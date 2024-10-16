Return-Path: <linux-arch+bounces-8197-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9CB299FD65
	for <lists+linux-arch@lfdr.de>; Wed, 16 Oct 2024 02:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82DB028669A
	for <lists+linux-arch@lfdr.de>; Wed, 16 Oct 2024 00:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42817DDC7;
	Wed, 16 Oct 2024 00:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WBuOvN7l";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vqfLhMwa"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CDC1097B;
	Wed, 16 Oct 2024 00:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729039849; cv=fail; b=D7f5d4QOu6FDL9RoBZmJdY7VE/bh9/HrU+UO+dvFIxwmizratqh04zmcyI8ouOGayAJgrCfIpMeaO3hZpMl7mdodv8WxxZpGUdFqTH97kwvWLsYzgxrw+GwGhkcgRoCygqCWvqbsqy5f2y/ucEmODmxYlK8pdKzlJn8+kEcfE34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729039849; c=relaxed/simple;
	bh=yXMNCWAEzMr671/U/9i+wTY2uxP4AEPPc2qAUxxHIIA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GhIoi/6eqP3fAuz02gd0ecH/G2CAXTmerz9BXpDZRokSeyY+7uUBxUduLkM4hz9esEzSkab/bALwh1uhAFbSRVPzJZq6nbkEe0BhkDo3WGY0g6RArHEIYkhVA5Tux0MwhOYsqD/srP+LgSwCzqA1I0lBrxYU8JvRVwIQcbqwdbA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WBuOvN7l; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vqfLhMwa; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49FHthEU019373;
	Wed, 16 Oct 2024 00:50:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=1ZZavvmL+POZ3yS4tlJRbY2KfmsSnJ2i1ab4gpW8W5w=; b=
	WBuOvN7lX/pOm2mEWM9pAvY5uPf4pFux1welOqY90YECn1tTGmx+QN5SmNSpk2d6
	uyQe4lXNSYQUIEv920OGW3JbCVeYQjFQ/hektGOCqaXMqqDmiLwAdqLojpmaws5Q
	suAqh3VzDf2sCJV4ZGJHAxSVp9laG9Y+NPYZHUET4DNudZRN2hlwKsf+iexyBohU
	VLRW8I/24F7PTkD3bOCEDxg/jEws6lJ/k69FhwRkaN0tY8CnzdOmED0lcnmgmmo4
	oxa8BQ7mSefP+kLy+igQCWCcsuR4yrinmDzM0Gijzq+jAWYlLUYCmMbzZ8LXyWY5
	2xoICHczD3MH9GqeOHj6Ig==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427gq7jk7u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Oct 2024 00:50:03 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49FM6kvL019943;
	Wed, 16 Oct 2024 00:50:02 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fj86bta-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Oct 2024 00:50:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eo5v+3gVtPsQGs9x7JhXQ156gQTU83YQCGnp978zWauvQoStXbqssobsRcefosczscs4/zB2zmFkpx9gNK3ll6SRWkRa9oRXvbhu11K1fIyY1nz+6Gzk5TCzMBJ9ByqocWGTm0D3xY2LidqeLFfHreuA+apMM/BzOx9da4OmveJ96j0gA6Cph6Wcsa4vUCExmjBP8Lcw3mVz0IfkoKb+vLhYXdOzbLbJ3/Fsa7X0NqfA/q4LCbTiodmJ07glg/onHfF4tCg4sT4Mw/nIdQ/PKwlab2NoVCatVm3IATjgA4gqvagoy7iwrlIuewCyTTSGz7kX6rMkfXuQks17RHa1QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ZZavvmL+POZ3yS4tlJRbY2KfmsSnJ2i1ab4gpW8W5w=;
 b=aK480X2b3U0oAzhg9aTEWVcM4RuwoOnRa4vVms+LVzaneo9vuZcaLQpeuGQ6znWiq1cDJHD2fyF0nWkjJwR1asrGKieLsVvkPy3z1+FEcK9Ls6pxLIzzdATESZ4bILAbrT1GrECClk9Od/Gd7JO8cr9Uw3ceH2VXpQ8QUwtfDvpxskBUK/G6IlTAh/rnhY0Ngj14KjueQo/so9zXPLqJn01y/8a4ZZOgnBOl+z/S85TdeyVhMOeJ9ID0vj/BxBE8QoeY1lxvPaXnjIstqjO+yw5H56xdX0JL1nquoJu/3iUhzunkbSQRQkoc/LeYL6GWsX7xgZdQMneZRN4RWgK9eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ZZavvmL+POZ3yS4tlJRbY2KfmsSnJ2i1ab4gpW8W5w=;
 b=vqfLhMwaKx5eYVRnWXJY83dVmXIEFAnrJcOuhvQ5cfg5Got8/5usTz/90Snt1Ed+ZbsILxBOEW5ARwEDRnQsqJDAwc7DFCouWJB6EiEp8iHyQIchRZnJSMBTidZLEXVsvCjH8uFDX0MIJGZuEqBW+Uq+WxNq3jzrbmwCLt5EbYc=
