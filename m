Return-Path: <linux-arch+bounces-5844-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C097F944958
	for <lists+linux-arch@lfdr.de>; Thu,  1 Aug 2024 12:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76ABA281AAC
	for <lists+linux-arch@lfdr.de>; Thu,  1 Aug 2024 10:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 942D113D626;
	Thu,  1 Aug 2024 10:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="pTLvbacu"
X-Original-To: linux-arch@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2064.outbound.protection.outlook.com [40.107.215.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB0F3BBE5;
	Thu,  1 Aug 2024 10:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722508415; cv=fail; b=n4CvKrHPcwq1QfoasHOaQ2ywU4mkpSJWj72nNqtoqAoIXYVc5ywzNg/jfii3yKNj80WosqJrmK0785ob4ttY/LxkPbH3Xkru5ek1apgN2lTZnGIEdDTkQJQHqBslwhguDBjHbjkVk0heXiygfyC2ekSUOUrPdFo1EGKV0zOIOXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722508415; c=relaxed/simple;
	bh=6rXwTGW/kJFgD7RBRMnmL9hjkgCO2pQcuxFvVqL4/60=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nezT46KNADSLw9JeRpH5Cuni2x0YspDxw9qpUHFt2UadnxFo9VRiPPnMrLx/2J5sTyhFRE5y9c/Dt++FX8i11izOpZMvUaSwzFlRmA5dE1jRnyLSulPGQc05izWO66waEfHhqyJtip+XarEcZCREAQNqG0dmCcxBixFkbpbIKy8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=pTLvbacu; arc=fail smtp.client-ip=40.107.215.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yo8Apioke3v1+7GeEoO9oPIKiqRj16k4tg9vxldEqCdAxhmxMYaAnjC47vv6IsGW3Q4OxSPq+65JEFzG/Rp4rOxweRwHlUFPuHtZP5Lj68fzO9HRfz2nZZ2GccytyEA7PYRQgEQEQF59Xvs8mPMmlO2IXwdmI9m3PfYr6j+jXYfFbdThwZWrl0CbD1NMW9txNAvIc4KQ+jQdarq/OjeqI6OcAPlodiwcaOmRwYrVKxoZiykmOB3WIebVP46erR7Dynw7cGGVLn2BX4I7yerwYTsBB8cY6Aykcl+OB7A7pWJNx5xJCFKvEevuIsAp2ZuH9rOnwyS36rZsiXTb0BE92Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DSuE5Oa7/DmjtlVa8Mg5447RmfexKka8rSYuQMUbJTk=;
 b=V+YFPLH4R55WRPI/tLjFtLUPhCOi1dx8Wm1mgDkSgp6Ndnu1tBsy9UyZUNjrCdIay73lKDdOQm9+3xyZlaxWkwhmUuYYh6XHUFnem944N0/ayG7Ea3tYb/Tu/qFHXyI1mi0CnBPXbvJN50Ee7fpl2yJQv41wCUb1k95Syv4msz6zog/PcqI0EOb8mvbchmriaQShnaf8eRAoFXhadc8jACHV010qmM5HRYyMP6rxx6pTH1U73zjTDIywWdNNOwPvq3AORiy2UY2WVt5/JyYqi3gs4PWPaiTNo44b8qrxZU2qGl66bEE52ORXzsbchjAI/WmbLRwRHygZOWjzA8bcWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DSuE5Oa7/DmjtlVa8Mg5447RmfexKka8rSYuQMUbJTk=;
 b=pTLvbacuSwVBxp3fM6RhesnI1CiTrenqsfXeeb0OicRVaJtVNy9ye95m1E3zP+oqPXoFfQH5cfXOtqV/rbHfpusnKMBMCopzCewd/lYAO9pT1bu67S3Z0trGr+Stit8t9LrKYUOTxmbHWUeZnVx66ljGRJa9ghWcOO4pqlqR0cHF4RRJkSXuWFuG4t/GtZcjSe7EFCYhv5nRx+LOXXX5WJ2lC3HJl1f8H+jp7PHxC4a6lqHa2+QpOkDaJX9CphYPjt/PkQXlbl4+XU7/4vd8zfnl95+Z3Neo12+OpDPpjC2FoX0cyZSV9IGxY17GBQaAu5XW0/0zrLvZYPoD6l13OQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by TYZPR06MB5099.apcprd06.prod.outlook.com (2603:1096:400:1c5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Thu, 1 Aug
 2024 10:33:27 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed%3]) with mapi id 15.20.7828.016; Thu, 1 Aug 2024
 10:33:27 +0000
