Return-Path: <linux-arch+bounces-8384-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A82B9A8EC5
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 21:26:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5DF5B21A68
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 19:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2608F1FC7D0;
	Mon, 21 Oct 2024 19:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iHV3Np99"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2049.outbound.protection.outlook.com [40.107.236.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8061FBCAA;
	Mon, 21 Oct 2024 19:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729538743; cv=fail; b=f9jItBON85XCQP2VumtK0Q9ACKkWd6EvXXGwlMHjV16DyJD1MNfg/8NwD21mcoc3IDvOs7mBQD1s7dvWUdWjKyv0WvhTKY/L6FHqbz5tuSqdNoEsnSr3aIp1mAP9zAKn+Qawv4QfMDzd09JXd7iwoWVXEPbxfteNJhwPxuaeo4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729538743; c=relaxed/simple;
	bh=yl/f6nmrj4bJkC2hnoSW2W3moUZceUgClX1Y0P+anE8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=S1s5rw/XoMpCiSOyN8AwwKYQ1f3TbmGVCTi3PkeaJynlxnDO1pBa3AXa6hmyq9ax+lnKpUzjE9sdlmfDU6z6AmqomDgcK7G52kyhOuEq5xBaJoSqlmV8hsUwam3rxjMr+RYJyIcpXZNwWgaAMnqQjXZldHlKS06gXCnYh+OED9E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iHV3Np99; arc=fail smtp.client-ip=40.107.236.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rM9A2xv4lXe3pS1W8l+eT7kAoNxzlaZGko85Kv1km5EMUekHPX0b+SPW7skdo3jW/+3bLneOvtDS6mMmRk+vRuj/eqfVBRSlQ/xH1rccUDENTc8Q80LhQWBE3IsHW4msmR8anFn7ir8QgBU9hLVKKktiQokRIOfFR1qrxGrqOTV4wHgK32tpAzuD528YIppoOoxSPqJ0+6ZvcigUnW97pzR0MS2Jq3Y0jiaS8+57YJfXLXxDtG142SB52rnFbkFlQX5jFHP4K4bGv2v5K0jO6gqUlpIziIpcqHgDw0PsmN4UM/Jxip2bUhHTmEiui1Oqco411QjTWzuSLaSVznCZYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+O0+SiJoFRHBTL1jfFln/M7VElXY4xPBomcz20IIpYE=;
 b=F1Ic3Gm/qB9aXMeT6hzOy4u5yCvgnZKoCKXJcBoiM26MkLz7h5ojesy0bWKj5laHK4heYUW3EJUMoxqlyumFNZl9Ko1yUqWICqLE+2/m/s/Wf1U7LxddC4YVSlBdcTSZrdTpIiVwI7t4ZtxcWazo9pGW6RrfYnYI9Hc+z3kqpRzQAKbbn1q8FvpAF4n8oS/bB4enS7XYS0c2tJk/mCFV17LicqeNmGF8hSLlBM9namDFIk9cabaiymsUE6jJAc2qthzTEcS7AngHhVLU7n8VvPnTphvWXXtpNJ5Nm02DItNJkj6wmJ+XvC0fYNpobURPs1xWrmywSUPb+1dFbCWYPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+O0+SiJoFRHBTL1jfFln/M7VElXY4xPBomcz20IIpYE=;
 b=iHV3Np99axxdZ5k3OKkrCHoH7w3C+5HtyY2+5dwiNsy/JC0rr0WBDJl1uQTpWsJA5APd3S9Qi5O/ir7w/9JZBetducUCtf7gL4w2IxopRhkoqZJ25+rxbysHyy50k8Lhs8HXQwiZUM70US2g9dWHnjTRenyYiuSWyRMWofryYg9v4BTxeFExcho2+GbfwQ6F+Gm+osUpgsTgsbsEOclpc9Di3ZX8zYCxvJzJUFxQDpviwSp6DpLxRsA/ChWPoNgJjg181Vpn9soeVo8hVamkUvLt4jKfSfVtqQFqyX6wv/xDxWq0gbLSfcfONJubwaDDLXzidQpKVwCK/5VDUrj2wQ==
