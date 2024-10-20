Return-Path: <linux-arch+bounces-8302-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDFBA9A5516
	for <lists+linux-arch@lfdr.de>; Sun, 20 Oct 2024 18:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E056D1C20E55
	for <lists+linux-arch@lfdr.de>; Sun, 20 Oct 2024 16:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64895194AF4;
	Sun, 20 Oct 2024 16:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dY5z0y0F";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hrVNdYsP"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF35C194A48;
	Sun, 20 Oct 2024 16:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729441273; cv=fail; b=QkrY5M4Ks4VHyj0JS87n3uEG8fMoxQ2wPOTFcgv1WWqn0zAPP0aD8RT0YqSeK3j1ZaKxlUc/GHnRdLOf4H5pPceMZfliJPMGw4jefXmuF+OcNL8w3knE8ha/kVe8AAaUW0HQ3qBHUSBxHvBL/b48Ln1k4i/D0UOEpsZSARcvSa8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729441273; c=relaxed/simple;
	bh=mBdFR5iz2DIYNrryxIYiv7cPXmGutfL45fVkRBbdTbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X46Tby44M51qC9LLyYNXc6iNg4W16mDUP62hZOzMGEg1dPnPx45onod5ymWZt9xHU4o1sGocRp2p2JbP1FF29iylyFNqePawIoui3rGnQnCxrVbEPynjYQHwusyADs0ubKpfYM6yNmjYHKYAo/QnMtIdfg16gbzDChOTbed9tBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dY5z0y0F; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hrVNdYsP; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49KDCUhl012343;
	Sun, 20 Oct 2024 16:20:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=hloMDzJ7xNRqR2Ml9NixNXpGBgDEPZG6/GT48LQVgGU=; b=
	dY5z0y0FhFad+ogJ6DnCBtxrrqBdBvqowzVBs7y/Nf/gFDjri5+Zv/I4dCIfoR76
	V9TxN4EPwJllKXdhgQnK5s2Kd3aBsBNFLRZrPxQoFyilBoxKvuakr+ba2j4ltnjO
	8AHaJdB2tVK53RCozOQ0P6Hsg/8zEXgCgxwe5QSKdZQu8mfFpRlsXdJe6Lgp8x3n
	cU40AKvxwW2oR1tthDmJiQyb2MeP7q+XDkmLakv9b0lthumTons1kn81kUAWJWl0
	LEprBD92tAY76Vc2UQnXVKcqHaYuLrYAyB3aqzN8kzCIT0zeLffwcYpoV+mf5coz
	9/nNZ+jR9SPf+wivABeq3g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42ckkqs3j4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 20 Oct 2024 16:20:38 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49KEBLia026202;
	Sun, 20 Oct 2024 16:20:37 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42c375g0ax-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 20 Oct 2024 16:20:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wBeV96v/BTVN83bjrvKrzYW1/QYaK67Kv2+G25J2tEdK+WJsxphpTsX43eRyRbv6G4jUqIW6rLtYjkyX6ASOmZBXkVcrRBoppl4xMIKooDpeqaz9ybl3s6iv1StsN/NLyngPViJDswl/HKWUszbRTQddTgpxnAFDNv66K/D7xWkB6ygliAA6I7NDM/jIhPMwBtghXi1xfUwLlg5XKtJwz7olgCDYlt5tNuYCaHt7l/Ja05euWUD08vGsyiRUYPaw47kcXbkuTCjuI8MpWAH5RziH/AvGTHLPh2lUtsoNTGPMlj69NClPctZmK61tzWNRQX2j7V3ieCaCzunWDQf7ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hloMDzJ7xNRqR2Ml9NixNXpGBgDEPZG6/GT48LQVgGU=;
 b=kiNT/7t+20nz+Y5IM+IMUgUWiogE8tX6vWe3gmsgm/WkfShES9+JPJ3V/PkTiB/0F8QInGnzTMW/y0GwO5es426tFFW8PZ4FYwpkqo0l4vrqFhPjKSAYZQZyo1C/F+vaJzxYiV1GyS2qdVN7S5V8gUzll6/SUzcQIPu4oyBJNYIOuyvH87Hd9z9Yi4/c6cYxcHcJ9IPWb76iNBatZ4/8YJUJ8Kx2a0modcIgjbGL20U6e+xQfZbOe3o6JHrh7vI7vApJWi98/f6a6Ejmn9TgqyuisRVSB1Z1VSVbdh/ZZb14KNqgw9RWzm6Kmh0HIbHj4qIzrUgWyQn+BUs/J00cwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hloMDzJ7xNRqR2Ml9NixNXpGBgDEPZG6/GT48LQVgGU=;
 b=hrVNdYsPAL86mTBPHSCd/U0pHElw1KwR1efyKr2YxnYbnp6qbOaLIOHWPOwX7kzG3Cd8u9ZFzR9h5gtgMfNnHkjs0/ZizFCuFVmyjsgsBJYSb30GNn5BLEYs0/dL/E9WMekWQau+WHcE7YySPpQ84gvZ1sf9w/BUs9sO2vP9Ba4=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by DS0PR10MB6703.namprd10.prod.outlook.com (2603:10b6:8:139::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.27; Sun, 20 Oct
 2024 16:20:29 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8069.024; Sun, 20 Oct 2024
 16:20:29 +0000
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
Subject: [PATCH v2 5/5] selftests/mm: add self tests for guard page feature
Date: Sun, 20 Oct 2024 17:20:05 +0100
Message-ID: <090ed13db09bc25863a78eba902d8bf2c6534ced.1729440856.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1729440856.git.lorenzo.stoakes@oracle.com>
References: <cover.1729440856.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P302CA0033.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:317::8) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|DS0PR10MB6703:EE_
X-MS-Office365-Filtering-Correlation-Id: 922aac19-af90-47bc-9456-08dcf1231d24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?D4xXaQSzlIDDB35YscIPcP5GLcECP3un6EJGOVSP0/aB6Q73QVv1qqwT12Hd?=
 =?us-ascii?Q?TpgPKLAxcfw4K1JtmbENSwr+UU7GjoamFbnmUcFq9H8KZ8oRF3VXFqcZYEIF?=
 =?us-ascii?Q?RvWwIx0nUOMadT1j5X34R671qXczA4jCUuv8x+Z93GuVVW0W5zR21doT3liR?=
 =?us-ascii?Q?5/dwLxwk3eAksqMjCz13rQvzJZwURImUzM5guKGlIOFh74vQHeRs1t3E+LcY?=
 =?us-ascii?Q?AteNAxSi5sOA6Z6d1xhF6ZL8l+LSbRXHv6T7wajBnxzuA8xf7meTnrKs6jtQ?=
 =?us-ascii?Q?XD0i93LH3CLj11EB5A6aDWVEEtjnqva9n4VjGvbeO/NxTqgEaHb+pXi3ojT/?=
 =?us-ascii?Q?hQSbT5AZ5IVyQsKOb7D7LvXBizwDO9xw2ZoXmjhR8wSDqPKWmWzTdKlpZGR7?=
 =?us-ascii?Q?A2QMEiWxkDAyAEGoocMvIEIPbQnIobqOVJO5c4+rwg9AQ2lHCBdzBkGkYH9g?=
 =?us-ascii?Q?rsU0nBWvjr5zNlTjELME4VAP4JFKG27pFmXL8gfN003/0bplCD2zTPmkB/l/?=
 =?us-ascii?Q?OL6GrphS2kCIaf/Du1fdyv+6FbyXL8MoxYFLXG333HNV+WNMKbDDT9ZaFQ+i?=
 =?us-ascii?Q?0SbYHZudwe2+ONPvzKRGeaRWq8IvBLxouBkdIhJWhdWoDoO0SawcLaUDtxDA?=
 =?us-ascii?Q?qrWuybdJLJeVQu5JI8VDAbEeG8X284iE7MQozZDzGWCKE4oi3Ol28hFWilqq?=
 =?us-ascii?Q?J6B4SeAmto5K/6Tqf4UOODq6ApSKyNDtupH1Lf1LbDQWKEYiLDP9FqO0lsiH?=
 =?us-ascii?Q?eQYwwQbEHmAxUEVkwXonq8YT27OIe8BFRNxekWXedvZ3EFgYe8zASk8SbfQt?=
 =?us-ascii?Q?uYOpvhFh1zgdlDiO4dp+9nooIPgRXiRzxjEHcUFloNeZ9AJjGZjyos12Q+mx?=
 =?us-ascii?Q?YFTHbKMOQlyxQlRWVemBlftA+L9UbMFpIi2I4br9P6dWeaQ1RSHVvyhs6lvf?=
 =?us-ascii?Q?EButeORBsJWv1m6aOPLMaiHqFgKp6bQ57KQr15ajQ9s+Jmx6EesJYc4A/lu2?=
 =?us-ascii?Q?Cp21V5bW/eKh3Mg4Owb679LrkBAREAZeBn3nVpoR/dvuqkNgR+Q2yyGlFXb1?=
 =?us-ascii?Q?h7UN/vkNJ8ZmFH8dF2ym+L6srC5/0G312TzutrnKJCs5rB1+ZJH3ktq+3H9G?=
 =?us-ascii?Q?e4RFcSNw+knYdVD+AzQyVaWd2aUq9jqfayGIMjw+iY3AYaxz4cd6HJTvhkYD?=
 =?us-ascii?Q?vkp7w/cWVuTJo61fBtjxinDhntZBnEBRg1PtwMmdRDdojUfUDlXjwDnT6qOe?=
 =?us-ascii?Q?D3qU5y151eR8QPBPdthGkISnRoj3I6bxxRmNyUwGGIRq9xpiUYqJrilhbhPg?=
 =?us-ascii?Q?FgB96f6RBy8tLq73DcrIOTWK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CzyG5i8RgCOM9HsxPJoMWLgxMpm7IihBe4Hlpz45I1HfsOPg0gfgoyjF4OQU?=
 =?us-ascii?Q?GSYVL7+DKqrQEXKiN9+G2FkeGbZ+yv2HQqn+CqZOWqnWyuhRTJeIB9WPXG5a?=
 =?us-ascii?Q?CT0QQ4p68OLpLYAZcPo+x9qrST0e9Lp9ssJLn4Gzv42ft6BlM2Olefl7onyG?=
 =?us-ascii?Q?PXmQptbEtGjLen/OThMzXcHyh6u8wY5Zv/PcD9ZioXmBF+J5O65k5FLqpWoY?=
 =?us-ascii?Q?zzigUPD3pYdHNx/oinooUE3ajLDLpGP73AZJ8ImhiPJ7K869MyhgFbWfPSlc?=
 =?us-ascii?Q?WCX3pjdISqQqh4/Hx+OzDoccTRS2NecwZuWa3qRFEby5s/Mi1DxD9OZfd1nn?=
 =?us-ascii?Q?2ZIFLoCaYZcBfOZmPmseQw6AOSuOjttP/8umq6P8onG+Q1v8xEUZN9Z4vfu6?=
 =?us-ascii?Q?DHtHgWBPgf2Z39MpTHaT/+amCytxeBZIdTki4RM70wkp/YuD9ZkpXwEbnUha?=
 =?us-ascii?Q?TK06N5XWgybyaTNTqmb+IXONdIb5oQytimnd60uiKU2jgg8Cx0pNlR1xwq+x?=
 =?us-ascii?Q?ts8LzcK1GoB9QUF3SZeo4j4TXMdwm+hFMjSRE4ovQK1PV/4bdrJoXWrLUdEV?=
 =?us-ascii?Q?0R8gMTsSsQeI7czs2Qecvc64xEqPg2+YAzHy6v3hOnyJjFw00P81zQ8U7nGV?=
 =?us-ascii?Q?jEEE4OFQS/PBdKvZWSfJNRX6/sd2xZMI/ZE9VX5It5sGQQ/uSj7QCkHXDocO?=
 =?us-ascii?Q?QsqsVGCizXW3NR1f+s/ub/8qL6yT6FdD+vK8SPdfFt0yc2QOrGwHtMO6+oMe?=
 =?us-ascii?Q?8/vHtUDWcj+7gn0Fs5vCUElEXdseVuhHzpbg2Ik8fDvTneIk5OT47n0HB1zd?=
 =?us-ascii?Q?v/6sjYy3ETJxrrY3IyQEK7JnBDNYZmfHy74kMpz26l30gYrLwb2gEdSPQDgm?=
 =?us-ascii?Q?efrxMC9Bhi+y25KoT9fHrBW9YoAkxBYeoBi7/xxZc/5SrTcurULo3GQUuPuL?=
 =?us-ascii?Q?afKVu1PJ1FZXzxniOrmekC2kxbYGLo/CSrZzQpQH+AUMkrzsvbWXZ3zw6H0L?=
 =?us-ascii?Q?dgg18Ue9WCPlFvbjwxVEnHEA7AmiP6XuoESa/5Ajb1mkG+RiJJ3Snfd7eeJO?=
 =?us-ascii?Q?YFWXJlCpe8r9AAgFmWPp4YRuKBKS+KOTOf5chVE+mtXKuHLSV+a48agAFwCf?=
 =?us-ascii?Q?88KaU61DM5HajCLQn/IG2Hx2vwjaN1XGXTs7mksX92rLIn3sQO5dfvi95DU4?=
 =?us-ascii?Q?Pou0TXg5cWpjSElvUqawS93vcFIW1zsjQONU623o3gfC84chHZiMkphDhc/2?=
 =?us-ascii?Q?PuNF0x6N1/ui4oL9gUM3IU6yW+60DyT+3fNEMAphONySJ0GKhqazMDXSrLGY?=
 =?us-ascii?Q?3O2NpEZvv41gSgUgx2KTJtGM0/SchnKSpmShsWkhy/L8pbMFQCYhBQ4zLg12?=
 =?us-ascii?Q?KXRzcKCXzvf0rgzr4uotspy4SFj2WgkmdIAcXUJ2pcPsKkno15fSfOJcpFno?=
 =?us-ascii?Q?fXdZCpl1zigUCNUVgbd9+a8DzKz8SdZMYPXtwwcEP3tVBdobnX68ZjkcSlUw?=
 =?us-ascii?Q?HaXmdmNcOEST1ZpFdvpfI8EjcaO1dfMkXDlLPQ84BZvjcqJbEYv1YORydJCo?=
 =?us-ascii?Q?XRYmcyYgczr/LAfPDsndsRu35md+vslU7S6YfJdpVVcZbL50fTmG6VptF9ep?=
 =?us-ascii?Q?2sAPh4kmM02KTTkC+9wJwwXOt3wdnUl+c/I8Byy1ClytWMVwvEqdsmehdpYI?=
 =?us-ascii?Q?Dw9Geg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5iEN5peKuHkjXOQ56zqcgJ9b0ou0p9R7sakS9+tj2rycfnEFKBDRW/21BceQkv+pIZYFffrb2DYNtW5JzrDj7qs53uKOgXJhnoV0FG048W4q8c8oVV0HDCEgXnV+kQmFFjsJIXHc/qZiEjHQZh7oMK81TU+DqSSBx5ssWmJhFMP1Bhw4esq6JP9CydHQldWzx/HaHmFxHPoYstQ9nmmXPdvvTX3ufJr2J41bjjo1la2Du9J2wM7heucNhbaywK1AllmykqYof6Ug6/6xArg3ZJC/EFWSLuhazShpLY7VLd1lxdXKjztEUHEZYh9/uFHrkFzmOjLjCxsehfLTYbLFJ5UigbJhTnqqIjAxuZ/3JO91g/bs0b29rrrcUn354LcMUn7SGN5w8AcpADaZHhDiRMzuVJdyZ1f0DcNfk8m6NBvDUY6me7oNfpsHmMrzVBFRlmEsK4iYTBp2E57M1vhlaebzyQBzAikt0GnpYhWPZB/owSdqqRlHJY8LMGiOZwt83Mpo1feZHk88SkqEcTD77+mVZ3HsNhH9aWYJtQMfwZCDBXz078xlJnO7K5YNX+n1FVhXz/UjZKRnqkO+hmw0Uu5kCX11+vRUWrrwwUHD/bQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 922aac19-af90-47bc-9456-08dcf1231d24
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2024 16:20:29.7943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EH9Tyddj/0mrn/DqeXu+cIQycrZVAAlTIiCkc2R3tS9qJwfkWav7zFzhlFwWQyXTXhS1AC9Sf2t0QaopC5LcnzG8Y7MAnOvCF0XT0+O6fAU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6703
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-20_14,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=0
 spamscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410200114
