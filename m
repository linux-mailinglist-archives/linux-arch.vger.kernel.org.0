Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45EBC65C0D6
	for <lists+linux-arch@lfdr.de>; Tue,  3 Jan 2023 14:31:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbjACNbD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 3 Jan 2023 08:31:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237551AbjACNbA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 3 Jan 2023 08:31:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C73A211171;
        Tue,  3 Jan 2023 05:30:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5876A61290;
        Tue,  3 Jan 2023 13:30:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4F7BC433EF;
        Tue,  3 Jan 2023 13:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672752657;
        bh=hUoNU0K1jiu0AMzzYChvK5UBNb0NQ1eLI3M81OvWO/4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eV7VpVOjSClYpf8kOi4dmjkSwDan0oZidPtMjIwlY7kVcD7ilt+mpUsrvd5EqEdMT
         cn2teqOXRLwiFmQtlDR07c+FuWc7Ke4j4rvh/vEfu8etSU0GE2NW5Y9P8TYLEz67qw
         JstWf7b9TBJwFb1G1q3vi0CVYqNrtDZqaoYa1lG44CY2EWieDtgi+tOfLTi8H6NHyp
         MhKJ6UpE3LXVhsOrY7LudmKrcFrbYxTWRKKjT0BcAY7E0LZuzCYIOqctaKn6kpvXT9
         2huL0DnUtjEMxxqDtg+QJbpyAi2VPZnAH8wWf79ifm/bF63nFbeewRJGSJFBGeuJPO
         L5fceN2F+vmsw==
Date:   Tue, 3 Jan 2023 22:30:53 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Song Chen <chensong_2000@189.cn>
Cc:     rostedt@goodmis.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v5 1/3] kernel/trace: Introduce trace_probe_print_args
 and use it in *probes
Message-Id: <20230103223053.d82c08125d8bcb83761b65ea@kernel.org>
In-Reply-To: <1672382000-18304-1-git-send-email-chensong_2000@189.cn>
References: <1672382000-18304-1-git-send-email-chensong_2000@189.cn>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 30 Dec 2022 14:33:19 +0800
Song Chen <chensong_2000@189.cn> wrote:

> print_probe_args is currently inplemented in trace_probe_tmpl.h and
> included by *probes, as a result, each probe has an identical copy.
> 
> This patch will move it to trace_probe.c as an new API, each probe
> calls it to print their args in trace file.
> 

This looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks!

