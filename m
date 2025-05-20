Return-Path: <linux-arch+bounces-12026-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 552B7ABE07B
	for <lists+linux-arch@lfdr.de>; Tue, 20 May 2025 18:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1327B161CEA
	for <lists+linux-arch@lfdr.de>; Tue, 20 May 2025 16:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11506281508;
	Tue, 20 May 2025 16:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="T2/OTQ0U";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ASP5H0cM"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388402B9A9;
	Tue, 20 May 2025 16:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747757677; cv=fail; b=i2DDhqqjo/IJKq/0uc/BixuN8O8LG49F1f7+LfXyTOs4N6muCJXK8LVq49uUiQQNM9Nl+2jljRRMajbcVdwDrgO16WaB3L2fT2AaJhMjFWI55I5/AN7ICNc2/SoOw1F3lZ/MchdCsMtV6sc9jxThlrzINPbH7IjaYcf3+08HXlY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747757677; c=relaxed/simple;
	bh=Ti+ZBGBrBWHNYvHW/l67X1iqksKLqLY17NjapV4mkOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iR3xEOBCNQGDZ+D0c5RL6a0nD/taCQMPskC3kj4g4Mmq9zhpBB/IgyFMnmTBKnpgLqN3qwltiysRCCl1F71cwNIuOBGyGSQND7xscScjnbL0S2my6RmYUQ/vop/pDyfOvXZWn7wZfLSbYQGIV2kIJKGNfDuTdMITY46mU1s04I8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=T2/OTQ0U; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ASP5H0cM; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54KGDugF025754;
	Tue, 20 May 2025 16:14:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Ti+ZBGBrBWHNYvHW/l67X1iqksKLqLY17NjapV4mkOo=; b=
	T2/OTQ0UCxw/AbqmtXMuUhKKOYdvXk89Xs75k4NgnpVAZiZwnZSSx0TKcpFIrMaQ
	woAkvI9Jrzllo03WlNHYr3G2txeM1ie/di+jPqWezNWPZRhCyDKATSsIPbzIgZpE
	Jmou32HLw8uJRJDMDQl/QAI7BW7AuUQBE1UYoZ6NrbGENfNaQJ9D9I69cTvvxMil
	M/9rGxo69Yxo5ZtTFD64Pxi4k7XVPL9y836+7kIe/HzEqVjUN6Mu56DJTFoxDN69
	J8E/0vYA7zp8Yuj8VsRMhwfJbaGKJ8tOtKQ33F+NKS+dwrXX3fO8Rk63e1N2ge1V
	y3EFayd1v+fG+td5s/7Igw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46rv5tg4v9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 May 2025 16:14:21 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54KFTiDt037545;
	Tue, 20 May 2025 16:14:21 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46pgw909y3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 May 2025 16:14:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CgSjuGnByTrLL4qamvR2hWbNFCIZUzsm16VAzllL802eaSNzNplkHBbgRDQ4xxGIw6x9qvFgcQzshv+3ohdcXYBzvbIyEY7xMaKThHBk6hUoLGY/3Ek6ohfZ46VMiwlbv1qfevQZ3RAwZRIrZ8pL+SjAqFk27uH1s9dFEMh9HdA5jyPUpL1gra7WDz3PSry9E8bJS6ZB9k5CXImybEk13aIcl+Q+pYlxsT5kWaWOqihxhcDj9P6VuLL6TBQPwYrRMdwMwnO3qoAUuVyvYwVoYJjKE/WvoffITuj/kenFgQ538aVcQ2Gt7UtJd7ync7EZsawzHJgfB0JKw+gQR2sRlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ti+ZBGBrBWHNYvHW/l67X1iqksKLqLY17NjapV4mkOo=;
 b=yjovkbDgi66h9yf6T0b6jmh1jjg90O6uKIjU8ZWE0MVH68p2jG/RuAjeDS3pYyopt2EYaFKNsHI3VlkaBIPKWX59OxE0JK+EBtzqx7YkHJc6pVa+R5wgfd7q7sgJ5ngrM1DnU628t5lHenUAnQlCeB4tbmX9G6kB/nKhcflscsfs7qbpfz/MMhyI9KQyxiP7m/wnAcVTu09DevyObs/xdS3DFJX82lFREvCzOEYVilAe4thVeSBWPiS/PiYuZUBv95b2fDYXIV0qyULXTsKPrzHilI8maOwdyJP+aSVD9hVd4G1lkqWa5S3xbaREImIdx+QQH3EIY1zGB5ScbdvLmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ti+ZBGBrBWHNYvHW/l67X1iqksKLqLY17NjapV4mkOo=;
 b=ASP5H0cMFPxMbwQIxp8LNP+rGphDg+iWBkRaV+JYFIps1D3APRapWxnDn1gwhvNNeR4U1aBfiMNyPOTABOS6bCTSxDvOdcNTJ0VzZGf3lCWMHrfF72aojcIIzr0iiH5wbjtyyP6Yig6EEdzxm1Xf4FI8CiJdj8zWf1BLLESqwN4=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH0PR10MB4662.namprd10.prod.outlook.com (2603:10b6:510:38::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Tue, 20 May
 2025 16:14:18 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 16:14:18 +0000
Date: Tue, 20 May 2025 17:14:16 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jann Horn <jannh@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>,
        Arnd Bergmann <arnd@arndb.de>, Christian Brauner <brauner@kernel.org>,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>,
        Usama Arif <usamaarif642@gmail.com>
Subject: Re: [RFC PATCH 0/5] add process_madvise() flags to modify behaviour
Message-ID: <4c1e185b-1a23-4f25-92e4-1e11a1f67642@lucifer.local>
References: <cover.1747686021.git.lorenzo.stoakes@oracle.com>
 <CAG48ez3-7EnBVEjpdoW7z5K0hX41nLQN5Wb65Vg-1p8DdXRnjg@mail.gmail.com>
 <368b0ca0-605e-4d2b-b12e-c24b1734d1c2@lucifer.local>
 <CAG48ez0RKgQwpE07tZ8WcfH5XCeZ26wVOZa26HdYjADzVbHbgw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez0RKgQwpE07tZ8WcfH5XCeZ26wVOZa26HdYjADzVbHbgw@mail.gmail.com>
X-ClientProxiedBy: LO2P265CA0072.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::36) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH0PR10MB4662:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cfabdc7-d005-4edb-91cb-08dd97b95fa5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q0ZZM21nR0Z4c1VnZnFxMXVCLzQvSVAxOW1CckxrNjlVYkJ6cGJEMEQ3cmtJ?=
 =?utf-8?B?WVh1c0syTVAwSVNzaDNZWG5kWkZFNVVEVXluYzQ0L0d5OGJXTjhRWEE5YVpM?=
 =?utf-8?B?eTBuVVBwWitPQW9LN05QeEkxL0RrNVgwWUZGUW93VWVyOFV6Y3gySE1nQ0Ni?=
 =?utf-8?B?bnZ0OFhWYXJqN3UzLzFrUStzajE3KzN4YVp1ekZBNitvVVAycTEvK29TMU0v?=
 =?utf-8?B?SlZWc3dFU1QxUFpXVnpkQTF1S1h1ZGxqUHFIWVY5cS9KZTltcTAwMDlIU0Nz?=
 =?utf-8?B?ZkdwaGEzQlZtVUd4WHBsS1BGRTMySVp3TDJtZzlGaC9aMERMNHRrUkxVWks3?=
 =?utf-8?B?Tnh2djhvNUdRQ2RMRkFGa1Q2RGJ0UCtYU1F4Sm1MYko1ZE1mek9RSzhSV3Ez?=
 =?utf-8?B?a3R0dzhJMFJMSTJaSjNnMnFySUorUktwSjVGU2RIbFpabkxHZ05PV2NnbFNU?=
 =?utf-8?B?bmh5eWJFNW1qRDFXWEZ4cS9TQmYwbHdTSzFjeVVSYS84Z2Y1aFNDalVVeTdZ?=
 =?utf-8?B?blQxeU1yNlVsdWJRWHRWQ0JUck9PUnNCUGRYUEZUZTFVYVpkeG9FNGVXcEZS?=
 =?utf-8?B?UGRLYVdYNDlMWUY3Q3hoSDNMZzhINTI1RFhKOWRJd3p0OTlkaklYd09IVE1t?=
 =?utf-8?B?cjdMS3NoMENLNE42N1ljSFdOZDNudVlsR3B3OG9UMnJjM0t5VVlvM2prdXlN?=
 =?utf-8?B?UmZYcjJrdE5lV0lLaWlRQ0t2c0YwVkNWMHV6QjUweVAvVlk0WTJLNHY0blBi?=
 =?utf-8?B?QnEvbU02RW5RSVFHZkt6c2VKY1E4YlRzSzBmdlVVcko0S3E0YzdrY3hoWXFC?=
 =?utf-8?B?YnhoQmNDQnJvU1VuV1dyUW80Sk56cy9lWDR3R1hLeUREcXZ5WVM1dVF6dlNO?=
 =?utf-8?B?bFV4TmxaRTNSYTZmQ2VYZ2hUdTgyaWFNNmRkUHJzMUFtME5nUjlETlo3RW5k?=
 =?utf-8?B?cGZoMjdpM0NnK2Mza1RxVU9BVVlYRnpacnFjNHZCUTJtM0xZYXl4bHNNemRt?=
 =?utf-8?B?WnUzb0JMM2dGUDlUUVpTb1VDWk0wMmkya0ltWDEwYkZzVS9pTXN6RUVScnhp?=
 =?utf-8?B?UUFZTzd6K05hR3Q4Q0VzVVM2cHJ1eDlWN010N292OE5zeUJic3Y5bkE0Q054?=
 =?utf-8?B?UC9ROXA5ekk4aDhDQUZCU0tyN2J0ZThUYXRocDJVT25tNWxjWFQ5RFc1R0hy?=
 =?utf-8?B?OXBEOGZGNnNrRXVCUlNvNWhsUUYvUktBbExwai9yUkV4Vk5hb25XTTBUeURJ?=
 =?utf-8?B?RWljcmg2dWdXbWQ2MFRBaVVGSjY5YVRnUWdZa2RhZEJoMEhHZWM1cGJ4SW5p?=
 =?utf-8?B?UjliMkVNQkJwQlhkT1k3WXNId2pFbk4zcEwyVFg3RXVpWmQ3NzZVNkJUREx5?=
 =?utf-8?B?Z2w4c3JVbUh0MERCMUNDa0hhMmVpbWZIaWpQZkFWa2w5QXJjSU93VnpnSVRo?=
 =?utf-8?B?NXRQM0hObTBjV1h3bit1QmFWWUVVR1VWdlQyWEQwSlZFeHNQNzZ5MldLK0sr?=
 =?utf-8?B?YmxzUGIwQVZGdURKWGRoL093UENVZThveWhpdUpzVFB5Uk1sbEwzT040R1lT?=
 =?utf-8?B?MEp2QUlxSDhZNk5jR3lXS3VwRTBFejlUVlNTRmU2UkNnR1gvYktoVVRPWXRP?=
 =?utf-8?B?QkRCT3l2dEFibzZCZmRoVkhndTFlcHptT0xncFRNWFdZeEpFbU0wa1duaFVo?=
 =?utf-8?B?WkFHNGI4OGJ1azdnUi94TmM3VTNTbTQvSDRPbkNBeThXT25ob0R1NlowdXJj?=
 =?utf-8?B?UEFIWHIwV1BOVXlKZDM3bHBjK3B5cm5HREtLbTBuWERZVkdMb2tFb2xzdDg2?=
 =?utf-8?B?ZzBTdlBGSlhxME1kamhTclhRcmZDZm9xSWJQWEVXcUdLWEV5LzRxZGg3QlZa?=
 =?utf-8?B?YzdvOFg2MlRTdHR4TjlvTUtIeCtiQXo2YjBYM0NKb1BvdGdlQXBidy94VVlR?=
 =?utf-8?Q?LjqS7FDH+XY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WHQrendqNjNmRnJ4b2RRWGM1Vk1GVWhvcmdHandsTkFoaXlHakJ3UUdYQkU5?=
 =?utf-8?B?K3FFWUpLZkU0Q1dpaUExR0xjUklFS1ArZU5WUHRmckFJS0lPYS9Wdkt3b0tp?=
 =?utf-8?B?T1FmMFlBMm54dkRGQUNTWEt4WDZSNVRmQlB2QUlmQ2IwMTRrcXBSUHRxVXNF?=
 =?utf-8?B?UlJ5QlFFTDN3ak14aE9JOXVNQXcwMHdLclhpdVBiUlhxaFZUVWpiL05wYUU2?=
 =?utf-8?B?bHR0alZicytjNDFtWVhSbG40bytkWTNPWFErb1gvS2s3RVFRc3JNWEpuT2Fo?=
 =?utf-8?B?UEdqOXlxWlp2UkdCcjFlVGZpcmNobmFRQmJ0U1NOUWxBNDI1cTdmMG00dmlw?=
 =?utf-8?B?ZnErQSt2eDRQMzRCbERuVjhjcVBvMXhqR1hRZDk0d3UrMnRNUnJYdDAwN1BZ?=
 =?utf-8?B?VTFITG1EVUlLeWxOcVRhc1BxQ2piV3ZZM3NyMDllWTFkVm1raDJZYmRzSDVq?=
 =?utf-8?B?Y1V3U1phNEsrZU16dkI1TDNMZ2JLQ0FOSjFWOW9MS2hCZVpUNHU2Y2xmYWJM?=
 =?utf-8?B?bHE1UFpqcXRwa1k2SzVRZEtkcHhxQXRKdmt5MGZHejJINXhzYWVtalJYU3hG?=
 =?utf-8?B?d2o3NGV6L21vTXMxOTR4Ry9WQXdlZ2JBRUg2YlN6TXJROTc1Y1RQRlF5aDRT?=
 =?utf-8?B?VE9CUEd0VVg1WjE5KzFsL1VkQ2lhYmxITzV4OTcxdTVMdUxTdDlIMjJwSVgz?=
 =?utf-8?B?ZDZrTU9paXk0cW1pOHppZHRXZ3lRWVo0MThwRVNvVDJaZFkrYjVLUUtySUtp?=
 =?utf-8?B?d1lYWFBrM0JNcnI5ZENTZHFUSjNTc09MOXMvWENDSnU3Wk56SjBzOWhTSWpX?=
 =?utf-8?B?SVdsaFV4TlRsL1AwU3N2SmZvRFVqVXJVdU1PeHB1TDEyUkpqS2pydVI0VEt3?=
 =?utf-8?B?YnFKbFlrZlIyZy92K2RIV0NucVdnYkhFZjZ0ZWhFcElxa2F2UWw1RVRyTTFq?=
 =?utf-8?B?K1l3aWViU0htYU1YWkxYandkTUh0djVWa0laMU1WaTVsa2w1Zks3Nm1zNENU?=
 =?utf-8?B?ZVlDTkJzUVBGZzZsMnhzcUt2M2I4eXB2dEI3dFVvRWVmblR2N2tLRC83Qzl3?=
 =?utf-8?B?dHRvcllUbXBmVGs1MTBDM3p1YUQzMEJUQTBjVmIxT0ViZlVYUGlzRnZQT3N4?=
 =?utf-8?B?VnBsT2VEREExR25tQk5sc1Jma1BhaVhqQ0Y3Mnp3NGJnNThBNnNuc3F2azNT?=
 =?utf-8?B?MWJwZEhKZ3k3WkxMaG9zTVlBNittTVREYmp6WmREeEdDNHFxUG5wY2hFZS80?=
 =?utf-8?B?RDBKVWVCbUI2SFpIb0l0Vk54NEc2akNlNHBmVkxRU2pBdFRwYVdPTW5IUzRO?=
 =?utf-8?B?RzZPMWtxcWMzOVVaSFFNVWRQT3pTYm5OQ0NKZ0Vjd1RQZHNEYzJtdDJlRmxN?=
 =?utf-8?B?QXJtRU1xQ3YwZUtHYitDaUxtMmxldC9vTksrQk11TTYzSnhubUp0cEFRN1ZK?=
 =?utf-8?B?bGExcTVTNTlnQ2JnRmZ0VXAzcTZuUzlnYmlJR1FPMzdFZUFwMVpTcUVnengx?=
 =?utf-8?B?STNQY1pLeXA3NSs4U2JVV3FFWDRBTUpWOTl2bXJ0NzJHRFpkMVdEdGdaM3hN?=
 =?utf-8?B?bHFZSVlRN0Q2c3lPTVI0KzZ1b2YyMUoyOGJQdi81VmFPck9oTWRxUkhTR2xW?=
 =?utf-8?B?SjhCNDJOYUU4RU5LcGFwbjlxdHF5QlcwVXVEODBXZnVlTXJYMmJleG1EM2FN?=
 =?utf-8?B?d0J4Y1ZldmtCdy9UeHNoVjNXTUFsdlAwdGRlQmw3aU8vYzRNcWVWbzRlQ2ts?=
 =?utf-8?B?RGNTeUFua1hYWUEvSytkc3lvVHEvd3JmWURNakY3OGdNdzZJNXNSaTBqMzEx?=
 =?utf-8?B?Z3dBb1c2bU12M1dXK0ZzZHIvSlEvbUdzelRMdGVDZE83WnZiZmxGMS9jY3V0?=
 =?utf-8?B?UW1BNWZjU2lQNnJGc0gwUDJhaHIvWHRqa0MrZm9ReEhQZWVwSjNvUUNaMDRM?=
 =?utf-8?B?REJhT010dWlZMEY2elF0eXUrWHYwcERKZFRyWWFONThtbjBDb3FXWmZRbEdn?=
 =?utf-8?B?K3FZZEdVczNjS2NjZnBVWHdjUHI5UzY3K1p0UVBFblBDeWpPVFUrcWxvcmF4?=
 =?utf-8?B?OVEwak8yc2dBU3BDYlZKcmd1TzUvbXNSTXRVZkZodThERFpBMDZ3ODhWT0ph?=
 =?utf-8?B?NjhYV0RBZ0gwRWIwSEpFeE5IMVdaanRndWVwNHM2MG5qcWUybGJqWTRLMi9B?=
 =?utf-8?B?b1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	a64zjWhnHdoX/tlcBPtkt5ytwGvrIAtocuLzAkPU8HBGn47v+IYkz+h2k3T8jiXN2uicGdgiFox/v1PVZA7ZpXATqoSecXwTvxuwMhFSA4H/BcsB/5/psyGJ30FwZ5KPkS8RhyOF9e6IrxfhUm2f85mEKB7ISynrPX37/xRTbBMXT2AbAHPl2nXGfEk10KWuJ8Sf2MrRDYto3/LAlWzeTNt+hJDkwDDC1YxW4GrVXWIQpOIg2C8H/cAu+6hxfMKLmIUs7zn1sfV2MPSyG+Bah8mdwUyPvjiM7GT1WBD+jbFj930ihEX1N06TfF5FByc7csIbycbhKKGAhyVaISJnp1mmqnYIJnakeUC+4XB5BUpsrinXVFXHoBSvXyz3MMQNCFYGqMoP95ql7wNDkyNzay+OKsTBRXJsH2zNIrTLiq4AfraxQYHvNPkODiBKurDRkyMUezMzMLI2AUpwzsC14vgd/b2m8dE/r63F3DQ+k5RoGZ5eiXXc/N4d0mxjj3ubHMzg80nxzAsWr9up4Ba8FLNu1LcImb3ZN8Qj5m5VQv6M1Mu03Sr5bea/3/C/VbzmbttJ6JQ/h5lvrRxMF/gieWhubt9SNoHTVD6fSsSL5Vg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cfabdc7-d005-4edb-91cb-08dd97b95fa5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 16:14:18.6756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hEIM2+94PBuO+EDTHcJ3L8aJtxKsx+qa5EE2GoHqnEXtiIlJQPKDz9S4MQKMMyQ1CFW9sihzsTTce/AM7qFTAOJfwr4RjZiK6JQBP4m9amM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4662
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_06,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=875 malwarescore=0
 mlxscore=0 adultscore=0 spamscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505070000 definitions=main-2505200133
