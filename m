Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B454C3A9BE4
	for <lists+linux-arch@lfdr.de>; Wed, 16 Jun 2021 15:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233205AbhFPN0X (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Jun 2021 09:26:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45389 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232766AbhFPN0W (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 16 Jun 2021 09:26:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623849856;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6tLWFqQWEsz56Ko5PZv18XXeVsybxvSI9R/PpDg/CYY=;
        b=BMTDSX7gYmQVp59K8GN7MSFBR5j23p128JFMME9dsLqU7J5vXj+foTzERArWZuHhVqIssg
        YFYap/n0RxoX3u550w1W/Rr+NY8wlTHiSkNGB1XeVo5ZSmKRMxssehvdg734XoEPPUzeJx
        0W79OhBYjxs9OEkl0ENZRDra1in/Jw8=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-460-tUxQgoDAPtGFEs5-X8iO4A-1; Wed, 16 Jun 2021 09:24:14 -0400
X-MC-Unique: tUxQgoDAPtGFEs5-X8iO4A-1
Received: by mail-ej1-f71.google.com with SMTP id gv42-20020a1709072beab02903eab8e33118so926385ejc.19
        for <linux-arch@vger.kernel.org>; Wed, 16 Jun 2021 06:24:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6tLWFqQWEsz56Ko5PZv18XXeVsybxvSI9R/PpDg/CYY=;
        b=HYgQQMNyF4kPjtJbJoLELuQmnpqf79lqC4eCVVcUJFGguWHk7yJIYqithvf/72rPuf
         TpDsrGRwSbSmLUJ7RkUmn6dwKLPo5NE7Tt/TFuz86YHz+79wM0a3/jwF/16vnQ8VQCuu
         LHWwzzF5scnNZxSS1QlWSYnbaZB1ULvZyM6gRqT4j9Qg+UmcAQg6qmZwMBue1dayJt5o
         +ZNpBXitxwRLfYHMi8VMvBGfrLtgoHVzXQ66QEnHv++nggkHtoT+2Pl9fC6aUNCE88rx
         fFNgN63kfZYNOsYYbNEG4IHJOb7vq54+L1ioyRrfz/BGHUJJwBNi+NhjmcEcU3SAker0
         oB3A==
X-Gm-Message-State: AOAM533MJSZVYIh1TAL0ks5SknOvXdMq9bWXCxvh9w8JZMwxAEGBKiUi
        zcd2Mb9WO8oYvbNQxnqeHXT1WZ9zJHgFQNn2ZFyhkA55aanniNTXO9TkxnJno/jNiedC///c7Ae
        PDo0YZp0GafHBk+iMde2N74T4jaXXmHY1kTOgqGB+Fuiar10uTEPFOlHN8tq6Hz8yajKksW1M
X-Received: by 2002:aa7:cf0f:: with SMTP id a15mr4138468edy.313.1623849853529;
        Wed, 16 Jun 2021 06:24:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwNlF2rQXtcidlADi5H32n7IyqgG9rDrZlrCXZqQXkNq/nK4wUcA6Bg8JuT7PnyUUx+ExFJKA==
X-Received: by 2002:aa7:cf0f:: with SMTP id a15mr4138397edy.313.1623849853297;
        Wed, 16 Jun 2021 06:24:13 -0700 (PDT)
Received: from x1.bristot.me (host-79-23-205-114.retail.telecomitalia.it. [79.23.205.114])
        by smtp.gmail.com with ESMTPSA id b25sm1846160edv.9.2021.06.16.06.24.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jun 2021 06:24:12 -0700 (PDT)
Subject: Re: [PATCH v2 7/7] sched: Change task_struct::state
To:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>
Cc:     Borislav Petkov <bp@alien8.de>, x86@kernel.org,
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
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
References: <20210611082810.970791107@infradead.org>
 <20210611082838.550736351@infradead.org>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <baf4b8d9-5801-45a8-d92a-be45a918e855@redhat.com>
Date:   Wed, 16 Jun 2021 15:24:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210611082838.550736351@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 6/11/21 10:28 AM, Peter Zijlstra wrote:
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -348,10 +348,10 @@ static void task_non_contending(struct t
>  	if ((zerolag_time < 0) || hrtimer_active(&dl_se->inactive_timer)) {
>  		if (dl_task(p))
>  			sub_running_bw(dl_se, dl_rq);
> -		if (!dl_task(p) || p->state == TASK_DEAD) {
> +		if (!dl_task(p) || READ_ONCE(p->__state) == TASK_DEAD) {
>  			struct dl_bw *dl_b = dl_bw_of(task_cpu(p));
>  
> -			if (p->state == TASK_DEAD)
> +			if (READ_ONCE(p->__state) == TASK_DEAD)
>  				sub_rq_bw(&p->dl, &rq->dl);
>  			raw_spin_lock(&dl_b->lock);
>  			__dl_sub(dl_b, p->dl.dl_bw, dl_bw_cpus(task_cpu(p)));
> @@ -1355,10 +1355,10 @@ static enum hrtimer_restart inactive_tas
>  	sched_clock_tick();
>  	update_rq_clock(rq);
>  
> -	if (!dl_task(p) || p->state == TASK_DEAD) {
> +	if (!dl_task(p) || READ_ONCE(p->__state) == TASK_DEAD) {
>  		struct dl_bw *dl_b = dl_bw_of(task_cpu(p));
>  
> -		if (p->state == TASK_DEAD && dl_se->dl_non_contending) {
> +		if (READ_ONCE(p->__state) == TASK_DEAD && dl_se->dl_non_contending) {
>  			sub_running_bw(&p->dl, dl_rq_of_se(&p->dl));
>  			sub_rq_bw(&p->dl, dl_rq_of_se(&p->dl));
>  			dl_se->dl_non_contending = 0;
> @@ -1722,7 +1722,7 @@ static void migrate_task_rq_dl(struct ta
>  {
>  	struct rq *rq;
>  
> -	if (p->state != TASK_WAKING)
> +	if (READ_ONCE(p->__state) != TASK_WAKING)
>  		return;
>  
>  	rq = task_rq(p);

Reviewed-by: Daniel Bristot de Oliveira <bristot@redhat.com>

Feel free to add it to the other patches as well.

Thanks!
-- Daniel

