Return-Path: <linux-arch+bounces-13355-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6174B4074D
	for <lists+linux-arch@lfdr.de>; Tue,  2 Sep 2025 16:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2838C1B66020
	for <lists+linux-arch@lfdr.de>; Tue,  2 Sep 2025 14:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E17314A79;
	Tue,  2 Sep 2025 14:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="jwSJ1UwT"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04olkn2025.outbound.protection.outlook.com [40.92.47.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8BC31280F;
	Tue,  2 Sep 2025 14:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.47.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756824150; cv=fail; b=pTCS8Bjj770UsHtliXnQeUzRloskFWz6S182s9+o6Cb5EyxqD3zPk8Rgz24k1jjRJTj9IdZ89+Qpbaf/yE6rNu95BcvCclXer8tkyY0UcOaIDtoizcUFmFp/Dh8YSi1CF0YLFdy2/jLr2ieke4OrM2TK68PRIgmUkhMt+JjMtUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756824150; c=relaxed/simple;
	bh=bc6meLVigi9jK80hx0nfKMwMQ/gvl7U0LFpgsOpOYvI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=edFYY2MixzInr8KI9P4i0oFc4h79S3Wssm2qBTHqww8QLZ6dXRmlIzsSmjWcqPyPOjjPEL12NFHX41D07CLL8PxEnv9JhDx9Pr9ByqGXwtpW4cNIJAEYJF6OpHYN7fk+I+z9IrTUvOkimIRwNjoSqeGYRluTN05/LU2VzgvAFLQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=jwSJ1UwT; arc=fail smtp.client-ip=40.92.47.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aakwmMClCu8oCI4EoudNUs3yF152c8Yz/lIZMCtjqxOkbeDGPTwTbLXhIZ4+U/BPaDTOC5jqB62gKo+9tutk27NMK9D2KpoRsy4d9aP0yFPdh0ziTeLWwlOTNmMD4c56xHqG5I62qRM+sOKJwFPkXUWBAbF3fr7/wq58Jyo9Bg7nIyhikIeoIjr0q9Ey4Y9TJXEDK1IBeAq0X6DevMso1Z8AVWsIk4HuAureeQbW2quoNMBZyKUHlEmcIGcDBxfj5ZoE9A699rWUaaMsJwyPaJWOWH4DZVHlQFKFRtLwGUr8PlLtXU4qheSL0O3OGfJHYVRkKB6V110gga6ryHH6zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=se48TOdd2F1d+ktohq1z2zeXEu8JTZdq5AVMM0zhXMg=;
 b=QO7Gpb1n2/f/GaoNmCqjj+Ji5g6qESxEvGmd7A+vQTiZKO9H76Zx9S8j0VFrwlUaB7Djg+OM01e+v+cxABUmo2RTxQ2qsbLS5TKelkubzUu8649b/5sJrn/JXpbwsGMT6/EBZYJ6+fu/hcWL9eoVkLrESiMVNknMDBxycQQmNY8PLH7Xj8nE1AQyki5zAhOKKO0j0FRJ3roN4bNMDMIMWznD4lz0z9En+ljK576xBaVAxDCbmJHvIRq3iDUuavk37VMaRUXupwT0yqssjY20Vl+IEwJJKTK/T6mFlrUGor/4g3eqow4L7OcAdVp1upL+98bld0EIc0CoTV0bBQaPyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=se48TOdd2F1d+ktohq1z2zeXEu8JTZdq5AVMM0zhXMg=;
 b=jwSJ1UwTUR7FROfYEAkIS7w9pDUwf3rntpgIiVolslCBe7lO5SV8seVs2VL8nrRoKC6pg1EC9pWRx8gDJyv8QJr07hdk2vJJDh7bh4HR/F5IHEimH8bj9zRwrs/xTtPIN5gHo5a57W/MG+68CjvMNGNMZ/YqOxAGMMx5u+jQ+WERJ8UsIjtbq1AvtN1RVcuKDGo/aiEFHGc/Qk8bXWu9gNCFVmCodl+yOISwVF7jViX0xY4uQzlVTOdxx6jNu0ELPpc8octKLzfAwqO/sLZHd8vcfPg6ggXer8HkyBspw/kUK2hRWPwv35DOqjQLl7q+DKX4l8dGfpwMnZaDxSzJUg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by LV3PR02MB10030.namprd02.prod.outlook.com (2603:10b6:408:19c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.29; Tue, 2 Sep
 2025 14:42:23 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.9052.027; Tue, 2 Sep 2025
 14:42:23 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Mukesh Rathor <mrathor@linux.microsoft.com>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>
CC: "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
	"mripard@kernel.org" <mripard@kernel.org>, "tzimmermann@suse.de"
	<tzimmermann@suse.de>, "airlied@gmail.com" <airlied@gmail.com>,
	"simona@ffwll.ch" <simona@ffwll.ch>, "jikos@kernel.org" <jikos@kernel.org>,
	"bentiss@kernel.org" <bentiss@kernel.org>, "kys@microsoft.com"
	<kys@microsoft.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "decui@microsoft.com"
	<decui@microsoft.com>, "dmitry.torokhov@gmail.com"
	<dmitry.torokhov@gmail.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "James.Bottomley@HansenPartnership.com"
	<James.Bottomley@HansenPartnership.com>, "martin.petersen@oracle.com"
	<martin.petersen@oracle.com>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "deller@gmx.de" <deller@gmx.de>,
	"arnd@arndb.de" <arnd@arndb.de>, "sgarzare@redhat.com" <sgarzare@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>
Subject: RE: [PATCH V0 0/2] Fix CONFIG_HYPERV and vmbus related anamoly
Thread-Topic: [PATCH V0 0/2] Fix CONFIG_HYPERV and vmbus related anamoly
Thread-Index: AQHcF7c4ZH9DwegJF0iLCVnaUNUDXbR7UfGg
Date: Tue, 2 Sep 2025 14:42:23 +0000
Message-ID:
 <SN6PR02MB4157917D84D00DBDAF54BD69D406A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250828005952.884343-1-mrathor@linux.microsoft.com>
In-Reply-To: <20250828005952.884343-1-mrathor@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|LV3PR02MB10030:EE_
x-ms-office365-filtering-correlation-id: a40a4d39-6566-4539-a02c-08ddea2eed9e
x-ms-exchange-slblob-mailprops:
 YfhX3sd/0TVWrg+fxRScxfg9v9HXnUFl2bb0N5PwJ9age037L4Klz87A6NyjFdfQ8zYEvCPDD2Z9dLgS+qpBFyEHZS2T1G+CFZEgm+otSlW4Nu0RhuXIKAu0H1UhoRCwQASdRc4cGepmATgSb6B2epRKeVqTeXYHfl6108YYmB7N7wUwun8wMQKTjdrQdaBBW09pShWMy6EWb8JkjoYu08Eh9snF/14iUrTKGhJ8k/v5H8vGBbY5djvgqkc0MPupD1QcwqQJS9v/wHFcO7lGzq3sFWDchzBC1XwEG1/dtjJahWz81gqAgmgi54mBn3G07pKtjZip2C+iJ3ec47VvBI33oXcoOSq1JryUrrvV3wW+w0/S/KqJl5Yb4vAK5xx4Ce4IBk5XyegLrP7RMDF6ceNuyZEoB4MBoftKwedS+VHgef9sVbtWZTruMc3b5CJ913sSHinCpWY2hfpvDoADbDz1+WGxBU+ugPhESyFk4wkXH9NI91Lurhpew/sm5TWWXjyfREHFJlLLPLXVvweHEBU0GthnadUA0YgcrsLopyok2R5gn9WYjoA33feypqNNzl4cH1gSc4rkoRfmlMhxLYfzeM15NT2ShoJhD1Y7B+K1p+3wjI81qY3XG3QkLxgITxn2plnZvbZtrV5nJgLyyD+t1e/eMcW9mgo2GrQ8mN4CJwU5/pUqdDBQnatH5afrQLP2SSGSX0AfGbdxIA19BYpYXmIRmOpq8nENXwnSmvS4kYxE2eGUXyIV4nW1+bLC0BBTxz/T9sFskJSn4B+gtJglK197aqwlcJAaXSm5rUM=
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799012|8060799015|8062599012|13091999003|461199028|31061999003|15080799012|3412199025|40105399003|41105399003|440099028|53005399003|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?MsjLxTZUp2l4MG7FKz/9FJAkVd/1+5Eun0kfhThgV2qEyvQJO+CV+tmo4iy1?=
 =?us-ascii?Q?lR3ACW81kjxrouPyC7IHE66uupNO6CMKqsP536wbPSVEQpIM2JRhUBkzHzcM?=
 =?us-ascii?Q?EzbI0xmg1I8+IeGXOHyqUPK5hND+98TPkmYS3lzY4jmxipxF7H0pKZ2ED30S?=
 =?us-ascii?Q?QzdCk/9G+ngIHBpXza1zvFAPLAYVDV7003oFNBbPddEYJn7CrBRI1vtjy5eK?=
 =?us-ascii?Q?6CMnSfaJnw+pUbqxS+wUYnll9a7SUhfEmUhT8Mg1ck/lpYhHTHMUq14RSWXo?=
 =?us-ascii?Q?j+RdoSlQSL8gZXl2fL6AKtdVDlvNKqP9Tgk6eriZ/ErIE+3VlFL3wTcfMpfa?=
 =?us-ascii?Q?MRB0ajnoZeX5S2gujlG/H3rwyaXoTgmTc7fw75F+RKYwtNm+Sp/GsuaMVzZP?=
 =?us-ascii?Q?t3dm1uME6RY3qdT0J/cggjx8rE3Av21QD0gxEehXEDMV9zMb97DUwGUwjHqy?=
 =?us-ascii?Q?Fl1V+xGIyT/Ewb4bqr2COnHP0zEmAfxkydRUi0d6sDPPzhRx2yUmaoiHO9dZ?=
 =?us-ascii?Q?Kon+Z23INKDN7dxO+ek4iSImOrazEP1SgSCxvQsNDOhZnp9mVjYahvueTQ3l?=
 =?us-ascii?Q?dqy94Mw9pKJ/zNd87pdZU22Gg4aZV5RT+2NrWW1DngEucAGqBuxIoZk7+5BT?=
 =?us-ascii?Q?qov5wrbCDV3NyIYRbpnEwlIBT7YwfBJJy4Lxy6JQGV3RJy5qG6KVGPVhFr6s?=
 =?us-ascii?Q?OWSbWGAdcPNt/TSgoAXj0QWndW7TIZ7JHmdEbG6Zm3BKq4JC9oFcV+RkmEGB?=
 =?us-ascii?Q?W0Azxgppmxso1Oyi2tSbu+pXjw7/n4C0xzcJ1DKyOzuA52tpjTintfgOC6f7?=
 =?us-ascii?Q?NYGJYPl7q+liLpxeXehXJPVzHdBcyYdyMWB7znvDzf2/NBqcgt7UV1gKSkoL?=
 =?us-ascii?Q?jmarwzk1x7Z3Rz1/I/bCaM7H6vUSEx8W8wgQi+5N1XYZ3AMlRFJmoTuoHAcR?=
 =?us-ascii?Q?MjEc0ABQhHvWmoc5I0R+Ve6bHxcOssatURNQgkYkaF5pMnwA58rCG7sd2FAL?=
 =?us-ascii?Q?pWnS256pWzV92Oq269+BitW5GVvOEfF7Nyz1/oKGApqlK9CbFQ/dilaPcwEw?=
 =?us-ascii?Q?/uB2ZKmvzInR+7kH3k1VlYNJs6Mq82le/IbUpmP9lWh4Bgz0ckguEQ86gjy/?=
 =?us-ascii?Q?IVUcIXGy9QFqpPh2CLCCo5dZ79WYW1G9d3SaEr+LEGu7bOmA7F5vrF+IYP/R?=
 =?us-ascii?Q?wXh5CGCxQOr+dwFWwGCtnXjeNDg4UEt6tSjj5CPET2xeoqOedGfg8fe8NYg?=
 =?us-ascii?Q?=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?4ioLFhR5M7csGXZ4ltKT8xjjCUJDyLM5t7kKKEL6ltC9DniUyp1BkwuRGHV+?=
 =?us-ascii?Q?1YgfGQx0IrOzJRPimNqCEuePUNLPjV9zBliPeOIQC2/S41/9qAlh/FUATZ9Y?=
 =?us-ascii?Q?gUU9T/Ghu5nO+MGq4z92Pw57kgRgXPM0UIgMiNcnkLEXpImxEbrh+KfZ0YZx?=
 =?us-ascii?Q?aT/Xv0frboHUwt6LS3pKlxjxn/Na2DFfPLQOCAAvCqtLRcWXUyZmBtq4/4T/?=
 =?us-ascii?Q?8HC5lshDIBs3f6CgcONu51Zv0/oG+eD7kO+vjcuzd71WuyLV069/tJes1LND?=
 =?us-ascii?Q?o4BwqShs9hBge2t71qySBj7KIC38VPSKKApmw4RWDlTXqqO/vm/2XUUG77sK?=
 =?us-ascii?Q?rtuyuhRPPqaE6gSct+THgNuDM8NscsAoj/+q28vVNsDdpXlEg1G0ZL/mAqbP?=
 =?us-ascii?Q?zHoFYxNjTAIvsxu4ze3yVbrWbYVs1pIhKn2qfHF+yRLYXP04T3MOEXOIsS4W?=
 =?us-ascii?Q?RHZaT34ZWU9e+DsK1Nx/bBRS6Z4qEgqhIOiHXmBl8XxEqXRx0PWWXOz4sIsl?=
 =?us-ascii?Q?LgFpWSkUBe5l0pq1K86IsGGJC+opaQ2607UGoJJgB0xHHvnayNlBEUV6XHQy?=
 =?us-ascii?Q?1sfLZ1SwUEu53tXrp9aVORYshTGLj7M6gcBIAiKkW/3niJOGDmS+4JHSRjis?=
 =?us-ascii?Q?koJ80zD24Y/yDbVPa0ZQvaBdh4KIUQ2OAhhBA64y6wn2aoW5uhbI9QNKXryd?=
 =?us-ascii?Q?6rrVM5tF8ghHHex3FEwEg0AxlXAAObMuA4zF1xLN161XTq9mSMztbnZU1xJj?=
 =?us-ascii?Q?s8C11XZgeO0ohkcATRFS2Gj/JAiE238MgcBPNk8Flrf9HxYukrbFPnwgtDXV?=
 =?us-ascii?Q?G82kG4ma5cjENkIzCqyRzlZbuCq9QpeGv3Y3zMcpR8vJRxtMGxV4XQVGTFju?=
 =?us-ascii?Q?BNS6MEFc+VUcqpojdL3em8tR4EX1IJZo5eX+XHJ1zqnAdeRlofmt92rzCbDx?=
 =?us-ascii?Q?RtdL/WR4+P6csfBrYv0MbAn3U8i4oGp+bcATwYULVLrElqMYsnfxVvaTHvXK?=
 =?us-ascii?Q?00K9/WxiTeyxp7jto6ST0StV87M2gSSUu2e1OB6/RhVUnbOlpHXx6eYRmSfM?=
 =?us-ascii?Q?tkZVa7yw9onzj+Ohlg0l7Y9jvAMNQ3TCi3Gj4kHrmk0qFDP50KR9lDBQsXML?=
 =?us-ascii?Q?BTVh8UfkQVdYJHwylV548FswQz4T9WlNGLzrLG1uOQLRh8anicL0hSbWigb1?=
 =?us-ascii?Q?/kes0dO4FsQ7FZqMwru2++j6NiHHKjWy90ybMezCKVtxPCGgVPseBDb6x28?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a40a4d39-6566-4539-a02c-08ddea2eed9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2025 14:42:23.2331
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR02MB10030

From: Mukesh Rathor <mrathor@linux.microsoft.com> Sent: Wednesday, August 2=
7, 2025 6:00 PM
>=20
> At present, drivers/Makefile will subst =3Dm to =3Dy for CONFIG_HYPERV fo=
r hv
> subdir. Also, drivers/hv/Makefile replaces =3Dm to =3Dy to build in
> hv_common.c that is needed for the drivers. Moreover, vmbus driver is
> built if CONFIG_HYPER is set, either loadable or builtin.
>=20
> This is not a good approach. CONFIG_HYPERV is really an umbrella config t=
hat
> encompasses builtin code and various other things and not a dedicated con=
fig
> option for VMBUS. Vmbus should really have a config option just like
> CONFIG_HYPERV_BALLOON etc. This small series introduces CONFIG_HYPERV_VMB=
US
> to build VMBUS driver and make that distinction explicit. With that
> CONFIG_HYPERV could be changed to bool.

Separating the core hypervisor support (CONFIG_HYPERV) from the VMBus
support (CONFIG_HYPERV_VMBUS) makes sense to me. Overall the code
is already mostly in separate source files code, though there's some
entanglement in the handling of VMBus interrupts, which could be
improved later.

However, I have a compatibility concern. Consider this scenario:

1) Assume running in a Hyper-V VM with a current Linux kernel version
    built with CONFIG_HYPERV=3Dm.
2) Grab a new version of kernel source code that contains this patch set.
3) Run 'make olddefconfig' to create the .config file for the new kernel.
4) Build the new kernel. This succeeds.
5) Install and run the new kernel in the Hyper-V VM. This fails.

