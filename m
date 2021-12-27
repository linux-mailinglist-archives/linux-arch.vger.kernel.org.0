Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 694AA48026B
	for <lists+linux-arch@lfdr.de>; Mon, 27 Dec 2021 17:48:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbhL0QsL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Dec 2021 11:48:11 -0500
Received: from mail-qv1-f50.google.com ([209.85.219.50]:36562 "EHLO
        mail-qv1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbhL0Qry (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Dec 2021 11:47:54 -0500
Received: by mail-qv1-f50.google.com with SMTP id kc16so14254323qvb.3;
        Mon, 27 Dec 2021 08:47:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lDE0B4GVjE0LJYoy9bVa5acyiTrwOeGwxNWWSw8Ch2k=;
        b=O+CrPnIRkajn6yieQcuIQBGGqiWpdQdJhYhVGHCIQ24hkqGSVVA/u8fHdnb9g0SiuV
         WZjokeiiB1xo6ESyUo4C4n8fGzCWDcSfROllSwagdYpFAN9VNDH/HOC2MDyGukFuM7Xo
         ZMrmOjXV7XfcvACnyK+ZiXmX520RKN32cSB9LsRod6N6/htPNUQwiotVZEOytZjYB4Wc
         mysuMxfhA5mLma5rDpWn9AYap/ztHdxrGgfvY7MCaujZOUJlFT3AdvK6AWeZNv4GatEH
         iZIy8bJ8vI4h3K46WFd1MS/6aP6FaviUtQoocoUWJ4b5nSFuIn3Nayw0UaTALlM0kLwE
         BwFw==
X-Gm-Message-State: AOAM533OHXj30X+/qYyA0iQlw2Uk7D1B5GcVA7e77sHsqZ6lz9r1RIck
        AbeC001dbtrrOCGsaGpamN+Wbp4+K8vt9w6nEgQ=
X-Google-Smtp-Source: ABdhPJzp91sTo1r6iyIdgTKl3gnZIU8G2ysznYOFt0lPn6SLPamsy1tCaZ8DFJhpq8W07Mr639WN2Jo3fcSBJq/l1lU=
X-Received: by 2002:a05:6214:508f:: with SMTP id kk15mr15558614qvb.61.1640623673123;
 Mon, 27 Dec 2021 08:47:53 -0800 (PST)
MIME-Version: 1.0
References: <20211227164317.4146918-1-schnelle@linux.ibm.com> <20211227164317.4146918-4-schnelle@linux.ibm.com>
In-Reply-To: <20211227164317.4146918-4-schnelle@linux.ibm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 27 Dec 2021 17:47:42 +0100
Message-ID: <CAJZ5v0iBJ8NtQautnWnp_pXMfLy_rxys8j4+ugSTbNBb=wzy6A@mail.gmail.com>
Subject: Re: [RFC 03/32] ACPI: Kconfig: add HAS_IOPORT dependencies
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        John Garry <john.garry@huawei.com>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        linux-riscv@lists.infradead.org, linux-csky@vger.kernel.org,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Dec 27, 2021 at 5:44 PM Niklas Schnelle <schnelle@linux.ibm.com> wrote:
>
> In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
> not being declared. As ACPI always uses I/O port access

The ARM64 people may not agree with this.

> we depend on HAS_IOPORT unconditionally.
>
> Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>  drivers/acpi/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index cdbdf68bd98f..b57f15817ede 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -9,6 +9,7 @@ config ARCH_SUPPORTS_ACPI
>  menuconfig ACPI
>         bool "ACPI (Advanced Configuration and Power Interface) Support"
>         depends on ARCH_SUPPORTS_ACPI
> +       depends on HAS_IOPORT
>         select PNP
>         select NLS
>         default y if X86
> --
> 2.32.0
>
