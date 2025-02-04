Return-Path: <linux-arch+bounces-10005-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 878BBA2776C
	for <lists+linux-arch@lfdr.de>; Tue,  4 Feb 2025 17:42:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AE1D161913
	for <lists+linux-arch@lfdr.de>; Tue,  4 Feb 2025 16:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905DE2153FB;
	Tue,  4 Feb 2025 16:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AUkewRSS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HhdZCSPg"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6392B2153E4;
	Tue,  4 Feb 2025 16:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738687317; cv=fail; b=bep4ll/0UObznB4auPkikggefZ28/Ckrn6YCB7ltn/tWDU6z3P8tz4YehXb8+8t12EcAfdW3qp5eP1hpPp7Q5tLmHOcE9RgzQCztrheouZa/t0oNxcjUftVcQuIxmvoZmDochBPeaoBAyLG0KcBrGFmbNRbj3it5Z3POITUXRuA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738687317; c=relaxed/simple;
	bh=WFX4pALgMQ1XJLVFEoA+zCdoSOfVvjJ7gSa1qZGOhaU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mS/TLQKHdzcBtZ3ElSxAZDU6RWwaThqmnSR4jAX7dUn/kBfBXEcOZK+dVu1zTO/aOYGaLDIdhYqjIPZYieWYaxk5K4NByRUPcnhq3jahvZkjUdXsDHUuNJrKizMv7rOFAvtJjD944BMnVgXjacZvsTz9zkZs8X03gmhczur41xc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AUkewRSS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HhdZCSPg; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 514GMr1k031782;
	Tue, 4 Feb 2025 16:41:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=ayH7fZ9hcGZjZFxXDT6PfgL7GG8nYB4TGMHDu7tmZm4=; b=
	AUkewRSSeitVWwWhn9dqBPGG33iBkcBb6hiQWrMIR2f8tfT6lvJi5ddkdj82Ayq4
	EYT8i3+BrExmU804+niglyZ3g/Kf+Y32RTRluuW4I0/ZT+XP98UoUa3C4uLYX35C
	uXbjgR6XwiBL1MCc0dYYfu2ztw56+TjsgMicSI82j85YgMAcEQsFusTKOwL0Cjql
	gAd8TwO+b9P7j/DR1TY3M8M+R1mQ7MOpVq3csiXqWbLw61txt5Yd4mY/XCtmKAOo
	iAm2j0qloqoTE2wKs4nULbLhzWwLE/hyyIPwSPplllx75emHEBjYaJfuWfvowLYE
	UCFyOQ/v4fXllysU9ayx6g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44hhjtw7bw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Feb 2025 16:41:10 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 514FMdXS036296;
	Tue, 4 Feb 2025 16:41:09 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44j8fme4t0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Feb 2025 16:41:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TqGe8ixI5ItYD9aGkEHDeF0ACJk9Fw+8W+S3STyldCImKKXzVHjDsm5ccdDFoRV348ktxwTT8OHdTZ1TyJXgNPkxvINw6Sa0ZVnA78dwJTRxGenGlZ6Oj5DSSU/Qds9VQfSrKS9QM4E5z3GvvJoVXt7JDuq+FtuJEg3/6QMu7Hzf+bo/ESLrmIL0FvWTdTEWJN2nAHRec7CQAC+5IiIbqyLpF4cuZFqJPP8JSxvS1aBtHzzxAkyxbBs1ATYmtmJKD3pHuzSCGmshoNY9C6Soj+XHaQEUvQyVJItNbpYkQfHoMMuHW9I2pvEqyOZr9v/bO8lC0YWzGvclsnAJ+jurrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ayH7fZ9hcGZjZFxXDT6PfgL7GG8nYB4TGMHDu7tmZm4=;
 b=vTcM8yvoBejfpqC4tszBX/Bt8Z79VSKhau6F2r3gmm8X20tEsPGEe/WcjSeo5p5J+hlbW/O8dKcYHPhsGmUQAGKS+QSUbcX3eUpyfp1pUtTwQ+meU/qcbgCxFV4hTeiTT4r0D3QfAu4J+TWS33MvRxy7uGg+SsX8LzoG1B+E8zZtevFRedzyMD3tN1YdysJh9GbX5EJZllAKRKgftyo4aHeapnggILDY9c9lGO2AuUw5/Buo3fZrU/UaPzYmQ8mijnM+27T5AeBETiOmW0Lk4uDFCDwHYy4x63uuS94MQ+9pVg1vE+gFWXndv+qyCuFj2/dXwyflyWb76aH3lzK5pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ayH7fZ9hcGZjZFxXDT6PfgL7GG8nYB4TGMHDu7tmZm4=;
 b=HhdZCSPgzopIvJPngHS0iFElsNLGYgoJggRNbfJ1nAqkXLqIm6pz6Kr9UrXUQc31BbaV5J4hAtxjwk7t72BWyJKLHHk5muuy47HmVmShSd1AfgpJ18lFYZmr2vzdXy8qJhnSMC5fE16P/dxh4+m7mA88pSslolwcoLS4mv+uIgU=
