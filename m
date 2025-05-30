Return-Path: <linux-arch+bounces-12159-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7797AC93C9
	for <lists+linux-arch@lfdr.de>; Fri, 30 May 2025 18:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7A34176646
	for <lists+linux-arch@lfdr.de>; Fri, 30 May 2025 16:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A09B1CD1E4;
	Fri, 30 May 2025 16:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ABFO6br9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KuGAASrj"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D471D63D3;
	Fri, 30 May 2025 16:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748623365; cv=fail; b=DGBNHgM6M1YMcSLk3e7lwta4BSKh3cF5v8FW4752N+rWcylz08NdhJFMvzYhsOcOjtvqmwoa0S2QgaHl9FlmaxPqFrSxSIKoyFXZ7zrSU24OjRNZBwIRGYL/7We4AgGTl1j4vzMj0yIo2wiP8E+c28IXKXxejOGJvZ+T+k3Md+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748623365; c=relaxed/simple;
	bh=k8vU/trUkBs5/8diAsG153Q9wtIKaW0nXzmLVrs74sk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ghsm88cX+qUtBSxQ3WZIH30gPlnCc8VQ6WI49iMfa5cYDvwNUhaA1LHTNlmFRbTugbhqm/U4cb2kTfTPj5QKEd4z//Ox1g5sMwTDwiyM7m2zqTd8yGMjdiH+qJypFcggh8naonrrB3naNnkxRXB1CreIek7LDX/Iw7DGuWZ2ALU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ABFO6br9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KuGAASrj; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54UGfpVx001834;
	Fri, 30 May 2025 16:41:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=GiMTIK3CH5NIrzChu3CREWNk62SRg+XBSebeMDaLOD8=; b=
	ABFO6br9RHTXFkBPi439pUtu0SnCgGzDAc4BopVSVFXyvmd1hzgXOZsR52VsuZvO
	qt09Xi3y0/vFrmnr6NxjrUtERf8UpKGBYoN4ZxHiKDQO8wdjmTcGkX6X1IV6aU/c
	u4/04lhgdBo+YazIigVxRTypb9NxefH/sillnw+PddpB9zd8jiOMnalxJWVMHVcK
	XGi6+MOs0uGCdYs/ZSpl9oNwYi89Amz5/bbsEcG9GjDdmfsSHfsDZ8Dx/vjbJHAG
	h+76ZSH7PHjwGwp4kRyVckGRi0zJjfItWIPNpSIUFatCA8HuKr8fuXb5MlOlsItQ
	IlbGm7rFp1lo2w6VWaF+Xw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v3pdad39-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 May 2025 16:41:58 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54UGO7TR023104;
	Fri, 30 May 2025 16:41:57 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04on2042.outbound.protection.outlook.com [40.107.100.42])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46u4jd83e0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 May 2025 16:41:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gwPrl9CLMg/lh7RYKHcW8JzRz9mg35XqQQcAbVdTWOX9L9F36pDC0aBOrP+wPVZBwestcbFqpWKFUHX1FYh+WEpUh91qeTev+rC7kVEIffwI4jesZcj4ekZW/i80J64CDQJVLHfw3rP7C/+x0eatb4kLhC1WknBTZxOFnC0ETzshKRYK2G28OPfUCh1txWEF+3ALp7Ab7OxSQ8tTv6rtvrE20tLSvkDfoGvPGSXjeHdKES2lb6/mbgqKPVL9DBMYzDoMjYoVmD45DKYb8Wxp3WyPIa+aswGzbMCyfT4kzYK2lk2dTgWs1QypPym50AV4f0/v/Fu1KGnY2/QMpfKNTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GiMTIK3CH5NIrzChu3CREWNk62SRg+XBSebeMDaLOD8=;
 b=mso70P1LbCKjmkPrUsYNMI6BiCrLBGkOwp7Qf5kdoF7d/kVNoYrnAQFlpfuSyYiUgthjgxlcjtGUHEg5B6o+8lPgOXGFr9zN8ScpczJrJeWcUFR/qAzubrpR7ny/W1mt9JWC7toLs/5QdzxZq4hAxmOFAluC0DVmdS+FUPLjDv4cMGaHbt/MfLwUESsFrH12/oRZfJ7zHmuWNWpY4I8FGki+3E/eeYvAJMkGDjQiLdyRqQ6pl37TJ9XDMmerWOArgkvjS5xczyewM4jryGIEVxFqPpK4e+l94Es+2hD8Gt3Yj3Bzs1Dtsa/M0lQUSWADQoKvnE65WGt4xpGE63fdOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GiMTIK3CH5NIrzChu3CREWNk62SRg+XBSebeMDaLOD8=;
 b=KuGAASrjCOVqa02mTzn7TUqhxCR1bPWBv899iW4a415PJqHmTCWxis4CKxmlD25G36ixcLPhM2OW5U6jKuS8j+FdTOrwPiXQXvwHgpZD7jEMhIlSquyngXAn5wXjg2TkNWzCOIqJVGt/nNW4NfJzzG5UmGWPA1DMqUDMPDic5NA=
