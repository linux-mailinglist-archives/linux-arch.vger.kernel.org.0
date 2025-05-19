Return-Path: <linux-arch+bounces-12000-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24CE1ABC8B6
	for <lists+linux-arch@lfdr.de>; Mon, 19 May 2025 22:55:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FED74A349D
	for <lists+linux-arch@lfdr.de>; Mon, 19 May 2025 20:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A3E21CC4A;
	Mon, 19 May 2025 20:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HZyYEfaP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZtFvMbcI"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3B021C9E7;
	Mon, 19 May 2025 20:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747688024; cv=fail; b=MGDegQfDvlcpnOvykqf3C94+K7QvsOm8puniYcorjy1AcSjn3ITAkcjC3/g5lj/F2og4tlAlqneC2BsYBrlx7/fhC2uH9A8VLWm2mc0bYbkYgs+6vdCiYktvwrSv4r0tOPfrYImsfin4eUI4cgT6NxO8QGVrjm2Rbp8HeX72qwE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747688024; c=relaxed/simple;
	bh=YDuoJX2oLUeiubdHjokiglM5GOl3xvQvt3biVT6mG8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PCZ8FU7M8shOHEh5XuhsJFBo0aEAQrcs5CvUw1w1VkYgUTY+mrXrELfcZwTp8SvpnKfmtIq9oVdL6pnG1YNEVPcx6QiPQcPsCOmWuHYRUdIqUiZiNjawPNiniEL7e54jFQ5NcmpaBw04CEmqEm+6pajNz/ywc+cHp8/BcYBH+mk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HZyYEfaP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZtFvMbcI; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54JGMp7M024635;
	Mon, 19 May 2025 20:53:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=/wuNo8wI0kyIUxjvVWuG54+mJye/M5HbQEt106WDJ6E=; b=
	HZyYEfaPttlZyKM8yjhKFB+Tn8OfgM8rGwUx1iiVP5rpcjCeSHpD1PCDb9LCpQPj
	8CidJzQqVgi2wLWSH5sKEgS27E/Q05dHOiFS6iP5s4BAWsHTMyvk/zXz0rDbartQ
	SGzVf5WuhXQe4RyNIka64sNuexHdIuXUGtCYB30+hRjl9TsfLljMIAxh4j71lMit
	UzjKyjGS89aFq8qVuubW6SXBWsF9DqS/PdqG9+IwqL+VZ5cylJN+2LWeUsptmDoU
	O7NbeglcjAeT7bE9mnUIcHyfAsRPTfVNnEw5r7B6kpeqgMgi45QGGXawqHTQEIF6
	2FxU3YnWqDZ/Y/si8oI1KQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46pgvekyc4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 May 2025 20:53:25 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54JItVHH017346;
	Mon, 19 May 2025 20:53:24 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2042.outbound.protection.outlook.com [104.47.70.42])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46pgw7e3p7-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 May 2025 20:53:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nFvcu5gQg/9wxF2/78AIbobNBIwhSx1LXik2k+GFfEZmcKbuRKlYcNnXFLKGkFIA+xhJIbvYTOLb4IywIXGlbT8jYYxOtx5po0d2SylqVTg72OfdFDiyKIzmUQqU7vmnONw2++wXo3wQyqKTVKgvJCeT3uuHV/v+LOAKsvcU6XZPDOjHSr/cI68usF1X9kV+DkvrB/4qcpD9QzHIOMFusfo0OGUbQt9sCdkdewXlwErG+YYQ44Hudz0X1EOD0xIkesPPqOvQ/SIll+vyf5fi2hETKD5XhnU9R3ScRAw3IQbfsw4dwTgZCzkI3MifXsjqEXq3DsHIChYE3tCJHuoKCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/wuNo8wI0kyIUxjvVWuG54+mJye/M5HbQEt106WDJ6E=;
 b=ep0F4xx1ni49tS1L/h86MXGvZ6jwi98nIwYfHm+ekqwBAgRfAT+2sL15oxtMtJbyGqA8kNnu+YX32lK0RHo4eeaus2jIz1JDiKFxEHr7hiKtu+gX9s7LbHbK9yCw6pWFDFckbeRxvKlYdhcfAHdOmfX/wJT06UnfoXyQeuNSmXQaSgzyJ88TGECiBLkxPnv7wFegS3bhOk+8SVxxqImnKt7lGALGd+kQctthW1SjxAWhtMyA9h6aNPBuq42Xw8b3RYXbjVpE9+BQ502p+AEeT9t9e1kN2W00nY8U0K0pZhG+cTEJxDHzQwqa9d2h7e4LMdhmFaGvoBwtDSpxWsydBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/wuNo8wI0kyIUxjvVWuG54+mJye/M5HbQEt106WDJ6E=;
 b=ZtFvMbcIrezUxCo+WnjfHNYn2DuDeiPdgXjFel/JhZ7NnvZ8FNhdE1pwnMA5F5jeesDysMLDi10pSpTPOpV0mgATu8akQ0yDM8YCz1xrnwN1yR63cRbq+lYGJ84dK24kCKYhz6lreegZ2vhZuyrnxgH7VsY9VOwaWSvod4KWkgk=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ5PPF4B2F62DBB.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::79d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Mon, 19 May
 2025 20:53:12 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8746.030; Mon, 19 May 2025
 20:53:12 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>,
        Jann Horn <jannh@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <brauner@kernel.org>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sj@kernel.org>, Usama Arif <usamaarif642@gmail.com>
