Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 333B7742871
	for <lists+linux-arch@lfdr.de>; Thu, 29 Jun 2023 16:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232384AbjF2Oc3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 29 Jun 2023 10:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232377AbjF2OcU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 29 Jun 2023 10:32:20 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78ED7358A;
        Thu, 29 Jun 2023 07:32:18 -0700 (PDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35TEMMGo032120;
        Thu, 29 Jun 2023 14:32:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=cI/uYcWliA0lDscgpvXhyRstakOSqS6a6NVTQTYILCg=;
 b=IxGquT6RRxD4N55SgfYNPCcFJMHtRGdDyJq74Rl72ckdNm0/cws51YdrNP+tGpzA2+at
 vbUmBvR6SXmqMK9sYvvmxlR5ld8uiBtiJgP4tO46IHnjEJ3zi7jZ8BHAuU4WGEj0lcqK
 QSMaz1fRQgdMGKrawERIYonC4KS+HtvujdsY+4z497k1fabsBT+/+P8Xt4e+er79l96+
 G7epCCvOJIlcpCQsr5KaRGEXnhEQ2QaXw5dP+KS+/x5nyuDiSCxk6awGm2kfXOFWyDxp
 8rjmPgfjy0/rF+hgZkq1Gv7AGeQsb6pPvaR7RZsyCsKVnoGH1LjjH7LdAAOygCNvgt1i gw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rhbnf08er-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Jun 2023 14:32:01 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35TENGZF003007;
        Thu, 29 Jun 2023 14:32:00 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rhbnf08cv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Jun 2023 14:32:00 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35T9UewR018753;
        Thu, 29 Jun 2023 14:31:58 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3rdr453d0q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Jun 2023 14:31:57 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35TEVtnN17892066
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Jun 2023 14:31:55 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AC12B20040;
        Thu, 29 Jun 2023 14:31:55 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3E5EC2004D;
        Thu, 29 Jun 2023 14:31:55 +0000 (GMT)
Received: from pomme.tlslab.ibm.com (unknown [9.101.4.33])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 29 Jun 2023 14:31:55 +0000 (GMT)
From:   Laurent Dufour <ldufour@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        tglx@linutronix.de, dave.hansen@linux.intel.com, mingo@redhat.com,
        bp@alien8.de
Subject: [PATCH v3 8/9] powerpc: Add HOTPLUG_SMT support
Date:   Thu, 29 Jun 2023 16:31:48 +0200
Message-ID: <20230629143149.79073-9-ldufour@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230629143149.79073-1-ldufour@linux.ibm.com>
References: <20230629143149.79073-1-ldufour@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: z4BokEob9LS0Xm8Avyd2rIR07vjWoMYt
X-Proofpoint-ORIG-GUID: 1A9IO0zUt8l8-92zr0N5NGVxwbIr2k-y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-29_03,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 priorityscore=1501 malwarescore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306290131
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Michael Ellerman <mpe@ellerman.id.au>

Add support for HOTPLUG_SMT, which enables the generic sysfs SMT support
files in /sys/devices/system/cpu/smt, as well as the "nosmt" boot
parameter.

Implement the recently added hooks to allow partial SMT states, allow
any number of threads per core.

Tie the config symbol to HOTPLUG_CPU, which enables it on the major
platforms that support SMT. If there are other platforms that want the
SMT support that can be tweaked in future.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
[ldufour: pass current SMT level to cpu_smt_set_num_threads]
[ldufour: remove topology_smt_supported]
[ldufour: remove topology_smt_threads_supported]
[ldufour: select CONFIG_SMT_NUM_THREADS_DYNAMIC]
[ldufour: update kernel-parameters.txt]
Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  4 ++--
 arch/powerpc/Kconfig                            |  2 ++
 arch/powerpc/include/asm/topology.h             | 15 +++++++++++++++
 arch/powerpc/kernel/smp.c                       |  8 +++++++-
 4 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 9e5bab29685f..5efb6c73a928 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3838,10 +3838,10 @@
 	nosmp		[SMP] Tells an SMP kernel to act as a UP kernel,
 			and disable the IO APIC.  legacy for "maxcpus=0".
 
-	nosmt		[KNL,S390] Disable symmetric multithreading (SMT).
+	nosmt		[KNL,S390,PPC] Disable symmetric multithreading (SMT).
 			Equivalent to smt=1.
 
-			[KNL,X86] Disable symmetric multithreading (SMT).
+			[KNL,X86,PPC] Disable symmetric multithreading (SMT).
 			nosmt=force: Force disable SMT, cannot be undone
 				     via the sysfs control file.
 
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 8b955bc7b59f..bacabc3d7f0c 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -273,6 +273,8 @@ config PPC
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_VIRT_CPU_ACCOUNTING
 	select HAVE_VIRT_CPU_ACCOUNTING_GEN
+	select HOTPLUG_SMT			if HOTPLUG_CPU
+	select SMT_NUM_THREADS_DYNAMIC
 	select HUGETLB_PAGE_SIZE_VARIABLE	if PPC_BOOK3S_64 && HUGETLB_PAGE
 	select IOMMU_HELPER			if PPC64
 	select IRQ_DOMAIN
diff --git a/arch/powerpc/include/asm/topology.h b/arch/powerpc/include/asm/topology.h
index 8a4d4f4d9749..f4e6f2dd04b7 100644
--- a/arch/powerpc/include/asm/topology.h
+++ b/arch/powerpc/include/asm/topology.h
@@ -143,5 +143,20 @@ static inline int cpu_to_coregroup_id(int cpu)
 #endif
 #endif
 
+#ifdef CONFIG_HOTPLUG_SMT
+#include <linux/cpu_smt.h>
+#include <asm/cputhreads.h>
+
+static inline bool topology_is_primary_thread(unsigned int cpu)
+{
+	return cpu == cpu_first_thread_sibling(cpu);
+}
+
+static inline bool topology_smt_thread_allowed(unsigned int cpu)
+{
+	return cpu_thread_in_core(cpu) < cpu_smt_num_threads;
+}
+#endif
+
 #endif /* __KERNEL__ */
 #endif	/* _ASM_POWERPC_TOPOLOGY_H */
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 406e6d0ffae3..eb539325dff8 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -1087,7 +1087,7 @@ static int __init init_big_cores(void)
 
 void __init smp_prepare_cpus(unsigned int max_cpus)
 {
-	unsigned int cpu;
+	unsigned int cpu, num_threads;
 
 	DBG("smp_prepare_cpus\n");
 
@@ -1154,6 +1154,12 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 
 	if (smp_ops && smp_ops->probe)
 		smp_ops->probe();
+
+	// Initalise the generic SMT topology support
+	num_threads = 1;
+	if (smt_enabled_at_boot)
+		num_threads = smt_enabled_at_boot;
+	cpu_smt_set_num_threads(num_threads, threads_per_core);
 }
 
 void smp_prepare_boot_cpu(void)
-- 
2.41.0

