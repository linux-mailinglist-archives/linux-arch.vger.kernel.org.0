Return-Path: <linux-arch+bounces-12212-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F32ACDF05
	for <lists+linux-arch@lfdr.de>; Wed,  4 Jun 2025 15:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E48F83A28D0
	for <lists+linux-arch@lfdr.de>; Wed,  4 Jun 2025 13:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23BE928D8C5;
	Wed,  4 Jun 2025 13:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lAD/l9AH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="y8F7fONB"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657471EF395;
	Wed,  4 Jun 2025 13:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749043661; cv=fail; b=Olo85WZH5eBwHviGwvL+A3MvbWf31gltXzv1NDlf+7LWO6MeZ4wNuXlTgI2ootS2racKQYGHMN1+O7r0WmQWm7AlXF0x0PIJqsVdYnBIjGqsW2AF/7gxrxgX2DC9feaZzcZA0VttGhMOUlqLNp1lG1Cgc1DWJBTHt1tkZoWMhIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749043661; c=relaxed/simple;
	bh=MTWzCjeb2EBNsZ7Ge9jNmNrSM2dgfR10T7vo1OUGH8o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JaTE/LzpGkgs/WfFv9+L/UsSZFsXYyt/u9cj0Acl1MaWFkngeYxytf2FeXocoqBd2F/qLDUbgnrJDERQarXhs7kF78PRTBTxoTkA5j/hoMJJaEgPJLhSaOASQcVMJPxsBZ5AMT/8F09vbeSMs51buc5YUdwVvujB5mzhA30uBxg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lAD/l9AH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=y8F7fONB; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5549Mlkt022279;
	Wed, 4 Jun 2025 13:27:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=OTk0DMsBEWC3p/eRAAl0IhIB1PvqTB2ZPNq2xib/y1k=; b=
	lAD/l9AHGDW6N4s5ZswETKcH/UFqfybEpgSZKeLypbjA91FLMS6nu7PqY+znPX1w
	/mUr5cvW0uclSMz3pGv28h6nOM3aPIxV4ZUGCQofwi0NvHmEMLv7kGzJU/qhTAeT
	wk50yCLxh+M411issKeEjrg/nCAWQfr4bP+ousx36EIVTSKPx7rkY9EUquuOF5al
	qt1Mheou6BQJx6a6jbH4NC9hE6EL/qwVp8achi4lU1C+hrmM4xYXnTHiZRWFtH7/
	pbD5LFLlzyiaQ3hgE/2rTd4qLr+EAkjRi78mx/Zz4oy9lZO7lCA5rjDw2LcN/Bdk
	TJdkrVrARfKPEwEhrpPvMQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 471g8dv15d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Jun 2025 13:27:17 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 554Bq9EC030680;
	Wed, 4 Jun 2025 13:27:16 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46yr7arr36-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Jun 2025 13:27:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bo6etuTU0L6I6VTwL82ba/51E+3AgM33fgF0ZTCn97K6JZZ/Cl0rf+6DAsjpsCZ7PUsBDQ0Ds37360iCehMD/lwZHcXx/o0sb0f0E/OaJVtBqkHUPkhhC3XAC8hdqXdqeKZgh15BQKM7zBKru7IPxlCrQNiBYoD6wt8GeipDjcb3MsyPX5kqLreohfjAhypGe22iuCmqZKeaTTX8vYHCCZ27glno8pzl0bMZUo3cQrRHWya/wM6ijrcBnqk8IrG4Xkuib4A+PGe0VdJYR9fSEVoMYlm4eq9cJKfern2UWmtLKNJIDO03tY87zg7Udck54iSpRLzZP9NlgcVPabOZiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OTk0DMsBEWC3p/eRAAl0IhIB1PvqTB2ZPNq2xib/y1k=;
 b=Ctxnc/xps/PQzCD/HtZkDsN3Krvq5Z0vPW9XMewpxE3BIL8w3Bl3PmX3lbBwUlx2/44jBJGmYA8uh2dsNJC+/ajljKQu4FS1+VvB87T8cVnGN3PsESNRh0HXrcy1I4CXg5LLZ76uVZemtUHmkVp3aIfkifcg5no9L/ZcU6g1csC5+J6aJ0o2mVSmOgYvCtyJveS5A1hH6N3HCoLugcE3226GyRNDp5ucn4zpoio9QNbaKk5HezV77xzF28WDt3sBwalkUyOyk8mWj0HMd0se2axO5+fIBDsXrDybR91bBpv2DD3JGMwYOsLZkfx+iYZrVIYmfvULuBHUXnN45mOH6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OTk0DMsBEWC3p/eRAAl0IhIB1PvqTB2ZPNq2xib/y1k=;
 b=y8F7fONB0UNQ22RHF7l6Cd03u8F6yKbZWw1OZG5qW3iyajTILBst/Eg+8HSgGgGCJt+rcbK+T8ED4w4bi2tcrdlCp6TBV56TdhA0+hkZ9oh7gQicKgImBdPGlPq1olRAfXsUuKUxCiU8WsigtJkJn6MzmEWpjgumhzC55SWS6pQ=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by PH0PR10MB4678.namprd10.prod.outlook.com (2603:10b6:510:3b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Wed, 4 Jun
 2025 13:27:13 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%2]) with mapi id 15.20.8792.034; Wed, 4 Jun 2025
 13:27:13 +0000