Received: from MW6PR10MB7660.namprd10.prod.outlook.com (2603:10b6:303:24b::12)
 by SA2PR10MB4539.namprd10.prod.outlook.com (2603:10b6:806:117::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.40; Fri, 30 May
 2025 16:41:54 +0000
Received: from MW6PR10MB7660.namprd10.prod.outlook.com
 ([fe80::41fa:92d3:28b9:2a15]) by MW6PR10MB7660.namprd10.prod.outlook.com
 ([fe80::41fa:92d3:28b9:2a15%4]) with mapi id 15.20.8746.030; Fri, 30 May 2025
 16:41:54 +0000
Message-ID: <7fb16136-947b-4a72-8134-60d95ba38c1a@oracle.com>
Date: Fri, 30 May 2025 09:41:39 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/20] mm/mshare: prepare for page table sharing
 support
To: Jann Horn <jannh@google.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, markhemm@googlemail.com,
        viro@zeniv.linux.org.uk, david@redhat.com, khalid@kernel.org,
        andreyknvl@gmail.com, dave.hansen@intel.com, luto@kernel.org,
        brauner@kernel.org, arnd@arndb.de, ebiederm@xmission.com,
        catalin.marinas@arm.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhiramat@kernel.org,
        rostedt@goodmis.org, vasily.averin@linux.dev, xhao@linux.alibaba.com,
        pcc@google.com, neilb@suse.de, maz@kernel.org,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
References: <20250404021902.48863-1-anthony.yznaga@oracle.com>
 <20250404021902.48863-13-anthony.yznaga@oracle.com>
 <CAG48ez0gzjbumcECmE39dxsF9TTtR0ED3L7WdKdW4RupZDRyWA@mail.gmail.com>
