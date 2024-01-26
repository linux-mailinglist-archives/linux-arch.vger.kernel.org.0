Return-Path: <linux-arch+bounces-1721-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A52583DD61
	for <lists+linux-arch@lfdr.de>; Fri, 26 Jan 2024 16:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E682B1F219E4
	for <lists+linux-arch@lfdr.de>; Fri, 26 Jan 2024 15:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926551CFB5;
	Fri, 26 Jan 2024 15:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uBMc/lPd"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70561D53E;
	Fri, 26 Jan 2024 15:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706282669; cv=fail; b=if2DIh1YLkBE14nLqIu6dHs9CnQPsZ0x6jqGwGU14xs70F9r0r/les9OTVv3GIc0Ck5AgewxMwc99vlBhid9jEQf33bIGnrjUJts2UEwR7ESGU13tgKvrm0AuTguhtgItm/D1hr+44j8SOjuRVVfDy4RtVDzVI3SHUoVEcoxGe4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706282669; c=relaxed/simple;
	bh=I9zOC//yzcLmaU+ytY+UC9bZwgB6mCIY47S5Pa8FdPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bUSRh6N/HpnXkJ4Y9x015lVgarPsIrYjXZamw/ZIf5DLC4GxDxvrHkEXFNHHc2pCD8Z8R4qBqALa/ClRDixL7TuLx+yoxitBFO4kydbPiCfgzbHzvVUKAmn1KsX7Yb5k8a9u63wEEdFckqNtkv4vlfkNDhkRSdmNMex1H0/V8rc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uBMc/lPd; arc=fail smtp.client-ip=40.107.94.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TrnlJN+yeJ56Jlza4QXlxOLiO1n5LSF2bBn05wlpPOM/8YfI7k7nxvNNqB+tXk6ak3/NIjjcDVkIgG5PyIwieA3+P0/VRgwmkvLW45y/JfqpX/lmTUtcPdUp32qCyq8M5gSTVj+PUGXXf8ggClHJeq1NXMraupt+No/SDG4xL9IIcG7MGtg1duXy1d9mJAZAVbumug8X9vFtSXPwmw/TcsKITt6lHKbYbgkHbKXki+a0wqVxmuLg4Zr58mmpt9dYG3e2ADRnyK2QN5XEtmr/Co+0TxsZG+U9suMBYQIBjsMGk+ZM+lzCZc8zjIBTNVE8G9lJZzUenATZV6WEyFhR0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tcj4tqaL/OYpYBUIzsT7N0Wteo0h2I9hQNcSl/KCg2s=;
 b=HiDhBv/n1sma4kW1mwWRa7B2SSaMgB0dewAZgvohsffp3t42Vb76hqJydi1m7FqyR+oXNJQ8rRHC/HD4LzA3grwMu/BpdAS+jearGr1Hn7dA6NnTWEYKt/kUCEK1+Pd9tcn4u5NVzEo9iXcvF3JYywY7KonKisS0iaxyHsHQ1nicSndm+f+ge6+71QKJYyh5Oj91Y2bjgP7CIY8FLvZS17uVVjDoeU2N0X4His80kD6Z81EeOZF7f3v6rOi6PX2wxapDdYw9XC32JFCmn2KvPMdOPJGlpTnIIUzeCOkYbzZxoJqU4icxUpRDwUfs6qL5A/wkP3IeHkgj0GKiHXLxSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tcj4tqaL/OYpYBUIzsT7N0Wteo0h2I9hQNcSl/KCg2s=;
 b=uBMc/lPd4KL+Ix4sUOgXN9HSCeFos5M3fWDGWgrvv4hietmRRTe+3IJ4ipZ7R2ut971x5mnLtagttZMYD9CIzr6WnmCPFg3wvN5IDfixTN4xhykFxWf+A4XE8ylOJY7qI8xsVA0u9OHOHS6g5qRcn67yCtUknOj6XdWbAjthpXTEci7pucqMxtZf4UofFxl1LTSdNt5pk5ALPJxJpUJA1XYBAsSl3pHlizX5U+myGcoYULnsZ9s8KwOClgc+iAWgPBHSenNdxAWje5AsllfA8RSA+no3y/BVFwQIBBGeDVhq0gU0z2hQuGeo3IsZIvvWrayx8Zz/t22J6pC9WFiYXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN0PR12MB5836.namprd12.prod.outlook.com (2603:10b6:208:37b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.24; Fri, 26 Jan
 2024 15:24:21 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873%6]) with mapi id 15.20.7228.022; Fri, 26 Jan 2024
 15:24:21 +0000
Date: Fri, 26 Jan 2024 11:24:20 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Leon Romanovsky <leon@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rdma@vger.kernel.org, llvm@lists.linux.dev,
	Michael Guralnik <michaelgur@mellanox.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH rdma-next 1/2] arm64/io: add memcpy_toio_64
