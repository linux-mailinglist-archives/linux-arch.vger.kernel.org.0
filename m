Return-Path: <linux-arch+bounces-5826-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E639444C1
	for <lists+linux-arch@lfdr.de>; Thu,  1 Aug 2024 08:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0836281A4F
	for <lists+linux-arch@lfdr.de>; Thu,  1 Aug 2024 06:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90BD158542;
	Thu,  1 Aug 2024 06:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="DOG10ZYx"
X-Original-To: linux-arch@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2075.outbound.protection.outlook.com [40.107.255.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACA4157490;
	Thu,  1 Aug 2024 06:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722495050; cv=fail; b=qKTx38eLjlYc7rtLX7eBDegVj/188wsSCZtaXI0vOjWUaCEVyH6Pa3V50jU5m3WoehmGHZgDZrzodhwAyYkThkY+o6y+G5IgPiuK9uTLLm+u6K7C1OnThUjV7R5nbwU+flV9y3CGXVHCNg+LooI6qy0UxEYTiUoBLWAJHWGUP8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722495050; c=relaxed/simple;
	bh=ngUk+D4yBN5F6sL8rV78k/hKoaG0avczY+uzlaxE00c=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=OcMXhlRtEpGy7tTAn6q74UTDbTQoxT7oKPE+fXBQI4GPZ3R7IGSYAkWApQrxOd3VVxVhddnYZ9Y5sLMF1HV91H2dxzoIjIMSKeBwxi27Oi5+D74VFzIQJIXCyUvcD2I+E23fj2t6hcjlHyqxC++7FLc5c+lXdgKxOmFBInTAJW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=DOG10ZYx; arc=fail smtp.client-ip=40.107.255.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iwH8bPtmu0FhcIP12SISLqph0RhE+5nliY07LCkeNxPNPebPAtPRUo+Z3RUWM8o8qMFgYJ2SaqEJl9PfDtEWUuDhnZOLnbRNhl6exj88KGQK2yXTx4sSMcAEuMZbx7dDxkZioQZ8nUHUBYgdbHcMnEDk89noc/5z/1/EpsBn0nCsB6iaiX5V0T0thsQj29sLDvpYLh+JtCxK5AW96Utj5Ei8i0CMcb1b/4qP6mL3cv/BRzujltgX65FjX0RU2QxARyDx8fOORjByG+zLRNAu9NZ3GzerPpmVHZ8baWNreKITDPXqqkf0V8y2C8mldB1wag+h+i55epv6Sp/YMs/sEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sk2gYF+c0tq3zemogGai/59wQ1myWfN4IictHGRvkXI=;
 b=XbmFXUoae74cCVWLeB9p0TskNNN5TC3u8lAJogqfeNrgUvdKI2QH4qijf9QYTYw+zVsjZvVwyjWVVBOsnXCqbWG2YK+H+HUQunpNs3/9yE3fjPke0CwaokdTCGLbgTV1m4/2ypkBthHbGBMtfGMHFSFTDT8pRnDSmZf12VvyuxQvC2M5WJ5ZeilB8LU7P1TYNYDmej7pxjrrK/j4JAbXpYhSC50dsrO7qkRwNvN+i+F8SAUbqd475QYn3mITsTTdCSJa3hVo6ixjUsQEtr5/XQ3vq32mHmtYooOzgHtil4BHtH786WTuEEBduqvyo68zdiG3I5hM6xl7Wy6zhNnlaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sk2gYF+c0tq3zemogGai/59wQ1myWfN4IictHGRvkXI=;
 b=DOG10ZYx/QQAoL9N4C3Nc3iuEKFCFGGu4VzIN8z4IR514Likph+XVHqxuInS0i65opIkqQm/LF1EgTDZQa3912AQUAt8j6PYQ1ZSXSjPLepsNmoV5IxzORo2KAe631iFnnegeWTObl23tnqiDqvxMu3mteylu6qA1A1Z0oQ+d5E8qgiAQM2JvH80o2QmK/DiYOHzA2IvPvluGUptmMlJvbMs8sLXlagy5cYHlQD6kDEjVOpbUsIISEbsNb+2S5o/y8zEbZjQKIzR4QmeuElnMCHxxas2+QDBSlrT2zuJA0Joaho6s5VIybBJY0WJ9+K2NBx/xBmKuyM+8xTD/g7oDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by JH0PR06MB7326.apcprd06.prod.outlook.com (2603:1096:990:a9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Thu, 1 Aug
 2024 06:50:43 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed%3]) with mapi id 15.20.7828.016; Thu, 1 Aug 2024
 06:50:43 +0000
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
	kernel test robot <lkp@intel.com>,
	Barry Song <21cnbao@gmail.com>,
	Zhiguo Jiang <justinjiang@vivo.com>
