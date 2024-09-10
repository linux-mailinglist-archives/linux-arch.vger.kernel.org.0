Return-Path: <linux-arch+bounces-7171-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F20972D9B
	for <lists+linux-arch@lfdr.de>; Tue, 10 Sep 2024 11:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5DF21C244A3
	for <lists+linux-arch@lfdr.de>; Tue, 10 Sep 2024 09:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8BC188A10;
	Tue, 10 Sep 2024 09:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="jYnAzuZf"
X-Original-To: linux-arch@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2075.outbound.protection.outlook.com [40.107.255.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB141862B8;
	Tue, 10 Sep 2024 09:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725960474; cv=fail; b=QjsrZ8RkFHNPUAXN/3xJ03NDxhn3fu69MBOQRVWFWLzOOPdq9Dp+zXWDzvVA8hPorwxMGiAehVigXnd9IBcCnfFEufNsyDT1nSzw6z3juCbCmKEAZS8rgGhOgn1I8PJmcKEyme6/sRQBPaAokj0fGWH9j0Pc/0hmAtNb1tqCUxs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725960474; c=relaxed/simple;
	bh=Ks88r/UIWtfoyB+HpB+EtlADShOPC+aFNRPBMLO8HUY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IxQWrbJIpbOQfNmdGNwAspvMGlYXqXHuM68F5iOQZqNeTsCPILRBUzSUNNpUsJFFHis0pBEFs5DJEd32C7Xy9AOwABD5ZI8wCAMs64JQFPBxGFI/g+BnTazBsbDpWRjFE67Q95yAd2cNLARg/dlwKuXw3tjxLv3R0Yulb9qBVJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=jYnAzuZf; arc=fail smtp.client-ip=40.107.255.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PKA2yEOZSnsE7nyGb1n/CchbR49M3Gvn8f2JJzCVpOY5wWn4HVHlldbFUl3eJkwQt7KjD85jUqGtEypjD6rQbf7IqD4WBt0qCT1odeSV2N/GE7Z7K3VeHYrqCTrUCJaqFOv2jaYdRJt046RPb5TaTSDXRCWFOZuXelviUfVG3KEBe1WdhHRrFTWGv6j7/iY/7rXZyA2gady6peZiIq25A346NuVFmvy8rJq4FgjPHmXTNFSkf6NxNLYL6CcBWf1WYPArs8+/hAvwtJGcVht5GkZNGLqcE5K6BSX13o+GJ3wUOIG7uZFgkg0zdSbVcp7FRCtaWyegtV/8CWAEfpHN3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PSVNLvNIVqU/zHnhh8Cl1obw6kEe0aZ05cc5rqu2SPA=;
 b=SSTuGAbn4Fa6dv6/+H/+NlXX1isS+sPqJdxlvaCGaFANgIj2NnIsG03SBPsAmDyR6PYpR+igXIzIipqGoNABvrxiedu7/FXspQagmxmpDf6uoxBwsSYTYXB+p0Ch10P/pH8/MdgmuhVF2qb5PWkdNTFA+fmPk/HAnIToj+oaYJNFcffekzr8aWthWbru3jsUuRPwIUPtIGBHL0vtVdQ3/FVb86j7F1zyFev+Y6Ge8zjtI+5oJkW9IFoa6Ef15qXHcfhV8lxCme/d2AA0Z2KBQY9nqvFMWgVP2iT4uGDXn2a6tfq94hEjjuSLN5nXxhnrTbwF5NCymKN24h0jfEGH6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PSVNLvNIVqU/zHnhh8Cl1obw6kEe0aZ05cc5rqu2SPA=;
 b=jYnAzuZfJICVQ3WxpRBU5IbccD63joSBv9f6k2ynFZyRfAVEbvGeK6h2XqKrgmZ5v6LvwauWbgIBWDX4RhCtXMyHDUB0uwh6m+YW4SfRUMSkO9S2b2jQne0rM4avEEQuYp4Z3Us3hsFnZskb4oakw8K27Q49nEufmxPjlNjTqmXJWaTBZEimNL7fM7nUaSulkuiYg8sHMplRzB6fzkuVI0Blr/rlocszupCYIJPliJvU02hghVIdZRdInv9LhcGzoMn0Tflw5uL2bXU6vZphSKPBYHWTMApAfGWxkK4C+4nQJwUnCXbjcYE9pKrRgE84PkidSA2h4zf0gVKhMYLcPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by TY0PR06MB5404.apcprd06.prod.outlook.com (2603:1096:400:219::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Tue, 10 Sep
 2024 09:27:44 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed%3]) with mapi id 15.20.7939.022; Tue, 10 Sep 2024
 09:27:44 +0000
