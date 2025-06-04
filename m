Return-Path: <linux-arch+bounces-12215-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56EC2ACE006
	for <lists+linux-arch@lfdr.de>; Wed,  4 Jun 2025 16:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E633E3A72E7
	for <lists+linux-arch@lfdr.de>; Wed,  4 Jun 2025 14:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75AE82AE74;
	Wed,  4 Jun 2025 14:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EuN2df/J";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="0ESDxtGu"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3539DF42;
	Wed,  4 Jun 2025 14:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749046588; cv=fail; b=TYnd9PEVvWIHHVsIbnik9Py1bbc4pDB4ONzUXnDAHh0cZfNreEm/dJitZsL/ntiqMimcSo3UST7ADD4jYJdr9nbt/cPwFBLZSUcaAdefuKghAnmpP5Ao32kdtDx1Wi9HTCIYxQf9VISJdil7dZ3TdQpOGQNMUQpVFfuGFPyJKWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749046588; c=relaxed/simple;
	bh=s45Nk6fjf9VHPcdoRYtBMFtTbnwbLNfN+RMfRRKnrvA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=E6WIMNWM/Azsh+nzCAACQC8HFgJcxIZor9xhdIt4fBa6es1Vh9giwUcxlvcM4IZHk5cPGNPdn8slrK+QKFP2l5dYcrOtFDMraOmUFVHHcKil4EjUg5zMUjQ21z9UFz3SqPwbYoXwPd0uT3rKv/ISRsL86S0wHUhQV2YQtT5NVOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EuN2df/J; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=0ESDxtGu; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5549MbFg025539;
	Wed, 4 Jun 2025 14:16:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=pi/mGD9wAfAZchswPQb0TlQL8X+j7qQ9xQMosY9hd90=; b=
	EuN2df/JH4f6m+y9PzfGjcWTXYFI+ovfWNpXCStavnYI4HRGhHugwmPWzH7WnMgv
	/VqyxAWajDSeF3q3GCy3uslJDRj4c0MCU47Nve5M5OzCHFimjgoUuMKW7DU7Kz1O
	MdpxtosbJ540+dIhShgKe0lkFCLqXnnbziogqYxsFTBoEC15ks4tXDC6Hi4rXMbN
	xVbLsAJ9mR83hz05DTxnB2KOegH0MUnav2ZHzgOOOOdIeW5ywQXEyY750sMgQGAa
	h2461iuWNx1ScwemexawG+K3tYFjwF4ukhsm0kB5tDoVEAJoR+0aZezf3hsc8oaR
	78MILM5t3bnCMtRxkkCwoQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 471gahc62g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Jun 2025 14:16:02 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 554D9kUN040698;
	Wed, 4 Jun 2025 14:16:02 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11011049.outbound.protection.outlook.com [40.93.194.49])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46yr7b2gsu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Jun 2025 14:16:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VVHoj+s5Ko5vtLulQ1SD2044+5Elkwxql/G22OxHdjqX/v5nXKL/qLyTegUDB9iNBwaAYtDOaWRlUBGtOrO8qAaiGEWJOmvWgy9T737Cz2EIOv95+lyfjzTNcACplVShgHb2Ygaf1FOrQj+lQj08LtNg1WUNqWWtlLgIzV1kSgrOZ8/bg2o8ERMTP8xpoJXKWXyiBdgZKh8WwpPQ4FX9Iv2x4kAgcVFjpoQl8RDPcTu+EhVN/OddgwmL0ijOrIThzlsAgUILGHFxNgU6SYU/b0qDZMOy3jykoyJ4BtDSde5d/W5wgBAYrg7YTuE9TtIiTesf8ybqMXGxvPCg8/HH9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pi/mGD9wAfAZchswPQb0TlQL8X+j7qQ9xQMosY9hd90=;
 b=PSqx6EF/BMRSpm40lC1cp2h9ya6zkE0y5kYmgR/l2MFXdQnJF8gdp6QUBEMo/V4bQLyeoWRPjQA0VWrbmQ/b+SnZAJwKY0jYOJHSaVu6CtvISnzeC2AuVxGWHBrH0NRXUq+P02vIbhenNaLuN0xqkgjx7/JDLheK9Dg3ojVHq3Oi5/GVxkws43axM2Tnza3WlPtA45k7XfFdqsYOZ8P/64wZRDmoE0T6hPQxWMH5LsRFwzMaRVZnroTG4jW2y9gyiZcguY0NtVLqm8rA3dfrN7s4g1w9EoXeuz2BDCVnVOf+skIqcRFIKTz7VQ4H4oaDeqSnjih5GfQx6Lj65mXmeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pi/mGD9wAfAZchswPQb0TlQL8X+j7qQ9xQMosY9hd90=;
 b=0ESDxtGu57UQYHYExxkmTNwIpvEkl04V8rV/31aHCqd99SkB8Hk9o0swNm9KIc8M+kgaFS5eBGRH/4vmOcoCcbhqV7ZbfvfD13C/LHSFu+UD+KgVk+jNAOdxxqUgutnBXK6tWQktpJowbP195z4onR/Lz51bePIJDpuwONBvuIE=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by DS0PR10MB8175.namprd10.prod.outlook.com (2603:10b6:8:1f7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Wed, 4 Jun
 2025 14:15:57 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%2]) with mapi id 15.20.8792.034; Wed, 4 Jun 2025
 14:15:57 +0000
