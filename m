Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D23270FAF2
	for <lists+linux-arch@lfdr.de>; Wed, 24 May 2023 17:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237758AbjEXP5x (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 May 2023 11:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237587AbjEXP5s (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 May 2023 11:57:48 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2BC110D1;
        Wed, 24 May 2023 08:57:17 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QRG5k12s0z4wgq;
        Thu, 25 May 2023 01:56:58 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1684943819;
        bh=pJxluW7i0bZ3DMPSPZr/X0SsGSnZoomyK/1WDBYirpE=;
        h=From:To:Cc:Subject:Date:From;
        b=T9p1VcABYWBTQ5sEc6m+ml3BQKxZRLhFHtKOvTMD2sZ7pKn6WUaJApRMIy9EwE1yT
         h5zsAxLsDoUdUvFNwhffKiLqX9Fhke4u8jJF63LdgQbv1ZL9yTejQn2+RZXylwMsGE
         mfl4e1Jl9+k9AhM4MEAkU52z1O6CI1z+6slcx8hvc0btqT+YZYej7QK5+/AjPtVeNE
         0FaKPhHZ7DTWG8ZGGOCpjUxnZxe8KceRraf/HWa9dsgWEfDSxea0dqf/yPFB+6gF/s
         aMENcXu50+TasQ7jCJoYfoRkWq4zRP+VVARKRGUOKy3xwxo0KqhRC/R3ONuzfDAPBs
         sfe9tz7TOpg3g==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     <linux-kernel@vger.kernel.org>
Cc:     <linuxppc-dev@lists.ozlabs.org>, <linux-arch@vger.kernel.org>,
        <ldufour@linux.ibm.com>, <tglx@linutronix.de>, bp@alien8.de,
        dave.hansen@linux.intel.com, mingo@redhat.com, x86@kernel.org
Subject: [PATCH 1/9] cpu/SMT: Move SMT prototypes into cpu_smt.h
Date:   Thu, 25 May 2023 01:56:22 +1000
Message-Id: <20230524155630.794584-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

A subsequent patch would like to use the cpuhp_smt_control enum as part
of the interface between generic and arch code.

Currently that leads to circular header dependencies. So split the enum
and related declarations into a separate header.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/x86/include/asm/topology.h |  2 ++
 include/linux/cpu.h             | 25 +------------------------
 include/linux/cpu_smt.h         | 29 +++++++++++++++++++++++++++++
 3 files changed, 32 insertions(+), 24 deletions(-)
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
index 000000000000..17e105b52d85
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
+# define cpu_smt_control		(CPU_SMT_NOT_IMPLEMENTED)
+static inline void cpu_smt_disable(bool force) { }
+static inline void cpu_smt_check_topology(void) { }
+static inline bool cpu_smt_possible(void) { return false; }
+static inline int cpuhp_smt_enable(void) { return 0; }
+static inline int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval) { return 0; }
+#endif
+
+#endif /* _LINUX_CPU_SMT_H_ */
-- 
2.40.1

