Return-Path: <linux-arch+bounces-4423-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12EB58C67A7
	for <lists+linux-arch@lfdr.de>; Wed, 15 May 2024 15:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7276EB21203
	for <lists+linux-arch@lfdr.de>; Wed, 15 May 2024 13:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2814913EFE4;
	Wed, 15 May 2024 13:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="P7ink8nq"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2027.outbound.protection.outlook.com [40.92.42.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A1E136983;
	Wed, 15 May 2024 13:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.42.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715780696; cv=fail; b=txxOgGutPpbjOprJvO+9GfcsJibixzHMwN2SJIoMAXUHNzIkFLJHIUTD9TfQXRiQqQqIan+WJLCFoeG2RNvW4ts+L4CsXLj+8VoLzKmejw21y1c27c7du3ANJTWYCO88wxC0aERgFDgXXb1Qa3KI83AwJDsZA5RUXeW4GyhIoeM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715780696; c=relaxed/simple;
	bh=7doiprbwB+abV/c+9MY3bxd9CEQwcjBqbHJrPQ6rO5A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RImZBHJfxiiGfJB2XqQY903BQMlFWB/jY/yODA9luFmnQxBLPZvhWTOanSXKVdob56qGGnOnQmmOVnqwkSh+647hLPvCXZJsQQEiDoc785Agp7rLlNH7LfrsmUkVEhd3mWpuULSHC2i+L2bZczXT/wnb2jq4+hn5mDyLzbI0e5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=P7ink8nq; arc=fail smtp.client-ip=40.92.42.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TkSi3Y7/+Q641Khjyy9Jy+ZAzLEDYyV61W1TAQ3RP5i8BunnA2YHWRF5Rrot3xzwVtmBCr6Hth7seYlzsFihXpJru/8vYWBz75RIQrcQ1ZbOvoNMRTFe82aMHNMWaaT7oOYAASZsZkvbOLuPrxHo4sBjo3LjoFJcy0pKsl9vG0t3uZn/Xxu/aWtMOllxE4oY3p3yu1ZS7nmv7zb67hxUzj8sSPMtTxTet/ciJ9XBVw0w3D4x+a795ejwPraWJr/dF5J4XcWWMm7mWmHUUeBxBOfqQZhEV6CE6leyhF7sGygz1zR1MTrCB4maiZN9sAr6fznwFfq5Ar1NYYfNI62jtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mYE3iRz+ZJKA3AF2T3De1tl95EhlJ4kdssR/7uGpuCA=;
 b=ocwxQXE9scVADPlMqkG8Ih6KjA0Uxo+3S+cPZe2lwz7NbKa0E1ni2REwIKmFkB57DS5zmDZ7eqWuqSn8+mNjKlCtv3BNNWOZKqI3boxkBHmZLsEVlofCaCBUWsBKNvjt/eI3c3i6SUyhbmm8MONeAd3L2HhHo3WdLiIKt1exYWkaLq9tVGQunLQrplgq0S76nwtqx+DfbxcOhyXPuC7uMAMifckvJ622VwgNpL4LqcTFbdn6rH1JblXs/YV9uAaMuOxjVPBFVrp2U0qsLlIkIOw4isJnywnTCNdKh9EHIWw408Hbjb95LDREpXZImi73lMHKq65vIKaPQU9euCmHGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mYE3iRz+ZJKA3AF2T3De1tl95EhlJ4kdssR/7uGpuCA=;
 b=P7ink8nqn67NOTJVE5MKKbJsQL6qyuDzNDhGE5B8ckZXdF/muilL/+BRiQGXl2YvvNf0bOi6R6+ZZpShcBGyNz3nd69nINxjkRNz7CFSiJzkB9qwh+Zm+o46A0c8MsLtvvhdEoZRk9tyIB+0faeKI25P0xLMxqsb2SN3pZNwy1G2feK9IhJYuLbEuVoXVpRCV/wA0Zm29e9sY7lKQrKShRkXNuzXkXTvwZ+MpHnPlo2uyJx8/mEExH7+j8RgLnwPBfffoU3f3OZAzhyC70Vsopw5y3oiGxci1gTptyzYEGkfXMJbtFQHTzmFPElr4aUPb3frC8oyssn+YIpQn/Ryjg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SJ0PR02MB8465.namprd02.prod.outlook.com (2603:10b6:a03:3f5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28; Wed, 15 May
 2024 13:44:50 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%2]) with mapi id 15.20.7544.052; Wed, 15 May 2024
 13:44:49 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Roman Kisel <romank@linux.microsoft.com>, "arnd@arndb.de" <arnd@arndb.de>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "bp@alien8.de" <bp@alien8.de>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"decui@microsoft.com" <decui@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "hpa@zytor.com" <hpa@zytor.com>, "kw@linux.com"
	<kw@linux.com>, "kys@microsoft.com" <kys@microsoft.com>, "lenb@kernel.org"
	<lenb@kernel.org>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "rafael@kernel.org"
	<rafael@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "will@kernel.org" <will@kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>
