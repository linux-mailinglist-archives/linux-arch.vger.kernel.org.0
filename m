Return-Path: <linux-arch+bounces-13441-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E1CB49FC0
	for <lists+linux-arch@lfdr.de>; Tue,  9 Sep 2025 05:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 560021B27324
	for <lists+linux-arch@lfdr.de>; Tue,  9 Sep 2025 03:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF97125D549;
	Tue,  9 Sep 2025 03:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="jPMnAM4Z"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2016.outbound.protection.outlook.com [40.92.42.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA56225A65A;
	Tue,  9 Sep 2025 03:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.42.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757387511; cv=fail; b=QeEhtLZeO48P4ECE06Gx+GgNohN15cHumKSAwuNPeSgx6K0bJ68EQtI/wGydyFgULFzFPsVmWGY0ETkpwcipHVp1MYY+mr0DkbUV87/vUYWghyuh5cLQ55UXWKqrWaKLGEM7QXqWFGFkCaBa6bimC3gYLHfHLpyvcNy45p0O7Ro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757387511; c=relaxed/simple;
	bh=Z2kBqe40GWEIfdKDc6xatzI0Yx03Wu5Wh7VTZUUxN8U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LOTT+aCmgbH8tSL+gguM/lBZY9oC278//onioP2nmlC5VcMmNXI44/D5P5+YucCnIfn0+Z/2/TvLbym0tVzZJF4SXar8WvktsDvS3J2tho9UEg5mdR+iOE5WHignghDOvz5CO2wvlWc/0u5Ag3qmvApCL0r4GRSac8q4P5wIhI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=jPMnAM4Z; arc=fail smtp.client-ip=40.92.42.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pmdChvtMGYq6JDAbwUrVwj+4IANjrteGYPXnaom50BSAPIrktTG/EGle1tXGZ7aKyp82JZpZH0wxDb/ar+u65G45tkF9XKEjIe+nVMd2tlXTNuuOh+NdjOqtEfxzG42BhfJTy5eNm22kQIqxQIu/gWpmZOWsCT9y+5sF6+Jx9dH4kd3gE89KZzP5img6q/uxPyOTDsQh3uSBoio40sxCS3WWlGneGd9XZVfxBtu4gBg/Qc2PvczhcFOUMw80+gbhJo62hXGarBLAikqWqh9tMmTYy1OTNrcbFB9U/sVRKrbNcbON9U/duCbKVpkyzjfOE7BDFqvSU2HCwNwnywJORQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YrMiSSee1J0jK1QHghSXtVZODSQP4Hf7v+ul4pEoAHQ=;
 b=eYpnpkXmR+iF2U3TEhMtn5kJfpk7YqvhVmpZhZUyQYz/zq0Yhy5Z2Z5q1ZEq1w8K12jrqNwDUBE24byw5AUMQan3qkefXxY0ddlh+ITKRSPzZWSxOnfvaxVOMuUS+5N0h4WN1gz+scAoI+zC+p12cz5arPLr9oEs/71QSIJ2B9DMX+3FI9Uid0jUKCv3AyKMe8v4qWA6yQwHZhc/Pnsx7cckXPb6LBKM3Z/0fLZI9yt/YuMrLoXnlUv5VXrhEt1G6N2DFFNnWNqq9yyW/i2peAYIB/GIkwCfUClSWTYFAbG9CdFSzsWfAC3QMwB5i9Bm6TFQopIOxLZJaIndkWEX0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YrMiSSee1J0jK1QHghSXtVZODSQP4Hf7v+ul4pEoAHQ=;
 b=jPMnAM4Z3HkjWwmLHNNpdc3D63UgR8GWRjoFT3Jb0ChfDjLAnCI85BbCkV/sz1GSGzkDQdIgsrF0j7zTweY8BnWsLlrtoy9b1RAosIV9p2fvabeZbGRczpR5XpUQ2JysiksaLjS1+RxGJtdDkIfchVZNkYFxSA5sEipgLrB2+EtXBghWd63AgmoUzCDESWs5MBNTS2pM2OjuuGxDjpEblUyxwpM66A/qke81+4m4IYWohaL14+F0+ez1BHxKInKalJyCr06kAVkDG/y91hN1GYd7J+sy8qMj0/OCE8eSnV5zYt6uDRWqQoIGmXzkp8WeYbi6iqEt9F59KRXApvsZPA==
Received: from BN7PR02MB4148.namprd02.prod.outlook.com (2603:10b6:406:f6::17)
 by SJ0PR02MB8484.namprd02.prod.outlook.com (2603:10b6:a03:3fd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.29; Tue, 9 Sep
 2025 03:11:47 +0000
Received: from BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::6007:d1a1:bcf9:58ef]) by BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::6007:d1a1:bcf9:58ef%4]) with mapi id 15.20.9094.018; Tue, 9 Sep 2025
 03:11:47 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Roman Kisel <romank@linux.microsoft.com>, "arnd@arndb.de" <arnd@arndb.de>,
	"bp@alien8.de" <bp@alien8.de>, "corbet@lwn.net" <corbet@lwn.net>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"decui@microsoft.com" <decui@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"kys@microsoft.com" <kys@microsoft.com>, "mikelley@microsoft.com"
	<mikelley@microsoft.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "Tianyu.Lan@microsoft.com"
	<Tianyu.Lan@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"x86@kernel.org" <x86@kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>
