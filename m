Return-Path: <linux-arch+bounces-11891-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A487AB33DF
	for <lists+linux-arch@lfdr.de>; Mon, 12 May 2025 11:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A33887A9DAE
	for <lists+linux-arch@lfdr.de>; Mon, 12 May 2025 09:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04BBE25EFB9;
	Mon, 12 May 2025 09:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Yqs7n+gD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lBGIvCrj"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDD525E45B;
	Mon, 12 May 2025 09:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747042822; cv=fail; b=DG0z/pT7Dk1PyVUPO6A5JHQv7gnKGu0mZsqgXasWH6FNqUk08h88LRv3Xu4uEdgSiAQbTbA5yQmWTrtr1so5yBcy/gMPx/3ZC6FDlJs2YB3AQX02E7GJEFy0+znchkMQ4aWxZ6vIC2q1h4DH3zo/peMoyuFSDUclZtNgIeaG3yk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747042822; c=relaxed/simple;
	bh=jZUWR1Ws08xFtwQ+GOdO0Qazgm0OGpjGsoh01DcX2hg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=al4L3QpMQEo0Lom0l6A0b4NRO2J19Ph5/3j7dTKSXzcWfe30PYzfdeYuZcP9+M6993H+dwiDQMZ2ijt0fi2MHwVM4Va57NynC4ej0Cq/KnnAcTT/0JClpCdBQI2PNo/U24z+1RiiN9wj/B0U1c3lwK2eHaCvwbj+NcZODiHcOMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Yqs7n+gD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lBGIvCrj; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54C7fqVC017479;
	Mon, 12 May 2025 09:39:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=mFP+yRzKuZ0vbYh7xZCPnqAdlKVWOOBhBhzJVxmT9dA=; b=
	Yqs7n+gD2GJqRxxRp3YOKDv23/wdAQdnq/jMSrrfU1bgHlPbjA7VvW7B+0nljh05
	zerFWZEvcdt2qnIIhlKKVqRjfBdU7Qc7SqQpkZrOVPZuWM4vNddrDRbwzB3SIpq2
	2a5hXzaUj8BynJwLBS8ktpyfv2imDSyo8wTfEoVN4yVTyz6V+25eMZ95kPduZEOC
	rJaY8FPOavb9Id8DgU/EESNMQWift/oGxvJ9cSl3gXAs9wsjlAlB1ff/r/tywGND
	0UctGIEg1Q6OPzhQbop66Z1e3zbMW/p/WdTfTgV5ZUz/vMemlW3jLXedkJeIi3km
	1qpeELkEp/wvGsXMVzF2nQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46j11c22qq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 May 2025 09:39:47 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54C8KvHl036207;
	Mon, 12 May 2025 09:39:46 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazlp17012051.outbound.protection.outlook.com [40.93.20.51])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46hw875nvf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 May 2025 09:39:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tf+R1E1zQHcYguKA26mNcWjmIhD52btBQOyg6AgZ/wGr8Vp/uj4We7rQSUktbFf0vOhm4UZLpmLXAZrhAjskvOIUxGyknGflGxQNNLyiS++wS3P2HUjZSTLdHa6TXAwHETuSZByBj6AnekfnBDCslSrTUPeTqBi3Co5CROJGeO/ZKb5zaTseRCuWyV1i+pI2T4MPGbQpOhOxF/250/X6HBq84THoWeneJIQ3sMkKdsNtXmyDrjdJMIdrCFqB7OPLhruSNWgOu5z+TEdeN/n42ihx0PVRy23lykCx+qxfRAsRQ4snNlz7V/kWADeirTmPJ3+i+zcWhxDTuRJSzy/SQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mFP+yRzKuZ0vbYh7xZCPnqAdlKVWOOBhBhzJVxmT9dA=;
 b=ZkDaU0RSoV1grHP7AAQvVJP1OzXRpIGG0O3tuDvfpzHjEn2AN8oweFXMWgEACI3QNM8C4OTrZTu/uyRSNVJ8zd3dJONnVNHvw/sr5Gx1/AIVC8eka+0aB5TgAd3wk0FCfJ1TSo+mYkPKto3Q5akaMvAGfFPWWVAiaK/vxW80Pxdm2+WNl4JEQe1obbuHM/La3gw42+mhaIqD0zG6wrYxIsvYFWdopSxI1iPl8AZA2WNS6yTFIEEGTNcLpW0rsgfE5rqH2fzz7l8uXkfE/FWny9pP1CH4qbJwgEhIOcTfxScHRYCDKexJqe5HjddgL5kfi9+uwYE1ovWrL/tZQoSWsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mFP+yRzKuZ0vbYh7xZCPnqAdlKVWOOBhBhzJVxmT9dA=;
 b=lBGIvCrjmaGZMY4mKRWvHR7EvQvp4a7CRyWLjyasOibPbBe8z3Q9LfxuvhbUvoSBEiIvpGwoxX+1QdcxVOC2lrX5P8bNutLJv1A0f35FZE+IwGjAiQ1mYg8bCeRgdCukQj2ltdSmyALWoRafGtwgfHNA1Ajij8//VxA/4Q1ad0E=
