Return-Path: <linux-arch+bounces-13070-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD41B1B9D5
	for <lists+linux-arch@lfdr.de>; Tue,  5 Aug 2025 20:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B16E3A7A8E
	for <lists+linux-arch@lfdr.de>; Tue,  5 Aug 2025 18:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B0F293C67;
	Tue,  5 Aug 2025 18:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Eka7C6co"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2082.outbound.protection.outlook.com [40.92.19.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0883C1D416C;
	Tue,  5 Aug 2025 18:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.19.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754417380; cv=fail; b=r4QAkssxKQSO56cFUnc6d+vQ78jqNxjv39bah/bSOlNSNKDpdCeB0Tk68+DOSnjDUJ3PRgL8bdt5i9nEH3CEhcucZmpJ7S8WtGgXo+Mb0AckdkgvzMEaLHvYbnY97AlCzw/fXpq4aoMHIR9wIc7j9pnRkzUjt4TxkwBK1riVxqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754417380; c=relaxed/simple;
	bh=uiF2iu/OWYuxc+2qLAAalKMAl5Z4L5IhtZT3Ul7f9Kg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ih5lUxdqH+dZQcA9zRKgq3zqPcye7vJG7TDVyb9rbnfSM+7VYPgNUzgaEQrDIPEBOvMqRSQe7ePW27g4HnocMW41XXJ558R8ADyJnV4i7PLfrrvLB2VQ8uTK2juTq5ZWnejLqBV/xnA6jJpXXQ+cHyFA4IzpbQOhfH2Tag/fUkE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Eka7C6co; arc=fail smtp.client-ip=40.92.19.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ys6ozgB+MFkkNp6CKM/ujQotDNIUu6Qu5wAs8MqNGa2LdUESJZICnLRG4wNxi9PgvDCJUdS2Wyb/vp+2DuUHnTXD78FrC5sNUcAhZCYZRtTMKK5OZFrccPYcRodI4CjPn6tEI8WCx0flxoWVOm70pcP7+zKSd0K/LVnqiuJQrrY5+MmMBlwe3NvXMzK7V14YrH6UeSWXdofrP/b64Z9JKk/EVkHSsebgPRv5vIUMnZbR2E8dfwnhzUSacN7y7w6TbUuW+PCKNhgljeOPO5erg3vnOPxLqJNZQC5CByHfCZiEIrKjgWA5eEZ8wv8gbAoSGHi2PrwoW7xOrBJeDcx8qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QOqKFv/yKZBfhAetkCd3sVSr1Btp5+fp68P9HA86p5w=;
 b=Jx5mfZnkXAwzcIG1WVL+uJ4HjmxUuFOvRHCLMrscCXXf+bdqGYTZbBNNUzn932i4jsvFxXAxTFgA6u/3Ih5DNGCWzZan5R6f5K6RNrbFD3Lvv8dxZedlUAusuldpOOuluJRqE2f2xxWHnOgL92BF/BrH8xYO3D+S2mUNC/Mo4aGZJSWoHhZMzkt8CwicZxNUl5vYz3u5uuGMkEkt+TQOERbJqCoQUmEs49HlbtwN0MqvL2nRb7PF/Bq++lFgbJ+OSCsCXJIjUU7nLRtz69jVksqN6Po9sVxRY8pNEjx8Rk4gh77bqvE4WHEyxCH634s2Adrn3fauqGwITmeDBXkMUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QOqKFv/yKZBfhAetkCd3sVSr1Btp5+fp68P9HA86p5w=;
 b=Eka7C6corKlS0Ym3n52zagn9BFPlv3hbyvq8DopTdG5C2BXmD599trhEI9AQ91XnScTTfm8/ZhHmkeiJBxkx3ZXV+Yg1/ZRlR0lM6aHgw0w3bK4qsDts9ZqlXNP5Fd4WF/IHOM1perc84ZukXR0Pj1R5Pvr3frkLxcxMGAtkstOx1TsL7GxnV+qWcRGTw7YDZ/yxBD0+6j4sJsfLsMK/8EeW7jGgUKdj0mwDoo1G4Rg5pRLrlML/6JIQPNVScJ0jyNTXq4e6cme+ebx4WQVSEFxW9UL4Aku51r3e9cIHHUqUglQdpA5VEdDy+zuFI441f5c8TWCPN93JSEtWG6yI/w==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by LV3PR02MB9957.namprd02.prod.outlook.com (2603:10b6:408:1a7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Tue, 5 Aug
 2025 18:09:32 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8989.018; Tue, 5 Aug 2025
 18:09:32 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Tianyu Lan <ltykernel@gmail.com>, "kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "decui@microsoft.com" <decui@microsoft.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "arnd@arndb.de"
	<arnd@arndb.de>, "Neeraj.Upadhyay@amd.com" <Neeraj.Upadhyay@amd.com>,
	"kvijayab@amd.com" <kvijayab@amd.com>
CC: Tianyu Lan <tiala@microsoft.com>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH V5 2/4] Drivers: hv: Allow vmbus message synic
 interrupt injected from Hyper-V
