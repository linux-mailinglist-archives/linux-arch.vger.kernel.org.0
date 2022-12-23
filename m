Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7929F655137
	for <lists+linux-arch@lfdr.de>; Fri, 23 Dec 2022 15:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbiLWOPv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 23 Dec 2022 09:15:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiLWOPu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 23 Dec 2022 09:15:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4627B13EA4;
        Fri, 23 Dec 2022 06:15:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA13560F74;
        Fri, 23 Dec 2022 14:15:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFE6DC433D2;
        Fri, 23 Dec 2022 14:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671804948;
        bh=kC/5ICblD4LB7IvS8fwCTmiK5DQUeaEZVETPs8nZAZ8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gzVYtBIoG1z48keDm9V4HVDC/PGhcmFIQJFHTrA2l9xP8AREJ1f+fog6mveB2ZHur
         m29UFSZCbhrbQRA0Wb0UVY5hRJOx5IUasz6U40uqG2I/XnJ+KHrvub6dq30gutvMaS
         wI/GlLpxn7Y0MWex1CbTd/NsjiY4njntP4z/oPKVCakXUCmCGy/cr6gEtuDMJdyrJp
         zBvpEnS+J10mzT9or1kldLX3HxHc+bueLw+8XEZ38Qx7O7WoE8GWJapH5kked6UyqO
         1QY+FYKVgHcYT6ZA909f7d7SwD/uyqe25G7GgmRmLQ9L48B+Y3kiWqPRpHuVEJ8aGI
         hsCK9o8EAcPIw==
Date:   Fri, 23 Dec 2022 23:15:45 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Song Chen <chensong_2000@189.cn>
Cc:     rostedt@goodmis.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v3 4/4] kernel/trace: remove calling regs_* when
 compiling HEXAGON
Message-Id: <20221223231545.e619f35b321192fbaa2f4cf9@kernel.org>
In-Reply-To: <1670229017-4106-1-git-send-email-chensong_2000@189.cn>
References: <1670229017-4106-1-git-send-email-chensong_2000@189.cn>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon,  5 Dec 2022 16:30:17 +0800
Song Chen <chensong_2000@189.cn> wrote:

> kernel test robot reports below errors:
> 
> In file included from kernel/trace/trace_events_synth.c:22:
> >> kernel/trace/trace_probe_kernel.h:203:9: error: call to
> undeclared function 'regs_get_register'; ISO C99 and later
> do not support implicit function declarations
> [-Wimplicit-function-declaration]
>                    val = regs_get_register(regs, code->param);
> 
> HEXAGON doesn't define and implement those reg_* functions
> underneath arch/hexagon as well as other archs. To remove
> those errors, i have to include those function calls in
> "CONFIG_HEXAGON"
> 
> It looks ugly, but i don't know any other way to fix it,
> this patch can be reverted after reg_* have been in place
> in arch/hexagon.
> 

Sorry, NACK. This is too add-hoc patch and this is introduced
by your patch. Do not introduce an issue and fix it later in
the same series.
Please fix it in your first patch. Maybe you should make another
header file for those APIs.

Thank you, 

> Signed-off-by: Song Chen <chensong_2000@189.cn>
> Reported-by: kernel test robot <lkp@intel.com>
> ---
>  kernel/trace/trace_probe_kernel.h | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/trace_probe_kernel.h b/kernel/trace/trace_probe_kernel.h
> index 8c42abe0dacf..7e958b7f07e5 100644
> --- a/kernel/trace/trace_probe_kernel.h
> +++ b/kernel/trace/trace_probe_kernel.h
> @@ -130,8 +130,7 @@ probe_mem_read(void *dest, void *src, size_t size)
>  	return copy_from_kernel_nofault(dest, src, size);
>  }
>  
> -static nokprobe_inline unsigned long
> -get_event_field(struct fetch_insn *code, void *rec)
> +static unsigned long get_event_field(struct fetch_insn *code, void *rec)
>  {
>  	struct ftrace_event_field *field = code->data;
>  	unsigned long val;
> @@ -194,23 +193,41 @@ static int
>  process_fetch_insn(struct fetch_insn *code, void *rec, void *dest,
>  		   void *base)
>  {
> +#ifndef CONFIG_HEXAGON
>  	struct pt_regs *regs = rec;
> +#endif
>  	unsigned long val;
>  
>  retry:
>  	/* 1st stage: get value from context */
>  	switch (code->op) {
>  	case FETCH_OP_REG:
> +#ifdef CONFIG_HEXAGON
> +		val = 0;
> +#else
>  		val = regs_get_register(regs, code->param);
> +#endif
>  		break;
>  	case FETCH_OP_STACK:
> +#ifdef CONFIG_HEXAGON
> +		val = 0;
> +#else
>  		val = regs_get_kernel_stack_nth(regs, code->param);
> +#endif
>  		break;
>  	case FETCH_OP_STACKP:
> +#ifdef CONFIG_HEXAGON
> +		val = 0;
> +#else
>  		val = kernel_stack_pointer(regs);
> +#endif
>  		break;
>  	case FETCH_OP_RETVAL:
> +#ifdef CONFIG_HEXAGON
> +		val = 0;
> +#else
>  		val = regs_return_value(regs);
> +#endif
>  		break;
>  	case FETCH_OP_IMM:
>  		val = code->immediate;
> -- 
> 2.25.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
