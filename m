Return-Path: <linux-arch+bounces-12161-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4DA8AC97D8
	for <lists+linux-arch@lfdr.de>; Sat, 31 May 2025 00:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A2291C202D8
	for <lists+linux-arch@lfdr.de>; Fri, 30 May 2025 22:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E37D27A105;
	Fri, 30 May 2025 22:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WKyrLwYH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="eiCq6LqF"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB5121CFFD;
	Fri, 30 May 2025 22:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748645273; cv=fail; b=PovvcbhEHrHvenFHUVQgkO/AzfTxPYfr/YVx1J2Z8G04nCLmjVgjxNF+blSa8J2fHRqe5BNTbnMnK26o1mOvCiDsjRlkIFXo7j4P9JTwNqyEo6GrMOzKopi4wQBIigWFTndScnRz0eloIToUnGm4odVJ9bYSeArj4DhLODtluCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748645273; c=relaxed/simple;
	bh=JtsJ4aZgUdtV7vQf8xhWJnWk2hs17ZEkNajkJnSRg/k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ws5ojEogYs+89cPCYUSS849OzMdleO7sY5AI11YziR1s4I2236Iyo65CaUhkwL8RyJDfyFeZS6T7UXuCxwOpiTKb0MJFn/b2YfYYIVRBeIcBdM1I1rkkdio4Apo4UjfRoMZUlOAJSmrnieO28mdHJfIAJqgL78qMagFUct43Sr0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WKyrLwYH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=eiCq6LqF; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54UJN5aA015887;
	Fri, 30 May 2025 22:47:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=ont+KvyDwoOB50khYeFgk5IamHI5t0E/PAQGU9KqkI0=; b=
	WKyrLwYH3n1nzhKtzojYEqgfZA2HBNGJgJ70kptLUcz7YhwsuCVGzapMbVr3jmx0
	bkoVeIH4WFhz/J1LVYELlJCk2RO3nCQXQOEJ+b7BMf6P4Uzk5LHZRpXN9cdJUZ83
	ykB/B/Fej/fP4tkbCfFse7vhUIfrf+CSzyZDS1xIu/oBgmLAXkDq48QhlTu7dKc9
	nQwJohaFJbx1xXfFGg3KLOXLi9TffTbd6y9TISUbUZAeUNqvZBU1pVXjNexygpno
	HyA62YjawaG/pe3y5hxdE7D5+gdAx9tV6BC+288bcYHxnAtT0sa7xM1xCv6R2S+r
	TbwfIAXoFIo76PUQwycZBA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v2pf2tdv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 May 2025 22:47:15 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54UMUunW025580;
	Fri, 30 May 2025 22:47:15 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46u4jm3y95-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 May 2025 22:47:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jdmGNh98tJo72noUdb6Hh+otDoL2s0ZHQoQuMyFXoqTEf8uojPlUl5Jr2hZ/Znb/eJYWoyjY142gzb++sXIntg7ZXUfnDf4j2A0KyfL8XHbqkoCfm8lIT872onqkxBhOGulSzAdOapDMKeu8f9XSJQDuvbo5cKfl02Zv7ZiNna1VxC2ZesbQYLNf9LocsGPOtRy4h0Y37DW7xIabe7XuO1/5vObYVs1F1F48jnlaHt0Zb3IQA0RspssXULHo6uzw/6oXU9tDJUKPcwl+6i77tzsjoXBQu717upXOgvHC10sJjlcJhE0iaEKEjgUXrHt1RkszoYtCt2CYGycY9tEucg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ont+KvyDwoOB50khYeFgk5IamHI5t0E/PAQGU9KqkI0=;
 b=ZAbPduag/rdmSIox/ICLJmKbmVTSnVu7suBlo5PY1/eFcOlGdO9wLQbJatJxXTYLXGTiOP0uO1LO+rs4pPJs+3yKlaJdq72ZfrnXGw0JQvwiX7voevZ+h8tnSpbDGhVEQX1lywvuqzQbkrZSHihRwmAXTOnkaB2QxaiVg1kWvQjTINZC2JtrEmO+EdRPZL6ss2gUK25BTRIcTlzCos7XLX6tcaAPm+Gsz1cCLPC62FZ2N1RHyXcVPpYJ29QNo8jJdz7Vloa6QTO72LW51wrMSn0NfrtGc59/TqAOBI4XlSrGh51A/8cRRJxE9vSBgv0JMItmScmAMI5cYf0iBSXWXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ont+KvyDwoOB50khYeFgk5IamHI5t0E/PAQGU9KqkI0=;
 b=eiCq6LqF/5ruWsvOEqESH93hj3yAEuoQ0SGVSiGil3CimyFQPP0C0w36TwJyAI9mfqc9NNM+o3buLlob+4Pb5yiXI4u8DjWEaZQP2vXD+UY5qsv3P8MCK0Flbqv54jruukp9teEveRCadZYyzuaYrXvfrJptA2Rr8V6i7pOz2IM=
