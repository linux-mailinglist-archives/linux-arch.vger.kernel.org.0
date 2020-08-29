Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FEA4256631
	for <lists+linux-arch@lfdr.de>; Sat, 29 Aug 2020 11:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbgH2JJe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 29 Aug 2020 05:09:34 -0400
Received: from mout.gmx.net ([212.227.17.20]:46331 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726258AbgH2JJ3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 29 Aug 2020 05:09:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1598692150;
        bh=LA8e3x7OTH7TmqUpRSk2U1gxj9jGzODKHY7UgSrCaC8=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=UZCInnwE+t5P0z8mWC0e962bsCtNuP+7fz1IV97jG6qozBFaJJRIOXO3ELstNrmM8
         /5YmRdkktxcbLfeaSIzenktDR0lM8JEASUsd6ZPFHQKM47UsiNivmKZFd43qFLV6aq
         oL2c0CNGzt45aT8daRS6odvsev6smIYy2ZGxaKnA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.169.105]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M8ykg-1kGsnj3Zhu-0066tf; Sat, 29
 Aug 2020 11:09:09 +0200
Subject: Re: [PATCH v2 15/23] parisc: use asm-generic/mmu_context.h for no-op
 implementations
To:     Nicholas Piggin <npiggin@gmail.com>, linux-arch@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Arnd Bergmann <arnd@arndb.de>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        linux-parisc@vger.kernel.org
References: <20200826145249.745432-1-npiggin@gmail.com>
 <20200826145249.745432-16-npiggin@gmail.com>
From:   Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
 c2TFWAS8k6RLkk41ZUU8ENX8+qZx/Q==
Message-ID: <05545df2-416a-a034-059a-a8404292143e@gmx.de>
Date:   Sat, 29 Aug 2020 11:09:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200826145249.745432-16-npiggin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MVu3F6cq3b3CpnuUMt96+KyaW7G8/TfrnMJKVxNZ3c+n5NTx0Ae
 t97uEKwepS/LVxjNOY/ELldLhFhU14cn55K0G6T7E59tPaU0dJLK5Qe9MqRCr7IcnbvU9Sq
 5JshNO7482QnBDtrkO+Zh1dNwBmutM+eE1XOY+uVptWyTTlQCLil5jlJd/kjiO1JPNhw/fx
 aVxXh4mini3Ri1j/zdI0A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:TjA0suBSCNU=:Z1eOmwhoqF8LfwOJofhBET
 TmJy5LJRJ9npHJpvWnTce1TAZb/b8hnvt+KtjuZ1RcxOpA5TO44kUE1Vjw458RAXbNdfOAso8
 6C/yNye0i4kmPmQlAUsc9aYoXBSkZmEhQS76DGBiTmXliQc4BOk2D4UMcEJpG6cW/zbPa3Vn5
 z0AbMjICenLNPhlqcE+g2ZoNMiIqft48c679m5MT88xPBuUdVwSITjRBKGnU3D4BAeCW/W53N
 XSHyTL7gg7wm2vuBRHjhrtlnWm+bDquTdWAQ4u4SnPV1Q8vYCLtOtB/4F1cUndeWxiRG219QL
 GvU9c1vSSZZakY2fNb6ROs05NsZnZUAYSgCsToZj4ykzVMgTGwe8NxoGMkQ47bZa1tAZOyZoI
 nN/HvWWqgjXJ5Q7kj2Qxbi+5BAxotfRk9U48g65XPMHo/eSB8fn43L3huwAxDcd6ub//oy59a
 ZwFE/uP7fNOpZTlFVsyuq3R8+/I5XLGSaqdX6uEwadGudgrW4VnrA4t7KyRDUZFt9Rl6BNA3g
 3me/mdHhIFrpUA9rVlXILWXwbrb8/b9/Sbq/xGX4aZR3sgsDWjzrlAWu3VfoBs51sEYeumi/R
 mf9eHcNvUoxH5yQkPDie6sJK+pNlfoWgkjUjyedGPph3k27I+MQO+DjvegyT0TX8vJY27prOJ
 VglHLCiHkDd6MUWi/7axv9nxqFMRN5eZcUDy3mWXSyMwRCyJtpYvXqd6P5sEq3RHEYwSwOAKE
 AS8czUxl3Vw6yM4arJxLduIcVUaXKiO524g+DV1K6FQKDnn6m6z1gb6CUZP2bf/849fn0Utsa
 QJ1ZHangVK039kyasJE+5XsG8eGDjcbge35aqEu9odQWIRBZwukyIXVjiMbnva6qLjas+M1g/
 TRn2JMtG3R6cIQirXUYwZh91tJrlOE6MBuRxErcvKtjM3qyWlN5xxkikDnUA37hJEYQXxtiQZ
 DxSI3j3UqUjEKULz8u0uMb4wR/fzVlfG4n8kTZVbVltzp2ud7u6YF8xjLMX39OHcOA2SpUfth
 TAPsOIBQ2wm5aq5i8NSvZVpqjo0W1wYdMCveeFjoUzt2+GojmIOLMIeOS/P2h0ZR/0t4mvq98
 6uFVY4xACwAovirnNdFlTVXfGfRrYCZVqSAfnnQ3xyczSbhk5VaauthQCa1Ns1RvAfSjEd55A
 pcMprEkJ32ENY5aucsDJnveQ6gSSA++v+DcuGGNO5f+FNBTKH7d3RGLAfWR5LtpvNQr3gVCGe
 PpHEY1TAz5KSV8aRE
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 26.08.20 16:52, Nicholas Piggin wrote:
> Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
> Cc: Helge Deller <deller@gmx.de>
> Cc: linux-parisc@vger.kernel.org
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Acked-by: Helge Deller <deller@gmx.de>

> ---
>  arch/parisc/include/asm/mmu_context.h | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/arch/parisc/include/asm/mmu_context.h b/arch/parisc/include=
/asm/mmu_context.h
> index cb5f2f730421..46f8c22c5977 100644
> --- a/arch/parisc/include/asm/mmu_context.h
> +++ b/arch/parisc/include/asm/mmu_context.h
> @@ -7,16 +7,13 @@
>  #include <linux/atomic.h>
>  #include <asm-generic/mm_hooks.h>
>
> -static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_str=
uct *tsk)
> -{
> -}
> -
>  /* on PA-RISC, we actually have enough contexts to justify an allocator
>   * for them.  prumpf */
>
>  extern unsigned long alloc_sid(void);
>  extern void free_sid(unsigned long);
>
> +#define init_new_context init_new_context
>  static inline int
>  init_new_context(struct task_struct *tsk, struct mm_struct *mm)
>  {
> @@ -26,6 +23,7 @@ init_new_context(struct task_struct *tsk, struct mm_st=
ruct *mm)
>  	return 0;
>  }
>
> +#define destroy_context destroy_context
>  static inline void
>  destroy_context(struct mm_struct *mm)
>  {
> @@ -71,8 +69,7 @@ static inline void switch_mm(struct mm_struct *prev,
>  }
>  #define switch_mm_irqs_off switch_mm_irqs_off
>
> -#define deactivate_mm(tsk,mm)	do { } while (0)
> -
> +#define activate_mm activate_mm
>  static inline void activate_mm(struct mm_struct *prev, struct mm_struct=
 *next)
>  {
>  	/*
> @@ -90,4 +87,7 @@ static inline void activate_mm(struct mm_struct *prev,=
 struct mm_struct *next)
>
>  	switch_mm(prev,next,current);
>  }
> +
> +#include <asm-generic/mmu_context.h>
> +
>  #endif
>

