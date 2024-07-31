Return-Path: <linux-arch+bounces-5772-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B38199430EF
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jul 2024 15:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E9B12819E8
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jul 2024 13:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644EB1B29A2;
	Wed, 31 Jul 2024 13:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="mliT2B7+"
X-Original-To: linux-arch@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2041.outbound.protection.outlook.com [40.107.255.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB8D1B0119;
	Wed, 31 Jul 2024 13:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722432816; cv=fail; b=sGd2+GOSLbnYEZ+34DUdvOhS6mQrj4h9T7eUvWrNutF4K+1zza2yBfbrzF6K/I1NcvzFpCQRSQr/Xxim5fZA4jQv6JwZn0D33I+cA1ZXf1wEH+n1/FKbn6MlzEbtBuennPPIobNWAr6qS724v03+n9OYOdB8Ko7QYC7eytOjpxc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722432816; c=relaxed/simple;
	bh=IfynjR46K2oSu9CTIKJ9uwo869z4B089oeIEDxZt0tM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m7msGqpC6jhWryxxNMagbh31NNLHnMA2RzQ2olyqtZ7wnbDzKjGFage+XbtjZnBU61p2ZTXfDF3Xu6b/A+ykXXoCJM1dcmj4isD0971Mp9pAMdJCsMJdGDuZbyS7Ph8hskBYZQCHMTGzqZ+j7B6aWpq7ZhgkhfnPNmkoeQtHeEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=mliT2B7+; arc=fail smtp.client-ip=40.107.255.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wyg155LufuVX4eGFF/0cX0V3abhdfgQa1lnTMNA0Uc96kQDO4W49Ke0cixnSt+vQ0WE56oS1sM0LK2O8B75UVfAcDbf4WbPJ+88sjCh1JbJk74aRYw1MEdit9CCGq/bS9pQb6EEu14KdhKJrMrAImLRQ72YFYPdC1sU2x/IBKkTp9imp3E0aZPvIB4qEsxNMKSlplY9c3Pp6F2FdrelsYs1Rjc+ESVWq5dFgg8sfqtfI6ENfVHxZRO1iAXwm64cKT8LXE+FM0mEDUYUrI75jIMqMtlSji8cdu/t7ELnmzJ2trrhfLjG75JZR/uYMVf22ulyQBdp9EQfE4QVf36Gy3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lyxFrc6Clfrofhrb3kvsAmejA25jBTP+9YIvp/aeLhU=;
 b=hxWM9XcSAJTzsa97wiINYEpO6p66Vqq+HbbtuiSblvdw7hWS92TFKxeikV1unI7oPx72ZrHsP7UJpqxDoazSdsMfJCqud9vwRlNoWxYKTOfdKDuKlY61kqOtbsICBqY4M0+NHMH3dpO7iLNgb5tU50oHeNHlSqzIkf/KP7QVnkU0OkKZfYq4BSiqDb44U/+DnJcJkgke8nN1sZ7NC2TzuIsjYPED+z+7/z/rScDLDvm+FnvknTtcqWemAS8cHnEWr9riFu7I6yj32pZkW1mBMZzXrMnoCfapCt3kaWxeZHlJMDetx2/NWaco3jFLlTMfNSIKFR0gWsw4y0QOrVjrPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lyxFrc6Clfrofhrb3kvsAmejA25jBTP+9YIvp/aeLhU=;
 b=mliT2B7+DK5nLl1qGxYmhcmtArAFoDwiIUCYjr2KevP/VQmrOY/3ivqJXzg0mcikQxbO0B9QZPUhIUpk/fl101zdVIp9HmWzLFfWI0U3PWFlqPS9tTtNHp2KNXfujA9IxZ3+5wyyc9YjDPRl8WNmuluH5PRgJkpP1vOJIX6N8Btjvsyu2nstoPJmS3KvHcL7hsS0EiZplQyF0WMuYLElv5/cXPe1b1+zaAHbBv/PxpW3AldxuHnnmMx1Vz5kHVa0xp2oKfIMm4xhIW+HIp1xNMxN2JjJQ4HY9cIy2Rf8hVEon85LWj3GVMQ2wNGB5JMUTKAoIlREieRaQUbQGKkVEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by TYZPR06MB7334.apcprd06.prod.outlook.com (2603:1096:405:a4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Wed, 31 Jul
 2024 13:33:28 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed%3]) with mapi id 15.20.7828.016; Wed, 31 Jul 2024
 13:33:28 +0000
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
Subject: [PATCH v2 1/3] mm: move task_is_dying to h headfile
Date: Wed, 31 Jul 2024 21:33:15 +0800
Message-ID: <20240731133318.527-2-justinjiang@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: ea452106-f2b6-40ab-a08c-08dcb1655cbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|52116014|366016|376014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?R7+Gq8enhSWUiHDdpLEDJfkl4ilHVQVdUr1XKj9MG7b9tzwF7GYT8hSKeKAj?=
 =?us-ascii?Q?Q8X0tBHcIyA7mD0qD4m2pqansTNG1xArGa5OgAN0lEePSJepdFt7tDRcAi1G?=
 =?us-ascii?Q?HoczXZpomW/ez2wkbg4C9b/+Rh7ZYOn5BbI8SEJ04p0ijOBnHmlSzUfqQnhm?=
 =?us-ascii?Q?2gfhQ2lrh+N2Cs/n2B7bp9QBIQeJVYMgsVfhdI9/CyBjOyMAwO3qQBO6BPKa?=
 =?us-ascii?Q?F3gL9gd5FN4nkdUTjEfwhw3iutRWQwobI7Gxz2WJRGWQwC33hV213knlIIL7?=
 =?us-ascii?Q?ubI8ZTjnK0Bo4i0BqCYvz6vILHEGX4+EHQIQlESniXKBrcSLWp5BJ99w/CD8?=
 =?us-ascii?Q?nIAcfobaW67jmADPAOe6DoONW/fOybRX57CxsFZVB9TXCY2cohXLM/9kNQbV?=
 =?us-ascii?Q?ZG0VrOGJOtAPoH+YMHVuYudonpspri0PIe/pCajLUDyoEAfi6N7wqEhAekQs?=
 =?us-ascii?Q?iP/uAs7sR8tW0Y+tStBC/hs0BD6yC0beaHhjZRUaFkcPx4l3M200KaIcoxU8?=
 =?us-ascii?Q?2XnpVTmT6m/V+1rMyUgDmkOtStMci3+DETDkCCyxV2W35V1VfVnS1nRP03rP?=
 =?us-ascii?Q?YLCz15s++3zDAFuK2SQYNgx5fI4O8rcIp/aQk7jB5axUcL9DM4AIwM0FxFd1?=
 =?us-ascii?Q?obwW7mUpg6U/+8HbDwPbNJxTDypzvq2MBVSE1iuGgJFr0lxRngZtxbvqbAmW?=
 =?us-ascii?Q?x2xTcHLHVQF3lq4tzqAw3ZxLpSlBhpOAhyY4w+kPyqSKK3UfcDgqLPVKBfOm?=
 =?us-ascii?Q?rOusNCJ2qyX6ZGW6b6dR6jLofve9jbF+y1CiGuk+kVb/y5Z1ABYYpVztQ8D5?=
 =?us-ascii?Q?fWN1SFJU5qGg1MoOS+JzX+3asr8QD1O0AC2aF69B/6CXYHX0VLETzjt5JvPY?=
 =?us-ascii?Q?RR+yHQ9Ohr+qmXz2erfy3lm34Z7qtNg+AKEws3C5PHdcKAHa+/k7lg78FzYT?=
 =?us-ascii?Q?q84cK6Pf1nTc/2m18FtSvpQYTrGFD9aSc1NthUWRcOowPO+NDtaZhWEvd48N?=
 =?us-ascii?Q?IQsZrnA6osHwabN1rVhYA5+/SXwH1/2KI28vcr1vuDkuSsrWbe4HNdCjFm9r?=
 =?us-ascii?Q?A4elqmSB748yWeORsWBO+LGORc8mrnjkRM4EqIvvh+fXhasumLIOESoBEGf2?=
 =?us-ascii?Q?3ekLj71Ey7cvgDtGnrECFztGPgksOnSrXDb5bWhWKmFG0Bp0PjAiRwuzaYhl?=
 =?us-ascii?Q?WeufL3pU1FW7OZU3mPx9nbm90a86Fj2cRQp7IWh2wk9qJE585CNM+2sKyRCQ?=
 =?us-ascii?Q?269gifz+266KShRidA3noOWwefa/S8XCluqDmP4No71k1zSZOAfs0nehYwsv?=
 =?us-ascii?Q?IJF+8NV9B9FWS5qa9AKsmp5L5jKxAEtW1KWOw9RUI9uxq0gGwdnqMzaQAzXP?=
 =?us-ascii?Q?GGHKlphrPS6chZ66o5KIOcEEVAVJ+waFjmDoY7eUUEkCW2jm/+AtOZYGFgWC?=
 =?us-ascii?Q?AQFLa8dw8Ug=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(52116014)(366016)(376014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?n6Uy8ZX8UOw9LR60+E3DJH3zgWAXiCDvb9Z4fgYcXXrN2L1qYTaB+/shsEjH?=
 =?us-ascii?Q?MTka+MV8ULkBzEVgPUxdG6l8lCdd9XvS7KwRW6NR0brbp9nVXbreBV7oYfmN?=
 =?us-ascii?Q?/8BWFTH+c+E3roBb4/ankx+AD2Bk9R4PFqWitS9GTxvhD9wbWQX+8uybTzLT?=
 =?us-ascii?Q?YdaoTW8XsLtOYnxlWrHbGp8N0KMe5/y8orcaJlYLefJnP0VmfUcfQFDBrzFF?=
 =?us-ascii?Q?o5dOSTPGeu+prZ+QWeE0RcGSgpIClA2L5jrQYYvugW60KDO5h6gTuwfcUktp?=
 =?us-ascii?Q?Fz5DzAn9KNhmKTF1S5B9HKKFPIAvtlHDsjBlGDu3WMAtsB30Skzzj+xReU4O?=
 =?us-ascii?Q?01M+/eIDTaxTax7YpRs/QyBblRYAEmuBbcwCBAHwRUHwU/emltmraIBxAWG9?=
 =?us-ascii?Q?TJbw4bCBWDXzyHlJV0/zYGXIRQL5sImCGQhpDJ/D0CLGlvSyB723ScVZlN4J?=
 =?us-ascii?Q?Qz3eLn3PcqL9Es1Tr8mMZvL+ur5zcqqGH3XaJVM6jyDbcnHAUPNFafIroodk?=
 =?us-ascii?Q?V3kHjL5AnUEALSeLqSA9Hdcj+Mk2RV8FLIQ5oT0smmu3dp+uNvmOLc7c28HU?=
 =?us-ascii?Q?v1a+tUSVilMlDa/MQ+JcZURgkaQ99QXNrOh5J8gV1OMm4DGXRs60qnYFJReR?=
 =?us-ascii?Q?lq+tY4OeWfl3CBfY3+NgvfzMoVlHggx+cCFTC/9IVyY9XL9G/w/+NJYbYasD?=
 =?us-ascii?Q?gNX2TQzBj31GOtBrgbQft3ocPxJ5b/8emjqUfI0MTSmYZhUXeqDaeLdmKJg4?=
 =?us-ascii?Q?MbFhFD4Vwp9HEOjb4MTFTc//8PwPLon8VqulPjDyFEIIVdDwVfv1XkP5hpnU?=
 =?us-ascii?Q?KFe6Wl9MF5cgImytvqJafBpmOzaPUgEz+UcaFIjjA0kdDmS43mP832642L/v?=
 =?us-ascii?Q?fq9ybCVqON/QJifoYt8GFPMRULL4ZJIThmSg/Syit3Yw1pK5IkdjfA6oeDxQ?=
 =?us-ascii?Q?XEBaywV07spE/qtKwMyWUAjZhsZXMPITur8+g2RFzBgGuaR//42kx0VmvNrc?=
 =?us-ascii?Q?WgWztDO/qixTGjagR2X//JyFqH5qpQvqW6WYa47d0vuHucSBnXdMfnK4hw4H?=
 =?us-ascii?Q?EQjmrNIF//GpL0nZWeyocTEG2A7UFy/MIiQMwiLFQ/UWMdQgTKN/C6eON1zR?=
 =?us-ascii?Q?XkydXMc9VLKZrEziDUdXXIHmIFnezu0iWvY6dlL9xl3iiidhh3NDQZwra1PH?=
 =?us-ascii?Q?d4XH3C5c//QcfGFpQn/OGm9auNGstfYLiMbfE0l1bVHrNq5fSMN138fUI4Zt?=
 =?us-ascii?Q?XVoi4vp0atp+6gH6h62oJRFnnjK2UykOgOpYF2wKge1JzXd7pKDbt9nYiLpt?=
 =?us-ascii?Q?GrvbpYa3PP5q+D8dxmSPse6rtwe/UaMqsn1sm5A9U0PoYvMYXfEAknMgs0Uv?=
 =?us-ascii?Q?ALZIiAtSzMMab6rEOxN2h9br2cS4DruP7ebKD/vB5fEYvisLkNrY+/v0TqKv?=
 =?us-ascii?Q?l5UlfHVlfs/4B/yNc3kDxArEbkWBuGxFIHmphT2IeAevnlv7vK4aM7t4I8Is?=
 =?us-ascii?Q?2/7oS0lB5PWvGrrlwTaPmHHjD9Lp22y6rlUgy74XWK9YNsPtyeUuMWcQJJnK?=
 =?us-ascii?Q?YpJ5wQ0W0MJS1NAPxEx+sqQDDvLWQWPZUNmaKmby?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea452106-f2b6-40ab-a08c-08dcb1655cbd
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 13:33:28.6958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VZQ0hbMmoHrTMOPGbmSTZOVFasdEXeXhH4qqqkuRKxZBg+9RaDM8NEdbgE45htRMmGggI/QP8E3WyjzWZ6iEgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB7334

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
index 9b3ef3a70833..c54a8aea19b0
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