Received: from MW6PR10MB7660.namprd10.prod.outlook.com (2603:10b6:303:24b::12)
 by SJ1PR10MB6002.namprd10.prod.outlook.com (2603:10b6:a03:45f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.40; Fri, 30 May
 2025 22:47:11 +0000
Received: from MW6PR10MB7660.namprd10.prod.outlook.com
 ([fe80::41fa:92d3:28b9:2a15]) by MW6PR10MB7660.namprd10.prod.outlook.com
 ([fe80::41fa:92d3:28b9:2a15%4]) with mapi id 15.20.8746.030; Fri, 30 May 2025
 22:47:10 +0000
Message-ID: <a66997b6-60e4-4bfc-9437-89924c2ed3aa@oracle.com>
Date: Fri, 30 May 2025 15:47:08 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/20] mm/mshare: flush all TLBs when updating PTEs in
 an mshare range
To: Jann Horn <jannh@google.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, markhemm@googlemail.com,
        viro@zeniv.linux.org.uk, david@redhat.com, khalid@kernel.org,
        andreyknvl@gmail.com, dave.hansen@intel.com, luto@kernel.org,
        brauner@kernel.org, arnd@arndb.de, ebiederm@xmission.com,
        catalin.marinas@arm.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhiramat@kernel.org,
        rostedt@goodmis.org, vasily.averin@linux.dev, xhao@linux.alibaba.com,
        pcc@google.com, neilb@suse.de, maz@kernel.org
References: <20250404021902.48863-1-anthony.yznaga@oracle.com>
 <20250404021902.48863-9-anthony.yznaga@oracle.com>
 <CAG48ez3cUZf+xOtP6UkkS2-CmOeo+3K5pvny0AFL_XBkHh5q_g@mail.gmail.com>
 <bd7d2ebe-f9be-437f-8cd8-683c809326f1@oracle.com>
 <CAG48ez3TTicKSxXyScmqq5Gg91+-KCSk80EccwkbvsQjLzjCFA@mail.gmail.com>
Content-Language: en-US
From: Anthony Yznaga <anthony.yznaga@oracle.com>
In-Reply-To: <CAG48ez3TTicKSxXyScmqq5Gg91+-KCSk80EccwkbvsQjLzjCFA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0199.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::24) To MW6PR10MB7660.namprd10.prod.outlook.com
 (2603:10b6:303:24b::12)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7660:EE_|SJ1PR10MB6002:EE_
