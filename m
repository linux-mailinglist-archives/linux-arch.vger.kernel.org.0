Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E435215BC0
	for <lists+linux-arch@lfdr.de>; Mon,  6 Jul 2020 18:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729435AbgGFQ0e (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Jul 2020 12:26:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:59546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729358AbgGFQ0e (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 6 Jul 2020 12:26:34 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-111-31.bvtn.or.frontiernet.net [50.39.111.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C63D220702;
        Mon,  6 Jul 2020 16:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594052793;
        bh=ELC0Qf8GBOcW7d74k7xE/syM0cqkEfG1ZwnEhNH0Xwc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=NWnqF8yNh1kmeojBtU/hvJnKQi+pZfEw8tRN6xyWsQTMlbnwqrlnw5lTOXvjlFbT7
         B5rw2d8haDBAV5oFbA0B0HdNl5tN/Er570PuYfYx1NWaxj3XhsCuq3jsWx3nC14oRK
         3IoGxJUeXAP3v3i6Usrl18oSx/B8BE0q7l0vU15Q=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id B23463521502; Mon,  6 Jul 2020 09:26:33 -0700 (PDT)
Date:   Mon, 6 Jul 2020 09:26:33 -0700
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
Message-ID: <20200706162633.GA13288@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200630203016.GI9247@paulmck-ThinkPad-P72>
 <CANpmjNP+7TtE0WPU=nX5zs3T2+4hPkkm08meUm2VDVY3RgsHDw@mail.gmail.com>
 <20200701114027.GO4800@hirez.programming.kicks-ass.net>
 <20200701140654.GL9247@paulmck-ThinkPad-P72>
 <20200701150512.GH4817@hirez.programming.kicks-ass.net>
 <20200701160338.GN9247@paulmck-ThinkPad-P72>
 <20200702082040.GB4781@hirez.programming.kicks-ass.net>
 <20200702175948.GV9247@paulmck-ThinkPad-P72>
 <20200703131330.GX4800@hirez.programming.kicks-ass.net>
 <20200703144228.GF9247@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200703144228.GF9247@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jul 03, 2020 at 07:42:28AM -0700, Paul E. McKenney wrote:
> On Fri, Jul 03, 2020 at 03:13:30PM +0200, Peter Zijlstra wrote:
> > On Thu, Jul 02, 2020 at 10:59:48AM -0700, Paul E. McKenney wrote:
> > > On Thu, Jul 02, 2020 at 10:20:40AM +0200, Peter Zijlstra wrote:
> > > > On Wed, Jul 01, 2020 at 09:03:38AM -0700, Paul E. McKenney wrote:

[ . . . ]

> > Also, if C goes and specifies load dependencies, in any form, is then
> > not the corrolary that they need to specify control dependencies? How
> > else can they exclude the transformation.
> 
> By requiring that any temporaries generated from variables that are
> marked _Dependent_ptr also be marked _Dependent_ptr.  This is of course
> one divergence of _Dependent_ptr from the volatile keyword.
> 
> > And of course, once we're there, can we get explicit support for control
> > dependencies too? :-) :-)
> 
> Keep talking like this and I am going to make sure that you attend a
> standards committee meeting.  If need be, by arranging for you to be
> physically dragged there.  ;-)
> 
> More seriously, for control dependencies, the variable that would need
> to be marked would be the program counter, which might require some
> additional syntax.

And perhaps more constructively, we do need to prioritize address and data
dependencies over control dependencies.  For one thing, there are a lot
more address/data dependencies in existing code than there are control
dependencies, and (sadly, perhaps more importantly) there are a lot more
people who are convinced that address/data dependencies are important.

For another (admittedly more theoretical) thing, the OOTA scenarios
stemming from control dependencies are a lot less annoying than those
from address/data dependencies.

And address/data dependencies are as far as I know vulnerable to things
like conditional-move instructions that can cause problems for control
dependencies.

Nevertheless, yes, control dependencies also need attention.

							Thanx, Paul
