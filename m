Return-Path: <linux-arch+bounces-13142-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA1AB22ECD
	for <lists+linux-arch@lfdr.de>; Tue, 12 Aug 2025 19:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE491683517
	for <lists+linux-arch@lfdr.de>; Tue, 12 Aug 2025 17:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A025A2FD1B0;
	Tue, 12 Aug 2025 17:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="caIU83SF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="o06e4bgc"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACFC2FD1C6;
	Tue, 12 Aug 2025 17:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755018783; cv=fail; b=kpUayNpkKm62DAVw/XhKZ3TLQbiqC9KCrrx5b/begPsjsy79cf9vv1eCW2O5fj7yaOOKUmw9RlvVxULzE6k7z52Ks9TPNgEesPRFpSUIAgzq4YQqTIRK/0SIJNl55mtoMvTAMPTw4pCc+iABsxG5RAUvPLQJOLTAE7v/FBEQsps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755018783; c=relaxed/simple;
	bh=i1cWSrW779nwOTd6BhvkGIa+0aPVJSj+Mnf9P8zetxE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NKe/pCLT/WG30r+VdvyO/5kKwD+9OJJzFcg+rm8ivM0ZvrGxDB6W7xWQTw/+o+/48ok67du+VwZNHEmDYmG+22Vr67H7IuIZsSKzYSgh1fLhvRycrZQISloyX5eCN58P/AdWyDycEZ77ylyue/u1VyoN4WqLQ0ZQjsCrfjyPbuw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=caIU83SF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=o06e4bgc; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CDC1q4025301;
	Tue, 12 Aug 2025 17:12:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=u8ky/16VbI32MKXQbqMIRpNTKwB7jIgG1/ZcA03D7yM=; b=
	caIU83SF6NJUi7vj3oKVD+EHduBY1ng0s9r18fPVkvqE2OQprDKoe2teP++A9kbZ
	pF3ZDx3xhlJDCw0LpU5d5vTDYfltFze2v5WYbRgxn0qUUqyEt3gRAi4Vq+sV3c3i
	2gZT+1i3xuAYn6BNHXIwGxqFbxPU50fVwpgBancioRqfKuVDTPpUqSSW6dCEoMml
	X9LSJLszbD+KfNkZ707Wyic4P1wlRwdn903Gw5G8oa8IRbS10EVOeM6R3TwGjYYU
	bJ1ylpzMhSnOnbS8fqFwxWfQslx79+ODmPx6vm0xuSxpjHpk0Gl2WbvJWR6ZQSsK
	+QwMIGPz0e0TuF/pvRY+Zw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dwxv56a1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Aug 2025 17:12:20 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57CFuu69009647;
	Tue, 12 Aug 2025 17:12:19 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2061.outbound.protection.outlook.com [40.107.236.61])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48dvsgj5q7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Aug 2025 17:12:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tl6cLtblJ6G9/CloA7YV1Qeu522/maki48LbHNuJzpdVTQ9ML+16XjQrN0Qg253LsnMJzUayK0REd1eEat2lToulVDHyoWJdP7zDCmUwfqdZom2HHVBHcJPqNwyRNhoGu5Jd17lx6CTO1sO3tlTDdxuklpQ7hNcW8+yTExphUXooyJx5BhIdfuD5fx6rEO1lIbBNMb+9aix4K899nvlSk+xg57KiNLrAGq6q0fXREV191W2tY1rHpJUxx6/mKuQ2+eGBM5FsWpFUFcFxaqacooHKIsCgqp5PU3Lo396n4Ajc+04HV2cdSR4TWsjW3lNHxmtpbU3QPpGLjTdoV9tP1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u8ky/16VbI32MKXQbqMIRpNTKwB7jIgG1/ZcA03D7yM=;
 b=raXvBmHimJRu3GcgkmoxuSfUrVsTzA8FfLb920uKv982BqpcFGIbWEz31KNqz+P8WYyQ5N/yQtH1T6hKndlEtTgoEtfsVsMra3zXVVaWp2tapQBFBVnsq27Ty6IXcsU9ObLa3KxFi2DffmI9ddiq5RR7j+NmESSEaB4P9dz0gwt/F/MeHbuorBK3Pt7jINmPdo3g7J1J7is1WvhdFDuXu7yCQBBg5F/ctzRvOLPDBRts4XtJUTW0ccseQcBX8uGZFToQO5ebNJQhP1seuxHQgoSmkq/TTT390H8K15RH7mdBoIvSJaaALi44lI8hC5wTv2P6DdrqeuXdFs5vQYsYng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u8ky/16VbI32MKXQbqMIRpNTKwB7jIgG1/ZcA03D7yM=;
 b=o06e4bgcJw5Tk1+r+ZXTBPvRcCf53Rw/t3Q98578WEEmFqcDz1kOP8bmmYXIDkdet/3jkRnYPpXch2r2xhyNupJp6o+7jopBUl6bKdpd0qckXQG4IzxL5cmj51PTYYlGZtaWta4IBgnMiPhighYsARCGHiv2q/fumpF86mApb78=
