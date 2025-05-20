Return-Path: <linux-arch+bounces-12027-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB11ABE08A
	for <lists+linux-arch@lfdr.de>; Tue, 20 May 2025 18:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57C3D3A31E1
	for <lists+linux-arch@lfdr.de>; Tue, 20 May 2025 16:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE9C2472A4;
	Tue, 20 May 2025 16:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hht6WsPB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sfBTg44R"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF669258CE3;
	Tue, 20 May 2025 16:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747757995; cv=fail; b=f8AmJ7HWAVcV54jB6ooVm0K3j7zxPJ7B7nF0hAuy9gntO01eZVVEn/j5XbfZIoxff0zhAnjXizKQZXnk/K98l7ary4kIxLXYZ/nvNNFQd1YhH44kZSYoYrZfih4BziYf6XGu6AU3r+8IygXEzAWaTfAJRn8F4KCmIN3/5swermU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747757995; c=relaxed/simple;
	bh=ezL5SpoUyp5mpS3Yh/ZOQjid84mS+KhshqWsOdGD+aE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qFOsygEZfVq9Er7gSoXKaKWqjghsTkbRAr7yQSjdKh3IBKvyQ/IHe9+jMW6AQXuA6TilelGKg2TPxVdxgBeR2A0v0MA6Q+5ozbqGAhm6DSoisbCxG4Tv+KwJQ6ieuGDJtQ92iBFfgzdKQs9fGiKWxoEvZYpdeK56ysENd6oQtf8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hht6WsPB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sfBTg44R; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54KGC0sl022079;
	Tue, 20 May 2025 16:19:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=ezL5SpoUyp5mpS3Yh/ZOQjid84mS+KhshqWsOdGD+aE=; b=
	hht6WsPB+KPesVJ5wuAKpIs9MN6kx4RAmnW6VGSUer50lc+De3xtCptLCpt15Kuv
	rt5xGDYqx+D+ZGO78jmukyYEZOxnZ1yxJHqmOC3wv6krF+4JB8OswI4dwlYiyVjm
	l6nmIRDq2DNPdd/MftOZFaGDfGcF1uatOnKwvkj+n0b2j+msnsxfmpnVmu3ZHBZ0
	BvlCE897UeL7DIhNJuQ722tigCZX8npBTG1ooFowIE69ZmdR8nMeOaEczrHuU+4v
	99Ro8UWE1a0rs6RCJCi3p2XhayIKIkOlZcpLFHOxMAB6kZlcyy2UCxByiGlCNRsA
	Zxhrv3++fHN3+WNUrICPGw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46ru11rf36-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 May 2025 16:19:35 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54KFCH5g017350;
	Tue, 20 May 2025 16:19:34 GMT