Subject: [RFC PATCH 5/5] mm/madvise: add PMADV_ENTIRE_ADDRESS_SPACE process_madvise() flag
Date: Mon, 19 May 2025 21:52:42 +0100
Message-ID: <fac0bdb1cf9d19ef818a7c4a470ac000e2e62dc1.1747686021.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1747686021.git.lorenzo.stoakes@oracle.com>
References: <cover.1747686021.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0214.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:33a::9) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ5PPF4B2F62DBB:EE_
X-MS-Office365-Filtering-Correlation-Id: b6e7033c-f475-4de4-6ee3-08dd97172b13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?J7mgkwbPn/j+hQj/Qb5dQPMKthP+wC7k3TbCKZvEilVIFaTdMMTANciHGbgj?=
 =?us-ascii?Q?mrNlBfamuHOvTRv0NoCs0K00om68F1ZMOw5Vqqgq8c3qbbms8suUCM3YnQrx?=
 =?us-ascii?Q?er9I49sst3OS3FpVbbB3oBRHx6KW9ObId4wmQ8ADsC0x6mpLaT7W9jr0yijv?=
 =?us-ascii?Q?5/a+79gSGCXvmsGoc/4K+eS7+pG0N9ajIcWd6ikRhV63flAlWa4q2mBORy8W?=
 =?us-ascii?Q?cl5x/EVQHYwNSJ3istXGccvGtsZZ/AhZ0hJr0gI65ubDpUgszi4HkyKIhHoj?=
 =?us-ascii?Q?AmMoE8+qawbqv2xNZ1+dtYq3cnUfj9/Rve1NBYN2KVUqrrT7qvTVTQUrEZn5?=
 =?us-ascii?Q?O3PJXxDXbBhwHyLuOOBtB0A89xRaRrGXsB1Wz4s84VV8AZptqZ5ihU9jhXd9?=
 =?us-ascii?Q?v+Ro+8GTbTViZS5l5VYlovRcmkFRr1tSH3I+fKozkC3X1Bq9+fjGQLgquFyG?=
 =?us-ascii?Q?2HbjYYRDQuDuYixAd6d4s2+qPyUjFQM+2povBwRPyhp+jx6dSrraWAW2yyat?=
 =?us-ascii?Q?fsN9OTvfuyMcqpO9/u5y09n4WmlrPbILEcdbW7DXSc2bxcmi2SDkKmkTmbig?=
 =?us-ascii?Q?T0cknpT/IDWdiw/60rgx1EziuZ9i1J3a5OLufU1LhA4IFESJXxdQplHPhMzb?=
 =?us-ascii?Q?H0sS2HCKKlUnmHOjt2k9oQTODb4eZyhodf5bDvm7Ua5RPoPMZ5Ohff4VM24o?=
 =?us-ascii?Q?ONZaGkTb8YsucBtEmGn5Rb2/elDYmUtgkymT7P7spTTG9EPq8vb8kC4VkXz5?=
 =?us-ascii?Q?A/txBUAv8MoOJ3kxENFW+2+sja02bq+gAru5ZHfcqVM8bMdTP2qXgdL52olC?=
 =?us-ascii?Q?FvHAZLToT3n2uFV9dpgMFrqVsUmRgklLYWiF2tFd/ibmbkybc4davbftrZVR?=
 =?us-ascii?Q?F4wc42PKfgqXjKDib7+aZl1y2mcKs1g7UoKHWGA5zx0xdBmposoOQOKD71s5?=
 =?us-ascii?Q?9PzkK8fg4kJsUsUKDpxvBt1EDtpmmNep9iyqEEaPrZvgTHvtw1xZtmFDpSR5?=
 =?us-ascii?Q?vUiEKuCoXCOBms+ypcaemMut/Neg3+q/ToRGsbYO3wJCpMtQvBgpQCkqtG46?=
 =?us-ascii?Q?Z0cBkxPplGJPZ8EpbmJ3UZQ84K7KxJdep8H8i9EpRG1cjTTvqMKZN4O68LWv?=
 =?us-ascii?Q?k/0qqzamY1RHBvX4SNOZ6LXO/kC7yxh3yN7MeItUs6kbEcMkirJq35a786q0?=
 =?us-ascii?Q?LFtHKzI18r4z19MpEeTpFgIylDJM34lPJpDiEn0ZiQSF6sTUXNoNqh9R9VPd?=
 =?us-ascii?Q?5NlrTsLFHXegKaWZjTk6CiKOCmWHSI+T3m9hvnWlUG3WSXI4GnhXP5Wy9sU4?=
 =?us-ascii?Q?Thgc6hQwen0dmQpNXTbh9IpV79HpkCcUo3WEWEyOu5XMVGW/1gArLAR+HY1F?=
 =?us-ascii?Q?CGy21v7AR7slrkvuVi+G81ZbK2zOa90kFuse1aCg6ugc4KslTiPuSCP2wSJS?=
 =?us-ascii?Q?7w5eAuUSdq0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oFe4luJ5etnQXWhiNF/giIEc9YzQmCt240pm+GGZef/IXTa7FZTU1Xob7TOP?=
 =?us-ascii?Q?TUd5B/3WTqxInEVlld4u2SUzMZVsiwfYa+sAvwPK399oO6I4msYSLV91q/pQ?=
 =?us-ascii?Q?ZD6b+6qDqFx7s3XIOWpdYhhAtgeNpo+frVfiU7S4Mpe/2oxa6HdXDpO3VOSH?=
 =?us-ascii?Q?E/Zzr6FoC5tDGahrW/osL0MqSs5sVbk04DwVS/eBQO1+yCdaY73Zz1h3Z6TJ?=
 =?us-ascii?Q?/Awtz06KC8EXM+bidJ1lN6WSbH66MI8M8vzPrsZGMUb06V7COo3aZFx/0EkQ?=
 =?us-ascii?Q?whG5+f4PLs4Hk9mWPQUCZixpo13De1fhS67QCN2jeqKDz7XeXLffbKtV6pkZ?=
 =?us-ascii?Q?Nli18q1BIHIwLYKPVPtoSm4bIy0NyNAA9kC+j1gRy0+d9i5oTrm7+ZcS7kx6?=
 =?us-ascii?Q?URYtWDGONuRnu/v7IVjAG9+qE7BeUegiLD5c3oi1lWfYBq6E2jTkKeMYHwEj?=
 =?us-ascii?Q?1kyuh5E+xJsLiRKw1Dk+zDNehtTeVbMfE5qlfcwvUdFAnhCFJ4GtbHIv+/e7?=
 =?us-ascii?Q?ky59NOp33Vf/q4Qoo2ZZbftqUn+nPgpeSmwClEMe4EBVPwHJ/UNrCYTh7Bap?=
 =?us-ascii?Q?uXWCoqC5Eku6SwtyiUcbjSqgvu5di+pQB1JkauEUFsCmGK+uS9+AkuPhRDWY?=
 =?us-ascii?Q?jVCWneVE7INGfqieaMiJpAy/7DAJPv9DCbWYdA5fhM0dCOl730eCYa4eHDic?=
 =?us-ascii?Q?/WEBuJfAPbw/RklLVKPvhL5opGwNBbxq3D7i9iu2SypxK0mlIaqW78g5YZvV?=
 =?us-ascii?Q?wRGTj54nqKxMgGLfzxIuJJsYt8mD3GFLdR6nPKtK8Bdti86R7bnZ49hlOFrf?=
 =?us-ascii?Q?I9+VDE76FcmFMHkXLFFbLtfVsS6e4IMGJ6WFGSQNR6mz5x1NYxh/smOLLNWm?=
 =?us-ascii?Q?bvoSK34TRazWty0r5GKjM9pJ4lG+BXbg+9KsPBbRtdrUUcaa4sb8r98Yvqqf?=
 =?us-ascii?Q?1gZf3Xn1Mpq9DTS8o17e04QBglyjfIxfZCHMlI6fW+HWKURGUTTXKeTUJqEx?=
 =?us-ascii?Q?WuMRFcVwKmEul5f8Pu5Rys5UUHUF6k82Wf4BoTb404AWD8r5rjmeiJGH3/Y4?=
 =?us-ascii?Q?6JJ2KC/WDARaOtuZi7TM7XUugBSLiBbEofvYexQF/G/C7DzVV1zP8FfdarFE?=
 =?us-ascii?Q?9+iCchOoUbM3Vnxqs+0gOmWqLywJhcqGn+Jk3MgEDuGja3L7V2ny+k/NTS/j?=
 =?us-ascii?Q?h951q3n0sKb4yIti6/9Mn8C/JjmvIsZZlggRd2aAdJBjX2GPXIvZ8FO2Ecom?=
 =?us-ascii?Q?iV3xj4o/dqnqQWl6J5RabbobLhZguqyAWgKDtSJDjijukcxVjH209WnOzYdm?=
 =?us-ascii?Q?dkasTV+cvLmy3GePHpKsdx8Gdp+zmvQX7GHTcfC84L7i6YYdSiYWRLIm58Av?=
 =?us-ascii?Q?AfNDrPrS9J1+t66Wak7fNG8Vbh9zceIcmiMJmYmDJi0gvh+a/bj6AS4kOlq/?=
 =?us-ascii?Q?zRMHjNbWlnMf5AgvVlP5I57Hq2anRE5pjaYFxZ48kj2QmVxOhNoe6Ux77qp6?=
 =?us-ascii?Q?0Y4fnHuze+R5bb8grRV45kZMefEBQ+VHF8TS9yUdi6y3wLREeFL95leFQEkd?=
 =?us-ascii?Q?G/miXF48zCHALIuSLIBfEqqxOEnU0h6ShIckS2HOcMOl5uKU5zdLYhMVeMdB?=
 =?us-ascii?Q?Hw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bNg6hEinlHmStw+lXwDi7IIZFHkMc18zwZ/XbonwzjWbKz6PXPlE0BUAkDjqacjA4iqX3z9LmhF7/aDmL7uoTA7LDeHnwdHckXqNKSxg38gv/4yGzVb0A70/52dTDKOCOgDCN1NfdWFxRgwKxUlACJ9Px8RWG3uOmi5RvZFd0FeIhyAJ7ZmLER0GWkQprAVDdtFESnR55kX7FKG3c6ZF/oLcveu4eGoey827PlDzDkJhsSKVQZDeHGQK7oXO7C/51oHeqvGu2W5JJV1QhzrRATv5HKSCPAaaL8P2pzLJfb5zbWPYRBJrOyrCyJaAmNwEylmHqUpNNr70dXWEtF8Gt4GN8M91fmQFjt1pK1jYSOH0hhLVRIHPgndywcJlIqe1k+nRZD2LWtaFn9igw8ZNlkO8VKXkDmuduzeA4I2cj8Y9qllZXTOsqqKw8DWOJPpm2uou94fDqPpbCMCZ6ZN8HY5sTfO9nUa9O7RCGZJPn4twik1SJz5TZ3B7UHvf9b+NUMaNgXnonClHHAberoP4bfTwGeOeRt5K9I6udX0goIW0Yk8CZOiOOb8bRgRab4AfW27lrBwkuZf/6JugQqNLSXwkxoEbGDwnHtf2CzO+N3k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6e7033c-f475-4de4-6ee3-08dd97172b13
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 20:53:12.0162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xiGqetPQpSkNeiTlyXzLsfZadQL9sl/GnYq0EqleGUuW/hqdiEdEfvVVQIgu5pcvr2tp6cUaV4HvBEot50nYNPbbSBo76ixS5MeGiQPgTMM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF4B2F62DBB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-19_08,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 spamscore=0
 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505070000
 definitions=main-2505190194
