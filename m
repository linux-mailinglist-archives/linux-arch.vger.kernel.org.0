Return-Path: <linux-arch+bounces-5621-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D178A93BAF1
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jul 2024 04:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AD7D1F2219B
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jul 2024 02:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B2411725;
	Thu, 25 Jul 2024 02:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="K/gRXzsz"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3422139B;
	Thu, 25 Jul 2024 02:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721875732; cv=fail; b=KBh/1CoJasIcWhx2J09egMciWvxB4UTvdmzesHu6mo5QBuGd/zMlz9AdQmMmpT7z0OIQ339qnFX+ac61hddnHYd0s6VHMWHktlkpPVLpgoHz7K0MuaMj3FSIkpytOu5pF2fIABJhM5OOU8mPbDLpnRyNcydRl/NWqa/HWUruL54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721875732; c=relaxed/simple;
	bh=Pw5FmhdcjlHnhYHySqycRUlHLi9a2tJi5nuxAsLZoLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XoDdO5wCEjNOlYwbsFfzz1g81AKLWsgpC+42gboni1+EYFD4pSBj+4BiqPE2ncgwUdWxmJxWbtO4+4au+aae8y+V3uKgIm0ttItejCZ81Olt5BXEmio+mEnDVs2W4QmvEW5VWWCp6scTkHgGCGjby7U6mtGjujdoNwNfSYjhqeI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=K/gRXzsz; arc=fail smtp.client-ip=40.107.92.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OPMWCVZVJXVs9jQE55+3JHZ7lTFWvn6colaLiJ8qNm0IswWQC7g637kFeQYeKe0Xca27VCew96V4VOwH4tH6wzrMgt1Z4bdnDzgyftwwKLYn7ZUTZXDMlBmzNAY6YMwH3H/iwvnrcYL2MnApLHALZTW1tsYVtOQYsSedNmjn36f2pb9TIjtTnWtf8X71gb4L/GLFJRSNWlslIFrY6cMIFONjUHA1c3RtgTbdVCdLfb3D8+eWLLiBMWfRg9D36NZqPzOTpHJkIYAnOOqULSSzNmMDy6gGiWcdvf8e7cQMAXUlirXiaaHWmIFMg8XDgifrEvHBrkdBbV+/ALUyW3rtiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KICwaEmEmefSXrpqpyBJFKorUqr504asr+dVhE0WZNg=;
 b=WJxRncRt7GS/x80xrF+lDVOttPmfCzMKCW/RrQZyVp6tyQX42QzjQhZRLWnTzpo8p8gLS8BS/iQMcl7K3qosIT9QYMCRRanMq48HW/ZdyvPmhVbMdXVHeQ15ycirOXIFY4h3aORxsKp3NirMnoWjqzirHjvmUvNirkYC3vSI9+9RQxImlmnlIfo6jjjyfPg8pZWTPdqlRugfD8cUUZpHFlLFQOgqGu8W4sbSv9fr095oykL03bL7Ku5rRgNoXrXr6THEtF0nDgRgnfgELHmzj5B24k79qlYZ0b5QOnmRQMmOrEhNAlexRvJ6Wk/3j6iw4+rkFAZLhDdBdlJlp2Rd9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KICwaEmEmefSXrpqpyBJFKorUqr504asr+dVhE0WZNg=;
 b=K/gRXzszGAPHYMDC/RhldMty0QV7ndTMINas1csgLmoH+RyKtxEsyjEtMv99trHezfehhW8WMXIUJWHFFKV5ynvVtotQPbhtm9Es3MIOdz8Ts0R0plCVX5uDQIcpiYff10dmYFu0O+edjun8LF4l7DkUGmRtVvnVUx4KnK7klsTaJYuIMoqDMcWLydleK59jaqDZhCTn1jQrUbf/DNss0C74gtCOD25RObpAdjB5jAfk9b5WiLnvtvkJAoF+sGFjVjeLpT7UUJQntv8tmC23oG9mKFleP2DJYnx7o/g3QydMxG1X99TKjUwgc42RBW7+dW65o4Ut5cbmyRsM+NTtFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 IA1PR12MB6434.namprd12.prod.outlook.com (2603:10b6:208:3ae::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.19; Thu, 25 Jul
 2024 02:48:46 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e%4]) with mapi id 15.20.7784.017; Thu, 25 Jul 2024
 02:48:46 +0000
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
 "David S. Miller" <davem@davemloft.net>, Davidlohr Bueso <dave@stgolabs.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Heiko Carstens <hca@linux.ibm.com>, Huacai Chen <chenhuacai@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Jonathan Corbet <corbet@lwn.net>, Michael Ellerman <mpe@ellerman.id.au>,
 Palmer Dabbelt <palmer@dabbelt.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Rob Herring <robh@kernel.org>, Samuel Holland <samuel.holland@sifive.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Thomas Gleixner <tglx@linutronix.de>, Vasily Gorbik <gor@linux.ibm.com>,
 Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-cxl@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-mips@vger.kernel.org, linux-mm@kvack.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 loongarch@lists.linux.dev, nvdimm@lists.linux.dev,
 sparclinux@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v2 00/25] mm: introduce numa_memblks
