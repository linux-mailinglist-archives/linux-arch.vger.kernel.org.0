Return-Path: <linux-arch+bounces-13409-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 363C3B49950
	for <lists+linux-arch@lfdr.de>; Mon,  8 Sep 2025 21:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D88762077E5
	for <lists+linux-arch@lfdr.de>; Mon,  8 Sep 2025 19:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47EB922ACF3;
	Mon,  8 Sep 2025 19:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="sJmgO401";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XJDpCiiG"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FD91E8324;
	Mon,  8 Sep 2025 19:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757358325; cv=fail; b=tTrNXbpbApCnVn4rj5o9xR1SjX53wkAiMQCAKRxCYoFwauRmOM/Gxl0di72CeMDyZN0pBL/y4MfIaHnY47wXg8SBbSZNLMKD5LbRM1sP05BauAOA/bfUnjWR41dKox/p3OBs8xByiL4EgUDrELtnv6IboRxt4kAd91ZI2nk2Fvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757358325; c=relaxed/simple;
	bh=veKL9bdeN+pznQLgzM2pC3e8GRrPZAjopRU/LOXP/p8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jub9L7nYEqr/DsUgGdxuYgvL/RilbUCVOGocFVdAgalsMh2eSL1JpE9coLmqPL6C43nw721jmuVz/J9QtXOp9EKAti0Vi3xb6Yv0JTqrTrWfDlzr+PwCHD6PfcG2OXx1x4NlP6sZKDnkOyW89RPE/vk0Ar1Bbl1otWOWIYd/7vc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=sJmgO401; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XJDpCiiG; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 588Hg0fv013390;
	Mon, 8 Sep 2025 19:04:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=k3t++NZk/S40ie/t/3BM5d1zbJggguNlrFUjDBaY8Zk=; b=
	sJmgO401gJf4RCqQOUta1UE376ug9Yx8cxq4Xk7iKbrIaYhPIuVvfrSPHJNyIMVj
	Of086jBXglylIIpZSHMdNgRVtAmLvLq6XnW8fkN+b0F96Uvb8zvTB2Ty6JR4V9OX
	E+CJFE+8tFVqjvMNGd7RwlK8BrIb/ckWTqqqfhUiQS0BjFGGtgVI3SGWsIeexhcM
	WUVutAq+FiMwh+tCnENYGtmg1MbM8XqJBgrF6ywO9S7xWaPx/SsbjJw8ESx7K6k7
	hgdsrrg0joV3m5qGYDfn0eGcp7fziD15NC4eylcMr3isCVFkrYbrd0ELkluA/J6j
	tFuNhRjTZ85UOvt9mMRqQw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4922960bjp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Sep 2025 19:04:08 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 588J2OKo032803;
	Mon, 8 Sep 2025 19:04:07 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2071.outbound.protection.outlook.com [40.107.236.71])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 490bd9m1sf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Sep 2025 19:04:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zUcWjczpR5HkyWimtlu6NlWTVS4mwOays1UQIKq1ri3FIvmR7qsNJb+7+UHwPfNs7vxnZbcNNKhLFhnZIssIrPxkQvoYRoa3YknOYtqu2HSVth8GwABMHqo8meUglTcSabFFLTzBBbN42GZvj/4fjZg5Tu6nwrgWYYO8Q+J736PxEtMBDa3Jm/3iuiany7T13Y1WZahJya0rLiwTKPI9wtWjpVeFgd7hzr/9xiEQ+xRQGydRBeBLoX5uV1yTr+I0SSM3IzbBrivehLlGN/bf6j2hGSPmoSuB9oYqOvT/SxO/imaDUK2qT+JK/jCZzP9c505DOJ8PKdXeS2MNNivTeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k3t++NZk/S40ie/t/3BM5d1zbJggguNlrFUjDBaY8Zk=;
 b=N2PSmH0YekY+FDHV7DGfHLd3Jw65BEacwlH+qeJBfN2qHvxTot4W96IJRCoVfLSF6uitvE/nohTNRkEvRtRXkW9Tnbk+BBqd/CQfF+5dxjnpowL4/V44527huNUVi8EK0iXzjvSUybgxJQXpHD9rH/0zZ1lr/zPwEwAJb6X7vrH4OLdiDlX4TiFn/A1uwmp9AeierJ3Z2bIWq6MyaKP0dxSuvKw1VeUXM4RpahnF+rTk6URk69H1LIsCkVPuAA5/ZKxLqSyehzm0s/es4kU3/gvO8DqyhspMlkHcsj1DFET70oq0ofbHEkhhjqrzDpVoMkhmPADwI4sHiINK69Hauw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k3t++NZk/S40ie/t/3BM5d1zbJggguNlrFUjDBaY8Zk=;
 b=XJDpCiiGxWuhr4lbCV5VBVjxBWKPiQ7ElNxO/48W6hSK/h20MQfnZlkHb2AKSzbizLx7nbqSHz7xWtEathvRpwKgR2U7FLctP2P+Pv0yRixg+tWJYvc1/Q6SszHgAoHBzp07m7TtKhu0Ml6GwChXfHZZ5UunhXm2qQrbyOxMmD0=
