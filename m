Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08A5E6C4C81
	for <lists+linux-arch@lfdr.de>; Wed, 22 Mar 2023 14:55:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbjCVNzR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Mar 2023 09:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbjCVNzQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Mar 2023 09:55:16 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 106AF59E4B;
        Wed, 22 Mar 2023 06:55:13 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 87F004B3;
        Wed, 22 Mar 2023 06:55:57 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.53.3])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B32103F71E;
        Wed, 22 Mar 2023 06:55:10 -0700 (PDT)
Date:   Wed, 22 Mar 2023 13:55:08 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, agordeev@linux.ibm.com,
        aou@eecs.berkeley.edu, bp@alien8.de, catalin.marinas@arm.com,
        dave.hansen@linux.intel.com, davem@davemloft.net,
        gor@linux.ibm.com, hca@linux.ibm.com, linux-arch@vger.kernel.org,
        linux@armlinux.org.uk, mingo@redhat.com, palmer@dabbelt.com,
        paul.walmsley@sifive.com, robin.murphy@arm.com, tglx@linutronix.de,
        viro@zeniv.linux.org.uk, will@kernel.org
Subject: Re: [PATCH v2 1/4] lib: test copy_{to,from}_user()
Message-ID: <ZBsIvLUBNwYAjNUK@FVFF77S0Q05N>
References: <20230321122514.1743889-1-mark.rutland@arm.com>
 <20230321122514.1743889-2-mark.rutland@arm.com>
 <CAHk-=wgknoR11b+mX=AP8TcHP+gsFGdhPk7sJPROaQBBsqdubw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wgknoR11b+mX=AP8TcHP+gsFGdhPk7sJPROaQBBsqdubw@mail.gmail.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Mar 21, 2023 at 11:04:26AM -0700, Linus Torvalds wrote:
> On Tue, Mar 21, 2023 at 5:25 AM Mark Rutland <mark.rutland@arm.com> wrote:
> >
> > * arm64's copy_to_user() under-reports the number of bytes copied in
> >   some cases, e.g.
> 
> So I think this is the ok case.
> 
> > * arm's copy_to_user() under-reports the number of bytes copied in some
> >   cases, and both copy_to_user() and copy_from_user() don't guarantee
> >   that at least a single byte is copied when a partial copy is possible,
> 
> Again, this is ok historically.
> 
> > * i386's copy_from_user does not guarantee that at least a single byte
> >   is copied when a partial copit is possible, e.g.
> >
> >   | too few bytes consumed (offset=4093, size=8, ret=8)
> 
> And here's the real example of "we've always done this optimization".
> The exact details have differed, but the i386 case is the really
> really traditional one: it does word-at-a-time copies, and does *not*
> try to fall back to byte-wise copies. Never has.

Sure; I understand that. The reason for pointing this out is that Al was very
specific that implementations *must* guarantee this back in:

  https://lore.kernel.org/all/YNSyZaZtPTmTa5P8@zeniv-ca.linux.org.uk/

... and that this could be done by having the fixup handler try to copy a byte.

I had assumed that *something* depended upon that, but I don't know what that
something actually is.

I'm not wedded to the semantic either way; if that's not required I can drop it
from the tests.

> > * s390 passes all tests
> >
> > * sparc's copy_from_user() over-reports the number of bbytes copied in
> >   some caes, e.g.
> 
> So this case I think this is wrong, and an outright bug. That can
> cause people to think that uninitialized data is initialized, and leak
> sensitive information.

Agreed.

> > * x86_64 passes all tests
> 
> I suspect your testing is flawed due to being too limited, and x86-64
> having multiple different copying routines.

Sorry; I should've called that out explicitly. I'm aware I'm not testing all
the variants (I'd be happy to); I just wanted to check that I wasn't going off
into the weeds with the semantics first.

I probably should've sent this as an RFC...

> Yes, at some point we made everything be quite careful with
> "handle_tail" etc, but we end up still having things that fail early,
> and fail hard.
> 
> At a minimum, at least unsafe_copy_to_user() will fault and not do the
> "fill to the very last byte" case. Of course, that doesn't return a
> partial length (it only has a "fail" case), but it's an example of
> this whole thing where we haven't really been byte-exact when doing
> copies.

Sure; that does seem to be different structurally too, so it'd need to be
plumbed into the harness differently.

I'll note that's more like {get,put}_user() which similarly just have a fail
case (and a put_user() could do a parital write then fault).

> So again, I get the feeling that these rules may make sense from a
> validation standpoint, but I'm not 100% sure we should generally have
> to be this careful.

I'm more than happy to relax the tests (and the docs); I just need to know
where the boundary is between what we must guarantee and what's a nice-to-have.

Thanks,
Mark.
