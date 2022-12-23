Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAA966551FC
	for <lists+linux-arch@lfdr.de>; Fri, 23 Dec 2022 16:22:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236325AbiLWPWF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 23 Dec 2022 10:22:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiLWPWE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 23 Dec 2022 10:22:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F2ABC04;
        Fri, 23 Dec 2022 07:22:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 58479611DB;
        Fri, 23 Dec 2022 15:22:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86187C433EF;
        Fri, 23 Dec 2022 15:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671808920;
        bh=CR9laOfT88DbZYkNVldbIf3CGCqsMBJWAm+kRPjVPGs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Dijplt8YGygEEGyCGnk7z3rBvaPWMRyCN743cBBgB6ujWH/GmtrrKmb3hkXfvIlc6
         gqD1AbN/hr7m6iA1PiWhOtcbKrlPbS1tSUJR1IX2MfGyHpVZKmkc37A9B2ubWweRnD
         0U+VC4oHrcoGJ8un8Rp05EEPlKCqUvjlJZmKCpnSXa5RDTMxX8GO5GpW6Iw1xP0RbN
         X64ysPKud/An5DmpBAzeSrzrRZMNoIRaX5iZxJrZd+geGi9jh6kRgLB8hZ5LhzOdnn
         DIKEgJwu5zBvDi+66OaKUrDCMSbYak93gWfcjQn7hwjdSvepEBR8FzX4MwXlWm41Pa
         0LM1Di/EEaNuA==
Date:   Sat, 24 Dec 2022 00:21:57 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Song Chen <chensong_2000@189.cn>
Cc:     rostedt@goodmis.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v3 2/4] kernel/trace: Provide default impelentations
 defined in trace_probe_tmpl.h
Message-Id: <20221224002157.ce3caeee919d153fe4f56bc8@kernel.org>
In-Reply-To: <1670228994-4020-1-git-send-email-chensong_2000@189.cn>
References: <1670228994-4020-1-git-send-email-chensong_2000@189.cn>
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

Hi Song,

On Mon,  5 Dec 2022 16:29:54 +0800
Song Chen <chensong_2000@189.cn> wrote:

> @@ -112,4 +112,133 @@ kern_fetch_store_string(unsigned long addr, void *dest, void *base)
>  	return ret;
>  }
>  
> +static nokprobe_inline int
> +probe_mem_read_user(void *dest, void *src, size_t size)
> +{
> +	const void __user *uaddr =  (__force const void __user *)src;
> +
> +	return copy_from_user_nofault(dest, uaddr, size);
> +}
> +
> +static nokprobe_inline int
> +probe_mem_read(void *dest, void *src, size_t size)
> +{
> +#ifdef CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
> +	if ((unsigned long)src < TASK_SIZE)
> +		return probe_mem_read_user(dest, src, size);
> +#endif
> +	return copy_from_kernel_nofault(dest, src, size);
> +}
> +

So, the error which kernel build bot found has been introduced by this patch.
The easiest acceptable change will add

#ifdef CONFIG_HAVE_REGS_AND_STACK_ACCESS_API

here, and #endif after process_fetch_insn(). 

Thank you,

> +static nokprobe_inline unsigned long
> +get_event_field(struct fetch_insn *code, void *rec)
> +{
> +	struct ftrace_event_field *field = code->data;
> +	unsigned long val;
> +	void *addr;
> +
> +	addr = rec + field->offset;
> +
> +	if (is_string_field(field)) {
> +		switch (field->filter_type) {
> +		case FILTER_DYN_STRING:
> +			val = (unsigned long)(rec + (*(unsigned int *)addr & 0xffff));
> +			break;
> +		case FILTER_RDYN_STRING:
> +			val = (unsigned long)(addr + (*(unsigned int *)addr & 0xffff));
> +			break;
> +		case FILTER_STATIC_STRING:
> +			val = (unsigned long)addr;
> +			break;
> +		case FILTER_PTR_STRING:
> +			val = (unsigned long)(*(char *)addr);
> +			break;
> +		default:
> +			WARN_ON_ONCE(1);
> +			return 0;
> +		}
> +		return val;
> +	}
> +
> +	switch (field->size) {
> +	case 1:
> +		if (field->is_signed)
> +			val = *(char *)addr;
> +		else
> +			val = *(unsigned char *)addr;
> +		break;
> +	case 2:
> +		if (field->is_signed)
> +			val = *(short *)addr;
> +		else
> +			val = *(unsigned short *)addr;
> +		break;
> +	case 4:
> +		if (field->is_signed)
> +			val = *(int *)addr;
> +		else
> +			val = *(unsigned int *)addr;
> +		break;
> +	default:
> +		if (field->is_signed)
> +			val = *(long *)addr;
> +		else
> +			val = *(unsigned long *)addr;
> +		break;
> +	}
> +	return val;
> +}
> +
> +/* Note that we don't verify it, since the code does not come from user space */
> +static int
> +process_fetch_insn(struct fetch_insn *code, void *rec, void *dest,
> +		   void *base)
> +{
> +	struct pt_regs *regs = rec;
> +	unsigned long val;
> +
> +retry:
> +	/* 1st stage: get value from context */
> +	switch (code->op) {
> +	case FETCH_OP_REG:
> +		val = regs_get_register(regs, code->param);
> +		break;
> +	case FETCH_OP_STACK:
> +		val = regs_get_kernel_stack_nth(regs, code->param);
> +		break;
> +	case FETCH_OP_STACKP:
> +		val = kernel_stack_pointer(regs);
> +		break;
> +	case FETCH_OP_RETVAL:
> +		val = regs_return_value(regs);
> +		break;
> +	case FETCH_OP_IMM:
> +		val = code->immediate;
> +		break;
> +	case FETCH_OP_COMM:
> +		val = (unsigned long)current->comm;
> +		break;
> +	case FETCH_OP_DATA:
> +		val = (unsigned long)code->data;
> +		break;
> +#ifdef CONFIG_HAVE_FUNCTION_ARG_ACCESS_API
> +	case FETCH_OP_ARG:
> +		val = regs_get_kernel_argument(regs, code->param);
> +		break;
> +#endif
> +	case FETCH_NOP_SYMBOL:	/* Ignore a place holder */
> +		code++;
> +		goto retry;
> +	case FETCH_OP_TP_ARG:
> +		val = get_event_field(code, rec);
> +		break;
> +	default:
> +		return -EILSEQ;
> +	}
> +	code++;
> +
> +	return process_fetch_insn_bottom(code, val, dest, base);
> +}
> +NOKPROBE_SYMBOL(process_fetch_insn)
> +
>  #endif /* __TRACE_PROBE_KERNEL_H_ */
> -- 
> 2.25.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
