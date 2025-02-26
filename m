Return-Path: <linux-arch+bounces-10381-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D2AA46284
	for <lists+linux-arch@lfdr.de>; Wed, 26 Feb 2025 15:23:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 221317A5B66
	for <lists+linux-arch@lfdr.de>; Wed, 26 Feb 2025 14:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A68221F39;
	Wed, 26 Feb 2025 14:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="l5FasFcn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="D5j/kIj0"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C11221F26;
	Wed, 26 Feb 2025 14:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740579654; cv=fail; b=DFDTZ2j2EwGHAb4hZfmUzOuIcC6rGNvAsGOu4scVZgt7r/2EgSlL+kyCXZiI+mlxPwxoglQc7148sBTrbFcWwxRGsLtLsmj87ajJHYi4eA1cfWQoUskmMvKUH0NK9Lil2R1qAbPFhpPsRjpG9LwFmPcQpIpDvvxL8s1o07Qe9A8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740579654; c=relaxed/simple;
	bh=mlROIVJCKP/mYy2Yi92efUzhAwB7k7aYa2eg00VSIrU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qCl9KAEnfU+nM5ZuSl91xmIAuQ8scrj3J8DBFhoHjcJTkGevVZqQloS9OPhFEz/q8DlrDfQjBTahv1Zhd/PmIricqaauItNrm6lEilBVBX0I6l1g7Jzu01SxQI+r0RIk4R5Bi4G+vscSB1JeCJV6Onzac/Cp3LcsGqxnB2OIGng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=l5FasFcn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=D5j/kIj0; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51QDtYPh010296;
	Wed, 26 Feb 2025 14:20:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=5siWxhBLDRqhaPKAVt4ABwBSnxkiKXlL46WbmGS2xYc=; b=
	l5FasFcntN8KkKCGyNNlnNDyDWrdsJavWNBpW2en3IzU/Oqs+I3kWkrEL69lTgu+
	U7y+imgsQ/m75AIe3F9YmBLAaQy5/UFMPqIWtMgKFb57zWmfe/5UB1NR8izk21cX
	r29hHw7XjX9/mLAVDtuLN722f65SiUTGaCBsNEg76r1U0mGd+2Y/npqdYEq1eXls
	KzK+Yh+PMk4l7xSRXd1VOGMRTU0K7j4FdtCWHym9/fn/uG76tWHIwQ/j1kdpf+sy
	KehOy9Tp0hUncM4yx6cRCLUrPSaODNvu5Q3yhWeRTK0TDHkATyugResu3AWGY/ew
	ORWgh/Fiw9JB46NenEGoNA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 451pse96nc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Feb 2025 14:20:22 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51QChRe3012524;
	Wed, 26 Feb 2025 14:20:21 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2046.outbound.protection.outlook.com [104.47.55.46])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y51bywjh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Feb 2025 14:20:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DpDQ4T6tjNQiA/blwv2XAIbONBi4bw6zahApHsOZpEtaHsHzsDnZA3qWgLJ/8ITml0ZUqhElH11a1XIUk192cNJzQQdh63obupM0ILnwAnqCCaqbnIiqLXw4EM2X7XSSXFD2Rry8Z6+i6CM6fV3G1xwBq1kWd36ng3kakZfDxweza9uljprFzU7+OQFYEeBGgodUzBtfLsQjTKttT2v1x1pnKbWTCPwV4RHEmOSbXXjawF1DxENq5i8PsFVGlCoKIl86Tdx5biXNWbuins/6hYz8+jTdx34TEsQECdBHnFcyBbFEwGSY7WgDu6rGhG790neKMf/WPJh8lc2b5ldrbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5siWxhBLDRqhaPKAVt4ABwBSnxkiKXlL46WbmGS2xYc=;
 b=RUO57P6XiNHPKfkdn8Nw5MTAG03F7v8pPFL5b2NaAZRNxIH86LBNv6ck1W+Y4+oz2ZliaVhbF1UNqw7K/OrAZvdJwECp5grNmlRHi0Zjk87Lu3O8Rf+OlWYjkxOtPhG+DVHAQCOHqfKvCc+9BXNB5whk4MbBrW9ANxpLV3ZYmj36/zz8ChyxQWeGwxZJQZToQqfxowqmbVZmszhem0hLf3vXOLsDu083otojZY7Roi1jpHiENScoIMT4HrKn1YntX9WXDlZVd8DwoPlqKhmdluLvG9lyP065EAItVylCpoHFCXzVOx8xYbMfDK/SB2xkd1pKS9G01Ow2Ps5RgOJHlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5siWxhBLDRqhaPKAVt4ABwBSnxkiKXlL46WbmGS2xYc=;
 b=D5j/kIj0I02Iex8juMt7gfaqVU6CuqjwAwx0WTaMKciLMX/hFmel6QFaKYbJnk6ZPXg5Y/AYOtZEfUXRDqY/11oiyVxFcp6v5Sl2L++4up2BgXjPa1mE5c+vwlts0iwHaSD1FzaBsCETtsPtrsR2MTi6bffmkxx2PRt/pgs52pE=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by LV3PR10MB7724.namprd10.prod.outlook.com (2603:10b6:408:1b4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Wed, 26 Feb
 2025 14:20:17 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%4]) with mapi id 15.20.8489.018; Wed, 26 Feb 2025
 14:20:17 +0000
