Return-Path: <linux-arch+bounces-12214-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF6EACDF96
	for <lists+linux-arch@lfdr.de>; Wed,  4 Jun 2025 15:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DBFC1898CCD
	for <lists+linux-arch@lfdr.de>; Wed,  4 Jun 2025 13:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE1028FABB;
	Wed,  4 Jun 2025 13:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="atyKTxlk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OMrVyR+8"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA1928EA7C;
	Wed,  4 Jun 2025 13:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749044965; cv=fail; b=h1Fjl8POkLcY4Ui++f9Uxygvfc7mPhMeyjFybB0T0sl1wT90EGW0GrskFnoEB4jcBYyezG3muGwRzEArTZrf3ZtcIy1i/Ymfje4K5n+SncP24mKLllSfMCvhGcFWx05jWRI3lup6huROoUYrBLLAKX8mH3CwUpdYux09wgHXcPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749044965; c=relaxed/simple;
	bh=QeYI8+YqRlGS8F2NytZyNF3SdNbjyc7d746fCWvp/oY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lX6pJCQw5D8/Vt17w9HteMBsVp2IZ2WTxodUXqqVW7ysyhaqrfDsguYkuuCJWzwZvbSyhjndISyGGDF74ug79m1IzMKJZzVD7CXatXrIpYbhkburCjq3pc7wtXITTzu1qWN7LavfZA8b6CYRh4zS66eTicp1BI0dwi6ncOjqI4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=atyKTxlk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OMrVyR+8; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5549MfZJ024864;
	Wed, 4 Jun 2025 13:48:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=JzLN8ERhIIMUcbmvCmQMGONo2NxbGDNELxkWjZRrBpw=; b=
	atyKTxlksTbCBib3jWURiGbOaZ87cCcOG3p/pb7lt60gV2C24qNDD4oE/x7cVlKW
	EtqGR8wUpCRe1q9OPBJ0G8K7XdRBFIaDsMmSHszF/M0lQ3/uDWuOFq8hKcZLv3xf
	F/06kKcJgtQuiel6MeuqPerhtsgLk4cEsJxVSyAJw5YCnSk+nvX2Z+VBxxkEHlVW
	6PSp6hJusTICBwLUZnbtAxLIfTw6Bgxe/gr+c38Z2e7jrPBPGmOVyIbF6bTTeh63
	QNqdTxqtt8ou7j2TBWfA066gRmmGnXE4gUHrHfKyocL8VLRSIkljNYqT8ID2Womy
	XU809UDxgBmadg5/W3eR9w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 471g8gc0s6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Jun 2025 13:48:58 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 554DPgsO040853;
	Wed, 4 Jun 2025 13:48:58 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02on2071.outbound.protection.outlook.com [40.107.96.71])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46yr7b1ejh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Jun 2025 13:48:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PfCNEY5P6QQfbScg5IvxfYJorSyYe8f2HtNQ5nzFDXRBU5+IIEeASJeHCR6TA3MlsCLYejOof/tNngLSjFnzH+IjMi3+5RLMpX3n6hfwXLe1yogm600Wp1ezpRrpekvFalBUiblit2Hwc3pKcJKb8xXbrc8UBU/rf9ZQLkaRrcgxar3DeqIGoBGKN4KudGBJ+XurzbVp2aAoFRr+9L948UxURoHe1iyuBiKdaw/Xx+eoiywKwbRQfUT9Ic4XYelanVZjlkBpi3AreMUHQ90mg4OLCFtXL+XETXzgLF2mjPR74sEmpM/wsjdhqjB+DZH4qfhyp41VRfLsUnpVt0G1Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JzLN8ERhIIMUcbmvCmQMGONo2NxbGDNELxkWjZRrBpw=;
 b=W1iU5SS/IDmT2Nepm3g3yZLc6z+/6htO9wVknHobIy983IkVs60Rr/vJjOX/ythxmNBiXNYgIk/vgIJWmHK2g6uRfJq9QwLhPzmheOuY1cbYu1Rsv/luGttHr3LDg6oVb4mvyvJJAzbNOC8va3+C0lwkeSelOreyQc0LtgT9wQTNiITBKSE09lcyi+23nxTIgH73olCQ2jUt106VnRjqk9PrrSozz+dqyeS9pgyb3L3XwMkGTDEnBn6z4pZg5ghigTO/EaUNDJLuTr4AzLX8xuRltOfiXp13MjNL5mFuHpt1KKLWb0jsFjl3NIz95l7HKCHp8HxTRYVzWhVjkZs2Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JzLN8ERhIIMUcbmvCmQMGONo2NxbGDNELxkWjZRrBpw=;
 b=OMrVyR+8ynhvRRPVVinZnVmnxD9NtQjQKjmJVOIj1FLWii1cm1oEb6MrbzK5eP1eAHu9uBM3y2WtnnfD6UKM/WX/RA5no4+1AYuIeh1z4p+Y6P1ZvJh1GiH6EcVemMDlAYfu3lnZSCCRvEQSPHXLMDgxcY/N3ghFJ+LX2vaUD+o=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by IA3PR10MB7994.namprd10.prod.outlook.com (2603:10b6:208:50b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.41; Wed, 4 Jun
 2025 13:48:54 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%2]) with mapi id 15.20.8792.034; Wed, 4 Jun 2025
 13:48:54 +0000
