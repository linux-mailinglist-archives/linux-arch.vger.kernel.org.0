Return-Path: <linux-arch+bounces-12046-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E28DEABE9BB
	for <lists+linux-arch@lfdr.de>; Wed, 21 May 2025 04:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1CE01889D85
	for <lists+linux-arch@lfdr.de>; Wed, 21 May 2025 02:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917BC4689;
	Wed, 21 May 2025 02:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JfeGTmY5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="e0pO0xjx"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC621993B7;
	Wed, 21 May 2025 02:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747793807; cv=fail; b=ItocYS+i6eQHEnaUWDihw/ktMBbbu9nUB/WXrZ5SMQ5DvFcqq1sOuaq+6E456G87gh8JchlQm/jqhPAECpUpMeDbRQ6qNxPL3H93lX6eU7f6V6OgAGEi1tBwVXYHSY/P7HQzyrfBqkGfQoPeXuX2/vvDTww2GsbQpjPpe9wa5ZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747793807; c=relaxed/simple;
	bh=goXMpW1IZxAUgRAgddxDQLq3uqDQA+YO50pYTXmkOhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Jpr2uui4/FjRzSJp2zS07GuzYevIy7sKlzlaDCPkjy+ZCmvuwrgNts9RXsc/ASQItyETCXUNjM/yVopNQ40En2ugbgl5W8Q45I0surC5Iql1HAHWuRUzxOgVzegR1+m1SIdDGScVFMo9vbLxJ7zHWiZp3HckzUl+Nzzjqg2NJDE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JfeGTmY5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=e0pO0xjx; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54L0gRYu005990;
	Wed, 21 May 2025 02:16:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=AleGMiRVnmhMJNeiAG
	c1fWh6aA2TolX3Q9YiarhBd5c=; b=JfeGTmY5hSwKENw6lw4vO26UI7yArjXSV0
	YfrfWH/NoDSPAPno1DJnaCZmCktZz6BMQKKx9hhk61ksrcY6oStLVAPT3G++1EFI
	kJ4+FAmkIX218G+6KMXa+Y/8GNeqVofSWrQBO0xV279TZI3OGMX/WI+FuQ1/oQB4
	J5jHQN6jqmKJ2QO3KWjMtW4aFyfNdXchJWBxQGxNiduZ4ef/iEavYhPnAnmRJDTV
	hKIhNdmEmwadAEyAX5RWlaavYL14DytgHL2R8dpdZAN2JMPUO9a/s+eQUqhjBjyu
	dVAh6mDnavbvfKuyq7sQhlxIGPdef/OwT4iLlkSGFf7ZOdcTgYnQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46s4h104s6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 May 2025 02:16:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54L2DlRg032206;
	Wed, 21 May 2025 02:16:27 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46rweks80h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 May 2025 02:16:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EkRW7unNhOw4agw8kWYm2/KOM+QjnTMygJk9spSejxE2IDvqrM+gOkARcGQhvZ69TbxG7KnpjreRt8UVdliN8jxQ9MDvzV+Q5uT7UY5IrF6cfr1Esf9pu10xhylOVhlP3grHtZlTcOalOXMm1o2Lcb906jz5NRchAAZmHHf/mfRmjTU6MFTCVMk5l77t4EpT6ZNuPlISoBUx3+qSYbEeXbKti8auRm0l8cW80OVwL8ENCd4SCmwMz6MQ8iwmzJyapmp27O3J0qBsDEboW/vfoyBs7IzujwIApp6sxPFssgsQX2I9+w3kHyCRqngA5nZ2+oywGLZSkB+OjVidFfBs/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AleGMiRVnmhMJNeiAGc1fWh6aA2TolX3Q9YiarhBd5c=;
 b=eWqA5jcozlRNy2GQm75UF5il5Ausca3uB9MHdZ30uPS8KsCfZ4hQXdFEkJahI9SroGeUJsfiT5eCLDiPMCJeAT9UFLG3CCTnw/tJhYFH6DNtVpbD/riCemiKtD1TESVDHJOEgFfUAaAUwYCKuphmzI2VM4V+pL3qT5pk7bZrGIa00IbBZXv3yxLITr9kEvrPLXs23yEiyCSgUMklk57WMQWkzZtdgEj56UUir/CzCLHRsGpjt5lueyJxxvlfmsPYx9Igxv5WXokYzOVyElPZX7V6JoXg0FZfQHwgHAKMCV95jTVHmuB9YSpHLvephl+VS1JwFIQ54z5e/Go58hPqbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AleGMiRVnmhMJNeiAGc1fWh6aA2TolX3Q9YiarhBd5c=;
 b=e0pO0xjx1GpPP6cGpi/8GfNMAHvw0nTyEs2zdzq8UwRAubx6+l7/7IwxW44DlqVnz8C5JzY1ACUC6d/j1O5s7wF1c4etVkUDvZJKVaD7LOrjxoN2oRdCnn7o3msrDh9eFKi3rIvYeKuItI5U5WuXGbsP8M2pp5BvkRiq+hlnAbs=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by PH0PR10MB6434.namprd10.prod.outlook.com (2603:10b6:510:21c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.34; Wed, 21 May
 2025 02:16:21 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%6]) with mapi id 15.20.8746.030; Wed, 21 May 2025
 02:16:21 +0000
