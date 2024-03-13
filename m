Return-Path: <linux-arch+bounces-2966-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C42587A2AD
	for <lists+linux-arch@lfdr.de>; Wed, 13 Mar 2024 06:29:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0F48282703
	for <lists+linux-arch@lfdr.de>; Wed, 13 Mar 2024 05:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295981170D;
	Wed, 13 Mar 2024 05:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="LdamE+F7"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2073.outbound.protection.outlook.com [40.92.42.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02302C122;
	Wed, 13 Mar 2024 05:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.42.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710307753; cv=fail; b=Rrk/tEp4LsW6nJb7HDwxKhHBXldxED9NWLC4oM1ferNNkgBBGP7hD/uWi0so+QVBicF9keQoxSM6x6/mpZzl/d4sPV7MSNNecc33XFQlwFBwPKjAlPvWP2v/NfmSldrDM/hzrsNbKRbCWBGCk+PdzkJDdA+PZ9tTexwFjJU9Q4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710307753; c=relaxed/simple;
	bh=NvkPFvN54TKLnCOtVSwr+VvP2H/C+sqAffwBchB/2Ec=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=c1vR4suJDl97Smcr0hRp35hBxdVeS7uYieGvuqWvGfhRBY5mxYtRp4OFK5QoO9wygZ4lQcS3Ma7bWuyllWjT4/Olm+sGR78P4VJ416FC8ERPLNIQbfQNffwrZL41KNhSJxbRbzOEc0vbOwC07aeuF5ccttSzvIXHjPwlomjdcrQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=LdamE+F7; arc=fail smtp.client-ip=40.92.42.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GiovIq3zql6MU/UBvFRbEIoMG5c+cKDHLf3QtehSwMHNHo/KCUam+3Xs2q2INKvxBRk/Mqc6ZxHsBtSNica97zeHf1hqLkUMr0OM97CqxS5OnMQ4gNIYg8fYez3TZ21oxZGmpsOEese2fhE9IDjcI8UbMAXSGFoVgBahW9BSkTcAP88fPessILLs7nNBEU1pnFNUBhLVvHF7NQRDGZddUsPREMV2uqRx3vOVDdgICH8UHV67vCqIV7323VRb78YXofi6sg2oKhZ8dUdnuoUm2J+Kg6XEEwB1k/C3HKFj2oie8AFSMzX/b1/VYgwqVw9axdRqtGcpMUm/W+wdNA8sog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dQcA4PPjT92tte1SYGIIIHpkAJ6BCQKzEw3zceAB3dw=;
 b=aXMn0UftU8ZV1JspaNrZSIdXjfnx41ckzsXdfuFDiSwyTcBGu091IBk3DizR1exeNrQRgPBbveytlKqhXzfX+rYEAryRNNKx1FldUf17vDUwx2Uq8QCeadY3UCB6Ac9vaxiYfJ6FBUZZTEZXfeeSRBsTE2Pke5dlMf/aYwLFEQsfR1Yyae52kJeWEsnvUQZBDoyYXMTTBAl7TGr6H5bhInAVd2GrqDYjKP1oAlAEcokNc0krOLW5Q2ih3kyhEGe3UlI4iOVY5u6e/dc6XzWtvTj4V+B1EtM3nQwA20u/EEI60n4+vbUKDVy84AJWBDD4zte9c0XHeU9gXgocPmgNTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dQcA4PPjT92tte1SYGIIIHpkAJ6BCQKzEw3zceAB3dw=;
 b=LdamE+F7FpBlj57yZSyBhZ7c+f50frtwdtPPdRusEYgeregb1jMOffv3PhshCaCIrNeVqWUJYQ0Lh8tl6uc0JcqPLtDOqWgq3A4OTNPIPWB4aQ6LqEUbL4qwT9LZwbRPXFFspomCT4b+Yws1r/4HEFZ+JjvfNjCWEmNGIUJlA67Ufz9QGp8/kaFryiwRmgP1Zc+kpq6+MzQtncnsYYEvBDbJriFRfrFdLTHhXZ3PrgYgzEE7TPix017g0qc80K6tEvM9s5p5aEXW7v4oF6u0+rJ0pStBPzz6CG8Ti1L1K06qPdvNdBWzvvGQVaSkBd2U5IsTIREhnV6TEF1XKXa0rg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CH0PR02MB7932.namprd02.prod.outlook.com (2603:10b6:610:101::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.34; Wed, 13 Mar
 2024 05:29:08 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd%5]) with mapi id 15.20.7362.035; Wed, 13 Mar 2024
 05:29:08 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Long Li <longli@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "hpa@zytor.com"
	<hpa@zytor.com>, "arnd@arndb.de" <arnd@arndb.de>, "tytso@mit.edu"
	<tytso@mit.edu>, jason <jason@zx2c4.com>, "x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: RE: [PATCH v2 1/1] x86/hyperv: Use Hyper-V entropy to seed guest
 random number generator
