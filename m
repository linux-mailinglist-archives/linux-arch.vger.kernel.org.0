Return-Path: <linux-arch+bounces-5741-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87DBF94258E
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jul 2024 06:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06A7A1F2455C
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jul 2024 04:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366B224B34;
	Wed, 31 Jul 2024 04:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="gGU0mTAk"
X-Original-To: linux-arch@vger.kernel.org
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010018.outbound.protection.outlook.com [52.101.128.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADDE288B1;
	Wed, 31 Jul 2024 04:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722401819; cv=fail; b=YL06JcbnR3Fbxo5tK/IL1W4aPID8gI5tDWKCXTeYGL8KCo1nMYq9EO0WDDJf1AUgjCEPcCgrXxh3r1QA35lENOAHU+Mm99SDPrQboe76nheN3zyS7yXS4bAJqnb+CSFRT2haYgp23GOXPVCoXzdQuOiwXy8ClfvtzwyvgeV5kY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722401819; c=relaxed/simple;
	bh=B6tuwdtrE8DzBnggDJcEv9eWqaYUCIMiSl9fGMuvLps=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fu9u8D+ETYCEsNw/bDZvmUZn9lKPpCViVUh/n6Ect/XQgeuyZWyjryPWdJkEdB1jkZDnMXOXUZD9O5tFo0g/y0OH45gF3hM9buSTVIZwnncNZzHz5IlTVwI6jfcom99usogRQ7fGTkGv6RSzW5kFApxn+I6qPW1H1OBwhCMQGf0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=gGU0mTAk; arc=fail smtp.client-ip=52.101.128.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XiS0VnlosXF5d1+cdSJKl0JPgmuQZfl0X1sWRKES5Wmt5uydmP0GqfNV8W6eCaMtlybqBhYTQarPJrlHeaFWtISw8QsqAeL5poy0GC0SpvpbGNwIDRJOSAnUtf7int7Pk96DiGGy5OZwOM2pEJ6Ki8gDkuZhMB0eJRkqkJA9gMwRLRjAm/dCWAczKJHd7wMIn5rYPZSffxYOGKsCBHdvqoud1W0vdCbKcDiAk2gstl6dt58P2S4JMNR6t2nPjvsls55AuIy57rivlJWduC69luu/ZgkTJ/ROEmM2Dh7qQUcVjQYMe2ckQc+jfkYOeN6+sldVr0+hJeDKjA5sB0OlUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F1CF/FQ/XQYy/C6n9/gOn+0vVSZvRxKSpiSpfyoOooE=;
 b=UYfl4M+Fl44idxFBbmHMsWSCpAyMq1A/5y0b26XsuBzXUpQj+L1C4wNfUqcaVQpx34qJEI2UV6dp/+x+QjUu9BusnabyhewteXDAz9k1YPpMtmrjBCk4yfzAqCLLvlOtPymwQ88jjZMfxBZDxFY89YkqGac4xeG6LPGEFwcz5dJNWQX2u7ZvLPXfukVu90pSGZ3JVIMZXN1ZQr7QKBMJaoyzD64bRzc8mhlX8jKvBNOiugBFUJ8zo9JIEZ8CF72PYab2yGD5cwK9FkjqNTMnB6Fv2EWKKN4QPsv0/7acnmfnYZJFKcEcSO6etjopqmCHfqxJ9rsPu/v0mFmkSIXwIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F1CF/FQ/XQYy/C6n9/gOn+0vVSZvRxKSpiSpfyoOooE=;
 b=gGU0mTAkzOt8P6Wmnn31pGNtbAzgjh1AXnXjqTVtw5Hw8PBnBiFrn3CoYqkgcqgXrkI8CiD2Ud/XFvdpFkXEVA/m2bf0bCqK+hOwbENv8wxOjWbBxZIXN5sQFFPOtbuk3aaVNAdso51sv0NyLriD/2qbw02IoIWvkl/8hvqklE9cgh3ME8szuOMl7oGsli44+MKZRbLhRgb5LWS49aalV5LsbdIDjKERVStt48gq+JWKbJ4YuHYpggtr/1K8vE/vefzlkWCWDDxWxfZvHkvRi+qIttEiGShfRP8ELiodtukYql1bebmM36Rx1P04Q/B3bnAWKZgCuVtzHeTRwsF6zg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by TYZPR06MB6237.apcprd06.prod.outlook.com (2603:1096:400:331::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Wed, 31 Jul
 2024 04:56:52 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed%3]) with mapi id 15.20.7828.016; Wed, 31 Jul 2024
 04:56:52 +0000
