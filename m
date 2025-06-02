Return-Path: <linux-arch+bounces-12184-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 443A3ACBD05
	for <lists+linux-arch@lfdr.de>; Tue,  3 Jun 2025 00:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3FBB16E391
	for <lists+linux-arch@lfdr.de>; Mon,  2 Jun 2025 22:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72521DE881;
	Mon,  2 Jun 2025 22:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FC9CRp7F";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="iTryXXPd"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA372C3250;
	Mon,  2 Jun 2025 22:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748901816; cv=fail; b=g9ljLf1JjLCw4wLms0LwGJt6fyfFWAA9guYS8U0lfaZSxyHzukrrxYYIRj6OHXj+g/s/V6w5JDszVSLnM7uN6bnqwZIWtFbla0dRamIk5ueXzQoW9Zz0pe72O0tMdPsEAUDYaJZbJEbYD/pTKPIK37IAovY+B1kpGk+1CzoZ4QY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748901816; c=relaxed/simple;
	bh=V+0ZtAnpB0iVJKuUArPTvANNeN1HAaczOquFII8WOvc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=alFVMGhM58qRPeeKpyrk7WrgtxzUKb4CV5gNPZ+Hw98Wh6b1C5CZACYyXiLUVoLMe9SxoJ1E5YeoLj1gcm12Ox8gCgA09rlK8P1kve1XuaVvYKIBHjGnwskR/0hvIDyMcZhAYeoZ+CyvLxP7H+qpgUVmlbZpXVZp1Ou10MjhvWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FC9CRp7F; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=iTryXXPd; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 552LN5dS000917;
	Mon, 2 Jun 2025 22:02:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=D+eGfB7/ziqsu1LSyGLFGXKS7LWCh9QJj/pzGWUjk/U=; b=
	FC9CRp7FkZMEjEUNhFc9Lg2VXSqfS0FkA8IY6uQ6D7NqWCTQ1qzMF+CM111vfsTh
	2FtX7VgUZ2V7UUCzmfBDEuSQ/gupQyNVawFM+eqcDMr5L5JqhFAgbwAnyXcc3cKl
	iEaTgwUWxgVV1dEJwxhj1s3iMWnUipEpxDBlI1dONznRYdYLadyny1JyYj0G53BV
	HRVygXs/8nt1V9q8j7uE1lG5h30hfLq/2+5QnlQ7ZRhqKuCxGOWSP0PzusGnYCC/
	iXdnwsRURqiWqSzQkImh49k1ciUadHfXM0OO2FvHA6s9poUyrWLmWZ4HcYZ1RECm
	CJEkPqW1TlkgnPyXfgjzLA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 471g8crj1y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Jun 2025 22:02:47 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 552LGxlK016244;
	Mon, 2 Jun 2025 22:02:47 GMT
