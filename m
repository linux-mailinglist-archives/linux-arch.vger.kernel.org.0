Return-Path: <linux-arch+bounces-5979-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1227947E4D
	for <lists+linux-arch@lfdr.de>; Mon,  5 Aug 2024 17:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30DA71F241BB
	for <lists+linux-arch@lfdr.de>; Mon,  5 Aug 2024 15:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE6F15B97A;
	Mon,  5 Aug 2024 15:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="bjcyxr3f"
X-Original-To: linux-arch@vger.kernel.org
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11011032.outbound.protection.outlook.com [52.101.129.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC7C15B54E;
	Mon,  5 Aug 2024 15:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722872222; cv=fail; b=DE1VSDHM35yrVp2dlXus6RD61ti20Os9LgDRKQvBV55Ky7PMJcWVfunz7zJhB91NyqnnY+sTSY0cHtcWziYS5yBw80RVvzc0cQBqrc+8qzxMZLTRSBo/HdKVzL4DKV0oq21I1e2DAZsfJa6aQ7Rqo1NXR6SMhUjZl21kdvImWpI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722872222; c=relaxed/simple;
	bh=68Exx9bfD/gP3Q99GFRthC9DpEmnoMnDw0pJT2VyGVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G+2sG6o+EQD5acizkdXtLWouYPPIyUMCzn51lL6YtOMlQ/q4dCTEr7B72z0iZO0ZAjOQPDq3V8nUjdgHSfVp+/0WCzJGRglhKklugemYS/05AEWkweGx7VV19GME6n4TXOj1btA4RCaOzdL9rOHdQGqGtkUrWzHoknceZw9Bf3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=bjcyxr3f; arc=fail smtp.client-ip=52.101.129.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e0/Q94AAhxUB3VMXka4+i8GtQuZyBuUkRnBnYL9vvRqd7NrzpX+J5HaH5KtcK7HwQw/8l9+F7Xx7/7hEbFYXy3FJJ6sDfr60l0Svb89diCa0PhwdFDUhfRuXrhjdloAc/B5WtFA4hHMMcgn5TuEiOt6MBbLaJ8HL1QgVCg3jkHI8ogYDxWlago/55R1ylYAV1c7RVc+OiYBVFl3/s3QDXu++rOIQIB0nqHFk/axSJQ3+rxhBiKszU815mjw1uyzfrxhrHm1tdOwEXJk+YfxJnKalR+BwLZZG86RJygl3dnXi4QvDNdcpnwtcr3qJIj10q0bOyWtlIK6AYbVXWr/NvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B4k3vmUew+Ccxrgwvhvwo6zaZj4NrRr16ZQekB7aLDs=;
 b=XFf54rm1/NRpiu21nrnCx0hxBxsE7MZXB0YAkdSeMDQdam+TKymGgFI/UPtpM4G/qWQiNwMUdfLtjrYyF6ISSVvtaFEdJXjmxMyWT8GO9o/RM/YqBkjWf4Nsv++NCZF/cJ/+4YSSyUE8EFHvhFGCxF0/oY2qfPSlcP0/yZPqr1fUgHngMjLFb0mFwYWojloM7X2tdLjAb212FswR8Yj0EkHVR9KgJgKu1DxELSZCNU/fyvt9mmiaYoIPpghEcrjS8jrGz/WKNZrBsdFcga0XXDhtlsMlrhEOWEwOo5BT/5yd0SImhv/2dyebCknBd68od4pEQRtIKBrEPtZ57Ns1NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B4k3vmUew+Ccxrgwvhvwo6zaZj4NrRr16ZQekB7aLDs=;
 b=bjcyxr3fZYvJ3BX9PqyPcFRR3p13/N0eKdQqnRYFF4bI8eEuxW64uT4OFupZPPSb1kR1Bl+LhT0IwDrUnhBoDnLdCsrlNckmxYEKNIvDbCd7dRe3HeSwonlrqXn303CTQbRxCFv3VuEhmCCdIizkVypnC2NcGZqItGd6lK5+Zh6Jh2d2vwkHitUCXaOFy7FYfGVcpw2qCi+TZSP9ax8+CB1rqdC6MDA6zvxYwcYKiKey30hGdoOvrTYFPlE1UhZvzqE0fYjCNVcZ2IFG/VW9ltJUJ4S5h0k/suy8LRO3tazha01V/b+ncm2THXks6HC+iGswsnx5ZsCRXu4deCZI4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by OS8PR06MB7322.apcprd06.prod.outlook.com (2603:1096:604:28c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.25; Mon, 5 Aug
 2024 15:36:51 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed%3]) with mapi id 15.20.7828.023; Mon, 5 Aug 2024
 15:36:51 +0000
