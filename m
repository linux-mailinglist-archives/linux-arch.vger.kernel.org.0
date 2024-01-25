Return-Path: <linux-arch+bounces-1664-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E7A83CA3D
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 18:43:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A58E62989BB
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 17:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9127613175A;
	Thu, 25 Jan 2024 17:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iHjtDVOO"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE8F1E861;
	Thu, 25 Jan 2024 17:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706204619; cv=fail; b=MLFlnnlAQOvy+T1qXlUr/U4YJdJ8smLP6xcECMiaf0XxxrgsHLyMmxgz5SmJGpmSfFucMmra6woPjZOAHrlgL8tf/iFmljmJbXg6nhQYVc/SHXNnEnjkd4kvKRX8b4n0Fyt8NV5td1Cc4+sAS/et3bwiylb2sjuuGQ/X9Cj3BiA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706204619; c=relaxed/simple;
	bh=m78LM8ZxK8gmstPC/z4tOIk3iJ98E3p3DyHX9L21pf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fRPXkh7wF4ti1MyGPsogfYeGbUtH9bemvVxeIbNwtKnvMuvdOUh/am5+8n5QWVU2vKmYfIzh4D4ztItFVnBYjG6Op/CDnYdF/gfrtn0lB/fNpl4XOjLsrBkfNaoE5Njj8voPlBEcah2BNfKDxX5J0qdecdma/LavJt9UMq24gwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iHjtDVOO; arc=fail smtp.client-ip=40.107.223.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KM9Y5MxPpL6qdeDkJVlRJvUGVxKwHvbL814dgB8xReMC9MRwn6cFWYgx0nJu/TMNyORjZ6QOEe6ukYGYb78nzuQkzy5hUQNFTu+MwYDyiiKIpgZqngQXT9e3GcSLXzeI9of7FZ7q6O8Exn2JfTtZjv18oHzOiBBb3h5hi+1v96UkGvxGSTA7zBhuYxZfE4hAgrg63axbmbakmapt3Om+SxHkzWMjuuyUX+vrztWLUoWB/Jba2d8fpX5mWuF7oLiL0VOckb1cCLISqDyO+OJXLYXjBrwqlqY5uWsNLyEnuS97+st0GzA0dW/Y4OEysOD+WIpaXNEngmTeJR1ac7fGVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m78LM8ZxK8gmstPC/z4tOIk3iJ98E3p3DyHX9L21pf8=;
 b=Q2mviCsdpBBAMWqm9Hua1QLY2uBShh5KhgNAxeuLQtmV4dZBMwM0H/SaQqgm8PILnVbGdCqRnCDFfBJajimTspgXcyHMuShVAnwWH9vfN9QoHkDflDzKIVsT7OoTYRvCGVXkuuH7kOpqXhnuSngW44tP5f33BdfHEZuy5hmT5lnix2lXVpLbvY1Cskj37VRQTJuQUyqLGlwcb4YP5ODiPI/syW0SueEZ3ho8Z64XGj6broxOfpnfjhs8T7RsOzaSUrOJ6fZUggbQVrT3Q12ot61sds6ntwP8cIwseIm9pmCyIlbNGXdtouMnap7tX2dkMPgI1pGcoEmzsA3l5r8yCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m78LM8ZxK8gmstPC/z4tOIk3iJ98E3p3DyHX9L21pf8=;
 b=iHjtDVOOs3sOCr30I1iKEOiB6X83InRyC+NTORz7DdbFiYuSu+6UCIuPQ3WLFeh6wA1AUtxYJS6FHfE4bsWRfVN3EcNtuhZdOy8HfXbCGkBvWt4lRASQbTiSuDbnZ0TCA9MrPuvasMTBqOdlW7VjJOdykAXgfaxxtkz/SxjzDS8bEbb4a5wqR+qWY4en5PlkkW6m+QQwIYiNiTflIcOdsTJ6Fd3JzkX2ssydiqBUp4Mq5CsYhRUvECx72Nj15KCNAaHCYPl6UjwsZBLj7wHaxj7RQ8mZ2BuDK+zL4PQUg3fL0VY9pVBxvkjG3srCmghfkZF/Y7ep4YB0/NLgfzrx3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SN7PR12MB7811.namprd12.prod.outlook.com (2603:10b6:806:34f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.30; Thu, 25 Jan
 2024 17:43:34 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873%6]) with mapi id 15.20.7228.022; Thu, 25 Jan 2024
 17:43:34 +0000
