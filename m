Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD8323B851
	for <lists+linux-arch@lfdr.de>; Tue,  4 Aug 2020 12:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbgHDKAm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Aug 2020 06:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726844AbgHDKAl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Aug 2020 06:00:41 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A45C06174A
        for <linux-arch@vger.kernel.org>; Tue,  4 Aug 2020 03:00:41 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id s26so19906343pfm.4
        for <linux-arch@vger.kernel.org>; Tue, 04 Aug 2020 03:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=F2ib0p50ylMcavfh6ZgnIlF4RFlh7CrG6aCp8ClNqUg=;
        b=KFZC9TN+x6FhyQjHVQsUSgwL8N6pKEWivHHLSU2aFBFMuKr5UAxYYJ9/MhU4O0t8Id
         I/LtvCJIgdklgO4ojnoRG3tF1BpU2yvOHRcmumVWhh+OiYucjw/kmDuK9AbF0vnAM8bp
         fNksKV0F5jtt2sItCj9SELODIY2pfTgyLFoO/NaMcmQG/BKQjTHfTiX4/wzvNA0Jrtjp
         MTzGYyCunJI8sgGEjujPqNdMykyuFoy9s2H0ILT9kzTg8RArkLxhXtyVLZ+5LoksZVfR
         iHVVDJXGXwH4NCwJ3WkimJVIxgDJZX/3jGZva+bN+Xa/hl/2yWMkXNWoV057oCsvAOL4
         MFCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=F2ib0p50ylMcavfh6ZgnIlF4RFlh7CrG6aCp8ClNqUg=;
        b=A87eSqq4CF2wUkeBLBbq1qK3vkdHp6cUlmwAVdIpOcqzJb2CoN3efkUMU/am1ASI5H
         vnqniAJthXZZ4BlXneTKXAoTGLKUyUZALe8X24bF/aKTh8XuNVp9XUtzE7S3kdl5zHL6
         iHHB0k78GhneD5RdwLyC5OAFPb3yBxOefL5jJTBDetBjSrKHSZh/mjwyL+ryPBp+xByX
         ararVh/o5VnpvShN+309W/Nhe1fJkKzvSOALSdhJp+iEUtNE9c6mmbjqUfCVo2dnV/x+
         ZDYlOe493te7x6ZPwiwRUPajwngYtf+0B81x4mA7hAdWMnzJsUIUagjs9qAyeg93kJ+T
         q8PA==
X-Gm-Message-State: AOAM532wIJg3ytpdFNhGv+DEXYm9OnzlNRbjZCqGBO8Yan6R+2QJbm35
        q4hx8ptSFajEIsN5+oA9TiCRVQ==
X-Google-Smtp-Source: ABdhPJzqNmoUT5ZadIkmy5LFu4Mg08b1UUTtNjf4NsXvptv0OOXv5NDV4hCRrUmiB4/YZlAMQrlIgg==
X-Received: by 2002:a63:920b:: with SMTP id o11mr19336029pgd.447.1596535240985;
        Tue, 04 Aug 2020 03:00:40 -0700 (PDT)
Received: from [192.168.10.94] (124-171-83-152.dyn.iinet.net.au. [124.171.83.152])
        by smtp.gmail.com with ESMTPSA id hi13sm1957375pjb.26.2020.08.04.03.00.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2020 03:00:40 -0700 (PDT)
Subject: Re: [PATCH 2/2] lockdep: warn on redundant or incorrect irq state
 changes
To:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
References: <20200723105615.1268126-1-npiggin@gmail.com>
 <20200723105615.1268126-2-npiggin@gmail.com>
From:   Alexey Kardashevskiy <aik@ozlabs.ru>
Autocrypt: addr=aik@ozlabs.ru; keydata=
 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
Message-ID: <c5b62871-aaf4-0663-bcb7-bc52289753b4@ozlabs.ru>
Date:   Tue, 4 Aug 2020 20:00:35 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200723105615.1268126-2-npiggin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 23/07/2020 20:56, Nicholas Piggin wrote:
> With the previous patch, lockdep hardirq state changes should not be
> redundant. Softirq state changes already follow that pattern.
> 
> So warn on unexpected enable-when-enabled or disable-when-disabled
> conditions, to catch possible errors or sloppy patterns that could
> lead to similar bad behavior due to NMIs etc.


This one does not apply anymore as Peter's changes went in already but
this one is not really a fix so I can live with that. Did 1/2 go
anywhere? Thanks,


> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  kernel/locking/lockdep.c           | 80 +++++++++++++-----------------
>  kernel/locking/lockdep_internals.h |  4 --
>  kernel/locking/lockdep_proc.c      | 10 +---
>  3 files changed, 35 insertions(+), 59 deletions(-)
> 
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index 29a8de4c50b9..138458fb2234 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -3649,15 +3649,8 @@ void lockdep_hardirqs_on_prepare(unsigned long ip)
>  	if (unlikely(!debug_locks || current->lockdep_recursion))
>  		return;
>  
> -	if (unlikely(current->hardirqs_enabled)) {
> -		/*
> -		 * Neither irq nor preemption are disabled here
> -		 * so this is racy by nature but losing one hit
> -		 * in a stat is not a big deal.
> -		 */
> -		__debug_atomic_inc(redundant_hardirqs_on);
> +	if (DEBUG_LOCKS_WARN_ON(current->hardirqs_enabled))
>  		return;
> -	}
>  
>  	/*
>  	 * We're enabling irqs and according to our state above irqs weren't
> @@ -3695,15 +3688,8 @@ void noinstr lockdep_hardirqs_on(unsigned long ip)
>  	if (unlikely(!debug_locks || curr->lockdep_recursion))
>  		return;
>  
> -	if (curr->hardirqs_enabled) {
> -		/*
> -		 * Neither irq nor preemption are disabled here
> -		 * so this is racy by nature but losing one hit
> -		 * in a stat is not a big deal.
> -		 */
> -		__debug_atomic_inc(redundant_hardirqs_on);
> +	if (DEBUG_LOCKS_WARN_ON(curr->hardirqs_enabled))
>  		return;
> -	}
>  
>  	/*
>  	 * We're enabling irqs and according to our state above irqs weren't
> @@ -3738,6 +3724,9 @@ void noinstr lockdep_hardirqs_off(unsigned long ip)
>  	if (unlikely(!debug_locks || curr->lockdep_recursion))
>  		return;
>  
> +	if (DEBUG_LOCKS_WARN_ON(!curr->hardirqs_enabled))
> +		return;
> +
>  	/*
>  	 * So we're supposed to get called after you mask local IRQs, but for
>  	 * some reason the hardware doesn't quite think you did a proper job.
> @@ -3745,17 +3734,13 @@ void noinstr lockdep_hardirqs_off(unsigned long ip)
>  	if (DEBUG_LOCKS_WARN_ON(!irqs_disabled()))
>  		return;
>  
> -	if (curr->hardirqs_enabled) {
> -		/*
> -		 * We have done an ON -> OFF transition:
> -		 */
> -		curr->hardirqs_enabled = 0;
> -		curr->hardirq_disable_ip = ip;
> -		curr->hardirq_disable_event = ++curr->irq_events;
> -		debug_atomic_inc(hardirqs_off_events);
> -	} else {
> -		debug_atomic_inc(redundant_hardirqs_off);
> -	}
> +	/*
> +	 * We have done an ON -> OFF transition:
> +	 */
> +	curr->hardirqs_enabled = 0;
> +	curr->hardirq_disable_ip = ip;
> +	curr->hardirq_disable_event = ++curr->irq_events;
> +	debug_atomic_inc(hardirqs_off_events);
>  }
>  EXPORT_SYMBOL_GPL(lockdep_hardirqs_off);
>  
> @@ -3769,6 +3754,9 @@ void lockdep_softirqs_on(unsigned long ip)
>  	if (unlikely(!debug_locks || current->lockdep_recursion))
>  		return;
>  
> +	if (DEBUG_LOCKS_WARN_ON(curr->softirqs_enabled))
> +		return;
> +
>  	/*
>  	 * We fancy IRQs being disabled here, see softirq.c, avoids
>  	 * funny state and nesting things.
> @@ -3776,11 +3764,6 @@ void lockdep_softirqs_on(unsigned long ip)
>  	if (DEBUG_LOCKS_WARN_ON(!irqs_disabled()))
>  		return;
>  
> -	if (curr->softirqs_enabled) {
> -		debug_atomic_inc(redundant_softirqs_on);
> -		return;
> -	}
> -
>  	current->lockdep_recursion++;
>  	/*
>  	 * We'll do an OFF -> ON transition:
> @@ -3809,26 +3792,26 @@ void lockdep_softirqs_off(unsigned long ip)
>  	if (unlikely(!debug_locks || current->lockdep_recursion))
>  		return;
>  
> +	if (DEBUG_LOCKS_WARN_ON(!curr->softirqs_enabled))
> +		return;
> +
>  	/*
>  	 * We fancy IRQs being disabled here, see softirq.c
>  	 */
>  	if (DEBUG_LOCKS_WARN_ON(!irqs_disabled()))
>  		return;
>  
> -	if (curr->softirqs_enabled) {
> -		/*
> -		 * We have done an ON -> OFF transition:
> -		 */
> -		curr->softirqs_enabled = 0;
> -		curr->softirq_disable_ip = ip;
> -		curr->softirq_disable_event = ++curr->irq_events;
> -		debug_atomic_inc(softirqs_off_events);
> -		/*
> -		 * Whoops, we wanted softirqs off, so why aren't they?
> -		 */
> -		DEBUG_LOCKS_WARN_ON(!softirq_count());
> -	} else
> -		debug_atomic_inc(redundant_softirqs_off);
> +	/*
> +	 * We have done an ON -> OFF transition:
> +	 */
> +	curr->softirqs_enabled = 0;
> +	curr->softirq_disable_ip = ip;
> +	curr->softirq_disable_event = ++curr->irq_events;
> +	debug_atomic_inc(softirqs_off_events);
> +	/*
> +	 * Whoops, we wanted softirqs off, so why aren't they?
> +	 */
> +	DEBUG_LOCKS_WARN_ON(!softirq_count());
>  }
>  
>  static int
> @@ -5684,6 +5667,11 @@ void __init lockdep_init(void)
>  
>  	printk(" per task-struct memory footprint: %zu bytes\n",
>  	       sizeof(((struct task_struct *)NULL)->held_locks));
> +
> +	WARN_ON(irqs_disabled());
> +
> +	current->hardirqs_enabled = 1;
> +	current->softirqs_enabled = 1;
>  }
>  
>  static void
> diff --git a/kernel/locking/lockdep_internals.h b/kernel/locking/lockdep_internals.h
> index baca699b94e9..6dd8b1f06dc4 100644
> --- a/kernel/locking/lockdep_internals.h
> +++ b/kernel/locking/lockdep_internals.h
> @@ -180,12 +180,8 @@ struct lockdep_stats {
>  	unsigned int   chain_lookup_misses;
>  	unsigned long  hardirqs_on_events;
>  	unsigned long  hardirqs_off_events;
> -	unsigned long  redundant_hardirqs_on;
> -	unsigned long  redundant_hardirqs_off;
>  	unsigned long  softirqs_on_events;
>  	unsigned long  softirqs_off_events;
> -	unsigned long  redundant_softirqs_on;
> -	unsigned long  redundant_softirqs_off;
>  	int            nr_unused_locks;
>  	unsigned int   nr_redundant_checks;
>  	unsigned int   nr_redundant;
> diff --git a/kernel/locking/lockdep_proc.c b/kernel/locking/lockdep_proc.c
> index 5525cd3ba0c8..98f204220ed9 100644
> --- a/kernel/locking/lockdep_proc.c
> +++ b/kernel/locking/lockdep_proc.c
> @@ -172,12 +172,8 @@ static void lockdep_stats_debug_show(struct seq_file *m)
>  #ifdef CONFIG_DEBUG_LOCKDEP
>  	unsigned long long hi1 = debug_atomic_read(hardirqs_on_events),
>  			   hi2 = debug_atomic_read(hardirqs_off_events),
> -			   hr1 = debug_atomic_read(redundant_hardirqs_on),
> -			   hr2 = debug_atomic_read(redundant_hardirqs_off),
>  			   si1 = debug_atomic_read(softirqs_on_events),
> -			   si2 = debug_atomic_read(softirqs_off_events),
> -			   sr1 = debug_atomic_read(redundant_softirqs_on),
> -			   sr2 = debug_atomic_read(redundant_softirqs_off);
> +			   si2 = debug_atomic_read(softirqs_off_events);
>  
>  	seq_printf(m, " chain lookup misses:           %11llu\n",
>  		debug_atomic_read(chain_lookup_misses));
> @@ -196,12 +192,8 @@ static void lockdep_stats_debug_show(struct seq_file *m)
>  
>  	seq_printf(m, " hardirq on events:             %11llu\n", hi1);
>  	seq_printf(m, " hardirq off events:            %11llu\n", hi2);
> -	seq_printf(m, " redundant hardirq ons:         %11llu\n", hr1);
> -	seq_printf(m, " redundant hardirq offs:        %11llu\n", hr2);
>  	seq_printf(m, " softirq on events:             %11llu\n", si1);
>  	seq_printf(m, " softirq off events:            %11llu\n", si2);
> -	seq_printf(m, " redundant softirq ons:         %11llu\n", sr1);
> -	seq_printf(m, " redundant softirq offs:        %11llu\n", sr2);
>  #endif
>  }
>  
> 

-- 
Alexey
