Return-Path: <linux-arch+bounces-4807-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A371B902A29
	for <lists+linux-arch@lfdr.de>; Mon, 10 Jun 2024 22:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A78151C237BA
	for <lists+linux-arch@lfdr.de>; Mon, 10 Jun 2024 20:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24354DA09;
	Mon, 10 Jun 2024 20:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JbjctN5u"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF8E4D8B6;
	Mon, 10 Jun 2024 20:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718052526; cv=none; b=ZGgV2zVjVIKnmp+MMTo6b89Fv237vz2YT6dNp6hLV2dUJmhc5Ofm3FYH3Os+TU8DG2bWf4Qlao6CfskpUx5j4AGi9ElKKkQkDe0Aye7VTPexEybmc8Jonhucaif9SSPvohmUSFnGlvdmp7NZSdvfI4/YPT9e4K7lTXB9/An5oS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718052526; c=relaxed/simple;
	bh=FOi86UUldJ0DWqgv3J6xhcGdiAK6DXsRyDRsaDmLflk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UqEh5NgkDJqJI7T6eg0Lqs40u4O+jES4KJ3eBMS8cLmWpcMEdc377x/uphAZEUotRpBF9EeGxRs5tsovtufzehu8gsrR5nKukiHV6nQ8CsyczjVP9YiuHWQd6ubTB9uV0f9N3RLIZcUjvmi7ovKX+5fCC5lKHc0xGbfFtWh0a1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=JbjctN5u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86479C32789;
	Mon, 10 Jun 2024 20:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1718052525;
	bh=FOi86UUldJ0DWqgv3J6xhcGdiAK6DXsRyDRsaDmLflk=;
	h=From:To:Cc:Subject:Date:From;
	b=JbjctN5ukgqDo74t/mtIe3qdJp7NLV6bNy0d+r9Tl9X8W2pffb0HzTbX9bcA2WglY
	 u3t5dDKfR3wnUKv9jy5lrQ7feHQUisP+6OvaVf+J0CmAu+oZQQoF9dp3n+rGQNrnT9
	 lhBQcb81GuKAGvcYAlquAO2mDYX4s1hUdkY5t/M8=
From: Linus Torvalds <torvalds@linux-foundation.org>
To: Peter Anvin <hpa@zytor.com>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	the arch/x86 maintainers <x86@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-arch <linux-arch@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 0/7] arm64 / x86-64: low-level code generation issues
Date: Mon, 10 Jun 2024 13:48:14 -0700
Message-ID: <20240610204821.230388-1-torvalds@linux-foundation.org>
X-Mailer: git-send-email 2.45.1.209.gc6f12300df
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

So this is the result of me doing some profiling on my 128-core Altra
box.  I've sent out versions of this before, but they've all been fairly
ugly partial series.

This is the full cleaned-up series with patches split up to be logical,
and with fixes from some of the commentary from previous patches.

The first four patches are for the 'runtime constant' code, where I did
the initial implementation on x86-64 just because I was more comfy with
that, and the arm64 version of it came once I had the x86-64 side
working.

The horror that is __d_lookup_rcu() shows up a lot more on my Altra box
because of the relatively pitiful caches, but it's something that I've
wanted on x86-64 before.  The arm64 numbers just made me bite the
bullet on the whole runtime constant thing.

The last three patches are purely arm64-specific, and just fix up some
nasty code generation in the user access functions.  I just noticed that
I will need to implement 'user_access_save()' for KCSAN now that I do
the unsafe user access functions. 

Anyway, that 'user_access_save/restore()' issue only shows up with
KCSAN.  And it would be a no-op thanks to arm64 doing SMAP the right way
(pet peeve: arm64 did what I told the x86 designers to do originally,
but they claimed was too hard, so we ended up with that CLAC/STAC
instead)... 

Sadly that "no-op for KCSAN" would is except for the horrid
CONFIG_ARM64_SW_TTBR0_PAN case, which is why I'm not touching it.  I'm
hoping some hapless^Whelpful arm64 person is willing to tackle this (or
maybe make KCSAN and ARM64_SW_TTBR0_PAN incompatible in the Kconfig). 

Note: the final access_ok() change in 7/7 is a API relaxation and
cleanup, and as such much more worrisome than the other patches.  It's
_simpler_ than the other patches, but the others aren't intended to
really change behavior.  That one does. 

Linus Torvalds (7):
  vfs: dcache: move hashlen_hash() from callers into d_hash()
  add default dummy 'runtime constant' infrastructure
  x86: add 'runtime constant' support
  arm64: add 'runtime constant' support
  arm64: start using 'asm goto' for get_user() when available
  arm64: start using 'asm goto' for put_user() when available
  arm64: access_ok() optimization

 arch/arm64/include/asm/runtime-const.h |  75 ++++++++++
 arch/arm64/include/asm/uaccess.h       | 191 +++++++++++++++++--------
 arch/arm64/kernel/mte.c                |  12 +-
 arch/arm64/kernel/vmlinux.lds.S        |   3 +
 arch/x86/include/asm/runtime-const.h   |  61 ++++++++
 arch/x86/kernel/vmlinux.lds.S          |   3 +
 fs/dcache.c                            |  17 ++-
 include/asm-generic/Kbuild             |   1 +
 include/asm-generic/runtime-const.h    |  15 ++
 include/asm-generic/vmlinux.lds.h      |   8 ++
 10 files changed, 319 insertions(+), 67 deletions(-)
 create mode 100644 arch/arm64/include/asm/runtime-const.h
 create mode 100644 arch/x86/include/asm/runtime-const.h
 create mode 100644 include/asm-generic/runtime-const.h

-- 
2.45.1.209.gc6f12300df


