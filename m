Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87902210A5E
	for <lists+linux-arch@lfdr.de>; Wed,  1 Jul 2020 13:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730251AbgGALki (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 Jul 2020 07:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730196AbgGALkh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Jul 2020 07:40:37 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB77C061755;
        Wed,  1 Jul 2020 04:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HcAuVDWEpmiLqpe0YNpYLGZ4fmq8QzKs/ZIuj2kkH8Y=; b=RPefHxRrCTySSxthpCiwJtUQ3p
        sehdVUh/OXlcD2v/g6AxiKxksqOrSjRiJ3RqUoq5JvswSrlFwUahiev5FWK/uvACmhnWZcX96iaAj
        WVqWxdhoftAZ4iiqY0ToHDJjZkiN1ml6ykH6Gd0nxYOevhI98eCLIhsTljU6lq3B56wQQRmi47Kgn
        2LXfsp8FLDVW0Y91r/ZhmJ1DxlRIfNCq4WjGOYr1KTJtkpVrIUjrB3ZLhTgikLeGURhbDlKKsizky
        W2kk0nblBpf9RF7AABwI4KnH5A2qlS/QhSpfLWCJdNS/WllrJd29THxB6xyaqhGxdP1buQGCuqnSh
        sM+SK4uQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jqb6M-0005ut-DO; Wed, 01 Jul 2020 11:40:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id ECCE9301AC6;
        Wed,  1 Jul 2020 13:40:27 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D969D2BB58971; Wed,  1 Jul 2020 13:40:27 +0200 (CEST)
Date:   Wed, 1 Jul 2020 13:40:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
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
Message-ID: <20200701114027.GO4800@hirez.programming.kicks-ass.net>
References: <20200624203200.78870-1-samitolvanen@google.com>
 <20200624211540.GS4817@hirez.programming.kicks-ass.net>
 <CAKwvOdmxz91c-M8egR9GdR1uOjeZv7-qoTP=pQ55nU8TCpkK6g@mail.gmail.com>
 <20200625080313.GY4817@hirez.programming.kicks-ass.net>
 <20200625082433.GC117543@hirez.programming.kicks-ass.net>
 <20200625085745.GD117543@hirez.programming.kicks-ass.net>
 <20200630191931.GA884155@elver.google.com>
 <20200630201243.GD4817@hirez.programming.kicks-ass.net>
 <20200630203016.GI9247@paulmck-ThinkPad-P72>
 <CANpmjNP+7TtE0WPU=nX5zs3T2+4hPkkm08meUm2VDVY3RgsHDw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNP+7TtE0WPU=nX5zs3T2+4hPkkm08meUm2VDVY3RgsHDw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jul 01, 2020 at 11:41:17AM +0200, Marco Elver wrote:
> On Tue, 30 Jun 2020 at 22:30, Paul E. McKenney <paulmck@kernel.org> wrote:
> > On Tue, Jun 30, 2020 at 10:12:43PM +0200, Peter Zijlstra wrote:
> > > On Tue, Jun 30, 2020 at 09:19:31PM +0200, Marco Elver wrote:

> > > > Thoughts?
> > >
> > > How hard would it be to creates something that analyzes a build and
> > > looks for all 'dependent load -> control dependency' transformations
> > > headed by a volatile (and/or from asm) load and issues a warning for
> > > them?
> 
> I was thinking about this, but in the context of the "auto-promote to
> acquire" which you didn't like. Issuing a warning should certainly be
> simpler.
> 
> I think there is no one place where we know these transformations
> happen, but rather, need to analyze the IR before transformations,
> take note of all the dependent loads headed by volatile+asm, and then
> run an analysis after optimizations checking the dependencies are
> still there.

Urgh, that sounds nasty. The thing is, as I've hinted at in my other
reply, I would really like a compiler switch to disable this
optimization entirely -- knowing how relevant the trnaformation is, is
simply a first step towards that.

In order to control the tranformation, you have to actually know where
in the optimization passes it happens.

Also, if (big if in my book) we find the optimization is actually
beneficial, we can invert the warning when using the switch and warn
about lost optimization possibilities and manually re-write the code to
use control deps.

> > > This would give us an indication of how valuable this transformation is
> > > for the kernel. I'm hoping/expecting it's vanishingly rare, but what do
> > > I know.
> >
> > This could be quite useful!
> 
> We might then even be able to say, "if you get this warning, turn on
> CONFIG_ACQUIRE_READ_DEPENDENCIES" (or however the option will be
> named). 

I was going to suggest: if this happens, employ -fno-wreck-dependencies
:-)
