Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 162C8164B7A
	for <lists+linux-arch@lfdr.de>; Wed, 19 Feb 2020 18:06:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgBSRGm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Feb 2020 12:06:42 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:37052 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbgBSRGm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Feb 2020 12:06:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2VDm9Fwq67hCgvrGLKykwfQSF1ZpYJUcsbBnQHg4U9M=; b=O8HyjDjI2sGm6H6UZ8E5I1dKat
        XIfbN3C0aPnxB1MU/SjvSynwdpUzbABrOO5i4DvLL2fxQ6yHBKAhkz3P3BJ+dq59SxPXAs/RNjFxd
        9NyzmpHrQXeK3+QLp3D5eQ7yGep63Bnrod8J4p7y2f7p9YFv/yGqtjH2iCMbSh65lz+hDkeHgN6RS
        W45VjWlZB3nmpq45D/x574srSS9SJiFxn4YSCTDHG67SdToR48JmK9EmaqVweBPUGcXo1n53RRG7o
        qrkuNC5GYKUxFguqmDBbrIr3/hCkXzkZhRlhzFKkFPeFmQhXF5FJ653p4sTtCa4C2hfYu5SrB4DOD
        PgCFKrtA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4Snb-00014d-FK; Wed, 19 Feb 2020 17:06:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F1BCD300606;
        Wed, 19 Feb 2020 18:04:16 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 46FAD202287DD; Wed, 19 Feb 2020 18:06:09 +0100 (CET)
Date:   Wed, 19 Feb 2020 18:06:09 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        rostedt@goodmis.org, mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        luto@kernel.org, tony.luck@intel.com, frederic@kernel.org,
        dan.carpenter@oracle.com, mhiramat@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Marco Elver <elver@google.com>
Subject: Re: [PATCH v3 18/22] asm-generic/atomic: Use __always_inline for
 fallback wrappers
Message-ID: <20200219170609.GN18400@hirez.programming.kicks-ass.net>
References: <20200219144724.800607165@infradead.org>
 <20200219150745.416854783@infradead.org>
 <20200219165521.GG2935@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219165521.GG2935@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 19, 2020 at 08:55:21AM -0800, Paul E. McKenney wrote:
> On Wed, Feb 19, 2020 at 03:47:42PM +0100, Peter Zijlstra wrote:
> > While the fallback wrappers aren't pure wrappers, they are trivial
> > nonetheless, and the function they wrap should determine the final
> > inlining policy.
> > 
> > For x86 tinyconfig we observe:
> >  - vmlinux baseline: 1315988
> >  - vmlinux with patch: 1315928 (-60 bytes)
> > 
> > Suggested-by: Mark Rutland <mark.rutland@arm.com>
> > Signed-off-by: Marco Elver <elver@google.com>
> > Acked-by: Mark Rutland <mark.rutland@arm.com>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> And this one and the previous one are also already in -tip, FYI.

That's where I found them ;-) Stole them from tip/locking/kcsan.
