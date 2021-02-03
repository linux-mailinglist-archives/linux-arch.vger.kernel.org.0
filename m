Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB01930E115
	for <lists+linux-arch@lfdr.de>; Wed,  3 Feb 2021 18:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232173AbhBCR2F (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 Feb 2021 12:28:05 -0500
Received: from mga06.intel.com ([134.134.136.31]:4056 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231458AbhBCR2C (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 3 Feb 2021 12:28:02 -0500
IronPort-SDR: Wqj/6Lb6Bw8ddYYlNE0gGDbE7U7TzjhqD66GXa/y8gPBW8i14GAk8/KFoBzqEMHSP+L/ZPrEPI
 +4pjHgn2nSAQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9884"; a="242592372"
X-IronPort-AV: E=Sophos;i="5.79,399,1602572400"; 
   d="scan'208";a="242592372"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2021 09:27:20 -0800
IronPort-SDR: oA3PaKU9GGXLkN4skpI8G0zZ4UhSSLoR9DRe6hQucbEG5o+5YjsqiWfNaxB3rPrX2+LHoGRZ/K
 mexo0SkdBtGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,399,1602572400"; 
   d="scan'208";a="406723651"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by fmsmga004.fm.intel.com with ESMTP; 03 Feb 2021 09:27:19 -0800
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     bp@suse.de, tglx@linutronix.de, mingo@kernel.org, luto@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, dave.hansen@intel.com, hjl.tools@gmail.com,
        Dave.Martin@arm.com, jannh@google.com, mpe@ellerman.id.au,
        carlos@redhat.com, tony.luck@intel.com, ravi.v.shankar@intel.com,
        libc-alpha@sourceware.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: [PATCH v5 0/5] x86: Improve Minimum Alternate Stack Size
Date:   Wed,  3 Feb 2021 09:22:37 -0800
Message-Id: <20210203172242.29644-1-chang.seok.bae@intel.com>
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

Changes from v4 [9]:
* Moved the aux vector define to the generic header (Carlos O'Donell)

Changes from v3 [8]:
* Updated the changelog (Borislav Petkov)
* Revised the test messages again (Borislav Petkov)

Changes from v2 [7]:
* Simplified the sigaltstack overflow prevention (Jann Horn)
* Renamed fpstate size helper with cleanup (Borislav Petkov)
* Cleaned up the signframe struct size defines (Borislav Petkov)
* Revised the selftest messages (Borislav Petkov)
* Revised a changelog (Borislav Petkov)

Changes from v1 [6]:
* Took stack alignment into account for sigframe size (Dave Martin)

[1]: https://sourceware.org/git/?p=glibc.git;a=blob;f=sysdeps/unix/sysv/linux/bits/sigstack.h;h=b9dca794da09
3dc4d41d39db9851d444e1b54d9b;hb=HEAD
[2]: https://www.gnu.org/software/libc/manual/html_node/Signal-Stack.html
[3]: https://man7.org/linux/man-pages/man2/sigaltstack.2.html
[4]: https://bugzilla.kernel.org/show_bug.cgi?id=153531
[5]: https://blog.linuxplumbersconf.org/2017/ocw/system/presentations/4671/original/plumbers-dm-2017.pdf
[6]: https://lore.kernel.org/lkml/20200929205746.6763-1-chang.seok.bae@intel.com/
[7]: https://lore.kernel.org/lkml/20201119190237.626-1-chang.seok.bae@intel.com/
[8]: https://lore.kernel.org/lkml/20201223015312.4882-1-chang.seok.bae@intel.com/
[9]: https://lore.kernel.org/lkml/20210115211038.2072-1-chang.seok.bae@intel.com/

Chang S. Bae (5):
  uapi: Move the aux vector AT_MINSIGSTKSZ define to uapi
  x86/signal: Introduce helpers to get the maximum signal frame size
  x86/elf: Support a new ELF aux vector AT_MINSIGSTKSZ
  x86/signal: Detect and prevent an alternate signal stack overflow
  selftest/x86/signal: Include test cases for validating sigaltstack

 arch/arm64/include/uapi/asm/auxvec.h      |   1 -
 arch/x86/include/asm/elf.h                |   4 +
 arch/x86/include/asm/fpu/signal.h         |   2 +
 arch/x86/include/asm/sigframe.h           |   2 +
 arch/x86/include/uapi/asm/auxvec.h        |   4 +-
 arch/x86/kernel/cpu/common.c              |   3 +
 arch/x86/kernel/fpu/signal.c              |  19 ++++
 arch/x86/kernel/signal.c                  |  69 +++++++++++-
 include/uapi/linux/auxvec.h               |   1 +
 tools/testing/selftests/x86/Makefile      |   2 +-
 tools/testing/selftests/x86/sigaltstack.c | 128 ++++++++++++++++++++++
 11 files changed, 227 insertions(+), 8 deletions(-)
 create mode 100644 tools/testing/selftests/x86/sigaltstack.c

-- 
2.17.1

