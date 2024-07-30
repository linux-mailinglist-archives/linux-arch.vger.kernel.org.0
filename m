Return-Path: <linux-arch+bounces-5724-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0BF89410FD
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jul 2024 13:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03FE6B27841
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jul 2024 11:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC61119E826;
	Tue, 30 Jul 2024 11:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="nuIjzXVB"
X-Original-To: linux-arch@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2068.outbound.protection.outlook.com [40.107.215.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0345E19E80F;
	Tue, 30 Jul 2024 11:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722339880; cv=fail; b=H/dZ3mNwTC1lveIL39ZQ6scDzXK7KeRbuDRJKTAUYa1rzkuBl5VHCuwzZSZAeqNE6An29qKqQ6fvKHHJQEX9TlSRVlZvWEmoTCsFNBTYBeUn3YQyuunX391zi2bHRldBgULIQ+o4ztsJLhaf5E1ENcF09aZY6YjnqRpzjm/tUh0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722339880; c=relaxed/simple;
	bh=OuySXNwIfINW12QLmVV+5kmUU/35Q7H0bhBRAYPfnq4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=oZX9EIb2yhiZ4aYjLbF9QcItKz6G4UlqNYVNpfwnBm6vI2UQPESF6KdGtUG8PeOLlL2BIuJMY2HbJLrGUQtUqMvKC2tL4kpVaUWELPBz92zzKLNzxf3zuJQs+sFBotMrxf/cg04sd/Kn5a31EB9WOlWwhfp/X3vF6hjSDT/1COc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=nuIjzXVB; arc=fail smtp.client-ip=40.107.215.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nEpNQioD/UzgFOoDfLvKzDIR5yfeakUocS4Kw9ulhQ5M/MqfR5a6P3rWg+z3KPEW45vEILCypejctFtAgEqMlXVK9iKSdPp+uzB6IHk6Ae4xlYcXZH2gYIwTGKqfIEkfy+I5YhruW0VFcdPyUE03SSaOcIN1zhNaf0WiEiqfg+2OBOJEFjrM5OIAnYvKzfIUyKti22a1kpbfMP8vXgraHq9pS/oqEq7KcWSs7j0+OwjKqLlCvDGprbfLnex7LbJXmKM3hDigd6ESqZ1MqFfMOriKGmKJvGLhBrWVmjtKcwl+SLUqS14ObdXqSu1ez2nVud4kyPNEbwC4MD6Ths5QRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kY2aCP1qt3NA2Ea6s+1o17+wGFhjsxPr8n1X6jxgy0M=;
 b=TniQAomgfOjngG97toHBOJ68a4SoVcXV7pm6pi/xkwEvbNzgBae+Xbhto+wTLKvDsVTazDkeoOAWk5GE8YXdihiE2CnOZxcPjYMzvwcWhEppZGeF15P9nISoN+NT8LXehY8eB6Y8F3EpTguWSmv4ip7MX0XrbqqIuR+advSUjJifMcE6zUiwAuBie6HaPJ7BB7x9Xm+9Ovr7LVE5BTTehxUQyDVCy27VjIx20m8UOHSui5lvNt7DQbYNGB8fgCfK4UnoGViTBNz4XwE2xZ1t4cSpDzpjzBiX5+zTDRQLUWXxe6MI/HeiP02sYhU6/GNr46ke+5j5VVTnDhrBQO27gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kY2aCP1qt3NA2Ea6s+1o17+wGFhjsxPr8n1X6jxgy0M=;
 b=nuIjzXVB5VXPh4C39vQakFHA91rwh26dIjAvIstAhfo0kWkjV7rilQz59DizPcIuAbdYBrOYI3vWE9j6X0tWF8f8VQS4FbFhcV0/APt/Sw9TWuwoOumeQWsz5Dak3pDQsI/iNDd9qWs2DfePIhLsVMUlJo1INbyuW0rrVj40OBhWRT/NnxBf74Z93giE3px4iuJZI6Jv6Hb5cNeKJqgHTgT3sPkTLZ1UxZYkDBqUvvsWI6SeKK6x9Fu1Fj1ouzbg23PGb9OOwVTDaLDTi1oNnt0DnnfvVnjYymR3zygqlxVHedNMeYG5vr+1kHNp8EMEoiwfCDjggO9ypM0DQBwx3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by KL1PR06MB6520.apcprd06.prod.outlook.com (2603:1096:820:fd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Tue, 30 Jul
 2024 11:44:36 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed%3]) with mapi id 15.20.7807.026; Tue, 30 Jul 2024
 11:44:35 +0000
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
	Zhiguo Jiang <justinjiang@vivo.com>
