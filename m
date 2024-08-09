Return-Path: <linux-arch+bounces-6136-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0570794D734
	for <lists+linux-arch@lfdr.de>; Fri,  9 Aug 2024 21:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51902B2302D
	for <lists+linux-arch@lfdr.de>; Fri,  9 Aug 2024 19:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 596DF16088F;
	Fri,  9 Aug 2024 19:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="AzCJQawp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LNJDAauL"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2A315FA8A;
	Fri,  9 Aug 2024 19:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723231510; cv=none; b=RAEKeCjiJfyjND6PnXw3MvsqI6wkDFe27LWr2mPJ284xD4WxCK3zC8SlK2yLX5dQbYwiqzNognPkkTLdq8VC2fDaViZVuRDo0KZD0gwR+yQfvO3C+an7yyMqCoXLDY6t/3I7rBV/Bw/tgsA062sahc2KiuEvETb25TaNBkofDKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723231510; c=relaxed/simple;
	bh=GaLop2K+QIkqMSJJz9AAraVySsj9T+4NejqFddiZQMc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NmYktwVnrhCVWTlPMNM5QlPi53PjdKWn/EjcSbAg6Ha0oafwQWP4zClj8SwERXRoziStrYx09lASflF5raVI2V4bqbVKl46i+pLrp5upnB8D1k+M6Sy2a4CzD43cv2V6X59fdwvvy2cIRex/PAebcPWC5IY4Cn7Vw6f/jB4OLE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=AzCJQawp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LNJDAauL; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id 8F83F1388004;
	Fri,  9 Aug 2024 15:25:07 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 09 Aug 2024 15:25:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1723231507;
	 x=1723317907; bh=ZKGq9+O9qy8NbbI92dWd4mhTg7vxYZDdv7ZdobM9JZ0=; b=
	AzCJQawpNwVPdnmQl1PolPtOYNPG1G6TOb1dVl2BpURlreniaueSW3e6r3XeJoJn
	pS02dRx6XNk3dYmDlUtXdphPWF3k1Z12epdtwTH/WVHVjShf8V1IOiN+vKsjqS0O
	qMJqsDRV8caYUS1iBU3Fn5Az+7EyrqxwXZnR9yaozsRcP58Lvyvk+t3NuSoiVeCw
	lnegYhBC3aX4+zQTn2ie0bjPUTdYNfboEQe/cPqardjxo9oagULhuUYSqT0qyoSo
	WtI9NsktN54sMdzC6Gf18I0o3T5snWVD82hFmOTjzcW9ANwPTXUpwuVV5jQggD3C
	zyWA5BSfLQBSLb4UJRSDqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1723231507; x=
	1723317907; bh=ZKGq9+O9qy8NbbI92dWd4mhTg7vxYZDdv7ZdobM9JZ0=; b=L
	NJDAauLWQMMHMkOva/BeRr7o3LnnkvS99LbdbgtcOQw7kadU6I/29av2Irrx0b9M
	KYRZYvGAogzMFuc9R6cVhmxeEUDOStwzVhB4luViYJeOrbVjw+P9Mafg8+OdZ8m0
	PgoIhiAGAdkeBlK3snFRyyOwA8DzOPHbgG5s3paeCM0AwH//aOyQOXVRn5j4kYEj
	dU9IKiIAja0fB8Q48eNT7LTGnLZJ39fMcWnUE5KoYyKlMrgrV7XzhH6Yo7pfQ4Mn
	QXdYbTm7u+/tRimwugIw2Wa432cjKF8FNABfEzME8HGJ39DqaDKJ7uucxdCOwreA
	9zs/JSZ9ndUYOD6KJ0k6g==
X-ME-Sender: <xms:E222ZqmA11VfpQx-5RoBlEFpu259kCoid4Yy0tC72vXMQT0xUeKUOw>
    <xme:E222Zh26G5ykm7IFbTD3BT1dBq_7yTEEWUsELfx91X9DFpm0vsVASq0L6HRLXYv2b
    aK-aRucqku0M9ReQ4I>
X-ME-Received: <xmr:E222ZoqkIBElNIZAEyuWhmmd2ERkfn12jbxnc5P8SnGf5JTfne-PJSknybKb2QKeiw>
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
X-ME-Proxy: <xmx:E222Zul21T4u4drre4DNSn94wUfyz0AJxIoU72DP8DAq2JRCcnwo5w>
    <xmx:E222Zo27yHKH8c_-PN8jeW1R9OOL6Nepc9z8CXw7F5fm4sXfQKPNKg>
    <xmx:E222Zlsl2-SbJta-vJlmImI569WJY-qYSRI0sw_zUYlnFvkv3sPang>
    <xmx:E222ZkU7YCGHG7gREx-h9I6TuEZ1Lms8mpH6guJWGYFDfcI2XT9o5A>
    <xmx:E222ZpLDySDgszmvFuftFjdrSXiK5wIJ8yPFQ01nwNmh-AzraOTkH-M5>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Aug 2024 15:25:06 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Fri, 09 Aug 2024 20:25:02 +0100
Subject: [PATCH 2/7] MIPS: pci: Unify pcibus_to_node implementation
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240809-mips-numa-v1-2-568751803bf8@flygoat.com>
References: <20240809-mips-numa-v1-0-568751803bf8@flygoat.com>
In-Reply-To: <20240809-mips-numa-v1-0-568751803bf8@flygoat.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Huacai Chen <chenhuacai@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-mips@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=4206;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=GaLop2K+QIkqMSJJz9AAraVySsj9T+4NejqFddiZQMc=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrRtufwMevNePb99wlKicJeOavZeu8tSvhKHezqq2y++1
 5E//PppRykLgxgXg6yYIkuIgFLfhsaLC64/yPoDM4eVCWwIF6cATMTlKCPDosQnsju/Kz3bXGZ5
 dLv1FYH5c2LiQ6N2mO++wah4ftnd74wM6yXdv9e2TNqpcHHGd9klDhsSw6zMOUQ0E6Lyay/fvJ3
 CCgA=
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


