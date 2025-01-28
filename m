Return-Path: <linux-arch+bounces-9944-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2AA0A21250
	for <lists+linux-arch@lfdr.de>; Tue, 28 Jan 2025 20:42:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 418451674EA
	for <lists+linux-arch@lfdr.de>; Tue, 28 Jan 2025 19:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4151DF96C;
	Tue, 28 Jan 2025 19:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ml+nYzqD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="usRGI80z"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB4322619;
	Tue, 28 Jan 2025 19:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738093316; cv=fail; b=KwApF4Fuwcpk8ETFAHezEJ/vtQ/ShOEO4vPDyYKuaxr/EnudrzGLiVyGtRBmjBNKBFb+ilBScDj9FU4y/S4ek98S4ai7OFz0q8qgeKALuiVHeNkKKVk5r5GVmnQ2yP07AubEnRuw++Tb7JA6h28IQ7HhHRmJhtEx1ODapWvsMg0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738093316; c=relaxed/simple;
	bh=kxtubTkZ6BIPxzEaAxn/4s14OrpUmYimrUcMzd/BeDo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dvuDlyX695wQTkfO3C1PibkwfYlcjmpL9Z0XCHQAj0wCr6VTmStgaChAcIziQC2gfPMpGxVwpo+kUtpagLpfnVPtGYNVFfQ2j/4d67/gsiW+xavUyg/T6ytYYZJJX55fHN6TiSyhVuS5oPKcoITIo+QuEaEV8pk2ar4za/bQai0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ml+nYzqD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=usRGI80z; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50SJXn1E024357;
	Tue, 28 Jan 2025 19:40:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=1aHogasrhbWR8152lS4Q2j+0aX4pO7++oVrFdBPsnRY=; b=
	Ml+nYzqDzmwQBtLYYwq6bcy4xMuaBkXAfZOh/i3dCQ6kigCkNwd26XZLwaBKaw8v
	BoomjZvH+TxJIbKsO9Fp8qmV7tpvgXBlydKX5ywfPQwmjCIv48l5BbFB1p+sWnkF
	XQ07TDsyHdM/Je+DC/iM1nmLpL8du/XwJ/cjqwgFslBhhioN1+Vsg/jvOwlpImlb
	HXtSB/I0Tt0epO7bjQdlfAx0FL2+KaHn4ZTsbheZ/IC+xKQ++OeVPXV7rDf8gUqL
	+ji72/Z4TIgGg84c5xf9KRXpBlTg/UU9ltV7MVkLjfhwTzb9IxvhcVilvVy1FyC8
	pCrELNE94uD5YD3XooCgKA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44f5ay8180-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jan 2025 19:40:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50SJP4su004271;
	Tue, 28 Jan 2025 19:40:49 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2043.outbound.protection.outlook.com [104.47.58.43])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44cpd8vnrv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jan 2025 19:40:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c/m/6djX6ObjrvyNC5qpV1p8zEE56a/O244UScnROkcOIJ09tvkUXnInnsR36wHIE3MVZQ8EmCWcNbJG8caqxncLx2rHq4tpFxsenfEHpKFGDtwnF+YXeE4LQdVdcBIRmp9UOoIC1tmoVJF/L8tgjuUaALqqRvanVAperztugXgP/Bss1XyYD/0P+G2jNbr6oov4JFkprAbD147UAdhBdUh6g4y/aBe+HSKjpXhSeFcWmcaaxaZvbyDuhaPElP/CIA6VjLR/5NP9SoxUU7KYYMjI05NbWYlDknsbXRO4NwXucqswhgknX9bphhrXOrdI78QKFkqPQ0wARV6fHYcZ/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1aHogasrhbWR8152lS4Q2j+0aX4pO7++oVrFdBPsnRY=;
 b=KrqRPnk2QsIxv/ClspBecQziDoNqOvrWBVRmBxLgI1AtTtmvDXtOznzViuiQrTdm+BUvMHbmlx5iF9m2GP7wBCARlc4saFcfkGyG0+1XzJDtgKgBSFJhDJfWYY19H5Kih+oEaYukvMmGmbkeqimgP28nxzHrL1bb8Xd+qxTGQqXZ/mPXAo1yR6Z/6/Y/bHvcITRNCCn3WXREei/p8D2yD5iq6nbwDFB8r0A1DtYSUxjE448EzAySmOHsSZtv4csLFN8rw2k836Yfd16GcbIWos1ZMNRqVABgM7wBBBCeFmHhoNjIIG7VLdpYxORttRfsaHEuQzk4vsPmJsPkWxwROQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1aHogasrhbWR8152lS4Q2j+0aX4pO7++oVrFdBPsnRY=;
 b=usRGI80zXwStxmPsda4dyd+8Mnv0Igbjh2y8R3awSFghXGYCvzw6oQM+bHDhbQSciTWsr9SraRLLohrqksLdQF8SovfScqgO7NYQFMJBFWp9QsIaGQAirNRZhSbbvRlrLlWq0AF++n2HlVfMwXqWSONMMI6N+KNjszaCGfwrLPY=