X-Proofpoint-GUID: QJFe-F71hEnVnIiS_RiyVkdq6vBoVKu1
X-Authority-Analysis: v=2.4 cv=JJk7s9Kb c=1 sm=1 tr=0 ts=682b9a45 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=fbqJCjwplNoI79WyuVMA:9 cc=ntf awl=host:13185
X-Proofpoint-ORIG-GUID: QJFe-F71hEnVnIiS_RiyVkdq6vBoVKu1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDE5MyBTYWx0ZWRfX8WsbiXjDKV1y E282bXIkFtmKxuDa2MPbnjpnlPrqOUQzQ77+cYfYsVmUPPH4MHk8h5RSEUw+zQRDS6l79vgOZOK VBhRcVZqM6js9wEDzllLb2K0i9oyn4L6Y6N21Cu1/ih30PkAqeoMRv430SbgfvKi3XF8wHl3WvG
 hoInAil9jmswkF3PwjHYJlIlhuZubi873Op26hjtAeshtsZSmxuf1aLHmxmRCj0c5IGd19Fm5+u hbHRx/NfjOgGoei1woqA484lWomdnvBLmGeP1xlVdtB8udsAq4gNic6/tk+o3r7Kmj+eYU6a/o6 AxYzvyV0ZfTiA/rkjhHUYjpofYBlo5o/Gh3vblz++20ZeotxAt9Taaj6gMKFxq0/nP++isNZFWz
 oy5j+8LBzqQUZn5LerhncQ7p33ofy9+tRhMZiPNCxpG3XV07rZUv67fMgt8FVYgE2FrQIyC0

