Return-Path: <linux-arch+bounces-2452-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19CCA857CCB
	for <lists+linux-arch@lfdr.de>; Fri, 16 Feb 2024 13:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DDB21C230A1
	for <lists+linux-arch@lfdr.de>; Fri, 16 Feb 2024 12:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6567E784;
	Fri, 16 Feb 2024 12:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GgsXzA7y"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991181292D9;
	Fri, 16 Feb 2024 12:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708087149; cv=fail; b=JEnH4IHBg3L3G+CwRf0qQbd/rBLZOFXe+isAJMFDPeqTlybDe/h5RCOXnxjUdMaqLEkzjtLnNxfmE+LuYLRppiI3PZb3/O0u5diG+WK9fv2DR5VmdravtxAPzDOkP0uuFMXBiN43hpKWnjqWz3Pue6sanIz02PVoog4FhBYYD2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708087149; c=relaxed/simple;
	bh=Yi9dWMTAyFJj9kKey9HhY7whOIw7J0Dm0kHFj4q/9X4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kaveldA4u0ASzB17WTDDLln7o9orNzmG+Py4BVxayfJ291KayGfdR8+/gur1HRjQVkrJhR1zTS3vFTHMk8DciLXx2f39xKLB3LC9mbZHIIFffcoksxx3N2v6DU9VuLJrXkeXxd4fnRsybnNGSPPsP6IYT1XhHnkIXyohW0J8y/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GgsXzA7y; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CSQeBM8cUb6/1FOP66YSuHhQxwo0xenSSQ1otRkW9IJFD7AuZMhWjcpNZgiueHEdXaUOGEVNLVeoMaCSA/WfCJ4D4w9t6lXcNI86BTA9YqVrZFCihcNs3OhLUA6qj8M8AXFdAgRaXfNJNXsBpP/DH53Gbu/pYG5pMW3YwmSpaAHr+G6C3HeAGeqsHPQ9KXQ5mscBSc1b5c2K/IBUdkmJz9usw5Dc78r7blWNnGJjiwRBvjtVL8NOsZusunICSc/psac8U0ALuifaeeiBsUnBeLPwfXbGg8RPXAAN2gnnkT6My8VWKdE6xvUeqkpMig563BZHzaXKP/IWgRgR/UxaZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RzFeW0nqwv8olDFt7IQjigMt0lS0Ud578TnmBLW2yRo=;
 b=JwQH2h4M1SxMGIv8KfHUqzr/r6W0x+z3B/jT21DQYhH0nBkUpyWM/VntigPDaL4IhDkwB5oPpESofpf0e9pZzPO69BxRhjas4d9Adse4kHiwEz2+AgLSlwQXaOJY4kmagc9ZGg4yL6QtqBzgib2+72bbmL3Ommr60OF1lewDGLpIBGI//Kc7LWJMbNS5QohOHGt7esL0azzhqWETIWje/SPiMUxwZZQ1OieZAapS3Sd97qokKt3J0F5UVHxwwyvDK6nAKkHZIuDJSq6hvosZiJR/euJ/iJRWwiO+C4IhH4V9pNvJVZdFu7KskG5r6USfDlYCfYCrkPQzpUYEm/6J6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RzFeW0nqwv8olDFt7IQjigMt0lS0Ud578TnmBLW2yRo=;
 b=GgsXzA7ylrQsKVOlAN5+n3cONiLuGT6FIoGZSUrKEm+gFTeJdk656yyFHcGwW4g8+gv8NXrncJdZx/8rqXP2yqN9veDvFKMMvofHzgaSbSmTbZaJR9TD3GipphvasgEcGwGxffwIcE1QKeqzM00KpGAVWKNrt2A2Z2fhf+U46nD/pf0q2Gj1pa2+0pWr14QFd6RwaVFgvCrqjMop0g9dlW/RgCg5Vb7ahx88abanDHxnIjL/MxaYeFxfBc55PyvWxLpYJtwKsiPVFDJt3XUQkYu09UVPYd7+/bZSLkV9nA3nIHbJJq7pG7K7wgGpuVdOHdFVi0aoWEd+dBIUc4MJLA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM6PR12MB4266.namprd12.prod.outlook.com (2603:10b6:5:21a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.12; Fri, 16 Feb
 2024 12:39:04 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873%6]) with mapi id 15.20.7316.012; Fri, 16 Feb 2024
 12:39:04 +0000