Date: Wed, 24 Jul 2024 22:48:42 -0400
X-Mailer: MailMate (1.14r6038)
Message-ID: <231F6DF6-96C8-4149-92CF-4FC03C9FE357@nvidia.com>
In-Reply-To: <6336C276-113E-4D93-A09E-13420A6438D8@nvidia.com>
References: <20240723064156.4009477-1-rppt@kernel.org>
 <1D474894-F8AC-427B-8F90-5A6808E77CC5@nvidia.com>
 <6336C276-113E-4D93-A09E-13420A6438D8@nvidia.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_59508B23-E8AA-4646-9577-89FD38A5FCB4_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BLAPR03CA0141.namprd03.prod.outlook.com
 (2603:10b6:208:32e::26) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|IA1PR12MB6434:EE_
X-MS-Office365-Filtering-Correlation-Id: 075ff538-581b-41af-e117-08dcac544dda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?F8zHuYmDBhxnoTyLuMaurgXYomhFgefgBuJEwk+q4yRleLjJjJda9fRSTf/q?=
 =?us-ascii?Q?HJFjhdPxL9lX31u3Anh0auTgOLNu6zqKCdfnfQS3UGzWpEx8TkFAWdF65aq+?=
 =?us-ascii?Q?1cyJy91odCgSQiN5O1ZKT/GvtQPjcWD6wThqjMUVB5sU1jGZnv7rCRmCBK/R?=
 =?us-ascii?Q?/xF5tWIWY7VySwZyTqC39EDfxbmhbzATPtix3W1sZ29JTlD4hjBN7H9yVaty?=
 =?us-ascii?Q?VTgTv/tvQeWP56q8d/iYPpee/kGZEamIQLzp3D8q83U2fMZmvrq+IHYgHsut?=
 =?us-ascii?Q?92xt/na/vDAyQrEiwlxwsBo+nqQ7dt3s5S+ZDsU/8Cf+i3TjgLFEK7qArIzn?=
 =?us-ascii?Q?+gTqA7sVZvmMFC534QxUbE8xFstkegUZmpThgeYKUZQ5j5q8tDpRTWhHyTnd?=
 =?us-ascii?Q?fQNPMXBgkVZ2NMxa663/H0L+34WGmF+o0fbQ6dRrYbwIvEZFxkqtiJAYWb1C?=
 =?us-ascii?Q?w6tK4q0hEz1QUcxzPS2S1Wnef3SAuZwnbWRzOS2SYDCcW4/dgDxo0xooEwuf?=
 =?us-ascii?Q?y9xcNUv5hzxFPImxGjbo44sXaSrg6NgHw4fX9O6qqmJ3qQwnOAM2c1Bc3BYZ?=
 =?us-ascii?Q?Q12ySP1DhmtTqvaWUJ08pPg6mZx5gejYi0jZGFKa5tOZ3zTaQtySIbJZFFwv?=
 =?us-ascii?Q?rHHEV0G441/DCugzbHpnmmcak73xhV5MWkEbHvj3onFyoPdAzSlU2Zkw+Vbd?=
 =?us-ascii?Q?IoEq3nfe/4ce6YqIKto8z3SOLOXeE2LQKwZGX84ri/YmLO1C0Zjww3b953T+?=
 =?us-ascii?Q?fEC95OQKIcmCNlJojnaXiOSbpTW3l9E1MGtzvuBqaf1dO8281JFfSAajC3x5?=
 =?us-ascii?Q?+u7ML5X8fhvw9DXQsgjZB/hRsBqld22oBp/5tLBOQpljYhJd+DnOMT7EIZ3u?=
 =?us-ascii?Q?LXgsSZStJJt2CfQ4Fl6dmbiQbHTEIRPS/l7zeRJ3158TKrvFZqbmJHxChhQT?=
 =?us-ascii?Q?xtRKeboxd2K9YAFEQVjHFK2OQI0H/EEKuw8CfhlB0VjgLPqAgRlbGDFazGgQ?=
 =?us-ascii?Q?p9Lz3wAI0Fb1BM9zqatLqCWdzvM1+YqReBeitLas1ykS+Ji93PrP3gv561LI?=
 =?us-ascii?Q?3ji5Pb5xK6DVWDnobVXkf1KE+toSCTEJFeoortH6Fa4vJZHEbyA07xJvESex?=
 =?us-ascii?Q?oz5hxLhuW7f3yTyTWv6z0l1gJtZwbbQoNdRX5NRFyHmmZLAQUQk/2FlYGoB8?=
 =?us-ascii?Q?6R1fXY+lWeHprZRDL5rnOBTDDzE4SSjpBzCUuNgZKtxpvy9/O8OXXb/Rbt5v?=
 =?us-ascii?Q?hRQ8Fl1oNYfEsEl8/BWM+GOhPjrCLtFcSenV0d3oUjytjp6S/U2VubOXLawN?=
 =?us-ascii?Q?sNmYhtMPVYYgXd3u72rxlAJM6jj3hwXZdnnuCtzMiRxse4DjrBVClRjrTnZg?=
 =?us-ascii?Q?SmpKX9U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KcN+AyorealjjBn58OV/a2CERzpv4ZdiPFnqfrPBIWjRrkr1pLiXlzahZaxm?=
 =?us-ascii?Q?NY9d/XDXUKab8XwYjWNDClFrDxQW9k6ZYtDHgwL41/SKwzCYzq5JBkDDqS1o?=
 =?us-ascii?Q?kWzNliU1vKxP9G3tzOvHE1x/hqDdF99CuFg2zcABgCVjJrRyq75MV156R3v9?=
 =?us-ascii?Q?avQ9mab1pIFQWjflI+ZsuZYD1qTMOG+S8vjUl3igaQL5hS9WFWDtDnLFXEOb?=
 =?us-ascii?Q?5A19tUvR1gg1C3GcEN8PF0xWoA0/wY2Sn8b1taQwRNg1SyVihpW8HzjK8pjN?=
 =?us-ascii?Q?bsO1OT1n5H3y8YswpGQLbmv22xuZTbEDqtZ6AIbd6AkCK4SF6FAZLVDRvC9g?=
 =?us-ascii?Q?bO26vVfrKCg9DxngGRs5h9JwU8daQDOt/hrQ0/wqnZhCN8Uf2LDVwxBOAZzO?=
 =?us-ascii?Q?UH44lEAnwJWo93WrICTIIh7uFKXkpRgay+bB2ZLlIw9C0cNZCXKgyPtxWg7l?=
 =?us-ascii?Q?fgej1RMvx85bvAOHKeY3V7JNg0LKvQvMf6gcXxGCxURFw+4q1NsgrzsSCr52?=
 =?us-ascii?Q?wuduZPDusdEG02u8vLgguJrAsWSV0j7E/zVYNNoqDm9UMFDaXImmBva6FBMO?=
 =?us-ascii?Q?I39SfRJSpeWDvtDvcz2Bv40wTLkxClpFfKvj0qsQClGV1FuZXTkLIrXa7W85?=
 =?us-ascii?Q?mzi/9UXaDg1xO5HVazlkbg/NmbZi4vlIitroHdTYkmmHEfPctJoVixkY3RIN?=
 =?us-ascii?Q?b3U4fqXTRHhllDuSn58yZ5i056FbQGoIFfnTRQa/BNPYY56KnI4vLp72sYoI?=
 =?us-ascii?Q?EzodjKdUOr0c6ljwhAIvABu5SDCIMIxVfs7SJwWtaWs2r4g+EQaO29RsJgYF?=
 =?us-ascii?Q?5g4Ta0zSplzx6/DJM6pISa2etC+YIRVxSmiBZBvel5DAovSQiZgV0MTjNFC/?=
 =?us-ascii?Q?imAs5ATH6go5wqEHgfrHpQ4h16GgNV2CXQoKYib4KrG/2STLy7/Zjf+3/9CD?=
 =?us-ascii?Q?ivjf8KSgyduqAm0JNlxf8+m49EnXU+yRlfH9Fo2+iwm6NRqs6QhAraML6CIW?=
 =?us-ascii?Q?G5CuGKlS0PwJ1usjI/5hikLo17z2u8E1B29+UNiPo0ZdHRTt0sKUVCi3EF9M?=
 =?us-ascii?Q?MmfVTRzDBEaXgMtwMeiAtTN7ayR1q6GJ2ZhZBS8/9gaYV3/e5LWPBssG5mA5?=
 =?us-ascii?Q?ou3kjEOZeKJu5bbdnpfurYIjexrGpEDTvLmoOmpXiOjjmnk3o/lwnO0J//l4?=
 =?us-ascii?Q?kLW1wmatHReqYHZO4HQxncY5VdE6Ey5ldUW0yAtRftSkCBlWPlcjpvo/g4vW?=
 =?us-ascii?Q?RNjxnfcYkYPxlk+lxud1sS01fP7qy6G5OksgxfqpBK7C6EEEVWvHyK2Omdoy?=
 =?us-ascii?Q?ypaGYMsoFJ+E60FrVFaCsJh/uT1kB00vzhmIisZ/CeKvSlVN8XDceoWjifPU?=
 =?us-ascii?Q?dO43pCPKkLperGFAY2DJr6A9a/VLXrinqZBme2wp4fyt/wCs0c5kK7G3AqK5?=
 =?us-ascii?Q?1nvxho9ONrYyXwzqQhD/2toSBADhx0ooDCxXko9Xc4KEUEzhkWZMdbtdXSdZ?=
 =?us-ascii?Q?FgZ197KczpR13cZm2xrAYOtm0oPuRLVa/42t6cMo3Ulf/pqeFlkJXVMSagOq?=
 =?us-ascii?Q?20ykFkh54liP7vW+iZuSNXtRIz03LpCl7fOfERYh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 075ff538-581b-41af-e117-08dcac544dda
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 02:48:46.4664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 68GWoAGC7x7M+9elXqXJm9xiJ4NJ6LwbNRQfq6l5NTs68k18A10Urz2M9qqv0O+E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6434