Message-ID: <eaf2687e-6054-4c54-9206-9dfdad56c3e9@oracle.com>
Date: Wed, 4 Jun 2025 19:45:43 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH hyperv-next v3 13/15] Drivers: hv: Support confidential
 VMBus channels
To: Roman Kisel <romank@linux.microsoft.com>, arnd@arndb.de, bp@alien8.de,
        corbet@lwn.net, dave.hansen@linux.intel.com, decui@microsoft.com,
        haiyangz@microsoft.com, hpa@zytor.com, kys@microsoft.com,
        mingo@redhat.com, mhklinux@outlook.com, tglx@linutronix.de,
        wei.liu@kernel.org, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org
Cc: apais@microsoft.com, benhill@microsoft.com, bperkins@microsoft.com,
        sunilmut@microsoft.com
References: <20250604004341.7194-1-romank@linux.microsoft.com>
 <20250604004341.7194-14-romank@linux.microsoft.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20250604004341.7194-14-romank@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KU0P306CA0028.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:16::10) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|DS0PR10MB8175:EE_
X-MS-Office365-Filtering-Correlation-Id: 213041e7-8b5c-471b-5ff6-08dda37252bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QnFaUFBZOWxFclN1K0NlREphaGV0d3o5ZDhIY2x1VnNjeWNTbVM4bG9ialI5?=
 =?utf-8?B?WXB1UFc4Y2JpaExNa0huT2paUEJZeXVjOFl5cWFNMzFzbXBKdEpzc1F2OEk0?=
 =?utf-8?B?elB6V1ZBMGhzQ2diREpveE5vT2lYd3Z4WXFneHo5WFFnVkJ1Y2EvdDVIeWRj?=
 =?utf-8?B?dW5YdS9sazlKUER4QTBROWpyZU4veXhYM0tHaitQNnpYbkd0Y2dveHRLaElT?=
 =?utf-8?B?Z3VxcTZ4akVHc0hpL1gzU3l5cEtYbGhNMmJXM3R5Q3o5d0xEMlBuZTV2ZXRK?=
 =?utf-8?B?cUk5aEVrTzMrRS9uekVmb1lFM1JqMlA3L05kdUNxOG13ZFc2Q285Nklxd3FL?=
 =?utf-8?B?QmtTWWZPK3NmN1Ivc2FsSzI4bys2TS9Mek1HdXY3RnZ5WS8zV1R0dUxGMUxy?=
 =?utf-8?B?L0JKenI4aDEwWjdZUWdLblVPTUZhd2RIdUJYQ0RzQnNaK2RUUDd4c0UxMGh1?=
 =?utf-8?B?cGhzeG5QVW96dDZVQUZISnlpbGd6Y1BMc3NjVU01WndxcXlpUldpNHNkdWZF?=
 =?utf-8?B?N0lVNUtXSTZkRUNnUnYvNkFYOGlsM1lRRnJWMHd2M0FRVmx0NVk4cjNOZzRj?=
 =?utf-8?B?VnNLYmZEY3JOOFRUK2ZlS1Y5WW02MmlUUnRtVUh2T3ZwU3NhV1M3b3MyRHg0?=
 =?utf-8?B?aW9FZG0vV3JsekdEZ0tZcXY3anFrcjVtT3NRdEZoOXdheVBOY1RvdjI2TWtR?=
 =?utf-8?B?blVkbDgyS2prOFVpTTRROSs3S1FJYjJmL0pJL0lKMEt3bVk1UUNaNmd4emNs?=
 =?utf-8?B?N1FSU0kwK2Z1ZVp1N25kM1ZFTjBUNXFGTHZGMTNGb2p1UStPSTZNMWJ4SEJN?=
 =?utf-8?B?dGptT3U1NndzTjBSM1NVWFd0QmFwZUNkWkdTbko2MWE3enZ1Uy9xM2tQWU55?=
 =?utf-8?B?RmhFWmJaUEdPWVNLcnNJTjBZV0l0ejc5cGh1M1NIVCtwWHFtY1NEcEVIZjV4?=
 =?utf-8?B?RjUxajlMbjZkRkp0UnBUcGxYNWdRUGZZODM1RFZRTm9aSUZsbTRHRVVTbTBE?=
 =?utf-8?B?TjVLOUdmcmVGb0JCdHcxYXBjM0hhekoxcGNUMFFxTWlDODhUR1RIbld2UktI?=
 =?utf-8?B?OFRUcmcwWWQzZmFvVW5pTW5ObEZpcEdWYTRUcm4vaVh6Z01qTFpiNTQ2NFJV?=
 =?utf-8?B?QWpmY0VROEp5eUNhRmdKVkpSWWNmWjNLREZ1MVRhVCtkVlFEM093R3JlQjNj?=
 =?utf-8?B?bVNKQkV3SzVHU1B2bVJMRjJQTXpJa04wdmd6ZGJTcnU3Yk5naTV4SjVqMS9H?=
 =?utf-8?B?SXlDcHpVL3pzWVZZR2FNYXRFWWRlR00rNFA0eDYreGZTRlhRTGhnZWVIb1Zs?=
 =?utf-8?B?NWw3MU5Ld3BMSDFTblI3SlFrSFRTWk8rd2JkdTd1emZkMUlRR2pKL3Z1Z0xY?=
 =?utf-8?B?eUtHQkZucE0rVlI2VUVDYnR3VzBtTmZOTTVQVzE1eFJrYVpSeXlJWENTRTJY?=
 =?utf-8?B?ZXpwNFRkOHVYTWt4RFgyK2JDcS9zdURmcHVsMEZmK2FncjNlTUhWY2ROL3Ra?=
 =?utf-8?B?ZEVwYzBFUFFZZmg1bXRUVG9DelRkT2hNVkllUkRTcGhiY1RZN0Q3TUR3UVVn?=
 =?utf-8?B?UVNLUHM3dXNQSE9HaTlFRTc4enNZUnJKQUVGdnlZUzU3N1dmU01xWGEzMjRy?=
 =?utf-8?B?cURmZlJSVWpLZHZyM1JibXptTCtKZlZmTHFTVXhsbUxUaEZyajZRZHVBeTJH?=
 =?utf-8?B?VU9MeWwxOEFiZTFyQk9ON0dMaDhsNHhkOVI1bm9GZE5RZGxGb0p2R1RZeitP?=
 =?utf-8?B?T09IQXk1RFlwOU9RWTNyU3dRSmNMWm03UWVhTjJHWDZpNUJQQVEvTk1jMnc3?=
 =?utf-8?B?ZzVoYWVYSFNYNjNjZWdIOWdUaElGQ2c4N2VBakNpQm5KVDB4bFQyNDdQTkJO?=
 =?utf-8?B?WVlwblVCSUNzU2U0dU1oUFAxQnFVR25iRmNqMFplR0xFU1d1T0lxMDIzUFd5?=
 =?utf-8?B?aXM3WVl5THEzakF6RkV1SUZWSjBqWlArQ1ZqZEwwMzhxOFp6QUpTMFROYTJ1?=
 =?utf-8?B?NENHeWM1MCtnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MUxrcGl4OGlBblhDcVJUblc4TFpuMVVkL0lnZXJQeTY4RkVlVXRFd0MvUzVa?=
 =?utf-8?B?QndNRW9STkVpQU1jUHkySFFZQTI5d1JRbFNpMjRQK0N5UndjaFdzaEh3cndy?=
 =?utf-8?B?azZEejMwWjVlMVNyankvVWczakw5V1FST0FMMFM1Z0JJNnhKVWVaa3Jyemdy?=
 =?utf-8?B?T3pTOEs2QTdtY1owUjdsdG9ldk5vSzVwcU95ZHhFK0xFaFZ0V2dlNWgxQS9J?=
 =?utf-8?B?dWhXYVFteWpoMzh6TjF0ZExVcE5VdmtORlVHODRuQ3pwbzY5N3FYZXBEODZh?=
 =?utf-8?B?RkhnMkZmRjU2Q1N2cWdQMnRVMEVRYlprYXBaZlRlNlVsZFpUTWxQR1dkWXM1?=
 =?utf-8?B?enhzZnMzMWxlUUZrYWxWSWRLbkdLbUkwUW91bDMvWjlNYkJTdFJ4djc0OUFt?=
 =?utf-8?B?dDBHY3lsRExpbk5DdzQvRjFHUEx1bCtCS0hFRHFkYWlnb2k4bmlNZ3U5THQz?=
 =?utf-8?B?SEZPTHduMjR5K1FhSjMwWjF6WmM2ckFXUmFFbVplYXBOY1BtZGpwV1JhZGZp?=
 =?utf-8?B?UGdselNYQ1pabHU4SDBDVWdhQlVNU3RJMk1KT3ZLdHdFbHM0MUNLSjE3bnlI?=
 =?utf-8?B?L2NyNi9LallKRTlNRXlHSFduVjltcFJoOTNPQWV5OFEySlNjR0NNT2FQYjUw?=
 =?utf-8?B?LzQrVGU5WlBVdzlLSnZjYlh6eEtJa3U1TElZbWIybjl5cXdZaXEwbmJ6cE4w?=
 =?utf-8?B?TCtEclR0WGVCRDBXWWR1RUN3RTY2bGd5UWplTnMwUytIYWdZY0NPSS9Lbnpr?=
 =?utf-8?B?OUkwbVMrZ0NJa3FncnFVY0ZzNWM1TXQ2VFR1U2hoMzdDQmV0ckxFUnpZQWEy?=
 =?utf-8?B?ZFNMWTQ0cENTUVJsRnh1ejJQaWhVSHhqVlNyalZiZmQrM2IzUmpkOFZJaW5N?=
 =?utf-8?B?aVIvSi9GWUQrdERiUldiZXZjTWtjL1hrc2lzakNqMDJhcU9HODhCSWFFSVRu?=
 =?utf-8?B?Unh5bzdnZTF6UUhlSEJuK3FqVFpkUDlKR3lYZHExVW5mSHhmdERtMjBJZXMy?=
 =?utf-8?B?S3pVaEtUWXFXNzlzcy9Oa1hnRGZHNndtcEZhNFJsVFBpcU5nWHhhcG5BYTlv?=
 =?utf-8?B?MjZzVFg4aitTZUl5MTN4WEJYSG9TQVZNM0RtSmQ3NzJ5QjFLSWVLMlJ2NXdW?=
 =?utf-8?B?NW0vR3BGcWwvdFdEZHZPdmEvdXhlUVVVaE1tQVh0SnpLNnVFdkNlMXhWbWNW?=
 =?utf-8?B?aTZwaGFVbXJOYmZMeklBc0ZnYkpmdVdhUnI3cC9MOTNDcUdCcHl6SWZQN0d4?=
 =?utf-8?B?RXVnMlhGN01PWUROYVpzQ3oxZHNwY2NjeCtjNVo5d3dRQmtwRlZ0RHE0dE5I?=
 =?utf-8?B?V2pJcGdnUUQ2UE5xdjVoYnlocXJsVUxEUjR6K2hqVFNxN053OGE4ZWtYVElk?=
 =?utf-8?B?TXdRT3dGaGxiMDVMdFRqanpLV3BYUDVISmNNeUx3WjloY0RCWGhqajlPV1BT?=
 =?utf-8?B?RHRtSmt5MjQ0WkZ2T2NMYmR0Z1NORUZxNWZ4STBjbHN0eWVKR2VxVDV5dzNT?=
 =?utf-8?B?SFk2MTZycFFCcGNWMXMwbTQvL3VkUHR4L0o5cStHVWhjOE1kSC96eUROeHhE?=
 =?utf-8?B?Wit2RTJ2aHpiS25GY2luNXhXZUZsaFNHUUJUY2xkb3VFVllya2FWSFdIeTJm?=
 =?utf-8?B?VnBjMmI4Q2dEcERCdllFa0xBK1M4aFcxdER2eWgvajNYM2hNTU5OY1ljS1pz?=
 =?utf-8?B?RWRXUUhXU0UxNEY0OVUySHV3NEE4dGNGeU1MS3Q5QlRCWTh3Q0daamIxajg1?=
 =?utf-8?B?ckJ0U3h4ejJ3ZzVGc0xyaGlOZDhFVDRvQTRrUmJCZmNBYWNOajdwNTU4VkVp?=
 =?utf-8?B?UG1GYUNLRFVYS0dzYjJDNjlRajJwK25QNmxUSTMwRVE2cWl4WWJoandLeDla?=
 =?utf-8?B?UzU2OEgzYlBVN0RnSVhTN21zelVHUGo2SExvSklWMEhtMFRBL0llMzloOG1a?=
 =?utf-8?B?QjNKeUg1OTNzOTJUbSt2T1hpQnFCeE5GUDJVTHdUNDNOc3A3TitjMmZ2SnI5?=
 =?utf-8?B?Mk5CMk9KcHUvZGpLQUhYNVhNaHFoSkZzUHBKcmdNQUNsZHdsdUVabjVPQ1du?=
 =?utf-8?B?QzFURDRkbUFPbGwrWk1XVHI4cUIycGs2cUpTSUlsL1lVYlgvVFV3SzArSnE0?=
 =?utf-8?B?OFduclRtT3BMdFJWdnV0bktlQ3BpNkpnY0RHRkdGeHU4TUgwRlZ6RWg5Mldz?=
 =?utf-8?B?a3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cPkYAsvwgccyr4vHqVJ3D/TP4CwVtsgpzVSLP81GDqFn74ol0qVZLJJMX8+bJjwDrScLOXEpNeOqYUnBg8QNLgoFRIx5sCTGYyCEXDvr2gBBDc17/8PgW2603v7e4C7tkhUQT7CcZgciga8ZgbTuAVuIOe183WktH5++Psz86/Zp943V+n/KSRrPxAVnP/igGFoG4aJg0fz2B7x6pKTCeHRLGo8bgQcRKJJEK4cO/i6lvh1hPFS+N16wki5Li0RlJBUq2rVilpYf7jR6IoWBiPAd0UwYDi/DOuiinK9WR6TedB0Ju/XILYWEuhQlgUC4xKEkSRt4HE5jWKwPA90EfkTywz9lfLciY2wvpmKhI0nqqnfuyldbLge1VxZu1vCLAgIiRg45olgznmcnxu8AwNgkYTJ0Mes/8ZUPlFWggRY6uWauIW6TwmdKMkFusICHur+dBIr2YQZF9lZtpvCjaKcjig1ZPnjvRjYeyFFpn4Uz4VN+yldo4jl3a762XGUMT6Os0+nTtSqQ+4as+LG/T5aS1NHAy2o8goxfF8CWca8lGrxw4AUiZdxXZEq9KZ9uPhWUi26wbRtS/KASdnFV7Rk0ohGO8fbnkS/fXuAi8mE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 213041e7-8b5c-471b-5ff6-08dda37252bd
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 14:15:56.9570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mlS9L+yOiMqIXoHS4VhSxDtLw3AGvXUdsxKObyol7oEcA02WOQ0Vt9GUQ1amTcLuV+FAy2beJ5+s3Okl+pnjkX1u+yjTZXwXVullj00VD1A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8175
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-04_03,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506040109
X-Authority-Analysis: v=2.4 cv=aqqyCTZV c=1 sm=1 tr=0 ts=68405522 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=yMhMjlubAAAA:8 a=B_lyg1YCA3zTvVKZH2oA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13206
X-Proofpoint-GUID: KpShytlLp-cSGLmsVGsnvPftgMkpsrz1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA0MDEwOSBTYWx0ZWRfX51hypwbPCxD7 5jrk9Jfe97KZBnGUh6mo0jSP8RIVA3PrO08enuy0BZDXqvp8MnDA1IgbYA/I2Itffq+yvMIrQGq tDmcXjW2uyUjIcne0Sp+y2h8bOBhsGSQYu9H1WhdowXs8gP8RNnsuN+hSQrkHmu2rr2KCWDYpyj
 vn+m8DEkX+MWRHp05GXYOJZPnYnIqbi6vkjJ6Xfl0HP71aZ1XuBTJK7YuWVV8z1zndavEPiDW5i bRireissLP/H4W2NTm6pcDsmMUMU9f6lTFR8loO6zNn39wRAGagNZHQvNJNEYPK/lqv6uyVcNRS W7EEIWlyK4bxBrEr9iC662Ni1TPLYFq2HdsfACWht+nyLHCShbZzjX96bBvAaXyOW8OpS5cvvnD
 jOmD6Ra9eH2+6r5/02fUC1zolTN4E1iTGLIcLPVeBWECqv4DSsepAsDCEdLH4ua08/VelKJP