Message-ID: <20240126152420.GV1455070@nvidia.com>
References: <20240117123618.GD734935@nvidia.com>
 <ZafWIsrjvk--JdDn@FVFF77S0Q05N.cambridge.arm.com>
 <ZbAj34vdVuMrmdFD@arm.com>
 <ZbD2n-BKGbDgMfsB@FVFF77S0Q05N.cambridge.arm.com>
 <ZbEFPbT7vl6HN4lk@arm.com>
 <20240124132719.GF1455070@nvidia.com>
 <ZbFHPTUaBmbHYnwx@arm.com>
 <20240124192634.GJ1455070@nvidia.com>
 <20240125174333.GA2192844@nvidia.com>
 <ZbPIH7g2Glh-9UWL@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbPIH7g2Glh-9UWL@arm.com>
X-ClientProxiedBy: SN7PR04CA0213.namprd04.prod.outlook.com
 (2603:10b6:806:127::8) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN0PR12MB5836:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e751714-10bd-4f40-f228-08dc1e82dece
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/znQepC+JTkaJG+fby++vghj8sl+EV5WK2dIeGt5VY0TAc+cR2xEN/YoTr5C/vtNIf08LJGXsLf3GARvpVl0j0th7oHfMLbSSaspFZ52pAayof5UHrfoMAvxL3T4tp3udFghyCaUjPdDHg19NEWOOycFRwSMitFBWPKnr8sFxfV6UqqHNeN+ZCmNFBAl31BL+9qPK9LlmmNbeIWU/Km/RpttdWXfr9K4p6e7rnNYcn/aHmz5XqDzbP4IwApFuOF5gq3WBWv/tUd8vwTAvdqccKU0LUWJWCGXt0cO9IYGfHGwNXbeHJJkgZZL0Bcg9qBT9RiKrGEkSu1h1z49O6e4mXSt50kUJGNs9xSzkFuywMXUCXYSZrFTQ7huq7zW8GSfH5E4ELbgDGr5zCctiGVYD9faeXj3JA4KJetnedQ11bcQHFJ75N4QTLGKGY2xgTDF969t9qQRjY82R3DWQHol/bC/9OAjwRXM3Tc6m0zA3ks8cp9qkMwvd2Zfa6tFu6yxuZsnowfO4DxTEfTx+u2CU538N6r88xala5cIj/jVCoZ0VMR435enN9B8wWjwOZEyCgbwq+jRIVvdX3o13PH2ToS0MQmVjO6tU5urVI/42rc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(376002)(346002)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(6486002)(966005)(2616005)(1076003)(26005)(478600001)(6512007)(6506007)(6916009)(316002)(54906003)(66476007)(66556008)(66946007)(36756003)(8936002)(33656002)(86362001)(2906002)(8676002)(38100700002)(7416002)(5660300002)(4326008)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0rdk/27OOWV8w4LJ19ZBKRvTUA61GmLu7lcLEXT+jp8koKqJIpQY6Z0b/xaY?=
 =?us-ascii?Q?o0Reg+qS93XWJcYKJ+iTix1Pvt+PKXu8rfLL2OUm0H1zGcy/Rw0vXodwS1Hu?=
 =?us-ascii?Q?KZVomEk2pw2yDm8zUuUJdSzrfqT2h1FaBn6/yt3t/cwgWG0bBE9x92Ipe7dS?=
 =?us-ascii?Q?j6hbc8N5FXtPscceakh1exuh1oe5cMTOyzrD55pQcwvvJM2+mpSABP+RRCJs?=
 =?us-ascii?Q?r4zzVLdpA3Rb85xUXnHkfz3T/DKFq9Mzq2wURvJ16YZfMySp897hmEdPrI62?=
 =?us-ascii?Q?mejKsr5vcD8P011MpOtDNi8I4A1D8MnLcRMUtOFOWD0zm32mJALjIWbgplsC?=
 =?us-ascii?Q?Lg87JaKAPjkmPgrQjbm+iDfkpMQbfatPhvrh5QAiPxKjnQnriSV6mN51X9ta?=
 =?us-ascii?Q?Lca4akYmOlSg9TqVOKY/k8IPIERFg3Za2rH3uf2gS1uPioEsTE6ogzdarDFH?=
 =?us-ascii?Q?H0V5vHdrEXiQ53eFX8VWwLPdK4zwjOe4sYFm2tHtjdfPsu6zKX9CNj9d6Pnh?=
 =?us-ascii?Q?1EsUg+FEM8Qtoy0/MNOmjMoaS2xlUnJwmihXGsrqB7qnPR31YjKMNQAElHN6?=
 =?us-ascii?Q?73Vd+7AhbWi44DS0vEpO4SuMQbOVyO3gR16M+NHuSwib28Knp9L31nVPPS80?=
 =?us-ascii?Q?GNk1g5+zRlbtYn0BbB+lgVbWjx7gmNW/rZiUJoF+jYabXrHklU9jCQQqjybL?=
 =?us-ascii?Q?5VEY6OvcbEkfxyo84F1aFIB6vSEKWfcVaCBiDpHQTdS9FsDLpEyZswA7ENhY?=
 =?us-ascii?Q?2YDuHf3KQrxhqUtHPMMdT3m7exKyrPchvFVfDkKJQOmkBlOFoD0cHtoAtzhq?=
 =?us-ascii?Q?yAodVSj4Ch+cKy3+jYgWqzGznvPvV2lCKBFBem4SPtWTdI65ZWYtW8fClfdQ?=
 =?us-ascii?Q?MM9Z7gOO7k7xt9jTCksI4JlRJfiv5CIZR0jpWjOoHqIMH1WiNxNP+1AwO8rv?=
 =?us-ascii?Q?HnYcLGt/6+wJVh7VsjjdpUJuB6COZJVdvOH3w542vjCyY5tE/6aLuB8oO37r?=
 =?us-ascii?Q?Y3BmqIQRQW4v6jinLhAnigiewIFaEAQWdCDPWFpTA4V0VDGyuCheWcJSYCyH?=
 =?us-ascii?Q?Yg4a70YqaMMUcKp+JZRNiLDlDvyfJ38DPIC/M8rQ9+32tf2CTcUorsp0HJIp?=
 =?us-ascii?Q?1pbKMBSAvozUtf7/7pXwR1u8ahUFdEHtHby9fetw6wIyt2jUM/qiTv8j2/5F?=
 =?us-ascii?Q?YnfM+FQSFxB5dDQIp4bO2hOOXSAxxCidZ5fO/mQHlLgn7sX20P5vjeAcfxXz?=
 =?us-ascii?Q?DQAs8uqjnZ24vcy90RxUssuSFFrQOF9usf7O6Q6Di60sifE9PIk2qA5WZ0cS?=
 =?us-ascii?Q?Y7OYvKWcXoOA22m70Y7yWa69NgPU6euojO1EnV9rUm2sBJqnlDqBhTqezM5T?=
 =?us-ascii?Q?KdEghso5J3jlAnUEd7rKJPg0lSB+QUDX2C7IAL76vrCuoET7nR2yQd6pTPxS?=
 =?us-ascii?Q?vCscidOlPS9P2sVjRbcOdnOLI9L5b1Az/Q1Tb5ITrX46XcdXcBGE+y5fSR1f?=
 =?us-ascii?Q?B718GfEhr6qQrFogf03A4mT9hFiXs1LUOTVZlnAsda0lnBOUdOCKqa172nns?=
 =?us-ascii?Q?baq+YYxxn673tHmSEod7n+vtcxeILHg45DqCRgd+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e751714-10bd-4f40-f228-08dc1e82dece
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 15:24:21.3806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OzkZgZ4cfjPBOpW//TI2nuzK38AUhe1xvk5grbleUYojMQF3hJfOWIQmiiL3x8Kl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5836

On Fri, Jan 26, 2024 at 02:56:31PM +0000, Catalin Marinas wrote:
> On Thu, Jan 25, 2024 at 01:43:33PM -0400, Jason Gunthorpe wrote:
> > On Wed, Jan 24, 2024 at 03:26:34PM -0400, Jason Gunthorpe wrote:
> > > The suggestion that it should not have any interleaving instructions
> > > and use STP came from our CPU architecture team.
> > 
> > I got some more details here.
> > 
> > They point to the ARM publication about write combining
> > 
> > https://community.arm.com/cfs-file/__key/telligent-evolution-components-attachments/13-150-00-00-00-00-10-12/Understanding_5F00_Write_5F00_Combining_5F00_on_5F00_Arm_5F00_V.1.0.pdf
> > 
> > specifically to the example code using 4x 128 bit NEON stores.
> 
> That's an example but this document doesn't make any statements about
> 64-bit writes.

ARM has consistently left this area as informally specified by
documents like this. This document arose specifically because a
certain implementation choose an architecturally complaint way to do
write combining but it was informally decided that Linux upstream
would not support it. These gaps were discovered during DOE's path
finding Astra supercomputer program about 6 years ago during testing
with mlx5 devices.

The document was specifically intended to guide HPC implementations
expecting to run inside the Linux ecosystem.

Based on all this I'm not surprised that the ecosystem has decided to
focus primarily on consecutive 128 bit writes, absent any other
guidance designers are following what information they have.

Jason

