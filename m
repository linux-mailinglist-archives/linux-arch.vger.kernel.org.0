Return-Path: <linux-arch+bounces-5726-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D7C941102
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jul 2024 13:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48EA428628D
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jul 2024 11:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63E619F495;
	Tue, 30 Jul 2024 11:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="aoouA7mV"
X-Original-To: linux-arch@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2068.outbound.protection.outlook.com [40.107.215.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0524619EEB8;
	Tue, 30 Jul 2024 11:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722339885; cv=fail; b=c6q0vm5vKX1aME1+/TJOl2r0OXdJV6UtQyBjpwgnc4KP0jlZ63bIMp+ICLk3/gHvSsK1/aw0j5NoQlAPV7DGMymCHzd/ZHfDF4DkNTQ/IXY/7FyJdpqIesAwowOOjLX00maV48RVJM7Q5ChFYKO3FjEj6+J2wtN0+635WJUJbP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722339885; c=relaxed/simple;
	bh=EceCXts2twk6UFb3Q7IGdB8mGnL1wMikqBe9qg9hlMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=inR9WOWLKpKMg94QOLCiYavFjy9+xx0X8KKCWqKEGl9CzeXSkwC/IXxTWlulYsyGNNd2lKu0CsZ1EWL4Vb+Ke0s5nLA7uyskuXCC4g+5cMQwD9VUxrMcDTk3JAmkIBSQMZ+kbx7Sp4YWB64ySVXNCxWLS3g9Xhp5Cppz+ywwVbY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=aoouA7mV; arc=fail smtp.client-ip=40.107.215.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c0DObm4R5A9T0kggyotd/FnNlji/MPhzTLCwEg0V5Sd/+qQznTWeoPtqcrmiO58Y4dMFA4S2JxMRB7TbnBVWkLCyTKo8kquspK3rwqBj4JPhzPFEbkEv6WJW6c8/sCs31dq8CmHV05EcBIQcNa52gf83d84RcaMyelL7l8TSInsDKyAQktPNEWPtj7NGwHVRdmSFTKE4olfrowpAT3EVPZfeIrqhrWh0P9ui96fJ07By/bn9n3p4nUjKrRSAFaY3Yqyia6sn0FanpbKILnA5rCKEgAB/igf+mwP7VjAo5LgpXIMn7REgpKBvMZxVfxLoFbW/sL6zJUsyr2FZXP0KWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w+yAbJV3p5E6MldL7D068KSuk5rJf9cNrO69LjY8gc0=;
 b=HutI9+d/ePfwdyUx3pGP7/WN9ToHMS7NKvq7OqISVcxkaOeKgsj1WDbmKt8q2LSRLM2zJX6q8H1qJkyuI8aG1rGNoo+piEOk7eQKqBmyILXCMJLRfuZsr4AWAhXRYVUwrP36gdD6Dcll5ebOjhDzJbT9FKdA+F2E2N8vKn39SmMs0vMYb6WyDVXKkS69A915+HoKYJ/bhprIDUjpsTk2pSRdaDXm/jLOkgA9qfN9He9ZzlYisoiWW61SdfCxpwpiUSKpqPjtEkjPh6lgucufnCXGnIGh8kW4i22NjrT4PbO9xaVs+6vVNaSFcp69vxDNsQy3R8GCcsY5nf7uPL3UJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w+yAbJV3p5E6MldL7D068KSuk5rJf9cNrO69LjY8gc0=;
 b=aoouA7mVgQxVfWHb0fnYHIfCq12lLw2qv3q12x0QENjoGMQsqQNZxKKlYz6moyCsIJrhhGYEAeRyxx8lfuwQJ4Z8WEO3smw59ZNT6iqRuZBT7vlWTndwZ+9CgB7zxCPVuMQ6hr3pP2oP+A/DYNhX1uXRUGPNf7lAwIFeNFDTy5rPdl13hZOQTbkv22SLrlnDCZriJXxMrrail/CHY9s0gJuwX/yRNNDm+JuJ/e9Fgb2MtTiuRvAbRrl8om8RtSG80Swgb+zL0ypW6l1cCqKW0rGdvUd80jexLA0x0yCOatv2i7rnxm/t0vk6uYjodS9P003TAx3PIj9xS2LUHXKo+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by KL1PR06MB6520.apcprd06.prod.outlook.com (2603:1096:820:fd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Tue, 30 Jul
 2024 11:44:39 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed%3]) with mapi id 15.20.7807.026; Tue, 30 Jul 2024
 11:44:39 +0000
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
Subject: [PATCH 2/2] mm: tlb: add tlb swap entries batch async release
Date: Tue, 30 Jul 2024 19:44:26 +0800
Message-ID: <20240730114426.511-3-justinjiang@vivo.com>
X-Mailer: git-send-email 2.41.0.windows.3
In-Reply-To: <20240730114426.511-1-justinjiang@vivo.com>
References: <20240730114426.511-1-justinjiang@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: a2057c46-37ce-47f4-54ae-08dcb08cfe7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YwYDK75IvZFtnWchv9kZ+bRqJpCKHwwGMa2ZQNIC+MvptbMAjY31gQkpGZk3?=
 =?us-ascii?Q?o14C634S72QXJB5gBH4DCtY81BWtJMLyqpnncTIXAiL8hb59BVrSuUzMzJ8d?=
 =?us-ascii?Q?wEcjdOhiTBvFACUd1Igw98ZYbukl9Nmdu+BBd2xvxTe6QSlHPMGJO3jVXoEH?=
 =?us-ascii?Q?JhLVdtfHy6UhLtUT0wmxTPwCi6tN4ZYOcmrGG2q4Y/aEd2rn9LD+xccVG+Da?=
 =?us-ascii?Q?qXy0jBKrX88SpqB0o3+tb6ecLO66YU9li95OVKS5zT+Kw0ZYdLQ/LOFk2KSr?=
 =?us-ascii?Q?MxohXwNKvKKa0+lHA7m9OdlKSwW+Q60DRPnhsE6W+Sf+PWv3n7aJIJOgVA4J?=
 =?us-ascii?Q?YLeznr05c29JnrihLrioHEIDh9dznY0eYN9e4FRW16WhZLeFYi5Cok7BhNyg?=
 =?us-ascii?Q?d0jb9N+S/xPJ7EG8crAhEVrwbc/OTJHQ/ugZUH3kSyQVZ2Tpqfo57qGraEgj?=
 =?us-ascii?Q?bhMJFamFh9FedMj7p/tsT0f7bpJvl6HCtc7BWIxzDsoHck5Wfy2f8AE1RZQl?=
 =?us-ascii?Q?ZHHfAHVvoTtKhgYGMHd7msJG0gpsL7TxikAcEOOGRcSM9A3jI7JdHyhwdL+C?=
 =?us-ascii?Q?4dG+WSAS0D24erQW5ftrSs31RmpcavUfQ1k1/aVKggtrBu6AYVi1bAF+cmTa?=
 =?us-ascii?Q?HgQeS2qfk7i2ELgc19aDC0yJmQsyCx1IynFS0kcL38j9sAK9Iczq96m+O7pu?=
 =?us-ascii?Q?g/R2KLxsQQwFoT7fjHokRH6P5l8NUaNk9CSP6LJ/fjzHXHxRZ7J8C04618G6?=
 =?us-ascii?Q?p0a7nOqSr6qtnoHyrFjUgxC+hXO6J+7I5H3wsenPCZgHJPWU2eePP+YeHAFD?=
 =?us-ascii?Q?AgZ1z8i+LwgJMHvaAknDK6xghomdIPw0is7EXbB81BmJ1E9BYQmY+kdwoqMr?=
 =?us-ascii?Q?ArpYczttISQJJx9L02okeXfSOUzyR8kq+vOzgUvEDrPiuvBp68zrbHmvv62Y?=
 =?us-ascii?Q?YRCGtsPNcLQvcB/SR6rXaacOdngBhqMW8Pj0ffHrZPUssVqXi8GJP4c8eRPt?=
 =?us-ascii?Q?u6hGOaiNS/yR8W/dL8xpwnx1a3SLG05iEBCKrToHTehQdaLtSK/KGoX6AcNa?=
 =?us-ascii?Q?CS3mb+urYSKOOSgeTusc56hVZJ7FkHYg4VWkYneea4A8wSKWcx2IQW6oAm9i?=
 =?us-ascii?Q?pVhdXGaBDvoqC7OGJKDqiZohholFpCPL2SnlgfTZmw1fE8kxQAiiAjrdBvXa?=
 =?us-ascii?Q?PZIQGkO0GRVs8W8i+hBV+HLehufKosp/q5M/yxryEwLz0+K7UcbmGrMot1TA?=
 =?us-ascii?Q?D2Nzbq2U7uSPbsVJX51hWsbEXNiseimwfpBRwVfouCpaYTGpIH9LWe9nFXj2?=
 =?us-ascii?Q?XPp1UFCT0j0DCr7fBDNmiPxCMXz7WTNEevd9lUdO/n1rWrCb1TfGi+JXccgg?=
 =?us-ascii?Q?B62I/YUON19mLW5hek5nizwI4v9VGen+/WZwiF/Dk+iYEOf/8DXnLpdwUaJP?=
 =?us-ascii?Q?FtxuvosTqQ8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BiKiRoeCiUsVJ3IPbYOWUQ49ghGOZmnLxJCGa9P3SY6x4LsdA5qkG+EUG3n/?=
 =?us-ascii?Q?RlfYcpvHq17+6Qcj/b1sU3U0NKQE76UeB7ITsLDDE2IC82S1oLOODUoClnWd?=
 =?us-ascii?Q?YxtH0zZ2DOkKCRWnz+RajE866IXGDaTtRlfN4uR1AoXJRuxoEdntrHOq/pxu?=
 =?us-ascii?Q?0JCfc2iJMJnfLpvIHkY2wq0fMpF2j7crWRJH9lmq2awJdJMWpp9mbXhPcMYM?=
 =?us-ascii?Q?3dDxDZkvhJc5+CWzBPMd1eS3knSj4vp69Dmlc48ohhavXmHcrp+dam0R+ln9?=
 =?us-ascii?Q?FHgZFrDhM8sK/3gwRJ7Qm1mp16BECrzqozE9JQZjRuA5laMdpBNiq8W09rYV?=
 =?us-ascii?Q?cDSrNCjS3SbVdVNP3SdDBVJmLYG+iBFThQRbKSu891nCdtJiXBAvKZE4HcPO?=
 =?us-ascii?Q?hD0YR7m8IfqEsWL2+uXZnfETXHxfpBS8fpBMBRYS4uArrw2ALoe8izhK4sqB?=
 =?us-ascii?Q?rfU0qTxYvWOqgCe9UmXFa6JTPAkIKr+EaAwwbxVTcc+Gl+TAdPW0Z8ngfTyd?=
 =?us-ascii?Q?p9F+eWHL0WULmrnTJTVLixNSkqDdkD/cOBe0gIgZFdrps1gr6boIBvMdJJhK?=
 =?us-ascii?Q?XIHiqazUxoXaVok/9GdxVi3hX+FXksOqlQGqDCbhdLX46i+rRQdvbr+JzAmT?=
 =?us-ascii?Q?A5wDLU9w/YR3FjG3aM75HssFezd6lsv8WfHMbazt5yv9Zy2i2F0j99r1pxcf?=
 =?us-ascii?Q?NzHeBZ4Ci1CyRQclGDlsCZS5zsaRtfpN1MMOYod2ePnbEvC7+On+y87zxeBT?=
 =?us-ascii?Q?gj8G/nwFMeV/NrroYrzDtXX/lbkrAyHeYaA2qsDsbWZt1gKLJcbdGj8rYpYT?=
 =?us-ascii?Q?YPu9k3JrmWNvaAwzdqMJu8ohd5LL4X31/tE5QHWaThUngOJy2szdmfxdl5H3?=
 =?us-ascii?Q?5Oo9rqyO0a/s1/It3Iwua/iR/JlOdQwrFB/eC9Rk+C7FRero0hL58sKtbA9D?=
 =?us-ascii?Q?JgWVp+Zx0WgMa3B3HMuMn68nA6rsx4O6Af8AHVc3PbJdITpnh56asg1E7auq?=
 =?us-ascii?Q?jW6m98tzhYG2Y+R+HQuoTcA+6Ij4d8ACtJYElL0yPedfGTv18fazotpyH7dO?=
 =?us-ascii?Q?osnnmxbpwhriXz3CAjZNsIXW4rub17ra6j4kFr6eJo2ytns6Z5LsONpN6m/y?=
 =?us-ascii?Q?NOaMFoU3LorDLJTKquV5cFmo973DccQ68Q6HEsYeXm6z9J0LN6jc5af4elGr?=
 =?us-ascii?Q?/RCgYcLHdEenG/QFfzy2cgDmB0Q5T0CaXdh2ItI7pnPN/I87iX6sldESDLjh?=
 =?us-ascii?Q?Fuf35L9nzEhdlgSNzvjxdPdFHlobUMoSmue5NMqKWKVqLTJKaDd4FDkAjqJf?=
 =?us-ascii?Q?iDEdZseUHEHT0VOZCseTFwDK7i/qJ3DoTK1uRqjQRg0sFdUbBF9aAt9BOr7w?=
 =?us-ascii?Q?IqlqprnMrhxc7tgKD1zeFwAAKqwVnLcCYPK7VVxpiiVzieru96bigL0vLbPl?=
 =?us-ascii?Q?+cbkhiWxp+rRexcSAfasHNKgiuZMsp9wo9RCkiWECWiNszUxnEuxRy8OxrdL?=
 =?us-ascii?Q?yM58A7trcG7nQ54nJm8FZOSjfrnk1hIqoTcZIxCvd97/dxPwwGk0mHT5Yjvh?=
 =?us-ascii?Q?YqO75X/VZZHl7clAGi9DuxMtemK/qp7Tg43zcp7M?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2057c46-37ce-47f4-54ae-08dcb08cfe7b
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 11:44:39.3257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mBVIig3OINasHb3fPfDVhF4wiPCoVKUKi9T1+TdwD/VZMImEhCdqPn30KeL7OOPCKJySj+iUUGbk9uUx1Jenow==
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

Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>
---
 include/asm-generic/tlb.h |  50 +++++++
 include/linux/mm_types.h  |  58 ++++++++
 mm/memory.c               |   3 +-
 mm/mmu_gather.c           | 297 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 407 insertions(+), 1 deletion(-)

diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index 709830274b75..aab43f1cf97f
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -294,6 +294,43 @@ extern void tlb_flush_rmaps(struct mmu_gather *tlb, struct vm_area_struct *vma);
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
+extern bool __tlb_remove_swap_entries(struct mmu_gather *tlb,
+		swp_entry_t entry, int nr);
+#else
+bool __tlb_remove_swap_entries(struct mmu_gather *tlb,
+		swp_entry_t entry, int nr)
+{
+	return false;
+}
+#endif
+
 /*
  * struct mmu_gather is an opaque type used by the mm code for passing around
  * any data needed by arch specific code for tlb_remove_page.
@@ -343,6 +380,18 @@ struct mmu_gather {
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
 
@@ -354,6 +403,7 @@ struct mmu_gather {
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


