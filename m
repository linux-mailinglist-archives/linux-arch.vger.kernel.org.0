Return-Path: <linux-arch+bounces-12075-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B522AC0D40
	for <lists+linux-arch@lfdr.de>; Thu, 22 May 2025 15:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8995D7AE9A6
	for <lists+linux-arch@lfdr.de>; Thu, 22 May 2025 13:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE8FF28BA88;
	Thu, 22 May 2025 13:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hfA2g9l0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="w6EO2O0N"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D15423BF91;
	Thu, 22 May 2025 13:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747921780; cv=fail; b=kVp0yf50YH21FpAau6CiDQIN7mtZR5RkThKwqYyDaKFep7Eo1JH3bqFbPEXIdhpjtleHfw/UYxfbJaqJa1N5Xl1vGufQmKLVlGKNcvkEcg5N/v14TdfD6glTQL5Pe66KL84TCFWmfMZi9dWW/3mqtLPO41BKgzQnZkmrtPu40Uc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747921780; c=relaxed/simple;
	bh=5hsqj+IVl1z3H2GEpF7uW2yQj2yLS5ffb9gFuxaolDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=h+qdLmevyoZGIKP4hH0UgoGCnEzInCfeZH3E3MjLdxW1jGSWa0eGf8bTNuVxHrh5RVZqE/eatETnU6w0qbYPHqjKPtF1nYujCxa54c4yQUvQJhdwW0aFBjdYcETmSr5grBCjGzVUtcLhjW4xgpm0BApRwuD3XSwxTF2YIsYXKS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hfA2g9l0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=w6EO2O0N; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54MDB9pP016600;
	Thu, 22 May 2025 13:49:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=5hsqj+IVl1z3H2GEpF
	7uW2yQj2yLS5ffb9gFuxaolDw=; b=hfA2g9l0MyjF9jZdJw9M1OnhcZ9G8GvMBA
	i2lLDCpaW7EWHAbs6ZpvBrNQ6NebMrrvl51yJGyfo9rk0hhwp64z7/aLOHygp4Aq
	GydVFSysaIM1uWL6x/njkuzCrDUhH9TJjDFw7FqlbDpR1xXYnTk101G61+AbYXPK
	mt43fkgnC6kwMMhJm9QdX4x2ifIdj/mfZKhpxTcpbsTpZf9YZr/ctCpe1sqfEFtu
	CsJMSDJ3iU96C6mVaWziawS2ZOWzmTOedIhmx4stU44JE8NOGW15ci8G2j+L3x0E
	mFQ7JPYUDxKqXs1v7Tqe1huV1DNc2QmCdzgXyH/jha1Fa4YJbGFQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46t4cm05cj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 May 2025 13:49:15 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54MCd4Rs033511;
	Thu, 22 May 2025 13:49:14 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46rweppf9g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 May 2025 13:49:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H6P8r+jggEiDzQ2D7T9A4ckJ4feYEtHWFbse72MkrpkvObkDnuB5vGgMWlxiOfeZPwZuDK8Uyj1nbDOAUg3+XEuqSORvTHac2wHZIF34D7pNLieVHChGS6bHdJ9xzSvnxfWXr+Lz46ybongfRFJ6hMxcNROFRO6nYCz/DLxL306DXvhVbCO8wznTCHAcrwvzd4ifbu0hgmkMNk8F8dfTUU8oedGfdpaMsM4T0sVO+6Q60O8Dko5QzhRWG3KVy/mM8qhIFjUSSzpnlEW+DnZW+hJTQNX5rzV6Q+n48aFWPGlnGUJsXT3UdGuBiZHptv3uqiV252B+BMRGFegURr93Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5hsqj+IVl1z3H2GEpF7uW2yQj2yLS5ffb9gFuxaolDw=;
 b=I+wm8tEBeTbROnWWTNoVRRK7mDTKH3sx3X70j9Ihe7/VifyWedWELE/1FyfnwymAGtWmmTd/I+DzNQSp9FSwReTmFfYPJA78kMwcz1mD4qsfWshINuBnrq1NXuU7bNE7ZJWDSc/IJZHun641hjF/cFZSkEmsO3g/Tx0fFGS6qQKbDdBvuuYZ1AwI52xvSz/8FgnqwxOOU8n5LUVhXLkYWH6vyalJ3BCy/nsSzY402G3aeopgXJ4DYFKkUnm21vMUudlh00+qmj1ZonxCeXCU0XzmaT8zD0SZNmsls5XiNamwRSyaMQ/J+0zi8qFqBTrO21FaJ1GenlVfpcC7T5Qc3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5hsqj+IVl1z3H2GEpF7uW2yQj2yLS5ffb9gFuxaolDw=;
 b=w6EO2O0NINWQHKNT8QKU8iphdL+1MxyqddLYD9HmRLYw+Y2W6GbQS8yv8F27CzmPrHbeFtezZ6I/ijDmCOh5ruGrfMDu9ZB8b+FAFStp0R+t5vMF2Wd3KshiS4zd32qSu0fsaLxiH3zr3q1r0zvhlqRfkU0Rx3HCvLHy4lBz2NM=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH0PR10MB4842.namprd10.prod.outlook.com (2603:10b6:610:df::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Thu, 22 May
 2025 13:49:12 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8746.030; Thu, 22 May 2025
 13:49:12 +0000
Date: Thu, 22 May 2025 14:49:09 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeel.butt@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Christian Brauner <brauner@kernel.org>,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>,
        Usama Arif <usamaarif642@gmail.com>
Subject: Re: [RFC PATCH 0/5] add process_madvise() flags to modify behaviour
Message-ID: <03f18fef-32a0-426a-beee-fdbe4c55446d@lucifer.local>
References: <cover.1747686021.git.lorenzo.stoakes@oracle.com>
 <7tzfy4mmbo2utodqr5clk24mcawef5l2gwrgmnp5jmqxmhkpav@jpzaaoys6jro>
 <5604190c-3309-4cb8-b746-2301615d933c@lucifer.local>
 <uxhvhja5igs5cau7tomk56wit65lh7ooq7i5xsdzyqsv5ikavm@kiwe26ioxl3t>
 <e8c459cb-c8b8-4c34-8f94-c8918bef582f@lucifer.local>
 <226owobtknee4iirb7sdm3hs26u4nvytdugxgxtz23kcrx6tzg@nryescaj266u>
 <7a214bee-d184-460f-88d6-2249b9d513ba@lucifer.local>
 <20250521173200.GA1065351@cmpxchg.org>
 <a8aedeb6-2179-4e53-8310-5b81438c2b80@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8aedeb6-2179-4e53-8310-5b81438c2b80@redhat.com>
X-ClientProxiedBy: LO2P265CA0495.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13a::20) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH0PR10MB4842:EE_
X-MS-Office365-Filtering-Correlation-Id: f3530526-da07-48a8-a197-08dd99376f10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oF3YHxhJVOYPA4QLRs1MXFraQ6CbN3aVZMSPYamP0IQKpkvvOauQl7erFxj3?=
 =?us-ascii?Q?8QVPI5dyhRO1/WKzAev0GsTvsQXXwTV9opWMxudO7r/al6jM8OUk25Jz/MHD?=
 =?us-ascii?Q?kI0H6ck98vlHKwEcg517i0RkJnpvHYEOZAuvv3DjHDZsfuZeXT/81zMN5DEr?=
 =?us-ascii?Q?mCifXohHxSfJjBb0HStOtnm6Aevx4tFO0ocVVZIQTh9BN78QgT3+OFtjsEEE?=
 =?us-ascii?Q?WK7DfXCbYZPaThZrOqCVeHaS96Vt4hQZ9ABI0vgsk2+4AJypRygT09mk0rKg?=
 =?us-ascii?Q?r9ljYOvCxTV4iUaI92issgpzsPRc4G/ar4io4Qvj1NY5nOeBvxEjdyCbhCJU?=
 =?us-ascii?Q?8KdVvl5qI9C6Gqcahv+qHTXJuJ8k+8Px1fEF4AFu2UZYAJjP4Y/KdXR3FQDG?=
 =?us-ascii?Q?kiVq1H3Q/5I2asE8fksndkKFuXmeaI8ishoK/7ckuyKBojtb8X+wrY29VrIA?=
 =?us-ascii?Q?Ypz+/xZS6kfe02CbItwbONoL2O1RvpNoP7J4DF8h8KWkHdSyZJy9le5B6Tbi?=
 =?us-ascii?Q?/KwZW/06dl9siYQTh5IB+HPl6nokkxDUCgNexRS4wjBGq8o3f2JODLcWk24p?=
 =?us-ascii?Q?/KflWIV7Uzort1ZfObIRo7xjctC7+/gr4wEFP7W/mRsp/9X2jXgClQ+YE7yr?=
 =?us-ascii?Q?jXe4FZgFcYjS4GogySmRBra9Va+aZsadEMrIjdMsso1iuMmltd6seNvslH94?=
 =?us-ascii?Q?oWgpm+pT0QPSxCvx8RItGbL0NdLkpxJE3DwXHJLemt/Q17RCEagWjs4UENci?=
 =?us-ascii?Q?bYeU/iCnLmChr+Tr9WeS/VpHy/G9bCJwA2p8pQbQ6el7qyVBpLn6bjUcsvn8?=
 =?us-ascii?Q?XvDyro1j8WGwlAaSyEoqyD6e9vkEafGq/O1tJKGiVhMys6COSA+pQX98qQwT?=
 =?us-ascii?Q?f1WxoUdhWsVlS9NcBEtycD4juvjvPuHjHZ9lCNE0NGoCbKZ3aAv7pj+dFaeO?=
 =?us-ascii?Q?duG8XeaLhJK1wyWR5eOEgoRwzM3DRSwarB3Mnl6ym971EPQVyaHSJMlEMij/?=
 =?us-ascii?Q?ATqZ6e9Mv1064R12aGdxjZWMgB30A27yLkLJ6yJyDJCp3e2ZmoFa+F5pldCb?=
 =?us-ascii?Q?fEnlMkoAc78oNDCjomhRoe7vfhhAmPnqTaGcmsfY509Rp7vqiEGTeOQRGnPs?=
 =?us-ascii?Q?gEWEcFaKjDZQHstqVQrh550od+vQ19smVMeWqJ73ip6IVGzR9xSD0EWrbJb9?=
 =?us-ascii?Q?La/MaKNFP816taLr3U1ozsJtQJitJiVI0cata3t4Vgadg6wSqNz0DS8T4/x7?=
 =?us-ascii?Q?hSOWcgLqBjx28thU5rjlPm8bEmLcQ0PsQsiyNkTvvwrYhCwSFw4h2GKYZEur?=
 =?us-ascii?Q?pCV+0+fFB2it2WvBa8LHdXfpiJ5HjqWi9E74V+KFornkdr2WH/KBQU9wEAjd?=
 =?us-ascii?Q?5SfS2A9hQukQmpPKoEUb+HZ0QpVmOFqYpd5CUXP9uXbb2PzymT/3Y+MTAk9w?=
 =?us-ascii?Q?xp/sMj657SU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aIJVQ2SKzqU7cg0ExsmIIi3zXHBT+e5eHDRDOGzzzt5g/CEXRY8SkaYyUeYV?=
 =?us-ascii?Q?oEiAwAZwnZXXUGybwa+fejM2CxZEaeptDgF7mYi63ZsVZZvfY6ZFpgaCo8DL?=
 =?us-ascii?Q?tlV9RZimZjDcOaQzrZO/XeHGtIlwRi+8N2VHv+rWt7pmywbQj+Xkw0xx8fAG?=
 =?us-ascii?Q?Qu+IM2nRg2shkbjU1iCJh96KsQ8n7R4XKniu8oClOq8+7UuJ04X6pHRobfgR?=
 =?us-ascii?Q?MVcPsAo3dBcP/m+THkpUDmmyCQkUsiVrp9vdHrVrj6UsR/MaBXa8M5dysmpU?=
 =?us-ascii?Q?usGC13cMNrVQ9p55QZa8TWz2LUZT6cKSQAEQNqivr90GBLPwr1zB3rrc5p4K?=
 =?us-ascii?Q?q/Ubln+C5S0hx8QSJeB+oPl478kc78bc/P7Vk+ZGZgjd9O2QFxtW980Kj3Dg?=
 =?us-ascii?Q?Rn3xB/TyoK7moYpl+Fg7r4iDzv0qqwiszULFNsN5lXVicRrXPbVr9TJnmrRW?=
 =?us-ascii?Q?hrF5AB1kf248GCb7pB+A9lII0Dg3b92LwltdUw+vW0ziciuT+FLZ7f49uKWt?=
 =?us-ascii?Q?ljApeh+m8SNR29rf1hOiyHkZ53icHL7L0V00vOAggdF+O+b2nq5L6U6eBBOX?=
 =?us-ascii?Q?3DtvVuv7ScnmOV6mo8yOkfj0zvNoM7gOd807AW1vwyjXmkcFpBSOKvkwSDzR?=
 =?us-ascii?Q?+5UDV0MXU3xm5F/y9TaEHDrI+3o+c+mPFxBEHN001hIyxrGVbi377fV805iJ?=
 =?us-ascii?Q?Dk+hnlnojrEq50QMfVGsWdSXpSYv+Y4FVtR9msy/8r/jHoAn548jn6EwpehE?=
 =?us-ascii?Q?Ph7k1BgyJtLUphz1aGUAMG0AbuqawJVEhAgJbXrx3ZiZLCXUpy+hVNTIvLOX?=
 =?us-ascii?Q?+A2NYTHH8rg17liy0b2V5VqLXOxDJxFmRxrTOvgA4tLnxmdtwRALvBgRsUUP?=
 =?us-ascii?Q?RaREKG+wzNa1WU9SoTsywC/hDZEOw4HsXIWtG0WMY1gleMax+5xVqvhWlof5?=
 =?us-ascii?Q?TLPAfHJ3U74LJyS1g1c/41BdfeK3cOKozJy+dWc4wcPA6kmFQ44bU30s7yyA?=
 =?us-ascii?Q?5Gl+jT49QCNNuHKV5cor5GarQZgPQd+4bhMbskAJBIRh/ouUMVJuOS+WIB6f?=
 =?us-ascii?Q?RRw/IIJ/v3RfeV7T7ipSlgVxpYTjNXMBJh5phf9CGp1Z/ctG7U3HDUOPDz98?=
 =?us-ascii?Q?TE0nQCR9W79eRsQY1aEwzQo//sUgp/8WnD/oDMrcmblAqfv748UyFfEhTJC8?=
 =?us-ascii?Q?h6pxE/e0G62bH3FRo/hAqZUaW3Mn4W64hXtJj+g2+qyBUF7GhXFBit2vbW2J?=
 =?us-ascii?Q?a5r7F8j/9IB5GD/VosSkeD9fAxoHTqxkiCgEzxXP0HKbHVGZROQeyK2QBvmP?=
 =?us-ascii?Q?LCjUfOsybth2A+9pjMoUsdNa7MjnjAShXojQgwXlfdF+xGnZWKA7gGFYw4xK?=
 =?us-ascii?Q?EuASYieSp4FW4Kz9U/CtESVQX5d5PjLqIj1IQkGOeFeWYhdYsfpmRrs+jC9S?=
 =?us-ascii?Q?jdQmtc4n4bhUgmw5F/FdiQfPjJcO3V2oNJJZvkq90Dfggxi6eAL8g5bCuBbc?=
 =?us-ascii?Q?EAuSjfEKfKW/jDEqXPdHQ5kGbMJYRAQa3/qHbv+TIRxH5tp3ETuR5OZ1FOj7?=
 =?us-ascii?Q?woih5MarWbMv0p1shHpaUAA6v960Y7faDV5pNrwGuoxxOKAEHzhXtwXyyERA?=
 =?us-ascii?Q?FA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	B+PP1Vt9+zPTfAKd6/ACMD8oQJBHPMNVgUoz5rcq6pf9X2EFmBMrZdSZwdzRhrBBMXqZg2EhSvQ/IhGdu/oKxer6SvetcBT3EDhCNVSWqOKC43uaQOJSN20q/VGrDYkA3S6WBfeVNzTEItYcMRZ6GewMa66P4tAPnDbCetaLNLcgGZq0HkNwo4oyN+uuU1CuNHFnj5OZHBvIeqbW+vMZ31qs4kuwYrIz+MR8VMo0xbysMhvQESC9n1Rr6ET6xPzDPgei/HUHbVZ27if2pUGD+BABP8DfztEKnr5llreTer4Aj7+kXgZgt5cUTvA/+KLDCY1PEotuFD/K91xfqxjYl3TUalwW0vGgB5kLbN+4MtBhouIIG9W2nerqhQri2+T7xSlg89iuhAjaqkJbGJmYB6fNH0u9i/41zvTl8UXTsYIeJ8yiVVB5I6RrjwV/wODaSqzQ9ZGV1TJq2pGTENzv+nHiJTDLxYsqXSxzWFNbFHgLtG6ZUYbQMP9hzt6FQpTrVnxQ2+TggGBl88wH56WaLHgSHCtFEQMkV6rtjhfmbfJr9EdKsmAP3fCg7n70RsTbiPHzvuNP8f9a4xt1i4rddn4agzSiZMJs9g8PFo3dBz0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3530526-da07-48a8-a197-08dd99376f10
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 13:49:12.2998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: od7QIboYJ3EF92PMJwwJ6qiXSsNxHoH8DWhx3vifHQ68sjbEOciXYM8BopHE4rtDXi0DIbNx0+nyqFB/f8WtpqJ02FioSJ/cDgGNOXgtulg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4842
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-22_07,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=907
 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2505220140
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIyMDEzOSBTYWx0ZWRfX8+VAbgVouLVQ YdMTpxDLUV+6X8Q1UReSN+KLvw4MZZ8x1lLldYzqgnuRTlZZ39TZfYnUAAl0VZVPG/kN+OTpdnZ DQyVz12aGRG3BxaqFVHidJGWUCk1v/yJgVv2zBAm28IDE5FgwVAuj8lbBy6Y9eZv8ldxznZ7R0/
 NfcZA+il7yw9juPGsK7hmUqBZedoCsrffPVH7ya5lcE5/ZYCtVFyYvRA/2pp1ufbnSQzB1K8uLg JBay75f0ZC9oOxNPl46s2wr7nik9fdZ0wzd2AMBsZbzmHsvSnFDFsh9jxLvEPyfAjueSHbvciMi z1EbedQw18WFqzGU8dqVHaEVFThj/gM19bTKWkDwWRQB6azwew3eLpq+AmlavTxXK9de2W8LUQ9
 AlmB8PMWnsDYkv/du+L85LodM53D/y+axZqpwdvyyjbgg45MOrw2sRYLSz8cbbaSzyNsrxw/
