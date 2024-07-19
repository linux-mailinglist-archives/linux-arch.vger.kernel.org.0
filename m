Return-Path: <linux-arch+bounces-5527-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27CE0937A49
	for <lists+linux-arch@lfdr.de>; Fri, 19 Jul 2024 18:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3F012828C6
	for <lists+linux-arch@lfdr.de>; Fri, 19 Jul 2024 16:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B29145B28;
	Fri, 19 Jul 2024 16:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YNkw7H2d"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C175D1448E0;
	Fri, 19 Jul 2024 16:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721405003; cv=fail; b=T8yAB7cCR+0qIaGXpcT+53H6F5cA8ic7WPJNvCfWehnuvJ3S0fEPTSOvFycOIrv0R0fXa3XwFVMHteZaI+/NyYHUDpUwl3YVsvyAW/C/zVmkP7KFce4Lm7Vk4DimDZUdyFrmXcK9GWyqSvuGM8qOWDb2dK7+6RuUq9K3xB6EQyg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721405003; c=relaxed/simple;
	bh=0PsyD+FOIrHoVuD/Utx1fscgLCRA1PE0wQFQOn3025Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OgWGRb4lo1YX0gCRdT/AhFSH4t5H9f/Y95AhG4QrVKftDUrCNMeNfr+FfBl+L5Tn6NcilgSOA1XLW17zqmSXc0rG7G9Z2B/5iX5qvyqSLVeSEaHCZ+hb78mVQyq+4gJIqsjOQCgt5MABBt5MnK1AK0G6aIOWKX0gv/X1rMNgJRk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YNkw7H2d; arc=fail smtp.client-ip=40.107.243.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CmO38kmC0VP29ehLZuswpLUaZGzq0c+7ximej0US1P1/tGvvH3ONGk1rhEcWifffiNjFd1LDfG+M4YX1QNT5QeDsbBFTPLnvMyQ9oVdXIHZjKeCV2G8jHyWHpAla2F8vuUlwCXTlulJ21wIbTsOjDvOBn1HO7kBh3Ib2WMYpJHFUDoH2ouWojiCYcCykTXOXa0tc7wghSh2O3WNC5mRcwS0ImmFHoTdBEu8NL6YXL0uUpt0JhF3OvDB17GtO96b/36ZnoHBSwmwJblKTqQApX5e/9UPqef8KRHcRafvIZCsG3ak9rVdMW6onMYD4m9ULdlAr49pfNlKwpT/Kbn6MWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pj8Tfi1qsQfE2s7nk7pGKy/bvcD+YBt4ocjuB/Ev0sE=;
 b=JkOZCvGDFX+lENckt2FxbAlExggbNaBfTa/ERp7e0+g23FFvuMtut66TCFFX6LNzTMPZqYUqJidMWVtk0XAEiOv6eViusnLYMkAv/KeNnYIkK4do960ZFOot3y0ci9lY+kHp+GaxJcfzGubFBCKi1zlnrezNLAXUVv/OeEX3UalZMV3MP7fdxskjHga8ABZ37hRV207hTAdDuv/gsx6PuneZxGp9MZnMgU85d8VCcQp3MJCXAOHghdkklcnDvENwqHUmS7iU8Ww84Brdr5RjGxalZnbdNqdL+QEC+JF0jag2Joe7wQhmO0djVr4HktAKTekv1mAR0k1W7idhDgx7og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pj8Tfi1qsQfE2s7nk7pGKy/bvcD+YBt4ocjuB/Ev0sE=;
 b=YNkw7H2dskQYhvcwcNNYh9gqoGRmu/x5/l29g+s/em7/rNaFbDxmfAdPz/U0dgQlblxX39oH84mH/7c+mxgUiwWkXaILnlRj6hPA0/4iT5oNLj62Co5esSEt7rX0WwW3nkxVokHMz3cP+UpBUYXOOXp0zvhRUR0eNvLCwl3xp32gdoU855WglIu9F8TDy+/SL7I5m9IlXI9SpPlavlRr1NSUG7aL0YebXTxjnILiqxFgTLvr+9YVdLx/OTjMF5pr9kQcoQlDsZaC+3m66GngIuw2LcoRfQOqdWkc/zMgreHJMsUpAVMSmFJ+bHCG/EQCwUrQCkfvYZztcA1h08SjGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 SJ1PR12MB6340.namprd12.prod.outlook.com (2603:10b6:a03:453::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Fri, 19 Jul
 2024 16:03:16 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e%4]) with mapi id 15.20.7784.013; Fri, 19 Jul 2024
 16:03:16 +0000
