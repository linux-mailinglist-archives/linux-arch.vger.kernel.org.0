Return-Path: <linux-arch+bounces-8304-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E58519A5525
	for <lists+linux-arch@lfdr.de>; Sun, 20 Oct 2024 18:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3957DB22724
	for <lists+linux-arch@lfdr.de>; Sun, 20 Oct 2024 16:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 850C41953B9;
	Sun, 20 Oct 2024 16:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DqtvXDzy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YAsb/lpQ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A63194AD5;
	Sun, 20 Oct 2024 16:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729441275; cv=fail; b=KHldr/YL42X4LNYTBAulnWI/IkVgp7R8xXzyPFZBEB/QjqP2yCrjjLP/ayfaDsqcSAj00hxhA5bCwWRIfr10wNuPBM1Ow2uLpkZvwx5s2Su9eD+jcIuvaXXa53UWeg6TA4NeGrvjF9X2gYlQ8WBVs+w2GatGl2AaQ1NtA3FondA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729441275; c=relaxed/simple;
	bh=imwnoMZ5P2Wy2dxWIQWvxWeGPLqzt7jcTPr4NJQozaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lI8T9m+2GTOwMFKHV4+C+g9cIotoS19MN6o3LbE0arcghXTqTiER0VD5Cok9afgYKGiqJI+GLseYSytHJVNlRtdAUSDsdbdbH5wm5hLCno418dwHKXuJWgLToxxIzUdu+cri9wB8+VFere8NWzWzBcwYZMLnYmOYWVbkUTrYZIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DqtvXDzy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YAsb/lpQ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49KDC9IH011703;
	Sun, 20 Oct 2024 16:20:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Vd2Vp6szhFvYTVsLkfnXlXF7Mkv+sqGaCcSK4gFh5M0=; b=
	DqtvXDzyMJdNvzJ4/b3t1NxBm4DvIcwh/RoDYAIoaT+46dhVBg+FN1JjkGp5IxJw
	q6sp3+h+4cqfkKFmyV4V1PIMPL25TdJh0gmOM4qq0CNTrsGJ4lFWuhm7jewiEnNG
	wio4cMxabRrvdxjpqeS6OwV54dAL8xtbmk7mDpGrVFhVk6NrKEjQ8+9WozJZGIO8
	jU8m7uupHBpE/27Kl3agE78ZkQ9jUQ6mHS36GxmfMAQOMQRGsyIMyOW4cWxRRXLm
	mXTBP1fTQMtPvMii1q4Ixx9gf5rEvYckzEIE3Ut0xlfckdod86Vbp6NrQMBX/vtK
	XuUBDOTb8Nf6Rrx1yBBriQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42ckkqs3hx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 20 Oct 2024 16:20:22 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49KCurTG008250;
	Sun, 20 Oct 2024 16:20:21 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2049.outbound.protection.outlook.com [104.47.51.49])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42c375gqxp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 20 Oct 2024 16:20:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mYoLplVzSpO1o10TNFaxPXS+D8m1zRgxemO+lvE5JPqirTIPVdoH4wyZ5QIZaDuGwOan00PhhDFGZxlcjWeWIEl3PymCNxZH1p/FsJxPdUuTrX+cyTC2TAW6pouCNgr6sqPH8NOZZQM1KyFwD8cfhuebx+/6GecwWVomY2P+Etu0lJaYOCWupYDD6zI6x1b5Z/WEIn4fIXR8du/1xziWvScn37QnCvPGtqUMDiXvmDSR7CqdD6NPwQa4xPKfvOTmy2RiPAnwg74WLTMvqqUcKmzeciFDcKxupGV5FfYfhnfcgLGe2ELHTqyonpSrhhL2isIX/THGZrJI+WhK6D6wIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vd2Vp6szhFvYTVsLkfnXlXF7Mkv+sqGaCcSK4gFh5M0=;
 b=a4W3fatYAQQlRNnxJsAL2ou8HEGJXtDYJY1vjbaBnOazcfldDR4kVjrEtIBk93alyvKgJiL2cKbyJE4mIna+2Ap6wy3gNShs7qxrj+S07DtfX6daNwZw5k93kKcMAtTmNr6vrB7nVZa16u9XExiDTwMarzbCrOOm8p4FhfkjJlO7HeiQcBn9s+MnOqFZkyG6mVHsB1acA6DyKBDNkF4UFmWHWZ3Zgc7zuKTWihMtIuF/uY9/O4QRKYDTHgT4wqmKHcFyu9hdqTSr1gdpjBnWiI2CyZbJnhIaYeTmTRJyWhtfp3SDunnXhQMthSwq6vj7lYmVHoy9WKMjnPNTLhjA1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vd2Vp6szhFvYTVsLkfnXlXF7Mkv+sqGaCcSK4gFh5M0=;
 b=YAsb/lpQN/ahO/phof+4aullfY+YQgXQPO6xj90GNLqkRehvUsmjdXM1HsNjASYl7nHlzL7ikxJ/S1mzayBzQu/WhxLIXwr+Zxwo+MD4if8gCvGhL1WOneELYK43g+Kk0/gAVd3bxhQhccxbdUBOlgAeR57aAqb2ErudUVSdAFI=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by DS0PR10MB6703.namprd10.prod.outlook.com (2603:10b6:8:139::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.27; Sun, 20 Oct
 2024 16:20:17 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8069.024; Sun, 20 Oct 2024
 16:20:17 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        "Paul E . McKenney" <paulmck@kernel.org>, Jann Horn <jannh@google.com>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Muchun Song <muchun.song@linux.dev>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-arch@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>,
        linux-kselftest@vger.kernel.org,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Jeff Xu <jeffxu@chromium.org>, Christoph Hellwig <hch@infradead.org>,
        linux-api@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v2 1/5] mm: pagewalk: add the ability to install PTEs