Thread-Topic: [RFC PATCH V5 2/4] Drivers: hv: Allow vmbus message synic
 interrupt injected from Hyper-V
Thread-Index: AQHcBWphdWjqJHpq8UywLh13Jb+C9bRUW0IA
Date: Tue, 5 Aug 2025 18:09:32 +0000
Message-ID:
 <SN6PR02MB415700541E44263490781D86D422A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250804180525.32658-1-ltykernel@gmail.com>
 <20250804180525.32658-3-ltykernel@gmail.com>
In-Reply-To: <20250804180525.32658-3-ltykernel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|LV3PR02MB9957:EE_
x-ms-office365-filtering-correlation-id: 4bd10ced-d28b-4ba4-f7aa-08ddd44b3a50
x-ms-exchange-slblob-mailprops:
 7J/vb0KDx3idnJD6lc/nqZLIFT+Fye11MLDcraxAR1BMlAAt1BUUHXLMGGnkpNYWU5LzoXqLUBfPiZdIJlHj/Enx32znOc70P00RW3o0Hd640uXzLzHvlIW6wb/dBAzTgcam6xA3gLxlpvjj/laO60Xo6IStgYRnApjs51yJz3JmCOJDVpmA98ozgUzpLrngfegE5lIOj+RwK8bNNMBcD3b1MQ6pgg0TzUQbpraGYpbhTofxFcFTxDk2ZOvonx8ZJeNSzPBdSjMlYVznuETZU83Dg/L0m0FmZSMxKbhrr7xpfjenM0kmWZBMnMxjZ7/5gpQwPxA1vDwytBej5n5gsg3yMfBQ4EljwwXbop/tjXlLQV+Y5Z3oVWv7laovssmWwHWmHDFDmmteTNP5350PF058jOhLuuN3j/7IgrX3pz4BU84dO6Pr8L4up1smCJzDhv4+vMa8mp6HkMqS81TYH/JeamM8/imeVzpFEyIBBVkj5jL8DLdjdP+TRm9d+XpcbuZQoFi/WOM1hE6uWjrp2+0IFD/D0PXrWpu5iuv1coJxZUjcTrxvYjbkXctOrvBZ5kclnZz95k9sA5VNoWiUO3Xn9jmazDJrVzu4BQAnVS86Syckjbje1Wz6D2qoXaKC/LelCOkzgFPovVus+yzFir7Da5WUNvSyTA0CcRLepohZoTBJckCPDW23S4jUIg49TbAAzBLSk3FW7Xj2o0M1e68xOZmI01D0z1dCc/vTFYnAdnADtl1V+Ed0dzvRrskQzYtKyoF3PQ5CMFsHdzcLci8AfBH2ZQKFeMdSsOfityE=
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799012|8060799015|8062599012|31061999003|461199028|15080799012|40105399003|3412199025|440099028|51005399003|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?KR4OUdgLIvjUGoX7pdvhKhF2RZve7AW/SaeTudlfGTFTTnm3tmuaY+igLr7/?=
 =?us-ascii?Q?s1n44d6OSIWh/8nyXngZpwf1ZTCK4nbjiMVmwph8LE1V1DUsikUj6Q+TZwpg?=
 =?us-ascii?Q?Y+9DIOrKBW8CaMzv74Wzky5d5KS64g0l2hclePNr56J51qjDkTnWESxEmL9G?=
 =?us-ascii?Q?U0yuvxFVaTTg7NRkMKKyXvRw4stZs5wYQu2JNQ/2J4exMDLyJdVs3tblDsVl?=
 =?us-ascii?Q?8cU/iipGw7Qu/qOBXkqmMLw8FmqkAg+SPEkE3B89klT/YElH1LrisLsDkozQ?=
 =?us-ascii?Q?mxTEEXcMXpWNRysz2cHSaC2Ip+6A5HI1qVFbv9cEMJuWNV1NwFnuuOeiPsW/?=
 =?us-ascii?Q?HyLcJLjhkRzhpywBY7OR7r+0SHdp88HZFMVMzzbldl9I8q6oq9lqMxa0LRL5?=
 =?us-ascii?Q?zda/7acD5pdm8fA2hAFmgLOdG2dtfwKZotcYDqQMk6s3MIT4DMtDoZeby2dQ?=
 =?us-ascii?Q?516ppVNWOCTwsEX1VFoVldneyZdjNjbpbwWbiPNVT6zpdHM/WdgKiKu7k4aR?=
 =?us-ascii?Q?uzC7yBapjU4BJjwjIgweqc9W+NGTg+5gdU2xEQnPYh+PwDztUcaYo3+drHs0?=
 =?us-ascii?Q?m/lhYOpZFgpEozSzl0rz9F6kIAgjcwEJf2s7tzq4arLnEpuhIA6hZI5YseuO?=
 =?us-ascii?Q?LdD+MRH7WqCryi+AG8MmbCaZCO8wpzIyPmDj1ujqTUGe9E8wHOwqsUTMlAPm?=
 =?us-ascii?Q?M4lcdl1mIQqf/shcI1saMzWCvL4NNq7MQVnhsqmGCtnfU2QvtSLtKJY1+iqM?=
 =?us-ascii?Q?/iyQVgZD6IJ45ZpBU0p0DFaLZ2fPx4qhve44nNdXSWQCeyc/BysHpHewMW2z?=
 =?us-ascii?Q?1euro1mW8j4hOMek5r45LyG99PkzqMude0N17GTYyMqwyptB41mxVCaBYTvT?=
 =?us-ascii?Q?ixijR+v28cv+VzyHDzE5SFjLF0X9bYziAEapvbF+AJArzhU5OT/BXcD0QOoE?=
 =?us-ascii?Q?WQuLNPryZ20PwDKg4CsKWWW/6E9UGYQrVuUwoJgQPlO0I+2NBzVQWh6b47L6?=
 =?us-ascii?Q?7QTkNm/Qj/BX4CykGUT24+WWcp/k1JJNoJBmb9nNlTG3UfRGwVLBMIueOwCT?=
 =?us-ascii?Q?YZmc8TealbV7aKHBGhTd6PImvmnBsfNcfqd6KSHr+mIeCVxrD2gXkGsSJM0Y?=
 =?us-ascii?Q?YLwxe4d15MYNNqtUC4AC6//vwLqeJensc3l0ez47lSOgKpQEenx3mqE=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?XkNtopDQS/0HtiIGV5rpxhEZTX5GiSf37D2yARaxbMMXZ443XdR3R3AlvSfx?=
 =?us-ascii?Q?SHFUV+cpjstN1R6nHMTHucpeTOX2T2jBJ2WC47SpqAW4vP8HSLCI4j2uM5jQ?=
 =?us-ascii?Q?QwhwV9VbXPPxl/FOmNUvGyEiK9r11JVPPS02bexJLiyo+W9rKwD9d4CAsT7G?=
 =?us-ascii?Q?EzX6J2o7JrzCICr7pt/1A56WAAOV9SyjcHCuZa3rLFOplIbJ1FmwuAnxaAGx?=
 =?us-ascii?Q?AH5yH80ZfWtvNxWSI7NfmP+dC8aK7fzZrXuOulQHT8a7CknM7GdL5h/0kGm9?=
 =?us-ascii?Q?LBLdPri5VspLnxpopkeRhMvPx+iF+DAkQA/krDZjQP6/jmPl/wg0tIzAsp+k?=
 =?us-ascii?Q?WlNSV3cVGUVkmqLXt5Zm/Xwc0aZuEO+MgjQWAKh8alatLaVAterQH9sSb+ak?=
 =?us-ascii?Q?bVsxFU5cgcNz7bvSLb3UUcgdYPscfonY8rX7r4v6s1CEmMSYeCxMoOLddLb5?=
 =?us-ascii?Q?MW05crIburxMVmsL/FSiQsnDUFtJQ9l+1pxkOSxxMcKTHpDC8hdaEVgRU+7z?=
 =?us-ascii?Q?Mkj6QByYtF7OIMvsjw5MIkKL7iTyfjtF206BhDGLxbIoyzrFi5ag3xym2ex0?=
 =?us-ascii?Q?5ZlBnURwieHXbtLXbSKEkyLakrDkJjRFq/hvNtN46ubVtKQiO25vrAnCwmop?=
 =?us-ascii?Q?Wik4d7Vk05gO1gmCynrPN2nwwZ/RDnynS7eltMCUxDQKKFoihMNFsVr3GDiB?=
 =?us-ascii?Q?zEgJEMUK2nfk/sbUMnx++eOuU01VoVAWkEpLGwNzTaZOu6y4oWcZE/jBCYJR?=
 =?us-ascii?Q?njj27iyf/iVRMbigLqxBQ5JBuuMjcGblm89zXTP4nv2YOzxxmRntSFuI0rns?=
 =?us-ascii?Q?8nrLEJIxS3Rlg03qI6P+CWEYLITSiMgSP8qIjnGR26YrfOjrlIiU/AebMt6P?=
 =?us-ascii?Q?M6KuoNbLjnaKrSClDyL2tbDVf8/Vf5Fjb7pphWhn2GQwGwBxxgQLYbdTKT4k?=
 =?us-ascii?Q?scWrMAxC2frNp8Jy3O662m1v4hEhHDtaefpH6Azl+6UNijE2dU1ohJjJL94x?=
 =?us-ascii?Q?ZfyCLQVjEoucistnTWPN2GuLXeANprooUbCshtJUNYg/8WBGBkVXYPwW+S53?=
 =?us-ascii?Q?BancfnTCXLKwAZuzD3hxAXF30pHUOti9C8+QXyaDLbdMT/eOHmtvtNLwFmvu?=
 =?us-ascii?Q?mrqBSHXGqTI3P4w0fgEwb7EcWgB5pXnI3SUtYwwBd8fL7MvLIl9ehT0jlK/d?=
 =?us-ascii?Q?15SaTf4XHdf0UL49zz+Ho4ul42XcYNo7PbM4z+7ML0+Y2vHiazI1qbILZhc?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bd10ced-d28b-4ba4-f7aa-08ddd44b3a50
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2025 18:09:32.2291
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR02MB9957

