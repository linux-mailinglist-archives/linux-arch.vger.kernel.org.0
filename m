Return-Path: <linux-arch+bounces-15659-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C0ADECF4314
	for <lists+linux-arch@lfdr.de>; Mon, 05 Jan 2026 15:42:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5AA5B31268D4
	for <lists+linux-arch@lfdr.de>; Mon,  5 Jan 2026 14:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55BC342C9D;
	Mon,  5 Jan 2026 14:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TnsRu8r+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="r7Ut4Cf5"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08412342CA2;
	Mon,  5 Jan 2026 14:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767622202; cv=fail; b=tNmOFnwjjgJG9iMrV1GUB7jk7A7lp6GOG0i1yxKD7TcCmGdHRaJiwEP2fOd7M6PCKCf0QddKFTQ4ye9E+hGzkx75tVUHJe5/La2o4r7T4K6WdkNuxlsbI7lTSGLux/X2ujnhxTWhMFCuB1j45It8qdt9iyhcPrA1RIdMppcJW14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767622202; c=relaxed/simple;
	bh=xqzjJCcujZeFNJzDwvqNPdhZIueDuJs/s0th0T29LQc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hExK6ko8ePKVFGwejW4U/RjlVPCXmPlmdz+ukylB8xCA9FkMFG6Y8iiK8FcV2b7nzHQ5Tww0AJClm5/f1g6v5PUnRIQEQfMcmyrMNxGekKf/SA9RSGEvofonbpZxwzDuBXJfAMApJos91hKUn6B2lEgJlcd/e/fR5jV4guQGDbs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TnsRu8r+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=r7Ut4Cf5; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6050RPq6328332;
	Mon, 5 Jan 2026 14:09:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=RYAUYyqe2lDuuWSeq6ZbF5i5s0Ne8XGCqzS5PafUdkM=; b=
	TnsRu8r+AFXKrvrpe5Jd5SlU21GFWEyd2HQvO8BWI6vztq6GNHZ4sofG7ocD/BxW
	gt3MJjZ2ncsBRf8+/+FdDyxP6aVV6UiBkY9oarSCNOOu61WWq2wh1S7tvu5KMXgs
	WFsVi6arWkAnPorxFcePn4/piRi4C6uHqFNukad6ZTyTIUazq0Mi76CoCkZzgbQR
	e8vecFigUsKHHTVjtI7pMRolE7kdWcj5+b418RHhb1cbwt1yfMaKOKWMIR/Ry52w
	Ri3f+d4inTddlP2ag8a2StipZxnxxNghgCNUpx8Wm8Iby69Kcp6pCgO1Yi1enhyQ
	fTtyRKe56RFWFvgcyuDCBw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bev1qss41-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Jan 2026 14:09:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 605D05Rd003234;
	Mon, 5 Jan 2026 14:09:27 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011002.outbound.protection.outlook.com [52.101.62.2])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4besj75jf9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Jan 2026 14:09:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bqL7jO3m3CREV9Sq7+VCwNqs9LWVlfBwCZS/XiezSQ4+8+KLiJkHTMw9S3KFJrTC6m46sTI7+rpdWHO7cKI128pQP3Xir6JIHzytHxh8FNi/whfh+jJO99w6eAzE++8jHUMmk2Y4JUkf8skl0qKQmNez9k3GkUSKL4y/dhwCyGWaks13u+IF1e7ToVM+Mn3kXdXV4MWx8EfaWF1g6GM/o14GnZACSsNOcZxOVlGARAAId0AFAkqgnTtnS+ho3fD5Ke074rW1upaBQRl8Vu6g9/h2/u0aLOlkfQS9vTRPI6bYNrpzg6VAgEdAMLoNfQFBz+AvoriXKE+EYLydn5HC/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RYAUYyqe2lDuuWSeq6ZbF5i5s0Ne8XGCqzS5PafUdkM=;
 b=eIZGAf2ZEYNCfeEoPpB2+1Aak69vGaiLKGejEDr2YafiTmn8VflaZsbsKcH6XlmVAjG3Obgtbyv9IuDXmM+oZew8cR5+pU/Q8rXJDFzTPNlczV16HNjUafk6b63HYgpNA8ycDfdadoBg87nAUJpDGXf+s7oF/oxEmJywbgETUNhlrQoEJMPNU4kXEw7BUYVe0Z0VDGyIKpAE2j+HegOz78cXuggqIgcVHgFBHNY//Eyo9v+qHzxhd3y7eiYTrD8jlN9/W7FLhONjvbuUNEHo82BGndove+DIJGXKi/dYQQ6v5GUwMRFEWa+hn9VNWK9b6eM1mI7GRKGSFt75M7rRbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RYAUYyqe2lDuuWSeq6ZbF5i5s0Ne8XGCqzS5PafUdkM=;
 b=r7Ut4Cf5L7GOthh1thWoFrVZog9LCz92Axqj5c/Rf3Zz1PGkx0YYXhD3+eCEa3ws/DmYD6mnfWL+XS4q4R7nE53QeNE/xL+JZynXeMx4n01El+aFjE9RROSUxDy6bzJrXW15THtaQLyC181VPttadsZFZL1fesJNj6CkQLlHpqM=
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54) by CH0PR10MB5081.namprd10.prod.outlook.com
 (2603:10b6:610:c2::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 14:09:24 +0000
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::ba87:9589:750c:6861]) by DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::ba87:9589:750c:6861%8]) with mapi id 15.20.9478.004; Mon, 5 Jan 2026
 14:09:24 +0000
