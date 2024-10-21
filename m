Return-Path: <linux-arch+bounces-8365-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA199A6F6B
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 18:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 577B1283FCE
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 16:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88FE21E00A1;
	Mon, 21 Oct 2024 16:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RqStx5iP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YupffbQX"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1291C330C;
	Mon, 21 Oct 2024 16:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729528191; cv=fail; b=rk55sfmCNZtMgjBQwaPVyumH8xsDp8YZvI5M1yIBZsl/j2xyzFGZ6pHyQkaVciONrSwXJ6RT7lwUMG7k/1h8ve/IGGpddMY+F0tpxImvdz3F6+9O3nDnC+M2f3IZhD9P+THMCBQ8tDdQN/JtxIDMOWJyZ2aZKuG2TfTnd9VVfzg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729528191; c=relaxed/simple;
	bh=eDu7w4k/jB1Ftp4uJ5gA8P+8NZHg2D5rWlgHrSSrOX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KQWQurHwANk0NaSXxfoV/CYa6laMT+qcJs5UaDDeQnaRrYhfMXQkT7ap8ItRZMytLcCW8OFYE8mGixRyu2bZna/a9jgrAyV3lc0AWWslc8HuHQ6EwCdvdStixwYdrM7/xim8Tzl4umwJ38PYeMe5yC3hzqzksUP6w1ut1Kl7h/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RqStx5iP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YupffbQX; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49LFtgoK017510;
	Mon, 21 Oct 2024 16:23:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=eQypnQwDNfpl4Qoriu
	WHQD64a27qnVDh397s1tMdyRU=; b=RqStx5iPgutJTZFyQiNedr1lueBLgeYxB9
	NJcbRpG/pbV+cSnyuuX28CcDR9EtGk+yEGPTAMJC5C5IxtmYnOewJbcxXGIHCVMU
	YMz1c/x/Tnt8PVRymnBSmJ3JujmXjHWQOu632hxtqRUvoFAMcA5GeujU5DuBC1LX
	dGHlZZNaIL3ku5KHFXgp8K0zcux9VtVJNXnwA62PjGsZ8PTBCFl7Io1hK/9XwBJV
	i0nfuGPnpoMV/EmTCfXUU8uFOLrhFU0HvTf0ZY4wLq2nBK9mFvLuXYtCpo+umWyc
	GnOus8NEMMngr20d3yFnJ95XkymTZXHS6xPjouObZm7WZqUHslAQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c55ebhfv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Oct 2024 16:23:18 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49LG81Ca007729;
	Mon, 21 Oct 2024 16:23:17 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42c376jgxa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Oct 2024 16:23:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S1FO8K9tLCYHlqS4zxHIFk/V2FKmRsCuRgIDfRIfGAVLfMhEjtxcLVhn5T6EOsN+8A6PaSsHDVUkXa4dX6TAZKQ1GC+vDVHJkNloi7DSJeDbsylAo1yWVj0oQaGHb8pLv1PQqESyPooGRJeuqzM0HI6DSRsmXCKJSsCtCcSeigRxrIah3TqBZAvyXT+zsMY0j3dz4ijQFwCchW8sM/QHnHNMXBCrRTt/U7hS/ZyGjRGIGToga96UuT9wz+FaOgb7EsJ4gz41L02TXeUP4B6chWXRvBtPxk1SiarSvmaKfdghyxllWRYeaq+0z+jQtYueXmA+0jVSprA5PniEIfkGgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eQypnQwDNfpl4QoriuWHQD64a27qnVDh397s1tMdyRU=;
 b=svamwtxWHqnEDM9o73RxTxr3V8bvjge2ptWLE6H+nW7uZN9jC51n175LkiKdlAe7xcXz8aA9EQi2/KroiQ6r9WVXjNkRy/CYvX5qgIwh/LOLnJOI5hWPCqyICG5fpoQU9ucXcVSxEOoUzI2I1a97LVOVLvN9VM9IZ0cRzxGRfBrFNDMMsNIl026hrvVb2sG6USpOo/1t3Uwdyaq38Elz3uB7/6Tr1JjZBdkE2zgTpyyi29zj3psPSLQE45rO6Y9snG5IA6pAlzpI857iNtLvbtWBFHZS6QZWPYxNDGjhcM6QtAGYyXkXcuc2EoHrITC4SInol/uD349n2u7UVGhv4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eQypnQwDNfpl4QoriuWHQD64a27qnVDh397s1tMdyRU=;
 b=YupffbQXlldwk7Isurbbc3H18QiUC/s4l6q4S3J+kIZrZ0XKmYt7QFalRYBODGjHCetbJskzUFBKIdOO/fAmjen1Kbzg9wE64SIB8JES+O+RcJHizlGPIwpfWq6CebOCONv6GNLd7F/u+IVXrNJCwsWmXiRZpw5fcd98aTz05ro=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by PH8PR10MB6315.namprd10.prod.outlook.com (2603:10b6:510:1ce::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 16:23:13 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8069.024; Mon, 21 Oct 2024
 16:23:13 +0000
Date: Mon, 21 Oct 2024 17:23:08 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Vlastimil Babka <vbabka@suse.cz>,
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
Subject: Re: [PATCH v2 2/5] mm: add PTE_MARKER_GUARD PTE marker
Message-ID: <ea771edf-0e38-440f-b264-3cbe285a628b@lucifer.local>
References: <cover.1729440856.git.lorenzo.stoakes@oracle.com>
 <081837b697a98c7fa5832542b20f603d49e0b557.1729440856.git.lorenzo.stoakes@oracle.com>
 <470886d2-9f6f-4486-a935-daea4c5bea09@suse.cz>
 <434a440a-d6a4-4144-b4fb-8e0d8535f03f@lucifer.local>
 <caf95a99-e975-4f3d-a94b-298a5fc88b5a@suse.cz>
 <4f4e41f1-531c-4686-b44d-dacdf034c241@lucifer.local>
 <cb0e49be-7b4e-4760-884c-8f4bf74ec1e1@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb0e49be-7b4e-4760-884c-8f4bf74ec1e1@redhat.com>
X-ClientProxiedBy: LO3P123CA0032.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:388::8) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|PH8PR10MB6315:EE_
X-MS-Office365-Filtering-Correlation-Id: 33adc5f1-683a-4a25-e7f4-08dcf1eca8ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?M1G0yyYRrBBTePkDCmA8XciMAHeIsnRSiqqVf8yHTNTuzea0FnMuXlW5Eri9?=
 =?us-ascii?Q?7zZB6TJ8Z423mKaUcgnrDRHCtZbqKedBMiTUo+5umIvbG2FyygjoUMU/SmxO?=
 =?us-ascii?Q?cE4YHj9fq9fB28rwWwE04hRb0C1HyVteDiKAJipXgyMFKyFuQfCQKFQQJnsD?=
 =?us-ascii?Q?LnjK5cji0OybUdofNlpgzL3WYxyjrLPOHLSH1sqROqj/IBtxvHVca6aEOUB0?=
 =?us-ascii?Q?8GMTjEzLHX0kTdTyHP0jNVdSGNoWK0DeWTi6uobjlIf6q2/huEAWgcQ9jKb+?=
 =?us-ascii?Q?19kB6Pptwzqc6/dXtCIuD4KmOh+iVsEgVm7MKz3tBO3gcyOoja9eOvDwRYB1?=
 =?us-ascii?Q?H+YVCyqzi0x+GQgTEm8H9M6RtrG0HDPYGNNwW61Bj9dAAWPo1SC3gyjOXM8t?=
 =?us-ascii?Q?pBGEU0hTqS75AKZccge38Id3dfL+9KqloVEsOn0k2ffzP6UkWo8BizIE8xaw?=
 =?us-ascii?Q?/P9ONMyMt9AeWcIgD2PhsXA80oqxnZpP+/vbvOzAeGrlsRzTGhmOgSC65kVm?=
 =?us-ascii?Q?G0GiWywuUHbyg5BfMOVF00kvZaztUa+1x/CVlx4q/Bp8wRgkNQTJo3X9TeJ7?=
 =?us-ascii?Q?3LdfD0cjFCrSy5VzRGBJynRlTPxA8aWTflmTY09ahz9je1FxfxN+n3NR77mP?=
 =?us-ascii?Q?eCdlMt04l+Tc/9TSE95IQSOsghNuutsRIKVT8cmtIK1ehtk/rq/YvZdIk8dw?=
 =?us-ascii?Q?KrXZ+Fv9sdz/CcbiTrrSCcoDJekqLVXf3O7WDqJzu6FbZY1NkRMvwxD7Ii4o?=
 =?us-ascii?Q?hM3YnA3iTA4z4Ch7ozwVQjCtk1bk68V01keVYZaqNXq0+wvSokzLQSg9FWep?=
 =?us-ascii?Q?JR9uV7vB4tCg/9lXxeL+bjYFfouoL04BEVtKG9ezOcZTG6Px4+rlJDHxqcyb?=
 =?us-ascii?Q?7DcGU2fE7bX7AfVO9onCe+TgiOzgBPbnDgTODBMXKWKLGRTKcWY94o3RCq7U?=
 =?us-ascii?Q?++TKKHK7zzv+Z+BbcgQ4+EbLc52v5VfYwZ38MLsuPWvY9aJSx8CWFsmtg6Vg?=
 =?us-ascii?Q?OPmQa4OOKuKtNQyKk8dhaX7fez8j/4RAPVSs5an2oYWVwYUEu/UI3P19dBUu?=
 =?us-ascii?Q?JhGiYKJQxLK+JVyQh8tIsEfl5oD8DZ9jp0tR1omFfVk0VAw+QRYUXQ/VG94D?=
 =?us-ascii?Q?O+jis9GbMKpNkP3ZMX7nYftcLIQEFvFgWIjNe5Ck9GcBjrFx9aUSt3+PXRTt?=
 =?us-ascii?Q?K46FSlJe4kapp0/tMPWJhD1+qKU/JDW/BLvTEljM0iHux04igmtPTAz9Xr06?=
 =?us-ascii?Q?C7h0YkznuxaYf7sOlx2qtqeTJBn1C3N9uN+jkFj/0z5LGm0CqShMjrkeeVjE?=
 =?us-ascii?Q?yKdPaE0vKvL1DP6mcv8fsPJp?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7mYiz1sWFlWo7+tSGzH+MLOuX+TVzFp+ihI9K1NBgMIUbCmvspHzyz8uyCWz?=
 =?us-ascii?Q?vf86Z4j1Uac/W6OUdw17PdCsqZaA/yp7YCdrQMjGExnn+8wA8ISzlaLOJxVH?=
 =?us-ascii?Q?n7CrtbiEgoJNSehc2PZ+eckrVu9uI0ihs00MOiGoA5wmM4oustMlQfWyZmUr?=
 =?us-ascii?Q?VE5aHsvTEQ1IlN+3206cMmwPrwFr4fcwRUWMOtaMtbg7WA3m+dknf5TBL6Lb?=
 =?us-ascii?Q?XWnElRsyCWV7MpqbP/ZXfbZgTCkk1MVk4IXu3Psk+tK20Fw7sKh8dYcgaT7e?=
 =?us-ascii?Q?lPtgIsZFb7zBdHdOBF2gC/3LYlXchDw+xXhgg1/5issGYTSc/rYqZjPqj65T?=
 =?us-ascii?Q?cp4aLTizExrkmA6QN6+WoH0Xd6NI22twMwYbqGO9njloihx05VKtW5w7hpfa?=
 =?us-ascii?Q?GNfG+Kj3zzwZ//+Oci8vsZ7Y6yU7cI5+k1YKH1PNm/MdS6KlPHfcx2lkPOfj?=
 =?us-ascii?Q?ewG/ZSuZsmIliorierWfe4lhFNBRyX3G19uGRh0MzKsd8OhDKlMIa6XNcoOq?=
 =?us-ascii?Q?qKQyqfP1YY7Fy8kNwMWrrNU8XSaET9rAA8AJ9gQPFCrfBBDi81s3jHQyW2GM?=
 =?us-ascii?Q?zmGOH5yF4HqZAlZBawDgedr3Y6cCX1U/vNUY6/cjc9UT1DXSPAspOz7Nk+rY?=
 =?us-ascii?Q?oBJDPtta5pP8I/FBU022+dNyQtN2gVCs19kDo26E0lwy7/b5G+zLGQr2xPvw?=
 =?us-ascii?Q?2yLZuCzQuXO0nz0v07LebWp6Hvr5Uf8o5P41JSzyre4qq5Stml8Plmn7ywuT?=
 =?us-ascii?Q?9iDD7pWWV5fUF7WDXQtR282gukx1j4OAL0uhawzGzU7/brTMev6lCKH0fm5/?=
 =?us-ascii?Q?bDlx9U7gbu5PLCpriuKVcTQzjaX91uoMbG1UdeSh3d7lzWn5/nRdq3bQdDvT?=
 =?us-ascii?Q?FzyYOYiD1UEchSz5eLGvU7K3SofmPkvuNGz0Tyur7GhfoskVGOQqPf0HHZcT?=
 =?us-ascii?Q?M4Cnuwn4VsC7u8lv2LouhqHbEQTz1EehjpO4zv/e/Vf4I30xjtMWPN9Mqe0i?=
 =?us-ascii?Q?+TcBU1yPgyyG/yGNBF6FrXl4PqIzfHfwKzjY/o1VkLBrvvjU8wUmZDDYymb+?=
 =?us-ascii?Q?eZtWn8iDSsc6iBegGrTjglYibD2QwRHzn+yzcqChF81VDELDTmcAawoVsxa+?=
 =?us-ascii?Q?Cr3BuuyexMWj3spqEGRSIjNg6XztILOJ6Utmb0KbV9BJYEJ292WiJwCeckli?=
 =?us-ascii?Q?NGPHSzdmJFawNAcW94Zz/eiyNif/Xbwf6OB/2X1bHqrL+GPVLdI9HcrGHQOa?=
 =?us-ascii?Q?xqj4iq6+u4XEM92qoh4jqWWFsoEO6WDaIT9kfLuLCURfpqkeVOMJ0U6fAaCV?=
 =?us-ascii?Q?cw1GfouZVLR8oUstAlkh0Jm42gWL7zll6Lf4MvPU4fneRej99BjrG6WTA8gm?=
 =?us-ascii?Q?Fbfv9K5on4pQ2hRBrRYWbcE623vVmpKOvSgUa4ZV5IPsLTL/y5q3bXmCnoWg?=
 =?us-ascii?Q?56u6MqeihrN5iO5ZRrcKjY2CVBL6x134xi3sZ0aGCTY1z2ER6/i09rNONtii?=
 =?us-ascii?Q?Z90W0H+1keOCOv9jb0NOY7BhDeL3hoXPNDBKJVR69hDAnaKWj3UN1yVsaazQ?=
 =?us-ascii?Q?2yr6SPV3akT5MnqK6CXtEkMUwDoikah+PY3wHJrNEAC+Rcm8SlCUXQ2HGeku?=
 =?us-ascii?Q?wQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2wiPSV17liI9PZ+31RMAo0Fg95JlNbBaPn+cBRb44/FsQd7YYt5RuMXcNe3K3pBlUb1JCwSkCBUaGWqYYVaLnV9Ojh6GFnEK3RbGO7kc+K2m3EagBOQ79rZ50CKsEMHAYn6qPz/mKcZF1+gmlphAXg6vOs6y/uGOiyj4ytksDSkIt9glOJnbF0oO6wBnrfuHGLz7Rcx7IFyQ/yGNMqpIi1y9fVv8QTEMwyGj28AU6u2hpNzS9dSTHAg+T3sUfOlFurlrp+9OALwTj9oDrwXRiNl7L9dxILzhcHp3oGe2ONp1D96EbOz7iLQ09K8YeXIHJYhT090GAjn/2RMDLo9RRkJ6QpD9nICCm31F4eLhdxD8W784h4xlY+Fzf5XmttilDvD6cAk9C21EJr5GS5iMbDsh3Cn3bHJ4gL47ugt3PQZ6xOEZ8X4xHbcsBwmqnvvQ+LAtkpAqR8bgAssIsuj2hF2JS2c+RSFUz5dCPGPzK1GmNbwLF3x8qB8eI5CD0RXY9fuBEbCctMrh4WO0m6iDNno0+8CD8BEOJQCu6ziwK1f5LWRfHp3E9TCdfHu/guNS9flolTFoSpGZJx9/Kke1hOlHvYc5cSlIa31rt+ZT170=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33adc5f1-683a-4a25-e7f4-08dcf1eca8ef
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 16:23:12.9871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dgZac59hcPWzqDQg519One+Fp8B2Vp12O8j9pSXZUC0bW9ZXLs4TCMTkQ78egZb4bYOnLAqBU0EBOiWEMSF4JsbdFuz+DPQO6UxlapVP/Zo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6315
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-21_14,2024-10-21_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410210117
X-Proofpoint-ORIG-GUID: TdGl0xLKf78M1BBXPQ11_JSEXodFY_Fl
X-Proofpoint-GUID: TdGl0xLKf78M1BBXPQ11_JSEXodFY_Fl

