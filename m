Return-Path: <linux-arch+bounces-15325-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 92DEACB33F4
	for <lists+linux-arch@lfdr.de>; Wed, 10 Dec 2025 16:04:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9223130B3A38
	for <lists+linux-arch@lfdr.de>; Wed, 10 Dec 2025 15:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55BA2F0C70;
	Wed, 10 Dec 2025 15:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="I/yoZvVC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QSs855ca"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE47E267729
	for <linux-arch@vger.kernel.org>; Wed, 10 Dec 2025 15:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765378989; cv=fail; b=nwjfiKbt4YWew/pzDMXpv6NsTvtiosKPXVgM0JTzGpB/YR9QMuIyb6MNXk9N8nRpmBaOvTUnqY65uc9Gtc5LB1KSR+hJhPszfkRv56TGR+Ebk2mHeGfL+iXD31aFAEQdye9myQ6BV6aY7B6qMg/AEOpH9d9eixHXRCsWMksTPD0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765378989; c=relaxed/simple;
	bh=y7NrnewlqODFxNDm7S2gg2SK1e3Fd6poZLXq80JZZqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qwjt5jergLek4hTHGEyC4UGnzyVlblQ3GRm+XS9FegIuT7GeOOiLyB773tU5Evjs9KXsL/SUgECjPIgpV40a6i4K7vbhSXe+ciQNqNi+5RJ1uIXa67TcRZj8j0noooRbAHzSU8lQo45PSaVj8bRL2DMq4QqXl8qFG6Ifk0GRZNY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=I/yoZvVC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QSs855ca; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BAEKbxw3326377;
	Wed, 10 Dec 2025 15:02:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=0ZbahB5vVdrjjmWnU0
	aVrMnPPGWBrnEV2Ylq8tGw4iE=; b=I/yoZvVCbN00u/BNdCt1D7AcGhs1vAy1Rv
	PMc8LSo8LyFE7ljILLL3eiJ+HdhPTbFE/Z5nu8zDc9EfyWdFzVKRpqPilKB9kHFs
	J1GZ46d5jGcVjPkJQCQw3bAj/F9bMjXzcDV2XyGBaMJb5TnNgQkyt9v1z/41Kom5
	k6RCtrr4rRxh/VquPR91yx5wcW1780AJlK5Fd630Emv0x15bWpDEGuU+s7H9kJS0
	G7q0tzEhz6NtddCqwVUVYf/UFUg3yYv8iyixez+BFt39+zVvA66ULi00B5rh3dLF
	CHp3nvmmK3Cnv9iQ6QPJqAYHsXA6MOnWxX6fWcjzcf0WnGq1TKOQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ayahv82gw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Dec 2025 15:02:12 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BADAw6g017530;
	Wed, 10 Dec 2025 15:02:11 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010001.outbound.protection.outlook.com [52.101.85.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4avaxad85k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Dec 2025 15:02:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mrwHa8VL5nm42K1hR5RYfq+5SW0FkVpEfka9y/xAG7L19eQI54Nh4pmsO4pljuzx+s94g8rifkwwj6Ymc5xDRxSdUaRX300snF215BL2QOoWMFc87oXEq8iSGseQN5pzKoCvtKSuF6mRSWuHPvEQFvJA2tpWEufZUWZ0WDkyCkvL4b+Mn6MRqTZlt6lb3IjsFov6ewTbmMlHGhgZHU52JfTlifd8z7IzGqnyVHRifKBXtyMbdDveCFK2BuqcPSuiwAAbkxDfliHHFHZ9AzjpWi3/VDwl1KR6q/gJD9okpOykGG+R4a+UtxOl37A7kP1RE4R5xRwi2vJLCZE2/dr9vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ZbahB5vVdrjjmWnU0aVrMnPPGWBrnEV2Ylq8tGw4iE=;
 b=F5rCeEmTg0p0bm+YaGM4CY7Mf8+aEclHdBoBFnVH+57r+oxrJiQhuycr07dWrWEk1BVyUrC1YMU8uLXYQhBinz4d3XU9N6ISuil5IrhKoU8BaCAXVliCKWVJmNnbosep+YlY/VGxWtyE/eMPJBprm0t/eAe/baU8dDHvTowxh5NhjU3DahwN3ujEmD63r+C/JTc5V++1s2aNYpKrhcgCp0SZW81MIQIlNKlW3pwBNtlSIP8DNedcBAMJBz1K1YV8alcnFPjQJp8t0V7pzKm/NC0dbe2BtOEpXNttZDs2za3hqkSAIAKf+ZGFq62F3VS8gTsVFiySmvhOK6IUVwbrGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ZbahB5vVdrjjmWnU0aVrMnPPGWBrnEV2Ylq8tGw4iE=;
 b=QSs855catz907yAH+4sNAdwL2Q2PdCk1tRG4r7J1Mc2Yw5V9UodHlHcRX5GyueTP7WGKHDWuvU7KRgq6GRHkhbUoCEeBdU2VgK4Dp4nGWFw3mMmxGHPixjzTW8I0DzyLkNVv5Y2lCpltU8v1RGjZrXncAj11iiZInMjoS1QHiJ8=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CO6PR10MB5791.namprd10.prod.outlook.com (2603:10b6:303:14c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.6; Wed, 10 Dec
 2025 15:02:02 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9412.005; Wed, 10 Dec 2025
 15:02:02 +0000
Date: Wed, 10 Dec 2025 15:02:01 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: kernel test robot <oliver.sang@intel.com>
Cc: David Hildenbrand <david@kernel.org>, oe-lkp@lists.linux.dev,
        lkp@intel.com, Andrew Morton <akpm@linux-foundation.org>,
        suschako@amazon.de, Laurence Oberman <loberman@redhat.com>,
        aneesh.kumar@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Jann Horn <jannh@google.com>, Liam Howlett <liam.howlett@oracle.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Muchun Song <muchun.song@linux.dev>, Nadav Amit <nadav.amit@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        Rik van Riel <riel@surriel.com>, Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>, Lance Yang <lance.yang@linux.dev>,
        linux-arch@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [linux-next:master] [mm/hugetlb]  0e1ad0324a:
 WARNING:at_mm/mmu_gather.c:#tlb_finish_mmu
Message-ID: <3966c02a-ec07-43c4-a230-8453f000a8c4@lucifer.local>
References: <202512102246.ee3d6d07-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202512102246.ee3d6d07-lkp@intel.com>
X-ClientProxiedBy: LO4P123CA0164.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18a::7) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CO6PR10MB5791:EE_
X-MS-Office365-Filtering-Correlation-Id: 72c4fc01-29d7-4b99-b5ae-08de37fd135c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Y7nEuxe4Ya9KwNcUDm3VzVClZVo010r8yi05MljYPjl4enWZ0ekjwITe04ax?=
 =?us-ascii?Q?42MkZoRwK1fGd9RRLcODsj0eDOK/HGgoTIO7RyZ1XTKmjwCuNzflIpqIjFmK?=
 =?us-ascii?Q?ujdM0zLBjb2cqmR63fqlD335fVdnIDhJh1hknKluBdg2Q9tQlicbgQ5gMaS5?=
 =?us-ascii?Q?YNO/RGesYk8S+ckiMxBCvotKQ/6A7oEKuLJ45IBNmTPrvry3VBAzTUhVteWW?=
 =?us-ascii?Q?4UasC37q7Ms8opm6IIBL3PSNKUHmpU4y4LgR8FeppinH8sH47KvDKaMefblR?=
 =?us-ascii?Q?sygUo0VZR7OT/lfZWJekF/GOVWLu7fis6f7a6Dp0YqSLnHqn/6uomj40CPMy?=
 =?us-ascii?Q?NWrSkIIPKeuI6tG4i3rkwOUuoqTa9YMi29WqMHikyx7Rsz8uwQAaglTw2/3j?=
 =?us-ascii?Q?e+PsekxGSbDJ1HEbIK3WcwBpSqgRUXb4y5/W+3UUKUFXvzvT4dbahXboYGwp?=
 =?us-ascii?Q?pW+SURk0b+usu74RHPlb71a/4lptm3PtTGAZ8o6QAdq+AxscKxY1EwlT5QXx?=
 =?us-ascii?Q?iZVNefe+3Ee9LHxSRgpkf54IJdAfmQ4J7PGOwWh/kxmJVWa3Y91+XNDxikFJ?=
 =?us-ascii?Q?+PCGEwjUzn2rBF3Mbt2Ir3/cMTrSZce91kh3Th9aE6FDhZadG1cfp0YNJO6E?=
 =?us-ascii?Q?ihIYwIiGNCsv4Xwel5W05qpiP3HteSg2N91IHfkfwJcjXJmdQvVvwOmcBNkC?=
 =?us-ascii?Q?8+9oqODTzeofbBX6RSn+/ZmGvhWrlKjuNnm4hxGviRPHPL5uwPdFci/gq/k7?=
 =?us-ascii?Q?8cJHBJZjbKQx5yY1Av08SaY0v86wcBLxkPCDFAFSfc+kvnHDQWqJfP326CRY?=
 =?us-ascii?Q?gqjhf3RhaN4smm7xUhZa7yuv80HWUfG5FajUgHly8FjkXv6FIlf/skqhx6fs?=
 =?us-ascii?Q?yos02i3GsgN1Ab6l+4tUhNq4OtxewpJ+dB9tO7HbAJm0H0G+psIgIOEoR2Bb?=
 =?us-ascii?Q?L/6xuzxaSUFuKTLbk65yQS89sDpZlOsa6AVFOx/oPZ3dmVJaMFLGp8M7W97X?=
 =?us-ascii?Q?V4lWZAfoUVCN2/E6N5fiEsYBto640MftlzV0sK+1v3hQutPK5p3NnkPOG/EY?=
 =?us-ascii?Q?58dmJeqOGGr6s80jXFJ754toJrJgeGGkP98mGKlKc8irP+ulHjq/gdNdR9UC?=
 =?us-ascii?Q?urafCAMpGS69FJbn171kMBIQAKIfnESub8k4RPAGJBj5enHVdsA4SmQ7JrCZ?=
 =?us-ascii?Q?/V/n/Gw7cRrlUVJa6yTObT35Q4RYEfuyJUOO8Ogsg0kMAmluKJ9d2W8eTwkw?=
 =?us-ascii?Q?qGdDU1kVd6zOJeiZ5GBgRNgHVQNkr/hRFOj3/fqEmyJnJUWqclW46egehFI0?=
 =?us-ascii?Q?WSxgN8qHhjraedjYOjLmfEPsI7bgTUPyNCbOAvB5fvTlBb7oEdW9+aC++O5F?=
 =?us-ascii?Q?G7BwxEuwpmKw4bIGTEkpPbGqyAj6Rrr+Wccpez4FBy2SDwIHccYdWcZYIGmX?=
 =?us-ascii?Q?DEN18RL393XajdxVm2tU4J18gmOWGbwQoUqlON5Pe7YhKLRjQamOmA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dY88SHeij8CESuapp9RC6D845B/gBZrH+Cp4nx9D6qJdU+NBv2bgIXiZChuP?=
 =?us-ascii?Q?x6zAqrbslkCTftvtPWRSbIkUMSeas2Ld+vGJdcTLmDium8eGI8/Ce4YgqVpM?=
 =?us-ascii?Q?s4zfGbwYhKQV9fPBtNVv913Yi8VSuzrxA6lppcNMDAUbb3aXbYWtwzjXyrjD?=
 =?us-ascii?Q?2WIU7+tnIB9EFSVDpLhY1P6F1KVYE1BM3sXK8kH1u2DpoOT9YrWm0J3UzP0h?=
 =?us-ascii?Q?jhKVuCdTE9ElMWVbV9f98CwEysaHICIydD9GRRsX6Ur8pk4dJJzDlSnk79SS?=
 =?us-ascii?Q?Tkzz0eAuI2vwitIrdNhWQSBgWSnKeb7mQU/nhlx7sIeNj9SIohTDMrxDEGIJ?=
 =?us-ascii?Q?fUlzJX6f+WdASYJgGFZJj3hDSZf0TmXeCbSMkX7PzlVoGIW51Q68eMKBY5aJ?=
 =?us-ascii?Q?XrDt2Q3/pYw6HI3ipzoAky3FjGSz8+OFbgcilwSRGgZIL7AH12qOiwEp48yd?=
 =?us-ascii?Q?Yc7PIr1qwp6j08cJdcsD8l7p1aYNVb73uT16ZuUkBZ//EuMIgAJgfEbcBsTw?=
 =?us-ascii?Q?TSDiYfz5v+VE+WPcEKiY/a7y7O17qEus17H/JlGee6Bmx9q7ilNugWvV56Yb?=
 =?us-ascii?Q?pLKIo1C50nB5pjXlkvoLm2HA9B9F5cKEvB1sugKqrt/jS3tkdVGWZRs9s3HF?=
 =?us-ascii?Q?mR9BTYy8ejXE6P8HKybEEWcyNZSjw5/Mt7JKwx/RBjrOPQJHDrmoSgRMeO2x?=
 =?us-ascii?Q?bUw2nHt1sQ8wQpdEJNWMC8SYimOTlUG+8CxBGaQgF8oh0U6bOUdpWPIEVfwo?=
 =?us-ascii?Q?z7Z9RIWZZYShZOqoWPd3U0JYnKS5PTzyxPTngaQsOc+jixTDHJ7yCTcWe2i/?=
 =?us-ascii?Q?fIB2I40IgSfqYgYY8PwmKGWfvronG89VK5N8w6iRFyrZCvnshwy7Ze6jKiqP?=
 =?us-ascii?Q?QvXp1PRaZoicz/LeQnGm/nhUfh9mOUyB8gvXS92PgacmsqzXBklAZV+LZW+D?=
 =?us-ascii?Q?2Dq5WsECXU2E5PkeWOS3mhTv93VpxyqGJiWdALuDU+cKxadwwgslzBuicnqB?=
 =?us-ascii?Q?I5v9sUHAUp+QOlWJwa8fCtqI0D0Fb4XGcVmt9yHPnkdA7G8EeGYXKgeX11QS?=
 =?us-ascii?Q?EXf+BDBTvoxeGsUAbUSzYXpCjWkiM/k0wxQyYci6AsYEqXmJX2szXddWgqgT?=
 =?us-ascii?Q?m+b2xaf0PF1YgUR0WNotyCE0xz59u3TEcyFO3M9aEuhD5G3o34SoRMrS4isx?=
 =?us-ascii?Q?xZuUJCPo3kFmdidKQ5Y1cGOaSNdm9A1rLA+hO3Gr8eyXb7nO59H0NauaJsTO?=
 =?us-ascii?Q?Q+iK/sPKYmOO38qIL0BdSit1B9H824cM76eABbqW+xb3FjKHqGaB4I3CS5l1?=
 =?us-ascii?Q?KI2jPn+J9B6v/+VCe2iNF5eF2mDDLAD/7RGLZ5egRK5RS8yAdHYvrZoUlLif?=
 =?us-ascii?Q?HDUYHAUOk6W13+lPDC6ut4cCwelV0mr8Q8TuoQsuorLtVpSqRW+TBLCD95EI?=
 =?us-ascii?Q?jNoc4f3KNk8bOV3mW8cZLYTlY/OIFc9SsEqGdWsCdRtYKlu+Uj9sdWx+K9FP?=
 =?us-ascii?Q?rr6FxvnMEg/ANWixFLReo6Jv3GJDpynUgvkaE48DSjOpj01AmmDgGtKYdo9e?=
 =?us-ascii?Q?ZMUsOFUAGfPEfyF/M7DcN3ywj2rUyQqpi3hFyu8Q3lWV4BAfvwZOxjpd4H4r?=
 =?us-ascii?Q?xQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MVXQwwOAcQ76uJA+g0xmALFBaN0aipVS7tvAEVXX7qmxSDG0z5uXM7Vc//6GSPNw2emhPCK76z/R/pdj+gBf8iMzT6hxp5f7Uc0NUeP/Nu9dlNpL8A6JuWv38VKRUNyM51ZqkBZ26EkF/UCMKJG/gFqSKN018TzFYNPIW+oMuNsyUbanilnhzjNCnkILj+XIpUDMa2doAb/bKm3G9mjtPcv0DOkkioQps6K1vxy2JXZDo+xXR6ioVx3zsSFa5Zg10MajX2RkqKmyFE04tMrsflsUAS3ES6yR0ay2g2GHCt27IL1dc3Nzkt8CIJO5UY3qX518xPkN2puCsA6oukDz3jJ4oRjTCBLHnjU+RZLEO6VPGCsmHvCFACmR55ekrMrW+ZgRlzNnlpXXWpp01Z8u0CTjlTnLboXeKlO6M5WZ6cqGUtFSN0D0DVbfJVocwuGeJTxKQ7GQLAsU3ARQbm/blytlphecLQJA2eO3qrL1Kc+Oq93RMO1KvUuNHc/nG/WLNs1jreGLViOloLr2ufYvJxbBbvWTQp9Fz2XVVCvO6KYpYzkKZ6evIwdRurcTl3yMh5KVXxYyT4KV7mKpSdbQZZQf3l5hBDEEgqZKgaf+YKc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72c4fc01-29d7-4b99-b5ae-08de37fd135c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 15:02:02.6200
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tp57phGA+EQEG9SAcbLiFO9lfUpAtYNCs2m+6Dzdq30Htx4NIhMkZuU788FXKZZB1oJ/Xdo4smO577cOfuKvb4xsOdDvHjxuKBEoQoPsVIY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5791
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-10_01,2025-12-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 bulkscore=0 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512100121
X-Authority-Analysis: v=2.4 cv=UelciaSN c=1 sm=1 tr=0 ts=69398b74 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=i3X5FwGiAAAA:8 a=NEAV23lmAAAA:8
 a=irHmBxNEyR6cq4EUMSIA:9 a=CjuIK1q_8ugA:10 a=mmqRlSCDY2ywfjPLJ4af:22
X-Proofpoint-ORIG-GUID: aApo99nZyWu6IRNWbn_BZm1FOXaaDSNH
X-Proofpoint-GUID: aApo99nZyWu6IRNWbn_BZm1FOXaaDSNH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEwMDEyMSBTYWx0ZWRfX1mjXwUnPQ0jZ
 hwAQPqWdL9V18ANB2PpAFz0/oJ+n0VGwl5f8fCVUZ3SqFXt68bHS1XGf6v7levXGR7Ws6+7ekek
 OcrGKqs8SBw59oCDr38MzY5IAq1fFDh0oyzEeH2SSwrP0iJZtPaNl6Bpej3RENzZT8oSOyMBTNO
 HNjFjQ/3fjvU6+GopZY8QQ8KWIBbYyxWzpIsqRWiyq21bJL49/fXDyNG+Y6NRWR/m1Y+yPMq7Tx
 1hAo2Jsza1vf7cIHEB3rIA6H3uxHqPaJyDxGTkPEVKqEnCb5mSYYVyFrIwA6LPPlRTQEIlTOYKV
 IXfdvzwEvqx9gs19JNHOYYF5Lud/NzK2eTacNtVAA==

On Wed, Dec 10, 2025 at 10:55:40PM +0800, kernel test robot wrote:
>
>
> Hello,
>
> kernel test robot noticed "WARNING:at_mm/mmu_gather.c:#tlb_finish_mmu" on:
>
> commit: 0e1ad0324aabb5aef3ef409de9a395cda7ee6098 ("mm/hugetlb: fix excessive IPI broadcasts when unsharing PMD tables using mmu_gather")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

This is the:

	VM_WARN_ON_ONCE(tlb->fully_unshared_tables);

test case, so is likely the issue that Nadav raised where this isn't being
initialised properly so is just spuriously firing off.

Cheers, Lorenzo

>
> in testcase: boot
>
> config: x86_64-randconfig-004-20251209
> compiler: gcc-14
> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 32G
>
> (please refer to attached dmesg/kmsg for entire log/backtrace)
>
>
> +--------------------------------------------+------------+------------+
> |                                            | ef8ae3fc3a | 0e1ad0324a |
> +--------------------------------------------+------------+------------+
> | WARNING:at_mm/mmu_gather.c:#tlb_finish_mmu | 0          | 12         |
> | RIP:tlb_finish_mmu                         | 0          | 12         |
> +--------------------------------------------+------------+------------+
>
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202512102246.ee3d6d07-lkp@intel.com
>
>
> [    5.210750][   T44] ------------[ cut here ]------------
> [    5.211469][   T44] WARNING: CPU: 0 PID: 44 at mm/mmu_gather.c:475 tlb_finish_mmu (mm/mmu_gather.c:475)
> [    5.212311][   T44] Modules linked in:
> [    5.212737][   T44] CPU: 0 UID: 0 PID: 44 Comm: modprobe Tainted: G                T   6.18.0-rc5-00395-g0e1ad0324aab #1 PREEMPT
> [    5.214003][   T44] Tainted: [T]=RANDSTRUCT
> [    5.214515][   T44] RIP: 0010:tlb_finish_mmu (mm/mmu_gather.c:475)
> [    5.215083][   T44] Code: 66 89 47 20 e8 90 fb ff ff ff 86 dc 00 00 00 5d c3 0f 1f 84 00 00 00 00 00 55 48 89 e5 41 54 53 48 89 fb f6 47 21 10 74 04 90 <0f> 0b 90 48 8b 03 8b 80 dc 00 00 00 ff c8 7e 10 80 4b 20 01 48 89
> All code
> ========
>    0:	66 89 47 20          	mov    %ax,0x20(%rdi)
>    4:	e8 90 fb ff ff       	call   0xfffffffffffffb99
>    9:	ff 86 dc 00 00 00    	incl   0xdc(%rsi)
>    f:	5d                   	pop    %rbp
>   10:	c3                   	ret
>   11:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
>   18:	00
>   19:	55                   	push   %rbp
>   1a:	48 89 e5             	mov    %rsp,%rbp
>   1d:	41 54                	push   %r12
>   1f:	53                   	push   %rbx
>   20:	48 89 fb             	mov    %rdi,%rbx
>   23:	f6 47 21 10          	testb  $0x10,0x21(%rdi)
>   27:	74 04                	je     0x2d
>   29:	90                   	nop
>   2a:*	0f 0b                	ud2		<-- trapping instruction
>   2c:	90                   	nop
>   2d:	48 8b 03             	mov    (%rbx),%rax
>   30:	8b 80 dc 00 00 00    	mov    0xdc(%rax),%eax
>   36:	ff c8                	dec    %eax
>   38:	7e 10                	jle    0x4a
>   3a:	80 4b 20 01          	orb    $0x1,0x20(%rbx)
>   3e:	48                   	rex.W
>   3f:	89                   	.byte 0x89
>
> Code starting with the faulting instruction
> ===========================================
>    0:	0f 0b                	ud2
>    2:	90                   	nop
>    3:	48 8b 03             	mov    (%rbx),%rax
>    6:	8b 80 dc 00 00 00    	mov    0xdc(%rax),%eax
>    c:	ff c8                	dec    %eax
>    e:	7e 10                	jle    0x20
>   10:	80 4b 20 01          	orb    $0x1,0x20(%rbx)
>   14:	48                   	rex.W
>   15:	89                   	.byte 0x89
> [    5.217110][   T44] RSP: 0000:ffff888103fc7c28 EFLAGS: 00010202
> [    5.217747][   T44] RAX: 0000000000000000 RBX: ffff888103fc7cc8 RCX: ffff888103fc7c68
> [    5.218585][   T44] RDX: ffff888102b85000 RSI: ffff888103fc7cc8 RDI: ffff888103fc7cc8
> [    5.219466][   T44] RBP: ffff888103fc7c38 R08: 00007fffffffe000 R09: 00007ffffffff000
> [    5.220295][   T44] R10: 0000000094692512 R11: ffff888101b54948 R12: 00007ffeaa1ad000
> [    5.221108][   T44] R13: 0000000000000000 R14: ffff888103f70a00 R15: ffff888102b85000
> [    5.221923][   T44] FS:  0000000000000000(0000) GS:0000000000000000(0000) knlGS:0000000000000000
> [    5.222854][   T44] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    5.223545][   T44] CR2: ffff88883ffff000 CR3: 000000010172b000 CR4: 00000000000406b0
> [    5.224429][   T44] Call Trace:
> [    5.224782][   T44]  <TASK>
> [    5.225096][   T44]  setup_arg_pages (fs/exec.c:674)
> [    5.225621][   T44]  load_elf_binary (fs/binfmt_elf.c:1028 (discriminator 1))
> [    5.226127][   T44]  ? exec_binprm (fs/exec.c:1670 fs/exec.c:1702)
> [    5.226612][   T44]  ? __lock_release+0x4e/0x120
> [    5.227188][   T44]  ? exec_binprm (fs/exec.c:1670 fs/exec.c:1702)
> [    5.227678][   T44]  ? __this_cpu_preempt_check (lib/smp_processor_id.c:65)
> [    5.228270][   T44]  exec_binprm (fs/exec.c:1672 fs/exec.c:1702)
> [    5.228746][   T44]  bprm_execve (fs/exec.c:1754)
> [    5.229212][   T44]  kernel_execve (fs/exec.c:1922)
> [    5.229754][   T44]  call_usermodehelper_exec_async (kernel/umh.c:109)
> [    5.230368][   T44]  ? umh_complete (kernel/umh.c:64)
> [    5.230867][   T44]  ret_from_fork (arch/x86/kernel/process.c:164)
> [    5.231341][   T44]  ? umh_complete (kernel/umh.c:64)
> [    5.231813][   T44]  ret_from_fork_asm (arch/x86/entry/entry_64.S:258)
> [    5.232321][   T44]  </TASK>
> [    5.232643][   T44] irq event stamp: 469
> [    5.233065][   T44] hardirqs last  enabled at (477): __up_console_sem (arch/x86/include/asm/irqflags.h:26 arch/x86/include/asm/irqflags.h:109 arch/x86/include/asm/irqflags.h:151 kernel/printk/printk.c:345)
> [    5.234028][   T44] hardirqs last disabled at (484): __up_console_sem (kernel/printk/printk.c:343 (discriminator 3))
> [    5.235062][   T44] softirqs last  enabled at (504): handle_softirqs (kernel/softirq.c:469 (discriminator 2) kernel/softirq.c:650 (discriminator 2))
> [    5.236041][   T44] softirqs last disabled at (493): __do_softirq (kernel/softirq.c:657)
> [    5.236959][   T44] ---[ end trace 0000000000000000 ]---
>
>
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20251210/202512102246.ee3d6d07-lkp@intel.com
>
>
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
>