X-MS-Office365-Filtering-Correlation-Id: caaca62e-d43e-4b58-70a0-08dd9fcbe9da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cHAvakVSVXZ0dUVoQjN2RUR4dWF6dm45L2ZYaGNJYWlyWVZGeGlEWFk5bUxM?=
 =?utf-8?B?bnZEZkdKSFNka25qbnFTK21GWDN4dmwyMWlLUjkzSE5xVVRHdzZQYmF2VkJW?=
 =?utf-8?B?Tzl2TDlybVl2MkVPUUJwTko2a1VoRmdBYkVQVmFGejI5U3k2d3RJT3Z2bWY1?=
 =?utf-8?B?U290SXBxNkx6RHZkVUlxcmpva0tLaGd5N0xtUC8yMmZYaCtNWjVkVllBZm4z?=
 =?utf-8?B?MkRxNStNQVhBR1BLRWlndTVYWmE2Z201SVBtNktMNGd2RUNlSkdvYkZ6dEFG?=
 =?utf-8?B?UHlteW5NMkNZYmZQODRQeHFGOFhic0NpR1VySEVTUGVuaWY4a1pkQVlBMFp2?=
 =?utf-8?B?OVQvLzlXeVhtRU5ydmtLTTJOclcyT3hvMWIxVGJoa2l1RHRaQStiNWxBbDI0?=
 =?utf-8?B?Q1RrYklRZnhHWGJpcnhVbitoM1o2ZTR0YitnZFp1R05HOVJUWEFpYzBOYlNJ?=
 =?utf-8?B?cE8zcFBLamdlaCt3cTZTRlVyU2c4a1hWdy9jWkJWMnlJUnFuSXJhQWozRkRV?=
 =?utf-8?B?WDY2bks4cGdHTWdYQUVCYkpPVXpSblg1MDJBQWl0VGdELzFhd0plTERqcjlu?=
 =?utf-8?B?RHhZZFQ3c0ZPL0lnWDB2VHRkdTl0c1BXMWdhcXo3RUhadHA3ZVYydmh0d3kv?=
 =?utf-8?B?QUxjRUtDVnp0U0xZbW1YenNrY0dKSSt5VU5md1BZaWl2bEtCRXRGbFNVanEw?=
 =?utf-8?B?TUNiVDBndnNkc1NkY045MGRtVkdsSmg1Y0J1ZE1iQTdyUmF2a0VJSnY1Wk10?=
 =?utf-8?B?VmRLMGdNbFMxSGRDU3NxL1MyRFpibEZLb09UeFlsc2hYbHJpU3JIL2pnUHdC?=
 =?utf-8?B?ZnFzaWg3eXlYQmxIZVNFcDBoQzkyZGc1MUdUNDBtZlA3cGRyYnlzTGxsOGc4?=
 =?utf-8?B?SENyTkwwUnh5aFhQUmpXQXpCeHN5WDZHZlVUWWt1RjYxcE9zSzNscDFpeWxV?=
 =?utf-8?B?SmpVYStTTTVxbXg3bXN3Nll1UThCVUw1b2JVa2dXSTV1VDdQNWdlWU9ieWVp?=
 =?utf-8?B?TzlGcHBSOVFYN2U5elN5ekkxeDJleFkwVUROOExYUG1LSUsveUFBU3luYjg0?=
 =?utf-8?B?NDZZY2tYTmpBeTlxWGdvNEFvdzYwemhKY01RQm5uRHRla3o0T0I4T0VsL2tl?=
 =?utf-8?B?c0lYZm9EQ240ZXJzV08vOVhVSkdVamtSUHB0M2x6Q2JnUnpaUGpURkxMTDlv?=
 =?utf-8?B?ZXRuYlNVYUQxQThGaHVKNk5MK2QvQmFueWtKd2wwNmRWd1hIc3d5SkpUVHJl?=
 =?utf-8?B?VVNBZWk0U2VjaFlpaDNGTGRGck1MdnJybk9GZWk1eFNqV1FXVWU4UUdzTUJ5?=
 =?utf-8?B?eUFvZjc1VkppbTgvVU1HNnhLKzNMTWY1dC9xUlQ0cXdaTXQzMHhHUnI3cEJL?=
 =?utf-8?B?SGFaRHFFSTN0UHZ4eElCUElnRHAxSXlweFJYeUpzR1NBWDFsWnhyeEw4d25K?=
 =?utf-8?B?V1M4R2V6TTZNblNDcHFNMW02RUJNNmNiNUtMT3RVMnZGL05hVTI5ZXB5N05l?=
 =?utf-8?B?UldnRWZWSXYvQ1N5UEhCK3NkZjR1V2J6U200L3hpRi9LY0dWcllPYUNqdzhH?=
 =?utf-8?B?L3FRVHdBMFRMYmhuWEV2bEI3NDlrV3JEUTUxYk9laTI0Q2N2U2grbHFDUXRm?=
 =?utf-8?B?NGNXWStNdlk3dENtMFdRZlNVWEh0VktSWURPZSttcTBjT2lGL2wrYUpESk5E?=
 =?utf-8?B?Mm5vL2tkcmY2Y2JKZ1hPQ3pZd0VEV2tOcHJTT1M0UnNXWHBKaFdaU1E0OHJI?=
 =?utf-8?B?NGJEMVNxRU9DZGZYNnRxekZUazlkNEtDMTJNYnpxaWlLS2lPSFpybkRkTFBk?=
 =?utf-8?B?aU9tRmwvNC9zeXMzbDNDNVRzcWpsVU5BTisveWlKZUViNHRhTmVoS24zSkFM?=
 =?utf-8?B?Y2JzWGVrVXVBV1NqVUhvY1QvSGQ0VmM2QkdtYm9Fcmc1Qjluc1RVS3R4QXp3?=
 =?utf-8?Q?X5SUXFeFASU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7660.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NjFFNlFtR1QxR3d3WUlzMEUvRVB4MWthdjF3SVVNczJoN3QxWWYyUTdTN2tF?=
 =?utf-8?B?NENzV0VaeCtqbEJsUGw2dFU4MVpmZzlFUFVJdlAveisvbjFLV1B4b3psbmJw?=
 =?utf-8?B?SFIyWFlSenllK3BrNWNGV28ycVNpdUhSV2p1YlRmeDl1M3lYRTJBWjQ3R1pF?=
 =?utf-8?B?L3hYcUdHTFZtMXVOYk43U2txQnlQajNqdWRLN0JxbUJsL05ibWw2eGlLWGM5?=
 =?utf-8?B?eGU4SXh4M3U5OEd2SlhtVlNpU3d3eDkvbm1kRlZrNURlSzAxWm02N3h1Wm51?=
 =?utf-8?B?L3NKdmdKWGdDUEF4dkl4UmkvblpraW5POTFHUkVSR3gwWVhJRmVLd1U0R01Q?=
 =?utf-8?B?NFN6TGtIMVVtUUlKZDhyMDVwODZQekZXdGlxR2lKNmlCQnpUSGVZY01NR3Er?=
 =?utf-8?B?Nit3eHY5OTB2S2lmVis2LzNFSGRSL2ROeXQ0dEtUTk40WVpGTUNpdDUyeTM0?=
 =?utf-8?B?K0s3b1NCbXhwRGZ4ZzFvb0cvdVNVUms0SldUTFdFSDRVYUYzdkNuc3h4T3Iw?=
 =?utf-8?B?LzQxV0dmYTFXakl3a1NYejcxREhkYStRdmg5WG0vZlYvdWYxN1EvdGVzT0Yz?=
 =?utf-8?B?MUNsSDVlT1NLUm1xUWM2VllVTjhUVlpiQlkycjNGZ2lTdVVVNDRZU0tHQTZX?=
 =?utf-8?B?YUdreGRRVlcxRTdTYXVZa295QkhPR1hDYVdhOXV5K0dLNVNseXppMFo2T0tQ?=
 =?utf-8?B?M2l2K09PL25aMFU4c2lMdmJUYXFSSmlnbGlzRG5XQ1BoTUdjek1hUEdwQVdT?=
 =?utf-8?B?QWVWZjZXM3dLRlRqd0V5cTNiT0lEZ0pjOXp3aVd5dGRFb245ZzY1ZU5xTnNO?=
 =?utf-8?B?M1pkWGN1amNUYy9kYUNtcjdYU3NwRHpLZHNRL2RtcCtWOGduM3d3eVVaWEpM?=
 =?utf-8?B?L2FXK1hoTDN1K3lQcEFCK3pscDJlSG41UkRQbis0a1BJWWx3T3dNeGZ3cjNX?=
 =?utf-8?B?TGFxUGtWdnVpUW1wdUlGL1N2ektkS1B0SjgxWjVqUDhqN0RUNHJtUWphZ0N3?=
 =?utf-8?B?VjJPOHpscUhJMnMvWVU2QjR6OWlsbmJzdkZ1ZU4vVCthOEtFVFJLMTRGVXVI?=
 =?utf-8?B?WmF4OVV4dWhWaDFnL1RIQUVZOEpjYVF0RkUxRWpTVXNVYWVpMnI0Umh5OUcr?=
 =?utf-8?B?QUhTcHlyY1ZMRTI4QVB6MnQyZEMyV21SVnVUdUhjdlg0VGlZeXNoM0RGanVi?=
 =?utf-8?B?eldZb3Q2M2ZqNTFwOVltbktLOG5oa1VLY3lVSVA4SnA4TzM2OWU3THlhbkpn?=
 =?utf-8?B?RS80c1B4OC9TL2dWQVgweWI2VEdyZWQzZEkxQm00Q1RmOUxzSktDb21WQzZo?=
 =?utf-8?B?cDloNXdTS3lQeHFRZ09iMk0xMGdmNHBkRkZITThxQXBpM05rVW1YUHgrZmtL?=
 =?utf-8?B?Ui82SWNvNDNLRDI1cEN4RHdzS3g1N1pmemFsTlJubjJDUmNyZkkrY1RWNG82?=
 =?utf-8?B?WDR0bkJnMEVsMVBZb2VmODR3OEsyMUFqaEs1Zno5aWFGWTFKc3YxVG4wYVRx?=
 =?utf-8?B?KzY0LzloSERQMnJpUXJya3NmanhzcjdSSzZaK3hqY1dMRDRmeTl6cWM1VFNx?=
 =?utf-8?B?VEpwQWRvbjRYUm4zUCt0RFlZZWEyZkIrTExBb1NZUE1DdUNUQy9jQnpHMDMx?=
 =?utf-8?B?cTZlOVV4WWlyUm5XamhRNjlsNEZxM3VhcEFoNGhYeldxNXAySGd6NzM1bmdm?=
 =?utf-8?B?eEIrbmV2NUZGeDd2RStlWFpDWkZXdXJ6Rk14YWFJRitTVG5QelB4eHRJTjJy?=
 =?utf-8?B?TTFFSmVTSHpWNlExMU9CNmhuaU9wcmR4b1B5cTZpdUtkbE5QZ3dkY3AyL3cz?=
 =?utf-8?B?YjdaTHlBZXZZdHpyQkYxbW1jVzJ6cjVGSmF6ZEFMUnl1WFczOGpodWE4cDNW?=
 =?utf-8?B?RkRBcFhlNFozWmRzeGxYUkVQZkI1NnNyRDROYUdHL2FHOG4yM3hjazU3WHZl?=
 =?utf-8?B?a0h0V2NkalFkNmJpV20yOXZIaU9yajZpKzZUTGJROE5HcWhLL3I0eWttQXJZ?=
 =?utf-8?B?dExJeTV2MUNqYllaa3V4aGxHS2JLUVJJNVc4M2R1ODVFMjVZZkZiYW1BbEd3?=
 =?utf-8?B?blBHSHRpSy9ETWpGZHBvdEthQ3RBQmpvZHNiRXRHaEo3QlJpTDQwVzZnSjFJ?=
 =?utf-8?B?RG9BdnZHVlZPdDNmSy9PNHVFcW5XZDNiSmtsMERBTlE4bm1HejBQdHd6VXFr?=
 =?utf-8?B?ZUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lt32MYzJbeU+QctQ259veymWINmNOSB0ktKu4Cz+zHIub3DqcvquEOiDFo4W15s7MtLXpjJEWoEb8adnELCMhalx7iTpSnMFKi88mGgQT0s08l3kjYNO3yRAE+M4A0FtjMTviLEYm/VhOTL0w7wgrrB1L3xe2GhOy0gpxQ84cZDgPRyUwLOHB+R/64KHxrG+Wuzy358TejRrtyuujh+FwK+/J3oJgrWSY/DjZDhDIgj9BUzUPrCfnAyg/kaglF0EHv3Q0o+dW/ZPOXfsd7HDieaJcK/ZvHCM7SvfeoNmbduy0fLs7V3W2GEr12gfT93YOmx4z74hjT8zZ+oMvrHOTeYes+Bxe4bIandPD0kcGOSjUOG7P7Y7vxSdsaaEh8VWUkoUThxzG474hwq5NjeiKF7l5LW3bgDTG409uFdAPm2erJCxylWGBgFqvDwGlBJyPAt85sFAQs7JIxVwBUKEKKf+3NCo+LYP9lpcKS1AWDt9GuQy9xL8tJ5u3BRcgpXcNGwkMfjBRBHVBrnejILqejfH4AMFdkfsBA/hwJOwaNsMf/Ti/I0lojHMUOxnz4U4MUSZgT5+7y2ymrhOhTNTuxCQz3cvT9nwzluqimxtOpo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: caaca62e-d43e-4b58-70a0-08dd9fcbe9da
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7660.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 22:47:10.8468
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rXJ8QBDnbifc1uMGk5ixjrYApqBEnMBc1JAdg93DHKiiFgzqFcm30Q0eViwKYAxvzJb6WUshqJjhMkb1FJMiPd/et3+EnuPeQH61XF2U+bc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB6002
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-30_10,2025-05-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 phishscore=0
 adultscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505300204
