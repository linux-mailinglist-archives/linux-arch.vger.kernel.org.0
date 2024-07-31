Return-Path: <linux-arch+bounces-5776-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4663F943141
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jul 2024 15:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBFE81F2122F
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jul 2024 13:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 007881B0114;
	Wed, 31 Jul 2024 13:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="f2DoW9dG"
X-Original-To: linux-arch@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2066.outbound.protection.outlook.com [40.107.255.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5371AD40D;
	Wed, 31 Jul 2024 13:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722433676; cv=fail; b=l5MGPcvDvvig47bXGU/f34DbKGH2D3hu/ABwlIK1MfTeBqOXmBiipRcCuM7cT0aROUObDOOXtxjezE0aMxo1ooiLLOQ4G/9+hYi5/j1c/OFKBPUG/G6KaDhGAXnN/ago0a5RG+G2RmDG2JNcmHvs4JbbdbsTSgUDrIWM54P/GFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722433676; c=relaxed/simple;
	bh=Cbvjhg6kIy01pJzSOYRZiKg7+76EUdGMCgQ9uHBRkUU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eRSmBS1f+uv5KPzuyOaoxhOR3QyJxhnxPmVVwyTNnU3KcFLDHbY3nMJoAZJPwJBv3kX7na85G7TdvTjFh8ik2UdDusO+4dCrCXLPE6X1pkQwA19WDcsY8xZscbPkQ5UVoHe2f7uANWrG/RzKRfO69BY2Br6WVuWbZPAeujuZTQM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=f2DoW9dG; arc=fail smtp.client-ip=40.107.255.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=roMWDHWaq8p+Ekz/mPpD58djaP2FmppEVpVT0GW3616khaz8rzIloGZwLCYYovEQu98m3q9Jf81aUI3D0/npXAlBLKj31HU7WoK1nAqC/v9WE+8ZHvuNIIssgw3cpAFAioOfUrGI0uNUeP73O5mLSpLes4NkkK9W0IiMDPyz1szA2VidHthew2TaAZIuvZdApOAGdneqwnlvWX2k63bn+gX9KDGt36aq0F8RcZuDIHMkhWglQE+93a4i8g85jpVf/QGdDJi+1TmUDbwK27mEEWnsONZgO1jJj4QxWqMIL0sM4z1Kyd0Et90Wz2bWNlLb8HvPrtUUHZ1x3BZxmPqJkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kA/C094rUWezWaL7UZkxusvqmDDV1m2UEA+xY06SfDY=;
 b=gXTWxbd5+NH0EUuNvP5yQsa26AsF+eqzEIkZYO1xRY3RmToescHGBCM7TptIW6SaH2chq9LDAEOkiOXUo58GfklXD/Z1jigc6RvkmAw0KFGAgjaB/QiD0PN+1d2VuiPSk9WeLT3KfWVVAKpx3LCy+76NuIhLOHfUq7aGpIcHQB/L0jW/77wQ+Omacx6tztQyTwX0Rde6RWaOwcuGyNESgqBmNMjRfLIdOuEJaRSV+LHLL9AhnLzUxEG4ihmhpLVgqvdgRMwhXhh1BokKRfTYxUNdgIyM92OW/2FFDV44Vl8Difd8Gm1rNF23AYHiZvNHyja9pS4X5HknFrhpylnO/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kA/C094rUWezWaL7UZkxusvqmDDV1m2UEA+xY06SfDY=;
 b=f2DoW9dGaxBQ442kW/VA9wPqeOOU66OiOl4L72eFDJDC9HA8rOSJ0JQoXtoYSc4Ij3ZAg8LJlUZAmbKEKt/nC01puwls46SjtGZ6NdQuXz1tgNrbM8fV8BVks0V9yoTk0q1WOHk+lWPOpLRBrSf//LhFoV+1bX+mYo7Sznlpu9cmVcqWo3yP3t0wmrtE9xBtK9Ser/qHg8gc6xKUPGHWgZme71z3irDDGQjOZotvOf2b+PU7fSONAcIBA4YV4jCVc9+JVP/hM5YgXQM0JqU/heMXL2T9wwm48h/sofnbb6B18cbftbs8oWDn7HVfCvD9471XgGKQVUgsVo35Jh2p7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by SEYPR06MB6904.apcprd06.prod.outlook.com (2603:1096:101:1e1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Wed, 31 Jul
 2024 13:47:50 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed%3]) with mapi id 15.20.7828.016; Wed, 31 Jul 2024
 13:47:50 +0000
