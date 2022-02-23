Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A905B4C1FA9
	for <lists+linux-arch@lfdr.de>; Thu, 24 Feb 2022 00:31:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244814AbiBWXbe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Feb 2022 18:31:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243948AbiBWXbc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 23 Feb 2022 18:31:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D58583B6;
        Wed, 23 Feb 2022 15:31:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 71131B81878;
        Wed, 23 Feb 2022 23:31:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62A8BC340E7;
        Wed, 23 Feb 2022 23:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645659061;
        bh=lqCEQ++vi7cgL8SGDqvu6VRtg8aruPJlQBSjPBXBFVM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=sbRe9FkUPCxCGG5QhSpQFHALisL4a0h67bCxhSLbAt1nLiwP1yIOk1Uj7FSa6KCb5
         weBLktMX2iJ1azUVoI5qzyIPsB248hdzJqK4FY8iQs4ijX9ClxGFEG4dPQ2t94Tu+v
         xnm83JKO7FsjVlGtupBZVZ1sGqkMArGtNnLjnEwqgMRRugYsRTn+yfOLhixpTMveFC
         hFyJk7dTbBRw3IsZy86rcTOonVkHxoMQs0BGW96T4vsXyVidvkbPH0uwFh8RFITz5K
         oD3k8dsNBCQPOLOspB8IOHbjF16KCCmPClOP9aOj20bxN2gTg9NdvWcdAxevymW0xQ
         hD4A1zZdc89kw==
Message-ID: <c6f461f1-1dd9-aec1-2c85-a3eda478a1be@kernel.org>
Date:   Wed, 23 Feb 2022 17:30:53 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 07/18] nios2: drop access_ok() check from __put_user()
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, linux-api@vger.kernel.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk
Cc:     linux@armlinux.org.uk, will@kernel.org, guoren@kernel.org,
        bcain@codeaurora.org, geert@linux-m68k.org, monstr@monstr.eu,
        tsbogend@alpha.franken.de, nickhu@andestech.com,
        green.hu@gmail.com, shorne@gmail.com, deller@gmx.de,
        mpe@ellerman.id.au, peterz@infradead.org, mingo@redhat.com,
        mark.rutland@arm.com, hca@linux.ibm.com, dalias@libc.org,
        davem@davemloft.net, richard@nod.at, x86@kernel.org,
        jcmvbkbc@gmail.com, ebiederm@xmission.com,
        akpm@linux-foundation.org, ardb@kernel.org,
        linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org
References: <20220216131332.1489939-1-arnd@kernel.org>
 <20220216131332.1489939-8-arnd@kernel.org>
From:   Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20220216131332.1489939-8-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 2/16/22 07:13, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Unlike other architectures, the nios2 version of __put_user() has an
> extra check for access_ok(), preventing it from being used to implement
> __put_kernel_nofault().
> 
> Split up put_user() along the same lines as __get_user()/get_user()
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   arch/nios2/include/asm/uaccess.h | 56 +++++++++++++++++++-------------
>   1 file changed, 33 insertions(+), 23 deletions(-)
> 
> diff --git a/arch/nios2/include/asm/uaccess.h b/arch/nios2/include/asm/uaccess.h
> index ca9285a915ef..a5cbe07cf0da 100644
> --- a/arch/nios2/include/asm/uaccess.h
> +++ b/arch/nios2/include/asm/uaccess.h
> @@ -167,34 +167,44 @@ do {									\
>   	: "r" (val), "r" (ptr), "i" (-EFAULT));				\
>   }
>   
> -#define put_user(x, ptr)						\
> +#define __put_user_common(__pu_val, __pu_ptr)				\
>   ({									\
>   	long __pu_err = -EFAULT;					\
> -	__typeof__(*(ptr)) __user *__pu_ptr = (ptr);			\
> -	__typeof__(*(ptr)) __pu_val = (__typeof(*ptr))(x);		\
> -	if (access_ok(__pu_ptr, sizeof(*__pu_ptr))) {	\
> -		switch (sizeof(*__pu_ptr)) {				\
> -		case 1:							\
> -			__put_user_asm(__pu_val, "stb", __pu_ptr, __pu_err); \
> -			break;						\
> -		case 2:							\
> -			__put_user_asm(__pu_val, "sth", __pu_ptr, __pu_err); \
> -			break;						\
> -		case 4:							\
> -			__put_user_asm(__pu_val, "stw", __pu_ptr, __pu_err); \
> -			break;						\
> -		default:						\
> -			/* XXX: This looks wrong... */			\
> -			__pu_err = 0;					\
> -			if (copy_to_user(__pu_ptr, &(__pu_val),		\
> -				sizeof(*__pu_ptr)))			\
> -				__pu_err = -EFAULT;			\
> -			break;						\
> -		}							\
> +	switch (sizeof(*__pu_ptr)) {					\
> +	case 1:								\
> +		__put_user_asm(__pu_val, "stb", __pu_ptr, __pu_err);	\
> +		break;							\
> +	case 2:								\
> +		__put_user_asm(__pu_val, "sth", __pu_ptr, __pu_err);	\
> +		break;							\
> +	case 4:								\
> +		__put_user_asm(__pu_val, "stw", __pu_ptr, __pu_err);	\
> +		break;							\
> +	default:							\
> +		/* XXX: This looks wrong... */				\
> +		__pu_err = 0;						\
> +		if (__copy_to_user(__pu_ptr, &(__pu_val),		\
> +			sizeof(*__pu_ptr)))				\
> +			__pu_err = -EFAULT;				\
> +		break;							\
>   	}								\
>   	__pu_err;							\
>   })
>   
> -#define __put_user(x, ptr) put_user(x, ptr)
> +#define __put_user(x, ptr)						\
> +({									\
> +	__auto_type __pu_ptr = (ptr);					\
> +	typeof(*__pu_ptr) __pu_val = (typeof(*__pu_ptr))(x);		\
> +	__put_user_common(__pu_val, __pu_ptr);				\
> +})
> +
> +#define put_user(x, ptr)						\
> +({									\
> +	__auto_type __pu_ptr = (ptr);					\
> +	typeof(*__pu_ptr) __pu_val = (typeof(*__pu_ptr))(x);		\
> +	access_ok(__pu_ptr, sizeof(*__pu_ptr)) ?			\
> +		__put_user_common(__pu_val, __pu_ptr) :			\
> +		-EFAULT;						\
> +})
>   
>   #endif /* _ASM_NIOS2_UACCESS_H */

Acked-by: Dinh Nguyen <dinguyen@kernel.org>
