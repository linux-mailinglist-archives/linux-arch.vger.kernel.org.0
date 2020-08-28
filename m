Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F36A4255DA3
	for <lists+linux-arch@lfdr.de>; Fri, 28 Aug 2020 17:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728303AbgH1PSu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 28 Aug 2020 11:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbgH1PSi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 28 Aug 2020 11:18:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 497A4C061232;
        Fri, 28 Aug 2020 08:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JKeQhoL4ZGEC1cQ3dqsE2L0OJR8mxSbszUgCFLGMeHU=; b=akxcjAXj7YDrUyYX/ul5o0ob5U
        1i5uGkMZRpQ5UtXXOws2Aba+T8Q+HX0Y8z4nA/7EkMhIL1pW9f22OIg9Bld1yw5lexb4ubdOtr8jk
        SDLi3SwWww7gVfAW+35tZgteI7vlPuuiNX0EuvxBBSaZ4F3OdCxw2j7gsW/WqjQbeYegHB71HNvj6
        TtBUBJUtkFETb8dInAatRAxKIqT7RjQ05Ww9A4V8zHT9XZsknYq+FYy4JH6qu3K6vKIlDxaSDfanq
        KumAjmhx4ZsB06vkUnJJ9keX87zp4QGtiyfNn5dlPLQkDgjva9CtqZAxhzoKWhAV5AcCkbZ7M079h
        N83qcvtg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kBg8m-0003cX-Cf; Fri, 28 Aug 2020 15:18:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 85D5A30015A;
        Fri, 28 Aug 2020 17:18:06 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 353B42C5FEF21; Fri, 28 Aug 2020 17:18:06 +0200 (CEST)
Date:   Fri, 28 Aug 2020 17:18:06 +0200
From:   peterz@infradead.org
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Eddy_Wu@trendmicro.com,
        x86@kernel.org, davem@davemloft.net, rostedt@goodmis.org,
        naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        linux-arch@vger.kernel.org, cameron@moodycamel.com,
        oleg@redhat.com, will@kernel.org, paulmck@kernel.org
Subject: Re: [PATCH v4 20/23] [RFC] kprobes: Remove task scan for updating
 kretprobe_instance
Message-ID: <20200828151806.GF1362448@hirez.programming.kicks-ass.net>
References: <159861759775.992023.12553306821235086809.stgit@devnote2>
 <159861781740.992023.4956784710984854658.stgit@devnote2>
 <20200828125236.GA1362448@hirez.programming.kicks-ass.net>
 <20200829001010.7ec1a183c2294f7bd843b153@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200829001010.7ec1a183c2294f7bd843b153@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Aug 29, 2020 at 12:10:10AM +0900, Masami Hiramatsu wrote:
> On Fri, 28 Aug 2020 14:52:36 +0200
> peterz@infradead.org wrote:

> > >  	synchronize_rcu();
> > 
> > This one might help, this means we can do rcu_read_lock() around
> > get_kretprobe() and it's usage. Can we call rp->handler() under RCU?
> 
> Yes, as I said above, the get_kretprobe() (and kretprobe handler) must be
> called under preempt-disabled.

Then we don't need the ordering; we'll need READ_ONCE() (or
rcu_derefernce()) to make sure the address dependency works on Alpha.
And a comment/assertion that explains this might not go amiss in
get_kretprobe().
