Return-Path: <linux-arch+bounces-706-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DFA0805C99
	for <lists+linux-arch@lfdr.de>; Tue,  5 Dec 2023 18:51:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C15301C2108C
	for <lists+linux-arch@lfdr.de>; Tue,  5 Dec 2023 17:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD386A33B;
	Tue,  5 Dec 2023 17:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="csj6OeBQ"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2086.outbound.protection.outlook.com [40.107.102.86])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 435E818F;
	Tue,  5 Dec 2023 09:51:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BMlxGYZ/AEcKqHM9tepjeQoF+4kdM382X9SHO9l+QaVwJqVvcRaMaP0Km4BdhXXLGd8p78oeK6pXSrQVirXT92YuSawpthlo6c9u4DUdt23nJNXuw2TxDYjLFUH8f9z1pxKRI4lzhIdAibdd2Nr9jyhIp7umrq3SJ/xB6lf/FcXcjde1SbHV0ap6qhIkP/jjVApbp1bQNhXODrKl1jkn/D7RPb21r5/ERSPnApFGJGL7jSjzzsPJKQuyVMYXPuxlaytlga74/HGHUIwwp/T+N8r4lYdLFjLb2sv+Dm2mJha2qAKoce8vp8av9wSl6S1NylBsN9oiUNIjVbndwNXh6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=efof6XjFHYzaeCUgn5K7CuGjpOO+HSLejGzqAzKvFMw=;
 b=FQfQzsddmj/x0j71nYnhGM1jRsVHY0gh1OyanJFhp7RAPrCyWmqZA4NRGU61mqb+CTjTegzhBhn34Aol9LxpgyMeRpkVwiKbwk1m6HwQHeLz8rTf6Est8pfKi7DE31O/TzRYz8hDh7uWvzYyxqhDfGokMb9hENxrqRKueV4ER2AVFczCKlmYGNNVxabr7JyLlRIFzl9GLcftKIsPQOt2SI00UyoYOV7VV7Y6ziHyJcjuVBiTlA2FluDx5KZYWQWpgqqxjr8ZeOyy4F95n86Ahh3GJl6EdWLLbNdoIC1vofQ2mRfPonumW1Ru6uOXnMTAUXVC8CvZ36keHCkTHpNVNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=efof6XjFHYzaeCUgn5K7CuGjpOO+HSLejGzqAzKvFMw=;
 b=csj6OeBQBZ33c4564O9aySkp5YKu4CTscsQBMO8BT3OGgNrNqL/kkK7Crh2XMhcONbSptEX/UYnQmRmT4lkthx/MXNEX8I4k1ws2tztn4CLSKD5vyQ/iy+TUV6YOd3B9Vjkhxurrjoe39Lz19BG+0N0TMv955mLYjf4F8WGkB/907SqTIh9OMbaRVjDo9EnOJj9qrsrInPLjU/yHFWF78cBDH+fKFw67gHlZYWHw0mR1A9gLsjgIbRCV35mZXupt9ojEm2MeOMKlkN8HvYkJN+C5reaREw+gO8vkP5IlK87COebqTnEB9STdFKYIPzeS5h5l09TyWFBYkr9//uMYpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB5746.namprd12.prod.outlook.com (2603:10b6:8:5d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 17:51:29 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7046.034; Tue, 5 Dec 2023
 17:51:29 +0000
Date: Tue, 5 Dec 2023 13:51:27 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Leon Romanovsky <leon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-rdma@vger.kernel.org,
	llvm@lists.linux.dev, Michael Guralnik <michaelgur@mellanox.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH rdma-next 1/2] arm64/io: add memcpy_toio_64
Message-ID: <20231205175127.GJ2692119@nvidia.com>
References: <cover.1700766072.git.leon@kernel.org>
 <c3ae87aea7660c3d266905c19d10d8de0f9fb779.1700766072.git.leon@kernel.org>
 <ZWB373y5XuZDultf@FVFF77S0Q05N>
 <20231124122352.GB436702@nvidia.com>
 <ZWSOwT2OyMXD1lmo@arm.com>
 <20231127134505.GI436702@nvidia.com>
 <ZW4NAzI_jvwoq8dL@arm.com>
 <20231204182330.GK1493156@nvidia.com>
 <ZW9cF0ALVwgvcQMy@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZW9cF0ALVwgvcQMy@arm.com>
