Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 486A2210E57
	for <lists+linux-arch@lfdr.de>; Wed,  1 Jul 2020 17:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731209AbgGAPFV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 Jul 2020 11:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731039AbgGAPFV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Jul 2020 11:05:21 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9C0C08C5C1;
        Wed,  1 Jul 2020 08:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yjUbAZQQ9f4rcShW5GkixqYv9x2nD42GGzyjdsiFm50=; b=i74sl3ZOPr1xqJIhkMJglGWOkB
        U8dqkz+3Y5fKVBDLcgGRCYbTPQFBGPgHtaCMun69vkwL/Ry/Z+4Jsl8Mf+SEd1g2rFtmyvmpbWIYZ
        K0Ycyjqzo60JLazLm+uQfh7KsY8FqjTzInhLzUzA/uu1WwZ1uS4jmIhsjRK2swdHfjsLC2mBUqXmb
        tjLVkf7OGf4kz+DTg9+2SwJMjK14kVHRsmKF/8JUPsny87vwFakQlM7eTrs35Vus1k5vP28RmJNHc
        Yyq+PGlJEHTv7w05Krc9LSs+q+qVge1miTYAIcksAas9z16JswYUyikbLlMyiWZjWWnmMZFBaj5Bf
        7m/rqxmg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jqeIU-0005dy-9r; Wed, 01 Jul 2020 15:05:14 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 229A930015A;
        Wed,  1 Jul 2020 17:05:12 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1242023D44E56; Wed,  1 Jul 2020 17:05:12 +0200 (CEST)
Date:   Wed, 1 Jul 2020 17:05:12 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
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
Message-ID: <20200701150512.GH4817@hirez.programming.kicks-ass.net>
References: <CAKwvOdmxz91c-M8egR9GdR1uOjeZv7-qoTP=pQ55nU8TCpkK6g@mail.gmail.com>
 <20200625080313.GY4817@hirez.programming.kicks-ass.net>
 <20200625082433.GC117543@hirez.programming.kicks-ass.net>
 <20200625085745.GD117543@hirez.programming.kicks-ass.net>
 <20200630191931.GA884155@elver.google.com>
 <20200630201243.GD4817@hirez.programming.kicks-ass.net>
 <20200630203016.GI9247@paulmck-ThinkPad-P72>
 <CANpmjNP+7TtE0WPU=nX5zs3T2+4hPkkm08meUm2VDVY3RgsHDw@mail.gmail.com>
 <20200701114027.GO4800@hirez.programming.kicks-ass.net>
 <20200701140654.GL9247@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200701140654.GL9247@paulmck-ThinkPad-P72>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jul 01, 2020 at 07:06:54AM -0700, Paul E. McKenney wrote:

> The current state in the C++ committee is that marking variables
> carrying dependencies is the way forward.  This is of course not what
> the Linux kernel community does, but it should not be hard to have a
> -fall-variables-dependent or some such that causes all variables to be
> treated as if they were marked.  Though I was hoping for only pointers.
> Are they -sure- that they -absolutely- need to carry dependencies
> through integers???

What's 'need'? :-)

I'm thinking __ktime_get_fast_ns() is better off with a dependent load
than it is with an extra smp_rmb().

Yes we can stick an smp_rmb() in there, but I don't like it. Like I
wrote earlier, if I wanted a control dependency, I'd have written one.
