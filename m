Return-Path: <linux-arch+bounces-7785-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72089993746
	for <lists+linux-arch@lfdr.de>; Mon,  7 Oct 2024 21:24:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D3D71C22EF0
	for <lists+linux-arch@lfdr.de>; Mon,  7 Oct 2024 19:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830121DE3B3;
	Mon,  7 Oct 2024 19:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="coZpapby";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EzCgKWhp"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941841DE3B2;
	Mon,  7 Oct 2024 19:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728329081; cv=fail; b=s1D1onvzxhj6cn25A0ObTqebCodnwrK9KLz2GzKY1tTtI7mHr8eRneUTGcrlxZZ+X8j/ecYkdhjDzLjbasEMRrJvPzD/Ch8+1EMHLUarvuEeUDicNKqRXFw6ZFI6rbVVGi02SFYTTHOb1Hh/Fv/BaqYTbUkS0P4vIv7vEU5NuWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728329081; c=relaxed/simple;
	bh=pH05Rv/VfTYf34n+NnlFKO4hSXVwJqxOwaQKJBVHaiE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UoT+v31OwDs19IVttnUEB5CAk2nsnCBDkdXnxroPfy2r6UDNniWOM+RgGJguyzthF2pVGisJcHvQMtb8yo9FikR5fsoUvGB8EoEBs9OlXFw+o27BU1lAwB86tFM6Mpk7CusWEHyfX9qWGXeE7M8KQnqVAnXitSRAyFU1Y3eQAiY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=coZpapby; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EzCgKWhp; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 497FMdnA030874;
	Mon, 7 Oct 2024 19:23:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=xyzItSlP2sS234zCsTVBEEu5lCV4a8kpUbkOyBfXbkc=; b=
	coZpapbynDC3MyZMKrBq/O4QATYWWnWFm2EtZDciYIQsVQvyxXPO9/umhIkAGpiB
	KZCd+LWFkW1FnF+bo8pTErqj39FxDdHynx44thZg4jqmmFjHhJmt6u3fHY5Yb4zr
	uipS8GlNh3BtNrLdkbF588dWCktsvevD5WQ57u+V065jP0KmcRWH3hcD7nqvpPGF
	RFqPfXcYEnmRcdyZMZKdfvtwLI9kKQ7K5D4OVwcfg8tJZHSrhxMrFhLcRHuqEMtM
	h1q9QQqkV8W0t7wMjDLVJTP844mrQCkY5/USJ3UOEIgF8hzd/moZGskll/GJO4OP
	wHvIMPauUeLTjcXTkpCcYA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 423063m6sk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Oct 2024 19:23:43 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 497J6vjj012446;
	Mon, 7 Oct 2024 19:23:42 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 422uw67t54-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Oct 2024 19:23:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n1nRHvdyBrEEXrtTcpD/Xg1zbmoZCqFZjCyjpF+8gGgDNjEQQBXSece3pdmyEmAr+fROYhULV+JZLiehp94uZ22DoCjV6DilOUkrtv/P27pGhYdEU99jQgWUuI58W3Yj0ETYr8NPs5hrwsgcsio61yxzGmuRyouL22Cd6u1tW58AWw5avg227pF+iIKnfWTej+4NWkTp6dseM6QyttgHvm3ZTtPaXREO0Zc8czm0sUxiW98OnKO/WXlCXEeOezXqvSiHOXsN4GCdHEDnI9FBTjcvQljt2yx2g28lNl4GTma+taS5ZKkjcdxxm+LdvECZBNjw9uzosP5yv/PvqSHUqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xyzItSlP2sS234zCsTVBEEu5lCV4a8kpUbkOyBfXbkc=;
 b=g4yWuJHyqzmrv/GtQT9GUS9kb5QCv0SA3OaBZNg4TFd29C9k6aFPQT7s63I/xFElkOB1D+BBWI4xrFPHOKC+sHyzcM3sKYvU8qSUchGjKCA6g8Es1XTkLmj2QydDsequr+an9EeXxPpjTkwsbBndOzEaDhrmI+q91XB8jdoen5YZMC/PYEXeafWg2Z0c83LctJTdh73uaSfAVSHJ0DaAOTrO/w0ekbkRFY6/9RYYIkkmchmbRy3MArS7CJBfmKsjUnO6u72qDvx7F2CThfxN+WFe1YJay/dUhuXtItFLPf390ZLcqKaVIuMXu/3k+C9foSGC6u/beaEpf99E9QZWtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xyzItSlP2sS234zCsTVBEEu5lCV4a8kpUbkOyBfXbkc=;
 b=EzCgKWhpIFQC0CzoCatsReGzVWRycCZ2ZP76QgXOsEcaBgGUM9gatvuZaVeJrNmqviORdFCr4q88fOBq33PDSseIx0atZuNY59nosPCEu+5H+PvJac0RCetrmNct/1erBI3fPVcraW5+27V/apKxSDi7XpEdTy8kw/wTSFIojJ8=
