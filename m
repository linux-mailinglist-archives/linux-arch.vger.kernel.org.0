Return-Path: <linux-arch+bounces-6157-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF0D894E9F5
	for <lists+linux-arch@lfdr.de>; Mon, 12 Aug 2024 11:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D760B213AA
	for <lists+linux-arch@lfdr.de>; Mon, 12 Aug 2024 09:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579A716DEA3;
	Mon, 12 Aug 2024 09:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="XH8JYUX9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gFecbiKM"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8645616D9DB;
	Mon, 12 Aug 2024 09:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723455451; cv=none; b=n+mcab5D7C8hbcGhLzQcscVPJX6yo627nTYpQvUWT+NogR7R4byxMex/IfmLz1BezgGCNdHmA0TYfY8V9HH9CXweem0IxmCZp+aquLWJTqsVZM/H3P8omHTIDcTKiI7DnCAj1SMuvr5BtAp53E4jquPhBjBIB2ywaww+OlnNGRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723455451; c=relaxed/simple;
	bh=/2vM9Jarepf6oyk/v8ZwnyJnwqhxSDzHMZeDhKKDNNc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xelr/9LTzbQc2/k69D3u0cqHkJeG9ehQ/aoVubNpGvj+RUdn4q5QIjhf7gdbOUt1FWdVmDwzKASGOzvtmFvhm+LU3qcCCg4/GfCcxr1Vyg5gfVWXnORq+EfXdU6wECxODY+BwKZmWMSWHXd6V6FJP3PecqHnRlXX0DSKg7qvQvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=XH8JYUX9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gFecbiKM; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from phl-compute-06.internal (phl-compute-06.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 8E864138FC87;
	Mon, 12 Aug 2024 05:37:27 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 12 Aug 2024 05:37:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1723455447;
	 x=1723541847; bh=Lux1sMrQcX9bqRHe6vEl5Vg0QIiAUMpeYGep9wxBF34=; b=
	XH8JYUX9o+wI5vUkqD/azjyMbzSom9Q5gUC1Gq7wGro4hYLHlxmaEjUDT3N4a2Mg
	BtRCQvm0SljkUe8tInoEK4LzYfKzUNIpiqO1KYX7TZwJqRatNACxA+v0MqXyTvMy
	anNSxjnxOwZ5p8dy7xl9kggy2INA99wtsXmXMIu8XydlQJKGDHt/OKkVBcKRVDRI
	65mVlc6c/5E5MgklgdNHfmx9Q2KEDAk6JWUynqu4+QkiO/CpH81ucw/v5Q3uyhtQ
	46inRYtV8dVOCxEfo29mKGH09ZTat08UnLbxbFtDmJcgEwU51yi9/d0zQstDUa0m
	iqgwVuJoMHUncgv+A98hZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1723455447; x=
	1723541847; bh=Lux1sMrQcX9bqRHe6vEl5Vg0QIiAUMpeYGep9wxBF34=; b=g
	FecbiKMWWnSz6E/wRPOTnC5ItgMhlIS7l7M65DdIiAD7Nenzmyv13g2rxoG41L9H
	NzBQyOpLfj1niuay4oz5YBR/5vEdMO3ykn0sA93qSj0/wWAg571f/TEsNC19S4Vh
	1DdmXxzxFeT+hP4FZLXQ468bhSOaVNdn7tbhlbUVV0kg76A2MNLY3T18knIJBU4F
	jKDatW7Pfngmzt1OmSCPIfUN9BdzyVLJh+YQedO+8xBlR/GzNWd7Lwv0X0eBmBGA
	jl2AScTYs3u6aXnH3YKo8I+Y6ynRF6FdzqcqoYijDbA2c/HGChteYI/fogBMySlP
	PpYNf5E/S4vAJ2InzVd1Q==
X-ME-Sender: <xms:19e5ZtmC3saxCJZPLJY_kEhHy2_EOWEvvA3214dlbEDSv53-wg6Bhw>
    <xme:19e5Zo3ITqx9ITpFlN3cFjbwcRTSCXLTFVFb1YdLDi42Y3MusmbSU20TO6SmZoXUZ
    JbPgz5eWoOQzoQaV-E>
X-ME-Received: <xmr:19e5ZjpqFkXa52-qykehDuk0peuIRKouUi2bmRgJdhmvRzd3hkb4ANjQEuiulXUReQ>
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
X-ME-Proxy: <xmx:19e5ZtnCVgyM4-08b9Y3KJ7rLmfUUyo5DQ2byKM3KWrW3L9ruFM2OA>
    <xmx:19e5Zr2wTz4mm2xEBSJyjtRc9_7zxLAbhDnRdHYvGcF0uUlrKTRifA>
    <xmx:19e5Zsuq2nVhcgDeW-Xuu3VwRC14UX9X2eFYbqpLx9PCm1gYJVIzng>
    <xmx:19e5ZvWrTpMmGB7J7s2Xa9X6KZzTMZyrZG4gB8_JgUJa-pH8ElNszg>
    <xmx:19e5ZkJVfNEnTUj4xVDEqBg-Uy6p_IKf47Una4gCBTQpVnko-ZF_5atp>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Aug 2024 05:37:26 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Mon, 12 Aug 2024 10:37:17 +0100
Subject: [PATCH v2 3/7] MIPS: Prepare NUMA headers for arch_numa
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240812-mips-numa-v2-3-fd9bdb2033b9@flygoat.com>
References: <20240812-mips-numa-v2-0-fd9bdb2033b9@flygoat.com>
In-Reply-To: <20240812-mips-numa-v2-0-fd9bdb2033b9@flygoat.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Huacai Chen <chenhuacai@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-mips@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=7544;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=/2vM9Jarepf6oyk/v8ZwnyJnwqhxSDzHMZeDhKKDNNc=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrSd1y89kfT0fS4oXPPS8kvF5reevU374s8us7bo1NC2z
 vqq/+l/RykLgxgXg6yYIkuIgFLfhsaLC64/yPoDM4eVCWQIAxenAEzklzLD/7TqkyYX135VXuHn
 fSrs6hzDvrTGTgnv83xH7Rs1NofM5WFkOLtWd+nLzTbXn7D0Xz1juWinS/X04l496bNccr0Pnt0
 K5QAA
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67

Massage headers so that we can include asm-generic/numa.h
for generic platform.

Provide dummy arch_numa like functions in Loongson64/IP27 platform
to fill the gap between them and generic platform.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/include/asm/mach-generic/mmzone.h      | 11 +++++++++++
 arch/mips/include/asm/mach-generic/numa.h        | 11 +++++++++++
 arch/mips/include/asm/mach-generic/topology.h    |  7 +++++++
 arch/mips/include/asm/mach-ip27/numa.h           | 22 ++++++++++++++++++++++
 arch/mips/include/asm/mach-ip27/topology.h       |  8 +++-----
 arch/mips/include/asm/mach-loongson64/numa.h     | 22 ++++++++++++++++++++++
 arch/mips/include/asm/mach-loongson64/topology.h | 10 ++++------
 arch/mips/include/asm/mmzone.h                   |  5 +----
 arch/mips/include/asm/numa.h                     | 12 ++++++++++++
 arch/mips/kernel/setup.c                         |  1 +
 10 files changed, 94 insertions(+), 15 deletions(-)

diff --git a/arch/mips/include/asm/mach-generic/mmzone.h b/arch/mips/include/asm/mach-generic/mmzone.h
new file mode 100644
index 000000000000..d4374b71a900
--- /dev/null
+++ b/arch/mips/include/asm/mach-generic/mmzone.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2024 Jiaxun Yang <jiaxun.yang@flygoat.com>
+ */
+
+#ifndef __ASM_MACH_GENERIC_MMZONE_H
+#define __ASM_MACH_GENERIC_MMZONE_H
+
+/* Intentionally empty file ...	 */
+
+#endif /* __ASM_MACH_GENERIC_MMZONE_H */
diff --git a/arch/mips/include/asm/mach-generic/numa.h b/arch/mips/include/asm/mach-generic/numa.h
new file mode 100644
index 000000000000..311a5871807c
--- /dev/null
+++ b/arch/mips/include/asm/mach-generic/numa.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2024 Jiaxun Yang <jiaxun.yang@flygoat.com>
+ */
+
+#ifndef __ASM_MACH_GENERIC_NUMA_H
+#define __ASM_MACH_GENERIC_NUMA_H
+
+#include <asm-generic/numa.h>
+
+#endif	/* __ASM_NUMA_H */
diff --git a/arch/mips/include/asm/mach-generic/topology.h b/arch/mips/include/asm/mach-generic/topology.h
index 5428f333a02c..fa82d18ba9e7 100644
--- a/arch/mips/include/asm/mach-generic/topology.h
+++ b/arch/mips/include/asm/mach-generic/topology.h
@@ -1 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef __ASM_MACH_GENERIC_TOPOLOGY_H
+#define __ASM_MACH_GENERIC_TOPOLOGY_H
+
+#include <asm/numa.h>
 #include <asm-generic/topology.h>
+
+#endif
diff --git a/arch/mips/include/asm/mach-ip27/numa.h b/arch/mips/include/asm/mach-ip27/numa.h
new file mode 100644
index 000000000000..e2adadf8a589
--- /dev/null
+++ b/arch/mips/include/asm/mach-ip27/numa.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2024 Jiaxun Yang <jiaxun.yang@flygoat.com>
+ */
+
+#ifndef __ASM_MACH_NUMA_H
+#define __ASM_MACH_NUMA_H
+
+#ifdef CONFIG_NUMA
+extern unsigned char __node_distances[MAX_NUMNODES][MAX_NUMNODES];
+
+#define node_distance(from, to) (__node_distances[(from)][(to)])
+#endif
+
+/* Hanlded in platform code */
+static inline void numa_store_cpu_info(unsigned int cpu) { }
+static inline void numa_add_cpu(unsigned int cpu) { }
+static inline void numa_remove_cpu(unsigned int cpu) { }
+static inline void arch_numa_init(void) { }
+static inline void early_map_cpu_to_node(unsigned int cpu, int nid) { }
+
+#endif	/* __ASM_NUMA_H */
diff --git a/arch/mips/include/asm/mach-ip27/topology.h b/arch/mips/include/asm/mach-ip27/topology.h
index 0ad74e2e0d85..33d5bf925431 100644
--- a/arch/mips/include/asm/mach-ip27/topology.h
+++ b/arch/mips/include/asm/mach-ip27/topology.h
@@ -4,6 +4,7 @@
 
 #include <asm/sn/types.h>
 #include <asm/mmzone.h>
+#include <asm/numa.h>
 
 struct cpuinfo_ip27 {
 	nasid_t		p_nasid;	/* my node ID in numa-as-id-space */
@@ -13,15 +14,12 @@ struct cpuinfo_ip27 {
 
 extern struct cpuinfo_ip27 sn_cpu_info[NR_CPUS];
 
-#define cpu_to_node(cpu)	(cputonasid(cpu))
+#define early_cpu_to_node(cpu)	(cputonasid(cpu))
+#define cpu_to_node(cpu)  early_cpu_to_node(cpu)
 #define cpumask_of_node(node)	((node) == -1 ?				\
 				 cpu_all_mask :				\
 				 &hub_data(node)->h_cpus)
 
-extern unsigned char __node_distances[MAX_NUMNODES][MAX_NUMNODES];
-
-#define node_distance(from, to) (__node_distances[(from)][(to)])
-
 #include <asm-generic/topology.h>
 
 #endif /* _ASM_MACH_TOPOLOGY_H */
diff --git a/arch/mips/include/asm/mach-loongson64/numa.h b/arch/mips/include/asm/mach-loongson64/numa.h
new file mode 100644
index 000000000000..2fac370d981f
--- /dev/null
+++ b/arch/mips/include/asm/mach-loongson64/numa.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2024 Jiaxun Yang <jiaxun.yang@flygoat.com>
+ */
+
+#ifndef __ASM_MACH_LOONGSON64_NUMA_H
+#define __ASM_MACH_LOONGSON64_NUMA_H
+
+#ifdef CONFIG_NUMA
+extern unsigned char __node_distances[MAX_NUMNODES][MAX_NUMNODES];
+
+#define node_distance(from, to)	(__node_distances[(from)][(to)])
+#endif
+
+/* Hanlded in platform code */
+static inline void numa_store_cpu_info(unsigned int cpu) { }
+static inline void numa_add_cpu(unsigned int cpu) { }
+static inline void numa_remove_cpu(unsigned int cpu) { }
+static inline void arch_numa_init(void) { }
+static inline void early_map_cpu_to_node(unsigned int cpu, int nid) { }
+
+#endif	/* __ASM_NUMA_H */
diff --git a/arch/mips/include/asm/mach-loongson64/topology.h b/arch/mips/include/asm/mach-loongson64/topology.h
index c60ccdbe5a94..ebb086821401 100644
--- a/arch/mips/include/asm/mach-loongson64/topology.h
+++ b/arch/mips/include/asm/mach-loongson64/topology.h
@@ -2,17 +2,15 @@
 #ifndef _ASM_MACH_TOPOLOGY_H
 #define _ASM_MACH_TOPOLOGY_H
 
-#ifdef CONFIG_NUMA
+#include <asm/numa.h>
 
-#define cpu_to_node(cpu)	(cpu_logical_map(cpu) >> 2)
+#ifdef CONFIG_NUMA
+#define early_cpu_to_node(cpu)	(cpu_logical_map(cpu) >> 2)
+#define cpu_to_node(cpu)  early_cpu_to_node(cpu)
 
 extern cpumask_t __node_cpumask[];
 #define cpumask_of_node(node)	(&__node_cpumask[node])
 
-extern unsigned char __node_distances[MAX_NUMNODES][MAX_NUMNODES];
-
-#define node_distance(from, to)	(__node_distances[(from)][(to)])
-
 #endif
 
 #include <asm-generic/topology.h>
diff --git a/arch/mips/include/asm/mmzone.h b/arch/mips/include/asm/mmzone.h
index 14226ea42036..f472c8ec3a63 100644
--- a/arch/mips/include/asm/mmzone.h
+++ b/arch/mips/include/asm/mmzone.h
@@ -7,10 +7,7 @@
 #define _ASM_MMZONE_H_
 
 #include <asm/page.h>
-
-#ifdef CONFIG_NUMA
-# include <mmzone.h>
-#endif
+#include <mmzone.h>
 
 #ifndef pa_to_nid
 #define pa_to_nid(addr) 0
diff --git a/arch/mips/include/asm/numa.h b/arch/mips/include/asm/numa.h
new file mode 100644
index 000000000000..ff1eb9ef51e6
--- /dev/null
+++ b/arch/mips/include/asm/numa.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2024 Jiaxun Yang <jiaxun.yang@flygoat.com>
+ */
+
+#ifndef __ASM_NUMA_H
+#define __ASM_NUMA_H
+
+#include <asm/topology.h>
+#include <numa.h>
+
+#endif /* __ASM_NUMA_H */
diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 12a1a4ffb602..655391c04477 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -664,6 +664,7 @@ static void __init arch_mem_init(char **cmdline_p)
 
 	mips_parse_crashkernel();
 	device_tree_init();
+	arch_numa_init();
 
 	/*
 	 * In order to reduce the possibility of kernel panic when failed to

-- 
2.46.0


