Return-Path: <linux-arch+bounces-8467-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 827479AD04C
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2024 18:26:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F6392847AA
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2024 16:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0A71CF2A9;
	Wed, 23 Oct 2024 16:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lMZc2EdF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="t0xUX0/S"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B071CF299;
	Wed, 23 Oct 2024 16:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729700735; cv=fail; b=GkkKnlerjcseJYCtetKFFrr8TqHXz8lcrBOcXrDqlW6M41FGHj+AWPjp5vHXUrSwjsQ2/cb60QdjR0G+PT6aNWkVHzJlGMn30K3YZLhOn1PVtLUVP7HIXqs6YlgoSHWchyEmWlMM8RMB0T10yGNG/WvTMwfnsvh/qbGD8jfkjhg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729700735; c=relaxed/simple;
	bh=Mmi4UeKbWikDYyMi8VghSLQVvjn+6yQRCp1LV6Xhqs4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PN17ASPAD4uOqcFWLAt9YPz5X74+FQZqrlxr2PQY9lWlQ5RVUM/46lTgfkIBQH3dlylDfy6jMUtycszosVAkFjWjlq5iSrujDpy+9U7TttRWMPEBvjZlTRI3ffhwWdH3hDJ/ifMbaBY/EUfkE5s5MoIXDNFPlPss54mDzCnvrJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lMZc2EdF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=t0xUX0/S; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49NFfcea025333;
	Wed, 23 Oct 2024 16:25:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=hFCM0e78+b+/G/MXToFjpQ50kDjpN2kBLlXHoOncL1g=; b=
	lMZc2EdF5VrT/GfHJax7Hi3pr+1xPROZ/tWuZJv1RwtT/nG1RJTV96Bc+RyogCbI
	mAoZsqGW1LI7hIWV1LBD7Q/6hUFX/56wsD5CdYm1ERaaj87zaCpUNRjRXpn9y8sC
	g6gaXItd0C3LyLc1OCiAjNVC468DL2qCvJLkHdkec7qlMChNJhuz0xKKNm+TsGHR
	pyE7Z8ygXEmX6UXimetwen0e3Y9Jxjj/zYQm6uHjnexxIHTgwgcT117aE6iuVi8t
	dHpqzMccCSEXcnEVyzKRowIegEF567rX5CS8ipj2afc5tqGBvEiM0E7x5PeWC7nF
	I1D/8o3+9/PTibAUDMvKTA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c5asgj4p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 16:25:01 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49NG1Eni027453;
	Wed, 23 Oct 2024 16:25:00 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2044.outbound.protection.outlook.com [104.47.58.44])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42emh328xd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 16:25:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tQoZoMsXzmxg4OJyNoJHAaDtF/jBRSEXDS3Y2nsPsbdOKq/kE4/bb5Mr+ck9i1qb964ihsazLnOTsy1Y6KgxoWyCBt32t9SqVYXmJTIIhyZEpwKe8RhXdmOJ/HX2hcuMKLYjsdUYREaULbcpC+WsL+CqKpX8Qsqr1v2ytROuMsBdFOhGm5EVEawTzIdBNOHxs48nwweAVDZVX4h0CiF1Sx/fIUV0Y/7098NiGK4uOdegCz5Vd4KXLSm4w42N/RL1fVe1vitqxlaARb4rkHSyKogdCSmoxQfPK/I6VIc6C3rvUyGl5JDXmATPt9tGh02HfUwbpmpZZ5jHTQg1oWssKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hFCM0e78+b+/G/MXToFjpQ50kDjpN2kBLlXHoOncL1g=;
 b=m1oo5LIT/Qefib8zeO5eulRCPAifBLK5uzlacAR/7/pDM8Liv8jcJ1HN4Dgx0U/6viWA3Zm2X/srm6bfVgePRpPdoUWPeTDYJ8/xTEMtSG0u6gpS2GNWo6Yxp6pg4UYMuIguIRbp5ZqRp0ZS6aFcQGAiU/FyldJ3s0RBWe2qrAyWvJ0gtth2ktkYYXd48vwayp7fGxj7OH5YUlhQ9DO/GgdK1LubsFQn09KSuOMLDqtid5iVFMCvOQkmBPxirdtxLo9HmrFK6N6OJlphqyzwiT0dgWmcpYd7wxj4kTUXLv8jK2IeLSOKnwCgHSONopW+d+pdq4P2QR/KWA89l7jdBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hFCM0e78+b+/G/MXToFjpQ50kDjpN2kBLlXHoOncL1g=;
 b=t0xUX0/SJ3FEzwiXEoBhgN54Cb1Gy1mr0YdJ13f1V8mkggzYvx0aOilmaLEDLE9tYhmeGjjXsLMM54HhXOWyYBNasFQZbaLjQYIwHhT3OzRKjDvPyGlIAvnm/vraC4wffdPKAAY23WVAMguLAwfWOt6LN/LcZ0wpw4vUGzWQrh8=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by CH3PR10MB6836.namprd10.prod.outlook.com (2603:10b6:610:14f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Wed, 23 Oct
 2024 16:24:56 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8069.024; Wed, 23 Oct 2024
 16:24:56 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        "Paul E . McKenney" <paulmck@kernel.org>, Jann Horn <jannh@google.com>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Muchun Song <muchun.song@linux.dev>,
        Richard Henderson <richard.henderson@linaro.org>,
        Matt Turner <mattst88@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>, Arnd Bergmann <arnd@kernel.org>,
        linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-arch@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>,
        linux-kselftest@vger.kernel.org,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Jeff Xu <jeffxu@chromium.org>, Christoph Hellwig <hch@infradead.org>,
        linux-api@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v3 1/5] mm: pagewalk: add the ability to install PTEs
