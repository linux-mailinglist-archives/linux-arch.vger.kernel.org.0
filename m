Return-Path: <linux-arch+bounces-12896-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 905C1B0E2EC
	for <lists+linux-arch@lfdr.de>; Tue, 22 Jul 2025 19:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D4321C85766
	for <lists+linux-arch@lfdr.de>; Tue, 22 Jul 2025 17:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3A1281352;
	Tue, 22 Jul 2025 17:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Jdnme6x9"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2049.outbound.protection.outlook.com [40.92.40.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B98191493;
	Tue, 22 Jul 2025 17:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.40.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753206310; cv=fail; b=Lq6os4J0vP8h6WmvGe4/9i5I9zTAmBbPwg6mZwlPC+XEmU2xtmjPt3cUm2UfK04j7hyNNTbiDk6HYxS1+QHwevalDwIfQ2NXePk6cpv5J1S65KwUNr3kNwzEZcYyjcn4iKYwZF7nHSgxCokmTnBbafyr+Xq86PjpGZYaBrgun4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753206310; c=relaxed/simple;
	bh=GETzCeHeWUxia2VV4PlMR6Go7w9LY5zXiM4c5BYJUrw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=N9qwfyKFq6UL3y58VmC8tteEYlHzHgFmPC8v9NHYXI9VT8GKI0i5uZHjUOOa2mfXsRVRbRo+sfUmN+xty80C44A+yTt/AsEETJL8wGsaKok2SWhd32gOpLRuvKyazo3CWothYxfOOqOBqjc3vWs+5xDShri7vJbm/nmMwNXU+gg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Jdnme6x9; arc=fail smtp.client-ip=40.92.40.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gGXFqxAMx9gu2JKokziQQgDrGSCygxBxrx4+aowyMuGdlqQcHQY+KHueuZr6WH0CFbX5avDz6zH4AEag9pADJwMfEiFIau/nxwJx7/N3Lt54AWYXnOHNhnywBJ40yPYLfj66Rqmr5QKPp/O2qNW9/99lbt4/AV3/D/PgCyDP/IDG1n8UB/sO7zGg+nEaxDMatwMuMPwXoow9MWtd+A7woCrDJTHoLqmLZApV40Up8EJivR9H8I6eg+RpQAWbFrSPsqqkhGXi5TLfZHe3r9FNcWAwGd6Iq3g5hyc3iEq/PrOojhMPEgqQ59G3llXxH0I6+2i8LsYwGQQn4hM9aeqYxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IZ7yWlgjH1yY6ynxdoQ5/ZmTpJRHACt+CwNFKBL3lr4=;
 b=P/kTVO50so5kGo/I8Z6dR+OavWqkMi1ffVvhq+ArX+bpuvdeIQ3zEd15zzIeUWPKudSwPKa9VAdCm6YF5tmY7FcHXSK7lfvVY2Wm7WjdmWsdj2eyAXA2z1wWB+t2KAz+5GqVh+E3tGBkNOAcHUP171RZYBLjOXY22xOooUuRfLYhBq18D2hjPoL1jKf0/szEpn049MIxdYJLJxkn1OnmKir3Qdx9JChI7ryva2LR5o1MTL1QUzyrT77IVeyv7oac8xHpyE7HKyolxf82/6xvAhkQngYIUBnd7UVmwTR7WP1GFB5Z1Yu5y4MMXevDUXkZyKQgYJ/qSUi1GKl748bZEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IZ7yWlgjH1yY6ynxdoQ5/ZmTpJRHACt+CwNFKBL3lr4=;
 b=Jdnme6x9Ms8Vog4N4ElIL1dJVIaid3iY//7D5XGRk5EIoT58gUM0JA6AZfPDHiAa+XKcpAgxWQDr9fQSy5ST3vsbrHfHoGxKFqCMx/JEcA18jK3iCCnI5brfiYriHdeV/PDqHG+osw2sEn0f56FaIypYZ9onvt43RYWPK0A+3/pIViYXgm8lsh5gyux3PnxQu5f+KC9Qx1FYVGYgOprmYE+CrKPtnTUJK6xsgb7K8d9NCe+0soOcPi0jP5tZ5ZYMAxxpUoXhZ6FKcLiZnOxzWoODXzZF3IyOhpHM+Sx60lAy2QRcAOtJ1fDzu6MOd+GQsvDfdpikPG6jL2vHBU79jQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CY8PR02MB9201.namprd02.prod.outlook.com (2603:10b6:930:9c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.28; Tue, 22 Jul
 2025 17:45:05 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 17:45:05 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Roman Kisel <romank@linux.microsoft.com>, "alok.a.tiwari@oracle.com"
	<alok.a.tiwari@oracle.com>, "arnd@arndb.de" <arnd@arndb.de>, "bp@alien8.de"
	<bp@alien8.de>, "corbet@lwn.net" <corbet@lwn.net>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"decui@microsoft.com" <decui@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"kys@microsoft.com" <kys@microsoft.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "rdunlap@infradead.org" <rdunlap@infradead.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "Tianyu.Lan@microsoft.com"
	<Tianyu.Lan@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>
