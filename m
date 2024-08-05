Return-Path: <linux-arch+bounces-5960-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E9E94739F
	for <lists+linux-arch@lfdr.de>; Mon,  5 Aug 2024 05:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 789CAB20C25
	for <lists+linux-arch@lfdr.de>; Mon,  5 Aug 2024 03:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 814E013D51E;
	Mon,  5 Aug 2024 03:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="NRTAMyQj"
X-Original-To: linux-arch@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazolkn19012054.outbound.protection.outlook.com [52.103.2.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55012F50A;
	Mon,  5 Aug 2024 03:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.2.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722826989; cv=fail; b=PoqW0EXWkKSCX9Zu0S2vQW+J2ja+3UYluGpwQg65gKa5EY7FKYu/t1Bg88WqNvxCCBQaQK2FcNSwL7inR8pRmeRboaAmrqzZZRzJj0KgpJ3OuYCs8Xdw7dkxnY+wuUoKiW3FRATnYYSaL/qF2SWKoHk21mj5lPv+onJgKMInXR8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722826989; c=relaxed/simple;
	bh=ilwDXyO0LlKG0J6xlX+5eYBj+4YKbHVcOE8hXZyP+Ew=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=l1CmZQylJduDUiemK9TbNVKBVJutdaUCcGs0lj+rjnBIJZvq33X+tqgPffW4a78XjvcVROny5rVpbzbxc+HswIo6yiAx/vQJLYT8CoIyR7v8cc0dc5DyqUS28DqS40GIGJOLKS7bYVry6cIU/JxU8bp+LPULvFFcSbVoYNWYSMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=NRTAMyQj; arc=fail smtp.client-ip=52.103.2.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uOWuO3pa3rpKeGDHK3UxZipGLWcEf41jrimlqqCP932mLos7cCt/lIUCnmEet5v5dX17YO/T6sJM56b08qNBjnJCJEmJFeLoRaK+kxbhWnx7335u+Ulc6o60AWOgGEJXwKSJi8jPQvX9sQ6VhSJDhdxNHPoq5t+Az0gGfylLtydrw/UlXjoJVKUxXShL9m4+g8Cdjl6yuvThijbG5PNU2JTywowuoW8QJuL/l14O06VSBO5RB5Eg87NXpiw20NuJio0EdHUFAN/3gtmXfYXtNuxsMu2jMmEa/6G0voIn3AceMnijm9I7fAMy+0ZX8ONnUwcAQi1w5AEy47PIH8xN1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+XIyJ1RmY7Zy3JeeHYhASGTzOHZS3d2nhLMdIMcDZMM=;
 b=feZpTagLqI6yPoWfspOR4e4Z55HDiUdxCxOvM9pTh7wQPIc0WMcDZABBxiHkLehYYSt19r1WnEGDyM8ZtmfleBkdax3in8hfYhi/F0W9nafZZhsTu29Gy+QMLIivhTUEeIExh197rg/wNbRvqv4jw6NgUhL0Kzkj5/n39hSsq8bntDjKcVw5qIxLowfaEPDbP7fGLbg6ld3rIyQchvSpZ2SbfD3Jy04rybNhkBFPru0VF0Osg+jUvtKweHk0qokLv9/yrI4T4MeEkShtLodrtez1g/bSGLKrnVPzvBPwPShALZknXY/rlZUaPB5hK9zP25O3AemY/lcOlSZ0POpj5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+XIyJ1RmY7Zy3JeeHYhASGTzOHZS3d2nhLMdIMcDZMM=;
 b=NRTAMyQjHvr+Ca0J09C4NxlPCUOMKIMVrc6ZLJTrZx8Y0fJnurA7tsvvvzR2OTV7VTKe8vb46V+cZERD9qT5MfHYErryxOzEwxDtxWP2bLR+lbPgOxenTH/PNeJILwjAbGMo9STjP9+no9cOskciw67ODXWtsRiURD6sMpiVtgq5DzNTHrFWOr18xuYyuzUdI0DT3d1LiD1qr3r8Lk5HA0iGZHtaZxN9EbHoUBdV+Vwa0sAjzxelLcSpBBU5HVEKBmdyxfyms9n75uZ+EIqlW9sK8aXXSvNMiXR7Bdhm9T2E/2LRTMkzUQ8ufw5Xqar/E/9ucQ7pnSTytpLL2oPQbA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by LV3PR02MB10738.namprd02.prod.outlook.com (2603:10b6:408:28b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.25; Mon, 5 Aug
 2024 03:03:04 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%6]) with mapi id 15.20.7807.026; Mon, 5 Aug 2024
 03:03:04 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Roman Kisel <romank@linux.microsoft.com>, Arnd Bergmann <arnd@arndb.de>,
	Krzysztof Kozlowski <krzk@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, Borislav Petkov <bp@alien8.de>, Catalin Marinas
	<catalin.marinas@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>, Dexuan
 Cui <decui@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, "H. Peter
 Anvin" <hpa@zytor.com>, =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?=
	<kw@linux.com>, "K. Y. Srinivasan" <kys@microsoft.com>, Len Brown
	<lenb@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, Ingo Molnar
	<mingo@redhat.com>, "Rafael J . Wysocki" <rafael@kernel.org>, Rob Herring
	<robh@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Wei Liu
	<wei.liu@kernel.org>, Will Deacon <will@kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Linux-Arch
	<linux-arch@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>
