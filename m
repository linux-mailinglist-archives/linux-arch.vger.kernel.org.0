Return-Path: <linux-arch+bounces-5936-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05105945F8C
	for <lists+linux-arch@lfdr.de>; Fri,  2 Aug 2024 16:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79C071F2196E
	for <lists+linux-arch@lfdr.de>; Fri,  2 Aug 2024 14:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76271210196;
	Fri,  2 Aug 2024 14:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="BzmMAruz"
X-Original-To: linux-arch@vger.kernel.org
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010063.outbound.protection.outlook.com [52.101.128.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B185A1171C;
	Fri,  2 Aug 2024 14:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722609770; cv=fail; b=BEbYMEovWcQZFhv5f+PJ21rDZ18zh3whv6Mfnd4ibg9VuxqLf+U0guwCY4iFPxDOvcKk32kXQqy5WTHbrWO+N2Kl44P6SvsFQvl4j3dSKIpruXBXsIa7qTmdOk94xIKC6WzKfapH6F5i8AyR79Wz1tTHwhT1RaA7T15AB0qEul0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722609770; c=relaxed/simple;
	bh=jTGLYScezhSozAxNBGHeL91bTCZvbX/JPVB783YDy4I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=o2LJvQ3z81B4FSI5do1WwqUslHWvx50jXaeyeqPbpNRinZcmb4crD0QZvRev0SXrYZfQR866J0MAQ+l8OSUXgdwQY6mlxeRLa6gh019fURPq8PoyZ4Ib1nvzhU53ulPBpjRE73Bw5NEPVolhcIRZMDmSDNEHJCH6gn5F/TmCIig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=BzmMAruz; arc=fail smtp.client-ip=52.101.128.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RejzHdXwB90q1YxhzrgYwxklDJvsU5LYyLznb8TN0pdpU71ypMyo2L0MbpSBpNxs0FANQkTHQyGpPik9EsrToKMlDHEofwOcKRiJ69Uy28qghMd6On5fTXPZgAa4CUTN5zbvdLdl/qdXWTrprK/EgTnjMvLg+7u4uPNozTN178VzGxNjP21oz/bVCW+f00MckMD9FZWi6YhKEgfNI0bxvn6e4L+8D6g9aIUsK+TB3zl3tqoJk/65W1AxIiXQ6hmQRy1MtgpGwE0iqyvQ9jf/sQEANUkgyt85nCpd3m3f+1+vhwLRFO4+ulURxmTCRW+XdpZS2nWrDJL6FCE0YvI3Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NRehNtetmdxX211PvBoYMqkwuRteDBd4/sGFAoh3bnU=;
 b=ZfLb8RFBVMCmdYpV7Bf5e8L7a4QUqrw3/VroqtgiRnRhVvi1fGdNdJf2Tt4QbwgE3vu5/IBb3/FvRT9BHBTC/jBruWIW66I9Cr5w3Q0DQkHbMUWpK+L55Uue95XRaZiEOscFYvqi9E3UnqmeyQgI29MkCKcZ7yo6SLdeuUP3TZ/R6UHryZGBTr/Cr7RDtlYsc4Bw6BClXDHQexK2aX8csI3bsu7l4+/+P0ArAzSX6MQza7iF5yxWZUD8V/ZB5H+lgwRCZHfUeJqIQu4kZRAm3Lun1ovlJlfqaUxurMqVpVnMjEGdj7ND59mm+VfQvQw0R8vEVDz9epF4fRErM9SIjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NRehNtetmdxX211PvBoYMqkwuRteDBd4/sGFAoh3bnU=;
 b=BzmMAruzlbD/CIoIR0WGCd7SnsoPdoCArEECsEGJ2OZJtv3vRU2Nqz9nwbsWG4fzmPmVEJUvPrf0icX4SY2Ky8hiROMheEmYmNGlcBqlFOEQBFGhc0qHWwMCfqt0HWv5pAyjnQ8guD1/KpHSbtbz7T+emPn8hfirK7AKSWq2cm7wyTmIcjI0GCL+trJQiAENEnsY4/JyIYithh58yT/w92JZMjDed1ZgjuzF2/lFLRF4gw6nyspl8XRQwy+6ItNI+123Fa1z8BpTSIF5ULNmGrrAHqdbkW5PpfGEC253JXZSpuqiozwk2QKYP7RP3nfu4FVlywdYKS2nOu47Z1oYsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by SEYPR06MB6505.apcprd06.prod.outlook.com (2603:1096:101:16c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Fri, 2 Aug
 2024 14:42:43 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed%3]) with mapi id 15.20.7828.023; Fri, 2 Aug 2024
 14:42:42 +0000
