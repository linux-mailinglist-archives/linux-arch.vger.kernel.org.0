Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 098122EF7AE
	for <lists+linux-arch@lfdr.de>; Fri,  8 Jan 2021 19:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728505AbhAHSvf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 8 Jan 2021 13:51:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:34202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728429AbhAHSve (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 8 Jan 2021 13:51:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 872D223A5E;
        Fri,  8 Jan 2021 18:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610131854;
        bh=RxHYjy0i/3NdfUEI25BhLzl08/4GhcgWadzUU0CMeNA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aLtx7xVuEhy5VwNBckoCFCYHgJEGr0YsT376UXgphaHoHpDEcLJ49HvJT4OlMCDy0
         5JOfpSLXzElCCI/zqCZNrcIaU2IzZvyYwX7YIbb1lPv4Sil24Ks5kQfTyXDT9RaFyF
         di0aC72bVybHu3K01V4UwGLVydGpun96XCGnBmSG8KYmGjIIlfT6qTk1sdLWvW/gWz
         6iCQt48/bYkVA25XhOYx/010O+1WzHDP0cQzgSNOydLgN6KYO9bNTRHpwr/4xHHRLa
         QzEOCwnE5QZIKAs/MsRx8TTe19BeTu2CWpAB686aM/A3qfpcL7CHo5JXelIUzX0trs
         W6iyE+8BCrT7g==
Date:   Fri, 8 Jan 2021 18:50:48 +0000
From:   Will Deacon <will@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH] arm64: make atomic helpers __always_inline
Message-ID: <20210108185047.GB5457@willie-the-truck>
References: <20210108092024.4034860-1-arnd@kernel.org>
 <20210108093258.GB4031@willie-the-truck>
 <CAK8P3a27y_EM6s3SwH1e6FR7bqeT3PEoLbxSWPyZ=4BzqAjceg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a27y_EM6s3SwH1e6FR7bqeT3PEoLbxSWPyZ=4BzqAjceg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jan 08, 2021 at 11:26:53AM +0100, Arnd Bergmann wrote:
> On Fri, Jan 8, 2021 at 10:33 AM Will Deacon <will@kernel.org> wrote:
> > On Fri, Jan 08, 2021 at 10:19:56AM +0100, Arnd Bergmann wrote:
> > > From: Arnd Bergmann <arnd@arndb.de>
> > >
> > > With UBSAN enabled and building with clang, there are occasionally
> > > warnings like
> > >
> > > WARNING: modpost: vmlinux.o(.text+0xc533ec): Section mismatch in reference from the function arch_atomic64_or() to the variable .init.data:numa_nodes_parsed
> > > The function arch_atomic64_or() references
> > > the variable __initdata numa_nodes_parsed.
> > > This is often because arch_atomic64_or lacks a __initdata
> > > annotation or the annotation of numa_nodes_parsed is wrong.
> > >
> > > for functions that end up not being inlined as intended but operating
> > > on __initdata variables. Mark these as __always_inline, along with
> > > the corresponding asm-generic wrappers.
> >
> > Hmm, I don't fully grok this. Why does it matter if a non '__init' function
> > is called with a pointer to some '__initdata'? Or is the reference coming
> > from somewhere else? (where?).
> 
> There are (at least) three ways for gcc to deal with a 'static inline'
> function:
> 
> a) fully inline it as the __always_inline attribute does
> b) not inline it at all, treating it as a regular static function
> c) create a specialized version with different calling conventions
> 
> In this case, clang goes with option c when it notices that all
> callers pass the same constant pointer. This means we have a
> synthetic
> 
> static noinline long arch_atomic64_or(long i)
> {
>         return __lse_ll_sc_body(atomic64_fetch_or, i, &numa_nodes_parsed);
> }
> 
> which is a few bytes shorter than option b as it saves a load in the
> caller. This function definition however violates the kernel's rules
> for section references, as the synthetic version is not marked __init.

Ah, I was hoping the compiler would've sorted that out, but then again, how
would it know? But doesn't this mean that whenever we get one caller passing
something like an __initdata pointer to a function, then that function needs
to be __always_inline for everybody? It feels like a slippery slope
considering the incentive to go back and replace it with 'inline' if the
caller goes away is very small.

Didn't we used to #define inline as __always_inline to avoid this situation?

Will
