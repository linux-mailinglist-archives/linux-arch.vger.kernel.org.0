Return-Path: <linux-arch+bounces-9925-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED758A1DAF2
	for <lists+linux-arch@lfdr.de>; Mon, 27 Jan 2025 18:03:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4912B162F15
	for <lists+linux-arch@lfdr.de>; Mon, 27 Jan 2025 17:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 337E017C20F;
	Mon, 27 Jan 2025 17:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="c2F8RJus";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VeFvAgW4"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949AE149DE8;
	Mon, 27 Jan 2025 17:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737997383; cv=fail; b=OWr9IARKtwpMKfjnAoLWW/HktglRWBb9DF8eBqZZlbDwFQGlEdQ7qnu+mFbHv0kQLY5XsYnSMaKp9aKokc+0QbLV+Jod6Jnm1SMtukiifYW+0Ok0ZlYHFc4ULioNeIrWLBdN531uUHrDH0oZHBjZjkqtv6RZAQ0DN3aV5eVsMiQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737997383; c=relaxed/simple;
	bh=mOUdC8ZAGGv6GyFN5FoOfc5gjoHOho3Ocz7EWeD9I78=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pz6GkfA4D9Mo8fgPz7mW2ySzg5uOvA2c2DNQWB7+Imk+woU0TNjM41fJX6kZebPbsWlWhBMg/PZ2o315MnDJVGi3kthv/AiQYSzjDRnNG/Oa0snNgzgFffMJepqyEO2hNGh2Js+UgzydTBtSXBMiJkJrg6haJYhOqTsvsCSrm2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=c2F8RJus; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VeFvAgW4; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50RGbHaD019409;
	Mon, 27 Jan 2025 17:02:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=gDVF4V2d+ayFugYKAxjYI/jJz5a2Z2re5Yiltu1Su1Y=; b=
	c2F8RJusRM2G+YRChYvhdHqgO76Oe61CHF0FsIQrsnP9Q5FRRuEjwDRxrABtsXt9
	+qUJuac3DdAzDEiv8CUI9xInZTNjEWPaRBUJIX7EQLQPhaMEBoMAHu3tAEwutTMJ
	HW5RzmP3jyUYMMmjHJ248xxrzas463fO2QGLYFRttapjKxUuB0BwBf8bsBdLIId/
	5NJ/VQ9NlFPGQldZSFwDikuBPNAHdzRnXMpBIW/LG58Fv1CILGpi5cFAuCbt6jBg
	GbXTQsBpIneelei/VoIKhNVw+qSTtLwrnspjJKrRbE6bF+obxcvprz2wvTwsfr5S
	dI/LDK6AueFmMGZbu5V5ng==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44edtn0248-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jan 2025 17:02:00 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50RGZe4K011737;
	Mon, 27 Jan 2025 17:02:00 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44cpd6yg20-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jan 2025 17:01:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MA16hlOHaXhxqL24Vwjtrr+lqmSkETIr40pqrJSXy1gFo+g3sr7MS4/gzXctlTVXtw1hGHp14hIo0PxXBdmL9PtuI426PauZSedH+iincDaD2LH4Nr7ZYTggaqbevNoaJMvApF27yG18C8tImavJJFcsF/1ufwG+y+jxiUGfttReCinCgzXPv654kd6Y3oeVWNnIjSUFwlvXyV/RdC8rTBaYVCymznNkdm8vCAKQVbo1CnGMsnIiwM+oKiRoT8YVJ9FlueBMrwC1rU1kyD2AIUkmY9dJPUfoocdZhdNIz/vvlvdv5KGQoAq3/cHJmPgxnd5jRVVZH2aF+MVbcfKbDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gDVF4V2d+ayFugYKAxjYI/jJz5a2Z2re5Yiltu1Su1Y=;
 b=DotNzF/MAU5tcUg+kGyK4p237DGRMXPTG5e50ItdE5zXMBQVmoBAshjkfISx6tja6FtjVHetsGUIB5xdzpk0hMYL2rqgS99au8Vig8TGv7+qfh4SNk5FeFOUsMZlCepwQ0j3ol3Lk4CfwXbBOYPuFiDK2PA/SbwMwr/g/GdMf/VqfXcAcFra1r747+vJ08PfNxKmLwWr/Pmie45tKv1ssM7ldjhZ1l3NpYj2UAcVHBZZZLXdY8ehx+/Ab22pwOkgPOQmXjUyKAU9YuC3n0TATP59G7eNHfKckvhXxRv3Ip7qyyExvNtHsR4sz2JRWrupIdZsptAOu9NQ72yq0Kq48w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gDVF4V2d+ayFugYKAxjYI/jJz5a2Z2re5Yiltu1Su1Y=;
 b=VeFvAgW4V50qrqAZX14/rRq9hi6+BlF1p6GKzYA9A1YGQNKncC9rw+ZD1E9myRceOGV7TPmLxRumRiw7imhf/LSChvb1zlqqZ8WX1SrvWIiAjDnCD9IEu6UVH8IEENrjTVShNP1fBP3oG4TDsrsr51kMF4bQWT9+/lEeKGyxMXs=
