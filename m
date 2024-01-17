Return-Path: <linux-arch+bounces-1387-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 539EA8305A7
	for <lists+linux-arch@lfdr.de>; Wed, 17 Jan 2024 13:41:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E53B828401A
	for <lists+linux-arch@lfdr.de>; Wed, 17 Jan 2024 12:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40541BDFF;
	Wed, 17 Jan 2024 12:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pKT0vqCr"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F55E1DFC6;
	Wed, 17 Jan 2024 12:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705495303; cv=fail; b=Fq+YBe0BfRcmjkQEz/25Ke7UZD6zW91DNt270U1XLDOAcMK6bik7mz8CfPaCr4+Hu4LBYuOdfGinp127Ek2ZPmeizm9+Vgq1Ra2sb9h5C9hyGmW03LZ5BZSBEvLvr2lSHUFoIV3x6uqjJ3IsBoEYFNo79AlZ9Tt4HFwwY4/Y0Us=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705495303; c=relaxed/simple;
	bh=w7IJet7T2djpQa2CyvZ6r3JV2fmN9pyPSSxx50NqnLQ=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 Content-Type:Content-Disposition:In-Reply-To:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=q3IpTFtg+y4MXsuV3Cg03W0KKDeA+4DSohtsDM5G+mNmQoCPWHetlYbuppLZMQtS01h1j/+KdJX2M2Tf7EgMsm39mtwhtH1YKPgMOB9DubAMfrF6otdcfICu7lVAZklN/1O8Gljxt5meKC2lV0tPBV4CmzUixKNrgW8cUlX4DxM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pKT0vqCr; arc=fail smtp.client-ip=40.107.93.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mselT1hkx/cNTF63hqbO7NFFRzdDIRx6lxP7D9yKJxayQsdSoEh9rozKWSRjd0Q/5xyRAsGgqyvRJkkzj1yPaFQU0GL7jYRoQvQNK8W4qo1Bl13A/hfXMkaHtj+vTFiPDvkBGcKDsTqiAdPXZ8Ghyob+xs+E4IQ/npu3x/92e+KDRXxn3hg7U16Es9we7ol5dqqyQGbygrTV6CKSGx7catnxS/X733ErYgAD5tT9e2u4PRRhNQtOjsLXK7iHWKfZMsJ2hz9Ueuf8+DmDSfwOatTkCPWyPW+2Z9YHoMHyZepcJkmg47ByjLrUpsZC+YsHgZpkKscNtEVMiFoESslFSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sx1GJxyxoPskmyXIukqiGZMnmMBy7OpbZnYWkFey3Vw=;
 b=oSKrKU9HE8KsfcQiiskiEvcoKrnHKJT8VOTRX/N2x32s9UKhf74va5BXHk8ijmmuI4wHkkz58aEo+weWCT2RFMNuRQEhCYla95FWORBnGXdSAuHtl1YVYm+ZP5lLmz2BwwkjL5tuUGQ9W2xIJOU+7G9XCSM7k4882VwudfMhMjnHiJc4TBM7AtaOB1uWmUce/hNudLsErPOWm4LDEDhTqgypTl5HoW4KOIK4X1RXyF6dg15G9LSMOhrcWCcQI7f/d0JWU24hLma03sP66/wl6dMDquD9kD02h53f/qQh/tSzNAMYsUQlojGK++AO1LJyNle2ILAn4bm0dnTkooGg2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sx1GJxyxoPskmyXIukqiGZMnmMBy7OpbZnYWkFey3Vw=;
 b=pKT0vqCropXz2AWT3kkExhdfPtp7ZTVWWUs/dB16Fax5hS1LpWqQJ38c5nCrcYLYKoa7BNaAS2oD/gc6pB36bM4nDIVo0RUH0y8Q1ybmIQN0RMqX/obtfHqlkhlZ4CxMQ5memcDCw5tCmVKTU0DaOI4hZ4FWKNd2X83R9Utlu7Y6O2r+z8xisw6lD4aCRmmG8fmGdhqvfNztwMmKGBugHzhWawuxQ9uhKR1avJRkUw+T4/Oo3dzcowqMiSkm03qjSnNPRoSQSItrEFqkafQ8ZLJo3myZpIPeM4doxKtxlVzkEgBc91rPMJo0uPbjHpG2ziZYXm+f6yo/j9ZYzlVPdw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ0PR12MB8137.namprd12.prod.outlook.com (2603:10b6:a03:4e5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.30; Wed, 17 Jan
 2024 12:41:39 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873%6]) with mapi id 15.20.7181.020; Wed, 17 Jan 2024
 12:41:39 +0000
Date: Wed, 17 Jan 2024 08:41:38 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Leon Romanovsky <leon@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rdma@vger.kernel.org, llvm@lists.linux.dev,
	Michael Guralnik <michaelgur@mellanox.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH rdma-next 1/2] arm64/io: add memcpy_toio_64
