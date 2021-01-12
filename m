Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6071F2F2CAD
	for <lists+linux-arch@lfdr.de>; Tue, 12 Jan 2021 11:24:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406091AbhALKYE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 12 Jan 2021 05:24:04 -0500
Received: from foss.arm.com ([217.140.110.172]:43514 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404201AbhALKYE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 12 Jan 2021 05:24:04 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 28AF231B;
        Tue, 12 Jan 2021 02:23:18 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.57.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EFF373F719;
        Tue, 12 Jan 2021 02:23:14 -0800 (PST)
Date:   Tue, 12 Jan 2021 10:23:12 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
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
Message-ID: <20210112102312.GC34326@C02TD0UTHF1T.local>
References: <20210108092024.4034860-1-arnd@kernel.org>
 <20210108093258.GB4031@willie-the-truck>
 <X/jDGbwDNcVrZdDJ@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X/jDGbwDNcVrZdDJ@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jan 08, 2021 at 09:39:53PM +0100, Peter Zijlstra wrote:
> On Fri, Jan 08, 2021 at 09:32:58AM +0000, Will Deacon wrote:
> > Hi Arnd,
> > 
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
> FWIW the x86 atomics are __always_inline in part due to the noinstr
> crud, which I imagine resulted in much the same 'fun'.

FWIW, I was planning on doing the same here as part of making arm64
noinstr safe, so I reckon we should probably do this regardless of
whether it's a complete fix for the section mismatch issue.

Mark.
