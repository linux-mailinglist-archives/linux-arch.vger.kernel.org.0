Return-Path: <linux-arch+bounces-4300-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C72CA8C2BB6
	for <lists+linux-arch@lfdr.de>; Fri, 10 May 2024 23:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32CD2B20AE1
	for <lists+linux-arch@lfdr.de>; Fri, 10 May 2024 21:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7803213B5AB;
	Fri, 10 May 2024 21:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="QOpwtB3j";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="InT8nqHg"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3332313B59A;
	Fri, 10 May 2024 21:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715376023; cv=none; b=V21aovs9e1XgMUXEEkFpI5RluLfH9v+50YVML6dZGSXnVYJBXbj1fLXP6hr8HsgqAkUZbwjA98dx2Cp/Eg/lgGQzGxy+DX7kddH00/yEZYp4Fqb8RcnmABGzNZILe5JY9rVVeAcZiZeQW16iR+0WvvlgZO2aXTmtLgoigyJ1Tjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715376023; c=relaxed/simple;
	bh=tSJuiRDV+CYJB5wJGdMlExG6bfQqglAbRPbjngLBA28=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=L/ZhN4RINfSGRUffCcZKyKB0i6UcJp6ModrUeJre7p2EJbOQbWcX8RZRwjLRCZQgjdjINgjUsF6S0kup1JzykKDjq+V+yqSlhuLbbX+Zy9MvwEabnsGsZGEObpcSVnEfOITY1+PxUvUXUgXrfZzMBG/3yy2KJhWReT2fd5kjq+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=QOpwtB3j; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=InT8nqHg; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 357961140150;
	Fri, 10 May 2024 17:20:17 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 10 May 2024 17:20:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715376017; x=1715462417; bh=EkgGfm04sZ
	P1741DkIoCLols09u8gma8LG+8ffwSpT0=; b=QOpwtB3jdubpJMtx2RzaGifonH
	XjSJQYhlEHb8Fbr4hYxbnroL2NgXd1yoL4sacCBesirdOZV2Xm1lDHa4l6fdJC9f
	O0C3TfpPa3yuianGmrDUVhWF7ZKfbXH6zk4w1wib/dJ0COdpdAJNuadwv9Qjr4aW
	PKEQFzM4Uw3eysoIKOgqZG8ceHv8kDZlfAolM1Y1ByqFXM+a1CpSW6LJ4h25de1Y
	+c1Ogniw8XyYRerPNsgivEiGWc7UKNmGh6UT1Xp2Fu3WfNgM7R5sghjEdYR29Byj
	clK5s8HrQAETcRI+xz4M1XiZVQSVKEfoMwNjM3t/kWxzUx111+R+koo9yRsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715376017; x=1715462417; bh=EkgGfm04sZP1741DkIoCLols09u8
	gma8LG+8ffwSpT0=; b=InT8nqHgEihs7Emcqt9D4Lr9tiprsbozFTfOT7qkHk39
	VH9R76ThjN1NuvOdMcQKwp45WJQZ5kSoCqpJcgxLiezWinkpK+oa5ua+/VVoQ/3p
	4lRVpFRv+ZyG/eJakMdTwmB/NP785PcpeHrjXhUPGCQEtNGxyERsbS2Gr6kq8YVq
	3Y++2eDfy4Fgv9lVqvnGA+zthoIFhuXnxyfTfvQ2z1+x6yV/xhLMdHh+aDRU184V
	zuLi4pBUz3z532qnHps1havE5y7KymARsnIKoOVjJuQb1MZWa/2IOagdA2fUP+UR
	Gs0p7xPksSnNq5PqgeGp5rcJnS7VaOkhcj3OnUxAsQ==
