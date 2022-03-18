Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3D94DDA66
	for <lists+linux-arch@lfdr.de>; Fri, 18 Mar 2022 14:24:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231802AbiCRNZv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Mar 2022 09:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbiCRNZu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Mar 2022 09:25:50 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 138D8E8875;
        Fri, 18 Mar 2022 06:24:32 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id w4so6922982ply.13;
        Fri, 18 Mar 2022 06:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=COTC0Zk9f9Pt+UMfVoj85/Sop+t7KdoHHeUTvF+YTag=;
        b=mHapdPCHciu3q7LenQ4fh8UJL+Q4rqq3cN4EMxTtbCw9gyzMqGA0rSYuPlODSitxEm
         0cMblSPQTVCMqFOAIvqa3D03Rvyhg145fXhr9BqEP9JpH7BCm+ZwOq9/zBfXJEnZmJsT
         k6saq2JTAwMq537c3dNebEzegbfvB0EWRQ1ZWltRgyuB2qx/7wyiPJr6R8Z4l7jcmaNZ
         g7RJ7qdAjWG5NXwacpiYyur5Y4aq8nV4tPB3MUqOhSd/8gZmY6Ym/bYO3WQ8p7BbIukI
         1W0w0Zz5JXK+TGMMpHTpRKaQBk6xOYklxB96XAHu6wMqHycrmXe1ePgvvwEHDTfnp5Vy
         InwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=COTC0Zk9f9Pt+UMfVoj85/Sop+t7KdoHHeUTvF+YTag=;
        b=SU9Z03PMYEA09Sb6VnYzMZaPlNNk3i6ZqiYwAwXrWmVaFi2C/rcGstXo+xO3vVlEXk
         Golp8dARmGi8GKHE/87Qx2mxbKhXWe2HpJDGWFZBSXelCLSnb3xrkG07vz2nejwmnSrZ
         aYSEt9u3uuvM7pe467Ku802ZOXHZ9bSUQ4pmhUGWIVpKMo2V0KAoeBt/Y6dkPxj/GO1U
         yJkWYmYRGmwlG2dpeiuPQZsqIsCx0l/5ij59ghKaFw32+GbfhPk7KCvx+AU8SyYgu9Fp
         n4qi03ya6JQbzYAeL4O1WjvdUdtrO3oh5wCdBfhAKFZrvDZ6bIXvgL/tLKS3Pv60MHXk
         bkRw==
X-Gm-Message-State: AOAM533hMJ2S6x63+AC2BrBGdb0pBTj74Ke3uT4kD28wFK846fc1ohep
        GeFXcgL5U5sg8y1iTnk9FXY=
X-Google-Smtp-Source: ABdhPJy0fmo0l1fknGc8VC4xdrbqin2dGehRcHR3oaavSDsqGlkILea5ly/L4PH8mE1vzLnw4quyQw==
X-Received: by 2002:a17:90b:352:b0:1c6:77e:a4f7 with SMTP id fh18-20020a17090b035200b001c6077ea4f7mr21584354pjb.77.1647609871527;
        Fri, 18 Mar 2022 06:24:31 -0700 (PDT)
Received: from odroid ([114.29.23.97])
        by smtp.gmail.com with ESMTPSA id p128-20020a622986000000b004e1366dd88esm9455586pfp.160.2022.03.18.06.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 06:24:31 -0700 (PDT)
Date:   Fri, 18 Mar 2022 13:24:24 +0000
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
Message-ID: <20220318132424.GA1665646@odroid>
References: <20220316224548.500123-1-namhyung@kernel.org>
 <20220316224548.500123-3-namhyung@kernel.org>
 <YjSBRNxzaE9c+F/1@boqun-archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YjSBRNxzaE9c+F/1@boqun-archlinux>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Mar 18, 2022 at 08:55:32PM +0800, Boqun Feng wrote:
> On Wed, Mar 16, 2022 at 03:45:48PM -0700, Namhyung Kim wrote:
> [...]
> > @@ -209,6 +210,7 @@ static inline int __sched __down_common(struct semaphore *sem, long state,
> >  								long timeout)
> >  {
> >  	struct semaphore_waiter waiter;
> > +	bool tracing = false;
> >  
> >  	list_add_tail(&waiter.list, &sem->wait_list);
> >  	waiter.task = current;
> > @@ -220,18 +222,28 @@ static inline int __sched __down_common(struct semaphore *sem, long state,
> >  		if (unlikely(timeout <= 0))
> >  			goto timed_out;
> >  		__set_current_state(state);
> > +		if (!tracing) {
> > +			trace_contention_begin(sem, 0);
> 
> This looks a littl ugly ;-/

I agree this can be simplified a bit.

> Maybe we can rename __down_common() to
> ___down_common() and implement __down_common() as:
> 
> 	static inline int __sched __down_common(...)
> 	{
> 		int ret;
> 		trace_contention_begin(sem, 0);
> 		ret = ___down_common(...);
> 		trace_contention_end(sem, ret);
> 		return ret;
> 	}
> 
> Thoughts?
>

But IMO inlining tracepoints is generally not a good idea.
Will increase kernel size a lot.

> Regards,
> Boqun
> 
> > +			tracing = true;
> > +		}
> >  		raw_spin_unlock_irq(&sem->lock);
> >  		timeout = schedule_timeout(timeout);
> >  		raw_spin_lock_irq(&sem->lock);
> > -		if (waiter.up)
> > +		if (waiter.up) {
> > +			trace_contention_end(sem, 0);
> >  			return 0;
> > +		}
> >  	}
> >  
> >   timed_out:
> > +	if (tracing)
> > +		trace_contention_end(sem, -ETIME);
> >  	list_del(&waiter.list);
> >  	return -ETIME;
> >  
> >   interrupted:
> > +	if (tracing)
> > +		trace_contention_end(sem, -EINTR);
> >  	list_del(&waiter.list);
> >  	return -EINTR;
> >  }
> > -- 
> > 2.35.1.894.gb6a874cedc-goog
> > 
