Return-Path: <linux-arch+bounces-13224-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5C4B2D175
	for <lists+linux-arch@lfdr.de>; Wed, 20 Aug 2025 03:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBDA7622C11
	for <lists+linux-arch@lfdr.de>; Wed, 20 Aug 2025 01:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187472356C9;
	Wed, 20 Aug 2025 01:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="q59VTyy8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="f9eLnFKq"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4263321019C;
	Wed, 20 Aug 2025 01:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755653614; cv=fail; b=ONBEqsLl1ExHvTPDjWEPwZiDGCPmbtqoqaJMl/Cs/YKubxkOGOX2BP5a4hRgkYn0aguFsoCr9tFIMR0U1QSYFXG8KY3UhGaBxTiQI908BqqjUrJptryEjq9ekr5gmdpnQ/HZMZVykkWqlcV48THptqZf/RzI9yPOvZ0ItVyz7qA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755653614; c=relaxed/simple;
	bh=vV72i7B6C0ah505qypWCcfCJIJzTCIRCfyv7C0mZ5Ko=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bgMCJOEhEn4fsP6/9ttbh8wjso6czdYOuD/5fcaWQcjpfanUIi1izMyjfsZmdY7P42BMhuWocNztJzRjP9NlVE9RBiaWtbeJM4TwGagVgScZFDbx81KhTKpb1dJrCQMwgthhb/TfGIpNSUCPCuAiB1h7BT1Fj+Ln7vyBrQTM0MM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=q59VTyy8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=f9eLnFKq; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57JLBvuX005009;
	Wed, 20 Aug 2025 01:32:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=xbEmk7EbAi9QLLc568iiaGakQQqFjSqr6hixUYwkAjs=; b=
	q59VTyy8IK8qtpi2mPN5ZEBiu0WBaq28rUPJ1YEf7XsK/Y2vFVoG0mGjjwz5JVXX
	aC+TOwo62Nng/iLa6JdLJlqtOJeln1vmJn5DO5/Ve8zA22o/6FIkJyYwgv9jSk0Y
	4jivAIDu/Ozc3woe4+bhphcnBNUPAYXPpH7rdldhyjQCjfqqBd7DmOtlYgE/aVSs
	sL5rQQRH4C7DCzW0nzqoVudSwnMl3iCgV8HT9oW2CiZr9PlRjjKh2pFAqN0obddB
	lbjNSCssQFwD3FMFPzfYXXdL5WBr5uuv/ZSJAEZQFfvusjGPrLjc0RBBdBL3P/ED
	TWptbFfnQqWBT8+GGmXIaA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48n0tqr91u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Aug 2025 01:32:51 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57K0OT0u026975;
	Wed, 20 Aug 2025 01:32:50 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48n3svhg39-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Aug 2025 01:32:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FvrB/sw6//lbkAGoqafG6GtVL2G0QQ7kBUF0xulHNeojRukfQPTLoVxX/4iLtdJofgBDe7EwTS2HyY9Fo11/GsHdroRaXJywXlQa+VM98w6FABrwoM7RjKvoB+j2d2WPnGYZmxAVcvxsmyQNghNkx/2Muz4/H1EOVMhVKc797aanQj3XpfrhrGHF0Ko3x7pfdZlIVkyabUinFDSi9vNyO6u9RwaM2gNJEl3o3lpUmIQoIulECNEKftINC/OKA3RNQY1ts1HXtbXGvXXxAWnZIk/ZmfGMFt1TpdcDaMbU5pvnh0VJIzm/LODWE2Hx36luUKJU3d/MzC1fDaDQ/Bl8Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xbEmk7EbAi9QLLc568iiaGakQQqFjSqr6hixUYwkAjs=;
 b=We2xIqaQMV051z3DS5IMWazuzE7b4zk4PP4LvhIGbzvWwE0UGaCYHFFGDhU3xyF1W58lFvlEYWX3R9cx4oEgv5GwVdFds23xGbkJGf61/JlGWO8wgub9RE6LYlAkkxVXCqm/eUxNQ6rIwiQ134WFv/wP99HZtGV58QVA4Q1nzJ5n78KaGb346lAkMXq+/rZKboaN5sT0k0ObcGgeRWG+3Zi/LMjw2AhqWOps9RAbkeDyQwoaxmN0p+qiLGo09AsmY3H0GTPBvJ83SDqaJ4f1fOq13zYM8WFl6pCZE317+ED9ZB7Lhxh8X4tNC6VKJ7bRt52eu3+w/JX9PFFVjnajPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xbEmk7EbAi9QLLc568iiaGakQQqFjSqr6hixUYwkAjs=;
 b=f9eLnFKq06nmcZd77Zmj+V8PTANgmbA1/PEH7axNkRSt83hv2w4HrOMhDnEv95FiGGWxbvjMxSFQyyWXhaJkEEV9a7sZmWimLi84HGHIgjVTiiDt0p/5h/X+Fd9M6z/ReppryQ2qKJyNBUdI96Wiiglp+9StpGyzpUfG7nt0z2Q=
