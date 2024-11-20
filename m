Return-Path: <linux-arch+bounces-9143-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A899D443A
	for <lists+linux-arch@lfdr.de>; Thu, 21 Nov 2024 00:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07AFEB255E8
	for <lists+linux-arch@lfdr.de>; Wed, 20 Nov 2024 23:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4F81D271C;
	Wed, 20 Nov 2024 22:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="R+AwGkFo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Gdra1tYf"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF591CEAA7;
	Wed, 20 Nov 2024 22:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732143465; cv=none; b=WdF3Ar/jmz3GvM2duBfT9isTFvMvttvgPpXP+Wk4/CmyAab+9A1Jt834tNG06y9rvuGlN8kPlWmBx7eP4z1qP7vCf5ItIiEPs+68EbRbbQCEBooA8JmVwS5OECHUeH8ms9SdVylGeDhZtgiGy8vYLYCHFLv2hiMySAW8G+qAbSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732143465; c=relaxed/simple;
	bh=Q+DckTrsrIkx5XUoBH2p9S4ZqT7N25G8hfDXBdqSAac=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:Subject:Content-Type; b=e/OiLIV0BIOfnt1eJ4h02sVZ+odtnFMannEquCdjcNU5Ll8VoSX7NvSzyYmZT1SjvAb5oMRrUoeoeOpwL9qZbc+OlN1FPM42BGWlj+AyaEalq7wGGePV/WHJ0KjaX55fO2DYcRm8ow015Qt6CnTT/2hSeg9KYEGCDOOi7c89xoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=R+AwGkFo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Gdra1tYf; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 8C55913806B2;
	Wed, 20 Nov 2024 17:57:40 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Wed, 20 Nov 2024 17:57:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm3; t=1732143460; x=1732229860; bh=v3
	3bTF1lUmn265ZZFGSSWMjsTMfGelk5vnAGLiroiys=; b=R+AwGkFoBF5HY+BMxz
	HkQdnm5S9KRYOq8B1gkA4t3LwCNFeURJNcg8ngzJ2seJdpakQ7mu707GMPfrCD0Y
	B+TJHkTTcLj/ZWsoCMBE6J0WvBRkoiFfe9d/yk1tn3oBwTMkWClYe1ZxOcP9PQyt
	ELUv8n2GhbVmnmzu6clKWjPURVqDU2jUr8tIF+HyOJ4caBKqRTTCMyjQhRUMi10R
	suXCY5gDkKwnUh9Yk/XLpc+V9wB3MJ0rQ9aqa/qKhtkFh5bWA6N82r3qnHgVutRg
	Bfqch5/oIoEBHngfIiVobGiR4hEvIeQelfHoG7TfqxavHl/rFfCfBZLOPNQ1Zf/7
	bNQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1732143460; x=1732229860; bh=v33bTF1lUmn265ZZFGSSWMjsTMfG
	elk5vnAGLiroiys=; b=Gdra1tYfRPGN/ItSaZltR9NLK0WOgntjF3DLYRi4qWOk
	vcB/+qNqLXfZgOdn6mu9ZZk9gbRFJiviU44EhNkeQhH79LgGEvI2jE7wj4tqHKJ1
	+PLJP4OmxojPiFEwUvOVB+0qJVcHeg+dc6jtmxvPWJBOeaRkiRjcgkYbrPnXRWYb
	ntmpQTc8/wl/u3Bc0aOcM1jC82LEAVfZ4wURleJ2ZtS22nZ+BOmenoYi5j/U/cs9
	BKlagDUmZqBNnM67CRMDO/7Vhushl1Z7/agrQqE9VyC9SP3NXmRCtkqc6tEoy5Dl
	uOrsCwQmcRyHqg28252DDS5o22rUqgWgjfPXLVCCsA==
X-ME-Sender: <xms:ZGk-Z24R3AEft1iK0W6hcXaQkq7DFR65rWuhAoAFpIzK2NP0m5r97Q>
    <xme:ZGk-Z_5buj-k0YXISoXSHkgrbPYlrqx--OajQzPgVfmN_c6h4l1A5IKkw9YBgQkNr
    zAbbmVecn2hWWQEf4I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeehgddtgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefoggffhffvvefkufgtgfesthhqredtredtjeenucfh
    rhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqe
    enucggtffrrghtthgvrhhnpedvieeggefhhffhgfeuvddvledvffdtgfdvffdtvdfggeeg
    hfektdefuedtvdeugfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggs
    rdguvgdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epnhhpihhtrhgvsegsrgihlhhisghrvgdrtghomhdprhgtphhtthhopehjvhgvthhtvghr
    sehkrghlrhgrhidrvghupdhrtghpthhtohepthhorhhvrghlughssehlihhnuhigqdhfoh
    hunhgurghtihhonhdrohhrghdprhgtphhtthhopehstghhnhgvlhhlvgeslhhinhhugidr
    ihgsmhdrtghomhdprhgtphhtthhopehhtghhsehlshhtrdguvgdprhgtphhtthhopehlih
    hnuhigqdgrrhgthhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhn
    uhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehvih
    hrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhk
