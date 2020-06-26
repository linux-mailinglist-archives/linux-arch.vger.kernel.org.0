Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A68520B081
	for <lists+linux-arch@lfdr.de>; Fri, 26 Jun 2020 13:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728598AbgFZLaU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 26 Jun 2020 07:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728467AbgFZLaU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 26 Jun 2020 07:30:20 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F01FBC08C5C1;
        Fri, 26 Jun 2020 04:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0MTNUdpvCFV2C1ooAXJ6Vvth7dm0A8sUroqcq/z5uD0=; b=EGCO0/B1XB2kdspcyQ89ZQhoyg
        Ax/IQM8mmxqV7jkKXl/MWFP7prA5jfkO8HqSZPvnttIDjSFg1w/tKaO3j0k8KL6L+qlIY0Zn2j/hq
        W4+C8nlebWIF5ebBhJfftDfljzTAMl06M2aRxkineGdmpGu/LekSm6EbJ+h10mKkHi/ilcNQ8Z18F
        M2MJ7rPoVqwffWXd5EUII1zbwujF3rIpU9+e9qp3xDauW8aC4GU0RX4H1LjU/WFGQSrKETn9e32/P
        Ej5EZj5V0SHGNf+0tpEq14xmxvUc265pk15KyovRcTjXtIcLHzhrye5Vn/4QwrJSU3Wa82Pvq0XOG
        Bstzz1kg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jomY2-0007sF-0f; Fri, 26 Jun 2020 11:29:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 61A90301DFC;
        Fri, 26 Jun 2020 13:29:31 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4048629C95961; Fri, 26 Jun 2020 13:29:31 +0200 (CEST)
Date:   Fri, 26 Jun 2020 13:29:31 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        mhelsley@vmware.com
Subject: Re: [RFC][PATCH] objtool,x86_64: Replace recordmcount with objtool
Message-ID: <20200626112931.GF4817@hirez.programming.kicks-ass.net>
References: <20200624203200.78870-1-samitolvanen@google.com>
 <20200624203200.78870-5-samitolvanen@google.com>
 <20200624212737.GV4817@hirez.programming.kicks-ass.net>
 <20200624214530.GA120457@google.com>
 <20200625074530.GW4817@hirez.programming.kicks-ass.net>
 <20200625161503.GB173089@google.com>
 <20200625200235.GQ4781@hirez.programming.kicks-ass.net>
 <20200625224042.GA169781@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200625224042.GA169781@google.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jun 25, 2020 at 03:40:42PM -0700, Sami Tolvanen wrote:

> > Not boot tested, but it generates the required sections and they look
> > more or less as expected, ymmv.

> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index a291823f3f26..189575c12434 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -174,7 +174,6 @@ config X86
> >  	select HAVE_EXIT_THREAD
> >  	select HAVE_FAST_GUP
> >  	select HAVE_FENTRY			if X86_64 || DYNAMIC_FTRACE
> > -	select HAVE_FTRACE_MCOUNT_RECORD
> >  	select HAVE_FUNCTION_GRAPH_TRACER
> >  	select HAVE_FUNCTION_TRACER
> >  	select HAVE_GCC_PLUGINS
> 
> This breaks DYNAMIC_FTRACE according to kernel/trace/ftrace.c:
> 
>   #ifndef CONFIG_FTRACE_MCOUNT_RECORD
>   # error Dynamic ftrace depends on MCOUNT_RECORD
>   #endif
> 
> And the build errors after that seem to confirm this. It looks like we might
> need another flag to skip recordmcount.

Hurm, Steve, how you want to do that?

> Anyway, since objtool is run before recordmcount, I just left this unchanged
> for testing and ignored the recordmcount warnings about __mcount_loc already
> existing. Something is a bit off still though, I see this at boot:
> 
>   ------------[ ftrace bug ]------------
>   ftrace failed to modify
>   [<ffffffff81000660>] __tracepoint_iter_initcall_level+0x0/0x40
>    actual:   0f:1f:44:00:00
>   Initializing ftrace call sites
>   ftrace record flags: 0
>    (0)
>    expected tramp: ffffffff81056500
>   ------------[ cut here ]------------
> 
> Otherwise, this looks pretty good.

Ha! it is trying to convert the "CALL __fentry__" into a NOP and not
finding the CALL -- because objtool already made it a NOP...

Weird, I thought recordmcount would also write NOPs, it certainly has
code for that. I suppose we can use CC_USING_NOP_MCOUNT to avoid those,
but I'd rather Steve explain this before I wreck things further.
