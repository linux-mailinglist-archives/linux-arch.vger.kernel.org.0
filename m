Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8A04C55EC
	for <lists+linux-arch@lfdr.de>; Sat, 26 Feb 2022 13:50:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231686AbiBZMtO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 26 Feb 2022 07:49:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbiBZMtN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 26 Feb 2022 07:49:13 -0500
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0BAB21E5012;
        Sat, 26 Feb 2022 04:48:38 -0800 (PST)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 21QCgprv028224;
        Sat, 26 Feb 2022 06:42:51 -0600
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 21QCgnST028222;
        Sat, 26 Feb 2022 06:42:49 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Sat, 26 Feb 2022 06:42:49 -0600
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jakob <jakobkoschel@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
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
Message-ID: <20220226124249.GU614@gate.crashing.org>
References: <20220217184829.1991035-1-jakobkoschel@gmail.com> <20220217184829.1991035-4-jakobkoschel@gmail.com> <CAHk-=wg1RdFQ6OGb_H4ZJoUwEr-gk11QXeQx63n91m0tvVUdZw@mail.gmail.com> <6DFD3D91-B82C-469C-8771-860C09BD8623@gmail.com> <CAHk-=wiyCH7xeHcmiFJ-YgXUy2Jaj7pnkdKpcovt8fYbVFW3TA@mail.gmail.com> <CAHk-=wgLe-OSLTEHm=V7eRG6Fcr0dpAM1ZRV1a=R_g6pBOr8Bg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wgLe-OSLTEHm=V7eRG6Fcr0dpAM1ZRV1a=R_g6pBOr8Bg@mail.gmail.com>
User-Agent: Mutt/1.4.2.3i
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 23, 2022 at 11:23:39AM -0800, Linus Torvalds wrote:
> On Wed, Feb 23, 2022 at 10:47 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Arnd - remind me, please.. Was there some other problem than just gcc-4.9?
> 
> Hmm. Interesting. I decided to just try it and see for the compiler I
> have, and changing the gnu89 to gnu99 I get new warnings
> (-Werror=shift-negative-value).
> 
> Very annoying.  Especially since negative values are in many contexts
> actually *safer* than positive ones when used as a mask, because as
> long as the top bit is set in 'int', if the end result is then
> expanded to some wider type, the top bit stays set.
> 
> Example:
> 
>   unsigned long mask(unsigned long x)
>   { return x & (~0 << 5); }
> 
>   unsigned long badmask(unsigned long x)
>   { return x & (~0u << 5); }
> 
> One does it properly, the other is buggy.

You won't get this confusion if you write -1 instead.  Not that that
helps your problem here.

The GCC documentation says (at
<https://gcc.gnu.org/onlinedocs/gcc/Integers-implementation.html>):

  - The results of some bitwise operations on signed integers (C90 6.3,
    C99 and C11 6.5).

    Bitwise operators act on the representation of the value including
    both the sign and value bits, where the sign bit is considered
    immediately above the highest-value value bit. Signed ‘>>’ acts on
    negative numbers by sign extension.

    As an extension to the C language, GCC does not use the latitude
    given in C99 and C11 only to treat certain aspects of signed ‘<<’ as
    undefined. However, -fsanitize=shift (and -fsanitize=undefined) will
    diagnose such cases. They are also diagnosed where constant
    expressions are required.

But in fact they are diagnosed more often:
===
unsigned int n;
int f0(int x) { return x & (~0 << 5); }
int f1(int x) { return x & (-1 << 5); }
int f2(int x) { return x & (~0 << n); }
int f3(int x) { return x & (-1 << n); }
===
gets a warning on every line:
===
shifty.c: In function 'f0':
shifty.c:2:32: warning: left shift of negative value [-Wshift-negative-value]
    2 | int f0(int x) { return x & (~0 << 5); }
      |                                ^~
shifty.c: In function 'f1':
shifty.c:3:32: warning: left shift of negative value [-Wshift-negative-value]
    3 | int f1(int x) { return x & (-1 << 5); }
      |                                ^~
shifty.c: In function 'f2':
shifty.c:4:32: warning: left shift of negative value [-Wshift-negative-value]
    4 | int f2(int x) { return x & (~0 << n); }
      |                                ^~
shifty.c: In function 'f3':
shifty.c:5:32: warning: left shift of negative value [-Wshift-negative-value]
    5 | int f3(int x) { return x & (-1 << n); }
      |                                ^~
===
(with -O2 -Wall -W, nothing more).  No constant expression is required
in any of those cases, and in f2 and f3 the shift is not a constant
expression even.

> So this Werror=shift-negative-value warning seems to be actively
> detrimental, and I'm not seeing the reason for it. Can somebody
> explain the thinking for that stupid warning?

-Werror=*anything* is detrimental, *always*.  Warnings are warnings
and errors are errors.  Warnings have false positives: if not, they
should be errors instead!

> That said, we seem to only have two cases of it in the kernel, at
> least by a x86-64 allmodconfig build. So we could examine the types
> there, or we could just add '-Wno-shift-negative-value".

Yes.

The only reason the warning exists is because it is undefined behaviour
(not implementation-defined or anything).  The reason it is that in the
standard is that it is hard to implement and even describe for machines
that are not two's complement.  However relevant that is today :-)


Segher