From: Zi Yan <ziy@nvidia.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: linux-kernel@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>,
 Andreas Larsson <andreas@gaisler.com>,
 Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>,
 Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Dan Williams <dan.j.williams@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 David Hildenbrand <david@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Heiko Carstens <hca@linux.ibm.com>, Huacai Chen <chenhuacai@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Palmer Dabbelt <palmer@dabbelt.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Thomas Gleixner <tglx@linutronix.de>, Vasily Gorbik <gor@linux.ibm.com>,
 Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
 loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev,
 devicetree@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org,
 x86@kernel.org
Subject: Re: [PATCH 14/17] mm: introduce numa_emulation
Date: Fri, 19 Jul 2024 12:03:11 -0400
X-Mailer: MailMate (1.14r6052)
Message-ID: <CCB95DEB-6B72-4175-A379-7E60D89114A6@nvidia.com>
In-Reply-To: <20240716111346.3676969-15-rppt@kernel.org>
References: <20240716111346.3676969-1-rppt@kernel.org>
 <20240716111346.3676969-15-rppt@kernel.org>
Content-Type: multipart/signed;
 boundary="=_MailMate_A3182494-4164-4931-ACA1-7DD7B64C4C42_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR12CA0030.namprd12.prod.outlook.com
 (2603:10b6:208:a8::43) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|SJ1PR12MB6340:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f78939d-8c21-4df9-dec8-08dca80c4cd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6DRunIAbaZV9AGBeHTaC8EUzAU2cLSczdw8wZEJVsgINqH9mtQQhR1LomMz2?=
 =?us-ascii?Q?4qnwrFegbF66cN/GUkHjkyMjjzrkCxcfiZECaG7MPo2VWItgkNJ91d9nwUMD?=
 =?us-ascii?Q?mxUf3SI2wGoYWPdr/aoiwjpMhYkmR3a6eZSxS2FGBa6TVd0DmbhKXZXcOP8y?=
 =?us-ascii?Q?GTMDEF6ebXpfLooVBu6G0OAU/8Od2zPfTD1yrsnw/48dTXduj/49Tp0wCU2j?=
 =?us-ascii?Q?etg+l3iYcZFA9z4IGZ8XuTHgae5FjA/njS8YtV54WGUyjKZNSnefEvV1rCMo?=
 =?us-ascii?Q?Yme0guiZyaMSpze7dYI2bEEoauPVJwQ24w7aMq2DAoEghoK8+KcksBH0R4gF?=
 =?us-ascii?Q?CKoIO7NBhkA8NflmiWV7Eb6VxC4+rvhmtPv6tjlfa9UMURk6Jq5qD4ky8fks?=
 =?us-ascii?Q?Mu1efGlm/2OeusS0Iay6KFoFQ3cdMpAbv//cEiRWK2NGUM3ZnQQoVoDOz48l?=
 =?us-ascii?Q?SMuF6MlAjDHG6io1rCXW0uS11KIAP/cgAnkyGT5MeSDenWPKu5EKjJhDtBSY?=
 =?us-ascii?Q?+KOP0+vt6gDVgxk5aA58Ide5k2TS6Pzvcyfg8bXpMUONFdxLm7U+N3Y4//DT?=
 =?us-ascii?Q?Na/sp4rt2Hsw67Gl+PXI10rc/pu5s872Qu8aJ5/YRBgIAH6ZxOswxvS63rTt?=
 =?us-ascii?Q?Y4Zr9j2gTwQxYk8fkQk9SiU3QlN5VXzTatTGLNjI6J1/JGjKwKfoqqYfjW2e?=
 =?us-ascii?Q?4GQMuoW86yq9pcff5L7NyI4TxRa/4Z+b0NRMt8BQXX6qfTAlKcLFNqIp8R4x?=
 =?us-ascii?Q?cpdotoOYbr1wX299ObaPDZei/FQI7Din2f5Nbn2l4fZYETFNeoL0Ple0m2Zo?=
 =?us-ascii?Q?OuhOxp9QrptkKSH+f+yCaLN+HYCf764JgkFdWvs8m+hGH2rXNOH1yo6C16Fb?=
 =?us-ascii?Q?+2Lnhm7rZ74oyAJRrYZae/B+qRRudYcfNIE42p3EUOQa4BGMsDH2DSGwZUyJ?=
 =?us-ascii?Q?1iznm9rah0OF7nios9+q0MvxUgCsmEzqAjAEbqi06DlfAfB3ANHkmtT6lgnS?=
 =?us-ascii?Q?rX3L4btOt1x1axGRbm9KszWFvj9XJBW6V3pV3Rjg3vxnTLCIDjVpcp+Sk12l?=
 =?us-ascii?Q?+NPk52PxQoQsXQfe8egjSbL5HmGQvCfBT+Jh9da3PEYDFMF0KE3iLavcWe3/?=
 =?us-ascii?Q?IARexQ2HN6o10Tiu5FDdGAoh6jHqyTcDDQEsh6ukf3EMxi+eFfdyEY7iYIKN?=
 =?us-ascii?Q?RzK5LWn7dTW/skWTc6M9GAm8AiAApHSkwe2sUngmFR50L6BZbQelQdz6MJ4f?=
 =?us-ascii?Q?A5yv4JpLaSGiJHfwNDdgNEWZVanTWMv5/nvEAxbH82w2OrFDeQHc4/5rNZ5y?=
 =?us-ascii?Q?tLV2d73/X81nxuAxW8QoyHfi+vGh2bBh5HSBwX1/mCjmmg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+zBv+fW43rr3gpqQvKeiCdmJKCD8ZQd+NNGV2td7sWy5VnWVUkTgxNtBMYn/?=
 =?us-ascii?Q?yuzWSmGZAswk0fXLGUWl3u2eJdINNXLqJfc306IVh9airU1IjCPJhRKW2MCv?=
 =?us-ascii?Q?x4Be5EB9hdogHwSwlQ5hlsvGdul2Yn3yw+SRS5GyKaik5dOWDpVdmmgwWQzC?=
 =?us-ascii?Q?zAXUgsihDXLzavLyUGVUe/FUuic8th4Ffoelia/pcyKN2rBtUuv7mp4VNebj?=
 =?us-ascii?Q?gfPM1yhTI3vF4+ThfR4p5cg6qKX8DsuWSJoN062xx9hAFuUMja05fLR8Lw01?=
 =?us-ascii?Q?M4435WAR11W8GSS2Xf26FeCNzYwtXQB+8+MB9AVXx+39VJkFvLNsiDJrgW0G?=
 =?us-ascii?Q?3A4jmjECbx3YGpUVAUl59mhyeknD4c+Dsz0X0fPTOhlcEQ2jkLy40+3J0hJ/?=
 =?us-ascii?Q?Tn/hycXs/eswEJ/nuWTUNgnByRosa3BejkDeHw2NC6rQIvrcZQNdjrQYAFSZ?=
 =?us-ascii?Q?hkJQXbmdc34XL+Ic7CPNC4UaHbMAV+36HzC+BipYRePO9ap2phzZNt5a4ALZ?=
 =?us-ascii?Q?N30WpQoV+ivYlsmSB4E8aG5fhFo6TUZpTv11VDmPl0CUkby/J0EGPziYfXcx?=
 =?us-ascii?Q?gLvAmB9xenK+hHBsT7nRPSf4HzLFxJAKmb+FdnFvKTZHaELvQzNI3l4Cmsuk?=
 =?us-ascii?Q?wNFKmMd1+VrBenuBpsrolumpx222y85ayly7lyFyRhro5cNnAfvQJ46sSQCY?=
 =?us-ascii?Q?X6HawQ5W/uAxycQ3YRaa9RaaPtIjofjofTbnjhrGb4WlEhr7e3qT/qHuLeVl?=
 =?us-ascii?Q?Lhv5J+Lg/UlmjHUkCMAL9EyoZlQS+kVA4iLCsi/k2mnQUVjS+jo7mJEciHoP?=
 =?us-ascii?Q?NZZr0SEaUIognZP17AXrgSE5Q4MTEk26MoG0yBQhbgv5SqGBpfBo6ne4OMFa?=
 =?us-ascii?Q?iU8pBthjmGjXF+R/dx2gADV6dFqCsOpU4aK5qmU7neYYoboVYkwaqt0NIjI/?=
 =?us-ascii?Q?V/GlBsIc3hG0AipFCfRG0QdPZTKV5c3LbhDyMdEbnZTnERyCYV7YYNUFo2On?=
 =?us-ascii?Q?mgpFBH2EdDn4ljIsvtXAEX/FlvbstIjdUMev0mnBOPO6tDkcIunKhDzj3P88?=
 =?us-ascii?Q?bVC/3LyfCv7XwvDYNjGhmS+aYTskGNK/13RKXb24mdHdqxD6ZHAnqqI2wNCF?=
 =?us-ascii?Q?g8JEr4C6PlavSlkOfBN0wDeV1vTj+8EfBWMen+3DYFVQ7+Q9kcMD3OcxBdDM?=
 =?us-ascii?Q?5b7a4r3A2/7R3Kf7u3pLlNTFjd/MJcis/gPt/CL25WhsBQ1Gvf1FXUeRUWjf?=
 =?us-ascii?Q?K1t97SydKVjLDXktKUBV8eecbQmCZdCEcfxnvbV/QhvCwrhd6DJL2aABdKDr?=
 =?us-ascii?Q?EJUsmJV9VHovWqUYNWb0mBdx0hJl7xNrUB02/fQ1lsR2/uLTFoJyySu+mEOG?=
 =?us-ascii?Q?RMTF1cmtfEjyjyJ1DC7RBOlm0TGqiZCcFecrHQBlcHWExlcXTw1fbHPss5EB?=
 =?us-ascii?Q?WyWEUlcEp4rjnrLTpkZyVw7LVAJ9YIe6TmR4Pmgx8hwMNYCw2aOR9YLy7fuS?=
 =?us-ascii?Q?kYiZmjMXP2FCXNSg8vFFky256m0Gcq+t3tx7FaNW3UI5/vdITsFSRUOmlaKG?=
 =?us-ascii?Q?8d3rmESBE88BBrIFS4vLBAfo4ntDXj6tQMk+yWc/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f78939d-8c21-4df9-dec8-08dca80c4cd4
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 16:03:16.3701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FCoIhUaRG1Gz+Ti8mz4S2fhVSH5CuhcGoMGS2rGNxOwoTY9jFsHG3pjRsv3Mgcrr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6340