Message-ID: <303e5809-041b-4270-9462-0f73a5cac062@vivo.com>
Date: Wed, 31 Jul 2024 12:56:45 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] mm: tlb swap entries batch async release
To: Barry Song <21cnbao@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin
 <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
 Arnd Bergmann <arnd@arndb.de>, Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 linux-arch@vger.kernel.org, cgroups@vger.kernel.org,
 opensource.kernel@vivo.com
References: <20240730114426.511-1-justinjiang@vivo.com>
 <CAGsJ_4xdnQjQyJVMfN7ZSW3OMvJhFRErjwMGSCDZACQOVWeesw@mail.gmail.com>
From: zhiguojiang <justinjiang@vivo.com>
In-Reply-To: <CAGsJ_4xdnQjQyJVMfN7ZSW3OMvJhFRErjwMGSCDZACQOVWeesw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0039.apcprd02.prod.outlook.com
 (2603:1096:4:196::9) To JH0PR06MB6849.apcprd06.prod.outlook.com
 (2603:1096:990:47::12)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|TYZPR06MB6237:EE_
X-MS-Office365-Filtering-Correlation-Id: bd1de586-738c-4d01-8645-08dcb11d314d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|43062017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Zmp3Ny9OTXRBbDNuZzNVaDRwdGFhUzlxVFFYcVRqVVdubGJyai9zeGdQWkZm?=
 =?utf-8?B?MXZ3QS9Xb05EWEFEaFZ2YjFCWXpMYkxMUFFjMHlMeDNBMzBQSkthQW1lbjZR?=
 =?utf-8?B?bkZwV2N3RnV5UFpmRWtkVUlwK29ielJud09jTWhxU0s3WGh4QmZmcW5YZndN?=
 =?utf-8?B?UnF1TkNLTHEvRFRJbUdneVdYdkJkUlFPVDBWNzRnMmNWeTRRdUZLdEhQaFVs?=
 =?utf-8?B?cGErOHNaQk05MFJUaWVGR2llbnp4TGhCdDB5emxhcDZ5NlA1WkkvZkVhL1pC?=
 =?utf-8?B?RnRYTXVkQUwwWHphSmVpTlFxYlFnTm56L3JNeUtvbGE0ajg4QXg2SjVheXdt?=
 =?utf-8?B?S0daZFRiS0dCOFk0Z0l6V3RwNzZOTVJVemZwMFNIK0l6M3pKbS9DZHIvRTZn?=
 =?utf-8?B?WmNrczVpd3JSdzIzQzMycVRWL1dCSGdvZzA5ZHV3cmxIMEdXUHQvYXpRSEMx?=
 =?utf-8?B?aENHdkkwdGdaeUtROGlVcjBoY2xNNEVJaGRoVnE2MVZ1QkU4UlZ0VnFIV3RW?=
 =?utf-8?B?U0E0RmtRZ1lEVmNlRjVvTDI1SEtrbVoyUTA0bFJReGY4ZzhhN2l5R3RYaUZo?=
 =?utf-8?B?a3FCVXl5WEFVY0IxUS9pVko3dW54TStrMGFpTlpjdnhMenc0VTRMQlBDeCtF?=
 =?utf-8?B?K09tMXlwOWIxWGs4MC83Q3VING0vYmlidENFd1pyaDVTY0pKZXdCc1ZMTGV2?=
 =?utf-8?B?QkwyZ1oxcWdSa1E1NWQwUzAvZ21TNnNxdTV2aE9MSGZLL0VIMWdPTVZPZjJ0?=
 =?utf-8?B?TS9qa3NHazNtOEt1YitYb3hLQUtEUjB0Y2JrUm8reEpUQzhMalpUcGJ4dlpq?=
 =?utf-8?B?NlBUZWFEZ01xazJSaGtxNzMxM0xaci9sUldKSHNaTzhHdmJTTGp6ZzFkRVlI?=
 =?utf-8?B?cGFTd3F3eUtKak9xL3lQSTJLVU9QWnJSRVRYeUYxa1pPb1lMUVJWUU5ET2dT?=
 =?utf-8?B?WURORXhXSVNnZFE4ck53Wm0rU2pSQVk5NE43UGZCcEc0VFk3Rys2cHhpdHhG?=
 =?utf-8?B?RTB4ejdPZWtQd3dHY24xa2s1bStpR05mWUh2dWZKbHpXR1haamZNallsd3VV?=
 =?utf-8?B?d0lPajdLeGEwNVpxL2MzZTVUQmxNV29LUm9oeGVpS2pvYm9VY0ptMktEOE5Z?=
 =?utf-8?B?RWFzeGJwU1M2aFBOLy8veE1WU2xjSWpVYUpXTDhrS1lzL0gzNmpaejFYOWJW?=
 =?utf-8?B?Z2ZmbHUyR2R2V00zb1llRFlQaU9JRER6aXpoL0FsY3Vid0JNSm4wWGtYUWln?=
 =?utf-8?B?MDVDMlJFQVBxZHpNL2xmS2RSWEM3a2NPQkxKN3ZOUFk2YzhPcTR4QWhGcUpP?=
 =?utf-8?B?aGVyaDZMWko1d2RKdFVrc0RTUGxkZDZ3STU0aWlpOHZLUkJCOFAyM3VFY3BL?=
 =?utf-8?B?LzhzVHYrbnNmVi9vdCtJSkhQVHVwK1NrMURXRE1CcTNmbmsvS2NkOXhvNHEv?=
 =?utf-8?B?VDI3WVlmWU9lTDU1ak9KbW1HTytEK0JvNjQzVHQxbzNOeFM3aHUvZjRFRVZk?=
 =?utf-8?B?bHcrbTJEb3c5WUg2M2Nmazk4RlVVU29QUzFLY0Ezd2xTVzNaZmtnZ0hYMDVF?=
 =?utf-8?B?Tm9NTGpqbFNLaDlxeWZtOHlZMXBXQUR0U0JOdTZtTWd0YUhQVUo2QWhNVnlr?=
 =?utf-8?B?aGlVRGlKNmtUb0YybWpJWUp5eXJCZC91S3RkNFMveXF4bFpFYmZpaUpmT1lq?=
 =?utf-8?B?N2VkSVd6TVNFUVFkYk9tS3dLUmxacEVvMGxaVTVxZy9RU2RaRFBSRElOWUtp?=
 =?utf-8?B?M1lWL2hCMTNSMzRwdkJBR0NXNzNGKzZwWDI0czAvazZtZjNvS2Q5T0RUalpV?=
 =?utf-8?B?ZVpuaEJuaHRhb1NTRnFLdnJiZTBzVEVzdXV6My9RYzJ2dWtyOW1aYmtZU216?=
 =?utf-8?B?MEZEdkp4YW5DRnAvUFo3aUt3cTJUcEhiWk15MnRuUXJLaFE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(43062017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q2JBR0QrMjZkYTA5N3loR2trTWRCTSsvREV5RjBuY1dvcmFLSXRXZjBLZEhF?=
 =?utf-8?B?Y2dCbk5tdForaEpoYU1lU3l4RVNWdm1hOVhDbTFSb0ZFVzRsZ1cvUE16RUtG?=
 =?utf-8?B?REo1RG5TQTlmNFhJRXQwSDdzZCtqbElGbUozdW44QkR1Y2lEclhGZEJVbmhi?=
 =?utf-8?B?VmNZMFVzNTFBOE1ZdU55eU8zVjFBb3FraVB0NEpETUlTdXVVbmtPOGJ4QTNY?=
 =?utf-8?B?czF4cVZjWXBnT0ZBUWZBSW13b1JwNXprK2kwVEZrUXZPemlxNVcyN2J2dFZD?=
 =?utf-8?B?UkdtdnJVY3U4VU0rVEdDU1puUjNZR3YyV2hXMFd4VDlKWGl2aTNiVUdQT1du?=
 =?utf-8?B?N0VLVGJIdFZMT2xPZmVERmU4ZEtEandxenAwL2VHYSt1cCtGbTE1dzFPZzFS?=
 =?utf-8?B?VSthNk4xU2xKRFpadElQVU9QVjQ1bHAwY2g2VG9uMlRHbXg1bUFERjlMYlZu?=
 =?utf-8?B?bkJwREUvUzVWZVYwdytiQzlDbWZRNnRFWFBlY2hqR0drTGdpTWFPRlVabFMy?=
 =?utf-8?B?UTBWV1FLZnhPbGxINk1icTBEUTJEQTBrWHlLLzdMNDFsYjZJRStzK2dGN2FD?=
 =?utf-8?B?NnRPeW1GNkxPT3dZS0V0WnMvVXRyc3pyNjlsVlVPMm9nOFJTVzZKS1lqaUNm?=
 =?utf-8?B?YjRycWNsaUI0YTJKKzIwaGlQQ2FSM2RFQzNFS3JESlJOL3lrZ2FNeXpoUzAy?=
 =?utf-8?B?WTlXVjNsNXVBZFMrTmpsdHI1ZUlrclQrS1hpWVpkRG5RK21HL0pzcHI2MWNn?=
 =?utf-8?B?bzA5MmpOYjlIelF6Q1lQQjNCMXdlY0U0RG5OZUgwcHdUeVJMaEtrMVNxVXV5?=
 =?utf-8?B?RDJrZ1NGOFNzRTN6NDVLRWFkc1Bxbzc4bnVWVTQzbE5ZUHJUZGNpTzRkUnA1?=
 =?utf-8?B?S2tzT0VhQVFYK09nZUJCa2M5VFZaTEJhcXpVdDlQVkNOTXo1RjRFTEE5ODJz?=
 =?utf-8?B?SUZJMC8wRnl2NXh0ekNRcGZDSnJqYXB2a0FpYno2ejRkN094UC9qUGk0aUIr?=
 =?utf-8?B?aWFiSXNHaHd1KzBlR3ZRaVNIWEkvSElzejBtZTR6NVRzTlF2ZENldUx1bWhi?=
 =?utf-8?B?dmV3aFNUcHdyR0JMaE1hZE9RT2d5V1VFdnhsbTBCak15YlRBUVdLSjl3WGtx?=
 =?utf-8?B?aXBVaWp6WU1oTlpRbUp5YUwrTXk4bnVvb0dFNzZmQUtVV1c0WmFjc2d6czdP?=
 =?utf-8?B?TVQ1UGQ3SWlPREpranJEOXdBWXBPUGI4L2J0OFZVSjRVd1hOSmQ0eU5QUnoz?=
 =?utf-8?B?UWZ5OXlDWjVxTlM4b1ozTGFSL0pRV1AvbDlpczBBYTZtN3RPbEJUeHFheG0w?=
 =?utf-8?B?RW1qbndWeTRxZzZXMk51UWxERm8zbmk1Zm9YV2xRa1ZUREZTVDdDTlRKcUZa?=
 =?utf-8?B?ekFLeGtQUHl5OE5pVk5SVXR3NS9TUkY3em9ZOUZxMnFMOTZHRVpvRm5MQlRx?=
 =?utf-8?B?VmJKTkdYK0lyS2VFN2U0MEQvdmVubDhlZ2tGcTlHcnpOTXV4R3ZKaEtzZmE0?=
 =?utf-8?B?U3Ryd0NrRlljd1NFSVgwK3BXdjBTRVVPWlpMaFNNbjBwVEpEbDMzSC9UWVlU?=
 =?utf-8?B?QzZJLzQvdjBrRVhmVzY2SGlCVGVsVTI4bENrU0Y4VWF5REFRUFFWK3VzMnVW?=
 =?utf-8?B?WlpsOGpDYUNkSXlnNFJLVVFudFhUNDNWL3VDc1phcjZWN0hMMU02aEZTWmRx?=
 =?utf-8?B?cGxQRWhxYUZodTAvc0x5Zi9URDk1VU5JTWxDQk1JWlRYRTFkSHg1NUEvM1Z3?=
 =?utf-8?B?K3VpdXo0RHV0djhaclRyWDRXT3BxWm9jQ3lrRW1JVEhuWTBPQUxhYzhHYXZ0?=
 =?utf-8?B?a1VXQmM4bE5ZT1pKNG40VC8raFIwM0VWbWNrbTJ0aTA3c1VnL0JhMWo3cUZq?=
 =?utf-8?B?ZHpXQUIrRWpJTnpsbkV3WHVMNndmemhNTXFiK3h0dThNdWlEZXNEaURpUldv?=
 =?utf-8?B?ZC92amtQd0RVaHBPMmtvQUdVanIwQ0tSS0tuZHN6RC9mZkpsUEt3WkQ3Q3kz?=
 =?utf-8?B?YnBlV0lHZGNGOWVKeE9BbHlKWXRRTm14N2VteG0vb2tMQWJGbGlra05YTlQx?=
 =?utf-8?B?NzB5Q29NUU85Zzl0ZlhhZXYrZG1SZ1hCU0JmTk1PVXcxQTdjUXlldXdGOXRu?=
 =?utf-8?Q?lYmkChzyHS6KlJYU0Lpl6xBqJ?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd1de586-738c-4d01-8645-08dcb11d314d
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 04:56:51.9867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Eh/zMWPtD6PK91CxHTaWY2w1YIIKFo9w/N/TWCZLKTt3GWLFyQBG001Tf0/wYhj9gQ52UPwozA6RuMMGYNNtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6237



在 2024/7/31 10:18, Barry Song 写道:
> [Some people who received this message don't often get email from 21cnbao@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> On Tue, Jul 30, 2024 at 7:44 PM Zhiguo Jiang <justinjiang@vivo.com> wrote:
>> The main reasons for the prolonged exit of a background process is the
>> time-consuming release of its swap entries. The proportion of swap memory
>> occupied by the background process increases with its duration in the
>> background, and after a period of time, this value can reach 60% or more.
> Do you know the reason? Could they be contending for a cluster lock or
> something?
> Is there any perf data or flamegraph available here?
Hi,

Testing datas of application occuping different physical memory sizes at 
different time
points in the background:
Testing Platform: 8GB RAM
Testing procedure:
After booting up, start 15 applications first, and then observe the 
physical memory size
occupied by the last launched application at different time points in 
the background.

foreground - abbreviation FG
background - abbreviation BG

The app launched last: com.qiyi.video app
|  memory type  | FG 5s  | BG 5s  | BG 1min | BG 3min | BG 5min | BG 
10min | BG 15min |
---------------------------------------------------------------------------------------
|     VmRSS(KB) | 453832 | 252300 |  207724 |  206776 |  204364 | 
199944   |  199748  |
|   RssAnon(KB) | 247348 |  99296 |   71816 |   71484 |   71268 | 
67808    |   67660  |
|   RssFile(KB) | 205536 | 152020 |  134956 |  134340 |  132144 | 
131184   |  131136  |
|  RssShmem(KB) |   1048 |    984 |     952 |     952 |     952 | 
952      |     952  |
|    VmSwap(KB) | 202692 | 334852 |  362332 |  362664 |  362880 | 
366340   |  366488  |
| Swap ratio(%) | 30.87% | 57.03% |  63.56% |  63.69% |  63.97% | 
64.69%   |  64.72%  |

The app launched last: com.netease.sky.vivo
|  memory type  | FG 5s  | BG 5s  | BG 1min | BG 3min | BG 5min | BG 
10min | BG 15min |
---------------------------------------------------------------------------------------
|     VmRSS(KB) | 435424 | 403564 |  403200 |  401688 |  402996 | 
396372   |   396268 |
|   RssAnon(KB) | 151616 | 117252 |  117244 |  115888 |  117088 | 
110780   |   110684 |
|   RssFile(KB) | 281672 | 284192 |  283836 |  283680 |  283788 | 
283472   |   283464 |
|  RssShmem(KB) |   2136 |   2120 |    2120 |    2120 |    2120 | 
2120     |     2120 |
|    VmSwap(KB) | 546584 | 559920 |  559928 |  561284 |  560084 | 
566392   |   566488 |
| Swap ratio(%) | 55.66% | 58.11% |  58.14% |  58.29% |  58.16% | 
58.83%   |   58.84% |

A background exiting process's perfedata:
|      interfaces              | cost(ms) | exe(ms) | average(ms) | run 
counts |
--------------------------------------------------------------------------------
| do_signal                    |  791.813 |   0     |     791.813 |     
1      |
| get_signal                   |  791.813 |   0     |     791.813 |     
1      |
| do_group_exit                |  791.813 |   0     |     791.813 |     
1      |
| do_exit                      |  791.813 |   0.148 |     791.813 |     
1      |
| exit_mm                      |  577.859 |   0     |     577.859 |     
1      |
| __mmput                      |  577.859 |   0.202 |     577.859 |     
1      |
| exit_mmap                    |  577.497 |   1.806 |     192.499 |     
3      |
| __oom_reap_task_mm           |  562.869 |   2.695 |     562.869 |     
1      |
| unmap_page_range             |  562.07  |   3.185 |      20.817 |    
27      |
| zap_pte_range                |  558.645 | 123.958 |      15.518 |    
36      |
| free_swap_and_cache          |  433.381 |  28.831 |       6.879 |    
63      |
| free_swap_slot               |  403.568 |   4.876 |       4.248 |    
95      |
| swapcache_free_entries       |  398.292 |   3.578 |       3.588 |   
111      |
| swap_entry_free              |  393.863 |  13.953 |       3.176 |   
124      |
| swap_range_free              |  372.602 | 202.478 |       1.791 |   
208      |
| $x.204 [zram]                |  132.389 |   0.341 |       0.33 |   
401      |
| zram_reset_device            |  131.888 |  22.376 |       0.326 |   
405      |
| obj_free                     |   80.101 |  29.517 |       0.21 |   
381      |
| zs_create_pool               |   29.381 |   2.772 |       0.124 |   
237      |
| clear_shadow_from_swap_cache |   22.846 |  22.686 |       0.11 |   
208      |
| __put_page                   |   19.317 |  10.088 |       0.105 |   
184      |
| pr_memcg_info                |   13.038 |   1.181 |       0.11 |   
118      |
| free_pcp_prepare             |    9.229 |   0.812 |       0.094 |    
98      |
| xxx_memcg_out                |    9.223 |   4.746 |       0.098 |    
94      |
| free_pgtables                |    8.813 |   3.302 |       8.813 |     
1      |
| zs_compact                   |    8.617 |   8.43  |       0.097 |    
89      |
| kmem_cache_free              |    7.483 |   4.595 |       0.084 |    
89      |
| __mem_cgroup_uncharge_swap   |    6.348 |   3.03  |       0.086 |    
74      |
| $x.178 [zsmalloc]            |    6.182 |   0.32  |       0.09 |    
69      |
| $x.182 [zsmalloc]            |    5.019 |   0.08  |       0.088 |    
57      |
cost - total time consumption.
exe - total actual execution time.

According to perfdata, we can observe that the main reason for the 
prolonged exit
of a background process is the time-consuming release of its swap entries.

The reason for the time-consuming release of swap entries is not only 
due to cluster
locks, but also swp_slots lock and swap_info lock, additionally zram and 
swapdisk free
path time-consuming .
>
>> Additionally, the relatively lengthy path for releasing swap entries
>> further contributes to the longer time required for the background process
>> to release its swap entries.
>>
>> In the multiple background applications scenario, when launching a large
>> memory application such as a camera, system may enter a low memory state,
>> which will triggers the killing of multiple background processes at the
>> same time. Due to multiple exiting processes occupying multiple CPUs for
>> concurrent execution, the current foreground application's CPU resources
>> are tight and may cause issues such as lagging.
>>
>> To solve this problem, we have introduced the multiple exiting process
>> asynchronous swap memory release mechanism, which isolates and caches
>> swap entries occupied by multiple exit processes, and hands them over
>> to an asynchronous kworker to complete the release. This allows the
>> exiting processes to complete quickly and release CPU resources. We have
>> validated this modification on the products and achieved the expected
>> benefits.
>>
>> It offers several benefits:
>> 1. Alleviate the high system cpu load caused by multiple exiting
>>     processes running simultaneously.
>> 2. Reduce lock competition in swap entry free path by an asynchronous
>   Do you have data on which lock is affected? Could it be a cluster lock?
The reason for the time-consuming release of swap entries is not only 
due to cluster
locks, but also swp_slots lock and swap_info lock, additionally zram and 
swapdisk free
path time-consuming . In short, swap entry release path is relatively 
long compared to
file and anonymous folio release path.
>
>>     kworker instead of multiple exiting processes parallel execution.
>> 3. Release memory occupied by exiting processes more efficiently.
>>
>> Zhiguo Jiang (2):
>>    mm: move task_is_dying to h headfile
>>    mm: tlb: multiple exiting processes's swap entries async release
>>
>>   include/asm-generic/tlb.h |  50 +++++++
>>   include/linux/mm_types.h  |  58 ++++++++
>>   include/linux/oom.h       |   6 +
>>   mm/memcontrol.c           |   6 -
>>   mm/memory.c               |   3 +-
>>   mm/mmu_gather.c           | 297 ++++++++++++++++++++++++++++++++++++++
>>   6 files changed, 413 insertions(+), 7 deletions(-)
>>   mode change 100644 => 100755 include/asm-generic/tlb.h
>>   mode change 100644 => 100755 include/linux/mm_types.h
>>   mode change 100644 => 100755 include/linux/oom.h
>>   mode change 100644 => 100755 mm/memcontrol.c
>>   mode change 100644 => 100755 mm/memory.c
>>   mode change 100644 => 100755 mm/mmu_gather.c
> Can you check your local filesystem to determine why you're running
> the chmod command?
Ok, I will check it carefully.

Thanks
Zhiguo
>
>> --
>> 2.39.0
>>
> Thanks
> Barry


