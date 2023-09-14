Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D64E7A07BB
	for <lists+linux-arch@lfdr.de>; Thu, 14 Sep 2023 16:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240379AbjINOsT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 14 Sep 2023 10:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240386AbjINOsP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 14 Sep 2023 10:48:15 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0EDA1FDE;
        Thu, 14 Sep 2023 07:48:10 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RmgCS0cnFz6K5mL;
        Thu, 14 Sep 2023 22:47:32 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 14 Sep
 2023 15:48:08 +0100
Date:   Thu, 14 Sep 2023 15:48:07 +0100
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
Subject: Re: [RFC PATCH v2 27/35] ACPICA: Add new MADT GICC flags fields
 [code first?]
Message-ID: <20230914154807.0000710d@Huawei.com>
In-Reply-To: <20230913163823.7880-28-james.morse@arm.com>
References: <20230913163823.7880-1-james.morse@arm.com>
        <20230913163823.7880-28-james.morse@arm.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 13 Sep 2023 16:38:15 +0000
James Morse <james.morse@arm.com> wrote:

> Add the new flag field to the MADT's GICC structure.
> 
> 'Online Capable' indicates a disabled CPU can be enabled later.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
Why [code first?] it's in ACPI 6.5
https://uefi.org/sites/default/files/resources/ACPI_Spec_6_5_Aug29.pdf

Spec reference would be good though. It's 6.5 Tabel 5.37: GICC CPU Interface Flags
I think

> ---
> This patch probably needs to go via the upstream acpica project,
> but is included here so the feature can be testd.
tested

> ---
>  include/acpi/actbl2.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
> index 3751ae69432f..c433a079d8e1 100644
> --- a/include/acpi/actbl2.h
> +++ b/include/acpi/actbl2.h
> @@ -1046,6 +1046,7 @@ struct acpi_madt_generic_interrupt {
>  /* ACPI_MADT_ENABLED                    (1)      Processor is usable if set */
>  #define ACPI_MADT_PERFORMANCE_IRQ_MODE  (1<<1)	/* 01: Performance Interrupt Mode */
>  #define ACPI_MADT_VGIC_IRQ_MODE         (1<<2)	/* 02: VGIC Maintenance Interrupt mode */
> +#define ACPI_MADT_GICC_CPU_CAPABLE      (1<<3)	/* 03: CPU is online capable */
bikeshed colour time....

It's capable of being a CPU?

ACPI_MADT_GICC_ONLINE_CAPABLE 

GICC already tells us it's a CPU (last C) despite the table in ACPI being labeled
Table 5.37: GICC CPU Interface table



>  
>  /* 12: Generic Distributor (ACPI 5.0 + ACPI 6.0 changes) */
>  

