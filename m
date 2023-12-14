Return-Path: <linux-arch+bounces-1043-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40FAC8138EB
	for <lists+linux-arch@lfdr.de>; Thu, 14 Dec 2023 18:41:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEC821F21D92
	for <lists+linux-arch@lfdr.de>; Thu, 14 Dec 2023 17:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE9167B49;
	Thu, 14 Dec 2023 17:41:14 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCFB8B7;
	Thu, 14 Dec 2023 09:41:10 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SrflK5yzwz6K61J;
	Fri, 15 Dec 2023 01:40:45 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 0FB9E1400DB;
	Fri, 15 Dec 2023 01:41:09 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 14 Dec
 2023 17:41:08 +0000
Date: Thu, 14 Dec 2023 17:41:07 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
CC: <linux-pm@vger.kernel.org>, <loongarch@lists.linux.dev>,
	<linux-acpi@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-riscv@lists.infradead.org>, <kvmarm@lists.linux.dev>,
	<x86@kernel.org>, <acpica-devel@lists.linuxfoundation.org>,
	<linux-csky@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-ia64@vger.kernel.org>, <linux-parisc@vger.kernel.org>, Salil Mehta
	<salil.mehta@huawei.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>,
	<jianyong.wu@arm.com>, <justin.he@arm.com>, James Morse <james.morse@arm.com>
Subject: Re: [PATCH RFC v3 05/21] ACPI: Rename ACPI_HOTPLUG_CPU to include
 'present'
Message-ID: <20231214174107.0000171f@Huawei.com>
In-Reply-To: <E1rDOgD-00Dvk2-3h@rmk-PC.armlinux.org.uk>
References: <ZXmn46ptis59F0CO@shell.armlinux.org.uk>
	<E1rDOgD-00Dvk2-3h@rmk-PC.armlinux.org.uk>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 13 Dec 2023 12:49:37 +0000
Russell King (Oracle) <rmk+kernel@armlinux.org.uk> wrote:

> From: James Morse <james.morse@arm.com>
> 
> The code behind ACPI_HOTPLUG_CPU allows a not-present CPU to become
> present. This isn't the only use of HOTPLUG_CPU. On arm64 and riscv
> CPUs can be taken offline as a power saving measure.
> 
> On arm64 an offline CPU may be disabled by firmware, preventing it from
> being brought back online, but it remains present throughout.
> 
> Adding code to prevent user-space trying to online these disabled CPUs
> needs some additional terminology.
> 
> Rename the Kconfig symbol CONFIG_ACPI_HOTPLUG_PRESENT_CPU to reflect
> that it makes possible CPUs present.
> 
> HOTPLUG_CPU is untouched as this is only about the ACPI mechanism.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Miguel Luis <miguel.luis@oracle.com>
> Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
> Tested-by: Jianyong Wu <jianyong.wu@arm.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Formatting nitpick inline. Either way FWIW:
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 4db54e928b36..36071bc11acd 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h

>  #ifdef CONFIG_ACPI_HOTPLUG_IOAPIC
>  int acpi_get_ioapic_id(acpi_handle handle, u32 gsi_base, u64 *phys_addr);
> @@ -629,7 +629,7 @@ static inline u32 acpi_osc_ctx_get_cxl_control(struct acpi_osc_context *context)
>  #define ACPI_GSB_ACCESS_ATTRIB_RAW_PROCESS	0x0000000F
>  
>  /* Enable _OST when all relevant hotplug operations are enabled */
> -#if defined(CONFIG_ACPI_HOTPLUG_CPU) &&			\
> +#if defined(CONFIG_ACPI_HOTPLUG_PRESENT_CPU) &&			\

Trivial but I think there is a tab to many before that \

>  	defined(CONFIG_ACPI_HOTPLUG_MEMORY) &&		\
>  	defined(CONFIG_ACPI_CONTAINER)
>  #define ACPI_HOTPLUG_OST