Received: from cy4pr02cu008.outbound.protection.outlook.com (mail-westcentralusazon11011068.outbound.protection.outlook.com [40.93.199.68])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46pgw8gc81-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 May 2025 16:19:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xb9XaiLja9k+6FU3Pg9iFPHZHqHOxfLc6SJiHjKwfnlButCIFkOmeEdmln1Ey6KHuMpKRZPY3C27N76oZh5Zhw3ulmMjl2+A96DEu/VYgeDgDW6zu8VkaDq5VkFyJT0uR1n1UJzAKzk1qdfJEBO/C0sbMfpmnT8FekCWJKKhLayUz/wkkRsX8ZOankJSa35gz4WdtGETsxkulMr3BhC1RAg9xUvEPcFDH8zT/4aonTG5zzX2QptzOTIwgDtyhpZxRn8RBbgxD/aK8AeXo0alRMcZ1X5uUKW46WMi9hepMVCi6M23AotoVFzOzyeeggvJADMeVLo68vB181I6hFuwEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ezL5SpoUyp5mpS3Yh/ZOQjid84mS+KhshqWsOdGD+aE=;
 b=GnomIfLZWs1Kf4L4arXRVWmsg4ypqYmZBjnLvPbJyb4S9Az+Bp07xdtleQcBrHbj9mYnZxgHmszn1d6KIr0ejegX/yqj789mj3MKQxKXxl4np0+FgM+65gXQKynQW4rTGBuBEf7eJljYGx0kpmOmUIFOD/ghP4jF9DbJ/oQzciwZJrKg5+6Piysauf7YMWTcSBQM1dYlCEQd9dHNR2d0cM55fJknf9okl7JJyGFuJrZgA0QiQh/9Hn7MR/bnJDUJk1arZgAZDQNyiV48Hcn+Q5RXWTLj0IacXFxgfASoXm8WPxTgPGfQHC6Vmed90udVoLlhUr3BST7HiXGQgT73bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ezL5SpoUyp5mpS3Yh/ZOQjid84mS+KhshqWsOdGD+aE=;
 b=sfBTg44RdI0+I36nTaQhV9rTwFmv1w+7ZXzbC54anZEtFZnls0e36slErURATUK99+TO7GHuM+tbys5Q5NZzBIuz1+8L9LebmB6nhlpo09TrYgw2icfZZ1k7Cyt8VFgxauEIWNTZWBier2qToA1nXLIfz/fSR48BZ94aw8/Z/8o=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CY8PR10MB6851.namprd10.prod.outlook.com (2603:10b6:930:9f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Tue, 20 May
 2025 16:19:28 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 16:19:28 +0000
Date: Tue, 20 May 2025 17:19:26 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jann Horn <jannh@google.com>
Cc: Pedro Falcato <pfalcato@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>,
        Arnd Bergmann <arnd@arndb.de>, Christian Brauner <brauner@kernel.org>,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>,
        Usama Arif <usamaarif642@gmail.com>
Subject: Re: [RFC PATCH 4/5] mm/madvise: add PMADV_SET_FORK_EXEC_DEFAULT
 process_madvise() flag
Message-ID: <24272ed3-0d16-412b-a7f4-78d02c347837@lucifer.local>
References: <cover.1747686021.git.lorenzo.stoakes@oracle.com>
 <617413860ff194dfb1afedb175b2d84a457e449d.1747686021.git.lorenzo.stoakes@oracle.com>
 <czd62f2vzwv6fow4ikvzlkjdj5odhc3nhtc72onwip52baobg5@yc5pjiqoqnh4>
 <CAG48ez2+UEifqF=GRat0dStPfDNXzzewHU=zxj0+FbOXL=mKVQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez2+UEifqF=GRat0dStPfDNXzzewHU=zxj0+FbOXL=mKVQ@mail.gmail.com>
X-ClientProxiedBy: LO2P265CA0476.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a2::32) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CY8PR10MB6851:EE_
X-MS-Office365-Filtering-Correlation-Id: 413f5466-f3cc-473a-9868-08dd97ba1878
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MUcwUlI4cHhGTkd2M2hhRDlHUzhKclFESkU4M1hKMmR0OFpFWW9IWnZDbXRG?=
 =?utf-8?B?b1pJYTdIdkZMSzA0RXIyMWVLK3pqUFcvYnYyT0VmMjRneWhySENSbmJ3UjRa?=
 =?utf-8?B?YVNlQlNtZ0I2TGVnU1VYREtkeHlkdW4zNFhkUUQydW5mejFwbEJxQjM3TTQy?=
 =?utf-8?B?RktROTZGcVZWTkFkcDNtazVIVlR3RGNrTG1zK3RtS3hDWW1HdllwVGUyMmEr?=
 =?utf-8?B?QnNXSStXZ0FrZnVJWTJhK0UxTDdUU1NnVGdjMGxkdFI5VWlkNGdJbWNYZ3ZS?=
 =?utf-8?B?dDB2K1B5aHJNc2pldm40QlRZWWkwYzlHVERwdUVhOEt6dFVtNVR5bjNObC9x?=
 =?utf-8?B?THJCVG1WNGRMWnNtK2ttb3EvbFBtWDVHb3VER0dFNGFXMFVoOHNzaXBJMU93?=
 =?utf-8?B?T1FVb21ybWllMWo3eTg4MURnOUl3WHd1YTZ4N2JwT3k5UjFMR0kzME9zbGlo?=
 =?utf-8?B?YXpBSTI4RjI5ek9sRHREbzhxMzZUQXFjNFRtbFFLc1g1TWN0NENkaVduMVJZ?=
 =?utf-8?B?TzNuRXRVZnkveWFpMkJqK2xsMGQyNVNCYkxJZldvRXJrNXhOQlk4Kzh4cERO?=
 =?utf-8?B?K0VGNWpaRVNsdmJkb2l4ZkhtcUNZcDJTZkJjT2NWdTM3V2FIWWZINDJqV09H?=
 =?utf-8?B?c2xHdzAvcEM3ZzNrYXJTMmJIU3g1dWx3R3RNR0VOWGlBQW9HSHJlRVhVYTVQ?=
 =?utf-8?B?eXNRcnVhZXk3a05odmN1OGZ2dHpxdWNVTFFHWG1YLzF5NGRwK2M4d3VDNzBy?=
 =?utf-8?B?Zy8vbERpTW1qTFhFL2NCb0xnZS9oUU82MGlSMVJxUzZmK1p4Rytid3dIa3Bq?=
 =?utf-8?B?VmYzcFZGb2tMVW13b3ZwNFdwUmErQVFjajQ2VmRmVXR1RllRTVpITVJBVXRw?=
 =?utf-8?B?OGR2OFpick5ENGZnNjgwemYxOFdNMDhjcVZ5WG14TGY3cHB2MWZSVzVWQ3hO?=
 =?utf-8?B?WG56NlJmSWxJb3psUWNpMi90dHc1dGxNRk43bFQ0K3kvNW43OUZyUnByQjgy?=
 =?utf-8?B?NGRPekpCOTNhbkNCcUV4MUNLcVljZmtYWmZJQWpJZWhiUkJRY0czY0orazVa?=
 =?utf-8?B?MXpQODhlU2JzRjdLMEdORTZoSkcyaGZvN3V5NHk4M2pYY3FjUFU3K2FsTEk0?=
 =?utf-8?B?WFhqUm4yWXE1ejZUV01Va2g2VERlR2Z2SS9zbkVlTzhWZFpZTi9YSVhYb29m?=
 =?utf-8?B?S1dGeWpNbmZhRjdoSG8vZjU0RGdrMUJIYkdkOVBxUFgxbm1tVFE2TFV1TFpE?=
 =?utf-8?B?SStBVDZJZ0IvRlBMTk9BSWgvaXhvRHA5Rnc5VXh1bUtBa0RTMEJuUFI0c3FT?=
 =?utf-8?B?eG4ybzYvZ3hkRndVRlFkeW5nb1BjaVJsNjFkWUtjY3BrWjFoZDVnWXptL2Vi?=
 =?utf-8?B?QXZzRVFEc1NMMi9naEY1TndFaEFzd29jaE9RNjFaTko2M0RkRGdwbEdocnUv?=
 =?utf-8?B?VTJLZ2JEYi9FWUZzcFQ0VEtQNWdCSWpmQmFoS1NacEE4Zmg1LzlWTUhXWlNI?=
 =?utf-8?B?WGwxM29XdVAwR3daQ0tlNXF2V3diSy9zRTY2MnBlNUh6bjJKM0VjZGsyRzJ0?=
 =?utf-8?B?SFlTcUVHWWVuREZoSnhjR0UvbE1URVRvOElJYlVHanNrcmk3SExsTkhBR3hW?=
 =?utf-8?B?YmpOVDgxY2lTc3l1elc0VjhhQVFxN0V4Zmo3NHcxT3oxOWFMNFV0S0JMYjVQ?=
 =?utf-8?B?dUgrT3poN3R3bXZwYUFOUnEwanVDSEJxS09CY2lYVkcvT1h6ZlhuWFRWVFdv?=
 =?utf-8?B?RXBYMUQ4dEJhUVd4ZUtkRUtOM2pKK0dMTnpoanlHalltMENsZFkxZTZZb2ZC?=
 =?utf-8?B?V3VUQWRYR1luQ0hiNi9GMVI1aTRJY0FmL25IeUtzYTJscFptZ3IxeWo5ZTVK?=
 =?utf-8?B?WTB6ZDNlOUxxNXcwaTlnMWljT0lsSTlxMFFZaXRGQm4zc3hPbmttMTU4c3k2?=
 =?utf-8?Q?WSQwRsSKkjM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YnVudlMxWG5zdDlVRjczNjAxUys2TC9HdUlvZFV4OGU3R3BqTjEvd1pKMWNu?=
 =?utf-8?B?alJmTUlmcGdrK0dMaFY1T1ErUFpHV3hqMjhFUHNtK2psY2Q1d2VhUVNsOGI4?=
 =?utf-8?B?eDB5djkvbEMyemRJaG9IZmU2ZW4zRHkyWFlKbTN5U1JrZzBncHI1ZTFzNHFz?=
 =?utf-8?B?YjRGRzZ5TlpuUnQxenM4dDhMbnZxeWJJbkdNS3AyVEd6K3gwc3ZEODJNR1cy?=
 =?utf-8?B?OTdueXFRQnhRMThmSTY4dHFyMHlHOWhSc0FWTzlaL0xuQXlhcUJOWnVKMFkz?=
 =?utf-8?B?bDF1WUc5eTZVQ0g3a1RLTEFZeVZzQTlFQ0ZOT2FINGQ0bS9mMlhkVVo1Wkl6?=
 =?utf-8?B?dWdFT1hLSTBsSEtZQlQxblVMTTRkdFB6d2RxYW4wODg1LzZvZytxY1VPbjA0?=
 =?utf-8?B?Q1YwTFZldWZKSjNsbDgvL0pPSU1lTlUzODBDd3V3UVhKd2VoSXR4a1k0c3No?=
 =?utf-8?B?djA0Rk9iamV0c2JyZy9iZmdIVkE1aU0zeUl0a0l1eitxV0pFWmV1OW5NZnpC?=
 =?utf-8?B?YXBTM3R2cjFrWmtUOG9JK1p1ejUzRkNjOHg2NHJ0anhPYzhxTEZYUnpwa3Ro?=
 =?utf-8?B?dGVqNEpnNW8zUWZNcld0Y0hUbExGVjdwRVhqcm01WlBWUXN5ekJzTEE3YXRh?=
 =?utf-8?B?ZzI1dkhjL1NCMDdnWUx2WFpkd2NkY21xamtKTVVTWG1kYlhuOTRvM1NIU1Bj?=
 =?utf-8?B?UzdRU0JXOVdSQlJOQXFOeGRVTEpPMmcxZmVmUVRQMVlzUUxVeGNaOUVLTnVh?=
 =?utf-8?B?OVFpK2dadDhmdEJZdHg2UXdCT2NSUWdNamkvNDF0YkgvUnpPR053UVUrWWtZ?=
 =?utf-8?B?aENtNEt4VTI4YjMwUXlwa2R5L3RrVTZmbVE3K1BibzNHRUlUdmxYZmFWSGVi?=
 =?utf-8?B?bFVkUDg5ODc3bjQzY1NycVlWcnc3K01sdmNlL3VQWUtYS1l6Z0tHM2xKa2k1?=
 =?utf-8?B?bEQzdHhKRExGczdNcllvWm5CSE1VZTFPV21jbEJBNE9DejZKdE56Um1la3dV?=
 =?utf-8?B?ZkIwWHVLcG9vUXhIVStVVngrMG5weFJHVW5GS1c4cmhSOTRIK0RLU2tNSzMw?=
 =?utf-8?B?OXNxOStNWW9selNDQlJNYUFVVDVKZG44a0dMNk1nY0VMcHNLUjYzblVsS2lu?=
 =?utf-8?B?SE8zTEdRZk9jNmRvWXVudUpsZFdvdUY4UGd1VytLK0ZiZ0pDemxYZWtteTdK?=
 =?utf-8?B?RVNXNnJwTGNyaHNqYkFLL0lySkhxR2JmN3N6aGFzVWJsby9uZjdYb3BTbllX?=
 =?utf-8?B?OVk5bjFwbWdJc3ZMcXA1RUNXcm9Na21SMGlKd0RSQnM2eVAvTWpqV01nS0hl?=
 =?utf-8?B?WCsrRjZjbE9TVzMzZ3owZEZGa1dnR0dUSWdXSkxsN0dOVHptMVFYUXZLbkJH?=
 =?utf-8?B?MVQxQ2pXNnljQjRuR2YxOHd0cEtCTkxadGpwT1U1Y3BEUENpOWdLSGRzQllP?=
 =?utf-8?B?bnJQTUNFMUdRWFJIdVhDUnRqZ2owZXphNWdOekI1WDhQRHB4cFhsWEV0QTZM?=
 =?utf-8?B?amRlc0NiYmF3ZDVLUDlOa1p1QUFLNmhEbDlpaFpOaHJ3UEx5a2YyRWtLdjBC?=
 =?utf-8?B?MnMwYXkrejcrL3ZZaUFRdU52NEdwdDFVMHFMajFKYUk5bW1QNHJUcDRPMWRZ?=
 =?utf-8?B?VEdodVRZUjcrNUt1ai9jT05KbkhyVDJIOEdUSGJ1cVMxYmZlTHl3MExhRXZn?=
 =?utf-8?B?cjRScm02aEN2L0VGWW9hM1JaQ09heGhVd2lUMHlKc1ZWUzF5UTVsNXRBVkJv?=
 =?utf-8?B?RFArWnMzeU90QlBGL0lNam4wQlVSM1R3N25aZ1FmKzRQSHBxN2s2M0RMMHV3?=
 =?utf-8?B?a21jT3JaeXRMaXZrdC9BR3VJK0dHaUUwU0VaTzRpcUUvWDlkbW92bkYydXR3?=
 =?utf-8?B?VVBwQ2tQMVBGdk4wZ0FncUQ4TzhTU2hVOTdFK0ZOM3Z5MXJBYnd1Z1NsUWRr?=
 =?utf-8?B?SUlLejZ0V3RjcGd2OTBvNGdpNDZRR1cyc3FEOWdwbXRpOEgvTmwzRWxGTldR?=
 =?utf-8?B?VkxoRDczeElyQUhSS1VkQ1k4cE9TV3hpWmRQbWpDakZscmR4R0swdXJSZmdN?=
 =?utf-8?B?eGJyekFJS3ZjN0pHR3k4UjBOS1Q5Y2luM3VqYUpUZGVJZ2tlOWN2ZWsvcHho?=
 =?utf-8?B?WWNFZ0UycW8zMkptckFHMFh0NWlvR3Fjdmp3QWNxaytSUnZGQk1uMXZ0N092?=
 =?utf-8?B?b3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qtaEIvkcXxcuaztslLgHO78hIC3nQt+jSlZbomzIGTw7Ld9pCbz+rdcOxrwiakZpMT264eeOuyDjGLRO0a6TnG0x5nEtAj9gXtg7gNN0YsZJMdV1AkltOEAxpmdfnd4rMFLO+YetDv7AlZdqCeV2pzGlfdpwzzHsYQG9SDNMXNyqVR403AJVTJPCbNIE+QErvHnHqYXk58ACMSR/rNOftKrhWbSfDwB0JGI6STePNNHYyI8zAnj+k2yEFQyVFVqJsckfQnPEKMerzI4ReCxOJxKF43zbdWcZ2IrxKGizRqKx3J67OcjmgEKCI/5J8gkR3AuSoDiiI6xom43zffAeWGEzxWoxvLjJepHZld9mAS1Mo/U/6uUlvdm0QKNrHAv9sK9kD6GydNumamNRi5cZ5q87FAbDjFh6ZjViXioIxN5g/DZQNJiPfhuEkt7e5iwFFBtYKZZhI9gQn9o4qlNFmH28uEuZuLiWE3huFqbbvc9lq+J2nUMYGCm02onpWZeFYgFmZaCfV5mmoNvXX4IECMtOBfT5/qhiIXV0F9wTLVjVWW+x61wZoDTxkhXUs81thYr57q7tA+SB8NIPk+pktFCoxV0t/uVuMPYfWoW2Hf4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 413f5466-f3cc-473a-9868-08dd97ba1878
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 16:19:28.7687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HOsjoUk9ZVSnPGuBm9/dF2yLLRYR+lbWRTZMVfD0u9zCIzJMZes77xrIZFztsNxuS4tuF8h86Ks/wvhjoh37wQcR/hsizfBhcmXjIhU1jNo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6851
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_06,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 spamscore=0
 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0 mlxlogscore=958
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505070000
 definitions=main-2505200134
