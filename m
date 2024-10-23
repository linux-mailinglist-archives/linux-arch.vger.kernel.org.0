Return-Path: <linux-arch+bounces-8466-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A35959AD046
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2024 18:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59E47284EE1
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2024 16:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145491CEE82;
	Wed, 23 Oct 2024 16:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="l3WCRLf9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="frhKhE+Z"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDB21CEAA6;
	Wed, 23 Oct 2024 16:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729700728; cv=fail; b=UKq8h60eBBQNVh1dIdwmRPFBTDIXDoXC6p5UKads1wgH61MRIaPIlQA7LA4OTK/nQruqx8wwef+nshRYDjFjkmHP2QrB/VoXnxhy1xQzIn0xMs48Fsy3MZwi4FZvKBjUwUYDKdov/Yeq53uMFH2kOdWXa3v24i0Jl7yPrrbvIWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729700728; c=relaxed/simple;
	bh=V7H+r16XRUCD5QoohI9L8oGT4a8rSW4UYzJpH40W+iM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=WJAlCF6aEL8QiA2BtU2iOTXGuq/DYBBPyo/wRqqRrraY8ziF4+nqnwVFnTvrBNcmxOH9FuGzozUMbOIUfO5TSZvlY54GzdVxpBx/Jq9x0M1Crl4JZaQdcCsWnzT/eIpAwz/PSenW/asACkFBjW4CeZOhliMFu1x60qvMA46Haa4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=l3WCRLf9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=frhKhE+Z; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49NFfexa001648;
	Wed, 23 Oct 2024 16:24:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=YIaSkUfezHF43aJ8
	9agPvSR9qTUn5gfna/f60qXuHk0=; b=l3WCRLf9oxSgFp7BDmGpScb4xpww1KWS
	hp8p5oipfZPX1wKT+x2hXTYyhxGLpms0nEu6mcGnNDJcWYISzkFC4u8bIEMxJ7s/
	PZ+6QUIC6/LSxDnl9Y5988LpQ75Y0ZULtAupMSlqbQf35gkJ9x0sHdCetIzIzPwV
	lVqw4puxn1ZzUHNFFK/QLqtAmdOlWq7VWNUA6I3Mw3nhN2PHs3wzg1QjBR06wG1c
	R9JwM9gWgHWG9IgLrMBySri9J5RFl/rFXDvgygkorGEn7vkdCYlC4ZLqMxHxCxke
	b4qBW/mUsvMlMDsbSqXX+uokEZLSY7UMWNQVap1XhM5NAHUQk9dXqA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c57qgkr4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 16:24:54 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49NGDJOC018405;
	Wed, 23 Oct 2024 16:24:54 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42emhjs6v9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 16:24:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MsP5+WL5H4J/sWVF7M+W/62X7SUbcpb5MuGWDQEtp7dfrbpCDdgXIo994ZWMXDtIDLmF2dqFdQAVA1Cz/E1B5rQMgJSz5iMCmwWndl7QNyZwxmTHsiRmsjdpRuWnAtQLm2wuCgjsr2f1X23/cih3tRgduLQJ63pk75pG5WjT1ZQCOHrGOziMAO4SpxfqTwn6cjPuREQglajCl2KZrxtF39jbupo9jAnZb2uL6Yvgxxq/WR3vlZX6UELrOP7yJk1xE2ayiQHCJstkxNgqOXqt89uj+phS7KWnB1HACGtThkggpafkJH3JrAr/cfprUuObfgpJAl9AFLuQVngIsJTx/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YIaSkUfezHF43aJ89agPvSR9qTUn5gfna/f60qXuHk0=;
 b=ArJ7Ib21CrPu3B5H/EZflv/TvVQbZxuZ51vKou9dWsMrLTvCZhqODVEwGCvc1ZuIxdPgUmEGeeWzXIXIwNRMF9c8ewdi3FzwRBDakm1+7n9630i3S74gHRU2zhraekuYFRmDOsiU9bbJi7JKgwS/3+FaXnqPsWnuaLuFhOn2vp27P/qwLZ+uynLviy3x5YCKdb5APsVIfY3I3fNoNABKDwA6yoMDKIHqPEBvOwg/OfUMQhtjRy0WeFLUxAuo3sVyqwFIiMk+xu/r8p5fMHf16aJf7E33/2MrLLTDVd2CWWo6EXB941wIg1OTbMUr/RDBuEkV02QFCPGPWBssHN3hHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YIaSkUfezHF43aJ89agPvSR9qTUn5gfna/f60qXuHk0=;
 b=frhKhE+Z3UPOSp6GWc1Axw/6KTghS75sORJyU/w7ESY0SzQaMoH8c7psCAFdVqvAWA7BBuvMRIVfp3M7wm2Okmkv+MNkJpX8FytBYeGZtoPmGsx4RpfwMc46dYc7EIpcEMP2ZBRRGXkOhQKUnlI/OH0MlPY07Hr7gPN5jQUBOBc=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Wed, 23 Oct
 2024 16:24:51 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8069.024; Wed, 23 Oct 2024
 16:24:50 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        "Paul E . McKenney" <paulmck@kernel.org>, Jann Horn <jannh@google.com>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Muchun Song <muchun.song@linux.dev>,
        Richard Henderson <richard.henderson@linaro.org>,
        Matt Turner <mattst88@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>, Arnd Bergmann <arnd@kernel.org>,
        linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-arch@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>,
        linux-kselftest@vger.kernel.org,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Jeff Xu <jeffxu@chromium.org>, Christoph Hellwig <hch@infradead.org>,
        linux-api@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v3 0/5] implement lightweight guard pages
