Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C55984C58E7
	for <lists+linux-arch@lfdr.de>; Sun, 27 Feb 2022 02:24:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbiB0BZP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 26 Feb 2022 20:25:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiB0BZP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 26 Feb 2022 20:25:15 -0500
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7344615A232;
        Sat, 26 Feb 2022 17:24:39 -0800 (PST)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 21R1JEtP000676;
        Sat, 26 Feb 2022 19:19:14 -0600
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 21R1JEI3000675;
        Sat, 26 Feb 2022 19:19:14 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Sat, 26 Feb 2022 19:19:13 -0600
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jakob <jakobkoschel@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Mike Rapoport <rppt@kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
Subject: Re: [RFC PATCH 03/13] usb: remove the usage of the list iterator after the loop
Message-ID: <20220227011913.GX614@gate.crashing.org>
References: <20220217184829.1991035-1-jakobkoschel@gmail.com> <20220217184829.1991035-4-jakobkoschel@gmail.com> <CAHk-=wg1RdFQ6OGb_H4ZJoUwEr-gk11QXeQx63n91m0tvVUdZw@mail.gmail.com> <6DFD3D91-B82C-469C-8771-860C09BD8623@gmail.com> <CAHk-=wiyCH7xeHcmiFJ-YgXUy2Jaj7pnkdKpcovt8fYbVFW3TA@mail.gmail.com> <CAHk-=wgLe-OSLTEHm=V7eRG6Fcr0dpAM1ZRV1a=R_g6pBOr8Bg@mail.gmail.com> <20220226124249.GU614@gate.crashing.org> <CAK8P3a2Dd+ZMzn=gDnTzOW=S3RHQVmm1j3Gy=aKmFEbyD-q=rQ@mail.gmail.com> <CAHk-=wjAG2TZj5rEhiHyuD7KoffTLhikXy7OSj2f8QXAf7M=2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjAG2TZj5rEhiHyuD7KoffTLhikXy7OSj2f8QXAf7M=2A@mail.gmail.com>
User-Agent: Mutt/1.4.2.3i
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Feb 26, 2022 at 03:03:09PM -0800, Linus Torvalds wrote:
> On Sat, Feb 26, 2022 at 2:14 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > Could gcc follow the clang behavior then and skip the warning and
> > sanitizer for this case when -fno-strict-overflow or -fwrapv are used?
> 
> Well, for the kernel, that horse has already left the barn, and we'd
> have to use -Wno-shift-negative-value anyway.
> 
> But yes, from a sanity standpoint, it would be good to shut that
> warning up automatically if compiling for a 2's complement machine (ie
> "all of them") with -fwrapv.
> 
> Considering that gcc doesn't support any non-2's-complement machines
> anyway afaik,

   * 'Whether signed integer types are represented using sign and
     magnitude, two's complement, or one's complement, and whether the
     extraordinary value is a trap representation or an ordinary value
     (C99 and C11 6.2.6.2).'

     GCC supports only two's complement integer types, and all bit
     patterns are ordinary values.

> and that the C standards people are also fixing the
> standard, and gcc has never done anything odd in this area in the
> first place, I think the warning is probably best removed entirely.

Well, not removed, it correctly identifies (formally) undefined
behaviour after all; but I agree it should not be in -Wextra.

-Wall should include the warnings that have a very good balance for
usefulness, number of false postives, seriousness of problems found.
-Wextra is exactly the same conditions, just a slightly lower bar.

-Wall should be useful for everyone.  -Wall -W should be good for most
people.

> But we'll have to do it manually for the existing situation.

Yes, sorry about that :-/


Segher
