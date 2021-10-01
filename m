Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB7241F1EA
	for <lists+linux-arch@lfdr.de>; Fri,  1 Oct 2021 18:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbhJAQPP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 1 Oct 2021 12:15:15 -0400
Received: from mail.efficios.com ([167.114.26.124]:39316 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354559AbhJAQPO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 1 Oct 2021 12:15:14 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 8A84638632E;
        Fri,  1 Oct 2021 12:13:29 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id ZM3AFaLuOgDH; Fri,  1 Oct 2021 12:13:28 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 6AE5338632D;
        Fri,  1 Oct 2021 12:13:28 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 6AE5338632D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1633104808;
        bh=7eKt/v8SRlysskI2agkVhAwiyRJ/IGvqsXIGEt7mukY=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=HRsS/V+HG6HeqpGV/J40K3XHvj85ZIHCsQDyPMZt0iKMe8LYstlk/ZCVe27ET19dw
         4W8Rmdmd/6roX9HfjStkwHdNdQOKpTgyL4ttT7pPX4MlzlkdU4Dco26etLSm9GUiA3
         FYFa0oANbcYESYQgFS4wEaRCNtBQTiryMomellBouzWPvlySk6qYa0jfocImP2Q2qr
         4/mPLb+ejUagbbihCOrntfFhOy3yZhey1dZcduBZLWa9OkEC9Y3sC84TVz6kYN914F
         R5++N0SKQuOfkf3RPbQfZG3Mg2Ji3zY0Zy0b9PxCPqKCrP0tuyC9qANqhTOgMyZKyG
         MzZC+utydT4XQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 4hr9GWQ1uzEd; Fri,  1 Oct 2021 12:13:28 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 52B303867A0;
        Fri,  1 Oct 2021 12:13:28 -0400 (EDT)
Date:   Fri, 1 Oct 2021 12:13:28 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Florian Weimer <fweimer@redhat.com>, Will Deacon <will@kernel.org>,
        paulmck <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        j alglave <j.alglave@ucl.ac.uk>,
        luc maranget <luc.maranget@inria.fr>,
        akiyks <akiyks@gmail.com>,
        linux-toolchains <linux-toolchains@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Message-ID: <2088260319.47978.1633104808220.JavaMail.zimbra@efficios.com>
In-Reply-To: <20210929174146.GF22689@gate.crashing.org>
References: <20210928211507.20335-1-mathieu.desnoyers@efficios.com> <87lf3f7eh6.fsf@oldenburg.str.redhat.com> <20210929174146.GF22689@gate.crashing.org>
Subject: Re: [RFC PATCH] LKMM: Add ctrl_dep() macro for control dependency
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4125 (ZimbraWebClient - FF92 (Linux)/8.8.15_GA_4059)
Thread-Topic: LKMM: Add ctrl_dep() macro for control dependency
Thread-Index: vReMbXYKiUNSWYkS0HYbTozqU0HTpw==
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

----- On Sep 29, 2021, at 1:41 PM, Segher Boessenkool segher@kernel.crashing.org wrote:

> Hi!
> 
> On Wed, Sep 29, 2021 at 02:28:37PM +0200, Florian Weimer wrote:
>> If you need a specific instruction emitted, you need a compiler
>> intrinsic or inline assembly.
> 
> Not an intrinsic.  Builtins (like almost all other code) do not say
> "generate this particular machine code", they say "generate code that
> does <this>".  That is one reason why builtins are more powerful than
> inline assembler (another related reason is that they tell the compiler
> exactly what behaviour is expected).
> 
>> I don't think it's possible to piggy-back this on something else.
> 
> Unless we get a description of what this does in term of language
> semantics (instead of generated machine code), there is no hope, even.

Hi Segher,

Let me try a slightly improved attempt at describing what I am looking
for in terms of language semantics.

First, let's suppose we define two new compiler builtins, e.g.
__sync_ctrl_dep_rw() and __sync_ctrl_dep_acquire().

Their task would be to ensure that a R->W or R->RW (acquire) dependency between the
volatile loads used as input of the evaluated expression and following volatile
stores, volatile loads for R->RW, volatile asm, memory clobbers, is present in the
following situations:

When the builtin is used around evaluation of the left operand of the && (logical
AND) and || (logical OR) expression, the R->W or R->RW dependency should be
present before evaluating the right operand.

When the builtin is used around evaluation of the first operand of the ternary
"question-mark" operator, the R->W or R->RW dependency should be present before
evaluating the second or third operands.

When the builtin is used around evaluation of the controlling expressions of
if, switch, while, and do-while statements, as well as of the second operand of
the for statement, the R->W or R->RW dependency should be present before the
next sequence point is evaluated.

One cheap way to achieve said R->W dependency (as well as R->RW on architectures which
to not reorder R->R) is to ensure that the generated assembly contains a conditional
branch. Other ways to ensure this include more heavy-weight approaches such as explicit
barriers.

Hopefully my description above is slightly closer to the expected language
semantics.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
