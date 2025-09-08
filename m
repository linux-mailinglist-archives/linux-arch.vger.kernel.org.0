Return-Path: <linux-arch+bounces-13416-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 175FFB49B47
	for <lists+linux-arch@lfdr.de>; Mon,  8 Sep 2025 22:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0335A1BC434C
	for <lists+linux-arch@lfdr.de>; Mon,  8 Sep 2025 20:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2366F2DC338;
	Mon,  8 Sep 2025 20:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JWdKhRh4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rXmmnpPL"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4E81C3C11;
	Mon,  8 Sep 2025 20:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757365022; cv=fail; b=QidQrR3TmBIGa3t33T+4u7gYyfrxln+0+j5csudAJ218hyF1m/8RiAuu9GwxXydKcGU7nazvciNDl7o9kK3ftZwX/W5+7opOIz6JowI5FFTXYhicslOvakVJaG5lpdG5UJ7URPfVhcTDGKbcINlbj+kgaSOqL67PeFqF6iKXjs4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757365022; c=relaxed/simple;
	bh=WjCPZiBfnf7U0jWxCn88RqUVCWM1IOr8OrA64bzyILo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Q2Kd7F0hPlK0lP7Ap8j2lLsjkkoGIS1fr42XqcdK+JCAZpDLy81Eyf6oCUqNl5uaEbA6YY23jL1oUXSVBx7OdTNSNdmFsT9/8QeKjXKe4UMTPP9+OJdo7XPyBATDgDvO1FOkKvhGG2ydjHB1uIK2/iHXKvyQfoskS1xG03s+3DY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JWdKhRh4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rXmmnpPL; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 588Ktlco021275;
	Mon, 8 Sep 2025 20:55:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=QMvtNVJ4Gep9T/m4bXl8OVS8azJ1Llgl8TWelwxnpwY=; b=
	JWdKhRh4dFS154Lo+h89raa09kK8K4HkAXR7DnvpF4la4sXK4FloXhdUzkTBs4xl
	kmeeMFSobqpY3lB9VwRjkIUm0aZ3r9a6vlqD9VuxsQNavsdR+FO+2+Cl94ctBkGT
	xAgmGGE8CIX+qsLR7rWYTp0wwTLeWIszecKM/ciKaKOaSEo2XBZ+UxJ34oX+RQyl
	0KJ2ef9URCLBffp4OIHCEU4L6E133cW69X8GZQezZ/Aybo7QafBtN3MHfqTa/bde
	19dSIbVjPKIj9O2fEIcwc6+Wh+BZaToDh5/N0R4tTvpY/vt7CaapzAfjkaiSR79C
	BJK1e8KhU/5mc1gqgg2C3Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4921pe8mq0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Sep 2025 20:55:48 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 588KPLst002889;
	Mon, 8 Sep 2025 20:55:46 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 490bdf7syc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Sep 2025 20:55:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GAc1vxaMPO/36jPV44fOVPIXPvYcklLWh7oy/6luoSLLQUAsS5iJP8lAlrTh3n5GQAeov7CmHhMsLoy+3ARtK5Janmix0LHUcizernTSsC4jt/3NFHJzlSabDCCMPoMjTmMF1s9OIhnYK2ugo84Em56LV6PMStD/49YmMxy/EW9xCklcvK0UXxAsfpdknndEmt9p97hXqjHQ+TBzI8YqTZnRCe4zNDGJdebslig2KRLLp++OWjmxF1typRx/i7ddHjUmr92eXP3K0kC414Q6S+Qn0chbtg1fRH7DC6Q5wvNS0nLVroyqY5wpSbnFjRIAN5yF45gyXIwXA7pvzis0mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QMvtNVJ4Gep9T/m4bXl8OVS8azJ1Llgl8TWelwxnpwY=;
 b=A0h2ntjC/HR9I5aTp0/5lsm5+1gDNYHWs2lua/k+JvoCEoY6CvdO7DkAsWq4u2dGtEwi1/N67CSw5wmkKZQshOr0266kBImXQU7smnTi2l7yn3HYFHFiR0jx3DWu4uLks/mlcEj38x+HWWbayBGDthVO0cIjrNcqYQTfAL8cPE1PfLkO8Gu+zMwb4N50TXVkgtmBi0x+BgdVSsAAJ1V8hbTnGC+sCKgcodhbxHPUi7HFj0zMBI8TKHZJ4ufjezL2C6vNR1FONZiwFvPXTtavmrbtxqVwmvi1QPiiABWz6aZmosGz1siYVpAAZvs2Set2hLzN4Hkb1v4JxzFc/wXHeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QMvtNVJ4Gep9T/m4bXl8OVS8azJ1Llgl8TWelwxnpwY=;
 b=rXmmnpPLveoW6uEdBsdWUkZjgAYTQUjZ7KQa36ZAYES+YxsM2HqJCWD+020vWkaOKj4N9ZGNb+82UGcVmZm9TJ7kRrEexjfVNAozgtz1RsLDSZ37a3SuMG67+B+XLHNiMw7ClGoICPsX5ClNErHalLYcLoYQx2bOILQMqJP0f08=
