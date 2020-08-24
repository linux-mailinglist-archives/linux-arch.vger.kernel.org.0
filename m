Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ABDE2505F6
	for <lists+linux-arch@lfdr.de>; Mon, 24 Aug 2020 19:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbgHXRYf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Aug 2020 13:24:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:53786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727080AbgHXRYO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 24 Aug 2020 13:24:14 -0400
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7323920738;
        Mon, 24 Aug 2020 17:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598289853;
        bh=u6ITf2TE+0Yj01YyyE3ZFTxoh+W/UkoJjDlG96zQlB8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=m9FtahviMbr5P384IS5H5uSVrGUs6/7NH8y15icrkiBkCK+DFwszIICTbKTpcPNkh
         Zz7xc0u+6Iw2jOvPzsky+c1gEznxeotr5lP+F3+ivqT1NBYYnsJlk+Bmwd9PR7+UzA
         fujNQZyw4bSqeIX0OO4ScKt2OsDcSCIiY80sfkqw=
Received: by mail-ot1-f43.google.com with SMTP id i11so956408otr.5;
        Mon, 24 Aug 2020 10:24:13 -0700 (PDT)
X-Gm-Message-State: AOAM531McTIrMEOiieC2umWprnKqinWS5r5Pa47xiYCU/p3CdkS3HYdr
        lQg89eiJz4komRzIGuG3TiUcFp4I9a9zugsNXt4=
X-Google-Smtp-Source: ABdhPJx54D6AG+VvNZEytOaXrn/shKRo/oQCyztVQLHUm4m/2JTRanN3KarJdrloIn4PZRieB1BNuwnqUHAdUuqZ9Dc=
X-Received: by 2002:a9d:6251:: with SMTP id i17mr4017155otk.90.1598289852763;
 Mon, 24 Aug 2020 10:24:12 -0700 (PDT)
MIME-Version: 1.0
References: <1598287583-71762-1-git-send-email-mikelley@microsoft.com> <1598287583-71762-11-git-send-email-mikelley@microsoft.com>
In-Reply-To: <1598287583-71762-11-git-send-email-mikelley@microsoft.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 24 Aug 2020 19:24:01 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHKDD5+Na7t=bbkqo2OaiidmnJg+RqermV-2=exj-P77A@mail.gmail.com>
Message-ID: <CAMj1kXHKDD5+Na7t=bbkqo2OaiidmnJg+RqermV-2=exj-P77A@mail.gmail.com>
Subject: Re: [PATCH v7 10/10] Drivers: hv: Enable Hyper-V code to be built on ARM64
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hyperv@vger.kernel.org,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>, wei.liu@kernel.org,
        vkuznets <vkuznets@redhat.com>,
        KY Srinivasan <kys@microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Boqun Feng <boqun.feng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 24 Aug 2020 at 18:48, Michael Kelley <mikelley@microsoft.com> wrote:
>
> Update drivers/hv/Kconfig so CONFIG_HYPERV can be selected on
> ARM64, causing the Hyper-V specific code to be built.
>
> Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> ---
>  drivers/hv/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
> index 79e5356..1113e49 100644
> --- a/drivers/hv/Kconfig
> +++ b/drivers/hv/Kconfig
> @@ -4,7 +4,8 @@ menu "Microsoft Hyper-V guest support"
>
>  config HYPERV
>         tristate "Microsoft Hyper-V client drivers"
> -       depends on X86 && ACPI && X86_LOCAL_APIC && HYPERVISOR_GUEST
> +       depends on ACPI && \
> +                       ((X86 && X86_LOCAL_APIC && HYPERVISOR_GUEST) || ARM64)
>         select PARAVIRT
>         select X86_HV_CALLBACK_VECTOR
>         help

Given the comment in a previous patch

+/*
+ * All data structures defined in the TLFS that are shared between Hyper-V
+ * and a guest VM use Little Endian byte ordering.  This matches the default
+ * byte ordering of Linux running on ARM64, so no special handling is required.
+ */

shouldn't this depend on !CONFIG_CPU_BIG_ENDIAN ?
