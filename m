Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6499A3A3EEC
	for <lists+linux-arch@lfdr.de>; Fri, 11 Jun 2021 11:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbhFKJTU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Jun 2021 05:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbhFKJTT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 Jun 2021 05:19:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 074F9C061574;
        Fri, 11 Jun 2021 02:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=N690ECQPvsAoivaYr746nCr4lTorK6+/ltFMNHOQPHU=; b=po4QGRDeQ+l23bIv8X8YNuxV/T
        3wrAaBtuS1EMBPRbsz/uO10WpvImy/Q0ncsUPqBkf/I57RcN1CMSKMRuX49NSBMMjVMBqkJTQTioG
        1Yfip3uio41jhqDv1isC2Kml1B8llOpWkUdLksxvIKFK3zeNL1jZn+BThk9c8DYTF7v0bC5pjtT7O
        lioIes5+UA55PTQ19ddPGPOScND6esndgalIbMyNXRMWlnCspuBSQVc2bxO6PXUAcSUMA6OF2FZIG
        80IKtGjUncW0FVotgtMJ64D6ATTvKeUnd4ZFfkQaHSGKEx6Wja49xw89v9twPRAJSR6flSB9KBk3p
        nnZeBEMw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lrdEQ-002bbE-PD; Fri, 11 Jun 2021 09:14:13 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 69CEF3001E3;
        Fri, 11 Jun 2021 11:13:34 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4E8A721AB0AC0; Fri, 11 Jun 2021 11:13:34 +0200 (CEST)
Date:   Fri, 11 Jun 2021 11:13:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Jens Axboe <axboe@kernel.dk>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH v2 2/7] sched: Introduce task_is_running()
Message-ID: <YMMpPmDh+7kTecgg@hirez.programming.kicks-ass.net>
References: <20210611082810.970791107@infradead.org>
 <20210611082838.222401495@infradead.org>
 <CAMuHMdWg=Z47A=WEQegn9W_FU-WFDWvmNOWDVm5Kge=d_-GYhA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdWg=Z47A=WEQegn9W_FU-WFDWvmNOWDVm5Kge=d_-GYhA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jun 11, 2021 at 10:49:56AM +0200, Geert Uytterhoeven wrote:
> Hoi Peter,
> 
> Thanks for your patch!
> 
> On Fri, Jun 11, 2021 at 10:36 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > Replace a bunch of 'p->state == TASK_RUNNING' with a new helper:
> > task_is_running(p).
> 
> You're also sticking a READ_ONCE() in the helper, which wasn't done
> by any of the old implementations? Care to mention why?

Patch 7/7 should clarify. Arguably I should leave the READ_ONCE() off
here and only add it there.