Message-ID: <20240117124138.GE734935@nvidia.com>
References: <20231204182330.GK1493156@nvidia.com>
 <ZW9cF0ALVwgvcQMy@arm.com>
 <20231205175127.GJ2692119@nvidia.com>
 <ZW97VdHYH3HYVyd5@arm.com>
 <20231205195130.GM2692119@nvidia.com>
 <ZXBWXodu2rxQ7Szz@arm.com>
 <20231206125919.GP2692119@nvidia.com>
 <20240116185121.GB980613@nvidia.com>
 <ZafISDVeAA1swx2I@FVFF77S0Q05N.cambridge.arm.com>
 <20240117123618.GD734935@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240117123618.GD734935@nvidia.com>
X-ClientProxiedBy: BL1PR13CA0306.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::11) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ0PR12MB8137:EE_
X-MS-Office365-Filtering-Correlation-Id: f962ee7e-4051-4f4f-d832-08dc1759a647
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NCUeTRRU3+8tJ9OqNPcazxuGYtXN4R1HWpnlzlE+8pNitFMRKBBI1v+R2fHCXZVQhpq0f4rQI09FTPpjFX8r+qiaZ9wKQmkqxiB9154HDnl7J5okje/rb4Qq123EgwkUtSRU7FEnFKOyhZxm0sAMKDLMCEmefZW3ACAiFDOccHgDV7VR+k2tJlgA6rDPeyO1Fi1pB9AVf3/O/CxhLPfIa4S6h++i+O+K2E1JEM3OIqE15rEFt1uEzEMUOg0GqiVCaOft1Cz7zrHsEVrZfGHpHCAvq0P4ACLmwvJF1zjktmPnEnQXmaoqcDc1qY7pXZK8o7LajFdlhi17TwLdNWlyyGsZRVsjpdX+4rYp0V8FDIGYdEn/1WqQTudV6PXWBkLtdlj21oK7pHCyKa1P1dxzgwqHRosmUoAKv0d47/4kp4ivkjXIJKUgdudRrsPzobJbj9oQjAAnk4FSytQjIq4K2oy/e4Amx5oRroFXelNvgUNGSlxMNpMeP0sHu+ojAGLLNKKlKppeq1lLbOObnM7autZYCVwG5e2cPfKtJegMPUSucRZwoKSEq1B8A+OVEJjxb64bAUIJWJ6PLDsnoqI10tBH69BDXa9qs2OWsO1sl6U47PEhIlViPzQc3jt2qSbd
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(376002)(136003)(396003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(6512007)(6506007)(26005)(2616005)(1076003)(38100700002)(33656002)(36756003)(86362001)(41300700001)(4326008)(6486002)(2906002)(5660300002)(83380400001)(7416002)(316002)(478600001)(66946007)(6916009)(66476007)(66556008)(8936002)(8676002)(54906003)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wl1oyj7IxWhmTuVEX+2IYivE2A0Iq/7dm552tBRzAYgS/BCbRenPOEjoeY6m?=
 =?us-ascii?Q?bbC6eulpxFsc8zKjY3E34aW3hQ6pvTb+RMTPgSG4NN+9K5+q+2rsOO/57Ebv?=
 =?us-ascii?Q?8bRCBAphALbasNOF5Ri5d0HdAVZpvn0jUzpIbWg3FBO1CVuorIDEBsXp05XA?=
 =?us-ascii?Q?GI16OUqUVWiYIdFkNwI/Pgtivbe4F4hznRTd7hXVmCAjzNQZUAd/uHsUN+1V?=
 =?us-ascii?Q?LtgaEaQK0j/EVK5WJeNjUcKV2fTDrMDzOCsMRn0E4D5Crz57GBg/Ukff2Yr1?=
 =?us-ascii?Q?eD4+kPSNVNXC8qwqiWbdvmsre4K+g6aehxKu0EcqoUr04GturslyFr38guRm?=
 =?us-ascii?Q?mnxQQvDuQOE5wJG1vyhrSzxMGBkc9jNqwCpjFuL/CQaCz6SE6eOrlDPabu2H?=
 =?us-ascii?Q?v51gt2cffPmWn3GTORyy6wsRd1/Zir67EseXWqXr8ahv2/j7NqYdVygohaNU?=
 =?us-ascii?Q?EqqSufQUgRgqoQhiXiRjBCoHlSv13Vyu1Jrx8l3VoeSgsDfSWa4c85yRdDMe?=
 =?us-ascii?Q?xSYOUwTaWF0GdXN3YHclNWEdwWtKS+XVlMl55AoHTQDKCx0011RgMNtxCQ6M?=
 =?us-ascii?Q?cavr4pGfV3is4z9yU7MOmSF2Ft+PHV9piSZrafVBU51W6eUPEyYK9kEUjhjQ?=
 =?us-ascii?Q?cXNOQH7xJX3Ur5AFbmO2m0C0L5lM660K00ZEF6xRO5atRHLpTIS2HcCQjn8J?=
 =?us-ascii?Q?IhNtBInX3209Vlf5RPhajoVH4oTrhqxvdQVvz2AyATaTW/qha6wa8Ppl1tUX?=
 =?us-ascii?Q?DLhGeNyxrCUzoyOSGe6Yw5Uv4S3eP4xL8JEfVgLkUWTUbBbDIF73vFVdReXK?=
 =?us-ascii?Q?eo+5v4TMxkDMHgeFXMH93cfuvNarXnxj3Kq3B/1D1uoxCYS5ruTRoS5YzTk8?=
 =?us-ascii?Q?YZnHTF179F+VqyU6afHBmnSU5LjkPu+1iZIuVkyGIcJGvXEM17JQZkhRIxtL?=
 =?us-ascii?Q?3zTyGSTayGdjC5TDbZkgcgdMywGLWMxkyyQfkPzATwWV80zD20nKvu3DUQP2?=
 =?us-ascii?Q?iDo8SlcxCJr6hHdeRUvW/IMc8Jf1oCTwFlu+9eVTMRd1HpJXGBQPXzdtsUEG?=
 =?us-ascii?Q?pQ0U5+YjsyrgQXf1pR1DUQv0ORzfmaqi/ddFqpeI28deu5JMiUKnk+nxTJ0Z?=
 =?us-ascii?Q?JDs9vApzLJSg8KAdkNGXNcRqdfB0KtRvWWlzSDlZdhiH6tDNm0BxJCThPmqK?=
 =?us-ascii?Q?0e6MqyjJOe3JaX0lSGYX1ruLRNXKwVFreKsLxH8jaqpJOQOsoPDZ86Gb762W?=
 =?us-ascii?Q?8Vc/1CV5Qx62sFh+Rxg8/bINRRcg64FmwyKqRhESPaJcCFKj8HPm4mhxWmfM?=
 =?us-ascii?Q?9akp2yul07c43D+G3qBjTI2Rsh8pzimuZxd/objdG39e8w1jxUsBnqTh+KWG?=
 =?us-ascii?Q?CU27UzqSF+Dr9+pVSwBCfMNtNASksJAac8QXuG6oRZR6B3OmbCm7Gtc4+/4F?=
 =?us-ascii?Q?OMtG0EnaUmTjgExg1NkSd4jmc5PZwvYUs0EukKNXK2SAfhafRIkSNAWwqo7X?=
 =?us-ascii?Q?wJHDm7hJdBTzXplFXxOXCu463UKrZQdc3wqV3pDghuu+iwG8WVKADp8U6AvL?=
 =?us-ascii?Q?TNf7ZHggPgQC6dSEN18cyTWK1UA9zTrzrsH5Apxv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f962ee7e-4051-4f4f-d832-08dc1759a647
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 12:41:39.0353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TsdkoCEPC/5DnMrx5OxF8l6o2uO9WOc+PI5gS4+jXqyyTVntecNGaEqoWNzzaD9J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8137

On Wed, Jan 17, 2024 at 08:36:18AM -0400, Jason Gunthorpe wrote:
> On Wed, Jan 17, 2024 at 12:30:00PM +0000, Mark Rutland wrote:
> > On Tue, Jan 16, 2024 at 02:51:21PM -0400, Jason Gunthorpe wrote:
> > > Hey Catalin,
> > > 
> > > I'm just revising this and I'm wondering if you know why ARM64 has this:
> > > 
> > > #define __raw_writeq __raw_writeq
> > > static __always_inline void __raw_writeq(u64 val, volatile void __iomem *addr)
> > > {
> > > 	asm volatile("str %x0, [%1]" : : "rZ" (val), "r" (addr));
> > > }
> > > 
> > > Instead of
> > > 
> > > #define __raw_writeq __raw_writeq
> > > static __always_inline void __raw_writeq(u64 val, volatile void __iomem *addr)
> > > {
> > > 	asm volatile("str %x0, %1" : : "rZ" (val), "m" (*(volatile u64 *)addr));
> > > }
> > > 
> > > ?? Like x86 has.
> > 
> > I believe this is for the same reason as doing so in all of our other IO
> > accessors.
> > 
> > We've deliberately ensured that our IO accessors use a single base register
> > with no offset as this is the only form that HW can represent in ESR_ELx.ISS.SRT
> > when reporting a stage-2 abort, which a hypervisor may use for
> > emulating IO.
> 
> Wow, harming bare metal performace to accommodate imperfect emulation
> sounds like a horrible reason :(
> 
> So what happens with this patch where IO is done with STP? Are you
> going to tell me I can't do it because of this?

I should also point out that userspace IO doesn't follow such a
restriction since nobody ever knew, and things like RDMA stack and
DPDK use ST4 and probably other non-trivial instructions for IO from
userspace.

I'm fearful you saying today's hypervisors don't work right on ARM if
IO is trapped, which does happen for some legimiate reasons and a few
illegitimate ones??

Jason

