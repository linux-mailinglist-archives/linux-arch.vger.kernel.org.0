Return-Path: <linux-arch+bounces-13067-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 651B0B1B606
	for <lists+linux-arch@lfdr.de>; Tue,  5 Aug 2025 16:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 923ED17B5E3
	for <lists+linux-arch@lfdr.de>; Tue,  5 Aug 2025 14:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C482275B1F;
	Tue,  5 Aug 2025 14:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="k/KKSR4D"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F121D1C700C;
	Tue,  5 Aug 2025 14:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754402805; cv=fail; b=UdVUje6MKCc+2BDXEyI8PVgk1R94/NjOMDepTxb0UfSd+kODx2BcOLPSlQQ5BCd1OzIfXSTSDEPIYEE6TH/BFqstYj3hzSDH2br2i12nOXplvLunq2zIS5geVJbKr8gvDpiVD6sggRfrU6tXH9i6YC3JWEVOZKZDL1y9DZ14spQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754402805; c=relaxed/simple;
	bh=mAkREmGqNMAHDRndkHP1YB4YbFzb/WTofda6Sl4Vtts=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aBYyru3FitCdYbpEC4AExyscXk9jY8ftecK3S2CfO88+0uEqjka0kTxhX+s2oHAWVlbEjMwptU/bK6mjygfy9rPf3td7TYq/KNF0veNq2ns6A9sXT1NczW/M16+Mi2fabns728eOcbOHFRqfONDsY3maiYJeNQPjPsNIlFoxX70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=k/KKSR4D; arc=fail smtp.client-ip=40.107.243.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g5B0cMDOnTlX0a/keM2ATDn0yMPluADLZkiJWuScTTd/rpRhc4R760riD3+FxvmEzi9AxmQbp8FShLNrX4nO59CKi/D57P/OD76IND3EtZ+2fr6YMj38ABA4/AY55F4Xw7/ejxl0ITga+MM8fpBnRiOmfTZfV8TxFSVQ/+H7VLEihKbJqU47RTwMPPxR63FKdM2+S4+xnCQsJ6nC4z//03CQqfYTqCp4ehclV1bnOS8+HDhZwolNmLSqsG7gMKdPLhb6ILJRgXAFAffRZwiGHJtuFLCet+AFhLMowszHCFezQyFGNz6eOR0EaNbVLRa72Bli3v6ch4K6uHhPpN+YAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jRR9x3vCMQxeLwO/qGNGjwpOYGn/YhqMCJAHWJRKDtI=;
 b=vSw4bjOPocL1IQeWmM58WSkFpEZoug8S3vKbXePImAjsxB/R6Ob0Rt2med+5kPt6ZpVqzkBhynFMlrfBgxZ0pkociJgFm0E/bPdPjc4TOkYoRGqdkLZAQSeVckUb2eytG/9idQmhFU2IzmQHHaBjxT3/VUh3bxwMDqcFwjTBoRA1h5TKTFbeRxVd6k1xLOt/dIjFBjjAyea119fRNp4nIfaym68PHlPbZnjQPmFlChYHzsrSvOIcF/UGRaMdgDAgWwm+OZAC6ueV9j3KC1WjrXVD1RQ9mdb6WKSHBfEzaNo3kWy3UDje0jCiWzn4Gh8k+nfOAfNF/OSmXM7xFfB56A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jRR9x3vCMQxeLwO/qGNGjwpOYGn/YhqMCJAHWJRKDtI=;
 b=k/KKSR4DA8REJwdyURUZ0weInAAVZqatSIv5e6bQbQKx2EPjoxC2J2lGW1wZxbBmj6nwsAGbdI6dRS6llcCv2j/5zXByRRJBXpN91Q1KdIPMQBt7MRWQwYFFpFtMcuB3O0F90mX9a/PSvBUhPpWTypADbtvERD3UnYxqUlNfuuk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6608.namprd12.prod.outlook.com (2603:10b6:8:d0::10) by
 BL4PR12MB9479.namprd12.prod.outlook.com (2603:10b6:208:58e::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8989.19; Tue, 5 Aug 2025 14:06:41 +0000
Received: from DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::b71d:8902:9ab3:f627]) by DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::b71d:8902:9ab3:f627%5]) with mapi id 15.20.9009.013; Tue, 5 Aug 2025
 14:06:41 +0000
Message-ID: <d8faa5c4-a118-453c-afde-8e334655eac4@amd.com>
Date: Tue, 5 Aug 2025 19:36:31 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH V5 3/4] x86/hyperv: Don't use auto-eoi when Secure
 AVIC is available
