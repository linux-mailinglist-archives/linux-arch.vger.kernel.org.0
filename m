Return-Path: <linux-arch+bounces-14390-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D60C183F7
	for <lists+linux-arch@lfdr.de>; Wed, 29 Oct 2025 05:42:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE2523AAD16
	for <lists+linux-arch@lfdr.de>; Wed, 29 Oct 2025 04:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0792F5A3E;
	Wed, 29 Oct 2025 04:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nhPZ0fti";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xbvk7NAt"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4BE246773;
	Wed, 29 Oct 2025 04:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761712952; cv=fail; b=pqQTWIkz8mBq9LWNZKQHNvgsS+NFOsx6sIz9SbnfaOH1vH0NTSaTR3BoKGYitiR0L6XnXyQoZdfnlwUiIh3LtABnCw36zpBUW6fiuGoltNVh0XyFAs7LyIQLSFaHYlz8qo0avsNwG+UxQ2q93XqFSZPYkWRD2/ZLgURpPceMsX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761712952; c=relaxed/simple;
	bh=VMEDAiyrswF/QIxT4fPVYAQI1Ed0cjdmpdSMqbNSKVA=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=b5usMmyp/KziyEdsSPPcImyQ2g0o1IdbhPFERD/+dPWJXxTmP7s95c6wItLkxlVm+YZAT3S2kUfj64teA9DOZ7kyMUxXn/97gppCztfm5985bo/VoDle02F0o6I7KGEyF5ryzLrNo7LOXirlOjiU+KBP2cxoMX8vk/xG7fsWVhs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nhPZ0fti; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xbvk7NAt; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59T48bDa015086;
	Wed, 29 Oct 2025 04:42:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=XarVNw+9YQY4XIJSEkzXAMdMd5898uRVstwnoMmMIEU=; b=
	nhPZ0fti3HuB6Dcfv93xMfgZm9mdyOzVtfiwBQb8SHEwGSoNaXRc/uGWQY2Gfgjy
	KquaKf3oMr0GbZRmAJhfQohB9V/qw3bdzruH8PLrbrT5zmz74MGmYCzOT9I4EyCZ
	KqKIfvlyFnFW4sB3H8w+pvLVBgCH4W05J/9N07jPGk23CJfI0f6/UsNMlW7KAjGC
	Hai9rgbSlSqeXV0eOQLYM538k5QiRAWrqQiGAZhKCuvBy9ipWs1+3+zhTWYkh47l
	5R1rUgeRgNNmXaO0veyObiSG76CweEu7r1jlWGBrLIz3VH2vpifHuq+hQOT3itmA
	Hp7d+rkkXpEIgvTEEYRZQQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a3b4w02ae-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Oct 2025 04:42:02 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59T3G2Ce021226;
	Wed, 29 Oct 2025 04:42:01 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012060.outbound.protection.outlook.com [40.93.195.60])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a359tbpsy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Oct 2025 04:42:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XRvpdzkXnLsA/b942CL0kruAr/kEXhbaKTGI4GKHKw2OI2lpOgqxwJ2C+htqjxVsqRu8d/rmks3dnqQL7bFhD4bM+yjlSape9Q6jf9O0HsbllSha889PCW7loIXRdYfq028pWyWg5EUwFOA1FNuJKSB4TT1BgPV/l/DLmcv40vYwmshSEapp8fD1SLIyLPpfQCdUCnt2eEUq6xGGc7DcJ8mIkSnxRNlbTGZLGmss4vIeCrR912WL0Z6cgfQFnJYPUHooC2p6pxUumU4l7X9MdiO1KRaf/NgIBIGr8asNKKTjOQGCnYGlwOIjIBRjxwP3wNSkgY1W5I9fbqZwV1916g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XarVNw+9YQY4XIJSEkzXAMdMd5898uRVstwnoMmMIEU=;
 b=irllt2twRjVyALv3b9G3f98pWxF9B7ZGSoNkEIHXZZuzmNrnbO1XwNLzvpabtttGxVco0i30YfyaCxS/K4U7004n8SAhLt3NLqTs0rdJukitix+AT7nF72VWBm5A66blqEUwaiiTBibZvU729I4rpm2mtXWAv6l4tBENROwqnE5vFEzot4ega8+KzqG9+N2wGOoQQqVTFgQ5jdGPvtLDNeVTdhdRdOHZ6fvwQg47bONZkuWL15yUgBvYzwAD+Zm6H68LZbBXvYlPZmff4XfEyBJxewOpv0XXeQTiAzyaZndvmtkyg0HJ3dgJPhGMyQc7QK/DqbSHYCKjEiMwIrn5KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XarVNw+9YQY4XIJSEkzXAMdMd5898uRVstwnoMmMIEU=;
 b=xbvk7NAtBL9m+FFsGx2ldEMPWsZZvY7bt3HOBOu5BHasODooGKewUKwXpuWwFewuEhi6Unvxs6g0TCri57Vjj9T/exDaIIvDygk4uwZp7AINnUKvD4jdNp5Q/XqHOzNE0D2cEiu4ECCZRwNI5B/v3axBJ/d0K8oZqBhlu5cPmIo=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DM6PR10MB4251.namprd10.prod.outlook.com (2603:10b6:5:21d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Wed, 29 Oct
 2025 04:41:57 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9275.011; Wed, 29 Oct 2025
 04:41:57 +0000
References: <20251028053136.692462-1-ankur.a.arora@oracle.com>
 <20251028053136.692462-8-ankur.a.arora@oracle.com>
 <CAJZ5v0hSvzHfsE4nrEW-Ey0dnJ+m=dSU-f1RywGNU0Xyi3jXtQ@mail.gmail.com>
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
In-reply-to: <CAJZ5v0hSvzHfsE4nrEW-Ey0dnJ+m=dSU-f1RywGNU0Xyi3jXtQ@mail.gmail.com>
Date: Tue, 28 Oct 2025 21:41:55 -0700
Message-ID: <87ms5ajp4c.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MW2PR16CA0023.namprd16.prod.outlook.com (2603:10b6:907::36)
 To CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DM6PR10MB4251:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ca1a902-3113-4313-672a-08de16a57de1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aFNjYVF6OTVxc1VnSW95aXVSdVZ4Qms0ZitDWEh5UDNKdXUzak55Z0Qvb1E2?=
 =?utf-8?B?R2R2ZlJQNFE5ajJXejMwYlQrRjVndHlCYVNzOUJPWnZEeTdiNkxwdUVLa2JJ?=
 =?utf-8?B?Z2F5a1VtTXF0REw5aWV6UU1STFVreHFFRGw0WDkwNUxhSXN1MUtFbHBtbTJP?=
 =?utf-8?B?QmszbWxzbkIxekh6ZHV4cTZicGNBbjR3TmZjd1dhNkJBODdiVG1TV254Q0pq?=
 =?utf-8?B?MytkbzFNM2VlR013RUlVekdRLzh2OWlTM3h3NVI0MDNXeWh0cWVSdEdZQ25B?=
 =?utf-8?B?WllhYXhtVE9VN0Z3d3BSYUxuWTZOM0Z5R1RFQ2t5K0JBdWU1UVRBVmNiUFMw?=
 =?utf-8?B?b0xaTzVsMVdCVHh1TEJIWXFKcHg2Mkc1WVVmSVdUVmZxNExUY1ZCSFFMb3Ft?=
 =?utf-8?B?N3pCQTZmblFhMU5ucXh6MjAzNFd3eHZYWkMzem1YZFh0d0RDbGNrNzV4cGla?=
 =?utf-8?B?WGFWWHFPVHgwaVVPditaaW9CN2Y0L1lmMEp5U2VKQ3U3TTIvU0FSVFVNOEpR?=
 =?utf-8?B?b05xVGxiZE9idHhYQ0tUa2xiU2F6T2NjMW1mZUJhTDJ1SHhwRU5zZFJyU2VP?=
 =?utf-8?B?ZDJzNnNuY2FFTzE5Y1E0WUFSSUhqbzl5MjJqdWlIdHFpSm1sMVVPTTAvZUFN?=
 =?utf-8?B?dStEN3VqbmtzUzNGTWYzMFBndndVVlNCZXo0djlNSUpGUjlKWS8vSGFBbzNO?=
 =?utf-8?B?eGZmbXhtcWlmMnd4UjJqV0ZKd3hPaThZMngzbGVabTZ4Si92SU9ldzVyZGRN?=
 =?utf-8?B?TVV5WDZMUDgyZmFKQ0cyWVhsTWg3YW41cE4zeU8yTTNtZkl4eHVVREJjQlJQ?=
 =?utf-8?B?cFMrTWpqelk0Rk5jMlVUbTlzdG5KR2Y4U3Vxb2VOWDlMWkNmU2duK1QrT2lG?=
 =?utf-8?B?a3Noc1Y5cHJGam1UVWtKSHg0ZVJuUWxjMktCS21mdUUvTWVNd3hjSWdPSXYy?=
 =?utf-8?B?MVVyRVh1a3hqUzFRZG9wdzZLYzhPV0dIQm9tTFJHM2ZTdUxTQ1dPSGw1SHhW?=
 =?utf-8?B?TDVmWVB0amdQWHcydnVmN3JBSS9UWlBoK2lSbVk2UDlsY04vK29xRTFFb3Fs?=
 =?utf-8?B?eWVveE1yOHNGdXFRaTRrREhiRjBDaWdESVVUc0pPeGJibmUxb1BleDlxZXp5?=
 =?utf-8?B?dVZPcGdXNlZaNjJDcTdaTW1DU3ZjSlRFVzdUQVo4Q21Ka0pzNERFZi9yMDBG?=
 =?utf-8?B?NlYyYXVySlFIZW1GNkRCV25hejNQMWo0blJGc1ZhK3VQeFM1L0JXVmlSN3Jq?=
 =?utf-8?B?bXNaUWxJbTA1Tmc5cjZBcXRQVWdtQmdqc2srTDh2RXJTNGhSQmNoOUtEUnNP?=
 =?utf-8?B?WE1EcmtBYTErYWZKSEVKNzIvbmtvUXRjbkk1bW5iUXl4ekNWbVozUWUrUVVj?=
 =?utf-8?B?aWh6aFp3MlFUODdMVU4za0h2NzRybTBuRkdqMHIzU21ZejdDalJVNkl5ZG13?=
 =?utf-8?B?bVFNQTE3Q1R6dlVoNlNrdHhTcWdIeGFrcDlNdTRBcDZUWExSVlVjdExHaWFX?=
 =?utf-8?B?U3N0Znp6enNoV25JOGd1YUV5N2RvV1hLSGdIS2dLRXhlTllLRkJQYW1TNnlU?=
 =?utf-8?B?Y29DTFJWN3AxMnNGRlhEVkFDeDE5NnFSWlV5T3VGTGxjS2NURCtrV0FSZU52?=
 =?utf-8?B?VDk1TGkxTjNUeFEvSHNZVDhQRmxQQ3U0eklZZ1lhR0c0R1BwVzgvUDMrcWFR?=
 =?utf-8?B?T1JwZFgydjUzQ1JiaVFJZzk3QjJ5d3YzNFRCL0doSWZMcHdsQjdFVHhpWFUz?=
 =?utf-8?B?NWkrMU0rL0JiRGczWGwyNisxNFlsRDRNQTBQSmd3UW9vWUdDZ0VEL1ZMaEYz?=
 =?utf-8?B?ZWV1Rk1kL2pHMFV1KzhDVmdnV2l2SXJDcVpqWWZJcFBEOUlxaGV0WGF0azlI?=
 =?utf-8?B?dHNQb3BjSDZsS2lyZTZNQkVjeS9wN3pRMDdlRUZTOTJZYUZPVzhBQW1PMVd6?=
 =?utf-8?Q?XZoXtXD+rpzeKXilh0zsXRLdSh3YWuxo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q0JvZHdMZEZFVVdyU0ZZRnowbG1EczQrRjZCTVp4MlpFUkhxTlQ5Z3ZkUjlI?=
 =?utf-8?B?MGZWMU1vb3FNSjZ3Ympma2xHMVdNL0ZyTDBHRVltQ2FuNTRZdjl6SnJxRTZY?=
 =?utf-8?B?NnJYK2s5YmtyM3R3ZVpMSjI5LzF0ZHRtUFE4azJ6dFQzRmZXWUx3d0RQOTRt?=
 =?utf-8?B?YTR2VVppTk95QnpBQ0N2K2dEbmt5cTd6Zjd4V1U2a0hwdmRkbGIySEltWE1F?=
 =?utf-8?B?RFNTNDU4QTRoVEwrTHY4d3lLQ1hSN2t6SlFveTZDL1FJMDZtL3NqMGluVnlI?=
 =?utf-8?B?cUFGTmJYd0w5dDRuWjdXejZjaTk2Y0l6Q2g2ZC8vRGJVZ0dWT2UvUkVlUDMr?=
 =?utf-8?B?VngxZUxoMytWMmhid2tFMDgxRDhkVzUxR2Rza2w1aG1XUjJ1UUtCc05nZWNR?=
 =?utf-8?B?K0RjYW9DRTJYZCsxRUJ1VUNkd282YXdOU1dMN1ViQ3ZGeUF0NnZBb1N2aStw?=
 =?utf-8?B?TEZLRHYxR21hWVFWTnlycXd4bDBucHF2RWR2TklJQXNNQmZZcXZDWERSTy91?=
 =?utf-8?B?VzYyRnJQKy9jdUlja25hcG03WlJUVmtPbkhvZ2prSDl6V3RZWGtaMWt1T3FE?=
 =?utf-8?B?VjlNWHFaTVJMMlBueTA2Nno2ZFpPMW80cTYwZysvZUYvcjN4SVFDUHFaQzE2?=
 =?utf-8?B?b0tBN3pIQUNoWFZueUV5blZ4QkxKT1liKy90MUg3eWZyVlpjRlVOQ3psTHMv?=
 =?utf-8?B?RVFNWm9TYjBxLy9kY015cTFSMFl5WWJjUWxLbVo1SlNTa213LzhlOGc0ekRG?=
 =?utf-8?B?VnJyZW44aGFwWkZhQVppRGc0NTFnMzdwNEx0YUI1eHdYNHUxbjVidmRxTjI3?=
 =?utf-8?B?UXRRemc5OGlPaElWSVFpRVhlbFhiU3BYV3JxOFlKbGZOaTQwTG05cDY5UWEw?=
 =?utf-8?B?NHEyNWNRV2hrNVRVNjRUdzNoTEQ5UUwyTVk3aTVndjVNN0pQREJwZTZDRGY2?=
 =?utf-8?B?Y3NjQ0RYWXlQbXJCRWNZb1gzam52dTVTZytSY2VGQ2R0Sy9FTysrblR3T0FQ?=
 =?utf-8?B?SCtyVEFDY2IrY0NSbXRlOVN3T0VHSUFWMEZDNWU5NFJRbVdhc2p2SENJMDh5?=
 =?utf-8?B?dVJhWDduRnlxb3BEQUlOQWc1YWFhV20vd1NMU1lyNDYzU2tGZTZnTzdrZk1G?=
 =?utf-8?B?b01YT1k1R2hWNjJOclNIbisvYzNHc3VRMUoyejk0L3pSYXY2WFVPa2phbXh0?=
 =?utf-8?B?aGh3U0F3NEdjdkVCbGE2KzVVQmdleVl2bE8vcFVNVlNGY3V0a1AreUlEUE1x?=
 =?utf-8?B?OXZoWVBIMnlkUzVtRmNtOVNSc2tPUnozbDV3TitGSmdETy94Ui8raWV5TWNR?=
 =?utf-8?B?clpJVGc4YzdNeXV0ejA4Q2QzNTdINE5mVGpDS013UlR4RXNMQnNrUHVxZTl1?=
 =?utf-8?B?bHFSMkpvNXF6ejZVUEplVFJhTXppL3M1bzlOQlR6UGlJdEJiUVJoa3dQWitp?=
 =?utf-8?B?TWh5dzNiRjZ1UDlTeDIrcldXOUtIdWJacU1CdTgrVUF0TXM5U29NWnI2WHFt?=
 =?utf-8?B?RzltY2VjemxqTE1HRUcvODdsUm0wMy9FQ1RYL0JUd3BWaUR1WmorQWIrTHZD?=
 =?utf-8?B?bnprWnE1M3l2dDM4SlJIZ3BqbExOZ3dyZ3VMN1ZodklSSDI3VGVIUldiVzRZ?=
 =?utf-8?B?bUFaUC80TG1LS3oybVgwNW1QYStHcldOaUVXa3N2T3p3OTRkR2I5cTdib05D?=
 =?utf-8?B?WTVTNTdYc0xLRWhCRUxZRm9BMXJVRkREdXh6bWtpZHJuVU5wU1UyZmRPaDdU?=
 =?utf-8?B?NC9SczhIcGdzK2hTSmNOLzVkZVBvbkZjTE9KM21ZMElRUU5TSTc1eEZXQURO?=
 =?utf-8?B?a1JsZmN1K3ZjemlDQTFXZXdXdVNNUXFQV1lSMFdLWlI5aHlrZFJtY3luWW1i?=
 =?utf-8?B?TVZMdHhLQW5vWitpTzdVRVUzdmhUTEMwY0dSWW9vSU1TRzlHVDNoTjluQk9F?=
 =?utf-8?B?bGJkWXdsU0FlQ2RFMjFETUczdlN3a0p6cDdCQ2RaWXNXYXM4eFh6c1JrY1V0?=
 =?utf-8?B?S1FleW43TENTOU9zSmp1TTRucEswUUlBWFNWVmRzV3A5Tjd5Nkd4UlNpNUtE?=
 =?utf-8?B?MVNBY09KWnNDd3J5Tnh0ZURhOUVLYWpTK0hFTlRxUWs5bDRjc0pPbWhLL0hE?=
 =?utf-8?B?MWtqSThnSDVyazhwTVdDNVNJN2FuZjRNQks5ZllkOWI0RHNrZGNremFzZ01z?=
 =?utf-8?B?UkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	c4nRTtLRXUBSb6YJSpsMMMwp8KxWez6St93eN7SS3iRJylYi62YNhO9jsYHZsSzzrF0OLG1VFdf1eETpaLO5UuaQJdI86oaQ+55EivoVtdC/L9lpZsjno+ayWMPERDJFY4RcPFyNAXZmIox59B+ce849FTbwPNdtZ2hJ9RXXeD11iTDkMfi0vmZWmZgXEhmAOedRmLMzhIiifvPTjado8cSlcWw751UtJRxRfULzd3TylHs8WtVRsnLJPH6BLXhc9yWGCCiBL25LZX4giLoYh3GITvG79uYOQitsCG2m5G3R9ZeAVNxb3hE147anldSXCkcdTx+aVw9gEcFCLUPwSFsciWEB64/C4e7PpC8B9qrgaktKnpkrEd/MAI/6aHSWllquiJlHqWtwT2E+pM6gH2f8q4b6eO5x2rmC/CNvdclUZRJkH1jR2XjF92AMvAH5FNWpiZzT0fZPRL9QV1Y4UpmzuUsMkPSLAPRTC4Nv72Q8Rbd2H0Er0q1Fb4dkxL0YLad4cwLteEI31YCJmLSTY6htfbvKoR1OmN/5B5FfSJIPNldTWOvbGmMD+KsD1iDPa48hPyHCJ2JGW5O8b9OeozzrvGGY9BxITq0omAgaq6I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ca1a902-3113-4313-672a-08de16a57de1
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 04:41:57.6126
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RHjch0FPWoNIEBYvplGPHPwBlHcwLpTh298Qv8vDzyVW1WbHFgDxxYkaQYIiUVM3Eq1itByoRdrAG73AZnRkyb3wwiNm6Qbk2ap6rbU73u8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4251
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-29_02,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 suspectscore=0 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2510290034
X-Authority-Analysis: v=2.4 cv=R9YO2NRX c=1 sm=1 tr=0 ts=69019b1a b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=KKAkSRfTAAAA:8 a=du4TVRCj8l5hAJjH2W0A:9
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22 cc=ntf awl=host:12123
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDAyNiBTYWx0ZWRfX4OcygqiqBvau
 //pyDtzc0/FmLQzC16cGftLgwdMu4ZC3u+9ick6f/vryggPzhVHrFzPgE11z+5zkHP2IjBI//J/
 CBX6rpLT7Y1QIP1unTUoe1p7K2tGVSkk8rLKOGh5KqCS+D3thjY4epMvzc8TSIuQp8wLWkh9xpj
 2oSlTk1T+Jeyw79YjOZqWZW0BDSneqUz3RwzZCg7XT95E4PVpSJXauvzafn5BK4CbiVNKEfApod
 eMOxi/BA3EWVCyE764z+XAB0wvCA1lVX8AX0gytM3PaQldluRg+Z7trP48DUZSwESOur9ejB1hd
 fWsjRsWY1u19eiZ5nYSdcXd/Z0xXVPJVeLjo81QQl9vzTuAuCA7JpIIn/Uc0XlRhTRApel3sSv1
 oHGOO7BhGIrbfEPjIpwY4Jeh7B/l6K35EPCEWFefJ/Q0kUoUlMc=
X-Proofpoint-ORIG-GUID: 2bQhVz0MGqB33VFkMnqZZV9jZTVkG3je
X-Proofpoint-GUID: 2bQhVz0MGqB33VFkMnqZZV9jZTVkG3je


Rafael J. Wysocki <rafael@kernel.org> writes:

> On Tue, Oct 28, 2025 at 6:32=E2=80=AFAM Ankur Arora <ankur.a.arora@oracle=
.com> wrote:
>>
>> The inner loop in poll_idle() polls over the thread_info flags,
>> waiting to see if the thread has TIF_NEED_RESCHED set. The loop
>> exits once the condition is met, or if the poll time limit has
>> been exceeded.
>>
>> To minimize the number of instructions executed in each iteration,
>> the time check is done only intermittently (once every
>> POLL_IDLE_RELAX_COUNT iterations). In addition, each loop iteration
>> executes cpu_relax() which on certain platforms provides a hint to
>> the pipeline that the loop busy-waits, allowing the processor to
>> reduce power consumption.
>>
>> This is close to what smp_cond_load_relaxed_timeout() provides. So,
>> restructure the loop and fold the loop condition and the timeout check
>> in smp_cond_load_relaxed_timeout().
>
> Well, it is close, but is it close enough?

I guess that's the question.

>> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
>> ---
>>  drivers/cpuidle/poll_state.c | 29 ++++++++---------------------
>>  1 file changed, 8 insertions(+), 21 deletions(-)
>>
>> diff --git a/drivers/cpuidle/poll_state.c b/drivers/cpuidle/poll_state.c
>> index 9b6d90a72601..dc7f4b424fec 100644
>> --- a/drivers/cpuidle/poll_state.c
>> +++ b/drivers/cpuidle/poll_state.c
>> @@ -8,35 +8,22 @@
>>  #include <linux/sched/clock.h>
>>  #include <linux/sched/idle.h>
>>
>> -#define POLL_IDLE_RELAX_COUNT  200
>> -
>>  static int __cpuidle poll_idle(struct cpuidle_device *dev,
>>                                struct cpuidle_driver *drv, int index)
>>  {
>> -       u64 time_start;
>> -
>> -       time_start =3D local_clock_noinstr();
>> +       u64 time_end;
>> +       u32 flags =3D 0;
>>
>>         dev->poll_time_limit =3D false;
>>
>> +       time_end =3D local_clock_noinstr() + cpuidle_poll_time(drv, dev)=
;
>
> Is there any particular reason for doing this unconditionally?  If
> not, then it looks like an arbitrary unrelated change to me.

Agreed. Will fix.

>> +
>>         raw_local_irq_enable();
>>         if (!current_set_polling_and_test()) {
>> -               unsigned int loop_count =3D 0;
>> -               u64 limit;
>> -
>> -               limit =3D cpuidle_poll_time(drv, dev);
>> -
>> -               while (!need_resched()) {
>> -                       cpu_relax();
>> -                       if (loop_count++ < POLL_IDLE_RELAX_COUNT)
>> -                               continue;
>> -
>> -                       loop_count =3D 0;
>> -                       if (local_clock_noinstr() - time_start > limit) =
{
>> -                               dev->poll_time_limit =3D true;
>> -                               break;
>> -                       }
>> -               }
>> +               flags =3D smp_cond_load_relaxed_timeout(&current_thread_=
info()->flags,
>> +                                                     (VAL & _TIF_NEED_R=
ESCHED),
>> +                                                     (local_clock_noins=
tr() >=3D time_end));
>
> So my understanding of this is that it reduces duplication with some
> other places doing similar things.  Fair enough.
>
> However, since there is "timeout" in the name, I'd expect it to take
> the timeout as an argument.

The early versions did have a timeout but that complicated the
implementation significantly. And the current users poll_idle(),
rqspinlock don't need a precise timeout.

smp_cond_load_relaxed_timed(), smp_cond_load_relaxed_timecheck()?

The problem with all suffixes I can think of is that it makes the
interface itself nonobvious.

Possibly something with the sense of bail out might work.

--
ankur

