Return-Path: <linux-arch+bounces-5364-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6CA592DD6C
	for <lists+linux-arch@lfdr.de>; Thu, 11 Jul 2024 02:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 615BF1F22645
	for <lists+linux-arch@lfdr.de>; Thu, 11 Jul 2024 00:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2751F20E3;
	Thu, 11 Jul 2024 00:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DR+EEvwa"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2085.outbound.protection.outlook.com [40.107.212.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35ACE383;
	Thu, 11 Jul 2024 00:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720658670; cv=fail; b=eGTb/j4PA5R17Mq5+mU8YF0f90h0/A7Nuj6/VFm/ppEDkdsRg0P3QV8v0cJBmI2D1PSLOweiMjoNnrGQL9cn0twofNzAJfdLIF5lrE/QNf9apzL0ZAHCvsRos/DSvaNgfVCh9saeBFaZA9Yyzi7QFyUFpl0dvARrJZEe9I3ap/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720658670; c=relaxed/simple;
	bh=TYfwOXmLubC4g0e3I+XdV5kIpT1cOg0vflWbWXcJLdA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Y9hEqFm5m4hZCIPk5Ygc65yYS3DHgqhGYQUsnpoIZF4nla7yujG2SZ/AS2qGitrbcc8UjRtOtlw8CvzcI9e1jOzZicgqCw17QNewGOAhW+3kM4CivBunY1Mm7c9Fm9s66UIk3Ob8aQVuEFJBgqvdPXfwhf+d4f+riRvBPsRwMkc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DR+EEvwa; arc=fail smtp.client-ip=40.107.212.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IXDb3JaXlSPblqEwemI37Oz1l2NAHPaun82ABWukTJrFAeJW2VlzyAI0B4r3TRToX/AlCJFM/g4QCvt9UtjPPtcTLUGWDayb8cdSlm8jKOYp7+uh7Q0UammiadJ7suSZIGzyaoVz2kdZvtbPsyoz4ZSmwrj6b7tGjmG2ie0vkoAbZ8eufyNQANCht5aUm7JsjyiT7Q6dcVJKsVpvLUc2m/KZ703vjrTbEe4g9ZHOT8F/ttkpVYL/0RSPySY0qbjGXAj6xp8SX4xRwdwBrNXgwKG65zw5Zl+zo8UBlDE7Wks06MYDefkAyTmwyJYsQJHB9gLi/s6toE6h50ijlW3tjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tUEpflRZnlymYQAGmmjEq3TEcnmsZwEGYMvytPvaT6k=;
 b=aGPnd+jk9lW72uwvB0KtckpzUVJSkgub0TvzeMp8TBQbZ1uC4VWknF98y5Q2P5fCRypG2qsk8lapW7v36rrAPVVdql+ckRuhW19SdV3SDgdIqE1iGCjGZZ/rYu9HqbvKhpta9uljRj8FPcOuyD0nuKuwxq6UAbO0ihnVbAeuUaEHml90b639yf9b7NKlsy5sLRA9Vscy/ZiCQ8RQRPqUkaQZlh/5Wcz21qpspyKos2FXDe8+6QLKcba76xy7wvgm2zjgAVyjDT9M4GQqbOzQg2aBPtoDRgu6Y6ha9bupYEhrrZDWoX5LQcvaj6N6WdPjjknvWflhaWacdeg1dXGR5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tUEpflRZnlymYQAGmmjEq3TEcnmsZwEGYMvytPvaT6k=;
 b=DR+EEvwaeicfPe/Xs04TYlhU8y547JA/5HvuHTBFn9Gs/uTvyBUFk/fTtHS4VNmsZsZxB9szGHSoSuYWzcucDL9AY7mA3LqyjhLHA9K8RB59xf6+h5LaKkYXcJgu8PTQ3G21UDnxEkGnVBfl1RvqsiMONutIlMiV18eBOSq6U8rZxhfClf2zaQvfLfJ7C4J4nNI16qbsU87pCXM+/iqxF6g433L60kvrrt9RtvNrY+pdr0Px2WiqMkhNnxSvAK4SK0VYs1UlaF+Y98Mo4gkJ+wlF+OTLwC6dI8ZRKjeY9OT8iKfxP+bQ5N9Pb7nHDxy0X1U+yw74IIRQamDTfAsjdw==
