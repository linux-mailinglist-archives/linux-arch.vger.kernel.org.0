Return-Path: <linux-arch+bounces-8468-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 261BD9AD054
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2024 18:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 474D81C21E6F
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2024 16:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F7C1CACF8;
	Wed, 23 Oct 2024 16:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="n/YigyHe";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="il+Yr2wK"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54BD81CEEBD;
	Wed, 23 Oct 2024 16:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729700736; cv=fail; b=HrYr5rhJTNBoZYLUQnK47B40tiDXwv7URSkWKr5X7VRTIF7FtFYHw3Epq8XbqMYovAuhZR2gtnmod+UDnAPNlvG96nAfRiLllqIV54dBoJFI3bdoq1wKgRVeCMuPUEgEM5clGKyPoV14xmyUbWNErL7gubLx4RGo8InHk6i73eM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729700736; c=relaxed/simple;
	bh=dzW7dqkkFK9SqZeQ/MXLjAOKLEhiNtQVc3EBs65U1B8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jKy7eNBYjl6h/qctJR/yxZlm+dkfN7ifh75urK5sRNuvRTMb4XI4HZLqQSM7dFd3AFFiWhMLBxSXohh9DipcKYGfiCRT0jRIEbF9rktViIbSEA18jyEbSTseV+CNQ1vXKlMaqaEnCCQV6S1wHjlioUDLraGByPC8FjRU3cEwRLw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=n/YigyHe; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=il+Yr2wK; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49NFfdNc012074;
	Wed, 23 Oct 2024 16:25:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=vgEdRzLyuHzc2anBjPO5zTNYgSoqG4gc63FTV4U/xUA=; b=
	n/YigyHeHBmU0VBwkUHxF61nZrAa5YKBaJCjyY9FxypkN1DplIpDT8Lu5Tpvrkzj
	c6fC32RbyvhTL8H+YEpGmtyt3dn+5qE4NXzi37Kt0K1lzH0J1F6zNprCnrcQ5oKY
	HRMKVZPLJfzg4581SSzjfyd07CNQmBnujCCV0ht2jZKfXjUPorBJIcJwnBquDB4w
	AfdV0BtRzBKWgn364sj7tIbSyoD9Xhhf/zZaayYL81YI18/U3lHUiaY8g8wy61hR
	wIa0rLDaGYYQZhyCT5akaD1tIb0ksOxaI3hQZsRjB5Ih6DHyBRDETF0SezB/U99I
	dCXHbuL4SpogNZTnVl4qzw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c53urht2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 16:25:05 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49NFc3C7027408;
	Wed, 23 Oct 2024 16:25:04 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2046.outbound.protection.outlook.com [104.47.58.46])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42emh3290n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 16:25:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wL4T7bcg7vvyYohT0I3q2j3qOV1sEqjt8KIICAYnmxqovP+iy4e1unetTPmyKCFxAxbqnBkkQtN9s9NLGsDomUbkDyBwMdxG3dzcuZn6e8/pfQfbD70MBej1zjnVQsmMYRCFJ5TaYH6QeRRHeilQIb9B84LGRx7OELFTjkMTxGi/O2nxcLV/jd/eacNCWbzXloabT51EVoWBZ1UjTd9smj6bzDYvfnw0Ms1HfsTnTX4+IYJw4AzruPOC063CRWvT+RVKM42DBTP+/CRe3SdSWgssEi+xKEdxhhNaBEqIAOE+GQrCTiDhY8RZL6rYbb/O+EbawoosMXrZUpzLRkaGSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vgEdRzLyuHzc2anBjPO5zTNYgSoqG4gc63FTV4U/xUA=;
 b=PRCj+QnLwufyIjD/WV3tzq37rdlSZY6NEKKQg8yWUt2eqIB9IUvnPx5BwJZTX2COABoIfrXwGTENJb116SevEOHW2B9PC4ecq+PffhFwAmRE7E5JVrQrROUfAc1OL199Dk5asE4OHcw/BpQ3C7rS1VV/qCIP5u1+fB2q+L7+l/dqTjvKDuHvvwBzfTuCwclO3YvEjTdoG5PvUnofW7wxxSc1EiVr8NhAmXb+foGWXjydlszuuOCP0AbDQ8C1060oJd1QXrZSJrT4vDl3mH2VkHM+DjizgPf7VHFB+0MtZI1gcULVraz645/SQJg/YrESmLNj3DwLx/9tzOcruEHHcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vgEdRzLyuHzc2anBjPO5zTNYgSoqG4gc63FTV4U/xUA=;
 b=il+Yr2wKdX3gnLiD6jmSWWK7vZTjCRqYmpyfOawlCnfyKVp3VeypB9ZpMU7W3aXqS1SMkaG5YGItC7R7k/KxpVupVw7cklVt7UQt3hPVgq3dEBh6kaFxABJLCryokd0qU95zBxVAvd+Zw4xSgY2KIsRdmRVmxhQmxVEHohT8zKk=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by CH3PR10MB6836.namprd10.prod.outlook.com (2603:10b6:610:14f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Wed, 23 Oct
 2024 16:25:00 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8069.024; Wed, 23 Oct 2024
 16:25:00 +0000
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
Subject: [PATCH v3 2/5] mm: add PTE_MARKER_GUARD PTE marker
Date: Wed, 23 Oct 2024 17:24:39 +0100
Message-ID: <7f81287792eef318a7a711d358c00e2e48216f15.1729699916.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1729699916.git.lorenzo.stoakes@oracle.com>
References: <cover.1729699916.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0070.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::34) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|CH3PR10MB6836:EE_
X-MS-Office365-Filtering-Correlation-Id: 465955cd-aa31-4d31-2167-08dcf37f3dd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/mq3qnNUhDJN5w2OjdtaVQWFJYr6bOdnB9gihGjSm69eQCEAAGWEwTOrEGni?=
 =?us-ascii?Q?oJnYWKB4MKhohSOKeVqoGR2HpLWAgthR6uZp9YTL+Fc2z+MjCcwjjyNEdcOs?=
 =?us-ascii?Q?IY4H5UShdD/iNLXLejDGr0ukFuvgm8xCh7SpgYiyFB+/1Uxmab7MQF5QP7/9?=
 =?us-ascii?Q?/wV+iEs+0FnAUKLotwBpX0IfjWKrBxVUV0hDPVLuuzpogvoSDhMp8X5xbTXM?=
 =?us-ascii?Q?h9TyMxmnq3ZrldIuVvlndW4QTiOQwEc8CQqCC9mGYLMPsOoQPNXYAnVAIY+5?=
 =?us-ascii?Q?MiVux8ejUtKWNEDOwu54Ho6/cTlw/ZIjhS1UdcD83m96ikWR2fo3zYaUTZo7?=
 =?us-ascii?Q?8w0lHvnQ8GMDkue7GxqUpV0iUFYol9QIurNa/A14vDWvqSY8vuSKkZCM04SO?=
 =?us-ascii?Q?oT8wT2fdo2OBoE/TMinWCNce/WospcSb6i7WE9vA/m7YVmxf9wtFXN1Q+C/u?=
 =?us-ascii?Q?PTfuWjnAJj23OoittMoTLDDlCEIAeeRL90gSWEYtMpD0SVjlqxY0ssoFu+Rp?=
 =?us-ascii?Q?w75kBDiuPsNHGUTxA+cfYGe3HRdC8xFRPlcmGAn1yENjqQyQNQdNteLpBNd8?=
 =?us-ascii?Q?Rdcrfv/it28sr4NQAFGiL3NdCis95dfcF7PuPN5aVv2MMnRPcDoIok7fQmd6?=
 =?us-ascii?Q?oEy39ZtG0pVLl53lM1TMyeViZxpjCf0jADKUcnmY+TkLUUhXW6EVNWqMW465?=
 =?us-ascii?Q?mGRzX91VEuMCvcfk+nu2MpGZCVaztGeC3xwxCutXBNPqbdI9Texnw0giaJkC?=
 =?us-ascii?Q?CD2+GPCVBVJE3X8v/uV+H5STP4KjKLwTwvFWcKjj+AGQMt39nTzRBhX5xFoY?=
 =?us-ascii?Q?5JDePUdkBSOUWmBp4CIbCUpYkvi64qc6LyR/W9a8aWPs2xIJ2silrBqut7Tc?=
 =?us-ascii?Q?ZRt6g83qcYez1P2EyGwAt+ZFbDd/0x+JwPWHhS6pFrNBN8/olrlQazTHmXxe?=
 =?us-ascii?Q?Tz7HhSt9LZq1eWp6/uRbKomSxtyicdLUiqea9SvWoPcEmpCubukdXSpXTegq?=
 =?us-ascii?Q?S4aUS/myUJYMVgxx+oQ0BP/LB3MpTsgtpH4qVsDekJMqBEIOBarULrS1542c?=
 =?us-ascii?Q?2nlcox6GoC1osnZBgAnkNJHPMs0l3KUnfsliBZRQm9T5eSkR2TuCCNG/soUK?=
 =?us-ascii?Q?CKaRxJdYAA6ogwgNcZl5uTG55SRGAP1CHAoagx8dTVrQH4NtOye6/a+FKz9G?=
 =?us-ascii?Q?asqPRxOy6OlfV/eFK8SN+BqSIN/vZO86OKR3LjbeoQJ1lwZ9gRkxiFZl/pQe?=
 =?us-ascii?Q?IfyaKXdakSQS0AIxSnq4Ht65wKGPj4vx2xMgP2Ng2wKMkZQA+aL0L/+zrsbn?=
 =?us-ascii?Q?OtU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9yJzjUE+p/vbsLN0GRGeYY5NaTBzXUhnk1VZt6Q4xtgB/UTljJO0XHXrr4OX?=
 =?us-ascii?Q?H18d6IKWQphxccFX1cJUMgfdF/os+vixwNOofIwMdcOyXv5AC3DVjDevSZpZ?=
 =?us-ascii?Q?S+ygjhLXQCaAKdDfEjWND+/ZzFatAR7IUwOLDNpbomVxRihCQCvsbPTwTHkA?=
 =?us-ascii?Q?SKh/3pMKJakV15N5H1KMqI7adR21LUc9f33xO6MKgs6z8MWOVTnlhs6iNkZG?=
 =?us-ascii?Q?y06wTCF5lXWWu3RZNmApQEn16S0L4mz+ZFppUtcQw8UDX4jeYNVJRWkCRsHJ?=
 =?us-ascii?Q?7WcM4N7WTISnT+MAJH646PSb+wJ8aGwfZGAapiJgv7n4yHw6tlwXYd1i3foD?=
 =?us-ascii?Q?0x/AM8tDO40bMzbphg3NR85/pqmURW6Z7h8ost/EShhUKeUWPsvCyiMPKBlJ?=
 =?us-ascii?Q?X+XOUVfZLV5TUF62izffR6wwTfTnYN49lr7POMYza4RUaISGcgU2PoYPJV8o?=
 =?us-ascii?Q?ZhL+1tvuP/oAsV3jV0ND+bt/GpW1ZyhuRS3C3BKPc/YFkVtTykYfHh5GS3P/?=
 =?us-ascii?Q?LbVxMDFFqa72IdoOBDFXBZ+iCVVkEL7+mMHfuR+l/WuLaPaaYlP7pmBmNccR?=
 =?us-ascii?Q?Lrx2EtFCAFVdN14ojBx6lW+73QqmklNQqFJT0zmOEdZDO/7KCCJ1NlnftYIs?=
 =?us-ascii?Q?0+dsxhIBQFeplJvVbcgEZmWiIfvmDPk+NKA7OzD2kIW6aMkW5MCjMz+9Waap?=
 =?us-ascii?Q?CSe9T+GTUAkwwOEX2TWkU4EfRgXz42zQuqVMqaEGfj4AtHYOQAt34Yrh04+C?=
 =?us-ascii?Q?T894BSudogeIjcw0uF3/d+vbNdmrFdZUI9Q0/ByefEgb9wSFhdpsIuBSamWg?=
 =?us-ascii?Q?HaVsUmPXyCibcz3xt9cZjXVpJ89j829qmPbZQ8S7RJxoVNwPz2Rwii1fZK/Q?=
 =?us-ascii?Q?d5KPjhrz2O9rRj+81EQxC1ZGnqx2fLfXUqddU9m9+Ke8HyN4gB99VlCt2JTw?=
 =?us-ascii?Q?xjNwLNyzXpt31AuSB9aCl5Nz/ZWaWp+a8WBko/L/+7TsNO+TTYDcKSJsYtty?=
 =?us-ascii?Q?817jCd1VUZ9+FAthJzRp0KjJYh4W9+fBZIjugCeIP1rZGkCQ4HohchGGPOHV?=
 =?us-ascii?Q?hWYjFcDJzE+FO0RJT/96Bc4IjM4d/Xp/jWATdLGxObkTuBo67djEGHyBifbI?=
 =?us-ascii?Q?t3OPC3U9Srb6Se/x8SWQuCV96JeFDCa7r5juYktCvZDefMR5VrBM2I1p4lIY?=
 =?us-ascii?Q?g5Mx6EREYWmBF3erZVrtHAFJA0i5zOdom4o5f9BAMtldYbAm3rlGxu08NN0z?=
 =?us-ascii?Q?to8HmgsBKsbxBH6jg+bgGCbm+AhlmbiizGTEXWacS4a183VYfipHBeSrRT6M?=
 =?us-ascii?Q?6r9Iwie+NtFNPM21YL3A38cKVl5sq7WKeqll1pm1blBtWlxbbfYJXfgclwmJ?=
 =?us-ascii?Q?k7S1pbc7KEUNbgU79zDqvCZumyR12+wiYh1XsMT2ZdISSYYinWBccBFumUoA?=
 =?us-ascii?Q?zkxxwiGutmZVuT0OaTHhzhjptL/6qnXFe9juNLR3cOpnuQzysGmaAaoS/0SC?=
 =?us-ascii?Q?Txbx1XMsj8gSCjQizocjcjP3wu8UggIq05pqTQvTyqs3RTyDHaOEDfOUwooU?=
 =?us-ascii?Q?LkWPp6z5Q+9Lq0n+Te4FveMTgk88d+QbsQAICDVWOYW2hOjxGAzNitad+uUE?=
 =?us-ascii?Q?d/O+oHMP+k2ZfYhIaL135DOrb19LRkygqAcm7IpxXMH14AXIlvZDE5rZenVL?=
 =?us-ascii?Q?1D5JZg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PjLZczK25Y7/h/Ef4ltingMLZ8Z7WIdYHRxAsQI6MhCHtMDNGHmUClHJ00EoxZCjNIqz/GrmA+bEJLgo4xlHeZo/pgthLM2nRhUgZ02bArmYNcIWEPYrzuAtiooH6w3FmGJ0Tgjyi8eM3Jqi8oZG5o1jWK+Bx4/jX7E40cy9R/KuCiLeWeGLnS4RmhVeyP3ndt/tDPcWx9chDkfuIDQN2zkwUwTprMfZkn5fXUxWdrdZmJ+ox0EdHkUkEZLh5ePlixD3UgnplxUnvsHW+Y0J540fiz87HRVPO4x9XlHLJEDL7UniRVW/k/1iyBcKDQuSLAYe+Q6GfPB52LmbW3tOBbc2x6luTq5pdfxG+rYk+M2g/VYxz53d31rlCUu+5wtM/xEtZTBR4CGCqCyK+E/o4uPV4tE23KN8//TSxV0Xte9QPyeCTrpR/BBeBSWtUZXDN2eA17UzTEVvNGFWyBHel0RgStoLAEY6cwSwXo5dSk1leCPCTOVJqZTSckIn7PGic3TYT18ZtIwdJQeY3yY3jTp7T4PlIGSNrnTzASizgc7obgWDfGupH0ls2JosS4DE/nNIue7/E0mA+ZOiOMlOia8Bk8Kb2sEpDgiKlHGILQs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 465955cd-aa31-4d31-2167-08dcf37f3dd2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 16:25:00.7223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KkLlTFvSNpT8HvhgISLYs3a2YAu+JAD0dRTWH1XuxwaG4ih3sKM0b2oSWfDSm/NnSK3hEjirM+TRGXxIOoFlpy3/Q4UnanEEFImvHKsUZIs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6836
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-23_13,2024-10-23_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 malwarescore=0 adultscore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410230095
X-Proofpoint-GUID: Qo3N_ypuxQvQZShNx9GUNmFG4Foq13m5
X-Proofpoint-ORIG-GUID: Qo3N_ypuxQvQZShNx9GUNmFG4Foq13m5

