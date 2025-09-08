Return-Path: <linux-arch+bounces-13410-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD95B49975
	for <lists+linux-arch@lfdr.de>; Mon,  8 Sep 2025 21:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ADFD1B27048
	for <lists+linux-arch@lfdr.de>; Mon,  8 Sep 2025 19:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38DCB2376EB;
	Mon,  8 Sep 2025 19:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="C41TvhKD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aXQit2Mc"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1FB28399;
	Mon,  8 Sep 2025 19:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757358654; cv=fail; b=AFD3xWSm1VxjCdtLQ/iyP6it7XdbaqvSukOW2tuW/dU1aWv5iClQeAyP6EwijiPK8ZqP/U4ZKSGGkBTAEFZNB1hc8L/BVn0ZLpi1W8D9Dv2vHtN3GefcvzwpTdhoIF+JBkTSJlkmNBGbkAyVpcsE5f8O718jFyHIPlP3LJA8Fuo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757358654; c=relaxed/simple;
	bh=GcFoNKSix6LPzVmymyX3gtE1ThgyeE6tIBnoFKMkTCE=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Njb3aRLGIDZVziY8b2mL5udhFEqS9TYDdb/0M9AuH5+VnENvos0KzzfeVddrG3HcIIcZCCeu0392b8ubkyH804Zm4AJS3Xcs/EHiP+0moxJ5Tbj5Q/mtpnvwwa7SUuBqD88lmWZm4f5uC1VPuqjRuUOe77beuxVdveKxqTJL9ts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=C41TvhKD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aXQit2Mc; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 588Hfqf0023827;
	Mon, 8 Sep 2025 19:09:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=M5lCHM2BXFp5PND4Fl4O2N8zW/sxOBXRJH32aPZAeDM=; b=
	C41TvhKDcmy8msdS7OFN+gtsWEmj4zsRYh7B3ke50eE4oRXz8KnN5TzrMXH6yr7K
	/ZjbPoRpu8q0W79oALkqs9ENUVrDAf+mQCfLf65xyx+nD5FDDDmlMpCpiX3ZseIy
	zci5z3SHchMjTo2tHsQgN1X5H+5DBEg/CB+V5gUMYASlY30slkiUxKmKQWMXkMUm
	Bngrur65Ry6ESh4kCMo36mXwEBYobSMZov0M4tLF9I+XsJ3F2Rhree4wT5+t/3tx
	RVeBug+B+NamXFSStLdgcfYg+DysyBbdUv18kv7AkABOhA6CQxcyBB5Nlx6YbbKG
	OTSkR7Su4uffI81I27FBvA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49226srcry-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Sep 2025 19:09:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 588HmvL5026344;
	Mon, 8 Sep 2025 19:09:49 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 490bd8mfpj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Sep 2025 19:09:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bt3FBqjUZdXQiaeDQRtYjj0qiLhx3RaqTbN3moTN0zUTbOjxHe7rQMPPJyANgBhKByJHbhCY5xKIb68zG/TpMLxZ1s3bIMnX5KthC00cKslNp8A4rQMMRopLnJiHOvcnervv8e5+baeH+xrwkhTlw0IGxp8ZMFCTc2FQOuNfDjqSTdThUNpfsCqh7VEFs4d6x+6t+IuYyddC7iXav2O488oWfgny6ZiN2bIsE1nRx18B19pLoUlAd0fxyz/IOexzGywEH90b0RNb4jei58nVK1Sn1y0Pmq0XJTDbuO8Mxp3Gak5b1D8zyEIle9dGbUoxK8Q81pi36jhJ8cFZGZs9zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M5lCHM2BXFp5PND4Fl4O2N8zW/sxOBXRJH32aPZAeDM=;
 b=Wf6wCqgspvw6VESUH8nnLL8PEkrrRD+5exP5KHAhQcY4mD/3/9LwzerOYeNIEvhd4yCK2kpR1U4zfNZg6TOEWlMg4wFCARasXG3D5422qRXMCoTPbLQX+77MP54bInkRolvaOP6SxF6taG+LYrnIl8ab2CP+N5xQr4DbWlhJkvLGsX99z9jzIGPcpEggcQnNoBefX1cJDVXZYmniEWxwds6OFRoIHx3n2OxKp6zosDxm8ktjrEBKHLYqMuPkuEh/LdCbSSi5v2CvAeqX/9MjIvfDW8nfh3xoOI5rSUMP2ih2uyzvUwBy3Grcw8kjS9UReFOsjjolhPQx1ybLjb5h8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M5lCHM2BXFp5PND4Fl4O2N8zW/sxOBXRJH32aPZAeDM=;
 b=aXQit2McsXeSeYUxqbYHlErAA67U1r6j7A+NWet1BWCaIwHRertCuTYcZKSXZhIpNXEj/DlPbUhT11Hne6UF8ZlP3XAOWcMmm4h7+BbFxs9vv8MPQGPZRLCey/EDUCedL7wb7Pjp09uqUYnmv/QGtj8EuhfPuWPBdjUl1Lbwdsc=