Received: from SJ2PR10MB7653.namprd10.prod.outlook.com (2603:10b6:a03:542::22)
 by SA6PR10MB8158.namprd10.prod.outlook.com (2603:10b6:806:442::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Tue, 12 Aug
 2025 17:12:17 +0000
Received: from SJ2PR10MB7653.namprd10.prod.outlook.com
 ([fe80::47d7:5812:ea42:38bb]) by SJ2PR10MB7653.namprd10.prod.outlook.com
 ([fe80::47d7:5812:ea42:38bb%6]) with mapi id 15.20.9009.018; Tue, 12 Aug 2025
 17:12:17 +0000
Message-ID: <e3aca3b7-4f38-410d-91d6-5a2521dedb6c@oracle.com>
Date: Tue, 12 Aug 2025 10:12:14 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/20] x86/mm: enable page table sharing
To: Yongting Lin <linyongting@bytedance.com>
Cc: akpm@linux-foundation.org, andreyknvl@gmail.com, arnd@arndb.de,
        brauner@kernel.org, catalin.marinas@arm.com, dave.hansen@intel.com,
        david@redhat.com, ebiederm@xmission.com, khalid@kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, luto@kernel.org, markhemm@googlemail.com,
        maz@kernel.org, mhiramat@kernel.org, neilb@suse.de, pcc@google.com,
        rostedt@goodmis.org, vasily.averin@linux.dev, viro@zeniv.linux.org.uk,
        willy@infradead.org, xhao@linux.alibaba.com
References: <20250404021902.48863-14-anthony.yznaga@oracle.com>
 <20250812134655.68614-1-linyongting@bytedance.com>
Content-Language: en-US
From: Anthony Yznaga <anthony.yznaga@oracle.com>
In-Reply-To: <20250812134655.68614-1-linyongting@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR13CA0030.namprd13.prod.outlook.com
 (2603:10b6:a03:180::43) To SJ2PR10MB7653.namprd10.prod.outlook.com
 (2603:10b6:a03:542::22)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR10MB7653:EE_|SA6PR10MB8158:EE_
