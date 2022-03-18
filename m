Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94C814DDA8A
	for <lists+linux-arch@lfdr.de>; Fri, 18 Mar 2022 14:28:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236687AbiCRNaA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Mar 2022 09:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbiCRNaA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Mar 2022 09:30:00 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC7F180041;
        Fri, 18 Mar 2022 06:28:41 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id n2so6959689plf.4;
        Fri, 18 Mar 2022 06:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=T8TYfEa1ru48XVVByk53Qi+iGu8psJDdH3gD/7G0awo=;
        b=oO8RZTq8u1xW4mLhlxq08I5LajCSO8NlGkg5Vwh7s2awgG2XSUSC6a3P+nJy+retw/
         LCiXMgUxnM9xlH4jpZaRNrRRMHvJWTMjLyl+q1yLDPpi/a1ZLsDQHkrXv40owQEvs73R
         QGDAMsc3akoKBKZTcgCeaOVSQ87uL4Pk0r3HQDG1hKObjGWQtbU+/+D6tYg7yW9TTbuN
         8MwUUWNUZdEyCDf3FEsv4T2qZ08fOfSIzj7RQlCn9polG6uoGcRMTsk8v+s1RAY92tdQ
         UF1ka9AbmXK8VK1k/yH43dJD8o0OsO8hH5v+hOHxqHLJEOS6MG3DRwY/XBpxt+jCrqDH
         0bcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=T8TYfEa1ru48XVVByk53Qi+iGu8psJDdH3gD/7G0awo=;
        b=gTI5cTMU+q3gvrYk+vNZPgt4+ZovM6e0nCOW0lSMs1xbMPDFdDxq1m4uHu2yrmKk9S
         LyfM5gONoU79tHWx8DUWbVDwTjapG6H55tdHm8+yNp8TyC3mREF8r94Kfg401zoiuxR5
         zW5N94NCSVN68kEmG+fW42C7DWjytCIUbHmXgxFbtwvRE2qUiuJ0D/mWaDzBqO550poK
         pSfzrL7dwc13lSXHmzY2g0Ivpq+E+wNr93Us9Nr6GyKVHSGm8HEpGiW1blLKnYk60l29
         ubdKk4SW3pX4Qt9YGIlU5VpyjsTEG3BT4vdDCBK8pXdyUwojpTa7UQbv9W46Hr6XygG6
         VD5A==
X-Gm-Message-State: AOAM531znkZ9TtDDa+nmdlWOexSocv076iROQGnl4+vEYGRqI2z9cIVL
        geR0/JbNnlzbYQpZRJLvi3M=
X-Google-Smtp-Source: ABdhPJwPvzGyge1l9ML5FOiHonA62LG+hA/D3eyn/oX5UYdtkXemyceYIAS/eXsTqa3iLkL5Up/fqA==
X-Received: by 2002:a17:90b:1bc7:b0:1c6:c3ac:894a with SMTP id oa7-20020a17090b1bc700b001c6c3ac894amr1347498pjb.125.1647610120543;
        Fri, 18 Mar 2022 06:28:40 -0700 (PDT)
Received: from odroid ([114.29.23.97])
        by smtp.gmail.com with ESMTPSA id l10-20020a056a00140a00b004c55d0dcbd1sm9635671pfu.120.2022.03.18.06.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 06:28:40 -0700 (PDT)
Date:   Fri, 18 Mar 2022 13:28:33 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Byungchul Park <byungchul.park@lge.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Radoslaw Burny <rburny@google.com>, linux-arch@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH 2/2] locking: Apply contention tracepoints in the slow
 path
Message-ID: <20220318132833.GB1665646@odroid>
References: <20220316224548.500123-1-namhyung@kernel.org>
 <20220316224548.500123-3-namhyung@kernel.org>
 <YjSBRNxzaE9c+F/1@boqun-archlinux>
 <20220318132424.GA1665646@odroid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220318132424.GA1665646@odroid>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Mar 18, 2022 at 01:24:24PM +0000, Hyeonggon Yoo wrote:
> On Fri, Mar 18, 2022 at 08:55:32PM +0800, Boqun Feng wrote:
> > On Wed, Mar 16, 2022 at 03:45:48PM -0700, Namhyung Kim wrote:
> > [...]
> > > @@ -209,6 +210,7 @@ static inline int __sched __down_common(struct semaphore *sem, long state,
> > >  								long timeout)
> > >  {
> > >  	struct semaphore_waiter waiter;
> > > +	bool tracing = false;
> > >  
> > >  	list_add_tail(&waiter.list, &sem->wait_list);
> > >  	waiter.task = current;
> > > @@ -220,18 +222,28 @@ static inline int __sched __down_common(struct semaphore *sem, long state,
> > >  		if (unlikely(timeout <= 0))
> > >  			goto timed_out;
> > >  		__set_current_state(state);
> > > +		if (!tracing) {
> > > +			trace_contention_begin(sem, 0);
> > 
> > This looks a littl ugly ;-/
> 
> I agree this can be simplified a bit.
> 
> > Maybe we can rename __down_common() to
> > ___down_common() and implement __down_common() as:
> > 
> > 	static inline int __sched __down_common(...)
> > 	{
> > 		int ret;
> > 		trace_contention_begin(sem, 0);
> > 		ret = ___down_common(...);
> > 		trace_contention_end(sem, ret);
> > 		return ret;
> > 	}
> > 
> > Thoughts?
> >
> 
> But IMO inlining tracepoints is generally not a good idea.
> Will increase kernel size a lot.
>

Ah, it's already inlined. Sorry.

> > Regards,
> > Boqun
> > 
> > > +			tracing = true;
> > > +		}
> > >  		raw_spin_unlock_irq(&sem->lock);
> > >  		timeout = schedule_timeout(timeout);
> > >  		raw_spin_lock_irq(&sem->lock);
> > > -		if (waiter.up)
> > > +		if (waiter.up) {
> > > +			trace_contention_end(sem, 0);
> > >  			return 0;
> > > +		}
> > >  	}
> > >  
> > >   timed_out:
> > > +	if (tracing)
> > > +		trace_contention_end(sem, -ETIME);
> > >  	list_del(&waiter.list);
> > >  	return -ETIME;
> > >  
> > >   interrupted:
> > > +	if (tracing)
> > > +		trace_contention_end(sem, -EINTR);
> > >  	list_del(&waiter.list);
> > >  	return -EINTR;
> > >  }
> > > -- 
> > > 2.35.1.894.gb6a874cedc-goog
> > > 
