Return-Path: <linux-arch+bounces-8097-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C9199D52D
	for <lists+linux-arch@lfdr.de>; Mon, 14 Oct 2024 19:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06C7F28483D
	for <lists+linux-arch@lfdr.de>; Mon, 14 Oct 2024 17:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 172481BB6BB;
	Mon, 14 Oct 2024 17:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GSVFFbqY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WOX4K6bG"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3161AF4F6;
	Mon, 14 Oct 2024 17:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728925364; cv=fail; b=dVLlfnF3FhD++gjfo5lONQ0wzJ/hRruymyZ1RzP2xYaD44FRwRxQZ/iWcg3sOjM4/dVwrjSFaR6gg1WlQd7UepoGuScMsU8BId1CrP+bWqjXhvpNrGo0OY6u46SwYEXv3t/d/l11L1sroP6UdrDZZhTU8SmHo4HGh2R1Es8/ink=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728925364; c=relaxed/simple;
	bh=hqFl1P3ZztTLFzFB32hBwfUQzWejwJaeGqB3JeRW5P0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qpNpzl8a/YKMpshPUjVGpqA73j1wrKJ44z2eZjPv8+agP7ZmqyZCiMogy8a+L9GkKbgvbJos8ubc/CGT85KpKYloo8Ro7k4D0dREeEBwpStcSMynEWsktJUyzNrbGjquxVIYTY9nkYqWCxRRDDOfRL+A38uG/k669TV/sFRQq1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GSVFFbqY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WOX4K6bG; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49EEfhi3019239;
	Mon, 14 Oct 2024 16:57:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=ilBlboGQh20EEmGJfGfWY8BpT3sT0b7Ouacl070+tf8=; b=
	GSVFFbqYS0Q0SjYnIexvRUwuJZigJl5GBSDp3b91957r6zIs3PpnUx5ydyy1B/zb
	RNZq4BCghRYI2MhlZufjEgTeMl7Yl1K96E3IhOHLPpeU67XlO9CeWWiYoRZfCUgW
	sOfuXfOw4Nz+BFbq/YSYrXXm+JglevkgI+9ijqvSG9IF8uY8Twpez3hFFcmgvEJU
	H/rhQuj9C/a8k8poLSjcO4JWqwMAe4Yx43JGZaMhDzUGcaOs+9EgSOqamxWBtQMa
	+1H+rDaWbrYIscH47OyT3s/uhdba/+uooTMeEmAgYvIovKDVAm8hvKoIdDElkmRy
	kIehOriU9H62fkOnBnKT2w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427fhcefaq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Oct 2024 16:57:05 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49EFVmGK019946;
	Mon, 14 Oct 2024 16:57:04 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2043.outbound.protection.outlook.com [104.47.58.43])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fj6ayqt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Oct 2024 16:57:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KZhD1BuSZ1adndaY6x5uNz7OSLsrE6AoH1K6WuxJHwyuSuAQnPGc6ro4mKurdvztd/7id/jjyOUWg8cc1E0iDglmI3uQYFWh5ePDIfelA3lHCiVl0VT5LEjuGBRYcNfrzP81rLYUZYlZQQBzQQsx+r/6nE/kFv8tdGZJx2hcz7RiJN+hzGMK7vwbMAG5g/MAJCdIfpTaW1n6SkhwqmJG5smXETkCbjd5WEYCBRLYXHq5Pmt9SInbuoupyQodjaKBmLzva4z/uR1qX4dCY/Eric5vnXFauR6kkVR/zJe/tVGOKIHgSFipvzkw5bdpmLUE+TdHksc375u+NdoLBzAXVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ilBlboGQh20EEmGJfGfWY8BpT3sT0b7Ouacl070+tf8=;
 b=DemsO8A2hHcHGm+wM7Awah7olQkt/oyyEgMbUAad90YaalbqE7fF75I7uBOCvOPTUP2Lz/QIgMAeYKqTvHmpCcWLBETw+x1LXzcg/JWvG5CI5u4Jw0kMzZlpdK4SH6MgsJQ7cOqtgkxKoGRFLpZDjnagpSPGENgUE113Zoc7okGKjUpehd10HgUZDb9NGgyBDwdLuq6zDgD30N+jT4N3X8aW2ka1gx5S1SS2JBI1jPrtIh2MSFRS280Dv+efFX14wmt+i80S9BdWDDIp5WEtyHPGsTajj77zgmOc8zN/RBcFcQhXnDWp2VxvNfmU1bGop+g2FJaUCKqVcoUs1A2kEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ilBlboGQh20EEmGJfGfWY8BpT3sT0b7Ouacl070+tf8=;
 b=WOX4K6bGcfkTmXt1HTiMByNFE0jOKGMWo+jeptsD74XxH8VNFDylLeYj5r3qZCKSBNvKDn9dBSctSeIsgR02CGeBwSetxMpTX4iSUGj8hArwWGWME2CaaAcHV5ktRqrMW56503XYqM1KNuO6l9M9I9j/Uaf1ixIlO/uWB8t27y0=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by MN6PR10MB8024.namprd10.prod.outlook.com (2603:10b6:208:501::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.25; Mon, 14 Oct
 2024 16:57:00 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 16:57:00 +0000
Date: Mon, 14 Oct 2024 17:56:57 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jann Horn <jannh@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Muchun Song <muchun.song@linux.dev>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-arch@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>,
        linux-kselftest@vger.kernel.org,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Vlastimil Babka <vbabka@suze.cz>
Subject: Re: [RFC PATCH 3/4] mm: madvise: implement lightweight guard page
 mechanism
Message-ID: <b483187b-5caa-4581-86b1-895184301cbb@lucifer.local>
References: <cover.1727440966.git.lorenzo.stoakes@oracle.com>
 <a578ee9bb656234d3a19bf9e97c3012378d31a19.1727440966.git.lorenzo.stoakes@oracle.com>
 <CAG48ez3ursoL-f=mYpV79Do18XPPt+MPPHNUBv6uFE1GhpOwSA@mail.gmail.com>
 <868739d2-0869-462f-ac86-1a8d1dccb0a4@lucifer.local>
 <CAG48ez3vqbqyWb4bLdpqSUnhwqGo2OQetecNhEGPdCGDr94nbQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez3vqbqyWb4bLdpqSUnhwqGo2OQetecNhEGPdCGDr94nbQ@mail.gmail.com>
X-ClientProxiedBy: LO4P123CA0031.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:151::18) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|MN6PR10MB8024:EE_
X-MS-Office365-Filtering-Correlation-Id: d1471184-2c1b-474f-8587-08dcec713894
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U1RNdVdKS0VacjBGQTZ6Q3Bkem9pRmU0cVpCRFluRlRyeUhYaWFsbXVxbVRK?=
 =?utf-8?B?MStpbXdlWndwVHpMRDRaV3VPSzJZTlBTVVBCejNFTndFd3pkQkNkWVJsR21S?=
 =?utf-8?B?V1hoemMxaDB5Y2lGMTAzUmp4Zjk4R0FwSk9QQ3c0T3VyMEcrWW1uZDRBRnh0?=
 =?utf-8?B?OU56dzNNbGZDRVkvclVaS2NoRC90YkRUS1hoeTN5NVNaR2hEdFpDMkFYTitq?=
 =?utf-8?B?TjlnVVFoRzFZTFg1b0pPM0x6dGFlMVNkN1BRNDFBRGhmVFIwUGdBQkpUeFZs?=
 =?utf-8?B?T3RwK0dMOFBwYk9SUEFXTjY1T2t1T0xNWDd5eElwTGcyRUc2UUVtUjNiVnRx?=
 =?utf-8?B?SmU5NlZOTDBJQ0s0OE4yaWc0WTY0N1ZVODVsVVRKNWZJeHZ5N3ZObkJmTVFu?=
 =?utf-8?B?VzBDdk05bFMwZU92YVVGazMyQmQzM2J3MUJuWUVwSHNoK1ZuMEMwSGFNcmln?=
 =?utf-8?B?MnJ3TVFwcmQ4U1hUbHkvQU5CTDFqcnFnRjJ2UHBzc2dHb0k1dGM1cHZKaGQy?=
 =?utf-8?B?Zyt1V2FuKzh2MU94K05Vck5CRXZvSFdUM0ZSWTJ0a083d0cvQjhDTjYrL2Qz?=
 =?utf-8?B?M05FTUpQVW1VTTNVZ2RyVVk1Wng2SGVBTDNHSWI2dnFWSnFGR1JvZ2ZaWFNH?=
 =?utf-8?B?Z29IN3BQZTFNYWhYV2lkYTJGRTkzVXVJSi9YcWEzSDlOQnhwd29wVy9iYTYw?=
 =?utf-8?B?ZlRxTE5Fa1VwNlhPQWJYbkxZK3ViQ2g5WkdpSDlJbXJhZzNRbkhHWjJUSlI0?=
 =?utf-8?B?VHRRZWN1SGZaa2Fsd2sxZWl3ZHBGWEwvaGgvaTZ2eVU5RE4xK3ZPZ05qK2J2?=
 =?utf-8?B?K3lITkFPNmQreTc5QTl1RHZWNzhKL1JCalNzU3QxYVhGSGFLaDRWeTFXVVdJ?=
 =?utf-8?B?UGJtTGtDak1lU0w5TTd4STZaWWVySVJ1QmRic3BlYUVNUHV0RHhsMzZseW0w?=
 =?utf-8?B?L04zWkVNOWYwM0dsR3gyd1A4Q1JXb3hONDI0MlhKV2tPUWlpQmtxTS9QcVlQ?=
 =?utf-8?B?R1pxTjV5Sjl0SDFjUTBzbGVJNzhNdmdwbmNtN2QweXBTbHhKR2NBaFR6Q3FZ?=
 =?utf-8?B?eGlPeHBtTVNkZmxaaUluV1B0TWNETDhUc3NHUmdwanh1TmNyb2swQjRmRVZP?=
 =?utf-8?B?KzQvYnlWWDlBcnhRbVhSc2U2UXptZkNFK2dHaFE1bkxMVStPSmxpV01EajRU?=
 =?utf-8?B?dFRVcjMrOCtOeDUvdGZ6OHUwdi9DaTh3SnExR2ZuU29RemcrZ1o3a2hYamph?=
 =?utf-8?B?d3JwSXE5OVJhaUd1V0NJN2d6R1d4UVJnaG53WlMxYVlHL3FxNTZuUG1WcHR3?=
 =?utf-8?B?SGN0ZkkyMk9QVnVBbDA2RHdNRVpwTnVmYjBraEpxVVlYaEVqVy9oUDV2MlB5?=
 =?utf-8?B?NWg4U0hCRGxLeExzd0FrMDNrYzlpbVZFZGVUcDBWVEw3QklmVGJlMC8zRXJN?=
 =?utf-8?B?YlBYSytYa0RCUUExaWI3OEpodFFvMWNkTVBvdU5SdkVVM1BROXFadStDNXdu?=
 =?utf-8?B?bTZtQnRiZHBNMk1ZS2RzSnRlOEVDcHBYa1d4RDBDU083ODNLTWM4VzByRVpv?=
 =?utf-8?B?bWhFTnhPWXBCcTFLbE5BRDZIZHJmVXRhRHR5M1JVVHRsQ2twZEtWSGF4d3M4?=
 =?utf-8?B?Vm4rYzBWY3Vxa1E1clYrWkl1TUs4MVdhSmI3VXIraE1HMXdRTjBkSldoeUFQ?=
 =?utf-8?B?Q3lhTm1qRnV1S3BlLzNYSXQ1eDN6d0NIYUV3VzhlT09vUC9jUWJhdnJRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TlRkcy9vQ2dRVlBicFlpY2lUb2xMVGF6dzdCZmNlWHFMekhNR2VwamFPckNk?=
 =?utf-8?B?N0JOWFFlT2hsRDFhWHZQTWkzVjVIUCtGd2VDNi9wNzd0eHlGYUFINFFBQmNL?=
 =?utf-8?B?bVMvNXZYNGxKSEt0bTkxSURPVUJSZHpEeVJ4OEtRajh0TU52ZzhXemF2VWdq?=
 =?utf-8?B?NWdnOXRuOVI3cWZ4RU5xYTBibjF5MzYreGxZdENYaDJpQ3g4dTBReGNKSzcv?=
 =?utf-8?B?dnYyZFY4anh5MWY3aXdFSi95TnZidUM2Q1RXdW9KbXRMWTFCZVJIdVVCcEd3?=
 =?utf-8?B?MXkwV2RQeVM0bG1ySCs2dUM3TmpIYldnaFV4aTEyQlF0eFJVWUZJWThna3lq?=
 =?utf-8?B?cU9CbjNEdjFGVURuV0tMODBjYy9YeFlsSklocDVndXRXODAxSDJwc0Y2M210?=
 =?utf-8?B?dGplMG1yTk1HNC9tZ2swR3g2c1duNVJPMDFXZTcwYjRlZ2lWa0cvK0dvQSs5?=
 =?utf-8?B?RHArZm53Z1FobWY0MUh4Qkh2N1UwU2xlOHlHWGJ2UmlZVUwxRHhKY2NuaDR0?=
 =?utf-8?B?dmV5dkxOZ2NXVnJLdjBiU3I3SWF2aFZpelExVkZLVmdUMUFyUVl2WjVTdXVn?=
 =?utf-8?B?WXQwTDh6aXVPUHpOd0lGWUd6VU1wQ2Q1MDFSc2FRQVV5YVNxZ3hrUGxvbk0w?=
 =?utf-8?B?MmMxUjdtV0xVaEY0aW5MTUlUanVUTEdrSDFreU1aNEYvOUYvVm40Z0JqNTdp?=
 =?utf-8?B?SmYwaS9iS3IzVGdYM3pMYmdxa29nYWVjc3hyc1E0ZGtYYmszOTlRQ0RFMFhW?=
 =?utf-8?B?UGJVTDF1WThCZmJrajJieFczRkRsTGVpb1MveWYvaDFqVVVvaXNtVHpXbk1I?=
 =?utf-8?B?VVVEblYzdStOUlVoN3hSa01ZT1V2SHpyL3d4SXJ2OEx2bUJKZm1tTXE3MStO?=
 =?utf-8?B?c1RMY1ozS3Zhdy9zUVZiQktNVDVKaHdhdkJOcGlGemd5cjlYME9SS0Z1ckhX?=
 =?utf-8?B?S1NSMzQvSm5wNE5JTlZBYnpKWWFYazhZaFoxVUpmTCs1NFhSOHJyTVdIbXpT?=
 =?utf-8?B?bTV2NHVUeEcvR045YmZhakxCbEJHemQ4QUNMajdFVnNiQm5wSTlGZVpoTkdN?=
 =?utf-8?B?cEYwY0xid2xqMXBKMmd3WDhtT1gwbWUvNzg2NFplY0hIT1lySndWbEQzRnFj?=
 =?utf-8?B?b0phek13VFdCRjZFSUhSRUtoMkd4ZjNVSm5lazFjMVZkWCs4Y1VxNTN0d1NF?=
 =?utf-8?B?VFdPVzRWT0xWQXE0SmRxeStPeWI2K0hxMlI5b1RvaHJ4ek9DWWRsRjhISlNP?=
 =?utf-8?B?TjFaMnJ3a1dxY2g3d1d1eFBUaUQzeGJEa0RYRDAzaGJWZ0xLbHFoZXYvSVZh?=
 =?utf-8?B?dzJFeklnN0MvemFwSCtSemdkOXhVVWZvL1Q5RzNPSURENXFlbVFpaUMzZHZl?=
 =?utf-8?B?MVhCeFhKMmVPOVJXOUhWMVdWNXVaTUN0TnREalhjUW1FQm9hcXVnS3YxUXZY?=
 =?utf-8?B?ODZWTDlURGowUXhvSDlyM0VTQjhnYXZvTmdaT3ZFQWpJWGZQOEJwS3B6UlhU?=
 =?utf-8?B?RStZcnVua0Y1UE1ZcnFMK1pseW1pN2Z2UmNZZi9VcTZIOXRSRjkwdnBjY1hT?=
 =?utf-8?B?ay9mNmdxYTFycXNqcWpIZmdBY1RvY2JlNjJKOTN2TGtjNSsxZVBRNHZNQTAw?=
 =?utf-8?B?aVFCNzBXVU94bUJQd00zZ2JSdzVHUW1meHF0Q3pLSVl5VnJKaTd5eXF6VGJv?=
 =?utf-8?B?NW54RmhqMVQvVkRiMmt2UUtUVHA2T3NvNTdaN2k2YmNBVFNMWjBuOVk4dFI2?=
 =?utf-8?B?cHVYSHVCMHo0TjVkMVJTaXozY2d5QTVlVi9aRUwrMVc0RVZqSEM3RTc4SkJr?=
 =?utf-8?B?U24xZ1dRWURBYm45STFWY3dDN2ttS2xxeW5QK0VkcEtvUUNMdkh0ak90Qmdl?=
 =?utf-8?B?bUJDbmMzeXQ2NWR2cVhWQ01kL2x5RlVxdG9PdGttR3lJWWpsQWk4dktXTGhU?=
 =?utf-8?B?NGZmZlFpdGVJa1FBR1JTMGZEMmxmdDZORWJpTXhaSnh2WXgwWG9MM0w1VDg3?=
 =?utf-8?B?YjdheHk5eDcwbk9CNVd5ZDIrK2Q3MzdOdDJySk9GOWRMcXdmNGU1NG1TSlpx?=
 =?utf-8?B?eXdyTEhRN3YzMlpuYmppKzlzN0F1bXltSHkyV2dReWw3RmhSOWFyYytYdzUy?=
 =?utf-8?B?ZFNZWXFhckttRTZoTjZ3Ykx3c1J2Uktmamc3MFdwZzZrZ2d3MFhYeDJueWVH?=
 =?utf-8?B?a1lmcTFJMFRYTkR5SUlTdktaSGlORWd3cHZZeTl6bmVETEpsYU1nTGQ5cmF4?=
 =?utf-8?B?SW01M1o3VjFvVk90M3BtSGlDTnZRPT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	87UqTDRE7QV2rqnERtyftKIP64MO1vjkKW3ZsX/dnBkQmLIiQfDWSMwhKpZdGaBfaHkuzz5wtnK/EbshipUqG/oGVFGnoddGdQoJx4MD69TD0acFyx6cJFgVicPxWBocI0nMcTuMahQ/pLw2uTrts0jlB7FSm43GAqTxtZepNHndrX3aRIYJz5aXVTcapBskrWCc4z7Nq8m0Nz7wQ+CZmCbvgqNa/othHeb+eefkKk2MsCpuE8T8AU9HHLyBb2EHaczVeu2JnmdXazGtWEQ90AT/wBpNowBfwn/0mBp/gT/E+LH+UVb/MGTKLDGBAw5lGy+zn3FaJhHJ6LQtI6Xq4PnomKcIbua5tvPQfTWyjSBl2ipRASzJGTN3eTA/xittcvQUUu8k2udYoQgFqra7AhYupXa8fuUgmR3fK6yXdL+YVQ1iYDbmtJ4xqWOFeDa7QBphtrd/V/r5MqQ/XFN4JHBOS6FveKvqFoFsbmwsphaVXI/Fnj0fjJh5BbEKNHa8KyDC0CqjQnKqOLOwQ9FeI2EGwmrefUZs5CSL26dyCoHVIxFjAsZ3EES7dO4b/nAmBg1rPpDCAw/Y81JMxrGwvQedlM+XtLOxBhVixAAq2zA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1471184-2c1b-474f-8587-08dcec713894
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 16:57:00.7062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AEO1KCgQhPIc+J+Aep6qUMWG/9oqHnY9kd0DiAZEcEUMCn9otqvO1t4UwT+y8OaoyupFOCi1MtUmAhkUbeil5LfliuNDRLgd9DnBpp9RfsU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB8024
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-14_11,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 phishscore=0
 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410140123
