Return-Path: <linux-arch+bounces-4109-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B078B91C6
	for <lists+linux-arch@lfdr.de>; Thu,  2 May 2024 00:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A12AA1F21E38
	for <lists+linux-arch@lfdr.de>; Wed,  1 May 2024 22:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6563B50286;
	Wed,  1 May 2024 22:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZJLyLwH6"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C34F1C68D;
	Wed,  1 May 2024 22:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714604295; cv=none; b=JphfbnJRAihijelHeD5F/040PMPfFZ/iQ6g8Xqw4ynPJbvkCKLoLyPGD9lNUGK/7JeiVQtBpB3wQMN87/E2dcKWIpCALZIwbP0Zt4GOVhk7PgLkznQY0dR9DCcliGAYYeMnM8Qc2J1cdtz8xrlAUC8RGbQzj8V9W3THgLo7jw9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714604295; c=relaxed/simple;
	bh=ZWvjsFb5VqBM8uFd+mM9iEyIUARqHxE23HizvDxq/fs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B+gJLi9Nj5YlseD9NHX90m5vStw/2giYu4fIbwh/dzs5IdSH4iHd/xpAG0C3bnl6rng5TNtxJmhSktnmTDLEdVKWRiZVhsFWb+D2xwKXyPAjntEOlu4YhKzJZvBubxXGO42UcEMj6fdONEVLVDTOEPUwO2H7eqQwCQkES+3v4Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZJLyLwH6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C72F6C072AA;
	Wed,  1 May 2024 22:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714604294;
	bh=ZWvjsFb5VqBM8uFd+mM9iEyIUARqHxE23HizvDxq/fs=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=ZJLyLwH6f0paQVmgaGR/4UiHVduIBks9p5SIT4YGCPKZ0W+uMGicxK0wMpTc4StMt
	 +cHxdkJL4wdv76z2lq+JBdLPVPfZGTtZGZIP9nbojB57JtbdttYrYK0kY6s8nZt0uW
	 m+SqVEfAyap9RTBh+z1qQ5LjMjmdy1+2qGwzq8Ccd88oJSu+r1T4i/D+3KGF0jImqO
	 C7CF+LolVMDbamJM3YcoDRCXCmYgplURSPxWDKKIG2HrKA8vWnqXU9J3dyULrk4kqC
	 Ij7P3kPo3JLUrR262kwYyePqXinBYVMyulYDMgJGbkkxF+4N3Vg+lJn5KdX/aVt9l/
	 IXUhnmjQbjkiw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 60C63CE1073; Wed,  1 May 2024 15:58:14 -0700 (PDT)
Date: Wed, 1 May 2024 15:58:14 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: elver@google.com, akpm@linux-foundation.org, tglx@linutronix.de,
	peterz@infradead.org, dianders@chromium.org, pmladek@suse.com,
	torvalds@linux-foundation.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 cmpxchg 0/8] Provide emulation for one--byte cmpxchg()
Message-ID: <b67e79d4-06cb-4a45-a906-b9e0fbae22c5@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <31c82dcc-e203-48a9-aadd-f2fcd57d94c1@paulmck-laptop>
 <7b3646e0-667c-48e2-8f09-e493c43c30cb@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b3646e0-667c-48e2-8f09-e493c43c30cb@paulmck-laptop>

Hello!

This v2 series provides emulation functions for one-byte cmpxchg,
and uses it for those architectures not supporting this in hardware.
The emulation is in terms of the fully ordered four-byte cmpxchg() that
is supplied by all of these architectures.  This was tested by making
x86 forget that it can do one-byte cmpxchg() natively:

f0183ab28489 ("EXP arch/x86: Test one-byte cmpxchg emulation")

This commit is local to -rcu and is of course not intended for mainline.

If accepted, RCU Tasks will use this capability in place of the current
rcu_trc_cmpxchg_need_qs() open-coding of this emulation.

The patches are as follows:

1.	sparc32: make __cmpxchg_u32() return u32, courtesy of Al Viro.

2.	sparc32: make the first argument of __cmpxchg_u64() volatile u64 *,
	courtesy of Al Viro.

3.	sparc32: unify __cmpxchg_u{32,64}, courtesy of Al Viro.

4.	sparc32: add __cmpxchg_u{8,16}() and teach __cmpxchg() to handle those
	sizes, courtesy of Al Viro.

5.	parisc: __cmpxchg_u32(): lift conversion into the callers,
	courtesy of Al Viro.

6.	parisc: unify implementations of __cmpxchg_u{8,32,64}, courtesy of
	Al Viro.

7.	parisc: add missing export of __cmpxchg_u8(), courtesy of Al Viro.

8.	parisc: add u16 support to cmpxchg(), courtesy of Al Viro.

9.	lib: Add one-byte emulation function.

10.	ARC: Emulate one-byte cmpxchg.

11.	csky: Emulate one-byte cmpxchg.

12.	sh: Emulate one-byte cmpxchg.

13.	xtensa: Emulate one-byte cmpxchg.

Changes since v2:

o	Dropped riscv patch in favor of alternative patch that
	provides native support.

o	Fixed yet more casting bugs spotted by kernel test robot
	and by Geert Uytterhoeven.

Changes since v1:

o	Add native support for sparc32 and parisc, courtesy of Al Viro.

o	Remove two-byte emulation due to architectures that still do not
	support two-byte load and store instructions, per Arnd Bergmann
	feedback.  (Yes, there are a few systems out there that do not
	even support one-byte load instructions, but these are slated
	for removal anyway.)

o	Fix numerous casting bugs spotted by kernel test robot.

o	Fix SPDX header.  "//" for .c files and "/*" for .h files.
	I am sure that there is a good reason for this.  ;-)

						Thanx, Paul

------------------------------------------------------------------------

 arch/parisc/include/asm/cmpxchg.h     |   19 +++++-------
 arch/parisc/kernel/parisc_ksyms.c     |    1 
 arch/parisc/lib/bitops.c              |   52 +++++++++++-----------------------
 arch/sparc/include/asm/cmpxchg_32.h   |   18 +++++------
 arch/sparc/lib/atomic32.c             |   47 +++++++++++++-----------------
 b/arch/Kconfig                        |    3 +
 b/arch/arc/Kconfig                    |    1 
 b/arch/arc/include/asm/cmpxchg.h      |   33 +++++++++++++++------
 b/arch/csky/Kconfig                   |    1 
 b/arch/csky/include/asm/cmpxchg.h     |   10 ++++++
 b/arch/parisc/include/asm/cmpxchg.h   |    3 -
 b/arch/parisc/kernel/parisc_ksyms.c   |    1 
 b/arch/parisc/lib/bitops.c            |    6 +--
 b/arch/sh/Kconfig                     |    1 
 b/arch/sh/include/asm/cmpxchg.h       |    3 +
 b/arch/sparc/include/asm/cmpxchg_32.h |    4 +-
 b/arch/sparc/lib/atomic32.c           |    4 +-
 b/arch/xtensa/Kconfig                 |    1 
 b/arch/xtensa/include/asm/cmpxchg.h   |    2 +
 b/include/linux/cmpxchg-emu.h         |   15 +++++++++
 b/lib/Makefile                        |    1 
 b/lib/cmpxchg-emu.c                   |   45 +++++++++++++++++++++++++++++
 22 files changed, 172 insertions(+), 99 deletions(-)

