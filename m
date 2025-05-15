Return-Path: <linux-arch+bounces-11941-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE13AB86D6
	for <lists+linux-arch@lfdr.de>; Thu, 15 May 2025 14:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95EC8A0294D
	for <lists+linux-arch@lfdr.de>; Thu, 15 May 2025 12:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3557B29AB08;
	Thu, 15 May 2025 12:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WBITZfFD"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBE6746E;
	Thu, 15 May 2025 12:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747313210; cv=none; b=dq1UudPqEgigqVqVqNnjXal/RdCnPy4qQdsJtWt9AVVZMWxbo41MYK+Ilm1AFkBgRAduAqvsXH1eY1TLS6AvxglKfLRDZUc2YtrGxblR0iv0xItIroCw2iDFGd29iR13IB7JoVUolWz5dklMTagN3e+mhHM37iMICLtTaVGF95c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747313210; c=relaxed/simple;
	bh=m3KYv6Rn2bBNxlhOTi61aTylCT2vyDeFV8awtAgjra0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N5DllGTVb1KE2ieuononzzNZbtJxXejmS2VNgodzqaZsnRbjEWujz+Cie2jXCdNZbC9M2QujqfDewZj5KhMhw7jEFrpZ3Unl0l8DHJq+CSKCTkyrq323l3iNWVdQfcMGbIKCr+v7EbN+SRc4mRkSI8wPQE9FUe20D1vJYamnLhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WBITZfFD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 325C6C4CEE7;
	Thu, 15 May 2025 12:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747313209;
	bh=m3KYv6Rn2bBNxlhOTi61aTylCT2vyDeFV8awtAgjra0=;
	h=From:To:Cc:Subject:Date:From;
	b=WBITZfFDjjZky+w59MZcoQ9YS6bjZ9l4LuTdWiFJ35Qaqq39kazDbfDDdigQ77aQg
	 5DMWOvUXB355khA8CSDQEPvm8LGOCI5Z11ERC587m/eUd9MgjotV/MsSvqzpT/uhHb
	 7Iy37CDpb1DUUeJlF2OG/X9Oq9tlqxGYsH/LusTVdP62cP1IZ5Drg8fZwt0ULV1dwW
	 2knwQOff2hnpC6EN6u0QDlguTtJ2sIzdZQw/W0Ri/oaGntA1y51jU/HSpY4xVPgq5W
	 rcRUpWbDY5llI1bVdVyYMzhu6CRXFsWy8ZX+/ml7xcWgvEfKdfgGr2QBWgIE7vEvZn
	 mit6UwfKbcYPg==
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-arch@vger.kernel.org
Subject: [PATCH 00/15] Implement CONFIG_DEBUG_BUGVERBOSE_DETAILED=y, to improve WARN_ON_ONCE() output by adding the condition string
Date: Thu, 15 May 2025 14:46:29 +0200
Message-ID: <20250515124644.2958810-1-mingo@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in -v2:

 - Incorporated review feedback:

    - Make the expanded strings conditional on the new
      CONFIG_DEBUG_BUGVERBOSE_DETAILED=y switch, to address concerns
      about the +100K kernel size increase, disabled by default.

    - Expanded the Cc: fields

 - Rebased to v6.15-rc6

This tree can also be found at:

	git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git WIP.core/bugs

Thanks,

	Ingo

=========================>
Original -v1 announcement:

This series improves the current WARN_ON_ONCE() output, if
the new CONFIG_DEBUG_BUGVERBOSE_DETAILED=y option is enabled,
from:

  WARN_ON_ONCE(idx < 0 && ptr);
  ...

  WARNING: CPU: 0 PID: 0 at kernel/sched/core.c:8511 sched_init+0x20/0x410

to (on all __WARN_FLAGS() using architectures except S390):

  WARNING: [idx < 0 && ptr] kernel/sched/core.c:8511 at sched_init+0x20/0x410 CPU#0: swapper/0

(Note the addition of the '[condition string]', and a reorganized CPU/comm/PID trailer.)