X-MS-Office365-Filtering-Correlation-Id: facee024-cacc-46ee-3203-08ddd9c363a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RlZ2Z2RaRVB2YmhVVnFVY0NsREdYaXZaT04xaCtyM3hPS2lhbkJXVmM3SkFz?=
 =?utf-8?B?VWJwektrMjIwd21LdXpuQzQzNlRQTHdHdTFERTFnVTU2Y3U3WmFJOEs5LzZj?=
 =?utf-8?B?MzdBbVNIbDVRa2ZFS2N5Mnc3bjAvb2hIMTlpcGp6aUdRK0RqZWFZRnpMcEdH?=
 =?utf-8?B?N09SQS9hQXBYVnY0c21XdDl6MXVhNlZuVTBtVFgxSHEyTThzQmNTQWhyQzBv?=
 =?utf-8?B?cE1kc3h0TFRoOFJLMWJoRFRqSFZwMDdqT2cwMGpITFZqY2FzdEozY281Z25k?=
 =?utf-8?B?L0R0OFN0b29MOElkKzVyYm90Tjg3UFVBTW9jZ1dTZE82UUdaclZGOThvM3Ny?=
 =?utf-8?B?LzZzeVByK1dYTG0vb0VMU1lqTnowaFRDbGlzQzFmZUNVVWNKVnUybjlTYUFp?=
 =?utf-8?B?cHM1M1RjMkNvTFFjSzJmaERmRXZLb1VSTk8ydjJEbGJMb1RHMW9kaU0zRVNB?=
 =?utf-8?B?ZW5SNk5xSVRXakplUkxBeDk3N25WcEl3S29lR1VjWUJUeHhpSEZwM2ZYTWhZ?=
 =?utf-8?B?M2RkVVFTNlAzbWhlSEVHUWlDRnR3VVhvSWdTNHpBZTRUM0NXOTZsODJwREJ1?=
 =?utf-8?B?RVhGbmxvUzNMa28vUG9BTzlxT1g1WHFZQUpCYlpoMFRyL3FKSklCZ09Ld0NQ?=
 =?utf-8?B?STh2MmhFZDZqQ09HekdTNUIvMktkOUNRSVN3ZFlqUnJjMFNuVjZKODdqSXll?=
 =?utf-8?B?d2ZIWVlMWXBmWU1lK05yVnZUbDIzTXBuM2ZVS0VYa0dLMjllZjBjcXhIY29O?=
 =?utf-8?B?cy9TbC9MU2ppbmltSEpQeVkvN0RCUkVUczJIMlVDTjNsREgxVHdwRENzU0lQ?=
 =?utf-8?B?ekVaT0hQdHo4L0FrY3ZsTlJyb1gxbE53U1ZRRHZwdkhJUmovZEk4alVuMEMr?=
 =?utf-8?B?SXlrUFgzRnEvdnlGcWdZRm5hbVppSVE4SnU4Y3RWWU85ZzIvOXNJT1JxQmpk?=
 =?utf-8?B?VTVjZ1gxOWg1K29ZQm9ReGpJcS9tMnJ6amg2SlN6NWFkQm5LcE05ZWRLZUFp?=
 =?utf-8?B?MDhmK2R4WjA1b3JwMk1tU2xSaUltU2JoemJ5dCtKVjB2YVZQZk1hNE9PREdi?=
 =?utf-8?B?MDFGM1ZOUkp4SWRUZ2hkdUpGcHA2ZGQ1RWlIbU1xRkR3MVJhL1U4emptMWJI?=
 =?utf-8?B?VExoSHlnTFdUWk1OOGVFK2h4SW4yK0M4UXhXUTZudFNxcFpGTjhBN25YYm8y?=
 =?utf-8?B?d3B0UUZmamtkcUs0Tk9sRmhKRTRxYVpVdzhvZ3lPZ1U5SWp1aVI0bGRpai9U?=
 =?utf-8?B?N01JWFR6Snp1UU8vNkJYL3hyUUN3TUtIQVIxMkJzYXcrNHRhZXdrOUdxbWdF?=
 =?utf-8?B?VlZOanBXWFk1SmhrQzFyVnNwaWx6ZWp2QncvbmpoUm4vVVYyTkZuU1lQQVpK?=
 =?utf-8?B?MWRUMzl5bjRqc2dKWTZWTHc0YjBoeHFPb1FqbWVpOUJ6bG0ySFlJbVpPcS9C?=
 =?utf-8?B?THZiOXFva3A3bEFQcHVDMnZpZ1M0d2JsNjIvYXQyb21zYjFNZ3pwYVNRbCtL?=
 =?utf-8?B?YVRsQ2FKaWFmVTZ5OU9qNnBsenBtVWtWbXhwR29PSzY3d3V4bHRUYzJNUTBV?=
 =?utf-8?B?QjhHS2p6TjJyazdVaC9waCt5bEhmcUxHYWlmOG5CUXljb0hxekhnWmNOeDNE?=
 =?utf-8?B?eWswa29hZVp6R1FLM002M0NWNTdLSUNucE9pUGpCa0ltL3FEckxoRWNLWHZL?=
 =?utf-8?B?SEM1dW12Q0dXbHhaQVFMRC9EZnNYTUVKOEFMbWp6dkFYZHdtZXVoaHgyMXpD?=
 =?utf-8?B?QU9KcFdkaFBNc0YzTkxnZXVuajYzd0loaGREQjFYTWJFdEpTTGZsRkpiOHJx?=
 =?utf-8?B?cmdHUlBpeGl1cW43bTFxQ2JOSlJlVmExRlRFeHA5dnlHaGUzM3FudUpzazBS?=
 =?utf-8?B?cHZYSnNBcVk0c3JnUWh2MmlzQlRyWWFnRzFRS0ltdGlxWmxoR2t2ZDRhanBk?=
 =?utf-8?Q?CIo1bFX6qCA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR10MB7653.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TlgvWitMd0hyNnFRdFpNaERuZ3k3VkREU3gvWmVkaWlKRmtTUkkwTEtMRkFs?=
 =?utf-8?B?bHNSNjNWdjY5d1BDWkFTWWx3VEwzZERzZ0dzN3R3NWwwVURWN0hyRVdIaWdZ?=
 =?utf-8?B?QzBjcllmejN4OUFmQkU2NUU3SHhtVHIvREU4RUxDTW9RUkxjb0xKc2Foc0NV?=
 =?utf-8?B?M01LaWFTcE5kV2FhdkRNcWNrZFJWdFgvL25wajV1L0Z1cUw2RGZHRlRqZGZC?=
 =?utf-8?B?dEpSMVQ1Nmx5OElXenpMQTNGcHhXV1JTWlBZcFRBVEZGVGVwSUVic0VsWHg3?=
 =?utf-8?B?YTVrTVRibG02MENLN3R5bDdYcWtYQ05XNjhPaEs5VGUzdjl0ejRkazNUS2NZ?=
 =?utf-8?B?Q1JDSCt2aG5VZ29obFpDaWRsRW9kRVpqQWJ5andGOVhDZStoTDRBUDlVWXNU?=
 =?utf-8?B?TUNXQ1kzT3V3Tk9xYjRpbXkwSTBPc3pPMXhpL1BPRFF1cXJLa2ZSNUlybWtJ?=
 =?utf-8?B?aldBVU1NTmJqdHNzcTJ0dENaM3pXblQ2MCtVZjVaYmFQYUEwRXJnNiswM2lH?=
 =?utf-8?B?Vm1MakxvNmJFSE15NUdzS0JsMXA4VnJpdVdHeEdLdXFhN3QyclRFOHFVUDFX?=
 =?utf-8?B?SXBqakUzQi9oNktzK2pZandCTWZOdFNkREkrQ2IxVUxwdCsyeXlSOUFNUVdp?=
 =?utf-8?B?QnVLcFNKT2toWUtPbmM2ZEg2K2ozUUhHcjZOZFNscDJyWlFXTDVTcFdXWEVx?=
 =?utf-8?B?T1VpcHRUNlcvM2FvUUk1VzlXM1YrdXo3UDZldm5DMUQxMU1HN0ZBVWE3SkVG?=
 =?utf-8?B?em4wSm5KZjU4L3hqaFU3RzhZbDR0M3lVNzIyZ3BqNHFHVmZ6NEJQZElkdlIz?=
 =?utf-8?B?ZUdhc3RGSk13Yzg1R2VQeDRzSEREcDJIUUdWL0RadzNKTDBkczkxM01hazU1?=
 =?utf-8?B?eWZTMzhGRmxIQTRxWFhJalAyVXZVQnFSV3RWTFZNMmFtdVYrNDBvb0lhQnJW?=
 =?utf-8?B?VGxPUjFUMUhjWGViSEpDY3hWQVBPT2IzQVFkQ0cwN0Raa2pCenQ3Rkp0VVY5?=
 =?utf-8?B?ZW5KQW1ucnp2NlJPUU04SnZ6MSsrTTJYRm9KUm12QUJHNWhpNXVXSEs5ZGhS?=
 =?utf-8?B?eUlML1A0cDMzd3NrRDNpTllQMjJ6alcrUUltR0lpY2pTSWhvSTRiU3NHa3Ir?=
 =?utf-8?B?V2tDQkdHZXFrNm5hTkovSXlKSEZGTjVOZmw0cTgzTVBDOUprREhQUVFub1Jp?=
 =?utf-8?B?eVJBU3d4SVZ3cWhiNXZJZDdMamYyUU8rbERFSHVSN1k5SUdXOGtYajh3OTY3?=
 =?utf-8?B?d2pycnVCRjJ0MHg1WkZLNVA1UGgvaytraHBZTlNQMDlPK2VsbVFadWtmNk9i?=
 =?utf-8?B?d2wvc2IwR3ZkS2tkdk1EbW8xempuSWxPZlRuMjdNVzVULzFicUxPNFlOcmJj?=
 =?utf-8?B?YkpJUmFDRkZhRUJiZUxMWlpLTmlKS1lWZnFtU2lyN1dGQlNicTV3Q05ZVGk3?=
 =?utf-8?B?WUxBMEV4SUZpTkV5M01LQ0x1MTByUytwWnpPQmtPZVA4dmVvYzJ6cmtmeUdS?=
 =?utf-8?B?aUt3ZWlzM2I0aklUbWdWUjVVYnBHMUdLTHZZYTF5aTJvREd4aDhGd3h6alEx?=
 =?utf-8?B?ME5FOTluMEJoN1RTbjN1WmozSHRzMTFSejV2bE1UN3orMzdTcVpUUFBQVW5G?=
 =?utf-8?B?SkJZOTdzL1EvY2RHR1dSSU8yTERXY1VTR1kxcWNaTzJYV0h6YksrK0xwc3F6?=
 =?utf-8?B?WHF4aXd0NjBsUEE1NzhVOUFJY2FSejJ5dXl0R3RxS0txM2Vkb3oraUpvSEFV?=
 =?utf-8?B?d3JOZjNPVHFMMjJWaGQzbVRUY0JJYVJVbHhiWjc2dG1aTU9TMkg3MkVTM0ZJ?=
 =?utf-8?B?MGNXNTFJY0dvZk13Zmw5QUZQRUVLdkoxMlV6K2ExVU5ZaW5zVE8wcmVlRGl0?=
 =?utf-8?B?QTg3dFNvSS90RndTSmYxdE95MlBabW9ZajVEU2pMV0lDLzRPcHRVaEx1ekFG?=
 =?utf-8?B?UU56akIyTFN6eVpDQlhYWUZDMjk0MGxzL3IwRkQzd2JTa3kraitEa2RBSXZp?=
 =?utf-8?B?cFJsNWlCdmJiMGJScERwK001ZDdKQWlkdERpSGpHdGEwV0M2cncrNUlVejBS?=
 =?utf-8?B?MFQyN09WeFh4bGxRam5zVXZEeHlzQzI4OXRDa2thak1XL3NXTElkeWt5S2J0?=
 =?utf-8?B?VktWZUdTVFhEU3hCN1dTTk1pWUNYaHAvbklBbUZEQWNDRVp6TmJYMGVqb1Zr?=
 =?utf-8?B?S1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	L39QOTPfaaRhC67pUHKYTcZM5H82WNAzaFNpLBuUOJ2636tba5FwVVysl05EYmr6PKK8OUMsu+FVc0UVSRVH1L17740DaYv+W+UJgRpCxRIu1cifDzEYhfUU+ExiIAXRXzq7o1GJ//KIJO0m22jypMc9jsLMhu3/VZOKPrUzwyZJBJxnj1svaGSHd1Q8TfE1OPEg8s4ChWSAE8kCjugPmoY6XM0Sj2e0EZSFCV1QaLGJsiSaLsWd9+tRBOEaGpJsB68KMSlVGdNfX6MMH1pVeqQE590ISW9R2QCHBFJj9z/G+JFScc1u3DfG+6cicXsqOfDh3zivsehPSsVcIHPwD12isAqrFRPr3lEZMjnTi7A9Cghfb9ctITBVq6hTJQ2KUte7f5O9GxDwJX9mV+u7+b1EK0UWk0OMEmBiAViZIrB3idYs+fyIjC0dwi3d8sgHagqev2pSbLrUG/ebL4o11Puzgibkp9qwbJZ1B1dY5U2VxisNPEUSw79jdwtbzpDjNSr/Ls1sTkGmuprZxRMHXfvDYyvUdnr330kogWUzkGU1UlcL2NH23YKeP8mYR6qTRy7AAE49LbLcFpZ724DYFZ9u+d1AGKC75RXiucTamuA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: facee024-cacc-46ee-3203-08ddd9c363a3
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR10MB7653.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 17:12:17.2910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8RCBs+OBoerh7Y0MY4/XpY13j/fO2+IJ6eKpTBGYIzvbEoFunkB6adMB7OGJ9lleP5Y1VPfDBsss1RJcR1+kBfqwdnH8s/bdL73KqWwPJWs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8158
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_07,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 mlxscore=0 phishscore=0 spamscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508120164
X-Proofpoint-GUID: SXGxVXGPk2wVpnKQlPa9mILkVUB9sPpE
X-Proofpoint-ORIG-GUID: SXGxVXGPk2wVpnKQlPa9mILkVUB9sPpE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDE2NSBTYWx0ZWRfX7H7TPGZ3saI4
 PbCF02WJDLNwPeuNH2Z/QJvXiWEv1UpB0ouGztlnc7wtoqeNGh0hTBOHy6I+Wv4aFKUWR+KZexg
 3E/X8W8h+kdpAvEKv6a3NxxJqhOxWq4CZPPuIE3XUztLigZJUxbWA4bWgcNf4EtJYArODdpyPaj
 nTNeZKNCXNEqdL7DtCvLjhEIlWhpxPBKFKIMMNsL/epCiU6eSIphktFHsVhIoUl3G4zXlTOBx8e
 bOi3x1KBTwU8ZyJIo0s4PIIDYi1H14Uz1B04nnxiMiouzc1VALoWYAhXJSIGB2aTMLyGmabrFd2
 weyBt/q19RE6LVx3ud4uCCAApkUUz63OkXqyhepMWhaqsBfVgUhppJVGv+1JNSZhqB7BGYsPSSO
 +xRWEK2+0u7saCczlS6+eW/VX3dMmmFXUHdARGvE9N3j3IujvQRLmd7JOKZeYHW7Ov43EHho
