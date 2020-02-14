Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D773B15CFF1
	for <lists+linux-arch@lfdr.de>; Fri, 14 Feb 2020 03:28:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbgBNC2o (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 13 Feb 2020 21:28:44 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37530 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727669AbgBNC2n (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 13 Feb 2020 21:28:43 -0500
Received: by mail-pl1-f194.google.com with SMTP id c23so3129586plz.4;
        Thu, 13 Feb 2020 18:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=C4IOnB+fnAI63RVs1D18HOwt87luoRvhyKaupr5pIOI=;
        b=C+QKtt6iINZJWgDIuAGJrZJh3OCHxD691wPY+cCb+4m3gY8gphafyhFjOsEVX906zh
         ph6eQl+SwkXTQf4l7E6hPI+i68oEarj8zAu2PyX7BKJWA+X7r4EGtOT+q3LtyjVuZkg5
         ZOPCLL8HhsNPk0DWbJxGcyHA6QY2Xi0Xx4dRdw89kl/Lp1K/joY8aNyL4pu0FXgQhfsv
         mtkfamScoy8bcwFbgVnBLWjdw2QgDljmpmpOUnNfwIoEFmR4PVlBSXjgekWc5K5mvZKS
         6aD+XBQ60xVBSrpV3SR9FvEhsbtZ/4bWLMxprDTU0dV+9rz+n1k0RX4z8XiyaZF09ljJ
         lZFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=C4IOnB+fnAI63RVs1D18HOwt87luoRvhyKaupr5pIOI=;
        b=avWJu5pVWGjBQemLlKuA9aUfWLDilQdkjAj7zUley4WxRcECUw28t/SwM7P2bfjKo6
         4BGr6INTc2TvC3/NtR6djgcy1g/a/iKqBzmIG+XQ/9RAhYkMhrJQCSVvA2M034ySV2Ur
         AAd1ixAp3mGzQxlkojt9qqd6fm99cFSG0llQRAuhHUrFmNAB5u04B8daDhb2dxFE+jl6
         HK3y5EagBkqrhwPwyMq+/Z8kZd6H4e+bdNdIWpb4Vi0TuWCArZxEShlcs1VYMd93fa5F
         FYpTPf8rDrnS1LmlFYjCv1hutTrqlVuLedV1J2vaJ5c6t9tsBjaHM6tJ7SLSuNDKkbcq
         1YRg==
X-Gm-Message-State: APjAAAVpSmXSyDtyB1PkgXq98qbPVWq6WX60dyFmFKeK8Lo8FOE3iZNC
        KUa//i59gOPvehVg7xioN7qXQxF4
X-Google-Smtp-Source: APXvYqysmvQH4I+SeH5DEAQx8Jqwb1QR7MI6ER9QrNNigIajV1q/MPLbd+h3SicnL9/W/BEplOMQ6w==
X-Received: by 2002:a17:902:7797:: with SMTP id o23mr931393pll.298.1581647321769;
        Thu, 13 Feb 2020 18:28:41 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:5bbb:c872:f2b1:f53b])
        by smtp.gmail.com with ESMTPSA id l73sm4709372pge.44.2020.02.13.18.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 18:28:40 -0800 (PST)
Date:   Fri, 14 Feb 2020 11:28:39 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        rostedt@goodmis.org, mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com
Subject: Re: [PATCH v2 9/9] perf,tracing: Allow function tracing when !RCU
Message-ID: <20200214022839.GG36551@google.com>
References: <20200212210139.382424693@infradead.org>
 <20200212210750.312024711@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212210750.312024711@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On (20/02/12 22:01), Peter Zijlstra wrote:
> Since perf is now able to deal with !rcu_is_watching() contexts,
> remove the restraint.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/trace/trace_event_perf.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/kernel/trace/trace_event_perf.c
> +++ b/kernel/trace/trace_event_perf.c
> @@ -477,7 +477,7 @@ static int perf_ftrace_function_register
>  {
>  	struct ftrace_ops *ops = &event->ftrace_ops;
>  
> -	ops->flags   = FTRACE_OPS_FL_RCU;
> +	ops->flags   = 0;

FTRACE_OPS_FL_ENABLED?

	-ss