Received: from MW6PR10MB7660.namprd10.prod.outlook.com (2603:10b6:303:24b::12)
 by BL3PR10MB6210.namprd10.prod.outlook.com (2603:10b6:208:3be::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.23; Tue, 4 Feb
 2025 16:41:06 +0000
Received: from MW6PR10MB7660.namprd10.prod.outlook.com
 ([fe80::41fa:92d3:28b9:2a15]) by MW6PR10MB7660.namprd10.prod.outlook.com
 ([fe80::41fa:92d3:28b9:2a15%4]) with mapi id 15.20.8422.009; Tue, 4 Feb 2025
 16:41:06 +0000
Message-ID: <0a68798d-0cfe-4b87-9348-6c0c9898f810@oracle.com>
Date: Tue, 4 Feb 2025 08:41:01 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/20] mm: Add msharefs filesystem
To: Bagas Sanjaya <bagasdotme@gmail.com>, akpm@linux-foundation.org,
        willy@infradead.org, markhemm@googlemail.com, viro@zeniv.linux.org.uk,
        david@redhat.com, khalid@kernel.org
Cc: jthoughton@google.com, corbet@lwn.net, dave.hansen@intel.com,
        kirill@shutemov.name, luto@kernel.org, brauner@kernel.org,
        arnd@arndb.de, ebiederm@xmission.com, catalin.marinas@arm.com,
        mingo@redhat.com, peterz@infradead.org, liam.howlett@oracle.com,
        lorenzo.stoakes@oracle.com, vbabka@suse.cz, jannh@google.com,
        hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
        shakeel.butt@linux.dev, muchun.song@linux.dev, tglx@linutronix.de,
        cgroups@vger.kernel.org, x86@kernel.org, linux-doc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mhiramat@kernel.org, rostedt@goodmis.org,
        vasily.averin@linux.dev, xhao@linux.alibaba.com, pcc@google.com,
        neilb@suse.de, maz@kernel.org
References: <20250124235454.84587-1-anthony.yznaga@oracle.com>
 <20250124235454.84587-2-anthony.yznaga@oracle.com>
 <Z6FyztBFs1Mwm2_K@archie.me>
Content-Language: en-US
From: Anthony Yznaga <anthony.yznaga@oracle.com>
In-Reply-To: <Z6FyztBFs1Mwm2_K@archie.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0037.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::12) To MW6PR10MB7660.namprd10.prod.outlook.com
 (2603:10b6:303:24b::12)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7660:EE_|BL3PR10MB6210:EE_
