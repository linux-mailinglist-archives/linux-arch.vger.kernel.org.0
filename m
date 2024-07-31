Return-Path: <linux-arch+bounces-5774-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6579430F6
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jul 2024 15:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBF75B2192D
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jul 2024 13:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64F41B3740;
	Wed, 31 Jul 2024 13:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="qcsdm8tQ"
X-Original-To: linux-arch@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2041.outbound.protection.outlook.com [40.107.255.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD671B3726;
	Wed, 31 Jul 2024 13:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722432820; cv=fail; b=BYYvssJ9qMmuMoexnPE4VpaQePi6O0vcaI79f5TOW0FkxyvGy/pg5PJ9Wzg2ATMm4UwPo2WFH0dU5R1PkgpQq41/DV0OmRng1YWLxk/Pcv5FVnd54C6O7lK9YZijqAVZ5IqDRLQPZWczxsl4AvwoLIs2CUlU6hBuF2uob9xefrw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722432820; c=relaxed/simple;
	bh=uiFYBNvG8Z5TwztF+F4vswF60rJZOxig0ngp4bfNr2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iPZsgSnbHSsTMgHSjnjbldVG/UlvS3ClMhhpMQVOKZbwU5CfW7NIvUmwu5etl0LMu9HEU3VYGoilHjxaEwvXlp6ZtsgfXl/s0HbaPdjk+r+rDUMuPBK/9JmWUxccFonmHbHxWHnse7XxqUZH1ZWs8nhlGV3W/6pwKA0JmABMD1k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=qcsdm8tQ; arc=fail smtp.client-ip=40.107.255.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q9aUvEIOnAY2YBqICCvRD6ldR99K0cZRjXbg2k/eP026xtNL4r59cu3iVQNYTCCW//iiENTCm6IZR2z+P5BOu/zw682hvdtyJMGE+xzhlpajUAtAkD/bfNTKhRO13XvoerH+bN72qZr+Dn6DeKeYSTcBuZV0DM1sup06y9H7Yzpdso3syFTZnxTPSnLwv9NTx1R7KVZFwVLWqdcMvFCYkEidPTJJozA0V4D5Qxdr/Rf6+4o8HefCOb2x7rVFYDGyNCZK3NfTE51MudPkgGpUyPkoKkyfe49uO/MpjeAwkGLqx8o4Ngupu5lwLtZ5cKRlkvb1PNhNGjckRSCjDbYYvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/QhpATYNabFfEKScK8u3kghz7HpalaoLiHjaRKPLXJY=;
 b=cXe0EKPbtH+Vcfh54VnBAFF3zmnAM970f++dBuC6y91eN4GblEWdue/pC0vMeB6JS1A1Wau0j264oPPvpxseAgDnFc1ASBrC0WDObu4d9Iafn/WvBlKePNiBWPnO4MA8I8Q3HAc7z6mT+Sm4YSPhJIlJZ81cetI2wNR5B0wZafDSuqD0UyMULDiGoqP+SONhXgX1Hpk6rD8v+y8RyRK1WwicbSZI+0tKWpsRlCs/IzNoqo+zqeHSw+wcHekqpSxiN7YOs1BPM7oJlsMw8aL57txV+ckGHDVU2CEdvsOCVt7E2/NSEVXq36RU1mtkQtI+C3T4DUQuCr3nQhHXKEQpzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/QhpATYNabFfEKScK8u3kghz7HpalaoLiHjaRKPLXJY=;
 b=qcsdm8tQjSqjvuimqVG1a6ww6jPQxl2b6qkvtpG6kzFmO4xU/QHzXJt2AEVezHkj5AbbYvNA+0+seAnkuXPM884mk3iBdlH/BphWbzxqZeETYxYoq+wP5KUY2ehcyIB+n4YnEUEUjuUQK3G2qv6FmIfBmLleWFNLiYa2JkAcRHgAbSObWkS1aS2c8ZyyIn3Px/V+BvECsAyYAXkcBn9v3L5mRuOVmFEcm0ilE75wtXrCNIdhYATl9W7fHVMPdIlBGl55aF3PNhg9A77KyORqKuXCIPklpqkPl7XdBmiI4gpH0blifBcS5iRHgf3Mr7roJOA3/dGp79HkzJeG9elqcA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by TYZPR06MB7334.apcprd06.prod.outlook.com (2603:1096:405:a4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Wed, 31 Jul
 2024 13:33:32 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed%3]) with mapi id 15.20.7828.016; Wed, 31 Jul 2024
 13:33:32 +0000
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
Subject: [PATCH v2 3/3] mm: s390: fix compilation warning
Date: Wed, 31 Jul 2024 21:33:17 +0800
Message-ID: <20240731133318.527-4-justinjiang@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0bf83302-f817-4095-26a7-08dcb1655ecc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|52116014|366016|376014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6Js3QYn0bUJ9K6TUrONW7Y+h7FGJubTjp0jkB9by/Ru9pohi1e4jIul7Fo7X?=
 =?us-ascii?Q?9SnxuXaNYxlwL8kG6VB20fM3+TtUf1bDu6DUZTYSY/Gj0rsk7R/3fkjzh5yL?=
 =?us-ascii?Q?okqZ9wJFggqXlUeGcEbJyn88/lYxs17zcaK9+jzZPtzpgWS5FYa6VUy5g+Xf?=
 =?us-ascii?Q?RBU4lPcSM+7Ima1bAY2PPodzYqJg3lIVM3jrp9Rcwh3qT6bPdrYTFap6zpc8?=
 =?us-ascii?Q?/io7cxHK8SmNuqHuJ78+kFbcoUVbTrFazg4Uk2G7mqIOe+k8C42yb6qsLzG3?=
 =?us-ascii?Q?UBug7rsJrybQJ3i0jKLCMXwuB12EJyhGEFTFi9z1ur9ni3EFLE0tv+NiX6rl?=
 =?us-ascii?Q?jHRz6jM4b6hddtleFWv8PXdHXEIR3wszFWRTGBwr+sGKX8nJ2PF6PMK+Xt6F?=
 =?us-ascii?Q?OcM4LbTsz5yS588K7tO0ouIM/tqpIpoXOiWQy/yZMOrB4frg+MJrG0ophFhC?=
 =?us-ascii?Q?vZQOU82/ngAFET81Bvozjs9XjZDOEFOaHeKIYsDcMsN+xDfXUopxWJUTW0fy?=
 =?us-ascii?Q?CIzW8xm21BXGAH1qWR/NRs3426vbYlESCDqlLAej1VmutmZRg8eyoFA1vuu+?=
 =?us-ascii?Q?sn/uMrAPjBYpIagRtp0bgnOpvyoJoY1/wh5bCiB+ZEf4CjQ6SB3aq9ZXnXW6?=
 =?us-ascii?Q?k19PSfGkVCnyXv+wbC6Ga8eW4moeANKtTvLZgah+gbcSjp1L7GatzCntBroK?=
 =?us-ascii?Q?8SUbvnU2WDoviBiPECdnR3h9cNg0meRTJK+pHc/+JuvG0COy7SPGEK7jr+OR?=
 =?us-ascii?Q?isFNy0wSKHisTWta8alztVVlYF6iH9AbyFqTe3O/G91+M5IN+VKes1lB++k9?=
 =?us-ascii?Q?dw/Gcq+6UWDIVNI2zmkcItUu1zHnYllzqV357bt9Cs7K65Xe6MBFGkMCgP2w?=
 =?us-ascii?Q?0s1R+KPgqy+alf/g7z5PagJPrNUW37dHmT1xndO8+hfD7lXxbGXhDL8sF4S9?=
 =?us-ascii?Q?4prMb1dS+DBDMSDvZQVt4ABNaoJJkCdqloy/uQyO3lmtIE0ZBoD8iWGHvl10?=
 =?us-ascii?Q?uW1aCtYNmwUITuBTTHTdsY2v/49mZtitOcGhSQNVINnyiurJB4pLzDZxp5hH?=
 =?us-ascii?Q?2NT6gagSlybUBroZxJ9Dk9LBSLDZP9Tqb6OFsFfbuwzgm0vzclFbYvYzUb9+?=
 =?us-ascii?Q?U2WhTmCPpT79w4aXBaIhZE4kQ8dTXvqeCXjluRHw6+sCaGWSS/55TYG0rBIL?=
 =?us-ascii?Q?Qdvm+VVBWUIdxe9yNB0Vv6CqWds/D0Ct55Znd3vmE43oGxOqPDOqieL+1o8N?=
 =?us-ascii?Q?E+PIEn52C145lIeNtcNqrBCXUgiSqc4J78JlWug+DB5XaZvwzW2TJNwI1Va5?=
 =?us-ascii?Q?bVaXwYANceZHI7Z/ULrS7p11juzfDA20UO2cM/P8IllH2Zf3DSCC0imXL93f?=
 =?us-ascii?Q?BWlg77UUojwzSNYvlxp4M/ZiM9dt?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(52116014)(366016)(376014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TCvxXeSuTOtG8AG0kGPUfO6btzM58bpB4T6s/HgJuMGjzJrHhJiVgB+/8Ee/?=
 =?us-ascii?Q?oheVHpZZsgojsH+u9QDg8mC9mvu7hTXIAb3DaXRyVeBmu8fJXX01NpDQkO1N?=
 =?us-ascii?Q?awZaIPQD9ARLDmc3YD5zxq2snSaduttWaf4bYW+ynctgJM75s6kU/HGVWEWb?=
 =?us-ascii?Q?HP408TdUydGMW8hYoEgZ9AfipxmjP0gI/E+PajI7J1spcgUVuDl1OHqpt+sm?=
 =?us-ascii?Q?y0iPpnnEcjkHG1bOMXHAvxFZNAtsXmOfIVCIN3s5nnkGDKEQlCWlHymVRDPI?=
 =?us-ascii?Q?TtxTCo+fMs3aE+OF4ceKRf6infJo7jy7zUmDszy8tzl/rIGBSuzNG2dyvSYE?=
 =?us-ascii?Q?UaTvPwHoZNb/F9CmTlV/v75tQNrvkZ03ZO1QJrdRp69PRPppDNLXGJgLvmty?=
 =?us-ascii?Q?izb7EQLMhXOmsrto4tgUd3rGyvR43Iv6lpVeG7BodFIP3h9gFQhpqiRyw9aw?=
 =?us-ascii?Q?WUNgqiPkqJeQ+SLHbyc+26OdcGxWYO7NEcnGi5bZ1+P6WqNs7E86fD+0fv+7?=
 =?us-ascii?Q?OCbjubMzUiWftvfxNlu6BQKXnH3tVuDz+rycqLz7OHLO8QD1dKpyv/w/EgGU?=
 =?us-ascii?Q?Galo3xHDvDDU/pjSlGalkVQpsZeF4E8Ufj6nTnF+lVpzNsA8tUMMHfBFL/Um?=
 =?us-ascii?Q?NaAL83v4PeV4r52QDeAJ85vcY0gswBa3VQvSAy0Cfx03BZW0mA59uwQeh1yH?=
 =?us-ascii?Q?M81dhV9ywfhfOikUHkww6wOqhZCVAejosAkLd17DNbjT2GyDIVATUyi1oMRy?=
 =?us-ascii?Q?j745mZkJaDLETHEwuDPpIeTK2gsuiaZgk4wKAjZuvhnABvGJfNaXkKBo4xQs?=
 =?us-ascii?Q?hHfbVoKuemILsdyO0B3flt1rLp5nUvHMozzNmCl32J6cCVf//jYWWWZwYLwC?=
 =?us-ascii?Q?NtEKZMyTGgikXM7AjVXj9GMetur8AR7KeEHTGl65vzNNztDllE7gzWZvSP14?=
 =?us-ascii?Q?SwjppAjCZa52eaZsZqltsP92kXHtDHhRHbUvIqFJhM4S7ctuqHbKB3Urnam+?=
 =?us-ascii?Q?X4N5Zu+j5tN8Lg5+k+pj3BtIf4D9kaU29gaP0MK71Se/Gz2ulEuRGvCPQbxa?=
 =?us-ascii?Q?aOdVo1Qxf45qu/mEtOoPxf0kahp+vSOEliCar4vTVyPfpxfKYXK61mtVF3mV?=
 =?us-ascii?Q?CUHF0TyjN4cETmwB8hLl6dlc3P9rn71wilqHxg3b1f25SFm0cU7tCcfzHIN3?=
 =?us-ascii?Q?BWFhByiywLv1c3lok1GJspE9Bw4Vjs9X/ni8GkuENQaTl5pdN6JYKXd32KnV?=
 =?us-ascii?Q?yn2nHatbhFNt0KYUxROsZDZg3kJuSitVNdTV4uqzTBBFXbp6tJYBVQcev1H1?=
 =?us-ascii?Q?9jx3OqruOEyUQc4pRpA8V/pb5mvDzPlfEfCV52E7RS9D5+sFxM4CZrhGcOvI?=
 =?us-ascii?Q?eS231e0LricutdDOLYYp62920/8F2ePSPDMfBzeuLrhUiWmffZroOz5DEq2W?=
 =?us-ascii?Q?64e/UwfmNG1he/METPMq89QjxABntpVEetBn39GPw4jFCA7OeMnLsvf3D+pP?=
 =?us-ascii?Q?PUvmWxmB/vIiG6gIzGBCP0AM5l5+j+NWhY6DbPrYmecrPgmFuSHVg2RswwLF?=
 =?us-ascii?Q?D6kCU7YEhfze6eBBccfHHznM5qpuwE6BwYfK9ETP?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bf83302-f817-4095-26a7-08dcb1655ecc
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 13:33:32.1319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zW3eL3xKwLuQTnTqwr87pLqbErpYxX+y+LcusrGjx45H1/WLb653Fd7N8pmxG1KIKXfMyiMn6JW90hji2+Q/SQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB7334

Define static inline bool __tlb_remove_page_size() to fix arch s390
config compilation Warning.

Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>
---

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202407311703.8q8sDQ2p-lkp@intel.com/
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202407311947.VPJNRqad-lkp@intel.com/

 arch/s390/include/asm/tlb.h | 8 ++++++++
 1 file changed, 8 insertions(+)

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
-- 
2.39.0


