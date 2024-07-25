Return-Path: <linux-arch+bounces-5619-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE34C93B9D4
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jul 2024 02:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A79FD2847DB
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jul 2024 00:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1E323D0;
	Thu, 25 Jul 2024 00:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hWpdNJIL"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37AB080C;
	Thu, 25 Jul 2024 00:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721867763; cv=fail; b=UqzdccvWoOd9GbByYACQ7jY209UDFXNhxM+BG9MlVlWg47ZB+UK4or1AQXAZ/Ah4pKuRNABgDhRerSFrYySt27a8Awh313CpkdMhwqRTrplnxq00ky/2HD7j710/Lqadb16+NmZ0aWugK6P0Kup6Q7KtcF1EfxjMH9GxZGRd59c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721867763; c=relaxed/simple;
	bh=vwNTV2405fK6xuUJfj8WD8ZqZ7npJMRLNp6/YM3Pyng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H7baKEjJrscYR09tJlVh3Kw5/3omXmpcxEAe/6niFIbDoO5Eqa8U6ubYoJ3jqo/CAlOEyKZkx14iXekanmGIr/irqs94keYUhhncebvme5ErqSnYS7NGu+kzNj3ljQXkSG0wn/jHuZFGOL3KD0bxi7EbwN4E1Ueu6Itnz+Ki9jY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hWpdNJIL; arc=fail smtp.client-ip=40.107.244.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ql2kQs/nrB1x3RngwzaEsYgV2E7zITfyigh8wJkXK+emLxOe2S+yl0l1JLOzO+lLpKClu/ecEkuDS5w1TSMmMc/l6P0FBexiUjrQrGLnEdLyzkjH78+V+vy3EDKNKJt4mzvFfvQEmFSjGPsp9WmBMUkkV0qoevclNPtXTSwmj8dVNmPIUMiTnyI7OgANEhiQvuZExYoxxYG2LKW0IsCAMFP62ALUjufIMtZZPSwH//9DQ8v5KUGkF36MMwyy2PPS+ITuMshHzlN10UL+wcvfzSNa/s72vHz/bGBmMNBmTQ5/17OpJAs9twHHkjAEtlS0En5XLGRr9AlJWD2gLEa+Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=puczn/Plvra1c85dji4K9vrlyWEUgXDf8mOWU9BkLB0=;
 b=WG6kF6teJD2vxyd1Z00JQ0D7v8IJNSdtMfc3jpIz/8iuz3PUiQ6OaaxOIoJaBi0z1xDLBYvSW+wD7fYUty6cnR80V+qxmkLn501OFV20KyKvELh1arGiux2FpMfT8LtfB56rsiSmeAY8jfuIsiG4r0MOgsevXb2uqQUsfLYnbVvjY+0eb3+SdNAIsP1K/1nHBEJotTgsXbbG9TO+V7T1gYZyfweqP7f9FSrhd8eUaEt0TVDcKP1pG+jI3zajbGUiWI6FoXzR+4tpcApa0WtR59J5rJ2CA+9A5+KeJFbd492CJ7jjSplGwsG27y34yvKSsypGcyZZP0MOx1BT9WYjCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=puczn/Plvra1c85dji4K9vrlyWEUgXDf8mOWU9BkLB0=;
 b=hWpdNJILJpAVIZDvejy+cbKEracGKV0LTQ6UUgJxG7q+54hJjR5qyEsD8sN3Sad97DFQRHPbUUzj/wWic6Mzb4k8QhHjXdMsYc5Ownw4TY14poUNzSOMmKmCVUTf25SMWukFCBX6auimKoQFWhCIqas2A4HguD43yJcISUQBC25iqj8fwXTZfud58ZBLwK0Iimj6jfAu0u51oCZTSkS+/S22vaQrUWBTaJPdYfdGGyTUcybuOHOlfWvWmDdUaWBB8GGerK9KIk36DmZ8gOxG1fwswWBVtwn3o8lYch/+b0XMmWYVFAshsSHFtgJ8fL9CYh5sDqOd6U7qOA1HkZZ/Cw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 MW4PR12MB7484.namprd12.prod.outlook.com (2603:10b6:303:212::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.28; Thu, 25 Jul
 2024 00:35:57 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e%4]) with mapi id 15.20.7784.017; Thu, 25 Jul 2024
 00:35:57 +0000
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
Date: Wed, 24 Jul 2024 20:35:53 -0400
X-Mailer: MailMate (1.14r6038)
Message-ID: <6336C276-113E-4D93-A09E-13420A6438D8@nvidia.com>
In-Reply-To: <1D474894-F8AC-427B-8F90-5A6808E77CC5@nvidia.com>
References: <20240723064156.4009477-1-rppt@kernel.org>
 <1D474894-F8AC-427B-8F90-5A6808E77CC5@nvidia.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_0F561B29-1B56-4DB1-964E-7E202A4B673B_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR07CA0015.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::25) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|MW4PR12MB7484:EE_
