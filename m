Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B152954FD17
	for <lists+linux-arch@lfdr.de>; Fri, 17 Jun 2022 21:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232457AbiFQS7y (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 17 Jun 2022 14:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiFQS7u (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 17 Jun 2022 14:59:50 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81096403F3
        for <linux-arch@vger.kernel.org>; Fri, 17 Jun 2022 11:59:48 -0700 (PDT)
Received: from mail-yw1-f173.google.com ([209.85.128.173]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1N8GEY-1ng7jm2wwC-014DV7 for <linux-arch@vger.kernel.org>; Fri, 17 Jun
 2022 20:59:46 +0200
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-3177e60d980so29223317b3.12
        for <linux-arch@vger.kernel.org>; Fri, 17 Jun 2022 11:59:46 -0700 (PDT)
X-Gm-Message-State: AJIora/KzShIXj/ns/Ms1rRaExjZp9bexN9CGBWciJ7g8D6VkeAIMuzy
        7M85A69HoFceFfcwj4N1JJyvc9nFX8a00/MgufY=
X-Google-Smtp-Source: AGRyM1vBPK/AD8SxjZFRQRRzL2gKhd7+cq/c1LJKDIezk+H78fL/tN1swRFZPDHzyTcwCRiLhJ5AWKcgK4l/v22YAgw=
X-Received: by 2002:a81:c08:0:b0:317:8131:2b21 with SMTP id
 8-20020a810c08000000b0031781312b21mr5024318ywm.249.1655492385569; Fri, 17 Jun
 2022 11:59:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220617145705.581985-1-chenhuacai@loongson.cn>
 <CAK8P3a2nD_Zxv5X_LB7AbO=kxHQyk3vz09fQZ-TTX4PL0b3g1g@mail.gmail.com> <CAJF2gTT_etFg7-N4f=A4LMOYvd3+H505e0xt8NyxK4uPtkuEXg@mail.gmail.com>
In-Reply-To: <CAJF2gTT_etFg7-N4f=A4LMOYvd3+H505e0xt8NyxK4uPtkuEXg@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 17 Jun 2022 20:59:28 +0200
X-Gmail-Original-Message-ID: <CAK8P3a078r6zkZYYeV7Qg3AEOvFxgG+eRN9bFE_3DNwHq=_1ZA@mail.gmail.com>
Message-ID: <CAK8P3a078r6zkZYYeV7Qg3AEOvFxgG+eRN9bFE_3DNwHq=_1ZA@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Add qspinlock support
To:     Guo Ren <guoren@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev,
        linux-arch <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:4ymDYj0w3W1jSqv9sQpB3EomfJH+/eYmZyy1KzkmHlxIDg5KNFg
 frLCsjVQNLBeRqmKsfmKgaaAjEOJvs2mjXRnDscQKlKh0DKV6+qBgwmmVH8fVtzkYLKelKK
 94/Xx2X8eiBdPk6wrI0ii4B2J1WYd/J7C4nfjgRpUgLtj9r3U9RKrFNogdoyrcFBgmKpM3W
 XzFj5IjxKMX4wmpmoaBWA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:K4LuofwJo0U=:xBgwiU8IcDI6GNbB4Kaj9P
 R8aJneif8y5ZI4mPxqvc01Ykd6bfoPLiMvj2IuxvEFAULMl0RUpIX7I4OPq6beHNPiB62PCdm
 0FA96NKzOAFeoUGQN6idSjVg6S2XzNHGm+LqBLG3DLkhnuvc65Gu5t9uy0fcybZ5wzSTntzgx
 rKO5CWr/myhnnqdYIgu14wf69ucuSvpve3v/Y32xRHN0oC2Rx7JI89/8tHZfh9pMsi1X1M+s+
 xIf41UDwbc+OOzLrZ9cJiihFjJZZ5z5ZzMfILTwE/j0lITAdetLVc1M1aCXO79tD7sUynhOFk
 95t0rS5z59ZRY/Jnbsqk57ko7Txc5CK9+oSKPTsvhHum1pFXFuY3ztiQwj307i7gwUqCdupY9
 ByI9M7Uq+sWyTHG+g3O5Nnpf53GrwYx8yiWjThM3sVEiPIavLPB4vsCfNXEgiiuAPbaFBk1g5
 17dc/h3aFz0HK4hDHK9NjRlycxIDQv6udbfD6k00FnlyalYFBF6+OA5w5I6yUTdpnpefTEKtb
 yPQSDJJmm03UnJCeI+XYMVnVHK5C04GATPZMp9gokK9s2Oo9fMUHKUZRcsX6tsLm1rUdVBSKT
 9brU3VF7Xy17aWh/fC/jkIpezj8Z12HNtWstu0/LPvL4fFsQ0vKfqFbDJCNGs0O65/ELA8djT
 1M4ZGxPdQu2TPa0fUNXFoClbg14DyQsJE4j4cMXRzu/C77TND2nFeaM2w62+ze3DIP+BU7ATN
 Ul8iJdIKE5dXZM2SIGifiVOY0ZlbNddAjRCGsQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jun 17, 2022 at 7:45 PM Guo Ren <guoren@kernel.org> wrote:
> On Sat, Jun 18, 2022 at 12:11 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > >+
> >
> > Do you actually need the size 1 as well?
> >
> > Generally speaking, I would like to rework the xchg()/cmpxchg() logic
> > to only cover the 32-bit and word-sized (possibly 64-bit) case, while
> > having separate optional 8-bit and 16-bit functions. I had a patch for
> Why not prevent 8-bit and 16-bit xchg()/cmpxchg() directly? eg: move
> qspinlock xchg_tail to per arch_xchg_tail.
> That means Linux doesn't provide a mixed-size atomic operation primitive.
>
> What does your "separate optional 8-bit and 16-bit functions" mean here?

What I have in mind is something like

static inline  u8 arch_xchg8(u8 *ptr, u8 x) {...}
static inline u16 arch_xchg16(u16 *ptr, u16 x) {...}
static inline u32 arch_xchg32(u32 *ptr, u32 x) {...}
static inline u64 arch_xchg64(u64 *ptr, u64 x) {...}

#ifdef CONFIG_64BIT
#define xchg(ptr, x) (sizeof(*ptr) == 8) ? \
            arch_xchg64((u64*)ptr, (uintptr_t)x)  \
            arch_xchg32((u32*)ptr, x)
#else
#define xchg(ptr, x) arch_xchg32((u32*)ptr, (uintptr_t)x)
#endif

This means most of the helpers can actually be normal
inline functions, and only 64-bit architectures need the special
case of dealing with non-u32-sized pointers and 'long' values.

         Arnd
