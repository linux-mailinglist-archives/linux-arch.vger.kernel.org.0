Return-Path: <linux-arch+bounces-15850-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F53DD3A1CA
	for <lists+linux-arch@lfdr.de>; Mon, 19 Jan 2026 09:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D21EF300161E
	for <lists+linux-arch@lfdr.de>; Mon, 19 Jan 2026 08:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF71343D64;
	Mon, 19 Jan 2026 08:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DWuuIXew";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="S4JpJE0t"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D893343D63;
	Mon, 19 Jan 2026 08:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768811981; cv=fail; b=P6EsIHZ4DZ+A78Gzk5j3nXD0h/633dDElPhC+qYO+1Ft/1amigP0Y94qfdO+jgcxk1ed1cEyXgC6oUSWZw4bzC4BXQ9Ov1aTzwNvohR8ZWoXuo29Gg7otdMrhSzBwxW0IqJHxqhjeKji+/ZYs6IpPnDxaoMQFWe61NvWXTT/twE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768811981; c=relaxed/simple;
	bh=yBt3f+Gg/ahAOhGwqgdPtQd8Fro6tzfUzskT660tRaU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eeAZMTO/wYwdY29uB4w+4nZrGxXK8zFlCQUdB9HZE3JCVQZUbst42YY0B1FX+i+3AuQkqWV+BVqlCzUL6PNNjrAWS5JYX2FNFz29xD24nAwuk5LU8FEQ+5uZJVHK4FiVaze0k5GihlI1acvb374+xu315Sk7rxNFTbA5biNm0VY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DWuuIXew; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=S4JpJE0t; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60J0GnXn4177917;
	Mon, 19 Jan 2026 08:38:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=5DXg/VkVpvOkN3PgYRtenTKdMa+3CO+avbTucnHuA4w=; b=
	DWuuIXewBsqQ1bv8y8YtUfdUPlJcdk/lCPN/c/m3iMVtHF7VwA+NqA7+itS0H9vb
	NeCUhDWV026NCvCU1b7NKxFnkEAvMv9Diw1DvhyuYEYaE6Ttv0Wq+xmtME/3dbAv
	LyPjUUWXo2jdmoZlufzneZfbAaAxCKviKaDcoJQyqHA3MF2DidxCH+4+IIILDuNq
	48WP2LVISnU8r2erkdD/N0vnFtUPvSKGocw+skG79XBg7Ht7y9lMnP8B2JsGFdYH
	evxmVj/o7nHVK58LwJq+JG4wpfSJm/pu/+QXus86C5yhVRZ7VvwYanDvC+9j0PSI
	YJaDyvZcm0t6dZOvr3hGJQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br10vsws8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Jan 2026 08:38:40 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60J6ZGBt039561;
	Mon, 19 Jan 2026 08:38:40 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010010.outbound.protection.outlook.com [52.101.56.10])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4br0v8381y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Jan 2026 08:38:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RkYkyOPbgYFOMPgr/P7lVR2lYdLVa3A5lkGxdyEoXsoOIf2Im/LRg6ZfLCUqOqVetV2hQ+9NX4ruc3FK88JSrQfRGMst4WkYWS93rFJYjub7atDdqJZ2Dy8FE41+zBj44E3u7lZkbmWYpZ0LlFf+MknGt+qWvl3mARagAe+tjOlw4EpcmG7hNRm/jhMpK8Y+ruEi4UTOY/F7jYeZMRHuqMwhiqCjZum958VRSCSxHrdLmOSqlkLWFeoiS9Wwhq6snAnG6gumNDJoIjkwGJOGRfiXTYqB7iLoCwnPI8uigWEFArK8nItKlyjzuI5iuUYUDqc00MqclIG2d7kCQP2v2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5DXg/VkVpvOkN3PgYRtenTKdMa+3CO+avbTucnHuA4w=;
 b=CLYEJMcfXJu0to5F56NTG+ZbxWgSzSHnhbrqWMaL8OefUacvYFfZdG7M1/F3s8+61syxclLkbZ6m4daa4hEJ0/BtcK7HGAhAi+tTIm2YNhBANDOc+VpvVJV5N9svAUoiVuW8mmGH5M+3wySnJNBhu8wdz01QdwCyeuam/lwxNKvM5SePOCZVLtOO5GZKghEG7amgd8K3ufPpgJ3SS1u6NBwPUFq7O0nC422m4sn5OVzx13rwDg/0GDt0gSr9d2WjB7ZG993gr1D38SOUrsoqg5k0zu6JaTpMPLXj0l7vO3X5E4/ToHI9sEBDI6Mhida+GVsKdkocNx8MZgnBG6WMOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5DXg/VkVpvOkN3PgYRtenTKdMa+3CO+avbTucnHuA4w=;
 b=S4JpJE0t6aUwN7a54QC88sAFzpToHvwwgIYM5v8Ewkl3r2C+PlgpACJhk81VJtdC7BtlLXFfBF3PWczAA/tblgV3+0yUlLMGUXDvqbIogLkb7ZsDFDRQuss+MTZhVBstbwYElOksEiHmb9+ZgnqlMvY3SDM6OFlXsl/hg1Ttj4s=
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54) by SJ0PR10MB4478.namprd10.prod.outlook.com
 (2603:10b6:a03:2d4::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Mon, 19 Jan
 2026 08:38:37 +0000
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::ba87:9589:750c:6861]) by DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::ba87:9589:750c:6861%8]) with mapi id 15.20.9520.011; Mon, 19 Jan 2026
 08:38:36 +0000
