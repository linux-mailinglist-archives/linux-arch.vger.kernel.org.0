Return-Path: <linux-arch+bounces-8356-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A83229A6E3F
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 17:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FFEAB21242
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 15:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072061C32E5;
	Mon, 21 Oct 2024 15:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PzTnJanx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BuGU5NWz"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950C0186E2F;
	Mon, 21 Oct 2024 15:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729524851; cv=fail; b=o7jykLCKIOH/jXODY4BLdvcb9gmty/Pdpd476+EM8MPjBRhChkq9nI2bquV4/NH8E8sKu79iB/RBcqODrVUT5/OahTasU5f8BDAmqH+3llxzKEReu6ldWZpLuC2NgXE6ajKnoiPLF820iVWC/AnvsNQPgjGxuPImJr+n0Te9j2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729524851; c=relaxed/simple;
	bh=4u+Dnaa197hApPRngXZ/RfZX365eaQXukqZxH11Thcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CxWkLKH8V8zAUlVAkyzucDdWCCNlfEsVgCx8qqjHWFj9mJDocIbsOmV2Hvn4udEOzDW8AOcSoVbdm+gzOefJsE2DlP/LZPOHs32itimkvwdgMACETYImZRKlpsG5K2V7OFQuJabnDUbzKtpwo2RtzeQZLIApts/qUZ371Ajkyv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PzTnJanx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BuGU5NWz; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49LEtjjk026519;
	Mon, 21 Oct 2024 15:33:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=kZbMulGgIcDuYAmCVS
	+1/0wlgrQat9BDWo15Qn2dIy8=; b=PzTnJanx7szs1yjahi7G3ymhsrK02ZlKCU
	plJ7y9o3rDGym/iCSd3/0XX2UUrcVozy70ECExNqAdwr/aM864T5qf45DXy64rRY
	1jZqscanLmD6VYotFUNwu9acLQs1R5bwuTdclJi6hXoeC93+C/hE2qTiwSqcOFHP
	EETm+ld3dDg3efFV+pKgQv/aT34h9cc40yMAxxpHnsF1UUWF90cDykjeYnbBL/qa
	zS/PcExctl3amQiSaLd9/nwM9k1q/sVO1Z0WrFTFmNE62ld+VkNZZLnYou5SAeP1
	qmxdNoP3sv6H1R2CgAOQHWQvsEVgYnBmzN7obaXkm1eiTnmHzLGg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c57qbdh2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Oct 2024 15:33:26 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49LEw25m019628;
	Mon, 21 Oct 2024 15:33:26 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2044.outbound.protection.outlook.com [104.47.51.44])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42c37cmdff-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Oct 2024 15:33:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ap9QfKt4PgYJ8uA/j62HlLs9vv32U35dfUx1DOyqVXleGkyaCjl8IgyMp/HzxaKAFMijKPTvYrzcRT3pgl8B37fASpFwAd2EjEk0CttqYhoYIZjD2Fbe1xgqDiRWqDYitQyUm6OJQ5NIHVOjjR5spJdShlWa5Vt50b1ofWcqTjG+Y7p3/6ZUo+whkE6WEO8fQ0F2FzFvv+G9T078ZRPd6ZtyU1GcgRNIY03cLooPywe1SIjv95NI/UqVA0pcROVs/TkEpecW5T1y88VwLfyocbN4oXPYk8sWBTMw/5xVe1GdrwR1ZqG3IZtqxEVvvOxSNaLsqg8O6y3S/cImLbCqww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kZbMulGgIcDuYAmCVS+1/0wlgrQat9BDWo15Qn2dIy8=;
 b=XeygKxAI/BTmKGb/qE+GvBCf32n8/1sanB6HPTImIOq2b+h8zwHSS5MKlyRT/Ph+Z/9x1layOCsBy43+LMwrmijRQtKlVz10UZXJBIZBKAuE+FxTkKheKRqpnvnyAmObA9l+HTiotHe7rArvquNaDjprDo0b4gzLg9kihpLl7I2m0Hzl/RNpSJeyDMjGtYUlc5AeP9u98Jv4LBxxv3XRJ1KKxujMKroGLUXbTTjCrj/XowMyEh4rBHoTZOhmwmkXKsTuGarS+tlU+OxKoVK7EM+/7OuoOfB/xyV8M/JyUb/YHv+wdsxv+Bz2EgzLNbxCz9Rp+WRIal227fc4/VNXBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kZbMulGgIcDuYAmCVS+1/0wlgrQat9BDWo15Qn2dIy8=;
 b=BuGU5NWzPX9K8uVM1GFZeQapIakIFEGpv0avFbQI9ZJYPpZFTGiIx9r25fv62NrTZEfUyQtRvCFK9xYiiVs4h2hk5RqvLl9ECqQVR6q1x8J+v1LRUhbFeSHb5uXoQ/uGmR6hnr+5trnwpzHx6dkYzDgtR/pPmq05k5m0eI+qJPE=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by LV8PR10MB7871.namprd10.prod.outlook.com (2603:10b6:408:1ed::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.20; Mon, 21 Oct
 2024 15:33:23 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8069.024; Mon, 21 Oct 2024
 15:33:23 +0000
Date: Mon, 21 Oct 2024 16:33:19 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>, Jann Horn <jannh@google.com>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Muchun Song <muchun.song@linux.dev>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-arch@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>,
        linux-kselftest@vger.kernel.org,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Jeff Xu <jeffxu@chromium.org>, Christoph Hellwig <hch@infradead.org>,
        linux-api@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v2 2/5] mm: add PTE_MARKER_GUARD PTE marker