Message-ID: <9c5c6a6b-421b-4f26-b3a2-1e10bc3badd1@oracle.com>
Date: Wed, 4 Jun 2025 18:57:01 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH hyperv-next v3 03/15] arch: hyperv: Get/set SynIC
 synth.registers via paravisor
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
 <20250604004341.7194-4-romank@linux.microsoft.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20250604004341.7194-4-romank@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0016.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::17) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|PH0PR10MB4678:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f195b7e-a1f9-4735-2a58-08dda36b8455
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ek5HVzF5cnlIejRFclV5MkZOQndhL0hJdWNmMGVVamZnaFJOYm10VzBXSTgy?=
 =?utf-8?B?Z2RRTXYvcHFCVzJic1NtUGFQdWxvdnlEaExxWnN4Sit5SW5KYlBzOEJCYkRy?=
 =?utf-8?B?RVhBNTZCT3RFYkk1L1FsMGo1a2pNSUJrU2lPL2E1aVNNcFJxc0hNTVpjdFZp?=
 =?utf-8?B?RUcwUmZ5K2pzeE9QdTY2bk1KdVQzN0pkM0RzeGVpVVdVdlRUakYyc3pYRjl6?=
 =?utf-8?B?dkFqaFB1elpvNW85ODd0WDJReHpMVmxWTmtFZ1BubG0wR1htSGZUT21kOTM2?=
 =?utf-8?B?bnI0K291WXMxZmQ5eGd0SGFHTExBY2NudGxoKzhXNlhuWm9EeUxLbUVUV0gy?=
 =?utf-8?B?LzNscElPb1VWblJ5czRzWkk1QUh6NU9iQWlZUEp0eDU2N0ZYVngrdnIvQ3lU?=
 =?utf-8?B?a0wzRGNnMFFvdVlRZ3ltYnBPbEh3SEUyc2gyS1d6ZndCRWd1Y2J4UTB0R0tV?=
 =?utf-8?B?bHc4V0JGc0hmWDVPVlBTbHdOeDcrMzRPT29XY0wycloweW1qbldTYk15VTZl?=
 =?utf-8?B?TjNuMVQ5VWk3bjJGTGVqUktrajgxQXhxUDd3Q0lqRjVHTGhIN3lrOGFGc1hp?=
 =?utf-8?B?MGpabmsyZFlTSkhydXdCYmwvODJGZ1NlRHlmVTdsNWlPbzZ3Q2FXUjhFcmxN?=
 =?utf-8?B?QUpIdFRQdXh6MTNTbWhWZjJ6MHk3c2VjZ3BWWDVPL1oyRXYxOWxiaGVKbStx?=
 =?utf-8?B?OGh6NGVRem5oTjFQUk9wYVR4SndvSHVCMXhCenVNdWFRQXlObGgvZHpkSmJo?=
 =?utf-8?B?ZVpFMVRxdEZ4SFVJTjBmT2lZNkJMMlJWVFVhaWRmd0orNVNMWmZFcmRnTHRR?=
 =?utf-8?B?c0hqLzNycDNKYnVMUlE4ODlsUXVtOWR1eDVSTCtWQ3BLNndDMzFXLzgrVXlF?=
 =?utf-8?B?clNmNzR0V1dJVzFRdnZVVHFLQ2I0QzhXc3VRSElYTnJPM0U3WjM1VjBlQm4w?=
 =?utf-8?B?QjdyVnFLaW12a1JxWlVsNlRGWVV2Y0FxdUt4OVlJNVcrd2grNkZlWVQvMFA0?=
 =?utf-8?B?c1cvVlpCZ2NRSlVVeHpBMDh5d2ZnNElBNGF5MWIzTnB4Wm1XYlhsekVpVGxw?=
 =?utf-8?B?M2EvZHU3VFVLT0lVeXFFMnZNN3JtS2tHcEFpaWRSRW1IcGF5QXVOR3o3S2cw?=
 =?utf-8?B?VjArMElUM2FnLzRtQ0Fyajl5MDkzWXlIS2VzTkJJK1JjQUp0cjJQUjJhZDlx?=
 =?utf-8?B?Sk5USXJjNlZZV3JtcmJiMXB0Q0hMZ0JnNXR0Z3ZUWHhUUmdkRENwTHZ3aE5v?=
 =?utf-8?B?a2lMWHpOMEdzcjlJSlRyaG4zMW1HRlZwQlhqL1g4c1l5NWdnblZteUFvcXdy?=
 =?utf-8?B?eFpDaEtOU2FvdU4zZ09SejB6cE5uRzJ5eTgxYittVkhwZWFtQlV0WVBMYkFH?=
 =?utf-8?B?Ylp0S3lrbWF1djh6NVBpcmh3L2VnbUtTTHl3Y3NjbTljaVhuSkhWUXQ2cE5l?=
 =?utf-8?B?d1hUZlluQVlPRGdRS09HbEJBM3hIWktJS1RsL1FNYytkRFJrTXd0Q0EwTVhC?=
 =?utf-8?B?QnBFQjVWRktqMUttR2VlbytTSGxCREU0bC9pc1gwb21saHExdllLTWtTM2l2?=
 =?utf-8?B?bDdLT21GbnJpeGVUcmFMWnpObUh2ZGo3azJyRGFkNjhkNEpMeWdiZ2d3VXIy?=
 =?utf-8?B?MkloS2szMExjd29JMG1TcEFaYTlHTFY2RG8zVnVBV3FxVWhRQklTanArbWJn?=
 =?utf-8?B?RCtrc1FVdmdpeVJ5Rjlpd3NVbUZ6MG9DejRxQ0dBNngzekRlSGpWWHlPZnd6?=
 =?utf-8?B?QjhMekhxRHdGd2plL1lTNkpDeG9ibnM3eVZ0aEEvb2h4YTQrQ1BwSUl6YUEx?=
 =?utf-8?B?V0JRcWd5dVNzdjI4c1k0V1V4MGdvOENlTjNXVTVmUmZxb0lqSy9GaEpMYzFW?=
 =?utf-8?B?cVRjdWsveXFUNWZ2eXpsSU5KZzlodWtNWGRPdHY5NzNkeVRXNVdBRE93WVRj?=
 =?utf-8?B?Wmh2Qlk0eFVLN0FiYnJ5a2xrT1h5bGtsK1pjbE5jQ3g4Nkx1TU1HNDkzdE1q?=
 =?utf-8?B?a0ExejNtRXJnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VnNGK29jREhoZFQ0M1RSWlVjWjFnZHNaQUR5T2hvUkN4TVdEd3lXazlDdE5H?=
 =?utf-8?B?TlB6OXZPOFIvS1B3ZGdYVlJwUHFRMi83ci8xMjE0MzhXaVpFNzFOQytvU2Fu?=
 =?utf-8?B?MHkvLzU3RUUvSERSU3BkaGFhRUcwWlhDa0hpV1RpL1haWURuM2FheDY2b1Na?=
 =?utf-8?B?Wi85VkFGeWFwY2RES3g3QkR6ZXRIMzQ0WFpCZWxLdWFpWExTektndnNjU1dX?=
 =?utf-8?B?dUE4RnJXZDZySlBadTJtamZOZUZtaGluandsZC8vMW4wbDNTZlRCd3JlUSts?=
 =?utf-8?B?MXA5MTJTbDIvelk4V2NFdXNsa0NvTng1bUxVd09xRTZwMlVwT3FHWVFPUEVI?=
 =?utf-8?B?TE4vSmM3bjRBWjk1MGp0NU8vdWZ2NzVwZ1d5alg3ODViM2pPSHYwK25BSEU5?=
 =?utf-8?B?V3V4bjRUTTJoVGJHWUZFQ2t4R2dLdDdZQy9kUWN5b1U4Q1NCQUVjQTJWWTZS?=
 =?utf-8?B?MkswWG14WGNDTUl2NHV0aUxjYnNtaG4zWUNOb3hxd2psQi9mOFRaQXhnakN2?=
 =?utf-8?B?NjhlSzZuL25GQ3ZuTzB1WnR3eDZzbGJKSTNjWTVNRjV0aWFlV1V3OXRTZWtD?=
 =?utf-8?B?dkFncnJqK1ROL0gwRC9wQ2Rxb0xaSDVuRU1CSW9xckxDZVFJUnRDbWNUUmVR?=
 =?utf-8?B?djNSdTg5Nm9LL0FLa0Nkcm84empUQzVKMmFtelJnaGpXYW1pRjRoUlhlcXJo?=
 =?utf-8?B?WWMzbGxHaVhpTFhUNm1QT0gxa0hkanVwWUlrMUorcEdQaFYyMFB2dzExc3pK?=
 =?utf-8?B?M21FQjZnU012elRLOFBQREJTaEFHSks2MGhLZk4vMG9vYkVjQURjN1N6eUIr?=
 =?utf-8?B?ZGN3bUhNc3RvcVk3aWtSOHJxTVNCZUViSnh3b2ZBWENoakJHSzhxbDVrclhq?=
 =?utf-8?B?ZHhzRk5mcnR4a0ZESzJ5YXhBUmlmcGZRbzN4VnNBclY0NmRTbmF3YU4zc2Vh?=
 =?utf-8?B?NmZ3TXZxZDZnWXF0K3BUMlk2VzRyS3RmSE00OVV0aEVGcTZsQzVkTlVvQ2Z3?=
 =?utf-8?B?bFIrdCtaTzl3TTNTOXgrMmorRG13aG1Wc3VyY2ZJcVRsUG96SURKUWtiZ1lq?=
 =?utf-8?B?c0JzeHRyazA0aTVsWGJ3N1hTUlg1KzNGUHNSOXpLOHR3NUVqeEZ2VXZ4bGxy?=
 =?utf-8?B?bEE5S3N1VWpZYmlzeTNXRW9hQXZma3RXcGpoc25ZNndCeDRJaEwwdFg4ZWha?=
 =?utf-8?B?czdQbWIvT0ZWMS9VMTAyeXpUck9ONkkvWHlIeURNSUZsUnJjV2JUYi9DVG1P?=
 =?utf-8?B?UXppN3RhREtkUXQwbzB6SmNjaDAreWFZeHFLdUNYNlYyRktYL0w1Z01vNHg2?=
 =?utf-8?B?ZWVmYUt1L2QxVnhFZGhKaEk5RFlYcUdiSHZjU3FhRUNVcUtucUVRU2lIQWFm?=
 =?utf-8?B?UVowT0xDNndiMU5aemFHc1dqeUh0eloxci96MWFZbnFwVE15SDZhRndrV3ZL?=
 =?utf-8?B?WVJqbXd6TDNGL3NtdjlxRnVYdC9nSkVoeWFZTi8rNlE4Nk5KdTI3Q1ZwTGtj?=
 =?utf-8?B?QjF1a0FmZWVGSG92NnMrNjJPY3F4OHhYZEZHbFFXRTNhakxHUEQwMUZ1SDhQ?=
 =?utf-8?B?azJvWFJQaGtoTGRRT2MxeWViRm1Edmduc3lQSVgydlZtOUxwa0hrMjNjeXpC?=
 =?utf-8?B?V1FkSEtXUWMzNm1RaThLM3hwd0ZlRWdqZlI4ZXY4NWpJUTl4Q3hvSlpLczNP?=
 =?utf-8?B?Zk11d3NHdVV0Y1l1ZUlPYWF0dm9ZaTJOcFl4MGp1TW5OQjVXNXdDSWp6djkv?=
 =?utf-8?B?OG9zWDBDMWJ3WEtkL0Z5NVFITFdUTloxK0FoRmxPdmZtUzdOV1ZqUmJ2cnRZ?=
 =?utf-8?B?MGtjczZzdzdKZndKMmVxTVBhaWtOcHlaVUlqQnFZZ0dVN2Q4Wjd6aHZnSW9K?=
 =?utf-8?B?VkxHZVhvTXRlMXVpaUxrbHRrQW9aNllubDVBWDdPZE10WkxEYkxJNHRyQmIr?=
 =?utf-8?B?d0s2YVQyYnRGdnA0cXg0WmxiSU9RdlhEMkpDN1ZUdEEvRy9sdEovUHNRdFpI?=
 =?utf-8?B?b01ybVpxbVFIYXM3cVh6VHBQQVcwZk8vS1Y5eVhQWU81bisrbkJSbFMweGkx?=
 =?utf-8?B?U3dZOWx2eHNaa1dkK2lrYXhRa05mdm1YZS9ja0o0OFBocDBtR01LT1MrQUhk?=
 =?utf-8?B?c085SjREdFJoSFlmcXB6WmRzK0gxU2FTVUpTbFVDdUdkcXJocVgxcFlFSEVt?=
 =?utf-8?B?eWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZdWU7UrDuVj0uMB1cJXKj+RcRtskbqWOz2nmVrl1HtrRqLB225FtHBOpRsrWvt8+Av7qYcWVHB4nc+tDLsC5qAAWUmdPCGbi+XaTmhI0WD8iMlVrgYLJekMaz4VZsRuCmxv5b2AoVWFK+Qm33oYZgGaY1d/jHzh4FnCpwH2LwGCsbi0bRkE2dO0gCBsiXs0HNOzZzop3i/C6tDVeGeQV7mqqJ6/c/OC9ED7h9QLdwYEODIAhSIw1IcotIs+pCsuc+yOITlDRE4i+GZVkSqlRvwnIourUGDuovXH0Ev700BsO2cbB0nGbn9h4N9DfGN1or2K4rpOk/nqsCoDfmbs8mx6PfuhMq0TLhGPWADn2fCwfI88V+ZYJbdseen8OsURhqXUcUuSOGvaUxAsjVckni/+wm059tj8W2Ks8R4I93P3Zt3q6DnnuyybXtDP6e4BTj3cb6ROYca1YZFVeERu0228og2g+OXAh5QaCEHZkBr2rHzWufV862fhgsPSvRjWUEn0H1jIgBgryGmVOKWlVyou7Y9MlvfofgdTgJn+YsqZuYUR6niLMdp2ptS+5MZjJ2m7S3jjcm5bFkAxu0AJwgEXXB0745JzJAqaPfJjatO8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f195b7e-a1f9-4735-2a58-08dda36b8455
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 13:27:13.6519
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: szhh1p28Nq4CLrvzCmzGRLr+NTgjw9ZV+KcS5ad5QzMWy/MkFsD228TslTRSDAkQod8LMldD4W3FWbr9sApnZUFunED8ZLlWaprH2d1oz0Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4678
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-04_03,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506040102
X-Authority-Analysis: v=2.4 cv=Va/3PEp9 c=1 sm=1 tr=0 ts=684049b5 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=yMhMjlubAAAA:8 a=yPCof4ZbAAAA:8 a=cTZmTnUJb99XY8YRqt0A:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:14714
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA0MDEwMiBTYWx0ZWRfXzB9TTv92c4ej ZjEC9+MUXDNst+doTgVUAE/1nJbkvyllU+5J415jQ8W/XZ+yUA88hnTbFcZFQxKu1cyFXFHQbSt ydQ6XTetPq+4wq80bTJfVU/VQ3lOCjw+37xPKCPtvWLf52CqqOXRjZsaTwHxGPOIVjKdjVzAIBC
 WznuWJZKKV2Fb7S08wAJw1GYPKkQs/MagG1q2nj6w6NmnbqDJ+A8hyAV2KNsHfsV/l2JaaxLops 1wvajS1uD6X7dthnjKzgUejnxuvTDMWM/6UgIcYeVnkHJ3YFuevpvI5eXS+1uh3DhuUVghr2zLI 7l9Q4448bfzTw45UgaxQAVBQhwPA9We/ZPk8aeihA4voysQTTHGVxJ6CCc3L2h0d0QhJU4c8o0W
 wnfDOiiMeGYDNuPdwzgUEJKn5y0aRSEjDjCYHOeNWO/YfTn5N8xn1uETq+JiKxQIOXud6sg/