Message-ID: <e5dbec93-8400-4e20-a6f6-b245765144f5@oracle.com>
Date: Mon, 5 Jan 2026 14:09:18 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] LoongArch: Make cpumask_of_node() robust against
 NUMA_NO_NODE
To: Huacai Chen <chenhuacai@kernel.org>
Cc: kernel@xen0n.name, jiaxun.yang@flygoat.com, tsbogend@alpha.franken.de,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, luto@kernel.org,
        peterz@infradead.org, arnd@arndb.de, x86@kernel.org,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-arch@vger.kernel.org,
        vulab@iscas.ac.cn, gregkh@linuxfoundation.org, rafael@kernel.org,
        dakr@kernel.org
References: <20260105100547.287332-1-john.g.garry@oracle.com>
 <20260105100547.287332-3-john.g.garry@oracle.com>
 <CAAhV-H4e9NOuO0ZyYfa1W1CyDnJVuuUDNEOavMS9o+h-u8PzLw@mail.gmail.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAAhV-H4e9NOuO0ZyYfa1W1CyDnJVuuUDNEOavMS9o+h-u8PzLw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0182.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::17) To DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPFEAFA21C69:EE_|CH0PR10MB5081:EE_
X-MS-Office365-Filtering-Correlation-Id: df9c0c7b-1c26-4bca-201e-08de4c640797
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VkJqLzRDcXlrZENnbmR2V1FHVDIwdkZ0Z2NVbUtkMHNPcUlmMDdlSTMvZmhH?=
 =?utf-8?B?VTY1Rmo0WTAxbzc3Q0VXdUV2cnhmT3VBUFd4dit1Z1BKZmljSjVIWDVtZHpG?=
 =?utf-8?B?T2p0RmtZYnV3Vlh5dytSY1VzRFlML1F0amhrVlM1Sm85Zis5akhyZUNaRzRD?=
 =?utf-8?B?ajJUSXUvLzdTSHIrcEJKNTRIQ2RWTEZKeVk5WW1FSVJmOE1QSkVwQlRscm1Y?=
 =?utf-8?B?emlMQ1NWbXNLZjFhNENkc3cxVTdxMm95OUE5WUd3MWpjNjIzcjFEeDFnYlhQ?=
 =?utf-8?B?djVRaUdKbmVQN1NRSTVYelRmc21Pa2JJRnlKTUFYdmVMaGcvemltZmR2ZkJB?=
 =?utf-8?B?TWQ3eHBrNlREeXZWY0RabkNKNzdmcVluTVRYYUh3eloybEhXWGhqVGdVSCtF?=
 =?utf-8?B?ajFvY0RTSVA2RTVyeHByMzIxS2l4ckJmeGU1cHJ2bEdMQjhjbXIzeHlJR2VX?=
 =?utf-8?B?Wlp6K3N0c25QTjlzeEQ3N3g5a3RWU1hoWWFCVXVhYjFVTWNPZ25LeFloOURT?=
 =?utf-8?B?SXRMbFNGSU1UWWVhaWZoenlWdHhEemwwa1lLcHY4MmxyTVpQdFVmaVhWK05r?=
 =?utf-8?B?YjJJektoOU9yZUlGVVZibFowS21BcE5XSGZIUEIwTitVK0R6V2ZTMXZURUlz?=
 =?utf-8?B?cGFDYVRLUjFzK255MmVybndPNUdkM3BoNWVuMTljeDFsMEpmYVNpQjZ0OGdM?=
 =?utf-8?B?dDE1dnowaHFwbFVOTWdGUlVjNzVNL3JqRWNZNmZKZ0NvditBZXpseFQyODBk?=
 =?utf-8?B?NTFPV1JmdzhobVYyby93TG51OWxiN1Nzc2hZd3lKOHB1Z3lWb09IMUNZOXNk?=
 =?utf-8?B?dzJoa0FjY1plWUUweWVNclRuSnBKMFRHb2F1ZnVzekpNaUJnamZpejN1L1RY?=
 =?utf-8?B?Y0pQSTZqZkVJNjVoRGVnSUdZblBUcm52UzFjZWd5dUk3SzlQUkJtYURDUURD?=
 =?utf-8?B?bnRIRWVVdEkrZDY1R2w1SDJLVVdWS3NMMnVzdEp5OHdHaU40S29zSXlNMDJQ?=
 =?utf-8?B?YXdTcGNlWGJ2YVFaRTMrWTllSFFMaGh4RnlWTy8zbCs0OURoRjYxdXlEWWlp?=
 =?utf-8?B?aUc5czlnREpUWWMyR0s5bnR2YnJsKzJoelduVXU5UVBJcjBZRnZjbWdYSS92?=
 =?utf-8?B?ZEhsZ1puN1c4NjJhNkVOY3BGcm12azFVVno4ZDI5b0xHaEhodmNyTk1MZytz?=
 =?utf-8?B?SHBTKzk5Wm12cllUS2hSMXlpQm41TUxzKzR2R0g3bDl1T0VOYkZ6WnE3SVhw?=
 =?utf-8?B?RlhjNlFJb3dNVDljK0s3QUI2UXY0M1dpZkI4S1lVeGNreUQ4Z1NiS0VQOXJC?=
 =?utf-8?B?eTg1TDlxS1RjekIwdERMVytIek1HL1JhQzY4RVArYkd6VDByV3FsZ1d5Nncr?=
 =?utf-8?B?VzFGMllHdWQrblhlNGIxNS9pL1BiSVV2UllMQjJ6QStvUDgzOENoMDNvMm1n?=
 =?utf-8?B?S2w2Q2V3SndoTWlHTGZtZXFVdHpTL3lZekdxQXdYY1ljUnhqTnp5YUxUUmh0?=
 =?utf-8?B?Q0FaNlU3SERhZWxyVUU0bi8zUHhmSUV3dFFTZWcvL2llSjByTHhpbllpRUg5?=
 =?utf-8?B?OStlVTBGSEtGN3FKVGtrWE50dzBxQU84aGV3cVRxNWxBWXhOV2t5YTRjTTQx?=
 =?utf-8?B?ZVEwa0dWemEzOG1kZGdwRmhmZG0rcFBGN2RpMFphSVpMQ3k2ZjhLMllMOW02?=
 =?utf-8?B?OWNPMngxNmcvbks4RC9IUmpNaWxuNkNpYnJ0aWs1R2F1ai83bkFPdjIrOFRY?=
 =?utf-8?B?bllxTFNjaE12MGk0Rm9KamprWlVmRnlLdG9xNUJlSllTWngrcS9xcWs2dU15?=
 =?utf-8?B?TmwwRE42NzlEK2NXU282RWg5VnVtdjZYQ1hwVnpscWt1TlZYYm1zSlZaenVC?=
 =?utf-8?B?VUFoQmVjU3Aya2tOL3FleXJYVjU5OVVZdGtJUVBWTmFhT1pFeDVQZng1dkVy?=
 =?utf-8?Q?wlioBiA7SKvSOnXKwS+QxVuyAsVWTwWr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFEAFA21C69.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RHhHZmhuZU05bDB3WE9WUUQ1Q3ZSYkFyZlBLRzJ2REtUZUxXTWUrd2htK1pY?=
 =?utf-8?B?TkwzMnRlckFtWHlyTS93RzJxdGhnSFBSSzBpTU1VUjVkYzFxMUt6Tlpod1Fr?=
 =?utf-8?B?cGkzdmVibDZCdy9kUnJtMTJpU2RHWUJUcUhDc0NlZm55SDh0MCtCa0RhQ0V5?=
 =?utf-8?B?TW50b0F6UVcrZjVDZEM5cCtSMk1BZmFuRG5BeXhKcm9PVWpJNndVd2w3dWcx?=
 =?utf-8?B?eU9McXdQUThwZC9ENXBLNUdwZ0p0elZPUXVjRkNGaVAzWFhVbTNVKzhVY0R5?=
 =?utf-8?B?MU5reTNqMjZ1NHgwaUEzRHhieFBXSk5scUx6d1orbHU3UkdnNzNwS3dvQlZu?=
 =?utf-8?B?cTROd2ZsQ2UzMEt1NS9zQU9BYXB6SGpLWWJOK1p4WWx0YUJnUGhzUkJ1SHNR?=
 =?utf-8?B?NTNwRTVIWUsvMk1PWGFwaldZMEVId1BMdnJhRzlDS1d2UVg1V2xndmY4M1Ry?=
 =?utf-8?B?dGFtM0JVV0ZEMmRSQU51cDVlRVdRa1ZZWlJZUGR1bkRvTVF0NTlSbWM1UkZm?=
 =?utf-8?B?d0NDMW42QldzK0VjQnc3VWJhZzl1T01VZ2grazRXVS9FQjBBc0xRcFNmM1U1?=
 =?utf-8?B?cnNjVDh6R1hhQXQ2NWNBTnRScGJ1eXVhV25VaWxncGlaRnRSZE9tdStXRDVH?=
 =?utf-8?B?WjRmMTRuQ0hZc0xZUEJBVkppeURzZTlIZU5LcHBiT1FGTnlHbE5oSWQxaTNx?=
 =?utf-8?B?TTdjMTU1YU1ETEVjVG9ZUzNsM0ZjSlZUeWthU2k2a2RhbHJUUjI0NzFxRy9i?=
 =?utf-8?B?enltTFMxTUFBcWtTRU94NWZtVis2blFtSk9aeWRYbmo5ZjVVMmp3MWRjOFA3?=
 =?utf-8?B?anp4RS9tN1d1S0U0NTFCYzdmZ2JMQVk0cTZaMm84U05qenV1WXhLbFhlcFdz?=
 =?utf-8?B?STM2OGsyakpYUk44UEJ0Mkp4dmhQZms3NE1FeEJVRmZlYjQ0TkhhaFI5MmRj?=
 =?utf-8?B?aVFUS1dQbnh3OFhBMzI0V0x5aXlXS0x2YUFqYm1MVzNoQjg4U2s2ZUdERzhu?=
 =?utf-8?B?SnU4MDFTM3dKRVB1dWZIWEVLck1ZclVITTJQTTd2LzFBUnBsQTlsdk5YdTNm?=
 =?utf-8?B?RHRFeGxiRlNCQjhDbkpJUkdidkVhRFJ1d0NDcVFRUDhDS1pCdWxKL25HRmd6?=
 =?utf-8?B?NUxsaE5vUVJ4NlE4bGZVVVFoRVdJZmYxM1MvR0RUSm02SkwzTGNWREJWMkxX?=
 =?utf-8?B?UUlkQVFkWjhoV0tHSW5ud0M5TGlDSXAyTm1HdzNsZHdHa0hselBmY0hydU5m?=
 =?utf-8?B?T0I5cUlnU29ET0lZUTloQ1pHQlhMUWR3TUZKRGQxellVZzZHRUR3RUUrSGJa?=
 =?utf-8?B?V1pYR1Vha2ZLT003N2pnWEVLQ2NWR1pnWHYxTlNDd08rbnlUZFl5bitGNitr?=
 =?utf-8?B?Q2FFbkg5TGVWRFAzTkFtT2xnWDJzLzB0V0NDUjVCMnV3U2NBc2ZpTTRpOGp0?=
 =?utf-8?B?VVJwT0l4Z2xsby9UVlNnZndrVG1SQ1RWMWdSOGg3bzVZNVNvL1B2SW1DYmZD?=
 =?utf-8?B?WEdSakJvcWtLUzN6OTlDdmt4SEUrajR3ZjVFQVJNcGVRS0lUbk11N0NoY3RW?=
 =?utf-8?B?Q3JCaythbzdEanJXQ1VmdGRzdTFMZjlSK0M3eTlUTkFqNVdsSXV2VkVIMnZP?=
 =?utf-8?B?VndyQnR5K1ZCYjh6eWZQRUIvZmNaNUVNVnBTMHRrSi9KRWNMMDNxVTdqb1F4?=
 =?utf-8?B?SHNCYXVOVWc3NTV0SGlncDBaV2NyOHNiVTFGblJEWmhiWE1JN1N4QmkvSy9V?=
 =?utf-8?B?dGpyMGJpZVJ5MWRVclJYRFdDUmlWdjh6cHA1OGhsaEtrR25KbXpGU0U2TSt0?=
 =?utf-8?B?Q1RtMjBYWUY4aWxoOWZKMXFhUndua0xDdzhKNzJvejV5a3UxdXBTSDlpUFNl?=
 =?utf-8?B?R1ByVzNTLzhIaVBCUVR0aHNNbDl4NHBabTZ0QzUyL3k1TE02REV1a0IwUXJ4?=
 =?utf-8?B?NG1Dek9GVmoweHovNk5QVUwzQ1h2aC9NWFdQZEVFcjF3WkVJTkFsZTZRU0Zp?=
 =?utf-8?B?R1VjQ3JmYXN0aGpSeGVPM0F5QUdHRU94WDU4ZDVSNUIvSU1BMEJrUWF3R1RS?=
 =?utf-8?B?bERHMEF1SHR5a0U2dVdKOWNDdUYwR3dadllUVWdhekxhQ1VjSXdGa1NaUnZv?=
 =?utf-8?B?dWpsUy9leEhVZjZGanZXSTk3VlNiUnpNL1FHbDg5SGJ0dnFpZGovZUhMZ1N1?=
 =?utf-8?B?VFVsdUZrUEd3OXd5V0dPY2tSa1lITXRETHhNR0dhVld2L3VtcGdTdXREeTF4?=
 =?utf-8?B?SUNObkE0OXBoQXMzdWFEYmJhQmJaYzFGWkgrNGNZTm55QloyWkNvQVNSLzlG?=
 =?utf-8?B?STI0Q0J0VHhVQmxHNFpKaGQ5anhoRS9LUGN3Qy9IQ0orNzl0VFBSRGxVcHBk?=
 =?utf-8?Q?+AerqiI/hFJaEOoY=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	uRK/pAzHIb4Q3TquKTJolazUkZ3x/4Yk5Tp4jn7d8HYhg9sU3LR2rrn9uT/mWsehaLuarnu+g2ueX1ibZo2zjN7tequ2voOX87YN96Lr+bk2CQUW1iL5NR/b6MmNHhxhvyvRwVjpLXS5bVUgMyhmU/Koy4qzJ8Yy+mRSTcSSL0t32135CyD1e220FV+ZEJJf/thkyOUDuWrU9046vXJF8wjxZUeI5MIxm/KXSmsCvHHIAo0o8uQhv/Qu2SfrXPKtDsVhj/j9icaj7MpLL9/Sxnva9r7c96WU56ONZdE0vVen3gcihDGGGPJqXEMwLlHmzEQ6KXTIXt/2VU9Mik219TiX78AKwFQ2TcqGTl+KUj0iUz63/LUJJegnvEuyYsPZk2W59P+6N4q+EG/h7fD8JcLL5mqzxZO55J5zVx1sOBYY/GdVxtSczY9t/Erohdt35CQ8//aUCU/02VpO4IDltLXWiQzVuML55C2QiorOP0YLXRjc9Q3qrNYbjl5NLlNdSbFv/ILJb4G21M+CNrjpx+Sa5zicXdYsCXTPshGccHqKQG1j0wYq17YycVkEYEUJBN8+annrWukh2Ttda1At/LwSKGRHT85Unijyhxi5TQI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df9c0c7b-1c26-4bca-201e-08de4c640797
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFEAFA21C69.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2026 14:09:24.3444
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aFZPley2iE81L0GcKMI1Hz8pWV8e7FhLno7WLnMHmqifR/EOALyYt0A5fTn5l/pB5srvsSA1hka7gjCFUAMHlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5081
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_01,2026-01-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2601050124
X-Proofpoint-GUID: CEZOcSAb51Zc2qAQZhecaxpULGivuJx_
X-Authority-Analysis: v=2.4 cv=Ec7FgfmC c=1 sm=1 tr=0 ts=695bc618 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=sIHEVLj31ub637hHCCAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: CEZOcSAb51Zc2qAQZhecaxpULGivuJx_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA1MDEyMyBTYWx0ZWRfX9Pcx/jNp2jaW
 xUWGRUUdu7A8/JPNCzBv9sAKNi5rrejBs2ke9dEIb3ue6gvJVhG8ib5KjomuzBb2omB3DMNUDF7
 bt4jOSB6UkK6s6rfR86rb32LYX1Iw+/lr1O58KMiXylLHIWniGw5jHAdnjNTL05q+Rtr8qSctxU
 RjVIz4BUf5j7SN7kvQn4yJHrpbA+UxBrdux+4LyywNUeUCpU8jMVOG2DpwPndLU4C52m+hV9iMS
 kWDY/UDu07LZcrRazpBrW4AeWOxVgyUBFndaEXB8DvfBQdHYRzJrfe3l0eVyaFWCvK5Seqh1chh
 74P//9wIAZtXNkNGb6VzHvSkJAeJ8zZtgybqlC58dKBnAnvQWLZvZ96tuACznr21FenY394yfr6
 7OpbUG//Ho5fqc0E+5XCLyS6HBPPg/BJ5Q0OGHWV5DIRhTfpRr21K4R795nOv8Fo9//Kb1QI40j
 DP/CA21HlQorQGODJkA==