Received: from MW6PR10MB7660.namprd10.prod.outlook.com (2603:10b6:303:24b::12)
 by CH3PR10MB7283.namprd10.prod.outlook.com (2603:10b6:610:12f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 8 Sep
 2025 19:04:03 +0000
Received: from MW6PR10MB7660.namprd10.prod.outlook.com
 ([fe80::41fa:92d3:28b9:2a15]) by MW6PR10MB7660.namprd10.prod.outlook.com
 ([fe80::41fa:92d3:28b9:2a15%5]) with mapi id 15.20.9094.021; Mon, 8 Sep 2025
 19:04:01 +0000
Message-ID: <0aaff7a6-9fd7-4bee-80c1-d39826633da3@oracle.com>
Date: Mon, 8 Sep 2025 12:03:56 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/22] mm/mshare: Add a vma flag to indicate an mshare
 region
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
 <20250820010415.699353-7-anthony.yznaga@oracle.com>
 <5c43116f-fef9-426d-8c90-1a3a129f3d20@redhat.com>
 <b99517e5-7b4b-494e-8ec6-918f933ddf50@oracle.com>
 <fcaa9042-3e64-4719-a8ab-a08d10b6e1a1@redhat.com>
Content-Language: en-US
From: Anthony Yznaga <anthony.yznaga@oracle.com>
In-Reply-To: <fcaa9042-3e64-4719-a8ab-a08d10b6e1a1@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR20CA0035.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::48) To MW6PR10MB7660.namprd10.prod.outlook.com
 (2603:10b6:303:24b::12)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7660:EE_|CH3PR10MB7283:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cdb9140-bd3a-473c-4432-08ddef0a78ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Wnhsdm5ISzVNazBUSldwVlUwY1Mvam1KZGJmN2F4Wkh5a2I1VTVyNnV6ZHVE?=
 =?utf-8?B?VkYyUUcrR3J3OFA0cnU3b00zeGUrTnRzQ0NjeDZyb1Z2QW5iVFVRMkRrY1I5?=
 =?utf-8?B?RXlEcHZ0OHFpZFhxdlU0YitkRExlZU1wREZQTW9idDdtZ0N1OHdiajRJdzla?=
 =?utf-8?B?bzlialFVOE0vaVJBWWM0Rmx1Z3o2YmgwVUdNWFlObGd2dTZXMVZSbURCNkV3?=
 =?utf-8?B?NTJDTGlDeUxuV092cWt4ZEgvUmtVVVFoWS9YTUtpbGJ3bnF6K0lxaVYzUkVh?=
 =?utf-8?B?aENXRS9oc0xDZ0FRUXFnOG84MDU2bkJ1NW1tOUR5bUY1S2Z6WXIyMnlnRVBo?=
 =?utf-8?B?K2t5YWJRMm1WejB4b2JUdGRDME5IOXQ4VERqNW5aTDdxWEh4T0o5c0lJVlA1?=
 =?utf-8?B?ekVneDRWYUk4WTRHUVAxZGpWY3czNlRnQjNBaU41UzdNNWNnMm83NllPRGNT?=
 =?utf-8?B?NnBJSktHVjVtTkQvQmdNSTZpZnFrVTN2WVZ2ME1IdjM5Q0lMcFUzbldyZEJU?=
 =?utf-8?B?UFdBS0tkcHNUMGhoalh1YXE1VjZUSGt0Y3Ivd29TVTllZkZreEYrYmU2NXNt?=
 =?utf-8?B?eGswT2lCTW5qMGt3NXpkVDY4RGs3YW1rZlI3SWkwSytZTXI0NVBNcHVZK3Nv?=
 =?utf-8?B?Z1JaUnE2RGJ0YnpubW1hU1JjdDREUUpyQ1FPWm44RHdZR3ROZCtzNDdVVGNR?=
 =?utf-8?B?d3ZKZjY0QlEzT1EzZHN0a3VKakJ2TVVDWHdvcWtlRUZyRjZNUlBPSGd6R3VC?=
 =?utf-8?B?QURIUVg4YzdqZHM0K1VtaHduK1I5K3Y4ZmFjdU53YncxVXBTSlk3Z1g1S1Fz?=
 =?utf-8?B?eCtCMkp0Q1JFTW1pQkxxVDRRclZQbkZucmpUcUlObGp1cUpPdXgvM2QzNlhC?=
 =?utf-8?B?TGJlOWxGNVI3aGM3bHVpRi8wTTlHY2pOOUlWdDlmQ3BoNGdaVnVDN3llMHo5?=
 =?utf-8?B?QzcrR0FkcThpRmZNSU40cmxoemNkdHp4dFRoenptU041S05tdDBRSGZFMVZl?=
 =?utf-8?B?c0F5QlN2eGh0disvRURlMGJkeWIrUlZWNlZoM200YmxldGZjYmZwL1p4Wmc2?=
 =?utf-8?B?MlFkcWpFd24zRlp0SmFTL0VMaEhtYm5mR3BpNzNFcXFvRDRYbEZFZXVmRFNX?=
 =?utf-8?B?UGNQS0haRDdRQ3lmSnFYbVBiUWF0ZUNVWXQ3SmxubjVhNEVSS01YQ0N3b0xH?=
 =?utf-8?B?SURZMnlSU25aNmZWMzJCRjlzMkFJYWlVLzVkRDN6WHd1UXBiUG0zUTkxbURJ?=
 =?utf-8?B?VzhIOFFIa0ZaTlVuUk9kNUpPQXBDeHlYNlM5REtZb2RGWnFTY2hCZ0pOem5C?=
 =?utf-8?B?c3BEeDR6NERyTnNuSFdaVWlZa1IzSkZ3aHl6NzdVRGlqMlFFNllWUUVFcWlz?=
 =?utf-8?B?RnhCREJwaGxMNC83RThXcS9La1REU3NLeUNpOWtJbTd5RC83cHdzYlJFQzVE?=
 =?utf-8?B?ZkZjSUhYckRIeHhDS3NHbjF5blh5UEswR290bU1zQS9xV1dpSmM0bDFnSERo?=
 =?utf-8?B?REhTZ1BDSmcvUkZwWi9KdmEySVZoT3Q3MHROZjZ3ZXpJNk45MFEyam5rZFVh?=
 =?utf-8?B?WUVmOGRxckNSTUxJcWpxY3BoV2crN2E0Qm8reVRHTDhwYnhRa0RJQjNMNHFx?=
 =?utf-8?B?aDBOd2NtY2JXcWszRHRMaXR6NElqVGpNTEdZMTRBYzZkUDlENWhjVlA5b21o?=
 =?utf-8?B?RTR3eTl3d2w0YXgrLzdkTk1IWktZdm9MaXFKUVRkMDgrN2hUWFV3TldoUGxD?=
 =?utf-8?B?d3R2N0VVWHllNm5WcDg1WnI5dEVBN3FMYlNmTS8yRVpIaUpzM0RxUTFHSkZk?=
 =?utf-8?B?RWFzNC9Ja0JteE5mVnVPVS80bnByT05PL0Ira0luWnRsWVVsTkZLNXV6WEFp?=
 =?utf-8?B?M3FuZFlPZHVVL3pzaXhLa29XM2pRd2xEN2NRRmp1Vml6dEZjeTd6SkVNeDV0?=
 =?utf-8?Q?B9eaoL/tVTE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7660.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ekhzbVozdXdJMlQxa1gzQmowQThCVEdvd2xEU3VIbDdndFJSRXN0dWJ3M2ln?=
 =?utf-8?B?UE5uUXFxc3psTitzYzl6MmRnbldjUjErQkNXK1JSQ0NQOGFiQ25EcmRJTGM1?=
 =?utf-8?B?VExMWEZqSCtVbkpRS3lkZVcrZHhYbC9SUHFBU1RaTWsxcWNjYS9yUnR0QmhR?=
 =?utf-8?B?dFZaNWphWXN1aklxMDZmeWJDU0lKbGJmeDVCU1lrL1NsSVFFSURqUVBsbzk2?=
 =?utf-8?B?WDI0dXppVFZQNmpJMEhnaDE0OVlVdXJvam5kdUJHT0k4TWZkcHlsc21jaEht?=
 =?utf-8?B?K3QwSHZyMFVWNndtSjN2L2xQc0ppSjRyM3dHdkNOQndvZEZ2Mzc1ZCtES1Vm?=
 =?utf-8?B?ai9VOERPM29vekFxM3lLejZSK3M1THNqWXlFcFViQVFlUXcxanZ2SkZEQkNU?=
 =?utf-8?B?aGxvR3FJYm9kUEJWOTUzRnd0NGwvcjdCN2hMT0FUOEhkNWMvRjJzek1Hanhk?=
 =?utf-8?B?ZmVRRmFJajhIMkQrQzBnUDhUUlJBNis3SS9pMS9McmFCZUNISVlwdXpFb2wy?=
 =?utf-8?B?cXVKREwvVHFBSXRTdmxqd0o3TzY0bVBzZVZaTU4wUkJHblZMbUpRTDdzclBq?=
 =?utf-8?B?VTJ4Nkw2VXpWYkFTOVl5RkI5dlk4WnNrR3EzbUlXQUcwNXdBQW05L3pPWmpL?=
 =?utf-8?B?RklUc2c1MHkzQk5Rb1VrZGFQTENDVjhINTRvOEhQNzRyalZUZmJwWTFjYmpp?=
 =?utf-8?B?Skg4WElTdnMwRXdDSWZObm83elJOem8yZG5QdVRKOUkyUGloNXhYMFNOWitT?=
 =?utf-8?B?SEFkMlU5N056bFZoZHFhK0lSRGQ4eWhJUlFQcE03b1NicklpZlNRSzlLZk1a?=
 =?utf-8?B?RWhRMWluVG9Rb2xZNFlGdmJ0dnFLTThZR3VOOGZlOWRTa2dldmhqc1U5a0Fy?=
 =?utf-8?B?UEg3VWJQUzRBZitHeDYrbzh0Z0pFUEJSaHA1RGhncnNVNXljMDFvc0ZTdm4v?=
 =?utf-8?B?TzBuaTVqYko0SEo3VUZuQ044MzNZelVyb2JTVnh3cWZVekhuczZicHhxNS91?=
 =?utf-8?B?TkEwc04zR2g0WUwxU2JkeGxmeG9HUFl2dzI5aHQ2eERhU29FUEhSSDE5MG1r?=
 =?utf-8?B?WElYZGdiNWdSZFZ3dE80Ym1ZMUJUdHpBSGdwdDJGY0kzYzI1elBacnJQb3V4?=
 =?utf-8?B?NVZmN2pRU1BQdHVsZ3FYTHpyU1ZJd0NTVkppWi9XNUlXSis4a1M5ZmdKa0JP?=
 =?utf-8?B?ODNtRWhGUFNEczNUS2owZG1oV0l1eXlIYm51UHZPcWQ2ampkdVNLWUx2QUhH?=
 =?utf-8?B?WjFTSkVLZUw5Y3VadS9DQkI4bmVHOEp3YUZaWUhLdUM3aS9LUURjbWd3TmJU?=
 =?utf-8?B?bEVvc2dERDNVWHdOL3hVN1JxUWd6eEtQbUtoVFczTk81bTRpWmtHaGpGb0R2?=
 =?utf-8?B?d1hreklubCtCR3lzOHFMUDlVNWpFMUVaMjlPU3VzYno5dUdBVTUzV3dZY1lU?=
 =?utf-8?B?VSs4Rk5LQ3NwR21XMTY3MUI5bG1UNWs5UnQxVnYxbkpJUmMrZmFyenZvLzZt?=
 =?utf-8?B?dy9XNlNjcUVwNmMyUWNWcWlrRmIwNWxOWk1hZTVjUGp1NTZTVW52YXIrcjZB?=
 =?utf-8?B?ajZsaER0a1M1U0taVUZQdlRwcGkvR0E1QjA0MDVkd2g5QXppcmtwdStUMWth?=
 =?utf-8?B?UWVpMHM4MXd5dnVSU3VMUkxzekR6SzZsa0xFYm1aS1FNNFlLMmsyTW1wVzZT?=
 =?utf-8?B?bVVjVndqc0JwWUFmUjd0am5DVW1XU1p1MmVINVo0QmVrRzZBd0owYWcxMllP?=
 =?utf-8?B?U2lTK0JKRFVKSXlmRWJkZVhFRWJkMHR0VDVuaUVkUzh0ZWlXZWFRU1dPMGlX?=
 =?utf-8?B?RGtSUFFaRzRycEtmeWc0dTJpZWxrSVIwSlF6MHlsYWhUdHFkaHRTSm0wUzkr?=
 =?utf-8?B?Q2drQjhxa3RndWlveTIrNVVVTVhPMFF3VzJXTVFFM1RrU3NyTnJsUWRjT0RG?=
 =?utf-8?B?Mkpvd3dsZHNGQWUyVjMvSU1XcVNFMzlsU01hSTI2d09VWWZkVmY0R1lmMXFI?=
 =?utf-8?B?M3RVN01pZVFmU3hycUdlVHppOWVmblByMmNpZHMrYzIvVHdqWTRLVDIvcUJG?=
 =?utf-8?B?bTRIL2JENXVCckgzRjdMeXJCNzdKa3I3QW0ybXQ0NE1SUmJ1cVhEa3lKTFVo?=
 =?utf-8?B?Z3RQUzJTT1kyVDhlWmNMTG1KTUlzUUZxeHZMRDdwUnA0OEYvem45cDhjVDF1?=
 =?utf-8?B?SWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LFoJDgqxqlRz8qoDyUZ+kSA4mIv1Bu4HCly/NL+4xIm9LAE+nIl1zKqlSlSKB6vRxelzjaN1UCh3fE+dXOoiMA9J+BLanUMyZEQm2mA7zzcyoXhkzNLL7o0tJIEZ9MNA8UNwcCxWly5ZZDVN+S5RZeOpGI4qP9R3Y7JRIdEQOQku+9AM2zOIyRKkQGY6Jg4gF49oNwUsx51ibKtYFTWGNcP4zAaWSVV33ZnfDCzYK+1JWLb49nwJVHrOZfS1OYaiSB41llLZjSGuqu3Eux9OLAKmg28h6HdhPPV82yoMttpHTmMQmtcWfvSdhsGIUA65jFpGVGZEIWr7z2AP8MXE+BIvQZ0fO/uhckrsO4sHiMjOVZOKpd3vrDHYl2Bm4LNZjlL0sEfjYMgwphfpdV0rXo5qbApt7TWPeDIwcbPiVLlGtOel44I+7sbW+lCXr5CqKx18JnecGbs1LuYRvv63Lk13CveAJEEYZNKlwI6ryQ4IvVKK+aAsbSujnr//p6QOZQNUGl1XakFYDm/wnmnh5d+hjJJcH7PVKFMay5UiLm3b9xIF6vSsv2KQNgIkSNNkDxzaSaA/Tqoki3nfQYmm8Aza7zm+mCuSpWbi01Fg+MI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cdb9140-bd3a-473c-4432-08ddef0a78ae
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7660.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 19:04:01.2377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RBpI0GjFLvMVr13Q1zvwMVpBswAPu7y586NR4Bmmi0c1qcR8RpI1sPsgXygv0HI9gA07b00SFtXIT/uBm8emk1MsQ/FmnXXInr2t2GAK8WM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7283
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 phishscore=0
 bulkscore=0 mlxlogscore=914 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509080188
