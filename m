Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9E10740E67
	for <lists+linux-arch@lfdr.de>; Wed, 28 Jun 2023 12:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231937AbjF1KMP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Jun 2023 06:12:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:62004 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231737AbjF1KGj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 28 Jun 2023 06:06:39 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35S9lc3B009841;
        Wed, 28 Jun 2023 10:06:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=YBUEZfQnmnU49SY1UU2T/P4JNtQ0yZI9JbS9It2A1LQ=;
 b=EZFRa9Fsqag+RkWNsz1/pMzLTveZht4/OSQqDRn0vYlhUMlF8fTwJLcffGnpLQVi1dFz
 imIGzoelW6+TiIeDT4sVFiw6/sNIVsNDHvAFBqs9U29loHtqx93hEVaT1x5w1kLWxfar
 MwrzwaF4kzW5LxfIFWmJ5WsoXdlvYH1xWaB5ThD1Iu51f1+0RjrfNpIPs0aQNb4yA51U
 DtS1ZQtxMG6fIILVtQBwF2qK0oG9f6KftVbmL1IwnaC0w5X4BpGkOQhFryk80/8LERGt
 oh917u4eHQTWr9OdvMiWkzbQ/GZ9MbK//Qwons5XZGBHtTbltQl+Cnnd4esBqKeoiELU lg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rgjhngf3c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 10:06:08 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35S9mApi011202;
        Wed, 28 Jun 2023 10:06:07 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rgjhngf1a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 10:06:07 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35S8w64V015928;
        Wed, 28 Jun 2023 10:06:05 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3rdr452f5b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 10:06:05 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35SA631b16581256
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Jun 2023 10:06:03 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 078132005A;
        Wed, 28 Jun 2023 10:06:03 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2904E20065;
        Wed, 28 Jun 2023 10:06:02 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.171.41.43])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 28 Jun 2023 10:06:02 +0000 (GMT)
From:   Laurent Dufour <ldufour@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        tglx@linutronix.de, dave.hansen@linux.intel.com, mingo@redhat.com,
        bp@alien8.de
Subject: [PATCH v2 3/9] cpu/SMT: Store the current/max number of threads
Date:   Wed, 28 Jun 2023 12:05:52 +0200
Message-ID: <20230628100558.43482-4-ldufour@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230628100558.43482-1-ldufour@linux.ibm.com>
References: <20230628100558.43482-1-ldufour@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: UTty2ojiXL_JMmv8XpSHOYQhxNAOilIC
X-Proofpoint-GUID: O8pR_ZPFeNXL7ASN0yTeJ1yPz3qwF6Oo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_06,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 impostorscore=0 adultscore=0 mlxlogscore=967 bulkscore=0
 priorityscore=1501 phishscore=0 mlxscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2306280088
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Michael Ellerman <mpe@ellerman.id.au>

Some architectures allows partial SMT states at boot time, ie. when
not all SMT threads are brought online.

To support that the SMT code needs to know the maximum number of SMT
threads, and also the currently configured number.

The architecture code knows the max number of threads, so have the
architecture code pass that value to cpu_smt_set_num_threads(). Note that
although topology_max_smt_threads() exists, it is not configured early
enough to be used here. As architecture, like PowerPC, allows the threads
number to be set through the kernel command line, also pass that value.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
[ldufour: slightly reword the commit message]
[ldufour: rename cpu_smt_check_topology and add a num_threads argument]
Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>
---
 arch/x86/kernel/cpu/bugs.c |  3 ++-
 include/linux/cpu_smt.h    |  8 ++++++--
 kernel/cpu.c               | 21 ++++++++++++++++++++-
 3 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 182af64387d0..ed71ad385ea7 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -34,6 +34,7 @@
 #include <asm/hypervisor.h>
 #include <asm/tlbflush.h>
 #include <asm/cpu.h>
+#include <asm/smp.h>
 
 #include "cpu.h"
 
@@ -133,7 +134,7 @@ void __init check_bugs(void)
 	 * identify_boot_cpu() initialized SMT support information, let the
 	 * core code know.
 	 */
-	cpu_smt_check_topology();
+	cpu_smt_set_num_threads(smp_num_siblings, smp_num_siblings);
 
 	if (!IS_ENABLED(CONFIG_SMP)) {
 		pr_info("CPU: ");
diff --git a/include/linux/cpu_smt.h b/include/linux/cpu_smt.h
index 722c2e306fef..0c1664294b57 100644
--- a/include/linux/cpu_smt.h
+++ b/include/linux/cpu_smt.h
@@ -12,15 +12,19 @@ enum cpuhp_smt_control {
 
 #if defined(CONFIG_SMP) && defined(CONFIG_HOTPLUG_SMT)
 extern enum cpuhp_smt_control cpu_smt_control;
+extern unsigned int cpu_smt_num_threads;
 extern void cpu_smt_disable(bool force);
-extern void cpu_smt_check_topology(void);
+extern void cpu_smt_set_num_threads(unsigned int num_threads,
+				    unsigned int max_threads);
 extern bool cpu_smt_possible(void);
 extern int cpuhp_smt_enable(void);
 extern int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval);
 #else
 # define cpu_smt_control               (CPU_SMT_NOT_IMPLEMENTED)
+# define cpu_smt_num_threads 1
 static inline void cpu_smt_disable(bool force) { }
-static inline void cpu_smt_check_topology(void) { }
+static inline void cpu_smt_set_num_threads(unsigned int num_threads,
+					   unsigned int max_threads) { }
 static inline bool cpu_smt_possible(void) { return false; }
 static inline int cpuhp_smt_enable(void) { return 0; }
 static inline int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval) { return 0; }
diff --git a/kernel/cpu.c b/kernel/cpu.c
index c67049bb3fc8..edca8b7bd400 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -415,6 +415,8 @@ void __weak arch_smt_update(void) { }
 #ifdef CONFIG_HOTPLUG_SMT
 
 enum cpuhp_smt_control cpu_smt_control __read_mostly = CPU_SMT_ENABLED;
+static unsigned int cpu_smt_max_threads __ro_after_init;
+unsigned int cpu_smt_num_threads __read_mostly = UINT_MAX;
 
 void __init cpu_smt_disable(bool force)
 {
@@ -428,16 +430,33 @@ void __init cpu_smt_disable(bool force)
 		pr_info("SMT: disabled\n");
 		cpu_smt_control = CPU_SMT_DISABLED;
 	}
+	cpu_smt_num_threads = 1;
 }
 
 /*
  * The decision whether SMT is supported can only be done after the full
  * CPU identification. Called from architecture code.
  */
-void __init cpu_smt_check_topology(void)
+void __init cpu_smt_set_num_threads(unsigned int num_threads,
+				    unsigned int max_threads)
 {
+	WARN_ON(!num_threads || (num_threads > max_threads));
+
 	if (!topology_smt_supported())
 		cpu_smt_control = CPU_SMT_NOT_SUPPORTED;
+
+	cpu_smt_max_threads = max_threads;
+
+	/*
+	 * If SMT has been disabled via the kernel command line or SMT is
+	 * not supported, set cpu_smt_num_threads to 1 for consistency.
+	 * If enabled, take the architecture requested number of threads
+	 * to bring up into account.
+	 */
+	if (cpu_smt_control != CPU_SMT_ENABLED)
+		cpu_smt_num_threads = 1;
+	else if (num_threads < cpu_smt_num_threads)
+		cpu_smt_num_threads = num_threads;
 }
 
 static int __init smt_cmdline_disable(char *str)
-- 
2.41.0

