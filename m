Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6563570FAFB
	for <lists+linux-arch@lfdr.de>; Wed, 24 May 2023 17:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237916AbjEXP6g (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 May 2023 11:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233929AbjEXP6W (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 May 2023 11:58:22 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58463E68;
        Wed, 24 May 2023 08:57:53 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QRG5p0dMtz4x4j;
        Thu, 25 May 2023 01:57:02 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1684943822;
        bh=w1ziCHRmZ+NzR3Oi+dKcHn23ZtE+UFXtsVrSaX2bNME=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ayIaxsmIIYzbycIL+fpi+mYdCAKOdeI6bQPTFPl1lx5fCzjWPed9GDBRnPhFQLZEW
         ooaF8fJc9GguiKuMXCVVZUvpMPvRGZ6r4HLZYRCi1DJGspid1sFCFN8fL0SfKBw3f2
         +gsTzvva6khPfXn4N+JJKvrp+PTFkoKLyTKgad1+31KHo3ZJ+XDpB+rxaCtPNsINUf
         0GK49Kick3SluL9xvAK6dIRcOGFu5Fv7gd+rtqqt7bEtufzYu8Bc7JfD5wsnL6tlAv
         +QmloK2YRDgQKYzL/CQ0A0hSrkMKVurnoLDZ2/DYYpXepHjwrrntQOFUG9gJvldYjW
         vO8R51bYiN0YQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     <linux-kernel@vger.kernel.org>
Cc:     <linuxppc-dev@lists.ozlabs.org>, <linux-arch@vger.kernel.org>,
        <ldufour@linux.ibm.com>, <tglx@linutronix.de>, bp@alien8.de,
        dave.hansen@linux.intel.com, mingo@redhat.com, x86@kernel.org
Subject: [PATCH 7/9] powerpc/pseries: Initialise CPU hotplug callbacks earlier
Date:   Thu, 25 May 2023 01:56:28 +1000
Message-Id: <20230524155630.794584-7-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230524155630.794584-1-mpe@ellerman.id.au>
References: <20230524155630.794584-1-mpe@ellerman.id.au>
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

As part of the generic HOTPLUG_SMT code, there is support for disabling
secondary SMT threads at boot time, by passing "nosmt" on the kernel
command line.

The way that is implemented is the secondary threads are brought partly
online, and then taken back offline again. That is done to support x86
CPUs needing certain initialisation done on all threads. However powerpc
has similar needs, see commit d70a54e2d085 ("powerpc/powernv: Ignore
smt-enabled on Power8 and later").

For that to work the powerpc CPU hotplug callbacks need to be registered
before secondary CPUs are brought online, otherwise __cpu_disable()
fails due to smp_ops->cpu_disable being NULL.

So split the basic initialisation into pseries_cpu_hotplug_init() which
can be called early from setup_arch(). The DLPAR related initialisation
can still be done later, because it needs to do allocations.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/platforms/pseries/hotplug-cpu.c | 22 ++++++++++++--------
 arch/powerpc/platforms/pseries/pseries.h     |  2 ++
 arch/powerpc/platforms/pseries/setup.c       |  2 ++
 3 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
index 1a3cb313976a..61fb7cb00880 100644
--- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
+++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
@@ -845,15 +845,9 @@ static struct notifier_block pseries_smp_nb = {
 	.notifier_call = pseries_smp_notifier,
 };
 
-static int __init pseries_cpu_hotplug_init(void)
+void __init pseries_cpu_hotplug_init(void)
 {
 	int qcss_tok;
-	unsigned int node;
-
-#ifdef CONFIG_ARCH_CPU_PROBE_RELEASE
-	ppc_md.cpu_probe = dlpar_cpu_probe;
-	ppc_md.cpu_release = dlpar_cpu_release;
-#endif /* CONFIG_ARCH_CPU_PROBE_RELEASE */
 
 	rtas_stop_self_token = rtas_function_token(RTAS_FN_STOP_SELF);
 	qcss_tok = rtas_function_token(RTAS_FN_QUERY_CPU_STOPPED_STATE);
@@ -862,12 +856,22 @@ static int __init pseries_cpu_hotplug_init(void)
 			qcss_tok == RTAS_UNKNOWN_SERVICE) {
 		printk(KERN_INFO "CPU Hotplug not supported by firmware "
 				"- disabling.\n");
-		return 0;
+		return;
 	}
 
 	smp_ops->cpu_offline_self = pseries_cpu_offline_self;
 	smp_ops->cpu_disable = pseries_cpu_disable;
 	smp_ops->cpu_die = pseries_cpu_die;
+}
+
+static int __init pseries_dlpar_init(void)
+{
+	unsigned int node;
+
+#ifdef CONFIG_ARCH_CPU_PROBE_RELEASE
+	ppc_md.cpu_probe = dlpar_cpu_probe;
+	ppc_md.cpu_release = dlpar_cpu_release;
+#endif /* CONFIG_ARCH_CPU_PROBE_RELEASE */
 
 	/* Processors can be added/removed only on LPAR */
 	if (firmware_has_feature(FW_FEATURE_LPAR)) {
@@ -886,4 +890,4 @@ static int __init pseries_cpu_hotplug_init(void)
 
 	return 0;
 }
-machine_arch_initcall(pseries, pseries_cpu_hotplug_init);
+machine_arch_initcall(pseries, pseries_dlpar_init);
diff --git a/arch/powerpc/platforms/pseries/pseries.h b/arch/powerpc/platforms/pseries/pseries.h
index f8bce40ebd0c..f8893ba46e83 100644
--- a/arch/powerpc/platforms/pseries/pseries.h
+++ b/arch/powerpc/platforms/pseries/pseries.h
@@ -75,11 +75,13 @@ static inline int dlpar_hp_pmem(struct pseries_hp_errorlog *hp_elog)
 
 #ifdef CONFIG_HOTPLUG_CPU
 int dlpar_cpu(struct pseries_hp_errorlog *hp_elog);
+void pseries_cpu_hotplug_init(void);
 #else
 static inline int dlpar_cpu(struct pseries_hp_errorlog *hp_elog)
 {
 	return -EOPNOTSUPP;
 }
+static inline void pseries_cpu_hotplug_init(void) { }
 #endif
 
 /* PCI root bridge prepare function override for pseries */
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index e2a57cfa6c83..41451b76c6e5 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -816,6 +816,8 @@ static void __init pSeries_setup_arch(void)
 	/* Discover PIC type and setup ppc_md accordingly */
 	smp_init_pseries();
 
+	// Setup CPU hotplug callbacks
+	pseries_cpu_hotplug_init();
 
 	if (radix_enabled() && !mmu_has_feature(MMU_FTR_GTSE))
 		if (!firmware_has_feature(FW_FEATURE_RPT_INVALIDATE))
-- 
2.40.1

