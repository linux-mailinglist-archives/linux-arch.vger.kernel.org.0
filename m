Return-Path: <linux-arch+bounces-444-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F147F7702
	for <lists+linux-arch@lfdr.de>; Fri, 24 Nov 2023 15:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B64D1C211F4
	for <lists+linux-arch@lfdr.de>; Fri, 24 Nov 2023 14:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92552D632;
	Fri, 24 Nov 2023 14:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cBhkZENr"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E557B19A9;
	Fri, 24 Nov 2023 06:55:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QRkRNe3UOiGG/2KzCf4ChObk1qsUksjJzDquRg5PdIfklCdSZqLrXnfNpCiQboCqA9ssG4BYiXd9YWYUOIlf3A4nVVsz6pwYLwsYfJqWUbMbM7/sFi+/9+XRIukmOMiksLeB9+k0Ik4Ys064OihEjN8H5vaNUzvWiwgYbVq+ZWa5M5hPy9pCOUg6ZJJtb2CbDrCQ/4LaDNKPAqB1nRMiV9Xua8+S6mOucXmgLTrAzQrDgjzYzvu/4YIGyGcJnOlGLj8WVf3adDnwJmEGkiJ2HadWpnrEm52Q4XAQ2Z9tQSrr6Q3xK7WPL0HX5EoXXAtgxaaUrdIITUL0l10PWptd5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SN6o2r/+NCn4NtNnGuh75iriqBhhEJbvdrYC3D5drlM=;
 b=coDfsaN1+2KrduSubkIJS4Zbglfn+Zmp4sxz44qrOWeFQZQQ3Hhthjhq2N9syb32xzy1yVDvfdqC/1WdYQ0kJjPRN/wpnYu4BnQQDKnojVxBzHxkwotMEqaIypIHNKxD2+qGMri3321hpWYseu7CX6t+F0ZrsLoSVMU/FjYENWrq6UCq2rpa9GyrFNtjVl/KNtnNUL7eD4La4+WwGaqpd8JLBrjR0pHP21rhkMv6pTQw/woeYCa6zaEBVJe13bHvc/eBsznsicQ+q2H49AqJvIiEWXlPscMfY85qgm1nXSPfjK93th1hzcwvZXF6W0qS/rTGcEgeD0eWS3hgFInqWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SN6o2r/+NCn4NtNnGuh75iriqBhhEJbvdrYC3D5drlM=;
 b=cBhkZENr+lExjh1D3EUCHpqrPl4EaEQ/VbqOcPPFcBTYBloMPa8Jh0q6fM8ZL1ucNA6+28sKMNavqf09E/qXPIYUm1OeImWeCoqb1xLe/AQTdVHgm4pW0qAH3oEAhkZ3tF8RKe9RfW32WXNGVh/sU8LWOYzue7kyo8S+txagJ8I8TblUEPpbufAYXxJVE7azJX9WZEbyqSDnvYERS+wLlvKSUG2n/VqxxihTb2jfpo5421cRhouP4DaD9Ev+ttRQXP5JmA7avC/6KTP1JoNZOjgzS0y84GGeEgNIy1yNvX014CagBLNEwfvFdriBck/ZJyFPZ9A3YaoBZ23CgFZpyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS0PR12MB9039.namprd12.prod.outlook.com (2603:10b6:8:de::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.21; Fri, 24 Nov
 2023 14:55:31 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7025.020; Fri, 24 Nov 2023
 14:55:31 +0000
Date: Fri, 24 Nov 2023 10:55:29 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Leon Romanovsky <leon@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rdma@vger.kernel.org, llvm@lists.linux.dev,
	Michael Guralnik <michaelgur@mellanox.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH rdma-next 1/2] arm64/io: add memcpy_toio_64
Message-ID: <20231124145529.GG436702@nvidia.com>
References: <cover.1700766072.git.leon@kernel.org>
 <c3ae87aea7660c3d266905c19d10d8de0f9fb779.1700766072.git.leon@kernel.org>
 <c102bdef10b280f47f5fe4538eb168ac730d7644.camel@linux.ibm.com>
 <20231124142049.GF436702@nvidia.com>
 <14103e31e0c47c0594e7479126ce7fe34f2de467.camel@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14103e31e0c47c0594e7479126ce7fe34f2de467.camel@linux.ibm.com>
