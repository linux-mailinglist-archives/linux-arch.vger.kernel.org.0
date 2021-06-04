Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 228BD39BCAF
	for <lists+linux-arch@lfdr.de>; Fri,  4 Jun 2021 18:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbhFDQNj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Jun 2021 12:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbhFDQNj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Jun 2021 12:13:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86592C061766;
        Fri,  4 Jun 2021 09:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zzQ2fHwLh0TtSCysjc6mlkkpZVERXn709psQKrnHUpY=; b=b6IdoBuSF3TmKqoaYe47i8MUTf
        WjhlUtRFx0mcVfQlYt5VnohfkmJ5Dn7WE9uNkJO9dS3t02wzMZVHZ1Cyz7sdgnETLzpS13ZOjROgo
        SW4j+zGkRTaNDKy3bLHYMEFmdDbftU9ezi5jKKPdeiKpevcEqDmnrWFRV2wWvb5QVo65kPyIXe+sA
        mzxw4uu3xyw+D9GiwN6PfDTct2/u0IDDxoIZQPenvl8g313z6RrCxKgfhNutpDZplONQetGEWAxq6
        LoDSBFJaE2JkdQnSV5MpOfYB0kTjF5AD9dCzbQjIlnkPBIXRxRxEl8/AZAstmHcSB6NSueXurEIn8
        7j0pldrg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lpCPQ-00DJuH-Qi; Fri, 04 Jun 2021 16:11:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 798CB300299;
        Fri,  4 Jun 2021 18:10:55 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 62FD02CCC7B70; Fri,  4 Jun 2021 18:10:55 +0200 (CEST)
Date:   Fri, 4 Jun 2021 18:10:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, will@kernel.org,
        paulmck@kernel.org, stern@rowland.harvard.edu,
        parri.andrea@gmail.com, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, linux-kernel@vger.kernel.org,
        linux-toolchains@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [RFC] LKMM: Add volatile_if()
Message-ID: <YLpQj+S3vpTLX7cc@hirez.programming.kicks-ass.net>
References: <YLn8dzbNwvqrqqp5@hirez.programming.kicks-ass.net>
 <YLoSJaOVbzKXU4/7@hirez.programming.kicks-ass.net>
 <20210604153518.GD18427@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210604153518.GD18427@gate.crashing.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jun 04, 2021 at 10:35:18AM -0500, Segher Boessenkool wrote:
> On Fri, Jun 04, 2021 at 01:44:37PM +0200, Peter Zijlstra wrote:
> > On naming (sorry Paul for forgetting that in the initial mail); while I
> > think using the volatile qualifier for the language feature (can we haz
> > plz, kthxbai) makes perfect sense, Paul felt that we might use a
> > 'better' name for the kernel use, ctrl_dep_if() was proposed.
> 
> In standard C statements do not have qualifiers.  Unless you can
> convince the ISO C committee to have them on "if", you will have a very
> hard time convincing any serious compiler to do this.

While some people like talking to the Committee, I would much rather
explore language extensions with the compiler communities. Such
extensions can then make their way into the Committee once they show
their usefulness.

The whole statement qualifier thing was something that was proposed by a
tools person, although I can't really remember who. I'm not much married
to it, but since it's been the only actual suggestion from a tools
person, it's stuck.

If you have another proposal on how to express this; one you'd rather
see implemented, I'm all ears.

But the fact is that we really do depend on this. And we seem to be
growing more of them, not less.

Data dependencies, control dependencies and address dependencies, C
doesn't really like them, we rely on them. It would be awesome if we can
fix this.