Received: from MW6PR10MB7660.namprd10.prod.outlook.com (2603:10b6:303:24b::12)
 by IA1PR10MB7240.namprd10.prod.outlook.com (2603:10b6:208:3f5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 01:32:47 +0000
Received: from MW6PR10MB7660.namprd10.prod.outlook.com
 ([fe80::41fa:92d3:28b9:2a15]) by MW6PR10MB7660.namprd10.prod.outlook.com
 ([fe80::41fa:92d3:28b9:2a15%7]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 01:32:46 +0000
Message-ID: <3701bcd4-ad8e-4daf-9b1b-0bc1a7d5f2b0@oracle.com>
Date: Tue, 19 Aug 2025 18:32:43 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/20] x86/mm: enable page table sharing
To: Yongting Lin <linyongting@bytedance.com>, shuah@kernel.org,
        skhan@linuxfoundation.org
Cc: akpm@linux-foundation.org, andreyknvl@gmail.com, arnd@arndb.de,
        brauner@kernel.org, catalin.marinas@arm.com, dave.hansen@intel.com,
        david@redhat.com, ebiederm@xmission.com, khalid@kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, luto@kernel.org, markhemm@googlemail.com,
        maz@kernel.org, mhiramat@kernel.org, neilb@suse.de, pcc@google.com,
        rostedt@goodmis.org, vasily.averin@linux.dev, viro@zeniv.linux.org.uk,
        willy@infradead.org, xhao@linux.alibaba.com,
        linux-kselftest@vger.kernel.org, libo.gcs85@bytedance.com,
        yuanzhu@bytedance.com
References: <e3aca3b7-4f38-410d-91d6-5a2521dedb6c@oracle.com>
 <20250818094402.13385-1-linyongting@bytedance.com>
Content-Language: en-US
From: Anthony Yznaga <anthony.yznaga@oracle.com>
In-Reply-To: <20250818094402.13385-1-linyongting@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0020.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::33) To MW6PR10MB7660.namprd10.prod.outlook.com
 (2603:10b6:303:24b::12)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7660:EE_|IA1PR10MB7240:EE_
