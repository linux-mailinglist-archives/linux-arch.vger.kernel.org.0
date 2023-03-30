Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4296D124C
	for <lists+linux-arch@lfdr.de>; Fri, 31 Mar 2023 00:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbjC3WlT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 30 Mar 2023 18:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbjC3WlL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 30 Mar 2023 18:41:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA312EB52;
        Thu, 30 Mar 2023 15:41:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7C34AB82A60;
        Thu, 30 Mar 2023 22:41:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B61F3C433D2;
        Thu, 30 Mar 2023 22:41:02 +0000 (UTC)
Date:   Thu, 30 Mar 2023 23:40:59 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Gregory Price <gourry.memverge@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arch@vger.kernel.org, oleg@redhat.com, avagin@gmail.com,
        peterz@infradead.org, luto@kernel.org, krisman@collabora.com,
        tglx@linutronix.de, corbet@lwn.net, shuah@kernel.org,
        arnd@arndb.de, Gregory Price <gregory.price@memverge.com>
Subject: Re: [PATCH v15 2/4] syscall user dispatch: untag selector addresses
 before access_ok
Message-ID: <ZCYP+4gRZDqC0lRo@arm.com>
References: <20230330212121.1688-1-gregory.price@memverge.com>
 <20230330212121.1688-3-gregory.price@memverge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230330212121.1688-3-gregory.price@memverge.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Mar 30, 2023 at 05:21:22PM -0400, Gregory Price wrote:
> diff --git a/kernel/entry/syscall_user_dispatch.c b/kernel/entry/syscall_user_dispatch.c
> index 22396b234854..16086226b41c 100644
> --- a/kernel/entry/syscall_user_dispatch.c
> +++ b/kernel/entry/syscall_user_dispatch.c
> @@ -87,7 +87,18 @@ static int task_set_syscall_user_dispatch(struct task_struct *task, unsigned lon
>  		if (offset && offset + len <= offset)
>  			return -EINVAL;
>  
> -		if (selector && !access_ok(selector, sizeof(*selector)))
> +		/*
> +		 * access_ok will clear memory tags for tagged addresses on tasks where
> +		 * memory tagging is enabled.  To enable a tracer to set a tracee's
> +		 * selector not in the same tagging state, the selector address must be
> +		 * untagged for access_ok, otherwise an untagged tracer will always fail
> +		 * to set a tagged tracee's selector.
> +		 *
> +		 * The result of this is that a tagged tracer may be capable of setting
> +		 * an invalid address, and the tracee will SIGSEGV on the next syscall.
> +		 * This is equivalent to a task setting a bad selector (selector=0x1).
> +		 */

I'd drop the last paragraph above. Even without tagged pointers, a tracer
can set an invalid address (as you already mentioned) but the phrasing
some implies (to me) that if we did it differently, the tracer would not be
able to set an invalid pointer.

Either way,

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

-- 
Catalin
