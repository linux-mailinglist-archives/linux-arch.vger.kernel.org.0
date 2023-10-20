Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51FC67D1463
	for <lists+linux-arch@lfdr.de>; Fri, 20 Oct 2023 18:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjJTQwO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Fri, 20 Oct 2023 12:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjJTQwN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 20 Oct 2023 12:52:13 -0400
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A41EFCA;
        Fri, 20 Oct 2023 09:52:11 -0700 (PDT)
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-57de3096e25so90192eaf.1;
        Fri, 20 Oct 2023 09:52:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697820731; x=1698425531;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=psILNHinFhubd7kf1xu/dppnYDWKXA3Ybjqll4DLjw0=;
        b=w24jwbxTNrd6oh/gZRoYUFGYk0zPOUo72sqiF10MJJ5xSwoIbsP0PF0BeLuRgNcFkn
         PcLxjAACK7lk/2r/m2lCF/9Ez/AUtaJ8/p1KmoUCgbGKlkdE+lBrO+OnQcoFWZlamkHu
         ExlRTQRzdfElty2Kre/y1N49+yDi/1f9gT5bC95bKxmqcEjwgwg0slGz+OYrxPhlEd7b
         Zj/a0aw0QSVNa7sR3qzqCzKuGVnWQFSTg2j8qJn6DrIS5dpoy6bBbDkRg6JS21anXLl5
         f1DcuXlIKGZnfWp8KrwhLn82dxhZcBYjvemZp22v/lsEw9cA5sDMUaqOICF5112MlejO
         xOYg==
X-Gm-Message-State: AOJu0YxB3c+PgdK8gL9+aycBMWf7qcO+gLfnvanOKvh6YPp+LzcWjeNm
        2K1WKw6wImGwLxv51zxovL8n5TcN1fH5tfgnHco=
X-Google-Smtp-Source: AGHT+IGh0cmdaOOYZFwyTinjpHRLVyGaQdJ8C+chdN0KihO5maTrIgG7O0UmbbjbnDR2+SuI/Pn6JwhLUpC07VMZzYY=
X-Received: by 2002:a4a:e7d1:0:b0:583:ec88:e0 with SMTP id y17-20020a4ae7d1000000b00583ec8800e0mr2657273oov.0.1697820730971;
 Fri, 20 Oct 2023 09:52:10 -0700 (PDT)
MIME-Version: 1.0
References: <E1qtq2W-00AJ8T-Mm@rmk-PC.armlinux.org.uk> <95A91316-0210-41D6-B8E2-4EE958066FFB@oracle.com>
In-Reply-To: <95A91316-0210-41D6-B8E2-4EE958066FFB@oracle.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 20 Oct 2023 18:52:00 +0200
Message-ID: <CAJZ5v0hfJkbE=TNpNWnVZsxzB4Hd-BCwQrJ+Lc3B95S9-KQezg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: Use the acpi_device_is_present() helper in more places
To:     Miguel Luis <miguel.luis@oracle.com>,
        Russell King <rmk+kernel@armlinux.org.uk>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
        "x86@kernel.org" <x86@kernel.org>,
        James Morse <james.morse@arm.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        "jianyong.wu@arm.com" <jianyong.wu@arm.com>,
        "justin.he@arm.com" <justin.he@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Oct 20, 2023 at 4:52 PM Miguel Luis <miguel.luis@oracle.com> wrote:
>
> Hi Russell,
>
> > On 20 Oct 2023, at 13:59, Russell King <rmk+kernel@armlinux.org.uk> wrote:
> >
> > From: James Morse <james.morse@arm.com>
> >
> > acpi_device_is_present() checks the present or functional bits
> > from the cached copy of _STA.
> >
> > A few places open-code this check. Use the helper instead to
> > improve readability.
> >
> > Signed-off-by: James Morse <james.morse@arm.com>
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Reviewed-by: Gavin Shan <gshan@redhat.com>
> > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > ---
> > Jonathan Cameron suggests "Pull this one out and send it upstream in
> > advance of the rest" so let's do that. See
> > https://lore.kernel.org/r/20230914130455.00004434@Huawei.com/
> >
> > So, let's get this upstream to reduce the number of outstanding patches
> > for aarch64 vcpu hotplug.
> >
> > drivers/acpi/scan.c | 4 ++--
> > 1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> > index 691d4b7686ee..ed01e19514ef 100644
> > --- a/drivers/acpi/scan.c
> > +++ b/drivers/acpi/scan.c
> > @@ -304,7 +304,7 @@ static int acpi_scan_device_check(struct acpi_device *adev)
> > int error;
> >
> > acpi_bus_get_status(adev);
> > - if (adev->status.present || adev->status.functional) {
> > + if (acpi_device_is_present(adev)) {
> > /*
> > * This function is only called for device objects for which
> > * matching scan handlers exist.  The only situation in which
> > @@ -338,7 +338,7 @@ static int acpi_scan_bus_check(struct acpi_device *adev, void *not_used)
> > int error;
> >
> > acpi_bus_get_status(adev);
> > - if (!(adev->status.present || adev->status.functional)) {
> > + if (!acpi_device_is_present(adev)) {
>
> Reviewed-by: Miguel Luis <miguel.luis@oracle.com>

Applied as 6.7 material, thanks!