X-MS-Office365-Filtering-Correlation-Id: 09bcdac4-5ea7-4c2f-1d2e-08dddf8977ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R2hrMGNNWlpYaG9xSmtwQ0xwRjRzVnM5Ukgxempad08wSEZTOHBWcHJGTWtG?=
 =?utf-8?B?YnFNSURHMGJXNTNEb1FIdURKb1hveURMU0h5b3J2ZmxQSmd3SmRLdGRrdEx3?=
 =?utf-8?B?Y1V0dmRxNmtkOGVkNUtmSjV2LzRhbDdVVko0U1VuOGtUcHBqMWhsQnpKVHBh?=
 =?utf-8?B?RUd6MndLbi9WUW5FNklRQURiMFB5UlE5bk4zbHJ3OWZ5OWYrY09rN1p0RHpX?=
 =?utf-8?B?am5DM0hySTRxL3NKcndObThtZndPaXpGcVRBL1hyWmxrajVTdGtzcGNPNGNR?=
 =?utf-8?B?dkgwaE13NUw3b2JYU3FxT0U2ckk0eXRJTndjakpIb1o3bHFHUjVZVjFoc21h?=
 =?utf-8?B?QTBjcmpUTURIS1hpVXZXa3hGeTgxTmtFbG1ZLzRqRUU4VFRLSFVmK2VXWlJT?=
 =?utf-8?B?ZzlhRktrTS9GZGlSRERlWm40bm5VdXpLcC9oYlhsblNadkI3K3RkRHNDYkdH?=
 =?utf-8?B?bzJlbXdDRG9lRjRQRkhDRCs5bHJwbHlXZkp3WXJuZkdmL2xwTWVlL1VheGVD?=
 =?utf-8?B?SjlyZzE2cG1LcFIxWk1mNlpWcXZlU0d4YTg1eHlQRVdrUnFEelV1Z0RpdW5C?=
 =?utf-8?B?SkFMMEdXbHcvcEdwZlBKV25iNElrdVRPME81aW5wVXVESVlpYkUzaXdNMjZG?=
 =?utf-8?B?K3N5TXA0Yy9QSFo1Z0xLZmdDTXhmWDRhcTA0K1hNSWNNamRtemhMVGJJTHBT?=
 =?utf-8?B?a3MrUm5CNjJ0dExUcGxzRGM4VTZtYjhTMDdmdTl0a2w0dUtnZ2NBa3JQcjJj?=
 =?utf-8?B?OTNpWmpaRkg2LzlEL1VEbitVRENPR1dPblloQjRjTzF2ZHFjNG1Id3dCOTZF?=
 =?utf-8?B?WkJIQU1QVmpXQVJRUEh0Rm9mSlVOWTBHUE1Nd0tXVmF4d2pCY1J2NnNiUVQ0?=
 =?utf-8?B?RGJCWUVuN3RWbVRRR21MUXFSMGRydm9PaFRMRVMyWmtTWHVBWTBUaHczVlpk?=
 =?utf-8?B?NXh1SWxwRytydE03MUlBUDZrRGtDU25sN040NUgvS2FTRTlnSk9JbmlSNFE1?=
 =?utf-8?B?OEwxdDBncVJwMDE5TlUvNStQS1JUMjZtSzVCN0NDOUlDWmJCRk1UKzNzWlBC?=
 =?utf-8?B?L0lyYUtaZjlxeTR5eDJwbzFLR2JxSXc3N0xqSmlvY1FaU1Zza1VvM2pSR084?=
 =?utf-8?B?eER0MVRVeVltSUsvTHpCeS93dnhMZXFPSStjVGs3Rkl4MjZLYUZWc2JLNTdi?=
 =?utf-8?B?NUZPYUpZR2RvWDVBRVBaMHdQblVNS0w5bkw5N2w4ZCtkYjh4ek1GaHZVMzZC?=
 =?utf-8?B?SElJb211Njh5T0k3R2xmUHc0NkdlcEFoZElldkxwZGpnYStEWUhCQk5Va2tR?=
 =?utf-8?B?bTlVU0p4Zk53VmFrbVZuQjJpT1JTMWFwV2ZGNkxVN2c5eDlxMDh6bEN6MEcz?=
 =?utf-8?B?alBIU3NzLzIvQWI0MHhSSEtycWI2MUZOV1F2T1ljYXNqUFNEeUxaQ3NGaWpp?=
 =?utf-8?B?MzhlQW41Q3U4clZncllONlNhMU9ucTVOQ2VmWWsvSXpLNi8waEdmbGtIR2lB?=
 =?utf-8?B?L1hsOGtuczhTQVk2c1g5aThNZzNVdE90K3lwSjd1THNlU3pWYXkrUG5EMWZQ?=
 =?utf-8?B?cXNhM2o2SzhYdG9PVm5KemFmckxaNWVYMFhjb3JZU1EvRkJ0eEVaYTlsamJV?=
 =?utf-8?B?RVp0bms2d0Y1cUk5UGs0dkRwbm1QcGFTdzhvZk9YVUFrRVlKRk9FcVB2K21n?=
 =?utf-8?B?V0E4MlQ3Nm56WGJWc294T0R5WkR6OUdmNGNCa0s1SzdZb2k4YThWbUZGbEJY?=
 =?utf-8?B?ZzVzZGF5YjViS1VlZzM5NDlXNVdod0phcE9FYlBlV2JmSllKVU1aSS8veVRW?=
 =?utf-8?B?a1pNQUVYR2tLWERCZ3ExMlRLTkM1Q0dacVlMbUZDVXc2UjJiOXhoeStKVHdW?=
 =?utf-8?Q?k+VuKmFL8fs4s?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7660.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z1FIYUxmL2x3eTA0dFRWSXRoUGoyYTZaZEdlU1BWR0xGZE1CY3kzVERrNzZ3?=
 =?utf-8?B?dTNSbTl5Wjdyb095Nk1WdjRqQ3ZlenlqNk1lYWZ1RjhaOWNjSkF2SmhCYkxZ?=
 =?utf-8?B?VFZYWnBkNGorVmt3bXFYNG5pMVpSWlFYT1pEeW5nY01iOVpHcng3OG41cGVv?=
 =?utf-8?B?S3RpMUpzRzNYR0xubE5vSVdNeVhTQlhhV0t1dlNZZGJBOVdiVzczWkVXL1lW?=
 =?utf-8?B?SCtwdGxrdjg4VU5EMEE4eGVOYysrSUVQMXpNQUlvVWFKWndzOUpVZVFSNjJH?=
 =?utf-8?B?UmNvUHg4azVXUlBQMld1Rm16Uy8vYUlTSWphZy92ZllDUkQrYnBSMC8xQlJq?=
 =?utf-8?B?cmx0L3ZIbFF2VjhyQ3I2MEdmTTUvdXdUZkJsNEhpeDJGczZJY0Fid3JlbzBy?=
 =?utf-8?B?STdiMVdrT0xWa3d4Rjl1K3F1V0VYNnkzN2V3VGRhaWNjTzF2SkRhOHZPZnVh?=
 =?utf-8?B?OUtBc2NyZUVQaTdpZVpiUlRsRmVkcXp0Z2hVSEpVUEluSlVNSXZ4QWpuZ1M1?=
 =?utf-8?B?M1FObXpueXgvWjZPVjJYb0dCTnNVbkRQam1FOG51aFptYjlhMHNKbTArVDlq?=
 =?utf-8?B?aTFFTXlRUXYwVUxDUVFlcUVxMGZTRzBKaWg1eWlzSmZqOTM2amJoZk04NEVE?=
 =?utf-8?B?R0x1aDYzb3MwcVh0dnhHb0FWZTNseGJGa0F2UXgrMHg1T3g4TTNsK0NYUm1Y?=
 =?utf-8?B?OGk5b0xlTFA0dVlVWjU5Z2VoS0lHZmM0bE1jcG51bE9hY3NBUjBNT3M2Rk1q?=
 =?utf-8?B?YzVNTmtHbFU1enVJZVpQdlRzNTI3YWlPVnJ4MDVGZnJVbzUzNUZreEljWjJM?=
 =?utf-8?B?bFRablZGaUt4S0d5Q2VSeHZ1WDVaVk03ckRqbFBCV0YwLy9BbndNSDRlWVZH?=
 =?utf-8?B?MWsxV3NQRUFYbFVsaHNDS2VEWjRJTEFMR1B4Z1l6Q003TE41OElCOFJIYVhC?=
 =?utf-8?B?UjJBTld5Q2pqM0k0YXFrK0l1K0ZYdm0zOUVlK2dOVkg0eEpjcWc4R242ay9J?=
 =?utf-8?B?d0M3V25kUU10elh3UEZ2eHJxeXhTeW1VbEtuRzJxa25XRjEvc3IwVFlRN0E4?=
 =?utf-8?B?M0VJbk9OaHJBSmt6TC81ZEFqZ0ZjZmVUT0JmMlYvRFNQQ0txUjNzRFlHZ0dH?=
 =?utf-8?B?WEl6bFNGdDhMN21WRkg4cVdrZ2xJcWsrRTgrcjJjS0FzOFVod2IrUCtwSXRW?=
 =?utf-8?B?V3JjRUR0RDVkOWRyRVFlbmMvNzlGUGhxb0pjTWVFeUxWR2ZCNXRBOUQ4YnRF?=
 =?utf-8?B?WEJwZnRSa0dMZFFRbUJPWHlNVkhYMThRNVVuMWZicHpOMjVSMHFLTmdIdnBu?=
 =?utf-8?B?cUtRZ0xpVTFDVFNCK1pUNGNEczlyOGJ0a3o4THlnSE1jTS8yMG15QVhhdnhk?=
 =?utf-8?B?ZW9vQ3hCTHliZkhFTktDclVSRHVSZFhHeTR2SHU4b2FKbzFtbGg1Mmc1UXRE?=
 =?utf-8?B?cTM3SS9oVXVjSm9PcTFuSG9jT3lhY0dEMXBrNVcrcVZFTkYyUTlFTzhoSVpQ?=
 =?utf-8?B?d3RoQzFYd3JleWpzTXViTEdnVVpBUjZBSzB4QktiN0pMT0tMK0p0U2wrbFN6?=
 =?utf-8?B?TVBRam5QUmw3RWhNY3dRY0JNR2I0akZPK2tPVUJyTGFQaGU5amZMWW1qbG9N?=
 =?utf-8?B?SmpCKzJhMlZONVRxVHdJc1NCSVY4T1AzVDA5S3o4YmZYajJjSXZkaS9yR3FD?=
 =?utf-8?B?bmk2OWxjYlpXQ0R6NWFjd1lsTDQrZEVmM3VGS1gxNGJGcEQvNFF4cGxvSTM2?=
 =?utf-8?B?cU10UGNMVWZDNlJvSGNCc3U2OXA0WkpxWlBqdnhNQzQxdjJPeTVsWGJNT0Mw?=
 =?utf-8?B?elE5U0xYVG9aQTdPcC9ZWUdsWHhZeUxvbXVmcVJzQXpBZXVMdy9vSE9pY2Yw?=
 =?utf-8?B?alU2MkZKZXNVelc3KzJMZjdvSnUzWm5nOEkvd2JGZWRXR1d3bnFIaXRDUFNi?=
 =?utf-8?B?bnJxVkZHWnpoYTM3eVJMTmhiNDNlL2xOemQreU1TMDRrUkdJOHlzdlU0VEVy?=
 =?utf-8?B?RG1TWFRUNHhMSWd4YjVSMytPZ0JjdkF6NzdjV2xISlI5RVdIczNtSXVDZ0Mv?=
 =?utf-8?B?MzZ5RzJQbE9Ecm95OUdWSWUwa0dneW00Y1BHY3JNdDZkSVNRODFpcWFYTi8x?=
 =?utf-8?B?UTF6d2p3UGE4ZkFTdjByajV6R3hOT0RzVWR3c0FielhkWHdNQ0t0Q3NaY2lR?=
 =?utf-8?B?dlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zBsW03UilzwPpx9s2TdB0Jxs/EeVu9NaE1R5rlWdeXMznvBEeXi+pDyR1neJiyW5UD3J/nxp0nvvuDWFKhDlKXOJ+eSeBMMa56Cuomy6z9F95wg9ffdLCoMswxta2auMOfMuewcmafNx3gyqelb4e3jFKy3PPtczzxyd8qJS+1Ao9xlyyZxGh5bYRWBa55JuNJjm/y4IyACkt6ohXxO4MsX+V/jgo1jq6z4/oSvEuQnPhfLd0vFcrjmIG9f5UqlOZHywlm+xdPCiUUP6Fd8zMuRPpP3EVXcQ1sldF8iz15hMQM+ZJDLYlOjpJxLbpaVX8HPnvRy5BQWWCo0T+DC4PSGroNHbaYBa1O/gBueasGVFPvE8VMxXcKNLxrRj+4k9W/hFYuHSlqWZv24Mrzqoc+uPruZm2JEtz0aJyZo39LZEQbszuRsR+0lDCmOE1FCD/ZXnJqv+uyRdDPcDj0O579Tuv0HeG1JGKJ2k0YI8l0+m5pob6V2n1dnjWaZ8zU1KD9Tsgg8FlKMwbd7vQI0+0e3ur6Sy2txiwYvaAnRGcovIj+8F2p+I15qmlWM7nb8vcBBEZ5kIe3qrGyg2SFgMqHfee0UPCgjyhxKVaqSP+zE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09bcdac4-5ea7-4c2f-1d2e-08dddf8977ad
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7660.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 01:32:46.9142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zBP6waHs1RatXEpNOkjTfvGkxZWl/08KfuERi5jSlQzhH4KzM6EBRaxhej+fxrb5k2i30Vd4StdAO5mlsyNTyf/doUqiY1y3sznKPDnsQWk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7240
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_04,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 suspectscore=0
 spamscore=0 phishscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2508200010
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDE5NyBTYWx0ZWRfXxEblGaQUw4k+
 Cz+hnC6XIke6+uVLI/o0d07qJDkLK43Yuo2AnSY9QmxFIE/ZbAydSjvCdcx1lzkWmcKbvsdSbdK
 TnCQ32IarAcAsJFb6AzJ4RCZaEbpG8+Z0UNEoSVzE2bVFPM/h7EahnCicJ1Gj2JD/s4XBFt2rZf
 PBWvIjgBL6kGwjS2f4wWEJwG2iyei7QwgA7oI+cI1itiZfx8xTcB2f4xIA+PbtVwso0Zm22sdu9
 M28/hFYVsv/Zv8uhkVIxeT5DSh9v/JPnzWwFciQYwvXOkY5UKBcK4iaEuHsYwFh2FHeZPFu4COU
 y9Gop2MUxxGO1gWMZYQLmIb0/RD1tEKiZM3brwoVxkiYt4Sm4FhGKXfyTlzrX3L623ajrcH7Dbh
 CrQ1fCwkmYKKTtGeSm7+85+iTjADmw==
