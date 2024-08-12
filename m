Return-Path: <linux-arch+bounces-6153-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20DE194E9EA
	for <lists+linux-arch@lfdr.de>; Mon, 12 Aug 2024 11:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7278BB20812
	for <lists+linux-arch@lfdr.de>; Mon, 12 Aug 2024 09:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8864916CD3D;
	Mon, 12 Aug 2024 09:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="WX7ZY6UM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PadxE0TY"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCD120323;
	Mon, 12 Aug 2024 09:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723455447; cv=none; b=HOHJezXDwOY615190Udluyu59gSKjUFBpUfY3pZDscyLn8DssH9rDfT8nSd5p8XD45oynz6czYbmm5emNrkmbl2VnQKMS1xF/T0e9y1ALzEDWFiMcToLzDvI05GLbBDeoBaFjAzJyeNeRfolrl+bbOjffYzBv3QeAOcpU84VSvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723455447; c=relaxed/simple;
	bh=l3vFiyDfS5OlYid1lRIhy3ppAAY2nz2gB/IJ8Owqvn4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jbqcN/YZlMQ2W3z8DeY8k1YdQtwz+VOVSKVCe65hF7SaZiXyCr3OJCp0XYHB/Dk3QXqoHwr6CDKoGgJJOIvqaDlghcAo7qL4/1cy8kY0AnSQRGidI2AokKWqrpL2NIwTWaA9EeP/Fgm5RvT7Tg7cGHT8EuyaHXDg+j975gbamyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=WX7ZY6UM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PadxE0TY; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from phl-compute-03.internal (phl-compute-03.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id A7C3F1382998;
	Mon, 12 Aug 2024 05:37:23 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 12 Aug 2024 05:37:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1723455443; x=1723541843; bh=qE
	cVq2E1HC4dTQQWILZwFzSh/d6pUjYS7xMcCE3J20A=; b=WX7ZY6UM97GBAzQNRP
	Alf1qA/S1HnMhMNU4HQKH71f1sqOpA2OGvnU7+VJ7Q/7kIXK+TGjTlZR0CZvZM53
	El5uxzV4ats+9/LUQg5tQfNAWiesWq8vjxaGwnKqTnIVr+fbLrCkLRShdqNEjqgp
	VYh0b2dTvy/+mdPvkXf9TaTbXD0DK5CZCyXlPrMlDb2G/izI90EnlK6CAZMpf84P
	OX6hmrpE6qlGo5UpZ3GG1M/2AHXuS1CD4Ar3aKkT2NmfsAtHUVCRadaPdbly+0uJ
	HKkEBnqBkID6eAzl5CpItI6tBM5yWwBrFfk6o3EQsAdCdbT7cocrMe1fbETcLI1X
	T4iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1723455443; x=1723541843; bh=qEcVq2E1HC4dT
	QQWILZwFzSh/d6pUjYS7xMcCE3J20A=; b=PadxE0TYmRgSgbWIhmE3t9IbtCUD6
	M+XQw/AbyQ6ClaYKYt5juAuby0gk2M/ipfcZKTYnGB109CloIOzA1CBl+/oznx29
	VG0H63gI3uKt5mNCNpC+OTC3ib79m6JVAStPqaFwa6SkqE3VuV+g/ZrDpHIbdxjp
	CluHR7BdXN28jBaOmtPssMhESWW+SW9s6WB/1rOb4SjHEPqIyOyFGKj+fX7viTCk
	3EXGDLdtcja6jAVy2qiQeTUqDseFK05rnE+0W6td7F28PN0JcAMlPWdE0P6nZhR4
	5ptyXTpEKB+QfxdV2icBl+HHpIGnaHP1jWz9wIjo1GyodcA+asgAnJd2Q==
X-ME-Sender: <xms:09e5ZsNdtt5A7cs0gGtYQaQyKQ4hkQM8VDLQjLlX-b7SNPqLSqxAeQ>
    <xme:09e5Zi86nX3Kd5A-ueeoibdWFyre1pRYfp8NTp2TG93YHGKkzGD934aFr3kF9BUq1
    OsyUt6I_c9jwmZx7C0>
X-ME-Received: <xmr:09e5ZjRY7Bp8AojkY6Wl2xrTyT6bzpF9_q3XQ3AbsXVhUC2nrGjnspCoAb6O-dppaA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddttddgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffufffkgggtgffvvefosehtjeertdertdejnecu
    hfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgoh
    grthdrtghomheqnecuggftrfgrthhtvghrnhepgfevffejteegjeeflefgkeetleekhfeu
    gfegvdeuueejkeejteekkedvfffffedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrgh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgr
    gihunhdrhigrnhhgsehflhihghhorghtrdgtohhmpdhnsggprhgtphhtthhopeekpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigqdhmihhpshesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopegthhgvnhhhuhgrtggriheskhgvrhhnvghlrd
    horhhgpdhrtghpthhtoheplhhinhhugidqrghrtghhsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhope
    grrhhnugesrghrnhgusgdruggvpdhrtghpthhtohepthhssghoghgvnhgusegrlhhphhgr
    rdhfrhgrnhhkvghnrdguvgdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjihgrgihunhdrhigrnhhgsehflhih
    ghhorghtrdgtohhm
X-ME-Proxy: <xmx:09e5Zkuys3pwttnYehfZ5g8hSFjmsiMtk5NKWCRfKnHFZp-yow150g>
    <xmx:09e5ZkcQGlR5jY6IPoFNw872nbf2MeIsi6PIkmWgBNEEosRD5X4Ciw>
    <xmx:09e5Zo1UE04hOJ7ii79xoCT1TFHWoc_TDMnpVshaOFVQ-ONVCAKFOQ>
    <xmx:09e5Zo8_y0YkuyF6Sksp18H19fQlZdp_08p3qTgIYhWeVMVppvr7dA>
    <xmx:09e5Zry18V0snQUMyckufit3xnK-Kc0ZOsa1sfwGFnmIya6F85QhXeNY>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Aug 2024 05:37:22 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v2 0/7] MIPS: arch_numa enablement
