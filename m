Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67A1D15CA8C
	for <lists+linux-arch@lfdr.de>; Thu, 13 Feb 2020 19:38:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbgBMSi1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 13 Feb 2020 13:38:27 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:40767 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727720AbgBMSi1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 13 Feb 2020 13:38:27 -0500
Received: by mail-qv1-f66.google.com with SMTP id q9so2160556qvu.7
        for <linux-arch@vger.kernel.org>; Thu, 13 Feb 2020 10:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FA/jDQzw6U/ZCCi4VgdRfvIwQUyHVGJoT6PY/S7rCjI=;
        b=YnZIhmvpQBUAmh2lcrs7K6ZFzcVvpxyqjJ5wq2FlHG+LUbz0FpbM1Ziq81a0WKFe/k
         7qPcdx0Zxp7QXTLzGV10lyJQd2k1EGofEFFuNbHQShM0gq54CuSvTrKb0mWdILETcG/s
         vzxCSWKHQX9M6O7OsBO2RWD8Od6vLsvNWj6x4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FA/jDQzw6U/ZCCi4VgdRfvIwQUyHVGJoT6PY/S7rCjI=;
        b=qDlzjoB0WDliV90OCO5Cpz0ZR8GeU3aNADPH5AJp0FiBeKZo5qaXU69LL/83DMJNzv
         lBJbOHZ1bh/FBnSkuGYPOJHz0cieQ9PvnQlZVFos0tsgPsGa00RVIi00XWigDlx7Torq
         K4XzIJJSH4vJBFDKDcYHJ5SAYNvQxgZgltTyZMmdN2nZ8sZrNozeHikVeZAdXibBkvrL
         hygvjIPEG5o6OSbAhDOPNH8KztaAJ5RaAjqAIAU3B1qORuGnDjmD+/qaDi0rlYkEu5Op
         ISz36lbUMbB+2gau+ZH0IKl82XKb/DZkKFv4Y8PUkXPqjxyJRe+4WU2EPQw5lKacnTmK
         Fjtg==
X-Gm-Message-State: APjAAAUiunfkZyWUVoEe+3I792b2sGvopxSD/S6TSi2qQlaLLBFpxTMp
        HRghaJcFJHhqComlTCX2JS2VSg==
X-Google-Smtp-Source: APXvYqzMIIh+00fsRTKdPae9JRiE6STFYIEoI6392QTap2lTzcC4ppc7frj+4ki7N55cUyt2YnceKg==
X-Received: by 2002:ad4:4e24:: with SMTP id dm4mr12561501qvb.170.1581619106235;
        Thu, 13 Feb 2020 10:38:26 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id 17sm1787747qkh.29.2020.02.13.10.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 10:38:25 -0800 (PST)
Date:   Thu, 13 Feb 2020 13:38:25 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        rostedt@goodmis.org, mingo@kernel.org, gregkh@linuxfoundation.org,
        gustavo@embeddedor.com, tglx@linutronix.de, paulmck@kernel.org,
        josh@joshtriplett.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com,
        "Steven Rostedt (VMware)" <rosted@goodmis.org>
Subject: Re: [PATCH v2 6/9] perf,tracing: Prepare the perf-trace interface
 for RCU changes
Message-ID: <20200213183825.GA207225@google.com>
References: <20200212210139.382424693@infradead.org>
 <20200212210750.142334759@infradead.org>
 <20200212232830.GB170680@google.com>
 <20200213082951.GK14897@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213082951.GK14897@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Feb 13, 2020 at 09:29:51AM +0100, Peter Zijlstra wrote:
> On Wed, Feb 12, 2020 at 06:28:30PM -0500, Joel Fernandes wrote:
> > On Wed, Feb 12, 2020 at 10:01:45PM +0100, Peter Zijlstra wrote:
> > > The tracepoint interface will stop providing regular RCU context; make
> > > sure we do it ourselves, since perf makes use of regular RCU protected
> > > data.
> > > 
> > > Suggested-by: Steven Rostedt (VMware) <rosted@goodmis.org>
> > > Suggested-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > ---
> > >  kernel/events/core.c |    5 +++++
> > >  1 file changed, 5 insertions(+)
> > > 
> > > --- a/kernel/events/core.c
> > > +++ b/kernel/events/core.c
> > > @@ -8950,6 +8950,7 @@ void perf_tp_event(u16 event_type, u64 c
> > >  {
> > >  	struct perf_sample_data data;
> > >  	struct perf_event *event;
> > > +	unsigned long rcu_flags;
> > 
> > The flags are not needed I guess, if you agree on not using in_nmi() in
> > trace_rcu_enter().
> 
> Even then we need to store the state: 'didn't do nothing' vs 'did call
> rcu_needs_to_wake_up_and_pay_attention_noaw'. That is, we only need to
> do something (expensive!) when !rcu_is_watching().

You are right, that sounds good. I was talking to Paul and we chatted that if
in_nmi() is safe (which I believe it is as we are not calling RCU before you
update the preempt counts), then in RCU we can replace the @irq with
!in_nmi() and simplify that code.  Then we can simplify this bit as well
(keep rcu_flags but only call rcu_irq_enter_irqsave() instead of
rcu_nmi_enter(). May be you can do the RCU internal bits in your v3 or should
those be separate patches? Whatever Paul and you want to do.

thanks,

 - Joel

 - Joel