On 05/01/2026 12:54, Huacai Chen wrote:
> Hi, John,
> 
> On Mon, Jan 5, 2026 at 6:07 PM John Garry <john.g.garry@oracle.com> wrote:
>>
>> The arch definition of cpumask_of_node() cannot handle NUMA_NO_NODE - which
>> is a valid index - so add a check for this.
>>
>> Signed-off-by: John Garry <john.g.garry@oracle.com>
>> ---
>>   arch/loongarch/include/asm/topology.h | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/loongarch/include/asm/topology.h b/arch/loongarch/include/asm/topology.h
>> index f06e7ff25bb7c..9857e4c20023c 100644
>> --- a/arch/loongarch/include/asm/topology.h
>> +++ b/arch/loongarch/include/asm/topology.h
>> @@ -12,7 +12,9 @@
>>
>>   extern cpumask_t cpus_on_node[];
>>
>> -#define cpumask_of_node(node)  (&cpus_on_node[node])
>> +#define cpumask_of_node(node)  ((node) == NUMA_NO_NODE ?       \
>> +                               cpu_all_mask :                  \
>> +                               &cpus_on_node[node])
> You can define it in one line, so does the MIPS version.
> 

ok, I can do it that way if you prefer. The reason I had it in flow was:
- a single line will overflow 80 characters, which some people still 
prefer not doing
- following example of other archs and general coding style to split 
macros functions across multiple lines.

Thanks,
John

