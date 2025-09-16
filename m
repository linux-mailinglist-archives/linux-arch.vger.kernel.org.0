Return-Path: <linux-arch+bounces-13656-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2077BB5962A
	for <lists+linux-arch@lfdr.de>; Tue, 16 Sep 2025 14:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56A8A3A78EA
	for <lists+linux-arch@lfdr.de>; Tue, 16 Sep 2025 12:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2872E229E;
	Tue, 16 Sep 2025 12:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Vt8nEguP"
X-Original-To: linux-arch@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010047.outbound.protection.outlook.com [52.101.46.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BC7296BA9;
	Tue, 16 Sep 2025 12:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758025642; cv=fail; b=ZkNhcNfXmGkp3z+i6qhH1sJxu8nsln1ulLMtNJpL2tsvWLvz3BffwEBwYFOBP3VqfhhZTKA0pOrtKk76Nf80cMtBwRlX5GnRyOWxF9IDgNVWpo+MUTFLRNUVzN0hZ8ynbQvNBlCMKDMrOxo5bhIjHrJMs4tu9SprhbAlr/LUFvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758025642; c=relaxed/simple;
	bh=29djyWZrh6FQWgd0h+gLz6NRxpnOsK+wFsaxmpVYnfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=D9YfVo+sT78kw2mIHQ5dSy6ai7R75MkR2q+hOzFNv23soo4jpQeGHy54bQsA65NfMgI8drlJXEeq8y0AmKABuZtZ7b34rU+qh5Stp4UM7L/R3wvapwyCe48lMV4Iy0U8IdpuI0cnRsAy124j/PPxPLp9byAbrO6T9NTllbhlh/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Vt8nEguP; arc=fail smtp.client-ip=52.101.46.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Re6V7JKkGxS1dyWRke8/6wOKDntWZ8yWkxuS8prsBAB4VqP43QrN1FjKEsriiaX5WVcT/XOoiFUHp4378nTypob8bu2UkMOEVxaTaLnkpl/D89BM08e44hdr5A2E2bsDQ8sxZ6rwHQVYn6I2PMwzG7IlUbCJDLb4DcfUa5/wyG5SOfo8hIMGz1pBAWaaYQba2gTgrGvLPnjEVbXTZ3IBWN0X0PFOnaZjxu9Jc37EHDAaPGi4HRKVNXHCqmhV9JBuER2w6UTBH2VjvrA7Bhb+O3L6aOYu+oNdeLrXdSzwu69xr8dEqsOfxeqQxBn15Q1ce3aA7S00G1mdjWuZwIW5tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=29djyWZrh6FQWgd0h+gLz6NRxpnOsK+wFsaxmpVYnfU=;
 b=pRdi9oQpDxDCiVOzDMnib1m7sgBM9x6em2dOt3US/KMEStb6hoxycRaRUqMgqzAErgIbVHTpclds/ZI7+AknsCM44Vpp8cqnljHrEI6qR02Xt6D2Bqwnr5CoCMt19gJMw7ZemDDO7wKhE3dS9AwPH2wSHvJHhBRv6z4hOGMgHteyOjhL75zJxPxf3NySCzR/d+vGtqSju91v2PKbDQV4bFHMnilfLlKAiltWje2GjKWT32CRxxRgZ/VviNXZhbv1PDQjMv83m13r2Oc989h962JjzEBU4qE47f3itxeWWx87dtbPw7WbR2f7GFq86R+B6w3BPj+kxk6ktus7fo0Quw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=29djyWZrh6FQWgd0h+gLz6NRxpnOsK+wFsaxmpVYnfU=;
 b=Vt8nEguPey+90jSx+BiFKH1r00kQAYDB/mOVy7SyVy21l9rFPyTNm8RNbsAXy2j9QgKGnNJsobBVC0RN4Nl7cpElVPwnvhxI/yE988XBUWHitjuApUlGPS+pSfWHJifnbuVtoNAQ046hoeb3oJN4hpn06DdICHX+YOz1fhz4XAT9TJqR0eXzvr0l05xjijGXD0V4DOXKhIiWDZ0++xn9jY6PvuxIqzuB6lFvBXgJJrEsdG1CeH8VPZ8gZ+XfUwvIz3eViL3Aw/CwcYd2imn+ju5wnu5puzu08xzU66s61A4AKzD9MprYLfWNDXAUbCzyQsNRt/HPiJKSOf3gXGyp8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by PH7PR12MB5829.namprd12.prod.outlook.com (2603:10b6:510:1d4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Tue, 16 Sep
 2025 12:27:18 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9115.022; Tue, 16 Sep 2025
 12:27:18 +0000
Date: Tue, 16 Sep 2025 09:27:15 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Patrisious Haddad <phaddad@nvidia.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Nathan Chancellor <nathan@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Netdev <netdev@vger.kernel.org>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Moshe Shemesh <moshe@nvidia.com>, Will Deacon <will@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Justin Stitt <justinstitt@google.com>, linux-s390@vger.kernel.org,
	llvm@lists.linux.dev, Ingo Molnar <mingo@redhat.com>,
	Bill Wendling <morbo@google.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
	Yisen Zhuang <yisen.zhuang@huawei.com>,
	Leon Romanovsky <leonro@mellanox.com>,
	Linux-Arch <linux-arch@vger.kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Mark Rutland <mark.rutland@arm.com>,
	Michael Guralnik <michaelgur@mellanox.com>, patches@lists.linux.dev,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Jijie Shao <shaojijie@huawei.com>
Subject: Re: [PATCH net-next V2] net/mlx5: Improve write-combining test
 reliability for ARM64 Grace CPUs
Message-ID: <20250916122715.GA1086830@nvidia.com>
References: <1757925308-614943-1-git-send-email-tariqt@nvidia.com>
 <20250915221859.GB925462@ax162>
 <20250915222758.GC925462@ax162>
 <20250915224810.GM1024672@nvidia.com>
 <20250915231506.GA973819@ax162>
 <d259ffa9-6c9e-488f-a64f-81025deba75c@nvidia.com>
 <9d4cd8d2-343e-4448-ab59-65e69728c850@app.fastmail.com>
 <0c61ff65-fdc7-43a3-a62b-75e0d76b95fd@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c61ff65-fdc7-43a3-a62b-75e0d76b95fd@nvidia.com>
X-ClientProxiedBy: SJ0PR03CA0331.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::6) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|PH7PR12MB5829:EE_
X-MS-Office365-Filtering-Correlation-Id: 6db59993-56c6-46e0-7d44-08ddf51c6034
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OU9Ki5BgUYy4KaarFG1AujxHmELTeuYLrim9NLvrGqaU4+Ys0dnzCEwiC38z?=
 =?us-ascii?Q?Iy2JyXDqXPqmhe4LFNgbtewYHISR8NRmAVac/kL4x2jA9/ndD2yy+Bt+E7b6?=
 =?us-ascii?Q?njVI7QXKeT/9X0NMaTqaRyNyZwdjvttnWYcFsSDNHI1/RDjl5jimPYPiYoBL?=
 =?us-ascii?Q?MmYUhNJPTU5sb4e9U7iQD86nAa4ZOkXRSF/TWKaTEEb+DGJEkhKzD2FgaMp+?=
 =?us-ascii?Q?+3k359AABonpMOHYgXo2/kmW9t/9dY6Dd577+R7bjm9Y1cnbBlnc6sNpBwxT?=
 =?us-ascii?Q?g+uA+QmUv5btFthNuOP1h9TcYiMo9lJdfxxQbwrQaUMjMbDdN+ssjfEZXt80?=
 =?us-ascii?Q?nnsUgHwfl/4ioMQwj3yRjsN2/GNwBcENg8vMpRQylzvo3yIREg7LZrnlg1q7?=
 =?us-ascii?Q?Ju3TNHYGz3XJuxLco8HoPvfHHNEsVooI5CpNtMFViNobVgXQGlJU1MzGTvfb?=
 =?us-ascii?Q?cKwP0cuPM8TkgyiKwuBYRelvsCKtnKnXfgqtloKnkFkcmEcTm+MmedqTdVo6?=
 =?us-ascii?Q?9CGQ/YjmrreMFB+3c6x0x1kpPNvi6t4QgmiwGNTBdkYin0RsxON6dh3wHvBB?=
 =?us-ascii?Q?kzEUXArVVV6QHq+L0HRhUXACS7DKAF3f/RYd9DsgMVd4R0KuCmWkp2i+Dt51?=
 =?us-ascii?Q?j6/PSJHuwUiyGpgKsYfWnrfEd2zW+P7nR8qlDat+5vYzMAPV8lCd1L3rM5Ao?=
 =?us-ascii?Q?77e5xcexT3xNVPm8rAKV8w1JuxVvqKyrUB3f8DyzZei9nuTZuAUJt4CM3NcK?=
 =?us-ascii?Q?2XxN4BtNW87fRVWCo1J5xvXbKtfUDlYQRmeD0UV6olFbkYULwzPgutdFcUam?=
 =?us-ascii?Q?dgEfw8jFHSkYD8xoPXNeu61IWNQlhUFszTMvpu4iyUPcHuSZ4LXeYz9u0Yc7?=
 =?us-ascii?Q?L7CJ8FDIZJt2Tw3EXiyMPtEQcufnfZZSn06ed62HnM9Lk2z7RR1PpDGTZrrK?=
 =?us-ascii?Q?dQUacdXHHJcV1/igV+bQA+CNfnHNm08Hly5GlQ/fwFdG6i1m+vCW9XbwhJd4?=
 =?us-ascii?Q?Mm/Ux/wpzRaAeiawaarpxs08rh1Vu9JhoTe9ZeRofRkKAWllxW8C8YpY8AQe?=
 =?us-ascii?Q?Jln2QdUqw9CdfF9WzocsLgzdWljVJ7ft0EanbB79qVo4D0rYHu3qIydrMsJ5?=
 =?us-ascii?Q?EBOkyo3BTbZGjYF2PMDxtDWwNWdyppUKFp3tiJk9vv4Ub2eth3Tn9FKGuDYN?=
 =?us-ascii?Q?Qop6X0NpmiLsQugn3TCfMJOa/eXTwaPr396VfACibmq+TLHI/+iZMZ77PcvU?=
 =?us-ascii?Q?/RDSxNoNVS/aMV9MgTl0ik3j8sjJ6HqLScDumn2/xqSldMdlFMBg2BEK8oao?=
 =?us-ascii?Q?X9zhpSZ1qxKVFcDcF86Yrt0YeC/5QhylSit4cnfccjJbBa2KiQbOhaCTjKsl?=
 =?us-ascii?Q?ELWc0VPhvcmmahAOlk483w6MResxRl+LFMqQXc1isJYj50aGww=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CtOLTFf7jAByejLRQNvzsni8x5e0USv+UUhr+cPyg5U3PHDO9uA77SljLLgs?=
 =?us-ascii?Q?M3sxPrQRXGcjdwFOuEd4DJzEUnLAa9gSSAIkJq8V9DVj0s5tN7HtuVZVZHDm?=
 =?us-ascii?Q?gEjomOJugw7poRYwfZN5Fsipugr3tNAyN2pZ6isbe4LhT6oVsZzXG5X/mzG5?=
 =?us-ascii?Q?6xzqfvBD9VVxhUsx17NDhbFPl/17PMeqdf4eWfc4EU0NEttJj/e2XzbpgomU?=
 =?us-ascii?Q?eFuD2ROtWwFDZiJvqM/n4V6gAdLe4cJnLYvo+2Qj3q0Z6puise4Vkm2ogpnp?=
 =?us-ascii?Q?2WJkvsSr26Kgp2E5/mVAB7NR/1uv7qrSgPp3BRSGS3v+JtJNUuOhCZBSiD1B?=
 =?us-ascii?Q?9EKGt8vdZUE0614jo3s+yi1ixCaZ5E/lL/kjms5/jk9V6YA6yKnvtbBUHpoZ?=
 =?us-ascii?Q?i9atRkcKFg7ACx/utCty8J3+pWWAqM2035LEjP+mioV+YNKp+gQEoD6/URYj?=
 =?us-ascii?Q?Mu0dfnbA8Ly8dbHw98a0TDFDkTV1Kyt7DLOQEsYnEthXztvoJUrF24F3i6eA?=
 =?us-ascii?Q?zcAPSpNCN1cNXACIcgWE3lDAQPjzruOo/au5bQ34QxmXHXEa1RxkIRNAOwRi?=
 =?us-ascii?Q?A011fFmzIp/82o+Hn5HG6kIupFNjOFIDMlQIvvYMCts1G7cmjc1S/OYtv+2u?=
 =?us-ascii?Q?jOhdSGDE5rjZ5dhOI5pPDsVMd/s5z7NoVzxoRLCa3P8RlL7UKedGGKtCKtY6?=
 =?us-ascii?Q?IFpmKuMHJRUaZO7IkV9MDTB2Enbmj7imiMvMopviBBf4BEYj9pyw4FG/MH0S?=
 =?us-ascii?Q?dWJEkf/d5Z79udyJV1aE6OZVsgdsDFOTUijUErmXriZXKWPuZbqZRcOCNMFM?=
 =?us-ascii?Q?JmkH3k5lrUboolVqoeYT58ZVwxM4MhIyHVUuLXHPKGOEReWWh7Jwn+cA50Jk?=
 =?us-ascii?Q?9mR248kZZCDAAw6eWyyafJKRk2XWaN/ZIXmLx22jLMWj05rJayxOQyUK5JcK?=
 =?us-ascii?Q?e/dSEcXpmIcTosuzBbXXAHLe6ACwng4aGVLYQInaWILeEOLINba4FCnOINnj?=
 =?us-ascii?Q?JuLpKihbHt+PhFVTOv709NilF0k+gtXJezxGOxXmDV66m+YZP3NBpOF+rFjw?=
 =?us-ascii?Q?Ws8e1uinkDb3TBON+bmJ3nxK5Ca4s/gwDedg5w1p5GGvAHVgikxI2XyXqU62?=
 =?us-ascii?Q?6ielbc6SIohidIGtwsuycrYj5gjBdfR9Tan1tw92cIrgReRyrf8x3HCDK4/O?=
 =?us-ascii?Q?Mn/6PiDT9m98f1ioIZD0uUxXvn59J44bRZ5ujCS8ogc6HelF9pFUlZQlzkCz?=
 =?us-ascii?Q?nin665tVBIy3useAT8Sjo8y6Qy76TElnfDfv7fvUwKCUz58gi+JoqpUC1u29?=
 =?us-ascii?Q?6uVKYE4kWeFNOzLV2P50RKtIau9XKc5hYyxgxnSBPFQVhMnjfmxGDabit7+N?=
 =?us-ascii?Q?nwX01+Flxn3hE6xyOpMYxoPL3hpvLEtMZvg9Nr3RCsKAMKFln0ojGdIuX12W?=
 =?us-ascii?Q?vyQK/m9Qaig78g6hQ7h9kRjbXcSwpylNI9hT3gnKO0j6rwJvdbSomKO394cc?=
 =?us-ascii?Q?ELYy5bm5b2QQvgVY5iJskPQSNwZ3RslV7dUJkrlvdngJzwWV2B9vkeDZ15D2?=
 =?us-ascii?Q?u6OSOhKik/bms/z1wJOKBn8zfF97ags6C8Fn3dxo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6db59993-56c6-46e0-7d44-08ddf51c6034
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 12:27:18.0839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J9q2YrQv6nL42m1nrY0cv6NTsh+yEItRzcOCgmp9v0gY2tdCuaJIDmrjs7/mkfCd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5829

On Tue, Sep 16, 2025 at 12:47:17PM +0300, Patrisious Haddad wrote:

> Using the correct CC flags by itself is sufficient and correct - and I don't
> see other neon users using the ".arch_extension simd" you mentioned , so why
> do you think it is needed here ?

If you do it as Arnd suggests then we don't need a another file,
makefile changes and so on. You can just drop a 5 line inline right
before it is used.

Jason

