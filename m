Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 676E36C8237
	for <lists+linux-arch@lfdr.de>; Fri, 24 Mar 2023 17:14:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbjCXQOg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Mar 2023 12:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231473AbjCXQOd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Mar 2023 12:14:33 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EA0EE196AF;
        Fri, 24 Mar 2023 09:14:30 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 85CBC113E;
        Fri, 24 Mar 2023 09:15:14 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.55.116])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5F2B83F6C4;
        Fri, 24 Mar 2023 09:14:28 -0700 (PDT)
Date:   Fri, 24 Mar 2023 16:14:22 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH 01/10] locking/atomic: Add missing cast to try_cmpxchg()
 fallbacks
Message-ID: <ZB3MR8lGbnea9ui6@FVFF77S0Q05N>
References: <20230305205628.27385-1-ubizjak@gmail.com>
 <20230305205628.27385-2-ubizjak@gmail.com>
 <ZB2v+avNt52ac/+w@FVFF77S0Q05N>
 <CAFULd4ZCgxDYnyy--qdgKoAo_y7MbNSaQdbdBFefnFuMoM2OYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFULd4ZCgxDYnyy--qdgKoAo_y7MbNSaQdbdBFefnFuMoM2OYw@mail.gmail.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Mar 24, 2023 at 04:43:32PM +0100, Uros Bizjak wrote:
> On Fri, Mar 24, 2023 at 3:13 PM Mark Rutland <mark.rutland@arm.com> wrote:
> >
> > On Sun, Mar 05, 2023 at 09:56:19PM +0100, Uros Bizjak wrote:
> > > Cast _oldp to the type of _ptr to avoid incompatible-pointer-types warning.
> >
> > Can you give an example of where we are passing an incompatible pointer?
> 
> An example is patch 10/10 from the series, which will fail without
> this fix when fallback code is used. We have:
> 
> -       } while (local_cmpxchg(&rb->head, offset, head) != offset);
> +       } while (!local_try_cmpxchg(&rb->head, &offset, head));
> 
> where rb->head is defined as:
> 
> typedef struct {
>    atomic_long_t a;
> } local_t;
> 
> while offset is defined as 'unsigned long'.

Ok, but that's because we're doing the wrong thing to start with.

Since local_t is defined in terms of atomic_long_t, we should define the
generic local_try_cmpxchg() in terms of atomic_long_try_cmpxchg(). We'll still
have a mismatch between 'long *' and 'unsigned long *', but then we can fix
that in the callsite:

	while (!local_try_cmpxchg(&rb->head, &(long *)offset, head))

... which then won't silently mask issues elsewhere, and will be consistent
with all the other atomic APIs.

Thanks,
Mark.

> 
> The assignment in existing try_cmpxchg template:
> 
> typeof(*(_ptr)) *___op = (_oldp)
> 
> will trigger an initialization from an incompatible pointer type error.
> 
> Please note that x86 avoids this issue by a cast in its
> target-dependent definition:
> 
> #define __raw_try_cmpxchg(_ptr, _pold, _new, size, lock)                \
> ({                                                                      \
>        bool success;                                                   \
>        __typeof__(_ptr) _old = (__typeof__(_ptr))(_pold);              \
>        __typeof__(*(_ptr)) __old = *_old;                              \
>        __typeof__(*(_ptr)) __new = (_new);                             \
> 
> so, the warning/error will trigger only in the fallback code.
> 
> > That sounds indicative of a bug in the caller, but maybe I'm missing some
> > reason this is necessary due to some indirection.
> >
> > > Fixes: 29f006fdefe6 ("asm-generic/atomic: Add try_cmpxchg() fallbacks")
> >
> > I'm not sure that this needs a fixes tag. Does anything go wrong today, or only
> > later in this series?
> 
> The patch at [1] triggered a build error in posix_acl.c/__get.acl due
> to the same problem. The compilation for x86 target was OK, because
> x86 defines target-specific arch_try_cmpxchg, but the compilation
> broke for targets that revert to generic support. Please note that
> this specific problem was recently fixed in a different way [2], but
> the issue with the fallback remains.
> 
> [1] https://lore.kernel.org/lkml/20220714173819.13312-1-ubizjak@gmail.com/
> [2] https://lore.kernel.org/lkml/20221201160103.76012-1-ubizjak@gmail.com/
> 
> Uros.
