Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68D33743E95
	for <lists+linux-arch@lfdr.de>; Fri, 30 Jun 2023 17:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232632AbjF3PUT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 30 Jun 2023 11:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232622AbjF3PT5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 30 Jun 2023 11:19:57 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989084691;
        Fri, 30 Jun 2023 08:19:34 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35UFH8pY020880;
        Fri, 30 Jun 2023 15:19:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Lycu8WDBwobi6T7/8g4368xPmrlcfRa0eBuPZnpI8Lc=;
 b=DpPNbNxVw0IHVufCOsCONzAILjxWSfiKsGs3wcXObsxPxZDO9Hzv4iMgsELKqSmlYlyV
 wGicDg/BK88qdVIFEasZPM7LHrF9bwFs/GciaVWD8sa+yQ8vqNGLNNl47hkCEwfLBFV5
 m0xX8NQsutw2QN3kneXublAQBJdwPeL0z1HrTJUIbR9PM/gPJyQUglGFX5Kv87c+B5xb
 hhQswlbGYOo5H2OXRMois8tALSZL5TZhkK+pH7aGQJyAEptBdwAKp6jmk5AgvqBsLOlI
 EIu4JWwS/n3s1r9ZFP8os/9BUH41MhxloHQHB+N1uwiSrT9me30Z4rOYQsklwNEkADKI 6Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rj1j801he-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Jun 2023 15:19:18 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35UFIxvx027941;
        Fri, 30 Jun 2023 15:19:18 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rj1j801gh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Jun 2023 15:19:18 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35U685W0029434;
        Fri, 30 Jun 2023 15:19:15 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3rdqre47h7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Jun 2023 15:19:15 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35UFJDQb4129508
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Jun 2023 15:19:13 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 667932004B;
        Fri, 30 Jun 2023 15:19:13 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B145920040;
        Fri, 30 Jun 2023 15:19:12 +0000 (GMT)
Received: from [9.171.36.134] (unknown [9.171.36.134])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 30 Jun 2023 15:19:12 +0000 (GMT)
Message-ID: <b62c80ba-e4eb-b694-7e45-082bc8ef7f2c@linux.ibm.com>
Date:   Fri, 30 Jun 2023 17:19:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v3 8/9] powerpc: Add HOTPLUG_SMT support
Content-Language: en-US
From:   Laurent Dufour <ldufour@linux.ibm.com>
To:     mpe@ellerman.id.au
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, tglx@linutronix.de,
        dave.hansen@linux.intel.com, mingo@redhat.com, bp@alien8.de
References: <20230629143149.79073-1-ldufour@linux.ibm.com>
 <20230629143149.79073-9-ldufour@linux.ibm.com>
In-Reply-To: <20230629143149.79073-9-ldufour@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Zjd6rE1HF1V40UiYmn1CrHGHg_OBorTP
X-Proofpoint-GUID: aFy_dg3U8mDXHnQe-tuAt7RuMPC3aWUd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-30_05,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 malwarescore=0 spamscore=0 bulkscore=0 clxscore=1015
 adultscore=0 mlxscore=0 lowpriorityscore=0 mlxlogscore=999 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306300127
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Michael,

