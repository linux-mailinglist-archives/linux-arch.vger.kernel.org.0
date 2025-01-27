Return-Path: <linux-arch+bounces-9929-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE908A20203
	for <lists+linux-arch@lfdr.de>; Tue, 28 Jan 2025 01:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 382B2164B03
	for <lists+linux-arch@lfdr.de>; Tue, 28 Jan 2025 00:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3F61F4713;
	Tue, 28 Jan 2025 00:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hoq6fCCe";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jvXok5cY"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499E01F2365;
	Tue, 28 Jan 2025 00:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738022424; cv=fail; b=oRIQQyQCwfuOEtiAjbX6sSN7L1dR8m6gWw7oSX3Q451nMUKG+S2JwyWbXZsOXhMRXb7xtyO2TKoarsFqviv7wTFj1oDB9wzwzkgPKuoDw3X/cur8zTfbyz1BLjGADqW07ies7Q2/xDs8E5A7NJa2na0xAMuNPdjTIep3XCNC+BE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738022424; c=relaxed/simple;
	bh=jr6gEKn+Y3ol77t/OntMZktcOQcEifz7rBwYk6LwNLI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=l+3KFDijy8zYB1qdSVRduqaDHvHtvzQpwTSyvpefMnFb5YxgY2aA5F2+1DBeDKwgbHJkGh90KBePhAXq5eKC3hqiaE8NCl8Vrw/WB1bnBp5OJsA2nBcwCnMPqsCOE68H3X4cu8DAGfOjVO5OOBu7OUg0X+tBVoheXKxvr1PYth8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hoq6fCCe; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jvXok5cY; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50RNY1Ia012894;
	Mon, 27 Jan 2025 23:59:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Pf3aL2zl6N/DQGMuu6sSbtvfLTrCaugJke4AjDjycXk=; b=
	hoq6fCCeXiLMIrzg1BNBj2tkMFPZimjyjfvrSt9ARsmmVqA75vVS0E08Etc3tU4Y
	G0pgh/n1Or5hSg8C54g9b8o73ANQrfD5W9vdnIAktvIpN3+enjMLO92rSzFOrH4e
	axFybKWCoOsXo1Z9AdKzDHCtqy2R4O/PrC/hChM8QJJuIUC+/GhQtOsmNZm9gYSd
	h4tGPP/+DkCHd12LKM0utTxXXxdgpo/kO2/eAwEoYqTM9GRARX9Y3nBijk8s5jBf
	rCe0vpOAmV1f4O3UJ3QvHqrxBJ7O+dhCskoCg/XdfAwBjo34oVg4n3LmeqgNtdzE
	GAU4M4Q+rprym6piXWh3Iw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44ekw680q5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jan 2025 23:59:41 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50RMR9cP035935;
	Mon, 27 Jan 2025 23:59:40 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44cpddpbk1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jan 2025 23:59:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CdTtRehGIPiFbK6gNndSr4Ur6E3GmMGVcK+Nim6iRPG1v3v5ON6/ZuNm02QdbbutXp8WqsWXPImkENYNhYVpfHhia3chCrovsJSQtVkFIAXZdIBtxXmVEOB4DiU89CQFgTo0MtEFx1ML+LS+hQ9RKCfqyp2kbxcaPRO/LKtFJZVeKgZrENE1e64w/EF7v6iGTii/nI3dz0oSQILiyDXoyxDYkH4p3wZDYY3vJwIOnHBq+0eR2Km+AQV+pCiIoDPLGrFedQvF7Ry7m8K16TsW3KuWwxr/goXss0fwL+nSY/ZGWDmT+OyPDgYMKSeRQMZyFf63y+Aq1nO54J+GMyjiFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pf3aL2zl6N/DQGMuu6sSbtvfLTrCaugJke4AjDjycXk=;
 b=A/VFhwBTvrVjVFx9HHa4fT46BDnSBgZH8Lulsiys6H7DMJlev8/LZOWWY4OX5bDmrwjtSu3AwEG6LoPc8nbyAVj6zImys8IjcpZWrmNGgDuErIZK5sXXGTpUrTJg/URSIlHfPyW3t45A2bRV0NLRRSY5ev2cXRObu5aH0/NZClA/hN5AJNJKdmoqwSFtqDtWH3G6lAgqXSERDHwrelPrsAqdHQICRDGfZ4xT7yuLy2i2Kk3bpU0IO8K9TC6nmCaty+UPRHIDA/yLHv7wphlviWXzc0qgwSN1rwihtH0PqBdxIH/kqSo4YtjIlhy3GVOMMuUcoCLJIcJ83p5JUHU/Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pf3aL2zl6N/DQGMuu6sSbtvfLTrCaugJke4AjDjycXk=;
 b=jvXok5cYhMx3w62wHwpXYTNxHEdiEPSdBjiTwQnAGI2XSjaM9x7dfLNXG9x0Lzr09n30JlapMYDdFa+iB2jD2WKah+c0xiZwL5WQFtFpdL0X3RmdNw8jesE0zWHjloA+Q5eYcO8oLILfnPwc/Bs5OCXrAzzmr9oyB9sgyzDKmro=