Date: Sun, 20 Oct 2024 17:20:01 +0100
Message-ID: <cf91e3936c2dee42aa8ac15af3e76c90c098d570.1729440856.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1729440856.git.lorenzo.stoakes@oracle.com>
References: <cover.1729440856.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P302CA0015.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c2::11) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|DS0PR10MB6703:EE_
X-MS-Office365-Filtering-Correlation-Id: 14c616a0-58cb-4ceb-14c6-08dcf12315b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MOmAdZP7Y8NQ/oELA0qq6nwlDUCJKJQfCYqsDS7dPorHa9ZeNkxD6hhXMpe9?=
 =?us-ascii?Q?PJhtP5V6bRBRu9fpLzuzo1Ceh3wSCZxqST2XT/0qJBjaRPBQjz85wRDdwj14?=
 =?us-ascii?Q?V+mMwCx+hqIC948SmMqLQxepZbm1RP2Fqwg45jObYK9TmsoEBEhvindqQ6sP?=
 =?us-ascii?Q?GWugCfGi6O7puIKr4qu7R++D8U2NVMH3kXYryW+e0Ru+3qzBgYM3sUa4j8wu?=
 =?us-ascii?Q?HGu1dzAHyRvr4k/V9zYHJxEMu/1GxA3GZfyYNgNmphGfG2dVzho7C6v5qdgV?=
 =?us-ascii?Q?6aYDqz6SnbchK5Bcx+0BLWPAGGe5t1FHJoGN+Tb1hLnej75Zaux69etdCCYt?=
 =?us-ascii?Q?75kzLS1kuuoWyPY3bgpfsugvE19BGD/IM7RTbjYMcLSsbGcpK/FStQkWF4jG?=
 =?us-ascii?Q?5H/h9+XL8zcitqSmmH/MghGM775rK+Cy3uI2Qu2iTXUQoSisOJRKq+KIhuJ7?=
 =?us-ascii?Q?33P9Gci21Xw9fNrIIcYkHU05BIZsuBPWXtNymkDWGUP03oEgZir2tYlrSliO?=
 =?us-ascii?Q?0D7qRPD2asTu3EJLSnNpS4d6bAoJwT28FRElMpf/1Hvj4LVxq1fxB/tiG6MY?=
 =?us-ascii?Q?L3/lbQinAwwUsqxZIi2ehzmPyGMLcgkeqqfHiSkBvViutVpwME3FF8tsOFDD?=
 =?us-ascii?Q?UPT7I9KtB/YH2aCKrrTNVJmUl0z5ZzXKDhGgYs3z3luObGhb5mwfisgjuFsp?=
 =?us-ascii?Q?vxNp+iJegPA/9TY556GCLDmIcZe+QPhwRiiw16m3RinOG1HZW5oReMXI1dFA?=
 =?us-ascii?Q?sSrJaXScoU7ZhQ0oK5y5k9r18KEMKNeRTfdff/74CI3UZOqLXOhb0ErG9bgy?=
 =?us-ascii?Q?qXZlQL+LsvqF6ycwN5uayr8CWylB75vy9DfMqCQiP13yR44l1VxdiToYSTpq?=
 =?us-ascii?Q?y2QxH0+cKrZVK6IV2LG7xyrAxhdxdFSsacRD+RPacTn789knTFGHid3MEEO/?=
 =?us-ascii?Q?oB4FcQuKITp2ziSty4ghKOiIfKhw5cEmRoMuZzFPxImAi1wlW96r+NhXZdZQ?=
 =?us-ascii?Q?0yA07Hn6R1mJA9/lT7OvrZZQujSBwdKxQIULtQ6UuvX4syMtFRWLrfJwkrh9?=
 =?us-ascii?Q?ZYuQ9kFC3i8mhSUv7ve0nt0zliaD0wqfqKQ3MvnA4jagDGOFgF3ORZv6yRdZ?=
 =?us-ascii?Q?nZ/jGy9twdoIdZDrcm1yTY1YTr8sXi8I5ZGMxUH64zji8Ptmo9SOWaquWukF?=
 =?us-ascii?Q?imDQ84IKaEQyi1ggSPhg4DlgTbq/lh+dp8pswFWPKQBk6BLBj+U498kdAAJh?=
 =?us-ascii?Q?0mOPfzptDER0U1sF1xIxUF/FG9mCIc7PXOwyzisPfKuBLGlRfdSYOPGPefzv?=
 =?us-ascii?Q?kNhqVaEQA4a4Iyhm+Qy1DXmy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nebTmjShqgiYO/+uWbrynKS6nR5LQiqSLHJAwMGJ9cNzSri6w2rFImEKnD9Y?=
 =?us-ascii?Q?0upS6KQtnYokErpCtwfT/rum5cjV1+mTK76ZI5Q1tixFSpgK6PX3I7cg/xpK?=
 =?us-ascii?Q?Vxiy+XrVaQrkZ9UJa+BW+vO8xmNbsoxLGJLcPE/chdif2on3pimkDe9EwYEy?=
 =?us-ascii?Q?RxbFLyiJ7UGFpzGAlMp0i7zw/FGAuOV13o2jE6nRcVN2lcgXFxAruTtZhmxg?=
 =?us-ascii?Q?/JtO8BasPfJRDmoexcS0zAk1sCv/UliwpS8C6ITYDmf7FR5zveUudR3WxVGb?=
 =?us-ascii?Q?t3vfofwaxj17kXVgD+pCUojCQ9lW5naxHEUgZh6CzTRfYNT2+bEI+an/TRDH?=
 =?us-ascii?Q?GIQzL+zJ7r3dWMSEbBid2718crBVAdp7Yr346uAvJISl6YU+mLQXhI6x/Ma4?=
 =?us-ascii?Q?9cq7ymBISIPRPhLK4wG8+KpFywzInn2XO6mlX3mNGWMRphTgtdzssNHTW1uK?=
 =?us-ascii?Q?9vmSDJ7MidlVC8dRCWnlUQYYekq9K42tAKfSM9FQS65C+IskNIHMAIVie7YI?=
 =?us-ascii?Q?2DKBfCeeMGSgCXaP2h4Btnu6gWRfrLm8TJFW4AHo8amODTfcgC4wADpq+Nos?=
 =?us-ascii?Q?FoTloTySXSuE390vSn2ZRDhsux6cg4/TfGIq7o4sqKcnfOvyT4FdjRmidRsu?=
 =?us-ascii?Q?b8fQd4nSilxQSaRhn08fSu5sHZiH93Juhgn+wLfC6fVV/iA/B3DRKdDDfIMl?=
 =?us-ascii?Q?eO1nBoORhA0yE6I3oa8MP547aZcp2vu7tgheuBUdCPxXrZE29Ls20l8bumSx?=
 =?us-ascii?Q?n6jk/97vYbDKRFzX8Ao0x8Z+ioi0VRo0ajI7bBjtfyNcy6HqtDq/7MdRAhx8?=
 =?us-ascii?Q?0wUR4rGRXG6QhfdHCKEUmmOnWJxbX2DFGwU2e1ji9uiePeelxt3PZsQuEaHr?=
 =?us-ascii?Q?Gs7UtyfxVKoPvWp5wZ48PK5kWiLB9dhhIzBnfaaAZrW9j9UBr5tIuUGjPom6?=
 =?us-ascii?Q?G+Zdwv2xmKoW1sv9a3UMAFT9wEzG+O+yPWqdFObOOKqLj7d0hiy6qxYFZEQu?=
 =?us-ascii?Q?4PXlUBHq9vBa9M5HPzVSPLZdBJxehJwZckMBCVRFDUEJUlSkY1AI0b6k4pxX?=
 =?us-ascii?Q?XUOcaHNVJH+tXyymcDF9FiRTAJqb6otzEPUjVKDBDVr4Zk1LSz1h3bMVSs8f?=
 =?us-ascii?Q?i6/CuZ5W7D0YmxMWCfvAmIOVhxkQre/PtnBEsfoWLOcoxe59q0etfmOalP5Q?=
 =?us-ascii?Q?FWZr/BWA8GtBbweJ7468i78aGVv4v8mlngSMDBGk+ffYobOPDfh1jXtMOvM1?=
 =?us-ascii?Q?djnY2OHj/hjkZk//ugZgd+jLGyZaVExGsjQqYDVTVwneSK2h8zYu9QBwivPI?=
 =?us-ascii?Q?imn6bEP6mdPbmvkEVKRBxlBsgbPzj1ylWacDne2tLdEt5aCUcgSo2h5DHxM2?=
 =?us-ascii?Q?68UHzwUckrZbtDitzQF+JQxwt8iIHKidz+09/cJgqXuZxze2jlmfhiHvXniv?=
 =?us-ascii?Q?YGuyEg5cBSqbkUowu1YD0OCMvBDpYAhWuUK6QyPzvigPFxvTYi8yE3wiDF//?=
 =?us-ascii?Q?HBT94eYhphJkflJf/hjj4gaLocBa25Mnbw9TWmVIpsA18SS0h70V6sRWyo5i?=
 =?us-ascii?Q?XlhQgApbP/5Hc6CsBPOh8q8JrXY9yb4e6BtPgaBrCgcyQOUoxs9nZzO6E18X?=
 =?us-ascii?Q?HIZfGhN2oMFrGvbyFWzYSgJ/AlmlTNmUXmJx9zdUWtFCrRhn/MSdSnbGh8Lb?=
 =?us-ascii?Q?iBUqWQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EgRw2whUAFm7JaubURTEQ+d8Kj6yhN0gYE8gxFZCTw+hsjUfJzjfd3FClHSPAQw9YuXV0UrR5UNqNSJg2Z/kIiYV2jDNtQRtp0BCwGDbjbx+KGgxvBmqG19JbfemucsctpPIaf0Y9iE/8GouZy0sdEmtXmSlcv5wtCB6uFmve7AswYisM/H2smtKz8RpM9njDfKHbqegwR+21fixi3romGEpSPVYmAoz9yh/VtEFJSL3ybw6Vy776+ctglGiXK3d+MRW2prONdXroCa8sxtCLo5kLLyAoPeBksnQVgon24tu1+ILWYxwjhKuBDNFqHqX6xqhMhUvabkE2PJpbYWyb9pdxRSR1uTcRVb6XPg/vChSdHdK8QqjKHU7anVe7P+atNJSZS3lMpJ98ZPaRc466em7vt9V0s78fkR40Xetg8Akw7EBD5jySlrGC/anIEeSodvfP9Rh5sgyxv9mTZF+f8zabVwfhFzgOJp+FigM3k5uZ1dudVEap035CWceAhSFxCFkm8DYIaOov3Kn7jPKs5NNDcC2+av4udMYuQn1azF658tAqq2U12TOLjNX+QSMY/q4k2KI8odEy8vM8xLHxctl3eb4Z2LqX2qgJHSNCvM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14c616a0-58cb-4ceb-14c6-08dcf12315b0
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2024 16:20:17.2575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iGZPNNcP8FLmLgt6xP49Rp7VNzyn8G7YCzUo/cRCzMZH7gTg4NL8XgGYpUeyy+B/EykAUCKsOU/AYc2Ul7TDGOF9DI7/XyL3xbxUQN58pZY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6703
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-20_14,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410200114
X-Proofpoint-GUID: TFpztYeXN_of0AZF1ycRAlRL_b9_wfDa
X-Proofpoint-ORIG-GUID: TFpztYeXN_of0AZF1ycRAlRL_b9_wfDa