Date: Wed, 23 Oct 2024 17:24:38 +0100
Message-ID: <9be732fd0e897453116b433fe2f468ef7795602e.1729699916.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1729699916.git.lorenzo.stoakes@oracle.com>
References: <cover.1729699916.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0384.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a3::36) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|CH3PR10MB6836:EE_
X-MS-Office365-Filtering-Correlation-Id: 393368a7-2130-4048-c51d-08dcf37f3b08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rWA8e+nnwvMJnTur8Y54LLOK62gKpX2Mh7J+ObxdvAmcZWNK9kxQurIpdZNC?=
 =?us-ascii?Q?FoFqjvcpqPZ0fBX+3Mgtmv5sq1zIB/MHYEolNVknMUkhp1umIVnUdE+ZGDrG?=
 =?us-ascii?Q?n0PVpGy4f16f0/vE5BspwbZCdzpPq2c9xPhH+VJohpB2fuaXCHrisJP1KtdN?=
 =?us-ascii?Q?8MKsLmdl+s307gEelv+nVyKSt2OPlg9BHCvn7MOF4b/dd+cWcs+/u+Vf1c+w?=
 =?us-ascii?Q?xqTsxJDbmlHDxrXbw9Bqa6n/mhkGa9utn1VE3XyT8sQ4TKjRxfVTvRWXfCPG?=
 =?us-ascii?Q?yeQ/RXhTwr0GH2JdQf8Sa/hSHYWaO6FAda/HxqOV7GkLtU7uXOfoRxrQlFEQ?=
 =?us-ascii?Q?/TT18bQ2Ix+Q9nPNUsRIRScIGU5R0oP1YWzvKcJ/ny62sQChKpK2ltksSiOz?=
 =?us-ascii?Q?UWW75ZkTrop028YgfpKeFKbyOLT2d/dy5f81s5eCEANoXnRNp7jYoLacBzUk?=
 =?us-ascii?Q?yQKbnxM2GnWXmKeeuvOK0C/CzcZ96SSoPYiHQMpXn2sB7+Gg3UeqhdFSc47p?=
 =?us-ascii?Q?MXwCE5/K96f6GVVayMTpi1aTkv1NAnW0a/NjkClOrVX8J4vfPa65A5i6bKNU?=
 =?us-ascii?Q?FI91LDOrE8TeeGpDK+iHt9DASkVkMooWiMHLc7PAdsooeM8pQWoisZhuJ6e/?=
 =?us-ascii?Q?ifyIg8bclYthOsVMIiZMCj3P0kSVe8Gv9r75epZ8ty9ymVIKFedvnfVwFll9?=
 =?us-ascii?Q?Z7sFM9ei+TzSHF/LseExQDZr1tPP1K7CWT5vSD9hHTKVTpkpPHzVwyeoYlgf?=
 =?us-ascii?Q?oKaSCPhAlZYvIRoFn/a4vRCXTguXDiAW+BjxGNfWtuqdc0xsZtLOu3FWRtub?=
 =?us-ascii?Q?29I4hhEfNElLmUsg3I2HF7I3bHqW+Puj+woJj/xM7bG0xEzmej/b3M+QMj8Z?=
 =?us-ascii?Q?lhK+1KH6LM5xRFTWOsK8fk0642zIE79OMptmxl9KDwxNXLyO2MDaG1lb17oh?=
 =?us-ascii?Q?ts+dT9vn29jvDaM0WDefx61t5rTkEMsQZqyY2z2PcCcatldNboL5VAAeyAlW?=
 =?us-ascii?Q?ykBsbvT2+P1f1oBx/HfOrTgB3i/cJhUTnQ+hMp8lUoRp8U2Vzn8MmkV9SClV?=
 =?us-ascii?Q?8JSe/9B2gyWaxTOXJdyJ/GX9IzEqM99VBq2cNlXsXAF5fvCLIdcnx/wZ5DXn?=
 =?us-ascii?Q?7pB973Gf7zugC7ONszO8dv0GSslq298O+ijT0z+uDA7IMgcYPAnkYZQXdO58?=
 =?us-ascii?Q?meCQzuOThIeesor1ZWpjUHNfmENTq7xx1sKDNivoBdg3y9b4NK03Kdsbxui4?=
 =?us-ascii?Q?ecaKxj/Gfb3OcjXjvKaO+x0y6D39t31k69I6MPYAgcydmexkLN4Jp25Qz8Lh?=
 =?us-ascii?Q?0HD3WAhYTm7E3MZ01x2a5QxE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pVotCpcuM2ze6cNCVL3vT6lhTwbP98D5DAhFk8zoDCH6WRYvG+IXbauEQObC?=
 =?us-ascii?Q?WaWqkL2QPAPJNnnR/1/ofIiidqm8Y8vHGu3H/+Ts3HXtArHYTAasLwhT+j28?=
 =?us-ascii?Q?M5LIUEN0NnCY7oDadopuWN9lN8NT8eAg43F0GFTJCBP7cM20Y/AxvF0KjhzS?=
 =?us-ascii?Q?gPjSin+k0kc4omFExxbShW2FW1TmnqmXbwZMCOTMX6GmPk2C5N4vf1EyyScn?=
 =?us-ascii?Q?YjWmpTzaVy9sDGapPRtQKbQWzuEAp1h8ZuIQOfnH3l+WPDedLX7D22MTZymO?=
 =?us-ascii?Q?tuqBYQ5OLaZQoEM3gbvK+XuvGVXZT5I9EDUD8croE+24/0e2Ymipg0ydwak3?=
 =?us-ascii?Q?4Nmvk8/lmUHEZ0r1sGAyML3XZ5/4xqOqwtOBeTAntl3pidy8q1uWazPkZwUg?=
 =?us-ascii?Q?IEap4l4z58ACvPhdWr9NmZ9cBiH9tjvBOl4l9nNYlOfQaMJZjUGL8574a0vA?=
 =?us-ascii?Q?0iDkhlnwmYctEa+iNITWSnARPBHNziyVhPbK7weFlKgalurB9qyN9EjJ5hIM?=
 =?us-ascii?Q?iYiYjo+WoYHwPo+iT08Ix/CccJ4Yibc6USIvfJY1b09CHN/ocy7M/QcHdJbP?=
 =?us-ascii?Q?ZJkDOsWkwf+bpgyz8gGrYq24CzMNBnvCv1Eb5AwGfYv9YtBhez13i5nKUBev?=
 =?us-ascii?Q?6OXx2bjx6ntFR1WTrXW/ry/NldpU7UX1EJnyEov7oCWSozN76y9/HfVo9/fj?=
 =?us-ascii?Q?TmaBKMXZSx05gVQkfmG1vMVQgbB65vNHGBkwre020mdMyYb5sXGnw4mNxQkr?=
 =?us-ascii?Q?fodD05sPnJZcVfmfyzBMjmNtUeR/BszVBwPUHcSQc6gcOl6LuVzf1SP4frUK?=
 =?us-ascii?Q?ZmXhzJFrJiVmVAJ8CLbJZq1oQ6eJAzMq0MeceN3969NCSSv6tw+go7qf/mgb?=
 =?us-ascii?Q?CjboMUFhqDIZOSxitX4Cz9g4gNDZ5TH3Kg6A7mBJjIh0yfZFzzBizt2GdYlg?=
 =?us-ascii?Q?ae5hgyGHNgmC7Rs8lOJwWqFLam0i7jS/U50EiZwMbyNrTscChki91cL/3FzW?=
 =?us-ascii?Q?S1PkT8kzx3qSbuk7up3KrPiDTi76n/AdF7JefTclilIUK4uCbv0JixTg0lO0?=
 =?us-ascii?Q?lPbSv6XNtIKUu2t87QSiz6UI4LqbIkz2LAixB7SH8HdUUq9ZgzJmAB48EbnS?=
 =?us-ascii?Q?WdbZODS8TSN3dcaNd2Ld9Zp3A8FT+ahUv6pPJuAxy5JPAJeT3Lm4z/svtb02?=
 =?us-ascii?Q?gZMMA9vkudHmKmQ30BA8zYGnDEAsySdPEAsg5+t8OR+Au7Q55hX+/+d0aTkh?=
 =?us-ascii?Q?ONLbXaMp0vp5didHNQrLrXzH4ELtIJmiPQrJ+aEm8HNQIdj3mSXUCKEF8w8f?=
 =?us-ascii?Q?RIqTO7XNPP7W0M1acfXQzmVBad1upQfOuZDR0WqzVg4amfsYjWLYGIdEkH6U?=
 =?us-ascii?Q?R98KhiFSLS/45ogIrGLIZgROENRS+pZlMPFvsNS+Xha0dUL5MwZoeAIR3NxR?=
 =?us-ascii?Q?8AVe9WGhH10bvRxVphV4vNnlvGNT8VoWzXGGhYdpnlaw8Dk00ZQgyxpJ1jmn?=
 =?us-ascii?Q?XhGV5MWWULE3BRqdYVeHKJC7fpXCt4NiR9mdBtP0IS7OlA5uA+ncRVEyLSCQ?=
 =?us-ascii?Q?cJPJCvUUoYb83YuxZ0Y3ODww/DLIaS6HhiQiXA9SHuorrM9rvDb2dDCftJk7?=
 =?us-ascii?Q?OAuJoZ+ptJtHQo7padG5RueMbD/vTzYzl7/91aIGTsoLrm3Gu/LisV3sq/t1?=
 =?us-ascii?Q?b46MkQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VHXByoypFYz39JXeTwmTT49Oq6AnMNRXy1hFV4RyGhKAZHb+ZH1kxUeVa/tj+ScneWJt3uVw26e3x2FO11+WoCTdn2nlQ/SSL5GooVzsD4uKN1hCONg9vz9aoV6nsAgP+RRJb+wE7I3D5w12l0YAHFk6pKJ8XL5qyS0ES0Y+X08HFqS1BwNPuDEWq1APonQ4NorDfPnYE6FcRK9Kc3zKV+xSV1ECH3kwvxnob2lG279m9W7ni3SHDANXwFUom2H9SBz7F6WqIfzDjsiPgKw2o91dGa/xAxLHH0P+VSWveY6L56H9GsZQ9KIUdU/IINLDX8tPeXyoA2SH58qeKm9HAFVN5U/M5e+HpkNuymeD0N1YTmuaZyeE4YvQPaos8pC/5/Ag15zUD2T5ui4icmWwfAzFJKsl/qwPSAmaYD4Zxt/Ur8IeRiTf+0oc/o6M7JOcZCA8Wz+9Pt6rvZXaIxSsdK/jIXZ2DCPkJPpR1Wd9R9PIfTEHh1E30HsgwfxpsbaesB2gh6lyoGfq9EEVqoVnJu8dqt+wZhYiWBo66PXOrJK9ag9xRg3UiEfA9vENYfihPj9cnLFQiO1nyUATnQmHlEVW439qlu3iKzIH3MRpMY4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 393368a7-2130-4048-c51d-08dcf37f3b08
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 16:24:56.5287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vXJDUY3tewWyajAVpUS9ZYHBkERSFi2SURoTZw7J6zzQ9JyJeHi4812BDKGYnPZyv8O5kbi/KJ3Uw68DVV0dBko6++TKsxQFPH8JZrjT5cY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6836
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-23_13,2024-10-23_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 malwarescore=0 adultscore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410230095
X-Proofpoint-GUID: nSb4NVsdwXyavRW_ddHmBWl7L7GTbHXn
X-Proofpoint-ORIG-GUID: nSb4NVsdwXyavRW_ddHmBWl7L7GTbHXn