Received: from MW6PR10MB7660.namprd10.prod.outlook.com (2603:10b6:303:24b::12)
 by CH0PR10MB5180.namprd10.prod.outlook.com (2603:10b6:610:db::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Mon, 27 Jan
 2025 23:59:37 +0000
Received: from MW6PR10MB7660.namprd10.prod.outlook.com
 ([fe80::41fa:92d3:28b9:2a15]) by MW6PR10MB7660.namprd10.prod.outlook.com
 ([fe80::41fa:92d3:28b9:2a15%5]) with mapi id 15.20.8377.021; Mon, 27 Jan 2025
 23:59:35 +0000
Message-ID: <4ac061cf-9b98-4831-9058-a3cb0e743dd6@oracle.com>
Date: Mon, 27 Jan 2025 15:59:30 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/20] Add support for shared PTEs across processes
To: Andrew Morton <akpm@linux-foundation.org>
Cc: willy@infradead.org, markhemm@googlemail.com, viro@zeniv.linux.org.uk,
        david@redhat.com, khalid@kernel.org, jthoughton@google.com,
        corbet@lwn.net, dave.hansen@intel.com, kirill@shutemov.name,
        luto@kernel.org, brauner@kernel.org, arnd@arndb.de,
        ebiederm@xmission.com, catalin.marinas@arm.com, mingo@redhat.com,
        peterz@infradead.org, liam.howlett@oracle.com,
        lorenzo.stoakes@oracle.com, vbabka@suse.cz, jannh@google.com,
        hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
        shakeel.butt@linux.dev, muchun.song@linux.dev, tglx@linutronix.de,
        cgroups@vger.kernel.org, x86@kernel.org, linux-doc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mhiramat@kernel.org, rostedt@goodmis.org,
        vasily.averin@linux.dev, xhao@linux.alibaba.com, pcc@google.com,
        neilb@suse.de, maz@kernel.org
References: <20250124235454.84587-1-anthony.yznaga@oracle.com>
 <20250127143339.b1f6b6d5586f319762c5e516@linux-foundation.org>
Content-Language: en-US
From: Anthony Yznaga <anthony.yznaga@oracle.com>
In-Reply-To: <20250127143339.b1f6b6d5586f319762c5e516@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0153.namprd05.prod.outlook.com
 (2603:10b6:a03:339::8) To MW6PR10MB7660.namprd10.prod.outlook.com
 (2603:10b6:303:24b::12)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7660:EE_|CH0PR10MB5180:EE_
