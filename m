Return-Path: <linux-arch+bounces-8549-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38AE29B0A9A
	for <lists+linux-arch@lfdr.de>; Fri, 25 Oct 2024 19:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9919B2846AA
	for <lists+linux-arch@lfdr.de>; Fri, 25 Oct 2024 17:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C04B61F80DC;
	Fri, 25 Oct 2024 17:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TG6hZc5u";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oQXw7/os"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD4C18C01A;
	Fri, 25 Oct 2024 17:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729876402; cv=fail; b=jyo9cUN3b31GIkt0fa7YY4u89AtkkCUC0cMfWsNO5u6ww0TjmKosszqjqdLfoHiSFxOZVTwmqQi/FlQbpbjxq9UeYA7MAXkmmy3WmlLxeKNZfOU/ZVByv9XDvGCxkkmifc9ZWReOtdjZWkhYKc6Bp4m2bMQwSualY5gKIuy6Z48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729876402; c=relaxed/simple;
	bh=snd5SAvNWKAIOJooIC85isfAuRPfxfSyhq9qrfrIQfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Zelda6FCb30bvT2Zgy9wsnliDxI9heupKzuDjO0kZouYbFdFqV6GxgCH+BAQLZvL9YcVW34wHAlKBImBBydCkkq+nHwuq4MBNNF2RK/aAYe+o9eakuWN+plpqmBUExIcNqQ7yOmi8scit1hmSNA3sUT8hBX2lYRm4ajvM6F5UHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TG6hZc5u; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oQXw7/os; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49PG0dZa017247;
	Fri, 25 Oct 2024 17:12:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=TsfuM9KeB/p+GIQtHP
	RUed6PM8gujqNcLeti4suNO2A=; b=TG6hZc5u/HYsXllXWi7sEQeS3trgfHh9Y6
	yyK0ZbKnDoXSk6P9PuRa+l3nRfKbLTXSnritvgt1X+WGFvQsNnLL3r/iAFB94JKm
	0GCGrAPskD1c51P6Nmjbzy8TxQ/GOOMw7XTnLeRAaN4w33I6QSyOgRyVekLf0tUT
	6wAsIQxBHSH3cv3qD4mHxaMrgbsgHErF1o9NX/1O2J5Ai2J9kCXGl08zqkDrbKSq
	BdBEqKet9aZNTul17L2aZRTJGyvS/JUeytk52buTaZgnhPC25q6TzpTv/oWCatJG
	+7c2M0u45WGJM5veb4i6n8c04AffXo3Ji51C35+QmfYc7RTAv9AQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c55enapv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 17:12:28 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49PFhBUU039313;
	Fri, 25 Oct 2024 17:12:25 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42emh60fq6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 17:12:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PdNyWnTaFwpK4XmGoHBBUPqZN5cUwUZB0YcYb2PW3ODcM6jxzMuXNZHAwoLdCwjMRlEqHGNbHKH7EVZxBD38MjQmQRKmqInc6ySXSEOkdpANFcJogL2TnG46mplfL4UIC0t3WFc1RU98vNJh0LQDLsYfCUckTuIEbAGQLept50HgabKfvLHRZIu/djDTBI96dMYkkCBH/jL2TH7gpAYU1HaC28At770BaMOHvtPx0bJUfOP5fQQgUHrNuMTtH5iNqa1ZFE7TC0yqlJPYjrF5cHB8EFnvL73mUzGDrV+Rbf7Foq5rfx1eksGpsDrbPcvWSorXjAYHJOIeoOUWl65Krw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TsfuM9KeB/p+GIQtHPRUed6PM8gujqNcLeti4suNO2A=;
 b=mnzchZKqf0uFB6kYkMLp1VAWavKJ2ZWRiBqYsPuL9HO6TBnvO2hB0fYhnkzCivHH71d/U3MGJQRQgGbiTZJ89O5lrKlX1TgsFiRzr2B/eqAvwdy4otY3xihkiOT5sD/GwryxZGZk6KvGNuS6w0BpolaimUku31KVYTw62wskIN/verWFWctYcbHjFbW09QuiHgaetk7YGwTostoF5QVTOPVbp5N5LaWoBabAkRSJXzvX4fzYh8ZbMhsKNbOCpGJSPt/CDQXnGRNOIt/lcQ0wJrSVno+ZPV087QW0Oavb/YRB17AtDBqmTUTHMRDlg4gHrcvm65drInu0GI+WvyeaHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TsfuM9KeB/p+GIQtHPRUed6PM8gujqNcLeti4suNO2A=;
 b=oQXw7/osCvug7Mzh17PWctH10/18BlqfA0tbD7R1VE2W9dxlK1iDuq/bBR566hjY0kPTqnRxJ9JMTGRKZXlGgKfOAbAwq/xr90EgmHuvJE7MZZ/xa/QyTGCZZu24r5Lk47+C13oJzY8SDVd2BgN0f734Oa8coqFbugz6ZcZKGXE=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by IA1PR10MB6781.namprd10.prod.outlook.com (2603:10b6:208:42b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Fri, 25 Oct
 2024 17:12:22 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8093.014; Fri, 25 Oct 2024
 17:12:22 +0000
Date: Fri, 25 Oct 2024 18:12:18 +0100
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
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>, Arnd Bergmann <arnd@kernel.org>,
        linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-arch@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>,
        linux-kselftest@vger.kernel.org,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Jeff Xu <jeffxu@chromium.org>, Christoph Hellwig <hch@infradead.org>,
        linux-api@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v3 3/5] mm: madvise: implement lightweight guard page
 mechanism