Received: from MW6PR10MB7660.namprd10.prod.outlook.com (2603:10b6:303:24b::12)
 by PH7PR10MB6132.namprd10.prod.outlook.com (2603:10b6:510:1f4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Wed, 16 Oct
 2024 00:49:57 +0000
Received: from MW6PR10MB7660.namprd10.prod.outlook.com
 ([fe80::41fa:92d3:28b9:2a15]) by MW6PR10MB7660.namprd10.prod.outlook.com
 ([fe80::41fa:92d3:28b9:2a15%7]) with mapi id 15.20.8048.020; Wed, 16 Oct 2024
 00:49:57 +0000
Message-ID: <345a8c5e-1f7d-4d73-a3a0-7d0040e5d5a6@oracle.com>
Date: Tue, 15 Oct 2024 17:49:53 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 05/10] mm/mshare: Add ioctl support
To: Jann Horn <jannh@google.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, markhemm@googlemail.com,
        viro@zeniv.linux.org.uk, david@redhat.com, khalid@kernel.org,
        andreyknvl@gmail.com, dave.hansen@intel.com, luto@kernel.org,
        brauner@kernel.org, arnd@arndb.de, ebiederm@xmission.com,
        catalin.marinas@arm.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhiramat@kernel.org,
        rostedt@goodmis.org, vasily.averin@linux.dev, xhao@linux.alibaba.com,
        pcc@google.com, neilb@suse.de, maz@kernel.org
References: <20240903232241.43995-1-anthony.yznaga@oracle.com>
 <20240903232241.43995-6-anthony.yznaga@oracle.com>
 <CAG48ez0OOpw17d73wB_HC55FVLeKOz0D9+teEHe7YAsY_00=kw@mail.gmail.com>