X-MS-Office365-Filtering-Correlation-Id: d84c4c21-80ac-4455-84d2-08dd3f2ea684
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZHhZMVdCZ3N5RHA4ZUlBYWxRRDF4ZGk4a2dWL2R3QkpwNy8rd2hvQWZORFBU?=
 =?utf-8?B?TFZNN2lsd1hYQllzRFNLWS9LTEk0M29BQm1rZlp5T0x5Uk9IMVY1QlFFLzln?=
 =?utf-8?B?d1FVU3Yrc1F6YnMwTlFIcThMeEs5QlRQNFlTdWxOYXhsR1dJQTNlMUdMWG1B?=
 =?utf-8?B?RHRPbVlxUms3d3VsVm1kMGx6dnprNHhzMmVac3YwL3lqemd5bjFkcTdxK1lK?=
 =?utf-8?B?YzdJS3IyNWhFUkJkNmtNUlBKaXpvR29WaWtJcVRtWHlWVmI1QXhuNC9YVmNp?=
 =?utf-8?B?THR0eks4OFRJbmd1cktlSWpHbndIcHJ3bC9ydjIzM29wS0RHQUh0UFlhZTdI?=
 =?utf-8?B?YnpZWEdGV1ZDNnZwdWxUaWxSRWdRSEQyUmpzUEpuWnd1R1pUNVB2SmNCekJ0?=
 =?utf-8?B?NW9GeTY2cGM1a3I5NnkrYXYwOGhNME1iVy9aZnUwTkZrRUMxOUhMZDBNeG93?=
 =?utf-8?B?TzZHTVdTV1h2MExHb1lZQTV6NldmN0Y4UE5HUVFzZk9VRkZIMzVBZUlTSzBP?=
 =?utf-8?B?azl1Ui96VE80WFlTYXVJUFlaL1hOYmFKMWZrVzBGQzMyWVl0Y0ZCMU1lb0RN?=
 =?utf-8?B?UFJiSzJVQ3lmRGt0YjJJOG8wNlBzWmgvc3JheDB2cHo0R1Q2eENYclBGMHJ5?=
 =?utf-8?B?R2FqbndLQmxERGR3UmlpSFRhbWRXQmF3bnR4YVo1ZmpURHBVMzhrUXFKcVVB?=
 =?utf-8?B?K2xLWXdpd2gxQURjdTkrUWczdlJsNUFWeTU3NFp5Ym9uM0JoNEV3R25IWGt1?=
 =?utf-8?B?VlhmZjJnUHlTQ29yclpObHdiNXQraTUvTm1YaFNCNEtDWkFmNmdJbjJtQWJ0?=
 =?utf-8?B?blNXZVIyQjlQTlZSS25vcHplbmxabUNTL01lY015eE1TTVV0cGpPTndkS3o0?=
 =?utf-8?B?eVhBY0o3WXpTTWUxdkd5NHIzekczSGRNdTkzYzlFbUFjZ25LNGxlWTUzenpP?=
 =?utf-8?B?U2tjYmx5V1FOd3Vnd0J3Z0NRdWxDUURhN2tRUG8zV1hEbWt5U2dsNGlITWlF?=
 =?utf-8?B?QWthYUNhWmVaSG9SVWk5cmMwZnpsekpKek4vb3dWcnVoUExxN3VLYTJoOVMv?=
 =?utf-8?B?eDRKdWlJSTE5RzN2ay9mQ0grK1dtWFNldXNSZ3ppVUJlS1d2ZDhud08wNU9Z?=
 =?utf-8?B?c0RIMDcvaS9SSS9NS2VVSGwzZHhvZlU4RnJvS3h5NzhOMzJpSTVrQmN4NVJs?=
 =?utf-8?B?WnN5UURKblBKVFNCOWoyK0w3VFhZcDR2UG1vSkRNa0VZY3h2dzlqUlZmUnNK?=
 =?utf-8?B?dnJoWjdNM3lFSlVwYVJOM0pkWHJhZDV1djZTRnQrSVZla1I3NlJobllNT2tR?=
 =?utf-8?B?OW9lZUx4RnRWdkNoVkllTkxOM2kwdVN3NE84b0hpNDI2bG1QanZkMGhub3pV?=
 =?utf-8?B?Zy9lZ2tCWndsZjVLeTFJbWxYaUJOeEVxNW9KTHdoZWUwUGZRejdGM29NRWtV?=
 =?utf-8?B?dFM4Y0NwRVBWbFlmRXpvdXQwOTBSMUp6OE5DYU51Tm9iREtqdnVMT245OFMx?=
 =?utf-8?B?aUhzTTJxMFBCR3phRVNSdUVOUVlJV1VwWnNqd2dNeXpOaWtObFVTazArT05n?=
 =?utf-8?B?a0ZwTlduQ2lDbUVkNmRRK0Z2aTBKT1NhZXBCMHZUdkZiemFZazZ3bHArWER6?=
 =?utf-8?B?QWVIUUs1K2JWME4xdnliUFErTEg0bVMxb2hPWkNIWS9aZWErUUF0WEh6eXk4?=
 =?utf-8?B?eURXUWh4MU9vdjVJcU14NHVSRGdTeWs3eWdkR21vYTRtaTZFbkdUWHJWQnRo?=
 =?utf-8?B?Rzg1bnBZcXlLNTVzNlZFd3ZUNmxscjZUZUYrb3BFZ2U5ZjV4cXVTcEJBaXhp?=
 =?utf-8?B?Zkk0eTdNamVFUlk2VklSdWUyS3RmdWVnOVIwTm5qK2hRK0J3NEFxd3NYYWVK?=
 =?utf-8?Q?bb+B2ttFezY43?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7660.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L2gxTzZFeFVkNU1UUWhpU1QxTVVKVFFkQ3BxS3BGTlpyK2IyYmYvalROajhl?=
 =?utf-8?B?TkFMUWNIRXRIS3BPQkdsa2F3YWZnczBZNEliMVVVK0xnZmUrblVGZU9HeFFw?=
 =?utf-8?B?T25QMDZjNFpPb29oNjJMWUdwRVgzZ3k0Ujlvakh4eGpBTHlUU2ljbUZaSTJy?=
 =?utf-8?B?NmNYWVpGWWd1ZkdlSDlJR1hwVjU1UythR0lZVVNhbFRrWmJuVmt0TC9wL2Jx?=
 =?utf-8?B?cjA0ZDRtanBINGRySENHRnVyRUpnOXhWUTRKckh6bmQ5Q3Fsa29lR0hRd0Jh?=
 =?utf-8?B?alpwK1VhclNVR1Q1MFZnYVNLME9JTzFlOTFHbmkwdXdGbU1XVGo5bDk3VmRE?=
 =?utf-8?B?UVR5NklyTk9CaFI4Q05JalhVLyt4bHRub1lNY1RpTmErVTBoV0NET0hyWjFT?=
 =?utf-8?B?elo5SkdHazVDdjhrd2VWZ1lTVnNFZmk4RzV0ZENORWVjeldibjdKUThlY0tR?=
 =?utf-8?B?TXBFNGRZd0ZNWmlhUUFKRjlSYyszNHRsMEMvUnRhLzU1L2NYenM2M0ZjeDM1?=
 =?utf-8?B?WWFnSFhubi81bWFMVlVNTjRieHh2Tk00emhwbmJvVG95T09jMkczNmZWdUQ4?=
 =?utf-8?B?WmpGNGJLYnl2Q3h1STdZOXcwZ2xIbXdYOUtPQ0lJWFl4eHJsN25rSGUrNmtF?=
 =?utf-8?B?QnFoV0pwTk1BRjRob0hTamYya1FURkF6ZTRFdXlBVzh1QXBVQWswYVFlbEZE?=
 =?utf-8?B?Q3crNWRiV1ZGT3gvRTZJajR0dGZRT0dPUlo3YjdvOHFCMDhzQ3hWWUZxVkQv?=
 =?utf-8?B?cXJuSmkxRnVzZ3hOblVKbmZBeS9GcXViZHFPZkltQmxiaUY5cUluekd2M0tV?=
 =?utf-8?B?RHlqUjh2ZFFDOXF2S0NUSEFzMDNlUkF4Z0VBc2Nmc0NJbnUrcEhKYnZqL3pG?=
 =?utf-8?B?aWxlV21ndERPVjBWSjI0OE1UcVp1b256bWlHYS96aWNhSHJsSEYzMWJYc1Jt?=
 =?utf-8?B?THczcDhvOVV2M1lBZzl0NkZhdDBEbW1aMFREK3pXYzhLeVJndTR1KzJjcngx?=
 =?utf-8?B?Nk8yQVdZcURQS2FSR3lOV2VQV0V6RWZJN29NTWVoL1c3ZzlFdkh2MnVQRmt4?=
 =?utf-8?B?L3gxN0M5ZGQ2N1hyQktud2JWNzhhM1RvYnpySTkzbUhTK2VKYis3aVVlcDE0?=
 =?utf-8?B?MTRuenkvRHRGRkNEalV1YUFEUVhIam5kMWhtUEorenFFakdTV0l3YXhJK1I2?=
 =?utf-8?B?NzJrOWpiMDJGWE5sdk9ORm02NGhhV2c4dVByOFVML1dQaWJHNHJFZWYyc1NS?=
 =?utf-8?B?L2JSamVtZmNXK0tXdGRWTnMxaG5aRXQ5Qm1nVW9saUlQN0xIbzBYTm9DdjF3?=
 =?utf-8?B?aHlCejk2dlhJVHJhWkdQZnMrbEdkK29vMDIzM2xxRklGZVpXek9uVnlEeERH?=
 =?utf-8?B?Uy9aSXJ4MXlLWDdUQ0lVbkZHcFkxamFJQ0tmSWJxZVBGTDkvS2J2M2E2OTR0?=
 =?utf-8?B?cHVsc3QxWTlDZUJWVlpidmxVS3hiVStyNy84aHMzRHhHS3lXMlR3Z2RyRDdT?=
 =?utf-8?B?OGljc0RIWGx5RHhpbmJTQ1M4T1h4ZXdkKzhLbkJyMVJ2Qm02TWxmZWNmWklD?=
 =?utf-8?B?STdxaTFDdzlrQzY5ayswRGpMemtpSEU1b1NUOHV1aVFxOGt2QUlmQ3dHSHRa?=
 =?utf-8?B?WVUwbkMvTTBHL1FsenlsRnZINkRjMnIzYmRWa0FKaXI4dkhUQTF6YXFXUTZj?=
 =?utf-8?B?NzhXeWJhL1VsQ1Voc0lVcUdYdnd3QjI3YkpIdmZITGFLUkdwNndlRVMwL0p4?=
 =?utf-8?B?UnBkekRvd25SMWI2RWs2REh2T2tkaGxGQVFqL3c4RWRVZ3ZSdHBmUVdocW94?=
 =?utf-8?B?WFpTcVAvWWpiWW0wVG5veFRRSFZ2UXVESkI0VU5xbzVhVVk5OFZ1NjNWSzRp?=
 =?utf-8?B?KzhCMVNGcWt4YWw0cGtQMW5QZnJwT0grWHRINGpwMWJhZHhwQVoxZFI4QVAw?=
 =?utf-8?B?T1psSGUrSHZXTFNzQXFjMDI5MUEyajBsT2VnNTFSZXcxYUg3Q1MxV3FLRFZ6?=
 =?utf-8?B?clBjR2F6ajJjaXR3R1k1eVZ2Ky9payt2blpoWnI4enNVR2VUWkdPQzAyZzVQ?=
 =?utf-8?B?YURiejZSV2Q3elZHVk5xaUNJN0lwYk0wVlI3ZGh0UDNpSksycHFpWGRWbm5C?=
 =?utf-8?B?ZFlRcSsrckp3OEYwVUgrSnpQTGJEeEY4ZERZSW84Zm1jbExCemN0UmY2Sm80?=
 =?utf-8?B?UEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	V32riONHu6oQs2I17OiXToy12IgQ+osUpPOiThB++/vKWpKyYuUhkgSG4M+cFHlxeR78u5diPsFYnaynq+lqHbo6RPwkyqqJiwFiq3klIIMpOHze7SWiPwMst3mmyPmV1h9a7Hh4sHFGzYtq7h46EWSaTYIGK+tqxaP21naN3KYMne7xgx9kPyTbfSP++1Mz+xqbWTDNNNX7Pa7UzRHywIjyexyt9ZKmg4/ik9+pFY310p4rwtSNWaEnYP4fdRrToKUncKPJfAZKMqnDQihtI+pUIiQLBf1YcUMLm2X5KXKPNCFCdaOszTmsuOWwH1u6k7nrZqbPT/v5lmWuV/kku1xnUp1ppBmL9wyK0AFFyiY4oQSvW2e1nTcvwfyhgEtUa5D1G5cWyM00OL/zrzM+tNJCQbx3yR/sHpQ6japT2iAGjPpIJjgLr9EQp6hXXzIkz9QEW62XWWDA1ZxX6dswTGUJJ21ew4V6wQz0P/+Vm5nWSw+l1/+1mksDJ6SN2C2uuYnbrrsAb4nKtnfrAmYgxsNbEBeVivMXeWephTLQ3YJsTgzzJbgjbYdpnn8OkgdFUVUOj6k+530oUQkEP8UREKZwXEsNm7rmORQ5VaWv0js=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d84c4c21-80ac-4455-84d2-08dd3f2ea684
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7660.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2025 23:59:35.3590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a1wH+nTfGXTz95zyJF1gDYmkp2K6nxaDn9DxEpksdGoa4vbCr/VF2fYejVZiPlFWwjVVombJI9OknisGIG973si4f7JveKiwMCVXTH/WIjM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5180
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-27_11,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 phishscore=0 suspectscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501270188
X-Proofpoint-ORIG-GUID: 8rfQ5TZcyYuRB8-PhXlBhUDGBJTLQEkz
X-Proofpoint-GUID: 8rfQ5TZcyYuRB8-PhXlBhUDGBJTLQEkz