X-ME-Proxy: <xmx:ZGk-Z1e3h5qhUoU4pBfktPLraGTa2IIr_48M00AGtTvWonEIY7Szhg>
    <xmx:ZGk-ZzKmmHXNDbINAaXQYPkN-Y-waUuSf_I4O_FblHnBgE7McqH10g>
    <xmx:ZGk-Z6JzqwUdHJ9cMynQy5-wntjezrRpOQNcEOqZjaFZF-wUOX_4Xg>
    <xmx:ZGk-Z0xkIgp8NOju5b5ANDU-m_GJ4GumujY7vqG9NHoKZQO6AMJJRw>
    <xmx:ZGk-Z7rhioQlKs_EVhccKvwnKxxRYGE9lTGQaqHWsVXd1KVKRSqZtOIg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E933C2220071; Wed, 20 Nov 2024 17:57:39 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 20 Nov 2024 23:57:18 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>,
 "Niklas Schnelle" <schnelle@linux.ibm.com>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Julian Vetter" <jvetter@kalray.eu>, "Nicolas Pitre" <npitre@baylibre.com>,
 "Christoph Hellwig" <hch@lst.de>
Message-Id: <c09168a6-23e7-40fd-afc2-4c3ac6deaff6@app.fastmail.com>
Subject: [GIT PULL] asm-generic updates for 6.13
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

