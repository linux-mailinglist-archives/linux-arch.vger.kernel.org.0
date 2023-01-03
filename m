Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE3965C0DD
	for <lists+linux-arch@lfdr.de>; Tue,  3 Jan 2023 14:32:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbjACNcM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 3 Jan 2023 08:32:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233362AbjACNcL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 3 Jan 2023 08:32:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F781116E;
        Tue,  3 Jan 2023 05:32:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0CE78B80EB9;
        Tue,  3 Jan 2023 13:32:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14181C433EF;
        Tue,  3 Jan 2023 13:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672752726;
        bh=a+pqWavNwn38zL63kZf70hmufM1E3jaoRa7Gg7LODZ4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NUAlL/ByCwvg5RBPxXgnZJVRBdEk9iWOY/Q3d0kcYa1yj+4qBkRQJzLrv776DAkaq
         sXkye3Ap4r02M7aH6KKXNPHsPDrZIHULCa/d26STzTkN6+pfnLi8eHf7hPLhYae5c1
         pMU83Ub86u4q288P4P2f4yLot4s2nc+KFQgNBM7MS4OzM41pjCRLyHZxNiShnY8sts
         BoRzuRMfegS0Vj2UFYie3/l9AwkLoHiwlI9rQUcWRBn9uFF2hJf6shW8PVijdtEFMt
         dsaKDCUTTfPkfV3b5Z/d7JaQtt+OhuOJhLYSHn5ntzRuDd8KrZmOvOK5qIFHcuAhuB
         axWrqVtKZc2/w==
Date:   Tue, 3 Jan 2023 22:32:02 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Song Chen <chensong_2000@189.cn>
Cc:     rostedt@goodmis.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v5 3/3] kernel/trace: extract common part in
 process_fetch_insn
Message-Id: <20230103223202.7963bfb62b4ae5827e51ee30@kernel.org>
In-Reply-To: <1672382033-18390-1-git-send-email-chensong_2000@189.cn>
References: <1672382033-18390-1-git-send-email-chensong_2000@189.cn>
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

On Fri, 30 Dec 2022 14:33:53 +0800
Song Chen <chensong_2000@189.cn> wrote:

> Each probe has an instance of process_fetch_insn respectively,
> but they have something in common.
> 
> This patch aims to extract the common part into
> process_common_fetch_insn which can be shared by each probe,
> and they only need to focus on their special cases.
> 
> Signed-off-by: Song Chen <chensong_2000@189.cn>
> Suggested-by: Masami Hiramatsu <mhiramat@kernel.org>

This looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks!