On 1/27/25 2:33 PM, Andrew Morton wrote:
> On Fri, 24 Jan 2025 15:54:34 -0800 Anthony Yznaga <anthony.yznaga@oracle.com> wrote:
>
>> Memory pages shared between processes require page table entries
>> (PTEs) for each process. Each of these PTEs consume some of
>> the memory and as long as the number of mappings being maintained
>> is small enough, this space consumed by page tables is not
>> objectionable. When very few memory pages are shared between
>> processes, the number of PTEs to maintain is mostly constrained by
>> the number of pages of memory on the system. As the number of shared
>> pages and the number of times pages are shared goes up, amount of
>> memory consumed by page tables starts to become significant. This
>> issue does not apply to threads. Any number of threads can share the
>> same pages inside a process while sharing the same PTEs. Extending
>> this same model to sharing pages across processes can eliminate this
>> issue for sharing across processes as well.
>>
>> ...
>>
>> API
>> ===
>>
>> mshare does not introduce a new API. It instead uses existing APIs
>> to implement page table sharing. The steps to use this feature are:
>>
>> 1. Mount msharefs on /sys/fs/mshare -
>>          mount -t msharefs msharefs /sys/fs/mshare
>>
>> 2. mshare regions have alignment and size requirements. Start
>>     address for the region must be aligned to an address boundary and
>>     be a multiple of fixed size. This alignment and size requirement
>>     can be obtained by reading the file /sys/fs/mshare/mshare_info
>>     which returns a number in text format. mshare regions must be
>>     aligned to this boundary and be a multiple of this size.
>>
>> 3. For the process creating an mshare region:
>>          a. Create a file on /sys/fs/mshare, for example -
>>                  fd = open("/sys/fs/mshare/shareme",
>>                                  O_RDWR|O_CREAT|O_EXCL, 0600);
>>
>>          b. Establish the starting address and size of the region
>>                  struct mshare_info minfo;
>>
>>                  minfo.start = TB(2);
>>                  minfo.size = BUFFER_SIZE;
>>                  ioctl(fd, MSHAREFS_SET_SIZE, &minfo)
>>
>>          c. Map some memory in the region
>>                  struct mshare_create mcreate;
>>
>>                  mcreate.addr = TB(2);
>>                  mcreate.size = BUFFER_SIZE;
>>                  mcreate.offset = 0;
>>                  mcreate.prot = PROT_READ | PROT_WRITE;
>>                  mcreate.flags = MAP_ANONYMOUS | MAP_SHARED | MAP_FIXED;
>>                  mcreate.fd = -1;
>>
>>                  ioctl(fd, MSHAREFS_CREATE_MAPPING, &mcreate)
> I'm not really understanding why step a exists.  It's basically an
> mmap() so why can't this be done within step d?

