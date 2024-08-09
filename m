Return-Path: <linux-arch+bounces-6140-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 655E194D742
	for <lists+linux-arch@lfdr.de>; Fri,  9 Aug 2024 21:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D19F28345E
	for <lists+linux-arch@lfdr.de>; Fri,  9 Aug 2024 19:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711D216B3BF;
	Fri,  9 Aug 2024 19:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="Rtjs0aYZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NPy6tjut"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD36716A92B;
	Fri,  9 Aug 2024 19:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723231515; cv=none; b=ZzXjGdp7RiLg0jlZmVaOw9K/AnoXf67YwaMFdEenTO1/2W/YMDyYgAvJNEgD5tVf5gczih6E5d0xjDni8BGSQy3jPW0JAfb+1AygNSrOhbz/F55vJmSrp28OLhMIY82MO6f5DfHzDyA10X8eKgQzuZ4k38QYQosg/ZSQJU1Zn2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723231515; c=relaxed/simple;
	bh=RY/FthAtkr/nzzBX9lGQDyrUaVP6XUjtTRqG+7Y42O0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dQDQVfJRtKFvBjA+U8fNjI7DRWsrYj0hLdqvfIhTdt7W7bOREp9MbrmL9YsI+YiK1l6mM6qR2m7dkRZmcS99CVA7enTAbsyJkp05H8KnVjAoKe3dCmOdtqSXMwfdkGgjW+Ra8u1CZywnMn1nhIZJXOTLWSMuanDb2DN9Tf9wYZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=Rtjs0aYZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NPy6tjut; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id D1CE4138E768;
	Fri,  9 Aug 2024 15:25:12 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 09 Aug 2024 15:25:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1723231512;
	 x=1723317912; bh=Qvz55kKdJIbJNrXhcKsilfBcMcr0pmQRWrdGCF4uAkU=; b=
	Rtjs0aYZh+RywneCHHAR7LX8hkdgTh5l5OY8HxynRQGLa0jlG8YERozDlrubPUGK
	xWNRPrWBuDIQyfrmQsRXjC7nm/1TDO0NOQ0BJqmn+fOIA6u7Gb+OfxOHbGFQKRVt
	N4vxJHnEanialV2WqkRSdsCBTRY5VPuLFGnrYeFyG7hag+ov581WJhSISv62BVds
	plOgqQhcOhx8U/Pl6msKHbpZ2AKpBtTMxVniOq1KHuWrnwjyqMDMvWmjquYqfz1g
	mVCsVGZiqnYUAyMySSUMrC2G8WBIpulcoi5idw+LRZ0oZ7qQ200BIowfonWvVghy
	mhaGB75JoE3ImCSU2hySvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1723231512; x=
	1723317912; bh=Qvz55kKdJIbJNrXhcKsilfBcMcr0pmQRWrdGCF4uAkU=; b=N
	Py6tjutpqPHSd09r1YilZuv+ovS/STt9/P41bzSPFo6gQddKuU3e2vXLZ5DYBuUW
	9WWKLB/gbkzeQR6wbsOGd03m5EONcBnXH968eb459zz3/TxBE8SAzf8qrW7Kj1Fn
	Y8RIVK8+V85X4HlhPlbffKN+gqTfIVtT1ZmSXDrwPTL27gdhh3SPZTNgqd3IoGMh
	vvEyF4mUzZyDBaUm+nA1hAbwH9KLzh+rcakwcg8k9yYCrK89ykC6cM7207/+WG7I
	hTPrFzlK0U6xB0QBQe9n2kTCD2y8FBOGTFBBDzo+x89hXE4du75b2qo5pJPMLa1B
	rBzKyZQCGwPhRyTbzgzmw==
X-ME-Sender: <xms:GG22ZlCvTbMcY7wbVojchUt_qSUDx8P7Qjc7LvT3szVU4VgXkNz8jQ>
    <xme:GG22ZjihS2lAUjBy269Z2E05acpp6FAeI7Sroeb8gV3tonuyXGH1yGhbK1fS3elxg
    AgawwmqltB01fijJfk>