Received: from BLAPR10MB5315.namprd10.prod.outlook.com (2603:10b6:208:324::8)
 by MN2PR10MB4333.namprd10.prod.outlook.com (2603:10b6:208:199::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Mon, 12 May
 2025 09:39:44 +0000
Received: from BLAPR10MB5315.namprd10.prod.outlook.com
 ([fe80::7056:2e10:874:f3aa]) by BLAPR10MB5315.namprd10.prod.outlook.com
 ([fe80::7056:2e10:874:f3aa%5]) with mapi id 15.20.8699.024; Mon, 12 May 2025
 09:39:44 +0000
Message-ID: <323ecc55-d829-4c74-8cb6-7b3a77dd3351@oracle.com>
Date: Mon, 12 May 2025 15:09:30 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH hyperv-next v2 3/4] arch: hyperv: Get/set SynIC
 synth.registers via paravisor
To: Roman Kisel <romank@linux.microsoft.com>, arnd@arndb.de, bp@alien8.de,
        catalin.marinas@arm.com, corbet@lwn.net, dave.hansen@linux.intel.com,
        decui@microsoft.com, haiyangz@microsoft.com, hpa@zytor.com,
        kys@microsoft.com, mingo@redhat.com, tglx@linutronix.de,
        wei.liu@kernel.org, will@kernel.org, x86@kernel.org,
        linux-hyperv@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org
Cc: apais@microsoft.com, benhill@microsoft.com, bperkins@microsoft.com,
        sunilmut@microsoft.com
References: <20250511230758.160674-1-romank@linux.microsoft.com>
 <20250511230758.160674-4-romank@linux.microsoft.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20250511230758.160674-4-romank@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYAPR01CA0021.jpnprd01.prod.outlook.com (2603:1096:404::33)
 To DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5315:EE_|MN2PR10MB4333:EE_