The existing generic pagewalk logic permits the walking of page tables,
invoking callbacks at individual page table levels via user-provided
mm_walk_ops callbacks.

This is useful for traversing existing page table entries, but precludes
the ability to establish new ones.

Existing mechanism for performing a walk which also installs page table
entries if necessary are heavily duplicated throughout the kernel, each
with semantic differences from one another and largely unavailable for use
elsewhere.

Rather than add yet another implementation, we extend the generic pagewalk
logic to enable the installation of page table entries by adding a new
install_pte() callback in mm_walk_ops. If this is specified, then upon
encountering a missing page table entry, we allocate and install a new one
and continue the traversal.

If a THP huge page is encountered, we make use of existing logic to split
it. Then once we reach the PTE level, we invoke the install_pte() callback
which provides a PTE entry to install. We do not support hugetlb at this
stage.

If this function returns an error, or an allocation fails during the
operation, we abort the operation altogether. It is up to the caller to
deal appropriately with partially populated page table ranges.

If install_pte() is defined, the semantics of pte_entry() change - this
callback is then only invoked if the entry already exists. This is a useful
property, as it allows a caller to handle existing PTEs while installing
new ones where necessary in the specified range.

If install_pte() is not defined, then there is no functional difference to
this patch, so all existing logic will work precisely as it did before.

