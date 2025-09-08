Return-Path: <linux-arch+bounces-13407-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45496B49928
	for <lists+linux-arch@lfdr.de>; Mon,  8 Sep 2025 20:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77A6B342953
	for <lists+linux-arch@lfdr.de>; Mon,  8 Sep 2025 18:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA8C31C59D;
	Mon,  8 Sep 2025 18:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="r6s4SDYb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UAXGnYk5"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E3B31C573;
	Mon,  8 Sep 2025 18:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757357891; cv=fail; b=IHI2q/bq5j66HBi3j41NU+JKDM0xo3xRBrksoY+FkeHThbIIUmizJ0v1HFkwGQeO+yIB2EbtdLZrPMWb+ng5/RanbNMJdiAuqDbmt+ND9Jye4/U/p90LutcaAfceA4VsNhZugxP3fNStvbrvpRB8sJnPe8PvwnDgNwIYL6nds0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757357891; c=relaxed/simple;
	bh=IB/qMU7CYxfCVIQaqafmpTqmDclFWNwaGDBQNPOyMVo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=W02E7W+yVPgczwdZDqN4RsSF3V4sXFbEkhdJkInKad8HGV1XKIjUfXg1/kuDqhWOX41M9D6jy5KImp4K21vqsOzkMzjXxaZkSGcmKnQvSleJU5uEiJhU2Jwy7Gh7T2uzEnUwhHCC6NWfmzngS19EDUVkJbWBv6vlOzsoLc+xuUo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=r6s4SDYb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UAXGnYk5; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 588HfgcK028887;
	Mon, 8 Sep 2025 18:57:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=+9WeEw1QoAduxYUnDhlOv/WJmpAyGvkUY4uDL3PzBgg=; b=
	r6s4SDYbOmemwara3G0mJVgFOJv86ZVetFF9teT4mHDtzywj66EFDvspWoH4lveY
	KLwAcytNhLpVyv1w8BXjmaGTBztZUr5TRSdwgI98ncBp3QYoB+KRQKMT3bv2nIqb
	mdyamY7bNQ0gcHFkTm7qS4UFxwZ5Ho+h7CPiCD5TIlIZHDUNNtRLlVmJpJRHqXay
	08pWIDaaGTGjbUKZ+HWA3hwji66GVe8cIkTSFpM00rVBj1bAoe/xVe3g2rlAQAfj
	C/KK5hfpyFvMvu9l+cBInMx6vcK4AI9/KN+ZNZKe7F/+BpJNQPEj8NW2h3mHkmzj
	XXgHReY0P2IdqdefCI6MPA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4921m2rf9n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Sep 2025 18:57:05 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 588HtH30002966;
	Mon, 8 Sep 2025 18:57:04 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010049.outbound.protection.outlook.com [40.93.198.49])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 490bdf423h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Sep 2025 18:57:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R6vw3xYe56L2qBgoKuJy18ximfOMht9ZhXfbMo/j7hyXCJ3PKyBW8NNXXqXeE5yA3pOzxM0ktoIlYL9yUNKU0Se9Psq8l1eHuhzcDHmFmdaQ5gPL81gEU7KXMjc5RM5kzrzFM9oozP+nSZddNcrSnJzoDXK7QdmYxDvJ9BgAT43FNGHWgZe17OpCIXwcA6X6M18XeKZsBQanw66oiqML86SpvRTFt7ZEKCXz0EpGVk/bo0vlzcFikGKGKCq5dAqnsyXbqt+tzJ+3FB1V9RVkz1MZSytPP4ieXzuCe3GFLxlv6YCqByEPheViT9wDlTcFy6fWSOUDNWFmbdb1VgdVxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+9WeEw1QoAduxYUnDhlOv/WJmpAyGvkUY4uDL3PzBgg=;
 b=uK/OunRxQ33t+5jh3JuUaC6CIB9ttHQiEoHvh/mZ4aKh9OnR7SSQJItimewLRSK4HYk9w6IEQuAV4qaGeDncB4NNv72cYaIe1fDrq05akU/DLJhvRd4QVu0PCvEvVY31B5t4tr9gs9IEzq8S4wdVnWPnT7zM7W+ToIrO7fBi/Y0ySOfD0aOAM6qHROi2Y+/KCXNkUzr2Gz0G6iueVBUEbM5eFNnPzR3GxlRKacCFd2EM39CKzT4sGR1pT07oZftmr6lcXXrIKJZUvnqaXDfykzvRcWVx9rxt1OlQJjeHultP6D+PhsVgVOWT87B1Ge0Bk3UPfLldGEKd1fIiQ6MgbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+9WeEw1QoAduxYUnDhlOv/WJmpAyGvkUY4uDL3PzBgg=;
 b=UAXGnYk5ElPNxIIA0LgRSlzu2I2VpqahNV3YOkD7qoZLTP5kycPKISdndN9hftOc5Sa680uF0rXxDg1ArBkDDVugDV3+rTq4TVJmkXilpxgzKi7OkOmKOvAeUxSm6MTU1WCtPm4/qS+LcsUE6A2jB5D2ojEBOF3/5T3jr4DCUDM=
