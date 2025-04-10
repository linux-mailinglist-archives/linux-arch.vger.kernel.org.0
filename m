Return-Path: <linux-arch+bounces-11382-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE653A84AA3
	for <lists+linux-arch@lfdr.de>; Thu, 10 Apr 2025 19:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B77F1BA04D2
	for <lists+linux-arch@lfdr.de>; Thu, 10 Apr 2025 17:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA3A1EE7BC;
	Thu, 10 Apr 2025 17:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="om1RCJVv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="f6Y8l04O"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DDB1E832A;
	Thu, 10 Apr 2025 17:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744304702; cv=fail; b=FWcflgVOidfRSEixGcWItcV7agOCZDLNy5fQPl9QUmrD95Ox7WZS+ZdymsC2itfKpQSK/Ep0PDPF5HHZdxmYmbecu4LUDxT2d6mKjA15i8Ojg2JGpTz3sRFNQPBMiqBId6l4BduLWkzwS6DJl+i6UBkTFLx908Y39mAAhhdbmIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744304702; c=relaxed/simple;
	bh=kZG7Zk9+KVBggeXyc9I0pzfadVxgmVT7od28IAApl+A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YbimVmCIBNgPQsRT/5hzd/x5UyjF7s5h8jNGeb+G+ItKfLB6x4n23PbUEwcYpcxkC3bGa4yyXp6rMSeb4byExBDgoFppHR2NlpSppe/bok6uH/OUqmtYkydNYHydoYoPzqbra1BWfz8fpnuX852deEZxqDYooKGOOlZGLWRhSC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=om1RCJVv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=f6Y8l04O; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53AH1dWt031646;
	Thu, 10 Apr 2025 17:03:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=ZrTIQgGRJVkPcy3HkO7mvJI8SbB26dCmFY/rHBmTNgY=; b=
	om1RCJVvcTx2gIIC8Cf/0e0rBvhgnaBlrE5EJvtp7+eXtcK5trRbwuogRqWUg/D1
	rXavrtxcKpj4QImXY78hKsUYbLja5MNlHMV100iZmSW2hn8gGQ8USJJXChLNCdwR
	Lc35bx2rX8tElMfBwxUX5pXaaYA2/XKx+GHyLlAwpP3C2Jo3NOKwz9qYg/nmNZ0m
	2u4EoHCntDyjpt4mZf+vtSHfc1O1Hb/wijQBg/1Q8rhRSVUQ7QpSQejpXINHfBvd
	bgI5KcFTdLkwdfoLi3g8bZBgMHqVorsYFWCFYDY0zMboxnVLY5Z3XQDr8j44bFP+
	j3DABvXzF8wZLXYiSW5JLg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45xj1c005f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Apr 2025 17:03:57 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53AG2mDd016323;
	Thu, 10 Apr 2025 17:03:56 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazlp17010001.outbound.protection.outlook.com [40.93.1.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45ttycgfwe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Apr 2025 17:03:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BdOjAMRB0tyGknT4ezwvGVVxFjbpeo8m5CvKMaU72Qk8/lXP9AlIk4F7soJJ9lyL/HEeXkWnAQsg/VzmYlPwqoCGZ9RZOXiY6YUfhg5b2ElO/plE2GY438IcYhm9k79lIU+UJ2RprKdLLam8rZiz7vxtXOWeIa6lpi6zXnOJeXxRi0XYU5zt4h3TbjuBqM4suCsAvL0XlVizODlRHgZyUeqlOdOLsDPECvzTr/Dt0W+gq7vJO3UK1kO8C/PVcn2drXQx6DB9mcHbT2huUmLQm0JSj4zw2sCfOUvwuVNHXumRMOtETvNvX5faAu7S5ovBa14E8iOqCmMz+6bM7e4d+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZrTIQgGRJVkPcy3HkO7mvJI8SbB26dCmFY/rHBmTNgY=;
 b=UnLXM8tX82yjkBMBSDZT2A7QYwQpcDLJw8AxQ+SLUFkVfEU6xo3jS6a+m2JFP1u4LWriufDidyB/0a7MlnBSwBiSmlnvC5ncAex8hw5rjmIroV2uIyEUwTCNgNsdmf2z/w9f9ZdnZvuUO19Yf0he4/o8C0kxz00jwSByAcI3swq2WUGjWdjCj6Iv2t8N2eMTfJ5wsMnoX8FNsHDttxXHot+KqGBewHVUPqywGGK6Zicj8YXWkFCSEZBGAgJThJoTkg/Z02spWrQujR3gChbuIDCftfqrXgoxQxpxkweyzIfi3BErSk/gZ1kPPHvvr9A/yw9P7bMdBGCWEZWkqEHrNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZrTIQgGRJVkPcy3HkO7mvJI8SbB26dCmFY/rHBmTNgY=;
 b=f6Y8l04ORovoiRZIe+rzdq/bTcNSe2Ilj5M+8cRMxNekabRj9sU/CPPcdQJRrYd2Wi48wNME7VE2MIawc8zjRYNxbLeoBzQ+v7zAVgF3YGdxnPVu3NW65AcMNTohMBMYZH8UWldBufUBPrNF26LFY18f5llzv7UpxSeGQ0s+2M0=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by IA3PR10MB8443.namprd10.prod.outlook.com (2603:10b6:208:572::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.21; Thu, 10 Apr
 2025 17:03:53 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%6]) with mapi id 15.20.8632.017; Thu, 10 Apr 2025
 17:03:53 +0000
