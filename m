Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92F8616A391
	for <lists+linux-arch@lfdr.de>; Mon, 24 Feb 2020 11:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbgBXKLW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Feb 2020 05:11:22 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:41050 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbgBXKLW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 Feb 2020 05:11:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jQLP9mf1jL7YgaAq+WWe3RXOAlNUOB8M/rZLTtdU6Ik=; b=hE/+Zv4YtW+bNi38wjH2XW0cfI
        XfFfIrLWpB9YhWBcW920X1N79/Bwmrd5ByMeR+iEh3DuV9AB0XniibpgIkpGQLvLzSZexAJNNZtvC
        ZHEqi0w8Iw4T2rNYXOXLOnOPyMv/1Ga/esJPtaxdJ4HNV0aRDDJtWuTWm28VlAdUc3kaCz1XDdOBZ
        0AwppBoRlgeswmXoBXHnF1XXpMBJOhNk5+60QnK9l4nqOkhQp/h1Ao29g3L+HseGg74xXw/gEM5BK
        zLQCD5DGJXptRxIvRF1mJfZqocuFU5WOSqnHWOCNkL01zk8bRkwi527iG/VONdS+Kv/sed9UNwaUg
        DH3lXg5w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j6AhR-00034m-MK; Mon, 24 Feb 2020 10:10:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 91C30300F7A;
        Mon, 24 Feb 2020 11:08:56 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F331629B39F55; Mon, 24 Feb 2020 11:10:50 +0100 (CET)
Date:   Mon, 24 Feb 2020 11:10:50 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        rostedt@goodmis.org, mingo@kernel.org, gregkh@linuxfoundation.org,
        gustavo@embeddedor.com, tglx@linutronix.de, paulmck@kernel.org,
        josh@joshtriplett.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, luto@kernel.org, tony.luck@intel.com,
        frederic@kernel.org, dan.carpenter@oracle.com, mhiramat@kernel.org
Subject: Re: [PATCH v4 01/27] lockdep: Teach lockdep about "USED" <- "IN-NMI"
 inversions
Message-ID: <20200224101050.GE14897@hirez.programming.kicks-ass.net>
References: <20200221133416.777099322@infradead.org>
 <20200221134215.090538203@infradead.org>
 <20200222030843.GA191380@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200222030843.GA191380@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Feb 21, 2020 at 10:08:43PM -0500, Joel Fernandes wrote:
> On Fri, Feb 21, 2020 at 02:34:17PM +0100, Peter Zijlstra wrote:
> > nmi_enter() does lockdep_off() and hence lockdep ignores everything.
> > 
> > And NMI context makes it impossible to do full IN-NMI tracking like we
> > do IN-HARDIRQ, that could result in graph_lock recursion.
> 
> The patch makes sense to me.
> 
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
> NOTE:
> Also, I was wondering if we can detect the graph_lock recursion case and
> avoid doing anything bad, that way we enable more of the lockdep
> functionality for NMI where possible. Not sure if the suggestion makes sense
> though!

Yeah, I considered playing trylock games, but figured I shouldn't make
it more complicated that it needs to be.
