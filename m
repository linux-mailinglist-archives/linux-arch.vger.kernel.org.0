Return-Path: <linux-arch+bounces-7228-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E9A9762B5
	for <lists+linux-arch@lfdr.de>; Thu, 12 Sep 2024 09:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 374B31C23144
	for <lists+linux-arch@lfdr.de>; Thu, 12 Sep 2024 07:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90AF188CDA;
	Thu, 12 Sep 2024 07:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="hmVaPY2M"
X-Original-To: linux-arch@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2080.outbound.protection.outlook.com [40.107.117.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD7E28F5;
	Thu, 12 Sep 2024 07:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726126269; cv=fail; b=lIFs5eM3IiXME8fsIDCf4VD8EEIUioxOxKn6xZr7egP1oxnyqFiNnrLYz/qtdadABi8SKpvLvb5LcLuMYjrjVRYALKIVeTElBZ6zrz89kEF9xHM9AZo2+do436iaom0W/GtlPVD1N7hhVObEpetmKCh+6tAxddL347wrJF8U0m8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726126269; c=relaxed/simple;
	bh=HzLLJHZqW+jH68oD3HfV2KJC1ObAAA8ev9jV8Agw73c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KHAafyCsEmAYdWVIQgssYyq5jsED6oLvg4lLcQ648RMcE7ZDU7TTmiVNVRGDyi0CfN/VJw0nGg5XztaUsQXSIHmUSLE/lGOXqg0kPSDDprtG82TFUqLRITefqQHMcDrRTU/1fzxcaR9FMAQbxdwIRk9cdDgv5Xav8TCbUbF17m8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=hmVaPY2M; arc=fail smtp.client-ip=40.107.117.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MKp7cgZKXc6Ja3cMrN97+XKshN0drcgputyWoORBSoCCzn6EfF4iHxPR0qJ65suVp46+1gO46a7BFsw9COMYDBlgCISohaa2zxof7CuYoLKq4OLqSawNokKe+7k591i6fdraGvAEhmSg0+7hOEf8sDVGCnQ/JWm0irungrQ/jAE+lDOYqjIGzdSUVzd93JSSSqVUcYsLFvK6B1OAZXmARjG5SWreX+uE2punfTFezCl9VnGQdyLVtqH58hspQzQ4/OZHF2VWxHfvaOAHVymznZGv5Xvr+FpIPqxuCVefIQ5oGmjfnBtIc7/ELmBnvucVpfDenGQ25JgKQtPzmOW11g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nboLgU/NdrZYww4ecyoJ36YxoK9SDLfahNbeZVVH608=;
 b=VmfsQJrxjWJjeGnLG+t0oXZSMXd/AjDnEb+hi7u7SavHBLPNUIMyuKor3bgQ91dWb8fvHV/6+HGuKa5O7dTMcOaMjQ2f0AH/4dhutJDgNqKXQ6JsL1bqzIayksm9RQqkJc6N3qrs2njBH1Q+lT+F0p1Nkvp/d0172v0jgwMmuNx8MNEMIOfCHxsN3NX5TAIQcnR9IAY+0syg0xW4Wye1TXawNG8+AqL/I/1o9wmJyM2DABhSXQmV+IW/mTOpwJyJ9tc9bHotrI6WGqNu7ukSzG3PuoPgNUgRM+MStdy2Xl49EZXrS/QNQT54Q0KR9iP9HlHXxqYeLI2MoODwiu9Pwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nboLgU/NdrZYww4ecyoJ36YxoK9SDLfahNbeZVVH608=;
 b=hmVaPY2MW4g3lNiJpTnSBLd2iW43rIEgm2A4sM3qpEbL0XB1459mNywBZi6SJtnfvFvuAflGfkUu4U5ZhrnjQjZhMuE3MW2vas+z+xFNMbaVd7OdksmfrHqxWQCLfh+CdcKdWOJmuBFmqyCsBiBoit8kaHKg1WVeGgl+Ukc4v0l7JJF1kil7B3Tr73Y9qZwj1jq4Dm6F9U/9sr/5cZw3PxvisszZSeWbtcOchnD1S0TcjGMl6+oIi3AVXaZCQAlWWcu8fkKUfE087EjbLX/xOXi1tpKM5HgQeTlpOMLdE51gfvxAlUaRDwyiKVBlroWk4suGsVCiafJza7A+GGaIFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by SEZPR06MB6206.apcprd06.prod.outlook.com (2603:1096:101:e8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25; Thu, 12 Sep
 2024 07:31:01 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed%3]) with mapi id 15.20.7939.022; Thu, 12 Sep 2024
 07:31:01 +0000
Message-ID: <2bee0223-ea5f-469f-a075-022f47d5be55@vivo.com>
Date: Thu, 12 Sep 2024 15:30:57 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] mm: tlb: add tlb swap entries batch async release
To: Barry Song <21cnbao@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin
 <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
 Arnd Bergmann <arnd@arndb.de>, Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 linux-arch@vger.kernel.org, cgroups@vger.kernel.org,
 David Hildenbrand <david@redhat.com>, opensource.kernel@vivo.com
References: <20240805153639.1057-1-justinjiang@vivo.com>
 <20240805153639.1057-3-justinjiang@vivo.com>
 <CAGsJ_4zXtJvBdgpDs+yyEwfdJ0gy+_dgrWLF1zxMgBbaLBeiYA@mail.gmail.com>
 <400918d7-aaaf-4ccc-af8e-ab48576746d1@vivo.com>
 <CAGsJ_4yAeuEFbmOoAqW4FRv3x9WNtfu3TZcuXOqb7sf3Jsgd9g@mail.gmail.com>
 <1e7e24a7-e602-4654-ba3f-d3e4d1a2a65e@vivo.com>
 <CAGsJ_4yhSVggqh-v7AjV1v3oTpVaQkMxyY4YYT1vRd5na_tpTQ@mail.gmail.com>
 <90e13734-526f-44fb-8a5c-8e8199a5aef3@vivo.com>
 <CAGsJ_4wPzSJhr_gT3oeSbbRBhqORLr17S9U30zX9x1=vDC2g6g@mail.gmail.com>
