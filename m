Return-Path: <linux-arch+bounces-13411-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD1CB499DA
	for <lists+linux-arch@lfdr.de>; Mon,  8 Sep 2025 21:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C65ED7AC31D
	for <lists+linux-arch@lfdr.de>; Mon,  8 Sep 2025 19:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC4727E04C;
	Mon,  8 Sep 2025 19:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="sC5hatoP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ysP+rb/f"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C971277807;
	Mon,  8 Sep 2025 19:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757359349; cv=fail; b=sTgbIomX+A6mE7Llo5qo6DtWB/bXY+IX7gbc1mRpY1veGuDL2EN9hMIQilkmcCEfQq7ZXPd2iE1lheaCKvpc+fhnwMRvWnEO7Fg5CQuuqBVfEHJ/trjohdzFIPPE3EOzxFdEdz9D11b0+TSm8omWDTryFNmMnu+xcOnKF/7b8Cw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757359349; c=relaxed/simple;
	bh=LhMgRSgHdmVTLJIGegW/Ny4Z9a0PUtshALx45VOBA90=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IZ5fyCoUjwxCSEUnhEVpSGZ5v2Vuq1asDXE4QsGmIHRlY/QgNnfZHb7qceceKHMGIKUaOC8NTIUSuwYva33Bax+/oyylpGmYsL6b4dlfiMlY8Wom19+OZ+h2t7v/sKW3FzLSTnEbzT5V3R7x/BcQWvG94NAnf9fH7t/ygSY53Xo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=sC5hatoP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ysP+rb/f; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 588Hg4MG007494;
	Mon, 8 Sep 2025 19:21:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=+c3a0V8lka9Afee1Nw7nJmCm0dx1rrGMyatPnpE9y+k=; b=
	sC5hatoPixIwnAB8UnxXLgLhN/R8BODVCSbybmlFGk0cbPSyyZ3KJvxTweRAHGtl
	mGQ9uVco2DgROsidXdvIX9LT2On0EtcBV0nQ05HSqQGBjgUbSMM8/4/tN90FFQ6D
	MBFWV07ykzJQR8Oq6n1/1JyBUK95nQLS6Ibu4pGmRl4QfY6nopVZo1S9JbnWNYZL
	9zDIB133U+6quvdgh18mp+hSAe7GCrAQKJFtpTOZXbV1i3PHPBHGhhlTP7R/KtTy
	0UBOuViKGx5QXZW3L4EMrXTDyNZbacVt0pNYB9vP/ebST6HIsl24tVrZdYnz9aZN
	Ei8QG69efRshHK83FcpZ/w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4922x909qf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Sep 2025 19:21:22 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 588HFsns031484;
	Mon, 8 Sep 2025 19:21:21 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 490bd8m3sg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Sep 2025 19:21:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=De6J9q8pa//8Nj40Hc2BQ25XUC3CdcXPzxwEbbX0RqPlTwKwIjvqqdWBYi/7qNq0SdDgUIJE1GYm06HuoyELegAMQtSSww0h2MitgyumSc3PUF295wmBq4Xji742Aka+loLttag0a/Y1bubawx0IIHMSK9gFmJPh2sF1VMN+Zz2o00cqXlu4KpCP3QSnf98foKAra7QlRBPpfxMVSCq5P90Nfejczg9nzRdkjt3K2NW/3cxoG8/Qrs/7gAyk7JN+Ii6AlhgxruiciZFgPN5EjUCCbzwWKQ5FIZ9HTmjb1MMW6N+vYaa773GQ8JIVyAPiPWw1xYcQZfXhZoDwDTPLMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+c3a0V8lka9Afee1Nw7nJmCm0dx1rrGMyatPnpE9y+k=;
 b=gDk53tcuKk0vKq6giLZwLZAQSTfwbbF3TVXWbvbG8A20JZaRiV53xztuASurr7aQd003p5bsAS/vvt6ZDe+t5mona836GlNuxNal21Tu00pNFHDJk5+TsfgI/2AjlytAiq+peE5wX/QC3ElS2y6PK5MjL1ZbECKE3u3DR2s4pYjVD/Pf2777TjB/TFvK485KDP5WyGHHN8bRbOnYOONI/+iZFk4lkhpPj83SozQXhmCzGouBYX36ImZj4k6N50abpZa2SiDId/ByBEA0LXaSvoq0uy08ebeF0HPjH5s05gvVZYkzBZ4J+Q2RVeJCN3mejIyr1jhCFY/YV5A4G+sg0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+c3a0V8lka9Afee1Nw7nJmCm0dx1rrGMyatPnpE9y+k=;
 b=ysP+rb/flTyqRev5Qqe0uxKX0wwFJSv2Ss1W9OC6ZZvFOnZB6hJIybKqFtWW2+PQpEEWFPagoFp/SJkm/zt+ZRmcGSB9fxA18DJsJBWsbDPeRmAUMigBNUVqA0QNAihPVSC09JuSjYZXXtfZC73sWy9N9mZpefYjiXPBhOE/Z58=