Received: from MW6PR10MB7660.namprd10.prod.outlook.com (2603:10b6:303:24b::12)
 by BLAPR10MB5058.namprd10.prod.outlook.com (2603:10b6:208:320::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 8 Sep
 2025 19:09:45 +0000
Received: from MW6PR10MB7660.namprd10.prod.outlook.com
 ([fe80::41fa:92d3:28b9:2a15]) by MW6PR10MB7660.namprd10.prod.outlook.com
 ([fe80::41fa:92d3:28b9:2a15%5]) with mapi id 15.20.9094.021; Mon, 8 Sep 2025
 19:09:45 +0000
Message-ID: <db2f17fd-6711-4521-8d2a-73c3fd8d914e@oracle.com>
Date: Mon, 8 Sep 2025 12:09:40 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/22] mm: Add msharefs filesystem
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org, andreyknvl@gmail.com, arnd@arndb.de,
        bp@alien8.de, brauner@kernel.org, bsegall@google.com, corbet@lwn.net,
        dave.hansen@linux.intel.com, david@redhat.com,
        dietmar.eggemann@arm.com, ebiederm@xmission.com, hpa@zytor.com,
        jakub.wartak@mailbox.org, jannh@google.com, juri.lelli@redhat.com,
        khalid@kernel.org, linyongting@bytedance.com,
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
 <20250820010415.699353-2-anthony.yznaga@oracle.com>
 <lgwf5d2y2ok2f52l7xi6klln4hbncnoyn2s2jdi3k4wi5ngfz4@kbtqjwirdnqj>
Content-Language: en-US
From: Anthony Yznaga <anthony.yznaga@oracle.com>
In-Reply-To: <lgwf5d2y2ok2f52l7xi6klln4hbncnoyn2s2jdi3k4wi5ngfz4@kbtqjwirdnqj>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR13CA0013.namprd13.prod.outlook.com
 (2603:10b6:a03:180::26) To MW6PR10MB7660.namprd10.prod.outlook.com
 (2603:10b6:303:24b::12)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7660:EE_|BLAPR10MB5058:EE_
