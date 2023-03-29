Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B89996CEF3C
	for <lists+linux-arch@lfdr.de>; Wed, 29 Mar 2023 18:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbjC2QXD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 29 Mar 2023 12:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjC2QXC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 29 Mar 2023 12:23:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D333C06;
        Wed, 29 Mar 2023 09:22:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 609FB61D89;
        Wed, 29 Mar 2023 16:22:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 967AEC433EF;
        Wed, 29 Mar 2023 16:22:52 +0000 (UTC)
Date:   Wed, 29 Mar 2023 17:22:49 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Gregory Price <gourry.memverge@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        oleg@redhat.com, avagin@gmail.com, peterz@infradead.org,
        luto@kernel.org, krisman@collabora.com, tglx@linutronix.de,
        corbet@lwn.net, shuah@kernel.org, arnd@arndb.de, will@kernel.org,
        mark.rutland@arm.com, tongtiangen@huawei.com, robin.murphy@arm.com,
        Gregory Price <gregory.price@memverge.com>
Subject: Re: [PATCH v14 1/4] asm-generic,arm64: create task variant of
 access_ok
Message-ID: <ZCRl2ZDsNK2nKAfy@arm.com>
References: <20230328164811.2451-1-gregory.price@memverge.com>
 <20230328164811.2451-2-gregory.price@memverge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328164811.2451-2-gregory.price@memverge.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Mar 28, 2023 at 12:48:08PM -0400, Gregory Price wrote:
> diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
> index 5c7b2f9d5913..1a51a54f264f 100644
> --- a/arch/arm64/include/asm/uaccess.h
> +++ b/arch/arm64/include/asm/uaccess.h
> @@ -35,7 +35,9 @@ static inline int __access_ok(const void __user *ptr, unsigned long size);
>   * This is equivalent to the following test:
>   * (u65)addr + (u65)size <= (u65)TASK_SIZE_MAX
>   */
> -static inline int access_ok(const void __user *addr, unsigned long size)
> +static inline int task_access_ok(struct task_struct *task,
> +				 const void __user *addr,
> +				 unsigned long size)
>  {
>  	/*
>  	 * Asynchronous I/O running in a kernel thread does not have the
> @@ -43,11 +45,18 @@ static inline int access_ok(const void __user *addr, unsigned long size)
>  	 * the user address before checking.
>  	 */
>  	if (IS_ENABLED(CONFIG_ARM64_TAGGED_ADDR_ABI) &&
> -	    (current->flags & PF_KTHREAD || test_thread_flag(TIF_TAGGED_ADDR)))
> +	    (task->flags & PF_KTHREAD || test_ti_thread_flag(task, TIF_TAGGED_ADDR)))
>  		addr = untagged_addr(addr);
>  
>  	return likely(__access_ok(addr, size));
>  }
> +
> +static inline int access_ok(const void __user *addr, unsigned long size)
> +{
> +	return task_access_ok(current, addr, size);
> +}
> +
> +#define task_access_ok task_access_ok

I'd not bother with this at all. In the generic code you can either do
an __access_ok() check directly or just
access_ok(untagged_addr(selector), ...) with a comment that address
tagging of the ptraced task may not be enabled.

-- 
Catalin
