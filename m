Return-Path: <linux-arch+bounces-9150-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 911DF9D590F
	for <lists+linux-arch@lfdr.de>; Fri, 22 Nov 2024 06:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C7E0B20C17
	for <lists+linux-arch@lfdr.de>; Fri, 22 Nov 2024 05:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2CB1531C8;
	Fri, 22 Nov 2024 05:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=illinois.edu header.i=@illinois.edu header.b="Gi0OI0Cg"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00007101.pphosted.com (mx0b-00007101.pphosted.com [148.163.139.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166572309B4;
	Fri, 22 Nov 2024 05:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732252008; cv=fail; b=Th8YuskR4tyX22eEa7Pl0jk/pkHEynof8TODgRXCX810c9JyVhO2QIOwVtpbFF7v9gf76O2zrh8zTGDTZpnujFQkw4ts1jGpSOb2SFPRrufDj3l6TT5zrvzCnEl8OKaEwT9i+gfulUt4+5bB6syEYqeQuO2P8nXvXPbJFd0YqyE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732252008; c=relaxed/simple;
	bh=x2MK10VtSpkXFP1SqNQRx1d0Aqc2VMWyXIwgx2HUUmE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LC96F1AcOMpRS90hxFJKH70z0wfMn7ozKvYP15azMz+olKVhwOo2WZqqklkCLROlcA4ljiP4Kw6S64MYr3U17VaLg6EzSAi2MMS7Qa7wlU0Kx2M0S45buHx+8c5nhXeBh60wO4rvy4poLPTyVkX4/JKylNoH6luj2Xjp25ft0fY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=illinois.edu; spf=pass smtp.mailfrom=illinois.edu; dkim=pass (2048-bit key) header.d=illinois.edu header.i=@illinois.edu header.b=Gi0OI0Cg; arc=fail smtp.client-ip=148.163.139.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=illinois.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=illinois.edu
Received: from pps.filterd (m0272703.ppops.net [127.0.0.1])
	by mx0b-00007101.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AM1KX8S023315;
	Fri, 22 Nov 2024 05:05:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=illinois.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=campusrelays;
	 bh=RXvrHdd3VfKVnXzzZPOQaOfjxOP9nhAj15k1kWvfEEo=; b=Gi0OI0Cg859r
	vLOJvhuqCDBgFsxGLq44lOiTLcIkzS0uFijoz/Tu437/wtEBPD1Ja49lijjaXyDu
	r7EVghU6uRdqbBSnxK3DqXiDtXgyyOKHmJO6j108FzWaDPduMARz8L+5t6wo1/+c
	belNFKnU0zNI5A5RtlKSl1f1gPCLZ0LRrextzmAE3KN7dVeoF+cFjBj8A8xagg/w
	PhDekX+SmfjfPNvKFFPzVx852LLBAKm+h/xiNC3+smIxrecXDzZDws0n29sghE8Z
	nCyqwiUejwrEP+DRq0Lren3U/IerlceSryDeLZBIB6CZW7YyXQ5sqzmzaQJj/RFD
	8Vqqtp2R/w==
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
	by mx0b-00007101.pphosted.com (PPS) with ESMTPS id 431m10w9cu-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Nov 2024 05:05:29 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m4b1rjhKjjhdsggiaGFDwMVIAfa88dMmdIRe5wsdCRe4dY1ud5F4MCyQsrqxZok5T0jMRqDcmSwHgLBhwTk8OFSZUGr2YsDIa12cy2n9wBkYDSAvhgS2KRHAMFXurUmumlznFFxKO9uf5mHLRdvb97kPJoAovW9a0KnvJXO0lcZAzX6UdbOlPNDyz4AZAnD7rcneJ3FLU6qzamDVbgTX6HzNKHdL097qtzGqoABSmstKC3gyxK+UfrABizGKFThx1yNEB65ASdYb6EZDWMVqB9I2V+WtXG0R5hSS8b/ZVc1wVFPTN6hPLsZtn/P4xuKFiC8zXxdS/2f+3cjcbhFd2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RXvrHdd3VfKVnXzzZPOQaOfjxOP9nhAj15k1kWvfEEo=;
 b=iudjgkbiZL0GeQIlt8XlXWILrQEn3tFE3p+/XZqwyVooKSqkSUiTHhO8hMqzfuJHLaD13ld4wbgK5RhprHx2xfwD58Hd1j6mTOV5PPbMC7f8/tffiadWi+nbLFftBmq74Q8LtDqRy2sLi5FAhKltpqqBNMf1+w+W5o1cD1fY53ZNBzzK5vZePSy8WTc9fXuCx8h3Eq2ow12zwX8CpCPYPwx1/q/7yX0lcYtyCJS4Z/dv+QxyhsZJrqx6sV9tkFlXa+urwr23SnnOB0V8szZAtwk819iFbyfNg1KVWZ9XFYYi8S1LHBYDpw26JSIdP31bTy1Rt99xtecUrvGZXvFgIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=illinois.edu; dmarc=pass action=none header.from=illinois.edu;
 dkim=pass header.d=illinois.edu; arc=none
Received: from DS0PR11MB7286.namprd11.prod.outlook.com (2603:10b6:8:13c::15)
 by CH0PR11MB8233.namprd11.prod.outlook.com (2603:10b6:610:183::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Fri, 22 Nov
 2024 05:05:24 +0000
Received: from DS0PR11MB7286.namprd11.prod.outlook.com
 ([fe80::d52:d2da:59c7:808]) by DS0PR11MB7286.namprd11.prod.outlook.com
 ([fe80::d52:d2da:59c7:808%4]) with mapi id 15.20.8182.016; Fri, 22 Nov 2024
 05:05:16 +0000
Message-ID: <284fe8fa-c094-49b7-8e16-3318676d38e3@illinois.edu>
Date: Thu, 21 Nov 2024 23:05:14 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] Enable measuring the kernel's Source-based Code
 Coverage and MC/DC with Clang
To: Nathan Chancellor <nathan@kernel.org>
Cc: Matt.Kelly2@boeing.com, akpm@linux-foundation.org,
        andrew.j.oppelt@boeing.com, anton.ivanov@cambridgegreys.com,
        ardb@kernel.org, arnd@arndb.de, bhelgaas@google.com, bp@alien8.de,
        chuck.wolber@boeing.com, dave.hansen@linux.intel.com,
        dvyukov@google.com, hpa@zytor.com, johannes@sipsolutions.net,
        jpoimboe@kernel.org, justinstitt@google.com, kees@kernel.org,
        kent.overstreet@linux.dev, linux-arch@vger.kernel.org,
        linux-efi@vger.kernel.org, Wentao Zhang <wentaoz5@illinois.edu>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-um@lists.infradead.org,
        llvm@lists.linux.dev, luto@kernel.org, marinov@illinois.edu,
        masahiroy@kernel.org, maskray@google.com,
        mathieu.desnoyers@efficios.com, matthew.l.weber3@boeing.com,
        mhiramat@kernel.org, mingo@redhat.com, morbo@google.com,
        ndesaulniers@google.com, oberpar@linux.ibm.com, paulmck@kernel.org,
        peterz@infradead.org, richard@nod.at, rostedt@goodmis.org,
        samitolvanen@google.com, samuel.sarkisian@boeing.com,
        steven.h.vanderleest@boeing.com, tglx@linutronix.de,
        tingxur@illinois.edu, tyxu@illinois.edu, x86@kernel.org
References: <20241002045347.GE555609@thelio-3990X>
 <20241002064252.41999-1-wentaoz5@illinois.edu>
 <20241003232938.GA1663252@thelio-3990X>
Content-Language: en-US
From: Jinghao Jia <jinghao7@illinois.edu>
In-Reply-To: <20241003232938.GA1663252@thelio-3990X>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P221CA0018.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11c::19) To DS0PR11MB7286.namprd11.prod.outlook.com
 (2603:10b6:8:13c::15)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7286:EE_|CH0PR11MB8233:EE_
X-MS-Office365-Filtering-Correlation-Id: 66193b42-07eb-46ec-87d6-08dd0ab34120
X-LD-Processed: 44467e6f-462c-4ea2-823f-7800de5434e3,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M0ZoNzY4cmViRDkzSTZ3YTAxWjNHUTJYUGxuYVZVejlFOElVd04vVzZ4NjdR?=
 =?utf-8?B?VzdHMFBZNkpPdmZ4eEVrR1pzWjN0cTJZZmh6ZVNwRGU2WXdsQXZ6L0ZYWEhE?=
 =?utf-8?B?ODJacVY1a0NqZVZhOWVLRTEwSHRwUW4xUVlNM2MyWG5LVzdDTVFGSHNPQ2lH?=
 =?utf-8?B?a01zWHlzTnc0K3doV2dvdy9PcExhRU5JNlpoTWw2cVlCSk1qb05SeEo5eVF3?=
 =?utf-8?B?VlRjNDdMQSs0d1BXaWJpdU5lcXNVdEsyb3hra2E0b0JkQ2RPQUJFeHJaQ3hz?=
 =?utf-8?B?U2F0MTB4L2UyKzlHZyszUkVYeEpYWlhPMkRveWhncW1rMzc3bi9LZHoxYktV?=
 =?utf-8?B?aEdOa1dPQ1RjcC9TYkt3OCtPcm1zOXl2WmNnN29kajdrSlBjeGM4RGpvbUFL?=
 =?utf-8?B?RlZtSGZqc2R3RDNWWGZCdHVPSGtWS3pERFgrQ3N4Z3RreGtIVGZlVGR3UjhK?=
 =?utf-8?B?Z1Y3RnBuTGhsV1hjcHY3SkhNTTN4aEdydUo2KzNMUzROdkJBWDl6Yllmb1ZQ?=
 =?utf-8?B?TGRTZHJ1UWxKa1lMQ3BBOVczS2IxOGJuSnBqWVlCTnpKaTNHNTdqL3ZzaDJL?=
 =?utf-8?B?VWg3SVhzV3lmeVZNd05VREprYTBvN2tueU11SThPVXdJdWtLdlBXRlYrRHhE?=
 =?utf-8?B?WFViUDlFRzdOdGE1N1V6eFVqOHZadFBncFV1MEZBV0lYcElxRW5EUHEvQTBq?=
 =?utf-8?B?cWZZb3RQSjEwTG13U2NFdHZLbDYwNXVPd2hrdjhTZXdyYnhNeWpuRTY4OFBK?=
 =?utf-8?B?bWR2VWtUaVo3MC9nUFY4WkJlQndrQjBMbk1wRmY5Nnhxb2ZZREQvWVF6ZWZD?=
 =?utf-8?B?QnRYZmZUbmoyZEJtTERHSjVxMU1oUFNqZWo0Qmp4N2pDSFhPaUlZUXVBUk5R?=
 =?utf-8?B?eElHRnFjUGlpM1g1bm9QTHVQMUdtZG5iS2NpdHJ3WHc5QjZ3TFgrbkV2VFR2?=
 =?utf-8?B?c1FTV0ZoWURHUHFqa3o2SHEvdnY5Zll3TkROQXI2a1NQdXdJaXdQdCtmR3NC?=
 =?utf-8?B?OW5iSzBINXVmL0VXY1VOU1BWT010TXFZMk5VNUIreVJJc05OeUtySDBCZkJP?=
 =?utf-8?B?cE8vU3lNdWc3OC8ySldMeFRpTTJFUDRnTkNQVEJWRE1IMm1OdnR3d1R5Tysy?=
 =?utf-8?B?bmMrem54VkpuNXB4cDFyb0E0UXVLSU45bEIxbDZXSEVkd2xQOWIwUTNzZk5V?=
 =?utf-8?B?YVIxTjNLc1dEOVkzZFBJS3JBQU5LUWxxWXlseWpFQmN3Y1AzN0lreGFwYmhJ?=
 =?utf-8?B?MU9FRFRjOThQdzVCL3BVRkxRT1p0Uk9CRkFFbEx6TmhsS1p4YnY2ZDgwK1Z2?=
 =?utf-8?B?aWdZdnFVUU41a1NxTSsxcHhWdFh2MXZHYUZJWjJ3VGpGaVh6VXV0aXdXaTR0?=
 =?utf-8?B?VXcyY2VId2QydkpIWTgvcTVXaU5DVVNHRjlYQlZrYWhQMitHNkpUZkE5MjVX?=
 =?utf-8?B?UzZydWdKQ1lyUXZSSmlDUHN6UEVUR09acU1mQ0lJU1hkbUl5UTZRUVExdElP?=
 =?utf-8?B?UHZVc083STV6N3ZqN0pRNU1GQURSR0JTTmdpWnhFZm1oZVlodXB4S3BPbXlU?=
 =?utf-8?B?bjNhdnZQUUlCQTBIT3JRVjRjKzdCYkNnOGZUUnZBMVRwUG5GR3hMdmtWMzJE?=
 =?utf-8?B?S3I2bDl1cE84SkFvOUhVRmE1MmY3Y2VBMHRZbzVocjFaYkZrdXJlZEM3NzEz?=
 =?utf-8?B?cncwcEtDbThUQ0k0c0NTYkFsWkRtUVpWZGZsbEVsUHlsSUtPUHdvZ3ludnNR?=
 =?utf-8?Q?gGUACxCEsG9co+GPE69CigfHluV6ym1JdLEdZn1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7286.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d0RveUVUTGlYdHRaQ0pvNDg5TE1kaVlYSysrL1kyVlhveDhFdDRNamp0b2VQ?=
 =?utf-8?B?TFp1ZDVPSjVXMGdCQm1Oemc2M2RVRlB0Kzd0VE9sbGpoZGtGOUVicCtoRFpr?=
 =?utf-8?B?T0wwbnVUWWtQOWRjbGMyT05QenordWZOTmwyUGpSSTY0VHRKOFVSZXZva0FN?=
 =?utf-8?B?eDY4VHZUc2JnMzl1cFZNZXM1SGU1UEZXamVzZ2VEZVIxUXZtR1A5aXk1NWtl?=
 =?utf-8?B?bVRNbTBMZ3lXYUZIaVhRQlNJNGZtSm5YSnRCZEJTT3Fmdzczem5reDR3eFBM?=
 =?utf-8?B?ZFd6bER0aDNVY3VDK2ROdUcwQVlaTWFKL3lUNTVjRlhlMFc5QkNCSnpCUjY4?=
 =?utf-8?B?Q09WWTJxdnhyMHY5aFdNNGJEUE41RkJOK2JTenlTczlqOUF5K0FLd3dSdXFn?=
 =?utf-8?B?VlFKY3JSMW1DRGdMYzBBbUt5Yk5IMGRsdFBJaDI3OFdpdHhDOUl0Q2dLYStz?=
 =?utf-8?B?YTJoSWNHWDhlVUpjSUxBMDZiOC92NDhuTkRJMzZHdnBxQjR0aTlMbmdKZlgz?=
 =?utf-8?B?ZHpWQWpNcWg2WVVSQ3BjSm9kbUFMeVkwQVRrbEMyVkZpckpGZ2tWQURvRTkw?=
 =?utf-8?B?RFBtSlc0VlRrdisyd1lMTkZaNFVyWlFNSU9aWlVlUWtwb3V0TitNZ2RqLzJ0?=
 =?utf-8?B?aVV1L3V3TXE4bEo1SnRXS1BUcXBWMUJJVnNzd1B5eXR5OVhvMWNkbW9sMHZC?=
 =?utf-8?B?Q2l4Vnh3QnZFMHZSM3NabW80YitEOTRUMlNtQVJjNjJueHM1bitPUllucVJV?=
 =?utf-8?B?Uktqb2IrUEt6NzdiMWVEOU41NUhsaVQxaXNJbXJyc0VEbUx4NFJ3QVlZbTRK?=
 =?utf-8?B?NnZPeDlEUHZPUTA5a3ljZDFvUEw4eDBWR1RjVTRhN2RlSkNhNGtRS0ZuRElG?=
 =?utf-8?B?cDFXUlBqcVVBTG9KKzFMTGFCRWsyN0k2LzFKRkhvUGdIdklaV294MmNGbHFU?=
 =?utf-8?B?YllKcktLSUgxZzgvMmthOU5tTG1jakVMQWk3ZjFVWnhaOFpPWWtSL1hiVVJD?=
 =?utf-8?B?azE4ekVCNUQxRWFZbjBPdUtBL2k0eXlFWnZUd3cxR3UyMjM5aXYranF2VFJ6?=
 =?utf-8?B?OWR5NXdBMXRVOSs0cnM0TTg5b3R6VDAxbEp4ZG51ZEdZMEF1dnMrV05hbFlV?=
 =?utf-8?B?bXpzanNyMUdGYzhGV3lrMDJPRUROWTNSeWMxMUhpaCtySDFETVVGbjhoMUFH?=
 =?utf-8?B?RVJqa2hoTkdvRDhxSys4MVVXTHpaUzNpT0pEL3FyZmxsRFpZZWdHeVVBbE5w?=
 =?utf-8?B?TDlwY1hFYklpYTUweVhRd01EeUNtOXRSS2dTVWkveWdjRDBoRHFYSmdkTXFD?=
 =?utf-8?B?SkdyOHlCaENlUDNnMkFtMSttUGFJalo3eE1HUTFzZ0hENXo4S2VwcGpzYmFI?=
 =?utf-8?B?c1AzREMwL2VFSjNRWE1RbFRVL2djTktKY0xmMExBVmdVNjViZCtGTW54WWIz?=
 =?utf-8?B?K1I2L24rbEJSTUU1UnJjR0QzQklvTTduSGVlUktmcEoyUDVqZnRuOHEwM1Yz?=
 =?utf-8?B?bzgrbHlGYVJTTDRPN1V1emxiK0FuektzaXVLMnB3WEt2NVIzSnNuYnJYN3BR?=
 =?utf-8?B?Z2FOZmdjbVdCWGMzR25wTGNlanNjc3hNRkY2MHJQTXZsSjhTMDJIaXhPU2FR?=
 =?utf-8?B?NXl5Y1RBdGhVSWlDZEtrWTBUL1VidmRWd1JDV1d5R3pDeXRjWmc3KzhoQ1NH?=
 =?utf-8?B?NUFiZ3pMTTFOT0dhejR1NW5sV1FQMFE2RGFmaDNSbVVpb0ttMEVyMVlRYlN1?=
 =?utf-8?B?ckR5WHhkamV1eEszRy9lVHYxNWY4Sk5PajNoRnpoanJhd3JBY0dTS0pJYlJP?=
 =?utf-8?B?V25na2Rxc0lXY0htOFA1UEhJOGxOMHAvaVIxamJYeVBIcW9rdzVySldidWc0?=
 =?utf-8?B?b0VsTm55MUR5c3dPT1RheDFhemFuT2RYZjdIVnVUTEl4QklFZlZHdnloRVVT?=
 =?utf-8?B?UUtLdDNjU0F1c0lIeEJxdHI3NmkwR0dUOWY1elNZbHM5bEZmakNUeVRIN1lC?=
 =?utf-8?B?bmNkZWRNYnFmNXRZTVljbk1RaFVWcWxkMTlhZm5rbTQ4L1lFTm1iL0U3VFZ3?=
 =?utf-8?B?ek9ENHBNUVFZczl6T0g5cUc1N2JlejZFVThJRzk5ZktkVEFLN3NCL3dFOHFj?=
 =?utf-8?Q?+yh4qN9dLYel2dhVDlOJjTJxp?=
X-OriginatorOrg: illinois.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 66193b42-07eb-46ec-87d6-08dd0ab34120
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7286.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 05:05:16.7314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 44467e6f-462c-4ea2-823f-7800de5434e3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FMSQaX3ZwallINNhf1thINWTMFF7EyBlELFRmxwFyxB8YPdSuZ0PVBEZiKu9hhTQrfrD39DIJShdMYnJDh0fmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8233
X-Proofpoint-ORIG-GUID: WSpmIfItbiAwMm0PG3UBlCHkj0uMzp5_
X-Proofpoint-GUID: WSpmIfItbiAwMm0PG3UBlCHkj0uMzp5_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01
X-Spam-Details: rule=cautious_plus_nq_notspam policy=cautious_plus_nq score=0 mlxscore=0
 lowpriorityscore=0 clxscore=1011 impostorscore=0 spamscore=0
 suspectscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999 phishscore=0
 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2411220041
X-Spam-Score: 0
X-Spam-OrigSender: jinghao7@illinois.edu
X-Spam-Bar: 

Hi Nathan,

Wentao and I were looking into this issue in the past weeks. The high level
conclusion is that it seems to be some problem with lld and I will go over the
detail here.

On 10/3/24 6:29 PM, Nathan Chancellor wrote:
> I seem to have narrowed down it to a few different configurations on top
> of x86_64_defconfig but I will include the full bad configuration as an
> attachment just in case anything else is relevant.
> 
> $ echo 'CONFIG_LLVM_COV_KERNEL=y
> CONFIG_LLVM_COV_PROFILE_ALL=y' >kernel/configs/llvm_cov.config
> 
> $ echo CONFIG_FORTIFY_SOURCE=y >kernel/configs/fortify_source.config
> 
> $ echo CONFIG_AMD_MEM_ENCRYPT=y >arch/x86/configs/amd_mem_encrypt.config
> 
> $ /usr/bin/time -v make -skj"$(nproc)" ARCH=x86_64 LLVM=1 mrproper {def,amd_mem_encrypt.,fortify_source.,llvm_cov.}config bzImage
> ...
> vmlinux.o: warning: objtool: __sev_es_nmi_complete+0x6e: call to kasan_check_write() leaves .noinstr.text section
> vmlinux.o: warning: objtool: do_syscall_64+0x141: call to lockdep_hardirqs_off() leaves .noinstr.text section
> vmlinux.o: warning: objtool: do_int80_emulation+0x138: call to lockdep_hardirqs_off() leaves .noinstr.text section
> vmlinux.o: warning: objtool: handle_bug+0x5: call to kmsan_unpoison_entry_regs() leaves .noinstr.text section
> vmlinux.o: warning: objtool: syscall_enter_from_user_mode_prepare+0x105: call to lockdep_hardirqs_off() leaves .noinstr.text section
> vmlinux.o: warning: objtool: syscall_exit_to_user_mode+0x73: call to user_enter_irqoff() leaves .noinstr.text section
> vmlinux.o: warning: objtool: irqentry_enter_from_user_mode+0x105: call to lockdep_hardirqs_off() leaves .noinstr.text section
> vmlinux.o: warning: objtool: irqentry_exit_to_user_mode+0x62: call to user_enter_irqoff() leaves .noinstr.text section
> vmlinux.o: warning: objtool: irqentry_enter+0x45: call to lockdep_hardirqs_off() leaves .noinstr.text section
> vmlinux.o: warning: objtool: irqentry_exit+0x4a: call to lockdep_hardirqs_on() leaves .noinstr.text section
> vmlinux.o: warning: objtool: irqentry_nmi_enter+0x4: call to lockdep_off() leaves .noinstr.text section
> vmlinux.o: warning: objtool: irqentry_nmi_exit+0x67: call to lockdep_on() leaves .noinstr.text section
> vmlinux.o: warning: objtool: enter_s2idle_proper+0xb5: call to lockdep_hardirqs_off() leaves .noinstr.text section
> vmlinux.o: warning: objtool: cpuidle_enter_state+0x113: call to lockdep_hardirqs_off() leaves .noinstr.text section
> vmlinux.o: warning: objtool: default_idle_call+0xad: call to lockdep_hardirqs_on() leaves .noinstr.text section
> vmlinux.o: warning: objtool: cpu_idle_poll+0x29: call to lockdep_hardirqs_on() leaves .noinstr.text section
> vmlinux.o: warning: objtool: acpi_idle_enter_bm+0x118: call to lockdep_hardirqs_on() leaves .noinstr.text section
> vmlinux.o: warning: objtool: acpi_idle_do_entry+0x4: call to perf_lopwr_cb() leaves .noinstr.text section
> ...
>         User time (seconds): 670.86
>         System time (seconds): 459.05
>         Percent of CPU this job got: 169%
>         Elapsed (wall clock) time (h:mm:ss or m:ss): 11:06.15
>         Average shared text size (kbytes): 0
>         Average unshared data size (kbytes): 0
>         Average stack size (kbytes): 0
>         Average total size (kbytes): 0
>         Maximum resident set size (kbytes): 38644844
>         Average resident set size (kbytes): 0
>         Major (requiring I/O) page faults: 18694
>         Minor (reclaiming a frame) page faults: 23068856
>         Voluntary context switches: 32215431
>         Involuntary context switches: 46422
>         Swaps: 0
>         File system inputs: 0
>         File system outputs: 40127696
>         Socket messages sent: 0
>         Socket messages received: 0
>         Signals delivered: 0
>         Page size (bytes): 4096
>         Exit status: 0
> 
> $ curl -LSs https://urldefense.com/v3/__https://github.com/ClangBuiltLinux/boot-utils/releases/download/20230707-182910/x86_64-rootfs.cpio.zst__;!!DZ3fjg!7BrjObiTQ7yWOq1feQGQPxe3uzUM5t4pPHkLUuijWyjOwoaX2rdCwZoD4P52pNU_t1tCT2OCWV3GPtNnAw8$  | zstd -d >rootfs.cpio
> 
> $ qemu-system-x86_64 \
>     -display none \
>     -nodefaults \
>     -M q35 \
>     -d unimp,guest_errors \
>     -append 'console=ttyS0 earlycon=uart8250,io,0x3f8' \
>     -kernel arch/x86/boot/bzImage
>     -initrd rootfs.cpio \
>     -cpu host \
>     -enable-kvm \
>     -m 8G \
>     -smp 8 \
>     -serial mon:stdio
> <hangs with no output>

This hang is caused by an early boot exception -- gdb shows the execution
reaches the halt loop in early_fixup_exception().  Dumping regs->ip associated
with this exception points us to the following instruction:

ffffffff89b58074:       48 ff 05 85 7f 4a 76    incq   0x764a7f85(%rip)        # 0 <fixed_percpu_data>

This is apparently an incorrect access to the per-cpu variable (the cpu offset
in %gs is needed) and triggers a null-ptr-deref. Without CONFIG_AMD_MEM_ENCRYPT
(one of the bad configs), it turns out the instruction is actually accessing
the llvm prof-counter of strscpy():

ffffffff89b85a04:       48 ff 05 6d 94 7d fa    incq   -0x5826b93(%rip)        # ffffffff8435ee78 <__profc__Z13sized_strscpyPcU25pass_dynamic_object_size1PKcU25pass_dynamic_object_size1m>

This symbol is left undefined in the bad vmlinux, which explains why the
faulting instruction is accessing address 0.  Tracing through the kernel
linking process shows that the symbol is still defined (as a weak symbol) in
vmlinux.a and vmlinux.o, but becomes undefined after the first round of linking
of the kernel image (.tmp_vmlinux1).

After playing with it a little bit, we found the creation of vmlinux.o to be
the problem. Specifically, if we use mold[1] instead of lld to create the
object and pass it to the later stages of kernel linking, the symbol will be
properly defined as a data symbol (and the kernel can boot).

It seems that the issue does not reproduce with LLVM-20. Nevertheless we have
reported[2] this to upstream llvm.

[1]: https://github.com/rui314/mold
[2]: https://github.com/llvm/llvm-project/issues/116575

P.S.: We used mold because gnu ld is simply too slow with all these llvm-cov
sections -- the vmlinux.o step ran for 10+ hours and still didn't stop. At the
same time, the fact that the creation of vmlinux.o does not use a linker script
allows us to directly plug mold in.

> 
> Cheers,
> Nathan

Best,
Jinghao


