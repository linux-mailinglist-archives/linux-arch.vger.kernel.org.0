Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A02B35162C4
	for <lists+linux-arch@lfdr.de>; Sun,  1 May 2022 10:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245289AbiEAIhO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 1 May 2022 04:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245223AbiEAIhO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 1 May 2022 04:37:14 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4022C1ADA9;
        Sun,  1 May 2022 01:33:48 -0700 (PDT)
Received: from mail-yw1-f175.google.com ([209.85.128.175]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MXp1Q-1nLlhf1EYG-00Y9J0; Sun, 01 May 2022 10:33:47 +0200
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-2f7c424c66cso122625357b3.1;
        Sun, 01 May 2022 01:33:46 -0700 (PDT)
X-Gm-Message-State: AOAM533k9kFTTG4MJ3KeAtcE/p3KbXo9IY6TP/yDjxc07BhxaHvGH3og
        FDomw6R4yVA0cIk/Vd+7fCzNAsurCinjojOiqMc=
X-Google-Smtp-Source: ABdhPJx7EkELZrBAmPjNc/73odhjEgqgTI5PwY7c4bA/A+enkyNER6K6fXqCt4wvYWQxX6D6K32sBvkhhAy1mpKvnE4=
X-Received: by 2002:a81:5594:0:b0:2f8:f39c:4cfc with SMTP id
 j142-20020a815594000000b002f8f39c4cfcmr3827327ywb.495.1651394025779; Sun, 01
 May 2022 01:33:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220430090518.3127980-1-chenhuacai@loongson.cn>
 <20220430090518.3127980-22-chenhuacai@loongson.cn> <CAK8P3a0LwJ3mMQMFkxGxr+umCMM3dKGRnLF+dMCmD5j43hq2sA@mail.gmail.com>
 <CAAhV-H6vPdLeup38YTj64Xxxk+PTact=DMJTs9efsa1b3t-y2A@mail.gmail.com>
In-Reply-To: <CAAhV-H6vPdLeup38YTj64Xxxk+PTact=DMJTs9efsa1b3t-y2A@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sun, 1 May 2022 10:33:29 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0E7P_TOJsT9=+O56L2=oyeMGckTvkb4OnK1MPcETLdtg@mail.gmail.com>
Message-ID: <CAK8P3a0E7P_TOJsT9=+O56L2=oyeMGckTvkb4OnK1MPcETLdtg@mail.gmail.com>
Subject: Re: [PATCH V9 21/24] LoongArch: Add zboot (compressed kernel) support
To:     Huacai Chen <chenhuacai@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@loongson.cn>,
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
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:src+v3wBVklFZE1E4lfrlLne3rNdSOB4FX3sLApOQfv8Gs2B0tj
 pOq2uSS8e7pNBa1C6K7GM034WtoPrgJU7RFx4/cuwsLgGX3K8e4hWw24lIc9azQ4bBw1Rbl
 gqTI94TCqgHO2NwQBDfIQBILO5+lF0WNqx8q0Cenyi4rAucuWXdNfTU6WvafvAdPfgQK4yr
 vONUXt3vHmABjlrdurKoQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CRjxA0bumHE=:dTvbCg2jL7wtOcoEhG7xHZ
 +x32gw83qJ/4snuVOZBs3hIymWE9/Ht4sHvOzN2+9bIZ5jMvvexfegGvKlmKh6a67PGmMSvSI
 rPLC3tkJMD6yzP5cq9tNjwMl+sxszX+PmGcwH70A/71KHZ7XGMcU51sbet97ISTYfDEdKRFpb
 hiyz6nF8rxuCX7s0nZ7DSefyhPSakgiItN0X18Lv+UdFWLPQv+dMl7zwaWrabUY+WkBZTzzBp
 /VNpAdlrPrDEKNV036MVLGf38Y6UnO9tw8z50UFRyRuGaEXwXeeRwjRjn1pIHIoxL7rDFRpJ8
 FM5unSyNkalFbf2CMd8quZH/gjOh0DJmiZe6dicGaTbfsH5LjRn2hPLT75u00CNt7mMgs6jEv
 Q5BW6hvEjp7/tI5PE5P/RiHjJVWV1ia/LD9xAIhMVDah1R9hk/UEl89/SR0qZBhSFC51dNwdt
 gIm10h+KVXgehPBKfP9OQd+c+8PpeDQLBBNo5Tkkifs7x2fC4cksGF1TBO536ZtjFj0BBpSLu
 7q+2rfncuy5U4nSNmqKDGYas7nYKgO42GZxTzU3+1ylJ1n16L3CCisARTAaXUu3X1gB3i+o+X
 UHGnKoeJuOzcaAHNzx2NMZ6hh5S4NjsP9Cd727GVyyMKZgIjlw1mb9Gy9qBQJi1Ua9NwvxI8e
 ACxhYXKnvAYl5J5f8MrpRTtKhQknMDkXnwEJUkNCDLdD4idE0fDcz6WB7FKM9a7oaIuSB32+q
 9QhAMdy0efvoC9UFxfh3yJNCjmhB6r12Iue74rQppbUAjbbK/wCgN3xvwuIl8Fo54yibVJiyK
 Zd9GP8GfntRPga2oBTTkFHqCfatMu/2y+TZA/FTTLy0ZbeC3MY=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, May 1, 2022 at 7:22 AM Huacai Chen <chenhuacai@gmail.com> wrote:
> On Sat, Apr 30, 2022 at 7:02 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > On Sat, Apr 30, 2022 at 11:05 AM Huacai Chen <chenhuacai@loongson.cn> wrote:
> > >
> > > This patch adds zboot (self-extracting compressed kernel) support, all
> > > existing in-kernel compressing algorithm and efistub are supported.
> > >
> > > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> >
> > I have no objections to adding a decompressor in principle, and
> > the implementation seems reasonable. However, I think we should try to
> > be consistent between architectures. On both arm64 and riscv, the
> > maintainers decided to not include a decompressor and instead leave
> > it up to the boot loader to decompress the kernel and enter it from there.
>
> X86, ARM32 and MIPS already support self-extracting kernel, and in
> 5.17 we even support self-extracting modules. So I think a
> self-extracting kernel is better than a pure compressed kernel.

These three support it because they always have and it's hard to
remove features later because it breaks user setups. Among the
architectures we merged since the start of the git history in 2005, only
xtensa supports compressed kernels, the rest rely on the boot loader.

> > Adding the arm64, risc-v and uefi maintainers for further discussion here,
> > see full below.
>
> Keeping consistency across architectures (support self-extracting for
> all modern architectures) looks good to me, but can we do that after
> this series? I think that needs a long time to discuss and develop.

Right, just drop this patch then, and we can get back to doing it for
all UEFI users after loongarch is merged.

      Arnd