Received: from cy4pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11010019.outbound.protection.outlook.com [40.93.198.19])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46yr78hphk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Jun 2025 22:02:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X/4/RRBjZo6MKxznLRad7sZ94b61blibyvURn/1nUbiG0c/5f8gOwewkELN24NZ0PJp6bg7MdQwGC6OHvwO9wktvvaBRMKc5QuvfPXGRH5lVurijb2XeFBzLxhB9iKZf7UU/KQ4D+2K4cQDkJGt0OdWLP7uoVPuMhUoQWvYeVVJ6QC8enQrU/7k8Gy4neM+ELFc4IiIDG6nwzUBpIAZ++O4mQbrb6IhtKS6jXvDuwSI810Ep2jQ61XDnp6yk0H7asmuXZZuXEqk2uJgD9My/iBsF9GeFdXxhf/dkZK35mKgZeGklvwGmClU/4T6pkHKosLbciKWzwnj6lbroE3EQGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D+eGfB7/ziqsu1LSyGLFGXKS7LWCh9QJj/pzGWUjk/U=;
 b=jOGWQmN3a9Zy9AmC8DA0Fo5f/SvJaLGhqi4e+owdjViCYFYTQOfOPRLReijIya97MkjgdsFAecfAIhELQQqQ5h+Nr5SWpvSzBGBnAVR3QpTSL/+xSOpCX/0i/SCyI4NAYxA8OXD8LJyRpbL084tPdBUKbEaWxMM7CweMMxxG3ZoA/u3Df8hJZ/dSfHYm7YCU64hCXtCYzDUwkkcLF5ITTeI/ddKdeoTD2c0AbCpowAKtRG4+Tzm+d5c8KJQlqlytnTRoLrCeD3rUHdDZefm7sOE1aVjsrHVrmS+Vkm0XtfkMdJ/gT2bw9eNk0bSBUdsXApNNEOqVzLW722y0EiYMzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D+eGfB7/ziqsu1LSyGLFGXKS7LWCh9QJj/pzGWUjk/U=;
 b=iTryXXPdqN1QZvkAiP13a0KmBVpbb1ve6koZLYckw+b0POAothnF8A/8R3UyCjxtPuMyRbxIZUb7Ej18jRUtyw1nNK8JWggSmM5Ffxp641B1k1oO5adgijlAqVgRBRrMKfAHLsDmWVJpbm0i7dTdVRC6JZ7X0hPl4s5FdCwsPTM=
Received: from MW6PR10MB7660.namprd10.prod.outlook.com (2603:10b6:303:24b::12)
 by SA6PR10MB8038.namprd10.prod.outlook.com (2603:10b6:806:43c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.40; Mon, 2 Jun
 2025 22:02:44 +0000
Received: from MW6PR10MB7660.namprd10.prod.outlook.com
 ([fe80::41fa:92d3:28b9:2a15]) by MW6PR10MB7660.namprd10.prod.outlook.com
 ([fe80::41fa:92d3:28b9:2a15%4]) with mapi id 15.20.8746.041; Mon, 2 Jun 2025
 22:02:44 +0000
Message-ID: <1fe10a54-64c9-4808-9d4a-50edf5d1662a@oracle.com>
Date: Mon, 2 Jun 2025 15:02:38 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/20] mm/mshare: prepare for page table sharing
 support
To: Jann Horn <jannh@google.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, markhemm@googlemail.com,
        viro@zeniv.linux.org.uk, david@redhat.com, khalid@kernel.org,
        andreyknvl@gmail.com, dave.hansen@intel.com, luto@kernel.org,
        brauner@kernel.org, arnd@arndb.de, ebiederm@xmission.com,
        catalin.marinas@arm.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhiramat@kernel.org,
        rostedt@goodmis.org, vasily.averin@linux.dev, xhao@linux.alibaba.com,
        pcc@google.com, neilb@suse.de, maz@kernel.org,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
References: <20250404021902.48863-1-anthony.yznaga@oracle.com>
 <20250404021902.48863-13-anthony.yznaga@oracle.com>
 <CAG48ez0gzjbumcECmE39dxsF9TTtR0ED3L7WdKdW4RupZDRyWA@mail.gmail.com>
 <7fb16136-947b-4a72-8134-60d95ba38c1a@oracle.com>
 <CAG48ez0i527ibBCvZ_TF_PVt4OxfVTpS=_TYUKrk0cRQ10Bpxg@mail.gmail.com>
Content-Language: en-US
From: Anthony Yznaga <anthony.yznaga@oracle.com>
In-Reply-To: <CAG48ez0i527ibBCvZ_TF_PVt4OxfVTpS=_TYUKrk0cRQ10Bpxg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0071.namprd13.prod.outlook.com
 (2603:10b6:806:23::16) To MW6PR10MB7660.namprd10.prod.outlook.com
 (2603:10b6:303:24b::12)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7660:EE_|SA6PR10MB8038:EE_
