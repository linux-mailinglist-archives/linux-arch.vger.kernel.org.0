Return-Path: <linux-arch+bounces-2840-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F692873DA6
	for <lists+linux-arch@lfdr.de>; Wed,  6 Mar 2024 18:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C918281A42
	for <lists+linux-arch@lfdr.de>; Wed,  6 Mar 2024 17:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58696137935;
	Wed,  6 Mar 2024 17:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="OHqTf0AT"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11olkn2028.outbound.protection.outlook.com [40.92.18.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7366E80601;
	Wed,  6 Mar 2024 17:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.18.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709747026; cv=fail; b=jjkdI9InPZjjaaD5P0N0XV+2z0rczQS78Vu+pS1CFf+qYpuaCBqaq62AdlyXPL3kLkmzvrKjidoY3FnNEOq2qo5LjQrLXMUC3hItxkUB1eFCQ95RQ1MogFo0fJJEoHRMZTs1bNo4k55AeMxIozPCc4ENzN7aiazPFmO5tiCXSSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709747026; c=relaxed/simple;
	bh=r0nc4VmAd1GgMbV+9XAHwToToGG9k56Gg7fl3V0X4e8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XV+W7J9FF/6zuOWsvRi4Qk+dr4nH5/GOez8bsQ0Rzc27JClhmIkHwUVnxkyACXo9uqWRePRvmCaUzCB/gAdTksM2tBav/NoUBwrK47y+67RylDBtgxWjpu4l8ucESiF/7UT++0GRQUjsO42zYa3rC+kq2RUN3s4vYNDdWniSm0Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=OHqTf0AT; arc=fail smtp.client-ip=40.92.18.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g/aS9N+Z8O37ca5A/A1l214YIBq2NFnhz9L29eRNPWdk8fqP4Y+pMkP2HQSVqZx7lA1bSs7l/YRPyM/ljw8FezQI4gqxZEo+5ArLVzCRr5Wfg4lAeFmvuj63nCO9PNyruHrrOVbZKvYelhaK1gOlzXy15AO7HmsQJkpp4FrXn3kVINQCo4hwgWxIQEs47/JC7Ha+cJpqJBE08Ld2uXD2rDMEF31F4NNhf5ULnwyViQ/n2sEsq40uY27X/4Wb+YKyOXtrGce9UsIaeqCpaIMWgAKI9undGRec5Znu6brx8FCD2Ya+3/k1GtyYLLm4M2MDtY5rCRoRH5g75xT1xXqBOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VBQynf+cv/c992G73fUo+kv1Z//vQ9oKlM9bdkVPFh4=;
 b=aW8JZ+qryRwqlbH6y5QcFzGu5X4A0ofuF6ix8X+mLsc51hZExGrVzlPMXo9siyC4TcVnPxcCRbyKUpl6m4jyVcIbhff/YJISCylmxtFi5oVjHlTKBnPmJxxznI1L0e8EMBTZgeoTLo28Ky4dikyuyVihctQ53xr1oj7LLjFugV4ms3yojCMOq3i+f5qZfhIpkpMUFf9M1pZo81MmYJtblch1i8DxGNLC6s5PKi+E/DzRktb/I4dpzLahErTtC6/xqXODD6PboeA18ZrRZEjL6NFA5n9vImsqRi+CTDb6SDB/WqxELpmxXFcNNJClbQP/CIQ2WduFOjhZwSznAEhSww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VBQynf+cv/c992G73fUo+kv1Z//vQ9oKlM9bdkVPFh4=;
 b=OHqTf0AT3LG6FTpeiCkOB0X5JGxFmqbwDHMgK9hxpFjSKRYyi/4hSv7SC1QMBh1j+jkXPa5nLtYB05prViJ1/+zsYL+UhuKU8QChwlyM0NbPGcrdfxw9l8tSXed5M3S02KR9Xse02YhvCEuauWH0CA22mqsCoNvAi4IU81s29z+iHhWPFAbGdQZN3M+36wtEpP2hIb2fwvGCYtq1wwAPvq6cAt6itsbNS25PETyy4N/+jHYfdmguikAsAyBH6a32jwlKyd/LUTJHUWvUOx0DOOG+MPOEuju4X8l4pL8kFM6Os31gfL0TTbylFCjZ/vX0C6SUArxj6SNEhZC089CQAg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CH2PR02MB6537.namprd02.prod.outlook.com (2603:10b6:610:69::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Wed, 6 Mar
 2024 17:43:42 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd%5]) with mapi id 15.20.7339.035; Wed, 6 Mar 2024
 17:43:42 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: "wei.liu@kernel.org" <wei.liu@kernel.org>