X-ClientProxiedBy: BL1PR13CA0163.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::18) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB5746:EE_
X-MS-Office365-Filtering-Correlation-Id: a4213330-dcf6-4021-a8af-08dbf5bacf3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0WwXS5kkqlskCv6cR0TpjwS4j2FIRWXUba+uaWcQjQIoo741d6PCHiFXtylYkyfjQ7xYPmzqeH//C22oNuFtMhRtZrQA/SfFh3kX6IssHnsPshZBlFDmq7WulDr2T4815AJEJGoZkUsv53Q+WqB9xNlLP4QQ7b+TLYmhaj1RjZQofnDnPI9Sx7/0HEs716MkHutBjJW/34zdIlmRlwaFljEqptiQPf+NgKpBncJrtOan9tpkqJnGkLbjU13Il6/8GaVNc7Tz4ZbvfFPOyq8YwBAB2pyvX8VzW9ImpWysVmj+0WmY2ge5uVrLnmm0Jzs8GM50dUBKn9DwUb1Gt20NuaLAbtN1oo6gHWAYKwTn9qxVjEBE7EA1h1ZYGy0VzzxFUzIv6OcurkJTlHEfCD9ogXQxJTZDdyQ/1YzIML5VTX0/C4eofohrJD/FcW1v5XzzZumwKqfkZkY9V8XTpGhuxVIVjkmsM+pGR8H3MvkQyyMBidnBU6M6ldKrMoWblLsNWtDRPNTIz3v6Yxg+8jKz3uDrE8K5oIxVDqL1qG9KybOo/gdc5fJ/ztFlfXrsHLx+
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(376002)(346002)(39860400002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(6486002)(83380400001)(478600001)(6512007)(2616005)(6506007)(26005)(1076003)(316002)(110136005)(66476007)(54906003)(66556008)(66946007)(86362001)(8936002)(41300700001)(36756003)(4326008)(8676002)(7416002)(33656002)(2906002)(5660300002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?C9+QQ6yoS7vgIBlcuVUd7/nMXq9vxMvQnNQMlvX22m35skZX60CXbWTpfDhm?=
 =?us-ascii?Q?l3xdhUkTIGCdaUCp+CaLIwOzrVrlv572NuHanzRlzMDCWrpONrWiJr72tFxt?=
 =?us-ascii?Q?Zpkf7veJ8Y2AyTGpsH/o4YMdjmtCw3O/GxSZcywpgRYhiKg17Gr+zRcV2PT5?=
 =?us-ascii?Q?xCqfC2+VFp2tkEB0Hlk58+BpJUgBEK+8/vEPA3Dprqyguab8T2V/PX0PEC9u?=
 =?us-ascii?Q?bY8trLKYZhaABFPHvWgVaFJIKDu991qlnIp+9Rk9U0GaCAVNYUo2/t3EVAP8?=
 =?us-ascii?Q?RvWeMyye1bhEgFnl+aCgsnbhOrnYoC6LXLkxImseEahdCi1wLp4mNrymsa2v?=
 =?us-ascii?Q?l0ShcW42NUgfc8m8cQfMVUWqqWmrp24e3pYhorYMiznG+S8FxkXQ2XCN2VvU?=
 =?us-ascii?Q?mT9KTP+aELb7btgN9mHh2X9evJp1TYfGxyfOjzNpajcmW1326RENcRQJLkrM?=
 =?us-ascii?Q?Fv/uae5ujB4rUXnpiMT5O4DumGsYu/9Tu+ADfAYBdBVfqJr9M5oWoWIRRDKs?=
 =?us-ascii?Q?WwgN7qLD8y0xxwVrFn4mos/nKTuh5gNW/CXZL5uECstLt9lX3gT+mGgZFygw?=
 =?us-ascii?Q?NjmcGrFGFTPkAZRrPKoHBFTgOvo14nnqhrhD5Eg6FkJiTv+AMm3CJCErt1tq?=
 =?us-ascii?Q?djT2NdOWd22kDAFkDPvQBMjogK6D7TDJmBNhT/gpHDpW+/5NtN8a4S3Ccmxs?=
 =?us-ascii?Q?dWPpbQQUVVq4/w4+ZkCD46ych86iTxjq3OJWTXsWEDJdazrmc08CblIpUQf1?=
 =?us-ascii?Q?gsl7sp4UDwuSS5Bk44MwenWBEVDeKj6INWOPyrtIBzlGSGlMLMvSIb29EyzE?=
 =?us-ascii?Q?nYlOKjsGTDxN7Ipvah6+cu5AdAS1LUB5T3yKwIPaonfXygf9s+SXGtCPBgDJ?=
 =?us-ascii?Q?yZShnZC4kBmbVtqvskS2mKAYGTcJTv2Jw3fhFV7e1K8gLTbCJk8ljGaiDNHR?=
 =?us-ascii?Q?pq33twQLsIi04WvagaFW93QIzK/A/2COVMXc+3HhaBG9ftu16RUJEK2Z+Nty?=
 =?us-ascii?Q?lG3w3YpJxHQWnlt34IdfcpQewRuN0DCLp0GsaDHBCFxKKl99n0x/IHMwJSYE?=
 =?us-ascii?Q?evq47LRsfWdWhFuaMRK0pBjfp2UEE98rGtYcccd+tK7CJermdFVLjRVTvXb5?=
 =?us-ascii?Q?yjqLa2qyAFWmPDE7XcGQyW6pfnidKoHRuJD3JvaiXnSDTwI4pdxeKAziKyIH?=
 =?us-ascii?Q?CKujF93oY1FIr9Htg8juoC0t7mt7X8cYutHPFokXFwfQ1ehBz0oLqdkDrYCl?=
 =?us-ascii?Q?1NPykHLV/cdOJyEkCuR5xz+r4o6Hpptl4zfwv3YGcbr6vi959q1tMYEMVi1C?=
 =?us-ascii?Q?DS5RpMxXTzkp8fMab4GnkCxEJ4uLu/b3ovhlE7e9JXHzT8RXO2YQE0xVhkmL?=
 =?us-ascii?Q?XLSK+0KVUSgcEgZzbDGEWae1TagwkvtRwU8LnS10rVRHIUrFgllaTLRB6C5H?=
 =?us-ascii?Q?KTtyNOmnhN8GulrSxM8r246Pkraz5l3E42YgjxpvBjkOG4m29bgDsOVTun4N?=
 =?us-ascii?Q?mFuAU1NLYfKSA/9VO6EthGF09uRZ5Q/rcKAg/XhKgTq9fHfPP4XIOIOmGayu?=
 =?us-ascii?Q?TzSp2aRsFC2i7++aYpTataW+KP2Y4AyRJh5R8SGY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4213330-dcf6-4021-a8af-08dbf5bacf3f
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 17:51:29.4059
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EKlLkHM8FH35IDCHpQTr8eMj/o62hnu1LWbPNQtpcxXhaVfi+EapfuYQsLdIcXOb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5746

On Tue, Dec 05, 2023 at 05:21:27PM +0000, Catalin Marinas wrote:
> On Mon, Dec 04, 2023 at 02:23:30PM -0400, Jason Gunthorpe wrote:
> > On Mon, Dec 04, 2023 at 05:31:47PM +0000, Catalin Marinas wrote:
> > > Personally I'd optimise the mempcy_toio() arm64 implementation to do
> > > STPs if the alignment is right (like we do for classic memcpy()).
> > > There's a slight overhead for alignment checking but I suspect it would
> > > be lost as long as you can get the write-combining. Not sure whether the
> > > interspersed reads in memcpy_toio() would somehow prevent the
> > > write-combining.
> > 
> > I understand on these new CPUs anything other than a block of
> > contiguous STPs is risky to break the WC. I was told we should not
> > have any loads between them.
> 
> Classic memcpy does similar tricks with four LDPs in a row before
> starting to issue the STPs (though there are new LDPs for the next
> data in-between). But that was tuned for cacheable memory, not sure
> if something similar would behave well on Normal-NC memory.

Can we conclude a direction here?

1) I don't want to mess with x86 so we keep a dedicated API
   Are we agreed to call it __iowrite512_copy() and note its special
   alignment limitation?

2) You want to #define __iowrite512_copy() to memcpy_toio() on ARM and
   implement some quad STP optimization for this case?

3) A future ST64B and the x86 version would be put under
   __iowrite512_copy()?

4) A future ST64B would come with some kind of 'must do 64b copy or
   oops' to support the future HW that must have this instruction? eg
   we already see on Intel that HW must use ENQCMD and nothing else.

Agreed?

Niklas, is this OK for S390 too?

> > I'm told it is problematic, something about ST64B not working with
> > NORMAL_NC.
> 
> Last time I checked it was meant to work on Normal-NC (not cacheable
> though). That's on page 285 of the Arm ARM J.a.

This is a relief to hear!

Thanks,
Jason