From: Tianyu Lan <ltykernel@gmail.com> Sent: Monday, August 4, 2025 11:05 A=
M
>=20
> When Secure AVIC is enabled, VMBus driver should
> call x2apic Secure AVIC interface to allow Hyper-V
> to inject VMBus message interrupt.
>=20
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> ---
> Change since RFC V4:
>         - Change the order to call hv_enable_coco_interrupt()
> 	  in the hv_synic_enable/disable_regs().
> 	- Update commit title "Drivers/hv:" to "Drivers: hv:"
>=20
> Change since RFC V3:
>        - Disable VMBus Message interrupt via hv_enable_
>        	 coco_interrupt() in the hv_synic_disable_regs().
> ---
>  arch/x86/hyperv/hv_apic.c      | 5 +++++
>  drivers/hv/hv.c                | 7 ++++++-
>  drivers/hv/hv_common.c         | 5 +++++
>  include/asm-generic/mshyperv.h | 1 +
>  4 files changed, 17 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
> index e669053b637d..a8de503def37 100644
> --- a/arch/x86/hyperv/hv_apic.c
> +++ b/arch/x86/hyperv/hv_apic.c
> @@ -53,6 +53,11 @@ static void hv_apic_icr_write(u32 low, u32 id)
>  	wrmsrq(HV_X64_MSR_ICR, reg_val);
>  }
>=20
> +void hv_enable_coco_interrupt(unsigned int cpu, unsigned int vector, boo=
l set)
> +{
> +	apic_update_vector(cpu, vector, set);
> +}
> +
>  static u32 hv_apic_read(u32 reg)
>  {
>  	u32 reg_val, hi;
> diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
> index 308c8f279df8..2ff433cb5cc2 100644
> --- a/drivers/hv/hv.c
> +++ b/drivers/hv/hv.c
> @@ -314,8 +314,11 @@ void hv_synic_enable_regs(unsigned int cpu)
>  	shared_sint.vector =3D vmbus_interrupt;
>  	shared_sint.masked =3D false;
>  	shared_sint.auto_eoi =3D hv_recommend_using_aeoi();
> +
>  	hv_set_msr(HV_MSR_SINT0 + VMBUS_MESSAGE_SINT, shared_sint.as_uint64);
>=20
> +	hv_enable_coco_interrupt(cpu, vmbus_interrupt, true);
> +
>  	/* Enable the global synic bit */
>  	sctrl.as_uint64 =3D hv_get_msr(HV_MSR_SCONTROL);
>  	sctrl.enable =3D 1;
> @@ -342,7 +345,6 @@ void hv_synic_disable_regs(unsigned int cpu)
>  	union hv_synic_scontrol sctrl;
>=20
>  	shared_sint.as_uint64 =3D hv_get_msr(HV_MSR_SINT0 + VMBUS_MESSAGE_SINT)=
;
> -
>  	shared_sint.masked =3D 1;
>=20
>  	/* Need to correctly cleanup in the case of SMP!!! */
> @@ -350,6 +352,9 @@ void hv_synic_disable_regs(unsigned int cpu)
>  	hv_set_msr(HV_MSR_SINT0 + VMBUS_MESSAGE_SINT, shared_sint.as_uint64);
>=20
>  	simp.as_uint64 =3D hv_get_msr(HV_MSR_SIMP);
> +
> +	hv_enable_coco_interrupt(cpu, vmbus_interrupt, false);
> +

I agree with Neeraj's comment on the placement of this line of code.
As I commented on v4 of the series, the hv_synic_enable/disable_regs()
functions have units of code that do read, modify, then write of a
synthetic MSR, such as the SIMP, SIEFP, and SINT. It's weird to have
hv_enable_coco_interrupt() in the middle of such a unit. In this v5,
you fixed the issue for hv_synic_enable_regs(), but not here for
hv_synic_disable_regs(). The call to hv_enable_coco_interrupt()
should go after call to hv_set_msr(HV_MSR_SINT0 ....), but before
the call to hv_get_msr(HV_MSR_SIMP) so that the read/modify/write
units aren't mixed with other things.

Michael

>  	/*
>  	 * In Isolation VM, sim and sief pages are allocated by
>  	 * paravisor. These pages also will be used by kdump
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index 49898d10faff..0f024ab3d360 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -716,6 +716,11 @@ u64 __weak hv_tdx_hypercall(u64 control, u64 param1,=
 u64 param2)
>  }
>  EXPORT_SYMBOL_GPL(hv_tdx_hypercall);
>=20
> +void __weak hv_enable_coco_interrupt(unsigned int cpu, unsigned int vect=
or, bool set)
> +{
> +}
> +EXPORT_SYMBOL_GPL(hv_enable_coco_interrupt);
> +
>  void hv_identify_partition_type(void)
>  {
>  	/* Assume guest role */
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyper=
v.h
> index a729b77983fa..7907c9878369 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -333,6 +333,7 @@ bool hv_is_isolation_supported(void);
>  bool hv_isolation_type_snp(void);
>  u64 hv_ghcb_hypercall(u64 control, void *input, void *output, u32 input_=
size);
>  u64 hv_tdx_hypercall(u64 control, u64 param1, u64 param2);
> +void hv_enable_coco_interrupt(unsigned int cpu, unsigned int vector, boo=
l set);
>  void hyperv_cleanup(void);
>  bool hv_query_ext_cap(u64 cap_query);
>  void hv_setup_dma_ops(struct device *dev, bool coherent);
> --
> 2.25.1


