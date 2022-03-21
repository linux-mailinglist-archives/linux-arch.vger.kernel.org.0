Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4726D4E225B
	for <lists+linux-arch@lfdr.de>; Mon, 21 Mar 2022 09:43:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345362AbiCUIoo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 21 Mar 2022 04:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243773AbiCUIon (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 21 Mar 2022 04:44:43 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BCE0BCA2
        for <linux-arch@vger.kernel.org>; Mon, 21 Mar 2022 01:43:17 -0700 (PDT)
Received: from mail-wm1-f45.google.com ([209.85.128.45]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MfYDO-1nyvcJ38VE-00fwNK for <linux-arch@vger.kernel.org>; Mon, 21 Mar
 2022 09:43:15 +0100
Received: by mail-wm1-f45.google.com with SMTP id l7-20020a05600c1d0700b0038c99618859so823697wms.2;
        Mon, 21 Mar 2022 01:43:15 -0700 (PDT)
X-Gm-Message-State: AOAM5318sSbofeVG/+hYaqRR+feFy6zuMzGjsVBqhEGZRhpUd6RzRR9B
        lS3Jq1NpY/4HqdgNfxh+NzgAWv5jAJ6NEDxGhGo=
X-Google-Smtp-Source: ABdhPJwHrKUKxYkZNzmmlwfspjQ9k/71XpCyBvdLMSQD+yuTHl2E5JvC+V3hbYc0A6xq6NZLQGug9dNQCUt046C6+7g=
X-Received: by 2002:a1c:f20b:0:b0:389:c99a:4360 with SMTP id
 s11-20020a1cf20b000000b00389c99a4360mr26314299wmc.174.1647852195434; Mon, 21
 Mar 2022 01:43:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220319142759.1026237-1-chenhuacai@loongson.cn>
 <20220319143817.1026708-1-chenhuacai@loongson.cn> <20220319143817.1026708-4-chenhuacai@loongson.cn>
In-Reply-To: <20220319143817.1026708-4-chenhuacai@loongson.cn>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 21 Mar 2022 09:42:59 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1ST1hBnhepvoQ9UTbAM=56JEU=-OiBAFQeK2rgaZ5aWw@mail.gmail.com>
Message-ID: <CAK8P3a1ST1hBnhepvoQ9UTbAM=56JEU=-OiBAFQeK2rgaZ5aWw@mail.gmail.com>
Subject: Re: [PATCH V8 11/22] LoongArch: Add process management
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>,
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
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:RBq5plTSvL7jyjPFW+cXGPvNSSi/CW9qVdYnu3tM5HNCd33I4DZ
 6Ok4f57u8tnj1/KviJfMtSNVjqRwT4DZl0JvhaUkp8vYhblnj4FrqbbfA3M4ZAqrhn3vn0D
 v7ymKiP1pWsirGOkkD9AbQjmcKgmQmLwzdmS0Y3u3O898+KzqZlgzkkhzQz6q+xQXPnWfQ4
 3HHZB3NL4p2dk9kcBWRRA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EDr6Dai2+yI=:gFf/900yRXqs4m9P9GqrgX
 oyMQEFJT69HIbPGluigHKkJWrFAlpq7mhngog2Djjzhwy7t6v/H6DVrvadgj7wAqqhT9z5nXR
 G2MFW8vcv6v+LWUozX7ywDLPddxauH8R0UHaQlTnViWPo6/sKS8Vq8wNlAR2TOyQ42Dh7QKj/
 w1XFxUGzMGeK1seDFs/EueMRf1H98E+AzUw+H1x2YovBhB381SndWkkpOKwGlBN4oju8uARf+
 kdT0G0HM/8+q0Q5U3kmY35yj6QLxxglXTIrN89cwGVWPvUH3O9jN7PnmpKUkoWe5PywDxtUc2
 d+CgkDuxOEYPyuiZ4C2hqyBVd7gPfM/ec9pnwMQZGB4xcjSnG0iNDogrngtbnXiX+Lll1EibO
 T3XmJNL1C+2RKnwaOGcKFWZn2ujq+ZZ/4MwN/mDjc085NLHwpMRQs1hR6NxEx2f8u0yzCDrx0
 /lYxmkl1ZEPvoACsyWuFVeK2jmCtnwuf4+LI0OqTAE4mX3T6KtNEXQtjfGiTkXjwJT5nQ3IuH
 X/M6r23QueFqBd3CCbPwJRA+CMd/J2Vrik5nzTX7sirZqODYHbIL69LA6ThWA0xknjGP9VwTm
 Vtblq833mWIn3BrPovy6WfsuCbDEdFYexYpmyGtpEYtz4l6OSPx/jTXnIr+5nTZTGfbJd4+x/
 qXD2esFw+lgXtQudjGRgRtL3MhZ0a8azrQRMtcJq/aZUpqGLVIUNK0UFNt/qY+Nha76wfGCtH
 OZwBi3oqmBmRanxM2ZgF8YKrCEpvV0Z85Gwb37sj7+pBWC8PNtDNovFjFSB5+EUY8IyWCOtBL
 jDi1lBgjB22S2ZVRdG1RFnah3kpxVOelu8xa3mWs/Co0pLUNFZSH7tywQ98bm3Hk6eoO9n1+f
 SxT3Qt4mH3jaRp4/5j2+SbvdJ1dvndfguCZgaxffc9utEfiPQ/HhWucRjWr4/hCPqe2lcU5FI
 FLrxN4PnpXQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Mar 19, 2022 at 3:38 PM Huacai Chen <chenhuacai@kernel.org> wrote:

> +#ifdef CONFIG_PAGE_SIZE_64KB
> +#define THREAD_SIZE_ORDER (0)
> +#endif
> +
> +#define THREAD_SIZE (PAGE_SIZE << THREAD_SIZE_ORDER)
> +#define THREAD_MASK (THREAD_SIZE - 1UL)
> +

Having a 64KB stack area is rather wasteful. I think you should use a sub-page
allocation in this configuration, or possibly disallow 64KB page configuration
entirely.

Note that you have to use full pages when using CONFIG_VMAP_STACK, but
you don't seem to support that at the moment, so allocating only 16KB stacks
on a 64KB page config should still work.

       Arnd
