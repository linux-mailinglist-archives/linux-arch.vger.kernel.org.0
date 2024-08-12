Return-Path: <linux-arch+bounces-6156-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6E194E9F3
	for <lists+linux-arch@lfdr.de>; Mon, 12 Aug 2024 11:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C835E280E8C
	for <lists+linux-arch@lfdr.de>; Mon, 12 Aug 2024 09:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 347EE16DC3C;
	Mon, 12 Aug 2024 09:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="BLJqopz+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UOuD/2bZ"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F3716DC03;
	Mon, 12 Aug 2024 09:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723455451; cv=none; b=jssCq93SF7iwrqeIMl4WITJFfG+AroUpuKxuvPQw6NmBpuTfPcF0ncHYTu7A4ywcP/K+1PD+XlhEVVOQHuAkWiptVVbw8ng3oh6vUkjFfppzUaYZhHY466TaGr+QSDz3+E8lCLilYBQsv5vBTD1/VIAawkLRcLu+HfG+bjrfhJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723455451; c=relaxed/simple;
	bh=+ejYp7maBb/oUUXF+jD1Nmv9exkAFT7PhKXpA9pkTKI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sG7LGofUJ8DfCXe5c0mWkT4OQ+I/31TyXtbiPWM1EWnKp9vgeZgJ3ZvNur6m1YdCu87ihuUEWKfLAZvMLA0w3D2XSEjlBqIHTqE1ofRe4bTAw660OWHgbUCIrPcRzeIK6Kh9BIuNGPeQl25zjaGCgFnhJH3I7w2LhdAMg29lWp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=BLJqopz+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UOuD/2bZ; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from phl-compute-03.internal (phl-compute-03.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id BD092138FDA8;
	Mon, 12 Aug 2024 05:37:28 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 12 Aug 2024 05:37:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1723455448;
	 x=1723541848; bh=FjgaJBEUF4kGFFxF8k99q8oZGLiVdvrhufwANUqc7y4=; b=
	BLJqopz+goXZzrbkhmXtiI6bsNKwpBroCNCrQOBod2zigeUz1spvQaOj8ENMdMu6
	kjwYOsFfS2LF2dRxOZQAr2EJ4QCesMzPpKo0A16vyXFNWaxCamf+xZdmO+FViMBE
	nH2nyZEvdjwcUzUWvBx9PupbVRqTPVwln1WPNR98o4Eq3U9+fXX5D3eRybp8yuz/
	U7qRLniStxBh0pFbTdntn16LB869dRIkt4Ids3PhdAFI8AXv5LK8AP6XglshLX2P
	iGoZU0SOAmQFX5AjYo/SC3PVEtEmSvtPror1El41/0h9sZIBPo7QJ9CbsRgGXD9p
	h/Os5l0MhPrNdGcR8CbGbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1723455448; x=
	1723541848; bh=FjgaJBEUF4kGFFxF8k99q8oZGLiVdvrhufwANUqc7y4=; b=U
	OuD/2bZslsgPMv19AlhmpmQdFdCdBuDM7/II7kycRRAbPa59jk0g7WKxoYWK9snG
	yT+RglJy+VZKnbIRW7Bc+ysYZxPKi0m53Wd9Mt5PC0fpsLGuH15LiKnxq3URhJNM
	6/7j2B8hDiFjzkHgXgxqtOdozyTVL/VGYbzM/NQf4DkcsEzeMNRheV6LVLysqKqU
	+L5fHA8vCP9JtdPsN71mWcp/4rLDajKLifJrYHk6duoNJiJPq1nI9U/KgQZIPhEa
	iUS5sQK5gu+sYN8dV4rH5BWRPQ1KF0nImqgWQRyO9Gu5Z5Tj1gt3foR8xzutO23W
	QrSYiZoyA9KSJ01iUFu4Q==
X-ME-Sender: <xms:2Ne5Zrziq9idYpY1MCS1J2XtptTrAicDb0AuEAdo6YoItsyeseSEdA>
    <xme:2Ne5ZjSOKgR83ibO7LwsCTfmnk3Kcj-hhUg3AlzT91BexS2kvnB8-_TA6xmenuIgV
    TCLO3BROeZFOLRzXh4>
X-ME-Received: <xmr:2Ne5ZlWcMSnl8xh0Rj73bKKX0ih6MHNaOIfwnrWM3s7Z16eliYRcSofP7kK630XP7A>
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
X-ME-Proxy: <xmx:2Ne5Zlha0zXWORmCTJ9P3S3uEBd_ail0C9nUHQ0f3SK_RdpcQUrkEQ>
    <xmx:2Ne5ZtBLjKMVG0x4vevbR3cO25uUPzemZ5vaMl9sNsMwWOsVpQeyQQ>
    <xmx:2Ne5ZuLDf3NJ6Tizdw-MwHZXYcnZCsn-hXlKStzsiBMQx5b2R4rpJg>
    <xmx:2Ne5ZsAEWfpmeoE_Ib0GekQtAACJiTwJAMOfmH5VP_HfFC8HuVhVOg>
    <xmx:2Ne5Zh1EBMcCX4td8hI0RBSBjazsAFrcpCPRx-iaa4XEMPLnyhNG2Jlb>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Aug 2024 05:37:27 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Mon, 12 Aug 2024 10:37:18 +0100
Subject: [PATCH v2 4/7] MIPS: mm: init: Prepare for arch_numa
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240812-mips-numa-v2-4-fd9bdb2033b9@flygoat.com>
References: <20240812-mips-numa-v2-0-fd9bdb2033b9@flygoat.com>
In-Reply-To: <20240812-mips-numa-v2-0-fd9bdb2033b9@flygoat.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Huacai Chen <chenhuacai@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-mips@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1793;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=+ejYp7maBb/oUUXF+jD1Nmv9exkAFT7PhKXpA9pkTKI=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrSd1y957ox94R72fO99edHSunmnpu7jZxK40HLzdfZiR
 btDQtrXOkpZGMS4GGTFFFlCBJT6NjReXHD9QdYfmDmsTCBDGLg4BWAibqsYGaZlLWR88WhRtOpX
 qS0zPsfNUZ4m6n8lpSt/65kdKfP7+KcyMszw3LhsZ86jA7MeRvWJu/46qsyjy9i26N/jxT2f4zg
 fpvMCAA==
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67

Opt-in various mm initailise routines for NUMA platforms
with arch_numa enabled.

Loongson64 & IP27 have their own implementations but arch_numa
is fine with the generic implementation.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/mm/init.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index 4583d1a2a73e..4d7d5e817939 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -401,7 +401,7 @@ void maar_init(void)
 	}
 }
 