CC: "apais@microsoft.com" <apais@microsoft.com>, "benhill@microsoft.com"
	<benhill@microsoft.com>, "ssengar@microsoft.com" <ssengar@microsoft.com>,
	"sunilmut@microsoft.com" <sunilmut@microsoft.com>, "vdso@hexbites.dev"
	<vdso@hexbites.dev>
Subject: RE: [PATCH v3 6/7] Drivers: hv: vmbus: Get the IRQ number from DT
Thread-Topic: [PATCH v3 6/7] Drivers: hv: vmbus: Get the IRQ number from DT
Thread-Index: AQHa36/Ax7vrWbxjOkqE907xHGTdubIKRlAAgAAF4QCAA6NygIAJZJYQ
Date: Mon, 5 Aug 2024 03:03:04 +0000
Message-ID:
 <SN6PR02MB41571723DB27E0A29877854ED4BE2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240726225910.1912537-1-romank@linux.microsoft.com>
 <20240726225910.1912537-7-romank@linux.microsoft.com>
 <7418bfcd-c572-4574-accc-7f2ae117529f@kernel.org>
 <ce8c1e88-2d2f-44de-bd43-c05e274c2660@app.fastmail.com>
 <dd25f792-3ea4-4660-a5cc-79b589b2b881@linux.microsoft.com>
