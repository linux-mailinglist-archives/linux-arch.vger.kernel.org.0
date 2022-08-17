Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE35D596A6B
	for <lists+linux-arch@lfdr.de>; Wed, 17 Aug 2022 09:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbiHQHgU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 17 Aug 2022 03:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbiHQHfw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 17 Aug 2022 03:35:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC5975CF2;
        Wed, 17 Aug 2022 00:35:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 714D5B80B6D;
        Wed, 17 Aug 2022 07:35:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04665C43141;
        Wed, 17 Aug 2022 07:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660721748;
        bh=kRWBdL8KuIR9lzjC86jiut/WktvRHyEtgar9YfSS8aw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=f5pshq/NwkuMgGYP//0wfDCKCdZER6j+qe2XNpE1VEST4/YsDYTVOQZgefH1O7nhy
         Len1UYBW3xXsHF1xiaL4OePl8HCrkss78L57FK6eK+ucjgv/MqcMYoLM9Pfm0WIT4q
         z40yqyZ8uajYZ3MTCB1vuuY4HQEHMz/PwtHbEp570p77N+dlDlsPEFuafgSbB9a2yn
         Egh+7ocXJH6MlsnzMLOup0LG3Q3FOLMMRSpuzunaKJk4dTOUJm7Q9Pne7F8+Wl1HHS
         yUPSPLGHfIoqwClWA868zf57sICTOUHeX1KIM6gSGCqrQAReavpmIMZHiIhb38fI3y
         aK3Esbi0YAgTQ==
Received: by mail-vs1-f47.google.com with SMTP id d126so12373127vsd.13;
        Wed, 17 Aug 2022 00:35:47 -0700 (PDT)
X-Gm-Message-State: ACgBeo2ABWgK+aWBWX00y1usYSWNFzM6yuiWj/rJx3VZxP2aD/QvCM2z
        AGgbLvzhP6JxbOLmOAJh6CKIWX6LgDI6ojVVR14=
X-Google-Smtp-Source: AA6agR4UC2eBl1dAvuMAA/z475fxgWNemreWYrByTXgOj8HuagYmO7k1l0SV9ycZyuAaVPTJ5y+Vd1yVnncr8qW3d5o=
X-Received: by 2002:a05:6102:390d:b0:387:78b9:bf9c with SMTP id
 e13-20020a056102390d00b0038778b9bf9cmr10284036vsu.43.1660721746834; Wed, 17
 Aug 2022 00:35:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220617145754.582056-1-chenhuacai@loongson.cn>
 <CAMj1kXERN209b7dbVs_hy4BeUwrmk2p9_vF+Wq2W8PUeHOQTkg@mail.gmail.com>
 <CAAhV-H60CJDRY4c+Eu+L=rNgHsXQqx=HK9nNSqg69WVV+Bm3SQ@mail.gmail.com>
 <CAMj1kXE1MijqonkPeH+Ydg8ti4_4YFXxBKK6Wztb=HtSY5EAgQ@mail.gmail.com>
 <CAAhV-H503hgyUZND2MmZ2h3qVb3SRt79HcQy7HrFmfGBci-QMA@mail.gmail.com>
 <CAMj1kXEzzAXYP3nXo8-Ny+iwuDorrO-JqoKjg3R+4kmhV_v_KQ@mail.gmail.com>
 <CAAhV-H60mSKx3k1CwBCdubswosgqe+NuVaMtKA=hpjBhq5w5wA@mail.gmail.com> <CAMj1kXFi0o3dOmpW9qarJPH2L2EWKCPKE--3z=jsGjaYh1JrTQ@mail.gmail.com>
In-Reply-To: <CAMj1kXFi0o3dOmpW9qarJPH2L2EWKCPKE--3z=jsGjaYh1JrTQ@mail.gmail.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Wed, 17 Aug 2022 15:35:34 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5CXeG9mNxqJLouvSGLqno4DSwbpPOO5xG2D6ptF2dSTQ@mail.gmail.com>
Message-ID: <CAAhV-H5CXeG9mNxqJLouvSGLqno4DSwbpPOO5xG2D6ptF2dSTQ@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Add efistub booting support
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>, loongarch@lists.linux.dev,
        linux-arch <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Ard,

On Wed, Aug 17, 2022 at 3:18 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Wed, 17 Aug 2022 at 09:17, Huacai Chen <chenhuacai@kernel.org> wrote:
> >
> > Hi, Ard,
> >
> > On Wed, Aug 17, 2022 at 3:00 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > >
> > > On Wed, 17 Aug 2022 at 08:43, Huacai Chen <chenhuacai@kernel.org> wrote:
> > > >
> > > > Hi, Ard,
> > > >
> > > > On Tue, Aug 16, 2022 at 11:32 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > > > >
> > > > > On Tue, 16 Aug 2022 at 17:23, Huacai Chen <chenhuacai@kernel.org> wrote:
> > > > > >
> > > ...
> > > > > >
> > > > >
> > > > > No that makes no difference. The point is that the EFI stub and the
> > > > > core kernel are the same image, so when the stub runs, the core
> > > > > kernel's screen_info already exists in memory - the only thing you
> > > > > need to do is make it accessible by adding it to image-vars.h
> > > > Emm,  in ARM64,
> > > > #define alloc_screen_info(x...)         &screen_info
> > > >
> > > > So screen_info is a global variable in the core kernel. For the zboot
> > > > case (our own implementation, not sure about the proposing new
> > > > method), efistub may be able to fill this info, but while
> > > > decompressing, screen_info will be overwritten. I think.
> > > >
> > >
> > > Right. So you can drop it then.
> > OK, then can we rename LINUX_EFI_ARM_SCREEN_INFO_TABLE_GUID to
> > LINUX_EFI_SCREEN_INFO_TABLE_GUID and avoid define a dedicated GUID for
> > each arch?
> >
>
> If you use the arm64 approach, you don't need a GUID at all.
Oh, I misunderstood.
OK, I will use the arm64 approach now, my problem only exists when the
order is "stub, decompression, core-kernel". If the new zboot way is
"decompression, stub, core-kernel", then there is no problem.

Huacai
>
> ...
>
> > > > > > > This code is not checking a platform feature so it does not belong here.
> > > > > > >
> > > > > > > The EFI stub code is an ordinary EFI app, and it runs in the execution
> > > > > > > context provided by EFI. So why is this needed so early? Can you move
> > > > > > > it into the kernel entry routine instead?
> > > > > > This is useful once we use our own zboot implementation, maybe we
> > > > > > don't need it with the new method you are proposing.
> > > > > >
> > > > >
> > > > > If this is part of your zboot implementation, please drop it for now.
> > > > > Let's try using the generic EFI zboot instead - if we need to, we can
> > > > > find a way to add it there.
> > > > >
> > > > > But out of curiosity, why is this needed at all?
> > > > My mistake, the real reason of configuring DMW in stub is that the
> > > > address of real_kernel_entry() is a kernel va, not a efi va (which is
> > > > the same as pa).
> > > >
> > >
> > > That means you can move this code to efi_enter_kernel(), no?
> > Yes, we can move to efi_enter_kernel(), thank you.
> >
>
> OK
