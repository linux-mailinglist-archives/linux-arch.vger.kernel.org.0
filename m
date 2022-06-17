Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1075500A0
	for <lists+linux-arch@lfdr.de>; Sat, 18 Jun 2022 01:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236606AbiFQXUE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 17 Jun 2022 19:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383708AbiFQXTt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 17 Jun 2022 19:19:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A48EB66CAF
        for <linux-arch@vger.kernel.org>; Fri, 17 Jun 2022 16:19:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5E283B82C0C
        for <linux-arch@vger.kernel.org>; Fri, 17 Jun 2022 23:19:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 209EBC341C4
        for <linux-arch@vger.kernel.org>; Fri, 17 Jun 2022 23:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655507981;
        bh=KGht/uubc0rpDhT7K4rkZ3NblZRjf4Gm7IDY6LQr4k0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WPdchb5Pqdz/Tysbxo41FSNx/yCuDpYUI/6ZFgrLDSR8FXwNBSyvmXImNMsLWoZo5
         uLPqXO4Q396QLfIxlU+gph91m7vz96mEQGNA2Z1llwxs21yfv4LvQ5hYV1GADfTDR0
         BWWxcY91PeirCxayrHPWiGDdDtHmXXo/b1c9pzmGPcBddJzC5XRNgLCs/yu3Vg9CFe
         RC7JIAehIxkw3yt8BDHy43uKdypgV9QpWlTTxZ3KN6XAtRmPAEhc5RS6Ddj3y3K+QO
         ZfWM74dI8H0VHnnopbjMcYYepaG8rEci9evALghMch/VpjffABO8KWv4lUvesZzEVg
         af85PwN2dyhKg==
Received: by mail-ua1-f54.google.com with SMTP id m10so2036063uao.11
        for <linux-arch@vger.kernel.org>; Fri, 17 Jun 2022 16:19:41 -0700 (PDT)
X-Gm-Message-State: AJIora+6yribW2paQjO33QgLhn7xgMn0ChW3jVHuX+L/W5tZn+EV2AwZ
        qmYH8ydcqVn2auQmi9UQuOOiGJ4xCz7Jyy5P0tk=
X-Google-Smtp-Source: AGRyM1vwgww4kNuJOLV6KW0trAY9XEj49LS5rDDHKOxvX5atVSPG+h9Ean/wlZKiHJsALSc2betqeDcCX3G2po0D8H0=
X-Received: by 2002:ab0:2747:0:b0:373:5408:d086 with SMTP id
 c7-20020ab02747000000b003735408d086mr5333967uap.12.1655507980045; Fri, 17 Jun
 2022 16:19:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220617145705.581985-1-chenhuacai@loongson.cn>
 <CAK8P3a2nD_Zxv5X_LB7AbO=kxHQyk3vz09fQZ-TTX4PL0b3g1g@mail.gmail.com>
 <CAJF2gTT_etFg7-N4f=A4LMOYvd3+H505e0xt8NyxK4uPtkuEXg@mail.gmail.com> <CAK8P3a078r6zkZYYeV7Qg3AEOvFxgG+eRN9bFE_3DNwHq=_1ZA@mail.gmail.com>
In-Reply-To: <CAK8P3a078r6zkZYYeV7Qg3AEOvFxgG+eRN9bFE_3DNwHq=_1ZA@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Sat, 18 Jun 2022 07:19:28 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQL+ysc+juQfNVxz1QtXgrLAYe=CyA9L_c3fzd4F8aFxQ@mail.gmail.com>
Message-ID: <CAJF2gTQL+ysc+juQfNVxz1QtXgrLAYe=CyA9L_c3fzd4F8aFxQ@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Add qspinlock support
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev,
        linux-arch <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Jun 18, 2022 at 2:59 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Fri, Jun 17, 2022 at 7:45 PM Guo Ren <guoren@kernel.org> wrote:
> > On Sat, Jun 18, 2022 at 12:11 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > > >+
> > >
> > > Do you actually need the size 1 as well?
> > >
> > > Generally speaking, I would like to rework the xchg()/cmpxchg() logic
> > > to only cover the 32-bit and word-sized (possibly 64-bit) case, while
> > > having separate optional 8-bit and 16-bit functions. I had a patch for
> > Why not prevent 8-bit and 16-bit xchg()/cmpxchg() directly? eg: move
> > qspinlock xchg_tail to per arch_xchg_tail.
> > That means Linux doesn't provide a mixed-size atomic operation primitive.
> >
> > What does your "separate optional 8-bit and 16-bit functions" mean here?
>
> What I have in mind is something like
>
> static inline  u8 arch_xchg8(u8 *ptr, u8 x) {...}
> static inline u16 arch_xchg16(u16 *ptr, u16 x) {...}
Yes, inline is very important. We should prevent procedure call like
this patch. My preparing qspinlock patch for riscv only deal with
xchg16 with inline.


> static inline u32 arch_xchg32(u32 *ptr, u32 x) {...}
> static inline u64 arch_xchg64(u64 *ptr, u64 x) {...}
>
> #ifdef CONFIG_64BIT
> #define xchg(ptr, x) (sizeof(*ptr) == 8) ? \
>             arch_xchg64((u64*)ptr, (uintptr_t)x)  \
>             arch_xchg32((u32*)ptr, x)
> #else
> #define xchg(ptr, x) arch_xchg32((u32*)ptr, (uintptr_t)x)
> #endif
The above primitive implies only long & int type args are permitted, right?

>
> This means most of the helpers can actually be normal
> inline functions, and only 64-bit architectures need the special
> case of dealing with non-u32-sized pointers and 'long' values.
>
>          Arnd



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