X-Proofpoint-ORIG-GUID: iSUzgKbxxeh3IXec_epNXBWU969HrESN
X-Proofpoint-GUID: iSUzgKbxxeh3IXec_epNXBWU969HrESN
X-Authority-Analysis: v=2.4 cv=K/p73yWI c=1 sm=1 tr=0 ts=68a525c3 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=NEAV23lmAAAA:8 a=MhhXR_6Vo3BLPKBwpIQA:9 a=QEXdDO2ut3YA:10
 a=nl4s5V0KI7Kw-pW0DWrs:22 a=pHzHmUro8NiASowvMSCR:22 a=xoEH_sTeL_Rfw54TyV31:22

Hi Yongting,

On 8/18/25 2:44 AM, Yongting Lin wrote:
> Thank you! Anthony.
> 
> Yep, I checked the comments in arch/mm/x86/fault.c file which says as your
> advices in previous email.
> 
> 
> I changed my code in kernel 5.5 as below:
> 
>         if (unlikely(is_shared_vma) && ((fault & VM_FAULT_RETRY) &&
>             (flags & FAULT_FLAG_ALLOW_RETRY) || fault_signal_pending(fault, regs)))
>                 mmap_read_unlock(mm);
> 
> BTW: I wrote some selftests in my github repostory, which perform
> the basic function of mshare, and I will write some complicated cases
> to support the new functions or defect found in mshare. For example,
> once you support mshare as a VMA in KVM (just as the defeat viewed by
> Jann Horn), I will add extra test cases to verify its correctiness for
> this scenario.