--=_MailMate_59508B23-E8AA-4646-9577-89FD38A5FCB4_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 24 Jul 2024, at 20:35, Zi Yan wrote:

> On 24 Jul 2024, at 18:44, Zi Yan wrote:
>
>> On 23 Jul 2024, at 2:41, Mike Rapoport wrote:
>>
>>> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>>>
>>> Hi,
>>>
>>> Following the discussion about handling of CXL fixed memory windows o=
n
>>> arm64 [1] I decided to bite the bullet and move numa_memblks from x86=
 to
>>> the generic code so they will be available on arm64/riscv and maybe o=
n
>>> loongarch sometime later.
>>>
>>> While it could be possible to use memblock to describe CXL memory win=
dows,
>>> it currently lacks notion of unpopulated memory ranges and numa_membl=
ks
>>> does implement this.
>>>
>>> Another reason to make numa_memblks generic is that both arch_numa (a=
rm64
>>> and riscv) and loongarch use trimmed copy of x86 code although there =
is no
>>> fundamental reason why the same code cannot be used on all these plat=
forms.
>>> Having numa_memblks in mm/ will make it's interaction with ACPI and F=
DT
>>> more consistent and I believe will reduce maintenance burden.
>>>
>>> And with generic numa_memblks it is (almost) straightforward to enabl=
e NUMA
>>> emulation on arm64 and riscv.
>>>
>>> The first 9 commits in this series are cleanups that are not strictly=

