Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB9E515B1B
	for <lists+linux-arch@lfdr.de>; Sat, 30 Apr 2022 09:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbiD3Hzb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 30 Apr 2022 03:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiD3Hza (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 30 Apr 2022 03:55:30 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 161FA4BFD1;
        Sat, 30 Apr 2022 00:52:09 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id h12so8906816plf.12;
        Sat, 30 Apr 2022 00:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bDVSZwPRgcAPJ3fWKSzR6sElFikHXLwmOFE7dJ7yN/I=;
        b=cBvuaGmInnkqUkO0kS3bKHO4L9FR56pjEwE1demPcEhzi4K0j5S/88Cvsqk/k+Inec
         HRNetMhU3zxfoHzCqM8kX568jD8Dtk8BgoHBbxGb1+5Lfut0JnkbfZDqadABIRQCFVU8
         Wo8HnY8dAuKrV4Zk3L0bKRoGE+7tBTVFhdpSpChcwqKwSoBfgopMEv8GbFIxW/ajrKuH
         Kjcps/SLOfTCowCaf9zG6VUOTe+uKTf59l/KkuTkrcHBWGJhBpP+3yDdjMEW5Seg+W+H
         rMvSXfYuTQtuhfcIFZvf5onF37T127wCsbqJZEKo/CMeGotJDXQAfMH4oQ4CP83apdSw
         sFvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bDVSZwPRgcAPJ3fWKSzR6sElFikHXLwmOFE7dJ7yN/I=;
        b=rjHqqLWVrx3rLBYMoBQQwYySUKNAx0b7vcPquHqstLZ+Fy/8eERBix3xtaPwAN/1Rm
         32neQlgmzCeyDLMgax1HtYWiSLYK0BL7m76PMgaNwyvzvhmli62kGriLpOPIKqdn+7Ii
         JfxhF6hUzGDQHzmj6EPYoddCxbTGdlsMVLwE8T3oxJB/zmNbOFo3j8/WO4DNc5tL+qgN
         WaYfRTFXRDZtMyXESX9WlFyey8u2o+k7mE7+EUxLzsrDwSHZVDsvmR3w9d+i/QK85W+q
         Z5PIVSei+DDa7tsEilNZCW1xtIg8kBorFeKj4/bfQhgFxsLzlAPbEXxl/p82GdBA8cDT
         DqGw==
X-Gm-Message-State: AOAM530oGJYzA+9pVIEcand+CrAox/axxychlAl79KdANkGkB8sn3SuJ
        9rQwcArEMqw9IOvIVHHUrRY=
X-Google-Smtp-Source: ABdhPJyRLygBdsWCWCiMOr7lmCiKPgf60Yhl9qtmmd4xMBQ4UAqn4VA2VymZU0SJZeL72jYgAdA+ZA==
X-Received: by 2002:a17:903:246:b0:153:87f0:a93e with SMTP id j6-20020a170903024600b0015387f0a93emr2969288plh.171.1651305128433;
        Sat, 30 Apr 2022 00:52:08 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id n5-20020a170903110500b0015e8d4eb252sm851999plh.156.2022.04.30.00.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Apr 2022 00:52:07 -0700 (PDT)
Date:   Sat, 30 Apr 2022 16:52:05 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, heiko@sntech.de, guoren@kernel.org,
        peterz@infradead.org, mingo@redhat.com,
        Will Deacon <will@kernel.org>, longman@redhat.com,
        boqun.feng@gmail.com, jonas@southpole.se,
        stefan.kristiansson@saunalahti.fi,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        macro@orcam.me.uk, Greg KH <gregkh@linuxfoundation.org>,
        sudipm.mukherjee@gmail.com, wangkefeng.wang@huawei.com,
        jszhang@kernel.org, linux-csky@vger.kernel.org,
        linux-kernel@vger.kernel.org, openrisc@lists.librecores.org,
        linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v3 4/7] openrisc: Move to ticket-spinlock
Message-ID: <YmzqpVCEenOXRTga@antec>
References: <20220414220214.24556-1-palmer@rivosinc.com>
 <20220414220214.24556-5-palmer@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220414220214.24556-5-palmer@rivosinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Apr 14, 2022 at 03:02:11PM -0700, Palmer Dabbelt wrote:
