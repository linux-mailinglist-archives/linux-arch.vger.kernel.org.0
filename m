Return-Path: <linux-arch+bounces-3488-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC03A89CAFE
	for <lists+linux-arch@lfdr.de>; Mon,  8 Apr 2024 19:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62F6A288B2B
	for <lists+linux-arch@lfdr.de>; Mon,  8 Apr 2024 17:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F371442F6;
	Mon,  8 Apr 2024 17:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WGNktws4"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592AF143C64;
	Mon,  8 Apr 2024 17:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712598468; cv=none; b=iBM1y1t7EdVyimrjehWNJrXj8bRYGOHvZq9wI3XD3cQeUq8VW5EwkrL5uy9ZDK/SCTni65E+0py8MEL10Otk58woydMxtYsa3qf80Qd4abSvT6p6ygREKECsXJkj25pXqReCQR0+jjGBKIYfdBxmfGVNZWFsbaVBs8oQkOhjkPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712598468; c=relaxed/simple;
	bh=hthrMF23hrV7RDKnYkCQipSHR0wxEktgjaf796DaoDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LjxJOZZogjV0hzSRKXby9V9oYw6LukF8V1Cra7UN8DcbR/RUqwJw7nUlEQFSxfpAUbIAzs+v3xypf+ya5PGiDwy6JeyY1xRZpE13Ewmz+3miaPUZzsQ9tzl15/XDByfPSCM49ZBZCsriH6eGCHWdsQn/vVOAzVGfLNNOB6pexUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WGNktws4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE569C433F1;
	Mon,  8 Apr 2024 17:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712598467;
	bh=hthrMF23hrV7RDKnYkCQipSHR0wxEktgjaf796DaoDs=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=WGNktws4jrKrfs0hp9jzy2Rg5s6G+ayHXXoAJFBujBxETGjf8N+UUSKjr03tlm+C3
	 63k6v3IxOvf8o4z4eS3djGlgP8Iyo2ulyVQ2890TFXS14M5zm52QWY5hoMl8BBxniz
	 sTHOzbwiZPBP09ZFgQ+cDxcHZEPmONohpNmtaJMY/qImG/AcT9QfY2e0L0w8oT6sDB
	 QMzTi6K2KY7kpurfxHGFKOfRJLHmgcOMZJxfeiFIF3WDczzEonk+yUorBgj+iRGVBJ
	 zbMV0z9/+t/HJdkNMcf04aXWaSZbewcNOMQGRdod/ydnMmv05NSvvv/fIGM+uiadrh
	 O251MTKUs79NA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 6A1E4CE126C; Mon,  8 Apr 2024 10:47:46 -0700 (PDT)
Date: Mon, 8 Apr 2024 10:47:46 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: elver@google.com, akpm@linux-foundation.org, tglx@linutronix.de,
	peterz@infradead.org, dianders@chromium.org, pmladek@suse.com,
	torvalds@linux-foundation.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH RFC cmpxchg 0/8] Provide emulation for one- and two-byte
 cmpxchg()
Message-ID: <7b3646e0-667c-48e2-8f09-e493c43c30cb@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <31c82dcc-e203-48a9-aadd-f2fcd57d94c1@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31c82dcc-e203-48a9-aadd-f2fcd57d94c1@paulmck-laptop>

Hello!

This series provides emulation functions for one-byte cmpxchg, and uses it
for those architectures not supporting this in hardware.  The emulation
is in terms of the fully ordered four-byte cmpxchg() that is supplied
by all of these architectures.  This was tested by making x86 forget
that it can do one-byte cmpxchg() natively:

88a9b3f7a924 ("EXP arch/x86: Test one-byte cmpxchg emulation")

This commit is local to -rcu and is of course not intended for mainline.

If accepted, RCU Tasks will use this capability in place of the current
rcu_trc_cmpxchg_need_qs() open-coding of this emulation.

1.	sparc32: make __cmpxchg_u32() return u32, courtesy of Al Viro.

2.	sparc32: make the first argument of __cmpxchg_u64() volatile u64 *,
	courtesy of Al Viro.

3.	sparc32: unify __cmpxchg_u{32,64}, courtesy of Al Viro.

4.	sparc32: add __cmpxchg_u{8,16}() and teach __cmpxchg() to handle those
	sizes, courtesy of Al Viro.

5.	parisc: __cmpxchg_u32(): lift conversion into the callers, courtesy of
	Al Viro.

6.	parisc: unify implementations of __cmpxchg_u{8,32,64}, courtesy of
	Al Viro.

7.	parisc: add missing export of __cmpxchg_u8(), courtesy of Al Viro.

8.	parisc: add u16 support to cmpxchg(), courtesy of Al Viro.

9.	lib: Add one-byte emulation function.

10.	ARC: Emulate one-byte cmpxchg.

11.	csky: Emulate one-byte cmpxchg.

12.	sh: Emulate one-byte cmpxchg.

13.	xtensa: Emulate one-byte cmpxchg.

14.	riscv: Emulate one-byte cmpxchg.

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
 b/arch/arc/include/asm/cmpxchg.h      |   32 +++++++++++++++-----
 b/arch/csky/Kconfig                   |    1 
 b/arch/csky/include/asm/cmpxchg.h     |   10 ++++++
 b/arch/parisc/include/asm/cmpxchg.h   |    3 -
 b/arch/parisc/kernel/parisc_ksyms.c   |    1 
 b/arch/parisc/lib/bitops.c            |    6 +--
 b/arch/riscv/Kconfig                  |    1 
 b/arch/riscv/include/asm/cmpxchg.h    |   13 ++++++++
 b/arch/sh/Kconfig                     |    1 
 b/arch/sh/include/asm/cmpxchg.h       |    2 +
 b/arch/sparc/include/asm/cmpxchg_32.h |    4 +-
 b/arch/sparc/lib/atomic32.c           |    4 +-
 b/arch/xtensa/Kconfig                 |    1 
 b/arch/xtensa/include/asm/cmpxchg.h   |    2 +
 b/include/linux/cmpxchg-emu.h         |   15 +++++++++
 b/lib/Makefile                        |    1 
 b/lib/cmpxchg-emu.c                   |   45 +++++++++++++++++++++++++++++
 24 files changed, 184 insertions(+), 99 deletions(-)