Date: Thu, 25 Jan 2024 13:43:33 -0400
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
Message-ID: <20240125174333.GA2192844@nvidia.com>
References: <20240116185121.GB980613@nvidia.com>
 <ZafISDVeAA1swx2I@FVFF77S0Q05N.cambridge.arm.com>
 <20240117123618.GD734935@nvidia.com>
 <ZafWIsrjvk--JdDn@FVFF77S0Q05N.cambridge.arm.com>
 <ZbAj34vdVuMrmdFD@arm.com>
 <ZbD2n-BKGbDgMfsB@FVFF77S0Q05N.cambridge.arm.com>
 <ZbEFPbT7vl6HN4lk@arm.com>
 <20240124132719.GF1455070@nvidia.com>
 <ZbFHPTUaBmbHYnwx@arm.com>
 <20240124192634.GJ1455070@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124192634.GJ1455070@nvidia.com>
X-ClientProxiedBy: SN7PR04CA0200.namprd04.prod.outlook.com
 (2603:10b6:806:126::25) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SN7PR12MB7811:EE_
X-MS-Office365-Filtering-Correlation-Id: 312bfffd-1f3e-4090-48cc-08dc1dcd274d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	o0ZTK5MxyWblh7HGUo5E+oYyUE14pTwkNHR6dEiXn6iAYhU2Ncavzh/4uXCstlGtZexm3tjXukW9bVFra/Yf0QIycZcAej+5dK7sGCvcXhf9qxMDlUjVDj29RuWg0jfgad8qK11XgeBW2RSED0b7Sy6BQ0/KJXsBhnJsSSIoX1dm0MqoLvZEC8nM10iSrmNs2jrklMryi5tX1btzdQUsW7rE1D3H0jJYYfn8X3Ix0Peq4yGjkGV69Ce15AxNlUyqwkGMhPHznoBQrccjKJid7xslm9bNG5c6leSvMkSbhQDagw0RTF62yxv+zEI7t5QE3sARNg/m9IBTi84n4a1YgdXyyu0VNaqKbhOlWukTo3IPtXULUzY5IdhE/XhcANStP45cBbtn5a/SEfIcWI42hMFIKrRaaZ5ZWDvF8BrJoFtZVWwDXn5YJhXYFiyw7osApG/15zQro/rio0glgIuP28zfEblUReEcntXb8lZINzp5QGaHBBPIDcR9MavxkI1pU8C1u6f5BFoGRyEcb8outYyAdvav3b9CIvfGdkfZTTgMdLc9anEwMXFE3WfJY4/Lk68Sg26h9L9+MBLv3wSsMnUSNqOQauOSskD4su2q9fw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(39860400002)(366004)(376002)(136003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(66556008)(2906002)(5660300002)(26005)(54906003)(4744005)(7416002)(8936002)(316002)(6506007)(966005)(66946007)(6512007)(6916009)(1076003)(6486002)(8676002)(2616005)(66476007)(478600001)(41300700001)(4326008)(36756003)(33656002)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KtGU5zJFQqMrbroho4sGJWL7ojEMYwWxEJHbprEBKcjQw/Q0s5Le8E8zZH+P?=
 =?us-ascii?Q?t85Ixx/u8Y/MXFaI1QvZu2yfhDSMd7WzFhTS82YawdHdovq2nsM2+OcKZrFO?=
 =?us-ascii?Q?ivHmOT7MwLZFz5V4Tx0pfDQViyRwx31xeRG3Zn/m2WtVkNzWdstYDdzCbAXt?=
 =?us-ascii?Q?YB3W0c4GqqTt/SD76cuzmdQxRSZc5M0EjL5CfbVFKQ4kqfjFzV/0j1co3s+i?=
 =?us-ascii?Q?ccf9IB+RYBNth0S9g7uBtvUC99USIgIEkqFp2rSQ1bwL8vECBBcTy7YkKwB7?=
 =?us-ascii?Q?chRRVMrxzO+WAQIUVEY8HUbMRlOAu8WI+F+xY/IeQQiQNHN1ocABYiQDHD43?=
 =?us-ascii?Q?vmSY4hlMa4Pd4apS21Dc6FTb2cra/g8I9dGt+b/v26jnsQS3bjBsa6KxlrDR?=
 =?us-ascii?Q?rkBs02Hooz8Kk7o7+26oEDV3SndzQwdQ6w/FFShjgKgitMgMIgnMxu6KH8q4?=
 =?us-ascii?Q?zTX1lxX7zvdkX6YFaspfuYhUn6AhbgsVn+E1zURyE77aGf9HNPfsIjYDhR/p?=
 =?us-ascii?Q?sKDWGdyNsQKtDLJ4MHuo/tEa4x83hB9HlWjgmrXxINPSSp9FankUic4tCBJF?=
 =?us-ascii?Q?4Si1zMNdCYhWsC6cYL2MPgisR9rc/neVYehMUzjQ9rT9dkKoYxbYTr/I8jam?=
 =?us-ascii?Q?xtbKm7TilEzr5dSmQXt582bbWa2F1xu6VF4ClfmFUnvCTBcmAfEz8ac8HgKO?=
 =?us-ascii?Q?9sgFPwfMFfJWmvaMdySRvVQFsj//veEMve4fHSyBLucA8zHA0FpNwqW90I0F?=
 =?us-ascii?Q?2yczAbsQlXDV3LqvBP9X+k8zKpc0mpcFQHkqVlSW1GgxpJAbujTs4VQ47/S4?=
 =?us-ascii?Q?ZkmHDvSHy0zyU5KgGmEJap8OI/C0A0tKGurLyNrm/pFYWd4eYFQwvNjvrcJ1?=
 =?us-ascii?Q?Re8hviBvI4eVO/dULDg5Dqk1Zkx1+YvSaZXGfTPL0SMKJb+gpQliZD45slN7?=
 =?us-ascii?Q?ZXWLJ5ktMAftdmK4jgcqeVzehXgJTT0cDbW5hBnb5vAfRicGmKXfhNe0tzkv?=
 =?us-ascii?Q?AQcxGMdb7ILpfOwOC7q+LR40QmjEPvAIAz3QyInmRmLqARK2crb5K7o0T1jw?=
 =?us-ascii?Q?kwU1Q/IUGw1wMybNH3R9xtanex/eaitOphYg9AX/a4zwUMhxePGEHKBTsJI1?=
 =?us-ascii?Q?BezXKJVV6XLYpmlJL4Q3xTOxUho4/g6SBVXJEVFlH52n+B8/PSGjvcjo5yyL?=
 =?us-ascii?Q?tj6kZZCkbQarAmCc6Wv+dFXXtuKPKNgsJk8nO7lnVIxeIciZmX/lWs9ALteJ?=
 =?us-ascii?Q?Xb/E/uOB7f+zBdrQ/ckvITtDY1X5SyDreucmpeD+0XWofM6jT2Ylz+C1QyEm?=
 =?us-ascii?Q?VLv/PWxjefBcBoUj2rhs+GmmIaeXyQpkaXBo/ZnS2/NTxxhS2w6bhcFAKTSn?=
 =?us-ascii?Q?LShfR9eHNYPDEEHdNTXxXf2A7gOR7jonfJokTiEyQuUMWiaNFRfeSO1Q7VG2?=
 =?us-ascii?Q?5pUEhzpQFY1lOMby0pmWnl+Yz1qu8HGng475W8ifb4ey4wyDgUL6dv+Df2sL?=
 =?us-ascii?Q?Ha5zFz3RNLd2TzL/piezBiShzJfFRpyxJaGN+Xw/lXL6iRV6q2gp8qx+dRoN?=
 =?us-ascii?Q?oAmor3mPVRxF7QiKAfwpi8XYG+JDkrr5kE6FubgP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 312bfffd-1f3e-4090-48cc-08dc1dcd274d
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 17:43:34.6290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nNYBinMPzcBKiaQqm3joN5BXKAeEeQatvPt1Xk9tcwLrCzaHthauiz9E8H1Z7lvW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7811

On Wed, Jan 24, 2024 at 03:26:34PM -0400, Jason Gunthorpe wrote:

> The suggestion that it should not have any interleaving instructions
> and use STP came from our CPU architecture team.

I got some more details here.

They point to the ARM publication about write combining

https://community.arm.com/cfs-file/__key/telligent-evolution-components-attachments/13-150-00-00-00-00-10-12/Understanding_5F00_Write_5F00_Combining_5F00_on_5F00_Arm_5F00_V.1.0.pdf

specifically to the example code using 4x 128 bit NEON stores.

They point at the actual CPU design and say it is optimized for 128
bit stores (STP and ST4 included, it seems).

64 bit stores trigger some different behavior.

I have no way to know if it will be OK for other drivers that expect
this to be a performance path in the kernel.

Are you *sure* you want to do this str version? If it works for mlx5 I
will send the patch and the other companies can come later with
performance data.

Jason