Received: from MW6PR10MB7660.namprd10.prod.outlook.com (2603:10b6:303:24b::12)
 by PH0PR10MB7099.namprd10.prod.outlook.com (2603:10b6:510:26d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Tue, 28 Jan
 2025 19:40:46 +0000
Received: from MW6PR10MB7660.namprd10.prod.outlook.com
 ([fe80::41fa:92d3:28b9:2a15]) by MW6PR10MB7660.namprd10.prod.outlook.com
 ([fe80::41fa:92d3:28b9:2a15%5]) with mapi id 15.20.8377.021; Tue, 28 Jan 2025
 19:40:46 +0000
Message-ID: <a6f26afa-e4df-4519-8287-39ec3eab181d@oracle.com>
Date: Tue, 28 Jan 2025 11:40:34 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/20] Add support for shared PTEs across processes
To: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
        willy@infradead.org, markhemm@googlemail.com, viro@zeniv.linux.org.uk,
        khalid@kernel.org
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
 <404b500a-4a28-4a8a-a0f5-3c96c397be0b@redhat.com>
Content-Language: en-US
From: Anthony Yznaga <anthony.yznaga@oracle.com>
In-Reply-To: <404b500a-4a28-4a8a-a0f5-3c96c397be0b@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0568.namprd03.prod.outlook.com
 (2603:10b6:408:138::33) To MW6PR10MB7660.namprd10.prod.outlook.com
 (2603:10b6:303:24b::12)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7660:EE_|PH0PR10MB7099:EE_
