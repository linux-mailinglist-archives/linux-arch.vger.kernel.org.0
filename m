Return-Path: <linux-arch+bounces-8254-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B559A2EE4
	for <lists+linux-arch@lfdr.de>; Thu, 17 Oct 2024 22:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 687A3B20D97
	for <lists+linux-arch@lfdr.de>; Thu, 17 Oct 2024 20:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE33E2281F5;
	Thu, 17 Oct 2024 20:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hlT25oPZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gzq9/D8b"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9443925779;
	Thu, 17 Oct 2024 20:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729197805; cv=fail; b=di0JyinZM5Cb4tKkGVC2BbGm2CAhEuRaq9gnCRP1dK2BFMiZ6FQGmx3+0B2cm0KH7WpLqf4Qvmcxyrd+NtX3KBwDL6NfVF0bvb5IJ/fOkMc52v/EsXpQEmLBLIymJFiuOD4uA1B+/CepNyeEIpO2McCLkZVaFZwTSOn/NoystZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729197805; c=relaxed/simple;
	bh=r1rIS4+tl2D1x4fXZD5fIAKB7CebxPDKwcDZdqEPq3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ptPP4n2ll+Uo5ACs5+N/XYuDyQAA+q7wNmWkQ8k/QbQ6y4fOPjgZBgsLd5h1xmHS6WKn/yiNWqTduAS6+HLcEx7lupG/0PFZzb1C3n7ZrcfYbM6U5YHqeOEhMt+yt16Nl8a4HycJ5Tionp6odODOAn3F0GClryzmrrX7Mj5CSMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hlT25oPZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gzq9/D8b; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49HFBvq6024561;
	Thu, 17 Oct 2024 20:42:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=0XL9Kp1iOKvA/fmdS4PltUGMSZ22lYarbZRleGRG5kI=; b=
	hlT25oPZy1L/mjEIi8zdIfEKciZwx4k39RHCN3wyKVdiX1YyKaWLEkKZRNslnwN4
	rwSDk5xO9VYPGCGb9okL3zsWcvr0WtNWfeMZTmA1PhlvN0YfrczvZFrlf7eBJeNz
	cHVSZ4IcIjUokwMJVty3ADEgqJ5/pXygG/uw0gCKXLjMpHOLJ53kCnSWY2rusRGz
	56IY5c9KV9znXEe0G21hCBBd7/h+ZqAMAhkU7qushIV/iGziFxm5vdeTg+kUxYsm
	W9d5Eq7VR1J+Xh2TndlvPmg5pX2Woa7Bvs3ytkmgNuQQFwqvOq6yjwUtbYmrKgSY
	Kv6lTGKIugKiXLxMQg+gFQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427fhcpyqv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 20:42:50 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49HKWWwc013877;
	Thu, 17 Oct 2024 20:42:49 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2042.outbound.protection.outlook.com [104.47.55.42])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fjarehs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 20:42:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dLjNnzJ5Edc1BweFrwDNAIuIlFNTilaIK5xkWGdbHkCYszr2A0ZjjAmgaOsadrfd62cFWyXRj/jGeLIPGuBCyHT5xWTJweyUcM9ZXyKCY9YKCo8HYEDhUgnyHs9aW7i/mMwN8lN7cHmVJvvYNDTPmOp1VpoVxjZ8+ipFB9UzWW11nHdVbUlPuEVxdAw3i+KFptTWKNerBbcLkRd/qNXY3+aDSCqlNkmQI5c1hWZjbKUmTjRTcTPq1Oh4x/gfeYkcujYdaxiQa48DlWXW3m4v1Bp5c8AaQo+ZSWJpdZgxJPpneB0+WEWqSwAaupkfhqC/YaAkNow6SSvIn5ZBwRhQcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0XL9Kp1iOKvA/fmdS4PltUGMSZ22lYarbZRleGRG5kI=;
 b=N1BsIwOsAUvU1+RDCIPxK8GtEkdBkPyNFVDrND31tROetjqy6V/w18EzXObkvlCSHHB1MtcKL6woh7rX7eQBox8nIYxqIJjk1r5bGf6t+EfRmN4zKI9oW61YLMkhyp7YGh9c2ZZKqifN6yB7nM6rZiJVTJJEQTvNBtlMt9Oqg8D4uW/+m05gV2rOwKZnUAXa7+wBwNQb2FGo60Bea/kUwIYK79qU3irdT64nkdhAJbDBpGU+EMA+ZSEgJw8KJji7FPVO8coFq4stHqyjVEI6zvu1LeJAXLV6wjvXLcx8nE3LVD28PGcE29lLPYZHSo3FTIz1kug7ojhnCdKMZ/YiSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0XL9Kp1iOKvA/fmdS4PltUGMSZ22lYarbZRleGRG5kI=;
 b=gzq9/D8bv/W6o7Qp8Y/kllE+/dSDIUl9plZXwBN5GbnrBuy7IXAp7D+2Pkc2jXss46YioWYh5whe6YnGssOBEEdhu1117+uHGQqkW7o6+jSBr6uTeuV2HpHuhq2vhhA0qoe6sBz5tWl2HWX6YJ97wjUEeV0bEoUYaBaO8gecJEo=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by DS7PR10MB5974.namprd10.prod.outlook.com (2603:10b6:8:9e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 20:42:46 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 20:42:46 +0000
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
        Jeff Xu <jeffxu@chromium.org>, Christoph Hellwig <hch@infradead.org>
Subject: [PATCH 1/4] mm: pagewalk: add the ability to install PTEs
Date: Thu, 17 Oct 2024 21:42:35 +0100
Message-ID: <7e246193f60298f08e5ee1f1341f780e0a6a9712.1729196871.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <cover.1729196871.git.lorenzo.stoakes@oracle.com>
References: <cover.1729196871.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0177.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:312::20) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|DS7PR10MB5974:EE_
X-MS-Office365-Filtering-Correlation-Id: 5df2e69f-e981-4e3e-0a82-08dceeec416b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?u0qkm7rjh1tD1oa6U2YqU1iEt7u0R89TrWEorHcge2iE/TtoDSwxwYkIohRA?=
 =?us-ascii?Q?rjGlhT3Q7/3UgvsSIYDxKUTyX6jovnB2rcWhO64botoInpb+r1NQNpj1ILHX?=
 =?us-ascii?Q?qF8LWfT4zoXludFjye2CO+bx9zPvkg+8TlPD3OZZcRcj8U2mj/b8ps20nI3V?=
 =?us-ascii?Q?7bNodfKb2D+yFlPJK6DF77BNDNLsgFY5niMh1bdC6G1CIO5D/b1Rymb3fQS7?=
 =?us-ascii?Q?8i47Y/86WZlaOFnBu31N6FcLsFXEAQFmMZMAsAL5GdYnTyq8j4/tqzM25Q8K?=
 =?us-ascii?Q?f590BkRyd3KpjF6qq0TYBzbWyCsbwr43P2i9OjYc0fFcgv3Rjc1GHUsF7iWv?=
 =?us-ascii?Q?GxYdDpGxSqvoLtk4fDtVxW1qo0BvrDw9z/2zxWtp2pKiN5Fh+d359EN27mk7?=
 =?us-ascii?Q?Qtth9n5LZ240pBpVeyhnGppWuk8DH//7oYgtQRLAJlb/8G0g8p4UBrAF39L1?=
 =?us-ascii?Q?kVM4EdHql2rqnIKIFDKbI5u/Y5EdaVHRO8QJhj+RGNvo//Ch6KS7gFVDfNUJ?=
 =?us-ascii?Q?f4yUrgkVx3jPfE4hDVQjjrNcxQOcWma+PuRou4d0KCFlqZvN5T3azVVv1To8?=
 =?us-ascii?Q?qSP1EkYGj8aOb9Xx0qj7JFbvYYGhgWvPH1iWhbJVT54yZk2AR3iqfnRdErhm?=
 =?us-ascii?Q?sM7JUCTAsnH+9ny7WjKXE9Os7HXRBp2hLtrnBSxMpMdGGCbkOGwey0CHYkhc?=
 =?us-ascii?Q?/6YEp/kZIZ4pJBSNcGVUDBa9zptdROAhbujroBWp7bLawlvdBF7TfUDBKj7p?=
 =?us-ascii?Q?7pLlsBpZVV2FxI33dyGDpNZfWdzcy+/RTU5iLQ7rXlOvSpbbq/7xtafs5ubp?=
 =?us-ascii?Q?dVn585+s5tXZMNddtZZ8mm/e73TsCPSVfncSpVRG54vY+rnMnaco6RSLERY+?=
 =?us-ascii?Q?dmSqPCJaCioX4lim2CL4xu6VOvFNBbCvThpwgCCzJyC9YRD3tl/E97RCqGmg?=
 =?us-ascii?Q?qFQ2UbOfBQ8GY9d1gn4wbBpwmG7MJNsLkI8PezUrby0I2ub0DHQ8JO/H7iYD?=
 =?us-ascii?Q?oelR8BhWcHyIAdeDzlXQ3PFDAO/VdQYPWT5tjQtuv/UyydKofEWhzyWzPQ8/?=
 =?us-ascii?Q?ubNxweZ5NJOccnwIIydyi1BwVwlXF1Fg8virOmBvtaztJGL/iVyxBgVbq86G?=
 =?us-ascii?Q?jWjUOybZQs0GDi0+AjQ02yEik4IfyXdV0mCgKM9gXVT8B48fPnwbNIbUXeRX?=
 =?us-ascii?Q?Hm2oDuJQLqEnO090PFcTsxAmj2DfpMNLMTyvRywgAQjrm9pLlA0lPWselLcI?=
 =?us-ascii?Q?I+wr/GABCGqVPXMCYiTaRLenb21EZ/Rq2czc7+5uUr4gNasdIjkb7G21qxac?=
 =?us-ascii?Q?F64A6n9MuEQTYURvL4rFkh1Y?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?64JICuhaT03EPmMftusg4jDlrxQV0bij5Q6Eht1U5446KTrW3X6qmP90uZsf?=
 =?us-ascii?Q?c7s6gI2NzVwaP/sfzaAQ16IO2o7NE+JmtL2EnVyC6Ab/Ny9pEAGBrjlIb4vu?=
 =?us-ascii?Q?DrSuCfaNWMfxoM5p9s/k/JjbfXqYCntQ0Z0qSnyszpQl45P7P4cBOS6guE01?=
 =?us-ascii?Q?2wlxtHwQ7j6kB/ljwTd4+h1QhdoqpfHbaagyMKOqnbSBPjJHxvXnWPptFUib?=
 =?us-ascii?Q?kYlTBiPElKxWOE1DgrASmCQwcVkUhcethqCMeDXcQC4mCXIHrHh9AE18C+Gz?=
 =?us-ascii?Q?rydSCJKXrDHi0M5y1IpYjvmEmyzP4AClxkgD4Anb2vp0KzPWs1gEAbDpI0Al?=
 =?us-ascii?Q?Ynox4hVBHAr+Sfyfjie19lcc5BXP67HBATy6S33TNdbsKC0vyk3f0SJXc5JD?=
 =?us-ascii?Q?dXgSdzobc26llTaM2tgCZEOBEC8mC4ZF9ApStgcxl2j/4aZHCu53EoH/Iof2?=
 =?us-ascii?Q?McB479EbHp/dLG/Dg7DPE+FI9ZFW+wB4mRY50VkcjGPcj+fnwzjJEdGXF7O3?=
 =?us-ascii?Q?Q4jI8W4X5N5BK9QJXu0NkQgnB3Ee+O8x5Yg5aeBECHQA+lZeXXj2gnqdJUto?=
 =?us-ascii?Q?h6ib/uGXbWk3LMSTWuHbte1mm4hsa2kk84Uc+LjCTEPx6/sHdBPy7nl+YcdL?=
 =?us-ascii?Q?eYaz2kV2F1iU6rYwJbYSSyeykkXrDXnp1n9lCVTAcIg3f/n87frCkhXFROeX?=
 =?us-ascii?Q?jUnGNyOPoq+qKwUHUgQdC/7pxbPBhMJKJz6wh0Phm7BqlUV37AhtdfKH9MGb?=
 =?us-ascii?Q?EfJ5ldq4L8YnXvqhcNJAY+lT5ZrkR4fRliU3/eGa6tpb70Ne/ZDv0BP81As+?=
 =?us-ascii?Q?xxuQhRZxiiIa3ML/SI1vG1f3p6eozeyS82PxxXcUOWPPLi0DCKem1wBiS9uu?=
 =?us-ascii?Q?V+RBfrS54kgwST2EpxVoGLL+LASlwkK1InItLTZM6sFDV3F4SFWhJhI6JAdL?=
 =?us-ascii?Q?3v69l+OzhcEEZO09riRqY9l3cp7PtFqc6vmvbaQ6CEqa3Lx54qU0oxh0Vcdy?=
 =?us-ascii?Q?POuURL1qbahQ6JyRPjvetFdM2aWoR6kLm1QBl4x3FuK7HKcHwTxbENhyPnBs?=
 =?us-ascii?Q?CHsXylzhvkRxdHUUpXGWCgqi44JgNSBYE3HgavhbaSWr/y8hiQTDDqaNPeBU?=
 =?us-ascii?Q?fRDBiztoms25DMY1reqozNVkBcO4WdrJuE0R8ms7wAOOdhNm14N/Jhf4CV/Y?=
 =?us-ascii?Q?1MMMTGLgS0/SONnZaCu8VRwqjeDOvKz01SfAeSDmhdtU0oBxHacaMAicgkUM?=
 =?us-ascii?Q?4s9M19fymIEJHCEnAEP0lUBqyZ4QlUAqs9YWy/jyw9jmC+q20t40Ris26gpu?=
 =?us-ascii?Q?XOgzc4/USl6ZeWB0JSeCyY8yPj/jT5m1JpXe8qmR/uMkQp0dSXJ9CJ9TF8H1?=
 =?us-ascii?Q?athM8pg3g9DdlxL1vYKQZEj04ixpIdudj7jXwxN5nd3gYpMWhUF9kGfcVWBV?=
 =?us-ascii?Q?iIpvyxQvhrOLFKbhBzgyh8b7+o8jNSmXcJ7OXLbbd7RWLlIIrf86JxLVq76m?=
 =?us-ascii?Q?zskN3dI0r8O0PHN4KKDQ6XukrXMPHMlBloEvG7uPLCCwt6OluOo/XfTB/e8r?=
 =?us-ascii?Q?yZ1On8TwrLOXnCzujO53GiE0kqYZ57kPit+q5peTzs0m6IkmR7V625epKdzc?=
 =?us-ascii?Q?3Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WsJ35mcqrmAk/goU3TJQOeR/93rTeZeBY8Yf26epZjd7jhTT4O84s7CV9G6yxjVOJ7pu3XIhPS9E/lT1dlOhlYgrXWuAQNYG7do0NoOUANx33bZBlqnElK01taPpcEVRyCw7u90C37LKAy7cTP2yQS+WvALGpK154YRCObEzxRF7oq0p+Uumq8IpaDuXoMuDDataVP9i74LL65HlLFR3OuH5FAV/LzxjwOOG9qZ/Z1TTrgPg1GBm2MCc092DbhDyBOqt44jPRHzI5mfRdZimNkrcnhsvA/VgGU5v8ys6T2AxiBXDWVtrhZd82biVhk1He/4xE0nNcARYukDKKwcZNR27PzFxJ64VDVI73fzLnxNwnuKbuJfkDfUPViIg2qwZix7i7hq4052+H720DDwnYFE4okgeB+CHNWKbihnKJvx8x5cdVJkrjFhxzAMX978jRC9dPSJKUbUHhp5b5e6nlhGe4h7QmkYpQY6fE04zAwJUnT+HIFySXTxiToKktQ1khTidlBQhIAhbjO/KTCJA4XeXci8jvw7FdIHJ6oZeYMRqSunv51hwFvljupiYVydtROPOftTak962bPrP7fFf+VdTdIb/qkByWfcfCEfBJVs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5df2e69f-e981-4e3e-0a82-08dceeec416b
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 20:42:46.0080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P5Su4uE3LK4b3WVzqktJH31/s43FHK+fhCowwBEDzFiJRGbcwo7UeB2Cp0IDLQdDK8qJYp7wOgTbYVJ++ric4NQjEawhOCit8E11+vzVf3Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5974
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-17_23,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410170139
X-Proofpoint-GUID: zvMkzT1Kk4r1NblzgsNfPkHZ0S4crHuO
X-Proofpoint-ORIG-GUID: zvMkzT1Kk4r1NblzgsNfPkHZ0S4crHuO

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
2.46.2


