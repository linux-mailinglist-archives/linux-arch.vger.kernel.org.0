Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E609E51A0DB
	for <lists+linux-arch@lfdr.de>; Wed,  4 May 2022 15:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346562AbiEDN1o (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 4 May 2022 09:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347065AbiEDN1l (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 May 2022 09:27:41 -0400
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C7DD88;
        Wed,  4 May 2022 06:24:04 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id f38so2355465ybi.3;
        Wed, 04 May 2022 06:24:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vvTTUaLWJsjzPOFhmxoasD7sFbTs6/YjaMVSqjmO3ts=;
        b=VFHLhVpkw7v/V1fI3l0jrlIOpZ9OmvzXuxPnzWbk4k+w2wAo+9U5CPXaYrz/790OOU
         ZPmO5+ikLZ49TvOFhvUkN8wPfMutOMFasYevjcrvIxZQTAsjUc/CUdr6yVKL+GsRbcDm
         D18bEHEo1rMvPlmDW7rbYUbrLt5VPLZx9ZeaUTKECQVDRh5cp0mqyxPWVhsylszWrafZ
         A23j4vnkhwcwyBlVreuaWh5eUTDMzKxMKK0vWv6X3oL8zDm3PJoMUViIY/U2WH1+YPLG
         QqFL8ZadM0bnJQhFA9fucDzSZXk3h0k6mN5zX4p74oliju/d6BJMwHjfCYRcpxOcOQJ9
         bYfA==
X-Gm-Message-State: AOAM530UIK9XXExKRGpN6rMukDlf74Q8C/cxIMiP/b4PzJVKvN8mAVtr
        xWJlph4CQ0FRplqwo6eIJldHJe1N0/VlwQJHZdg=
X-Google-Smtp-Source: ABdhPJxppYsWFTgmx4TSOuqHe5105380Jz8OCQyRpJxioOe85R2bkm4kBc3Ir4s/36lupzUTfHVs8wA1Ac+nLmg8rAI=
X-Received: by 2002:a25:3795:0:b0:648:fa25:5268 with SMTP id
 e143-20020a253795000000b00648fa255268mr18583257yba.153.1651670643716; Wed, 04
 May 2022 06:24:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220429135108.2781579-1-schnelle@linux.ibm.com> <20220429135108.2781579-3-schnelle@linux.ibm.com>
In-Reply-To: <20220429135108.2781579-3-schnelle@linux.ibm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 4 May 2022 15:23:52 +0200
Message-ID: <CAJZ5v0jbX6kWWn9a9SBh0qhmreC-KDOHCB2TbM4A5_HSJu++UQ@mail.gmail.com>
Subject: Re: [RFC v2 02/39] ACPI: add dependency on HAS_IOPORT
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Apr 29, 2022 at 3:51 PM Niklas Schnelle <schnelle@linux.ibm.com> wrote:
>
> In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
> not being declared. As ACPI always uses I/O port access we simply depend
> on HAS_IOPORT.
>
> Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>  drivers/acpi/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index 1e34f846508f..8ad0d168004c 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -5,6 +5,7 @@
>
>  config ARCH_SUPPORTS_ACPI
>         bool
> +       depends on HAS_IOPORT

This and the analogous PNP change are both fine with me.

Thanks!

>
>  menuconfig ACPI
>         bool "ACPI (Advanced Configuration and Power Interface) Support"
> --
> 2.32.0
>
