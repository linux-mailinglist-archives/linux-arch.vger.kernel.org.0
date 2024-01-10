Return-Path: <linux-arch+bounces-1325-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CBD1829725
	for <lists+linux-arch@lfdr.de>; Wed, 10 Jan 2024 11:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B9CB1C219C3
	for <lists+linux-arch@lfdr.de>; Wed, 10 Jan 2024 10:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C863FB08;
	Wed, 10 Jan 2024 10:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="QIlgLaD5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BbshDz4z"
X-Original-To: linux-arch@vger.kernel.org
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3103FB02;
	Wed, 10 Jan 2024 10:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 513873200AE6;
	Wed, 10 Jan 2024 05:19:13 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 10 Jan 2024 05:19:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm2; t=1704881952; x=1704968352; bh=tz
	ttvDUX93pOgvU5O2v5sdJ4w+bYyfhKUlqgeYo0g68=; b=QIlgLaD5d6LcJbLbTE
	3lTQQf9AA6Et7bHuZtEbXdByb2UFkVbyzgo9yhfYiUsLTPJ6uJgJvjlgJZcNKZtH
	ly/BhCqI915Srzow5fbITCQIAtjKZ43Wh5EUbCsDpcSWJHoxLXFw+ZtWXQwiHGP8
	z9UZfbNN3QC0zNBELXLIhterbjFowk3dYsUc7HHyS3fWMjOhkMePweMqq9nNIYTY
	c6qw18adKY1gKpw1p4Zww8EdYbubLT/gHD19zi0AeRHBTOI2pLRyoXgkekjwPIoI
	hFD9tvTgUF4pR01Gbd9oegblIk8p3uTNDauiySADxrao6yI8VLQ5FvIVAL2emh2L
	19VA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1704881952; x=1704968352; bh=tzttvDUX93pOg
	vU5O2v5sdJ4w+bYyfhKUlqgeYo0g68=; b=BbshDz4zd1hTisUwXxj/k21KnzC+J
	Ey3ysXF6xssunYFv5REuM7xnog6doHy0V0CzsNSmOCiDXvKGtOmEsnfYSVLUHcTI
	6XFopjXIc6F+gdBNnQd27rqg8gYGO8exkKPiwqdTCo6W6GMZJCPblmJOKZdXYq0g
	V3PL3QrQNZFSYvZDpNrCaDnwyobF4cyCY619w+Is0VnkpSAbRT5qDNXvwcoU2iQs
	2/8DGbDUXQ60TFkvUAYR7T/Zn3e5FYFq3qQ5yq8zqSvFg2cvcvNC8O4DO4E2i1Fj
	v07H29BTrEN88TGS+4hNT31DsFeQJDPOj8hLXpyowsqszGGOI953hF8jA==
X-ME-Sender: <xms:IG-eZRBFdQH06Wb4N_Mj5WIhi2Bron6FqITv3c3oM9Mo5BjLSUtiKw>
    <xme:IG-eZfjjsM33q06ArhDbeii2rr2gZDPAu9nblGn-MNt9j9e1To5khcmPaXeKFf-uE
    xD89t2qR2aq-A960QM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeiuddgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkfffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpefgffevuddtledthfduiedtvddvtdelfeekhfeggfevveelgfeitdeileeffefg
    ieenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:IG-eZck4IrEjC-qYAxL6ZzeaJAyzpPbjF0F3kLTgxduvU46ceBVd9Q>
    <xmx:IG-eZbwvxhZ_HwpxACt6dq5Gg-N80SU1OolIBLKzxYZ7daH02E6hEQ>
    <xmx:IG-eZWT_2AbFMxCNqDXxKJGHR82Q1JIAPpEU30Lq7bIpBcJqNlIx3w>
    <xmx:IG-eZf5FCEtIWpyDuWnJEI44OthYcDwnDqH25bXUHEjTyJkRjs0B4g>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 786C4B6008D; Wed, 10 Jan 2024 05:19:12 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1364-ga51d5fd3b7-fm-20231219.001-ga51d5fd3
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <8d87c3da-fe7e-4b2d-9078-4421e4ca7727@app.fastmail.com>
Date: Wed, 10 Jan 2024 11:18:36 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>
Subject: [GIT PULL] asm-generic cleanups for 6.8
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

The following changes since commit b85ea95d086471afb4ad062012a4d73cd328f=
a86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git t=
ags/asm-generic-6.8

for you to fetch changes up to d93cca2f3109f88c94a32d3322ec8b2854a9c339:

  asm-generic: Fix 32 bit __generic_cmpxchg_local (2024-01-05 23:19:14 +=
0100)

----------------------------------------------------------------
asm-generic cleanups for 6.8

A series from Baoquan He cleans up the asm-generic/io.h to remove the
ioremap_uc() definition from everything except x86, which still needs it
for pre-PAT systems. This series notably contains a patch from Jiaxun Ya=
ng
that converts MIPS to use asm-generic/io.h like every other architecture
does, enabling future cleanups.

Some of my own patches fix -Wmissing-prototype warnings in architecture
specific code across several architectures. This is now needed as the
warning is enabled by default. There are still some remaining warnings
in minor platforms, but the series should catch most of the widely used
ones make them more consistent with one another.

David McKay fixes a bug in __generic_cmpxchg_local() when this is used
on 64-bit architectures. This could currently only affect parisc64
and sparc64.

Additional cleanups address from Linus Walleij, Uwe Kleine-K=C3=B6nig,
Thomas Huth, and Kefeng Wang help reduce unnecessary inconsistencies
between architectures.