>>> related to numa_memblks.
>>> Commits 10-16 slightly reorder code in x86 to allow extracting numa_m=
emblks
>>> and NUMA emulation to the generic code.
>>> Commits 17-19 actually move the code from arch/x86/ to mm/ and commit=
s 20-22
>>> does some aftermath cleanups.
>>> Commit 23 switches arch_numa to numa_memblks.
>>> Commit 24 enables usage of phys_to_target_node() and
>>> memory_add_physaddr_to_nid() with numa_memblks.
>>> Commit 25 moves the description for numa=3Dfake from x86 to admin-gui=
de
>>>
>>> [1] https://lore.kernel.org/all/20240529171236.32002-1-Jonathan.Camer=
on@huawei.com/
>>>
>>> v1: https://lore.kernel.org/all/20240716111346.3676969-1-rppt@kernel.=
org
>>> * add cleanup for arch_alloc_nodedata and HAVE_ARCH_NODEDATA_EXTENSIO=
N
>>> * add patch that moves description of numa=3Dfake kernel parameter fr=
om
>>>   x86 to admin-guide
>>> * reduce rounding up of node_data allocations from PAGE_SIZE to
>>>   SMP_CACHE_BYTES
>>> * restore single allocation attempt of numa_distance
>>> * fix several comments
>>> * added review tags
>>>
>>> Mike Rapoport (Microsoft) (25):
>>>   mm: move kernel/numa.c to mm/
>>>   MIPS: sgi-ip27: make NODE_DATA() the same as on all other architect=
ures
>>>   MIPS: sgi-ip27: ensure node_possible_map only contains valid nodes
>>>   MIPS: sgi-ip27: drop HAVE_ARCH_NODEDATA_EXTENSION
>>>   MIPS: loongson64: rename __node_data to node_data
>>>   MIPS: loongson64: drop HAVE_ARCH_NODEDATA_EXTENSION
>>>   mm: drop CONFIG_HAVE_ARCH_NODEDATA_EXTENSION
>>>   arch, mm: move definition of node_data to generic code
>>>   arch, mm: pull out allocation of NODE_DATA to generic code
>>>   x86/numa: simplify numa_distance allocation
>>>   x86/numa: use get_pfn_range_for_nid to verify that node spans memor=
y
>>>   x86/numa: move FAKE_NODE_* defines to numa_emu
>>>   x86/numa_emu: simplify allocation of phys_dist
>>>   x86/numa_emu: split __apicid_to_node update to a helper function
>>>   x86/numa_emu: use a helper function to get MAX_DMA32_PFN
>>>   x86/numa: numa_{add,remove}_cpu: make cpu parameter unsigned
>>>   mm: introduce numa_memblks
>>>   mm: move numa_distance and related code from x86 to numa_memblks
>>>   mm: introduce numa_emulation
>>>   mm: numa_memblks: introduce numa_memblks_init
>>>   mm: numa_memblks: make several functions and variables static
>>>   mm: numa_memblks: use memblock_{start,end}_of_DRAM() when sanitizin=
g
>>>     meminfo
>>>   arch_numa: switch over to numa_memblks
>>>   mm: make range-to-target_node lookup facility a part of numa_memblk=
s
>>>   docs: move numa=3Dfake description to kernel-parameters.txt
>>>
>> Hi,
>>
>> I have tested this series on both x86_64 and arm64. It works fine on x=
86_64.
>> All numa=3Dfake=3D options work as they did before the series.
>>
>> But I am not able to boot the kernel (no printout at all) on arm64 VM
>> (Mac mini M1 VMWare). By git bisecting, arch_numa: switch over to numa=
_memblks
>> is the first patch causing the boot failure. I see the warning:
>>
>> WARNING: modpost: vmlinux: section mismatch in reference: numa_add_cpu=
+0x1c (section: .text) -> early_cpu_to_node (section: .init.text)
>>
>> I am not sure if it is red herring or not, since changing early_cpu_to=
_node
>> to cpu_to_node in numa_add_cpu() from mm/numa_emulation.c did get rid =
of the
>> warning, but the system still failed to boot.
>>
>> Please note that you need binutils 2.40 to build the arm64 kernel, sin=
ce there
>> is a bug(https://sourceware.org/bugzilla/show_bug.cgi?id=3D31924) in 2=
=2E42 preventing
>> arm64 kernel from booting as well.
>>
>> My config is attached.
>
> I get more info after adding earlycon to the boot option.
> pgdat is NULL, causing issues when free_area_init_node() is dereferenci=
ng
> it at first WARN_ON.
>
> FYI, my build is this series on top of v6.10 instead of the base commit=
,
> where the series applies cleanly on top v6.10.

OK, the issue comes from that my arm64 VM has no ACPI but x86_64 VM has i=
t,
thus on arm64 VM numa_init(arch_acpi_numa_ini) failed in arch_numa_init()=

and the code falls back to numa_init(dummy_numa_init). In dummy_numa_init=
(),
before patch 23 "arch_numa: switch over to numa_memblks", numa_add_memblk=
()
from drivers/base/arch_numa.c is called on arm64, which unconditionally
set 0 to numa_nodes_parsed. This is missing in the x86 version of
numa_add_memblk(), which is now used by all arch. By adding the patch
below, my arm64 kernel boots in the VM.


diff --git a/drivers/base/arch_numa.c b/drivers/base/arch_numa.c
index 806550239d08..354f15b8d9b7 100644
--- a/drivers/base/arch_numa.c
+++ b/drivers/base/arch_numa.c
@@ -279,6 +279,7 @@ static int __init dummy_numa_init(void)
                pr_err("NUMA init failed\n");
                return ret;
        }