X-Proofpoint-ORIG-GUID: 9t1cfMHLB6VjweNyFwtjrg0_cbhSUtcs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTMwMDIwNCBTYWx0ZWRfX4GgHH+vK0Vqq V/g186IqUX8mZBReTPhHbuN9/SdVShLeGYO5Qvb+pujzniQXHudYwPmqX8sFIuS92gyqVyzrNHC Eg4YBMGOSftpsrBMJZrtBIuyrLDZHIujpY6Owtt6hwH9sZ8YQ42W7qTaQ5sH39tmwmIDclnPkdk
 qGTTUncI7x2MpZIG5S0Va99exA4HKZbNlUJ+yObvRDF7w/E97U72O/IUE1qvfZYfgeCDgPs/Qbu if9qKzFARV7RYEgfYa6uddyepYBsEBmzfnyw3UxEoR1GMrrBlYR/cGWUCyvKDedgIzhAwLS4Wey mWEIdG+TlC3eLXnvlV827/TKRJ5xRIiz4V9+V9bdsa2Zqby+n2IEDO1nX9ac2aJtxKUUJ5SzGnB
 26vZXhfIQvwtgEwRkKP/7L6cxKr+FydrRx775wBNgakG/ZYffOIZ23zTQ0Yf079wejzX4MLL