----------------------------------------------------------------
Arnd Bergmann (10):
      Merge branch 'asm-generic-io.h-cleanup' into asm-generic
      arch: consolidate arch_irq_work_raise prototypes
      arch: fix asm-offsets.c building with -Wmissing-prototypes
      arch: include linux/cpu.h for trap_init() prototype
      arch: vdso: consolidate gettime prototypes
      arch: add missing prepare_ftrace_return() prototypes
      arch: add do_page_fault prototypes
      csky: fix arch_jump_label_transform_static override
      Merge branch 'asm-generic-prototypes' into asm-generic
      mips: remove extraneous asm-generic/iomap.h include

Baoquan He (2):
      arch/*/io.h: remove ioremap_uc in some architectures
      mips: io: remove duplicated codes

David McKay (1):
      asm-generic: Fix 32 bit __generic_cmpxchg_local

Jiaxun Yang (1):
      mips: add <asm-generic/io.h> including

Kefeng Wang (1):
      asm/io: remove unnecessary xlate_dev_mem_ptr() and unxlate_dev_mem=
_ptr()

Linus Walleij (2):
      ARC: mm: Make virt_to_pfn() a static inline
      Hexagon: Make pfn accessors statics inlines

Nathan Chancellor (1):
      arm64: vdso32: Define BUILD_VDSO32_64 to correct prototypes

Thomas Huth (1):
      hexagon: Remove CONFIG_HEXAGON_ARCH_VERSION from uapi header

Uwe Kleine-K=C3=B6nig (1):
      sparc: Use $(kecho) to announce kernel images being ready

 Documentation/driver-api/device-io.rst   |   9 ++-
 arch/alpha/include/asm/io.h              |   7 --
 arch/alpha/include/asm/mmu_context.h     |   2 +
 arch/alpha/kernel/asm-offsets.c          |   2 +-
 arch/alpha/kernel/traps.c                |   1 +
 arch/arc/include/asm/page.h              |  21 ++---
 arch/arc/include/asm/pgtable-levels.h    |   2 +-
 arch/arm/include/asm/io.h                |   6 --
 arch/arm/include/asm/irq_work.h          |   2 -
 arch/arm/include/asm/vdso.h              |   5 --
 arch/arm/vdso/vgettimeofday.c            |   1 +
 arch/arm64/include/asm/irq_work.h        |   2 -
 arch/arm64/kernel/vdso32/vgettimeofday.c |   2 +
 arch/csky/include/asm/ftrace.h           |   4 +
 arch/csky/include/asm/irq_work.h         |   2 +-
 arch/csky/include/asm/jump_label.h       |   5 ++
 arch/csky/include/asm/traps.h            |   2 +-
 arch/csky/kernel/traps.c                 |   1 +
 arch/csky/kernel/vdso/vgettimeofday.c    |  11 +--
 arch/hexagon/include/asm/io.h            |   9 ---
 arch/hexagon/include/asm/page.h          |  15 +++-
 arch/hexagon/include/uapi/asm/user.h     |   7 +-
 arch/hexagon/kernel/ptrace.c             |   7 +-
 arch/loongarch/kernel/asm-offsets.c      |  26 +++----
 arch/loongarch/vdso/vgettimeofday.c      |   7 +-
 arch/m68k/coldfire/vectors.c             |   3 +-
 arch/m68k/coldfire/vectors.h             |   3 -
 arch/m68k/include/asm/io_mm.h            |   6 --
 arch/m68k/include/asm/kmap.h             |   1 -
 arch/microblaze/include/asm/ftrace.h     |   1 +
 arch/microblaze/kernel/traps.c           |   1 +
 arch/mips/include/asm/ftrace.h           |   4 +
 arch/mips/include/asm/io.h               | 128 +++++++++++++++++-------=
-------
 arch/mips/include/asm/mmiowb.h           |   4 +-
 arch/mips/include/asm/smp-ops.h          |   2 -
 arch/mips/include/asm/smp.h              |   4 +-
 arch/mips/include/asm/traps.h            |   3 +
 arch/mips/kernel/setup.c                 |   1 +
 arch/mips/pci/pci-ip27.c                 |   3 +
 arch/mips/vdso/vgettimeofday.c           |   1 +
 arch/nios2/include/asm/traps.h           |   2 +
 arch/parisc/include/asm/io.h             |   8 --
 arch/powerpc/include/asm/io.h            |   7 --
 arch/powerpc/include/asm/irq_work.h      |   1 -
 arch/riscv/include/asm/irq_work.h        |   2 +-
 arch/riscv/kernel/vdso/vgettimeofday.c   |   7 +-
 arch/s390/include/asm/irq_work.h         |   2 -
 arch/sh/include/asm/io.h                 |   9 ---
 arch/sh/include/asm/traps_32.h           |   3 +
 arch/sparc/boot/Makefile                 |  10 +--
 arch/sparc/include/asm/io_64.h           |   7 --
 arch/sparc/kernel/asm-offsets.c          |   6 +-
 arch/sparc/kernel/traps_32.c             |   1 +
 arch/sparc/kernel/traps_64.c             |   1 +
 arch/x86/entry/vdso/vclock_gettime.c     |  10 +--
 arch/x86/include/asm/irq_work.h          |   1 -
 arch/x86/include/asm/traps.h             |   1 -
 arch/x86/include/asm/vdso/gettimeofday.h |   2 -
 arch/x86/kernel/traps.c                  |   1 +
 include/asm-generic/cmpxchg-local.h      |   2 +-
 include/linux/irq_work.h                 |   3 +
 include/vdso/gettime.h                   |  23 ++++++
 scripts/headers_install.sh               |   1 -
 63 files changed, 204 insertions(+), 229 deletions(-)
 delete mode 100644 arch/m68k/coldfire/vectors.h
 create mode 100644 include/vdso/gettime.h