X-MS-Office365-Filtering-Correlation-Id: b00e961b-1ed9-4fc9-7d72-08dcac41c020
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UEQXi1MXIgOm1aM3RiyjXJlXmZOZaqLT2V8uSuz9Cbf2rjo3wM6iyTrT4j3O?=
 =?us-ascii?Q?H54v2O1XISyG1nVe3kbMjS37hTS4i+asyndqWx2aFYNCEeEyaEBp/tdOTdXm?=
 =?us-ascii?Q?EaJcXBXsd5kSLNbXiThf5h7PMK+NqDnJYZBcMwSQEChgCD1WYwQ80VIsSnmX?=
 =?us-ascii?Q?XogmRWDb+wt+35+BOv7asQR3NQPUjyUcc7EUdFaD43qSlW0RqPYQkwKnarHK?=
 =?us-ascii?Q?pxcQEK1X+eRJh+kyatAoIS+HwYMm7ZiL0FxRaF8ZF4Y8Q/1MKS3QNlIlzo5N?=
 =?us-ascii?Q?I1f9bPPENtuMYoOi6p7jK4bHj6ZTsjKkf3IbrEU0DT/ANvNI/yWyBMcKNof7?=
 =?us-ascii?Q?DJ512UZqYym7fuhbPeAvEWQxUQb/rJqpWT4q6YBWMLfBlNIk8ymXKKmLnY4E?=
 =?us-ascii?Q?bD+UJHPp76tdurk4ejtNvMCGc7k6aFlZWp3IkHjKOl3amtX39dou6P71X+yi?=
 =?us-ascii?Q?jH/luSe5fp3YXhrlI0VXV5Y1yQJIkeqwWH3qT41W5LuXBeVtlI1GJoExd+yt?=
 =?us-ascii?Q?p+uYmW1fCn6oRcT9NSMMvLUv4TVYhUEG1r8ucg2m9kNPU9YPqrOwl//JEyQ0?=
 =?us-ascii?Q?CdiW/5YDYnogUU5J2YMoYSm56x5wtskRWZz7tOMocL+l3JArPLIb/JmcjJ3S?=
 =?us-ascii?Q?6lLeXhdaad4Jx84KjmY3bIC2AD7cl20+mv0hc3Jsn+mgtdKPxoZ3l75ChBG8?=
 =?us-ascii?Q?byc3uBxd5A//DDDOhM9qtNjXkBCODDiqTsxcTDKTSVs7mP39/ieUJBGHJsC8?=
 =?us-ascii?Q?yEgyl4ltt0ZvfwqBHf3Wb16Ytw7IwdkVxUqQ0A2Qaxnmb2vR/nxhMgjlf9WS?=
 =?us-ascii?Q?e5+KKmsfdj4Ytzz4iRW8uxULYTUQYDFlGwsQXNgbBgo0Q5XocyjfxyulnNT5?=
 =?us-ascii?Q?gLbA8u3kCfpCF7PtbYWKHrxIfFdlUm8x9Pljp669M0+7xNYCZ5aBn+VA3GYO?=
 =?us-ascii?Q?sYgmMVr7LFe8eGmXc4WadoSY9oyU68JTAvVRu9tRpNcKsKdMtunZKUC4UHOu?=
 =?us-ascii?Q?rJAABLzuNy/PPAT7pWdaVa7Cr+DHmm3AKb2oySQI/7oPMh1l0Y9LaUitVnyg?=
 =?us-ascii?Q?OBrw8GhIbJtMTbCJ4bl9r7OLLm8J0qPc/deR/8xa63bfC3fcSGC9thZT3+mg?=
 =?us-ascii?Q?9tT52qpFax4XYg+mA2rajFCU1wKnBfW6x8ukYoOkxzmAEIV1G2/6+R83tW4Y?=
 =?us-ascii?Q?wB7thchh3Qt+Bn9H0CUDo/QytfY8EexEDZi4TyfGuCbbB/CXYRYe2RTfuJNo?=
 =?us-ascii?Q?yrsknjiegZl9n3v5374i0o45UdjD65YTHmZWBdaj2gAD2+74Q1LzbAhEjHlu?=
 =?us-ascii?Q?E4Rm0zgk7LwT2WUopQmvDtV2s+xQBbkr1QxLFFbm4JhbyreH+20C0o+ORMOp?=
 =?us-ascii?Q?HcHFcqs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UEsv3FlW8LVidPVPWv/90sGVkaqGQ+ZEbdZlhWXe/wtU9RlqLpGMhCLF5rch?=
 =?us-ascii?Q?s5SA2lMNXvbNybnU5sUMjEu+e4S2hagZ5VE6YnNlPXRqRAeN+BqoLt2RIKIW?=
 =?us-ascii?Q?pey2iy2+iuFEYfcRqCo4TWHssFNamBvjanLWhh62QSI7mIaXvjB+nUxVpZUt?=
 =?us-ascii?Q?JWhumU5Z2Nu9UJgFVo+3T/DBDj/JTuoIXcXQzPTnBQu3iSEgejwZIn2X5ejG?=
 =?us-ascii?Q?Ii1vgjKZLuYTsslJJ95mJfXmYx4BxWQfwlHxy7H4bRNlm+NuowndZX1rRkcn?=
 =?us-ascii?Q?cSCaRiBg9IRmYMzzq8FXPgWL1uKpdSihsTYPcTh7YlLgG4YcteWHnWZYp8xp?=
 =?us-ascii?Q?isXF3oq1ngbTa2lvcQ99FFu80QppOQI/JGExZ6QIbjPq0SYni2vagX66M1NQ?=
 =?us-ascii?Q?rDbfOWs6QME5ZZ3oNS3attYJiuzoRKQVucgye3tmJdMR+JaTbnwC7FSsnUXM?=
 =?us-ascii?Q?122Q4jYG1/HzgIPbMHPYGKqmEZIJn6/oAdTLk28CYBr8JLMzSIgRhC+z1QLr?=
 =?us-ascii?Q?l/3V/0v0fpFHkEDltbJlYdTmjXUJjT7XECDwWjKwJW4A8TzdeYvC3WfA/Qah?=
 =?us-ascii?Q?mGeUUmGiDjENF92yjVm38ODm3NPlcd+IN8gBn233xF0SlfVsnBRqSSw9PUt3?=
 =?us-ascii?Q?fBs5HYxTkyjCiBU0RYIAjjSeqHDhAwaMX6Z8SPwcnTpsqUxtF5C1VQVJGTp0?=
 =?us-ascii?Q?Q2280epUAWrFPiJ9l8zR9I2bJo06gq7PNz2VLOc9oWuXoQIm2/dhoyy7IMJ8?=
 =?us-ascii?Q?ryVWD2dc/e/YeiPzBeXuAIw9r1G81skVA7tp4uU6bgLhidAOZBB/7537rMIi?=
 =?us-ascii?Q?N+iOwxnRk18uYlF4F5NbTzWHzDJdb4C6Ommhr3an8fDgiAB1nLL7vydlLlFK?=
 =?us-ascii?Q?TVKoEItAlHnLpheqFYyQYNfC9IwfiMlAgHsLtrgCSbBohMZ/sPeDLZ3ZEpAz?=
 =?us-ascii?Q?HXdJXUxh0m+7aRyK1OfSwFqRj3gW3irczLzpRZTVsgc2MQhJ5Wmb51UoTp6d?=
 =?us-ascii?Q?wJ5V3er1hczCDOr9vYfysSHBK+CMKGwBOU12faVlFjI/XgICCT/wBemmSiKE?=
 =?us-ascii?Q?v5/vqdCAJmql1qCEsszzDcpi2oXBvZG0sm+T7bYn80dc77PJmybB8RflEEao?=
 =?us-ascii?Q?5SJxHV2Dhg66B2ugohMEOzS3ZoqHdkmDa+lAOWxsqlLgjmjYXdYMHXQAUeVN?=
 =?us-ascii?Q?DZW1X9PNNR/bX3Z+8KLwZiY5hCODsdNZ3gX4IlkqQMdIILHAUvmn87IlZzAG?=
 =?us-ascii?Q?b1eGRayfLtVDyBTAmSCUGijUfyGZmrZmzWOraoNVCTarsqIADVfdVPEONiWA?=
 =?us-ascii?Q?QxZM2cEEo9V0lUqJ6Yr8t55jZpH4Ak7KjHesnV/0waulmjeDN83NsME4VOFr?=
 =?us-ascii?Q?l9rsqewyc8RoP/AQGBmZvqbVJ9s2hBLGqA0ibTNGWvjWLgw9K6xkIirWDGZ7?=
 =?us-ascii?Q?fwGCWRLfNGSsu55gEbNRiOs+Fe+2OP7pDxqqXlzBCO0TnHSPgzuV5nAk5eAq?=
 =?us-ascii?Q?KhQy1BtSjYggKa0b7yByUHQTXbVzDQt1CXJ/wk06Jfs39b+vvkBnokufUa2J?=
 =?us-ascii?Q?0d8bxPUlqFmVXhswEYGtjv/tohUIJypvoeSOohpg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b00e961b-1ed9-4fc9-7d72-08dcac41c020
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 00:35:57.7342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QK+rn9sLxym9rS/RFQjmNGqbhsvb1t1q656c7qz9/1Y4HHPzMxuVRfeqXlr3dlrx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7484