Message-ID: <f09086cd-c49c-4eea-adff-d626c16083de@lucifer.local>
References: <cover.1729699916.git.lorenzo.stoakes@oracle.com>
 <415da1e6c5828d96db3af480d243a7f68ccabf6d.1729699916.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <415da1e6c5828d96db3af480d243a7f68ccabf6d.1729699916.git.lorenzo.stoakes@oracle.com>
X-ClientProxiedBy: LO4P265CA0239.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:350::13) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|IA1PR10MB6781:EE_
X-MS-Office365-Filtering-Correlation-Id: 9064111c-6e36-4c92-6cbf-08dcf51830a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MV/utXT8JwIVVjyi3KjCKMd15schxptYP8Aay6ncYRtv9HqX/SGdIqORL3Zf?=
 =?us-ascii?Q?GdETG6+G/qAEvlTOXw8a8LUZmbSXsYdrEcYUyfLgyMFJvGDKalQDhesY6YOb?=
 =?us-ascii?Q?T9we7Dpvk2l/nxYidYA8Q1/pnkb9OVTagam48d/CHjbIcbelDeHB78lqZnJ9?=
 =?us-ascii?Q?+Woz1nES+Cee5FUmY2yAkyYiD8S1WUxXUfmGJU3pJS2O83QyMLDqlXbu7a5D?=
 =?us-ascii?Q?egOSzY7UIhO/ffArOFvZHsSjGIOraZn1PVwbDlyCfrU0zO63KAI4II3CqCK6?=
 =?us-ascii?Q?ODY2w8JiR1lvYRXvSDbwBI1oI9QDnYGx+yOaYpjQFJ3r/RKW0xV8sIjXCqQC?=
 =?us-ascii?Q?n/MgqEEDoTODWEWEegtErUZx0mqoNhoqhhmlINGGvDnFcGxGMWFCrHGAzQmg?=
 =?us-ascii?Q?3jTKUfErlAoa4UaS2jdgyfqQarR+9cSJvys59HyLMOXwtpdLQ4xpWhVaf1M1?=
 =?us-ascii?Q?WPl6YXWNmPf61aU6meq/hCBRAKgSYXimBbD6crIOTo761WlZvpCyRpNANEN2?=
 =?us-ascii?Q?i1tg5/0MTo+IKikiiVqGM1ZoggNtsS2laUr9cFCuqGdmT1Qyl+sw+Z8zh4Uy?=
 =?us-ascii?Q?dO+bfRpXcSPTdvb6ulD1ZgLabtgBe+8xdM2dC0Qup/0TIpzzss+c5ne36LGZ?=
 =?us-ascii?Q?MiQHqPKqLcaKps+lU0n3g4Fg+wRdwf3mQoi1OnOJCdUnag/ELFK8u+CDPGyb?=
 =?us-ascii?Q?giXRr/PJXH3DmS8zJJ3Eddl0zJHINVCcyU9C8uNjXs5xgfUokZMnNIgvx5Zm?=
 =?us-ascii?Q?8C6WacFbFuRu+S4j//KIsvA9JBnh4AfcHLorOPcSs53hakyRN8gtYJLqxJkS?=
 =?us-ascii?Q?va5AM8UUp3vzu1izutSDd8Yu89Dtztv2xLLU0vOokybINOm/iD/WxZFlU0OA?=
 =?us-ascii?Q?TpKTRNrlhjDivb4svFwRFfUGHPN0QJsQWaACXxffG5wUERrJga7By3P/sKr/?=
 =?us-ascii?Q?TSjEX+m01cX/cn//8OEYVElUZKI4r1U6VFLlm/riEDHiFR8WoU25H6+gjIgH?=
 =?us-ascii?Q?jlExD4c94/IfjCmWMv/BiBnGKOA8noMdFSLz/ONkJWUljAtn4niPjC61zhdu?=
 =?us-ascii?Q?A7ILsDy01me3IQi41LsE4d89qMac7Aes34tz0cNyP2gnKfEcLs6mAhLYZxJc?=
 =?us-ascii?Q?TGX4OAoYp/xg+t3L8LqHIuw7emcihhRg4spxv0y3pj6AC3dEAOoyLfXd9eiF?=
 =?us-ascii?Q?wJoIJ9QsyFJYwi8mLBaq0XPMVZCil4w0WMH9aAxPOaVRqYK+hU0n07CneMDl?=
 =?us-ascii?Q?nGdrWLwl7rgIciofWdYbtO1/Me05KqAmaf5DzkWkbh554JEyqsRcmynFDQyp?=
 =?us-ascii?Q?kcNwlVqD/UPq1jUBLczz+Lia?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LlVhqwTbXvZ4eWlVcnIA2pV/SRjwGenWt5p4RwAPZmMbwtRsFlKbDehHxbul?=
 =?us-ascii?Q?6yZwh00/trEn0VO+/bGnOizFmhGUAmG+ljMEQBE+zGQ/EmLxk7PSjPkPdv+P?=
 =?us-ascii?Q?0sIzFZUWpUaEyAt6bk4oeyQoN/0eHNtdnD7Zgr76YnWbnKxj1DZuCMNcp52Y?=
 =?us-ascii?Q?W2UCQAQRJSHBjCimqgfj6EEQt1psAhYfHR5q2rL8Qj5fb2y5lWHCMJdNVsw7?=
 =?us-ascii?Q?fZtgEHwT64Z8nu51eWlGyl86GFAtIsYLI4sR7/KYyhPFq0W/V+La1Q0xnoeJ?=
 =?us-ascii?Q?CZmBuetbMcooceacKPwkipaDz/YQAu3NQnEGGy4jXc7+cm3nWZISS+BpYR6k?=
 =?us-ascii?Q?5qCwQeyDvEOBdjpk6hPAQMBvPaSXdDNUci835r7+5ZJfe9xq5E8XJaCr2a+H?=
 =?us-ascii?Q?y4BNQ0WvXLH+3ReC5Gx8i9c9IrEZmD+70NC4b7osIUJIZQj97xejcHBHXq2w?=
 =?us-ascii?Q?Xy5fDYGoP2RWVUZ0xO2qpWR58B9FvSRT++Rg1un2E0eZallqik4bFTvpnHUV?=
 =?us-ascii?Q?7CJEYoPVhizOumT0CTGWP2lWgvXGkv2SvHfkRRc3L3+lenjxn5bOZ+9jv4Tx?=
 =?us-ascii?Q?OAyzEE7vrxz62KkebU6TJu1uXnWL8kuF1tgK18UNKMdGJJPZ5E10wEk7HJ5E?=
 =?us-ascii?Q?T4V4jR6sy8N8dKD6Ufny0RNnMZojXYkIj3RuJOU2phEj8scMkqHL4rClSv8w?=
 =?us-ascii?Q?dF8U8LcVNJzr0s6EuHL3SBjKgonRW0nO0Qnw2Du/pOtS4UxulUDgCW2o7F+o?=
 =?us-ascii?Q?Q/SgCdTvUDm/nUbd+vEvfuh4IyKhQ2YC+oGnf6edxt4XzcvkDkNMfSiahzff?=
 =?us-ascii?Q?a8GZ0BD+qWhTNZXotvmmRII3ukuC4Z/z9W97fp1rhCVLBywExJ9bEbdCXgj1?=
 =?us-ascii?Q?mC5ZtBSrJFIoI81HBs+PKAsNqXDiFBsyPCcII9IFj1RXQtc+aVSynpyXKw6h?=
 =?us-ascii?Q?/PtO40QuDawzH1Lb/wTl0a9W9TaqgIxw8BEO2I/zvekIaXwAzw3G0P/fQaKx?=
 =?us-ascii?Q?JwB3+mGkqwOusnNypY8Eg/sqXwfSw2QHasYY7QcNe48ymVr2F+9BhrCaMGaa?=
 =?us-ascii?Q?9DhUEZdaXQjZdBaiiBDUd2dKC/vhAWhLocKfpbm37wVN+YOhCCny91e/pjsV?=
 =?us-ascii?Q?tFDfQhVv+XYTTYY2LhAPo94dIhLPqEF17IppDur8vQUHKTnvqpKozx9CZyBy?=
 =?us-ascii?Q?snxER1o98Pe7ivVfK6tZFrnNmYDTE0nj0E7lpo8/ZQCGAaybGf536NYQxd7S?=
 =?us-ascii?Q?t2Dl6stBirdDuNhV1adEWjoc2sUhICZ/oeX5vBW2CAtVT5Ryox8daF/zBX6n?=
 =?us-ascii?Q?qULlZFIDG7q88IErVb7CJTDDUSBjPw90vaeKsyuOYxwZg1lIE/cmREdi17nM?=
 =?us-ascii?Q?386sz+qw5zB748egGdr5RkUsQQQfGQZXCmJIdoFB/WqFkIr6Z3laNOq4+95D?=
 =?us-ascii?Q?FsPa8Ogo4AUbhBLWI7zxI0XVkb8wu2l9X+6uM596T+uF9ftuolFbjjcd3E6a?=
 =?us-ascii?Q?GJGdxv5xn08Y+ihNywZ1+1FIzDt4b72dLs3By2X5+ilTfUNfAsNU23OxA1bR?=
 =?us-ascii?Q?VpLDDe87W6FyYAwYCw+CA2E5hIt6R5Og6lYZJr7RM7ACQcEKNLHGrkaWiug4?=
 =?us-ascii?Q?5DG4f1gcEBejg6i0BhlDZziJWrOZymb3Zm3Nmh7g3kXMSso6Qp3lhdtLTNjW?=
 =?us-ascii?Q?NnQ58w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	KilkU/4dmSf4LZK0nPRvBjN5VK9mMx4cdzaH2ERSTj5Y8q9usGGUAZeaRAu/AaZzb5hPZn/14QfQakK5a4re3yOmmg6jgSPGF6/f8RDyeR2xTJVQhSM1rSWUdYtrAleLOEE1B4DCHb5TAwhUk67N8fEGrckGTGcaNboXWSg4JJKqhug0O6qc/lEI5Xm6TIb54wf8Khuvr4iTWTFCUHC2LOOZYz3npckY0mPNxHCTLZtMxZb2/ZcelvD9wLcHD45g6LJAHRy7KgPf0c1Tu8qw83DJW9g/+lX1We17IALhJ1dNk0bSYYKRZ7TgfRSZ60VcC9rxnz7QU88LEmaqHHEgFWXKJQiT2DPboEe4qCsZL06af1BDh8IUGNe+M5epSG969y+WBjqk7W5no73mxp4DbIA0zE3mc2KdJjnaZiypkvroAkszv7Lj9B2tFdnhG7N4Rv6d6LSHoFMa89SIIWAIaFQqXPH62vCyWJbKi0WSeCj2sV0LNwPjbh7fgrN620VxnymkrxKxYOp3BDalA7QNygid3a2cRO3UpfR4j0IGMI7XMvNZ7ZBbCp74E4IK2h42XwZE/gZgbLwlzC/7LdffsR7DEX918i/vXQsqkDP69yY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9064111c-6e36-4c92-6cbf-08dcf51830a3
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 17:12:22.6672
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1bR1hBuSPFCOsPZPeHjcdHP4VNdRErUZLPzH1xocBx/z7VeuN4e1xEr8tVLdVP4pvgoyXu5AvWRAYvpITEy6QMyPr8+JFH8Cd9f+42O6CIk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6781
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-25_14,2024-10-25_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 malwarescore=0 adultscore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410250132
X-Proofpoint-ORIG-GUID: dlRyEGxNM7KkNS-9K3Z-67gZmfRNaJrj
X-Proofpoint-GUID: dlRyEGxNM7KkNS-9K3Z-67gZmfRNaJrj