Message-ID: <7f846810-d932-48e7-864d-d42837ca4704@oracle.com>
Date: Mon, 19 Jan 2026 08:38:32 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] Make cpumask_of_node() robust against NUMA_NO_NODE
To: chenhuacai@kernel.org, kernel@xen0n.name, jiaxun.yang@flygoat.com,
        tsbogend@alpha.franken.de, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        luto@kernel.org, peterz@infradead.org, arnd@arndb.de, x86@kernel.org
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-arch@vger.kernel.org,
        vulab@iscas.ac.cn, gregkh@linuxfoundation.org, rafael@kernel.org,
        dakr@kernel.org
References: <20260107094007.966496-1-john.g.garry@oracle.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20260107094007.966496-1-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0295.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a5::19) To DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPFEAFA21C69:EE_|SJ0PR10MB4478:EE_
X-MS-Office365-Filtering-Correlation-Id: 86ebf098-49dc-494c-f1a5-08de57362355
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WERBMVVKcm1JamhZWjdVYjNlTkQxSkl2bHBTbVM0a1hnVmpXVVdFT0wzNUZG?=
 =?utf-8?B?c3VBMmlMMXh4RFBGM1dRTEE2ZzQzLytBcWJnK1NzY0hrdzhkRnhyMGdPOFVz?=
 =?utf-8?B?N0tWS01hQW9ITFVUK3dEQUFCalpKQ3MxR3RWazBtcmZhSW1MeFFrc0JRSmdt?=
 =?utf-8?B?ZUVjRjhBcUNGVzd1ejZUcUdBRXJNVGExdzJLU1dZWWdDbk5rYVFQMkhkdDNF?=
 =?utf-8?B?OEJ0M2VMdGVuOC9OdDdvQzZtd0xxWVRBMytPNVc1WFZ2K0dod3FUb01QMUdI?=
 =?utf-8?B?S3NERjZpeXZMWm1zUlBUek5kT3Byd3lWVFpXSzJieHMyQUtIdlpyNGRneGNm?=
 =?utf-8?B?bjZQRzR3VzZMcHdEVEFIR0xGVWdRak1acXRwNzV5MnVVTzdJMExVZkdRaGJn?=
 =?utf-8?B?T0VvbGZFRnJUeVVCZTJscm9KVWg1MnZjV2xSbEdKOC9oVFFPdEQ5N2RxTGMv?=
 =?utf-8?B?RlUvSi9HcDVZS2tHMTAyUGdqTVBPTTBBalB6cWEvdGdkMnlTVlZ0M09Fa2t1?=
 =?utf-8?B?bHd4UzM5anA3YW0wNVJaN3kwYURWTjFJQ3F6QnlnU3N4Szl5Tld6dmtMQ2FO?=
 =?utf-8?B?UzRCbTl6OGIvZ0VnaFNnaVlHUlg0eGZXbXNpdWk2UUtzWDB0ajVSdFV5elRu?=
 =?utf-8?B?c01FdEx3ZDZaSTAvVFdTbUE4RnhDR2tnY3JvWnNCcU40eTVjR3RPOXI3T2VZ?=
 =?utf-8?B?TW9oN1M2cmJrV3lMMUkyTTJnU0lFdHBycmZETlp2dW9RSXZwU0tHMEFKdEw1?=
 =?utf-8?B?N3hxSlFURTUzNXB4QnlucVpDTGhuaXVQWldtTXU0dElhQ0NhWmJpOGFVRWIv?=
 =?utf-8?B?K1lQL0RaQWlnd3VyOXJoRXd2S2g4YWw1bHFiQjZGVktsTWxtU2IzdHkzdmxo?=
 =?utf-8?B?MDloY2I2ekVxY3ErN2srMEx0VDJVY25MQTBSbG5FbEdieDhYMjhITmhaS3Vq?=
 =?utf-8?B?Y0tPS1RYQ3cwZFNtTm5uSVVrYnp2NzY5Y3FNanAveXd1bjdlYnczUGhuZHBy?=
 =?utf-8?B?OUNoalRGSmtCeXNqRzNhcEF2cW1YekIxQXBYMnJ1MmdLelpnYWZPcmM5a0tk?=
 =?utf-8?B?YzlMZWxPWnFEWlRSd3c1Q3huWVlsR21aUDlVYk5XTXU3UnRjWUN0UnFFVDZr?=
 =?utf-8?B?amd2RVJMT01ZQkZmSG1uUWNGYVNTT1BQNktmWitON09oM24vV3c2UFhIVkR3?=
 =?utf-8?B?SGZrdDNVQVl3SWhhbXE1ZFgrTVZBSzNyWTllcHJkK28xK0g0REwrbzZpZGpD?=
 =?utf-8?B?ZWtxdnpFM3hyR3JjU1ZrZGNpUERkL2plekZwTm44ejV4VVNyVkQrQlA3U2pi?=
 =?utf-8?B?dXMvejJ2S2IvYkFRV0pOeUVkckZjMTgxeXhCdDNzMVgxWHIrUEpxTmh2R1Ay?=
 =?utf-8?B?dVBWYUNtWXpLRjZhdHF3T2F5UE5BT1hJTGV6L00vQjFtUERpRnBPclhsN0t5?=
 =?utf-8?B?UFc1UzJraXVSNGEvM21GSEJQSytoWklKYit1OWU3bTUzNnZHZmZBN2w4bytR?=
 =?utf-8?B?TkRST2NSdWZVTm1UTE9IWXBFdlV4anp6UlRVYXA4cHZrR3AvWE5NVWxpREw4?=
 =?utf-8?B?NnV2ODltOVljR0duMUlYWUo5RW9VNlo5L29SckdKbm1kb1EzVkpYTDZxdi81?=
 =?utf-8?B?MnVreWxPVUJ2M2lqajVOZHpzSFNVYVhxOWFwSlIyRHNFdVJqR3N2c1I0aGlK?=
 =?utf-8?B?dkNwcnA2SU52bjdqdVFPdEhKYlVhcHA3RlZpdmp0aUU4bWRHek5ZSDdxWnZ2?=
 =?utf-8?B?bG9GbkwraVM4S2d6aHNHNG9CQTFpZGYwVHNGYkYwbzloamhTOXJ0aThuWWpC?=
 =?utf-8?B?UmpTOFdmWWl3bG5sRnh4bjVlMXhiYlh4VEhHMUFYSTYvejJrcHoybzEwdWJo?=
 =?utf-8?B?Z2NjczljRXp2TGoxOEc1OWhVNzRsRVdVSkN1d1QvV0ZXZllJMm5POUxXQ1Vx?=
 =?utf-8?B?NTZQVUNqVWVhcmZaWi9lb2pqemRwaUVOVkVFaXVZOUJyY2tSSkhwVm1nRWlH?=
 =?utf-8?B?RExncmM4V3hUTS9Rd1ZtQzl4bERHSXM4dVAycmRhUk82STNLRlZEb0FBSm5S?=
 =?utf-8?B?dVQzWXE1cEU4MEI5VmRUbDlOaUo3TFBpQy92WGdHZTVxNlVJOWZzNStjcnhV?=
 =?utf-8?B?bE5SRzkzT3NCMXVjamdxejhEMVYyaFNMU3d6ZlNFWXY2WStLTmRab2owRmhi?=
 =?utf-8?Q?er4qsmjeRcnsOaSXUropATk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFEAFA21C69.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a252azJGbjZaRGxrYXkybVpaSmoxTHRLTzI1MkdSQ2w1RDRnRHFtc3N6Q01K?=
 =?utf-8?B?TnFHenhVRXdZbFNPM1JNWDhRZDQ5SkRscmFGZmEvTlhxK3RrOGVYL0RFdE5I?=
 =?utf-8?B?ZldVSWVkUDAwMVhKZnBaeFZZaTdLRTc4bjE4eXZJMUhzSDhUd1piMTBCS3VM?=
 =?utf-8?B?ajRyMUlndkRzeGlDU1MzakFvekVDNDJYTU9qNk1JWHk4dnkveFozQitQb2pY?=
 =?utf-8?B?NFhScGwycmZoOEo0VXdvQWFQbmMxcVhUcktBUzRuTUNQRXdDbWRLZmViTlZk?=
 =?utf-8?B?YS9TOUppRzZLbWN3NFUxeGZzdC9VeDl1NEpjMkh0aERkUktxd3dqUXNQcndU?=
 =?utf-8?B?R0Vocms0bnBkRCtzMmYvY2M4VHZHSnluVjh2SkMxTmxpOEkvdm9MR2cvWlBL?=
 =?utf-8?B?MSsrekZOSGxKRm9HaTBVbXZTOVJnSC9EckhqQ0lBdThYOGFXNjBXeUIwOFhL?=
 =?utf-8?B?Wk92RFlMUkNuOHJ2SExmeUZhU3REc01KaUdKR1o0OFg4ZHVzdmt0aFdadmwz?=
 =?utf-8?B?QmNsUVdBQWhwdFZtSEVGblRmTlArY1RHNUZIVkxyQkJXLzFVMFMyM2RyV3lq?=
 =?utf-8?B?ZXNqaUtIeGJMVXlDRThJbzBrSHdycFdkVmtROHBnSU9tYjBVVTczOEtscjJq?=
 =?utf-8?B?NXdHaVIwd1ZLTHl5cXlwaUhKeWU0V2RZdjVoVHEwQlFOcFE2bWUzVDNSajFQ?=
 =?utf-8?B?QzFRYU1VQzRhbE03S2IwY051VHFNL08xUEJnNlRZS3MzZHNjT21WczdubEg3?=
 =?utf-8?B?R2kxTXNIT0Z3RmpIT2pWd3A5QjJZWGZKUFpjTTVJZzNKcE13L0h5NWwvN2lC?=
 =?utf-8?B?V2dMdGJKbVdsRWhnVnNHWTJ0SUxjcmVHNHRIcGJmaVQxcjJHQjhmZDYzbFNQ?=
 =?utf-8?B?b2JzM241N21XVkd2eFd4YkZKT0pzcUZNT200SThjcmRPOWlCYWtDYU50Q3hN?=
 =?utf-8?B?NzAyWWUwMFhmRnlOMCtLSS9hZzRBL1hsQm1OdHBCY01kWnB4WTRlbGRDZ21k?=
 =?utf-8?B?ajNoSENIZFdoNDBxSE5RcDZXa3hPbDdZZ1JxSmdHOFZqenNqejEvZ2szSnBB?=
 =?utf-8?B?OTNCcnljKzcvOEtQc1A1YW16YnJ5eFFIQU90KzVBMkJYTXphZ2tKQndTaXQv?=
 =?utf-8?B?aGRaZkF2MmFqaSszZGpjeE03VFptRTZ4OHpyTnI1amNud0dHbDI0aVNvbnZm?=
 =?utf-8?B?QTN6OElObWZhMjdiMTZKZVFua0Jsb2VCWTdjRFN3c1UxbjY5ZWR3bkNtR3FD?=
 =?utf-8?B?VEY4TTd6andKcmpqcldyRC9pZlNEUmpHdnVObllqUy9rTUxkYWpkNHh2R2dG?=
 =?utf-8?B?V2VBUkgrNTNrbVJCY1ZWK3VRL2h0MFg2OGo0WmUwUVhscFpKUVhEZkt0MElv?=
 =?utf-8?B?a3VyWkRmLzVzUG5Wa2JQZXBoSFJHMDB3WVZQdG9SSmlsenl0QnNVNEpPMktj?=
 =?utf-8?B?YW9NVTBpVk5FeG11ZEhmMjdjY0RGMjR1Q1ZGV3B2MjRLbUxDclYwNC9EcHkx?=
 =?utf-8?B?KzdTNTBTT1RhZVBuTGt5dkZIWWV4S21rbUErOTJRV00yK1ZLb08yUlJzeWFw?=
 =?utf-8?B?VkYvS3gwS1ZRTFZqQmNHTXdKSnZOOGxKY0ExRkdaaXllSDFQdFdLV2g0Q0h3?=
 =?utf-8?B?MDRQNGMwV1RkbWFJSFF4L3NoOUhHZmxOdzRFNXluTndQcEkyNHM1VXBEUEcr?=
 =?utf-8?B?RE9POUxDcWN2a1ByUTNZeEZZZjZqaW1UMVZNUkg3U0cwdVB4cXJFNk51Yy9B?=
 =?utf-8?B?bzc4TDlCVlNaMVpRVXpYSU5XclpzMzdraFRmd0pxY0t0QzZ0NzY3a25pa2ds?=
 =?utf-8?B?ZEd6Q3UvQkdOa0xGWjJCRk4xenhyc25sU2ZBMU1sdHE0VUMySVpGSExHbGhY?=
 =?utf-8?B?NDQ0b2ZxSGF3NU1vU0I3VHpQbkxTWXgrQWIzbGlvZFQ0TktvZ0wyWEhmdURx?=
 =?utf-8?B?Y0ZzdENDUTV5ZEhRVnhWUW0zOE5EbGN0WWg4dkpCdi9ETVpabWE4WWFwMnJS?=
 =?utf-8?B?ZDA0NWgwRDJwTHJvWE5oTG5VcEVXS3N6UG9pK1pRU1h2dlIrc21pVVdXd3Y4?=
 =?utf-8?B?WHNHS0grQlRUSk9qdld1WGhGQUx1NVp1WE9QU0dZOG5JWjhvWHk1dnJVMlhK?=
 =?utf-8?B?VDIyTGo5eGJIR3NXY285cW5maTM3OVVVRWhlYXg1U1hyYk5BeThlK3JkZU8z?=
 =?utf-8?B?Ymp0Yy9Fd3ppa2d0bVM1dWh6cHVUVzlvaERsWDZzSmt5eWNUQVFpMUExSHNv?=
 =?utf-8?B?TGtBUXdXUk1peThPZmxVR0ZWV2tYQUsycDh5TS9JNVBydVYwd3NBLzBqcW42?=
 =?utf-8?B?bk0vQ2FBUUJPM1NXYkVSOTEyc3crTytKYTNpQWw1QndseUlNdnB2Zz09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TU334nPbPvFx+KWaVI/RKXVFRHssEdaMwn4iez6bsQIE8x6dzMNcxkR6iQtn9mEH2lzG/BCSUut1mkiv9BOvczWKJyx413IdpBZ+/vNJzYG+OAN9j+wpi+K8OdG5ipMBIh6QrHJkzJ2X6Icdz5gjAzVbOC/U5gctP1fyo94a+uv/1qoAjMYmquNARFenPNh2AtBvztP1ND1CMvUof4AADhHEj7fUlDpHrjhUFKz45cRm+8Vnj0TN5MxiMroisSvtl9SmjVBvpI1J3p6Qpt8zvVwhb7q87g/tq+j4vbto6SVZ2/VrsZmFsKoEtOH2+1aRWuf9jbg193DBBtiIqXR+/iyDkyZNQbgMxK9h6m4mo3HpBL2+6/JxgjrqCWj/HCDX96y7coPwudUHP2bPacnB3Gf//F5uXRVEyHFeK3F7nf86d0TGFssy4Thd7E8+pqjocoDWct7Uoj3LkE1Ea313hRFtIcxBl+yuxPGGToGgJXZZc+B2uzvX/JlQaZwJJ3BKIqYEIM4p2sUfUGJ69dTJreIX52OSHZ00kk05kcqoFsMYref1zJQTRCtTYKCJ0w9o41c+T3SIyr9c82VIDqkfqLPoOooWRstZJBFIVR7zRDg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86ebf098-49dc-494c-f1a5-08de57362355
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFEAFA21C69.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 08:38:36.8588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g5cFg1XOoHj7rduyTT/ah9qbxIgO8ID6Z2CbqHuws9T4WShv5nspvIWwKDt1UVAEcyMCrT382ljA0OaYI8TQ/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4478
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-19_01,2026-01-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 phishscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601190070
X-Authority-Analysis: v=2.4 cv=H4nWAuYi c=1 sm=1 tr=0 ts=696ded90 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=PYnjg3YJAAAA:8 a=P2re38llptAuaerClHkA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Dx14T0TxfMfhChsiNWeuazjCcsXexnYU
X-Proofpoint-ORIG-GUID: Dx14T0TxfMfhChsiNWeuazjCcsXexnYU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDA3MCBTYWx0ZWRfX6LRu/TKA83vF
 6WrQO3sG2g6TS0WuFxdlkVzieflAMVF0eC2NffttRKpiA53OZQD+2TrccxUhl/AH/qe73IDf00r
 +O7au+9vx0lsSRl0Cx416Gaww0cvUpMwPPasHFyTMWaLnWhR2Io2975qVReEJGW6TbJeU3M11br
 vfXl6zRSSOkdMl1HjlsBukGoCapVRkryQqxcnkWTobP/ifmXLPtwhMquTZNEzyy8LmY+p6LtgP1
 bHXOyGJ11bEDgrVtGD+LFKrDtAzZSif7OkNJB14DSG9qETFkJ8ZYunDc0Q0+GuE3z4hcNAM4kcO
 pe3h7vw6uKw59vWByhahJSnFZ2rfjKoqzIV0pf6fYLkC1iQz8hO4dTRgSS4JfGnvdHn1+Mujcl1
 9Dc9JnWGRu7E3FRMsYsGGOBiMyrOUXzqAr8LjC9XFaMedcaigczu6LeY5Gt2W0JrxgG7LDH9GQk
 wSM2Ajxil1pt5st+lfA==