The failure occurs because CONFIG_HYPERV=3Dm is no longer legal,
so the .config file created in Step 3 has CONFIG_HYPERV=3Dn. The
newly built kernel has no Hyper-V support and won't run in a
Hyper-V VM.

As a second issue, if in Step 1 the current kernel was built with
CONFIG_HYPERV=3Dy, then the .config file for the new kernel will have
CONFIG_HYPERV=3Dy, which is better. But CONFIG_HYPERV_VMBUS
defaults to 'n', so the new kernel doesn't have any VMBus drivers
and won't run in a typical Hyper-V VM.

The second issue could be fixed by assigning CONFIG_HYPERV_VMBUS
a default value, such as whatever CONFIG_HYPERV is set to. But
I'm not sure how to fix the first issue, except by continuing to
allow CONFIG_HYPERV=3Dm.=20

See additional minor comments in Patches 1 and 2.

Michael

>=20
> For now, hv_common.c is left as is to reduce conflicts for upcoming patch=
es,
> but once merges are mostly done, that and some others should be moved to
> virt/hyperv directory.
>=20
> Mukesh Rathor (2):
>   hyper-v: Add CONFIG_HYPERV_VMBUS option
>   hyper-v: Make CONFIG_HYPERV bool
>=20
>  drivers/Makefile               |  2 +-
>  drivers/gpu/drm/Kconfig        |  2 +-
>  drivers/hid/Kconfig            |  2 +-
>  drivers/hv/Kconfig             | 14 ++++++++++----
>  drivers/hv/Makefile            |  4 ++--
>  drivers/input/serio/Kconfig    |  4 ++--
>  drivers/net/hyperv/Kconfig     |  2 +-
>  drivers/pci/Kconfig            |  2 +-
>  drivers/scsi/Kconfig           |  2 +-
>  drivers/uio/Kconfig            |  2 +-
>  drivers/video/fbdev/Kconfig    |  2 +-
>  include/asm-generic/mshyperv.h |  8 +++++---
>  net/vmw_vsock/Kconfig          |  2 +-
>  13 files changed, 28 insertions(+), 20 deletions(-)
>=20
> --
> 2.36.1.vfs.0.0
>=20


