Return-Path: <linux-arch+bounces-9945-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58E8BA212C7
	for <lists+linux-arch@lfdr.de>; Tue, 28 Jan 2025 20:54:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 345253A222A
	for <lists+linux-arch@lfdr.de>; Tue, 28 Jan 2025 19:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A21901DE893;
	Tue, 28 Jan 2025 19:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YR0ZshKH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GBq396dE"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF85F1DFD89;
	Tue, 28 Jan 2025 19:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738094052; cv=fail; b=F4HzvArVqYiRxB7MBUDw82lOx1eUdrCrOhZCAQFi3d4woTSGpQmAk0xFMkCyfGdU6nIkehqjqN6OiucZmOtvF5P4oFd0ZguTHjFTcD9lDs1wTvlSc8ZNj8VTW6paGcUKvYr6KLkicdRqgUkUgCliAagmcbFK1OLUHAB9HUs/C5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738094052; c=relaxed/simple;
	bh=jkQIfIQCq2uSmw4JQHlpAY6ebFYB+5dYQLGXlcSbtBg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gzm1WP+3FlpGOTXIwj1N2ECgKJRDd555UltqN5tCPpiPtt9zV2Cvc1wXXJvldnNLSSFpDmym5zSMAnGYVJducrc43t6Hes65a2QTJ8XFUNQyJDzE9AVUD6z/CfF4MZI3wTzbDQ6MMo8VWE51ofXx35JIp1+1EubZ2lWIMCMRBs4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YR0ZshKH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GBq396dE; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50SJXpAO026947;
	Tue, 28 Jan 2025 19:53:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=sj0+9WhLzZFXeOL4N3jhj5He1hK4lXy+AanfhUIgOUs=; b=
	YR0ZshKHJ5OZAfGzi3XiAn+A6/F0RuvOIhYCgCILJ4BrS31von5b6Zxyv0XG9OGZ
	QFy82H8nvXOZNQt796rqWN8cUs1RGJrU6DsgYxH5GGMS3T3/dRXZvA8euVZFnCAx
	KajRco4BqlNDsgdVevVOa4ijiMTea9LuzucAqZLZZLTQO36jZOZIu04WM3p4LVqr
	sAkB2PA71tZj3vFRRRHThB9iJEIZDqyb6b9ING4qk2Wjslj7uOMd2bjaFf0E8Vh5
	Hadd5KRNpqAJ0JxuzbtEeaPc3DLuWBnuCoEVsSOJbvNbW86DWdF6ywRP/cCPntu5
	GAPEVdN5RpEl6CeK5Jn+1g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44f32b0df4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jan 2025 19:53:24 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50SJ2G6K011648;
	Tue, 28 Jan 2025 19:53:23 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2040.outbound.protection.outlook.com [104.47.58.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44cpd8jsea-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jan 2025 19:53:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wWOeZ5Pz6w2+GTmMnFFJ3VOeMTkLTSt5k8By1hmeO+1c+VeNefh7qNI4sDJnVEyZRqZI/mMRFd/TEzXoCyj4B7tlRb0E3ac/YU0NmLVuRyENU28wfwQAbBc7JIOXroIPnW22CULIAUDgxvNQyRVzYiRWvRn9jjKshbjS+CjEPrpNd1tjWt1wUOcwDvqsUfo/iOyI05QOWHiY4L468+T/vB7UW9W86zehGfjmx88hzV1FXTWZyg9bRZ1JxKXaMSb2HAJxo4rJC+Jgu0WUhg2uOu8lbC6KYkQGaiNjHbKbs+x9tz0/sebmjQJ1FS6kYJ7KHBY+rfpOv29r4aKsnFGuVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sj0+9WhLzZFXeOL4N3jhj5He1hK4lXy+AanfhUIgOUs=;
 b=kVA0iRcg0YSv0mdpSkfVwUxUisPyO+wp2HrHevXockH4/iMBDhm5gpyLV+VvTlqRK03MjOxSSj4RChz2pcSDg6+kCxgqrqhUqIO2TNP7O6o+6R90sQm3nL2itnlxYULummuKzN1+KRerg3RZEwmSz3lVlTKaj1wEE87P1fZyf7ETaKGXNdf3ClBmU4SskZrH17jc+Ykd1rbtdN/na7uuSfzLHcsBOZHWB5qdl20AZ6DRnRGizuxDj+7Tuzg6ZQCzbsPXhrbUjL5ZI3vGWxNd+UP7b9AWhF+rGooowHNR0gQIK8i3DEHIKv1ccDwgtn/+qHR8uH758rDyJP64X2CULQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sj0+9WhLzZFXeOL4N3jhj5He1hK4lXy+AanfhUIgOUs=;
 b=GBq396dEaCD9iHjXowEJSP0PUWckDtq2huon7XwE7rZMUMWQDSIrke0Bryc1vgwAxtvO+hb9w6xlVojAxcbr2t26kc8aiHY9vg1doPL+o+ySBCQIbsJabzI0SaVi6g2Ue0vJzVCD/ePhMa5k68Z8eLLR3hKmvgD7heD9jdeLNEg=
Received: from MW6PR10MB7660.namprd10.prod.outlook.com (2603:10b6:303:24b::12)
 by CH0PR10MB5017.namprd10.prod.outlook.com (2603:10b6:610:c3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.23; Tue, 28 Jan
 2025 19:53:20 +0000
Received: from MW6PR10MB7660.namprd10.prod.outlook.com
 ([fe80::41fa:92d3:28b9:2a15]) by MW6PR10MB7660.namprd10.prod.outlook.com
 ([fe80::41fa:92d3:28b9:2a15%5]) with mapi id 15.20.8377.021; Tue, 28 Jan 2025
 19:53:20 +0000
Message-ID: <6a2c1324-cf61-47ea-9ffb-f84463adaa41@oracle.com>
Date: Tue, 28 Jan 2025 11:53:15 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/20] Add support for shared PTEs across processes
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
 <Z5iDEpaEPynnW4s5@archie.me>
Content-Language: en-US
From: Anthony Yznaga <anthony.yznaga@oracle.com>
In-Reply-To: <Z5iDEpaEPynnW4s5@archie.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0069.namprd03.prod.outlook.com
 (2603:10b6:a03:331::14) To MW6PR10MB7660.namprd10.prod.outlook.com
 (2603:10b6:303:24b::12)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7660:EE_|CH0PR10MB5017:EE_
X-MS-Office365-Filtering-Correlation-Id: aaec09f9-9dd5-46ee-8630-08dd3fd56a61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cW5QNjc1YzVKRFlmbHl1c1FUTGk0ak4wZGJEUW9HRTd1RnlRdVEzb0tYMElv?=
 =?utf-8?B?QkQ4d2J0T2dtUUlCTDNLdFBEQUkybHBsK3Z6UzRKVWhtM0UxSXpvTjVmUUFG?=
 =?utf-8?B?WU5lMmhERG5lNDFMN1phMW1oam0wT1ZqalppeDkzbGxjOStGNTFoQW8wb0JU?=
 =?utf-8?B?SG54TWNrTklOQjJpdWZlMk5FTzcwQmYrcXlSUSt2K1BsSGdXK1lUZnUrUFFp?=
 =?utf-8?B?a2p3c2xLME5sdG9hYVFla3h0NFova3hGTEZ2cWhuaUVkMHhkb2ZGNkNOcUZh?=
 =?utf-8?B?bE45U3l4c2E2dVBKcTJ3MW1PRDhpV0dScHRETWxmc2UrUTZEdjltYXpBblQz?=
 =?utf-8?B?cWhiemxKektESFQvM0FFT2psMzFOVW1RTnE2c1g3TFJCVDVtVENSMHBBMXYz?=
 =?utf-8?B?UGR3a0E2amZIQm9vbEsxOTRFaERDdnYrV0phVlhiV0doV0g0M0o3ZXJCT2Nj?=
 =?utf-8?B?Mkxkb0NxV0RJREw2cWZGQlRkTE9hSDNyZ040VDlCRWQxU0ozNUcyY0xjaFhr?=
 =?utf-8?B?SEFSU1FGZUZDcGh2R3pPaVlEYS9tcEx6R3JQSWNhN2crSnAyek1uNC9TN1dV?=
 =?utf-8?B?ZmJsYjZXTzV2cUVScTJtWmFJWnZ3TWtDTlVwaGx2R0YrcVYxNlN2SlRqQWdR?=
 =?utf-8?B?d3crVGhoWjhmZ0YzSmZCYkJWK0l5bmpIWHkrcEIzbENNR3dLYlpaR3FDZlNT?=
 =?utf-8?B?dlZZUzhSeThsUHRleUkrK0dHUmZJdmFUV01SWXBzcW5aMC9DM0k5aDcrRjVS?=
 =?utf-8?B?SzlOREV0ZW9rMEx6OGRoWGgxeElNUW4wbG9CWXpiejFYS0Q4Y216dW1DcmZ2?=
 =?utf-8?B?Nkl0WWxRNmt0L3lOVVpSMU1FL2JYZnpXbkFXeVFZMnNuM0Jsemk3WTBEcWlS?=
 =?utf-8?B?cUJoY2VHRENmQjFYN2hEeU14eGkwaS9mZnE4MXR3MXRLazE4Q3YwWndVa1NQ?=
 =?utf-8?B?TjFnZTgrcHl2TzRSY0hVM1ViQ3hNZEs1bEdtS1dnNE05RkI3czF4RzRIeS9h?=
 =?utf-8?B?ZnZpMC8rUHdBN2o1VHJBLzdXdkFndExmVndkenc2Q1YramM4aTQxZmhYMTF1?=
 =?utf-8?B?T3BYMzE0NHNoNzZlYU0xV3ljWnJHRWVSczZjWHdZQWJCdXRDRks1TXhGNHhS?=
 =?utf-8?B?WGdseGxBTnVRYjlPZlRKVFVoWXoxYXkvTm9pUkwzRHRUd1lYTjFJeXJ6VkRD?=
 =?utf-8?B?ekEyOER1a0x5dVBaczNOamxVd0pzRE5PMU9SaXZ0T0JlMzd3Tmw2cXRGOE56?=
 =?utf-8?B?bHlrRHdySnQycGxpdkx6UWJSR0tVV3NLREcvRm9aMCtpZ29qaVF3YXBJOHg4?=
 =?utf-8?B?YVdaYW1hVllneS9lRmprcE16dEZoL1pRcnhESStZOWY1aVVQMHJSd0s5eFZN?=
 =?utf-8?B?SjVOQXBGamVsSXMrWmRCWDl4cDYyaTU5b256cS9SVXVmeVZ1OHpjWVBMOVhK?=
 =?utf-8?B?K1pDS0dmUGpwbG01Y201UjF0U3dObDlZM0VFSmlBVHBNS2JUc3ZpR1lQVi9N?=
 =?utf-8?B?b2hoTWtUWTRyNWhOYzVaLysxMWNYd2FIZ1Jjc1RTL1ZBRERKZGM4K2paU1J6?=
 =?utf-8?B?RUk3SnJYUFJQbzROUWhxMU1KU1BhcGpYYXh0L0doK3Y1eGMyV20vODBIR1N6?=
 =?utf-8?B?eXpjNkJJTjN2OFJxa1VvSDdMRUJGbU1NdElibGN3dmNrNWw1L1AwWU42b0RT?=
 =?utf-8?B?R0M2TXFIMFVEZ2Q2akpEcFlDbnVXeDRYNWF2c0FIS05yTzJZRncvMFluYXZQ?=
 =?utf-8?B?ekJtaXR1K2lqWHFHMk1KMmc5bG9aampxZWZrRGRXVEhZSEhqaks2VjQzK0Q3?=
 =?utf-8?B?c3pVWEw4cEVQNE95bFJQd0xFdHQ1V053SUwwcWtVQ0pWTGNpYnIyQjBiUXI1?=
 =?utf-8?Q?4H8m9QtRU6isQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7660.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UnpxL3Bwb2tDRkovemNsYjVWeElJZVdTZFI5K1JramlNUldzU3UxSjFhc3k5?=
 =?utf-8?B?R2hYMVVCMUdxWWtqMWpBQTgwY0NwZ3FBWGxNTytUT1FxYUVDZnkzNE4vQ2w4?=
 =?utf-8?B?eFB2MU45RWpwMy90bURTVTNOeHhMSm1iSHlzVDdBTGczbE1pcVVGT2Fycjlx?=
 =?utf-8?B?QXFXRklLejl3RFpEQzBiNkVlWXhnZkxvbW03VXlwNnc0M082d3RkQkt6clR3?=
 =?utf-8?B?TmFGc25iVzZzYnJqejlZb1hLUGkyVDk5OWdBYmFUZEZMNEk3OVJrUzJLb0xa?=
 =?utf-8?B?dnl0R1MyM0w2aWgvVXd0TFMrS0lKZ1VHbkxEV3NneEYvdnlpbytQR0xBdjVH?=
 =?utf-8?B?dXdleWJEV0ZEZWdCZm9xYXNGMWIrdTRRc3k0V1Nxck1GSUxDVGIvRG8wd0p5?=
 =?utf-8?B?Zjgyd0xjK0xPTFQ2d3Q4NDQrNCthMUZzS0NRNGNhYUxpOFRWL08vR3RhdlJu?=
 =?utf-8?B?MHlpNmlabTZUOWUxckF4ZVBJck9MMmxTL2E5UmZ0QTl6dFhsR0FhMDhnR1pP?=
 =?utf-8?B?MHZrZHZvMmF5cmtXakZ6MFo4K3MzdE9qaHM2aXV1UDdRWjM3V09uZ004c3dI?=
 =?utf-8?B?bFcvU3RDSkZkRWZSRnNUbW4zdXJFQVBKZE9vVlF0eU5IeWVzVEVDd1VTZEwy?=
 =?utf-8?B?R1Q0T2NhUWlwMnMwSEdNbkZzdDdoMzNIUjh4ckR2SnpCdmROTmVEOUFQR2FQ?=
 =?utf-8?B?MWtCNHZ0U3ZCNjdyeEV6RTJMem1yMlNFcWordnU4Q1hDSzB0eFE0RTBtYUR1?=
 =?utf-8?B?dldKUEZvV2Q0R2VkS0pJdFBKb1RtTUYwb285d0lFMmNRaWcvTzQ4UEttT0Y0?=
 =?utf-8?B?NXRtYnczVGF6UUU5NWhFbFdQZ2RQVDFXWlNicldsQTBpR1lFRnNKdktkMk9X?=
 =?utf-8?B?V2EvS3Fmekt6cnVGYWxsbVJyK3oxMTc4SUE1TVF2U1lUTXVQR3hRQVVBNS9E?=
 =?utf-8?B?VGQvVk15b0lieWRKaFRDNnI1ZjRPTmNhTE94U1cvQkIvSncrdk9nZlRUdHdu?=
 =?utf-8?B?czJzTGdiL3dPQTkyMlFpbnJIbElIeGM1c05FZGhNcTQ2R3lBZXgxUGJiR2dF?=
 =?utf-8?B?dWNxb3pkMy9ERVZDZWE3a1dvUGdqRzVmaHJVbTgwUDY2SElnbEFySXB1dkNC?=
 =?utf-8?B?ZDdJQnBpeElKTzJ5NDhweHhQbytIZGJTV1hPbm85NzNSaktPUGRBL291cXFQ?=
 =?utf-8?B?NFk0MkRxQWFPWmlzV2pjU2R5MzZ4TGlsQmFIQWdSdXpMb0p6Z01KM216dWZV?=
 =?utf-8?B?cHZtamI3cTI5WkZmWUFVNGEwMVA4Y0JsaTJHbUhWQ09SYzg0VWhTcmg4WDhx?=
 =?utf-8?B?TGlwUnVQMlM3bkUxK01adXNyejlJMXRydHR3Zzh3ZDhyRTlJTzRwc1JOWHEz?=
 =?utf-8?B?TjZtMVFtT1M1bHdDZ1g1ckUxK0RzUjZtcGp5ZXlaSEg4YzRJV2ZqYUw4UUlE?=
 =?utf-8?B?SXFtYTkyazlhQzdEWDFiMjVUeU5TWUNWZG9RV3lwc2NiTjVLUTRnaTZnaGk0?=
 =?utf-8?B?OElTU0tkbFpjRDdxOVhRWEVEaVNTZmVHOFozdUhFOU81b25HOUhMNmZNck1x?=
 =?utf-8?B?M08xWDBPNmZmb2Z0cTBWRlEyNy9YREdjSUE0ZWZsd2xtRENJRWcxZHp3N2I4?=
 =?utf-8?B?cjRWZEtxUW1EQlZTVTA1cTBXZ0lSM2d1WFZGZmt4S0dTbTJEeTNPL3dvYVNR?=
 =?utf-8?B?bzQyWUJKS0kvUnpDOFhjZUpHZFlwMGduZkFjWGsrZjl5UEduY2lYQTNldkhV?=
 =?utf-8?B?Z3A4S0lWTXhiRmRXZnRhdENHQ0NOUTQvYXo4YmdZVDFONXp3L3FSZjBIcU1n?=
 =?utf-8?B?ZE1oMmxPbi96Z3h0WTJReFo4cTUrcG9aN2F3RWNtLzhVYmwrT0xaazdTYkNP?=
 =?utf-8?B?Y0YvRmdMSWQvYnB3L3hLcHNJcGFXZ3pYU3FtNFovTDV4c3JwN3pDYW1Vdm1u?=
 =?utf-8?B?dkQ1TnIrK1cwTmw1OWNJREN5VTFoYWs0QmdzSGU2eENnbnVrc2pteDIwbnA4?=
 =?utf-8?B?a0F3MGZ6Q0UwTG9ZbXdzTnYzeHdQekMva3hlZk43b01rMmJSbG9aZlJjSGd2?=
 =?utf-8?B?SUtzZUY1OURxU3M4dkZhUE16WlhrQ1VPMHUveU83Mkpvd1hva1h3VEhybCs2?=
 =?utf-8?B?SmdGK3hIYWVUWHJmcmxWM3BkdWx2SEtBZEFIb1BHSnNkNm1RQW9PUndhSkMx?=
 =?utf-8?B?SlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	I7GVLML5AOsDz/hfDDYW3cy2E03zvcnWtZb6EM9FtVgzYIawBt6VC2w3geX2G03qwHlgxbZbiPnQwTeSu/5219isRdhIfUaVsGFyGcSgNiANhQvZvi+RmhzMr2UOmcH3XrgRuVF+bNiLJfYTr2g+TFE+rBF4lhhyqO8qv8gfNK+KNOcllRV1lxhHyZ1Qr5oX4BfFzVRA5Nr7yFMjarV5dbFmKeVtNyreMJ1z8O5rbv5cGOOqLN+sIsYRJ50yWNtiXs5ngdab2SJF+uhTMSoexiq4lhyJTKuMKdJPSTW6fY7tMDxD7JMlKcYE7zLw3SL47/0DVgboXc7Fxp+2TMPH89yWzAzmmY8H+APoV34E0hbzbir2JXEatq1aba3f0Cwz3v9brNKMyua2E/eKnGsa6vrrCj1JmI84a1K0IViPA+OHmmwU3yWlu11jukUnvXXHdM5A7YHeBmeSov/Yo2oHi/gLP/x2EzAJieKPIKZbVPO58S/KRcpEccskFz4p77RqOQJxwygePcD+K/PSsoq7pzofHm+Fn914HrXBntj4BrN439y3JFHBHIwtLQOI8x0Tl/60ATm1hFrYlE69j1EdDM7G9h1mXBlPeBca9kGdeoo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aaec09f9-9dd5-46ee-8630-08dd3fd56a61
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7660.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2025 19:53:20.3575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ISZEZvndFPl6QRSnAZl54cMYX4epPnFO8E5wpD0+8eZsrEzNKOIEPsOa1fP24lIvVZXaIZn8PeSkmE6Q0e28e96VSy4p8HxkabgoqNLVAEs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5017
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_04,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 spamscore=0
 malwarescore=0 mlxlogscore=850 bulkscore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501280145
X-Proofpoint-GUID: 390Uydn4-CmWd0YyGWC_0eHm1lsyakxm
X-Proofpoint-ORIG-GUID: 390Uydn4-CmWd0YyGWC_0eHm1lsyakxm


On 1/27/25 11:11 PM, Bagas Sanjaya wrote:
> On Fri, Jan 24, 2025 at 03:54:34PM -0800, Anthony Yznaga wrote:
>> v1:
>>    - Based on mm-unstable mm-hotfixes-stable-2025-01-16-21-11
> Seems like I can't cleanly apply this series on the aforementioned tag.
> Can you give me the exact base commit?
>
> Confused...
>
Hmm, maybe I goofed something. Last commit was:

103978aab801 mm/compaction: fix UBSAN shift-out-of-bounds warning


Anthony


