version 1.0
#WORKFLOW DEFINITION
workflow Hello_GATK {
    input {
        File ref_fasta
        File ref_fasta_index
        File ref_dict
        File input_bam
        File input_bai
        String sample_name
        String gotc_docker = "broadinstitute/gatk:4.3.0.0"
    }

    #call gatk function
    call HaplotypeCaller_GVCF{
        input:
            ref_fasta = ref_fasta,
            ref_fasta_index = ref_fasta_index,
            ref_dict = ref_dict,
            input_bam = input_bam,
            sample_name = sample_name,
            docker_image = gotc_docker,
            input_bai = input_bai
    }
    #Outputs gvcf
    output {
        File output_gvcf = HaplotypeCaller_GVCF.output_gvcf
    }

}

task HaplotypeCaller_GVCF {
    input {
        String java_opt 

        File ref_fasta
        File ref_fasta_index
        File ref_dict
        File input_bam
        File input_bai

        String docker_image
        Int mem_size = 20
        Int cpu_size = 8
        Int disk_size = 50
        String sample_name
    

    }

    command {
        gatk --java-options ${java_opt} HaplotypeCaller \
            -R ${ref_fasta} \
            -I ${input_bam} \
            -O ${sample_name}.gvcf \
            -ERC GVCF
    }
    
    runtime {
        docker: docker_image
        cpu: cpu_size
        memory: mem_size + " GB"
        disk: disk_size + " GB" 
    }

    output {
        File output_gvcf = "${sample_name}.gvcf"
    }

    
}