X-MS-Office365-Filtering-Correlation-Id: e494ffd0-cbbb-4098-cd8f-08dd3fd3a8c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z3o1elExeW95MEhPbGhOaFN6bjZCR05qRk5WWTBGbFhQdnhxWTczbm5PTkdk?=
 =?utf-8?B?VlVHRFRMUnpxN3FLRU56dDN4S3ExU0xlbWJzV2xNRUtrNkdyUnlPbGZWaDI4?=
 =?utf-8?B?blJFQVVYOUFPcHlJV1pSV0NRWTNQUlVPWnl3K3dBeCtpMDBzZ2JlVWV2TFow?=
 =?utf-8?B?OEU4SzdIR1U4end4cElPclpvOUdEbWZaNDJNNUw0VTUwM2RLbEVKRlErMUlt?=
 =?utf-8?B?MHI4RlFJbTdZVHNBZTZtTVJjaTdEWmVvQkRHVm5RRjVDQnFROXV5c1d1YXcy?=
 =?utf-8?B?cnNLT0I0TEo0WkxXKzdMQ1JQMFdpMDVnQTh5OEFyWlM0RS8zSEl0SzFkTVpw?=
 =?utf-8?B?elRucmhLN0U1ZW82bE95aGNybHNzaW5IUDdoTzlVMGRMNlgyS0g3VDdsRmlk?=
 =?utf-8?B?Z0hzTHlYYWZOaTFkdnlvRFpucENFY0IxWDFrQXpUUm5PdmkyREZRdzBydUNk?=
 =?utf-8?B?ekNaTC9qdmlVcEF1ZVZpUE1ISUFiYkNuM25sTERLTTBsNXVFWjdMT3dsUCtH?=
 =?utf-8?B?QmlMK0p0b2hyL2tzM2VsUWdYK2NrQ0E3ZDcvOW96Sng5VXBDZWREcXpEODFP?=
 =?utf-8?B?b3poZStzR3V4cytpODZ6Yzl5blZHelBwTzVpMW1YVTdXUTd3V2djTXVTTy9a?=
 =?utf-8?B?QTJLa0dBYmc5YjYrTkVBeFNyNHBHaThhOUZGN1B0S0pmR21JUjhVWktkYWpy?=
 =?utf-8?B?YnB3UFJ5MS9ZOUZ2N3dncHVpTXh3dnNja0o5eEg2Z0pzL25LQ3hncnVqc0N1?=
 =?utf-8?B?VDk0V3pVR25jWko1dkRyQ3hzSHVLM2x6aDVhcGpuZ0ZNWTlycDVockFVTVE5?=
 =?utf-8?B?b3Z2U0M2eldncURrNXEwSEM2cXVMbGVlOFJoQmo5TmQ4NjBlbWhTT1VOOXFU?=
 =?utf-8?B?N2M3NVhNbnJRblc4QnFDc01Za0kzQ0VvOCtraTlzVGtHdVU3OGw0dHJZZVIy?=
 =?utf-8?B?WHhWbFZReWJsb1RSUUxzc1RjOXg0b1pJcUhOYmtjSVRybk1KUEtTY0lKRnpM?=
 =?utf-8?B?M3YyQldoU3hLQ1ovQ3FPZm9hZXNNajFhZmIyRWJNb0V1dnhSak91NG9uRUVh?=
 =?utf-8?B?bUFKNXdFN25Tc3FlSGQ4d2t1N09ENTcxM2FMMXk0VUlScE1QS2VkTkhyNW8w?=
 =?utf-8?B?MEhJRTY0c2E1UkEyTkxQOGJZT2RzL04xY0dkNEs1WkNabUpnczVyMTZtTlJR?=
 =?utf-8?B?UmFZQXIrUHFvNENqMGVuYlpRSDNjZ0RVbFBRV28ybmI3MzZHT21aNE1BOWVM?=
 =?utf-8?B?T1V6Tlp0eHV6UFp6a3M4M1JXeVdYV3FYRHdqaGM2UVl5VHVwWTZ1MUVwYzNP?=
 =?utf-8?B?MUVuVlZoS3BGKzdjUEVzNGNSd2xxZllLSng1cUZ6MFVIb2trOVhXTUF2c3JU?=
 =?utf-8?B?SVIydTJSQTJnMUtWWTljc2JMeWhpNUZGS3BoSC9KZDRGRWNXT0Q4Z1k1UXp3?=
 =?utf-8?B?MEtKV0RiV2JzTHJEV1VxbmtZYW1NYVYxZ1ZITHY5Tjh5U0hxeFZWbFFSZUxT?=
 =?utf-8?B?VmFwRnFhamNHOW95dWRMRHVKSDBKU01aUVFNcXFxZllvazJSSG1CZEdoekVS?=
 =?utf-8?B?dkdLQ05oeDRLWmM5MWJMV2w4TFFMa1VZN2JGNVBVcVFGclNFTlNyMHFoSmt6?=
 =?utf-8?B?TzhiajVMSFRWTnlxUG5lYWRNaXByNGl1YURIWnhzQnRtdGZuZkFYdlBHMUZw?=
 =?utf-8?B?TElBOTB5TTI5aHB1Mk5sOEkyV0I2ME51UEFrM1RnQVMyMGFPRHdTWFJ6cS9o?=
 =?utf-8?B?Z2x2U2h1TGFSMWZXWXFDQUV2aEdKT3gzd094YXZhV0NvaWNnTWZWTTJMMGVa?=
 =?utf-8?B?WE1lK1pWSDl6bFJYVDBOZEwrTThOTHY0K2I4WmFPb2Q1eXF3T0Y5S2ZITnRu?=
 =?utf-8?Q?24QaYxQMaO57n?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7660.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZmlnVm16WnljMXJ5RjA5UmFKYUVrRnBXZXZtMm5SK3BvUjNxYXowT201cUZX?=
 =?utf-8?B?bzNtNkZ5cHpiYVVFYzBkSGx0OWNYb3c3bnNLRStZU2tsT0RrdVR4Y25jKzhz?=
 =?utf-8?B?UFcwOUo2NTEyemYwYU9wZ0lqc2Z1dTVYVmNvaUdta2FtSlZnNU1GTTNtNTZX?=
 =?utf-8?B?NkpPWFdhQTErU0RLUGVBQVptOERWcFlHaUVWQVo2UUhSOVpZSHFCb3ZCcTJN?=
 =?utf-8?B?bUtoTzRaMVo5ZG4yWTUzemFqVkM4eVFJNjAvL2czTnFac0xFQXhBQmprUWRW?=
 =?utf-8?B?Wk9kRkJmMWphZTNmdGVjMWNXYTJ2aHh6MDJ4YW1RUU1SSTVETWFia1F3RmdT?=
 =?utf-8?B?RVBubW1OWWJrcFNIYThoNWtuY1RqZ2YwMm56NVhlMDNHYTU0eUJaZStvUU9l?=
 =?utf-8?B?dFU4N3M5bExJVUZxR05BNHJuZEo4Y3RWOE9aSnA1R09DY1pMUE12NFBkSVBu?=
 =?utf-8?B?WU4xMFFueWMzYXRwRXp3SUJzbE5lczE3Z3QxSjB0UDZNeU5rMllXbWY4c3NP?=
 =?utf-8?B?UmNBdGcyWFFEUTdCOUN3bmFVUGFkd242RjVWVmwwaisyNXhtMng1bUFaK2Zl?=
 =?utf-8?B?Z3F4Y29LaExVSndDa2pOL2lOdzFCNzMxTHRWTXB0QlI3UE5Lbk9vWFdEbEg5?=
 =?utf-8?B?T3ZSQXFBcjVwbm1KS09oK2NUWWQ5NUVsRVNSZ2gyNHNsd3NsUnkyQm1wSTg4?=
 =?utf-8?B?YkJsNE8yeFZ6VVBtZkJtSlppQW1oUDRBNVQ4cHlZN2dkV2tydXZWRHkyc0RI?=
 =?utf-8?B?RzFDMWVWaHBRRWJiS1F1VlhjQlozbGJIUWoybmJZT0pVQjk2aHY1TWdNWkp6?=
 =?utf-8?B?ZnVKak9sR3R6V1lNR01YaVdRdHovRUw0RTlRMEJ1OHM3NlZmNnVQbDBEMHNi?=
 =?utf-8?B?TktVL2EyK2VwSjNFUHMzb0Uvd2NOSU04bVA1QVAxM3oxZVBNTU5LaWJsWWwv?=
 =?utf-8?B?UGV4QzVQc1pXTzVJOUJHZDFEdGRFa1phTElVL2VHVzcwOEZrd01IbGFWamRH?=
 =?utf-8?B?eGVCa01zZEhRNE5tRTZNTk9SUUhxZ1VqVVZseFhVdStjbCt6b1RGak1QWVBF?=
 =?utf-8?B?VEJ1K3BSdko1bUpxMDZac2U4Mm1IVTJ1QnQrRUFpTTllNnYzRVdTa05EVnpF?=
 =?utf-8?B?eWpySjJBalkwK3pqYTV3T29PZ1IxR3VuQTRKb3hZNVZ5dkdnZldkTDZoUzY5?=
 =?utf-8?B?WE8rSVdkaFJsT1c2cGRjWEF1emJxK1FzYm1nWUJ4SytRY0V5RVcvS1hnaitS?=
 =?utf-8?B?UTYrZVJBdGxEa0pVclRrZEpxR0VOa0lMSVBzeW13U25lakx0cElsY01WbkdO?=
 =?utf-8?B?aTZlekg1VUJoMUxUenY1NEQzOWpQSVBhd1lRWTBSb0dnK0hCRjFXSGRxWXR2?=
 =?utf-8?B?dU0ySDE3ckNMZGo2L1QzVE5HdzJWOVdnOE5kcWRSMVF4LzJQU0NMSHFuOHl1?=
 =?utf-8?B?aEVuaTVnVS9mODUwSUQ5cEZBNG5xTzRvV29BS1Z4QzdHWm1DU0dzaGYwSFlH?=
 =?utf-8?B?dEFkYmlqMHNmeG5EM3dFSmVqVTgvWVcyc3o2QXJOMzlIbThvZ2Y4eVdWcmJi?=
 =?utf-8?B?cG9lRFloWUxuYlRWMmU0VW03SjYzWjhRTzNydlBEQ3gwdVQ1UnFPN2tPenBW?=
 =?utf-8?B?R3JENVNiaGVwNE9FNmhYTVpQQnJGTVFpd1R6cTlkSWJNZU14Q05Wc0tGRDZM?=
 =?utf-8?B?SjBWWTlEM2lkNjVsQ3VRSkFtUUtGZUVabWlWTmgxdVFOcGxLaGtTZ0cwYmJI?=
 =?utf-8?B?K1RUQ2czblgyUlFYdUlkTnNOMVd6NGh6dmttTmljcjNFVkFJM1doTW9obFlJ?=
 =?utf-8?B?SFdjUUNZNkJlOHFtR0FzeVR5OS9kUGRDK0JqRDRneHgyRjdrTFdwZzZrY1hs?=
 =?utf-8?B?VHRFbnhXOVN2bDIzWEJHdS92djZndHlpSkJmTFk2WEk0VkFDQW14bGpFSDNz?=
 =?utf-8?B?cCtiR0pHRTJBV0FlVHBScnltYStXbzM1N0d4S0RqQXJaaUZXZG1WcURGcWo0?=
 =?utf-8?B?N0tjZ0ZtWmYwaEFBcTkwVk9XUWZTOVNyUllGQURJT2xYU3RzZ3V4STlScW1a?=
 =?utf-8?B?cmVVK0pOVkZvMDljNFc5SnZnNjREV2hmY0IzMkZSTkhqS1M3dVFjSXhHYm00?=
 =?utf-8?B?dm5nNmFrUGdpNmpPUk5BOXJYREdBdFRwL3dyUy9hNXdxRlRRNkliaXA4Z0Rr?=
 =?utf-8?B?aXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6/4zRJ3sGgx8QDvBNDXDXvW2R3EeV3o/F/+83wosq5h7MqgdoPi0vx0ftRVMkZENll1ohDZ1+aILTRzkak7/HHj1LXvt8KcRD8lrvVkF1gLCKXsAdD0e/FzpAH8U20C5+5uGTZW5qHiEyS+ZmIOzbH7xRMqUcQ3Mcv/6CZg8EGGJ89qQ19AllXyKDx+gW6L5zjSpyB42YUhSWNqtPjk1dYL+LLBItkh6gLqGHktvZhyBCRjGh5aIB5MNlxpEN1oJrVZ9+SuW5KhpH+19tU5Zticoueth40Zi31kXQxkJUD8vGonCo0I3yCm4fO+bNW1cwCKoNnks6fmXG0hOrx2PxO6fqRcy1eW92M+ukBvXWmRbKJu1RJRaeW1kHXJPqCgzsAqwIt7wY8GUfjAbVdyV5CW/JY2AU/z42X/37cNYqCYvvRif0+kmWnmONOFmoX/j2jUtB3ebAHtq67OgBZbiC3bVfZ4OgK2Ff/WEd8flbG2LaOSOFJ+kEu6FXpXAM6lkYYDbY7tMIaUYVOMKvYjDFhOmpc6EiYzdrzNvBwxHH0wkXEbdrHqYU+zVdI5fAPhilRT/3akaHSCTOSzNyYIlaXZ5erazMHFTm2SxXDE+NZE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e494ffd0-cbbb-4098-cd8f-08dd3fd3a8c3
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7660.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2025 19:40:46.0482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pxwJO40du7SZuDsfJMeZjDvXKCOFHJUz3+3Slfsw/jQHH3ryO99R5jTAORyj6zvxfoM9hurg6yaqdn39wGKsQX13iS7Fesn0ae3odXvoTuM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7099
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_04,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 adultscore=0
 malwarescore=0 spamscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501280144
