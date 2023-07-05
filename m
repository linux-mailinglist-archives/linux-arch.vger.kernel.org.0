Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95E86748763
	for <lists+linux-arch@lfdr.de>; Wed,  5 Jul 2023 17:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232583AbjGEPFB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Jul 2023 11:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232692AbjGEPE7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Jul 2023 11:04:59 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF8CFF;
        Wed,  5 Jul 2023 08:04:58 -0700 (PDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 365ElG3M025128;
        Wed, 5 Jul 2023 15:04:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=I5NJo0VWHfd/AtjXszRvWrnq5hPYTYi77kf9Y39lCDM=;
 b=bjIuNrg5fjJ8M1iURG2wXAKZXN6jMdpY191a97UK18Uq0bCo2CJtvV0e5bDzIv79P6hN
 bliXo1uRaQbZJcQqrK4Hhn0ymrdaNUSZKFZqxLcZFFfnOzLRG+qNsXq6io0amnLq3Y8f
 GFyAZCg/UTfARlsw1S68owchnrN4DVrt+5CG80XBFseGmyEiDExxX2lnDJjHuhjIOMc2
 Ckf0FYFLm1wct+FGkZIG15vzILAZPdH1DBaJr2Hz/uEbZfNZXhFd5P9eMrYT+x78mxvY
 cjX/GAvXKbjetvs8MfZgrk98IWxh1nTclJ+YKb/A1/qwWfEjtu2tbqa/JV2FNniVMKiu bQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rnak40kvf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Jul 2023 15:04:42 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 365EmEQW027796;
        Wed, 5 Jul 2023 15:04:42 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rnak40kua-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Jul 2023 15:04:42 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3650sFUo032566;
        Wed, 5 Jul 2023 14:51:50 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3rjbs4tn98-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Jul 2023 14:51:50 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 365EpmCG15991500
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 5 Jul 2023 14:51:48 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7D3772004B;
        Wed,  5 Jul 2023 14:51:48 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 61E1E20043;
        Wed,  5 Jul 2023 14:51:47 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.171.79.178])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  5 Jul 2023 14:51:47 +0000 (GMT)
From:   Laurent Dufour <ldufour@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        tglx@linutronix.de, dave.hansen@linux.intel.com, mingo@redhat.com,
        bp@alien8.de, rui.zhang@intel.com
Subject: [PATCH v4 02/10] cpu/SMT: Move SMT prototypes into cpu_smt.h
Date:   Wed,  5 Jul 2023 16:51:35 +0200
Message-ID: <20230705145143.40545-3-ldufour@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230705145143.40545-1-ldufour@linux.ibm.com>
References: <20230705145143.40545-1-ldufour@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 8w4OFb0D3RTobjUnLAGpaCHu8uF0bnKB
X-Proofpoint-GUID: aR52Uirc87Gq9s9ZAQWXvtp3Vif_bUIy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-05_06,2023-07-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 impostorscore=0 clxscore=1015 suspectscore=0 mlxscore=0
 adultscore=0 phishscore=0 priorityscore=1501 mlxlogscore=833 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

In order to export the cpuhp_smt_control enum as part of the interface
between generic and architecture code, the architecture code needs to
include asm/topology.h.

But that leads to circular header dependencies. So split the enum and
related declarations into a separate header.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
[ldufour: rewording the commit's description]
Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>
---
 arch/x86/include/asm/topology.h |  2 ++
 include/linux/cpu.h             | 25 +------------------------
 include/linux/cpu_smt.h         | 29 +++++++++++++++++++++++++++++
 kernel/cpu.c                    |  1 +
 4 files changed, 33 insertions(+), 24 deletions(-)
 create mode 100644 include/linux/cpu_smt.h

diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index caf41c4869a0..ae49ed4417d0 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -136,6 +136,8 @@ static inline int topology_max_smt_threads(void)
 	return __max_smt_threads;
 }
 
