Return-Path: <linux-arch+bounces-10357-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34CEBA43AFE
	for <lists+linux-arch@lfdr.de>; Tue, 25 Feb 2025 11:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C73691665FF
	for <lists+linux-arch@lfdr.de>; Tue, 25 Feb 2025 10:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B6A2676FD;
	Tue, 25 Feb 2025 10:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lNW8mNDd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="R4RE4O32"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAC62676CF;
	Tue, 25 Feb 2025 10:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740477739; cv=fail; b=Mf+GkpIy1TJJBtLLED5irsKVEI7fIUfDAIyboVpNjqrCNbNisTMS90A7K7NaPYsO2hN1VtHMBbT4HKFIUywsI6snrGb2vXEXf3lX9pXCBsj9hotreHgmxM6LYhpO8K8x6QHO/x90UUzzB379QAFuYLB2gu6KhnxT/9oF/OFQoGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740477739; c=relaxed/simple;
	bh=0KKyOuaLBJW9DMOsRLfHcp0WFV5YS53cQijQxFWnx8o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gCYnTRzTHfxflVxqlD1h+4qKEpCIxMi0NE4WcuKkuZk3NXZsWQtOns9tccCobxETh40l5+bSdd03+r/kbq82IYW6U6Lc7wwa3BFzOjs5bO3cK32C3t7I61e0exNpsrT2zFR6MxSboJJM1M9X/1zY8arkszCb9Cnm8iZxcWBbh9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lNW8mNDd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=R4RE4O32; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51P9feAG021521;
	Tue, 25 Feb 2025 10:01:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=bJGCEeAO2FVp1vgNXeYLzPMedvN+v9VZWZy8UEYJoRI=; b=
	lNW8mNDdgFQEX2C74pUvRhfJi3HX4EIYKFosVNOHt9KOSNMJHifcnmy6C16A8cMP
	EnsFQ26bebPI8uJ9/z60eyB1jduSS+uWKeWQdlZ4rbdS8oXkbqDtv33r+QK21kSk
	V+9N0yncjvYsNdInOYhbmTKfposqPaFIY/N2RliQpyVuPLs8xjU6wnN09GLArNCF
	poLQ3shGxdBLlOk0PiJj9o0essk0HkSD4Fbtp2w2RbH28b60FHMZPWnJBCL7KL4B
	n5rj4PtIi697aycyeolj6Q3keYo3zi0SzWqPDheHLVE6cziZZt0Jro6K/IMoH/jf
	5/dhHww38ldL9qhryySo5w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y5604qhe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 10:01:45 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51P8tHV4025437;
	Tue, 25 Feb 2025 10:01:43 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2043.outbound.protection.outlook.com [104.47.55.43])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44y51ffcau-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 10:01:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n8ZR+7wPrWxxhMjThjF10XV173tdl2rDRfdF8SSfSTcp2aeCb/cK9xFBjE+MNZTNUO/5bQ4/iwoCNZeamnfGw7O6/7qhNstSYObeTJsLsDZBRepMm8JYZ8Ase38Ul1GOjeANwnOnWMwW+fGJFKnVK8Tq8B9JEDR5WnO2yRxhO9IJpmunrWfV+4lQfQbfGf8jECsj+ICSvQ5pqRbVn/6ZuyeDggZqVFwWGj07tJCJmaI+tg1wjKObPiI2VTDxLAo4d+qs8yn+LYqzL4m6MI4wFoGNTfud6EdTcYi0yjwzVBMSuRimhu/OliPPzvogfTcvVnPXCKdc2XWnhmbNsbD6pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bJGCEeAO2FVp1vgNXeYLzPMedvN+v9VZWZy8UEYJoRI=;
 b=fBvGIq7wMzJwWW5y1U1YwfaM6XU1UoM0wSXgw1QmiZ3ZF3aUrl7hopC869A00NOYDLmItZF3m0KXqO9KF3vzhgrx1ALtbXgNuA3FdFDv31+EG4trc3MCS7O6loYj3S7BPcb92uGIcs1FT5RCTxLDxYf+kf1zhkLaCYaxTs9JCeI+IBW4Xt2eYG3weFofmkEF0lybNDrMuXEWdf/2n1oXUdPH0r9fNtFwjuw/Gbw3qji6cJvDhbcmoA+URrwthyX10uzyrPwBB4l/X3Lgy37rgf08dyPoi9z9odOY/3AJhCzmQLOxx0F7pWDGWHKjNfIqESKkvC3nWgB/6OButaGAKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bJGCEeAO2FVp1vgNXeYLzPMedvN+v9VZWZy8UEYJoRI=;
 b=R4RE4O32645Gb1g6B43/EFAVDB+NQuRVFN6MJV/VcXl23uU5UjsBBGn/zeTS5ZzDhwAORezQW7sMWUMSIi9OXssu+2hkg8Dq+BGmo+OWtIVYG5DSIednXS2n+HSIsIfX5VbLj4hRTqL+7HAAztxFE6GmKDXVcNPyEXKWmuJEtAo=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by SA2PR10MB4508.namprd10.prod.outlook.com (2603:10b6:806:11d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Tue, 25 Feb
 2025 10:01:34 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%4]) with mapi id 15.20.8466.020; Tue, 25 Feb 2025
 10:01:34 +0000