Date: Wed, 23 Oct 2024 17:24:37 +0100
Message-ID: <cover.1729699916.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0019.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:62::31) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|MN2PR10MB4320:EE_
X-MS-Office365-Filtering-Correlation-Id: a55a89e1-d097-4825-a5bb-08dcf37f35e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?k76CuCBAKdz2KU0J216SG7zVb28L1I830iRV4F4/iQV+KjVSsj3Y0kbcZKC3?=
 =?us-ascii?Q?dzDcSxg5ZvwSx+EazYftX3tFfqNiWeM3ksDztLKEpLE3SYLdgLKBcaouG2ZC?=
 =?us-ascii?Q?hfZSchnQUPpci86D9wmhAnTCpzQ4W63oOBG0/mwOX0hTFVnJW41oba8su9eW?=
 =?us-ascii?Q?UtnFtL/XZUepp47779PuHL3Bs4mz6Q2DCwWehxqIBwzTM1ir6cMfxROBlCiE?=
 =?us-ascii?Q?zdCjiAbqSGwW9OYgCCxnjI5Hib+qjHmSC4A2t17etYsidaBsGtsO/Eqafyz2?=
 =?us-ascii?Q?32kT2ntl/ptK2ICtMUrmCPi1sM0VHhMgvsCEWJXoL/TOyXQzWcnvHay+JoXa?=
 =?us-ascii?Q?mCugEXwN3Dz/4AkQDcoMZlrkkqa/jSSNZoSUL/rHP8+p59kePN8QfUKrGXFN?=
 =?us-ascii?Q?BG+T1PcNekz2WccNWGDEq/3r4/9YtKCi24ML7dyvUAcjeWrL8UNTxhmT79BR?=
 =?us-ascii?Q?alQVGf+CR78oSJMfG4faMp39Vkyr1QHnlPzHnebT0OxhBjyawIhwkmG+YlVt?=
 =?us-ascii?Q?N9pmfmdZdh+yBFshJk/suyz7s+4xOku2RbD1PDqdqay1LkJ8Nbg0gLXVHcSL?=
 =?us-ascii?Q?DPF0WwE+PgcyDPz99nqec4eeKGOozpp3x+6j8TyxrK81YI1Wh9ZCLg5AW8/b?=
 =?us-ascii?Q?Re3xF25cv2hyIPVN+QRacAFSiaZ/Z9o/53JCJ+sg6kUBgjjOUzQJAo1PNYWO?=
 =?us-ascii?Q?Mm1iqlrifzl0CQAFndioA4zQI7Ye1QLsKma41JBFJyD50+b3OpwHDYqxKZbJ?=
 =?us-ascii?Q?fHLN9f0rlhHL9pCFn7UbF/7q/fU7oRm2sbv+8NRuLVdRnHdzQ4pkwempDM7d?=
 =?us-ascii?Q?GXqX6sEmKU6GxSLsN+gvt4w1CNW1khYfTlbWLOTAHbYclTUDjIqanhAHattP?=
 =?us-ascii?Q?EoXF5Xi5FPIFHGqilkaCjqkgfE842MHggQDDGhgM7EdrKBIbjPFi2CUE9k7n?=
 =?us-ascii?Q?CEZZseR1cXlSoAUfrejHWgiLrgwoNIs3P/B3USi4vPGgFXvung4O5yrZmNtA?=
 =?us-ascii?Q?xT8NKQqzkA3BVBPHDUUrq2fq9qQ0Z/DWWSsIpYNdNEjH7+8OqVN05YpOHzF3?=
 =?us-ascii?Q?4QzODLtLDNGGdEJ+uKBL15BWztl8kUMBWaIZ4PQSHi1Qvo6LLKN7cgcCIW9x?=
 =?us-ascii?Q?I8zObm8iRwaQ1w3IMHMHYk1zXQsWNkNNZBQ+xMakUJexXLxLpzD8KQzYTJYY?=
 =?us-ascii?Q?S7kcjsvQExHfkBPks1rU7gFb7ctmWGNiumMEgf8R5wRQK8c73XmYV4yOaD6p?=
 =?us-ascii?Q?+LfFVvpEkhj2rKLbkrAck8LV8tvxLa/9G1szkHEGnXfPWdBQfLSy4r6EvNrU?=
 =?us-ascii?Q?9WL9WVtrMCKJFXO8mptaH8dN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?s5OsK3DIT5Z5e0r4Cf83Jb3PlskuxCSl5kMn6pWO8yWgSS5fXOfqt9e6k+qw?=
 =?us-ascii?Q?a0f+p6dENvNEuE11gNVbzCEpCAx0997GV1Qz3Zsa6/h/b/7oAk5oMoYPdOzv?=
 =?us-ascii?Q?xdy+6mFdpz/0R2mv9nTD8fMF57aJjdERf/ISKIYfV6VjK/ED6tIwvYeLJcCu?=
 =?us-ascii?Q?rW5QjfVMp2TgeCZ+gVbHxCsm9b98b78J97HXaRZkOq++2BnCnpFO/WbYx5Gx?=
 =?us-ascii?Q?/voEkqNro9I2XLcS19Pe0Rb3Jk+4gMoVzOWkhPADK2HihddyqasC1uCDrbSU?=
 =?us-ascii?Q?VCrf0lW0JmU6Pnks4ocXJgPutyVAEH+5JHkPA9xIbgl2tneeJWBInAGJG2Zh?=
 =?us-ascii?Q?xt7D0QrK6nI4iNJAEvkm/tp2GwAh8r+tj2uviIe6QgmQOJQErkqTxnRLKThN?=
 =?us-ascii?Q?1ca2FiIGmGvoEO+/aFD2qW0srm9KEvOos3hsUOicYZoguJ2RqjDymkUisZW1?=
 =?us-ascii?Q?tIacdQfrRaucrKY4pPiZKOW0q6Dm3/zri3eZ4XTfbb9Kj5svpT9jS+3QPtkY?=
 =?us-ascii?Q?sHuLTBRNkArx9w0aaaFvLcP9pZ79AOkt/6WJThSIL4CcaqSb6SrIz4G2e4ZE?=
 =?us-ascii?Q?WWcyBPHQ+s7vAuQeSOs8YTosjgVS2xjDHTqsGOrkDPrcziE04gw8REfpq7Db?=
 =?us-ascii?Q?EjfKhlfiEmrTsNvtNIWKycnzreIaLe4ZpMiG78Be6H7XtlxfLwE/DH6cCSbO?=
 =?us-ascii?Q?Uw6Qf2S4ahvxuE9JPlIk1kK+wunLFIe1uup+mPUap6guEaHW0Ar905GtO+zX?=
 =?us-ascii?Q?jTLDyKZDiXPq/BZh0Nu3PmjaJqInAanhSBCkv0EAo81W65xCPnxEs1QTIDnP?=
 =?us-ascii?Q?B9iC/jFk1V1oQA1qq+oYXBvWMQsIN/OopNzOU+i/HQ1piLmR/l2jE51CFrOR?=
 =?us-ascii?Q?MMRNe2bVzLCHQlBs34+MBXfRitqIzT+h/z2g39Iq2ZElfyULxECFs20KkB74?=
 =?us-ascii?Q?PSrmemcE7++ZhVtN2chEsWNwCd9T/8MFWUru97hpEwDmLUim6/go7gmO31YX?=
 =?us-ascii?Q?BQ8ewIPhyzRKELvW27KAtH3nRS14oH1orS7Wy5VEAHzAMnNBrW4SKLj2O03N?=
 =?us-ascii?Q?b2x8LnFhI6HMcE2EEf6vMX0BDMxaQvTee/ykzItJ/mmeIYQFz9ZI7b2VdjTL?=
 =?us-ascii?Q?xlJvMnz+VYz/EIwPPVHnwGTkudOOCIKzKF9bZnfRYIAtPcbyhua4HIzBFV9X?=
 =?us-ascii?Q?Zn+Fyg1W8Wpb2tVCfeTdI4k8208HO6otVDYoZZO3G3eKY6oVeqOMUR9ZBBMK?=
 =?us-ascii?Q?T1dZxltpHxWyqupJctXhwhSaKhwoWYg5ZEQzk82vTutDXS3xh9l/tcy+KL2n?=
 =?us-ascii?Q?oLQ4jWAg7EWIdD7kbxIlOudh34vfsKPtU7zqdBM5AK6g4RyRxuPbMI6npoAu?=
 =?us-ascii?Q?rXzNE9kStl4/NaKv7/JQLxbU0ptb1DXG5N5uxnTb41Kfjf6/Wo6S4i6MYtTt?=
 =?us-ascii?Q?EKJYh8G3ddvyym8uB4vG7yCWaVAFrqcuenwZmgnX56vHLuDxPUD+iY/ztoF2?=
 =?us-ascii?Q?2DyV3ditNhaEueCLIhgpsGtzZhQJsOQ6poNG17e51icQ7WpBUT5vBnzvgkwq?=
 =?us-ascii?Q?xrAgz3SFc/sRYBWZRwmBWCZkXv8CosTAvQWO80JHHcbrs4LlttNQfXDftqRs?=
 =?us-ascii?Q?flI+TTW97jFfwPkNQDtH88s/fq5stZ0ZXGOvOGoIeYzLBzqYtE1TSDSXdwlf?=
 =?us-ascii?Q?bxzurw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qw81qFO4D9qow7prB4+wNLLbwnapz+s9TDdJUHlEe1boiVBvVLWjMdXO1newNITtQhCFWQSQyp3N+B8eNVGEb/XOKZXHy2mgFBF1Clzg2cumL7x6xLghv7JYyBW9sNpcMFuf73dZRIBRwxCNfekXFH4yqd7QDDncNe1a3KWfsjEApGB4tcgBj8Dp7TllhFwlkVo/QoKrTo9O04XA0Ai8B/gcmmHrusP16WbxEQc1fYmhSqibgWB4TcAk7PYnqvVROqyVpcouftUqDv43mOihkmhWlb5eNEcG/ZSPPuq3jWkuCB56R74844XtfFWrhE5lHlh8BeWqbivBs4/grulTGYT2u52SMoKOac8FN9xojCuAprXOs/BpP0G5SyDYWzSBEvnS3u10Bba5cjg8k7t445i/jk8/oKw98BnnGYEODI9/aeJhkYFDwKD4QWgfb4EvdIb/+HOk807xLL4OtXRT7nUj1bEH7xe9PTbe1cTYfQc69chw2iVOpsdxT2MKYsiefUDynn27iGHJlKBcMrOhsqU8KeeEXPYlIfHN+SwpdS6EBWaMYmnU2bFy6UFR0GQ0zwFmbxBo21uxqS5LKMNXbET2GvVQMeO4T+VEHW8BxRU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a55a89e1-d097-4825-a5bb-08dcf37f35e2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 16:24:50.8740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ySgkCgvYSXvccX6Htpw7qYpquYSIOdlIzlEELLbWvZjS39Xgcxr8MG0TeWtk1BnGg5smsO84QarksCa95UoqbB3M0ZbST3Ygieifll5yKtQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4320
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-23_13,2024-10-23_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410230095
X-Proofpoint-ORIG-GUID: aUfmOqLDCU4lQJMW5_VDKlQyGvaaFwqN
X-Proofpoint-GUID: aUfmOqLDCU4lQJMW5_VDKlQyGvaaFwqN