The existing generic pagewalk logic permits the walking of page tables,
invoking callbacks at individual page table levels via user-provided
mm_walk_ops callbacks.

This is useful for traversing existing page table entries, but precludes
the ability to establish new ones.

Existing mechanism for performing a walk which also installs page table
entries if necessary are heavily duplicated throughout the kernel, each
with semantic differences from one another and largely unavailable for use
elsewhere.

Rather than add yet another implementation, we extend the generic pagewalk
logic to enable the installation of page table entries by adding a new
install_pte() callback in mm_walk_ops. If this is specified, then upon
encountering a missing page table entry, we allocate and install a new one
and continue the traversal.

If a THP huge page is encountered at either the PMD or PUD level we split
it only if there are ops->pte_entry() (or ops->pmd_entry at PUD level),
otherwise if there is only an ops->install_pte(), we avoid the unnecessary
split.

We do not support hugetlb at this stage.

If this function returns an error, or an allocation fails during the
operation, we abort the operation altogether. It is up to the caller to
deal appropriately with partially populated page table ranges.

If install_pte() is defined, the semantics of pte_entry() change - this
callback is then only invoked if the entry already exists. This is a useful
property, as it allows a caller to handle existing PTEs while installing
new ones where necessary in the specified range.

If install_pte() is not defined, then there is no functional difference to
this patch, so all existing logic will work precisely as it did before.