X-Authority-Analysis: v=2.4 cv=YogPR5YX c=1 sm=1 tr=0 ts=682f2b5c b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=aMOKAgl9J8874X4INE0A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: vlP3TKEv7mFikja94SPLsiLYUAcigbHK
X-Proofpoint-ORIG-GUID: vlP3TKEv7mFikja94SPLsiLYUAcigbHK

On Thu, May 22, 2025 at 02:45:30PM +0200, David Hildenbrand wrote:
> On 21.05.25 19:32, Johannes Weiner wrote:
> > On Wed, May 21, 2025 at 05:21:19AM +0100, Lorenzo Stoakes wrote:
> > > So, something Liam mentioned off-list was the beautifully named
> > > 'mmadvise()'. Idea being that we have a system call _explicitly for_
> > > mm-wide modifications.
>
> As stated elsewhere (e.g., THP cabal yesterday): mctrl() or sth like that
> might be better.
>
> ... or anything else that doesn't (ab)use the "advise" terminology in an
> interface that will not only consume advises.

Ack, as per my other reply, will work up some pseudocode/API exploration (not
yet code) and mail it round to participants here so we can explore this idea.

>
> > >
> > > With Barry's series doing a prctl() for something similar, and a whole host
> > > of mm->flags existing for modifying behaviour, it would seem a natural fit.
> >
> > That's an interesting idea.
> >
> > So we'd have THP policies and Barry's FADE_ON_DEATH to start; and it
> > might also be a good fit for the coredump stuff and ksm if we wanted
> > to incorporate them into that (although it would duplicate the
> > existing proc/prctl knobs). The other MMF_s are internal AFAICS.
> >
> > I think my main concern would be making something very generic and
> > versatile without having sufficiently broad/popular usecases for it.
> >
> > But no strong feelings either way. Like I said, I don't have a strong
> > dislike for prctl(), but this idea would obviously be cleaner if we
> > think there is enough of a demand for a new syscall.
>
> Same here. I am not 100% sure process_madvise() is really the right thing to
> extend, but I do enjoy the SET_DEFAULT_EXEC option. I am also not a big fan
> of prctl() ...

Yeah agreed on both actually! :)

>
> --
> Cheers,
>
> David / dhildenb
>