X-Proofpoint-GUID: 53IpLX60ZWqS_JocM0vOWge0xH-N3DTR
X-Authority-Analysis: v=2.4 cv=CPEqXQrD c=1 sm=1 tr=0 ts=68bf28a8 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8
 a=yPCof4ZbAAAA:8 a=lqKt24KulqzpwC64SE4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1OSBTYWx0ZWRfX0iLvRtQvcTno
 Q9CilKR+VlqphFhQtLBzQIi9ajfgPMSVvFIA1EkT3br/6RkwcNIIrCIh0zt+rNVeE7/iinFQLdE
 HsJgavfleBEwEyh8UV7q6B1/NPm1BW0Lv4jOw4UHUWjKAbPyNzI25SPFWkjUzuinY/V6lPUvFfM
 zI8FI1qfE8BHcKiCAaVfftXSNnKeiHtjuGlvH8EIcP9SKGevCtEneDshRyT7OtZvJbRw3NoFqj+
 4K74egqanxSUQF+CNKXShC4mUlz61qpqao5+4fyH6bopRZddadkrAiXaRdzpAAtqOw2JXVC4WUJ
 3IYqXLNXldcAjH4Par5hOANEfQeScvcH5+NhuH/nAaOxcaXZ/xT+/hhcIH9L/c2U1WAZUMZRNw6
 ygznGWO8
X-Proofpoint-ORIG-GUID: 53IpLX60ZWqS_JocM0vOWge0xH-N3DTR



On 9/8/25 12:02 PM, David Hildenbrand wrote:
> On 08.09.25 20:56, Anthony Yznaga wrote:
>>
>>
>> On 9/8/25 11:45 AM, David Hildenbrand wrote:
>>> On 20.08.25 03:03, Anthony Yznaga wrote:
>>>> From: Khalid Aziz <khalid@kernel.org>
>>>>
>>>> An mshare region contains zero or more actual vmas that map objects
>>>> in the mshare range with shared page tables.
>>>>
>>>> Signed-off-by: Khalid Aziz <khalid@kernel.org>
>>>> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
>>>> Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
>>>> ---
>>>
>>> Why can't we query the mapping instead?
>>>
>>
>>
>> The bit check is nice and zippy since vma_is_mshare() is called for
>> every fault, but it's not required. The check could be made to be:
>>
>>     return vma->vm_ops == &msharefs_vm_ops;
> 
> Yes, like we do in secretmem_mapping(), for example.
> 
> (there, we also have a vma_is_secretmem()).
> 

Okay, I'll make that change. Thanks!