From: Zhiguo Jiang <justinjiang@vivo.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Will Deacon <will@kernel.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Nick Piggin <npiggin@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	linux-arch@vger.kernel.org,
	cgroups@vger.kernel.org,
	Barry Song <21cnbao@gmail.com>,
	David Hildenbrand <david@redhat.com>,
	Zhiguo Jiang <justinjiang@vivo.com>
Cc: opensource.kernel@vivo.com
Subject: [PATCH v3 2/2] mm: tlb: add tlb swap entries batch async release
Date: Mon,  5 Aug 2024 23:36:38 +0800
Message-ID: <20240805153639.1057-3-justinjiang@vivo.com>
X-Mailer: git-send-email 2.41.0.windows.3
In-Reply-To: <20240805153639.1057-1-justinjiang@vivo.com>
References: <20240805153639.1057-1-justinjiang@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0001.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::7)
 To JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|OS8PR06MB7322:EE_
X-MS-Office365-Filtering-Correlation-Id: f47a112e-1705-4415-9d26-08dcb5646d17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|52116014|7416014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/NFqX1vvqAh9Qc8CHlEUvBR02zjxBJfix6hfQNDkM+fdxR5f+Yun5lpDx7Bc?=
 =?us-ascii?Q?sKslI2sOsh5Wzy3E0ny+pxbNBA2HZxfrsIS32JrXpyzrCNu8CjUPaHIZE2xD?=
 =?us-ascii?Q?TKjCLKlM+WhqNAkdSSiVuja2ju0HEiW+pytswPlLjN7lxKDwI2J5Je7xCtei?=
 =?us-ascii?Q?NyfXWs3iiha0R9RaWcikkVXonn9MrxkvVVBsNTDWptdqu5Rp54AO8OLQMKSY?=
 =?us-ascii?Q?B6kd9PqYIlekKjLr56XfS4d7E1h53tIf2/KORsLhlQoX7wNmz/E5Efe6DRMH?=
 =?us-ascii?Q?RFi5fTtG5Z3Ejt+kc/Gsv6QaT2TO5sfqWbldfGAPMGwDw7lm4Ai/0hGyfBCu?=
 =?us-ascii?Q?iMevqC7xZCdY3qE8rXztQblphJ3k7/mXNUwTgyTi5COnXJVhYJsMCadIKyob?=
 =?us-ascii?Q?Ri784CNEDWY47nkqnjMsBg3fZUslCLnEpD4AvFvOS3s92Cv4MVcbW0kpc3IS?=
 =?us-ascii?Q?Kmtmp37CCV3vmYdnCIB3MJRYAnqrfW9XQnTyeIRKHUEez/UXGimslh72P0cC?=
 =?us-ascii?Q?qi77589iWJs9/aH+NJng9eFo2YGtDm4ugYQkky25U0N0vCfnc91tfcGSEG64?=
 =?us-ascii?Q?u35lnu7xFBdIyPuwsVSUBu5NrVsTTdeCu+XTOo71N7rJmtG6LCKfNy+731gS?=
 =?us-ascii?Q?Hfkk6mBnHKiu41EFFBCTmoDWaFpDCN0Rw4z4oevS3xdRxmViLbcJliyEqBGp?=
 =?us-ascii?Q?NmYtvOeRgPcdzhTv9OtcUbffDb2l+y9sgZZJbHxLv823EqU+TsbSkTjdAFN8?=
 =?us-ascii?Q?hyDS5L/5IgKAyP1QpGMF6+XWRWsNG1753LneijMoxjeC4/kTjzvnIC1fniP/?=
 =?us-ascii?Q?b/gszmnXX0cG+Lo9ug00atashqvsw7bRRObICOTgjacAyl/hnGTWqhDrw9SM?=
 =?us-ascii?Q?19wUb89GNEQIC97NHRuIbrNbTa5Xlz1T5rFvVmQXu2OvC9AsNWXxIGg88txE?=
 =?us-ascii?Q?N/Q5dTP1vENPXVpSIK87UXPAscbobtRuXeMYUmP3kkvOhMNcgiZ3apYmuXAg?=
 =?us-ascii?Q?C61qxWxhjrgqOe2EWhq6zVr9uttni4g9P4Pou2w3CbvWeHynB/RlRCX88pK5?=
 =?us-ascii?Q?18BPoO2j265jVU9QVB3vxtqpvoNg+AHcMUHsjAXg6HHIFA8ufB9ILyLNAkkV?=
 =?us-ascii?Q?ZIgnMec/dpfpEXDUPFdmREN8d0X4PynpI+A+7arzb1odeuhBjS6Uo99ETHOx?=
 =?us-ascii?Q?lvAhsh9f46d20oOHaZVnSTHtXaX0o64rxFr/LEsj3dI8ZOWajfJwJ8iz1DE8?=
 =?us-ascii?Q?3vT5affH8yxI2ZZn6rAtkxRpZuEORVnwnre/IjAfRN661VJp0J3lQwFHIJhe?=
 =?us-ascii?Q?hZCZq+ks0uhEWV9GzXX9thJFmgp+7NoANNAwCe7Niq2Olm1uH/xrpMExWuCL?=
 =?us-ascii?Q?ljMuX32n1+3opGc2IXcJ4pzeS9WsMCkFPlLCu+sk5baADO1pdJRqz25Yap2A?=
 =?us-ascii?Q?/tm6qt8P+/k=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(52116014)(7416014)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YSnnY7ww2gwm4gvvm9lLkgKQZmExBKaFe5lyws+8RVZaMHdA8W3mbixviEha?=
 =?us-ascii?Q?pFLi3i9Oqo/26PB/BOoAN+FDmCaYINVvy8h/Bk+m+gPn7I/FVWI7UbAEe/D3?=
 =?us-ascii?Q?hkHubh4wcEblZEwL45LX1V2J7KiXo2l/lwNdIVinBiICmmspeulVwvV3lTCF?=
 =?us-ascii?Q?IlN2CrRBuz5w3nFZbrWtMRZ7TlKmZjOfJVMDRlEd8GiRS9SiygmSK+5IE0Ly?=
 =?us-ascii?Q?5z+yzvN2j8lrHFas7w29/E6krS7d7uL24CJUE7iZzfCYD3MM89q6C/hLxRyx?=
 =?us-ascii?Q?holwC0waK9UvNE6mMz30W94+o22ax4rYMyrtQxzZaZ14mJaM0oiUqTUmaTH7?=
 =?us-ascii?Q?Y/Hfkg0FyudKSwcq1tnnHqW8XAsPhrd6mXYqRtQQXMp30fOk8ddQ5Lx90tsk?=
 =?us-ascii?Q?mZl7idC0MfF5GgW78rNbp7K+jvf0A/+RiAGTg1ZF5yoYISlozUNKJa+ylh6u?=
 =?us-ascii?Q?pnCR4FLykdk5E/xuRpenMFzy7aD9/LrEFv/2vMts/SVFnX6G9XqTXeBf4iaI?=
 =?us-ascii?Q?3owYFw7TveK5fGMzZfnbAzsFQ/gWfCXafJmYMc3lSkrLzSDet9os0f+cM5Lq?=
 =?us-ascii?Q?muGdvi4FeftyR3BqLuExxXIMA6t5cNAw4FGVzZM3Fm0SLmpT7TGQ3TW+9oSW?=
 =?us-ascii?Q?o+/IbcC3ZpdLBQa3hq8TgrfxIErzNnR4xu3FR85qFl3iebSINdDlm50lurzh?=
 =?us-ascii?Q?MUMg3BRObUIsUuwg66YgHPccyWXRq12Wa48xRSSF0J+YtvqaTbK6h0j9UzE6?=
 =?us-ascii?Q?GpBPR3HrffptI5XQcXTJ1zlNwro0yFPIGBFcROs9+kG/4fpxnm5O57rbo1ry?=
 =?us-ascii?Q?Q/pcGQq4mCkehsBnNHThx4EJwEa79HZz7hWwfe13Quo9QaAOzcqun3pPN7yI?=
 =?us-ascii?Q?MCN5/uGE+Nu+5pGPzSyIrqA2vS6LtQWhQefPmuOItaDwoQuonOh+SadLuTPY?=
 =?us-ascii?Q?fSwESsF/Ptq7LZnqrAmeFL16Maxy3qJUVK9GmbD+u6wN3iUEBthBn90SyiDB?=
 =?us-ascii?Q?y5YOYlJHS7v3JwkloWoGNRVHE91U/doUOvzl2DGgfua5+IqlVCTUSaFPzKT8?=
 =?us-ascii?Q?uYHRcwVhkN2I8oxI4adsuEYcl1ezOMCMqy7kP5yLF3qIJ3WNS3SKmrkEbDff?=
 =?us-ascii?Q?GpoV6uLZ/1GEU4DAGgd+Et3js6NDybHOcuGNieo5pTGs4CzjBlbLSs1uYNn0?=
 =?us-ascii?Q?cSh8Gx2lvfzBG78TtCFWL45Zaukj3y7HKZNEu8QiDnvY996QGObe7WyoDHaa?=
 =?us-ascii?Q?ENaFipmJdg8dUhZxlfvf7wUGwIJmpTJXpNrneJ30oROcNhXOFMax9ihN93Dt?=
 =?us-ascii?Q?8NVNYjcmCuSicatjjk74r83QSts21vL+TdIB9/m/asHGW8IgMCmy3lwgAFrm?=
 =?us-ascii?Q?QDZhSUXMPXKB1MPMoqAFladkgBfzOKZuIZ6HhSt2czKwT5TyAhGBnbrVkWxj?=
 =?us-ascii?Q?dQPDwvgZJFC37KPYW866b26yNEYi+WM+Tu2Wn4/MlIaRkefN+PZJ/tIotqwL?=
 =?us-ascii?Q?IONJc6+OJJJFIXEizHjrEKze/Ayy0NxrXm9VzQzkH5TFJ4Q2x7Fs0tOQoW+L?=
 =?us-ascii?Q?QMdV5TiQLQ1IsG1vgqVHt8hibEadIBZAT8z/59vm?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f47a112e-1705-4415-9d26-08dcb5646d17
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 15:36:51.4257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k5uwEUol51hEQ6esxAvil4iJRR2XmLcG4KjXAq3oTjDw2Hp0XVT1fLb87Z6NhN+u8fdhFpxqALs/2WqF7GSWYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS8PR06MB7322