As we only permit the installation of PTEs where a mapping does not already
exist there is no need for TLB management, however we do invoke
update_mmu_cache() for architectures which require manual maintenance of
mappings for other CPUs.

We explicitly do not allow the existing page walk API to expose this
feature as it is dangerous and intended for internal mm use only. Therefore
we provide a new walk_page_range_mm() function exposed only to
mm/internal.h.

Reviewed-by: Jann Horn <jannh@google.com>
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/linux/pagewalk.h |  18 +++-
 mm/internal.h            |   6 ++
 mm/pagewalk.c            | 200 ++++++++++++++++++++++++++++-----------
 3 files changed, 165 insertions(+), 59 deletions(-)

diff --git a/include/linux/pagewalk.h b/include/linux/pagewalk.h
index f5eb5a32aeed..9700a29f8afb 100644
--- a/include/linux/pagewalk.h
+++ b/include/linux/pagewalk.h
@@ -25,12 +25,15 @@ enum page_walk_lock {
  *			this handler is required to be able to handle
  *			pmd_trans_huge() pmds.  They may simply choose to
  *			split_huge_page() instead of handling it explicitly.
- * @pte_entry:		if set, called for each PTE (lowest-level) entry,
- *			including empty ones
+ * @pte_entry:		if set, called for each PTE (lowest-level) entry
+ *			including empty ones, except if @install_pte is set.
+ *			If @install_pte is set, @pte_entry is called only for
+ *			existing PTEs.
  * @pte_hole:		if set, called for each hole at all levels,
  *			depth is -1 if not known, 0:PGD, 1:P4D, 2:PUD, 3:PMD.
  *			Any folded depths (where PTRS_PER_P?D is equal to 1)
- *			are skipped.
+ *			are skipped. If @install_pte is specified, this will
+ *			not trigger for any populated ranges.
  * @hugetlb_entry:	if set, called for each hugetlb entry. This hook
  *			function is called with the vma lock held, in order to
  *			protect against a concurrent freeing of the pte_t* or
@@ -51,6 +54,13 @@ enum page_walk_lock {
  * @pre_vma:            if set, called before starting walk on a non-null vma.
  * @post_vma:           if set, called after a walk on a non-null vma, provided
  *                      that @pre_vma and the vma walk succeeded.
+ * @install_pte:        if set, missing page table entries are installed and
+ *                      thus all levels are always walked in the specified
+ *                      range. This callback is then invoked at the PTE level
+ *                      (having split any THP pages prior), providing the PTE to
+ *                      install. If allocations fail, the walk is aborted. This
+ *                      operation is only available for userland memory. Not
+ *                      usable for hugetlb ranges.
  *
  * p?d_entry callbacks are called even if those levels are folded on a
  * particular architecture/configuration.
@@ -76,6 +86,8 @@ struct mm_walk_ops {
 	int (*pre_vma)(unsigned long start, unsigned long end,
 		       struct mm_walk *walk);
 	void (*post_vma)(struct mm_walk *walk);
+	int (*install_pte)(unsigned long addr, unsigned long next,
+			   pte_t *ptep, struct mm_walk *walk);
 	enum page_walk_lock walk_lock;
 };
 
diff --git a/mm/internal.h b/mm/internal.h
index 508f7802dd2b..fb1fb0c984e4 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -12,6 +12,7 @@
 #include <linux/mm.h>
 #include <linux/mm_inline.h>
 #include <linux/pagemap.h>
+#include <linux/pagewalk.h>
 #include <linux/rmap.h>
 #include <linux/swap.h>
 #include <linux/swapops.h>
@@ -1451,4 +1452,9 @@ static inline void accept_page(struct page *page)
 }
 #endif /* CONFIG_UNACCEPTED_MEMORY */
 
+/* pagewalk.c */
+int walk_page_range_mm(struct mm_struct *mm, unsigned long start,
+		unsigned long end, const struct mm_walk_ops *ops,
+		void *private);
+
 #endif	/* __MM_INTERNAL_H */
diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index 5f9f01532e67..261cd5f2de38 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -3,9 +3,14 @@
 #include <linux/highmem.h>
 #include <linux/sched.h>
 #include <linux/hugetlb.h>
+#include <linux/mmu_context.h>
 #include <linux/swap.h>
 #include <linux/swapops.h>
 
+#include <asm/tlbflush.h>
+
+#include "internal.h"
+
 /*
  * We want to know the real level where a entry is located ignoring any
  * folding of levels which may be happening. For example if p4d is folded then
@@ -29,9 +34,23 @@ static int walk_pte_range_inner(pte_t *pte, unsigned long addr,
 	int err = 0;
 
 	for (;;) {
-		err = ops->pte_entry(pte, addr, addr + PAGE_SIZE, walk);
-		if (err)
-		       break;
+		if (ops->install_pte && pte_none(ptep_get(pte))) {
+			pte_t new_pte;
+
+			err = ops->install_pte(addr, addr + PAGE_SIZE, &new_pte,
+					       walk);
+			if (err)
+				break;
+
+			set_pte_at(walk->mm, addr, pte, new_pte);
+			/* Non-present before, so for arches that need it. */
+			if (!WARN_ON_ONCE(walk->no_vma))
+				update_mmu_cache(walk->vma, addr, pte);
+		} else {
+			err = ops->pte_entry(pte, addr, addr + PAGE_SIZE, walk);
+			if (err)
+				break;
+		}
 		if (addr >= end - PAGE_SIZE)
 			break;
 		addr += PAGE_SIZE;
