Return-Path: <linux-arch+bounces-14516-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F4093C347AB
	for <lists+linux-arch@lfdr.de>; Wed, 05 Nov 2025 09:32:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BEEB423BEE
	for <lists+linux-arch@lfdr.de>; Wed,  5 Nov 2025 08:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1637E299954;
	Wed,  5 Nov 2025 08:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mgBJHfJ+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ufxhV5yS"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECAC1991CB;
	Wed,  5 Nov 2025 08:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762331485; cv=fail; b=McJqHKtXzTWoVvj0MDNTy3pp5hp2r7/d806N3MTV3bPAj61PaJ9wP80Jxu/nujDpFdTbLOioKQV4IxOSYJPxEkjXP0BjmWaXHU7WTMETvbu5aA5pUyTGKW4xSkQBe3Md11LbwDy3NxAWdmoXMsc526ms/yBTM6oejxMWEJI76cI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762331485; c=relaxed/simple;
	bh=zVHP3E1ndaVCZayni/fNUiJF6UFJ3aB9LKpIvTgnMHE=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=UNK8sYBrfOC9AG/Cj35pw/eDb1lOH73wHxPXbVqZgFh1rT9ibFSQpYQsREat10jftnfNHraAzRET8T+dttG5wx/9a8TEjw0K9DxkobiSyqdJhHWD3hdn2j9bLRvJhQJ/dWYx6eRch0jZ7TTxJClxFspPsTsGaHEPzOknnuvdVRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mgBJHfJ+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ufxhV5yS; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A57OIFE030035;
	Wed, 5 Nov 2025 08:30:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=JEKLFzIBFMt1mjezAIY6cDaVU+HlcuPffjxYAkcThNY=; b=
	mgBJHfJ+0bHmZ4GwiZv88dcl0KZ+aWw3hAAjuk905HGenuqkWnufi5wmy1OZjjOW
	TKQvXgWfFI80F9Rq8IvPcQYeulgEvqLDAiXLkz1QWh1ukCVBFF+1Eqnux9m/yAMB
	duuVz1qhc1OrBBx0OTK4RTvEv+EcbjHha6KZPaSoPVY3RfqSsIdt5kQ+rUPkkk9h
	eM043cZ09T3hkx2k2ViEKcUyYkpR0tyJHQ8XoFfl6nT1TnIPEAO2QpibH6Q6Oz7X
	f/OE81d2QiU+uH4ohuXtKiTx+kRkbInmYDD6esZm2DonT6X+mCTnL1eX3TjRC5AR
	hGudtEf37F3DxICEsS62jw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a825p83k2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Nov 2025 08:30:50 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A58OVeO005149;
	Wed, 5 Nov 2025 08:30:49 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011014.outbound.protection.outlook.com [40.107.208.14])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a58naeqh5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Nov 2025 08:30:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kEo0ZAuPnYvo1o25AyuTmdEhOIggBsyTSICBnBk23R9VTInVNuzdYv7k0rFlA1IssIezCtSovn7TOm1gQJDFlfZZ4ktYuPu/mcWRWeIBBqnquIXkO9AcrTCWm2uhkHqd+Jh6ORycJpdj57pE6rsgGyzb2N8/MiMS91Oi6TRsP8uouDCeDCEjH2kR51asvMc1evCKQyiw0CG21sElwYMfYjhSfk0JWXdYh8bWpjq21xzbESDNXIPJEVcwJe+fWJXwR8AqpURxHu1yjstW822Dw/xUzsynzuj6aKUQDehYuObQkMSPTe96ZXWuRdrMgttvPrw8apxVFwlR5KMYgeIZRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JEKLFzIBFMt1mjezAIY6cDaVU+HlcuPffjxYAkcThNY=;
 b=f2AYBRLIcRR+SW9PjgWLfLZS+8SRx2tai8pojKvS1sWg+kIGemNN9uZ+nLX95zCeqtQd78R13MI6RYuCAb0cgBLUvto+nFg3YIlvV6oqoBgLfL34q1nUPQqDrhnqFdYdve3KhkHmfmRl03YYSev4Wa9Zfp772apzKxPUEpRFK43P1pq/cGUicj2FjLXw2AekO1wjin3lupqx+UINxCHHEGMbPFfZuqfppsin8oL/KeFCQ5z0LkaYen2vc3VYKHaMxzztuRN+zxo/IFxhLhV/MjiRzMfX9LYO//bA+zNOL5WU9Hb72S9+C7yqDhT8TN9GrB3T4MsmA4sI36E6GU0SkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JEKLFzIBFMt1mjezAIY6cDaVU+HlcuPffjxYAkcThNY=;
 b=ufxhV5ySYmf1fdNRslQ/URG2TtThS8zeLa3uqMMqWIx6jZitRuwkW0JkH+OI8DTWzJtN/jLpjaNGCNkBu2FngpLAD5jkWwTAOi7LRkI9/njnZBiMuIGxO7OMGNHkkVNWYyt/oAOSZYWXKhR9PI05ZzXq/yPDCk307eK/0JG5j2U=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DS0PR10MB6104.namprd10.prod.outlook.com (2603:10b6:8:c7::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.16; Wed, 5 Nov 2025 08:30:45 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9298.006; Wed, 5 Nov 2025
 08:30:44 +0000
References: <20251028053136.692462-1-ankur.a.arora@oracle.com>
 <20251028053136.692462-8-ankur.a.arora@oracle.com>
 <CAJZ5v0hSvzHfsE4nrEW-Ey0dnJ+m=dSU-f1RywGNU0Xyi3jXtQ@mail.gmail.com>
 <87ms5ajp4c.fsf@oracle.com>
 <CAJZ5v0hQ7G9jvOv9VtRmsCKahBpUcPJMMOe07k_2mqsvggWcWg@mail.gmail.com>
 <874irhjzcf.fsf@oracle.com>
 <CAJZ5v0i5-8eO6T_-Sr-K=3Up89+_qtJW7NSjDknJSkk3Nhu8BQ@mail.gmail.com>
 <875xbxifs0.fsf@oracle.com>
 <CAJZ5v0izSBR0_DeH5HVnSLFGRfV9WoSzbu9Mh5yvvuyrvw7fLg@mail.gmail.com>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, bpf@vger.kernel.org, arnd@arndb.de,
        catalin.marinas@arm.com, will@kernel.org, peterz@infradead.org,
        akpm@linux-foundation.org, mark.rutland@arm.com, harisokn@amazon.com,
        cl@gentwo.org, ast@kernel.org, daniel.lezcano@linaro.org,
        memxor@gmail.com, zhenglifeng1@huawei.com, xueshuai@linux.alibaba.com,
        joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com
Subject: Re: [RESEND PATCH v7 7/7] cpuidle/poll_state: Poll via
 smp_cond_load_relaxed_timeout()
In-reply-to: <CAJZ5v0izSBR0_DeH5HVnSLFGRfV9WoSzbu9Mh5yvvuyrvw7fLg@mail.gmail.com>
Date: Wed, 05 Nov 2025 00:30:43 -0800
Message-ID: <87y0ok98zw.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MW4PR03CA0116.namprd03.prod.outlook.com
 (2603:10b6:303:b7::31) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DS0PR10MB6104:EE_
X-MS-Office365-Filtering-Correlation-Id: 87580204-7ce2-41b3-fe22-08de1c459cce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cVM0cm9ZT040OFhadzdIRjhCNWFEUGtMVlFSRWVDdlM1ekZneERSYytOdURD?=
 =?utf-8?B?K1NWYUVmcEFiZXhLNEZlL0FmZ0JJdzBoSjVxSkJqWUpJUnptanMyQXVGWVJD?=
 =?utf-8?B?Zmp1bElQTFRnTTBBUEtPRG9nSmhEQ0RkVUdsZHhQM0tDZmdEd3JuNTUrNm9i?=
 =?utf-8?B?L2hacjQ2V1k2d0ZYTytwdHQ3aURKOVBFcndkN1BITmlwMlZNTXdETzFxazUw?=
 =?utf-8?B?RzBJR0k3NDUzc2xjMHJEM0V6cVMzc2VCNDM4dFYvRk8zZ0tNVXFiY0J4UUli?=
 =?utf-8?B?aGhuUGppVkRvbU9nV2dDdmxxczBVRmlveFB3VzlGczNERW52eFM5bmR3bXVX?=
 =?utf-8?B?cWVPZkY0RkVFMUl4R1MyaUNuUVl1ejc1dFFJL3RhbE9HVzlPdEtDZVBTbkJJ?=
 =?utf-8?B?dGZlUjNLNXNVb1NNdEFTclAwZ2xyeW5rODFCWC84anBoUnd6ZjJNTFJxUXlh?=
 =?utf-8?B?cXpGR1dyT0ozOStteWl1RFJpYzAvTXdwR1hiQVFEYUVhU2YvZnZPc0pjVUY4?=
 =?utf-8?B?MEpBVFRrVjdweXZ1MHpHZGVDMXdzM05NNmc2OG1TUVFxcldMQ2VtN3NrVW5K?=
 =?utf-8?B?dXh4WWxsdDlSbFJPVlhxaVlkQ25kWnoyQ0lNOUNFL1E2UGhBdjRzbS9Fb0VF?=
 =?utf-8?B?YmtFc3RPbVZPbndRZU51Q2xLbmJCTVd2NWNCMm9aNFNBcjA5Uy9DaWFNRHJO?=
 =?utf-8?B?SHdxd1B5bVFCcHpoS2V4aDFScytNbWhFNzhyZG5OUnorRjR6cnlKelB1VFpE?=
 =?utf-8?B?MFlaNW9STWt3RWVSZlFldktmaFJpbTFVTTJ3SUxraUdnTE8xS3I3MXVNN1ZR?=
 =?utf-8?B?d2NXQkVJVGdVWlZ1QUViTDYxNVBDT2dzWDdFUVVRS2VSRGVzWnNBRzEwVlhT?=
 =?utf-8?B?aEtndVM0djVxS1JPTUI0Q285Y1g4MUN5bXJlNGVjTUVZbjNjdmNOY0JyYk9T?=
 =?utf-8?B?Q29sdHh4elFQejd5ZUlZaHI3eE5HNE1mdUZaSjJiVkxIaHpnZHVFcEd5TUI5?=
 =?utf-8?B?SHErR2JDSGNRQU5lSmNwQURJMU12NUZaZnFyelhGdFE2Vk8wYUZ3MjU4bVAw?=
 =?utf-8?B?SkNiVTcwc1JzYnJJM3pHK0RiVVNJUyt1cEhibEpRclpmYThmYUtPT3lFNUs1?=
 =?utf-8?B?UHN4akh5K0JjdXd3cWgya2h6dXFhYXg2RUFyODlrd2tndm9BcjB3T1pvZjIz?=
 =?utf-8?B?VVFVbVRpcXNyVzVnd0pPNzJ0MUtsSGxkZnNaNXZBaDYrWVNSWnM3Vm9hYThH?=
 =?utf-8?B?cVR6Y0UzZ3hKZWxMUzRjVXRkUXIyTXRFVXFrckdIOStmS2F1QlRxdnJGZCtE?=
 =?utf-8?B?S2NNQ3pvM09qU01ta1kvVHdUc243YjNBVDFxMDNkWDhudXBwNll1ZFg0aXFu?=
 =?utf-8?B?VFMvcFVxZXRGbjgzd0UrQVNTaXlLYURMRHpGcll3V1ZZUDhkZ3hjV255QlBG?=
 =?utf-8?B?Yk9UbUNGT0JNSlFrb3dpZTc5cVRsVVFGcjE0SXJ6OUgxMit4OUFtSVZQVzVD?=
 =?utf-8?B?NjVWRDZ3c1ppd3Z2Q0xETi9HcmdsN1A2bVdnL1dtZ2c0bVEvbUZxTk9pNEhk?=
 =?utf-8?B?OWhsQjdEb1RidThSdVExWkIvR2NqaS84S2J0T01ZazgyQ3dFanN2M2JWdGpW?=
 =?utf-8?B?dmc3b010VlNvVmgzaVBIVnNrM1U5QVVnTTFURFMrd2JZaC9ENzdTUkVVUEh0?=
 =?utf-8?B?YXZjbHdSdFl2M25PeWpheFpwUTF1WmlEc2NuOTdCTmU3YXhjQVltVHhHTEl1?=
 =?utf-8?B?dWVEbWIvUU1DdkZHcTNtQVdWS3Zxc2NUeTZtdVVOd2hNTEt6NFFveUk2dFNj?=
 =?utf-8?B?T2JlVy9ZcmdoSlR5c0hoQlgxZktpcFFNdDBVOXpxMjJHZ2FabTBFWGdlbkh0?=
 =?utf-8?B?SHFjZ2hiM3FGOUV6dTBUVC9EREFTS0RuNGlMcXZORS9uVFpqcXdRdHdINjVE?=
 =?utf-8?B?bmRsaHZMMEs1YUFHTnNtQnJOUW1NWDdBY0lNZ3RVOEpidzNjR25rQ2lmbkNp?=
 =?utf-8?B?bFBYYjk1ckRnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MnBHa0FNbHBaalZWK2g3WVNwSUxaa0FCTk5TaHBaZFVXcUEwTDRjalBqNjc3?=
 =?utf-8?B?SUoxR2pHdTd1b0RBZHJHdGJHVHRLa1BsV3pzYTMxeWpnV0E3OExDZ2grTEJq?=
 =?utf-8?B?UzBlQWpPTE9XRlZ4eW13YWNPeG9NbnpWTjh4OVJpQmh5SW5iK2VTN25zd1E3?=
 =?utf-8?B?cnduUWZUZmJ2aTBGclpWRFZRYk05a280MHJTZUVrSWlPbGhOUmh5T2h1bzdI?=
 =?utf-8?B?UVVSa0wvR09qVEIzV2taM3BPUVlMWk0yd1ZGV2NJajlqZjBpaGpQeUFjL3JX?=
 =?utf-8?B?KysvVlZVR2wzT0JVOEJHVWY5SzBJN2pWMHRRUnluZE9TTHZBYU1wcFRTUW5Y?=
 =?utf-8?B?NTlKdlBoZSsrNCtGS0lEVCt5dlIvS1dsd3l4OW9ZemVnSjVKNzl4dG1pNDdr?=
 =?utf-8?B?Rm9UdzRobEVMRkVWY1pZSURtK3crUFM4L3BRZGZmLzZEVTlaeFgwN0wrZVdv?=
 =?utf-8?B?Mm1ycEpwSjc3UVVTTk80cDhkTmlSNzg1SThxR0ZlWFhjME1PT1RrTzA3c3RI?=
 =?utf-8?B?Vi92ZllZWlZwSWY0VmxacFIvS0hySVNTbEw1akd1amdnRngvVTVvcGZzVFJX?=
 =?utf-8?B?eHhJUk84RDkvRGlmejVwZjBMaUl2bWdteHdFSC9QNUlSTlVQbDZuaThhemZ6?=
 =?utf-8?B?MCt5WDRKWkNzN0RpUE1mMlVYSk9OUHEwMGZxZk9zSVRrRUhQbERHOFVDeG0z?=
 =?utf-8?B?YWRCSnc2ZVpuTDlLVVhoeGpOdC9HMmV2U0FHRG95THI3QU1iNnpiUnphWW9u?=
 =?utf-8?B?d2VFMStwVkJZUW5QZTZXbityVHFKS0NJRlNnTFQzVnA4eGJLK1BMazRNK2xh?=
 =?utf-8?B?NjR3MkpRcTNHd1AxNCtwdlFtekNvT2FwOHVsYjFEeHBsSEFMMXZkeFg1Yklj?=
 =?utf-8?B?Y1Y0MHJPdVkrSWJVRzZnaHphQVpEMFhiT1dzMXZmT0RZVGtTRlVXdmtwZTlU?=
 =?utf-8?B?a1BsdERhdThXWTFIb0gydTNhdE81YWVLaGZlVjNwTmdUZUdheVhUZy9CeW4x?=
 =?utf-8?B?L0syZXNNd1ovY3dKbWVtUnNRRDd1VmxWenlkLzA4TXA3YzdMRWUvUW5GY3h6?=
 =?utf-8?B?T0E3UmlBOVY4MzFaWVlxSm9LeG9IaFRSdEw5eGlZY05nZm5ydEtveWYrajdp?=
 =?utf-8?B?ZlJldWVtNDhWTzhSdE5IQzVyVmZXNmFTT0ttS1dSem9rRTdaUzdnVHpiYU95?=
 =?utf-8?B?NWp6TGlNdDJOdkJxTlZZVjAxR0N4VjZWOEpaNXJJRnd1WmtKUVB0OGRhTEtj?=
 =?utf-8?B?U3lYdnM4R3FCT0x0eXpjTmdlVE9vSlBtdWhGdlRWK2MxUjB3OEg4UkxzMWhL?=
 =?utf-8?B?cnJZMGp1NVlWRk9jZStwTUg3UXljN0NXMGFtRldhTVdRSFIyZEtpRWZMUmpY?=
 =?utf-8?B?SGVtVVdEOE92Uy9xVTBrUWNyUURCUHdOZnp0ay8ydHpEL20wU0ZLdHlidndB?=
 =?utf-8?B?SVJubVV2V3Q3VDJQamdEMjFaaVdGS3E3V2wvUzVIam43UGV4Q3dYS0FjOVpH?=
 =?utf-8?B?YTU0a1A1aTBCNGRXMnRUWmlEK2ZRcmZjR0UzNFphMEtWRWlISGJ1WFpMNmZX?=
 =?utf-8?B?Qk5wYzNrdGhkZWY4WHNuQm9aS1JpdFlkRU1tOVJxUnhwRWxPa0MzZzVoaFQz?=
 =?utf-8?B?cTFsWXEzT1pIN1BncUxhU05OUEpKMVdibDF4YUs4U1U3TkxCOWFsSGVtWjlM?=
 =?utf-8?B?QWZZZ0xMeXV0d2lEVHhXSUVSaDNxVWtZYTNzUGhWUVlQeVhJMGV4U1pEdzlG?=
 =?utf-8?B?eU0zTUFiK1BUZER0VEl1TFpMUWR6UGFGVFE2QjJBZ0h3MDQybFlOMDRlbjYz?=
 =?utf-8?B?UFhIekZZNmlqTXR3VGphSDFsL0dTUDhoVFhCQ0ZjT1dzOHZWR2hobnJnQ1Yr?=
 =?utf-8?B?UE1lS0FYZU1wWjJ3UlhTUSt0Kzd1Q2MyVHFMNERRMjV1S0VpTHd6cVJGZTN2?=
 =?utf-8?B?MDJ4L0dabExpR2FPUHBvay9SSnhyWWFTeVNGRTBiWThTZUxPZFVrcmZnaFk3?=
 =?utf-8?B?ek9UTEpDcFpTdUdCSGdxZGZPTzduNzhsYmpuSktyU2tQOForVE5QMVRGK28y?=
 =?utf-8?B?QmF1Z1lXWG5qNGFueWU3S1VrRy93cS9Fck9iSjltZjBzZi81eTV1K0FVL0Ft?=
 =?utf-8?B?b0JFRjZKOUhuaG9uQXdCUjd0b2pQbGk2TVUvcTBDV2Z1eDYvUGIweUlkdE9I?=
 =?utf-8?B?cVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	clP+ihIo7rRuGuUDGT5XOpg1E9rGgsXdiXV6gLU0OkW3pN5a5Tcy0LanzeHbrnxNXzNxNT8pKpzdGRQ153gNQjyVux8o+fsv53ErEFs1Ttt/ptK4Dh+v2eZ7jCFymKfMr1tJfAUsDUbRRyfbRf/Gg5p9JGXnOoHrkUPI3Df1FfG+lKaSQNGfDNfvlji3bllT5/x/61F2+d+zjHUuKJzLY4QMLUrKZ4RiJSyrVUgVwg19q+4hsPj4ihJ+w6mgegvd/PWSr6QxnVKVng/SQFxyS9TyeogzVRQvIPmw+TBBAAauCuA58dYpf9W0o9uagvF0+nPKfeM79rxK5g2aIP0HXzzLoC/05vkfeMsASlrYmP2EX2tZYSMYseFBr6wr2oifYcpNYIEv0I7z4J3sA1ZlEJ2kDAkrgV8lp9Qy6DUQa0/lwKDBVN6nWZkBJKuWKTLLvhpF+INhQwwlQ+xV5F9upl6i6ZyC0yRSG/ESyzllygWAtq1img2YziZCmg3Cy00TsLltLv2Nm1QhBd0F25iE9RojSbnM/XArZD2bbBQDYJMTVEJKrb4edJNkl7P9kvMw8gvyUxfgZEf4KlRWJ9R70QKYohplUnbXfoz63abBS5Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87580204-7ce2-41b3-fe22-08de1c459cce
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 08:30:44.4585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZA69x0BonSvmTcN7NjXRNmqh+6iqkeFyDn3s4+cIDuD3BfImuBgtfnw5awx/ujmHICdjG2EP5R3/gKk+6hyXfNXs+qvdOwceyZbr3WDbuME=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6104
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_03,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511050062
X-Proofpoint-GUID: gyVZrwQPTS-5pkKsYfacYu2rYR9Ilf72
X-Proofpoint-ORIG-GUID: gyVZrwQPTS-5pkKsYfacYu2rYR9Ilf72
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDA1MiBTYWx0ZWRfX4Q1huQ+tdWQy
 UkADm+C7rxVW3/94dk+G5oIXkVxVz+/bRjGOMGKpidRcW/FoV2ryYVKaQusmttyS+pIesEGu8kc
 WHq+C4e3kL05AyD3NBOKsB6+Vat8vMuxFIWAjOfytONOvw9AraNMe4vdzUFTrjNC4XI3oDN56TO
 vSpW7shV+gTAVx3OZlNnU3SJHWN9iYfVrGAmwcii7Up3t+i24v+Al+V8axXWyzysPHRyiH1LHqt
 zq8CkXN8dsLTjvsodWtXeqG+KnRsUYsB+gGxuuPY5KataqnKxuomFWttPjpPfbxcst8KR/dSP8J
 mflXf2dlMBicR41HA2MrLIdNd5Llgux6vA/Hrboj2F0IGxKj8BU7Mh3HtNWH6XXpxOU/cGaBC5e
 Oo3SMXF1i1+p79r9k1nx3dkwJprM0A==
X-Authority-Analysis: v=2.4 cv=db6NHHXe c=1 sm=1 tr=0 ts=690b0b3a cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=KKAkSRfTAAAA:8 a=4bwR4ZU4bTf_GQbLaowA:9
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22 a=cPQSjfK2_nFv0Q5t_7PE:22


Rafael J. Wysocki <rafael@kernel.org> writes:

> On Wed, Oct 29, 2025 at 10:01=E2=80=AFPM Ankur Arora <ankur.a.arora@oracl=
e.com> wrote:
>>
>>
>> Rafael J. Wysocki <rafael@kernel.org> writes:
>>
>> > On Wed, Oct 29, 2025 at 8:13=E2=80=AFPM Ankur Arora <ankur.a.arora@ora=
cle.com> wrote:
>> >>
>> >>
>> >> Rafael J. Wysocki <rafael@kernel.org> writes:
>> >>
>> >> > On Wed, Oct 29, 2025 at 5:42=E2=80=AFAM Ankur Arora <ankur.a.arora@=
oracle.com> wrote:
>> >> >>
>> >> >>
>> >> >> Rafael J. Wysocki <rafael@kernel.org> writes:
>> >> >>
>> >> >> > On Tue, Oct 28, 2025 at 6:32=E2=80=AFAM Ankur Arora <ankur.a.aro=
ra@oracle.com> wrote:
>> >> >> >>
>> >> >> >> The inner loop in poll_idle() polls over the thread_info flags,
>> >> >> >> waiting to see if the thread has TIF_NEED_RESCHED set. The loop
>> >> >> >> exits once the condition is met, or if the poll time limit has
>> >> >> >> been exceeded.
>> >> >> >>
>> >> >> >> To minimize the number of instructions executed in each iterati=
on,
>> >> >> >> the time check is done only intermittently (once every
>> >> >> >> POLL_IDLE_RELAX_COUNT iterations). In addition, each loop itera=
tion
>> >> >> >> executes cpu_relax() which on certain platforms provides a hint=
 to
>> >> >> >> the pipeline that the loop busy-waits, allowing the processor t=
o
>> >> >> >> reduce power consumption.
>> >> >> >>
>> >> >> >> This is close to what smp_cond_load_relaxed_timeout() provides.=
 So,
>> >> >> >> restructure the loop and fold the loop condition and the timeou=
t check
>> >> >> >> in smp_cond_load_relaxed_timeout().
>> >> >> >
>> >> >> > Well, it is close, but is it close enough?
>> >> >>
>> >> >> I guess that's the question.
>> >> >>
>> >> >> >> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
>> >> >> >> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>> >> >> >> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
>> >> >> >> ---
>> >> >> >>  drivers/cpuidle/poll_state.c | 29 ++++++++--------------------=
-
>> >> >> >>  1 file changed, 8 insertions(+), 21 deletions(-)
>> >> >> >>
>> >> >> >> diff --git a/drivers/cpuidle/poll_state.c b/drivers/cpuidle/pol=
l_state.c
>> >> >> >> index 9b6d90a72601..dc7f4b424fec 100644
>> >> >> >> --- a/drivers/cpuidle/poll_state.c
>> >> >> >> +++ b/drivers/cpuidle/poll_state.c
>> >> >> >> @@ -8,35 +8,22 @@
>> >> >> >>  #include <linux/sched/clock.h>
>> >> >> >>  #include <linux/sched/idle.h>
>> >> >> >>
>> >> >> >> -#define POLL_IDLE_RELAX_COUNT  200
>> >> >> >> -
>> >> >> >>  static int __cpuidle poll_idle(struct cpuidle_device *dev,
>> >> >> >>                                struct cpuidle_driver *drv, int =
index)
>> >> >> >>  {
>> >> >> >> -       u64 time_start;
>> >> >> >> -
>> >> >> >> -       time_start =3D local_clock_noinstr();
>> >> >> >> +       u64 time_end;
>> >> >> >> +       u32 flags =3D 0;
>> >> >> >>
>> >> >> >>         dev->poll_time_limit =3D false;
>> >> >> >>
>> >> >> >> +       time_end =3D local_clock_noinstr() + cpuidle_poll_time(=
drv, dev);
>> >> >> >
>> >> >> > Is there any particular reason for doing this unconditionally?  =
If
>> >> >> > not, then it looks like an arbitrary unrelated change to me.
>> >> >>
>> >> >> Agreed. Will fix.
>> >> >>
>> >> >> >> +
>> >> >> >>         raw_local_irq_enable();
>> >> >> >>         if (!current_set_polling_and_test()) {
>> >> >> >> -               unsigned int loop_count =3D 0;
>> >> >> >> -               u64 limit;
>> >> >> >> -
>> >> >> >> -               limit =3D cpuidle_poll_time(drv, dev);
>> >> >> >> -
>> >> >> >> -               while (!need_resched()) {
>> >> >> >> -                       cpu_relax();
>> >> >> >> -                       if (loop_count++ < POLL_IDLE_RELAX_COUN=
T)
>> >> >> >> -                               continue;
>> >> >> >> -
>> >> >> >> -                       loop_count =3D 0;
>> >> >> >> -                       if (local_clock_noinstr() - time_start =
> limit) {
>> >> >> >> -                               dev->poll_time_limit =3D true;
>> >> >> >> -                               break;
>> >> >> >> -                       }
>> >> >> >> -               }
>> >> >> >> +               flags =3D smp_cond_load_relaxed_timeout(&curren=
t_thread_info()->flags,
>> >> >> >> +                                                     (VAL & _T=
IF_NEED_RESCHED),
>> >> >> >> +                                                     (local_cl=
ock_noinstr() >=3D time_end));
>> >> >> >
>> >> >> > So my understanding of this is that it reduces duplication with =
some
>> >> >> > other places doing similar things.  Fair enough.
>> >> >> >
>> >> >> > However, since there is "timeout" in the name, I'd expect it to =
take
>> >> >> > the timeout as an argument.
>> >> >>
>> >> >> The early versions did have a timeout but that complicated the
>> >> >> implementation significantly. And the current users poll_idle(),
>> >> >> rqspinlock don't need a precise timeout.
>> >> >>
>> >> >> smp_cond_load_relaxed_timed(), smp_cond_load_relaxed_timecheck()?
>> >> >>
>> >> >> The problem with all suffixes I can think of is that it makes the
>> >> >> interface itself nonobvious.
>> >> >>
>> >> >> Possibly something with the sense of bail out might work.
>> >> >
>> >> > It basically has two conditions, one of which is checked in every s=
tep
>> >> > of the internal loop and the other one is checked every
>> >> > SMP_TIMEOUT_POLL_COUNT steps of it.  That isn't particularly
>> >> > straightforward IMV.
>> >>
>> >> Right. And that's similar to what poll_idle().
>> >
>> > My point is that the macro in its current form is not particularly
>> > straightforward.
>> >
>> > The code in poll_idle() does what it needs to do.
>> >
>> >> > Honestly, I prefer the existing code.  It is much easier to follow =
and
>> >> > I don't see why the new code would be better.  Sorry.
>> >>
>> >> I don't think there's any problem with the current code. However, I'd=
 like
>> >> to add support for poll_idle() on arm64 (and maybe other platforms) w=
here
>> >> instead of spinning in a cpu_relax() loop, you wait on a cacheline.
>> >
>> > Well, there is MWAIT on x86, but it is not used here.  It just takes
>> > too much time to wake up from.  There are "fast" variants of that too,
>> > but they have been designed with user space in mind, so somewhat
>> > cumbersome for kernel use.
>> >
>> >> And that's what using something like smp_cond_load_relaxed_timeout()
>> >> would enable.
>> >>
>> >> Something like the series here:
>> >>   https://lore.kernel.org/lkml/87wmaljd81.fsf@oracle.com/
>> >>
>> >> (Sorry, should have mentioned this in the commit message.)
>> >
>> > I'm not sure how you can combine that with a proper timeout.
>>
>> Would taking the timeout as a separate argument work?
>>
>>   flags =3D smp_cond_load_relaxed_timeout(&current_thread_info()->flags,
>>                                          (VAL & _TIF_NEED_RESCHED),
>>                                          local_clock_noinstr(), time_end=
);
>>
>> Or you are thinking of something on different lines from the smp_cond_lo=
ad
>> kind of interface?
>
> I would like it to be something along the lines of
>
> arch_busy_wait_for_need_resched(time_limit);
> dev->poll_time_limit =3D !need_resched();
>
> and I don't care much about how exactly this is done in the arch code,
> so long as it does what it says.

This looks great. I think it could just be:

  tif_need_resched_wait(time_limit);

And, given that this is tied in with scheduling contexts, this interface
should be able to use local_clock()/sched_clock().

--
ankur

