Return-Path: <linux-arch+bounces-12155-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B9EAC8FCE
	for <lists+linux-arch@lfdr.de>; Fri, 30 May 2025 15:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F042DA46034
	for <lists+linux-arch@lfdr.de>; Fri, 30 May 2025 13:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98FA383A5;
	Fri, 30 May 2025 13:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="U6t9ZLy1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="osX4QV5u"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A931BF37;
	Fri, 30 May 2025 13:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748610689; cv=fail; b=hJCsTl8i++zhbTOVDpIj0d1sgWFrS6ZMG8l1dWlxf5BzREvogYgRaduM+LnPs3UV70cmkZkK5f84ykSf9xyGjELRWmGG3AbGKZLdyrbFCI2BIOQIcRmOte7fKmdV2PdfNiVev2gfc31jAlk2yWl4bMS+3O/LpU9abYg4ndVDY+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748610689; c=relaxed/simple;
	bh=JSTCbjdBlzAIBIwAlYCbqa9RnUsRlQqdZ6PJtZ6MZNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FEn6ePz0BuTNYILZzY7KRavsxnGjuVISJPk2lENc0V8l98ecpOFUtonB81NZ7Gbfm5uD9oG9AFN66Jxc57gixok61mExfjPtwbmnY1tSfj4Lke1UsihpR4dWt4boKZZ5aLn5zFGnpgxRT3Lp0TGzZg3hXbshZCAi0XFgABldp0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=U6t9ZLy1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=osX4QV5u; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54UAtP94005330;
	Fri, 30 May 2025 13:11:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=pC8wd/+R60NSl0MxVT
	qu7f5ARc9cO4vkvZ73vlqd2Tw=; b=U6t9ZLy1KopPvw1M/4iAZCrY4THhGDX1ma
	kaIMeg3WMmZkRpainDL9fmZ2Hu08rBihXaoDiZcwAECQ4XRjKqmHLHKFZzS0pP2l
	tUHi++9ciGj73phk6Z8+1hsc0WaX1YJDpdbX64Ed6js1kEFOnP5+L1Qqcs6kxu5B
	KsVIoBJzJ8qatBWQ3cfFoTPLGuYZ54Thak96mW/60XSHu7Ex/V8l1eDx/juWOSf1
	R9ISRO36OpcMHoXUHCWevm7z1mCfm1JkAIZnvmKHPAChfEu10M7tCUy1g36Zke6D
	aOnOieW/hlzFyTO48FZQdZmb054z5+9xJQr01+4MVGs/0pbw42Wg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v3pd9yph-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 May 2025 13:11:03 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54UD3pQh025746;
	Fri, 30 May 2025 13:11:01 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46u4jkh2hj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 May 2025 13:11:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p8CAKGs3unKNcRJ2WMKBOy1fPf0tTIUaE+tORNsZxm+vaK3L7c0EgsNkhjJFZx0bFwFX4CZI/JeYzbAHwGcpERPncgF5GsbKF2JRZmw9KILX53fEMSDdBiljMhejouFq8VGFqCUs4zrb8IjWXuRrysmO9bv9/E4sCzpQOJALTnppBJuFMPtr6qZ24CeqgbVpVb+yEw3Tymu7ZRdvWFdUHOZ241WSngP0C9ZTNvY9gkoWh3zRYqm+kXG1qP9e76g6pqZ5WW/2wDjJBuQtIMUhPfxh2H4d5EXSTZhXwZCoLim+sctUJ7jsOLgCrWyWxfUh1Ykb2fmEG0Q6rLEpnv9opA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pC8wd/+R60NSl0MxVTqu7f5ARc9cO4vkvZ73vlqd2Tw=;
 b=I6QirnqvjjCtvWuQ/vb4sy6CT9G7iGhNBnHQ8KDsDSP9ienFEi7LhoU4JB+hVs+CMJnFqwbyAZZmjkQqNwQkTdNnN06tDlIrU/zT77LaE2T2G+tQqNwd2Bm9hF1CdX1HG5W3hUbn1HMG7Ga9BizkHXu3eMCQ3g8IpWQ28Iomu8y1gu/Csm3nychFkP0gM/3EGRgF4XscjaFN6PPp1a+61Pf4u60YMwfKD6SwP1/Ho7vdkPlcz8JakdWNoBxgG/sE8z3pe6CFPAPvgZbTZZY0zEu1Owk0fOrEZ8e+avhxcaCYdksnXfbkWeK/iJdtBaq8srGTttP810+CzHKjztphGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pC8wd/+R60NSl0MxVTqu7f5ARc9cO4vkvZ73vlqd2Tw=;
 b=osX4QV5uY2BXvgoJ3WkZ8y8tgPpImBpYPqOquh1z/xElu7lM20xZClCJ22+hcxlW8iWodILD+NCMQ5+wjIyp6xY+sGVKue1iZ1UmfI0oLauPwKM4Rg7XXM2BzY+QmfC/uKgNmBRI7m47TaeCKIyrw20ofoP1NZXuo8gAQk9gsRs=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.35; Fri, 30 May
 2025 13:10:58 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8746.030; Fri, 30 May 2025
 13:10:58 +0000