X-MS-Office365-Filtering-Correlation-Id: 50b3792d-f962-4254-99c6-08ddef0b45d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dkUrc0pqQnlGd0Rha0VLZ0ZoUnFFNTZEWkllOXpEd1ZMRXZhM29UekI3QWhl?=
 =?utf-8?B?Mko4YWpaT1VjMGw0Z3RDQ1BXNy9wZVArV0wzRzVad0U3Q3IxNng1ZzJSOURl?=
 =?utf-8?B?NE01QTVJL2N0aXljY1l6UC9aTmhFV0l1Z3Q0emgydUFVbW5DMlFIU1pHRHpi?=
 =?utf-8?B?NCtrZnlScVJ4L2U5MitDL1l1R3pwaDBOY1gzdGY0SmFvRzRoSFptblRJcnhE?=
 =?utf-8?B?bzd6NUR2THdhcWlFU2dNWjZiVnpyQkxvNGYwZHFocjArS2tFbjJKcnlLVTkz?=
 =?utf-8?B?ZFVXWVNQYloydDMzZ0F2NWFNdmREWTQyQnJnODByaCs1T3M2OGdnK0Y5U0hH?=
 =?utf-8?B?Y0lybkFrSDRaemNvajNycm1SYU5qSjF5a3RBZ08wM0tMMFhpSklUeHNZS3NM?=
 =?utf-8?B?d3U4Y1JUakRGUDdnbTBkelQvelYwRnBoYURJRzJ0NFVHTlVrTWJLZHZ0dzBR?=
 =?utf-8?B?UENjOUhJckRzNnpDNldNdHdjM0E5MVRHMnUrRW90dmhxakN3OHF1M2txQjZ5?=
 =?utf-8?B?Y0JIUVRTZlNDdHFuQTlsNmZzZlozYjZ3VVNSNTVuV1prUHcvelZ1cjlwa3NX?=
 =?utf-8?B?ZHpobFRYTDJCWEI2eCtXYkFEN0VQc24wVzFjRGlHUWUrWENvWmszL0hSdDJo?=
 =?utf-8?B?dFp1WXYvNC9WL25pUElhNk9GVUJCVk00anl1bXFsU0x3NDB5cmRXTDJYc0pR?=
 =?utf-8?B?cFkvb2dWbWQwSFQvUmVqQitlVVVFUFB0SFhNWWxrTG1oZXhHekF6ZndsS1k4?=
 =?utf-8?B?VDdsQWRsOE1UM292ejU3aUdMMTk4ODJITDlabi9NNTNXSEJpN3Njakw5M29q?=
 =?utf-8?B?N3loTFl4eUV3QW85MWExdEREdzJVam5pZHZKN3czaFIyciticlptMWdSVHYz?=
 =?utf-8?B?SDVEekZDdTYxNGQzWjR2T2xKSHI1TnBra2JmQ2VmVVdiTlBqTjV0N2tKZUNq?=
 =?utf-8?B?NEVLaXowQVJlWjJkMEt0aEo4b3ZvUmdzZ05LZjFFWmV3cG9vUmN0YVUxazE5?=
 =?utf-8?B?Q09mN3ROQmtmRW56a2d2aGNqM0oxL3JucmNlSVY0cWxhcFkxTFVNUExUT0Nh?=
 =?utf-8?B?S3BnMzloK2svKy90RlpOZkI3cDYzZU5wTlN1enZjOXBBK3ZUOGFPb1o2MklG?=
 =?utf-8?B?OGdncThJVkhZWis4a0N5ZkRoQzVnZ0FEQy9JWDN5b21OQ1hUdW9nT2NQaVZO?=
 =?utf-8?B?R0ZwVi9WL3RyRk9nWkcxcDIzdXBpdVV6VzlZS0thZDVROEd1WjU2azI3VzdC?=
 =?utf-8?B?QzdjQWhCUnRWWkxhalYrS0JUVEx1cFQ0MVp4N1FIWis0RHJlY2ZKVVoyQzlM?=
 =?utf-8?B?VmFPOGhPdkZzVGpXTWVIZExxNTlyL0ovT1c0Vld1ZXR2WWtEcFhOMmNTdEtW?=
 =?utf-8?B?NFBhb0RCUEF3TXlJUWZnSXJXTEJQbHprQ3I2dzVFdVNPSUkvWVBuS1dqeHB6?=
 =?utf-8?B?SXBsLy8zbDBKZUYrVE1acHN6dmN4TXQrN1FOWnNMbFpqdGNlLzFQekx0c0c1?=
 =?utf-8?B?WlE4S1JhRWxId3ZudmRjbDh0MGw3S2NiSitkMko4TDVFYU9VUCt3SW5XZzFm?=
 =?utf-8?B?Z2xkTFZpSXVDNWZkcFlGRzJFUUdlaEV6dEtCWGJmSHZOM2NzSmR3Q1NpMWQ2?=
 =?utf-8?B?UGJWNEVZd2p4K20xWU1qWFhsZ1ZXZEpHcEJpVDBrZ25iVzU2aGhTTm9VcC9I?=
 =?utf-8?B?QzBnSkNJZzd3dVVDbUl0NW5UbE9MOS94QjRpNzhBa013dVI1UE5rd24vRUpL?=
 =?utf-8?B?bnNWT1gzQ0dUbytIaEpVSElVaDg1dXhRTFFsY1hHTXVZc0xxcGMvK3BFT01L?=
 =?utf-8?B?cHdDVkhIamdCbWxxL1hJSlQxeHJWUVliMmRVUzhnUURpNGE4L1pJL3BSWWQw?=
 =?utf-8?B?YkVLd3I1WUVES0xLYnFIdWJEV3hQRm4rR0xoMmFzWURHMnZSTXpyNkxyZklY?=
 =?utf-8?B?M08yNWZnMEh2T0Q1WHErRmJ3TnR1ZXZOQjMyRTRNQTU2MU1NU3hhUHV2MEZ5?=
 =?utf-8?B?aUxHWXZpMmlRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7660.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bitrdFVtNzZRb2Nrc3JSOHE1dHM3cmpVUEFYcmJtTUdFWk4vUnZHWTFscWUr?=
 =?utf-8?B?R2YvL1lpR2NFMGtKTmNpL2l3NDhiMUNlblBrSkU2UkFqb1JvTlhBU0NRQzJD?=
 =?utf-8?B?TllJMFpEWjMwQnlhdWpTbE1OV2JFZys4eUhjcW5PQlNlcDMza1Y0d0RNeVUr?=
 =?utf-8?B?NTAycjMxbmp5aWVzZ3lOQjhqQkNqbWJBdzVFTXRObjcxejhUSW1yaEFoV2ZM?=
 =?utf-8?B?M25tbUpNdzhuVnFjdUR3cUh0b0hzd0owbng1M015RndQTys5a0hTTW1lZld0?=
 =?utf-8?B?MTZSd1JabERrNFI4NVdPdkFGcGsvUlN1R2taaGd0ckpiUXZrdnBKNVR6eTlo?=
 =?utf-8?B?QVVGd2l2cTV5REpxdzlsUS9yNFBQWDVzcU1FbmdJQWJUWk5COW44MkxkR1dz?=
 =?utf-8?B?N2VoUk40bXFEV2FUVjg3UmRyWEF3eFhJa3I3c1A3ZlQvYk9qdVhuMHRWTzll?=
 =?utf-8?B?NHBBZWRmUlA3WUw2bUorbUhqeURwNGxxWmFjUktNS0sxOEF0cVFQd3JqVWpO?=
 =?utf-8?B?YnBZUFR2R2x1ZTRNeGxScXJQd3Z3NXBHZWphTW1IUXVwVmdPQUtCS2VKdGhP?=
 =?utf-8?B?ZmJ5NUJybUtsdjhrVGI3WFBhUnE5ekNjMys4SmFOKzduMTJuL3NXV2ZKYTJH?=
 =?utf-8?B?N1lWa2VBa3o4cXlVTXFvM2M3QzBwRWFFc096MFJzTHA2Uk1CUHMycFVpa2p1?=
 =?utf-8?B?RU5UYmFyN05ZMnJQazZobG5kWi9qM2V5RldodEVQb050WlFTdVo0alhWdnNK?=
 =?utf-8?B?ekxpSXh4Ym9nbGhEcTBPdUg4SHl3dUNacWQ0R0lFR1AvSFlhN2VVRFhFZFYv?=
 =?utf-8?B?RlFqc2ptZEUzSHRVbllNN3d6QnVLWGcyL2c4N0ZJaFFjOFNmQkpTS28yaXBM?=
 =?utf-8?B?VXVPMENYaUFpUHRReHp3RTU1b3J3b3hsek42RjFaUEtPQm83Tmo5R0preStp?=
 =?utf-8?B?UjJEdnZiMHhRblh0ZWN5U3FzZWpDcUVJYktMalZzVm9mQWp0cnpieEVwWCsx?=
 =?utf-8?B?S2hkYkYyYkMvVHF4VEJjRkgrU1ZnVzdJY1RQTGZhMG41QVRRRFAxYzZsSDVn?=
 =?utf-8?B?VlROcjJvcnpXV2xnRU1hQkQ5OVQvaHMzZm1xdUQ4M1o4RmJuNytuaVZPbm14?=
 =?utf-8?B?UTExNnhWT3U1V3BoZ3BhQ2t0cWNFYlJHVkJVcDFkTVJpNEpiRUk1a3hiRkdP?=
 =?utf-8?B?UzhFSEJLcktGVklZL1ZmbENPRkJZWUhaN1M1cVlNUGpzWUJsaXpER2hSTXBE?=
 =?utf-8?B?cjJqd2tGZ1ZuaDhhUVRsOGsvWnZ2MnlxTDQrS3cxZ3RWdEhycnl3a29uOGxZ?=
 =?utf-8?B?NFR5OFNlaUFVckRDUFFOQi8xbmRQSGlBTTY5K1hCTlNWeWc0ckpiVTJHUzJ2?=
 =?utf-8?B?Mk9sUkRQUWhDS2d5bFRZb3ZzWG85MXBsSDZMQWhqaUc4ckVNWG8wNS9vT2dn?=
 =?utf-8?B?SFhxUW9DZnZaNVkwR0RVZVY4aVhNdndRMTFlbEFsZG5vVkF4NEkrVlpVZlli?=
 =?utf-8?B?eWVlenNJM0RyNms2cHRRKzdxV1BDWlc5azVWUlRjN1NuWnRCNjdwYzRvRnlx?=
 =?utf-8?B?eGsvVWJtdC9hdXhkdERmYVV1N2VkUzNHSlZFUHlkK2ZqMmRjRFdJcVJEYWhp?=
 =?utf-8?B?U0FTQ3E1emdGcGdPRVFTd2YzQTJZMzQ1cElxcXU1aVB4dkJWS1cwK05rMEtt?=
 =?utf-8?B?Wld1bXNKQ3N3NGRPbWlKU3Z4eWRnRHVkWHJDc24rdjNaZUwrTFh2UHdwcE93?=
 =?utf-8?B?cTlVUDZiaEZkN1orVkhjNmpSOGFicXFubUhBRndhY1RMYVRpbEVYVDYxUm9V?=
 =?utf-8?B?TWt5YXM0K2FVNSs2UXZxRnVNK3JFOTEzdWNYWEljektpMGxpczFUdG5HOHc5?=
 =?utf-8?B?ckRtZDY1SzVmWmhKM2RDaGZMM1l5bXRwRXBmUTB0YzhLQzNJeWpvc0RQcWhP?=
 =?utf-8?B?R2taUy8zdER1WXNQUGk3M3c4aG45MWdZd3FoVGRXa3gwZTlDenZia1EySm1z?=
 =?utf-8?B?TlNtNURDNzlpN3R4R0d3NjlxNmRtNFNSMkhKakpUTnliQTBiTG1BMHV5bUFq?=
 =?utf-8?B?VjR3QWpBb0NReDUrSCs4Z3JCSjJvNUw0NXVSajBSSWQxWS90TWxtSkdLalhO?=
 =?utf-8?B?aHdNQURwZVoxejl0aG5QaFBPSWhrMEtwQlpZODdvU0JPY1VheFc5QlBNaDY1?=
 =?utf-8?B?VWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rbS94WjPuh7pOSKa6U5UAa3mJmjrvOAq9xKETxCS5CbRB5rzCBcyxf642WVaC9vZPEjKlhTNEeDf5E7frC3sUDoa58yETXR93RJQRn6ENNIZoP6wTzaK4Q1GHzPBoYK9aG786u9GC0m2IsRlEQxNz6tpTx0GPWI3jYhcCIKh0GL6wN3EzMOVjcmEiBncseE3gnR3l0B0xeNEHDJuqES8Q6e3afTuS1Y7QPw4J9tOrsFa4M/YP9QUab15EA/ctRhEhdXyvD55/XJl3IbLBM9V1AmtN4yoqzdqXIVuFoPgMMnrssLOqcoPtjQ/OzKf22Pa+867K1Kn+aa+ASBkDLxGLbY2FHur+zZ6g/EBO9e0f4G0SREGlOn6+/HIyxeboGuf9K8O+XGNI3vbH5wcyP8EF8HQG0jJ4D1E/AsI0WaLZYot0OElqXqaQcni6GEBq7l+d2pqc9+1o55jDVdlmQpG6XnnetwjmL3xrKjhzFW7hrssKDusW64xqMGfTyAduY+/ll6zH059FWGoH1qtIOu2u/3tFJsngW1VPgr2Kmeg+O/Q5ULm9db5J+fHqpQHTDuYo7hpKGZ6HZlNnjOOjnicEfZbm3OzaR7zBkzXVBuoWK8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50b3792d-f962-4254-99c6-08ddef0b45d5
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7660.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 19:09:45.3561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GOwnrYu6F4V94jV1y8LHzHWksSwksVgY4ihnJyu104vE88Os+XYh/DITIVDQEdcXBR3H/j0jdIfPXJkUyknJ1qt1mqnAhRQP5tVNB1UUbDA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5058
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509080189
X-Authority-Analysis: v=2.4 cv=QeRmvtbv c=1 sm=1 tr=0 ts=68bf29fe b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8
 a=NeSQVN01N5FM5_svAXAA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13602
