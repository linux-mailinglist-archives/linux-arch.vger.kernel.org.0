Return-Path: <linux-arch+bounces-8887-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A07F9C07B5
	for <lists+linux-arch@lfdr.de>; Thu,  7 Nov 2024 14:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D8CE1C238E0
	for <lists+linux-arch@lfdr.de>; Thu,  7 Nov 2024 13:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF05021018B;
	Thu,  7 Nov 2024 13:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="T7FunfcL"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6E518FDAF;
	Thu,  7 Nov 2024 13:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730986652; cv=fail; b=BxWQCzXOHsnlKKfTv9VNGajDAGTN6CmsUis0D/+os52fCPaLr4/nZDn69Vtj4M3mTqHVZB0w2bgYgriqr6rCTr3yKNdIxx9Ew52aiczSsOPPVZMdaAZp4UGXHR1UL/yZqusX5nmBb+FgxrflYehgpJB7PAnhshSnGcnhxWCKsy8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730986652; c=relaxed/simple;
	bh=uqjm4ruQJKbgTqmVAnM8v1SOvNtL1HsABaKuITU/b2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZoZpr04HVGDYhUOtMOWPCiCH/kEJKJX9oNIVWOiw8mSurWnd2V5B+mnDlm20FyCkcmdA9PjN7HXL0JbhWIZ7XCDacFSNDyROmAhQ5P0+0CbnAXkvjqZmIMVTWmd5vEK0BxL+fP3ZyvPDAhB9LXDSulfDvAwx4AVoRFc7zlt1GqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=T7FunfcL; arc=fail smtp.client-ip=40.107.237.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lzMlH1VJleWh3uBAqD3Z6zOJDm1CLkwKHTACUcTC789vDW7yxJAJm629vTqPEQKHNhS+UGCV0IkGnSWeUo/U5xdUC7Qq5SlavJwfjhB+zETkKVNRnDnnLoipTqiU6dt7OVZpZuENjQZqonEq6tkfkOLraLFcpEBH7WyRXfs2kc0G/PtIlYVr7GoFgC+QBK2z8303VPXYkz7OWCsuQphr19wYE7JT5AanGrnUlrdzHJijphFIhBdF4s3xwDkNHJzX+rd0Wk5S2BxZq41mJgFythIVZKbqdG0HzGoKIxYJ1+d/428V8+4S/OEX17vjluuoQZc9GT3/qU8a8S6KPKgZXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2vA4mWuK67pfUjv0phfrN6+VEK9IQ5fKe2u0rvuFFNc=;
 b=nN9NAk/7t1W8HIP52FemoX12nb/6QQkWiCDsHxBgS7mj4YQ8ewtpbEP6oalAOZNOGiHTMmWHmPVnzDw9ahyuXwu5BrwEVM1/q81z1VB9TWEfHYLJqoiiPlmjR1lf7JJGNXqHbQ4KoKgihBiHFzgphoIE64BwZ3QlUQJgIfpI3XbkjVqGID5/UrSYz2Oy+5Rwr3Apm11tgRptTlYialLNMCTENDZ5/X/cQSFVqmW0nMnibRG2Aq+9DHBs/j3KCJLJ0zPeZD/YL3+TwY5FJ3n4RkWLwbis78aFYKg8crNOb2DyAkU4Nne8UsvWewx6zlMpTrpEwRbrmPmMCTPxaX96jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2vA4mWuK67pfUjv0phfrN6+VEK9IQ5fKe2u0rvuFFNc=;
 b=T7FunfcLNZVFJ/5nlg/lByi6Tc7c/uJeRECU2zECHX0/iJUsAgHpMq9JxW+DIPUg8FWC13qBdtxRFtKmj6+QwK3ihVhcA+ZU/IK5qs3aq+VSP8qc7nuZzEKa1YzUwQ5t6s0bZdPZva5xnOs/k3MJxeqz5G9MJa4DUtrc84ooKcJv6fck6z3XUgGhrWiLhZv1LBYMp8scW+w9tPY/+E+m6XuBgnoObzVAA2LIhIl1zJ1yQl9w6/rtT9L4iRfxVekuX7mbZ2HbPPwR9bqZIz3FERs2cybHoaGCM2w0Ev0CBVIb6fLKzVcx0YXb+2DSLLMaHlf872sHTvCjxmOqSR0BUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MN2PR12MB4046.namprd12.prod.outlook.com (2603:10b6:208:1da::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.21; Thu, 7 Nov
 2024 13:37:27 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 13:37:27 +0000
Date: Thu, 7 Nov 2024 09:37:25 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Uros Bizjak <ubizjak@gmail.com>, Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>, vasant.hegde@amd.com,
	Kevin Tian <kevin.tian@intel.com>, jon.grimm@amd.com,
	santosh.shukla@amd.com, pandoh@google.com, kumaranand@google.com,
	Linux-Arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH v9 03/10] asm/rwonce: Introduce [READ|WRITE]_ONCE()
 support for __int128
