Return-Path: <linux-arch+bounces-5773-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B50939430F2
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jul 2024 15:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13AB1B21C80
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jul 2024 13:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0B11B3721;
	Wed, 31 Jul 2024 13:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="N20k++xT"
X-Original-To: linux-arch@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2041.outbound.protection.outlook.com [40.107.255.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887641B29AA;
	Wed, 31 Jul 2024 13:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722432818; cv=fail; b=V5INZK510Iha3KL0Bp26fwBP2AZ1U1S3QDhBwi9E6wdUUTY8tPHaN7Fumtg24WQjm8A5A7+rdvFj8BRcQQuGw+iCuiVUKElfrYJn0NjMW7jGWbTDCAu7fz7OJBUaXxcHMRwEvfnQutPDFAR2ntpHrMq0ZUjmSLOkt0a/TSIqHzM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722432818; c=relaxed/simple;
	bh=+iJVGKoEt7o7gzZZ+n2YojVRk0C/wAQhBY7sEsqzSY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Gek+tQFLW8y/0DfTLTrwosWkmHd5XpXZ1ZzwGFe3k9jVxsdxxVaq7h/yfmsAgR6R8V309fnmLrsRuEcmPEEjbbox29tKFZYsTDbkMeN2RkepWm0YUjIWRjgUhyY7NtuFTlh+TXIwnAXOTwgq3w9oVwvaFWnhPsrcvSmiJ8MFMKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=N20k++xT; arc=fail smtp.client-ip=40.107.255.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IBbfGChWJfoEiU108qZSB0MpTAbXX/mIL6mWEpcV8P/yDDdIPkog9CXqYMbu4fNppPSZU4KYk9n/qQ0+Npj20L+quBGlkBhYgyPIzXIow7ut+GQ8eGcMhL899H0Tq6zU2w7OdBYbkFyHH9To+oVm3wa4gFdOpBOn4wGEUw3hpf8yM020kGfl4eQMkb6sRP//yut+ocEbazSLGC2ihhKRYpaFdxjsEhmqe+jEq4OuU90bbrO638UijYm3+tUHx8WYl3wwxWwukqtRP8gnKIuVGU8vgVYU0D6rtBn8fwnpwT/xYmm9uOeOqkU1BBxahkuY2yVgMhewTiwnWHKG6yI1Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ObihyOKZQ/WIgIQoj2hpGxPMHAvrXspcNNpS+vgDLoE=;
 b=Trave3MxE3fjUC702S9wrHfVzPH6cKFuArIps0uEmHl8eDrHTDKhTmwet0tnofQA1eo4DgW235d2pXTyb3mPogGOBJbjdHgJfKnBJF/GdIRqEf3uAfab/vM68Yp9XxCJy815RWm9IWMQMApZ3Qj7ldIpiTFkPCz0rZKZWyWvPyqJvgM4ZvaKe4cjCS9sQZLTrWooad0sZ2/k73F6AkMsMzYUXeO6/FuoOhdsdoYy3cOgPO+yqp7Ue2iKH1Ot3lHZzkE3MJRjjoBEriMhgV2DYqg3tEaoQzfZvYS94yALLyVvav5la+zR2HY07I4dzHsmQ+AEjvI40b9+Pk3g1prfQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ObihyOKZQ/WIgIQoj2hpGxPMHAvrXspcNNpS+vgDLoE=;
 b=N20k++xTQGf41fe6tvxUAFocppip0WoaAm3t/4BAvGkR+W2ggDCnYEeqfLc+ine2IrMIwS0dZTXMIntTDTZHVBsf7h8lp3tJjESrGt9/6XGDebBak2V/9i4swdwz0tWvd985uRN7Aj+ZIr6xai5hsdzaTWaQjKo9MFmYkUF74m7Dvx8nv4iugGZ855SSEFB4fxXErwhEsC+VkCmEVtrOpZH9XBZ6arm/CdB+ACy2b8ltX5digrkBCtsftHtouOCuDJhgJj/JetOvPDnTMxjPb1XF6QC7CtIewirMMUv9rGBFn8CCqnkccbZ6aqCGlE3Q25jIVqpQFcmUtDMguM8F5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by TYZPR06MB7334.apcprd06.prod.outlook.com (2603:1096:405:a4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Wed, 31 Jul
 2024 13:33:30 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed%3]) with mapi id 15.20.7828.016; Wed, 31 Jul 2024
 13:33:30 +0000
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
	kernel test robot <lkp@intel.com>,
	Zhiguo Jiang <justinjiang@vivo.com>
