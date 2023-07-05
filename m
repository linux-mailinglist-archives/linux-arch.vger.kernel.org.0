Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 339297486DB
	for <lists+linux-arch@lfdr.de>; Wed,  5 Jul 2023 16:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232748AbjGEOwU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Jul 2023 10:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232731AbjGEOwP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Jul 2023 10:52:15 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C80170B;
        Wed,  5 Jul 2023 07:52:13 -0700 (PDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 365Eklta005724;
        Wed, 5 Jul 2023 14:51:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=ICUKBZmkuAMtPXeSJmZSdFrU+2dxXTnvFaZImteBHdY=;
 b=sjyHfxW2bkZ1f6LaMh/yaINNiuO+8U04kqLr5YW/STD2ATqYmuq8o4H0s81RHGuxrp4G
 MAdE8CeeNZMbAs3XFJRJ8+ImseGmkL94Y8x5b8lxB5/Bzabul0wo2Orp/Dfyg3a1zlOS
 1UQ/HVkf3GwRUDOmtA7qje6GIJQnLVqAPp8lQYLxe4hvIRT9u0Msd+kLdnDdDMZOAAng
 /aN9yZN2gVJGpXgsloUf8tiugVeZjrKPN1JYw1Pu8ov8nxJNPCcTsfN24HrgF+zg/QcO
 TY/f84WomqikChbg3EH1gQK046lVdWIa4uLwv46b55D03Q9Z9wPPkMHbO+tp0OrZTGSC lQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rnak28616-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Jul 2023 14:51:56 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 365ElljO010524;
        Wed, 5 Jul 2023 14:51:55 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rnak285yt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Jul 2023 14:51:55 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3656KdpP000398;
        Wed, 5 Jul 2023 14:51:53 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma02fra.de.ibm.com (PPS) with ESMTPS id 3rjbs4sy2y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Jul 2023 14:51:53 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 365Epp3863177180
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 5 Jul 2023 14:51:51 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E283220043;
        Wed,  5 Jul 2023 14:51:50 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DCF1120040;
        Wed,  5 Jul 2023 14:51:49 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.171.79.178])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  5 Jul 2023 14:51:49 +0000 (GMT)
From:   Laurent Dufour <ldufour@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        tglx@linutronix.de, dave.hansen@linux.intel.com, mingo@redhat.com,
        bp@alien8.de, rui.zhang@intel.com
Subject: [PATCH v4 04/10] cpu/SMT: Store the current/max number of threads
Date:   Wed,  5 Jul 2023 16:51:37 +0200
Message-ID: <20230705145143.40545-5-ldufour@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230705145143.40545-1-ldufour@linux.ibm.com>
References: <20230705145143.40545-1-ldufour@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Cdv_MKFIyGHawEVHyeSZCbcF0MKLBNE5
X-Proofpoint-ORIG-GUID: ytTn16AvzTKlOazDG5THA90psjdGnKAt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-05_06,2023-07-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0 mlxscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 mlxlogscore=965 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307050131
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

Some architectures allow partial SMT states at boot time, ie. when
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
 arch/x86/kernel/cpu/common.c |  2 +-
 include/linux/cpu_smt.h      |  8 ++++++--
 kernel/cpu.c                 | 21 ++++++++++++++++++++-
 3 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 52683fddafaf..12a48a85da3d 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2317,7 +2317,7 @@ void __init arch_cpu_finalize_init(void)
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
index b6fe170c93e9..d7dd535cb5b5 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -594,6 +594,8 @@ void __weak arch_smt_update(void) { }
 #ifdef CONFIG_HOTPLUG_SMT
 
 enum cpuhp_smt_control cpu_smt_control __read_mostly = CPU_SMT_ENABLED;
+static unsigned int cpu_smt_max_threads __ro_after_init;
+unsigned int cpu_smt_num_threads __read_mostly = UINT_MAX;
 
 void __init cpu_smt_disable(bool force)
 {
@@ -607,16 +609,33 @@ void __init cpu_smt_disable(bool force)
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