This is great! I'll take a look at them in more detail. I just sent out 
an updated series.

> 
>  From Jann Horn's review:
> https://lore.kernel.org/all/CAG48ez3cUZf+xOtP6UkkS2-CmOeo+3K5pvny0AFL_XBkHh5q_g@mail.gmail.com/

My new series does not yet have support for mmu notifiers. It's 
something I'm working on, but there are key issues to overcome. One is 
that I need to update the implementation of mm_take_all_locks() to also 
carefully take all locks in any mapped mshare regions. The other is that 
passing through mmu notifier calls for arch_invalidate_secondary_tlbs 
callbacks is especially tricky because the callback is not allowed to 
sleep due to holding a ptl spin lock.

> 
> Currently, I put my selftest in my github repostory, and you could retrieve it
> as below:
> 
>      git remote add yongting-mshare-selftests https://github.com/ivanalgo/linux-kernel-develop/
>      git fetch yongting-mshare-selftests dev-mshare-v2-selftest-v1
>      git cherry-pick a64f2ff6497d13c09badc0fc68c44d9995bc2fef
> 
> At this stage, I am not sure what is the best way to proceed:
> - Should I send them as part of your next version (v3)?
> - Or should I post them separately as [RFC PATCH] for early review?
> 
> Please let me know your preference and any sugestion is welcome.
> I am happy to rebase and resend in the format that works best for
> the community.