CC: "haiyangz@microsoft.com" <haiyangz@microsoft.com>, "decui@microsoft.com"
	<decui@microsoft.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "hpa@zytor.com"
	<hpa@zytor.com>, "arnd@arndb.de" <arnd@arndb.de>, "tytso@mit.edu"
	<tytso@mit.edu>, "Jason@zx2c4.com" <Jason@zx2c4.com>, "x86@kernel.org"
	<x86@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, Saurabh Singh Sengar <ssengar@microsoft.com>,
	Long Li <longli@microsoft.com>
Subject: RE: [PATCH 1/1] x86/hyperv: Use Hyper-V entropy to seed guest random
 number generator
Thread-Topic: [PATCH 1/1] x86/hyperv: Use Hyper-V entropy to seed guest random
 number generator
Thread-Index: AQHaTVXupwvTPY5m0kOclayMSeGBz7ErP/XA
Date: Wed, 6 Mar 2024 17:43:41 +0000
Message-ID:
 <SN6PR02MB4157B61CA09C0DAF0BB994E1D4212@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240122160003.348521-1-mhklinux@outlook.com>
In-Reply-To: <20240122160003.348521-1-mhklinux@outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [fYpzzOH95P8VQZ1G+RxN64cqInnGNBfy]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CH2PR02MB6537:EE_
x-ms-office365-filtering-correlation-id: b4d9355c-f76f-4842-1ade-08dc3e04f6ae
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 AIvIwGepn0O54SAZ30wuVeZ3eVmia753Jp1AUWx7hLRAg0HZ36i8hVZGEC27Z585Sit6l9Ty3CboNpLj6ZTq5ykrg3cZHPBM09lR58Ni85gu5GTvuuSlh789TWBuBnXrGK1NI7vRcIgKozbrHE2wxuuqHD6M2DSXY+TTxCkQDPYsrK7dzegoViVt5oGG83uHGLUvREuC+yrPfvmYIHDZ5IPO0vCSjaKfj92v5ZvEPMUniGk8ia9XIpBdKo5aXabZBZ556mCj2gqGyBYDH1Jt3PLvzSG2wTzk3ny+i+DOSwqwbFiY9Lim/vgjEPNBZ5SY088xKYJ+iDmA6joP9NUHThhlgMpo2Xfw92a1gx7chSOZYsR1bD5unTTn3UF7MpG1G0Os30YuBZhFqagbFfbeNmHZxXn1pxLuiZaOpzfgt1Z/YX5+aJs6nI46zNxra+GSz64hGhKKRfN2Ni6f1AAW2jekBtO11dDy1zSdRdeqf3akrdCUbOmYFK1ZXEFZS0YPtnsBLvgmutEmiYHhK+EARA3gOF+CdcVxJl+SfbvwqNYVyMpZNaJacd24o4QDCMgH
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?oXyKs/TTzwlGr+UzVueZsbNZWsFgtLjqUIGfiO75AdrxT72ciJS93OrG+ZHW?=
 =?us-ascii?Q?n7+VmcsmtxJejjgFFHEUxlP+VcY47zcSlQqCA1WOh14AJXsyYdNDD0boBwZw?=
 =?us-ascii?Q?qvbO1FKL58nhsbsDD+fB/vBytQ+sP14eqFf27smV4gJUlZ0zm6fkDl8GyJ6Z?=
 =?us-ascii?Q?s/A6Nt2wuLDoYjAsoeiwM/fzsRF3qNcCASF95Qzq4RgNccxeSmMN/ID/t/kH?=
 =?us-ascii?Q?pEWg3GYoLcer6e06MSqml5GuubOZmDv8gZq4gvTm8QXNkZXIe+7HkF9AlNnP?=
 =?us-ascii?Q?mU737zF6MDrZgnMQEnbZJwObXwjl4xLqcU/dtTm4lcLYC08gXGu+xGeKaEWh?=
 =?us-ascii?Q?GXusU4Wh+bar/Z6b2hnpFkf2ShtHaV01xuCt0F2Tf5YAK71VraIFn9nY93mu?=
 =?us-ascii?Q?1HTcW7u9kYa9sJJEIeTe8NF/uXkzbXUYmfYeWG0EY/PqU8wxG/SGLwKHx3qW?=
 =?us-ascii?Q?ht+jwGH2sHFQZVdp0jcExRP46EVaHlP2IVfuYynBTDOwvr37GxMldI6RriXp?=
 =?us-ascii?Q?p+FO+fZRtL6EhQo9WWTNaXBDGzz7o9sUogwEd6f28RTL1fBUfeaGvBkXwNdK?=
 =?us-ascii?Q?pq2If1+6Hljf2MotF5KRTm99trSAl7x7fo2wfOMeqfKxOj2SfwkL71S9ltLT?=
 =?us-ascii?Q?/G+22sjkG6IMX/Z9Ri94350Z6GygtEDVVtS2PIH/OCD/mInf6ZaCH1NzV/y9?=
 =?us-ascii?Q?zf91d3Tg8dygPMr7+Y3JYSpGnqZeOuUOWhAwLJfJsnxlxgLEKsH9VF39ld/g?=
 =?us-ascii?Q?lk1rz4PLEZPZkzpVRmLyPCR7q/7YqwYPo9nBBjyvyBwPmpyslsuAlkNZ6avr?=
 =?us-ascii?Q?+pK2EgZL6l9v5T+3miUOR5bi1gl8R09HGuxGrYp2N7VIYc/TJB2MBxbSKWbn?=
 =?us-ascii?Q?64SV5PtaK89i9Db2GZu2GuKocvsOYJvEG59rMd02/rRX9Q+/SPjwPEJx3VUR?=
 =?us-ascii?Q?4aowzqnBXNqzysdKgfp0PUvJ+y3L2kQlTuydNX/s2WeZauBu1ypUCdr9tUSq?=
 =?us-ascii?Q?hFXoqfM2m0MzTYGt6G//aBL5tLtFvC2o0TaNSBtjpvFJU3IAZjROaPxTAx/Z?=
 =?us-ascii?Q?Sjf2dQC3qSj0FVZegW2sAMYjJaVJ2bFaXJyBJY91uMJcvtFOEYHGvB67lnio?=
 =?us-ascii?Q?Tm+pZxUJdJZihOlVn8gNbmR9U8UIy5bM1D4fWdvZXQ8v1cRc5nwe+0L81ywU?=
 =?us-ascii?Q?8Tsts3foKY31hajsyiANFlPX6VcKPU0S9xIJ2w=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b4d9355c-f76f-4842-1ade-08dc3e04f6ae
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2024 17:43:41.8760
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6537

