Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D627655EC4E
	for <lists+linux-arch@lfdr.de>; Tue, 28 Jun 2022 20:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbiF1SNq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Jun 2022 14:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbiF1SNq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Jun 2022 14:13:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4A4C41B78B
        for <linux-arch@vger.kernel.org>; Tue, 28 Jun 2022 11:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656440024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BCsO+VHWvi/xygeTHehRQRa8L5qzqJMKZwPbHoiNY8A=;
        b=cBYdotTo1N8uURC2AHU6LRfuXC9tMmucNeqnTK9IDDolYm8AcWBW96XLTq6efFnaVLihKP
        1FwFzfg34GBBYAOmg/P3nWFeOcJ39dfq0JU+R5oncpkFccJQAEhpEJhsY62J+FaRh3Tkuz
        s8ey3WQJFUghBwKjHOx7Ywd0BcgmD5Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-384-z1c1mbwEPzysVN0r0myy4Q-1; Tue, 28 Jun 2022 14:13:41 -0400
X-MC-Unique: z1c1mbwEPzysVN0r0myy4Q-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7B543801233;
        Tue, 28 Jun 2022 18:13:40 +0000 (UTC)
Received: from [10.22.34.187] (unknown [10.22.34.187])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 170E4492CA3;
        Tue, 28 Jun 2022 18:13:40 +0000 (UTC)
Message-ID: <09abc75e-2ffb-1ab5-d0fc-1c15c943948d@redhat.com>
Date:   Tue, 28 Jun 2022 14:13:39 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH V7 4/5] asm-generic: spinlock: Add combo spinlock (ticket
 & queued)
Content-Language: en-US
To:     guoren@kernel.org, palmer@rivosinc.com, arnd@arndb.de,
        mingo@redhat.com, will@kernel.org, boqun.feng@gmail.com
Cc:     linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>,
        Peter Zijlstra <peterz@infradead.org>
References: <20220628081707.1997728-1-guoren@kernel.org>
 <20220628081707.1997728-5-guoren@kernel.org>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20220628081707.1997728-5-guoren@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 6/28/22 04:17, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
>
> Some architecture has a flexible requirement on the type of spinlock.
> Some LL/SC architectures of ISA don't force micro-arch to give a strong
> forward guarantee. Thus different kinds of memory model micro-arch would
> come out in one ISA. The ticket lock is suitable for exclusive monitor
> designed LL/SC micro-arch with limited cores and "!NUMA". The
> queue-spinlock could deal with NUMA/large-scale scenarios with a strong
> forward guarantee designed LL/SC micro-arch.
>
> So, make the spinlock a combo with feature.
>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Palmer Dabbelt <palmer@rivosinc.com>
> ---
>   include/asm-generic/spinlock.h | 43 ++++++++++++++++++++++++++++++++--
>   kernel/locking/qspinlock.c     |  2 ++
>   2 files changed, 43 insertions(+), 2 deletions(-)
>
> diff --git a/include/asm-generic/spinlock.h b/include/asm-generic/spinlock.h
> index f41dc7c2b900..a9b43089bf99 100644
> --- a/include/asm-generic/spinlock.h
> +++ b/include/asm-generic/spinlock.h
> @@ -28,34 +28,73 @@
>   #define __ASM_GENERIC_SPINLOCK_H
>   
>   #include <asm-generic/ticket_spinlock.h>
> +#ifdef CONFIG_ARCH_USE_QUEUED_SPINLOCKS
> +#include <linux/jump_label.h>
> +#include <asm-generic/qspinlock.h>
> +
> +DECLARE_STATIC_KEY_TRUE(use_qspinlock_key);
> +#endif
> +
> +#undef arch_spin_is_locked
> +#undef arch_spin_is_contended
> +#undef arch_spin_value_unlocked
> +#undef arch_spin_lock
> +#undef arch_spin_trylock
> +#undef arch_spin_unlock
>   
>   static __always_inline void arch_spin_lock(arch_spinlock_t *lock)
>   {
> -	ticket_spin_lock(lock);
> +#ifdef CONFIG_ARCH_USE_QUEUED_SPINLOCKS
> +	if (static_branch_likely(&use_qspinlock_key))
> +		queued_spin_lock(lock);
> +	else
> +#endif
> +		ticket_spin_lock(lock);
>   }

Why do you use a static key to control whether to use qspinlock or 
ticket lock? In the next patch, you have

+#if !defined(CONFIG_NUMA) && defined(CONFIG_QUEUED_SPINLOCKS)
+	static_branch_disable(&use_qspinlock_key);
+#endif

So the current config setting determines if qspinlock will be used, not 
some boot time parameter that user needs to specify. This patch will 
just add useless code to lock/unlock sites. I don't see any benefit of 
doing that.

Cheers,
Longman

