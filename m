Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACA037694C5
	for <lists+linux-arch@lfdr.de>; Mon, 31 Jul 2023 13:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbjGaL1b (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 31 Jul 2023 07:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbjGaL1a (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 31 Jul 2023 07:27:30 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E518F125;
        Mon, 31 Jul 2023 04:27:24 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.170])
        by gateway (Coremail) with SMTP id _____8Dxg_CamsdkXjgNAA--.31654S3;
        Mon, 31 Jul 2023 19:27:22 +0800 (CST)
Received: from [10.20.42.170] (unknown [10.20.42.170])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Cx7yOXmsdk11lCAA--.2410S3;
        Mon, 31 Jul 2023 19:27:19 +0800 (CST)
Message-ID: <cd1a8791-a524-8813-c70d-2adb4e6c5471@loongson.cn>
Date:   Mon, 31 Jul 2023 19:27:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH V2] asm-generic: ticket-lock: Optimize
 arch_spin_value_unlocked
Content-Language: en-US
To:     guoren@kernel.org, David.Laight@ACULAB.COM, will@kernel.org,
        peterz@infradead.org, mingo@redhat.com, longman@redhat.com
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>
References: <20230731023308.3748432-1-guoren@kernel.org>
From:   bibo mao <maobibo@loongson.cn>
In-Reply-To: <20230731023308.3748432-1-guoren@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Cx7yOXmsdk11lCAA--.2410S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7CFW5Zw13CrWDAF4rWF18Xrc_yoW8Kw1Upr
        98CFs3AF47CFykZFZFyF42vr1rJwsF9r18ur90gwn2yFsrX3s5KanY9rn0vr1jk3WxKrsx
        XFW2gFy5uayjyFXCm3ZEXasCq-sJn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUPab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
        AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
        AVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
        8JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vI
        r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67
        AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
        rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14
        v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWx
        JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUcbAwUU
        UUU
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



在 2023/7/31 10:33, guoren@kernel.org 写道:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> The arch_spin_value_unlocked would cause an unnecessary memory
> access to the contended value. Although it won't cause a significant
> performance gap in most architectures, the arch_spin_value_unlocked
> argument contains enough information. Thus, remove unnecessary
> atomic_read in arch_spin_value_unlocked().
> 
> The caller of arch_spin_value_unlocked() could benefit from this
> change. Currently, the only caller is lockref.
> 
> Signed-off-by: Guo Ren <guoren@kernel.org>
> Cc: Waiman Long <longman@redhat.com>
> Cc: David Laight <David.Laight@ACULAB.COM>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> ---
> Changelog
> V2:
>  - Fixup commit log with Waiman advice.
>  - Add Waiman comment in the commit msg.
> ---
>  include/asm-generic/spinlock.h | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/include/asm-generic/spinlock.h b/include/asm-generic/spinlock.h
> index fdfebcb050f4..90803a826ba0 100644
> --- a/include/asm-generic/spinlock.h
> +++ b/include/asm-generic/spinlock.h
> @@ -68,11 +68,18 @@ static __always_inline void arch_spin_unlock(arch_spinlock_t *lock)
>  	smp_store_release(ptr, (u16)val + 1);
>  }
>  
> +static __always_inline int arch_spin_value_unlocked(arch_spinlock_t lock)
> +{
> +	u32 val = lock.counter;
> +
> +	return ((val >> 16) == (val & 0xffff));
> +}
I do not know much about lock, will it be cached in register without memory
access again like READ_ONCE or atomic_read?

Regards
Bibo Mao
> +
>  static __always_inline int arch_spin_is_locked(arch_spinlock_t *lock)
>  {
> -	u32 val = atomic_read(lock);
> +	arch_spinlock_t val = READ_ONCE(*lock);
>  
> -	return ((val >> 16) != (val & 0xffff));
> +	return !arch_spin_value_unlocked(val);
>  }
>  
>  static __always_inline int arch_spin_is_contended(arch_spinlock_t *lock)
> @@ -82,11 +89,6 @@ static __always_inline int arch_spin_is_contended(arch_spinlock_t *lock)
>  	return (s16)((val >> 16) - (val & 0xffff)) > 1;
>  }
>  
> -static __always_inline int arch_spin_value_unlocked(arch_spinlock_t lock)
> -{
> -	return !arch_spin_is_locked(&lock);
> -}
> -
>  #include <asm/qrwlock.h>
>  
>  #endif /* __ASM_GENERIC_SPINLOCK_H */