-#ifndef CONFIG_NUMA
+#if !defined(CONFIG_NUMA) || defined(CONFIG_GENERIC_ARCH_NUMA)
 void __init paging_init(void)
 {
 	unsigned long max_zone_pfns[MAX_NR_ZONES];
@@ -424,14 +424,14 @@ void __init paging_init(void)
 		       (highend_pfn - max_low_pfn) << (PAGE_SHIFT - 10));
 		max_zone_pfns[ZONE_HIGHMEM] = max_low_pfn;
 
-		max_mapnr = max_low_pfn;
+		set_max_mapnr(max_low_pfn);
 	} else if (highend_pfn) {
-		max_mapnr = highend_pfn;
+		set_max_mapnr(highend_pfn);
 	} else {
-		max_mapnr = max_low_pfn;
+		set_max_mapnr(max_low_pfn);
 	}
 #else
-	max_mapnr = max_low_pfn;
+	set_max_mapnr(max_low_pfn);
 #endif
 	high_memory = (void *) __va(max_low_pfn << PAGE_SHIFT);
 
@@ -482,7 +482,7 @@ void __init mem_init(void)
 				0x80000000 - 4, KCORE_TEXT);
 #endif
 }
-#endif /* !CONFIG_NUMA */
+#endif
 
 void free_init_pages(const char *what, unsigned long begin, unsigned long end)
 {
@@ -519,7 +519,7 @@ void __ref free_initmem(void)
 		free_initmem_default(POISON_FREE_INITMEM);
 }
 
-#ifdef CONFIG_HAVE_SETUP_PER_CPU_AREA
+#if defined(CONFIG_NUMA) && !defined(CONFIG_GENERIC_ARCH_NUMA)
 unsigned long __per_cpu_offset[NR_CPUS] __read_mostly;
 EXPORT_SYMBOL(__per_cpu_offset);
 

-- 
2.46.0