X-Authority-Analysis: v=2.4 cv=EIEG00ZC c=1 sm=1 tr=0 ts=682caa5d b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=Hex65v_Prg4jIqumQqoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13189
X-Proofpoint-ORIG-GUID: t0XGt7NvK9SAEMo3PM9bV53X53ZKnFID
X-Proofpoint-GUID: t0XGt7NvK9SAEMo3PM9bV53X53ZKnFID
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDEzMyBTYWx0ZWRfX1Hphsao0cvnp KjUiUAbQkgEIPpe3WjI3OwSL5UXhzdvZVmYODKKypWw2YZF9/OdAsMv5bEA5Pv24AnJ81/FcB1B 6LdZBPt3q4YHdSXkOZr14nfiUosEzD1rxWRb7HQFr90ztm0jT7rjldSP81CY2ceEB/c0e3a3/ER
 5ImYKiqicBHbC2H2b3cOj7a5jkjQwxS0j43Jj9fRu63akamLrMxz54G0S10/a8ARx+tbUJSATAq zmlH4K/RyrwJvr66HJQ2hqqzOtfBqhnqYcAy/v+0GrzUIYUR6wRQ9C9y+6R0QqhlMbFGaVu50L9 vR3sbc7crTW+ZoFQ20L4pbRDwaZoyjh8oF6lSgSCk/pdaKOfNDbFPtgS112oa2/wXIHNxtPUP06
 pDtu3riVUyrASMKssTtLxw56UoBEuGzkM02mYKd9hMew+cSuuh3bqqPjg4m7DMZnZF1RGqCI

