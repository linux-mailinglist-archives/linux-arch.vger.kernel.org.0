Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C39304C892E
	for <lists+linux-arch@lfdr.de>; Tue,  1 Mar 2022 11:24:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231911AbiCAKZA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Mar 2022 05:25:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234127AbiCAKY7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Mar 2022 05:24:59 -0500
X-Greylist: delayed 303 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 01 Mar 2022 02:24:18 PST
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3477358830;
        Tue,  1 Mar 2022 02:24:17 -0800 (PST)
Received: from mail-wr1-f47.google.com ([209.85.221.47]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MmU9X-1o6Xg02KI5-00iRlQ; Tue, 01 Mar 2022 11:19:13 +0100
Received: by mail-wr1-f47.google.com with SMTP id j17so19731748wrc.0;
        Tue, 01 Mar 2022 02:19:13 -0800 (PST)
X-Gm-Message-State: AOAM532h+TSsT7XvTtltQpow3PwSn4+2uzT8xgz1pYiE3i8l451g41cf
        UNXRvarmF9I01/AqayURu6IwTnPEVV950GaoALM=
X-Google-Smtp-Source: ABdhPJzzPOquGV619/Ft2Hlid0sPxXMa9f5QyUk3acsgXWRETaM+gTfyx5RKFPDTTgU6lhKUdNltea8NVoyAewfh61A=
X-Received: by 2002:a5d:63c2:0:b0:1ef:840e:e139 with SMTP id
 c2-20020a5d63c2000000b001ef840ee139mr11569532wrw.192.1646129952971; Tue, 01
 Mar 2022 02:19:12 -0800 (PST)
MIME-Version: 1.0
References: <20220226110338.77547-1-chenhuacai@loongson.cn>
 <20220226110338.77547-10-chenhuacai@loongson.cn> <CAMj1kXHWRZcjF9H2jZ+p-HNuXyPs-=9B8WiYLsrDJGpipgKo_w@mail.gmail.com>
 <YhupaVZvbipgke2Z@kroah.com> <CAAhV-H6hmvyniHP-CMxtOopRHp6XYaF58re13snMrk_Umj+wSQ@mail.gmail.com>
 <CAMj1kXFa447Z21q3uu0UFExDDDG9Y42ZHtiUppu6QpuNA_5bhA@mail.gmail.com>
 <CAAhV-H7X+Txq4HaaF49QZ9deD=Dwx_GX-2E9q_nA8P76ZRDeXg@mail.gmail.com>
 <CAMj1kXGH1AtL8_KbFkK+FRgWQPzPm1dCdvEF0A2KksREGTSeCg@mail.gmail.com>
 <CAAhV-H6fdJwbVG_m0ZL_JGROKCrCbc-fKpj3dnOowaEUA+3ujQ@mail.gmail.com>
 <CAK8P3a2hr2rjyLpkeG1EKiOVGrY4UCB61OHGj5nzft-KCS3jYA@mail.gmail.com>
 <CAMj1kXHGG80LdNUUA+Ug1VBXWuvtPxKpqnuChg2N=6Hf2EhY7g@mail.gmail.com> <CAAhV-H6dxkdmDizd+ZVhJ_zHZ9RK8QjKU-3U-CaovLiNbEVpbg@mail.gmail.com>
In-Reply-To: <CAAhV-H6dxkdmDizd+ZVhJ_zHZ9RK8QjKU-3U-CaovLiNbEVpbg@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 1 Mar 2022 11:18:56 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2wF2XA8wCFtP9RNTNQf3W9D8fKOuQ704yE+dRSS5aCVw@mail.gmail.com>
Message-ID: <CAK8P3a2wF2XA8wCFtP9RNTNQf3W9D8fKOuQ704yE+dRSS5aCVw@mail.gmail.com>
Subject: Re: [PATCH V6 09/22] LoongArch: Add boot and setup routines
To:     Huacai Chen <chenhuacai@gmail.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:XStCGZX/ROQSePDe1dyXr69F8I2kJSDcoRYdgl9fhDF89FNNCW1
 nl7YRK11Fp/q7Y2u5OU7dCpbyI0QK7AQ9lUDGcY0XS7/J3ubQpMAGQA7zTGx1I8haebHYrh
 Al/vYhQKudbTknC/RGK+Q07kfD3/1SETShIQeF6bkDlvbciFXCm1ftcmZvuAEm8HSodfAP5
 KlQpqVR5YoPF1QJu6+RbA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9IFbU8ZQfYw=:X3PrtjVhlasVZ4xhIuFgqS
 R846WvDKkxFkaQq8faDAZlJJr4vCSNQygFIGKs9/SQRVyjiCahjK7OznSWWDKPvrmWUdYPBlV
 /DFUEoWDV4F4zCynGjzruVcV/zgvTwyDPx/jt36L4Ej+m3GvSqfH0faZC2GYOl7rvpupYvaoh
 HnETPwquGI/+P3JZa+kclWRQuGJ5uNlvGEXetauIMpZBb21V5QEGAtZRl0cEY6f3WlLHd2KwS
 UuUv0xvCsYHsGjYq+FRGeI+QWOoI3KjJ3trcxM32quHX6gmGlygpqe+VSQnJiygGldXzObWe2
 ZyRqsAKx3CjezilRrJhm744CtfXjxf500DT669nClml+zMghEhBjOhO8iT9N0WYlgMxkNnhKH
 1d1gYeLVmyXmo75eNKHj/VAeq0P/PYrV6qyHQImBbzFAudXZQfcvC97Xzl/7TaP5BeOVMOKJx
 kp5mTm/Wl7whgeIkS1JTtjBVubif1t/aKNIXs3WrM/cFTy8jDJW/axfBTAann8sOxVUFNSXmO
 9fCzAKIrOdgvMWt5B1lIUwupQ6xcsPxLgUybsQ1/I4JRSDAWJ3AuGYvx290BpM/A94SjN0b4k
 Fo2Bxh9b3lntP0AD2Iwl5mBd7jfEswUpGkoorY9YG1TmEvzXQkfmjtvp3APeNMy2bE5iUt0+t
 qjv+17daBS/GHKNwx8b2EzUtUcBrWhqSte8+pz1K96oGsXft+fzzELAY7yB8i/PhyIW4=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Mar 1, 2022 at 5:17 AM Huacai Chen <chenhuacai@gmail.com> wrote:
> On Mon, Feb 28, 2022 at 7:35 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > On Mon, 28 Feb 2022 at 12:24, Arnd Bergmann <arnd@arndb.de> wrote:
> > > On Mon, Feb 28, 2022 at 11:42 AM Huacai Chen <chenhuacai@gmail.com> wrote:
> > > Can't you just use the UEFI protocol for kernel entry regardless
> > > of the bootloader? It seems odd to use a different protocol for loading
> > > grub and the kernel, especially if that means you end up having to
> > > support both protocols inside of u-boot and grub, in order to chain-load
> > > a uefi application like grub.
> > >
> >
> > I think this would make sense. Now that the EFI stub has generic
> > support for loading the initrd via a UEFI specific protocol (of which
> > u-boot already carries an implementation), booting via UEFI only would
> > mean that no Linux boot protocol would need to be defined outside of
> > the kernel at all (i.e., where to load the kernel, where to put the
> > command line, where to put the initrd, other arch specific rules etc
> > etc) UEFI already supports both ACPI and DT boot
>
> After one night thinking, I agree with Ard that we can use RISCV-style
> fdt to support the raw elf kernel at present, and add efistub support
> after new UEFI SPEC released.

I think that is the opposite of what Ard and I discussed above.

> If I'm right, it seems that RISC-V passes a0 (hartid) and a1 (fdt
> pointer, which contains cmdline, initrd, etc.) to the raw elf kernel.
> And in my opinion, the main drawback of current LoongArch method
> (a0=argc a1=argv a2=bootparamsinterface pointer) is it uses a
> non-standard method to pass kernel args and initrd. So, can the below
> new solution be acceptable?
>
> a0=bootparamsinterface pointer (the same as a2 in current method)
> a1=fdt pointer (contains cmdline, initrd, etc., like RISC-V, I think
> this is the standard method)

It would seem more logical to me to keep those details as part of the
interface between the EFI stub and the kernel, rather than the
documented boot interface.

You said that there is already grub support using the UEFI
loader, so I assume you have a working draft of the boot
protocol. Are there still open questions about the interface
definition for that preventing you from using it as the only
way to enter the kernel from a bootloader?

        Arnd