Date: Fri, 30 May 2025 14:10:55 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Usama Arif <usamaarif642@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeel.butt@linux.dev>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>,
        Jann Horn <jannh@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <brauner@kernel.org>, SeongJae Park <sj@kernel.org>,
        Mike Rapoport <rppt@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
        Barry Song <21cnbao@gmail.com>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, Pedro Falcato <pfalcato@suse.de>
Subject: Re: [DISCUSSION] proposed mctl() API
Message-ID: <d7ccb47b-7124-45e9-ace0-b0fa49f881ef@lucifer.local>
References: <85778a76-7dc8-4ea8-8827-acb45f74ee05@lucifer.local>
 <e166592f-aeb3-4573-bb73-270a2eb90be3@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e166592f-aeb3-4573-bb73-270a2eb90be3@gmail.com>
X-ClientProxiedBy: LO4P265CA0226.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:315::7) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS0PR10MB7933:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c404d98-e953-423e-e67c-08dd9f7b6ac1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OB+ry4MyVBYFCzrmajzTXG70HAbev2JgJabFgi9eyH8lsPDya/sWRzPk3pMK?=
 =?us-ascii?Q?4YCvRxB8o2ZOH9N21542zsA58LCY8qiFUgW2EIs3sdI8VYuv4064JVlD+rcl?=
 =?us-ascii?Q?iKaRG89GeWw1wQZL+YhHool4dPTJ3QnUVRo7SmkOQtOdsu52ZvrfvHpVV+oV?=
 =?us-ascii?Q?o50KowoNSVgJChERw2rOaYJCsfGdupC6s3ZzGn+vK+4rZaTbgZqpRqPM/kWw?=
 =?us-ascii?Q?He1WsKW1k4Cs6DsiqSNa2j2/jCVPRCKU1XitJsDXRuMVqN0qpUaGqXLjj1lZ?=
 =?us-ascii?Q?j/b9Naahd1ATsSpcN85mD4i0xyggzAGdnjoR3iEb2Jl/LNrjTfFqWKwa4AWU?=
 =?us-ascii?Q?7WiA41wHEiBOKUYqGISUhwGXvLgEYcfZDUSgUFvZpve6ZkBlkbag3yOqyqiB?=
 =?us-ascii?Q?kDjd/dv27mZOUwPF6QPbsCFet2E28I3MY6/LQutyQNBtyb3jE+ptShBGU5/A?=
 =?us-ascii?Q?NHz05vCPGvTu7ZlRYN2/si+5in3lOx2+89B7P9WgDJcM66A8bkxKewar0X8V?=
 =?us-ascii?Q?gRZvkZV8OHKIUawkvznKRx6Eoc0VUy95US4eZx0g2jnG/Uy1Iii1Kz0dY9q3?=
 =?us-ascii?Q?QjRxyXaY9qSSfTpNXRh5srQBqJCtGWcjUhzjkHCy7xTqM0M9aPkxmefmP22N?=
 =?us-ascii?Q?5dCY68xDlGXhBLnb/iypx+Jaj22gNUjvsW6Dr5APYsHDqaMJ2maRbn2Hv0Qs?=
 =?us-ascii?Q?16VWR83PELHYPeUqz760ADE3cDAO7veBIzpHnPM3EqlR1Lsimx8CJS4wLb19?=
 =?us-ascii?Q?81X9drqdIZhOZZ26eeT6yFmBuHrIkfGAJ785ALB7RdhupxhvUOr/bDVgRP9w?=
 =?us-ascii?Q?0PhHYGio/gk3gLBAexss6uEuObnaz2k0ZHhnPQMgxZ8dmi9Vrlq9ZI7FFEzU?=
 =?us-ascii?Q?m8X11IUfFJn/aM3cYQB3S4KEOj+3C9sWjZ0PiIABFwfrk2mghl0exPYQ8vgc?=
 =?us-ascii?Q?SqmCz1uTcDR6AkUa0v1wqUqIxerC/X5juePD6SvOp2J537YXDY73YhAQyHRM?=
 =?us-ascii?Q?7TrIpa5EEnv9Tbxsv1o5qWVFNw97Crv2FBY5o4Gs9M7t0GSkyYr+9vbxBNgS?=
 =?us-ascii?Q?0uQp+jd/3W0BkSqmTd93FZHQPnOY3jbzvfM5V8tsEJrS4YmR5F1P+R2XrhGF?=
 =?us-ascii?Q?G02yJYBSegrg/kjasMmgM5ELsEyp/+XlXBeM2CvGyOL161Q/G4kzw7fQiIjh?=
 =?us-ascii?Q?mPOc+tKE+YnKlod236cPBwDbainY3Xb3wGM4tfq1n1K4+g2jLCfrCW8OXl2T?=
 =?us-ascii?Q?OWe5PRRV+mJjkISJBK17lIWpVyH2p1x+hFQHvwjKRhAirKzMCprjX5TCXzfV?=
 =?us-ascii?Q?pEM8pFSsamDazEy7npvqzBDT1BFJoVyZ1XkNGCMfYgvooJVSzpfMHYJ8QCSh?=
 =?us-ascii?Q?yvfnUN6BgTi4z4avRl2kYLt6HBFb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yl8vwRydC7Z01jXFjIvBYITMgpm8DUtFQw7OSutPA6OB4AC0ifxerMeSzj//?=
 =?us-ascii?Q?lqGQQoqP8qH7L1FcilC4j316eo4KyctSKWA3GJwL8X1VMcSXS0KH4exBZQQ5?=
 =?us-ascii?Q?NrQg35krMZc4cy8w7WJjLxxtAcfABzrk/PgAfdWlGpvlS4BJKwSDdXPSYl9B?=
 =?us-ascii?Q?xhgfkhixBFusgcpAVe5CzbghPZrRZ8UGMp2A496xn8u2/T9EXeDZpiDlKAwX?=
 =?us-ascii?Q?+ydhzDKK3jU3BQgbDYDHh+s6ADNDN4INgcobAPBnG0QkJKdISJjFfciCF8+6?=
 =?us-ascii?Q?9adc6s/3yfOfPXcreUqnG5HbfiLz4iM9yviEFriR1qYVMifwGBDV73rsbKR7?=
 =?us-ascii?Q?TqshhTi61TnxEYgnSCgIqp/NhWEU/pDk8XWA3NBc+AIBft1SaA0emt1og3vN?=
 =?us-ascii?Q?GsEY1KcKvBeHe0EPrSvdzjmbTF2DogCd9IQgpN2VNAxW23dSpf4mASsGzgAO?=
 =?us-ascii?Q?rSqYUxBh9x32x7VjvKN5Cu6OrkLxXv7HEnZoXLbT2ZzSIUQMxyLfzBxuAvnY?=
 =?us-ascii?Q?lvpCQ2ItfGZHYdvdZxiFMBYP95EGkvAQD/H84J2/3dEt3/hUXheGVxqqwBJM?=
 =?us-ascii?Q?jDkxdNxvYKK9pIYShN63BEOMmwIt+4lXyd2MpZloeIFCDtDe+GHdePCZ+CPO?=
 =?us-ascii?Q?noVEBeQ7Su8OQljtNxODnMImUxU73jHUbLsUV5ZS4V5AKA5cP+oRsA0QrAtm?=
 =?us-ascii?Q?yFdYRgctoXaGWuovqCff43ooBbWJcticOy7O5T5x4Ly8QzlpY3MqQSJs2pK6?=
 =?us-ascii?Q?iyiNb2f3K/WDaE0UaiQqhILM8cFxaefTMzcBeRaiyBPwpoAEnyuZC7jr79zW?=
 =?us-ascii?Q?U0C9DsbY9gAJd8eO5F4oU2NFTPNDG+ohpL/oNvw9yGKEiVb1s21FfwiJ+cQz?=
 =?us-ascii?Q?xj4dnpgvOXi6EpRnbxYpR8DlrPHo25Q8OI01CwKN/st8CE4PG1PIZrLF+/+W?=
 =?us-ascii?Q?wZ6C0bViohxCEg2rn/GejTfWU1qi6ST6evFkp+rJKl3xDkINjwj3VUA/r/+y?=
 =?us-ascii?Q?YjfJ/u3248O9rJc4XUXhW1IRXU7gERcp6OJvjMLMmszw9r0cJnpgTtynDbX/?=
 =?us-ascii?Q?pKccvaf/ZyFtvSeUYOD+qyOwlSiqjNY6M6P1b9rhW57AXLPnMZdTle5QVZnT?=
 =?us-ascii?Q?NQR+eEo90MEMp8x0YhlFGTVKifpQx98/U1R1KTG+N2IvyfZA8gQXmqvjqLAu?=
 =?us-ascii?Q?ArnENQXuFo5F8cK9OVspWuR/v/PgADJhDXvfG7A3feOe8Qq6HT6crVH8ijiI?=
 =?us-ascii?Q?j/XA46w/kGBf92uf9Bj8XkwQveN87VP5yYR4Pnqo1InUlllln5FI0S8ppfVv?=
 =?us-ascii?Q?+ETCkzQXfJoNMNhjeXAbOc4svBLEVknhB9idrpKT+nBe54vUhXakHiloUDdk?=
 =?us-ascii?Q?CGuRzLRwrDp5HDcYXmxNyN+gL/lKIbFLI9/H/2rKWxXZIL8PbAzIg7a6CQYQ?=
 =?us-ascii?Q?A1y/50cbztB7TX1dy2n2xoDs9eGZptrzYCof3/0aYJFVrbVJWkbLQtVaMg9k?=
 =?us-ascii?Q?rSFYMjSynmBNLGHkI7ckgWBbikTJ4z1TqXYeZ4SQWXnPCe24DIOOnkKcdPUW?=
 =?us-ascii?Q?6kIxzDb9116Li//YMlaygTvSgX4vifancVIRcDQIlHqN+cRy+DuCTP2GWm/l?=
 =?us-ascii?Q?XA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fKAva9Uj1dIBtGrBU01UzlRCr3XYjtd5wHAl9nH05K1dc4jIMZoB/wVKoNMXPwd7edT5Y6qlt6xTW3tMYe5AcWMVhPOp1nV3/UPwN39y/ir7MnMA77iWqmBB6VSqVxupaL80NPVk/jw4ZAO7do91K0S5pwnaQoDbNeHSzTkPFj6hW23YHKmbWYrtV0a7h/zS1HtOYBC5XNwe+hqYWp4iv8UcuwwUOd6AS3oI3ftkSp3W2YGHzRsujrIxXUS2p7Z2ohVn41bTJTs1xAxdFV1s+OAk64/SPPeROcMEJ1VFl9VNBcBWgCEVdivxxmIkzkdJHKm9QAPObRlJ5pAbG8H6d3XMbrqCbFifCRVbPezpN8pCcIiOFri7OWf7W9SP0WJo3EwV5RB9Ee4a3zwBmC8rs/WEMviv5M4+frhUuijHgHgxxwwyjYZSb7NYrY4QEj0tU5wLAOZ7Cl00Aez+Uvys5mQ9+gDNbN+7w8XfvuEiuO9z2hMTf/BLV9E8CVd5HsdMReDHhmILjykeWIBAf8K3DaWs2tEJuLtpugP6T6bpwGEeFCPDwJkJrTIBWPvi/ScYB3RXi/wC4LF3357xCSUK2kSCvCVSoyy3inUH5HfL/40=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c404d98-e953-423e-e67c-08dd9f7b6ac1
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 13:10:57.9435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gx8zPlnXPr0dwwLki5EC5J/yJKvjwtZDmQqkccDRW5z63JdS9h1ehHxwoxQt6aJcJNKJRJxMZEz7RfTFAcAzsrg9mllq0pJCxXKMtnpSJ38=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7933
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-30_05,2025-05-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 phishscore=0
 adultscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505300115