X-Authority-Analysis: v=2.4 cv=KJZaDEFo c=1 sm=1 tr=0 ts=689b75f4 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=qs7miOXIAFowCICzxXsA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12069



On 8/12/25 6:46 AM, Yongting Lin wrote:
> Hi,
> 
> On 4/4/25 10:18 AM, Anthony Yznaga wrote:
>> Enable x86 support for handling page faults in an mshare region by
>> redirecting page faults to operate on the mshare mm_struct and vmas
>> contained in it.
>> Some permissions checks are done using vma flags in architecture-specfic
>> fault handling code so the actual vma needed to complete the handling
>> is acquired before calling handle_mm_fault(). Because of this an
>> ARCH_SUPPORTS_MSHARE config option is added.
>>
>> Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
>> ---
>>   arch/Kconfig        |  3 +++
>>   arch/x86/Kconfig    |  1 +
>>   arch/x86/mm/fault.c | 37 ++++++++++++++++++++++++++++++++++++-
>>   mm/Kconfig          |  2 +-
>>   4 files changed, 41 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/Kconfig b/arch/Kconfig
>> index 9f6eb09ef12d..2e000fefe9b3 100644
>> --- a/arch/Kconfig
>> +++ b/arch/Kconfig
>> @@ -1652,6 +1652,9 @@ config HAVE_ARCH_PFN_VALID
>>   config ARCH_SUPPORTS_DEBUG_PAGEALLOC
>>   	bool
>>   
>> +config ARCH_SUPPORTS_MSHARE
>> +	bool
>> +
>>   config ARCH_SUPPORTS_PAGE_TABLE_CHECK
>>   	bool
>>   
>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> index 1502fd0c3c06..1f1779decb44 100644
>> --- a/arch/x86/Kconfig
>> +++ b/arch/x86/Kconfig
>> @@ -125,6 +125,7 @@ config X86
>>   	select ARCH_SUPPORTS_ACPI
>>   	select ARCH_SUPPORTS_ATOMIC_RMW
>>   	select ARCH_SUPPORTS_DEBUG_PAGEALLOC
>> +	select ARCH_SUPPORTS_MSHARE		if X86_64
>>   	select ARCH_SUPPORTS_PAGE_TABLE_CHECK	if X86_64
>>   	select ARCH_SUPPORTS_NUMA_BALANCING	if X86_64
>>   	select ARCH_SUPPORTS_KMAP_LOCAL_FORCE_MAP	if NR_CPUS <= 4096
>> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
>> index 296d294142c8..49659d2f9316 100644
>> --- a/arch/x86/mm/fault.c
>> +++ b/arch/x86/mm/fault.c
>> @@ -1216,6 +1216,8 @@ void do_user_addr_fault(struct pt_regs *regs,
>>   	struct mm_struct *mm;
>>   	vm_fault_t fault;
>>   	unsigned int flags = FAULT_FLAG_DEFAULT;
>> +	bool is_shared_vma;
>> +	unsigned long addr;
>>   
>>   	tsk = current;
>>   	mm = tsk->mm;
>> @@ -1329,6 +1331,12 @@ void do_user_addr_fault(struct pt_regs *regs,
>>   	if (!vma)
>>   		goto lock_mmap;
>>   
>> +	/* mshare does not support per-VMA locks yet */
>> +	if (vma_is_mshare(vma)) {
>> +		vma_end_read(vma);
>> +		goto lock_mmap;
>> +	}
>> +
>>   	if (unlikely(access_error(error_code, vma))) {
>>   		bad_area_access_error(regs, error_code, address, NULL, vma);
>>   		count_vm_vma_lock_event(VMA_LOCK_SUCCESS);
>> @@ -1357,17 +1365,38 @@ void do_user_addr_fault(struct pt_regs *regs,
>>   lock_mmap:
>>   
>>   retry:
>> +	addr = address;
>> +	is_shared_vma = false;
>>   	vma = lock_mm_and_find_vma(mm, address, regs);
>>   	if (unlikely(!vma)) {
>>   		bad_area_nosemaphore(regs, error_code, address);
>>   		return;
>>   	}
>>   
>> +	if (unlikely(vma_is_mshare(vma))) {
>> +		fault = find_shared_vma(&vma, &addr);
>> +
>> +		if (fault) {
>> +			mmap_read_unlock(mm);
>> +			goto done;
>> +		}
>> +
>> +		if (!vma) {
>> +			mmap_read_unlock(mm);
>> +			bad_area_nosemaphore(regs, error_code, address);
>> +			return;
>> +		}
>> +
>> +		is_shared_vma = true;
>> +	}
>> +
>>   	/*
>>   	 * Ok, we have a good vm_area for this memory access, so
>>   	 * we can handle it..
>>   	 */
>>   	if (unlikely(access_error(error_code, vma))) {
>> +		if (unlikely(is_shared_vma))
>> +			mmap_read_unlock(vma->vm_mm);
>>   		bad_area_access_error(regs, error_code, address, mm, vma);
>>   		return;
>>   	}
>> @@ -1385,7 +1414,11 @@ void do_user_addr_fault(struct pt_regs *regs,
>>   	 * userland). The return to userland is identified whenever
>>   	 * FAULT_FLAG_USER|FAULT_FLAG_KILLABLE are both set in flags.
>>   	 */
>> -	fault = handle_mm_fault(vma, address, flags, regs);
>> +	fault = handle_mm_fault(vma, addr, flags, regs);
>> +
>> +	if (unlikely(is_shared_vma) && ((fault & VM_FAULT_COMPLETED) ||
>> +	    (fault & VM_FAULT_RETRY) || fault_signal_pending(fault, regs)))
>> +		mmap_read_unlock(mm);
> 
> I was backporting these patches of mshare to 5.15 kernel and trying to do some
> basic tests. Then found a potential issue.
> 
> Reaching here means find_shared_vma function has been executed successfully
> and host_mm->mmap_lock has got locked.
> 
> When returned fault variable has VM_FAULT_COMPLETED or VM_FAULT_RETRY flags,
> or fault_signal_pending(fault, regs) takes true, there is not chance to release
> locks of both mm and host_mm(i.e. vma->vm_mm) in the following Snippet of Code.

If VM_FAULT_COMPLETED or VM_FAULT_RETRY are returned then the 
host_mm->mmap_lock will already have been released. See 
fault_dirty_shared_page(), filemap_fault(), and other callers of 
maybe_unlock_mmap_for_io(). I will add a comment to help make this 
clearer. I also realized that fault_signal_pending() does not need to be 
called here because it can only return true if VM_FAULT_RETRY is set so 
I'll change that, too.

The checks in a 5.15 kernel will be different. You probably want 
something like:

         if (unlikely(is_shared_vma) && ((fault & VM_FAULT_RETRY) &&
             (flags & FAULT_FLAG_ALLOW_RETRY)) || 
fault_signal_pending(fault, regs))
                 mmap_read_unlock(mm);

Anthony

> 
> As a result, needs to release vma->vm_mm.mmap_lock as well.
> 
> So it is supposed to be like below:
> 
> -	fault = handle_mm_fault(vma, address, flags, regs);
> +	fault = handle_mm_fault(vma, addr, flags, regs);
> +
> +	if (unlikely(is_shared_vma) && ((fault & VM_FAULT_COMPLETED) ||
> +	    (fault & VM_FAULT_RETRY) || fault_signal_pending(fault, regs))) {
> +		mmap_read_unlock(vma->vm_mm);
> +		mmap_read_unlock(mm);
> +	}
> 
>>   
>>   	if (fault_signal_pending(fault, regs)) {
>>   		/*
>> @@ -1413,6 +1446,8 @@ void do_user_addr_fault(struct pt_regs *regs,
>>   		goto retry;
>>   	}
>>   
>> +	if (unlikely(is_shared_vma))
>> +		mmap_read_unlock(vma->vm_mm);
>>   	mmap_read_unlock(mm);
>>   done:
>>   	if (likely(!(fault & VM_FAULT_ERROR)))
>> diff --git a/mm/Kconfig b/mm/Kconfig
>> index e6c90db83d01..8a5a159457f2 100644
>> --- a/mm/Kconfig
>> +++ b/mm/Kconfig
>> @@ -1344,7 +1344,7 @@ config PT_RECLAIM
>>   
>>   config MSHARE
>>   	bool "Mshare"
>> -	depends on MMU
>> +	depends on MMU && ARCH_SUPPORTS_MSHARE
>>   	help
>>   	  Enable msharefs: A ram-based filesystem that allows multiple
>>   	  processes to share page table entries for shared pages. A file
> 
> Yongting Lin.