--=_MailMate_A3182494-4164-4931-ACA1-7DD7B64C4C42_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 16 Jul 2024, at 7:13, Mike Rapoport wrote:

> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>
> Move numa_emulation codfrom arch/x86 to mm/numa_emulation.c
>
> This code will be later reused by arch_numa.
>
> No functional changes.
>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  arch/x86/Kconfig             |  8 --------
>  arch/x86/include/asm/numa.h  | 12 ------------
>  arch/x86/mm/Makefile         |  1 -
>  arch/x86/mm/numa_internal.h  | 11 -----------
>  include/linux/numa_memblks.h | 17 +++++++++++++++++
>  mm/Kconfig                   |  8 ++++++++
>  mm/Makefile                  |  1 +
>  mm/numa_emulation.c          |  4 +---
>  8 files changed, 27 insertions(+), 35 deletions(-)

After this code move, the document of numa=3Dfake=3D should be moved from=

Documentation/arch/x86/x86_64/boot-options.rst to
Documentation/admin-guide/kernel-parameters.txt
too.

Something like:

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentat=
ion/admin-guide/kernel-parameters.txt
index bc55fb55cd26..ce3659289b5e 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4158,6 +4158,18 @@
                        Disable NUMA, Only set up a single NUMA node
                        spanning all memory.