On Tue, May 20, 2025 at 06:04:47PM +0200, Jann Horn wrote:
> On Tue, May 20, 2025 at 7:36 AM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> > On Mon, May 19, 2025 at 11:53:43PM +0200, Jann Horn wrote:
> > > For comparison, personality flags are explicitly supposed to persist
> > > across execve, but they can be dangerous (stuff like READ_IMPLIES_EXEC
> > > and ADDR_NO_RANDOMIZE), so we have PER_CLEAR_ON_SETID which gets
> > > cleared only if the execution is privileged. (Annoyingly, the
> > > PER_CLEAR_ON_SETID handling is currently implemented separately for
> > > each type of privileged execution we can have
> > > [setuid/setgid/fscaps/selinux transition/apparmor transition/smack
> > > transition], but I guess you could probably gate it on
> > > bprm->secureexec instead...).
> > >
> > > It would be nice if you could either make this a property of the
> > > mm_struct that does not persist across exec, or if that would break
> > > your intended usecase, alternatively wipe it on privileged execution.
> >
> > The use case specifically requires persistence, unfortunately (we are still
> > determining whether this makes sense however - it is by no means a 'done
> > deal' that we're accepting this as a thing).
> >
> > I suppose wiping on privileged execution could be achieved by storing a
> > mask of these permitted flags and clearing that mask in mm->def_flags at
> > this point?
>
> Oh, I see, we're already inheriting VM_NOHUGEPAGE on execve through
> mm->def_flags, with the bitmask VM_INIT_DEF_MASK controlling what is
> inheritable? Hmmmm... I guess turning hugepages _off_ should be
> fine...
>
> Yeah I guess I'd do this by adding another bitmask
> VM_INIT_DEF_MASK_SECUREEXEC or something like that, and then applying
> that bitmask on setuid execution.

I guess we could do it this way, as it would only otherwise limit a non-sys
admin user, and we should try to keep things as flexible as possible.

Let me do this for v2 and see how it works.

As it seems there's some general traction here I can also write some
tests...