X-Proofpoint-ORIG-GUID: RdUwimOfrfod-uyP3_kWCmnCQ1MbFXaM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTMwMDExNSBTYWx0ZWRfXytPen0+ww8NG CD9oB6fvYCYn+/M65rNjVbPIj5cFHdxmy+iIoAFxuoIMNiFFLXOfUWwHTEdLK0jxtNpVQLzRNnN vyDNXvZ8Mu54YE8Hrh0/Dmu4C3YUEGCp4hKPuRCzGuHZBTI6uzGtPdyjes0QsFpv6xoMwv0SGm6
 hXmxgd8Esn5j2EPWqnrgdw8S0G670wzE7RRoggJj+e5kQkewXQ+HPD3z01k1mvEXGH7tO2s8IXw qqbDNPlvYX9QU3hp/kdhJXRGcMwCQSAVDa+WQ6W5OfoJun187sym/J0TkxpuEibSF/oocLiCtcu xbsfKidcDtFIVXHG02f7fR1H9FhCeUtkXnQXzsFX8kyH60QWOdno24kBXuRuGP0qbENsGoUseh7
 85gVWUXWZbTxamMySd2yd15+HFEmaDK0Pz3q60A+aPGM/EQEQnNPSG6EQd17Xq7wfAv/h3jD
