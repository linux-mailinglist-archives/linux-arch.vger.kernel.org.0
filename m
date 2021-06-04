Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E23DF39BCDD
	for <lists+linux-arch@lfdr.de>; Fri,  4 Jun 2021 18:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbhFDQTb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Jun 2021 12:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbhFDQTa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Jun 2021 12:19:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69D1BC061766;
        Fri,  4 Jun 2021 09:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4TIqxuAtjmYbU2OSV74pXFrJBXrS1Qz+P5gtj2DTtNc=; b=SGA/apo1OYgipms8RsEEofalK7
        wfBmIfnzC2FPQwKF/lmRGA3cLcicoit+A1GfJjyrvke8HNLxq+ZlcarIPcpXYF4nEMjZR5Qfsxz63
        fflFA9xF+roMwaMInlzptkd1Iqzroj7nkPdoIksdOaxji0z1slgmRPudOp+7Qza3wTsRc3hwoVN4m
        V0I157ljSP6Irfo9cBWq7hV0FiYAPH38A0rwiILHXbCCgmmrjU7FEZc9yUSSyY4eZfYSyfkvBJSJu
        EG9jvefnb0f69Znz/M8pvux20vn06+jVgv0V+PWO8EvVzK+GVLg5lJjY+t6l4yGyH/dkDDm+3grR3
        qzAEZSIA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lpCVd-00DKM0-C6; Fri, 04 Jun 2021 16:17:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D48993001DB;
        Fri,  4 Jun 2021 18:17:20 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B3132207AA26E; Fri,  4 Jun 2021 18:17:20 +0200 (CEST)
Date:   Fri, 4 Jun 2021 18:17:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Will Deacon <will@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        paulmck@kernel.org, parri.andrea@gmail.com, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com,
        linux-kernel@vger.kernel.org, linux-toolchains@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [RFC] LKMM: Add volatile_if()
Message-ID: <YLpSEM7sxSmsuc5t@hirez.programming.kicks-ass.net>
References: <YLn8dzbNwvqrqqp5@hirez.programming.kicks-ass.net>
 <20210604104359.GE2318@willie-the-truck>
 <YLoPJDzlTsvpjFWt@hirez.programming.kicks-ass.net>
 <20210604134422.GA2793@willie-the-truck>
 <YLoxAOua/qsZXNmY@hirez.programming.kicks-ass.net>
 <20210604151356.GC2793@willie-the-truck>
 <YLpFHE5Cr45rWTUV@hirez.programming.kicks-ass.net>
 <YLpJ5K6O52o1cAVT@hirez.programming.kicks-ass.net>
 <20210604155154.GG1676809@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210604155154.GG1676809@rowland.harvard.edu>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jun 04, 2021 at 11:51:54AM -0400, Alan Stern wrote:
> On Fri, Jun 04, 2021 at 05:42:28PM +0200, Peter Zijlstra wrote:

> > #define volatile_if(cond) if (({ bool __t = (cond); BUILD_BUG_ON(__builtin_constant_p(__t)); volatile_cond(__t); }))
> 
> That won't help with more complicated examples, such as:
> 
> 	volatile_if (READ_ONCE(*x) * 0 + READ_ONCE(*y))

That's effectively:

	volatile_if (READ_ONCE(*y))
		WRITE_ONCE(*y, 42);

which is a valid, but daft, LOAD->STORE order, no? A compiler might
maybe be able to WARN on that, but that's definitely beyond what we can
do with macros.
