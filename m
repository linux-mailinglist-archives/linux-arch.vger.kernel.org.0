Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E25A39B7B8
	for <lists+linux-arch@lfdr.de>; Fri,  4 Jun 2021 13:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbhFDLPa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Jun 2021 07:15:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:54490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230004AbhFDLPa (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 4 Jun 2021 07:15:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BA561613FF;
        Fri,  4 Jun 2021 11:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622805224;
        bh=fpRSxd6X5RuF/EJyTMPUH5MksDB90dR+zrIwskEQgj4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Lxr6FoffyoGymYBmqJAFXIMFiP6BpmY9/SGgSNDsbl+a8WuCSwW/sXIred5oUZ1OO
         W2q8sk4jFL4MgP5iXW1peivnOs8PkUDzyIbmyDZLCS1SpglmBIoZ3bzignWeYkR/pV
         tWfvXK7dac5+v8S5pccxKliG+Ssg0ouXWmbQ14AuM+9/nLOxOk7kDm+EGYjKveormR
         cQ2eeBgcUgRhxs58IuBlHjp1g/1nDLFgrsmPfmfONwmIWi3cKHeSaJzwMEkeJrva2D
         veYV9wKHkguK/rUBLvZZ7B3XGQBVFOtk7GRdpkeIk4QkebZX7EtCF0n+/La/pji8/+
         3gjQASTEuavbg==
Date:   Fri, 4 Jun 2021 12:13:38 +0100
From:   Will Deacon <will@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, paulmck@kernel.org,
        stern@rowland.harvard.edu, parri.andrea@gmail.com,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com,
        linux-kernel@vger.kernel.org, linux-toolchains@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [RFC] LKMM: Add volatile_if()
Message-ID: <20210604111337.GA2721@willie-the-truck>
References: <YLn8dzbNwvqrqqp5@hirez.programming.kicks-ass.net>
 <20210604104359.GE2318@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210604104359.GE2318@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jun 04, 2021 at 11:43:59AM +0100, Will Deacon wrote:
> On Fri, Jun 04, 2021 at 12:12:07PM +0200, Peter Zijlstra wrote:
> > With optimizing compilers becoming more and more agressive and C so far
> > refusing to acknowledge the concept of control-dependencies even while
> > we keep growing the amount of reliance on them, things will eventually
> > come apart.
> > 
> > There have been talks with toolchain people on how to resolve this; one
> > suggestion was allowing the volatile qualifier on branch statements like
> > 'if', but so far no actual compiler has made any progress on this.
> > 
> > Rather than waiting any longer, provide our own construct based on that
> > suggestion. The idea is by Alan Stern and refined by Paul and myself.
> > 
> > Code generation is sub-optimal (for the weak architectures) since we're
> > forced to convert the condition into another and use a fixed conditional
> > branch instruction, but shouldn't be too bad.
> > 
> > Usage of volatile_if requires the @cond to be headed by a volatile load
> > (READ_ONCE() / atomic_read() etc..) such that the compiler is forced to
> > emit the load and the branch emitted will have the required
> > data-dependency. Furthermore, volatile_if() is a compiler barrier, which
> > should prohibit the compiler from lifting anything out of the selection
> > statement.
> 
> When building with LTO on arm64, we already upgrade READ_ONCE() to an RCpc
> acquire. In this case, it would be really good to avoid having the dummy
> conditional branch somehow, but I can't see a good way to achieve that.

Thinking more on this, an alternative angle would be having READ_ONCE_CTRL()
instead of volatile_if. That would then expand (on arm64) to either
something like:

	LDR	X0, [X1]
	CBNZ	X0, 1f		// Dummy ctrl
1:

or, with LTO:

	LDAPR	X0, [X1]	// RCpc

and we'd avoid the redundancy.

Will
