Return-Path: <linux-arch+bounces-12377-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94995ADF269
	for <lists+linux-arch@lfdr.de>; Wed, 18 Jun 2025 18:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 016A84A2D38
	for <lists+linux-arch@lfdr.de>; Wed, 18 Jun 2025 16:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D5B2EB5C5;
	Wed, 18 Jun 2025 16:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="J+athKVM"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2090.outbound.protection.outlook.com [40.92.40.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC3C2F0035;
	Wed, 18 Jun 2025 16:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.40.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750263568; cv=fail; b=W308DICt72BrMFXArAqAhJCrcT1liWroAPuePiJKav28aFz7Hjgim5YXwvq4Xia5AGKnEO0vVWQOIIeNmjWz2spArUJHxF6mDIfpQ0C2JzloD5L/jIgUeLGW+L6vJpBkMQtD/8Wisuhn4NwaqtWLv+HxezuGzozJgt0ogwn6fio=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750263568; c=relaxed/simple;
	bh=R/RoBKXgb6tcn2/xp5oX/d7pxMrDswdQluy+JWcDGF0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OTz6ffkD2ADW5Rq9m7xjOKH/TX4enYWNoWcVB+cs60eSR23qttbbGi0vbQuGd01M+DYv7Ntx8Ae4f23+tzaayjnMo85d9BG+HWmU+d+B0Ssr30niYuHhgEDhbjEcCjV8n6+CAThYRU2krVzhSar8XaFRfRpGiZh0G/31M9S2PDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=J+athKVM; arc=fail smtp.client-ip=40.92.40.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DjBsdaeDIZK2ehkDpY0LIBGg4ajo3NGTLitWzpXXLX+TW3HYbCAT0HZAl8cjKQGdX+og6IJLpXriQFxjAUJ7yZ31CEWrZuk9PgaAog1ZPeAFtKUAPZKZtz0CSAXcPQs0jk62Ifo8dieegoWnK4eTTKVqJ8wixi0n01Ru548vdZ5l5lBoho0PkQXDLWmSU0mI3/IyKw8PLjF2WDiA91kypbZVx5Eb+8N2xVMBCCOacZLyFY3valvh/xEuz3DopT1GaiwaGZz0gIjbtj9lbT/Qei3YmCKqCJ/FLz6OLWOucLtk7IJ9EAJOer3WWjPt6z7+HqlWgBoBWr4Rx0xTDgQxOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Baz+HaAsEIp8cMqNfnbHgWSvYNT7l/Qxoa3Rz1/Nzvw=;
 b=saBLeCHn03QkCekKy+gK8aTpH5AatQ6OSF5X6cvz1oZ/2o6XcE5wjLfgQ+AXIyb1xYgHscWfZ/Nc/qgRgtt4Sg7hRNpmPeEVMRykO6la289iIRppASc7XFRpQPwAVAmA/bDbzgC8D/c5N19XbDelAy2jxR0jDEAlDVlIlaAri0/37yQ4csFObZMmMCl8lK4WZXU85okXAWxLs0AcNAQ7a0RS62690LNBHUHySgHVP/SbUVyngAyxGwgEXMvaDjFGuE1QCE3n2JTF5EYLL3IS+JsUK16o02IQog53fy+EQx0AaehRkEQHXz3CxCDuaoN/UHEgl8/vzdEy/J2QP+08Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Baz+HaAsEIp8cMqNfnbHgWSvYNT7l/Qxoa3Rz1/Nzvw=;
 b=J+athKVMWRNX1tFdIGxk8n1M1L7xLy1tDZdmz3A++cRDSF/yeatEnnYCrdvNUHSRhoma5/sdHWMqueR7z69wwvWO5WNmZwMIkpq/H1U5OKTEl5dJY+ZPe+eN9d13zt8XPLYtOhDxPqzyXOXH38FY4C8wImQ6CJUfnvtlG9puamhUBOk70OXnPcFS7vp0nHqPvvVJ6KHHNSYe71YAddchKJf5nEd9xRGzcBnpDC4SE3TH0WzH+rRjFVg/sCdTAPrhfIPj6gASeLcBOVivTcsdKW5FwPDr+nsJtHN1K9FO5hAzobHCTG+c8C9Y0rW/UpoohfcnF1vcZtHWJk0t4CI30w==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SA1PR02MB8462.namprd02.prod.outlook.com (2603:10b6:806:1f6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Wed, 18 Jun
 2025 16:19:16 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 16:19:16 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Roman Kisel <romank@linux.microsoft.com>, "alok.a.tiwari@oracle.com"
	<alok.a.tiwari@oracle.com>, "arnd@arndb.de" <arnd@arndb.de>, "bp@alien8.de"
	<bp@alien8.de>, "corbet@lwn.net" <corbet@lwn.net>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"decui@microsoft.com" <decui@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"kys@microsoft.com" <kys@microsoft.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>
CC: "apais@microsoft.com" <apais@microsoft.com>, "benhill@microsoft.com"
	<benhill@microsoft.com>, "bperkins@microsoft.com" <bperkins@microsoft.com>,
	"sunilmut@microsoft.com" <sunilmut@microsoft.com>
Subject: RE: [PATCH hyperv-next v3 11/15] Drivers: hv: Functions for setting
 up and tearing down the paravisor SynIC
Thread-Topic: [PATCH hyperv-next v3 11/15] Drivers: hv: Functions for setting
 up and tearing down the paravisor SynIC
Thread-Index: AQHb1Om8y7QtQ3XcDEmhXsGuIHwOHLQF+8/g
Date: Wed, 18 Jun 2025 16:19:16 +0000
Message-ID:
 <SN6PR02MB4157B7036994536E2F89436DD472A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250604004341.7194-1-romank@linux.microsoft.com>
 <20250604004341.7194-12-romank@linux.microsoft.com>
In-Reply-To: <20250604004341.7194-12-romank@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SA1PR02MB8462:EE_
x-ms-office365-filtering-correlation-id: d02e39b2-cb3f-46de-bb80-08ddae83df27
x-ms-exchange-slblob-mailprops:
 ZILSnhm0P3k1KuhwzYdE6C/ocrAmq9m0lRqMO2l5NxEZ2nzrExUxMExeJjXCKSu8SUs/eMgJnGkjLZIpFo+hrxHD93blQHB5lp/NlnubBC2mO1p0Qx+tILdPYJg3O63dMtbywptBfVNOb2cvX5SB4AiqWJUXTcimeSvZd7gU5+QuoN+Ux6o3A5k3guTUp2Y7QzoybHZeGPisqBJh5bOjZ1ZjLAwuzKzXnqHu77NiPPk2dG3xm9hBq8hjHwYV9i8OpGi8HJCpOjDMmheke6ZOIEjPpoLrZvZb0FpadO3tMqhEoQkY1DVdEboJlCXR8iOfzaicgqaVz1sVfITDaKTagGlN2LsbSjm2FkX9vk9hisWxYzzMQeWceTxSKKkZ2HR9zAIJdDM4xc4IHlziMvp2mCMw5jXo/0H5QM2s3607865goWS1FsgMjFqB9y9p+gEaTexNhUGQMIGfqz9nNPJ/VRmFP2i9KGiwn4z3U1ik1LEk9twhDg1ORwaGsVIifMq5XYTbha3IuhFzsg7NeGcRCbzRWqeZeOrUtWgRv7HgtXbX63SXYf94KtA8j3V+EmKqMYreRasZMGMiFdCn6G6qMJ4r+NDQaQDW164cDkizN1BB7SgxmQSFxVLgGXe02tSmY7TCQBi9Q00NyoooSOApxhAcmhjYKoRqsUZepISN5I065Ye6vGbNcnhwrfQ5VwhzVXH5m3qlDwZVcZA2f/2USf+e0S6LXwX9bZHXiFtj1SjMrY0wkR+AlOj6kwBl1fKOWG7O7aHHiXiELvqKfs/6W7Ye3jEeopf6
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|19110799006|8062599006|15080799009|8060799009|41001999006|3412199025|440099028|40105399003|12091999003|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?735mUU1N6zJ0Kpii1/UaXU9qusaOKAMjr4EE8jb2joRbjFb9WQzKYYUaNQaz?=
 =?us-ascii?Q?Oo6UqPzyP7xG/M7SIOuQoY15jP6LQDr7XWRC8rpGVBsts1QiWPyPu0jRt4Ac?=
 =?us-ascii?Q?/D9u5EemeZddlmN0qumzQpCkey1/wUfHMdy/z1vXzY9ucG0/AQbYiHCeeTuI?=
 =?us-ascii?Q?MgiCe74YjtfcOm4ncjOp+TQwlv4okYhupywsjlBMEXkgRvq5YifWK2TlLw0/?=
 =?us-ascii?Q?30NaVzs6RucMrEGao+rw2E3KDip2ZPZan1z/IGOAtruqK8OWPvZkUTyyLlMb?=
 =?us-ascii?Q?1NwWWCoTnsMsv4nj/WkfWc0L3Hqw4uHPU24N6Sb+B7rOjzpOUK8PD6v7k7f+?=
 =?us-ascii?Q?MyOtdIi2UbuSiGC1PqnQYlUvXt+O5N0Mz30R0Wqq5hMtQyDkTj1ecEWZfzjp?=
 =?us-ascii?Q?8XwtL5bKHxp+DgIKGvhvZPgxdaFPNY2w5mrk2W55CYfGxSOz7TIrlnAaT19q?=
 =?us-ascii?Q?AYBVM0t6K4fJQnUDJGOMn0J5iBYpkmm5bP5xk9xSMyOmrxiJSqDQPxZVkbJU?=
 =?us-ascii?Q?pDPyrV4GGaOx2q+dYwzp29PtHEwYLwovJE8MoLEFiqJi7HQFnpE/NBrieRJk?=
 =?us-ascii?Q?sDWQ/PE5a/qdMzF2SiWfHTYaQenhzcUWSmlu+v0bv5k+M74P00cOALiivwtn?=
 =?us-ascii?Q?r7DzLN7SAP/PVyQzL4JkmyvN8gtZ0k7ex0xpp8ds8enl/Ed7jdSwlF7lYfQ9?=
 =?us-ascii?Q?b6L1O+c1fKQjQRk3Mjs3ttm+oLWN9cWVHNdD2cYrz2kcrEGMpOWObwnFJh3y?=
 =?us-ascii?Q?/LFb9HItwzlmgg9+bY+CIN4sH+IPoi1EG4Bed+hdltxUrp/2MWTLXCk0qQqS?=
 =?us-ascii?Q?Eu3JKc8/Sc3RluKXHMOJZc02c2A8ikJ0myzycvjdsT5bZzbuY32D4bzxk2LI?=
 =?us-ascii?Q?n9o9VZsNN07uf0GS/g/DNhDVu9CP4MOkzNRfXFLAJMDN9WSHKZtG/xg2sAkp?=
 =?us-ascii?Q?txkGajy3TLpzHMa/oOBCvQxeZ4GQ0D9VKmgBFy/MswzGtxhYnjqR9n79lrd3?=
 =?us-ascii?Q?F+Gj5eVKxxuryl76gGNFNBNrzC7GdE1lHDwZ7i2vZZyyTEOr8tgaoj/cVz7K?=
 =?us-ascii?Q?F5WzspoJIyYiHihsZ7PZ0zgkTNeBgPZ4BqREQygr/qDX3jOr+VHl2ZqlzSyF?=
 =?us-ascii?Q?62adcgE4TgaFjZd5PJnC+ambv9im15XF7xscIp6v6QBPjQeSeDnAXME=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?AbuOmkFOi5UAZcf/pRM0ZrA2GvRXUC5ZetJ9PKoNfDX/gA6yBuBcI4ky6uGC?=
 =?us-ascii?Q?mUvUCOvFxH6n24GeTfwTb+cw2chA399UzFpjKLArfRZcFL7OxdBX/TpotQSh?=
 =?us-ascii?Q?86QFfEf2/Yvdqwm2KXJ2GvJ88OwZcQ30UfUrA1HnkEIr60dErA6Usg53Ux0I?=
 =?us-ascii?Q?+Dc6HdL8Xgiq3lqxzX+0TCTnP3/OP1JouYe2JdTdeuGNFXJC9FnLCSD9otOM?=
 =?us-ascii?Q?mTcCI/WGeh8gcNTphDtYfWYrm2+jn/6JDY94QbaK+ESzDfGeCETLI4tNOgUL?=
 =?us-ascii?Q?73NNc5ofNDmnq5aREOASjYj8IAK4fEtaiqixfC+OiHvnxq13phbkV6i8elPh?=
 =?us-ascii?Q?M9WdfLi4sb9tmVCt9gqhEO8B5wh9CBdZXmw0rwfVxuiGXs9t0rAhxIORdjeC?=
 =?us-ascii?Q?J5LHwSV8pnfs++/jv/IT9+f8ZsEiPV8y0B4DnBVeUx6MyttENkqNrTJjlD0Y?=
 =?us-ascii?Q?fuDsM60t6jEtvRicIBfa1ZjajbKI4d1vPYTFqPA3APzifuYvdn0PZp9eVFM+?=
 =?us-ascii?Q?mJJ7fVb77F8uvteVUJ2ByM3zMy7DTl7xiiGOvQCDsHqlEyd7ao2UsVQ2tcve?=
 =?us-ascii?Q?zh8p6bpTDsgv7a7VY0Gn5sDitc+Fjm6cQQ178YGJxv7c2SiwybPgtCamrtd/?=
 =?us-ascii?Q?5VK226mP4LZ8KXdNwdJH4hniRGqpXF/H1fiWcokU5ssfxPm5iMbgg/4jazmb?=
 =?us-ascii?Q?09hVWdsjllH13RdOPgI91KcuJYJH7h8ql6N+cxfOdLumwcxUI7XfBrfZJYa1?=
 =?us-ascii?Q?GOwxY8uZ6rvkBwZPyk3mo6Lq+uje+5d2zGH4xpGM/Oj79IbZJMkES+G1UVwW?=
 =?us-ascii?Q?T85NCX0104BpZ99MC0y2n2eJxZUE6nb2zy3AGVcO/qZpO2cWHX2hGpsH9ALm?=
 =?us-ascii?Q?++eM2vV/gRcO7wtRVTBjjJdEx6dQtWkKMPg+JBqtuhY1AvlMIh7wRxA1XMTw?=
 =?us-ascii?Q?jNIFI3u5eRdyodXn2Q3sNPY4nuIYorp7nFoKNHOanbgKYLKA9Sga/WZevG8X?=
 =?us-ascii?Q?g2RDKQT/2muRXED3XHlTok8LtjZtoRNuTDGFTmc33r4INxRIJbRG2dpDGjsP?=
 =?us-ascii?Q?oDI2O5BZ4C+LKdfMagBCTbMFsSOhTQwSunYu7P7LjBnsrQnasJ6YjbtcBkSb?=
 =?us-ascii?Q?bgaaVHXTq0S7tP8wF7uIqLrUXZR0W2ail4mvPQIpn2wu0JJr8JvXipL/UP7y?=
 =?us-ascii?Q?s09Pfdb6MKj4AYPiCOndd9VwxbafN00Hn7H2TfWLDXqIzoWIpAyR2QW99OY?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d02e39b2-cb3f-46de-bb80-08ddae83df27
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2025 16:19:16.4245
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB8462

From: Roman Kisel <romank@linux.microsoft.com> Sent: Tuesday, June 3, 2025 =
5:44 PM
>=20
> The confidential VMBus runs with the paravisor SynIC and requires
> configuring it with the paravisor.
>=20
> Add the functions for configuring the paravisor SynIC

Suggest:

Add the functions for configuring the paravisor SynIC. Update
overall SynIC initialization logic to initialize the SynIC if it is present=
.
Finally, break out SynIC interrupt enable/disable code into separate
functions so that SynIC interrupts can be enabled/disable via the
paravisor instead of the hypervisor if the paravisor SynIC is present.

>=20
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> ---
>  drivers/hv/hv.c | 180 +++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 169 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
> index 2b561825089a..c9649ab3439e 100644
> --- a/drivers/hv/hv.c
> +++ b/drivers/hv/hv.c
> @@ -203,7 +203,7 @@ int hv_synic_alloc(void)
>  				decrypt, "hypervisor SynIC event");
>  			if (ret)
>  				goto err;
> -			}
> +		}