Content-Language: en-US
From: Anthony Yznaga <anthony.yznaga@oracle.com>
In-Reply-To: <CAG48ez0OOpw17d73wB_HC55FVLeKOz0D9+teEHe7YAsY_00=kw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0248.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::13) To MW6PR10MB7660.namprd10.prod.outlook.com
 (2603:10b6:303:24b::12)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7660:EE_|PH7PR10MB6132:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e5ca66e-bf8c-44a1-f769-08dced7c74cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aUhuV1JLdzVQaHB2aVpJRWpEYUw0a3BlbXZsYlN5VkxLdjI5bGRnRXdYTDF5?=
 =?utf-8?B?bW9JWkNYVVZCc1ZpaWRMbzJQaVpWTHRpN0xQOS84eTQzdzVNc01ZVE12T2g4?=
 =?utf-8?B?WkF1Wm9aV3JjVmNGeXNONk05SjZTclZ4ZmY5OXRiempKY1d5bGxWdElZUDhV?=
 =?utf-8?B?bVd4VGlYWDFTdmcyS1N4RjVIK1FQWWU3ZnFlTXo0QnNNV3hROXd0ZytoWHc1?=
 =?utf-8?B?azdlRHNWTGZOWnUwZm1iOFpVQ0JFTktESkRZYTU0cjB6bW1PeG10dzVTM1Vx?=
 =?utf-8?B?NG1RZ1AxM1BiUU1weGNtUzM2U3JyM0FDU1g5NTkyUS8wYkpwWjZ2Myt2QzN1?=
 =?utf-8?B?d1BUQ0lvWE05ZFRqNmFOeDBSRm9ucEhxR0RpR0JQNFN2T0YvRmNxUS9Tc2o5?=
 =?utf-8?B?djd1Z3lud0RTeVRaMkJMNm9nTEFuQk00NzJCWFlkV1M2eEtoWVhBYnFtbjdy?=
 =?utf-8?B?MmZyaEQwUjE0YVJZN0QwVEkvUU8zN2EwaE1WSWdza1RmZHRpUS9Fc09ZZGR6?=
 =?utf-8?B?SzhHVDZOdTV4Smp5eDc5aEZUQ3JtU2g2RGdoam0vdVRkK3pYWGEyNVJIamNU?=
 =?utf-8?B?Y0FCRjFwVVgwRDQ2MFo2UWFqNzJlZ01MYzVRaHRtR1pQYi9UODF2U0hNZCtz?=
 =?utf-8?B?TTdzMGtsY3dZMDRnMXhPRXRpNzlJSnViQytTUTQxOTNCaCtKdjRpSExWWWUw?=
 =?utf-8?B?cWk1RHM1bHlGUTFtN0NpMDU5TDFwZXl2ZU9pOFhuQUh2cjl4Szc1UnF3T01s?=
 =?utf-8?B?Q1hncEJUUDNZK1QyLytNeDZVcExLTjE4cGNqZzRGNGxvVFI0UjcrejB2M3VJ?=
 =?utf-8?B?LytOaGpLR0M3M2tkdHpsbnl3WmdoQ1U0ak11VEl6UGhwN3cyWndxNVpIN0NE?=
 =?utf-8?B?K1J4U0M2TnVKRHRLNHB2d2tQK1h2dnhrbXFOZzM4SHFxeHdMZzNPUkR2UHZl?=
 =?utf-8?B?ZnBuQ3N3UHE5bTB5Z3UrdkFxNFJNbDUrcTZwc3ZEeS9YVTlLM0NRemFSRk1y?=
 =?utf-8?B?eGIwL1VZOXVtWHFSTndzWjFmbytMWjdXaDFaN0g2eGY0ZFM5cUtCYlUwNjhj?=
 =?utf-8?B?N3VsWURzUmFhRnhuMitxWWVKMDA0UHoxVEVvSTc1WUFuY0x0LzVBZTlrek82?=
 =?utf-8?B?Y29sdXpwTkxpRVgwdDJpREhKL1JYaDNKdDIyV1pXVkpwL082NlZob1crZERl?=
 =?utf-8?B?U2VPaHV3aFgzYmFvMEhxdGdXcTJSOVFvZ0xnTGhhREkwMzYyN3FOMjJWRFRh?=
 =?utf-8?B?M3ZYNVNiTmhuM2NQQjNXYVFaMldyTG1qNWlWNWU3cHI5Zzk1OGt5dVlEWU1X?=
 =?utf-8?B?WGhmaDlTemVPMGpsRzdETkN2U0RoUThXTUFodkNnMTNpS1dhZDRWK0t3eWZH?=
 =?utf-8?B?cjZUbjNsZjFaWE1VS2M0M0J0WGpnOFcydXNTL3FJckNqd3hQUGNFU0ZJSkhh?=
 =?utf-8?B?anI0c3BLaVNkcTdUSjFoUjZqU0U1QVhFNktaTE1sNzd6OFRnTnpKN3dNdE5j?=
 =?utf-8?B?RDcxMU9KSk50VGdJZTRlTlIxSEpwd0FQVnczQ3FYRWJnenJBUjliTmMvN2lV?=
 =?utf-8?B?NERyVjRMZk9OVlBKb1ErL090QVVxNWhqQzVka1dwSEpPUERVSjk1V3RjeVNK?=
 =?utf-8?B?T3VFWFBVZlcwQVFKZ3pSMENybi8xNzNrVkFnSllEZml4Q2NIYWNNVVh4ejdh?=
 =?utf-8?B?WFZwOE9NbFgxZnh2N1kxQkhtQUtJQ2J6WlpVS1BOOW9LeFBoeEFMWDFBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7660.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RHFxSEpibVEvTFdTSXVxcTJTQVdsUXhhbDE2ZEt1MSt1eFg5UHhFN1FjTVhE?=
 =?utf-8?B?TTh1UDJVQlF6Tk80Yzl3bGUxZllFRm0rVVlldno1ek51SThoeUV5TXFMZFN6?=
 =?utf-8?B?a3drYXcyV1p3UWdrcC9DNlczanV5T2NlT0xmdHpJc3dHa2Nqd3doUnFvYjg5?=
 =?utf-8?B?WGZpN2kvZjVYWWVpU2JWTlV2TncwU2h4MUVmVVRGT3RIeGIrbjljTnlYdGZ4?=
 =?utf-8?B?QmZtL0hqKy9yR2t1akhRK3BSM1UvNFhDcDBBZHppd2N5cHgvQVBHUHVmYUxJ?=
 =?utf-8?B?RzFqTVg4RllvWVpFTmVRM0ErZkQ4V3cydS90YldOMVoxTk8rbVhFZXg3R1U0?=
 =?utf-8?B?aTN4dC9ja05FeExTeXUwYVEzTnJzck1CZzJQOCtvYjlVZmxzYXhkLzl5WkNj?=
 =?utf-8?B?WFZDamRiUnFQR2ZaL2orWUs3YUtOQkFzemt4V3JoT2hFQ2hwQ1BROXBvZnRr?=
 =?utf-8?B?ZmRyM3hXWHdNRE8vN0xqcUNVOHpnWFZaQTJ4RWgxZmd0RnJlUzhXaXpjYjNJ?=
 =?utf-8?B?WjhncGg3SWFLSUxSczExdVNjeG9EVUt6a1g4blJGOWRzVDhhbEZhYi9rMmNN?=
 =?utf-8?B?QktVZk5mUlhZWksvczZvMkFVOUNrcldOZHhneUhjclJSWDFDa2xSZzFIZi9P?=
 =?utf-8?B?M2REbnFUNDBwWHh1dy9iTUVrekhwU3YyNUxCbERZZ1UwaVpZcThleWpIaGEw?=
 =?utf-8?B?Q0pOeUxRZ0Q1RkdqRTVhM2oxZm5HRUdsejZSekxnL1lZTGs1VGp3ODhDZzJF?=
 =?utf-8?B?dmplZ2FiNHQ2dExOamRhNnFMTnZvcXc2RlIwNjdWV210aFBYZm1ZOHloV2d0?=
 =?utf-8?B?ZkZwQXVoUW92YU9kbXhqR09GYVdDeFpkc21nZlljSUR6NmhQb2IwTFA0UHV0?=
 =?utf-8?B?bUdjTHU3emV4eVdRdU1xZnZNeTVvT2IwN09VV29QanF0RWtCQldSWG84Smpz?=
 =?utf-8?B?ajBNalpWT0VoYjJGS2d6aXRxN3lSV2pBY1RrSGdzRjZLNGtBQTVpandSSjJQ?=
 =?utf-8?B?Z0lwYk5ra3JUb2NqSlgvaUZNanBzUGRqbXdPTmRIbXRnM1A4QkxyeU9Ea3I3?=
 =?utf-8?B?VjlYSHYzQm5Pa1dYQ3pPbGUxRVVmbUxGMGZBSitoeFRQOHRGeWR6aE1yTGNj?=
 =?utf-8?B?TGovQld2WW9zUVREaDZJYzZRbUNxeXpCb3Q5NlR2ZHYvNUNjeXlWSThmOE5G?=
 =?utf-8?B?RDFtTmRmbHFJSHlZU3FwVkE0cGtHdE5oclVsSG9pUlg5cXRaYW5QMEJNb0xk?=
 =?utf-8?B?YWhuK2hGNXhlUDNTcTlja3AxK2psdUhIcjlEdG04TkZ5YndmVXRRK2tZbkNG?=
 =?utf-8?B?cU1OVlpqWEN1NERYRG05TVYxRzV2aFExR3RGNU1OSXZPVjBWa1hxc29tdDdn?=
 =?utf-8?B?Z2p5aGhEZkJyc3Nsb0hUY0duRzZaSkUzdDY3dVozQjRvays2RFEyRlRMUFJ0?=
 =?utf-8?B?V0grdEhCa2xVa1JRbjRCRHJ5VGVSZWNyUko3ZkpFZXNPdzk3eC9KUEtUeGhF?=
 =?utf-8?B?NlA1UlVTT29SckN1Znk0OHNzcmc5aXBBcllYblE1a3M3bTE2aUdleFFPOWMy?=
 =?utf-8?B?TklFNTlZM3BHekRjaW9ycGRqeFF0a0NDT0ZORnlwWXBXYjFmYmw5eGNlRU01?=
 =?utf-8?B?QkZXTkV5Q2Q1eWpiR3BGeWcvb3B5U2hiVldNZGRSM2hXTjlvNUtQTjZYQlo0?=
 =?utf-8?B?SVNMSmFXSmFrNUZjaHZheEtySGk4YmJzR29qMDhteGhrUTBMUEE1Ulk1L2d0?=
 =?utf-8?B?RENKaGYydkhzWTBDcVBMYUswYVdPVU1CRkp6ZHF4SThIYUh3RmxTeG1SbzlP?=
 =?utf-8?B?THYzYlRVa01PQ0l3RnZac3FNczg1NVZScEZlSHRlemRjRExYOStTcDBnWmxW?=
 =?utf-8?B?czFuZUIzeTA3V0xGNTIwRWQrb2NocHVzbkVLWW5UVklCbEdpNEIrY2QvTndB?=
 =?utf-8?B?bTQ2ZWNYSjNHazNlZ3hWQXhVRUhTalArOGtndHVxblBRR29Qa1laNzAySHk2?=
 =?utf-8?B?VGp5elR1NHFHRXhjb2YrRjA5RTVkN3o5SGttRHFSc3lScC9WdzIvT2xzZkV0?=
 =?utf-8?B?Tnh6TXBEWW5aWlV5SGdPNmU5c3RLOVpoRisrRmZtUzFGWWlZeW1xeUdLaHN4?=
 =?utf-8?B?Q0ZEZlV1Q2dpVElSbDFSc0htOHJqVTJuaWV6T0tUMFFaSEp4ckFnb1djRFBT?=
 =?utf-8?B?WlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7FS5te4kplJK+67smH9p3zyCWEXhws8jwAb8jKlddmvozZqBb+e0s7hzklpiQYe6phgPGY3CfK5WVKsd8KNWHzvk6Cgtq+m6uVACmP9WNjZgoZ7Ed6Zt8QQ+YTpdWTsLGj36PqKaXaSTKLfZaCckNaxJ/jwelxFcfBOkr3UM4QyB3cHHzBPohsf4DZ9JlIbalkUySr2qchQLtcx7kPLO4vrRu9bL4c0yD7+yYf9kzKSHTTWysg6d1MKZyc7OhjC6tyiAoy29ORdrFsZPOazqCRsvEjSP5gwrNJN27ekybTexVYWLZ0q1Wkv98SiFOGROED12n2zU9gVVnKg72kAU3O/CYXhQ79xtCAeGmfGS2o4G1pL/ZKaKo+998/WuOwYy0Av3NpqXftKYIWbjolt44hl2qwhh04FCH4zISTPA8vxdiTQuK013avSqrWaWrWEy4q5d2q48XDPw1u7adTQRVmrUbXiHdhwbl9XH5fl66IVa2PXJRLrKMTD3ZY/8mIW/jz/3PajyXHpR/ZbDDH2q5BWbxTM0zyzQZYN/rr6PztN3hQ3lIMqvio+UsusF4V+lq1pqx055g6qL+Q+XjE2qVMSFWHhhA8r2R09h/3/j6RE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e5ca66e-bf8c-44a1-f769-08dced7c74cc
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7660.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 00:49:57.2942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MRU6XaPgeQ1dYnsiVE9LHgSoT5ofT1tN7gbkJ1yOwZjxp1Xl1OcpqGghWhjfa4Wn8aoWombzvXxc+5qXSvCnJq+hg25+2jy41C0llKN97xs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6132
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_20,2024-10-15_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 phishscore=0
 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410160004
