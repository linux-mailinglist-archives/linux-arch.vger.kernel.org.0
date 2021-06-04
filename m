Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE8539C04C
	for <lists+linux-arch@lfdr.de>; Fri,  4 Jun 2021 21:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbhFDTT4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Jun 2021 15:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbhFDTTz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Jun 2021 15:19:55 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09301C061766;
        Fri,  4 Jun 2021 12:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=O2AjOQo+EfGzP0xtOCIGjvm4MCb77kNuiw/QwVIDtE8=; b=HcplW/moiuIb9r7f4QTI38nRgt
        I8aWJPxL40ZFOAyz+easvu8P3hASUZ9nR6VmTNphvY8unTai3syQ93tuZBmDcDB93ycgrWk8FUU8A
        yRtKxDPXy1pLltZ4t9a1qDPHSWgFGbBOqhFGpGGjECRwboeB2EBUM9TvnEIu59RiqlKXjuYWiaZiR
        SI76Uf6iMvt2da7sk6oSHI1/gwa+/osdESJEu8q2e/qZRUoobhuNjeks66ZA2NX1eoXN5WXjkm2l+
        5w84Ao2o+6JLhdU6CQvsf8rlCbpHbQGxCjmY/GESK5O3+Sv129kB90C5tpDR6EpLWw+r1rgiX/Hp7
        bryY68Jg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lpFKJ-003VTZ-9P; Fri, 04 Jun 2021 19:17:58 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6BD0A986EEC; Fri,  4 Jun 2021 21:17:56 +0200 (CEST)
Date:   Fri, 4 Jun 2021 21:17:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nick Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-toolchains@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>
Subject: Re: [RFC] LKMM: Add volatile_if()
Message-ID: <20210604191756.GE68208@worktop.programming.kicks-ass.net>
References: <YLn8dzbNwvqrqqp5@hirez.programming.kicks-ass.net>
 <CAHk-=wievFk29DZgFLEFpH9yuZ0jfJqppLTJnOMvhe=+tDqgrw@mail.gmail.com>
 <YLpWwm1lDwBaUven@hirez.programming.kicks-ass.net>
 <CAHk-=wjf-VJZd3Uxv3T3pSJYYVzyfK2--znG0VEOnNRchMGgdQ@mail.gmail.com>
 <20210604172407.GJ18427@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210604172407.GJ18427@gate.crashing.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jun 04, 2021 at 12:24:07PM -0500, Segher Boessenkool wrote:
> On Fri, Jun 04, 2021 at 10:10:29AM -0700, Linus Torvalds wrote:
> > The compiler *cannot* just say "oh, I'll do that 'volatile asm
> > barrier' whether the condition is true or not". That would be a
> > fundamental compiler bug.
> 
> Yes.

So we can all agree on something like this?

#define volatile_if(x) \
	if (({ _Bool __x = (x); BUILD_BUG_ON(__builtin_constant_p(__x)); __x; }) && \
	    ({ barrier(); 1; }))

Do we keep volatile_if() or do we like ctrl_dep_if() better?