X-Proofpoint-ORIG-GUID: KpShytlLp-cSGLmsVGsnvPftgMkpsrz1



On 04-06-2025 06:13, Roman Kisel wrote:
> To run a confidential VMBus channels, one has to initialize the
> co_ring_buffers and co_external_memory fields of the channel
> structure.
> 
> Advertise support upon negoatiating the version and compute
> values for those fields and initialize them.
> 
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> ---
>   drivers/hv/channel_mgmt.c | 19 +++++++++++++++++++
>   drivers/hv/connection.c   |  3 +++
>   2 files changed, 22 insertions(+)
> 
> diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
> index ca2fe10c110a..33bc29e826bd 100644
> --- a/drivers/hv/channel_mgmt.c
> +++ b/drivers/hv/channel_mgmt.c
> @@ -1021,6 +1021,7 @@ static void vmbus_onoffer(struct vmbus_channel_message_header *hdr)
>   	struct vmbus_channel_offer_channel *offer;
>   	struct vmbus_channel *oldchannel, *newchannel;
>   	size_t offer_sz;
> +	bool co_ring_buffer, co_external_memory;
>   
>   	offer = (struct vmbus_channel_offer_channel *)hdr;
>   
> @@ -1033,6 +1034,22 @@ static void vmbus_onoffer(struct vmbus_channel_message_header *hdr)
>   		return;
>   	}
>   
> +	co_ring_buffer = is_co_ring_buffer(offer);
> +	if (co_ring_buffer) {
> +		if (vmbus_proto_version < VERSION_WIN10_V6_0 || !vmbus_is_confidential()) {
> +			atomic_dec(&vmbus_connection.offer_in_progress);
> +			return;
> +		}
> +	}
> +
> +	co_external_memory = is_co_external_memory(offer);
> +	if (is_co_external_memory(offer)) {

  Redundant call for is_co_external_memory()
  if(co_external_memory)

> +		if (vmbus_proto_version < VERSION_WIN10_V6_0 || !vmbus_is_confidential()) {
> +			atomic_dec(&vmbus_connection.offer_in_progress);
> +			return;
> +		}
> +	}
> +
>   	oldchannel = find_primary_channel_by_offer(offer);
>   
>   	if (oldchannel != NULL) {
> @@ -1111,6 +1128,8 @@ static void vmbus_onoffer(struct vmbus_channel_message_header *hdr)
>   		pr_err("Unable to allocate channel object\n");
>   		return;
>   	}
> +	newchannel->co_ring_buffer = co_ring_buffer;
> +	newchannel->co_external_memory = co_external_memory;
>   
>   	vmbus_setup_channel_state(newchannel, offer);
>   
> diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
> index be490c598785..eeb472019d69 100644
> --- a/drivers/hv/connection.c
> +++ b/drivers/hv/connection.c
> @@ -105,6 +105,9 @@ int vmbus_negotiate_version(struct vmbus_channel_msginfo *msginfo, u32 version)
>   		vmbus_connection.msg_conn_id = VMBUS_MESSAGE_CONNECTION_ID;
>   	}
>   
> +	if (vmbus_is_confidential() && version >= VERSION_WIN10_V6_0)
> +		msg->feature_flags = VMBUS_FEATURE_FLAG_CONFIDENTIAL_CHANNELS;
> +
>   	/*
>   	 * shared_gpa_boundary is zero in non-SNP VMs, so it's safe to always
>   	 * bitwise OR it


Thanks,
Alok

