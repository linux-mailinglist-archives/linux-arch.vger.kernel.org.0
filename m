Return-Path: <linux-arch+bounces-1383-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E99F082F49E
	for <lists+linux-arch@lfdr.de>; Tue, 16 Jan 2024 19:51:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58DEF1F2411B
	for <lists+linux-arch@lfdr.de>; Tue, 16 Jan 2024 18:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F5C1CF8C;
	Tue, 16 Jan 2024 18:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mhrcITwR"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27F618E06;
	Tue, 16 Jan 2024 18:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705431087; cv=fail; b=jlznCVD+bTwulHztykuD3q0Q2f6++EM2iWbFp5Fn/wVvnDgnQTC1BLFLSgtj7WcZAVCc+BRit6H2j0dTki97i4ZHJXb9+/lsQk0nQZqObvb9RAtpSBy7QcPuDeq6ny+FbG8TOsCaFmWfMOIOGe1MyroXSB4dZ6SeOnma2qVmPyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705431087; c=relaxed/simple;
	bh=4SYyLae4ur5AH6co9+rKUIGUVJ9nMTFO+AjGNRfVp5k=;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=m25NVldjwk/csnKnHSTEejfYHwJI2+Yx+npa/uDatoIaCBtrsge4LNgjNIajByT3o9HOWwxEpUjMF6OFoeRxGBcqhvbT21rOtWS+igKRMeDwSWOrr1BR0uCP7yC8W7xhNLXJfUchletidLgvg3hIgRqS8LzZ+KS/NsVOS88S/s8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mhrcITwR; arc=fail smtp.client-ip=40.107.92.75
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mJOE1PugYO+le3Tm643yh8saKyXtYK2W6EiFnjWsqkO5Z5fPr0tSyZ2ZKMya1ygRP1/I5t1e+OottTKYMQXvuSuLm9MBHV2Z2CwMuCDrKhjj3sdKqGCD2PUo6mD7aMcBb/lDiBMi0rOvRRFDsAHhyS2QljFer8h9nONekKJ36MmfIRTIt41gJxoxmEYeGV9Oow351cBrG7bKyQUTjWpOyhtqp+scrf84FoGD80TPKX5VGYbyJUjg9ZjclsQIKc3Igw6uY0k6OZC5n6Hhnk5BY0vy67Ey1hRK3HW3ix1xK0Rpr5vTBx05nECZ4QPV1YbnkHREed0NDImw5ycP14Vy2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3usiNmFGiZLs6gCwlCNUZQPmQsp7B9UsD5p4Ojmv82g=;
 b=KIoTevUi5P+kMYReg5TXL8jtYT4nUnl9qlYGudZFttN25p29nNQT00rpPcLLdU0+nWoUEc4eh3Yxe0HvcgC/vk9IrDq5JiqUjlGJD0IWURwkRtkS2U4hBfayjTccwH0VH9EGWNuGhN7pk/+XOSARc6GH7BhH3MNGBr0Yyg3jj8u/Q82dMEhCL1Nua6n2KFZdi3cx3FteD721PCd6xTuSgaQET+alaxHaUr+FcZnWmthwEB2zOQNlUQjyNg/uPaKhB0Iwewz4fILmQZn1pijjt8mmcQq1N3SEovUz8f+BK5aBi6BGxtTZH9Rqn+jPXko/5TxW7ZKoIWVxc0P657MqvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3usiNmFGiZLs6gCwlCNUZQPmQsp7B9UsD5p4Ojmv82g=;
 b=mhrcITwRLoHW26abLYLmHatEuVlATcKYSrR83bC6Mmwk40Y0SA8jyY+rAAbxTsjBtxypd79xzFn2ADBDXFrpalhRVh8j3U2pa0X8tVHN0rMRcV405dv2MWDYciVdzDPDz4zLjO0tbN3TmEpIeDzH4duGD5Yn5c4ATrG0RUqPL7dda7j4f51hIcEOC04beZlSBJnUS08JbeSmzjibqr5b0tnct53oNklEF9NgztceJeD/XvIUgYRKpxiDqxjwh2/9Cl1hQs5gwGxxvM6vP1a34ceUBRsDDyDTvbEc0LUDKdHG7xiTRGG/mlESepM07Hhp6f4K+5KEeh5WPFJHCLl76w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH2PR12MB4134.namprd12.prod.outlook.com (2603:10b6:610:a7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23; Tue, 16 Jan
 2024 18:51:22 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873%6]) with mapi id 15.20.7181.020; Tue, 16 Jan 2024
 18:51:22 +0000
