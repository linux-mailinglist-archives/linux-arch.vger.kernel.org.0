Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B328577353D
	for <lists+linux-arch@lfdr.de>; Tue,  8 Aug 2023 01:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbjHGXwB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Aug 2023 19:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjHGXwA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Aug 2023 19:52:00 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B8809E;
        Mon,  7 Aug 2023 16:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=m/8sfZtPepdEzWXIkozoxJYa1l+e++UeoE3yI8VOEBY=; b=D6MJQbL6py8+R+xYZewA8eGw1B
        XBTftyAMMQBIc8s3UgmrUn9FX+AdJqGdTy13apx0+YrOTbkJI2dpDYbWrtdqHVoVGvM8/iOB2ge1m
        wWS83yEQNuo888rvLN5MTEaQHy6oM76/pvwNR9+CPhQKH7nINO3jlV1q1hWa4v8jGgsI4Aok9JO/+
        M1nR71q8CG8AtgolIuoYaohkQwHH75XmXQzIdRWDrP09Wwpbqotz5H+L7RTSyXvslI9oJjadHWBNJ
        Pk7JGc1XG/vznPdK6Spfno857Txfw/gGRJMrQC28XO+h5UG/Z7zfL92Ai/Pu6zGeIJRLFL2oXROk7
        Nf2IaLRw==;
Received: from [177.45.63.19] (helo=[192.168.1.111])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1qTA0t-00F9EE-2b; Tue, 08 Aug 2023 01:51:51 +0200
Message-ID: <3e73ae5e-8550-42a7-82de-bea1ca57fe1e@igalia.com>
Date:   Mon, 7 Aug 2023 20:51:42 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/14] futex: Clarify FUTEX2 flags
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        dvhart@infradead.org, dave@stgolabs.net,
        Andrew Morton <akpm@linux-foundation.org>, urezki@gmail.com,
        hch@infradead.org, lstoakes@gmail.com,
        Arnd Bergmann <arnd@arndb.de>, tglx@linutronix.de,
        linux-api@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, malteskarupke@web.de, axboe@kernel.dk
References: <20230807121843.710612856@infradead.org>
 <20230807123322.814039156@infradead.org>
Content-Language: en-US
From:   =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <20230807123322.814039156@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Peter, thank you for your patches.

Em 07/08/2023 09:18, Peter Zijlstra escreveu:
> sys_futex_waitv() is part of the futex2 series (the first and only so
> far) of syscalls and has a flags field per futex (as opposed to flags
> being encoded in the futex op).
> 
> This new flags field has a new namespace, which unfortunately isn't
> super explicit. Notably it currently takes FUTEX_32 and
> FUTEX_PRIVATE_FLAG.
> 
> Introduce the FUTEX2 namespace to clarify this
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: André Almeida <andrealmeid@igalia.com>

> ---
>   include/uapi/linux/futex.h |   16 +++++++++++++---
>   kernel/futex/syscalls.c    |    7 +++----
>   2 files changed, 16 insertions(+), 7 deletions(-)
> 
> --- a/include/uapi/linux/futex.h
> +++ b/include/uapi/linux/futex.h
> @@ -44,10 +44,20 @@
>   					 FUTEX_PRIVATE_FLAG)
>   
>   /*
> - * Flags to specify the bit length of the futex word for futex2 syscalls.
> - * Currently, only 32 is supported.
> + * Flags for futex2 syscalls.
>    */
> -#define FUTEX_32		2
> +			/*	0x00 */
> +			/*	0x01 */
> +#define FUTEX2_SIZE_U32		0x02
> +			/*	0x04 */
> +			/*	0x08 */
> +			/*	0x10 */
> +			/*	0x20 */
> +			/*	0x40 */
> +#define FUTEX2_PRIVATE		FUTEX_PRIVATE_FLAG
> +
> +/* do not use */
> +#define FUTEX_32		FUTEX2_SIZE_U32 /* historical accident :-( */
>   
>   /*
>    * Max numbers of elements in a futex_waitv array
> --- a/kernel/futex/syscalls.c
> +++ b/kernel/futex/syscalls.c
> @@ -183,8 +183,7 @@ SYSCALL_DEFINE6(futex, u32 __user *, uad
>   	return do_futex(uaddr, op, val, tp, uaddr2, (unsigned long)utime, val3);
>   }
>   
> -/* Mask of available flags for each futex in futex_waitv list */
> -#define FUTEXV_WAITER_MASK (FUTEX_32 | FUTEX_PRIVATE_FLAG)
> +#define FUTEX2_VALID_MASK (FUTEX2_SIZE_U32 | FUTEX2_PRIVATE)
>   
>   /**
>    * futex_parse_waitv - Parse a waitv array from userspace
> @@ -205,10 +204,10 @@ static int futex_parse_waitv(struct fute
>   		if (copy_from_user(&aux, &uwaitv[i], sizeof(aux)))
>   			return -EFAULT;
>   
> -		if ((aux.flags & ~FUTEXV_WAITER_MASK) || aux.__reserved)
> +		if ((aux.flags & ~FUTEX2_VALID_MASK) || aux.__reserved)
>   			return -EINVAL;
>   
> -		if (!(aux.flags & FUTEX_32))
> +		if (!(aux.flags & FUTEX2_SIZE_U32))
>   			return -EINVAL;
>   
>   		futexv[i].w.flags = aux.flags;
> 
> 