X-Proofpoint-GUID: pmfcAVRKClJfSxpY9KvG6fhYh5OpGPap
X-Proofpoint-ORIG-GUID: pmfcAVRKClJfSxpY9KvG6fhYh5OpGPap

Utilise the kselftest harmness to implement tests for the guard page
implementation.

We start by implement basic tests asserting that guard pages can be
established (poisoned), cleared (remedied) and that touching poisoned pages
result in SIGSEGV. We also assert that, in remedying a range, non-poison
pages remain intact.

We then examine different operations on regions containing poison markers
behave to ensure correct behaviour:

* Operations over multiple VMAs operate as expected.
* Invoking MADV_GUARD_POISION / MADV_GUARD_REMEDY via process_madvise() in
  batches works correctly.
* Ensuring that munmap() correctly tears down poison markers.
* Using mprotect() to adjust protection bits does not in any way override
  or cause issues with poison markers.
* Ensuring that splitting and merging VMAs around poison markers causes no
  issue - i.e. that a marker which 'belongs' to one VMA can function just
  as well 'belonging' to another.
* Ensuring that madvise(..., MADV_DONTNEED) does not remove poison markers.
* Ensuring that mlock()'ing a range containing poison markers does not
  cause issues.
* Ensuring that mremap() can move a poisoned range and retain poison
  markers.