X-Authority-Analysis: v=2.4 cv=UZNRSLSN c=1 sm=1 tr=0 ts=6839ae67 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8 a=NEAV23lmAAAA:8 a=ntC1vYa_JTQSKSf0F1MA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13207
X-Proofpoint-GUID: RdUwimOfrfod-uyP3_kWCmnCQ1MbFXaM

On Thu, May 29, 2025 at 06:21:55PM +0100, Usama Arif wrote:
>
>
> On 29/05/2025 15:43, Lorenzo Stoakes wrote:
> > ## INTRODUCTION
> >
> > After discussions in various threads (Usama's series adding a new prctl()
> > in [0], and a proposal to adapt process_madvise() to do the same -
> > conception in [1] and RFC in [2]), it seems fairly clear that it would make
> > sense to explore a dedicated API to explicitly allow for actions which
> > affect the virtual address space as a whole.
> >
> > Also, Barry is implementing a feature (currently under RFC) which could
> > additionally make use of this API (see [3]).
> >
> > [0]: https://lore.kernel.org/all/20250515133519.2779639-1-usamaarif642@gmail.com/
> > [1]: https://lore.kernel.org/linux-mm/c390dd7e-0770-4d29-bb0e-f410ff6678e3@lucifer.local/
> > [2]: https://lore.kernel.org/all/cover.1747686021.git.lorenzo.stoakes@oracle.com/
> > [3]: https://lore.kernel.org/all/20250514070820.51793-1-21cnbao@gmail.com/
> >
> > While madvise() and process_madvise() are useful for altering the
> > attributes of VMAs within a virtual address space, it isn't the right fit
> > for something that affects the whole address space.
> >
> > Additionally, a requirement of Usama's proposal (see [0]) is that we have
> > the ability to propagate the change in behaviour across fork/exec. This
> > further suggests the need for a dedicated interface, as this really sits
> > outside the ordinary behaviour of [process_]madvise().
> >
> > prctl() is too broad and encourages mm code to migrate to kernel/sys.c
> > where it is at risk of bit-rotting. It can make it harder/impossible to
> > isolate mm logic for testing and logic there might be missed in changes
> > moving forward.
> >
> > It also, like so many kernel interfaces, has 'grown roots out of its pot'
> > so to speak - while it started off as an ostensible 'process' manipulation
> > interface, prctl() operations manipulate a myriad of task, virtual
> > address space and even specific VMA attributes.
> >
> > At this stage it really is a 'catch-all' for things we simply couldn't fit
> > elsewhere.
> >
> > Therefore, as suggested by the rather excellent Liam Howlett, I propose an
> > mm-specific interface that _explicitly_ manipulates attributes of the
> > virtual address space as a whole.
> >
> > I think something that mimics the simplicity of [process_]madvise() makes
> > sense - have a limited set of actions that can be taken, and treat them as
> > a simple action - a user requests you do XXX to the virtual address space
> > (that is, across the mm_struct), and you do it.
> >
>
>
> Hi Lorenzo,
>
> Thanks for writing the proposal, this is awesome!

