Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA2E174286B
	for <lists+linux-arch@lfdr.de>; Thu, 29 Jun 2023 16:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbjF2OcS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 29 Jun 2023 10:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbjF2OcR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 29 Jun 2023 10:32:17 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B83B2D56;
        Thu, 29 Jun 2023 07:32:15 -0700 (PDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35TERpoM012296;
        Thu, 29 Jun 2023 14:31:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=41nfk7hVKk/WvuSxvNTVdQGB0w7rWokALwy7vmRvjrs=;
 b=R714lsXmp0Hyb9p2ypbY+7/AD7Qnn2bHTPWr7LiHcFJXiCz/UaqyiPdFbzBcym1TxHZt
 jZgjIHTv2LFn3LXPOOs7bLqkqk8KJEENe6fY55ETNJm4eU9AkU+USfs/n8iFwijj+Hoh
 5h7LwylVvTeIGaNYxNpvHjiCub/9owljzbFGWPYXHfRVnhPtYbGVIrNQE+BzWBqcrO8W
 Z6rcQ21LkqWWyBeUe7XF/efcs2HCjO2dvlL0X8HOryeR2t7qe+RQzZACBZ8wQvOnJFzt
 2oggH+nmAZVhTUK9QQf30TzXoN9jL+i1XXYDGLDGs2qMv5kEFrvMLLv0HZjsY0/n28YK Ig== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rhbr802sm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Jun 2023 14:31:57 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35TESZSY014916;
        Thu, 29 Jun 2023 14:31:57 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rhbr802qy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Jun 2023 14:31:57 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35TCijaW019529;
        Thu, 29 Jun 2023 14:31:54 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma02fra.de.ibm.com (PPS) with ESMTPS id 3rdr452hcs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Jun 2023 14:31:54 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35TEVq5W57344464
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Jun 2023 14:31:52 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0B19420040;
        Thu, 29 Jun 2023 14:31:52 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 907082004B;
        Thu, 29 Jun 2023 14:31:51 +0000 (GMT)
Received: from pomme.tlslab.ibm.com (unknown [9.101.4.33])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 29 Jun 2023 14:31:51 +0000 (GMT)
From:   Laurent Dufour <ldufour@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        tglx@linutronix.de, dave.hansen@linux.intel.com, mingo@redhat.com,
        bp@alien8.de
Subject: [PATCH v3 1/9] cpu/SMT: Move SMT prototypes into cpu_smt.h
Date:   Thu, 29 Jun 2023 16:31:41 +0200
Message-ID: <20230629143149.79073-2-ldufour@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230629143149.79073-1-ldufour@linux.ibm.com>
References: <20230629143149.79073-1-ldufour@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: qok6Iwls5hMQVnLlIb9in4W0qHiQy2Cz
X-Proofpoint-ORIG-GUID: 3Rw_No3n5AygzyJQ4aUyH0Jzi8w-aASt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-29_03,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 impostorscore=0
 spamscore=0 adultscore=0 mlxlogscore=811 clxscore=1015 mlxscore=0
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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
index 458c891a8273..66927a59e822 100644
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
index 8582a7142623..40548f3c201c 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -18,6 +18,7 @@
 #include <linux/compiler.h>
 #include <linux/cpumask.h>
 #include <linux/cpuhotplug.h>
+#include <linux/cpu_smt.h>
 
 struct device;
 struct device_node;
@@ -202,30 +203,6 @@ void cpuhp_report_idle_dead(void);
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
index f4a2c5845bcb..237394e0574a 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -413,6 +413,7 @@ static void lockdep_release_cpus_lock(void)
 void __weak arch_smt_update(void) { }
 
 #ifdef CONFIG_HOTPLUG_SMT
+
 enum cpuhp_smt_control cpu_smt_control __read_mostly = CPU_SMT_ENABLED;
 
 void __init cpu_smt_disable(bool force)
-- 
2.41.0

