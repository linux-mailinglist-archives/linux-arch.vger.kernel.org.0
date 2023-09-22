Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 491897AAE2D
	for <lists+linux-arch@lfdr.de>; Fri, 22 Sep 2023 11:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbjIVJfR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 22 Sep 2023 05:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbjIVJfQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 22 Sep 2023 05:35:16 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D3A197;
        Fri, 22 Sep 2023 02:35:08 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-405361bb949so15551055e9.1;
        Fri, 22 Sep 2023 02:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695375307; x=1695980107; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PTRcAdPYlN/VHO8FKzfnqIxG4I6YBXrgONS3QPJcMq8=;
        b=TaQ8NEtpEuVv69ZwP6BlQZNrOZH9hWvlKKzV4EFMAGVoL3gqQ2JyPbWZJPBiT1sCy6
         pYM6hR81JV4oW2EKCjmd8LhQKn0Y/D9AgpGR/tPhxOsurLhaGzKh7KVKiSAnHd05l530
         VmMUeoZdqpgnuEZOU9Uu/PrGzEHTE9iN5g5uYor38eD9zE5ZIxAgdoajB6NDXf9sbS7m
         /MvIc97eenrrsddYKqVCrvfSuEnRaXyc4nfKXctkSt4LOeGlfWGJveT44ZfB9f9Pv+7Y
         bOu33d9n/b+ECxUQ1N+ZNJN2+NDT3ix6vgVhFo4TCXGCk2gGdvBJoy1HsZtgOPTy2Jwc
         NoYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695375307; x=1695980107;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PTRcAdPYlN/VHO8FKzfnqIxG4I6YBXrgONS3QPJcMq8=;
        b=lF3FDHphhrh+q+GV1Bcu5frA1dstOZ5zKF3Cu/07LAdLcztUXr2GfEpl1/DsBkTV1J
         u4ktUBLWLY7HA0VQbHhKX7hwtmErveF8R5+Kl7HDthvkDjwACAdB6tzlvrwds5PcyPMs
         Fj7+jbD11U9yZxc8yyf+CntqXF6xunFeJ0GVZPaXBr//9N9IF92PwirASKWm3v5a/2n1
         u5ftfpCc7DmueVpsmbwPWCTV+7piUvuF1VXA0r2KxqmhjUl5+52g/kXgNSs0Ebo4kB+a
         NgnoCrncGiSeJWfV35k+rLySqvaeBx6rID0s6Q2fKbeN1S3LVaF8ZZfPhtBY3nD9pdB4
         UPpg==
X-Gm-Message-State: AOJu0Yw1KUGogS57novVervPxvDMpW7MRV87dee7Qu1nc33EBuC2S5P4
        GYdLKLH4F+cqnYsoMpXU+8A=
X-Google-Smtp-Source: AGHT+IHgk2oAySrEJX2mQ/nnZhq8OwQDyWgRq6/WsNVQQ6OGQjV4H9P7ur5I0ax4wch7C5zJrWdveA==
X-Received: by 2002:adf:fc0d:0:b0:314:152d:f8db with SMTP id i13-20020adffc0d000000b00314152df8dbmr6957471wrr.58.1695375306573;
        Fri, 22 Sep 2023 02:35:06 -0700 (PDT)
Received: from gmail.com (1F2EF49C.nat.pool.telekom.hu. [31.46.244.156])
        by smtp.gmail.com with ESMTPSA id v9-20020a5d4b09000000b0032008f99216sm4038542wrq.96.2023.09.22.02.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 02:35:05 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Fri, 22 Sep 2023 11:35:03 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     peterz@infradead.org
Cc:     tglx@linutronix.de, axboe@kernel.dk, linux-kernel@vger.kernel.org,
        mingo@redhat.com, dvhart@infradead.org, dave@stgolabs.net,
        andrealmeid@igalia.com, Andrew Morton <akpm@linux-foundation.org>,
        urezki@gmail.com, hch@infradead.org, lstoakes@gmail.com,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        malteskarupke@web.de, Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v3 10/15] futex: Add sys_futex_requeue()
Message-ID: <ZQ1fx29+b8PmLVk6@gmail.com>
References: <20230921104505.717750284@noisy.programming.kicks-ass.net>
 <20230921105248.511860556@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230921105248.511860556@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


* peterz@infradead.org <peterz@infradead.org> wrote:

> --- linux-2.6.orig/kernel/futex/syscalls.c
> +++ linux-2.6/kernel/futex/syscalls.c
> @@ -396,6 +396,44 @@ SYSCALL_DEFINE6(futex_wait,
>  	return ret;
>  }
>  
> +/*
> + * sys_futex_requeue - Requeue a waiter from one futex to another
> + * @waiters:	array describing the source and destination futex
> + * @flags:	unused
> + * @nr_wake:	number of futexes to wake
> + * @nr_requeue:	number of futexes to requeue
> + *
> + * Identical to the traditional FUTEX_CMP_REQUEUE op, except it is part of the
> + * futex2 family of calls.
> + */
> +
> +SYSCALL_DEFINE4(futex_requeue,
> +		struct futex_waitv __user *, waiters,
> +		unsigned int, flags,
> +		int, nr_wake,
> +		int, nr_requeue)
> +{
> +	struct futex_vector futexes[2];
> +	u32 cmpval;
> +	int ret;
> +
> +	if (flags)
> +		return -EINVAL;

Small detail, but isn't -ENOSYS the canonical error code for functionality 
not yet implemented - which the unused 'flags' ABI is arguably?

-EINVAL is for recognized but incorrect parameters, such as:

> +	if (!waiters)
> +		return -EINVAL;

Thanks,

	Ingo