Thanks :)

>
> Whatever the community agrees with, whether its this or prctl, happy to
> move forward with either as both should accomplish the usecase proposed.

Awesome!

>
> I will just add some points over here in defence of prctl, this is just for
> discussion, and if the community disagrees, completely happy to move forward
> with new syscall as well.

Please do - it's vital we have all sides of the argument!

>
> When it comes to having mm code in kernel/sys.c, we can just do something
> like below that can actually clean it up?
>
> diff --git a/kernel/sys.c b/kernel/sys.c
> index 3a2df1bd9f64..bfadc339e2c5 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -2467,6 +2467,12 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
>
>         error = 0;
>         switch (option) {
> +       case PR_SET_MM:
> +       case PR_GET_THP_DISABLE:
> +       case PR_SET_THP_DISABLE:
> +       case PR_NEW_MM_THING:
> +               error = some_function_in_mm_folder(); // in mm/mctl.c ?
> +               break;
>         case PR_SET_PDEATHSIG:
>                 if (!valid_signal(arg2)) {
>                         error = -EINVAL;
>
> when it comes to prctl becoming a catch-all thing, with above clean up,
> we can be a lot more careful to what gets added to the mm side of prctl.

Sure, and I think we were to decide prctl() was the way to go this would be the
way it should look, or at least specifically for this case.

This addresses the bit rot issue but not how hidden the functionality is, what
prctl() generally represents de-facto (that is - a catch-all for obscure stuff),
depending on the interface of the function it might be harder/impossible to
userland-test and of course we have the beautiful vector-interface that means we
can't restrict behaviour in the API in the way we'd ideally like.

I mean overall there is no beautiful solution here.

As Matthew says, the reason we're struggling here is probably more so because
this is just showing up a flaw in how THP is these days - we really ideally need
something automagic where the kernel figures things out for us.

But in the meantime we have this frankly kinda terrible interface that's rather
off/on and yet want to establish policy _ourselves_ when the kernel should be
able to figure it out.

But with that said, we must trade that off with the reality that there is a need
for this kind of fine-grained control now, in this less than ideal world we
currently inhabit :)

>
> The advantage of this is it avoids having another syscall.
> My personal view (which can be wrong :)) is that a new syscall should be
> for something major,
> and I feel that PR_DEFAULT_MADV_HUGEPAGE and PR_DEFAULT_MADV_NOHUGEPAGE
> might be small enough to fit in prctl? but I completely understand
> your point of view as well!