X-Proofpoint-ORIG-GUID: io5Y2l4-ft8-MuTc_Io2M6hRm4qrv8Ky
X-Proofpoint-GUID: io5Y2l4-ft8-MuTc_Io2M6hRm4qrv8Ky



On 04-06-2025 06:13, Roman Kisel wrote:
> The confidential VMBus is built on the guest talking to the
> paravisor only.
> 
> Provide functions that allow manipulating the SynIC registers
> via paravisor. No functional changes.
> 
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> Reviewed-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> ---
>   arch/x86/kernel/cpu/mshyperv.c | 44 ++++++++++++++++++++++++++++++++++
>   drivers/hv/hv_common.c         | 13 ++++++++++
>   include/asm-generic/mshyperv.h |  2 ++
>   3 files changed, 59 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> index 3e2533954675..83a85d94bcb3 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -89,6 +89,50 @@ void hv_set_non_nested_msr(unsigned int reg, u64 value)
>   }
>   EXPORT_SYMBOL_GPL(hv_set_non_nested_msr);
>   
> +/*
> + * Attempt to get the SynIC register value from the paravisor.
> + *
> + * Not all paravisors support reading SynIC registers, so this function
> + * may fail. The register for the SynIC of the running CPU is accessed.
> + *
> + * Writes the SynIC register value into the memory pointed by val,
> + * and ~0ULL is on failure.
> + *
> + * Returns -ENODEV if the MSR is not a SynIC register, or another error
> + * code if getting the MSR fails (meaning the paravisor doesn't support
> + * relaying VMBus comminucations).

comminucations -> communications

> + */
> +int hv_para_get_synic_register(unsigned int reg, u64 *val)
> +{
> +	u64 reg_val = ~0ULL;
> +	int err = -ENODEV;
> +
> +	if (hv_is_synic_msr(reg))
> +		reg_val = native_read_msr_safe(reg, &err);
> +	*val = reg_val;
> +
> +	return err;
> +}
> +
> +/*
> + * Attempt to set the SynIC register value with the paravisor.
> + *
> + * Not all paravisors support reading SynIC registers, so this function
> + * may fail. The register for the SynIC of the running CPU is accessed.

you are writing, not reading. ?
-> "Not all paravisors support writing SynIC registers"

> + *
> + * Sets the register to the value supplied.
> + *
> + * Returns: -ENODEV if the MSR is not a SynIC register, or another error
> + * code if writing to the MSR fails (meaning the paravisor doesn't support
> + * relaying VMBus comminucations).
> + */
> +int hv_para_set_synic_register(unsigned int reg, u64 val)
> +{
> +	if (!hv_is_synic_msr(reg))
> +		return -ENODEV;
> +	return wrmsrl_safe(reg, val);
> +}


Thanks,
Alok