Received: from MW6PR10MB7660.namprd10.prod.outlook.com (2603:10b6:303:24b::12)
 by BL4PR10MB8231.namprd10.prod.outlook.com (2603:10b6:208:4e6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 8 Sep
 2025 20:55:38 +0000
Received: from MW6PR10MB7660.namprd10.prod.outlook.com
 ([fe80::41fa:92d3:28b9:2a15]) by MW6PR10MB7660.namprd10.prod.outlook.com
 ([fe80::41fa:92d3:28b9:2a15%5]) with mapi id 15.20.9094.021; Mon, 8 Sep 2025
 20:55:38 +0000
Message-ID: <74410776-0e8a-464c-b725-9780a0400afb@oracle.com>
Date: Mon, 8 Sep 2025 13:55:33 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 22/22] mm/mshare: charge fault handling allocations to
 the mshare owner
To: David Hildenbrand <david@redhat.com>, linux-mm@kvack.org
Cc: akpm@linux-foundation.org, andreyknvl@gmail.com, arnd@arndb.de,
        bp@alien8.de, brauner@kernel.org, bsegall@google.com, corbet@lwn.net,
        dave.hansen@linux.intel.com, dietmar.eggemann@arm.com,
        ebiederm@xmission.com, hpa@zytor.com, jakub.wartak@mailbox.org,
        jannh@google.com, juri.lelli@redhat.com, khalid@kernel.org,
        liam.howlett@oracle.com, linyongting@bytedance.com,
        lorenzo.stoakes@oracle.com, luto@kernel.org, markhemm@googlemail.com,
        maz@kernel.org, mhiramat@kernel.org, mgorman@suse.de, mhocko@suse.com,
        mingo@redhat.com, muchun.song@linux.dev, neilb@suse.de,
        osalvador@suse.de, pcc@google.com, peterz@infradead.org,
        pfalcato@suse.de, rostedt@goodmis.org, rppt@kernel.org,
        shakeel.butt@linux.dev, surenb@google.com, tglx@linutronix.de,
        vasily.averin@linux.dev, vbabka@suse.cz, vincent.guittot@linaro.org,
        viro@zeniv.linux.org.uk, vschneid@redhat.com, willy@infradead.org,
        x86@kernel.org, xhao@linux.alibaba.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
References: <20250820010415.699353-1-anthony.yznaga@oracle.com>
 <20250820010415.699353-23-anthony.yznaga@oracle.com>
 <a0238ff1-3ca2-4f0b-8452-26584b531724@redhat.com>
 <3752d094-e754-4453-b404-75d92de3e364@oracle.com>
 <fbbd4b7d-1614-4d6f-9f7c-2821f35404ae@redhat.com>
Content-Language: en-US
From: Anthony Yznaga <anthony.yznaga@oracle.com>
In-Reply-To: <fbbd4b7d-1614-4d6f-9f7c-2821f35404ae@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR21CA0005.namprd21.prod.outlook.com
 (2603:10b6:a03:114::15) To MW6PR10MB7660.namprd10.prod.outlook.com
 (2603:10b6:303:24b::12)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7660:EE_|BL4PR10MB8231:EE_