Received: from MW6PR10MB7660.namprd10.prod.outlook.com (2603:10b6:303:24b::12)
 by CH3PR10MB7307.namprd10.prod.outlook.com (2603:10b6:610:12f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Mon, 27 Jan
 2025 17:01:56 +0000
Received: from MW6PR10MB7660.namprd10.prod.outlook.com
 ([fe80::41fa:92d3:28b9:2a15]) by MW6PR10MB7660.namprd10.prod.outlook.com
 ([fe80::41fa:92d3:28b9:2a15%5]) with mapi id 15.20.8377.021; Mon, 27 Jan 2025
 17:01:56 +0000
Message-ID: <403f1597-05a9-454e-900c-48340b90880c@oracle.com>
Date: Mon, 27 Jan 2025 09:01:50 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/20] mm: Add msharefs filesystem
To: Matthew Wilcox <willy@infradead.org>
Cc: Randy Dunlap <rdunlap@infradead.org>, akpm@linux-foundation.org,
        markhemm@googlemail.com, viro@zeniv.linux.org.uk, david@redhat.com,
        khalid@kernel.org, jthoughton@google.com, corbet@lwn.net,
        dave.hansen@intel.com, kirill@shutemov.name, luto@kernel.org,
        brauner@kernel.org, arnd@arndb.de, ebiederm@xmission.com,
        catalin.marinas@arm.com, mingo@redhat.com, peterz@infradead.org,
        liam.howlett@oracle.com, lorenzo.stoakes@oracle.com, vbabka@suse.cz,
        jannh@google.com, hannes@cmpxchg.org, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeel.butt@linux.dev,
        muchun.song@linux.dev, tglx@linutronix.de, cgroups@vger.kernel.org,
        x86@kernel.org, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhiramat@kernel.org,
        rostedt@goodmis.org, vasily.averin@linux.dev, xhao@linux.alibaba.com,
        pcc@google.com, neilb@suse.de, maz@kernel.org
References: <20250124235454.84587-1-anthony.yznaga@oracle.com>
 <20250124235454.84587-2-anthony.yznaga@oracle.com>
 <879e64a0-f097-4bde-ae31-25a1adc30d5f@infradead.org>
 <f515279e-235e-4396-9c91-cbf67083001f@oracle.com>
 <Z5VTXhszpk3_zfV1@casper.infradead.org>
Content-Language: en-US
From: Anthony Yznaga <anthony.yznaga@oracle.com>
In-Reply-To: <Z5VTXhszpk3_zfV1@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0047.namprd11.prod.outlook.com
 (2603:10b6:a03:80::24) To MW6PR10MB7660.namprd10.prod.outlook.com
 (2603:10b6:303:24b::12)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7660:EE_|CH3PR10MB7307:EE_