* Ensuring that mremap() can expand a poisoned range and retain poison
  markers (perhaps moving the range).
* Ensuring that mremap() can shrink a poisoned range and retain poison
  markers.
* Ensuring that forking a process correctly retains poison markers.
* Ensuring that forking a VMA with VM_WIPEONFORK set behaves sanely.
* Ensuring that lazyfree simply clears poison markers.
* Ensuring that userfaultfd can co-exist with guard pages.
* Ensuring that madvise(..., MADV_POPULATE_READ) and
  madvise(..., MADV_POPULATE_WRITE) error out when encountering
  poison markers.
* Ensuring that madvise(..., MADV_COLD) and madvise(..., MADV_PAGEOUT) do
  not remove poison markers.

If any test is unable to be run due to lack of permissions, that test is
skipped.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 tools/testing/selftests/mm/.gitignore    |    1 +
 tools/testing/selftests/mm/Makefile      |    1 +
 tools/testing/selftests/mm/guard-pages.c | 1228 ++++++++++++++++++++++
 3 files changed, 1230 insertions(+)
 create mode 100644 tools/testing/selftests/mm/guard-pages.c

diff --git a/tools/testing/selftests/mm/.gitignore b/tools/testing/selftests/mm/.gitignore
index 689bbd520296..8f01f4da1c0d 100644
--- a/tools/testing/selftests/mm/.gitignore
+++ b/tools/testing/selftests/mm/.gitignore
@@ -54,3 +54,4 @@ droppable
 hugetlb_dio
 pkey_sighandler_tests_32
 pkey_sighandler_tests_64
+guard-pages
diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index 02e1204971b0..15c734d6cfec 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -79,6 +79,7 @@ TEST_GEN_FILES += hugetlb_fault_after_madv
 TEST_GEN_FILES += hugetlb_madv_vs_map
 TEST_GEN_FILES += hugetlb_dio
 TEST_GEN_FILES += droppable
+TEST_GEN_FILES += guard-pages
 
 ifneq ($(ARCH),arm64)
 TEST_GEN_FILES += soft-dirty
