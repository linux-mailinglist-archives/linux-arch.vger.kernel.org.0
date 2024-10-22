Return-Path: <linux-arch+bounces-8416-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8529A9FEA
	for <lists+linux-arch@lfdr.de>; Tue, 22 Oct 2024 12:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A87FA284FD8
	for <lists+linux-arch@lfdr.de>; Tue, 22 Oct 2024 10:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D592219A292;
	Tue, 22 Oct 2024 10:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="M/l+RQjc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="abZMl2C7"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CA8198842;
	Tue, 22 Oct 2024 10:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729592797; cv=fail; b=VP/SiXF9hrgG2SxJtlXQv8ygfh3EVnjY6/F8LCY/QKy3anEiQM0gMErtMnMix6LgBuiEyb8e3FygV6HdeUj2LKcWmO8Rc7Wr7nW8Va44MayMGC7y2uTM/pbtojra2S9z6w+UnwuNd4i9E9C+8nj7cdfAKM+OXf/zw+QE2eYdXoI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729592797; c=relaxed/simple;
	bh=x6ob/7J62UsPZLxME/tDmen439VQgzbCmn80bpQc58w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jzd3pF7vBMNk0YWBcQQB8v9noucVZpEnzkAGhvq8Ss8LD3O0UbEWYgGOz4p5u90K/pnffDL6uTdmQRkLMLT3bgsO4bodBRKaj3vP99RiQtKTePrV9z5FEe6XbJCsYbND4ZtFuHTyS0brL8kZkzJQwTnaG2w/OBm2agM8Sk3lF6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=M/l+RQjc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=abZMl2C7; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49M7tg4R011337;
	Tue, 22 Oct 2024 10:25:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=ERhKoConSGBBQF+IPs
	GcGQVQEAz9j9Yw7D9l46CQznE=; b=M/l+RQjcKOacOVWJQ5sZXlRviRJNCpMXQ8
	57YLkCZuBy4Hdj1wECgjN/5J+nP09mg24vlnnaADHONPSbKUtpeV1aeT6kQjK9Pj
	0Lw49LjSBMRB2VVVT9JrYbY3chdUEYn6svV1zXEirK60Q6IWzPaPxdDG469tHT3A
	g6dT53YS7Z4xq+3MQN+07T8aEAGQgPoW8+h8xFs6vACFzQA92YFGCPtj410DIH8n
	i5amXY3ZcRPLzTlKBFKVf9meJt1pc1Rmusg0sRWwrnFyUDDzybnFUT+SzQfJGPOv
	YkE+auFKA9TEyA2gbm8h3XYpeA9cEOpuMafSmMPK3frRIXU27kzQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c545590r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Oct 2024 10:25:20 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49M9vwmY023530;
	Tue, 22 Oct 2024 10:25:19 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42c8evbgvk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Oct 2024 10:25:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sodV97MeHmmsuSZQ+YZUcHj1LfPs8E/7dZ2A7NBCj3CgNIoJs4wHx/drSh1C2BIf5Ctioidr3KDPEtM4sj0tLg77ElxlH3LAKV27BEXO0zg1gjhCW2DCn7SyCoszKfsuj6p0CoadqXe1VrgbfXa6IE5Rh0UrayZqzhhgesD4aJqqFCUqM4f/wh96E6JReiHyQnd22Q63JpnKv1FGeaQOJieXGFvMX6bgL+VUE3qVFekRfvk5QWnp8UqbnPwzl25LNthZ6Ski4lF817zLn2ciFO6c8N7ujciLa12b+m8k/8gXKj2zlAnykASCIlC04xkxMLZgl1WwYMgt15LCGon9bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ERhKoConSGBBQF+IPsGcGQVQEAz9j9Yw7D9l46CQznE=;
 b=f073WGho5gm2ozpZdOv77GLPzsQQ9CZyZFte7VjagY3cg6gVmEwOjOiNrdZi0ye2d/AStZN8vlj/rQ8yyMZND7hxrlTSV+gN5c6oXWYpjs3h/jWiGVssheTqtIylvFxttlIaV+ec5juvVv4OhiP+xgmDJV1habEKI76oQu+KmwjBy6fkvwxik6dAp0zEzIS9NrO/b7hXO6lIxt+6JNjRmX8DrcnAfjXAtlcIuF5pNrTCU1GHGy1h6x1faWMaap6FEuVUNmVSp2B4u3p7XK/BpGLpU/pbvz/F5R1g4Yz/wD5AHr0r8mvQ+GmAMnnaR6IHDncMRnrcOs2jAfNEUEw/7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ERhKoConSGBBQF+IPsGcGQVQEAz9j9Yw7D9l46CQznE=;
 b=abZMl2C7mxckZKI+YUZqIOvMW4BsCquSTgic/kpNTd1mKr+AiHzqZaznAr0qIYWSDEh2RXETpGxsxViceQZ83aeeR1UMtnzVDHT2zAvhL5oi3mdxs6+IU/js9cVbeWh//dlF9r6ynRFY3kC8vlANnvCb+NIs1ntDoq7lHGCX6Vs=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by BY5PR10MB4356.namprd10.prod.outlook.com (2603:10b6:a03:210::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Tue, 22 Oct
 2024 10:25:17 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8069.024; Tue, 22 Oct 2024
 10:25:17 +0000
