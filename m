Return-Path: <linux-arch+bounces-7034-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 708DF96C6F3
	for <lists+linux-arch@lfdr.de>; Wed,  4 Sep 2024 20:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF9DD1F23888
	for <lists+linux-arch@lfdr.de>; Wed,  4 Sep 2024 18:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E071E1A3C;
	Wed,  4 Sep 2024 18:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RbG4+sos"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA1481723;
	Wed,  4 Sep 2024 18:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725476295; cv=fail; b=LSbcse91umVP4v3VIN4f2q7MKwgmgx8NzkB1nmQ2WA8iDWcrzs7XLpyPBRpCwPZyRcKvBmSoL/zGTmRBgjALroAOABRXGw0JD6ZvnEMvxWZEM3pXWT1StGa6LcT7X7sbFX8nqNVl0MspiCE6DZZghRzt0lhj9d1z+E1jUnYPddU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725476295; c=relaxed/simple;
	bh=o+2CB3GZW+oD7nyRh8SG+Ft3uqB0XcCbzUGSSHYaObo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AeHN8ibXjgI/PIdxYiLWRHl7GFBj1iA0H8Givu/YTPcZROohfz4A7/W0GMjBOHd1BoPMYV6XXEopyu0vb/wDIH7F1MMKZM/sg+gDNoDy8y/S7d2+1f7K9OJf1avNTVH+F1JRTySkgYhBvgE42LZzPmM422LeJw/69ouNyHihTz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RbG4+sos; arc=fail smtp.client-ip=40.107.223.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hk8qBLycRGl2Up1G4PpPbd8syAZBBFVaGLaHdn6N4YNkolAKhpWyJ3JE6v1G15GcdSR/z+Tav/07AjRO1cF6uWTQzFjt4rC5AHL5MAmt6RkXpAKF0ciDJDMK7JCVMRUI4xSPsGEkr3B5jlKZBB9OXpg3MoN/3Glt/RhND0nZrrXkaipIzz9/TXs6BOEdkGJCOtGKpIi381+SQ/TMMEeHQwYMLnudt0zqoStJCkogO4kdt0JNrw0ZGp519ZSLpHR1R00Kc/Z1eiq6+OxMu2muHZ5LHpv96xAJDvslvEIoEo9URcOYy9A6+twsdJZasXySo+2giCbBCP1JF4eogsipqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FcpkGuHoWDPoVNkOxue6j/Ackq6i7a3wGCbnP9Vp3Rw=;
 b=Xqmc8OZnduxu3S+iqarM4kjmgCGNyZlkdi6b5u2B98FMjCAsXMiOAqJu48yx8mwWwddbvAhkl9wxN+LFN/609eT+XgRd2ZLPLs64JtLE5FA1L4jZtLXURgMuSGtiZS8yNDCvQm17+r9AgPIP5ItUvE9N10ETvOfqL1ma/wNrGL3NjWvBQJ2JmIOdfSfbK4soPocBUW5fe7uGY3LBp2suHlDRTyrBMLIyW+mX3SOe6rkvZbSjthi1EtK6sWZ2Q5UzdQed1XxGZg4Xdx/nm09CfKr0w5eihn+DgNXWDMvQ76wXWp7VO2966sO8o0scm7I6T8wEZvwoRb3C/b8Mivr+mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FcpkGuHoWDPoVNkOxue6j/Ackq6i7a3wGCbnP9Vp3Rw=;
 b=RbG4+sosq6fUBYLsYR9MFuD7dOCwuoVi0U1yvRgZ/7OP7HzjES0w/IDlXz4MXapE/xY5rf6npGChJ6ToBpuzqgjbTqmIkhCFTrtp1q3zctWjBMhf+20p7WbQxynnkJcFURndDA/1coFaCUBSTK/CZoBQUzvehlDBd5wRaRHyak/kzh4ZnHt6S1IDFnEHUEPlL4p9APIvCYC5U74VNTtLhPrCiwgEDn/Uk5LGpBH12YHSzvLNmd5t4BfDgKXX736tACXpRxZQIW/GUBPYWlSGJ4nOcwrqF426BAAnxcsW6T+XgyRKWJj/BA1yFTVuRLh5Xx/8QbnNYU3fVpu5ZWrsHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ0PR12MB5469.namprd12.prod.outlook.com (2603:10b6:a03:37f::16)
 by IA0PR12MB9012.namprd12.prod.outlook.com (2603:10b6:208:485::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Wed, 4 Sep
 2024 18:58:09 +0000
Received: from SJ0PR12MB5469.namprd12.prod.outlook.com
 ([fe80::ff21:d180:55f2:d0c0]) by SJ0PR12MB5469.namprd12.prod.outlook.com
 ([fe80::ff21:d180:55f2:d0c0%5]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 18:58:09 +0000
Message-ID: <c55739ec-3f0c-4f37-ad86-fe337d71d5a2@nvidia.com>
Date: Wed, 4 Sep 2024 11:58:07 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] alloc_tag: config to store page allocation tag
 refs in page flags
To: Suren Baghdasaryan <surenb@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, kent.overstreet@linux.dev,
 corbet@lwn.net, arnd@arndb.de, mcgrof@kernel.org, rppt@kernel.org,
 paulmck@kernel.org, thuth@redhat.com, tglx@linutronix.de, bp@alien8.de,
 xiongwei.song@windriver.com, ardb@kernel.org, david@redhat.com,
 vbabka@suse.cz, mhocko@suse.com, hannes@cmpxchg.org,
 roman.gushchin@linux.dev, dave@stgolabs.net, willy@infradead.org,
 liam.howlett@oracle.com, pasha.tatashin@soleen.com, souravpanda@google.com,
 keescook@chromium.org, dennis@kernel.org, yuzhao@google.com,
 vvvvvv@google.com, rostedt@goodmis.org, iamjoonsoo.kim@lge.com,
 rientjes@google.com, minchan@google.com, kaleshsingh@google.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-mm@kvack.org,
 linux-modules@vger.kernel.org, kernel-team@android.com
References: <20240902044128.664075-1-surenb@google.com>
 <20240902044128.664075-7-surenb@google.com>
 <20240901221636.5b0af3694510482e9d9e67df@linux-foundation.org>
 <CAJuCfpGNYgx0GW4suHRzmxVH28RGRnFBvFC6WO+F8BD4HDqxXA@mail.gmail.com>
 <47c4ef47-3948-4e46-8ea5-6af747293b18@nvidia.com>
 <70ef75d9-a573-4989-9a9d-c8bc087f212b@nvidia.com>
 <CAJuCfpEQLDW1A7EX8LAcaRYdxKYBvP1E1cmYDoFXrG_V+AXv+g@mail.gmail.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <CAJuCfpEQLDW1A7EX8LAcaRYdxKYBvP1E1cmYDoFXrG_V+AXv+g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0385.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::30) To SJ0PR12MB5469.namprd12.prod.outlook.com
 (2603:10b6:a03:37f::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5469:EE_|IA0PR12MB9012:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f8a55cb-6e75-4ef4-dce0-08dccd138471
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RmRjRnQvcVMwYVNBOGJQUmFNTGt0UWVoQUV3T2p5djlTZDZyeUpLZ2ord2xt?=
 =?utf-8?B?d1d1K2NHdnZVbTVlL2FBS25KVHA4NlVRbUhGM1EzcHBscmFZdFE3ME1nS0N6?=
 =?utf-8?B?QU5vOTdEVk5vY1RiSlNNemJZQW1lRnFDVlhVYzVjSHVQaVI1aGl0TFFFdTBx?=
 =?utf-8?B?TEVxQ2VtM0ZwckF5eWhIQ3ZIaWlqYWRIR1FBSU03L0J6aGxmeXFuWnlrekpG?=
 =?utf-8?B?em8xSU9TeFZwTndEaUxUa1V0TzVVN1F6WWJkL3FobjdOamR3cURyWXdsTlJo?=
 =?utf-8?B?WkJWR1hLQk0yclRHY2RXSzJnSEVicXozQkJ6OHV1NVQxaXV6YUVSQzIyMERn?=
 =?utf-8?B?UGo1cHhndER6RDJlRDJlcDNNUjBVdlR3YXFNZGk4eDEweTdxTURNVGd6VzVU?=
 =?utf-8?B?RlhLZDduSU1wWTdnS00yZVRURkkveC83L1RYZkxmdk5UcE9NZ2o1NFhsamdB?=
 =?utf-8?B?elkrNVZmam01dDVFeW0vNGhTSzZSS0JxemltNDFsZUN3d1g0Zk11eTRTTXVH?=
 =?utf-8?B?MmFuSkt1VE9yblVBTnZsQzdsdUxjYkF2aEoxTGJFSTN3dFEwdTVlTjVzL3dH?=
 =?utf-8?B?SzNLcCtQSlFKZW5FUWRweHUrUW53MjBlQWxHak1jTWRNUnJVb2dFaTRPRVFy?=
 =?utf-8?B?VDNDVGRWWGdtbG50RnlpRmhLaStDd2tCRDh6V3RMcVhhRllUNmFISElXVlRD?=
 =?utf-8?B?RDRlVXRJRkhBRUw0aG5XY0ZaSXpYRXFySHl2NmVNdmVjcUdXZDFCM3Y0RUU2?=
 =?utf-8?B?c1dGcTF3Tk1CcGdMQVFMdU9OcFZZeDBKL3YzTXEyaFp6Q3RkWnJqSnVROUZH?=
 =?utf-8?B?Q1dMdll3ZkRvak9ncVhzQ1NGR05EbDJzL05nSDMrWUVnRmxMQlg2a0pwUkVq?=
 =?utf-8?B?NGs4RFFWUG00c0pIbEZPVUc3OERtMS9lcXJlbGgzN0Z2MVM5MlJIbS9XOUVC?=
 =?utf-8?B?UU4vT1hLa1lWUWJhLzVTbGxiU253Y0xJOHhwdGtiWng0VmdjK0Q0VytmYXJ1?=
 =?utf-8?B?VzRLY0ZGQkIrNUZuSG1oMTQ0N0ZzSFJnZy9WUFd3bm1kcU1yVkJmNHllMWht?=
 =?utf-8?B?MktSZTBreEY4QURjaFZCSEFSUktiVXR6ZWJxeWd0TFQ3REFyZXd1QkRjaWtF?=
 =?utf-8?B?ejdaOXZFd3NDdEEySmVXU0tKQjQza2JnWkxNeHRPVXZzaDhOMHI4SkoyRFF1?=
 =?utf-8?B?NnZFL3JaMnY5SGF3NXR3N0dsWTZVZVpLQzBZeTNBWWZzWlAvcVljajhRQTNy?=
 =?utf-8?B?MDFhS0FpdFA1ZTJmOGx5Vy9DMkRkLzA0a2s3UHZwMW1iNDl1K2V4ZjRjelZE?=
 =?utf-8?B?M25CcXVYSTBya0Fmdy83M0M5d09PVHZOT29iNXpvdGVTWmswRzhDNnRRenVa?=
 =?utf-8?B?RUNGMG9YNElMRjdCY2Y3WldzQ004SEdSU29SZTkzYktoaTlxT0RyeHp3cEpT?=
 =?utf-8?B?NmtwS2NiRFpnVmQ0R0VLTXUwc1RydmpWYTJHdDh0dFFFU0xjTFN1aTZyN1k2?=
 =?utf-8?B?TG43M0pqUTA4U0VYd1h4NWZPRWE1S2oxRFRiK3BYRHZDeUpHSXFrKys1eVVG?=
 =?utf-8?B?UHNBTUplM0thNlBadEl0WnBocjUxUXdwNXI0S0krRkJ4cDB6VDIwNE1FRFRP?=
 =?utf-8?B?VlI3aE9wZnZJWnJNaDg5bFBFNXlaSFdjVlViS3JVRXlkZjA3N1lveW15c29v?=
 =?utf-8?B?Sy9MTmxTdklIWXY2ay8vcUw1US9BUm03UFlqQkxZdmVraEtabVJHOUdad2JX?=
 =?utf-8?B?V2ljcUJZZmZ1UHdyVlJXZG5JTWZqTitmTU9sU1BXc2o2QmJnL1hVeEtJKzdT?=
 =?utf-8?B?WEh4MlN5dThYTUdZUWF0UT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB5469.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QVVUMjdESG1sVUloMlZqV1kzRWQzYWFraktSRWU3azYzOWdVOExCdTJRL294?=
 =?utf-8?B?azBYeWJGUGljUzh2NHBiSDIxbnRZbk0zZ0Z5Q1ZvN0UvdE92cGZkQllxWE9i?=
 =?utf-8?B?NjNmZHBnVWNOS2JwbFNzQlBQeHlIc2d4M25LNlpnUW5oSmgzU2FXV0puL3RI?=
 =?utf-8?B?RmZjUVZUb0dZVjgzNlNneGlCVyszTWhLY1JQdzd6MlF0LzlCZEszZ3BWWXJz?=
 =?utf-8?B?SjV2Q21qbGRLZnlhZmRpQmxHNk1DTHQyODgzelF5TFpCSTl0elZaM0RrbHlF?=
 =?utf-8?B?dkp2MHcrMkNtSFJRS3VCQTFqdDdkL0tEZGludThPRWpOMmpYZGZiZ0xReXRu?=
 =?utf-8?B?OGdlbTRCU0FvYnMrcDhsNlZLQnNaampnM0lzaFdEcy9Id2ZTR2tkbUk1N0I4?=
 =?utf-8?B?V3Z5aklsR3dBRE0yOGpMMmk3ZlJvY3dRZi9zOUN0U1RKajlFUTRNeFpzaUNG?=
 =?utf-8?B?THNzT0N5b3pMRkRBU1hoMG5oclZMVjN5VnkyMFpnb051ckdEY3BoWnhWK0Ey?=
 =?utf-8?B?cmU0UTl6cDFXNVkrR3k2TmZBTCtveFNYbmNQQjB1R0NCZzA5SjVTYzVpUTI3?=
 =?utf-8?B?cWVUdjVpQmtNVTY2dmp3ODhUZnlJWGJvTzdnSG5nTDVhMUNBUEI1ZTZUWEg2?=
 =?utf-8?B?aWNmTUlkMGVSSkRGeVMzaUFiaW9UU3R0bHRsUys4cFliV3FBdlBGYVRFVWtG?=
 =?utf-8?B?dnZRczR2N3h4MVFVYjhHamRVNklmZmNVWnFjMlNNU3NpZDhta3BCTHp0Ym5l?=
 =?utf-8?B?ZkdueEx1VUQ0YXltbURIY2k5V1NKZ25ld1JRU2tuOUdITGVZNk15cm5rU1Bx?=
 =?utf-8?B?bW91Mmp1aWlxT281Skw1cVVuWEQzVEgvbVRiL0ZORUhnc3cwQnB1My9rOHBD?=
 =?utf-8?B?UFhTZDBNZUpzN0pha0Z0VlJ5cW1zN1Z1Z01FK2d1Z0xud2VpaXVDTFg4bmYv?=
 =?utf-8?B?QkRVS2FGdUZjbURnTE13YW8xalFObDFuMjE5eUJEek5MOGVRYmRZczR2UmdB?=
 =?utf-8?B?M3JwSzBwdmVjaDIzc2F0Mk41Tzd6WE94MGlJdmphOStGNThDY21PN0k3MS9t?=
 =?utf-8?B?K000Wm91MGNCbUkxVkZ6OXJOK3ZiUXFwTUdwQnVGTDJJOUVZMlNWem16NUdu?=
 =?utf-8?B?azJ4N3hFanRuYXdZRFFvWDhnQkJUbVAzaEJFMmlnODVzVENhVUJYL2hKaE1h?=
 =?utf-8?B?b1o2ckY5dmxrRXFEa3N0U3g5aWY4WkZTWEVlVEltck0zNWlkYk11WjRPVm5T?=
 =?utf-8?B?Y25oMW55SVRacnZMK0FMVWIwazRvZTBOL3luZGUwTXhaSVVKMVRQNzNGVUFZ?=
 =?utf-8?B?V2lsbk95NGpXS2xsUmFqNnZhVFpOQzN3ZUlMQzVBZmF4cGRZdUZpemdkUEpY?=
 =?utf-8?B?enZha3ZVdVFhQndQdUZOV0RsMW1jMjdDK1ViWFduR1o2QmFDT1cvSzM5RXhU?=
 =?utf-8?B?TjFpeHlueFFSSTByN0RuMVJ4NCtOdTJVbWQwbGp3SzNtc0xuTkJ0VnhEeW1L?=
 =?utf-8?B?YmR3eTdlZG43VCtUS1M3M1NmUGtQRFJTNzZCM0tZeG90TUJaRG5tREZ5Zlox?=
 =?utf-8?B?YWJUQ3BTK2tNcFV1R0NOVENSS0dsV1JWZEE5T0lVelc3Q3AzY0s1QlF3Y1Rs?=
 =?utf-8?B?LzNxVy9CbzdvMUMralRwVmNKeEl3UEFUVGc0eGNCY0tsSUxCSVJOMnQ0YkZ6?=
 =?utf-8?B?UTBNRFZmS2xubVBNZ25DanlSMTlDenpHTjhSVDhyMlJXdWNsQVhnTTNidE5h?=
 =?utf-8?B?TjBiZDB4SzVweTlVUWpPMi9paWVoajMra2tYN0RqT3NTa25jVFZnWEpscjVo?=
 =?utf-8?B?aU0zSUFiQU92c3dUb0ZGT0ttQkFIVkFvTDRKOGFRb2drdmdBbWk5OGlYOWxx?=
 =?utf-8?B?TVU2Z1BIeEZTV0pvZDFDRkZERVJ6RjRRUGNNOEt3dHZxMHlOcDJuWHFhMkx2?=
 =?utf-8?B?Z3hEVmordjlycjErUUZscVhPTGFvOTI4KzdoQUtkV3lJK1BWUlpNS1RPVzda?=
 =?utf-8?B?Y3ZIRVpFRGE2ZVRaWit4VFZYV0lrZTk4Zm16QnVnVERpUVBabWFzRHVMNks2?=
 =?utf-8?B?dWhnNk9MRFJXM2dVRmdzUXNXNE8vZnIvVlA0cEszUkUxR3lyRzI1bG8xU0dw?=
 =?utf-8?B?T0FJVmsvRURZOE5xUGY0VnFWbGhETTUwakNVNjZyUE5yL3NkbjJuQUpoT1F4?=
 =?utf-8?B?SlE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f8a55cb-6e75-4ef4-dce0-08dccd138471
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 18:58:09.0806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IxsmGjRO9VET3YThErhxetSwJeqo/RebSzxSELAxnr3LYD+PH0G8XqL7zo2xEqKIeTqwG2f0LSe02324u/4RnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9012

On 9/4/24 9:08 AM, Suren Baghdasaryan wrote:
> On Tue, Sep 3, 2024 at 7:06 PM 'John Hubbard' via kernel-team
> <kernel-team@android.com> wrote:
>> On 9/3/24 6:25 PM, John Hubbard wrote:
>>> On 9/3/24 11:19 AM, Suren Baghdasaryan wrote:
>>>> On Sun, Sep 1, 2024 at 10:16 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>>>>> On Sun,  1 Sep 2024 21:41:28 -0700 Suren Baghdasaryan <surenb@google.com> wrote:
...
>> The configuration should disable itself, in this case. But if that is
>> too big of a change for now, I suppose we could fall back to an error
>> message to the effect of, "please disable CONFIG_PGALLOC_TAG_USE_PAGEFLAGS
>> because the kernel build system is still too primitive to do that for you". :)
> 
> I don't think we can detect this at build time. We need to know how
> many page allocations there are, which we find out only after we build
> the kernel image (from the section size that holds allocation tags).
> Therefore it would have to be a post-build check. So I think the best
> we can do is to generate the error like the one you suggested after we
> build the image.
> Dependency on CONFIG_PAGE_EXTENSION is yet another complexity because
> if we auto-disable CONFIG_PGALLOC_TAG_USE_PAGEFLAGS, we would have to
> also auto-enable CONFIG_PAGE_EXTENSION if it's not already enabled.
> 
> I'll dig around some more to see if there is a better way.
>>
>>>> - If there are enough unused bits but we have to push last_cpupid out
>>>> of page flags, we issue a warning and continue. The user can disable
>>>> CONFIG_PGALLOC_TAG_USE_PAGEFLAGS if last_cpupid has to stay in page
>>>> flags.
>>
>> Let's try to decide now, what that tradeoff should be. Just pick one based
>> on what some of us perceive to be the expected usefulness and frequency of
>> use between last_cpuid and these tag refs.
>>
>> If someone really needs to change the tradeoff for that one bit, then that
>> someone is also likely able to hack up a change for it.
> 
> Yeah, from all the feedback, I realize that by pursuing the maximum
> flexibility I made configuring this mechanism close to impossible. I
> think the first step towards simplifying this would be to identify
> usable configurations. From that POV, I can see 3 useful modes:
> 
> 1. Page flags are not used. In this mode we will use direct pointer
> references and page extensions, like we do today. This mode is used
> when we don't have enough page flags. This can be a safe default which
> keeps things as they are today and should always work.

Definitely my favorite so far.

> 2. Page flags are used but not forced. This means we will try to use
> all free page flags bits (up to a reasonable limit of 16) without
> pushing out last_cpupid.

This is a logical next step, agreed.

> 3. Page flags are forced. This means we will try to use all free page
> flags bits after pushing last_cpupid out of page flags. This mode
> could be used if the user cares about memory profiling more than the
> performance overhead caused by last_cpupid.
> 
> I'm not 100% sure (3) is needed, so I think we can skip it until
> someone asks for it. It should be easy to add that in the future.

Right.

> If we detect at build time that we don't have enough page flag bits to
> cover kernel allocations for modes (2) or (3), we issue an error
> prompting the user to reconfigure to mode (1).
> 
> Ideally, I would like to have (2) as default mode and automatically
> fall back to (1) when it's impossible but as I mentioned before, I
> don't yet see a way to do that automatically.
> 
> For loadable modules, I think my earlier suggestion should work fine.
> If a module causes us to run out of space for tags, we disable memory
> profiling at runtime and log a warning for the user stating that we
> disabled memory profiling and if the user needs it they should
> configure mode (1). I *think* I can even disable profiling only for
> that module and not globally but I need to try that first.
> 
> I can start with modes (1) and (2) support which requires only
> CONFIG_PGALLOC_TAG_USE_PAGEFLAGS defaulted to N. Any user can try
> enabling this config and if that builds fine then keeping it for
> better performance and memory usage. Does that sound acceptable?
> Thanks,
> Suren.
> 

How badly do we need (2)? Because this is really expensive:

    a) It adds complexity to a complex,delicate core part of mm.

    b) It adds constraints, which prevent possible future features.

It's not yet clear that (2) is valuable enough (compared to (1))
to compensate, at least from what I've read. Unless I missed
something big.


thanks,
-- 
John Hubbard