Message-ID: <83a42276-22cc-4642-8ce6-7ef16fa93d9c@oracle.com>
Date: Tue, 25 Feb 2025 10:01:27 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] btf: Add the option to include global variable types
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Stephen Brennan <stephen.s.brennan@oracle.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>,
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
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAADnVQLiyezBW34dhkwZw+mWmkFAYMZUdHbOa4uYCdPbgS10SQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DB8PR03CA0002.eurprd03.prod.outlook.com
 (2603:10a6:10:be::15) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|SA2PR10MB4508:EE_
X-MS-Office365-Filtering-Correlation-Id: 482aa051-8a35-47f9-6bb0-08dd5583629e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?STM2RmFUNmdYTWxCQ3JZM2Z1dDA0Y0FkcWpDcVhLUXY3KzNScFl5VlNBeity?=
 =?utf-8?B?Zkh0SDhXSGNMNk1XRWV2TThzd3JxelZCb2JLOW5pRVBMbmIzRXNvVW9sVTYy?=
 =?utf-8?B?N2lLNGpDYUVpZkVQa0VpcHEvR3JLRklBVURIeUpDaGxwNXRUSUFsVXJHOW5R?=
 =?utf-8?B?cDEyNkJIcnYwQXE0NXA0K1dXQzBjWFdGRUJKaHFDZy80V3c4ZEMrK3Z4Zkkr?=
 =?utf-8?B?SEZOZ0NZSGVOeFU3c1VjU29mYzhEK25INEtVblVqWHZQZC85V3NFWHlDWWwz?=
 =?utf-8?B?UDhoblowbWFJak81WXBzbFRWM09xSFMrRmJ0USt0K1dBeWtBSlI1YVVoSGds?=
 =?utf-8?B?TFhBLzFka1l3eDh0a3FSMjQyT1o1VjZXZGRSRFhTNnptZlFwMXhpWDlNTWtJ?=
 =?utf-8?B?ZWdnZzRzaWNkeG91VDlBMlQ2OVdRZUorZ0J0bWJnMnRCdXVyS2FYQnRKRDQx?=
 =?utf-8?B?b2wxcFhGcCt1TG80M0tMOExsVEg1aXdpdEpmaGNueFZ4cVFMKytCUFg5YmJK?=
 =?utf-8?B?T0pjMWVZdHhKTmhBZ29JTlBuclFLOVMvQ3JnNHV3Wld1Vmw3UGFxMlhqRGpZ?=
 =?utf-8?B?ZGFsa1pDdFZnR3JDZmE3akViQ3djVG42MUhvNkt6TWY2UjhJVXdqWXU3d3ph?=
 =?utf-8?B?QWJaMElZd1QvQndRZnZsZk94L241RFg5Z3M4YS9zZWZydXBybWZOcnJ4SDdl?=
 =?utf-8?B?ZjhPR0RCS1M5cVliaVAvTjVxdTExaTM2RlVqRWZ2bStORW5ZVmNHcEtma1VD?=
 =?utf-8?B?VVd5cTNSdkQvcWlQb3MxOVlNZDE4QzFHWHNYekVnaW9GNEJEVFhuSWI5Ymtu?=
 =?utf-8?B?QXpQUlcrcTN5VXJiakJpTzErTmhOeEptcE1MUG8xa2J0NWY2ZVowUitpRDQv?=
 =?utf-8?B?bG4rWGJOQjd6akxJOGg0SWhaQlJYdWl6bTVYVVBwRUd1azFSRWVTVUZBaW5C?=
 =?utf-8?B?SlJzaWZMUmkvelFjazRsTzlrS084S3hxelgzWjZ3amdwbXIrMllCVTFVVlNP?=
 =?utf-8?B?RmUvb09GV3ZNUSsvNTNtQW1BLzFRTisxbXo2WWNmd2lDV2l3eWFzMVVLcnJ0?=
 =?utf-8?B?d0NaMWdXREVySWx1aUxwYnpnT2psUEJlSzY5bzBkNzhud29VQVJGcGpMaXVh?=
 =?utf-8?B?aUZZUk9ZaFRrZFU2bnpuL0syUzFORHIrVE1BVDV4R3NoTUU3UW95QTdKNllx?=
 =?utf-8?B?ZUYrUmNHOWIxL25hTnhIRTEzRko3c291Y0JTOSsxajduVzJ2VjVCOVN5amxH?=
 =?utf-8?B?dm9OMElIV2VZTXJ1ck5CekIybUZEZmJmN1loUTIraEdvcVRDd1A0RS9qZmtL?=
 =?utf-8?B?dnNNWEhvTmtQeW1ZUUJGd3d4RmhsaVMrdHFpNUF2aHF3bnp3ajloVjBPN2NR?=
 =?utf-8?B?anZHT0pucGZBWU9ROE4rYTk1U2E3NDlKQzVtYnkrZGtpcXJ5K2JPdGtHVjdq?=
 =?utf-8?B?N1oxSzRSSW5pWHpxSVFMZHh5Sk4yYWNFV1lwcG5IRlhlWkZnWGg4NnhKZzkv?=
 =?utf-8?B?S3loQlZ1SUhJdmwwRTRYMWU2NCt4bGlPSWhDVEY4OVBtTmV6WVh6YjYrUFlk?=
 =?utf-8?B?NklQbTRmc1pONVhOTm1vakFZNnk5eVZCeUFnOGZjZk9rbkFVRGdFcXY4aGp2?=
 =?utf-8?B?QU01Q0t3WExGbHRGY0hrMFgvWTRDY3dVUWZmTFp0SG1KVXVnZXhFQlg2cklv?=
 =?utf-8?B?TWlYMlZxY2wyK3VOQnY0cVAvWXhiTm4rOVhHT1N0Zm9yNVNDdTYxSUZzVG01?=
 =?utf-8?B?cjgwSjRLL2c3S3JrREZadFNxd0hmYzkzcXZsb080NWsyQzQ3L0pHVXJ1QVp0?=
 =?utf-8?B?SHAxdGk3RWNCNlFxVnVBQ1BJbzNOc0wxMUxadXRvem5Kc0dxcVZyU0RNUnF2?=
 =?utf-8?Q?LFb5+z6QdbLWr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c2FDY0dXTlQ1c0hBemxkV3Jab0hHbHd6ZEV1RTBwRTAvTmFuMnhES2h1aEFy?=
 =?utf-8?B?MnExdngzRXZnUlB4SWhsUXR3aWI5QUt3TWdjRTUwNzZmVHVFUzBKblh4N3FI?=
 =?utf-8?B?bkl3ZUp6akxDNVB0YWtvYXdLMEhiRzcrK0M2L2twZnFwcjJBWDlVN3d4OTdK?=
 =?utf-8?B?TUtkakxEWDFTKy91Sndsbys5VG9BWHdQQXkzbmJZL2RaeTJvakRKcGdaNlJ3?=
 =?utf-8?B?bGI3SzRENWlOZW5TZHZCVDhIV0hnWWd1OWQweGs4RVZYQUZOOU1WSnFmYjFB?=
 =?utf-8?B?OExEN0dFT1JJaTdwM1M1S1QySktxN2swTjZranFyZGl4T0M2RzR3QXBNM21o?=
 =?utf-8?B?bHg4MGFYZm15dHdnRDV6aE51MGFOTE9zWVRvL3d1c01GY3l6WUkvTGVGck52?=
 =?utf-8?B?bE81Y2V1SW9YMThjWU1vTzNiSDdwR2pzMHhyOTJacGpOMXU3SGpEOE85M3Bv?=
 =?utf-8?B?dGNDVi9CNldaRWxsZ1I4L1l3SHp6YVp5endQa3VDaHVFc2RiZTlaeWdKRXl6?=
 =?utf-8?B?K3FPMXEwZDZPaUVJbEFxZE9hZnZLanYwNnlndjRBM3dBSTdRb0tkTU1ZN2kv?=
 =?utf-8?B?SFlvaEdRSEd1R1NKd1VTZDBZU1dzbGZmbDdRKy8zNTlWMVhlc3ozZmM0RlJo?=
 =?utf-8?B?d0hDdEVmRWIrS1kyRmV3VmsxSkJrNk9CTTVwR0JXcEFjQUM4SHpPSi9mVStN?=
 =?utf-8?B?RDIrZ29acC85MTdwTm1HUU5KcXRncVJkbGdBcXI0cWh1ODdVbHZ6T2ZqTXhx?=
 =?utf-8?B?VWYzc1I0eEFNa21vb3pQSVZReUFzcmlSM09qOWN3WW9CNVdrWU1OTjVYU0k2?=
 =?utf-8?B?ZkJNNHJkRTVpdll5Rkg3cGtQM043NXNGUHdKNWxTL2d4ZDR6Yk9KWG5LNENP?=
 =?utf-8?B?ZVNaM05GNC8zaEdWSzZhSFN2Q1hDTDh0M1JuMXVsTjB2NmEvSEVJMkE5RW4x?=
 =?utf-8?B?ZXk1azdOWHhGWDZ0czlEZkVLdFh5dUoza1dEMVlxTFltWlBBS3hPMFdrQTkz?=
 =?utf-8?B?VGpLT1Y4eElHSmlwZUlveUZUa28rZzAyMldGRFI1ZHlwWkdjdVdYMStXMFQ2?=
 =?utf-8?B?NnRENjBxbitDdVAwZk9mL053bDc4bUMzdFRLcmxXcHZwb1VyakR4WnFHbTUx?=
 =?utf-8?B?MGtlM2RLUWdmNUFPVjRJQStXbmwyaDUzbi9Md3hCQlV6U0hMa3RqMnpmYkpO?=
 =?utf-8?B?MVhFVTJVZ0hZMno3V2FhVUs5MTlDQk9sTFR1NC9QUlIxWWhPUkJXU2tQZXA1?=
 =?utf-8?B?djNqWFpFYmJ3M3FRbnB1ZEFlWXNRWC9VWkFVL2krSVUzZDM4MkxXbndWNkI4?=
 =?utf-8?B?aU52NmkxOElxMjc1MDBJajg0OVpuRk1sbllUUUpOVi9XbjRmWTluWGVWbnBY?=
 =?utf-8?B?SzlwS2NpQTFGeGdsNEtoSC9PWUZNUS9MNlJkQ3NWNFBteE15L1lLZnhaakpW?=
 =?utf-8?B?eWovVEVQK0xML2xIeW0yWWprQ3duU3AwK05nQ1BDeXc5ejIwTXVQbEg0WkJB?=
 =?utf-8?B?TzhPd3JKMkFpRC9HRWlkd0kvMXRpZEZ1UVlqMmw0OWU3dnJSMzhXMnBiRjdx?=
 =?utf-8?B?aTl4emlNK2wwLzhSMGlzYlBxUkxBRStQU2hWWERFV0pkc3pheXBhZVE5SGND?=
 =?utf-8?B?KzNSOFpOWGxPQ2cza2Q0VnFVbndxaUlnOXY2aUNhVmZhRWdmREF3Sm5XR1Ft?=
 =?utf-8?B?M1FWYU9QdjE2MHNwR1RkVUo3NHZURFZnc3Z0Wm00V3NNR1d4V1FvZWlScHlG?=
 =?utf-8?B?YzBFUERXWnIreHF1SnpDRndvUFJYTHdvc01xaUM5UTlxelljWm4zdjErSW04?=
 =?utf-8?B?Q28xR2todEw0MGZ4b3dsZU5tZmRKVkxxTVBlcS9FdnhSNm9ES2xEUDFoL2Vn?=
 =?utf-8?B?SmNXaWd4VWpRMU94eWg3eUtlNHZ4S1NONlJQOU1oK1d5L2k5UEhxejhqVWE4?=
 =?utf-8?B?aHBrcjFTRllGQ1kxV3pCall0YUErZzQreXA2RHNVL29FMTFCM2VvZ3VaWW5W?=
 =?utf-8?B?c3ordUUrR29YMkNOclc0cGllZEh3dGtsbEJvMS9kQVNVNkxMdk1zZjA1aEpp?=
 =?utf-8?B?MTUwbDl6T0l0SlVRZVpHTXcwVFZveEhreW41bEpRRnNQMWNTWEhpQ3RLWFFJ?=
 =?utf-8?B?anRaMFVYKzRzcVZQaW5aQlJOU3lRRzN6RUdiWTM0RlVzUVBwN1dZcUJMTTZr?=
 =?utf-8?B?TUNEdVJBUWI0UldxRUdrZ2lxTTBCUXIyZkxIVlA5R1pXQ2ozT3RQQU1pak4w?=
 =?utf-8?B?Smk3RTB4UlBDMTlYUFJPTGJOOTlRPT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xULt7XqtYYQEoIXhbGlXl9UiSb1gbJKw3BlF13z2OFKthoy/pVFITsRvOgK74AM2vJ8OuJS2ZlgiucxwaBzljWaB7YDPhVO8rGiA5UsX1/LwmOECTvYw8qUdv/PiOth+Ngxf7PnewoikCZqf9enX2Ns9VAloG5TpTQupsdkoL4i/hoZKAbXRIXyZB/CQBOGE2i2nKlBTIBqGJUew2hPey+TxiFg6v+OQw/JEwjFo3ljVOL0RHqHB4gxY6BAdVTUucT9yOQrX/0vDbcIz996KViPyATymJgDAvHglHb63MBBCqIwkqy1kwTRiKZkqHjjm/yKOU2P/3AYRy7wL0m2Mf9B5htsBNVOj5wWykrQKvrBIN0hNFQfkjWqy5WhuzwQYx+WwEJzTOn839jk+pQ7clk4FS19Ni1WbBdJQAvIZE2BAAOxaGrwoIjGCFQcJbhdkZFt0Ft1g6prqVX4Ats74DPgyKQ5GAJublrLV57NHmq4wnPRFsIFxrHmjkGP05uEzkZPstldQ/ydwpmfI6Yc17lrPPZRX+F92jS/QBGeUWLr+fwaitB1L5/Hx5QvogWa6ZKvNQVfjODEmVvxkwPlLG8ziBdQ8PtKOEf5iv+miITo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 482aa051-8a35-47f9-6bb0-08dd5583629e
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 10:01:34.1768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: owBH4r0GcnwKPtOFMLLlCpd6omJwajyFfbOH/NVPONFVQVOVehdYY4UptdNE6gChGllXhKLRWB0QLz4m2Kgh8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4508
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_03,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 suspectscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502250069
X-Proofpoint-GUID: yRZSTH03XAbV0KbDtyIxXQ4NhUnBBkfY
X-Proofpoint-ORIG-GUID: yRZSTH03XAbV0KbDtyIxXQ4NhUnBBkfY

