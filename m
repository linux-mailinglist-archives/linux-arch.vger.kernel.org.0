Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01F404EEA60
	for <lists+linux-arch@lfdr.de>; Fri,  1 Apr 2022 11:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235390AbiDAJ2T (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 1 Apr 2022 05:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244634AbiDAJ2S (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 1 Apr 2022 05:28:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB772FA22B;
        Fri,  1 Apr 2022 02:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zD1bh8zBdF6SWEbtcuaNiNWduZj2pRO29dlVMIKrE7w=; b=q4bzTMMtSJLueTsGJcO/34ysUf
        wyz9AQNc0dJ3tUyivpAw4uGN+3qThn7qqycBSDot6XOLEeD5YGQ1VNEUQV8X+Dzkn9dg4SKkgVoQV
        IjVXUjTTMHhQCGjjWzQjmucW6GB4fR194p4vmecZF2ouped3zOnRKYU9GwkHqb6WLgrBmpX8nksta
        5p4tOd3I8CdGlAtEvGgFqgJudyNuHyxEOidXQcJNBMa8A8e0CoccoPzhZtSMFCusH8a+81q1qokJR
        yGTw6U+gJA9bQMziZ0usxZ0DYgClHXU1kzgCCEwI+0F3q2WNJG2D7H2sw7TAYwxUAmR+jR6VHTfM6
        tHJTFp7Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1naDXe-0033hJ-7N; Fri, 01 Apr 2022 09:26:02 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id E05619861EB; Fri,  1 Apr 2022 11:25:59 +0200 (CEST)
Date:   Fri, 1 Apr 2022 11:25:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Byungchul Park <byungchul.park@lge.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Radoslaw Burny <rburny@google.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: Re: [PATCH 2/2] locking: Apply contention tracepoints in the slow
 path
Message-ID: <20220401092559.GW8939@worktop.programming.kicks-ass.net>
References: <20220322185709.141236-1-namhyung@kernel.org>
 <20220322185709.141236-3-namhyung@kernel.org>
 <20220328113946.GA8939@worktop.programming.kicks-ass.net>
 <CAM9d7ciQQEypvv2a2zQLHNc7p3NNxF59kASxHoFMCqiQicKwBA@mail.gmail.com>
 <20220330110853.GK8939@worktop.programming.kicks-ass.net>
 <CAM9d7cjQnThKgsUfnqJDcmBFseSTk-56a6f0sefo1x8D7LWSZw@mail.gmail.com>
 <20220331115916.GU8939@worktop.programming.kicks-ass.net>
 <YkabCQYJmq9G9ZJ4@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkabCQYJmq9G9ZJ4@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Mar 31, 2022 at 11:26:17PM -0700, Namhyung Kim wrote:
> On Thu, Mar 31, 2022 at 01:59:16PM +0200, Peter Zijlstra wrote:
> > I've since pushed out the lot to:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git locking/core
> > 
> > It builds, but I've not actually used it. Much appreciated if you could
> > test.
> > 
> 
> I've tested it and it worked well.  Thanks for your work!
> 
> And we need to add the below too..

Thanks

> ----8<----
> 
> diff --git a/include/trace/events/lock.h b/include/trace/events/lock.h
> index db5bdbb9b9c0..9463a93132c3 100644
> --- a/include/trace/events/lock.h
> +++ b/include/trace/events/lock.h
> @@ -114,7 +114,8 @@ TRACE_EVENT(contention_begin,
>  				{ LCB_F_READ,		"READ" },
>  				{ LCB_F_WRITE,		"WRITE" },
>  				{ LCB_F_RT,		"RT" },
> -				{ LCB_F_PERCPU,		"PERCPU" }
> +				{ LCB_F_PERCPU,		"PERCPU" },
> +				{ LCB_F_MUTEX,		"MUTEX" }
>  			  ))
>  );

Duh, indeed, folded!