--=_MailMate_0F561B29-1B56-4DB1-964E-7E202A4B673B_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 24 Jul 2024, at 18:44, Zi Yan wrote:

> On 23 Jul 2024, at 2:41, Mike Rapoport wrote:
>
>> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>>
>> Hi,
>>
>> Following the discussion about handling of CXL fixed memory windows on=

>> arm64 [1] I decided to bite the bullet and move numa_memblks from x86 =
to
>> the generic code so they will be available on arm64/riscv and maybe on=

>> loongarch sometime later.
>>
>> While it could be possible to use memblock to describe CXL memory wind=
ows,
>> it currently lacks notion of unpopulated memory ranges and numa_memblk=
s
>> does implement this.
>>
>> Another reason to make numa_memblks generic is that both arch_numa (ar=
m64
>> and riscv) and loongarch use trimmed copy of x86 code although there i=
s no
>> fundamental reason why the same code cannot be used on all these platf=
orms.
>> Having numa_memblks in mm/ will make it's interaction with ACPI and FD=
T
>> more consistent and I believe will reduce maintenance burden.
>>
>> And with generic numa_memblks it is (almost) straightforward to enable=
 NUMA
>> emulation on arm64 and riscv.
>>
>> The first 9 commits in this series are cleanups that are not strictly
>> related to numa_memblks.
>> Commits 10-16 slightly reorder code in x86 to allow extracting numa_me=
mblks
>> and NUMA emulation to the generic code.
>> Commits 17-19 actually move the code from arch/x86/ to mm/ and commits=
 20-22
