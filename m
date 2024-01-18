Return-Path: <linux-arch+bounces-1396-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22DA3831B01
	for <lists+linux-arch@lfdr.de>; Thu, 18 Jan 2024 15:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C76E128B689
	for <lists+linux-arch@lfdr.de>; Thu, 18 Jan 2024 14:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9497E2575C;
	Thu, 18 Jan 2024 14:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YsdmlIuo"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1592625639;
	Thu, 18 Jan 2024 14:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705586445; cv=fail; b=KlEC47haVQP1NojvH+6PbjqploHDGEif22n4X6dnkT+mnTbaugwrZ4wXfnG6M+Bd6lVZyiF+loAq9HgaerL/2K66jTwLPXm35BwlRnl6/KDEt9x1RMMPR1Y1ydvkxOinQ8n7tR2R8b7DKOIPA1J5cAzUIeGO1oUU0PWOu0A9XxU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705586445; c=relaxed/simple;
	bh=Sv5py5Obswg4hRVbB52Z3z9fsc8MLd+H33YQLJh+nBM=;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=re97AfWoaVDoyg+zfjbNjj89TFMdAJMQiWXN6aV+YWqpSnpKjacOHaC8Fr70JBWNnNRRMYL4mBW20aOmErQdgf/GAMlZDsfErSzeOayFFRVHxVY7pWRqnuqh8wAxxCx4d3uKntaehjGiide4cbobRSYyIRUmRqh30I15+RnOx7g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YsdmlIuo; arc=fail smtp.client-ip=40.107.223.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DWsueujLx3hTduZPEtr1akbseHKjCq443tHRlD7HxN7NGBuu+CA/5fqVh3/3Rxb7pMT6U7daOGSmOHYW1jujUyTKZoheKs6J2omLBMUKtYV/Z81iGL7/C+Pnc5pUubmA70KERO2u7dBhCADktLGUElLjEbrOq58leVTn11FnLdQXLn1is0WU1X++b3SDqcdN2NQLP3Au08QjKA/kcV35mObjqC4OmRq29gazHosicZCbvEFsIwFjwmIabCdU8N4+lndtJ8/GA0Meii7VX9UMK6R8bp/SMdZtQ/cy75vz8/2hETgSq3SGGg4UEQxuK0+FtWc050ITvwUVe0NKK7cTrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sv5py5Obswg4hRVbB52Z3z9fsc8MLd+H33YQLJh+nBM=;
 b=g2/7mZC9/G5f6yJUYDnmiEZfvkCGWrSKon73K1bVWGnq5rmH2MuGxUsZH+owDWVBBP5unZmtnSFfYGkDVfmcyddTGm4KRvGV63PJJazbEZarUT/E78Tc4R5W2qwTjSGPjndRo6t6C0o2JcsSUTEmvy6FAGTDxLTzJkmkdM/xZvu2RD2i7SvcutbXr6n6OEUtXkzVws/bbwSiIwwgnCvxXz2F8yypfGeJEM3hTWoh8QCqe9lMF4KAv6F92fOYhQTAO7y6jjMfW7ckeld7cK0m1FQwFs9BVgin2/n4JCulBGAvGqxV7tnqvQ+47kkbfogbjhbKK3Kw2kuxX+QLqOq/Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sv5py5Obswg4hRVbB52Z3z9fsc8MLd+H33YQLJh+nBM=;
 b=YsdmlIuoEqHyUzDqiST48jFMsq0y1TNh4Jd0BoeqZ7LXIz+7V/Pnk6rZICrIRzALs1B9uAUb8qQPJnGz2p/whZgXtia0fn7J3tzcgW8GhdHbUez4H2ThcuMKFRjeG80/QKWDIiOzZ2oGMA+/uzCTQUnkBMGKphPxaOZxiYxVvwptbXXrXT0JuR5E6yeZG8GNXm0fUlUXDCmOMWpKK1u1/8S7G22s1IDFpQW+bNpCOb+OYP+BKeMzb3MqVFoYbde/Ns6cnqfN6KeQROS1HRahcRH3lspvkpmTPefWNIT9SsjJpHjz2A/rdM5xdA60GSYX7tX8oySV7HVHFEfo3Ip1YQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by LV8PR12MB9261.namprd12.prod.outlook.com (2603:10b6:408:1ed::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Thu, 18 Jan
 2024 14:00:41 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873%6]) with mapi id 15.20.7202.024; Thu, 18 Jan 2024
 14:00:41 +0000
