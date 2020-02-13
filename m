Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D19815CA90
	for <lists+linux-arch@lfdr.de>; Thu, 13 Feb 2020 19:39:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbgBMSjQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 13 Feb 2020 13:39:16 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:42063 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727789AbgBMSjP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 13 Feb 2020 13:39:15 -0500
Received: by mail-qv1-f67.google.com with SMTP id dc14so3078807qvb.9
        for <linux-arch@vger.kernel.org>; Thu, 13 Feb 2020 10:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ckZLVESfEdYWN9scXv4QPDAyT2tf1XCLtTQVFWSOkak=;
        b=YBDWZ7Vjv/V8lXoR2mBZRvRi/ceb+/qigcPTiv0Rc4HmE0bQMoDmskrHRs+kVLHUuK
         WDqVZl8aQ5nbXSYtXpUZq2C26c8sXgjTs/PyMKLoYU1sdLrZ8lxFEUaKWWviQ+QNaGmK
         cSWkcMZSlHZdJZCwZk3OE4E9K68A6yoRpkeEY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ckZLVESfEdYWN9scXv4QPDAyT2tf1XCLtTQVFWSOkak=;
        b=t1fmY6o75NlJyTAOBdMy81U1jWUUbehnkRz8LT3T0TX9oREAEe+Q2pCPcCEaEP5WzM
         55UHp+RmPyUwYy0DU8vcUyB0sCdzblTf7Jv0bVY61jNuij51eLtw2TY10Uz7W0HKZ7BJ
         zJeNuwx0fmwtru3YktMrN7aqxEFdk5BSujAOS00X6N5GDT1uPTrx9JsrMfJpuBtLRHq5
         fyWEpXJaEX8bpHrDPYExP652I9bWOJyTOIr0F16/+TyPPr8JvxUg23JYrOcP2VFiaRdz
         PUXJWGhoPhE8ySXP3cDRCaNhdmUNUjPwJGu4yE/DgDD7bjvYEPEYQzEl9jf+rzPzhzqi
         5DVQ==
X-Gm-Message-State: APjAAAWo3l6KAxglLeFn4AVtGeb03Fec3fXPOtshgtRFXJKva2Vuj7Iw
        GCudvmIH7n6FMx2LAeK93DeoCQ==
X-Google-Smtp-Source: APXvYqzHsVALJUWy/T7m4VimAf8+AVDbsjkwQvzvwe13sun3om/9nuVR4fubbIzWUDJvK8agPQGKeg==
X-Received: by 2002:a05:6214:524:: with SMTP id x4mr25320787qvw.4.1581619154824;
        Thu, 13 Feb 2020 10:39:14 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id x197sm1768089qkb.28.2020.02.13.10.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 10:39:14 -0800 (PST)
Date:   Thu, 13 Feb 2020 13:39:14 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        rostedt@goodmis.org, mingo@kernel.org, gregkh@linuxfoundation.org,
        gustavo@embeddedor.com, tglx@linutronix.de, paulmck@kernel.org,
        josh@joshtriplett.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com
Subject: Re: [PATCH v2 3/9] rcu,tracing: Create trace_rcu_{enter,exit}()
Message-ID: <20200213183914.GB207225@google.com>
References: <20200212210139.382424693@infradead.org>
 <20200212210749.971717428@infradead.org>
 <20200212232702.GA170680@google.com>
 <20200213082814.GJ14897@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213082814.GJ14897@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Feb 13, 2020 at 09:28:14AM +0100, Peter Zijlstra wrote:
> On Wed, Feb 12, 2020 at 06:27:02PM -0500, Joel Fernandes wrote:
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
> > Since rcu_irq_enter_irqsave can be called from a tracer context, should those
> > be marked with notrace as well? AFAICS, there's no notrace marking on them.
> 
> It should work, these functions are re-entrant (as are IRQs / NMIs) and
> Steve wants to be able to trace RCU itself.

Hoping there are no recursion scenarios possible, but that sounds good to me. thanks,

 - Joel