Thread-Topic: [PATCH v2 1/1] x86/hyperv: Use Hyper-V entropy to seed guest
 random number generator
Thread-Index: AQHacMAZOd50lMXg2E+WGXTGLlHRJ7E1IpWAgAAI74A=
Date: Wed, 13 Mar 2024 05:29:08 +0000
Message-ID:
 <SN6PR02MB4157E883A8EA7796264D3AA7D42A2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240307184820.70589-1-mhklinux@outlook.com>
 <SJ1PR21MB34571493BC1473790F5917E0CE2A2@SJ1PR21MB3457.namprd21.prod.outlook.com>
In-Reply-To:
 <SJ1PR21MB34571493BC1473790F5917E0CE2A2@SJ1PR21MB3457.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [nnO0d94QcuK1BYdK/tzW9m4QBCPsuQ37]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CH0PR02MB7932:EE_
x-ms-office365-filtering-correlation-id: 73373275-ae45-45b2-9caf-08dc431e8191
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Qzyd28YrsVpSc8Fyq4c6/jztR4WwUWgdcoBe8X2Gp2GZctcr/ljCOgJeGcQwBVXP4WCdsm6nw4XTKzrbNI+kGH4pzGIcUNOrKRCyaWyCC0BJjudUBXzXCK3loxnmw2cn0jk05XDKgtx/jo5pDTa8cx/DUcbj11p4JTnln4kzAUdSbAAgSjbTYXLyiRnb5woI3YT6/xYnQLe+mn1r6vAYFN/Ny0sQ5r+jJ8gVXVnnGAtLMqJhryn5pMcGC59KXtv7NEYsL7fGFPKrlp1hn4vw17g01pio13bM8tlC6I3dUhAAet0W6JNO1mBGQLuKi0TXJCuyiknoiSpk7vfg/D2twLn+8RIj2/Ta5COCezw2nXbbTJU3Vvtv0Mm0wq5io4xZ/kSxIG8859RYvd9sQ1eUpxlKiDlTq5ZoXwEEx8X79yfS7P5rX/VbayVREAXc6+0CBH4cUHXMa+eit7McV4SMccx1gtxv2mDpSeQTsP9PSzRgr0CDpE6ubqPEqcTDO20BjlSR6iqlnRL4czIz+qjCnLJ8lWlKnnnBP5O/eSWllI2hQ/h4qGZSYq5T9GvLh06R+ujnitvLUJFLZR2Snt7r/4evorNRkXKypqchK5vmlhlCl//IMd+JS1nfKvm6/RDmaRKWKaZZZYJGPn5b5bhHyVdWCZGc6GQaewU/kwYyUGA=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Z7xo2yiUw5cdOubkGGdIbCIIqkPHbd+BVMP+ZirBIaXEjnLV7zdvh2mb+SFZ?=
 =?us-ascii?Q?HTkTYYt6d9z9S9tAbUtG65giKj4ejjUdJSBBUwOjWKy3wRcp9Z7qvFvXn3ea?=
 =?us-ascii?Q?2aeN4VY+19o34BocfvEOlmeysfR7WJGU1ygePM6EWb9VGLn6qz5FtBgJ2MVm?=
 =?us-ascii?Q?0UwVomQeQEHlszPCs7yioQirTU5+qsqouzs2dCnr+dwRPll4JmnRvu0VTR6G?=
 =?us-ascii?Q?QHJXPblSV+qQrNFk79kzDQq6HKg7AZDalJjpKdxx4t4gifmW2GrIlKCfEW/d?=
 =?us-ascii?Q?ztIL0qwE1WzxRcdLWC9DhJ8Z+CxwWp6GS7NmL1yWo/T9UeDEtnJV6Ram08eK?=
 =?us-ascii?Q?O4ZssmOjDM5iEwMRn8yB0tP8GjQV/bQyR/F8WqtB3KhZoOxE57lWMCHYFXAy?=
 =?us-ascii?Q?rrc2Zg+vJFP8TKgX5i0FT9c2dNPjNabqSnkp3M+9/VXtBK2uK7ElDIMqbk8+?=
 =?us-ascii?Q?uL1qHhlCsHhKjmKwI5qJZhjx1rSTsuZM6w238MJ3p6O/XQHI4A0B12KACTCh?=
 =?us-ascii?Q?YqRqWlUtoPolxXCAEOT49kGvO83bEksmL0G+mn9vWWEZ2c+diWr+goONfBzn?=
 =?us-ascii?Q?apWUW/zcAbmsrxsB6+eDvbJPV9T3tqGnXHPaGF8zEFLGlWHnu7WbJCCP1cFE?=
 =?us-ascii?Q?wtYgr60KZ5yJ/LRmZWz4UanrTjhurVdHD5qCdtWrojG/Gf0id7BWeLFq2mLR?=
 =?us-ascii?Q?Q0FgPEaGWqPa2f0rY8EDjZNeRf0S/NJBckEFxW7Vclsga5X5kJGWzdrKF8rS?=
 =?us-ascii?Q?ie8Q/L6SlnEZosgGdPVU7NXSKQqky+9vaMBBWS7b5FZEcrxo9nA39vdzZMyB?=
 =?us-ascii?Q?268DsiNdDj3EFAI9BOrgvlEhOP5ISm/33DqWUX8CW/Y0W5w3voTx5LeTF5lV?=
 =?us-ascii?Q?5A+7bIQRtaNIkFJfjctiTFn/NtEWRTdKPwDJrI2nV8+y2QsSJ0FK0oP0ccIc?=
 =?us-ascii?Q?kzI58PNNROgQWrxx0wliAp7ZyNboYe1yPzj2swdWD1qDLDcmTse0PiraX8ah?=
 =?us-ascii?Q?o9Zc4vXDm/x/490K76o27D9S0RGvsb/j28BYgqu36s6NENz0n9FN2+qlp5aX?=
 =?us-ascii?Q?umqLThvzIs+0ahEhU+X2gu2spWt1+XzBf1txS7CGlNo26MvTz9XDtDifxU7Z?=
 =?us-ascii?Q?fKQQGTiM5t84mrEhEVinOYiUwFUsVS6nJOB8M8HtHSscxtl2d9V0m95L4GOd?=
 =?us-ascii?Q?YW53oHzkdLaUGCdQp4M4i9Lw56Qcs9bkMYhJHA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 73373275-ae45-45b2-9caf-08dc431e8191
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2024 05:29:08.1551
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR02MB7932

