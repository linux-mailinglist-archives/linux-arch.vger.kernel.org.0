Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5D2115A58A
	for <lists+linux-arch@lfdr.de>; Wed, 12 Feb 2020 11:01:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728781AbgBLKB3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 Feb 2020 05:01:29 -0500
Received: from merlin.infradead.org ([205.233.59.134]:33092 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728745AbgBLKB3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Feb 2020 05:01:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vmVcNp5qMZzdUdSZWSizA+92PAY3N8xDElToXt9qO7s=; b=RcqtaBtjoSUkXiIj/AcVat4N5a
        5RNdGUDjTDltWOV04YoqWBTWVY6ScTJJl7zSQvvwbHWip8jZOLqI6KirYpqeQB34P+wo6+0aQkMsf
        koy5kpkUMB5H3LwxseZgp/J4DgvDWplbRsCxdxV34tCe6CioeSUorn1D9JfZWtdyGaqku/9CIKK9g
        PS8DdE6guOBCllTcj9GwF+4EzZkP+alnSedaO4w4zVYRRiFj7F8kNyCuyNRZIXTqLBtkUzQjqW2ov
        S34n/4L7+JVhNZPtP8iDvcsBKKMwXVsw9EymHY9JpDpJ2dl+VdyFAqMQiFJXvyUMMsWlz3g/W+iHx
        7Beoppmg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1opQ-0006Zo-JN; Wed, 12 Feb 2020 10:01:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AAFF7300679;
        Wed, 12 Feb 2020 10:59:17 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9C8DB2B2A98AF; Wed, 12 Feb 2020 11:01:06 +0100 (CET)
Date:   Wed, 12 Feb 2020 11:01:06 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        rostedt@goodmis.org, james.morse@arm.com, will@kernel.org,
        catalin.marinas@arm.com
Cc:     mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com
Subject: Re: [PATCH 0/8] tracing vs rcu vs nmi
Message-ID: <20200212100106.GA14914@hirez.programming.kicks-ass.net>
References: <20200212093210.468391728@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212093210.468391728@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 12, 2020 at 10:32:10AM +0100, Peter Zijlstra wrote:
> Hi all,
> 
> These here patches are the result of Mathieu and Steve trying to get commit
> 865e63b04e9b2 ("tracing: Add back in rcu_irq_enter/exit_irqson() for rcuidle
> tracepoints") reverted again.
> 
> One of the things discovered is that tracing MUST NOT happen before nmi_enter()
> or after nmi_exit(). I've only fixed x86, but quickly gone through other
> architectures and there is definitely more stuff to be fixed (simply grep for
> nmi_enter in your arch).

For ARM64:

 - apei_claim_sea()
 - __sdei_handler()
 - do_serror()
 - debug_exception_enter() / do_debug_exception()

all look dodgy.