One way to think of it is that step d establishes a window to the mshare 
region and the objects mapped within it.

Discussions on earlier iterations of mshare pushed back strongly on 
introducing special casing in the mmap path to redirect mmaps that fell 
within an mshare region to map into an mshare mm. Even then it gets 
messier for munmap, i.e. does an unmap of the whole range mean unmap the 
window or unmap the objects within it.

>
>>          d. Map the mshare region into the process
>>                  mmap((void *)TB(2), BUF_SIZE, PROT_READ | PROT_WRITE,
>>                          MAP_SHARED, fd, 0);
>>
>>          e. Write and read to mshared region normally.
>>
>> 4. For processes attaching an mshare region:
>>          a. Open the file on msharefs, for example -
>>                  fd = open("/sys/fs/mshare/shareme", O_RDWR);
>>
>>          b. Get information about mshare'd region from the file:
>>                  struct mshare_info minfo;
>>
>>                  ioctl(fd, MSHAREFS_GET_SIZE, &minfo);
>>
>>          c. Map the mshare'd region into the process
>>                  mmap(minfo.start, minfo.size,
>>                          PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
>>
>> 5. To delete the mshare region -
>>                  unlink("/sys/fs/mshare/shareme");
>>
> The userspace intergace is the thing we should initially consider.  I'm
> having ancient memories of hugetlbfs.  Over time it was seen that
> hugetlbfs was too standalone and huge pages became more (and more (and
> more (and more))) integrated into regular MM code.  Can we expect a
> similar evolution with pte-shared memory and if so, is this the correct
> interface to be starting out with?

I don't know. This is an approach that has been refined through a number 
of discussions, but I'm certainly open to alternatives.


Anthony