Message-ID: <6c89777a-65dc-44da-83cd-005cb6c82430@oracle.com>
Date: Wed, 26 Feb 2025 14:20:10 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] btf: Add the option to include global variable types
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>, Kees Cook <kees@kernel.org>,
        KP Singh <kpsingh@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
        Sami Tolvanen <samitolvanen@google.com>,
        Eduard Zingerman
 <eddyz87@gmail.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Stanislav Fomichev <sdf@fomichev.me>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Jann Horn <jannh@google.com>, Ard Biesheuvel <ardb@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>, Hao Luo <haoluo@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>, linux-debuggers@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>, Song Liu <song@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>
References: <20250207012045.2129841-1-stephen.s.brennan@oracle.com>
 <20250207012045.2129841-3-stephen.s.brennan@oracle.com>
 <CAADnVQLiyezBW34dhkwZw+mWmkFAYMZUdHbOa4uYCdPbgS10SQ@mail.gmail.com>
 <83a42276-22cc-4642-8ce6-7ef16fa93d9c@oracle.com>
 <CAEf4BzYvFnqeZjNy_b_VP9DEpBaTMWuMAau8j6ZAWtgwcE5ysg@mail.gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAEf4BzYvFnqeZjNy_b_VP9DEpBaTMWuMAau8j6ZAWtgwcE5ysg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DU2PR04CA0349.eurprd04.prod.outlook.com
 (2603:10a6:10:2b4::6) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|LV3PR10MB7724:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b4f1257-4c63-43eb-12da-08dd5670b1ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZnhyT1Z3UXZjWUhka2M2bXdJWkZXc1RYQkcrVVExWDhJNU8wdnFzUmZQeVdT?=
 =?utf-8?B?T1Z6TlBsVlZBQjhUb1FzZHhIdHpZQ09Pc0QzZXh2RW53RGc4VHNTQUk4U2dU?=
 =?utf-8?B?emkxbkd6UWYwWDBWOGZRQ0kram5XSm5VSXZXSXBULy9WRzhhYUh5VEtMajFH?=
 =?utf-8?B?UmVKVjNmdDVMMGJGbVNuZFd2T2U1QVRreHFwWXprNWNGTXkvY01qbXlqSGg5?=
 =?utf-8?B?L0krbWczV3Q0d3psSFBmQjFUYXNNOW9CTm9hZi9HN0dWeHB6YnU1b2lxMWRV?=
 =?utf-8?B?bDhNS3pjYjZFUko0ZlA3SVF2T1NBQTFkMGVaN0ZVMU5KaU9ES1lTMHdqU3ZU?=
 =?utf-8?B?K2ptdVlGZzFubFdTNG05OUZhbVJyTUlhVkJjbVh5OVBUY1lBSklpODBJRS80?=
 =?utf-8?B?L2krTndHek9kb2RwMkd0MnkrS1pRdUxqbWVjN2M3ZStZOVIrVW1TYXJQK29N?=
 =?utf-8?B?dWNBNVU2SXdkQ1FiL2FvQXBKZkRZNnRSNCt3OFd1aXFSbDF0U1d1elFiTlBL?=
 =?utf-8?B?TFEzYitOenlxb2RzcnF4aFRVYUVmZmtuOXpGVVZFR2hNMTBvbE5QU2loVjBl?=
 =?utf-8?B?UkhCS0pEa21WOVpnTWdFQ1pUU1hQYmQxMHBYb1ZxU3h0aHFZdHpONHh0cUkx?=
 =?utf-8?B?SUdNUHZ4aFI0YXdlSDRWOU5yaW1QWHJVbnI4NTBza0RDS013cHVtMFV4NjV4?=
 =?utf-8?B?M3NLSjg0MUkzTXVLbnRwTmczWnNlYzVMZHdxRlBYa25GVGFQdldLSTlGUVRi?=
 =?utf-8?B?bjgxRnQwT2MxbWVUOUV2VzZsem1wYzhnQlZzbFdVTHZSUzZ0R2dXelRLSW5q?=
 =?utf-8?B?N2Q5bVdUTVZTb1hETFFVUExwam1oSGw0SHJ4cVVlVXJjYm1Ec2h5d3JKdDg1?=
 =?utf-8?B?ZTYrU0YzUGIwaG9zSU5pQXJGRmRhaWduUFU1WnFvdWhpZUdiS0xzQkFaY2Nk?=
 =?utf-8?B?dll5RmM1cmRCVXJ6dDN6SnlsZ0QzdEh5RjViRkZiUG9DU1dIOFlEdkcvWWlo?=
 =?utf-8?B?Sm9zaFdCSmVuK0c5a0hxcmsrRUdsVkJKUGNlTVBzb2NscFUzVjZSVG9wb096?=
 =?utf-8?B?VFdGZXZXZkFXUGdaQW53N2d1ZFUrL1NERnNyTTh5WGM3Rkh5NnFNRDVOeThy?=
 =?utf-8?B?a3d6ekU5YXZGOXpLVmZCb2VaZnMvQi94WnhRQmV0cVI1TzhtNFgzTlc2SGEx?=
 =?utf-8?B?blN3YVJxMjVkbTdjeU96a2o3TXVPMi9QcEMxWEdYc2kzZHZpUzk2TGp3QjMw?=
 =?utf-8?B?NERpeUVGRUdPMWJFeGFJbGFVcG02bDZWZjlCV1FyTHpqVkpva1hFZVRqMDJD?=
 =?utf-8?B?T1FTckprZnpGQ2dqYmFhVzJRQU1kWU1oSENzL3djcDc4cEJrdlBBWXBXZ29X?=
 =?utf-8?B?MFZMekEwUVBDNjN5QWRQTE53VEQyVGZJRlNidk5qTThYcXZNVi9mTTBsTUFF?=
 =?utf-8?B?OEJ0dHMvZnhhQlc3Qk5ObmpBbUJ3OW5DcU10aWRHUnB6L3RUbXYraCtyNUlE?=
 =?utf-8?B?c21HSzFVV0NYL2p1NjhTbVFtNUs5SkRsU3RicUNHZlAzMUhlNytac3Ayek90?=
 =?utf-8?B?bTBlYTA3VmI5aUFvbDRkZFJmRXh1c2Z2azVlRWFaeTFKZ3FjaStUT0xLR2pw?=
 =?utf-8?B?aFlReGZHaERubDZiYWtGb254a0xWNHU5b3JCQlNxWVh3aWtSTDZXYkFzRWIr?=
 =?utf-8?B?RzZGc0d0VHZXMGpVeUt3K2NvU3AwUkt5UUZPUDltVml5U3R4VkUrQkhLbFdT?=
 =?utf-8?B?NVR3OE9KdDZ2dWhHQVRNbFJPdUVIV2c1QWZNN0R1NitVbjFWUnZBbWx5cEpT?=
 =?utf-8?B?T1pUY2R4elpKMThXWndISHR6RDErMnp5ZmVEdUZSQXlOdzBPR044RDlVSDJH?=
 =?utf-8?Q?CABlNYw7CoJik?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c082MTFncWQ1S0RLVlRJYTIvTXRoMWg0TGt0ZFZERFpIY255OHcyUGxmd3ht?=
 =?utf-8?B?bGxpekM1V1dDUGFweTZVUzREU25UZE1ZVHF4ZVJvVXpiN2tnRkdnMWxIazhW?=
 =?utf-8?B?eXVxOVZPTWIvcDN6Y3NDNURLdDRSTlV1QWdjRnorcTFTU1JacXZ2Z3ZuTkor?=
 =?utf-8?B?dVU5R3dmc3Q0Nk1lU00ya0RTaVQrNC9iMHJyT004WXFyRFl3SHc3UisvNE1w?=
 =?utf-8?B?REhVS0NJb1A4SllQQjQ3YW1yMjdlcjNUNnZBYi9sK3NaR1IrRE5xWmVBeU01?=
 =?utf-8?B?Mzd5M2JrYWZwL0NqWVpGR0Y1WXQ2eUhncDdvbXhZaEFrNmxSNDFjdEg3REFt?=
 =?utf-8?B?VkZHMDY3RTZiaUJYOTBnUXU4YUFwaFlDWWQwU2l6em5lNVBSaTJYYW0yanJl?=
 =?utf-8?B?T3hITWYwYmFpTXBvV2REdU9EcnpaSG5veld4MnVVVnVPckpBTjNtM1JjT1hY?=
 =?utf-8?B?WkZHYkc1SjZQMktrU1RoSzNva213L3I5Z3VtZUp1bHRFbmo4TGNJMDJiSEpm?=
 =?utf-8?B?SVNVaGNZRU8zaFNPWHdQS3Z0bHZKam9qRG9obG5TUTFnbjNVTmFRV1dsWXJX?=
 =?utf-8?B?b3BKQUprR3BqOFRabGtJVUcyYk1udEdxclY2L2V0VXZaSUhKcUFGMTRvc2dR?=
 =?utf-8?B?UERYbktvbWV4ZGkrNWVRemxwNkhObXVmcnVkaXh1WUp3dHFEMlFST0o3MVJi?=
 =?utf-8?B?aVdoa05vanNTWENSclA1QVRwamJpNkxkVm9kRTJ0OHNha3A1b2VOa2hoVDN3?=
 =?utf-8?B?Y3FkLzgxdlVqUVBtQ2dSVFllWkZodGNMa0kzUzUzNnA0cVEvY3RiMGY5M3FR?=
 =?utf-8?B?akZFMHFWWm5pRDlqei9RQzF4Uzd3OFpRaUxLVFFZOXc2aGJkR3hnODhZZW05?=
 =?utf-8?B?Sm1PcHgxSWlzUEpUZ3dPRzVReFpSVi9mSGQ0U1p5S1dqN0c1d3hlcU5KNG14?=
 =?utf-8?B?aHRneGd0VXdIQjRBY29PbFNwUVF4Vkp6MHNGSEcwK0NkTmdJc1FlanBBMzhx?=
 =?utf-8?B?YWpEOVJpQnlLbVdqNmV3R0pYTVI3RnBHQ0I1dlV1NE1QdUpTaWY0U002bUlv?=
 =?utf-8?B?MG5HLy9UTVhnZ1F2SFRuOStITFFGckVpc1h6UngyaS9SUWNYWldZMG9YVC9i?=
 =?utf-8?B?YndVT2FRL3BxeXAwUytaNWFWdXVxSHA0Yi9uZUJ1NjQrNWxrVDNVWUgreURo?=
 =?utf-8?B?bkYvNU5SUjBuWGRQeEFUcEx3UHVYYkI5UzBPQ2dRSkgzZjZiRUhYVFZXUjZt?=
 =?utf-8?B?R2NGL1BrVmdJaXVHc2NBZkNCSmw1c3ZlYzgwYW5QNi9SemhCR2RIZytZQ1oy?=
 =?utf-8?B?N2g2S3ZKeUJTeW11Y0lXaTNkT1VuYUd3Z0Y5dTNWWERmeXdCNldJWnF3bGRj?=
 =?utf-8?B?b2hjY3hBY09FYTBsOXptWnRHb0V6cklzYXM1TUN3NEUwaGJlS1BHVnk4MXg4?=
 =?utf-8?B?ckpuQy9Bbk9KVW0rTFhQQThlWVI1UCtuODFDK3ljbFhGOXVHbnhXbGoyYlV2?=
 =?utf-8?B?SC9ENFltOU9ONEQ3SFRBT2pJVkk1MmRLSWFGbVFzaExtbEV1ZmoremN2T2Js?=
 =?utf-8?B?d1Z1OTZCUm8zd09uZGNBazV4b1Nlck9nRTk2ZHJmdStjMGwraXZPL2ZNS3lR?=
 =?utf-8?B?Q2VNVmhsTXR1UGpCcW5Gb3BHalBuS0JpUWFuZlVhS3ZiZFJiK1JSMWJSUE9F?=
 =?utf-8?B?R1RYS2FTdHFvUDRmUDlpS3pOdUZaNWxwWmZxbTlxcFRzZkk5TkpYb2dQWFg0?=
 =?utf-8?B?Y0dmc2FucXB5QlpqeGtVck1jSnBxTVdxVnltQWlVZWpZV0w1NU54Q0hSZVB2?=
 =?utf-8?B?eThCZkVYaWFYcHZUVWl1U3FQSFdEYVRUb1ZXMmhzTVFEajNmUkxVRlhjQWl4?=
 =?utf-8?B?QURWd3U1MnRxL0dlNFVrOFFCYlpZMCtpcDVzZjRIOWVIeU1PYTdia1BJVVRw?=
 =?utf-8?B?VXhRUmlRYVlVdlhoalZBRlJ4a3pQR1VWbmVOVXVsZENMa0xEaElMWnBxWG4v?=
 =?utf-8?B?OER0V2FwaTdyMytKUk1CUnI2NVREaXg1cHBxcjRMdDN4Y1VmOWFyY2JLaXNJ?=
 =?utf-8?B?L0h4TVI1MUQ1QjIyVUt1Qm5HaUZlNmkrNktiYmlFczc0NWFNbUxJeTc2TWZH?=
 =?utf-8?B?ZEpxeGNXMHhaNy90OFphcjdIWjB6ODNaZzlNWmZRVkxPaEREWmcycHkyM21R?=
 =?utf-8?B?RFIrQUwzN1lTK2RvT0Y1dEVoUktuMzRjbnZDSmhqVFlKa2Y4Q2NDTEhYaktB?=
 =?utf-8?B?MVViNnEydnNmZXRjOFd0NnNzSUNBPT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5MQVdq8bhUG9sQpuudexD1OJuG1x5ghOALopP3Yp1eLepJYkQxz/Ay32NzFSqwr2XMYC15XtsA4DCCoPJAjxBzMXlA+WBOQJ0j/hAcY0k//UVk2pY5z0gOx9KQQ80i6GUow8ktQ7EH1opB8oiuYZSO/qHDamqNVCrJcYwHeBl+8nR2p2qbF7zIyp5p9iGWVSSaRI1yWR8oDYV3CSG8KZWY7Ji3kXbLDOpTwJfICwEsWahL6y11xB+fylUAlLuRPmq+5jT43Nfbjokb4C+81IipX1DdRzHwtiEyGcXmTmsdgdWq99y4KsSZvyX+0Bc7NEi0OixP9MjfUDPZapkMYg0Rf0tfDOnDcEFzb5v89uBu7U5Il2xJJlDC+yqpHykBpWu0AjtQ+k6DO2bXQ/VVF9EZLPXkqQefAOtCBddyNvGQ0dJk78FOXBeQEPptviRC8zQVcatl7ToJK8Zd8XyRQenxeGT6dufxHMJ7LXUPinnm+3+DVIHkxJdc0X3LMhwoBCmGcKox+/F65YZvGmcuTSSVfaNGhUoE3IP87/4tPXfTQcL5jLDz68JrsLbIUNbLQ5mZ+pnR3KD98rc9EMAskwSiUEjNXYLwlGo8A9MX/QThM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b4f1257-4c63-43eb-12da-08dd5670b1ad
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 14:20:17.5997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6AwnqNS0gX7yJMnGsl+HPpNivTsTAXEvJGnAuu8CpOSFjLfkg87ArQb0wdH3cHpOmeJ4nDect++8bbFShN2RgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7724
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-26_03,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 mlxscore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502260114
X-Proofpoint-GUID: MMO0--xys9lKwwTeM43LBEJWHW9QeT9U
X-Proofpoint-ORIG-GUID: MMO0--xys9lKwwTeM43LBEJWHW9QeT9U

