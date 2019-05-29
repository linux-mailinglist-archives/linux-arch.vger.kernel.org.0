Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69D5E2E11D
	for <lists+linux-arch@lfdr.de>; Wed, 29 May 2019 17:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726012AbfE2PdE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 29 May 2019 11:33:04 -0400
Received: from foss.arm.com ([217.140.101.70]:48232 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725914AbfE2PdE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 29 May 2019 11:33:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 004AB341;
        Wed, 29 May 2019 08:33:04 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0BEAA3F5AF;
        Wed, 29 May 2019 08:33:00 -0700 (PDT)
Date:   Wed, 29 May 2019 16:32:58 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Marco Elver <elver@google.com>, peterz@infradead.org
Cc:     aryabinin@virtuozzo.com, dvyukov@google.com, glider@google.com,
        andreyknvl@google.com, corbet@lwn.net, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        arnd@arndb.de, jpoimboe@redhat.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kasan-dev@googlegroups.com
Subject: Re: [PATCH v2 3/3] asm-generic, x86: Add bitops instrumentation for
 KASAN
Message-ID: <20190529153258.GJ31777@lakrids.cambridge.arm.com>
References: <20190529141500.193390-1-elver@google.com>
 <20190529141500.193390-4-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529141500.193390-4-elver@google.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, May 29, 2019 at 04:15:01PM +0200, Marco Elver wrote:
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
> Changes in v2:
> * Instrument word-sized accesses, as specified by the interface.
> ---
>  Documentation/core-api/kernel-api.rst     |   2 +-
>  arch/x86/include/asm/bitops.h             | 210 ++++----------
>  include/asm-generic/bitops-instrumented.h | 317 ++++++++++++++++++++++
>  3 files changed, 370 insertions(+), 159 deletions(-)
>  create mode 100644 include/asm-generic/bitops-instrumented.h

[...]

> diff --git a/include/asm-generic/bitops-instrumented.h b/include/asm-generic/bitops-instrumented.h
> new file mode 100644
> index 000000000000..b01b0dd93964
> --- /dev/null
> +++ b/include/asm-generic/bitops-instrumented.h
> @@ -0,0 +1,317 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +/*
> + * This file provides wrappers with sanitizer instrumentation for bit
> + * operations.
> + *
> + * To use this functionality, an arch's bitops.h file needs to define each of
> + * the below bit operations with an arch_ prefix (e.g. arch_set_bit(),
> + * arch___set_bit(), etc.), #define each provided arch_ function, and include
> + * this file after their definitions. For undefined arch_ functions, it is
> + * assumed that they are provided via asm-generic/bitops, which are implicitly
> + * instrumented.
> + */

If using the asm-generic/bitops.h, all of the below will be defined
unconditionally, so I don't believe we need the ifdeffery for each
function.

> +#ifndef _ASM_GENERIC_BITOPS_INSTRUMENTED_H
> +#define _ASM_GENERIC_BITOPS_INSTRUMENTED_H
> +
> +#include <linux/kasan-checks.h>
> +
> +#if defined(arch_set_bit)
> +/**
> + * set_bit - Atomically set a bit in memory
> + * @nr: the bit to set
> + * @addr: the address to start counting from
> + *
> + * This function is atomic and may not be reordered.  See __set_bit()
> + * if you do not require the atomic guarantees.
> + *
> + * Note: there are no guarantees that this function will not be reordered
> + * on non x86 architectures, so if you are writing portable code,
> + * make sure not to rely on its reordering guarantees.

These two paragraphs are contradictory.

Since this is not under arch/x86, please fix this to describe the
generic semantics; any x86-specific behaviour should be commented under
arch/x86.

AFAICT per include/asm-generic/bitops/atomic.h, generically this
provides no ordering guarantees. So I think this can be:

/**
 * set_bit - Atomically set a bit in memory
 * @nr: the bit to set
 * @addr: the address to start counting from
 *
 * This function is atomic and may be reordered.
 *
 * Note that @nr may be almost arbitrarily large; this function is not
 * restricted to acting on a single-word quantity.
 */

... with the x86 ordering beahviour commented in x86's arch_set_bit.

Peter, do you have a better wording for the above?

[...]

> +#if defined(arch___test_and_clear_bit)
> +/**
> + * __test_and_clear_bit - Clear a bit and return its old value
> + * @nr: Bit to clear
> + * @addr: Address to count from
> + *
> + * This operation is non-atomic and can be reordered.
> + * If two examples of this operation race, one can appear to succeed
> + * but actually fail.  You must protect multiple accesses with a lock.
> + *
> + * Note: the operation is performed atomically with respect to
> + * the local CPU, but not other CPUs. Portable code should not
> + * rely on this behaviour.
> + * KVM relies on this behaviour on x86 for modifying memory that is also
> + * accessed from a hypervisor on the same CPU if running in a VM: don't change
> + * this without also updating arch/x86/kernel/kvm.c
> + */

Likewise, please only specify the generic semantics in this header, and
leave the x86-specific behaviour commented under arch/x86.

Otherwise this looks sound to me.

Thanks,
Mark.