In-Reply-To: <dd25f792-3ea4-4660-a5cc-79b589b2b881@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [L7YRdbtNl+ALCqzVj5Q1yecY/H4THnvL]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|LV3PR02MB10738:EE_
x-ms-office365-filtering-correlation-id: 85487154-fc25-4544-a84c-08dcb4fb1fa4
x-ms-exchange-slblob-mailprops:
 AZnQBsB9Xmqyyf+cGoeQ3Ulm4AiLwQwdQvjOaKpcwm25FIOkVpeOw5totQYlwy9D9VF1XNs/96VCvyoDRBCCglRTe2tWnsCShLpKAzkJiHva52IEe0sbXDcoiPBDa0ui0YE29hI3CBLXWXbLyOHdpukEgPP9FNILKake3ssMp8SD0iIOLASqjh/jfox19PgS6GBrhoe6wNUvS3D2R2NnsEOlG4xi3uwUz4K7UlFRWDh86QEgOmbvt868o+4NRYF+OWmjkDVSjyf0Emnp47S3puiHgBUNh86HUJOD86dGLoeqrA/E0fujvIJ1G7HgybXBzA7ZmpMLVRHjz2Qvt0mkMz7F6yvrC6zydmnYJb0PZWfemCY4rFVIaz81QN6HZUkoMzR47V1hHKMWy2jcLeIfSbEErdjE+G7BKM/ZIiNG20sO+W9qnFie9sFGIqCwY4R/uGnn0kU4aK4+KkU6Sc5M68YBX8Gq4CGf0CIxmkRbC2tHBVoq4jJOHUPH7PqGWU7i93CPMU1ncsaVz2pOZYy6JD8Y0kdBNvEBFsIhfn76Iy4c6FzyWx0jHmCmq3b6n+hNEw1V577Yl08dEFCVefEGHVFenAL3dLV0ghPohnix08kTkL69BS+P0X8P2dU1dHkPGHZsBr7AAjSmyeXfj+x/OxNPZWvlou1Z5AZQyoV7u0xyHxXfedvaYw8Cch36lqcWvfqx/edl+/kKgfMtT3J6nMCeed6vQcCHvvcsvm2lkaQb6wpqTn/Jl6ufUkWqE5hpAM1oE7tpeUk=
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799003|8060799006|461199028|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 2YiRxs0KPHmFCRHzAtO0txk5RVkFzg06Lr3wulIPx+SUJ5t5TvKU3x6laTU7Hp/lCVeknh37yO8Iv6RZxRp4uBGsl9HI40Zw603Him+XyrhL8IYI/8umxx0Iky/CwzqoltVIYIpgYEavdFCeiBtT1w3P840B9qZVuQDZDkciJn9i76beiVwGr1dof6DiAWlD5j29XnZa9FsM1Y3ckt7O3UVplKvYtKUUTiLYRmYqmEC2DrGdPWrWxYN6WewTfFVc3b9iGFfycKYpjz3QWxRMGSVbeqULFoV/mX3Lt+FDNORd9yeirCJ3jfH3yQ0Jn4Zhz73Cf5eXyKqJHYBj/vBtiAjakqMhj1Ut/+Pi/EO8CphPvF5u3vXFh+bCQh4YINdONswazsJYS/7wKaxvwadR5gYJquhAgTDEWLYlkDKjhr9BzN2PVDsZ8gyc9dfphC+bXJ1uMu5+Qn2fHDAN3+r65v9UjcxPThIoRAmG7qggk9WhcfDU7t9eCvJP2szfvIjWpBkl34ABZAu2DsGBOgmRgujFZBh5fzzYn+MGQpDZqMInTwoIrZxqKR5pwLp3nesIuGvESNfoHAiBe/WpJb3eFr6x9K0WCD/1kHDf5qmMYy+Rw3OPgAp97qan5GiHNqK90r6vJdMZ6tkDZBydiTZTMg==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?wYof8AD/HN6nlNbiQBv0ifVLYG+u3cf2Muxwiiuewjl+8swNY/JJmgsclB?=
 =?iso-8859-2?Q?/NDOlRhEdojrkZQv7RLwru/235jWVyyahtYb3AWsZLhi860dAjPdrULLhl?=
 =?iso-8859-2?Q?dl6fSz2FchDEEFntGbzGAF3a06a6ZKGIMcYPEXBbpWtD8GTnCBZhuMPGOe?=
 =?iso-8859-2?Q?W2IoBORQwmvhMzTsk27COBSe4QW1Chj01ZhYZ6yUQjkIR6LhUppKwnlVjD?=
 =?iso-8859-2?Q?DETzvAgIuR9JnOAcwoSfW6vE+baXCjtSFll00ewhewu1VuakUlloHpb2RJ?=
 =?iso-8859-2?Q?gl2WpbEOETAXPwr7oX0WQSXYbb5Lbj6FO1WX05RPHQ7uJKU3CdB/CDvaQK?=
 =?iso-8859-2?Q?UeG4k072w1s4SEtvINw8/cGk4h0nypsfWsa43gdqa92Wug8h4w3MPGnwXi?=
 =?iso-8859-2?Q?fe9DXahWqr8j6B/Y96ZakkCmFFlMultj/l55cs12LQVjfNcFsPMzViNJ4b?=
 =?iso-8859-2?Q?Yph/FCk4RJ1VegIXOE7Xl0/H5GTdS/1VrAK2pXDMuvBqXEyhCMCHx7k+9D?=
 =?iso-8859-2?Q?AVy2xNggu3DOq5eLKxDrm8vq79kvgPODDJ+YBdd/dw3VmFw8xd/cbBIf+o?=
 =?iso-8859-2?Q?w7ZctCRBnHm69RN+gouXCUd7zBCeFRNNpFmzvb1jaT9wO/mCjtiuoyl1A2?=
 =?iso-8859-2?Q?WHNwPfj3nwBQUTx25RB45/pmBeWubxWqfoqzy3Hbg5RxgcuwITU44r94aM?=
 =?iso-8859-2?Q?UMgAzOD1DMsVNoTrkPFeeTsJSjpvUKiIq56TE8khMqNhYsaq0ZczyA932o?=
 =?iso-8859-2?Q?64y/oYuNRpzg4Wac9Ute7jJovwU02iwBsmlCtiY7q502NZLRR698oGmSv1?=
 =?iso-8859-2?Q?Dhg8EcYBjnoUQepmZaGPmtb51s2SyIk29/cE+LWw3xv/DSEz3vMDDrtCRT?=
 =?iso-8859-2?Q?FsBE5UCOvPmUxIdTELAUx3jUJzRCHzPxohc+VPPa2u9yX0MvGYP5Y3KNsv?=
 =?iso-8859-2?Q?zPuk8O3IKzbgD0JyMxeHbbNqDUWS7kf6zajFsom1ITHp5gKg1RnTHfZksX?=
 =?iso-8859-2?Q?hwkbaMn6t9gtE6VpNar6GAGwVYGV5LzacwY4+itE/t0IuqaK8zbbuCI/r2?=
 =?iso-8859-2?Q?HPa8l2kcAOCECvjqcKhw3AWESEZuaSz9MjR5az/t2NGoRLazaRQftA/pxu?=
 =?iso-8859-2?Q?P1n1QnoHK89oLAhXDEEpZ9zdvegypt+3J7BTvAK0OTVFtYAg4fZ3rkcQAQ?=
 =?iso-8859-2?Q?GRRCUg3MZA9prBPaBZgvh5Mquuy0x/GfA+egbtZdRNT7eqy0li6mMwnHvU?=
 =?iso-8859-2?Q?jzGg241Kl8yhkBALQwEQjZ/7K46BmcJ0DqpOSjK04=3D?=
