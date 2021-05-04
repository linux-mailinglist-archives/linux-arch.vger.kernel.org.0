Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3DFE3726B9
	for <lists+linux-arch@lfdr.de>; Tue,  4 May 2021 09:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbhEDHoT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 May 2021 03:44:19 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:40559 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbhEDHoS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 May 2021 03:44:18 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MJmX3-1lxpR53rVB-00K506; Tue, 04 May 2021 09:43:22 +0200
Received: by mail-wr1-f45.google.com with SMTP id n2so8256935wrm.0;
        Tue, 04 May 2021 00:43:22 -0700 (PDT)
X-Gm-Message-State: AOAM531N6vsLZpdYM4kEppDMA7Ki9dsuT0FG7NtAOq/2TctwEaByMpLO
        AoVoZZ6KMcgrqZ0XU202lYNN3YA8iaYn0zrN5/M=
X-Google-Smtp-Source: ABdhPJwmQ0TWMpLbjB8m36FPm0+mFnFt1RjNALmJYjdOwkjE12j3BzFHniwAOiE13u6QZ6b9BCL1HxKmH7RGeYuBGWg=
X-Received: by 2002:a5d:6a52:: with SMTP id t18mr12372887wrw.361.1620114202631;
 Tue, 04 May 2021 00:43:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210430111641.1911207-1-schnelle@linux.ibm.com>
 <CAK8P3a3mCujxC0=_cL6Z88Xh2cb=OY_Ct7DVpJNvRn1v9=FhkQ@mail.gmail.com> <9e52895227515143bf3cd9197876ff1ed596682b.camel@linux.ibm.com>
In-Reply-To: <9e52895227515143bf3cd9197876ff1ed596682b.camel@linux.ibm.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 4 May 2021 09:42:42 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1F1X2SUZLLxK8_QriRZjYyV2AYJFNQt=sGZcWP8yovaw@mail.gmail.com>
Message-ID: <CAK8P3a1F1X2SUZLLxK8_QriRZjYyV2AYJFNQt=sGZcWP8yovaw@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] asm-generic/io.h: Silence -Wnull-pointer-arithmetic
 warning on PCI_IOBASE
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Vineet Gupta <vgupta@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        "open list:SYNOPSYS ARC ARCHITECTURE" 
        <linux-snps-arc@lists.infradead.org>,
        sparclinux <sparclinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:PM8N81IVkqWP0jQZee0H2Kf7n5kTuYYDTuPYQ2Fxj2M2biu4sFy
 BVPNYNmBF+OA1OgO9hmCUg29cpwOkBgCFqk7hvLMCEb9TqOcuAitSOhmiJsmkD3D/IeKQ4+
 XIz8dkouyYUSfbr9ijiwIxomw106OPS7cIrW1HXfMPv9rgEW6rtEzI93uG0NRQomPYqPfPv
 HR6kbV8fya83cSCPdoQBw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:zq+SEaKWvlY=:Rz+YkKRTkZJEoRf0QhGzDT
 B+P6zACEbRyfR2XpXcRmzp9r1cA63MTv31wkm13KU4iJIqQuaWyxnTY0N0NiMllOH2VmHhYn1
 VDJCAWqIVLMPKQQGF1CX9clLtRnAMv7zFdAKcJEQ5BVqhsVzBurQyt08rNrT6IADxkAfkaiJN
 FBi1k5bj4NBR2P5C4sprnyMWKONnyC0ArMuc/BL8wWkLajX3EdZvJxmBHchcDjO+ax+h31e2i
 RRddPYtDdc15Tnbelpwct9pjSyZo77giResNPncqiTv0fwBzWl+2QvYKl/TAneEznG34v+X9s
 FmCdbniYpQFRsIQ9m7Aw2GMPcKQIcdx83ro+rtrqb15/FQ6Xj19yQgyPwyDtJg1hYsFKle/Tz
 jOoySf6C0vdp6NBV+ZbdocT8fIVzBZohuKLQw0gPgIOBkqIz26fb7VD0gj7jYfhwX5WpdoJlU
 MIrAoBWWSz3vo76ywjYzj54BumgRKfyJ+GfUM7K/+f96i3kxKwQfz42uqJhK2pF9xERot4dUb
 7SJnobLAJzvhBw16LPMueqJ4VMp7DMPxYCiGYuCXC0G/ijXSIMA3ngEEiLBgb8qFTmM9vQxq/
 fYxJ+fdTrSp4dexPstY5gGb2ZZFy0YLgyK4FfJEW8VRrKosfpRcCfjFT3QS7xm32CyoBvu5gO
 ZXBg=
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, May 4, 2021 at 9:40 AM Niklas Schnelle <schnelle@linux.ibm.com> wrote:
> On Mon, 2021-05-03 at 18:07 +0200, Arnd Bergmann wrote:
> > - for the risc-v patch, I would suggest explaining that this fixes
> >   an existing runtime bug, not just a compiler error:
> >   | This is already broken, as accessing a fixed I/O port number of
> >   | an ISA device on NOMMU RISC-V would turn into a NULL pointer
> >   | dereference.
> >   Feel free to either copy this, or use your own explanation.
>
> I mixed the above in with the current commit message:
>
>     Without MMU support PCI_IOBASE is left undefined because PCI_IO_END is
>     VMEMMAP_START. Nevertheless the in*()/out*() helper macros are left
>     defined with uses of PCI_IOBASE. At the moment this only compiles
>     because asm-generic/io.h defines PCI_IOBASE as 0 if it is undefined and
>     so at macro expansion PCI_IOBASE is defined. This leads to compilation
>     errors when asm-generic/io.h is changed to leave PCI_IOBASE undefined.
>     More importantly it is currently broken at runtime, as accessing a fixed
>     I/O port number of an ISA device on NOMMU RISC-V would turn into a NULL
>     pointer dereference. Instead only define the in*()/out*() helper macros
>     with MMU support and fall back to the asm-generic/io.h helper stubs
>     otherwise.

Looks good, thanks. Maybe split into two or three paragraphs for readability.

     Arnd