X-Proofpoint-GUID: 9t1cfMHLB6VjweNyFwtjrg0_cbhSUtcs
X-Authority-Analysis: v=2.4 cv=TdeWtQQh c=1 sm=1 tr=0 ts=683a3573 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=eeJ_F2nzhkZ3xsAi-J0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13207



On 5/30/25 10:46 AM, Jann Horn wrote:
> On Fri, May 30, 2025 at 6:30 PM Anthony Yznaga
> <anthony.yznaga@oracle.com> wrote:
>> On 5/30/25 7:41 AM, Jann Horn wrote:
>>> On Fri, Apr 4, 2025 at 4:18 AM Anthony Yznaga <anthony.yznaga@oracle.com> wrote:
>>>> Unlike the mm of a task, an mshare host mm is not updated on context
>>>> switch. In particular this means that mm_cpumask is never updated
>>>> which results in TLB flushes for updates to mshare PTEs only being
>>>> done on the local CPU. To ensure entries are flushed for non-local
>>>> TLBs, set up an mmu notifier on the mshare mm and use the
>>>> .arch_invalidate_secondary_tlbs callback to flush all TLBs.
>>>> arch_invalidate_secondary_tlbs guarantees that TLB entries will be
>>>> flushed before pages are freed when unmapping pages in an mshare region.
>>>
>>> Thanks for working on this, I think this is a really nice feature.
>>>
>>> An issue that I think this series doesn't address is:
>>> There could be mmu_notifiers (for things like KVM or SVA IOMMU) that
>>> want to be notified on changes to an mshare VMA; if those are not
>>> invoked, we could get UAF of page contents. So either we propagate MMU
>>> notifier invocations in the host mm into the mshare regions that use
>>> it, or we'd have to somehow prevent a process from using MMU notifiers
>>> and mshare at the same time.
>>
>> Thanks, Jann. I've noted this as an issue. Ultimately I think the
>> notifiers calls will need to be propagated. It's going to be tricky, but
>> I have some ideas.
> 
> Very naively I think you could basically register your own notifier on
> the host mm that has notifier callbacks vaguely like this that walk
> the rmap of the mshare file and invoke nested mmu notifiers on each
> VMA that maps the file, basically like unmap_mapping_pages() except
> that you replace unmap_mapping_range_vma() with a notifier invocation?
> 
> static int mshare_mmu_notifier_invalidate_range_start(struct mmu_notifier *mn,
>      const struct mmu_notifier_range *range)
> {
>    struct vm_area_struct *vma;
>    pgoff_t first_index, last_index;
> 
>    if (range->end < host_mm->mmap_base)
>      return 0;
>    first_index = (max(range->start, host_mm->mmap_base) -
> host_mm->mmap_base) / PAGE_SIZE;
>    last_index = (range->end - host_mm->mmap_base) / PAGE_SIZE;
>    i_mmap_lock_read(mapping);
>    vma_interval_tree_foreach(vma, &mapping->i_mmap, first_index, last_index) {
>      struct mmu_notifier_range nested_range;
> 
>      [... same math as in unmap_mapping_range_tree ...]
>      mmu_notifier_range_init(&nested_range, range->event, vma->vm_mm,
> nested_start, nested_end);
>      mmu_notifier_invalidate_range_start(&nested_range);
>    }
>    i_mmap_unlock_read(mapping);
> }
> 
> And ensure that when mm_take_all_locks() encounters an mshare VMA, it
> basically recursively does mm_take_all_locks() on the mshare host mm?
> 
> I think that might be enough to make it work, and the rest beyond that
> would be optimizations?

I figured the vma interval tree would need to be walked. I hadn't 
considered mm_take_all_locks(), though. This is definitely a good 
starting point. Thanks for this!