As we only permit the installation of PTEs where a mapping does not already
exist there is no need for TLB management, however we do invoke
update_mmu_cache() for architectures which require manual maintenance of
mappings for other CPUs.

We explicitly do not allow the existing page walk API to expose this
feature as it is dangerous and intended for internal mm use only. Therefore
we provide a new walk_page_range_mm() function exposed only to
mm/internal.h.

Reviewed-by: Jann Horn <jannh@google.com>
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/linux/pagewalk.h |  18 +++-
 mm/internal.h            |   6 ++
 mm/pagewalk.c            | 227 +++++++++++++++++++++++++++------------
 3 files changed, 182 insertions(+), 69 deletions(-)

diff --git a/include/linux/pagewalk.h b/include/linux/pagewalk.h
index f5eb5a32aeed..9700a29f8afb 100644
--- a/include/linux/pagewalk.h
+++ b/include/linux/pagewalk.h
@@ -25,12 +25,15 @@ enum page_walk_lock {
  *			this handler is required to be able to handle
  *			pmd_trans_huge() pmds.  They may simply choose to
  *			split_huge_page() instead of handling it explicitly.
- * @pte_entry:		if set, called for each PTE (lowest-level) entry,
- *			including empty ones
+ * @pte_entry:		if set, called for each PTE (lowest-level) entry
+ *			including empty ones, except if @install_pte is set.
+ *			If @install_pte is set, @pte_entry is called only for
+ *			existing PTEs.
  * @pte_hole:		if set, called for each hole at all levels,
  *			depth is -1 if not known, 0:PGD, 1:P4D, 2:PUD, 3:PMD.
  *			Any folded depths (where PTRS_PER_P?D is equal to 1)
- *			are skipped.
+ *			are skipped. If @install_pte is specified, this will
+ *			not trigger for any populated ranges.
  * @hugetlb_entry:	if set, called for each hugetlb entry. This hook
  *			function is called with the vma lock held, in order to
  *			protect against a concurrent freeing of the pte_t* or
@@ -51,6 +54,13 @@ enum page_walk_lock {
  * @pre_vma:            if set, called before starting walk on a non-null vma.
  * @post_vma:           if set, called after a walk on a non-null vma, provided
  *                      that @pre_vma and the vma walk succeeded.
+ * @install_pte:        if set, missing page table entries are installed and
+ *                      thus all levels are always walked in the specified
+ *                      range. This callback is then invoked at the PTE level
+ *                      (having split any THP pages prior), providing the PTE to
+ *                      install. If allocations fail, the walk is aborted. This
+ *                      operation is only available for userland memory. Not
+ *                      usable for hugetlb ranges.
  *
  * p?d_entry callbacks are called even if those levels are folded on a
  * particular architecture/configuration.
@@ -76,6 +86,8 @@ struct mm_walk_ops {
 	int (*pre_vma)(unsigned long start, unsigned long end,
 		       struct mm_walk *walk);
 	void (*post_vma)(struct mm_walk *walk);
+	int (*install_pte)(unsigned long addr, unsigned long next,
+			   pte_t *ptep, struct mm_walk *walk);
 	enum page_walk_lock walk_lock;
 };
 
diff --git a/mm/internal.h b/mm/internal.h
index 508f7802dd2b..fb1fb0c984e4 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -12,6 +12,7 @@
 #include <linux/mm.h>
 #include <linux/mm_inline.h>
 #include <linux/pagemap.h>
+#include <linux/pagewalk.h>
 #include <linux/rmap.h>
 #include <linux/swap.h>
 #include <linux/swapops.h>
@@ -1451,4 +1452,9 @@ static inline void accept_page(struct page *page)
 }
 #endif /* CONFIG_UNACCEPTED_MEMORY */
 
+/* pagewalk.c */
+int walk_page_range_mm(struct mm_struct *mm, unsigned long start,
+		unsigned long end, const struct mm_walk_ops *ops,
+		void *private);
+
 #endif	/* __MM_INTERNAL_H */
diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index 5f9f01532e67..f3cbad384344 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -3,9 +3,14 @@
 #include <linux/highmem.h>
 #include <linux/sched.h>
 #include <linux/hugetlb.h>
+#include <linux/mmu_context.h>
 #include <linux/swap.h>
 #include <linux/swapops.h>
 
+#include <asm/tlbflush.h>
+
+#include "internal.h"
+
 /*
  * We want to know the real level where a entry is located ignoring any
  * folding of levels which may be happening. For example if p4d is folded then
@@ -29,9 +34,23 @@ static int walk_pte_range_inner(pte_t *pte, unsigned long addr,
 	int err = 0;
 
 	for (;;) {
-		err = ops->pte_entry(pte, addr, addr + PAGE_SIZE, walk);
-		if (err)
-		       break;
+		if (ops->install_pte && pte_none(ptep_get(pte))) {
+			pte_t new_pte;
+
+			err = ops->install_pte(addr, addr + PAGE_SIZE, &new_pte,
+					       walk);
+			if (err)
+				break;
+
+			set_pte_at(walk->mm, addr, pte, new_pte);
+			/* Non-present before, so for arches that need it. */
+			if (!WARN_ON_ONCE(walk->no_vma))
+				update_mmu_cache(walk->vma, addr, pte);
+		} else {
+			err = ops->pte_entry(pte, addr, addr + PAGE_SIZE, walk);
+			if (err)
+				break;
+		}
 		if (addr >= end - PAGE_SIZE)
 			break;
 		addr += PAGE_SIZE;
