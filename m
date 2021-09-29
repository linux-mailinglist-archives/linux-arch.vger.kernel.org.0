Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1499341CC98
	for <lists+linux-arch@lfdr.de>; Wed, 29 Sep 2021 21:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346620AbhI2T2w (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 29 Sep 2021 15:28:52 -0400
Received: from mail.efficios.com ([167.114.26.124]:56926 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346609AbhI2T2v (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 29 Sep 2021 15:28:51 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 2AB6036C376;
        Wed, 29 Sep 2021 15:27:09 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id raTpiO30fpZA; Wed, 29 Sep 2021 15:27:07 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 19F8C36C7B1;
        Wed, 29 Sep 2021 15:27:07 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 19F8C36C7B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1632943627;
        bh=CkOi3VPTp6ogoTAZn5G8/aQOQFuimMm2R8UBTyDNfdk=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=kCiFD6Uo8W8p7WoUCjCQ9v8w2TFEsn/RdM13pO8Lze4zMc5Fe/d6nbdqY6uwIT2fs
         oD1A2Ow7nspUQUAcycyUkPERyFbSwnL9J6FM5QfiSEfM7PusvBqAxUB+EUsmqr2cre
         qmrmFSdGOHIGmxcX8w+bupiKLWSFu4jFpVCJzog/ZZH/1ftlzSwCreQRqrG7m+kw6c
         PUCVWPmZ1M3b9/VILoJSeROGkA0AMHVUg+wqNra2zH7NyiRBkB9a2H7bb1EVBLAugI
         zAE9oYrGwM8mvBI3waIjOP40eix30iXIp8+e6+UFryJtdllGJdeicVbuyzg0d4kdOU
         KPjG8P47mJcXw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id EraXV3JHf38h; Wed, 29 Sep 2021 15:27:07 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 06CAC36C2E3;
        Wed, 29 Sep 2021 15:27:07 -0400 (EDT)
Date:   Wed, 29 Sep 2021 15:27:06 -0400 (EDT)
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
Message-ID: <1882826966.44389.1632943626923.JavaMail.zimbra@efficios.com>
In-Reply-To: <CAHk-=wg23CqjGWjjxDQ7yxrb+eF5at2KFU03GZa18Znx=+Xvow@mail.gmail.com>
References: <20210928211507.20335-1-mathieu.desnoyers@efficios.com> <CAHk-=wg23CqjGWjjxDQ7yxrb+eF5at2KFU03GZa18Znx=+Xvow@mail.gmail.com>
Subject: Re: [RFC PATCH] LKMM: Add ctrl_dep() macro for control dependency
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4125 (ZimbraWebClient - FF92 (Linux)/8.8.15_GA_4059)
Thread-Topic: LKMM: Add ctrl_dep() macro for control dependency
Thread-Index: scHG8V709IkY+wJtrVUo+d3Zn/2umg==
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

----- On Sep 29, 2021, at 10:47 AM, Linus Torvalds torvalds@linux-foundation.org wrote:

> On Tue, Sep 28, 2021 at 2:15 PM Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
>>
>> Introduce the ctrl_dep macro in the generic headers, and use it
>> everywhere it appears relevant.
> 
> The control dependency is so subtle - just see our discussions - that
> I really think every single use of it needs to have a comment about
> why it's needed.

I agree with you on thorough documentation of each control dependency,
perhaps just not about documentation of all compiler optimizations
affecting each of them.

> 
> Right now, that patch seems to just sprinkle them more or less
> randomly. That's absolutely not what I want. It will just mean that
> other people start sprinkling them randomly even more, and nobody will
> dare remove them.

Note that I have not found that many uses of control dependencies in the
kernel tree. When they are used, this happens to be code where speed
really matters though.

> So I'd literally want a comment about "this needs a control
> dependency, because otherwise the compiler could merge the two
> identical stores X and Y".

My hope with this ctrl_dep() macro is to remove at least some of
the caveats to keep in mind when using control dependency ordering.
Requiring to keep track of all relevant compiler optimizations on all
architectures while reasoning about memory barriers is error-prone.

> When you have a READ_ONCE() in the conditional, and a WRITE_ONCE() in
> the statement protected by the conditional, there is *no* need to
> randomly sprinkle noise that doesn't matter.

The main advantage in doing so would be documentation, both in terms of
letting the compiler know that this control dependency matters for
ordering, and in terms of simplifying the set of caveats to document
in Documentation/memory-barriers.txt.

> And if there *is* need ("look, we have that same store in both the if-
> and the else-statement" or whatever), then say so, and state that
> thing.

If we go for only using ctrl_dep() for scenarios which require it for
documented reasons, then we would need to leave in place all the
caveats details in Documentation/memory-barriers.txt, and document
that in those scenarios ctrl_dep() should be used. This would be a
starting point I guess.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