This looks like a code cleanup that should be part of Patch 6 of this serie=
s.

>=20
>  		if (vmbus_is_confidential()) {
>  			ret =3D hv_alloc_page(cpu, &hv_cpu->para_synic_message_page,
> @@ -267,7 +267,6 @@ void hv_hyp_synic_enable_regs(unsigned int cpu)
>  	union hv_synic_simp simp;
>  	union hv_synic_siefp siefp;
>  	union hv_synic_sint shared_sint;
> -	union hv_synic_scontrol sctrl;
>=20
>  	/* Setup the Synic's message page */
>  	simp.as_uint64 =3D hv_get_msr(HV_MSR_SIMP);
> @@ -288,7 +287,7 @@ void hv_hyp_synic_enable_regs(unsigned int cpu)
>=20
>  	hv_set_msr(HV_MSR_SIMP, simp.as_uint64);
>=20
> -	/* Setup the Synic's event page */
> +	/* Setup the Synic's event page with the hypervisor. */

You added "with the hypervisor" to this comment, but not the similar
comment above for the message page. Consistency .... :-)

>  	siefp.as_uint64 =3D hv_get_msr(HV_MSR_SIEFP);
>  	siefp.siefp_enabled =3D 1;
>=20
> @@ -316,6 +315,11 @@ void hv_hyp_synic_enable_regs(unsigned int cpu)
>  	shared_sint.masked =3D false;
>  	shared_sint.auto_eoi =3D hv_recommend_using_aeoi();
>  	hv_set_msr(HV_MSR_SINT0 + VMBUS_MESSAGE_SINT, shared_sint.as_uint64);
> +}
> +
> +static void hv_hyp_synic_enable_interrupts(void)
> +{
> +	union hv_synic_scontrol sctrl;
>=20
>  	/* Enable the global synic bit */
>  	sctrl.as_uint64 =3D hv_get_msr(HV_MSR_SCONTROL);
> @@ -324,13 +328,90 @@ void hv_hyp_synic_enable_regs(unsigned int cpu)
>  	hv_set_msr(HV_MSR_SCONTROL, sctrl.as_uint64);
>  }
>=20
> +/*
> + * The paravisor might not support proxying SynIC, and this
> + * function may fail.
> + */
> +static int hv_para_synic_enable_regs(unsigned int cpu)
> +{
> +	int err;
> +	union hv_synic_simp simp;
> +	union hv_synic_siefp siefp;
> +	struct hv_per_cpu_context *hv_cpu
> +		=3D per_cpu_ptr(hv_context.cpu_context, cpu);
> +
> +	/* Setup the Synic's message page with the paravisor. */
> +	err =3D hv_para_get_synic_register(HV_MSR_SIMP, &simp.as_uint64);
> +	if (err)
> +		return err;
> +	simp.simp_enabled =3D 1;
> +	simp.base_simp_gpa =3D virt_to_phys(hv_cpu->para_synic_message_page)
> +			>> HV_HYP_PAGE_SHIFT;
> +	err =3D hv_para_set_synic_register(HV_MSR_SIMP, simp.as_uint64);
> +	if (err)
> +		return err;
> +
> +	/* Setup the Synic's event page with the paravisor. */
> +	err =3D hv_para_get_synic_register(HV_MSR_SIEFP, &siefp.as_uint64);
> +	if (err)
> +		return err;
> +	siefp.siefp_enabled =3D 1;
> +	siefp.base_siefp_gpa =3D virt_to_phys(hv_cpu->para_synic_event_page)
> +			>> HV_HYP_PAGE_SHIFT;
> +	return hv_para_set_synic_register(HV_MSR_SIEFP, siefp.as_uint64);
> +}
> +
> +static int hv_para_synic_enable_interrupts(void)
> +{
> +	union hv_synic_scontrol sctrl;
> +	int err;
> +
> +	/* Enable the global synic bit */
> +	err =3D hv_para_get_synic_register(HV_MSR_SCONTROL, &sctrl.as_uint64);
> +	if (err)
> +		return err;
> +	sctrl.enable =3D 1;
> +
> +	return hv_para_set_synic_register(HV_MSR_SCONTROL, sctrl.as_uint64);
> +}
> +
>  int hv_synic_init(unsigned int cpu)
>  {
> +	int err;
> +
> +	/*
> +	 * The paravisor may not support the confidential VMBus,
> +	 * check on that first.
> +	 */
> +	if (vmbus_is_confidential()) {
> +		err =3D hv_para_synic_enable_regs(cpu);
> +		if (err)
> +			goto fail;
> +	}
> +
>  	hv_hyp_synic_enable_regs(cpu);
> +	if (vmbus_is_confidential()) {
> +		err =3D hv_para_synic_enable_interrupts();
> +		if (err)
> +			goto fail;
> +	} else
> +		hv_hyp_synic_enable_interrupts();

It would be nice to have some detailed code comments somewhere
describing how VMBus interrupts work with Confidential VMBus. I
see that the SINT is set in hv_hyperv_synic_enable_regs() by calling
hv_set_msr().  hv_set_msr() in turn has special case code for the
SINT MSRs that write to the hypervisor version of the MSR *and*
the paravisor version of the MSR (but *without* the proxy bit when
VMBus is confidential). Then the code above enables interrupts
via the paravisor if VMBus is confidential, and otherwise via the
hypervisor.

Assuming my description is correct, maybe just writing that down
in a comment somewhere will confirm to later developers of this
code about what is supposed to be happening.

>=20
>  	hv_stimer_legacy_init(cpu, VMBUS_MESSAGE_SINT);
>=20
>  	return 0;
> +
> +fail:
> +	/*
> +	 * The failure may only come from enabling the paravisor SynIC.
> +	 * That in turn means that the confidential VMBus cannot be used
> +	 * which is not an error: the setup will be re-tried with the
> +	 * non-confidential VMBus.
> +	 *
> +	 * We also don't bother attempting to reset the paravisor registers
> +	 * as something isn't working there anyway.
> +	 */
> +	return err;
>  }
>=20
>  void hv_hyp_synic_disable_regs(unsigned int cpu)
> @@ -340,7 +421,6 @@ void hv_hyp_synic_disable_regs(unsigned int cpu)
>  	union hv_synic_sint shared_sint;
>  	union hv_synic_simp simp;
>  	union hv_synic_siefp siefp;
> -	union hv_synic_scontrol sctrl;
>=20
>  	shared_sint.as_uint64 =3D hv_get_msr(HV_MSR_SINT0 + VMBUS_MESSAGE_SINT)=
;
>=20
> @@ -378,14 +458,71 @@ void hv_hyp_synic_disable_regs(unsigned int cpu)
>  	}
>=20
>  	hv_set_msr(HV_MSR_SIEFP, siefp.as_uint64);
> +}
> +
> +static void hv_hyp_synic_disable_interrupts(void)
> +{
> +	union hv_synic_scontrol sctrl;
>=20
>  	/* Disable the global synic bit */
>  	sctrl.as_uint64 =3D hv_get_msr(HV_MSR_SCONTROL);
>  	sctrl.enable =3D 0;
>  	hv_set_msr(HV_MSR_SCONTROL, sctrl.as_uint64);
> +}
>=20
> -	if (vmbus_irq !=3D -1)
> -		disable_percpu_irq(vmbus_irq);
> +static void hv_para_synic_disable_regs(unsigned int cpu)
> +{
> +	/*
> +	 * When a get/set register error is encountered, the function
> +	 * returns as the paravisor may not support these registers.
> +	 */
> +	int err;
> +	union hv_synic_simp simp;
> +	union hv_synic_siefp siefp;
> +
> +	struct hv_per_cpu_context *hv_cpu
> +		=3D per_cpu_ptr(hv_context.cpu_context, cpu);
> +
> +	/* Disable SynIC's message page in the paravisor. */
> +	err =3D hv_para_get_synic_register(HV_MSR_SIMP, &simp.as_uint64);
> +	if (err)
> +		return;
> +	simp.simp_enabled =3D 0;
> +
> +	if (hv_cpu->para_synic_message_page) {
> +		free_page((u64)(hv_cpu->para_synic_message_page));
> +		hv_cpu->para_synic_message_page =3D NULL;
> +	}

Freeing the para_synic_message_page memory here causes problems if a
CPU is taken offline, then back online. This function gets called when the =
CPU
goes offline, so the para_synic_message_page and para_synic_event_page
memory is freed. Then if the CPU comes back online,
hv_para_synic_enable_regs() runs without the memory being allocated
again.

Be sure to test the CPU offlining/onlining scenario to make sure it
works throughout the stack, including the paravisor.

> +
> +	err =3D hv_para_set_synic_register(HV_MSR_SIMP, simp.as_uint64);
> +	if (err)
> +		return;
> +
> +	/* Disable SynIC's event page in the paravisor. */
> +	err =3D hv_para_get_synic_register(HV_MSR_SIEFP, &siefp.as_uint64);
> +	if (err)
> +		return;
> +	siefp.siefp_enabled =3D 0;
> +
> +	if (hv_cpu->para_synic_event_page) {
> +		free_page((u64)(hv_cpu->para_synic_event_page));
> +		hv_cpu->para_synic_event_page =3D NULL;

As above, don't free the memory here.

> +	}
> +
> +	hv_para_set_synic_register(HV_MSR_SIEFP, siefp.as_uint64);
> +}
> +
> +static void hv_para_synic_disable_interrupts(void)
> +{
> +	union hv_synic_scontrol sctrl;
> +	int err;
> +
> +	/* Disable the global synic bit */
> +	err =3D hv_para_get_synic_register(HV_MSR_SCONTROL, &sctrl.as_uint64);
> +	if (err)
> +		return;
> +	sctrl.enable =3D 0;
> +	hv_para_set_synic_register(HV_MSR_SCONTROL, sctrl.as_uint64);
>  }
>=20
>  #define HV_MAX_TRIES 3
> @@ -398,16 +535,18 @@ void hv_hyp_synic_disable_regs(unsigned int cpu)
>   * that the normal interrupt handling mechanism will find and process th=
e channel interrupt
>   * "very soon", and in the process clear the bit.
>   */
> -static bool hv_synic_event_pending(void)
> +static bool __hv_synic_event_pending(union hv_synic_event_flags *event, =
int sint)
>  {
> -	struct hv_per_cpu_context *hv_cpu =3D this_cpu_ptr(hv_context.cpu_conte=
xt);
> -	union hv_synic_event_flags *event =3D
> -		(union hv_synic_event_flags *)hv_cpu->hyp_synic_event_page + VMBUS_MES=
SAGE_SINT;
> -	unsigned long *recv_int_page =3D event->flags; /* assumes VMBus version=
 >=3D VERSION_WIN8 */
> +	unsigned long *recv_int_page;
>  	bool pending;
>  	u32 relid;
>  	int tries =3D 0;
>=20
> +	if (!event)
> +		return false;
> +
> +	event +=3D sint;
> +	recv_int_page =3D event->flags; /* assumes VMBus version >=3D VERSION_W=
IN8 */
>  retry:
>  	pending =3D false;
>  	for_each_set_bit(relid, recv_int_page, HV_EVENT_FLAGS_COUNT) {
> @@ -424,6 +563,17 @@ static bool hv_synic_event_pending(void)
>  	return pending;
>  }
>=20
> +static bool hv_synic_event_pending(void)
> +{
> +	struct hv_per_cpu_context *hv_cpu =3D this_cpu_ptr(hv_context.cpu_conte=
xt);
> +	union hv_synic_event_flags *hyp_synic_event_page =3D hv_cpu->hyp_synic_=
event_page;
> +	union hv_synic_event_flags *para_synic_event_page =3D hv_cpu->para_syni=
c_event_page;
> +
> +	return
> +		__hv_synic_event_pending(hyp_synic_event_page, VMBUS_MESSAGE_SINT) ||
> +		__hv_synic_event_pending(para_synic_event_page, VMBUS_MESSAGE_SINT);
> +}
> +
>  static int hv_pick_new_cpu(struct vmbus_channel *channel)
>  {
>  	int ret =3D -EBUSY;
> @@ -517,6 +667,14 @@ int hv_synic_cleanup(unsigned int cpu)
>  	hv_stimer_legacy_cleanup(cpu);
>=20
>  	hv_hyp_synic_disable_regs(cpu);
> +	if (vmbus_is_confidential()) {
> +		hv_para_synic_disable_regs(cpu);
> +		hv_para_synic_disable_interrupts();

The ordering of the interrupt handling here is a bit scary to me, but maybe
it's right. hv_hyp_synic_disable_regs() first masks the SINT, and because i=
t's
a SINT MSR, it does so first in the hypervisor and then in the paravisor.
Then hv_para_synic_disable_regs() resets the SIMP and SIEFP. Finally
hv_para_synic_disable_interrupts() does a global interrupt disable via
the paravisor. I worry about there being gaps between steps where bad
things can happen. Might want to confirm with the hypervisor and
paravisor folks.

When VMBus is not confidential, the sequencing is the same as it is
now, which is good. There's presumably no reason to change that.

This is another aspect of my earlier comment about adding comments
that clearly describe how interrupts are to be setup/disabled when both
SynICs are present.

> +	} else {
> +		hv_hyp_synic_disable_interrupts();
> +	}
> +	if (vmbus_irq !=3D -1)
> +		disable_percpu_irq(vmbus_irq);
>=20
>  	return ret;
>  }
> --
> 2.43.0


