Return-Path: <linux-arch+bounces-10663-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E2AE4A5AB9C
	for <lists+linux-arch@lfdr.de>; Tue, 11 Mar 2025 00:12:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0868F7A10DB
	for <lists+linux-arch@lfdr.de>; Mon, 10 Mar 2025 23:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C523216E05;
	Mon, 10 Mar 2025 23:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="YIYNDrxN"
X-Original-To: linux-arch@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazolkn19010000.outbound.protection.outlook.com [52.103.11.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7D71C4A13;
	Mon, 10 Mar 2025 23:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.11.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741648346; cv=fail; b=dypCC8TYBBpAFYRirALCFUaw+z9RnQWmVNMzLIMQ3mhmt2qp99hywbNlcl6NAWzE4o2lXGbrUGpdsUwRiltYtki9CALLoPwl4jBQVOL/+omQVvygpcHQ38KYnu8tWVPI5n2HrHmiDaKudV6GrUoEfDjGrZ3yb5hav2b8dTa639I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741648346; c=relaxed/simple;
	bh=5dlCNpVVbCOYrrbVcnjJ9AIhsw+ksn15EWiReEw4VyI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=U6eWBiFO+2R37Y9flyGvwxTpCzETs4s+TNBkkvXV4PS04gbDpJNDWSft7cPlserSkz9On8/qx+8qIy332Tb5OwVKhmTNjx3FL8evQ+hKT7thR1rRA4tztcz1kW7J5lrRW5gEkvIYn62ghAjS+pJOnK8PYnn0D+Fi7XkkBhjVAuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=YIYNDrxN; arc=fail smtp.client-ip=52.103.11.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fVZPwWggn61fpojjOmhmPogt4IA+Ff5lLQsQwzGLkl624bJVqf2yhQVHbrq20hQuxnKeCOw0A2FU3JcQHzTt+kc2R5XFl1ckDgovDyl3xD+JK81L8q1kmR83Yb2Os0yid5xAidNTvP4lCKO/dYFqroUJL7KLb+r8h4IrsnoKT8diWBNvIW3kCHfFPh8T1ZpMdN8pCwQlpKcSwX0Qbrf3V7Gfz5Dt4px7Z3TUKLKaD0PCqnNlaU6sqPVG9utP4vtcDeoIm67NJ7A0ms1W694Hf+vTtl8g6JgmjZ4s0+pD2CKKhe09CubRDuEA9MWZU+PRGSv6bJKQLEJW30gxfymV9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Luvgx78lTgVHv7VS4FiVlLGGOxsjer83fdZX3pjsILk=;
 b=pi4+ncY+mzaaiF/lU1Hm9Ab4ofDa8kSiNfko2EFwBxegkEK19UAYeLIP7UZW5CeGNMOKCSABR3Fyz4UkT8sJ+dmKhNBhxtLCf6Eg7qf+qgrLO8XPD1126kVHLNteJijfMwmHfuWpxrVnrEYhobNY3a9SauWTKMuSeezmIVC4LXvbdEpWUFYwmDQSX70TNFeD/L+gCJTdZnHjMoqMtZBJ6S4ZKpqc0c1+pKsasXrR2lUtbeZ0xwV0SK0mgrAACrefQQeW4xr/rTdtrylcznIivc0ocNoHisiArEIn6AWMQsbuoB6uthGkkfJfTAa4BrICKO70oZTBHOG6/2ezT/77Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Luvgx78lTgVHv7VS4FiVlLGGOxsjer83fdZX3pjsILk=;
 b=YIYNDrxN8kpxKDe8uzJKvsCS009xWa0Isg1hl/VjMeUsJ1YnL7/KgSuUsI1Zyv1i3CrXnof6P9z3SRA5TIoeabPcVYsO6XZZ8BhwowjhW0jRtwHer3ekMeSX6JnYw6KCO2T4K0ZpIqoNb8YKH8aVCgzlB61EpMQUbq0chZlPQY59Lrtsk64QZVMv7WDNFhnBDEsLa0s3hQJDShwyOhuCEeJ08VIuhRPe9ZYjdESczufF3GTvoToNggJT/9kjZ7P7jyE3xM7rOwXFXo0zR7r9UinzbgzMJsUbfsLpNqaR1qhv0aZDvSfKP7vnoKuzSAcvEe5aVH4ZjRzgNYJvIeuuPA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by MN2PR02MB6734.namprd02.prod.outlook.com (2603:10b6:208:1d1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.23; Mon, 10 Mar
 2025 23:12:20 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.8511.026; Mon, 10 Mar 2025
 23:12:19 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Roman Kisel <romank@linux.microsoft.com>, "arnd@arndb.de" <arnd@arndb.de>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "bp@alien8.de" <bp@alien8.de>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "decui@microsoft.com" <decui@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>, "hpa@zytor.com"
	<hpa@zytor.com>, "joey.gouly@arm.com" <joey.gouly@arm.com>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "kw@linux.com" <kw@linux.com>,
	"kys@microsoft.com" <kys@microsoft.com>, "lenb@kernel.org" <lenb@kernel.org>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>, "maz@kernel.org"
	<maz@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"oliver.upton@linux.dev" <oliver.upton@linux.dev>, "rafael@kernel.org"
	<rafael@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
	"sudeep.holla@arm.com" <sudeep.holla@arm.com>, "suzuki.poulose@arm.com"
	<suzuki.poulose@arm.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "will@kernel.org"
	<will@kernel.org>, "yuzenghui@huawei.com" <yuzenghui@huawei.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>
CC: "apais@microsoft.com" <apais@microsoft.com>, "benhill@microsoft.com"
	<benhill@microsoft.com>, "bperkins@microsoft.com" <bperkins@microsoft.com>,
	"sunilmut@microsoft.com" <sunilmut@microsoft.com>
Subject: RE: [PATCH hyperv-next v5 09/11] Drivers: hv: vmbus: Introduce
 hv_get_vmbus_root_device()
Thread-Topic: [PATCH hyperv-next v5 09/11] Drivers: hv: vmbus: Introduce
 hv_get_vmbus_root_device()
Thread-Index: AQHbj606Fy+UafjC+0mpP0N9csy7qbNtBBfQ
Date: Mon, 10 Mar 2025 23:12:19 +0000
Message-ID:
 <SN6PR02MB415757163CDEC267B0CBB3E4D4D62@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250307220304.247725-1-romank@linux.microsoft.com>
 <20250307220304.247725-10-romank@linux.microsoft.com>
In-Reply-To: <20250307220304.247725-10-romank@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|MN2PR02MB6734:EE_
x-ms-office365-filtering-correlation-id: ffa97981-4d37-4162-199c-08dd602901b4
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799006|461199028|19110799003|15080799006|8062599003|440099028|3412199025|41001999003|12091999003|102099032|56899033;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?emAou/RzghaOda3AZGxVXlkM8v3wmiWDUJKp9WLG0sS5brPHKrnqfaynJRQT?=
 =?us-ascii?Q?q2tr9+Q/oqCIsCE2i/OSEqU5ak6Ft1FSa2x3Cqv/9Ar+M8pTJ+gPQBbh5dCd?=
 =?us-ascii?Q?B/C0A5azW+GAWg6tauzSoz27T2lU8XE4N9eVLu7ApR0jsDPI66oHE2T+P/56?=
 =?us-ascii?Q?WXH7CH3o/G2ER8Y0y2WJZFgnnasYMeXIRbHZF24TPTpRt3YHammFReEv0alY?=
 =?us-ascii?Q?/5J3wAy554Ehuw+cslYOa7D+8s41PSZCQX4sPMdifw7guoKtMufKJpnBz+By?=
 =?us-ascii?Q?qjh5ZpYJyDwRXuUQtBvZqLqOIkX73dRMxQ9VY8XFPwLwBj/dsfmNqGORV03R?=
 =?us-ascii?Q?9XxR3DDQUf2TiidNFeLHWVMA33AW0hwyCwCrj5reocFlNYCXSlhxcD2Ya4En?=
 =?us-ascii?Q?1I3G/U4EXdI6hSUl6qoALXF6vVpdGRuW0vW589kHU24Hcw6GtyfMueCOpNt1?=
 =?us-ascii?Q?qEQrfU0cuggxJAdP6ukpdHWvOF2x0PWgifF56RHfHdU7JMwiV2JM1UXDfhTA?=
 =?us-ascii?Q?PxEvUoSmDwOouZDw+N4exak6JdnC4mEebOeKI0Ys9T7MB4YJ2bwLgALdFaz8?=
 =?us-ascii?Q?Hn3rGvn3SHjMmlyo/cBy0J417ilWfv8S7FoNaOZk7ZGbcbPB9tzfiWW2rwEw?=
 =?us-ascii?Q?HaaHIZlRDpAcvcuOzmlXJKx+PG4wnFLzIDB9i1D15bvNuqqCchD58/7yu/eJ?=
 =?us-ascii?Q?OLSdP2QdtTvLHbcQkhUWYUiEYy1w8zHi4VyF2UTfSZ/5JmfT2D6SXP+wwO01?=
 =?us-ascii?Q?WBoM7xB+wOUr5UAn/0ACP4ZX4FeX+G0zKLUeNnyidm0rxbNxoZ8WfhvAMC6I?=
 =?us-ascii?Q?z58l8My29ShasDz4loDkM0EsdGuYs1bnAjP96634Co22v1TVpMrnZMWbBRv2?=
 =?us-ascii?Q?TaDANyAh+Qu6C+kq+RdvfkrED8Pd0sArFP6r6OcCb80Jr/5KCzCyTszMJ34l?=
 =?us-ascii?Q?23BGinJj7LbZyT4xJ81oNcCUxFSuBAW0JP+0Zapzy8nLBta62yk9Nm7jLEND?=
 =?us-ascii?Q?HeG0x0MZ67j0j85YfnPRMFwz6r1pvPj8P+JLMh97x/6YYdDn61UtO0yL9k1O?=
 =?us-ascii?Q?M54ETSk4iWCsyovT9DU/NrYlG4EBWJ+YH9rL7vO8NivsBIZszHM=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?bjYXRK2Dy6aAAf5ToA2CGxbQQoZcvyh5sL3Nz2p2hUoqhkmNwFrQ+EbBjBSE?=
 =?us-ascii?Q?H5vgvVQhvox09xBt5TDjlWSzx8rPn/SU25Nf/QWI5cDT2vXaPpnNGdTcTkuK?=
 =?us-ascii?Q?2GkIugIxy3JQlpMwOFEJwjAzVweI3TYxluCgND7++tjctKnFpA0V73Iplq0K?=
 =?us-ascii?Q?rTvJGs/IPBNSk+vPOSKvAHLgrx8+fBaiUeybwkrCEOOZ/CPFIN+++QVmjls+?=
 =?us-ascii?Q?LYSX+Tn/dD0MdhrFRPT01Ji3B9MZV7r83KY7RWyztFS3MJYIPdMDQGmWgXTq?=
 =?us-ascii?Q?kR2eAM3UBzwmHY7nJduvwKvqi6JrnQ//JXOvf9N4DnsypzTOrvB5ErlK6Mii?=
 =?us-ascii?Q?EENkPagu1c5htHNxOaj7yqOrnk3dR0Dt0pVDSME+6Q8UVRwzP2OiU3BDSNrn?=
 =?us-ascii?Q?wDwLYfJXT3NJlBkZwN7csY+CBvnCp/w4FS4fbwIMOsFcP6G81Cjro2jgeASA?=
 =?us-ascii?Q?9YVuLNyuSkhHcHVP7va9Rk8OPK7PIPiwECAcYBZxRu/3xbG7Y4fI6wTlMe6V?=
 =?us-ascii?Q?/N0PaiP04gStqIRDUXyresIzgP87RovLNV9q00a8kZOT3ifPlAerOnblkTRf?=
 =?us-ascii?Q?msWO8EZPUOEO2qhQZsr0RC/y+khLdMfKRw9i70I1LnazMC6nX0MNaUlWagMp?=
 =?us-ascii?Q?+jYD70s+r2x8ahParAZY8PAPlKtUSfGd6S1RR+qdiP9XdZ2VHgDwNJj2MOKT?=
 =?us-ascii?Q?2ZQC3rwrSmhc5pqFCS3I/o0UjjEt4In6Tu7Kay3k/A+UMeooLW/bUe231F4N?=
 =?us-ascii?Q?gYWCqCkvY8q286WArOotJJvUBJa/sFfHYiyeWaJd4InX8mfrovbSqzOck/zT?=
 =?us-ascii?Q?HnHDcZQc2r8mKxiVP9mPUO6mNbwcd2A5xIh9aVK+A7PU/i7lJ9CKX38tRZg6?=
 =?us-ascii?Q?QUirIHAOwnT1cah4zb+7eZ4XQ1lmFkCJQAS5WWH2Ia/4poQb8U/fHB0CMKBD?=
 =?us-ascii?Q?1lkIr2BcWYnKPyOyu4bukF+tPMm46Bh9ODukcaD4QMU6bmVyuEmAj6MMR70N?=
 =?us-ascii?Q?YHRNbmPiZENk82zPxlWhQue0fgsfDdPQ+Ldz52oxyJtzLW3uQyzx/f6LmztQ?=
 =?us-ascii?Q?ioQTYYzjzkHGwxHT8VxHNMDH4zhIkijSF5Hsi4qUurGGs9xr6FSFijRscgMX?=
 =?us-ascii?Q?IGR7YIAuhvGO6LGbY8jcPQ7QDoRkEWYkDfoDJW2/86Lc59mEcF01xgH0T1uv?=
 =?us-ascii?Q?5OlORoSDExIW1RwKpqiT8zhzbVcvKITJjKG8qafLt7EDy9tILG0Y2iGFutc?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ffa97981-4d37-4162-199c-08dd602901b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2025 23:12:19.4643
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6734

From: Roman Kisel <romank@linux.microsoft.com> Sent: Friday, March 7, 2025 =
2:03 PM
>=20
> The ARM64 PCI code for hyperv needs to know the VMBus root
> device, and it is private.
>=20
> Provide a function that returns it. Rename it from "hv_dev"
> as "hv_dev" as a symbol is very overloaded. No functional
> changes.
>=20
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

> ---
>  drivers/hv/vmbus_drv.c | 23 +++++++++++++++--------
>  include/linux/hyperv.h |  2 ++
>  2 files changed, 17 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index c8474b48dcd2..7bfafe702963 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -45,7 +45,8 @@ struct vmbus_dynid {
>  	struct hv_vmbus_device_id id;
>  };
>=20
> -static struct device  *hv_dev;
> +/* VMBus Root Device */
> +static struct device  *vmbus_root_device;
>=20
>  static int hyperv_cpuhp_online;
>=20
> @@ -80,9 +81,15 @@ static struct resource *fb_mmio;
>  static struct resource *hyperv_mmio;
>  static DEFINE_MUTEX(hyperv_mmio_lock);
>=20
> +struct device *hv_get_vmbus_root_device(void)
> +{
> +	return vmbus_root_device;
> +}
> +EXPORT_SYMBOL_GPL(hv_get_vmbus_root_device);
> +
>  static int vmbus_exists(void)
>  {
> -	if (hv_dev =3D=3D NULL)
> +	if (vmbus_root_device =3D=3D NULL)
>  		return -ENODEV;
>=20
>  	return 0;
> @@ -861,7 +868,7 @@ static int vmbus_dma_configure(struct device *child_d=
evice)
>  	 * On x86/x64 coherence is assumed and these calls have no effect.
>  	 */
>  	hv_setup_dma_ops(child_device,
> -		device_get_dma_attr(hv_dev) =3D=3D DEV_DMA_COHERENT);
> +		device_get_dma_attr(vmbus_root_device) =3D=3D DEV_DMA_COHERENT);
>  	return 0;
>  }
>=20
> @@ -1930,7 +1937,7 @@ int vmbus_device_register(struct hv_device *child_d=
evice_obj)
>  		     &child_device_obj->channel->offermsg.offer.if_instance);
>=20
>  	child_device_obj->device.bus =3D &hv_bus;
> -	child_device_obj->device.parent =3D hv_dev;
> +	child_device_obj->device.parent =3D vmbus_root_device;
>  	child_device_obj->device.release =3D vmbus_device_release;
>=20
>  	child_device_obj->device.dma_parms =3D &child_device_obj->dma_parms;
> @@ -2292,7 +2299,7 @@ static int vmbus_acpi_add(struct platform_device *p=
dev)
>  	struct acpi_device *ancestor;
>  	struct acpi_device *device =3D ACPI_COMPANION(&pdev->dev);
>=20
> -	hv_dev =3D &device->dev;
> +	vmbus_root_device =3D &device->dev;
>=20
>  	/*
>  	 * Older versions of Hyper-V for ARM64 fail to include the _CCA
> @@ -2383,7 +2390,7 @@ static int vmbus_device_add(struct platform_device =
*pdev)
>  	struct device_node *np =3D pdev->dev.of_node;
>  	int ret;
>=20
> -	hv_dev =3D &pdev->dev;
> +	vmbus_root_device =3D &pdev->dev;
>=20
>  	ret =3D of_range_parser_init(&parser, np);
>  	if (ret)
> @@ -2702,7 +2709,7 @@ static int __init hv_acpi_init(void)
>  	if (ret)
>  		return ret;
>=20
> -	if (!hv_dev) {
> +	if (!vmbus_root_device) {
>  		ret =3D -ENODEV;
>  		goto cleanup;
>  	}
> @@ -2733,7 +2740,7 @@ static int __init hv_acpi_init(void)
>=20
>  cleanup:
>  	platform_driver_unregister(&vmbus_platform_driver);
> -	hv_dev =3D NULL;
> +	vmbus_root_device =3D NULL;
>  	return ret;
>  }
>=20
> diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
> index 7f4f8d8bdf43..1f0851fde041 100644
> --- a/include/linux/hyperv.h
> +++ b/include/linux/hyperv.h
> @@ -1333,6 +1333,8 @@ static inline void *hv_get_drvdata(struct hv_device=
 *dev)
>  	return dev_get_drvdata(&dev->device);
>  }
>=20
> +struct device *hv_get_vmbus_root_device(void);
> +
>  struct hv_ring_buffer_debug_info {
>  	u32 current_interrupt_mask;
>  	u32 current_read_index;
> --
> 2.43.0
>=20