On 07/01/2026 09:40, John Garry wrote:

A friendly reminder on this one.

Thanks

> This series aims to remedy an issue that not all per-arch versions of
> cpumask_of_node() are robust against NUMA_NO_NODE.
> 
> In my view, cpumask_of_node() should be able to handle NUMA_NO_NODE. This
> is because NUMA_NO_NODE is a valid index from the following flow, where
> the device NUMA node is not set (from default):
> 
> device_initialize(dev)
> 	set_dev_node(dev, NUMA_NO_NODE);
> 
> mask = cpumask_of_node(dev_to_node(dev));
> 
> The CONFIG_DEBUG_PER_CPU_MAPS=n x86 version cpumask_of_node() would
> produce an array out-of-index issue (when passed NUMA_NO_NODE), which I
> think is attempted to be worked around here:
> https://lore.kernel.org/linux-scsi/cf0f9085-6c87-4dd5-9114-925723e68495@oracle.com/T/#mdedb68052e419b4bfca9ce45bb33b58988018945
> 
> I also see a CVE which also looks related:
> https://nvd.nist.gov/vuln/detail/cve-2024-39277
> 
> Each per-arch version could be picked up separately, as can the
> asm-generic change.
> 
> Differences to v1:
> - Put mips and loongarch definition on a single line (Huacai)
> 
> John Garry (4):
>    include/asm-generic/topology.h: Remove unused definition of
>      cpumask_of_node()
>    LoongArch: Make cpumask_of_node() robust against NUMA_NO_NODE
>    MIPS: Loongson: Make cpumask_of_node() robust against NUMA_NO_NODE
>    x86/cpu/topology: Make cpumask_of_node() robust against NUMA_NO_NODE
> 
>   arch/loongarch/include/asm/topology.h            | 2 +-
>   arch/mips/include/asm/mach-loongson64/topology.h | 2 +-
>   arch/x86/include/asm/topology.h                  | 2 ++
>   arch/x86/mm/numa.c                               | 2 ++
>   include/asm-generic/topology.h                   | 8 ++------
>   5 files changed, 8 insertions(+), 8 deletions(-)
> 


