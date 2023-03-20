Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 729C96C1E58
	for <lists+linux-arch@lfdr.de>; Mon, 20 Mar 2023 18:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbjCTRmb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Mon, 20 Mar 2023 13:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231613AbjCTRmP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Mar 2023 13:42:15 -0400
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB8FD2F05A;
        Mon, 20 Mar 2023 10:38:13 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id r11so49914970edd.5;
        Mon, 20 Mar 2023 10:38:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679333868;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rZotrnK0BQHQbLHJH05swEdzFKEdXH40eo0fD7GE5Hc=;
        b=w1/i/D8MFRUMF0l/zwAvqIhxrOrYyEzqPWtY7f6EJue8ayl8rpl9PyaE5f8W88adQC
         QQhiDODCDUmJT34pQr9MQ9l8j0DKjiDIGuTziqgFDSij9XREsvWofXfLilVsCpAM1Vjd
         5XyeRrj+yr3ImwkNQzVEFJZ/nqsVIIgTghYjp+T7MQ4GOXMCZtZo2whTB1GGkyCyV7Nn
         N9HDgTih8ZoJRf6/sP6f3gMN9OUd9vwXQ3rsylRCOlA2sUAeJ5T/gg6GBVVNXp+9VV1F
         IvWU4rBB/WY+FAKRteiqsStszoN0f03rpBWAnN2OjGZgvLlG5sBuTLfj5L7JDuRCiKfl
         KXEg==
X-Gm-Message-State: AO0yUKXym6NrxtXPhm72G3Zf1tFWAEqqWrLu25C/x+cj1e+Qy9X1LzDi
        049yfAmqUT1sA6W+NPpexGauFdgnU1FGAZPUyS4=
X-Google-Smtp-Source: AK7set/7mKYdzFXNHBsJkH4BxDkLEiE9GiBxDky6AIoIRPmj56YQuwHBgUnMSN8Ec87G7/8Jp2UVFLowqIhE4IG2rVU=
X-Received: by 2002:a50:a451:0:b0:4fb:c8e3:1adb with SMTP id
 v17-20020a50a451000000b004fbc8e31adbmr201778edb.3.1679333868217; Mon, 20 Mar
 2023 10:37:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230314121216.413434-1-schnelle@linux.ibm.com> <20230314121216.413434-27-schnelle@linux.ibm.com>
In-Reply-To: <20230314121216.413434-27-schnelle@linux.ibm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 20 Mar 2023 18:37:37 +0100
Message-ID: <CAJZ5v0gYGkbUk4uFXgidMaRBniwiXpizZWwMGixeNNejeZjPzg@mail.gmail.com>
Subject: Re: [PATCH v3 26/38] pnp: add HAS_IOPORT dependencies
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Mar 14, 2023 at 1:13 PM Niklas Schnelle <schnelle@linux.ibm.com> wrote:
>
> In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
> not being declared. We thus need to depend on HAS_IOPORT even when
> compile testing only.
>
> Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
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

Applied as 6.4 material, thanks!
