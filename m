Return-Path: <linux-arch+bounces-8588-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D479B12B3
	for <lists+linux-arch@lfdr.de>; Sat, 26 Oct 2024 00:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96DBC1C20C75
	for <lists+linux-arch@lfdr.de>; Fri, 25 Oct 2024 22:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C593520BB5C;
	Fri, 25 Oct 2024 22:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QnaTZbbg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IazVXkwT"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FE2217F22;
	Fri, 25 Oct 2024 22:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729895747; cv=fail; b=TVy8/KNHt58PywUVDhIzWG2IzU+LhR8ZP/c/tnK1rWPcLZCJ3K/97d270YKRyKqbHYWhHMTZCtLeSrB6K8CHw54wAgCTTF/4SOa3ajKx5k6fyZMuWjwGQ2jCXsMFTQX/kcRoboyaiSUzKembTvM24LDbVbRVTM6TAto2Y1TE+uE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729895747; c=relaxed/simple;
	bh=0/Twq/2pSjumZQFTf9Bqkl3UPiB8VwoQBtg8pAYOPnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MtLPUHxELB0KmFyB3I9FvhuoQn4x7zLVDSXUuUapY81oRFYjDLO+KCWgGkQEb8kfTVA0LAdpWpBEBnsF8dyC6GJMUZg2G7TYlV288IVwCGZw8lWo4uamNNu9Ilt/wiYpby/5xCLVoYtgGDkbDb7d8zDln7/4dLrJD82QCqU7CzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QnaTZbbg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IazVXkwT; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49PJdRLZ015520;
	Fri, 25 Oct 2024 22:35:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=Ysx/2SVCoBxGTQ8hg3
	ORqxmvmsF5PAtV5UqAzKzVKQE=; b=QnaTZbbgjFbia4d6TSBTgRlawbqcOiKzgX
	P/1FeIqg0mbOwRR8LbHdQQTR+z40rF9pNWwY2WMjHGx626f+ZsRygascg8FrB8t4
	RjlXGbpUkVbVbbGbgHemcfr8Gdo4hcNK6jWIMFbaFpv5F8y6SiTBg3UM+iM1/I+1
	zAGkoZ6koLbC97jiqq0YpzMKs+6ZsfGAGwTpQVr6nxaouXfOWTCb9e7mKgt0S/Lc
	e0G1uLuHr7gcfXzZIhbgZY2dzmYhlUJGfaSCZ4vr6q+4kgpTUSlXqq9iQnygZ9zV
	5jqVk7DvxAl8baF9sgDx0QI2HRQGWmRTw2A4auQQ69DcTLT2Yizw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c545e4d7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 22:35:11 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49PMPUic036853;
	Fri, 25 Oct 2024 22:35:10 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42emh5vffx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 22:35:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gz5biEx0TQUdsOi8PH51eHSSNvLsDVcOxH4MA1fVkzUoNv8sJUPvCxZ+pJC+g6tKGmPQ2ls6hiplhT3RUeTeBlifNYW3ovaWQG/GhXc0FJ0YmfpmrCRtDAEY78iFsk5GnTrlsIQJEVPTXalCxcPbAueJrfn27k9lcldFRS8J6bLSvLK+11kK6gLc0iYVc6wnIvtib2SeYSTrxEcow/X3conrw/Le7TQ4Rj5Y1PdF+5ZoZYpf9wtcT7VzXVWZKaZXb6MAI5IzBEDTpuKYe7zMJ17PkmdZPRlfb3GAUQdlZESyH+ecqKt+lDAMktLtZuEDXJ83KnKq6Em4THn2dh8iLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ysx/2SVCoBxGTQ8hg3ORqxmvmsF5PAtV5UqAzKzVKQE=;
 b=nML9DRL69EUT3BCZcYM8ILs7DoxIAIFXeQaysoIwY3vabNpypwHzg9Mo6OEkhD8r0s4oxVCTKmZ9wafc79hNfw7K4cDAUbuP8mQswpRo/XF17qjnuw6qqNw07/Yf8l8Pjnz6FI2Ho6k1WLPArPLSjTJXS8oldPYnIYs+rFbwdfvE8EcH7iwtsX4/RULidQzfmmAJZa7gBWBq705Qyebmy8Z3Im9hPzgF8h3eo4X7Z+n5EQvdnngSbelXUOQUcUDX7aHPjLU5NgQqj+K2u8MFGHpmh1K6Sm4ETrxvH5wlr+HOOlzprTfa+k21E6e92QUfPg6vhKaIN2NgbBkTLQzGcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ysx/2SVCoBxGTQ8hg3ORqxmvmsF5PAtV5UqAzKzVKQE=;
 b=IazVXkwTOiWQC1DaEKf24DFDhYh8u9XzuivgJ5fLQeCSw8qgNoRmTFJctMcIwpX1nMWl3jYgGkJCTqdDsPtFD0+rCYBjGm3syDLrxJbPBRuDS0hG+E5bTtXPUtHyeGxL/3r7l95/+rBhEIMHBNMNi9Ql+TpydGHj6iFeSwiZ8Xo=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by MN2PR10MB4222.namprd10.prod.outlook.com (2603:10b6:208:198::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Fri, 25 Oct
 2024 22:35:07 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8093.014; Fri, 25 Oct 2024
 22:35:07 +0000
Date: Fri, 25 Oct 2024 23:35:03 +0100
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
Message-ID: <c957ae63-6aa9-4a29-a191-1686ee31987e@lucifer.local>
References: <cover.1729699916.git.lorenzo.stoakes@oracle.com>
 <415da1e6c5828d96db3af480d243a7f68ccabf6d.1729699916.git.lorenzo.stoakes@oracle.com>
 <f09086cd-c49c-4eea-adff-d626c16083de@lucifer.local>
 <7c7185ed-f997-484a-b1d1-91ae6c761266@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c7185ed-f997-484a-b1d1-91ae6c761266@suse.cz>
X-ClientProxiedBy: LO4P123CA0633.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:294::20) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|MN2PR10MB4222:EE_
X-MS-Office365-Filtering-Correlation-Id: bd92ea82-b963-42d2-66ea-08dcf54546ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|10070799003|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?O+9SeGE9Pdm3YI30IK65FPyYcmZN/WDHrMKVR/7odrFDeuPnuD2d1mioDh2Y?=
 =?us-ascii?Q?yu7m0yxCdlRKTYuaIg/NrAE+4VwJGGVPR9IPuphP0R/he/9jz5X2jlFlCuoc?=
 =?us-ascii?Q?sL9jDerLQnNLlSkJo1reDHe9B1fe8Fbj7c4lnhEQiB7sFZN8d+704yJcY4sR?=
 =?us-ascii?Q?GS1PRYfGKZo/lyfovTaRQYcYZ4v0RnItHpzjq+yYxgd0dFqfMhgzGzWeprw/?=
 =?us-ascii?Q?aMkDbem8JVe7wMG1aJzithmfkhgaL/PR8mPs+5giSn3v3yyo6nD7ficGWnQ7?=
 =?us-ascii?Q?XBLvxRfabwx0SJPS3Z0d6mWAMRYVYkbRIWQ5/FvECwg29Y63X32FvhB2Hws9?=
 =?us-ascii?Q?Ekh7Icxd0wVvxUKN2GkwOSFVNewm52jxS/jbCrR80u8Tsz6z4zlibBMFiIJQ?=
 =?us-ascii?Q?d/pVDgvUek/bkbY9t0F6LkkTvbgvvwIBl6dDa2Uuh/uq02wV5jCkNpiqX5fD?=
 =?us-ascii?Q?qEiW9mUwHsNyh5TLXbXHcxP0DUgwhNDnNX6lJQRC4x5lHGG1wHewpCwGoYLG?=
 =?us-ascii?Q?UL1i09gKAQE2VncKLDSFxxsDcUqK1GnVIrYoxQOP7yOL7rPvNSmawiWMEmF1?=
 =?us-ascii?Q?TuFc/QDLCPfW2t4zb4LT5MtdlKZzQVZrHlVQEM4bOWoR3Bq+A+Udg73MC7zR?=
 =?us-ascii?Q?lQaLmz/FF2krIUS0w6B4r4aasbMvan9N69BjuYKizrvOj2ZJjD6kcUS0Cs78?=
 =?us-ascii?Q?+IdMZ8/YaSqWya770VL12PhF3inzqvcTJ/+JI1ZQ8GsMqdYJvUniFIzNZrlG?=
 =?us-ascii?Q?pnaiSCflk7CSBsNAkD2PoEmOdZcEpBmXWGJPhWDLf4uqy/rdMy/y4Ffupjde?=
 =?us-ascii?Q?sXdmbpq94Fo94N7Ka/MqGvHnIB/xAdxdsZsdQxQv3Q93bvNvmTSiR3o9YXO6?=
 =?us-ascii?Q?o/DTKrhmA7CQohB/tBukyKb9GeVLDLOx+apU3j2LmoeG2VxLPoSxGM58JXpw?=
 =?us-ascii?Q?pIIpZpC3aO/qsohht5ptZ9zSQYy1+EuJUk1z8daD5d2LAqwxOhYOpvFpf0Ev?=
 =?us-ascii?Q?tM8oVxuK3+Hw9h8LgpBPWwtBaWP9Re9s7fKmiwVHHy6CQdx2N0SFtWpyISBr?=
 =?us-ascii?Q?//+E8v5oqTLcULCiZFuT77eT6IcnMKYE0zWo0jcmhQK6XR0S/rxCdxY7OmGb?=
 =?us-ascii?Q?mXt9bwNoVc/g5IdJIBbsXdKHMzVC5BP1ynbsFGFS/zzynkk/EIae2elYCMLj?=
 =?us-ascii?Q?U7GjXXSrxVRVW0Eea4ToP/ioLA6sW4PB9YJlmHJnuPKCJYmI2nrA1g126+tN?=
 =?us-ascii?Q?1jmyjq6+hg4PfgY89T3PfhM11uFHRowMNKx6DgULkSS6flvSKhZQ9w0h/t+n?=
 =?us-ascii?Q?mtGoh0u8b7ynXx1k/fkodFpt?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JnPDpOknZs/AsyGO4C/iEcBsWlNe/FXEVbTJI3NCZFFVeReacRKspK4mkKur?=
 =?us-ascii?Q?jbE0ft3cWNXolQ16jySq+yzx1Vc94aWmuDDv2Q+qaOowY/UYqTG3LTpVcWch?=
 =?us-ascii?Q?fAWvJuKqRSLoWL/nS+ZFZCr/U/YGGNcjKXoswuTookNH6nMK5xMmexzJmT5o?=
 =?us-ascii?Q?Oc7lzf9v4PrWoSuQ3sIEFJIeZJ8hLDfCk274BPCs1wuc9KPN+qP2OcSp6aP/?=
 =?us-ascii?Q?aDb/KfAf02AdEPng4UDh9dJD8tNXB8CQ+olGLBSJvWCBhnI0cMhJvFCPpc1l?=
 =?us-ascii?Q?5oOA9OK3KhpdFKOmfKgawCB1xRcMiV84gZ3+VjiaO5csXj3LB+LVhm5eN1vZ?=
 =?us-ascii?Q?JHAzp0Ac36tXeJzrhUsG/W5SY3XniDCm25U6wtzTVpCED6vYZcxmt3ouB+oj?=
 =?us-ascii?Q?7NT4VrTTVI32pNO5atTslL2UaKZ+kGgg/3nv7eMNV6KBo0Fr9pfvANud28BM?=
 =?us-ascii?Q?ZKZFfnZXeq2oGdAFj7+Ygi7JyUkgFhcl8mxYXUADsKjl3hSj+TCN+jFdRu40?=
 =?us-ascii?Q?y4diSAFi//lO1/xe0OegSf5kn8HV3Lqj/fo25eaBXoQRppmwPhAMqQb+6stc?=
 =?us-ascii?Q?rQJ6mskHXt2zdEOffMKHgpLGeFreRAvVkBoGET7r5p3bFWbjJlgeOaeTnpZG?=
 =?us-ascii?Q?80iTQuwGjgAKv7+/ecKewB5ygtqfWUlTCgPL6WPTymkXcUj4E54wc+eFGmKQ?=
 =?us-ascii?Q?26Dch1uBYy8SqYD022TsI60ngsbXIuM2wRXVAygjzxAzaJGWXWmdIWng9TfG?=
 =?us-ascii?Q?HhFQo8/SwN5n7cLWMQwAUniS36LE0YQiwt9CUT4cP7/IM/AeqXv5WsnEsHjc?=
 =?us-ascii?Q?XjwLG1HDgPKlXM/VPczFVPZzEdPQwl2td5jLE/nDbkXZhxZyYlMQehnuHvVJ?=
 =?us-ascii?Q?FgkR9r2Yk3hTEjvolzw2AcX3ih3it0o4v3TpKcHravQTDyNVsPOr8ni4Nhrb?=
 =?us-ascii?Q?egQ8w2ZKOJr9jbiQriq5m6wVaIhTH3xj0k+o2r5ziHyIoYgj0ulKgK+1uwaw?=
 =?us-ascii?Q?t945lesTtv4Of0Ve4+y+DQUIn/hA2wQnTok815DOPstH2H96oNaPIkuKJfLx?=
 =?us-ascii?Q?gkVxmUuZ/8Hg3QjjSliH/wpbge8MSJIKm3JEcDGaVRCxM33mcWvGlRApq9WY?=
 =?us-ascii?Q?3sEIbKXgipkE+z8etORfHrJzjoQKKQceFJC6N4yWepUQISbSbyGSakd+mfWa?=
 =?us-ascii?Q?d1txGLdfEqtl8ZouqRx+J158vIGHBvyM2f42NKpZvWx/T9al/Q+xUq2pl/bA?=
 =?us-ascii?Q?ggb0VdoSEmDMxqvkLxXQUR2TXzcckzxQNvJRFXfX6OHCirepCev3EhvPglOn?=
 =?us-ascii?Q?E5GegX+LHJgW/A6RG8e0t5EQo5DIiqP++QPHsQy9Zvm7sx77TeElYoXMkeSW?=
 =?us-ascii?Q?19hgdG6Qbc7wg84ccLXq9CaRdT9bV/q/C959p/Ox0JuN1UYZmXmqm09MHYCC?=
 =?us-ascii?Q?TMzq9guI4oG42kSgPYcqY79fX7/gtI3LnyeUTSl/2d6ouAK6b4AkOrnrA0PP?=
 =?us-ascii?Q?fLjxzoDWeqGsepgMDIm0k3L7lfw3AcgcUTMiw1HQOyF5jZVIuAJzLCiVTIBp?=
 =?us-ascii?Q?gkqIHAK7dxrmtcjX2OpfoafM1v7/Gs2uJBzDhit6Zs0ursphZk0K4L9F2bJd?=
 =?us-ascii?Q?kPkv0bVtKcZrKWmNG2xgX4h8QwJfEVEylizLxorDbJBI0GHWddYdQnatw6Vf?=
 =?us-ascii?Q?fA4zdQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	KAB7wpVTGRO85I1uT13mTy1C/sixbjNpDNiB9goVLiTHw7xlVTXa0J6wdW+SlzlEBL3qkNGtlSBPWg9Q53p3hVeCar8zJMO8WmMXNBWKv6eqx658woTwFP5XKkOO/0B6B9uPVFX0Ge6vmdmQv1r7LYkXsO6eWFL6UuJcPvCLi6nybJTo7B9PwfvZEZwKNANN7JWUtKiS+vXLIEf5PpwvZHiUXXpeo9gpE13TZDL0CLnY64NT7Fnm522ygQBeZ3emJZ/Udn+F9FZGoqJjBdJKEtiowYEaa4Anq9SqZz67Uf43OJJbMzKkEs9Gd1icdp5ujuOyk5/XinKeFfmsWZQbPA6Pl1bbvDA8Ir0vywCv1tbhTRJ7z9txoi/Ceou8IDgC0Nwi+6p2d+wtud+6fwYj2KSr2hVPu5Dc+2JjOZi9y6uUxI09WmTqy9oLVOWhBmbckf7uwLcunbkjjDWt0dfWoijuB+ilpHimsIL6vQxNTT9kIYsFN3ID6b9Z3EnRCL60iQw/HWe+qOEP5Wf+JlUxQnPo/q6OPFaAwkjTw2BbHOEEWke3JCBsFO60C1x7zLRSwUc3KWqpnacf53MXm8L4f9bAwtYSXpACgi4hELmBH84=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd92ea82-b963-42d2-66ea-08dcf54546ff
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 22:35:07.3577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7izV62a7XZQyVwYbrW+4N2TIQcf9CMryZg0+tJxP0bm5vuNKgCjYs5TXCh/1b5/ZJr1kimqo5LYGK6DoBV9TouTDaxLBmizxzGL9mtrRKr0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4222
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-25_14,2024-10-25_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410250175
X-Proofpoint-ORIG-GUID: vFuSRDv4ccs0zSghCPOtl9XyUAgA0Uac
X-Proofpoint-GUID: vFuSRDv4ccs0zSghCPOtl9XyUAgA0Uac

