Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE9C7467B73
	for <lists+linux-arch@lfdr.de>; Fri,  3 Dec 2021 17:33:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245728AbhLCQgi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Dec 2021 11:36:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240590AbhLCQgi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Dec 2021 11:36:38 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E9D7C061751;
        Fri,  3 Dec 2021 08:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QjwBqRRkSrixSh/IDyfbmaebOro1hr1dDZ0gMoqAxDY=; b=filV5mfIAXvfm0uzdKd9gxn+Ac
        /Z+Bd/HBfONMrS6Ywwq2Z1V9I2sh7rZnRhXrZb+mLZf65ChTQzrJUzraRuiPZrarIhntiH3mwAljC
        BLpVdZnwOqd0WZVg9w1rzQnTT7SZJzrZ3SB4ic9vMTZx47mGfdxhg6qjQOmTQ1RurUee0ohGp6MrC
        46nDrNFg0zbkY2BN0n0ou4kE11nRCvkPZiZsLAOE2bhH4e4V9FDaIUuJiNh54VF+CW2y5W8kS79v9
        ZVzvesXBl8G8PJYmPI6bdsJ6+T/Gavx2XwBzBd0urakpY2UvJY15R/ay4wJJ1JSgCfCn4qqb8Z5wF
        fhXW5HFQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mtBUA-009OIf-6T; Fri, 03 Dec 2021 16:32:35 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 37CEC9810D4; Fri,  3 Dec 2021 17:32:34 +0100 (CET)
Date:   Fri, 3 Dec 2021 17:32:34 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexander Lobakin <alexandr.lobakin@intel.com>
Cc:     linux-hardening@vger.kernel.org, x86@kernel.org,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Ard Biesheuvel <ardb@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Bruce Schlobohm <bruce.schlobohm@intel.com>,
        Jessica Yu <jeyu@kernel.org>,
        kernel test robot <lkp@intel.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Marios Pomonis <pomonis@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-arch@vger.kernel.org, live-patching@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH v8 00/14] Function Granular KASLR
Message-ID: <20211203163234.GJ16608@worktop.programming.kicks-ass.net>
References: <20211202223214.72888-1-alexandr.lobakin@intel.com>
 <YanzpvmaX1JWYf9t@hirez.programming.kicks-ass.net>
 <20211203144136.82915-1-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211203144136.82915-1-alexandr.lobakin@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Dec 03, 2021 at 03:41:36PM +0100, Alexander Lobakin wrote:
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Fri, 3 Dec 2021 11:38:30 +0100
> 
> > On Thu, Dec 02, 2021 at 11:32:00PM +0100, Alexander Lobakin wrote:
> > 
> > > feat        make -j65 boot    vmlinux.o vmlinux  bzImage  bogoops/s
> > > Relocatable 4m38.478s 24.440s 72014208  58579520  9396192 57640.39
> > > KASLR       4m39.344s 24.204s 72020624  87805776  9740352 57393.80
> > > FG-K 16 fps 6m16.493s 25.429s 83759856  87194160 10885632 57784.76
> > > FG-K 8 fps  6m20.190s 25.094s 83759856  88741328 10985248 56625.84
> > > FG-K 1 fps  7m09.611s 25.922s 83759856  95681128 11352192 56953.99
> > 
> > :sadface: so at best it makes my kernel compiles ~50% slower. Who would
> > ever consider doing that? It's like retpolines weren't bad enough; lets
> > heap on the fail?
> 
> I was waiting for that :D
> 
> I know it's horrible for now, but there are some points to consider:
>  - folks who are placing hardening over everything don't mind
>    compile times most likely;
>  - linkers choking on huge LD scripts is actually a bug in their
>    code. They process 40k sections as orphans (without a generated
>    LD script) for a split second, so they're likely able to do the
>    same with it. Our position here is that after FG-KASLR landing
>    we'll report it and probably look into linkers' code to see if
>    that can be addressed (Kees et al are on this AFAIU);
>  - ClangLTO (at least "Fat", not sure about Thin as I didn't used
>    it) thinks on vmlinux.o for ~5 minutes on 8-core Skylake. Still,
>    it is here in mainline and is widely (relatively) used.
>    I know FG-KASLR stuff is way more exotic, but anyways.
>  - And the last one: I wouldn't consider FG-KASLR production ready
>    as Kees would like to see it. Apart from compilation time, you
>    get random performance {in,de}creases here-and-there all over
>    the kernel and modules you can't predict at all.
>    I guess it would become better later on when/if we introduce
>    profiling-based function placement (there are some discussions
>    around that and one related article is referred in the orig
>    cover letter), but dunno for now.
>    There's one issue in the current code as well -- PTI switching
>    code is in .entry.text which doesn't currently get randomized.
>    So it can probably be hunted using gadget collectors I guess?

Oooh, so those compile times are not, as one would expect the compile
times for a set .config but with different kernel, but instead for a
varying .config on the same kernel?

IOW, they don't represent the run-time overhead of this thing, but
merely the toolchain overhead of all this.

So what is the actual runtime overhead of all this?
