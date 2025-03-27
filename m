Return-Path: <linux-arch+bounces-11157-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4F7A72E35
	for <lists+linux-arch@lfdr.de>; Thu, 27 Mar 2025 11:52:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77F95188A997
	for <lists+linux-arch@lfdr.de>; Thu, 27 Mar 2025 10:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D323320E310;
	Thu, 27 Mar 2025 10:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="d6Sb2vEq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SYIndZuo"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2C3186A;
	Thu, 27 Mar 2025 10:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743072745; cv=none; b=dWrMEYpI8Hy3Q+EzyY1jEMvWexDIA9YVTVeNx+H5YdimM9mO72xCxdLWHzIgqs4b1tq8HQKIZznyjYaQvHQxjpVF5eH1JFGjfdC99igjSvj40fOxDOmePFhaweYMlbSKLgFS1cxz6uAQ1Wu8QrqcM/LIJGMWiT9nYl1gZ7VIJOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743072745; c=relaxed/simple;
	bh=dy2B4+JhE3vXYtlwADZt2j6DltZypSdj/blYdPD9JkI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:Subject:Content-Type; b=ptYBaA1nkqTGGqhdfFHDGa6W3NGkifuJ+BMgNbBpI9HXcRnbYZuVteXBncQdiTcgdaKSpiNOdJ2usD552ScVOUDQG0EwwSNyoQDRXTqM6nmtWFTH3bZ+lOjeiPIiJ0MdOi0OQ7MfrAbi6sA8+RHBedTTKhUeUCj+rbUsA9P1U4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=d6Sb2vEq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SYIndZuo; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4188125400E3;
	Thu, 27 Mar 2025 06:52:22 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-07.internal (MEProxy); Thu, 27 Mar 2025 06:52:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1743072742; x=1743159142; bh=W0
	c+nYkLl1hcTJJL97XkxUcZa1KgfoFSWcd5L5aQGZE=; b=d6Sb2vEq3EUBiUnRWX
	Y9eScgQlbLei5oGd2N7L0108oGhId63hHviiqFz11t6Xr7aE6ObiVvElylh8cfiL
	CEPz1fxEWkvmKLJR/2glwlXG3FmXXyTVYPfeutp9W/cK00wVEgBvs9Ji6i/GP8G3
	sHZcGBzXsnmWhcMXEH3gxz9IZOrx6x9S0Ib3eYhigcwxJbMd++br/silXevsGAlI
	fiUFHMnjmKtJa5bzaggH2ytE5+89cfl/6Fe1AcddF18JdgVQLZqsBSq5JCRPJOo0
	AX5N4lSRwHUbnVH3R9kGiaNRSB6ZbtUXsPI539t2IupOAl5CB7/q6w07VgVrEz+t
	uZFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1743072742; x=1743159142; bh=W0c+nYkLl1hcTJJL97XkxUcZa1Kg
	foFSWcd5L5aQGZE=; b=SYIndZuoeNngii5gcjx0ZYzvf1E1iLob8Q9qHdRqHW0B
	pJg8n8Hv4od92m/qvHaW0UzUiG2YZAs7HaFKoi0ViBElZBEvFT9bfFHuQyPvMb0E
	P8NWvM4oognd+ubV4MH+QP+pkWLVAxKXC/GNOF6XUpDyYwMzk5UUCf7SAn4dkHo4
	nRZwkI67aTA5iJfrtJVFEHmf1+iYCRgejsaaCrJMJTN1fhixidCtvxlAEK+lDwug
	5yDYKtG9cF2eSXejlB/Jl392TpjpVKMwBFn967sczdRW33+ekIEPz3Kyo43r6hlB
	QfHSlLEnQRSkUysW29LRCnmz/0kUUv36SvgsG/eNiA==
X-ME-Sender: <xms:5S3lZ1ImDKh0Kn2ld5HKXLjcOn5jmZEqGnpFV-5wxutjibBv5KcWFg>
    <xme:5S3lZxIZKC8VBJTdm9OsG8G8faPRO0GWyFnyomi55hWNvifHic31PXtU4PkZaKDDR
    qSf0KwXPk-_yrBTP8Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieekvddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkffutgfgsehtjeertdertddt
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhepudelieegkeevueegtedtjedttdelgeehhfdvhfeu
    heethfduleffuddvueelveetnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghr
    nhgusgdruggvpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehjrghnnhhhsehgohhoghhlvgdrtghomhdprhgtphhtthhopehtohhrvhgrlhgu
    sheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheplhhinhhugi
    dqrghrtghhsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidq
    khgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:5S3lZ9swkcpoHWcOPMSHKa_0ay3EToyvsdKVqza2WNqaFPESNAAWZQ>
    <xmx:5S3lZ2b7fercgyBrMsqL4lhK1yyxAD6WNKICPZhXe5r2YfnOdQPjAg>
    <xmx:5S3lZ8ZyzXnBvRDdH1-Gi8walzbFkp6_po7CxP5pWqyvcwbGsR-ACQ>
    <xmx:5S3lZ6BeBnUpoPl89Z6Z_EsP5Bnb3ODEdM8KqIlFhPPvrX4VTzuPgA>
    <xmx:5i3lZ0H4X_3wrDfcpxF-uNGqW7zopis_ACWLBCfnshDdlYTRG3-E3Xps>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id AC6CF2220072; Thu, 27 Mar 2025 06:52:21 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 27 Mar 2025 11:51:51 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org,
 "Jann Horn" <jannh@google.com>
Message-Id: <d37aac3f-8220-49ba-ac01-88dfa13ef6b9@app.fastmail.com>
Subject: [GIT PULL v2] asm-generic changes for 6.15
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f05b:

  Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/asm-generic-6.15-2

for you to fetch changes up to 47a60391ae0ed04ffbb9bd8dcd94ad9d08b41288:

  rwonce: fix crash by removing READ_ONCE() for unaligned read (2025-03-26 22:16:50 +0100)

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

[this is the same content as yesterday, but with the regression
 fix from Jann added on top of his original patch]

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

Jann Horn (2):
      rwonce: handle KCSAN like KASAN in read_word_at_a_time()
      rwonce: fix crash by removing READ_ONCE() for unaligned read

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
 include/asm-generic/rwonce.h                   |  10 +-
 include/linux/io-64-nonatomic-hi-lo.h          |  16 +++
 include/linux/io-64-nonatomic-lo-hi.h          |  16 +++
 include/linux/io.h                             |   3 -
 lib/iomap.c                                    |  40 +++---
 24 files changed, 167 insertions(+), 355 deletions(-)
 delete mode 100644 arch/sh/kernel/iomap.c

