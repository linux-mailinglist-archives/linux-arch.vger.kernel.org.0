Return-Path: <linux-arch+bounces-7000-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0816796BA93
	for <lists+linux-arch@lfdr.de>; Wed,  4 Sep 2024 13:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 471C31F25204
	for <lists+linux-arch@lfdr.de>; Wed,  4 Sep 2024 11:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE5F1D0DCF;
	Wed,  4 Sep 2024 11:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="ZXFf+Ywu"
X-Original-To: linux-arch@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2083.outbound.protection.outlook.com [40.107.117.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E03B1CF2AB;
	Wed,  4 Sep 2024 11:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725449182; cv=fail; b=X4MnB0acVKXmBbsqU62XqKRJZhKOwZ28gr5JMIbmWbE6xbNkPb5vbCwpm0KVgbv+jjD6wCrR3FUBo3p39UivJxylYP50vDcmMBWAGo3W7hv7/3WLs0IakUCtrND+kfynk8qQk1UGuT2q9x4/mDHflPQTfP8ds8ycBsx2IFE1Mgo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725449182; c=relaxed/simple;
	bh=6ZXTN1IWqzm/ssL/DdmnewQGEm4HUBg3FqjZtRQrjVY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=J2AjlPSHeNKqdtKaHi0dbhYxMVF2S7E64HI0o1inc2K0/8xz1Ea3uxzdCTvhxPBUKjrVduevBOHs3cXUzkV9+jetXI4GVD0mqRWpUxcSA+7drdTN1+xlDaYlrZksnbF+aea6eDKWBnoq0H/4NpUJCjgOVgxKb+RNkt1mCmt/wSs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=ZXFf+Ywu; arc=fail smtp.client-ip=40.107.117.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iRcM+ARTby214cuJSBWgDcIDRFKHzXLVy5HSVE/x1tXX76bhqGXBYsST9KC6q+WW4A9NqrHyXjh6ur9i5vFpL6fiEQbC6an5eFliFW1BwiLDu0E+Qck1WEmrUhoLFF3gKw4mxIPWzjpFpSK7s0kYI7FKS0FJZqx5tdWVPrnGVY0AsVXYJ+inxJIvzteqY36jLlMGRDaBDHKrlbYXHnnEYZEblz779vb/pTLXMZqgB17kLx4rwVdTTqxETYF66txiDCLJCJaiHrv1uEMpJMuXPPXYHD2E65vIo/7Fj4J/lPw9m8Gn+QrZ9MjXzGMwqo9M/oXj/ZC6xj0K5tzzGlQWkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HP+qlEj22Z/TDDU9i6UKTd3VxMNfjjwf5UEjzsyDxzc=;
 b=b5bHXKryVA+kGDmOuN/IxOU4LO3WeDATDqbSgz+Ryz/GgkX1QsclD9jphAARK0rbkMGdXfo2+oeijOJyQKclOp7JRGHmAsEjduAeY5xpOQY9c4LyLPgot1J68obDd2k0COmS3qwyGxhqSPHJM1Gv29fOWojjeMiC23MqjBSnFZrtkY5SKemRd6O+DjAKO8Nhrmc7wWkYXBQL/Q8ixaaFalLonsyaYviQuancLFhf6l08Kqb/OEscQWhN2P/zeN9uNOnytb2+6N+YBXC8PZo0su+IFVlCl35StQgKhmq5dyEIjv/yEVmaDfoqyimq7GJPTPEfyMhmJzMgQr5Gwk/Hcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HP+qlEj22Z/TDDU9i6UKTd3VxMNfjjwf5UEjzsyDxzc=;
 b=ZXFf+YwuCy8N3wyvZuhvs+jjuXkdkntfO/yiDVvl9sUxUIRTWYAgRmZEqp9lLlC34OfnH4ZyBsJOlnx8rwmInlHLIA/gBNFF+17sRYPbzl0F4G9I/5uj7cEaUS/bxu/KMqPT98BAhDelj8uL2RGnqfd96rflGJJLXyoPA84egsYU+LtWlp37HpmxdgdBTKAdfn97PRLYu0BEAERGGIspSKg22Ev/9PKXu/vUoINg+0uq7Uz+5EVS82wnOQdn9meO0sC4f8nyTqb/NgpS+nsodDLX0wMdwaeMFaYIEPH2ApuxYz+thRwr0GxaG/zW79dN+EPnkqtCJk20T6hklUYDnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by KL1PR06MB7085.apcprd06.prod.outlook.com (2603:1096:820:120::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Wed, 4 Sep
 2024 11:26:15 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed%3]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 11:26:15 +0000
Message-ID: <400918d7-aaaf-4ccc-af8e-ab48576746d1@vivo.com>
Date: Wed, 4 Sep 2024 19:26:11 +0800
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
From: zhiguojiang <justinjiang@vivo.com>
In-Reply-To: <CAGsJ_4zXtJvBdgpDs+yyEwfdJ0gy+_dgrWLF1zxMgBbaLBeiYA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0134.apcprd02.prod.outlook.com
 (2603:1096:4:188::14) To JH0PR06MB6849.apcprd06.prod.outlook.com
 (2603:1096:990:47::12)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|KL1PR06MB7085:EE_
X-MS-Office365-Filtering-Correlation-Id: e7ecea5d-01c1-4a0c-4647-08dcccd4639f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|43062017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?blNQZnZtbDhaUzd0UEJKdzNpd0doQThkZDlEcGQ2MnI3MmFHRkVTbEVtNHQ5?=
 =?utf-8?B?TG1iVUhUbDRmWExnYTJscHliUG1iU3RZdldDQzF1SWw3Uk4xV1ZlZ2xYWXNC?=
 =?utf-8?B?VHBCTGQ3cGs0cDRMRW5nQlg4STJWQWN0UnF0SmpRa3JaUzFZVG1Gc2Zyb3VJ?=
 =?utf-8?B?MFdDZHgwN1l2dVVzTXUwbW45aHR5T0FrYnltbzhpaHNKN29XVHdJNjNUZzNY?=
 =?utf-8?B?dU1uQS93aVUrK2QvbzZ1M3h4WGsvcFBkK3ZnVWphRlFwU2FkRXNnc0Z2cE9D?=
 =?utf-8?B?d1ZYTVk0c2pHUFh1Rmt0ZWp1Q3Q2TGlRVmF6ZXdvdUlIbERuOFJtRlJDbzhE?=
 =?utf-8?B?VzFGcStuRnFVRCs3U3JsYnd4VUpnaWRBZWZ2QlZYRk5sa3g4ZVF0YmtEMFB0?=
 =?utf-8?B?QS8vcDR3QzBrYnN3bkxqUEZNOW5pT1ltQWNyY3lzb21LNDJETEg0TzU1cVRR?=
 =?utf-8?B?clczd0RVNDJod21HWHZFRFczUzlITWRLT25Bbk43R09jeVdUUHVQUDRPZDB4?=
 =?utf-8?B?VHE0THNyam9CZU1hS0xieW9YWmRaV3UzY0JMa2E0MWpwWlY5V2JOMWVpc3FG?=
 =?utf-8?B?SHp2ODVzUlV4dVN5cDRJcDRwcnV1ZUFCRXAwSXhHZGtBVXh1QTZXZGpoWjV6?=
 =?utf-8?B?bnFrdlIyM1lTS1FZMTdJdmlhMjBSYiswb09JRG5GTTVLU1pWamNvakRDaTAw?=
 =?utf-8?B?cVBTa2kvQjBkRWlkM1A0bFdIT2FIemVPUWszSGZCNE05bC8zaUNUb0VKYnYy?=
 =?utf-8?B?N01JUGpCV1ZRUGVPK0JaWTZYdGd6VzVzYnR3OVB6dFg2OGRQRy8reUpCSG5Q?=
 =?utf-8?B?MkI5YzVQb05xdzRnWlBHbU1KaDRlb2JrR2RrZG93WmlqMnphRjV5eTN3UVg2?=
 =?utf-8?B?YXgwTkxRcTcvMTF3ZEp4QW55YnoycTQ1UDc4Ky8vQ0lKcThVekYvNThRc1RZ?=
 =?utf-8?B?TEdwQlhPRUhGQ3NrVEE3UjdXUk5TUm91UktKeFRvR1NqUE9jcHhKZ2JzL3F2?=
 =?utf-8?B?M09pajd6UlFyalIzTWd0R2tiVm5UTmQ2RWdTK0RYZ1o0K2U5L05oSnpuZ01D?=
 =?utf-8?B?U3FITGIzMFJTRm1zNjlpdWFwRjVBdlZxNzJCSkZOd3pjVzVCaW1QL2ZaOVlI?=
 =?utf-8?B?RnpBenlBVHpCdkJaR1Y5UHQ2RE4wR0dSUWVSRzZvYmFrS0JoQUxiZ3c4ZU5v?=
 =?utf-8?B?Z3M1NkFiUG95a3VPRjlaWGx5d0FtVXRldi9rMW9OaVhQOTFNeFkzdGoxVkt5?=
 =?utf-8?B?Qjh4d0NKNVFzWTdDS3NENTk2elNQbEFIeCtQM0hQSkRZUEp5TUtZTXdmKzFn?=
 =?utf-8?B?dE5ZVW5VcmZtQytFd1dFY3RGZjdqbG56TTVsRmsvSWZYaW5rc2FvTWEvL3oy?=
 =?utf-8?B?M1J6amtyMUtrZU0wZWE3dnFJK2lkQnY0NnBXUGJabzZiaG85emRpcVRQVncv?=
 =?utf-8?B?c0RhOElCQ1dEc0V4NUVGV0kxZ3cxSWxVMldhZXJHVjAwUElSUVRTZlZ2dzZO?=
 =?utf-8?B?RzdQMUUzVU4zdVM2YUVlRjA4VHg4UjVFL3JNRzJZelRJaDZTdTVTSmtSZENu?=
 =?utf-8?B?K3JUY1BQM2VjMmRqTHFOZ1ZKNExuL3NZaW5DbkswN2lqWVAxL0ppamdWUkV6?=
 =?utf-8?B?OGVLRmREYWd3Z0VNWGJJUXppT2JRaTNSanIxOUE2ek1nOHNZQjVrbDVlRDhs?=
 =?utf-8?B?blB4c0ZjODAvbGVVb2Vscy9KanpzUlhZTmE1WnRzR2VzTHNNRzVWTGhMVUZI?=
 =?utf-8?B?OFhFTzVkR1ZPQzFrWmF5bmpvYU5jVlN2S3hubTlWeGk0ZDFJMThOWHg1aDhF?=
 =?utf-8?B?TUxXWmJMcGJNMWdHMlc5bDNKQWRnRlA5cmlRSGVFMkdabllNYzFKVlpZL250?=
 =?utf-8?B?a1FXVTA2MTJvcHB6U2ZUWHJDZDNpTEQ0Z0pYZytwVC83L0E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(43062017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UENXYWEwUmJzRlE1T0VyWWRya29ZSUNqV1ZNTTFtMGpyNmNSVThmRUZRK0M3?=
 =?utf-8?B?Z0hObTJ5WUNOVkFhUkZRd0JSYjBCNzZmeXRxejM4K2hxaHRvdDVVT2g5MVh6?=
 =?utf-8?B?RzIvYWNxcUR1TXhOVmtqdkY0T3hOQzRJNGppT04xS1JkN0VGWjRYK1pXTDQ1?=
 =?utf-8?B?Y2dWWkF5dmtER2pZL1lMeUxRclZYNDhLTnkwSTdML1pCaGJaaktIRW44Z1Ar?=
 =?utf-8?B?MWNLL2JSd01sSkkyNDBNRy9IWDV4OUFicnZsL3BxWUdMZlRYS29JWSt2U21X?=
 =?utf-8?B?c3dYaVdBZ2lJRDhtNlh6UFdmZ1ROa2l5dWxHMnZoQ3RjL0c3dnhPdUVtTG1R?=
 =?utf-8?B?VHlvY01HK2F3dURYWGxMamR6RDIxYXhobnA2bVJpQWNnUzFLNk1EWS9ubmFL?=
 =?utf-8?B?V0VlNEFEZTgreWR2YzA1NlJrWkljTm5LUFYySEMxcVd2NTFEWU1ZLzQzTlNq?=
 =?utf-8?B?Sm12OE5zc1hCSEVBeGZZdlpBREI4eWJFUmtUOWswWTlocnVmRXBOZUh1eXcw?=
 =?utf-8?B?b1MyMW04dHJnb3licnc1NU54aFZhdzdNTmo3ZGY2Wm1NWnJOWVhkTWErUVFm?=
 =?utf-8?B?Z2E3QzI4Vkw2UG5DUGxJNENtbFBDNHh1Zi9NSkM5M01vTStRaTlVK0N4Rm5J?=
 =?utf-8?B?Ly9OY1I5SGZDZHdvRDFoRDF5dUMyN1Q4Q0g1bzc2NGFEKytlcDZ2UnRiVUt0?=
 =?utf-8?B?T0NLQUNCZ3UrVEtMdXJKbWtNTzMwYTNWQjBGcmlra3VyY1pDYW5vV0ZIbHpl?=
 =?utf-8?B?Nitxa29hVCtxUnpHVy9FWHpVZ1dEdE8xenVNSENWNXZpODVYRW9HeUMzZkJT?=
 =?utf-8?B?Ti84ZllhMTdLZjdrVHoyVlovdHliSzBhdDZYNURiUHlrb1Nxa3p0bmV0Rk1D?=
 =?utf-8?B?djBDWDdJbTJHYkRZM1NHbUhNZEJpNGF3dTd2ZEtNNTk4SnlzSmpFbUtnUUdE?=
 =?utf-8?B?ZFdtV2hFaVRlMmx5RE8yajNuQ2dpYU0yYVllWDE1KzJ0b0pLNFJTSjB2Nmtr?=
 =?utf-8?B?b0tKeEs2NUlvWit3dW8xaDhpNGVkOTZQWGJITkJNNFZFUGR3VWw5dFN2dkEv?=
 =?utf-8?B?Zlc5eHVNeDlNK3NaQUo4aVRGcE9qTmpZYjBkVHk1aFNUUG42RllleFVzaDZF?=
 =?utf-8?B?ci9MRWJ5T21MSHVkRktIVjY5ekg4TW9ER1pUNW5MbVpiRjhzV0MxVHpycjJH?=
 =?utf-8?B?T0Z4TVh1VVQ1ZWRGcXpjajVUNkhOenNKcDFmMkR1QWxibnh6OEtsMjdMejZn?=
 =?utf-8?B?TnUrVUdnMTRZc3lhYzhwVjIxZ0laWU1wZmEyZCs5R3NMaFE2SlhWZktEaTc5?=
 =?utf-8?B?Q3FwUzh5YWpPR2daT1Y1ZDFQeEQ1WGFsc0ljcEp4ektjSFJxMmU4dVBzQ3Jn?=
 =?utf-8?B?TURiNmxoTVFnaGdPZHRmb0JEa25Ba05LL0pSU3RmRjQxM2RYdmNzQ05vYlJm?=
 =?utf-8?B?bjYxdVU1L3hFa0xmWXVvTzQyblN3bEdYcjVEUk42dGZQR29WNlZEa2ZtdXpE?=
 =?utf-8?B?cVQzelBTN2p3TlROSjl3RnJrWmRnOThKQnRxUlR1bHBKVmQwYXcrcWRrUUti?=
 =?utf-8?B?cU9TVVU0Ni83N0I4RE1XajR2b3F4ZE5rbis5M2t1clo0cG1vSXFUWHVmMjUr?=
 =?utf-8?B?b1d1VU5KUTFsUjlnNWxvTG85bHQvYkN5akxoSVptb2I3UEYvZDZNTFc2NmFn?=
 =?utf-8?B?T1lKREhnck1GSkhMUG5mYXNvNklYazhTWmlMUitxQ2pWMWY0S082b01IdzVR?=
 =?utf-8?B?QVY1THpjZUxKWnI0dE1EQ1FwcFV2dDBFcyt0Y2xtbTREY215QkNhSndwRTVo?=
 =?utf-8?B?ZU5mSU14Unp3em5lOTBNazU1VWp0V2I1alFvaWlyQTNXcmhueC8vRm1KTmY5?=
 =?utf-8?B?UHZHVXkwaFBBT0hkQ0w5c0k0UTJtZVJaak9ZSXQvaUsyUnZucXV2VXlNV1o1?=
 =?utf-8?B?ME5rL3FteHlNd2xQQmFxTnhrY2dnTi9uajZGSzJpY0RhSk1WZjg2SDl5QTBx?=
 =?utf-8?B?WWx5TTNYcVk0T0c1QTB6K29uaUFDbW15MHh1ZDJuUktiM0pycGc1NHVCbEFW?=
 =?utf-8?B?K1E0bGdKdWRjNFUyNG5rd3JMcmRQNHBTdEgyM2xnZVdPeGRhd3phcmdDOHMy?=
 =?utf-8?Q?fylnjiQTmvKMJR26wydAHsO1w?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7ecea5d-01c1-4a0c-4647-08dcccd4639f
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 11:26:15.8471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D+k5Fgpc6+Wpy+E1mSkxdza5tC7mY83QXMTt1JH1MXWXg4fvlTdrSv+TYSHISzB6SA6i98wDKje3Uu4mKp2e4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB7085



在 2024/9/4 17:16, Barry Song 写道:
> On Tue, Aug 6, 2024 at 3:36 AM Zhiguo Jiang <justinjiang@vivo.com> wrote:
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
>> |  memory type  |  0min  |  1min  |   5min  |   10min  |   15min  |
>> -------------------------------------------------------------------
>> |     VmRSS(KB) | 453832 | 252300 |  204364 |   199944 |  199748  |
>> |   RssAnon(KB) | 247348 |  99296 |   71268 |    67808 |   67660  |
>> |   RssFile(KB) | 205536 | 152020 |  132144 |   131184 |  131136  |
>> |  RssShmem(KB) |   1048 |    984 |     952 |     952  |     952  |
>> |    VmSwap(KB) | 202692 | 334852 |  362880 |   366340 |  366488  |
>> | Swap ratio(%) | 30.87% | 57.03% |  63.97% |   64.69% |  64.72%  |
>> Note: min - minute.
>>
>> When there are multiple processes with independent mm and the high
>> memory pressure in system, if the large memory required process is
>> launched at this time, system will is likely to trigger the instantaneous
>> killing of many processes with independent mm. Due to multiple exiting
>> processes occupying multiple CPU core resources for concurrent execution,
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
>>
>> It offers several benefits:
>> 1. Alleviate the high system cpu loading caused by multiple exiting
>>     processes running simultaneously.
>> 2. Reduce lock competition in swap entry free path by an asynchronous
>>     kworker instead of multiple exiting processes parallel execution.
>> 3. Release pte_present memory occupied by exiting processes more
>>     efficiently.
>>
>> Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>
>> ---
>>   arch/s390/include/asm/tlb.h |   8 +
>>   include/asm-generic/tlb.h   |  44 ++++++
>>   include/linux/mm_types.h    |  58 +++++++
>>   mm/memory.c                 |   3 +-
>>   mm/mmu_gather.c             | 296 ++++++++++++++++++++++++++++++++++++
>>   5 files changed, 408 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/s390/include/asm/tlb.h b/arch/s390/include/asm/tlb.h
>> index e95b2c8081eb..3f681f63390f
>> --- a/arch/s390/include/asm/tlb.h
>> +++ b/arch/s390/include/asm/tlb.h
>> @@ -28,6 +28,8 @@ static inline bool __tlb_remove_page_size(struct mmu_gather *tlb,
>>                  struct page *page, bool delay_rmap, int page_size);
>>   static inline bool __tlb_remove_folio_pages(struct mmu_gather *tlb,
>>                  struct page *page, unsigned int nr_pages, bool delay_rmap);
>> +static inline bool __tlb_remove_swap_entries(struct mmu_gather *tlb,
>> +               swp_entry_t entry, int nr);
>>
>>   #define tlb_flush tlb_flush
>>   #define pte_free_tlb pte_free_tlb
>> @@ -69,6 +71,12 @@ static inline bool __tlb_remove_folio_pages(struct mmu_gather *tlb,
>>          return false;
>>   }
>>
>> +static inline bool __tlb_remove_swap_entries(struct mmu_gather *tlb,
>> +               swp_entry_t entry, int nr)
>> +{
>> +       return false;
>> +}
>> +
>>   static inline void tlb_flush(struct mmu_gather *tlb)
>>   {
>>          __tlb_flush_mm_lazy(tlb->mm);
>> diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
>> index 709830274b75..8b4d516b35b8
>> --- a/include/asm-generic/tlb.h
>> +++ b/include/asm-generic/tlb.h
>> @@ -294,6 +294,37 @@ extern void tlb_flush_rmaps(struct mmu_gather *tlb, struct vm_area_struct *vma);
>>   static inline void tlb_flush_rmaps(struct mmu_gather *tlb, struct vm_area_struct *vma) { }
>>   #endif
>>
>> +#ifndef CONFIG_MMU_GATHER_NO_GATHER
>> +struct mmu_swap_batch {
>> +       struct mmu_swap_batch *next;
>> +       unsigned int nr;
>> +       unsigned int max;
>> +       encoded_swpentry_t encoded_entrys[];
>> +};
>> +
>> +#define MAX_SWAP_GATHER_BATCH  \
>> +       ((PAGE_SIZE - sizeof(struct mmu_swap_batch)) / sizeof(void *))
>> +
>> +#define MAX_SWAP_GATHER_BATCH_COUNT    (10000UL / MAX_SWAP_GATHER_BATCH)
>> +
>> +struct mmu_swap_gather {
>> +       /*
>> +        * the asynchronous kworker to batch
>> +        * release swap entries
>> +        */
>> +       struct work_struct free_work;
>> +
>> +       /* batch cache swap entries */
>> +       unsigned int batch_count;
>> +       struct mmu_swap_batch *active;
>> +       struct mmu_swap_batch local;
>> +       encoded_swpentry_t __encoded_entrys[MMU_GATHER_BUNDLE];
>> +};
>> +
>> +bool __tlb_remove_swap_entries(struct mmu_gather *tlb,
>> +               swp_entry_t entry, int nr);
>> +#endif
>> +
>>   /*
>>    * struct mmu_gather is an opaque type used by the mm code for passing around
>>    * any data needed by arch specific code for tlb_remove_page.
>> @@ -343,6 +374,18 @@ struct mmu_gather {
>>          unsigned int            vma_exec : 1;
>>          unsigned int            vma_huge : 1;
>>          unsigned int            vma_pfn  : 1;
>> +#ifndef CONFIG_MMU_GATHER_NO_GATHER
>> +       /*
>> +        * Two states of releasing swap entries
>> +        * asynchronously:
>> +        * swp_freeable - have opportunity to
>> +        * release asynchronously future
>> +        * swp_freeing - be releasing asynchronously.
>> +        */
>> +       unsigned int            swp_freeable : 1;
>> +       unsigned int            swp_freeing : 1;
>> +       unsigned int            swp_disable : 1;
>> +#endif
>>
>>          unsigned int            batch_count;
>>
>> @@ -354,6 +397,7 @@ struct mmu_gather {
>>   #ifdef CONFIG_MMU_GATHER_PAGE_SIZE
>>          unsigned int page_size;
>>   #endif
>> +       struct mmu_swap_gather *swp;
>>   #endif
>>   };
>>
>> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
>> index 165c58b12ccc..2f66303f1519
>> --- a/include/linux/mm_types.h
>> +++ b/include/linux/mm_types.h
>> @@ -283,6 +283,64 @@ typedef struct {
>>          unsigned long val;
>>   } swp_entry_t;
>>
>> +/*
>> + * encoded_swpentry_t - a type marking the encoded swp_entry_t.
>> + *
>> + * An 'encoded_swpentry_t' represents a 'swp_enrty_t' with its the highest
>> + * bit indicating extra context-dependent information. Only used in swp_entry
>> + * asynchronous release path by mmu_swap_gather.
>> + */
>> +typedef struct {
>> +       unsigned long val;
>> +} encoded_swpentry_t;
>> +
>> +/*
>> + * The next item in an encoded_swpentry_t array is the "nr" argument, specifying the
>> + * total number of consecutive swap entries associated with the same folio. If this
>> + * bit is not set, "nr" is implicitly 1.
>> + *
>> + * Refer to include\asm\pgtable.h, swp_offset bits: 0 ~ 57, swp_type bits: 58 ~ 62.
>> + * Bit63 can be used here.
>> + */
>> +#define ENCODED_SWPENTRY_BIT_NR_ENTRYS_NEXT (1UL << (BITS_PER_LONG - 1))
>> +
>> +static __always_inline encoded_swpentry_t
>> +encode_swpentry(swp_entry_t entry, unsigned long flags)
>> +{
>> +       encoded_swpentry_t ret;
>> +
>> +       VM_WARN_ON_ONCE(flags & ~ENCODED_SWPENTRY_BIT_NR_ENTRYS_NEXT);
>> +       ret.val = flags | entry.val;
>> +       return ret;
>> +}
>> +
>> +static inline unsigned long encoded_swpentry_flags(encoded_swpentry_t entry)
>> +{
>> +       return ENCODED_SWPENTRY_BIT_NR_ENTRYS_NEXT & entry.val;
>> +}
>> +
>> +static inline swp_entry_t encoded_swpentry_data(encoded_swpentry_t entry)
>> +{
>> +       swp_entry_t ret;
>> +
>> +       ret.val = ~ENCODED_SWPENTRY_BIT_NR_ENTRYS_NEXT & entry.val;
>> +       return ret;
>> +}
>> +
>> +static __always_inline encoded_swpentry_t encode_nr_swpentrys(unsigned long nr)
>> +{
>> +       encoded_swpentry_t ret;
>> +
>> +       VM_WARN_ON_ONCE(nr & ENCODED_SWPENTRY_BIT_NR_ENTRYS_NEXT);
>> +       ret.val = nr;
>> +       return ret;
>> +}
>> +
>> +static __always_inline unsigned long encoded_nr_swpentrys(encoded_swpentry_t entry)
>> +{
>> +       return ((~ENCODED_SWPENTRY_BIT_NR_ENTRYS_NEXT) & entry.val);
>> +}
>> +
>>   /**
>>    * struct folio - Represents a contiguous set of bytes.
>>    * @flags: Identical to the page flags.
>> diff --git a/mm/memory.c b/mm/memory.c
>> index d6a9dcddaca4..023a8adcb67c
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -1650,7 +1650,8 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
>>                          if (!should_zap_cows(details))
>>                                  continue;
>>                          rss[MM_SWAPENTS] -= nr;
>> -                       free_swap_and_cache_nr(entry, nr);
>> +                       if (!__tlb_remove_swap_entries(tlb, entry, nr))
>> +                               free_swap_and_cache_nr(entry, nr);
>>                  } else if (is_migration_entry(entry)) {
>>                          folio = pfn_swap_entry_folio(entry);
>>                          if (!should_zap_folio(details, folio))
>> diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
>> index 99b3e9408aa0..33dc9d1faff9
>> --- a/mm/mmu_gather.c
>> +++ b/mm/mmu_gather.c
>> @@ -9,11 +9,303 @@
>>   #include <linux/smp.h>
>>   #include <linux/swap.h>
>>   #include <linux/rmap.h>
>> +#include <linux/oom.h>
>>
>>   #include <asm/pgalloc.h>
>>   #include <asm/tlb.h>
>>
>>   #ifndef CONFIG_MMU_GATHER_NO_GATHER
>> +/*
>> + * The swp_entry asynchronous release mechanism for multiple processes with
>> + * independent mm exiting simultaneously.
>> + *
>> + * During the multiple exiting processes releasing their own mm simultaneously,
>> + * the swap entries in the exiting processes are handled by isolating, caching
>> + * and handing over to an asynchronous kworker to complete the release.
>> + *
>> + * The conditions for the exiting process entering the swp_entry asynchronous
>> + * release path:
>> + * 1. The exiting process's MM_SWAPENTS count is >= SWAP_CLUSTER_MAX, avoiding
>> + *    to alloc struct mmu_swap_gather frequently.
>> + * 2. The number of exiting processes is >= NR_MIN_EXITING_PROCESSES.
> Hi Zhiguo,
>
> I'm curious about the significance of NR_MIN_EXITING_PROCESSES. It seems that
> batched swap entry freeing, even with one process, could be a
> bottleneck for a single
> process based on the data from this patch:
>
> mm: attempt to batch free swap entries for zap_pte_range()
> https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/commit/?h=mm-stable&id=bea67dcc5ee
> "munmap bandwidth becomes 3X faster."
>
> So what would happen if you simply set NR_MIN_EXITING_PROCESSES to 1?
Hi Barry,

Thanks for your comments.

The reason for NR_MIN_EXITING_PROCESSES = 2 is that previously we
conducted the multiple android apps continuous startup performance
test on the case of NR_MIN_EXITING_PROCESSES = 1, and the results
showed that the startup time had deteriorated slightly. However,
the patch's logic in this test was different from the one I submitted
to the community, and it may be due to some other issues with the
previous old patch.

However, we have conducted relevant memory performance tests on this
patches submitted to the community (NR_MIN_EXITING_PROCESSES=2), and
the results are better than before the modification. The patches have
been used on multiple projects.
For example:
Test the time consumption and subjective fluency experience of
launching 30 android apps continuously for two rounds.
Test machine: RAM 16GB
|        | time(s) | Frame-droped rate(%) |
| before | 230.76  |         0.54         |
| after  | 225.23  |         0.74         |
We can see that the patch has been optimized 5.53s for startup time and
0.2% frame-droped rate and better subjective smoothness experience.

Perhaps the patches submitted to the community has also improved the
multiple android apps continuous startup performance in the case
of NR_MIN_EXITING_PROCESSES=1. If necessary, I will conduct relevant
tests to verify this situation in the future.
>
>> + *
>> + * Since the time for determining the number of exiting processes is dynamic,
>> + * the exiting process may start to enter the swp_entry asynchronous release
>> + * at the beginning or middle stage of the exiting process's swp_entry release
>> + * path.
>> + *
>> + * Once an exiting process enters the swp_entry asynchronous release, all remaining
>> + * swap entries in this exiting process need to be fully released by asynchronous
>> + * kworker theoretically.
> Freeing a slot can indeed release memory from `zRAM`, potentially returning
> it to the system for allocation. Your patch frees swap slots asynchronously;
> I assume this doesn’t slow down the memory freeing process for `zRAM`, or
> could it even slow down the freeing of `zRAM` memory? Freeing compressed
> memory might not be as crucial compared to freeing uncompressed memory with
> present PTEs?
Yes, freeing uncompressed memory with present PTEs is more important
compared to freeing compressed 'zRAM' memory.

I guess that the multiple exiting processes releasing swap entries
simultaneously may result in the swap_info->lock competition pressure
in swapcache_free_entries(), affecting the efficiency of releasing swap
entries. However, if the asynchronous kworker is used, this issue can
be avoided, and perhaps the improvement is minor.

The freeing of zRAM memory does not slow down. We have observed traces
in the camera startup scene and found that the asynchronous kworker
can release all swap entries before entering the camera preview.
Compared to not using the asynchronous kworker, the exiting processes
completed after entering the camera preview.
>
>> + *
>> + * The function of the swp_entry asynchronous release:
>> + * 1. Alleviate the high system cpu load caused by multiple exiting processes
>> + *    running simultaneously.
>> + * 2. Reduce lock competition in swap entry free path by an asynchronous kworker
>> + *    instead of multiple exiting processes parallel execution.
>> + * 3. Release pte_present memory occupied by exiting processes more efficiently.
>> + */
>> +
>> +/*
>> + * The min number of exiting processes required for swp_entry asynchronous release
>> + */
>> +#define NR_MIN_EXITING_PROCESSES 2
>> +
>> +static atomic_t nr_exiting_processes = ATOMIC_INIT(0);
>> +static struct kmem_cache *swap_gather_cachep;
>> +static struct workqueue_struct *swapfree_wq;
>> +static DEFINE_STATIC_KEY_TRUE(tlb_swap_asyncfree_disabled);
>> +
>> +static int __init tlb_swap_async_free_setup(void)
>> +{
>> +       swapfree_wq = alloc_workqueue("smfree_wq", WQ_UNBOUND |
>> +               WQ_HIGHPRI | WQ_MEM_RECLAIM, 1);
>> +       if (!swapfree_wq)
>> +               goto fail;
>> +
>> +       swap_gather_cachep = kmem_cache_create("swap_gather",
>> +               sizeof(struct mmu_swap_gather),
>> +               0, SLAB_TYPESAFE_BY_RCU | SLAB_PANIC | SLAB_ACCOUNT,
>> +               NULL);
>> +       if (!swap_gather_cachep)
>> +               goto kcache_fail;
>> +
>> +       static_branch_disable(&tlb_swap_asyncfree_disabled);
>> +       return 0;
>> +
>> +kcache_fail:
>> +       destroy_workqueue(swapfree_wq);
>> +fail:
>> +       return -ENOMEM;
>> +}
>> +postcore_initcall(tlb_swap_async_free_setup);
>> +
>> +static void __tlb_swap_gather_free(struct mmu_swap_gather *swap_gather)
>> +{
>> +       struct mmu_swap_batch *swap_batch, *next;
>> +
>> +       for (swap_batch = swap_gather->local.next; swap_batch; swap_batch = next) {
>> +               next = swap_batch->next;
>> +               free_page((unsigned long)swap_batch);
>> +       }
>> +       swap_gather->local.next = NULL;
>> +       kmem_cache_free(swap_gather_cachep, swap_gather);
>> +}
>> +
>> +static void tlb_swap_async_free_work(struct work_struct *w)
>> +{
>> +       int i, nr_multi, nr_free;
>> +       swp_entry_t start_entry;
>> +       struct mmu_swap_batch *swap_batch;
>> +       struct mmu_swap_gather *swap_gather = container_of(w,
>> +               struct mmu_swap_gather, free_work);
>> +
>> +       /* Release swap entries cached in mmu_swap_batch. */
>> +       for (swap_batch = &swap_gather->local; swap_batch && swap_batch->nr;
>> +           swap_batch = swap_batch->next) {
>> +               nr_free = 0;
>> +               for (i = 0; i < swap_batch->nr; i++) {
>> +                       if (unlikely(encoded_swpentry_flags(swap_batch->encoded_entrys[i]) &
>> +                           ENCODED_SWPENTRY_BIT_NR_ENTRYS_NEXT)) {
>> +                               start_entry = encoded_swpentry_data(swap_batch->encoded_entrys[i]);
>> +                               nr_multi = encoded_nr_swpentrys(swap_batch->encoded_entrys[++i]);
>> +                               free_swap_and_cache_nr(start_entry, nr_multi);
>> +                               nr_free += 2;
>> +                       } else {
>> +                               start_entry = encoded_swpentry_data(swap_batch->encoded_entrys[i]);
>> +                               free_swap_and_cache_nr(start_entry, 1);
>> +                               nr_free++;
>> +                       }
>> +               }
>> +               swap_batch->nr -= nr_free;
>> +               VM_BUG_ON(swap_batch->nr);
>> +       }
>> +       __tlb_swap_gather_free(swap_gather);
>> +}
>> +
>> +static bool __tlb_swap_gather_mmu_check(struct mmu_gather *tlb)
>> +{
>> +       /*
>> +        * Only the exiting processes with the MM_SWAPENTS counter >=
>> +        * SWAP_CLUSTER_MAX have the opportunity to release their swap
>> +        * entries by asynchronous kworker.
>> +        */
>> +       if (!task_is_dying() ||
>> +           get_mm_counter(tlb->mm, MM_SWAPENTS) < SWAP_CLUSTER_MAX)
>> +               return true;
>> +
>> +       atomic_inc(&nr_exiting_processes);
>> +       if (atomic_read(&nr_exiting_processes) < NR_MIN_EXITING_PROCESSES)
>> +               tlb->swp_freeable = 1;
>> +       else
>> +               tlb->swp_freeing = 1;
>> +
>> +       return false;
>> +}
>> +
>> +/**
>> + * __tlb_swap_gather_init - Initialize an mmu_swap_gather structure
>> + * for swp_entry tear-down.
>> + * @tlb: the mmu_swap_gather structure belongs to tlb
>> + */
>> +static bool __tlb_swap_gather_init(struct mmu_gather *tlb)
>> +{
>> +       tlb->swp = kmem_cache_alloc(swap_gather_cachep, GFP_ATOMIC | GFP_NOWAIT);
>> +       if (unlikely(!tlb->swp))
>> +               return false;
>> +
>> +       tlb->swp->local.next  = NULL;
>> +       tlb->swp->local.nr    = 0;
>> +       tlb->swp->local.max   = ARRAY_SIZE(tlb->swp->__encoded_entrys);
>> +
>> +       tlb->swp->active      = &tlb->swp->local;
>> +       tlb->swp->batch_count = 0;
>> +
>> +       INIT_WORK(&tlb->swp->free_work, tlb_swap_async_free_work);
>> +       return true;
>> +}
>> +
>> +static void __tlb_swap_gather_mmu(struct mmu_gather *tlb)
>> +{
>> +       if (static_branch_unlikely(&tlb_swap_asyncfree_disabled))
>> +               return;
>> +
>> +       tlb->swp = NULL;
>> +       tlb->swp_freeable = 0;
>> +       tlb->swp_freeing = 0;
>> +       tlb->swp_disable = 0;
>> +
>> +       if (__tlb_swap_gather_mmu_check(tlb))
>> +               return;
>> +
>> +       /*
>> +        * If the exiting process meets the conditions of
>> +        * swp_entry asynchronous release, an mmu_swap_gather
>> +        * structure will be initialized.
>> +        */
>> +       if (tlb->swp_freeing)
>> +               __tlb_swap_gather_init(tlb);
>> +}
>> +
>> +static void __tlb_swap_gather_queuework(struct mmu_gather *tlb, bool finish)
>> +{
>> +       queue_work(swapfree_wq, &tlb->swp->free_work);
>> +       tlb->swp = NULL;
>> +       if (!finish)
>> +               __tlb_swap_gather_init(tlb);
>> +}
>> +
>> +static bool __tlb_swap_next_batch(struct mmu_gather *tlb)
>> +{
>> +       struct mmu_swap_batch *swap_batch;
>> +
>> +       if (tlb->swp->batch_count == MAX_SWAP_GATHER_BATCH_COUNT)
>> +               goto free;
>> +
>> +       swap_batch = (void *)__get_free_page(GFP_ATOMIC | GFP_NOWAIT);
>> +       if (unlikely(!swap_batch))
>> +               goto free;
>> +
>> +       swap_batch->next = NULL;
>> +       swap_batch->nr   = 0;
>> +       swap_batch->max  = MAX_SWAP_GATHER_BATCH;
>> +
>> +       tlb->swp->active->next = swap_batch;
>> +       tlb->swp->active = swap_batch;
>> +       tlb->swp->batch_count++;
>> +       return true;
>> +free:
>> +       /* batch move to wq */
>> +       __tlb_swap_gather_queuework(tlb, false);
>> +       return false;
>> +}
>> +
>> +/**
>> + * __tlb_remove_swap_entries - the swap entries in exiting process are
>> + * isolated, batch cached in struct mmu_swap_batch.
>> + * @tlb: the current mmu_gather
>> + * @entry: swp_entry to be isolated and cached
>> + * @nr: the number of consecutive entries starting from entry parameter.
>> + */
>> +bool __tlb_remove_swap_entries(struct mmu_gather *tlb,
>> +                            swp_entry_t entry, int nr)
>> +{
>> +       struct mmu_swap_batch *swap_batch;
>> +       unsigned long flags = 0;
>> +       bool ret = false;
>> +
>> +       if (tlb->swp_disable)
>> +               return ret;
>> +
>> +       if (!tlb->swp_freeable && !tlb->swp_freeing)
>> +               return ret;
>> +
>> +       if (tlb->swp_freeable) {
>> +               if (atomic_read(&nr_exiting_processes) <
>> +                   NR_MIN_EXITING_PROCESSES)
>> +                       return ret;
>> +               /*
>> +                * If the current number of exiting processes
>> +                * is >= NR_MIN_EXITING_PROCESSES, the exiting
>> +                * process with swp_freeable state will enter
>> +                * swp_freeing state to start releasing its
>> +                * remaining swap entries by the asynchronous
>> +                * kworker.
>> +                */
>> +               tlb->swp_freeable = 0;
>> +               tlb->swp_freeing = 1;
>> +       }
>> +
>> +       VM_BUG_ON(tlb->swp_freeable || !tlb->swp_freeing);
>> +       if (!tlb->swp && !__tlb_swap_gather_init(tlb))
>> +               return ret;
>> +
>> +       swap_batch = tlb->swp->active;
>> +       if (unlikely(swap_batch->nr >= swap_batch->max - 1)) {
>> +               __tlb_swap_gather_queuework(tlb, false);
>> +               return ret;
>> +       }
>> +
>> +       if (likely(nr == 1)) {
>> +               swap_batch->encoded_entrys[swap_batch->nr++] = encode_swpentry(entry, flags);
>> +       } else {
>> +               flags |= ENCODED_SWPENTRY_BIT_NR_ENTRYS_NEXT;
>> +               swap_batch->encoded_entrys[swap_batch->nr++] = encode_swpentry(entry, flags);
>> +               swap_batch->encoded_entrys[swap_batch->nr++] = encode_nr_swpentrys(nr);
>> +       }
>> +       ret = true;
>> +
>> +       if (swap_batch->nr >= swap_batch->max - 1) {
>> +               if (!__tlb_swap_next_batch(tlb))
>> +                       goto exit;
>> +               swap_batch = tlb->swp->active;
>> +       }
>> +       VM_BUG_ON(swap_batch->nr > swap_batch->max - 1);
>> +exit:
>> +       return ret;
>> +}
>> +
>> +static void __tlb_batch_swap_finish(struct mmu_gather *tlb)
>> +{
>> +       if (tlb->swp_disable)
>> +               return;
>> +
>> +       if (!tlb->swp_freeable && !tlb->swp_freeing)
>> +               return;
>> +
>> +       if (tlb->swp_freeable) {
>> +               tlb->swp_freeable = 0;
>> +               VM_BUG_ON(tlb->swp_freeing);
>> +               goto exit;
>> +       }
>> +       tlb->swp_freeing = 0;
>> +       if (unlikely(!tlb->swp))
>> +               goto exit;
>> +
>> +       __tlb_swap_gather_queuework(tlb, true);
>> +exit:
>> +       atomic_dec(&nr_exiting_processes);
>> +}
>>
>>   static bool tlb_next_batch(struct mmu_gather *tlb)
>>   {
>> @@ -386,6 +678,9 @@ static void __tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm,
>>          tlb->local.max  = ARRAY_SIZE(tlb->__pages);
>>          tlb->active     = &tlb->local;
>>          tlb->batch_count = 0;
>> +
>> +       tlb->swp_disable = 1;
>> +       __tlb_swap_gather_mmu(tlb);
>>   #endif
>>          tlb->delayed_rmap = 0;
>>
>> @@ -466,6 +761,7 @@ void tlb_finish_mmu(struct mmu_gather *tlb)
>>
>>   #ifndef CONFIG_MMU_GATHER_NO_GATHER
>>          tlb_batch_list_free(tlb);
>> +       __tlb_batch_swap_finish(tlb);
>>   #endif
>>          dec_tlb_flush_pending(tlb->mm);
>>   }
>> --
>> 2.39.0
>>
> Thanks
> Barry
Thanks
Zhiguo


