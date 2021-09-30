Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0586541DB0C
	for <lists+linux-arch@lfdr.de>; Thu, 30 Sep 2021 15:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351446AbhI3Nab (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 30 Sep 2021 09:30:31 -0400
Received: from mail.efficios.com ([167.114.26.124]:35888 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351412AbhI3NaY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 30 Sep 2021 09:30:24 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 3499437C086;
        Thu, 30 Sep 2021 09:28:40 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id EZN6yp12FozF; Thu, 30 Sep 2021 09:28:39 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id C6E1C37C085;
        Thu, 30 Sep 2021 09:28:39 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com C6E1C37C085
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1633008519;
        bh=P2J1OfBgBODYqiVp9Fk+5wLLLt/MgES+lhZs6+l7620=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=fc+xe9aAPKF4JDOwSBRlGC3VM10Z1WI2UVRVJE0s/bcQCOczbZd5f4MJgwWNj0G5Y
         INboUXd9M4hUDLR0MuEpfBXOHvsbxih7kPz3jSY+O5cvISEoG7ZBMjUSj/BxSYQAsu
         j7UOEK4ozB9y+BTVEuOIzqIOE2zoruEtZAqIJwRUTI+ZoIBiUVd+tZp94XII/rzcTq
         swnEIO00zDufAWTvKpHqeBBp+j1LshQ9QiGhe1ODyQcurBuHzvGOYFa1HRbtgLKwwB
         pV7SSCYLIEuwrKqXgEOZZzWNYgMgW6Rf0daUrjAnVeQ2/ZEaO0Ymbkl8rWuRMeuPNa
         e83jM/ZRA6FeA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 8dgSr6wP-cnh; Thu, 30 Sep 2021 09:28:39 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id B377237BF24;
        Thu, 30 Sep 2021 09:28:39 -0400 (EDT)
Date:   Thu, 30 Sep 2021 09:28:39 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Will Deacon <will@kernel.org>, paulmck <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
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
Message-ID: <164706701.45822.1633008519556.JavaMail.zimbra@efficios.com>
In-Reply-To: <87lf3f7eh6.fsf@oldenburg.str.redhat.com>
References: <20210928211507.20335-1-mathieu.desnoyers@efficios.com> <87lf3f7eh6.fsf@oldenburg.str.redhat.com>
Subject: Re: [RFC PATCH] LKMM: Add ctrl_dep() macro for control dependency
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4125 (ZimbraWebClient - FF92 (Linux)/8.8.15_GA_4059)
Thread-Topic: LKMM: Add ctrl_dep() macro for control dependency
Thread-Index: viZtDEW1KcIpECawIzUvMKrWKcwLGw==
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

----- On Sep 29, 2021, at 8:28 AM, Florian Weimer fweimer@redhat.com wrote:

> * Mathieu Desnoyers:
> 
>> + * will ensure that the STORE to B happens after the LOAD of A. Normally a
>> + * control dependency relies on a conditional branch having a data dependency
>> + * on the LOAD and an architecture's inability to speculate STOREs. IOW, this
>> + * provides a LOAD->STORE order.
>> + *
>> + * Due to optimizing compilers, extra care is needed; as per the example above
>> + * the LOAD must be 'volatile' qualified in order to ensure the compiler
>> + * actually emits the load, such that the data-dependency to the conditional
>> + * branch can be formed.
>> + *
>> + * Secondly, the compiler must be prohibited from lifting anything out of the
>> + * selection statement, as this would obviously also break the ordering.
>> + *
>> + * Thirdly, architectures that allow the LOAD->STORE reorder must ensure
>> + * the compiler actually emits the conditional branch instruction.
> 
> If you need a specific instruction emitted, you need a compiler
> intrinsic or inline assembly.
> 
> So something like this:
> 
> #define control_dep(x)                          \
>  ({                                            \
>    __typeof(x) x__ = (x);                      \
>    __asm__("test $0, %0\n\t"                   \
>            "jnz 1f\n\t"                        \
>            "1:"                                \
>            :: "r"(x__) : "cc");                \
>  })
> 
> with an appropriate instruction sequence for each architecture.
> 
> I don't think it's possible to piggy-back this on something else.

The previous patch set from Peter Zijlstra proposed using asm goto to achieve this,
but it was turned down in part because it prevented the compiler from choosing the
most appropriate instruction for the conditional branch:

https://lore.kernel.org/lkml/YLn8dzbNwvqrqqp5@hirez.programming.kicks-ass.net/

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
