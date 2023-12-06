Return-Path: <linux-arch+bounces-716-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 934CA80706F
	for <lists+linux-arch@lfdr.de>; Wed,  6 Dec 2023 13:59:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BAE81F210DE
	for <lists+linux-arch@lfdr.de>; Wed,  6 Dec 2023 12:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8894A3716C;
	Wed,  6 Dec 2023 12:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MFmxFdel"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CB7BFA;
	Wed,  6 Dec 2023 04:59:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F1m8vEQD+GuOwIr5rpmQpPz3ImP9nnoL+mBed0W5K8Z5qjPXeecSbBno/vc7ZK0gjrlS/fkiS0OTBRFZ20q9xe+Ek8K9MR2PdU3Xm1IxLEiwr9aExHjfMqWbJiXecBlQYl1XIxzMORVMjlgqbZjDTtCvuAolkWmlXBxjl6AC+711PPSKLigd6s3xxmWpukx7rNLb/L4taU+jgJ/3N0Wc4g/BBkZtTeLa7snihCjF9N7juducmmlDD0+q44WvqVyr2pgT9bWXvaxkruZ0TBk+YCF8XKx5udkyW5sqeeTJVaIM7xWmkGujHmWh/0mUvbDXW/YRP4EZt7/DW057k7rqvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1nh1hLjX4JBNK9/q8nKw80qjmU93bqFJwOi7MVVE4wE=;
 b=R59Joquu7BGRGGr9ao2AAhkeloyKTTrc01Mvqtuzx5iGo8/I2yXn9RpP/kKD2pdEUYm7IJhAAOS5S5KD2uzI1FkAqWN02Bz7AzPOeaqK7REyzz2vqbfPucIAVq6OeJO4esqtPzboroQNPdyR5CzoYz3ra5P66BAp5HB7+0uk3SS0aAlGNQHRg0f1kM2DQ40c5nllVMT9TKez/Kao++hCUVsMTh0veDBMBBnvuzgY5Zp5xP0BEH6J2czI4k0cqPtpQRtYkM/8SbBOp5rjUJVoFHwHLQq0t+GXahl5a0jddMDf6+H9uJHJFoKMJSMeRrrjO0RK6KL4uMoZVQXaIY8j3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1nh1hLjX4JBNK9/q8nKw80qjmU93bqFJwOi7MVVE4wE=;
 b=MFmxFdelv16GxaM1lkJMBlOLGD97Nt8qOtODFQaDBx5d9b3x2l1iLUDX+KBEm+MsDBLwn9ao6ixNJIyO/P8JAbZIod+Rj/uvIwhwGMGyEgdCpZhvK27OR9XdmQa0UcZuLacRoEx+sClA7SivFS3bf4H3DmtXNp+bJf2EtkeCjG9nBSzkbN6C8QsIxssVQ3bTlrLNPv0yQTU9//0yWBga+w3CTHNZBGGAIcpHjO4eOMk+ma86bHmJfRp5MqnNpm89j961JN2fkpBxQN8gMvxv9jW8jHLX91DT6oFFqT+zOJC8weF+cDjx+tc8c2GJNMNJV3L0hnhyZi4qrOOePuGnzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ2PR12MB7848.namprd12.prod.outlook.com (2603:10b6:a03:4ca::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 12:59:21 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7046.034; Wed, 6 Dec 2023
 12:59:21 +0000
Date: Wed, 6 Dec 2023 08:59:19 -0400
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
Message-ID: <20231206125919.GP2692119@nvidia.com>
References: <20231124122352.GB436702@nvidia.com>
 <ZWSOwT2OyMXD1lmo@arm.com>
 <20231127134505.GI436702@nvidia.com>
 <ZW4NAzI_jvwoq8dL@arm.com>
 <20231204182330.GK1493156@nvidia.com>
 <ZW9cF0ALVwgvcQMy@arm.com>
 <20231205175127.GJ2692119@nvidia.com>
 <ZW97VdHYH3HYVyd5@arm.com>
 <20231205195130.GM2692119@nvidia.com>
 <ZXBWXodu2rxQ7Szz@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXBWXodu2rxQ7Szz@arm.com>
X-ClientProxiedBy: MN2PR06CA0015.namprd06.prod.outlook.com
 (2603:10b6:208:23d::20) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ2PR12MB7848:EE_