Message-ID: <2bb5f502-5274-4e4d-9fb3-4c774a3ba424@vivo.com>
Date: Fri, 2 Aug 2024 22:42:41 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] mm: tlb swap entries batch async release
To: Barry Song <21cnbao@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin
 <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
 Arnd Bergmann <arnd@arndb.de>, Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 linux-arch@vger.kernel.org, cgroups@vger.kernel.org,
 kernel test robot <lkp@intel.com>, opensource.kernel@vivo.com
References: <20240731133318.527-1-justinjiang@vivo.com>
 <20240731091715.b78969467c002fa3a120e034@linux-foundation.org>
 <dbead7ca-e9a4-4ee8-9247-4e1ba9f6695c@vivo.com>
 <CAGsJ_4xv--92w+hOVWtMtYK-0TsR6z67xiHEXCvuRNvXx71b2A@mail.gmail.com>
 <820dfff4-1f09-474e-aa68-30d779a72fed@vivo.com>
 <CAGsJ_4xV3010jJ1o_zLw9_rcpTHRR4vd+N_4FF7_9NezT7Ezpg@mail.gmail.com>
From: zhiguojiang <justinjiang@vivo.com>
In-Reply-To: <CAGsJ_4xV3010jJ1o_zLw9_rcpTHRR4vd+N_4FF7_9NezT7Ezpg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGXP274CA0024.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::36)
 To JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|SEYPR06MB6505:EE_
