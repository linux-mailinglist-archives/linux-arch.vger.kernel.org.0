Return-Path: <linux-arch+bounces-2939-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A815687995E
	for <lists+linux-arch@lfdr.de>; Tue, 12 Mar 2024 17:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D51561C2166C
	for <lists+linux-arch@lfdr.de>; Tue, 12 Mar 2024 16:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A25134436;
	Tue, 12 Mar 2024 16:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="N1v+2M3S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NpKoQHpM"
X-Original-To: linux-arch@vger.kernel.org
Received: from wfhigh4-smtp.messagingengine.com (wfhigh4-smtp.messagingengine.com [64.147.123.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D18612BEA1;
	Tue, 12 Mar 2024 16:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710262237; cv=none; b=cmmp7V2pAhxfMkyG8Q1+w8UQ+gSCj49ThJnFspgt/gmkXsBgg5HH7jjwQ14FNaF3o5ef7nYyz06P5vhKOQk2txyMH3Iy5lRZ6DC/wpZsKw08VhKUzPkD18nFL+7dUf5VG/kAN+r7Np2kvu6JsTeotyHNF0pbe6TRx3YSa+o+gpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710262237; c=relaxed/simple;
	bh=zMVMZD++Xw9xE9a3A6ebUih4y5MNw3QJI955QGXTKfE=;
	h=MIME-Version:Message-Id:Date:From:To:Cc:Subject:Content-Type; b=QuaKPwYCc7bn0IDuACdTs3ZebGhgl6q2h/7aOUfK7m0NnE7ZCF2qcaLZDi+w7IvDxV8VQRAumG9CJ3D1mtItik5Mgy8/p1LYfmBHclcAEfVbaAiaIOYz6Gde5v6a9i+LCzx2GQkvLSDI7SuvVof0WrzIH6Uo+NYrwsr395mG0Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=N1v+2M3S; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NpKoQHpM; arc=none smtp.client-ip=64.147.123.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id 2BD6218000A7;
	Tue, 12 Mar 2024 12:50:34 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 12 Mar 2024 12:50:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm1;
	 t=1710262233; x=1710348633; bh=L41tDme8S/qn61AryL+yWGfHDr+9J6uD
	P9+pt+TYsJg=; b=N1v+2M3SlP4/TYtoTPi0xti4onV4s+W5eWiatD6xMEeMAMix
	OOCT/rQMDEXfq4Tvv94ng5hy0ips/4YT4vpr3hNONUN7yonHOwsXrOpEfuyIsbua
	IBkyuWd30GFRtJDohr8j4hIuBtpv4x68MjItpcG9VB5XyKM0AGNQhy8yKuEOLcMO
	SQKyYUXBRvex21c9cJHZnAxZmefnMoZgWK+NQE2NIQmNJ8yavgZqhbxK5NxZYUoC
	JolO8A1/e886IoOXGXJ5Lc0OMDIP1b/25cQR5+XYabtpwRtiqSmp/kvAL0HjGwIZ
	seFcrkyDjyh6uKf6ZzDh0CF3pCsPQTjlMaeE6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1710262233; x=1710348633; bh=L41tDme8S/qn61AryL+yWGfHDr+9J6uDP9+
	pt+TYsJg=; b=NpKoQHpMjJsPqdWfyLgbccV0P9YdEp2TVCiINxNrf2oAChoGxqo
	W//mJJfxvCI3iJwcjIRxZaU92NPQ9AgVbD1qCVvYdBRr5HKPVO/4deR6wU9juT+z
	cWNR18uYdY0cMaATgUfa6CqAZH6jCx8oTy3iG2n0FlVyjTprmiRefTLSitmvUaDe
	ozhzax+tK/ZgRsmoaKQJg9rEys2c/iQpv2PJYl+mBbLNL8/S1kuoA+XL9cPjlSD7
	HnFVjJQEJnYH4U/32yuAPHv8OQVkn3VmzlicQ8b+2W28uepzLJASm/HruJ8MN5M6
	ndXumCdYgqZf/0tFdOVSft5MKa+ovLXWRBg==
X-ME-Sender: <xms:2IfwZSd3KMUctAuXBpTqytWjAEVFErVDX3ILG5sdenGyyo_gRODgvQ>
    <xme:2IfwZcPhMT90Nk-eaNIEdrRo3KFI3nS1TO3ZqU3Du9NSvx4_24_Io6L1spP5twxuq
    yzETrhsq9Aghso5KaY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjeefgdelfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpeeffeeuhfekjeevtddvtdelledttddtjeegvdfhtdduvdfhueekudeihfejtefgieen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:2YfwZTiqNurccSjszB9adnqPaa0eeA2ah5IONJg2AzXPBWJIov5DeA>
    <xmx:2YfwZf81uJZ_pU8JX8hBIH2gdyNdRDSlrPAA0tEjZHrzA44NPh-wvQ>
    <xmx:2YfwZevbSdIWuA1tXv9ISpg3DgJy56v_GMPsp03J6NHlVYGXNDdtqw>
    <xmx:2YfwZWFhkuyUVB80AAT3J09iTdzUVA4u27nNANlpvCKfRCeCWOzd0g>
    <xmx:2YfwZb9iM86DXngVpbF42P0DSKs4WpOLC2O5-MsUqHAYqz4at8obwKDAApo>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id E7C36B6008D; Tue, 12 Mar 2024 12:50:32 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-251-g8332da0bf6-fm-20240305.001-g8332da0b
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <84ad750e-7234-429f-b43c-17464fbfc58b@app.fastmail.com>
Date: Tue, 12 Mar 2024 17:50:12 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Vincenzo Frascino" <vincenzo.frascino@arm.com>,
 "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 "Yan Zhao" <yan.y.zhao@intel.com>
Subject: [GIT PULL] asm-generic updates for 6.9
Content-Type: text/plain

The following changes since commit b401b621758e46812da61fa58a67c3fd8d91de0d:

  Linux 6.8-rc5 (2024-02-18 12:56:25 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/asm-generic-6.9

for you to fetch changes up to 5394f1e9b687bcf26595cabf83483e568676128d:

  arch: define CONFIG_PAGE_SIZE_*KB on all architectures (2024-03-06 19:29:09 +0100)

----------------------------------------------------------------
asm-generic updates for 6.9

Just two small updates this time:

 - A series I did to unify the definition of PAGE_SIZE through Kconfig,
   intended to help with a vdso rework that needs the constant but
   cannot include the normal kernel headers when building the compat
   VDSO on arm64 and potentially others.

 - a patch from Yan Zhao to remove the pfn_to_virt() definitions from
   a couple of architectures after finding they were both incorrect
   and entirely unused.

----------------------------------------------------------------
Arnd Bergmann (3):
      arch: consolidate existing CONFIG_PAGE_SIZE_*KB definitions
      arch: simplify architecture specific page size configuration
      arch: define CONFIG_PAGE_SIZE_*KB on all architectures

Yan Zhao (1):
      mm: Remove broken pfn_to_virt() on arch csky/hexagon/openrisc

 arch/Kconfig                       | 94 +++++++++++++++++++++++++++++++++++++-
 arch/alpha/Kconfig                 |  1 +
 arch/alpha/include/asm/page.h      |  2 +-
 arch/arc/Kconfig                   |  3 ++
 arch/arc/include/uapi/asm/page.h   |  6 +--
 arch/arm/Kconfig                   |  1 +
 arch/arm/include/asm/page.h        |  2 +-
 arch/arm64/Kconfig                 | 29 ++++++------
 arch/arm64/include/asm/page-def.h  |  2 +-
 arch/csky/Kconfig                  |  1 +
 arch/csky/include/asm/page.h       |  7 +--
 arch/hexagon/Kconfig               | 24 ++--------
 arch/hexagon/include/asm/page.h    | 12 +----
 arch/loongarch/Kconfig             | 21 +++------
 arch/loongarch/include/asm/page.h  | 10 +---
 arch/m68k/Kconfig                  |  3 ++
 arch/m68k/Kconfig.cpu              |  2 +
 arch/m68k/include/asm/page.h       |  6 +--
 arch/microblaze/Kconfig            |  1 +
 arch/microblaze/include/asm/page.h |  2 +-
 arch/mips/Kconfig                  | 58 ++---------------------
 arch/mips/include/asm/page.h       | 16 +------
 arch/nios2/Kconfig                 |  1 +
 arch/nios2/include/asm/page.h      |  2 +-
 arch/openrisc/Kconfig              |  1 +
 arch/openrisc/include/asm/page.h   |  7 +--
 arch/parisc/Kconfig                |  3 ++
 arch/parisc/include/asm/page.h     | 10 +---
 arch/powerpc/Kconfig               | 31 +++----------
 arch/powerpc/include/asm/page.h    |  2 +-
 arch/riscv/Kconfig                 |  1 +
 arch/riscv/include/asm/page.h      |  2 +-
 arch/s390/Kconfig                  |  1 +
 arch/s390/include/asm/page.h       |  2 +-
 arch/sh/include/asm/page.h         | 13 +-----
 arch/sh/mm/Kconfig                 | 42 +++++------------
 arch/sparc/Kconfig                 |  2 +
 arch/sparc/include/asm/page_32.h   |  2 +-
 arch/sparc/include/asm/page_64.h   |  3 +-
 arch/um/Kconfig                    |  1 +
 arch/um/include/asm/page.h         |  2 +-
 arch/x86/Kconfig                   |  1 +
 arch/x86/include/asm/page_types.h  |  2 +-
 arch/xtensa/Kconfig                |  1 +
 arch/xtensa/include/asm/page.h     |  2 +-
 scripts/gdb/linux/constants.py.in  |  2 +-
 scripts/gdb/linux/mm.py            |  2 +-
 47 files changed, 187 insertions(+), 254 deletions(-)

