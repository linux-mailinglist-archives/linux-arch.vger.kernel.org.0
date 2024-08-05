Return-Path: <linux-arch+bounces-5977-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C49947E47
	for <lists+linux-arch@lfdr.de>; Mon,  5 Aug 2024 17:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B5981F23EA5
	for <lists+linux-arch@lfdr.de>; Mon,  5 Aug 2024 15:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B54215B12C;
	Mon,  5 Aug 2024 15:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="OXnWYJA4"
X-Original-To: linux-arch@vger.kernel.org
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11011032.outbound.protection.outlook.com [52.101.129.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A06D1591F0;
	Mon,  5 Aug 2024 15:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722872217; cv=fail; b=UO0Uf8pXKJ2ifesIDTTSZs7BajV11i9jzaCfFqk+OOwK5vQJYiPZbvvu06Zvtfx5EjTb+qMIJVZE465XXqmCNebJHh9InrKhj7/t/V8Dg0j2DfXOV/sytOWsCc1ZUmJfXy4umpQ1iBfdtZXNY7o3tGci/eLzI7UQfp4etCm7Rgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722872217; c=relaxed/simple;
	bh=IjnkJGtqwYV+Wpm1KQghD2s2GnQmRg3JkOMYDepfJYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LVUaaC5vANV+hbmIbowiLGQxPoFmP4qoQiSqgeiuPPoXtavM51qV/YdXHi4PeiZ/WO2xad6LhVX8EX9qEaXX7KVrE7ZlUQaBLWMgzojJiwoRNsYgeCa8QrNDmcvnc705sL/J06J28+xVivm9k9RvflFvJNsBZA5jqPFLpYHUtQM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=OXnWYJA4; arc=fail smtp.client-ip=52.101.129.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JIWxvyI+cuRNHjWFMGBzhvfdxHkUT6ATmjQpqwunftJ9rpkGdtOIsctdMFZbSVLiMj2Uh5E80FetvWLxCjeXpHajVYn4unBR0FFZNcrRPsHcaDwIInQ2vOaDf3TrA10sdV28q0Hx4cSMl5GlLT1NCcgHTFXHYqQJD6m/4bkLHmQy6HoHt1C42i/L7wckQNb8sXmIKiQkTwKUrnvgjQ2CDW+LhpxjUhYJDFOT3/kgAWAL//H0z9SJ6VSX/lvD/1tEZY8NDHrw/2Jmos+ll655JYKAC6I+3RgtTS7JXgPe8c7g0L7EuXnaIOxsZAZRCog4ziSJMGE8VyX2kEaHqwk64Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zTdca26mZ0+y5WvCdBJjNuJ1RkRd0oVINsau97sg0cY=;
 b=Nz//xa4S7cYUhQ6kglg+60qstGdfLBhFNI9mBNVpneEXJQYCe30VM4m1bRlED0UGPcDavR7lugKP6Um1H5qgtcErMv4fJVz/7hjIOeMTnvc3MSl2mqudtmjFBPQR+SXcJQfxhdZJc+2ILQH3XI2hHPKDYh0KCtET1bSigNHudOo5Fgg3k3+SC6+1FuCC9bc3OOSYJJrQ0wvchwJMjz8femRajV95D44K3Hy0JI9YApkHgX2QIxsQUsEdBTYTGRcJm9Xn9VoIKVJc+GA/q+kKgDnHQOMGQMXon97mB8I2i42fpZHj02r2gkU7OlWnupGDLsJtFDk/tI8uAdTUZDDGkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zTdca26mZ0+y5WvCdBJjNuJ1RkRd0oVINsau97sg0cY=;
 b=OXnWYJA4Kc33FWLfi9j2rKufcYjguAN/sQ6XH7dIG9ZNRhvysQqM4kGMi+wkY/EGH4yKfjgIWGem2hddpGgOSbKCX6BZnPXOeK7wGToBXgxXYUQF5PP4/DDO8lnjUZxfqSe0HcQTmONhmPKlTzi3xgAos5CuE+xitNzE7ce6jVfOZ2+wsZxbUa7Nl/ox6u3tLXzdGD4YVgDn5rq32hxX6ZYozLOlTNasqCP2k4yX4YyBwDN7hcFBtpsfW2tSghRasVu4kEMnXNO10r6o2//6ZzWzvE1klV2Nhl42TTmBDqpQNWZ4e8BZel0mlR2s1j1yvewiTEkDiTdLLRJkKMjPIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by OS8PR06MB7322.apcprd06.prod.outlook.com (2603:1096:604:28c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.25; Mon, 5 Aug
 2024 15:36:49 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed%3]) with mapi id 15.20.7828.023; Mon, 5 Aug 2024
 15:36:49 +0000
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
Subject: [PATCH v3 1/2] mm: move task_is_dying to h headfile
Date: Mon,  5 Aug 2024 23:36:37 +0800
Message-ID: <20240805153639.1057-2-justinjiang@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: fcecb7f6-c3ba-459b-2d21-08dcb5646c2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|52116014|7416014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JdMay6IkSGrZY0QT9/LhwHRwBM4bMprEMxHJm6mu4XbYNsb158X9Cxu0Gt6H?=
 =?us-ascii?Q?3KdjW603xngOS76ya2ArEysWTeA+P4CddjkAZwUzo9PeECRsfJgdhUjiGl7s?=
 =?us-ascii?Q?G7q57+cM3e8YhEMyat6M7opAe0yUa8BgfIbkKJqt6pn8S2L8fNU+9sc326g+?=
 =?us-ascii?Q?re2AmTe1r4foH8t5UMczbVe+nSOvftGGH4nwA5LoEsbEKAoFcBJ58VTa09gd?=
 =?us-ascii?Q?zM8m+0yTplpKk+7nps4iCM3yl/oS3hNky9bLUOfiCmmtJSl6p05GDSsMXiQU?=
 =?us-ascii?Q?g0ocpwQskU8sus1+L6WHh3/Po7WCyGNQOLf3U09i9atXBTVbh2XHid219b9H?=
 =?us-ascii?Q?DRw0w947KBKE8e4wJnoCA6SXYF03wYgjCrSv3oqNg/U6gWgWMkBPwxWiD6/y?=
 =?us-ascii?Q?fmwt4/rgEfGTPo6suxfjRLHvBdbwCraQMgWCFG2Efx9G0mpg93eQh0QE8GPO?=
 =?us-ascii?Q?BFeLxUDle5jNe8W+Gi2YGwYdF+PD3Wpmzhp32KJljJCGHxK4SZam9qAUQl2W?=
 =?us-ascii?Q?x/MIL3OPh7jE2RojXJJrJC+CTg+SZgiE4yW4H68fvCiN49zh2uw4O46QG64B?=
 =?us-ascii?Q?lYhtCPbMWs07foMesYq78Yxoq4BHzq6Md0HqSQezNCuZgQGBm49hLEO4B49l?=
 =?us-ascii?Q?oO1LKn9M9dk7hN4tH8CX9XElVYegYopGDdpuTO1BqjeOhvW2K7DF4Tjxzgny?=
 =?us-ascii?Q?AD+MMbjx/acZXRq8H6Is+A222rTPlty9Z3Q94AhGNg7uLx7esIRKqSoymWp6?=
 =?us-ascii?Q?vuOC7GVaUKCZI21iQL2YW5PQMzPbbPxifmfPYUhtQOufqLjusIWYCoYZYI9o?=
 =?us-ascii?Q?ExLLMMYOs2g1+wJxSkqyaijML9+qmW9kInPHRoMPn80DrdLX2BwUdoA3B9/O?=
 =?us-ascii?Q?QqKsv3Q21nSDLAd/nAmEasoR/nNpXSKmORBIjn+/dkaSJmMhWleYPpBFbk+6?=
 =?us-ascii?Q?dcgxcAzH6NR7nvCl6QfD2lINkpfAGWKwL1Z9gAQSc1vTDv8rjInMIf3pDymh?=
 =?us-ascii?Q?mAcwGKKdbJdY9cT5LaLpUb03nAnpPOrl/tEd5yMDyTfnt9gRmRAgIyMAQ4FO?=
 =?us-ascii?Q?/brFUC8AynOJQWEEej8TIkvfmomnXuNYGMLTAcRRkoLdRFpsgOBS7QF+6LgO?=
 =?us-ascii?Q?YZf18c26sAsFasIhfRBqXRIljAusNNE06TdzDF82Wt/6r32K1a8FsdrfZNx9?=
 =?us-ascii?Q?FAxfEnVic0oZk6jOMKvyo1r2js/hvfCjwJ4If2/34glA6iDss5rH2YmnAUwW?=
 =?us-ascii?Q?ni9YvuKTZogWv/YSho0y2ug/11Hp/MB+XAXzryBxJI6qQ+XFUMruiT9i5AB9?=
 =?us-ascii?Q?MZC9eQxizcUHPSn5GFFZ+BrEpjWmtY8H+qRQCSGVPL2vlAxkQKZnkv8j+ciP?=
 =?us-ascii?Q?ap5Og+0NVwXSvNmAbuJ0uyTH9/l6+voaGU71qHOy6ho0YLc3O+w5aEh+EgAc?=
 =?us-ascii?Q?M/sVvAaqx9w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(52116014)(7416014)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+Rhcsr0dpZlTDDJcK4kjOIr3KICN7MCSTaWNmLvp3KNkQjCdmXWWE3ep0+eY?=
 =?us-ascii?Q?QUzhggSZzC2a35FOsuheOxhzk64uIq0QQBDkb7+ONgRoT1C9Czd6+0CWfCbh?=
 =?us-ascii?Q?3mFVTxmtTM575ohXEOXrbA6q6GCEEjLVu6duDw3jWVp4ug6eLwvFx3KY0pPr?=
 =?us-ascii?Q?O+NiUXGf+RwIMbkB29F/Ml7X+a8YXi2O+25DzsaAClP3K2un6woJra2N6bCJ?=
 =?us-ascii?Q?Sf97v4if/nT9pJdVf4pZucPH/RJHqLjuMhncjzQMj2kFHIwJ5ZxdVkwt3A+H?=
 =?us-ascii?Q?bW/AqWo0WF2eRzHF5JWtVpMvXoVlbTbtDdko8NqjusaXguxrVDLPuCkadNNh?=
 =?us-ascii?Q?j16XI6FMgWIPob5X4gi/B+av0vB18segzKqrNP6xJLU/wqvc4uteCVVDXpLJ?=
 =?us-ascii?Q?0PUa0zrFsk6pQpKfGuHR3TLxn1U7HBMESyjeNENNxFs4Cnaj5ezJ3RWLW3xY?=
 =?us-ascii?Q?m9UyTWqFfAMIgSlFqJndkx2pPJ0t47MtCA9wOANjVSb2+iVlB9pmNmWs5kEe?=
 =?us-ascii?Q?MJMIwfB+H7gfQ8IKqDv/1yzmcq318uV5sCr8FNRf9vQQ+619XxYCEh278I6f?=
 =?us-ascii?Q?QI9/3wJi7H+lwMqUf1zCQt0p7cK3WOFz7AeHwxBOYkz0J/JEmV1Qnu5+ifkF?=
 =?us-ascii?Q?UQCww4e8/tLLqjZFv3GxY0X3cnjJ5HzYOOJG/FAGBf6D3ltVFGo0KydQYXjm?=
 =?us-ascii?Q?DxcxPMK6oQ0XOtg89Wc0Wih7S7hbDHPvf/7+w3b33D+cp0273Veu48KBiUUd?=
 =?us-ascii?Q?9W3S504YT4IOn9e0JS7S4XHbKtmk1l3gcE2mBhZ2Nn2V0OBQi89Widw7VHgQ?=
 =?us-ascii?Q?CcpgAov3+/Trsk65I1KFy06oSUKSD9gK1J+mcP8xm/ILdkacWNzoK87VEBPL?=
 =?us-ascii?Q?+3FHwnMPN1/rgh0tCe3kk5R5rKb0DLe5YrnNpnurO1pG3t1+Cqm0VaRNcjKX?=
 =?us-ascii?Q?gnaWuTZBiWSVR38NgwYyIqI1FI0fnVoRZ3vUjJfZ2PjgWGjVowyuNJAGbfVN?=
 =?us-ascii?Q?wTwBzU+65T9YybiZtZKEApStqjKhAENdkmREBWpAih3Dc1noQ0H6XZ7FU2Da?=
 =?us-ascii?Q?w2kPY+H9PfQRhtQkw+kuRxNEAxGv6UjBQfgOuWKBccx6/EDfQfqu96LQ0pfC?=
 =?us-ascii?Q?A82gfSqoTndq4tXIJCMyCjsMifKaawGLOU2OhPwrAckSLHGQtGm4wnd0F50/?=
 =?us-ascii?Q?Fs62yoM154gDXapMsorB2Yqvyzag+YwfyAGjrBNfQXMpE1VBWzwTSluGn3X3?=
 =?us-ascii?Q?8POTelWvLF4igqwebp2smynyEIp7ViVxAl8wUq1fY5zOMFjtdk23yjMPOAzP?=
 =?us-ascii?Q?H6r7/chQnLFma1ehH55IuFM+YufKJM/OkXNS6rIXCiBuL0pgfYtDqfdI4t+p?=
 =?us-ascii?Q?3EY7rg99VLHf26K70aqiIHgmHXV7v5DSITrHfguE7fn9PzEgat8OA/ZQLOoP?=
 =?us-ascii?Q?xXgkc2TrQR8t267ucdziT4qvr6euZJBcRHf11nlC+NMNePCeqQjAwwqJnKyh?=
 =?us-ascii?Q?cv1c7IN5zn0vst/1rXR9EcohmFOwSAXj/assUMe7TNKVMI6g0BUaAWXvt0gP?=
 =?us-ascii?Q?PBIGHU2dOvBPSH0zPcrOrHUjwMhd6mrdYqjRk2e2?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcecb7f6-c3ba-459b-2d21-08dcb5646c2c
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 15:36:49.7314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TDGo/wF5OfsdaMCw38NP8dA9iMqI7YGfrSVDwW9J1z5owg3u9cJjIILHvYqFGHypk78XecJRfXCP3Bfw9JgcaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS8PR06MB7322