X-MS-Office365-Filtering-Correlation-Id: 9338a98e-48ce-4a94-1669-08dcb3015da8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|43062017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MzRGZ2NjRERFblg2RGRiaGowcko1bG5qanIyU3pTM2VoME9FU2ZRaFV5QzZE?=
 =?utf-8?B?Q2RrbHBuSENPb1RSMEFOcllEU1VpNFFlb2MyclhLMGZrSUljUFNCR1EyODZn?=
 =?utf-8?B?d25XclZOZWF1b2RReXNlZGxDZUtuWXgxVHhNQ05iRmdYSHIxeXJEVGlMTHJY?=
 =?utf-8?B?TzkwY1I4a2xrczNSN3FFak1RcTkrbDlEeS83dkphSU5wK0diK1NndHMrSCtN?=
 =?utf-8?B?bUdhNnZHblpVOTJrTjUyT2hrejFzaFhvZ2tOblhlam96YWs2Y3pLM240ZmtR?=
 =?utf-8?B?aU8zOXdvZ0Q5SkVYYVZuemZMb2ZWK25jMVgyUmNEWWowVUlqN1N2QU5LeHA4?=
 =?utf-8?B?V3V3NktPR0ZqS0RKU0FxODU4emp5OXVJbm5CdXYwdXpTdkxXdGV0Q0RuM0x3?=
 =?utf-8?B?ZUpscmtUYlhYa2hwUzhGK2FsZU5ZM202R3M2OFhXN0J0Slc0UGRiMHNpSUR0?=
 =?utf-8?B?b0Z2NzBpcmxvb2xvMkhobjJjWVh2c0t4emVidzBpZnFobFI4aGNsaVB2K0o5?=
 =?utf-8?B?QmRoYVdaaUMyNVpmM0U4WU9ydDM2RHFmcnpEd0MvSnRDS3BxSzZScklseHZh?=
 =?utf-8?B?RklXb2l5UnJXZWtrdVhad3Rhbk9yN1hRTE9adEMwK2VnblVnTFZRMGNhUWxn?=
 =?utf-8?B?V3NBS0hZMW12NHZqWC9GRDVmWVFibzhIbGN6aXlpdUVWWTk2R2lkZWRrSlc4?=
 =?utf-8?B?Q3VYMUJzN0dOWGMwblh4R0l5UWtmdkUvbmNPMytiaU13UDVQQ0VHSmc3Z1Rz?=
 =?utf-8?B?ZEV2ZXp1QW41Vi9DRVIzb0pWWjVESjJZZzR6WjhtS1ZQK2I1ZWFDQlpOdXcy?=
 =?utf-8?B?aU0wR1A1Mk03U2E0Q0ZsZzFJd2lGUDkyekl1SUtGNTdtT3pvQVFqVHdKMVVT?=
 =?utf-8?B?d2FvY1lZWlcxbkhnNHI5YXFOaWdyL1kwN2xqNTZXbWIvNmtKM1lCRHJGQ25B?=
 =?utf-8?B?VGZQNmx4Y3V1WHJSM3JyTG11OFVRWGVFZTN6Nmw3ZG9McW4wWklwbkV1WGVJ?=
 =?utf-8?B?UFZzTm51dk40WXlRVHV1b1hES09wT1h6RW9XaGx0Y2JtbUtjYnpvTkh4dVZx?=
 =?utf-8?B?cTBxTFFoemZ3aVFORFdGQ2pXOE5iZ3JobWQ2dHlVeU1KenFNa1VHNFBHMktu?=
 =?utf-8?B?RDFlMVg3cnljVmVCNDlEL3cxdXI1alV0NWgreVBIVVhCRllQdGVmUCtWUjZZ?=
 =?utf-8?B?ZjFxWlI4d3RuaWs5MVpjeVh2cnFtbFdsRTc3ejVuYnhVOTVMeTN2ZHcrM2dX?=
 =?utf-8?B?dHBSMmlsNURBZ3pSdFgwUGxkWElKQUhsRmpPeGY0dFZmWWg4TFFTMDI2YURR?=
 =?utf-8?B?MGNLOGRxdFJkL3g0WUw2b2hFNUxWdlhzQWdmQWgzUVZBK01wMWJ2OFI0YkdV?=
 =?utf-8?B?U1BjRHpMZ3Vpa2ZFTlhNYW5TZE43THJHMWZkcnNNSmJsMS80SUNXREtuSU0w?=
 =?utf-8?B?Qk12cFA5V0txUnpmZjVTYzEzN3BxTzZPM09OSVYxOU9NSG1aU3IrU093OHJN?=
 =?utf-8?B?N3R3OGR4eXhuN3g1NW9oV0g5TWlrTnhXd1Arc2dDdzAwVitSSW9YOW9uK1Jn?=
 =?utf-8?B?eUxBSW95R2FMNlRCMEpnbmR1eXhubGE0a0lKU08vb1hEUzZOSTcxdHF1NHFy?=
 =?utf-8?B?bFQyS013QXJ2cEpFWENBUkhDRVMwQjRLSnc2ZWFIQkEvYTRaR2QrTnJLb1BF?=
 =?utf-8?B?KzBDL0RtUHNEb21ZWGpFc0ZnNkhJWGhESi9jRURITUJYZnhDbHlaZWZNajJi?=
 =?utf-8?B?REJxcTk0UWhQckRDa2pGNXBDWmNlcS9MN0k5eHJCKy9HYytYZlU3Z055ODZF?=
 =?utf-8?B?Uk1vTTV1UHp6OC9oZitycFJ6bkozTVlqUDljTVJuRWxVejg1MkhDblIwZGZF?=
 =?utf-8?B?Zm9QdmovVGlYcHRZWDR0KzZsTElUbmFDNUFWcHdkbVRsOWc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(43062017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?elpmby9CcjQwa0xIcm1iWXpFYThQeXpRaEYzb2RjSnE4RURxa3BLWFlrTCth?=
 =?utf-8?B?SHQ2U3pLNnlSeHl0QWk1WlVRcEh5OE9tbVhvbUhlTE9Pckw0dzc0RzludHha?=
 =?utf-8?B?NFpOa3dyOEZnejk5MVh6SmJNaEhWMWtXc2dPZUJMNTFXSVlmM0l2SERnYy9G?=
 =?utf-8?B?bE9SRytCaUtVNmhqaG9OTG1scjNaOUN6OWcvVzhiN2h6TDAyKzh5MjdEVk9v?=
 =?utf-8?B?emJEZXlmQXp6djlpU2dJdXcrdUpjZ0NpTFNHZnFsbUFnMUVxcHJseVM5M0NL?=
 =?utf-8?B?TnB1NHZ5QVlBSEkraHYrcENmazlxYXB1cTdlS3ZDdGpIOVQ2SC9RaWZwdmRr?=
 =?utf-8?B?eHRWaTBuUmdSbjFCbVlPTG9rSVNOR3d3WjNOS1dkTnVkTzQzb1JzdjBVV0kz?=
 =?utf-8?B?UUM4bjV6Rk8yNzUzWkczbUFTb0ZsK0FKWkxqZkNsWlNzd2FZWWlEa05WS3Vo?=
 =?utf-8?B?ZWxjY2ZRQkNVdjVNZE1oREFORGVRMHBEdXZMK2lia3V1QmZVa2p1WlgrZ2cy?=
 =?utf-8?B?cGtxYVlyRkhlUFdXVlRnVW4xUW0wTjVtRCtncXRPV3dybVdiNU1UTVZxRjdH?=
 =?utf-8?B?QXZid2hBYXhDZVp0RjdmeHhnWktpTE80aHYrODl4Q3R1N2tSQjNFYWNFcGNw?=
 =?utf-8?B?UUsrSEs3Q2VRdlUxRGg4c0xYeitwNGpEMHRQWFR3ak1udzJVdDArTjhiTDRm?=
 =?utf-8?B?TGhNLzFNTGhBekRpTDhDeXFQb29MREdGWTRlcUtzNWxCSTVtUnJYZGRzbnVt?=
 =?utf-8?B?bTVkRURobG95TG14QkFIZUlUbnNNZjRJVFVwSWhPc2ZiWDlIVitHVFovdXAv?=
 =?utf-8?B?Z2RZQWFlYnpGZGFDSjhIS2dJcmdHUzJqdTRjeHpHdTRvL25vTlBuQnBQZkRm?=
 =?utf-8?B?Q1VHdGZaT2tFM2hJR09ZY2hnc2YyS043VktvdFErMExhZHROKy8yVFNHYVpv?=
 =?utf-8?B?Y0F2WDRPalpPSTZlUDlXVUd5c2VzYm5OMGRKUjlmdEFjbjZtMVRsUjZOZ25W?=
 =?utf-8?B?ZWRaV0VYa2xtSXU0dDJnOHc3SzRWR1BpL1dTbGU1bVUzWlluNE0yUUdxL2hV?=
 =?utf-8?B?TVNXR0FNY2RLM3ZSemhtRy9lY1Urd2JRN0l4OUNyanMvenpWa3lmbXlhVzBG?=
 =?utf-8?B?R3huY2UwL0NLZUc2UVkvVTFpVjBXS3RoMzlIZGVRNmJsb3ZWZUcreG81cEF1?=
 =?utf-8?B?Z0JIS2oxcm4rS2hEN1VhOFJ0OFFzTzdaM1R0WDJKai8xQW5TSGE3WkExaWpl?=
 =?utf-8?B?NlE3YUVkeG9KN090N1UycmltUnoxMTVJMzZKeXVycmJ4UjFSQWIvNVY2b0No?=
 =?utf-8?B?d0ZVSjlTdGJUdTFPUGUwbGlnTkpnRkR3dk5YV3oycXA0TmlIdmtzbnJ6SFNY?=
 =?utf-8?B?SUdqUzl5R2JXNDJiL0lvSVNXck84UFlZUTZMY0Z4dUx5MTBGVmJ3clMrQW0w?=
 =?utf-8?B?K0xjdXR1QUx5eHZ6R3dmQ3RMeHcvY2JlMVZDaWlCM2VISVNnbXBVVVE5WnBN?=
 =?utf-8?B?eWdBdGh1TVBraEU2NVR1SW45anJCWVdDd2hYTEwrS1lRMDcrNEpwWUxNaDVQ?=
 =?utf-8?B?cTdnbWdJQ1RYSlowMlEvQnZTRGIwaXpjT3NhSUVUT3NKWTJjVDdralBzYk90?=
 =?utf-8?B?SnBQY2kwL2JwcFZzL3EvK3gyVTdGeFVRVXkwcFBCUldMcXFpODFPbS9xQkVz?=
 =?utf-8?B?OEhJd05IQU5PUWdJeXZrYytETmcxN0hCSnpzcFUwU1RIY2k2dFU1RkdwcDR1?=
 =?utf-8?B?WmxPeFpJQ1Q4TU4zYXMzRS9WUjFQUEk4QTlBZWpTa1pidWpYbmJ0TGMwTUVr?=
 =?utf-8?B?blFtVlo5UlNiQWg4R2FjRVpqVmxRRjVXNHJZWG96SytrRHNQT0JJKzc4Q0NX?=
 =?utf-8?B?NFJLcG4zZXlFZS90WS9VZGdMVXZSOXBBdlVyVVNDYklXR1hzY2Rqd0VQS2xz?=
 =?utf-8?B?OXVnSDF3U2tLYSt2cWRkNGpuZFRIQVZBSEJLbmtOR3h0UU1XSnpFQSsvMi9l?=
 =?utf-8?B?Q0RMbGxCVVhFQ0k2QStGWTZIZTN2SUJVNjQ1MXFibnRjZ3c0dU1yalhqZzdj?=
 =?utf-8?B?UGo5eFFSSWh0N0k4TnNkb0NoZTJTbERHWDVwVGhrREtZNFpYTDAxMWpPc0F4?=
 =?utf-8?Q?7l8Zqk3oqS+f0gK/6El8rrj67?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9338a98e-48ce-4a94-1669-08dcb3015da8
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2024 14:42:42.8427
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xnlvWr8+te/aEAaRMkPSMPnWyEE1O/Qo4/spcPFHOvEbaMuXjMyxFfiqlBOOP8bKMnun7YD8+curElfOAb+HZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6505



在 2024/8/2 18:42, Barry Song 写道:
> On Thu, Aug 1, 2024 at 10:33 PM zhiguojiang <justinjiang@vivo.com> wrote:
>>
>>
>> 在 2024/8/1 15:36, Barry Song 写道:
>>> On Thu, Aug 1, 2024 at 2:31 PM zhiguojiang <justinjiang@vivo.com> wrote:
>>>> 在 2024/8/1 0:17, Andrew Morton 写道:
>>>>> [Some people who received this message don't often get email from akpm@linux-foundation.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>>>>>
>>>>> On Wed, 31 Jul 2024 21:33:14 +0800 Zhiguo Jiang <justinjiang@vivo.com> wrote:
>>>>>
>>>>>> The main reasons for the prolonged exit of a background process is the
>>>>> The kernel really doesn't have a concept of a "background process".
>>>>> It's a userspace concept - perhaps "the parent process isn't waiting on
>>>>> this process via wait()".
>>>>>
>>>>> I assume here you're referring to an Android userspace concept?  I
>>>>> expect that when Android "backgrounds" a process, it does lots of
>>>>> things to that process.  Perhaps scheduling priority, perhaps
>>>>> alteration of various MM tunables, etc.
>>>>>
>>>>> So rather than referring to "backgrounding" it would be better to
>>>>> identify what tuning alterations are made to such processes to bring
>>>>> about this behavior.
>>>> Hi Andrew Morton,
>>>>
>>>> Thank you for your review and comments.
>>>>
>>>> You are right. The "background process" here refers to the process
>>>> corresponding to an Android application switched to the background.
>>>> In fact, this patch is applicable to any exiting process.
>>>>
>>>> The further explaination the concept of "multiple exiting processes",
>>>> is that it refers to different processes owning independent mm rather
>>>> than sharing the same mm.
>>>>
>>>> I will use "mm" to describe process instead of "background" in next
>>>> version.
>>>>>> time-consuming release of its swap entries. The proportion of swap memory
>>>>>> occupied by the background process increases with its duration in the
>>>>>> background, and after a period of time, this value can reach 60% or more.
>>>>> Again, what is it about the tuning of such processes which causes this
>>>>> behavior?
>>>> When system is low memory, memory recycling will be trigged, where
>>>> anonymous folios in the process will be continuously reclaimed, resulting
>>>> in an increase of swap entries occupies by this process. So when the
>>>> process is killed, it takes more time to release it's swap entries over
>>>> time.
>>>>
>>>> Testing datas of process occuping different physical memory sizes at
>>>> different time points:
>>>> Testing Platform: 8GB RAM
>>>> Testing procedure:
>>>> After booting up, start 15 processes first, and then observe the
>>>> physical memory size occupied by the last launched process at
>>>> different time points.
>>>>
>>>> Example:
>>>> The process launched last: com.qiyi.video
>>>> |  memory type  |  0min  |  1min  | BG 5min | BG 10min | BG 15min |
>>>> -------------------------------------------------------------------
>>>> |     VmRSS(KB) | 453832 | 252300 |  204364 |   199944 |  199748  |
>>>> |   RssAnon(KB) | 247348 |  99296 |   71268 |    67808 |   67660  |
>>>> |   RssFile(KB) | 205536 | 152020 |  132144 |   131184 |  131136  |
>>>> |  RssShmem(KB) |   1048 |    984 |     952 |     952  |     952  |
>>>> |    VmSwap(KB) | 202692 | 334852 |  362880 |   366340 |  366488  |
>>>> | Swap ratio(%) | 30.87% | 57.03% |  63.97% |   64.69% |  64.72%  |
>>>> min - minute.
>>>>
>>>> Based on the above datas, we can know that the swap ratio occupied by
>>>> the process gradually increases over time.
>>> If I understand correctly, during zap_pte_range(), if 64.72% of the anonymous
>>> pages are actually swapped out, you end up zapping 100 PTEs but only freeing
>>> 36.28 pages of memory. By doing this asynchronously, you prevent the
>>> swap_release operation from blocking the process of zapping normal
>>> PTEs that are mapping to memory.
>>>
>>> Could you provide data showing the improvements after implementing
>>> asynchronous freeing of swap entries?
>> Hi Barry,
>>
>> Your understanding is correct. From the perspective of the benefits of
>> releasing the physical memory occupied by the exiting process, an
>> asynchronous kworker releasing swap entries can indeed accelerate
>> the exiting process to release its pte_present memory (e.g. file and
>> anonymous folio) faster.
>>
>> In addition, from the perspective of CPU resources, for scenarios where
>> multiple exiting processes are running simultaneously, an asynchronous
>> kworker instead of multiple exiting processes is used to release swap
>> entries can release more CPU core resources for the current non-exiting
>> and important processes to use, thereby improving the user experience
>> of the current non-exiting and important processes. I think this is the
>> main contribution of this modification.
>>
>> Example:
>> When there are multiple processes and the system memory is low, if
>> the camera processes are started at this time, it will trigger the
>> instantaneous killing of many processes because the camera processes
>> need to alloc a large amount of memory, resulting in multiple exiting
>> processes running simultaneously. These exiting processes will compete
>> with the current camera processes for CPU resources, and the release of
>> physical memory occupied by multiple exiting processes due to scheduling
>> is slow, ultimately affecting the slow execution of the camera process.
>>
>> By using this optimization modification, multiple exiting processes can
>> quickly exit, freeing up their CPU resources and physical memory of
>> pte_preset, improving the running speed of camera processes.
>>
>> Testing Platform: 8GB RAM
>> Testing procedure:
>> After restarting the machine, start 15 app processes first, and then
>> start the camera app processes, we monitor the cold start and preview
>> time datas of the camera app processes.
>>
>> Test datas of camera processes cold start time (unit: millisecond):
>> |  seq   |   1  |   2  |   3  |   4  |   5  |   6  | average |
>> | before | 1498 | 1476 | 1741 | 1337 | 1367 | 1655 |   1512  |
>> | after  | 1396 | 1107 | 1136 | 1178 | 1071 | 1339 |   1204  |
>>
>> Test datas of camera processes preview time (unit: millisecond):
>> |  seq   |   1  |   2  |   3  |   4  |   5  |   6  | average |
>> | before |  267 |  402 |  504 |  513 |  161 |  265 |   352   |
>> | after  |  188 |  223 |  301 |  203 |  162 |  154 |   205   |
>>
>> Base on the average of the six sets of test datas above, we can see that
>> the benefit datas of the modified patch:
>> 1. The cold start time of camera app processes has reduced by about 20%.
>> 2. The preview time of camera app processes has reduced by about 42%.
> This sounds quite promising. I understand that asynchronous releasing
> of swap entries can help killed processes free memory more quickly,
> allowing your camera app to access it faster. However, I’m unsure
> about the impact of swap-related lock contention. My intuition is that
> it might not be significant, given that the cluster uses a single lock
> and its relatively small size helps distribute the swap locks.
>
> Anyway, I’m very interested in your patchset and can certainly
> appreciate its benefits from my own experience working on phones. I’m
> quite busy with other issues at the moment, but I hope to provide you
> with detailed comments in about two weeks.
>
>>>>>> Additionally, the relatively lengthy path for releasing swap entries
>>>>>> further contributes to the longer time required for the background process
>>>>>> to release its swap entries.
>>>>>>
>>>>>> In the multiple background applications scenario, when launching a large
>>>>>> memory application such as a camera, system may enter a low memory state,
>>>>>> which will triggers the killing of multiple background processes at the
>>>>>> same time. Due to multiple exiting processes occupying multiple CPUs for
>>>>>> concurrent execution, the current foreground application's CPU resources
>>>>>> are tight and may cause issues such as lagging.
>>>>>>
>>>>>> To solve this problem, we have introduced the multiple exiting process
>>>>>> asynchronous swap memory release mechanism, which isolates and caches
>>>>>> swap entries occupied by multiple exit processes, and hands them over
>>>>>> to an asynchronous kworker to complete the release. This allows the
>>>>>> exiting processes to complete quickly and release CPU resources. We have
>>>>>> validated this modification on the products and achieved the expected
>>>>>> benefits.
>>>>> Dumb question: why can't this be done in userspace?  The exiting
>>>>> process does fork/exit and lets the child do all this asynchronous freeing?
>>>> The logic optimization for kernel releasing swap entries cannot be
>>>> implemented in userspace. The multiple exiting processes here own
>>>> their independent mm, rather than parent and child processes share the
>>>> same mm. Therefore, when the kernel executes multiple exiting process
>>>> simultaneously, they will definitely occupy multiple CPU core resources
>>>> to complete it.
>>>>>> It offers several benefits:
>>>>>> 1. Alleviate the high system cpu load caused by multiple exiting
>>>>>>       processes running simultaneously.
>>>>>> 2. Reduce lock competition in swap entry free path by an asynchronous
>>>>>>       kworker instead of multiple exiting processes parallel execution.
>>>>> Why is lock contention reduced?  The same amount of work needs to be
>>>>> done.
>>>> When multiple CPU cores run to release the different swap entries belong
>>>> to different exiting processes simultaneously, cluster lock or swapinfo
>>>> lock may encounter lock contention issues, and while an asynchronous
>>>> kworker that only occupies one CPU core is used to complete this work,
>>>> it can reduce the probability of lock contention and free up the
>>>> remaining CPU core resources for other non-exiting processes to use.
>>>>>> 3. Release memory occupied by exiting processes more efficiently.
>>>>> Probably it's slightly less efficient.
>>>> We observed that using an asynchronous kworker can result in more free
>>>> memory earlier. When multiple processes exit simultaneously, due to CPU
>>>> core resources competition, these exiting processes remain in a
>>>> runnable state for a long time and cannot release their occupied memory
>>>> resources timely.
>>>>> There are potential problems with this approach of passing work to a
>>>>> kernel thread:
>>>>>
>>>>> - The process will exit while its resources are still allocated.  But
>>>>>      its parent process assumes those resources are now all freed and the
>>>>>      parent process then proceeds to allocate resources.  This results in
>>>>>      a time period where peak resource consumption is higher than it was
>>>>>      before such a change.
>>>> - I don't think this modification will cause such a problem. Perhaps I
>>>>      haven't fully understood your meaning yet. Can you give me a specific
>>>>      example?
>>> Normally, after completing zap_pte_range, your swap slots are returned to
>>> the swap file, except for a few slot caches. However, with the asynchronous
>>> approach, it means that even after your process has completely exited,
>>>    some swap slots might still not be released to the system. This could
>>> potentially starve other processes waiting for swap slots to perform
>>> swap-outs. I assume this isn't a critical issue for you because, in the
>>> case of killing processes, freeing up memory is more important than
>>> releasing swap entries?
>>    I did not encounter issues caused by the slow release of swap entries
>> by asynchronous kworker during our testing. Normally, asynchronous
>> kworker can also release cached swap entries in a short period of time.
>> Of course, if the system allows, it is necessary to increase the running
>> priority of the asynchronous kworker appropriately in order to release
>> swap entries faster, which is also beneficial for the system.
>>
>> The swap-out datas for swap entries is also compressed and stored in the
>> zram memory space, so it is relatively important to release the zram
>> memory space corresponding to swap entries as soon as possible.
Thank you for your attention and look forward to your reply.

You are correct, it might not be significant for cluster lock contention
due to its relatively small size of entries. However, asynchronous
kworker should have some benefits for swapinfo lock contention, because
when multiple exiting processes release their respective entries at the
same time, there will have swapinfo lock contention issue in the
swapcache_free_entries().
>>>>> - If all CPUs are running in userspace with realtime policy
>>>>>      (SCHED_FIFO, for example) then the kworker thread will not run,
>>>>>      indefinitely.
>>>> - In my clumsy understanding, the execution priority of kernel threads
>>>>      should not be lower than that of the exiting process, and the
>>>>      asynchronous kworker execution should only be triggered when the
>>>>      process exits. The exiting process should not be set to SCHED_LFO,
>>>>      so when the exiting process is executed, the asynchronous kworker
>>>>      should also have opportunity to get timely execution.
>>>>> - Work which should have been accounted to the exiting process will
>>>>>      instead go unaccounted.
>>>> - You are right, the statistics of process exit time may no longer be
>>>>      complete.
>>>>> So please fully address all these potential issues.
>>>> Thanks
>>>> Zhiguo
> Thanks
> Barry
Thanks
Zhiguo