Date: Tue, 16 Jan 2024 14:51:21 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Leon Romanovsky <leon@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rdma@vger.kernel.org, llvm@lists.linux.dev,
	Michael Guralnik <michaelgur@mellanox.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH rdma-next 1/2] arm64/io: add memcpy_toio_64
Message-ID: <20240116185121.GB980613@nvidia.com>
References: <ZWSOwT2OyMXD1lmo@arm.com>
 <20231127134505.GI436702@nvidia.com>
 <ZW4NAzI_jvwoq8dL@arm.com>
 <20231204182330.GK1493156@nvidia.com>
 <ZW9cF0ALVwgvcQMy@arm.com>
 <20231205175127.GJ2692119@nvidia.com>
 <ZW97VdHYH3HYVyd5@arm.com>
 <20231205195130.GM2692119@nvidia.com>
 <ZXBWXodu2rxQ7Szz@arm.com>
 <20231206125919.GP2692119@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206125919.GP2692119@nvidia.com>
X-ClientProxiedBy: BL1P223CA0010.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::15) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH2PR12MB4134:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e93351b-8e71-4155-c917-08dc16c42221
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lT7d2AJ3X+gUbaZagsjP4HmbCNAi1TxhsFAiRlGtOBTR/2eiMXllkfPkRp1EnP54W0i2GBsPfwjbHaoCLOviW3B01w8IwP6trkKRInNFMVHryastb3zFuO89SdJ3zyYD9f7z12S374UE6Jj7dyZIdDYFkWVrg8xVy4XdBGwECRO6ufdkTk9pf+J5+KAF/AZHhD/rcWHnMNcZKOW0WWd8Eal1F6oRSzg/0jWkGP8aGO+VCADKJs0ZEUKAaQzpU+Gn1dLq0gdLwN1Ng2+naJq0Lu8V9C0ZMGxO31idyksmXugbtQW3M8HxFf74j/vqy9yaV6NRiWC/Q4JLnZcuG1YfLdbKtkVSiLdtXhSk5EDosMxF5hz9C15YnsI5OFypcW508SyTmur/13dXWflhvRurWe1uC5tWqS++wNfvi/1xuCw0BWAqFpLl1/s9w4nuTsMYfkWVYROve4yi8BwqNd3t5Vqtff3E5HxQPJ+PCc7UGhVkLg74P0FFwbgTO2LLvAV51ZhbuOS4MVqVxuW0zdKXqN7TRZTycgggrAtonv7/oYjQ6Sbou19AQZFoOcpSJ7aLaqAr8CSShvLthnIfOGC4XgaAHPK1krh7fBuBFZ1CknygNbDvu2hW60LrMaJV4YK5
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(366004)(39860400002)(396003)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(41300700001)(38100700002)(33656002)(86362001)(54906003)(66946007)(316002)(66476007)(66556008)(6916009)(8936002)(7416002)(2906002)(8676002)(4326008)(5660300002)(2616005)(1076003)(26005)(6486002)(478600001)(6506007)(6512007)(36756003)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BLCLtu5xw4CO5lLB8RQhvU0QGY/po1K4wQKzyVOZO6Dj0zuLsUQTSlzI1i5o?=
 =?us-ascii?Q?DaQCRMWOY3w0LqQi1vL/FsV1ATrmOIokK2Ye7j52pQ8/9ud9qW/DcGasw4xA?=
 =?us-ascii?Q?/fNvj9/LCe8UnVFxFrdoZO5/+Fa3Lmza/r087hUhvZeSABtckCiNsl/WLsIG?=
 =?us-ascii?Q?EUP8CWeUSgu6RSU5To35b3WiiH3pIlWS1KwZGBisGx9LHfAm5Y0jag2c/W06?=
 =?us-ascii?Q?4r2ASNubqiCFG8GKn5Ynrr3qhPKQDJkYubPW4kvNLPaAd81HaQoG1z90+NHs?=
 =?us-ascii?Q?7tCDTpf+h7KpB0Xp59xf/JXDGyllO0WEt+m3bFdELL4KWN2ORBhz1ghfsTTI?=
 =?us-ascii?Q?480X9D8GWCcywHzceQS0Ow5G7SWFPpRmouvIZ94uMfHmzLMsRnnaj355Kxif?=
 =?us-ascii?Q?mJ3qdS34e2UNmcG+T+RnMsoJDGAH/4HczibhwT6P1oTBbQqTtslCUtDsmKDl?=
 =?us-ascii?Q?/w0nqcnwEF4panHyVpVSA4SDn+zhJUxqYqGRhWCJYwZ1F9DDzLqeicaF7dV2?=
 =?us-ascii?Q?unXumFrTv2Xc20IscHsK+uyst92jzE3ggwK1OUtxbskbKmPdFKeOyCFe1G/Z?=
 =?us-ascii?Q?KSKZeD3mcgArjQ6w63zmYXFu9zpbWH/P7CL4EspWwvZOWXv5U/KDT/Zi1W+D?=
 =?us-ascii?Q?Cwajf4qnJ2CEyAcir//Isloo4meowxpmVdE8JxrFv1mScyALB0F35GnMAP8C?=
 =?us-ascii?Q?go3IMlKLF/uwBTKPaVFruiWTV3OrIwhL7RyxqKNAIqR9fPGWOJDcE8dP9SHf?=
 =?us-ascii?Q?CMInc6J3VQVHIUzs0Bnl9s7XJ0pxP4uWHeX/k7Pt+yhPuwmcSiCVxLu9QeMx?=
 =?us-ascii?Q?+cujD9RxZHfPK2zcTX/mBnC0CODFP9CmhBNCEIsValD+MAqI9Aj2K4M74pcW?=
 =?us-ascii?Q?Liigicc4MHp4XXy8/XMaR02UlsUJoHsCrSXjpONkITVqiUY8gk7XO1ETm1Ss?=
 =?us-ascii?Q?o3I0rNEZoWXJOA5INVsd/agZutyFicuQmhgaZFuS6sbqHQ3ayxKlgNDDjPr8?=
 =?us-ascii?Q?VjyRA/nk71JONprsNLyJhRBbXQ+MJXNUOQ8Xc6wzAySYiP+MmPOrHlnwL1WB?=
 =?us-ascii?Q?HNB2qs4pY499/T6jVBTovzh2gJZ9zSE3h5qpEfZlPCeaO9/OBGbR8lUKfmH9?=
 =?us-ascii?Q?sedoGyeA33g4W4LhEoZk5hN2L0nZSeSk4SU2GaUA0heIqDtKs9zyGzip6GE8?=
 =?us-ascii?Q?3iSuhE0Ps8GolmnnMNDhkoIUELduAPBHPMJeen0ava/aaMbhYYtabu0T1oY9?=
 =?us-ascii?Q?XqDHKWCq8MFWnm8b0vO8V0L3celFGSXQwN7+TzTvmmWA0X14LbnTYTym3Adz?=
 =?us-ascii?Q?gcfOFIypL6numrBuKEgwl4mUijIkERtig4kDPuIGPB8SMLnh/OVJUgeJjYDu?=
 =?us-ascii?Q?cDEf4VYlXcXPEDoSBbGYxg42sRo0fK87aWjQIxyyRDYoixkLgOj9JYKXk5Oc?=
 =?us-ascii?Q?X1kdGuiFlZaMgfpUFazmGZZXB1hvr8NDwXIMAl83wsWXjInLKKuZu4bNhL4D?=
 =?us-ascii?Q?eojwP7UyeyS321WdqqNG1dZS1MYhGsznPv8me3Iy+O31JuiSqh5QYm4Z5tZU?=
 =?us-ascii?Q?c9CRu77RaUkb48UNsNzwCS1bB+L3W2hoZBnzR4o4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e93351b-8e71-4155-c917-08dc16c42221
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 18:51:22.3345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NYNN4dt3a5DaW4/fYLXcsn81nTtWnlbVlAx82sE+ykYdhStD8qdAnnZEA/BMYrk9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4134