X-Proofpoint-ORIG-GUID: ylYNJFbI1VtUb_NBF3jxGuPrZABX-Uz6
X-Proofpoint-GUID: ylYNJFbI1VtUb_NBF3jxGuPrZABX-Uz6


On 1/28/25 1:36 AM, David Hildenbrand wrote:
>> API
>> ===
>>
>> mshare does not introduce a new API. It instead uses existing APIs
>> to implement page table sharing. The steps to use this feature are:
>>
>> 1. Mount msharefs on /sys/fs/mshare -
>>          mount -t msharefs msharefs /sys/fs/mshare
>>
>> 2. mshare regions have alignment and size requirements. Start
>>     address for the region must be aligned to an address boundary and
>>     be a multiple of fixed size. This alignment and size requirement
>>     can be obtained by reading the file /sys/fs/mshare/mshare_info
>>     which returns a number in text format. mshare regions must be
>>     aligned to this boundary and be a multiple of this size.
>>
>> 3. For the process creating an mshare region:
>>          a. Create a file on /sys/fs/mshare, for example -
>>                  fd = open("/sys/fs/mshare/shareme",
>>                                  O_RDWR|O_CREAT|O_EXCL, 0600);
>>
>>          b. Establish the starting address and size of the region
>>                  struct mshare_info minfo;
>>
>>                  minfo.start = TB(2);
>>                  minfo.size = BUFFER_SIZE;
>>                  ioctl(fd, MSHAREFS_SET_SIZE, &minfo)
>
> We could set the size using ftruncate, just like for any other file. 
> It would have to be the first thing after creating the file, and 
> before we allow any other modifications.