To: Tianyu Lan <ltykernel@gmail.com>, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, arnd@arndb.de,
 kvijayab@amd.com
Cc: Tianyu Lan <tiala@microsoft.com>, linux-arch@vger.kernel.org,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 Michael Kelley <mhklinux@outlook.com>
References: <20250804180525.32658-1-ltykernel@gmail.com>
 <20250804180525.32658-4-ltykernel@gmail.com>
Content-Language: en-US
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
In-Reply-To: <20250804180525.32658-4-ltykernel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0112.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::16) To DS0PR12MB6608.namprd12.prod.outlook.com
 (2603:10b6:8:d0::10)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6608:EE_|BL4PR12MB9479:EE_
X-MS-Office365-Filtering-Correlation-Id: de85f2ac-94e4-4e4b-af8a-08ddd4294d31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aFNDKzRoSHNzV2lycmVJSjZwT2F4V2R2UHl0S0p6RmhBeEorc3EvT0pkdXEy?=
 =?utf-8?B?cEttcURvZFhyQ2RBR2dmODJKcWpWTDZiNDlrSFdXc0R1UVlPOXVIS0lzZDJw?=
 =?utf-8?B?ZFE0WGtwTGxxUkxqaEFYMS91YlQ3UEhXTHNxOFc5T2p4c1BqRGFoaU1iSGxs?=
 =?utf-8?B?STRFMVhnYWZ0eFQrcW1WVUlyaDNzMlo2Zzk3UmdUblpJenQwb013Nk95L0N4?=
 =?utf-8?B?cDFjS3VrUHJ6V0xRai9DRy8wT2NSbWo5S0ZYTU1iekFMMUgvcS8yUkM1cDJK?=
 =?utf-8?B?OUVKbnY1ZWFDaTlWQWYxcU9rRTE3YnRSek81Y2twb2IxdXlRL3ZWU0Q0dHFR?=
 =?utf-8?B?VTMvdG1MdnppZVQ5MUd3TzNCY0wvdElOOGdHaVFocURvK1g2eWlLdUdudFRl?=
 =?utf-8?B?VHNjSXF0WlN0RzErQjIvMFdMRFBxdEpyYmMzRjlnMnU3UnczaUFxVldWSWZj?=
 =?utf-8?B?azF6Umx3YmIvMW0rWks3d04vNXpHMXlhNHZ2dmFFOUo2RUo3djA2SkVDUHFZ?=
 =?utf-8?B?YWRxRWFoSy96TzBSSno5Z1JhNEgwMTNWZ0pqRXNqU2xoWlJwakllZ3lkVm5K?=
 =?utf-8?B?c3o4QlI1cFhVa1NCcFhSUnB5NXVFcm5JRXFtU0daVkN3REQrSDIwM2ZxanA3?=
 =?utf-8?B?VWZ1YU9Ua3lQNHpjS2ZNV0psMjg5dkwyQkRUand2SzZmcFY1UHZ0d2UrN1A4?=
 =?utf-8?B?TmlxaEJ4TytvSmZMZVFnOHlxU1ZTcHNYYS8xWC9OZldrK29KZmFhMjdQcWF4?=
 =?utf-8?B?NW5oajhmYzgxaUJYeWk0ak05bWlKbm51cjVtdVFMM0hkbXg1aHhyQ2Q5K0Jl?=
 =?utf-8?B?TitvSUtIMVdHZUpKbnA2OU5LUFFPUURzRGlXaHlLZzVqMU1pUUphdU5oV3By?=
 =?utf-8?B?MzJ3ZTZuRzJIUGpxWmVIMUViWlBFbGcvQjdUakZxRlAyMS9ldFNHMzR4RlZh?=
 =?utf-8?B?ZGwxRFFoOEpUeHFMaVdXbExocklTbjFkWStNWDh6YzUrVGtRallIYWpma01k?=
 =?utf-8?B?aHg1N0JIT2x3YkVmaHhDcHRrcG1JVDNjUHhpSHR3bForZE9EM25BMlFjRGIr?=
 =?utf-8?B?V29ISXd1OUk2YUU0NVdmd1RkSkhhU2xPWWVFYkM3UjFTYWp3d041LzlLQVk0?=
 =?utf-8?B?dzFvYmxjTVlxRHBuaW9ZNS9XbEUyc01sMlVackpSditlNy8yMlVsTG5hTE5B?=
 =?utf-8?B?T1ExZjdMSWZUYzJRdTdvdGQwRjNMVHhWRGhJK0ptaGJqVUxiNjJnVlo1eStn?=
 =?utf-8?B?YnVqY0JHWURBQTVjR2g3Uk5QYjB2TXRIRXB2d0RSeVMxQlZ1d2xIcUtwbEMr?=
 =?utf-8?B?eTFQS09CNGlkNTdwenpZWTdRRzVhN1ZROEc4ZGg3VXRsVUtHcDBxWDRZY1Jv?=
 =?utf-8?B?aXZMd2oycW9abE1IMFpVMDVHcHR4a0RvNmt0T096R2xsOC9aTHRPMmw0Mmkv?=
 =?utf-8?B?OVY1SkdtblIyejFRbnVHN1NJdWJ1VlllTWxLaGhDN3N2SXg0QmpFeE5lWUtE?=
 =?utf-8?B?dlpnRzNaOUhDbzVsM1EzSjJmUUkrdk4vUHhtUmVzZk9tSlhwcjFQazlxaS9V?=
 =?utf-8?B?a25PaUdSMXZPVEluNlFXUmNWNGZqbm1wQW5MTUJiYnhkb0JoZVNkS0lkS2Vq?=
 =?utf-8?B?eTBwMVVxSUYwWWVsZXZMSGFuQS9jS1h2SEJUSm1oTWZYV1RFdDg5YVNKaG43?=
 =?utf-8?B?VnVCVVZNUE9zcjRvNHZDeGVweEdpK2VyeG51NDg5azVENVVOWTRodmQ0TXc5?=
 =?utf-8?B?SHNLV1VyZUl6YVJSNFc3bm9WT0JSZlhXYUZ6YjF0WTB6QUo3QkJVRGdNait1?=
 =?utf-8?B?eDlMNTdDanIyUDRuYnVFZUJCcWJ5OVFkNjhuSkVTYzQzSGNDd3E0ZzVodVpa?=
 =?utf-8?B?VW9iRXd4bHluS3pQRnA5enM2VDg1elQvVWJxMEVJNE9uSDlKRHFUMDluY1pL?=
 =?utf-8?B?VlBnWVpNbFozZnd2eEMrUFNEZUlUalYzMk05cDIwdW9rZFJ6MmFHY2RjTzJG?=
 =?utf-8?B?d0tzYmkxTnh3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6608.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YkxhaFh3djR0YnF4VTRZY0VBK2tZc2Z6Rjd5RkNRYmNXOElQYjF4TUlPcEp3?=
 =?utf-8?B?VDNmZjhJeitZbGdseFdCWlB0RlVBY29sUlluQjRnVnVEWDZqWnhqVG5vajA1?=
 =?utf-8?B?aUdlSzQ3YXd1OHRoanY1YWJ5N3ZEdU1RM3pRbFpjR3U0SisrVFNhWnFJOVJk?=
 =?utf-8?B?UU5meW1xS2FCRW51c1o3YnJLdUlIWEVjYmlidEZhY09sVzFtZWNlNWpVQVho?=
 =?utf-8?B?aXg0YU1XTjVxbXpFWityVjlDTWlkci9WQUt0eWhuWkNrd0JQTmJmdXF4ODZH?=
 =?utf-8?B?TExKTXR2c2M1N3BKS1doWjZ6cWtyTzhPamMzTEhuUUQxL0xmdnBwOEJGbXRt?=
 =?utf-8?B?M1B0dVlZQnZvYUVReVlRaGg3OGU3bStwUkE1VHEwbThjWllWN29hTjF6cDF3?=
 =?utf-8?B?Q2FIb1VOS0Y5aU44YXlpcnRTaE90WGd0VjZxV0VwVmE3Yjczd1RsOHd2Qm1H?=
 =?utf-8?B?OFB6cGs2LzdIQUFuSjZCdVJUcGZ0UWIvWEpKbGd5UUF2MnRNUm1tSm1SZVMx?=
 =?utf-8?B?d3QvR2hDbHpSMEJrQzUxT2w0QjJTUmxsZ00zY2RkajZxZ3NHcEpNeWhPNlFy?=
 =?utf-8?B?YXFOcFJtTFhhREFFQk44QTFLZUNSNE1SanA0U3JoNE1HdkZERFZmazFqRlA5?=
 =?utf-8?B?SSs0Zk9WL2twaWllWGNHS3VEeFFXZGJUL2d2OGlYOThIU1ZyNW13anZ1blow?=
 =?utf-8?B?SEVtSkh2WEVld0NRcExsWHBOVkM3RStybXl0TnU1MWRJNWZoY3BhRW9CN1FR?=
 =?utf-8?B?OHhNSnJ5cEViaHp4L2MwMExxSzFnSVpmanp3enpobXo3NVRMdWpEU3VZclVN?=
 =?utf-8?B?SVVveFV6eE9iY1RYSm1ETk1ybEZ6VHBqRVVza0hjNHY5ZDNHbW1xY1VKT25v?=
 =?utf-8?B?RVFJNkZHajI1MWdpNE9zY1FJYVMwVHNLK1Z3am5lOGNTWTR2QVpVYnVTMGth?=
 =?utf-8?B?c3hDbUppR3I0UzR0NklWY2RRMzFjVjNwRkNHQndvQVFRc3JXSXZNWWRTZnZh?=
 =?utf-8?B?WWxkNkxJZUZjMGEvbTBhdWdwYW9LWHZSc01MaWlQV0FZTDJzelhielNJY25S?=
 =?utf-8?B?czUzVGNtdHZvZWRvdVIyWXZEWEpUZEVJa2MrTmh5MHZjUXZzZ1dkUmJjU09w?=
 =?utf-8?B?RWQyTytlVkdhd1pXakhaNWQ3NWZnK21hSGloa2VoTDNtUUhub0FPcnVnZmo3?=
 =?utf-8?B?eFo5VmxLQjlhU2JDamE0RjZFZXNMcTNSNGNQeVpzWXFsMWpJblBXTU8wNVo1?=
 =?utf-8?B?SGgrYTZBT0lIY0lXQ0trb2FJSGR6U21BRFYwTktXekFEMFcwMlJpUTdxZzlX?=
 =?utf-8?B?bHBQcUN5WHJVR2MrVitZZjBYeUs1QkdIc1Vjd3YzaVlLL2M2eWQ1VVRjL01I?=
 =?utf-8?B?MXNSMDgxMHgrYkZBbC9zdlZBVVFvVGx2b1NBNENIdWpIRC9BZGJsbG40eDN5?=
 =?utf-8?B?Z1Z3YmVOSkNjaHdBOTArUTRoZjVMUmN4V1JHbEJXOEVwNnhjZWZCYVlkRWFn?=
 =?utf-8?B?Q0RMNHpCWEJZTDFwR3dva0VMWUtocWQ5dGltUjhVTXphRU5uVCtZTE5tSmlw?=
 =?utf-8?B?cmxUcWdzQ3V1WVVNWkttWXJMR1JTSmtHM1RjZ3VjUlByUFR3c2dMRDlvdnMw?=
 =?utf-8?B?SWpDNG9HQmZDWm4rbjBDZlJRNkh2a1NLWlp6azkzOVFuQy9MY05GczlJK2g3?=
 =?utf-8?B?K1ZITmJvdmJRSmYyUVhiVXlQUlFMMk00TWtVcnB0MzZiQzcrbllXaGMxTFg5?=
 =?utf-8?B?UE5HajUxdjk1THg5UzMzdG1EMWVKQy9ZWFU2QTZIMlpudW1mbnhDdDJseVZU?=
 =?utf-8?B?WmQ2dzlzb3dzN3hTWUdGNlUrUzFrR09ZN0xoOXFzcU5NZXVjR0lzeTNGV0F6?=
 =?utf-8?B?ZHBwMnU4UGxJMEtZNXIybnZ3S0MwTkNBcG9Kb0ZBSTUyWm5YY3RpNThxYUVH?=
 =?utf-8?B?U1MzZDI5N0E2QXd1Q1pQQk1OWmhodngyWDJBY0JJNVRDSy9RSGdjc1czM3J1?=
 =?utf-8?B?NHloSjMwKy9PMXR0cUhxQ24rcmYyWmlYUG5qamRNa2RJRXgvU3F6RzZkbkNT?=
 =?utf-8?B?eGRkbXo3TXpYM05jeHZmRjZraVJ4czYzTnUvdXR4Y0FHUEhQRDhOOFZNa3hh?=
 =?utf-8?Q?gfnDf96q2ZgSSq8WL3gy5tH55?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de85f2ac-94e4-4e4b-af8a-08ddd4294d31
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6608.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 14:06:41.2211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7d7chL5IBTaAEPOg778SlMhNm+lRJibQn1Q721Ldc9HUOk3sbGVivxwB6ir8ERpZDbLTsjQ3LejRQTMKqll3gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9479



On 8/4/2025 11:35 PM, Tianyu Lan wrote:
> From: Tianyu Lan <tiala@microsoft.com>
> 
> Hyper-V doesn't support auto-eoi with Secure AVIC.
> So set the HV_DEPRECATING_AEOI_RECOMMENDED flag
> to force writing the EOI register after handling an interrupt.
> 
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> ---
> Change since RFC V3:
>        - Update title prefix from "x86/Hyper-V" to "x86/hyperv"
> ---

Reviewed-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>

