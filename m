Return-Path: <linux-arch+bounces-5775-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B302894312E
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jul 2024 15:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 695942825C5
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jul 2024 13:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C20A1B29C5;
	Wed, 31 Jul 2024 13:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="hmiw1Hy0"
X-Original-To: linux-arch@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2046.outbound.protection.outlook.com [40.107.117.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6DE1AD3FE;
	Wed, 31 Jul 2024 13:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722433388; cv=fail; b=qQGPHtfly1zCBvARpvuGeTlhhFkQIm7bCa6BJ5Kklb5/ta/NxutNZWEM81I+hc4VGDsFOu5BJfq/83OxzKJQrysQRzwgUu9GGofcACwHqcxNg3lKP75TUso9zl6nicORfCi7UCSqSKiY3Gt7lVG1+8C+2l7x3KX/G+e5hBb9g7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722433388; c=relaxed/simple;
	bh=V/BvUE7R8mIcqvZnAOKMZqq2Y/6U4TlRmaAfjXX2Gcg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=S+2xaoZluDdInloD38RSsxatd8RdeWIFAZ4bGYnQtxTJ8Y2yQIeVgZSU1csdynUHtQ3skgT/jduhMP3nq18CT50ZVn0yvpP+qZhDU8kdx3pUR/Oz61VWJCMp71/K+ljlqNYtCEXB6QQsnnifiqngNWf42GLGy21WEvVPuN7XSnA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=hmiw1Hy0; arc=fail smtp.client-ip=40.107.117.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EMGia1RhHv5YkN2pS970+lpbIE/i5WP44XSrLJ0oyIQayO0AvFc86SMCVFKzWdalydipYLOSo0VnggaUqZFnxyaJ94U28ZkOlQmxlgSTOjq3N4Uijbj7vRvfaG29F/WuC2PFollCkjMy1L5C8E/uASQYfG09zztOSF7ZlbLs+oaK87WNe3U0MuKlgmsCA8VzvZaZNboO5v/Dq91lVzAcvHCEOCf17ltjh/ESdPL2YL2DIuh45ZzrFK2rNmpBt1N227u0iIjd4ZO47pudfFsUG1QP+jXyXKAYgeQxJi0Icq//tG3GrA0UufokyhakiO5CQER+o03lyyhV+C42TGlkyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dolIl/AeRiW5suYiDexgbywRgxoZoRMHfwDQhCcQB4I=;
 b=vc/z44LDbotKGBF9HLYTbjs+mTujbO6kfEgPzGPGhRQls+YbhnGzSGkIXNKYNGNhA6enfMObUt77ENV6UV+4wSA03ZT4UUKjyfbilpk5ysI8BqeU+FiVlYFDjzezrACzLROlH2gflZR37IopQG5GhZ/76X5hN/kUwA/hQdX+OeF1hcXht6IutHkBdkHca1tV5vkQwJcs8MY/9FyJW3AN83yroPkcuuwTtM8wn+OHUCY/z9neX0MvmmUzHcUCpofeibH4FaxB9NncL9pDeLATvwXSR8KAyEL/USt3X/p9MJFqxAHwp5UloSuK7VZETTRxCoMs7CS05UnpFuMVb12mlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dolIl/AeRiW5suYiDexgbywRgxoZoRMHfwDQhCcQB4I=;
 b=hmiw1Hy0oNrpdZFnFiM4UsjShMTi26cpMEMP8C5ZzL31fzwmhYmiJqKf7qeko3sdfI+ZfvIGqVX/7VUlbrlrMJqIk41+6VwaP85JWF2gdezCcaWphwdwZUYYt/cMT5KTAiX4pPx1WGdod4OXxsyQxjiPNnRH7yvFXv1L+NYtNrvnPz6r+c0rbXmRdCn4fJgQy6IqgLtOJLQnXkLenRyDSB9alk5JA0yMDDENbNJropKneHwOze9TqUOeLJlRigqoO0jYDbGHHH7NjPZl3Fe4h9lU+IJGqZyEoax9Lk6HCMGwyHNtwouSehR9pKtuh6NygjD2kTtd+I2CQj3LlEFM/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by SEYPR06MB6904.apcprd06.prod.outlook.com (2603:1096:101:1e1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Wed, 31 Jul
 2024 13:43:02 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed%3]) with mapi id 15.20.7828.016; Wed, 31 Jul 2024
 13:43:02 +0000
