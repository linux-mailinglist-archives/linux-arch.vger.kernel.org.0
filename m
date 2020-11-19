Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0191B2B9B2B
	for <lists+linux-arch@lfdr.de>; Thu, 19 Nov 2020 20:12:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727392AbgKSTGl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 19 Nov 2020 14:06:41 -0500
Received: from mga12.intel.com ([192.55.52.136]:21738 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727160AbgKSTGl (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 19 Nov 2020 14:06:41 -0500
IronPort-SDR: BEutbUlwzYkRLSFFuYoTIIw9J/Ud7cYFOkeZeot0N6uNOXxD+VcSchYAM+BeOpAlsyIQlmnpxB
 9FlkcI+XdzTw==
X-IronPort-AV: E=McAfee;i="6000,8403,9810"; a="150614461"
X-IronPort-AV: E=Sophos;i="5.78,354,1599548400"; 
   d="scan'208";a="150614461"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2020 11:06:39 -0800
IronPort-SDR: /LycEAwuD7D8NTvjhQxukEXdB9131AkvjDRbv7YVI1eXzkJ/47ZWL81OOQKr1Z9f7wuTYGB47H
 oc9i+TynSF4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,354,1599548400"; 
   d="scan'208";a="431333987"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by fmsmga001.fm.intel.com with ESMTP; 19 Nov 2020 11:06:39 -0800
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     tglx@linutronix.de, mingo@kernel.org, bp@suse.de, luto@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, dave.hansen@intel.com, hjl.tools@gmail.com,
        Dave.Martin@arm.com, mpe@ellerman.id.au, tony.luck@intel.com,
        ravi.v.shankar@intel.com, libc-alpha@sourceware.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, chang.seok.bae@intel.com
Subject: [PATCH v2 0/4] x86: Improve Minimum Alternate Stack Size
Date:   Thu, 19 Nov 2020 11:02:33 -0800
Message-Id: <20201119190237.626-1-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

[ We know there are a lot of Intel patches out there this week. We're
  posting this as early as we can in case anyone has bandwidth to take a
  look.  We don't think these are quite ready to be merged, but any review
  is appreciated. ]

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

Changes from v1 [6]:
* Took stack alignment into account for sigframe size (Dave Martin)

[1]: https://sourceware.org/git/?p=glibc.git;a=blob;f=sysdeps/unix/sysv/linux/bits/sigstack.h;h=b9dca794da093dc4d41d39db9851d444e1b54d9b;hb=HEAD
[2]: https://www.gnu.org/software/libc/manual/html_node/Signal-Stack.html
[3]: https://man7.org/linux/man-pages/man2/sigaltstack.2.html
[4]: https://bugzilla.kernel.org/show_bug.cgi?id=153531
[5]: https://blog.linuxplumbersconf.org/2017/ocw/system/presentations/4671/original/plumbers-dm-2017.pdf
[6]: https://lore.kernel.org/lkml/20200929205746.6763-1-chang.seok.bae@intel.com/

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
 arch/x86/kernel/signal.c                  |  82 +++++++++++++-
 tools/testing/selftests/x86/Makefile      |   2 +-
 tools/testing/selftests/x86/sigaltstack.c | 126 ++++++++++++++++++++++
 10 files changed, 272 insertions(+), 9 deletions(-)
 create mode 100644 tools/testing/selftests/x86/sigaltstack.c

-- 
2.17.1

