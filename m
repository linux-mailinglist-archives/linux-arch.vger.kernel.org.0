Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 608CB2556D9
	for <lists+linux-arch@lfdr.de>; Fri, 28 Aug 2020 10:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbgH1ItR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 28 Aug 2020 04:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbgH1ItP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 28 Aug 2020 04:49:15 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE31C061264;
        Fri, 28 Aug 2020 01:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=k8aPF73jxQe0xsExpEcThESxr3TxPHZHxMhHZh2teH4=; b=duPFIWfR7dv63evjzP0erJXqD8
        0eHf+nY8HPAZWqwHPzsnS2DRA/Vo0aEt9AqB7QMok6mgRVohmdBefpOhRWUpzO+cIRYh5JrV59FfU
        OD+NKllFG4RWjleIQmP/OKtTP4oirxt3UKAqrOKE/3AXqG1cPXJXqva4g6jmO989UNZqZoNaItqHs
        tMLtt9//vxsothJ3qHss5bTu0AlzXx7t7uTrnD9I74SoLnN/W63UweDdIw/iLefc5iF9vJ0UicBJY
        hMTzrfa8+IAdwoSnryokEh+dbK5rw9U+HSEhKrTOBfLtldFrJxdSV8MrHmSIxJo2vv0t3mSAi2rTW
        ws2TEZiw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kBa45-0006bO-Ac; Fri, 28 Aug 2020 08:48:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E2392300238;
        Fri, 28 Aug 2020 10:48:51 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 986532C5F134C; Fri, 28 Aug 2020 10:48:51 +0200 (CEST)
Date:   Fri, 28 Aug 2020 10:48:51 +0200
From:   peterz@infradead.org
To:     linux-kernel@vger.kernel.org, mhiramat@kernel.org
Cc:     Eddy_Wu@trendmicro.com, x86@kernel.org, davem@davemloft.net,
        rostedt@goodmis.org, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, linux-arch@vger.kernel.org,
        cameron@moodycamel.com, oleg@redhat.com, will@kernel.org,
        paulmck@kernel.org
Subject: Re: [RFC][PATCH 7/7] kprobes: Replace rp->free_instance with freelist
Message-ID: <20200828084851.GQ1362448@hirez.programming.kicks-ass.net>
References: <20200827161237.889877377@infradead.org>
 <20200827161754.594247581@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200827161754.594247581@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Aug 27, 2020 at 06:12:44PM +0200, Peter Zijlstra wrote:
>  struct kretprobe_instance {
>  	union {
> +		/*
> +		 * Dodgy as heck, this relies on not clobbering freelist::refs.
> +		 * llist: only clobbers freelist::next.
> +		 * rcu: clobbers both, but only after rp::freelist is gone.
> +		 */
> +		struct freelist_node freelist;
>  		struct llist_node llist;
> -		struct hlist_node hlist;
>  		struct rcu_head rcu;
>  	};

Masami, make sure to make this something like:

	union {
		struct freelist_node freelist;
		struct rcu_head rcu;
	};
	struct llist_node llist;

for v4, because after some sleep I'm fairly sure what I wrote above was
broken.

We'll only use RCU once the freelist is gone, so sharing that storage
should still be okay.