+       numa=3Dfake=3D<size>[MG]
+                       If given as a memory unit, fills all system RAM w=
ith nodes of
+                       size interleaved over physical nodes.
+
+       numa=3Dfake=3D<N>
+                       If given as an integer, fills all system RAM with=
 N fake nodes
+                       interleaved over physical nodes.
+
+       numa=3Dfake=3D<N>U
+                       If given as an integer followed by 'U', it will d=
ivide each
+                       physical node into N emulated nodes.
+
        numa_balancing=3D [KNL,ARM64,PPC,RISCV,S390,X86] Enable or disabl=
e automatic
                        NUMA balancing.
                        Allowed values are enable and disable
diff --git a/Documentation/arch/x86/x86_64/boot-options.rst b/Documentati=
on/arch/x86/x86_64/boot-options.rst
index 137432d34109..98d4805f0823 100644
--- a/Documentation/arch/x86/x86_64/boot-options.rst
+++ b/Documentation/arch/x86/x86_64/boot-options.rst
@@ -170,18 +170,6 @@ NUMA
     Don't parse the HMAT table for NUMA setup, or soft-reserved memory
     partitioning.

-  numa=3Dfake=3D<size>[MG]
-    If given as a memory unit, fills all system RAM with nodes of
-    size interleaved over physical nodes.
-
-  numa=3Dfake=3D<N>
-    If given as an integer, fills all system RAM with N fake nodes
-    interleaved over physical nodes.
-
-  numa=3Dfake=3D<N>U
-    If given as an integer followed by 'U', it will divide each
-    physical node into N emulated nodes.
-
 ACPI
 =3D=3D=3D=3D