Received: from SJ2PR10MB7653.namprd10.prod.outlook.com (2603:10b6:a03:542::22)
 by SJ0PR10MB6399.namprd10.prod.outlook.com (2603:10b6:a03:44b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Mon, 7 Oct
 2024 19:23:39 +0000
Received: from SJ2PR10MB7653.namprd10.prod.outlook.com
 ([fe80::47d7:5812:ea42:38bb]) by SJ2PR10MB7653.namprd10.prod.outlook.com
 ([fe80::47d7:5812:ea42:38bb%5]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 19:23:39 +0000
Message-ID: <d56b1326-74e3-4782-a5c7-0451f08cf10b@oracle.com>
Date: Mon, 7 Oct 2024 12:23:27 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 00/10] Add support for shared PTEs across processes
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: akpm@linux-foundation.org, willy@infradead.org, markhemm@googlemail.com,
        viro@zeniv.linux.org.uk, david@redhat.com, khalid@kernel.org,
        andreyknvl@gmail.com, dave.hansen@intel.com, luto@kernel.org,
        brauner@kernel.org, arnd@arndb.de, ebiederm@xmission.com,
        catalin.marinas@arm.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhiramat@kernel.org,
        rostedt@goodmis.org, vasily.averin@linux.dev, xhao@linux.alibaba.com,
        pcc@google.com, neilb@suse.de, maz@kernel.org
References: <20240903232241.43995-1-anthony.yznaga@oracle.com>
 <nst3wauaphvvnkseuatqknxfhtu5ewf7zqmoskim5kt52wf2mi@sasls2f6r22i>
Content-Language: en-US
From: Anthony Yznaga <anthony.yznaga@oracle.com>
In-Reply-To: <nst3wauaphvvnkseuatqknxfhtu5ewf7zqmoskim5kt52wf2mi@sasls2f6r22i>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0444.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:e::24) To SJ2PR10MB7653.namprd10.prod.outlook.com
 (2603:10b6:a03:542::22)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR10MB7653:EE_|SJ0PR10MB6399:EE_
