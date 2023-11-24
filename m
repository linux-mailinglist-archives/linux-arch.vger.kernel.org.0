Return-Path: <linux-arch+bounces-447-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ADDA7F788C
	for <lists+linux-arch@lfdr.de>; Fri, 24 Nov 2023 17:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E15A1281310
	for <lists+linux-arch@lfdr.de>; Fri, 24 Nov 2023 16:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2F733CDF;
	Fri, 24 Nov 2023 16:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eZ1VsCrQ"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2047.outbound.protection.outlook.com [40.107.100.47])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C2C9199A;
	Fri, 24 Nov 2023 08:06:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LUHpqWVrYVA89kZ5gmA/oXOCRsbv2ykeSvtLUBcn3vYgHAP69+WhuitxKv1qdYwf5WsedXZflrxvELdAKompFaUcXxHx7h6vnbPCt00MM6mmESISq8bHszHaJ3cbicl5WdVAzWrQ/vfrYe7aM26yOEBlrIb6GwVtE5M42/lXPqx9C2LmpUiwLrHwHqrcXHA1I/g0u7zSdugn0Ks0K/+Mz6bKa6hWFgFKnO+LzaM0PDKRnNOpTLtIiA++Vmgvg1P65X31xk0LjgTO/1Sc6bYxNyAUHq+78a2NThZp/D2QSD5/5Dfh+i0xjvJhFKpBL/xQ5J2hwc4gVrdxKq6BknWFnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gg3r1r1+u/6KJFFs6l+Hs6HtE1ETFXoJdDdeja+SwYg=;
 b=eG9LuI1t0fl99R5KKq50zCtUHj3kCiporJJNxfQox6zjbIT7J3FCh4m1SoeFzzAM8vZfP5mnYzAEEUno3dIbNeXzOM7XjuqK3DTPPxn6SWDQ797nm+OFJcxTtrV7//P/u/m7vGyA+2FjCKYMxhKPghJf/V/Fu+fDFFbGnS/5O0z3eIfSkIHE4Er820oqVHhFIjD3FP0dGuRWu9tfjVQHtORRP6LRDoC1cOFYoPDntwh08LMCsZiObW0leAE43r1Fz0F4ubPYVmD2MhII1QbaR3axApaEuHvEdb2BlsgpEskrk7kr2EST+v93+XzZrSz+tttcCZ6bFKxysZOg6P3yTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gg3r1r1+u/6KJFFs6l+Hs6HtE1ETFXoJdDdeja+SwYg=;
 b=eZ1VsCrQLLdXhMGBEtJju8ETZnlyx0U4KBMXSVVJs2sdci5A8pBvAJzF7Zc+EsXnQMb3R+NqTJ7O9qiBSzplBAQjI2nZB98ky3AnZBp+61faG5UN4ZHPUT0/g+kjCAsg4i2PNVSqu4fPxVRwtd1nfR3ZjRObOsiO1L7c9Ll9BIWpU+p6sXWkM0Imy08o+Ph6F4RCs98pNVQ8GW11hXkI31VjjmEPDG1Ec+JLPOn2BGw5xyKGyJFtHFtHaHlYTvxDY0jWm7MfI4A+3gR7eb/ir5O21zD7/Mr1bsk32SF6TCrdT+uIKaZlBCsgEf0Y2ERRHG7XlJndBlE8F56FerHuOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA0PR12MB8716.namprd12.prod.outlook.com (2603:10b6:208:485::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.21; Fri, 24 Nov
 2023 16:06:29 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7025.020; Fri, 24 Nov 2023
 16:06:29 +0000
Date: Fri, 24 Nov 2023 12:06:27 -0400
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
Message-ID: <20231124160627.GH436702@nvidia.com>
References: <cover.1700766072.git.leon@kernel.org>
 <c3ae87aea7660c3d266905c19d10d8de0f9fb779.1700766072.git.leon@kernel.org>
 <c102bdef10b280f47f5fe4538eb168ac730d7644.camel@linux.ibm.com>
 <20231124142049.GF436702@nvidia.com>
 <14103e31e0c47c0594e7479126ce7fe34f2de467.camel@linux.ibm.com>
 <20231124145529.GG436702@nvidia.com>
 <b3250b9a9af2f29ee3d06830746fb6e8ac49271d.camel@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3250b9a9af2f29ee3d06830746fb6e8ac49271d.camel@linux.ibm.com>
X-ClientProxiedBy: SA9PR13CA0133.namprd13.prod.outlook.com
 (2603:10b6:806:27::18) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA0PR12MB8716:EE_
X-MS-Office365-Filtering-Correlation-Id: b67d8d8e-f201-49fe-3fa3-08dbed0751b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cpOg9wgngQt2shCAcwe2SBwmbyrtJrMagFwZ9rzAzpWsVySuzVOr15vnMsPc8qYgFHwhFwa1f71GWi914MWxeQC8kVDvKBiZl4JBwErbQ4JknT2RdWWXqY3Lg+KG3Z7nicLjmJQ6Fnb67iBEc0G4S/9suNMqCW3ZG2NBPBzjuIDY8dwoR/uwiU2372rVlK/Pi9TgWfS8aYwyMSNGcjkAu8oHi71L3o28jB0TqISpvo+8ypZjj+hWLubtWuyrqAuaHCiFQYoTDbXdVwGlI+saRKDfZ+haVl1fiktL04XBNONhfNlxYRUHtsGATMrGpgkwRv2WaASFOAJ2pj36G5/SdepmC02Z18Mb/eOkDRF+2yyEH+EaP8F/GJwPjvh2plWD9LMYMbdW7rAiZxrWn1apqlPIpGwvGNE000jGfD4wZZdCoVrxnJMIWnfPOJ4AvSOoSVyFezfdFhgfJl2KKh2gYsdnmOT/FsrmkN75qC69fKrPbtuJozhHf1ieAkAZ5OFMJRRSlFD0ypKKMA6OmdmIanYESGGwg/pLGdVf3FuUEqlwU6XXzeiDUrgd+sFNnAEw6idyALIu5Vbf4PkSjp2T3VKONxhPHuiNmxEdsWoDe4I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(346002)(136003)(39860400002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(6506007)(26005)(1076003)(41300700001)(6512007)(2616005)(38100700002)(36756003)(6486002)(478600001)(33656002)(6916009)(316002)(66946007)(66556008)(66476007)(54906003)(2906002)(8936002)(8676002)(4326008)(4744005)(7416002)(5660300002)(86362001)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ov+/RXMQAMNhdgVOUh+VwulfVkjYIdYYceC0J/7f6/cH0/HnHTYmF6rgXUmt?=
 =?us-ascii?Q?9w1vBeHfXGG3ZByYgtU48dV+oG8Nslbr/+vDryYHC/p0DkWMP/pd8D2amHiY?=
 =?us-ascii?Q?NPMECn4UVGEpxu5dHZ773DLnc5qjY9laW7pG98BF/hCodbTuGWtm0E3bMeSU?=
 =?us-ascii?Q?tsQQkVL1VIKtcTZ72Kqf15rtc9N3y3gBjBznUbbQi8ZMaJ0KNcv+iiHhKbN1?=
 =?us-ascii?Q?BtgmBid7T3oYFGlqUkEHn8pV2yIdlWuZ36jLXFlnF21S82C1sZR/azE7UEoB?=
 =?us-ascii?Q?a40GT04hcFWrf1+4TVD+O1AtExnoP68wbcop0Oa48gfWAjMU2fEA6ztod4z+?=
 =?us-ascii?Q?FaJBni+eazDugzrN07cG/Ee9mXnWQx+sf4PQyuxnulm9idWx92BgYJHMAh4/?=
 =?us-ascii?Q?QafJPOlIiABYxhl8sw4rg/lxiCxIqPwU/8k+vWWF9fjUaZoNT9i1UJkO7kur?=
 =?us-ascii?Q?sIrIVi4qyYBnO8jtYQXGZz1yFs/AoreVz5dyIZTlXIGgs7Dyqc809/dmf1Dr?=
 =?us-ascii?Q?ayc2gnrypaMlNAdCx0mk+xs93mDcyjfI3vBaPIN3w8WdmQqNpsCL5EsaELsY?=
 =?us-ascii?Q?YvVE+KdyioCgYqcXYrN3rbydx4CUXVZsfO1oz78LQYaZ/cqjPq3WtBYcc1fd?=
 =?us-ascii?Q?yjFtuwbo0gTN2YiYoAxF+uq9QDHD/ydnJiHbe+bJiAIJw4W4/vvcEsJWz8fM?=
 =?us-ascii?Q?HLHYt9S1zC/j5Lmt3A8vCJJgR3ofSSQbH0Z60v91W8fW+f+fD8Wl1TIRDFok?=
 =?us-ascii?Q?Npm7Onxq2YsAqb4voqerYpdzGa6GzF3frCC5YhXmTgiVjgTYFXjeZ3L+PfRW?=
 =?us-ascii?Q?uNuDevTgfuaWIO72gW8+Y14nWEJoBhPvQsG3RlhKThR14oI+jyr1SzqqEmqp?=
 =?us-ascii?Q?LV36z4NOra1LW/wqX/dBKLZfPMPjjg7gs2E7vD6Yh7yR3p0dET1VjJrb7m/4?=
 =?us-ascii?Q?6pl9lOEV12oLK+KCB+jPaT4wMRTCLcMy+QrzWBO8Y/Q5/HhabGlh49DWLYVI?=
 =?us-ascii?Q?KfQWgy+JOW1VIjXGeEywHFbNVS3o3MLJjD+imwhO8lI5lPzQs6iCdy9eUBKY?=
 =?us-ascii?Q?YIKsVzIkEeZIxof3pImw3JBs2yveGr1rrtkA+nPBYZuUYohbrCrXH/e4fmKX?=
 =?us-ascii?Q?5y5ECZjTxM89EDxiwZQoel9lwqr3y7IutVl5YaB79j4hf+wQghoHKw63hs+r?=
 =?us-ascii?Q?/Yi3KYtr8RrrQeuZ8AzwkJSgIeupEP1vvih/a8BZzB9JUxzwggzm5CJQcHdo?=
 =?us-ascii?Q?h6Gdy3OackyKw7uqKR4lropthM4QgleZH4KhKiRF+s8iJsSBfy6Yk5mErBLB?=
 =?us-ascii?Q?o2GJM/hnxOvJuO2X5d9OZsxbpqd4LX7ZlWlHTzJEZ7QeVqFI/4GtRqm2VP9P?=
 =?us-ascii?Q?cwpoxB+wtywv7vEpBvsKBl8qrmmJl60hpNR1OXPekfG5qU1x0AE5jWCg7cKi?=
 =?us-ascii?Q?1mobv67HjA33y2yjH6Nx8VhWiSXgK1WuwQZ48H37RzqWwDqlbgrl18ItvB8V?=
 =?us-ascii?Q?V280NKTFhsfPh8tju2l9KMC+JDc3NaTdH4jThFHdwHTAdnY+BedROwwgOQS0?=
 =?us-ascii?Q?gbzCnFmdqysyusXFIWsH/CX3YiCRjPsqtUQu4F7A?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b67d8d8e-f201-49fe-3fa3-08dbed0751b6
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2023 16:06:29.5559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: coTg/JHWgW0pytTzR2bfs6ud/oEERH9VbWBqLYog75FsM+m5WGGMJCV67Ps330wr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8716

On Fri, Nov 24, 2023 at 04:59:38PM +0100, Niklas Schnelle wrote:
 
> This should be as easy as adding
> 
> #define memcpy_toio_64(to, from) zpci_memcpy_toio(to, from, 64)
> 
> to arch/s390/include/asm/io.h. I'm wondering if we should do that as
> part of this series. It's not as good as a special case but probably
> better than the existing loop.

Makes sense

> I don't think we have any existing in-kernel users of memcpy_toio() on
> s390 so far though so I'd like to give this some extra testing. Could
> you share instructions on how to exercise the code path of patch 2 on a
> ConnectX-5 or 6? Is this exercised e.g. when using NVMe-oF RDMA?

Simply boot and look at pr_debug from mlx5 to see if writecombining is
on or off - you want to see on.

Thanks,
Jason

