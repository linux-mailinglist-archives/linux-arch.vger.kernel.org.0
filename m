Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4003B4DE445
	for <lists+linux-arch@lfdr.de>; Fri, 18 Mar 2022 23:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241380AbiCRWtk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Mar 2022 18:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241383AbiCRWti (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Mar 2022 18:49:38 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A79D11777D9
        for <linux-arch@vger.kernel.org>; Fri, 18 Mar 2022 15:48:18 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d18so8207431plr.6
        for <linux-arch@vger.kernel.org>; Fri, 18 Mar 2022 15:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=udZZwCkDvht+/ZkTVpsoov30eC/vSqk3+YzF/CtgcQo=;
        b=sK5EqUes8d1oJOXfxUzYGp9+QruHGINR3qWOR7SRTDQu8Fd0WzF8gkI5j8Lh7PNNmu
         TrE+w1H9yumVErYj1LEY4HqILtkJ5DBxebo9yUvw1u6aO8pKI19uRBS9Z9phinJeUh7V
         Pb0N7TFf83eDyx29IgXm5P3Z32Kd5kZ4ieG65+IS5c9eA5H+x0zaeRLY23ymQOQnvChX
         6IB0n2M78pBJAE4jfc9poKP4Z0TbIFiZjRy7dWo9Q8NAyixN277LrHE2bUpla0MA6GsG
         1O7uzt8ZuwBFP201/weLwvxeDKuZlLiym/B76RKDph/A55LySFhhKJ44FHFAkFp+eYw5
         t+rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=udZZwCkDvht+/ZkTVpsoov30eC/vSqk3+YzF/CtgcQo=;
        b=NLN92mDniTMijr5Dh/d1iLrvUQPYbm6AcoQELNF0fxNjmIe0fgzK0Aaj87km+tjX84
         WRoQCA+xZWEqrxd2Ahvmt2WpdKgRnmk69t3Dh+c6ZYDhquiyhRmKaZbEnTdzAEG9hJqH
         mOyBijHHW9K359yMHPOuZKVQmfj5yX/wyzdMkgk5HpQgWbAs83DAL7SzCFLfGhemxrG+
         eOdrKHruxRmzg3Bnxyugw9etwuJ54lWNm/jEU7bP9TBXc2z2lyBQ8jocZrLR881xmYrM
         6TwcAFqh5uZzyy9cSYvcvFNLImuqw5VbiCEAo+fp5X14N5fP6U2U5OB9l1A/SY7B6k7v
         16nw==
X-Gm-Message-State: AOAM533k1Y+km47708qCYjNxpG3AP3LDYXGddALwE5n7vHSnzn8jFmBh
        qEAtbrhlOR9Ca5NcXjfPYhnZ7w==
X-Google-Smtp-Source: ABdhPJzWPKoQuuwqidSyMnypTwE1jeYVoH5MRZ0FWHGrRq670xsv5stem+CyVLANVs604KAHxC6kZA==
X-Received: by 2002:a17:902:ce08:b0:153:8d90:a109 with SMTP id k8-20020a170902ce0800b001538d90a109mr1744437plg.157.1647643698169;
        Fri, 18 Mar 2022 15:48:18 -0700 (PDT)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id w8-20020a63a748000000b0038117e18f02sm8301624pgo.29.2022.03.18.15.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 15:48:17 -0700 (PDT)
Date:   Fri, 18 Mar 2022 15:48:17 -0700 (PDT)
X-Google-Original-Date: Fri, 18 Mar 2022 15:48:15 PDT (-0700)
Subject:     Re: [PATCH] csky: Move to generic ticket-spinlock
In-Reply-To: <20220318083421.2062259-1-guoren@kernel.org>
CC:     linux-csky@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, guoren@linux.alibaba.com
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     guoren@kernel.org
Message-ID: <mhng-88509dbf-71a1-495a-84a7-3dffef8c77a5@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 18 Mar 2022 01:34:21 PDT (-0700), guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
>
> There is no benefit from custom implementation for ticket-spinlock,
> so move to generic ticket-spinlock for easy maintenance.
>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Cc: Palmer Dabbelt <palmer@rivosinc.com>

Thanks, one less port to look at ;)

Looks like there were a few comments on the v1, and I wasn't going to 
target this at the upcoming merge window anyway because I wanted to give 
the various RISC-V vendors time to test stuff.  LMK if you want me to 
add this to the others, but I was planning on posting a stable tag 
either way so no big deal on my end.