Date: Tue, 20 May 2025 22:16:07 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>,
        Jann Horn <jannh@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <brauner@kernel.org>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sj@kernel.org>, Usama Arif <usamaarif642@gmail.com>
Subject: Re: [RFC PATCH 0/5] add process_madvise() flags to modify behaviour
Message-ID: <4jw2sj6zxi64xmjbfwdthwboeftz2ucmrkvk2vvrf5sx7vxzoq@rotrm765fbfl>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, Arnd Bergmann <arnd@arndb.de>, 
	Christian Brauner <brauner@kernel.org>, linux-mm@kvack.org, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>, 
	Usama Arif <usamaarif642@gmail.com>
References: <cover.1747686021.git.lorenzo.stoakes@oracle.com>
 <7tzfy4mmbo2utodqr5clk24mcawef5l2gwrgmnp5jmqxmhkpav@jpzaaoys6jro>
 <5604190c-3309-4cb8-b746-2301615d933c@lucifer.local>
 <uxhvhja5igs5cau7tomk56wit65lh7ooq7i5xsdzyqsv5ikavm@kiwe26ioxl3t>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <uxhvhja5igs5cau7tomk56wit65lh7ooq7i5xsdzyqsv5ikavm@kiwe26ioxl3t>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0101.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::17) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|PH0PR10MB6434:EE_
