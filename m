Return-Path: <linux-arch+bounces-4346-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A728C37C6
	for <lists+linux-arch@lfdr.de>; Sun, 12 May 2024 19:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09CED2813F7
	for <lists+linux-arch@lfdr.de>; Sun, 12 May 2024 17:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2877D4CB2E;
	Sun, 12 May 2024 17:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P0KyCyDK"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE71C46430;
	Sun, 12 May 2024 17:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715534915; cv=none; b=giX0ih8IjUnLkktoPmj09lizOhGrpJL6sc1EZbsUmeqqcOrC0UdvMn1GjX6zhCI6FA5z8rd2Krsvvkjw0z5G8My9Inh25eZ18fYWyAMNMldjoNWKmrUeVHZLZfxdDyYNdzCKkZsswOoQev0/rTzgO1P5V9jNvWIbKdZWy5bgwj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715534915; c=relaxed/simple;
	bh=yoD3v95RGwummZEVUok+lA5erasx7wbDTMozE5Oaj3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DAK8Htapvqn7zdIgNwDxjPVzm0dKwSmH55BhmnO/phsXw7Holhi+MwmyQKA9lO5r9b1mZ9nJnODw4vShY0p4J0bKzMZNaCns6Zh8Xq3EXBzg2Xwly45/w1f43Uq/zS2/klhDl22wMtOh1dQ7E7W+nmBar5aoVjiYpiCdGK1lNWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P0KyCyDK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55A47C116B1;
	Sun, 12 May 2024 17:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715534914;
	bh=yoD3v95RGwummZEVUok+lA5erasx7wbDTMozE5Oaj3Y=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=P0KyCyDKaU8O9AlnA1PLjeK92G0I4K0q1u/Uj08VU2XQSGnNQ1GT7g4fIcd3n0Kai
	 D0eIJg/O3XOXWD2MR4zs8+0T+GaVul08+B5NsJgIKgh4djYrb+l0r2eZ+Ac9kNbI/e
	 +sMlKnGgWtgZ5X4wVX8Y5jGQL9Xt3xsI4Gc3soxdIGUtxjaAKo9yPLKxqntjdYM0B8
	 x/Vtx0n5sd5oIQIzkuv8trjn+w+o5XaoX00L9vYS6smr7hXXPuqYZTJIsQAZ8tYRaH
	 K3E/+hVSy8cRxaUubCWeuWiSw9LvyjWX3w4Pwzt+ok+8PpPLKd8jasTjxNCfmXC4zj
	 43xHDByEu6lcA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id A10ADCE105C; Sun, 12 May 2024 10:28:33 -0700 (PDT)
Date: Sun, 12 May 2024 10:28:33 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-csky@vger.kernel.org, kernel-team@meta.com,
	viro@zeniv.linux.org.uk, elver@google.com,
	akpm@linux-foundation.org, tglx@linutronix.de, peterz@infradead.org,
	dianders@chromium.org, pmladek@suse.com, arnd@arndb.de,
	yujie.liu@intel.com, guoren@kernel.org
Subject: [GIT PULL] Native and emulated one-byte cmpxcha()g for v6.10
Message-ID: <a03cbcce-ac01-46e7-9fd5-c4f0b782c8df@paulmck-laptop>
Reply-To: paulmck@kernel.org
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello, Linus,

Please pull the following cmpxchg()-related changes:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/cmpxchg.2024.05.11a
  # HEAD: 5800e77d88c0cd98bc10460df148631afa7b5e4d: csky: Emulate one-byte cmpxchg (2024-05-11 07:07:07 -0700)

Please note that the commit and tag are quite recent.  However, the
only change was to add the architecture maintainer'a ack.  The exact
same change (other than the ack) has been in -next for quite some time.

Of course, if you would prefer that this exact commit be in -next for a
decent interval, please let me know and I will be happy to re-send this
pull request after a few days in -next.

----------------------------------------------------------------
sparc32,parisc,csky: Provide one-byte and two-byte cmpxchg() support

This series provides native one-byte and two-byte cmpxchg() support
for sparc32 and parisc, courtesy of Al Viro.  This support is provided
by the same hashed-array-of-locks technique used for the other atomic
operations provided for these two platforms.

This series also provides emulated one-byte cmpxchg() support for csky
using a new cmpxchg_emu_u8() function that uses a four-byte cmpxchg()
to emulate the one-byte variant.

Similar patches for emulation of one-byte cmpxchg() for arc, sh, and
xtensa have not yet received maintainer acks, so they are slated for
the v6.11 merge window.

----------------------------------------------------------------
Al Viro (8):
      sparc32: make __cmpxchg_u32() return u32
      sparc32: make the first argument of __cmpxchg_u64() volatile u64 *
      sparc32: unify __cmpxchg_u{32,64}
      sparc32: add __cmpxchg_u{8,16}() and teach __cmpxchg() to handle those sizes
      parisc: __cmpxchg_u32(): lift conversion into the callers
      parisc: unify implementations of __cmpxchg_u{8,32,64}
      parisc: add missing export of __cmpxchg_u8()
      parisc: add u16 support to cmpxchg()

Paul E. McKenney (2):
      lib: Add one-byte emulation function
      csky: Emulate one-byte cmpxchg

 arch/Kconfig                        |  3 +++
 arch/csky/Kconfig                   |  1 +
 arch/csky/include/asm/cmpxchg.h     | 10 +++++++
 arch/parisc/include/asm/cmpxchg.h   | 22 +++++++---------
 arch/parisc/kernel/parisc_ksyms.c   |  2 ++
 arch/parisc/lib/bitops.c            | 52 ++++++++++++-------------------------
 arch/sparc/include/asm/cmpxchg_32.h | 20 +++++++-------
 arch/sparc/lib/atomic32.c           | 45 ++++++++++++++------------------
 include/linux/cmpxchg-emu.h         | 15 +++++++++++
 lib/Makefile                        |  1 +
 lib/cmpxchg-emu.c                   | 45 ++++++++++++++++++++++++++++++++
 11 files changed, 133 insertions(+), 83 deletions(-)
 create mode 100644 include/linux/cmpxchg-emu.h
 create mode 100644 lib/cmpxchg-emu.c

