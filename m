Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58A763D75A3
	for <lists+linux-arch@lfdr.de>; Tue, 27 Jul 2021 15:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236320AbhG0NOZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Jul 2021 09:14:25 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:60913 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236284AbhG0NOZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 27 Jul 2021 09:14:25 -0400
Received: from mail-wm1-f50.google.com ([209.85.128.50]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1Mgek8-1mpQMe0Ccu-00h7Vo for <linux-arch@vger.kernel.org>; Tue, 27 Jul 2021
 15:14:24 +0200
Received: by mail-wm1-f50.google.com with SMTP id e25-20020a05600c4b99b0290253418ba0fbso2321992wmp.1
        for <linux-arch@vger.kernel.org>; Tue, 27 Jul 2021 06:14:23 -0700 (PDT)
X-Gm-Message-State: AOAM532tvdz3NJCVYPJijUjERAGd7Z+YN7dQCykF34BD8DO7Be706eK3
        gDkfoOPHpMwgb+Xn0Ie+wY4+Ext05E13j9ucabc=
X-Google-Smtp-Source: ABdhPJwO7my9hqH1q6v4eUqesMptr+HjsD8LcDfD/br7CNBaMGHMP3Pjc7TR6vON3Mjz4vwH6kZ7bzFzTKv0z9nPF1k=
X-Received: by 2002:a7b:ce10:: with SMTP id m16mr3932391wmc.75.1627391663745;
 Tue, 27 Jul 2021 06:14:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210706041820.1536502-1-chenhuacai@loongson.cn>
 <20210706041820.1536502-6-chenhuacai@loongson.cn> <CAK8P3a1w2Dz_7J1qrGmTYwUqpu=Mc4ew2TMmLynjvyvoEXMd7Q@mail.gmail.com>
 <CAAhV-H4HrcfmLmgxB765CyU72FGsAx1kEzV+yjfgKUO+9KiCNw@mail.gmail.com>
 <CAK8P3a3WdXOrsg6wYShr9KU7PFn2mUHz4dwOTNhYtw53WiwT1A@mail.gmail.com> <CAMj1kXGCMcy5qTmjg_Ejg2eXBo2zhDrK+d-yrsQXmF_A4CVcDg@mail.gmail.com>
In-Reply-To: <CAMj1kXGCMcy5qTmjg_Ejg2eXBo2zhDrK+d-yrsQXmF_A4CVcDg@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 27 Jul 2021 15:14:07 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3kRum-qZBdwJ0bAKbxL2iDfmCgzNeoJk8zEr_Zc_J1Fg@mail.gmail.com>
Message-ID: <CAK8P3a3kRum-qZBdwJ0bAKbxL2iDfmCgzNeoJk8zEr_Zc_J1Fg@mail.gmail.com>
Subject: Re: [PATCH 05/19] LoongArch: Add boot and setup routines
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@gmail.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:B4YYi+mMuL4MgOzJOByG7gl6HSeE3ubWZJ4q7qOHvCjtTgWPiTi
 EGSwXd7uzJdrThDdwd/WraV1hoEEF5CIw1tJrZA3EjiCAPBUMAGoFgtllZQpeF77rMoiv7+
 QXGyuDiim/DShxR3j3ilNJ4bvwt3fMv3wSzM9cYmXJdtU2nuuJfkYx6mHYeyt4vaUDsvOlt
 Vj3XVhlupUSwMvpvhbKQw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:YtCFoXe/px0=:XAtSSe5hVlbT2f3IPWc3Cc
 YrxA7x38YuiRLUehLOlIfJdlN8M4m+ZugwQBh+1R3JpYotdveuLqtGGXbaYR3jvl6Rex/REd0
 /9QRz7/D7kJJXv6pwFaBblVubE2+3OPy7209R74b+csq49PXe9XkAupzrxH7cIIplJPqqgNGu
 Cq5Or3CrdQ10xnxzDxVoORo3bjtVoSh+lkucO3qqCNIh1miZOMnCyfQH9GSZHBgbMAq9uJCTd
 MDSi78Cj/0IF/1AZO03yElsK5A7ckNTYnFg2jEj4dXm8mWRKErzWxlWX+LK6aCRSikJ1Pw6Rf
 Y3BuTZHakxbDLdz7MuEY3riZLzwBZ52RsPJ9r65+kWATfuF3hxJuOC8Lf0QtdcpdULMRhzBz/
 dIZ1u78AjU9cqrRqNy+U50YkaP+QTDffVyfXNZb7wCfvSQDbtJmCrpAoQMh2/db602kbM2/Sr
 bK6jnJxxkN2Bg4cW7aGDz/Qy7E+msCbJmZJJifBqUKJ5fVFTSV66yHfpHiPYeD3PDqUwnNXhk
 xz/QepEnbBz9FrrI08pGH+dL+od2H8KRizg1BQ4L6pnDtgxU6/YQQVyRF/q5Q7idO1SY/tpgW
 6QfWpQxiuy0l02eTMs80h0IIhNOgJ7uusRk7NBAD+31d5D91jMvRqv9mTTjydUII6bgNQOosA
 fK3/gSRhloaQNN9OKJO/IVwfajOHKvONJNkDJ3d/CoXsbwMo3975+0JlbaRZEAsTaA2n9BHuh
 pL4gbuyW6io6MpHVu5K3EQ2OTG10ykHpRpPvirXA8uCtsZST9T92e5yPz5w8YXDon/1VF0XZb
 N6dzaVYsBGivVKi5kewRa/Ufvtvz2+a+dxPePu0leDMOqr/gNFxv+KWJUFPcaeYX0xc0G/OSU
 KIH+KgDNYUbnD+M8LJn+XBgnA13gy74LJgMzS+VDkEoWjlw2ZaMAieIcXFK3RvypkLAdV1TNC
 0B8znTaXu5sSURx8bOnPbr/+NWrXY3c/dPYWw+9vBtN4/QTArD8Zs
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 27, 2021 at 2:51 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> On Tue, 27 Jul 2021 at 14:41, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Tue, Jul 27, 2021 at 1:53 PM Huacai Chen <chenhuacai@gmail.com> wrote:
> >
> > As far as I understand it, this should be using the kernel's UEFI stub
> > as documented in Documentation/admin-guide/efi-stub.rst
> >
>
> That document describes how the EFI stub can load an initrd from the
> partition that the kernel image itself was loaded from.
>
> After loading it, the EFI stub still needs to tell the kernel proper
> where the initrd lives in memory, and it uses either struct bootparam
> (x86) or DT's /chosen node (other arches) for this.
>
> I think we should avoid inventing yet another way of passing this
> information, but if the architecture in question does not use DT (and
> is != x86), I don't think we have a choice.

Ok, I see.

Would the existing early_param("initrd", early_initrd); in
init/do_mounts_initrd.c work for this then? This would be
similar to the proposed rd_start()/rd_size() early_parem
additions, but use architecture-independent code.

How is other information passed from grub to the efi stub
and from there to the kernel on loongarch?
I suppose at the minimum we need memory regions, ACPI
tables, and command line, in addition to the initrd.

       Arnd
