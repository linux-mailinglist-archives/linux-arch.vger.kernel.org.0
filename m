Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 653CE4DDA00
	for <lists+linux-arch@lfdr.de>; Fri, 18 Mar 2022 13:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235015AbiCRM5Z (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Mar 2022 08:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234818AbiCRM5Y (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Mar 2022 08:57:24 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D52DC23457A;
        Fri, 18 Mar 2022 05:56:05 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d15so5626232qty.8;
        Fri, 18 Mar 2022 05:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=o+4kjV5M7AAhRV6+HUHDlhX1FtegGYf686kx5iPLbhM=;
        b=axBLgwuquigWzrQ1tKUH1ihyDMq/qqvK0jUvPmXNAC7iR/iUu2O0ZM8nxF7wc0eePP
         HJj/1kSdWGiVc987xgqdV+5kDO3K5hA1bKKmWk8FEYPcjFQwvxU5/ZVYiis5m1RPt3i8
         ty10FRALip3F8QFywhetmrVk99HiyqbHe/D0Ta1maP1fqi41EZc9+olTylIaujbyxO4a
         mDQ8NGNISmBK2IKuXUyNmBBF8Ib7Hv8ex27+xsTv9meKzBPUGG2uLkI/k79ang9CmlUe
         OkwWVtA6upsTm3XOm33SlBAqwm4jgjIk+r2XcB6MjNvIzMrlpkfqA0n1JeU5rfAwN8ZM
         wOsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=o+4kjV5M7AAhRV6+HUHDlhX1FtegGYf686kx5iPLbhM=;
        b=ZsmXKCMShVxKMpRdXvouDEw1PJA4U4xJlrWFbgliOx2oKLWJM258hQWojP82C6nrXB
         P0RjDNf3oqmZ1DYptezNS7a3bdF6Reov1++hEfu+OHZuwNjjV63SoBEW3VxDeFeeuU/r
         s+qpAc1MmWFmsI7e1SQfgqj6zAPRz921u2W1YtH8NzZNNaHuCtY6E/k8czA+fdIYSvm1
         rZ79r6IdrK5jW83VMfGMwx3J5Ok9GdkL85BhJ1NdzUH/cWRSlIsoEBuiMhR/VqYHCFAg
         qMX2x0S35W7nivujHsehXygqgwN8dRQgEUS8fm8de6fjceJcqoFQ8IhApLYwB4wZDRcp
         ELpg==
X-Gm-Message-State: AOAM530klvlsdY7dSs/OH6Oe639tCqUhUGgjzO5YzxhHYpqla71gxDZy
        YdQrGrIQah56DfolxAyTj8Q=
X-Google-Smtp-Source: ABdhPJzQfTpBIudr3YDujX+wxBBXMN1W3gFT+2UU7kFEAwvObkd7vERyCRDjWFQizUEu2sOGQYxgvQ==
X-Received: by 2002:a05:622a:8e:b0:2e1:fee4:8ca2 with SMTP id o14-20020a05622a008e00b002e1fee48ca2mr3888357qtw.431.1647608164801;
        Fri, 18 Mar 2022 05:56:04 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id r14-20020ac85c8e000000b002e1d62ba775sm5690654qta.21.2022.03.18.05.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 05:56:03 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailauth.nyi.internal (Postfix) with ESMTP id C8FCF27C0054;
        Fri, 18 Mar 2022 08:56:02 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 18 Mar 2022 08:56:02 -0400
X-ME-Sender: <xms:YIE0YjJve060_gNtvlACuxZdgw8GAcIFU-XLwr8pG24ZVDukXIN_bw>
    <xme:YIE0YnJgg3ZwDTs1dKRTCiyVxxA8IF33iJyLPQlxMMQLajAzEUjYekdXg15PtST99
    g-FUEf_1wylh1C_Qg>
X-ME-Received: <xmr:YIE0YrvUDjs-uRFxBOsfVhPCtUKNiB6eYpmw4mLubBhhANBUDM-lrkU4K-U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudefiedggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepvdelieegudfggeevjefhjeevueevieetjeeikedvgfejfeduheefhffggedv
    geejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    hoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieeg
    qddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigi
    hmvgdrnhgrmhgv
X-ME-Proxy: <xmx:YIE0YsYBuAPDft-ELbq0Jl5iKH9NCF6XLzMSGgwd72TI7-nSPv9o1Q>
    <xmx:YIE0YqZpvHlvwwOy2Cnb7xoLikD8VF1lDXMNbPWxvKoAKzCBT1GUXg>
    <xmx:YIE0YgC8EvZ47TqrTAmX2ZWJ4vn36L1GTtBtYiJDNGlxNlS-ZTdiaQ>
    <xmx:YoE0Ygx40GUudZGYICpS4_Jd5IymmQs0w5bgDB7DqVVERR1CctFXzYYyTuo>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Mar 2022 08:56:00 -0400 (EDT)
Date:   Fri, 18 Mar 2022 20:55:32 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <YjSBRNxzaE9c+F/1@boqun-archlinux>
References: <20220316224548.500123-1-namhyung@kernel.org>
 <20220316224548.500123-3-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220316224548.500123-3-namhyung@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 16, 2022 at 03:45:48PM -0700, Namhyung Kim wrote:
[...]
> @@ -209,6 +210,7 @@ static inline int __sched __down_common(struct semaphore *sem, long state,
>  								long timeout)
>  {
>  	struct semaphore_waiter waiter;
> +	bool tracing = false;
>  
>  	list_add_tail(&waiter.list, &sem->wait_list);
>  	waiter.task = current;
> @@ -220,18 +222,28 @@ static inline int __sched __down_common(struct semaphore *sem, long state,
>  		if (unlikely(timeout <= 0))
>  			goto timed_out;
>  		__set_current_state(state);
> +		if (!tracing) {
> +			trace_contention_begin(sem, 0);

This looks a littl ugly ;-/ Maybe we can rename __down_common() to
___down_common() and implement __down_common() as:

	static inline int __sched __down_common(...)
	{
		int ret;
		trace_contention_begin(sem, 0);
		ret = ___down_common(...);
		trace_contention_end(sem, ret);
		return ret;
	}

Thoughts?

Regards,
Boqun

> +			tracing = true;
> +		}
>  		raw_spin_unlock_irq(&sem->lock);
>  		timeout = schedule_timeout(timeout);
>  		raw_spin_lock_irq(&sem->lock);
> -		if (waiter.up)
> +		if (waiter.up) {
> +			trace_contention_end(sem, 0);
>  			return 0;
> +		}
>  	}
>  
>   timed_out:
> +	if (tracing)
> +		trace_contention_end(sem, -ETIME);
>  	list_del(&waiter.list);
>  	return -ETIME;
>  
>   interrupted:
> +	if (tracing)
> +		trace_contention_end(sem, -EINTR);
>  	list_del(&waiter.list);
>  	return -EINTR;
>  }
> -- 
> 2.35.1.894.gb6a874cedc-goog
> 
