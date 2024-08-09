Return-Path: <linux-arch+bounces-6138-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B49F94D73B
	for <lists+linux-arch@lfdr.de>; Fri,  9 Aug 2024 21:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD83FB2347E
	for <lists+linux-arch@lfdr.de>; Fri,  9 Aug 2024 19:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6EF1684AB;
	Fri,  9 Aug 2024 19:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="YC7TOh2Q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LCKy1Ho9"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D191166312;
	Fri,  9 Aug 2024 19:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723231512; cv=none; b=rI1dG6RAZJMQ7pYgCJHTTVQ3IIugKiDc0JToRzWfBmMQYgjXXaMTOYo1r3V1goBeuYcEL7cTmtP+nrajh+YtM+lR07YymEgwBf//bO9Womlq4xe35GIL0xHbpri8uDZ9iGtMoON7VI5pDBMDbeLKzWzu+3jHFNOQOwetTrfWLZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723231512; c=relaxed/simple;
	bh=+ejYp7maBb/oUUXF+jD1Nmv9exkAFT7PhKXpA9pkTKI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EwTKQLdrIV7yf8NnmTAHKYd2HtNsMUTMIklxw9Hpsg1TKAZDDhfAdsyTngCI4ba85zktGmyaFNjsyleU1sIQ2jaHxGyYtXD5p3NxJQgtSON/ZnG3LcxxqVgexMarRBQXWhSiV5H+tsMY9yxot/H4KkJ4VIjVqd66uuuZHAuRpl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=YC7TOh2Q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LCKy1Ho9; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 3404F138FC56;
	Fri,  9 Aug 2024 15:25:10 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 09 Aug 2024 15:25:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1723231510;
	 x=1723317910; bh=FjgaJBEUF4kGFFxF8k99q8oZGLiVdvrhufwANUqc7y4=; b=
	YC7TOh2Qr+OgBz9NvWJcCb3lHgTl6UPdyeOL5GuXgcZGo4fbkZoyt4UH8I97krBq
	1qO+giF2Cb0VEz8JLDYK5sxqXHnxY2r1yD7EuXbpYwSn8le4IdsEFqSm7TQMIXvR
	4Pxt5n+CXd5/eGC5tWOPXXBSXtIUy4ykxDS6m9WUDi7K0xe0qweH0kijQxtS528H
	gtuxfghNLVqhc7oiLecv9cSnG2enkzyuODtKPaFv47F/fmCd6EqHzlfwYvlAi+Ea
	drqI3x5r6n7Veq8jIW6NsDas1No7x6T47tj5XMaobTUbvhU6PxvddNeOPF9D/OvQ
	bEh840LqL+dT+jjqp4uEaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1723231510; x=
	1723317910; bh=FjgaJBEUF4kGFFxF8k99q8oZGLiVdvrhufwANUqc7y4=; b=L
	CKy1Ho9ri/ak3uczziaE43V/rvzd7vAscHshnuupgRzdfWp6gQSeJspxZZPS//3L
	i603T0f5QJHP2L1LRkER78jREyBssIq+a6SMsbtrG7/50VQRyUJvVHefyZnIOKZz
	7c62IBO6hm4AgXPE7kDG2vIdWmSjWJjORGAphtpRCGkNnAswX0w/Ul84EE8xHF9A
	/mnNQ63HK7KwxU/gEn/PcZramtOyfvLAajzNGTij+nFepSEo+nDFHFqCEMyh8kSh
	i7dBzExmkuT54oUhp4mFYqZ8JFnKD01ExvMznF+EA98OhqStwrPi2d82snQMK8qz
	DO4VYR8e6Evct9wGaaG1w==
X-ME-Sender: <xms:Fm22Ztgrq-uzfAr-lECU7NDvqOowkwEOPuABvmoqeYYqtMhifuWzdA>
    <xme:Fm22ZiDXWyTmtLVZ_4MlxNkSwihyYfL4KiDrVQepVeCfkLVau-1rPz72EyIPZe1OO
    zGiGE0BgkX7TnVW4l4>
X-ME-Received: <xmr:Fm22ZtGwQQcL-KYN9DYhcezyPhI6IKEX6ml2_pBkWMMHAitNK91KA3kSRwck1x0_TA>
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
X-ME-Proxy: <xmx:Fm22ZiR7Y59zLP6UOEyTxIaDyh3whQ7rlAF8S7CLYVzSrA4CCj-fWA>
    <xmx:Fm22ZqyKcTcWNQD4BJ7F7bB5INcieHvK7tFUP3vL-hOz_zTtoKOJig>
    <xmx:Fm22Zo4vZR3mq65aFBty9BztbamCW9qzDYhoqSXaMKIxNSTeRkvf6Q>
    <xmx:Fm22ZvxkVNp1wa63v779yjFioIlHqUZ_ihSi4lJgM20Vf7kfjHbegA>
    <xmx:Fm22ZplvchGK-4ZgLA8olkoCP8vRzk_3rfdKESXF1GiN8prSrT19CHxM>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Aug 2024 15:25:09 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Fri, 09 Aug 2024 20:25:04 +0100
Subject: [PATCH 4/7] MIPS: mm: init: Prepare for arch_numa
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240809-mips-numa-v1-4-568751803bf8@flygoat.com>
References: <20240809-mips-numa-v1-0-568751803bf8@flygoat.com>
In-Reply-To: <20240809-mips-numa-v1-0-568751803bf8@flygoat.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Huacai Chen <chenhuacai@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-mips@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1793;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=+ejYp7maBb/oUUXF+jD1Nmv9exkAFT7PhKXpA9pkTKI=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrRtufzf/jCYK16smWg2o5HTbuoPz9Yuvnw9lbpXBSYHl
 /lfq+PvKGVhEONikBVTZAkRUOrb0HhxwfUHWX9g5rAygQxh4OIUgIlcnc7I0DFN7mC64YINjySS
 HKTl8uTWaR/uFtHtfGWd/NTpVqftP0aGlohtZ/5Lhn9e4dEqp9guFmL1fHaJ8btz6VPPCx7s8Gt
 jBwA=
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


