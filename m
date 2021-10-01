Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE5F41F317
	for <lists+linux-arch@lfdr.de>; Fri,  1 Oct 2021 19:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355398AbhJAR3r (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 1 Oct 2021 13:29:47 -0400
Received: from mail.efficios.com ([167.114.26.124]:35276 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355340AbhJAR3r (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 1 Oct 2021 13:29:47 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 50C14387085;
        Fri,  1 Oct 2021 13:28:02 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id lq8dsp9cdxNa; Fri,  1 Oct 2021 13:28:01 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id B365F386CF6;
        Fri,  1 Oct 2021 13:28:01 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com B365F386CF6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1633109281;
        bh=7N3hqrVDPZoEeqvjnRSW/PvE1OIfBC0sTtoSyM6UFEQ=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=duPgBz5qWMYIYKFsdx/H6NAzPDoUHfb6T6XQtbGyBnaDwgmcp79/yUBPiO6+L4cQz
         DFYhVYaTzFPE56ddMVptW9dmZG/GZ32ewq91yjrOzh11FzOcsP2h6WuYM86DGy5+lN
         H2mpmmbcTrBCqOiEPMKSIdxeEln8MinqBe+KG3HWWCAlp8lQAetGSyPOSFD1garUCE
         JKnp2cYVlfA34t8J0EmBsLKlJ+iduZMqgBjf8wv4k3aWWu38kbXnaapvX2TZnc5vr1
         Bj1ulzgRhceWxm9FHjU1TEwuxZm3OqBoS9SRInWmHRLBw2RR447kn/+y1jxyEXYHrQ
         yEAhkILTBveqg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 6IH4YKtaNHrY; Fri,  1 Oct 2021 13:28:01 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 9FC0C386E1A;
        Fri,  1 Oct 2021 13:28:01 -0400 (EDT)
Date:   Fri, 1 Oct 2021 13:28:01 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Marco Elver <elver@google.com>, Will Deacon <will@kernel.org>,
        paulmck <paulmck@kernel.org>,
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
Message-ID: <1097444747.48074.1633109281556.JavaMail.zimbra@efficios.com>
In-Reply-To: <CAHk-=whcN4ACLFvst0THwwpUFK4DDSM4O_frSoUQJ1m+0ENWjw@mail.gmail.com>
References: <20210928211507.20335-1-mathieu.desnoyers@efficios.com> <YVRWyq+rDeAFLx+X@elver.google.com> <1340204910.47919.1633103136293.JavaMail.zimbra@efficios.com> <CAHk-=whcN4ACLFvst0THwwpUFK4DDSM4O_frSoUQJ1m+0ENWjw@mail.gmail.com>
Subject: Re: [RFC PATCH] LKMM: Add ctrl_dep() macro for control dependency
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4125 (ZimbraWebClient - FF92 (Linux)/8.8.15_GA_4059)
Thread-Topic: LKMM: Add ctrl_dep() macro for control dependency
Thread-Index: PUaQPCRz5juCZ3ZAN/T/b+zlfZwrzw==
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

----- On Oct 1, 2021, at 12:20 PM, Linus Torvalds torvalds@linux-foundation.org wrote:
[...]
> But again - a lot of these made-up examples are exactly that: made up.
> For us to have a ctrl_dep() macro, I really want to see an actual
> honest-to-goodness case of this that we can point to.

I've spent some quality time staring at generated assembler diff in the past
days, and looking for code patterns of refcount_dec_and_test users, without
much success. There are some cases which end up working by chance, e.g. in
cases where the if leg has a smp_acquire__after_ctrl_dep and the else leg has
code that emits a barrier(), but I did not find any buggy generated
code per se. In order to observe those issues in real life, we would
really need to have identical then/else legs to the branch.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