> Signed-off-by: Song Chen <chensong_2000@189.cn>
> ---
>  kernel/trace/trace_eprobe.c     |  2 +-
>  kernel/trace/trace_kprobe.c     |  4 ++--
>  kernel/trace/trace_probe.c      | 27 +++++++++++++++++++++++++++
>  kernel/trace/trace_probe.h      |  2 ++
>  kernel/trace/trace_probe_tmpl.h | 28 ----------------------------
>  kernel/trace/trace_uprobe.c     |  2 +-
>  6 files changed, 33 insertions(+), 32 deletions(-)
> 
> diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
> index 5dd0617e5df6..bdb26eee7a0c 100644
> --- a/kernel/trace/trace_eprobe.c
> +++ b/kernel/trace/trace_eprobe.c
> @@ -310,7 +310,7 @@ print_eprobe_event(struct trace_iterator *iter, int flags,
>  
>  	trace_seq_putc(s, ')');
>  
> -	if (print_probe_args(s, tp->args, tp->nr_args,
> +	if (trace_probe_print_args(s, tp->args, tp->nr_args,
>  			     (u8 *)&field[1], field) < 0)
>  		goto out;
>  
> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> index 5a75b039e586..a4ffa864dbb7 100644
> --- a/kernel/trace/trace_kprobe.c
> +++ b/kernel/trace/trace_kprobe.c
> @@ -1426,7 +1426,7 @@ print_kprobe_event(struct trace_iterator *iter, int flags,
>  
>  	trace_seq_putc(s, ')');
>  
> -	if (print_probe_args(s, tp->args, tp->nr_args,
> +	if (trace_probe_print_args(s, tp->args, tp->nr_args,
>  			     (u8 *)&field[1], field) < 0)
>  		goto out;
>  
> @@ -1461,7 +1461,7 @@ print_kretprobe_event(struct trace_iterator *iter, int flags,
>  
>  	trace_seq_putc(s, ')');
>  
> -	if (print_probe_args(s, tp->args, tp->nr_args,
> +	if (trace_probe_print_args(s, tp->args, tp->nr_args,
>  			     (u8 *)&field[1], field) < 0)
>  		goto out;
>  
> diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> index 36dff277de46..ae13b6b2d5da 100644
> --- a/kernel/trace/trace_probe.c
> +++ b/kernel/trace/trace_probe.c
> @@ -1218,3 +1218,30 @@ int trace_probe_create(const char *raw_command, int (*createfn)(int, const char
>  
>  	return ret;
>  }
> +
> +int trace_probe_print_args(struct trace_seq *s, struct probe_arg *args, int nr_args,
> +		 u8 *data, void *field)
> +{
> +	void *p;
> +	int i, j;
> +
> +	for (i = 0; i < nr_args; i++) {
> +		struct probe_arg *a = args + i;
> +
> +		trace_seq_printf(s, " %s=", a->name);
> +		if (likely(!a->count)) {
> +			if (!a->type->print(s, data + a->offset, field))
> +				return -ENOMEM;
> +			continue;
> +		}
> +		trace_seq_putc(s, '{');
> +		p = data + a->offset;
> +		for (j = 0; j < a->count; j++) {
> +			if (!a->type->print(s, p, field))
> +				return -ENOMEM;
> +			trace_seq_putc(s, j == a->count - 1 ? '}' : ',');
> +			p += a->type->size;
> +		}
> +	}
> +	return 0;
> +}
> diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
> index de38f1c03776..cfef198013af 100644
> --- a/kernel/trace/trace_probe.h
> +++ b/kernel/trace/trace_probe.h
> @@ -343,6 +343,8 @@ int trace_probe_compare_arg_type(struct trace_probe *a, struct trace_probe *b);
>  bool trace_probe_match_command_args(struct trace_probe *tp,
>  				    int argc, const char **argv);
>  int trace_probe_create(const char *raw_command, int (*createfn)(int, const char **));
> +int trace_probe_print_args(struct trace_seq *s, struct probe_arg *args, int nr_args,
> +		 u8 *data, void *field);
>  
>  #define trace_probe_for_each_link(pos, tp)	\
>  	list_for_each_entry(pos, &(tp)->event->files, list)
> diff --git a/kernel/trace/trace_probe_tmpl.h b/kernel/trace/trace_probe_tmpl.h
> index b3bdb8ddb862..1b57420857e1 100644
> --- a/kernel/trace/trace_probe_tmpl.h
> +++ b/kernel/trace/trace_probe_tmpl.h
> @@ -212,31 +212,3 @@ store_trace_args(void *data, struct trace_probe *tp, void *rec,
>  		}
>  	}
>  }
> -
> -static inline int
> -print_probe_args(struct trace_seq *s, struct probe_arg *args, int nr_args,
> -		 u8 *data, void *field)
> -{
> -	void *p;
> -	int i, j;
> -
> -	for (i = 0; i < nr_args; i++) {
> -		struct probe_arg *a = args + i;
> -
> -		trace_seq_printf(s, " %s=", a->name);
> -		if (likely(!a->count)) {
> -			if (!a->type->print(s, data + a->offset, field))
> -				return -ENOMEM;
> -			continue;
> -		}
> -		trace_seq_putc(s, '{');
> -		p = data + a->offset;
> -		for (j = 0; j < a->count; j++) {
> -			if (!a->type->print(s, p, field))
> -				return -ENOMEM;
> -			trace_seq_putc(s, j == a->count - 1 ? '}' : ',');
> -			p += a->type->size;
> -		}
> -	}
> -	return 0;
> -}
> diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
> index fb58e86dd117..1ff8f87211a6 100644
> --- a/kernel/trace/trace_uprobe.c
> +++ b/kernel/trace/trace_uprobe.c
> @@ -1041,7 +1041,7 @@ print_uprobe_event(struct trace_iterator *iter, int flags, struct trace_event *e
>  		data = DATAOF_TRACE_ENTRY(entry, false);
>  	}
>  
> -	if (print_probe_args(s, tu->tp.args, tu->tp.nr_args, data, entry) < 0)
> +	if (trace_probe_print_args(s, tu->tp.args, tu->tp.nr_args, data, entry) < 0)
>  		goto out;
>  
>  	trace_seq_putc(s, '\n');
> -- 
> 2.25.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