Message-ID: <820dfff4-1f09-474e-aa68-30d779a72fed@vivo.com>
Date: Thu, 1 Aug 2024 18:33:24 +0800
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
From: zhiguojiang <justinjiang@vivo.com>
In-Reply-To: <CAGsJ_4xv--92w+hOVWtMtYK-0TsR6z67xiHEXCvuRNvXx71b2A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0008.APCP153.PROD.OUTLOOK.COM (2603:1096::18) To
 JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|TYZPR06MB5099:EE_
X-MS-Office365-Filtering-Correlation-Id: b2686242-a7fa-4821-d12f-08dcb2156140
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|43062017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?KzhwQzhQT21lWk51dW0vdDM2S1JGZXJQYU1tUnh3YXN3b1Rtb0dNeCtBSGN6?=
 =?utf-8?B?SGdhMUR6anVnZTQ4WEJmOGpxRFdlaGZlUGw4V0lvQWVnTW8vMnJhOTNTMnYv?=
 =?utf-8?B?bGhzVU96d3JYZkQwMzl6TnQrYVpnRTloRmJKN2h4bEZmSzQyTU9EV1BnSFhH?=
 =?utf-8?B?WEhxcURFQXkyMmVNcm1VUTh1UFJzYXhob09nMWQxb3BpV3ZPVWdLcUtTV0sz?=
 =?utf-8?B?TVphNzFJZW80NVBuOGlnZGcyalp6VG1wWmk3RVYwNUxwSzZWZmREdDlUTTRH?=
 =?utf-8?B?S0hKSkU1NElRSDFxdGpjRkZVdzhIWkRJZG5rY0lnZ3BHZUp4TTdKOENjcXdu?=
 =?utf-8?B?YTE3aGtubGRsUlJkZysvUzJ6L0xFY1RvR1ZPUnExRVdQZ1JHSVo3RTA1T1Zv?=
 =?utf-8?B?cldXcDFOd1J1UjIva1FmR05sZnNmVEhtS1JGenU0d1lBT3VDMXF0TjlmYUlL?=
 =?utf-8?B?QmcxL1F1aVJVOWc4NnBGZ1FmR1JwRU02VG42cmFmQWNqSjBxYnlVT092S2Vp?=
 =?utf-8?B?T2dHZFMzOEJZV24wWEV5RFVXYituL1FheDlBaHBhL2VaelBycnRqUUc5TVE1?=
 =?utf-8?B?TWtEMmpWSzBaNTFRR2J5QUNRekhhbHdnV1dVYUtqRWtrR2RZdUNxUzFPUFNX?=
 =?utf-8?B?RXZSTytuV2FRalVaQXVrMDR1clgvU25Kdk9uOVRBRE9nd0pmV29YZk4rRnFZ?=
 =?utf-8?B?dG9qMWhvMEVpVDY3ODhSWVhzWGtoYUJwVzhoV0psWUZ1ZFFmR09DL2dNemZi?=
 =?utf-8?B?UVJVZ0hwcE5Qd0V4allNQXkrNzdIbi96bGE4Z3pLN2Q1SDk4MWtvbUNjY1ky?=
 =?utf-8?B?UFhnY2EwcW1iYXhFTFVEWjlkeUt6dy9RRXhyVHBNdGxtTDVLdDZYZW8yYXZn?=
 =?utf-8?B?RHgrWFdOM0FTWnBuSk11aE1QTXNtTHI2c3AvbUpnWW05WHhLWDU2aXByb2U5?=
 =?utf-8?B?bmlDZXk4Yld3SXZYY284TU1HSXh4eUo5QjRQWmErMlgzbVFHS0F0bzhtVXhE?=
 =?utf-8?B?eVg3Y3phUmlQR1FBV3p2Z3Zjc3hGb2pqdXpXekxlQzM1NERJQ3N1NWd1bFhD?=
 =?utf-8?B?OEFFc1BvOXYyU0E0YkhpNFd1WjErVzRhcllRaDlEUXlibnFsc0p6T2dCenZl?=
 =?utf-8?B?NFQvdTRSYVBOVnZIOHdNc1VrUzJuYUgzVVVoYVhHcTZxdXpDMDEzWXozR3BX?=
 =?utf-8?B?TW1yczFSTW40bXpsZDhIYnpBaW81TjFKdTBmaklmd200RGhWOGZDWTZvdkNk?=
 =?utf-8?B?WUJwTFlVSHpTaS9VZTRVanl6VXcvYS9CMldVaHBpbDU3c296Ulp2WWxZekg0?=
 =?utf-8?B?bHc5Y2xWSXJ5UUYwQXV2OUFaTWxXZFh0U2p5L1orUmpvb2MvM3JpQ1BlVnFX?=
 =?utf-8?B?dmswanBySkxRcVdNK2Y3NThsRUFLVzcwUWZNbmc0SmwySFVKd2xHQUEwRUxI?=
 =?utf-8?B?SHpFVDV2b3Z3d2hWWkczZXRwSDFkNVN1MnF4TDczQlo3VjZ0T252cFJCMHJY?=
 =?utf-8?B?ZXQza1BtQVBYcjF0dWVhZFBCRGNKODY4ZFZnZU95eDlreVRpVFh4ZW9QQkhk?=
 =?utf-8?B?Y3FGQWRsOGV1QmNjLzRVbVZRc2ZKbmNJSVFnVDhYbEhBOGpDN1Jzd1ZzSDkw?=
 =?utf-8?B?R01laHlJb3RYdGUwcTQ3MU9iVnhoTGdRdlZKZ0JETmxqWmpEcmljWkZCMkhz?=
 =?utf-8?B?UitZdHowODQwRnlFMUNmRVlRT0VYdDNrR05nVTdBSG14M0x6bjh2SHB6VUNj?=
 =?utf-8?B?NGMzSUFNZC9lcDVCU3FyTm11Z2xZTStnaUUrSm9rQ3pOSWc1WHNHQ3VzV2lx?=
 =?utf-8?B?aFg5RjgrN2JHSWRoVWFGUko0VG11L1pjM2tIYVpJcVMveGdhdlJYU2ppaTJK?=
 =?utf-8?B?Y1JYaEc4RXMrRmJBd0R2RFlVZ0dFdHlNRXZDWDRzN3pGQWc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(43062017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ejJVc3FMZnNMaHZDcXJZcDY1QzhvOU1BbDRMdFZXWEZ5ODJRWHozdGhPZ1JQ?=
 =?utf-8?B?dVNocUF3VC9RbkV4QkNONThhVnRFZEtJODU5WU5RNkNweWVpTVVwZ1ZZQTFU?=
 =?utf-8?B?MzlsbktTdnRYQlVtNG9KMmpiZUpiUS9hNEhmWGluMS9vMzFUVHI0RldILzI4?=
 =?utf-8?B?ZDhzYThxTHcvbEdPVEQzSzYzNlZKL2pCYmtUWlNydFJUOTVpdFdxckNDL00x?=
 =?utf-8?B?dW15bDJ4ZlB0UXhwWTE5SUw5cm1INXEwQmtoK3JyWXV1bzg5ZHRMSTRVTGJT?=
 =?utf-8?B?a2UvYVdwdHhiOUlrM0hUTmFLeWFnaVIyaVJ6YWJDZmdNWDRCa0d5N0FGaWQ0?=
 =?utf-8?B?NVJqWU5WMGdnd3pwdjZ6ZWZyRVZSdmxzc09MMExyWUR3WFRqSG8xNmVvejJx?=
 =?utf-8?B?MldBc1QyY1dGZ2d3dlMvWGVIYVlxb1NZamRKb3NNRkVCY0Q4VE9kY21mVlZS?=
 =?utf-8?B?RFdxU2ppSEtuZEd4TTA5QjRBNExzRzcyT2sxQk8ySVZvSXV4RWpSRXVzRFo1?=
 =?utf-8?B?UEhrcWNPNGJpUUdERlNqU2xEbmsvVWhVVnFKTDVaUDluSFNVSVM3ZXMyT2th?=
 =?utf-8?B?Z3IwMjNVaWtMT0wvdGVwNUxnSUovVVV6eVdKT05mMlhrTlg2am1RUXRTQ2h1?=
 =?utf-8?B?MzA0c0g3MEREMnl5QlpZdVFROE5PdE5VNlhKY3Zqb0JmTFpaMmVKZ2pSK2xt?=
 =?utf-8?B?dU5hdEt4WnlqVnBZQW44ZFdIUGJ0cENIbWxmVW5wZUpVK0hGR3ZxWUQzQnls?=
 =?utf-8?B?TFFiOW43RXdkQW9SMW0rS0xKMnJWcEVqbEl6bGxJUTJLNGxvWTNWdFVMTllu?=
 =?utf-8?B?NDZrRjA0N3licnI2RTVsVlJzcm9wcVp5VURsMUk4K2pZZjUzQ2h3NHZRWmxm?=
 =?utf-8?B?M2lvV2taMzNuNkJBUXpIcnpjYURuYXp2SVMvSlJBajZwUERZVFFLanZSeHht?=
 =?utf-8?B?WDhNU3BHdkowbmJCT0xWYzN5Q1RMMTBvVSt0Rit5REIvMTRFVVA4Q3NBakR1?=
 =?utf-8?B?RUlMNitFdFlXLzRQZW9uQlA3NmZMV3JtMzdrM0FyWGF3VFNIemh2K2Y0NXR4?=
 =?utf-8?B?L0RoMHdvUzVsREpXWDd0SDNFdnlUUlZDTCt2MnE5d2xZWUxwc2w1MGdDOHdG?=
 =?utf-8?B?bzIwWFlsZzQ0NGp4QmU3eGJBbm5DcEl3SHVrTE1ZSVBsWHlSdU5QS0RmeERN?=
 =?utf-8?B?UDRyOGxUSVZFNFNKTGJHV1dxYXU4TXR3TkVjMVNnY1BCK3R0L2lrOW9DU0JP?=
 =?utf-8?B?RnlJVFJySlVrY09PbTVOa0l1c2xyN2tGd0RoNEVDTEhqeC9WQmxCZjBSUytq?=
 =?utf-8?B?Q0l6N09aSkZzQkxyc1dwa3haVmlBQzhDUlMzQzc2N0JkRUo1Ym92QmFVTGJN?=
 =?utf-8?B?ZG5RckRad2krTWQ1VDRTU1lxTGdWckRSdVNzbTNIdm5UQy9NRmhkM3ZXVXNp?=
 =?utf-8?B?Rmc0aGQ3SWt4aDd1TkIrR2tLdlkwYkVVNURSTDA0ME1zaWl3REQyV0hqT0ZH?=
 =?utf-8?B?OC85M0FzdU1YcVdVb3ZRaEduYjRlQlowTklQcmdEY2RJOThUcU4wUjJ4QU9P?=
 =?utf-8?B?dXBwVWdnakZHRmc4RHZNSHRXOUtsdEl2eSt2QVc2eHo3MGNGKzBBQkJSZ3ps?=
 =?utf-8?B?bXE2Q0RjbEpTbmUrNVY5WGxCbzJaMERKTVNHMm9CSlRnbkptRys0ZHFGVW9V?=
 =?utf-8?B?QmF5UWxuakVVK3M0NnJ6MFlaMHllTVJpM25EdkR3UU5zb25waUNDMk9XbitW?=
 =?utf-8?B?TmpjMDArbE9GTUZHTXEvTVg1WEN4MzFlakxqVVlSM0MrMmRna3Fwa2wvN25R?=
 =?utf-8?B?Q2dzb05HV0tHZElCMDlwQUxPWWp1c05qbktXTWpMWFdFeW9KSTM1QmZ6cjB6?=
 =?utf-8?B?aU9CWUpsWXM2ZlJLaXZiV1F5RzNPb0llbFZ1THB2OHVkdU9Qc3lpU29VUStr?=
 =?utf-8?B?UWRxUmZtQnBjUlVoUnhMNlZvVXpxYTdEUFFnTzdTQUJIS21GNGhkZWxKcHNi?=
 =?utf-8?B?K21FL0FGa0UzMG83UnpIYW9BbXpLRHhaSzJrMWc0b1doQmdmekxVVkR0WlBu?=
 =?utf-8?B?WVpjUElqd2FmMUFMN2FsR2s0UlVTY3ZJUDJYYk96UmJkZG82cW5QOWM5N25m?=
 =?utf-8?Q?nky/LTdnuY3BZQECO68OeNV0u?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2686242-a7fa-4821-d12f-08dcb2156140
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 10:33:27.6474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BbudOa4mvgHWrRbw1RBjYXfE59jc82ck80P/fyv9VpWIdKmy1FGRW1rgUXm9Vbopn/lzafG4qNp2g5hFUorUwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5099



在 2024/8/1 15:36, Barry Song 写道:
> On Thu, Aug 1, 2024 at 2:31 PM zhiguojiang <justinjiang@vivo.com> wrote:
>>
>> 在 2024/8/1 0:17, Andrew Morton 写道:
>>> [Some people who received this message don't often get email from akpm@linux-foundation.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>>>
>>> On Wed, 31 Jul 2024 21:33:14 +0800 Zhiguo Jiang <justinjiang@vivo.com> wrote:
>>>
>>>> The main reasons for the prolonged exit of a background process is the
>>> The kernel really doesn't have a concept of a "background process".
>>> It's a userspace concept - perhaps "the parent process isn't waiting on
>>> this process via wait()".
>>>
>>> I assume here you're referring to an Android userspace concept?  I
>>> expect that when Android "backgrounds" a process, it does lots of
>>> things to that process.  Perhaps scheduling priority, perhaps
>>> alteration of various MM tunables, etc.
>>>
>>> So rather than referring to "backgrounding" it would be better to
>>> identify what tuning alterations are made to such processes to bring
>>> about this behavior.
>> Hi Andrew Morton,
>>
>> Thank you for your review and comments.
>>
>> You are right. The "background process" here refers to the process
>> corresponding to an Android application switched to the background.
>> In fact, this patch is applicable to any exiting process.
>>
>> The further explaination the concept of "multiple exiting processes",
>> is that it refers to different processes owning independent mm rather
>> than sharing the same mm.
>>
>> I will use "mm" to describe process instead of "background" in next
>> version.
>>>> time-consuming release of its swap entries. The proportion of swap memory
>>>> occupied by the background process increases with its duration in the
>>>> background, and after a period of time, this value can reach 60% or more.
>>> Again, what is it about the tuning of such processes which causes this
>>> behavior?
>> When system is low memory, memory recycling will be trigged, where
>> anonymous folios in the process will be continuously reclaimed, resulting
>> in an increase of swap entries occupies by this process. So when the
>> process is killed, it takes more time to release it's swap entries over
>> time.
>>
>> Testing datas of process occuping different physical memory sizes at
>> different time points:
>> Testing Platform: 8GB RAM
>> Testing procedure:
>> After booting up, start 15 processes first, and then observe the
>> physical memory size occupied by the last launched process at
>> different time points.
>>
>> Example:
>> The process launched last: com.qiyi.video
>> |  memory type  |  0min  |  1min  | BG 5min | BG 10min | BG 15min |
>> -------------------------------------------------------------------
>> |     VmRSS(KB) | 453832 | 252300 |  204364 |   199944 |  199748  |
>> |   RssAnon(KB) | 247348 |  99296 |   71268 |    67808 |   67660  |
>> |   RssFile(KB) | 205536 | 152020 |  132144 |   131184 |  131136  |
>> |  RssShmem(KB) |   1048 |    984 |     952 |     952  |     952  |
>> |    VmSwap(KB) | 202692 | 334852 |  362880 |   366340 |  366488  |
>> | Swap ratio(%) | 30.87% | 57.03% |  63.97% |   64.69% |  64.72%  |
>> min - minute.
>>
>> Based on the above datas, we can know that the swap ratio occupied by
>> the process gradually increases over time.
> If I understand correctly, during zap_pte_range(), if 64.72% of the anonymous
> pages are actually swapped out, you end up zapping 100 PTEs but only freeing
> 36.28 pages of memory. By doing this asynchronously, you prevent the
> swap_release operation from blocking the process of zapping normal
> PTEs that are mapping to memory.
>
> Could you provide data showing the improvements after implementing
> asynchronous freeing of swap entries?
Hi Barry,

Your understanding is correct. From the perspective of the benefits of
releasing the physical memory occupied by the exiting process, an
asynchronous kworker releasing swap entries can indeed accelerate
the exiting process to release its pte_present memory (e.g. file and
anonymous folio) faster.

In addition, from the perspective of CPU resources, for scenarios where
multiple exiting processes are running simultaneously, an asynchronous
kworker instead of multiple exiting processes is used to release swap
entries can release more CPU core resources for the current non-exiting
and important processes to use, thereby improving the user experience
of the current non-exiting and important processes. I think this is the
main contribution of this modification.

Example:
When there are multiple processes and the system memory is low, if
the camera processes are started at this time, it will trigger the
instantaneous killing of many processes because the camera processes
need to alloc a large amount of memory, resulting in multiple exiting
processes running simultaneously. These exiting processes will compete
with the current camera processes for CPU resources, and the release of
physical memory occupied by multiple exiting processes due to scheduling
is slow, ultimately affecting the slow execution of the camera process.

By using this optimization modification, multiple exiting processes can
quickly exit, freeing up their CPU resources and physical memory of
pte_preset, improving the running speed of camera processes.

Testing Platform: 8GB RAM
Testing procedure:
After restarting the machine, start 15 app processes first, and then
start the camera app processes, we monitor the cold start and preview
time datas of the camera app processes.

Test datas of camera processes cold start time (unit: millisecond):
|  seq   |   1  |   2  |   3  |   4  |   5  |   6  | average |
| before | 1498 | 1476 | 1741 | 1337 | 1367 | 1655 |   1512  |
| after  | 1396 | 1107 | 1136 | 1178 | 1071 | 1339 |   1204  |

Test datas of camera processes preview time (unit: millisecond):
|  seq   |   1  |   2  |   3  |   4  |   5  |   6  | average |
| before |  267 |  402 |  504 |  513 |  161 |  265 |   352   |
| after  |  188 |  223 |  301 |  203 |  162 |  154 |   205   |

Base on the average of the six sets of test datas above, we can see that
the benefit datas of the modified patch:
1. The cold start time of camera app processes has reduced by about 20%.
2. The preview time of camera app processes has reduced by about 42%.
>
>>>> Additionally, the relatively lengthy path for releasing swap entries
>>>> further contributes to the longer time required for the background process
>>>> to release its swap entries.
>>>>
>>>> In the multiple background applications scenario, when launching a large
>>>> memory application such as a camera, system may enter a low memory state,
>>>> which will triggers the killing of multiple background processes at the
>>>> same time. Due to multiple exiting processes occupying multiple CPUs for
>>>> concurrent execution, the current foreground application's CPU resources
>>>> are tight and may cause issues such as lagging.
>>>>
>>>> To solve this problem, we have introduced the multiple exiting process
>>>> asynchronous swap memory release mechanism, which isolates and caches
>>>> swap entries occupied by multiple exit processes, and hands them over
>>>> to an asynchronous kworker to complete the release. This allows the
>>>> exiting processes to complete quickly and release CPU resources. We have
>>>> validated this modification on the products and achieved the expected
>>>> benefits.
>>> Dumb question: why can't this be done in userspace?  The exiting
>>> process does fork/exit and lets the child do all this asynchronous freeing?
>> The logic optimization for kernel releasing swap entries cannot be
>> implemented in userspace. The multiple exiting processes here own
>> their independent mm, rather than parent and child processes share the
>> same mm. Therefore, when the kernel executes multiple exiting process
>> simultaneously, they will definitely occupy multiple CPU core resources
>> to complete it.
>>>> It offers several benefits:
>>>> 1. Alleviate the high system cpu load caused by multiple exiting
>>>>      processes running simultaneously.
>>>> 2. Reduce lock competition in swap entry free path by an asynchronous
>>>>      kworker instead of multiple exiting processes parallel execution.
>>> Why is lock contention reduced?  The same amount of work needs to be
>>> done.
>> When multiple CPU cores run to release the different swap entries belong
>> to different exiting processes simultaneously, cluster lock or swapinfo
>> lock may encounter lock contention issues, and while an asynchronous
>> kworker that only occupies one CPU core is used to complete this work,
>> it can reduce the probability of lock contention and free up the
>> remaining CPU core resources for other non-exiting processes to use.
>>>> 3. Release memory occupied by exiting processes more efficiently.
>>> Probably it's slightly less efficient.
>> We observed that using an asynchronous kworker can result in more free
>> memory earlier. When multiple processes exit simultaneously, due to CPU
>> core resources competition, these exiting processes remain in a
>> runnable state for a long time and cannot release their occupied memory
>> resources timely.
>>> There are potential problems with this approach of passing work to a
>>> kernel thread:
>>>
>>> - The process will exit while its resources are still allocated.  But
>>>     its parent process assumes those resources are now all freed and the
>>>     parent process then proceeds to allocate resources.  This results in
>>>     a time period where peak resource consumption is higher than it was
>>>     before such a change.
>> - I don't think this modification will cause such a problem. Perhaps I
>>     haven't fully understood your meaning yet. Can you give me a specific
>>     example?
> Normally, after completing zap_pte_range, your swap slots are returned to
> the swap file, except for a few slot caches. However, with the asynchronous
> approach, it means that even after your process has completely exited,
>   some swap slots might still not be released to the system. This could
> potentially starve other processes waiting for swap slots to perform
> swap-outs. I assume this isn't a critical issue for you because, in the
> case of killing processes, freeing up memory is more important than
> releasing swap entries?
  I did not encounter issues caused by the slow release of swap entries
by asynchronous kworker during our testing. Normally, asynchronous
kworker can also release cached swap entries in a short period of time.
Of course, if the system allows, it is necessary to increase the running
priority of the asynchronous kworker appropriately in order to release
swap entries faster, which is also beneficial for the system.

The swap-out datas for swap entries is also compressed and stored in the
zram memory space, so it is relatively important to release the zram
memory space corresponding to swap entries as soon as possible.
>
>>> - If all CPUs are running in userspace with realtime policy
>>>     (SCHED_FIFO, for example) then the kworker thread will not run,
>>>     indefinitely.
>> - In my clumsy understanding, the execution priority of kernel threads
>>     should not be lower than that of the exiting process, and the
>>     asynchronous kworker execution should only be triggered when the
>>     process exits. The exiting process should not be set to SCHED_LFO,
>>     so when the exiting process is executed, the asynchronous kworker
>>     should also have opportunity to get timely execution.
>>> - Work which should have been accounted to the exiting process will
>>>     instead go unaccounted.
>> - You are right, the statistics of process exit time may no longer be
>>     complete.
>>> So please fully address all these potential issues.
>> Thanks
>> Zhiguo
>>
> Thanks
> Barry
Thanks
Zhiguo


