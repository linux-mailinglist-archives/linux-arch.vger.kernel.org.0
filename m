Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C035740E65
	for <lists+linux-arch@lfdr.de>; Wed, 28 Jun 2023 12:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbjF1KMM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Jun 2023 06:12:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:13318 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231626AbjF1KGe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 28 Jun 2023 06:06:34 -0400
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35S9vpFU020511;
        Wed, 28 Jun 2023 10:06:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=cI/uYcWliA0lDscgpvXhyRstakOSqS6a6NVTQTYILCg=;
 b=BXr907oOhK4D+4xhVXBWlCLH9IFuBCiDIz/Ly59UDUehbWxUDfIwMc7n1XlWQZDo82S+
 eXK0FRrfmmgy/jrJa6oyPdFkmOCQ3aBnEtT/Z0bhXNiHcV87ezNU+ctOexia9zj9W9VX
 7ESpZD0+HJOji3peAA/PMOpYzY/NL33tdl9VCzM5pCrZdN7xCos8+GLFrm//YSHJpVuT
 FcXeSeZltTj7wW+kDcSjMMWIrvaDUWXcTDdrFZRz6fcfvYPlYaXtEN2VleYGreN6BLlu
 ilTs82J3W4A6pDM4hGShFjWSZw3oEE+9g8G47ziwW5DSTQ6MK3/DHdYy0xgpSEwLuON8 Kg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rgjpq04y7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 10:06:13 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35S9x072025432;
        Wed, 28 Jun 2023 10:06:13 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rgjpq04wh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 10:06:13 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35S3gVgY010615;
        Wed, 28 Jun 2023 10:06:10 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma06fra.de.ibm.com (PPS) with ESMTPS id 3rdqre1vv1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 10:06:10 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35SA67VI8651390
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Jun 2023 10:06:07 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CB9AD2005A;
        Wed, 28 Jun 2023 10:06:07 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F183B20043;
        Wed, 28 Jun 2023 10:06:06 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.171.41.43])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 28 Jun 2023 10:06:06 +0000 (GMT)
From:   Laurent Dufour <ldufour@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        tglx@linutronix.de, dave.hansen@linux.intel.com, mingo@redhat.com,
        bp@alien8.de
Subject: [PATCH v2 8/9] powerpc: Add HOTPLUG_SMT support
Date:   Wed, 28 Jun 2023 12:05:57 +0200
Message-ID: <20230628100558.43482-9-ldufour@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230628100558.43482-1-ldufour@linux.ibm.com>
References: <20230628100558.43482-1-ldufour@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 6L5n7ua3NXeNNPuTIch9zHRZ5n9GxjdT
X-Proofpoint-ORIG-GUID: VX8Rls4XOBwFrSgy5zXRyqRmt6LpkJUY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_06,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 phishscore=0 impostorscore=0
 mlxscore=0 lowpriorityscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306280088
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