X-MS-Office365-Filtering-Correlation-Id: 6501bd4c-44cd-4e46-fe5e-08dce7058c70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aEE2Wjdnd0UrZEhNS05ITWF2bFVnQjVJemJYWlA0bjRDM2JzQy8yQnNLd2Ew?=
 =?utf-8?B?QS9Va0kzVi94MXhOV1hhU3ZCMkc2aEFWT0YyVjBid0NQK2RjbEMrTW91akNs?=
 =?utf-8?B?NmhoLzg4WVlRMWdkYnFZWDFER29uTWZvdnZVbzV6djNVL1NiUkJkdW5OaC9z?=
 =?utf-8?B?eHlIU1Zib0JJNUppYVd5SUx4bWFHRkdjN0N5bjhuSDdDVFM4QXlRME9ZTXJF?=
 =?utf-8?B?dEt1dEdnRWpBNmtTTTQyZEhsa1Nvd0RzSm1YN1JxSjBucXZra3NjWGY5dmJW?=
 =?utf-8?B?aVRyQzdjK1BJbmMrTmpmUDF6bGwvTUJ1Y0dERWE1cVFER2VidnlSV0luU29q?=
 =?utf-8?B?aXkvODZMM09ZbThyVzhBRHJhaFd5a1psNVVGTFhEUmFMT0ZkTWJiaHVCZGVC?=
 =?utf-8?B?eThGWmRoSG1OaU56ZHNBb0ZlcUVHTEVYK1JWQVpmUTg1NkRyVjR6UHFGaVN6?=
 =?utf-8?B?T0RBeUdnMmMrNkpvRkJ3T1A1a3NtM1Mrblk2TDBTeUtnbVN6UjN0ZnN4cTJ5?=
 =?utf-8?B?VUM2OU1FZXlrUnR0L3dJWFpjb0gxMHFFSXBKd2ZSandGcGZQcW5XeW55SHox?=
 =?utf-8?B?SGF5aUM5VDhQT1dXZHg1M3N6OUludzlxYi9NelpUQkFINFBiSEdpZXJpWnBy?=
 =?utf-8?B?d2U0Z2IySEhSYjJyVTVmQ0tDMEtFM3lzdHpBSS9xanRzeUp0QnZURlBtRzBU?=
 =?utf-8?B?VkhQVTNMTmpTbkZ2dXkrQVBTcVVhYWpPTlJsOCtDTGFNTFhWMHRiczhFOHNS?=
 =?utf-8?B?RGVtRmV1T1VQN3FwUjhvWHNBb1FxZFVDSHlySGpmaG9SZjZUUmw5M29UbG5l?=
 =?utf-8?B?bEc1NlhJbHBXb090N3kyVEJDblVEZ2R2VjNwbFJaRDdKdGwzT3o2OTg1aUIz?=
 =?utf-8?B?QU1vOWsxUlZ4TU9INUlFbHJKU29XWDdNV2U3bWlPMFlZd1hoNitjQWFiajlt?=
 =?utf-8?B?dUxQbWcveDRnVkF0TU5jMWFNVndQV29WUXYydmdtVXN2cDEwTVEwWEJuZFlZ?=
 =?utf-8?B?aUo0Ukk2NHI0bndsazhVM1FJd2JBUXZ4QmNqSUZzaVFDdVlMT2JlMFFUaHgy?=
 =?utf-8?B?WXJnVVZTVVYzaUY0QjQ4QXpqamREeHFOVHJYYlR3YndPVTFISlU4QWl5bmpR?=
 =?utf-8?B?SC85UDRKc3E0YThQcnFsNGRXWnllUnZGeXZJQXRlNEozL2dMRVVUK081SG5H?=
 =?utf-8?B?V255SXZ0K2l1TVdSSk9VYXdwRzBXUnA2UGxkYnZrOXIrL1VHQkxlbWxuNzZi?=
 =?utf-8?B?QTd2OElGSzJDZlkwRjNNbmNEVVF0K2Z4TEltMVFlbXdOUlUvYUs3QjJGVWEr?=
 =?utf-8?B?NEkwQXM1ZUhjRjRWS3BrSnprd2dGT2tKVzVodGllTEw2aU03WHVTSDNjSm1K?=
 =?utf-8?B?Zld6b05ZQ1ZubVdrVkZmZXViSGhkaUhCYzAycG0xcjc5dzVhYTVqYUVoS2s4?=
 =?utf-8?B?K0ZySWh6Ymh4eFhaZkFNNHZuRUU0akt1QVhObnhOVjVTOUFTM2VGU0hicVNN?=
 =?utf-8?B?bnFxOEkxcFBnUXNQMW9BNWpFZVExb2ZaZ3NveU5xTmVzWDcyV2hRaWNsQ0ZR?=
 =?utf-8?B?MjVmVlFUY3J6emcrNVFDV2FBMGdXcjRIK2hoVHlWaWgwV1lydElUR0h6R0tE?=
 =?utf-8?B?eVhTQ1FIeU96RUVwUHJtU2J1cStZOEYzdHIxZUVCUW1ySUlRWHJLMW51cWI5?=
 =?utf-8?B?U0lGc2dWajVJaENGNlEyYlYrZkxSbDkrSkNaQ0tZbGdtZXorTjFHYkRRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR10MB7653.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q1JONTdCSW1La3FVWEo2VjRvU3hVQkZWcmpDeitRY2I0MTREWkMyVndJMHBX?=
 =?utf-8?B?czIxSDlxU1ltakVoanZWY0ZrMnpBYWlsdENBZVBFQXdVeElNeEpzYW5JZXVS?=
 =?utf-8?B?WTZ4ZXpRVGFpRFkwZnRsbThRY1FYdlE1YVhiT2p3c0JMcUpLRXFudVI4aHoy?=
 =?utf-8?B?OVFqMi9OL2xhZzlUWWt5QUNRbTNya2R1cHJJdkVBYUsweEZUVHZFbDBJU1oz?=
 =?utf-8?B?OEs1Ynp4U3hwYjZiN3Z1VWtxVEd0dzB1dEZJMDZLazJrTUxUcnlvWk5sTFRm?=
 =?utf-8?B?RUU4bnp4V0pKNU1lbFExcjdkS3ppZDNxUjg5TFU3ZW0vb1ZjUWFvNlZwWWYv?=
 =?utf-8?B?V3NlTmxGNlZXamVzQVpXVFplbUp6NXhWRkdkRDlxMlBOaGt6R2ZjUTFvQTUx?=
 =?utf-8?B?cG1vSHo2ODhKWlRVRzltMnhocEU2TklKUmtlSlpMRm9qVFRjZmNZK2I0K0dx?=
 =?utf-8?B?eU1lVm9lSGRKaGhldW1vOEd1eEJ3d0d1TFNxbThUbzRWYkpJSXp4NysrTGM5?=
 =?utf-8?B?b1BSYXZibitSVEw3TXFDem9iK2lkTCtwakNzTVlaUldRK3BPR0dlVXE3WGxp?=
 =?utf-8?B?blN5RXdrR21XcmZIZSs4eWJGL0FsQ3NFNHR4YWxraVRFNi96OTM5OTdrdUhU?=
 =?utf-8?B?WFZmTi95UGVwWFIzT2VVVzJibUJEQUg3b0dkekdCcld2QTdLUVh5Y3V1MWQ3?=
 =?utf-8?B?NHRHcCtWem9IOFdtYjU0MktNRkpQdHB4MUdrdGthclQrUkdaWFY2UWttRDRj?=
 =?utf-8?B?RjdpaG1BMC9QS0dad0tCSFhLWkI3OGlNQWpxSHRaSXp2S2Z0cWZpZko0cE5n?=
 =?utf-8?B?SXFLV2JrdHVYZ1dVYmZ3dW44Zzl2MWljSFBGckVRd0RYMjRLLzRiT1RCbG4r?=
 =?utf-8?B?VjVlZzQvZC95MW4wd1RId1plZHRxNEZFd3lLRUh5cXp6V3M4dE5ZWTNQZk1n?=
 =?utf-8?B?elQ3RzNEQ3RrbmJUeEJySGtqYlpqRHRJUU51Z2VONXVBZ0ozU3hqVjBzcC9w?=
 =?utf-8?B?eDlMVzZSMU14Si9RTzdNbUM1YzdLK29RUWFwaHBwMlVFZWdvMlpxS0FVbEhJ?=
 =?utf-8?B?VXpMdHhFQW04ZHpLd3I2dHV5VjBrdzZHNU1SQUExUnlKTEQxNnpZVUlWU1Ba?=
 =?utf-8?B?K2hSNWd4cURLRzF4bGdlQ1hrMDVLaWdrZXF6bU9FcU13Zi85TjJFMGRVRFBp?=
 =?utf-8?B?bm9QVGEvRzFEalRodVRtTFZOLzVuUElPeER6NWE5QjFOMXExRFNwVjZjUEk2?=
 =?utf-8?B?RHBycDNkWW1iTURyeHpkdnBkWWtXcm9NNk1Mc05EVXNCU0FMVDFucEtOWjVk?=
 =?utf-8?B?SEN4TlRHQVk4OGtDM3dVM0xLbHhxS3l0MHJ2Wk1xdUFUb3c4c0NsanRHNmIx?=
 =?utf-8?B?cmNjWWFTNVVOdGhaZllWbGxlUWVjR2hwOU4wc2ZKMFRtTkRQMWZhK0NvQi9y?=
 =?utf-8?B?eWZEZ3oxRHFjWUpqaG0vbTNOMldXei9taWNiTTBxamViQXJmbFFDSTBTK2VW?=
 =?utf-8?B?S0dQQWQyMHN4Zi9POW1xV2cyd2pMekg4OG8wSDd1Q1g3c1VYNkhXRHNFZjVz?=
 =?utf-8?B?dnFkVWNTNFdKaEtQbVhhcUlMTndNY2RJNzMxeW9mbG92dlFPWlcrQldJMjds?=
 =?utf-8?B?b1k1Z2doMFZNZjljcjdDTGJrNmdHOWJxTzBNbC81UW80WG1LNS9yY1Jzc29k?=
 =?utf-8?B?YlZHN3BsbmZMbHdyUThCOXJyVU1YbUdpa3B3Uk0rVitnSlhCVkRrdlo3bG95?=
 =?utf-8?B?TWEyQitSRDFWOEJ4VnBtTy9Hem5BbDRqNU83U2NOcEUxWjBscG0xU1lnMno2?=
 =?utf-8?B?azF6clBFZGNCUUt3NG9pRzVab2lZWEQ5V0NBSjREaTJaQlJFeFpPbXQ2Z1Vn?=
 =?utf-8?B?Qzk4Y1NrcG56ZSt6V24veUgwRks3OXZnMGZGeExneERWZDhWOW0wR2M2YmY4?=
 =?utf-8?B?bTBiVFBvaEVyaVdZZDZTZzlrNEZsYjFhbklVeWp4d1M2SXN6RDN5QWtZVFVZ?=
 =?utf-8?B?aDdxeWZhdmtPTVcxdGZnM2UrZmZEdzlnUkI3dlFzbFZ4TUl3NHRxc3N3WlVv?=
 =?utf-8?B?QysxdnFzZmJoNTJ1M3JvUWI0bjdmeXBsdklTdkEweTdzS3p3UWFzQVoxakpj?=
 =?utf-8?B?YWZiZ2tvb2RmYVVWZ2NOVnVwYzZLZzJJenNwNk9Xc2pEaFphRGxNRjA5dWZP?=
 =?utf-8?B?MFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EZJ6h9ncAVkIPF0PNfcb81jpuVXC5DuLu8ERb/fdi3QOHQGjCpBDZ9i76tk2Dh5Q3aV7d+mz7x+6ybK+vDM7Az+yhp47KZWOALtpMLtSslYUjQZNXiYMT8/nTV0itRJo6chHg4ZYEPhTR5wRDTY2qBAJVE26qXYmbNnmhG4zb+oGdkFIoF0PGlspe2zkkp3qbya1/Du81lyAWpq3qKjKu8bkhKAZFJF9n49Gsab8Imo6PQMCygKtdSGl89rbgUfd2A+t5mByc/6ImZfRjTf1tND5W8RYlvFziQO0ROugNC+lcp+oBJTDsWBl9fWfctoNP8uUYM+sb5XVnkG5pTmP/w7Zj7hGnr/vizC2qoGx3m5p4DCNj9b1rbZvapF//YltRqZULBaSILY9YMRftR2yr0z2H51/rOZxp77JtzXEBg36GcNk0wSIVc+CAUKf/tf8Adxn84p00PJAldSsTrH0XMNfvQmTsRRXdAHVZZKnlEKOEvHcnCH+8+wzfNyxb420MIRW88HZE5coP+JKdkOquAeHQwrPDtDGVD1FcBhyGmZYWeaROPx2tfQSMaZI2hmCSI4R3jdCEKUAZ2BI/JQ2vzP/pf9Blt0mEgovEXDCzko=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6501bd4c-44cd-4e46-fe5e-08dce7058c70
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR10MB7653.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 19:23:39.8251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WjNp+K8TYoBlB0OugZEGqy2QO3/4mLdFOW82R5QlT9m0HX59TIaBx9nvkKoCMRbWyOxoyUP7slHizLL5CvkVdJKpRL3s1S0xhTJS+3k1eFw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6399
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-07_12,2024-10-07_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 mlxscore=0 suspectscore=0 bulkscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410070133
X-Proofpoint-ORIG-GUID: hsJizORtmuNYVTPdRBzT5dkcddndh2sa
X-Proofpoint-GUID: hsJizORtmuNYVTPdRBzT5dkcddndh2sa


