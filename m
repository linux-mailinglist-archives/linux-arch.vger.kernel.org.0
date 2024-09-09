Return-Path: <linux-arch+bounces-7156-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26914971CF7
	for <lists+linux-arch@lfdr.de>; Mon,  9 Sep 2024 16:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 425BB1C2166F
	for <lists+linux-arch@lfdr.de>; Mon,  9 Sep 2024 14:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C6B1BAEE9;
	Mon,  9 Sep 2024 14:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="hRL2qA2a"
X-Original-To: linux-arch@vger.kernel.org
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11011061.outbound.protection.outlook.com [52.101.129.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEB51BAEDC;
	Mon,  9 Sep 2024 14:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725893048; cv=fail; b=gVlirOpthWNiTeBEcu3NJBGgD2sCXNFXlwSZyU6mXlQfORwcopbMbHJRbBPg6XVgufsXbVtDC5g28B2q9osgYCkA3Aw/KjdwpjG5E4TfTmWk/nUgszBb2lX04BZIAZtZQLugh0UH2RTWYQX8AYYZm/BXb1Ix9O2pNOUJEZHCLuk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725893048; c=relaxed/simple;
	bh=tmtkriEZD05qaLXD9H8eMFGuOeaVuZZO6yQevMRkbns=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uDOWTRWyoGe7kRP5Aky1P90hVPN63l6aSFm8vMcsODccFSyhN5RpjrMXsNPFvzFTAOr6DENo15pqjsjIL0fxhydOQlnM0DTjrYRmI2RJLoaRN9ZgxyX70D7OLcqdBJeA1fAuUofCd4Bfc/VyITfWsgW04EqJTqTriUejx1tV1Zo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=hRL2qA2a; arc=fail smtp.client-ip=52.101.129.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=guZsIKdIKF1L9XXv4TJzPNAGCk5GPMqOgguaA3upRfPMZgC9vhBgnoe+UWIBIF5aA10J7n8Se1Zd8U6l9yH8j9GCmXfoqL0rGPcTZMDuBM4xB5SeludPmMqFct5KTAzoezP5l6Y0UuxIfsE3p4UBIw3N+hJGAlCdNWqa5KjUXFeC4aRHvHcTW9+DfOJiTMNH2HuWfM3AteWftk8rtfEmPZw3ac8PEdTKxHCN70vfINRjSJZ4KTXl3YsnHPXNwVDD7DU2OdpjJc0FDzEh9+XOlN7Lj7X74VzudJrAzrg1odmUnIGom4/XMXlGzBsXJKcFtxHEgJ9Nnm3XGbFS+bdTqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R1d0hDLYmeeJx9kTdtpwgMxA4GHaiDgWUjr5zfmjJpw=;
 b=V+cJBeGbCz8/++Xjl+iCUywh8/Fa2l9UL2KSC76AJo4cIKqWTrYX1CRUfurn3xuvGPY1JjJpszTc6RvG47oN4/vZXpV8PQxGNBKt2aRKOngxbZSH+i6CFeMP/IyKPUFp0RQ5RRSqoZ5wVnNSiJyF6SDQxcnXZ9byb2BACR7XXIg2GlJBFMyfRUNsjddoPUpEe16zUenDLeiYvCVDLM6kgXbsF8qffX05kW+K2mOWUmEyo2kD1BpTCKAwkzeZtpImPvQqX2p3FnjKN5nEFkDE0JC5Xbz6FjV28D6iUwTCoNET+/KjC7FFU3ANdQ47t78rWTFeNllcjlqq39blVapdTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R1d0hDLYmeeJx9kTdtpwgMxA4GHaiDgWUjr5zfmjJpw=;
 b=hRL2qA2aq88Pw4FzpTHmXMl1xsYDaOCIxb7gTKCFK8nLYS3043qqnMcrBh7drMJoOh47xs3tPNbQuIlhsfZXPWS9MtZIn21MmBu6DrB/2gYFXKUI1eySfUl3Wd3nDvjsskyCQekrLqFJdmtECFNku+KHc7oUf1VsyEOcbKuZU4tQavE7KwdutdGlpCy1PS9H+uhQ0muSVjP+43Yt3NCQVVCqfrCm0d6WIeY662K8UXlf9Mk0+s94kkfS77pUuRbHIcRsjnNDgfCmnSeoGCsHdr1dOa60hoRQF5+51gFROloCQDj4RCJHCFnBSIEOtFELzKE+yYMGLE/icmfw2XsREg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by SI2PR06MB5388.apcprd06.prod.outlook.com (2603:1096:4:1ef::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23; Mon, 9 Sep
 2024 14:44:02 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed%3]) with mapi id 15.20.7918.024; Mon, 9 Sep 2024
 14:44:02 +0000
