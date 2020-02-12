Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A59B15AB03
	for <lists+linux-arch@lfdr.de>; Wed, 12 Feb 2020 15:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727698AbgBLOci (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 Feb 2020 09:32:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:46844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727662AbgBLOci (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 12 Feb 2020 09:32:38 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 547D8206D7;
        Wed, 12 Feb 2020 14:32:36 +0000 (UTC)
Date:   Wed, 12 Feb 2020 09:32:34 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Will Deacon <will@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        james.morse@arm.com, catalin.marinas@arm.com, mingo@kernel.org,
        joel@joelfernandes.org, gregkh@linuxfoundation.org,
        gustavo@embeddedor.com, tglx@linutronix.de, paulmck@kernel.org,
        josh@joshtriplett.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com
Subject: Re: [PATCH 0/8] tracing vs rcu vs nmi
Message-ID: <20200212093235.2be06208@gandalf.local.home>
In-Reply-To: <20200212105646.GA4017@willie-the-truck>
References: <20200212093210.468391728@infradead.org>
        <20200212100106.GA14914@hirez.programming.kicks-ass.net>
        <20200212105646.GA4017@willie-the-truck>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 12 Feb 2020 10:56:46 +0000
Will Deacon <will@kernel.org> wrote:

> Hmm, so looks like we need to spinkle some 'notrace' annotations around
> these. Are there are scenarios where you would want NOKPROBE_SYMBOL() but
> *not* 'notrace'? We've already got the former for the debug exception
> handlers and we probably (?) want it for the SDEI stuff too...

Note, function tracing has a lot of recursion detection, and when
something registers with the function tracer it needs to state if it
can be called when rcu is not watching, or it wont be called then.

And yes, there's plenty of places that we have "nokprobe" but allow
tracing.

I've been trying to get rid of notrace around the kernel, not add more.

-- Steve