X-MS-Office365-Filtering-Correlation-Id: bbda2d6b-b651-44c0-f6b7-08dd980d7a73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EcTuHjg7tShnj6zb99ruxghVhxRCDD5YhxyL+osFXloQZtkFi/sMK4HBj59w?=
 =?us-ascii?Q?a+21tnZMQjvsH0XaNaihGwQsYX+veMuYX5Jo836Msx5tlsuBrwPiaLa3K+tO?=
 =?us-ascii?Q?2DQb2W/qTtWlrLyXa27bS+cqJBPt8vkhtwwOJ1nniv6e93Pm6fsRrRy+1wB9?=
 =?us-ascii?Q?OzzhGIDOPNU4L9Q1PbH3cgr3QPJ6uu9jrY/G43J/uxW6Y+oFccIG18Xsa15N?=
 =?us-ascii?Q?vtLtXJfBrF3W81Q+CoG+KsZrUedSU+oEni6y0Vz59SS2o01tA8LN+vI9MpCM?=
 =?us-ascii?Q?TOf0XWixlg69/m7Ju9U4bphyL4RudjBYIOfVTl+1eM9lhiX5xhUB7uvWRRje?=
 =?us-ascii?Q?zcG7JA0xNlx+WpsO0+HQ76nVWgqRgV4MfFA+ZEn9UXMF93p/nnOWHeAksWLa?=
 =?us-ascii?Q?CR+pqjDFRH5SoWsFngwaUI86yxGBT/xqVoiS3cKvwpNLr0WwS0s93AtIDdsk?=
 =?us-ascii?Q?mst09oqNgNM8y/ltxBUocKoj7z5F8KDT46qoieaRLxk9xfrxoxBBNfGf/8ee?=
 =?us-ascii?Q?H3efkVe0r0YGjcs9G3Zh8BnB9YqfznkqVHxPkK7Wlb0K6hQ9KeIccHNV2Ktd?=
 =?us-ascii?Q?16aulCzlqHtQuWEpSh8Lna7BEEVvOsebR7ZFMIbIPmXs+SExYTYMTvVGSLnL?=
 =?us-ascii?Q?dHs+0KUrmEqeAyMDpY5lTnLd3o4tovrUqBIY/ZA9r2RHyEn28ZIql5rcp9lJ?=
 =?us-ascii?Q?9v/aijWMiIHoKGvtwp9SJMcxBZf70qUlB1zq8PoERAdBmfaOup/h5ZxcY0a8?=
 =?us-ascii?Q?n2xCyjxfwEEiAmiQmw8OXW6GY6xp+MjjCKDWl3Xuch+dbpDZqQXkCtYMIo6w?=
 =?us-ascii?Q?9Oel4CHw218CJW+6tTSqd3EREC7RXQ6R5kSU5GKztqJc5hM1pJpQRXelunNk?=
 =?us-ascii?Q?ZFIIsalSyVqYJuCDeSCsK9Wsaf6PKezoRjc2rVpOG9+4ioLFzUmrBYyZyk1z?=
 =?us-ascii?Q?bpVCEv5HY4eE4ln16pcEWQpqXb+KS2bDlm/WwCJSYKU/Jr9vTTaXzpB1cjm0?=
 =?us-ascii?Q?XwiFKkx4dygr6tsMdVNKiHTT8A9CZqMNBcRooCGQpCQNvnXAhheaNIMAgFN0?=
 =?us-ascii?Q?vBMLhldvyeWXHb4XkqRkctvBJ4IsoaNSKjgBj8P02HVimyOgVqRTVZasVMEc?=
 =?us-ascii?Q?u3izqhKvxWkxB0E/iAElVkCfR90bzsiMJgCbhn4pEnLwblmIj8KHw/NUmnSS?=
 =?us-ascii?Q?Ymet75ZqB0xPLiPYPFeK4nQqdy1cKhu4LJm4H28+0SiC4G8MMUVfGyIDU2vj?=
 =?us-ascii?Q?bzwHioA4wS37PYsZe1Hz5nwHIhq3U/eW4hxPaU88NqfmQmXpyQYJI1nhhuT6?=
 =?us-ascii?Q?9tXNNwaX+QkJ9AFzzp6SWhzJGVdjSYp4+lddfc9qLoZd3u7OcHd/F9EcpXIu?=
 =?us-ascii?Q?fzv7KS3bygjsL81iAFV/J0Ab5DF2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?96E7dfpr3SEFXGqFwyD/QXG4NDDiAceopGyUpFAIhOCniJGNOXiIzTKAPt2Y?=
 =?us-ascii?Q?tiHdMFsqMf2RIPIRIxC078bWAz9r6KzSmVeeV6KrcC7fHJWdKb7BfYeZTOVk?=
 =?us-ascii?Q?61qeyicoQ7yolRlncR3+9IpcPOPGg/z0BolqIHAij8NhM0G8dVCVJuhA8ZWW?=
 =?us-ascii?Q?beq5HM/jiMxlu9VB6Bdjzw66eCzrerRVz9m+LeaQy8k0/Ydb5iyZQ0sgvezz?=
 =?us-ascii?Q?FpdkbeW+MpBBUDy03l0HjLqcP+agztg2Y6WR4H/WkK9FQzlb2e2gZv9PpNyk?=
 =?us-ascii?Q?peht2okRVsHbjr6trUXdDkR9pFctg2bROXSVPX9sDWr5+qg6I8uUytM/lDyK?=
 =?us-ascii?Q?DlpNwxzkzFy7fVTVVpwP/IY1+Hsn4L+H1NfXcmnwEQvu+7RLcO7qDVVS4Lz0?=
 =?us-ascii?Q?CVOoq/Zc+t5daMuqfYmapq34gzjtQkksYcztcvHmBscKHgIa1baLlnXm3My8?=
 =?us-ascii?Q?wk++FzG3cWK5wo9JlQes+5tOINj/9e4sp/XrVb/0uPzKIwsmyW11hEButKdy?=
 =?us-ascii?Q?6rNfcI6YoQ//chA3DUD+j2Z+pwjiVzTWvfY0Vd6pcUr3dTKJot7i+TxG2e2o?=
 =?us-ascii?Q?oBhFi44u/nQFaK980QGKGPHuDZZTWeSXFbJJjS2jOlxPWH9vYuOYfLihqG0n?=
 =?us-ascii?Q?cOnyzaRw39DyaZUXcALWVjECqgT/moVbqVkQGjqu3PUvqTuvgrk7kePqCG6w?=
 =?us-ascii?Q?d3SZhfwSvTndfvaQZUFlTXw7LH+ftcaQw491qY48kXMZyxaKbRuKy6GJnYaS?=
 =?us-ascii?Q?kxfCQ365CjlzCAwLW5gkcD0GAQBzvgtureeI7xy4pYz0OHwTqVGSBGzCOq/8?=
 =?us-ascii?Q?FtyNk1It/wjoYsi1bAqgXlYMY227KBwUBLO17BUGFXZmFxSmJpKC62t99LiK?=
 =?us-ascii?Q?zyJ8xk2vy+RYMLApo0IhGU//W5izEr7rjgtNzw1hmbpa4VA3VBc7I3eatMcP?=
 =?us-ascii?Q?5XZ2cDNljVQT59Bq9YW3d+CnEXKHRdlUg8Ymzmp4Ki9pfAZgt03rMaA8/+SP?=
 =?us-ascii?Q?7ldtvtoG+pMckqPKE//HIvKkGUfTuUnN/nzIR1aZN8oZx5NDToWNOUeGJRgd?=
 =?us-ascii?Q?W2g6JtFGrfWMNma3Mw/Uo7RwfA5hUbO2WKgag1HyuijIfVvhBy3CT4efwL/a?=
 =?us-ascii?Q?XWkVi4k1MLnyYaQYIAykXmynxjhJxdIB/sxZzJkHlN6oWskRVBZZRMMug80V?=
 =?us-ascii?Q?QU/Ia9R5qR+p5eq7cUhakEXQNfmbsm0l2lzcB6A3PKL5uTmX3Gb8scpAZ1XM?=
 =?us-ascii?Q?Q3e5w1AjGWv5pWcsVqQNDuADPY4gW6ocYjZy/5pOkovHSmy+5GL3yyf/n1qm?=
 =?us-ascii?Q?gff1hC4c0eddmhqnjBkBwqisLpv3IXQG5F3hUuGS3/VWfX6f4aAWJzylc2LE?=
 =?us-ascii?Q?RwO2Dnz1AuEi+MsTR59V/0tqVJd6GT7lmn/J7coOFpAVt44sxmq9NWLhEDoB?=
 =?us-ascii?Q?9TQFvfzTwjLCC4yq48/lqNmFBwqwd/hqTM2kWPmIYcUqx/jIPfLIm/0nrrsb?=
 =?us-ascii?Q?4ntz05icA9vVsyW3niRLz/VB+Q4dgxrex4m1bAh7gtKVZ6KmYHuhwlxr9X1k?=
 =?us-ascii?Q?FrM+v5j8vOdRqq48ZcksDgOcrhDInR6X4tTH87H3?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QT2y4aSqbZYMmztJqUPLq/L/jn8py6egdscGzGuZ0Gu9HmGoiam2CyFnkABeV0Nf/ui8wBTk8ENZCnDqq540FfQWtt31WhusykyFNC8WWBP817g0SKEqlwhD/fIsVtjLYLaYnTxMXs8X1nsoDyK/Qsi4tWYZ5U9X/fVSYnr2zt4ndv1GqH5G0tMDn5CkoEWWKuE1AZQhQEPu7RAtyEIYGQATsNQvVr5dQ6HaRtqSU6XWt7IAspSu/DKsi4/U1p75cN4GkcHAR14RgnTDzKBV7KXpl8sEwqUvdBg+oKCRB5MgBMbFouTT1YDuOa98wNgX/g382tPPKS3eYnzTArQqHWYJFryN8Rv3KKd5PtvSCvCKbHrn6pckLOiCyDdFz0mGATpMvg3OC8eqfX08HyNFRJCVwqCkUAyoBcwY29cbqeu1dXjLxtkNaZd0JHG0fLNJROBNr/MW7cS7KLy17e0bmuUP7mPjUdNWk7VpASFoQgYHCDANvaTqFtc+RYcBYu2XHb3o0UTMbcEjcwbAHXsks9Fvr4X8Hya4KV0uo5jfSLmuGx0g5TKHUBPsj9z9Uwnam1O7YLcc3bkfaTbWAwfXW68UpX2fjew1YJ7GZK6wbwM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbda2d6b-b651-44c0-f6b7-08dd980d7a73
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 02:16:21.5495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: th4aVpM6Ls1jS/PTc3EEAS2mbXrbaTB3bArfS8GmhwkvNQePBw8F3BvHSuefnNE+cYr1anEd5C3EBRwTANUCYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB6434
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_01,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 mlxscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2505210020
X-Proofpoint-ORIG-GUID: -I093dxHC2Oq3NRTVX3dDTCjhKrkMVdR
X-Authority-Analysis: v=2.4 cv=d/b1yQjE c=1 sm=1 tr=0 ts=682d377c cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=azuNYdDSJcKUf-lGKZYA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: -I093dxHC2Oq3NRTVX3dDTCjhKrkMVdR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDAyMSBTYWx0ZWRfXwH6Vv/Dk6O+p /ZAGZ5i7Xlp8joNyn0cZ5of0JAK7hnDlXE3qkzhFsg22u6m3iXXHslQRSbaT2s12fbF7ioRWeyV jc75BJ7SOQLYNEha9r9HaSKyfQO26RVg2DDSmy2qk1KlFz0l7rpduIamVomRaF+8O9Y677++tlX
 YabS9PAlIlJ4lfb44NH4RT+S46B3QvLdBvO53YRE6qCHIlWqFNiHO7uJs6pzywCeoOc2PMlfs2h vkfghRzYUWCwlk0VlF/RXWdixUZzppJAEP0mmEhVcHaEHV3j3FGu5Nsz9cPueD9vOoW15KSTbzP M16Z/2+mjFHxGABM1xckVykekJHT7X10Mu1QRhH9D4NbyoW+t5C9vglDQvKoDM6cG0KA6nLT9wc
 /f40rUs+hquuUviMNOOS+zqVvyPOYUph4huLt611Y5jLHKSx3RQJUpZ+hEJbv+OOQrcHP8zW

