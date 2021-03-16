Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9EDA33CE2F
	for <lists+linux-arch@lfdr.de>; Tue, 16 Mar 2021 07:57:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233939AbhCPG5N (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 Mar 2021 02:57:13 -0400
Received: from mga07.intel.com ([134.134.136.100]:44607 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235766AbhCPG5M (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 16 Mar 2021 02:57:12 -0400
IronPort-SDR: gK2TuscX5yf2Xi4jEYj3BpxvHx/QsOuUwiciImASBPFImq4RiZoLf8Y+nQjGs+Ycw7jBoa5gDr
 XoNHpkrNl5XQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9924"; a="253227830"
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; 
   d="scan'208";a="253227830"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2021 23:57:11 -0700
IronPort-SDR: qnpBGRE2wppZL6tplYqEm0jVKNV60UXK9XAj1XjenkDdKKw1lubXGnQNqiT9J9tG8UKh7kQiNc
 euuofBv8/mqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; 
   d="scan'208";a="511296069"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by fmsmga001.fm.intel.com with ESMTP; 15 Mar 2021 23:57:11 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     bp@suse.de, tglx@linutronix.de, mingo@kernel.org, luto@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, dave.hansen@intel.com, hjl.tools@gmail.com,
        Dave.Martin@arm.com, jannh@google.com, mpe@ellerman.id.au,
        carlos@redhat.com, tony.luck@intel.com, ravi.v.shankar@intel.com,
        libc-alpha@sourceware.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: [PATCH v7 0/6] x86: Improve Minimum Alternate Stack Size
Date:   Mon, 15 Mar 2021 23:52:09 -0700
Message-Id: <20210316065215.23768-1-chang.seok.bae@intel.com>
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
   approach to [5].
2. Avoid using a too-small alternate stack.

Changes from v6 [11]:
* Updated and fixed the documentation. (Borislav Petkov)
* Revised the AT_MINSIGSTKSZ comment. (Borislav Petkov)

Changes form v5 [10]:
* Fixed the overflow detection. (Andy Lutomirski)
* Reverted the AT_MINSIGSTKSZ removal on arm64. (Dave Martin)
* Added a documentation about the x86 AT_MINSIGSTKSZ.
* Supported the existing sigaltstack test to use the new aux vector.

Changes from v4 [9]:
* Moved the aux vector define to the generic header. (Carlos O'Donell)

Changes from v3 [8]:
* Updated the changelog. (Borislav Petkov)
* Revised the test messages again. (Borislav Petkov)

Changes from v2 [7]:
* Simplified the sigaltstack overflow prevention. (Jann Horn)
* Renamed fpstate size helper with cleanup. (Borislav Petkov)
* Cleaned up the signframe struct size defines. (Borislav Petkov)
* Revised the selftest messages. (Borislav Petkov)
* Revised a changelog. (Borislav Petkov)

Changes from v1 [6]:
* Took stack alignment into account for sigframe size. (Dave Martin)

[1]: https://sourceware.org/git/?p=glibc.git;a=blob;f=sysdeps/unix/sysv/linux/bits/sigstack.h;h=b9dca794da093dc4d41d39db9851d444e1b54d9b;hb=HEAD
[2]: https://www.gnu.org/software/libc/manual/html_node/Signal-Stack.html
[3]: https://man7.org/linux/man-pages/man2/sigaltstack.2.html
[4]: https://bugzilla.kernel.org/show_bug.cgi?id=153531
[5]: https://blog.linuxplumbersconf.org/2017/ocw/system/presentations/4671/original/plumbers-dm-2017.pdf
[6]: https://lore.kernel.org/lkml/20200929205746.6763-1-chang.seok.bae@intel.com/
[7]: https://lore.kernel.org/lkml/20201119190237.626-1-chang.seok.bae@intel.com/
[8]: https://lore.kernel.org/lkml/20201223015312.4882-1-chang.seok.bae@intel.com/
[9]: https://lore.kernel.org/lkml/20210115211038.2072-1-chang.seok.bae@intel.com/
[10]: https://lore.kernel.org/lkml/20210203172242.29644-1-chang.seok.bae@intel.com/
[11]: https://lore.kernel.org/lkml/20210227165911.32757-1-chang.seok.bae@intel.com/

Chang S. Bae (6):
  uapi: Define the aux vector AT_MINSIGSTKSZ
  x86/signal: Introduce helpers to get the maximum signal frame size
  x86/elf: Support a new ELF aux vector AT_MINSIGSTKSZ
  selftest/sigaltstack: Use the AT_MINSIGSTKSZ aux vector if available
  x86/signal: Detect and prevent an alternate signal stack overflow
  selftest/x86/signal: Include test cases for validating sigaltstack

 Documentation/x86/elf_auxvec.rst          |  53 +++++++++
 Documentation/x86/index.rst               |   1 +
 arch/x86/include/asm/elf.h                |   4 +
 arch/x86/include/asm/fpu/signal.h         |   2 +
 arch/x86/include/asm/sigframe.h           |   2 +
 arch/x86/include/uapi/asm/auxvec.h        |   4 +-
 arch/x86/kernel/cpu/common.c              |   3 +
 arch/x86/kernel/fpu/signal.c              |  19 ++++
 arch/x86/kernel/signal.c                  |  72 +++++++++++-
 include/uapi/linux/auxvec.h               |   3 +
 tools/testing/selftests/sigaltstack/sas.c |  20 +++-
 tools/testing/selftests/x86/Makefile      |   2 +-
 tools/testing/selftests/x86/sigaltstack.c | 128 ++++++++++++++++++++++
 13 files changed, 300 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/x86/elf_auxvec.rst
 create mode 100644 tools/testing/selftests/x86/sigaltstack.c


base-commit: 1e28eed17697bcf343c6743f0028cc3b5dd88bf0
-- 
2.17.1