For convenience, add the ability to specify the entire address space to
apply the madvise() flag to.

This is best used with PMADV_SKIP_ERRORS (this implies
PMADV_NO_ERROR_ON_UNMAPPED) to skip over any VMAs to which the flags do not
apply.

When this flag is specified, the input vec and vlen parameters must be set
to NULL and -1 respectively, as the user is requesting to perform the
action on the entire address space, e.g.:

process_madvise(PIDFD_SELF, NULL, -1, MADV_HUGEPAGE,
	PMADV_ENTIRE_ADDRESS_SPACE | PMADV_SKIP_ERRORS);

This can be used in conjunction with PMADV_SET_FORK_EXEC_DEFAULT for the
ability to both apply an madvise() behaviour to all VMAs in the process
address space but also to default set the relevant VMA flags for any new
mappings, e.g.:

process_madvise(PIDFD_SELF, NULL, -1, MADV_HUGEPAGE,
	PMADV_ENTIRE_ADDRESS_SPACE | PMADV_SKIP_ERRORS |
	PMADV_SET_FORK_EXEC_DEFAULT);

Which can be useful for ensuring that the flag in question is consistently
applied everywhere.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/uapi/asm-generic/mman-common.h |  1 +
 mm/madvise.c                           | 23 +++++++++++++++++++----
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
index 6998ea0ecc6d..3d523db2f100 100644
--- a/include/uapi/asm-generic/mman-common.h
+++ b/include/uapi/asm-generic/mman-common.h
@@ -95,5 +95,6 @@
 #define PMADV_SKIP_ERRORS (1U << 0) /* Skip VMAs on errors, but carry on. Implies no error on unmapped. */
 #define PMADV_NO_ERROR_ON_UNMAPPED (1U << 1) /* Never report an error on unmapped ranges. */
 #define PMADV_SET_FORK_EXEC_DEFAULT (1U << 2) /* Set the behavior as a default that survives fork/exec. */
