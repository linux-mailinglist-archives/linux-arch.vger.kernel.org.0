Return-Path: <linux-arch+bounces-8517-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D939ADE7D
	for <lists+linux-arch@lfdr.de>; Thu, 24 Oct 2024 10:08:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F152C28406F
	for <lists+linux-arch@lfdr.de>; Thu, 24 Oct 2024 08:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 638DF1AE01E;
	Thu, 24 Oct 2024 08:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CK9eC6v5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nuofanYU"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83571AC445;
	Thu, 24 Oct 2024 08:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729757311; cv=fail; b=ESwBpLOsU4imYTN2ueUY4D70eOf2xxb+vv/HHFWoluXSeunWEvHGMk82Ez/dwruona+xRhnKo+l58x2uZKt1DqcoeOtnFt1LNeJJmrmUjYmwdkLVpYyZrf+xJ4yR27oXTiSXQ0dIliyQ6Pmqi5NW+EwVRROmlAA5YLO+ihR42Hs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729757311; c=relaxed/simple;
	bh=2YRnRRJEvVq8NKhIBhv4E0O0Jd9oviMhqb9j2fltgzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HZLB9T2u8Yf003pj3xB2kZGKXmpe21NleWl9tUUWobIuCNlZlUUBPzA16CdfDnM4hYSa+QhQeENBKVtvTuV1r9sr8kIGzWy0UMSHxwqDMjKXVE5rNCcUTLjufqQTsNOyexbR/2JGnbAGPbMfSVufLHgAIw6xO2whOZEGEt1p4Ys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CK9eC6v5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nuofanYU; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49O2fgOT021675;
	Thu, 24 Oct 2024 08:07:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=2YRnRRJEvVq8NKhIBh
	v4E0O0Jd9oviMhqb9j2fltgzA=; b=CK9eC6v5xvqC8TA9xas4ilTR7n8I5eMTdE
	IoOMRst306jXXA6C1DnwsP64SIyarKu1F4tdUu41vcXNGmghxv9tMP7zSB2Jy6Hl
	OQeF7laycAp7izKFFYoaI1CfclniQ1mZWHog+ymhqm2a6mTbXTF7beNGMBkGhp/K
	GuSCl8UqzexjHULbQJ7Mza2Z5QTAUtwl7yFeNP1anAod6CwxPzhFGKPQnavK6j3+
	RVvBxT7B/q3DHNEpsD332ylxOihsR+54kX7C8pyA8Lf7QyfVW+6ebpXozQDiDeao
	lL+v+SbOpLJ3u2j2R2H0JJe5njsDw4miaVAdKij79tRNi+cBmWlA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42ckkr18ge-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Oct 2024 08:07:42 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49O6ipkg025332;
	Thu, 24 Oct 2024 08:07:41 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42emhajt3d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Oct 2024 08:07:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pkioMkyY3rGjaOwsKfCWnJO7iDNSMg4xp53Ov0f3XTB9hffzD4WpZBzGg0t5COtSgIA5HM6QH9AFYUyGHrKlYzPepePLQ5CgeqLfzi060tgop76mc2h/R20bT/E5H1rus9ZeFlCsIPbZpZRpI80G51vlsoNeZtXaF/si7Vny93035J612oklmqiBsPL/arPBOSnKQEYqCDhAK62UxCT9mdSLhT1ffWmeSH5MMVPKhSLDKGza4IvE0ERlZy1qGDwj1yW9i0zQ0D8oTs/pG9LAuJR8eGbCIW/lTa7co5xYjMt971FYumxYDeJnQZOT69ta1BkC0klxdm3OTgQcIGSbmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2YRnRRJEvVq8NKhIBhv4E0O0Jd9oviMhqb9j2fltgzA=;
 b=vAP270MkylQKbPTEv9tYO9u+PpDlqqKRXJzyryBI5VC7WtkW39Xi6BmJo0OTEjFugSNKHPabQNC6Mj7iEuWBJX2nQKc5XCPDeOpDMKHs7u/gTB4NzC8/VVxtJPtfovUCA1UFIQaLaH/ekPb2Td0WbceuAOTDikF2hFacD+z95N3nm3lVNlxPCre/8GKbJ+s/u8iUXOmwBG6lG3tH05NJMEiCBJurFbVtZEPrbpCNLZ/xwN0gLw16UGdxVJjL0S1jTPLRh5cbXLGVsDhWEcXe+IUfykIAnnDYU0f5+3Y4Un44zE63HYW9ckemQtDaF/ctNPykwTokwqkimUhe9ACfSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2YRnRRJEvVq8NKhIBhv4E0O0Jd9oviMhqb9j2fltgzA=;
 b=nuofanYUOjW6Mde2P++kIzz9ThaPsmkVfKZ94QkhM6reGUQmA4pdhUwZSwEQ1cWo+aKhvLDwu/YWSfuPG7Hx2hKzINwyfzs1M74Z0aqiOLKZEkFepE5D5RmCEQ561ubNXWO1+386ngL2XtC/4hBUeO860b8GpRods2jxfPuKcqc=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by SJ0PR10MB4560.namprd10.prod.outlook.com (2603:10b6:a03:2d3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Thu, 24 Oct
 2024 08:07:38 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8093.014; Thu, 24 Oct 2024
 08:07:38 +0000
Date: Thu, 24 Oct 2024 09:07:34 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        "Paul E . McKenney" <paulmck@kernel.org>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <muchun.song@linux.dev>,
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
Subject: Re: [PATCH v3 1/5] mm: pagewalk: add the ability to install PTEs
Message-ID: <e62ef664-1c71-48e0-a695-6a53b6d46922@lucifer.local>
References: <cover.1729699916.git.lorenzo.stoakes@oracle.com>
 <9be732fd0e897453116b433fe2f468ef7795602e.1729699916.git.lorenzo.stoakes@oracle.com>
 <20241023160405.33995c68f20c141325a8fadb@linux-foundation.org>
 <635de052-35a6-40e0-82ea-4349f3aecc06@lucifer.local>
 <a089ff3b-119e-44a0-a780-3abca01886f7@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a089ff3b-119e-44a0-a780-3abca01886f7@redhat.com>
X-ClientProxiedBy: LO4P123CA0629.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:294::10) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|SJ0PR10MB4560:EE_
X-MS-Office365-Filtering-Correlation-Id: 6475a5ec-3ccd-48ae-af70-08dcf402ece0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wAv+uc26nUr2xTBxhNv9DTCsEhlkTV9JSvf3PoY3PANx4gdhnEaEHRZYyI+/?=
 =?us-ascii?Q?LLjD6oMv7vuqh4wZmV90a1gFyFUDwO2/IOXtlW1RMsyYr7Txt+xqqRGMpbRh?=
 =?us-ascii?Q?sCiYBw6qXpOapWS4AzG9T48aHskzO1DQU91oDDlbpUDWeXSbeaFUXhyLADT6?=
 =?us-ascii?Q?WGhymaGsO5o4McvDEQZWFQb8+vo4d8PE6YLM8OAhjG63mRuBehdhlhSA1u0c?=
 =?us-ascii?Q?tb47AVEJ/bA+kaFNUBRCFNfSSGB4kpGjT99i3msk0ZrgDx48DAnPv0VCMXSJ?=
 =?us-ascii?Q?a1RqX/CCrubHMUiewMJ4qaJFa0jLAXYdWpaorlym8lLdZwuzaZ3l56VAUxOT?=
 =?us-ascii?Q?sVI/PbBTUqq2d5OVQsL345ld4vVc+boY8L6Oib9btd+Iyl/tRdN75KEBE5m9?=
 =?us-ascii?Q?/T7upxQtTPyI8oYST/LvXV250piiKJLQLzATiJemWZvBps8ML29vqirIJXut?=
 =?us-ascii?Q?IBx5gqZnw6aEUb3a5LDOmlRTrVC6UCXyMPGc9CbigxN2fMcr5KQHMUiXfSRt?=
 =?us-ascii?Q?UZ8nCxVDYEMb/GhpkLIOEykjV4UtjAu8D3GyGkxaHEXKAoA7qMt2NwsVbe7A?=
 =?us-ascii?Q?9MvA0YHbUHuyIu1pOUtp6Ek/tFcCuZnDWBmNCgz+bpWPbeYFEWxeN50sdkW+?=
 =?us-ascii?Q?jioYTyA8cXdiztQjfYpLT/AO8Mnrw5PQoo9Isto68Cerd1rt1lK0RdoHvmQH?=
 =?us-ascii?Q?YfNzIAE+JYuuUmAuhrYojHfAnXR6T9E+ASzWSzP/9GQhIgOGN17aFPRJjFSw?=
 =?us-ascii?Q?KjGGgt4oT6zfwZw7PzMzxiRCibLkxAbEze7yKc/mHUw3FzMobt9kFJb8IKxe?=
 =?us-ascii?Q?fvayCN3bfBgpDEBObOCCBVxzWHBpBnX5Klzl4OQglxxmLyEI2JE8hEq1Txow?=
 =?us-ascii?Q?lpGqwpETH1lDb24bG28/4lJJsLaxpXlK0ShL7JPSPyxngxjmxaQW09IyMjDQ?=
 =?us-ascii?Q?VVEHtlmzIfylYmyYv+zX+YHrzSD8zr9W6mHmIpwbpQnMeMdrhTQyB5lOHtKK?=
 =?us-ascii?Q?+1t11z0r0uOTLn3RaZi5mSTPGQ3pk0udw51ovXUlRB/q1QunXr4Y2tjG0LKy?=
 =?us-ascii?Q?Bp6h+li/4rxMRiHKb+6byYo10khlyjIQzqhNDhs1eBizNo1kHFTjlLaM+eWx?=
 =?us-ascii?Q?ovTJXGeYeMQnYXA+uGVg9D03wYDNwE4loKXfpVJgPBZxqpyUa2DrHK89JKss?=
 =?us-ascii?Q?AD7Qnq+EYdRZIkxhuW1A3LzsVVZ94UHnO4Eo6la+22AEG4nYs7UqvWnSO5rd?=
 =?us-ascii?Q?vvHDQAW+NSmkYr+P8ysRVPAGx0bTBfBae+fXJ73dxj9GZLNA8Msbrqb1xFcM?=
 =?us-ascii?Q?5YAXbhWpwe64m9o9N4/SRVQW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Z6Cj21HTtNyAQz2Cd4ZP7/CWLuzPDHKgJieb9R2OZE75SggTSwqfy7KJs6MN?=
 =?us-ascii?Q?63Qdi0ItVrpzWAnDvhkWy03mRPyQS+W8e9esS3t9KCVf/nHPnuMWuM61i7Nq?=
 =?us-ascii?Q?CI+J3A+6e/AeXbEAJBwFuwrqaDoTOdJIRhI2fSj7Ep7YbDFfXfYlK8eh+bXi?=
 =?us-ascii?Q?ivHQzSlzvncgJ+n9DMk5hvOEu4E82+rjADmbeO65tRAXy5Wg2AbtczOlU3nr?=
 =?us-ascii?Q?lDbjKhf/b9HKD+RpMysitnAyHrKC3D8/H9QYtLXPBMRtl9mFBt4tDw6/GR8x?=
 =?us-ascii?Q?+6fNlkaQaWjlgCDb6v4X5ulZVWHy4xPTBIA43VLWk2dvUc8w+dB1bLm3N199?=
 =?us-ascii?Q?28t7/nIxN2Tks6dyRicVdC37is4/gYD3jQ2ThtRaY9sNliOAaTbHDYMTYW7/?=
 =?us-ascii?Q?U/3VG0DJDID5k3qMCxSQQj++UAjmGZD3vgtPpZkxlwBomn6K0f4oMs+MCu7X?=
 =?us-ascii?Q?AaLXjBSv5S7DQGYNaAsKzKKctX9SVxxZJuePSj+UhKE/MQN1AwJY9AMfauwJ?=
 =?us-ascii?Q?uJ/HWIZJ4Dc5Em1V7PKgH6ybXOMhjEcEHJyAR5bwOmdUiraiVXy7lR5EcT4S?=
 =?us-ascii?Q?wWXiHXKVBQeXROmJ6L+LPoWEbAxFaQ2Dw5M3nwnWNLEYA/OCuzKM9tLCtQ6h?=
 =?us-ascii?Q?ljWpZn+4+e86ln92nLeBKaL/VMFvJPcwmCx/Kn/31/09BrqaBWuuToG9M9np?=
 =?us-ascii?Q?RM3yyeXqjhZnT9k4o8GMB/LxAZi2l9wqHfXgOLdtelClTkMhJZF6ud8J67jm?=
 =?us-ascii?Q?kT8apJBly0InQo7y3lYYRwZJwXuUZoAsu7wsbjkPtS22cYRXDJ2iMKlB9EKJ?=
 =?us-ascii?Q?PHaoat3oY/+Nci2e5iW/b8CgssVlnXY/GzGeMI/LYfZxHAwm2Vif07+iFVWz?=
 =?us-ascii?Q?iG4Vyz6kkckAbXLd7heZdaHAVGEY4DNYUf034cxl1Evt2q0O0vN1P18pOylU?=
 =?us-ascii?Q?QEMyfBPJsmeNCbHqQuNs2ptVr1nj5x8pl7gdTA1FYI4Q0M2SIx6YMchJ/Iuk?=
 =?us-ascii?Q?8P8eSGtMnr+7SYhY2ZteAf1mxKLwwtytNT7j3p+ISomzSjqBH8RzsmPhTt+K?=
 =?us-ascii?Q?NtsI2JraEwuO6o1lZJld/YJpaRDnbAcJq0JJMnTFYrcTQLA/WVm/YaZ370AU?=
 =?us-ascii?Q?DkLQBPMoifjT/8AmUN7B5xnePAP1xLsw6aCprWNN4rwBIpIqaJxboRlnpdA/?=
 =?us-ascii?Q?cGnzhnnxXlMuXsUnI6fUWLdOsUmkuoqmVU3PczjbtY2paHhpFK6tY6RYg0H5?=
 =?us-ascii?Q?AoHb2uw/SXI5g9nu6wPcyBR6gITksrO5nF56dqN867OLPDqBE5xziEehjVs1?=
 =?us-ascii?Q?37PxpQC5/OPySZfzwe8WzsqMcW8nN/qZ4Aqn1GCuTQngBUSJiDWRbJER54D5?=
 =?us-ascii?Q?bXfO4eXJ0Y8B4A4ZFnGTo3YTNtkiDe/MuhnDg/CpMf+VeYJTYsLl7zjHN/Vt?=
 =?us-ascii?Q?tmuM0ei/vqZFKYbeACw4ebJ7b8KuWo17i7gnwN3qXZM7luCONS/W0BTgcCBI?=
 =?us-ascii?Q?32VaZ45UIj+s70g9UmD4mhVol3Z4VxLZs5J86AK7ii1ZL3ofZF3JrQabbZvq?=
 =?us-ascii?Q?j3U5JaNiK1uYxtxrXOLolRyeqonKN7M4O2kmnIGNgi1UnTjKnj/1MSHmv5aG?=
 =?us-ascii?Q?Qnmw4PvSPeOxSP5Y8ObzTEAvXhFlCoTHcqG9aAlVsq7zY39isgMxQarHw9HS?=
 =?us-ascii?Q?2X39fg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RNw0vM+x4VWYkYHzTFePwlEcRhLC4lUm8I1yRfCX0Zyhw9iFXiHRFNpBDkaAc3QQH6OsKcNIIaLgso5xC8/RT0dscyoTFdaVs4El7sM9SSEQQOakYGYPbTJMQC4uOE0+feTnrWVz5jqQb96Y+z26fNsO2EFrwig91vozo0CM7tCs00rIfpBTzbxVTRQqllb/fgYFwxUhP82p3pXn9ImxsKpcXeTKipqtQFyXcdtzln19osvLnNJTmuyn2nDr/HVk8CxXV9hPvj9xZq2IvVd8nqUvt+4TP1Bnauqr4F5DhdPPVcqvRu6G5pkULSvWG2/+5xAFh9XYgEb0/3AfHXs2yCUfzK4OLrCTUzYTzc2OPbwm4WxCHEOh5eNq74liWbYzuNLGrohhYxhIv3IKmxAEXWeDD0qTzQod12rpdVMjcMS+Ex4tbtiLFiVXNHeI/HoIU+c6ZgaoSu3CwSGG6uiNKY0UNWcnTwaRtB5U8BFCd1KlZv1ulYTtmtEQBKo3aZ14rc8Mo8Ek/Q5GUb93Dgx118S6sv0eLSym6590ZOjddlvMgowBUU0+e0wOSnM7Isc/IbCNH3O/7m9dZ7l2qXwJcZRmV9zVwPY3YAhemxcPJME=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6475a5ec-3ccd-48ae-af70-08dcf402ece0
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 08:07:38.3411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: myd8OAd/Vq5++OscT8kMgxs1Ud3d2ET7O74ywftOzFvdbBy7OijR4PxuBOArx+u/jvuLx/pQuABYfHE9ssvh383BVVcw5vOtCta0slVv5fM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4560
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-24_07,2024-10-24_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 mlxlogscore=902 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410240062
X-Proofpoint-GUID: b8LlskUT9rJgHOjJDMCnkcblSudLLPn5
X-Proofpoint-ORIG-GUID: b8LlskUT9rJgHOjJDMCnkcblSudLLPn5