Message-ID: <d8445378-4eb2-4d5c-b3b8-1e1a5a3b1458@vivo.com>
Date: Mon, 9 Sep 2024 22:43:58 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] mm: tlb: add tlb swap entries batch async release
To: David Hildenbrand <david@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin
 <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
 Arnd Bergmann <arnd@arndb.de>, Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 linux-arch@vger.kernel.org, cgroups@vger.kernel.org,
 Barry Song <21cnbao@gmail.com>
Cc: opensource.kernel@vivo.com
References: <20240805153639.1057-1-justinjiang@vivo.com>
 <20240805153639.1057-3-justinjiang@vivo.com>
 <f58950cd-dbe3-4629-ac92-30c76db7849a@redhat.com>
From: zhiguojiang <justinjiang@vivo.com>
In-Reply-To: <f58950cd-dbe3-4629-ac92-30c76db7849a@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0046.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::18) To JH0PR06MB6849.apcprd06.prod.outlook.com
 (2603:1096:990:47::12)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|SI2PR06MB5388:EE_
X-MS-Office365-Filtering-Correlation-Id: d7b02fec-a88f-4b91-f544-08dcd0ddd897
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|921020|43062017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Zmd3M1RQUzFDRXIxaXQwRThQZmE4azgxNUpweU4vQ3A5VFUwTVFnSnRhL3o1?=
 =?utf-8?B?ZCtNS0dQYUJBRWJqYk1SczYyVDNDNDNzMTZwdDl1WDhRYW5QUXQ1RVFlL29N?=
 =?utf-8?B?cUVRWUNRYjJDbEFVTFp1M2hsVnB3U3o0cVFISWhMdkFzeW1UQUljS0tERXVj?=
 =?utf-8?B?YmE2V25OMldFTEo1YzRySFNBQWtKOHpoVHAxcy9yWGtIUitNcURxVFhnOG14?=
 =?utf-8?B?Zy9iQkJ2b1BIVUZoRWZuOEVJbFJNKzlyNXVUMDVMcEhOckFTbXNOZFVoc1dP?=
 =?utf-8?B?YUhzLzdDeEtvcVpGN05jMlhZdnFtc0h0TEFrcmRmd3NIbm1Yc2VaWVBLZG1J?=
 =?utf-8?B?OFhESWZDemVzd1hhT2owazZ6b1Bwd3NKc28rMmlJS3krbSthZFhUYXZ5L2dt?=
 =?utf-8?B?YlM0cHZwV1BBQkZUNDhiL0E1c09Oa3JCc2RQSWN5K1RwMG1MSnIyMUtSbStJ?=
 =?utf-8?B?MU52RUJ3OU9XVm4yUk92WHRvZ1NqZU1TUVJ1dFQ2OXp1TWxlQUVNUklJb1lP?=
 =?utf-8?B?cENNQmtiSmk3QzY2cUxaZjJvdEQ3aitEbFJkbUg3QUhaengyQW9GRDJtakp6?=
 =?utf-8?B?dmI1RmlNajhEQ3dhNHZWaFVGWjdidStGRXJJZmpQMVYyNmdWYzRVZksxVmpD?=
 =?utf-8?B?RHpqalA1eFVaZWl4VnZvWnZqd0RYNjM0aGtna1JIaWxuRkNvcUo3MmFrOXN5?=
 =?utf-8?B?MXF3M3ZvMWdTc1VGenEvS1NxWTFXOGJDdXQ0cjF2dyt0SGJ1OUZlWTZzMVFo?=
 =?utf-8?B?NVNZNTR5VUViLzVMTHQvZHplNlRLekpzMFEwNFBKMVkwcDIvMEx5OGxiTWVS?=
 =?utf-8?B?c08rZFBseWV1MjM3YW52RnNoUi85Y3drYUZuK2M5bFpBcXEvbmpqMHc0ME94?=
 =?utf-8?B?dFJPTTJHa0NZcU5GV2YrYjJUT0dMOE9ITGNEZjZteDQ3TkhQNHMwTHh6V0h3?=
 =?utf-8?B?K2Q0VFZQbXhMVm0vUkNNVUprV0ZmSnFjRnpMckRGZTJDeEVIV21CZk9nYnlj?=
 =?utf-8?B?b25sSGk1MUJ1bjlTRkVpSkxuSmRQWmVPSS9OdHd1NmVQR01USnJ3ZWJITVpv?=
 =?utf-8?B?MzBaeGU5dFQ2WjVnblZKYTkzYTZteW5nRUY0UHk4akhXaHpuZ2hNTkxoSFk3?=
 =?utf-8?B?VGhSWmFoUVM5YXRDcWdMSXdDUmlWOXRza05FSlF2bUZnbHZMSURyWVpweVVU?=
 =?utf-8?B?T1VhbUVIb01IOW1nYWN4L21rTFdhcGpQdEpXRWd1UnBHSTErMjhnUFFzb2d0?=
 =?utf-8?B?QUR2ME9jcnd1UHc2eVRVTmxrTnB2TFlhZVphZ2tpRGFrQ3IrU0RzYUY4VHZW?=
 =?utf-8?B?V2hpcmNPbnE4K0thQnlPNFFxaTlpRmg3eWo3VFNxOW1kS0hOUEdMTFl6RDFB?=
 =?utf-8?B?R1R3NDNsMVRlL0NXQ3l6T0M1ZkNkQTFGcnB0Z09LaDFnakdBV1Z1bDVZNDhq?=
 =?utf-8?B?bjdVV1pKNUk1cS9YcS9jVXdJdmVQd3NIVEFxbHBIR1VRdmN2TXI3TmZRdTBB?=
 =?utf-8?B?Zmo2Nk1Cdk5JWmhqVkl1QndScTgyL3BjNmUwTEt1eG8waTY1YXZVcXpxWmg3?=
 =?utf-8?B?UTFGUk5yRk5NZlpGdDdBeUZXY1ltVGZuYzBnWm5yTzZhZFlRL29kbGhiZmdO?=
 =?utf-8?B?cG9hbFNUZk5SekREekNocENpMzJzVVZVMlFDd3RZUjN0VjhVSTlaTi96NUR2?=
 =?utf-8?B?eE1ERjhXU3NxOHdQZG8zdGkrRTBYMzd6OGdEN0NIK0xDUHVneWd4SkVBWVpk?=
 =?utf-8?B?M2d4OFdwYkt3eG56bVRqNmJ4UGE2ci9kdFU3K0p4cjBDZjFhL0hXd0VyMTQ0?=
 =?utf-8?B?OXVCYVdIQ1F1VFY0aENuNWM3djMraC83Sk93Kzd2UkxIR0ZtRHRVNDhiNDJ4?=
 =?utf-8?B?U1lTRE51NTBLNng3MWhabjF0N0wwWSt4Y2U3aHFSNlNyV3c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020)(43062017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZldTSnFja0hZNDlKc24zbnlTNEpFZTRReFlnM0tMUFVTQkora3hCZ040UEVp?=
 =?utf-8?B?VW16TEFvSE1rU29QSWVSRG44cGluVU9uaVZxVlpwdk0vVGN4LzlPcjhMOVdj?=
 =?utf-8?B?QVdTME9NSFZyV2ZSRzRCTkJZUVk3RDBmUDNPK1pxclhGRjFsMlpUN1JFTU5u?=
 =?utf-8?B?K1lxSHl2VlNEQzFQWHlVME04QkYwQXRrU0dNeWVXNHIrc0Y2aFQ1YUZqdjZ1?=
 =?utf-8?B?VHBBM3lNeStGWjAvUVJSOFFFWlcrSjJ2NXdiVXJyNjNBMGJhK3B1ZGlUeEl0?=
 =?utf-8?B?QkZzcXJ0M0ZnNmtnckRsUjVNZ3haaEZESzZpdkxMZHJpT3lsUzY4KzRROU56?=
 =?utf-8?B?YlhpTGMxR3Y1MjRFT2txdVVNWG9FQjBNVDNEc2lrOUV0ZzdsdzN0ZzlUajEw?=
 =?utf-8?B?QTFWeVgzNXhKRFdLcVJremNBTEhoQys2OCs4bEswSHZ0VEc5TSt3cGNFVkxW?=
 =?utf-8?B?citxaXA0ejRoV3p4NHgwb0w0V3l4M1UzcWZnV0VST1p0RjhVMDl5QWcyM1pW?=
 =?utf-8?B?V081NGw2SUxab0oyYTFNaWdVRGF5dHlxbTdCNVlwb3d2L2pUa05jbXg2MG95?=
 =?utf-8?B?b05HYzBsNnVQME1FQnhqbndQOHM0YmNRdDAzRW1uM1AzWitWNmwveXRzVkFo?=
 =?utf-8?B?Q2FkaVhqZmFFQ29VRUFseHBXRlRCUzdSNnJ0aW5SaURCSkxlS01tU1lldVkr?=
 =?utf-8?B?NVV6WC9TTUI4SVpEbzlkZUNJSk9lQ1ZlUG9IY0hLcytzSTVZSmdENHBPckRZ?=
 =?utf-8?B?eHNFNVZ0M2xjNk55dzh1YmtON1hwcUlyajBEWGlNdE1qOC9IUStneXlmQWl4?=
 =?utf-8?B?a2p1bFRRMVNvN3lhd0lxYi9Fb2hRVFdIbEk4K3lyK2ZiMmZkRmgwYW8wSTJW?=
 =?utf-8?B?RjV5TDgvVGFqdUxmbGRyYnFDR0Z1UFlQckV6aDNHazNCcENwVGRic1BhT3FZ?=
 =?utf-8?B?cEw2YjJoMEt4STF5aFFuNkIzUHFBaFBkdE5JRm5BOXIxbHBUcUszcjZtZXpm?=
 =?utf-8?B?c1RlNXM1M0V3cktXWmhqcXNwL3huczl4L1l5NGlXR0Z0ZG9PaVlFdGlQdy8y?=
 =?utf-8?B?MnZWcXdZd2VDQzY5ZXFEalByeFhFWDdMMHd2MVFCOTRCbVBkc1BYVnlvLzMv?=
 =?utf-8?B?eFVIZWhWS05sQnpJWXFjT3pXYWQ2L2h4bWFEaDVOSHk2M3dteDRBSEQ4YmVY?=
 =?utf-8?B?QllPZldpcWJpVk9SYWZIY2Y0TTB2TEludkVHYTZWazhKbStUR2pyYTZxU0hR?=
 =?utf-8?B?bVgvZVNzZzdIeitHWXpDWkxRVUppOWxmeGx1RkNXTm8vd1NrR2pjQjdidm1U?=
 =?utf-8?B?ZkxhT09uc0l5UkNldGdFRFFnaEZFQnMrTzREMkdUVkFlejZtV2o2TzVoZlJt?=
 =?utf-8?B?MHUrSFIvSHlFcVBXM0hrZFVSSnA5VjIwTnoyUHRLSGxJc1AvRkhwRWNnclpp?=
 =?utf-8?B?REtvamM2dHN3TDNwWHY1STIrTytEeWtPZGkvSmNQY0lDSkNyQ0h0N2UvTVR3?=
 =?utf-8?B?NGJYYnVFeE9DWEcrVU1icm92eFlHcWMzejVEM3dCY0NpWm5iZFhDc29VN09H?=
 =?utf-8?B?RThkOTN3Y1pzR0ZUclQzZmRIYm5EUVUxUUh5SndVMUVsSVhPdWNWQ3RRZ1RR?=
 =?utf-8?B?clAxZCtmMkU5MTlwdmRnc1V6b0d0eXlDSmg5MFh0WnZkaUY2aHBNWlc0SUZO?=
 =?utf-8?B?RXRiNVYxTVRxdmZGK05HYW5HdW9SM0Mxc3hENjRvak15R1QvV1VzODRpOStB?=
 =?utf-8?B?RUljM3I3YzVYUnRrUlpYS3pwR1JuTzlVQlVnM1N5QlZMWkNVak9DYWsrWSt2?=
 =?utf-8?B?WE1oV3JRM0l4eUk0VCtkSWM3SlNFd05PdExOWnBwb215OVhubU1jY1hGNzFG?=
 =?utf-8?B?V0w4VXBJN3ZGZzV6QzJmbEh5Vm9MTHIzQWRiUWFOZVlOYllVc2QzeTBSRWdV?=
 =?utf-8?B?RFBrL1o2TTV3enQwb0IyZllPc2tvZXVGdGFOeElrZnAyUlV2WUN5dlJDM3dz?=
 =?utf-8?B?SVIvSDVuaENkS09VNitMQWtRMTRmdWhSQitpcWtnb1NvdnZzTllTVTdDTUJn?=
 =?utf-8?B?dU9YSVBEaUpBU0tibytWQVNHUnMzVW1XSzZXUUExV0t0K0lML1c2a2FsUWNO?=
 =?utf-8?Q?HjWxOkfpY5yRyAQq2QV7emuHA?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7b02fec-a88f-4b91-f544-08dcd0ddd897
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 14:44:02.0934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lV2g45F/6vem9hWK2deqJ/0m7JVXwZ8ABZi7x3Dh9G27nf5TguciL9Tb7p1Cc1BQpDKeCuLgIbcvBmoHDZbkkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5388



在 2024/9/9 14:49, David Hildenbrand 写道:
> On 05.08.24 17:36, Zhiguo Jiang wrote:
>> One of the main reasons for the prolonged exit of the process with
>> independent mm is the time-consuming release of its swap entries.
>> The proportion of swap memory occupied by the process increases over
>> time due to high memory pressure triggering to reclaim anonymous folio
>> into swapspace, e.g., in Android devices, we found this proportion can
>> reach 60% or more after a period of time. Additionally, the relatively
>> lengthy path for releasing swap entries further contributes to the
>> longer time required to release swap entries.
>>
>> Testing Platform: 8GB RAM
>> Testing procedure:
>> After booting up, start 15 processes first, and then observe the
>> physical memory size occupied by the last launched process at different
>> time points.
>> Example: The process launched last: com.qiyi.video
>> |  memory type  |  0min  |  1min  |   5min  |   10min  | 15min  |
>> -------------------------------------------------------------------
>> |     VmRSS(KB) | 453832 | 252300 |  204364 |   199944 | 199748  |
>> |   RssAnon(KB) | 247348 |  99296 |   71268 |    67808 | 67660  |
>> |   RssFile(KB) | 205536 | 152020 |  132144 |   131184 | 131136  |
>> |  RssShmem(KB) |   1048 |    984 |     952 |     952  | 952  |
>> |    VmSwap(KB) | 202692 | 334852 |  362880 |   366340 | 366488  |
>> | Swap ratio(%) | 30.87% | 57.03% |  63.97% |   64.69% | 64.72%  |
>> Note: min - minute.
>>
>> When there are multiple processes with independent mm and the high
>> memory pressure in system, if the large memory required process is
>> launched at this time, system will is likely to trigger the 
>> instantaneous
>> killing of many processes with independent mm. Due to multiple exiting
>> processes occupying multiple CPU core resources for concurrent 
>> execution,
>> leading to some issues such as the current non-exiting and important
>> processes lagging.
>>
>> To solve this problem, we have introduced the multiple exiting process
>> asynchronous swap entries release mechanism, which isolates and caches
>> swap entries occupied by multiple exiting processes, and hands them over
>> to an asynchronous kworker to complete the release. This allows the
>> exiting processes to complete quickly and release CPU resources. We have
>> validated this modification on the Android products and achieved the
>> expected benefits.
>>
>> Testing Platform: 8GB RAM
>> Testing procedure:
>> After restarting the machine, start 15 app processes first, and then
>> start the camera app processes, we monitor the cold start and preview
>> time datas of the camera app processes.
>>
>> Test datas of camera processes cold start time (unit: millisecond):
>> |  seq   |   1  |   2  |   3  |   4  |   5  |   6  | average |
>> | before | 1498 | 1476 | 1741 | 1337 | 1367 | 1655 |   1512  |
>> | after  | 1396 | 1107 | 1136 | 1178 | 1071 | 1339 |   1204  |
>>
>> Test datas of camera processes preview time (unit: millisecond):
>> |  seq   |   1  |   2  |   3  |   4  |   5  |   6  | average |
>> | before |  267 |  402 |  504 |  513 |  161 |  265 |   352   |
>> | after  |  188 |  223 |  301 |  203 |  162 |  154 |   205   |
>>
>> Base on the average of the six sets of test datas above, we can see that
>> the benefit datas of the modified patch:
>> 1. The cold start time of camera app processes has reduced by about 20%.
>> 2. The preview time of camera app processes has reduced by about 42%.
>>
>> It offers several benefits:
>> 1. Alleviate the high system cpu loading caused by multiple exiting
>>     processes running simultaneously.
>> 2. Reduce lock competition in swap entry free path by an asynchronous
>>     kworker instead of multiple exiting processes parallel execution.
>> 3. Release pte_present memory occupied by exiting processes more
>>     efficiently.
>>
>> Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>
>> ---
>>   arch/s390/include/asm/tlb.h |   8 +
>>   include/asm-generic/tlb.h   |  44 ++++++
>>   include/linux/mm_types.h    |  58 +++++++
>>   mm/memory.c                 |   3 +-
>>   mm/mmu_gather.c             | 296 ++++++++++++++++++++++++++++++++++++
>>   5 files changed, 408 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/s390/include/asm/tlb.h b/arch/s390/include/asm/tlb.h
>> index e95b2c8081eb..3f681f63390f
>> --- a/arch/s390/include/asm/tlb.h
>> +++ b/arch/s390/include/asm/tlb.h
>> @@ -28,6 +28,8 @@ static inline bool __tlb_remove_page_size(struct 
>> mmu_gather *tlb,
>>           struct page *page, bool delay_rmap, int page_size);
>>   static inline bool __tlb_remove_folio_pages(struct mmu_gather *tlb,
>>           struct page *page, unsigned int nr_pages, bool delay_rmap);
>> +static inline bool __tlb_remove_swap_entries(struct mmu_gather *tlb,
>> +        swp_entry_t entry, int nr);
>
>
> The problem I am having is that swap entries don't have any 
> intersection with the TLB. It sounds like we're squeezing something 
> into an existing concept (MMU gather) that just doesn't belong in there.
I referred to the mechanism of batch release in tlb, and perhaps a new
structure needs to be created to implement this feature.

Thanks
Zhiguo


