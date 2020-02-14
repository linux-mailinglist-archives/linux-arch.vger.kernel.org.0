Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A71D15D01B
	for <lists+linux-arch@lfdr.de>; Fri, 14 Feb 2020 03:42:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728141AbgBNCms (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 13 Feb 2020 21:42:48 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39023 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728004AbgBNCms (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 13 Feb 2020 21:42:48 -0500
Received: by mail-pf1-f196.google.com with SMTP id 84so4109721pfy.6;
        Thu, 13 Feb 2020 18:42:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CZDOMDG2RZUfkNh7l0YIqZzEpJOX/xGLD5t790ic9jk=;
        b=G7Qu3tSHrt5GVgh3YVSDD9xMrSt+jM7YQ6RLz5t0b2v40G9oII/7JxcKUwx56HouiB
         xjyrSR+ow9cK56CEqz+D6Fd+5emgib05c3zyELt/GdW0PsoPNv+1KXMWqRFdhZuTrVpj
         +kRz4UwZjAjPVmssI/TXAla7Q2z/olRUeg4QQXWlQ2TvsjcWgC5T9nzcs5VYC+qspb86
         qeeZkBPSXAmbJtqvUHQHyP0NniyGCZyzR8+Bh088BsCe/eJaJxBYhdeshDyM/k4xkWwj
         f7jPoU/n0VUoh+ybreYjjXeIryGU6bKsyfqeOGqYXOOrxKtxbCWRJKTBBkit5JBwDTTm
         DFIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CZDOMDG2RZUfkNh7l0YIqZzEpJOX/xGLD5t790ic9jk=;
        b=YFwuaUzeA0qDY2hpvrhJRDYCPglzTZZe/X0x5mdkIiCBW2ABulYwPZEi1LGXkxmivJ
         kfZleBK1Cw/97tpnnz64PL8Vs3gm5SaIis6ZKtGwmhnhnSPaYRf5r+DCgFtAmE6S2hom
         Qh2VQVE3VgpjCkNF5cTIGDhuDKzYwKFmfcV/I9G+4Sx3FXtZJfmpSEVHkbskXVD1ZqAl
         GAAHvW61d7r3DbtKqz0exhZLHP7sZNBM4g3ZRnOx1HBq8DqAy4QDOjDFjOaki8CcLiHg
         NbMDsB41/56uWMvnnu9hUe/wnVVezV8MXbomCK1yZOQgztBBVZuW2TPAhEAAF/hmIn9T
         4BdQ==
X-Gm-Message-State: APjAAAUyaxL4xaF6OF613mftApyf579Ja/w83j72BkOguxAwuF8W48GE
        WEit8+pLGXj0f3KjxFtLNtOwUZr0
X-Google-Smtp-Source: APXvYqzUcvIPqYHtwkzQFMd3TRZUQFeZfOgdy6PXX1AKHwaoEchoy9nBhZrFaPduBFTVz3qS3UkshA==
X-Received: by 2002:a63:ff05:: with SMTP id k5mr1020851pgi.185.1581648167823;
        Thu, 13 Feb 2020 18:42:47 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:5bbb:c872:f2b1:f53b])
        by smtp.gmail.com with ESMTPSA id j14sm4584373pgs.57.2020.02.13.18.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 18:42:47 -0800 (PST)
Date:   Fri, 14 Feb 2020 11:42:45 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        rostedt@goodmis.org, mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        sergey.senozhatsky.work@gmail.com
Subject: Re: [PATCH v2 9/9] perf,tracing: Allow function tracing when !RCU
Message-ID: <20200214024244.GH36551@google.com>
References: <20200212210139.382424693@infradead.org>
 <20200212210750.312024711@infradead.org>
 <20200214022839.GG36551@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200214022839.GG36551@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On (20/02/14 11:28), Sergey Senozhatsky wrote:
> On (20/02/12 22:01), Peter Zijlstra wrote:
> > Since perf is now able to deal with !rcu_is_watching() contexts,
> > remove the restraint.
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >  kernel/trace/trace_event_perf.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > --- a/kernel/trace/trace_event_perf.c
> > +++ b/kernel/trace/trace_event_perf.c
> > @@ -477,7 +477,7 @@ static int perf_ftrace_function_register
> >  {
> >  	struct ftrace_ops *ops = &event->ftrace_ops;
> >  
> > -	ops->flags   = FTRACE_OPS_FL_RCU;
> > +	ops->flags   = 0;
> 
> FTRACE_OPS_FL_ENABLED?

No, never mind.

	-ss
