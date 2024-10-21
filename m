Return-Path: <linux-arch+bounces-8408-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1E29A9253
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 23:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E88E0281EB3
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 21:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9B11FF5FB;
	Mon, 21 Oct 2024 21:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TDJz/Q1M";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="H0GbPcg5"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427D31FF058;
	Mon, 21 Oct 2024 21:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729547240; cv=fail; b=iE6fNGjuuLxxof79sdVbYvSw4+wWa55EtP1ybbOAkVUqGjxhw7MXrTDWGdmNmXWE6d/JJ9jhwULMCJAJxYO1wZmTIrYkoDSfm0qddbvSJsObCd/5ocyj/CCopSkWS7SORjw60KI36GSVgXO3JV1MJk9ehxX5YyG6n7X/iSn8diI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729547240; c=relaxed/simple;
	bh=VplK7tMh07DRo6t7tPNrSHfayVHYdHAhgBe/01PAfac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RY49JhmoJAggWzKerErpIaEcjsq3BcODn73czSh880fx7gRPYmzFjjEjWtJN/7+Co7EiQ6t/KHsnRWZH1OxJLL1jwASBpixrJHLAA2armDa0aYORjREspDiflq81KQG7Yjy/iamQ2/TwG0Bse6Erc/tADrfjKe2GPo1SRGdvLgQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TDJz/Q1M; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=H0GbPcg5; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49LKfb5M029854;
	Mon, 21 Oct 2024 21:46:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=VplK7tMh07DRo6t7tP
	NrSHfayVHYdHAhgBe/01PAfac=; b=TDJz/Q1MKrgrBZk6j3AkaO1F/7AlVrC1tr
	niU6HWAZ/5xlCat2Fi2wqYxfhhzQH7BWVk+TrMMb/8tOHV99FEYlM8hWyTCwyfX0
	dIzZ4sxIUky5HL0i/NJ+cWiE9LfKW1cFZpN2c4z16e8MNdqPbgEYEYZBHybLJhIz
	Uw74603YV2NmXHtytsOYbyiGMqqjLd1OptmKlBDZMj/KIHLLpdep4amLnDDupZ6+
	BLCSl2VJK9YQrbP7hCBJfXHNK6+GjHc+ufKPD0UldvFIBsQxGWOC/c4zltUrYPK3
	2jKugqM2Tkhy/MjQnjTrhrL9/IfCBkajCYe9q5Ulwf01MJ6OjIEQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c54548fj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Oct 2024 21:46:42 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49LK83Cm022727;
	Mon, 21 Oct 2024 21:46:42 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2041.outbound.protection.outlook.com [104.47.58.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42c8euregy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Oct 2024 21:46:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aQFrfFMUU4U7+njZ1ZWIr+RgwV+kpTM4MJAyN3Cp7hpF1Tl/QfgI4JhlqFwdP6IgvgTpczaCowlaokrWRN3zHX/lHRlOU98CFmW6Ry8Ijqgqx0TuOiCOodmrwpN3KxasAYj/d6TC+cj+lqY2Z/I1WX+tcvUlv6+ZA1o7mzhaDVxE/f4vcuG4a0TWt7by7qBLIuGdmUxNT1vvBS5IGOu6FQ2wvJ1BChXrw7iITes2u1Yur16oYiLG96ioiiblDXYkXbZLJiDRQ2X+YDOKuiwQC474vEo20BwrWPuOX5aQ4AVyRYTkOKgD1IV9kNfSJluMa6bVR3kyv4qZa3QQrQB0/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VplK7tMh07DRo6t7tPNrSHfayVHYdHAhgBe/01PAfac=;
 b=OU9/0nmX+6wThRDOwkEOmGQwaIeMmJ9ImLOIgVREDyQaoixuv5AQuqQJfK3Md3z86cdtL3r2/VOzzNiJp759I54dlqxM2782kElMPtYw/lvciQ35HrDbjqWEYT2Rx8hySTGi7owilgJOEiDqOiO6ivn18s1sEkIDG8cHL2JGn/J9jfexrhlGgc4gwam9bkxKKrZJX0u5yLWi/Fg5WGNOBVfz2LcFuIxYdTPMQP7sNGoJrGP+HZMjkWq4Uaio3025Ngi7NwbMGywcSLc3ToVz18hBzpNgJUJB8IHQojX3RutQqb2sqhR1vL90yiT71Vg99ktdmdYiajpp9MG2tfnhAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VplK7tMh07DRo6t7tPNrSHfayVHYdHAhgBe/01PAfac=;
 b=H0GbPcg5yoe128elaZPUylmL2EyK4RzOqgS9Ul/Ul5qFhtBKrQf3vzcAH91UxYD4JdQj4z+B7fHk+poElPDUbFwm/FgZdDoQ4IiU29Np1YAAC0PcDmxMO+OBl8xgc2Myw7Cqglixw5Y/8iwKheACIYh7Dtuh1wJIxiliG0MOttw=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by IA1PR10MB7540.namprd10.prod.outlook.com (2603:10b6:208:445::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 21:46:36 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8069.024; Mon, 21 Oct 2024
 21:46:36 +0000
Date: Mon, 21 Oct 2024 22:46:11 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <muchun.song@linux.dev>,
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
Subject: Re: [PATCH v2 3/5] mm: madvise: implement lightweight guard page
 mechanism
Message-ID: <efc2af8d-6e6f-4bd2-9edf-673ea622185c@lucifer.local>
References: <cover.1729440856.git.lorenzo.stoakes@oracle.com>
 <fce49bbbfe41b82161a37b022c8eb1e6c20e1d85.1729440856.git.lorenzo.stoakes@oracle.com>
 <c37ada68-5bf5-4ca5-9de8-c0838160c443@suse.cz>
 <6c282299-506f-45c9-9ddc-9ef4de582394@redhat.com>
 <fedd19ce-ea15-4ded-a1b5-ff050de15bba@suse.cz>
 <9727ada4-0048-499b-a43f-ac0a625bae5d@redhat.com>
 <73134e10-19eb-4e52-b87f-5fbfd322b575@lucifer.local>
 <0f7a6b69-5706-4010-ba7a-68a071922c80@redhat.com>
 <b92c58da-ec94-409b-8cdf-46eb3d2c7870@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b92c58da-ec94-409b-8cdf-46eb3d2c7870@suse.cz>
X-ClientProxiedBy: LO4P265CA0114.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c3::18) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|IA1PR10MB7540:EE_
X-MS-Office365-Filtering-Correlation-Id: 488f1e03-b911-439d-35c0-08dcf219d27e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cy8qrotfXlD+3aDsfHWrTTONHES6PQy1wH5ygkQ7E//dvj1jP/RQz2epLAoi?=
 =?us-ascii?Q?ow0QJTri/rhp4DkOieHEWATKnnVBno8Gp+o7SnG7s413LzjbX+N3eUDU8UKT?=
 =?us-ascii?Q?YyGLvTc7kZ3/wqVPlE/+tYZFzD8OVfXUNc2gICxC84PsJ7Wxzc7YAf4Q5wkc?=
 =?us-ascii?Q?nwN722vIU82lqhY1cbBAFm+y5He0s+MJBwg6IQmWddgMvyz3mF7UaQK47phS?=
 =?us-ascii?Q?g7SAsjH5091/uw/Kf068rsR13XmuuUyvePDvDYJdTJOLwTaKxCEs0IR34fXZ?=
 =?us-ascii?Q?w5DBcqlA0XfxfXHM1ivbpF0BfKQybFPEOTg6TXOi/kbwK2T6eqk0U6Oov1Kw?=
 =?us-ascii?Q?srWXaezIrzl9FaoldAFn4Zll/ZyQuVuy/8C+QZzP5Qlb5udk8UxdQYUgjrHc?=
 =?us-ascii?Q?c7PQpWHfvGaJXYma1nipECEpNeFxqwU8JHr6H+5IMsOAGcXCdbccb5z9XcTJ?=
 =?us-ascii?Q?CalfwScY7nTvoW7SSD5VwmjFtMVso3uZIoJDRzV+/XMjuurEjLgx0U/aKLGe?=
 =?us-ascii?Q?2Cxb1hH95bPCkJh73KTPlVF3MBQ4POjdfDAAorW5NxAWzIE3h67yXyzYk7ar?=
 =?us-ascii?Q?PqWbd7iMwJmP8AuzE2GH54p1YDZhzqsDvZyZ5nfqfhhoBZCP4ucvzMZhWQ7j?=
 =?us-ascii?Q?VTXrIKfX875/KJK6PgIT/ZpSkRQcdH12WA4vojJVkc8W019WyKJwPq0HfGW/?=
 =?us-ascii?Q?c2RHCHoqgjio1LV5q5DgDypp0xwSWlkxkJGTr3uPeI1Eew9ir68RHP8sHgoP?=
 =?us-ascii?Q?hSohP9Pxczz+0wu4jHl9B0azqyyJBlGY72+RFFZ0KfUxrvq6fWEmqXreplnk?=
 =?us-ascii?Q?gDrfMzvbH2E5F6MbrhxEVHMbmx9AZZ8ugL4aoS5LHnI8MCuVaqgMKulLZAY9?=
 =?us-ascii?Q?60/FoZAADnNlgJHB4/FZmyY1MmDVxQbws78bj4wQhnwDLs37ra1Srf+pX6tZ?=
 =?us-ascii?Q?W48f893GXZQj/X/hH5JosK3n9NIbPijARTNWs8uIa/w0hzicgFXIY8//ZFzr?=
 =?us-ascii?Q?+Lp7iBd/z89XzCMGdEb6KUf6DGfbHn/mTX8fm5Syvguu2AxOSNy2teZQmYb5?=
 =?us-ascii?Q?uo8hCBYkldgX//IaOF7Wq1OqpJeFHmr0rBFmgEOJCKKUW+g2mRMSnpsgvKM5?=
 =?us-ascii?Q?L6HMsOp3fDMcMpezD2sgKI/EtfnSROEQoeMIueNIoGITcxPTwo/QtlTEZfjK?=
 =?us-ascii?Q?YPOa7JWT99Ju/aosKlNU4Dg2BkeEop5WBtyY3RxieRxrlilnAU/gVCa+Qw2h?=
 =?us-ascii?Q?s3o9aYZDoCldm0iM9QndH+yo8B75lkpPdv+x4eEY6cS2RScxbCMWXMiNFfbF?=
 =?us-ascii?Q?2nwd9ybfxbgWZg9jNC1WlOVA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ic9hpG2nVKnAyIQTZBX5KVHN2x8JS7LCx+NICOlCqGGx3GMajjfAmpUF/jCI?=
 =?us-ascii?Q?H31XlpepnhOGebA+/XhQPCoq1WGWd9zrJ6bJvQc3V1EDgCCIKfRX/0Bci9M0?=
 =?us-ascii?Q?oKNvwf9N+aYW02m7GAVAjbuyqf/I7DrsGmkGoUYxCoRMkQAfPOf89vStvDw/?=
 =?us-ascii?Q?be9J//0tKVtdfvXbKr7YBH71V3fgTiONKJeTJkbeM2LSSRIXmw26vWY0vVhq?=
 =?us-ascii?Q?KOl46vUchNMshXN91ma0kuUWhwfoYUsFXMOKbPST4Dc9C9/RHDdlSwlROoO7?=
 =?us-ascii?Q?GBm+nG4n8noqPl88monHnqCIVavE3Y87N3AjOP/vrZ1nLp9m+S92xpKM1wBr?=
 =?us-ascii?Q?fLM9SWx/EwzM0M8tNUwiQwSfUvu7QIeBScS1kwrmXhP1Wa1Cr8TDfI9+D944?=
 =?us-ascii?Q?lvTcpm/TW+QQP3G+4acf0BCRbqnl4Wfk1Q7MzWJFrbvYoNidBFG3pZJZr87f?=
 =?us-ascii?Q?e5wyGaOmvtYq9hBypucdW31w0GAaPlmisHTX9p7fFIr8CZuIHSVGVCAogWSZ?=
 =?us-ascii?Q?BwOzDRbwCOO0p8yRw6JFTL/CrIms8Dq3TdVXD2pz7EpkO3NC/ieUsg3LpYi8?=
 =?us-ascii?Q?XScNItriFjf1bZIJjSqZLpXtSTy/BKcYSEUEcyqmnzN42X+clFjoEcvJE9VU?=
 =?us-ascii?Q?sqy2p9/WdxSaa8Xgr8RcV3uSXtOoQ/vwjG0+mAGVM0TDeyXCHord+JC09OvW?=
 =?us-ascii?Q?3UXp+2sglDkdJR1O4BmxzTmt0W5tOTMQeMXcvu17gPTmdvEgQXQjO8aq05T1?=
 =?us-ascii?Q?oKJYArZsNCUNDYWI+lgA8PLXDOrea8DLwWdvKFMNCqTJUfKud0AXrWufCDAh?=
 =?us-ascii?Q?qh8wkhYM1gCpZvHaOd8/yIj/ZAKaESL9V/DKqFH0bexWc1h4zeV08Pjfw3Q0?=
 =?us-ascii?Q?wRg8Fclg20FFhg44MVND0XKz352NeTMDoTIMkmtc5uWtPOIthjn0wmx4qiHn?=
 =?us-ascii?Q?izYukFrVp70zSeuSeqSi8T4ZoYjdiDUiH9Z3Ls3Nn9eX78ufujvXgZU+QbEt?=
 =?us-ascii?Q?CLk09IuXD3BmrvdACDwUMMfa68PGANinWUnObnDXbHHg9w9k3uQELZWlws3B?=
 =?us-ascii?Q?0QfEzGIPPEQxYkkNjYMTrO5hm6f+lVntr+NnQbYY8pR9qJDTYufUBWaIykUj?=
 =?us-ascii?Q?J201m9+L47iqIVL4cxGJRLChKJA8ELqVVYKBFcUKu3JfIPAc/fcCCk2/nqBx?=
 =?us-ascii?Q?3rAj/Bpq96qV85k+FO3tfpn/eaiiq6rNUhCcmEy6Wv9WKtdjPorQgkgyx11S?=
 =?us-ascii?Q?OHQANfXO3NNGjOUswKZtXdNcssoJ0k9rnK6DIS46fjobwcMgIX+FCC7wmDZ4?=
 =?us-ascii?Q?v9g/KKZy4QKTXwQ1uWjqmM+M533oJsUybYBCQRvpCsPx+7KRl24AztLmwehn?=
 =?us-ascii?Q?r89ZXlgWeWD14lqApewJB80LLZRLtvlRYvewK1dfi5klOZrWx94VV9t/oD+Q?=
 =?us-ascii?Q?z127PdTkkaEbPQ4pu9DZ52D0XW9JhEUJS4tYgB9M7Dj6bT7Kd+K3CSzwQ647?=
 =?us-ascii?Q?dfiIDCAdniordBhq0CgKQjvn+Fin+jXAVAKnQquQqp+OoAmwho0RlNxV6aQf?=
 =?us-ascii?Q?/d8xDKFY25ZLzPu/1VONP4h4DCufm9KlpX9yW57KOpAoJuuG1ilplXMPd+tm?=
 =?us-ascii?Q?pg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VYx7nIjxgTZB5KrgSpS2Whg1fPxSQgDkKMeRjvUzdbM/Khxl+RxlXcY/ObLpdgNsDpw5+1E3lSOLqXL7g4apOI4sPmQl83GqO3JqcC/Sn8ZUl9NxCylk+xOLQpCbjzCnFRuVZ8BWJ5WMxtBPhbQmlhP3JWzO3Yjq1y6LUF75ChHczeWr+vwkkvYu0ljrkpzWWwyq2UhfxOH9qHkMXR75YHj6kQ7EfXAsi4WcW53kmQrqCidcd7oIcvEWGzAjsnyxj6Z3C41nbKaBIBFMnSLMf5CC2TyOgCdCCqGrs/sESZ/EiGGdbyHIhy06wl3Vn1st8FndaedAo7QXkkGo7bBQUb7YGbjZhGw7DYqcBECWqxWGrUH07d833/nlqr2gDCGUZUsgW6cOSYk5KbpNvUTrqLKFlCy4KFHU70P+4/oKqVPKaUfSPEaVxpFgPKdpwY1mOAsOzLH8Jo4s0zBgvRfjmcZfO3tGUre6VAFplWTm/pN9jHwf6cqAQ00P+pBYd1xyVh9u21va5tJOnTHzTDSVDxTYZZe8uU7sK3M4LqoIcHsJnFCdkpgEsOBWLc7eLPPxbQ/FF/3TDya3XZcuRdXqi1UYnQfL4pCm8C2MdwD8hZE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 488f1e03-b911-439d-35c0-08dcf219d27e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 21:46:35.7786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a/mfwEEQf+XncYnR0SnVHAGoNrSwihHGvjM/Rm7d6+gJmFuVjFIhHLU81bQo59QWz6AuEbfX6DHbtt6M1l6ehwPGW+F5MUziAbPgnK2mVLU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7540
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-21_22,2024-10-21_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410210154
X-Proofpoint-ORIG-GUID: QuDA_ud536oB0mM-6txpeTJ6bke3xkZN
X-Proofpoint-GUID: QuDA_ud536oB0mM-6txpeTJ6bke3xkZN

On Mon, Oct 21, 2024 at 11:35:24PM +0200, Vlastimil Babka wrote:
> On 10/21/24 23:20, David Hildenbrand wrote:
> >> I don't think there's really any value in that. There's just no sensible
> >> situation in which a user would care about this I don't think.
> >
> > Making sure nobody touches an area, and wile doing that somebody already
> > touched that area? I guess it could be worked around by
> > mprotect(PROT_NONE),madvise(GUARD),mprotect(PROT_READ|PROT_WRITE) ...
> > which is not particularly nice :)
> >
> >>
> >> And if you're saying 'hey do MADV_DONTNEED if this fails and keep trying!'
> >> then why not just do that in the kernel?
> >
> > Heh, no!
> >
> > If user space doesn't expect there to be something, it should *fail*.
> > That's likely going to be the majority of use cases for guard pages
> > (happy to be told otherwise). No retry.
> >
> > And if user space expects there to be something it should zap ahead of
> > time (which some allocators maybe already do to free up memory after
> > free()) to then install the guard. No retry.
> >
> > There is this case where user space might be unsure. There, it might
> > make sense to retry exactly once.
>
> I've thought so too and the RFC was implemented like this, but Jann came up
> with a scenario where a THP can cause the range including our
> to-be-installed guard pte to be populated even if the userspace is not
> trying to access that exact address, see here:
>
> https://lore.kernel.org/all/CAG48ez3vqbqyWb4bLdpqSUnhwqGo2OQetecNhEGPdCGDr94nbQ@mail.gmail.com/
>
> So unless we can't *reliably* detect that userspace is really shooting
> itself in the foot and return a failure to install guard pte *only* in that
> case (which would be useful), and not horribly complicate everything to
> ensure that reliability and to avoid false positives due to races with
> THP's, then it's probably better to just retry as this version does.

It would be complicated, and I'd reallly like to avoid trying to detect
this. It feels a bit whack-a-mole because maybe there's other scenarios
we've not thought about that could be equally problematic?

>
> >>
> >> Trying to explain to a user 'hey this is for installing guard pages but if
> >> there's a facing fault it'll fail and that could keep happening and then
> >> you'll have to zap and maybe in a loop' just... seems like a bloody awful
> >> interface?
> >
> > Hope my example above made it clearer. This "retry forever until it
> > works" use case doesn't quite make sense to me, but I might just be
> > missing something important.
> >
> > But again, I have to do more reading on the history of the current
> > approach ... and it's fairly late here.
>
> Yeah see the RFC thread linked above.
>

Right, but I don't think this is the only scenario that can happen, and I
think, FWIW, yet again the fundamental point comes down to 'is it a
problem?'

Because if looping like this isn't, then problem solved we can all high 5
and go home listening to the prodigy and full happiness.

If not then we can revisit.

And how could it be a problem? Surely only security or DoS
potential. Hopefully Jann can give some positive feedback on that.

We could also, and I hate to say it, but... try to find some means of
checking on reasonable forward progress in the loop if we had to or some
other 'reasonable attempt'.

But let's see...

