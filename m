Return-Path: <linux-arch+bounces-6159-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2245D94E9FB
	for <lists+linux-arch@lfdr.de>; Mon, 12 Aug 2024 11:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46F091C21641
	for <lists+linux-arch@lfdr.de>; Mon, 12 Aug 2024 09:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5695916E899;
	Mon, 12 Aug 2024 09:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="Kv5025fT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P1hfbfwo"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD69816D4D9;
	Mon, 12 Aug 2024 09:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723455454; cv=none; b=o+Qv8VRkv6UXpYkWAKv9wJXfb/UpjTih+KkK9fWs+UyDWYTyz7X79ytT3PcGbbVhBv3s1iIrJQxB6mbwEb06luWnW0fyVD5610QsVpwgUwsbiz1JVWK3f9GA3YzpMbp+2H/P8saNehGGlLV2zH7hdIx1Fdj0RJ/ZTZuqmaOvN74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723455454; c=relaxed/simple;
	bh=RY/FthAtkr/nzzBX9lGQDyrUaVP6XUjtTRqG+7Y42O0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=koT+rf1GhGT8y+Lm2gAiHQUQNuNQNAkeaa7Ubr5C+PBCA7Fpvx1EQ29w0gQJPbRd8MxrQmJU3ckLeKZP2ySmu+QMFGoe0rWMhmQTMyTFJfvAaD9ksyKMv7+D6l8ZWZExvpNva+lUR1wZR6DPx58sh1uPbZmEqS8hFYskDRNSh8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=Kv5025fT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P1hfbfwo; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from phl-compute-04.internal (phl-compute-04.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 5780C114AB5D;
	Mon, 12 Aug 2024 05:37:31 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 12 Aug 2024 05:37:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1723455451;
	 x=1723541851; bh=Qvz55kKdJIbJNrXhcKsilfBcMcr0pmQRWrdGCF4uAkU=; b=
	Kv5025fTsj13tARNHv4wveSyK4yJu5IMoByFxmDjlk2CjbW07yDDVTk6GBoytqt1
	g+qo5lIo50ROFU9AGhqvwJAQxN3zPaD7h1mXHVgvW7QHRVbU5ff9N7RdZriMOqSY
	9AcrGaGGjhMtQ/TdHM++EJppgxkugolB1Dt4F/2pQDQFx6o13Mvbc55UBfl3hAlI
	z3brPwiSmoNlBepR6lZFPjjV14GSKdLqyjmTrJLVW5/rYyvwfxSMG0vmUBY33B1E
	Ul/W7wmXa2yQzASuQ2lZpKEDj6yzQ4/+0Ht/AfBJMZBNxySnEaEmQAuapNO2BSUK
	+27Cf1vDSQQSLxrEPqgAbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1723455451; x=
	1723541851; bh=Qvz55kKdJIbJNrXhcKsilfBcMcr0pmQRWrdGCF4uAkU=; b=P
	1hfbfwoinAaOb5D/LJBW1kCX/XHh2HtBLzXiEoh420fWIzsEiWs574fraRgWZhzK
	NiOAvYk3rmfQ/FHEgI6J6rydvjSMFRlMOkAXCFZm2tNLgkwYl3dfivzujx9oZyIF
	j+TbrOrxmy0EEblw6DaDtG5/pcIS5TYgNze7Tz+ncgBhJlyfsSWl+npAPbCP4+a+
	pVCirzitlk/ivOPLVVOYpbyMfLsGrJ7O/2SresZJ3Xchl8JXqoXw9xET0tPgpr9L
	RwZAR/UqIbekAdpCUkqhq4194pBhDQzH3ugUkedFqy1RnzSuPyab0zbYqZCcOWnf
	f6n7ScH6/br1D4tDiT54Q==
X-ME-Sender: <xms:29e5ZkUzHUqb5E5rJNSLv9ue7CpIkl1mV5GqwzlMNPpw7UQOo6banA>
    <xme:29e5ZonuECz1qNmyG1FvPMkjQ-zWrzQPtrKlkIwyLfG3gurrcrG67wRBKGlt1QaFe
    dUkk7H75AdLG407SpE>
X-ME-Received: <xmr:29e5Zob-MKWNfqK_Y_u3X2Dz3VW8ioeXcwaQmdHdod3zKDERk8hsnrR8lq5b9zIPKg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddttddgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhi
    hgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffek
    gedugefhtdduudeghfeuveegffegudekjeelnecuvehluhhsthgvrhfuihiivgepudenuc
    frrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdr
    tghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    eplhhinhhugidqmhhiphhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    tghhvghnhhhurggtrghisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqd
    grrhgthhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrrghfrggvlhes
    khgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghrnhgusegrrhhnuggsrdguvgdprhgtph
    htthhopehtshgsohhgvghnugesrghlphhhrgdrfhhrrghnkhgvnhdruggvpdhrtghpthht
    oheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:29e5ZjUv9HbkDAzD2U6y48Nbbg9SS6fT9meWBDrczr0PKQcTFmEyww>
    <xmx:29e5Zul7gb8vU1Wx0f4gOSFLcfofYIZXGuIaw0oQ6fCiEONyVteZNg>
    <xmx:29e5Zoe0J6k7LqWTLyjLEtlzMYRlMIBoVLp3UPuLxZ1EzJolaSrc2g>
    <xmx:29e5ZgG5KqOhSXJZheXe3cv4r5btEjdZcz_GSU-R7Bz_qWjcLXBp4g>
    <xmx:29e5Zo6U1B_k4RXQV9X637e0dDlR0EEFzgrF7cCXo2BVa1tJFL5pMKbU>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Aug 2024 05:37:30 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Mon, 12 Aug 2024 10:37:20 +0100
Subject: [PATCH v2 6/7] MIPS: generic: Make NUMA available
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240812-mips-numa-v2-6-fd9bdb2033b9@flygoat.com>
References: <20240812-mips-numa-v2-0-fd9bdb2033b9@flygoat.com>
In-Reply-To: <20240812-mips-numa-v2-0-fd9bdb2033b9@flygoat.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Huacai Chen <chenhuacai@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-mips@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1336;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=RY/FthAtkr/nzzBX9lGQDyrUaVP6XUjtTRqG+7Y42O0=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrSd1y+12u7uaQspXpa7ofZB0O65yYKyRxles6+6Ptcjc
 MbljXfdO0pZGMS4GGTFFFlCBJT6NjReXHD9QdYfmDmsTCBDGLg4BWAis30Y/tm+7ZGseTJ7Qbjp
 mWVPP92apDmxyb1kx0buCxZfysXLJ39g+B+z/qDW5jXTpaSSppuWrVw5zW0Dp/+jGDWbb0WnO8+
 umMQBAA==
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