I may have more feedback once I take look. I suggest starting by 
updating them to work with the series I just sent out.

Thanks,
Anthony
  >
> Thanks
> Yongting
> 
>> Anthony
>>
>>>
>>> As a result, needs to release vma->vm_mm.mmap_lock as well.
>>>
>>> So it is supposed to be like below:
>>>
>>> -    fault = handle_mm_fault(vma, address, flags, regs);
>>> +    fault = handle_mm_fault(vma, addr, flags, regs);
>>> +
>>> +    if (unlikely(is_shared_vma) && ((fault & VM_FAULT_COMPLETED) ||
>>> +        (fault & VM_FAULT_RETRY) || fault_signal_pending(fault, regs))) {
>>> +        mmap_read_unlock(vma->vm_mm);
>>> +        mmap_read_unlock(mm);
>>> +    }
>>>
>>>>          if (fault_signal_pending(fault, regs)) {
>>>>            /*
>>>> @@ -1413,6 +1446,8 @@ void do_user_addr_fault(struct pt_regs *regs,
>>>>            goto retry;
>>>>        }
>>>>    +    if (unlikely(is_shared_vma))
>>>> +        mmap_read_unlock(vma->vm_mm);
>>>>        mmap_read_unlock(mm);
>>>>    done:
>>>>        if (likely(!(fault & VM_FAULT_ERROR)))
>>>> diff --git a/mm/Kconfig b/mm/Kconfig
>>>> index e6c90db83d01..8a5a159457f2 100644
>>>> --- a/mm/Kconfig
>>>> +++ b/mm/Kconfig
>>>> @@ -1344,7 +1344,7 @@ config PT_RECLAIM
>>>>      config MSHARE
>>>>        bool "Mshare"
>>>> -    depends on MMU
>>>> +    depends on MMU && ARCH_SUPPORTS_MSHARE
>>>>        help
>>>>          Enable msharefs: A ram-based filesystem that allows multiple
>>>>          processes to share page table entries for shared pages. A file
>>>
>>> Yongting Lin.
>>
>>


