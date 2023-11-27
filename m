Return-Path: <linux-arch+bounces-469-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 011617FA140
	for <lists+linux-arch@lfdr.de>; Mon, 27 Nov 2023 14:45:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8713BB20B49
	for <lists+linux-arch@lfdr.de>; Mon, 27 Nov 2023 13:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375732FE21;
	Mon, 27 Nov 2023 13:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AgT1g8rJ"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2055.outbound.protection.outlook.com [40.107.95.55])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CEC0C3;
	Mon, 27 Nov 2023 05:45:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=izBHSC2wPrJO3Zq5GSshZOS5L8q1vQbbyMjpP7Xr5d/Ko8d0FV6PMlJCpOr9m5U6SWicaXiavtW12dj2xYH5IZWAnc9j+NXEpYsNfRmFoYJCwvX9qFdBUzSJ7ksfyomYBFct3DmbI0g1Y8ORr2YZXc3RUXNfBlY8zmAzsEeRp1591pnUppz+1i3XT18GxWWJonsuxYxGr7tzb95x0OBLDqfWyWGqwbhdvVK/+j0173wNaiE92FPC0WwFrLGyTP/JeyWjEdWx5GV0cCwQAavTURX4LtqPZ718de8EXGR+lWhCUcLamRrYr5ZtsoVfK3J4NSDKjBo6r8u6eeV6+KaU8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tgs+DFTDw4s2XIB0IXCVhNSdD/mDZF1DNr1X6HN+IqA=;
 b=lodUslG6p9lLqQflhmHr5yNnIzkcui3vuj7jxarvYd34rIo2zN9TzMRqnaVxZ1manY29ba7d71uiffZ+FvcyzTIjOSQQQue60QUJ1qfHFR6c2/qJjr6/dHVmNDCeuWSfQnipvPWFPzovAOc1E8qtKC/3bqt0Y9RneQoHQA6BD0U3ymfJDQiUoQY3uWnDbUwr58TPBlK+C7DeZDQheVJBIzy4uTQgHEmLaa1RzJ9zAexYR8a592/YQVBPE1rPWKR4gKK3nNOQginyhiBYRqP3U09C4ZiPqlAGxW+bzHQfDRBuSrOggN4p9q5OgHuglS+f8b0Z7qQG4hx2qozcnFD40Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tgs+DFTDw4s2XIB0IXCVhNSdD/mDZF1DNr1X6HN+IqA=;
 b=AgT1g8rJC6rgg7UxdfC0paDm4Pf+vvqZwWR39GjhowHJFSKK2wQyY8u2GkQf9o/FTLB3V5NRWWWyb9o966h7uTDRHvbatgveFjADaCUltwFyKBoFrXMkdj/xZHn9TPR+8cKXeZLDwMrUCz7aHfFmrhlUQVKfHLa3t+0f/0bzA7gIPK9lJAGniLe4IitjddbtteqDfs3o8cGHAvjFmolpE5EWQZtyqFsYArx6in6T7kLdazFnIVV1/FAPEzNT81JFsPbgt6gPyEcJSgv/Lg5rTLvq8+xA6Ukdp80Q6A54F1DE8d+DXiuFrSLPw2RstDVHv0eDtW/h+7bqTDnHADKz7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ2PR12MB8953.namprd12.prod.outlook.com (2603:10b6:a03:544::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Mon, 27 Nov
 2023 13:45:06 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7025.022; Mon, 27 Nov 2023
 13:45:05 +0000
Date: Mon, 27 Nov 2023 09:45:05 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Leon Romanovsky <leon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-rdma@vger.kernel.org,
	llvm@lists.linux.dev, Michael Guralnik <michaelgur@mellanox.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH rdma-next 1/2] arm64/io: add memcpy_toio_64
Message-ID: <20231127134505.GI436702@nvidia.com>
References: <cover.1700766072.git.leon@kernel.org>
 <c3ae87aea7660c3d266905c19d10d8de0f9fb779.1700766072.git.leon@kernel.org>
 <ZWB373y5XuZDultf@FVFF77S0Q05N>
 <20231124122352.GB436702@nvidia.com>
 <ZWSOwT2OyMXD1lmo@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWSOwT2OyMXD1lmo@arm.com>