>> does some aftermath cleanups.
>> Commit 23 switches arch_numa to numa_memblks.
>> Commit 24 enables usage of phys_to_target_node() and
>> memory_add_physaddr_to_nid() with numa_memblks.
>> Commit 25 moves the description for numa=3Dfake from x86 to admin-guid=
e
>>
>> [1] https://lore.kernel.org/all/20240529171236.32002-1-Jonathan.Camero=
n@huawei.com/
>>
>> v1: https://lore.kernel.org/all/20240716111346.3676969-1-rppt@kernel.o=
rg
>> * add cleanup for arch_alloc_nodedata and HAVE_ARCH_NODEDATA_EXTENSION=

>> * add patch that moves description of numa=3Dfake kernel parameter fro=
m
>>   x86 to admin-guide
>> * reduce rounding up of node_data allocations from PAGE_SIZE to
>>   SMP_CACHE_BYTES
>> * restore single allocation attempt of numa_distance
>> * fix several comments
>> * added review tags
>>
>> Mike Rapoport (Microsoft) (25):
>>   mm: move kernel/numa.c to mm/
>>   MIPS: sgi-ip27: make NODE_DATA() the same as on all other architectu=
res
>>   MIPS: sgi-ip27: ensure node_possible_map only contains valid nodes
>>   MIPS: sgi-ip27: drop HAVE_ARCH_NODEDATA_EXTENSION
>>   MIPS: loongson64: rename __node_data to node_data
>>   MIPS: loongson64: drop HAVE_ARCH_NODEDATA_EXTENSION
>>   mm: drop CONFIG_HAVE_ARCH_NODEDATA_EXTENSION
>>   arch, mm: move definition of node_data to generic code
>>   arch, mm: pull out allocation of NODE_DATA to generic code
>>   x86/numa: simplify numa_distance allocation
>>   x86/numa: use get_pfn_range_for_nid to verify that node spans memory=

