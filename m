Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33E093F8C70
	for <lists+linux-arch@lfdr.de>; Thu, 26 Aug 2021 18:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbhHZQuQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 26 Aug 2021 12:50:16 -0400
Received: from mengyan1223.wang ([89.208.246.23]:59078 "EHLO mengyan1223.wang"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229880AbhHZQuQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 26 Aug 2021 12:50:16 -0400
X-Greylist: delayed 324 seconds by postgrey-1.27 at vger.kernel.org; Thu, 26 Aug 2021 12:50:16 EDT
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@mengyan1223.wang)
        by mengyan1223.wang (Postfix) with ESMTPSA id 4CBF26594D;
        Thu, 26 Aug 2021 12:44:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mengyan1223.wang;
        s=mail; t=1629996244;
        bh=ZN1VZGsuQbCAerDXrUvjtinCGdCO31eQerED68KhhF0=;
        h=Subject:From:Reply-To:To:Cc:Date:In-Reply-To:References:From;
        b=q1qXV4fJ+NFcPNVMXa3Eucy47UtKa2X5YxqbXmephv+aJNBEGbZ4dADTTaSnDxhPu
         XkU0zzfczXa8XcSjZ21rStzMWh9jsqY08VJQ/ATG7lI2fm6WKTEIxWdDF/pyUVisLV
         jGN8gEefz95HwFTEeCrf/cPHTBCTCrTL4I246CDvMTOC6kwQuLduHgVeGSlrZIhhne
         1KIRQQnfawDhyQrf4TBvmrIC+JbJUi4MNlk31alrxSnqE3C3Bz4wINWeJSg7ZAHHfE
         Wfm2dohpkuCKNh1cf7MAgE3Oagv3+plLEQmQjVgCOpciuWC6p8WJz0nWIf/kzgTnzn
         ekO2KmBw0xP/g==
Message-ID: <df1260f044186d0bbb56b297c88ac3658a888f98.camel@mengyan1223.wang>
Subject: Re: [PATCH 10/19] LoongArch: Add signal handling support
From:   Xi Ruoyao <xry111@mengyan1223.wang>
Reply-To: Xi Ruoyao <xry111@mengyan1223.wang>
To:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Xi Ruoyao <xry111@mengyan1223.wang>
Date:   Fri, 27 Aug 2021 00:43:58 +0800
In-Reply-To: <20210706041820.1536502-11-chenhuacai@loongson.cn>
References: <20210706041820.1536502-1-chenhuacai@loongson.cn>
         <20210706041820.1536502-11-chenhuacai@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 2021-07-06 at 12:18 +0800, Huacai Chen wrote:

> +/**
> + * struct ucontext - user context structure
> + * @uc_flags:
> + * @uc_link:
> + * @uc_stack:
> + * @uc_mcontext:       holds basic processor state
> + * @uc_sigmask:
> + * @uc_extcontext:     holds extended processor state
> + */
> +struct ucontext {
> +       /* Historic fields matching asm-generic */
> +       unsigned long           uc_flags;
> +       struct ucontext         *uc_link;
> +       stack_t                 uc_stack;
> +       struct sigcontext       uc_mcontext;
> +       sigset_t                uc_sigmask;
> +
> +       /* Extended context structures may follow ucontext */
> +       unsigned long long      uc_extcontext[0];
> +};
> +
> +#endif /* __LOONGARCH_UAPI_ASM_UCONTEXT_H */

Hi Huacai,

Maybe this is off topic, but I just seen something damn particular in
your workmates' glibc repo:

https://github.com/loongson/glibc/commit/86d7512949640642cdf767fb6beb077d446b2857
"Modify struct mcontext_t and ucontext_t layout":

> @@ -75,8 +73,8 @@ typedef struct ucontext_t
>    unsigned long int __uc_flags;
>    struct ucontext_t *uc_link;
>    stack_t uc_stack;
> -  mcontext_t uc_mcontext;
>    sigset_t uc_sigmask;
> +  mcontext_t uc_mcontext;
>  } ucontext_t;

AFAIK if this doesn't match the struct ucontext definition above, the
system will just blow up?  Have you coordinated with the change?