Message-ID: <4f4e41f1-531c-4686-b44d-dacdf034c241@lucifer.local>
References: <cover.1729440856.git.lorenzo.stoakes@oracle.com>
 <081837b697a98c7fa5832542b20f603d49e0b557.1729440856.git.lorenzo.stoakes@oracle.com>
 <470886d2-9f6f-4486-a935-daea4c5bea09@suse.cz>
 <434a440a-d6a4-4144-b4fb-8e0d8535f03f@lucifer.local>
 <caf95a99-e975-4f3d-a94b-298a5fc88b5a@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <caf95a99-e975-4f3d-a94b-298a5fc88b5a@suse.cz>
X-ClientProxiedBy: LO4P265CA0313.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:390::15) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|LV8PR10MB7871:EE_
X-MS-Office365-Filtering-Correlation-Id: f2fe6c4d-ffdc-4a9e-1be6-08dcf1e5b2c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rvCnrtZkDfZNyjm4qLycR5+Mi0I8m7pQnbjFVkaIayLHsVCXRbfh4hAZnUjt?=
 =?us-ascii?Q?gegrl3zE1QWZwMAclk1qrdaTfSIEuSSuM6PSw7SESePrZjIYBusA0tt8CS7W?=
 =?us-ascii?Q?mBsJX6wH3IU5q0NVkPDZCyReCbQJk+tsUXiIWbL3F9NrtRRWX8xWbc/YuWtp?=
 =?us-ascii?Q?T0l6P305VPPDgfiRYOFKSZGeT1PF3ARxccbBpP+9RQUuE4R7dMaS0jDxTUw0?=
 =?us-ascii?Q?1T/IMs4aVaOw/7O4NEqeH1jx4A6zi+0F+ngmuGX5NLh5zZLjJwpQJi79CZOp?=
 =?us-ascii?Q?YbTHwSdSNk5N+aJ+8GYMsHK3DB9OzO+/+1F5q2VtfEYxtQnMX4GOw8xylc20?=
 =?us-ascii?Q?cQGPCxMGXcud0ghvaTpg1W2BrF81EqPVmQhrj8pbgNz3NlxaGfEk6I4CEfOA?=
 =?us-ascii?Q?C2jgGeF1CMnFtvZPp0a7T9xm9SgVomrGpv0bCh0jqgUL679l3chRQq+MxHRU?=
 =?us-ascii?Q?i08YkcKidYlA5eJUszc/Gttzk/ruVDrXE+riOjzMQUvof5iSYYptNZC1dUqe?=
 =?us-ascii?Q?2BSljQGnUb3l1Gm/K8pqD29IZQt0PVAyMsn4EcTIZDGsYTcyGPIoMAkPZLjS?=
 =?us-ascii?Q?xo+sBO45f+2qVzUEbBdr1zFdNM3+lGmlLI5piB5TopkGGU2m9PVA8DT+2kou?=
 =?us-ascii?Q?Iea+Srd8XG4/C3q4gRYXJX1O2xwp5JlOGEOe9zYsnCiIwIgKMY/2ECJCK7N4?=
 =?us-ascii?Q?x2MkFYCuPuBsULqXWm2jYOJ7/LapPHtndAl7fXi4zkmrqU/Oh0e98ma6mhgS?=
 =?us-ascii?Q?J+8D6keu87fh2pCztgXj4QLTAz8mphLqZMSc4QxeugGVMn8SiX0ZA9S6NvCn?=
 =?us-ascii?Q?6jlciaIvxpMGsJfJxgLYPvxhe2RljEvfwveVrKsk0XqmFycj6Qs+2lFD7qY5?=
 =?us-ascii?Q?rPvM+E5J2Mt21dm1YlLTH6RXPK8qi3skbR1zDu5Z+YNVDG3OtHsYbZud/aOv?=
 =?us-ascii?Q?lzzZO47p2Eo5Za4tR2Ju5cXrSKayRm98uKuuN6fCxZ3sjuxNpJHLhFyBuu6Z?=
 =?us-ascii?Q?Aq4UNgEc9Y8vpiH1HUCq63Pbw3flKUeIKpX315t2wPbgbBwoX7XfD32elO/L?=
 =?us-ascii?Q?fVPBFJAdicQMQ7r+uH/o/kVnaj41zix4ql9Iz34ZDA4zj1SpvpI8CxWMRxVa?=
 =?us-ascii?Q?dYxOx4U+BOGAjOsSv5873qiE9EDwgRllPTai6SRXseAwX3sacfngveYgFxx4?=
 =?us-ascii?Q?TjJ+sWeDGRG9ydq/PJSknEfnvdo1lAKzGW7vm5pF3ghVkzlki+5A38gouONl?=
 =?us-ascii?Q?RKyZXkFGBxwA2oBoMCLWd7ehr2jTtF4V6xW0WlzJvA1nRmYHtgHj4mndTmiw?=
 =?us-ascii?Q?8DA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ot4r/ozf32VXeb0CeB61zmhd2zlGOxkDhZGWbgectp4q8WHsHwnZ+YQMmTmB?=
 =?us-ascii?Q?LxYK8YSC1hekf7M1vIJdAt/F3b/yOaJGcrKVvttI9Vj3X4NEC5Mh0bEuI/GZ?=
 =?us-ascii?Q?tT9J20LKswC+s75tlTrXsKsKY9n8jBBVZnwpmXDNH83tTHcqVac4bazhdNLe?=
 =?us-ascii?Q?boCklMPFs+ncfpeGjhfN0Qmy4Urla9PGvQootT4F9XBHw9iCmtu7MmU9L6mi?=
 =?us-ascii?Q?s1MSS4c78SDYlflc/vYC8NZQdZP5tK4akEkSTxU1WBaBzwb+GALdBOYPRYcH?=
 =?us-ascii?Q?p58fy7hdBYqGjddtDlgbYWSPLK4VrRStSPm2Mz4ny12YaB8zdCsB+iNTatwi?=
 =?us-ascii?Q?c8gkb5gCw4taN9ZVLxgcAsQBwsTD9Ko5ocv6EHX2OrE+mBkQz1/68s4u2Ln6?=
 =?us-ascii?Q?AxOPisSOynWEEQHFzrziUWhAW9ByybLYfbAdZ4ak+spCnOiGWiT8u+UvIPia?=
 =?us-ascii?Q?9FZt5apKKyNNWX8tuldQ4kKr/UX+d75MR1WP/mehQjFJxOrE8jD8NnQqdiHj?=
 =?us-ascii?Q?wl7bhXTtfp7qbpk5gTLb/napMcBTzbbZpizs3vQriZpJz89zmc5UjvD5wpbr?=
 =?us-ascii?Q?2iBWIjh3kZhi4ItKVGEH4KWQ9oStXfW3PCNOsxHzdSC5QrPt2iTyUm/cG48j?=
 =?us-ascii?Q?V5EcvbEO+kDVagQYgkRbF0kl0ucD5cTyqjC4ulS7ZPm9/eMUw9ERDTrL1+nG?=
 =?us-ascii?Q?ue03SvFwD7JDAZ/Icw1nREH3uxn+IEwkaJnhzAiOeXK31fuUuNAiEQEKJdwP?=
 =?us-ascii?Q?JJdQYLK18BNV5Dw94dFOnvaiI+xHValip4ZZ4iCf7Ay4zLCO3IgrJ4W1zgw5?=
 =?us-ascii?Q?5I6pSn2oP+VNZvaAjT6qUQwJvQZqwKVW0EJS9IMkCoNEDAR7SszK4zUHmQec?=
 =?us-ascii?Q?rA2+HQaz5c/0hE2hsuhcadOMFAzHpjSYAQTd+ijZThYvnfxtOiyOIadScf6E?=
 =?us-ascii?Q?xIFcJUJV2OBR4LTuWLqHB9phJSTH7WsRP6nc4qtRb3qScuyvp4w4PVAw4FyB?=
 =?us-ascii?Q?rtXdRFUc2KkseILiArWz+ZqlpTGY6nMQx4oRZ/KpuaXryeusOPHo7+CH6Wbn?=
 =?us-ascii?Q?EF+j0DkvveFtRz9wN8RDDabNLGz7CItVEk4NBP0AsPW+tudxw3+Ms1re4M5J?=
 =?us-ascii?Q?S2FLiCAudOJru4LVy4SYDugXDZHRYov8vwaDLQ5uakqwT6OaCD4vsIyuDf2R?=
 =?us-ascii?Q?epbu0S1NvjQ2cL0Yg1jG6zyrxeervSN6T4bRp/e8C0zfgGhKnQ/IF1bFtdgW?=
 =?us-ascii?Q?wulQeiB8GSOdTzrqSYQ2nhxeAIPyu/Yua17fpC360oWPkAd/g9zI0AZ5oYrL?=
 =?us-ascii?Q?bYMAYWycvaWNhTPwRR3nR4yJ6rBoRtzYiacQn6zZBWOye+l8nHtUvSnHGZ9H?=
 =?us-ascii?Q?qq7oDc30ATvKJOZF8S+V7LXfCEaIzLmV0wPLLiofdH31TL8x6rw3+7rWtPbP?=
 =?us-ascii?Q?EKMhdcT4wcQ4mFsXrzuYmwvrHPUQL8UNy/e1/qHEVPXAy15O59d5n/z5vUhG?=
 =?us-ascii?Q?Z6pYY1O0Y6Dc12jXwRgVXn/+pn3IYaFFc2oUNLVth8TiL0SQZYGfqWeTL3re?=
 =?us-ascii?Q?N4fDY0GwT/r1FHpU5vFAwoHK89LDhuVCttYcUa4lRVWqiQP2zSE9wDU6MAG1?=
 =?us-ascii?Q?NA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4fdJhDXURwCpv0Pwwta4aB4mPshSgCPwwFHvuo5GUhMUPrQNkQZ8CKcrNYa7cvwnyrJ4eO/HHwJw2YDzNajnGFvSMX2J/awN8UAbGFOTPmuoavqokHBSygMh6AwztIFqgQ8c7sm8SdsPwpq1c6ZtJ+VSIKxFZJkoAEBYggPduKFjCIexiV/ny81TN6BfzLL0yVjJIuT0tDgNc7a3sp2texaEmfskkExibLtUw4iufiOc4goktjn1zr1dl4hKNQs4GMi6efovckpfVqLVrP8piAoqzVbQcFM2mrLPc7Azdfkn76tHPqIf0oG0hMi3JgId3dtPckXkmTknd4O3No7PqkSd8eueIzSrGXNvQ6GP7Si0BAzcX5r7oXBQ3Y+BL2Su3uDiur8aR3s7OD1GrUiN8aOjl+W1o1a3ErNcqFVZ4cgaIwxPdpPIl988l0XYUpuy1Ajnw8g8R/JIZ2Ta79S26PEOCyqj0MSXAKrK44hCEEm3SDQxZuV09ogjOlBTxmUkckuG4ejwTwaVDJeKxz9bU5N0FA30byUWil54JtjL/lEzpJES+/vMsdxR8KEJVbQnykKHAR89NdZGlZNh8xhS8aPN9VdNNXVt+ivZGaz4IYo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2fe6c4d-ffdc-4a9e-1be6-08dcf1e5b2c5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 15:33:23.1511
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Knl0lA9Hzbv3+HLzkhe6DhtMSTyp3m5yIy4WnBgO4cHP8aXwbu46GZC//T129MXY8GhR4kGfsE+JLGs4NUcQk8W47qhrgUw1xl5MSNfmmA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7871
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-21_12,2024-10-21_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=492 spamscore=0 malwarescore=0 mlxscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410210111
X-Proofpoint-ORIG-GUID: YbVkQLF3gKbz08FRYnjjrKIBs2rsVhsc
X-Proofpoint-GUID: YbVkQLF3gKbz08FRYnjjrKIBs2rsVhsc