Userland library functions such as allocators and threading implementations
often require regions of memory to act as 'guard pages' - mappings which,
when accessed, result in a fatal signal being sent to the accessing
process.

The current means by which these are implemented is via a PROT_NONE mmap()
mapping, which provides the required semantics however incur an overhead of
a VMA for each such region.

With a great many processes and threads, this can rapidly add up and incur
a significant memory penalty. It also has the added problem of preventing
merges that might otherwise be permitted.

This series takes a different approach - an idea suggested by Vlasimil
Babka (and before him David Hildenbrand and Jann Horn - perhaps more - the
provenance becomes a little tricky to ascertain after this - please forgive
any omissions!)  - rather than locating the guard pages at the VMA layer,
instead placing them in page tables mapping the required ranges.

Early testing of the prototype version of this code suggests a 5 times
speed up in memory mapping invocations (in conjunction with use of
process_madvise()) and a 13% reduction in VMAs on an entirely idle android
system and unoptimised code.

We expect with optimisation and a loaded system with a larger number of
guard pages this could significantly increase, but in any case these
numbers are encouraging.

This way, rather than having separate VMAs specifying which parts of a
range are guard pages, instead we have a VMA spanning the entire range of
memory a user is permitted to access and including ranges which are to be
'guarded'.

After mapping this, a user can specify which parts of the range should
result in a fatal signal when accessed.