Hey Catalin,

I'm just revising this and I'm wondering if you know why ARM64 has this:

#define __raw_writeq __raw_writeq
static __always_inline void __raw_writeq(u64 val, volatile void __iomem *addr)
{
	asm volatile("str %x0, [%1]" : : "rZ" (val), "r" (addr));
}

Instead of

#define __raw_writeq __raw_writeq
static __always_inline void __raw_writeq(u64 val, volatile void __iomem *addr)
{
	asm volatile("str %x0, %1" : : "rZ" (val), "m" (*(volatile u64 *)addr));
}

?? Like x86 has.

The codegen for a 64 byte unrolled copy loop is way better with "m" on gcc:

"r" constraint (gcc 13.2.0):

.L3:
        ldr     x3, [x1]
        str x3, [x0]
        ldr     x3, [x1, 8]
        add     x4, x0, 8
        str x3, [x4]
        ldr     x3, [x1, 16]
        add     x4, x0, 16
        str x3, [x4]
        ldr     x3, [x1, 24]
        add     x4, x0, 24
        str x3, [x4]
        ldr     x3, [x1, 32]
        add     x4, x0, 32
        str x3, [x4]
        ldr     x3, [x1, 40]
        add     x4, x0, 40
        str x3, [x4]
        ldr     x3, [x1, 48]
        add     x4, x0, 48
        str x3, [x4]
        ldr     x3, [x1, 56]
        add     x4, x0, 56
        str x3, [x4]
        add     x1, x1, 64
        add     x0, x0, 64
        cmp     x2, x1
        bhi     .L3