CC: "apais@microsoft.com" <apais@microsoft.com>, "benhill@microsoft.com"
	<benhill@microsoft.com>, "bperkins@microsoft.com" <bperkins@microsoft.com>,
	"sunilmut@microsoft.com" <sunilmut@microsoft.com>
Subject: RE: [PATCH hyperv-next v4 13/16] Drivers: hv: Free msginfo when the
 buffer fails to decrypt
Thread-Topic: [PATCH hyperv-next v4 13/16] Drivers: hv: Free msginfo when the
 buffer fails to decrypt
Thread-Index: AQHb9Qzcv0brGDBEBkW7YQrUCD5iQrQ4wVqw
Date: Tue, 22 Jul 2025 17:45:05 +0000
Message-ID:
 <SN6PR02MB4157BBB94F6D2D7592B17C14D45CA@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250714221545.5615-1-romank@linux.microsoft.com>
 <20250714221545.5615-14-romank@linux.microsoft.com>
In-Reply-To: <20250714221545.5615-14-romank@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CY8PR02MB9201:EE_
x-ms-office365-filtering-correlation-id: b36ce041-ff89-464a-b7ef-08ddc9477e2b
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799012|461199028|41001999006|56899033|1602099012|40105399003|3412199025|440099028|4302099013|11031999003|12091999003|102099032|10035399007;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Bjp75qMkmUwxNU92x3gTe3HfsXsGlj7Xj0RMXirxQJBxoMeaaVODqgHcgExA?=
 =?us-ascii?Q?0dA0i5Ou5wH+UUoXFqlSxvvGx6bL68o13/mLuGGFweJQJsHQM5NfnlqFaS5X?=
 =?us-ascii?Q?HtUFInHd06XHhjvLOjqrjnLGoFQjqO2TGOePEFfYd9OdujBFIjAueijVF2gG?=
 =?us-ascii?Q?bLaZd0Q3a5UkU03v38tGBwc5+BmjJ2P1Dv7wLXbLMZ6lQg5cQKyJkq+MBmZ9?=
 =?us-ascii?Q?UvbquDVSZB9zNZaIuGT54cYNj8IM+XBOSw7HSm7ztkwe6Vf0haYsmMwYAkOy?=
 =?us-ascii?Q?MiQL9GbyAesn2FXYsvTlDqHhiSvkdLGrOhj8qOP3vmyPP0ywKa9lHdDcuxbP?=
 =?us-ascii?Q?6EL9UfPLee5y2sJXBbRfPfcTdrjdSQ3vTbcjD0d705kydAfSTjdxc2e31xtm?=
 =?us-ascii?Q?pkiRySremuYXyzoTj5TrUZhUsxoR602knBdiB/PVfcl7/L+5NyO7977vReLx?=
 =?us-ascii?Q?cdVHA7TY3Zf39N2PAwaIQWReTCanBgWzNHNBkPYyKxfMwgOhy8J1X7C7qXhZ?=
 =?us-ascii?Q?iZaKve/3VFcTK3snhtMHg0D/our0DfEQzBq4pvPiGvMBnycA1bKfVntpLfi2?=
 =?us-ascii?Q?5islWsksgMF1gDXxWMLsLIhx+/dub+P9wYHLMm03f2nzHMeEMlpwjdC/JXiM?=
 =?us-ascii?Q?rb3VkoFtYiMPw/yXdiaLSi/IpPV8OlYWuI5HxKudVx3tXKyHkt2GlH+iH3Yq?=
 =?us-ascii?Q?nx5lz0xQ5SdLUDzedHWOul8wv8OVO6NoK4KtwtlRCL/pb8OkQHklACq85EUJ?=
 =?us-ascii?Q?R24D2FrG+9jQUzf2HcM6/7sKUT7zQpnnRG5TDRTWYL5VQM9RgCXbcWqnpydo?=
 =?us-ascii?Q?2kMz8EYr8/SFZvzyunNiz0cIIEZQ6dqwf81SxQWeaqos11kiXNyiZG/mmAKZ?=
 =?us-ascii?Q?okeahRyW2hez7RSMfrLL6rPbJAjtaUz5lXiMDWhu+oMIp6sjzBH48EaSQKe+?=
 =?us-ascii?Q?uIHIEDkkdA6BUMTXUq2m0gIGykIk0XEuzTH6phTNTYQ4i/LiOKReCkdBHOAv?=
 =?us-ascii?Q?rE5FndyPsvtYZFmm1n+DWl14wb/BCIv6O6Ls+//YrcK+LSTPodBdlo0+kJbF?=
 =?us-ascii?Q?oTYqKa9NyJYsvSDs/NiMfCRGTlK2dZQ7675rHb2CG4tsEUCYwNM8biP4a6kz?=
 =?us-ascii?Q?Vil2KxoSvjJvlMI8F094GbxB9i90e4+uWX1ReOR36lzeUXPpuzfKjzWKX5KI?=
 =?us-ascii?Q?2Tc0uhLCH4K73IJYEKNHztT2rvvQahsgGRzNyl1mTqi8E4tvRgyMrKh/9nUJ?=
 =?us-ascii?Q?s8ZXvlzIKF7gGIR1iANn?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?hZeSL78BytPepjcm5/k2vdgYHQiTH7+GCgieg7ygY0FTV5U16VhmyfVWiUyA?=
 =?us-ascii?Q?GrLs0rbICND/pe57P5QV8Xjukgr7+BibVX4Y1RkfbOv0Lj8De7op431QfRDP?=
 =?us-ascii?Q?hdXKyQSgsp5qTw0D+85VTpoiZhwoK/qLkuKrqZhf1UJS5ob6T+U1ay2uWafI?=
 =?us-ascii?Q?3KZck2FR+te34wvs6IQVIee0O6b7ZT4vwblZBqgTE92K6CD3WxD27Ncgi9aJ?=
 =?us-ascii?Q?PAhyu7VR84qVSYveF7vThs95eRB6NyCz+ttPZAxVUmFhTzcRe0HGS3CAJwOd?=
 =?us-ascii?Q?kY6VAhSQq0djwkPX6QjhlmCCHntfKQFTilQIRnpzUL/2QP67xuitKGDJEUiq?=
 =?us-ascii?Q?i1tkVCBdI1+EYrVD5oAsXsxAVmUuE3WV3iJHwhVAxvpX7UeVMFPCFUSzKpxA?=
 =?us-ascii?Q?X/oErbGhgwNA2mn5qp2Ljx77F8NGk/S44fpAcMFMY4N4iaTD5Ved9dqsE+vn?=
 =?us-ascii?Q?TVeOd3VHxqtSw4nZyhwI2Cx7d0B7B02XTNz5ar+FZzsAm3ICxPqGIgEGJsVR?=
 =?us-ascii?Q?tr4ULDh7nE1GH1/F1sRCt3s+q3kYjNrlvWmE0Zow76N4RkWRSsw929FE3hOu?=
 =?us-ascii?Q?JH6xKf1fmXx+kzGq4144WiRgZwhgp8k7vL6bFcok+YG+gdPgGgrJejSobnRN?=
 =?us-ascii?Q?R6633laojHcivaMbqZiAM+zXFscwd+fImmPyc2J0iS2VLEEYwkdHufASJPk1?=
 =?us-ascii?Q?7Oagv99iv10jB+H63ij8ei1S3mDAi+QMpCEqgBtje0yS8e+ESoZewpw+OoBE?=
 =?us-ascii?Q?a6ujIcZjj5btehlSKLbAymslFQGDKGu2q1LqqszFemz+I1494qmSNghD1l0s?=
 =?us-ascii?Q?/hAHko5VFND1hki3CmBYFZu//2lDXbBtAbq2Fvm/J7CzCR/pD40zu61vuGqg?=
 =?us-ascii?Q?mOYVTdlGuYJfK+srso9k4ydcbqlUXbu9g4i4/ftLob6N91HuH+xI6oVDVWQY?=
 =?us-ascii?Q?Z0Fo2rx0VRD+af8ueDw90sYZcFB4cSochzf3KPatdKmIeYAVQr3EovymhYzW?=
 =?us-ascii?Q?ub7DiXouTUmUZ0lXe8EMGDt8+mBGgZQxSPDCyBXswnE8S2DDjDLOznWFcE7X?=
 =?us-ascii?Q?qZk2JqOa7TumQX0k214FnnGxJbUOgGJRlHUbpU2748ZN3sOanUPt2NkJhTW4?=
 =?us-ascii?Q?2HdGwrj5EMQ4UNVaUBdBIPsPj+xDLmCFn9ljyfzLeHfUi+MEZdjdUvna4AtT?=
 =?us-ascii?Q?HDY3R1+OUqOxJoilugB+2unl9PCgoojiOQdxbwGNBDquUIEhDujTkUSoND4?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b36ce041-ff89-464a-b7ef-08ddc9477e2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2025 17:45:05.2920
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR02MB9201