X-ClientProxiedBy: SA1P222CA0021.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:22c::28) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS0PR12MB9039:EE_
X-MS-Office365-Filtering-Correlation-Id: 2288b638-3624-408a-14b2-08dbecfd6770
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BwsPCKP1zdbqYVBWnI7LbqrP18uvLvHCi4GIBU+4Cdei5vOKsMGpdLcDFvLKjMrwIRUOmY09zD9FiRIhbExU/SAzE0CAMk21GGmjbEDbm2rzX5zbmCy9AWRHwFoGunQcm72N5pjvUaFnnU000tbmsbkixLu11UcjVugZlqMiJbpw/PYNMBY9+WRDrpx98W+CY75dUQQzxFGY6VhwrZMQ818BiwzokwkyB0QLDl602WgJJ202axkyxaZMUWVo1Uerl1dott69dPqmvW4DkjaE/uJlIaBJig48lTuiKchRsuftn5KOYXi8eNCiigrpZzme/Z3upwyyF2WcSDNPmcM/kAY4TxjkVAbfCcyF2GWl/8aJppwAn5QwC367lIPLAokYU1vuDNWDfl1DIHnyKjXzscxaaxxYEP9eF4dbf9gI6F8NEmRm/8w6rOfiO/byWmCISU51DNBBfoJhzEb9Fby4DukTjrz5WTI/Hn0+3vYoBU+0xW3FHpI5zNpsLQnfn5/rpcQKIqBwuquytxm8SzAx73Vno3stYeLESIm0t9XaHFGkAUpNR1RmAiWjBpUAn92NlCH8LzawT7o11Tx7WX1KyReC+GZLmRU85eDAXyLN4eTX5pTfla8kmE30fF+l6NeI
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(396003)(366004)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(478600001)(6486002)(6512007)(6506007)(316002)(6916009)(54906003)(66476007)(66556008)(66946007)(8676002)(4326008)(8936002)(4001150100001)(2906002)(33656002)(36756003)(41300700001)(38100700002)(1076003)(86362001)(2616005)(83380400001)(7416002)(26005)(5660300002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RluHG2cMIGkEpMV7HkJtil7J328szD/h0DuD5af8NF8uuBpaIGLyZ4p3Oaao?=
 =?us-ascii?Q?/7eeEC9wZ/h1nQxew5zLFnYz5eoaPZ0BsYwDW2Tzo8RcK5HPd0tBfBjv2KvJ?=
 =?us-ascii?Q?Bgb6Dv+GYpJNJPrNcsvnQxHRoBNYAN0cYNvnoQF15v5g6Lc7D60sneFBjom+?=
 =?us-ascii?Q?6xi6Tb3MY2TBi6rblTnqZNuVga9dCIvRa+cmG22pi5jKxKNRdmpDtTYvtcqY?=
 =?us-ascii?Q?Lq4/vPMUfA6jqcDsYT5P0Gfv0FoTbxH1iOxIPkyJZCFYZ+nX6hPH9ybh9dt6?=
 =?us-ascii?Q?8TzdZtd90Av896jY/t7ldZ5eAUIOaVBOcr5y3ypzZjgVU+LlpG9rD2/XZZn+?=
 =?us-ascii?Q?wp2lS145KAsTeDTDxEtZJKrYtVz40BOaOnqgi+/jjHRnaRBNngiFEDj2HDOE?=
 =?us-ascii?Q?2QvHQdI8GsMErRp9vHC7lkxiZb3r0ZoFKULfT1OQbuku21g+TnnPxS3lvvMs?=
 =?us-ascii?Q?2HLKMqArQ/KzSE8v57ZlUoqYBwSbGGwCXU6MC0e3pLckCLnT8kd1zNYaGr1W?=
 =?us-ascii?Q?ZEDxVzjAt5Mb2O0e4hmWRe6E1CfbCrkLzwQ+zTuEHqfaeeMkZv/cBkwQYqu/?=
 =?us-ascii?Q?T7Lhrs1GjzH4ffLWiJ9mO61OK5coIpyMgVCXoVkK0nEaiFURl2Tc1frtpT/6?=
 =?us-ascii?Q?+s6LZ21+UOwJzWKzGnb2Lbv0k6eQqEIgcsa3Z9BxMpb+ThMxa+lIa5BKzKX8?=
 =?us-ascii?Q?RJRmBVHZhxdkI/KJ2Xq0Fn9FG5/5MK0jdzyVTwq79cHjwJf4ieadcYT7J1HI?=
 =?us-ascii?Q?MMK9EunR0eVYrUNLGv6QVhTldhce47MvReMmKTXrQmAPv4QrqYE47nKt51ti?=
 =?us-ascii?Q?KAj02qrZfZwsGuHTKyyMjSV+RzPJhQsrhpI0NcG++ZqYMBnRwKBb6nOruWXc?=
 =?us-ascii?Q?haHPnkUBL0JIdJdTbDUKTfWI3NB3DXmG2uCMQDJuanGNI+lsjWnL0OX7mFdX?=
 =?us-ascii?Q?9ctKtKTlp4nu1Tf/WLKyM8jh0z1+Me8ZXtA+hai8O06/hln8K8SF8cAu7qMa?=
 =?us-ascii?Q?62GKsS5NbmJ/lzVm//WKvsIjud3Zi8weJ0+KTtAuoGpBkseEhsmNI/LmY/e1?=
 =?us-ascii?Q?wI2uWOk3F6d33H9DXGkyzSn6wPtOvfD3Z0XNdTIIwJPNQNvoN3v3GAkr687U?=
 =?us-ascii?Q?z9S6qAj50cEUuLnu9FaT1pR1ULe3GJIMkWzEEAcP90rlEceOuPD9aY/7Dqab?=
 =?us-ascii?Q?CIlE42zr6FgUJhQDY09e7LG2OpQ++IPY5ubh2JphbNK6/5cCeaBkBVVyAST0?=
 =?us-ascii?Q?gBzEWjfYx1CZQMpzWtB/6p9l/kbyYZkcNFquoMGPK66XfeOgvnbq+KDiKw4x?=
 =?us-ascii?Q?gxInFzdbHHAV77etQdD70fEXsjeIM82JDt2VHAPr5r+qBGe+K8SyPzXZir2J?=
 =?us-ascii?Q?WNC4G+XvgHec9853iauBPPMBiJ3na2W7N9l2t0eIWflm5b3jqfr3S9jd+OTX?=
 =?us-ascii?Q?ZtWSB8MelqkYBl4yvq01EsCrHn+aPEDla+Uvj3mQ2qic5khz6vo769Dk5TcU?=
 =?us-ascii?Q?d1e1+fjmZm8VqM57QkPTTTKly9l4Q4tHpothJykvAH1z2B38vG21dObGIlGE?=
 =?us-ascii?Q?31jHFzrJTB9DkdCCikFHo98+wuJ+Kt6jyMCJfOCZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2288b638-3624-408a-14b2-08dbecfd6770
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2023 14:55:31.0535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q9IgAA8b/ohc7Zir+7X4C0QdMOikTniCJzUM1JHksi5a7OwxspApH2FenCdzDkLc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9039

On Fri, Nov 24, 2023 at 03:48:22PM +0100, Niklas Schnelle wrote:
> On Fri, 2023-11-24 at 10:20 -0400, Jason Gunthorpe wrote:
> > On Fri, Nov 24, 2023 at 03:10:29PM +0100, Niklas Schnelle wrote:
> >  
> > > What's the reasoning behind not using the existing memcpy_toio()
> > > here?
> > 
> > Going forward CPUs are implementing an instruction to do a 64 byte
> > aligned store, this is a wrapper for exactly that operation.
> > 
> > memcpy_toio() is much more general, it allows unaligned buffers and
> > non-multiples of 64. Adapting the general version to generate the
> > optimized version in the cases it can is complex and has a codegen
> > penalty..
> 
> I think you misunderstood me. I understand why you want a separate
> memcpy_toio_64(). I just wonder if its generic implementation shouldn't
> just be a define or inline wrapper for memcpy_toio(addr, buffer, 64).

Oh, yes, I totally did.

I'm worried that x86 will less reliably generate write combining with
it's memcpy_toio implemention. It codegens byte copies for that
function :(

> Also seeing the second patch of course that would no longer really test
> for write combining for us which we can also do but I think that's okay
> and you're probably going to use memcpy_toio_64() in more places and
> there we really want the PCI store block.

Right now we don't have in-kernel performance use cases for write
combining for mlx5.

Userspace uses the WC and we already have the special 390 instructions
for batching in rdma-core already, IIRC.

So it would be appropriate for s390 to use a consistent path.

Jason