CC: "benhill@microsoft.com" <benhill@microsoft.com>, "bperkins@microsoft.com"
	<bperkins@microsoft.com>, "sunilmut@microsoft.com" <sunilmut@microsoft.com>
Subject: RE: [PATCH hyperv-next v5 04/16] arch/x86: mshyperv: Trap on access
 for some synthetic MSRs
Thread-Topic: [PATCH hyperv-next v5 04/16] arch/x86: mshyperv: Trap on access
 for some synthetic MSRs
Thread-Index: AQHcF7gUnPp8XYPKGEqgKM8N/rTiL7SJ9BZQ
Date: Tue, 9 Sep 2025 03:11:47 +0000
Message-ID:
 <BN7PR02MB414878837D34F40D23DB9506D40FA@BN7PR02MB4148.namprd02.prod.outlook.com>
References: <20250828010557.123869-1-romank@linux.microsoft.com>
 <20250828010557.123869-5-romank@linux.microsoft.com>
In-Reply-To: <20250828010557.123869-5-romank@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR02MB4148:EE_|SJ0PR02MB8484:EE_
x-ms-office365-filtering-correlation-id: cc69b9cb-4ff8-4413-9c60-08ddef4e9cb1
x-ms-exchange-slblob-mailprops:
 znQPCv1HvwUykhYCLh9DY9coCVULpTnXUDO3VEcqtlHWJAuvPD+kBSMLeZbgV8PBpDew1I56yxLoRRn5gCwK8orL1XSmdq9WoeIbeU2ImtBlVM/Esh2hgL4PiPSBSkwElh/jthzEsmYg833z7RTIaNIdkDc68WNrDLBBWblOSScMRYxs2xbmWkBTdkX3ceozwYl4LvBAjwGVcwz4PAvbhf8aUlWYC37SZx1ZAmoMFfaKY7v8ayRV9/NxFoYyhBZi1zB5DG6FBMy/BcQq6KGd5Q/PGKsFtAf7ybtcWHxqwfHtNm/mhnYZzD/rDRM3hQgO5yjPDk+9cnnz1Woo2wBJ7ZTtnf3CqTu/d63I8YX+2wD/09WwUWh+TL2g1POi1lHOOAjPp480E7kqWcPSDf+cNG/EXite+h8nLDKa0P34fvN53hiF4/ZfnfZUSS19BjM9olexIHTCGpfbobWfNsu3Tqgx3PVZ55Vmg5hZ6ola454f62193ZG6Y15iJNdmYfRlv0spVOREO2sha2bfwxJE1aylj+Vd53Tur+W19lVV2NCUuLtvD0pYCVdUzcbo+7R+FRH4rZDII1lBjAIoWnhYTdNLGvzUrVpdfFBB2wf4rpr3kJPp0L2EbOAYLyfRGQjGBcYzEHI+BWE37luVooaBeDzCklfjiWkNRy0vSZujUOEN8gZF/vJklhI0aWnkp8nna+Hf2SIWKarMsI+jDoS2q10/ciNuyCioLMHdCesnU/CJ+3izTygtMTc+yWKXh5tBr8oh3YAacaQ=