X-MS-Office365-Filtering-Correlation-Id: 69be7295-b314-4623-a0e0-08dd453ab898
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MVFCcks4Y21jN1FydGRjbkVrMVBSSE02V1cxbUxqUTFDc1Z0U1doYWk5VUJS?=
 =?utf-8?B?cjQ3V1d5dWI4eVRIeWFLWFU3c2hXVG8yTjFtek1rU1dLZlZmVTJ3SVhoZzNQ?=
 =?utf-8?B?dWY3NWxXV09lM2Y1dGhXam1pQkhNZUw4Q0RnYVB2clVHQmpzd1VrRDJ4ejlK?=
 =?utf-8?B?OVRmOXRodURHbTVlNXhubi9VOG1tOTlQZW9HTGthYUVqSFFpOGQwbzRmc252?=
 =?utf-8?B?TkRTZGlKMVkyR0hNKzh3TENqWlkwNThTQzZ3ajVnRjYxbzBtaTFadnYvKytj?=
 =?utf-8?B?MzFibmxPL0NzVVVZcitLNEVtVEFhOCtPanE1MWhJckZLYnBzdUNVQkI1RHNG?=
 =?utf-8?B?Z2hUdmJaUXZCNDRxZzczZzQ4bVNTRHJ5L1hoUkhWTE9CVzgvWmRiUk16R2p1?=
 =?utf-8?B?eTBFTkk2UDVrMEZ1bC9Gd3BaUzFOWVBCUEdlazdXc3FwQm55SWtNMFlHN25W?=
 =?utf-8?B?cGs1cndDNldjUGNuMklIYUdIckRiTzZaUDZObVkwbk40YVd6RkR2dWxKWHVr?=
 =?utf-8?B?Wml6YjlYWjVhbCt6K2MyK2ZKZG1ZVHU4YlhYMWVtRUFjTE9OaE13SFhlUi9M?=
 =?utf-8?B?Y2tZN3pvT1pqVHpTQUt6WHNCZWJOYkZpY3NQT3UyczlxWDZub2UwWFVuZ3RQ?=
 =?utf-8?B?TVBrQjFTZE1nMG9RNXNoQ0FzVGJtODZNRXFnamlXOWIvckpUdjlzZkNEUjBD?=
 =?utf-8?B?VWQxRTNhWVVkMThIeGQyaVk4ZEVhcDFLa3l5RTBHVTRRazllNWtsNy9zR28r?=
 =?utf-8?B?ZU1RNFEraE1KR000a3VGUktzQWd4UDZXZ2RSZDJ1MnhNNStOekxrN21FZUt5?=
 =?utf-8?B?bEVwY3VIWjdGVUpJQm9wRnIxVnNNN0c5a3NZd2pTUEREZldwU0dRZGxXVjMr?=
 =?utf-8?B?OW9LSStHU2xvOTY3S3RIYkZmWE5YT3kzNE1HSlQwWE4xeGhOSkk1V0JZODA0?=
 =?utf-8?B?THlCYkV2WVlqOGEyVDY3SFcxYWNCUU9jczgycDNERWpzaERkRk5DYm1qZHdR?=
 =?utf-8?B?UkFiVERWMUVBbmJhNUE2WTRRVXRRRGRNWDVhU0pIMkJxWVFlS0N2NDB2Ykpk?=
 =?utf-8?B?RmkwSmhEa1YvNTU5WkY4MXZuZ241RkpiNWQwT01GNUpGUWZMVnJEKy95ZVRk?=
 =?utf-8?B?dmdCdDRqYjEzb0Q5a2ovSkt0U1RMVTJHNlBKd0t0bVNZV2J3VmllN25FeE85?=
 =?utf-8?B?bHpaQ05FSWFHUGIzTUxQREZkYjBjUnFDWXk2bkxWbDZqWHp5NlBGOEFqUzFw?=
 =?utf-8?B?RkNoYmU5UmR1OGI5U0lrUFhNUkorcEJMK2lzZlpLaE9VeTM1ditReDNDWUVR?=
 =?utf-8?B?YXk0RGtnUjBacjBycEZvZzAvQVVKbFB3ZjYxanhMZ2ZTZjJoSHZhN2dOazJF?=
 =?utf-8?B?cFpHR0N4UjVNZVVxMy9ieG5TSC9GK011MUovVnF0QnlJWHJYWk1TNUhRNUFD?=
 =?utf-8?B?WTcwbnNkOGVYNFd1ME9qUHlRemNDV1RQYnlVT1ZHd0w5YXNxNzJEMEN2Z0hM?=
 =?utf-8?B?bjBPaUFXTHhidWFpb3VIcmtSVTRZMHpkSTBPbGlXejhvazFJbEtyaHBwRVdN?=
 =?utf-8?B?Y09uaTNndDFoaCtEUVcyWWExb01CekRMMnJkME8xaUlaM2RLYUYvZXdQM2Zt?=
 =?utf-8?B?eTRnRTZqc1gwT1ZpUUdJbkpUMVE4TzdMV2k3M0toVG5nMTczSStLL2RVOFQy?=
 =?utf-8?B?NndacktGdHNSU2paT0JOcXlTaUZCZ05uQThxaU03RW5rdytpTXdtenRvdDhz?=
 =?utf-8?B?cWl2UVMrUnJ2TkNSaFJyN2pBOVpHbGNySU5DVWordmEyNnJ1ekhRM3BhWWZj?=
 =?utf-8?B?NXJUZVFqcnRERERmbUNXMjMwTElMTDFJeDFlczdGeWZOUWV0Q2QvQjZYcy9z?=
 =?utf-8?Q?G/ZdGL+M2cQab?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7660.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WnYyRlMyNkg4Z2h2Z0xIWGVaYWE5UFVoUEdPeWlpMjgrS1pzODRCSlg3UXo3?=
 =?utf-8?B?bUxQanh4UFlQSjlqSVhQUEZkRnJqS2NkR0c4aERQZzVWamRWRmtqaEJCZEdj?=
 =?utf-8?B?elRaUzA2TVNiR2NJQ01UcTdISkF4NVl2VUxiK2VwTFNpVC9YaEJpVEV2ZWN5?=
 =?utf-8?B?L1RESzJSRVVSdW95SmZLYk1pc1NQS0c4M2ZMeU41em9mOEhTWjFxSzUwaU9M?=
 =?utf-8?B?YVZkSWVGK2djMzdIVVVKNWZFRlhPMGtWZDN6SHFkWWk2NklIRExLWWJqa3Vj?=
 =?utf-8?B?dTdEc0JQS2UxbWlRRmFlSHJ4eWNCUFNwY1gzTGRJOFd6eGRibEdmVnBUT1Nu?=
 =?utf-8?B?djUrcm5GTVdRMkxQQlArQjhQZlRFL0RaUVpZZkRhbUFjUnlkMmlPMGZUUk52?=
 =?utf-8?B?QU9QSlZKZGQ3OFppNkZNNzNDMnFMTEtQZTJUU1dpRWJ2clFlYVJxdHpiSk9h?=
 =?utf-8?B?bHk5c0lQOUgwTksxVHJHMFZqUjZXVkJpK3ZnUk01SWRTWkpNaytTTWlxb3gz?=
 =?utf-8?B?NEIydjJ3amVncVpQTFB2NkZmQStHMXV0US9nejFyd0p6MlBYam01Sk1IS0ZL?=
 =?utf-8?B?eUtLaDZVR1pJN1pRYWhtaU9ocUdUdjRHamZxUFU1ejRKejJ6bXhOK2h2V1RV?=
 =?utf-8?B?YlRjWnBYRlNYWUVPSjl4RnlMcDJjTW0rTzhUbjFFajgwTjJ2YmI2eFNtYmRJ?=
 =?utf-8?B?ancxWU9PcGJNL0ZwWUZpRk0ra0MwZDdXVTJQUUI3b2hrU1d3SzhKOHNlMjg5?=
 =?utf-8?B?RUxkcFJMamlHMUViSFFGOUswbE5kbjJxREh4YmRIUXpmSHU4RlFidEc4SzQ2?=
 =?utf-8?B?NUNlOVVWWmVZelBoNFREK3JzUWtuSXZERG91TFFmZzFNdXRJYVo5OS9UVnZs?=
 =?utf-8?B?N0h0dGFQVUpJSExtc1hHVVJJRndnYzFkbGVuaUVpcVJNeTg2Q29yeHVBYUxs?=
 =?utf-8?B?ZGhKQ2ZSa1N1eER3NUN0ci9JdWQ5Mi9jd3dwa0hUcjVxaTEvNzlaaFNhZHFm?=
 =?utf-8?B?eExtd05YWnloTjQ3a2JBOFJIWnB1MTBuYXptNHMwTnFiTTBhckJqY1lzY0ZQ?=
 =?utf-8?B?SFJkNnhyaFpaalQ0LzI2OGJ1aVlySVlYM2hrVUxEWXczMVZ3eW9LcThrR09G?=
 =?utf-8?B?d3ZUQVZJRWlrVkJHOVY3ZThDbEV0d21VMitWdE5hVGdjMTBaelNUVHNQZ1Yy?=
 =?utf-8?B?UXhJUHFyNWcvOS9tcWI5b28xWXpiL2ZybHFocW1yUEI5VS9ZcjZvd0dNdm9X?=
 =?utf-8?B?L2RLWVd3TkV3ZWxkNE9mWlZzWGhOYmZsRVJyeFlIcFM5OTlELzBTSUhDVSth?=
 =?utf-8?B?bEV0TVdwZEZBU0dEQkFUUTlJOEkrOGVIMlRtLzV2Nk5vVHIxc3VkOEFzOFUz?=
 =?utf-8?B?cWRyclZoMUJlcjRvYzR0ZnBOSjg1OUlldmxYZXJibS9GNFM3UncrTDdpODNJ?=
 =?utf-8?B?K1YxZUswVVl3a3k0TG5pUXlpME1IUlVOTHMyZVB4cVRUMVNaT0VjbW9TTEd6?=
 =?utf-8?B?bk9oakNvRTNnV1g5UHpubUNoSXBXK01EZkh1YnBSeVZROWdLc3lTbHNKcG9v?=
 =?utf-8?B?djBoREJaT0lNaFNES3dZT2ZBOTVVZmtsL1hua2ZqeXRONXdnbmJ0K2xWVzFX?=
 =?utf-8?B?a1QySStCb3FwVnRqeHRtc0svT3N6QldLd0NEY3duWngzL3BEMW00K0dKYjFB?=
 =?utf-8?B?L3hYcGZ1bFVRNVRxQ2FxMEE1ZFAyL3c2NndGcnNyM21oTGhiZkxTL2NDQ3Fy?=
 =?utf-8?B?ckdJK2VIMzZWNVNvZEJqQkJDRnFMeldIMWNZRTJlYXUwQU52K0R3NTIzdXNm?=
 =?utf-8?B?bEpTS1NSbkl2Q2xkWG4xcTVMSHVwR0VncjZ0VjVieHFvdmJnS3JaaGFRTUsv?=
 =?utf-8?B?TWFSdyt3aHk3dDQ1dkwybXlmaFl6Mm9vVGJqbmI4WEY2QVRMblVLdHRlVlQx?=
 =?utf-8?B?ZkZtY1gvcmQ0RU4rcWl2VDVCZTlqeVNiazNnb0Z0ZDR1emVva1ZOZVZUYmZh?=
 =?utf-8?B?L2hycEo2bWx1YWJIQWdDdnZUOE5KaFBlZjc3L0RocTBaTHNaYUN1NWFJeExH?=
 =?utf-8?B?TElFQmJSZ1g2MmY2eElYZ0JGbSswdkFuVnU0WW8rck5paGhmbDVON0VrSXF3?=
 =?utf-8?B?SXN3OGZzMWFNekdWMW1qRUhJaG5rWEhJV21ucG82Sm4zakJZOHluVWdQanNa?=
 =?utf-8?B?U0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	We89ggZ7mHQYwL7aB73vSEnsY/MZvULulUX/wxm5C9Xv0pK5+/I95FJuLHN/hjKd8hehHxaexe6+HVc9rO6l4Ze5DU7wZuywcnuOm6Ng60lvs8frgrMucKliSH+ZcXWYjuXWY7AXopxn3e2n1IFdoJ5Cs4lUmONGpAFDI2XrpS3cKo8tAsX3/WcIpJC8HnC+DdcF9UnC9ZKjMWEM6kzL7+sv0LbRKeWd+L8c2nVrYblKNualK2jfqatoztr/bEBqy76HHhENmLvuwiSXTJ0ZBVDvI3XXYfTM+73XJWl4feazbQ8RNo2qLmWtVyggOwD/YncqDRvHgeBOXb66cH2cR6xxfXdlIr9g2DsZTjWqVbv9sKn5MPIr/0sJNWlvdQAalE/eFQyXlmXIezzzlyYV3S+TIPO6Q6cPojwNGahJMzKT5Mf/kIU9HF7woXGz9Ll/EXHzzs1n7/uFdPhTe7ZlDmcYS9QAu7H6QNvd5ZgNFk59lL1TRkPlSo0vl23+QM0V4MhdoZkF8lj/hobN/TRfSYZ0qffUuDW4MXer1Lb6TSQVjTqGy+bDME5JdGcT5hMoplkPBV0xzktap+hl4rM8/eH47WPqtVNBSEH55PH/sBg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69be7295-b314-4623-a0e0-08dd453ab898
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7660.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 16:41:06.5915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vLeebEB5MeRC/aaNbGPjLlMk+9qRIwmuaAulSxfzUlNbIBap30Lx8c+4wsEFqnoWUAMV9EyMppWcS81IB95WWt9ZHutA2opTdRvaf/LxyUY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6210
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_08,2025-02-04_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502040128
X-Proofpoint-GUID: 5AYjy9v8IM2tAjmg0IR3bnfHb5Ivk9lh
X-Proofpoint-ORIG-GUID: 5AYjy9v8IM2tAjmg0IR3bnfHb5Ivk9lh