X-MS-Office365-Filtering-Correlation-Id: 67550d8f-02b0-48db-3986-08dd9138ec8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z1dQakR4ZEMwakJFNmU4NDBDS3J1cHpLbytxTERMcUNkUkUySjR6TDRlOVFw?=
 =?utf-8?B?czBjVVE3aVVPMGhPUFZYUWtlNlZDdjRQY3U0bHFPd3VMSHZiZEJwaVIwaDlH?=
 =?utf-8?B?NjZ3eFVta21ueEQrV0dqSmZXWG1NK0Y3bXN0NHEyc29yRUhIQ09rYzFWUUJ4?=
 =?utf-8?B?dk5WcnVXR0NUSUlGaUFmQlhsc0dub0M5NVZRSWtUMngzOVJBbXZYSlFyN0FV?=
 =?utf-8?B?YmlQREV5bWZ1UXIvVjVFazZENlczTWd2MmREdG5sbVVLTUJhcDNXK1h1THJB?=
 =?utf-8?B?UGdIN2ZLeUEzYjF6Y045WTl3VmM3Vi9KT2JRUDhQL2hxNjJ2QTh1dWR1a25m?=
 =?utf-8?B?RXZtMm5aSTI4anMvQ3paN3FtdHlRZWV3RWhXU0J0aUNFNmJRSDVteG0xcDI0?=
 =?utf-8?B?TU9BOXZEYUk1Nm1qbWNoUkN1ZWF2Ylc2aERGL2tNdENDQzE5Zk1pSmpDZ2NT?=
 =?utf-8?B?aHZZOXY0WGxzR1pDckorV2RUTlhhYVdFejNUMkZrTXVwbklXN29jTlBEbTFE?=
 =?utf-8?B?UDg4d3BFa0E0VU9OTXZGcGloa21TR3VkakNKSDI2Vk9TNXAzOGZHUVUvWkhF?=
 =?utf-8?B?anlSNTRmelJydHVaOUlobFFkOWRlejVOMnJpbTdablorZUFzVlIyMUZSL0Ez?=
 =?utf-8?B?UWZJUTJzU2EwN1Z0ZFdITFBmZWxudWlqZHVrUjBpaTFpUFRGRFlDM0JUVTlG?=
 =?utf-8?B?b2NPUGhBOHBIL1gwcllVaHdXUmI5cDdtVUNNbVZEaEpUcUVkNVNrVFN0Tmdq?=
 =?utf-8?B?WWdlWW5YUG1oUUpxVkk5V2FjQzVVZk1Ib3F2NEI0aGtmWWtNQmowT0ExUFZ6?=
 =?utf-8?B?VVRQUGpHWEJCbE5VbjY4YTgzRHZDcGNZK3dmaHczcU9lRnloQkJnc1VKdnZS?=
 =?utf-8?B?L0UybWhmY3dYd0I0MVU0TnpmbUFpUSs0a0p2WVhaZkJvSkxLamRpQUQzaDRX?=
 =?utf-8?B?a1htK0t5ck5TWk51QkZLMDFGaVFrYnNUMERNTDAvcHVyRk9MWE1CVkpNc1hJ?=
 =?utf-8?B?WElRYnFERGJDTlpLQmluWVlVMVhlUytBUHpPRWlsVVNXWHJDRXR5MnRROHp4?=
 =?utf-8?B?TFJ4WFZzZWVJdzVKMzdDcnRtSGRUbC9MQ25sV3FZbnd5QkVTdU9OUzA5Uzdi?=
 =?utf-8?B?S1IwL3pvbVk5QUpuYkRzc3o1ZENxaVhMUDM0UWVjVVdCMFh0YWpZWUZFbFhn?=
 =?utf-8?B?ZjlVWVMxeThwbCtWTkRxaVdBWU1ZQ2wzS0pOZXhNU1pvZE9aZGVjM2RhTm03?=
 =?utf-8?B?WkYvZ3J1VVNPcGRWUXlwZHZQa0o1VmIxblJHby9zKzBxRy9yd0hxeHlOMVhk?=
 =?utf-8?B?Ky9QNWFrNlZObWdRVm1UeW9MdDF2d0VHbVdKUFlNTm9rdTJDR3V2ZklCWHFu?=
 =?utf-8?B?RkFieUJMbjUydS9yRHNaV01CQzAydVZ6TERPcks2blZwSmxVTXFEWjE4bG00?=
 =?utf-8?B?T29NSkZTMGNsY3VPaUc3QUlRdGZUb0tvWkZaSUZpKyt5Zk16UytBSm53a3dV?=
 =?utf-8?B?Y1hwNVU4MW5QdGJHc1hSUFp0UmNrTXBTMFpHcXBCT2xCVEJla1Y2emhwNkgr?=
 =?utf-8?B?dDdYMjRxalR6NndmbG5ucXNIejE0akVLb0FKZlAvUjRpNkJ1c0s3b1dpL1ZI?=
 =?utf-8?B?RmFMaDdWcDkydVRhcXpWTnpLNlh1NFBkQTBOdytwNUptLzkzc2ZyUWc2SHA4?=
 =?utf-8?B?Y21kMzdzRGxsR1IycUMyR3Y4SEl6UEVSZTRJTkhtVWI1NjdINmdqd2hXcU1n?=
 =?utf-8?B?eUZoa2lFU1J0ekRXMDI0eVBpWEF1MXRURkt2Q2liTFJ3UzcvaWRpYmRFeURi?=
 =?utf-8?B?RW9USVdRWk8vWUdYLzJyZDB0dnlCZ0Q1dGhXcWJaRStIWkczL0hkVXFyM2tL?=
 =?utf-8?B?S0R5NW45cDF2L0w0YkwyZDdXOGwrNmZUUmZQN0tJWTNwaVk2dlFsUHVNN3RC?=
 =?utf-8?Q?pO6vPFcBxcYaNOtDtqohfnOGv2x1KSvx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5315.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MDc4OEt2QWRuTzczbXNoM2lOajErcmdhTHJ5aFJrc09WcUc2a1lEdmd6OFN1?=
 =?utf-8?B?MnNEU1htUWdweEtydG5SRUZDMzVPeVc4cW1NZzdRdXgyYUFUYmR3a0ljQkVp?=
 =?utf-8?B?VkZTbkJabXF1RFIrYnUyazViM1hQemJVdVYwZTFOWlJORHI0NzNaTTlJZ2VZ?=
 =?utf-8?B?SXlndXRPK0EwMERwNTExcWZscThhOHpYZ2VtOXRwNkVMbUVNcGsvL0lFWlNj?=
 =?utf-8?B?ZndtNzY3VFdnMjEzOEs5VkdoZUUrS3NwQi9WYmdXVytLa0xBMU9VWjVQOHdQ?=
 =?utf-8?B?V0o0UWpXRFJVd2NiVzRTV0Zybkx4cG9lOFVWdUVvTWF5ZDYwL3l1Zy9UeWJZ?=
 =?utf-8?B?RzNtZGI0UHJXQmFLb0svM21idnRKQWpuRTFDaUFWbmdXcUg2bDJpTzFOWDd2?=
 =?utf-8?B?SU5SbDVsd3RpWVVsaXhiN1UyN2pidXROaW5UUUQzRXFzZGhhZXNZdnhOMUUz?=
 =?utf-8?B?bjFsM3JjbGFLWUhXNkJNWjhtQk5GeGJoYXY0YTdFaHdtVVFORjdaZGtaWHpT?=
 =?utf-8?B?UDREcjBEeTdtK0FZNXF0SVBsaFZkTzI0N3hEYkRUbHZOR3d4Y2xZY0VoU2Ro?=
 =?utf-8?B?azhIc2F0Rk03ckZ3OUVQYTcwL3ltOFhHWHVmS2pCWjNNVW1FQzhrV1d1TzZx?=
 =?utf-8?B?N25QK3M3TkxldVhCY2xIaG0vUHNnZE9hUWpLeVNpRHBWUHZEbnJiYnZHdnVM?=
 =?utf-8?B?QzQzRWp3bExJWkovUUVUVUtlNGw0WHVwU2QxWU5CamliUDY2cmlpSE83N2hV?=
 =?utf-8?B?Y0RXUHgxMjY1L1ZXRUl5VUNvUWdIOExIeUh4VEJxVVo5L1FJakpFMkc0eVRq?=
 =?utf-8?B?YWRBSjlmQ3diLzhzQnNWekxMMFlhZ0dPZm5jcmJXWXNLOXBJRWRqRVM0RkNQ?=
 =?utf-8?B?Q0MvRjlNbFgyRHFiamNreTRYOFRSMFhrVUtvWFFBT01SYXRzWkhaaFJvWjgz?=
 =?utf-8?B?N0kwd3pRWnFoVWdZUVJ4ekNHa0RVRk9INWUzYlVpeVZrN3NKWVlKVmV6Vkl1?=
 =?utf-8?B?NTBZcEttcmJCRjlPTHY3cmozY3ZJbTZqOWNwc0tuVjhTZ0tHVG4xTk5TcGNQ?=
 =?utf-8?B?S0R3Z2JQL3lEN0VUYUN0NWhrYXpXS2p5b0JweHNvQ2Q2dzRaQnVUTDlXTVl3?=
 =?utf-8?B?UlhFMUJFL0RpQmZjTXNncXBxMmY1VTV5TndGaVN6aHNoV1FKeHA3b3lIWi85?=
 =?utf-8?B?UWtXTnVNaDJiN1V5M0NWREpZY2p3czIzYmxnQUNxQmltRGs5Nko4MTIzR1ho?=
 =?utf-8?B?aG9lMTVER1pZVXBxWi83N0s1em9zdS9OTXZMVU1nNW1VVnhaVkphMUQ1Q0Vx?=
 =?utf-8?B?bFFLcHNlazVpWktkOVNvbDhib1RqZTVOTTMwSzRlSDRsd1gwcEVpRDZHSitX?=
 =?utf-8?B?dGZJVVhFQ0hzQmJkcVJVNERYUTVLTEJ2emJjRWhWd1VpWkJWQWZieDhsakI5?=
 =?utf-8?B?ZFk1a3NvZVJlRXdHekhvRWJUZEREK1hjNkVBZDA2SCtlei9OdmFSUTFkc3Zq?=
 =?utf-8?B?UzZMeWNhR2NNV09kNUZEWG5xVXY2dHdNa2FCVkZFUitFQXlneHF6M2xKbEdC?=
 =?utf-8?B?Tmp5THk3SHJOdGZZeUJGLzdWUkNzZnFHQ2dqNE5mSWt4dVpka3MxalMvVThs?=
 =?utf-8?B?a29tcjdOM2Y0MG1Nc0xiU2NIZzRIaHYyQ2FrSGo3cENMdWFDaWxtMGJ3Q2tt?=
 =?utf-8?B?dnhVLzVoSzR0NTJrc1hsc1BIT1NxWVpENnQzV0Y3NzhDSWJZQ3djY3NjVnBJ?=
 =?utf-8?B?cTJyWm9kT2MrYVplMG81ajNYK1BNR2FKM0wvSTdKUmVSMUREV2VENXUycVlJ?=
 =?utf-8?B?U0cxV2IvUERSNi9ZZmo0RDZMbTBKT0tzeS9rS3BDazEvS1FRS0VmcnJHYUo1?=
 =?utf-8?B?eHc4K1RPSERVZlFaVzZYazBHQ3F2cDIzSGNQa0dJTjNGWTlQZEo4ckxXWFVa?=
 =?utf-8?B?c2srV2hJRlROM2JHYXdyTHNXSkVPS3pXLzA1OFlaeVdiS3NUZGFuVEJDVFF2?=
 =?utf-8?B?NU1DUldXT25pcG4wdit2NTc0NitsQ2NxK3d0U3VTZmhhaFlQaVRabHFtZ2Fo?=
 =?utf-8?B?U3dpQXR5UWJjSjhhci83ZEJ2R3FKbUlIMFlxaGNNc0s4N0tSemVaTlA1RzZP?=
 =?utf-8?B?Ukk0aVh1ZEFjeVJqdG9mLy9GRHRBcnlINnhRc3YxT2NlditGMHFqdHpUNm5j?=
 =?utf-8?B?UWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	yyfOjFnqWY3GS8M5bKhjop8BEbXwa0sQ1MOQg2UmIh3p/d8ze3D/xysn8I1K/c7LaJIMEnAy2uKCYviO9X8GCfdkLUivHvz6mdO8F0yDMpOw1GeGn51b1Y8zmcXWVNm/lBrs4MBHszbFehPmZ0fq2ijulLsKMb9By0hJC6SijcetC+AOtFJhA22Th6z60LP0yfoHY/YAtb/X/RSuD6S92Tc8IQxw95zK86ILMT1Vvd6HmKQl0se9d35OC1SXgUE+sazE6gXyyZCccEtR/dmjNP1s+pa7Qin/q/+d65JzHtbTfmnAJU1boD5o/78RF7lynycHMSEVViBmJgMJbZPj2DdSQ0GQZoHN1II/EZYv3aZpP2RHmA9hJKN3cIwynx/D02X1tYZj3gnMD30kHgzHhz/B0555VgG+/au9i5T6ayPDg5EStxJqq2mdku9CBlxDYp3u4l2Xp4zFoHn2Gwok+7mIXmcpFt2VlfFu3NwGvnjtmu250pK4fh4BjRewxhl3b9QTdixcPsccz2R8bO7saIcXvlt/2Ritaum2NZoF2TnJFMCKgwus+3v2q3xb7BmNTjh6O61rX3xTQq6GTpuyCKN9kpC5CyIfLl5ddG3y/Nk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67550d8f-02b0-48db-3986-08dd9138ec8f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 09:39:44.3051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1FgsbF7oW2gUfLzvjdMIAOI3OIvlgZMwHtSTrQFcnn/N19HMbvqSyd1r4htRf2uTpbSLJ9T9YfPJ02cvOeaNIQJwZbqmsMrDK5wPqKST5ww=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4333
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_03,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 spamscore=0 mlxlogscore=999 phishscore=0 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505120101
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDEwMSBTYWx0ZWRfX+9HrgRKe4bHv YBfpxHFK4gEq1rKAbfhc9c0Hs/kJvZ0tCGMHusK6uQuvt2vHd14LUDL2yaS5S5n+unsvmsPxC6c 2dPv1/mhZ5k52NCNTYiOpH3N+c5T/pKG0HkbHZK1gOarhJ6yMupMGfihvk3h9VbASmcLRSwD8Hp
 4DP3abfXx5wrOKg1LJQ4TGLXjlV+H3VPt8PVPt4FErpku4SPRmYL1qAR0SB/it2EnI4asjpOTv/ KQZgc6gdVFQIY/vRn7NkNawkCW8FVSvABbfn/ZWnsaKmwUTFBSjz3OZfF89HbS2iwQwwGxH8+Ts xraXbvxd4AlABr7tPATorzOnn35QHmk40bFob8uY48WzJ9Ab6w2NGql+vo018hX4lYtLWC691tO
 rc+MDcfmjPktX582MV4rJjsnIgjwAHiMbTzEsAVcaPpyQb7DlxJbd+UvdzD27BQGx1bs+D4U