Move task_is_dying() to include/linux/oom.h so that it can be
referenced elsewhere.

Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>
---
 include/linux/oom.h | 6 ++++++
 mm/memcontrol.c     | 6 ------
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/oom.h b/include/linux/oom.h
index 7d0c9c48a0c5..a3a58463c0d5
--- a/include/linux/oom.h
+++ b/include/linux/oom.h
@@ -77,6 +77,12 @@ static inline bool tsk_is_oom_victim(struct task_struct * tsk)
 	return tsk->signal->oom_mm;
 }
 
+static inline bool task_is_dying(void)
+{
+	return tsk_is_oom_victim(current) || fatal_signal_pending(current) ||
+		(current->flags & PF_EXITING);
+}
+
 /*
  * Checks whether a page fault on the given mm is still reliable.
  * This is no longer true if the oom reaper started to reap the
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index e1ffd2950393..37054c94031a
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -98,12 +98,6 @@ static DECLARE_WAIT_QUEUE_HEAD(memcg_cgwb_frn_waitq);
 #define THRESHOLDS_EVENTS_TARGET 128
 #define SOFTLIMIT_EVENTS_TARGET 1024
 
-static inline bool task_is_dying(void)
-{
-	return tsk_is_oom_victim(current) || fatal_signal_pending(current) ||
-		(current->flags & PF_EXITING);
-}
-
 /* Some nice accessors for the vmpressure. */
 struct vmpressure *memcg_to_vmpressure(struct mem_cgroup *memcg)
 {
-- 
2.39.0