Content-Language: en-US
From: Anthony Yznaga <anthony.yznaga@oracle.com>
In-Reply-To: <CAG48ez0gzjbumcECmE39dxsF9TTtR0ED3L7WdKdW4RupZDRyWA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0244.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a7::15) To MW6PR10MB7660.namprd10.prod.outlook.com
 (2603:10b6:303:24b::12)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7660:EE_|SA2PR10MB4539:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b8e809a-73e6-479f-6509-08dd9f98e259
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QS9zNWZ3SUlaYnV2U05zMHkxVUJmWkI2eXJObTUwVlljK3FrVkpDYTluRTVU?=
 =?utf-8?B?Ulhpd0FoREp0Tmt1WVEwbFZSUWZQNXliMVlONnFoUXJOY2NIMnNDQy9qSC8x?=
 =?utf-8?B?MkRITFBYMzJRYWEwK1VXT0VsMlBFbVh6R2tyeGVsNWo4M2hhQnlQbWRCYmk2?=
 =?utf-8?B?cXBMYTd0SUhhN0l1cm90RWtIdGFvWEtxWkpldFdiZWZPbUl3VWlveGRETng3?=
 =?utf-8?B?SXMxdTJWdklEcUZ4Y0J6UGtjM2o5M0RaODUwNTVyc1BhTEYycDVOeEJuS1NS?=
 =?utf-8?B?c1RhVjRVcUgwRnovZ1Y0UXZUUVhrSzE0MURXaFg5SkFKZEJ2Y2kwcHk3a3do?=
 =?utf-8?B?ZUZzTHBqZ3ZZYTFXeEpqdHF1cnRSek5wbWZWcFk1SFdvTk5iQlRvSUlwQTdm?=
 =?utf-8?B?d3ZaWUZ3bkZqVHIzRmY1dTdkaUhOZER4dnFNVUhLOWhLT00vcDBmQkYrSWoz?=
 =?utf-8?B?dUxkNlVMU3cweXZrejdkcm5xb01sWTMwbUloSlc2YlRSbGZvYXlQSW1JZllU?=
 =?utf-8?B?emRkdmJoZ3VBalBlVi9tVG5pdDNDdm8zSkR0QldMbFdjZjZxazh6TCtFb3BU?=
 =?utf-8?B?YXo5bDF2K2dxb0pFLzlBZzVYUUZWOExjYi80elB4ODJNenltQk03eXhTM1Bu?=
 =?utf-8?B?aUowTmNabTBLSVg1VXdTcjlQUGw0dDlDWGFzcG9mTzFjQkxTWG5uUHoyZyty?=
 =?utf-8?B?SzJ0UllvcjFkeEhZMUlGOTlISHFwNWNPV1MzcTdCTStxN0d5emk4a3Jldkl0?=
 =?utf-8?B?R0pQaUUvUlJZTTBPM0hTNmNkZ0g4VXVuRnRIWG9XNGU1Zk43YlVocUs5T25v?=
 =?utf-8?B?UDd4ZWVvdnRUejBhcEFyZFlldjZoc3FhaEZhUmxCK29jeWtoUGtFZTFJWXdq?=
 =?utf-8?B?b3VvVnh4S1E5RU9tVkYrYlk2SFBOS29wNUdYZ2tDQ2ZOSVIwSGRkRlFlalV1?=
 =?utf-8?B?M2c3dlRMTVBLMUFkMjk3K3IzZ1lPbjNwUUhNNHA5bmdnZThoOGpKTVVNRTR5?=
 =?utf-8?B?bUNrcTduZHBxNUJUUUVLR2RRcW1UTlpySWRrS3hTSGhwWkNaQTlMZXdLVDhj?=
 =?utf-8?B?cVpDNEZFTjFwOFZyK1lsbU80enRLazk2YTdDcWU4REtndjMzNm90Vy9jeFI0?=
 =?utf-8?B?VHZ4ZmVSTDZRaTJBUnVSMWdsaTZLMVk0K2hGSlRxQnBGekNaZU43cUt2aUFh?=
 =?utf-8?B?RDBmdWZ6YTFld3pxSVZLOEdhZjZKcFBUTkR2MjMrTm5aU2pqT3A4T0NoMzlw?=
 =?utf-8?B?dTZaeDh6SzFHTWJBR1ZwYVBOcmhlNW9MeHpCcGdVM1Z1cVY4dUVOS1RZYXk5?=
 =?utf-8?B?NVlDTlh2S2c4b0RIdUFwdjl3SWRIR3plblI1RGJKNDdFQnhtTmJ2TE8rbnlO?=
 =?utf-8?B?cnJtaHJmemY3aGJldjR5Vzg2SXlFUVlPaU5nQzBPYzE2WlU3NUw4Y3ZHQW5X?=
 =?utf-8?B?WkpCK29icThGbjFvWDM4YzRXeE9tMXhSeSt0ZUFSQ2tpcnNBUSsraGFFeHhR?=
 =?utf-8?B?WElENHk3eEFFaER5eklDMWV2OWRBNW9MRzk4ZGNqTDVEVU1JcE1SOFF6VDZi?=
 =?utf-8?B?cjBMOVdkbW9kbXV4RSsyS0dEdzVtRWZ5UFhqWm1qd1BjaEtaaHcwd3crYVdh?=
 =?utf-8?B?WTZVUXJUZCt5dm5EUXlDdFkyM25SQXg2QU1BQkpONnpYNU9DUkFyQ2dOalVX?=
 =?utf-8?B?SDhOQWNlK2x0dU8wOEFaWTJyM3FDU2dJTEhPODIzSlMwTysxTDBhNU5UREt4?=
 =?utf-8?B?MTZmRXBMRXNmRlJaRmxtS01nb00vMFhtNmRhRHROblkwb21SNHROamNIOCs0?=
 =?utf-8?B?NEc2T2RFd2lvZmZXdUwwRUJyZlA0aFFLR3MxOGlTYU0zbGpxL21Qd1RqVVUw?=
 =?utf-8?B?UTFRaUNlQmQvamFtR2w0am5uY1ZvVG1DNU9XUVJEZ0lua1dPZjZTV0IxK0xl?=
 =?utf-8?Q?uWg1wnia56s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7660.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NEVmOFJmWVlKM2MxcC9WMXp2OTZQWE1NUnlQUzROVDAyOUtpZHFKT3NVaFFr?=
 =?utf-8?B?TXh1d1NLTnV5eWlzZTJqUjRNVG54eEdKYjk4V0JyMXZiNUV0NW5WYndGZW1m?=
 =?utf-8?B?ZG8vNGlqM3BmMVhtcTVOY2pQVmttVmtCd2pQclF5ampXZGZzcGdabDB5OU03?=
 =?utf-8?B?Skt6NTQyQzA5NWNDdGIvOUE1bWJOL1hNTnQ3aFdTUWVQcmxLWWYxVGV6U0Nn?=
 =?utf-8?B?bHVycEhFUVFVSWk5K3NLcGtmbTdnM1lSK1hodUg0UllLdm1NUlJRcnhtcE14?=
 =?utf-8?B?MDFuSllOaVlvMXRyNnh1dDRXOFBKTzlNeWd4S3FSNGkwVUtCYlU2a0d3TTU4?=
 =?utf-8?B?VnZQU3E3b2FQaTNJT05BTGh2K3RNcFQ0eTlNSXR6K0wrVzJDeEVNb094T3k0?=
 =?utf-8?B?Zk5xSDlxL1JoQTVwMjB2OG1saFVzd0FsNGx3M2ZwNi9DU01kQ3JhNjN5cjJS?=
 =?utf-8?B?bktqWkxrcEIyUE50bld3c0RLMFMwYTJaR01kMU5FbXpwNGgrQUhxS0R0QVl2?=
 =?utf-8?B?eTc4eVdUUHMvUCtXWklNWDlWbkxOSDR4Y1JYWC9jWTBUQldPY3BJTlcxeGFB?=
 =?utf-8?B?c0UxUWpySXRubVVyNzMvM3FlN1pqNm5ORUlKNSsvOE9ac3JXNS9DSmN6V3Rj?=
 =?utf-8?B?aTltWnpsV1l0bGk5VkRpaDkrcStsUkdLKzlOVVU1S0F6QkpiZFplZFpqWUQ3?=
 =?utf-8?B?bExicGFLcmJ4S0xTZlJlUzNyTVBwa05iajFRdHBwaGdBWmNHeDczVVpyekNz?=
 =?utf-8?B?aWh1RDRSa1poelI4aTBVN0ZSSDdXNWFNL1BtMzBrY1hLRHA5R0c4YXoxeTZJ?=
 =?utf-8?B?VTZLQnJPdk10aUpkQ0VCSjNib1NVTkxDZmVqVGhoWlZYMlBkNHBtYzhHZDFo?=
 =?utf-8?B?dUZEcnM0R2l2Vjh6UFhSMUhqL041QUFGbkhmaExpOWVyNTloNGduZGVISDJT?=
 =?utf-8?B?dDZWaTIwd1RxaXlGSDM3OGxwazFnTDBvNGo1N2R0NjZsL0dkL0I0em8xNHl4?=
 =?utf-8?B?cVNQRmt5UEtjWU5DQmJFNGV0bzVvNm43S3FXYTcwVUJXenJueEYwNDU2ZHFV?=
 =?utf-8?B?NjQzaVBzZTh5Qm9lRlRnbGtPZmk2d0Z3SjBCSlZ2dkROM20zTWI4MTRuaFR3?=
 =?utf-8?B?UjFob2tmQ1NNdzhvQWRVU1FFSWZSS3B0NVcycjBkazlZbkorTnduMHVLWmNs?=
 =?utf-8?B?TlpETHQwUkJOM3h4bHNuMkx4UVM2QTJZSWJyMzgrVGF1VzhJRVFicXB4NGdC?=
 =?utf-8?B?OVY4ZmgwRXYrcUUvdDdpNHFBTjRCZmMxR1VQbEJkcVl6MG9PZzJJL1JxSHNw?=
 =?utf-8?B?eS80QzlNQlQ4YVhhQ25jZjZJanFsd2dpV1Nua1ZXR2JtbXlSUnBBdGI1SThh?=
 =?utf-8?B?U1k1VG45QnVJMG9JQUFjTVdwcVZONmdja0ZXblZlRGJwaS9NS2piaGVFeEt6?=
 =?utf-8?B?U1FFQWgrd2R3NnNiV2tKTXpsWVMxaFUxVmpRVFNNTGE5MmxpRkxxeEtYY0pw?=
 =?utf-8?B?ck9ob3lUQVVRejQ2RG9GMUtqeHprTTc1V0I3Znlod1JzUEpSWkJhT0ZXdEFJ?=
 =?utf-8?B?ckxLRjhaU1I5cm1rbWloMVlCbXRVeHViODkyNWorYWpLZjFqRTV5NFJYN2hF?=
 =?utf-8?B?a25wRjR1MGVlQ2FyV0E5RVp4cEo3Ny9EbWZpV0tXSVVIUnowcGQvSmw5aFIr?=
 =?utf-8?B?TEFTekUyNjEvZ2loWVk2TjhiV0tnMnBabnVjQ1JrOEFyeXdXZmlIbU9FOWtW?=
 =?utf-8?B?dmtTZ28vTndUbXlMYVBVSUs2cHNwTXpTNndORHJMVVkrU3BES2c5TVZYbFFv?=
 =?utf-8?B?SFN4R3hnQ0FJQ3ZRbWVvVEJ5TnZoWG93bFc3aEUzZXJsUWJzMjZDM1V3SUFq?=
 =?utf-8?B?VWFBbWpvRmtyanRwamVvZGFXMEVMd3dwZDdMTjFkNmJiZDNPK2cxY0tlRnlw?=
 =?utf-8?B?b3R6cC9SYlZwZ0pSNWpqZjJuNEhtTkZOVDdXMnhRZ2RScjBJOCtwUVJEMkky?=
 =?utf-8?B?cVhvaUlJdzZCMjYvaVZwbzFMR3VOdUpJbzUwVUpZenEvcHIxelF0SmozajRD?=
 =?utf-8?B?QzdHZTNpVGh2MmVWVWdRb1JseFlFMUhyenp0VmhqcEFpL2FseGZaK25uWEJR?=
 =?utf-8?B?ZlE2emlvb3M4WHFUQ0dWTnZ1SmlRSmZ2WHFCTElQSjRrZXVxalVVSW5BK1Ev?=
 =?utf-8?B?WFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	injDnxuAFb6/dUyLdPZARO1lsES2LRxKiItfxDyazKn/49Rnw5ynbxW0ipuiRBqa+CpBx78L5HingG+XRqaKkhKe8fxIVJhYFY6K8GG6Zk3tHVVnj/Gx7vcNeAW+v0MERj01PkK+rP+iE8OJAftmXghTTTDuoSZCQZmGLopD6zrYohYgFgya4BgmfVZcbSklyqAtbLEdW7iFFPLYM/5BZFP7FJvB909jE+2jyoW+wUd4n3+e6U1ajmDwk1eETn4SuQo+p2/Tqb+ZRhFmQKJjdFqwZoMN0YFifWbY9tIlzgJv4RWPx/J+1J6AP82hyPZ0jnhIyQvSkuDeZqmbWRX5UQF/pn/ZF6OWewwX5CmR/gmK0P1bq+VknETQx2TKEOqYOM+Up7ef6IsRkZQLpZ33ewfPX6DBH9fVsj1xVOgUOjcykIGF0erwa82e9mgagzqLko4aCYln2IIPPCxKs8edSS3Y2BduQDUOLY4bCL19QL1/L4gbpd/T70c/hwsAiSsS2qfb31EDtoh1qas2hcwVfU8udxzuHWOtYZPkqEOSKPMI6RFsRptegOh3GGtVV6Lm/d9MxcjfjBkVjQZoWMiySNgGglo5lHSub4kMGxLsZgc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b8e809a-73e6-479f-6509-08dd9f98e259
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7660.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 16:41:54.0779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dggrFZtu/LgsB+sZkwEUCl8pFtg0ad6N4i8jWysGYH7saQWMdGypeggwPrbcSwHjBhK2YvBklwBua+TNBOUN/2L8M49zDMwi+SPktjaZlE0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4539
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-30_07,2025-05-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505300147
X-Proofpoint-ORIG-GUID: 26cbbc2R4EOTZ5bfstSkEDq45TG0AXgI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTMwMDE0NyBTYWx0ZWRfX91N5pqZeXVYS Ec8SQN1KFKzZ1m2BLXgnGzRmajs3WtIbL9HJUXqIcqipbk5hU4otZk9sm1WZH2Sk4heKzq/UmeU Bwas02bjD0lfYJk9EMKqSPvNrgEGMRlf7tFW4DmK7koTTSRtjFxnpgzID8nOrjAEdmudvGoQRrT
 Qge2DxAKICtkAHDsHlH2NAAxUUWxaE/1xengEieubqKOyhRDCFYcC9t6EEALQ4RCa59bbv/kTXd SshJ6VmWeuVTtBjroTHuZU131AUG5gjgCpW+y/OrvsaFLU6FaqB8aP5trGX0ROQqDFNR7Xo5qZW K5hvjrT+77Iz65dDAiMXWMwRI2uEnVZUYhYVCgz/pL0CRdAKCVNPgwLuwpyZslhLeQAbEdSDJqg
 upJ9p7xaRhuK7d10zO5VY4HLhJ7D77O2tCD9/tC6hMjya5cSyGKZfr97vWXfOdCAHZ58RuXt