On 10/7/24 2:01 AM, Kirill A. Shutemov wrote:
> On Tue, Sep 03, 2024 at 04:22:31PM -0700, Anthony Yznaga wrote:
>> This patch series implements a mechanism that allows userspace
>> processes to opt into sharing PTEs. It adds a new in-memory
>> filesystem - msharefs. A file created on msharefs represents a
>> shared region where all processes mapping that region will map
>> objects within it with shared PTEs. When the file is created,
>> a new host mm struct is created to hold the shared page tables
>> and vmas for objects later mapped into the shared region. This
>> host mm struct is associated with the file and not with a task.
> Taskless mm_struct can be problematic. Like, we don't have access to it's
> counters because it is not represented in /proc. For instance, there's no
> way to check its smaps.

Definitely needs exposure in /proc. One of the things I'm looking into 
is the feasibility of showing the mappings in maps/smaps/etc..


>
> Also, I *think* it is immune to oom-killer because oom-killer looks for a
> victim task, not mm.
> I hope it is not an intended feature :P

oom-killer would have to kill all sharers of an mshare region before the 
mshare region itself could be freed, but I'm not sure that oom-killer 
would be the one to free the region. An mshare region is essentially a 
shared memory object not unlike a tmpfs or hugetlb file. I think some 
higher level intelligence would have to be involved to release it if 
appropriate when under oom conditions.


>
>> When a process mmap's the shared region, a vm flag VM_SHARED_PT
>> is added to the vma. On page fault the vma is checked for the
>> presence of the VM_SHARED_PT flag.
> I think it is wrong approach.
>
> Instead of spaying VM_SHARED_PT checks across core-mm, we need to add a
> generic hooks that can be used by mshare and hugetlb. And remove
> is_vm_hugetlb_page() check from core-mm along the way.
>
> BTW, is_vm_hugetlb_page() callsites seem to be the indicator to check if
> mshare has to do something differently there. I feel you miss a lot of
> such cases.

Good point about is_vm_hugetlb_page(). I'll review the callsites (there 
are only ~60 of them :-).


Thanks,

Anthony