On 25/02/2025 21:52, Andrii Nakryiko wrote:
> On Tue, Feb 25, 2025 at 2:02 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>
>> On 07/02/2025 23:50, Alexei Starovoitov wrote:
>>> On Thu, Feb 6, 2025 at 5:21 PM Stephen Brennan
>>> <stephen.s.brennan@oracle.com> wrote:
>>>> When the feature was implemented in pahole, my measurements indicated
>>>> that vmlinux BTF size increased by about 25.8%, and module BTF size
>>>> increased by 53.2%. Due to these increases, the feature is implemented
>>>> behind a new config option, allowing users sensitive to increased memory
>>>> usage to disable it.
>>>>
>>>
>>> ...
>>>> +config DEBUG_INFO_BTF_GLOBAL_VARS
>>>> +       bool "Generate BTF type information for all global variables"
>>>> +       default y
>>>> +       depends on DEBUG_INFO_BTF && PAHOLE_VERSION >= 128
>>>> +       help
>>>> +         Include type information for all global variables in the BTF. This
>>>> +         increases the size of the BTF information, which increases memory
>>>> +         usage at runtime. With global variable types available, runtime
>>>> +         debugging and tracers may be able to provide more detail.
>>>
>>> This is not a solution.
>>> Even if it's changed to 'default n' distros will enable it
>>> like they enable everything and will suffer a regression.
>>>
>>> We need to add a new module like vmlinux_btf.ko that will contain
>>> this additional BTF data. For global vars and everything else we might need.
>>>
>>
>> In this area, I've been exploring adding support for
>> CONFIG_DEBUG_INFO_BTF=m , so that the BTF info for vmlinux is delivered
>> via a module. From the consumer side, everything looks identical
>> (/sys/kernel/btf/vmlinux is there etc), it is just that the .BTF section
>> is delivered via btf_vmlinux.ko instead. The original need for this was
>> that embedded folks noted that because in the current situation BTF data
>> is in vmlinux, they cannot enable BTF because such small-footprint
>> systems do not support a large vmlinux binary. However they could
>> potentially use kernel BTF if it was delivered via a module. The other
>> nice thing about module delivery in the general case is we can make use
>> of module compression. In experiments I see a 5.8Mb vmlinux BTF reduce
>> to a 1.8Mb btf_vmlinux.ko.gz module on-disk.
>>
>> The challenge in delivering vmlinux BTF in a module is that on module
>> load during boot other modules expect vmlinux BTF to be there when
>> adding their own BTF to /sys/kernel/btf. And kfunc registration from
>> kernel and modules expects this also. So support for deferred BTF module
>> load/kfunc registration is required too. I've implemented the former and
>> now am working on the latter. Hope to have some RFC patches ready soon,
>> but it looks feasible at this point.
> 
> Lazy btf_vmlinux.ko loading when BTF is actually needed (i.e., when
> user reads /sys/kernel/btf/vmlinux for the first time; or when BPF
> program is validated and needs kernel BTF) would be great. Curious too
> see how all that fits together!
> 
>>
>> Assuming such an option was available to small-footprint systems, should
>> we consider adding global variables to core vmlinux BTF along with
>> per-cpu variables? Then vmlinux BTF extras could be used for some of the
>> additional optional representations like function site-specific data
>> (inlines etc)? Or are there other factors other than on-disk footprint
>> that we need to consider? Thanks!
> 
> I'd keep BTF for variables separate from "core" vmlinux BTF. We can
> have /sys/kernel/btf/vmlinux.vars, which would depend on
> /sys/kernel/btf/vmlinux as a base BTF. Separately, we could eventually
> have /sys/kernel/btf/vmlinux.inlines which would also have
> /sys/kernel/btf/vmlinux as base BTF. If no one needs vmlinux.vars on
> the system, we won't need to waste memory on it. Seems more modular
> and extensible.
>

Sounds good. So thinking about how this fits with
CONFIG_DEBUG_INFO_BTF=m, perhaps the approach would be to use
btf_vmlinux.ko for all such extensible /sys/kernel/btf/vmlinux.vars,
vmlinux.inlines etc. Each of these is derived from .BTF.vars ,
.BTF.inlines sections in btf_vmlinux.ko. These are optionally included
via CONFIG_DEBUG_INFO_BTF_EXTRAS list. If CONFIG_DEBUG_INFO_BTF=y the
core vmlinux section stays in vmlinux itself and the extras are
delivered via btf_vmlinux.ko, but if CONFIG_DEBUG_INFO_BTF=m, the
vmlinux .BTF section is delivered in btf_vmlinux.ko too.

If this makes sense, I'll try and put together the
CONFIG_DEBUG_INFO_BTF=m support first, and that will give us a
btf_vmlinux.ko to work with for delivery of extras. Thanks!

Alan

>>
>> Alan
>>
>>> pw-bot: cr
>>>
>>