X-Authority-Analysis: v=2.4 cv=UZNRSLSN c=1 sm=1 tr=0 ts=6839dfd7 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8 a=Fq5PAG9FImPNefx_jWwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=1CNFftbPRP8L7MoqJWF3:22 cc=ntf
 awl=host:14714
X-Proofpoint-GUID: 26cbbc2R4EOTZ5bfstSkEDq45TG0AXgI



On 5/30/25 7:56 AM, Jann Horn wrote:
> On Fri, Apr 4, 2025 at 4:18 AM Anthony Yznaga <anthony.yznaga@oracle.com> wrote:
>> In preparation for enabling the handling of page faults in an mshare
>> region provide a way to link an mshare shared page table to a process
>> page table and otherwise find the actual vma in order to handle a page
>> fault. Modify the unmap path to ensure that page tables in mshare regions
>> are unlinked and kept intact when a process exits or an mshare region
>> is explicitly unmapped.
>>
>> Signed-off-by: Khalid Aziz <khalid@kernel.org>
>> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
>> Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
> [...]
>> diff --git a/mm/memory.c b/mm/memory.c
>> index db558fe43088..68422b606819 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
> [...]
>> @@ -259,7 +260,10 @@ static inline void free_p4d_range(struct mmu_gather *tlb, pgd_t *pgd,
>>                  next = p4d_addr_end(addr, end);
>>                  if (p4d_none_or_clear_bad(p4d))
>>                          continue;
>> -               free_pud_range(tlb, p4d, addr, next, floor, ceiling);
>> +               if (unlikely(shared_pud))
>> +                       p4d_clear(p4d);
>> +               else
>> +                       free_pud_range(tlb, p4d, addr, next, floor, ceiling);
>>          } while (p4d++, addr = next, addr != end);
>>
>>          start &= PGDIR_MASK;
> [...]
>> +static void mshare_vm_op_unmap_page_range(struct mmu_gather *tlb,
>> +                               struct vm_area_struct *vma,
>> +                               unsigned long addr, unsigned long end,
>> +                               struct zap_details *details)
>> +{
>> +       /*
>> +        * The msharefs vma is being unmapped. Do not unmap pages in the
>> +        * mshare region itself.
>> +        */
>> +}
> 
> Unmapping a VMA has three major phases:
> 
> 1. unlinking the VMA from the VMA tree
> 2. removing the VMA contents
> 3. removing unneeded page tables
> 
> The MM subsystem broadly assumes that after phase 2, no stuff is
> mapped in the region anymore and therefore changes to the backing file
> don't need to TLB-flush this VMA anymore, and unlinks the mapping from
> rmaps and such. If munmap() of an mshare region only removes the
> mapping of shared page tables in step 3, as implemented here, that
> means things like TLB flushes won't be able to discover all
> currently-existing mshare mappings of a host MM through rmap walks.
> 
> I think it would make more sense to remove the links to shared page
> tables in step 2 (meaning in mshare_vm_op_unmap_page_range), just like
> hugetlb does, and not modify free_pgtables().

That makes sense. I'll make this change.

Thanks!

> 
>>   static const struct vm_operations_struct msharefs_vm_ops = {
>>          .may_split = mshare_vm_op_split,
>>          .mprotect = mshare_vm_op_mprotect,
>> +       .unmap_page_range = mshare_vm_op_unmap_page_range,
>>   };
>>
>>   /*
>> --
>> 2.43.5
>>