Content-Type: text/plain; charset="iso-8859-2"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 85487154-fc25-4544-a84c-08dcb4fb1fa4
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2024 03:03:04.0176
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR02MB10738

From: Roman Kisel <romank@linux.microsoft.com> Sent: Monday, July 29, 2024 =
9:51 AM
>=20
>=20
> On 7/27/2024 2:17 AM, Arnd Bergmann wrote:
> > On Sat, Jul 27, 2024, at 10:56, Krzysztof Kozlowski wrote:
> >> On 27/07/2024 00:59, Roman Kisel wrote:
> >>> @@ -2338,6 +2372,21 @@ static int vmbus_device_add(struct platform_de=
vice *pdev)
> >>>   		cur_res =3D &res->sibling;
> >>>   	}
> >>>
> >>> +	/*
> >>> +	 * Hyper-V always assumes DMA cache coherency, and the DMA subsyste=
m
> >>> +	 * might default to 'not coherent' on some architectures.
> >>> +	 * Avoid high-cost cache coherency maintenance done by the CPU.
> >>> +	 */
> >>> +#if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE) || \
> >>> +	defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU) || \
> >>> +	defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL)
> >>> +
> >>> +	if (!of_property_read_bool(np, "dma-coherent"))
> >>> +		pr_warn("Assuming cache coherent DMA transactions, no 'dma-coheren=
t' node supplied\n");
> >>
> >> Why do you need this property at all, if it is allways dma-coherent? A=
re
> >> you supporting dma-noncoherent somewhere?
> >
> > It's just a sanity check that the DT is well-formed.

In my view, this chunk of code can be dropped entirely. The guest
should believe what the Hyper-V host tells it via DT, and that includes
operating in non-coherent mode. There might be some future case
where non-coherent DMA is correct. In such a case, we don't want to
have to come back and remove an overly aggressive sanity test from
Linux kernel code.

As Arnd noted, the dma-coherent (or dma-noncoherent) property should
be interpreted and applied to the device by common code. If that's not
working for some reason in this case, we should investigate why not.

Note that the ACPI code for VMBus does the same thing -- it believes and
uses whatever the _CCA property says. The exception is that there
are deployed version of Hyper-V that don't set _CCA at all, contrary to the
ACPI spec. So there's a hack in vmbus_acpi_add() to work around this case
and force coherent_dma. But that's the only place where the current
Hyper-V assumption of coherence comes into play. I sincerely hope Hyper-V
ensures that the DT correctly includes dma-coherent from the start, and
that we don't have to replicate the hack on the DT side.

Michael

> >
> > Since the dma-coherent property is interpreted by common code, it's
> > not up to hv to change the default for the platform. I'm not sure
> > if the presence of CONFIG_ARCH_HAS_SYNC_DMA_* options is the correct
> > check to determine that an architecture defaults to noncoherent
> > though, as the function may be needed to do something else.
> I used the ifdef as the dma_coherent field is declared under these macros=
:
>=20
> #if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE) || \
> 	defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU) || \
> 	defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL)
> extern bool dma_default_coherent;
> static inline bool dev_is_dma_coherent(struct device *dev)
> {
> 	return dev->dma_coherent;
> }
> #else
> #define dma_default_coherent true
>=20
> static inline bool dev_is_dma_coherent(struct device *dev)
> {
> 	return true;
> }
>=20
> i.e., there is no API to set dma_coherent. As I see it, the options
> are either warn the user if they forgot to add `dma-coherent`
>=20
> if (!dev_is_dma_coherent(dev)) pr_warn("add dma-coherent to be faster\n")=
,
>=20
> or warn and force the flag to true. Maybe just warn
> the user I think now... The code will be cleaner (no need to emulate
> a-would-be set_dma_coherent) , and the user will
> know how to make the system perform at its best.
>=20
> Appreciate sharing the reservations about that piece!
>=20
> >
> > The global "dma_default_coherent' may be a better thing to check
> > for. This is e.g. set on powerpc64, riscv and on specific mips
> > platforms, but it's never set on arm64 as far as I can tell.
> >
> >       Arnd
>=20
> --
> Thank you,
> Roman
>=20