Received: from MW6PR10MB7660.namprd10.prod.outlook.com (2603:10b6:303:24b::12)
 by PH0PR10MB7006.namprd10.prod.outlook.com (2603:10b6:510:285::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 8 Sep
 2025 19:21:18 +0000
Received: from MW6PR10MB7660.namprd10.prod.outlook.com
 ([fe80::41fa:92d3:28b9:2a15]) by MW6PR10MB7660.namprd10.prod.outlook.com
 ([fe80::41fa:92d3:28b9:2a15%5]) with mapi id 15.20.9094.021; Mon, 8 Sep 2025
 19:21:17 +0000
Message-ID: <3752d094-e754-4453-b404-75d92de3e364@oracle.com>
Date: Mon, 8 Sep 2025 12:21:11 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 22/22] mm/mshare: charge fault handling allocations to
 the mshare owner
To: David Hildenbrand <david@redhat.com>, linux-mm@kvack.org
Cc: akpm@linux-foundation.org, andreyknvl@gmail.com, arnd@arndb.de,
        bp@alien8.de, brauner@kernel.org, bsegall@google.com, corbet@lwn.net,
        dave.hansen@linux.intel.com, dietmar.eggemann@arm.com,
        ebiederm@xmission.com, hpa@zytor.com, jakub.wartak@mailbox.org,
        jannh@google.com, juri.lelli@redhat.com, khalid@kernel.org,
        liam.howlett@oracle.com, linyongting@bytedance.com,
        lorenzo.stoakes@oracle.com, luto@kernel.org, markhemm@googlemail.com,
        maz@kernel.org, mhiramat@kernel.org, mgorman@suse.de, mhocko@suse.com,
        mingo@redhat.com, muchun.song@linux.dev, neilb@suse.de,
        osalvador@suse.de, pcc@google.com, peterz@infradead.org,
        pfalcato@suse.de, rostedt@goodmis.org, rppt@kernel.org,
        shakeel.butt@linux.dev, surenb@google.com, tglx@linutronix.de,
        vasily.averin@linux.dev, vbabka@suse.cz, vincent.guittot@linaro.org,
        viro@zeniv.linux.org.uk, vschneid@redhat.com, willy@infradead.org,
        x86@kernel.org, xhao@linux.alibaba.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
References: <20250820010415.699353-1-anthony.yznaga@oracle.com>
 <20250820010415.699353-23-anthony.yznaga@oracle.com>
 <a0238ff1-3ca2-4f0b-8452-26584b531724@redhat.com>
Content-Language: en-US
From: Anthony Yznaga <anthony.yznaga@oracle.com>
In-Reply-To: <a0238ff1-3ca2-4f0b-8452-26584b531724@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8PR07CA0033.namprd07.prod.outlook.com
 (2603:10b6:510:2cf::20) To MW6PR10MB7660.namprd10.prod.outlook.com
 (2603:10b6:303:24b::12)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7660:EE_|PH0PR10MB7006:EE_