From: zhiguojiang <justinjiang@vivo.com>
In-Reply-To: <CAGsJ_4wPzSJhr_gT3oeSbbRBhqORLr17S9U30zX9x1=vDC2g6g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0137.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::17) To JH0PR06MB6849.apcprd06.prod.outlook.com
 (2603:1096:990:47::12)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|SEZPR06MB6206:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e423e6e-d09a-4740-3b48-08dcd2fcd9c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|43062017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cWFjRWsvZ2lSZHRia0RDVmRWemYzOFRrNnNZb25EcHZQeGVqVUFScHAyRmgy?=
 =?utf-8?B?T2hzRTlZa0c1MFBwYnlTRHpwNHVGb1phc3lMM2QvTCthUVAwWnAwZ2dtdEZT?=
 =?utf-8?B?TXRnUWlHRmhnZmlPSDlEU2lhOGxRWm55alhsMEtqUkg1dlowaStMWVBmdzdh?=
 =?utf-8?B?d2dQRDFkSDBmRjlZRUdJQ0tFWWdSS3E2M3MzYnp0NTVsbUpVb3hxa0hxTkJw?=
 =?utf-8?B?M0dKU0lkTDh0Yy95QUNXNGtQWXdadzJiUjBQV1dyeU5NUjhmQjNkTFFTWVk3?=
 =?utf-8?B?ZmdEWUFuRXlUTEpMa093Lzh2cDVUZDRyVWVyTGtJeG81L2lIenNzOS9ZMGpp?=
 =?utf-8?B?dmFnYkJNVFh1M2JreDlMZkNuSEJJQzJ0UHM3RkJ2OUpkbWs3UWxjazNwVzRI?=
 =?utf-8?B?c2krQU52M0xocW9sZTJUSkRUZHZQVTBGWWZOTXJ0RnBGSlk0Y1VjbS92ak44?=
 =?utf-8?B?ZFpzSlF4WjV6bjNONVNUNTdUY3M3eDJ3WjFFSWRXMW9LcnBETk5MTHFVcnMx?=
 =?utf-8?B?ckkxcmV1aXVaSUpJUjh0NzhqM1pHa3BrRlAxOEw4djFsRVZDd1krbGZ5NnBM?=
 =?utf-8?B?anloZkZ4Snh6djc1K0xPWSs0ZzhMRFdiV2Z0TysvdzlKOXZNYk44Yjh0Vm40?=
 =?utf-8?B?WCtKbytnbXA5SWhkYWhUc2lqbkE3c000WWxZOTVTc2JkYThuSmo2RmwrNmlk?=
 =?utf-8?B?bG1MblE4emJUNUhFL1Jza2dqbEdWZHBmalRrOWdtZ3ZPN3ZRc2FwS1BxZ2NF?=
 =?utf-8?B?djhlOG45Qm02eEptK2dnY0FJdlExQkF5cWJLYjN3VXVPMXpFYU1qY3grZ3du?=
 =?utf-8?B?L3doQzA0WjRkQzM2T2ZSc25SUzlvdUYrQWV6NnF3QlF3SEFxamhMK0FSazVj?=
 =?utf-8?B?TFVnOUxKd21sL1hqdVIwYTNiY3Y1U2w3UHc0REpobnRLQ1JGTDE5QjJtR0dE?=
 =?utf-8?B?N1RKWE9hUXpWMTMrYlhKWGRpa2NUZzd6YVRjTnM1ekJvRmIyckk1NlQvbE84?=
 =?utf-8?B?UlBqSTFQb21DSVV1ams3K05oOEJZOW9rVXphSHpqMjladUNINFJaSkpDV1Bu?=
 =?utf-8?B?UmV5aVdDN3h1TzNzRWtGRElMRjhSVmc1K1BkdjUxSUJCREFuNW5YNXNQZm9V?=
 =?utf-8?B?SzArL09QMVN0bGJpS0Z2WUtVSnNraFFhcis0SGcwT2NDdE1kMmFhMFFKTXJP?=
 =?utf-8?B?T1pSalRMSk9qSDBLWHE0V0RMZlVraTMxRk5KOUduQngxcHV3VWZFczlJd1Y0?=
 =?utf-8?B?OHVSM0MweUtMVEpFcDBsRU9oZHJuOC8waTZQSmpJVVh4VDFZR2RqZHNZeVpP?=
 =?utf-8?B?dThuSThKSkxvOWt3U090WGorSUpROEE4QlBGaTBOTFA4MW1tTHdVVG1wZEY4?=
 =?utf-8?B?aW9mUUtKNjd3dkxkSDlYTWZ2QmtvajVadzFHMGM5NFVCMFdNYzhEaGVHek5k?=
 =?utf-8?B?TExkMEw4K2JQL2gydG5YUVNRNU1qT2NxUnRuYVpIaEEwVGQwTW5laDhkVk1I?=
 =?utf-8?B?bUtVV3RkTmMwN0I5QWxqUzJPalNRYkVnOGhFc3JqK3JEd3FOUTFEQUFuMmtB?=
 =?utf-8?B?NXF4eE5sb016Ky94cm1rMU8vQ2Nudnd1Vmlrci9oOTZWaGFrODBSeUxmRzFx?=
 =?utf-8?B?UThLWjFkTHUzR1pDY3ZCWnFjaVFIZ3RneWN6OTFjRWZ5ZEZrYk9SREkzajlC?=
 =?utf-8?B?WVZOMlBYMVFxbGpQWkIyV2pUWHpuK2RhQW10Y0kvTkZ1dlJEdE5vb1hKS1RX?=
 =?utf-8?B?ZkJDUE1lOG83UDlyanFpK21xLzViTkhuQllzWEZyNU95UjlRMExjbVNXdVVi?=
 =?utf-8?B?aXZOUUJRQngyMVUyamVua2NGVWYyM2NOS2VlalNVQzZDSExIVzVxNmVkZmlQ?=
 =?utf-8?B?eXB5a1dHbmsrQTJ5Sld2bHBhRHNucmN1RTI3TUJVVmJUS3c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(43062017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VWZOcllLakc0dnVSRFNVVm5xSkptRkdnUDJrOXVtVTdyL2VRQjF2UEpYT290?=
 =?utf-8?B?VjJiM1cxZ0Jrcm16eDUyNTlMYnVlRUZVbzVSUjl2WC8rUUczS2xISzBJa3dI?=
 =?utf-8?B?dTZTcENwZk12VUQ1L21WcVBPWkN0WU1VNEp6YlQyem1MUnQyT2g4OTc0TWdO?=
 =?utf-8?B?cVRkanRCY05ESnl0YzR0Zktza0JJb0hwZHB3dHpRTGxqOEFubjBCQUJ5MWFy?=
 =?utf-8?B?WmJoUUZGelJPWURSdTZ4N3RBSjFZcFo3bFFvVkU0R081Y3dBb0pHRTI4UC9u?=
 =?utf-8?B?dzBrSHdSNjlMOUZoUjB6SGg4UjN3S0FIUCs2ejNaTm1xaUl6anNJUEN4QnRp?=
 =?utf-8?B?SWRBU3VZc3haVWtpRk92bUk5amxERGJ1RFdVZDRwUUtuT2pUbm8ySVBnR0lM?=
 =?utf-8?B?VmhMaWk2Ry9lMWM2b2dOc1grZjFIVVN3VWh4cG1DNCtsS1p5K0RXcUpPRFhM?=
 =?utf-8?B?OUl2dnZYdXBOandFc2k0MGIvb2ptZTVaRGtIeTdvOHFsYzhCcjllV1k1Z3JS?=
 =?utf-8?B?OEo2b0RzOGprSk94dk5BemxhVXpXcCtCaG1JaHlCcEtTTnNTRVBydXg0TXh1?=
 =?utf-8?B?QjNLTENwQjIybHJnWFlxS1lrdmlNc01xUmZxSDJ2Mk1oc2QzZURJWE5IZTd3?=
 =?utf-8?B?TUdkWWRIVG9oSnQraHF6SjBOaG9xdGtIN1htcWlsaU1EV2NHb2g0MGZUaWJO?=
 =?utf-8?B?RUN0Z1hlK1R5TWg4K1I5YnMrNXRCcnB3b0tIWVlTKzZWek90U0JFTmlYTHNt?=
 =?utf-8?B?TnlSR0tEazREaWRxSkNuemgwOWtWTVFIT20wcXNpQ0piUktpM2hSTUY4d2VL?=
 =?utf-8?B?VzNUUkhWTTZXYW5Oa0VNOFc0WFV1M2orNDdZMmpMM2lsejNreXhUSnhIU21D?=
 =?utf-8?B?N3NrNks4dGdXUTdtNm55emVuemlEOE5haXRkSEJaLzFISFRCbCtGcjI2ZFp5?=
 =?utf-8?B?djh0c0FXRjB5UFM4L25ETHd5UFQzamJRY0dqNUFMVXhkekdsN1RQK05vL3lK?=
 =?utf-8?B?UU5ZdmEzdW1BM2hlTVVna0N6MkRLY3RjZURXSXVaSTFybFZhbWZNRHVMSkcy?=
 =?utf-8?B?UHVheEJBT2JXSWNOSmNzaUVCY3U1S0Y3di9LeWdUa29jUlJpV3VRdnc5SFI0?=
 =?utf-8?B?ZE4vcjRLb2NySDBaR05DSmkzWEF0V1F4STBCYU1zOUNNZEk0ZU9pVVVzbU5o?=
 =?utf-8?B?QlNLdEJzZkRUSjNjZkxYVXhpeTJsMEl0bXBUS01VSkRKZVFFcmhDWmpRdmpP?=
 =?utf-8?B?bnhVN3FRaGN0amRLWW1rcUZkSm9SS0hvemliMUMrcHBpMFByaERjcWN0NmFB?=
 =?utf-8?B?Tm9CQ1lNaFNtVWRMU3JhdTl4a25VNWdEOXpVWGlvS1VpWGdiSWU2MjdzVjdj?=
 =?utf-8?B?eFZjcEhlUGRmWVpkS1E2Szd5MWE4UHRXZVJaN3V6M0t6eTVpNFBrU25GbUVk?=
 =?utf-8?B?ZEhYMXJ1bi8xdFRyL3BZTUtUczU5SFNXcVlBZWUrbVhGS043ejByeDlWMlFP?=
 =?utf-8?B?d0FyZDltMkVyRVAwU0tQWmVyeW02OGFyWkFjelhyUEVFQ2kwWndpMjdOVWNl?=
 =?utf-8?B?K2xYSklBU2FXU2xrNituQ0lRZXVDOGN3ZVpqYUJhWHpwc0tPNmtzbUZzNFNj?=
 =?utf-8?B?d2IxTHZCejR6aWF4clVGOUIzVkRPaEJtdWFsYzZHT2hGbndabzg3bFVlT01o?=
 =?utf-8?B?NStnWVZMUUt3L25uWERZK2N6TkxOaXdLRFB5OWNpdy9SMXVObXh1bk91U2lN?=
 =?utf-8?B?cW92Y3pCV2NXQVJkZTlhREF0eENwYVhha0RqZXVCdWtFbmI4c2ozR2lCenpH?=
 =?utf-8?B?eWlYQU5CSkZHNUhLVGZYeStEOStYSmhuSVVRSjNFYUdMWHR0Mjg1ajJQK3Jx?=
 =?utf-8?B?UWt1clVqRUdhVnNHSmtLWXJZaGsxMVMxOFRGcmhEWUhzYXNKZFBQenRFbW5T?=
 =?utf-8?B?cHE1QjlZdkpPK0gxcEJtSEt4SHFBVk9JUjBNb2NUa1Rma1JLcS9Ydk8zbk9o?=
 =?utf-8?B?Nkc2OVM0M1RnVGRkVDM1T2tuNHluWURKTDZVbHBhZEthb0ptelJrT0JLS2E3?=
 =?utf-8?B?aUtlSnZKQllhRWc0Nm9FMDJQdjFoZDN5KzRxcDF3Z0VoampEcjEyeDNlNmJn?=
 =?utf-8?Q?Whq5nz6jgnWgT5XinSNdf6mI1?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e423e6e-d09a-4740-3b48-08dcd2fcd9c0
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 07:31:00.8378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p4WD98rqKWzbYmAkBAP2sCZfe2dp/biPl9FWbrHIjnf/NT1cWlYLfsqDAZa8ZKvEU4hkN4VavLn3cg2OYfkVTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6206



在 2024/9/10 18:11, Barry Song 写道:
> On Tue, Sep 10, 2024 at 9:22 PM zhiguojiang <justinjiang@vivo.com> wrote:
>>
>>
>> 在 2024/9/10 12:18, Barry Song 写道:
>>> On Tue, Sep 10, 2024 at 2:39 AM zhiguojiang <justinjiang@vivo.com> wrote:
>>>>
>>>> 在 2024/9/9 9:59, Barry Song 写道:
>>>>> On Wed, Sep 4, 2024 at 11:26 PM zhiguojiang <justinjiang@vivo.com> wrote:
>>>>>> 在 2024/9/4 17:16, Barry Song 写道:
>>>>>>> On Tue, Aug 6, 2024 at 3:36 AM Zhiguo Jiang <justinjiang@vivo.com> wrote:
>>>>>>>> One of the main reasons for the prolonged exit of the process with
>>>>>>>> independent mm is the time-consuming release of its swap entries.
>>>>>>>> The proportion of swap memory occupied by the process increases over
>>>>>>>> time due to high memory pressure triggering to reclaim anonymous folio
>>>>>>>> into swapspace, e.g., in Android devices, we found this proportion can
>>>>>>>> reach 60% or more after a period of time. Additionally, the relatively
>>>>>>>> lengthy path for releasing swap entries further contributes to the
>>>>>>>> longer time required to release swap entries.
>>>>>>>>
>>>>>>>> Testing Platform: 8GB RAM
>>>>>>>> Testing procedure:
>>>>>>>> After booting up, start 15 processes first, and then observe the
>>>>>>>> physical memory size occupied by the last launched process at different
>>>>>>>> time points.
>>>>>>>> Example: The process launched last: com.qiyi.video
>>>>>>>> |  memory type  |  0min  |  1min  |   5min  |   10min  |   15min  |
>>>>>>>> -------------------------------------------------------------------
>>>>>>>> |     VmRSS(KB) | 453832 | 252300 |  204364 |   199944 |  199748  |
>>>>>>>> |   RssAnon(KB) | 247348 |  99296 |   71268 |    67808 |   67660  |
>>>>>>>> |   RssFile(KB) | 205536 | 152020 |  132144 |   131184 |  131136  |
>>>>>>>> |  RssShmem(KB) |   1048 |    984 |     952 |     952  |     952  |
>>>>>>>> |    VmSwap(KB) | 202692 | 334852 |  362880 |   366340 |  366488  |
>>>>>>>> | Swap ratio(%) | 30.87% | 57.03% |  63.97% |   64.69% |  64.72%  |
>>>>>>>> Note: min - minute.
>>>>>>>>
>>>>>>>> When there are multiple processes with independent mm and the high
>>>>>>>> memory pressure in system, if the large memory required process is
>>>>>>>> launched at this time, system will is likely to trigger the instantaneous
>>>>>>>> killing of many processes with independent mm. Due to multiple exiting
>>>>>>>> processes occupying multiple CPU core resources for concurrent execution,
>>>>>>>> leading to some issues such as the current non-exiting and important
>>>>>>>> processes lagging.
>>>>>>>>
>>>>>>>> To solve this problem, we have introduced the multiple exiting process
>>>>>>>> asynchronous swap entries release mechanism, which isolates and caches
>>>>>>>> swap entries occupied by multiple exiting processes, and hands them over
>>>>>>>> to an asynchronous kworker to complete the release. This allows the
>>>>>>>> exiting processes to complete quickly and release CPU resources. We have
>>>>>>>> validated this modification on the Android products and achieved the
>>>>>>>> expected benefits.
>>>>>>>>
>>>>>>>> Testing Platform: 8GB RAM
>>>>>>>> Testing procedure:
>>>>>>>> After restarting the machine, start 15 app processes first, and then
>>>>>>>> start the camera app processes, we monitor the cold start and preview
>>>>>>>> time datas of the camera app processes.
>>>>>>>>
>>>>>>>> Test datas of camera processes cold start time (unit: millisecond):
>>>>>>>> |  seq   |   1  |   2  |   3  |   4  |   5  |   6  | average |
>>>>>>>> | before | 1498 | 1476 | 1741 | 1337 | 1367 | 1655 |   1512  |
>>>>>>>> | after  | 1396 | 1107 | 1136 | 1178 | 1071 | 1339 |   1204  |
>>>>>>>>
>>>>>>>> Test datas of camera processes preview time (unit: millisecond):
>>>>>>>> |  seq   |   1  |   2  |   3  |   4  |   5  |   6  | average |
>>>>>>>> | before |  267 |  402 |  504 |  513 |  161 |  265 |   352   |
>>>>>>>> | after  |  188 |  223 |  301 |  203 |  162 |  154 |   205   |
>>>>>>>>
>>>>>>>> Base on the average of the six sets of test datas above, we can see that
>>>>>>>> the benefit datas of the modified patch:
>>>>>>>> 1. The cold start time of camera app processes has reduced by about 20%.
>>>>>>>> 2. The preview time of camera app processes has reduced by about 42%.
>>>>>>>>
>>>>>>>> It offers several benefits:
>>>>>>>> 1. Alleviate the high system cpu loading caused by multiple exiting
>>>>>>>>        processes running simultaneously.
>>>>>>>> 2. Reduce lock competition in swap entry free path by an asynchronous
>>>>>>>>        kworker instead of multiple exiting processes parallel execution.
>>>>>>>> 3. Release pte_present memory occupied by exiting processes more
>>>>>>>>        efficiently.
>>>>>>>>
>>>>>>>> Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>
>>>>>>>> ---
>>>>>>>>      arch/s390/include/asm/tlb.h |   8 +
>>>>>>>>      include/asm-generic/tlb.h   |  44 ++++++
>>>>>>>>      include/linux/mm_types.h    |  58 +++++++
>>>>>>>>      mm/memory.c                 |   3 +-
>>>>>>>>      mm/mmu_gather.c             | 296 ++++++++++++++++++++++++++++++++++++
>>>>>>>>      5 files changed, 408 insertions(+), 1 deletion(-)
>>>>>>>>
>>>>>>>> diff --git a/arch/s390/include/asm/tlb.h b/arch/s390/include/asm/tlb.h
>>>>>>>> index e95b2c8081eb..3f681f63390f
>>>>>>>> --- a/arch/s390/include/asm/tlb.h
>>>>>>>> +++ b/arch/s390/include/asm/tlb.h
>>>>>>>> @@ -28,6 +28,8 @@ static inline bool __tlb_remove_page_size(struct mmu_gather *tlb,
>>>>>>>>                     struct page *page, bool delay_rmap, int page_size);
>>>>>>>>      static inline bool __tlb_remove_folio_pages(struct mmu_gather *tlb,
>>>>>>>>                     struct page *page, unsigned int nr_pages, bool delay_rmap);
>>>>>>>> +static inline bool __tlb_remove_swap_entries(struct mmu_gather *tlb,
>>>>>>>> +               swp_entry_t entry, int nr);
>>>>>>>>
>>>>>>>>      #define tlb_flush tlb_flush
>>>>>>>>      #define pte_free_tlb pte_free_tlb
>>>>>>>> @@ -69,6 +71,12 @@ static inline bool __tlb_remove_folio_pages(struct mmu_gather *tlb,
>>>>>>>>             return false;
>>>>>>>>      }
>>>>>>>>
>>>>>>>> +static inline bool __tlb_remove_swap_entries(struct mmu_gather *tlb,
>>>>>>>> +               swp_entry_t entry, int nr)
>>>>>>>> +{
>>>>>>>> +       return false;
>>>>>>>> +}
>>>>>>>> +
>>>>>>>>      static inline void tlb_flush(struct mmu_gather *tlb)
>>>>>>>>      {
>>>>>>>>             __tlb_flush_mm_lazy(tlb->mm);
>>>>>>>> diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
>>>>>>>> index 709830274b75..8b4d516b35b8
>>>>>>>> --- a/include/asm-generic/tlb.h
>>>>>>>> +++ b/include/asm-generic/tlb.h
>>>>>>>> @@ -294,6 +294,37 @@ extern void tlb_flush_rmaps(struct mmu_gather *tlb, struct vm_area_struct *vma);
>>>>>>>>      static inline void tlb_flush_rmaps(struct mmu_gather *tlb, struct vm_area_struct *vma) { }
>>>>>>>>      #endif
>>>>>>>>
>>>>>>>> +#ifndef CONFIG_MMU_GATHER_NO_GATHER
>>>>>>>> +struct mmu_swap_batch {
>>>>>>>> +       struct mmu_swap_batch *next;
>>>>>>>> +       unsigned int nr;
>>>>>>>> +       unsigned int max;
>>>>>>>> +       encoded_swpentry_t encoded_entrys[];
>>>>>>>> +};
>>>>>>>> +
>>>>>>>> +#define MAX_SWAP_GATHER_BATCH  \
>>>>>>>> +       ((PAGE_SIZE - sizeof(struct mmu_swap_batch)) / sizeof(void *))
>>>>>>>> +
>>>>>>>> +#define MAX_SWAP_GATHER_BATCH_COUNT    (10000UL / MAX_SWAP_GATHER_BATCH)
>>>>>>>> +
>>>>>>>> +struct mmu_swap_gather {
>>>>>>>> +       /*
>>>>>>>> +        * the asynchronous kworker to batch
>>>>>>>> +        * release swap entries
>>>>>>>> +        */
>>>>>>>> +       struct work_struct free_work;
>>>>>>>> +
>>>>>>>> +       /* batch cache swap entries */
>>>>>>>> +       unsigned int batch_count;
>>>>>>>> +       struct mmu_swap_batch *active;
>>>>>>>> +       struct mmu_swap_batch local;
>>>>>>>> +       encoded_swpentry_t __encoded_entrys[MMU_GATHER_BUNDLE];
>>>>>>>> +};
>>>>>>>> +
>>>>>>>> +bool __tlb_remove_swap_entries(struct mmu_gather *tlb,
>>>>>>>> +               swp_entry_t entry, int nr);
>>>>>>>> +#endif
>>>>>>>> +
>>>>>>>>      /*
>>>>>>>>       * struct mmu_gather is an opaque type used by the mm code for passing around
>>>>>>>>       * any data needed by arch specific code for tlb_remove_page.
>>>>>>>> @@ -343,6 +374,18 @@ struct mmu_gather {
>>>>>>>>             unsigned int            vma_exec : 1;
>>>>>>>>             unsigned int            vma_huge : 1;
>>>>>>>>             unsigned int            vma_pfn  : 1;
>>>>>>>> +#ifndef CONFIG_MMU_GATHER_NO_GATHER
>>>>>>>> +       /*
>>>>>>>> +        * Two states of releasing swap entries
>>>>>>>> +        * asynchronously:
>>>>>>>> +        * swp_freeable - have opportunity to
>>>>>>>> +        * release asynchronously future
>>>>>>>> +        * swp_freeing - be releasing asynchronously.
>>>>>>>> +        */
>>>>>>>> +       unsigned int            swp_freeable : 1;
>>>>>>>> +       unsigned int            swp_freeing : 1;
>>>>>>>> +       unsigned int            swp_disable : 1;
>>>>>>>> +#endif
>>>>>>>>
>>>>>>>>             unsigned int            batch_count;
>>>>>>>>
>>>>>>>> @@ -354,6 +397,7 @@ struct mmu_gather {
>>>>>>>>      #ifdef CONFIG_MMU_GATHER_PAGE_SIZE
>>>>>>>>             unsigned int page_size;
>>>>>>>>      #endif
>>>>>>>> +       struct mmu_swap_gather *swp;
>>>>>>>>      #endif
>>>>>>>>      };
>>>>>>>>
>>>>>>>> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
>>>>>>>> index 165c58b12ccc..2f66303f1519
>>>>>>>> --- a/include/linux/mm_types.h
>>>>>>>> +++ b/include/linux/mm_types.h
>>>>>>>> @@ -283,6 +283,64 @@ typedef struct {
>>>>>>>>             unsigned long val;
>>>>>>>>      } swp_entry_t;
>>>>>>>>
>>>>>>>> +/*
>>>>>>>> + * encoded_swpentry_t - a type marking the encoded swp_entry_t.
>>>>>>>> + *
>>>>>>>> + * An 'encoded_swpentry_t' represents a 'swp_enrty_t' with its the highest
>>>>>>>> + * bit indicating extra context-dependent information. Only used in swp_entry
>>>>>>>> + * asynchronous release path by mmu_swap_gather.
>>>>>>>> + */
>>>>>>>> +typedef struct {
>>>>>>>> +       unsigned long val;
>>>>>>>> +} encoded_swpentry_t;
>>>>>>>> +
>>>>>>>> +/*
>>>>>>>> + * The next item in an encoded_swpentry_t array is the "nr" argument, specifying the
>>>>>>>> + * total number of consecutive swap entries associated with the same folio. If this
>>>>>>>> + * bit is not set, "nr" is implicitly 1.
>>>>>>>> + *
>>>>>>>> + * Refer to include\asm\pgtable.h, swp_offset bits: 0 ~ 57, swp_type bits: 58 ~ 62.
>>>>>>>> + * Bit63 can be used here.
>>>>>>>> + */
>>>>>>>> +#define ENCODED_SWPENTRY_BIT_NR_ENTRYS_NEXT (1UL << (BITS_PER_LONG - 1))
>>>>>>>> +
>>>>>>>> +static __always_inline encoded_swpentry_t
>>>>>>>> +encode_swpentry(swp_entry_t entry, unsigned long flags)
>>>>>>>> +{
>>>>>>>> +       encoded_swpentry_t ret;
>>>>>>>> +
>>>>>>>> +       VM_WARN_ON_ONCE(flags & ~ENCODED_SWPENTRY_BIT_NR_ENTRYS_NEXT);
>>>>>>>> +       ret.val = flags | entry.val;
>>>>>>>> +       return ret;
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +static inline unsigned long encoded_swpentry_flags(encoded_swpentry_t entry)
>>>>>>>> +{
>>>>>>>> +       return ENCODED_SWPENTRY_BIT_NR_ENTRYS_NEXT & entry.val;
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +static inline swp_entry_t encoded_swpentry_data(encoded_swpentry_t entry)
>>>>>>>> +{
>>>>>>>> +       swp_entry_t ret;
>>>>>>>> +
>>>>>>>> +       ret.val = ~ENCODED_SWPENTRY_BIT_NR_ENTRYS_NEXT & entry.val;
>>>>>>>> +       return ret;
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +static __always_inline encoded_swpentry_t encode_nr_swpentrys(unsigned long nr)
>>>>>>>> +{
>>>>>>>> +       encoded_swpentry_t ret;
>>>>>>>> +
>>>>>>>> +       VM_WARN_ON_ONCE(nr & ENCODED_SWPENTRY_BIT_NR_ENTRYS_NEXT);
>>>>>>>> +       ret.val = nr;
>>>>>>>> +       return ret;
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +static __always_inline unsigned long encoded_nr_swpentrys(encoded_swpentry_t entry)
>>>>>>>> +{
>>>>>>>> +       return ((~ENCODED_SWPENTRY_BIT_NR_ENTRYS_NEXT) & entry.val);
>>>>>>>> +}
>>>>>>>> +
>>>>>>>>      /**
>>>>>>>>       * struct folio - Represents a contiguous set of bytes.
>>>>>>>>       * @flags: Identical to the page flags.
>>>>>>>> diff --git a/mm/memory.c b/mm/memory.c
>>>>>>>> index d6a9dcddaca4..023a8adcb67c
>>>>>>>> --- a/mm/memory.c
>>>>>>>> +++ b/mm/memory.c
>>>>>>>> @@ -1650,7 +1650,8 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
>>>>>>>>                             if (!should_zap_cows(details))
>>>>>>>>                                     continue;
>>>>>>>>                             rss[MM_SWAPENTS] -= nr;
>>>>>>>> -                       free_swap_and_cache_nr(entry, nr);
>>>>>>>> +                       if (!__tlb_remove_swap_entries(tlb, entry, nr))
>>>>>>>> +                               free_swap_and_cache_nr(entry, nr);
>>>>>>>>                     } else if (is_migration_entry(entry)) {
>>>>>>>>                             folio = pfn_swap_entry_folio(entry);
>>>>>>>>                             if (!should_zap_folio(details, folio))
>>>>>>>> diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
>>>>>>>> index 99b3e9408aa0..33dc9d1faff9
>>>>>>>> --- a/mm/mmu_gather.c
>>>>>>>> +++ b/mm/mmu_gather.c
>>>>>>>> @@ -9,11 +9,303 @@
>>>>>>>>      #include <linux/smp.h>
>>>>>>>>      #include <linux/swap.h>
>>>>>>>>      #include <linux/rmap.h>
>>>>>>>> +#include <linux/oom.h>
>>>>>>>>
>>>>>>>>      #include <asm/pgalloc.h>
>>>>>>>>      #include <asm/tlb.h>
>>>>>>>>
>>>>>>>>      #ifndef CONFIG_MMU_GATHER_NO_GATHER
>>>>>>>> +/*
>>>>>>>> + * The swp_entry asynchronous release mechanism for multiple processes with
>>>>>>>> + * independent mm exiting simultaneously.
>>>>>>>> + *
>>>>>>>> + * During the multiple exiting processes releasing their own mm simultaneously,
>>>>>>>> + * the swap entries in the exiting processes are handled by isolating, caching
>>>>>>>> + * and handing over to an asynchronous kworker to complete the release.
>>>>>>>> + *
>>>>>>>> + * The conditions for the exiting process entering the swp_entry asynchronous
>>>>>>>> + * release path:
>>>>>>>> + * 1. The exiting process's MM_SWAPENTS count is >= SWAP_CLUSTER_MAX, avoiding
>>>>>>>> + *    to alloc struct mmu_swap_gather frequently.
>>>>>>>> + * 2. The number of exiting processes is >= NR_MIN_EXITING_PROCESSES.
>>>>>>> Hi Zhiguo,
>>>>>>>
>>>>>>> I'm curious about the significance of NR_MIN_EXITING_PROCESSES. It seems that
>>>>>>> batched swap entry freeing, even with one process, could be a
>>>>>>> bottleneck for a single
>>>>>>> process based on the data from this patch:
>>>>>>>
>>>>>>> mm: attempt to batch free swap entries for zap_pte_range()
>>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/commit/?h=mm-stable&id=bea67dcc5ee
>>>>>>> "munmap bandwidth becomes 3X faster."
>>>>>>>
>>>>>>> So what would happen if you simply set NR_MIN_EXITING_PROCESSES to 1?
>>>>>> Hi Barry,
>>>>>>
>>>>>> Thanks for your comments.
>>>>>>
>>>>>> The reason for NR_MIN_EXITING_PROCESSES = 2 is that previously we
>>>>>> conducted the multiple android apps continuous startup performance
>>>>>> test on the case of NR_MIN_EXITING_PROCESSES = 1, and the results
>>>>>> showed that the startup time had deteriorated slightly. However,
>>>>>> the patch's logic in this test was different from the one I submitted
>>>>>> to the community, and it may be due to some other issues with the
>>>>>> previous old patch.
>>>>>>
>>>>>> However, we have conducted relevant memory performance tests on this
>>>>>> patches submitted to the community (NR_MIN_EXITING_PROCESSES=2), and
>>>>>> the results are better than before the modification. The patches have
>>>>>> been used on multiple projects.
>>>>>> For example:
>>>>>> Test the time consumption and subjective fluency experience of
>>>>>> launching 30 android apps continuously for two rounds.
>>>>>> Test machine: RAM 16GB
>>>>>> |        | time(s) | Frame-droped rate(%) |
>>>>>> | before | 230.76  |         0.54         |
>>>>>> | after  | 225.23  |         0.74         |
>>>>>> We can see that the patch has been optimized 5.53s for startup time and
>>>>>> 0.2% frame-droped rate and better subjective smoothness experience.
>>>>>>
>>>>>> Perhaps the patches submitted to the community has also improved the
>>>>>> multiple android apps continuous startup performance in the case
>>>>>> of NR_MIN_EXITING_PROCESSES=1. If necessary, I will conduct relevant
>>>>>> tests to verify this situation in the future.
>>>> Thanks Barry for your valuable suggestions.
>>>>> Using a fixed value like 2 feels more like a workaround than a solid solution.
>>>>> It would be better if we could eliminate this hack.
>>>> Ok, I will conduct more tests for tring to solve this parameter issue.
>>>>> Additionally, this type of asynchronous reclamation might struggle to scale
>>>>> effectively, particularly on NUMA systems with many CPU cores.
>>>>>
>>>>> Many kernel threads are per-node, like kswapd. For instance, if we have 100
>>>>> threads running on 100 CPUs executing zap_pte_range(), your approach, which
>>>>> relies on a single async thread to reclaim swap entries, might lead to
>>>>> performance
>>>>> regressions.
>>>>>
>>>>> We might need to consider a more adaptable approach that can evaluate
>>>>> the machine's
>>>>> topology and dynamically determine the appropriate number of async
>>>>> threads, rather
>>>>> than hard-coding it to just one. Otherwise, there could be ongoing
>>>>> concerns about
>>>>> whether this solution is truly applicable to all systems.
>>>> Can we dynamically determine the number of asynchronous kworkers to be
>>>> created based on the number of exiting processes at a certain moment,
>>>> for example, every 8 exiting processes corresponds to one asynchronous
>>>> kworker?
>>>>
>>>> | The number of exiting processes | The number of asynchronous kworkers |
>>>> |          [1, 8]                 | 1                    |
>>>> |          [9, 16]                | 2                    |
>>>> |          ...                    | ...                   |
>>>> |      [8*N+1, 8*(N+1)]           | N+1                   |
>>>> N >= 0
>>> I'm not entirely sure. Another potential approach could be to use a
>>> dedicated thread
>>> for each NUMA node, but we would need data to confirm if this is the
>>> right solution.
>> I feel that this may be a feasible async approach, where the async
>> kworker of each NUMA node is responsible for maintaining and releasing
>> swap entries mapped by the exiting processes executing on the
>> corresponding local CPUs. Not sure how many CPUs each NUMA node can
>> contain? However, I currently do not have a NUMA environment for this
>> testing verification.
> Yes, I get it. As someone working on phones, we don’t have NUMA machines,
> but our code still impacts them. That’s what makes things so tricky:-)
>
>>>>> Alternatively, we might be able to develop a method to speed up
>>>>> batched freeing in a
>>>>> synchronous manner after collecting the mmu_swap_batch. mmu_gather isn't
>>>>> async, but it can still speed up tlb flush, right?
>>>> The synchronous manner may have some optimization effect, but it seems
>>>> that the optimization effect on the CPUs load occupied by multiple
>>>> exiting processes is not significant. In addition, David stated in the
>>>> latest comment that swap entry seems unrelated to tlb.
>>>>> For phones with just 8 CPU cores, I definitely like your patch.
>>>>> However, since we're
>>>>> aiming for something which can affect all systems, the situation might be more
>>>>> complex.
>>>> Yes, this pacth still needs further improvement to adapt to all systems.
>>> If we want to keep things simple, another approach might be to profile the
>>> hotspots within swap_free_nr(), identifying the most time-consuming parts,
>>> and then optimize them based on the data we collect from your
>>> mmu_swap_batch. Then we don't have to make things async. Have you ever
>>> profiled the hotspots?
>> The hotspots seems to have been implemented in the __swap_entries_free()
>> in the patches you submitted, releasing continuous swap entries at once.
>> Moreover, there may be duplication between the mmu_swap_batch and
>> swapsots_cache.🙂
> I assume you're referring to how __swap_entries_free() in the patch "mm:
> attempt to batch free swap entries for zap_pte_range()" addresses the
> hotspots, potentially eliminating the swap entry release as a bottleneck once
> we have mTHP. However, for platforms that don’t use mTHP, is this still a
> significant issue?
Maybe.
>
> Have you ever profiled the code and identified the exact bottleneck? If so,
> we can brainstorm ideas to address it together. Honestly, I wasn’t sure which
> specific line was causing swap_free to be so slow, but __swap_entries_free()
> significantly improves performance for the mTHP case.
I did not find any specific interface that was the bottleneck affecting
performance in releasing the swap entry path. When releasing a swap
entry, it is also necessary to release the corresponding compressed
zram obj. My understanding is that the path for releasing the swap is
relatively long and is released one by one, which leads to a relatively
long time consumption. Additionally, if the path of releasing zram obj
also support mTHP logic, performance may be further improved.
>
>>>>>>>> + *
>>>>>>>> + * Since the time for determining the number of exiting processes is dynamic,
>>>>>>>> + * the exiting process may start to enter the swp_entry asynchronous release
>>>>>>>> + * at the beginning or middle stage of the exiting process's swp_entry release
>>>>>>>> + * path.
>>>>>>>> + *
>>>>>>>> + * Once an exiting process enters the swp_entry asynchronous release, all remaining
>>>>>>>> + * swap entries in this exiting process need to be fully released by asynchronous
>>>>>>>> + * kworker theoretically.
>>>>>>> Freeing a slot can indeed release memory from `zRAM`, potentially returning
>>>>>>> it to the system for allocation. Your patch frees swap slots asynchronously;
>>>>>>> I assume this doesn’t slow down the memory freeing process for `zRAM`, or
>>>>>>> could it even slow down the freeing of `zRAM` memory? Freeing compressed
>>>>>>> memory might not be as crucial compared to freeing uncompressed memory with
>>>>>>> present PTEs?
>>>>>> Yes, freeing uncompressed memory with present PTEs is more important
>>>>>> compared to freeing compressed 'zRAM' memory.
>>>>>>
>>>>>> I guess that the multiple exiting processes releasing swap entries
>>>>>> simultaneously may result in the swap_info->lock competition pressure
>>>>>> in swapcache_free_entries(), affecting the efficiency of releasing swap
>>>>>> entries. However, if the asynchronous kworker is used, this issue can
>>>>>> be avoided, and perhaps the improvement is minor.
>>>>>>
>>>>>> The freeing of zRAM memory does not slow down. We have observed traces
>>>>>> in the camera startup scene and found that the asynchronous kworker
>>>>>> can release all swap entries before entering the camera preview.
>>>>>> Compared to not using the asynchronous kworker, the exiting processes
>>>>>> completed after entering the camera preview.
>>>>>>>> + *
>>>>>>>> + * The function of the swp_entry asynchronous release:
>>>>>>>> + * 1. Alleviate the high system cpu load caused by multiple exiting processes
>>>>>>>> + *    running simultaneously.
>>>>>>>> + * 2. Reduce lock competition in swap entry free path by an asynchronous kworker
>>>>>>>> + *    instead of multiple exiting processes parallel execution.
>>>>>>>> + * 3. Release pte_present memory occupied by exiting processes more efficiently.
>>>>>>>> + */
>>>>>>>> +
>>>>>>>> +/*
>>>>>>>> + * The min number of exiting processes required for swp_entry asynchronous release
>>>>>>>> + */
>>>>>>>> +#define NR_MIN_EXITING_PROCESSES 2
>>>>>>>> +
>>>>>>>> +static atomic_t nr_exiting_processes = ATOMIC_INIT(0);
>>>>>>>> +static struct kmem_cache *swap_gather_cachep;
>>>>>>>> +static struct workqueue_struct *swapfree_wq;
>>>>>>>> +static DEFINE_STATIC_KEY_TRUE(tlb_swap_asyncfree_disabled);
>>>>>>>> +
>>>>>>>> +static int __init tlb_swap_async_free_setup(void)
>>>>>>>> +{
>>>>>>>> +       swapfree_wq = alloc_workqueue("smfree_wq", WQ_UNBOUND |
>>>>>>>> +               WQ_HIGHPRI | WQ_MEM_RECLAIM, 1);
>>>>>>>> +       if (!swapfree_wq)
>>>>>>>> +               goto fail;
>>>>>>>> +
>>>>>>>> +       swap_gather_cachep = kmem_cache_create("swap_gather",
>>>>>>>> +               sizeof(struct mmu_swap_gather),
>>>>>>>> +               0, SLAB_TYPESAFE_BY_RCU | SLAB_PANIC | SLAB_ACCOUNT,
>>>>>>>> +               NULL);
>>>>>>>> +       if (!swap_gather_cachep)
>>>>>>>> +               goto kcache_fail;
>>>>>>>> +
>>>>>>>> +       static_branch_disable(&tlb_swap_asyncfree_disabled);
>>>>>>>> +       return 0;
>>>>>>>> +
>>>>>>>> +kcache_fail:
>>>>>>>> +       destroy_workqueue(swapfree_wq);
>>>>>>>> +fail:
>>>>>>>> +       return -ENOMEM;
>>>>>>>> +}
>>>>>>>> +postcore_initcall(tlb_swap_async_free_setup);
>>>>>>>> +
>>>>>>>> +static void __tlb_swap_gather_free(struct mmu_swap_gather *swap_gather)
>>>>>>>> +{
>>>>>>>> +       struct mmu_swap_batch *swap_batch, *next;
>>>>>>>> +
>>>>>>>> +       for (swap_batch = swap_gather->local.next; swap_batch; swap_batch = next) {
>>>>>>>> +               next = swap_batch->next;
>>>>>>>> +               free_page((unsigned long)swap_batch);
>>>>>>>> +       }
>>>>>>>> +       swap_gather->local.next = NULL;
>>>>>>>> +       kmem_cache_free(swap_gather_cachep, swap_gather);
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +static void tlb_swap_async_free_work(struct work_struct *w)
>>>>>>>> +{
>>>>>>>> +       int i, nr_multi, nr_free;
>>>>>>>> +       swp_entry_t start_entry;
>>>>>>>> +       struct mmu_swap_batch *swap_batch;
>>>>>>>> +       struct mmu_swap_gather *swap_gather = container_of(w,
>>>>>>>> +               struct mmu_swap_gather, free_work);
>>>>>>>> +
>>>>>>>> +       /* Release swap entries cached in mmu_swap_batch. */
>>>>>>>> +       for (swap_batch = &swap_gather->local; swap_batch && swap_batch->nr;
>>>>>>>> +           swap_batch = swap_batch->next) {
>>>>>>>> +               nr_free = 0;
>>>>>>>> +               for (i = 0; i < swap_batch->nr; i++) {
>>>>>>>> +                       if (unlikely(encoded_swpentry_flags(swap_batch->encoded_entrys[i]) &
>>>>>>>> +                           ENCODED_SWPENTRY_BIT_NR_ENTRYS_NEXT)) {
>>>>>>>> +                               start_entry = encoded_swpentry_data(swap_batch->encoded_entrys[i]);
>>>>>>>> +                               nr_multi = encoded_nr_swpentrys(swap_batch->encoded_entrys[++i]);
>>>>>>>> +                               free_swap_and_cache_nr(start_entry, nr_multi);
>>>>>>>> +                               nr_free += 2;
>>>>>>>> +                       } else {
>>>>>>>> +                               start_entry = encoded_swpentry_data(swap_batch->encoded_entrys[i]);
>>>>>>>> +                               free_swap_and_cache_nr(start_entry, 1);
>>>>>>>> +                               nr_free++;
>>>>>>>> +                       }
>>>>>>>> +               }
>>>>>>>> +               swap_batch->nr -= nr_free;
>>>>>>>> +               VM_BUG_ON(swap_batch->nr);
>>>>>>>> +       }
>>>>>>>> +       __tlb_swap_gather_free(swap_gather);
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +static bool __tlb_swap_gather_mmu_check(struct mmu_gather *tlb)
>>>>>>>> +{
>>>>>>>> +       /*
>>>>>>>> +        * Only the exiting processes with the MM_SWAPENTS counter >=
>>>>>>>> +        * SWAP_CLUSTER_MAX have the opportunity to release their swap
>>>>>>>> +        * entries by asynchronous kworker.
>>>>>>>> +        */
>>>>>>>> +       if (!task_is_dying() ||
>>>>>>>> +           get_mm_counter(tlb->mm, MM_SWAPENTS) < SWAP_CLUSTER_MAX)
>>>>>>>> +               return true;
>>>>>>>> +
>>>>>>>> +       atomic_inc(&nr_exiting_processes);
>>>>>>>> +       if (atomic_read(&nr_exiting_processes) < NR_MIN_EXITING_PROCESSES)
>>>>>>>> +               tlb->swp_freeable = 1;
>>>>>>>> +       else
>>>>>>>> +               tlb->swp_freeing = 1;
>>>>>>>> +
>>>>>>>> +       return false;
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +/**
>>>>>>>> + * __tlb_swap_gather_init - Initialize an mmu_swap_gather structure
>>>>>>>> + * for swp_entry tear-down.
>>>>>>>> + * @tlb: the mmu_swap_gather structure belongs to tlb
>>>>>>>> + */
>>>>>>>> +static bool __tlb_swap_gather_init(struct mmu_gather *tlb)
>>>>>>>> +{
>>>>>>>> +       tlb->swp = kmem_cache_alloc(swap_gather_cachep, GFP_ATOMIC | GFP_NOWAIT);
>>>>>>>> +       if (unlikely(!tlb->swp))
>>>>>>>> +               return false;
>>>>>>>> +
>>>>>>>> +       tlb->swp->local.next  = NULL;
>>>>>>>> +       tlb->swp->local.nr    = 0;
>>>>>>>> +       tlb->swp->local.max   = ARRAY_SIZE(tlb->swp->__encoded_entrys);
>>>>>>>> +
>>>>>>>> +       tlb->swp->active      = &tlb->swp->local;
>>>>>>>> +       tlb->swp->batch_count = 0;
>>>>>>>> +
>>>>>>>> +       INIT_WORK(&tlb->swp->free_work, tlb_swap_async_free_work);
>>>>>>>> +       return true;
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +static void __tlb_swap_gather_mmu(struct mmu_gather *tlb)
>>>>>>>> +{
>>>>>>>> +       if (static_branch_unlikely(&tlb_swap_asyncfree_disabled))
>>>>>>>> +               return;
>>>>>>>> +
>>>>>>>> +       tlb->swp = NULL;
>>>>>>>> +       tlb->swp_freeable = 0;
>>>>>>>> +       tlb->swp_freeing = 0;
>>>>>>>> +       tlb->swp_disable = 0;
>>>>>>>> +
>>>>>>>> +       if (__tlb_swap_gather_mmu_check(tlb))
>>>>>>>> +               return;
>>>>>>>> +
>>>>>>>> +       /*
>>>>>>>> +        * If the exiting process meets the conditions of
>>>>>>>> +        * swp_entry asynchronous release, an mmu_swap_gather
>>>>>>>> +        * structure will be initialized.
>>>>>>>> +        */
>>>>>>>> +       if (tlb->swp_freeing)
>>>>>>>> +               __tlb_swap_gather_init(tlb);
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +static void __tlb_swap_gather_queuework(struct mmu_gather *tlb, bool finish)
>>>>>>>> +{
>>>>>>>> +       queue_work(swapfree_wq, &tlb->swp->free_work);
>>>>>>>> +       tlb->swp = NULL;
>>>>>>>> +       if (!finish)
>>>>>>>> +               __tlb_swap_gather_init(tlb);
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +static bool __tlb_swap_next_batch(struct mmu_gather *tlb)
>>>>>>>> +{
>>>>>>>> +       struct mmu_swap_batch *swap_batch;
>>>>>>>> +
>>>>>>>> +       if (tlb->swp->batch_count == MAX_SWAP_GATHER_BATCH_COUNT)
>>>>>>>> +               goto free;
>>>>>>>> +
>>>>>>>> +       swap_batch = (void *)__get_free_page(GFP_ATOMIC | GFP_NOWAIT);
>>>>>>>> +       if (unlikely(!swap_batch))
>>>>>>>> +               goto free;
>>>>>>>> +
>>>>>>>> +       swap_batch->next = NULL;
>>>>>>>> +       swap_batch->nr   = 0;
>>>>>>>> +       swap_batch->max  = MAX_SWAP_GATHER_BATCH;
>>>>>>>> +
>>>>>>>> +       tlb->swp->active->next = swap_batch;
>>>>>>>> +       tlb->swp->active = swap_batch;
>>>>>>>> +       tlb->swp->batch_count++;
>>>>>>>> +       return true;
>>>>>>>> +free:
>>>>>>>> +       /* batch move to wq */
>>>>>>>> +       __tlb_swap_gather_queuework(tlb, false);
>>>>>>>> +       return false;
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +/**
>>>>>>>> + * __tlb_remove_swap_entries - the swap entries in exiting process are
>>>>>>>> + * isolated, batch cached in struct mmu_swap_batch.
>>>>>>>> + * @tlb: the current mmu_gather
>>>>>>>> + * @entry: swp_entry to be isolated and cached
>>>>>>>> + * @nr: the number of consecutive entries starting from entry parameter.
>>>>>>>> + */
>>>>>>>> +bool __tlb_remove_swap_entries(struct mmu_gather *tlb,
>>>>>>>> +                            swp_entry_t entry, int nr)
>>>>>>>> +{
>>>>>>>> +       struct mmu_swap_batch *swap_batch;
>>>>>>>> +       unsigned long flags = 0;
>>>>>>>> +       bool ret = false;
>>>>>>>> +
>>>>>>>> +       if (tlb->swp_disable)
>>>>>>>> +               return ret;
>>>>>>>> +
>>>>>>>> +       if (!tlb->swp_freeable && !tlb->swp_freeing)
>>>>>>>> +               return ret;
>>>>>>>> +
>>>>>>>> +       if (tlb->swp_freeable) {
>>>>>>>> +               if (atomic_read(&nr_exiting_processes) <
>>>>>>>> +                   NR_MIN_EXITING_PROCESSES)
>>>>>>>> +                       return ret;
>>>>>>>> +               /*
>>>>>>>> +                * If the current number of exiting processes
>>>>>>>> +                * is >= NR_MIN_EXITING_PROCESSES, the exiting
>>>>>>>> +                * process with swp_freeable state will enter
>>>>>>>> +                * swp_freeing state to start releasing its
>>>>>>>> +                * remaining swap entries by the asynchronous
>>>>>>>> +                * kworker.
>>>>>>>> +                */
>>>>>>>> +               tlb->swp_freeable = 0;
>>>>>>>> +               tlb->swp_freeing = 1;
>>>>>>>> +       }
>>>>>>>> +
>>>>>>>> +       VM_BUG_ON(tlb->swp_freeable || !tlb->swp_freeing);
>>>>>>>> +       if (!tlb->swp && !__tlb_swap_gather_init(tlb))
>>>>>>>> +               return ret;
>>>>>>>> +
>>>>>>>> +       swap_batch = tlb->swp->active;
>>>>>>>> +       if (unlikely(swap_batch->nr >= swap_batch->max - 1)) {
>>>>>>>> +               __tlb_swap_gather_queuework(tlb, false);
>>>>>>>> +               return ret;
>>>>>>>> +       }
>>>>>>>> +
>>>>>>>> +       if (likely(nr == 1)) {
>>>>>>>> +               swap_batch->encoded_entrys[swap_batch->nr++] = encode_swpentry(entry, flags);
>>>>>>>> +       } else {
>>>>>>>> +               flags |= ENCODED_SWPENTRY_BIT_NR_ENTRYS_NEXT;
>>>>>>>> +               swap_batch->encoded_entrys[swap_batch->nr++] = encode_swpentry(entry, flags);
>>>>>>>> +               swap_batch->encoded_entrys[swap_batch->nr++] = encode_nr_swpentrys(nr);
>>>>>>>> +       }
>>>>>>>> +       ret = true;
>>>>>>>> +
>>>>>>>> +       if (swap_batch->nr >= swap_batch->max - 1) {
>>>>>>>> +               if (!__tlb_swap_next_batch(tlb))
>>>>>>>> +                       goto exit;
>>>>>>>> +               swap_batch = tlb->swp->active;
>>>>>>>> +       }
>>>>>>>> +       VM_BUG_ON(swap_batch->nr > swap_batch->max - 1);
>>>>>>>> +exit:
>>>>>>>> +       return ret;
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +static void __tlb_batch_swap_finish(struct mmu_gather *tlb)
>>>>>>>> +{
>>>>>>>> +       if (tlb->swp_disable)
>>>>>>>> +               return;
>>>>>>>> +
>>>>>>>> +       if (!tlb->swp_freeable && !tlb->swp_freeing)
>>>>>>>> +               return;
>>>>>>>> +
>>>>>>>> +       if (tlb->swp_freeable) {
>>>>>>>> +               tlb->swp_freeable = 0;
>>>>>>>> +               VM_BUG_ON(tlb->swp_freeing);
>>>>>>>> +               goto exit;
>>>>>>>> +       }
>>>>>>>> +       tlb->swp_freeing = 0;
>>>>>>>> +       if (unlikely(!tlb->swp))
>>>>>>>> +               goto exit;
>>>>>>>> +
>>>>>>>> +       __tlb_swap_gather_queuework(tlb, true);
>>>>>>>> +exit:
>>>>>>>> +       atomic_dec(&nr_exiting_processes);
>>>>>>>> +}
>>>>>>>>
>>>>>>>>      static bool tlb_next_batch(struct mmu_gather *tlb)
>>>>>>>>      {
>>>>>>>> @@ -386,6 +678,9 @@ static void __tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm,
>>>>>>>>             tlb->local.max  = ARRAY_SIZE(tlb->__pages);
>>>>>>>>             tlb->active     = &tlb->local;
>>>>>>>>             tlb->batch_count = 0;
>>>>>>>> +
>>>>>>>> +       tlb->swp_disable = 1;
>>>>>>>> +       __tlb_swap_gather_mmu(tlb);
>>>>>>>>      #endif
>>>>>>>>             tlb->delayed_rmap = 0;
>>>>>>>>
>>>>>>>> @@ -466,6 +761,7 @@ void tlb_finish_mmu(struct mmu_gather *tlb)
>>>>>>>>
>>>>>>>>      #ifndef CONFIG_MMU_GATHER_NO_GATHER
>>>>>>>>             tlb_batch_list_free(tlb);
>>>>>>>> +       __tlb_batch_swap_finish(tlb);
>>>>>>>>      #endif
>>>>>>>>             dec_tlb_flush_pending(tlb->mm);
>>>>>>>>      }
>>>>>>>> --
>>>>>>>> 2.39.0
>>>>>>>>
>>>>> Thanks
>>>>> Barry
>>>> Thanks
>>>> Zhiguo
>>>>
>>> Thanks
>>> Barry
> Thanks
> Barry
Thanks
Zhiguo



