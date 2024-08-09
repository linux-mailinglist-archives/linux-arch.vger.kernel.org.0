Return-Path: <linux-arch+bounces-6139-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B7B994D740
	for <lists+linux-arch@lfdr.de>; Fri,  9 Aug 2024 21:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FC44283331
	for <lists+linux-arch@lfdr.de>; Fri,  9 Aug 2024 19:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E6016A934;
	Fri,  9 Aug 2024 19:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="FlUrNbVu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mL4aVRj2"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309B0168491;
	Fri,  9 Aug 2024 19:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723231513; cv=none; b=gj/vQrt+RHhpvur5WEtsk9OxGlOAVf3a/usAG595+uezHgsrd73ctwuY61neX4rsw86jNAFY1pnjuABu5YtU2mLMdYIvd9UhtxpYBhQ34bLz95gKtgrjNFCtzSIjUS5ZJDUCioyReUlxeNGEC3W+8gZHTVHsDAXqOt/V2BbNvQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723231513; c=relaxed/simple;
	bh=25PGnrDbozNqXeo66FAaZeG/EjrxdTBJIrhq5W4w0Zg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jc5V8EA+PElzcICeqQuPpIWH8ZIBA+O7jatsnL+mW2PFR3jutCtaIHs5d5Kjp2XJp7qbY4LlMPZTLuMmHQiAkpxaacF7YjZ2Cgl9t/TpdN7cmXlKnyc5k3kBQc3rOUZtAF1hP7qzJ5VxqXfKRMSANTg3RJcqjqblCmXpIkk6XGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=FlUrNbVu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mL4aVRj2; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id 8B2421388193;
	Fri,  9 Aug 2024 15:25:11 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 09 Aug 2024 15:25:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1723231511;
	 x=1723317911; bh=91Ntn8+8S3tkwtkpXtQo+UUnbH7tPRABNLmEHtSRkko=; b=
	FlUrNbVuM7/wrsS0RQ6onehyaerYTFf/sTAMkFpo4g5NWPzZfApMyNWYgQ76wnOv
	jHYd0TqAMB1gDnbm2Qnlurdp5ugq80GbC6yMvbCCviXixFMCkDpfcN5zG6d3Crew
	2lcpcYtwzS+hyYizziW1cqUjxMH1zxKirFOWeKf1rnN9HZ0vTniW6Fwb9Ej8lK3G
	hrQiCWgGXcvhOuF+M3MgUby0UDG+HGfEaIXSEBB6jvj0KJwKm+IMbhH5Zq8qHXjL
	bLNRDWWqk6RLxBfBRJO/9Wr463MY/AE0ZMRygxel6fnlaiuydzf3QxUq5c1R5fiq
	H3+DAyDrbqtnxzxY398aSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1723231511; x=
	1723317911; bh=91Ntn8+8S3tkwtkpXtQo+UUnbH7tPRABNLmEHtSRkko=; b=m
	L4aVRj20J54gh//0E554dy1KLgUuYcY50hSwvxQI0l2VhrWOn+ehY3hkoh7oPo3I
	dBYls/iwIeGuPRlg66Oko0O+qQXbpg8dihFgotJA/AhJkOJbEpAki5OfTM9mq2fm
	/8hJbv1CrMg/xNAx3q8NFJOY8ve1shSkXRRfTF60EK+2pBpdiMwjl0mV7q2YCr8D
	K3EJUIgUV9rkvuOckypAAmKUiGIy4uloHuRNsIw2Fgoq5PiIexDDAQiHnuMb3ZJu
	qoPMaX91CDQkUFcEek931VDi1KtMy1zp6jAlOmrpSPXx66Hm2fcg17efuDKpxf+o
	4iQaFdWGOYXbBqqy1VH4g==
X-ME-Sender: <xms:F222Zrgx1ZflWBB_I4ufWuAjMZcTutXnzZAnGup8IxBSJG8xPrwrsA>
    <xme:F222ZoCXB95yMtr2YqoYPZZtnXHDeUnQDEK6XesEVWKMvqkMqM7Tx_rWAhXz-CbDH
    qIW7lt7gsCHKm3NxWU>
