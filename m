Return-Path: <linux-arch+bounces-6155-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD0594E9F0
	for <lists+linux-arch@lfdr.de>; Mon, 12 Aug 2024 11:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F4D51F2249D
	for <lists+linux-arch@lfdr.de>; Mon, 12 Aug 2024 09:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B5816D9C7;
	Mon, 12 Aug 2024 09:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="LSKfliIh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mR6KyuL9"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242B616132B;
	Mon, 12 Aug 2024 09:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723455448; cv=none; b=gdNnNFzNUsuZ8aroElxbt1Ap0YRy9db2f2bTaYHgN9TSe3ZGIKqH/IAFC4Mjis8CvzOJQNJ2t/LRwdL82DuYhghn/LrG2CL386PrWVdPZ3SpXVTqH505wUNfySJI/OJjvDZiGV+nwuckgzlmDOIbYKuFZcyTymHgjvQ81xpO+sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723455448; c=relaxed/simple;
	bh=GaLop2K+QIkqMSJJz9AAraVySsj9T+4NejqFddiZQMc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rVUrY8tet8NpnSUNnhYBXFl/vT1Harl+3/IlkcRykAkwQTDpfyXuxNwpplQj0EFnYeEsUHZVz2fnxPF0cB6KeY+g/sVaGMoTzEZYDcW8hK2REfSJOLXJeXjjyqfG9oI0g6rZ1WDhmxQjBc6g/xOFBV/fp24TbyEm+y3P6V7tbJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=LSKfliIh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mR6KyuL9; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from phl-compute-04.internal (phl-compute-04.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 36C56138FD52;
	Mon, 12 Aug 2024 05:37:26 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 12 Aug 2024 05:37:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1723455446;
	 x=1723541846; bh=ZKGq9+O9qy8NbbI92dWd4mhTg7vxYZDdv7ZdobM9JZ0=; b=
	LSKfliIhqnmUdfSqnGcT3JS/oDdK7Ei8uHE4HMkogsuU2OiW4ahvavD4gLFx4d86
	l6zt+XW9589atiLLlCdDvV4nf1dSan2+ZlYFMRy4/GcTUm0l6DIyYbL+CdSHYfW7
	xB+M/M7so3A7dVsvTE1n+hS9ZuUGR3sAkTaeb6FeV8HmeQwl34WRWGezuZJTPgKa
	Lwn656ebOgHx4+ckI/yq9u1P05tDjOoXOEU2FzR/1nLGbMi++deAqToNfGZMIPy5
	87UiGXHBggsjgx58ixr5dDPAteAajOiIbhAybhyILB4cjH1XCWkndWA00w9+Qca6
	Y9x4DtIKXRAOmA5FtEY2fw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1723455446; x=
	1723541846; bh=ZKGq9+O9qy8NbbI92dWd4mhTg7vxYZDdv7ZdobM9JZ0=; b=m
	R6KyuL994a4qCvzuGhuRsH6EtuKPupvXAQtIcGlm0u3+3Dr8ReW+jH8vtUQEBNyt
	PvVKCJFhDOT8ClsMgj4JngCR5HJMjY3wjchI9rI9CfhY0oJgVcRDhy/FYKxMqEht
	XZQ9cgB9Y7B76uLLK7fxpGeszje4gp4CElXXfHHFrH99j03Pv80w9XL436e9RLyd
	kL6m8HoIQ7EE7kOom6BSbkPeMllKW137k+lsJNQpYn4+LZTBjUfuiP+zvy/JU2yZ
	Y42Zmu9Aqg1le28CZSVAswIAlvBGmCpcCwkOugPo996B4Pt6yQ3ab33mgIcS/Pc7
	n2pVIVSLP75Mnh8t5/tDg==
X-ME-Sender: <xms:1te5ZoGcyp91layNMkQC1poJqzPIjrtBV4XFB4jvDOi5WhqmfUXj8Q>
    <xme:1te5ZhWlwn54gwG_e5_Wecw-B4U1_tHxhU1urgQp6QKW9f_1sPTN1ov-OF8be5eZi
    XB2CsYp1AkAVD8uHd0>
X-ME-Received: <xmr:1te5ZiKA7TWnWtxgTi0rX7Q4j_Zao-VYQgcb942dc2QoYNIoMdiTLAddXm1VRK6pUA>
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
X-ME-Proxy: <xmx:1te5ZqGGeTcZNpXxxpaU4Nismq3NQ7XXP_gh2hbYJbwUhhrw4krc9w>
    <xmx:1te5ZuW8YsRoftLcJeawN64QsXn7FaUXf9BgfcSK9YoNBvj9VnCbzQ>
    <xmx:1te5ZtPHwo0kTJdjVdP7hJkznqLdY6IrfUIOh5At9v72ymQJ5UmAsg>
    <xmx:1te5Zl04mP4EqObqjU0AbEcAUKXLOKBpCGyYykIhZJvIWkol0Tl8OA>
    <xmx:1te5Ziq1ZJMpbeR2s62MPpw-S5e05cyloV-lMI0T9_ghgbnJisjQgkob>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Aug 2024 05:37:25 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Mon, 12 Aug 2024 10:37:16 +0100
Subject: [PATCH v2 2/7] MIPS: pci: Unify pcibus_to_node implementation
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240812-mips-numa-v2-2-fd9bdb2033b9@flygoat.com>
References: <20240812-mips-numa-v2-0-fd9bdb2033b9@flygoat.com>
In-Reply-To: <20240812-mips-numa-v2-0-fd9bdb2033b9@flygoat.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Huacai Chen <chenhuacai@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-mips@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=4206;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=GaLop2K+QIkqMSJJz9AAraVySsj9T+4NejqFddiZQMc=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrSd1y9lH6y77HTGxn7ToY1cp/m+PoiLDI5c8zDumN+c2
 ZfmSZw611HKwiDGxSArpsgSIqDUt6Hx4oLrD7L+wMxhZQIZwsDFKQATmXqY4Z+KbM5B9px28cvH
 2B4mz91ynXd1iNFTboXZ6/yWqTVHSxowMiyRZTO//Prr+r28FT+jjESyJKVUGdabzRafmL6xIk1
 oDgMA
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67

Nowadays PCI Bus NUMA node information is always stored in struct
device of host bridge.

Unify the implementation of pcibus_to_node to simplify code.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/include/asm/mach-ip27/topology.h       |  4 ----
 arch/mips/include/asm/mach-loongson64/topology.h |  5 -----
 arch/mips/include/asm/pci.h                      | 12 ++++++++++++
 arch/mips/loongson64/numa.c                      |  7 -------
 arch/mips/pci/pci-ip27.c                         | 10 ----------
 arch/mips/pci/pci-xtalk-bridge.c                 |  1 +
 6 files changed, 13 insertions(+), 26 deletions(-)

diff --git a/arch/mips/include/asm/mach-ip27/topology.h b/arch/mips/include/asm/mach-ip27/topology.h
index d66cc53feab8..0ad74e2e0d85 100644
--- a/arch/mips/include/asm/mach-ip27/topology.h
+++ b/arch/mips/include/asm/mach-ip27/topology.h
@@ -17,10 +17,6 @@ extern struct cpuinfo_ip27 sn_cpu_info[NR_CPUS];
 #define cpumask_of_node(node)	((node) == -1 ?				\
 				 cpu_all_mask :				\
 				 &hub_data(node)->h_cpus)