Received: from MW6PR10MB7660.namprd10.prod.outlook.com (2603:10b6:303:24b::12)
 by DM3PPF59D9BB966.namprd10.prod.outlook.com (2603:10b6:f:fc00::c29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 8 Sep
 2025 18:57:00 +0000
Received: from MW6PR10MB7660.namprd10.prod.outlook.com
 ([fe80::41fa:92d3:28b9:2a15]) by MW6PR10MB7660.namprd10.prod.outlook.com
 ([fe80::41fa:92d3:28b9:2a15%5]) with mapi id 15.20.9094.021; Mon, 8 Sep 2025
 18:57:00 +0000
Message-ID: <b99517e5-7b4b-494e-8ec6-918f933ddf50@oracle.com>
Date: Mon, 8 Sep 2025 11:56:54 -0700
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
Content-Language: en-US
From: Anthony Yznaga <anthony.yznaga@oracle.com>
In-Reply-To: <5c43116f-fef9-426d-8c90-1a3a129f3d20@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR21CA0026.namprd21.prod.outlook.com
 (2603:10b6:a03:114::36) To MW6PR10MB7660.namprd10.prod.outlook.com
 (2603:10b6:303:24b::12)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7660:EE_|DM3PPF59D9BB966:EE_
X-MS-Office365-Filtering-Correlation-Id: dcbb69a7-8060-45be-1c55-08ddef097d84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NmVBREdWM0Y5dHhBaGVGaWFkU1M4aDgyT0xISjlpZU1sYitmTUxtRmdVQVFy?=
 =?utf-8?B?R0d2RE5ROW5CUkVZOENQZ1d3dlRUMWJEaWFVMkNyRTdsVVZuUHU1NFlaZC85?=
 =?utf-8?B?MzlLZGdGUU5WckxyNmQ1d1BOa3hsSWwwaU9KVGkrZ1JoNGFkeEd3K3liVWJu?=
 =?utf-8?B?a3VJQ2N1TEJSM3R3cU9weEwwdURTclE0alRYTWREUEVHWTBhOVJNNjhuWHVK?=
 =?utf-8?B?Wkw3RkJLY1V6MVVPUEpjbTUrbjF0K2w3NUVKN3ZaMHBHNjM3eDRkRmJVV3Zz?=
 =?utf-8?B?ZE9LTlJzT1JCT0Y5ZHJsZXZFQWROa0tDTDVkRXBKbTBFM211ZjZMS1dLMitB?=
 =?utf-8?B?SGVYQ24zUGk5NkF2RHE0Y2VVeHUwcThaZEQzRHBFRDJ4dWM5OEkwUTNUWDRV?=
 =?utf-8?B?SGpld1dGQ2UwL1p2OHFRaFhkR2FYYjdKOUtEYVdRYmdxR0VZS1RockVRSFlm?=
 =?utf-8?B?ZzRyN0xKbGh4UmxJdnJ0YmtWelNhM252VERQdmlKR1JOaVVad0FVSWxVWito?=
 =?utf-8?B?Rm5YZS9xNi8zdFBZUEdrTDdhQmhBcFB6OGtpOW83YVRJbHN3Smp5bGpBOEx0?=
 =?utf-8?B?dlhwRDdRbVJ6UEkwZDRtRUhNOG1ZajdsTDNZT2o5WmEvcnZmcUExL2xtL2ND?=
 =?utf-8?B?R1lHZzZvTHU5Skd3dnIxaTVSZWxFdHZpTHJjenRuL0xMODZ6aFRack42Q0FN?=
 =?utf-8?B?SlcxY3BaTFZaeFRLVExnbnBSckx2Nk1UbjRCa3lNYktYMnpWVlpMMVRSZFVh?=
 =?utf-8?B?THNSYitkOHlvRHFJYzFwaHhXd0d6MjhxUWZMa09WbGh3MFhUNHNUdWhkaU5j?=
 =?utf-8?B?QjZ6QVZ3Ny9USnoyZFZ3VWYwekFLZytNczVXSW1ueUhTeXkzc0d1Qks4bWJz?=
 =?utf-8?B?eVVVSUc1cTRRd0YwMTIwZDJlczJWQzFKTTl0emN2VjNIMkNLZnhDQWdqcXYx?=
 =?utf-8?B?RVRwMFhicUxKZ3A2QUpyVkR2RnpNZ0Z6L0M1NEFVdnN3Q0hBTE5pY0VoeFcw?=
 =?utf-8?B?K09FSW5NNW80VTd6NUN5V0ZOdDZnRC9CcXdMWVg5QmhkdElrU1JGcWpncWYz?=
 =?utf-8?B?Z0grWmkxS2ZOODMzcTNKTTFEaTdzUWlDbVdZajRCNHpXbmszWHFWRVJTTHlC?=
 =?utf-8?B?VExoY0dHQ1Ezc1pPVUZOZkZEVml6RkhUS2dDdXo4bGpUZHcrUkpwMEE2TElV?=
 =?utf-8?B?Tkx4NlNVbUpvQ3FwL0FlcXV1TWNuWVdPQUV4YUgySEtzVExQVFBGaVd1SFF5?=
 =?utf-8?B?SnMwTmxkNG5UZmcvYnVraFNwaUY3OW5Qb3RlTGZLcGE3Y3hUNlJTNVJrdUVI?=
 =?utf-8?B?dFA2RTh4bHRmcHJZd2VIb0dJZjI5ZVoydWJ4RGhaT3hGL284TlV1WktTZ1lT?=
 =?utf-8?B?ZzNRbFVuK3R3cHBnUGxPTTJtMGhkcG9Xb2FnZnV0WEUzdGJSTzVRSVNtM1J1?=
 =?utf-8?B?ZVNhSlp3Uk1CVUEvbHR5NEdhdjB3R1JqVlNjZ282VGVjQzEzOVorNHlxVU5y?=
 =?utf-8?B?bEFxNEZhSVFmWGNiaTdOa1p3NEdocnFIQ3pXMmRmMHdoTU1Eb0tvQXJneU0w?=
 =?utf-8?B?bXljc3c1NHpabURWV05ZV1ZQa3RNNzNKeVF3Z0ZibWdzL0dtV0c3NFl5dDlM?=
 =?utf-8?B?SHZMQ3dtL3VoRnNzbEJ6Q1NyZFVXOXZ5Wk1zRlRwc0tqUlRMZVk4RDNlZ1Vu?=
 =?utf-8?B?MGw0enJ1bjhHRld6TVc3WWl5VWpxM0FJYmhkZEJYc1BKMkUzdU52LytBSGdG?=
 =?utf-8?B?eDFrK3pLaWhWOTB3TVE4Zm5yU290bmRZMklRcmk5cmM1UXAyK3VDa1BhL3Fj?=
 =?utf-8?B?L3BidzZndE40b3RQMmxtWGROR1hFSjFFQW9oME1vd0xzdjhtUWgyclBzWTF5?=
 =?utf-8?B?RjM4Qi8ybm1Sd1ZLMHdOYTZoMkhNcytBa01ic3dLMGJxSk4wUDE3YU1HRks3?=
 =?utf-8?Q?BETVMBku+l0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7660.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T2JqS3pZMnN4V2JsN2tZTUhIYXoraVVrSG9Cd21BL0Exb0hVTGgzcTRjMGRp?=
 =?utf-8?B?VVZxSGRHQUNXb2hWeEF2WWtQaUZjcHM1a3Q0bFJJcVZGYVQ3MFBqbyt6VFNr?=
 =?utf-8?B?UDhROXNtc2M0S05GenIzNURzRWh5ckE5UUVhVnU5b1c2TE9UYnFsZWV4MHJN?=
 =?utf-8?B?VDFUSitnUEZHak1sblovWi9PNHMrakJLSCtFNE5vSDlwNnBzelUxTGNLc0FR?=
 =?utf-8?B?Q2gxZWRvMTdkNnkxUWNNYTBqVXBjV1BHd1h5WkZPRDcxQ2RCM0ZiV3JNODJ6?=
 =?utf-8?B?cDRoczE0M01jK2xUN2owMEdmL24rRHBXaks1aGJZU1VHVS9yamVLbXYyaHpM?=
 =?utf-8?B?YmttTTlaZ3ZTckU0M0J6T0VoNUpmc1VZYVFpMWwyU3dUbVZlSVFJRm84OEZ6?=
 =?utf-8?B?NFJ2RkhiYmJOUzEyM2Jzd0ZDL3NodWdCanJLbmlLTTRHclcyb2Zmblhsb0VM?=
 =?utf-8?B?MnNQSkxvby82T1JGUmtDVkVlTlpQTk51OHdwTlcrS3lObGJZaFVhcXByK3dH?=
 =?utf-8?B?NzFjaU1HeVRoc3ptd0YxSEt4L01kUy9JY3IwR1BqRnJqdUJSRkdNNHBLZVE4?=
 =?utf-8?B?VWVFUXd0Rmpqc0FMSzAxZzVtbXpOakFRUThiUExiN21NNkJCUTZwWWI4eW05?=
 =?utf-8?B?dFhBSGRDMTBqb1RqaVV1RTlDUFM4d2o2UGRxT2xrbHBNWUpyY3J2YXRMc0ly?=
 =?utf-8?B?NEVwdkJxYUR1bzFlNnlSSEJSS1cwTTU2QlNKazJmb0tyR25HNE9HQXFYNW5w?=
 =?utf-8?B?MURKa0ZhWVZkZHRPT093a2JaR2w1VmcxbmlZMTlKQlRFbExKODVCSlVTZHMw?=
 =?utf-8?B?VGFzMUROT2NaeS8yWS9YOERiaERsY0dTTHBodUJCZExidk8xK1RoRE1ndXJp?=
 =?utf-8?B?NE0wc3hTeUs5RWxlQytGanYwVFhGTDB3dENZN2VjVElFektITWdONlVSUllX?=
 =?utf-8?B?OHhTMU0vTGpFODNQeVVWMERLbk93eG94eWdWTHJpZzZuOUtxVDR1ek1pSFRm?=
 =?utf-8?B?d0lRNm90MXJFWHZzU2RtRU41NlBiaEZncGhuTFU3VzF4NkJ2WXFmT092QVZM?=
 =?utf-8?B?WDN6STIxYjZTTWFFQURWb3EwOERoTFlKa2NZV3dNeWRWaEpESUZEajRUSXRL?=
 =?utf-8?B?dTJVblIvWFhrOEdZYW9lRDE4T3lQUENReWFTYlFBU1JnYnZzbllsZTVQNnFz?=
 =?utf-8?B?Ui9jQ1A0bytxdVRVd2hIeklqa0JEQ3QrbGZ5T3JrQ09TcGJjajZ3WUNRbmJR?=
 =?utf-8?B?czR4SE15ZG9PaGoram0yWVh3aC8xRTBOWlpnSzE0L0tZdW5nc0w2SU44SFNR?=
 =?utf-8?B?MlFtU0FrTDlFT1I4b1pPekhuRENSUWY4Njl1TWlnNXJLaUJWeHVYTWdHMm1Q?=
 =?utf-8?B?YXRzTzJKTGJUTHcrTEFMVU84ZDBndlZ5WHI5OXRQKzVjTkY5cmxhb3FBRjZS?=
 =?utf-8?B?ZGtzUXpDcW1sWURlVTJFaFNRKzlLNStZQStScTFqYzRpM2lIR0cra0MrTjRu?=
 =?utf-8?B?aWtUL1VJaUVONlArcnNWTFZibklBRFViaXJQbFNESjFPbmZDNGsvZWc3aFVD?=
 =?utf-8?B?L0JkQkk2RTFxZ0hENzRWaE1Ea3BsR1dHUi9Ob3Q2bUtWSFo0Y01WdkMyZVFW?=
 =?utf-8?B?YXlyaVBDbkFMUG5lTWVxQXdTOEJ3MlYxZlNVQXNWa3BhTVpRdDFIUFN0WFly?=
 =?utf-8?B?SW5GZ2NqSXhtbDN1ZFpRaFlPVEJtdC9FNVdVeDBvc2tKaVcyL3hiTTZ2d1li?=
 =?utf-8?B?ZUlsMDVJNmpBVU1tR1J6YlJ0TzFGR3M0dGlYNlpDT2psQmVSMEZxanFqcFRs?=
 =?utf-8?B?eEU3aGV0QU13SU9xUXVzSjBscFRnQmhtTklObzYzak01akdwNy9QaTBmYlVy?=
 =?utf-8?B?dEdFQTJrMmlHekRZUWYxNmJzVFJDWFdWNTM5MkpDZmtHZWdWOFB5ei8yNUtu?=
 =?utf-8?B?RTZGN3N2ZVIzN3VISWkrUVd1RjJjb3lBK3FmaHV3NUQrL0R3TTNjQ3lRQTNW?=
 =?utf-8?B?d1lsOTZMODhXYU03cWo4TXgxN1lpNFhWdmhNRHY0RmZkU3MwSkk3KzhEY3Vt?=
 =?utf-8?B?QWFiWHFsaVJ3MFU4Q2NLTktzQ2NqbTIwSEhocmMzbngzaHJSRkgvWGtVUWR3?=
 =?utf-8?B?TzJWYXB4ZzJUMC9PRGV4bHBPNGs5VUJhLzJ0MlBBVkVEenBiNTJxeXVLMkU5?=
 =?utf-8?B?Y1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kRv70ZvkEjB7otf91MgUkgIf5rmXAWe66xttVvwF75DWICoyYgilbO7LKD/eTpwVxjedSe7d/Jxai/uWUtU3LZ6E7L5HukGJKEvdLPXKy0sPuZGoEBrW/y2G+CgN8JgVPMfiBQn+jwGD2pP/15OsrU9HZEnbtPkd/1EG9dUK/5PTwNgV+L8kisgHKdBG/xJ+6H5BxcWZZgi+Xi+GFpIsBfU885JpDC5ZuyukI9CcWk0Jzuc5uyN9FuAWGkZG9V9ApWcpuJzUN15K4OVNxXBWnpiKmosBPu+p46BBxt8tQNfIFUhl9MaFYYyGmIYShU9empPLrhw21LZhGJ3LtdE5A/EYT3H2Z35b8LBobYkjxycg+rPGOhyXQ3l7UFDRzprFGrIgF9pbZY2ooKC6paYobKGtAFtx2cBDqjXLFpRR05+yeri679S7V3o3O1al+gpbi0z+VqbPpLwUHS4n/aCItuLiBmqfBDddWEv6XbH8nVuOjQitgfE5hfa2AD6JEm6bnjb/IAZ/zeIANBJVnt9UH9LlDfJP9SCSJaZtAKgyuInbbw380heVMh27PMKJ52F4vJ6jIZRYR0O9VllhvfbU0LkvBUPs3k/S3CmbDB2iQE0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcbb69a7-8060-45be-1c55-08ddef097d84
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7660.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 18:56:59.9498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YnX1De91lgDHh+itYnZ1l0tpnC8/lVDlX9IYVS0mv/RyULiVkumKz3Kjy/oavbLots8b0SOIPe011yAKTKqwEwQ4agnnypYq+6Z8ByoNEpI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF59D9BB966
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 bulkscore=0 mlxscore=0 mlxlogscore=899 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509080187
X-Proofpoint-GUID: s6VzyLt8P8iE6qGbW6NDa0WlR7YcS9M8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1MSBTYWx0ZWRfXz5NASfdj2KaP
 N6cwvmfmWiJjbTiC2ZppFEsH9znaVTfPZ6iGjcWJKxrB9imlPVxKvPc2FOHoEvYhWaKV37VUG53
 vkA7z60LbAdOnTSJR3SqlauxknpUWcI1pI2WeuHvPZ7JeckWIxJNKmJAfQ9dTcw3N4Pklsm2t6I
 YGjeFt8CzVQt3+vlKfdni2MB2HbT6UBdj08jJj+Z1JvocJHVRL92PhmhzOoO7Q+CAITx5Qf+vGH
 amdLgpcNLcM4AIoN4Ray53LSvg6F3GrXHHxpPnWlc4nJ1I9PGMDWxV30qEabfG90EKQVYgYbYMN
 WZYd1GEjVhU4aZgj0+um4yBrIPpWBmRt/N6m0lRxGhodZioCDfNAFWHm8IEujsLvh1WgLhpG4R+
 9jQd/zeOuLt4Ay8ddFDlmEoerCRpCA==
X-Authority-Analysis: v=2.4 cv=Dp5W+H/+ c=1 sm=1 tr=0 ts=68bf2701 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8
 a=yPCof4ZbAAAA:8 a=TzzTiGglJDmFBzg4XmsA:9 a=QEXdDO2ut3YA:10
 a=1CNFftbPRP8L7MoqJWF3:22 cc=ntf awl=host:12069
X-Proofpoint-ORIG-GUID: s6VzyLt8P8iE6qGbW6NDa0WlR7YcS9M8



On 9/8/25 11:45 AM, David Hildenbrand wrote:
> On 20.08.25 03:03, Anthony Yznaga wrote:
>> From: Khalid Aziz <khalid@kernel.org>
>>
>> An mshare region contains zero or more actual vmas that map objects
>> in the mshare range with shared page tables.
>>
>> Signed-off-by: Khalid Aziz <khalid@kernel.org>
>> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
>> Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
>> ---
> 
> Why can't we query the mapping instead?
> 


The bit check is nice and zippy since vma_is_mshare() is called for 
every fault, but it's not required. The check could be made to be:

	return vma->vm_ops == &msharefs_vm_ops;



