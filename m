Return-Path: <linux-arch+bounces-3029-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3728887F358
	for <lists+linux-arch@lfdr.de>; Mon, 18 Mar 2024 23:50:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3A1B2811BB
	for <lists+linux-arch@lfdr.de>; Mon, 18 Mar 2024 22:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E815A791;
	Mon, 18 Mar 2024 22:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="AV/Zv/lY"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02olkn2103.outbound.protection.outlook.com [40.92.15.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C542D5A786;
	Mon, 18 Mar 2024 22:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.15.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710802202; cv=fail; b=std5uDRWDUzC3b9RMFna26wFW3cVjaU+L2FX+OMqpXNyMsZ/hQEu2vhvSr/9+scuyTrNaHCyAXb582b0VZmfkwKe8H6Y/tbrOrmCSC3tuEFiJRK5afWp1Kd2yH+DxOtTe+bHOgj1OPw227SHae1wUejPh4pIKHHHtOP08UKPAHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710802202; c=relaxed/simple;
	bh=i9PCq4onUtwphcMj91ITBeejLhoKsXBkr1vxkQxmjx4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=M2atgFj9L39Lm1R+6f9ECYyot2ofgPf3y6+tBo0vrpIFNufafwOzbLzt58CTkSLAgSXNCGt8hv+s5G6eGACzft1s69roSn5DJaGLGngwlaDqBGhMhB+9zs+Rv4RmDUofRDOzwAgL2TqWqc+NmxVVGw9VEVgLO4YzVJmWOapaAXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=AV/Zv/lY; arc=fail smtp.client-ip=40.92.15.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dbOgbQqnBM3v1yTmtXBBCX6bgjP6jxsc+krH9Aj3doIN2UFP11s68kR6DP1cSMW15Ko24MNeP9/31jzJq+PSw0oxr7rQrg3ikEpoGyVa0D1QgH4n6xIHaCANAgTwsEMGsC7tC2Xh3Ag75qBE5DFx7AhzjVZtfH0nJVnDr1/7dBHQ9cuF1Bu2dxNGm4MnFxDP08qe5LkteXJW3gqzmAmIoIPWcMbV3F/9A9FwiS1H86/XtL7qeGjwvfGCQUXPYv3EGsOKKaA6jsSLXT9YqEyLONKkyZlI1juBzi0z897MQEXJ7hN1nQNX2SRm4lzkf1DljidhjbOcoiqfQMLW3mCgKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=maiBQrljasbuZsLtowxm600l1PKQkjqwe9jHJubESto=;
 b=RKmil6ZfNyDq1eI/zYZFHjJ83/Q8atTqc3mxGJocZan2+7fqhHrB/3X73wy7+jroUVwdIB/be647qmcX8CLvEVwUCCSIHQ30oUuy5vokS4P9KZqND5j4VehKQJWwLOLyCVf7xLrktTjQlIsxpkmVK+AAglM8OqcQM10R+xvckc3nGuJhAON6BWGel1rujjTPAm5iDZIRjaeXnNzPgStEokeWO8Ktdt0cO2mkhORthdCIQ73R/RYB9sPHvkDROk6O3ZFABbdKh/nVqxTE8qBUxkRzzFMsuoLI7UrxuRP4+9bPPHBPJx7lUBA7jcraFddKb6DDC9zwfIWXwA2WdJ0iqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=maiBQrljasbuZsLtowxm600l1PKQkjqwe9jHJubESto=;
 b=AV/Zv/lYceeSxY7WoF/LkgjlBj9/+gL9+hF3EGUV5Fz0KUFEgnx4i5OZke+hf9L6Pl593BjJ+CEMfb92/USwR6xCY2fNDDg6/Mhpt9RRjEBJOZnd5Pikn6mCRaToY/k+E3ualtwlZ3pC//KMjM5cnkhFzT+AG/R5A68JrUetksvc0cmNADvXe3s55mfTBb/C77/vgHJZeSQGijuJA8QHVeQenXFq0bqGCNKlRvIu9vaf3ghDzm6YEyVSmz77okUnHbbO5oiVDcqRB0TWjveVt6TVqzTnJsZVW1Qa8vnrI8MS8Mn8JIaF0sAQzKMBQYikBjFF0lpy5b/LpbbaI3RoKA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DM6PR02MB6844.namprd02.prod.outlook.com (2603:10b6:5:21a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 22:49:58 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd%5]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 22:49:58 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
CC: "haiyangz@microsoft.com" <haiyangz@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "decui@microsoft.com" <decui@microsoft.com>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will@kernel.org"
	<will@kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "hpa@zytor.com"
	<hpa@zytor.com>, "arnd@arndb.de" <arnd@arndb.de>, "tytso@mit.edu"
	<tytso@mit.edu>, "x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: RE: [PATCH v3 1/1] x86/hyperv: Use Hyper-V entropy to seed guest
 random number generator
Thread-Topic: [PATCH v3 1/1] x86/hyperv: Use Hyper-V entropy to seed guest
 random number generator
Thread-Index: AQHaeUyZvwlmluIhS0+V4P/P+ldkWLE9/NGAgAAdLDA=
Date: Mon, 18 Mar 2024 22:49:58 +0000
Message-ID:
 <SN6PR02MB4157453833547D915BF3F326D42D2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240318155408.216851-1-mhklinux@outlook.com>
 <ZfisGSPX9et2hGzx@zx2c4.com>
In-Reply-To: <ZfisGSPX9et2hGzx@zx2c4.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [7DBf6Z14ITcOtsql4Wsdki4yxE9lKbUX]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DM6PR02MB6844:EE_
x-ms-office365-filtering-correlation-id: f31aa55f-b56b-4054-1929-08dc479dbcdb
x-ms-exchange-slblob-mailprops:
 7J/vb0KDx3g6a7F03Qev6DWobkb5Oxer2eYaH9yW8GEq1ETVn48NmetZM85QL/FJnByTrmhxydlUrObM7odeGRiBDak9D0Ngxea9nAXbDfjMY4Q5B3cvq1icE6EeaweJPVSI81x0Aub8IKyshePtxYhQwS/tFAmElEhkBa2k46pFgQL67JTPTH3iNwHJrrUcF+iU4N2BbVqm7WHrjxqXsmudcUJYxzt8Bm9iUEDFgrl9vpYH3QxebXIkKshuHpnW2vKFaA2T9VSR1iFqx2afUglKwhEa+D3oQ2p+IUPL8XgfWXlxxGFJLliT2sKEmesxtyM8NfE/bMy6Zk8uMLFjHO4gh1ITgTgkzLOUYEeoF4VtjQJDvdHQ/1xLnxPq61UYu+S+lhwwM6Y8Ly0PpFWK3blnlGYu583OXFPr5HGNJM/c6jJJE6tnTkNEIziJqegLgmoOYol5Nv9ouMKYW5e48z9VZ83PsKeTChwMbLkIc7t8MUN5eOn5YqY18E0EEsZuYbhFu/babmiYs/LgEpXmvdPe0Y7w1gStNtATBD0Opdv/akTe8Ql8FMQiJ0fgDqVo7cPOlaRIpizf10RkwlsBNumFMz7cFdfVpZwm1v3tVY2Jl+YotBNw9sEBxbYiaVVi1nmQRdTSCj38bCqkQkLzNdXsuxShGoO6v13SIgfEWNDUHUXGm8L5CITdkXgqRgrNkoysP4IEGQL0SI9P1vqPirwMOHWmXA1Vvluq3mnVEVvc+apEZHeIJzJPCYOkPGcrR8npMRdjBy4scPwUSvgG+5gx/REBlJgrOsrUlp4rUtA=
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 AoCqUZyeBiV+eP/bAfVoktpf/SaNvh+NBRONVaaXMi2o8oG/j3aYzM4yr8muho8YdS45OW2ADBtkMjiRLEI7Gr56aYZ6GePBj81F8b/mMnd6PZZefiv6SBvWNrdHsnhNPkz9eeMYOpsAikmINzJecNP7jzl/g4D+Fmhmbyevaoy919wp3E4wTZFvAsdkxyx/cSIzvWUdvk8vHZk4m50SK/ZmUZu2nVFqXoarlPKKXztiF/2bJWFuivw1ROw8ucxnJYURhtN9+KVIerHBAGHwqiNLLjKibLad/kPGptVfYTlwDil9V0roh7dnrKff1SAM6Pg9pLKIgciq9hgXcJVPlTxxmUOMO0TiVMU6Gmw37F++9zsbl4/AAMPxbhm2DPNn8E1Sp02tPaby+OY/0z5Cm7VZZ7X+P5lI9QoHvbp7qhmqIxK+/BI06pYFq5N/3vX8bWrCyg0MhNlTLNd2ISTvfAhvNRcdo00tNPivZP5UJ9SenlfaoghlfUu7lh/MPW903fLkSM500FweO90/U3Kx5jHS2Y6gSB8TNIYZ230IfoQFMpgI51UYC6i/EzfPl5cpDmb95EePOLnL8DtKWgn32m+KJp+E01CX4AjiwuRVtwA9ksE6UGQ9eCC/S75/++BaBUkIQtbg7IwKxJrfSvAilaA+kppKjrif43PHr11qxNQ=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?O/GQgU5oslylRLhqsvsuV+l54u523uEE5ufPK/L0odYZTEUUPQ0Ej9sAXL3A?=
 =?us-ascii?Q?FSLylDoOHjwO7KKbS5evZRWHF52iOpBljLNrnX8HCI3iTPye9qek4T2ioIpr?=
 =?us-ascii?Q?Q95+J0TWf6UKPe4yaLs4vcuX0+URw6EFOELeuBsOPfjFxMX/nddTZZPTavI5?=
 =?us-ascii?Q?UcuZwqnUmYYRt5uDLDwwB1IIMmX1gLPOXWCoYOToVUjHqO2l6cqy9IFKu4ad?=
 =?us-ascii?Q?wNf/GNk/wltEk/cpEycgRSTYygHCW+rlTWhETpadQrheFTJRsvAEKx+Iw74+?=
 =?us-ascii?Q?eHL0p9pM1yoHpbIWWpgUfEQRQLLifNUkshKWNw+AqSvLhd0B1+chXXM1q0Gw?=
 =?us-ascii?Q?D/aboRb3XvT7q6nkt5cjLNFZwwwcVubjITQoffMBplr9/5wR2tFQtbnscZwc?=
 =?us-ascii?Q?yv/eyZAxIfwEidRsRBvlDL04VcvIF9eth5QF9u45cjkXIXkTLS5K8z0CtYYL?=
 =?us-ascii?Q?N2TP2jOO6qNEcyvEDQUpQrkkhFS+BIBdaVlzbz7DG5Ihwv5SR+3X3jCGRSDs?=
 =?us-ascii?Q?wfhCArEkq8AvY3Bg9ggpo6lVgAWwkDxKkjmyCeRwvFXj2riguH3zomOiJy6X?=
 =?us-ascii?Q?BJRWlaCPDDrw95vzNmYH3ZQlAH0IFaVg8q+XxOcG44/xBpixbGTyH17ZJbUg?=
 =?us-ascii?Q?8195QOWdTUopYp699R5a7KTYYBDnZCsNaS9Z6Bihj2OIqboN5b1x3DmeQQRr?=
 =?us-ascii?Q?0HSCw/mGVQyxhEuqByZQJOr1+6bWa2IYTj2mKyLn9gHi0nB4kyvrcBWsSzw8?=
 =?us-ascii?Q?UjXb1rPBMNVbJn3ag9qDAnPBo6haNe0Udak+x3Y49Qg2CbYkEMIEm7QUoUB6?=
 =?us-ascii?Q?7T83icVrHP4APMyXf7YPxtKkgNJJcq3K4/nkxXMKT+vsvAhi7V3rqiN2mAvY?=
 =?us-ascii?Q?Xo8/iRLf0VMAEyatjPJWpym6fdbegiSNeDyRKehpJR3pJuQzW0ewqgxHfrwA?=
 =?us-ascii?Q?vumlI9MHwkLtcxl4zxlURloW8C+6ufEt2XQ3E3OxnUCvTr/t0h/Rbg5IOdfF?=
 =?us-ascii?Q?KiJdLsXpdp0+qYJrJ6Q0EweW8MAQi4Z11E4CwmmsW/VL97Fg66lOKOqS06h7?=
 =?us-ascii?Q?EaHqWZNtE7fcq1Pihu4+ZcZOrX1+GJBhFwg17atBb0rVJa+dZH+uxT97fiRl?=
 =?us-ascii?Q?MqP3tLb99/EK8sit8r4nA5khGDkxcQ89zQtAHEX2pyc9z+0wMKWq+R0Kvkyz?=
 =?us-ascii?Q?aCJ68oqrr9KQLBpClxkcmmv2r75Ifum2tqb/fw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f31aa55f-b56b-4054-1929-08dc479dbcdb
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2024 22:49:58.3559
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6844

From: Jason A. Donenfeld <Jason@zx2c4.com> Sent: Monday, March 18, 2024 2:0=
3 PM
>=20
> On Mon, Mar 18, 2024 at 08:54:08AM -0700, mhkelley58@gmail.com wrote:
> > From: Michael Kelley <mhklinux@outlook.com>
> >
> > A Hyper-V host provides its guest VMs with entropy in a custom ACPI
> > table named "OEM0".  The entropy bits are updated each time Hyper-V
> > boots the VM, and are suitable for seeding the Linux guest random
> > number generator (rng). See a brief description of OEM0 in [1].
> >
> > Generation 2 VMs on Hyper-V use UEFI to boot. Existing EFI code in
> > Linux seeds the rng with entropy bits from the EFI_RNG_PROTOCOL.
> > Via this path, the rng is seeded very early during boot with good
> > entropy. The ACPI OEM0 table provided in such VMs is an additional
> > source of entropy.
> >
> > Generation 1 VMs on Hyper-V boot from BIOS. For these VMs, Linux
> > doesn't currently get any entropy from the Hyper-V host. While this
> > is not fundamentally broken because Linux can generate its own entropy,
> > using the Hyper-V host provided entropy would get the rng off to a
> > better start and would do so earlier in the boot process.
> >
> > Improve the rng seeding for Generation 1 VMs by having Hyper-V specific
> > code in Linux take advantage of the OEM0 table to seed the rng. For
> > Generation 2 VMs, use the OEM0 table to provide additional entropy
> > beyond the EFI_RNG_PROTOCOL. Because the OEM0 table is custom to
> > Hyper-V, parse it directly in the Hyper-V code in the Linux kernel
> > and use add_bootloader_randomness() to add it to the rng. Once the
> > entropy bits are read from OEM0, zero them out in the table so
> > they don't appear in /sys/firmware/acpi/tables/OEM0 in the running
> > VM. The zero'ing is done out of an abundance of caution to avoid
> > potential security risks to the rng. Also set the OEM0 data length
> > to zero so a kexec or other subsequent use of the table won't try
> > to use the zero'ed bits.
> >
> > [1] https://download.microsoft.com/download/1/c/9/1c9813b8-089c-4fef-b2=
ad-ad80e79403ba/Whitepaper%20-%20The%20Windows%2010%20random%20number%20gen=
eration%20infrastructure.pdf=20
>=20
> Looks good to me. Assuming you've tested this and it works,

Yes, tested on both x86 and arm64.  Thanks.

Michael

>=20
>  Reviewed-by: Jason A. Donenfeld <Jason@zx2c4.com>
>=20
> Thanks for the v3.
>=20
> Jason