Date: Thu, 18 Jan 2024 10:00:39 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Leon Romanovsky <leon@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rdma@vger.kernel.org, llvm@lists.linux.dev,
	Michael Guralnik <michaelgur@mellanox.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Will Deacon <will@kernel.org>, Gerd Bayer <gbayer@linux.ibm.com>
Subject: Re: [PATCH rdma-next 1/2] arm64/io: add memcpy_toio_64
Message-ID: <20240118140039.GL734935@nvidia.com>
References: <b3250b9a9af2f29ee3d06830746fb6e8ac49271d.camel@linux.ibm.com>
 <20231124160627.GH436702@nvidia.com>
 <637dcc4d69c380bd939dfdd1b14a5c82c2ddfaa4.camel@linux.ibm.com>
 <20231127175115.GC1165737@nvidia.com>
 <002043477bba726f7dfb38573bf33990e38e3a51.camel@linux.ibm.com>
 <20240116173330.GA980613@nvidia.com>
 <ddd56db15bd2c87073a2f839e06cdb80d693272c.camel@linux.ibm.com>
 <20240117132613.GH734935@nvidia.com>
 <20240117175518.GJ734935@nvidia.com>
 <8e043042f425b4c574d1d3c3ed686253c8cd3517.camel@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e043042f425b4c574d1d3c3ed686253c8cd3517.camel@linux.ibm.com>
X-ClientProxiedBy: SN7PR04CA0046.namprd04.prod.outlook.com
 (2603:10b6:806:120::21) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|LV8PR12MB9261:EE_