From: Long Li <longli@microsoft.com> Sent: Tuesday, March 12, 2024 9:51 PM
>=20
> > +void __init ms_hyperv_late_init(void)
> > +{
> > +       struct acpi_table_header *header;
> > +       acpi_status status;
> > +       u8 *randomdata;
> > +       u32 length, i;
> > +
> > +       /*
> > +        * Seed the Linux random number generator with entropy provided=
 by
> > +        * the Hyper-V host in ACPI table OEM0.  It would be nice to do=
 this
> > +        * even earlier in ms_hyperv_init_platform(), but the ACPI subs=
ystem
> > +        * isn't set up at that point. Skip if booted via EFI as generi=
c EFI
> > +        * code has already done some seeding using the EFI RNG protoco=
l.
> > +        */
> > +       if (!IS_ENABLED(CONFIG_ACPI) || efi_enabled(EFI_BOOT))
> > +               return;
> > +
> > +       status =3D acpi_get_table("OEM0", 0, &header);
> > +       if (ACPI_FAILURE(status) || !header)
> > +               return;
>=20
> Should we call acpi_put_table() if header =3D=3D 0?

No.  acpi_get_table() setting header to NULL is equivalent to
returning a failure status, per a comment in the code for
acpi_get_table().  So checking header for NULL is probably
redundant, but it doesn't hurt.

> It will also be helpful doing a
> pr_info() here so user knows that hyper-v random number is not used.

In v1 of the patch, I had such a pr_info(), but Wei Liu recommended
removing it, and I agreed it wasn't really necessary.  See the brief=20
discussion here:

https://lore.kernel.org/linux-hyperv/SN6PR02MB4157B61CA09C0DAF0BB994E1D4212=
@SN6PR02MB4157.namprd02.prod.outlook.com/

Michael



