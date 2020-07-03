Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7AE213BF6
	for <lists+linux-arch@lfdr.de>; Fri,  3 Jul 2020 16:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbgGCOma (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Jul 2020 10:42:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:53204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbgGCOm3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 3 Jul 2020 10:42:29 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E97632070B;
        Fri,  3 Jul 2020 14:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593787349;
        bh=khFnCo/pGLEB19N//Rky8g6llITGKpNJBaJy6+SEmKk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=H8guQjP2EdQJuyTAIEJlqPZ9dTsE/gpVH4wDM9sewh1jG32DEAkI7fY/6EIPtfWRt
         NyBmWss1z52+Wh8CSogPzL9F5+r2IrZvHkDlIvzql19Whj6/KOdw2X9nWsqVjnP7x2
         mDq3KPpQdR9rPAyB7igZQy3EgXuvigRcXxfXcWFQ=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id D081235206C0; Fri,  3 Jul 2020 07:42:28 -0700 (PDT)
Date:   Fri, 3 Jul 2020 07:42:28 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Marco Elver <elver@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
Subject: Re: [PATCH 00/22] add support for Clang LTO
Message-ID: <20200703144228.GF9247@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200630201243.GD4817@hirez.programming.kicks-ass.net>
 <20200630203016.GI9247@paulmck-ThinkPad-P72>
 <CANpmjNP+7TtE0WPU=nX5zs3T2+4hPkkm08meUm2VDVY3RgsHDw@mail.gmail.com>
 <20200701114027.GO4800@hirez.programming.kicks-ass.net>
 <20200701140654.GL9247@paulmck-ThinkPad-P72>
 <20200701150512.GH4817@hirez.programming.kicks-ass.net>
 <20200701160338.GN9247@paulmck-ThinkPad-P72>
 <20200702082040.GB4781@hirez.programming.kicks-ass.net>
 <20200702175948.GV9247@paulmck-ThinkPad-P72>
 <20200703131330.GX4800@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200703131330.GX4800@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jul 03, 2020 at 03:13:30PM +0200, Peter Zijlstra wrote:
> On Thu, Jul 02, 2020 at 10:59:48AM -0700, Paul E. McKenney wrote:
> > On Thu, Jul 02, 2020 at 10:20:40AM +0200, Peter Zijlstra wrote:
> > > On Wed, Jul 01, 2020 at 09:03:38AM -0700, Paul E. McKenney wrote:
> > > 
> > > > But it looks like we are going to have to tell the compiler.
> > > 
> > > What does the current proposal look like? I can certainly annotate the
> > > seqcount latch users, but who knows what other code is out there....
> > 
> > For pointers, yes, within the Linux kernel it is hopeless, thus the
> > thought of a -fall-dependent-ptr or some such that makes the compiler
> > pretend that each and every pointer is marked with the _Dependent_ptr
> > qualifier.
> > 
> > New non-Linux-kernel code might want to use his qualifier explicitly,
> > perhaps something like the following:
> > 
> > 	_Dependent_ptr struct foo *p;  // Or maybe after the "*"?
> 
> After, as you've written it, it's a pointer to a '_Dependent struct
> foo'.

Yeah, I have to look that up every time.  :-/

Thank you for checking!

> > 	rcu_read_lock();
> > 	p = rcu_dereference(gp);
> > 	// And so on...
> > 
> > If a function is to take a dependent pointer as a function argument,
> > then the corresponding parameter need the _Dependent_ptr marking.
> > Ditto for return values.
> > 
> > The proposal did not cover integers due to concerns about the number of
> > optimization passes that would need to be reviewed to make that work.
> > Nevertheless, using a marked integer would be safer than using an unmarked
> > one, and if the review can be carried out, why not?  Maybe something
> > like this:
> > 
> > 	_Dependent_ptr int idx;
> > 
> > 	rcu_read_lock();
> > 	idx = READ_ONCE(gidx);
> > 	d = rcuarray[idx];
> > 	rcu_read_unlock();
> > 	do_something_with(d);
> > 
> > So use of this qualifier is quite reasonable.
> 
> The above usage might warrant a rename of the qualifier though, since
> clearly there isn't anything ptr around.

Given the large number of additional optimizations that need to be
suppressed in the non-pointer case, any discouragement based on the "_ptr"
at the end of the name is all to the good.

And if that line of reasoning is unconvincing, please look at the program
at the end of this email, which compiles without errors with -Wall and
gives the expected output.  ;-)

> > The prototype for GCC is here: https://github.com/AKG001/gcc/
> 
> Thanks! Those test cases are somewhat over qualified though:
> 
>        static volatile _Atomic (TYPE) * _Dependent_ptr a;     		\

Especially given that in C, _Atomic operations are implicitly volatile.
But this is likely a holdover from Akshat's implementation strategy,
which was to pattern _Dependent_ptr after the volatile keyword.

> Also, if C goes and specifies load dependencies, in any form, is then
> not the corrolary that they need to specify control dependencies? How
> else can they exclude the transformation.

By requiring that any temporaries generated from variables that are
marked _Dependent_ptr also be marked _Dependent_ptr.  This is of course
one divergence of _Dependent_ptr from the volatile keyword.

> And of course, once we're there, can we get explicit support for control
> dependencies too? :-) :-)

Keep talking like this and I am going to make sure that you attend a
standards committee meeting.  If need be, by arranging for you to be
physically dragged there.  ;-)

More seriously, for control dependencies, the variable that would need
to be marked would be the program counter, which might require some
additional syntax.

							Thanx, Paul

------------------------------------------------------------------------

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int foo(int *p, int i)
{
	return i[p];
}

int arr[] = { 0, 1, 4, 9, 16, 25, 36, 49, 64, 81, 100, 121, 144, };

int main(int argc, char *argv[])
{
	int i = atoi(argv[1]);

	printf("%d[arr] = %d\n", i, foo(arr, i));
	return 0;
}
