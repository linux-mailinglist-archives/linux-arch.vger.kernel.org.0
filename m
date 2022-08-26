Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAEA55A32C6
	for <lists+linux-arch@lfdr.de>; Sat, 27 Aug 2022 01:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344902AbiHZXsJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 26 Aug 2022 19:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231738AbiHZXsI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 26 Aug 2022 19:48:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85FE8CE47B;
        Fri, 26 Aug 2022 16:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RihkyqkxPM44mhyP+mwM99oIWv5j91aBKkFn/0XdLw0=; b=J/e+vdYyKTfzv8vbnik9utCg1J
        39uMQWQIu/Dej8/Tx74LqhhEmHhwLftQHtTtN+VGHBqPsJ4f/F9Wac40zqlzbpEoHaYdCnkCsUDj+
        GUK/pqARY2RcJSibUWdzuSfbHQ5rt00em2ZgZjLnFz03x9/fEvwsV8wktmZrC5EWbK7hjRsuxrgWP
        dvu7OVqvgDKvJMuaSlfORYhBcUJSMEGSrZldP9GaHUQjRuEXTuP+uoxU8knfDIwnndNbUFu1LBsx3
        UeNMNEFKBfIDpA1bNy1mPxd/KjUorQxaYQox2d9EHQGiFAUjUsxZsYGMv96yTkuIlt9lYLHa9IUOq
        LaZ0KjPQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oRj3H-000xj1-Nr; Fri, 26 Aug 2022 23:47:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E7074300094;
        Sat, 27 Aug 2022 01:47:48 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C51EB2B7E5A5E; Sat, 27 Aug 2022 01:47:48 +0200 (CEST)
Date:   Sat, 27 Aug 2022 01:47:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, parri.andrea@gmail.com,
        will@kernel.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: "Verifying and Optimizing Compact NUMA-Aware Locks on Weak
 Memory Models"
Message-ID: <YwlbpPHzp8tj0Gn0@hirez.programming.kicks-ass.net>
References: <20220826124812.GA3007435@paulmck-ThinkPad-P17-Gen-1>
 <YwjzfASTcODOXP1f@worktop.programming.kicks-ass.net>
 <Ywj+j2kC+5xb6DmO@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ywj+j2kC+5xb6DmO@rowland.harvard.edu>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Aug 26, 2022 at 01:10:39PM -0400, Alan Stern wrote:

> >  - some babbling about a missing propagation -- ISTR Linux if stuffed
> >    full of them, specifically we require stores to auto propagate
> >    without help from barriers
> 
> Not a missing propagation; a late one.
> 
> Don't understand what you mean by "auto propagate without help from 
> barriers".

Linux hard relies on:

	CPU0				CPU1

	WRITE_ONCE(foo, 1);		while (!READ_ONCE(foo));

making forward progress.

There were a few 'funny' uarchs that were broken, see for example commit
a30718868915f.