x-microsoft-antispam:
 BCL:0;ARA:14566002|13091999003|8060799015|8062599012|31061999003|461199028|15080799012|41001999006|19110799012|440099028|40105399003|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?yh97SNBuJOi5IokBLb4V1Gc/tkoWz8X9oy+7SEYTQe9eP6p2Bv0v9ACLQc2d?=
 =?us-ascii?Q?FSvp+Tp/G1mBpTqWV2OApKKTAq5UX2RGijtOD4tG/tS3U6nhqa15MvjaOLUS?=
 =?us-ascii?Q?DdLUPrpanH7tAGe5liaRVeEna3LRJYIwm0Ui7rsUj09gwR24qKStrarLItRs?=
 =?us-ascii?Q?cUJy6TSxp5FwYVLUURlwOgfUAD96qQgsi5WhQIiTkPJgM5Yp1ZED0UMRmGE8?=
 =?us-ascii?Q?yeaS3b/UECE+OEUZH7FZMtpDWpUqLZI4HcfoPtf8iEWIVz7AJo6Mb4qoHgci?=
 =?us-ascii?Q?BLal44y0rre+jLCYTw7/j5v5TtCs2XiV6F6yISXtPKWaw3hVJ5hPDu4WVv24?=
 =?us-ascii?Q?kNPKKC0Dm84nDTA1zCnO3d1iXiV9yaqbXDL5HyUhP7G+cFMHJMgQ9Gs6l1Cg?=
 =?us-ascii?Q?l/DLnmPrzwBcXU9U+IkeuARM28LAPWiBDUxlhENp/LvCjMA+9N29lZFQd25T?=
 =?us-ascii?Q?nNVqm62xPqUEXWCCiu/qPGXX+8T3vIOPw0y/FtHd8O64/Cib7LohHjBxqe6t?=
 =?us-ascii?Q?eVkL7LepBK0SiCxKFrxw08huFStw9LCQ9W3z8JXrtOlyW6AHCIdbpqE1pPx7?=
 =?us-ascii?Q?wsxg5LHXT3qFegsoheSLbAMNib0e8QvNYzQ2wI53G7qfyBDz37vQuesmCEn3?=
 =?us-ascii?Q?bBL8cyOlfxl+aQyVb6g1mhDqyMjSf/kHKeLWx3HEZ+TjyPUCxyCgHW+Uas5P?=
 =?us-ascii?Q?xSMeoFxe82pySnp2bIihCoejX7tVVgP/9mUiJe7oHfju/gmJwhxChT4gWlNM?=
 =?us-ascii?Q?VLu5/5YY0JehIAlYS5NSA6Ai1kQp0DHpwVi1EW0G3fQFChFsQ79MgPRASkCF?=
 =?us-ascii?Q?KHvLAb3Rav1LVCuwQKRfGQtcmI99uY/dw4Gms381sKDddq+PQFq8fpGoHbBC?=
 =?us-ascii?Q?IMpEZuPvrJF6WzcG7/hbeEJYn6ksrFPLwDhAFucDx7KkboBdtb3U23XKQ3/u?=
 =?us-ascii?Q?0x58aGT2FD+hBaBEOWxrdpsX+9wg4rKVAFSuCTqBxIWJW1RPXqY3lopqVch7?=
 =?us-ascii?Q?9H/q+3qXlodaOHmTc3/pYKcPNpuy9iCgSVbrQVdkYo3r/N+7sj5xr2s6+uiI?=
 =?us-ascii?Q?b8TZbmk6BmFQ39RlIs9WKMF54ecT7hlA7C1LIRYcFOiA/0RDdSw+4HZvt4Nv?=
 =?us-ascii?Q?ljRiFi6j46MZaBv+XX+0cSa7d/4D5utsxE4q7hxpOUS5YIeTt+ATaWGu8BoN?=
 =?us-ascii?Q?PMvH91M199L6Vxsn4vnS6O/ndz9NdTcsxH4nOg=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?9/N8dtSuDni7WHGxiEC9/+izKW04LG3Rv+3vuoY6YIn+xbip3OXYq7nZ9oP2?=
 =?us-ascii?Q?C8R7l3fBZ4sfNZnvOdRrX4FSzjUyfOWFVpigfefdWELpgQoAxgdflwJHjZZA?=
 =?us-ascii?Q?T+M6AdQG2v8H9lrJCOICxY8XQvdod3CAw56jvxIJL/b53Pc4dJlS0qTShF+5?=
 =?us-ascii?Q?3RgX5nTpANycn2c4T/t3nDLfuF90bwktXE4OphtDHref2V4IIstxT/ZCLv4P?=
 =?us-ascii?Q?PANRoXObARGsvwKmQTzPYqTOiMUh3vpfjk0AjYH2biUD/b8S8hV9rlcMP8mO?=
 =?us-ascii?Q?uC8Dj2BxcGSHakCW4Tne4kRIX2zri2OB1lq2usiLIa8iEMUqNap6b/2zFdbm?=
 =?us-ascii?Q?70qudd312jvxAbT0RrHDREcugCZffnXHAq/MqpEHDfDidxCqS9GlfyGC4ZxF?=
 =?us-ascii?Q?mVxIqyv9msS2tANsttwXTWYepZp4DoMGv30o9Ui42OoP4Dy9k8+wSV+K7BdI?=
 =?us-ascii?Q?yoCZSXFcmxy9OH8Wzcdga+HzpW+LwfhHhF00zwyd8fwcsbTq6LMCMhJq6z66?=
 =?us-ascii?Q?dFTvQi/yw4tYSx5aJUqG+xrVbNjprE/vVOVPeZgjzL9Au1QN8rWF6bCs2yAO?=
 =?us-ascii?Q?9sQQQ8J9uqC5YvP0tWUez0ifBRiE3F8ZvzOVZAEftM/z7GVRul+0dRMOh8wg?=
 =?us-ascii?Q?iRq5ZRIdIl8oJ9/1SYq4Xy8/YkgGxrgll/eNCFRFwC8OjrZFZ84h1L2x2cYv?=
 =?us-ascii?Q?BbhvUegN2AjmCmo959tV68c/8nXFshgnpLXbz+BEPjQlqTiwb1+a7Lsj4F/p?=
 =?us-ascii?Q?KAEeCOJLBVaN4H536d/Eprq6P45fAB+Wx7jYoKhfDxNN1lxub6b1sJPQjowl?=
 =?us-ascii?Q?ZNYgTUnlkAtoWJHjeVvAbAsWlj3M6eCxH3CgZ3dY0b8QOX0WG9PkKYoZPdfT?=
 =?us-ascii?Q?YVUkMxmii2pxDs9xCCmLtyQINGm4Y9O3GX/2OFvGBxEKRRQmvQtegzSMnAx6?=
 =?us-ascii?Q?GtHLwGr9rXvUJDKojrr4DyHmwt+M5uRCflbtYrZ/Gfbs7Cb/tJZEAiSWNUPa?=
 =?us-ascii?Q?fJOIe4awB6fb22HET2EZKiy48AVWvFDH+U4+vY3r1OX91nxFlHJukGf+J+Id?=
 =?us-ascii?Q?TaAkweKQ0byAQkk9hNYEQjwGADUI4tnMxHN2tg+IK9RwFUcj7Ebw1nJh7pr0?=
 =?us-ascii?Q?yO/C+EwzrawBYCBqh9r1Ruu9gNdxlRaazVoJciPWoIrx9EHL/4la+hXeYrAM?=
 =?us-ascii?Q?sb8rwjGAWNRwNH58SJa/hVOtOi+2tpXmitBNk2VtutJQcZjsTXHxZBiTR5k?=
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
X-MS-Exchange-CrossTenant-AuthSource: BN7PR02MB4148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: cc69b9cb-4ff8-4413-9c60-08ddef4e9cb1
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2025 03:11:47.0809
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8484