Message-ID: <5589650f-0511-46de-b08f-8accba10de4a@vivo.com>
Date: Tue, 10 Sep 2024 17:27:41 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] mm: tlb: add tlb swap entries batch async release
To: Barry Song <21cnbao@gmail.com>
Cc: David Hildenbrand <david@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin
 <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
 Arnd Bergmann <arnd@arndb.de>, Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 linux-arch@vger.kernel.org, cgroups@vger.kernel.org,
 opensource.kernel@vivo.com
References: <20240805153639.1057-1-justinjiang@vivo.com>
 <20240805153639.1057-3-justinjiang@vivo.com>
 <f58950cd-dbe3-4629-ac92-30c76db7849a@redhat.com>
 <d8445378-4eb2-4d5c-b3b8-1e1a5a3b1458@vivo.com>
 <CAGsJ_4z=u8Da4V+8HcX944SwmspXydavazoFwziZF9kCkqE-Yg@mail.gmail.com>
From: zhiguojiang <justinjiang@vivo.com>
In-Reply-To: <CAGsJ_4z=u8Da4V+8HcX944SwmspXydavazoFwziZF9kCkqE-Yg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR04CA0015.apcprd04.prod.outlook.com
 (2603:1096:4:197::21) To JH0PR06MB6849.apcprd06.prod.outlook.com
 (2603:1096:990:47::12)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|TY0PR06MB5404:EE_
