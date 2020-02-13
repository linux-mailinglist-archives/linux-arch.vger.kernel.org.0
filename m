Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5DF515BAC5
	for <lists+linux-arch@lfdr.de>; Thu, 13 Feb 2020 09:28:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729406AbgBMI2n (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 13 Feb 2020 03:28:43 -0500
Received: from merlin.infradead.org ([205.233.59.134]:37882 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729401AbgBMI2n (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 13 Feb 2020 03:28:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fWWQVJH6jVRQdf2/X+vSpBWX6L3mpdhm8g7q3TQeAEU=; b=q824KgdOALQPoLYbcAq6PXAlq4
        KSmkRNffNlPgGaimTUf23VxILUjZHorck9ssJ24TWk3Bop40ecM8eOaYxt9umXde4Fpz2bdWi0EZL
        DwwzDXKqNmOcRF2I84JLps6A6Kc7UNpmrI3FUR7obq1By/FWqXsTgoSmB/y3CqgyQ7Eny4H6L171n
        NN3x04O7OIrpoEMTMhEx2QPYJmN9Wtvk1xEe5GK0BB+DtfAk+WPAd/XMGgM3YSgVYjN6p9yBMkt5T
        xBRBeCY8LsGZrSF71vfmwHxxOO7pMRbspZ6idC+lY+asJcq+uBhXXyfoVJhArDjx3Ojv3m1nCEPcX
        mFytarJA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j29r6-0005da-6k; Thu, 13 Feb 2020 08:28:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 70AC43013A4;
        Thu, 13 Feb 2020 09:26:25 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 046CA2B4CEB00; Thu, 13 Feb 2020 09:28:15 +0100 (CET)
Date:   Thu, 13 Feb 2020 09:28:14 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        rostedt@goodmis.org, mingo@kernel.org, gregkh@linuxfoundation.org,
        gustavo@embeddedor.com, tglx@linutronix.de, paulmck@kernel.org,
        josh@joshtriplett.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com
Subject: Re: [PATCH v2 3/9] rcu,tracing: Create trace_rcu_{enter,exit}()
Message-ID: <20200213082814.GJ14897@hirez.programming.kicks-ass.net>
References: <20200212210139.382424693@infradead.org>
 <20200212210749.971717428@infradead.org>
 <20200212232702.GA170680@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212232702.GA170680@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 12, 2020 at 06:27:02PM -0500, Joel Fernandes wrote:
> On Wed, Feb 12, 2020 at 10:01:42PM +0100, Peter Zijlstra wrote:

> > +#define trace_rcu_enter()					\
> > +({								\
> > +	unsigned long state = 0;				\
> > +	if (!rcu_is_watching())	{				\
> > +		if (in_nmi()) {					\
> > +			state = __TR_NMI;			\
> > +			rcu_nmi_enter();			\
> > +		} else {					\
> > +			state = __TR_IRQ;			\
> > +			rcu_irq_enter_irqsave();		\
> 
> Since rcu_irq_enter_irqsave can be called from a tracer context, should those
> be marked with notrace as well? AFAICS, there's no notrace marking on them.

It should work, these functions are re-entrant (as are IRQs / NMIs) and
Steve wants to be able to trace RCU itself.
