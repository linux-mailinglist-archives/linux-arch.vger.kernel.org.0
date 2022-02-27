Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5F04C58E2
	for <lists+linux-arch@lfdr.de>; Sun, 27 Feb 2022 02:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiB0BRJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 26 Feb 2022 20:17:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiB0BRI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 26 Feb 2022 20:17:08 -0500
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5434989CC1;
        Sat, 26 Feb 2022 17:16:33 -0800 (PST)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 21R19wb7032672;
        Sat, 26 Feb 2022 19:09:58 -0600
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 21R19uhE032669;
        Sat, 26 Feb 2022 19:09:56 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Sat, 26 Feb 2022 19:09:56 -0600
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
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
Message-ID: <20220227010956.GW614@gate.crashing.org>
References: <20220217184829.1991035-1-jakobkoschel@gmail.com> <20220217184829.1991035-4-jakobkoschel@gmail.com> <CAHk-=wg1RdFQ6OGb_H4ZJoUwEr-gk11QXeQx63n91m0tvVUdZw@mail.gmail.com> <6DFD3D91-B82C-469C-8771-860C09BD8623@gmail.com> <CAHk-=wiyCH7xeHcmiFJ-YgXUy2Jaj7pnkdKpcovt8fYbVFW3TA@mail.gmail.com> <CAHk-=wgLe-OSLTEHm=V7eRG6Fcr0dpAM1ZRV1a=R_g6pBOr8Bg@mail.gmail.com> <20220226124249.GU614@gate.crashing.org> <CAK8P3a2Dd+ZMzn=gDnTzOW=S3RHQVmm1j3Gy=aKmFEbyD-q=rQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2Dd+ZMzn=gDnTzOW=S3RHQVmm1j3Gy=aKmFEbyD-q=rQ@mail.gmail.com>
User-Agent: Mutt/1.4.2.3i
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Feb 26, 2022 at 11:14:15PM +0100, Arnd Bergmann wrote:
> On Sat, Feb 26, 2022 at 1:42 PM Segher Boessenkool
> <segher@kernel.crashing.org> wrote:
> > On Wed, Feb 23, 2022 at 11:23:39AM -0800, Linus Torvalds wrote:
> 
> > > That said, we seem to only have two cases of it in the kernel, at
> > > least by a x86-64 allmodconfig build. So we could examine the types
> > > there, or we could just add '-Wno-shift-negative-value".
> >
> > Yes.
> >
> > The only reason the warning exists is because it is undefined behaviour
> > (not implementation-defined or anything).  The reason it is that in the
> > standard is that it is hard to implement and even describe for machines
> > that are not two's complement.  However relevant that is today :-)
> 
> Could gcc follow the clang behavior then and skip the warning and
> sanitizer for this case when -fno-strict-overflow or -fwrapv are used?

As I said, we have this implementation choice documented as
  As an extension to the C language, GCC does not use the latitude
  given in C99 and C11 only to treat certain aspects of signed '<<'
  as undefined.  However, '-fsanitize=shift' (and
  '-fsanitize=undefined') will diagnose such cases.  They are also
  diagnosed where constant expressions are required.
but that is not at all what we implement currently, we warn much more
often.  Constant expressions are required only in a few places (#if
condition, bitfield length, (non-variable) array length, enumeration
declarations, _Alignas, _Static_assert, case labels, most initialisers);
not places you will see code like this problem normally.

So imo we should just never do this by default, not just if the nasty
-fwrapv or nastier -fno-strict-overflow is used, just like we suggest
in our own documentation.  The only valid reason -Wshift-negative-value
is in -Wextra is it warns for situations that always are undefined
behaviour (even if not in GCC).

Could you open a GCC PR for this?  The current situation is quite
suboptimal, and what we document as our implementation choice is much
more useful!


Segher