Message-ID: <b4210b27-e1a0-4334-a379-95fd8167c58c@oracle.com>
Date: Thu, 10 Apr 2025 22:33:38 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH hyperv-next 2/6] drivers: hyperv: VMBus protocol version
 6.0
To: Roman Kisel <romank@linux.microsoft.com>, aleksander.lobakin@intel.com,
        andriy.shevchenko@linux.intel.com, arnd@arndb.de, bp@alien8.de,
        catalin.marinas@arm.com, corbet@lwn.net, dakr@kernel.org,
        dan.j.williams@intel.com, dave.hansen@linux.intel.com,
        decui@microsoft.com, gregkh@linuxfoundation.org,
        haiyangz@microsoft.com, hch@lst.de, hpa@zytor.com,
        James.Bottomley@HansenPartnership.com, Jonathan.Cameron@huawei.com,
        kys@microsoft.com, leon@kernel.org, lukas@wunner.de, luto@kernel.org,
        m.szyprowski@samsung.com, martin.petersen@oracle.com, mingo@redhat.com,
        peterz@infradead.org, quic_zijuhu@quicinc.com, robin.murphy@arm.com,
        tglx@linutronix.de, wei.liu@kernel.org, will@kernel.org,
        iommu@lists.linux.dev, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, x86@kernel.org
Cc: apais@microsoft.com, benhill@microsoft.com, bperkins@microsoft.com,
        sunilmut@microsoft.com