On 2/3/25 5:52 PM, Bagas Sanjaya wrote:
> On Fri, Jan 24, 2025 at 03:54:35PM -0800, Anthony Yznaga wrote:
>> diff --git a/Documentation/filesystems/msharefs.rst b/Documentation/filesystems/msharefs.rst
>> new file mode 100644
>> index 000000000000..c3c7168aa18f
>> --- /dev/null
>> +++ b/Documentation/filesystems/msharefs.rst
>> @@ -0,0 +1,107 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +
>> +=====================================================
>> +msharefs - a filesystem to support shared page tables
>> +=====================================================
>> +
>> +msharefs is a ram-based filesystem that allows multiple processes to
>> +share page table entries for shared pages. To enable support for
>> +msharefs the kernel must be compiled with CONFIG_MSHARE set.
>> +
>> +msharefs is typically mounted like this::
>> +
>> +	mount -t msharefs none /sys/fs/mshare
>> +
>> +A file created on msharefs creates a new shared region where all
>> +processes mapping that region will map it using shared page table
>> +entries. ioctls are used to initialize or retrieve the start address
>> +and size of a shared region and to map objects in the shared
>> +region. It is important to note that an msharefs file is a control
>> +file for the shared region and does not contain the contents
>> +of the region itself.
>> +
>> +Here are the basic steps for using mshare::
>> +
>> +1. Mount msharefs on /sys/fs/mshare::
>> +
>> +	mount -t msharefs msharefs /sys/fs/mshare
>> +
>> +2. mshare regions have alignment and size requirements. Start
>> +   address for the region must be aligned to an address boundary and
>> +   be a multiple of fixed size. This alignment and size requirement
>> +   can be obtained by reading the file ``/sys/fs/mshare/mshare_info``
>> +   which returns a number in text format. mshare regions must be
>> +   aligned to this boundary and be a multiple of this size.
>> +
>> +3. For the process creating an mshare region::
>> +
>> +a. Create a file on /sys/fs/mshare, for example:
> Should the creating mshare region sublist be nested list?
Can you expand on that? Do you mean create an mshare region as a 
directory and populate it with files representing the mappings that are 
created in the region?
>
>> +
>> +.. code-block:: c
>> +
>> +	fd = open("/sys/fs/mshare/shareme",
>> +			O_RDWR|O_CREAT|O_EXCL, 0600);
>> +
>> +b. Establish the starting address and size of the region:
>> +
>> +.. code-block:: c
>> +
>> +	struct mshare_info minfo;
>> +
>> +	minfo.start = TB(2);
>> +	minfo.size = BUFFER_SIZE;
>> +	ioctl(fd, MSHAREFS_SET_SIZE, &minfo);
>> +
>> +c. Map some memory in the region:
>> +
>> +.. code-block:: c
>> +
>> +	struct mshare_create mcreate;
>> +
>> +	mcreate.addr = TB(2);
>> +	mcreate.size = BUFFER_SIZE;
>> +	mcreate.offset = 0;
>> +	mcreate.prot = PROT_READ | PROT_WRITE;
>> +	mcreate.flags = MAP_ANONYMOUS | MAP_SHARED | MAP_FIXED;
>> +	mcreate.fd = -1;
>> +
>> +	ioctl(fd, MSHAREFS_CREATE_MAPPING, &mcreate);
>> +
>> +d. Map the mshare region into the process:
>> +
>> +.. code-block:: c
>> +
>> +	mmap((void *)TB(2), BUF_SIZE,
>> +		PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
>> +
>> +e. Write and read to mshared region normally.
>> +
>> +
>> +4. For processes attaching an mshare region::
>> +
>> +a. Open the file on msharefs, for example:
>> +
>> +.. code-block:: c
>> +
>> +	fd = open("/sys/fs/mshare/shareme", O_RDWR);
>> +
>> +b. Get information about mshare'd region from the file:
>> +
>> +.. code-block:: c
>> +
>> +	struct mshare_info minfo;
>> +
>> +	ioctl(fd, MSHAREFS_GET_SIZE, &minfo);
>> +
>> +c. Map the mshare'd region into the process:
>> +
>> +.. code-block:: c
>> +
>> +	mmap(minfo.start, minfo.size,
>> +		PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
>> +
>> +5. To delete the mshare region:
>> +
>> +.. code-block:: c
>> +
>> +		unlink("/sys/fs/mshare/shareme");
> Sphinx reports htmldocs warnings:
>
> Documentation/filesystems/msharefs.rst:25: WARNING: Literal block expected; none found. [docutils]
> Documentation/filesystems/msharefs.rst:38: WARNING: Literal block expected; none found. [docutils]
> Documentation/filesystems/msharefs.rst:82: WARNING: Literal block expected; none found. [docutils]

Thanks. Will fix this.


Anthony


>
> Thanks.
>

