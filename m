Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8CEA704D24
	for <lists+linux-arch@lfdr.de>; Tue, 16 May 2023 13:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232825AbjEPLz0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Tue, 16 May 2023 07:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232739AbjEPLzZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 May 2023 07:55:25 -0400
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B6630D2;
        Tue, 16 May 2023 04:55:16 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-94a342f4c8eso357644366b.0;
        Tue, 16 May 2023 04:55:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684238115; x=1686830115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9q5DgTfm8dN9Omjxcw65gevA2+mgzpXo7SfWnYHWz0g=;
        b=jEjV+Yxz7ptaFr7s5sAGGvKfmStF9UB+eF37s9KC2TStNeGyFjbzA6ye1mHFYrIsq/
         qoNPVPXJc55mKh6Au+NuyOSgKqV5Xb2N2MAe0WWwq9SaUHFf4EKbLzDni2BlMyO/VVGN
         X3BMoVjGWC+HMJfs80ACHghUPnsvRLgVVrLmSAgc+pwkeHxtLkMUQSVRMNvH9opqUiLD
         b3HH6Nw9jQMZB4aUKCmmLEyXoBxnzpzLp618KBbZAZAAOFz1NDS5Vy84nW4L7M0bRmHN
         iS/K8r2W9hx90+8kUGwAGVBJ2USCmfltm5XxqOTmOfn2FDznc7TPaOLojWtAwm3pLlnV
         LIsw==
X-Gm-Message-State: AC+VfDwsoPGSvVQvEIzKzj2/b3oN+s3KaKWqmxgxKc7iDskZpNoVPnyG
        qSStWPjygNIiv1gwsKVM0p49MkKPhx3dxoMlQ/g=
X-Google-Smtp-Source: ACHHUZ5Y4w5srTMXTX32pzyHoJgePACCnf7VjnU0fIY3EUJVUD7FKNJPs1y7jPKGagn9SDVi8k47k6mzIs8J2VMXKpw=
X-Received: by 2002:a17:906:51cb:b0:94e:d688:fca6 with SMTP id
 v11-20020a17090651cb00b0094ed688fca6mr9170548ejk.0.1684238115020; Tue, 16 May
 2023 04:55:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230516110038.2413224-1-schnelle@linux.ibm.com> <20230516110038.2413224-27-schnelle@linux.ibm.com>
In-Reply-To: <20230516110038.2413224-27-schnelle@linux.ibm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 16 May 2023 13:55:03 +0200
Message-ID: <CAJZ5v0j8tZH+JdekZoKGH6DuvYBT2A5rORC6m4VARBLKrKAR6A@mail.gmail.com>
Subject: Re: [PATCH v4 26/41] pnp: add HAS_IOPORT dependencies
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jaroslav Kysela <perex@perex.cz>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, May 16, 2023 at 1:01 PM Niklas Schnelle <schnelle@linux.ibm.com> wrote:
>
> In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
> not being declared. We thus need to depend on HAS_IOPORT even when
> compile testing only.
>
> Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
> Note: The HAS_IOPORT Kconfig option was added in v6.4-rc1 so
>       per-subsystem patches may be applied independently
>
>  drivers/pnp/isapnp/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pnp/isapnp/Kconfig b/drivers/pnp/isapnp/Kconfig
> index d0479a563123..79bd48f1dd94 100644
> --- a/drivers/pnp/isapnp/Kconfig
> +++ b/drivers/pnp/isapnp/Kconfig
> @@ -4,7 +4,7 @@
>  #
>  config ISAPNP
>         bool "ISA Plug and Play support"
> -       depends on ISA || COMPILE_TEST
> +       depends on ISA || (HAS_IOPORT && COMPILE_TEST)
>         help
>           Say Y here if you would like support for ISA Plug and Play devices.
>           Some information is in <file:Documentation/driver-api/isapnp.rst>.
> --
> 2.39.2
>