CC: "ssengar@microsoft.com" <ssengar@microsoft.com>, "sunilmut@microsoft.com"
	<sunilmut@microsoft.com>, "vdso@hexbites.dev" <vdso@hexbites.dev>
Subject: RE: [PATCH v2 5/6] drivers/hv/vmbus: Get the irq number from
 DeviceTree
Thread-Topic: [PATCH v2 5/6] drivers/hv/vmbus: Get the irq number from
 DeviceTree
Thread-Index: AQHaplCUKVZJccIEO0en3RaA+UinKLGXlBTQ
Date: Wed, 15 May 2024 13:44:48 +0000
Message-ID:
 <SN6PR02MB4157473A48D58D545102614BD4EC2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240514224508.212318-1-romank@linux.microsoft.com>
 <20240514224508.212318-6-romank@linux.microsoft.com>
In-Reply-To: <20240514224508.212318-6-romank@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [EBAvK6iTYSLSwdj6QuTwrbcYMASsMKAx]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SJ0PR02MB8465:EE_
x-ms-office365-filtering-correlation-id: e48274ca-21be-4771-e21c-08dc74e53081
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199019|102099023|3412199016|440099019;
x-microsoft-antispam-message-info:
 9CydlIp1o7+0tSRHqpZo8b5n8uHgRjHfnRkyqBYktIIzVAtxAd2KDyGXoD8kgcC65Tnx6rmRcSWSIU29OHwvYEFI5sgIPW9vwcERD5wQVBr1wzaD9ZV9O0mB4cneFSM69oPXRLgF4AY/KycTRyb6JW5YDnGgV8xwvOgWSieuyL8Rwt2b1LSKK/y89o/aaHbuV51E+gE9sGlWBjthQFTlCLVDSNl3hrusafPBwRw+bMGjLMHnLMe/GHL4vjbgG+7sHbU9+/bbmEgs+Eeo9iJsAem7BhAR5EZF6pomXvSOtq65jieRWHg8Cag/dl3bvvI456d5KloavQCRguS2cU1B/jl27zlnggyhpAgKrzsKqxU3W/pDYSytieGZTADHsCb2yKqHR1AChtU4VQcgvqEPQt2NHca11qGKtqpZxVuBqGrh5izOxWlfEWPJI+dQHXcQ3wWfqqVn86GfVQSisMqp1vK9Q/cYdKmcWXbFypaxd97NYtzNv0kBE0+OBnjf5ZvjVQ9IHHsxLM7b+8WSdwu+4uJJnhmZn4FFbR5ElawQzwSuH3xaAZAJz2C12oQfQpmx
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?2LXEXymtVwEG5EWHEqJMH3QCyCLduJVkJiAtvolQ97hHmHqPdACMLqG/8Uky?=
 =?us-ascii?Q?CGxkrQHkurvobOr9GResDK/wocUQlrEnRKABCuJg/NcEJfCtoMa8mIuomrq1?=
 =?us-ascii?Q?q3bPgkxkBdFplynxD4jpUXV2U++GUBe+H/iNNsbx11w4xqsTpMDMDFz5NFE2?=
 =?us-ascii?Q?Kh2GLKWDgpxJUTeCYgYpZKvY1BvqnXXtv1+ka6DGjtcrgcxuHC3W8/GNhM6h?=
 =?us-ascii?Q?oWK1gijudQ3I5KoQZ+IAUigVLF+GUqZ/m5piYAKNpRAwnjmRuMlptiHxypw0?=
 =?us-ascii?Q?GXLX2jc1eXiGZK0BNawJWS8FlVCtd+2pZluuGdggpFGioyx0+gJvY6JpBWLe?=
 =?us-ascii?Q?XhwJO11CDFcGH8PeYoiUr1QjwGNVjA9EgKMEAj+I4vOnnj/W7BpqdxOByJze?=
 =?us-ascii?Q?94ugg9hTsvkGjmxtvMcLZNWSpdAJYAUGH+yXhO7MEWAxcb+p7ODC19pudnLD?=
 =?us-ascii?Q?mnTHJirVyCDshOf1POOUlecHZsp7t4eM5+d+a+/Nqs8kTsK8/kHUJPR/5dq5?=
 =?us-ascii?Q?UkK6hVPvH/+QpcnCPFHBvCQ2ipOWFL5Q3rdi2LZQ8gdOII/8cV0nXYs2CefU?=
 =?us-ascii?Q?kblWdsTYaw61PD+TGEtU4zK87R67B238KJ5fnx6sG22dG49IupJWDGoTzE2J?=
 =?us-ascii?Q?sOd/G37qSdYbScU5F3cFcQLQHecr9TdrYDktdkJSJogKzN3hm/FGccMqcdpy?=
 =?us-ascii?Q?bRxbCEm8hGjWENOyNAp5MV1rHGUboPm2E4odxlCtdnSnz+ARu8kIDoCgri4y?=
 =?us-ascii?Q?a0VcGa5VmTSmmlTzbYLriyg1ZqffpSNaiEv30kki+4YFJJ+naJHpThQ0Bphi?=
 =?us-ascii?Q?GzvMEv6WYXsNI1YpIIhSN8g1H7ydq7/eSuXSMZJxtozN0+ktqiXea7DVre4r?=
 =?us-ascii?Q?4CfKU34PHLyMvSWnA+iXGLylq0HYhGiubPbQ9bXcPL3d4TS5+J/J+uA+N2Ox?=
 =?us-ascii?Q?qsHH1/WSZ+PGim6rCL7ffyDHm3WSsEmzS2+XF09jCwYq7UwJPbxKUG29RAjf?=
 =?us-ascii?Q?n4AfGMs1ySknQ5SA2JsLVKR0E7ahlLt6NqxonYuIIQW9/zDPbOnvk6ASTa/m?=
 =?us-ascii?Q?/heI8OdVfY9uD4bE8ZZkSWgYer0E8mgWhyTvqGMOzlqSPTHYc5InqZxSq21P?=
 =?us-ascii?Q?/gI/I2y9zdxEW8M+5iX7PBLTaiDGRVfGdf1Z8wIJ0xuaHPZL2y4ooq9gJXyE?=
 =?us-ascii?Q?H2tTxs8gNLY3u/96TcqW28CtbV3wI6F8vJtUey6xp1gop1PMCoYL7srCvoI?=
 =?us-ascii?Q?=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: e48274ca-21be-4771-e21c-08dc74e53081
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2024 13:44:48.9614
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8465