+#define PMADV_ENTIRE_ADDRESS_SPACE (1U << 3) /* Ignore input iovec and apply to entire address space. */
 
 #endif /* __ASM_GENERIC_MMAN_COMMON_H */
diff --git a/mm/madvise.c b/mm/madvise.c
index 9ea36800de3c..0fb8cd7fdc7a 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1992,7 +1992,7 @@ static ssize_t vector_madvise(struct mm_struct *mm, struct iov_iter *iter,
 static bool check_process_madvise_flags(unsigned int flags)
 {
 	unsigned int mask = PMADV_SKIP_ERRORS | PMADV_NO_ERROR_ON_UNMAPPED |
-		PMADV_SET_FORK_EXEC_DEFAULT;
+		PMADV_SET_FORK_EXEC_DEFAULT | PMADV_ENTIRE_ADDRESS_SPACE;
 
 	if (flags & ~mask)
 		return false;
@@ -2010,15 +2010,30 @@ SYSCALL_DEFINE5(process_madvise, int, pidfd, const struct iovec __user *, vec,
 	struct task_struct *task;
 	struct mm_struct *mm;
 	unsigned int f_flags;
+	bool entire_address_space = flags & PMADV_ENTIRE_ADDRESS_SPACE;
 
 	if (!check_process_madvise_flags(flags)) {
 		ret = -EINVAL;
 		goto out;
 	}
 
-	ret = import_iovec(ITER_DEST, vec, vlen, ARRAY_SIZE(iovstack), &iov, &iter);
-	if (ret < 0)
-		goto out;
+	if (entire_address_space) {
+		/* The user must specify NULL, -1 vec, vlen parameters. */
+		if (vec != NULL || vlen != (size_t)-1)
+			return -EINVAL;
+
+		/*
+		 * Ignore the input and simply add a single entry spanning the
+		 * whole address space.
+		 */
+		iovstack[0].iov_base = 0;
+		iovstack[0].iov_len = TASK_SIZE_MAX;
+		iov_iter_init(&iter, ITER_DEST, iov, 1, 1);
+	} else {
+		ret = import_iovec(ITER_DEST, vec, vlen, ARRAY_SIZE(iovstack), &iov, &iter);
+		if (ret < 0)
+			goto out;
+	}
 
 	task = pidfd_get_task(pidfd, &f_flags);
 	if (IS_ERR(task)) {
-- 
2.49.0


