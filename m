Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 159DF17C618
	for <lists+linux-arch@lfdr.de>; Fri,  6 Mar 2020 20:14:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbgCFTOM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 Mar 2020 14:14:12 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:36879 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgCFTOM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 Mar 2020 14:14:12 -0500
Received: by mail-qv1-f68.google.com with SMTP id w16so1029666qvn.4
        for <linux-arch@vger.kernel.org>; Fri, 06 Mar 2020 11:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6b2t4A6NGCaXbHtJi6TbMJSxKUKRxcf/wElpt30nY0g=;
        b=N1MT+syilOyNYAUCLRErWmOJboAM6iLImcB6nz23JfiG36LB96/XWtKyfhbDCO2Ocq
         BwKPKLBGw7m/H5OPTzaSB/vIuxbnoGbUxo1jwjFDj1BeEyjMYy/HrHAcwekSeAycYcBZ
         q7m6xe2DF/lhBHGNtZ6XKWYRFVIvKvjQipzP4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6b2t4A6NGCaXbHtJi6TbMJSxKUKRxcf/wElpt30nY0g=;
        b=YF6EFuONtvGreEPixhNaTCDBor+s1UVfVi0AMexhYCcFp8eK0pf1XiW1P0YwQkIOXK
         4fqA0qfG7WZBWOJqjDMFsSZvjR+jTSAYqf+AhWMDCTh78/8l4q2M+LdXbFR4ofVcUb69
         g4U9xea5v4k22o2hOFxiEk3/zihda0XslqwVm8Fd9cXkBoz8K/R4+V/ngXpx5zcYeCcR
         yeS5UYH4yhE2U21m9zELETpXupFbNuDfpvmHiYeVIYMY5QXJ68d0p8+Qebqh/e/Rs6mR
         hNMqvBAkWjiAHz2b8oSlkgrdkJjGcGut+qoVhjNG+qEVYQoOrVshelBue1Aqf/OF5MvS
         EVRw==
X-Gm-Message-State: ANhLgQ1Rtsibax05oMNapiGS+fALumcnUfc/UFKhDECaFJZBMLoXnY2W
        tY51j/nIjf12E6YcPEwxrtR51A==
X-Google-Smtp-Source: ADFU+vtfHCkqs07wkfQTkSGpc2U+cJSVnNpis/+2j8/iaA6TIBUWgu8YItmwKJlOp+HGWSIFUTA5Kg==
X-Received: by 2002:ad4:4e88:: with SMTP id dy8mr4421977qvb.118.1583522051248;
        Fri, 06 Mar 2020 11:14:11 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id f13sm4034043qte.53.2020.03.06.11.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2020 11:14:10 -0800 (PST)
Date:   Fri, 6 Mar 2020 14:14:10 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        paulmck <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        dan carpenter <dan.carpenter@oracle.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v4 16/27] tracing: Remove regular RCU context for
 _rcuidle tracepoints (again)
Message-ID: <20200306191410.GB60713@google.com>
References: <20200221133416.777099322@infradead.org>
 <20200221134216.051596115@infradead.org>
 <20200306104335.GF3348@worktop.programming.kicks-ass.net>
 <20200306113135.GA8787@worktop.programming.kicks-ass.net>
 <CAADnVQKp=UKg8HAuMOFknhmXtfm_LVu_ynTNJuedHqKdA6zh1g@mail.gmail.com>
 <1896740806.20220.1583510668164.JavaMail.zimbra@efficios.com>
 <20200306125500.6aa75c0d@gandalf.local.home>
 <20200306184538.GA92717@google.com>
 <20200306135925.50c38bec@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200306135925.50c38bec@gandalf.local.home>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Mar 06, 2020 at 01:59:25PM -0500, Steven Rostedt wrote:
[snip]
> > > -			rcu_irq_enter_irqson();				\
> > > -		}							\
> > >  									\
> > >  		it_func_ptr = rcu_dereference_raw((tp)->funcs);		\
> > >  									\
> > >  		if (it_func_ptr) {					\
> > >  			do {						\
> > > +				int rcu_flags;				\
> > >  				it_func = (it_func_ptr)->func;		\
> > > +				if (rcuidle &&				\
> > > +				    (it_func_ptr)->requires_rcu)	\
> > > +					rcu_flags = trace_rcu_enter();	\
> > >  				__data = (it_func_ptr)->data;		\
> > >  				((void(*)(proto))(it_func))(args);	\
> > > +				if (rcuidle &&				\
> > > +				    (it_func_ptr)->requires_rcu)	\
> > > +					trace_rcu_exit(rcu_flags);	\  
> > 
> > Nit: If we have incurred the cost of trace_rcu_enter() once, we can call
> > it only once and then call trace_rcu_exit() after the do-while loop. That way
> > we pay the price only once.
> >
> 
> I thought about that, but the common case is only one callback attached at
> a time. To make the code complex for the non common case seemed too much
> of an overkill. If we find that it does help, it's best to do that as a
> separate patch because then if something goes wrong we know where it
> happened.
> 
> Currently, this provides the same overhead as if each callback did it
> themselves like we were proposing (but without the added need to do it for
> all instances of the callback).

That's ok, it could be a separate patch.

thanks,

 - Joel