The following changes since commit 8cf0b93919e13d1e8d4466eb4080a4c4d9d66=
d7b:

  Linux 6.12-rc2 (2024-10-06 15:32:27 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git t=
ags/asm-generic-3.13

for you to fetch changes up to 0af8e32343f8d0db31f593464fc140eaef25a281:

  empty include/asm-generic/vga.h (2024-11-11 21:51:42 +0100)

----------------------------------------------------------------
asm-generic updates for 6.13

These are a number of unrelated cleanups, generally simplifying the
architecture specific header files:

 - A series from Al Viro simplifies asm/vga.h, after it turns out that
   most of it can be generalized.

 - A series from Julian Vetter adds a common version of
   memcpy_{to,from}io() and memset_io() and changes most architectures
   to use that instead of their own implementation

 - A series from Niklas Schnelle concludes his work to make PC
   style inb()/outb() optional

 - Nicolas Pitre contributes improvements for the generic do_div()
   helper

 - Christoph Hellwig adds a generic version of page_to_phys()
   and phys_to_page(), replacing the slightly different architecture
   specific definitions.

 - Uwe Kleine-Koenig has a minor cleanup for ioctl definitions

----------------------------------------------------------------
Al Viro (4):
      vt_buffer.h: get rid of dead code in default scr_...() instances
      asm/vga.h: don't bother with scr_mem{cpy,move}v() unless we need to
      sparc: get rid of asm/vga.h
      empty include/asm-generic/vga.h

Arnd Bergmann (3):
      hexagon: simplify asm/io.h for !HAS_IOPORT
      lib/iomem_copy: fix kerneldoc format style
      tty: serial: export serial_8250_warn_need_ioport

Christoph Hellwig (2):
      asm-generic: provide generic page_to_phys and phys_to_page impleme=
ntations
      asm-generic: add an optional pfn_valid check to page_to_phys

Julian Vetter (4):
      New implementation for IO memcpy and IO memset
      arm64: Use new fallback IO memcpy/memset
      csky: Use new fallback IO memcpy/memset
      loongarch: Use new fallback IO memcpy/memset

Nicolas Pitre (4):
      lib/math/test_div64: add some edge cases relevant to __div64_const=
32()
      asm-generic/div64: optimize/simplify __div64_const32()
      ARM: div64: improve __arch_xprod_64()
      __arch_xprod64(): make __always_inline when optimizing for perform=
ance

Niklas Schnelle (6):
      hexagon: Don't select GENERIC_IOMAP without HAS_IOPORT support
      Bluetooth: add HAS_IOPORT dependencies
      drm: handle HAS_IOPORT dependencies
      tty: serial: handle HAS_IOPORT dependencies
      asm-generic/io.h: Remove I/O port accessors for HAS_IOPORT=3Dn
      watchdog: Add HAS_IOPORT dependency for SBC8360 and SBC7240

Uwe Kleine-K=C3=B6nig (1):
      UAPI/ioctl: Improve parameter name of ioctl request definition hel=
pers

 arch/alpha/include/asm/io.h           |   1 -
 arch/arc/include/asm/io.h             |   3 -
 arch/arm/include/asm/div64.h          |  13 +-
 arch/arm/include/asm/memory.h         |   6 -
 arch/arm64/include/asm/io.h           |  11 --
 arch/arm64/include/asm/memory.h       |   6 -
 arch/arm64/kernel/io.c                |  87 -------------
 arch/csky/include/asm/io.h            |  11 --
 arch/csky/include/asm/page.h          |   3 -
 arch/csky/kernel/Makefile             |   2 +-
 arch/csky/kernel/io.c                 |  91 --------------
 arch/hexagon/Kconfig                  |   5 +-
 arch/hexagon/include/asm/io.h         | 223 ++-------------------------=
-------
 arch/hexagon/include/asm/page.h       |   6 -
 arch/hexagon/lib/Makefile             |   2 +-
 arch/hexagon/lib/io.c                 |  82 -------------
 arch/loongarch/include/asm/io.h       |  10 --
 arch/loongarch/include/asm/page.h     |   3 -
 arch/loongarch/kernel/Makefile        |   2 +-
 arch/loongarch/kernel/io.c            |  94 --------------
 arch/m68k/include/asm/virtconvert.h   |   3 -
 arch/microblaze/include/asm/page.h    |   1 -
 arch/mips/include/asm/io.h            |   5 -
 arch/mips/include/asm/vga.h           |   4 -
 arch/nios2/include/asm/io.h           |   3 -
 arch/openrisc/include/asm/page.h      |   2 -
 arch/parisc/include/asm/page.h        |   1 -
 arch/powerpc/include/asm/io.h         |  12 --
 arch/powerpc/include/asm/vga.h        |   5 -
 arch/riscv/include/asm/page.h         |   3 -
 arch/s390/include/asm/page.h          |   2 -
 arch/sh/include/asm/page.h            |   1 -
 arch/sh/include/asm/vga.h             |   7 --
 arch/sparc/include/asm/page.h         |   2 -
 arch/sparc/include/asm/vga.h          |  60 ---------
 arch/um/include/asm/pgtable.h         |   2 -
 arch/x86/include/asm/io.h             |   5 -
 arch/xtensa/include/asm/page.h        |   1 -
 drivers/bluetooth/Kconfig             |   6 +-
 drivers/gpu/drm/gma500/Kconfig        |   2 +-
 drivers/gpu/drm/qxl/Kconfig           |   2 +-
 drivers/gpu/drm/tiny/bochs.c          |  19 ++-
 drivers/gpu/drm/tiny/cirrus.c         |   2 +
 drivers/gpu/drm/xe/Kconfig            |   2 +-
 drivers/tty/Kconfig                   |   4 +-
 drivers/tty/serial/8250/8250_early.c  |   4 +
 drivers/tty/serial/8250/8250_pci.c    |  40 ++++++
 drivers/tty/serial/8250/8250_pcilib.c |  13 +-
 drivers/tty/serial/8250/8250_pcilib.h |   2 +
 drivers/tty/serial/8250/8250_port.c   |  27 +++-
 drivers/tty/serial/8250/Kconfig       |   4 +-
 drivers/tty/serial/Kconfig            |   2 +-
 drivers/watchdog/Kconfig              |   4 +-
 include/asm-generic/div64.h           | 121 +++++++-----------
 include/asm-generic/io.h              |  82 ++++++++++---
 include/asm-generic/memory_model.h    |  13 ++
 include/asm-generic/vga.h             |  23 +---
 include/linux/serial_core.h           |   4 +
 include/linux/vt_buffer.h             |  24 ----
 include/uapi/asm-generic/ioctl.h      |  14 +--
 lib/Makefile                          |   2 +-
 lib/iomem_copy.c                      | 136 +++++++++++++++++++++
 lib/math/test_div64.c                 |  85 ++++++++++++-
 63 files changed, 487 insertions(+), 930 deletions(-)
 delete mode 100644 arch/csky/kernel/io.c
 delete mode 100644 arch/hexagon/lib/io.c
 delete mode 100644 arch/loongarch/kernel/io.c
 delete mode 100644 arch/sh/include/asm/vga.h
 delete mode 100644 arch/sparc/include/asm/vga.h
 create mode 100644 lib/iomem_copy.c