Message-ID: <2838094e-815b-4b98-8787-65ab0180acd3@oracle.com>
Date: Wed, 4 Jun 2025 19:18:40 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH hyperv-next v3 07/15] Drivers: hv: Post messages via the
 confidential VMBus if available
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
 <20250604004341.7194-8-romank@linux.microsoft.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20250604004341.7194-8-romank@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KU0P306CA0040.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:29::7) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|IA3PR10MB7994:EE_
X-MS-Office365-Filtering-Correlation-Id: ef42d98d-0655-47c6-3875-08dda36e8b54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RVEyNmliajdjKzNybEZXcFBlcndpU1I1cmtRUnJ2UG83UWgySmdnS1ZNbzE5?=
 =?utf-8?B?Q2x3RVN5OERUbmlJWFE1MmlzbW1aemdhYTFseGU5ZjVDemZUbC8zN2Jqc3RG?=
 =?utf-8?B?MTJLeDRSTWtTUHl5MlI4RGlPbEtIZUhySUYyZmlMZ2NxKzFPOTBHTHEwRXFK?=
 =?utf-8?B?L0dmSlVkN1dJVXBJc255Um5WWEcrM3pzOVNuVUpCZ1BYQzI0OXNLUTAzdHBx?=
 =?utf-8?B?NmkvT28vMTI0VDllV2t5ak1tQ3BGK3Yzc2xVQ2tqRVkwVTZFSG1ESmt0S243?=
 =?utf-8?B?c2RBbkd2c1NGRXoxWURFTzVFbnFadFFCQk9JWkNCTjgyTjlmSSs1dWo5MXMz?=
 =?utf-8?B?Mmd3SXZzQ2JFMG13TmxWMXpMdDNMZ1FLQ0w5eEp3K1JSRjRPSTB4SHJNbnlK?=
 =?utf-8?B?MGNjSWFDU2tFbG43UnBCVVMrenh5TEt5WmdwbFk1dVBhemxPSzU4VDBJYmJN?=
 =?utf-8?B?aGMzU1dOaXIySE5CWWczQWRLZDlPL3V5V3ZORU5HekppWEpHM01mSHJjMXNr?=
 =?utf-8?B?b2tiN2V3K2xTNEJTRUJYNWxwZ3B4ZDJwVlRQQXlHN3RsYTVyd2NXZ3RLOW1o?=
 =?utf-8?B?VTFHbm1lUXNUUmhPTElXckFrM0hOZGp4SmFjMi9SZGV2WWlKcWo3S20rNGRN?=
 =?utf-8?B?V3pNSEtwV1NNYW45MVZLWkM5aHpYTFUwMmtuRTNFZnNXcFphNzJ6VTJwTmEr?=
 =?utf-8?B?MHAwU3NCaXd0S1ZIbzhzVVJDeFJhWFVIY1hTZzVpQzVsMmp0SmRuUFo0Rm1P?=
 =?utf-8?B?NFlTSlN6eExTM2Zia0tRNmJLWFhkZHZ1M1Zob2xsY285WGhqWC85NW1oRm9B?=
 =?utf-8?B?SWg1dDMyZXBPQ3IraFZKanRTelRSdGtSTVZpTHFCbGxaSFQxY2Q0K3Z4eUxH?=
 =?utf-8?B?NU9Gc2dmUHNvSWwwaGlscjNWdGZrOHd2bFBNOWdUVmQ4WlZWSXNqZWFWNjJB?=
 =?utf-8?B?Q21zbjlHdHhyZzJkNGZmamY3b1pYbjhPZmRMMTdVRkI2d3J5RUJ0bXJnb2d5?=
 =?utf-8?B?NCtBaEl2bGZ0VW5FM0NyMXBBVjcrck1nR0o0RVp5c2ZuVnRCSUlDY0lGVlFk?=
 =?utf-8?B?M0luQ2FCeGpwTDVmWmVobVdBL1Z0UEx2d3g2dVBmV0Nkb1ZtUVZtNTRWcXBp?=
 =?utf-8?B?enlhUUZwR3NLUHZqYXFkbTRzcHJkU3JwZmRjNXNhL0JnR04xS0RNZnBpT1RH?=
 =?utf-8?B?ZEFPM1RFMnlaSC81TEtxZXBMNnRGVnNWYkhYTEY0YTVrVFBsWWxzK01xbXVj?=
 =?utf-8?B?Z1hhNHJwQjdFVUdSSGwzK0tKT0llS0dFWXNHWjVOWldqMTNUd3Y1NkFMaWJw?=
 =?utf-8?B?dFRwRUtpK3hybHBNSGhoV1I5T05OYVNPd2gvVUJMYWxUTGdiUnNwQWxsak52?=
 =?utf-8?B?eTlmYTNobi9GUXNWTWZOVy92OVNkSlNXRkd1RWJ0Tm5SanZGZmZqYUFrUU9T?=
 =?utf-8?B?SlErMTRqai9aRFNrWlhDdzNZemNrTC8xWUhCU3JCU3ZuRFJtMFQ4TGE1TFdh?=
 =?utf-8?B?Z2VzQ29seEVaUjlyeElMR1hDUHlxd3BnZ1pkMGZwK1drM2JjUnlCenZValll?=
 =?utf-8?B?UTBiZjB0b2JqSm9LTDNROEpSZXNCYTh6ZlM1ZXVTWlkyTDhta21sYU1mc29S?=
 =?utf-8?B?cGR6aFlyNFVYVjFWd2R5M0hJbnY1K3FZN0I5NlV6bTFRRXdtcm5jS0JwMUtW?=
 =?utf-8?B?UjRPaUxJTGZGVlBWbzR3RjdUNG5iODYyd0ZOV2FUek5qTjJBcCt5azYxcW9u?=
 =?utf-8?B?NU1LdE5DWmVTdkpvbmZFaXhzZnRtZlRyMzV1Sk5CaGlNQ2FUOUFtWk82T2Qv?=
 =?utf-8?B?aTdwUzRuZXJINVRSUE9wZnVXdm93ZGRlMk40Smh1bTBjclYvQ1VmTkQvVE5X?=
 =?utf-8?B?S3BmQWQrdU16V1pUWkhZUlFVRy8yQWVvaFBHYmo1U2lRY3hRUVIrL2Rjb2h4?=
 =?utf-8?B?dFBBMnk1amU4THNSd2FSbUVMc2V3eDA2VWhxWmhnY2xGRStHU1RFdFRmRU9u?=
 =?utf-8?B?UDBiNUJUcmNRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VGQ2aVVXRUpwemtRbkJFa1N2WjlSWFp4UHpta1NqWEpaM01iaUtMMWJUWXFj?=
 =?utf-8?B?UTZ5UHFUYkN0SXYwVTB6SUdwb3Bvak93RkF4dlpkYTNxRGFvQTB0dDFpR2Rk?=
 =?utf-8?B?MSsxOHRGL1ZLZnNjcnhWRXFFTFNvLzlxak8vd2paMGxxa2NXM2lneUw2NEhi?=
 =?utf-8?B?TjB5RUZDUVRpL3hGTXN0WWNiMVBVNzlGSjNyK2RsK01Ua1dDT2xMbnB0U3o5?=
 =?utf-8?B?WHhhNURON1JGRlcxZFRMWStZeTFQVklKdGE0aS9OZDlBYW10WVI4Qk5HWUVO?=
 =?utf-8?B?RUg2SlNEaW9wcGNSY1FzcFdYQnRDSzRxMGdaMjg0SE1HcHlMdkVwcmRYMURx?=
 =?utf-8?B?Qk5veWluR2I2QlllbVQ2Y1ovQkUySmxBbnVqNERUaWFxTjVrRTJpSmhBdmlT?=
 =?utf-8?B?blZ3Q2lWd2Y2TGVVWGxaM2FZRjhGS1JnSGdibjB1QUdiTzdzS05kMExscGRm?=
 =?utf-8?B?MEJJQ3VvYTVuU1NsOTlSNVBmZGtGMHBScjVIS3V2RnR5Sk1TNXNZdHNxd0Q0?=
 =?utf-8?B?QzVoMmRNNDlMU3AzcXM5cEt6REJDbU5ubG93WEsrUjN3WkNHeWhaYjZCRGVl?=
 =?utf-8?B?ZnQ5aW9oK0IreW5mQVFzOUNUU3FDVktjZU45SFc3R0ZWOFVVV2xqVGt4NlFp?=
 =?utf-8?B?ZjZ2OXVLbGpJQ2dRZ2VIOU9aakhaNGFzeW9MdHN5UVZGdjhPSEJrR3dLTm1C?=
 =?utf-8?B?ZUtPMWtUaUdHMmxYZWdTbkxtL1lmaDlzWXA0eEluNUl0MEpHNE84L3QxUUtu?=
 =?utf-8?B?NjFvaStKRlZPM0NMVXhzRUFvMHowdVRqdVJPMEwxVTdVeW1YUml2c21Lc3VE?=
 =?utf-8?B?SWdQRmlhUHhhbWxwUlkrNFBqUlBncFBMeHZPZW44UWJUZDd2VkxFLzhiUTNV?=
 =?utf-8?B?TG9ucXhyZDI2dDduSXRKUENJemhHSlVIc1UyRnovd2dOMDZ3d1A5eWdOVnRJ?=
 =?utf-8?B?T3NUcUY4ckx2WjZZcUg2b3hmR1ZaR3ZTRTFTeW4xSDZhdHZpYW5ITUFOc0tr?=
 =?utf-8?B?VEFHbWREdWo5UlpuRXhGUG5OdVZ5VW5wK0lkWkRlMmpCUTZraUI2RVJ6SVBO?=
 =?utf-8?B?VkIyYVowVlUwTWpmQVZLUjFLbW9QQndDd2JleGxURjU1YUNNVThDNnF6Ujlz?=
 =?utf-8?B?VW5Wa0lLTnByMEJxMFFlcStyc1NkT0EyZ3dpaGlYWGxaL0FNSUdhQ2NWTUI1?=
 =?utf-8?B?WEdzY1F3RkdiRy9McXNodVRsRW9CaHRQVDVXcG9nek1obktGakxYM3h3NkxR?=
 =?utf-8?B?Z3cweXRMV1BWOGtuVkdvbTZFaUJWMnlUSXhVWXJtcUFoVkt4TmgyUDNVWFMr?=
 =?utf-8?B?c3RVNlAzMEtyUEU4ZnhEN1Y0WEc5VW1ZSjY4N1Vwc0NReEYvaUFsYkJwOVNF?=
 =?utf-8?B?RmxGNTYxM3N0cnlIaWkrZGdqcTYzOXlBTVhPYU91VUZvMG9RYVNFMXBqa09y?=
 =?utf-8?B?VVRYaFc4bVJ2K0JUbzVYckEzcnFHT3hLdFRacHRIendickxCSEpQZE0xT0pm?=
 =?utf-8?B?aGpzaUx1V2xmUFdYekpDd0o5cGlMbmpVQnNTWFJYVXVpc1VndWo4dGorQm5C?=
 =?utf-8?B?MVdLQ2IvdTNKbmd5RGQwNXoydlNiZEloVDBKcHk2YjVjZmQwTHozUUNYVmxE?=
 =?utf-8?B?eE1KcmFCWXZHcHhEazJ5L1pac3lGVEVPd1kyQ3dUMHFiZXBGd1ZBaU9aVGNr?=
 =?utf-8?B?YVlzWHFuRWlLaEpTM29ORWNkY2t1OW1VVDhES1dkM2h1Q05OZVllanY5bzNY?=
 =?utf-8?B?MkU0ZEJUWXY1OHdTVGlzd0c0QUlrdGJyWDZOM0hvakIzck55YlhvMVVLaU43?=
 =?utf-8?B?c3ZHYlBmUEhrQ2RDeXJYZzZONjMvQTBqa2FoaVRjbmdoM05nSDQ3cUFUcUU0?=
 =?utf-8?B?TlRGcWNFUnRQL1NjdUFrZm41RVVzREJMbTd0Ry9qZS9HUUc3R0xjbC9vbnUr?=
 =?utf-8?B?WmMzZVFNYnNOeXNkWThuS3I3dk5TcFc1QXhyaTNiUG9RTGhPZnpMN0I5T0NP?=
 =?utf-8?B?dTNlT1hEQVRja3RsNk1hRTFLZkk3UTFQMTlyQURyQnpseXYvdzIwR25jUldJ?=
 =?utf-8?B?RFVzOTltVW4zK3VGNkw3dyt5NVJDOHhsZFdhOXB2eGFaVy9meVU0VERxTVgw?=
 =?utf-8?B?L3FqdnhkajRHYkYrZzlxQXk1S2xtQXMxN0VQY3VkN3h4cmRDY2svd1NsM01i?=
 =?utf-8?B?blE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qOIkvqQpzn6gYIlWIAmiZ6DZTLKoDfzNkWYwQv/aZDNJaiDVsqKbOwT4IIvcGIO21+crQdG6pdYAyrwT6NVx5HM11iCNiJH7BC6rRQnLSPY+iZwjfmx2Gs0LnxzqK1Q237oXrXtwOFTWxDj2+UwYmtvL+gPYtw35eScindaGR9k8vU6+cIjN5aAAV8R8JMIxqbIk+V8zyQOF9wiBE7pTqSfuBDhMX7pFDw8rtRc1lHVUzrNY0YtArEr+OTfbNUeTZBaPdGVkp2bcHz8A00BdKk0vu12zDTHP1r3ZPbQK581GKK7giay3f0Sfeo1L9BbnPbvNVe8QqSJJ5BapQi2+yL8E3Sdf+Flr25P7SgxUOunl2uLO71ipZySZOUkvpWkpaWYnTvZRl9idwCVsfgfvDKG620qLGI/DQ2GQlcX2yBuJGPP58gYsuTcnilmpzVx1qnR0pDHBgnA+yPlkC3bY2F7tY/tj4rUVjrFGYB+jNCYE6Wd9UtWN+gq+tmuZ2n7ksQgxzaM7X4qFGg/9T1UlXHXTHPp6xV/jpEEWktqCI3ChVRYWyUVvHAgfWL/qgHs92FSu6MZ5GN/G8Sx3BwOporkU7G7EuCyRZg2stfdLiqc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef42d98d-0655-47c6-3875-08dda36e8b54
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 13:48:53.9029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iwXcDe6Y7CF86ipdKKlq6XIi9qRGOUh+X95kjnXyRH9L+ECZ1ZMAsK6YsOS5+O9p3jpV328shQrxnw9FBccwdNlvnqbiu48eSicdif8EXuc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB7994
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-04_03,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506040105
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA0MDEwNSBTYWx0ZWRfX7YUjWNRPPwr+ p1lLr00eIihaiJkM6RWVu1cx/qbd+Vz1PKzRFjzH5qYyW1Fehhi0N1U7dT1GpGxQzuYdyWxZwtS rd3BYXWCIDz1aS+DuenbDIDqxV1Krf+xaP759lZn/JZuLanI5a7dM4NEVcG02F/fIrdJlp9OmmC
 F45OG90bAyeiL8C/NcY3YAtGmZbeEZtzUuS/g2PdxUkHLCD+JYIBNUHYcdvzkHAulePYwQKZLxI 6QNsAuphMKarV1pAoOudMNhMKXxOVcLdRsJkgsTQTW8yGFmInZHH4lL7u5jgu8+8n5WPT/RYB1u 1M2Mtc9Mwcd7mmbWL2zJ05AL8/hhkVyqEkUmkVMZi4X6PAhw2NSfj0HIn1fYHLTctCdCFeVQXMK
 yec7WbqHWmgvGs5ISTw6qtMVrUAq4og1rKIBwRHtvBEUdRW447jlyq5NnL4O1ycs/+s15d6T
X-Proofpoint-GUID: ySNdKJNWWRe3jOnNrRvkjG9RNJ5kkPW7
X-Proofpoint-ORIG-GUID: ySNdKJNWWRe3jOnNrRvkjG9RNJ5kkPW7
X-Authority-Analysis: v=2.4 cv=H5Tbw/Yi c=1 sm=1 tr=0 ts=68404eca b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=3NcdCr0Wo7SOhKP_vvEA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13206



On 04-06-2025 06:13, Roman Kisel wrote:
> -	if (ms_hyperv.paravisor_present) {
> +	if (ms_hyperv.paravisor_present && !vmbus_is_confidential()) {

it is, not vmbus_is_confidential() ?

>   		if (hv_isolation_type_tdx())
>   			status = hv_tdx_hypercall(HVCALL_POST_MESSAGE,
>   						  virt_to_phys(aligned_msg), 0);


Thanks,
Alok