Message-ID: <20241107133725.GD520535@nvidia.com>
References: <20241101162304.4688-1-suravee.suthikulpanit@amd.com>
 <20241101162304.4688-4-suravee.suthikulpanit@amd.com>
 <ZyoP0IKVmxfesRU8@8bytes.org>
 <323dcff2-6135-4b8a-85db-bccc315ddfdf@app.fastmail.com>
 <CAFULd4Za4BQL+h9Xmra1TjB2oGGzPwru_y1xOrrAFSg==bfvgg@mail.gmail.com>
 <20241106134034.GN458827@nvidia.com>
 <4c9fd886-3305-4797-9091-3f9b0b9ee0b6@app.fastmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c9fd886-3305-4797-9091-3f9b0b9ee0b6@app.fastmail.com>
X-ClientProxiedBy: BL1PR13CA0288.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::23) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MN2PR12MB4046:EE_
X-MS-Office365-Filtering-Correlation-Id: ba8bd71d-7d3e-49a7-2e81-08dcff3151a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LQzONdTKcmJuM/3Sr2Zqp1fzVZV+JHBJoNsTei6z2cK/qVVpLNkkqWimlq4+?=
 =?us-ascii?Q?4b4EVOtbJXSdGolOdcrpirDssFs/B3FQVOeeDQ+mKc6z+WFWW/GmQADN6vU8?=
 =?us-ascii?Q?6LAOt9ZAMqxk/i9DwiehoWeD9bLXsdmSjxEFzMwqBCmgIbSfX4++8FS5zZsR?=
 =?us-ascii?Q?+2aVU+y0TghbryUMIqKyyBwkMqZH3Z9cyjnmtL0mrkjcGaQ5zWGAFRbJqFH7?=
 =?us-ascii?Q?ijzPgkXd/IquxaB53XGzk016go1VO/x/PZX5m8hymlZ6uzGATPKaydkyVTu4?=
 =?us-ascii?Q?zD3I/RI3ylqCvZuygd43CFR3h7Ntn6dT2yEDYqYhf0NT11Xvho2i5STYQhug?=
 =?us-ascii?Q?YmID9ftP32zO3M5Bymu5EqPvq5TOqvY6Jw3wWcC5CMro76keueUxqJ1oqM2G?=
 =?us-ascii?Q?WrYu8LRSkddkaaSSHF01hJ8yLkjkLMU6p4sfN92OAldljtptfQmF4EgMMaOt?=
 =?us-ascii?Q?dSTVv2IfHr0YvPdzM0rD9+X6yDv9eNEEuuaHLOzXlTKjUSNYvi+YiXePLKfX?=
 =?us-ascii?Q?9ACxbpXigfRef4U0XMQoPAFjsjZF9p9yPUM0UmeOlXbiGWmOPWEoIgyICf0L?=
 =?us-ascii?Q?SU3VjsbzlfsAGIp6heYDOe+9lGuo24KYH/uEKtHBC3cRO55rZYsTWGeolIt2?=
 =?us-ascii?Q?9eJEOxx40mRdyhNz0Ge2Mc/86upelY22UvBodKS926N83xjopgmq2ivCXIHr?=
 =?us-ascii?Q?1pDN0hB7BoL4yre5ubggZltPOw6423AJ25IJNlK1almD3B0iOaWB2h+3PDEC?=
 =?us-ascii?Q?Neva223lJRZfl5rTmDWro1pM59Z2TM4aNTix9CAwDpGvYOav9xIQK0pXixXV?=
 =?us-ascii?Q?6vqCR1+ZNN63D4iuS1B2ERZZwbSAgEx38+T/qd9QfRa1aalQ9Blj3Tqu+UcT?=
 =?us-ascii?Q?e5qvL4BZu4/oRKxsErf3BqXJWQXvxLI2fcicakr2ZyScAzAsEteQPTDgdnRd?=
 =?us-ascii?Q?nUBf+Kf/UhReYhMQk2tpAI5tsjws1IUm89KNaxAuaI8Q7i2qdw8Lsxewjq7y?=
 =?us-ascii?Q?lDoEwAWWoaXFDjiC+xeyPE5gwHaMigMlMxsKzVVQWdqPjEx7ShHyOzHAJe2a?=
 =?us-ascii?Q?V87PYdzpQYtaSNe7lQhbfKkw6kFKr4SEHwafi0yR0uG6Zr7P5KMm4/bErh/f?=
 =?us-ascii?Q?x3WgDlQUZWrOix7NIFP/MtxEi5oTwy5/pKXrNEimTduddqDlsdYVxMUDiz11?=
 =?us-ascii?Q?N6EZ5jiCmPkmom7VCFCDZAtMWyYJDp+ni50hSWg1CMDVJzz5Bi+jxqif5M91?=
 =?us-ascii?Q?BwSbup13ZKQXZ8axvlfLvXI+yiRu34OrbuFGdt7xS9LFh4jiCVYfIPN/6Wxd?=
 =?us-ascii?Q?Uny5TcSis3InArNBJqZRaXh8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Af3yTwlmTFuVZggiIqdPchwcmSAsJI4VeSjYprMVzYH32fnsXS/DuDkUvqnV?=
 =?us-ascii?Q?iRHdRY8rPd8c+ticSDtTWLlGAqjaYbYj1C24z2srY8aRVqckPrLWVN6IBgsW?=
 =?us-ascii?Q?DcsexD1TdX4SPnGQDOt+/St8EePCsR2RQkzdOJrZMS0RM5Mvm7MHMDKm9LBU?=
 =?us-ascii?Q?FoaMIjPcRxaE/VZ8c2BsHiuNI9EQpPH6E2Q6ngCy6ZyRNgQft5PnMKhSnL5S?=
 =?us-ascii?Q?g2BihH09bByPyigWXio+EVBfN1iiuHM91y/lUgTsY1PNDCwzJizJOk2TEaHq?=
 =?us-ascii?Q?xM+WEzXkzFwBQ0A4Oye6zwKwaJ7kuwZ4Q3/mmDwOWSy3Xwl9V+nLo1c+o+fm?=
 =?us-ascii?Q?1NEQyWMycwBEEOiZPfUiv+PY9erDsRsPUMFy6DOxBzFoVEh7WEe423+xEyt6?=
 =?us-ascii?Q?QRohtl+nUDd0pFUNvbbWXu77Dn5g878e5pv3ImkvMlVEEHiblQ4q9iwnknhe?=
 =?us-ascii?Q?Bd13gWS+uINbP1y0CetJs58OKobyPC9fREQ3E364CgPASuasstA5L1GN2qUz?=
 =?us-ascii?Q?TNn1r4Yujt0Kci1NTpCLbqnSjlxW+wD2iZsStmoL7ZQi92JStXiqp6guOPU5?=
 =?us-ascii?Q?dOEq5XjQbiv0favzKwvec4KIo1Auyf6x73e3f9YsM1fk0RZJeYf20UXOEHqT?=
 =?us-ascii?Q?upEpa2d2E/A1QLzLVkaE/ZfO0yMIDiunvzu5V5+u4TwYoyg0ifAy+BO1B8/m?=
 =?us-ascii?Q?q+Y6gy6/7qE8yTYIk/cOUD/zxwbknLtPKfCacrgrC5lCIWCiQmH9M34Arllc?=
 =?us-ascii?Q?lrPUFPRA9ulkrFGqqzKwgImIO27h0UCdDvVti6daPWuY1ib+zX8UWz55+6kV?=
 =?us-ascii?Q?gChaGRIQBoYiSukoard6zSLiG+ww8f3PWJ8QhFZ7EI8zQ0HOrXwgBtws1lmi?=
 =?us-ascii?Q?ZIunvPhcM0qaDYYnGl8eOveszXSH07g5TXaYRo6nP33ynYYMN6K68T3NstUq?=
 =?us-ascii?Q?hz/45jc7Fhq94d0BNw/0lUGOGb80ltr7QRIR95NJc8C7f6Cp9/vPxEyV/W9x?=
 =?us-ascii?Q?MLT0kDYFlzPwOf48fD3sgqbGXgA7GKIySoa1TqwZQCQw12q8wVE72LcGVAsz?=
 =?us-ascii?Q?2v7NhNgM0PqsYCPaEnAM6O4ly6oG5nMl8+HXpQPo87JUc9nsMsb4jaWmv3Wi?=
 =?us-ascii?Q?ytfCyjuK3XgCe5lwj9aw902LA0s5Ki4UQdD6rcS4mDVIar5jap7B2eZHo7DC?=
 =?us-ascii?Q?9mBeLIw5ZFzzSsm/eVSkFNZrbo3e5+ETUz+UIA0zJmU8WL/JZHFD/iribSHq?=
 =?us-ascii?Q?QMyDlaS3597RwecaaiD2d/WGGQ9Be395gzLx6dynDx5oBALUMtM3ibwH/zQl?=
 =?us-ascii?Q?G6uAhL3UnrPzJQqDfy+uB4s+Z3u4PPf/3ut7XNsRzCD1dq6+qMuiZKMjWmsB?=
 =?us-ascii?Q?z17iELwMIdcky1Wfpqktq/bUUuxQ3yo/b94QzIvKNe+j0VUabRg1vhmBQSkZ?=
 =?us-ascii?Q?bBvdgQ/FRwCvoh/88OZ7TCj4XMoqDtq5L3AZUcybpnUCLzjnmEWQg/vIZqnC?=
 =?us-ascii?Q?AfYXg3MBOxZQivshr0Uh8BQVD2VPvUvuRQGyWTlHzKRBsWsI2DJHYOLXEoox?=
 =?us-ascii?Q?aTL9Ukf1MC3T6suJG/mjok1/N+j9MFrGJTsWW+Yr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba8bd71d-7d3e-49a7-2e81-08dcff3151a3
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 13:37:26.9783
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 02KrXh4AzqUADFqp0u6VcqUY6p/npAVwZktKxFov3hQD34+fTxw6AGvXaxFL69YV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4046