> ---
>  kernel/trace/trace_eprobe.c     | 26 ++++++--------------------
>  kernel/trace/trace_kprobe.c     | 14 ++++----------
>  kernel/trace/trace_probe_tmpl.h | 20 ++++++++++++++++++++
>  kernel/trace/trace_uprobe.c     | 11 ++++-------
>  4 files changed, 34 insertions(+), 37 deletions(-)
> 
> diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
> index ca5d097eec4f..bff0f48f4b44 100644
> --- a/kernel/trace/trace_eprobe.c
> +++ b/kernel/trace/trace_eprobe.c
> @@ -395,20 +395,12 @@ static int get_eprobe_size(struct trace_probe *tp, void *rec)
>  			case FETCH_OP_TP_ARG:
>  				val = get_event_field(code, rec);
>  				break;
> -			case FETCH_OP_IMM:
> -				val = code->immediate;
> -				break;
> -			case FETCH_OP_COMM:
> -				val = (unsigned long)current->comm;
> -				break;
> -			case FETCH_OP_DATA:
> -				val = (unsigned long)code->data;
> -				break;
>  			case FETCH_NOP_SYMBOL:	/* Ignore a place holder */
>  				code++;
>  				goto retry;
>  			default:
> -				continue;
> +				if (process_common_fetch_insn(code, &val) < 0)
> +					continue;
>  			}
>  			code++;
>  			len = process_fetch_insn_bottom(code, val, NULL, NULL);
> @@ -428,26 +420,20 @@ process_fetch_insn(struct fetch_insn *code, void *rec, void *dest,
>  		   void *base)
>  {
>  	unsigned long val;
> +	int ret;
>  
>   retry:
>  	switch (code->op) {
>  	case FETCH_OP_TP_ARG:
>  		val = get_event_field(code, rec);
>  		break;
> -	case FETCH_OP_IMM:
> -		val = code->immediate;
> -		break;
> -	case FETCH_OP_COMM:
> -		val = (unsigned long)current->comm;
> -		break;
> -	case FETCH_OP_DATA:
> -		val = (unsigned long)code->data;
> -		break;
>  	case FETCH_NOP_SYMBOL:	/* Ignore a place holder */
>  		code++;
>  		goto retry;
>  	default:
> -		return -EILSEQ;
> +		ret = process_common_fetch_insn(code, &val);
> +		if (ret < 0)
> +			return ret;
>  	}
>  	code++;
>  	return process_fetch_insn_bottom(code, val, dest, base);
> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> index 714fe9c04eb6..af8b2023a76b 100644
> --- a/kernel/trace/trace_kprobe.c
> +++ b/kernel/trace/trace_kprobe.c
> @@ -1225,6 +1225,7 @@ process_fetch_insn(struct fetch_insn *code, void *rec, void *dest,
>  {
>  	struct pt_regs *regs = rec;
>  	unsigned long val;
> +	int ret;
>  
>  retry:
>  	/* 1st stage: get value from context */
> @@ -1241,15 +1242,6 @@ process_fetch_insn(struct fetch_insn *code, void *rec, void *dest,
>  	case FETCH_OP_RETVAL:
>  		val = regs_return_value(regs);
>  		break;
> -	case FETCH_OP_IMM:
> -		val = code->immediate;
> -		break;
> -	case FETCH_OP_COMM:
> -		val = (unsigned long)current->comm;
> -		break;
> -	case FETCH_OP_DATA:
> -		val = (unsigned long)code->data;
> -		break;
>  #ifdef CONFIG_HAVE_FUNCTION_ARG_ACCESS_API
>  	case FETCH_OP_ARG:
>  		val = regs_get_kernel_argument(regs, code->param);
> @@ -1259,7 +1251,9 @@ process_fetch_insn(struct fetch_insn *code, void *rec, void *dest,
>  		code++;
>  		goto retry;
>  	default:
> -		return -EILSEQ;
> +		ret = process_common_fetch_insn(code, &val);
> +		if (ret < 0)
> +			return ret;
>  	}
>  	code++;
>  
> diff --git a/kernel/trace/trace_probe_tmpl.h b/kernel/trace/trace_probe_tmpl.h
> index 1b57420857e1..17258eca0125 100644
> --- a/kernel/trace/trace_probe_tmpl.h
> +++ b/kernel/trace/trace_probe_tmpl.h
> @@ -67,6 +67,26 @@ probe_mem_read(void *dest, void *src, size_t size);
>  static nokprobe_inline int
>  probe_mem_read_user(void *dest, void *src, size_t size);
>  
> +/* common part of process_fetch_insn*/
> +static nokprobe_inline int
> +process_common_fetch_insn(struct fetch_insn *code, unsigned long *val)
> +{
> +	switch (code->op) {
> +	case FETCH_OP_IMM:
> +		*val = code->immediate;
> +		break;
> +	case FETCH_OP_COMM:
> +		*val = (unsigned long)current->comm;
> +		break;
> +	case FETCH_OP_DATA:
> +		*val = (unsigned long)code->data;
> +		break;
> +	default:
> +		return -EILSEQ;
> +	}
> +	return 0;
> +}
> +
>  /* From the 2nd stage, routine is same */
>  static nokprobe_inline int
>  process_fetch_insn_bottom(struct fetch_insn *code, unsigned long val,
> diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
> index 1ff8f87211a6..c53b0752533f 100644
> --- a/kernel/trace/trace_uprobe.c
> +++ b/kernel/trace/trace_uprobe.c
> @@ -220,6 +220,7 @@ process_fetch_insn(struct fetch_insn *code, void *rec, void *dest,
>  {
>  	struct pt_regs *regs = rec;
>  	unsigned long val;
> +	int ret;
>  
>  	/* 1st stage: get value from context */
>  	switch (code->op) {
> @@ -235,20 +236,16 @@ process_fetch_insn(struct fetch_insn *code, void *rec, void *dest,
>  	case FETCH_OP_RETVAL:
>  		val = regs_return_value(regs);
>  		break;
> -	case FETCH_OP_IMM:
> -		val = code->immediate;
> -		break;
>  	case FETCH_OP_COMM:
>  		val = FETCH_TOKEN_COMM;
>  		break;
> -	case FETCH_OP_DATA:
> -		val = (unsigned long)code->data;
> -		break;
>  	case FETCH_OP_FOFFS:
>  		val = translate_user_vaddr(code->immediate);
>  		break;
>  	default:
> -		return -EILSEQ;
> +		ret = process_common_fetch_insn(code, &val);
> +		if (ret < 0)
> +			return ret;
>  	}
>  	code++;
>  
> -- 
> 2.25.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
