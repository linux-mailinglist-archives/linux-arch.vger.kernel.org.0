Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF27776C22
	for <lists+linux-arch@lfdr.de>; Thu, 10 Aug 2023 00:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbjHIWZd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Aug 2023 18:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjHIWZd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Aug 2023 18:25:33 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22FF9B2;
        Wed,  9 Aug 2023 15:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=//xuUqEbAoChMqlkpflQb6XFF+UhgSuCsR64Dz8oIOw=; b=RufX4PgdOl7/nn1WfR4xMKanOl
        D8ramvykvo45vHnoc+ju2imszAJPNbvtFdVL0OAfTekgQwwA2HBM3O4RyiDQpaRRNM/2kqS4u4SmG
        YwKohVEgznE3HYd0qC2ScNMZxaFBGA5NkQUwLMYG2eTgldeeOQHQlWYD98Ym40vjOQsny+efBjxpc
        0P0JA7rgEa0usmHDtYv85YIiTyIQzg5ThDrQMn8xVUCCsF7KFw1AslC2RHbmnlzeh9t2ZgwSG2B9c
        CsDCPXpSHkA9MheAvKSZSV/fFKyMjeyJHm+/VdJLiZKwvNgVK0zS633u+Cv7gN5lEt4OKitHigi+u
        SmbFSjYQ==;
Received: from [191.193.179.209] (helo=[192.168.1.111])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1qTrcL-00GDvY-H2; Thu, 10 Aug 2023 00:25:25 +0200
Message-ID: <071c02ae-a74d-46d8-990b-262264b62caf@igalia.com>
Date:   Wed, 9 Aug 2023 19:25:19 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/14] futex: Add sys_futex_wake()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        dvhart@infradead.org, dave@stgolabs.net, tglx@linutronix.de,
        axboe@kernel.dk, Andrew Morton <akpm@linux-foundation.org>,
        urezki@gmail.com, hch@infradead.org, lstoakes@gmail.com,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        malteskarupke@web.de, Geert Uytterhoeven <geert@linux-m68k.org>
References: <20230807121843.710612856@infradead.org>
 <20230807123323.090897260@infradead.org>
Content-Language: en-US
From:   =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <20230807123323.090897260@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Peter,

Em 07/08/2023 09:18, Peter Zijlstra escreveu:
> To complement sys_futex_waitv() add sys_futex_wake(). This syscall
> implements what was previously known as FUTEX_WAKE_BITSET except it
> uses 'unsigned long' for the bitmask and takes FUTEX2 flags.
> 
> The 'unsigned long' allows FUTEX2_SIZE_U64 on 64bit platforms.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---

[...]

> +/*
> + * sys_futex_wake - Wake a number of futexes
> + * @uaddr:	Address of the futex(es) to wake
> + * @mask:	bitmask
> + * @nr:		Number of the futexes to wake
> + * @flags:	FUTEX2 flags
> + *
> + * Identical to the traditional FUTEX_WAKE_BITSET op, except it is part of the
> + * futex2 family of calls.
> + */
> +
> +SYSCALL_DEFINE4(futex_wake,
> +		void __user *, uaddr,
> +		unsigned long, mask,
> +		int, nr,
> +		unsigned int, flags)
> +{

Do you think we could have a

	if (!nr)
		return 0;

here? Otherwise, calling futex_wake(&f, 0, flags) will wake 1 futex (if 
available), which is a strange undocumented behavior in my opinion.

> +	if (flags & ~FUTEX2_VALID_MASK)
> +		return -EINVAL;
> +
> +	flags = futex2_to_flags(flags);
> +	if (!futex_flags_valid(flags))
> +		return -EINVAL;
> +
> +	if (!futex_validate_input(flags, mask))
> +		return -EINVAL;
> +
> +	return futex_wake(uaddr, flags, nr, mask);
> +}
> +
>   #ifdef CONFIG_COMPAT
>   COMPAT_SYSCALL_DEFINE2(set_robust_list,
>   		struct compat_robust_list_head __user *, head,
> --- a/kernel/sys_ni.c
> +++ b/kernel/sys_ni.c
> @@ -87,6 +87,7 @@ COND_SYSCALL_COMPAT(set_robust_list);
>   COND_SYSCALL(get_robust_list);
>   COND_SYSCALL_COMPAT(get_robust_list);
>   COND_SYSCALL(futex_waitv);
> +COND_SYSCALL(futex_wake);
>   COND_SYSCALL(kexec_load);
>   COND_SYSCALL_COMPAT(kexec_load);
>   COND_SYSCALL(init_module);
> 
> 