Cc: opensource.kernel@vivo.com
Subject: [PATCH 0/2] mm: tlb swap entries batch async release
Date: Tue, 30 Jul 2024 19:44:24 +0800
Message-ID: <20240730114426.511-1-justinjiang@vivo.com>
X-Mailer: git-send-email 2.41.0.windows.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0018.apcprd04.prod.outlook.com
 (2603:1096:4:197::9) To JH0PR06MB6849.apcprd06.prod.outlook.com
 (2603:1096:990:47::12)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|KL1PR06MB6520:EE_
X-MS-Office365-Filtering-Correlation-Id: 7639269d-62c2-4e34-d70f-08dcb08cfc7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?g5BIEAgVU+bzDXftWfLSgpZ2LGnYCDNGm+epgyBQGb+W6p18oXlKidimdevQ?=
 =?us-ascii?Q?Anj1fA05RU+xuyT3xWyd4XgphPI3en5ZIBKZHHcteumuPD20SbA1Lovp0jdA?=
 =?us-ascii?Q?Gqbo/3nremUmOhFjuvsQm4iMw2OZFSApUGZGO6KIpq+zXJwsBqc8fKMHs04q?=
 =?us-ascii?Q?WsI3DmQfQqYEz4mJGdjUubMbod8VIo7uUi/qvXuiQEbn/8T84o7vwSR1xmdg?=
 =?us-ascii?Q?sklchLAtUyuXmWFLHsGjgPJlO7k9NvrEJJIrVhWa0KPsLnRPEJQoTIrGnSUG?=
 =?us-ascii?Q?MOFoulvkhYl+9PGamaFAjVdHqU7WJ1PF1AQyFt4+Q03ZrI5dWzekSGdHgE/U?=
 =?us-ascii?Q?Mh9EmOyY1pt2birgrg4fGIgfewMXY8gY01W/8/7LxnhmqtAKaNPGh6fczDjT?=
 =?us-ascii?Q?H9sFZ1zA4HNqSh2jNjQYqSPDmSXU6DnF2HIiYI0x5ynXM+Vkx5PSIltcHqey?=
 =?us-ascii?Q?WozjfG9IHbEvBf7jQCouxrCC8lk6vQqzfWkZ6+h1RDqrzYr9JBpUbbpIyDhe?=
 =?us-ascii?Q?m+v3kgvn1hk7GZJCVCdwFrciihcwIOwRsfttl3KFzRF4SRK+nO9st4jZ7RYf?=
 =?us-ascii?Q?1k8qB3tieL5BTX511oTP4rlxNrf7CY6C4P9TIaIKA0A5V9EqUaVHopDkKBd+?=
 =?us-ascii?Q?ghdvwToWW8NrA406R9b7jx+wepcvbsBgacvmvQMb9EBg9k9vtYzNPKY72k2G?=
 =?us-ascii?Q?P+U39KDNi0fzqZMIk15blWeSvAMXckc10fAvZZeGsJ0y9XSy/SxaxK6T2yGZ?=
 =?us-ascii?Q?2pEND6e1GY+s7xaCHp81DwQh9rth/TgpBBolKv5LVZv3MejBRotJFcUug53r?=
 =?us-ascii?Q?hB3s+UFl5bFzwBz0lhwXTcsl4NIPfHVnJFBQ/7PQOAaedKT9mCeBI6R4aJC3?=
 =?us-ascii?Q?q6TLOYv9VDrepO/K5NY41avnlwpRwsslTf0ia0ty2NmEC474mpfDtvJqfDxT?=
 =?us-ascii?Q?FMn1jIn7XjsgyZC278ewf69Jc0KlhlhqJY1ofxi5LSijfa8MpRjX8yVCMAF6?=
 =?us-ascii?Q?sqh5LPDD9NSn884pYdoxN2lchP/KdjZt7bu4d+BbyP9F5eKTrJf7Xu0NWpOy?=
 =?us-ascii?Q?6jxz8ip5cRnaEbGohz8AvS2yq3cFkrFNIhlrlyIZA1dAapk6y+x4PQCIRZ6S?=
 =?us-ascii?Q?YGOhaxt7CLTqtWrgm8BtAg33k99lKgn32cX4uJCKzjqUPSGG4P61HUqy5z8R?=
 =?us-ascii?Q?FLfFA+2npgzZfQNC5yQuIEfL0G0ifzMpKT1qPPHE+3ovPR/yDPJDKnkdjDss?=
 =?us-ascii?Q?VOtyk/s/KopVujuW6PP46iPdFKuQqERYqRswlCHAgn+P1ZjnjtnyDU0zQSLh?=
 =?us-ascii?Q?VByenzv8x6ZyUoRjjVqyH0NA0s/m6QB/NsyHZMZiuCy287mEo/lPBFKnb69Z?=
 =?us-ascii?Q?YWtbgQZQ7oB8yf7e7zeAZ1rzpHbdtcGR4/H5CZtSTRz/6abr9zK/20wB9dhd?=
 =?us-ascii?Q?AFD+jFuGn0s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4acl5saLglfRzLQtH8ZGLEgeOw6/BrlLn3G3SzNYAzdLRpyLb1CAaWHoivcd?=
 =?us-ascii?Q?UcHc/mC+miXy3wtu658OmOxGtx274yY5PNyERN4VraImKDB26/NLD2CBb0L9?=
 =?us-ascii?Q?Y0MwpPtC8OOGra87GeYq6eCDHboCEum4n/byIFqLbNYUueV2+BSKZHBlXHJ5?=
 =?us-ascii?Q?ELSk0MpR6+zFUl2RZPT59pYy/niWtyB6Eivee2uWwQQvc4YdoaYCQTnVTdIW?=
 =?us-ascii?Q?GNpCgAaVUM/PUtXP3uFfij+vAGRw4orfYFMN3sXd+ZOIyrt3Fcjde/m3vHr4?=
 =?us-ascii?Q?IFwzVk6NJ404d4rA8WWNrUSkixBmMzXJZEgE8aPj/V/kZTBXxB9L5Gfb0+BE?=
 =?us-ascii?Q?1c+Dy6Fn1QSzIBemzPC9m0T5iZ/H1BOtpEK0p1Hr0aO5C2i7ZMaHk0wRU9Sc?=
 =?us-ascii?Q?ipMRn5rGxwmKFdlp1yRoLRqEj5vL5Q+adzAhPX7GbQ58U/oBzmkIU3yLPu0M?=
 =?us-ascii?Q?HXNHTDADsvB/hRJonHwUdmNwV1nUZhqMGfRvoiharQHPl7NC2CitrqUTxrJD?=
 =?us-ascii?Q?z3NhQJo7YBaBrdGGQSYYgf9UCG/88izPY0xDFtVham0aSJfyYpadVFeXRCJP?=
 =?us-ascii?Q?gT10LcCMBo29gk58YHZNR/0q+Xa6ZWA9QRbiojZaUvdDFv5eYrHa9mHQUAes?=
 =?us-ascii?Q?OBSBvE4rraoAjeKfwyZittunUHT6AM5Lr5eZ4yTr9CoiAeqqZEqZmLyCByrL?=
 =?us-ascii?Q?57iBGrYSjuOzipQejh2oanSRHiIzn/S0TyEF4yWng0JqJ0tjvOGgogAmbACR?=
 =?us-ascii?Q?VHomGGApzPUWqdcZJoaA/PGh7f2NPz9X8QxCfp9R01r4apPeBjxFAHEITPj9?=
 =?us-ascii?Q?uowRcY1Mn6Dyg8CsScaWvxU/JqCcsWBU1PyNybkUHD8uJwip59BxeHB4hMaS?=
 =?us-ascii?Q?Ky/fayHXPiwkqwcTb3gqp75TiOzbbBqywPHa4NCe8VS5PBAx8ahnGlICn/CB?=
 =?us-ascii?Q?Q8+hoIPhbRFIvus4rGam6g+VF5OSyN1QYp1jzSU0fTiedh3toOszWzjOT2on?=
 =?us-ascii?Q?oQJspJftx/IwvNdcm6cjt8Ql79IlnU6h6JCOT/RUpFjPwi3s1K4GfKJSS/13?=
 =?us-ascii?Q?XTxbO09lTYUIDYoKV3Xw1y1OWrs3ZDeXItqJErox+Kx40gw2sm3jeF4JEp30?=
 =?us-ascii?Q?HqSZ+yughSge6qq3CuL18WPJdtuRZL9p4ONZr1GFxWp3ipmd3MAgLDDfYHb4?=
 =?us-ascii?Q?APKcvGK71sZJjYebP8M/0qteuKP28sgRClRjUAOe88R2Mk2Lr2IIb3RdUJcG?=
 =?us-ascii?Q?hfBzOh65ZfELl7FHL6vQRMSrMsfzkka6fRPpJu27QdfDrDwE0fat6hG/ugHz?=
 =?us-ascii?Q?p4iRe3F741Ynxx70POpOR9n0xnb19rPophiA8D/WV2KCa6I2A0FOtd9PCoI1?=
 =?us-ascii?Q?HONcMtIgaQoJApyjp5Q/Xaq74v6F9RdsD2G2jvz3e53r3/vBAnHJLUm1yvg9?=
 =?us-ascii?Q?h7IDGpmOWn+GNjJU6BjtoZjaww/Iw9tCxQHM8gh5kbWbohX+BQOoCBEa68ZD?=
 =?us-ascii?Q?c93i0lMgO37fmnm9x3Dv8jGjSZbhWQSetQ/HH3XpXs9TMzbaGRYVl3796JEE?=
 =?us-ascii?Q?h6yIEISh7N6cQKGMyVfF79VYWT3IshzdSLnaPWHI?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7639269d-62c2-4e34-d70f-08dcb08cfc7c
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 11:44:35.9587
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LF4coIADzOiygmEf8WGfMgLCpaLVL9DuwqX8rJEf1Gob59lKjvD6gAXF25IThBRhKjyMDXEXG+x0VFjjAR288Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6520

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

Zhiguo Jiang (2):
  mm: move task_is_dying to h headfile
  mm: tlb: multiple exiting processes's swap entries async release

 include/asm-generic/tlb.h |  50 +++++++
 include/linux/mm_types.h  |  58 ++++++++
 include/linux/oom.h       |   6 +
 mm/memcontrol.c           |   6 -
 mm/memory.c               |   3 +-
 mm/mmu_gather.c           | 297 ++++++++++++++++++++++++++++++++++++++
 6 files changed, 413 insertions(+), 7 deletions(-)
 mode change 100644 => 100755 include/asm-generic/tlb.h
 mode change 100644 => 100755 include/linux/mm_types.h
 mode change 100644 => 100755 include/linux/oom.h
 mode change 100644 => 100755 mm/memcontrol.c
 mode change 100644 => 100755 mm/memory.c
 mode change 100644 => 100755 mm/mmu_gather.c

-- 
2.39.0