+       node_set(0, numa_nodes_parsed);

        numa_off =3D true;
        return 0;


Feel free to add

Tested-by: Zi Yan <ziy@nvidia.com> # for x86_64 and arm64

after you incorporate the fix.


--
Best Regards,
Yan, Zi

--=_MailMate_59508B23-E8AA-4646-9577-89FD38A5FCB4_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmahvQoPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUSf0P/0cm9Ze5mkTYGa1wnpb68oWLf69d3kYx4/rD
EJiF/eiAN0aZvKrfaf0nR+Wv3VR+Q/uNKbhMUSV4Fh4rmQ2RlHsWKyfnTiHssLey
tG29ykrNlHIW7JKyczMSOk1OoZIcNLGGN/460+/vg/5i5GJycnZzVDossjE3aNAm
nxsRenHA8CKxOgRfWoklsq9BxqkrbiO44mAfJ5u/pITtTBwHMl/Ic2e8jtr+jyMG
9dXB5q5E6vyLXAam9dDqLxKBCuDN3JHEP7H8FeHqqm1fvMShZ1L2i6KNJIILIGus
VS2axQL2JJG2gjGSU4WhUQU1vNCS9olGNq8RTR2Z8dZN0giE5RqIxnPJCtyMPxYc
CweiYuXt3j2SnADAUJkwoG1e6UEu+N+EPl4n0NOehhsCT0I+EYUtRKG8vUlVv4J5
lXAhfCXI2yM7y1TgmCHxeRRbvxXMzBJ9nca1DGBZ96NXga/F0n8OxOF5wZLrNAH5
45aSfogAKVUN69rtRtd6S3YjUm8yplbX3LQ3zFG72ojN/qeLK3jOzTRO0Cqk3vCE
qzH0Hr1GjYL2m18/9Qv2hpZYyREL8qYtRX+zbUmHhq5XQaPtfYUNOPGw91M/XCgH
+eZEp7E/gWez4mMq/hFK8b2HudbSBYg9xiDNiG2LSn0eA8pGhyXVhC4+2IzUtzSm
JyYYM5Mt
=ZVJ/
-----END PGP SIGNATURE-----

--=_MailMate_59508B23-E8AA-4646-9577-89FD38A5FCB4_=--