-struct pci_bus;
-extern int pcibus_to_node(struct pci_bus *);
-
-#define cpumask_of_pcibus(bus)	(cpumask_of_node(pcibus_to_node(bus)))
 
 extern unsigned char __node_distances[MAX_NUMNODES][MAX_NUMNODES];
 
diff --git a/arch/mips/include/asm/mach-loongson64/topology.h b/arch/mips/include/asm/mach-loongson64/topology.h
index 3414a1fd1783..c60ccdbe5a94 100644
--- a/arch/mips/include/asm/mach-loongson64/topology.h
+++ b/arch/mips/include/asm/mach-loongson64/topology.h
@@ -9,11 +9,6 @@
 extern cpumask_t __node_cpumask[];
 #define cpumask_of_node(node)	(&__node_cpumask[node])
 
-struct pci_bus;
-extern int pcibus_to_node(struct pci_bus *);
-
-#define cpumask_of_pcibus(bus)	(cpu_online_mask)
-
 extern unsigned char __node_distances[MAX_NUMNODES][MAX_NUMNODES];
 
 #define node_distance(from, to)	(__node_distances[(from)][(to)])
diff --git a/arch/mips/include/asm/pci.h b/arch/mips/include/asm/pci.h
index d993df6302dc..09323348d362 100644
--- a/arch/mips/include/asm/pci.h
+++ b/arch/mips/include/asm/pci.h
@@ -134,6 +134,18 @@ static inline int pci_proc_domain(struct pci_bus *bus)
 }
 #endif /* CONFIG_PCI_DOMAINS */
 