X-Proofpoint-GUID: 0AHo600uxh6NAApipis2CO8z0buiioGw
X-Proofpoint-ORIG-GUID: 0AHo600uxh6NAApipis2CO8z0buiioGw

On Mon, Oct 14, 2024 at 05:56:50PM +0200, Jann Horn wrote:
> On Mon, Oct 14, 2024 at 1:09 PM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> > On Fri, Oct 11, 2024 at 08:11:36PM +0200, Jann Horn wrote:
> > > On Fri, Sep 27, 2024 at 2:51 PM Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
> > > >                 return 0;
> > > >         default:
> > > >                 /* be safe, default to 1. list exceptions explicitly */
> > > [...]
> > > > +static long madvise_guard_poison(struct vm_area_struct *vma,
> > > > +                                struct vm_area_struct **prev,
> > > > +                                unsigned long start, unsigned long end)
> > > > +{
> > > > +       long err;
> > > > +       bool retried = false;
> > > > +
> > > > +       *prev = vma;
> > > > +       if (!is_valid_guard_vma(vma, /* allow_locked = */false))
> > > > +               return -EINVAL;
> > > > +
> > > > +       /*
> > > > +        * Optimistically try to install the guard poison pages first. If any
> > > > +        * non-guard pages are encountered, give up and zap the range before
> > > > +        * trying again.
> > > > +        */
> > > > +       while (true) {
> > > > +               unsigned long num_installed = 0;
> > > > +
> > > > +               /* Returns < 0 on error, == 0 if success, > 0 if zap needed. */
> > > > +               err = walk_page_range_mm(vma->vm_mm, start, end,
> > > > +                                        &guard_poison_walk_ops,
> > > > +                                        &num_installed);
> > > > +               /*
> > > > +                * If we install poison markers, then the range is no longer
> > > > +                * empty from a page table perspective and therefore it's
> > > > +                * appropriate to have an anon_vma.
> > > > +                *
> > > > +                * This ensures that on fork, we copy page tables correctly.
> > > > +                */
> > > > +               if (err >= 0 && num_installed > 0) {
> > > > +                       int err_anon = anon_vma_prepare(vma);
> > >
> > > I'd move this up, to before we create poison PTEs. There's no harm in
> > > attaching an anon_vma to the VMA even if the rest of the operation
> > > fails; and I think it would be weird to have error paths that don't
> > > attach an anon_vma even though they .
> >
> > I think you didn't finish this sentence :)
>
> Oops...
>
> > I disagree, we might have absolutely no need to do it, and I'd rather only
> > do so _if_ we have to.
>
> But there's no downside to erroring out after having installed an
> anon_vma, right?

We then use a resource we don't have to. I think it's more logical to only
take that action when we know we need to.

>
> > It feels like the logical spot to do it and, while the cases where it
> > wouldn't happen are ones where pages are already poisoned (the
> > vma->anon_vma == NULL test will fail so basically a no-op) or error on page
> > walk.
>
> My understanding is that some of the MM code basically assumes that a
> VMA without an anon_vma and without userfault-WP can't contain any
> state that needs to be preserved; or something along those lines. As
> you pointed out, fork() is one such case (which maybe doesn't matter
> so much because it can't race with this operation).
>
> khugepaged also relies on this assumption in retract_page_tables(),
> though that function is not used on anonymous VMAs. If MADVISE_GUARD
> is extended to cover file VMAs in the future, then I think we could
> race with retract_page_tables() in a functionally relevant way even
> when MADVISE_GUARD succeeds: If khugepaged preempts us between the
> page walk and installing the anon_vma, retract_page_tables() could
> observe that we don't have an anon_vma yet and throw away a page table
> in which we just installed guard PTEs.

Well for one retract_page_tables() seems to require the VMA to be
file-backed :) So we can disregard this at this stage.

We enter into a slightly strange scenario with file-backed as to how we
manifest memory poisoning, because a file will have backing in the page
cache or an anon page for shmem and it seems that khugepage() operates at
this level and simply remaps at the higher order.

But we then introduce a way the _mapping_ can be different and we have to
correctly handle that.

So I think actually you'd see this break there too?

Interesting that we special-case uffd-wp, which similarly uses PTE markers
and this is commented in retract_page_tables():

		/*
		 * When a vma is registered with uffd-wp, we cannot recycle
		 * the page table because there may be pte markers installed.
		 * Other vmas can still have the same file mapped hugely, but
		 * skip this one: it will always be mapped in small page size
		 * for uffd-wp registered ranges.
		 */
		if (userfaultfd_wp(vma))
			continue;

So this is something (one of many) I will note down to think about when we
come on to file-backed guard pages.

>
> Though I guess really that's not the main reason why I'm saying this;
> my main reason is that almost any other path that has to ensure an
> anon_vma is present does that part first (usually because the ordering
> matters and this way around is more or less the only possible
> ordering). So even if there are some specific reasons why you can do
> the ordering the other way around here, it kinda stands out to me as
> being weird...

I mean, fair enough, on the basis of convention and to avoid future issues
with this I'll move it.

>
> > > > +                       if (err_anon)
> > > > +                               err = err_anon;
> > > > +               }
> > > > +
> > > > +               if (err <= 0)
> > > > +                       return err;
> > > > +
> > > > +               if (!retried)
> > > > +                       /*
> > > > +                        * OK some of the range have non-guard pages mapped, zap
> > > > +                        * them. This leaves existing guard pages in place.
> > > > +                        */
> > > > +                       zap_page_range_single(vma, start, end - start, NULL);
> > > > +               else
> > > > +                       /*
> > > > +                        * If we reach here, then there is a racing fault that
> > > > +                        * has populated the PTE after we zapped. Give up and
> > > > +                        * let the user know to try again.
> > > > +                        */
> > > > +                       return -EAGAIN;
> > >
> > > Hmm, yeah, it would be nice if we could avoid telling userspace to
> > > loop on -EAGAIN but I guess we don't have any particularly good
> > > options here? Well, we could bail out with -EINTR if a (fatal?) signal
> > > is pending and otherwise keep looping... if we'd tell userspace "try
> > > again on -EAGAIN", we might as well do that in the kernel...
> >
> > The problem is you could conceivably go on for quite some time, while
> > holding and contending a HIGHLY contended lock (mm->mmap_lock) so I'd
> > really rather let userspace take care of it.
>
> Hmm... so if the retry was handled in-kernel, you'd basically ideally
> have the retry happen all the way up in do_madvise(), where the mmap
> lock can be dropped and re-taken?

Yeah perhaps, but that gets (really) horrible.

>
> > You could avoid this by having the walker be a _replace_ operation, that is
> > - if we encounter an existing mapping, replace in-place with a poison
> > marker rather than install marker/zap.
> >
> > However doing that would involve either completely abstracting such logic
> > from scratch (a significant task in itself) to avoid duplication which be
> > hugely off-topic for the patch set or worse, duplicating a whole bunch of
> > page walking logic once again.
>
> Mmh, yeah, you'd have to extract the locked part of zap_pte_range()
> and add your own copy of all the stuff that happens higher up for
> setting up TLB flushes and such... I see how that would be a massive
> pain and error-prone.

Yep, I'd really, really like to avoid doing that, the solution we have now
is neat and avoids such duplication.

>
> > By being optimistic and simply having the user having to handle looping
> > which seems reasonable (again, it's weird if you're installing poison
> > markers and another thread could be racing you) we avoid all of that.
>
> I guess one case in which that could happen legitimately is if you
> race a MADV_POISON on the area 0x1ff000-0x200100 (first page is
> populated, second page is not, pmd entry corresponding to 0x200000 is
> clear) with a page fault at 0x200200? So you could have a scenario
> like:
>
> 1. MADV_POISON starts walk_page_range()
> 2. MADV_POISON sees non-zero, non-poison PTE at 0x1ff000, stops the walk
> 3. MADV_POISON does zap_page_range_single()
> 4. pagefault at 0x200200 happens and populates with a hugepage
> 5. MADV_POISON enters walk_page_range()
> 6. MADV_POISON splits the THP
> 7. MADV_POISON sees a populated PTE

You really shouldn't be seeing page faults in the range you are setting up
poison markers for _at all_ :) it's something you'd do ahead of time.