X-Proofpoint-ORIG-GUID: OnGwgNgwg-e37oNfmBq-KXqbEeNhRuT7
X-Proofpoint-GUID: OnGwgNgwg-e37oNfmBq-KXqbEeNhRuT7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1OCBTYWx0ZWRfXxlrs0T2mdBN5
 hE1D+dVdImNbIE2YAquJkP1HSg/5Gl03anFJJTcq8CkeShJWXP3GCn/YL0lbaoy2ELaegt51iMj
 HQK/HlvvUeLjvwigcgaWXTEOiC46U87nHy6P+iUSSZVcq/rb/Oxon/u0jF8wzu+F+BUT3P8aCjT
 b6Oz5LuO8Vtj1u/8ljM0o6NoKupQoE6UVub7Z+/eMvVHL/xTLzvGEIaHETfgvCQsna2Q6RU9Sd1
 btX9c+bCJdshW0Pbf5U75eh1FPwkB/vj1zlyX4nyZjsTYq6PFM26WYZy7cYZmeE0HpVjdJmIqZq
 OCgAtSgY8EIQCnqyhvQr9MVF6vOXxShVuONqhUNF7NQlEvgF6NoCDcR73bsJVNVbUA6VxBlrHmk
 gIYV+YsaxazbZ5xTeUbIrR8Y5ccHYQ==