+#include <linux/cpu_smt.h>
+
 int topology_update_package_map(unsigned int apicid, unsigned int cpu);
 int topology_update_die_map(unsigned int dieid, unsigned int cpu);
 int topology_phys_to_logical_pkg(unsigned int pkg);
diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index 6e6e57ec69e8..6b326a9e8191 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -18,6 +18,7 @@
 #include <linux/compiler.h>
 #include <linux/cpumask.h>
 #include <linux/cpuhotplug.h>
+#include <linux/cpu_smt.h>
 
 struct device;
 struct device_node;
@@ -204,30 +205,6 @@ void cpuhp_report_idle_dead(void);
 static inline void cpuhp_report_idle_dead(void) { }
 #endif /* #ifdef CONFIG_HOTPLUG_CPU */
 
-enum cpuhp_smt_control {
-	CPU_SMT_ENABLED,
-	CPU_SMT_DISABLED,
-	CPU_SMT_FORCE_DISABLED,
-	CPU_SMT_NOT_SUPPORTED,
-	CPU_SMT_NOT_IMPLEMENTED,
-};
-
-#if defined(CONFIG_SMP) && defined(CONFIG_HOTPLUG_SMT)
-extern enum cpuhp_smt_control cpu_smt_control;
-extern void cpu_smt_disable(bool force);
-extern void cpu_smt_check_topology(void);
-extern bool cpu_smt_possible(void);
-extern int cpuhp_smt_enable(void);
-extern int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval);
-#else
-# define cpu_smt_control		(CPU_SMT_NOT_IMPLEMENTED)
-static inline void cpu_smt_disable(bool force) { }
-static inline void cpu_smt_check_topology(void) { }
-static inline bool cpu_smt_possible(void) { return false; }
-static inline int cpuhp_smt_enable(void) { return 0; }
-static inline int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval) { return 0; }
-#endif
-
 extern bool cpu_mitigations_off(void);
 extern bool cpu_mitigations_auto_nosmt(void);
 
diff --git a/include/linux/cpu_smt.h b/include/linux/cpu_smt.h
new file mode 100644
index 000000000000..722c2e306fef
--- /dev/null
+++ b/include/linux/cpu_smt.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_CPU_SMT_H_
+#define _LINUX_CPU_SMT_H_
+
+enum cpuhp_smt_control {
+	CPU_SMT_ENABLED,
+	CPU_SMT_DISABLED,
+	CPU_SMT_FORCE_DISABLED,
+	CPU_SMT_NOT_SUPPORTED,
+	CPU_SMT_NOT_IMPLEMENTED,
+};
+
+#if defined(CONFIG_SMP) && defined(CONFIG_HOTPLUG_SMT)
+extern enum cpuhp_smt_control cpu_smt_control;
+extern void cpu_smt_disable(bool force);
+extern void cpu_smt_check_topology(void);
+extern bool cpu_smt_possible(void);
+extern int cpuhp_smt_enable(void);
+extern int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval);
+#else
+# define cpu_smt_control               (CPU_SMT_NOT_IMPLEMENTED)
+static inline void cpu_smt_disable(bool force) { }
+static inline void cpu_smt_check_topology(void) { }
+static inline bool cpu_smt_possible(void) { return false; }
+static inline int cpuhp_smt_enable(void) { return 0; }
+static inline int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval) { return 0; }
+#endif
+
+#endif /* _LINUX_CPU_SMT_H_ */
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 03309f2f35a4..e02204c4675a 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -592,6 +592,7 @@ static void lockdep_release_cpus_lock(void)
 void __weak arch_smt_update(void) { }
 
 #ifdef CONFIG_HOTPLUG_SMT
+
 enum cpuhp_smt_control cpu_smt_control __read_mostly = CPU_SMT_ENABLED;
 
 void __init cpu_smt_disable(bool force)
-- 
2.41.0