Message-ID: <7986a0a9-79c7-46b9-8227-ebf8835ef08f@vivo.com>
Date: Wed, 31 Jul 2024 21:42:55 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] mm: tlb: add tlb swap entries batch async release
To: kernel test robot <lkp@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 Will Deacon <will@kernel.org>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Nick Piggin <npiggin@kernel.dk>, Peter Zijlstra <peterz@infradead.org>,
 Arnd Bergmann <arnd@arndb.de>, Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 linux-arch@vger.kernel.org, cgroups@vger.kernel.org,
 Barry Song <21cnbao@gmail.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 Linux Memory Management List <linux-mm@kvack.org>, opensource.kernel@vivo.com
References: <20240730114426.511-3-justinjiang@vivo.com>
 <202407311703.8q8sDQ2p-lkp@intel.com>
From: zhiguojiang <justinjiang@vivo.com>
In-Reply-To: <202407311703.8q8sDQ2p-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG3P274CA0007.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::19)
 To JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|SEYPR06MB6904:EE_
X-MS-Office365-Filtering-Correlation-Id: bd5150a4-6561-47e9-98cd-08dcb166b26a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020|43062017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VWtobWowVDF2YVJVaWZqWjNBTXl2aUpBVk9mMmNqY1dNdi9rQVcxYkhLZThQ?=
 =?utf-8?B?N1FWc1dHeE1vTnFmWC9IZElaQlNWTU9nQkVRMmpFOXl5aUhMM282ZkdwSWw5?=
 =?utf-8?B?Tk9xMUFjb0JuUXNJOG82NmQvb2pUSlFGUlBWVW5SMHJjWFR6c0RqYy9xeTB2?=
 =?utf-8?B?N3ErcWJiWHJNekdaQ0ZkRDZrSWxoYzVPNmUxTklEVHF1U3pJRnNHYVAvOEh4?=
 =?utf-8?B?MTNYbzhIc0dhOGxhNXdnUEpMdkhlVHZFWTlJRHA3enhyNU1FYXJwK25rZzNj?=
 =?utf-8?B?d2hRaGEzbkcyQldHbjIyNmdYeUF0aEFlaVc4a2htODVrMXJTaTdQOE5BNkIz?=
 =?utf-8?B?d0hRSzdhZS9Nd0M2MFNsak45VzZ5NzQxL3ZkOHRWK0NGU2VJK0ltUUJVTXRK?=
 =?utf-8?B?UTNsQXRQenRJZ0RLcUlyZGloTndBWDlTVklzcVNhb1NITDFjaWk1dkVwU2to?=
 =?utf-8?B?QnE4eTJFRTdmejZPK1YrVmFVWGFhVVJHczErM0NQMWtjZ0VjQlBNM2d5cGh3?=
 =?utf-8?B?cUtiUzFMazVXYWhNckI5Q09ZRUtZZ05yanlnNU9PaG1qdzNkTjVOQjVhNDQr?=
 =?utf-8?B?QlJQeTdPam5TQUhTOHFUNjRvODhIRGxjc2ZBSEJFcnlqRkdiRzQ0Q281YndX?=
 =?utf-8?B?UktaTGJOV0ZkRjRQYVdYeUNjK1M5eFpDRjV3eUQ4MmxhUVNoOG1SM3lndU9U?=
 =?utf-8?B?TzJQUGVuVlV6akZtQnp5UmdaV3FveGE4d2gxN0d5STdFS3pCazBiL0JtTTh4?=
 =?utf-8?B?dDl2OFFDZWlTTS9sL0EvSHo3VzFEbUs1WWExeVFHcUdySGtQaTltNTJneUYw?=
 =?utf-8?B?QjRCdmw1QlpmR3p5MkdzSWhISHhlOXh6T3phRGJxbk9ud1lBbCsvTW8vdU85?=
 =?utf-8?B?RE1CRkE5QTZtdkl2aFU2MGhhRUR1TWMxZ3RaeWFETmJTSGlQYVhONll5SzVa?=
 =?utf-8?B?cEdVc3FXSEVjWW85bDVMRWRFdXZWMm8rendWbTNqYjhiMzMwR0YvYi9XQ2xE?=
 =?utf-8?B?RVdEKzRQdld3UUlSWDVkZUhMcHpOWDIrR1BrVldqV2s4Vkg4TlcrbEtBcmF5?=
 =?utf-8?B?K1dnZFJicWJZdFBpQlo0SnJmMSt1SCtjN0k3dWI1eC9lRSt6NlVxblFQS3NW?=
 =?utf-8?B?c0RZaENuTU9YNFJWSWl3M1dyRm9pSlUwOFBLRTV2TzJ5cnQ2OWJnVHZ3S3N5?=
 =?utf-8?B?Qkl4bkphWG5mRkZyb3VYYzU3NEx0TWoyNGlJVDBycWM2a2ZyOHJwWUpHamc5?=
 =?utf-8?B?b3pFTE50NHpzL0taY2NLQm5pS3lqTERza2JXK3VlQVdqeUNPa0QwUHhybWZn?=
 =?utf-8?B?cXg5OUZIQm9yN05VdFhTRFVUdFRYTS9JamRYRGpjTUhOMlhmVk00RlRmUlBG?=
 =?utf-8?B?bG1zWlA1TmlYWkErN0VkZXl4YnBwTHVUM1JmeXlmT3Y1cjF0empYczdRZDNC?=
 =?utf-8?B?N1VteTd5aXJGSk5lZkh2NG1pMmxOZU42a20wT2FwUGtMRUQ1RUk3M1ZFNzF6?=
 =?utf-8?B?bHA2Rk5YUTF4T1VaaGUzR0RIV1BTUC9kMjRtRU81SzNuOTU1VmY3T0k3ZzA4?=
 =?utf-8?B?alQ4OWZkbGJ6aEQ1YU5IYVpUSkRXZGRickRQbzN6UFprM290UElRZTVoT25u?=
 =?utf-8?B?SjFEMFp3eCswREd6OXBSL2RCeVJObjZzd0l5TXJob2FPUkpyRTFjbVRUaDFZ?=
 =?utf-8?B?Z3IzbkE0SVdDcndMY2Vaamlnb05DcUgvT0U0bXZRNUxrakVBVnE2eWpxS3Ey?=
 =?utf-8?B?NHFkaXZWYUVMUUtRYmw0ZFc3dWJCMzBmbWxjNTZOWlQvY2RzZEtsb0hSa0RL?=
 =?utf-8?Q?jkX2+ZH/z0xWP2ItSfo+R6H+DfOCVBdJalgS8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(43062017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ajBHYW1JcEkvYS9KdGo0b0ZwRk4zbTJCZVVWcERTTkdqSXIySEgvV3dRaXc3?=
 =?utf-8?B?RkFCREhORElUMmRqK0E5Y2dPQ2xvYUtSMEJMYXhpaStXVkErbUJzaUFyY1dx?=
 =?utf-8?B?ZFZ1U2xEcEJDaHhubFdnVHQ0Qms1TFRVaHY5RlZINElkTDQrdFVicGV1bDE5?=
 =?utf-8?B?TVdjZUozWFFESnNaKytCWlZ3ZWhJUGhOOXlHb3BueTV0cW9xOG9ENEVtWEFu?=
 =?utf-8?B?TEVyai9tUjBxNDk5R2tZYzBYQnUrcm1BeWljRml0ZGU5eDhlMHIwZkdVU1dr?=
 =?utf-8?B?T0M2QmtBN285ODFjdURIM3k1NlhBdXV1VENiTC9WNGFJWDRmV3pEdVh2ZzJx?=
 =?utf-8?B?ZENpM0ovY3ZnT1J3Qkh1T3U2T3kwVEx0bk9tUnlhRmRDMTYvcm9IS3NzRktI?=
 =?utf-8?B?N0hWcGtNV013aVZvWlZSM3V4eWh5SEZ4M2lKaUE0VnJTRzVvQTZ6ZUExeTBh?=
 =?utf-8?B?NklhcmFJZHBuOVYyQm9nWEIyMkhDbGRtbXNWdm1zRU4rY1JUOUlpK25RenBV?=
 =?utf-8?B?Y2hhVzV5My9aQ01kL2V0aU16VEo4RXNsY2orSXlEbzVobzZJTnRnYVpLWGRP?=
 =?utf-8?B?UVNNYngweXhHdU91dm55QmYyQkpkTWx6aTJ6Z1NPeWhrN1NZUDV3UjI1QUls?=
 =?utf-8?B?UEYwNWFFNXo0ZXF0SzZNVUpQYXFsS0t3cEs2SU0xRm14ZFQxRGVJQmRZZCtn?=
 =?utf-8?B?WmpydDJyVkpGMFVRWG90OWVrT2djeE4xMGM3OVY1dFNYWTdIbTAvWGZxaGpX?=
 =?utf-8?B?TFZqTUJxRzhzR0tVRkljTDNubzgzOGxWSTRkRExlRVBDeDcxNEVNYSsvdzN3?=
 =?utf-8?B?aENTQmlTSVZxdWRRWVJldXVvM29MQ1o4UEgyL1J3REpYWE1RUXRtOCsxK2Ru?=
 =?utf-8?B?ZXV2TVdYekZ0OVdiZmpMZ1cyVXRaZndJblRMbGxya3ltbFZPMXdwOWN1Sk5T?=
 =?utf-8?B?ZWlWLzlGcjRjd0s3MTlVK3ZOTzRBSWlTamdoTXVoRzQvSmE0ZStZbWlHMWli?=
 =?utf-8?B?d3RmT2hZMVZoSHNVQzdjQmxuR1lCYS9xbnpLMk5FNFovOG1waFdJSm9iOHZE?=
 =?utf-8?B?K3FzNTRMWEUzcVFMajUyTWRaT3RrL0EvUVFnRmgyUWRTekcvbjBzZnc4S0oy?=
 =?utf-8?B?SjgzVmg1K0drc0hRN3ZReE9OTGovdmpQTVJ1Um5sSUJXOGhxcG9VQ3BPQmFn?=
 =?utf-8?B?b1FZUUxrRmJFWGMwZmIxYmhKb3U3SzkzU2hvZ0tBRFJuRzFyV0IyK2dRUGtj?=
 =?utf-8?B?NXRyRElJSWpqZTIvWUFpYjF4NENUQzRzZXdUMElENTJScmRNOXVNVGNlejlr?=
 =?utf-8?B?NFhsU0NiR0ltcGtHczBvVVgyWmlSV2s4dWZxd09LNFVZK1NpYVA2eVRhSDVp?=
 =?utf-8?B?MnJtWWNsVkpvN09FVjVESWtoODl0OHJvTVZpdFJjWk1wNjB3VllDbTU5Zkts?=
 =?utf-8?B?enhPeWgrVHE0UFd0L2FWOWZoVStwL1c5azVxZmZBS0RNelRPMzZzN3RVUFJI?=
 =?utf-8?B?RFpjRnBWQmhqSG1kallpSUlwUVMrb0R2Q2I3VHVTSU1Kay8vNWg1U3VNQWlR?=
 =?utf-8?B?WHE2SUR4K1BQZFVDdVp3V25yQXFDVzhhZGQ5NERzOTNHV0k3TW04MGtCMnNM?=
 =?utf-8?B?VXlWc3J5SE5mVlZsMmJad2JZREt3dS9JTi9OdEphczZEUVJOMUJidGtjSG9u?=
 =?utf-8?B?MUtqeEJFVFYwUVZyc2xXdC9WZGtvUlFtL1NwTGZEaXVyUi9JdHhyRi9ONHpJ?=
 =?utf-8?B?dis5S2hvSkwyZlNOUlo1RjNwRVlKY0FxYXV1VHJWdkxvMjhwak1MNnd6Vmhz?=
 =?utf-8?B?QVZuTlpyNnQ0R1RWQWlWSTA0L3NCRUl6NGgyRlNiT2x3WSs2TTFYM0RMcW1G?=
 =?utf-8?B?SkFodk95SUxrUzUrQTc3TGJkc1BTYlN6N3JIcFpmN0VtbWl5VHgvUmhCMEdx?=
 =?utf-8?B?R2RHUXFCQ1M1VnJXMVhaNlVGWWFoZHd4d08yamc0SFlhc0kwK1B0N2dLZjB6?=
 =?utf-8?B?dVRNK2ZVaTZETXJCVks3QklCZ3J2WHNUcEx2NWlxK1EwUEMxWmM2aEU0Vnlk?=
 =?utf-8?B?c2ZGUUhQUjlVUWRrQ1hkdGNqV3FxWTJxa2pKR2E0Mm5uNnlRU2EyckRHVm9r?=
 =?utf-8?Q?fSxY2j4N7QHveaendLF/AzhnL?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd5150a4-6561-47e9-98cd-08dcb166b26a
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 13:43:01.9415
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Psgc7U3LkUKFS/IHB5NS5u4UjffLe/OvSV0Z90syilN+MoCpigUt5csGB4FdGFf18UpNZ8B0N+PB/qlZzJvGow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6904



在 2024/7/31 17:55, kernel test robot 写道:
> [Some people who received this message don't often get email from lkp@intel.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> Hi Zhiguo,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on akpm-mm/mm-everything]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Zhiguo-Jiang/mm-move-task_is_dying-to-h-headfile/20240730-215136
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
> patch link:    https://lore.kernel.org/r/20240730114426.511-3-justinjiang%40vivo.com
> patch subject: [PATCH 2/2] mm: tlb: add tlb swap entries batch async release
> config: s390-allnoconfig (https://download.01.org/0day-ci/archive/20240731/202407311703.8q8sDQ2p-lkp@intel.com/config)
> compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project ccae7b461be339e717d02f99ac857cf0bc7d17fc)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240731/202407311703.8q8sDQ2p-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202407311703.8q8sDQ2p-lkp@intel.com/
Hi,

I have fixed the arch s390 config compilation warning in v2. Please 
kindly help to test again.
https://lore.kernel.org/linux-mm/20240731133318.527-1-justinjiang@vivo.com/T/#t

Thanks
> All error/warnings (new ones prefixed by >>):
>
>     In file included from arch/s390/mm/init.c:17:
>     In file included from include/linux/ptrace.h:10:
>     In file included from include/linux/pid_namespace.h:7:
>     In file included from include/linux/mm.h:2234:
>     include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
>       514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
>           |                               ~~~~~~~~~~~ ^ ~~~
>     In file included from arch/s390/mm/init.c:25:
>     In file included from include/linux/memblock.h:13:
>     In file included from arch/s390/include/asm/dma.h:5:
>     In file included from include/linux/io.h:14:
>     In file included from arch/s390/include/asm/io.h:93:
>     include/asm-generic/io.h:548:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>       548 |         val = __raw_readb(PCI_IOBASE + addr);
>           |                           ~~~~~~~~~~ ^
>     include/asm-generic/io.h:561:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>       561 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
>           |                                                         ~~~~~~~~~~ ^
>     include/uapi/linux/byteorder/big_endian.h:37:59: note: expanded from macro '__le16_to_cpu'
>        37 | #define __le16_to_cpu(x) __swab16((__force __u16)(__le16)(x))
>           |                                                           ^
>     include/uapi/linux/swab.h:102:54: note: expanded from macro '__swab16'
>       102 | #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
>           |                                                      ^
>     In file included from arch/s390/mm/init.c:25:
>     In file included from include/linux/memblock.h:13:
>     In file included from arch/s390/include/asm/dma.h:5:
>     In file included from include/linux/io.h:14:
>     In file included from arch/s390/include/asm/io.h:93:
>     include/asm-generic/io.h:574:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>       574 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
>           |                                                         ~~~~~~~~~~ ^
>     include/uapi/linux/byteorder/big_endian.h:35:59: note: expanded from macro '__le32_to_cpu'
>        35 | #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
>           |                                                           ^
>     include/uapi/linux/swab.h:115:54: note: expanded from macro '__swab32'
>       115 | #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
>           |                                                      ^
>     In file included from arch/s390/mm/init.c:25:
>     In file included from include/linux/memblock.h:13:
>     In file included from arch/s390/include/asm/dma.h:5:
>     In file included from include/linux/io.h:14:
>     In file included from arch/s390/include/asm/io.h:93:
>     include/asm-generic/io.h:585:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>       585 |         __raw_writeb(value, PCI_IOBASE + addr);
>           |                             ~~~~~~~~~~ ^
>     include/asm-generic/io.h:595:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>       595 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
>           |                                                       ~~~~~~~~~~ ^
>     include/asm-generic/io.h:605:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>       605 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
>           |                                                       ~~~~~~~~~~ ^
>     include/asm-generic/io.h:693:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>       693 |         readsb(PCI_IOBASE + addr, buffer, count);
>           |                ~~~~~~~~~~ ^
>     include/asm-generic/io.h:701:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>       701 |         readsw(PCI_IOBASE + addr, buffer, count);
>           |                ~~~~~~~~~~ ^
>     include/asm-generic/io.h:709:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>       709 |         readsl(PCI_IOBASE + addr, buffer, count);
>           |                ~~~~~~~~~~ ^
>     include/asm-generic/io.h:718:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>       718 |         writesb(PCI_IOBASE + addr, buffer, count);
>           |                 ~~~~~~~~~~ ^
>     include/asm-generic/io.h:727:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>       727 |         writesw(PCI_IOBASE + addr, buffer, count);
>           |                 ~~~~~~~~~~ ^
>     include/asm-generic/io.h:736:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>       736 |         writesl(PCI_IOBASE + addr, buffer, count);
>           |                 ~~~~~~~~~~ ^
>     In file included from arch/s390/mm/init.c:42:
>     In file included from arch/s390/include/asm/tlb.h:39:
>>> include/asm-generic/tlb.h:327:6: warning: no previous prototype for function '__tlb_remove_swap_entries' [-Wmissing-prototypes]
>       327 | bool __tlb_remove_swap_entries(struct mmu_gather *tlb,
>           |      ^
>     include/asm-generic/tlb.h:327:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>       327 | bool __tlb_remove_swap_entries(struct mmu_gather *tlb,
>           | ^
>           | static
>     14 warnings generated.
> --
>     In file included from arch/s390/mm/pgtable.c:11:
>     In file included from include/linux/mm.h:2234:
>     include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
>       514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
>           |                               ~~~~~~~~~~~ ^ ~~~
>     In file included from arch/s390/mm/pgtable.c:22:
>     In file included from arch/s390/include/asm/tlb.h:39:
>>> include/asm-generic/tlb.h:327:6: warning: no previous prototype for function '__tlb_remove_swap_entries' [-Wmissing-prototypes]
>       327 | bool __tlb_remove_swap_entries(struct mmu_gather *tlb,
>           |      ^
>     include/asm-generic/tlb.h:327:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>       327 | bool __tlb_remove_swap_entries(struct mmu_gather *tlb,
>           | ^
>           | static
>     2 warnings generated.
> --
>     In file included from mm/memory.c:44:
>     In file included from include/linux/mm.h:2234:
>     include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
>       514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
>           |                               ~~~~~~~~~~~ ^ ~~~
>     In file included from mm/memory.c:45:
>     include/linux/mm_inline.h:47:41: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
>        47 |         __mod_lruvec_state(lruvec, NR_LRU_BASE + lru, nr_pages);
>           |                                    ~~~~~~~~~~~ ^ ~~~
>     include/linux/mm_inline.h:49:22: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
>        49 |                                 NR_ZONE_LRU_BASE + lru, nr_pages);
>           |                                 ~~~~~~~~~~~~~~~~ ^ ~~~
>     In file included from mm/memory.c:84:
>     In file included from arch/s390/include/asm/io.h:93:
>     include/asm-generic/io.h:548:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>       548 |         val = __raw_readb(PCI_IOBASE + addr);
>           |                           ~~~~~~~~~~ ^
>     include/asm-generic/io.h:561:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>       561 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
>           |                                                         ~~~~~~~~~~ ^
>     include/uapi/linux/byteorder/big_endian.h:37:59: note: expanded from macro '__le16_to_cpu'
>        37 | #define __le16_to_cpu(x) __swab16((__force __u16)(__le16)(x))
>           |                                                           ^
>     include/uapi/linux/swab.h:102:54: note: expanded from macro '__swab16'
>       102 | #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
>           |                                                      ^
>     In file included from mm/memory.c:84:
>     In file included from arch/s390/include/asm/io.h:93:
>     include/asm-generic/io.h:574:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>       574 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
>           |                                                         ~~~~~~~~~~ ^
>     include/uapi/linux/byteorder/big_endian.h:35:59: note: expanded from macro '__le32_to_cpu'
>        35 | #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
>           |                                                           ^
>     include/uapi/linux/swab.h:115:54: note: expanded from macro '__swab32'
>       115 | #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
>           |                                                      ^
>     In file included from mm/memory.c:84:
>     In file included from arch/s390/include/asm/io.h:93:
>     include/asm-generic/io.h:585:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>       585 |         __raw_writeb(value, PCI_IOBASE + addr);
>           |                             ~~~~~~~~~~ ^
>     include/asm-generic/io.h:595:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>       595 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
>           |                                                       ~~~~~~~~~~ ^
>     include/asm-generic/io.h:605:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>       605 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
>           |                                                       ~~~~~~~~~~ ^
>     include/asm-generic/io.h:693:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>       693 |         readsb(PCI_IOBASE + addr, buffer, count);
>           |                ~~~~~~~~~~ ^
>     include/asm-generic/io.h:701:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>       701 |         readsw(PCI_IOBASE + addr, buffer, count);
>           |                ~~~~~~~~~~ ^
>     include/asm-generic/io.h:709:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>       709 |         readsl(PCI_IOBASE + addr, buffer, count);
>           |                ~~~~~~~~~~ ^
>     include/asm-generic/io.h:718:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>       718 |         writesb(PCI_IOBASE + addr, buffer, count);
>           |                 ~~~~~~~~~~ ^
>     include/asm-generic/io.h:727:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>       727 |         writesw(PCI_IOBASE + addr, buffer, count);
>           |                 ~~~~~~~~~~ ^
>     include/asm-generic/io.h:736:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>       736 |         writesl(PCI_IOBASE + addr, buffer, count);
>           |                 ~~~~~~~~~~ ^
>     In file included from mm/memory.c:88:
>     In file included from arch/s390/include/asm/tlb.h:39:
>>> include/asm-generic/tlb.h:327:6: warning: no previous prototype for function '__tlb_remove_swap_entries' [-Wmissing-prototypes]
>       327 | bool __tlb_remove_swap_entries(struct mmu_gather *tlb,
>           |      ^
>     include/asm-generic/tlb.h:327:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>       327 | bool __tlb_remove_swap_entries(struct mmu_gather *tlb,
>           | ^
>           | static
>     16 warnings generated.
> --
>     In file included from mm/mmap.c:14:
>     In file included from include/linux/backing-dev.h:15:
>     In file included from include/linux/device.h:32:
>     In file included from include/linux/device/driver.h:21:
>     In file included from include/linux/module.h:19:
>     In file included from include/linux/elf.h:6:
>     In file included from arch/s390/include/asm/elf.h:181:
>     In file included from arch/s390/include/asm/mmu_context.h:11:
>     In file included from arch/s390/include/asm/pgalloc.h:18:
>     In file included from include/linux/mm.h:2234:
>     include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
>       514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
>           |                               ~~~~~~~~~~~ ^ ~~~
>     In file included from mm/mmap.c:16:
>     include/linux/mm_inline.h:47:41: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
>        47 |         __mod_lruvec_state(lruvec, NR_LRU_BASE + lru, nr_pages);
>           |                                    ~~~~~~~~~~~ ^ ~~~
>     include/linux/mm_inline.h:49:22: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
>        49 |                                 NR_ZONE_LRU_BASE + lru, nr_pages);
>           |                                 ~~~~~~~~~~~~~~~~ ^ ~~~
>     In file included from mm/mmap.c:53:
>     In file included from arch/s390/include/asm/tlb.h:39:
>>> include/asm-generic/tlb.h:327:6: warning: no previous prototype for function '__tlb_remove_swap_entries' [-Wmissing-prototypes]
>       327 | bool __tlb_remove_swap_entries(struct mmu_gather *tlb,
>           |      ^
>     include/asm-generic/tlb.h:327:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>       327 | bool __tlb_remove_swap_entries(struct mmu_gather *tlb,
>           | ^
>           | static
>     4 warnings generated.
> --
>     In file included from mm/mremap.c:11:
>     In file included from include/linux/mm.h:2234:
>     include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
>       514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
>           |                               ~~~~~~~~~~~ ^ ~~~
>     In file included from mm/mremap.c:12:
>     include/linux/mm_inline.h:47:41: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
>        47 |         __mod_lruvec_state(lruvec, NR_LRU_BASE + lru, nr_pages);
>           |                                    ~~~~~~~~~~~ ^ ~~~
>     include/linux/mm_inline.h:49:22: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
>        49 |                                 NR_ZONE_LRU_BASE + lru, nr_pages);
>           |                                 ~~~~~~~~~~~~~~~~ ^ ~~~
>     In file included from mm/mremap.c:30:
>     In file included from arch/s390/include/asm/tlb.h:39:
>>> include/asm-generic/tlb.h:327:6: warning: no previous prototype for function '__tlb_remove_swap_entries' [-Wmissing-prototypes]
>       327 | bool __tlb_remove_swap_entries(struct mmu_gather *tlb,
>           |      ^
>     include/asm-generic/tlb.h:327:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>       327 | bool __tlb_remove_swap_entries(struct mmu_gather *tlb,
>           | ^
>           | static
>     mm/mremap.c:228:20: warning: unused function 'arch_supports_page_table_move' [-Wunused-function]
>       228 | static inline bool arch_supports_page_table_move(void)
>           |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     mm/mremap.c:227:39: note: expanded from macro 'arch_supports_page_table_move'
>       227 | #define arch_supports_page_table_move arch_supports_page_table_move
>           |                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     5 warnings generated.
> --
>     In file included from kernel/sched/core.c:10:
>     In file included from include/linux/highmem.h:10:
>     In file included from include/linux/mm.h:2234:
>     include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
>       514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
>           |                               ~~~~~~~~~~~ ^ ~~~
>     In file included from kernel/sched/core.c:34:
>     In file included from include/linux/sched/isolation.h:7:
>     In file included from include/linux/tick.h:8:
>     In file included from include/linux/clockchips.h:14:
>     In file included from include/linux/clocksource.h:22:
>     In file included from arch/s390/include/asm/io.h:93:
>     include/asm-generic/io.h:548:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>       548 |         val = __raw_readb(PCI_IOBASE + addr);
>           |                           ~~~~~~~~~~ ^
>     include/asm-generic/io.h:561:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>       561 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
>           |                                                         ~~~~~~~~~~ ^
>     include/uapi/linux/byteorder/big_endian.h:37:59: note: expanded from macro '__le16_to_cpu'
>        37 | #define __le16_to_cpu(x) __swab16((__force __u16)(__le16)(x))
>           |                                                           ^
>     include/uapi/linux/swab.h:102:54: note: expanded from macro '__swab16'
>       102 | #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
>           |                                                      ^
>     In file included from kernel/sched/core.c:34:
>     In file included from include/linux/sched/isolation.h:7:
>     In file included from include/linux/tick.h:8:
>     In file included from include/linux/clockchips.h:14:
>     In file included from include/linux/clocksource.h:22:
>     In file included from arch/s390/include/asm/io.h:93:
>     include/asm-generic/io.h:574:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>       574 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
>           |                                                         ~~~~~~~~~~ ^
>     include/uapi/linux/byteorder/big_endian.h:35:59: note: expanded from macro '__le32_to_cpu'
>        35 | #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
>           |                                                           ^
>     include/uapi/linux/swab.h:115:54: note: expanded from macro '__swab32'
>       115 | #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
>           |                                                      ^
>     In file included from kernel/sched/core.c:34:
>     In file included from include/linux/sched/isolation.h:7:
>     In file included from include/linux/tick.h:8:
>     In file included from include/linux/clockchips.h:14:
>     In file included from include/linux/clocksource.h:22:
>     In file included from arch/s390/include/asm/io.h:93:
>     include/asm-generic/io.h:585:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>       585 |         __raw_writeb(value, PCI_IOBASE + addr);
>           |                             ~~~~~~~~~~ ^
>     include/asm-generic/io.h:595:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>       595 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
>           |                                                       ~~~~~~~~~~ ^
>     include/asm-generic/io.h:605:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>       605 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
>           |                                                       ~~~~~~~~~~ ^
>     include/asm-generic/io.h:693:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>       693 |         readsb(PCI_IOBASE + addr, buffer, count);
>           |                ~~~~~~~~~~ ^
>     include/asm-generic/io.h:701:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>       701 |         readsw(PCI_IOBASE + addr, buffer, count);
>           |                ~~~~~~~~~~ ^
>     include/asm-generic/io.h:709:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>       709 |         readsl(PCI_IOBASE + addr, buffer, count);
>           |                ~~~~~~~~~~ ^
>     include/asm-generic/io.h:718:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>       718 |         writesb(PCI_IOBASE + addr, buffer, count);
>           |                 ~~~~~~~~~~ ^
>     include/asm-generic/io.h:727:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>       727 |         writesw(PCI_IOBASE + addr, buffer, count);
>           |                 ~~~~~~~~~~ ^
>     include/asm-generic/io.h:736:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>       736 |         writesl(PCI_IOBASE + addr, buffer, count);
>           |                 ~~~~~~~~~~ ^
>     In file included from kernel/sched/core.c:80:
>     In file included from arch/s390/include/asm/tlb.h:39:
>>> include/asm-generic/tlb.h:327:6: warning: no previous prototype for function '__tlb_remove_swap_entries' [-Wmissing-prototypes]
>       327 | bool __tlb_remove_swap_entries(struct mmu_gather *tlb,
>           |      ^
>     include/asm-generic/tlb.h:327:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>       327 | bool __tlb_remove_swap_entries(struct mmu_gather *tlb,
>           | ^
>           | static
>     kernel/sched/core.c:6330:20: warning: unused function 'sched_core_cpu_deactivate' [-Wunused-function]
>      6330 | static inline void sched_core_cpu_deactivate(unsigned int cpu) {}
>           |                    ^~~~~~~~~~~~~~~~~~~~~~~~~
>     15 warnings generated.
> ..
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki


