Return-Path: <linux-arch+bounces-11552-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03408A9A459
	for <lists+linux-arch@lfdr.de>; Thu, 24 Apr 2025 09:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BDD47A9602
	for <lists+linux-arch@lfdr.de>; Thu, 24 Apr 2025 07:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44E01FF1A0;
	Thu, 24 Apr 2025 07:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CQL0TCfC"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD441FE470;
	Thu, 24 Apr 2025 07:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745480011; cv=fail; b=UJXDDT0rELEec5f/ZSAFxzuiu/Q7p+oYGaqlelw36WV0QkE4naZeUXksriLUfNz4cFAxnOrbgbHu67FfpaGhQJmjPBJ4FD57k12wpAuNbL2V/yoYHR1sr7EsrLSc8uSBG0t6ARLN90hLf7OtbtEjEZBr8Xgm/hw8mpxDS4cWArA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745480011; c=relaxed/simple;
	bh=hl4ljonU2SXiN7cO+qYdHKUvB369nrWIKiALa3MHtaU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BB7N58r5nMnT238Z4+U4wObw6bzCMuLxBJPI1p80AqfNjXsydLcj7wH3WXD9jBzs5tafeE5VVEQG2CfGpT4OhpRrMeclhZiwbIalFQ60pYxaE/3jzli9VPdkjJgAxe6Y+sogOw0ImLF3sEAb67CczWZKzateJghRZWAeHGenNtQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CQL0TCfC; arc=fail smtp.client-ip=40.107.223.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qg0+7gMzk3B+uavErOreDZFGJPp8XSKpjVjoxo7qqHn7WoSzPqgWm31KNEdiIVTki9yLN0Y/kCpOtWAHOmDRPB3L9VWi+e9jXZE5uX82MncodmT1pfOUX/1yFwc+p9/JVk52XkoMRlthgzS1Ka0hePZ+lPk07entawrqrxdEpXJfdDLhaC+mplgv757Q5uv5PTMjhZ0T790Q044wxFafrj+I1t8iFEZTtnXScQCdqYdthOfZ/Esi58hoSgcvhe+hRDdu3cXCl6mWODqm/iixsdRefKZZSihN7gHXC+0vbf21eLeXimkyFBWXCyp1Aj5upenLFVbeJ/x4AurYvQaaFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k+HCeKCsyBlHmTU8A3dmxms9/RArYomFOIqZjAhtYoc=;
 b=kkIgwxhabP5adbouWXsJvKd5ZudLEhkt1lQeGD7ZI+maQwoSEjG9PEQTMeQiXL4s2/9mH0hj9+IAsqNvvcS7xJZfBm2uWMvsdaLhg3njv3sd/fXzbNWlB1C1gLSYNAvyrOLIJ6ejlTMWbIZaXNq+mhjUeD6RlxO+RFp7istEFaaddU7/PmrbEWaUNZvtsePVHflYXzuGBTtuiYRnn0qC3dNJyQtWYvYdXVRC4IdQbO9nvxNYJUBrsWmyzbr9T+0XEu4O923tBcNWzgntxPWZYzCCrz3EJ/kgWkC9WliEEZk/m/Ke9AOC5q9lLXAUeZmpASc9++RKjwmkgLlGOiwSxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k+HCeKCsyBlHmTU8A3dmxms9/RArYomFOIqZjAhtYoc=;
 b=CQL0TCfCn3pO6wt0fkLJ8Dmj67BvEq9wg6GIwp6nj5QSQIE4xNUCzpDyoh4p+345ewdZ30DxX7zZktxHDGyjGA+gXwdxEgpzVda1/WTlGCXT8gEcOFyvMR65CeSTU0SjEM+oa+C4uHPlzkhQzydQDrIDV1sWPG6oRgNF3Dqn/Rhx+M2J174+sV8IXO4JJvrHZH16F4bdWFprkztWmxt2xGXOztGfz5Rt95qWVRM0YZRNWZP1cRhBhE/gdemyhW8rsfBoN9NdqmuGYWxCKbG5kak4k1ehqLC/ymf7aHoWMjkdyhr9sFahKfrfj9K9bT1/E5FBRqxfwxWj3DoCIhIrMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by MN0PR12MB6053.namprd12.prod.outlook.com (2603:10b6:208:3cf::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Thu, 24 Apr
 2025 07:33:26 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%3]) with mapi id 15.20.8655.033; Thu, 24 Apr 2025
 07:33:26 +0000
Message-ID: <96d56e78-68db-4294-ab97-423edc9c06d8@nvidia.com>
Date: Thu, 24 Apr 2025 08:33:20 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/10] tools headers: Update the syscall table with the
 kernel sources
To: James Clark <james.clark@linaro.org>, Namhyung Kim <namhyung@kernel.org>,
 Arnd Bergmann <arnd@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org,
 linux-arch@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20250410001125.391820-1-namhyung@kernel.org>
 <20250410001125.391820-6-namhyung@kernel.org>
 <f950fe96-34d3-4631-b04d-4a1584f4c2f1@linaro.org>
 <95c9bd53-ccef-4a34-b6d2-7203df84db01@linaro.org>
 <4c042dd9-50d6-401a-bce7-d22213b07bca@nvidia.com>
 <b2a5cfc4-190f-4983-8d5e-3483a02be980@linaro.org>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <b2a5cfc4-190f-4983-8d5e-3483a02be980@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0270.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:194::23) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|MN0PR12MB6053:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dcded1d-fc64-46ad-0167-08dd83024d21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OW1HenErMUFreUtlODRHVitWOHVuaFIvYWJreFIwZXppb3FCSnVyUTJsZzdm?=
 =?utf-8?B?d2huZ1hBc0FMekY1cVlJa1JUQUU2VS96ZGZqYkJZQTR3bXBSbFcvdDhnNUZY?=
 =?utf-8?B?dGg2UWNiVGEycFVMVEZUeElBRHNmWXVoTkNkMGtpNTd4UUYvZlpOTWFqbThz?=
 =?utf-8?B?NFZ2MUN2am5oYTh6WjBUSkIvQjBYUEVjZ2hXY3BoKzBZUTByQWt4MStwMTAv?=
 =?utf-8?B?Y0JnTzlnZTBUcGpiWkZLSVpNbklOSWQ3SDJYRzhTTy8yREZDd2lLK2V1OGNj?=
 =?utf-8?B?aUk5SC9yL3NWVEE3M1lma2xNbzk0TWk5dzY2a29xNkVHZWFrOC92VmovaHFK?=
 =?utf-8?B?Z0NKdGU2T1lZZmdSZHlvNkFiek9pY3JiMEZ3dkF3OGhnZXFibFIwanJUZm5m?=
 =?utf-8?B?TnZnV2tkYTdKa2dYTTNNdWZNTVdKeGRFSWwxUDVzZ0RlaXJ4V0hhbElGME5X?=
 =?utf-8?B?UHBaNkh5cm5MbkhiVmdWdm56U0R5U0JFQ05keW1OWU14dDVxUmtySisrSlFC?=
 =?utf-8?B?RUpNcWpSNmViRFZ0NUlWNzN6VmIzTFlFZDRTbVZ6VHRkV1RMWG1xdW10MFAw?=
 =?utf-8?B?QkpITjR5Z1g2UXgvZk9DM3NhZzRmQU1xV0d6b3VtOUZBNlJLbXhNTXk2dlho?=
 =?utf-8?B?U1hXT290TmpTVkljODh2b1lDMmlWUXNneXV5dGV5SGZha0l5dXBGTmJwckdi?=
 =?utf-8?B?RURpQzdtVG1VSERuM2UwWkhLS3J1czlpNncxbXhtQ2tkcG4xTlNBRVZ5VVNy?=
 =?utf-8?B?ZzE0Q0thbVB3L0VsNkk4UXFKd29aeFB2MWNQakZNTlpQcVo4Zk82dnBDVXJy?=
 =?utf-8?B?R1d0K1NjK1lWRDdJMlJFeUhlL2UxVEJiVlFkSk5jcE9zeUdyOW9RWnd2UmV5?=
 =?utf-8?B?WFBoS2hxU25EWGlKaWhoM0lOYW1KVTZXN0JrR0IrdW1lYmh6M0JjOTdNZmNO?=
 =?utf-8?B?ZjBZUVVsR2xyNDIwblNEdUNaek80Ti9EWC9PTXVSM01lcno5WXRRQU1kUUNx?=
 =?utf-8?B?dmlzYnVjV1NnUldYZlA4M0FVYkZjS3pqa0hPWWE3UGR0YXRWcTNjVGYxaTMv?=
 =?utf-8?B?QStzMC9VR1p5VVluMWR0TjVhVVJZeFJMTGZMemhENkdCWm1pUGN0TytWd3Qv?=
 =?utf-8?B?QmdYcHZqdm9EajZWWnhPdzk3cHhMTlVUTStqVFN6ZVhwQS9sbDFDU1pkY0Uy?=
 =?utf-8?B?dUw0Yno4b0R6a2hHUGdVMmswZUd5Vm1JM2xwU3o1SG1VYkRoemFtVHNDMHZC?=
 =?utf-8?B?eHJmT0QxSWVnenkwRUFpNlUwT3hMN3VQbFVpckZ3a0c5T0VMclhyMmhLU1pK?=
 =?utf-8?B?QW9Zd09DVFlQVUUvb3pBZkVqejFONUxHRnp2LzBBZUZ5Tko4TGM5SFYyQXVS?=
 =?utf-8?B?SVlVVXovREw3bVdIVXk3U3lQbW90RzdIRjFvN0U5ek1rTlpMaTVqTWlyelFq?=
 =?utf-8?B?eUtiWHFSalllcHRkdUZWOWdNTk56eG5FUnhpUVBaZG9KNHFISFdKYUdzRGJT?=
 =?utf-8?B?dzdTYzRIRXBLVXZFWWJwSmlvcWtLZ0RObS81RnlvT2JkOHh0QUxQVXNmWUZZ?=
 =?utf-8?B?TVkrRm5na2w2NURLOXFGSXhid2MzYUxGd25PZk1neDFzVVJsdWVyM0hmKzVU?=
 =?utf-8?B?cHR5cUl5WUNFbkNHc3BXYjg0SVAxMUp0d1FPZmwxY1d6NHpUTVVYZVBVUGtM?=
 =?utf-8?B?UUYvWVp4Z1NpR0J5WGg4aFdGTjhkS2ViWjNraGk1QXd3M2pWMTFFZXlSTHVU?=
 =?utf-8?B?NlZZUnBlQlErWURqK3lQa3lGcTIyeFg5VGFSWjEzM1JDbk9hbzdmRTBKTnRK?=
 =?utf-8?B?ekRaU0hzTkZyU1NQS3VSNThNS3dlb1AwNVBVN2JVR0cxYjhBRVNVMVk5dmRp?=
 =?utf-8?B?SUFjOS83M1FoM2U4NllJMitTRWovdVNHZkQ2VmdPaTBiR2VDY2pFUFlzWWpw?=
 =?utf-8?Q?d/Blci9Qctk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cU8xbkZmdTkxRlpVMXVrZmFidldZeE9BV1U2RFJ2Y1p6SkYyWEQyb01sRTg4?=
 =?utf-8?B?YU5xUGFUL1FxUkVadVNOalpkaFBGTnVsdU0yVmRnTU51Q0ZLRlpFSXBSWTlY?=
 =?utf-8?B?U214LzVJZTZaSzV3VDBCb0pZL2U1YmdpbjZySlcrV3VicGNWdm5zNk52SFlU?=
 =?utf-8?B?aXFCNUdLWS9aVy9qNVBLM2ZUcnkxdUlqYWtRdlRNMy9HU1BmK0djVjlVQ2ox?=
 =?utf-8?B?UFhhd3U5L2NrbnpITXIxcHN6OVdZMm5vaU8yUGpNZm5zVVV6MTZaa2RtQ0NN?=
 =?utf-8?B?TFRZOFFSWG5wVUkzeGwxMk9wMGRvRG9tUnZ0aHZETkdCVDAyWTNnYzkvbFRX?=
 =?utf-8?B?Sms1d0poOC9wYitVSlhtSUlOSGdnVVo3OTdIQjIyYmU2cVFlR2RsUVE1eTRy?=
 =?utf-8?B?RndIY2NBSUQ0WUVTZU45RmFMdkhlSDJ5YXZCblJZR21keS9vU0tzVTZTVi9a?=
 =?utf-8?B?VzhXMWY1Zkg1RDd2dDl4ZjF0Y0xjTU42eXJESzByOExvcXo4Uk4xRU90eUh0?=
 =?utf-8?B?TkpVb0F6WHRCUC9Zd0NiTkpXUytBQ3Q3L0RpQjMyQXJQUzRlRkROWG52Z2t0?=
 =?utf-8?B?S1ZPNno4S2hXL3A4SmtrQ25CSmVkbENHOExoL0pCenU4NmxHdFQ1aEhPeU9Q?=
 =?utf-8?B?bnJHN1VZN2pmN1dIQzVocXFHQ0hmandoREdsVWIwa1Qxc2lBa3NDV1lJaWdn?=
 =?utf-8?B?OWd2NmU0bEc2TmRiRUVRWUxsMjFIazZvUVRodHJ6Z0d3TXRJRWd0MzM4eFpQ?=
 =?utf-8?B?UkxHdDRERWRYcGVCaEhBMlRPZ1JuS3drZTlpK2FNRklmdHpYME1rdjZQVkRN?=
 =?utf-8?B?U3ZRSkUveWtJMlhtUW5kVW4wQTc2ekc0NzhjVGJtTXFkQnoyaEh3Snhxd3hr?=
 =?utf-8?B?T2VXem5aUWZpbllmc2lhTTV2eDYvMEt0SlRPcGZRRUo3K3Y5bEhzbGx5V1ZM?=
 =?utf-8?B?VXA1R2RseEdGcFRFY3RzOXU5ZjBsWUZDTzJWREZJakdKUUNhajRzS2taVXZ2?=
 =?utf-8?B?L3hJTWlwb3RnZWlmaWJDNFduOGpReU9uZTh1TEtNaDhoUXhXK09PcGxSMTl3?=
 =?utf-8?B?M3IxQThkMGlZc3hLZStOZ09iSUYybDdMRkNoTENNa0dyMFpCWUd3OGREcFIy?=
 =?utf-8?B?eVdIY09ZUDVuQ0U4ZStkZ2I2bXovbDlGN0xvSjdGK3RqSVpZWGhtQ3hIbmhB?=
 =?utf-8?B?VHdYUVlkL0hqZTZOU0h4STlJUDk3Z1l6SXZSWi9zdTVpbFg4SGgvVVFSWHp5?=
 =?utf-8?B?bUZhcXpJd0ZTaEg4aEViS0cyZCtJZHBJbVBaSTY3eGRoTFhMT1pKYS9lOUZH?=
 =?utf-8?B?Y0E4N2xkMzQ1ekFRYmZlN2g3bmVjY0FMWlF4ZVdvSTU1Skw5ZFhZbG5VUm5G?=
 =?utf-8?B?eTNkNUtjRU9sUE13aUVSSzU1ZGhRMjJuVHlVZEorNEt3VVR3Y1k5TG1WRkZX?=
 =?utf-8?B?MkpiT2pjcnI5VytwV3JLNkZLZUF1YUZEYUZ5UnJSTDQwb1hqK3JIeDRDMzFK?=
 =?utf-8?B?RTBQODFXNlYwaytUM081dXdjUWhBMTNYMk8zdmlGdnRCRTVKcjdPTHI3TTJu?=
 =?utf-8?B?TTZnZjlOYkgxUDFDZE5VRFV4SERnaHpQM2JnamZqeHl5aFNrUlRsZVJMYjY1?=
 =?utf-8?B?QWI5Z3hmeERzbHlLQWRsUHdic05UZVdYU2taQXk1aU5ERTFnUjk5eXRsaGVK?=
 =?utf-8?B?Y0dqWlJSK2dDcUxnVElOc1BwTDZEOW1NOE5mTFZvZEhKYWlnc3cvaElrczA4?=
 =?utf-8?B?d01neDdYSnQ3V0hSRHJxbWxPUjI2bGtZOUM4eXZIeG9oRDlNbTRQUlFLcE5R?=
 =?utf-8?B?QUl3b0Z6MGJXdFM5MkREdE10SVlJZEhyUmR5NXk1eGh4ODhqTEppb240OTNP?=
 =?utf-8?B?MXNNc09MZVNTV2IxSEE1cndSdHAxZG12VldwOTFIcThRdTVRR1NDRzE1ek92?=
 =?utf-8?B?Ulc5ZU1HNmcrQlREUktYcWVhUW5tY1l5cVlqZGtscDZGc21IUmVtR1I2SXBN?=
 =?utf-8?B?VUpQcTJlUW55MmF3VHpEMC95RXpMbkVIMlJiRVhZVFBBKzRWeEVUQkpGTkRm?=
 =?utf-8?B?T1ZiMUxYbEV1SkRkV2JiV0Q2SDhhU21MSy9RbFZHVGlpNVJQWnpIbWs4ZWpX?=
 =?utf-8?B?clM5Qlo4bnExaUE1RFNzYUtHMUJNamxEQmUyQWdjR1YveDhCRmVqTlpRSUlj?=
 =?utf-8?B?Q3c9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dcded1d-fc64-46ad-0167-08dd83024d21
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 07:33:26.6431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tW0C9UaMkQXIY3nhqaimeIyoACbCEAEaLpLOUy9vKAlPLL6IxDJNnE7Mv6SZ3As0ktxC8QleCLqtbz8Ch2xgGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6053


On 23/04/2025 15:57, James Clark wrote:

...

>> FWIW I am seeing this build issue too on ARM64 and these changes have 
>> now landed in the mainline :-(
>>
>> So would be great to get this fixed or reverted.
>>
>> Jon
>>
> 
> Hi Jon,
> 
> I probably should have updated this thread, but the fix is here:
> 
> https://lore.kernel.org/linux-perf-users/20250417-james-perf-fix-gen- 
> syscall-v1-1-1d268c923901@linaro.org/

Great!

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Thanks for fixing and sharing!

Jon

-- 
nvpublic