> From: Peter Zijlstra <peterz@infradead.org>
> 
> We have no indications that openrisc meets the qspinlock requirements,
> so move to ticket-spinlock as that is more likey to be correct.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> ---
>  arch/openrisc/Kconfig                      |  1 -
>  arch/openrisc/include/asm/Kbuild           |  5 ++--
>  arch/openrisc/include/asm/spinlock.h       | 27 ----------------------
>  arch/openrisc/include/asm/spinlock_types.h |  7 ------
>  4 files changed, 2 insertions(+), 38 deletions(-)
>  delete mode 100644 arch/openrisc/include/asm/spinlock.h
>  delete mode 100644 arch/openrisc/include/asm/spinlock_types.h
> 
> diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
> index 0d68adf6e02b..99f0e4a4cbbd 100644
> --- a/arch/openrisc/Kconfig
> +++ b/arch/openrisc/Kconfig
> @@ -30,7 +30,6 @@ config OPENRISC
>  	select HAVE_DEBUG_STACKOVERFLOW
>  	select OR1K_PIC
>  	select CPU_NO_EFFICIENT_FFS if !OPENRISC_HAVE_INST_FF1
> -	select ARCH_USE_QUEUED_SPINLOCKS
>  	select ARCH_USE_QUEUED_RWLOCKS
>  	select OMPIC if SMP
>  	select ARCH_WANT_FRAME_POINTERS
> diff --git a/arch/openrisc/include/asm/Kbuild b/arch/openrisc/include/asm/Kbuild
> index ca5987e11053..3386b9c1c073 100644
> --- a/arch/openrisc/include/asm/Kbuild
> +++ b/arch/openrisc/include/asm/Kbuild
> @@ -1,9 +1,8 @@
>  # SPDX-License-Identifier: GPL-2.0
>  generic-y += extable.h
>  generic-y += kvm_para.h
> -generic-y += mcs_spinlock.h
> -generic-y += qspinlock_types.h
> -generic-y += qspinlock.h
> +generic-y += spinlock_types.h
> +generic-y += spinlock.h
>  generic-y += qrwlock_types.h
>  generic-y += qrwlock.h
>  generic-y += user.h
> diff --git a/arch/openrisc/include/asm/spinlock.h b/arch/openrisc/include/asm/spinlock.h
> deleted file mode 100644
> index 264944a71535..000000000000
> --- a/arch/openrisc/include/asm/spinlock.h
> +++ /dev/null
> @@ -1,27 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-or-later */
> -/*
> - * OpenRISC Linux
> - *
> - * Linux architectural port borrowing liberally from similar works of
> - * others.  All original copyrights apply as per the original source
> - * declaration.
> - *
> - * OpenRISC implementation:
> - * Copyright (C) 2003 Matjaz Breskvar <phoenix@bsemi.com>
> - * Copyright (C) 2010-2011 Jonas Bonn <jonas@southpole.se>
> - * et al.
> - */
> -
> -#ifndef __ASM_OPENRISC_SPINLOCK_H
> -#define __ASM_OPENRISC_SPINLOCK_H
> -
> -#include <asm/qspinlock.h>
> -
> -#include <asm/qrwlock.h>
> -
> -#define arch_spin_relax(lock)	cpu_relax()
> -#define arch_read_relax(lock)	cpu_relax()
> -#define arch_write_relax(lock)	cpu_relax()
> -
> -
> -#endif
> diff --git a/arch/openrisc/include/asm/spinlock_types.h b/arch/openrisc/include/asm/spinlock_types.h
> deleted file mode 100644
> index 7c6fb1208c88..000000000000
> --- a/arch/openrisc/include/asm/spinlock_types.h
> +++ /dev/null
> @@ -1,7 +0,0 @@
> -#ifndef _ASM_OPENRISC_SPINLOCK_TYPES_H
> -#define _ASM_OPENRISC_SPINLOCK_TYPES_H
> -
> -#include <asm/qspinlock_types.h>
> -#include <asm/qrwlock_types.h>
> -
> -#endif /* _ASM_OPENRISC_SPINLOCK_TYPES_H */

Thanks for this, a bit late but.

Acked-by: Stafford Horne <shorne@gmail.com>