X-ME-Sender: <xms:kI8-ZhPwibcwi-LvSD0JiZIIVCbfuo-AblFtgKEvDxLSxdnUYfVx9g>
    <xme:kI8-Zj9m5iaDwdIYWNNvpQnixQ5cLId7NmQKTXLwzAz3FYTo3BXw8vg_CDm7i8WAa
    OCmoVZBURUJm2Myxgo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdefkedgudehlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeevhfffledtgeehfeffhfdtgedvheejtdfgkeeuvefgudffteettdekkeeu
    feehudenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:kI8-ZgR7amt0jP0ZO8gmvjA4bwQJ0qdevFt-9SZ_-gOHrW-KW14OJA>
    <xmx:kI8-Zttkb4tB-AV13IRtRTCovr1wb1rtbHWKQwhVzwtyFL580FWC2g>
    <xmx:kI8-Zpd3MpO2GFGad5LxJ0d3aE4TLTrac3F0SGMNuJf2NJQrRcfWRg>
    <xmx:kI8-Zp0xCbYH71j01W0xOYtMqzSC3IXxZXI8BCOwxDO_DP-5XEG6Fw>
    <xmx:kY8-ZowsfpBRFRkmOyxqR0H2m5HgNil51hRrZaCZpuV85f_xe9h0EQqA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 6A8DDB6008D; Fri, 10 May 2024 17:20:16 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-443-g0dc955c2a-fm-20240507.001-g0dc955c2
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e383dfe5-814a-4a87-befc-4831a7788f42@app.fastmail.com>
In-Reply-To: <71feb004-82ef-4c7b-9e21-0264607e4b20@app.fastmail.com>
References: <71feb004-82ef-4c7b-9e21-0264607e4b20@app.fastmail.com>
Date: Fri, 10 May 2024 23:19:56 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>,
 linux-alpha@vger.kernel.org,
 "Richard Henderson" <richard.henderson@linaro.org>,
 "Ivan Kokshaysky" <ink@jurassic.park.msu.ru>,
 "Matt Turner" <mattst88@gmail.com>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Paul E. McKenney" <paulmck@kernel.org>
Subject: [GIT PULL] alpha: cleanups and build fixes for 6.10
Content-Type: text/plain

