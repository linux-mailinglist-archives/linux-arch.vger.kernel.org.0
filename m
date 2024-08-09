Return-Path: <linux-arch+bounces-6134-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A8E94D72D
	for <lists+linux-arch@lfdr.de>; Fri,  9 Aug 2024 21:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6EEC283234
	for <lists+linux-arch@lfdr.de>; Fri,  9 Aug 2024 19:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FBE115EFA3;
	Fri,  9 Aug 2024 19:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="mlTp0Gb9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eNDuJbAl"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF8529CE1;
	Fri,  9 Aug 2024 19:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723231508; cv=none; b=TNb3IDpdIjZv7oMh+CwmJ6okoZ6DGl9thYUTHvyNAN2r4ES0hLgB6pQQXo9A+BQw8lCkFleTqxZBz7fG3X1NDxZkXKziIyjL/Idp7C2iJRC0FSLjSB1fALVGLv6dtUgfIjQ6t+ELFDsKZVXXEmSMirj8TI0fhluwOU/7vW0Q2P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723231508; c=relaxed/simple;
	bh=dLse45f0Y/r6aYazJTjVLZujpjzO+wRDSgsZpV4WXQg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ctiYNFn442hRTwk6FfQeBkrCJWz6FhrzTnXmrbVMoNgDSKhFgEE7tp5ReQk9eJJa6q0wqRGLNPKVAXOCoNPdCMS6zRK9AsVy5HSxsK1hAlcqCKGCPXe5KocqsxH56G0DSlr19YreRp2/kq/8AMGsDydkatEnwGmmANLe8W+5KGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=mlTp0Gb9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eNDuJbAl; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 08C06138DD84;
	Fri,  9 Aug 2024 15:25:05 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 09 Aug 2024 15:25:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1723231505; x=1723317905; bh=3/
	X8xr20DmbMYTocfx25oo9rVKmKK5I+3ao7EXk+ioc=; b=mlTp0Gb9oEyn2Zwr3u
	e2kkz6P47RqlQFInMZUaAsv8mN1TcRNhAujGPh7MYvuQIL8qOMdPdIbfD+V/vQRG
	uxSmuj9csB1bly/LjQuKWYhvXotpxa2rzrwI1/674FDhKT9HQGULEl8VxF/UzCmi
	Fz34BeIqp09a6QuQmUclRblFm2ROeDjt/OMprbz9Me5ocsYOac3pKLW9w4J/thS3
	Pbr9wb2U4I1QbOTrWr8IXuMYTRHVStOFSieZ3PyQLGx8qAhJUp0UQhs2W2Eh6cid
	fWXj7AjoStcnzUcweox4vIJj3us+GRePs/I0YMcqemtsDv8x68Ry+fk7hoCLN0Wv
	8/tw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1723231505; x=1723317905; bh=3/X8xr20DmbMY
	Tocfx25oo9rVKmKK5I+3ao7EXk+ioc=; b=eNDuJbAl9UUGUZw5KZzLJaTQ8q88t
	1PLI4a/msg87dVJz1r930wVhsSnDbofK2OmNuBb8KyegueATnzP/Ktze6EDeED1a
	kljYTL3cYqUTxeMzbIIrrKcEPVdSG6kQaZr2rqtJL9DoheV1buwn3lKYH45K11nL
	p4ndeWZNq1L/Oo4lpGv2yJ89TMv6HZR2XZlMDAxSPYJapwzB0ktK9UOUMJ9Z7t09
	T6Nie25C5LzpnKWGY1tlEj65INWLdgVGyq2Y/kimm8QJeDoCFHrSYJKo/i8ZXMpc
	T46MdxMZYmQE6Lb7fJWL3dUd4C6clJ5icvyaBur+uI13rcV8j8NoFCbig==
X-ME-Sender: <xms:EG22ZjnMqR5LLNKOsfRB2wDgj4jDO2xG7npwvDeZq6wV-sthWmZKXA>
    <xme:EG22Zm1GSZZL-DcXUbXPQKZPRDrCCH0bFGDIl_jlRsvVJYw5kIw3p1l84TmzYTh5q
    -h5aYc-i16TmmAWVZg>