From: Roman Kisel <romank@linux.microsoft.com> Sent: Wednesday, August 27, =
2025 6:06 PM
>=20
> hv_set_non_nested_msr() has special handling for SINT MSRs
> when a paravisor is present. In addition to updating the MSR on the
> host, the mirror MSR in the paravisor is updated, including with the
> proxy bit. But with Confidential VMBus, the proxy bit must not be
> used, so add a special case to skip it.
>=20
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> Reviewed-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> Reviewed-by: Tianyu Lan <tiala@microsoft.com>
> ---
>  arch/x86/include/asm/mshyperv.h |  2 ++
>  arch/x86/kernel/cpu/mshyperv.c  | 28 +++++++++++++++++++++++++---
>  drivers/hv/hv_common.c          |  5 +++++
>  include/asm-generic/mshyperv.h  |  1 +
>  4 files changed, 33 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyp=
erv.h
> index abc4659f5809..4905343c246e 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -42,6 +42,8 @@ static inline unsigned char hv_get_nmi_reason(void)
>  #if IS_ENABLED(CONFIG_HYPERV)
>  extern bool hyperv_paravisor_present;
>=20
> +extern u64 hyperv_sint_proxy_mask;
> +

hyperv_sint_proxy_mask is never declared or referenced anywhere, so this
"extern" seems spurious.