X-Authority-Analysis: v=2.4 cv=RbGQC0tv c=1 sm=1 tr=0 ts=682cab97 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=Kzr6cDFhjX9Ab3z9xHsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13188
X-Proofpoint-ORIG-GUID: Igu1VVirqwdjPKbRSjV9wR31IwphscHa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDEzNCBTYWx0ZWRfX7O00x9e2sNzb RIl0yt1EZ3gCnDJlQA4UkdaRZELuEeIQP6qsRBjjtkKWRd4BKxaVQHDhqFMCQOBh30NCIlgB88w cZ1uN9ISgv6b6ieNCb5TT/ANYoJsGvuMocj4YNq6T/w2quHWV5kHYQfJqXcS116QCMRIt0xzxJa
 fsi1GPVdO4mGro8VBIK/sx5WbdZ7UEqtuqFA5fPNaxyCqzy50jLU7PdhX2O1FrpyG+e3GaImAA3 xhJ5aUpVCA8zSqVQkojeOsqnet3ntAvCl5nVJCx2Kr7nuV8PolIoBdK9XB9jFtawc9aDdThIzwp 4opJt7MAy/1jYVJlGwm+2D82rVq1jnkM3cPAwT8CSuf1MgCxrIWkm8uqF/os4SYZ4dwr1EsMgqU
 PS27duR374oNEDgC0JaVHNmJ1LtJUQpT6WZ0+r2udfxMs8ubLuWSdLe422bX3J+JCseD8AZu
X-Proofpoint-GUID: Igu1VVirqwdjPKbRSjV9wR31IwphscHa

On Tue, May 20, 2025 at 06:11:49PM +0200, Jann Horn wrote:
> On Tue, May 20, 2025 at 10:38 AM Pedro Falcato <pfalcato@suse.de> wrote:
> > - PMADV_INHERIT_FORK. This makes it so the flag is propagated to child processes (does not imply PMADV_FUTURE)
>
> Do we think there will be flags settable through this API that we
> explicitly _don't_ want to inherit on fork()? My understanding is that
> sort of the default for fork() is to inherit everything, and things
> that don't get inherited are weird special cases (like mlock() state).
> (While the default for execve() is to inherit nothing about the MM.)

Yeah this is true. It is the exception rather than the rule...

>
> (I guess you could make a case that in a fork+exec sequence, the child
> might not want to create hugepage between fork and exec... but this is
> probably not the right place to control that?)

From my point of view it simply reads better :)

But perhaps we can drop the fork bit and leave that implied.