Date: Fri, 16 Feb 2024 08:39:03 -0400
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
Message-ID: <20240216123903.GB13330@nvidia.com>
References: <20231127175115.GC1165737@nvidia.com>
 <002043477bba726f7dfb38573bf33990e38e3a51.camel@linux.ibm.com>
 <20240116173330.GA980613@nvidia.com>
 <ddd56db15bd2c87073a2f839e06cdb80d693272c.camel@linux.ibm.com>
 <20240117132613.GH734935@nvidia.com>
 <20240117175518.GJ734935@nvidia.com>
 <8e043042f425b4c574d1d3c3ed686253c8cd3517.camel@linux.ibm.com>
 <20240118140039.GL734935@nvidia.com>
 <071e2d2e301769d523dd613e77c6541a61bd496b.camel@linux.ibm.com>
 <e1a6dcb9ccf1b5401fc0178ac2d700be9d8ce564.camel@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1a6dcb9ccf1b5401fc0178ac2d700be9d8ce564.camel@linux.ibm.com>
X-ClientProxiedBy: MN2PR02CA0003.namprd02.prod.outlook.com
 (2603:10b6:208:fc::16) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB4266:EE_
X-MS-Office365-Filtering-Correlation-Id: 091ec69b-efec-4ce4-b3a6-08dc2eec42aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WJZwAwGFZeUTimPH4lsxUb8pIwpgbq9zwNQLdeJloHou2NS842DREwxyYmTUP70YzZkPU/HoHosk7vDzxIUPbnFx38TKH5gqnpUwl/qF7MyngQXw/Jj6g/FC7DPXYiCeDfXpRpaTZu/anCueo+xfIHFZosuCYoMNjgbOTOq4IKFMx2cVxUsNABVviGKusqntfYnEchbXc8dUGPbv30xBsPgPuToZLPHZ4MjFTfgHRvG+a4EBa96on5OJW6WAtNOSdnIFEzqqU9RiNPd0+AYzn/0YBSQNN0wl6SwSVtoUkEI+tAsGqqInfkgr50uS416wuYCpQjenjiNEYJ0x7F7qAE59b6PY2ysk6HciN+8C2MyvHO7Mteu5SpJoM0OE22TTMIkHkcUvFTdJRJlPH1psNW0KmI3KOO6l8dCvYk/y9ghSoVWGgaTVwWg5vwKm8DqUSkS5UU99f0+IijPknHJG1rqt5iLEa3Zv9CtLBVV3vtQuKVnQbl4DMPYkU86FZwuw+t4gMoEVxdzuPWfee2peASJ+AhQK7UD4wBlvYvZ6od35h8k3K4CTxfJM9OUXvf/QTN/qX+zBNlXEi7H+g27c+dQJjgb/EYNK4RYKIrFikV0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(346002)(376002)(136003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(966005)(6486002)(6512007)(41300700001)(478600001)(7416002)(4326008)(5660300002)(2906002)(8676002)(8936002)(316002)(66476007)(6506007)(66946007)(54906003)(6916009)(2616005)(66556008)(83380400001)(1076003)(86362001)(36756003)(38100700002)(26005)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UHu15nHxuzTeB4xkROLw2oavdyl3/6Y9A0Uuk5iDIxZMDCDOkEHSbqLX/bdM?=
 =?us-ascii?Q?M54JsWi0N83ZHTUS8wuuH7WjMMMmHovs4G1LndiS6R0pKquiysIVNWmhvWil?=
 =?us-ascii?Q?4HRfLFWmGk2dtJH+vN1nZd8VSZUIk71GgIpCLzcGStK9/a54NBld9gX1Eikc?=
 =?us-ascii?Q?5f8/csbRpmRKh4PCaaTATW/Z9jq7OprhFte3rYS8RAWEysgEKfY+QvBquzSS?=
 =?us-ascii?Q?2UkG6HYKYsLMIhtsPivSFBjEHjf2Tszsqd5HaSEoVLrHaNl2yt65EpNcZXao?=
 =?us-ascii?Q?l7KxwGksktc1FuX3Cr8/vjFRd9xluGvNpZxHpkaQ1C8OkK0JDZglkwT7vVtI?=
 =?us-ascii?Q?Ez9tg1I75yGN4yNdWVT45B1zaW+ThfAf0yUkzmXF5b++PgPWV9FKNN7vaqYz?=
 =?us-ascii?Q?buCWTNUxpzDwmOBaZOmoVlkYsZKZvVCB+NuPr4IaiVb5KBUrYJmGRs0kax4F?=
 =?us-ascii?Q?1t+UKTW89nxnT0k+lVqimvOewFOJuJIFK2t0OvV3bM4FTioDOMafdr8JPlCV?=
 =?us-ascii?Q?9xAHyyrZhskCNXh2/DdPlskfodK8oSb725LmmmhJHHEozRjCpQ40zO2JG7q1?=
 =?us-ascii?Q?p23/L03lHqTePp4u153EMY8XlqBBCy8HSoNi9BLUUJPKgb2dao+e+4vXIEyS?=
 =?us-ascii?Q?J4rIhiNhb4BYPgtEIlXp8BOaSrCqYzVgIxLHkFgNoQGN0Jld5fYU17YDywhE?=
 =?us-ascii?Q?tLOWlwNSpqsYejFA1wE89mxv35cNJwOJBOzJmkkqhI2yM/xEHRRwW+2ZRGPb?=
 =?us-ascii?Q?filYtT5fQHcEMHM1icCtbrg7s38wX4cBdf/tLOrql6qhLtLr4IYGF5lQtA9G?=
 =?us-ascii?Q?mS5H+Wf4NtPGjEcFni/SAU5heCfofjaMIDdp5BK9pzUzuUXf2zIXqOkxLDj3?=
 =?us-ascii?Q?DxtzwNJVsHultXaaPZYSf9xf5lNXrBReb4MfgHDudfENq+DtvcdxqEvfZJlU?=
 =?us-ascii?Q?ffKta2NU5Dr80Gbr0K30UbhEm+0GpM7vXOTHemh/ki94yRURy446ocIKbvm/?=
 =?us-ascii?Q?gt1Ct5eKQ0YTOYKphRb++cuZ6q+OHle8RYaTVBFF8teErxWltw1W4FxlRIt7?=
 =?us-ascii?Q?SaGrjS/apwjP56zsDDo4ta5MyOVR7mhVsaz0+5oOu0YnRLN+SpUpbpGXzmDf?=
 =?us-ascii?Q?B11mj9U/IqsQJE6ns7agTj6UQof6YD8F8HY3xJg85ixwBUm9M5Cs6VkFAJPi?=
 =?us-ascii?Q?aHkCZvGOEe7ELkB6pYa/tuF99llL0MSRwkSDphIlKnle2WViiwmRPj50Gdbe?=
 =?us-ascii?Q?TBi6yWxJj9cypxmKhdOjyzyulQv5KdQl3tbCVqBY+EkAYv6eDU1OW3yOr7St?=
 =?us-ascii?Q?9lKt8pwt8NLXTLdSIJXbO7494cDgB/8Mt8g8CXNkEYNKe/TdW3rTxT9W7cwp?=
 =?us-ascii?Q?tgi/P6WLNqT2i5LjT60YGXGAMAxHxFd+/7L6oKxhjTkZ6hVGj/qU7PVxUXKu?=
 =?us-ascii?Q?3wiai1MG4B6k7cm1h+tVmZoWa1TQo8ukduz7NwPy265zSTQEOqDdqjvmBl5W?=
 =?us-ascii?Q?S9sXYbpZb0T09WlNJ+2GFlEhWzYrHKBMyhac1u43qi5y2fyRtZDpS5zvl9o9?=
 =?us-ascii?Q?nmyyENaxTUwYhkEPEfEYqmAF4M8/lVJfyQVfFRVL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 091ec69b-efec-4ce4-b3a6-08dc2eec42aa
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 12:39:04.6896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: igF6ACn9ZDwkqTEooALH5S4DQidE3hM4edqjtj/NBOW8A0SBGq3ks7SagqGFNw9A
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4266

On Fri, Feb 16, 2024 at 01:09:10PM +0100, Niklas Schnelle wrote:
> On Thu, 2024-01-18 at 16:59 +0100, Niklas Schnelle wrote:
> > On Thu, 2024-01-18 at 10:00 -0400, Jason Gunthorpe wrote:
> > > On Thu, Jan 18, 2024 at 02:46:40PM +0100, Niklas Schnelle wrote:
> > > 
> > > > Yes, we need zpci_memcpy_toio(to, from, count * 8) since our count is
> > > > in bytes like for memcpy_toio().
> > > 
> > > https://github.com/jgunthorpe/linux/commits/mlx5_wc/
> > > 
> > > Jason
> > > 
> > 
> > Thanks, the s390 patches:
> > 
> > 
> > s390: Implement __iowrite32_copy() 
> > s390: Use the correct count for __iowrite64_copy() 
> > s390: Stop using weak symbols for __iowrite64_copy() 
> > 
> > Look good to me. I.e. you may add my.
> > 
> > Acked-by Niklas Schnelle <schnelle@linux.ibm.com>
> > 
> > I did test your patches too and by accident confirmed again that these
> > do need commit 80df7d6af7f6 ("s390/pci: fix max size calculation in
> > zpci_memcpy_toio()") from the s390 feature branch to get the mlx5
> > driver to detect Write-Combining as supported. Note, as far as I know
> > Alexander Gordeev is targeting that one for v6.8-rc2 since we had quite
> > a few changes for v6.8-rc1.
> 
> Since I haven't seen a new version of this yet I was just wondering
> what the current plan is. If this is somewhat stuck would you be
> willing to send the "s390: Use the correct count for
> __iowrite64_copy()" patch separately, preferably with "s390/pci:"
> prefix?

I have been waiting for test cycles on the right ARM64 system and it
is taking a long time :(

I'll send your bit so you can take it to -rc

Thanks,
Jason

