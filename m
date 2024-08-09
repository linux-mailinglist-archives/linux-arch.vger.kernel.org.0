Return-Path: <linux-arch+bounces-6137-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB7F94D736
	for <lists+linux-arch@lfdr.de>; Fri,  9 Aug 2024 21:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F05E1F22777
	for <lists+linux-arch@lfdr.de>; Fri,  9 Aug 2024 19:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE37167DB8;
	Fri,  9 Aug 2024 19:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="PLd0laW2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vVm6+gSU"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61D8160860;
	Fri,  9 Aug 2024 19:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723231511; cv=none; b=iIuk67hCRGJHYh6tqov6uczZvmrpCvpebSqJ/weAKRgzCcLSz6b/ntBGV/GygN9MEAnM9HEYnzx7Dycc+msMHpCV9Ta7ww66YyAgHAnhiCe19lJS1iwB3MCTvGaPB2URxAE89tNdwBGgCPbCKfhEIvr2fpURy3VAjr+/QpSKMCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723231511; c=relaxed/simple;
	bh=/2vM9Jarepf6oyk/v8ZwnyJnwqhxSDzHMZeDhKKDNNc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rMmu1YhHGv6TnXZM2KkRrwxSbNkKyFZexHxxvRXKwmxdHMANhiXOYjSbaf2ItFrIJc4GJUm07Y2Xqjp+OOkpyPZzlfRl19k5xi1mKARQjqv0snD3x26LMzk4gT811nxBNBBQIpn9NBamGCcRzXSvq9kumhLSx5FLt2AccHHIm6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=PLd0laW2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vVm6+gSU; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id E8FAB138F206;
	Fri,  9 Aug 2024 15:25:08 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 09 Aug 2024 15:25:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1723231508;
	 x=1723317908; bh=Lux1sMrQcX9bqRHe6vEl5Vg0QIiAUMpeYGep9wxBF34=; b=
	PLd0laW2eUF08ApyM3Jtu/1rm7oB3mg3MVPV8U/0YYpQvX6F9Wv1MmimHzHh0Dnq
	Dhc3PSCsxcpTO1RF5wpAuFEMOejzGhLheTjhzduzCDVGnEEtM/VKgh7GVdyHyLgA
	0F4f7JP68G3gVdJTMezLAuTsNaDx4/XW/ygK4hbUfD+B1HNwNCtI74usyDB6kyA0
	+3uvbL6c6BddgUmnr8jDXRApmto5yq9NnC8cSPI5e5qBHkqVrQFCJonvxdUlwe5Y
	sM6E47b6GS7tK+Tuh0ypC7j3ewRat3zfNWYjHYjUkulUK4/9B8N0qK5LBAGG1SV0
	CukcIaV02tizgXsl/i9l7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1723231508; x=
	1723317908; bh=Lux1sMrQcX9bqRHe6vEl5Vg0QIiAUMpeYGep9wxBF34=; b=v
	Vm6+gSUi5zI1yM+EJxPZRhiVADyZGuGHXzag7PhRC6wDME6UA5i1b768ICwVYHp9
	zzNVpXfEbGTvjH2o7KFuTrtAhBc3HVk2wEvW2CqpGte5xiWxNNeNfBIQzgdRs2jD
	bE5A9TUhwYDy4317kH/350PLQuVE8DM9L1hpqOJHSDjqf9EnY7q+GkvC+40+i990
	fXWZ25+d1JbSO5bWRufsINfhVsOXt7XNNnLQBy8ObMpV//60RGSi2swsGcgHoW+O
	qwDS6Jg8SHxKVbiCGs5uv7VLDan6D2Dkf7ljQUp2C+sLscJBomby/H7/x3/kYdS0
	cJFrKlK3SnRBR3ZtLVkOg==
X-ME-Sender: <xms:FG22ZvrinnwSZNZ6Fs9yZLmWXaj0fe3159Ba7N9i0v9aNq3Q5rLmVQ>
    <xme:FG22ZppcASL_1yvY2guFSxeW5eeHKM5WKf0_5g6dbPXzzasPyaZDBYXtw8MEHXw4i
    NlE_suVOF6krnJu984>
X-ME-Received: <xmr:FG22ZsMhH5WEEwQLMTGO9BrRhxXUEISu-DXCr3vwI0-q5urhO_Pgjbtv4ZmG7pdXtw>
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
X-ME-Proxy: <xmx:FG22Zi7-PfXuukn57jdDRdSe_BO1xXd_xTUqwroqlGyb7DditR2BvA>
    <xmx:FG22Zu5RbpB0A3H38bFEwdApXQhmPEPKU2b7DWMgKJlU5iK8IaTBkQ>
    <xmx:FG22ZqhS4whxZ_pMk_gyVDrFg7POOXzIagjvFMEc11ZWfN41AnCFFA>
    <xmx:FG22Zg6zilotoCn-qdbnyU8VMhnKFEiOXR0TPthsAAlyW7UPgPtgtg>
    <xmx:FG22ZgsBNr_kB0xWNrKlJq8DzUc5vnxs3jAhIW3_sM3IDUJmwZC9RxIG>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Aug 2024 15:25:07 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Fri, 09 Aug 2024 20:25:03 +0100
Subject: [PATCH 3/7] MIPS: Prepare NUMA headers for arch_numa
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240809-mips-numa-v1-3-568751803bf8@flygoat.com>
References: <20240809-mips-numa-v1-0-568751803bf8@flygoat.com>
In-Reply-To: <20240809-mips-numa-v1-0-568751803bf8@flygoat.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Huacai Chen <chenhuacai@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-mips@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=7544;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=/2vM9Jarepf6oyk/v8ZwnyJnwqhxSDzHMZeDhKKDNNc=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrRtufyXl1/oa+CcGhS45FRCtPr57Sanpn2xlUznlfijO
 atJdvG5jlIWBjEuBlkxRZYQAaW+DY0XF1x/kPUHZg4rE8gQBi5OAZjIR0aG/6H7Or/e+VDeLea9
 xmij+r6Ga/kvu285pj4PO6GroVxyzYThn+IB/1MRLFyhLyQYIpxmbBcW6k4Xdzr09UibiZRFaqI
 VBwA=
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


