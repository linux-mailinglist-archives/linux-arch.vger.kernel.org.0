Return-Path: <linux-arch+bounces-5771-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2489430EC
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jul 2024 15:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D2ED1F215E2
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jul 2024 13:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87FC81B1424;
	Wed, 31 Jul 2024 13:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="deKRmXv+"
X-Original-To: linux-arch@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2041.outbound.protection.outlook.com [40.107.255.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FA91AE843;
	Wed, 31 Jul 2024 13:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722432814; cv=fail; b=X/F9stzBlBIeEwraKxkx+qtQ1IZe8ujDnx6TzAD+IEA9uxW7zXiYRdglVFvQ8yzSUfJqoeSul5ADHgeKcjvRA1ntwxO2FdoLSvNInW27mG5LctoIhyhfcYGGyfrWRcMvEe4BKMzWJUS+CI8JZSYoenVc7R2llxIRKe5d+wN9BjM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722432814; c=relaxed/simple;
	bh=NVhp3wDmIvo3kwnp7XqxNiZ1K1cxv/6n6YgzZwsr3C0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=fTYUMY1nhh55PhmoMG8XI2onPHmrAxvF+H3369Jn4dXAM2k0/FCkXQjdpJecwzGyi7F1LajztiD5111AnU0lNkWWWB8h5wcE86Q6tb/27dWL4o19aqKF/ZuChAnxtH3URXdoBBODL52AzWY6bgD/XbJ7xXpbZ9qjx4SGaXNENsc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=deKRmXv+; arc=fail smtp.client-ip=40.107.255.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ei6sk+BpT7vSAbxcCnDrQ/ryQowujcgU/PF9BbNS4I1LhLEbcJCc97AcfsLoKkKzQLY48ow+NVDVts21kGuqwjU1aja5zF3UVdUDtc9P9cAWoWIPC0qQg0qSfUvh18t1R0JCny/eFZ9sBdiQZzzWmaF7GBXRvOtglGc2Exl/2ib7r/Vbzac0VUXLiH3xvnPOvAGmOglPCD16OHEN5qBgPdZrfGxUHjIaVmZG0g0xgc5/iDi+EPvsoFwsJSu0wLux7BH7bompRD6mhpJXxThz/O2PVHG+QJHomSmAatk3FO4Toj4t9pooNZDO/tEtZ2hk0L1AbGIKmDsT+6/PENGg2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=739J4L0eZUDa9JBOs+I/9WEAuUcr7cIQUlrDGorXYWI=;
 b=Rf3tA1XpwYaXjLplkf6jRpoS30sMdZG7ieV+nIEbS/tm4roRzSw02nG59/sG1jrXld0zPOueK6I/6sRTrrfQbR562MzU0UxU3RM3FMQWgRJl3XjmO/kLHH9BLrPdL3xeKXgoEiDfrv3k5+YOOlnMJ0McvKt2MJE6cPNhn7UNY+acuetaIzpKPPE0FDsBNrJUkYb2Il5eQLf13N6uC8IoES2q+SE0KYx88lJwuTvQLOy+RWeH4iEmJymZfwNRRV7bzX2G3s6EzK8epoqz6v4qJX06z9BN5Ny2L1VnvJ7VjrFC70iZOhtyHzacY+y5dCDxZQH608bAJ6MZ8GSZbSdjhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=739J4L0eZUDa9JBOs+I/9WEAuUcr7cIQUlrDGorXYWI=;
 b=deKRmXv+xn6HcAR38Zzm9DgtRvrFHAAmfpC5WCbVsqihtl9Uti6dToO52d54GPUX7TrYhbOCksDauo1SF7bdcvHAIVmPyx00L3KVy+YkxRnWvm7uRK3NoOPWIDL7CgFv9J/p0OGHJD3Y4LxJCFQ8unZubU77yohPrdzmW8JtRyWryiq+3pjfh4XeXhgzH12bfbaxY7NVTEB9PjfKhled0opzTRBouMv0YOZgviTjdGjSR1No2OPjEHEGCrjqgsqXuL4/r/N+OVqpIApnh8C81oYQHOMwE/ba7n4Ye4FY8kEbs53pFAXsFeEgMLC4JB9sptXy21tS2bZ7NoEVrLi7Lg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by TYZPR06MB7334.apcprd06.prod.outlook.com (2603:1096:405:a4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Wed, 31 Jul
 2024 13:33:27 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed%3]) with mapi id 15.20.7828.016; Wed, 31 Jul 2024
 13:33:27 +0000
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
Subject: [PATCH v2 0/3] mm: tlb swap entries batch async release
Date: Wed, 31 Jul 2024 21:33:14 +0800
Message-ID: <20240731133318.527-1-justinjiang@vivo.com>
X-Mailer: git-send-email 2.41.0.windows.3
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
X-MS-Office365-Filtering-Correlation-Id: d69485cb-c47e-41f7-1951-08dcb1655bb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|52116014|366016|376014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CYZVpTy+VrJkOcJQcGUeBzFG6SoZLhes0vjh8XzOnoFP1NeeHYuqwHnO2+N3?=
 =?us-ascii?Q?lVG07Qb7jS31teCs7QHUHOIwXYNh076++kCumIdRWu8wshy0NaLJqefvZRlO?=
 =?us-ascii?Q?KKgJTtv1c9iqBuq683jRLjfVOuLFCgoKyjuWQ++XnXIyXZ1lE9VNrnG74Xyb?=
 =?us-ascii?Q?AUcLfV8gGZ2vcksXKEPQcL6XjHYyVe+ZEsujsuFWyohj6T4w+MVi513qp1qR?=
 =?us-ascii?Q?jVA8mZ5zSdyij6KJIJlMeTFuSfIrPamIUm1RBLvWA8wVa9Edm9veHv1ouy5m?=
 =?us-ascii?Q?GujVcbTfkTZtrUK8nNFiuTgVsdc1Ij6nOTkvR3/dlPnZTUf6nVYyL9BwEhj/?=
 =?us-ascii?Q?ZiK33Zyx1hL5XHPeMNmBkKe+uFO8+tJ95L6wcSd5yad3E66P3qahviuAudqG?=
 =?us-ascii?Q?jaSEJKjXjDxBuSdAmVsceEWBXnc3aIIJ4jTHElZmdO9kLSuu+evJX7oslv3m?=
 =?us-ascii?Q?mACO9KCbR5qi8QHa0PMownCQSTQZsL7cZBEDplRFBBT1NwrBmIcnrwGRXDJo?=
 =?us-ascii?Q?BwRs2CScoOWNRarX1z2zjIB1+6gRxzd8dGsmxVKokMwkjkQcgvp3t5YE9EEl?=
 =?us-ascii?Q?yxkbYpbg4qsFkk3Ayng2pJuC0ii2FvccA31r7g5rUenYIkHfO+oGzgaI3F3E?=
 =?us-ascii?Q?BnHAu6Y93m1Gvxk9KWeSMkaNaECy587FS/292k79yIlcGoy0+KLhcb//42aS?=
 =?us-ascii?Q?ehqnc6+8n7Xmqz8goKrc4s79DrE5q29i/wZ2EU+RoTvuhVvWbdpZm2QswBgj?=
 =?us-ascii?Q?n5ZaWdNqcrtni4YxtbzFoMR8pdZSsjGJn17YE4toQGOlyH9NrsJ1eR4+xHNH?=
 =?us-ascii?Q?DJ1GhwHyo8vD9UCuPVK6FhhNo2X161Siy9nefBQzEAegv0rGlqOAI+S2YXVv?=
 =?us-ascii?Q?a00wW1NWpFoVLmAK8Nh35NekHwYRIORgWbxX2beeSKgPYAVcBGuRHb+wqzts?=
 =?us-ascii?Q?QujxJXdhbJRuzGoUOzKZLgcikoIwrFETO5C6WNQvEDv8Kr4U7FOA+ABSxNzU?=
 =?us-ascii?Q?isM21VAj+2Cggrb/MTXx+aVY+ZccRZXDIPYyIVqqA5iwNj1udgkBSXJ5KKmJ?=
 =?us-ascii?Q?UeAA8XlH148oYtDfQZa321x/b8i0DOhJ8osJRN77ikUpfTx4K/Bz9YAGYIFX?=
 =?us-ascii?Q?2JyBgv9/A3grKcfRT6tQgDNKFsZfFKIoAKQ5U6zaeors7JK3EnFfwFbAEEoP?=
 =?us-ascii?Q?Pay+Ved98VScahlLNIu8msayEK51Ubg3wex9tW1LH84ScKfS7zjLLuBAIUkj?=
 =?us-ascii?Q?Qvtff+XGpv1Ee0hnP4ItSGVzrcV1Xxp3tbyeKUUCZU6CYFtyTZqZGNpMYiip?=
 =?us-ascii?Q?uOT8odp8RDz0Boesr+M/gFrcidYXcPmz8SvlZh7uPb0DuVd7rIjoo3ZzWSAQ?=
 =?us-ascii?Q?c+oEk5/20GMYBarQlrpWUL9/d7bv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(52116014)(366016)(376014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5PXMCK3cLVR6rlmZq36v7Ex/1GwUrhRVxK/1vBy6klxuXHTnS/Q5Ueo3OV7s?=
 =?us-ascii?Q?HzCVlLBo1Dr5r1+OXM1GRG6xY0vHshZi9E1vQ4ZKjesLzlgX2fq9Yy7zwPPq?=
 =?us-ascii?Q?RIQWZdBBh1pTD3vqBNDo6PnkFRETNktp4lt8NKihlU9DH3Y3lLqnWmPjVG1J?=
 =?us-ascii?Q?64S5Aw3eqNYc85deQFSui152LdrBqIuErHw0IGLLUa26xzqZeKKBamVVNtBJ?=
 =?us-ascii?Q?qoyBlz/tonjtoRwAKtDm+kZfZ115YN1mekDUjfyCtgPusTy+TtvZnWfOp44Y?=
 =?us-ascii?Q?gPhL+b+rJDK0NlI+rI41HtPbQx2XUqEDJmcLbY3BsaJ9eNDZBQwXeP/LbERX?=
 =?us-ascii?Q?c4r0h2qrWrULbZsJsEbDhME1pBqduMndMsZ2TSDBZsZ6SdsWYTTJkzA7x+C9?=
 =?us-ascii?Q?T8lpIyiaa/lZkuLJbW/Y8ys73PNDphSgf++LGT9B3UmXHQm8eqUkDN2xcuZT?=
 =?us-ascii?Q?bHfFEoHO/4BLwblaMPNQ4OR+Cs5afRY6FdsvDoCJpGySV6plbBki86OwLfBu?=
 =?us-ascii?Q?BpFomHKqn5bhaBPivEdzCREx2opM7dW+f6siEImvxHxDql4UZn1N9SKcm3HQ?=
 =?us-ascii?Q?0X6eoc7tltekZLLoTYZKWbybqOTkP5ytifLxfosUYlxuweRpeC83lbHcKJfp?=
 =?us-ascii?Q?hT3Qv0sXM5MOZFvTFvoy8RR+Xkg6gd8buSJXwjOZ3z79M85UoBReuufnIXS0?=
 =?us-ascii?Q?kHqvpNgeT4S8qhVhCSNNao8tgfHmB0YL0nF3qORX/NCjyt/jFXmSukQt/dkM?=
 =?us-ascii?Q?lngrsos08gLOLMcud97k3lCtNuo7v6rp919z5wzRRWxHDfqZrsw7ca9SWdm2?=
 =?us-ascii?Q?j5Nh/nXn6VLNBiz6T2bAWBRVmuX/vrWu3tPQYBkRc4MmOfM72+hRUBQoMCLd?=
 =?us-ascii?Q?OhkIka/Bwn1+F0m8X1OYXoV9dOLOjcOZfM68+h40XlSA89cNvRGrsOzwy8sY?=
 =?us-ascii?Q?1AWyQW01wK48a5xtLaplVqL/+orYBRycB0UWOMOLQjPZ/dhSeHq45jL+t4eM?=
 =?us-ascii?Q?MNTUM309BjEJwgl5sWNdb/z1wwK+gtxy+q6NneG8PYEjx2C+kgG+glfq8VMO?=
 =?us-ascii?Q?pJI1B8Ly+RqdLrQ2kOChB2boJlFHbNpYnLZqkP+NDWapResEhY3TZfbySTBv?=
 =?us-ascii?Q?3yefs9Bfizx6H5s1oX6mWwZeBpMk4FeSUwy1WlmPAVm2e79cy3VQ/Kkca90f?=
 =?us-ascii?Q?tULkt5UpLHY/zyMrZkgQ5b2Hq/X9iE3ZOUL/JlEKotTspPsqUo8E0tuq48NW?=
 =?us-ascii?Q?ifXIwmjeIS2YLKAGbGue2BJ63xCU4PIaXEFnI4JXPwjARHTP/w+dskqt6HxQ?=
 =?us-ascii?Q?7/Xtep4PTioQwr7kENQ064evUCzisSozUgXml7ISalmb+OMlpNY0OoKufAE2?=
 =?us-ascii?Q?UzbAFaYoEeopP1FqL1jZvgSHiZS8NqaDlt2PKc4/n159gYSwb+GmcKoNlv6b?=
 =?us-ascii?Q?/nXOOi1/J0BEQ9x+UZoxRQ2U/5G1eoq+c2vV3j1Eo+b3kZOed9/usYN57H47?=
 =?us-ascii?Q?TWeGSZuEipY6u+i7tayueqajPq9QwQVCScglXijgq61QNzRqIqjL/O2/mltX?=
 =?us-ascii?Q?yMRrrwYb8zjEqOd1u4Roy3lqMWkI+mI+xVnkVCs2?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d69485cb-c47e-41f7-1951-08dcb1655bb1
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 13:33:26.9378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cko4TKMobaPu1w4yA91w8i3pJK8HiF4BezVs4Q+A6GqeRCcK8fgdZmc8ldtQdKvQqpiQnRZ/eZlHxfTJW8nACA==
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

-v2:
1. fix arch s390 config compilation warning.
 Reported-by: kernel test robot <lkp@intel.com>
 Closes: https://lore.kernel.org/oe-kbuild-all/202407311703.8q8sDQ2p-lkp@intel.com/
 Reported-by: kernel test robot <lkp@intel.com>
 Closes: https://lore.kernel.org/oe-kbuild-all/202407311947.VPJNRqad-lkp@intel.com/

-v1:
 https://lore.kernel.org/linux-mm/20240730114426.511-1-justinjiang@vivo.com/

Zhiguo Jiang (3):
  mm: move task_is_dying to h headfile
  mm: tlb: add tlb swap entries batch async release
  mm: s390: fix compilation warning

 arch/s390/include/asm/tlb.h |   8 +
 include/asm-generic/tlb.h   |  44 ++++++
 include/linux/mm_types.h    |  58 +++++++
 include/linux/oom.h         |   6 +
 mm/memcontrol.c             |   6 -
 mm/memory.c                 |   3 +-
 mm/mmu_gather.c             | 297 ++++++++++++++++++++++++++++++++++++
 7 files changed, 415 insertions(+), 7 deletions(-)

-- 
2.39.0