diff --git a/tools/testing/selftests/mm/guard-pages.c b/tools/testing/selftests/mm/guard-pages.c
new file mode 100644
index 000000000000..f67d2700d44a
--- /dev/null
+++ b/tools/testing/selftests/mm/guard-pages.c
@@ -0,0 +1,1228 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#define _GNU_SOURCE
+#include "../kselftest_harness.h"
+#include <asm-generic/mman.h> /* Force the import of the tools version. */
+#include <assert.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <linux/userfaultfd.h>
+#include <setjmp.h>
+#include <signal.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/ioctl.h>
+#include <sys/mman.h>
+#include <sys/syscall.h>
+#include <sys/uio.h>
+#include <unistd.h>
+
+/*
+ * Ignore the checkpatch warning, as per the C99 standard, section 7.14.1.1:
+ *
+ * "If the signal occurs other than as the result of calling the abort or raise
+ *  function, the behavior is undefined if the signal handler refers to any
+ *  object with static storage duration other than by assigning a value to an
+ *  object declared as volatile sig_atomic_t"
+ */
+static volatile sig_atomic_t signal_jump_set;
+static sigjmp_buf signal_jmp_buf;
+
+/*
+ * Ignore the checkpatch warning, we must read from x but don't want to do
+ * anything with it in order to trigger a read page fault. We therefore must use
+ * volatile to stop the compiler from optimising this away.
+ */
+#define FORCE_READ(x) (*(volatile typeof(x) *)x)
+
+static int userfaultfd(int flags)
+{
+	return syscall(SYS_userfaultfd, flags);
+}
+
+static void handle_fatal(int c)
+{
+	if (!signal_jump_set)
+		return;
+
+	siglongjmp(signal_jmp_buf, c);
+}
+
+static int pidfd_open(pid_t pid, unsigned int flags)
+{
+	return syscall(SYS_pidfd_open, pid, flags);
+}
+
+/*
+ * Enable our signal catcher and try to read/write the specified buffer. The
+ * return value indicates whether the read/write succeeds without a fatal
+ * signal.
+ */
+static bool try_access_buf(char *ptr, bool write)
+{
+	bool failed;
+
+	/* Tell signal handler to jump back here on fatal signal. */
+	signal_jump_set = true;
+	/* If a fatal signal arose, we will jump back here and failed is set. */
+	failed = sigsetjmp(signal_jmp_buf, 0) != 0;
+
+	if (!failed) {
+		if (write)
+			*ptr = 'x';
+		else
+			FORCE_READ(ptr);
+	}
+
+	signal_jump_set = false;
+	return !failed;
+}
+
+/* Try and read from a buffer, return true if no fatal signal. */
+static bool try_read_buf(char *ptr)
+{
+	return try_access_buf(ptr, false);
+}
+
+/* Try and write to a buffer, return true if no fatal signal. */
+static bool try_write_buf(char *ptr)
+{
+	return try_access_buf(ptr, true);
+}
+
+/*
+ * Try and BOTH read from AND write to a buffer, return true if BOTH operations
+ * succeed.
+ */
+static bool try_read_write_buf(char *ptr)
+{
+	return try_read_buf(ptr) && try_write_buf(ptr);
+}
+
+FIXTURE(guard_pages)
+{
+	unsigned long page_size;
+};
+
+FIXTURE_SETUP(guard_pages)
+{
+	struct sigaction act = {
+		.sa_handler = &handle_fatal,
+		.sa_flags = SA_NODEFER,
+	};
+
+	sigemptyset(&act.sa_mask);
+	if (sigaction(SIGSEGV, &act, NULL))
+		ksft_exit_fail_perror("sigaction");
+
+	self->page_size = (unsigned long)sysconf(_SC_PAGESIZE);
+};
+
+FIXTURE_TEARDOWN(guard_pages)
+{
+	struct sigaction act = {
+		.sa_handler = SIG_DFL,
+		.sa_flags = SA_NODEFER,
+	};
+
+	sigemptyset(&act.sa_mask);
+	sigaction(SIGSEGV, &act, NULL);
+}
+
+TEST_F(guard_pages, basic)
+{
+	const unsigned long NUM_PAGES = 10;
+	const unsigned long page_size = self->page_size;
+	char *ptr;
+	int i;
+
+	ptr = mmap(NULL, NUM_PAGES * page_size, PROT_READ | PROT_WRITE,
+		   MAP_PRIVATE | MAP_ANON, -1, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+
+	/* Trivially assert we can touch the first page. */
+	ASSERT_TRUE(try_read_write_buf(ptr));
+
+	ASSERT_EQ(madvise(ptr, page_size, MADV_GUARD_POISON), 0);
+
+	/* Establish that 1st page SIGSEGV's. */
+	ASSERT_FALSE(try_read_write_buf(ptr));
+
+	/* Ensure we can touch everything else.*/
+	for (i = 1; i < NUM_PAGES; i++) {
+		char *curr = &ptr[i * page_size];
+
+		ASSERT_TRUE(try_read_write_buf(curr));
+	}
+
+	/* Establish a guard page at the end of the mapping. */
+	ASSERT_EQ(madvise(&ptr[(NUM_PAGES - 1) * page_size], page_size,
+			  MADV_GUARD_POISON), 0);
+
+	/* Check that both guard pages result in SIGSEGV. */
+	ASSERT_FALSE(try_read_write_buf(ptr));
+	ASSERT_FALSE(try_read_write_buf(&ptr[(NUM_PAGES - 1) * page_size]));
+
+	/* Unpoison the first. */
+	ASSERT_FALSE(madvise(ptr, page_size, MADV_GUARD_UNPOISON));
+
+	/* Make sure we can touch it. */
+	ASSERT_TRUE(try_read_write_buf(ptr));
+
+	/* Unpoison the last. */
+	ASSERT_FALSE(madvise(&ptr[(NUM_PAGES - 1) * page_size], page_size,
+			     MADV_GUARD_UNPOISON));
+
+	/* Make sure we can touch it. */
+	ASSERT_TRUE(try_read_write_buf(&ptr[(NUM_PAGES - 1) * page_size]));
+
+	/*
+	 *  Test setting a _range_ of pages, namely the first 3. The first of
+	 *  these be faulted in, so this also tests that we can poison backed
+	 *  pages.
+	 */
+	ASSERT_EQ(madvise(ptr, 3 * page_size, MADV_GUARD_POISON), 0);
+
+	/* Make sure they are all poisoned. */
+	for (i = 0; i < 3; i++) {
+		char *curr = &ptr[i * page_size];
+
+		ASSERT_FALSE(try_read_write_buf(curr));
+	}
+
+	/* Make sure the rest are not. */
+	for (i = 3; i < NUM_PAGES; i++) {
+		char *curr = &ptr[i * page_size];
+
+		ASSERT_TRUE(try_read_write_buf(curr));
+	}
+
+	/* Unpoison them. */
+	ASSERT_EQ(madvise(ptr, NUM_PAGES * page_size, MADV_GUARD_UNPOISON), 0);
+
+	/* Now make sure we can touch everything. */
+	for (i = 0; i < NUM_PAGES; i++) {
+		char *curr = &ptr[i * page_size];
+
+		ASSERT_TRUE(try_read_write_buf(curr));
+	}
+
+	/* Now unpoison everything, make sure we don't remove existing entries */
+	ASSERT_EQ(madvise(ptr, NUM_PAGES * page_size, MADV_GUARD_UNPOISON), 0);
+
+	for (i = 0; i < NUM_PAGES * page_size; i += page_size) {
+		char chr = ptr[i];
+
+		ASSERT_EQ(chr, 'x');
+	}
+
+	ASSERT_EQ(munmap(ptr, NUM_PAGES * page_size), 0);
+}
+
+/* Assert that operations applied across multiple VMAs work as expected. */
+TEST_F(guard_pages, multi_vma)
+{
+	const unsigned long page_size = self->page_size;
+	char *ptr_region, *ptr, *ptr1, *ptr2, *ptr3;
+	int i;
+
+	/* Reserve a 100 page region over which we can install VMAs. */
+	ptr_region = mmap(NULL, 100 * page_size, PROT_NONE,
+			  MAP_ANON | MAP_PRIVATE, -1, 0);
+	ASSERT_NE(ptr_region, MAP_FAILED);
+
+	/* Place a VMA of 10 pages size at the start of the region. */
+	ptr1 = mmap(ptr_region, 10 * page_size, PROT_READ | PROT_WRITE,
+		    MAP_FIXED | MAP_ANON | MAP_PRIVATE, -1, 0);
+	ASSERT_NE(ptr1, MAP_FAILED);
+
+	/* Place a VMA of 5 pages size 50 pages into the region. */
+	ptr2 = mmap(&ptr_region[50 * page_size], 5 * page_size,
+		    PROT_READ | PROT_WRITE,
+		    MAP_FIXED | MAP_ANON | MAP_PRIVATE, -1, 0);
+	ASSERT_NE(ptr2, MAP_FAILED);
+
+	/* Place a VMA of 20 pages size at the end of the region. */
+	ptr3 = mmap(&ptr_region[80 * page_size], 20 * page_size,
+		    PROT_READ | PROT_WRITE,
+		    MAP_FIXED | MAP_ANON | MAP_PRIVATE, -1, 0);
+	ASSERT_NE(ptr3, MAP_FAILED);
+
+	/* Unmap gaps. */
+	ASSERT_EQ(munmap(&ptr_region[10 * page_size], 40 * page_size), 0);
+	ASSERT_EQ(munmap(&ptr_region[55 * page_size], 25 * page_size), 0);
+
+	/*
+	 * We end up with VMAs like this:
+	 *
+	 * 0    10 .. 50   55 .. 80   100
+	 * [---]      [---]      [---]
+	 */
+
+	/* Now poison the whole range and make sure all VMAs are poisoned. */
+
+	/*
+	 * madvise() is certifiable and lets you perform operations over gaps,
+	 * everything works, but it indicates an error and errno is set to
+	 * -ENOMEM. Also if anything runs out of memory it is set to
+	 * -ENOMEM. You are meant to guess which is which.
+	 */
+	ASSERT_EQ(madvise(ptr_region, 100 * page_size, MADV_GUARD_POISON), -1);
+	ASSERT_EQ(errno, ENOMEM);
+
+	for (i = 0; i < 10; i++) {
+		char *curr = &ptr1[i * page_size];
+
+		ASSERT_FALSE(try_read_write_buf(curr));
+	}
+
+	for (i = 0; i < 5; i++) {
+		char *curr = &ptr2[i * page_size];
+
+		ASSERT_FALSE(try_read_write_buf(curr));
+	}
+
+	for (i = 0; i < 20; i++) {
+		char *curr = &ptr3[i * page_size];
+
+		ASSERT_FALSE(try_read_write_buf(curr));
+	}
+
+	/* Now unpoison the range and assert the opposite. */
+
+	ASSERT_EQ(madvise(ptr_region, 100 * page_size, MADV_GUARD_UNPOISON), -1);
+	ASSERT_EQ(errno, ENOMEM);
+
+	for (i = 0; i < 10; i++) {
+		char *curr = &ptr1[i * page_size];
+
+		ASSERT_TRUE(try_read_write_buf(curr));
+	}
+
+	for (i = 0; i < 5; i++) {
+		char *curr = &ptr2[i * page_size];
+
+		ASSERT_TRUE(try_read_write_buf(curr));
+	}
+
+	for (i = 0; i < 20; i++) {
+		char *curr = &ptr3[i * page_size];
+
+		ASSERT_TRUE(try_read_write_buf(curr));
+	}
+
+	/* Now map incompatible VMAs in the gaps. */
+	ptr = mmap(&ptr_region[10 * page_size], 40 * page_size,
+		   PROT_READ | PROT_WRITE | PROT_EXEC,
+		   MAP_FIXED | MAP_ANON | MAP_PRIVATE, -1, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+	ptr = mmap(&ptr_region[55 * page_size], 25 * page_size,
+		   PROT_READ | PROT_WRITE | PROT_EXEC,
+		   MAP_FIXED | MAP_ANON | MAP_PRIVATE, -1, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+
+	/*
+	 * We end up with VMAs like this:
+	 *
+	 * 0    10 .. 50   55 .. 80   100
+	 * [---][xxxx][---][xxxx][---]
+	 *
+	 * Where 'x' signifies VMAs that cannot be merged with those adjacent to
+	 * them.
+	 */
+
+	/* Multiple VMAs adjacent to one another should result in no error. */
+	ASSERT_EQ(madvise(ptr_region, 100 * page_size, MADV_GUARD_POISON), 0);
+	for (i = 0; i < 100; i++) {
+		char *curr = &ptr_region[i * page_size];
+
+		ASSERT_FALSE(try_read_write_buf(curr));
+	}
+	ASSERT_EQ(madvise(ptr_region, 100 * page_size, MADV_GUARD_UNPOISON), 0);
+	for (i = 0; i < 100; i++) {
+		char *curr = &ptr_region[i * page_size];
+
+		ASSERT_TRUE(try_read_write_buf(curr));
+	}
+
+	/* Cleanup. */
+	ASSERT_EQ(munmap(ptr_region, 100 * page_size), 0);
+}
+
+/*
+ * Assert that batched operations performed using process_madvise() work as
+ * expected.
+ */
+TEST_F(guard_pages, process_madvise)
+{
+	const unsigned long page_size = self->page_size;
+	pid_t pid = getpid();
+	int pidfd = pidfd_open(pid, 0);
+	char *ptr_region, *ptr1, *ptr2, *ptr3;
+	ssize_t count;
+	struct iovec vec[6];
+
+	ASSERT_NE(pidfd, -1);
+
+	/* Reserve region to map over. */
+	ptr_region = mmap(NULL, 100 * page_size, PROT_NONE,
+			  MAP_ANON | MAP_PRIVATE, -1, 0);
+	ASSERT_NE(ptr_region, MAP_FAILED);
+
+	/* 10 pages offset 1 page into reserve region. */
+	ptr1 = mmap(&ptr_region[page_size], 10 * page_size,
+		    PROT_READ | PROT_WRITE,
+		    MAP_FIXED | MAP_ANON | MAP_PRIVATE, -1, 0);
+	ASSERT_NE(ptr1, MAP_FAILED);
+	/* We want poison markers at start/end of each VMA. */
+	vec[0].iov_base = ptr1;
+	vec[0].iov_len = page_size;
+	vec[1].iov_base = &ptr1[9 * page_size];
+	vec[1].iov_len = page_size;
+
+	/* 5 pages offset 50 pages into reserve region. */
+	ptr2 = mmap(&ptr_region[50 * page_size], 5 * page_size,
+		    PROT_READ | PROT_WRITE,
+		    MAP_FIXED | MAP_ANON | MAP_PRIVATE, -1, 0);
+	ASSERT_NE(ptr2, MAP_FAILED);
+	vec[2].iov_base = ptr2;
+	vec[2].iov_len = page_size;
+	vec[3].iov_base = &ptr2[4 * page_size];
+	vec[3].iov_len = page_size;
+
+	/* 20 pages offset 79 pages into reserve region. */
+	ptr3 = mmap(&ptr_region[79 * page_size], 20 * page_size,
+		    PROT_READ | PROT_WRITE,
+		    MAP_FIXED | MAP_ANON | MAP_PRIVATE, -1, 0);
+	ASSERT_NE(ptr3, MAP_FAILED);
+	vec[4].iov_base = ptr3;
+	vec[4].iov_len = page_size;
+	vec[5].iov_base = &ptr3[19 * page_size];
+	vec[5].iov_len = page_size;
+
+	/* Free surrounding VMAs. */
+	ASSERT_EQ(munmap(ptr_region, page_size), 0);
+	ASSERT_EQ(munmap(&ptr_region[11 * page_size], 39 * page_size), 0);
+	ASSERT_EQ(munmap(&ptr_region[55 * page_size], 24 * page_size), 0);
+	ASSERT_EQ(munmap(&ptr_region[99 * page_size], page_size), 0);
+
+	/* Now poison in one step. */
+	count = process_madvise(pidfd, vec, 6, MADV_GUARD_POISON, 0);
+
+	/* OK we don't have permission to do this, skip. */
+	if (count == -1 && errno == EPERM)
+		ksft_exit_skip("No process_madvise() permissions, try running as root.\n");
+
+	/* Returns the number of bytes advised. */
+	ASSERT_EQ(count, 6 * page_size);
+
+	/* Now make sure the poisoning was applied. */
+
+	ASSERT_FALSE(try_read_write_buf(ptr1));
+	ASSERT_FALSE(try_read_write_buf(&ptr1[9 * page_size]));
+
+	ASSERT_FALSE(try_read_write_buf(ptr2));
+	ASSERT_FALSE(try_read_write_buf(&ptr2[4 * page_size]));
+
+	ASSERT_FALSE(try_read_write_buf(ptr3));
+	ASSERT_FALSE(try_read_write_buf(&ptr3[19 * page_size]));
+
+	/* Now do the same with unpoison... */
+	count = process_madvise(pidfd, vec, 6, MADV_GUARD_UNPOISON, 0);
+
+	/* ...and everything should now succeed. */
+
+	ASSERT_TRUE(try_read_write_buf(ptr1));
+	ASSERT_TRUE(try_read_write_buf(&ptr1[9 * page_size]));
+
+	ASSERT_TRUE(try_read_write_buf(ptr2));
+	ASSERT_TRUE(try_read_write_buf(&ptr2[4 * page_size]));
+
+	ASSERT_TRUE(try_read_write_buf(ptr3));
+	ASSERT_TRUE(try_read_write_buf(&ptr3[19 * page_size]));
+
+	/* Cleanup. */
+	ASSERT_EQ(munmap(ptr1, 10 * page_size), 0);
+	ASSERT_EQ(munmap(ptr2, 5 * page_size), 0);
+	ASSERT_EQ(munmap(ptr3, 20 * page_size), 0);
+	close(pidfd);
+}
+
+/* Assert that unmapping ranges does not leave poison behind. */
+TEST_F(guard_pages, munmap)
+{
+	const unsigned long page_size = self->page_size;
+	char *ptr, *ptr_new1, *ptr_new2;
+
+	ptr = mmap(NULL, 10 * page_size, PROT_READ | PROT_WRITE,
+		   MAP_ANON | MAP_PRIVATE, -1, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+
+	/* Poison first and last pages. */
+	ASSERT_EQ(madvise(ptr, page_size, MADV_GUARD_POISON), 0);
+	ASSERT_EQ(madvise(&ptr[9 * page_size], page_size, MADV_GUARD_POISON), 0);
+
+	/* Assert that they are poisoned. */
+	ASSERT_FALSE(try_read_write_buf(ptr));
+	ASSERT_FALSE(try_read_write_buf(&ptr[9 * page_size]));
+
+	/* Unmap them. */
+	ASSERT_EQ(munmap(ptr, page_size), 0);
+	ASSERT_EQ(munmap(&ptr[9 * page_size], page_size), 0);
+
+	/* Map over them.*/
+	ptr_new1 = mmap(ptr, page_size, PROT_READ | PROT_WRITE,
+			MAP_FIXED | MAP_ANON | MAP_PRIVATE, -1, 0);
+	ASSERT_NE(ptr_new1, MAP_FAILED);
+	ptr_new2 = mmap(&ptr[9 * page_size], page_size, PROT_READ | PROT_WRITE,
+			MAP_FIXED | MAP_ANON | MAP_PRIVATE, -1, 0);
+	ASSERT_NE(ptr_new2, MAP_FAILED);
+
+	/* Assert that they are now not poisoned. */
+	ASSERT_TRUE(try_read_write_buf(ptr_new1));
+	ASSERT_TRUE(try_read_write_buf(ptr_new2));
+
+	/* Cleanup. */
+	ASSERT_EQ(munmap(ptr, 10 * page_size), 0);
+}
+
+/* Assert that mprotect() operations have no bearing on guard poison markers. */
+TEST_F(guard_pages, mprotect)
+{
+	const unsigned long page_size = self->page_size;
+	char *ptr;
+	int i;
+
+	ptr = mmap(NULL, 10 * page_size, PROT_READ | PROT_WRITE,
+		   MAP_ANON | MAP_PRIVATE, -1, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+
+	/* Poison the middle of the range. */
+	ASSERT_EQ(madvise(&ptr[5 * page_size], 2 * page_size,
+			  MADV_GUARD_POISON), 0);
+
+	/* Assert that it is indeed poisoned. */
+	ASSERT_FALSE(try_read_write_buf(&ptr[5 * page_size]));
+	ASSERT_FALSE(try_read_write_buf(&ptr[6 * page_size]));
+
+	/* Now make these pages read-only. */
+	ASSERT_EQ(mprotect(&ptr[5 * page_size], 2 * page_size, PROT_READ), 0);
+
+	/* Make sure the range is still poisoned. */
+	ASSERT_FALSE(try_read_buf(&ptr[5 * page_size]));
+	ASSERT_FALSE(try_read_buf(&ptr[6 * page_size]));
+
+	/* Make sure we can poison again without issue.*/
+	ASSERT_EQ(madvise(&ptr[5 * page_size], 2 * page_size,
+			  MADV_GUARD_POISON), 0);
+
+	/* Make sure the range is, yet again, still poisoned. */
+	ASSERT_FALSE(try_read_buf(&ptr[5 * page_size]));
+	ASSERT_FALSE(try_read_buf(&ptr[6 * page_size]));
+
+	/* Now unpoison the whole range. */
+	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_GUARD_UNPOISON), 0);
+
+	/* Make sure the whole range is readable. */
+	for (i = 0; i < 10; i++) {
+		char *curr = &ptr[i * page_size];
+
+		ASSERT_TRUE(try_read_buf(curr));
+	}
+
+	/* Cleanup. */
+	ASSERT_EQ(munmap(ptr, 10 * page_size), 0);
+}
+
+/* Split and merge VMAs and make sure guard pages still behave. */
+TEST_F(guard_pages, split_merge)
+{
+	const unsigned long page_size = self->page_size;
+	char *ptr, *ptr_new;
+	int i;
+
+	ptr = mmap(NULL, 10 * page_size, PROT_READ | PROT_WRITE,
+		   MAP_ANON | MAP_PRIVATE, -1, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+
+	/* Poison the whole range. */
+	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_GUARD_POISON), 0);
+
+	/* Make sure the whole range is poisoned. */
+	for (i = 0; i < 10; i++) {
+		char *curr = &ptr[i * page_size];
+
+		ASSERT_FALSE(try_read_write_buf(curr));
+	}
+
+	/* Now unmap some pages in the range so we split. */
+	ASSERT_EQ(munmap(&ptr[2 * page_size], page_size), 0);
+	ASSERT_EQ(munmap(&ptr[5 * page_size], page_size), 0);
+	ASSERT_EQ(munmap(&ptr[8 * page_size], page_size), 0);
+
+	/* Make sure the remaining ranges are poisoned post-split. */
+	for (i = 0; i < 2; i++) {
+		char *curr = &ptr[i * page_size];
+
+		ASSERT_FALSE(try_read_write_buf(curr));
+	}
+	for (i = 2; i < 5; i++) {
+		char *curr = &ptr[i * page_size];
+
+		ASSERT_FALSE(try_read_write_buf(curr));
+	}
+	for (i = 6; i < 8; i++) {
+		char *curr = &ptr[i * page_size];
+
+		ASSERT_FALSE(try_read_write_buf(curr));
+	}
+	for (i = 9; i < 10; i++) {
+		char *curr = &ptr[i * page_size];
+
+		ASSERT_FALSE(try_read_write_buf(curr));
+	}
+
+	/* Now map them again - the unmap will have cleared the poison. */
+	ptr_new = mmap(&ptr[2 * page_size], page_size, PROT_READ | PROT_WRITE,
+		       MAP_FIXED | MAP_ANON | MAP_PRIVATE, -1, 0);
+	ASSERT_NE(ptr_new, MAP_FAILED);
+	ptr_new = mmap(&ptr[5 * page_size], page_size, PROT_READ | PROT_WRITE,
+		       MAP_FIXED | MAP_ANON | MAP_PRIVATE, -1, 0);
+	ASSERT_NE(ptr_new, MAP_FAILED);
+	ptr_new = mmap(&ptr[8 * page_size], page_size, PROT_READ | PROT_WRITE,
+		       MAP_FIXED | MAP_ANON | MAP_PRIVATE, -1, 0);
+	ASSERT_NE(ptr_new, MAP_FAILED);
+
+	/* Now make sure poisoning is as expected. */
+	for (i = 0; i < 10; i++) {
+		char *curr = &ptr[i * page_size];
+		bool result = try_read_write_buf(curr);
+		bool expect_true = i == 2 || i == 5 || i == 8;
+
+		ASSERT_TRUE(expect_true ? result : !result);
+	}
+
+	/* Now poison everything again. */
+	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_GUARD_POISON), 0);
+
+	/* Make sure the whole range is poisoned. */
+	for (i = 0; i < 10; i++) {
+		char *curr = &ptr[i * page_size];
+
+		ASSERT_FALSE(try_read_write_buf(curr));
+	}
+
+	/* Now split the range into three. */
+	ASSERT_EQ(mprotect(ptr, 3 * page_size, PROT_READ), 0);
+	ASSERT_EQ(mprotect(&ptr[7 * page_size], 3 * page_size, PROT_READ), 0);
+
+	/* Make sure the whole range is poisoned for read. */
+	for (i = 0; i < 10; i++) {
+		char *curr = &ptr[i * page_size];
+
+		ASSERT_FALSE(try_read_buf(curr));
+	}
+
+	/* Now reset protection bits so we merge the whole thing. */
+	ASSERT_EQ(mprotect(ptr, 3 * page_size, PROT_READ | PROT_WRITE), 0);
+	ASSERT_EQ(mprotect(&ptr[7 * page_size], 3 * page_size,
+			   PROT_READ | PROT_WRITE), 0);
+
+	/* Make sure the whole range is still poisoned. */
+	for (i = 0; i < 10; i++) {
+		char *curr = &ptr[i * page_size];
+
+		ASSERT_FALSE(try_read_write_buf(curr));
+	}
+
+	/* Split range into 3 again... */
+	ASSERT_EQ(mprotect(ptr, 3 * page_size, PROT_READ), 0);
+	ASSERT_EQ(mprotect(&ptr[7 * page_size], 3 * page_size, PROT_READ), 0);
+
+	/* ...and unpoison the whole range. */
+	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_GUARD_UNPOISON), 0);
+
+	/* Make sure the whole range is remedied for read. */
+	for (i = 0; i < 10; i++) {
+		char *curr = &ptr[i * page_size];
+
+		ASSERT_TRUE(try_read_buf(curr));
+	}
+
+	/* Merge them again. */
+	ASSERT_EQ(mprotect(ptr, 3 * page_size, PROT_READ | PROT_WRITE), 0);
+	ASSERT_EQ(mprotect(&ptr[7 * page_size], 3 * page_size,
+			   PROT_READ | PROT_WRITE), 0);
+
+	/* Now ensure the merged range is remedied for read/write. */
+	for (i = 0; i < 10; i++) {
+		char *curr = &ptr[i * page_size];
+
+		ASSERT_TRUE(try_read_write_buf(curr));
+	}
+
+	/* Cleanup. */
+	ASSERT_EQ(munmap(ptr, 10 * page_size), 0);
+}
+
+/* Assert that MADV_DONTNEED does not remove guard poison markers. */
+TEST_F(guard_pages, dontneed)
+{
+	const unsigned long page_size = self->page_size;
+	char *ptr;
+	int i;
+
+	ptr = mmap(NULL, 10 * page_size, PROT_READ | PROT_WRITE,
+		   MAP_ANON | MAP_PRIVATE, -1, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+
+	/* Back the whole range. */
+	for (i = 0; i < 10; i++) {
+		char *curr = &ptr[i * page_size];
+
+		*curr = 'y';
+	}
+
+	/* Poison every other page. */
+	for (i = 0; i < 10; i += 2) {
+		char *curr = &ptr[i * page_size];
+		int res = madvise(curr, page_size, MADV_GUARD_POISON);
+
+		ASSERT_EQ(res, 0);
+	}
+
+	/* Indicate that we don't need any of the range. */
+	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_DONTNEED), 0);
+
+	/* Check to ensure poison markers are still in place. */
+	for (i = 0; i < 10; i++) {
+		char *curr = &ptr[i * page_size];
+		bool result = try_read_buf(curr);
+
+		if (i % 2 == 0) {
+			ASSERT_FALSE(result);
+		} else {
+			ASSERT_TRUE(result);
+			/* Make sure we really did get reset to zero page. */
+			ASSERT_EQ(*curr, '\0');
+		}
+
+		/* Now write... */
+		result = try_write_buf(&ptr[i * page_size]);
+
+		/* ...and make sure same result. */
+		ASSERT_TRUE(i % 2 != 0 ? result : !result);
+	}
+
+	/* Cleanup. */
+	ASSERT_EQ(munmap(ptr, 10 * page_size), 0);
+}
+
+/* Assert that mlock()'ed pages work correctly with poison markers. */
+TEST_F(guard_pages, mlock)
+{
+	const unsigned long page_size = self->page_size;
+	char *ptr;
+	int i;
+
+	ptr = mmap(NULL, 10 * page_size, PROT_READ | PROT_WRITE,
+		   MAP_ANON | MAP_PRIVATE, -1, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+
+	/* Populate. */
+	for (i = 0; i < 10; i++) {
+		char *curr = &ptr[i * page_size];
+
+		*curr = 'y';
+	}
+
+	/* Lock. */
+	ASSERT_EQ(mlock(ptr, 10 * page_size), 0);
+
+	/* Now try to poison, should fail with EINVAL. */
+	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_GUARD_POISON), -1);
+	ASSERT_EQ(errno, EINVAL);
+
+	/* OK unlock. */
+	ASSERT_EQ(munlock(ptr, 10 * page_size), 0);
+
+	/* Poison first half of range, should now succeed. */
+	ASSERT_EQ(madvise(ptr, 5 * page_size, MADV_GUARD_POISON), 0);
+
+	/* Make sure poison works. */
+	for (i = 0; i < 10; i++) {
+		char *curr = &ptr[i * page_size];
+		bool result = try_read_write_buf(curr);
+
+		if (i < 5) {
+			ASSERT_FALSE(result);
+		} else {
+			ASSERT_TRUE(result);
+			ASSERT_EQ(*curr, 'x');
+		}
+	}
+
+	/*
+	 * Now lock the latter part of the range. We can't lock the poisoned
+	 * pages, as this would result in the pages being populated and the
+	 * poisoning would cause this to error out.
+	 */
+	ASSERT_EQ(mlock(&ptr[5 * page_size], 5 * page_size), 0);
+
+	/*
+	 * Now unpoison, we do not permit mlock()'d ranges to be remedied as it is
+	 * a non-destructive operation.
+	 */
+	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_GUARD_UNPOISON), 0);
+
+	/* Now check that everything is remedied. */
+	for (i = 0; i < 10; i++) {
+		char *curr = &ptr[i * page_size];
+
+		ASSERT_TRUE(try_read_write_buf(curr));
+	}
+
+	/* Cleanup. */
+	ASSERT_EQ(munmap(ptr, 10 * page_size), 0);
+}
+
+/*
+ * Assert that moving, extending and shrinking memory via mremap() retains
+ * poison markers where possible.
+ *
+ * - Moving a mapping alone should retain markers as they are.
+ */
+TEST_F(guard_pages, mremap_move)
+{
+	const unsigned long page_size = self->page_size;
+	char *ptr, *ptr_new;
+
+	/* Map 5 pages. */
+	ptr = mmap(NULL, 5 * page_size, PROT_READ | PROT_WRITE,
+		   MAP_ANON | MAP_PRIVATE, -1, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+
+	/* Place poison markers at both ends of the 5 page span. */
+	ASSERT_EQ(madvise(ptr, page_size, MADV_GUARD_POISON), 0);
+	ASSERT_EQ(madvise(&ptr[4 * page_size], page_size, MADV_GUARD_POISON), 0);
+
+	/* Make sure the poison is in effect. */
+	ASSERT_FALSE(try_read_write_buf(ptr));
+	ASSERT_FALSE(try_read_write_buf(&ptr[4 * page_size]));
+
+	/* Map a new region we will move this range into. Doing this ensures
+	 * that we have reserved a range to map into.
+	 */
+	ptr_new = mmap(NULL, 5 * page_size, PROT_NONE, MAP_ANON | MAP_PRIVATE,
+		       -1, 0);
+	ASSERT_NE(ptr_new, MAP_FAILED);
+
+	ASSERT_EQ(mremap(ptr, 5 * page_size, 5 * page_size,
+			 MREMAP_MAYMOVE | MREMAP_FIXED, ptr_new), ptr_new);
+
+	/* Make sure the poison is retained. */
+	ASSERT_FALSE(try_read_write_buf(ptr_new));
+	ASSERT_FALSE(try_read_write_buf(&ptr_new[4 * page_size]));
+
+	/*
+	 * Clean up - we only need reference the new pointer as we overwrote the
+	 * PROT_NONE range and moved the existing one.
+	 */
+	munmap(ptr_new, 5 * page_size);
+}
+
+/*
+ * Assert that moving, extending and shrinking memory via mremap() retains
+ * poison markers where possible.
+ *
+ * - Expanding should retain, only now in different position. The user will have
+ *   to unpoison manually to fix up (they'd have to do the same if it were a
+ *   PROT_NONE mapping)
+ */
+TEST_F(guard_pages, mremap_expand)
+{
+	const unsigned long page_size = self->page_size;
+	char *ptr, *ptr_new;
+
+	/* Map 10 pages... */
+	ptr = mmap(NULL, 10 * page_size, PROT_READ | PROT_WRITE,
+		   MAP_ANON | MAP_PRIVATE, -1, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+	/* ...But unmap the last 5 so we can ensure we can expand into them. */
+	ASSERT_EQ(munmap(&ptr[5 * page_size], 5 * page_size), 0);
+
+	/* Place poison markers at both ends of the 5 page span. */
+	ASSERT_EQ(madvise(ptr, page_size, MADV_GUARD_POISON), 0);
+	ASSERT_EQ(madvise(&ptr[4 * page_size], page_size, MADV_GUARD_POISON), 0);
+
+	/* Make sure the poison is in effect. */
+	ASSERT_FALSE(try_read_write_buf(ptr));
+	ASSERT_FALSE(try_read_write_buf(&ptr[4 * page_size]));
+
+	/* Now expand to 10 pages. */
+	ptr = mremap(ptr, 5 * page_size, 10 * page_size, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+
+	/* Make sure the poison is retained in its original positions. */
+	ASSERT_FALSE(try_read_write_buf(ptr));
+	ASSERT_FALSE(try_read_write_buf(&ptr[4 * page_size]));
+
+	/* Reserve a region which we can move to and expand into. */
+	ptr_new = mmap(NULL, 20 * page_size, PROT_NONE,
+		       MAP_ANON | MAP_PRIVATE, -1, 0);
+	ASSERT_NE(ptr_new, MAP_FAILED);
+
+	/* Now move and expand into it. */
+	ptr = mremap(ptr, 10 * page_size, 20 * page_size,
+		     MREMAP_MAYMOVE | MREMAP_FIXED, ptr_new);
+	ASSERT_EQ(ptr, ptr_new);
+
+	/* Again, make sure the poison is retained in its original positions. */
+	ASSERT_FALSE(try_read_write_buf(ptr));
+	ASSERT_FALSE(try_read_write_buf(&ptr[4 * page_size]));
+
+	/*
+	 * A real user would have to unpoison, but would reasonably expect all
+	 * characteristics of the mapping to be retained, including poison
+	 * markers.
+	 */
+
+	/* Cleanup. */
+	munmap(ptr, 20 * page_size);
+}
+/*
+ * Assert that moving, extending and shrinking memory via mremap() retains
+ * poison markers where possible.
+ *
+ * - Shrinking will result in markers that are shrunk over being removed. Again,
+ *   if the user were using a PROT_NONE mapping they'd have to manually fix this
+ *   up also so this is OK.
+ */
+TEST_F(guard_pages, mremap_shrink)
+{
+	const unsigned long page_size = self->page_size;
+	char *ptr;
+	int i;
+
+	/* Map 5 pages. */
+	ptr = mmap(NULL, 5 * page_size, PROT_READ | PROT_WRITE,
+		   MAP_ANON | MAP_PRIVATE, -1, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+
+	/* Place poison markers at both ends of the 5 page span. */
+	ASSERT_EQ(madvise(ptr, page_size, MADV_GUARD_POISON), 0);
+	ASSERT_EQ(madvise(&ptr[4 * page_size], page_size, MADV_GUARD_POISON), 0);
+
+	/* Make sure the poison is in effect. */
+	ASSERT_FALSE(try_read_write_buf(ptr));
+	ASSERT_FALSE(try_read_write_buf(&ptr[4 * page_size]));
+
+	/* Now shrink to 3 pages. */
+	ptr = mremap(ptr, 5 * page_size, 3 * page_size, MREMAP_MAYMOVE);
+	ASSERT_NE(ptr, MAP_FAILED);
+
+	/* We expect the poison marker at the start to be retained... */
+	ASSERT_FALSE(try_read_write_buf(ptr));
+
+	/* ...But remaining pages will not have poison markers. */
+	for (i = 1; i < 3; i++) {
+		char *curr = &ptr[i * page_size];
+
+		ASSERT_TRUE(try_read_write_buf(curr));
+	}
+
+	/*
+	 * As with expansion, a real user would have to unpoison and fixup. But
+	 * you'd have to do similar manual things with PROT_NONE mappings too.
+	 */
+
+	/*
+	 * If we expand back to the original size, the end marker will, of
+	 * course, no longer be present.
+	 */
+	ptr = mremap(ptr, 3 * page_size, 5 * page_size, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+
+	/* Again, we expect the poison marker at the start to be retained... */
+	ASSERT_FALSE(try_read_write_buf(ptr));
+
+	/* ...But remaining pages will not have poison markers. */
+	for (i = 1; i < 5; i++) {
+		char *curr = &ptr[i * page_size];
+
+		ASSERT_TRUE(try_read_write_buf(curr));
+	}
+
+	/* Cleanup. */
+	munmap(ptr, 5 * page_size);
+}
+
+/*
+ * Assert that forking a process with VMAs that do not have VM_WIPEONFORK set
+ * retain guard pages.
+ */
+TEST_F(guard_pages, fork)
+{
+	const unsigned long page_size = self->page_size;
+	char *ptr;
+	pid_t pid;
+	int i;
+
+	/* Map 10 pages. */
+	ptr = mmap(NULL, 10 * page_size, PROT_READ | PROT_WRITE,
+		   MAP_ANON | MAP_PRIVATE, -1, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+
+	/* Poison the first 5 pages. */
+	ASSERT_EQ(madvise(ptr, 5 * page_size, MADV_GUARD_POISON), 0);
+
+	pid = fork();
+	ASSERT_NE(pid, -1);
+	if (!pid) {
+		/* This is the child process now. */
+
+		/* Assert that the poisoning is in effect. */
+		for (i = 0; i < 10; i++) {
+			char *curr = &ptr[i * page_size];
+			bool result = try_read_write_buf(curr);
+
+			ASSERT_TRUE(i >= 5 ? result : !result);
+		}
+
+		/* Now unpoison the range.*/
+		ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_GUARD_UNPOISON), 0);
+
+		exit(0);
+	}
+
+	/* Parent process. */
+
+	/* Parent simply waits on child. */
+	waitpid(pid, NULL, 0);
+
+	/* Child unpoison does not impact parent page table state. */
+	for (i = 0; i < 10; i++) {
+		char *curr = &ptr[i * page_size];
+		bool result = try_read_write_buf(curr);
+
+		ASSERT_TRUE(i >= 5 ? result : !result);
+	}
+
+	/* Cleanup. */
+	ASSERT_EQ(munmap(ptr, 10 * page_size), 0);
+}
+
+/*
+ * Assert that forking a process with VMAs that do have VM_WIPEONFORK set
+ * behave as expected.
+ */
+TEST_F(guard_pages, fork_wipeonfork)
+{
+	const unsigned long page_size = self->page_size;
+	char *ptr;
+	pid_t pid;
+	int i;
+
+	/* Map 10 pages. */
+	ptr = mmap(NULL, 10 * page_size, PROT_READ | PROT_WRITE,
+		   MAP_ANON | MAP_PRIVATE, -1, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+
+	/* Mark wipe on fork. */
+	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_WIPEONFORK), 0);
+
+	/* Poison the first 5 pages. */
+	ASSERT_EQ(madvise(ptr, 5 * page_size, MADV_GUARD_POISON), 0);
+
+	pid = fork();
+	ASSERT_NE(pid, -1);
+	if (!pid) {
+		/* This is the child process now. */
+
+		/* Poison will have been wiped. */
+		for (i = 0; i < 10; i++) {
+			char *curr = &ptr[i * page_size];
+
+			ASSERT_TRUE(try_read_write_buf(curr));
+		}
+
+		exit(0);
+	}
+
+	/* Parent process. */
+
+	waitpid(pid, NULL, 0);
+
+	/* Poison should be in effect.*/
+	for (i = 0; i < 10; i++) {
+		char *curr = &ptr[i * page_size];
+		bool result = try_read_write_buf(curr);
+
+		ASSERT_TRUE(i >= 5 ? result : !result);
+	}
+
+	/* Cleanup. */
+	ASSERT_EQ(munmap(ptr, 10 * page_size), 0);
+}
+
+/* Ensure that MADV_FREE frees poison entries as expected. */
+TEST_F(guard_pages, lazyfree)
+{
+	const unsigned long page_size = self->page_size;
+	char *ptr;
+	int i;
+
+	/* Map 10 pages. */
+	ptr = mmap(NULL, 10 * page_size, PROT_READ | PROT_WRITE,
+		   MAP_ANON | MAP_PRIVATE, -1, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+
+	/* Poison range. */
+	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_GUARD_POISON), 0);
+
+	/* Ensure poisoned. */
+	for (i = 0; i < 10; i++) {
+		char *curr = &ptr[i * page_size];
+
+		ASSERT_FALSE(try_read_write_buf(curr));
+	}
+
+	/* Lazyfree range. */
+	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_FREE), 0);
+
+	/* This should simply clear the poison markers. */
+	for (i = 0; i < 10; i++) {
+		char *curr = &ptr[i * page_size];
+
+		ASSERT_TRUE(try_read_write_buf(curr));
+	}
+
+	/* Cleanup. */
+	ASSERT_EQ(munmap(ptr, 10 * page_size), 0);
+}
+
+/* Ensure that MADV_POPULATE_READ, MADV_POPULATE_WRITE behave as expected. */
+TEST_F(guard_pages, populate)
+{
+	const unsigned long page_size = self->page_size;
+	char *ptr;
+
+	/* Map 10 pages. */
+	ptr = mmap(NULL, 10 * page_size, PROT_READ | PROT_WRITE,
+		   MAP_ANON | MAP_PRIVATE, -1, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+
+	/* Poison range. */
+	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_GUARD_POISON), 0);
+
+	/* Populate read should error out... */
+	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_POPULATE_READ), -1);
+	ASSERT_EQ(errno, EFAULT);
+
+	/* ...as should populate write. */
+	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_POPULATE_WRITE), -1);
+	ASSERT_EQ(errno, EFAULT);
+
+	/* Cleanup. */
+	ASSERT_EQ(munmap(ptr, 10 * page_size), 0);
+}
+
+/* Ensure that MADV_COLD, MADV_PAGEOUT do not remove poison markers. */
+TEST_F(guard_pages, cold_pageout)
+{
+	const unsigned long page_size = self->page_size;
+	char *ptr;
+	int i;
+
+	/* Map 10 pages. */
+	ptr = mmap(NULL, 10 * page_size, PROT_READ | PROT_WRITE,
+		   MAP_ANON | MAP_PRIVATE, -1, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+
+	/* Poison range. */
+	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_GUARD_POISON), 0);
+
+	/* Ensured poisoned. */
+	for (i = 0; i < 10; i++) {
+		char *curr = &ptr[i * page_size];
+
+		ASSERT_FALSE(try_read_write_buf(curr));
+	}
+
+	/* Now mark cold. This should have no impact on poison markers. */
+	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_COLD), 0);
+
+	/* Should remain poisoned. */
+	for (i = 0; i < 10; i++) {
+		char *curr = &ptr[i * page_size];
+
+		ASSERT_FALSE(try_read_write_buf(curr));
+	}
+
+	/* OK, now page out. This should equally, have no effect on markers. */
+	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_PAGEOUT), 0);
+
+	/* Should remain poisoned. */
+	for (i = 0; i < 10; i++) {
+		char *curr = &ptr[i * page_size];
+
+		ASSERT_FALSE(try_read_write_buf(curr));
+	}
+
+	/* Cleanup. */
+	ASSERT_EQ(munmap(ptr, 10 * page_size), 0);
+}
+
+/* Ensure that guard pages do not break userfaultd. */
+TEST_F(guard_pages, uffd)
+{
+	const unsigned long page_size = self->page_size;
+	int uffd;
+	char *ptr;
+	int i;
+	struct uffdio_api api = {
+		.api = UFFD_API,
+		.features = 0,
+	};
+	struct uffdio_register reg;
+	struct uffdio_range range;
+
+	/* Set up uffd. */
+	uffd = userfaultfd(0);
+	if (uffd == -1 && errno == EPERM)
+		ksft_exit_skip("No userfaultfd permissions, try running as root.\n");
+	ASSERT_NE(uffd, -1);
+
+	ASSERT_EQ(ioctl(uffd, UFFDIO_API, &api), 0);
+
+	/* Map 10 pages. */
+	ptr = mmap(NULL, 10 * page_size, PROT_READ | PROT_WRITE,
+		   MAP_ANON | MAP_PRIVATE, -1, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+
+	/* Register the range with uffd. */
+	range.start = (unsigned long)ptr;
+	range.len = 10 * page_size;
+	reg.range = range;
+	reg.mode = UFFDIO_REGISTER_MODE_MISSING;
+	ASSERT_EQ(ioctl(uffd, UFFDIO_REGISTER, &reg), 0);
+
+	/* Poison the range. This should not trigger the uffd. */
+	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_GUARD_POISON), 0);
+
+	/* The poisoning should behave as usual with no uffd intervention. */
+	for (i = 0; i < 10; i++) {
+		char *curr = &ptr[i * page_size];
+
+		ASSERT_FALSE(try_read_write_buf(curr));
+	}
+
+	/* Cleanup. */
+	ASSERT_EQ(ioctl(uffd, UFFDIO_UNREGISTER, &range), 0);
+	close(uffd);
+	ASSERT_EQ(munmap(ptr, 10 * page_size), 0);
+}
+
+TEST_HARNESS_MAIN
-- 
2.47.0


