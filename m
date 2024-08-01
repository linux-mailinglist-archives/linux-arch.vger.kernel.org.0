Return-Path: <linux-arch+bounces-5825-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E158294447F
	for <lists+linux-arch@lfdr.de>; Thu,  1 Aug 2024 08:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F2671C223D2
	for <lists+linux-arch@lfdr.de>; Thu,  1 Aug 2024 06:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70BD158219;
	Thu,  1 Aug 2024 06:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="CbIdGmb+"
X-Original-To: linux-arch@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2074.outbound.protection.outlook.com [40.107.215.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BC413D509;
	Thu,  1 Aug 2024 06:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722493874; cv=fail; b=jI6fL9QheHl+wjoLc347b2VeEN+I/dHzTH3ogYYy85IkNUcy+mU2O1FzpXqg6uPZU7ut8CuzLr7Leazp+yTC6GCo0Mop+RluSAVxXovLeSklyu52dGPxUscIHFTqgRGS3EG9vc3lcjM7+CF9V+IMscgM4wkuMduTXWAq3KJ4ar4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722493874; c=relaxed/simple;
	bh=YcmQh9sHdHVKAqCexzsuM+tEmFogtpPlkI6xZ1aCA5s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=T25rN6zQh8haVYmQDSJvkl3QLUjdyZvaqskvzxGKN5vH+h6UXsJHeQMp/OCcwdxZ36hFpcQbo9ZX134f0KNkfWxQWheNogSY4s8mK1GXWQAl+BtbCpPVE+wzbSwFBK7D+Sib9v/4ritI3nbf8BMUtPVxsibXe774Nxxyop7K50M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=CbIdGmb+; arc=fail smtp.client-ip=40.107.215.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iAEPIQY7lBD1439mNcCrsxgbYCUIyem7C4nHMKyfjdgKN5nqDSFsdVN3hwBkec8MTCvHQyMryiohGnU6lLmbwyeNU0qHAaaalBypyYVNxPWXJUqvgurixbLnXK//iiM8qxBdsvrArZ8mdOW+wV6+PEQtczKs4OPDS8N6Cc/m0zJqsMxkGcQSg3EHc7NIhGib5f1S/T89S+q7j2GyT58Bi3o+XpoWg/Bo3SKxWtti5Ry05PfzXGQiOmOXGkrDropSgaiyEFGJqY1Q2QcKoKmp68btt3ExNjiaRQsqdFEv7Ut4ZqHGdSZb8g7NHmjHUud1xT0vtbPuu0wKDFrg5QaSMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D8cqKMQLnnyRFglbrbalmicNm+ryHolmCcaMXM429q0=;
 b=R3aUfabchMG7UypVfhnJrh0Wf0asBmzHvepWvLhoiohww/w9kpvF9HXK8c6k6JYwRi4PsBNN3kHJiphJ21wkV0q3uXO8orRRGbju+4lAk3XO0zdc+aRldjFp2Flc9PNp99YxvjVxTpLGefpVlsUJqoBr0Ir95Fjxzt8PZXPuBuDDdZ5X0/zrM4vQy6ggmTEw3Zc9KPq5Az2fpcHxycKaM68jGBP69kvgxPtRA6L9ej73efMRGhSUS4hrrvQVLK44sy65TR1fGDHRAwDObrX+Bs+7sziT9GRReBL3TJKbF5RDdLpMa9EsgU6gLWHTckSCcA8xD7eTOKKlQqUmG+qkZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D8cqKMQLnnyRFglbrbalmicNm+ryHolmCcaMXM429q0=;
 b=CbIdGmb+giMR9Wd22aKH6f3F2OiTwndUkZU9qgx0rEeUf3zDbCN1CDAoISIklFOVijzl9JhVVo+KAkUUIs4xm5jFKq6W6PvVLX8tvNF86sZILH0BBAZQrMCget3OzsFpkMH5H4qYZ1uOiwix1cYWtpxbWTmtg3mLNt5YidQ04diw0Ne7ADMsaTJqRR+9iJlaAmD8pqSYqCZ5N7yba4M1BaTcBaH90rVuK/eEeYZqm4CnDJxSNA6VG37r8fvDgpQhOwV9EibvWwYRAkbqHmV0MuplaTkJpwWRxXqAvQ+Xa3pt3p1HP6/TBiHx3Ehg/6m382JW7skm+kJn6Radfg5Jhw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by JH0PR06MB7209.apcprd06.prod.outlook.com (2603:1096:990:94::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Thu, 1 Aug
 2024 06:30:56 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed%3]) with mapi id 15.20.7828.016; Thu, 1 Aug 2024
 06:30:55 +0000