On Mon, Oct 21, 2024 at 04:54:06PM +0200, Vlastimil Babka wrote:
> On 10/21/24 16:33, Lorenzo Stoakes wrote:
> > On Mon, Oct 21, 2024 at 04:13:34PM +0200, Vlastimil Babka wrote:
> >> On 10/20/24 18:20, Lorenzo Stoakes wrote:
> >> > Add a new PTE marker that results in any access causing the accessing
> >> > process to segfault.
> >> >
> >> > This is preferable to PTE_MARKER_POISONED, which results in the same
> >> > handling as hardware poisoned memory, and is thus undesirable for cases
> >> > where we simply wish to 'soft' poison a range.
> >> >
> >> > This is in preparation for implementing the ability to specify guard pages
> >> > at the page table level, i.e. ranges that, when accessed, should cause
> >> > process termination.
> >> >
> >> > Additionally, rename zap_drop_file_uffd_wp() to zap_drop_markers() - the
> >> > function checks the ZAP_FLAG_DROP_MARKER flag so naming it for this single
> >> > purpose was simply incorrect.
> >> >
> >> > We then reuse the same logic to determine whether a zap should clear a
> >> > guard entry - this should only be performed on teardown and never on
> >> > MADV_DONTNEED or the like.
> >>
> >> Since I would have personally put MADV_FREE among "or the like" here, it's
> >> surprising to me that it in fact it's tearing down the guard entries now. Is
> >> that intentional? It should be at least mentioned very explicitly. But I'd
> >> really argue against it, as MADV_FREE is to me a weaker form of
> >> MADV_DONTNEED - the existing pages are not zapped immediately but
> >> prioritized for reclaim. If MADV_DONTNEED leaves guard PTEs in place, why
> >> shouldn't MADV_FREE too?
> >
> > That is not, as I understand it, what MADV_FREE is, semantically. From the
> > man pages:
> >
> >        MADV_FREE (since Linux 4.5)
> >
> >               The application no longer requires the pages in the range
> >               specified by addr and len.  The kernel can thus free these
> >               pages, but the freeing could be delayed until memory pressure
> >               occurs.
> >
> >        MADV_DONTNEED
> >
> >               Do not expect access in the near future.  (For the time
> >               being, the application is finished with the given range, so
> >               the kernel can free resources associated with it.)
> >
> > MADV_FREE is 'we are completely done with this range'. MADV_DONTNEED is 'we
> > don't expect to use it in the near future'.
>
> I think the description gives a wrong impression. What I think matters it
> what happens (limited to anon private case as MADV_FREE doesn't support any
> other)
>
> MADV_DONTNEED - pages discarded immediately, further access gives new
> zero-filled pages
>
> MADV_FREE - pages prioritized for discarding, if that happens before next
> write, it gets zero-filled page on next access, but a write done soon enough
>  can cancel the upcoming discard.
>
> In that sense, MADV_FREE is a weaker form of DONTNEED, no?
>
> >>
> >> Seems to me rather currently an artifact of MADV_FREE implementation - if it
> >> encounters hwpoison entries it will tear them down because why not, we have
> >> detected a hw memory error and are lucky the program wants to discard the
> >> pages and not access them, so best use the opportunity and get rid of the
> >> PTE entries immediately (if MADV_DONTNEED doesn't do that too, it certainly
> >> could).
> >
> > Right, but we explicitly do not tear them down in the case of MADV_DONTNEED
> > which matches the description in the manpages that the user _might_ come
> > back to the range, whereas MADV_FREE means they are truly done but just
> > don't want the overhead of actually unmapping at this point.
>
> But it's also defined what happens if user comes back to the range after a
> MADV_FREE. I think the overhead saved happens in the case of actually coming
> back soon enough to prevent the discard. With MADV_DONTNEED its immediate
> and unconditional.
>
> > Seems to be this is moreso that MADV_FREE is a not-really-as-efficient
> > version of what Rik wants to do with his MADV_LAZYFREE thing.
>
> I think that further optimizes MADV_FREE, which is already more optimized
> than MADV_DONTNEED.
>
> >>
> >> But to extend this to guard PTEs which are result of an explicit userspace
> >> action feels wrong, unless the semantics is the same for MADV_DONTEED. The
> >> semantics chosen for MADV_DONTNEED makes sense, so MADV_FREE should behave
> >> the same?
> >
> > My understanding from the above is that MADV_FREE is a softer version of
> > munmap(), i.e. 'totally done with this range', whereas MADV_DONTNEED is a
> > 'revert state to when I first mapped this stuff because I'm done with it
> > for now but might use it later'.
>
> From the implementation I get the opposite understanding. Neither tears down
> the vma like a proper unmap(). MADV_DONTNEED zaps page tables immediately,
> MADV_FREE effectively too but with a delay depending on memory pressure.
>

OK so based on IRC chat I think the conclusion here is TL;DR yes we have to
change this, you're right :)

To summarise for on-list:

* MADV_FREE, while ostensibly being a 'lazy free' mechanism, has the
  ability to be 'cancelled' if you write to the memory. Also, after the
  freeing is complete, you can write to the memory to reuse it, the mapping
  is still there.

* For hardware poison markers it makes sense to drop them as you're
  effectively saying 'I am done with this range that is now unbacked and
  expect to get an empty page should I use it now'. UFFD WP I am not sure
  about but presumably also fine.

* However, guard pages are different - if you 'cancel' and you are left
  with a block of memory allocated to you by a pthread or userland
  allocator implementation, you don't want to then no longer be protected
  from overrunning into other thread memory.

So, while I implemented this based on a. the semantics as apparently
expressed in the man page and b. existing PTE marker behaviour, it seems
that it would actually be problematic to do so.

So yeah, I'll change that in v3!

