Return-Path: <linux-arch+bounces-10235-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB073A3CD5A
	for <lists+linux-arch@lfdr.de>; Thu, 20 Feb 2025 00:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AACC63A9314
	for <lists+linux-arch@lfdr.de>; Wed, 19 Feb 2025 23:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876501CAA65;
	Wed, 19 Feb 2025 23:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="mC3T9HtJ"
X-Original-To: linux-arch@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazolkn19011025.outbound.protection.outlook.com [52.103.14.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FAE23E259;
	Wed, 19 Feb 2025 23:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.14.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740007259; cv=fail; b=rzXLK5GfrD7ot2oo1NqR6ndA5F7B+fKkFjAEYEDmOfNBc25O79xJZhdSo52fxSEkStw1+cXKHh0009PIS6guDVvuqpFuzjX2Ld+tWT63X0BrrLaVF4ANuOdI0U3VcbHMrakNwQtl5sKhMxgk03pgPCri87OYlDwPnsSPm+umW4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740007259; c=relaxed/simple;
	bh=HsLMWCu7ZOLOnATz6hojYrHs+CykqLsS1b80A33f7LE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=muZ/gTJf5dYCplqbfyl0UiaJxF6cxn0wtM/nGrAtGRqu/aFdb4SyccbzbhfrRDmuEkaHcLsu+kqM2x7jS+xeVpUpnte+G4UVXstM0+BPxottc8l35KsL6FtwFSZ4KEw6bx06rqJXzEzWM9axkbnhMQwUGhfPieMZBc02aME8VJY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=mC3T9HtJ; arc=fail smtp.client-ip=52.103.14.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ESj1qHWscpFC1W4k6gvU67FF2UBsv+JUqMIWPPypnBtsHmiWsO3W4FrthUAZuFjt32ju37rQ8MnOT/AlbPxkwEXop3pDjx9XvVw423s7GrwdMVfY9blEC/snx7wzu4IlkoIzSPJLO4Ua/W8mkZK/olQTbdHjflRQIYUmkG3/sYnp3aLNi7tK8ef52ttZeqTaiy3CHoGfPAObJtumbIbbH77a75L9FFraTy3f0oHxhyy9/SGSJFEfVqWYMv3FGk/bc0VYESnXAB3F9oyKXdjKdJ+mleF9lbJaeguoq54Hxgbj/8BmJqo4MeaXsAXrwAzWOxdBZ4XZQr7X6dlDKNVmYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pcn+q3P/97V/T4nmJalmllKimkCpLU/zywsJ69ViBt8=;
 b=J6hDDQ+oEpppU7Mh81OJnn1cgqxvLTIll18tuaEwkWdq9WCr5ThpnecRsp4gYWXeyro/TLUjQrtSWuHo8A98BAUlIsF+BfOm5uwXD+e+rYWQQW3ABguBZ96FmYopVwwEMd5qlWQDD10TNBXaAl+5GDT/obaDmM6mzB6XYgc1yqKI83vq+ETPBUNFBR5XFFXSKGleqoGa5hqpMT4OPl3HTElWqffMRzot0u7VkFWMs4jR1Jmv4W4TGkRorQQ8//h5CZkdaQFT8/o8xVPg5Uh5tHAZ77jDocf10f/wkMeJQEUlS/qtTWHI/TE3yl9/oApAo7s5AhpOkKwE5OJRkDPC+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pcn+q3P/97V/T4nmJalmllKimkCpLU/zywsJ69ViBt8=;
 b=mC3T9HtJqEV5+xmS4rt3oxL2weTAuX9C8TVzecqJ2QjFvXarLmRDLcJMVZNH2dau9SQUI3508hIc+nqPUGgkO0GCp+RvXqef66zQMTJAC35SmkmyZnPgKfjfvYFbUACcDbDgMIYrjETJfQM9HtJ1+Ndh6E1/OIgzMyZiGEfI11ZxbyihrDZES3bR/nAR0qgNLDZ9b3kfWAIjtWWLdtOPe2chMahK6EHCpHQenuSaew+8/Se8OCT9O2o3346i69jiGQhByhX2XtqZ+vn7xPUuIfVk9txkqAkql8iYeofVcb2ASxhSVxdrJIyFL9/U6BqM1KU3B9G6OrwaVC4J7AFZAg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by MN2PR02MB7021.namprd02.prod.outlook.com (2603:10b6:208:20c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Wed, 19 Feb
 2025 23:20:54 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8466.013; Wed, 19 Feb 2025
 23:20:53 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Roman Kisel <romank@linux.microsoft.com>, "arnd@arndb.de" <arnd@arndb.de>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "bp@alien8.de" <bp@alien8.de>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "decui@microsoft.com" <decui@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>, "hpa@zytor.com"
	<hpa@zytor.com>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>, "kw@linux.com"
	<kw@linux.com>, "kys@microsoft.com" <kys@microsoft.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "robh@kernel.org" <robh@kernel.org>,
	"ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "will@kernel.org" <will@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>
CC: "benhill@microsoft.com" <benhill@microsoft.com>, "bperkins@microsoft.com"
	<bperkins@microsoft.com>, "sunilmut@microsoft.com" <sunilmut@microsoft.com>
Subject: RE: [PATCH hyperv-next v4 5/6] Drivers: hv: vmbus: Get the IRQ number
 from DeviceTree
Thread-Topic: [PATCH hyperv-next v4 5/6] Drivers: hv: vmbus: Get the IRQ
 number from DeviceTree
Thread-Index: AQHbfO+7wRnkj4D6I02VQYSXcaqbprNPT03Q
Date: Wed, 19 Feb 2025 23:20:52 +0000
Message-ID:
 <SN6PR02MB41575DC25ED52C19DE237125D4C52@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250212014321.1108840-1-romank@linux.microsoft.com>
 <20250212014321.1108840-6-romank@linux.microsoft.com>
In-Reply-To: <20250212014321.1108840-6-romank@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|MN2PR02MB7021:EE_
x-ms-office365-filtering-correlation-id: 73f2a4ee-8ff6-4cb0-cd7c-08dd513c0deb
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|15080799006|19110799003|8060799006|8062599003|56899033|102099032|440099028|3412199025|12091999003|41001999003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?hkSdkZYMXd0NS7JkIQ6oyUKggRlW/bkdU3VWyLhc2zHbTauB9XlJGvt4lMOX?=
 =?us-ascii?Q?xfhRTK+bGPeBY9qGnBodAKi1srDLKpynALaBeu7iI640H/d9EfhH+U/rTNxW?=
 =?us-ascii?Q?CyMx48AvRGoTej3bDRhM+tsRC7FS/puNvBNQqRk/ML+1qKoL6qhNo6uCiKsj?=
 =?us-ascii?Q?AFGmql8nwIBS/VR3rxV3Vq/TnkHDKivjC6oI3SfPLYFClwhB8tDmYeuq2LuQ?=
 =?us-ascii?Q?4xU1OFjE9AZjY9c46vcbHibrpObm6CDENiP7eOodZXe5mNHFSkSQ798OugQk?=
 =?us-ascii?Q?M//TFOTXemNNB/f4vkt1jTa48XN6415QgOYvL02lgM2mknPGPSAocHKtt6rf?=
 =?us-ascii?Q?Y8uAWiiY02BpWQroY9ZBv2bPQNbybLxcsx2HL5dx/yYxvNHmk3YiqKMAyP1x?=
 =?us-ascii?Q?iMf1pQwL/5JPM83nuziIkaogwmAMtHXlfnoL/ijilsVd56gSEYLWH/jNcALi?=
 =?us-ascii?Q?xlmaPmgAbqQYC3VcNtEKIkJuhA4CEVHcMG+TTB3inYt7N5++q0m5/Y/A9U6m?=
 =?us-ascii?Q?qd2ZALw8m7y/XPzOqTLRdUo1naQMid3GsEv/g+pKdiT3E2pFDIKdq0Iyfh9l?=
 =?us-ascii?Q?4qtHmKlgL8emEMVd3vGc91JpYE8TQnIezBcW1DWLeAzQklbYObnIt73mzccv?=
 =?us-ascii?Q?qY9VPaqmaa1jEIdd3irbf+DU+A9Nu6RVzsW+wDABejhDUNYLNCCCroLgVWVI?=
 =?us-ascii?Q?QDIBAsFDgVelgotGd4ORhoNTxCo3bZ3T0mDfzpGeJul9ORR+DIpCuCrKydfK?=
 =?us-ascii?Q?KcyqHCfYyjL0HHR1G5W/RonM+pV9ljGQmr2GyZu3B/ZmODHWcQQrUpHYb2ES?=
 =?us-ascii?Q?oEaSOjbnw9JNJ6mHBIItBopscNSas3LxrPvO7rWiYok2GAEwzM84yLXhJqH8?=
 =?us-ascii?Q?EcpmX3Rp2izxk24DiGujRDTOBCnV6Q1DSgrgLpvh7omKleBqAopuridYH8O4?=
 =?us-ascii?Q?RLareqfb/tacKZ95u6BWQeDK0wdo7gWs05IEFnYKugD5+VgauirTK/cAQvuF?=
 =?us-ascii?Q?aZOp+PvwZ+w4GuMaMo2C4mx7lq+iJPGdmdQeNssvSh13gt2lCLTnch+gVbIm?=
 =?us-ascii?Q?4GxW9zqEYXzVBm+3amwMgUBaVlvSsVxsEGxkMpuA+HT4fL714Jo=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Oxy8GvTlLJpR4KQLIoxJRsAHci3MqXnqRVLEg2jP/Cai9eSKC6ay3cWZL1JM?=
 =?us-ascii?Q?XSX9jNuKI0uf+pfTceFJkQsOHo0Ew+jwsABmPFZf8A463us7FvGhCYoysHlv?=
 =?us-ascii?Q?8IIdQEwsQrFyGNle3PdGRM8qj58mq1wApegabs7eTcwx01nkhobmwFDBNuhf?=
 =?us-ascii?Q?OLVudckY/ywByDTqOtqbht7yJ+TAg9lSjn70w05j4eKWZUewgw2YDVpDV6sf?=
 =?us-ascii?Q?8lpwGDJfmNR6ga85wOD4WwrZmG1feDpNu4vbMURmPoSnTECU0mcLjBF9jIYY?=
 =?us-ascii?Q?lf5TTN1BIz3akH3zjxwzFRlN9C75uAbhMP7fyzJMUXo2BSBfEfut3ZYfK4Aw?=
 =?us-ascii?Q?I9EVF4yTPwNXxlyjrAg7I8bTF5kkXdTnKZ0p/nO0c4hl4w0PyiyF5++GBCsf?=
 =?us-ascii?Q?s3sSmItKLpK9UbSBO5bOJ8nFN0w2ahiEbGXiVWQnqhehUtHaX8M7H1LU2zFG?=
 =?us-ascii?Q?mzQwZ823iUOP634WZ6pkUi4cU08MCmw8FCj0fMr3q7YvfWxI/mejot0vGN+d?=
 =?us-ascii?Q?T1PDrXHHwhiF7u014hNXmH1c9ckVojJs9m3DdpgIRuXOutTxPziyBNqn8ZBQ?=
 =?us-ascii?Q?O8JIU28QefGKU2C2+rdCAxSF6Dv7OI2o9Mfkf+hJv8osZgxc3wYSICMcGhLK?=
 =?us-ascii?Q?u/xPTL49lroTjuvw1bHPwr4qH+i8h3fpdiQNvn6BHocwGkS3XvetCSsoOaB7?=
 =?us-ascii?Q?IVdHT6aY4i0n6J6naFiIGH0JF/v5R30Vo/detBPxn+NhCepsScmKS0yRTqHI?=
 =?us-ascii?Q?CwgHNTQIAM5MSU1+6l1p1EiYAf2biQADV+nDn9ukAbr22yvOs/lYG4K5TJa9?=
 =?us-ascii?Q?bBRLFtq22imWNLoCIwHSH8XsN5Inxk0LyAvHCSdcrfTFbjYEthwVkb9hEYGH?=
 =?us-ascii?Q?pNqMFtRKp9brRa6IPDr3HAa4ZL7IrvikCYNH7OTvByFGsLRi7TIzG4BgFoL9?=
 =?us-ascii?Q?SBv3lku5kxgIkBN/AKaLOmfL38FtABaWtywVDNoIuIQE9NZK7xPhJFiK5nZ4?=
 =?us-ascii?Q?ArMkZHh0CSILMLhY05uEvRbsYVdy9mPKAnFkP//XDP87Sjh4mmqe/qZayjBP?=
 =?us-ascii?Q?WuTtt0UqNyFE3ZV1RQBekiSGLuXdVIG/ljznyjB+vtpJt1S1lF7qK5RnVwiC?=
 =?us-ascii?Q?W34rDu4zRZ7B2F/0rww8gaQYM1nnHqheEiiE2fKN8Y4bNCLOS8pD2hNEVhf9?=
 =?us-ascii?Q?C4imYq3DjCu9anmoVrq+8Hjdyb93NFJuBUR1fsCP5FKmIwwfsB5U98OpOOE?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 73f2a4ee-8ff6-4cb0-cd7c-08dd513c0deb
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2025 23:20:52.9725
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB7021

From: Roman Kisel <romank@linux.microsoft.com> Sent: Tuesday, February 11, =
2025 5:43 PM
>=20
> The VMBus driver uses ACPI for interrupt assignment on
> arm64 hence it won't function in the VTL mode where only
> DeviceTree can be used.
>=20
> Update the VMBus driver to discover interrupt configuration
> from DT.
>=20
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> ---
>  drivers/hv/vmbus_drv.c | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>=20
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 0f6cd44fff29..9d0c2dbd2a69 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -2335,6 +2335,36 @@ static int vmbus_acpi_add(struct platform_device *=
pdev)
>  }
>  #endif
>=20
> +static int __maybe_unused vmbus_set_irq(struct platform_device *pdev)
> +{
> +	struct irq_data *data;
> +	int irq;
> +	irq_hw_number_t hwirq;
> +
> +	irq =3D platform_get_irq(pdev, 0);
> +	if (irq =3D=3D 0) {
> +		pr_err("VMBus interrupt mapping failure\n");
> +		return -EINVAL;
> +	}
> +	if (irq < 0) {
> +		pr_err("VMBus interrupt data can't be read from DeviceTree, error
> %d\n", irq);
> +		return irq;
> +	}
> +
> +	data =3D irq_get_irq_data(irq);
> +	if (!data) {
> +		pr_err("No interrupt data for VMBus virq %d\n", irq);
> +		return -ENODEV;
> +	}
> +	hwirq =3D irqd_to_hwirq(data);
> +
> +	vmbus_irq =3D irq;
> +	vmbus_interrupt =3D hwirq;
> +	pr_debug("VMBus virq %d, hwirq %d\n", vmbus_irq, vmbus_interrupt);
> +
> +	return 0;
> +}
> +
>  static int vmbus_device_add(struct platform_device *pdev)
>  {
>  	struct resource **cur_res =3D &hyperv_mmio;
> @@ -2349,6 +2379,12 @@ static int vmbus_device_add(struct platform_device=
 *pdev)
>  	if (ret)
>  		return ret;
>=20
> +#ifndef HYPERVISOR_CALLBACK_VECTOR
> +	ret =3D vmbus_set_irq(pdev);
> +	if (ret)
> +		return ret;
> +#endif
> +
>  	for_each_of_range(&parser, &range) {
>  		struct resource *res;
>=20
> --
> 2.43.0
>=20

Having to do the #ifdef HYPERVISOR_CALLBACK_VECTOR is
unfortunate, but I don't immediately have a cleaner approach
to offer.

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

