Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A53615BF5E
	for <lists+linux-arch@lfdr.de>; Thu, 13 Feb 2020 14:31:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729948AbgBMNbO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 13 Feb 2020 08:31:14 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40558 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729588AbgBMNbO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 13 Feb 2020 08:31:14 -0500
Received: by mail-qt1-f196.google.com with SMTP id v25so4339760qto.7
        for <linux-arch@vger.kernel.org>; Thu, 13 Feb 2020 05:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6IEsHZFJMl+23M5QA2AtPWKaUyyo+qqKit+87XlJBO0=;
        b=gkeAxQFIpHpyzTIC3whxvisNtVOvDwblwDIpJbaPHNg/E4RjUx5n8JhypSbffNf4ry
         sintmd28BiLxOu7NXwjG7L0wctnXJE/TVbYuxjywfhwFY03i8Ud0dBzefxR3zFSz/0EA
         KN3FjRn17k+uz6APqhThy5ntuBhS+2epjjE9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6IEsHZFJMl+23M5QA2AtPWKaUyyo+qqKit+87XlJBO0=;
        b=DEFaPgXi+kgRo/B/Qe425ib/8131YYWcfJG3v+UraE7jHMtsS3/KT1UkZAPHqQeaWk
         OHWoWBLFuOKeaptGgIHgs4pNAg9RQtRJJ6RR4Of+1kN1CI7p8aobyfM/snDY4Lv+A7n6
         cy85QxWh2JICEDemaT7XCnrdrqGj3yNKCaxuKgiUqmIR5J3rI+p5LLNIpze4HQ05zMdk
         StInsaZ6wCKKRDAE64rQOQctMFWhi5Py2cmYqIC0ysbt9IEYEtD4Z2z19sk3N/hSrj7f
         lYO6G8vUq2JdQXfaXyg9dzjJuRsIY2xjwCsLEUEA1fmo5dGjhEfi9cZGexrfZZRIj692
         +Skw==
X-Gm-Message-State: APjAAAUJwtUo9mMSVWE3mpLC/gR6/EiLswplUXCgnWtOBsRwahH1Ml47
        ynw3tlnKhXPA2Sa0r5e4Fo/FMA==
X-Google-Smtp-Source: APXvYqwTQnhKtvKsYa980wB+b4XcSVoocXslNvbt1WCbkDhze4zkq4QcXoTQPOph+ZpQwUcdntx6uw==
X-Received: by 2002:ac8:1205:: with SMTP id x5mr11622616qti.238.1581600673220;
        Thu, 13 Feb 2020 05:31:13 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id v78sm1341896qkb.48.2020.02.13.05.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 05:31:12 -0800 (PST)
Date:   Thu, 13 Feb 2020 08:31:12 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        rostedt@goodmis.org, mingo@kernel.org, gregkh@linuxfoundation.org,
        gustavo@embeddedor.com, tglx@linutronix.de, paulmck@kernel.org,
        josh@joshtriplett.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com
Subject: Re: [PATCH v2 3/9] rcu,tracing: Create trace_rcu_{enter,exit}()
Message-ID: <20200213133112.GD170680@google.com>
References: <20200212210139.382424693@infradead.org>
 <20200212210749.971717428@infradead.org>
 <20200212232005.GC115917@google.com>
 <20200213082716.GI14897@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213082716.GI14897@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Feb 13, 2020 at 09:27:16AM +0100, Peter Zijlstra wrote:
> On Wed, Feb 12, 2020 at 06:20:05PM -0500, Joel Fernandes wrote:
> > On Wed, Feb 12, 2020 at 10:01:42PM +0100, Peter Zijlstra wrote:
> 
> > > +#define trace_rcu_enter()					\
> > > +({								\
> > > +	unsigned long state = 0;				\
> > > +	if (!rcu_is_watching())	{				\
> > > +		if (in_nmi()) {					\
> > > +			state = __TR_NMI;			\
> > > +			rcu_nmi_enter();			\
> > > +		} else {					\
> > > +			state = __TR_IRQ;			\
> > > +			rcu_irq_enter_irqsave();		\
> > 
> > I think this can be simplified. You don't need to rely on in_nmi() here. I
> > believe for NMI's, you can just call rcu_irq_enter_irqsave() and that should
> > be sufficient to get RCU watching. Paul can correct me if I'm wrong, but I am
> > pretty sure that would work.
> > 
> > In fact, I think a better naming for rcu_irq_enter_irqsave() pair could be
> > (in the first patch):
> > 
> > rcu_ensure_watching_begin();
> > rcu_ensure_watching_end();
> 
> So I hadn't looked deeply into rcu_irq_enter(), it seems to call
> rcu_nmi_enter_common(), but with @irq=true.
> 
> What exactly is the purpose of that @irq argument, and how much will it
> hurt to lie there? Will it come apart if we have @irq != !in_nmi()
> for example?

At least rcu_dynticks_task_exit() and rcu_cleanup_after_idle() seem to be
safe regardless of IRQ or NMI. If they are safe either way, we should
probably get look into removing @irq. But I'm not fully sure and looking
forward to Paul's thought on that.. I would love for us to simplify that as
well if possible.

> There is a comment in there that says ->dynticks_nmi_nesting ought to be
> odd only if we're in NMI. The only place that seems to care is
> rcu_nmi_exit_common(), and that does indeed do something different for
> IRQs vs NMIs.

I know a bit about the counters. I had previously unified it and it passed
RCU torture testing etc. (Didn't get merge as Paul wanted it done slightly
done differently) : https://lore.kernel.org/patchwork/patch/1120022/ . I am
planning to get back to finishing that soon.

About the comment on dynticks_nmi_nesting and counters, you mean this comment
right? The odd value of '1' is just to catch the outer most handler. We need
to enter/exit the EQS (extended QS) state only from the outermost handler. I
believe that would work regardless whether it is NMI and IRQ that are
nesting. If IRQs could nest within other IRQs in Linux, then that could also
very well have used the odd/ even trick.

	/*
	 * If idle from RCU viewpoint, atomically increment ->dynticks
	 * to mark non-idle and increment ->dynticks_nmi_nesting by one.
	 * Otherwise, increment ->dynticks_nmi_nesting by two.  This means
	 * if ->dynticks_nmi_nesting is equal to one, we are guaranteed
	 * to be in the outermost NMI handler that interrupted an RCU-idle
	 * period (observation due to Andy Lutomirski).
	 */

thanks,

 - Joel