From: Roman Kisel <romank@linux.microsoft.com> Sent: Monday, July 14, 2025 =
3:16 PM
>=20
> The early failure path in __vmbus_establish_gpadl() doesn't deallocate
> msginfo if the buffer fails to decrypt.
>=20
> Fix the leak by breaking out the cleanup code into a separate function
> and calling it where required.
>=20
> Fixes: d4dccf353db80 ("Drivers: hv: vmbus: Mark vmbus ring buffer visible=
 to host in Isolation VM")
> Reported-by: Michael Kelly <mkhlinux@outlook.com>

s/Kelly/Kelley/

> Closes: https://lore.kernel.org/linux-hyperv/SN6PR02MB41573796F9787F67E0E=
97049D472A@SN6PR02MB4157.namprd02.prod.outlook.com/=20
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> ---
>  drivers/hv/channel.c | 32 ++++++++++++++++++++++----------
>  1 file changed, 22 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
> index 051eeba800f2..0eb300b940db 100644
> --- a/drivers/hv/channel.c
> +++ b/drivers/hv/channel.c
> @@ -409,6 +409,25 @@ static int create_gpadl_header(enum hv_gpadl_type ty=
pe, void *kbuffer,
>  	return 0;
>  }
>=20
> +static void vmbus_free_channel_msginfo(struct vmbus_channel_msginfo *msg=
info)
> +{
> +	unsigned long flags;
> +	struct vmbus_channel_msginfo *submsginfo, *tmp;
> +
> +	if (!msginfo)
> +		return;
> +
> +	spin_lock_irqsave(&vmbus_connection.channelmsg_lock, flags);
> +	list_del(&msginfo->msglistentry);
> +	spin_unlock_irqrestore(&vmbus_connection.channelmsg_lock, flags);
> +	list_for_each_entry_safe(submsginfo, tmp, &msginfo->submsglist,
> +				 msglistentry) {
> +		kfree(submsginfo);
> +	}
> +
> +	kfree(msginfo);
> +}
> +
>  /*
>   * __vmbus_establish_gpadl - Establish a GPADL for a buffer or ringbuffe=
r
>   *
> @@ -428,7 +447,7 @@ static int __vmbus_establish_gpadl(struct vmbus_chann=
el *channel,
>  	struct vmbus_channel_gpadl_header *gpadlmsg;
>  	struct vmbus_channel_gpadl_body *gpadl_body;
>  	struct vmbus_channel_msginfo *msginfo =3D NULL;
> -	struct vmbus_channel_msginfo *submsginfo, *tmp;
> +	struct vmbus_channel_msginfo *submsginfo;
>  	struct list_head *curr;
>  	u32 next_gpadl_handle;
>  	unsigned long flags;
> @@ -458,6 +477,7 @@ static int __vmbus_establish_gpadl(struct vmbus_chann=
el *channel,
>  			dev_warn(&channel->device_obj->device,
>  				"Failed to set host visibility for new GPADL %d.\n",
>  				ret);
> +			vmbus_free_channel_msginfo(msginfo);

I don't think this works. At this point, msginfo has not been added to the =
global
vmbus_connection.chn_msg_list.  vmbus_free_channel_msginfo() will try to
remove it from that list using list_del(), and will fault on a NULL pointer=
.

>  			return ret;
>  		}
>  	}
> @@ -531,15 +551,7 @@ static int __vmbus_establish_gpadl(struct vmbus_chan=
nel *channel,
>=20
>=20
>  cleanup:
> -	spin_lock_irqsave(&vmbus_connection.channelmsg_lock, flags);
> -	list_del(&msginfo->msglistentry);
> -	spin_unlock_irqrestore(&vmbus_connection.channelmsg_lock, flags);
> -	list_for_each_entry_safe(submsginfo, tmp, &msginfo->submsglist,
> -				 msglistentry) {
> -		kfree(submsginfo);
> -	}
> -
> -	kfree(msginfo);
> +	vmbus_free_channel_msginfo(msginfo);
>=20
>  	if (ret) {
>  		/*
> --
> 2.43.0