See Andrew's point on the syscall thing, they're cheap ;)

I mean the idea of course is that we can put all future stuff like that here
too.

We could even port some existing prctl() stuff across, in theory. But having 2
ways of doing the same thing would probably suck.

>
> > ## INTERFACE
> >
> > The proposed interface is simply:
> >
> > int mctl(int pidfd, int action, unsigned int flags);
> >
> > Since PIDFD_SELF is now available, it is easy to invoke this for the
> > current process, while also adding the flexibility of being able to apply
> > actions to other processes also.
> >
> > The function will return 0 on success, -1 on failure, with errno set to the
> > error that arose, standard stuff.
> >
> > The behaviour will be tailored to each action taken.
> >
> > To begin with, I propose a single flag:
> >
> > - MCTL_SET_DEFAULT_EXEC - Persists this behaviour across fork/exec.
> >
> > This again will be tailored - only certain actions will be allowed to set
> > this flag, and we will of course assert appropriate capabilities, etc. upon
> > its use.
> >
>
> Sounds good to me. Just adding this here, the solution will be used in systemd
> in exec_invoke, similar to how KSM is done with prctl in [1], so for the THP
> solution, we would need MCTL_SET_DEFAULT_EXEC as it would need to be inherited
> across fork+exec.

Right yeah, this was the intent.