X-MS-Office365-Filtering-Correlation-Id: d1d94a73-0660-45a6-4afe-08dda22133b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?LzhhOWt6QUZTSVBYNkV4VnV1TnJ5Z0RyMktNa05veWtRWGxOSzVFVXdTcVdq?=
 =?utf-8?B?cXF1WkxhRkUvQTFFU2dPSlNFZm1Mb0pxeW9OVEJ2QjlLQ1N1YXRSdi8xaVND?=
 =?utf-8?B?ZEVVSWU3dHVVaDNlczJmaXV4K3dyUHZWOW5LSGdmeXJmTUY3eitiUEx4cG5Y?=
 =?utf-8?B?ZFprMmluMllKYkpFQVUwWmowanpQVmVFUUMvUS9pTHpaQWFJWmRlVWtUdUFn?=
 =?utf-8?B?UDY3cGpTVmVQUmVOc2dSRWZkRzdTSkxBZ2UrR1RmQWFMTW4xSDlmeVNwZk9z?=
 =?utf-8?B?RTl5NGczOW01OFYrWFpUbmRuMkRVaVFRQVFacllzeDhZeW8yTGhseE9jS2FP?=
 =?utf-8?B?L0VuNU1CaVFpdGV1cnhaS280YmNzNEliWVBTWmEzRUZXKzFCb2JFMzlmbWVi?=
 =?utf-8?B?VjJKT0lEQ3Jjc2ttZzduVDhlSWxZL0piaHZDclRNUWxLd2dCbmVIWldoSTJp?=
 =?utf-8?B?azh0Z1A0L0c4NGZmR0VDcS8yQ0NMeWVhVyttQUtuRW5MNXpqbzdtbWw1dnZp?=
 =?utf-8?B?Smk0Y2VKK2NjR3FSZytDUTFRMm5MR1JQelV5U25UellsQjR6VXlaMHVMYmpJ?=
 =?utf-8?B?Q2w5dVlFd0Z6K1VVQjV5Z2dqbm5xaVM2elhHVHpTWkRiRXZkS044ZlY1MW44?=
 =?utf-8?B?aU53SDJCeDhFY0g1YnJnZDJhVXljNElnRnhXNVcrMEU1aFhveUNTVU5DcnZJ?=
 =?utf-8?B?Z3VwaHRQZHZLaGI4OUlRKzl6QTVjdDBsZVdySkRIOVg5QWwwV0s2cEtyeVhy?=
 =?utf-8?B?bkNhRUNRV0d3cVFlRER1aWIyY3RRSmFPeDA1NER3UTYvQTQ1YVluSzlwREJY?=
 =?utf-8?B?dkNkcnNEbEVjdU5NZU0rMzRhcnlZMEd2Q0JrMGV4N29oZW10bis0ejlMUTZT?=
 =?utf-8?B?Vk9WU1pwNG5DSkFPbG1CcTBSNzdQcGJuTjVLcVJIYzBMcjhXMGJETHgrUXMx?=
 =?utf-8?B?NVRHajZLUG8rWlp3OWhLWjd6UkpEdHFCa0xXK2NsYjVoOXpuSXJHZTRabmtK?=
 =?utf-8?B?L1BBV1NQeTBZN3QwV2d0NC9QaUpFZFdGcjRUbDRVbyt6S2UzcnM3b1RZYS8z?=
 =?utf-8?B?MGJrSDUyYlppV3Y0cDRMdUV0Y0JiRDlrUCtwWEQ0NFRiRXdabE42S0FKM0hK?=
 =?utf-8?B?T1Y1Y3V2NlVvUDRzSStXUVB5dmxaaENqRTNBajJZQUZpRVNMWlp3ZE54L012?=
 =?utf-8?B?eUMwWEtwdjl0RzF4ODRZMFU1dEp1NjgrZUUxMXlDWWtRUmRNSEhBTWI4QnBL?=
 =?utf-8?B?M2JxSVplTHJSR1p0NTZPdlhoOUpNOVhrK2h5WEMwMEtTdU4wTUNiSzZvWmRK?=
 =?utf-8?B?ek0zdlJxMXdPb3h0a1lBbzJrNk5jY3FHRjNDcis0eXNmeWRFcFhUa0ZqOVNX?=
 =?utf-8?B?dWVTcjVoc05ENGlYM1BpOVNqSXdPVEJkNjQzRmtDZHhkTi9CYkt0Z0ZJcVNo?=
 =?utf-8?B?cy9GZ3kwbXlSbFVoRXlTOStyZGxtRlM4TkgyZjh2VkdaTkIxcXY0bUJHUUt1?=
 =?utf-8?B?MzRTSHNoMnpCVzlNd281SnQ1V1FURlcyazdzcnNsYWwxblJvWFU3MERROW1Q?=
 =?utf-8?B?UnhkdVcrb2prQkxJUkhwbENOcDI0d1U3eHpUck9qWmVXWEpxTmgzcUxwcXZp?=
 =?utf-8?B?OXpxc3N2WUlCQmV0b2NSN0VBZmcyZVNNN3RJSEpOV0NyZnBvRExXSU1zTWVB?=
 =?utf-8?B?SnRGTXpZaEI0Q2lkMkJXaXRyUmZZSkRWYkF1T2dOL3EvdXdrMGFKazY2TENw?=
 =?utf-8?B?K21maXd6VUE5MTFGams4WTlhOWc0MVRaL1MvWkQ4SGxwTzN4OEE0UzdSUllO?=
 =?utf-8?B?SGZDZ0ljUkpSMmVINUJLTERobUFaQzEyQ0NEek9mRzI4QUZGVDRhd2Z5U25w?=
 =?utf-8?B?ZFNoUWFLb205WmszcjFaVGVncDc2cndHa1U5S3owSlJ5cVFxWXUyQU9IeWhw?=
 =?utf-8?Q?fPppwkGqZw8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7660.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TEFEVWRiVG1IV2cxK29lRTlDYzhVc2xUUlBaQlZVVnh1cWRQT0ZtL3JjMDdH?=
 =?utf-8?B?NHIrWklXV3NhQXhOOWJpVlNmMHpFN1d2RWhmVlJHRTZTOXBjbWxrOXNpZW00?=
 =?utf-8?B?cUhFV2lVTS95ODZtMnpoNWtUanlQWUljSXFwOWhGUXF0Z0xOb3ZkT1RTbG51?=
 =?utf-8?B?eERvR0JxRTQ1NmpBSVo4V0lZQllPVngxYWNqTEdVTkZrTXVtR091dnZwY2JN?=
 =?utf-8?B?czVTT3F3UEpMY2daZkx1aXRIRDhwcUJ3dUdjZHF4OUtyaGlaZjYxdWxEanZK?=
 =?utf-8?B?RXdkaWFPUk9ScWZURVlFUE9FK2U4c0NpMjBJSXlwRHpXSjJqcVMxSjV6ZVdD?=
 =?utf-8?B?NzRITUF3ajRlWjk4UFRYTlhVSTRESGRkOWFwcXR2V3h4a1hoaC9QdWtENytY?=
 =?utf-8?B?QitBQndTcmlHdFZWQWh2a0tGSGtNVGQzUURtTmhlY3RWb1AwTjRxdy91MHdo?=
 =?utf-8?B?RVFiMExPYXhDZkhCMU56eHltWlkvQWxoL3FZbDRyd3ZKV1BlNlhGVjRQYlh4?=
 =?utf-8?B?RmhWOVVya3VGYzdQcEFxQWJwM2FGV3VVZElBalZjWFdaMGZHaUJ3REo3SHRV?=
 =?utf-8?B?UFBPZDRqSThSYTgxRjBKYkdlUEtvV0ZYYXpsWHJJRVA3TEZ3VzFGRGYrdmJ5?=
 =?utf-8?B?V0tsUkZCWVptbnFDb1ByMndlRUdsZVBrTWRnVHRZT2hvclFVUGpxci91bGlK?=
 =?utf-8?B?dUs3OHZRN0lmRUQxcFdTWDVkQStvMjljc1FqanZUeXRtcDk3OU9qaFJLaFAv?=
 =?utf-8?B?MkVHY2FzOHlZZXE1OE5QWXdCSEhSZG16WXBrd2hualNPK3AwSWwvaW01bXhk?=
 =?utf-8?B?R285YjNCNzNXSENQSUdpQ1cyeDlSM1crSHpLK1oxRGYybWpPL3o4UUxZYy96?=
 =?utf-8?B?OUVRcDJGQVVJRjNuTHB0NnNNb0ZyQ2lDNnNXK2JDVW5kUnZNeFVPbUpFTTFF?=
 =?utf-8?B?NFBqVzJuOXJNa0V2K1ZRUnVjMkJ4YkZkK2hrVG9sejdJRzJDNGRob1pjaVlX?=
 =?utf-8?B?dk9iUlovbVVKS0ZSR3JuMStXQnFZWjYxN3l5K0ZjdnUrT1BTbFBWZWNWUUVX?=
 =?utf-8?B?R3NnaUJIdjN6UHVzVXNnWU1Ld3ArUXFLU3BnOGZNWnB5UEZzS3dPWHhlS294?=
 =?utf-8?B?QnFHTTFDMEhETkd4eVM3MWlIL1JtREhOSWp6YlhkdnJvVUlVWXBlY2lPckRK?=
 =?utf-8?B?VlY0V2wyMkVNWFFQNWVmM0ViczF6OHNhcTdJV2cvNjVSVm5WVlZueUJSWEJN?=
 =?utf-8?B?VnJyeVRrdXUvQlBYcnhSUzlPUC9yaDQzeXg0NUNzRkdtMlNiNXlrZWs0bnEx?=
 =?utf-8?B?OUo2Z2lheWFlMjIvSDBNTDVSRktBeGx4aGtnV1A3d0VabHZYV3NvV1BQMVQ5?=
 =?utf-8?B?cGFhYXQ4aEtoUFV0M1pLRXF5RTd0UDdaenRhVTRGRXg2MGtHbUdHK3Y0TzVh?=
 =?utf-8?B?YWJGTC9qY252UEY5VkxkcmdZN3A0TWpId2dUSTg1Qm1BcG9UUzcwdVpFS0g5?=
 =?utf-8?B?QmwxTzlleW5GUnVBS1BtSUpZRlBFZ2RkcVh2RHNGVENQSE52ckFMbE1kVE56?=
 =?utf-8?B?TkVDaEFmamFhSGJGc1lzWFhFclBIemJzSmNjTk41T0VFVmljWVpWaGt4MjB3?=
 =?utf-8?B?dkR1ZDgyakNPeUtncmV3SjcvSWxmQjlZWnMyUmVvMHlGeEZXWU8vaW9tb2VG?=
 =?utf-8?B?bkxvM3hOVWhuUmp5VUxYNlMzUDVmR0ZzWmx0TGU3d1lBM3dvbTI4UGVVZWha?=
 =?utf-8?B?R1RveHE0Zmc4VXYvMjNDSHBaeDJSQ1N3QmdOTmx0VVo1bkhIcHFEL0U3dmFK?=
 =?utf-8?B?SFVnZklDWnJJNXBCSUxQemlZYU42REV3Y0hVZVJjdCtKZGxuak5VeVJWK0V3?=
 =?utf-8?B?NWJXcm9WRlRaRVlMbXBTdDc5NFhQc0FQbXZIeFRxV3M3c2ZERXJmSGIvVVVi?=
 =?utf-8?B?Z1cvTWlUT0l3UVJFbFNmQlQxbmhXeGhSUUszV1pZeG41TnZmd3hzTE5ibXph?=
 =?utf-8?B?aDNUVHQyT09ISmdtblVpSE51RG9YWi95SkE0bEI4NVZENk1WZkErVml0S20y?=
 =?utf-8?B?ZFB1Z3l2MHNOWXhvK29JVHpUSHk3ZmZsUkVJUWxkRmpuby9oci9KYjUvUWFt?=
 =?utf-8?B?RHdwd1Zjb01FTUwxWWpMc2N0Um9ML2ZoVXYvSlpYMmhEQit0ckJoTlFLV1Jo?=
 =?utf-8?B?emc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3kF7112FkRPsG1Fdc0fWc0fpuMJtsSiCHIfUTUQ2aJaYm0HRxFgbuxBNGyN02lO//AuRzhMrTpELOEl1tqrX9V+U4g9LIsgvN8OOh+6YMUYCgug372efaFuzd+JXwhp61/CWToCKYfet8ETIAhEaGtEExiMfmCXCMteScK4X4kChODAKU3qQ42w40SYlgKF+fqHEZ6oDfD1Zl0DVUpzP1Gp/8KIJ1yVNlkjuxAi0j3w4hrjpUskwcCJjE+/vY7BXE4ClERWK4J3g6wqZgjfo7EzbAv88seNHSAQEBmGEdE9c/eF5xICWRac2DVitCY/7Z9R/xczafRdbJxRoCaa77A+aj/fUAaaORiOT3IuQCYbb4k3pXrGKAQgyGb6V8irnSpkgve/puFLtdZ0iYVVq5oaCY+tiIoGQo4F0SVLJ+lIneQmfRVlhFIm9a0ZrwN0AX1p5X2Ny2yr9npS75JFIdbLFsw3ynBxcCAXmRSgbg0dgEny8Spa1k751gmsVogLSw3PcUh1AoyOFKi0OErtssanNHFL3ZervtnTXqG9X8QA/0BSIV1XLu0hNK6it1v109bLsUkAXEcr+OEknBeHmgGTjE83GX9CmDQ4jsfmbk64=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1d94a73-0660-45a6-4afe-08dda22133b7
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7660.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 22:02:44.3969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NF8KDFPlj/CmYGRvt72ARyc8K+Kdq5yACfxwc0u/tiOTj9CJlRnILR2CnaNIP+PqZX5iQEyairGj7LaA9PferaHK99dT5MB0Iunl49cC1YA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8038
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-02_08,2025-06-02_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 bulkscore=0 spamscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506020181
X-Proofpoint-GUID: BhQOBZwKT9BAhCZ3DedZfTOTzTpRoxu5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAyMDE4MSBTYWx0ZWRfX49KOsbV1ir+D YtAS6wrT5ZLlmtldkKRiPYnZYBX4caa/pGW6t3Rdkp3FISUEianTqLyI2rhBHOpjf2Zry9sPVSL e09KeNYU/6xbuwawAai3ZDDPyckgeFuAeEPsR01q5SB8/S5usFEPN1Y3s4AfIk5N+XkvKR5Bq/9
 h7SQXrYY0C3XEIUVuKCePGTmuZvVcd54xxrM+XJ/v/5jgIGUF1dew4GQ6Uvapx5z5USrvz9GXPZ dTSJ2KoUaM+yHnQTrkhost6AkmZs+hjpTW1r1I0lRXRlG232peXB1y7i1WSXq0yjyiGjcTAnFAB w8+VLS/itKa8a7j0uNU5Nn97Ukx+eU0f2pL2JSndaSOSvvc3c81dMCvNGV0IS7Wpk8ovc0rXjCW
 kSu0h2eAfiyB1YaoJIuBUDtO0JzzpE+Vblavbow/UxUJhF7kfpNigX5IAWUfK1qC6Rs4NW3O
