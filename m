Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 960B434AE76
	for <lists+linux-arch@lfdr.de>; Fri, 26 Mar 2021 19:23:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbhCZSW1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 26 Mar 2021 14:22:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:33874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230213AbhCZSWT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 26 Mar 2021 14:22:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E74AC61A42;
        Fri, 26 Mar 2021 18:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616782938;
        bh=jLGR+NyehSUNZVl5kh+mHpluJzlAfSJXFMkJ5QFHPLQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FGNMBA2S+sqoHCfdgN2xPFLdvY7w1ubfGycnYplAm5Xuh33eTfteivyAovekbWA9w
         yfld9bMxHjPtk6Hhklpu7oYZIbdFL1ljaGBXqC5JDt9yKBlTX7kAx1myFZ7wuAQTTU
         jVdlWWeH+3FguNaGmIau3X7NuPSKeRLNaH0udlAHqHLaTI2Nh59I0ILOAppKs8o8/D
         19qHEC4fCaQI1gejM6rW9sLEbEJ8sx1EuiN8eQS9UBjNdK2v5TM+H9geJCe0fg2Uua
         hTXju+20flSq1dpCUtji3RjvYCP8L0pwpr+4Ldr1Bi1ZJpawqdb9WedZVTTF9eqZAI
         +O7oIbfohruuw==
Received: by mail-ed1-f43.google.com with SMTP id z1so7357057edb.8;
        Fri, 26 Mar 2021 11:22:17 -0700 (PDT)
X-Gm-Message-State: AOAM531NN1LxYZLJOxCneNWdSgtk6d+MKHDjSzrgTmSVmvn9CQTFQ7W7
        qmCMJiyxN2fCYXZ7HmhCfaumQr7mc30XpZJJ6Q==
X-Google-Smtp-Source: ABdhPJzge00Chol2o+zcxsCiGngmRlWpn0gXJpTNd7PjgqCsH3Y9wanEoRXm0NadwDvEZ6TqBdnoQxNSvLg0UG9tpaw=
X-Received: by 2002:a05:6402:c0f:: with SMTP id co15mr16452718edb.373.1616782936426;
 Fri, 26 Mar 2021 11:22:16 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1616765869.git.christophe.leroy@csgroup.eu>
 <7362e4f6a5f5b79e6ad3fd3cec3183a4a283f7fc.1616765870.git.christophe.leroy@csgroup.eu>
 <CAL_Jsq+LF-s5K4Jwd5jCHrU8271L5WCiGb0tR7aTUa8ddHF1YQ@mail.gmail.com> <c18ef8f7-8e79-a9d3-3853-f8b992a4fc93@csgroup.eu>
In-Reply-To: <c18ef8f7-8e79-a9d3-3853-f8b992a4fc93@csgroup.eu>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 26 Mar 2021 12:22:04 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJOFHmfRNAXgm6Gbe3qTUwnUTroxPzPmmLJUN7ciM2z9g@mail.gmail.com>
Message-ID: <CAL_JsqJOFHmfRNAXgm6Gbe3qTUwnUTroxPzPmmLJUN7ciM2z9g@mail.gmail.com>
Subject: Re: [PATCH v3 05/17] arm: Convert to GENERIC_CMDLINE
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nicolas Pitre <nico@fluxnic.net>
Cc:     Will Deacon <will@kernel.org>, Daniel Walker <danielwa@cisco.com>,
        Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>,
        "open list:GENERIC INCLUDE/ASM HEADER FILES" 
        <linux-arch@vger.kernel.org>, devicetree@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        microblaze <monstr@monstr.eu>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        nios2 <ley.foon.tan@intel.com>,
        Openrisc <openrisc@lists.librecores.org>,
        linux-hexagon@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        X86 ML <x86@kernel.org>, linux-xtensa@linux-xtensa.org,
        SH-Linux <linux-sh@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

+Nico who added the line in question.

On Fri, Mar 26, 2021 at 9:50 AM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
>
>
> Le 26/03/2021 =C3=A0 16:47, Rob Herring a =C3=A9crit :
> > On Fri, Mar 26, 2021 at 7:44 AM Christophe Leroy
> > <christophe.leroy@csgroup.eu> wrote:
> >>
> >> This converts the architecture to GENERIC_CMDLINE.
> >>
> >> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> >> ---
> >>   arch/arm/Kconfig              | 38 +--------------------------------=
--
> >>   arch/arm/kernel/atags_parse.c | 15 +++++---------
> >>   2 files changed, 6 insertions(+), 47 deletions(-)
> >>
> >> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> >> index 5da96f5df48f..67bc75f2da81 100644
> >> --- a/arch/arm/Kconfig
> >> +++ b/arch/arm/Kconfig
> >> @@ -50,6 +50,7 @@ config ARM
> >>          select GENERIC_ARCH_TOPOLOGY if ARM_CPU_TOPOLOGY
> >>          select GENERIC_ATOMIC64 if CPU_V7M || CPU_V6 || !CPU_32v6K ||=
 !AEABI
> >>          select GENERIC_CLOCKEVENTS_BROADCAST if SMP
> >> +       select GENERIC_CMDLINE if ATAGS
> >
> > Don't we need this enabled for !ATAGS (i.e. DT boot)?
> >
> > Can we always enable GENERIC_CMDLINE for OF_EARLY_FLATTREE?
> >
>
> Don't know.
>
> Today ARM has:
>
> choice
>         prompt "Kernel command line type" if CMDLINE !=3D ""
>         default CMDLINE_FROM_BOOTLOADER
>         depends on ATAGS

I think that's a mistake. In a DT only case (no ATAGS), we'll get
different behaviour (in fdt.c) depending if CONFIG_ATAGS is enabled or
not. Note that at the time (2012) the above was added, the DT code
only supported CONFIG_CMDLINE and CONFIG_CMDLINE_FORCE.
CONFIG_CMDLINE_EXTEND was only added in 2016. And that has different
behavior for ATAGS vs. DT. In summary, it's a mess. We should drop the
depends either before this patch or just as part of this patch IMO.
I'd go with the latter given CONFIG_ATAGS is default y and enabled for
common configs. Without that, it looks like CONFIG_CMDLINE disappears
from menuconfig for at91_dt_defconfig.

Also, I think this code should be refactored a bit to eliminate
default_command_line. Instead, we should just save a pointer to the
ATAGS command line string, and then call cmdline_build here instead of
doing the extra copy:

        /* parse_early_param needs a boot_command_line */
        strlcpy(boot_command_line, from, COMMAND_LINE_SIZE);

Rob