Cc: opensource.kernel@vivo.com
Subject: [PATCH] mm: fix compilation warning in patchs
Date: Thu,  1 Aug 2024 14:50:34 +0800
Message-ID: <20240801065035.621-1-justinjiang@vivo.com>
X-Mailer: git-send-email 2.41.0.windows.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0004.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::16)
 To JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|JH0PR06MB7326:EE_
X-MS-Office365-Filtering-Correlation-Id: 3de912c4-f562-4023-eb30-08dcb1f643b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|7416014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?T0qCrtpKKAwA7QjLnxLRp5IVQCEKNQcQsCNRv78DEvcqxXThpuVli29ZCt5h?=
 =?us-ascii?Q?Yq7ot1LIHWJClGsbciPcv3RxDHjSuMX3KLUokdtHM3WNXNrzluehfZVZf4TC?=
 =?us-ascii?Q?tOl3Lv3Xb4muNDNbEKHQbtgDE5sOo0jNI+9nzDpWL2Ux47UPUYzeVZ9d2lEi?=
 =?us-ascii?Q?BtyXc8D0jJ15OWESPtm8v2tapqlQfJ1uxRDVFJuSDalxpeI4+ncxSvWJobPg?=
 =?us-ascii?Q?Chst8gqjsChngZ17m6+yefWGC29GvVYGlXKa5oK+7wSFE/ar1MW5SjNYhBK7?=
 =?us-ascii?Q?MMz0G1G1nE5Kj/VXb3BgygwDk5d8UxNecx1aCDekPQupkqKJK2PBWF2zLPyh?=
 =?us-ascii?Q?d3u1UUaypQpU4OpM2VBv7zJSiXLum2BB2R6hZ0QQHWEUQJsqbAApGx92IwTT?=
 =?us-ascii?Q?99g0P6AQ7jeJCgqV/3djjghCBX59AI006PBJ6U0+b7tEko4mjW0V9jP506QI?=
 =?us-ascii?Q?67em77/pDOnKMdOpmodevqT1smNaa/s2TXaE8CW8rXSPCXpW5BmsvgeK3UJr?=
 =?us-ascii?Q?61tiDR2j0GP/QfcV37gnzIQZ416EoA+Q607DZXV0hhkIGiAyQFhGrishFDPb?=
 =?us-ascii?Q?GN3FGSWbYkwX8OfD7nG+Qhi6NNQEApgA7vCSy3j5Qo74K7+Nshn19LFciVd5?=
 =?us-ascii?Q?FHGNSajjbyxdmO12L0h6oVv33w+EdoiUKHrqw/bUekGzdAPrAUNU8OijghfR?=
 =?us-ascii?Q?urX7Wz8YIdEeieoWTSQOmGaHHMGIRMLRWUj+8j5/1KsKkrdhBAJ4xD1aYpTy?=
 =?us-ascii?Q?39qe6AvyjJnK7oztpI/SBQIXWUzQdkRjXRuicbbrDWvtZ3eiaQ520Un/L6Qz?=
 =?us-ascii?Q?iGuNBDXmZl995/t8m+3g/50Iytdt/W+H4tdouaJLoIPo7Vj8OSk7cNvYvMNA?=
 =?us-ascii?Q?3EUMzYsm5rBFl4vy5Crk7Or6QUETYiW8nflYhEJzAAAfgofUDMAkvL5yrSw0?=
 =?us-ascii?Q?px6zvLKXWFDXsA9yFqRYoO1c21YgRFarjHUcHICiD/GSQn6s6ZkvYIic+iQr?=
 =?us-ascii?Q?DXKDqZTuPfxXel2FjUO8ON1wYNSOZofi/ljg99Xugi9zWGLcaOGtXNRvfw8h?=
 =?us-ascii?Q?Hr+fr54X3qGEAX7bNRnTJwx8d50w2uI8wq+lkQLLWBllRYymHl+G1UzgaevT?=
 =?us-ascii?Q?Wbr4lgikBNfVzSx36TwSoEugtfDwMP9Dt+KTlMUjj3IgfrzeKkoz03L/Ppos?=
 =?us-ascii?Q?7hwL+XHyaQa031UDX6mt916MBUOFJYblFrjRHt0SBKaj4KAedFs7g/sVadMb?=
 =?us-ascii?Q?m/4ipTg3pqdyV88DeaGD5xRIHwtFZT7uyHnSxYD0HJz5ZhjgDvNGdfvHEdKs?=
 =?us-ascii?Q?X/XnrgK78mzFAYDDQzsWJBmxFh7eXSzSF2OLR2TOJrArwiV2LDRPZMzoJz8n?=
 =?us-ascii?Q?FVoooejofXB33Wo+qaW8znEMdiEp?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?b7yf0onOocr4JYNVOKdnh+Sl7T/XMgt70eiZJikJTGqLWQyxSRqcat9yNEuW?=
 =?us-ascii?Q?KKWGbB4mAzwpyCW+WzJk7E7MVXAF3K01P0MGZse1+mO7xMlfyAy+ZyIj+O3k?=
 =?us-ascii?Q?CYlk10G2ynRoscXYmBDqFdhVuGw2jroqXakyzR4n/vtv+ZTGHAc1aKcMlvbc?=
 =?us-ascii?Q?wNNy4wB11w44LzqkS9eurw2QG49xr22S/blaHoaS2z8y3nBjk/tKHofmycnh?=
 =?us-ascii?Q?2lCGlHPfntFW/ZG6nepv4ppmnEJSV4sUv0uh0lm9nq6U6N9bhfjqESO7UMKv?=
 =?us-ascii?Q?jDv2FIJ8PU4HUyD1Sq0jpWhsxki1aUPO9Qe6F+7SBfUyfn9OohBSbdtaqUGu?=
 =?us-ascii?Q?rnPE8C9pCbkUzOkaRd4/XVsDdE2lEfuB5Y3kwMMx4xcBU34X7mtxnfO/S0Oy?=
 =?us-ascii?Q?QZNe0NFbgvJqRrYXR+izoR52519byq8Kc19POoQMWijWqqf7gn0p/rcLacka?=
 =?us-ascii?Q?jjcQ207JDYKO7Qt8l1ts03VBMzrfrR+IcFkFmeJa5PASk0NVa/oG0B31/aoR?=
 =?us-ascii?Q?sidVdoRyyDizLBZZYwJmJfZJ2gtrLaR6g8GkH9YQU9Z7vEWIC/UFazOqEQvQ?=
 =?us-ascii?Q?/luHYKlOsNejZcVvdSqaYizZWb2t7LBK4j/VsAgqyoMQ6QkD0gGqEAgIyaGL?=
 =?us-ascii?Q?qSG9NQiu7O3yh/UFtEyV4slx14iqGR7PoABG2ouRwnnr7b3kaWeUospxakKD?=
 =?us-ascii?Q?eTIsezx+6y3PUwUZcI0DnUaPO2EJaF77ATOHJKWPGXxGhJaeabaO96T4isTu?=
 =?us-ascii?Q?thFlihA1ZxtTXgq0lxts97eNTYjTnWMHMgjrXRUdz3ENrcd6+r9ZmU5XE6MO?=
 =?us-ascii?Q?9tqV9DkoFSeAyvSjWoBS+eNk0/TCpCJDRo3M8O9wxI/q/l+DLsk+t2jKyUCS?=
 =?us-ascii?Q?N6PRM+VxRtzxuhbqjxqHZW9OAK9axYpeO8K4EYsJZ2wn6Ebh1NFO4T1vglcH?=
 =?us-ascii?Q?JSi/+FU5Nfot7OkRlIdPGzBqjYTfNMBulDkAK+hya6cqU8x4BdV+Zv/DOZX8?=
 =?us-ascii?Q?8sxiE1eg000qQw6ywgi84IodmPtrHMOjevynG4t8OmdGIqZQ5GxUWHFS0JuC?=
 =?us-ascii?Q?AgiyO3Nmtw4qxVKVNw8PkCgC+K2HiQjZMYCe6rrz1mVAPnQNrrnESI5YrTll?=
 =?us-ascii?Q?h+3AHDdnKu85ck0MZqwYW5TogDg1/+ZHbqsQy0c/9LWfy1TQxkWz9j6Yzuet?=
 =?us-ascii?Q?p9O8KiWMJNQ5rgMshxYFkchJi/VIMu/2R+jCw0Rf3bOR+EeCfLLCWoWWIyJD?=
 =?us-ascii?Q?5FpOrFTKIoZTX40IuKvC9/vAU5g0Ckf7viyjNElMibI4OYNN1veBIKg9ahuF?=
 =?us-ascii?Q?WERPDnQR3mzVVmNBBFO8iyeRhnsPsIj05nSTGgpxq2nvn5GRAY/kAkJXuIjJ?=
 =?us-ascii?Q?O6C84vhdJxzhMCUAL2/tmv3ICYQKu1j0vbRzJ1YSnn6AKmr/sPNqt2bso8OH?=
 =?us-ascii?Q?+LMmORzcs78wOb5CaJ/qgKiZ7ogLOeG4fYXGHRSn69iWjaIqlUo1qRP3WsNr?=
 =?us-ascii?Q?ADc4Y3EKRZeKzj/uCpiKhdnCjNJ5VH5oebBstFdFmQOMju6S9PUcM1krnWOH?=
 =?us-ascii?Q?M3QH0TN41raOZ4+JKjEDQ+jArEQnHhnN1bDHz5sN?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3de912c4-f562-4023-eb30-08dcb1f643b9
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 06:50:43.7258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ff4iWsCud+Z1IKQI1h0pdD+/8tBM6z2YHWTDJ7LDqC18ZdSozbTkYANrlPDcitWZnZluAeDU7d/V/uGpI4kvQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB7326

Fix compilation warning in bellow patch.
https://lore.kernel.org/linux-mm/202408010150.13yZScv6-lkp@intel.com/

Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>
---

| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408010150.13yZScv6-lkp@intel.com/

 mm/mmu_gather.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
index 2bb413d052bd..405383f619f5 100644
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -51,7 +51,7 @@
  */
 #define NR_MIN_EXITING_PROCESSES 2
 
-atomic_t nr_exiting_processes = ATOMIC_INIT(0);
+static atomic_t nr_exiting_processes = ATOMIC_INIT(0);
 static struct kmem_cache *swap_gather_cachep;
 static struct workqueue_struct *swapfree_wq;
 static DEFINE_STATIC_KEY_TRUE(tlb_swap_asyncfree_disabled);
-- 
2.39.0


