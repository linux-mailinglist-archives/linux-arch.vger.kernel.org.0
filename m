Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4CC27D97D
	for <lists+linux-arch@lfdr.de>; Tue, 29 Sep 2020 23:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729138AbgI2VBo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 29 Sep 2020 17:01:44 -0400
Received: from mga02.intel.com ([134.134.136.20]:60573 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728729AbgI2VBo (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 29 Sep 2020 17:01:44 -0400
IronPort-SDR: chJ2gBJXE8LCof6NiCxDl3C99+fmhBJ4tV/YY7CGxWQ0/+VX7DLfXf8TBe9CW9ubF3Lt37BVpH
 wq9XNm4a2MGQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9759"; a="149947655"
X-IronPort-AV: E=Sophos;i="5.77,319,1596524400"; 
   d="scan'208";a="149947655"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2020 14:01:22 -0700
IronPort-SDR: bFn8JtJ42VossFrlSUkzKDjyua51j/jF2FeiiAoBoXvDILU7PlBemmWR34TyuRuKfxE1NraZ6/
 TvBROEA/0eLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,319,1596524400"; 
   d="scan'208";a="514024807"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by fmsmga006.fm.intel.com with ESMTP; 29 Sep 2020 14:01:22 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     tglx@linutronix.de, mingo@kernel.org, bp@suse.de, luto@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, dave.hansen@intel.com, hjl.tools@gmail.com,
        Dave.Martin@arm.com, mpe@ellerman.id.au, tony.luck@intel.com,
        ravi.v.shankar@intel.com, libc-alpha@sourceware.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, chang.seok.bae@intel.com
Subject: [RFC PATCH 0/4] x86: Improve Minimum Alternate Stack Size
Date:   Tue, 29 Sep 2020 13:57:42 -0700
Message-Id: <20200929205746.6763-1-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

During signal entry, the kernel pushes data onto the normal userspace
stack. On x86, the data pushed onto the user stack includes XSAVE state,
which has grown over time as new features and larger registers have been
added to the architecture.

MINSIGSTKSZ is a constant provided in the kernel signal.h headers and
typically distributed in lib-dev(el) packages, e.g. [1]. Its value is
compiled into programs and is part of the user/kernel ABI. The MINSIGSTKSZ
constant indicates to userspace how much data the kernel expects to push on
the user stack, [2][3].

However, this constant is much too small and does not reflect recent
additions to the architecture. For instance, when AVX-512 states are in
use, the signal frame size can be 3.5KB while MINSIGSTKSZ remains 2KB.

The bug report [4] explains this as an ABI issue. The small MINSIGSTKSZ can
cause user stack overflow when delivering a signal.

In this series, we suggest a couple of things:
1. Provide a variable minimum stack size to userspace, as a similar
   approach to [5]
2. Avoid using a too-small alternate stack

[1]: https://sourceware.org/git/?p=glibc.git;a=blob;f=sysdeps/unix/sysv/linux/bits/sigstack.h;h=b9dca794da093dc4d41d39db9851d444e1b54d9b;hb=HEAD
[2]: https://www.gnu.org/software/libc/manual/html_node/Signal-Stack.html
[3]: https://man7.org/linux/man-pages/man2/sigaltstack.2.html
[4]: https://bugzilla.kernel.org/show_bug.cgi?id=153531
[5]: https://blog.linuxplumbersconf.org/2017/ocw/system/presentations/4671/original/plumbers-dm-2017.pdf

Chang S. Bae (4):
  x86/signal: Introduce helpers to get the maximum signal frame size
  x86/elf: Support a new ELF aux vector AT_MINSIGSTKSZ
  x86/signal: Prevent an alternate stack overflow before a signal
    delivery
  selftest/x86/signal: Include test cases for validating sigaltstack

 arch/x86/ia32/ia32_signal.c               |  11 +-
 arch/x86/include/asm/elf.h                |   4 +
 arch/x86/include/asm/fpu/signal.h         |   2 +
 arch/x86/include/asm/sigframe.h           |  25 +++++
 arch/x86/include/uapi/asm/auxvec.h        |   6 +-
 arch/x86/kernel/cpu/common.c              |   3 +
 arch/x86/kernel/fpu/signal.c              |  20 ++++
 arch/x86/kernel/signal.c                  |  66 +++++++++++-
 tools/testing/selftests/x86/Makefile      |   2 +-
 tools/testing/selftests/x86/sigaltstack.c | 126 ++++++++++++++++++++++
 10 files changed, 258 insertions(+), 7 deletions(-)
 create mode 100644 tools/testing/selftests/x86/sigaltstack.c

--
2.17.1