The following changes since commit fec50db7033ea478773b159e0e2efb135270e3b7:

  Linux 6.9-rc3 (2024-04-07 13:22:46 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/asm-generic-alpha

for you to fetch changes up to a4184174be36369c3af8d937e165f28a43ef1e02:

  alpha: drop pre-EV56 support (2024-05-06 12:05:00 +0200)

----------------------------------------------------------------
alpha: cleanups and build fixes

I had investigated dropping support for alpha EV5 and earlier a while
ago after noticing that this is the only supported CPU family
in the kernel without native byte access and that Debian has already
dropped support for this generation last year [1] in order to
improve performance for the newer machines.

This topic came up again when Paul E. McKenney noticed that
parts of the RCU code already rely on byte access and do not
work on alpha EV5 reliably, so we decided on using my series to
avoid the problem entirely.

Al Viro did another series for alpha to address all the known build
issues. I rebased his patches without any further changes and included
it as a baseline for my work here to avoid conflicts and allow
backporting the fixes to stable kernels for the now removed hardware
support as well.

----------------------------------------------------------------
Al Viro (9):
      alpha: sort scr_mem{cpy,move}w() out
      alpha: fix modversions for strcpy() et.al.
      alpha: add clone3() support
      alpha: don't make functions public without a reason
      alpha: sys_sio: fix misspelled ifdefs
      alpha: missing includes
      alpha: core_lca: take the unused functions out
      alpha: jensen, t2 - make __EXTERN_INLINE same as for the rest
      alpha: trim the unused stuff from asm-offsets.c

Arnd Bergmann (5):
      alpha: remove DECpc AXP150 (Jensen) support
      alpha: sable: remove early machine support
      alpha: remove LCA and APECS based machines
      alpha: cabriolet: remove EV5 CPU support
      alpha: drop pre-EV56 support

 Documentation/driver-api/eisa.rst      |   4 +-
 arch/alpha/Kconfig                     | 175 +----------
 arch/alpha/Makefile                    |   8 +-
 arch/alpha/include/asm/core_apecs.h    | 534 ---------------------------------
 arch/alpha/include/asm/core_lca.h      | 378 -----------------------
 arch/alpha/include/asm/core_t2.h       |   8 -
 arch/alpha/include/asm/dma-mapping.h   |   4 -
 arch/alpha/include/asm/dma.h           |   9 +-
 arch/alpha/include/asm/elf.h           |   4 +-
 arch/alpha/include/asm/io.h            |  26 +-
 arch/alpha/include/asm/irq.h           |  10 +-
 arch/alpha/include/asm/jensen.h        | 363 ----------------------
 arch/alpha/include/asm/machvec.h       |   9 -
 arch/alpha/include/asm/mmu_context.h   |  45 +--
 arch/alpha/include/asm/special_insns.h |   5 +-
 arch/alpha/include/asm/tlbflush.h      |  37 +--
 arch/alpha/include/asm/uaccess.h       |  80 -----
 arch/alpha/include/asm/vga.h           |   2 +
 arch/alpha/include/uapi/asm/compiler.h |  18 --
 arch/alpha/kernel/Makefile             |  25 +-
 arch/alpha/kernel/asm-offsets.c        |  21 +-
 arch/alpha/kernel/bugs.c               |   1 +
 arch/alpha/kernel/console.c            |   1 +
 arch/alpha/kernel/core_apecs.c         | 420 --------------------------
 arch/alpha/kernel/core_cia.c           |   6 +-
 arch/alpha/kernel/core_irongate.c      |   1 -
 arch/alpha/kernel/core_lca.c           | 517 -------------------------------
 arch/alpha/kernel/core_marvel.c        |   2 +-
 arch/alpha/kernel/core_t2.c            |   2 +-
 arch/alpha/kernel/core_wildfire.c      |   8 +-
 arch/alpha/kernel/entry.S              |   1 +
 arch/alpha/kernel/io.c                 |  19 ++
 arch/alpha/kernel/irq.c                |   1 +
 arch/alpha/kernel/irq_i8259.c          |   4 -
 arch/alpha/kernel/machvec_impl.h       |  25 +-
 arch/alpha/kernel/pci-noop.c           | 113 -------
 arch/alpha/kernel/pci_impl.h           |   4 +-
 arch/alpha/kernel/perf_event.c         |   2 +-
 arch/alpha/kernel/proto.h              |  44 +--
 arch/alpha/kernel/setup.c              | 109 +------
 arch/alpha/kernel/smc37c669.c          |   6 +-
 arch/alpha/kernel/smc37c93x.c          |   2 +
 arch/alpha/kernel/smp.c                |   1 +
 arch/alpha/kernel/srmcons.c            |   2 +
 arch/alpha/kernel/sys_cabriolet.c      |  87 +-----
 arch/alpha/kernel/sys_eb64p.c          | 238 ---------------
 arch/alpha/kernel/sys_jensen.c         | 237 ---------------
 arch/alpha/kernel/sys_mikasa.c         |  57 ----
 arch/alpha/kernel/sys_nautilus.c       |   8 +-
 arch/alpha/kernel/sys_noritake.c       |  60 ----
 arch/alpha/kernel/sys_sable.c          | 294 +-----------------
 arch/alpha/kernel/sys_sio.c            | 486 ------------------------------
 arch/alpha/kernel/syscalls/syscall.tbl |   2 +-
 arch/alpha/kernel/traps.c              |  64 ----
 arch/alpha/lib/Makefile                |  14 -
 arch/alpha/lib/checksum.c              |   1 +
 arch/alpha/lib/fpreg.c                 |   1 +
 arch/alpha/lib/memcpy.c                |   3 +
 arch/alpha/lib/stycpy.S                |  11 +
 arch/alpha/lib/styncpy.S               |  11 +
 arch/alpha/math-emu/math.c             |   7 +-
 arch/alpha/mm/init.c                   |   2 +-
 drivers/char/agp/alpha-agp.c           |   2 +-
 drivers/eisa/Kconfig                   |   9 +-
 drivers/eisa/virtual_root.c            |   2 +-
 drivers/input/serio/i8042-io.h         |   5 +-
 drivers/tty/serial/8250/8250.h         |   3 -
 drivers/tty/serial/8250/8250_alpha.c   |  21 --
 drivers/tty/serial/8250/8250_core.c    |   4 -
 drivers/tty/serial/8250/Makefile       |   2 -
 include/linux/blk_types.h              |   6 -
 include/linux/tty.h                    |  14 +-
 72 files changed, 166 insertions(+), 4541 deletions(-)
 delete mode 100644 arch/alpha/include/asm/core_apecs.h
 delete mode 100644 arch/alpha/include/asm/core_lca.h
 delete mode 100644 arch/alpha/include/asm/jensen.h
 delete mode 100644 arch/alpha/kernel/core_apecs.c
 delete mode 100644 arch/alpha/kernel/core_lca.c
 delete mode 100644 arch/alpha/kernel/pci-noop.c
 delete mode 100644 arch/alpha/kernel/sys_eb64p.c
 delete mode 100644 arch/alpha/kernel/sys_jensen.c
 delete mode 100644 arch/alpha/kernel/sys_sio.c
 create mode 100644 arch/alpha/lib/stycpy.S
 create mode 100644 arch/alpha/lib/styncpy.S
 delete mode 100644 drivers/tty/serial/8250/8250_alpha.c

