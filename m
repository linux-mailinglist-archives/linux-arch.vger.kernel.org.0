Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADEDB706174
	for <lists+linux-arch@lfdr.de>; Wed, 17 May 2023 09:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjEQHl7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 17 May 2023 03:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjEQHl6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 17 May 2023 03:41:58 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6305010E6;
        Wed, 17 May 2023 00:41:53 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-3f38c23b06eso3364831cf.3;
        Wed, 17 May 2023 00:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684309312; x=1686901312;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Gt8vcqfcBcSzFv5CqI8kXtZUiisqmIiLAVfG/Z4B1wo=;
        b=gNAni+aefYGCbzXJZ1KCoFg8ZVjbrHwK7u+sKWIsmjjGqQJ2bWNPSg+WakHJQVS3ab
         Bp5bqMntw1uQkVw+IN1lOsU4BFRNTNuMiq9ef5c1RW9TLIi66HUQpNRoz99rtQztmRGD
         KYnmVtSd+sNgymFummMsYYEpskLLZBxJnmkacqEQxSIDH8jjQDIifWpfH9ktAgm+tMoA
         l5xZHrVJnxwv1lhnl/gXppJABX//LI0ugS4VIj2bunZX7U1ejXCSJwy/Tf02yZh0TYX/
         2qa/8Rhqzrv1gtxn/rhiuEfjmYRrH3Jk4TsxNllrNjP6UscF1wHGQheDYKzJXyF9J7W6
         2Wiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684309312; x=1686901312;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gt8vcqfcBcSzFv5CqI8kXtZUiisqmIiLAVfG/Z4B1wo=;
        b=O4BYHxzEvATblTSSSlpOJLuQ4kAEho7zd5KcXofjc+THCL0MoOYhNMnHEsINaiMzMY
         8/gfZU6ToH1Vk3B+BTnXDm+K4OFWxDpQXiS0yYpXLs/ZRVDxbNUdoQnbfWfmiAOI2GwU
         DYvR7VyrseNN0cDnPGGZgNAEqQGWRyMeBVw9YEeN7phjgQAX/b4AN1k7N9nkLecpS3xA
         sZU9kI6PyxmI7L0L/EOSicDT782+s6Hsb+9Gpc5edF6ai1Ca5ORhXtZU9Iv0z1+n3crr
         vd7r0wcW115VM7ejZJhrEsWdCWbXTqu/rxUxO1XSfY2bbY/GkGa1a6WYiZ+mYq7J0Fz6
         deTw==
X-Gm-Message-State: AC+VfDwNnDyAUbXk6EDuKdwHea5oMUnnwALi3IIn2PjnSiD7eroUU819
        q+nJ47q78vMmJPsfR8bzalDjTaY5v8J7GXf1kls=
X-Google-Smtp-Source: ACHHUZ74fvUaQLS0H9Z1NeDqPl+csekVSshwiPDecXWRaUqETx8dIFlUfbpRHpQ/LDhjlhXM7ONSaWWLwZCTLV0Bubs=
X-Received: by 2002:ac8:580e:0:b0:3ef:52ac:10d2 with SMTP id
 g14-20020ac8580e000000b003ef52ac10d2mr66678755qtg.43.1684309312426; Wed, 17
 May 2023 00:41:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230405141710.3551-1-ubizjak@gmail.com> <20230405141710.3551-4-ubizjak@gmail.com>
In-Reply-To: <20230405141710.3551-4-ubizjak@gmail.com>
From:   Charlemagne Lasse <charlemagnelasse@gmail.com>
Date:   Wed, 17 May 2023 09:41:41 +0200
Message-ID: <CAFGhKbyxtuk=LoW-E3yLXgcmR93m+Dfo5-u9oQA_YC5Fcy_t9g@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] locking/arch: Wire up local_try_cmpxchg
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     linux-alpha@vger.kernel.org, loongarch@lists.linux.dev,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        x86@kernel.org, linux-arch@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Jun Yi <yijun@loongson.cn>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> +static __inline__ bool local_try_cmpxchg(local_t *l, long *old, long new)
> +{
> +       typeof(l->a.counter) *__old = (typeof(l->a.counter) *) old;
> +       return try_cmpxchg_local(&l->a.counter, __old, new);
> +}
> +

This patch then causes following sparse errors:

    ./arch/x86/include/asm/local.h:131:16: warning: symbol '__old'
shadows an earlier one
    ./arch/x86/include/asm/local.h:130:30: originally declared here

This is then visible in all kinds of builds - which makes it hard to
find out actual problems with sparse.