On Thu, Oct 24, 2024 at 09:45:37AM +0200, David Hildenbrand wrote:
> On 24.10.24 09:34, Lorenzo Stoakes wrote:
> > On Wed, Oct 23, 2024 at 04:04:05PM -0700, Andrew Morton wrote:
> > > On Wed, 23 Oct 2024 17:24:38 +0100 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
> > >
> > > >
> > > > ...
> > > >
> > > > Existing mechanism for performing a walk which also installs page table
> > > > entries if necessary are heavily duplicated throughout the kernel,
> > >
> > > How complicated is it to migrate those to use this?
> >
> > I would say probably somewhat difficult as very often people are doing quite
> > custom things, but I will take a look at seeing if we can't make things a little
> > more generic.
> >
> > I am also mildly motivated to look at trying to find a generic way to do
> > replaces...
> >
> > Both on the TODO!
>
> I'm not super happy about extending the rusty old pagewalk API, because it's
> inefficient (indirect calls) and not future proof (batching, large folios).

Yeah it could be improved, but I think the ideal way would be to genericise as
much as we can and 'upgrade' this logic.

>
> But I see how we ended up with this patch, and it will be easy to convert to
> something better once we have it.

Yes, I was quite happy with what an ultimately small delta this all ended up
being vs. the various other alternatives (change zap logic, introduce custom
page fault mechanism, duplicating page walk code _yet again_, porting uffd
logic, etc. etc.)

But in an ideal world we'd have _one_ place that does this.

>
> We already discussed in the past that we need a better and more efficient
> way to walk page tables. I have part of that on my TODO list, but I'm
> getting distracted.

Yes I remember an LSF session on this, it's a really obvious area of improvement
that stands out at the moment for sure.

Having worked several 12+ hour days in a row though recently I can relate to
workload making this difficult though :)

>
> *Inserting* (not walking/modifying existing things as most users to) as done
> in this patch is slightly different though, likely "on thing that fits all"
> will not apply to all page table walker user cases.

Yeah, there's also replace scenarios which then have to do egregious amounts of
work to make sure we do everything right, in fact there's duplicates of this in
mm/madvise.c *grumble grumble*.

>
> --
> Cheers,
>
> David / dhildenb
>

OK so I guess I'll hold off my TODOs on this as you are looking in this area and
I trust you :)

Cheers!