... and on S390 and non-__WARN_FLAGS architectures to:

  WARNING: kernel/sched/core.c:8511 at sched_init+0x20/0x410 CPU#0: swapper/0

and on non-x86 architectures (the CPU/PID fields in the WARNING line are skipped):

  WARNING: kernel/sched/core.c:8511 sched_init+0x20/0x410
  CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 6.14.0-01616-g94d7af2844aa #4 PREEMPT(undef)

The motivation behind this series is the SCHED_WARN_ON() primitive that
got removed in the v6.14 merge window:

  f7d2728cc032 ("sched/debug: Change SCHED_WARN_ON() to WARN_ON_ONCE()")

... which produced more informative debug output, as it included the
WARN_ON_ONCE() condition string - at the expense of worse code generation.

This series, based on Linus's latest Git tree, merges the code generation
benefits of modern WARN_ON_ONCE() bug_entry architecture code with the expanded
information content of SCHED_WARN_ON().

The cost is about +100K more .data on a defconfig kernel, and no runtime
code generation impact:

       text       data        bss         dec        hex    filename
   29523998    7926322    1389904    38840224    250a7a0    vmlinux.x86.defconfig.before
   29523998    8024626    1389904    38938528    25227a0    vmlinue.x86.defconfig.after

On !CONFIG_DEBUG_BUGVERBOSE_DETAILED there's no size difference.

The series was build and boot tested on x86, with an expectation for it to
work on other architectures (with no testing at the moment to back up that
expectation).


    Ingo

================>
Ingo Molnar (15):
  bugs/core: Extend __WARN_FLAGS() with the 'cond_str' parameter
  bugs/core: Pass down the condition string of WARN_ON_ONCE(cond) warnings to __WARN_FLAGS()
  bugs/core: Introduce the CONFIG_DEBUG_BUGVERBOSE_DETAILED Kconfig switch
  bugs/x86: Extend _BUG_FLAGS() with the 'cond_str' parameter
  bugs/x86: Augment warnings output by concatenating 'cond_str' with the regular __FILE__ string in _BUG_FLAGS()
  bugs/powerpc: Pass in 'cond_str' to BUG_ENTRY()
  bugs/powerpc: Concatenate 'cond_str' with '__FILE__' in BUG_ENTRY(), to extend WARN_ON/BUG_ON output
  bugs/LoongArch: Pass in 'cond_str' to __BUG_ENTRY()
  bugs/LoongArch: Concatenate 'cond_str' with '__FILE__' in __BUG_ENTRY(), to extend WARN_ON/BUG_ON output
  bugs/s390: Pass in 'cond_str' to __EMIT_BUG()
  bugs/riscv: Pass in 'cond_str' to __BUG_FLAGS()
  bugs/riscv: Concatenate 'cond_str' with '__FILE__' in __BUG_FLAGS(), to extend WARN_ON/BUG_ON output
  bugs/parisc: Concatenate 'cond_str' with '__FILE__' in __WARN_FLAGS(), to extend WARN_ON/BUG_ON output
  bugs/sh: Concatenate 'cond_str' with '__FILE__' in __WARN_FLAGS(), to extend WARN_ON/BUG_ON output
  bugs/core: Reorganize fields in the first line of WARNING output, add ->comm[] output

 arch/arm64/include/asm/bug.h     |  2 +-
 arch/loongarch/include/asm/bug.h | 25 ++++++++++++-------------
 arch/parisc/include/asm/bug.h    |  6 +++---
 arch/powerpc/include/asm/bug.h   | 12 ++++++------
 arch/riscv/include/asm/bug.h     | 10 +++++-----
 arch/s390/include/asm/bug.h      | 10 +++++-----
 arch/sh/include/asm/bug.h        |  4 ++--
 arch/x86/include/asm/bug.h       | 14 +++++++-------
 include/asm-generic/bug.h        | 13 ++++++++++---
 kernel/panic.c                   | 16 +++++++++-------
 lib/Kconfig.debug                | 10 ++++++++++
 11 files changed, 70 insertions(+), 52 deletions(-)

-- 
2.45.2


