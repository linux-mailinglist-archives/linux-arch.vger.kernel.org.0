Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 597554C5F92
	for <lists+linux-arch@lfdr.de>; Sun, 27 Feb 2022 23:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbiB0Wtz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 27 Feb 2022 17:49:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232118AbiB0Wtz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 27 Feb 2022 17:49:55 -0500
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6025B5A080;
        Sun, 27 Feb 2022 14:49:17 -0800 (PST)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 21RMhqmu022704;
        Sun, 27 Feb 2022 16:43:53 -0600
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 21RMhqks022703;
        Sun, 27 Feb 2022 16:43:52 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Sun, 27 Feb 2022 16:43:52 -0600
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
Message-ID: <20220227224352.GA614@gate.crashing.org>
References: <20220217184829.1991035-1-jakobkoschel@gmail.com> <20220217184829.1991035-4-jakobkoschel@gmail.com> <CAHk-=wg1RdFQ6OGb_H4ZJoUwEr-gk11QXeQx63n91m0tvVUdZw@mail.gmail.com> <6DFD3D91-B82C-469C-8771-860C09BD8623@gmail.com> <CAHk-=wiyCH7xeHcmiFJ-YgXUy2Jaj7pnkdKpcovt8fYbVFW3TA@mail.gmail.com> <CAHk-=wgLe-OSLTEHm=V7eRG6Fcr0dpAM1ZRV1a=R_g6pBOr8Bg@mail.gmail.com> <20220226124249.GU614@gate.crashing.org> <CAK8P3a2Dd+ZMzn=gDnTzOW=S3RHQVmm1j3Gy=aKmFEbyD-q=rQ@mail.gmail.com> <20220227010956.GW614@gate.crashing.org> <CAK8P3a2bocgetbPQzy5xWhnW=mOdGynp_pWrPt6KeVTkEfEwKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2bocgetbPQzy5xWhnW=mOdGynp_pWrPt6KeVTkEfEwKg@mail.gmail.com>
User-Agent: Mutt/1.4.2.3i
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Feb 27, 2022 at 10:28:41PM +0100, Arnd Bergmann wrote:
> On Sun, Feb 27, 2022 at 2:09 AM Segher Boessenkool
> <segher@kernel.crashing.org> wrote:
> >
> > So imo we should just never do this by default, not just if the nasty
> > -fwrapv or nastier -fno-strict-overflow is used, just like we suggest
> > in our own documentation.  The only valid reason -Wshift-negative-value
> > is in -Wextra is it warns for situations that always are undefined
> > behaviour (even if not in GCC).
> 
> Ok, I just realized that this is specific to the i915 driver because
> that, unlike
> most of the kernel builds with -Wextra by default. -Wextra is enabled when
> users ask for a 'make W=1' build in linux, and i915 is one of just three
> drivers that enable an equivalent set of warnings, the other ones
> being greybus and btrfs.
> 
> This means to work around the extra warnings, we also just need to disable
> it in the W=1 part of scripts/Makefile.extrawarn, as well as the three drivers
> that copy those options, but not the default warnings that don't include them.

Ah good, all of the workaround in one simple place, neat.

> > Could you open a GCC PR for this?  The current situation is quite
> > suboptimal, and what we document as our implementation choice is much
> > more useful!
> 
> I hope I managed to capture the issue in
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=104711

That looks fine.  Thank you!

(I attached the testcase to the bug itself, we prefer it that way, maybe
godbolt will go away some day, who knows.)


Segher