Cc: opensource.kernel@vivo.com
Subject: [PATCH v2 2/3] mm: tlb: add tlb swap entries batch async release
Date: Wed, 31 Jul 2024 21:33:16 +0800
Message-ID: <20240731133318.527-3-justinjiang@vivo.com>
X-Mailer: git-send-email 2.41.0.windows.3
In-Reply-To: <20240731133318.527-1-justinjiang@vivo.com>
References: <20240731133318.527-1-justinjiang@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0019.apcprd02.prod.outlook.com
 (2603:1096:4:195::13) To JH0PR06MB6849.apcprd06.prod.outlook.com
 (2603:1096:990:47::12)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|TYZPR06MB7334:EE_
X-MS-Office365-Filtering-Correlation-Id: bf23920c-4bdb-41ac-fc64-08dcb1655dc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|52116014|366016|376014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WcS2cwrN/SqJaTKjK4Jb64PW5HGI1ROvkjpIrFVPSRqptTu52eywdLoS+uju?=
 =?us-ascii?Q?AnvGfSCQf2+7G7sfT7NF7RN+7qdkq9m9qOc+uaDWuWoZanbECBW1Nc0bA/D8?=
 =?us-ascii?Q?Q0Gw5SV7TAtqOR8TZU9a44KYEciC1Qlp9UMVPeOiMxiv0w83pKdi5T5bONjq?=
 =?us-ascii?Q?Wrad20qu5lBSNDQgasmcirXlYjpHMN2WLrafOzzi+y7DP2/E7Rj7R+G5+fR+?=
 =?us-ascii?Q?+9Xixqy1sDGYJBVFot08T1wiAoayy25i4ksUe5AeeVpqQpyaWAdu1Zm9Owp3?=
 =?us-ascii?Q?d3yg9sBwJTdAHorcuUIowaAKbG1wRHnZPyBvS0aKgf6XXlNpAi0J6QLEafV9?=
 =?us-ascii?Q?5Ci9OtFD9rcYOEDqAb8sgf9hXl8B20r5ANwhGTrfUNbWKpJTqd1z4EBNPIdk?=
 =?us-ascii?Q?AylhT7em10ZvGSOv1c+9uGYOieil1CISw+sEbHRWmIY6+1cwJ9UHX/oz6WpM?=
 =?us-ascii?Q?gFuj57tmtLwY2l80Io3nbS2Y+fyduAuAjq8WoDs+hfkEMHRzycDoaNNQSzaw?=
 =?us-ascii?Q?WIZoOw1MGuRF0nbYBl6vOFrqfhgBJdRHGF/usi9Izv6GeZWpgt1JnpOMRt3q?=
 =?us-ascii?Q?S1RZFrzDUUd7k3Zg9IWpNW9BL85vKXwNxMUGYpxyghVw9mLjmCKBHQzbGaeM?=
 =?us-ascii?Q?DBi7CUTt8PSi9ek+Fo7RD811UldKEzQeAl/XdU2TW7RlFjfY33zu6Q2dMMWM?=
 =?us-ascii?Q?QpWPMZFR037glVBRDNOBCac/4zG7m1OXbHBT395ml54mnwsdWdnw65zC8nhP?=
 =?us-ascii?Q?Fdi7ri6hVpZna3FctmCzSKOGXk8/UCsc4oVh0a23VDtoPTDzuPp8ypZImt8s?=
 =?us-ascii?Q?gvYkrxZKRpAp6tXd1d1Gx7rjBraloEHmqr4SS2SxFrPxnLT5hmoc4GuTd0/v?=
 =?us-ascii?Q?7ckXLAF0XVhYMxRzrDYnsqG5C12McSXkW04A5ShL114v/Whj4uuX8H38sJ/c?=
 =?us-ascii?Q?mmCiFpf/Q3fDZ1t1FK3/+ZL1XzDl/NNIJSdKLmtEJXovBjYUzhUM2VVTOerg?=
 =?us-ascii?Q?WWR9hg1c1+zjI7YY3msNDkGdTBhuHdYKlR32QoeiCfxR9OLKl/dDEQY65yeX?=
 =?us-ascii?Q?5S6OKMbRRzwndEHIcxp51OT9/vURf0yekL9hedYJQw5Dh4PQGIrntH3IcNam?=
 =?us-ascii?Q?vcd8PMEkmOPEF2sRdrVZgSfLyqKLEdwxBsMf4SciPN6ECQDMAcpk+ZVvBBeQ?=
 =?us-ascii?Q?Q11ylcFyb7O7VHREt20p2IyTbt5ryni1ytPfOzNIj0oPvEfEoquMD9G/chb4?=
 =?us-ascii?Q?F2JoQbRId3H5ZjyQo2dnPvgc/+LWqFeg7Z4+fDrgxCc/U4shNBAvidbrL9sz?=
 =?us-ascii?Q?N1Htfq+H66Ut2wAmX0mb4JbZm09B+Kb73SHSnXGgYkNoxPxcEsLNnu5VGO1H?=
 =?us-ascii?Q?Eqi1XIX9GIw5xZoeiCklUngqitw8z+PXnfW3kye3s6zeQ1v+IXn0/ru4H22X?=
 =?us-ascii?Q?WSwokLCcxdk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(52116014)(366016)(376014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2jYb25M6hDgjt+dphtwRh3WQ34xnFFQ20GFVoAUIyaDAJ+urjaSv73STOni0?=
 =?us-ascii?Q?+3ufOUAjklFxZM2G6g1J3rhng5thjhlHAPdYyE9jjaTJhF/8uXUe9llnx65C?=
 =?us-ascii?Q?Yw+jWEpk5xc6pB2mlR/6k0Y/PYyBqwCTcYR8Lt1keDGd/rqPZoZ64JgWY0GT?=
 =?us-ascii?Q?7JBJnySb+vKCgr0loADOV0z34ffwbZXGbLnIAocGzt/pUENFRzIWFld4ClHW?=
 =?us-ascii?Q?SfcThhJoTMfXRG3WtCNZoPSmbomHn1/WNwEHSCH0Suf2mvrRiIxt1zZsyjOt?=
 =?us-ascii?Q?drVUDs2VzUWLrQK05sOL9+1DcW1M8afteRol5t3rObKQLraQZzDfKVfhvQiM?=
 =?us-ascii?Q?73bCCOxn4cvQvCl75m44EaFhJhCRgbyQNAzOdF+XNMVxciwsj6kBiljiRM7q?=
 =?us-ascii?Q?y5JrfOEZnxBD4r14aOa9CFw6wcPC/9ffe6LBVntcuaMfOze2j5qgIdDKYulS?=
 =?us-ascii?Q?2mgqUjBSIkMUPCIz1HJ2kZEenx1CYGP3vE5KvhHhAZkcFkRFCiFxWXY3JQI+?=
 =?us-ascii?Q?gf710YgeN2ufyu18aGRE9punIMLlyrNlu4QI6IOHTI36JrLIMuobgxnJ4GZI?=
 =?us-ascii?Q?SZiGNZrC6cFmBBbt/jH1wSfHezw/7quCilkxBXxmwBxCKBy3wJfoJltwsncH?=
 =?us-ascii?Q?gpQ+hUBmz+lMwJi7T6pbsfEhkxrGIMUO+dwN511SRTUftf9EW/5BWnqNqju+?=
 =?us-ascii?Q?DzWMI8D01W+WHR4xhz1AZKAmpYXH7tKsEiJXhiSEKgxuRzc+62JQ8/GOvpVe?=
 =?us-ascii?Q?yWCyHgMNSA08puExBcBu+PwaIqnPQRNIsm2knE6Wqhs6lUWvInrqwUSmsFyE?=
 =?us-ascii?Q?rEPZgI+R8ofj4U1KBwLtJZG4gIVR+2Kn2nKHSgkyyTDKL3ubXTWzAeghcdm/?=
 =?us-ascii?Q?SYzui7fifWnu9rwmJBiCqSGjwkG/VlJh7q7psQ91u8D+O9IATn9qQZShsuMQ?=
 =?us-ascii?Q?WLBUKg3PsUIjM4aV2NHBneQRQhAqV+YCjoDB64OeiQaAfW0ZyUvVm6ewYTa9?=
 =?us-ascii?Q?xP1uaZorjKQM6suUQoxBTU1S4sC3Yf6vozpWJLEt3RhbaI0p5O7wFXsf28hC?=
 =?us-ascii?Q?RiO0Lcyy947QwZSH0Cekh8WbPlG9q0O9YemQkZyyLrdWcZU0O8lca5X+MRZH?=
 =?us-ascii?Q?SsIsEQyFdzl7TOAxCB8WW+ofkcFj5Rw33tAUjoMwOTIgsOO/3P9OTBlcmRVB?=
 =?us-ascii?Q?Ga2su4JfFG/ghU7GojO478jZXT+m1VAlCXiRu49alCfdPi69mxaMs+g7Olg1?=
 =?us-ascii?Q?ZRAkvIhZJqoiJ8qVZG8fu7pMskq4UprfzQz3yeJAZ5CKnK8h84lqHv4Ftw/V?=
 =?us-ascii?Q?L8LQCU3g0n/9IFORMNYpm59YxG5VEefVWVi7PZ2H8hmWu7exRN6aQB7Ha+Th?=
 =?us-ascii?Q?MkMzHDCvBWOeQg7diNug4LObb4kU5NvU9aePlwUQr3IvjLCvIl8n6xoPPkSh?=
 =?us-ascii?Q?qD4B9sNeVHWXI3UwXg5XKGZr+3FXm1Np1enzxF/Uhzjx3bp+AlxZTOuK4w7z?=
 =?us-ascii?Q?TAwsBFDbYEkTiorkxOo/WCLGs9j2d4NFcN3HuYUbrRCM4uwHijIOTChcnhJM?=
 =?us-ascii?Q?Rr8y4A8x/Q+mueTEd5zFK7nv6VekTIq9ItDpdS9/?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf23920c-4bdb-41ac-fc64-08dcb1655dc4
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 13:33:30.4061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qD4gS2vb2uDXKPlbmJYwYeTnsfa4sExi4kPoErPBHaSNx7lIKeiCpanMQfSMXnqXnPYYD8Rolb5m9lErKT+YAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB7334

The main reasons for the prolonged exit of a background process is the
time-consuming release of its swap entries. The proportion of swap memory
occupied by the background process increases with its duration in the
background, and after a period of time, this value can reach 60% or more.
Additionally, the relatively lengthy path for releasing swap entries
further contributes to the longer time required for the background process
to release its swap entries.

In the multiple background applications scenario, when launching a large
memory application such as a camera, system may enter a low memory state,
which will triggers the killing of multiple background processes at the
same time. Due to multiple exiting processes occupying multiple CPUs for
concurrent execution, the current foreground application's CPU resources
are tight and may cause issues such as lagging.

To solve this problem, we have introduced the multiple exiting process
asynchronous swap memory release mechanism, which isolates and caches
swap entries occupied by multiple exit processes, and hands them over
to an asynchronous kworker to complete the release. This allows the
exiting processes to complete quickly and release CPU resources. We have
validated this modification on the products and achieved the expected
benefits.

It offers several benefits:
1. Alleviate the high system cpu load caused by multiple exiting
   processes running simultaneously.
2. Reduce lock competition in swap entry free path by an asynchronous
   kworker instead of multiple exiting processes parallel execution.
3. Release memory occupied by exiting processes more efficiently.

Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>
---
 include/asm-generic/tlb.h |  44 ++++++
 include/linux/mm_types.h  |  58 ++++++++
 mm/memory.c               |   3 +-
 mm/mmu_gather.c           | 297 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 401 insertions(+), 1 deletion(-)

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
index 485424979254..f26fbff93ff4
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
index b9f5cc0db3eb..bfa1995558d2
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
index 99b3e9408aa0..2bb413d052bd
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -9,11 +9,304 @@
 #include <linux/smp.h>
 #include <linux/swap.h>
 #include <linux/rmap.h>
+#include <linux/oom.h>
 
 #include <asm/pgalloc.h>
 #include <asm/tlb.h>
 
 #ifndef CONFIG_MMU_GATHER_NO_GATHER
+/*
+ * The swp_entry asynchronous release mechanism for multiple processes exiting
+ * simultaneously.
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
+ * 3. Release memory occupied by exiting processes more efficiently.
+ */
+
+/*
+ * The min number of exiting processes required for swp_entry asynchronous release
+ */
+#define NR_MIN_EXITING_PROCESSES 2
+
+atomic_t nr_exiting_processes = ATOMIC_INIT(0);
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
+		WARN_ON_ONCE(swap_batch->nr);
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
@@ -386,6 +679,9 @@ static void __tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm,
 	tlb->local.max  = ARRAY_SIZE(tlb->__pages);
 	tlb->active     = &tlb->local;
 	tlb->batch_count = 0;
+
+	tlb->swp_disable = 1;
+	__tlb_swap_gather_mmu(tlb);
 #endif
 	tlb->delayed_rmap = 0;
 
@@ -466,6 +762,7 @@ void tlb_finish_mmu(struct mmu_gather *tlb)
 
 #ifndef CONFIG_MMU_GATHER_NO_GATHER
 	tlb_batch_list_free(tlb);
+	__tlb_batch_swap_finish(tlb);
 #endif
 	dec_tlb_flush_pending(tlb->mm);
 }
-- 
2.39.0