X-MS-Office365-Filtering-Correlation-Id: 964e9e8f-7ced-4d2d-526a-08ddef1a1076
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NGQwTWtUeDZvN1gyQUFpQ21ZVkxLQjNRSmRBejNwMGVhTFdKaWpQNm4remVV?=
 =?utf-8?B?a05yTXlmSGRseElrRDYzZUIxV21nV0xXcWpoRVZZTmVFY05TdGh1OWNBQ3Fy?=
 =?utf-8?B?OXJqNnZ2cUM0aXkwYmsxanFVd3pSY2RBOUd3eHpUL2tya1d1aC9MMUV5dzFE?=
 =?utf-8?B?ZWNoNU5QUE1iZGpXMlgveXpJN3BrelVBczBxOHdEQUdWemlMQklia2VmckRO?=
 =?utf-8?B?SmFDOExSLzIvQ2NKWjBzSzJ2cmVsRlFYVFhWL2V5ZTNLS1A4Nm04QjdVZU9s?=
 =?utf-8?B?ZWcvRTdMWWhiRlVwS3ljd2RldS85V2tPcERWZUxOU1l5QmJkNjVSb0ZYcWRU?=
 =?utf-8?B?RGlBRFBZeHdjVmtNRXN5VkJ2TCtKM1dLa2ZJYWNEL1dkeUpEZEZjVWtaWTdh?=
 =?utf-8?B?ZEhrK2h6M0orcGZJRi9YVUVrcjhRRkVyelpUT0R1MDY2eXN0RmVXbnVLa3N0?=
 =?utf-8?B?VW5kdnlZM0JYNXdsUWtzWUllM0NXSlVLNmg3OEhKL3hMb2V6VVM5Z0d1RnpV?=
 =?utf-8?B?QUwwSEdQOXE5Q2FGSmJCenh2bldVN2pYV1RqU3FqcDRrOWZEclR6OGJPYk15?=
 =?utf-8?B?blljVTBkQmp3YXdnZHIvVkgwSmNLaFFDTXF1VDRvR2M1dkJDL1g5Wjdzcjlp?=
 =?utf-8?B?alB6SGgyVzdoVXZ1ODhPa2tZYUZIYXQ4a0RTZ3IySDQyZ2taNWVaOCtFVy8z?=
 =?utf-8?B?TnhwdXU4OXNMd1ljYUp1STBqTnd0aTFOSERnaXNKdWdxT0dZRk9FYTlXeVRZ?=
 =?utf-8?B?c2RwNnZ5Y0EvV0x5UmQxbG5hWmxYR2ticHdJeG5aVVIzVldjYzZxdW1BUEs5?=
 =?utf-8?B?cVFaZ2dmblQxcHQ5TE9lS003ZGRocVRxV1paN0V5TS9sSGZaV2FnUEEwcm5N?=
 =?utf-8?B?WW1nOFdMTGt5WkthMlYrUVNnVGI5bUc3T21RRExzV2w4SERPM2FhU3FNUFFG?=
 =?utf-8?B?MXE4bkdJWFlzZExYbzIyZWtpeFo0RkEyMmMrYmRiY05oU1JILzNRQmE4N2FI?=
 =?utf-8?B?YlhBd3IzY3VyZ3pLNk1BMlJRTXNLQ29sYmVkMFllMlY0VlhkVnVIM2x0a2JO?=
 =?utf-8?B?cjNNcVNzQmVWRWNDOGlPWExvTldBQWhoMUtyc0tWTlFkTW9CMlBZMVVXZWpn?=
 =?utf-8?B?dE1aL0FNVXl0Y3J6WWE0NEpJZDgzYVY2dFkyV09Sc29vSEI3eFBwVU9TeE0r?=
 =?utf-8?B?Z1ZNQkNMNFdXVWYxdk03aHVrWUZCcTYrVk5HeDN5V3FWdGZRWStpUU5kTFh4?=
 =?utf-8?B?ckFZbElHa1k2QkhCUGVsR3FxNVA1ZmM1MkZTalQ4WXByYmNIY0QyVjVoT0hx?=
 =?utf-8?B?ZW9ua2l5RitEQUtHbUFuZDV6YkZleW1GcFRscndZMkZac1Q5d1J6TWU4UVkw?=
 =?utf-8?B?cHpSdjJYRFBWak8vL3VpSW5ocHFEb05hNnpMTnFoTHd0Uk5TQnd3ZU4wNno1?=
 =?utf-8?B?SXBpdnJqMEFzS3F2dzZITjVYRHdOMGZJSUJrd2xSNlBPSkt5TFlsbFl4azZD?=
 =?utf-8?B?aTM4b293OE1EOUJmTUJHMzJBL0JFL1l3NEFBdzZndDJ2ZzJkUHRzQnRxTjRG?=
 =?utf-8?B?SmVreUhGQXMvM0RyRyt0SXZIT0J5eUZrVGdQN0l5QUovMDkvK0FBSWlRTVRW?=
 =?utf-8?B?S1ZrQWpaTnhSYXY1MDFXT3NLQlVTMmZDSlJaUWpGT214cEtrZ0tqY3JnWWNY?=
 =?utf-8?B?aENPNkd3ZGRxRE5OMGF0cFB4M1MzdWtmMU0vZ2pkbjlpRWRZZTQremh2R1pu?=
 =?utf-8?B?Q0VXd3k1bU90WXB4ZG9ydnJUS2ViejNzVVJvQVVKSFdkZHdsMTJRWHc1NWlr?=
 =?utf-8?B?UHJ3NndXQUFlY0tHdmFqTEFEck94cXNQQW1ISUlTempLNHNtOURaRzdaNG8z?=
 =?utf-8?B?U0NaazIvVWdLV1lBckxHT3RYM3ZTMnNtNWgzb1lqditPTUdsZVpqOGJvaHR0?=
 =?utf-8?Q?KJcpsAI7gew=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7660.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VUxuRFpDbGVZZ205V2Z2aGF3bnQ5RzcvVjZ6czFqRWYyZ3RxZjZvcmNBRy9t?=
 =?utf-8?B?bjk0YTlrRHVvdHQ5dE5Gekh6aEpxUGFLcXZ3azlvM0tPd3FqQitPV3Q0ZHVk?=
 =?utf-8?B?TmJ3VEw0a0dRbG0zSXJ1ZXJCUjhOUHI0a3NRejZpZVRSVkZYbmdHRXJ1STdk?=
 =?utf-8?B?dDV3ZHplTGNwK0YzbHh5VE5Yek5YMjdSNVpWNElFdUtBVDZxbi8rNWZCajFr?=
 =?utf-8?B?SDB2cmZaWEJkSjIwMGRFMGswK2plS0pBMXI0LzZpdjVxaEpxNGxmazN5NzNp?=
 =?utf-8?B?VU9Wdk5Pc0JKQ21CSW1EQW5KSC9yNURxdlpBdWFvK09vVVBCNW5qRnorckVq?=
 =?utf-8?B?V2FNdmhUb3ZYYnM4bUZML0tOSEhyd1BIbjVHWitSS2tFVXNjN2FlV1NDL08y?=
 =?utf-8?B?c0F3NTJGYThpN0YxRHNLOUpYVDZDbmRZSkxBSVh4RjRpMXZ0NTFJUnFKcEd5?=
 =?utf-8?B?Z1hsTmlsbHJzVnNkcHRUTTVidDZLOXAyc1RadDFvN1plQVArN1BDYU9Ya09y?=
 =?utf-8?B?dmJBOFN1bnNlT0VnVDhaNXBYYXBEQ2h4WnZWR24zTFRydDBRWmlqVHZ0RFVV?=
 =?utf-8?B?WTRNNW1YUFJxQk5Ycmw1dENFUFRnZVV5NFdoN1FjL0phaUFUcmlzTlk4dzZ4?=
 =?utf-8?B?UHVuUmV6Sm92cUM5YkVFY2IyT1psUzUwRXdFb0xiWHFDMjRZaEZsdEhpQ0N5?=
 =?utf-8?B?MTFNSFhueDlDMXlTQ1JnNm12S2NZL28rU0dCSkJoeGNDZFlGQkNFV1YyUjJZ?=
 =?utf-8?B?Wmo5bXc4dGdsazJ2cXhRb1llZThQK0JCeHZoQStocjh6WC8wZlRDak53VEhF?=
 =?utf-8?B?b0pSUWxmOFpvRGpkSVZBT2JUL1R4UTh3Z2ZYejVLNHZQSGdpUXNKMTJCcGFo?=
 =?utf-8?B?VVdZdHp4MFZ6eDlaOCtvUmJrd3JEbG9rbHZ1NEE2bmZSMTRQUlhmM3h0Z0Nz?=
 =?utf-8?B?UHovRmcxUlZvVUxTenNPNWh6d3lTd0JiMWVFT1ltclVjVytKemJwWmVpNmJZ?=
 =?utf-8?B?bTd6SlZUN2tZKzd0QTZ0UGgxeGt1bXpHOXY1ZjJBTExEbzZyN24yUll4TUlR?=
 =?utf-8?B?Wkhrc1FBTmI0emp3T0syREFnZCthbDVURm53R1UyaVN3cWtSdUFyQTM4OXBL?=
 =?utf-8?B?R0EvZDhhNHJ1L3RBQUlIV2VPcUUwQ29UVVNNMngrUmpqdlZNL29HVXJJZXRC?=
 =?utf-8?B?dWgwRzd4bTV1N0J6RDcycnZ6YUpTOFJrN2lQUVNzT2JIZXVJbUlNdFlwNTZX?=
 =?utf-8?B?ZDBQMkd1d3B1VDFNZHN6YmwwRGx3U29aR2wveXMwWUxWSWxjUUcvR3NhMG5m?=
 =?utf-8?B?R0tvUVF5bjhRdmtPSmJBQWl0UGFaL2V6enUyOWhGSmpSR1RML1VleHdFQ0JC?=
 =?utf-8?B?a0NWVGpLLytoUTRiY043bDRFcytLRjRNK3Y3SU5XSnFWVWl5ZlVVWHQ3Y1lx?=
 =?utf-8?B?WFJHRTBId1Y1aWpsWm9PWEZVbkVXSS9ldmlZRlV4anAyYlpOOVdHSndSdThW?=
 =?utf-8?B?SDhYZG9ldHVjY1p1OFZvZ3M2TXdTMVRMVGdHaVg5cUFWMlN0MXhqK0lNSnRV?=
 =?utf-8?B?ZnBWY3pwS29sOUdJM05JSzYrbFBsZXl6MGNxenY4aVB2NHZhSFZOTFdrNzVw?=
 =?utf-8?B?L29Ibm91cE1NMTNjRjNFd0NBSytJckkrdTZOTDkydzd4Vk1FRXZKZ2JjSmNC?=
 =?utf-8?B?SU5QZmhwSzYyeW45ZkdJdFkwbFdiUndTMUNMdy82WFVGZDFxSDBDYVNNR21i?=
 =?utf-8?B?Rld0aFkrU2x5R1ZqNEJiVmVmMUpFZHRMT3gzUXh3cmZ0bnNuS09vcWcrOTVO?=
 =?utf-8?B?dEk3TWlJV0xyLzRrVHY1em1Va1RDWlZFUkI5eWdWZld1TE52bFFMWUFNTW04?=
 =?utf-8?B?QUEvcTc3TEtMVnM4TmVFeG5hTHdCdjhKT1BpWkNPVUxDUmVzUmh2c0JpS3Y4?=
 =?utf-8?B?eTdGK0tjL1dCeDJTQXF2enhlMHVxekZCcnlVYXk5aTBpRTdiUGFLOFZleGYv?=
 =?utf-8?B?S1c1NTI1ZThEY3BZcmo0d21VY3BUa09HQ0t6NUFjZGFWa2FQbDhNeXE2a2Vw?=
 =?utf-8?B?cnRxeStVanQ2K2cvNnE4QXJBOHJyRHA2SFU0QW1uQ2lRaDFadVo4aGI4TGVP?=
 =?utf-8?B?VEQrWForazVMci9CYnJ1OEhCZGFIQ2tuaUIwK2NQV1VJZkl2RGhvTmIxU0VV?=
 =?utf-8?B?bnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	aEZjP8JGLawrVIv2EL3NnAzt2bVaDEmosO6tNukdBs1EFxZWO/fu9LCBbE3Pa65mhK91GjSEocx1TTOxN3xo7RdvQZhfo+6ZjKFMCXD4DPdmMsqIuNGBNyq5cQgBTHhmUMjca4yRUg9Sh7TlI+yUGXqjpuPfoQ7OFgB+bfSIZuIQReJgdAQmLD7Tx5mElpZW8sJhe7BKOJe3Te6r1vceWz5I13POjVwM0s/ZF+M0CgEcQL/JrUoz5o3IX2X2R89PURfUezfssno/QNeB4Gmcd/xsyWzDBiFXpdD2aXmjjzboHrJxgCLbOq7vZsKQr2jwhBfH5OdbsEnprlofmkF8Ylq0iyaK76Qn4WMSvwdz+Q8GCFoczJtGZEynv1rnnuiNUf4S8LO3IDJ8fOeOMKQZdETLiErfEnmUjDh+ShGKmI2ofBzai6uFy0KEkgVV8+DYUJRlvDL5rhhjukXTNinNRU+eSakO1PIqh025XDCSOkMTiN1X6AvRgfE83bervR88vqsGxRVYSYEFV1iRA16VQz/ZrqNuzmE7JL6muKcJ/uFgPDw9AIg0W+YMlSsJK/texLHCp8aSrHORseSCubP27gjHorlHSBRd8hf/UO8Bokk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 964e9e8f-7ced-4d2d-526a-08ddef1a1076
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7660.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 20:55:38.3293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XxxXGqGVM5jbYqx/fKqZmlX/cAhH46oujqICdGmqyyjwZzNVnhg7Rd/vmZPNfrSiZEk4dn7fj4waPFMTRTTTkST5VLjt9dMh3vgYNDnKE4A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR10MB8231
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 bulkscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509080206
X-Proofpoint-GUID: b5HgO8gE4FPcqHeqpvpTBovd2v3tZF10
X-Proofpoint-ORIG-GUID: b5HgO8gE4FPcqHeqpvpTBovd2v3tZF10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1MiBTYWx0ZWRfX38PyNRWCkZCj
 4o+Zvi5+ntjuJgyUNerBzEqKDA8TQx0QChYSS6YVjv50fWT3r1FjcTzm1GP3/v+x9qVBl2lXPtd
 EntEFxSFB0kekWnwaEpyo4VXcVQSU44XC0SLE92TTXHlyJGJ5thzbgJ6Tk/V5pCMl7rxK9YtD0n
 Q13Z39z5pSFDilb4maYx66lDwTOYEkDXh3jaHvxCnVVDCj2f0Mp1Dwhd4v9mF9/6litt6LGiBgf
 pZ7jvqkNdFArnwpRV33qrTXep3RXJBCx/HwglLNu1Lf9K8WuGAGniJzpFbjok8lQjvC6p4Qgg5D
 dQ2LNRFaIqMrk6MTyAmortLqzh2IG4jw1+VasBaVohHUE/vh3I2FlE/DC37ap9hQHaRrjnixy2y
 nwInziScL9MM5Agsdiw3mdoLswLe7Q==
