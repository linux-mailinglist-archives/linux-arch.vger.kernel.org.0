Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE7BA2F875C
	for <lists+linux-arch@lfdr.de>; Fri, 15 Jan 2021 22:16:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726223AbhAOVQQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 Jan 2021 16:16:16 -0500
Received: from mga18.intel.com ([134.134.136.126]:45764 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725772AbhAOVQO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 15 Jan 2021 16:16:14 -0500
IronPort-SDR: RI4Kcaqo+gk+gcivpGA0f19Br7mLt6DZpO1sjsHuyEIvu+n7CMDwU6JC60q+tIjneak7U4bh3H
 ffEleScTPl9w==
X-IronPort-AV: E=McAfee;i="6000,8403,9865"; a="166277105"
X-IronPort-AV: E=Sophos;i="5.79,350,1602572400"; 
   d="scan'208";a="166277105"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2021 13:15:15 -0800
IronPort-SDR: 1M9GAuDspsCvPRQeL54zCIkrCO/CE9pz+yzb+uIZgY7SGHnGEyFzv9KH02kHfmSz33rsLU2WsC
 ciQVcXt9ZPmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,350,1602572400"; 
   d="scan'208";a="401418959"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by fmsmga002.fm.intel.com with ESMTP; 15 Jan 2021 13:15:15 -0800
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     bp@suse.de, tglx@linutronix.de, mingo@kernel.org, luto@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, dave.hansen@intel.com, hjl.tools@gmail.com,
        Dave.Martin@arm.com, jannh@google.com, mpe@ellerman.id.au,
        tony.luck@intel.com, ravi.v.shankar@intel.com,
        libc-alpha@sourceware.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: [PATCH v4 0/4] x86: Improve Minimum Alternate Stack Size
Date:   Fri, 15 Jan 2021 13:10:34 -0800
Message-Id: <20210115211038.2072-1-chang.seok.bae@intel.com>
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

[1]: https://sourceware.org/git/?p=glibc.git;a=blob;f=sysdeps/unix/sysv/linux/bits/sigstack.h;h=b9dca794da093dc4d41d39db9851d444e1b54d9b;hb=HEAD
[2]: https://www.gnu.org/software/libc/manual/html_node/Signal-Stack.html
[3]: https://man7.org/linux/man-pages/man2/sigaltstack.2.html
[4]: https://bugzilla.kernel.org/show_bug.cgi?id=153531
[5]: https://blog.linuxplumbersconf.org/2017/ocw/system/presentations/4671/original/plumbers-dm-2017.pdf
[6]: https://lore.kernel.org/lkml/20200929205746.6763-1-chang.seok.bae@intel.com/
[7]: https://lore.kernel.org/lkml/20201119190237.626-1-chang.seok.bae@intel.com/
[8]: https://lore.kernel.org/lkml/20201223015312.4882-1-chang.seok.bae@intel.com/

Chang S. Bae (4):
  x86/signal: Introduce helpers to get the maximum signal frame size
  x86/elf: Support a new ELF aux vector AT_MINSIGSTKSZ
  x86/signal: Detect and prevent an alternate signal stack overflow
  selftest/x86/signal: Include test cases for validating sigaltstack

 arch/x86/include/asm/elf.h                |   4 +
 arch/x86/include/asm/fpu/signal.h         |   2 +
 arch/x86/include/asm/sigframe.h           |   2 +
 arch/x86/include/uapi/asm/auxvec.h        |   6 +-
 arch/x86/kernel/cpu/common.c              |   3 +
 arch/x86/kernel/fpu/signal.c              |  19 ++++
 arch/x86/kernel/signal.c                  |  69 +++++++++++-
 tools/testing/selftests/x86/Makefile      |   2 +-
 tools/testing/selftests/x86/sigaltstack.c | 128 ++++++++++++++++++++++
 9 files changed, 228 insertions(+), 7 deletions(-)
 create mode 100644 tools/testing/selftests/x86/sigaltstack.c

-- 
2.17.1