"m" constraint:

.L3:
        ldp     x10, x9, [x1]
        ldp     x8, x7, [x1, 16]
        ldp     x6, x5, [x1, 32]
        ldp     x4, x3, [x1, 48]
        str x10, [x0]
        str x9, [x0, 8]
        str x8, [x0, 16]
        str x7, [x0, 24]
        str x6, [x0, 32]
        str x5, [x0, 40]
        str x4, [x0, 48]
        str x3, [x0, 56]
        add     x1, x1, 64
        add     x0, x0, 64
        cmp     x2, x1
        bhi     .L3

clang 17 doesn't do any better either way, it doesn't seem to do
anything with 'm', but I guess it could..

clang 17 (either):

.LBB0_2:                                // =>This Inner Loop Header: Depth=1
        ldp     x9, x10, [x1]
        add     x14, x0, #8
        add     x18, x0, #40
        ldp     x11, x12, [x1, #16]
        add     x2, x0, #48
        add     x3, x0, #56
        ldp     x13, x15, [x1, #32]
        ldp     x16, x17, [x1, #48]
        str     x9, [x0]
        str     x10, [x14]
        add     x9, x0, #16
        add     x10, x0, #24
        add     x14, x0, #32
        str     x11, [x9]
        str     x12, [x10]
        str     x13, [x14]
        str     x15, [x18]
        str     x16, [x2]
        str     x17, [x3]
        add     x1, x1, #64
        add     x0, x0, #64
        cmp     x1, x8
        b.lo    .LBB0_2

It doesn't matter for this series, but it seems like something ARM64
might want to look at to improve..

Jason

