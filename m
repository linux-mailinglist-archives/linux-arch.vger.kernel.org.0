Return-Path: <linux-arch+bounces-11141-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53863A71F73
	for <lists+linux-arch@lfdr.de>; Wed, 26 Mar 2025 20:47:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 079C7189C8AF
	for <lists+linux-arch@lfdr.de>; Wed, 26 Mar 2025 19:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D8C253349;
	Wed, 26 Mar 2025 19:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="UT3WLwHu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iOINO0mI"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A602F24C676;
	Wed, 26 Mar 2025 19:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743018248; cv=none; b=udrENRW9zz5T9pPyK7vAZGJbe4oDilSMJCuOcB7A44avyeSekXtfJli3LHxKEwVOXZOC6jBmFUm9wNARAmhgG/qehBB7P4DfTUo+p7XxM3RHDqd7vUV+alQIlheiaUvsmRvI1Lx49efwL4tlPWBzkas19tM5BTe/qf4UEBVRTEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743018248; c=relaxed/simple;
	bh=1zxp2JuUA4SoDWupkMfGgw89XKTQK0YYH4Zgo6ukpTA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:Subject:Content-Type; b=kftkV/QettKczyC6GsAp8vwf+6ltOQWQM1905tkeM/Y5ZAg763s0PxQlC7FC4QLeJftURm89oqMg/FOaafoLIus79U75iZ24opT7mDCJC7A01x5E3bLwHhC6TXvfilENBcVRuYTLhh38OA9q8iTB7R16Tf7a2CaD+rZKv71bvro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=UT3WLwHu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iOINO0mI; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B92271140114;
	Wed, 26 Mar 2025 15:44:04 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-07.internal (MEProxy); Wed, 26 Mar 2025 15:44:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1743018244; x=1743104644; bh=3B
	m37zrfytA9X0z64bKtWgE5xF7qOkcmjrE7cIKq4Ic=; b=UT3WLwHuQ4zO/l7HL7
	mpLvPA5inrnRi6CiRK1kbyAv8iYoo36IXEnZfCnb0CHIcsGGd4Z/b/C5DZLaK7To
	iH1SEUW+8JU5lJv0HvA85vuhXhTpgAhWcEujfUiTh0gE/DQIYXPvlbkIdHVfvfcf
	Rg/3pFQQYfFw8pEdNoKuDoAfjUkcza01jy1Bctsj4JEeBqumg5HZfJ3jfC6om3zE
	9TKIpkg773kaMrhnt0MMMW7iZHFphLdBPwt5I1XOS/Cjd0w+Ig+wYZw8sHmVgHiZ
	OLFAeV+tBLYIDGEdC+OotQpD28Jzy3MLLE4+QiVDN1sIlhxkY440kYNUO2KPe0bJ
	BDAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1743018244; x=1743104644; bh=3Bm37zrfytA9X0z64bKtWgE5xF7q
	OkcmjrE7cIKq4Ic=; b=iOINO0mIM9RRAi7zjek2lg7mhlBvjBbDZH6mKbfu8xZY
	omml4VdjlxSBXhTO6j0QhIqTnz+YcKyKqDLOcYybC2/3Wf1JTVGqXPsv42/du0rG
	p0f0T4HfbakgNzGxHAUyDBXgT7cSmrCe3gFLKhKp6+wH9ZUX+UrV7tUR6CGEM01F
	8eF3qaGusqp8XC0atx9SK7PJBWWlETc7lONB3kVXPsLty5zhr6O35tpreKFupxbj
	VH9ClbLB+6NMR07Eu7nB+5LM+xHNYbp9c3p5hh4Qudr8G1owtWjFY8rLt1Vte2D2
	rimHpQvf6oyHrzDIjNYjH2OtT2pb4d489/esnzcUxA==
