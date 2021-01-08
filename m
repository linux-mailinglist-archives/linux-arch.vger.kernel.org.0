Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61B182EEFB9
	for <lists+linux-arch@lfdr.de>; Fri,  8 Jan 2021 10:34:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbhAHJdq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 8 Jan 2021 04:33:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:52774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727661AbhAHJdp (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 8 Jan 2021 04:33:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 365F822BE8;
        Fri,  8 Jan 2021 09:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610098384;
        bh=FbhPcDUndjAB6/H1OTOUBoWyx4YiqVFJQbRKF5EZ9PY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XBAh5ke3xFCC21/4t0+IO8+LeZnsYAEC0R6ItjiQSI7InY6o3dZRqrB4iiupGt7xa
         VYRiwYGWeMJFUUAxhz6+aGGlbLR2fxRptKjEUvT+9B9ta2H2G8SAyyRyywBFORV95q
         7fpkthtWE/KXuIuVGS0coDDfUjusg8xw4Wtq2GjR0LOysKvcKrBpuhcGhqg3gQFkdg
         Xw1rQ87+TsGU6Q5IYIZYAQ5uomGTZx8dm7azSnrtMtxXCb2VMZjol2G2bnoduru3sq
         mX4I8xjmuHXxzuBIDzGbU3KTabtbfybdZH8YXCOc4YS0tqsPKQBssXmR8NW81RIG9f
         rDTMfigP4y5mw==
Date:   Fri, 8 Jan 2021 09:32:58 +0000
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
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] arm64: make atomic helpers __always_inline
Message-ID: <20210108093258.GB4031@willie-the-truck>
References: <20210108092024.4034860-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210108092024.4034860-1-arnd@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Arnd,

On Fri, Jan 08, 2021 at 10:19:56AM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> With UBSAN enabled and building with clang, there are occasionally
> warnings like
> 
> WARNING: modpost: vmlinux.o(.text+0xc533ec): Section mismatch in reference from the function arch_atomic64_or() to the variable .init.data:numa_nodes_parsed
> The function arch_atomic64_or() references
> the variable __initdata numa_nodes_parsed.
> This is often because arch_atomic64_or lacks a __initdata
> annotation or the annotation of numa_nodes_parsed is wrong.
> 
> for functions that end up not being inlined as intended but operating
> on __initdata variables. Mark these as __always_inline, along with
> the corresponding asm-generic wrappers.

Hmm, I don't fully grok this. Why does it matter if a non '__init' function
is called with a pointer to some '__initdata'? Or is the reference coming
from somewhere else? (where?).

Will