X-Proofpoint-ORIG-GUID: f9WjsTFt0NJ9UCI01d6VWUv-2r8Pi1b5
X-Proofpoint-GUID: f9WjsTFt0NJ9UCI01d6VWUv-2r8Pi1b5


On 10/14/24 1:08 PM, Jann Horn wrote:
> On Wed, Sep 4, 2024 at 1:22 AM Anthony Yznaga <anthony.yznaga@oracle.com> wrote:
>> Reserve a range of ioctls for msharefs and add the first two ioctls
>> to get and set the start address and size of an mshare region.
> [...]
>> +static long
>> +msharefs_set_size(struct mm_struct *mm, struct mshare_data *m_data,
>> +                       struct mshare_info *minfo)
>> +{
>> +       unsigned long end = minfo->start + minfo->size;
>> +
>> +       /*
>> +        * Validate alignment for start address, and size
>> +        */
>> +       if ((minfo->start | end) & (PGDIR_SIZE - 1)) {
>> +               spin_unlock(&m_data->m_lock);
>> +               return -EINVAL;
>> +       }
>> +
>> +       mm->mmap_base = minfo->start;
>> +       mm->task_size = minfo->size;
>> +       if (!mm->task_size)
>> +               mm->task_size--;
>> +
>> +       m_data->minfo.start = mm->mmap_base;
>> +       m_data->minfo.size = mm->task_size;
>> +       spin_unlock(&m_data->m_lock);
>> +
>> +       return 0;
>> +}
>> +
>> +static long
>> +msharefs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>> +{
>> +       struct mshare_data *m_data = filp->private_data;
>> +       struct mm_struct *mm = m_data->mm;
>> +       struct mshare_info minfo;
>> +
>> +       switch (cmd) {
>> +       case MSHAREFS_GET_SIZE:
>> +               spin_lock(&m_data->m_lock);
>> +               minfo = m_data->minfo;
>> +               spin_unlock(&m_data->m_lock);
>> +
>> +               if (copy_to_user((void __user *)arg, &minfo, sizeof(minfo)))
>> +                       return -EFAULT;
>> +
>> +               return 0;
>> +
>> +       case MSHAREFS_SET_SIZE:
>> +               if (copy_from_user(&minfo, (struct mshare_info __user *)arg,
>> +                       sizeof(minfo)))
>> +                       return -EFAULT;
>> +
>> +               /*
>> +                * If this mshare region has been set up once already, bail out
>> +                */
>> +               spin_lock(&m_data->m_lock);
>> +               if (m_data->minfo.start != 0) {
> Is there actually anything that prevents msharefs_set_size() from
> setting up m_data with ->minfo.start==0, so that a second
> MSHAREFS_SET_SIZE invocation will succeed? It would probably be more
> reliable to have a separate flag for "has this thing been set up yet".

Thanks for pointing this out. Yes, this is problematic. A start address 
of 0 generally won't work because mmap() will fail unless there are 
sufficient privileges (cap_map_addr will return -EPERM). I already have 
changes to use the size to indicate initialization, but it may make 
sense to have flags.


Anthony

>
>
>> +                       spin_unlock(&m_data->m_lock);
>> +                       return -EINVAL;
>> +               }
>> +
>> +               return msharefs_set_size(mm, m_data, &minfo);
>> +
>> +       default:
>> +               return -ENOTTY;
>> +       }
>> +}