@@ -89,11 +108,14 @@ static int walk_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
 again:
 		next = pmd_addr_end(addr, end);
 		if (pmd_none(*pmd)) {
-			if (ops->pte_hole)
+			if (ops->install_pte)
+				err = __pte_alloc(walk->mm, pmd);
+			else if (ops->pte_hole)
 				err = ops->pte_hole(addr, next, depth, walk);
 			if (err)
 				break;
-			continue;
+			if (!ops->install_pte)
+				continue;
 		}
 
 		walk->action = ACTION_SUBTREE;
@@ -109,18 +131,19 @@ static int walk_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
 
 		if (walk->action == ACTION_AGAIN)
 			goto again;
-
-		/*
-		 * Check this here so we only break down trans_huge
-		 * pages when we _need_ to
-		 */
-		if ((!walk->vma && (pmd_leaf(*pmd) || !pmd_present(*pmd))) ||
-		    walk->action == ACTION_CONTINUE ||
-		    !(ops->pte_entry))
+		if (walk->action == ACTION_CONTINUE)
 			continue;
+		if (!ops->install_pte && !ops->pte_entry)
+			continue; /* Nothing to do. */
+		if (!ops->pte_entry && ops->install_pte &&
+		    pmd_present(*pmd) &&
+		    (pmd_trans_huge(*pmd) || pmd_devmap(*pmd)))
+			continue; /* Avoid unnecessary split. */
 
 		if (walk->vma)
 			split_huge_pmd(walk->vma, pmd, addr);
