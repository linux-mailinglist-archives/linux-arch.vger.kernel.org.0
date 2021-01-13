Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 626DA2F4C67
	for <lists+linux-arch@lfdr.de>; Wed, 13 Jan 2021 14:45:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726471AbhAMNo7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 Jan 2021 08:44:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:39526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726143AbhAMNo7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 13 Jan 2021 08:44:59 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4D31823339;
        Wed, 13 Jan 2021 13:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610545458;
        bh=yxQwj7GErWFKst6hClfszM91CiSR/sjTPkADcoTkPH0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YcB7crq3hn52aPbNe0/Ti6ExxAYovh1rGMfLJgiY80ZiCBwTAdK01k7DjSMHeTTTh
         063QZiOJyfrrssG3CeaAqvSqH8DBGF4OJ0i5aTHZcgcenfO44Auq8lu4oKYwaHI3IB
         9eB7hMuzH/hkWi8YU/n90wQrXeB+Wk7baC1Hx6Lw3xk/NEB/5hgWs7pIBCx2OVjIYl
         Owxa4Vacll3dWTFxSazNhWMnqdujGsipk+JBvQFnyjNcdnGv1LxIgTN9FXfMyz0znr
         oqp651nCUQBI6ebnKxP1+Pc+9ATW113fjboBTwjMTGJonczcNcyUzJWo6BE3l5PqG/
         49B2XXQtW6LGg==
Date:   Wed, 13 Jan 2021 13:44:12 +0000
From:   Will Deacon <will@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] arm64: make atomic helpers __always_inline
Message-ID: <20210113134412.GA11757@willie-the-truck>
References: <20210108092024.4034860-1-arnd@kernel.org>
 <20210108093258.GB4031@willie-the-truck>
 <X/jDGbwDNcVrZdDJ@hirez.programming.kicks-ass.net>
 <20210112102312.GC34326@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210112102312.GC34326@C02TD0UTHF1T.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jan 12, 2021 at 10:23:12AM +0000, Mark Rutland wrote:
> On Fri, Jan 08, 2021 at 09:39:53PM +0100, Peter Zijlstra wrote:
> > On Fri, Jan 08, 2021 at 09:32:58AM +0000, Will Deacon wrote:
> > > Hi Arnd,
> > > 
> > > On Fri, Jan 08, 2021 at 10:19:56AM +0100, Arnd Bergmann wrote:
> > > > From: Arnd Bergmann <arnd@arndb.de>
> > > > 
> > > > With UBSAN enabled and building with clang, there are occasionally
> > > > warnings like
> > > > 
> > > > WARNING: modpost: vmlinux.o(.text+0xc533ec): Section mismatch in reference from the function arch_atomic64_or() to the variable .init.data:numa_nodes_parsed
> > > > The function arch_atomic64_or() references
> > > > the variable __initdata numa_nodes_parsed.
> > > > This is often because arch_atomic64_or lacks a __initdata
> > > > annotation or the annotation of numa_nodes_parsed is wrong.
> > > > 
> > > > for functions that end up not being inlined as intended but operating
> > > > on __initdata variables. Mark these as __always_inline, along with
> > > > the corresponding asm-generic wrappers.
> > > 
> > > Hmm, I don't fully grok this. Why does it matter if a non '__init' function
> > > is called with a pointer to some '__initdata'? Or is the reference coming
> > > from somewhere else? (where?).
> > 
> > FWIW the x86 atomics are __always_inline in part due to the noinstr
> > crud, which I imagine resulted in much the same 'fun'.
> 
> FWIW, I was planning on doing the same here as part of making arm64
> noinstr safe, so I reckon we should probably do this regardless of
> whether it's a complete fix for the section mismatch issue.

Fair enough:

Acked-by: Will Deacon <will@kernel.org>

Will