Received: from BYAPR01CA0002.prod.exchangelabs.com (2603:10b6:a02:80::15) by
 LV8PR12MB9208.namprd12.prod.outlook.com (2603:10b6:408:182::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Thu, 11 Jul
 2024 00:44:24 +0000
Received: from SJ1PEPF00001CE2.namprd05.prod.outlook.com
 (2603:10b6:a02:80:cafe::dd) by BYAPR01CA0002.outlook.office365.com
 (2603:10b6:a02:80::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.19 via Frontend
 Transport; Thu, 11 Jul 2024 00:44:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00001CE2.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.17 via Frontend Transport; Thu, 11 Jul 2024 00:44:23 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 10 Jul
 2024 17:44:09 -0700
Received: from [10.110.48.28] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 10 Jul
 2024 17:44:07 -0700
Message-ID: <4b0479b0-1e0f-43db-8333-26b7a1fd791c@nvidia.com>
Date: Wed, 10 Jul 2024 17:44:03 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v16 12/13] selftests: add ncdevmem, netcat for
 devmem TCP
To: Mina Almasry <almasrymina@google.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-alpha@vger.kernel.org>, <linux-mips@vger.kernel.org>,
	<linux-parisc@vger.kernel.org>, <sparclinux@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <bpf@vger.kernel.org>,
	<linux-media@vger.kernel.org>, <dri-devel@lists.freedesktop.org>
CC: Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, "Richard
 Henderson" <richard.henderson@linaro.org>, Ivan Kokshaysky
	<ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, "Thomas
 Bogendoerfer" <tsbogend@alpha.franken.de>, "James E.J. Bottomley"
	<James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>,
	Andreas Larsson <andreas@gaisler.com>, Jesper Dangaard Brouer
	<hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, "Steven
 Rostedt" <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Arnd Bergmann
	<arnd@arndb.de>, Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>, "Willem de
 Bruijn" <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?=
	<christian.koenig@amd.com>, Bagas Sanjaya <bagasdotme@gmail.com>, "Christoph
 Hellwig" <hch@infradead.org>, Nikolay Aleksandrov <razor@blackwall.org>,
	Taehee Yoo <ap420073@gmail.com>, Pavel Begunkov <asml.silence@gmail.com>,
	David Wei <dw@davidwei.uk>, Jason Gunthorpe <jgg@ziepe.ca>, Yunsheng Lin
	<linyunsheng@huawei.com>, Shailend Chand <shailend@google.com>, "Harshitha
 Ramamurthy" <hramamurthy@google.com>, Shakeel Butt <shakeel.butt@linux.dev>,
	Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi
	<pkaligineedi@google.com>, Stanislav Fomichev <sdf@google.com>
References: <20240710001749.1388631-1-almasrymina@google.com>
 <20240710001749.1388631-13-almasrymina@google.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20240710001749.1388631-13-almasrymina@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE2:EE_|LV8PR12MB9208:EE_
X-MS-Office365-Filtering-Correlation-Id: e027ea6e-9d80-4d4f-6be7-08dca1429c32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|1800799024|376014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?amlSczV1cSswOWxjRlpTNDNyMVFMaFU1QVhXVXZ1enErSVNQKzUwNTVKcWpt?=
 =?utf-8?B?MmpSMW4vazFpeEdYZHhidHd0Vm9RVDF3VFJtcnB2ZHJVVm1ncUZQU2tPdEYx?=
 =?utf-8?B?OEQ3eG4yQ2V5MnpFSG1sMzlDdEpjb3Z4NDVpaE5Tdk1FbDdLY1NleGdKL1JV?=
 =?utf-8?B?QzdDQnc3U1hNbjRsYlIyaU1Nb3B3RWRkYTlKLzlRR084WXdIa1hMcFFzWWpa?=
 =?utf-8?B?QmQwMVZ4OUJDTFdZbmdoN05MZ2U4WUd1cGJDVVQ0SmdtUFFJUk44YlpVbDFU?=
 =?utf-8?B?NzVtYTEva1plRnk4NHlGOGtGdElDY20vemx1VWZLYU4rU2s2K1ZPRnV5alk0?=
 =?utf-8?B?Q2taaEUvdE05Smh1aTFOTEJTRk93Q2UxN01XOXo0MG5QUFgxU1YxTXNRU204?=
 =?utf-8?B?cjJyZ0RobGVQSkFwK2ZwemJCQlhZUnVYSmJ2eTcwbUNwd0tNUFpQOU5HWEt1?=
 =?utf-8?B?Q0RpclhsL2hBUHFqamF5czJHRHdIRFViVUxOWVFKZTNrQTE0dUJISncyaGtU?=
 =?utf-8?B?UHlITlpFZlk1bEk1T2dEa1JTMlQ4WHdCaVlCcTk2SURSbGFNdHQ2VWZHNG9x?=
 =?utf-8?B?Y3dFMUREUDFIa1ZLUWZybUxFeUE3S2dQcTI3U1VieERrU2h6c3g1d1lYTXNH?=
 =?utf-8?B?S3RjUXd2eE85eHJrVys1QXphUm42QXhBZXA1NmJ3N2Q4eXIvYUozazR0VzdI?=
 =?utf-8?B?OWlJWGN0V1M4azZWWjdNd1hjZDBra0duUnh0NnF1TkhLdU54bGROK0VXM2h6?=
 =?utf-8?B?SmhCcXNwUjNvUVJUaFJqOXB4bDF2R3BJNmROeDQ2Vng4QUJpM2Y3QkxMQ2hv?=
 =?utf-8?B?NXYzdG9zSWFZbm9UMVQvdTVFQ1hoUkw2K0srTE5ZNUVEY3B5dlVFZnhGMHN0?=
 =?utf-8?B?d0w0bHJ0bzZ3eURnTHhnbGx4RUMzN3h3bXp5NE5EbFE3TTFWYkpLSTVQUjBL?=
 =?utf-8?B?cE1rY3YzNGp2MXVCdjZyT2lwOC9pdTdzMVJFc1U5cHloVys1Tjg1d1VmUmpM?=
 =?utf-8?B?MUR3eDlMVWpacXFQUmhEbm5HU3FaZ2hqTktWeFpBQy9hZWxHWG5qQm9EYnF6?=
 =?utf-8?B?QUhFMmtTWERxd0ljYTc5cUVsbVVoN0ZCdEMyMm1iWFFwODFuc3h3Q1l6ajQv?=
 =?utf-8?B?VHNUYS9zTTlDTjdTQ29Xd0paa2QxbTlIbERXTzRJbjNIQ2Vhdzc3OURJRDJX?=
 =?utf-8?B?SkoyZkQvTmVua2NwWDRMbW9sVVNFSFdkMG94NW9lRU5TRU9ldjN0SDVRRDY5?=
 =?utf-8?B?ZE5BMjJxa0lkT2lEWXNFek95MjlNTmVYeWJ3SVZRRkhiRHlYUTZRTEloeFA5?=
 =?utf-8?B?ZGkxNzhUR3JSM2JoMDFIMEd0R2Q1OXlUYXJVMTAzZUFVMWgxN01DTUlNZVVs?=
 =?utf-8?B?TXpDVU5yR3o5UXVTdVMwd3MveVZGb213U1M3MUQ3SytGMUxWek5lWkpNcVo4?=
 =?utf-8?B?WkJiS1QvUnJoSHdKUTg1TFhia1dKV3RZTVEraE5GQVBMekVNZzloNjlqS1pv?=
 =?utf-8?B?UWMwS1hmVHFYNGxlREJYTDFmMkp0Rk01UXNiQ0VoTTNtS3kzbS9mV3dvVXB4?=
 =?utf-8?B?ais4Y3AzYytkYS9PYjVsTk0vZDh1QW9pVXdoUi80YU0wOXg3WHZ5UkpiZEVE?=
 =?utf-8?B?ZjhwUWprUGlmdnpHb0YvT1NvR09VUHZkOUVqZUhLNlJyanpaWnZTend6Mzdj?=
 =?utf-8?B?MGhGU2FkZmFOZGRwUExUK1dCNUNKeE5TYUxPMldqQ2hxSTFVOXNqZkJzQXdZ?=
 =?utf-8?B?d084NmVSTDV0MGJUb0RkSS9rOWk0MzlVYzdOVHpleXF3YUpNQk05K3JPcGJs?=
 =?utf-8?B?OFExWTE5T1VMdkVlU0VHU1gzWjI1T1Z5eWppVGRtek9WMlJtVU4wVDNFU2d0?=
 =?utf-8?B?V2R1Tks2RjFGRGpFV2poemRvN0pjR0tSWnc0azV3cTBraitTNlZZREpoN0Ry?=
 =?utf-8?B?MHU3MDM2WDMrKzFVeXdHS3ZiTnZRWDY5WjFsVUorMVBLQi84MVdmaHptRnFy?=
 =?utf-8?B?QXVpNXdORzBRPT0=?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(1800799024)(376014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 00:44:23.9137
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e027ea6e-9d80-4d4f-6be7-08dca1429c32
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9208

On 7/9/24 5:17 PM, Mina Almasry wrote:
...
> diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
> index bc3925200637c..39420a6e86b7f 100644
> --- a/tools/testing/selftests/net/Makefile
> +++ b/tools/testing/selftests/net/Makefile
> @@ -95,6 +95,11 @@ TEST_PROGS += fq_band_pktlimit.sh
>   TEST_PROGS += vlan_hw_filter.sh
>   TEST_PROGS += bpf_offload.py
>   
> +# YNL files, must be before "include ..lib.mk"
> +EXTRA_CLEAN += $(OUTPUT)/libynl.a
> +YNL_GEN_FILES := ncdevmem
> +TEST_GEN_FILES += $(YNL_GEN_FILES)
> +
>   TEST_FILES := settings
>   TEST_FILES += in_netns.sh lib.sh net_helper.sh setup_loopback.sh setup_veth.sh
>   
> @@ -104,6 +109,10 @@ TEST_INCLUDES := forwarding/lib.sh
>   
>   include ../lib.mk
>   
> +# YNL build
> +YNL_GENS := netdev
> +include ynl.mk

This seems to be missing a rule to generate ynl.mk, right?

thanks,
-- 
John Hubbard
NVIDIA