X-Authority-Analysis: v=2.4 cv=KaTSsRYD c=1 sm=1 tr=0 ts=683e1f87 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8 a=AI1VmuGoBMbauuzdEjUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-ORIG-GUID: BhQOBZwKT9BAhCZ3DedZfTOTzTpRoxu5



On 6/2/25 8:26 AM, Jann Horn wrote:
> On Fri, May 30, 2025 at 6:42 PM Anthony Yznaga
> <anthony.yznaga@oracle.com> wrote:
>> On 5/30/25 7:56 AM, Jann Horn wrote:
>>> On Fri, Apr 4, 2025 at 4:18 AM Anthony Yznaga <anthony.yznaga@oracle.com> wrote:
>>>> In preparation for enabling the handling of page faults in an mshare
>>>> region provide a way to link an mshare shared page table to a process
>>>> page table and otherwise find the actual vma in order to handle a page
>>>> fault. Modify the unmap path to ensure that page tables in mshare regions
>>>> are unlinked and kept intact when a process exits or an mshare region
>>>> is explicitly unmapped.
>>>>
>>>> Signed-off-by: Khalid Aziz <khalid@kernel.org>
>>>> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
>>>> Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
>>> [...]
>>>> diff --git a/mm/memory.c b/mm/memory.c
>>>> index db558fe43088..68422b606819 100644
>>>> --- a/mm/memory.c
>>>> +++ b/mm/memory.c
>>> [...]
>>>> @@ -259,7 +260,10 @@ static inline void free_p4d_range(struct mmu_gather *tlb, pgd_t *pgd,
>>>>                   next = p4d_addr_end(addr, end);
>>>>                   if (p4d_none_or_clear_bad(p4d))
>>>>                           continue;
>>>> -               free_pud_range(tlb, p4d, addr, next, floor, ceiling);
>>>> +               if (unlikely(shared_pud))
>>>> +                       p4d_clear(p4d);
>>>> +               else
>>>> +                       free_pud_range(tlb, p4d, addr, next, floor, ceiling);
>>>>           } while (p4d++, addr = next, addr != end);
>>>>
>>>>           start &= PGDIR_MASK;
>>> [...]
>>>> +static void mshare_vm_op_unmap_page_range(struct mmu_gather *tlb,
>>>> +                               struct vm_area_struct *vma,
>>>> +                               unsigned long addr, unsigned long end,
>>>> +                               struct zap_details *details)
>>>> +{
>>>> +       /*
>>>> +        * The msharefs vma is being unmapped. Do not unmap pages in the
>>>> +        * mshare region itself.
>>>> +        */
>>>> +}
>>>
>>> Unmapping a VMA has three major phases:
>>>
>>> 1. unlinking the VMA from the VMA tree
>>> 2. removing the VMA contents
>>> 3. removing unneeded page tables
>>>
>>> The MM subsystem broadly assumes that after phase 2, no stuff is
>>> mapped in the region anymore and therefore changes to the backing file
>>> don't need to TLB-flush this VMA anymore, and unlinks the mapping from
>>> rmaps and such. If munmap() of an mshare region only removes the
>>> mapping of shared page tables in step 3, as implemented here, that
>>> means things like TLB flushes won't be able to discover all
>>> currently-existing mshare mappings of a host MM through rmap walks.
>>>
>>> I think it would make more sense to remove the links to shared page
>>> tables in step 2 (meaning in mshare_vm_op_unmap_page_range), just like
>>> hugetlb does, and not modify free_pgtables().
>>
>> That makes sense. I'll make this change.
> 
> Related: I think there needs to be a strategy for preventing walking
> of mshare host page tables through an mshare VMA by codepaths relying
> on MM/VMA locks, because those locks won't have an effect on the
> underlying host MM. For example, I think the only reason fork() is
> safe with your proposal is that copy_page_range() skips shared VMAs,
> and I think non-fast get_user_pages() could maybe hit use-after-free
> of page tables or such?
> 
> I guess the only clean strategy for that is to ensure that all
> locking-based page table walking code does a check for "is this an
> mshare VMA?" and, if yes, either bails immediately or takes extra
> locks on the host MM (which could get messy).

Thanks. Yes, I need to audit all VMA / page table scanning. This series 
already has a patch to avoid scanning mshare VMAs for numa migration, 
but more issues are lurking.