Date: Tue, 22 Oct 2024 11:25:11 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
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
Subject: Re: [PATCH v2 5/5] selftests/mm: add self tests for guard page
 feature
Message-ID: <9032e483-0e8c-4cff-a5a3-c329899829df@lucifer.local>
References: <cover.1729440856.git.lorenzo.stoakes@oracle.com>
 <090ed13db09bc25863a78eba902d8bf2c6534ced.1729440856.git.lorenzo.stoakes@oracle.com>
 <360241aa-49ec-42b1-99c9-759a9a0873a0@linuxfoundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <360241aa-49ec-42b1-99c9-759a9a0873a0@linuxfoundation.org>
X-ClientProxiedBy: LO4P123CA0405.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:189::14) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|BY5PR10MB4356:EE_
X-MS-Office365-Filtering-Correlation-Id: 8470c6ca-6ffa-4036-c373-08dcf283d280
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kHkZOLz3LT0STmDUkxK+xzfTda4chhCp0qDm07mI3eUgLdD3uJbAgrl5YV3k?=
 =?us-ascii?Q?NVztTUlnCE56rrHcXn1uXrMdCvBCvV9oFuBqaqYazrp9xOkjhB4EYOOt6xZo?=
 =?us-ascii?Q?zYu1xfhLkJXn1fKd1R4awP18a4Zk6SedQfQ6+3wA3PhUcODO6xZVxHtX1xqj?=
 =?us-ascii?Q?f4xxcUa7wtYMwnoNQ12+OXB9DAjHGTjc7DztVCroQaXm73CJG4kPn4XXXsiN?=
 =?us-ascii?Q?I5ywJoV/IaRbPJhqMesfNVzvfQ/bDgytzd4WJg+mrkX2vBg4oZsP9zhWszF0?=
 =?us-ascii?Q?sfQah9WUcCC6kYyH//1KSFSdlAQJBoa38daHV2eVZxx9ofQIZMyOQ9zXXeuu?=
 =?us-ascii?Q?giK4YSwmunLwf/gRx3zlfzxx1LT3ad2uQbQsX2p2lsO7OymOLaF4FZELJ7z/?=
 =?us-ascii?Q?cq6acwDNl0oNGREmk7PtGbkkevOYq5+i3Yf8WQXqe4BwpnO9oooE1R+nfes9?=
 =?us-ascii?Q?LehMXMv+Nv0BxMi9a6Hi227WNzOmvvUGxWiDVkvW+GVDZOPY4Cg3ZrKYSEpi?=
 =?us-ascii?Q?qBJMEcM2JLuo1aTrmHe0I5VmMIHQ0mEOwtMb8kTVLjpEW5z6nvXz9bBhsP2M?=
 =?us-ascii?Q?71xNYRXbdxoQZ6jNY+CuCnCUwKYFo3xqKooXru1iu5SHlCBNw56pDQbXrkZh?=
 =?us-ascii?Q?x0A5R5q8NKZ/ms7b8Wb2CiYJwLSQFJaG54fnpfmi5WiDgGbJbQ2/+/FUD2e2?=
 =?us-ascii?Q?uKKaLS1+jxdWlDhC2RwdKdXsqLYjHV/aLAf9blqBA7FSkOWK3g7uaYgP4xAp?=
 =?us-ascii?Q?5UFXOA4i0NRf36KEmVnuu6eBzS+3WHPZ2aOb5vl/hEZjn/dK7EVcfu42tl1q?=
 =?us-ascii?Q?K7xjdPHsARTZRgT892H8bDszJKQt4OfgF0aotOuAZoWVmUnFeAy1F3dplQLF?=
 =?us-ascii?Q?eXQdzsbyF5cr/YY/deK4D15ABqQBcokT+GMrdGdoLKc6W60ZWQ2baXZ/doek?=
 =?us-ascii?Q?N9qSZE8TrvnlTLH7YEtdbMlQNVqhSNPI6Njrbaiz+f1K9nAzORh0n5FhjFz3?=
 =?us-ascii?Q?YtprV76fYKFwAWX2LyUqstUsarzdAmg7Dhlow76y3chOp8wXUdyPmLYouU4/?=
 =?us-ascii?Q?O8UUJwRCjNllkjuvS/rIshzjkAw5ItkqMtcKBwvYi/huxA3+9awiLSPjILb8?=
 =?us-ascii?Q?lxUgSrjRsMfC/ICAUITbSjwmH8tqANliGYw01QCAMcHShS1uOzGoubAzynGg?=
 =?us-ascii?Q?XDKBcEqaGuPBJUt51nnOiNFp4xxircqx0Vr6LaEow78KVYI+zP6GWeMk7yQH?=
 =?us-ascii?Q?moCvV2HWkqmpe/NzLwlCpymgBvh3EpdoQQYraFhtnHh7/zDZ5OHuzSPEOO+9?=
 =?us-ascii?Q?x1kngLOgWiuBDZ3p8i8i5Fms?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ExoCNxir+0w16+4PqXcn4vRDTDP0eTVTsPwqIl8/dLOLW0ELBfCt7qRXVB6s?=
 =?us-ascii?Q?XbLl0ruWhtUwIMnNaHaioC72H42bRVXwCUNbIWQ3feBNqdDmpC8unPfLKBtb?=
 =?us-ascii?Q?vuIq409hYplI0MO6jgt2w3PBNGwNyi8m/TNR8GxdDnrw91qTekpbTF2Uuwa9?=
 =?us-ascii?Q?KEF3Ry7Ok/J1qPjP3WibNgcrdxn01wI4ppjf1Lw72TfrGQY8b/JpYsDhKDN7?=
 =?us-ascii?Q?gy2VNSd9VW9UND53Y/KWj9UxsVcEiRyyH/McA3pDOeUomgFERGexk4TrWep4?=
 =?us-ascii?Q?H7pVOg/EtgAmPyZLcgpSaBoiwfIf3tY6qeamqoTNTrHRd41pMYmtmyram7eY?=
 =?us-ascii?Q?3EVRpxbrdi+4lqX7hY/7U4YPn5bgJ6teLWSpRk6/uSl05WK1iup9Dos0fHNn?=
 =?us-ascii?Q?/tkXH7RNWtB+YeUKCxcwy1SMGVx7cY9nh/OOImV1+ao/f7eIrAmDHm3YhIsH?=
 =?us-ascii?Q?Lm51eTN5mPXEBwtgoMSwdJugDSjyw/SPTLmC+h6AFp+ZIQ4YA90Pqsq28Twu?=
 =?us-ascii?Q?i6h6hMThQwhJ66IyCkHo+AJ4neSm62I9FiI56/KWOJgJXH9b8RBBkRUdg64T?=
 =?us-ascii?Q?KKT2reJ7sqQFR/30dl/y8N1RAMJNB2BslQxPcGn85oQoI90QB7pTfQHCcZbT?=
 =?us-ascii?Q?rmfKZx2rzdfmwXIPpPWG8vA7p73ckSUDTFByXFhvSM+qayDFThpMBYOGCKx3?=
 =?us-ascii?Q?ycxmco4EKV6/2kpByzq1Nfakn5Y/rk/RKtBl6HMGb2C1S1auUu721BuQpV4B?=
 =?us-ascii?Q?T4cifTRARl+UyyYAvjuwAPNpPHKyciUe60Cq/fQalqSppXzJPNL7/zjMReZ5?=
 =?us-ascii?Q?+qddo1rV1txPMHdtCxAdznT6Bv0SdDXU6G22vy43Nji+SO3I+cIb6INUPZwj?=
 =?us-ascii?Q?UU97djrPAkHGUWomIw4cCST8GAtKRlovqrSptuMyJol/IJRvzLWfYvCur4yN?=
 =?us-ascii?Q?4an2fnnMWNxQZTQ8czw45kD5i5hMdXZK05Xf2BI7BsT65iZPjmWD0eStwT8P?=
 =?us-ascii?Q?HVqSnTvJPbv/DONH0r4SbZGAziQ77VvWzFPa1hq3eSzrM1Ph0IDEgS13SKRV?=
 =?us-ascii?Q?t94kOz1zB951lllsk6gWcBONfVkwhsVycuTk2rO+2b4BqiM0dYEXX21hMU3L?=
 =?us-ascii?Q?xBqQ9hUWFzWzamiQ1+/2KU/cc4LxCmFAGBLy6LJaO1Fwb5GMDdBWYO5gOocN?=
 =?us-ascii?Q?8Qwjdw0WWoHMf06BQwNQRnDjmk9oOln1ps/+PvWQ09va5D8KNfmEkpwXnT9V?=
 =?us-ascii?Q?NBP66Z70/abtru64+SdsMku8CLc/7cVPvJ2jifMX1OtY/gopYk6EIrY/0/SF?=
 =?us-ascii?Q?TLHcVleoyXtv0qIldkYvXZI/J+HgUZepdtm6TaO6OLAWTo/YqI6f/X4w957k?=
 =?us-ascii?Q?BtCg7v+2WuSKWcuLLOtAnlTnu3vlAqdU2++DZ7miKNA0hUkRaWLMls79QPSG?=
 =?us-ascii?Q?7nuzCRA+G/eItTL4PKKhp+y+kmCtJXeaP/Humm45dNBmnIvqrxU6cbSEN59D?=
 =?us-ascii?Q?tDl+vlTOmUJgpbMHpLDKhsPO4ZjCM8O4Rc+pV5hXzND0JBKRU78jVHYJ01CS?=
 =?us-ascii?Q?WkY5VhEYM+0XQgcOd1uOTq40rwWQ/A6hst+DOO+h8JVOGQJ4mOmuN0p9uD9z?=
 =?us-ascii?Q?y3s4iAxCG7TzxSA0nJDu2RzKL/w6Wqnx+tMZ34uqRiKLJW3QtvpBhz8fhvx0?=
 =?us-ascii?Q?MCOPjQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tlQ0bSLRR1cWk/ApUZZSNhdk/BrmiOW3GvCCQiRE/eTZLokGNFpBqIOtpwOGO/bJZVy1BcoBbowQbvpNpgobYlSVR4aktBBNwgbtVjf55sEHD9YVNo253Ohj2iG/cU1N9BAS8Y7pnNKvlun+z1+kTPD2tzlsGJ/u0dp3lpVg1puilD8nuxXckQ6w2xXoHeka6qedVkdMXvgJindHLATlRfk2qRhEy2txWs96DO0ZstTpDSUoVrGMCTenXENKj7fsK980vv0nS3emP2juY0d6msGB70mzwnWlcB1pkxNPunPg0KQX2A14kTJD/7elzZdxo3j7zjLbh2+02QQ30n3WRmAwpZEomRavIF0WBT8ytqBHxxP8E4g6X5IVSBULlYcOrda9Knd7RT0wpKvqjD8wo14lq3yWEL+5QJlliMjFMDbh7nvJwt1Xt4AhYMqz2c+6XANKSPYtzEBhiosk0DZU0sdD3QyYPwJbnfVLXLxATnvt8ygWnchXOyRjU7kmm1PakhbRLgLkVySCtQlvM7mmGUBBHIX+rgVIw9xelKeEufN7JHw06te5GAEMhNg6OrsnK5AqZsbzXCtASUzLlk0mmxIXXhMI8AlNc0xosHYf8IQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8470c6ca-6ffa-4036-c373-08dcf283d280
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 10:25:17.0734
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HGYNJzhfqRUYYfC7+TEK898NzFLtGv6Nf6vThdRjK5PVYAixC33j5WeE/0ZS3apxmT1gw3RaZ/DfTea3dyJCV42QNNTen69CONLTvz1YN4E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4356
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-22_10,2024-10-21_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410220067
X-Proofpoint-ORIG-GUID: -tQCqXWNLrA6jRq-BFd8FdInv0bgvmji
X-Proofpoint-GUID: -tQCqXWNLrA6jRq-BFd8FdInv0bgvmji

