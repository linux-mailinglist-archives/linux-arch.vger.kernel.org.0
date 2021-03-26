Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1B8E34AB71
	for <lists+linux-arch@lfdr.de>; Fri, 26 Mar 2021 16:27:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbhCZP1G (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 26 Mar 2021 11:27:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:50848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230098AbhCZP1C (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 26 Mar 2021 11:27:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AD59E61A36;
        Fri, 26 Mar 2021 15:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616772421;
        bh=PgZvub/EEgXyOMtj36/Ui5nnRJqFFaiQoQ/VbltMCjA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Eg+BwZGAwSyILfvPcAOTVne302pKV2q+cmm5Ihp4Me5aUHSjUNGW3+nDtB8R91wcm
         C2DZ9VNhmbn0jETV9GNehbOwe3JTYKhoqjnh/MiS11ee4oxdvW0wRf2ZrWgUDyfJma
         hWNpN/TDOWiJIBIfJozhEVq7FS6Mk6XBvB49orLZFW6uYQR5hUuZGCCK5sAk8SD5SC
         UeP3y50GhNpSvcc4yWyh8y4La1rfFodfJDuofdgE1ai4ujHIVkZF7oQxbAyMF7RCJU
         u626vT1IL6nOSZEgmRmqhiGrDEBDKZfd4AiSGwBgBRCvns974kHSj2o73ajFlbU9P5
         x5eyEjjSzm5/A==
Received: by mail-ed1-f42.google.com with SMTP id bf3so6760125edb.6;
        Fri, 26 Mar 2021 08:27:01 -0700 (PDT)
X-Gm-Message-State: AOAM5314zhfTHmpNPiZvla7UF3/Hs8EnVkg1oA4GXjTiAG8dOURW35N+
        ZUZGDbPp5z87wTpP5TtBFmSnG5H7B8Og419Mtw==
X-Google-Smtp-Source: ABdhPJwqjia+Et0ifS4Qa3YP7BG89nAuXW50XJw7Bv12OLaUbiQxEkJ38eyAu5ZhN7DqGhRVJR72+O39P4k/LsEHPLw=
X-Received: by 2002:a05:6402:5252:: with SMTP id t18mr16004050edd.258.1616772420155;
 Fri, 26 Mar 2021 08:27:00 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1616765869.git.christophe.leroy@csgroup.eu>
 <46745e07b04139a22b5bd01dc37df97e6981e643.1616765870.git.christophe.leroy@csgroup.eu>
 <87zgyqdn3d.fsf@igel.home> <81a7e63f-57d4-5c81-acc5-35278fe5bb04@csgroup.eu>
In-Reply-To: <81a7e63f-57d4-5c81-acc5-35278fe5bb04@csgroup.eu>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 26 Mar 2021 09:26:47 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK2TT=j1QjiRgTYQvwHqivE-3HgYo2JzxTJSWO2wvK69Q@mail.gmail.com>
Message-ID: <CAL_JsqK2TT=j1QjiRgTYQvwHqivE-3HgYo2JzxTJSWO2wvK69Q@mail.gmail.com>
Subject: Re: [PATCH v3 11/17] riscv: Convert to GENERIC_CMDLINE
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Andreas Schwab <schwab@linux-m68k.org>,
        Will Deacon <will@kernel.org>,
        Daniel Walker <danielwa@cisco.com>,
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

On Fri, Mar 26, 2021 at 8:20 AM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
>
>
> Le 26/03/2021 =C3=A0 15:08, Andreas Schwab a =C3=A9crit :
> > On M=C3=A4r 26 2021, Christophe Leroy wrote:
> >
> >> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> >> index f8f15332caa2..e7c91ee478d1 100644
> >> --- a/arch/riscv/kernel/setup.c
> >> +++ b/arch/riscv/kernel/setup.c
> >> @@ -20,6 +20,7 @@
> >>   #include <linux/swiotlb.h>
> >>   #include <linux/smp.h>
> >>   #include <linux/efi.h>
> >> +#include <linux/cmdline.h>
> >>
> >>   #include <asm/cpu_ops.h>
> >>   #include <asm/early_ioremap.h>
> >> @@ -228,10 +229,8 @@ static void __init parse_dtb(void)
> >>      }
> >>
> >>      pr_err("No DTB passed to the kernel\n");
> >> -#ifdef CONFIG_CMDLINE_FORCE
> >> -    strlcpy(boot_command_line, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
> >> +    cmdline_build(boot_command_line, NULL, COMMAND_LINE_SIZE);
> >>      pr_info("Forcing kernel command line to: %s\n", boot_command_line=
);
> >
> > Shouldn't that message become conditional in some way?
> >
>
> You are right, I did something similar on ARM but looks like I missed it =
on RISCV.

How is this hunk even useful? Under what conditions can you boot
without a DTB? Even with a built-in DTB, the DT cmdline handling would
be called.

Rob
