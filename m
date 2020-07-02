Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4992F212BC2
	for <lists+linux-arch@lfdr.de>; Thu,  2 Jul 2020 19:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbgGBR7t (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Jul 2020 13:59:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:52286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726349AbgGBR7t (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 2 Jul 2020 13:59:49 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69C4F20737;
        Thu,  2 Jul 2020 17:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593712788;
        bh=vG1vBm6vstM6zzH+k1vdCUTH1v0SmoEIDUIITtr1D/0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=YSECcQsGgN0Kb258rQalKoY0GD0gMkQKjSrIAw4B93WGNrTMgWQ/6hr+oWDw+SXRG
         xKlKIQ4BaG/mRIGsMf9Tu1kJIwAlxOy0d4WAWr1fTaubryYquozE9wywm8Z/2siJrf
         mogkDnM5b8tk2Qmi8jhn2YzWtbDFbssSH7swTEv0=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 52653352334B; Thu,  2 Jul 2020 10:59:48 -0700 (PDT)
Date:   Thu, 2 Jul 2020 10:59:48 -0700
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
Message-ID: <20200702175948.GV9247@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200625085745.GD117543@hirez.programming.kicks-ass.net>
 <20200630191931.GA884155@elver.google.com>
 <20200630201243.GD4817@hirez.programming.kicks-ass.net>
 <20200630203016.GI9247@paulmck-ThinkPad-P72>
 <CANpmjNP+7TtE0WPU=nX5zs3T2+4hPkkm08meUm2VDVY3RgsHDw@mail.gmail.com>
 <20200701114027.GO4800@hirez.programming.kicks-ass.net>
 <20200701140654.GL9247@paulmck-ThinkPad-P72>
 <20200701150512.GH4817@hirez.programming.kicks-ass.net>
 <20200701160338.GN9247@paulmck-ThinkPad-P72>
 <20200702082040.GB4781@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702082040.GB4781@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jul 02, 2020 at 10:20:40AM +0200, Peter Zijlstra wrote:
> On Wed, Jul 01, 2020 at 09:03:38AM -0700, Paul E. McKenney wrote:
> 
> > But it looks like we are going to have to tell the compiler.
> 
> What does the current proposal look like? I can certainly annotate the
> seqcount latch users, but who knows what other code is out there....

For pointers, yes, within the Linux kernel it is hopeless, thus the
thought of a -fall-dependent-ptr or some such that makes the compiler
pretend that each and every pointer is marked with the _Dependent_ptr
qualifier.

New non-Linux-kernel code might want to use his qualifier explicitly,
perhaps something like the following:

	_Dependent_ptr struct foo *p;  // Or maybe after the "*"?

	rcu_read_lock();
	p = rcu_dereference(gp);
	// And so on...

If a function is to take a dependent pointer as a function argument,
then the corresponding parameter need the _Dependent_ptr marking.
Ditto for return values.

The proposal did not cover integers due to concerns about the number of
optimization passes that would need to be reviewed to make that work.
Nevertheless, using a marked integer would be safer than using an unmarked
one, and if the review can be carried out, why not?  Maybe something
like this:

	_Dependent_ptr int idx;

	rcu_read_lock();
	idx = READ_ONCE(gidx);
	d = rcuarray[idx];
	rcu_read_unlock();
	do_something_with(d);

So use of this qualifier is quite reasonable.

The prototype for GCC is here: https://github.com/AKG001/gcc/

							Thanx, Paul