On Mon, Oct 21, 2024 at 03:31:59PM -0600, Shuah Khan wrote:
> On 10/20/24 10:20, Lorenzo Stoakes wrote:
> > Utilise the kselftest harmness to implement tests for the guard page
> > implementation.
> >
> > We start by implement basic tests asserting that guard pages can be
> > established (poisoned), cleared (remedied) and that touching poisoned pages
> > result in SIGSEGV. We also assert that, in remedying a range, non-poison
> > pages remain intact.
> >
> > We then examine different operations on regions containing poison markers
> > behave to ensure correct behaviour:
> >
> > * Operations over multiple VMAs operate as expected.
> > * Invoking MADV_GUARD_POISION / MADV_GUARD_REMEDY via process_madvise() in
> >    batches works correctly.
> > * Ensuring that munmap() correctly tears down poison markers.
> > * Using mprotect() to adjust protection bits does not in any way override
> >    or cause issues with poison markers.
> > * Ensuring that splitting and merging VMAs around poison markers causes no
> >    issue - i.e. that a marker which 'belongs' to one VMA can function just
> >    as well 'belonging' to another.
> > * Ensuring that madvise(..., MADV_DONTNEED) does not remove poison markers.
> > * Ensuring that mlock()'ing a range containing poison markers does not
> >    cause issues.
> > * Ensuring that mremap() can move a poisoned range and retain poison
> >    markers.
> > * Ensuring that mremap() can expand a poisoned range and retain poison
> >    markers (perhaps moving the range).
> > * Ensuring that mremap() can shrink a poisoned range and retain poison
> >    markers.
> > * Ensuring that forking a process correctly retains poison markers.
> > * Ensuring that forking a VMA with VM_WIPEONFORK set behaves sanely.
> > * Ensuring that lazyfree simply clears poison markers.
> > * Ensuring that userfaultfd can co-exist with guard pages.
> > * Ensuring that madvise(..., MADV_POPULATE_READ) and
> >    madvise(..., MADV_POPULATE_WRITE) error out when encountering
> >    poison markers.
> > * Ensuring that madvise(..., MADV_COLD) and madvise(..., MADV_PAGEOUT) do
> >    not remove poison markers.
> >
> > If any test is unable to be run due to lack of permissions, that test is
> > skipped.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > ---
> >   tools/testing/selftests/mm/.gitignore    |    1 +
> >   tools/testing/selftests/mm/Makefile      |    1 +
> >   tools/testing/selftests/mm/guard-pages.c | 1228 ++++++++++++++++++++++
> >   3 files changed, 1230 insertions(+)
> >   create mode 100644 tools/testing/selftests/mm/guard-pages.c
> >
> > diff --git a/tools/testing/selftests/mm/.gitignore b/tools/testing/selftests/mm/.gitignore
> > index 689bbd520296..8f01f4da1c0d 100644
> > --- a/tools/testing/selftests/mm/.gitignore
> > +++ b/tools/testing/selftests/mm/.gitignore
> > @@ -54,3 +54,4 @@ droppable
> >   hugetlb_dio
> >   pkey_sighandler_tests_32
> >   pkey_sighandler_tests_64
> > +guard-pages
> > diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
> > index 02e1204971b0..15c734d6cfec 100644
> > --- a/tools/testing/selftests/mm/Makefile
> > +++ b/tools/testing/selftests/mm/Makefile
> > @@ -79,6 +79,7 @@ TEST_GEN_FILES += hugetlb_fault_after_madv
> >   TEST_GEN_FILES += hugetlb_madv_vs_map
> >   TEST_GEN_FILES += hugetlb_dio
> >   TEST_GEN_FILES += droppable
> > +TEST_GEN_FILES += guard-pages
> >   ifneq ($(ARCH),arm64)
> >   TEST_GEN_FILES += soft-dirty
> > diff --git a/tools/testing/selftests/mm/guard-pages.c b/tools/testing/selftests/mm/guard-pages.c
> > new file mode 100644
> > index 000000000000..f67d2700d44a
> > --- /dev/null
> > +++ b/tools/testing/selftests/mm/guard-pages.c
> > @@ -0,0 +1,1228 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +
> > +#define _GNU_SOURCE
> > +#include "../kselftest_harness.h"
> > +#include <asm-generic/mman.h> /* Force the import of the tools version. */
> > +#include <assert.h>
> > +#include <errno.h>
> > +#include <fcntl.h>
> > +#include <linux/userfaultfd.h>
> > +#include <setjmp.h>
> > +#include <signal.h>
> > +#include <stdbool.h>
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include <string.h>
> > +#include <sys/ioctl.h>
> > +#include <sys/mman.h>
> > +#include <sys/syscall.h>
> > +#include <sys/uio.h>
> > +#include <unistd.h>
> > +
> > +/*
> > + * Ignore the checkpatch warning, as per the C99 standard, section 7.14.1.1:
> > + *
> > + * "If the signal occurs other than as the result of calling the abort or raise
> > + *  function, the behavior is undefined if the signal handler refers to any
> > + *  object with static storage duration other than by assigning a value to an
> > + *  object declared as volatile sig_atomic_t"
> > + */
> > +static volatile sig_atomic_t signal_jump_set;
> > +static sigjmp_buf signal_jmp_buf;
> > +
> > +/*
> > + * Ignore the checkpatch warning, we must read from x but don't want to do
> > + * anything with it in order to trigger a read page fault. We therefore must use
> > + * volatile to stop the compiler from optimising this away.
> > + */
> > +#define FORCE_READ(x) (*(volatile typeof(x) *)x)
> > +
>
> Thank you.
>
> Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

Thanks! :)

>
> thanks,
> -- Shuah
>

