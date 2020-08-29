Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA63925659F
	for <lists+linux-arch@lfdr.de>; Sat, 29 Aug 2020 09:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbgH2HbW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 29 Aug 2020 03:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbgH2HbW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 29 Aug 2020 03:31:22 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A625EC061236;
        Sat, 29 Aug 2020 00:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=279k8AeqOLCTopTeV5uu2VZ9asceYdrmtuKPOqaG8bc=; b=UmsTEw1411nVBcjgUuowDWKFWB
        WzoGCd6PpoQ0VqtNDI9zgVFZlPal6fRAnjhyoYuEywtutKkTG4HsKIwVYweMS+Nf5Pk3dCbivo2k8
        01lln/IP2BqFsaahqVZC7VqMynPiLJyDsTqPZFa1Yz4I4bK3BaorIAiWu1m7eUhgKodFH/gOuIFbu
        6BG6U/eixy02pdpk9QH7XDBZKfdYokq/5IjzuTsXMyCPTKqtVP1thTOjjVckRwVOKCh+WOLNEpRQa
        mm1GDtaIgkeUXrXGlgaJKz0x8oJbzPi0S8dKH2C1v3lcLkWaGsc6f62H56diwpZTNgsFwJTM4ePvm
        80tX+HRQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kBvKA-0002GY-CU; Sat, 29 Aug 2020 07:30:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 561A43011F0;
        Sat, 29 Aug 2020 09:30:49 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 150A722B8F169; Sat, 29 Aug 2020 09:30:49 +0200 (CEST)
Date:   Sat, 29 Aug 2020 09:30:49 +0200
From:   peterz@infradead.org
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Eddy_Wu@trendmicro.com,
        x86@kernel.org, davem@davemloft.net, rostedt@goodmis.org,
        naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        linux-arch@vger.kernel.org, cameron@moodycamel.com,
        oleg@redhat.com, will@kernel.org, paulmck@kernel.org
Subject: Re: [PATCH v4 18/23] sched: Fix try_invoke_on_locked_down_task()
 semantics
Message-ID: <20200829073049.GC2674@hirez.programming.kicks-ass.net>
References: <159861759775.992023.12553306821235086809.stgit@devnote2>
 <159861779482.992023.8503137488052381952.stgit@devnote2>
 <20200829110155.70c676520ad2cfef8374171d@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200829110155.70c676520ad2cfef8374171d@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Aug 29, 2020 at 11:01:55AM +0900, Masami Hiramatsu wrote:
> On Fri, 28 Aug 2020 21:29:55 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > From: Peter Zijlstra <peterz@infradead.org>
> 
> In the next version I will drop this since I will merge the kretprobe_holder
> things into removing kretporbe hash patch.
> 
> However, this patch itself seems fixing a bug of commit 2beaf3280e57
> ("sched/core: Add function to sample state of locked-down task").
> Peter, could you push this separately?

Yeah, Paul and me have a slightly different version for that, this also
changes semantics we're still bickering over ;-)

But yes, I'll take care of it.