One of the main reasons for the prolonged exit of the process with
independent mm is the time-consuming release of its swap entries.
The proportion of swap memory occupied by the process increases over
time due to high memory pressure triggering to reclaim anonymous folio
into swapspace, e.g., in Android devices, we found this proportion can
reach 60% or more after a period of time. Additionally, the relatively
lengthy path for releasing swap entries further contributes to the
longer time required to release swap entries.

Testing Platform: 8GB RAM
Testing procedure:
After booting up, start 15 processes first, and then observe the
physical memory size occupied by the last launched process at different
time points.
Example: The process launched last: com.qiyi.video
|  memory type  |  0min  |  1min  |   5min  |   10min  |   15min  |
-------------------------------------------------------------------
|     VmRSS(KB) | 453832 | 252300 |  204364 |   199944 |  199748  |
|   RssAnon(KB) | 247348 |  99296 |   71268 |    67808 |   67660  |
|   RssFile(KB) | 205536 | 152020 |  132144 |   131184 |  131136  |
|  RssShmem(KB) |   1048 |    984 |     952 |     952  |     952  |
|    VmSwap(KB) | 202692 | 334852 |  362880 |   366340 |  366488  |
| Swap ratio(%) | 30.87% | 57.03% |  63.97% |   64.69% |  64.72%  |
Note: min - minute.