X-Authority-Analysis: v=2.4 cv=YJ2fyQGx c=1 sm=1 tr=0 ts=6821c1e3 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=gRteV8TEMhhfuH8V2V4A:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13186
X-Proofpoint-GUID: cr7udnuJ2D_Amje5_ii1mY8oY16ye-7q
X-Proofpoint-ORIG-GUID: cr7udnuJ2D_Amje5_ii1mY8oY16ye-7q



On 12-05-2025 04:37, Roman Kisel wrote:
> +/*
> + * Not every paravisor supports getting SynIC registers, and
> + * this function may fail. The caller has to make sure that this function
> + * runs on the CPU of interest.
> + */

Title and Intent: Clearly state the purpose of the function in the first 
sentence
/*
  * Attempt to get the SynIC register value.
  *
  * Not all paravisors support reading SynIC registers, so this function
  * may fail. The caller must ensure that it is executed on the target
  * CPU.
  *
  * Returns: The SynIC register value or ~0ULL on failure.
  * Sets err to -ENODEV if the provided register is not a valid SynIC
  * MSR.
  */

> +u64 hv_pv_get_synic_register(unsigned int reg, int *err)
> +{
> +	if (!hv_is_synic_msr(reg)) {
> +		*err = -ENODEV;
> +		return !0ULL;
> +	}
> +	return native_read_msr_safe(reg, err);
> +}
> +EXPORT_SYMBOL_GPL(hv_pv_get_synic_register);
> +
> +/*
> + * Not every paravisor supports setting SynIC registers, and
> + * this function may fail. The caller has to make sure that this function
> + * runs on the CPU of interest.
> + */

ditto.

> +int hv_pv_set_synic_register(unsigned int reg, u64 val)
> +{
> +	if (!hv_is_synic_msr(reg))
> +		return -ENODEV;
> +	return wrmsrl_safe(reg, val);
> +}
> +EXPORT_SYMBOL_GPL(hv_pv_set_synic_register);

Thanks,
Alok