On 07/02/2025 23:50, Alexei Starovoitov wrote:
> On Thu, Feb 6, 2025 at 5:21 PM Stephen Brennan
> <stephen.s.brennan@oracle.com> wrote:
>> When the feature was implemented in pahole, my measurements indicated
>> that vmlinux BTF size increased by about 25.8%, and module BTF size
>> increased by 53.2%. Due to these increases, the feature is implemented
>> behind a new config option, allowing users sensitive to increased memory
>> usage to disable it.
>>
> 
> ...
>> +config DEBUG_INFO_BTF_GLOBAL_VARS
>> +       bool "Generate BTF type information for all global variables"
>> +       default y
>> +       depends on DEBUG_INFO_BTF && PAHOLE_VERSION >= 128
>> +       help
>> +         Include type information for all global variables in the BTF. This
>> +         increases the size of the BTF information, which increases memory
>> +         usage at runtime. With global variable types available, runtime
>> +         debugging and tracers may be able to provide more detail.
> 
> This is not a solution.
> Even if it's changed to 'default n' distros will enable it
> like they enable everything and will suffer a regression.
> 
> We need to add a new module like vmlinux_btf.ko that will contain
> this additional BTF data. For global vars and everything else we might need.
> 

In this area, I've been exploring adding support for
CONFIG_DEBUG_INFO_BTF=m , so that the BTF info for vmlinux is delivered
via a module. From the consumer side, everything looks identical
(/sys/kernel/btf/vmlinux is there etc), it is just that the .BTF section
is delivered via btf_vmlinux.ko instead. The original need for this was
that embedded folks noted that because in the current situation BTF data
is in vmlinux, they cannot enable BTF because such small-footprint
systems do not support a large vmlinux binary. However they could
potentially use kernel BTF if it was delivered via a module. The other
nice thing about module delivery in the general case is we can make use
of module compression. In experiments I see a 5.8Mb vmlinux BTF reduce
to a 1.8Mb btf_vmlinux.ko.gz module on-disk.

The challenge in delivering vmlinux BTF in a module is that on module
load during boot other modules expect vmlinux BTF to be there when
adding their own BTF to /sys/kernel/btf. And kfunc registration from
kernel and modules expects this also. So support for deferred BTF module
load/kfunc registration is required too. I've implemented the former and
now am working on the latter. Hope to have some RFC patches ready soon,
but it looks feasible at this point.

Assuming such an option was available to small-footprint systems, should
we consider adding global variables to core vmlinux BTF along with
per-cpu variables? Then vmlinux BTF extras could be used for some of the
additional optional representations like function site-specific data
(inlines etc)? Or are there other factors other than on-disk footprint
that we need to consider? Thanks!

Alan

> pw-bot: cr
> 