Add a new PTE marker that results in any access causing the accessing
process to segfault.

This is preferable to PTE_MARKER_POISONED, which results in the same
handling as hardware poisoned memory, and is thus undesirable for cases
where we simply wish to 'soft' poison a range.

This is in preparation for implementing the ability to specify guard pages
at the page table level, i.e. ranges that, when accessed, should cause
process termination.

Additionally, rename zap_drop_file_uffd_wp() to zap_drop_markers() - the
function checks the ZAP_FLAG_DROP_MARKER flag so naming it for this single
purpose was simply incorrect.

We then reuse the same logic to determine whether a zap should clear a
guard entry - this should only be performed on teardown and never on
MADV_DONTNEED or MADV_FREE.

We additionally add a WARN_ON_ONCE() in hugetlb logic should a guard marker
be encountered there, as we explicitly do not support this operation and
this should not occur.

Acked-by: Vlastimil Babka <vbabkba@suse.cz>
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/linux/mm_inline.h |  2 +-
 include/linux/swapops.h   | 24 +++++++++++++++++++++++-
 mm/hugetlb.c              |  4 ++++
 mm/memory.c               | 18 +++++++++++++++---
 mm/mprotect.c             |  6 ++++--
 5 files changed, 47 insertions(+), 7 deletions(-)

diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index 355cf46a01a6..1b6a917fffa4 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -544,7 +544,7 @@ static inline pte_marker copy_pte_marker(
 {
 	pte_marker srcm = pte_marker_get(entry);
 	/* Always copy error entries. */
-	pte_marker dstm = srcm & PTE_MARKER_POISONED;
+	pte_marker dstm = srcm & (PTE_MARKER_POISONED | PTE_MARKER_GUARD);
 
 	/* Only copy PTE markers if UFFD register matches. */
 	if ((srcm & PTE_MARKER_UFFD_WP) && userfaultfd_wp(dst_vma))
diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index cb468e418ea1..96f26e29fefe 100644
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -426,9 +426,19 @@ typedef unsigned long pte_marker;
  * "Poisoned" here is meant in the very general sense of "future accesses are
  * invalid", instead of referring very specifically to hardware memory errors.
  * This marker is meant to represent any of various different causes of this.
+ *
+ * Note that, when encountered by the faulting logic, PTEs with this marker will
+ * result in VM_FAULT_HWPOISON and thus regardless trigger hardware memory error
+ * logic.
  */
 #define  PTE_MARKER_POISONED			BIT(1)
-#define  PTE_MARKER_MASK			(BIT(2) - 1)
+/*
+ * Indicates that, on fault, this PTE will case a SIGSEGV signal to be
+ * sent. This means guard markers behave in effect as if the region were mapped
+ * PROT_NONE, rather than if they were a memory hole or equivalent.
+ */
+#define  PTE_MARKER_GUARD			BIT(2)
+#define  PTE_MARKER_MASK			(BIT(3) - 1)
 
 static inline swp_entry_t make_pte_marker_entry(pte_marker marker)
 {
@@ -464,6 +474,18 @@ static inline int is_poisoned_swp_entry(swp_entry_t entry)
 {
 	return is_pte_marker_entry(entry) &&
 	    (pte_marker_get(entry) & PTE_MARKER_POISONED);
+
+}
+
+static inline swp_entry_t make_guard_swp_entry(void)
+{
+	return make_pte_marker_entry(PTE_MARKER_GUARD);
+}
+
+static inline int is_guard_swp_entry(swp_entry_t entry)
+{
+	return is_pte_marker_entry(entry) &&
+		(pte_marker_get(entry) & PTE_MARKER_GUARD);
 }
 
 /*
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 906294ac85dc..2c8c5da0f5d3 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6353,6 +6353,10 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 				ret = VM_FAULT_HWPOISON_LARGE |
 				      VM_FAULT_SET_HINDEX(hstate_index(h));
 				goto out_mutex;
+			} else if (WARN_ON_ONCE(marker & PTE_MARKER_GUARD)) {
+				/* This isn't supported in hugetlb. */
+				ret = VM_FAULT_SIGSEGV;
+				goto out_mutex;
 			}
 		}
 
diff --git a/mm/memory.c b/mm/memory.c
index 0f614523b9f4..551455cd453f 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1455,7 +1455,7 @@ static inline bool should_zap_folio(struct zap_details *details,
 	return !folio_test_anon(folio);
 }
 
-static inline bool zap_drop_file_uffd_wp(struct zap_details *details)
+static inline bool zap_drop_markers(struct zap_details *details)
 {
 	if (!details)
 		return false;
@@ -1476,7 +1476,7 @@ zap_install_uffd_wp_if_needed(struct vm_area_struct *vma,
 	if (vma_is_anonymous(vma))
 		return;
 
-	if (zap_drop_file_uffd_wp(details))
+	if (zap_drop_markers(details))
 		return;
 
 	for (;;) {
@@ -1671,7 +1671,15 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 			 * drop the marker if explicitly requested.
 			 */
 			if (!vma_is_anonymous(vma) &&
-			    !zap_drop_file_uffd_wp(details))
+			    !zap_drop_markers(details))
+				continue;
+		} else if (is_guard_swp_entry(entry)) {
+			/*
+			 * Ordinary zapping should not remove guard PTE
+			 * markers. Only do so if we should remove PTE markers
+			 * in general.
+			 */
+			if (!zap_drop_markers(details))
 				continue;
 		} else if (is_hwpoison_entry(entry) ||
 			   is_poisoned_swp_entry(entry)) {
@@ -4003,6 +4011,10 @@ static vm_fault_t handle_pte_marker(struct vm_fault *vmf)
 	if (marker & PTE_MARKER_POISONED)
 		return VM_FAULT_HWPOISON;
 
+	/* Hitting a guard page is always a fatal condition. */
+	if (marker & PTE_MARKER_GUARD)
+		return VM_FAULT_SIGSEGV;
+
 	if (pte_marker_entry_uffd_wp(entry))
 		return pte_marker_handle_uffd_wp(vmf);
 
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 0c5d6d06107d..1f671b0667bd 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -236,9 +236,11 @@ static long change_pte_range(struct mmu_gather *tlb,
 			} else if (is_pte_marker_entry(entry)) {
 				/*
 				 * Ignore error swap entries unconditionally,
-				 * because any access should sigbus anyway.
+				 * because any access should sigbus/sigsegv
+				 * anyway.
 				 */
-				if (is_poisoned_swp_entry(entry))
+				if (is_poisoned_swp_entry(entry) ||
+				    is_guard_swp_entry(entry))
 					continue;
 				/*
 				 * If this is uffd-wp pte marker and we'd like
-- 
2.47.0


