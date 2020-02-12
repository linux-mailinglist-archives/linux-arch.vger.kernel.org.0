Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA4D515ABE3
	for <lists+linux-arch@lfdr.de>; Wed, 12 Feb 2020 16:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbgBLPVa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 Feb 2020 10:21:30 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48376 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727519AbgBLPV3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Feb 2020 10:21:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kOxp9mEib8PrWpqKIrmfxByXwLZKLOabbiFYit+STus=; b=T/FBzZ1fg4VcMPcvl5h5zyNeuk
        zlTHtdit3LTaes4nIEkPpGE1fDCfv+JErwZFbOilw5xufCgKrFEurxsKJgwtj82sUZ/j5G9CzJWbU
        Xn5tdNqwu7aFLopuefh9QNEo+jqql0wGcNLqzklxy1wvzUKq7I30pjfmpeSoBf7z++wbt7j8nMnLv
        opCT5RVRZ4ne1rCAZVO5upd+FlGmI3lvBJEGNAmSRV3BkLxJGWNTAYFVqaJSw39jq0xRzh6aEl0Ug
        sOd9WcZKV2O4mChI3z3jt8eDSY4K68bXGdD+v+P5crQsZVSqEYBrmtFdjsWH/fnPXjA6m0ZLE+FpN
        /5gwcmrA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1tp0-0004Ge-BL; Wed, 12 Feb 2020 15:21:02 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7F3DF30220B;
        Wed, 12 Feb 2020 16:19:11 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8886A2032662E; Wed, 12 Feb 2020 16:21:00 +0100 (CET)
Date:   Wed, 12 Feb 2020 16:21:00 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, james.morse@arm.com,
        catalin.marinas@arm.com, mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com
Subject: Re: [PATCH 0/8] tracing vs rcu vs nmi
Message-ID: <20200212152100.GV14897@hirez.programming.kicks-ass.net>
References: <20200212093210.468391728@infradead.org>
 <20200212100106.GA14914@hirez.programming.kicks-ass.net>
 <20200212105646.GA4017@willie-the-truck>
 <20200212093235.2be06208@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212093235.2be06208@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 12, 2020 at 09:32:34AM -0500, Steven Rostedt wrote:
> I've been trying to get rid of notrace around the kernel, not add more.

As is abundantly clear, I hope, we really need more this time.

You want to trace RCU itself, the concequence is we _MUST_NOT_ trace the
early NMI code until we can distinguish we're *in* NMI code.

There really is no 2 way about it; and I'm not going to wait until some
poor sucker trips over it.