On Mon, Oct 21, 2024 at 06:00:20PM +0200, David Hildenbrand wrote:
[snip]
> >
> > To summarise for on-list:
> >
> > * MADV_FREE, while ostensibly being a 'lazy free' mechanism, has the
> >    ability to be 'cancelled' if you write to the memory. Also, after the
> >    freeing is complete, you can write to the memory to reuse it, the mapping
> >    is still there.
> >
> > * For hardware poison markers it makes sense to drop them as you're
> >    effectively saying 'I am done with this range that is now unbacked and
> >    expect to get an empty page should I use it now'. UFFD WP I am not sure
> >    about but presumably also fine.
> >
> > * However, guard pages are different - if you 'cancel' and you are left
> >    with a block of memory allocated to you by a pthread or userland
> >    allocator implementation, you don't want to then no longer be protected
> >    from overrunning into other thread memory.
>
> Agreed. What happens on MADV_DONTNEED/MADV_FREE on guard pages? Ignored or
> error? It sounds like a usage "error" to me (in contrast to munmap()).

It's ignored, no errror. On MADV_DONTNEED we already left the guard pages in
place, from v3 we will do the same for MADV_FREE.

I'm not sure I'd say it's an error per se, as somebody might have a use case
where they want to zap over a range but keep guard pages, perhaps an allocator
or something?

Also the existing logic is that existing markers (HW poison, uffd-simulated HW
poison, uffd wp marker) are retained and no error raised on MADV_DONTNEED, and
no error on MADV_FREE either, so it'd be consistent with existing behaviour.

Also semantically you are achieving what the calls expect you are freeing the
ranges since the guard page regions are unbacked so are already freed... so yeah
I don't think an error really makes sense here.

We might also be limiting use cases by assuming they might _only_ be used for
allocators and such.

>
> --
> Cheers,
>
> David / dhildenb
>