Best Regards,
Yan, Zi

--=_MailMate_A3182494-4164-4931-ACA1-7DD7B64C4C42_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmaajj8PHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKi50P/2StnFfVhyfIidxi4I4PviEIp07lK+a0HhUj
GiUL0AoGmg41VTNcrPoAVr+L2nm5s7aAAswaJWre5Tg3suLl5ONshbWi5yf66f4C
VhHdLA8XFmx40SaWkXjIz/80fhCZtfSI+8FQijjTllZyxVwpOZRZomUJoKJrndwJ
doWGtBIxAMCgLBg+cZcx2nLCFP2Wx7pTXwL6mzPkmWvn514VtFOO7OyC6v6+b8e6
6PIs+lXBh1bQIsCdvbK3TlNMH0CQpEjD+YQbVzDG3sp2nQQfDxopYlfwZPZM9wzI
Ty1jJ9GU1+B9Ex7n02ApOJSUbqB3DnoYQ3wmyZj/kxi/FJDj/xPffmpCIr6wo5SS
1SvP1UP4aEsTjrIIwctWDvu3sII3/kjTyrHBM9PRC86lhcU8sHV9vtreDn3ftuv+
bObTSTqi/XC0U25H3yVJCZscFflEfyYgtHpN4++Qh50rWR5yCe7M+nycJ+vmZQsK
pp0fqQzABrterk06dkC88PFVRHhR78A3JbtCpILrBkUFNfuOjPj9tcc+yKtaiL0J
1rbL+ZS5xF86UYWN/S1ooLCYQwB6k+CL5dvOzqScJB6Q7yCcRsFaSy+DM87kfJVo
0VHeaXSxP0o1TgBWwq4guExScJ9otSZgS0ymc+aRiF2weG4ia4hjBH6ajBFv4wst
rYpx8igp
=Qe2B
-----END PGP SIGNATURE-----

--=_MailMate_A3182494-4164-4931-ACA1-7DD7B64C4C42_=--

