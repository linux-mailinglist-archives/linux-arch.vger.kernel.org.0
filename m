Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E40541CE87
	for <lists+linux-arch@lfdr.de>; Wed, 29 Sep 2021 23:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346585AbhI2Vyr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 29 Sep 2021 17:54:47 -0400
Received: from gate.crashing.org ([63.228.1.57]:53123 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346634AbhI2Vym (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 29 Sep 2021 17:54:42 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 18TLl6mK020560;
        Wed, 29 Sep 2021 16:47:06 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 18TLl3K9020545;
        Wed, 29 Sep 2021 16:47:03 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Wed, 29 Sep 2021 16:47:03 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     will@kernel.org, paulmck@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        stern@rowland.harvard.edu, parri.andrea@gmail.com,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com,
        linux-toolchains@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [RFC PATCH] LKMM: Add ctrl_dep() macro for control dependency
Message-ID: <20210929214703.GG22689@gate.crashing.org>
References: <20210928211507.20335-1-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210928211507.20335-1-mathieu.desnoyers@efficios.com>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi!

On Tue, Sep 28, 2021 at 05:15:07PM -0400, Mathieu Desnoyers wrote:
> C99 describes that accessing volatile objects are side-effects, and that
> "at certain specified points in the execution sequence called sequence
> points, all side effects of previous evaluations shall be complete
> and no side effects of subsequent evaluations shall have taken
> place". [2]

But note that the kernel explicitly uses C89 (with GNU extensions).
Side effects are largely equal there though.

Also note that there may no place in the generated machine code that
corresponds exactly to some sequence point.  Sequence points are a
concept that applies to the source program and how that executes on the
abstract machine.

> +Because ctrl_dep emits distinct asm volatile within each leg of the if
> +statement, the compiler cannot transform the two writes to 'b' into a
> +conditional-move (cmov) instruction, thus ensuring the presence of a
> +conditional branch.  Also because the ctrl_dep emits asm volatile within
> +each leg of the if statement, the compiler cannot move the write to 'c'
> +before the conditional branch.

I think your reasoning here misses some things.  So many that I don't
know where to start to list them, every "because" and "thus" here does
not follow, and even the statements of fact are not a given.

Why do you want a conditional branch insn at all, anyway?  You really
want something else as far as I can see.

It is essential here that there is a READ_ONCE and the WRITE_ONCE.
Those things might make it work the way you want, but as Linus says this
is all way too subtle.  Can you include the *_ONCE into the primitive
itself somehow?


Segher