When there are multiple processes with independent mm and the high
memory pressure in system, if the large memory required process is
launched at this time, system will is likely to trigger the instantaneous
killing of many processes with independent mm. Due to multiple exiting
processes occupying multiple CPU core resources for concurrent execution,
leading to some issues such as the current non-exiting and important
processes lagging.

To solve this problem, we have introduced the multiple exiting process
asynchronous swap entries release mechanism, which isolates and caches
swap entries occupied by multiple exiting processes, and hands them over
to an asynchronous kworker to complete the release. This allows the
exiting processes to complete quickly and release CPU resources. We have
validated this modification on the Android products and achieved the
expected benefits.

Testing Platform: 8GB RAM
Testing procedure:
After restarting the machine, start 15 app processes first, and then
start the camera app processes, we monitor the cold start and preview
time datas of the camera app processes.

Test datas of camera processes cold start time (unit: millisecond):
|  seq   |   1  |   2  |   3  |   4  |   5  |   6  | average |
| before | 1498 | 1476 | 1741 | 1337 | 1367 | 1655 |   1512  |
| after  | 1396 | 1107 | 1136 | 1178 | 1071 | 1339 |   1204  |

Test datas of camera processes preview time (unit: millisecond):
|  seq   |   1  |   2  |   3  |   4  |   5  |   6  | average |
| before |  267 |  402 |  504 |  513 |  161 |  265 |   352   |
| after  |  188 |  223 |  301 |  203 |  162 |  154 |   205   |

Base on the average of the six sets of test datas above, we can see that
the benefit datas of the modified patch:
1. The cold start time of camera app processes has reduced by about 20%.
2. The preview time of camera app processes has reduced by about 42%.

It offers several benefits:
1. Alleviate the high system cpu loading caused by multiple exiting
   processes running simultaneously.
2. Reduce lock competition in swap entry free path by an asynchronous
   kworker instead of multiple exiting processes parallel execution.