X-MS-Office365-Filtering-Correlation-Id: 101f4e15-3659-4bee-e8ad-08dc182ddb4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DMv1BTFSZ0mMb2JC3kF5haBW2t9htX6rzIRhFpFfCIiV0jL0XIp23M0v9PWp4HZJjg3lnOGqZluQh8XoaSc7VC2wa6yjBUzZ2n8Q6XYL1ZINJatLgnLQM5iG/BBJUAdi3fekrn1nPYB5csoc3dfe1ikVK+eRFp7sWU6eln748yi/ZrijWEriKH7p6iRkCk5gyV0uR6C39dUhk1SPT3t+g0s9R/RLe9jPvvVa+a0gKQtqd4tk7YCkR2/HmFhhRbBJxeJyzq97NHGYWmJbRLVke4eHsUVZpMp73mTNw0kRXEKqtwaHmUa4SazgwQ4FyVIWT9n9aHvpzcbBcG4mDAS0k/phNzmhACe7XuFCDJu75Pevzdk+3/x6S8mT6q1c0eUB87Aot+LP8Leekw4SO8WHuILgapQmHc2sfkzqz1U/RXIdAd3+Ya82QVFDCG+dYqRLeiZKeLl6fg7BOHKlvl9HPoxaHo8AOeuf6rfZAfSE3JvG+XWglbVs3Xf2gDxkhgDcio2mnsEn74+ddM96rvJoWBokp8F53Qn7epX/ms4LZuxyroKqLwn6MTPyw/yCXl4SsyUtqVPH7GUrfbIWO7ndwPdkoimvI4ZBQYizCilXiYHETLntNh6ratcRJGJ5sJ3yyHPIt/pJIFW3yVTz5UgQpg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(366004)(396003)(376002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(41300700001)(36756003)(33656002)(558084003)(6916009)(86362001)(38100700002)(8676002)(66556008)(8936002)(316002)(66946007)(54906003)(66476007)(26005)(4326008)(6486002)(5660300002)(478600001)(966005)(7416002)(2616005)(1076003)(6506007)(2906002)(6512007)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nwXZbhz5gV7VnG11cpB2+5MnR70jv5Zz5S2xzZ7LTbH5CIZLzwu4db+kkb6c?=
 =?us-ascii?Q?m74Pe0JNFwRonP8XHmau091MTZnBHhpMd4rh0UMZ4ex3jAfKNnJGz0pHEmph?=
 =?us-ascii?Q?IoYmujbYE2JVueEfkMEMimcZUW/zrzknWd9KG6USmxeuHB5s0CiZ+M7xsrgx?=
 =?us-ascii?Q?ShUBoOoaF6m6TDjUz2ojx+NCmAGT/F88TkXrFOavJjuhpDatVUNZ78f/HKDw?=
 =?us-ascii?Q?eQJL7Z7END5J7PRqTn2ctMvFlsVrwNfEKhG/0eQx1+S3Eoh5VH6tGqR5bKWJ?=
 =?us-ascii?Q?qvRDr1j/xuck+WQCVH9WOKIZRZp728uNbrRGcplPd1LYAuFmxlHxGTjzxeJv?=
 =?us-ascii?Q?7bjHhYHnD4C49gpml1P2kVvLTxaanH/y5/4VKxFdlBoDkUAk6ieoMYxn2a/M?=
 =?us-ascii?Q?4jr3eMNa+xkb+dvm0fB3z8Dtz/OPX1q6IrpB/tdXr0jAV4ED2n6D7c5k0VDo?=
 =?us-ascii?Q?n0fj0CzzuMtukoWApi3XVuTHr9sMIU3qsNWRH9CMw19OBY0G29jyZuW8MjGZ?=
 =?us-ascii?Q?y/xbT8HwaQK22R4rLk+Y/1yXHID8f09g1MNV81se1VacoRz8YA7itb93Mj2d?=
 =?us-ascii?Q?NBgV8LlXroP7B8RxYVV4cCvr/xnIqYvt3//U+EL3Stzt5SL0e85sJHTOlPlP?=
 =?us-ascii?Q?0JvGZ6jMxjWvyp5I4LDi7tu9xcKA+NRhqrZu9Dtknny06ef8ukbxw4F9OR7B?=
 =?us-ascii?Q?Eog4kLsRyyIz9JusLYWOyFDF/9hbIkdbCviJFfLeBvgwmfV4WjwdkiovC6xL?=
 =?us-ascii?Q?SZOTr7n5desY4fdYWiUBpZRVYvmjUlCgeXhH2exATnvr71FRxbe2ASeMHfIh?=
 =?us-ascii?Q?Ve1mHweS2RecPnz1mqVZLui0zJyx2YMduK/hwx1XVTSsr7SxoldIK4Imt6Op?=
 =?us-ascii?Q?k90CvRdyDZoN6BmteLpqpbg+Pi4X9v6SR9GX/ZzCJE2X9GtPWokrEDLyFdOC?=
 =?us-ascii?Q?f3YoVqxHFJMcLZflMa5upF2MPi6x+kB3pONyYLLaJrYnoMSeI35eQtjIi6rn?=
 =?us-ascii?Q?W0XJKI5EQvW/SHGlT8nmjU6CLjL441RZLm5RmKqQbQmvwO9IHEBO5LxwOXHa?=
 =?us-ascii?Q?hcNdBiU9Yb56Xd+SEaioGHKVoqfKt9Gp5+PEx7DJhZ2jsz5l1f9pVGXijKW8?=
 =?us-ascii?Q?aqCGu+XtnaGjuDClIrpiiR33DLfw5sXUyuCfz20iFCc/VGUxobHW++wA3qgv?=
 =?us-ascii?Q?ewX7xVip7FRm3rLHQVJInVcmoOQ34qZ786Ahzl2IGoSFKDY26Xy24qvdw/cP?=
 =?us-ascii?Q?fvivfMeEbwXJMjsr2Zlo3Pk7ydiw9e0HYjrrUNDOsTQ8/2Fdt7Pb2vMYGPOS?=
 =?us-ascii?Q?X5N0f6uNjpIafTM17jRq2FkGAfVLpsvNSYp5XOHpFFyLgsaR22UKgA1wnDYh?=
 =?us-ascii?Q?Wfu3dBsSos93xPLdS44zDBMIpTeOrat4ogN+2lQPu5p18y/Xt1T3PSD6HwEp?=
 =?us-ascii?Q?QCW1/dE2i5zYT06UPwhXqs01U8M67KUJ1qE7/0mlXf4FQnBqUEm0PnKJFjdm?=
 =?us-ascii?Q?OJ3ph7X5YSjt/+cum0Pmo02Zrz/WIUQsBWn5OiRgbzO7RtGsU30D+YZalzXv?=
 =?us-ascii?Q?x5d1TjdPAj7BNTwyFUGqyYOophnyHXutXzOvmB1q?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 101f4e15-3659-4bee-e8ad-08dc182ddb4d
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 14:00:41.3226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RSdHkCS4f6T/iQ/M5YbpLwtnmfOdTYgFMhfx/oBL2QWKaQRwtPIq5N6JsJ1/c/wz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9261

On Thu, Jan 18, 2024 at 02:46:40PM +0100, Niklas Schnelle wrote:

> Yes, we need zpci_memcpy_toio(to, from, count * 8) since our count is
> in bytes like for memcpy_toio().

https://github.com/jgunthorpe/linux/commits/mlx5_wc/

Jason