I'll look into this.


>
> Idealy, we'd be able to get rid of the "start", use something 
> resaonable (e.g., TB(2)) internally, and allow processes to mmap() it 
> at different (suitably-aligned) addresses.
>
> I recall we discussed that in the past. Did you stumble over real 
> blockers such that we really must mmap() the file at the same address 
> in all processes? I recall some things around TLB flushing, but not 
> sure. So we might have to stick to an mmap address for now.

It's not hard to implement this. It does have the affect that rmap walks 
will find the internal VA rather than the actual VA for a given process. 
For TLB flushing this isn't a problem for the current implementation 
because all TLBs are flushed entirely. I don't know if there might be 
other complications. It does mean that an offset rather than address 
should be used when creating a mapping as you point out below.


>
> When using fallocate/stat to set/query the file size, we could end up 
> with:
>
> /*
>  * Set the address where this file can be mapped into processes. Other
>  * addresses are not supported for now, and mmap will fail. Changing the
>  * mmap address after mappings were already created is not supported.
>  */
> MSHAREFS_SET_MMAP_ADDRESS
> MSHAREFS_GET_MMAP_ADDRESS

I'll look into this, too.


>
>
>>
>>          c. Map some memory in the region
>>                  struct mshare_create mcreate;
>>
>>                  mcreate.addr = TB(2);
>
> Can we use the offset into the virtual file instead? We should be able 
> to perform that translation internally fairly easily I assume.

