Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB8E3A402A
	for <lists+linux-arch@lfdr.de>; Fri, 11 Jun 2021 12:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbhFKK2u (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Jun 2021 06:28:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:54374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230321AbhFKK2t (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 11 Jun 2021 06:28:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 90901613DE;
        Fri, 11 Jun 2021 10:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623407211;
        bh=uwYHPJSg++x6nayJxNLyMIhWvBZRZ31Cc/mjNWAEOW0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l6Ps2bJf8EUFGrwM/uLjxcqpZtDtHrV8QoI1ui3ts/NpKYm+8ny2k+aLdy46dnb/g
         wCAJY3LyZMTz2oVbfNhBVQ6P7gz551Fa4dFwzB+7x9PEv0sQZXpBGSxyLGqe79EhrT
         Lu2kjHyVwkyC9eV2Mqa4qVTL543VpUgDDqDQ0q980NeXEXearpNN2FmPkKuTmdEhEQ
         YfRhP00b1vz/D2QpBjnhvMd6dzMSBroOWJtUz1FDaCjBMyCExdD0haXxmQUAIiBDPR
         bfspzxTWQ0eiewqLYzLXQoRMK0FVI+O81KmPBGeaOqZF1rZyRRNNjPSz1ldxidS1VM
         B6FphYs0NCgug==
Date:   Fri, 11 Jun 2021 11:26:41 +0100
From:   Will Deacon <will@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
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
        Pavel Machek <pavel@ucw.cz>, Waiman Long <longman@redhat.com>,
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
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v2 2/7] sched: Introduce task_is_running()
Message-ID: <20210611102640.GA15274@willie-the-truck>
References: <20210611082810.970791107@infradead.org>
 <20210611082838.222401495@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210611082838.222401495@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jun 11, 2021 at 10:28:12AM +0200, Peter Zijlstra wrote:
> Replace a bunch of 'p->state == TASK_RUNNING' with a new helper:
> task_is_running(p).
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Acked-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>  arch/alpha/kernel/process.c    |    2 +-
>  arch/arc/kernel/stacktrace.c   |    2 +-
>  arch/arm/kernel/process.c      |    2 +-
>  arch/arm64/kernel/process.c    |    2 +-
>  arch/csky/kernel/stacktrace.c  |    2 +-
>  arch/h8300/kernel/process.c    |    2 +-
>  arch/hexagon/kernel/process.c  |    2 +-
>  arch/ia64/kernel/process.c     |    4 ++--
>  arch/m68k/kernel/process.c     |    2 +-
>  arch/mips/kernel/process.c     |    2 +-
>  arch/nds32/kernel/process.c    |    2 +-
>  arch/nios2/kernel/process.c    |    2 +-
>  arch/parisc/kernel/process.c   |    4 ++--
>  arch/powerpc/kernel/process.c  |    4 ++--
>  arch/riscv/kernel/stacktrace.c |    2 +-
>  arch/s390/kernel/process.c     |    2 +-
>  arch/s390/mm/fault.c           |    2 +-
>  arch/sh/kernel/process_32.c    |    2 +-
>  arch/sparc/kernel/process_32.c |    3 +--
>  arch/sparc/kernel/process_64.c |    3 +--
>  arch/um/kernel/process.c       |    2 +-
>  arch/x86/kernel/process.c      |    4 ++--
>  arch/xtensa/kernel/process.c   |    2 +-

Cheers for adding the missing arch bits:

Acked-by: Will Deacon <will@kernel.org>

Will