References: <20250409000835.285105-1-romank@linux.microsoft.com>
 <20250409000835.285105-3-romank@linux.microsoft.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20250409000835.285105-3-romank@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MAXPR01CA0112.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::30) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|IA3PR10MB8443:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e58b6aa-62bd-4328-7ddb-08dd7851abc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L1ZyUm1jMnNtaUs4UWwzSzloRE9IYlNDSlEvdFdwR09LMWFUc3o0N2ptMVJ4?=
 =?utf-8?B?V1JLQ0JNTUk5TWU4cWJRSGVzUkZ2Tm5CYXYwM0htd3lmSGlSRHdxVG1GdTN5?=
 =?utf-8?B?ZmZsdHVYTVp6RE40UXRmRzYyUWg0anM3clBBWndQcm1HWVVyT3FLQy9xV28y?=
 =?utf-8?B?L3hUQklDSVNGN3Y2K2cyUnl3UFJ3YnVQMTJHRTdzb2hmd0pibG1XZW55UVFY?=
 =?utf-8?B?OGtZZ1hSZk9wNnozMjMzVXlFY0RoaGd6eURwYkpkZllDTVRPQ3Y4RU1mRG9M?=
 =?utf-8?B?bHpzbk5KRkhQUUJTU2I1WkczS3FxUC9US1hwaEg3NGFYclZTNlFRcU1PMnBm?=
 =?utf-8?B?UStZQlBmcndIYWtyYTBpZENsTWxZYjh3NXVsRHdYR1RWcWNvcVZlRExmUEEy?=
 =?utf-8?B?MUhiS3hPUzNMRHNzZTJqMDh5TzdvQlJPeXl6djFDV3Z3RmJ3ckRhcHVsYXJB?=
 =?utf-8?B?cjJhMnUzSk5MdjBheURRRzhSTTdiV2ZncmlvV3RUSHZJSUFyTXYvVGdnS0xa?=
 =?utf-8?B?L3kxNDJTMjF2dHh1V05URlV3OGY3ekhwMm1ROFVEVzRxaDBIbnRYY2RKVXB4?=
 =?utf-8?B?YytwZ3JYaEQrQWVURngwd21WT2N3M3pEV2FFSi9HLzYxelBvOUkwVTRLVGtr?=
 =?utf-8?B?dHZPenNvRnlCbE5NQTk3YkVWa3IxbjdzREFtSXV1cGg3MzJuNVRzR2ZCNkto?=
 =?utf-8?B?dCt2M2NxV2hkL2RUYlNFOWlDRHJjSjlGTkQ5UVhkYUlpYko0V1ZuT2kxZzY5?=
 =?utf-8?B?R1lZa3I5emZTZnRlMXZNQURSOE11NGd4dzVMNmNsTEpCWEdNTmt4ODI1V0Zz?=
 =?utf-8?B?c25mRDdhdjkrNU1GaEF3UTlhWGJVM1RBeG5yOXZJamZnVi9sTlBIQis1LzBE?=
 =?utf-8?B?YUx1eUo4M3l4SzZZbzlabGZRS1I1Mk9vN21yMnNib0hqUnJJcU4xSWd3MXNV?=
 =?utf-8?B?ZzQzZjduS3Y2cVZpWjZLc3NTekp2alcwNFM1emJjUUpKbDZqWEhzNUdsQWJw?=
 =?utf-8?B?bjdqR01UaUlnMDJJeXpIQkwvZ3lkbmdqQVpnazlsMmNqa25kVVN5ck1yUXUr?=
 =?utf-8?B?aXFIUVNMcXNhTWJ3WGVnQXp5dFRHNkxVTWQvV1doVTZOZldUbC90ajR5WlRw?=
 =?utf-8?B?MDI1OWRuUUdrTnlXUjFvWHl4c0hXZjN2bUZQYllDWkVVZEJYS0dQWUd5Ynl2?=
 =?utf-8?B?THRvZVROUWNiVFpMVlpiSDMrTVpoTGtTTHhFaFlXQlNOb1hhTlR1akxEd2Fj?=
 =?utf-8?B?NklBNlNIVnFoUnRWb3gzRjNaRkVvaSt2eEIyMjM0YXkwNlRRSStoUHFlbU1w?=
 =?utf-8?B?cmw0VUxJM3lkakNMaUxnV1Jqak1jdDI5ekVYT2JJUVBRV2ZCU1FmK2txZVQx?=
 =?utf-8?B?UGszMVIxWmw2ZzMrbzNsL0RselBSMXZJNjZZdkM1SjRQT3pNR0lpWXNnVHdr?=
 =?utf-8?B?ZytpNVNKRkFpSGdJL1FlRjNKUi9HWVpzV3hGOEdFcC8yQ1A5SUJsWlhOakVL?=
 =?utf-8?B?RWI3V2szbkhSZkVNUEQyZUt6OFNsaFh3dEJzQmJDUjcyb1JjblhaTEZkVmNP?=
 =?utf-8?B?UnBZZWJMMTJHNXRXSzdxRnZMVk1vZVdZam1IRkNIOS9UUGl3UGlrV0lLS2tY?=
 =?utf-8?B?WFJ2M0xZZ01uNEtoZFdUMmo4d0ZSMGxJcUMvUHk5TkNWeE94QzQ5L2FGSm55?=
 =?utf-8?B?dDRVQjR1aDA5a0ZONGVwSmpLNDl5TTlLekk0MG9vZUUvell6WFh5K0M4NHIr?=
 =?utf-8?B?THRTOEdKMHA2Y3JmNW93YjNrQm9UbVdHQ2JlRGpFSFgrNjZ0WTRkeG56K1Jr?=
 =?utf-8?B?cDdsTnMzUC81SitIQWFFMEcrYUhUV1hrQTJReEd2dXdQTzR1c3FIUVdvVWJq?=
 =?utf-8?B?OURkQlZCRStXZTJ1NlVCclNuNlMrY1FMTk4yRUdld1J2TVZPb3hvbkRObXBa?=
 =?utf-8?Q?gi9wKJvRSqU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VGVlVDFidkNqVmxnaWloUlFpRHlNdlN0UzRPS1BVNGIzc1dhamtnSER2NDdG?=
 =?utf-8?B?NG1hdnk5NmxlOTBuUTlHY3M5eWV0Z0lMYjBENjlOLzhrdmo3UnpXazJQSEpI?=
 =?utf-8?B?TXhWeDU1Y3plSDQwNDU3M1VkQUZnUUZSdElZZ1FNbnNyODVDZWxpWkppOEo4?=
 =?utf-8?B?ekFSNy9ITWF1cmdZYUk2Yy9LVEs0b3RybWRvVUMrc1JQdjVPZ0x5eFM4ODlr?=
 =?utf-8?B?cTRhM3FsS1VYQWhyZmJ1blZSQThtYnlUdGgzaFhmcmE1MkJKQXI2clE4WElS?=
 =?utf-8?B?N0xndjFGeC9kOHRCdkpiTkZySk9DVU5aNGovUFJSQTZqMXZ6b0NQRzMrVTdo?=
 =?utf-8?B?b3lFL0R1cTRETEYwdy9zM3VkaXEzdmswMUgrYjRsTnU4L2xQdFZ2NmtESVFN?=
 =?utf-8?B?RC80SUppd2UzWUVLd1Q5cnR6bmJuelpFMTgydkJGMmlzQlF4eTJEbzNrVS9u?=
 =?utf-8?B?cytiZHZ4SEFZREp2SVJVejY2RHBHY2t1NVpxM1dXQm0reTczWmJUZG4yMlZ1?=
 =?utf-8?B?SjJoV0FiVXdMK1JCVmNHcWxZaW04OHlKS3BoRVRrREp6WWord29EanVEWFpm?=
 =?utf-8?B?dnJzYXQ5dmgySk11ZGdxS2ZuVXI1STlRMlk2YVlCTmtBcnRSMXBwMzBZcExo?=
 =?utf-8?B?RSs1dXBWN2k3Y3Q0bGRrbFNEU0g3dkZ0QU5lWHZtUWw4a0llQ1A5TVc4ZDl5?=
 =?utf-8?B?dGJpZXJOa2pOOTFiUVVMWTB4YlRaZkMrNVR4ZDV5WUVtdjgxSnRFUkJ3dWtV?=
 =?utf-8?B?aE9qNUJpdTMwcEpBY2FzTzRaME5xUFRFeEN1TEVZeThjSXdzbTNKeWJPejNS?=
 =?utf-8?B?YWg0ODIzbmdwOWNuUVpVdEFBeTM0SFN6bUNuYm4xL21Kci9mYU9WekxXNDBu?=
 =?utf-8?B?T3ZEN2QramZWZE5JaW1rVERVSFMwYWJUVnZLUmR6TUJtSzZLL3pFZFBzNitW?=
 =?utf-8?B?Q2lqU3JYM1pEVUxZaVM2WTU1Rmp6MkJtdm1XazNaVmJ3VHczZTZHUjZYejgr?=
 =?utf-8?B?WFlhMDR0N3VqaytJaS9kL2lwa2pQV0drNW90NkNMNkJOMW5iaGNxNEpCMlBB?=
 =?utf-8?B?ZWhFc2lMVzFGODZiZ293eGdHei9tQWttdk1aVHI1NkVoNEtiVy9lV2x5VDJz?=
 =?utf-8?B?RzRhbUZSN1pkd1VDYXllSE1kV0xlaVVHUFg5SEp6T3hqaHlBMmExZDdwRml3?=
 =?utf-8?B?a3dac0x6Z0c1QnpwVW5sK1h3V1FFWVFwZk0wMkZPYmVhTW9yand5T3o4NTMv?=
 =?utf-8?B?L1lINmFxRFRXL0ZkN1pFUXdYd3c5eHpLN2VnN210RFBwVExUcFg2Q1p1OURX?=
 =?utf-8?B?SlhEVUVVTVJpTUFhZWIwVkxVWjBONTNnbW16RUtBOFAzaXhCS2VEbW44MTRn?=
 =?utf-8?B?M08vSFlMbGllOElwVG5zSzhtU252SkxNeEhydlRqN3M2NUFOTldHV0F4MHpz?=
 =?utf-8?B?ZTU1NU9DcVFMcXBTSytjMm5XWmJmTzA1NTRXL1U5QmVXRWVIZ2hWN1htWU9V?=
 =?utf-8?B?ZHV0d0czRGVPNGFodFRmcWlwdXlIdDlxQW1IcGhjbEdQRUlSOWpMRjl3TWs4?=
 =?utf-8?B?aEhNeVVVTjhkUmRaZWx1S3FBTm1JOXZhaVJDZFM3V3lGbVhvRW9Sb0JuenFM?=
 =?utf-8?B?RE5lZHFBa2FLRzV4TWNINk90SjZTMy9ISjNNVWpYaEw4UExGeDVPd3VZNUR2?=
 =?utf-8?B?L1B3WEw4TFk5dWpLYlN5dmVkZCsrdGtVTE90L08zajhWQ2hrWlRnVktjVE12?=
 =?utf-8?B?WUZwaUo2N2dvRHVBdmM3bWVxMVdieXoyYkd6Q1o4OWkxVytYZStYYzBQTlNk?=
 =?utf-8?B?ZlgrSlNhdkp2V29PNUtuaFdQWlBlTGZMYzIxMW4xSkxjcVRoWTUwdGZ2OFZs?=
 =?utf-8?B?aHlybmI4RUEyNDl5NXMzVjdKTFYrMS9tay83RTRrWUE5TnBDaC80WkVtMGF3?=
 =?utf-8?B?NkpNaTBRcDY0cXMrNDFRbXA0dzhOa01SeElhSjh6T3lIbVlIbmxBY1FzSnFs?=
 =?utf-8?B?c015UWI1djdHOG95WHZXMGpqbXVCM2pENWw2d3RMRFRPcG1UcjdYam9nTTFo?=
 =?utf-8?B?OE9Xb0laR0FKZkdsTCs1blhrbWJTenNiNTZiWTFOMEtyWGdqR05mNzFWdlhl?=
 =?utf-8?B?WWtSMFl6c2VBdkZxUmpRaW1RcWN2ZHRIejZUaEt4OUs2UWJmMmZ4M0hUeHR3?=
 =?utf-8?B?R1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	69ZjFRU0j1I7M0rGWcl07BdqhbqsxCbpH2s6BY2S3okagm9uMVuWCYloaE6S5JwFeBlmEcUlhmfrdT/OI6AxY7oo7c1pouJrYaFevJku4o63EOGDe30kRZS8nPmzEZUS8lu10VY83cCW/auBmol7i92McvZYjzYFf59N02RUC79qBEEXlOfAdJq5RNSC4yv9qkKEOhfL275+Fe1V67fKCzJMS5BKHlYt17SbfVfnfZaphUMFA80jNu3gPPAg4h3mR+ae4xFNlDbMCcM+JCWe4fjvm2sb+DwlKss3lLDHbgGyRDiGxJHnbAhBF7MgV4KzshJ7d5HVIj0tQ4hjLZi6Yoys7qQuJNfbGPvs76MTjHcIN0pihmQn/S0ANFegyu6BoXCjmEXInLg7PRFYnktMxQXi0ZTjkagC4wGZUXJrvwnSjrorD7wi0WO6Gj4MnjAnVPvrrLSHluXFpiIDYb8yJP72QNmdP5/GyEn7omdrRpOk8JAEHd9CGVXpyWThGzhg+ueMtKxsofxLAdVSyP8Z2hWJvOP1lwKYU1pqKs+IxDDkWy1dO0TcGA6jWjzJqpPYWOatrQqqi4rLKuamKiKsVejqaKLHe1/8ypsWi4HPts8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e58b6aa-62bd-4328-7ddb-08dd7851abc6
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 17:03:52.9644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Le7l+KXFrpZJe0hXPdAjWDByss8czPj6nFZ6hI+fE7K6GQmnmbu1WU1DN2CJpikvyeJ56F5G/a+14Ixj2NPwkMqurNN/nTP/rOgOnqfeUkA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8443
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-10_04,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 bulkscore=0 adultscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504100122
X-Proofpoint-GUID: _yKymxvxc3Rvt2MN23GGE22rWSkxasTJ
X-Proofpoint-ORIG-GUID: _yKymxvxc3Rvt2MN23GGE22rWSkxasTJ



On 09-04-2025 05:38, Roman Kisel wrote:
> The confidential VMBus is supported starting from the protocol
> version 6.0 onwards.
> 
> Update the relevant definitions, provide a function that returns
> whether VMBus is condifential or not.
> 

typo condifential  -> confidential

> Signed-off-by: Roman Kisel<romank@linux.microsoft.com>
> ---
>   drivers/hv/vmbus_drv.c         | 12 ++++++
>   include/asm-generic/mshyperv.h |  1 +
>   include/linux/hyperv.h         | 71 +++++++++++++++++++++++++---------
>   3 files changed, 65 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 22afebfc28ff..fa3ad6fe0bec 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c


Thanks,
Alok