Yes, an offset would be preferable. Especially if mapping the same file 
at different VAs is implemented.


>
>>                  mcreate.size = BUFFER_SIZE;
>>                  mcreate.offset = 0;
>>                  mcreate.prot = PROT_READ | PROT_WRITE;
>>                  mcreate.flags = MAP_ANONYMOUS | MAP_SHARED | MAP_FIXED;
>>                  mcreate.fd = -1;
>>
>>                  ioctl(fd, MSHAREFS_CREATE_MAPPING, &mcreate)
>
> Would examples with multiple mappings work already in this version?
>
> Did you experiment with other mappings (e.g., ordinary shared file 
> mappings), and what are the blockers to make that fly?

Yes, multiple mappings works. And it's straightforward to make shared 
file mappings work. I have a patch where I basically just copied code 
from ksys_mmap_pgoff() into msharefs_create_mapping(). Needs some 
refactoring and finessing to make it a real patch.


>
>>
>>          d. Map the mshare region into the process
>>                  mmap((void *)TB(2), BUF_SIZE, PROT_READ | PROT_WRITE,
>>                          MAP_SHARED, fd, 0);
>>
>>          e. Write and read to mshared region normally.
>>
>> 4. For processes attaching an mshare region:
>>          a. Open the file on msharefs, for example -
>>                  fd = open("/sys/fs/mshare/shareme", O_RDWR);
>>
>>          b. Get information about mshare'd region from the file:
>>                  struct mshare_info minfo;
>>
>>                  ioctl(fd, MSHAREFS_GET_SIZE, &minfo);
>>
>>          c. Map the mshare'd region into the process
>>                  mmap(minfo.start, minfo.size,
>>                          PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
>>
>> 5. To delete the mshare region -
>>                  unlink("/sys/fs/mshare/shareme");
>>
>
> I recall discussions around cgroup accounting, OOM handling etc. I 
> thought the conclusion was that we need an "mshare process" where the 
> memory is accounted to, and once that process is killed (e.g., OOM), 
> it must tear down all mappings/pages etc.
>
> How does your design currently look like in that regard? E.g., how can 
> OOM handling make progress, how is cgroup accounting handled?


There was some discussion on this at last year's LSF/MM, but it seemed 
more like ideas rather than a conclusion on an approach. In any case, 
tearing down everything if an owning process is killed does not work for 
our internal use cases, and I think that was mentioned somewhere in 
discussions. Plus it seems to me that yanking the mappings away from the 
unsuspecting non-owner processes could be quite catastrophic. Shouldn't 
an mshare virtual file be treated like any other in-memory file? Or do 
such files get zapped somehow by OOM? Not saying we shouldn't do 
anything for OOM, but I'm not sure what the answer is.


Cgroups are tricky. At the mm alignment meeting last year a use case was 
brought up where it would be desirable to have all pagetable pages 
charged to one memcg rather than have them charged on a first touch 
basis. It was proposed that perhaps an mshare file could associated with 
a cgroup at the time it is created. I have figured out a way to do this 
but I'm not versed enough in cgroups to know if the approach is viable. 
The last three patches provided this functionality as well as 
functionality that ensures a newly faulted in page is charged to the 
current process. If everything, pagetable and faulted pages, should be 
charged to the same cgroup then more work is definitely required. 
Hopefully this provides enough context to move towards a complete solution.


Anthony