But of course it's possible some scenario could arise like that, that's
what the EAGAIN is for.

I just really don't want to get into a realm of trying to prove absolutely
under all circumstances that we can't go on forever in a loop like that.

If you drop the lock for contention then you up the risk of that, it just
feels dangerous.

A userland program can however live with a 'if EAGAIN try again' situation.

An alternative approach to this might be to try to take the VMA lock, but
given the fraught situation with locking elsewhere I wonder if we should.

Also, you have to be realy unlucky with timing for this to happen, even in
the scenario you mention (where you'd have to be unlucky with alignment
too), unless you're _heavily_ page faulting in the range, either way a
userland loop checking EAGAIN doesn't seem unreasonable.

>
> > > > +               update_mmu_cache(walk->vma, addr, pte);
> > > > +       }
> > > > +
> > > > +       return 0;
> > > > +}
> > > > +
> > > > +static const struct mm_walk_ops guard_unpoison_walk_ops = {
> > > > +       .pte_entry              = guard_unpoison_pte_entry,
> > > > +       .walk_lock              = PGWALK_RDLOCK,
> > > > +};
> > >
> > > It is a _little_ weird that unpoisoning creates page tables when they
> > > don't already exist, which will also prevent creating THP entries on
> > > fault in such areas afterwards... but I guess it doesn't really matter
> > > given that poisoning has that effect, too, and you probably usually
> > > won't call MADV_GUARD_UNPOISON on an area that hasn't been poisoned
> > > before... so I guess this is not an actionable comment.
> >
> > It doesn't? There's no .install_pte so if an entries are non-present we
> > ignore.
>
> Ah, right, of course. Nevermind.
>
> > HOWEVER, we do split THP. I don't think there's any way around it unless we
> > extended the page walker to handle this more gracefully (pmd level being
> > able to hint that we shouldn't do that or something), but that's really out
> > of scope here.
>
> I think the `walk->action == ACTION_CONTINUE` check in
> walk_pmd_range() would let you do that, see wp_clean_pmd_entry() for
> an example. But yeah I guess that might just be unnecessary
> complexity.

Ah yeah... cool, actually think I will add that then, I hadn't noticed you
could update that _in a callback_, as I first thought it was something you
could set ahead of time then noticed the walker code resets it and... yeah
cool.

>
> > The idea is that a caller can lazily call MADV_GUARD_UNPOISON on a range
> > knowing things stay as they were, I guess we can add to the manpage a note
> > that this will split THP?
>
> Yeah, might make sense...

No need then :)