@@ -89,11 +108,14 @@ static int walk_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
 again:
 		next = pmd_addr_end(addr, end);
 		if (pmd_none(*pmd)) {
-			if (ops->pte_hole)
+			if (ops->install_pte)
+				err = __pte_alloc(walk->mm, pmd);
+			else if (ops->pte_hole)
 				err = ops->pte_hole(addr, next, depth, walk);
 			if (err)
 				break;
-			continue;
+			if (!ops->install_pte)
+				continue;
 		}
 
 		walk->action = ACTION_SUBTREE;
@@ -116,7 +138,7 @@ static int walk_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
 		 */
 		if ((!walk->vma && (pmd_leaf(*pmd) || !pmd_present(*pmd))) ||
 		    walk->action == ACTION_CONTINUE ||
-		    !(ops->pte_entry))
+		    !(ops->pte_entry || ops->install_pte))
 			continue;
 
 		if (walk->vma)
@@ -148,11 +170,14 @@ static int walk_pud_range(p4d_t *p4d, unsigned long addr, unsigned long end,
  again:
 		next = pud_addr_end(addr, end);
 		if (pud_none(*pud)) {
-			if (ops->pte_hole)
+			if (ops->install_pte)
+				err = __pmd_alloc(walk->mm, pud, addr);
+			else if (ops->pte_hole)
 				err = ops->pte_hole(addr, next, depth, walk);
 			if (err)
 				break;
-			continue;
+			if (!ops->install_pte)
+				continue;
 		}
 
 		walk->action = ACTION_SUBTREE;
@@ -167,7 +192,7 @@ static int walk_pud_range(p4d_t *p4d, unsigned long addr, unsigned long end,
 
 		if ((!walk->vma && (pud_leaf(*pud) || !pud_present(*pud))) ||
 		    walk->action == ACTION_CONTINUE ||
-		    !(ops->pmd_entry || ops->pte_entry))
+		    !(ops->pmd_entry || ops->pte_entry || ops->install_pte))
 			continue;
 
 		if (walk->vma)
@@ -196,18 +221,22 @@ static int walk_p4d_range(pgd_t *pgd, unsigned long addr, unsigned long end,
 	do {
 		next = p4d_addr_end(addr, end);
 		if (p4d_none_or_clear_bad(p4d)) {
-			if (ops->pte_hole)
+			if (ops->install_pte)
+				err = __pud_alloc(walk->mm, p4d, addr);
+			else if (ops->pte_hole)
 				err = ops->pte_hole(addr, next, depth, walk);
 			if (err)
 				break;
-			continue;
+			if (!ops->install_pte)
+				continue;
 		}
 		if (ops->p4d_entry) {
 			err = ops->p4d_entry(p4d, addr, next, walk);
 			if (err)
 				break;
 		}
-		if (ops->pud_entry || ops->pmd_entry || ops->pte_entry)
+		if (ops->pud_entry || ops->pmd_entry || ops->pte_entry ||
+		    ops->install_pte)
 			err = walk_pud_range(p4d, addr, next, walk);
 		if (err)
 			break;
@@ -231,18 +260,22 @@ static int walk_pgd_range(unsigned long addr, unsigned long end,
 	do {
 		next = pgd_addr_end(addr, end);
 		if (pgd_none_or_clear_bad(pgd)) {
-			if (ops->pte_hole)
+			if (ops->install_pte)
+				err = __p4d_alloc(walk->mm, pgd, addr);
+			else if (ops->pte_hole)
 				err = ops->pte_hole(addr, next, 0, walk);
 			if (err)
 				break;
-			continue;
+			if (!ops->install_pte)
+				continue;
 		}
 		if (ops->pgd_entry) {
 			err = ops->pgd_entry(pgd, addr, next, walk);
 			if (err)
 				break;
 		}
-		if (ops->p4d_entry || ops->pud_entry || ops->pmd_entry || ops->pte_entry)
+		if (ops->p4d_entry || ops->pud_entry || ops->pmd_entry ||
+		    ops->pte_entry || ops->install_pte)
 			err = walk_p4d_range(pgd, addr, next, walk);
 		if (err)
 			break;
@@ -334,6 +367,11 @@ static int __walk_page_range(unsigned long start, unsigned long end,
 	int err = 0;
 	struct vm_area_struct *vma = walk->vma;
 	const struct mm_walk_ops *ops = walk->ops;
+	bool is_hugetlb = is_vm_hugetlb_page(vma);
+
+	/* We do not support hugetlb PTE installation. */
+	if (ops->install_pte && is_hugetlb)
+		return -EINVAL;
 
 	if (ops->pre_vma) {
 		err = ops->pre_vma(start, end, walk);
@@ -341,7 +379,7 @@ static int __walk_page_range(unsigned long start, unsigned long end,
 			return err;
 	}
 
-	if (is_vm_hugetlb_page(vma)) {
+	if (is_hugetlb) {
 		if (ops->hugetlb_entry)
 			err = walk_hugetlb_range(start, end, walk);
 	} else
@@ -380,47 +418,14 @@ static inline void process_vma_walk_lock(struct vm_area_struct *vma,
 #endif
 }
 
-/**
- * walk_page_range - walk page table with caller specific callbacks
- * @mm:		mm_struct representing the target process of page table walk
- * @start:	start address of the virtual address range
- * @end:	end address of the virtual address range
- * @ops:	operation to call during the walk
- * @private:	private data for callbacks' usage
- *
- * Recursively walk the page table tree of the process represented by @mm
- * within the virtual address range [@start, @end). During walking, we can do
- * some caller-specific works for each entry, by setting up pmd_entry(),
- * pte_entry(), and/or hugetlb_entry(). If you don't set up for some of these
- * callbacks, the associated entries/pages are just ignored.
- * The return values of these callbacks are commonly defined like below:
- *
- *  - 0  : succeeded to handle the current entry, and if you don't reach the
- *         end address yet, continue to walk.
- *  - >0 : succeeded to handle the current entry, and return to the caller
- *         with caller specific value.
- *  - <0 : failed to handle the current entry, and return to the caller
- *         with error code.
- *
- * Before starting to walk page table, some callers want to check whether
- * they really want to walk over the current vma, typically by checking
- * its vm_flags. walk_page_test() and @ops->test_walk() are used for this
- * purpose.
- *
- * If operations need to be staged before and committed after a vma is walked,
- * there are two callbacks, pre_vma() and post_vma(). Note that post_vma(),
- * since it is intended to handle commit-type operations, can't return any
- * errors.
- *
- * struct mm_walk keeps current values of some common data like vma and pmd,
- * which are useful for the access from callbacks. If you want to pass some
- * caller-specific data to callbacks, @private should be helpful.
+/*
+ * See the comment for walk_page_range(), this performs the heavy lifting of the
+ * operation, only sets no restrictions on how the walk proceeds.
  *
- * Locking:
- *   Callers of walk_page_range() and walk_page_vma() should hold @mm->mmap_lock,
- *   because these function traverse vma list and/or access to vma's data.
+ * We usually restrict the ability to install PTEs, but this functionality is
+ * available to internal memory management code and provided in mm/internal.h.
  */
-int walk_page_range(struct mm_struct *mm, unsigned long start,
+int walk_page_range_mm(struct mm_struct *mm, unsigned long start,
 		unsigned long end, const struct mm_walk_ops *ops,
 		void *private)
 {
@@ -479,6 +484,80 @@ int walk_page_range(struct mm_struct *mm, unsigned long start,
 	return err;
 }
 
+/*
+ * Determine if the walk operations specified are permitted to be used for a
+ * page table walk.
+ *
+ * This check is performed on all functions which are parameterised by walk
+ * operations and exposed in include/linux/pagewalk.h.
+ *
+ * Internal memory management code can use the walk_page_range_mm() function to
+ * be able to use all page walking operations.
+ */
+static bool check_ops_valid(const struct mm_walk_ops *ops)
+{
+	/*
+	 * The installation of PTEs is solely under the control of memory
+	 * management logic and subject to many subtle locking, security and
+	 * cache considerations so we cannot permit other users to do so, and
+	 * certainly not for exported symbols.
+	 */
+	if (ops->install_pte)
+		return false;
+
+	return true;
+}
+
+/**
+ * walk_page_range - walk page table with caller specific callbacks
+ * @mm:		mm_struct representing the target process of page table walk
+ * @start:	start address of the virtual address range
+ * @end:	end address of the virtual address range
+ * @ops:	operation to call during the walk
+ * @private:	private data for callbacks' usage
+ *
+ * Recursively walk the page table tree of the process represented by @mm
+ * within the virtual address range [@start, @end). During walking, we can do
+ * some caller-specific works for each entry, by setting up pmd_entry(),
+ * pte_entry(), and/or hugetlb_entry(). If you don't set up for some of these
+ * callbacks, the associated entries/pages are just ignored.
+ * The return values of these callbacks are commonly defined like below:
+ *
+ *  - 0  : succeeded to handle the current entry, and if you don't reach the
+ *         end address yet, continue to walk.
+ *  - >0 : succeeded to handle the current entry, and return to the caller
+ *         with caller specific value.
+ *  - <0 : failed to handle the current entry, and return to the caller
+ *         with error code.
+ *
+ * Before starting to walk page table, some callers want to check whether
+ * they really want to walk over the current vma, typically by checking
+ * its vm_flags. walk_page_test() and @ops->test_walk() are used for this
+ * purpose.
+ *
+ * If operations need to be staged before and committed after a vma is walked,
+ * there are two callbacks, pre_vma() and post_vma(). Note that post_vma(),
+ * since it is intended to handle commit-type operations, can't return any
+ * errors.
+ *
+ * struct mm_walk keeps current values of some common data like vma and pmd,
+ * which are useful for the access from callbacks. If you want to pass some
+ * caller-specific data to callbacks, @private should be helpful.
+ *
+ * Locking:
+ *   Callers of walk_page_range() and walk_page_vma() should hold @mm->mmap_lock,
+ *   because these function traverse vma list and/or access to vma's data.
+ */
+int walk_page_range(struct mm_struct *mm, unsigned long start,
+		unsigned long end, const struct mm_walk_ops *ops,
+		void *private)
+{
+	if (!check_ops_valid(ops))
+		return -EINVAL;
+
+	return walk_page_range_mm(mm, start, end, ops, private);
+}
+
 /**
  * walk_page_range_novma - walk a range of pagetables not backed by a vma
  * @mm:		mm_struct representing the target process of page table walk
@@ -494,7 +573,7 @@ int walk_page_range(struct mm_struct *mm, unsigned long start,
  * walking the kernel pages tables or page tables for firmware.
  *
  * Note: Be careful to walk the kernel pages tables, the caller may be need to
- * take other effective approache (mmap lock may be insufficient) to prevent
+ * take other effective approaches (mmap lock may be insufficient) to prevent
  * the intermediate kernel page tables belonging to the specified address range
  * from being freed (e.g. memory hot-remove).
  */
@@ -513,6 +592,8 @@ int walk_page_range_novma(struct mm_struct *mm, unsigned long start,
 
 	if (start >= end || !walk.mm)
 		return -EINVAL;
+	if (!check_ops_valid(ops))
+		return -EINVAL;
 
 	/*
 	 * 1) For walking the user virtual address space:
@@ -556,6 +637,8 @@ int walk_page_range_vma(struct vm_area_struct *vma, unsigned long start,
 		return -EINVAL;
 	if (start < vma->vm_start || end > vma->vm_end)
 		return -EINVAL;
+	if (!check_ops_valid(ops))
+		return -EINVAL;
 
 	process_mm_walk_lock(walk.mm, ops->walk_lock);
 	process_vma_walk_lock(vma, ops->walk_lock);
@@ -574,6 +657,8 @@ int walk_page_vma(struct vm_area_struct *vma, const struct mm_walk_ops *ops,
 
 	if (!walk.mm)
 		return -EINVAL;
+	if (!check_ops_valid(ops))
+		return -EINVAL;
 
 	process_mm_walk_lock(walk.mm, ops->walk_lock);
 	process_vma_walk_lock(vma, ops->walk_lock);
@@ -623,6 +708,9 @@ int walk_page_mapping(struct address_space *mapping, pgoff_t first_index,
 	unsigned long start_addr, end_addr;
 	int err = 0;
 
+	if (!check_ops_valid(ops))
+		return -EINVAL;
+
 	lockdep_assert_held(&mapping->i_mmap_rwsem);
 	vma_interval_tree_foreach(vma, &mapping->i_mmap, first_index,
 				  first_index + nr - 1) {
-- 
2.47.0