By restricting the ability to specify guard pages to memory mapped by
existing VMAs, we can rely on the mappings being torn down when the
mappings are ultimately unmapped and everything works simply as if the
memory were not faulted in, from the point of view of the containing VMAs.

This mechanism in effect poisons memory ranges similar to hardware memory
poisoning, only it is an entirely software-controlled form of poisoning.

The mechanism is implemented via madvise() behaviour - MADV_GUARD_INSTALL
which installs page table-level guard page markers - and
MADV_GUARD_REMOVE - which clears them.

Guard markers can be installed across multiple VMAs and any existing
mappings will be cleared, that is zapped, before installing the guard page
markers in the page tables.

There is no concept of 'nested' guard markers, multiple attempts to install
guard markers in a range will, after the first attempt, have no effect.

Importantly, removing guard markers over a range that contains both guard
markers and ordinary backed memory has no effect on anything but the guard
markers (including leaving huge pages un-split), so a user can safely
remove guard markers over a range of memory leaving the rest intact.

The actual mechanism by which the page table entries are specified makes
use of existing logic - PTE markers, which are used for the userfaultfd
UFFDIO_POISON mechanism.

Unfortunately PTE_MARKER_POISONED is not suited for the guard page
mechanism as it results in VM_FAULT_HWPOISON semantics in the fault
handler, so we add our own specific PTE_MARKER_GUARD and adapt existing
logic to handle it.