On 9/8/25 11:29 AM, Liam R. Howlett wrote:
> * Anthony Yznaga <anthony.yznaga@oracle.com> [250819 21:04]:
>> From: Khalid Aziz <khalid@kernel.org>
>>
>> Add a pseudo filesystem that contains files and page table sharing
>> information that enables processes to share page table entries.
>> This patch adds the basic filesystem that can be mounted, a
>> CONFIG_MSHARE option to enable the feature, and documentation.
>>
>> Signed-off-by: Khalid Aziz <khalid@kernel.org>
>> Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
>> ---
>>   Documentation/filesystems/index.rst    |  1 +
>>   Documentation/filesystems/msharefs.rst | 96 +++++++++++++++++++++++++
>>   include/uapi/linux/magic.h             |  1 +
>>   mm/Kconfig                             | 11 +++
>>   mm/Makefile                            |  4 ++
>>   mm/mshare.c                            | 97 ++++++++++++++++++++++++++
>>   6 files changed, 210 insertions(+)
>>   create mode 100644 Documentation/filesystems/msharefs.rst
>>   create mode 100644 mm/mshare.c
>>
>> diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
>> index 11a599387266..dcd6605eb228 100644
>> --- a/Documentation/filesystems/index.rst
>> +++ b/Documentation/filesystems/index.rst
>> @@ -102,6 +102,7 @@ Documentation for filesystem implementations.
>>      fuse-passthrough
>>      inotify
>>      isofs
>> +   msharefs
>>      nilfs2
>>      nfs/index
>>      ntfs3
>> diff --git a/Documentation/filesystems/msharefs.rst b/Documentation/filesystems/msharefs.rst
>> new file mode 100644
>> index 000000000000..3e5b7d531821
>> --- /dev/null
>> +++ b/Documentation/filesystems/msharefs.rst
>> @@ -0,0 +1,96 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +
>> +=====================================================
>> +Msharefs - A filesystem to support shared page tables
>> +=====================================================
>> +
>> +What is msharefs?
>> +-----------------
>> +
>> +msharefs is a pseudo filesystem that allows multiple processes to
>> +share page table entries for shared pages. To enable support for
>> +msharefs the kernel must be compiled with CONFIG_MSHARE set.
>> +
>> +msharefs is typically mounted like this::
>> +
>> +	mount -t msharefs none /sys/fs/mshare
>> +
>> +A file created on msharefs creates a new shared region where all
>> +processes mapping that region will map it using shared page table
>> +entries. Once the size of the region has been established via
>> +ftruncate() or fallocate(), the region can be mapped into processes
>> +and ioctls used to map and unmap objects within it. Note that an
>> +msharefs file is a control file and accessing mapped objects within
>> +a shared region through read or write of the file is not permitted.
>> +
>> +How to use mshare
>> +-----------------
>> +
>> +Here are the basic steps for using mshare:
>> +
>> +  1. Mount msharefs on /sys/fs/mshare::
>> +
>> +	mount -t msharefs msharefs /sys/fs/mshare
>> +
>> +  2. mshare regions have alignment and size requirements. Start
>> +     address for the region must be aligned to an address boundary and
>> +     be a multiple of fixed size. This alignment and size requirement
>> +     can be obtained by reading the file ``/sys/fs/mshare/mshare_info``
>> +     which returns a number in text format. mshare regions must be
>> +     aligned to this boundary and be a multiple of this size.
>> +
>> +  3. For the process creating an mshare region:
>> +
>> +    a. Create a file on /sys/fs/mshare, for example::
>> +
>> +        fd = open("/sys/fs/mshare/shareme",
>> +                        O_RDWR|O_CREAT|O_EXCL, 0600);
>> +
>> +    b. Establish the size of the region::
>> +
>> +        fallocate(fd, 0, 0, BUF_SIZE);
>> +
>> +      or::
>> +
>> +        ftruncate(fd, BUF_SIZE);
>> +
>> +    c. Map some memory in the region::
>> +
>> +	struct mshare_create mcreate;
>> +
>> +	mcreate.region_offset = 0;
>> +	mcreate.size = BUF_SIZE;
>> +	mcreate.offset = 0;
>> +	mcreate.prot = PROT_READ | PROT_WRITE;
>> +	mcreate.flags = MAP_ANONYMOUS | MAP_SHARED | MAP_FIXED;
>> +	mcreate.fd = -1;
>> +
>> +	ioctl(fd, MSHAREFS_CREATE_MAPPING, &mcreate);
>> +
>> +    d. Map the mshare region into the process::
>> +
>> +	mmap(NULL, BUF_SIZE,
>> +		PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
>> +
>> +    e. Write and read to mshared region normally.
>> +
>> +
>> +  4. For processes attaching an mshare region:
>> +
>> +    a. Open the msharefs file, for example::
>> +
>> +	fd = open("/sys/fs/mshare/shareme", O_RDWR);
>> +
>> +    b. Get the size of the mshare region from the file::
>> +
>> +        fstat(fd, &sb);
>> +        mshare_size = sb.st_size;
>> +
>> +    c. Map the mshare region into the process::
>> +
>> +	mmap(NULL, mshare_size,
>> +		PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
>> +
>> +  5. To delete the mshare region::
>> +
>> +		unlink("/sys/fs/mshare/shareme");
>> diff --git a/include/uapi/linux/magic.h b/include/uapi/linux/magic.h
>> index bb575f3ab45e..e53dd6063cba 100644
>> --- a/include/uapi/linux/magic.h
>> +++ b/include/uapi/linux/magic.h
>> @@ -103,5 +103,6 @@
>>   #define DEVMEM_MAGIC		0x454d444d	/* "DMEM" */
>>   #define SECRETMEM_MAGIC		0x5345434d	/* "SECM" */
>>   #define PID_FS_MAGIC		0x50494446	/* "PIDF" */
>> +#define MSHARE_MAGIC		0x4d534852	/* "MSHR" */
>>   
>>   #endif /* __LINUX_MAGIC_H__ */
>> diff --git a/mm/Kconfig b/mm/Kconfig
>> index 4108bcd96784..8b50e9785729 100644
>> --- a/mm/Kconfig
>> +++ b/mm/Kconfig
>> @@ -1400,6 +1400,17 @@ config PT_RECLAIM
>>   config FIND_NORMAL_PAGE
>>   	def_bool n
>>   
>> +config MSHARE
>> +	bool "Mshare"
>> +	depends on MMU
>> +	help
>> +	  Enable msharefs: A pseudo filesystem that allows multiple processes
>> +	  to share kernel resources for mapping shared pages. A file created on
>> +	  msharefs represents a shared region where all processes mapping that
>> +	  region will map objects within it with shared page table entries and
>> +	  VMAs. Ioctls are used to configure and map objects into the shared
>> +	  region.
>> +
>>   source "mm/damon/Kconfig"
>>   
>>   endmenu
>> diff --git a/mm/Makefile b/mm/Makefile
>> index ef54aa615d9d..4af111b29c68 100644
>> --- a/mm/Makefile
>> +++ b/mm/Makefile
>> @@ -48,6 +48,10 @@ ifdef CONFIG_64BIT
>>   mmu-$(CONFIG_MMU)	+= mseal.o
>>   endif
>>   
>> +ifdef CONFIG_MSHARE
>> +mmu-$(CONFIG_MMU)	+= mshare.o
>> +endif
>> +
>>   obj-y			:= filemap.o mempool.o oom_kill.o fadvise.o \
>>   			   maccess.o page-writeback.o folio-compat.o \
>>   			   readahead.o swap.o truncate.o vmscan.o shrinker.o \
>> diff --git a/mm/mshare.c b/mm/mshare.c
>> new file mode 100644
>> index 000000000000..f703af49ec81
>> --- /dev/null
>> +++ b/mm/mshare.c
>> @@ -0,0 +1,97 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Enable cooperating processes to share page table between
>> + * them to reduce the extra memory consumed by multiple copies
>> + * of page tables.
>> + *
>> + * This code adds an in-memory filesystem - msharefs.
>> + * msharefs is used to manage page table sharing
>> + *
>> + *
>> + * Copyright (C) 2024 Oracle Corp. All rights reserved.
>> + * Author:	Khalid Aziz <khalid@kernel.org>
> 
> Probably needs a new year or year range and another author?

Yes. I'll make sure the next series is updated.

> 
>> + *
>> + */
>> +
>> +#include <linux/fs.h>
>> +#include <linux/fs_context.h>
>> +#include <uapi/linux/magic.h>
>> +
>> +static const struct file_operations msharefs_file_operations = {
>> +	.open			= simple_open,
>> +};
>> +
>> +static const struct super_operations mshare_s_ops = {
>> +	.statfs		= simple_statfs,
>> +};
>> +
>> +static int
>> +msharefs_fill_super(struct super_block *sb, struct fs_context *fc)
>> +{
>> +	struct inode *inode;
>> +
>> +	sb->s_blocksize		= PAGE_SIZE;
>> +	sb->s_blocksize_bits	= PAGE_SHIFT;
>> +	sb->s_maxbytes		= MAX_LFS_FILESIZE;
>> +	sb->s_magic		= MSHARE_MAGIC;
>> +	sb->s_op		= &mshare_s_ops;
>> +	sb->s_time_gran		= 1;
>> +
>> +	inode = new_inode(sb);
>> +	if (!inode)
>> +		return -ENOMEM;
>> +
>> +	inode->i_ino = 1;
>> +	inode->i_mode = S_IFDIR | 0777;
>> +	simple_inode_init_ts(inode);
>> +	inode->i_op = &simple_dir_inode_operations;
>> +	inode->i_fop = &simple_dir_operations;
>> +	set_nlink(inode, 2);
>> +
>> +	sb->s_root = d_make_root(inode);
>> +	if (!sb->s_root)
>> +		return -ENOMEM;
> 
> I don't know the recovery here, but what about inode and inode link
> count?

If d_make_root() returns NULL it will have called iput_final(inode) 
which takes care of freeing the inode.

> 
>> +
>> +	return 0;
>> +}
>> +
>> +static int
>> +msharefs_get_tree(struct fs_context *fc)
>> +{
>> +	return get_tree_nodev(fc, msharefs_fill_super);
>> +}
>> +
>> +static const struct fs_context_operations msharefs_context_ops = {
>> +	.get_tree	= msharefs_get_tree,
>> +};
>> +
>> +static int
>> +mshare_init_fs_context(struct fs_context *fc)
>> +{
>> +	fc->ops = &msharefs_context_ops;
>> +	return 0;
>> +}
>> +
>> +static struct file_system_type mshare_fs = {
>> +	.name			= "msharefs",
>> +	.init_fs_context	= mshare_init_fs_context,
>> +	.kill_sb		= kill_litter_super,
>> +};
>> +
>> +static int __init
>> +mshare_init(void)
>> +{
>> +	int ret;
>> +
>> +	ret = sysfs_create_mount_point(fs_kobj, "mshare");
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = register_filesystem(&mshare_fs);
>> +	if (ret)
>> +		sysfs_remove_mount_point(fs_kobj, "mshare");
>> +
>> +	return ret;
>> +}
>> +
>> +core_initcall(mshare_init);
>> -- 
>> 2.47.1
>>