X-ME-Sender: <xms:BFnkZ3j921VnGC1yrnpG8vL22xupYMdJVt8k64K5N69wNiyswUyJWw>
    <xme:BFnkZ0DY-jZagIPfq95Qa9wLEeAk0ngQSav29hCxUsPUkZoIuBPzAfqYg_Ncpncz9
    U5NyfhzAof8nRVTBiY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieeigedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkffutgfgsehtjeertdertddt
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhepudelieegkeevueegtedtjedttdelgeehhfdvhfeu
    heethfduleffuddvueelveetnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghr
    nhgusgdruggvpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehtohhrvhgrlhgusheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhr
    tghpthhtoheplhhinhhugidqrghrtghhsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:BFnkZ3Hrd5muDsWKP7KqcnGC1Tx_8o1Ut2hXgTwX97pxTa0Kpo2aeA>
    <xmx:BFnkZ0QxpmSTH6WKS1m7PswQJumsjJKS4nS9mwfLYpbcEl1OrfrKYA>
    <xmx:BFnkZ0zW-cnWrrSFwye9wRb8pFH7KBBsyNeezJ86_r54OQLErrinHw>
    <xmx:BFnkZ64i32xTSlL2g3Zku-5siRbCb3JZmQCYFGBaceeJtr0J7azkiQ>
    <xmx:BFnkZ__gFB-BuRFfL6dkeR-gD5uGbOxrwdVyszy4NNpJiGDj1SyjZ-SL>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 569CF2220073; Wed, 26 Mar 2025 15:44:04 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 26 Mar 2025 20:43:17 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org
Message-Id: <31097083-a444-4bd1-8722-d8b7c4b7a43a@app.fastmail.com>
Subject: [GIT PULL] asm-generic changes for 6.15
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f05b:

  Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/asm-generic-6.15

for you to fetch changes up to ece69af2ede103e190ffdfccd9f9ec850606ab5e:

  rwonce: handle KCSAN like KASAN in read_word_at_a_time() (2025-03-25 17:50:38 +0100)

----------------------------------------------------------------
asm-generic changes for 6.15

This is mainly set of cleanups of asm-generic/io.h, resolving problems
with inconsistent semantics of ioread64/iowrite64 that were causing
runtime and build issues.

The "GENERIC_IOMAP" version that switches between inb()/outb() and
readb()/writeb() style accessors is now only used on architectures that
have PC-style ISA devices that are not memory mapped (x86, uml, m68k-q40
and powerpc-powernv), while alpha and parisc use a more complicated
variant and everything else just maps the ioread interfaces to plan MMIO
(readb/writeb etc).

In addition there are two small changes from Raag Jadav to simplify
the asm-generic/io.h indirect inclusions and from Jann Horn to fix
a corner case with read_word_at_a_time.

----------------------------------------------------------------
Arnd Bergmann (10):
      asm-generic/io.h: rework split ioread64/iowrite64 helpers
      alpha: stop using asm-generic/iomap.h
      sh: remove duplicate ioread/iowrite helpers
      parisc: stop using asm-generic/iomap.h
      powerpc: asm/io.h: remove split ioread64/iowrite64 helpers
      mips: drop GENERIC_IOMAP wrapper
      m68k/nommu: stop using GENERIC_IOMAP
      mips: fix PCI_IOBASE definition
      mips: export pci_iounmap()
      m68k: coldfire: select PCI_IOMAP for PCI

Jann Horn (1):
      rwonce: handle KCSAN like KASAN in read_word_at_a_time()

Raag Jadav (2):
      drm/draw: include missing headers
      io.h: drop unused headers

 arch/alpha/include/asm/io.h                    |  31 ++---
 arch/m68k/Kconfig                              |   3 +-
 arch/m68k/include/asm/io_no.h                  |   4 -
 arch/mips/Kconfig                              |   2 +-
 arch/mips/include/asm/io.h                     |  25 ++--
 arch/mips/include/asm/mach-loongson64/spaces.h |   5 +-
 arch/mips/include/asm/mach-ralink/spaces.h     |   2 +-
 arch/mips/lib/iomap-pci.c                      |  10 ++
 arch/mips/loongson64/init.c                    |   4 +-
 arch/parisc/include/asm/io.h                   |  36 ++++--
 arch/powerpc/include/asm/io.h                  |  48 --------
 arch/sh/include/asm/io.h                       |  30 +----
 arch/sh/kernel/Makefile                        |   3 -
 arch/sh/kernel/iomap.c                         | 162 -------------------------
 arch/sh/kernel/ioport.c                        |   5 -
 arch/sh/lib/io.c                               |   4 +-
 drivers/gpu/drm/drm_draw.c                     |   2 +
 drivers/sh/clk/cpg.c                           |  25 ++--
 include/asm-generic/iomap.h                    |  36 ++----
 include/asm-generic/rwonce.h                   |   7 +-
 include/linux/io-64-nonatomic-hi-lo.h          |  16 +++
 include/linux/io-64-nonatomic-lo-hi.h          |  16 +++
 include/linux/io.h                             |   3 -
 lib/iomap.c                                    |  40 +++---
 24 files changed, 163 insertions(+), 356 deletions(-)
 delete mode 100644 arch/sh/kernel/iomap.c

