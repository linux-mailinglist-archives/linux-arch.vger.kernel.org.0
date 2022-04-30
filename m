Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1E5515C17
	for <lists+linux-arch@lfdr.de>; Sat, 30 Apr 2022 12:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239446AbiD3KEY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 30 Apr 2022 06:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237334AbiD3KEX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 30 Apr 2022 06:04:23 -0400
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E64DF2B;
        Sat, 30 Apr 2022 03:01:02 -0700 (PDT)
Received: by mail-vk1-xa30.google.com with SMTP id s68so4746690vke.6;
        Sat, 30 Apr 2022 03:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=quV8WHZmDcS2wrGZmcNoLVVmjUJMCV+xLzyUcPnYrus=;
        b=WMCGgV8fNS4bMQz5MyebiYtV2S2mzseJP7omogbqGCOzS+DBQ6JSN57qiXOPZsqqMI
         li1POetQ1bXlyEna5PodIyobFVicN+6B35KE3XaqFv+yKWIV+rOoET7SGoQF6MC+OkIE
         EksoQoWC6NqJX0nWxUVpJUFS2DN3RMsFJQf+U7U51NsV1zYbgbOduOSymKbD3FwJ7cJR
         oGgQDfgzJEcKuynSWboSVh4eX2b8ZxzUViiSoDQxPD1rSMqCWjeBffwkiElXK0d0nSaU
         zdFCKIXZ5ho6V6924CInZpZKAiJI+71pdjaC+ekDqb2zb0LOn/F4KBQFflAwRiOR3cWz
         wTkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=quV8WHZmDcS2wrGZmcNoLVVmjUJMCV+xLzyUcPnYrus=;
        b=sjJo/qhtJjzP3zk5ZYfJvVw591APMsCK1aX8qiIkzWHuzKKAqQmOjtyQ3er9+o4m2V
         qlUD7jMRx1zRRSwp+1I05Igi2LMACpzYH15P1nbSO1siPmp3mwZD7eIQ0iZSe+Lw475P
         9s10je+Fc0ES2VuW9FzvMh2J+q8qw7hCFUxvLqKj5G5vVrNq8ZoH4qlBGXUiQuQ+B9Al
         RN1o4/54xtnI3R5fdp1VGETSxbebtJVZQ2XBd5EyNy0Wbj5j7CUc2xgmQOgHPc+WGxSk
         Kx9UnjLTB0oK7R6wZN5ErkYmtfMBK+R/btYei7Hp6Qyp3MGAipLTcrNrStfqd71TiSae
         e+aA==
X-Gm-Message-State: AOAM531TODuf7f7r5xbC+SgzQ9REr+/WJOmslvzaSPDMZl9Er22zDaXm
        g0ev/K943Mvy//4whURCqeWb221rLPk5Heg9Aic=
X-Google-Smtp-Source: ABdhPJz5pj02IH+rT1bQnVvZ1alBCZWLMt8WVaOEdirIYezrxPp1bDXegjtVPi5OaSfBvTY4MlffHqi3ZHlE+D/vun8=
X-Received: by 2002:a1f:3085:0:b0:348:e0b6:bd89 with SMTP id
 w127-20020a1f3085000000b00348e0b6bd89mr971547vkw.2.1651312861374; Sat, 30 Apr
 2022 03:01:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220430090518.3127980-1-chenhuacai@loongson.cn>
 <20220430090518.3127980-17-chenhuacai@loongson.cn> <CAK8P3a097Z_DKXbrLrCB7JZUB0J0duSmZRHSJkjRM5=rteit6g@mail.gmail.com>
In-Reply-To: <CAK8P3a097Z_DKXbrLrCB7JZUB0J0duSmZRHSJkjRM5=rteit6g@mail.gmail.com>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Sat, 30 Apr 2022 18:00:50 +0800
Message-ID: <CAAhV-H4COmSy1RNBKi1XCDerAhiQb1Z=g4rEmBz4xgLkSpKmmA@mail.gmail.com>
Subject: Re: [PATCH V9 16/24] LoongArch: Add misc common routines
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Arnd,

On Sat, Apr 30, 2022 at 5:50 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Sat, Apr 30, 2022 at 11:05 AM Huacai Chen <chenhuacai@loongson.cn> wrote:
>
> > +unsigned long __xchg_small(volatile void *ptr, unsigned long val, unsigned int size)
> > +{
> > +       u32 old32, mask, temp;
> > +       volatile u32 *ptr32;
> > +       unsigned int shift;
> > +
> > +       /* Check that ptr is naturally aligned */
>
> As discussed, please remove this function and all the references to it.
It seems that "generic ticket spinlock" hasn't been merged in 5.18?

Huacai
>
>       Arnd