X-MS-Office365-Filtering-Correlation-Id: 18a37e38-32a5-4abc-7847-08dbf65b29f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Hu6Q+0sG6npe90Kmr91B8fbIcRqF3mWKonJ72AwBP0I5fiJ21Y0Cqhj8elCJ5j1PIqh0lkpi4gojLVOrLavSJGKvOVyl4NjE68pp9yqT5J6bceoReFsOzgPonZyeoGUt28n4ouOClQLMdfdu/N9ARyvYSYrwg5NhO9RUmLxuCOUjqVxeeZla7WSt9ekkbeG3a9WZuuryR45zKnIbDT89N3ftlMMhsqXauuxFrSKIhSs5WVC3yO8K7a50spnx4TgGT+fneCn0Xz5hpAEL4AoQsFLzD9p9qA1DXleY00DbfXvS7RHNowMy5jCavubDkNMeflvjMp/oUcJL1xABQAoUyTelCDlGPaxxZNRJzI9tAnmyg2qJyKtOLBMVDWPvPBjK0Jguw/WinoZgqo9EM2tJvLTPqOZD8Fs/2zeVEntwtH6JA0YMC1sITwv3sDDNUIEQsWWZQJHmL+p95YvrldkSTrOnr9IoS4lY+YFYNMydSGf+1bxYVnT+LhTmEhvJcRZ0JGQLPJoyOpJCr4BE3l/tzhUkWsLRwxfxKpwVcSwUj8APejgqwofJLXPga7ukgPJS
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(136003)(376002)(39860400002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(2616005)(5660300002)(38100700002)(7416002)(33656002)(2906002)(6512007)(83380400001)(6506007)(1076003)(26005)(6486002)(478600001)(36756003)(41300700001)(8676002)(54906003)(66476007)(66556008)(8936002)(4326008)(6916009)(86362001)(316002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZqrvVKOXgFxWdx1MUw3Me7JvUkIho4N0TqV6huLTbNcgBuEG89OtybCXvt/C?=
 =?us-ascii?Q?aXnCCyMY+wzidagCyWvfhLbhYpkdnhfgr0oDWgnHuzQPmPvpAiOjPxjrxwUt?=
 =?us-ascii?Q?5ONXD3QwNhxKNjyMymfi/vrHJ7BIt+Uu+rWg57Qjg9wGJ5owl0bQK1RQcD0s?=
 =?us-ascii?Q?uzp8tN02+mRaYifFr0o8l2agP0x+5Dkapg1vCQpcIgrATs0ZPcfc8sZ9t5e/?=
 =?us-ascii?Q?JYWdACswAFABDipyxaCKC4KU+SP5JudU+kcfgwRmTPb2af6hlueXhWmz+Tga?=
 =?us-ascii?Q?LMOb22LU/kueJvwT3CmOq0fnfNn4fmSil13jPlPav4ZdspxOHhfDJJ0nMFbB?=
 =?us-ascii?Q?uWBRPfBYpxgNYmx9g2ujCPHNReJYpMWjwlqhgcCD4kcoy/voPCQ5CJ1g+IXb?=
 =?us-ascii?Q?N1cyOI82vK2eyyac9XlD4AK48T9JpAodL2fWbyjgCN7qwKZo/MAvEmi5Dq81?=
 =?us-ascii?Q?zGJuA4fuWjvEipFus7VbIZ4LDrK82cJ7Ixjg5q7XP9wkp/njNNbw3kxNvRQC?=
 =?us-ascii?Q?W9rSgu3MBbLJ6RpIlK5W2gVhNsIiMxUEU/KfX7YPqFDOF0VgYDOL2Hv+gB4s?=
 =?us-ascii?Q?+adUSn6jFeyvv82MsI2N81JNx7/QJm3c5U6j8HMiQOSN34ZQNJSihYCAvzXj?=
 =?us-ascii?Q?77kWMyZlxTPchUs1cyjIqHdIcXtvM3K/CC7hiYvKZjFC/YsQIEOa27DQJV8t?=
 =?us-ascii?Q?rbe8wP7uy/fTcpZAySd2D3bG8oab6YjROXwsND/QlAkEAuENRFKM3ZE2h3GS?=
 =?us-ascii?Q?6ZbArMuodF0pkf/unatllYEJyFVOwP4BC8ahJDdm+MaRPMM0cD9nH7KHZja4?=
 =?us-ascii?Q?4oj6pn71gvFQDOAuO5zKFy/6cAE4ITvG/nyAu3GqZFpfBkcCPA5XIpUPWoaH?=
 =?us-ascii?Q?MXlHOL9Hwu6mWFJhgRm4RTORD50gZAzjtruQKExnMfMdi4b1xj+BnIRATwpT?=
 =?us-ascii?Q?cU0GAQ/IRPHehI0Tj/bNR998rr2cDB0ZtyUjGqyfRR8zKmz2yfa7xUS1gb7o?=
 =?us-ascii?Q?nazIJdXMpWwpHV5gnUdwUaphEz+QFrEqlmuVt5eDU2kOKxwqq4Vm9ebloJ33?=
 =?us-ascii?Q?FJVT617mgwCHl/aWfZzZq4qUtYPGqNV8Kkz+py0zl5TpeZ2Qk3mf4hQWU4uO?=
 =?us-ascii?Q?LkeMXihaRdb4it84QPM6LDcoJiTZ6Np6C9+dkCkI/DXpC5Ea8lBElihkyMtr?=
 =?us-ascii?Q?uCP7Led3u5W1EYV4vy7IhFVZbmbvSoxdX7VdCS9pIiZ4HOOd1E5XgxFybP9x?=
 =?us-ascii?Q?WX8zboy+PHBB/Is2An61k3nnV1W9QIjRr1X7HKpFa58LJ1EpYEGGv1qiGg9+?=
 =?us-ascii?Q?JCxpXUUtJVb9gWuI/M2IgQECiW9QjD8Nb4DqKyxoadKjnVD6imvpC3+TFgdh?=
 =?us-ascii?Q?FYyQwGr73XqMphJ6YqPWjdfWuG9kHtTVdFpPhRyL/E6TqpgPTEbG1iselxFO?=
 =?us-ascii?Q?wP66XS1JpMOeQixrkPy/ixKQtwW9XME8oth/i245qdG1bwSxcoxCCt/+hw86?=
 =?us-ascii?Q?u3xTVfC3r/o0eQIOXtBMLt1bfBO7iMHkab8vwk3fOLTpr8R38ZoB+CFEdC0i?=
 =?us-ascii?Q?qS4rKtOZcvrU2f/SxTPwAnSOPgoAq8lfVm/pV/Hm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18a37e38-32a5-4abc-7847-08dbf65b29f1
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 12:59:21.0444
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F0Fxslgut5Bt7cthxl2TOTUYLXDvQ7pRS+ZtmMIoh9i2PTNvPHJ+LDvb8zQuaqz2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7848

On Wed, Dec 06, 2023 at 11:09:18AM +0000, Catalin Marinas wrote:
> On Tue, Dec 05, 2023 at 03:51:30PM -0400, Jason Gunthorpe wrote:
> > On Tue, Dec 05, 2023 at 07:34:45PM +0000, Catalin Marinas wrote:
> > > > 2) You want to #define __iowrite512_copy() to memcpy_toio() on ARM and
> > > >    implement some quad STP optimization for this case?
> > > 
> > > We can have the generic __iowrite512_copy() do memcpy_toio() and have
> > > the arm64 implement an optimised version.
> > > 
> > > What I'm not entirely sure of is the DGH (whatever the io_* barrier name
> > > is). I'd put it in the same __iowrite512_copy() function and remove it
> > > from the driver code. Otherwise when ST64B is added, we have an
> > > unnecessary DGH in the driver. If this does not match the other
> > > __iowrite*_copy() semantics, we can come up with another name. But start
> > > with this for now and document the function.
> > 
> > I think the iowrite is only used for WC and the DGH is functionally
> > harmless for non-WC, so it makes sense.
> > 
> > In this case we should just remove the DGH macro from the generic
> > architecture code and tell people to use iowrite - since we now
> > understand that callers basically have to in order to use DGH on new
> > ARM CPUs.
> 
> That works for me but what would the semantics be for __iowrite64_copy()
> for example? Is there a DGH at the end of the whole write or after each
> iteration?

End of the iowrite_copy function call. The purpose of DGH is to reduce
latency through write combining buffers by providing a hint to the HW
to close them. __iowrite64_copy can be reasonably thought of as trying
to push the argument into a single TLP.

> I'd go with the former since e.g. hns3_tx_push_bd() does
> that (and doesn't seem to be a 64 byte copy).

sizeof(struct hns3_desc) == 32, HNS3_MAX_PUSH_BD_NUM == 2, so it is 64
bytes.

Indeed, I already know this HW and it functions similar to mlx5. In
userspace it uses the ST4 instruction, in fact HNS was the team that
did that change citing measured improvements on their SOC. Changing
this to be the STP block will likely be an improvement.

Jason