Le 29/06/2023 à 16:31, Laurent Dufour a écrit :
> From: Michael Ellerman <mpe@ellerman.id.au>
> 
> Add support for HOTPLUG_SMT, which enables the generic sysfs SMT support
> files in /sys/devices/system/cpu/smt, as well as the "nosmt" boot
> parameter.
> 
> Implement the recently added hooks to allow partial SMT states, allow
> any number of threads per core.
> 
> Tie the config symbol to HOTPLUG_CPU, which enables it on the major
> platforms that support SMT. If there are other platforms that want the
> SMT support that can be tweaked in future.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> [ldufour: pass current SMT level to cpu_smt_set_num_threads]
> [ldufour: remove topology_smt_supported]
> [ldufour: remove topology_smt_threads_supported]
> [ldufour: select CONFIG_SMT_NUM_THREADS_DYNAMIC]
> [ldufour: update kernel-parameters.txt]
> Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>
> ---
>   Documentation/admin-guide/kernel-parameters.txt |  4 ++--
>   arch/powerpc/Kconfig                            |  2 ++
>   arch/powerpc/include/asm/topology.h             | 15 +++++++++++++++
>   arch/powerpc/kernel/smp.c                       |  8 +++++++-
>   4 files changed, 26 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 9e5bab29685f..5efb6c73a928 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3838,10 +3838,10 @@
>   	nosmp		[SMP] Tells an SMP kernel to act as a UP kernel,
>   			and disable the IO APIC.  legacy for "maxcpus=0".
>   
> -	nosmt		[KNL,S390] Disable symmetric multithreading (SMT).
> +	nosmt		[KNL,S390,PPC] Disable symmetric multithreading (SMT).
>   			Equivalent to smt=1.
>   
> -			[KNL,X86] Disable symmetric multithreading (SMT).
> +			[KNL,X86,PPC] Disable symmetric multithreading (SMT).
>   			nosmt=force: Force disable SMT, cannot be undone
>   				     via the sysfs control file.
>   
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 8b955bc7b59f..bacabc3d7f0c 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -273,6 +273,8 @@ config PPC
>   	select HAVE_SYSCALL_TRACEPOINTS
>   	select HAVE_VIRT_CPU_ACCOUNTING
>   	select HAVE_VIRT_CPU_ACCOUNTING_GEN
> +	select HOTPLUG_SMT			if HOTPLUG_CPU
> +	select SMT_NUM_THREADS_DYNAMIC

I missed that this list should be kept sorted alphabetically.
Could you fix that when applying the series, or should I send a new 
version ?

Thanks,
Laurent.

>   	select HUGETLB_PAGE_SIZE_VARIABLE	if PPC_BOOK3S_64 && HUGETLB_PAGE
>   	select IOMMU_HELPER			if PPC64
>   	select IRQ_DOMAIN
> diff --git a/arch/powerpc/include/asm/topology.h b/arch/powerpc/include/asm/topology.h
> index 8a4d4f4d9749..f4e6f2dd04b7 100644
> --- a/arch/powerpc/include/asm/topology.h
> +++ b/arch/powerpc/include/asm/topology.h
> @@ -143,5 +143,20 @@ static inline int cpu_to_coregroup_id(int cpu)
>   #endif
>   #endif
>   
> +#ifdef CONFIG_HOTPLUG_SMT
> +#include <linux/cpu_smt.h>
> +#include <asm/cputhreads.h>
> +
> +static inline bool topology_is_primary_thread(unsigned int cpu)
> +{
> +	return cpu == cpu_first_thread_sibling(cpu);
> +}
> +
> +static inline bool topology_smt_thread_allowed(unsigned int cpu)
> +{
> +	return cpu_thread_in_core(cpu) < cpu_smt_num_threads;
> +}
> +#endif
> +
>   #endif /* __KERNEL__ */
>   #endif	/* _ASM_POWERPC_TOPOLOGY_H */
> diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
> index 406e6d0ffae3..eb539325dff8 100644
> --- a/arch/powerpc/kernel/smp.c
> +++ b/arch/powerpc/kernel/smp.c
> @@ -1087,7 +1087,7 @@ static int __init init_big_cores(void)
>   
>   void __init smp_prepare_cpus(unsigned int max_cpus)
>   {
> -	unsigned int cpu;
> +	unsigned int cpu, num_threads;
>   
>   	DBG("smp_prepare_cpus\n");
>   
> @@ -1154,6 +1154,12 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
>   
>   	if (smp_ops && smp_ops->probe)
>   		smp_ops->probe();
> +
> +	// Initalise the generic SMT topology support
> +	num_threads = 1;
> +	if (smt_enabled_at_boot)
> +		num_threads = smt_enabled_at_boot;
> +	cpu_smt_set_num_threads(num_threads, threads_per_core);
>   }
>   
>   void smp_prepare_boot_cpu(void)