X-MS-Office365-Filtering-Correlation-Id: 35cc5d3a-9f25-45af-b662-08dd3ef44dff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bkp4M0hTYzdreldEbE5ScjBpQjVvcUxXZEl5c2FPcHF3VUx5TWs0VlhEMFVU?=
 =?utf-8?B?bXhTdVNBVDR1ZEQ5ODdoWHpWeTEyN0tGK0l1bUE5S0c5YnVmZFl2Q2h0Q1FT?=
 =?utf-8?B?dlA3VWc4ckpJeWs5dTMrRkx3a29iY0hiNEFPSFNxNkhCVU1HZDBFQ3ovcjdT?=
 =?utf-8?B?ajdrR3ZWcG1XK3NyeElSYmIycE9pUHVSVVI5WjhnVy9aZld1RDlTMkY3RzZ4?=
 =?utf-8?B?eTFoUTdRR1JVT1hDNDBscWVJbm5teXJuSklmSE9ZblFrVmM2cGVqQnY4dyt4?=
 =?utf-8?B?WWFvTWQwMkRiamQyRk92dzl3NkZmRlNBYnNQMlpKd3hGQXVuUnVtY0V5bDlx?=
 =?utf-8?B?c2ZCQ1BxbklqYjBHRXlUZnFnOUsrTkRsQWV4RElEeEFSZmhGS2N0djJZUkJi?=
 =?utf-8?B?eUowb0hhOWxaTWhOM2RqWlFDTlQvNTY3ZGlQUVUvQTQvQTZSNGRuWkNhcWlG?=
 =?utf-8?B?UXVPSWE2ekhOdkVLRUd5OE9RWXBtdnQwNGgxaEpMeUFNeldPWlZGVkhyVW8x?=
 =?utf-8?B?SUc5dHVyeWZZbG84bEJZWXhuYXBGSXNSTk8ydFlpY09vS3pUcTczNStZQ1NL?=
 =?utf-8?B?dnVqRU42cEV2ZDdRYXJ4Zy85OU9pczY5cmcvSzgzMzVPMXJsL1ptZWdEQXQ1?=
 =?utf-8?B?eGpaNWJ3YzY4bUZENGZTWTBqd1JQdEoxTk5OWmtjUlYzVUN6TmhQd3E5T1ox?=
 =?utf-8?B?M3VTY2VQenVTaDZFWWdGSERZeUptU1BtMUtNMyszWXNweVFlVDhKUkJSU2I5?=
 =?utf-8?B?RmxXYnFCRkRvK3NkUjhwd081WnprVmZFWGQwRE5MRHE2MGU4enhmZkovL2Zz?=
 =?utf-8?B?SUpWUUsrRW9NNEhYVWprUlk3V2pYb2VuVzJiWmZrM2d1N2s5OW1Kay85U3hQ?=
 =?utf-8?B?VXhsNWhkSEpRV3VkTjBQM25qL3FvS2FoNStWcWF2ZkEzaDZoRGdmUklOREdq?=
 =?utf-8?B?N0lrWEd6Rmw1alFPWUhlb0gwemE0Sjl0bmRmVDYwTzhnTDY4NkdZYnlBMWdH?=
 =?utf-8?B?cHpDRzdFcTlEMFJrU05pSURaQ3lDL2V0V3JnR2c5Znc4QXhWMG5wdks1U1RV?=
 =?utf-8?B?dkRtRmxXck42UStVNHg4U0NpQU1CTUFiWFh6Ui9VZzJRWVJNSlhGSUpweXRY?=
 =?utf-8?B?dnlpSGwrMFVoU2hTMGROdU5tLzFDUmJHUTNYQ0VqbW8yTG9QM2J5ZXVzWVFY?=
 =?utf-8?B?bktFN21UVkp6TjJyam5JZkxDcExPeld4LzhNZlNJcGV0TGUyenRSTTRlV0gr?=
 =?utf-8?B?WGVTWTZOcWtCQVBwbGM0WHlPaDZIRkJSZlUxbCtJODhlUWVvSVRUR1NZMUJZ?=
 =?utf-8?B?ekVXN0FUR3M4WVNiUFBUMVZibUdjWlE1MlJRa2MvNmpRL1dTYjVrT2FnQmVL?=
 =?utf-8?B?RjZ2ekYrVVUzeWx5bWFPQzc0VFFpV2xxR0hDbTBtY1F0T2RTZVhFOGs0ckdR?=
 =?utf-8?B?aXQwYVRZMlJ2dWhFZitSRld1NzZOZ2lKQjZ0bkwzVHBCcERYelV6MUJNWmJy?=
 =?utf-8?B?SVhZeENnMm0xZlhKdjdyaUdlOCtTZTU3TGtTZEsrUm9nekxLLzlnWUoybnVS?=
 =?utf-8?B?MExtekt5TlBDR2U2Nmd5OUpTNU1ZbVFBNnlHQUlqZHN1NUxodVRSWkVGQ002?=
 =?utf-8?B?VXpFbEE0L21XRjVSWmIzS2tDZEJ6MmpGdkNJR3dqRnJ5dXBuRXphdURoUmZw?=
 =?utf-8?B?SGtxWkJpOHBNaEFDV3pwWkZ3cG80aVRSa3Z1eGdyWGI2UmZiMDFtYWFQckJq?=
 =?utf-8?B?aDREVTQwd2ova0dOOVBaMFJMSVJBbW1ua1U1RndNaHIvSmtGeTBzWTE5NTlH?=
 =?utf-8?B?WXRYbGlkbXZWZ2w2UlNRSjBZcEpFNkxYSmtGd0FWWkVqOXFkQXZQSmZhbG9z?=
 =?utf-8?Q?zM7GC2YVreJpi?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7660.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UEgrb2hMSjZocU90cS9uRjFnL0xaU0YrdVRSMUZyeS83UTZ4cVVRMjcrWSs5?=
 =?utf-8?B?bWNhSlpESmFjdkdvcVRCQVdYNkp1dWxBK21lSytjUWtHQ05Wd2xXcXJYdFEv?=
 =?utf-8?B?Ni9DS2xsU2svZ2JzVjRqYWY0OUN4dmRkdGV2Ly9HRzhvem5jdUp2SUpIbGJr?=
 =?utf-8?B?aVYvUTVkNm5KUWtGamNCbUhOTkZNRjNJaUszRnVsZjNUUVVONjlKaWZUc0VI?=
 =?utf-8?B?REhwRER3YWxRVzF2TjlkSkhzSDRhc2hpdWI5Y1k1M1cwaHYwWlpqOTJ1bHZW?=
 =?utf-8?B?ang1ZStmYktZVXVkLzQybW00TG5CZkQyNXdMSzBwSGJsWHR5OXlnRTlNdFp0?=
 =?utf-8?B?ZHhWdlUrenNIQWRnMG9TcWJPWG9Fem5BTDlhdzVvUkV0WHB3bHpoc1FMeC9P?=
 =?utf-8?B?VENHcE5IS3YveDBmbGFNci9qeFVFTkdlQm83WllMbG9QeWhVMnBKSHI0K0Fi?=
 =?utf-8?B?Uy9aWDhackt6N28vaWdaYTU1RFN6NE5sN0ZyU3B4UE1zSXJTOFBnSzBLTzZJ?=
 =?utf-8?B?eElsQUtQb3Y1UC82QysrUkZZM3k0MllhNU5TemowOWNpeEdNRkJzVU9iYjhy?=
 =?utf-8?B?VEF0cHFhRDNzcXRQaEJ1dXZTamFXeHNQRGphai8wTnJxVUlpdGJGUTFReXVl?=
 =?utf-8?B?UkFWZ0dsZHVTaUtZbXZTRU9WMDU1dUo5MjdzUTVoek82WlZVdEphaXhhRjg3?=
 =?utf-8?B?UTdrMjZtcDQrTWptUHp1OWlVU2JvVTJLb3h4MUJQZGRhTmtIQ2VZdFBxZFhl?=
 =?utf-8?B?cWtZRE1FQ09pMmg2cDhnVDVxYjZVM085M3J6cHJQMDRtKzY2ZnpNVUdiRGlC?=
 =?utf-8?B?WFBLN0MwNHlCQWdadE5rSFhMRWpaVllnZy9BWmEvRlRKNVFUNnJkVEN3U1N5?=
 =?utf-8?B?bm1ZQ1FVZUEzNkVwSEVwNWNyYytKNHZCRTNtU1JZb1Y3bldZYzdsT0w5b1FV?=
 =?utf-8?B?ejlqeGd4K0ozQlJ5Z0d4eUJhNTl6MGF6TGRhb1lla3c3S0pvTTdIdkNib1Yr?=
 =?utf-8?B?ZXhhKzBKWllEZEhmRVVwUi8ybWpuZU41QVdTbWE1MEtFTkdvWVQvbEZIeE1U?=
 =?utf-8?B?SUJvcVZkMWRJYjNDcWVxd2V6Rk1WNzJLQmpBbHpwTUtsOE9aRC9VSmdKRnNG?=
 =?utf-8?B?Q2h3YnpZZllzN0pDcDVBRlZhVkxjcUJWZGF0TFhHc0JGUjQ1aDVVTzJtL3or?=
 =?utf-8?B?aXBaNWlNcVV6Njd5ZU5qYXo4OTZtUUx2TjdQWk1BYTZmcmZTeEorVUx6ZVBh?=
 =?utf-8?B?cTROYTRHYkE1ZUwxdWZzZll3TW1XOTAvbkcvYUd3NkRzbTZhdmZKVkRlaDI1?=
 =?utf-8?B?QWxYdWtCTVBzb0YyRWZRa0pGV2ovc1psbnFjNWFMNWw3VW1hZlV1MTVUbXht?=
 =?utf-8?B?bi9oSzZlUEVTcDFXWGxTS2JzRTVYb3Mrc2w2eFdyNUg2VzB2YVhZd0RLU080?=
 =?utf-8?B?Z1A4aG5wOEVSRXVqWjN0YzBOSjE1eThtV1ZzcEsxek9ISTgybTlKQUN1ZVQ1?=
 =?utf-8?B?aXRXTU1SOGY4TWtsd2Z5VFd0RFoxaDNjS1NMV2FncGZySlZGVW1rQWZWVEZj?=
 =?utf-8?B?UFdtRlVDUk1oZ1pKK1k1WG04TEoxblJMVjZlb1d1SXRPV1ZQOHBCYUUxQ1JT?=
 =?utf-8?B?ZFpHSXFWT1ZBNkVlYWVWZDUyN2JpblZpUzlYdUNudU9ZRHR5WUp0dVQvL1pV?=
 =?utf-8?B?ZWRlZDJBMXdQZHZCQkt3OEEyVklhUCswcGxOd29iMUkxKzRibmo2K1V1aEt6?=
 =?utf-8?B?Ym5MQk1OTXd2UGFBdUJSbExDNGgzdkE0OTN3ZXFFUXY0Zzd4UTF2VjU2SFIw?=
 =?utf-8?B?ZDc5MU45N1QrV2lsQll6N2NDNXhZbEVTb01sRHB3RXBWenVlRWl2Q2RML24x?=
 =?utf-8?B?ZUlkd3pSYS9WS2JDRkFZdzFRbjlRMFhOdk9KS01BK2hObmtlZWMxaWduRlRC?=
 =?utf-8?B?RHhsNVdhZ2FXck4vL3Z6dEVONmkwUi9WY1pWMnllWWxTS3ppZXB5Q2V3cG9n?=
 =?utf-8?B?RCtDMEtzNGJObG9sUGRuUEY2VmVqQmYvKzhvMG1sbDVzV1RMWFdveEI5K25q?=
 =?utf-8?B?VGhSTjM2V3NQTEhBdU9kMFpsVkhiU2dDUmk5ZnN6ekx0R09iRU5qaW9wTngv?=
 =?utf-8?B?OFY1d1N4SW9WMHBFTWJOVFE2MmExNHVOWEo0dWR1cTVHWkpoanM1aE5RSUxj?=
 =?utf-8?B?RlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+R39FI+/vDGKQpzANNJuPv6NU9+AiJRGExjSKtAdeIlG9azYm6hd9xmAdwhgDCfMay0h2+U2cZci7q/bOxirkqioDlEOVh945rvJX4TjGn7zTvhjBEofuPR+mNH92gn+75fDrKkMhn6DcsNyjUK9hBT/cUP/Yx1KEjykMZEtjjrVBvAF5n4qhggo6NbzkLK4GZ18ggKCQQ2WkuRaSZTOWG+kHB58SBPM2MFwlp/r31acr5D5NV7o5nO73j6TBIAInCqkwsjEPgzCGQVUQ9RUoiG2rezIajko5Tnx43nY8QUdvYylOCpwEBMbbjI45QWorya7tTajHMQnmPj+vAU/hKuOZroQ5IgUL50uYfd5m06j3VuWOwBLLKkJ3PjSdjsyWZL4IDY4KB5IQ9I+ywFPbztkveoXzmHVoA4OZRjYImt/2KB/sBTxx4UJntobUUWOu1o/jnDYDZ5Iwhd0NKrNdk814G+5UQ92KbSZjLdZ3tJvk5kxzLukPvBbwi7FcSFbup7OxKYuDAz9BleRDvoolU4GjrDHUg3xF6bOu1ozSLbKe9GuGanlG+jkSJAEYHr0x4gDITVMEceZaeJqef6OfzaEl6neJPb0/kKTvoPr/Vc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35cc5d3a-9f25-45af-b662-08dd3ef44dff
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7660.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2025 17:01:56.0401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CkhXfm9nXylhOydfGnuAczvCIwEyzNCYbghobvoseTUesVnXAKj6vHJHx01exPnoU0YRjSn1CCW0L5tV85k/iksnsKaUvvRE/NXAW7Fh1yc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7307
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-27_08,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 spamscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501270135
X-Proofpoint-ORIG-GUID: 57AVUURpFZaLS1CxI_w4bnHic6_k8ni6
X-Proofpoint-GUID: 57AVUURpFZaLS1CxI_w4bnHic6_k8ni6


On 1/25/25 1:10 PM, Matthew Wilcox wrote:
> On Sat, Jan 25, 2025 at 12:05:47PM -0800, Anthony Yznaga wrote:
>> On 1/24/25 7:13 PM, Randy Dunlap wrote:
>>> Just nits:
>>>
>>>
>>> On 1/24/25 3:54 PM, Anthony Yznaga wrote:
>>>> diff --git a/mm/Kconfig b/mm/Kconfig
>>>> index 1b501db06417..ba3dbe31f86a 100644
>>>> --- a/mm/Kconfig
>>>> +++ b/mm/Kconfig
>>>> @@ -1358,6 +1358,15 @@ config PT_RECLAIM
>>>>    	  Note: now only empty user PTE page table pages will be reclaimed.
>>>> +config MSHARE
>>>> +	bool "Mshare"
>>>> +	depends on MMU
>>>> +	help
>>>> +	  Enable msharefs: A ram-based filesystem that allows multiple
>>> 	                     RAM-based
> But it's not a ram-based filesystem.  It's a pseudo-filesystem like
> procfs.  It doesn't have any memory of its own.

Right. I'll clear that up.


Anthony