>>   x86/numa: move FAKE_NODE_* defines to numa_emu
>>   x86/numa_emu: simplify allocation of phys_dist
>>   x86/numa_emu: split __apicid_to_node update to a helper function
>>   x86/numa_emu: use a helper function to get MAX_DMA32_PFN
>>   x86/numa: numa_{add,remove}_cpu: make cpu parameter unsigned
>>   mm: introduce numa_memblks
>>   mm: move numa_distance and related code from x86 to numa_memblks
>>   mm: introduce numa_emulation
>>   mm: numa_memblks: introduce numa_memblks_init
>>   mm: numa_memblks: make several functions and variables static
>>   mm: numa_memblks: use memblock_{start,end}_of_DRAM() when sanitizing=

>>     meminfo
>>   arch_numa: switch over to numa_memblks
>>   mm: make range-to-target_node lookup facility a part of numa_memblks=

>>   docs: move numa=3Dfake description to kernel-parameters.txt
>>
> Hi,
>
> I have tested this series on both x86_64 and arm64. It works fine on x8=
6_64.
> All numa=3Dfake=3D options work as they did before the series.
>
> But I am not able to boot the kernel (no printout at all) on arm64 VM
> (Mac mini M1 VMWare). By git bisecting, arch_numa: switch over to numa_=
memblks
> is the first patch causing the boot failure. I see the warning:
>
> WARNING: modpost: vmlinux: section mismatch in reference: numa_add_cpu+=
0x1c (section: .text) -> early_cpu_to_node (section: .init.text)
>
> I am not sure if it is red herring or not, since changing early_cpu_to_=
node
> to cpu_to_node in numa_add_cpu() from mm/numa_emulation.c did get rid o=
f the
> warning, but the system still failed to boot.
>
> Please note that you need binutils 2.40 to build the arm64 kernel, sinc=
e there
> is a bug(https://sourceware.org/bugzilla/show_bug.cgi?id=3D31924) in 2.=
42 preventing
> arm64 kernel from booting as well.
>
> My config is attached.

I get more info after adding earlycon to the boot option.
pgdat is NULL, causing issues when free_area_init_node() is dereferencing=

it at first WARN_ON.

FYI, my build is this series on top of v6.10 instead of the base commit,
where the series applies cleanly on top v6.10.

[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000080000000-0x00000000ffd82fff]
[    0.000000]   node   0: [mem 0x00000000ffd83000-0x00000000fffb5fff]
[    0.000000]   node   0: [mem 0x00000000fffb6000-0x000000017befffff]
[    0.000000]   node   0: [mem 0x000000017bf00000-0x000000017bfbffff]
[    0.000000]   node   0: [mem 0x000000017bfc0000-0x000000017c02ffff]
[    0.000000]   node   0: [mem 0x000000017c030000-0x000000017c03ffff]
[    0.000000]   node   0: [mem 0x000000017c040000-0x000000017c09ffff]
[    0.000000]   node   0: [mem 0x000000017c0a0000-0x000000017c13ffff]
[    0.000000]   node   0: [mem 0x000000017c140000-0x000000017f41ffff]
[    0.000000]   node   0: [mem 0x000000017f420000-0x000000017f4affff]
[    0.000000]   node   0: [mem 0x000000017f4b0000-0x000000017f5bffff]
[    0.000000]   node   0: [mem 0x000000017f5c0000-0x000000017f5dffff]
[    0.000000]   node   0: [mem 0x000000017f5e0000-0x000000017fffffff]
[    0.000000] pgdat: 0000000000000000, nid: 0
[    0.000000] Unable to handle kernel paging request at virtual address =
0000000000002220
[    0.000000] Mem abort info:
[    0.000000]   ESR =3D 0x0000000096000004
[    0.000000]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
[    0.000000]   SET =3D 0, FnV =3D 0
[    0.000000]   EA =3D 0, S1PTW =3D 0
[    0.000000]   FSC =3D 0x04: level 0 translation fault
[    0.000000] Data abort info:
[    0.000000]   ISV =3D 0, ISS =3D 0x00000004, ISS2 =3D 0x00000000
[    0.000000]   CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0
[    0.000000]   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
[    0.000000] [0000000000002220] user address but active_mm is swapper
[    0.000000] Internal error: Oops: 0000000096000004 [#1] SMP
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 6.10.0+ #17
[    0.000000] pstate: 600000c5 (nZCv daIF -PAN -UAO -TCO -DIT -SSBS BTYP=
E=3D--)
[    0.000000] pc : free_area_init+0x720/0xf90
[    0.000000] lr : free_area_init+0x714/0xf90
[    0.000000] sp : ffff800081eb3c20
[    0.000000] x29: ffff800081eb3c20 x28: 000000017b5e710c x27: ffff80008=
2158000
[    0.000000] x26: 000000017ffff168 x25: ffff800081ecc000 x24: 000000000=
0000000
[    0.000000] x23: 0000000000000000 x22: 0000000000000000 x21: ffff80008=
21f0480
[    0.000000] x20: 0000000000000000 x19: ffff8000818863f0 x18: 000000000=
0000006
[    0.000000] x17: 00000000007fb000 x16: 000000017f805000 x15: ffff80008=
1eb36b0
[    0.000000] x14: 0000000000000000 x13: 30203a64696e202c x12: ffff80008=
1f3ef10
[    0.000000] x11: 0000000000000001 x10: 0000000000000001 x9 : 000000000=
0017fe8
[    0.000000] x8 : c0000000ffffefff x7 : ffff800081ee6d40 x6 : 000000000=
0057fa8
[    0.000000] x5 : ffff800081f3eeb8 x4 : 0000000000000000 x3 : 000000000=
0000000
[    0.000000] x2 : 0000000000000000 x1 : ffff800081ec8c40 x0 : 000000000=
000001f
[    0.000000] Call trace:
[    0.000000]  free_area_init+0x720/0xf90
[    0.000000]  bootmem_init+0x158/0x218
[    0.000000]  setup_arch+0x220/0x650
[    0.000000]  start_kernel+0x74/0x7e0
[    0.000000]  __primary_switched+0x80/0x90
[    0.000000] Code: 97a64606 b940b7f6 a90dffff f876dab4 (b9622280)
[    0.000000] ---[ end trace 0000000000000000 ]---
[    0.000000] Kernel panic - not syncing: Attempted to kill the idle tas=
k!
[    0.000000] ---[ end Kernel panic - not syncing: Attempted to kill the=
 idle task! ]---

--
Best Regards,
Yan, Zi

--=_MailMate_0F561B29-1B56-4DB1-964E-7E202A4B673B_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmahneoPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUlwUQAJhiW3WWTu3PREnDrPSG03Ni98AT5kE27HQs
kZfZpevoam3PiqHoTYaJz02RxXnfY/8qp2JwPiTSCkDJfMuncNS+JC9tEykJzxdw
15Y+zyIufYtDgu80/xlyvj4qBqkxliiAhG50K8iZOWEYBdu4GpAM87AWY3Ff0Iv+
niUUJ/vmsNUH1R3ZYdyP2b2PfSC3Ok9kfFlwE5Jm4LXY9Ju4ixrU5Ku9C1UtxyDb
CGRv/et2yGKPbzM34rR6u6/JAAFbXoQW3uJrUmSr2UnTbFITW51gqDQ7urvUwxPA
pnnqqUCNLGLfR7inpVqC0EOs4AMVfnj4ZkOxWihSD73lnUz5tE8kTrt3yf7+qVO5
Q2GTniU/D9l38KVu8yuX9Z3/DULpJN/La58dWMxPKAQlOU21eFhufMAX8sNLga/j
VeJTo8tVpqMyJLJuT4gP0sXlZknYhCmV4RzWc5s8QT54TfcIbaAx5I2LhRJwmuu9
Gze5NXEqCyEQ4guQ6t2oEfmf8+Eanax26jFgm08ZfUuZwfsgynTnYAyo8JtAj4az
VIGf+kKnKOQDiojSMBABaQoiBk6h6Sh5U1AXirqeSvNrmKISkEdydul9NijMidjN
aC97As4te+mPqJ1QyZNdudbYCtrZZ6+X+88HoDMKgB9uHhXmGpdnSsjDJ89LD9tk
ROfMsB3E
=mFe0
-----END PGP SIGNATURE-----

--=_MailMate_0F561B29-1B56-4DB1-964E-7E202A4B673B_=--