We also extend the generic page walk mechanism to allow for installation of
PTEs (carefully restricted to memory management logic only to prevent
unwanted abuse).

We ensure that zapping performed by MADV_DONTNEED and MADV_FREE do not
remove guard markers, nor does forking (except when VM_WIPEONFORK is
specified for a VMA which implies a total removal of memory
characteristics).

It's important to note that the guard page implementation is emphatically
NOT a security feature, so a user can remove the markers if they wish. We
simply implement it in such a way as to provide the least surprising
behaviour.

An extensive set of self-tests are provided which ensure behaviour is as
expected and additionally self-documents expected behaviour of guard
ranges.

Suggested-by: Vlastimil Babka <vbabka@suse.cz>
Suggested-by: Jann Horn <jannh@google.com>
Suggested-by: David Hildenbrand <david@redhat.com>

v3
* Cleaned up mm/pagewalk.c logic a bit to make things clearer, as suggested
  by Vlastiml.
* Explicitly avoid splitting THP on PTE installation, as suggested by
  Vlastimil. Note this has no impact on the guard pages logic, which has
  page table entry handlers at PUD, PMD and PTE level.
* Added WARN_ON_ONCE() to mm/hugetlb.c path where we don't expect a guard
  marker, as suggested by Vlastimil.
* Reverted change to is_poisoned_swp_entry() to exclude guard pages which
  has the effect of MADV_FREE _not_ clearing guard pages. After discussion
  with Vlastimil, it became apparent that the ability to 'cancel' the
  freeing operation by writing to the mapping after having issued an
  MADV_FREE would mean that we would risk unexpected behaviour should the
  guard pages be removed, so we now do not remove markers here at all.