Received: from BN9PR03CA0944.namprd03.prod.outlook.com (2603:10b6:408:108::19)
 by PH0PR12MB8800.namprd12.prod.outlook.com (2603:10b6:510:26f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 19:25:36 +0000
Received: from BL02EPF0001A103.namprd05.prod.outlook.com
 (2603:10b6:408:108:cafe::42) by BN9PR03CA0944.outlook.office365.com
 (2603:10b6:408:108::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28 via Frontend
 Transport; Mon, 21 Oct 2024 19:25:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A103.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Mon, 21 Oct 2024 19:25:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 21 Oct
 2024 12:25:14 -0700
Received: from [10.110.48.28] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 21 Oct
 2024 12:25:14 -0700
Message-ID: <3baf8814-0a9a-4de0-b568-62d241dbba0e@nvidia.com>
Date: Mon, 21 Oct 2024 12:25:08 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] mm: madvise: implement lightweight guard page
 mechanism
To: David Hildenbrand <david@redhat.com>, Lorenzo Stoakes
	<lorenzo.stoakes@oracle.com>
CC: Andrew Morton <akpm@linux-foundation.org>, Suren Baghdasaryan
	<surenb@google.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, "Matthew
 Wilcox" <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>, "Paul E .
 McKenney" <paulmck@kernel.org>, Jann Horn <jannh@google.com>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, Muchun Song
	<muchun.song@linux.dev>, Richard Henderson <richard.henderson@linaro.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, "James E . J . Bottomley"
	<James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, "Chris
 Zankel" <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, Arnd Bergmann
	<arnd@arndb.de>, <linux-alpha@vger.kernel.org>, <linux-mips@vger.kernel.org>,
	<linux-parisc@vger.kernel.org>, <linux-arch@vger.kernel.org>, Shuah Khan
	<shuah@kernel.org>, Christian Brauner <brauner@kernel.org>,
	<linux-kselftest@vger.kernel.org>, Sidhartha Kumar
	<sidhartha.kumar@oracle.com>, Jeff Xu <jeffxu@chromium.org>, "Christoph
 Hellwig" <hch@infradead.org>, <linux-api@vger.kernel.org>
References: <cover.1729440856.git.lorenzo.stoakes@oracle.com>
 <fce49bbbfe41b82161a37b022c8eb1e6c20e1d85.1729440856.git.lorenzo.stoakes@oracle.com>
 <b13a83f4-c31c-441d-b18e-d63d78c4b2fb@redhat.com>
 <b2bca752-77f3-4b63-abe9-348a5fc2a5cc@lucifer.local>
 <c8272b9d-5c33-4b44-9d6d-1d25c7ac23dd@redhat.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <c8272b9d-5c33-4b44-9d6d-1d25c7ac23dd@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A103:EE_|PH0PR12MB8800:EE_
X-MS-Office365-Filtering-Correlation-Id: d57fb43c-a333-4362-5f61-08dcf20623d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dFZ2dm1BcTMreWtpZGFXSnZUNXlpZGZURjd3cTNKQnBYZkhEMWx1d1BkS2Vr?=
 =?utf-8?B?VElFd25abHZ3Mys5MWVoNFQ5SHRkTEJkYXlnMnlBSGo0K0JRNVYyRGc3VVRa?=
 =?utf-8?B?MHh0bUFKdDZSZWVSYy9iQk9EdlVObXBpYWY0WEt3RGR5RWxyQXpUTnVuZVFq?=
 =?utf-8?B?aUN0TFFVaWh3bUdXdHZNQVJiaDJjRG8vRUs1NXEvRVFVcTkzL2lTTE5BOVhp?=
 =?utf-8?B?dzNRclRkV2xtZStDVDNIUmZJeitGWDZlUXhOekFDd09PVFFsSk9DbTZoMDdH?=
 =?utf-8?B?TExVVThLMFh4WnlEczdKRzErQytWSllsUE1NbEhLNndnT2ZxeDBValAvYldi?=
 =?utf-8?B?NzRsaEd1N2dWKytHRGRuTFBEVG4wOXFvYVZDVEFzejQwNERFd2s0RFhCVlpK?=
 =?utf-8?B?dHpFUHlaS3BsRkJyaUl1RlZHVnRlcFR2WmFTRGNsWDRjUXgrbUZjcTVhWTJj?=
 =?utf-8?B?dUZVN1JxcmFVZTg1anpqWnQvblBFclU5T2w3Y0ZqSWxvNlJTUk9heFhkQmhE?=
 =?utf-8?B?ZHR1UWZLVlBjVHlFSlpUa1lZaWNMY0FKNmNTM0FXelJnbDlsbi9rak9xeEg3?=
 =?utf-8?B?Vm5MaEdNZjZzemJkQ0tIa2dvL0JuZlJMSmJ6WE1Rc3RDWkxKU1NyS3pxZVRO?=
 =?utf-8?B?TTc3aHdIWFAzVDB3alpvWkRaU3o1Q3d4UTRKL2g3dXF1N25TSkxtNWZlWWtu?=
 =?utf-8?B?c0VENUZFNzJxRUNpZkVKR05hdmdGbkd0TTdrODlCQnpiOFlQdlJjZnkxaWpM?=
 =?utf-8?B?Wk43ZTRWaEZHb0pibUZ4RWdGMloyenBHV2JFbEQzNjBJbHZiZ3BRNVZyTHFs?=
 =?utf-8?B?ZzcyRTJpd2dhb21zTkd6QVlza0w2TzJmTHVzb1dDR3YrVVFLemtWSUliT00y?=
 =?utf-8?B?bFJDZHhkN1FLRG5zdmkydVBtdHJ1NVUxRXBnd25qVVllRytScHZnbnV1M0ZF?=
 =?utf-8?B?T1lXQ1JlOWVUU2JMSk5ON3FuM0UrUS93cDYxaVRveFdSU1FCMzhLenBCWEhU?=
 =?utf-8?B?a0FNdTNwcnNrUzlrWlJaK1NFMWx3ZjlIemZWU0owT3BBUStDUjh0UnhrWCtL?=
 =?utf-8?B?MVNJaWdKdGpXcU1nbFJncDNDaG1FaUVFSGdLdW8rcy9QalR0RUxpeXI2YXph?=
 =?utf-8?B?MFdrMzFUV3JES2RFdktjMXU2MkxSNG5MTXJVaWpGY3Q2U2dKM29LUlc4V2d2?=
 =?utf-8?B?bElxckVtK2MxWUtWNkI2YkZRM0c4S3liRGFreEc1dENLQVEyVG0xdHduYkow?=
 =?utf-8?B?VEYvSzZIUnFZcFc4MnFreVpBdDFLeHVUT01OOEtTM1pxQzY4eEFnc0JBNnZx?=
 =?utf-8?B?TzhjQmsyYUdKMSswckZkMDVNY3d6ZlR4ZHBQeklRS0ZJL2pWUkdxNEwrUXB6?=
 =?utf-8?B?VXJydTJmOU8zUzZxTmhwbitKSTdGL3JySHlPL2h6UUtWUmd3cW1TOTgzczdj?=
 =?utf-8?B?OTQ3M1l0RFBLVEthNHkyK0twVTBXazk5SHhhakRzbklPWHo1dVJHVlVNRS9z?=
 =?utf-8?B?V0ZVRDNURlB2L3FheVRKdkl4c2JIOUZXdEI0Mjc1QldCMXJBS21KeFg1V3hu?=
 =?utf-8?B?NnJYSVIxVTlpMVE4MStaTStqZTlPanFyQnRMZGYrY1ZMOFVEbnVBTjlLT09h?=
 =?utf-8?B?dXY5TWc1ZWF3d21aMUtkUFIxbFk5YnllenNHeitVc1d6dEI0dVJOa0IzMTFM?=
 =?utf-8?B?RFk1LzFnMUlpa0wzaVFkekVHVW0xZndSVUQzMHV3enNNTXUzamc5aDdlbmN3?=
 =?utf-8?B?R2hZQmpMZWVsZy9ocVFHYjhmSGRSeUZqa2h1STZna3pid2FIOVJSb1p5N3Zm?=
 =?utf-8?B?Q2dGNTZmNlkxZFUvd1pzVis0L2xtbG54UlhBM1VpWlpZeFh2L0FsOW53Qytp?=
 =?utf-8?B?TjFObHJnR05sSi9oMEJwcE1xTkxkVzNpQVhlZVNqU3pDWUE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 19:25:36.2738
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d57fb43c-a333-4362-5f61-08dcf20623d4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A103.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8800

On 10/21/24 10:23 AM, David Hildenbrand wrote:
> On 21.10.24 19:15, Lorenzo Stoakes wrote:
>> On Mon, Oct 21, 2024 at 07:05:27PM +0200, David Hildenbrand wrote:
>>> On 20.10.24 18:20, Lorenzo Stoakes wrote:
>>>> Implement a new lightweight guard page feature, that is regions of userland
>>>> virtual memory that, when accessed, cause a fatal signal to arise.
>>>>
>>>> Currently users must establish PROT_NONE ranges to achieve this.
>>>>
>>>> However this is very costly memory-wise - we need a VMA for each and every
>>>> one of these regions AND they become unmergeable with surrounding VMAs.
>>>>
>>>> In addition repeated mmap() calls require repeated kernel context switches
>>>> and contention of the mmap lock to install these ranges, potentially also
>>>> having to unmap memory if installed over existing ranges.
>>>>
>>>> The lightweight guard approach eliminates the VMA cost altogether - rather
>>>> than establishing a PROT_NONE VMA, it operates at the level of page table
>>>> entries - poisoning PTEs such that accesses to them cause a fault followed
>>>> by a SIGSGEV signal being raised.
>>>>
>>>> This is achieved through the PTE marker mechanism, which a previous commit
>>>> in this series extended to permit this to be done, installed via the
>>>> generic page walking logic, also extended by a prior commit for this
>>>> purpose.
>>>>
>>>> These poison ranges are established with MADV_GUARD_POISON, and if the
>>>> range in which they are installed contain any existing mappings, they will
>>>> be zapped, i.e. free the range and unmap memory (thus mimicking the
>>>> behaviour of MADV_DONTNEED in this respect).
>>>>
>>>> Any existing poison entries will be left untouched. There is no nesting of
>>>> poisoned pages.
>>>>
>>>> Poisoned ranges are NOT cleared by MADV_DONTNEED, as this would be rather
>>>> unexpected behaviour, but are cleared on process teardown or unmapping of
>>>> memory ranges.
>>>>
>>>> Ranges can have the poison property removed by MADV_GUARD_UNPOISON -
>>>> 'remedying' the poisoning. The ranges over which this is applied, should
>>>> they contain non-poison entries, will be untouched, only poison entries
>>>> will be cleared.
>>>>
>>>> We permit this operation on anonymous memory only, and only VMAs which are
>>>> non-special, non-huge and not mlock()'d (if we permitted this we'd have to
>>>> drop locked pages which would be rather counterintuitive).
>>>>
>>>> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
>>>> Suggested-by: Jann Horn <jannh@google.com>
>>>> Suggested-by: David Hildenbrand <david@redhat.com>
>>>> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>>>> ---
>>>>    arch/alpha/include/uapi/asm/mman.h     |   3 +
>>>>    arch/mips/include/uapi/asm/mman.h      |   3 +
>>>>    arch/parisc/include/uapi/asm/mman.h    |   3 +
>>>>    arch/xtensa/include/uapi/asm/mman.h    |   3 +
>>>>    include/uapi/asm-generic/mman-common.h |   3 +
>>>>    mm/madvise.c                           | 168 +++++++++++++++++++++++++
>>>>    mm/mprotect.c                          |   3 +-
>>>>    mm/mseal.c                             |   1 +
>>>>    8 files changed, 186 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/alpha/include/uapi/asm/mman.h b/arch/alpha/include/uapi/asm/mman.h
>>>> index 763929e814e9..71e13f27742d 100644
>>>> --- a/arch/alpha/include/uapi/asm/mman.h
>>>> +++ b/arch/alpha/include/uapi/asm/mman.h
>>>> @@ -78,6 +78,9 @@
>>>>    #define MADV_COLLAPSE    25        /* Synchronous hugepage collapse */
>>>> +#define MADV_GUARD_POISON 102        /* fatal signal on access to range */
>>>> +#define MADV_GUARD_UNPOISON 103        /* revoke guard poisoning */
>>>
>>> Just to raise it here: MADV_GUARD_INSTALL / MADV_GUARD_REMOVE or sth. like
>>> that would have been even clearer, at least to me.

Yes, I think so.

>>
>> :)
>>
>> It still feels like poisoning to me because we're explicitly putting
>> something in the page tables to make a range have different fault behaviour
>> like a HW poisoning, and 'installing' suggests backing or something like
>> this, I think that's more confusing.
> 
> I connect "poison" to "SIGBUS" and "corrupt memory state", not to "there is nothing and there must not be anything". Thus my thinking. But again, not the end of the world, just wanted to raise it ...

"Poison" is used so far for fairly distinct things, and I'd very much like
to avoid extending its meaning to guard pages. It makes the other things
less unique, and it misses a naming and classification opportunity.

"Guard" and "guard page" are fairly unique names. That's valuable.


thanks,
-- 
John Hubbard