On Fri, Oct 25, 2024 at 11:56:52PM +0200, Vlastimil Babka wrote:
> On 10/25/24 19:12, Lorenzo Stoakes wrote:
> > On Wed, Oct 23, 2024 at 05:24:40PM +0100, Lorenzo Stoakes wrote:
> >> Implement a new lightweight guard page feature, that is regions of userland
> >> virtual memory that, when accessed, cause a fatal signal to arise.
> >
> > <snip>
> >
> > Hi Andrew - Could you apply the below fix-patch? I realise we must handle
> > fatal signals and conditional rescheduling in the vector_madvise() special
> > case.
> >
> > Thanks!
> >
> > ----8<----
> > From 546d7e1831c71599fc733d589e0d75f52e84826d Mon Sep 17 00:00:00 2001
> > From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > Date: Fri, 25 Oct 2024 18:05:48 +0100
> > Subject: [PATCH] mm: yield on fatal signal/cond_sched() in vector_madvise()
> >
> > While we have to treat -ERESTARTNOINTR specially here as we are looping
> > through a vector of operations and can't simply restart the entire
> > operation, we mustn't hold up fatal signals or RT kernels.
>
> For plain madvise() syscall returning -ERESTARTNOINTR does the right thing
> and checks fatal_signal_pending() before returning, right?