From: wei.liu@kernel.org @ 2024-03-04  6:57 UTC
>=20
> > +void __init ms_hyperv_late_init(void)
> > +{
> > +	struct acpi_table_header *header;
> > +	acpi_status status;
> > +	u8 *randomdata;
> > +	u32 length, i;
> > +
> > +	/*
> > +	 * Seed the Linux random number generator with entropy provided by
> > +	 * the Hyper-V host in ACPI table OEM0.  It would be nice to do this
> > +	 * even earlier in ms_hyperv_init_platform(), but the ACPI subsystem
> > +	 * isn't set up at that point. Skip if booted via EFI as generic EFI
> > +	 * code has already done some seeding using the EFI RNG protocol.
> > +	 */
> > +	if (!IS_ENABLED(CONFIG_ACPI) || efi_enabled(EFI_BOOT))
> > +		return;
> > +
> > +	status =3D acpi_get_table("OEM0", 0, &header);
> > +	if (ACPI_FAILURE(status) || !header) {
> > +		pr_info("Hyper-V: ACPI table OEM0 not found\n");
>=20
> I would like this to be a pr_debug() instead of pr_info(), considering
> using the negative case may cause users to think not having this table
> can be problematic.
>=20
> Alternatively, we can remove this message here, and then ...
>=20
> > +		return;
> > +	}
> > +
>=20
> ... add a pr_debug() here to indicate that the table was found.
>=20
> 	pr_info("Hyper-V: Seeding randomness with data from ACPI table OEM0\n");

You wrote the code as "pr_info()" but your comment suggests "pr_debug()".
I'm assuming pr_debug() is better because we don't really need any output
on success or failure. If trying to debug something related to the rng,
even with no explicit output it's relatively easy to tell whether a Gen1 VM
picked up any entropy from the OEM0 table.  When it does, this dmesg
line will appear much earlier than when it does not.

[    0.000000] random: crng init done

I'll spin a v2 with this tweak and your wording comment on the
commit message.

Michael

>=20
> Dexuan, Saurabh, Haiyang and Long, can you give an ack or nack to this
> patch and help test it?
>=20
> Thanks,
> Wei.