X-Authority-Analysis: v=2.4 cv=b9Oy4sGx c=1 sm=1 tr=0 ts=68bf42d4 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=gvk5xnXEtd-PH1V_gY4A:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12084



On 9/8/25 1:28 PM, David Hildenbrand wrote:
> On 08.09.25 21:21, Anthony Yznaga wrote:
>>
>>
>> On 9/8/25 11:50 AM, David Hildenbrand wrote:
>>> On 20.08.25 03:04, Anthony Yznaga wrote:
>>>> When handling a fault in an mshare range, redirect charges for page
>>>> tables and other allocations to the mshare owner rather than the
>>>> current task.
>>>>
>>>
>>> That looks rather weird. I would have thought there would be an easy way
>>> to query the mshare owner for a given mshare mapping, and if the current
>>> MM corresponds to that owner you know that you are running in the owner
>>> context.
>>>
>>> Of course, we could have a helper like is_mshare_owner(mapping, current)
>>> or sth like that.
>>>
>>
>> I'm not quite following you. Charges for newly faulted pages will be
>> automatically directed to the mshare owner because the mshare mm will
>> have its mm_owner field pointing to the owner. On the other hand,
>> allocations for page table pages are handled differently.
>> GFP_PGTABLE_USER causes the accounting to go through
>> __memcg_kmem_charge_page() which will charge them to the memcg for the
>> current task unless unless current->active_memcg is set to point to
>> another memcg.
> 
> As a note, I think at some point we discussed re-routing page faults to 
> the owner, so the owner can take care of all of that naturally. Is that 
> what's happening here?

The memcg charges are routed to the owner but otherwise the page faults 
are handled using the mshare mm.

> 
> 
> So, are we running into that code that we have current be another MM 
> than vma->vm_mm?

That will always be the case when handling a page fault in an mshare 
region. The fault handling code uses the msharefs VMA to find the actual 
VMA associated with the mshare mm. The actual VMA has its vm_mm pointing 
to the mshare mm, and it is the VMA passed to handle_mm_fault().

> 
> Reminds me of: FOLL_REMOTE->FAULT_FLAG_REMOTE. But I guess, we don't 
> take care of different accounting in that case.
> 
> Anyhow, what I meant is that you could just check whether you have a 
> mshare VMA, and if so check if current is different to the mshare MM 
> owner. So I don't immediately see why MMF_MSHARE is required.

It's because it is not the msharefs VMA that is passed to 
handle_mm_fault(). At one point I did have the code for setting 
active_memcg in do_user_addr_fault(), but it did not seem as clean.
The msharefs VMA is not passed handle_mm_fault() because protection 
checks done in the arch-specific handling need to be done against the 
actual VMA.



