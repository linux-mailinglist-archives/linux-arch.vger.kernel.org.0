Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7FE22CC9F
	for <lists+linux-arch@lfdr.de>; Tue, 28 May 2019 18:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbfE1Qun (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 May 2019 12:50:43 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:32960 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726786AbfE1Qum (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 28 May 2019 12:50:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 27DBB341;
        Tue, 28 May 2019 09:50:42 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3200F3F59C;
        Tue, 28 May 2019 09:50:39 -0700 (PDT)
Date:   Tue, 28 May 2019 17:50:36 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Marco Elver <elver@google.com>
Cc:     peterz@infradead.org, aryabinin@virtuozzo.com, dvyukov@google.com,
        glider@google.com, andreyknvl@google.com, corbet@lwn.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, arnd@arndb.de, jpoimboe@redhat.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, kasan-dev@googlegroups.com
Subject: Re: [PATCH 3/3] asm-generic, x86: Add bitops instrumentation for
 KASAN
Message-ID: <20190528165036.GC28492@lakrids.cambridge.arm.com>
References: <20190528163258.260144-1-elver@google.com>
 <20190528163258.260144-3-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190528163258.260144-3-elver@google.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, May 28, 2019 at 06:32:58PM +0200, Marco Elver wrote:
> This adds a new header to asm-generic to allow optionally instrumenting
> architecture-specific asm implementations of bitops.
> 
> This change includes the required change for x86 as reference and
> changes the kernel API doc to point to bitops-instrumented.h instead.
> Rationale: the functions in x86's bitops.h are no longer the kernel API
> functions, but instead the arch_ prefixed functions, which are then
> instrumented via bitops-instrumented.h.
> 
> Other architectures can similarly add support for asm implementations of
> bitops.
> 
> The documentation text has been copied/moved, and *no* changes to it
> have been made in this patch.
> 
> Tested: using lib/test_kasan with bitops tests (pre-requisite patch).
> 
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=198439
> Signed-off-by: Marco Elver <elver@google.com>
> ---
>  Documentation/core-api/kernel-api.rst     |   2 +-
>  arch/x86/include/asm/bitops.h             | 210 ++++----------
>  include/asm-generic/bitops-instrumented.h | 327 ++++++++++++++++++++++
>  3 files changed, 380 insertions(+), 159 deletions(-)
>  create mode 100644 include/asm-generic/bitops-instrumented.h

[...]

> +#if !defined(BITOPS_INSTRUMENT_RANGE)
> +/*
> + * This may be defined by an arch's bitops.h, in case bitops do not operate on
> + * single bytes only. The default version here is conservative and assumes that
> + * bitops operate only on the byte with the target bit.
> + */
> +#define BITOPS_INSTRUMENT_RANGE(addr, nr)                                  \
> +	(const volatile char *)(addr) + ((nr) / BITS_PER_BYTE), 1
> +#endif

I was under the impression that logically, all the bitops operated on
the entire long the bit happend to be contained in, so checking the
entire long would make more sense to me.

FWIW, arm64's atomic bit ops are all implemented atop of atomic_long_*
functions, which are instrumented, and always checks at the granularity
of a long. I haven't seen splats from that when fuzzing with Syzkaller.

Are you seeing bugs without this?

Thanks,
Mark.