X-ME-Received: <xmr:F222ZrHZuPwG7XqMX6qWeflqhB1nJGW-aMS3oaobbso9fL5Dl9s13_Op-bi4s59KzA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrleeggddufeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhi
    hgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffek
    gedugefhtdduudeghfeuveegffegudekjeelnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdr
    tghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    eprghrnhgusegrrhhnuggsrdguvgdprhgtphhtthhopehjihgrgihunhdrhigrnhhgsehf
    lhihghhorghtrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhssghoghgvnhgusegrlhhphhgrrdhf
    rhgrnhhkvghnrdguvgdprhgtphhtthhopegthhgvnhhhuhgrtggriheskhgvrhhnvghlrd
    horhhgpdhrtghpthhtoheplhhinhhugidqmhhiphhssehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheplhhinhhugidqrghrtghhsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:F222ZoQiWSA4f-S9zHUE88_JDi6_WeF2ZxHFi22gWSuncYUOBPKLYg>
    <xmx:F222ZowO6mCZp2ImMts8oZCGjFhjphlRq-XKR8o8MTB2yjxS2H7kGQ>
    <xmx:F222Zu6VsN5XMEPrCBqy2p-vE1XZ-whDcNoZP_ERVvwOpcMKAG7AYA>
    <xmx:F222Ztw76YV2CaP4wA1ZPkTg0zIrVDnVszO0qZtUHAY7jbA0O3KAtg>
    <xmx:F222ZnmQhdj2_jQwZlRyNuRwHY36pvu7Z3APCwkeFk8vCHPlsW21DcCS>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Aug 2024 15:25:10 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Fri, 09 Aug 2024 20:25:05 +0100
Subject: [PATCH 5/7] MIPS: smp: Process NUMA information
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240809-mips-numa-v1-5-568751803bf8@flygoat.com>
References: <20240809-mips-numa-v1-0-568751803bf8@flygoat.com>
In-Reply-To: <20240809-mips-numa-v1-0-568751803bf8@flygoat.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Huacai Chen <chenhuacai@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-mips@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=4040;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=25PGnrDbozNqXeo66FAaZeG/EjrxdTBJIrhq5W4w0Zg=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrRtufxx1o+nFocyPGJadDPpM2+4rAH7XPYysey3TVqhk
 9UOXznYUcrCIMbFICumyBIioNS3ofHigusPsv7AzGFlAhnCwMUpABPRi2T4H63g0Vy68Hzg04aT
 PNLilRHh+243bJF8IjZ9z4JZjZLKTgz//awOP745f6t+bkf5seM7P6Tph04+YFF/0H5z6e/i9ab
 hbAA=
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67

Performing numa_add_cpu and numa_remove_cpu as necessary, store
NUMA map from devicetree and fix up if platform SMP code didn't
do mapping properly.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/include/asm/smp-ops.h |  7 +------
 arch/mips/kernel/smp-cps.c      |  6 ++++++
 arch/mips/kernel/smp.c          | 26 ++++++++++++++++++++++++++
 3 files changed, 33 insertions(+), 6 deletions(-)

