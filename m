Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEA892EFC48
	for <lists+linux-arch@lfdr.de>; Sat,  9 Jan 2021 01:43:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725817AbhAIAlN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 8 Jan 2021 19:41:13 -0500
Received: from casper.infradead.org ([90.155.50.34]:56398 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbhAIAlM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 8 Jan 2021 19:41:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Fh1FiaPgximaUf/jTCpsygk/6dDJoGnbhcrl2nWi8C8=; b=HrVyzxCBV/pGgvd8ZD53/tfTMS
        IK7lQhcX5ydSWkAVEKKoQgNPiFRLnvTp6tNypCovPHhS9smNH3jfL8/mZEpAAo3AdJ3v0g7IfUfUs
        Xc7AFVJCMMBF3evvGocW6HybrPNUirdz+vm1wRTPvYQ2OfQqfVkTaeUyUjbrgIgFSLWbRRpmRkMqI
        kXfkd6gJpfM4gG2FVgpfmmQ+5AFRyt14P2JMQ9W1FN3dxmIOip/p0Nd35rRrODpooKJAsTGDa8fxG
        3zVGhRwTXLgnWVXPqGhBHW8qzsPoVOt6g/Jd7MlM4AP+NDCEj4HoBpFJE2qXJvAAIm+eiylh4lcAW
        dH4Zfetw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1kxyY7-0003SS-Gg; Fri, 08 Jan 2021 20:40:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 01D3F305C10;
        Fri,  8 Jan 2021 21:39:53 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C2C362C8F2DAA; Fri,  8 Jan 2021 21:39:53 +0100 (CET)
Date:   Fri, 8 Jan 2021 21:39:53 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will@kernel.org>
Cc:     Arnd Bergmann <arnd@kernel.org>,
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
Message-ID: <X/jDGbwDNcVrZdDJ@hirez.programming.kicks-ass.net>
References: <20210108092024.4034860-1-arnd@kernel.org>
 <20210108093258.GB4031@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210108093258.GB4031@willie-the-truck>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jan 08, 2021 at 09:32:58AM +0000, Will Deacon wrote:
> Hi Arnd,
> 
> On Fri, Jan 08, 2021 at 10:19:56AM +0100, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> > 
> > With UBSAN enabled and building with clang, there are occasionally
> > warnings like
> > 
> > WARNING: modpost: vmlinux.o(.text+0xc533ec): Section mismatch in reference from the function arch_atomic64_or() to the variable .init.data:numa_nodes_parsed
> > The function arch_atomic64_or() references
> > the variable __initdata numa_nodes_parsed.
> > This is often because arch_atomic64_or lacks a __initdata
> > annotation or the annotation of numa_nodes_parsed is wrong.
> > 
> > for functions that end up not being inlined as intended but operating
> > on __initdata variables. Mark these as __always_inline, along with
> > the corresponding asm-generic wrappers.
> 
> Hmm, I don't fully grok this. Why does it matter if a non '__init' function
> is called with a pointer to some '__initdata'? Or is the reference coming
> from somewhere else? (where?).

FWIW the x86 atomics are __always_inline in part due to the noinstr
crud, which I imagine resulted in much the same 'fun'.