* Shakeel Butt <shakeel.butt@linux.dev> [250520 15:49]:
> On Tue, May 20, 2025 at 07:45:43PM +0100, Lorenzo Stoakes wrote:
> > On Tue, May 20, 2025 at 11:25:05AM -0700, Shakeel Butt wrote:
> > > On Mon, May 19, 2025 at 09:52:37PM +0100, Lorenzo Stoakes wrote:
> > > > REVIEWERS NOTES:
> > > > ================
> > > >
> > > > This is a VERY EARLY version of the idea, it's relatively untested, and I'm
> > > > 'putting it out there' for feedback. Any serious version of this will add a
> > > > bunch of self-tests to assert correct behaviour and I will more carefully
> > > > confirm everything's working.
> > > >
> > > > This is based on discussion arising from Usama's series [0], SJ's input on
> > > > the thread around process_madvise() behaviour [1] (and a subsequent
> > > > response by me [2]) and prior discussion about a new madvise() interface
> > > > [3].
> > > >
> > > > [0]: https://lore.kernel.org/linux-mm/20250515133519.2779639-1-usamaarif642@gmail.com/
> > > > [1]: https://lore.kernel.org/linux-mm/20250517162048.36347-1-sj@kernel.org/
> > > > [2]: https://lore.kernel.org/linux-mm/e3ba284c-3cb1-42c1-a0ba-9c59374d0541@lucifer.local/
> > > > [3]: https://lore.kernel.org/linux-mm/c390dd7e-0770-4d29-bb0e-f410ff6678e3@lucifer.local/
> > > >
> > > > ================