3. Release pte_present memory occupied by exiting processes more
   efficiently.

Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>
---
 arch/s390/include/asm/tlb.h |   8 +
 include/asm-generic/tlb.h   |  44 ++++++
 include/linux/mm_types.h    |  58 +++++++
 mm/memory.c                 |   3 +-
 mm/mmu_gather.c             | 296 ++++++++++++++++++++++++++++++++++++
 5 files changed, 408 insertions(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/tlb.h b/arch/s390/include/asm/tlb.h
index e95b2c8081eb..3f681f63390f
--- a/arch/s390/include/asm/tlb.h
+++ b/arch/s390/include/asm/tlb.h
@@ -28,6 +28,8 @@ static inline bool __tlb_remove_page_size(struct mmu_gather *tlb,
 		struct page *page, bool delay_rmap, int page_size);
 static inline bool __tlb_remove_folio_pages(struct mmu_gather *tlb,
 		struct page *page, unsigned int nr_pages, bool delay_rmap);
+static inline bool __tlb_remove_swap_entries(struct mmu_gather *tlb,
+		swp_entry_t entry, int nr);
 
 #define tlb_flush tlb_flush
 #define pte_free_tlb pte_free_tlb
@@ -69,6 +71,12 @@ static inline bool __tlb_remove_folio_pages(struct mmu_gather *tlb,
 	return false;
 }
 
+static inline bool __tlb_remove_swap_entries(struct mmu_gather *tlb,
+		swp_entry_t entry, int nr)
+{
+	return false;
+}
+
 static inline void tlb_flush(struct mmu_gather *tlb)
 {
 	__tlb_flush_mm_lazy(tlb->mm);
diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index 709830274b75..8b4d516b35b8
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -294,6 +294,37 @@ extern void tlb_flush_rmaps(struct mmu_gather *tlb, struct vm_area_struct *vma);
 static inline void tlb_flush_rmaps(struct mmu_gather *tlb, struct vm_area_struct *vma) { }
 #endif
 
+#ifndef CONFIG_MMU_GATHER_NO_GATHER
+struct mmu_swap_batch {
+	struct mmu_swap_batch *next;
+	unsigned int nr;
+	unsigned int max;
+	encoded_swpentry_t encoded_entrys[];
+};
+
+#define MAX_SWAP_GATHER_BATCH	\
+	((PAGE_SIZE - sizeof(struct mmu_swap_batch)) / sizeof(void *))
+
+#define MAX_SWAP_GATHER_BATCH_COUNT	(10000UL / MAX_SWAP_GATHER_BATCH)
+
+struct mmu_swap_gather {
+	/*
+	 * the asynchronous kworker to batch
+	 * release swap entries
+	 */
+	struct work_struct free_work;
+
+	/* batch cache swap entries */
+	unsigned int batch_count;
+	struct mmu_swap_batch *active;
+	struct mmu_swap_batch local;
+	encoded_swpentry_t __encoded_entrys[MMU_GATHER_BUNDLE];
+};
+
+bool __tlb_remove_swap_entries(struct mmu_gather *tlb,
+		swp_entry_t entry, int nr);
+#endif
+
 /*
  * struct mmu_gather is an opaque type used by the mm code for passing around
  * any data needed by arch specific code for tlb_remove_page.
@@ -343,6 +374,18 @@ struct mmu_gather {
 	unsigned int		vma_exec : 1;
 	unsigned int		vma_huge : 1;
 	unsigned int		vma_pfn  : 1;
+#ifndef CONFIG_MMU_GATHER_NO_GATHER
+	/*
+	 * Two states of releasing swap entries
+	 * asynchronously:
+	 * swp_freeable - have opportunity to
+	 * release asynchronously future
+	 * swp_freeing - be releasing asynchronously.
+	 */
+	unsigned int		swp_freeable : 1;
+	unsigned int		swp_freeing : 1;
+	unsigned int		swp_disable : 1;
+#endif
 
 	unsigned int		batch_count;
 
@@ -354,6 +397,7 @@ struct mmu_gather {
 #ifdef CONFIG_MMU_GATHER_PAGE_SIZE
 	unsigned int page_size;
 #endif
+	struct mmu_swap_gather *swp;
 #endif
 };
 
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 165c58b12ccc..2f66303f1519
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -283,6 +283,64 @@ typedef struct {
 	unsigned long val;
 } swp_entry_t;
 
+/*
+ * encoded_swpentry_t - a type marking the encoded swp_entry_t.
+ *
+ * An 'encoded_swpentry_t' represents a 'swp_enrty_t' with its the highest
+ * bit indicating extra context-dependent information. Only used in swp_entry
+ * asynchronous release path by mmu_swap_gather.
+ */
+typedef struct {
+	unsigned long val;
+} encoded_swpentry_t;
+
+/*
+ * The next item in an encoded_swpentry_t array is the "nr" argument, specifying the
+ * total number of consecutive swap entries associated with the same folio. If this
+ * bit is not set, "nr" is implicitly 1.
+ *
+ * Refer to include\asm\pgtable.h, swp_offset bits: 0 ~ 57, swp_type bits: 58 ~ 62.
+ * Bit63 can be used here.
+ */
+#define ENCODED_SWPENTRY_BIT_NR_ENTRYS_NEXT (1UL << (BITS_PER_LONG - 1))
+
+static __always_inline encoded_swpentry_t
+encode_swpentry(swp_entry_t entry, unsigned long flags)
+{
+	encoded_swpentry_t ret;
+
+	VM_WARN_ON_ONCE(flags & ~ENCODED_SWPENTRY_BIT_NR_ENTRYS_NEXT);
+	ret.val = flags | entry.val;
+	return ret;
+}
+
+static inline unsigned long encoded_swpentry_flags(encoded_swpentry_t entry)
+{
+	return ENCODED_SWPENTRY_BIT_NR_ENTRYS_NEXT & entry.val;
+}
+
+static inline swp_entry_t encoded_swpentry_data(encoded_swpentry_t entry)
+{
+	swp_entry_t ret;
+
+	ret.val = ~ENCODED_SWPENTRY_BIT_NR_ENTRYS_NEXT & entry.val;
+	return ret;
+}
+
+static __always_inline encoded_swpentry_t encode_nr_swpentrys(unsigned long nr)
+{
+	encoded_swpentry_t ret;
+
+	VM_WARN_ON_ONCE(nr & ENCODED_SWPENTRY_BIT_NR_ENTRYS_NEXT);
+	ret.val = nr;
+	return ret;
+}
+
+static __always_inline unsigned long encoded_nr_swpentrys(encoded_swpentry_t entry)
+{
+	return ((~ENCODED_SWPENTRY_BIT_NR_ENTRYS_NEXT) & entry.val);
+}
+
 /**
  * struct folio - Represents a contiguous set of bytes.
  * @flags: Identical to the page flags.
diff --git a/mm/memory.c b/mm/memory.c
index d6a9dcddaca4..023a8adcb67c
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1650,7 +1650,8 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 			if (!should_zap_cows(details))
 				continue;
 			rss[MM_SWAPENTS] -= nr;
-			free_swap_and_cache_nr(entry, nr);
+			if (!__tlb_remove_swap_entries(tlb, entry, nr))
+				free_swap_and_cache_nr(entry, nr);
 		} else if (is_migration_entry(entry)) {
 			folio = pfn_swap_entry_folio(entry);
 			if (!should_zap_folio(details, folio))
diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
index 99b3e9408aa0..33dc9d1faff9
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -9,11 +9,303 @@
 #include <linux/smp.h>
 #include <linux/swap.h>
 #include <linux/rmap.h>
+#include <linux/oom.h>
 
 #include <asm/pgalloc.h>
 #include <asm/tlb.h>
 
 #ifndef CONFIG_MMU_GATHER_NO_GATHER
+/*
+ * The swp_entry asynchronous release mechanism for multiple processes with
+ * independent mm exiting simultaneously.
+ *
+ * During the multiple exiting processes releasing their own mm simultaneously,
+ * the swap entries in the exiting processes are handled by isolating, caching
+ * and handing over to an asynchronous kworker to complete the release.
+ *
+ * The conditions for the exiting process entering the swp_entry asynchronous
+ * release path:
+ * 1. The exiting process's MM_SWAPENTS count is >= SWAP_CLUSTER_MAX, avoiding
+ *    to alloc struct mmu_swap_gather frequently.
+ * 2. The number of exiting processes is >= NR_MIN_EXITING_PROCESSES.
+ *
+ * Since the time for determining the number of exiting processes is dynamic,
+ * the exiting process may start to enter the swp_entry asynchronous release
+ * at the beginning or middle stage of the exiting process's swp_entry release
+ * path.
+ *
+ * Once an exiting process enters the swp_entry asynchronous release, all remaining
+ * swap entries in this exiting process need to be fully released by asynchronous
+ * kworker theoretically.
+ *
+ * The function of the swp_entry asynchronous release:
+ * 1. Alleviate the high system cpu load caused by multiple exiting processes
+ *    running simultaneously.
+ * 2. Reduce lock competition in swap entry free path by an asynchronous kworker
+ *    instead of multiple exiting processes parallel execution.
+ * 3. Release pte_present memory occupied by exiting processes more efficiently.
+ */
+
+/*
+ * The min number of exiting processes required for swp_entry asynchronous release
+ */
+#define NR_MIN_EXITING_PROCESSES 2
+
+static atomic_t nr_exiting_processes = ATOMIC_INIT(0);
+static struct kmem_cache *swap_gather_cachep;
+static struct workqueue_struct *swapfree_wq;
+static DEFINE_STATIC_KEY_TRUE(tlb_swap_asyncfree_disabled);
+
+static int __init tlb_swap_async_free_setup(void)
+{
+	swapfree_wq = alloc_workqueue("smfree_wq", WQ_UNBOUND |
+		WQ_HIGHPRI | WQ_MEM_RECLAIM, 1);
+	if (!swapfree_wq)
+		goto fail;
+
+	swap_gather_cachep = kmem_cache_create("swap_gather",
+		sizeof(struct mmu_swap_gather),
+		0, SLAB_TYPESAFE_BY_RCU | SLAB_PANIC | SLAB_ACCOUNT,
+		NULL);
+	if (!swap_gather_cachep)
+		goto kcache_fail;
+
+	static_branch_disable(&tlb_swap_asyncfree_disabled);
+	return 0;
+
+kcache_fail:
+	destroy_workqueue(swapfree_wq);
+fail:
+	return -ENOMEM;
+}
+postcore_initcall(tlb_swap_async_free_setup);
+
+static void __tlb_swap_gather_free(struct mmu_swap_gather *swap_gather)
+{
+	struct mmu_swap_batch *swap_batch, *next;
+
+	for (swap_batch = swap_gather->local.next; swap_batch; swap_batch = next) {
+		next = swap_batch->next;
+		free_page((unsigned long)swap_batch);
+	}
+	swap_gather->local.next = NULL;
+	kmem_cache_free(swap_gather_cachep, swap_gather);
+}
+
+static void tlb_swap_async_free_work(struct work_struct *w)
+{
+	int i, nr_multi, nr_free;
+	swp_entry_t start_entry;
+	struct mmu_swap_batch *swap_batch;
+	struct mmu_swap_gather *swap_gather = container_of(w,
+		struct mmu_swap_gather, free_work);
+
+	/* Release swap entries cached in mmu_swap_batch. */
+	for (swap_batch = &swap_gather->local; swap_batch && swap_batch->nr;
+	    swap_batch = swap_batch->next) {
+		nr_free = 0;
+		for (i = 0; i < swap_batch->nr; i++) {
+			if (unlikely(encoded_swpentry_flags(swap_batch->encoded_entrys[i]) &
+			    ENCODED_SWPENTRY_BIT_NR_ENTRYS_NEXT)) {
+				start_entry = encoded_swpentry_data(swap_batch->encoded_entrys[i]);
+				nr_multi = encoded_nr_swpentrys(swap_batch->encoded_entrys[++i]);
+				free_swap_and_cache_nr(start_entry, nr_multi);
+				nr_free += 2;
+			} else {
+				start_entry = encoded_swpentry_data(swap_batch->encoded_entrys[i]);
+				free_swap_and_cache_nr(start_entry, 1);
+				nr_free++;
+			}
+		}
+		swap_batch->nr -= nr_free;
+		VM_BUG_ON(swap_batch->nr);
+	}
+	__tlb_swap_gather_free(swap_gather);
+}
+
+static bool __tlb_swap_gather_mmu_check(struct mmu_gather *tlb)
+{
+	/*
+	 * Only the exiting processes with the MM_SWAPENTS counter >=
+	 * SWAP_CLUSTER_MAX have the opportunity to release their swap
+	 * entries by asynchronous kworker.
+	 */
+	if (!task_is_dying() ||
+	    get_mm_counter(tlb->mm, MM_SWAPENTS) < SWAP_CLUSTER_MAX)
+		return true;
+
+	atomic_inc(&nr_exiting_processes);
+	if (atomic_read(&nr_exiting_processes) < NR_MIN_EXITING_PROCESSES)
+		tlb->swp_freeable = 1;
+	else
+		tlb->swp_freeing = 1;
+
+	return false;
+}
+
+/**
+ * __tlb_swap_gather_init - Initialize an mmu_swap_gather structure
+ * for swp_entry tear-down.
+ * @tlb: the mmu_swap_gather structure belongs to tlb
+ */
+static bool __tlb_swap_gather_init(struct mmu_gather *tlb)
+{
+	tlb->swp = kmem_cache_alloc(swap_gather_cachep, GFP_ATOMIC | GFP_NOWAIT);
+	if (unlikely(!tlb->swp))
+		return false;
+
+	tlb->swp->local.next  = NULL;
+	tlb->swp->local.nr    = 0;
+	tlb->swp->local.max   = ARRAY_SIZE(tlb->swp->__encoded_entrys);
+
+	tlb->swp->active      = &tlb->swp->local;
+	tlb->swp->batch_count = 0;
+
+	INIT_WORK(&tlb->swp->free_work, tlb_swap_async_free_work);
+	return true;
+}
+
+static void __tlb_swap_gather_mmu(struct mmu_gather *tlb)
+{
+	if (static_branch_unlikely(&tlb_swap_asyncfree_disabled))
+		return;
+
+	tlb->swp = NULL;
+	tlb->swp_freeable = 0;
+	tlb->swp_freeing = 0;
+	tlb->swp_disable = 0;
+
+	if (__tlb_swap_gather_mmu_check(tlb))
+		return;
+
+	/*
+	 * If the exiting process meets the conditions of
+	 * swp_entry asynchronous release, an mmu_swap_gather
+	 * structure will be initialized.
+	 */
+	if (tlb->swp_freeing)
+		__tlb_swap_gather_init(tlb);
+}
+
+static void __tlb_swap_gather_queuework(struct mmu_gather *tlb, bool finish)
+{
+	queue_work(swapfree_wq, &tlb->swp->free_work);
+	tlb->swp = NULL;
+	if (!finish)
+		__tlb_swap_gather_init(tlb);
+}
+
+static bool __tlb_swap_next_batch(struct mmu_gather *tlb)
+{
+	struct mmu_swap_batch *swap_batch;
+
+	if (tlb->swp->batch_count == MAX_SWAP_GATHER_BATCH_COUNT)
+		goto free;
+
+	swap_batch = (void *)__get_free_page(GFP_ATOMIC | GFP_NOWAIT);
+	if (unlikely(!swap_batch))
+		goto free;
+
+	swap_batch->next = NULL;
+	swap_batch->nr   = 0;
+	swap_batch->max  = MAX_SWAP_GATHER_BATCH;
+
+	tlb->swp->active->next = swap_batch;
+	tlb->swp->active = swap_batch;
+	tlb->swp->batch_count++;
+	return true;
+free:
+	/* batch move to wq */
+	__tlb_swap_gather_queuework(tlb, false);
+	return false;
+}
+
+/**
+ * __tlb_remove_swap_entries - the swap entries in exiting process are
+ * isolated, batch cached in struct mmu_swap_batch.
+ * @tlb: the current mmu_gather
+ * @entry: swp_entry to be isolated and cached
+ * @nr: the number of consecutive entries starting from entry parameter.
+ */
+bool __tlb_remove_swap_entries(struct mmu_gather *tlb,
+			     swp_entry_t entry, int nr)
+{
+	struct mmu_swap_batch *swap_batch;
+	unsigned long flags = 0;
+	bool ret = false;
+
+	if (tlb->swp_disable)
+		return ret;
+
+	if (!tlb->swp_freeable && !tlb->swp_freeing)
+		return ret;
+
+	if (tlb->swp_freeable) {
+		if (atomic_read(&nr_exiting_processes) <
+		    NR_MIN_EXITING_PROCESSES)
+			return ret;
+		/*
+		 * If the current number of exiting processes
+		 * is >= NR_MIN_EXITING_PROCESSES, the exiting
+		 * process with swp_freeable state will enter
+		 * swp_freeing state to start releasing its
+		 * remaining swap entries by the asynchronous
+		 * kworker.
+		 */
+		tlb->swp_freeable = 0;
+		tlb->swp_freeing = 1;
+	}
+
+	VM_BUG_ON(tlb->swp_freeable || !tlb->swp_freeing);
+	if (!tlb->swp && !__tlb_swap_gather_init(tlb))
+		return ret;
+
+	swap_batch = tlb->swp->active;
+	if (unlikely(swap_batch->nr >= swap_batch->max - 1)) {
+		__tlb_swap_gather_queuework(tlb, false);
+		return ret;
+	}
+
+	if (likely(nr == 1)) {
+		swap_batch->encoded_entrys[swap_batch->nr++] = encode_swpentry(entry, flags);
+	} else {
+		flags |= ENCODED_SWPENTRY_BIT_NR_ENTRYS_NEXT;
+		swap_batch->encoded_entrys[swap_batch->nr++] = encode_swpentry(entry, flags);
+		swap_batch->encoded_entrys[swap_batch->nr++] = encode_nr_swpentrys(nr);
+	}
+	ret = true;
+
+	if (swap_batch->nr >= swap_batch->max - 1) {
+		if (!__tlb_swap_next_batch(tlb))
+			goto exit;
+		swap_batch = tlb->swp->active;
+	}
+	VM_BUG_ON(swap_batch->nr > swap_batch->max - 1);
+exit:
+	return ret;
+}
+
+static void __tlb_batch_swap_finish(struct mmu_gather *tlb)
+{
+	if (tlb->swp_disable)
+		return;
+
+	if (!tlb->swp_freeable && !tlb->swp_freeing)
+		return;
+
+	if (tlb->swp_freeable) {
+		tlb->swp_freeable = 0;
+		VM_BUG_ON(tlb->swp_freeing);
+		goto exit;
+	}
+	tlb->swp_freeing = 0;
+	if (unlikely(!tlb->swp))
+		goto exit;
+
+	__tlb_swap_gather_queuework(tlb, true);
+exit:
+	atomic_dec(&nr_exiting_processes);
+}
 
 static bool tlb_next_batch(struct mmu_gather *tlb)
 {
@@ -386,6 +678,9 @@ static void __tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm,
 	tlb->local.max  = ARRAY_SIZE(tlb->__pages);
 	tlb->active     = &tlb->local;
 	tlb->batch_count = 0;
+
+	tlb->swp_disable = 1;
+	__tlb_swap_gather_mmu(tlb);
 #endif
 	tlb->delayed_rmap = 0;
 
@@ -466,6 +761,7 @@ void tlb_finish_mmu(struct mmu_gather *tlb)
 
 #ifndef CONFIG_MMU_GATHER_NO_GATHER
 	tlb_batch_list_free(tlb);
+	__tlb_batch_swap_finish(tlb);
 #endif
 	dec_tlb_flush_pending(tlb->mm);
 }
-- 
2.39.0


