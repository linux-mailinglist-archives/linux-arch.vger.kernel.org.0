Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1C382836D4
	for <lists+linux-arch@lfdr.de>; Mon,  5 Oct 2020 15:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbgJENpk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 5 Oct 2020 09:45:40 -0400
Received: from foss.arm.com ([217.140.110.172]:47844 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725936AbgJENpk (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 5 Oct 2020 09:45:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 96F92106F;
        Mon,  5 Oct 2020 06:45:39 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9B6933F70D;
        Mon,  5 Oct 2020 06:45:37 -0700 (PDT)
Date:   Mon, 5 Oct 2020 14:45:34 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     "Chang S. Bae" <chang.seok.bae@intel.com>
Cc:     tglx@linutronix.de, mingo@kernel.org, bp@suse.de, luto@kernel.org,
        x86@kernel.org, len.brown@intel.com, dave.hansen@intel.com,
        hjl.tools@gmail.com, mpe@ellerman.id.au, tony.luck@intel.com,
        ravi.v.shankar@intel.com, libc-alpha@sourceware.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/4] x86: Improve Minimum Alternate Stack Size
Message-ID: <20201005134534.GT6642@arm.com>
References: <20200929205746.6763-1-chang.seok.bae@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929205746.6763-1-chang.seok.bae@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Sep 29, 2020 at 01:57:42PM -0700, Chang S. Bae wrote:
> During signal entry, the kernel pushes data onto the normal userspace
> stack. On x86, the data pushed onto the user stack includes XSAVE state,
> which has grown over time as new features and larger registers have been
> added to the architecture.
> 
> MINSIGSTKSZ is a constant provided in the kernel signal.h headers and
> typically distributed in lib-dev(el) packages, e.g. [1]. Its value is
> compiled into programs and is part of the user/kernel ABI. The MINSIGSTKSZ
> constant indicates to userspace how much data the kernel expects to push on
> the user stack, [2][3].
> 
> However, this constant is much too small and does not reflect recent
> additions to the architecture. For instance, when AVX-512 states are in
> use, the signal frame size can be 3.5KB while MINSIGSTKSZ remains 2KB.
> 
> The bug report [4] explains this as an ABI issue. The small MINSIGSTKSZ can
> cause user stack overflow when delivering a signal.
> 
> In this series, we suggest a couple of things:
> 1. Provide a variable minimum stack size to userspace, as a similar
>    approach to [5]
> 2. Avoid using a too-small alternate stack

I can't comment on the x86 specifics, but the approach followed in this
series does seem consistent with the way arm64 populates
AT_MINSIGSTKSZ.

I need to dig up my glibc hacks for providing a sysconf interface to
this...

Cheers
---Dave

> 
> [1]: https://sourceware.org/git/?p=glibc.git;a=blob;f=sysdeps/unix/sysv/linux/bits/sigstack.h;h=b9dca794da093dc4d41d39db9851d444e1b54d9b;hb=HEAD
> [2]: https://www.gnu.org/software/libc/manual/html_node/Signal-Stack.html
> [3]: https://man7.org/linux/man-pages/man2/sigaltstack.2.html
> [4]: https://bugzilla.kernel.org/show_bug.cgi?id=153531
> [5]: https://blog.linuxplumbersconf.org/2017/ocw/system/presentations/4671/original/plumbers-dm-2017.pdf
> 
> Chang S. Bae (4):
>   x86/signal: Introduce helpers to get the maximum signal frame size
>   x86/elf: Support a new ELF aux vector AT_MINSIGSTKSZ
>   x86/signal: Prevent an alternate stack overflow before a signal
>     delivery
>   selftest/x86/signal: Include test cases for validating sigaltstack
> 
>  arch/x86/ia32/ia32_signal.c               |  11 +-
>  arch/x86/include/asm/elf.h                |   4 +
>  arch/x86/include/asm/fpu/signal.h         |   2 +
>  arch/x86/include/asm/sigframe.h           |  25 +++++
>  arch/x86/include/uapi/asm/auxvec.h        |   6 +-
>  arch/x86/kernel/cpu/common.c              |   3 +
>  arch/x86/kernel/fpu/signal.c              |  20 ++++
>  arch/x86/kernel/signal.c                  |  66 +++++++++++-
>  tools/testing/selftests/x86/Makefile      |   2 +-
>  tools/testing/selftests/x86/sigaltstack.c | 126 ++++++++++++++++++++++
>  10 files changed, 258 insertions(+), 7 deletions(-)
>  create mode 100644 tools/testing/selftests/x86/sigaltstack.c
> 
> --
> 2.17.1
> 