X-MS-Office365-Filtering-Correlation-Id: 1848be74-9ed4-467e-35b8-08ddef0ce245
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UDBDaWJxZnhvRkJhc1JTYi9hK0xxOWJTcjBxSTcyK2tlTCtmc0ozSXViN1VU?=
 =?utf-8?B?R0lqSDFvK1lYUXdJWXNhMHNWVXNDU0U3bW5mR0NHVjFlcGoyN09JSi8zQWRv?=
 =?utf-8?B?ZkQ1cHlqejhkQzlxeGFzYyt5b0ppcmp6ZUVkeU1Wbmhzdi9mWnhMbU15UnVX?=
 =?utf-8?B?VU9EQTVCeGQwME1mcDJkeERLS2E4c0tzQjNBYW85QjIyWFVzRCtWSGhZWURY?=
 =?utf-8?B?ajlVSTlsUlUzRVJPT0ROMWJ1L2E0RWsrM2NTTERiVGd4M1JBUFdEdUR6b29P?=
 =?utf-8?B?Y3JOZldFTW5KNVZSMG9CeEJPM2RJRlFnMElZa2dkQ0kxQjRlL3lkYlVQT1lW?=
 =?utf-8?B?NmM4Z0IwOTRHWTZIZG84QmtlNGRWMjNveWxmYmJXbEhPZWdiMUwzNDJTcHk5?=
 =?utf-8?B?SW8wb29Xa25MdVQrZTRqRUVsTDJVQzhuMkYxOEJIa25zSTJHdnlGTXF3SC9m?=
 =?utf-8?B?TjBHYlFsNG52MTMycGp5ZDJXK2V6ZWk1QVlwT2VEZUsvY0VtL003K1lvVGll?=
 =?utf-8?B?VFlITnRsNjBpRnFKQ1VxYzFHUkY5MWltQzBScFdwOHU5UnFKVmlWQW1DcUFJ?=
 =?utf-8?B?dktFSFRTRzBxZVVIUkhSWmNiK21VSTVCK2lFTjJaemR1NHFleUFteDlXOVFz?=
 =?utf-8?B?OWEyVFBGN0N1RTQzVmhIZ29qZTQ3YkswbVROWE5iMytNYk5jZU1DdUd4T1Va?=
 =?utf-8?B?SzdtcUE3MHlOUC9XaUYrd0xuMTF0c1JQb2s1dms0SFdFUCttWDZzTHVHR3JI?=
 =?utf-8?B?VnVBUHNyaDJrTU5sT3M5M2owbFlWcTlKSGYxZHVEN3FtaG5nVFQ3azMxNU5w?=
 =?utf-8?B?Q3NuZytraGJtMDdsa0hVN3dVNlpXS0UxYVV3a2tuZ3JkSU9XR0F4aGFmVEt2?=
 =?utf-8?B?VnA2bitQT25obUlXZ2JIL0FqMXptWmNNeFNEWmExRFBaTytVN3NGdzQ5SUlt?=
 =?utf-8?B?STZmSXh1NnBJY0JKd2puNEVzc1MrQW5GeUtRb2N1blo0REpIb3ZvN3FJUGlE?=
 =?utf-8?B?SDdxUi9IWG5TUGF2RjNPYzBNQ01RdUhxQ1hMMDVaV09DUWo2ZGJ2aGgxNzhl?=
 =?utf-8?B?M3pFb3lJNC9CUjJ3VnJVYXVjVTFzMkZ6NFhQYlpqK3NpMGN2b0FuNmltYUVt?=
 =?utf-8?B?cGRnNkJQTUQyakRjOXJOZmZ4QTBjRUx6SThQRm5PZXFxa0t1MTZ4RmRsbUI2?=
 =?utf-8?B?MkFIRlhkVjF2TUZJM2pMRVQxa3Z3MWhSVzBBTFVEeFhCQzIyYWZnSERUQlpr?=
 =?utf-8?B?bHd6citSMWExS0dBV1c0cmpDemlBeVJpdTIwVVF6RDJIbHd4b0pUd3h6MktZ?=
 =?utf-8?B?K2hqaitva1docEh5Z3R4Mlg4R2VhNnJBc2NUNVI4aTRvSi91bkNtRGlQbURM?=
 =?utf-8?B?NXVLQjdMMG1pQzVTRkJTWm84UXlXek5ZY2JGUkFaenJja3NCTzlobG1xb0U0?=
 =?utf-8?B?N21qSEI3bXQwdVFEaXNVTmJTd0Jxb290QmJIS2o5UldUeXRIaXRMSkQzc0Mx?=
 =?utf-8?B?emNHUzh5V3lsTkxUeFUrbUtKM29aMXA5NkRDRWJWZi9vb0xRYk5mN1lOZHhp?=
 =?utf-8?B?b0hnVG9iajI1S2NDWGxGYm1acmk2clZnZlBIRlovcVBUQjFvTUo0Mk1qUkRH?=
 =?utf-8?B?S3FweU9zem1iUG16QjkrU2RRa0duc2pidGRLWmorc3NRd3BEMHdSY3E2SUxV?=
 =?utf-8?B?amhrM1dNN25pNSthdTdvaGZVdVpSRUxYUkgwK2Q0SkQ2MytTaE5ZS0hydFlH?=
 =?utf-8?B?V0lxVTFFMkJEdXA1dzBYSGFIZ1RNbFluem55Q2o3S0FWN25uQlNQQTdydmZU?=
 =?utf-8?B?T25lN0o2WWM5RlIwT1ljdTBFOVlRZjBwZ2ZJYVpJV0plRHVjZXhvQVlHYmZ4?=
 =?utf-8?B?SUwyaDB0cng5cE9DaXlNekpSSjJtdXh0K3lPMnVnRFBoVGc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7660.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b0VPQXhWRHg0ZFFhclJBNHFtajJmMDN0aXFoQ3pYejB0WDgzWmptWkErOUIv?=
 =?utf-8?B?SmdNS09aME9CTUZsL2FUK0ttaTZVWUFzQkVaQUZDOEkrV2NKbFA0dXp5c3o1?=
 =?utf-8?B?MkNBZ3JpcGtSM0lUeTRLaGlnKzdaNnVFNXZERTgvSnh0RmVnMHNiTDIrZFJP?=
 =?utf-8?B?TXExTFd3T3ZmOUJOMVI5L1JhSG9TSU9tRS95bE5PblptVmdycG9tRU05OGRM?=
 =?utf-8?B?ZzltUVZ1c2xybnZEQlN3Tkw5ZDg3N3dvdXdET3E1WU44aHBBNmRNQ0tpUzEx?=
 =?utf-8?B?QlpQVGJ4T0d6VVJBU3I5SUpGanZJcjc1UUlYTVdPN1NxK081RmdXTUQ4Y1JO?=
 =?utf-8?B?UFlsQ3FSU1Z0UHdNT01SclQ1MDNmYmNMWFhnSCt3d24yLzRJRGgzc1lyVGww?=
 =?utf-8?B?aW51V3NDT3Zpb2MvZytkWjBCWFJ4eWtYaDNnM1p4S3RFZ21UeEJ6bjc3LzFX?=
 =?utf-8?B?dzZLSDVkQUgzUTdnalIyaEFHeFVPd0JEN2g1d0UyVGNTRXY4WlZjQzhKVE9h?=
 =?utf-8?B?Y1EzNUdYcmFXNlBqeHlZVm9PUGQ5QzVnMFlVWStxSWtMb2xTa1crWFdCTStw?=
 =?utf-8?B?OW4wL3dIVmhkVVY2b2pkWkE5NXVjQlhPSUZhMzhJazdxcERRZ29SenQxOVRK?=
 =?utf-8?B?NlpUY1NSOXJJSmZvQzI5TTFMc3oyUThsVElTUlVGZnVMSkIybDUrN3QydG53?=
 =?utf-8?B?VndXNHRYRnY0NTBrMXlHeExPYU9QUmJ3OE5wUk5Jb2Z4YVF3ZEhJQ0dacXdm?=
 =?utf-8?B?VVUxZVJ2OG5sa3ZpZmU5UXU2Wmd6Ylp1UjlmVWNhSkduamU1OEJIS3I1dEJo?=
 =?utf-8?B?SWVwbFRPd3V6eFRtZmN2Qm1yU2liNTZ3cWswRzYzQmtVOTZ1RXZuUkJINW1t?=
 =?utf-8?B?dkRaWlkvcXVkODhkSTBscDc5V28zM0pCbG5zVTNyU3RmamhmZlB5TUVtakJh?=
 =?utf-8?B?MngxT05SQTlKTFpyeE1EWWVwT1A5K3BpUGFXZ3lpNnZTNENmeElLZEp5aDNU?=
 =?utf-8?B?MUtkSG1ySHpLT0xTMHYyU0ZsL0Zwc3U5VXlCcG45dytGaHNaSlFZQk4yQ0pD?=
 =?utf-8?B?U0hLZkgzNXVxT2dHT0JBNjdJUEpjWXJEb21hbDcvRXgvREs5ZVhqMGlTV2Ft?=
 =?utf-8?B?bDJDOTdZdm9xaVlhMVptdkNIWkdyZlhYbnFFcVNkRDlWd3pDZ3IzeEdUaHVa?=
 =?utf-8?B?ZHYxVXVneVdOZnZBc0ZhTDVJeDI4WWZxRytBZXljQlVFa0pmTUI1R3RnaXFj?=
 =?utf-8?B?MTNIeVFscWRZdElIMXI4MElmU0tyc3RBaHlqZ2MzWkZXTTRUays1U2R3OElq?=
 =?utf-8?B?dG82NjNDMHBaQUxwNlMxVWtrZlFEcGk4QTJ3aVhJcktlS0R0QTRNQk11ZlBR?=
 =?utf-8?B?bkxqeXZWUGZtc2kzVUw5ejY5UVUyMFFCK2pMWkRIWFVCdlptemJYalVqWm56?=
 =?utf-8?B?M2JPa0xkWEgrNXMwbHBnajdsZkpJZDdsVlI2SjVYMTc5bmd2VDBHdjBrVUJ3?=
 =?utf-8?B?M1VYY1RzekduYkhsdGh5N1lCTUd2eUZqYXZ3QjVzSk05OXZibHhvNEVTcXV1?=
 =?utf-8?B?TnNUdzN3UlRZc1FFSlVFRWVMQ2pXVEZwQjZTdmFYY1YwR0RwZjZGRDF6OGgz?=
 =?utf-8?B?dUhjRHAwTUhiSjhUUWZnTTlhUlNTM0VIS3hwcFl0cjRTd2VYNWZhaUMwamUy?=
 =?utf-8?B?WFpTdVQxZTMxdVBjT3lDZFJWeVFFUTNzOTBKMnBtNW9XRlRiWmVUVTVjMUxI?=
 =?utf-8?B?OVcwRUJpcDZ3SjFvUU55cjQ2dE9ud29EY0RoeHROV1l0R1MzdGI1ZFZMMzVN?=
 =?utf-8?B?dXg4VnpxWFhuRFB0bWtuVWRCQkxIWVFqSDZSbWVRUWlUbVJTZmR1OFNudFZZ?=
 =?utf-8?B?VW9xa2U2VjRMWlN1R2MvaWtqVGMyOWVSQ3NpTTNFYVFIZGowYlo5UXQxODFq?=
 =?utf-8?B?Rk1Dam94Z2JLcjRheWJRRExaRWs3SHJ5eS9kajR3TXJZYld1V1dZSlJRT3h6?=
 =?utf-8?B?a1Aya1FNUGk2Wjd6Z0o0NU1rSGUvME5ucDY4VSt5YzdrNndYWHNDSU9PdjVB?=
 =?utf-8?B?MllsODlZalhEcHJFeVh3T291VkpZRzZVM0prRk55MmJLcnVzMGQxazg3LzBj?=
 =?utf-8?B?TmNpc1pxcUQyVjVGQlJrUTV1TS92RzdXR1llemtVRkhzT3IrR1hxVnJHOElM?=
 =?utf-8?B?SkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IKCLa0RF4XyKKNhJ/zHnOb4e2SExCGLWtkMRRf11etT9IR2RC6o0vo2PxS/2Ax/IlYxVfJoNNX9qiBbGNSNNHDceKRDghhtQhWHmgC1J4CKEiFjedJ2AVhKjzzx68lcutIp+F/vI5jq/FWltiMwXDuUQNrd126ZalG7/j/GedeQ/diQIY3zRyXIdL3h81rG0Fn3WRVnm3M4s+4fxQPm/7GevaJKhoRj77/+DRmG7KYmTo/DYIxcuLtvGds4PURovlWVSNzgzs4GZ+fV3bs8uYJC0JMV1mQNdLsbdMMS+r7TT+mpcDoPodV8s7zDZACbYaFRlCsDOtJWH5xW9F7cNq/fZxBh/8rpqjdien9827RM5aB/W381SV7cOYF6sMXn3nUCaVfnT6gYxiztuybTjxyQmp12GXX8mn1c5IEBHx/NgV+RaNhTH41HGEQJpz9V/z57rAf2gDtlKiRg/OdFlqqx8vIR2o+lE1p5u2rL57NWi5qxJQY8wr6RPLgjXomBp8/Ke7wGoFO93OB/Gp2uXHRqk/oRp9s6ogkEFicKwFpQ3adzkCSlavfSH41yiFHZoZEsOEQ4XCjcbVzs8Ha1vgO+KmvxT5Sitoo9PKx6vFU8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1848be74-9ed4-467e-35b8-08ddef0ce245
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7660.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 19:21:17.6694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 15A8VJjveglQv/TWYOY+OvRA8g24zPDx6Wmi4APT2M535vj0lT8c0joFc9sZtB3fV0jVlCpQ9Gvue4BpsriUJBfWrrRufWQ+I1hkjWcCXxM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7006
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509080191
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE2NiBTYWx0ZWRfX2j4HS46EWcFs
 gB6tdpYLMq3e3MLBkrPjJ16i9j+AFLLF+0O6tK/3ZAWUkQ8dD0+fT4gRpHNLus4rIUvd47HCTcg
 NK2l2eKi8m4FTMHTmT2z8VZKvx+EIbe3kBmS77GUvua+5DVO7KRbcYIU9MQhadjRMFdwbJ+tMBW
 fvKCOufqUFKUz28/0vHFvz+j2O37seoD23Z0z/I07YM6Ymglrf9Qvsxa3F9cYd9be3Y/SPi/wgH
 JRCwQzo5uzUd41VU1aSoDJPXzbKSAAmq1UkMBqB3LQs/UmdwjRekd30sluFqHiXkevovK4GOt5e
 Jp/h/UVBnovlQSWNfKexywmausHGDpBXsojEEOanZ6Q+EWau9ximztEdA4eeHmx4f2w6Pml1pou
 wmbiX30D
