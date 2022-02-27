Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E31FB4C5AA6
	for <lists+linux-arch@lfdr.de>; Sun, 27 Feb 2022 12:38:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbiB0LjG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 27 Feb 2022 06:39:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbiB0LjF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 27 Feb 2022 06:39:05 -0500
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 12DF222B18;
        Sun, 27 Feb 2022 03:38:26 -0800 (PST)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 21RBWpjr023197;
        Sun, 27 Feb 2022 05:32:51 -0600
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 21RBWjtP023189;
        Sun, 27 Feb 2022 05:32:45 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Sun, 27 Feb 2022 05:32:45 -0600
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     David Laight <David.Laight@aculab.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jakob <jakobkoschel@gmail.com>,
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
Message-ID: <20220227113245.GY614@gate.crashing.org>
References: <20220217184829.1991035-1-jakobkoschel@gmail.com> <20220217184829.1991035-4-jakobkoschel@gmail.com> <CAHk-=wg1RdFQ6OGb_H4ZJoUwEr-gk11QXeQx63n91m0tvVUdZw@mail.gmail.com> <6DFD3D91-B82C-469C-8771-860C09BD8623@gmail.com> <CAHk-=wiyCH7xeHcmiFJ-YgXUy2Jaj7pnkdKpcovt8fYbVFW3TA@mail.gmail.com> <CAHk-=wgLe-OSLTEHm=V7eRG6Fcr0dpAM1ZRV1a=R_g6pBOr8Bg@mail.gmail.com> <20220226124249.GU614@gate.crashing.org> <CAK8P3a2Dd+ZMzn=gDnTzOW=S3RHQVmm1j3Gy=aKmFEbyD-q=rQ@mail.gmail.com> <20220227010956.GW614@gate.crashing.org> <7abf3406919b4f0c828dacea6ce97ce8@AcuMS.aculab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7abf3406919b4f0c828dacea6ce97ce8@AcuMS.aculab.com>
User-Agent: Mutt/1.4.2.3i
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Feb 27, 2022 at 07:10:45AM +0000, David Laight wrote:
> From: Segher Boessenkool
> > Sent: 27 February 2022 01:10
> > On Sat, Feb 26, 2022 at 11:14:15PM +0100, Arnd Bergmann wrote:
> > > On Sat, Feb 26, 2022 at 1:42 PM Segher Boessenkool
> > > <segher@kernel.crashing.org> wrote:
> > > > The only reason the warning exists is because it is undefined behaviour
> > > > (not implementation-defined or anything).  The reason it is that in the
> > > > standard is that it is hard to implement and even describe for machines
> > > > that are not two's complement.  However relevant that is today :-)
> 
> I thought only right shifts of negative values were 'undefined'.

All shifts by a negative amount, or an amount greater or equal to the
width of the first operand (after the integer promotions).

Right shifts of a negative value.

Left shifts of a negative value where E1*2**E2 is not expressable in the
result type.

C90 (aka C89) had those right shifts merely implementation-defined
behaviour, and the left shifts perfectly well-defined.

> And that was to allow cpu that only had logical shift right
> (ie ones that didn't propagate the sign) to be conformant.

The C99 rationale says
  The C89 Committee affirmed the freedom in implementation granted by
  K&R in not requiring the signed right shift operation to sign extend,
  since such a requirement might slow down fast code and since the
  usefulness of sign extended shifts is marginal. (Shifting a negative
  two’s-complement integer arithmetically right one place is not the
  same as dividing by two!)

> I wonder when the last cpu like that was?

There still are one-off cores without such an instruction.  If you have
right shifts at all (if you have shifts at all!) it quickly becomes
apparent what a hassle it is not to have an SRA/ASR/SAR instruction, and
it is easy to implement, so :-)

The last widely spread ones' complement machine was the 6600 I guess,
which disappeared somewhere in the 80's.  Sign-magnitude machines are
still made: all FP is like that, and some (simple, embedded, etc.)
machines have no separate integer register set.  C is available for most
such fringe CPUs :-)

> Quite why the standards keeps using the term 'undefined behaviour'
> beats me - there ought to be something for 'undefined value'.

It is pretty much impossible to not have *some* undefined behaviour.
How will you define dividing by zero so that its behaviour is reasonable
for every program, for example?  Invoking an error handler at runtime
has most of the same unwanted effects, except is is never silent.  You
can get that via UBSAN for example.  Defining some arbitrary value as
the "correct" answer when that is not at all obvious *does* give silent,
unexpected results.

C does have "unspecified value"s and "unspecified behaviour".  It
requires the implementation to document the choice made here.  At least
some effort was made not to have undefined behaviour everywhere.

Perhaps C does have the concept you are after in 6.3.2/2, where it talks
about using uninitialised objects?  Of course, using an uninitialised
object is undefined behaviour :-P

C has much more undefined behaviours than most other languages.  On one
hand there was no clear, formal definition of the language (and
testsuites for it etc.) before it became popular.  On the other hand, it
was implemented on widely different architectures, back in the days when
there was a lot more variety in implementation choices than there is
now.  When the language was standardised (and all the way to this day)
the sentiment was to not unnecessarily break existing implementations.


Segher