Message-ID: <dbead7ca-e9a4-4ee8-9247-4e1ba9f6695c@vivo.com>
Date: Thu, 1 Aug 2024 14:30:52 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] mm: tlb swap entries batch async release
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Will Deacon <will@kernel.org>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
 Arnd Bergmann <arnd@arndb.de>, Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 linux-arch@vger.kernel.org, cgroups@vger.kernel.org,
 Barry Song <21cnbao@gmail.com>, kernel test robot <lkp@intel.com>,
 opensource.kernel@vivo.com
References: <20240731133318.527-1-justinjiang@vivo.com>
 <20240731091715.b78969467c002fa3a120e034@linux-foundation.org>
From: zhiguojiang <justinjiang@vivo.com>
In-Reply-To: <20240731091715.b78969467c002fa3a120e034@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0160.apcprd04.prod.outlook.com (2603:1096:4::22)
 To JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|JH0PR06MB7209:EE_
X-MS-Office365-Filtering-Correlation-Id: c19b6b23-88a0-4340-387c-08dcb1f37fc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|43062017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SHpHTk1nenhMM1Nkb2hmd09GRCtqYkYyWWF3VnNLaldQQXl3QU01TTdVbDVO?=
 =?utf-8?B?dS9jY01INXhuck55QVlKL3lSRC9CR1VUNUFhQ2JrdjZiWWR5K2dRVFdBOW53?=
 =?utf-8?B?MDRIelk4aDdqS1d0UmlBcUE1MUcxVDBtS21Ub0Y0WHcyckg4Sm5NdlhEb09s?=
 =?utf-8?B?c1JyREpXMytsWjl6bkowd3FlYmpFMGJNR3NXRkw4M0hidDc4TUR5bGZLbXo1?=
 =?utf-8?B?NnFtTndTbmZpcVBMTkxVd2pWL3R5K1JOZFhHNTJpUHBNRHRUVFExOS81eFY3?=
 =?utf-8?B?YldUek5oWExHckhibVkyMkVwK3ZnMXMvZWxqSUZVanI3c0Z3ckM2bEFCdGtB?=
 =?utf-8?B?LzJ0TjFiMEZDdEhlbWEvb3QxUGZpZlR1aytvSk96OUNZZjdpUndzVzc2TFhG?=
 =?utf-8?B?aVM2Zmt1eXRYTFA4RkhJYmFDbVpvUG8xbnNEeGpaQ1BXejVhQ3BCdGVPdnZ1?=
 =?utf-8?B?STIyWTlVclVvU2plMjRkbDdFR3pGcXEyalY3TnI3MmlEWUdUdUxwbklmYWx6?=
 =?utf-8?B?S3o0QXJCNnQwZlZFaWxnbW1OSkMvM0ZWZGhGdDlsbThaTmtnYktNVWgrL2Ex?=
 =?utf-8?B?cHNzbThaaDFhejI0cTFOWUhIT0ZIUEc0VFUveDhtemdGeVZLUExPMGl2dmgy?=
 =?utf-8?B?eVVRd3JkVTc2eHpOWDVKQitpNUxFMkQ0WVdqNjlPaXN2VFpjdE9GWVRMNzlj?=
 =?utf-8?B?dXVrbm9HV2c1YUJXWS82ai9wOThyUHBvRC9aYzlySzRhQWVoeVNoNHRZR0hX?=
 =?utf-8?B?NHdtVWF3U0YxSU9HTXoxSXo5Y1ZoajFqVkU3L25lakVyeG9jNWhXaDliaWtT?=
 =?utf-8?B?NWhJd3VYTU9JUFZHRXpRT2JwYWpLdnVFbEV6SzNsRWZYc2FYVWR4alFGOTdO?=
 =?utf-8?B?bmY3Z1VuakdDc2Y0eWI3NytnMFcyWWdjaGdPQU5lN1Bhcldweit4cG1aNmh2?=
 =?utf-8?B?Y3hFTGVNU0x1S2tlSldsVGw0UFEweEVHQkVrQ3d1UGRaN0hVb2Q1VlkwRGUx?=
 =?utf-8?B?L2N1OXVEZnF2dHpXYllaczhldytLbXFoT3o3Y0RjOENQN2xnTFFtZHVQUlQv?=
 =?utf-8?B?ZXNEYVJ1b201OWQzNnVPS1k4SysrTzVCbFVsdFQ4eVhtTjRkdlRNMStNd3BS?=
 =?utf-8?B?bmVtWnR1S1hMSHJPSVAwMVN4OXJVYUU4bllCOGFTcGYycys5L3BGY25OZlV1?=
 =?utf-8?B?R2pCUGRCK2Y2cXprbEd6ZWh6MGtOb2F0RnJ3Y2I2Y2hTSitieGFIMFFFMjVh?=
 =?utf-8?B?MG8wWndZQkVLN2N1aU9DbEM4bVkxcENLTnBnc2NoTTVLODV5OEcyTXM2dmY2?=
 =?utf-8?B?clI1UWsvaElKK0xzY3k2aUJEd3Y4SWdlS2x3WkI3ZVZmY240eXc3YkZ6VUFW?=
 =?utf-8?B?elpvY2RZVmN6VVdlc3hsNjRlUm5Ib3VOM2dnUWt0NHArRVQzNVY4Ky9XY1lT?=
 =?utf-8?B?cU02R1VKVVRNNVo4eHdOVC9EQ0pCcTN0TXBJdTJqa3hlTFlpV1poVXdXbEgv?=
 =?utf-8?B?ZzU2WDZTM21zdWZ5SmZHZEFlbkhRZVNBbmpLcnh3Rml6L1lLRHVObFppMmRh?=
 =?utf-8?B?QmZEaU83RjBWYzZhcXRZS0JHU2dNa0ppbHFhaGdtV1BGQmZYdmYyN09nei9O?=
 =?utf-8?B?RDNUbll3Tml4QlNrc0diNzFZN0FaQ2YwcWE2YVl3U1M0SHVJNEk0MithUk9F?=
 =?utf-8?B?NEJKY3lVYlFwNGNoZDdrWWN3OCtqbWJza2VjK1pNNUZQOVA1d0c4MTNUdlN5?=
 =?utf-8?B?S0QyeFB4WXczNmZQSWJXM1NzNFRlMVhLaU1BZTNLZHB1UTlsY1R3aEY3ekpM?=
 =?utf-8?B?K00vSzlPWUtBUVpxbGhNZEg4aW5MeWllLzA4UzlWYWpSVU1oak5HY3NqSkg3?=
 =?utf-8?B?ZXdiVW12L2dZdXhqbmtPQnpOQmw4SXhEdDBnSDg2NldXUFE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(43062017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S0pkWVJsazBDaldXaG9QYVBLYytyWXM1cklLdDNoOHhWTnlZOXJnK3dsZ2N4?=
 =?utf-8?B?ZnZVZmxlWlY3Tml4NFBQYldlaS9XVXJmdjVrUzNWVWxtN2dGbU5hTXJCWjZB?=
 =?utf-8?B?WUMwckNnTmFCR0FGb1JuOEhBTXRXMGpnZXhYdGJYRG1EK0xmR1BDb3RIRDFs?=
 =?utf-8?B?UEJKSmVOaTJNN1VzTEs5WHJFR0hJUDNKdlFEeENaM1g3blRvZ3ZvYzJhTEEx?=
 =?utf-8?B?OE01cldOMG1NZm8wbHA0MVkrMzlSMXhkWFlib1RVbCtrN085Y2hZRndaNHVi?=
 =?utf-8?B?Skg1MDZtTDNDcStzUXdLQW9lUlRRamk1MnRvWjNTNktqWjltYmpwTHFHbytX?=
 =?utf-8?B?S0M2bGc3MHNPcDh5clUwWUVQRGdZOEQ2OURnTnU0WmhXMGV0K2FqVEJwSEp6?=
 =?utf-8?B?OFdINVlSNG5GS2tXT0tuODJkVXJ6NHlSU3N0QnpZVGp1Zm5JVFFucWFjQlJ5?=
 =?utf-8?B?WHBNN3BzUGs4a1RIcUdvSFgvaS83d1lWcmQ1RlQvM0RIbnEvNStlU2lsWjhX?=
 =?utf-8?B?VjI3YmR6aGJFajRuNy8ydzFmRWtSRzJoV1dXdHpKYTd0aGFYSW9pTEs0THlV?=
 =?utf-8?B?OHNxb2h3S3BaODlGNVFJUjF5YStuaFB6My9rNlFaaTllTXVDQi9zcCtVV3Vu?=
 =?utf-8?B?STVJL3FRcWtFUkNPT3lLM2tsWHdGZ2xhQnFHTklyV2dENzQzTnFIRXRZc2Vp?=
 =?utf-8?B?ZWpTQlhFbWExdWVabkhtK0NGNFpUekxBRSs4ZHlhOGo2Zjg3U2xRYWt3MFNz?=
 =?utf-8?B?ZDhwVjFPbzJXcXlHT0l4TWZyOE9PaS9UdEg4VlpiaXF1eitOVGZwYVo5Y3g4?=
 =?utf-8?B?ejJFRC90N1p1bEQzeWdrOCtkM0U5ckNiWTVXUDdLYUtkVzhHMUlPV3kxVith?=
 =?utf-8?B?VmJTaEpUTEZIYVRDUUhXelVVaVJYYkdVY0tOdTdBTHZENERJbUFKUFRoSDBh?=
 =?utf-8?B?ODJEQktHUEk1Ymw5S0xvZmhnbGh6ZlN0RHpIZUQ2UlQyd3hXNzlDbVNzcnU2?=
 =?utf-8?B?VXZBQXpYc2VvSUF5MmFIaE5RRjJBdTQyL1hWWXNmMjQzUnhENTFhUUpiYWZL?=
 =?utf-8?B?WUV3Zzd6T014ZmxQNWpGWDliNXFxZ3J6SVo4ZmFlV0Y2WXhWclhBVVN3bzJV?=
 =?utf-8?B?eGxTOHJZTFREU2lBNXJlSWxQNHhTT0VrempybzNpNVRLQnpFUnFCNkRIUkdQ?=
 =?utf-8?B?eGRxZ3k2bzNPY2lySDQwMEdXNmFvTUZOZm93M3ppdWxvS3NHeVg0MCtqMVo5?=
 =?utf-8?B?ekdtYytWaWRaS055ZUdNVnRtRHFXWjdXRzBBUXozTVpYWEN3TU50Y3QrV1Nx?=
 =?utf-8?B?YlhOMm1ZNXJXbWlqaWU0ZXV2dzFRL29GZm56cEhpaXk3S2xVb3BWVVFkTGNH?=
 =?utf-8?B?RmJSWlA2eHcxVUpUNUNYMEFHWDBjeGZBOVZBRmlZaEFMVFFOQ3I1VE55QnYx?=
 =?utf-8?B?YUlHL2FQM1ZjQXNua3R0L2luL1h1RGN3T2x3VmVoWU0rRjBMYlV3UnI1UDE3?=
 =?utf-8?B?eDFyRkN4emFkL3ZkamtNdFF5Ti9yd1UxNEVVZ1JXSitnaFYwMnhyTzZodk5Y?=
 =?utf-8?B?QUNqek5aeVF4bVNVbkRlUkNuNUdIZXBtczlrWkVBV295cHM2VTN1S1Z1ZVZq?=
 =?utf-8?B?Nk9SL1FLWlV4OE1VR3piZkRFeWxIRXJWSXRQSFN4cVJidWY0REZic2NKZy9H?=
 =?utf-8?B?QmRzbXBLTVpnNnJyck5lL2pTQ2pXMVROMWM4cnRhRU10Nll3S2NvY3BUMHBy?=
 =?utf-8?B?OURWYXVMV0lEZDJockFNREd1L2daaWE1YUVZbmdkUmw0M0tNNG9WUkl6K1ZI?=
 =?utf-8?B?cVNJdjJTd0FPYUlqL0JFMER3d0VjRkR5dUtTRGlMVktRdGZnbFFQZXd6UDNL?=
 =?utf-8?B?Z1BXeDd0ZFhkdUJ3dE9TWllrOTVwUlY3UGVUM0hHZXdGMXZWQ0Q0UUNxSVNk?=
 =?utf-8?B?cmFoclU5WHM1eVVYdjlaaFpybjczMTJlOVpKM1czYVR6bmRUZzFhckZYeU8r?=
 =?utf-8?B?QUN0TVIySHltOExncHNiWHMvb1hHS1dQMGI0KzlOSlNmZUtXZkNmczY0TnJN?=
 =?utf-8?B?Z1AyckRwTmJBS3FNcE9tSkRPa2JwWDBNczNQdEFCUVlaV3JNRkM2WTZJS2Er?=
 =?utf-8?Q?b7T/XePvX1kRdHwUj4qkzcWr0?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c19b6b23-88a0-4340-387c-08dcb1f37fc3
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 06:30:55.9245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GMvdNgMg0mCOLb59r1YcxlMYT/S2QfgFzS/gkSqM7u74QeTi2BWd8qsGq2K1p6fTczpVkJOlHame+c5d7kJjfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB7209



在 2024/8/1 0:17, Andrew Morton 写道:
> [Some people who received this message don't often get email from akpm@linux-foundation.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> On Wed, 31 Jul 2024 21:33:14 +0800 Zhiguo Jiang <justinjiang@vivo.com> wrote:
>
>> The main reasons for the prolonged exit of a background process is the
> The kernel really doesn't have a concept of a "background process".
> It's a userspace concept - perhaps "the parent process isn't waiting on
> this process via wait()".
>
> I assume here you're referring to an Android userspace concept?  I
> expect that when Android "backgrounds" a process, it does lots of
> things to that process.  Perhaps scheduling priority, perhaps
> alteration of various MM tunables, etc.
>
> So rather than referring to "backgrounding" it would be better to
> identify what tuning alterations are made to such processes to bring
> about this behavior.
Hi Andrew Morton,

Thank you for your review and comments.

You are right. The "background process" here refers to the process
corresponding to an Android application switched to the background.
In fact, this patch is applicable to any exiting process.

The further explaination the concept of "multiple exiting processes",
is that it refers to different processes owning independent mm rather
than sharing the same mm.

I will use "mm" to describe process instead of "background" in next
version.
>
>> time-consuming release of its swap entries. The proportion of swap memory
>> occupied by the background process increases with its duration in the
>> background, and after a period of time, this value can reach 60% or more.
> Again, what is it about the tuning of such processes which causes this
> behavior?
When system is low memory, memory recycling will be trigged, where
anonymous folios in the process will be continuously reclaimed, resulting
in an increase of swap entries occupies by this process. So when the
process is killed, it takes more time to release it's swap entries over
time.

Testing datas of process occuping different physical memory sizes at
different time points:
Testing Platform: 8GB RAM
Testing procedure:
After booting up, start 15 processes first, and then observe the
physical memory size occupied by the last launched process at
different time points.

Example:
The process launched last: com.qiyi.video
|  memory type  |  0min  |  1min  | BG 5min | BG 10min | BG 15min |
-------------------------------------------------------------------
|     VmRSS(KB) | 453832 | 252300 |  204364 |   199944 |  199748  |
|   RssAnon(KB) | 247348 |  99296 |   71268 |    67808 |   67660  |
|   RssFile(KB) | 205536 | 152020 |  132144 |   131184 |  131136  |
|  RssShmem(KB) |   1048 |    984 |     952 |     952  |     952  |
|    VmSwap(KB) | 202692 | 334852 |  362880 |   366340 |  366488  |
| Swap ratio(%) | 30.87% | 57.03% |  63.97% |   64.69% |  64.72%  |
min - minute.

Based on the above datas, we can know that the swap ratio occupied by
the process gradually increases over time.
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
> Dumb question: why can't this be done in userspace?  The exiting
> process does fork/exit and lets the child do all this asynchronous freeing?
The logic optimization for kernel releasing swap entries cannot be
implemented in userspace. The multiple exiting processes here own
their independent mm, rather than parent and child processes share the
same mm. Therefore, when the kernel executes multiple exiting process
simultaneously, they will definitely occupy multiple CPU core resources
to complete it.
>> It offers several benefits:
>> 1. Alleviate the high system cpu load caused by multiple exiting
>>     processes running simultaneously.
>> 2. Reduce lock competition in swap entry free path by an asynchronous
>>     kworker instead of multiple exiting processes parallel execution.
> Why is lock contention reduced?  The same amount of work needs to be
> done.
When multiple CPU cores run to release the different swap entries belong
to different exiting processes simultaneously, cluster lock or swapinfo
lock may encounter lock contention issues, and while an asynchronous
kworker that only occupies one CPU core is used to complete this work,
it can reduce the probability of lock contention and free up the
remaining CPU core resources for other non-exiting processes to use.
>
>> 3. Release memory occupied by exiting processes more efficiently.
> Probably it's slightly less efficient.
We observed that using an asynchronous kworker can result in more free
memory earlier. When multiple processes exit simultaneously, due to CPU
core resources competition, these exiting processes remain in a
runnable state for a long time and cannot release their occupied memory
resources timely.
>
> There are potential problems with this approach of passing work to a
> kernel thread:
>
> - The process will exit while its resources are still allocated.  But
>    its parent process assumes those resources are now all freed and the
>    parent process then proceeds to allocate resources.  This results in
>    a time period where peak resource consumption is higher than it was
>    before such a change.
- I don't think this modification will cause such a problem. Perhaps I
   haven't fully understood your meaning yet. Can you give me a specific
   example?
> - If all CPUs are running in userspace with realtime policy
>    (SCHED_FIFO, for example) then the kworker thread will not run,
>    indefinitely.
- In my clumsy understanding, the execution priority of kernel threads
   should not be lower than that of the exiting process, and the
   asynchronous kworker execution should only be triggered when the
   process exits. The exiting process should not be set to SCHED_LFO,
   so when the exiting process is executed, the asynchronous kworker
   should also have opportunity to get timely execution.
> - Work which should have been accounted to the exiting process will
>    instead go unaccounted.
- You are right, the statistics of process exit time may no longer be
   complete.
> So please fully address all these potential issues.
Thanks
Zhiguo