X-MS-Office365-Filtering-Correlation-Id: 978e4894-e1f9-42df-de90-08dcd17ad3ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|43062017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d3RsMThyUTJWVUowY3ZhZGczS00xTHorRThQY3pWcmtUa0V3bVpPYjhVUTcw?=
 =?utf-8?B?NmpqUzdLbmxMbDBkYzBBdzdhSkd0b0pBSy9DTDdyVk5OaEJwOWQ1cGJhQk9S?=
 =?utf-8?B?ZlpGakZUKzlaUTYvSG5ZUGRXbzBpS1JkTDlueGNKZmFWSXI0d3paZU1WN05o?=
 =?utf-8?B?bzMydGVlLzlqWC9ZWHZlZ0dvVjdRZFcrTGNseUkxcU1lenNNUWdZbEFFeHFB?=
 =?utf-8?B?RTVtemFnc012T0d3MnQvN0VJMHBNQ1VBUGoxeC94UjlXTVdZUnlhaGZnQ3FB?=
 =?utf-8?B?bnc1UWFZN2swV0pzOFhXbUhzZ2tVQnk0SkFtNTNBZ0JtOVoxZ3poVnVINkt4?=
 =?utf-8?B?T2tqMkRqd29LNmxvZ0xocWdEVmkrOTBrdzBiaVpET1ZYQzA2SzJnc1o0Ly9E?=
 =?utf-8?B?YWVMSG1SNFlMUTNodHlzMjluNEp1YVhsamhIL2poK0RkRWMvM1hzL0QvN1J5?=
 =?utf-8?B?MUdIVm1aaWRBSXhNOGxlQUo2V1BYN0czMVhmeU1tbDEvTnV2WG1sRGdjaXRZ?=
 =?utf-8?B?ZStvK3RjYU1semdwUkNHdGNrelBZM1UyU203OGswQ0hSazVBbFRrVnlZemFn?=
 =?utf-8?B?NXc5SWtsNStOa1lWYngrTHBxanR4UGtRdFE1T09VVk1JZkMzd2JBRnl4bjFw?=
 =?utf-8?B?dGNnMW1FU3YrbDN1QTB3TlNZUWNBQWIvYU9ta1RZMkwrNFRBVmJCajNyTnlW?=
 =?utf-8?B?c0Noa3dCRXJwWVcyaFVtWDlpZVhmV0x3L0N1RU1keUtieFRSSDV1NG9DZEg4?=
 =?utf-8?B?N2E5USt1eFgvYjMrMHdEOENlb3d3RG1oRGRWcTNRZmVNSEZmNDRxY2kvQnN2?=
 =?utf-8?B?blZSZTRPa2I3RTlGWVpaUHZPMitxeWtURVQvZkE5UkxBQk5BVlZvbUlDcW1u?=
 =?utf-8?B?V0x6WU9oc1RRNVpKMHZnU2ZTWGg0eFU3T0txVmZYVnhCVUlCVEMwVk5MN1JS?=
 =?utf-8?B?MWtZK0NoYjZ1UW5JT3IvVmxzRVRsaVl0QURCaVRkQzBDSGUwOVMySlhWZjFn?=
 =?utf-8?B?UmV4VElkSGVIaTd3OFRnV3RmeEhIc0IwM3k0ZHBqZk1HVlpEY21KMStkYVhz?=
 =?utf-8?B?QW50MC9jRlZwYjB4ay9vVkRxWUMrRVlVR3pSSkpieWlVYzhBTkFTdkRRREpp?=
 =?utf-8?B?TFZZemZ2NGhxV3dWSWVhYWpzemc3bEUvdmJBYWhvTXBvUWF6U3VGL2FYYTBz?=
 =?utf-8?B?Y1BhdEdsYjJmdXRNdkx5UlhQT1Q3anpKdzVtZ3kzWnppNTdMbmszR1Q4dldB?=
 =?utf-8?B?ZFluU0txd1dlaSs2NnRNYzRHZGtJSERxYTl2c3RsN1FDaVdqaVVpajQ0WHhp?=
 =?utf-8?B?SFFyWFRHV0hSTEt0RTNsQUp3bWt1MFUweWdEbVJmeGRuQ0hIdHE4STlub2hT?=
 =?utf-8?B?TlpvQThudTN2MkZrcTFFMFBURXo2TUNSUURxMDkvT1RQR3VwNHllNVJ4V1hv?=
 =?utf-8?B?M3Jkc2ZoMTlnVXZPaTFyUTVlbUFBQzlxdkdRajZxYmFLdmN3RFpZQjlwUE9M?=
 =?utf-8?B?UzZ5TmVUYXMwOVZEaElmSUpjQ2huQzluVDI3ZXZHYk9kN09VWmRES0xmczZE?=
 =?utf-8?B?TGhBenlUVXZpemwrUnVwTjJOeFN0bVRIRUNQSGFiRk9VN0tBazM0YWdJQU9Q?=
 =?utf-8?B?amdscGRYMXJoV0RQQWVaMExCY3h2Zk04M0ZBaFMvemxNYnNGOE1zQVJlL2hX?=
 =?utf-8?B?TU5LRk1iYnpFV1VyVnhtbUl4WTNNMW93NkNDelFqT0JLa2ovR0dNbGtya3V5?=
 =?utf-8?B?L2JmL0VVSkFkU0loK2l4TnhLTDY2WnBWMTJ4WUdHSTJOcUVFOUp0R0ZRa3k0?=
 =?utf-8?B?Slg0QVkxcjdpUklUQXBIQ3pjQ2F1UUxici94b1Z4ZVQvRHVndUw2M0w4T3Np?=
 =?utf-8?B?MVErTHJaTjJJZGdYeTlBZ05LczhsbkNVTlBxYis2aWFDNVE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(43062017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bUw4clFDUythL1pEVlpDMHcybjZ3OU4vYVVCancvamhkMlc1NnZ1QitPbWpM?=
 =?utf-8?B?MkpIbnVtMWd4anlKM2c1clptRENJaHFxUWIvM2xMeVNtczFKcmh5QmlFZHBt?=
 =?utf-8?B?RkVWRC8vZ0VKdmRDOWdybEVSZ20wWDZQemZPUE5GUTlXUTJZeWtSRFhpL1pW?=
 =?utf-8?B?SGxEK2xsWTJiUXZnNWExaUI2U0hPZGJLdDRSTnk4S2FxTTJTdVdRWkN0MUhz?=
 =?utf-8?B?bkVxVldsaXJuNDA4OEwxOWpQNUhOVGxtWTRxT1JwbFJ5NjZyd1hVeTlaRHdm?=
 =?utf-8?B?Q3h1YlFnYVJvd2RlbE9vdzc4OG5sZzR4TStRUnNrN2lNWTRqcFdJQUNnRHFN?=
 =?utf-8?B?TTVCRnpUVFpKdlFFTXo1a2kwVllmQVl0SWZhRXdSYVd1OTYwMHlEMXlvR2FX?=
 =?utf-8?B?Tk5yU2ZtK09TY0FrWjJpRVFCL3pKaDlzbWhVdVBhMFN0SUlBTUlhZWhVWVpF?=
 =?utf-8?B?bGt3S0NYcDA3czhZSUIrLzBpaUJMZ2p2VDEwNG4rV1hJS2FGRDJtVEJtbkkr?=
 =?utf-8?B?OTJkOGxXSEJGcGovdnE2cXM5cS82em1pdDF2UGhKcGtidGJmb3VINVB1UDdJ?=
 =?utf-8?B?VHNpL2FCYTJmUThSeXh5NGlZRmd4UXZJdmJOTXBMYVpsZEtxa1BBcFJhdVE1?=
 =?utf-8?B?bVFjZ3JkSUtJTGtTRUpwSERNMGJJLzJ2YTN0Q2QyeW94SUZLV1RhL1JpZHR6?=
 =?utf-8?B?dEx6TFQxeGJxZ2JNVDdMZ1B1ODhMZFp0SnNPb2ZhaUkvNlZpbWNrWmpTZlND?=
 =?utf-8?B?NUtPb1hXcjRlVUJwaXJlQ01DOFVQZDJOYWM4MGFCek9OM3pHUGhuUmgxVy95?=
 =?utf-8?B?cUlEcDVzMkxTVHJ6Q2MzYkJxMHZITkk3Mnl5Ykh4NUx6emlDS0VtajNaaDQ5?=
 =?utf-8?B?Z2tkMW5MbFA3UWRVckJGdlR6VWUwc0J4eUJiVnU2NFkzay9EUklLQlRremVu?=
 =?utf-8?B?c0VaSVUzcWY3N0ZFaFFQbWdab3BocUo4ZlF4bmE3c1BFOFBBSmFRdFpRODFN?=
 =?utf-8?B?TUszV0VzRWM4SHFsRHpiU2lTR2VEOThyTE5pTVhieGNKUVVNcFp1Nkk5MWxS?=
 =?utf-8?B?MUJuUHhOWitKd1JrWGRaQ3FleC9FRnJFSWtlV2F3QlQrSHNoYjAweWFOZkRJ?=
 =?utf-8?B?UTNMUlFZc2RVNjczMks1emlRSm4rL3VITThjUE9LOG9rclVVNFlKNVdwNDUx?=
 =?utf-8?B?Um5MVkVLSldrZGFkV0JzOVlCbXpRa2JNb3VoSE9KeE5QZEUzNU0xY2FxclJ4?=
 =?utf-8?B?emxpWGw2bkRQY1R4K2VmSnNnQTZuRTdVQlFVSW5qZTV0ZU1mOUZvZkNvQWw4?=
 =?utf-8?B?am1CaFZlRkQyb2pwbXNobUxFMmM4cGRxSEh3aENDNEwva043RTRoajRtUWNl?=
 =?utf-8?B?K0dxcEtodTVVZGRXMytyY2tZV3h0VVUzc2JMcmg4STJsWU5rQU5MN2pSNlVK?=
 =?utf-8?B?SUptZG5jQjFSUks3bmtLYThJUWtIZU1OcnErN29FRFhNREZ0OTIvV3c1RVl0?=
 =?utf-8?B?VlJZOEFEK0Z1akFjcWl3dndJZ1RDVUQ3ZlI2Y0xPNGlxbWRzSjROY0N0RUZP?=
 =?utf-8?B?bW11a0pGR1IwM293ZG5HUnE4a3hZSjkrYWVQU1V3WWU0RHczTEtvK2d2Y29r?=
 =?utf-8?B?NVFpVmFmQmlNVmVHUGdsVUVwdGdabnJMMzFPdFB6ZnhQdWlncWZ5R2tRSytJ?=
 =?utf-8?B?V2ZhUTdXK2xBT09XZTlHWjlNK3ZXRytMRjRhMFFuN2pXVjRGSWVQeEFEM0Uz?=
 =?utf-8?B?NytuNUswdndoRFArVHFiUGlmUTBFdFNSbkRmckZTUXF4RkN6ZlAwcENVSkJm?=
 =?utf-8?B?ckpYbGdrUFNCTXpjdlhyVHlMd3RGU3FYcEZrQUJpeW1zTFR5amdrVTU1eXZz?=
 =?utf-8?B?c2paRXVYWkVUQWMzckFRSWNuZnR5VWxrVWxMV2c0K1p0bXlKU3UvOEo3VzVk?=
 =?utf-8?B?UVpKQWpTdGJ4eDdVeXNNUVZEM2tmMG5lZHF4Y0o3RXA4Tk1xY0E0K1dRakVp?=
 =?utf-8?B?L3pkdGhzVVdaWGw1bkJkUTJDSmsrRitBNUJoRUlKYVpmR2s5L2ZmZHdyMDYy?=
 =?utf-8?B?S201ZzNPV2RRU1JOcHVvc1dUaDhxVXdSWTVZR2NlRXdGaDFyRHJ4SWNGUFUv?=
 =?utf-8?Q?Mlb5Wq+RZDd4Woo9BkW7lOTlH?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 978e4894-e1f9-42df-de90-08dcd17ad3ac
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 09:27:44.8122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CILsUFpiSCefJtWoPV3PgQ20gQTC546ta2wGMJaSd5tm9YNX5t0bcS7vKySGcmCyeopcon8EAiHuURW3FoI2Ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5404



在 2024/9/10 12:22, Barry Song 写道:
> On Tue, Sep 10, 2024 at 2:44 AM zhiguojiang <justinjiang@vivo.com> wrote:
>>
>>
>> 在 2024/9/9 14:49, David Hildenbrand 写道:
>>> On 05.08.24 17:36, Zhiguo Jiang wrote:
>>>> One of the main reasons for the prolonged exit of the process with
>>>> independent mm is the time-consuming release of its swap entries.
>>>> The proportion of swap memory occupied by the process increases over
>>>> time due to high memory pressure triggering to reclaim anonymous folio
>>>> into swapspace, e.g., in Android devices, we found this proportion can
>>>> reach 60% or more after a period of time. Additionally, the relatively
>>>> lengthy path for releasing swap entries further contributes to the
>>>> longer time required to release swap entries.
>>>>
>>>> Testing Platform: 8GB RAM
>>>> Testing procedure:
>>>> After booting up, start 15 processes first, and then observe the
>>>> physical memory size occupied by the last launched process at different
>>>> time points.
>>>> Example: The process launched last: com.qiyi.video
>>>> |  memory type  |  0min  |  1min  |   5min  |   10min  | 15min  |
>>>> -------------------------------------------------------------------
>>>> |     VmRSS(KB) | 453832 | 252300 |  204364 |   199944 | 199748  |
>>>> |   RssAnon(KB) | 247348 |  99296 |   71268 |    67808 | 67660  |
>>>> |   RssFile(KB) | 205536 | 152020 |  132144 |   131184 | 131136  |
>>>> |  RssShmem(KB) |   1048 |    984 |     952 |     952  | 952  |
>>>> |    VmSwap(KB) | 202692 | 334852 |  362880 |   366340 | 366488  |
>>>> | Swap ratio(%) | 30.87% | 57.03% |  63.97% |   64.69% | 64.72%  |
>>>> Note: min - minute.
>>>>
>>>> When there are multiple processes with independent mm and the high
>>>> memory pressure in system, if the large memory required process is
>>>> launched at this time, system will is likely to trigger the
>>>> instantaneous
>>>> killing of many processes with independent mm. Due to multiple exiting
>>>> processes occupying multiple CPU core resources for concurrent
>>>> execution,
>>>> leading to some issues such as the current non-exiting and important
>>>> processes lagging.
>>>>
>>>> To solve this problem, we have introduced the multiple exiting process
>>>> asynchronous swap entries release mechanism, which isolates and caches
>>>> swap entries occupied by multiple exiting processes, and hands them over
>>>> to an asynchronous kworker to complete the release. This allows the
>>>> exiting processes to complete quickly and release CPU resources. We have
>>>> validated this modification on the Android products and achieved the
>>>> expected benefits.
>>>>
>>>> Testing Platform: 8GB RAM
>>>> Testing procedure:
>>>> After restarting the machine, start 15 app processes first, and then
>>>> start the camera app processes, we monitor the cold start and preview
>>>> time datas of the camera app processes.
>>>>
>>>> Test datas of camera processes cold start time (unit: millisecond):
>>>> |  seq   |   1  |   2  |   3  |   4  |   5  |   6  | average |
>>>> | before | 1498 | 1476 | 1741 | 1337 | 1367 | 1655 |   1512  |
>>>> | after  | 1396 | 1107 | 1136 | 1178 | 1071 | 1339 |   1204  |
>>>>
>>>> Test datas of camera processes preview time (unit: millisecond):
>>>> |  seq   |   1  |   2  |   3  |   4  |   5  |   6  | average |
>>>> | before |  267 |  402 |  504 |  513 |  161 |  265 |   352   |
>>>> | after  |  188 |  223 |  301 |  203 |  162 |  154 |   205   |
>>>>
>>>> Base on the average of the six sets of test datas above, we can see that
>>>> the benefit datas of the modified patch:
>>>> 1. The cold start time of camera app processes has reduced by about 20%.
>>>> 2. The preview time of camera app processes has reduced by about 42%.
>>>>
>>>> It offers several benefits:
>>>> 1. Alleviate the high system cpu loading caused by multiple exiting
>>>>      processes running simultaneously.
>>>> 2. Reduce lock competition in swap entry free path by an asynchronous
>>>>      kworker instead of multiple exiting processes parallel execution.
>>>> 3. Release pte_present memory occupied by exiting processes more
>>>>      efficiently.
>>>>
>>>> Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>
>>>> ---
>>>>    arch/s390/include/asm/tlb.h |   8 +
>>>>    include/asm-generic/tlb.h   |  44 ++++++
>>>>    include/linux/mm_types.h    |  58 +++++++
>>>>    mm/memory.c                 |   3 +-
>>>>    mm/mmu_gather.c             | 296 ++++++++++++++++++++++++++++++++++++
>>>>    5 files changed, 408 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/s390/include/asm/tlb.h b/arch/s390/include/asm/tlb.h
>>>> index e95b2c8081eb..3f681f63390f
>>>> --- a/arch/s390/include/asm/tlb.h
>>>> +++ b/arch/s390/include/asm/tlb.h
>>>> @@ -28,6 +28,8 @@ static inline bool __tlb_remove_page_size(struct
>>>> mmu_gather *tlb,
>>>>            struct page *page, bool delay_rmap, int page_size);
>>>>    static inline bool __tlb_remove_folio_pages(struct mmu_gather *tlb,
>>>>            struct page *page, unsigned int nr_pages, bool delay_rmap);
>>>> +static inline bool __tlb_remove_swap_entries(struct mmu_gather *tlb,
>>>> +        swp_entry_t entry, int nr);
>>>
>>> The problem I am having is that swap entries don't have any
>>> intersection with the TLB. It sounds like we're squeezing something
>>> into an existing concept (MMU gather) that just doesn't belong in there.
>> I referred to the mechanism of batch release in tlb, and perhaps a new
>> structure needs to be created to implement this feature.
> We already use swap_slots_cache to collect multiple swap entries and
> free them in
> batches. Would it be better to incorporate our new logic there? might
> be much less
> change and don't need to touch zap_pte_range() ?  for example, while slot_caches
> are almost full, wake up the async thread to free? Or, do you think
> that cache->free_lock
> is also a contended lock?
There should be no need to add mmu_swap_batch logic in the sync release
method, and this may lead to repetitive logic. The number of async
threads for releasing slot_caches seems also uncertain for a large
number of CPUs architectures. The cache->free_lock is a percpu spinlock,
which will disable preemption, so I guess there should be no lock
contention issue with it.

I understand that you want to incorporate this feature through sync
manner, and I think it may be a bit difficult.
>
>> Thanks
>> Zhiguo
>>
> Thanks
> Barry
Thanks
Zhiguo


