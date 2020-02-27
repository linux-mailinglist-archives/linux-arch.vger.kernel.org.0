Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F32F31713CC
	for <lists+linux-arch@lfdr.de>; Thu, 27 Feb 2020 10:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728614AbgB0JLS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Feb 2020 04:11:18 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:56870 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728629AbgB0JLS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Feb 2020 04:11:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=N/eG6R5gRkfiRMhJTTXhdsldDieY9WVtiDoVkj36lRQ=; b=CPQPsUrmvVbg2ZfEz0zCKoLGLr
        xCxhaUDi6/YSXfrsBteTXdeqGvM6lccotwD/nYdGIrWfVS6lmmOdatfm17h65xq98+E0Rhqb1Ff8t
        Fnj0594C7tsE5JldKGPjex/V+kpgjW+30JhRo7t9fvLcbWE3rL0dQHKxOoN9we8/UQIVxI+fYz0Yk
        H8Eu38oG0oNT1pcKpo5NKY0GJSsYqIGQ2lt2iLNKb5wJ1UBhzC7ZbF0Bmgw5kOFlt4gf2kwE3B9hp
        IsM5/yzSAcPiKhCkbXm2Lrd6aVqbMXlxdrlVvjHMa5Zao5US8PhWd2PS6c//Tb217Ijy9lZqfYCj1
        CwuBClXw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j7FBt-0000jA-PE; Thu, 27 Feb 2020 09:10:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2935430018B;
        Thu, 27 Feb 2020 10:08:46 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BDF1F2B9AF8CC; Thu, 27 Feb 2020 10:10:42 +0100 (CET)
Date:   Thu, 27 Feb 2020 10:10:42 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        rostedt@goodmis.org, mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        luto@kernel.org, tony.luck@intel.com, dan.carpenter@oracle.com,
        mhiramat@kernel.org, Will Deacon <will@kernel.org>,
        Petr Mladek <pmladek@suse.com>, Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v4 02/27] hardirq/nmi: Allow nested nmi_enter()
Message-ID: <20200227091042.GG18400@hirez.programming.kicks-ass.net>
References: <20200221133416.777099322@infradead.org>
 <20200221134215.149193474@infradead.org>
 <20200221222129.GB28251@lenoir>
 <20200224161318.GG14897@hirez.programming.kicks-ass.net>
 <20200225030905.GB28329@lenoir>
 <20200225154111.GM18400@hirez.programming.kicks-ass.net>
 <20200225221031.GB9599@lenoir>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200225221031.GB9599@lenoir>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Feb 25, 2020 at 11:10:32PM +0100, Frederic Weisbecker wrote:
> So here is my previous proposal, based on a simple counter, this time
> with comments and a few fixes:

I've presumed your SoB and made this your patch.
