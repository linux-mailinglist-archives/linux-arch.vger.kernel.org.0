Return-Path: <linux-arch+bounces-6993-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E848596ADD3
	for <lists+linux-arch@lfdr.de>; Wed,  4 Sep 2024 03:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17C181C212F4
	for <lists+linux-arch@lfdr.de>; Wed,  4 Sep 2024 01:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E7279DE;
	Wed,  4 Sep 2024 01:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aIotTcX5"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2BD1EBFF0;
	Wed,  4 Sep 2024 01:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725413169; cv=fail; b=kBzhTqCFOgRf/58LvqabnoQrkuVvFiMV1RScx/DukDTTa5chuWZZQqiBsDNgBV4zhtclwcHcVgQ2f0mQP+gpkj9fNgEgSJk+0YZCv6zq+0Wi+1XzO5O6FuOufkvKxy1lQd4knyEk/2s2cfL9SDW24zRZMsI8XiMDINCwqKCbqhk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725413169; c=relaxed/simple;
	bh=7lfRQTcmVYcmaOceuMsaqQFlwm1EiEjzx0w6yBNpix4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CWWp9VMk0xrsU6eakKb6MWX40RgJfOpbyPUsZNQsSSVWVQliKjqKtcPwSwycDrNIcvjneHGCprljmiNGs44OdyHYdHKNf/1Ci/EUv0AG7OR0VH1UQQJLBgplTPornIoUPzJ5oqyUe3d2GRVoS1JDAEvadwjTp6lqBXS0qpA0T9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aIotTcX5; arc=fail smtp.client-ip=40.107.94.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tsAGKCtpaeMK2v7vOete6k1L8a/rG7ISZY1CLkGjBv5oBbTkdjaIwvxmE9wsRW6xWEru8TvUU9Txn/VuC8XDkvUzfRZdGpfmyITT8D2SZAJsGkIN4B7+PYksZmE8W9nNdBTsKkqdW5bHJlVTtRayEmgIWLpSgPToR/qqvTRyrbvAT39U7yJbKp7ha/g525tCwiyIuU7/KMdfx5nVTsQyZVLOLBNNH1xRZ4jCiJR1JobznCBOt4CszvwuoTr4OlhSB9KxwTTh9iA4sk17JUtRVxxok3fJ2QJQrPXnRjiBxZIiOidBLG4Jlq7kmDaDsKdV8wFSUeHm59t3J48FcdY6dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SNI6apRHOCNLp/bIEDYgLEewt6/UkGUpo5AoYQoCUlQ=;
 b=NSVQ66QpkhHm+we1Xu1UJe3HVbP7AudUqKgFWglUMN+KtmaBBIZIx8MWBsFQ5Ea6hKQxENwd1/u+GsJ6B7UV/Q2cWoIPJfikFBv6UAITzO/WDfSak04fMpdpj9S+EC/bTPtI0j8s+HuucfUZo7XmTFqZHOTbaJgdhA9ppjM6LKXWUs98Kuq4NwwcPwDMqdAKDzbpzmSW1OEpdHZVvJVWFs4sqeF9nT9gQeSyGiZb3ulMUTn1CQMR6y7Vd7uWML+Qf4PN3ZFfpj9o7ClqNaYMPAxT6/7Tc4r/u4TiucuJfs4f1VSt/c2knR31Rm4WfyurjfY+sNn8Y45j1WxJGrJSNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SNI6apRHOCNLp/bIEDYgLEewt6/UkGUpo5AoYQoCUlQ=;
 b=aIotTcX56U4oguMeIS7vs661NpeOXH+FouGh2qwne+CYuIYsi29PE6NPFy6BvE5wJ+AKBom2UvAi0HbkurjyiqlurLeMeWIdkJ628df1yEua1/5Dpnk27qNpAV6ux08PpuX7iWmFzvAKV15PDa21eQxfhnpCq33N8y4t3g/RAe+Lmhn/4DKxh6wUTNY6JRbWl1+youZusbL+RcOg8tIQcx8NvcPCO/5XUQiJcF4Jaz0jV5UB7V5l+4tznilRZag8ymfRWdSDqOcSKoD7Cx9mdCm8Bhv6rUmIjOUixGZDEoEUGEe6fulNIOcxrbfIn0WEBWsebdtNIKppItiUPOZkfg==