X-ME-Received: <xmr:GG22ZglNDO-36UcIYP8B3s8TkK7m--pGbRsPF-N9SRNNU_8vOmxSZwTsxidXjp9N8g>
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
X-ME-Proxy: <xmx:GG22ZvxOouxu1W4x3Zd76fi_DcH63OHr24hJBwsu9Y-4WKCRZrN-xg>
    <xmx:GG22ZqTNpSixsVefqzVxBhP4mkvLqXCOqrfuJfdgT2XZKWT4Ves-rw>
    <xmx:GG22ZiaDcJHpUjWLT-_42kAWW4LpRj96yU_6wQ9kmwDvsOMqiBMq6g>
    <xmx:GG22ZrSMYVB1iUCfgLGBeXopwT_cn-tB1MXE85wnc3d42Cc55UH7GA>
    <xmx:GG22ZtGJfEqn0XqlbS9MumVs__y23hZA-ytHjicTPt8_epV_ZGv5_Mkp>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Aug 2024 15:25:11 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Fri, 09 Aug 2024 20:25:06 +0100
Subject: [PATCH 6/7] MIPS: generic: Make NUMA available
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240809-mips-numa-v1-6-568751803bf8@flygoat.com>
References: <20240809-mips-numa-v1-0-568751803bf8@flygoat.com>
In-Reply-To: <20240809-mips-numa-v1-0-568751803bf8@flygoat.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Huacai Chen <chenhuacai@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-mips@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1336;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=RY/FthAtkr/nzzBX9lGQDyrUaVP6XUjtTRqG+7Y42O0=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrRtufwNF7L3HtJonnR/9RH5z4tOqB616xX89cP3vsa0v
 8K795lO6ihlYRDjYpAVU2QJEVDq29B4ccH1B1l/YOawMoEMYeDiFICJ8Ocy/A/+UrR919cqV9+H
 X66/7zIzu3t12i279pr3uqJR52cc3nSKkaE1QCnzse7XJwY1cm5PNbUTHGJiX/tLd+0sfHW+dm2
 DOAsA
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67

Enable arch_numa and dependent options for generic and future NUMA
platforms.

Enable SPARSEMEM for 64 bit generic kernel.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 43da6d596e2b..9284a06db2b4 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -140,6 +140,7 @@ choice
 
 config MIPS_GENERIC_KERNEL
 	bool "Generic board-agnostic MIPS kernel"
+	select ARCH_SPARSEMEM_ENABLE if 64BIT
 	select MIPS_GENERIC
 	select BOOT_RAW
 	select BUILTIN_DTB
@@ -178,6 +179,7 @@ config MIPS_GENERIC_KERNEL
 	select SYS_SUPPORTS_MIPS16
 	select SYS_SUPPORTS_MIPS_CPS
 	select SYS_SUPPORTS_MULTITHREADING
+	select SYS_SUPPORTS_NUMA
 	select SYS_SUPPORTS_RELOCATABLE
 	select SYS_SUPPORTS_SMARTMIPS
 	select SYS_SUPPORTS_ZBOOT
@@ -2599,8 +2601,10 @@ config NUMA
 	bool "NUMA Support"
 	depends on SYS_SUPPORTS_NUMA
 	select SMP
+	select GENERIC_ARCH_NUMA if !SGI_IP27 && !MACH_LOONGSON64
 	select HAVE_SETUP_PER_CPU_AREA
 	select NEED_PER_CPU_EMBED_FIRST_CHUNK
+	select USE_PERCPU_NUMA_NODE_ID if GENERIC_ARCH_NUMA
 	help
 	  Say Y to compile the kernel to support NUMA (Non-Uniform Memory
 	  Access).  This option improves performance on systems with more

-- 
2.46.0