Message-ID: <dbcd8d48-3095-4ed1-88fb-1de463e8f593@vivo.com>
Date: Wed, 31 Jul 2024 21:47:45 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] mm: tlb: add tlb swap entries batch async release
To: Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Will Deacon <will@kernel.org>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Nicholas Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Linux-Arch <linux-arch@vger.kernel.org>, cgroups@vger.kernel.org,
 Barry Song <21cnbao@gmail.com>
Cc: opensource.kernel@vivo.com
References: <20240730114426.511-1-justinjiang@vivo.com>
 <20240730114426.511-3-justinjiang@vivo.com>
 <b8fad35b-ba72-44ef-b89b-5333dd457ca7@app.fastmail.com>
From: zhiguojiang <justinjiang@vivo.com>
In-Reply-To: <b8fad35b-ba72-44ef-b89b-5333dd457ca7@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0013.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::12) To JH0PR06MB6849.apcprd06.prod.outlook.com
 (2603:1096:990:47::12)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|SEYPR06MB6904:EE_
X-MS-Office365-Filtering-Correlation-Id: a9cce5c7-421e-4655-ca5f-08dcb1675e5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020|43062017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YmdUZ0JVdzl2MXpEK1BwNFhaaFR3dEpPSTBPdjJnWVZyTjdHQk9zZVQrVUdY?=
 =?utf-8?B?dHlSY2phVUMwa1lIK25UdERhRDMxb3NIWUlQSEhXUUZGeGVSenlGTEZJdFp4?=
 =?utf-8?B?Wmc2eTNCcVBoMDZJRzZYZ3JUd3pVbXRPVDJIVi9tVmEyVEZLbU0rMWFQWkJD?=
 =?utf-8?B?VkNxRS9INGt0YXphcExINWgxck5mNzRCOGd1MmFUekdSWkdiOEU2dTYzdzZ5?=
 =?utf-8?B?ZnBqM2tRRUVZNEtXQW1EcG1rTmpoclp3aWd0cHV5OStsQWx0RVhWZjZtVXNY?=
 =?utf-8?B?SzdiZUk4VEhiaEluYUpBTWsxVmlkeHZvS0pOdmRlWjdjbVp3RnBqYTFnM3cv?=
 =?utf-8?B?MExxdWRaSHpqcW81WXQ5YmlJWlRmVEM3a091djFVZGloSzd6ZDBYbXBqaTNa?=
 =?utf-8?B?cHU3UFNRWTZpYUVBQVhBUXBPN1JTU2t5TEJxRmhRYTI2TkhOWnFkK2pjell1?=
 =?utf-8?B?Q1ZBRHJHUFd2U3NobHJnUkJVNUtNbHBCU2V5dXIrclFCWDNqOFQzZjdkd1Y4?=
 =?utf-8?B?MmtkZ0lWMlBuU01aYTZlRklEVEw1Yzc1QzJoUTBrb1M0SXl0OS9KeHVkUGk2?=
 =?utf-8?B?K3pobkhpclp3WHRqajJmMDM1WmRtK0VML0Fzb2FTL01mNzNjL0JqSzhsK0ly?=
 =?utf-8?B?Szl5blJQamJETU5abDBBRkZnd3dXYXViQURwVTBFTGt1andIaGVUSDhZd28w?=
 =?utf-8?B?a2pLVWMrb0ZicnV3RVVRWCs1bVovRmhPRFFDZURqNjhYYjNVREJXL00rVEVz?=
 =?utf-8?B?RXVCWGhnazF6WTgrWUJyYlR2Z1IyUThOYUxzWVgyWlVMTkVCT2M4V1FVb1p1?=
 =?utf-8?B?blRtQ21yOTVQZzNtRTM2Uk9OM090cEpBTVlqczFlS1hJTWdlNFFsa2w3Unha?=
 =?utf-8?B?YnhSVnpJOEpSMGJQUW4wUk00K0c0dkN5SnhrSHZGUkxsYkVXd1pKcmMxSmlX?=
 =?utf-8?B?bXd0YklBcVJueGJEVUQ1WTludnNvNURTbzFCUHpjcWppb2xoMlVKTngzQXVq?=
 =?utf-8?B?NUJiS1JrTkQwTkl1VTlkdkFvNWdlVlh5VXFpcVczMytjMGRZUjEzSE90M1Vw?=
 =?utf-8?B?ejlrZytqOHVHV2Z1S0IwcHUzQWRGY1pQVGtiR2pFdUk2YnpkNUtjMlZXRlNu?=
 =?utf-8?B?dHpxWlQ2Z09jdE5naW9kd0ZFbkJoVy9QWjUyVlIvOEt6ampIdGF6VGdKOWtI?=
 =?utf-8?B?NUJxMExEUkVrSUM4eXJ0emtGS080TnRuNzRvM0JEZ0dVQWVmcjVkWjhPUVJZ?=
 =?utf-8?B?S0R2US9lY3BHUms2TE83UUNNMVVITWdYVjd4MjdKMXhsb1pFcEZFYVUvUXBN?=
 =?utf-8?B?dDcrYTRhcE9hOWUzZElGMlcvYjdaNE0yYTcwN1d1T2Y1VlF3RDR4c1Z3WU83?=
 =?utf-8?B?OUZOYjZReDFlZzFWc25zRDN6OHA4aVMveHNWYm1QMGZNR0NDS0ZVSVB2SStv?=
 =?utf-8?B?U0x5U3hwbTRiY2pTdUZic1YxMGZnUW1WRXhsbHBUd3gvNllYRytYMDlTMzdG?=
 =?utf-8?B?a2FpTTNpaTJFTmhuVnc5MTlrc01tY3pyU2tsWnNqMkpUMGswby9NQ0QwWUND?=
 =?utf-8?B?eUh0QmJWZnhNRk5nQ2lETWVJLzY2RVltWHJINDFrV1VzMy9kVHJIYmduYUd2?=
 =?utf-8?B?TUI3WGUwL0FMMjhvYXJ4OWJyNXJCMW00WlNmbWttc2tPbk40ZTZzVVhZMkJP?=
 =?utf-8?B?bjNsQXBUMUpkQlNPb29OaGprblBpQU42NytkbW1lb0hScnVJdWVIQi9na3g4?=
 =?utf-8?B?RHUrSTNUWlNCQVo3SVZ5OFVLR0tRbWtpeXA3UFJtakpDQnBuYy9nRVAvZUgw?=
 =?utf-8?Q?vE1EwDUxcXKTNRzUj6Q7gygqvEDfaMBT6GBM0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(43062017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eCsyWlAwRnZlc1J1dTVMbUl3MnYxb2RpK0ZuNHhxQnhTZy9lZ3B5VEJpOC9G?=
 =?utf-8?B?NExQSG9LYnZxaENpM21sa3ZXVDdLbVFQWXQ2QlhUcGhNUzFQOHdkb3ZrWTZz?=
 =?utf-8?B?Y01SZFd6VUc3YTRMSTlCRUZLSVhLQ2ZXVW5yVk9BejJPUSt2ZjJEL29YRndz?=
 =?utf-8?B?cUxrK0d6L2lTT2VBRnBpcEJVN0JNbW0zb0xDZDZsaFZqQW9SN2hhcUt0d0dj?=
 =?utf-8?B?YWVRVWl6QUcwaHhhaDlmVTM4VXZkRG1oWThBaXFKT2RPWldCOVJoZGR6eVND?=
 =?utf-8?B?TWw3YkFpdzNvT2c2UFFxUUk1aDJwU29wU0tFdkVKWlIzd24xNXFBNkZ6eVhB?=
 =?utf-8?B?cVdJaHc0c0FtczBnM0xtZ09sZ0xJQTYxVFIxZHBoRFE5cUhhMmljYkErT1B2?=
 =?utf-8?B?NngxUC9NRlZ0TXBubHlLMldxSFJ6VElURTJCTzFrV2dhTnVqSFI2YXNjOC91?=
 =?utf-8?B?MW04TDYrdjViaDNyU2pOR1dxenorYUU4Y1YyNGxtOHJqT09Uc3p1V1hPa0lr?=
 =?utf-8?B?MWVhaEM2ZzlYd1FPYVNYQXYyd3RBODlwK29naDBNSUdUNFA0WHl5ME5JN1FV?=
 =?utf-8?B?Zm55ZjF5RTJLV3VlT2pjVTZqbE1kWlZoZ0UwUUVJenI4N2VLbkhINStLY1BZ?=
 =?utf-8?B?d1dWS3hVNTJFbGJ1dHoxaDQveTBSNVdCN2s2aXZ5eVlJaG82WVZabFBnK2Vn?=
 =?utf-8?B?ckhSUXVZc2wzYUd6aUhVenF6OTBVVVYvRGVVUmtaaVdlWTRsbVVmZmdpOFRu?=
 =?utf-8?B?WTVIQU91NCtteVJMclhIR3J1WE54SCtCY2ZnYTNKY3dIVEZuZ0hpVUdyV2VG?=
 =?utf-8?B?aEJGeG04YWF5SHUyR3lvQU51TUNvNVFPWmtrcHNoSVRUUHcvSUE3SS9lMWM2?=
 =?utf-8?B?VmpiRFRzbUhOWDZsN2xxZWxMRUZPLzNxVitDN3RiL3pLM2hERHNsb1VhSUc0?=
 =?utf-8?B?TytvZWNPVm5YQ0FMV0ZnK0JaQnl4STdLMVB6bDI5R3ZlMnUyOFVLOVRVQjZn?=
 =?utf-8?B?amFhaWZtYktvWXl3SHhXZjE3eE9hYWo3dWx0cFA2ZVJTUVVaV2x0aUl2dGhS?=
 =?utf-8?B?ODVxOWw5VFRTWFVRTVF4eUVLcURiSnk5QVZTUXNHQlNFS2tEckJQeDIzSEQv?=
 =?utf-8?B?Qm1DU3kzYkNFSnhKUGo2N3dwSWdUR05rckwrMjRyN1hoRE5Fc1hsZHZobHR0?=
 =?utf-8?B?NFJxVTQxcjBoTjQyZ2Z6VzQzWkZlR3RHNFJ4S1dwWWZrc0hKRGZ2TURnSlZu?=
 =?utf-8?B?N1B3d1JuWjB2ZU5aRFZOVUV5bVh0ZXBWeVQxcHhUMTBLWS9iYnZOK2RZdUFi?=
 =?utf-8?B?SkdqMUtJOEoydGxVV2xlM3Z3YVdRaUI1S0FLSFl2dGdxTkpiVlJkQnRzZUxX?=
 =?utf-8?B?eVRrcGN4cmw3U3kzVDM1ZlJyRDRWeDdaR3Q2NGtTeHhEZGZGUWFORWJ1dXZT?=
 =?utf-8?B?QWRZQ3dpYnhpK1A0L2I4RzAvd2ZuaUxHbHM5ZmpQOU5UUzJIYlZockNLZWlB?=
 =?utf-8?B?TnV2WGZlZVA3UmUzUEpZeUtpMFVORTNPN2FoVXVRazloUmsvWXpsajQwV2Jy?=
 =?utf-8?B?WmF4RTlSL2hSbThvUFptMlZLNnNrWlByenRlbGpsVTFrY0xiRjRtN1JSOE1z?=
 =?utf-8?B?bXJRKzZ5b285VUw2WVJGRVUrRjg0RXpyYUJoaVQ1ZHc0VENPRHRKUDJDeXpK?=
 =?utf-8?B?d0MxWkNJVGhjOGtRQ05wZ1pSd0pmSk9mSzgrR1pmWldSUUNENVc2L2cweks2?=
 =?utf-8?B?VWR1VmZBVnNodEhweko3YWI4SnhOMkw1SlArTkV1OHVsQnkxUjIwa3Q2K2or?=
 =?utf-8?B?V0VHbnpMc2hxeVFzM082N2MxOGx3akVtaWE4aVNYSjVPek5sbi9HWTBkMjlJ?=
 =?utf-8?B?aC8rbSsxcEIrZmtzR082VE5vSnVUc1BrRExuM0xBODZpcU15R1FzYjQya1Er?=
 =?utf-8?B?Yjh6cldFUHZDT3FlTUsxeHBrY3Q2czkzcnRvbkNTQ2JZOU80dGVJMlhYM08z?=
 =?utf-8?B?TFMxemg2TWw4WTVyMytDNGV2TzlIQ1AvVjVQWE80QmpJUnlKc3ZrR1l0TnN2?=
 =?utf-8?B?RzZReHRDU1FQeWVSemU5dDUyd245aGRUYXhYeFRpSEI2M1pNVUFGbVNyU1B0?=
 =?utf-8?Q?VR1GIrryakg9pPvYLIakHgotB?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9cce5c7-421e-4655-ca5f-08dcb1675e5b
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 13:47:50.3489
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CBTG/XXrxRdk8JGnxaLHTrX2oaRJWSAZnkOSobOt40saZAnNaFrah/y2H9DP4yWJdXbJhNVVVQNOV7SnBTVtqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6904



在 2024/7/31 20:08, Arnd Bergmann 写道:
> On Tue, Jul 30, 2024, at 13:44, Zhiguo Jiang wrote:
>
>> +
>> +
>> +extern bool __tlb_remove_swap_entries(struct mmu_gather *tlb,
>> +		swp_entry_t entry, int nr);
>> +#else
>> +bool __tlb_remove_swap_entries(struct mmu_gather *tlb,
>> +		swp_entry_t entry, int nr)
>> +{
>> +	return false;
>> +}
>> +#endif
> To address the reported build regression, that function must
> be annotated as 'static inline'.
>
>       Arnd
Hi Arnd,

I have added 'static inline' for __tlb_remove_swap_entries() in [PATCH 
v2 3/3].
Thanks for your nice guidance.
https://lore.kernel.org/linux-mm/20240731133318.527-1-justinjiang@vivo.com/T/#t

Thanks
Zhiguo