...

> > > >
> > > > 3. PMADV_SET_FORK_EXEC_DEFAULT
> > > >
> > > > It may be desirable for a user to specify that all VMAs mapped in a process
> > > > address space default to having an madvise() behaviour established by
> > > > default, in such a fashion as that this persists across fork/exec.
> > > >
> > > > Since this is a very powerful option that would make no sense for many
> > > > advice modes, we explicitly only permit known-safe flags here (currently
> > > > MADV_HUGEPAGE and MADV_NOHUGEPAGE only).
> > >
> > > Other flags seems general enough but this one is just weird. This is
> > > exactly the scenario for prctl() like interface. You are trying to make
> > > process_madvise() like prctl() and I can see process_madvise() would be
> > > included in all the hate that prctl() receives.
> > 
> > I'm really not sure what you mean. prctl() has no rhyme nor reason, so not
> > sure what a 'prctl() like interface' means here, and you're not explaining
> > what you mean by that.
> 
> I meant it applies a property at the task or process level and has
> examples where those properties are inherited to children.

Okay, I don't think we should have any illusions of how clear cut either
of these things are. prctl has PR_SET_VMA, which isn't to to do with
the process.

madvise() can be called with a range covering the entire address space
and may or may not fail on gaps (depending on the call).

process_madvise() was to madvise on a process range - including all of
it, so I don't see either as the wrong place.  Or, really, the best
place.