+		else if (pmd_leaf(*pmd) || !pmd_present(*pmd))
+			continue; /* Nothing to do. */
 
 		err = walk_pte_range(pmd, addr, next, walk);
 		if (err)
@@ -148,11 +171,14 @@ static int walk_pud_range(p4d_t *p4d, unsigned long addr, unsigned long end,
  again:
 		next = pud_addr_end(addr, end);
 		if (pud_none(*pud)) {
-			if (ops->pte_hole)
+			if (ops->install_pte)
+				err = __pmd_alloc(walk->mm, pud, addr);
+			else if (ops->pte_hole)
 				err = ops->pte_hole(addr, next, depth, walk);
 			if (err)
 				break;
-			continue;
+			if (!ops->install_pte)
+				continue;
 		}
 
 		walk->action = ACTION_SUBTREE;
@@ -164,14 +190,20 @@ static int walk_pud_range(p4d_t *p4d, unsigned long addr, unsigned long end,
 
 		if (walk->action == ACTION_AGAIN)
 			goto again;
-
-		if ((!walk->vma && (pud_leaf(*pud) || !pud_present(*pud))) ||
-		    walk->action == ACTION_CONTINUE ||
-		    !(ops->pmd_entry || ops->pte_entry))
+		if (walk->action == ACTION_CONTINUE)
 			continue;
+		if (!ops->install_pte && !ops->pte_entry && !ops->pmd_entry)
+			continue;  /* Nothing to do. */
+		if (!ops->pmd_entry && !ops->pte_entry && ops->install_pte &&
+		    pud_present(*pud) &&
+		    (pud_trans_huge(*pud) || pud_devmap(*pud)))
+			continue; /* Avoid unnecessary split. */
 
 		if (walk->vma)
 			split_huge_pud(walk->vma, pud, addr);
+		else if (pud_leaf(*pud) || !pud_present(*pud))
+			continue; /* Nothing to do. */
+
 		if (pud_none(*pud))
 			goto again;
 
@@ -196,18 +228,22 @@ static int walk_p4d_range(pgd_t *pgd, unsigned long addr, unsigned long end,
 	do {
 		next = p4d_addr_end(addr, end);
 		if (p4d_none_or_clear_bad(p4d)) {
-			if (ops->pte_hole)
+			if (ops->install_pte)
+				err = __pud_alloc(walk->mm, p4d, addr);
+			else if (ops->pte_hole)
 				err = ops->pte_hole(addr, next, depth, walk);
 			if (err)
 				break;
-			continue;
+			if (!ops->install_pte)
+				continue;
 		}
 		if (ops->p4d_entry) {
 			err = ops->p4d_entry(p4d, addr, next, walk);
 			if (err)
 				break;
 		}
-		if (ops->pud_entry || ops->pmd_entry || ops->pte_entry)
+		if (ops->pud_entry || ops->pmd_entry || ops->pte_entry ||
+		    ops->install_pte)
 			err = walk_pud_range(p4d, addr, next, walk);
 		if (err)
 			break;
@@ -231,18 +267,22 @@ static int walk_pgd_range(unsigned long addr, unsigned long end,
 	do {
 		next = pgd_addr_end(addr, end);
 		if (pgd_none_or_clear_bad(pgd)) {
-			if (ops->pte_hole)
+			if (ops->install_pte)
+				err = __p4d_alloc(walk->mm, pgd, addr);
+			else if (ops->pte_hole)
 				err = ops->pte_hole(addr, next, 0, walk);
 			if (err)
 				break;
-			continue;
+			if (!ops->install_pte)
+				continue;
 		}
 		if (ops->pgd_entry) {
 			err = ops->pgd_entry(pgd, addr, next, walk);
 			if (err)
 				break;
 		}
-		if (ops->p4d_entry || ops->pud_entry || ops->pmd_entry || ops->pte_entry)
+		if (ops->p4d_entry || ops->pud_entry || ops->pmd_entry ||
+		    ops->pte_entry || ops->install_pte)
 			err = walk_p4d_range(pgd, addr, next, walk);
 		if (err)
 			break;
@@ -334,6 +374,11 @@ static int __walk_page_range(unsigned long start, unsigned long end,
 	int err = 0;
 	struct vm_area_struct *vma = walk->vma;
 	const struct mm_walk_ops *ops = walk->ops;
+	bool is_hugetlb = is_vm_hugetlb_page(vma);
+
+	/* We do not support hugetlb PTE installation. */
+	if (ops->install_pte && is_hugetlb)
+		return -EINVAL;
 
 	if (ops->pre_vma) {
 		err = ops->pre_vma(start, end, walk);
@@ -341,7 +386,7 @@ static int __walk_page_range(unsigned long start, unsigned long end,
 			return err;
 	}
 
-	if (is_vm_hugetlb_page(vma)) {
+	if (is_hugetlb) {
 		if (ops->hugetlb_entry)
 			err = walk_hugetlb_range(start, end, walk);
 	} else
@@ -380,47 +425,14 @@ static inline void process_vma_walk_lock(struct vm_area_struct *vma,
 #endif
 }
 
-/**
- * walk_page_range - walk page table with caller specific callbacks
- * @mm:		mm_struct representing the target process of page table walk
- * @start:	start address of the virtual address range
- * @end:	end address of the virtual address range
- * @ops:	operation to call during the walk
- * @private:	private data for callbacks' usage
- *
- * Recursively walk the page table tree of the process represented by @mm
- * within the virtual address range [@start, @end). During walking, we can do
- * some caller-specific works for each entry, by setting up pmd_entry(),
- * pte_entry(), and/or hugetlb_entry(). If you don't set up for some of these
- * callbacks, the associated entries/pages are just ignored.
- * The return values of these callbacks are commonly defined like below:
- *
- *  - 0  : succeeded to handle the current entry, and if you don't reach the
- *         end address yet, continue to walk.
- *  - >0 : succeeded to handle the current entry, and return to the caller
- *         with caller specific value.
- *  - <0 : failed to handle the current entry, and return to the caller
- *         with error code.
- *
- * Before starting to walk page table, some callers want to check whether
- * they really want to walk over the current vma, typically by checking
- * its vm_flags. walk_page_test() and @ops->test_walk() are used for this
- * purpose.
- *
- * If operations need to be staged before and committed after a vma is walked,
- * there are two callbacks, pre_vma() and post_vma(). Note that post_vma(),
- * since it is intended to handle commit-type operations, can't return any
- * errors.
- *
- * struct mm_walk keeps current values of some common data like vma and pmd,
- * which are useful for the access from callbacks. If you want to pass some
- * caller-specific data to callbacks, @private should be helpful.
+/*
+ * See the comment for walk_page_range(), this performs the heavy lifting of the
+ * operation, only sets no restrictions on how the walk proceeds.
  *
- * Locking:
- *   Callers of walk_page_range() and walk_page_vma() should hold @mm->mmap_lock,
- *   because these function traverse vma list and/or access to vma's data.
+ * We usually restrict the ability to install PTEs, but this functionality is
+ * available to internal memory management code and provided in mm/internal.h.
  */
-int walk_page_range(struct mm_struct *mm, unsigned long start,
+int walk_page_range_mm(struct mm_struct *mm, unsigned long start,
 		unsigned long end, const struct mm_walk_ops *ops,
 		void *private)
 {
@@ -479,6 +491,80 @@ int walk_page_range(struct mm_struct *mm, unsigned long start,
 	return err;
 }
 
+/*
+ * Determine if the walk operations specified are permitted to be used for a
+ * page table walk.
+ *
+ * This check is performed on all functions which are parameterised by walk
+ * operations and exposed in include/linux/pagewalk.h.
+ *
+ * Internal memory management code can use the walk_page_range_mm() function to
+ * be able to use all page walking operations.
+ */
+static bool check_ops_valid(const struct mm_walk_ops *ops)
+{
+	/*
+	 * The installation of PTEs is solely under the control of memory
+	 * management logic and subject to many subtle locking, security and
+	 * cache considerations so we cannot permit other users to do so, and
+	 * certainly not for exported symbols.
+	 */
+	if (ops->install_pte)
+		return false;
+
+	return true;
+}
+
+/**
+ * walk_page_range - walk page table with caller specific callbacks
+ * @mm:		mm_struct representing the target process of page table walk
+ * @start:	start address of the virtual address range
+ * @end:	end address of the virtual address range
+ * @ops:	operation to call during the walk
+ * @private:	private data for callbacks' usage
+ *
+ * Recursively walk the page table tree of the process represented by @mm
+ * within the virtual address range [@start, @end). During walking, we can do
+ * some caller-specific works for each entry, by setting up pmd_entry(),
+ * pte_entry(), and/or hugetlb_entry(). If you don't set up for some of these
+ * callbacks, the associated entries/pages are just ignored.
+ * The return values of these callbacks are commonly defined like below:
+ *
+ *  - 0  : succeeded to handle the current entry, and if you don't reach the
+ *         end address yet, continue to walk.
+ *  - >0 : succeeded to handle the current entry, and return to the caller
+ *         with caller specific value.
+ *  - <0 : failed to handle the current entry, and return to the caller
+ *         with error code.
+ *
+ * Before starting to walk page table, some callers want to check whether
+ * they really want to walk over the current vma, typically by checking
+ * its vm_flags. walk_page_test() and @ops->test_walk() are used for this
+ * purpose.
+ *
+ * If operations need to be staged before and committed after a vma is walked,
+ * there are two callbacks, pre_vma() and post_vma(). Note that post_vma(),
+ * since it is intended to handle commit-type operations, can't return any
+ * errors.
+ *
+ * struct mm_walk keeps current values of some common data like vma and pmd,
+ * which are useful for the access from callbacks. If you want to pass some
+ * caller-specific data to callbacks, @private should be helpful.
+ *
+ * Locking:
+ *   Callers of walk_page_range() and walk_page_vma() should hold @mm->mmap_lock,
+ *   because these function traverse vma list and/or access to vma's data.
+ */
+int walk_page_range(struct mm_struct *mm, unsigned long start,
+		unsigned long end, const struct mm_walk_ops *ops,
+		void *private)
+{
+	if (!check_ops_valid(ops))
+		return -EINVAL;
+
+	return walk_page_range_mm(mm, start, end, ops, private);
+}
+
 /**
  * walk_page_range_novma - walk a range of pagetables not backed by a vma
  * @mm:		mm_struct representing the target process of page table walk
@@ -494,7 +580,7 @@ int walk_page_range(struct mm_struct *mm, unsigned long start,
  * walking the kernel pages tables or page tables for firmware.
  *
  * Note: Be careful to walk the kernel pages tables, the caller may be need to
- * take other effective approache (mmap lock may be insufficient) to prevent
+ * take other effective approaches (mmap lock may be insufficient) to prevent
  * the intermediate kernel page tables belonging to the specified address range
  * from being freed (e.g. memory hot-remove).
  */
@@ -513,6 +599,8 @@ int walk_page_range_novma(struct mm_struct *mm, unsigned long start,
 
 	if (start >= end || !walk.mm)
 		return -EINVAL;
+	if (!check_ops_valid(ops))
+		return -EINVAL;
 
 	/*
 	 * 1) For walking the user virtual address space:
@@ -556,6 +644,8 @@ int walk_page_range_vma(struct vm_area_struct *vma, unsigned long start,
 		return -EINVAL;
 	if (start < vma->vm_start || end > vma->vm_end)
 		return -EINVAL;
+	if (!check_ops_valid(ops))
+		return -EINVAL;
 
 	process_mm_walk_lock(walk.mm, ops->walk_lock);
 	process_vma_walk_lock(vma, ops->walk_lock);
@@ -574,6 +664,8 @@ int walk_page_vma(struct vm_area_struct *vma, const struct mm_walk_ops *ops,
 
 	if (!walk.mm)
 		return -EINVAL;
+	if (!check_ops_valid(ops))
+		return -EINVAL;
 
 	process_mm_walk_lock(walk.mm, ops->walk_lock);
 	process_vma_walk_lock(vma, ops->walk_lock);
@@ -623,6 +715,9 @@ int walk_page_mapping(struct address_space *mapping, pgoff_t first_index,
 	unsigned long start_addr, end_addr;
 	int err = 0;
 
+	if (!check_ops_valid(ops))
+		return -EINVAL;
+
 	lockdep_assert_held(&mapping->i_mmap_rwsem);
 	vma_interval_tree_foreach(vma, &mapping->i_mmap, first_index,
 				  first_index + nr - 1) {
-- 
2.47.0


