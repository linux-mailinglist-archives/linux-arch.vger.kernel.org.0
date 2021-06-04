Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2871639BC24
	for <lists+linux-arch@lfdr.de>; Fri,  4 Jun 2021 17:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbhFDPoZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Jun 2021 11:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbhFDPoZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Jun 2021 11:44:25 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16CE3C061766;
        Fri,  4 Jun 2021 08:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lYzDRibLCqThmqO90LTJPfzqukmjHc6SQrjL7E3n9co=; b=a1RA1JaDWj/tVJWgwLfZMFuHG6
        zKNZSU9Vy7EUDf1+08rvm5GLD53N2kAqCjEURivQjB54jD9mO+QYGDGKnkJftW1gfAzhZP7dJGPsG
        onhJXXPNJq3eJB2b3q2bLKMe2THgfkEGCzkMxxyUs0YNq1G335PqG5xe0qwjMxLU6vawRlah5LIDu
        D22+SS7rTdwjY0635BqApLwXFA1MvkTfTuO9vbr7DNg6wM1oTOHM8HYytLDN9AFFlS2EQiF9iua8W
        BwD3065pK6TkTfsxXDy7QkM9F0zwv3slKJSR3AeBq9aclgTx2sqzfKsCj1iLCpehgjgQX+LDZHeiP
        tMZBd/gw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lpBxn-003TSd-45; Fri, 04 Jun 2021 15:42:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1677530018A;
        Fri,  4 Jun 2021 17:42:29 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 02C2F2CCC7B87; Fri,  4 Jun 2021 17:42:28 +0200 (CEST)
Date:   Fri, 4 Jun 2021 17:42:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, paulmck@kernel.org,
        stern@rowland.harvard.edu, parri.andrea@gmail.com,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com,
        linux-kernel@vger.kernel.org, linux-toolchains@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [RFC] LKMM: Add volatile_if()
Message-ID: <YLpJ5K6O52o1cAVT@hirez.programming.kicks-ass.net>
References: <YLn8dzbNwvqrqqp5@hirez.programming.kicks-ass.net>
 <20210604104359.GE2318@willie-the-truck>
 <YLoPJDzlTsvpjFWt@hirez.programming.kicks-ass.net>
 <20210604134422.GA2793@willie-the-truck>
 <YLoxAOua/qsZXNmY@hirez.programming.kicks-ass.net>
 <20210604151356.GC2793@willie-the-truck>
 <YLpFHE5Cr45rWTUV@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YLpFHE5Cr45rWTUV@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jun 04, 2021 at 05:22:04PM +0200, Peter Zijlstra wrote:
> On Fri, Jun 04, 2021 at 04:13:57PM +0100, Will Deacon wrote:
> 
> > In fact, maybe it's actually necessary to bundle the load and branch
> > together. I looked at some of the examples of compilers breaking control
> > dependencies from memory-barriers.txt and the "boolean short-circuit"
> > example seems to defeat volatile_if:
> > 
> > void foo(int *x, int *y)
> > {
> >         volatile_if (READ_ONCE(*x) || 1 > 0)
> >                 WRITE_ONCE(*y, 42);
> > }  
> 
> Yeah, I'm not too bothered about this. Broken is broken.
> 
> If this were a compiler feature, the above would be a compile error. But
> alas, we're not there yet :/ and the best we get to say at this point
> is: don't do that then.

Ha! Fixed it for you:

#define volatile_if(cond) if (({ bool __t = (cond); BUILD_BUG_ON(__builtin_constant_p(__t)); volatile_cond(__t); }))