> 
> > 
> > Presumably you mean you find this odd as you feel it sits outside the realm
> > of madvise() behaviour.
> 
> The persistence across exec seems weird.
> 
> > 
> > But I'd suggest it does not - the idea is to align _everything_ with
> > madvise(). Rather than adding an entirely arbitrary function in prctl(), we
> > are going the other way - keeping everything relating to madvise()-like
> > modification of memory _in mm_ and _in madvise()_, rather than bitrotting
> > away in kernel/sys.c.
> 
> The above para seems like you are talking about code which can be moved
> to mm.
> 
> > 
> > So we get alignment in the fact that we're saying 'we establish a _default_
> > madvise flag for a process'.
> 
> I think this is an important point. So, we want to introduce a way to
> set a process level property which can be inherited through fork/exec.
> With that in mind, is process_madvise() (or even madvise()) really a
> good interface for it? There is no need for address ranges for such
> use-case.
> 
> > 
> > We restrict initially to VM_HUGEPAGE and VM_NOHUGEPAGE to a. achieve what
> > you guys at meta want while also opening the door to doing so in future if
> > it makes sense to.
> 
> Please drop the "you guys at meta". We should be aiming for what is good
> for all (or most) linux users. Whatever is done here will be
> incorporated in systemd which will be used very widely.

Agreed, the aim is to provide the most flexible interface for the
majority of the users.  In my view, there isn't a clear way forward yet:
I don't want to make process_madvise() a dumping ground and I don't want
to make prctl() a bigger mess.

But right now, it seems there is more than one user arguing for this
particular implementation, but in fact there two employees at the same
company and that isn't clear in this conversation to the casual reader.
And the opinions are being cross-referenced as evidence of how others
view it.  I have no idea if you two know each other, or even if you know
that you are both at meta - but I think if I chimed in from some other
email address saying how crazy prctl() is over this other way, then
you'd probably feel compelled to say something about where I work (I
hope you would tbh)?

You could add a (meta) to your email address or signature so that it is
implicit that there may be other influences on opinion.  I'm not saying
there is an influence on opinion or that this opinion is wrong, but it
is not fully transparent and complicates the conversation.

I don't think it is unreasonable for people to point out that everyone
arguing for one solution is at the same company when it isn't obvious,
do you?

> 
> > 
> > This couldn't be more different than putting some arbitrary code relating
> > to mm in the 'netherrealm' of prctl().
> > 
> > 
> > >
> > > Let me ask in a different way. Eventually we want to be in a state where
> > > hugepages works out of the box for all workloads. In that state what
> > > would the need for this flag unless you have use-cases other than
> > > hugepages. To me, there is a general consensus that prctl is a hacky
> > > interface, so having some intermediate solution through prctl until
> > > hugepages are good out of the box seems more reasonable.

(oh my, I'm going to sound like a jerk here.. sorry)

This is a terrible argument.  This intermediate solution may outlive us
all.. it may even shorten some of our lives due to stress dealing with
it.  Will the removal of the prctl() call coincide with the year of the
Linux desktop?  Or maybe the removal of the mmap lock... wait.

The hacky interface of prctl() is one of my main gripes with that
proposal, it's not a reason to go with it.

> > 
> > No, fundamentally disagree. We already have MADV_[NO]HUGEPAGE. This will
> > have to be supported. In a future where things are automatic, these may be
> > no-ops in 'auto' mode.
> > 
> > But the requirement to have these flags will still exist, the requirement
> > to do madvise() operations will still exist, we're simply expanding this
> > functionality.
> > 
> > The problem arises the other way around when we shovel mm stuff in
> > kernel/sys.c.
> 
> I think you mixing the location of the code and the interface which will
> remain relevant long term. I don't see process_madvise (or madvise) good
> interface for this specific functionality (i.e. process level property
> that gets inherited through fork/exec).

Process is literally in the name and we are applying an madvise flag
across the entire range.

The inherited through fork/exec is a much stronger reason that I see for
not doing it in process_madvise().

> Now we can add a new syscall for
> this but to me, particularly for hugepage, this functionality is needed
> temporarily until hugepages are good out of the box.

I'm not holding my breath.

> However if there is
> a use-case other than hugepages then yes, why not a new syscall.
> 

We also have Barry looking at prctl() for avoiding LRU updates on exit
[1], which I guess is process related.. or page related.. really it is
mm flags related in his implementation, sort of like this feature.  But
it will probably only be used by android, so...

[1]. https://lore.kernel.org/all/20250514070820.51793-1-21cnbao@gmail.com/

Thanks,
Liam