> ---
>  arch/csky/include/asm/Kbuild           |  2 +
>  arch/csky/include/asm/spinlock.h       | 82 +-------------------------
>  arch/csky/include/asm/spinlock_types.h | 20 +------
>  3 files changed, 4 insertions(+), 100 deletions(-)
>
> diff --git a/arch/csky/include/asm/Kbuild b/arch/csky/include/asm/Kbuild
> index 904a18a818be..d94434288c31 100644
> --- a/arch/csky/include/asm/Kbuild
> +++ b/arch/csky/include/asm/Kbuild
> @@ -3,6 +3,8 @@ generic-y += asm-offsets.h
>  generic-y += extable.h
>  generic-y += gpio.h
>  generic-y += kvm_para.h
> +generic-y += ticket-lock.h
> +generic-y += ticket-lock-types.h
>  generic-y += qrwlock.h
>  generic-y += user.h
>  generic-y += vmlinux.lds.h
> diff --git a/arch/csky/include/asm/spinlock.h b/arch/csky/include/asm/spinlock.h
> index 69f5aa249c5f..8bc179ba0d8d 100644
> --- a/arch/csky/include/asm/spinlock.h
> +++ b/arch/csky/include/asm/spinlock.h
> @@ -3,87 +3,7 @@
>  #ifndef __ASM_CSKY_SPINLOCK_H
>  #define __ASM_CSKY_SPINLOCK_H
>
> -#include <linux/spinlock_types.h>
> -#include <asm/barrier.h>
> -
> -/*
> - * Ticket-based spin-locking.
> - */
> -static inline void arch_spin_lock(arch_spinlock_t *lock)
> -{
> -	arch_spinlock_t lockval;
> -	u32 ticket_next = 1 << TICKET_NEXT;
> -	u32 *p = &lock->lock;
> -	u32 tmp;
> -
> -	asm volatile (
> -		"1:	ldex.w		%0, (%2) \n"
> -		"	mov		%1, %0	 \n"
> -		"	add		%0, %3	 \n"
> -		"	stex.w		%0, (%2) \n"
> -		"	bez		%0, 1b   \n"
> -		: "=&r" (tmp), "=&r" (lockval)
> -		: "r"(p), "r"(ticket_next)
> -		: "cc");
> -
> -	while (lockval.tickets.next != lockval.tickets.owner)
> -		lockval.tickets.owner = READ_ONCE(lock->tickets.owner);
> -
> -	smp_mb();
> -}
> -
> -static inline int arch_spin_trylock(arch_spinlock_t *lock)
> -{
> -	u32 tmp, contended, res;
> -	u32 ticket_next = 1 << TICKET_NEXT;
> -	u32 *p = &lock->lock;
> -
> -	do {
> -		asm volatile (
> -		"	ldex.w		%0, (%3)   \n"
> -		"	movi		%2, 1	   \n"
> -		"	rotli		%1, %0, 16 \n"
> -		"	cmpne		%1, %0     \n"
> -		"	bt		1f         \n"
> -		"	movi		%2, 0	   \n"
> -		"	add		%0, %0, %4 \n"
> -		"	stex.w		%0, (%3)   \n"
> -		"1:				   \n"
> -		: "=&r" (res), "=&r" (tmp), "=&r" (contended)
> -		: "r"(p), "r"(ticket_next)
> -		: "cc");
> -	} while (!res);
> -
> -	if (!contended)
> -		smp_mb();
> -
> -	return !contended;
> -}
> -
> -static inline void arch_spin_unlock(arch_spinlock_t *lock)
> -{
> -	smp_mb();
> -	WRITE_ONCE(lock->tickets.owner, lock->tickets.owner + 1);
> -}
> -
> -static inline int arch_spin_value_unlocked(arch_spinlock_t lock)
> -{
> -	return lock.tickets.owner == lock.tickets.next;
> -}
> -
> -static inline int arch_spin_is_locked(arch_spinlock_t *lock)
> -{
> -	return !arch_spin_value_unlocked(READ_ONCE(*lock));
> -}
> -
> -static inline int arch_spin_is_contended(arch_spinlock_t *lock)
> -{
> -	struct __raw_tickets tickets = READ_ONCE(lock->tickets);
> -
> -	return (tickets.next - tickets.owner) > 1;
> -}
> -#define arch_spin_is_contended	arch_spin_is_contended
> -
> +#include <asm/ticket-lock.h>
>  #include <asm/qrwlock.h>
>
>  #endif /* __ASM_CSKY_SPINLOCK_H */
> diff --git a/arch/csky/include/asm/spinlock_types.h b/arch/csky/include/asm/spinlock_types.h
> index db87a12c3827..0bb7f6022a3b 100644
> --- a/arch/csky/include/asm/spinlock_types.h
> +++ b/arch/csky/include/asm/spinlock_types.h
> @@ -3,25 +3,7 @@
>  #ifndef __ASM_CSKY_SPINLOCK_TYPES_H
>  #define __ASM_CSKY_SPINLOCK_TYPES_H
>
> -#ifndef __LINUX_SPINLOCK_TYPES_RAW_H
> -# error "please don't include this file directly"
> -#endif
> -
> -#define TICKET_NEXT	16
> -
> -typedef struct {
> -	union {
> -		u32 lock;
> -		struct __raw_tickets {
> -			/* little endian */
> -			u16 owner;
> -			u16 next;
> -		} tickets;
> -	};
> -} arch_spinlock_t;
> -
> -#define __ARCH_SPIN_LOCK_UNLOCKED	{ { 0 } }
> -
> +#include <asm/ticket-lock-types.h>
>  #include <asm-generic/qrwlock_types.h>
>
>  #endif /* __ASM_CSKY_SPINLOCK_TYPES_H */