On Wed, Oct 23, 2024 at 05:24:40PM +0100, Lorenzo Stoakes wrote:
> Implement a new lightweight guard page feature, that is regions of userland
> virtual memory that, when accessed, cause a fatal signal to arise.

<snip>

Hi Andrew - Could you apply the below fix-patch? I realise we must handle
fatal signals and conditional rescheduling in the vector_madvise() special
case.

Thanks!

----8<----
From 546d7e1831c71599fc733d589e0d75f52e84826d Mon Sep 17 00:00:00 2001
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Date: Fri, 25 Oct 2024 18:05:48 +0100
Subject: [PATCH] mm: yield on fatal signal/cond_sched() in vector_madvise()

While we have to treat -ERESTARTNOINTR specially here as we are looping
through a vector of operations and can't simply restart the entire
operation, we mustn't hold up fatal signals or RT kernels.
---
 mm/madvise.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 48eba25e25fe..127aa5d86656 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1713,8 +1713,14 @@ static ssize_t vector_madvise(struct mm_struct *mm, struct iov_iter *iter,
 		 * we have already rescinded locks, it should be no problem to
 		 * simply try again.
 		 */
-		if (ret == -ERESTARTNOINTR)
+		if (ret == -ERESTARTNOINTR) {
+			if (fatal_signal_pending(current)) {
+				ret = -EINTR;
+				break;
+			}
+			cond_resched();
 			continue;
+		}
 		if (ret < 0)
 			break;
 		iov_iter_advance(iter, iter_iov_len(iter));
--
2.47.0

