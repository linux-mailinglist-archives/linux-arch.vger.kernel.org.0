Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0194E3747
	for <lists+linux-arch@lfdr.de>; Tue, 22 Mar 2022 04:11:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235928AbiCVDML (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 21 Mar 2022 23:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235946AbiCVDMK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 21 Mar 2022 23:12:10 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 136DD50468;
        Mon, 21 Mar 2022 20:10:42 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id x2so823678plm.7;
        Mon, 21 Mar 2022 20:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Hh+l+cDJOH+rmHGFl5Z8Zd7K4dLUYHJocdz9v2HO6zA=;
        b=DjtmHKskX4TxeKbVb7A93JrGp2xt18gLwaV/CfU6iNuYFEdrAE1RP9ngjSmWlQq13X
         yHAxabQDUqqWL45RtLOICtJf40+Gw0+ps6Y9Uq1uM+L7l1QUKvFRirvhaJOrT/kAg/9X
         wNvXOLCWc4HE2YMGhHYgJ8xDGCbuo1qWdoXBThR4yz4nKi3EbI10zq7VCWwUZP44Znq5
         Ht1vQtGaa9S25e03tNwBJ5eR8sbMM2GdHdFFgFD8RHjkpInfUCZ1l+WWPm7viu8CUe5C
         aGh+Dea1u2wzHcWT4ZdW1u6zquKoTRTy4hix8MEkUKRaOqMESjh5vkUuC7SFEKzSVR4X
         hysA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Hh+l+cDJOH+rmHGFl5Z8Zd7K4dLUYHJocdz9v2HO6zA=;
        b=Ujlgh+Rw0I3ZL0C3wVGLgMZHloQdC45HFa4ldy3B+iOFX/M++3PCIl/R+60yOTR1cf
         1C6TkxwxzjnUc7p8u5IsaWGmgkovx2bLHPaGrVk9eN2sfM0+KaTMI+wV+BHDMoekiiJJ
         c7SMqK7ucza4qdJj/FRc68HkAXM3LY1MZKehMX8Tc/V0fb2/AE5WxFNUSGZ9CY6FS6yr
         noYQ7mhlYWvfL+RrNVzQrcD7eu0aPrXa6f/zmw8DQ5eyh2L2BnfprqZhtPii6lNuTPl+
         2aUFwPyAm+YasZaFwImekzz215UYfFP+y8xWnQbkQVOGMht8JXtJzkiyPDYYmmSt9hG6
         ToBg==
X-Gm-Message-State: AOAM532vn41Mku17htVz+hwX+tO/j8eNxPaLP/RV+fkP8MOyzECkDtFG
        jf4fYmR46zrax8OJ3HvoawY=
X-Google-Smtp-Source: ABdhPJzg61lhXH43T0oAx2tFK5dMDO7rgoTBBFqYh0KY+3YN04A1J1laQWvkvScPHw0opdbB0iyBtg==
X-Received: by 2002:a17:902:e9d3:b0:154:6dd6:2521 with SMTP id 19-20020a170902e9d300b001546dd62521mr5289232plk.59.1647918641193;
        Mon, 21 Mar 2022 20:10:41 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id s141-20020a632c93000000b0038134d09219sm16260355pgs.55.2022.03.21.20.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 20:10:37 -0700 (PDT)
Date:   Tue, 22 Mar 2022 12:10:36 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     guoren@kernel.org
Cc:     palmer@dabbelt.com, arnd@arndb.de, boqun.feng@gmail.com,
        longman@redhat.com, peterz@infradead.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, openrisc@lists.librecores.org,
        Palmer Dabbelt <palmer@rivosinc.com>,
        linux-riscv@lists.infradead.org
Subject: Re: [OpenRISC] [PATCH V2 1/5] asm-generic: ticket-lock: New generic
 ticket-based spinlock
Message-ID: <Yjk+LGwhc50zvsk2@antec>
References: <20220319035457.2214979-1-guoren@kernel.org>
 <20220319035457.2214979-2-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220319035457.2214979-2-guoren@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hello,

There is a problem with this patch on Big Endian machines, see below.

On Sat, Mar 19, 2022 at 11:54:53AM +0800, guoren@kernel.org wrote:
> From: Peter Zijlstra <peterz@infradead.org>
> 
> This is a simple, fair spinlock.  Specifically it doesn't have all the
> subtle memory model dependencies that qspinlock has, which makes it more
> suitable for simple systems as it is more likely to be correct.
> 
> [Palmer: commit text]
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> 
> --
> 
> I have specifically not included Peter's SOB on this, as he sent his
> original patch
> <https://lore.kernel.org/lkml/YHbBBuVFNnI4kjj3@hirez.programming.kicks-ass.net/>
> without one.
> ---
>  include/asm-generic/spinlock.h          | 11 +++-
>  include/asm-generic/spinlock_types.h    | 15 +++++
>  include/asm-generic/ticket-lock-types.h | 11 ++++
>  include/asm-generic/ticket-lock.h       | 86 +++++++++++++++++++++++++
>  4 files changed, 120 insertions(+), 3 deletions(-)
>  create mode 100644 include/asm-generic/spinlock_types.h
>  create mode 100644 include/asm-generic/ticket-lock-types.h
>  create mode 100644 include/asm-generic/ticket-lock.h
> 
> diff --git a/include/asm-generic/ticket-lock.h b/include/asm-generic/ticket-lock.h
> new file mode 100644
> index 000000000000..59373de3e32a
> --- /dev/null
> +++ b/include/asm-generic/ticket-lock.h

...

> +static __always_inline void ticket_unlock(arch_spinlock_t *lock)
> +{
> +	u16 *ptr = (u16 *)lock + __is_defined(__BIG_ENDIAN);

As mentioned, this patch series breaks SMP on OpenRISC.  I traced it to this
line.  The above `__is_defined(__BIG_ENDIAN)`  does not return 1 as expected
even on BIG_ENDIAN machines.  This works:


diff --git a/include/asm-generic/ticket-lock.h b/include/asm-generic/ticket-lock.h
index 59373de3e32a..52b5dc9ffdba 100644
--- a/include/asm-generic/ticket-lock.h
+++ b/include/asm-generic/ticket-lock.h
@@ -26,6 +26,7 @@
 #define __ASM_GENERIC_TICKET_LOCK_H
 
 #include <linux/atomic.h>
+#include <linux/kconfig.h>
 #include <asm-generic/ticket-lock-types.h>
 
 static __always_inline void ticket_lock(arch_spinlock_t *lock)
@@ -51,7 +52,7 @@ static __always_inline bool ticket_trylock(arch_spinlock_t *lock)
 
 static __always_inline void ticket_unlock(arch_spinlock_t *lock)
 {
-       u16 *ptr = (u16 *)lock + __is_defined(__BIG_ENDIAN);
+       u16 *ptr = (u16 *)lock + IS_ENABLED(CONFIG_CPU_BIG_ENDIAN);
        u32 val = atomic_read(lock);
 
        smp_store_release(ptr, (u16)val + 1);


> +	u32 val = atomic_read(lock);
> +
> +	smp_store_release(ptr, (u16)val + 1);
> +}
> +