I believe so. But now you've caused me some doubt so let me double check
and make absolutely sure :)

>
> Uh actually can we be just returning -ERESTARTNOINTR or do we need to use
> restart_syscall()?

Yeah I was wondering about that, but restart_syscall() seems to set
TIF_SIGPENDING, and I wondered if that was correct... but then I saw other
places that seemed to use it direct so it seemed so.

Let's eliminiate doubt, will check this next week and make sure.

>
> > ---
> >  mm/madvise.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/madvise.c b/mm/madvise.c
> > index 48eba25e25fe..127aa5d86656 100644
> > --- a/mm/madvise.c
> > +++ b/mm/madvise.c
> > @@ -1713,8 +1713,14 @@ static ssize_t vector_madvise(struct mm_struct *mm, struct iov_iter *iter,
> >  		 * we have already rescinded locks, it should be no problem to
> >  		 * simply try again.
> >  		 */
> > -		if (ret == -ERESTARTNOINTR)
> > +		if (ret == -ERESTARTNOINTR) {
> > +			if (fatal_signal_pending(current)) {
> > +				ret = -EINTR;
> > +				break;
> > +			}
> > +			cond_resched();
>
> Should be unnecessary as we're calling an operation that takes a rwsem so
> there are reschedule points already. And with lazy preempt hopefully
> cond_resched()s will become history, so let's not add more only to delete later.

Ack will remove on respin.

>
> >  			continue;
> > +		}
> >  		if (ret < 0)
> >  			break;
> >  		iov_iter_advance(iter, iter_iov_len(iter));
> > --
> > 2.47.0
>

For simplicitly with your other comments too I think I'll respin this next
week.