* Added comment to PTE_MARKER_GUARD to highlight that memory tagged with
  the marker behaves as if it were a region mapped PROT_NONE, as
  highlighted by David.
* Rename poison -> install, unpoison -> remove (i.e. MADV_GUARD_INSTALL /
  MADV_GUARD_REMOVE over MADV_GUARD_POISON / MADV_GUARD_REMOVE) at the
  request of David and John who both find the poison analogy
  confusing/overloaded.
* After a lot of discussion, replace the looping behaviour should page
  faults race with guard page installation with a modest reattempt followed
  by returning -ERESTARTNOINTR to have the operation abort and re-enter,
  relieving lock contention and avoiding the possibility of allowing a
  malicious sandboxed process to impact the mmap lock or stall the overall
  process more than necessary, as suggested by Jann and Vlastimil having
  raised the issue.
* Adjusted the page table walker so a populated huge PUD or PMD is
  correctly treated as being populated, necessitating a zap. In v2 we
  incorrectly skipped over these, which would cause the logic to wrongly
  proceed as if nothing were populated and the install succeeded.
  Instead, explicitly check to see if a huge page - if so, do not split but
  rather abort the operation and let zap take care of things.
* Updated the guard remove logic to not unnecessarily split huge pages
  either.
* Added a debug check to assert that the number of installed PTEs matches
  expectation, accounting for any existing guard pages.
* Adapted vector_madvise() used by the process_madvise() system call to
  handle -ERESTARTNOINTR correctly.

v2
* The macros in kselftest_harness.h seem to be broken - __EXPECT() is
  terminated by '} while (0); OPTIONAL_HANDLER(_assert)' meaning it is not
  safe in single line if / else or for /which blocks, however working
  around this results in checkpatch producing invalid warnings, as reported
  by Shuah.
