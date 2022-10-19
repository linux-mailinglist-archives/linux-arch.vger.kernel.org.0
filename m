Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 481D5604F22
	for <lists+linux-arch@lfdr.de>; Wed, 19 Oct 2022 19:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231529AbiJSRqf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Oct 2022 13:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231509AbiJSRqZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Oct 2022 13:46:25 -0400
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A17531C843D;
        Wed, 19 Oct 2022 10:46:22 -0700 (PDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 29JHhjS0005682;
        Wed, 19 Oct 2022 12:43:46 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 29JHhjxm005681;
        Wed, 19 Oct 2022 12:43:45 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Wed, 19 Oct 2022 12:43:45 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-toolchains@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] kbuild: treat char as always signed
Message-ID: <20221019174345.GM25951@gate.crashing.org>
References: <20221019162648.3557490-1-Jason@zx2c4.com> <20221019165455.GL25951@gate.crashing.org> <CAHk-=wiMWk2t8FHn0iqVVe1mn62OTAD6ffL5rn9Eeu021H9d1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiMWk2t8FHn0iqVVe1mn62OTAD6ffL5rn9Eeu021H9d1Q@mail.gmail.com>
User-Agent: Mutt/1.4.2.3i
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi!

On Wed, Oct 19, 2022 at 10:14:20AM -0700, Linus Torvalds wrote:
> On Wed, Oct 19, 2022 at 9:57 AM Segher Boessenkool
> <segher@kernel.crashing.org> wrote:
> >
> > This is an ABI change.  It is also hugely detrimental to generated
> > code quality on architectures that make the saner choice (that is, have
> > most instructions zero-extend byte quantities).
> 
> Yeah, I agree. We should just accept the standard wording, and be
> aware that 'char' has indeterminate signedness.

And plain "char" is a separate type from "signed char" and "unsigned
char" both.

> But:
> 
> > Instead, don't actively disable the compiler warnings that catch such
> > cases?  So start with removing footguns like
> >
> >   # disable pointer signed / unsigned warnings in gcc 4.0
> >   KBUILD_CFLAGS += -Wno-pointer-sign
> 
> Nope, that won't fly.
> 
> The pointer-sign thing doesn't actually help (ie it won't find places
> where you actually compare a char), and it causes untold damage in
> doing completely insane things.

When I did this more than a decade ago there indeed was a LOT of noise,
mostly caused by dubious code.  I do agree many cases detected are not
very important, but it also revealed cases where a filesystem's disk
format changed (atarifs or amigafs or such iirc) -- many cases it is
annoying to be reminded of sloppy code, but in some cases it detects
crucial problems.

> Seriously, -Wpointer-sign is not just useless, it's actively _evil_.

Then suggest something better?  Or suggest improvements to the existing
warning?

This warning is part of -Wall, most people must not have problems with
it (or people are so apathetic about this that they have not complained
about it).

It is easy to improve your code when the compiler detects problems like
this.  Of course after such a long time of lax code sanity enforcement
you get all warnings at once :-/

> The fact that you suggest that clearly means that you've never used
> it.

Ah, ad hominems.  Great.


Segher
