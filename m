Return-Path: <linux-arch+bounces-5725-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEAAB941100
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jul 2024 13:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9CF9B277F5
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jul 2024 11:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC3A19EEAA;
	Tue, 30 Jul 2024 11:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="ZnWYkggF"
X-Original-To: linux-arch@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2068.outbound.protection.outlook.com [40.107.215.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2199019E7D1;
	Tue, 30 Jul 2024 11:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722339882; cv=fail; b=f50iq1J4B5P1R9ZvbzHv4JoNjEL5qQw4JG7FwdTZ4dp+vNULdwtmC2IfGHB6r4igFGoygBTSspkFmWvqH0wAN0V4uT3qj2AMS0F73/VjbrPxczYf9kKC1MiU/ghSwJHDUZax95RBWOzUFfKE1EBRzHs6d5BXNOLW9iOhppqd0Mg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722339882; c=relaxed/simple;
	bh=IfynjR46K2oSu9CTIKJ9uwo869z4B089oeIEDxZt0tM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JLBGZ0aujfjBr8FgOiAN0CDd+ppRDSKrqkBIv/chT3eYbp7ZyIFpHGMV9INbDOl8h95t5qiDyjSIzTMSVVh5YAY1ktWxc5KR2YlcSRltbflOivDazW20JiY5vfSx+Z2j8Q9I/2i/93oGuGnlqqDwsmrdYT5vVFCMUDbYGOVJ5U4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=ZnWYkggF; arc=fail smtp.client-ip=40.107.215.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=edAaJWcCrABKLfIwgirbbLTusm6buQxCBJP4h4SriQ77CqJ1IAlIkoPjiWMfshvr2PzitxjOb5ywpJMHKI37Z//CV63lYR9AD6+C9d7ZN+3Wlv0gbA2cdkmp2I5JwUe5RZXQrJiBory3ekkFSUk+u57Ha2m1CxynpDKTgF2W9NHT8YeHqHBIN6D717ytLXziX3rxYF1iABngd66k+wd28QrH0JnjgaszRhT3BuFP/VDLl++vy3DYe/x0pjks7IDs9hd/iQGdaNN1Gsd2X1deZKm+FvrMMCFZXKalUIFv9PBo/3BlpnTGPGMYvFVblbA1rFdlPdppMQXj/ckEeVqvBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lyxFrc6Clfrofhrb3kvsAmejA25jBTP+9YIvp/aeLhU=;
 b=BBfNWL6kmlRBx2WedY60xNqRA0BpmpXlczND526vwkxgvJbBAbWM3Qn3LmI2sYEX2w7AAWIqZ5qQm9FZRdc7k7FBUU34hxWvlSRjyTIdQ2kG2Pqp/y70QoSE8QK6Su8cjuxcL9ObfMNevWdaO6r7cNtDj9/X8Yl/aEXPrsnBpvdPety31WCXKTvHNza7DlyhIb0eIk6YNcUu7aWhbN4M8QANMYRPqEuzsbhd7/Kw9MgnoyKohVnj9gBisOIdqChjiPbzYwuEq1cQbHHazQEpz2N5E6Ov6GL2o005Ch8esQ6LJWoKkKcMFvDoF8wQMtWxO/LiNx+k9NTsufxOpQi0Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lyxFrc6Clfrofhrb3kvsAmejA25jBTP+9YIvp/aeLhU=;
 b=ZnWYkggFLTJW/LWEp6yQeFM+udpDyffnSHL5+PuALL0ajyaSc7CyrspafWpaPj/96QPOfN0wsd2NK6uhwaFJ87B9/wxMvIYfcJH5AbOnFBfsoAUAGjX9a/Hf+Hff9150tH/eYDqhzfoxyoE36pmBCXxdMktzpJeulbk0/747px1ctLVbd07FDPkiZnvEbd4YhdPy8A5dij203R4ChquxPSRr1+WGmngTGVLWgH1I3OiCdKx1qHCW+GtXCvxlnmetXZwu3JfInTjz83UDlYULjPYHr7tmEuWE5nUsFGTr2wxRiUMdbQiQGlbX3VJUxphnVcv4rT4SdZ2Ci1OA032pBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by KL1PR06MB6520.apcprd06.prod.outlook.com (2603:1096:820:fd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Tue, 30 Jul
 2024 11:44:37 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed%3]) with mapi id 15.20.7807.026; Tue, 30 Jul 2024
 11:44:37 +0000
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
Subject: [PATCH 1/2] mm: move task_is_dying to h headfile
Date: Tue, 30 Jul 2024 19:44:25 +0800
Message-ID: <20240730114426.511-2-justinjiang@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8596e6d6-d95f-4374-ec8b-08dcb08cfd7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VA6BcA0maItQ5r/HS8h836amASMLoL8nK3PeRP+S5d8rl2aPbALQ0mK2rXqA?=
 =?us-ascii?Q?i9ekRAJniyjtXTwC/n2dSeVktI9URiQraDnlUCe3urHUAXRVhpVSeTzE2gVB?=
 =?us-ascii?Q?bzGomtqnr4JR+OSggSthAadJnaSQFa2tSr+RnmTfmKdsZnBIVIxtGYOzMuU3?=
 =?us-ascii?Q?PhLSKM7VjbNAgbwfpIEGQUL/AK7igpCktjvAGy7d6x/2qY5jrXYNw0EAH3n2?=
 =?us-ascii?Q?waL0mj3XRO/qiPDooFFOCsyx6GFp0Fd8XOVEwxm6SJtQaR5cK7ttEXEMyaoe?=
 =?us-ascii?Q?6enL/hZEOOv8AmV5lOzk81g/ZfhfNExeHJchmXVIqBtcsDLW1oEJ0YnEiO/J?=
 =?us-ascii?Q?nZb7HEVLechOloX7F+SbSMmZX4W0Vstu826mzxRiNJW4HCS9dKfV4b++31j+?=
 =?us-ascii?Q?fj0tNW4KjTMX358Nfq1CYZJm15GCjesWivs6wtcJOKTbrLld0m08vQZlx4jv?=
 =?us-ascii?Q?kxuERlcAQd4w3OhONRNQekp/LXlohFU8UiaTWFMjX03tEunGdmlaQ4jDhaan?=
 =?us-ascii?Q?91DWlrQ0RVptMiYjEXuKSuJei4s6eEhgEEKBdqn9B+i5MNEmvTpKKvpBKjmD?=
 =?us-ascii?Q?VW/pCivBuOfojnywmukMi9f6GvK8TcjQfYf71SF+HKJScQhrdzSSts3S6Mc5?=
 =?us-ascii?Q?6dZ79GRl1GGhtHRT9EXvWxQ0p66VH5asepKDt9J1gCHatMENvoXBe8vcm/D0?=
 =?us-ascii?Q?fIi5ekK1u8iuuATR54lkC6VOmKaPwSieWgIvXumvi4ktQApgsZsETUY6q8mj?=
 =?us-ascii?Q?CzfkK9qrbkbfaL7iGBynMkkUU7j9suqK+KdiszmAlcephq2pT9W0Lr65V8av?=
 =?us-ascii?Q?c7LM5pGIs8IrT8ccOI2GB0zVV6CPfIxmuILwj28sI/bGdT6FEQ9vUnhpu9u2?=
 =?us-ascii?Q?xw6etEQki01AkTDqEJLEUtW3Vpt6tPVVaPF4McQeBE8NMvOU1SO2l8MyOk2f?=
 =?us-ascii?Q?8yZnTZx7h71X0LOMx5SxJcaRe/NDMbFRO0DFnHWncLBEoI6G2+PpZhZ+hxZ/?=
 =?us-ascii?Q?kNFNWDnZjMLSxk4EJ5kw90k+tRGJ5HrlniEY1Qa8Ag4Q7N9srT4b+1CZuw5n?=
 =?us-ascii?Q?Ahs7HtojywiKzvJwaczK5lyESNyB/4ZYiKYi0u+RWZWys5LOLqscy2hj5HNR?=
 =?us-ascii?Q?FcffQDedqUYc4SmHMray5IjcvdK5wVsYXpJW8OSqGcAqTlryAtpREwlh4nsa?=
 =?us-ascii?Q?csNciGM9mlxTm7QXeK0qTn07RAVSIHMMKtwweyAwWnwMbS48NA8WGCsn/T6X?=
 =?us-ascii?Q?XnEFIPBYaTic50NxcjsgkW7eh5TdIXJU5EKIzBQQlYgRu2EUCtcTJr/2nM3o?=
 =?us-ascii?Q?9RQJrm9BiwKN4dlrDa+6LpB1fjhNKgqcMayWsBcxzy7f1GaQym5Z2SB380uc?=
 =?us-ascii?Q?rUAat3vhYPXBaWHGHjhwtVfBP3cRuwl6MycKw6CB/gHbiKoy+wQrvFPZbSQh?=
 =?us-ascii?Q?BXLd5A/abIU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?USQG8Z3b9uQ0Kku77tquSSEFhY02DqTRxVSzd+ua+ST4RY8ppTwpK9q5lRay?=
 =?us-ascii?Q?s/35GnmTjHNi++xrAz3KxemgN+fBj+oZD1afmmEA5fYuBbyd708tzh1C67QD?=
 =?us-ascii?Q?CCplqmLykr99YLVeMjNOL5H6kcw09CGRfhau7YLwhGhUfziiAGn9Di/CnBr9?=
 =?us-ascii?Q?/dJDrdj1sjb2vD8Rpc7dx7325VM+TPewjOnSgwkcU2qZIaIsHf9K8v4Cfojr?=
 =?us-ascii?Q?R/DyAHOBqcx6NSwRqIW8UB1GT3JwxNLyaXTJ5l6txSXr0XyURrYbmBn34O/U?=
 =?us-ascii?Q?ECMgF0J5a35DcITqSUA6BrU8Y39+/gQH3gJPxQLkR5M1Uyt3PDO3bCqCAtnJ?=
 =?us-ascii?Q?ycI8N+wN767RyYgjUpwSNK+LMQTX8JH54iIr9VIQ5UHfRfk/BIDtPbG/Qt9g?=
 =?us-ascii?Q?3Z77+8HSWc7b+q2oxPgogkyACwqUINiV6M0aKvnjN1myaI6iegIkP2gNIHX+?=
 =?us-ascii?Q?RptUlEVuv69d8C3bPjyVAmH4o8voee3P+Ej8zX0Yqdth7i0qxd91ViKf6/bE?=
 =?us-ascii?Q?4CkY/CoL8+wAo5nkByYnA4xmaqKXZph9Qo6BPAff7GnTf/YW+Z65uAIWjzTN?=
 =?us-ascii?Q?/kHJZryuSnehQBwW1RAriKT6zWRD7+pSbi+GsdXpHEY8mAoJFxL2PiQg5hKm?=
 =?us-ascii?Q?W6o/6QKoj11CBbzaV3fUCUx46KmtUUCPuzbGqmANSyjiEIuswO6tSEzwmh6t?=
 =?us-ascii?Q?DL35euH27u3vwNTcGvzYjE2KlKoXnENrOHnZXWKS/JliOp0jyvKS2TbRepIo?=
 =?us-ascii?Q?KYvhuQi85SJqD8NyRcsdhD+KVgNIFqxKyT4+/nPj0500tad56GuSQ3IhuJrr?=
 =?us-ascii?Q?BgBdGCVbmTk5ltyQLJxV9pBZOFA2GYf8LfHE6LpVHm3n/HCLKNxSF6PwNnwD?=
 =?us-ascii?Q?djLLYCXC0oF5SJhwvIz/q9tVWlWNWloMh87PhfQ33H9qTX03blFm+OL5MW3W?=
 =?us-ascii?Q?L+kKqiiXY3mPwPlmuEbwJJ0KBCwgl6qeNsa5KZsxiBgjwU6FN3on2sdO5wIU?=
 =?us-ascii?Q?tDOvhEWQ5kjCqhAvpKg+oum18Tv9gVCo5qFusTv0obSPqjFBk6jHoct+r97k?=
 =?us-ascii?Q?eeU6OKJ6YH+jX53R6ac+lHe6xmR5YbU/Ay1BciXWJlDpqheUqvzr6ZgwXgw8?=
 =?us-ascii?Q?spyTQ/8wmWphXwfczY4HlLo/WOlNHSpwJD/PbSHPGkmAIrcFBajK7ftidQub?=
 =?us-ascii?Q?Jot1Ky+EGjo1ZtvvCCGCL/c8Mvsw+q6c+UPn+UjvyRdYyzvXrhd7X7fNyIQr?=
 =?us-ascii?Q?6xfLIqwdrqeY1CWFUlm+hcaSS4eKjaiy/GMjwCr7/SwvFkZDYd5NhcVuXWc4?=
 =?us-ascii?Q?cI9Jk5eyzQu8hdbND5bnTAGnVagirFnd6IgrhPhqOWCuRWsTDkOxZ904Iwl2?=
 =?us-ascii?Q?dnATqD4pLMTP1m4JWOrwRolu4V3xHRLL++xGSjmsa6rdFcreA4w42hbKIquy?=
 =?us-ascii?Q?lhX7+gF6WMoKlKriIuJdoeQtjO+XMwXAgrtsZaNLoPniF5DErQ21GwzIGczR?=
 =?us-ascii?Q?y0NJbsgv9gYxlhKgkBHeiTHcymSPIvgTeLfGvZ2NsbAdsgmCNV8HnMpIrX2V?=
 =?us-ascii?Q?LEvJ0tNpuJiCPvd7fTRB/ychnPEuUkCA2sYU8Hu3?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8596e6d6-d95f-4374-ec8b-08dcb08cfd7d
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 11:44:37.6413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t26tSBp1kOJTxpiGj6S2X62+H6qZlfzfgAG/NOg3CYWbdHXZ+pFFPkBotmii1eiaYl0KEOL+r7ZyURHaMY+dPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6520

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


