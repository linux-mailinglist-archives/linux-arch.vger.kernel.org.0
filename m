Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2FB15B4B1
	for <lists+linux-arch@lfdr.de>; Thu, 13 Feb 2020 00:28:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729342AbgBLX2o (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 Feb 2020 18:28:44 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:41901 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729194AbgBLX2o (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Feb 2020 18:28:44 -0500
Received: by mail-qk1-f193.google.com with SMTP id d11so3881537qko.8
        for <linux-arch@vger.kernel.org>; Wed, 12 Feb 2020 15:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fYuqkm3Om1sqZwRi3Fq5WUa7PQ8WgfNshBVo9cj4H40=;
        b=sxuyQmGOizY2EQbmpzNJJACGJLi5ux1yhvSrNAVDmPYY9CSCCK7T0Zpu39Y7UQpKyj
         P4rI6Trf3FmihIsEQRk0ObZbCBkbKxRS7X5mMaAIQcm7rdhzTr+lQ4feSfy/We15KIB9
         A/tVydjW/MtCP+mTi6RT8ye8Z61SmUuibMqXc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fYuqkm3Om1sqZwRi3Fq5WUa7PQ8WgfNshBVo9cj4H40=;
        b=jKdWCVortmsAJ8VO4hmoJ0rUNfYcMHS5YaW+N/oziRKmnElVoW9P6oeN943BeAUy0W
         CErPFEfxiR8PuTFaZYhJpNktOIU5QK5QZdH11VOg4zY9cKxmsxgiEgjcCPDacn/xkgom
         XzOb2RCn9KNxfGNRj9ScluaMWFNBs/froZY/jRNGZA66pWrbDhTSgVXTGdxabBAaSNKu
         8JDo+cONbIM/JTBhThdhK1VM9pZY4oC/p6Dd5fseZjJJ3Z85f3DdyyEyhPTNKr1p0YUG
         mLb88ekEEAUZ10Enpp7CWl8d8uB8unZ74n0NCwJ//Ffe3h4nBbemJoJrXa3jF1plmMb2
         kTIw==
X-Gm-Message-State: APjAAAX5ttS68dPL/diGNsD59xQzsyat0mgLzoRGWIsXx9bDm1w5K0nZ
        05LpuBv6mciZs7kW4Ln3URNTvA==
X-Google-Smtp-Source: APXvYqxHHxiD+zW4lcdfx2K3IYuaYzDj7OaOEwM4KOg9c7GQz/OUqUp4o9KRtnh/azJZ07LcffaqUA==
X-Received: by 2002:a05:620a:12a5:: with SMTP id x5mr9755316qki.478.1581550123076;
        Wed, 12 Feb 2020 15:28:43 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id t7sm240428qkm.136.2020.02.12.15.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 15:28:30 -0800 (PST)
Date:   Wed, 12 Feb 2020 18:28:30 -0500
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
Message-ID: <20200212232830.GB170680@google.com>
References: <20200212210139.382424693@infradead.org>
 <20200212210750.142334759@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212210750.142334759@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 12, 2020 at 10:01:45PM +0100, Peter Zijlstra wrote:
> The tracepoint interface will stop providing regular RCU context; make
> sure we do it ourselves, since perf makes use of regular RCU protected
> data.
> 
> Suggested-by: Steven Rostedt (VMware) <rosted@goodmis.org>
> Suggested-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/events/core.c |    5 +++++
>  1 file changed, 5 insertions(+)
> 
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -8950,6 +8950,7 @@ void perf_tp_event(u16 event_type, u64 c
>  {
>  	struct perf_sample_data data;
>  	struct perf_event *event;
> +	unsigned long rcu_flags;

The flags are not needed I guess, if you agree on not using in_nmi() in
trace_rcu_enter().

thanks,

 - Joel


>  	struct perf_raw_record raw = {
>  		.frag = {
> @@ -8961,6 +8962,8 @@ void perf_tp_event(u16 event_type, u64 c
>  	perf_sample_data_init(&data, 0, 0);
>  	data.raw = &raw;
>  
> +	rcu_flags = trace_rcu_enter();
> +
>  	perf_trace_buf_update(record, event_type);
>  
>  	hlist_for_each_entry_rcu(event, head, hlist_entry) {
> @@ -8996,6 +8999,8 @@ void perf_tp_event(u16 event_type, u64 c
>  	}
>  
>  	perf_swevent_put_recursion_context(rctx);
> +
> +	trace_rcu_exit(rcu_flags);
>  }
>  EXPORT_SYMBOL_GPL(perf_tp_event);
>  
> 
> 