On Thu, Nov 07, 2024 at 11:01:58AM +0100, Arnd Bergmann wrote:

> >> and later:
> >> 
> >>  * Yes, this permits 64-bit accesses on 32-bit architectures. These will
> >>  * actually be atomic in some cases (namely Armv7 + LPAE), but for others we
> >>  * rely on the access being split into 2x32-bit accesses for a 32-bit quantity
> >>  * (e.g. a virtual address) and a strong prevailing wind.
> >> 
> >> This is the "strong prevailing wind", mentioned in the patch review at [1].
> >> 
> >> [1] https://lore.kernel.org/lkml/20241016130819.GJ3559746@nvidia.com/
> 
> I understand the special case for ARMv7VE. I think the more important
> comment in that file is
> 
>   * Use __READ_ONCE() instead of READ_ONCE() if you do not require any
>   * atomicity. Note that this may result in tears!

That makes sense, let's just use that and there is no need to change
anything here?

Uros?

> >> FYI, Processors with AVX guarantee 128bit atomic access with SSE
> >> 128bit move instructions, see e.g. [2].
> >> 
> >> [2] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=104688
> 
> AVX instructions are not used in the kernel. If you want atomic
> loads, that has to rely on architecture specific instructions
> like cmpxchg16b on x86-64 or ldp on arm64. Actually using these
> requires checking the system_has_cmpxchg128() macro.

Yeah, that is what this series is doing..

Jason

