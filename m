Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63D933D7CA6
	for <lists+linux-arch@lfdr.de>; Tue, 27 Jul 2021 19:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbhG0RyD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Jul 2021 13:54:03 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:52567 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbhG0RyC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 27 Jul 2021 13:54:02 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MPoTl-1mVDLu0Ueh-00Mrtm for <linux-arch@vger.kernel.org>; Tue, 27 Jul
 2021 19:54:01 +0200
Received: by mail-wr1-f48.google.com with SMTP id r2so16236039wrl.1
        for <linux-arch@vger.kernel.org>; Tue, 27 Jul 2021 10:54:01 -0700 (PDT)
X-Gm-Message-State: AOAM530RacVmXicTCxRETjVpuSmhsMKi+atSOsArkDie4y3Rdy105TQc
        vOL1ULLp9NUG4beDnWjqtVON3PT3YHLDdwWZRNg=
X-Google-Smtp-Source: ABdhPJzTogxQtsp8EqNkFrU6/v75y9LtSITwxVKX6ysc7OSypq+UIgDUc7D9tqFisqqmB0TcmA8XQSqzCDI0M8+SBek=
X-Received: by 2002:adf:fd90:: with SMTP id d16mr2372049wrr.105.1627408440801;
 Tue, 27 Jul 2021 10:54:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210706041820.1536502-1-chenhuacai@loongson.cn>
 <20210706041820.1536502-6-chenhuacai@loongson.cn> <CAK8P3a1w2Dz_7J1qrGmTYwUqpu=Mc4ew2TMmLynjvyvoEXMd7Q@mail.gmail.com>
 <CAAhV-H4HrcfmLmgxB765CyU72FGsAx1kEzV+yjfgKUO+9KiCNw@mail.gmail.com>
 <CAK8P3a3WdXOrsg6wYShr9KU7PFn2mUHz4dwOTNhYtw53WiwT1A@mail.gmail.com>
 <CAMj1kXGCMcy5qTmjg_Ejg2eXBo2zhDrK+d-yrsQXmF_A4CVcDg@mail.gmail.com>
 <CAK8P3a3kRum-qZBdwJ0bAKbxL2iDfmCgzNeoJk8zEr_Zc_J1Fg@mail.gmail.com> <CAMj1kXGUfAZ79N7Xtsyh3P+HubVhgLgnrBuJT1U3z80z569uag@mail.gmail.com>
In-Reply-To: <CAMj1kXGUfAZ79N7Xtsyh3P+HubVhgLgnrBuJT1U3z80z569uag@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 27 Jul 2021 19:53:44 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0zYMrZ7muts2sR==_Ca=Vx-MjOQXmzteAcj6Oqmtiufw@mail.gmail.com>
Message-ID: <CAK8P3a0zYMrZ7muts2sR==_Ca=Vx-MjOQXmzteAcj6Oqmtiufw@mail.gmail.com>
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
X-Provags-ID: V03:K1:U8RBwQ7ZxCKRmnpsd2VgHfw2loBZUC3zXIkdd2WVSnyAjAemhXN
 JU0jf69KKc4hx/lZx2fQPOtNwmlQpUq3d+3v7TPoFulRJ7Nkl6Xlj0+AtjLS3tWqOZ38Jii
 vOBxJX3TFqfpLbDoEhHDagZwUzRmnbq46mYv5dKkHHZlqt1TETV9/A6XOdifXHAUXloPlbI
 zCcY247Z5GMqlOFJsJxqg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:nUw0t69+vvc=:u1wSErPmVPOaMPZ+UIRFx9
 AnmT+MxaCurPY1kTmUfFXoXX1+0tT1pDD+YELARGXocwthgLFWLolqBWr8+IZ5gwHJcdosNgv
 deTiHaQ1lemwgrABKdKPEJyYNY4K4Hl0WKG0AR6SVvIqA/t8bMDMxZWFt6M6rqGL6tB18r2dv
 LMsS7S8bUpRU/oeU/og4IQxsAzkWAuLZW0AtjXlEj+fhV8YIXlMrjyBBhZBVrzLjlPC4Uo/qG
 QaVAKrwRbYuY7hoJgny6+fc7R6wUpYmR53dPJKQk9UNRSjh2LsY3OhD+uLMO/I2W3EXoN8qX1
 QQOZNg+PWUV2XxsjgXw0/NCJvRfNKbH+citYX81/+stune+IR1zlEa3BnJBfvW0qKWrxDGw6p
 sjBczYlnmMpTtYp1JpdFXHyA/sZM/Vb87ijA+Mf5NhQ3cN3bMfU2tWwdSZepnGZ4Pi0FsaWrm
 sbQgBHQVsWib8udCvPQioi0NUhqR/shcMQc36nhMDw5uDEFvjr0yHNGbmygVO8IVd3/Z+0dbQ
 5FyuuhzJahhW1MvqsCwlDIWdeNqROb+bEc4SZpZ/n3OIXPQXcvifKTdGmaDy37Jlxi1vUHG6o
 smvM1AByf0PKNMRdyfHtflr/4n+kOXIlDGs8psSSulullmT+T5Ky24O8GbSTkgUleEs3fT0B3
 E4VEdYH2vn8hRujE5pHxDo1CRU2vhwc6qnYPJx/OtOAVgWKMsvrxMf8ivAf/sY+QKN0/FaY69
 18wwzChhN0cP4Yh6BbyIpqqCKmb83TCsl5ov4PBUEEBJMOu4DNDIVKWbfSxskMfnCo1chIiT7
 OB2I2UT6TVe7NNv3Omkw80sOSUWRlT4URqj/8WwlvvsF5WTsOafijDBP/LZxshOsQEKgkB2
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 27, 2021 at 6:22 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> On Tue, 27 Jul 2021 at 15:14, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Tue, Jul 27, 2021 at 2:51 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > > On Tue, 27 Jul 2021 at 14:41, Arnd Bergmann <arnd@arndb.de> wrote:
> > > > On Tue, Jul 27, 2021 at 1:53 PM Huacai Chen <chenhuacai@gmail.com> wrote:
> > > >
> > How is other information passed from grub to the efi stub
> > and from there to the kernel on loongarch?
>
> I don't think this architecture boots via EFI at all - it looks like a
> data structure is created in memory that looks like an EFI system
> table, and provided to the kernel proper without going through the
> stub. This is not surprising, given that the stub turns the kernel
> into a PE/COFF executable, and the PE/COFF spec nor the EFI spec
> support the LoongSon architecture.

A lot of upstream projects are still missing loongarch support completely.
I already pointed out the lack of kernel support when the musl and
qemu patches got posted first, and the lack of toolchain support for the
kernel, so it's possible this one is just another missing dependency that
they plan to post later but really should have sooner.

> This is problematic from a maintenance point of view, given that the
> interface between the kernel proper and the EFI stub is being promoted
> from an internal interface that we can freely modify to one that needs
> to remain stable for compatibility of new kernels with older firmware.
> I don't think we should be going down this path tbh.

Agreed. Having a reliable boot interface is definitely important here,
and copying from arch/mips was probably not the best choice in this
regard. They can probably look at what was needed for RISC-V to
add this properly, as that was done fairly recently.

        Arnd