Received: from MW4PR04CA0168.namprd04.prod.outlook.com (2603:10b6:303:85::23)
 by MW4PR12MB7384.namprd12.prod.outlook.com (2603:10b6:303:22b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Wed, 4 Sep
 2024 01:26:03 +0000
Received: from CO1PEPF000044F8.namprd21.prod.outlook.com
 (2603:10b6:303:85:cafe::5) by MW4PR04CA0168.outlook.office365.com
 (2603:10b6:303:85::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27 via Frontend
 Transport; Wed, 4 Sep 2024 01:26:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000044F8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7962.2 via Frontend Transport; Wed, 4 Sep 2024 01:26:03 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 3 Sep 2024
 18:25:55 -0700
Received: from [10.110.48.28] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 3 Sep 2024
 18:25:53 -0700
Message-ID: <47c4ef47-3948-4e46-8ea5-6af747293b18@nvidia.com>
Date: Tue, 3 Sep 2024 18:25:52 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] alloc_tag: config to store page allocation tag
 refs in page flags
To: Suren Baghdasaryan <surenb@google.com>, Andrew Morton
	<akpm@linux-foundation.org>
CC: <kent.overstreet@linux.dev>, <corbet@lwn.net>, <arnd@arndb.de>,
	<mcgrof@kernel.org>, <rppt@kernel.org>, <paulmck@kernel.org>,
	<thuth@redhat.com>, <tglx@linutronix.de>, <bp@alien8.de>,
	<xiongwei.song@windriver.com>, <ardb@kernel.org>, <david@redhat.com>,
	<vbabka@suse.cz>, <mhocko@suse.com>, <hannes@cmpxchg.org>,
	<roman.gushchin@linux.dev>, <dave@stgolabs.net>, <willy@infradead.org>,
	<liam.howlett@oracle.com>, <pasha.tatashin@soleen.com>,
	<souravpanda@google.com>, <keescook@chromium.org>, <dennis@kernel.org>,
	<yuzhao@google.com>, <vvvvvv@google.com>, <rostedt@goodmis.org>,
	<iamjoonsoo.kim@lge.com>, <rientjes@google.com>, <minchan@google.com>,
	<kaleshsingh@google.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-modules@vger.kernel.org>,
	<kernel-team@android.com>
References: <20240902044128.664075-1-surenb@google.com>
 <20240902044128.664075-7-surenb@google.com>
 <20240901221636.5b0af3694510482e9d9e67df@linux-foundation.org>
 <CAJuCfpGNYgx0GW4suHRzmxVH28RGRnFBvFC6WO+F8BD4HDqxXA@mail.gmail.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <CAJuCfpGNYgx0GW4suHRzmxVH28RGRnFBvFC6WO+F8BD4HDqxXA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F8:EE_|MW4PR12MB7384:EE_
X-MS-Office365-Filtering-Correlation-Id: 089fa32a-ff9e-4a0c-1577-08dccc808aec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aWE0djJSOXVpWHk3RDl2TUYzaVVpL3ROQmZiWkVLQkVxaDVWY01BSDF0ejRW?=
 =?utf-8?B?eWdHL0V3ZG82RjdGZHRRS3JsM3F5cVlKMmN6eDBFRjBXanZQOVpIbkFSbjhL?=
 =?utf-8?B?UllLT3h5a29DSVJhN0xjMndManZnUGtiZUtzYy9Wc05jaE5mbWVlQjRpRXpC?=
 =?utf-8?B?ZHBlS0I2bWZLQ29EMnlzY3M5NldaMUVMclNHODh2ZldvRjhQdC9qN2FycTVt?=
 =?utf-8?B?ODVyQTZNNm9pN2NQbUFZZFhuUHAyb253SXJ6Zkt2Sy8zMHBUTWJhWWV6YWJh?=
 =?utf-8?B?RjVPVnoyZ01QNHJqcEZ1QTRwQ1YveWZFS3pSaUdqQ2hMN091bGRsRWhBc0dk?=
 =?utf-8?B?eHY2eGZsRGNmZDF3enU2VGt4aXRhUGZwTk1DeFJ6MnJPR1ZObGxBYVFqd3Zr?=
 =?utf-8?B?OXpsUmhMT1ViRWVMKytvSHV6MjZMUUZiT2Y0YVU0QkNOeE1RaVBxZjA2cU1o?=
 =?utf-8?B?RXJiOWZvdVFoUlRLQ25lQzhrRExvTkdTQ2J3dEtGNThUcThYd0UxM2EwdDNO?=
 =?utf-8?B?Yk5tN3MrZWxkWHhvN1l0Wnh1dDRuMFBJTTJpMEUvQm1qR1pSUW1jdkhNOHF0?=
 =?utf-8?B?b1VwY1cxdkc2bE4wOGVZU3RaUXBHd3RDZVRWYjRQbnhEWXJSQU9CZ08zQzV6?=
 =?utf-8?B?V1Z5VmJGdmk3ZVloZXdGTEdNV0lDVXJkejl5VHlNdDlsUHdjWHBqT1Z5am5O?=
 =?utf-8?B?cVpyUkIrSVg4TDFsVy9LYnBjQVVIQmdUUG85d1dKREQ5ZjE2VFNJVjAwWm1F?=
 =?utf-8?B?VlAwZEpGRTZUSXVBcFhCS0hkVng4WXBMTTZRemdrbkU1VktZNWg3WWU2YWxJ?=
 =?utf-8?B?cjFHcDVwQkZqMVBMSUVkVGdpTUVUS3VHaUFnQUhVSS8yWU5TZWZsVitSQTRr?=
 =?utf-8?B?VERaTVl5d3BIbGZnN0ovZHVlWmxiTmxlVHhITzdUdmxKbGNUTDhGRlNWaVI3?=
 =?utf-8?B?K2R5NURJUVVFVTA4NTQxL1FqazBOam9rU0U2K1p6S0FPTUd3ZC9sRjdZZ1FF?=
 =?utf-8?B?bWlyUy9Gb3RiU2pxYVE1WWJiRGkwcUlVOGtjVEJCbG81NWhSQ2pBTnVubTNM?=
 =?utf-8?B?dDA1WjJvcmhOUlMya1dSaHhyaVF3WlhubjU1VnJQZW96VmY5d3ppcmhxK3VP?=
 =?utf-8?B?cXRJaGVVTVNVL3dXNzhRUk1mMnBMcHQ2azBmZjF4aDJrUlZhSU5qbDFUU2xn?=
 =?utf-8?B?RjYyRmJLeWVMNjFkQW5BR2lzZ0VsZElBK2VjMzlpWUV6dWFEMzR6VEdOSTdY?=
 =?utf-8?B?Q2lFWVI4clMxaW0yOFlaUEhWdDRFVU5JSlMvUllFVDRtdmh5OThPQTNqMDFl?=
 =?utf-8?B?Zmt2OVFxWldhUlJhbDdibkFyK3NBa2VzTnZQZSthZHNJbkEyV3B1cnptSm9r?=
 =?utf-8?B?V2NtVDI4aGxKZlMreGJNNUVJNUJlTUh3QWFxTTM3SW5UNFFJNENIeHYyK0tz?=
 =?utf-8?B?TElETUpLOE45ZVZ1dTFNS2tTd0VockVjb3N2L2g1V3VPQWJVRW1JQ3V0OHk4?=
 =?utf-8?B?R1NQV0N5c3pvM0tINEFXc1RRbU5HeE5TUjdxcGk0RjNTc0xTVzdkTjc0aFpW?=
 =?utf-8?B?QlpEcldwY2RvV2habHBrcklhRTBkZkpZM2Nza09CV214REJqakZObFF6bWdp?=
 =?utf-8?B?eGppTG1QT1o4a2tQUnl6VEdaV1dNbHc0TTR2YU9BMDNYTjM2YXpJalNRcHNm?=
 =?utf-8?B?a01YVDg2VTNTV3FpenNDUEhUemdFbUJmMDlobFJ3cmc5NDhmRDlTOUtMcC9m?=
 =?utf-8?B?NXNBRjVDWnVpTTYwT2pNcUhMMWc3SmZCUGhZakd1QUJlTk1Ra0tZd0pteGdQ?=
 =?utf-8?B?RjdCbUtoNTJBVm5sR3NrcGhPb0RyZW9PYTdCNjhUL0U2VGs1aU15bURVYk11?=
 =?utf-8?B?MFVrcUt1ZTdRMXRqNkd5cEo5cFhQT0ZZTjRNOHB3ZTgreHVuSU9JVkVNOWJL?=
 =?utf-8?Q?pMyy7F4B2X0rjf5B4iHRZKnpHLGTEO8F?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 01:26:03.6813
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 089fa32a-ff9e-4a0c-1577-08dccc808aec
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7384

On 9/3/24 11:19 AM, Suren Baghdasaryan wrote:
> On Sun, Sep 1, 2024 at 10:16 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>> On Sun,  1 Sep 2024 21:41:28 -0700 Suren Baghdasaryan <surenb@google.com> wrote:
...
>> We shouldn't be offering things like this to our users.  If we cannot decide, how
>> can they?
> 
> Thinking about the ease of use, the CONFIG_PGALLOC_TAG_REF_BITS is the
> hardest one to set. The user does not know how many page allocations
> are there. I think I can simplify this by trying to use all unused
> page flag bits for addressing the tags. Then, after compilation we can
> follow the rules I mentioned before:
> - If the available bits are not enough to address all kernel page
> allocations, we issue an error. The user should disable
> CONFIG_PGALLOC_TAG_USE_PAGEFLAGS.
> - If there are enough unused bits but we have to push last_cpupid out
> of page flags, we issue a warning and continue. The user can disable
> CONFIG_PGALLOC_TAG_USE_PAGEFLAGS if last_cpupid has to stay in page
> flags.
> - If we run out of addressing space during module loading, we disable
> allocation tagging and continue. The user should disable
> CONFIG_PGALLOC_TAG_USE_PAGEFLAGS.

If the computer already knows what to do, it should do it, rather than
prompting the user to disable a deeply mystifying config parameter.

> 
> This leaves one outstanding case:
> - If we run out of addressing space during module loading but we would
> not run out of space if we pushed last_cpupid out of page flags during
> compilation.
> In this case I would want the user to have an option to request a
> larger addressing space for page allocation tags at compile time.
> Maybe I can keep CONFIG_PGALLOC_TAG_REF_BITS for such explicit
> requests for a larger space? This would limit the use of
> CONFIG_PGALLOC_TAG_REF_BITS to this case only. In all other cases the
> number of bits would be set automatically. WDYT?

Manually dealing with something like this is just not going to work.

The more I read this story, the clearer it becomes that this should be
entirely done by the build system: set it, or don't set it, automatically.

And if you can make it not even a kconfig item at all, that's probably even
better.

And if there is no way to set it automatically, then that probably means
that the feature is still too raw to unleash upon the world.

thanks,
-- 
John Hubbard
NVIDIA


