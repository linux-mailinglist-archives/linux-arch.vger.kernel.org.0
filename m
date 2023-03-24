Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3856C8269
	for <lists+linux-arch@lfdr.de>; Fri, 24 Mar 2023 17:34:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbjCXQd6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Mar 2023 12:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjCXQd4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Mar 2023 12:33:56 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 13DFCC65E;
        Fri, 24 Mar 2023 09:33:55 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E2C3A113E;
        Fri, 24 Mar 2023 09:34:38 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.56.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 17CBD3F6C4;
        Fri, 24 Mar 2023 09:33:52 -0700 (PDT)
Date:   Fri, 24 Mar 2023 16:32:52 +0000
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
Message-ID: <ZB3QtDYuWdpiD5qk@FVFF77S0Q05N>
References: <20230305205628.27385-1-ubizjak@gmail.com>
 <20230305205628.27385-2-ubizjak@gmail.com>
 <ZB2v+avNt52ac/+w@FVFF77S0Q05N>
 <CAFULd4ZCgxDYnyy--qdgKoAo_y7MbNSaQdbdBFefnFuMoM2OYw@mail.gmail.com>
 <ZB3MR8lGbnea9ui6@FVFF77S0Q05N>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZB3MR8lGbnea9ui6@FVFF77S0Q05N>
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Mar 24, 2023 at 04:14:22PM +0000, Mark Rutland wrote:
> On Fri, Mar 24, 2023 at 04:43:32PM +0100, Uros Bizjak wrote:
> > On Fri, Mar 24, 2023 at 3:13 PM Mark Rutland <mark.rutland@arm.com> wrote:
> > >
> > > On Sun, Mar 05, 2023 at 09:56:19PM +0100, Uros Bizjak wrote:
> > > > Cast _oldp to the type of _ptr to avoid incompatible-pointer-types warning.
> > >
> > > Can you give an example of where we are passing an incompatible pointer?
> > 
> > An example is patch 10/10 from the series, which will fail without
> > this fix when fallback code is used. We have:
> > 
> > -       } while (local_cmpxchg(&rb->head, offset, head) != offset);
> > +       } while (!local_try_cmpxchg(&rb->head, &offset, head));
> > 
> > where rb->head is defined as:
> > 
> > typedef struct {
> >    atomic_long_t a;
> > } local_t;
> > 
> > while offset is defined as 'unsigned long'.
> 
> Ok, but that's because we're doing the wrong thing to start with.
> 
> Since local_t is defined in terms of atomic_long_t, we should define the
> generic local_try_cmpxchg() in terms of atomic_long_try_cmpxchg(). We'll still
> have a mismatch between 'long *' and 'unsigned long *', but then we can fix
> that in the callsite:
> 
> 	while (!local_try_cmpxchg(&rb->head, &(long *)offset, head))

Sorry, that should be:
	
	while (!local_try_cmpxchg(&rb->head, (long *)&offset, head))

The fundamenalthing I'm trying to say is that the
atomic/atomic64/atomic_long/local/local64 APIs should be type-safe, and for
their try_cmpxchg() implementations, the type signature should be:

	${atomictype}_try_cmpxchg(${atomictype} *ptr, ${inttype} *old, ${inttype} new)

Thanks,
Mark.