+#ifdef CONFIG_NUMA
+static inline int pcibus_to_node(struct pci_bus *bus)
+{
+	return dev_to_node(&bus->dev);
+}
+#ifndef cpumask_of_pcibus
+#define cpumask_of_pcibus(bus)	(pcibus_to_node(bus) == -1 ?		\
+				 cpu_all_mask :				\
+				 cpumask_of_node(pcibus_to_node(bus)))
+#endif
+#endif
+
 #endif /* __KERNEL__ */
 
 /* Do platform specific device initialization at pci_enable_device() time */
diff --git a/arch/mips/loongson64/numa.c b/arch/mips/loongson64/numa.c
index 8388400d052f..d49180562c9f 100644
--- a/arch/mips/loongson64/numa.c
+++ b/arch/mips/loongson64/numa.c
@@ -171,13 +171,6 @@ void __init mem_init(void)
 	setup_zero_pages();	/* This comes from node 0 */
 }
 
-/* All PCI device belongs to logical Node-0 */
-int pcibus_to_node(struct pci_bus *bus)
-{
-	return 0;
-}
-EXPORT_SYMBOL(pcibus_to_node);
-
 void __init prom_init_numa_memory(void)
 {
 	pr_info("CP0_Config3: CP0 16.3 (0x%x)\n", read_c0_config3());
diff --git a/arch/mips/pci/pci-ip27.c b/arch/mips/pci/pci-ip27.c
index 973faea61cad..d919c70e02b1 100644
--- a/arch/mips/pci/pci-ip27.c
+++ b/arch/mips/pci/pci-ip27.c
@@ -17,16 +17,6 @@
 #include <asm/sn/ioc3.h>
 #include <asm/pci/bridge.h>
 
-#ifdef CONFIG_NUMA
-int pcibus_to_node(struct pci_bus *bus)
-{
-	struct bridge_controller *bc = BRIDGE_CONTROLLER(bus);
-
-	return bc->nasid;
-}
-EXPORT_SYMBOL(pcibus_to_node);
-#endif /* CONFIG_NUMA */
-
 static void ip29_fixup_phy(struct pci_dev *dev)
 {
 	int nasid = pcibus_to_node(dev->bus);
diff --git a/arch/mips/pci/pci-xtalk-bridge.c b/arch/mips/pci/pci-xtalk-bridge.c
index 45ddbaa6c123..45b2b390e553 100644
--- a/arch/mips/pci/pci-xtalk-bridge.c
+++ b/arch/mips/pci/pci-xtalk-bridge.c
@@ -633,6 +633,7 @@ static int bridge_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
+	set_dev_node(dev, bd->nasid);
 	pci_set_flags(PCI_PROBE_ONLY);
 
 	host = devm_pci_alloc_host_bridge(dev, sizeof(*bc));

-- 
2.46.0