Date: Mon, 12 Aug 2024 10:37:14 +0100
Message-Id: <20240812-mips-numa-v2-0-fd9bdb2033b9@flygoat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMrXuWYC/03MSwqDMBSF4a3IHfeWJPWRdtR9FAeah16oiSRWK
 pK9NxUKHf6Hw7dDNIFMhFuxQzArRfIuhzgVoMbODQZJ5wbBRMkka3CiOaJ7TR3WSmldSsFL3kP
 +z8FYeh/Wo809Ulx82A565d/1p1z/lJUjw6qWTcUlu/RW3u1zG3y3nJWfoE0pfQC1NhfhpAAAA
 A==
To: "Rafael J. Wysocki" <rafael@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Huacai Chen <chenhuacai@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-mips@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2561;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=l3vFiyDfS5OlYid1lRIhy3ppAAY2nz2gB/IJ8Owqvn4=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrSd1y9N8pynufbOia9fd+u2JegruN3YOu/zPsHesG6Zd
 StmK7LYd5SyMIhxMciKKbKECCj1bWi8uOD6g6w/MHNYmUCGMHBxCsBE4j0YGXbeTJv0P7Uw4M3U
 9hzup15yG0xCtmeduHp73dZd/9a0/5Jh+GfHsSjTX2hu1YdLi3aK3pZV/z/R8NkOiysZzXs99lz
 YwMsAAA==
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67

Hi all,

This series enabled arch_numa for generic MIPS machine, and ported
loongson64 machine to arch_numa infra. SGI IP27 is left untouched
with legacy NUMA implementation as I don't have access to hardware.

Tested on Loongson64 NUMA system and numa_emu on Boston.

Please review.

Thanks

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
Changes in v2:
- Use Kconfig symbol instead of weak function (Arnd)
- Link to v1: https://lore.kernel.org/r/20240809-mips-numa-v1-0-568751803bf8@flygoat.com

---
Jiaxun Yang (7):
      arch_numa: Provide platform numa init hook
      MIPS: pci: Unify pcibus_to_node implementation
      MIPS: Prepare NUMA headers for arch_numa
      MIPS: mm: init: Prepare for arch_numa
      MIPS: smp: Process NUMA information
      MIPS: generic: Make NUMA available
      MIPS: Loongson64: Migrate to arch_numa

 arch/mips/Kconfig                                |   5 +
 arch/mips/include/asm/mach-generic/mmzone.h      |  11 ++
 arch/mips/include/asm/mach-generic/numa.h        |  11 ++
 arch/mips/include/asm/mach-generic/topology.h    |   7 +
 arch/mips/include/asm/mach-ip27/numa.h           |  22 ++++
 arch/mips/include/asm/mach-ip27/topology.h       |  12 +-
 arch/mips/include/asm/mach-loongson64/mmzone.h   |   2 -
 arch/mips/include/asm/mach-loongson64/topology.h |  25 ----
 arch/mips/include/asm/mmzone.h                   |   5 +-
 arch/mips/include/asm/numa.h                     |  12 ++
 arch/mips/include/asm/pci.h                      |  12 ++
 arch/mips/include/asm/smp-ops.h                  |   7 +-
 arch/mips/kernel/setup.c                         |   3 +-
 arch/mips/kernel/smp-cps.c                       |   6 +
 arch/mips/kernel/smp.c                           |  26 ++++
 arch/mips/loongson64/init.c                      |  28 ++--
 arch/mips/loongson64/numa.c                      | 158 ++---------------------
 arch/mips/loongson64/smp.c                       |   2 +
 arch/mips/mm/init.c                              |  14 +-
 arch/mips/pci/pci-ip27.c                         |  10 --
 arch/mips/pci/pci-xtalk-bridge.c                 |   1 +
 drivers/base/Kconfig                             |   4 +
 drivers/base/arch_numa.c                         |   9 ++
 include/asm-generic/numa.h                       |   1 +
 24 files changed, 163 insertions(+), 230 deletions(-)
---
base-commit: eec5d86d5bac6b3e972eb9c1898af3c08303c52d
change-id: 20240807-mips-numa-6ccdd482141b

Best regards,
-- 
Jiaxun Yang <jiaxun.yang@flygoat.com>


