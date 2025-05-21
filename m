Return-Path: <linux-arch+bounces-12065-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9288ABFCF4
	for <lists+linux-arch@lfdr.de>; Wed, 21 May 2025 20:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D51A11BC13CF
	for <lists+linux-arch@lfdr.de>; Wed, 21 May 2025 18:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75DF228ECE5;
	Wed, 21 May 2025 18:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rQAppbTV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nauK8Eu8"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D126EB79;
	Wed, 21 May 2025 18:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747852845; cv=fail; b=cwnfL/tBuL1LojEB0+T4iGw0aGZBxJRWf41HpDZuo1INuRllnjkZ2zhXEUkk/XFq2LQj24EIcFn3b00LC7swaepYo5izCrdZDhQ4Da8CCBsjSiMctA4aSN+s2hWSt7LIxEqERhn+Eh1Ji+LtCyFrOkF1FzwCSwwb3mCjJKjH0RM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747852845; c=relaxed/simple;
	bh=aOC+iP9LQDBHxs2s6Kieo0++ttzP5/bGfeM21CQBFHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NEN0l1Jh8iBJ23zY7w53BD1Z5u58NuMxRl3qEg2iveeDaVjO+jZJLIOsK9GJSN6mxqbsfQ1MPHwgpwmnfDbur9qRH52QKmb9zPspZE6k6ctyuXdvPqgXtZ0acnCb2eORlxwKXL9hFT0egTU5iMPRhOKMNSuiUwdYfhCZLqLDmCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=rQAppbTV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nauK8Eu8; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54LHrudf013735;
	Wed, 21 May 2025 18:40:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=aOC+iP9LQDBHxs2s6K
	ieo0++ttzP5/bGfeM21CQBFHE=; b=rQAppbTVr3j+QlWigogvjdBF3mheqQ4Lxv
	Q39TMAGpIZrAyGYERIAmL5Hei3DdCEzTBiHCrKVJEXrK3qL3tYSrP5DBiUDdj+H5
	XflRWI3CEaYw9b64YhJbvCGhyNeb8QwBXUsIdARCVR2a7TzKL0Wc/+KeRKr1FwL/
	7z1hgx65i3Nhe6ZRPMssSz4wb8FmID5XI1uuT2gaJRQsaKP/sBUCXl16w1yXLI/1
	fsZCb0qKYJgb8qe9Ia6+NNYiC8c5NfedhlkbOaS/OpiVSqmn8v3qj3VWTp82FxYE
	1g8LlFzPHaNuX8ctdFPkKWnI5PCgAHlNnnLN8DONSjey5/6vBY+A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46skmc830p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 May 2025 18:40:21 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54LGxpQD034540;
	Wed, 21 May 2025 18:40:19 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46rweq7qtr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 May 2025 18:40:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D86JwDEeZR57IovhR7Dje0cS8nNw8BzbCiDPEZ0CDV9O1PHOZWO/E52xQ9n0BltxgzYfFs2p1pU8SG4tfhL1VMUnh02ony/sasKVAQPCTB4wKTqnerft+pNAzjTaDA2jQyBXrsr/Z/CEQ68ZZauak+c/7MYvbmwdNndKE3iSHS8dmz6x4dftTO3EMigUMxoyqRKb5iM0ZoTehqEjc+8JK5bse1SRQuxXBpMTKdhm0r1B8oraniQAuRhbEWm+z06pndiK7j4rFXVI6xYqJ0WXMYsLI1Nef4BtEAhtusColkXOJgRmGlE6vhiMqEm6uy0MqatEIv1+Znxym6S+94i2uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aOC+iP9LQDBHxs2s6Kieo0++ttzP5/bGfeM21CQBFHE=;
 b=Fg/mJrujdcNrH7SQ1S7bALGV07CiRq9cRX56i+qstWs5nZ/FeInMCKTHdqrGb1jktJlP6Ttg2V5PKk0YKU+B0EPBdNxR4V09ru7nALYkTyJLaUHKTw8eXcrMd5P/d7GO/o9B+iga8eelwByuNzDQs9bXwRM/jriOd/yTnmsTLnSkHfXrv+N5M5YvLFx/dEVggVZj3U/LunyOsuPVHR1ckTdM/ymLMzt3Cpkjd9mhGyrZlHl/pFBsdnXs42VFwV2DHD0tP0tS+51ucFuIDmQ2aMr5h5luKPOtoM0emrtfQKHmhKF6n9iHAyMzZSoPdeUzTNq52CT/8bvD/JawPdnDKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aOC+iP9LQDBHxs2s6Kieo0++ttzP5/bGfeM21CQBFHE=;
 b=nauK8Eu8Hqf3HiFDX2EiqU4y005zLKUZ5hsGjWrcXu74NPzQtbT2ZyUvXVfVYxMbMSX5jK8FdfRtuPdRsUxTdKzOtqHXpB0UBjwU2L3kGh49LQ+E9PQpYLBLLZeU8zQ84gmCyRIEU4Mh7aU17L55qPHlvadDErnm5sY4JFBqSo4=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by BN0PR10MB5063.namprd10.prod.outlook.com (2603:10b6:408:126::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Wed, 21 May
 2025 18:40:17 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8746.030; Wed, 21 May 2025
 18:40:17 +0000
Date: Wed, 21 May 2025 19:40:14 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Usama Arif <usamaarif642@gmail.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>,
        Jann Horn <jannh@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <brauner@kernel.org>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sj@kernel.org>
Subject: Re: [RFC PATCH 0/5] add process_madvise() flags to modify behaviour
Message-ID: <733527d5-c10d-4f3c-b022-78cc3c21c4d6@lucifer.local>
References: <7tzfy4mmbo2utodqr5clk24mcawef5l2gwrgmnp5jmqxmhkpav@jpzaaoys6jro>
 <5604190c-3309-4cb8-b746-2301615d933c@lucifer.local>
 <uxhvhja5igs5cau7tomk56wit65lh7ooq7i5xsdzyqsv5ikavm@kiwe26ioxl3t>
 <e8c459cb-c8b8-4c34-8f94-c8918bef582f@lucifer.local>
 <226owobtknee4iirb7sdm3hs26u4nvytdugxgxtz23kcrx6tzg@nryescaj266u>
 <7a214bee-d184-460f-88d6-2249b9d513ba@lucifer.local>
 <djdcvn3flljlbl7pwyurpdplqxikxy6j2obj6cwcjd4znr6hwj@w3lzlvdibi2i>
 <b78e0fd8-e6b9-47c6-bec8-a44a8be242f1@gmail.com>
 <1a7be28f-c805-4092-a7dc-d71759920714@lucifer.local>
 <9ca3f5eb-e76f-4135-91d8-363851f5c3ea@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ca3f5eb-e76f-4135-91d8-363851f5c3ea@gmail.com>
X-ClientProxiedBy: LNXP265CA0017.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5e::29) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|BN0PR10MB5063:EE_
X-MS-Office365-Filtering-Correlation-Id: 99d05da1-7050-45e5-1b44-08dd9896ee6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GEIjqZUEl9TODwdlY5zqWvT18MGRe7MhK0zG/ADBIkjHplpsav34O0SV53XX?=
 =?us-ascii?Q?u8PXVqp2y+8syjQN4flE4EiOO7FmyB10kUpDAygk7ZNEY4Dp/D3PI2cZnh6w?=
 =?us-ascii?Q?heZ8qlXrsp5t5EK91OQWrkcxz8Vg2Oud/jFgPyI4wEGv7k4hcfzQWcXzb4Ir?=
 =?us-ascii?Q?9s7dDwoJJqRRlRm3/wT46d9cmtWuJAlVHtJjtlWGpJBBoBoyy+JCrGsGrjLX?=
 =?us-ascii?Q?P3ptLqaYF1zzuK/H8FWOZ65uJZ5OSKU8grTTH7cHL9LII21VwjjMEUWjOXyt?=
 =?us-ascii?Q?pgITSXtu46mHmO0lziUYINzpM9bGc2/1jB3Ub03XsrqM0XD50+gwSm+7Yfbu?=
 =?us-ascii?Q?1FuM73wB+9pDNZr2nEuZ6qxcAU+p2ybFqWaLRMyA9lQPxAVxcjnE3UNS4ciY?=
 =?us-ascii?Q?iuj6mEyyxy6FyQ/DW/mLkyMpGmnJirWde4gmiLpFuoPvIciE5a9R5wRi4AxC?=
 =?us-ascii?Q?kEo/JxaR9IZ8RYw921qLdbPHvJ6NhRJ/5plCJeFcuMCuBZgWI/ReMHQM/ie1?=
 =?us-ascii?Q?peXiDsPEujjcuNPSyfYN+I3zZRWFkK4fBLDGfd/SbmZdkS/Xi2/gHF8WDz4u?=
 =?us-ascii?Q?UeEw3Q5uCH9Kn+AhAT9SzoWMgCpXlHMLDhGQTuERV/FL1FZ/0VAj1uWwPGr4?=
 =?us-ascii?Q?LwS6f6JOjlFWeoI4jcr/YO3ck8GV0p2H7qvm/Td8vWTP+xbmJ9uApfsy7jkb?=
 =?us-ascii?Q?iqv5tWnqhhp1r7KR0hYHuNntVLAoWexWtorzKRRcsivUBDZaBq9PigG1t7Ly?=
 =?us-ascii?Q?AiAZqZGcmFUaPeroXAlW3yMHzQOpFWgwwomqQmSMmtdIEesq7Ui3sMl05DHB?=
 =?us-ascii?Q?yCVGgaDbJQJ1IXHY729D7IyROx4ATH0tdd3TxCRl7LacyALVCzVwgunALZ4B?=
 =?us-ascii?Q?Jikpq9uH4Ex2VRP27SOsW8lNKDxcAHVvj+kNOS4wDB963+jlYeOpa2a4Xv1Z?=
 =?us-ascii?Q?mmypBTaF9fnLX2ykSz2TPIw9KJvZ3Z4btJv2NM6MdkDRgDUgMvHzz/Zpom+S?=
 =?us-ascii?Q?H35fBQFpRyKqUhBqEBn4eiG32CLW2TARhWA9JFxDUuh1RCfqQLeWtV/OZuv6?=
 =?us-ascii?Q?QH5YZmbtyQX91ndNR4Xdn2ZxyeuAI6S6CHoniafm0CPJvTH6n5SfhQj7nfSy?=
 =?us-ascii?Q?VbzM22SB4gaoiJb4IucZ19Aq9SX6qPmqnmxTxrpQ27tR36zbsYgK5c40RMWV?=
 =?us-ascii?Q?p6wShSM3ZXsHJCnG+hjGf14z5RFf+qp5sQC154N0CtzSD+PZuKucndDOZKX3?=
 =?us-ascii?Q?wZuojVvbhOiPglQliY2TrN+gAxunS3eD2wUtbcwv/2v4XgS5CZio7wDefX1d?=
 =?us-ascii?Q?hKZhWvVSNfWDUN6JGutttUVZgAAhME31nZduYXWdnJRMY8fSHFTUuLFg/k6q?=
 =?us-ascii?Q?wUQns96puQzXD88+NUNZjsIBH+ZNW24GBYIjfZmcz27UulKxsA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YJMe1L/hfoFBWBP6r89HvNAR+n/rHOVcWc5TZGtBzZQZtVER3w52+pLeNaao?=
 =?us-ascii?Q?krv6s0bS6KsjlkT0Yut5ymnJwEcUh3xhV2yyOgg88HS/IlS8vR7v4XmYyxMq?=
 =?us-ascii?Q?y/1EwgYCG8vKPGWp7aCNiJ5/Oa+Nx0iQOSr+HAEtsap1lylfnTPW7yBiCEm2?=
 =?us-ascii?Q?PW1C9c77jRsS4ZwcvJYAOeTGIzMh1L2JA3iJVl+hd6ZqDQNV9FdFVEMQakao?=
 =?us-ascii?Q?Jw7j8em3ZgC+TqP/CyU4rMWZcEDs6/P1hB1myLIs0PspcDxA/NjaTn+KL+X/?=
 =?us-ascii?Q?oGiKlWNDTGVCfa1kqMTJEGu8n5yf8QNMFBvaXBLmRUHX0wlAhk2Z6xf9+hxY?=
 =?us-ascii?Q?oxWaG+LazHITixc2zFLyiSlizbRC6AV8QeL03SreJBjqI3yY76PdhLxA76wi?=
 =?us-ascii?Q?WdgwuPrrV3KhEATXiDvaOUmyjPazsOsHcZx1jeDVYJwBtNXJKn1EI6jo+x8C?=
 =?us-ascii?Q?3WtXSFwOEg7d9fPzj6EyQZkUBDo0rSTR1r/5nP2jjVqOII4yyAOIsl0/5gnz?=
 =?us-ascii?Q?+jfdXttg8+Lw1iSOkDbejRTdLhAKWF46aID8TpwwhH164Vk6xI/J8qeVO2Co?=
 =?us-ascii?Q?pB6j9M7RvIZRwXw2izkFgEGQlE9GYgRs8mah0rh+axdtrP4a/Y2TLRd/j4U8?=
 =?us-ascii?Q?YvnewkNrinokTicHJUNgeZYAC7+XBKHZ7jcQl9Z+4eYzEsHIsIcKZkIwUxps?=
 =?us-ascii?Q?PsHZ0fxTGk49s1l8RxrF5xPnva5hXy6921+DdiTQaHSZ+AlaUBAqrpU2/wsz?=
 =?us-ascii?Q?mOtCZfKCQ7AGRH+K9lV98UrMTXfvwoot3EGDuFwyJ5k7eNC4PXzJtv6YwFNe?=
 =?us-ascii?Q?ipN1oElCmEiUcLHXOTWPk1wd+6mSb8pIdgUIFIiycZXxh+1cG1TgXsB+hhf+?=
 =?us-ascii?Q?0L6jUl8fL9RCvkMICY5dZ7XX48kvoOm3Zvf/3EzX7rY4vE/aos7vsGPiQ0W0?=
 =?us-ascii?Q?eKGnu7sXfQ3LN6OJShUsNktEG7ArIBgbyvKv0SifJ35UyLakJsByXie2wu3w?=
 =?us-ascii?Q?wljyOhrndq/h6lRfqC3R6EVdHL+wUxyQTbC3v5eQ0ps6/vQpl7yJ8fbrlQc8?=
 =?us-ascii?Q?v1Qx/Gd8o/Xn8SNnDBYV8efpMJlja87GC5vJCnHfcPn7RMKqGGLzeYoizHEW?=
 =?us-ascii?Q?469K/6TaJpvPpMFJN7oQcXbjGOvyYaY/hdKudZyk8PW6vNg2xrI8P9QcTzb8?=
 =?us-ascii?Q?cKWx2Wn/kBl2oE+A4EOW4O6x2pwKH5ah/AS2QWBGipHBXIyyQEISPyuMpXmB?=
 =?us-ascii?Q?eGxj5eXv+0lLj7Q+8Bdc11KinKiV+/CSHdJVPpMAFMQ9Q9sDDNRi+2wo4zML?=
 =?us-ascii?Q?CE4gH3YR+bMxdPK/1pML0my43F7rTWYX60H81JJqFBaTO9+B5vlQfLMrPiPA?=
 =?us-ascii?Q?EHJGrfKZe4TncYIhx6+TSc/lXG++1NGmIDIhT9ZVB2BULbO3Ad62T0jFRFuf?=
 =?us-ascii?Q?qk8mE8sfhy3W17c+wNT8Umfbo6wKbymqWTIT9T3Xmau4CLH61rLCqU3hH/W8?=
 =?us-ascii?Q?96mEp6MtFdSjgDapbqenrM2VERllMOJhbAc33pywfNqJFOZw0T7WyJgTjKqX?=
 =?us-ascii?Q?V/cCAgXdYhIk1ommgl57Deq0ZrVf5qbR9n//Dty0qXYECp/wBGaRPwR+Q0VE?=
 =?us-ascii?Q?pw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LHbGSY5rvASFQX6bECfBJ2IxsQbHCP2UyBMZVahv5D2kw5Z7e0XIBs99U9J6JLeSUDEwrdiW7am5bXmba14FBWwzvvcyHUTMayVGI8rYRDPO+fPkxb5yLMvgG+YvZQiGbU0lNIeOLHBlJwcf9udpIkcRy3N/t92T0PoQ2uv9StUtwn7Y8cjPNQQNvh6ChDzAlumKFfK6hsfl8Bx4HUyHGelQsVnTQA7KjjmiOoaea85Ku0Fajc0tXPYNItUX+c1QKGYkaa1cs3GS4XxJ3PZ14ntdpsoRqGncNOAFnHyyF+1s3Q4E7TTAQdnvW+go4AYMTTYKAFaK4fXY0pdeKcmvyIgpQsxYxKtZ1QbJKNrXh3DnESTx5/DCMgYFiksN/T15u5vYRlSXMR1bji93B+sw08GVoAmowsPSelA8q/2YU8vClaU1WyYm0D8dk1cp2BXsgRFSA11cIVNS6W56nMyR+Kv4iExm+AKWd0TmUrh10sKxY2YfHfs7TxHRniWB+xp0dPf34LSgeA+jmLBVV5Q136M9GGFUX0T7H3Un1NOVMesJF9ZnbFV0ZmVlTTF5GZJZ8zQeyeUrf6Xc1vg+4aS67DZmxElImoSdFkMzRfR2e00=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99d05da1-7050-45e5-1b44-08dd9896ee6b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 18:40:16.9737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: msv/VL6G8pb7rX/Gv+5CovU7tQc9GufJDbqzTVJ/NJJ2lUFj+NhT5Ib11mjcfOKI0eSELOKciodM4m0E4BSvj8rpfDC1AaZXR+skSVq8RsA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5063
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_06,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 suspectscore=0 adultscore=0 malwarescore=0 phishscore=0 mlxlogscore=601
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505210185
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDE4NSBTYWx0ZWRfXwcIPw8K16yw7 PuHcngxIRe5Q3QkaO/+1Torht6WtYkPtOVBhyztGzrRKhkkVa5c20e/xydQMopSVeqmnNTegbQ3 VEPv/X7Sk3cb/up8Jg9jz9SaubRHmrbRlwSM8iojbX3Rx9clbT5DBmKkQWCGXxpFzWBM6ZXgNVE
 xT+SRrk0+R+r4dKzgC20Y74KZNpCjD+jM8iRaZEydxnbm93IKAvQ1TYd/A2mRhZAhTb0T/u1QY1 6FbOBbPd6IgfL4w3gyC94/B9/C6Xc+vVvaG9Izl2kMeh+XCxubxbRO6N8eSTz+KctiWzFTyS9JY IC375Isj74gHBgDAY9u4xwv/vfdkPTI9wxG/L++6m5cw+Ggf7ydhcDWgU1of+bUCTWvppOnO5O1
 L5cFFYdrtcGeGiNaEG75YJqYYEfyEDN8WMB7e0tH+nAYg2qkDl5rYM/UC7S58dmO6xs9QSwX
X-Authority-Analysis: v=2.4 cv=B5650PtM c=1 sm=1 tr=0 ts=682e1e15 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=WMZ9pnEnIIB_uqVslawA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13206
X-Proofpoint-ORIG-GUID: kQ0suz0j-SIsrhkb6ZAyJ1dXljxO-NHx
X-Proofpoint-GUID: kQ0suz0j-SIsrhkb6ZAyJ1dXljxO-NHx

I feel this will get circular. So let's not get lost in the weeds here.

Let's see what others think, and if not too much push-back I'll put out
another RFC for the mcontrol() concept and we can compare to your RFC and
use that to reach consensus if that works for you?

Thanks, Lorenzo

