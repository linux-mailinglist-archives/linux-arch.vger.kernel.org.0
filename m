Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB0515B4A2
	for <lists+linux-arch@lfdr.de>; Thu, 13 Feb 2020 00:27:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729220AbgBLX1F (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 Feb 2020 18:27:05 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:46061 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727117AbgBLX1F (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Feb 2020 18:27:05 -0500
Received: by mail-qv1-f65.google.com with SMTP id l14so1771607qvu.12
        for <linux-arch@vger.kernel.org>; Wed, 12 Feb 2020 15:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kTNWibF5tbkLobqhHD4V+kFeYgR//KAz2RdK40R6a+4=;
        b=u9psciCNbDsT6qUbD5ro/cVfFEVW2xyWmVMVMqId/QwrQkrT+KrRh17aDBGPsccKoO
         zaZKFdBejZJATq6jepTQMoGa41JY57r7F7/HW0ogqkdUwc1prWmv5MFA+scuYp4Nw6Gd
         vBZ51+AyfLN8Mxdd60G/KDaGGqpT1ZvRRKlOs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kTNWibF5tbkLobqhHD4V+kFeYgR//KAz2RdK40R6a+4=;
        b=Lq/NsrP/Jw5Hc7tbTt+Yo4iqy5vD78ibQCWFhUjPS/TAkoy/QoqU7Y4phkmd03brrw
         K8zYynYtcs1PK/4gO310GWo8MCEIFFZ86T1pWiGp7GP3Lhmq9/+GQ2m6cBDS02JTdf0I
         ZXHAgAm4NXrJrXeKJykGrDSwj0e+aojgECl/II/z8LEkrObzLPzB/8e6aeRNLwgpcbDV
         +zC27Ymwmevi3XEp+kZu4IKX6NMWF+8MjloguQKFVLhzY3EqHLiBstclKEsMQWLD3crL
         V0gCLTI/TXCpb2N5EIhgPUiPW99K5YLOlfSfMTKXjrU/fpN3+fEJr+MalDcHiSTha72L
         dRsA==
X-Gm-Message-State: APjAAAXNxA3zTQPYRg23ZvDC6DBc4mRw6SIBeJxHclfVECQFXRxJRq6R
        tFcKvV3yzrvY5LimMmko4Am88Q==
X-Google-Smtp-Source: APXvYqyeP6AQshumUNOlf+Y3b/66Lbbev3nq+A2SD1fAG9TX0YJOSCK6ZNzZtmmvlE6IG+G15uDN7Q==
X-Received: by 2002:a0c:fe0d:: with SMTP id x13mr9506026qvr.88.1581550022806;
        Wed, 12 Feb 2020 15:27:02 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id d18sm255530qke.75.2020.02.12.15.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 15:27:02 -0800 (PST)
Date:   Wed, 12 Feb 2020 18:27:02 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        rostedt@goodmis.org, mingo@kernel.org, gregkh@linuxfoundation.org,
        gustavo@embeddedor.com, tglx@linutronix.de, paulmck@kernel.org,
        josh@joshtriplett.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com
Subject: Re: [PATCH v2 3/9] rcu,tracing: Create trace_rcu_{enter,exit}()
Message-ID: <20200212232702.GA170680@google.com>
References: <20200212210139.382424693@infradead.org>
 <20200212210749.971717428@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212210749.971717428@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 12, 2020 at 10:01:42PM +0100, Peter Zijlstra wrote:
> To facilitate tracers that need RCU, add some helpers to wrap the
> magic required.
> 
> The problem is that we can call into tracers (trace events and
> function tracing) while RCU isn't watching and this can happen from
> any context, including NMI.
> 
> It is this latter that is causing most of the trouble; we must make
> sure in_nmi() returns true before we land in anything tracing,
> otherwise we cannot recover.
> 
> These helpers are macros because of header-hell; they're placed here
> because of the proximity to nmi_{enter,exit{().
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  include/linux/hardirq.h |   48 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
> 
> --- a/include/linux/hardirq.h
> +++ b/include/linux/hardirq.h
> @@ -89,4 +89,52 @@ extern void irq_exit(void);
>  		arch_nmi_exit();				\
>  	} while (0)
>  
> +/*
> + * Tracing vs RCU
> + * --------------
> + *
> + * tracepoints and function-tracing can happen when RCU isn't watching (idle,
> + * or early IRQ/NMI entry).
> + *
> + * When it happens during idle or early during IRQ entry, tracing will have
> + * to inform RCU that it ought to pay attention, this is done by calling
> + * rcu_irq_enter_irqsave().
> + *
> + * On NMI entry, we must be very careful that tracing only happens after we've
> + * incremented preempt_count(), otherwise we cannot tell we're in NMI and take
> + * the special path.
> + */
> +
> +#define __TR_IRQ	1
> +#define __TR_NMI	2
> +
> +#define trace_rcu_enter()					\
> +({								\
> +	unsigned long state = 0;				\
> +	if (!rcu_is_watching())	{				\
> +		if (in_nmi()) {					\
> +			state = __TR_NMI;			\
> +			rcu_nmi_enter();			\
> +		} else {					\
> +			state = __TR_IRQ;			\
> +			rcu_irq_enter_irqsave();		\

Since rcu_irq_enter_irqsave can be called from a tracer context, should those
be marked with notrace as well? AFAICS, there's no notrace marking on them.

thanks,

 - Joel


> +		}						\
> +	}							\
> +	state;							\
> +})
> +
> +#define trace_rcu_exit(state)					\
> +do {								\
> +	switch (state) {					\
> +	case __TR_IRQ:						\
> +		rcu_irq_exit_irqsave();				\
> +		break;						\
> +	case __TR_NMI:						\
> +		rcu_nmi_exit();					\
> +		break;						\
> +	default:						\
> +		break;						\
> +	}							\
> +} while (0)
> +
>  #endif /* LINUX_HARDIRQ_H */
> 
> 