X-Proofpoint-GUID: zb-CzWDmkudGcKj-_1bSh__ZxwfUODY_
X-Proofpoint-ORIG-GUID: zb-CzWDmkudGcKj-_1bSh__ZxwfUODY_
X-Authority-Analysis: v=2.4 cv=LYY86ifi c=1 sm=1 tr=0 ts=68bf2cb2 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=i-pEsNv00SWCavqrx0oA:9
 a=QEXdDO2ut3YA:10



On 9/8/25 11:50 AM, David Hildenbrand wrote:
> On 20.08.25 03:04, Anthony Yznaga wrote:
>> When handling a fault in an mshare range, redirect charges for page
>> tables and other allocations to the mshare owner rather than the
>> current task.
>>
> 
> That looks rather weird. I would have thought there would be an easy way 
> to query the mshare owner for a given mshare mapping, and if the current 
> MM corresponds to that owner you know that you are running in the owner 
> context.
> 
> Of course, we could have a helper like is_mshare_owner(mapping, current) 
> or sth like that.
> 

I'm not quite following you. Charges for newly faulted pages will be 
automatically directed to the mshare owner because the mshare mm will 
have its mm_owner field pointing to the owner. On the other hand, 
allocations for page table pages are handled differently. 
GFP_PGTABLE_USER causes the accounting to go through 
__memcg_kmem_charge_page() which will charge them to the memcg for the 
current task unless unless current->active_memcg is set to point to 
another memcg.


