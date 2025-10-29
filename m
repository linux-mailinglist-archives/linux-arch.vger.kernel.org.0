Return-Path: <linux-arch+bounces-14417-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29651C1CFC1
	for <lists+linux-arch@lfdr.de>; Wed, 29 Oct 2025 20:19:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44410564226
	for <lists+linux-arch@lfdr.de>; Wed, 29 Oct 2025 19:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525113590AD;
	Wed, 29 Oct 2025 19:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ns++xhuz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vqqHgJwD"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0082EAD15;
	Wed, 29 Oct 2025 19:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761765245; cv=fail; b=X/BGtDY+KWUAbTHRWTsgl3PuCq/RMT8vBIf7bRWbkVO4QSQNSR8mzEOnxkOUCs35kA5x1Zhk548rS5EuUDpy/8mq3mIQWc/vComyuA4H5OZQb60RY/lvr++ZSCYCOqhovlVV6t5ADO09np7drOpAmHPFw3ZZuz3CU7WLcS4kbDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761765245; c=relaxed/simple;
	bh=Xa0IsKZ8e2iNT6cINH5hGiG+VNh4nmU9c+hi+aJXSeA=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=iTFGi4T0TdjwPxFAk6EDJXJsindluehVLeaVPtgMp7ICU9G0ClPUqB5rXv7ZJ3iy4iHMnxW94+rT98PSrQL5v7aWfDVyq9EKI/39Tva6KOsi6JrZaIUK9EYjK1loiWHltnFVpyiK4CJdo22CmzLdaNYj8O9r0VsnVyffqrUDbBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ns++xhuz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vqqHgJwD; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59TIp4ux021838;
	Wed, 29 Oct 2025 19:13:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=sAJaZKJ10S5No0grOXbjg0UFHfGqdoao52nGCBSeI64=; b=
	ns++xhuzRiYL9OQMhBgPyH6ZPRmVptbeRlzGsm7e0jvntwDogdTwY2z5tHDP7wYS
	dsDvx7f6pl7g+OnZT65yI0cjIdcJcwVFWMG0N8LqIrKzdwkl1XIblvaGIKQGfwks
	olB/Q8Zdir+kbUQ75BKgz+ztljzmiE6YUcUjrGnS1GJlnzPpKyfdbLXFjKjZVdN0
	1S5XbxTAiU16Y1FR0II6swqVb+WtfnvgiWexHVnoSqh1AJetWB0cPN4qmMO6iQvH
	s1whj50zgWnMwDwpA8nI+99Q0swtOkSQBVScZ01vFaI6VLwpNqyRrpXOm3cdWwfl
	Di03wOhKJUHphE9aYGjWCw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a33vwat51-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Oct 2025 19:13:37 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59TIlJCT032251;
	Wed, 29 Oct 2025 19:13:37 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010037.outbound.protection.outlook.com [52.101.61.37])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a34eccd13-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Oct 2025 19:13:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UeStzZAngW2ZOSq8VgM4CtYuRu2oLCyVaKpPfH/mXNISfxP5gYPtmpzWtQJLe5XhgFqNpRVU3SLsA3gzkj/3gjlihc+ZD3ptowPQ7iBuZfJwdX7IYOqLkyQ5ba2+T6/4c4fLG3oDLpMfyEgK/SighlZ4iUPVKNT8X8YWCM/9+6dbdnA4vOKImoNhVurzGa5lYS4pUlCJSDX3UrS3h+gfYladzOcE9cRN8PaleE1MVg0l1kXxE8wJ3Z66B7yPJoWasVN1/ulepE3KqOheiMSJVyKIPF4jS5qXULItY80UIjZUO7JvGd5QU5iLkeAMh7LFM5DqnpPtQCGrqQJQLcI7TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sAJaZKJ10S5No0grOXbjg0UFHfGqdoao52nGCBSeI64=;
 b=GPt+EVFdRy7Vm5BrZyHFr3xVeHHBE/HGuanDLGKnGqWI3fcp2/57ilSuQIRm55xjxKfKelt+um8h7LazHXuNKJf9VCAEpihxli5pQqXj9y+OQ8Hpg5rEWWyLfEtYYYLHSLxlFtJYrjmvD5BO6EJxdY+SOqRGR0qPjDVGbERwNoViEGbXSHvKEZqNtJfnEsShSkAazNQm+DGQddVHvOmOkkUGdw7y21RB6uLBPyAKdUxIYOVqg5SfBMOyDuFY6LqSfXBHoyfATN9j5IsU0to9nsNcnssxSRQacmlHkShAYSEM96RM58a20Rf7cWRfB8s185o4CfuFusoMUp8tY5usFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sAJaZKJ10S5No0grOXbjg0UFHfGqdoao52nGCBSeI64=;
 b=vqqHgJwDStZx8PPq31NKIvpd9Ak8pqkWit8bVDUSSyxL0VWiC/Ruj2tDRphAaR5B3uusPSNoNAiSosxv0+oMMezH7czrUH0f0AoSeD/Vy6r2wyLJF0rkhB19TA23JRk5AmEn7clGUWnzZFwJvl6C8atOXjV9Fay3CBGhlP/8iLY=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by IA3PR10MB8044.namprd10.prod.outlook.com (2603:10b6:208:515::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 19:13:21 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9275.011; Wed, 29 Oct 2025
 19:13:21 +0000
References: <20251028053136.692462-1-ankur.a.arora@oracle.com>
 <20251028053136.692462-8-ankur.a.arora@oracle.com>
 <CAJZ5v0hSvzHfsE4nrEW-Ey0dnJ+m=dSU-f1RywGNU0Xyi3jXtQ@mail.gmail.com>
 <87ms5ajp4c.fsf@oracle.com>
 <CAJZ5v0hQ7G9jvOv9VtRmsCKahBpUcPJMMOe07k_2mqsvggWcWg@mail.gmail.com>
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
In-reply-to: <CAJZ5v0hQ7G9jvOv9VtRmsCKahBpUcPJMMOe07k_2mqsvggWcWg@mail.gmail.com>
Date: Wed, 29 Oct 2025 12:13:20 -0700
Message-ID: <874irhjzcf.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MW4PR03CA0048.namprd03.prod.outlook.com
 (2603:10b6:303:8e::23) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|IA3PR10MB8044:EE_
X-MS-Office365-Filtering-Correlation-Id: 66077c47-26ea-4927-e81c-08de171f399d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dTk5ZDRRRFRMNGp5SHUzOWN5VC8zMGI3cVBJcXpLUm9HNU5GY1dOWHEwaGk5?=
 =?utf-8?B?MnM2OWh4QlJpUEtYbXliaHBkODMxVFBUSlU2YXRnYjhncGpVQ1E4Qnk0Mng2?=
 =?utf-8?B?T2FlNU0zMUhHM3cxSUlwYlkyNW43RldmekE5b2dDY2dlSXkzSUJTZEE5eHhI?=
 =?utf-8?B?cjVPdEkwTGVJWXFHenZHQzRBaFZoWEo2eG1rS0pKRysrbGFmY0JsbXUyTmtV?=
 =?utf-8?B?WmxIcG1LbDdkZnZkZVJLN1lRV0YvRFVJZzh2Vm9QanJ0c0VZSUFOMnQzUFdu?=
 =?utf-8?B?T1crOEpOTnJSd0trZ29XeG5WaVRDNnYyRm42WkJNSThoYUs3MFoySmlDWWdz?=
 =?utf-8?B?M3M2LzN2WnFJZHdwdVVibjZtQkpwMmpnMlR3azA5Ym5ScnhBYm5aTkx1dmVK?=
 =?utf-8?B?QUxPR1B2dTRzSlVNaUxWcmVaWDM5ZFhzQmZXNFk3eXg0Y3dwRzUvTFRDckJn?=
 =?utf-8?B?RnF2dW4zRzhDZkFrbnpBUFZPU1Rkci9aOVN6WVg1bVdma3l0RFVlKyt2YkFN?=
 =?utf-8?B?TnZKVDFueGdNRHlNNlFSaHNCZVVjTWViUFIxN1pVNUgzWTlvYWEyQ3RaWm4v?=
 =?utf-8?B?YTRNN1lCVTJyRWJhMEVLalcvNUhxWVQ5RUxCVXZldURtUjJwdmFiaVQ1K3NX?=
 =?utf-8?B?a3ZiOU1RTnFOS0ViaVVmdGxDWUJFeXZTd0dmd0FnZW9YM3Q3d2VJUjJqaktU?=
 =?utf-8?B?RDd2MEswSytqeUZkcHV2N0RrdHNUQ1E4Zkt0NFhtK3YyRVZXdFhQUWdET3NW?=
 =?utf-8?B?cFVaR3ovc2xvRDBUYmwwT1lpdjUyZ0dWTXFVcmZLbTVWTytMRVdnV281a0Rj?=
 =?utf-8?B?UGVGUGdUZlFkY1doVGw5UDlVVWdxMnZ4T0JUNFEyRk8yd1RZV2NlWHNPRXhm?=
 =?utf-8?B?NGt6anJtMDRIc295SUJOMlB4SzllaTdveWRjZVFkWTBYc2dmTnF1T1k5TEk4?=
 =?utf-8?B?ZnlJa3p3ZGpUMi90Yzc3WjFKWXlzQW9tVUlweFMrajRnUXljcCtBc3NuTTlo?=
 =?utf-8?B?aHBnTlcyM1Q1MEhacCtrb283S2ZWMlhRVVdiU3lTVWM3TWJrV2dBQUFsOFls?=
 =?utf-8?B?WUtCT0ZKd3V6dFkzN1BWdWl3WkdydmJRUktqWm4vYlZhMWNPUEQxS3ZDYTBw?=
 =?utf-8?B?Mll2Q1R2UWJDVXkrbVU2eDZVRUdNYzV6bTVkWWYrVHFodVZ5ZDNOalpiRDM2?=
 =?utf-8?B?YkxoSGRiUmZyVmc5eHZjR2VZNWZNSHljbm54M3BLaFRCcUltTkhQTncrY0M0?=
 =?utf-8?B?ek1JTGh1RXU5UmNZODFLRCtWazRNQXVaOFlGVFY5Nkp4ckJ3OWNqVjhIR1Jk?=
 =?utf-8?B?TXgxUE4zY1o4NFBMUHBOMG9EemxRaG1IcWFQOWphZnl0M0tIYjBVQVRDMmxE?=
 =?utf-8?B?S3ZtUTR6bEd5Rit4OTZtMUJlb3NrZlN6QkxjZkpPRWRpek5zYmJ6Q3pORHF2?=
 =?utf-8?B?a0x2dWxQbllwaC9wQjdIS1FGNkc0c0VveGVvMmxTbGIvNFIwSkVRdXEwYWJJ?=
 =?utf-8?B?cmN1TVE5TUZCYVBYcUNscmQ0SlUvaE1sRmM0RldDMWozd0Rpc3kyYkl1b1FP?=
 =?utf-8?B?elJaL0pHd3dkejhiN2U3TTBaLzAzekVxM0x1WDhRNVlVK0paMFNqU2xBd1F6?=
 =?utf-8?B?RzJCZEkzU0twbkFmejBvREhpNUdWVDIzRGdvWkJia0hMeWFLMXN5eG9rYkl0?=
 =?utf-8?B?eW9LeUlWSDQ2OW9RdDVlblh5WXpvc2dKbkxVMDlZajFuQ1owQktrbGtVcUZ4?=
 =?utf-8?B?Rmo1OVo0T25LY3o2akNud2dpZlp1bEs5VzRrd3BvOWh2TUtuVjFQMUhkMkdI?=
 =?utf-8?B?c0N6VGd5Q3lKeTRyVGh4YjdKeHpHc2FOanNEUitQK1VvRU4zL1JoYVA5OEFp?=
 =?utf-8?B?T0NTY3R4ZnpzUGdabVVadUtMT1RzZ0tObFVVK2k3cGRCeCtDTTRTakNVM1ll?=
 =?utf-8?B?a1FRWWc3cUJFSGpEd243ZGNvdHF3UWczaGV6cHBGcnVwakd5bThhMHlNVldU?=
 =?utf-8?B?ajN1ZVdwc2RnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?enB5ZGhiUXM2ckJjeGlBUW1CYnM1YjlQcWlpYUk5UDJaZklJUnAwSDRlNUJH?=
 =?utf-8?B?cHZxbEtxdmRGK2RPQzNPb0h4SkFObGk3ZTlPUVNtQ3pHS3AxTGFST0dFTm5K?=
 =?utf-8?B?aGo0QVB2SW9vMTBLUXRBVnVaQkt0c210T0hUOHlBanJ0bzRtOFp2UmJ5MDdB?=
 =?utf-8?B?YVkzQmVkU0pMUlBZbjg3K2sweGM3Zm1HZ1JmVDZocHJnZkJlby9VRVRLbCts?=
 =?utf-8?B?Y0Y5Q0JicjV6ZWpSMkl6NldNSVlIYzVsNmNGNVZiZjVqNDQrMFNqUVhpVFB4?=
 =?utf-8?B?NE54d1FjaUJWK1d6UElGZDlLTmtXSUZlVDM0NkV2akNGbUZKdzdGODYwYll6?=
 =?utf-8?B?dFVsUHF5SU8rU3UzTkFDb2prdHRrWDBVb1p4eHUrUTQySjlKRWVJRWlZcEM2?=
 =?utf-8?B?MkF6WEJ5MVdjWG5KZmJ4NTNKUjA4djBER0x1bWQvdTJiWlNpR3UwdHVkVUEz?=
 =?utf-8?B?V0ZJYmZaY2FHa3N2OEIrNTVmWkIrZW9VK3BFdEhkVWg5YnlRRUp5OXpMdXJv?=
 =?utf-8?B?dlE1OW5xNmVzaU9mdUZqS2U4MkQzRHAvVWZNTWVQSVNkeXdKaXlPbE9Db2FK?=
 =?utf-8?B?OFpNSElXSFZ2d2FnRFZjR0J4MnRtTHRvOFdlUVgyZ01HRU9wenZ3ZTBJWWpW?=
 =?utf-8?B?NDlwTS85Ukp6VlFGZDZWSlo2TUtwbzFKUWhOaWxXdHpSS25hMVhYNXFJdnpy?=
 =?utf-8?B?eGFSVmg5a1BhS2pRcUlSY1RUaUNFOXJ1VnJYaHJTTXIrRFBadndGbldqSFFp?=
 =?utf-8?B?eXIrTVIxQy9VRzl6eEREL24zUTlpaG1SK1ZTZmFWN2FkMmtueDAxVVd2RC9s?=
 =?utf-8?B?b3NlSEpUN1IxMUNnaTNFQ0k5azRraUQvS2FmRU9iYnhKNHcwRkhQV0p1Sm5m?=
 =?utf-8?B?b0k1R1J5N0NQWmk4SlZGTkxnSFkrRUhZOFd0YWZqOWxrZ2FuaW40OHlhRkc1?=
 =?utf-8?B?ZzZrTWppTURXeXhjNHNycnZTNnkyUE02QVc3NFRIZnpBQ1FIclJUdlFUMG4x?=
 =?utf-8?B?cmEvZWJ4NGhMd1F3L25BMzgzYlgyMTJCa0VBQXphU3dMeUJFVzh0ZkZCWTA3?=
 =?utf-8?B?bk1ST1V2azFQM3gxYWVOMk13ZjZVZ25sekVKekpaQm9rWGJaNjArSUltc1RT?=
 =?utf-8?B?aG1mMWNOL3ZPOG5vUi9RcGZFRGo1NlBINkxyQ2F0eEVzTnp5dzRjN2RzUzFp?=
 =?utf-8?B?ZnBuSnBmZFJSNG56TktaczUvSjdqWW1DZjdCOE0rNVE5OHMwd1IwQkNsMDRj?=
 =?utf-8?B?VjVuL2lFSW9aNDlYRm5ZODVVZDJhdFdOUUJIU2gySndOeUNQTDZOSE15Z0lH?=
 =?utf-8?B?T3FYYjVHc3o1SC9sSmhkd3hZVnpPZUlkVi82RHpUS1Jod0t3WGlrTUU4OHZs?=
 =?utf-8?B?dmNtN3RTZzNWTWt0VW81L0cva2RkWXpFdy9HaVZ5WDlmWnhJNjNaWDRlZmxy?=
 =?utf-8?B?WnN6VFduYjluOHRWN3ZIUEhKWEtrV0d5dlhmRFlPZEcvNnM4SDJONnVXT21h?=
 =?utf-8?B?c29teUwvSzBwSVpTQVNRSEdaTFpEUkpZU0hLbzN5TTNueGVwWEIrTFFQeHlv?=
 =?utf-8?B?U0MzVWZBUTJsWWdPcE9VNGtTRW9pN0JxWkNqdnA3NXlCbXdsL0tjL0Q2dExs?=
 =?utf-8?B?WmtRdDVEcnlwN3duN09TenhneERzWi9KSHhEUHBnLzFDYmNpVHd6NVU1N3Iw?=
 =?utf-8?B?dUhzcGh6Z2QrU3FDSjgvanU2TDdESW9rRCtZNXRzRndDTG9IUTA1SU5ZTWQw?=
 =?utf-8?B?MzFUTGZKWDlBVkk5VmJmdmhIejg4aS9vSlFFZ2UyaTRBS2dYb05yTzdNYjZE?=
 =?utf-8?B?NUVuaVhYTG01b0xNT2ZQc1UyWVA3YW5tSHJuOHRIVGl1bFdHZmFKa1J3VUdG?=
 =?utf-8?B?eGxuOW9lajF6Qm95ajhmdE4rNmltVG1tMy96QnhaMS9QRTk1NkFvMGwyUzF3?=
 =?utf-8?B?RXpBS01hVXNzUi90eWs4YXc5cXd1VlRYYU52SDhxUWpsWkpPUjJ6OXFtT2wz?=
 =?utf-8?B?OU4yMnpNSTMydHNKMkQ3c2ZpK3VHT3IrWHp0MjB1TVhIWnMvdWtiT25MMWxI?=
 =?utf-8?B?Szl0S2NORGRBWkxKM0FoSExGT3hlNTRXZmhLWStZSkdWdGF5VXpxN2U2dFZP?=
 =?utf-8?B?amdpZ0pueHg0bS9BMzlObUhDWC81Q0xqQUwxQkVkWEQvZlBFMFRJOXRmMmJD?=
 =?utf-8?B?NVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qe6OfwaBFumiLE2j7azdXRyw93m07h4NuMNn3MjzHHH3nQu1HRN4Of7kip4WhdPVgOTWsXtns7obsqAQp0yjX7bOrRoYW/aNfz+UcnFwWYR+Tvh98IlwG5D6gH5T5BuvXBMXBZV4VgiLQuQuSYBuduh4RzMlmLHJhQtlJFXqpZU1PQtRMc+qUDMQBsBWZpIc4P5QnKZ5lVcl5YEJplTChra/2UCTKZ6LWddHOpRRHcpkXidYa6wLqihkETzTJizghp6wjcYLRShNUTpymBbIcYBd3XNPPRcSK8Rl4HIBDem1CTE57FGVbhLmzRuEROVh5WOaipMZAuPn7AhCT6imIDykQ2+5O7HvMCE1ky3JZEw7KUMny3iibIYL0E+RN3LRmJ0dC6/NTNuJplJGEm0oq4EUv0fLiw1jKddPbbQpmjQ49IQd5Mri9lPiFr3mtjDiqi3JsJfKmKLubhEBSmdF4H8yvRjTgA95XwE0xG8B03/nptOfRy+4Wv45+GVke+8SlKPlAYIVLS9klbyoJ8PXVr2rBb2hhalOjJjPAQy+t47TvCx94woNfN+TDfmZXJWEVcOhKD46RvAaufGH5Xx2LWcKfTpvB5ZX+uVo9z9FRpU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66077c47-26ea-4927-e81c-08de171f399d
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 19:13:21.3451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LZ1LlL31Xx7vLu3Nf0XJa9g0t+1PTDxhDxt9Lqq0rNfTlq6ze3JKQjd5Rv9UVO+XC9auVAqqCsMvthjj15SjcxAWe8a6b7CMhdi0c8HQYj0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8044
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-29_07,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 malwarescore=0
 mlxscore=0 phishscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2510290154
X-Proofpoint-GUID: W7xr1FAUcGn91iq4uXj4sf2R9h4SYv8b
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE2MiBTYWx0ZWRfX3sW5SwnG5XIA
 c/Qb/e60JNzNjZ+YsAhELWy/yRcDQzHM3MD259Hu+6AHeeKBuTdJsrnpbsDvjH5rFRAmwqVhaYT
 6PEJ1jYOjOhUlaSZT+PmEix8f5+3Cz5YXlXqkc7B45ysEpvwB2Uv5NgVLC3Xq1JbSPmckj9v082
 xF4WRmAwHFlgCtHNPAe62nKuP4BrocfcgLlnB4SsGzSoy9QTllI0gh5Moy3EA5AfQrnYYGc5S4x
 ukrC2ITOU7jKuVqzqvrKMdkHF8TcGV38xmrLfyYOrtuvYYoCh2I0DAREmubQ2nDzRBmLU1ExZ10
 PQGP+0ft5FN5TtgSgBK0aA0fBZW8DSmLK8i5YD3X8qRuJVybiEBbGnJ3v9bQWD3UeDfGOYAVOIi
 aXszYvem0G54efiXI1/ZrXI3dAGRBhBnZ6SGANdLEgrHQgpYgKs=
X-Authority-Analysis: v=2.4 cv=Uslu9uwB c=1 sm=1 tr=0 ts=69026761 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=KKAkSRfTAAAA:8 a=mtOkqmUE-bh76MT0fEgA:9
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22 cc=ntf awl=host:13657
X-Proofpoint-ORIG-GUID: W7xr1FAUcGn91iq4uXj4sf2R9h4SYv8b


Rafael J. Wysocki <rafael@kernel.org> writes:

> On Wed, Oct 29, 2025 at 5:42=E2=80=AFAM Ankur Arora <ankur.a.arora@oracle=
.com> wrote:
>>
>>
>> Rafael J. Wysocki <rafael@kernel.org> writes:
>>
>> > On Tue, Oct 28, 2025 at 6:32=E2=80=AFAM Ankur Arora <ankur.a.arora@ora=
cle.com> wrote:
>> >>
>> >> The inner loop in poll_idle() polls over the thread_info flags,
>> >> waiting to see if the thread has TIF_NEED_RESCHED set. The loop
>> >> exits once the condition is met, or if the poll time limit has
>> >> been exceeded.
>> >>
>> >> To minimize the number of instructions executed in each iteration,
>> >> the time check is done only intermittently (once every
>> >> POLL_IDLE_RELAX_COUNT iterations). In addition, each loop iteration
>> >> executes cpu_relax() which on certain platforms provides a hint to
>> >> the pipeline that the loop busy-waits, allowing the processor to
>> >> reduce power consumption.
>> >>
>> >> This is close to what smp_cond_load_relaxed_timeout() provides. So,
>> >> restructure the loop and fold the loop condition and the timeout chec=
k
>> >> in smp_cond_load_relaxed_timeout().
>> >
>> > Well, it is close, but is it close enough?
>>
>> I guess that's the question.
>>
>> >> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
>> >> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>> >> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
>> >> ---
>> >>  drivers/cpuidle/poll_state.c | 29 ++++++++---------------------
>> >>  1 file changed, 8 insertions(+), 21 deletions(-)
>> >>
>> >> diff --git a/drivers/cpuidle/poll_state.c b/drivers/cpuidle/poll_stat=
e.c
>> >> index 9b6d90a72601..dc7f4b424fec 100644
>> >> --- a/drivers/cpuidle/poll_state.c
>> >> +++ b/drivers/cpuidle/poll_state.c
>> >> @@ -8,35 +8,22 @@
>> >>  #include <linux/sched/clock.h>
>> >>  #include <linux/sched/idle.h>
>> >>
>> >> -#define POLL_IDLE_RELAX_COUNT  200
>> >> -
>> >>  static int __cpuidle poll_idle(struct cpuidle_device *dev,
>> >>                                struct cpuidle_driver *drv, int index)
>> >>  {
>> >> -       u64 time_start;
>> >> -
>> >> -       time_start =3D local_clock_noinstr();
>> >> +       u64 time_end;
>> >> +       u32 flags =3D 0;
>> >>
>> >>         dev->poll_time_limit =3D false;
>> >>
>> >> +       time_end =3D local_clock_noinstr() + cpuidle_poll_time(drv, d=
ev);
>> >
>> > Is there any particular reason for doing this unconditionally?  If
>> > not, then it looks like an arbitrary unrelated change to me.
>>
>> Agreed. Will fix.
>>
>> >> +
>> >>         raw_local_irq_enable();
>> >>         if (!current_set_polling_and_test()) {
>> >> -               unsigned int loop_count =3D 0;
>> >> -               u64 limit;
>> >> -
>> >> -               limit =3D cpuidle_poll_time(drv, dev);
>> >> -
>> >> -               while (!need_resched()) {
>> >> -                       cpu_relax();
>> >> -                       if (loop_count++ < POLL_IDLE_RELAX_COUNT)
>> >> -                               continue;
>> >> -
>> >> -                       loop_count =3D 0;
>> >> -                       if (local_clock_noinstr() - time_start > limi=
t) {
>> >> -                               dev->poll_time_limit =3D true;
>> >> -                               break;
>> >> -                       }
>> >> -               }
>> >> +               flags =3D smp_cond_load_relaxed_timeout(&current_thre=
ad_info()->flags,
>> >> +                                                     (VAL & _TIF_NEE=
D_RESCHED),
>> >> +                                                     (local_clock_no=
instr() >=3D time_end));
>> >
>> > So my understanding of this is that it reduces duplication with some
>> > other places doing similar things.  Fair enough.
>> >
>> > However, since there is "timeout" in the name, I'd expect it to take
>> > the timeout as an argument.
>>
>> The early versions did have a timeout but that complicated the
>> implementation significantly. And the current users poll_idle(),
>> rqspinlock don't need a precise timeout.
>>
>> smp_cond_load_relaxed_timed(), smp_cond_load_relaxed_timecheck()?
>>
>> The problem with all suffixes I can think of is that it makes the
>> interface itself nonobvious.
>>
>> Possibly something with the sense of bail out might work.
>
> It basically has two conditions, one of which is checked in every step
> of the internal loop and the other one is checked every
> SMP_TIMEOUT_POLL_COUNT steps of it.  That isn't particularly
> straightforward IMV.

Right. And that's similar to what poll_idle().

> Honestly, I prefer the existing code.  It is much easier to follow and
> I don't see why the new code would be better.  Sorry.

I don't think there's any problem with the current code. However, I'd like
to add support for poll_idle() on arm64 (and maybe other platforms) where
instead of spinning in a cpu_relax() loop, you wait on a cacheline.

And that's what using something like smp_cond_load_relaxed_timeout()
would enable.

Something like the series here:
  https://lore.kernel.org/lkml/87wmaljd81.fsf@oracle.com/

(Sorry, should have mentioned this in the commit message.)

--
ankur

