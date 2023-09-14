Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0D77A06F3
	for <lists+linux-arch@lfdr.de>; Thu, 14 Sep 2023 16:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239652AbjINOKe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 14 Sep 2023 10:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239724AbjINOKd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 14 Sep 2023 10:10:33 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10D571FD5;
        Thu, 14 Sep 2023 07:10:29 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RmfMy0jWJz67Q1Y;
        Thu, 14 Sep 2023 22:09:50 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 14 Sep
 2023 15:10:26 +0100
Date:   Thu, 14 Sep 2023 15:10:25 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     James Morse <james.morse@arm.com>
CC:     <linux-pm@vger.kernel.org>, <loongarch@lists.linux.dev>,
        <linux-acpi@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-riscv@lists.infradead.org>, <kvmarm@lists.linux.dev>,
        <x86@kernel.org>, Salil Mehta <salil.mehta@huawei.com>,
        Russell King <linux@armlinux.org.uk>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        <jianyong.wu@arm.com>, <justin.he@arm.com>
Subject: Re: [RFC PATCH v2 19/35] ACPI: Move acpi_bus_trim_one() before
 acpi_scan_hot_remove()
Message-ID: <20230914151025.00003cef@Huawei.com>
In-Reply-To: <20230913163823.7880-20-james.morse@arm.com>
References: <20230913163823.7880-1-james.morse@arm.com>
        <20230913163823.7880-20-james.morse@arm.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 13 Sep 2023 16:38:07 +0000
James Morse <james.morse@arm.com> wrote:

> A subsequent patch will change acpi_scan_hot_remove() to call
> acpi_bus_trim_one() instead of acpi_bus_trim(), meaning it can no longer
> rely on the prototype in the header file.
> 
> Move these functions further up the file.
> No change in behaviour.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
FWIW
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/acpi/scan.c | 76 ++++++++++++++++++++++-----------------------
>  1 file changed, 38 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index f898591ce05f..a675333618ae 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -244,6 +244,44 @@ static int acpi_scan_try_to_offline(struct acpi_device *device)
>  	return 0;
>  }
>  
> +static int acpi_bus_trim_one(struct acpi_device *adev, void *not_used)
> +{
> +	struct acpi_scan_handler *handler = adev->handler;
> +
> +	acpi_dev_for_each_child_reverse(adev, acpi_bus_trim_one, NULL);
> +
> +	adev->flags.match_driver = false;
> +	if (handler) {
> +		if (handler->detach)
> +			handler->detach(adev);
> +
> +		adev->handler = NULL;
> +	} else {
> +		device_release_driver(&adev->dev);
> +	}
> +	/*
> +	 * Most likely, the device is going away, so put it into D3cold before
> +	 * that.
> +	 */
> +	acpi_device_set_power(adev, ACPI_STATE_D3_COLD);
> +	adev->flags.initialized = false;
> +	acpi_device_clear_enumerated(adev);
> +
> +	return 0;
> +}
> +
> +/**
> + * acpi_bus_trim - Detach scan handlers and drivers from ACPI device objects.
> + * @adev: Root of the ACPI namespace scope to walk.
> + *
> + * Must be called under acpi_scan_lock.
> + */
> +void acpi_bus_trim(struct acpi_device *adev)
> +{
> +	acpi_bus_trim_one(adev, NULL);
> +}
> +EXPORT_SYMBOL_GPL(acpi_bus_trim);
> +
>  static int acpi_scan_hot_remove(struct acpi_device *device)
>  {
>  	acpi_handle handle = device->handle;
> @@ -2506,44 +2544,6 @@ int acpi_bus_scan(acpi_handle handle)
>  }
>  EXPORT_SYMBOL(acpi_bus_scan);
>  
> -static int acpi_bus_trim_one(struct acpi_device *adev, void *not_used)
> -{
> -	struct acpi_scan_handler *handler = adev->handler;
> -
> -	acpi_dev_for_each_child_reverse(adev, acpi_bus_trim_one, NULL);
> -
> -	adev->flags.match_driver = false;
> -	if (handler) {
> -		if (handler->detach)
> -			handler->detach(adev);
> -
> -		adev->handler = NULL;
> -	} else {
> -		device_release_driver(&adev->dev);
> -	}
> -	/*
> -	 * Most likely, the device is going away, so put it into D3cold before
> -	 * that.
> -	 */
> -	acpi_device_set_power(adev, ACPI_STATE_D3_COLD);
> -	adev->flags.initialized = false;
> -	acpi_device_clear_enumerated(adev);
> -
> -	return 0;
> -}
> -
> -/**
> - * acpi_bus_trim - Detach scan handlers and drivers from ACPI device objects.
> - * @adev: Root of the ACPI namespace scope to walk.
> - *
> - * Must be called under acpi_scan_lock.
> - */
> -void acpi_bus_trim(struct acpi_device *adev)
> -{
> -	acpi_bus_trim_one(adev, NULL);
> -}
> -EXPORT_SYMBOL_GPL(acpi_bus_trim);
> -
>  int acpi_bus_register_early_device(int type)
>  {
>  	struct acpi_device *device = NULL;

