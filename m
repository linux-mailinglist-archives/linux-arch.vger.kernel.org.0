Return-Path: <linux-arch+bounces-6154-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22BEB94E9EB
	for <lists+linux-arch@lfdr.de>; Mon, 12 Aug 2024 11:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0004280F8D
	for <lists+linux-arch@lfdr.de>; Mon, 12 Aug 2024 09:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02F616D4F9;
	Mon, 12 Aug 2024 09:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="YWRxtvtu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LXNA/x1J"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FC715099B;
	Mon, 12 Aug 2024 09:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723455447; cv=none; b=eV+eaxCtNhKKFb5qB578zQiRUKGyhPcLmsRTxsw5USLNgtgOSBLxwDtlt18oA8wA471jMPncs52cT6ZZR7RG6Ei6Qbv/j1ReVugpFgVTGMbXiHsrnYxHelYGCf5DvquonnGCAy1DhSntCD79yHy0OhzkP7O/cYjuNWX5Hl2Dq10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723455447; c=relaxed/simple;
	bh=HZtNM2iYdTDdJK9RBWXmVSgejXa+e7s20WbxWq/3ZHY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d4Od+DL1B/EV79g8zX3JUvyUSy4/fQ0S6qF9WtsHEhCc/sRq6tbtnfR3he9a5Sp3ChVnbEGY9VIVEBIi+/e5XuML+kgRCcnJfBW8UO7fBrAwF4G6YJR6pjNsu6zL57VaLqnONKWXUt5Rkah+oZC6pksNKSVFdEthEVWPs2O5LbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=YWRxtvtu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LXNA/x1J; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from phl-compute-06.internal (phl-compute-06.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id E42BE114AB6B;
	Mon, 12 Aug 2024 05:37:24 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 12 Aug 2024 05:37:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1723455444;
	 x=1723541844; bh=63VkM8R6TTBXVYCj/tQEl1CrLjl1cy5T2PmvGmxYctU=; b=
	YWRxtvtuRRFl+/0dABaEySxEMLxzAIOq31Vcqwk52a05HCcn8RpyW6xIxNIPQEHt
	fb5SBSsPy+O1N8ztVicXSzEXC3mgCgtHcVOi7bUQ6oaAvGifNFwgD7y0eS/g6ziR
	TK3WJOnVt+MsIA3k6r/2EZuM1NpQoXVtFPk+R0p2RbzEJsenO9sQxiEopFceIiQM
	BSshfaqobo6qU3KIanKBsJXwldg1g56WGjLZwrfw8GIDc+FRBPC8IcDkL0CipqwV
	xRvB7AdhOz7qsZET/HkISMWW01nI215vnXfSPtPpfgg/r6MxlxhZ/gTYGTwRc9lU
	AVAv/ZEnmPDN5JDuVsB1Gw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1723455444; x=
	1723541844; bh=63VkM8R6TTBXVYCj/tQEl1CrLjl1cy5T2PmvGmxYctU=; b=L
	XNA/x1Jtm0al2hkeTZF3C0EkIFieIhrtGqs2nKE+RED00Pv1ZYrRTf82JS0W3hJt
	fvPT3PQ9ybQ1b1KZtQQ5l+Q2BflxcakG2Hmw3M2D2ZTZZoup+JqWO5E1Dnoqq4ml
	EYRqviIcKN7nS/peTQg4k9iy09sRtsKhWvHQ4pgUbAEoqDVfFrk7ECwlReaqF8Io
	2FCNoaq0oiIPyjOjOYO8v0w1zOs585raBwxzCckWG5oCe/UAEKY6L/picXkGJ0Op
	n1f9pze2em7scEWD7cJ01syC5sym1lhHZJc5bQrocVt2uLSmymXt0nR9S7aJVJLr
	m9720iTPJtJnmuJ0fnRFA==
X-ME-Sender: <xms:1Ne5Zk7JRVFz8iFeBlG2x1wbW1rOTOucX7KkpKGTgfTxYVCICF_G7A>
    <xme:1Ne5Zl7mcM0dtj3Z5Kjgosyq_3vRP8fWaMLSxTmwfJ-idbJaNum90EgPuU5hhhXm1
    J5c50BD6ed65bvXpqE>
X-ME-Received: <xmr:1Ne5ZjfiEsKc3WKkarkwEmK9jFS2-kMrkxcIBJIHxsvnjwXO5qSGAG2DNzFWARi_-Q>
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
X-ME-Proxy: <xmx:1Ne5ZpIn3xqH21vHb370SIRsXAaOkOsWgrB1Gd__DQuRYSoNyMYEzQ>
    <xmx:1Ne5ZoLJbEHA3ZbS5vtyt7hmPnk4Ug_-pjY9GGrJtXLTidPfgArUYg>
    <xmx:1Ne5Zqw0G5kJWFgZjZXqEn4SyYSmtApcA-uVR3Ke0r70hbfIhx-zlw>
    <xmx:1Ne5ZsKGFcsVZXXLuDTJaH2kqxnZxLxVYJdynTENOZs_YWHoxv1vvQ>
    <xmx:1Ne5Zn_GKsXhZj2HS5m-yXne2G2Fgs02HLr5BjaDM44eoy_QO3SC9EQS>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Aug 2024 05:37:23 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Mon, 12 Aug 2024 10:37:15 +0100
Subject: [PATCH v2 1/7] arch_numa: Provide platform numa init hook
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240812-mips-numa-v2-1-fd9bdb2033b9@flygoat.com>
References: <20240812-mips-numa-v2-0-fd9bdb2033b9@flygoat.com>
In-Reply-To: <20240812-mips-numa-v2-0-fd9bdb2033b9@flygoat.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Huacai Chen <chenhuacai@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-mips@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2225;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=HZtNM2iYdTDdJK9RBWXmVSgejXa+e7s20WbxWq/3ZHY=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrSd1y9t+t7VMvfflPYDNjNzdk6btq5gStL+OfeOK243S
 /qrE2eypKOUhUGMi0FWTJElRECpb0PjxQXXH2T9gZnDygQyhIGLUwAmYsvJ8D/frnFBS7npvWuJ
 nxdk1L11iNXc2CazfY725FUMDuzflTsZ/hctSuvaeKxr9ZlUY88Nr/a/+qy23zj2VNGrfacdfM8
 sjGQAAA==
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67

For some pre-devicetree systems, NUMA information may come from
platform specific way.

Provide platform numa init hook to allow platform code kick in
as last resort method to supply NUMA configuration, and use
ARCH_PLATFORM_NUMA Kconfig symbol to gate that function.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
v2: Use Kconfig symbol instead of weak function (arnd)
---
 drivers/base/Kconfig       | 4 ++++
 drivers/base/arch_numa.c   | 9 +++++++++
 include/asm-generic/numa.h | 1 +
 3 files changed, 14 insertions(+)

diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
index 064eb52ff7e2..e169627b9172 100644
--- a/drivers/base/Kconfig
+++ b/drivers/base/Kconfig
@@ -231,6 +231,10 @@ config GENERIC_ARCH_NUMA
 	  Enable support for generic NUMA implementation. Currently, RISC-V
 	  and ARM64 use it.
 
+config ARCH_PLATFORM_NUMA
+	bool
+	depends on GENERIC_ARCH_NUMA
+
 config FW_DEVLINK_SYNC_STATE_TIMEOUT
 	bool "sync_state() behavior defaults to timeout instead of strict"
 	help
diff --git a/drivers/base/arch_numa.c b/drivers/base/arch_numa.c
index 8d49893c0e94..19be18b35430 100644
--- a/drivers/base/arch_numa.c
+++ b/drivers/base/arch_numa.c
@@ -305,6 +305,13 @@ static int __init arch_acpi_numa_init(void)
 }
 #endif
 
+#ifndef CONFIG_ARCH_PLATFORM_NUMA
+int __init arch_platform_numa_init(void)
+{
+	return -EOPNOTSUPP;
+}
+#endif
+
 /**
  * arch_numa_init() - Initialize NUMA
  *
@@ -318,6 +325,8 @@ void __init arch_numa_init(void)
 			return;
 		if (acpi_disabled && !numa_init(of_numa_init))
 			return;
+		if (!numa_init(arch_platform_numa_init))
+			return;
 	}
 
 	numa_init(dummy_numa_init);
diff --git a/include/asm-generic/numa.h b/include/asm-generic/numa.h
index c2b046d1fd82..53a8210fde00 100644
--- a/include/asm-generic/numa.h
+++ b/include/asm-generic/numa.h
@@ -31,6 +31,7 @@ static inline const struct cpumask *cpumask_of_node(int node)
 #endif
 
 void __init arch_numa_init(void);
+int __init arch_platform_numa_init(void);
 int __init numa_add_memblk(int nodeid, u64 start, u64 end);
 void __init early_map_cpu_to_node(unsigned int cpu, int nid);
 int __init early_cpu_to_node(int cpu);

-- 
2.46.0