>
> [1] https://github.com/systemd/systemd/blob/2e72d3efafa88c1cb4d9b28dd4ade7c6ab7be29a/src/core/exec-invoke.c#L5046
>
> > All actions would, impact every VMA (if adjustments to VMAs are required).
> >
> > ## SECURITY
> >
> > Of course, security will be of utmost concern (Jann's input is important
> > here :)
> >
> > We can vary security requirements depending on the action taken.
> >
> > For an initial version I suggest we simply limit operations which:
> >
> > - Operate on a remote process
> > - Use the MCTL_SET_DEFAULT_EXEC flag
> >
> > To those tasks which possess the CAP_SYS_ADMIN capability.
> >
> > This may be too restrictive - be good to get some feedback on this.
> >
> > I know Jann raised concerns around privileged execution and perhaps it'd be
> > useful to see whether this would make more sense for the SET_DEFAULT_EXEC
> > case or not.
> >
> > Usama - would requiring CAP_SYS_ADMIN be egregious to your use case?
> >
>
> My knowledge is security is limited, so please bare with me, but I actually
> didn't understand the security issue and the need for CAP_SYS_ADMIN for
> doing VM_(NO)HUGEPAGE.
>
> A process can already madvise its own VMAs, and this is just doing that
> for the entire process. And VM_INIT_DEF_MASK is already set to VM_NOHUGEPAGE
> so it will be inherited by the parent. Just adding VM_HUGEPAGE shouldnt be
> a issue? Inheriting MMF_VM_HUGEPAGE will mean that khugepaged would enter
> for that process as well, which again doesnt seem like a security issue
> to me.

W.R.T. the current process, the Issue is one Jann raised, in relation to
propagation of behaviour to privileged (e.g. setuid) processes.

W.R.T. remote processes, obviously we want to make sure we are permitted to do
so.

>
> > ## IMPLEMENTATION
> >
> > I think that sensibly we'd need to add some new files here, mm/mctl.c,
> > include/linux/mctl.h (the latter of providing the MCTL_xxx actions and
> > flags).
> >
> > We could find ways to share code between mm files where appropriate to
> > avoid too much duplication.
> >
> > I suggest that the best way forward, if we were minded to examine how this
> > would look in practice, would be for me to implement an RFC that adds the
> > interface, and a simple MCTL_SET_NOHUGEPAGE, MCTL_CLEAR_NOHUGEPAGE
> > implementation as a proof of concept.
> >
> > If we wanted to then go ahead with a non-RFC version, this could then form
> > a foundation upon which Usama and Barry could implement their features,
> > with Usama then able to add MCTL_[SET/CLEAR]_HUGEPAGE and Barry
> > MCTL_[SET/CLEAR]_FADE_ON_DEATH.
> >
> > Obviously I don't mean to presume to suggest how we might proceed here -
> > only suggesting this might be a good way of moving forward and getting
> > things done as quickly as possible while allowing you guys to move forward
> > with your features.
> >
> > Let me know if this makes sense, alternatively I could try to find a
> > relatively benign action to implement as part of the base work, or we could
> > simply collaborate to do it all in one series with multiple authors?
> >
> > ## RFC
> >
> > The above is all only in effect 'putting ideas out there' so this is
> > entirely an RFC in spirit and intent - let me know if this makes sense in
> > whole or part :)
> >
> > Thanks!
> >
> > Lorenzo
>
> Again thanks for the proposal! Happy to move forward with this or prctl.
> Just adding my 2 cents in this email.

Thank you! And your input is most appreciated - it's important we get all sides
of the story here!

>
> Thanks
> Usama
>

Cheers, Lorenzo

