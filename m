Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A451D7D4F55
	for <lists+linux-arch@lfdr.de>; Tue, 24 Oct 2023 14:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232956AbjJXMCU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Tue, 24 Oct 2023 08:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233435AbjJXMCT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 24 Oct 2023 08:02:19 -0400
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC31E120;
        Tue, 24 Oct 2023 05:02:17 -0700 (PDT)
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3b2d9a9c824so1006841b6e.0;
        Tue, 24 Oct 2023 05:02:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698148937; x=1698753737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q2pHDhFBV3p+9e1mZi2uGJDDYekveY6SeTMBwmaYx/4=;
        b=SzR3QQEYyvhYRcAV2mt9thqEo+GgfpLYPwXexHxaEJ8URGnqceLxSYECZzWRCJkKx0
         rZ2QGxui+UFef4QKs9ZbZ45IEqIU4mSud3D0mKPeZe0F3PZWmONM8i3tu9n+iESja9tP
         RkCV0l7UwYXx8zBZP4Ubdivsxj0YFr4MuEmtuJ6izvEU/Re8WQx9H+As1Sr/pHsGfSpX
         qjYpgkoJZs32R7TDoasiTfEdfogF59ApFtrRbvDIILONyAKudftuwdQj4m68+fqRIth7
         +nhPUHwfHQF++EJNw3bEUg+zac3MaCxcqioi26tXrteZKXIpjVQQxXYc6L3PFGEAnffp
         bmlw==
X-Gm-Message-State: AOJu0Yys0jeFsrf8FGpN2jdKNA6LLUavTE2B2MxGPzULME9GMfwm40ZN
        4p6yDIcocdahMT87J7v55JLqG99qPAk6YcQ9gmU=
X-Google-Smtp-Source: AGHT+IGIETBiiFD1D2fRVRb8FftiTW+n7MOvkpWXai2dprUcsPzAq6Nyi8wxC+U5gNTBl00FSuUydUoDBwyRfxz40/M=
X-Received: by 2002:a05:6808:1513:b0:3ae:5e6a:5693 with SMTP id
 u19-20020a056808151300b003ae5e6a5693mr13497868oiw.0.1698148937006; Tue, 24
 Oct 2023 05:02:17 -0700 (PDT)
MIME-Version: 1.0
References: <E1qtuWW-00AQ7P-0W@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1qtuWW-00AQ7P-0W@rmk-PC.armlinux.org.uk>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 24 Oct 2023 14:02:05 +0200
Message-ID: <CAJZ5v0hEXaYSgre=F=hZ0XTRqupaBR5Grnck=tQtfj4inDkOKA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: Rename acpi_scan_device_not_present() to be about enumeration
To:     Russell King <rmk+kernel@armlinux.org.uk>
Cc:     linux-pm@vger.kernel.org, loongarch@lists.linux.dev,
        linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev,
        x86@kernel.org, James Morse <james.morse@arm.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        jianyong.wu@arm.com, justin.he@arm.com,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Oct 20, 2023 at 8:47 PM Russell King <rmk+kernel@armlinux.org.uk> wrote:
>
> From: James Morse <james.morse@arm.com>
>
> acpi_scan_device_not_present() is called when a device in the
> hierarchy is not available for enumeration. Historically enumeration
> was only based on whether the device was present.
>
> To add support for only enumerating devices that are both present
> and enabled, this helper should be renamed. It was only ever about
> enumeration, rename it acpi_scan_device_not_enumerated().
>
> No change in behaviour is intended.
>
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
> This is another patch from James' aarch64 hotplug vcpu series.
>
> I asked:
> > Is this another patch which ought to be submitted without waiting
> > for the rest of the series?
> to which Jonathan Cameron replied:
> > Looks like a valid standalone change to me.
>
> So let's get this queued up.
>
>  drivers/acpi/scan.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index ed01e19514ef..17ab875a7d4e 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -289,10 +289,10 @@ static int acpi_scan_hot_remove(struct acpi_device *device)
>         return 0;
>  }
>
> -static int acpi_scan_device_not_present(struct acpi_device *adev)
> +static int acpi_scan_device_not_enumerated(struct acpi_device *adev)
>  {
>         if (!acpi_device_enumerated(adev)) {
> -               dev_warn(&adev->dev, "Still not present\n");
> +               dev_warn(&adev->dev, "Still not enumerated\n");
>                 return -EALREADY;
>         }
>         acpi_bus_trim(adev);
> @@ -327,7 +327,7 @@ static int acpi_scan_device_check(struct acpi_device *adev)
>                         error = -ENODEV;
>                 }
>         } else {
> -               error = acpi_scan_device_not_present(adev);
> +               error = acpi_scan_device_not_enumerated(adev);
>         }
>         return error;
>  }
> @@ -339,7 +339,7 @@ static int acpi_scan_bus_check(struct acpi_device *adev, void *not_used)
>
>         acpi_bus_get_status(adev);
>         if (!acpi_device_is_present(adev)) {
> -               acpi_scan_device_not_present(adev);
> +               acpi_scan_device_not_enumerated(adev);
>                 return 0;
>         }
>         if (handler && handler->hotplug.scan_dependent)
> --

Applied as 6.7 material, thanks!