X-ClientProxiedBy: MN2PR20CA0030.namprd20.prod.outlook.com
 (2603:10b6:208:e8::43) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ2PR12MB8953:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cd98644-bcd1-48de-a5d2-08dbef4f1040
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9/dK1HT5V8Vo0sbNCShdReCw9B0coZPyIXrUAQbuDKhcIYrTA+APL9vJ3/OTvoFUsDUm4eI4KaBZZdzvBxXIK3ba+fFswe8Oz+arDMl8B8pMzj4Z8THNJAUWSlqFkmAKRfCuGgsNe+j4j1r2VGJzIi1qk1H3dgdbjq4plvyQ6achntMYLWwTzzGy5h0+s4MQWZpHSaBbhux+pDnN2ThEszgFwgIqH09R77Ekeuk4T15FLN1Y8SFgWwAd/KLPfHpLz7iRqbSFZwhmHIUrB4kPwppNQlbTZ8muN0WKs8xG+4qf6TuhzAU/JLJGT211VXsQ3PXvuZO9JlVSvw15TZImqLSZdECAqbmafrOM4O0b0KtMCtK2VHRUNDCR/dDn0PYDE8Id17nXIaZeXpll7ftFJxytmiKOaxCpbcoefFUs2hikd7xPvX85Qxv7l3AqILoGNZKLhjuCC8aXo+xPHXtM6MLqf22wF/nbcZlQMFFcxik6yIBZsuOyN7P+T8C1F/quHFMvKk2dL/KfuhYtwaCdt63ENm8e5e3gTPIDUUs4aiDOz/D0xYgw7psT05xJlaTMVaaQGNQEyj4JtQeLiZVvPDLtL1NecBd2zLW207EBBYc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(396003)(136003)(366004)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(38100700002)(41300700001)(33656002)(36756003)(86362001)(1076003)(83380400001)(5660300002)(7416002)(26005)(2616005)(2906002)(6512007)(6506007)(8676002)(4326008)(8936002)(478600001)(6486002)(66946007)(54906003)(66476007)(66556008)(6916009)(316002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sKgVIt1O4ONSJTb3tPKBIELWTPMMDUIkJezMWJ8IAWEly7PkC78GEZIXN757?=
 =?us-ascii?Q?83N9GLfkIox7DmIoDoigcCic3QpBKh0QRIWz7PPuaPlo/lMUv8QAPTtVryFg?=
 =?us-ascii?Q?uzDgE/w8zc8Xv9h2Phvj0n0SnTG+PuZoGXxgQ1fVxp9pYRXGfr9wtDH4o3ci?=
 =?us-ascii?Q?drtibcWxn143embpuwcVpS/lddVOzAlgNDt8jdldhxEPIcgDHb9LWWJrMWrj?=
 =?us-ascii?Q?FemO7IFmpW7CDdYWkcvRMoXRj3/pTFB5jWWxcfKaa7hLUkM2fN3u8VFTqOkm?=
 =?us-ascii?Q?/l88CPIzUZF3QacpZB1YmWWpLRqqN6tdGm5kr0AYpiTStoGyXV6cGmqvUYag?=
 =?us-ascii?Q?z39CDWatxG0QlpeAD2g4UEF54R2UfelDB9Hi43BxYim6ytrcElYLaGcSgncp?=
 =?us-ascii?Q?OC8wN4+2GCzkb4wZd51skJNt7IEjTfsuBq0YBlt6erYEpxPSnHxFKJoDefil?=
 =?us-ascii?Q?DwwCQctkekCEJa6CwbQinZjt6a/xXyu6nUEu60C1+jC7I+ZImzqabvXEZ3Nb?=
 =?us-ascii?Q?/sMwyjrASwTeVqhrl2sPtHT1XmpHnaPoD/4TR63+XwFqUlBzAHMEv+ExGDiS?=
 =?us-ascii?Q?A8eCLiyWwInua1BqkT4uIgO32lQ2jzBbWikozeY47+LqURCCU0zpMSfceAvk?=
 =?us-ascii?Q?RJ6v8WCwQp6Gxpo36E9nZMO6vH4A69IPJXJNuAP0zGm/Y4lRUehtZbvn0g37?=
 =?us-ascii?Q?pqXnWGklT9fHr4AwYyDrnEXUTBjAc+knJy5UWsL4HxEVKL7g89Hmql7J5eKq?=
 =?us-ascii?Q?Eu6I9h+fuMy7tZ0fLnUuqpWoM/HTcyX8dL0nKGghmkDnj45r/eqT2KGWj16w?=
 =?us-ascii?Q?LP1pBMAtinRST1MWwNm2DGqRmbfVOjR+WV62AL6PE1kjwu88GaJbE5rG0vqT?=
 =?us-ascii?Q?CTxQoHNtMWrXU1UlVZLYGDztxey9K6xr48vO6Sj1FKI41UdRuSViPTCQOn2C?=
 =?us-ascii?Q?QJ8JCjirGyRD98sJbdFAwdO7SQXugmCsSuymbZRRaF1ZzxNhlga3sYC0nppc?=
 =?us-ascii?Q?dW2ciEdh7t94lE5qs+G583QMkkPncZ4tqxZn2Nus8d/8M/T+u7EB0VWVoG5j?=
 =?us-ascii?Q?LwrgYV3ycPzqCep+kMJX6xzEKSTJlOiyO15nsPRkuIcagxYaA0+0NVsknwT7?=
 =?us-ascii?Q?+FM6p7JC+C7/Ocmwa01YbetoOiqi1eZZZjQDc5HMI+3rwcNnNCpe16/jT5fH?=
 =?us-ascii?Q?7SdU221ETXpkJ7weo0AcTIjyhxHAkjzdxOeEQJ0zW0cx1+pqhVPjkeLEjqaI?=
 =?us-ascii?Q?HmXHRMOj1chJoaRiE7Gu6DtVahWuRLA3JkV3W6RF9Cj0SHq+cFQeyIfVZ3wY?=
 =?us-ascii?Q?45p1183hYUVnsGLXmfRDLT06JOPkg1syl3sMBA+GUhdniEMdbpb9RJAUeJyQ?=
 =?us-ascii?Q?+V4R3SYYQ0+30pcAJC+gbiwSF2d+VgigRGkrtfWKU6MuyYF5A3p4T0vrNpaC?=
 =?us-ascii?Q?SZ06xx1+OrHHwRi9Uc+CVlYlZXaBov2drRP9JMxGGED8rvRNKvxRI3SF5REQ?=
 =?us-ascii?Q?R5sED1QZ0MwUymnrcF2wR4k5AsmPIkYC3Hg0YqZsSfGvnfR4exBY8rGKA/D8?=
 =?us-ascii?Q?inF+rrKYvbtjstF53FrawLDDyq3gY67OY5Znjp/8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cd98644-bcd1-48de-a5d2-08dbef4f1040
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 13:45:05.8897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ud4Wyafk3iwKV9nFdtUp3Ol81cqBWYWMQ51JPJXLIaF3IEGykMCEOSOtkxjsSIxx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8953

On Mon, Nov 27, 2023 at 12:42:41PM +0000, Catalin Marinas wrote:

> > > What's the actual requirement here? Is this just for performance?
> > 
> > Yes, just performance.
> 
> Do you have any rough numbers (percentage)? It's highly
> microarchitecture-dependent until we get the ST64B instruction.

The current C code is an open coded store loop. The kernel does 250
tries and measures if any one of them succeeds to combine.

On x86, and older ARM cores we see that 100% of the time at least 1 in
250 tries succeeds.

With the new CPU cores we see more like 9 out of 10 time there are 0
in 250 tries that succeed. Ie we can go thousands of times without
seeing any successful WC combine.

The STP block brings it back to 100% of the time 1 in 250 succeed.

This is a statistical lower bound, based on what we see performance
wise it almost always works.

However, in userspace we have long been using ST4 to create a
single-instruction 64 byte store on ARM64. As far as I know this is
highly reliable. I don't have direct data on the STP configuration.

> More of a bike-shedding, I wonder whether the __iowrite*_copy()
> semantics are better suited for what you need in terms of ordering (not
> that mempcy_toio() to Normal NC memory gives us any ordering).

I have the same remark I gave to Niklas, this does not require
alignment or an exact 64 byte size. It was clearly made to support WC
stores since Pathscale did it, but I don't see this mapping nicely to
the future 64 byte store instructions are we getting.

We could name it __iowrite512_copy() if that makes more sense?

Thanks,
Jason