From: Roman Kisel <romank@linux.microsoft.com> Sent: Tuesday, May 14, 2024 =
3:44 PM
>=20
> The vmbus driver uses ACPI for interrupt assignment on
> arm64 hence it won't function in the VTL mode where only
> DeviceTree can be used.
>=20
> Update the vmbus driver to discover interrupt configuration
> via DeviceTree.
>=20
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> ---
>  drivers/hv/vmbus_drv.c | 37 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>=20
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index e25223cee3ab..52f01bd1c947 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -36,6 +36,7 @@
>  #include <linux/syscore_ops.h>
>  #include <linux/dma-map-ops.h>
>  #include <linux/pci.h>
> +#include <linux/of_irq.h>
>  #include <clocksource/hyperv_timer.h>
>  #include <asm/mshyperv.h>
>  #include "hyperv_vmbus.h"
> @@ -2316,6 +2317,34 @@ static int vmbus_acpi_add(struct platform_device *=
pdev)
>  }
>  #endif
>=20
> +static int __maybe_unused vmbus_of_set_irq(struct device_node *np)
> +{
> +	struct irq_desc *desc;
> +	int irq;
> +
> +	irq =3D of_irq_get(np, 0);
> +	if (irq =3D=3D 0) {
> +		pr_err("VMBus interrupt mapping failure\n");
> +		return -EINVAL;
> +	}
> +	if (irq < 0) {
> +		pr_err("VMBus interrupt data can't be read from DeviceTree, error %d\n=
", irq);
> +		return irq;
> +	}
> +
> +	desc =3D irq_to_desc(irq);
> +	if (!desc) {
> +		pr_err("VMBus interrupt description can't be found for virq %d\n", irq=
);

s/description/descriptor/

Or maybe slightly more compact overall:  "No interrupt descriptor for VMBus=
 virq %d\n".

> +		return -ENODEV;
> +	}
> +
> +	vmbus_irq =3D irq;
> +	vmbus_interrupt =3D desc->irq_data.hwirq;
> +	pr_debug("VMBus virq %d, hwirq %d\n", vmbus_irq, vmbus_interrupt);

How does device DMA cache coherency get handled in the DeviceTree case on
arm64? For vmbus_acpi_add(), there's code to look at the _CCA flag, which i=
s
required in ACPI for arm64.  (There's also code to handle the Hyper-V bug w=
here
_CCA is omitted.)  I don't know DeviceTree, but is there a similar flag to =
indicate
device cache coherency?  Of course, Hyper-V always assumes DMA cache
coherency, and that's a valid assumption for the server-class systems that
would run Hyper-V VMs on arm64.  But the Linux DMA subsystem needs to be
told, and vmbus_dma_configure() needs to propagate the setting from the
VMBus device to the child VMBus devices. Everything still works if the Linu=
x
DMA subsystem isn't told, but you end up with a perf hit.  The DMA code
defaults to "not coherent" on arm64, and you'll get a lot of high-cost cach=
e
coherency maintenance done by the CPU when it is unnecessary.  This issue
doesn't arise on x86 since the architecture requires DMA cache coherency, a=
nd
the Linux default is "coherent".

> +
> +	return 0;
> +}
> +
>  static int vmbus_device_add(struct platform_device *pdev)
>  {
>  	struct resource **cur_res =3D &hyperv_mmio;
> @@ -2324,12 +2353,20 @@ static int vmbus_device_add(struct platform_devic=
e *pdev)
>  	struct device_node *np =3D pdev->dev.of_node;
>  	int ret;
>=20
> +	pr_debug("VMBus is present in DeviceTree\n");
> +

I'm not clear on how interpret this debug message.  Reaching this point in =
the code
path just means that acpi_disabled is "true".  DeviceTree hasn't yet been s=
earched to
see if VMBus is found.

>  	hv_dev =3D &pdev->dev;
>=20
>  	ret =3D of_range_parser_init(&parser, np);
>  	if (ret)
>  		return ret;
>=20
> +#ifndef HYPERVISOR_CALLBACK_VECTOR
> +	ret =3D vmbus_of_set_irq(np);
> +	if (ret)
> +		return ret;
> +#endif
> +
>  	for_each_of_range(&parser, &range) {
>  		struct resource *res;
>=20
> --
> 2.45.0
>=20


