Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C08D34ABC9
	for <lists+linux-arch@lfdr.de>; Fri, 26 Mar 2021 16:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbhCZPrw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 26 Mar 2021 11:47:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:56248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230236AbhCZPrT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 26 Mar 2021 11:47:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DFEF461A27;
        Fri, 26 Mar 2021 15:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616773639;
        bh=FOq/AGTP4gWQcAqm6gE3CbPMoPZd/s7+r0gDFMG3q6U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AcCDpzU7tp9iwdGG8gDfzEHT/oRIXsIga7wXxu53WqUJhT2ul2T9YDS65RNqPU2n3
         Xvn+RFssUybeWEZgEY2lh1i4UxjZPbwmKsgliPvp0IToMiB2a/WA5KR9z10HdDinOv
         UYM5sw/0IvqfBsKxROncwVaSX/vsAHxPYgALR1dSYHioveObkwXiHIvFx1Yj/tNdZJ
         KMRbv1ObJxkt+zXV5bOiWGyn/1VwvDn/9VCA4p517RmAt9EEHqYSMNig8Oj+y1Zu4e
         B4aIe1rurjyjKfoN2EcYkT1/pA82eHFw94cAgT8CIulbihfa0tOaUKwaviLlzc9Bb9
         p9VnLj0VX7D0A==
Received: by mail-ed1-f50.google.com with SMTP id y6so6863670eds.1;
        Fri, 26 Mar 2021 08:47:18 -0700 (PDT)
X-Gm-Message-State: AOAM533y3Mbzdq/w0OJ5kPTx9/7Cq9mAA6LjG4KaQ05ghWDBJC3D1ESE
        yrNKJFeSjM4MbkrT/jc59B04xoMkSziUJkuolw==
X-Google-Smtp-Source: ABdhPJyGMjMWznP/BbCajkt9nas+eMG/Qmwgar26pPUJYE7aEhO5sSz0Y/IOGFJNx4RiD0k/WjxUTeg0KAhhn6cQx0c=
X-Received: by 2002:a05:6402:c88:: with SMTP id cm8mr15784199edb.62.1616773637523;
 Fri, 26 Mar 2021 08:47:17 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1616765869.git.christophe.leroy@csgroup.eu> <7362e4f6a5f5b79e6ad3fd3cec3183a4a283f7fc.1616765870.git.christophe.leroy@csgroup.eu>
In-Reply-To: <7362e4f6a5f5b79e6ad3fd3cec3183a4a283f7fc.1616765870.git.christophe.leroy@csgroup.eu>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 26 Mar 2021 09:47:04 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+LF-s5K4Jwd5jCHrU8271L5WCiGb0tR7aTUa8ddHF1YQ@mail.gmail.com>
Message-ID: <CAL_Jsq+LF-s5K4Jwd5jCHrU8271L5WCiGb0tR7aTUa8ddHF1YQ@mail.gmail.com>
Subject: Re: [PATCH v3 05/17] arm: Convert to GENERIC_CMDLINE
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
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
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Mar 26, 2021 at 7:44 AM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
> This converts the architecture to GENERIC_CMDLINE.
>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/arm/Kconfig              | 38 +----------------------------------
>  arch/arm/kernel/atags_parse.c | 15 +++++---------
>  2 files changed, 6 insertions(+), 47 deletions(-)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 5da96f5df48f..67bc75f2da81 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -50,6 +50,7 @@ config ARM
>         select GENERIC_ARCH_TOPOLOGY if ARM_CPU_TOPOLOGY
>         select GENERIC_ATOMIC64 if CPU_V7M || CPU_V6 || !CPU_32v6K || !AEABI
>         select GENERIC_CLOCKEVENTS_BROADCAST if SMP
> +       select GENERIC_CMDLINE if ATAGS

Don't we need this enabled for !ATAGS (i.e. DT boot)?

Can we always enable GENERIC_CMDLINE for OF_EARLY_FLATTREE?

Rob