diff --git a/arch/mips/include/asm/smp-ops.h b/arch/mips/include/asm/smp-ops.h
index 1617b207723f..4d984f0088cb 100644
--- a/arch/mips/include/asm/smp-ops.h
+++ b/arch/mips/include/asm/smp-ops.h
@@ -40,12 +40,7 @@ struct plat_smp_ops {
 
 extern void register_smp_ops(const struct plat_smp_ops *ops);
 
-static inline void plat_smp_setup(void)
-{
-	extern const struct plat_smp_ops *mp_ops;	/* private */
-
-	mp_ops->smp_setup();
-}
+extern void __init plat_smp_setup(void);
 
 extern void mips_smp_send_ipi_single(int cpu, unsigned int action);
 extern void mips_smp_send_ipi_mask(const struct cpumask *mask,
diff --git a/arch/mips/kernel/smp-cps.c b/arch/mips/kernel/smp-cps.c
index 395622c37325..be9f13c0b058 100644
--- a/arch/mips/kernel/smp-cps.c
+++ b/arch/mips/kernel/smp-cps.c
@@ -8,6 +8,7 @@
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/memblock.h>
+#include <linux/of.h>
 #include <linux/sched/task_stack.h>
 #include <linux/sched/hotplug.h>
 #include <linux/slab.h>
@@ -179,10 +180,14 @@ static void __init cps_smp_setup(void)
 
 	/* Indicate present CPUs (CPU being synonymous with VPE) */
 	for (v = 0; v < min_t(unsigned, nvpes, NR_CPUS); v++) {
+		struct device_node *np = of_get_cpu_node(v, NULL);
+
 		set_cpu_possible(v, cpu_cluster(&cpu_data[v]) == 0);
 		set_cpu_present(v, cpu_cluster(&cpu_data[v]) == 0);
 		__cpu_number_map[v] = v;
 		__cpu_logical_map[v] = v;
+		if (np)
+			early_map_cpu_to_node(v, of_node_to_nid(np));
 	}
 
 	/* Set a coherent default CCA (CWB) */
@@ -553,6 +558,7 @@ static int cps_cpu_disable(void)
 	atomic_sub(1 << cpu_vpe_id(&current_cpu_data), &core_cfg->vpe_mask);
 	smp_mb__after_atomic();
 	set_cpu_online(cpu, false);
+	numa_remove_cpu(cpu);
 	calculate_cpu_foreign_map();
 	irq_migrate_all_off_this_cpu();
 
diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index 0362fc5df7b0..17dd97ad3cbb 100644
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -153,6 +153,11 @@ void calculate_cpu_foreign_map(void)
 			       &temp_foreign_map, &cpu_sibling_map[i]);
 }
 
+bool arch_match_cpu_phys_id(int cpu, u64 phys_id)
+{
+	return phys_id == cpu_logical_map(cpu);
+}
+
 const struct plat_smp_ops *mp_ops;
 EXPORT_SYMBOL(mp_ops);
 
@@ -164,6 +169,19 @@ void register_smp_ops(const struct plat_smp_ops *ops)
 	mp_ops = ops;
 }
 
+void __init plat_smp_setup(void)
+{
+	unsigned int cpu;
+
+	mp_ops->smp_setup();
+
+	for_each_possible_cpu(cpu) {
+		/* Workaround platform SMP code not handling NUMA map */
+		if (early_cpu_to_node(cpu) == NUMA_NO_NODE)
+			early_map_cpu_to_node(cpu, 0);
+	}
+}
+
 #ifdef CONFIG_GENERIC_IRQ_IPI
 void mips_smp_send_ipi_single(int cpu, unsigned int action)
 {
@@ -372,6 +390,7 @@ asmlinkage void start_secondary(void)
 
 	set_cpu_sibling_map(cpu);
 	set_cpu_core_map(cpu);
+	numa_add_cpu(cpu);
 
 	cpumask_set_cpu(cpu, &cpu_coherent_mask);
 	notify_cpu_starting(cpu);
@@ -426,6 +445,8 @@ void __init smp_cpus_done(unsigned int max_cpus)
 /* called from main before smp_init() */
 void __init smp_prepare_cpus(unsigned int max_cpus)
 {
+	unsigned int cpu;
+
 	init_new_context(current, &init_mm);
 	current_thread_info()->cpu = 0;
 	mp_ops->prepare_cpus(max_cpus);
@@ -436,6 +457,11 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 	init_cpu_present(cpu_possible_mask);
 #endif
 	cpumask_copy(&cpu_coherent_mask, cpu_possible_mask);
+
+	for_each_possible_cpu(cpu)
+		numa_store_cpu_info(cpu);
+
+	numa_add_cpu(0);
 }
 
 /* preload SMP state for boot cpu */

-- 
2.46.0


