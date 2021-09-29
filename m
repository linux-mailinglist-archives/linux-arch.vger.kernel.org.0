Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1FB841CCE7
	for <lists+linux-arch@lfdr.de>; Wed, 29 Sep 2021 21:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345655AbhI2Twi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 29 Sep 2021 15:52:38 -0400
Received: from mail.efficios.com ([167.114.26.124]:37850 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345636AbhI2Twf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 29 Sep 2021 15:52:35 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 5653536CAAF;
        Wed, 29 Sep 2021 15:50:53 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id J39vdJ66HPaU; Wed, 29 Sep 2021 15:50:52 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 85EC236CB58;
        Wed, 29 Sep 2021 15:50:52 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 85EC236CB58
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1632945052;
        bh=WiwY1kiDvwRVHtpENMrogCkLtrldkOHJEToBV94K9Kc=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=IvbrHeK2un8t2ZPuiWyezyjxsxp+PNxfRMHi5sf0Ie3WqcOmlfSAGyYqisE9euvMU
         ALVt/KFLRLDJVMCvvMfRbykAv6c1iNlgDQK85w6cV2e39PWEt1PleFDXoPmOEktO0f
         9/P4omnGqYzW9fyFjq3aPYp4fcnhglQQQkDSg/C/aNqorfsjBqobE1ghHf5sUuzhvY
         D3kH2es3cmcJginAS2ND4xeh5w7zIx9pfjEJxSWSb8YrL9NdAkWyFYIpJ4VKAh5ny0
         Ly8MvK/7sLv6rqTwxErnyoUGHsVJWcXoglp8PW8b1MOOt6BTSAISipdgn3dmOb3uDI
         C3Dfn/fp2fVNA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id WniF562roqeL; Wed, 29 Sep 2021 15:50:52 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 6EB0736C55F;
        Wed, 29 Sep 2021 15:50:52 -0400 (EDT)
Date:   Wed, 29 Sep 2021 15:50:52 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>, paulmck <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
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
Message-ID: <457755093.44604.1632945052335.JavaMail.zimbra@efficios.com>
In-Reply-To: <CAHk-=wjd_BJiJYZ99PAoc4mQ3QTiZrt-tRdznj3g9kU8-gYsAA@mail.gmail.com>
References: <20210928211507.20335-1-mathieu.desnoyers@efficios.com> <CAHk-=wg23CqjGWjjxDQ7yxrb+eF5at2KFU03GZa18Znx=+Xvow@mail.gmail.com> <CAHk-=wjd_BJiJYZ99PAoc4mQ3QTiZrt-tRdznj3g9kU8-gYsAA@mail.gmail.com>
Subject: Re: [RFC PATCH] LKMM: Add ctrl_dep() macro for control dependency
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4125 (ZimbraWebClient - FF92 (Linux)/8.8.15_GA_4059)
Thread-Topic: LKMM: Add ctrl_dep() macro for control dependency
Thread-Index: cL23+1Kw3cVad0ytZvNC6SLA16g8Tw==
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

----- On Sep 29, 2021, at 10:54 AM, Linus Torvalds torvalds@linux-foundation.org wrote:

> On Wed, Sep 29, 2021 at 7:47 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> And if there *is* need ("look, we have that same store in both the if-
>> and the else-statement" or whatever), then say so, and state that
>> thing.
> 
> Side note: I'd also like the commit that introduces this to talk very
> explicitly about the particular case that it is used doe and that it
> fixes. No "this can happen". A "this happened, here's the _actual_
> wrong code generation, and look how this new ctrl_dep() macro fixes
> it".
> 
> When it's this subtle, I don't want theoretical arguments. I want
> actual outstanding and real bugs.
> 
> Because I get the feeling that there were very few actual realistic
> examples of this, only made-up theoretical cases that wouldn't ever
> really be found in real code.

There is one particular scenario which concerns me in refcount_dec_and_test().
It relies on smp_acquire__after_ctrl_dep() to promote the control
dependency to an acquire barrier on success. Because it is exposed
within a static inline function, it hides the fact that control dependencies
are being used under the hood.

I have not identified a specific instance of oddly generated code, but this is
an accident waiting to happen. If we take this simplified refcount code
into godbolt.org and compile it for RISC-V rv64gc clang 12.0.1:

#define RISCV_FENCE(p, s) \
        __asm__ __volatile__ ("fence " #p "," #s : : : "memory")
#define __smp_rmb()     RISCV_FENCE(r,r)

volatile int var1;
volatile int refcount;

static inline bool refcount_dec_and_test(void)
{
    refcount--;
    if (refcount == 0) {
        __smp_rmb();    /* acquire after ctrl_dep */
        return true;
    }
    return false;
}

void fct(void)
{
    int x;

    if (refcount_dec_and_test()) {
        var1 = 0;
        return;
    }
    __smp_rmb();
    var1 = 1;
}

We end up with:

fct():                               # @fct()
        lui     a0, %hi(refcount)
        lw      a1, %lo(refcount)(a0)
        addiw   a1, a1, -1
        sw      a1, %lo(refcount)(a0)
        lw      a0, %lo(refcount)(a0)
        fence   r, r
        snez    a0, a0
        lui     a1, %hi(var1)
        sw      a0, %lo(var1)(a1)
        ret

Which lacks the conditional branch, and where the "fence r,r" instruction
does not properly order following stores after the refcount load.

Adding ctrl_dep() around the refcount == 0 check fixes this:

fct():                                # @fct()
        lui     a0, %hi(refcount)
        lw      a1, %lo(refcount)(a0)
        addiw   a1, a1, -1
        sw      a1, %lo(refcount)(a0)
        lw      a0, %lo(refcount)(a0)
        beqz    a0, .LBB0_2

        fence   r, r
        addi    a0, zero, 1
        j       .LBB0_3
.LBB0_2:

        fence   r, r
        mv      a0, zero
.LBB0_3:
        lui     a1, %hi(var1)
        sw      a0, %lo(var1)(a1)
        ret

I admit that this is still a "made up" example, although it is similar to the actual
implementation of refcount_dec_and_check(). But if we need to audit every user of this
API for wrongly generated code, we may be looking for a needle in a haystack.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
