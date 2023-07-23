Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1808475DFAB
	for <lists+linux-arch@lfdr.de>; Sun, 23 Jul 2023 04:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbjGWCIJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 22 Jul 2023 22:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjGWCII (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 22 Jul 2023 22:08:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC01511A
        for <linux-arch@vger.kernel.org>; Sat, 22 Jul 2023 19:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690078044;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aolYBVkE3WPKfHj0+foqpR/ODsP1aqUpuEFPF1b8XQI=;
        b=bO2wGi1HoTXWc796BP1t9TG+s1+TJUMhqXUFpC/89b+6wtiESsaEyPpBMDO8wwTpLvi7hT
        9/i8U3AHQxyaoxRaBplplHKz5WhI8bjmEoy3mkc8YC7/AmewK2jJ60Y+3+NFMh/9Q6oISK
        qzQ0xQ+VpOAkHX7NF6j5HX47+k1yQas=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-518-IHVL0zy_OzWro8RtDRzEQw-1; Sat, 22 Jul 2023 22:07:21 -0400
X-MC-Unique: IHVL0zy_OzWro8RtDRzEQw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ACC59293248C;
        Sun, 23 Jul 2023 02:07:20 +0000 (UTC)
Received: from [10.22.32.12] (unknown [10.22.32.12])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E77711121314;
        Sun, 23 Jul 2023 02:07:19 +0000 (UTC)
Message-ID: <0e39d62d-44bc-731e-471e-4df621b4cdd5@redhat.com>
Date:   Sat, 22 Jul 2023 22:07:19 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] asm-generic: ticket-lock: Optimize
 arch_spin_value_unlocked
Content-Language: en-US
To:     guoren@kernel.org, David.Laight@ACULAB.COM, will@kernel.org,
        peterz@infradead.org, mingo@redhat.com
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>
References: <20230719070001.795010-1-guoren@kernel.org>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230719070001.795010-1-guoren@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 7/19/23 03:00, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
>
> Using arch_spinlock_is_locked would cause another unnecessary memory
> access to the contended value. Although it won't cause a significant
> performance gap in most architectures, the arch_spin_value_unlocked
> argument contains enough information. Thus, remove unnecessary
> atomic_read in arch_spin_value_unlocked().

AFAICS, only one memory access is needed for the current 
arch_spinlock_is_locked(). So your description isn't quite right. OTOH, 
caller of arch_spin_value_unlocked() could benefit from this change. 
Currently, the only caller is lockref.

Other than that, the patch looks good to me.

Cheers,
Longman

>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Cc: David Laight <David.Laight@ACULAB.COM>
> Cc: Peter Zijlstra <peterz@infradead.org>
> ---
> Changelog:
> This patch is separate from:
> https://lore.kernel.org/linux-riscv/20220808071318.3335746-1-guoren@kernel.org/
>
> Peter & David have commented on it:
> https://lore.kernel.org/linux-riscv/YsK4Z9w0tFtgkni8@hirez.programming.kicks-ass.net/
> ---
>   include/asm-generic/spinlock.h | 16 +++++++++-------
>   1 file changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/include/asm-generic/spinlock.h b/include/asm-generic/spinlock.h
> index fdfebcb050f4..90803a826ba0 100644
> --- a/include/asm-generic/spinlock.h
> +++ b/include/asm-generic/spinlock.h
> @@ -68,11 +68,18 @@ static __always_inline void arch_spin_unlock(arch_spinlock_t *lock)
>   	smp_store_release(ptr, (u16)val + 1);
>   }
>   
> +static __always_inline int arch_spin_value_unlocked(arch_spinlock_t lock)
> +{
> +	u32 val = lock.counter;
> +
> +	return ((val >> 16) == (val & 0xffff));
> +}
> +
>   static __always_inline int arch_spin_is_locked(arch_spinlock_t *lock)
>   {
> -	u32 val = atomic_read(lock);
> +	arch_spinlock_t val = READ_ONCE(*lock);
>   
> -	return ((val >> 16) != (val & 0xffff));
> +	return !arch_spin_value_unlocked(val);
>   }
>   
>   static __always_inline int arch_spin_is_contended(arch_spinlock_t *lock)
> @@ -82,11 +89,6 @@ static __always_inline int arch_spin_is_contended(arch_spinlock_t *lock)
>   	return (s16)((val >> 16) - (val & 0xffff)) > 1;
>   }
>   
> -static __always_inline int arch_spin_value_unlocked(arch_spinlock_t lock)
> -{
> -	return !arch_spin_is_locked(&lock);
> -}
> -
>   #include <asm/qrwlock.h>
>   
>   #endif /* __ASM_GENERIC_SPINLOCK_H */

