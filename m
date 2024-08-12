Return-Path: <linux-arch+bounces-6158-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A431694E9F9
	for <lists+linux-arch@lfdr.de>; Mon, 12 Aug 2024 11:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59ABB281002
	for <lists+linux-arch@lfdr.de>; Mon, 12 Aug 2024 09:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A80016E872;
	Mon, 12 Aug 2024 09:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="V3F8WsrQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V8lkh58+"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C030916DEBD;
	Mon, 12 Aug 2024 09:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723455453; cv=none; b=BKKuYlwVraETzTlnfTHUEH8g8vSKOw2FAZcF9XAxL+Qqw4nBdRFuG/ZHfc3xCtm2bmyCnxSNJ2dP0vwVUpsO46AVdbounWO17cDnhgrrWwoTLX/oyflU/lSM099b6wA+Y9t++uzYdAugflkGPwbwDgjYLrwP65KQchgyj/yxwdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723455453; c=relaxed/simple;
	bh=25PGnrDbozNqXeo66FAaZeG/EjrxdTBJIrhq5W4w0Zg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y5MzEgNxUfAej9myOIMCQi+X8iKolzvhTLr1mJQqLsgmADs74+v8v0JBYQ+vC2rlaBl9UbZVMmtwpU7jJjVGrSji/UA9XrLRTyvZ/gapu5rqRg72AYFnkw+u9cpdJksIniqrhXiuXJpXB1mFGSDf6TlgnjZs0MnbylqlARohODg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=V3F8WsrQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=V8lkh58+; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from phl-compute-02.internal (phl-compute-02.nyi.internal [10.202.2.42])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 17E69114709A;
	Mon, 12 Aug 2024 05:37:30 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 12 Aug 2024 05:37:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1723455450;
	 x=1723541850; bh=91Ntn8+8S3tkwtkpXtQo+UUnbH7tPRABNLmEHtSRkko=; b=
	V3F8WsrQ5HxTj9fr1WdAgoJUIZOH41ZKKp0Hcsb5lKBpJlqBj6zq8y0P6o8I55S0
	1rVRt3nqu8xK2gjqdj/kscR+r0XNWgz/ExqtNu2DM1CwBpUyEfx+XKlmgcksODBM
	N2A1uTvvre7kV5CeSoDHtF3rrLgU9yWy9AE2yTykAF1QBL4HktvIM66H/bn2rG/v
	d/0WMhzE9/KnUoHcxVAfQ9ars1kbU1MeNuHpxxnmzmAWQzTuRm6k2UvoAS0T327P
	kiNjHGEOltHL0JXRL00R9SgUAcjtuYx4ZqsOz7Fymn5OGcab1GtMC0JRsPjIaGiA
	kHlUVw92tgsHIk4vtZRyww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1723455450; x=
	1723541850; bh=91Ntn8+8S3tkwtkpXtQo+UUnbH7tPRABNLmEHtSRkko=; b=V
	8lkh58+LZljnia9kVJFkbHv7FE2jOorprFHvWn8lkJiC/1ecgnysFk3WNbAlCV+7
	rPADjnH1WDJyg/wAPjFiHsZatv03miQHQQRbYK4inGiw5ahRViOyOzh6Y2be5p9y
	sv2kbsjKg590ejVveizTtikqSVJaqtBGYLyOsWR4V5/fKS9Ss1uMVSeUDYxUx5TS
	7D9cAnCY+BbHpVxFDzC28ljRd+V3XxIxg6hX7h4sZhTkRsXTUCCaB4AbrNgK/DxH
	xffcHYymz3dcYTcTu8nhBPlUKJ5Tu3x8c1BH63efKcNcBcxs3zkIBi+hlfNa0/tQ
	m0OltqUC+siR49jxTNYdA==
X-ME-Sender: <xms:2de5Zh2zh-pvjcVsvQiYJUPjS2u32A3VZmQJ1dTl7Dr9MnX9cv3WRg>
    <xme:2de5ZoFtZVMcqn3rt_dsh6GaNDSIH3VQyXAuOXfhq4urLfIAX_17_nS9q4vkZV51u
    8XmPeUsVN5thIayRVE>
X-ME-Received: <xmr:2de5Zh7e3WpPROANArGYhFieTYvKkyDKVJ6mYMDZdTRUFCbR_nldCvjAens5lN0jnA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddttddgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhi
    hgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffek
    gedugefhtdduudeghfeuveegffegudekjeelnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdr
    tghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    eplhhinhhugidqmhhiphhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    tghhvghnhhhurggtrghisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqd
    grrhgthhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrrghfrggvlhes
    khgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghrnhgusegrrhhnuggsrdguvgdprhgtph
    htthhopehtshgsohhgvghnugesrghlphhhrgdrfhhrrghnkhgvnhdruggvpdhrtghpthht
    oheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:2te5Zu3ykeLnz-EylXvcmKD829FvlGSDProzZMBRThVt_qeyz-5Fcg>
    <xmx:2te5ZkEhJU3RDFQXPKRE1XZMRQdMNGTNv4XQZ7PIFLAAckFub3omsw>
    <xmx:2te5Zv8qgruKpjiuSoyXkaBUpNGpd1WmFgYYB_cNFyy_EbL5n7sY6w>
    <xmx:2te5Zhn6vgDIxIC7u9G2VcifnCRohM0VMrzTbx_Bg2n6DkDxbfeiDw>
    <xmx:2te5ZiaKWPtUH18ELsrRsPHsNwz2fgjl4Y4dwnTFn1mCICDflLwrn7-h>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Aug 2024 05:37:28 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Mon, 12 Aug 2024 10:37:19 +0100
Subject: [PATCH v2 5/7] MIPS: smp: Process NUMA information
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240812-mips-numa-v2-5-fd9bdb2033b9@flygoat.com>
References: <20240812-mips-numa-v2-0-fd9bdb2033b9@flygoat.com>
In-Reply-To: <20240812-mips-numa-v2-0-fd9bdb2033b9@flygoat.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Huacai Chen <chenhuacai@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-mips@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=4040;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=25PGnrDbozNqXeo66FAaZeG/EjrxdTBJIrhq5W4w0Zg=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrSd1y9V2ClGO4dcXXeg1GhRzeurThekvFZKPU4Ld8g2P
 Mt8gzOyo5SFQYyLQVZMkSVEQKlvQ+PFBdcfZP2BmcPKBDKEgYtTACZyeg/DX2FX4ckPp4qkv6lR
 0Zviek9bUDZ/666aLNfuvuV7TwjJCTP8r9xubjpjl+Dr57NK1diSfvxvy0zp4hRYfVzr3B6/vfI
 LGQA=
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