X-ME-Received: <xmr:EG22ZppCVTwXu8kox9BcCH2MFfXs0y5dAx_B5XSaBVzgg2khAf7591s_Y5mE4IQ5cQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrleeggddufeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffufffkgggtgffvvefosehtjeertdertdejnecu
    hfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgoh
    grthdrtghomheqnecuggftrfgrthhtvghrnhepudffffffhfeuheevhffgleevkeeugeet
    feegieeijeehfeekheekveduveeigeeunecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtgho
    mhdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprg
    hrnhgusegrrhhnuggsrdguvgdprhgtphhtthhopehjihgrgihunhdrhigrnhhgsehflhih
    ghhorghtrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepthhssghoghgvnhgusegrlhhphhgrrdhfrhgr
    nhhkvghnrdguvgdprhgtphhtthhopegthhgvnhhhuhgrtggriheskhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheplhhinhhugidqmhhiphhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheplhhinhhugidqrghrtghhsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:EG22Zrkj_4ChEpb3xRiYAWeWLkDIBEKv_3Y6JKaY69lMz03Wg_qOcQ>
    <xmx:EG22Zh0wir9c1ZTnWuwxN8RVXMD3Yn7AIBHhIMsbEJfQdZ3B4WO7Xg>
    <xmx:EG22Zqsms7Yl5k69nRBqMqA79005_eJz7EQ54UAvt0IQ1fZBGR_7YA>
    <xmx:EG22ZlWqRiEPXCb1vAi8HUslrnqJjo0vCD4BqH5c0j0-p5xVD5-_UA>
    <xmx:EW22ZqIFoiHLZpQpTQiMq27AzYYnxOly9aOQCxGG1U82T8BCbNMYfiHI>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Aug 2024 15:25:03 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 0/7] MIPS: arch_numa enablement
Date: Fri, 09 Aug 2024 20:25:00 +0100
Message-Id: <20240809-mips-numa-v1-0-568751803bf8@flygoat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA1ttmYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDCwNz3dzMgmLdvNLcRF2z5OSUFBMLI0MTwyQloPqCotS0zAqwWdGxtbU
 AR+k0HlsAAAA=
To: "Rafael J. Wysocki" <rafael@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Huacai Chen <chenhuacai@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-mips@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2334;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=dLse45f0Y/r6aYazJTjVLZujpjzO+wRDSgsZpV4WXQg=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrRtufz39sXN/m4Q25OTZ9IU8E5d5vtLvf0hwkKfGbclf
 1fl/Lqgo5SFQYyLQVZMkSVEQKlvQ+PFBdcfZP2BmcPKBDKEgYtTACbyxpnhf/Azpm7HGNfexF9q
 h5bMknx5IOfO/PIFy1gUnq4qFZt2v4Dhv+tvm1vdAq839x6qPafRMCmZb7V1fozwNN5Ye/agyV9
 vsAMA
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
Jiaxun Yang (7):
      arch_numa: Provide platform numa init hook
      MIPS: pci: Unify pcibus_to_node implementation
      MIPS: Prepare NUMA headers for arch_numa
      MIPS: mm: init: Prepare for arch_numa
      MIPS: smp: Process NUMA information
      MIPS: generic: Make NUMA available
      MIPS: Loongson64: Migrate to arch_numa

 arch/mips/Kconfig                                |   4 +
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
 arch/mips/loongson64/init.c                      |  27 ++--
 arch/mips/loongson64/numa.c                      | 158 ++---------------------
 arch/mips/loongson64/smp.c                       |   2 +
 arch/mips/mm/init.c                              |  14 +-
 arch/mips/pci/pci-ip27.c                         |  10 --
 arch/mips/pci/pci-xtalk-bridge.c                 |   1 +
 drivers/base/arch_numa.c                         |   7 +
 include/asm-generic/numa.h                       |   1 +
 23 files changed, 155 insertions(+), 230 deletions(-)
---
base-commit: eec5d86d5bac6b3e972eb9c1898af3c08303c52d
change-id: 20240807-mips-numa-6ccdd482141b

Best regards,
-- 
Jiaxun Yang <jiaxun.yang@flygoat.com>