>  extern void *hv_hypercall_pg;
>=20
>  extern union hv_ghcb * __percpu *hv_ghcb_pg;
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyper=
v.c
> index a619b661275b..5e2c6fd637d2 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -28,6 +28,7 @@
>  #include <asm/apic.h>
>  #include <asm/timer.h>
>  #include <asm/reboot.h>
> +#include <asm/msr.h>
>  #include <asm/nmi.h>
>  #include <clocksource/hyperv_timer.h>
>  #include <asm/msr.h>
> @@ -38,6 +39,16 @@
>  bool hv_nested;
>  struct ms_hyperv_info ms_hyperv;
>=20
> +#define HYPERV_SINT_PROXY_ENABLE	BIT(20)
> +#define HYPERV_SINT_PROXY_DISABLE	0

Seems like these definitions belong in hvgdk_mini.h together with
the definition of "union hv_synic_sint". Since that union already
defines the "proxy" field, the definitions really should be in terms
of that field (though I'd have to fiddle with the code to figure out
if there's a reasonable way to do that).

> +
> +/*
> + * When running with the paravisor, proxy the synthetic interrupts from =
the host
> + * by default
> + */
> +u64 hv_para_sint_proxy =3D HYPERV_SINT_PROXY_ENABLE;
> +EXPORT_SYMBOL_GPL(hv_para_sint_proxy);

This variable is not referenced outside this module, nor should it be.=20
It can be "static" and the EXPORT can be dropped.

Also, does it need to be initialized? From what I can see,=20
hv_para_set_sint_proxy() is always called before any SynIC
MSRs are set. Initializing it doesn't hurt, but it begs the question
"why?"

> +
>  /* Used in modules via hv_do_hypercall(): see arch/x86/include/asm/mshyp=
erv.h */
>  bool hyperv_paravisor_present __ro_after_init;
>  EXPORT_SYMBOL_GPL(hyperv_paravisor_present);
> @@ -79,13 +90,14 @@ EXPORT_SYMBOL_GPL(hv_get_non_nested_msr);
>  void hv_set_non_nested_msr(unsigned int reg, u64 value)
>  {
>  	if (hv_is_synic_msr(reg) && ms_hyperv.paravisor_present) {
> +		/* The hypervisor will get the intercept. */
>  		hv_ivm_msr_write(reg, value);
>=20
> -		/* Write proxy bit via wrmsl instruction */
> +		/* Using wrmsrq so the following goes to the paravisor. */
>  		if (hv_is_sint_msr(reg))
> -			wrmsrq(reg, value | 1 << 20);
> +			native_wrmsrq(reg, value | hv_para_sint_proxy);
>  	} else {
> -		wrmsrq(reg, value);
> +		native_wrmsrq(reg, value);
>  	}
>  }
>  EXPORT_SYMBOL_GPL(hv_set_non_nested_msr);
> @@ -109,6 +121,16 @@ bool hv_confidential_vmbus_available(void)
>  	return eax & HYPERV_VS_PROPERTIES_EAX_CONFIDENTIAL_VMBUS_AVAILABLE;
>  }
>=20
> +/*
> + * Enable or disable proxying synthetic interrupts
> + * to the paravisor.
> + */
> +void hv_para_set_sint_proxy(bool enable)
> +{
> +	hv_para_sint_proxy =3D
> +		enable ? HYPERV_SINT_PROXY_ENABLE : HYPERV_SINT_PROXY_DISABLE;
> +}
> +
>  /*
>   * Attempt to get the SynIC register value from the paravisor.
>   *
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index 8285ba005a71..eabd582240a3 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -722,6 +722,11 @@ bool __weak hv_confidential_vmbus_available(void)
>  }
>  EXPORT_SYMBOL_GPL(hv_confidential_vmbus_available);
>=20
> +void __weak hv_para_set_sint_proxy(bool enable)
> +{
> +}
> +EXPORT_SYMBOL_GPL(hv_para_set_sint_proxy);
> +
>  int __weak hv_para_get_synic_register(unsigned int reg, u64 *val)
>  {
>  	*val =3D ~0ULL;
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyper=
v.h
> index 4b0b05faef70..bc4e3862a3f9 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -300,6 +300,7 @@ bool hv_isolation_type_snp(void);
>  bool hv_confidential_vmbus_available(void);
>  u64 hv_ghcb_hypercall(u64 control, void *input, void *output, u32 input_=
size);
>  u64 hv_tdx_hypercall(u64 control, u64 param1, u64 param2);
> +void hv_para_set_sint_proxy(bool enable);
>  int hv_para_get_synic_register(unsigned int reg, u64 *val);
>  int hv_para_set_synic_register(unsigned int reg, u64 val);
>  void hyperv_cleanup(void);
> --
> 2.43.0
>=20