* Fixing these macros is out of scope for this series, so compromise and
  instead rewrite test blocks so as to use multiple lines by separating out
  a decl in most cases. This has the side effect of, for the most part,
  making things more readable.
* Heavily document the use of the volatile keyword - we can't avoid
  checkpatch complaining about this, so we explain it, as reported by
  Shuah.
* Updated commit message to highlight that we skip tests we lack
  permissions for, as reported by Shuah.
* Replaced a perror() with ksft_exit_fail_perror(), as reported by Shuah.
* Added user friendly messages to cases where tests are skipped due to lack
  of permissions, as reported by Shuah.
* Update the tool header to include the new MADV_GUARD_POISON/UNPOISON
  defines and directly include asm-generic/mman.h to get the
  platform-neutral versions to ensure we import them.
* Finally fixed Vlastimil's email address in Suggested-by tags from suze to
  suse, as reported by Vlastimil.
* Added linux-api to cc list, as reported by Vlastimil.
https://lore.kernel.org/all/cover.1729440856.git.lorenzo.stoakes@oracle.com/

v1
* Un-RFC'd as appears no major objections to approach but rather debate on
  implementation.
* Fixed issue with arches which need mmu_context.h and
  tlbfush.h. header imports in pagewalker logic to be able to use
  update_mmu_cache() as reported by the kernel test bot.
* Added comments in page walker logic to clarify who can use
  ops->install_pte and why as well as adding a check_ops_valid() helper
  function, as suggested by Christoph.
* Pass false in full parameter in pte_clear_not_present_full() as suggested
  by Jann.
* Stopped erroneously requiring a write lock for the poison operation as
  suggested by Jann and Suren.
* Moved anon_vma_prepare() to the start of madvise_guard_poison() to be
  consistent with how this is used elsewhere in the kernel as suggested by
  Jann.
* Avoid returning -EAGAIN if we are raced on page faults, just keep looping
  and duck out if a fatal signal is pending or a conditional reschedule is
  needed, as suggested by Jann.
* Avoid needlessly splitting huge PUDs and PMDs by specifying
  ACTION_CONTINUE, as suggested by Jann.
https://lore.kernel.org/all/cover.1729196871.git.lorenzo.stoakes@oracle.com/

RFC
https://lore.kernel.org/all/cover.1727440966.git.lorenzo.stoakes@oracle.com/

Lorenzo Stoakes (5):
  mm: pagewalk: add the ability to install PTEs
  mm: add PTE_MARKER_GUARD PTE marker
  mm: madvise: implement lightweight guard page mechanism
  tools: testing: update tools UAPI header for mman-common.h
  selftests/mm: add self tests for guard page feature

 arch/alpha/include/uapi/asm/mman.h           |    3 +
 arch/mips/include/uapi/asm/mman.h            |    3 +
 arch/parisc/include/uapi/asm/mman.h          |    3 +
 arch/xtensa/include/uapi/asm/mman.h          |    3 +
 include/linux/mm_inline.h                    |    2 +-
 include/linux/pagewalk.h                     |   18 +-
 include/linux/swapops.h                      |   24 +-
 include/uapi/asm-generic/mman-common.h       |    3 +
 mm/hugetlb.c                                 |    4 +
 mm/internal.h                                |   12 +
 mm/madvise.c                                 |  225 ++++
 mm/memory.c                                  |   18 +-
 mm/mprotect.c                                |    6 +-
 mm/mseal.c                                   |    1 +
 mm/pagewalk.c                                |  227 +++-
 tools/include/uapi/asm-generic/mman-common.h |    3 +
 tools/testing/selftests/mm/.gitignore        |    1 +
 tools/testing/selftests/mm/Makefile          |    1 +
 tools/testing/selftests/mm/guard-pages.c     | 1239 ++++++++++++++++++
 19 files changed, 1720 insertions(+), 76 deletions(-)
 create mode 100644 tools/testing/selftests/mm/guard-pages.c

--
2.47.0

