Return-Path: <linux-arch+bounces-6727-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52EFB962FDD
	for <lists+linux-arch@lfdr.de>; Wed, 28 Aug 2024 20:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03B71284DF6
	for <lists+linux-arch@lfdr.de>; Wed, 28 Aug 2024 18:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84861A7AE3;
	Wed, 28 Aug 2024 18:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="a421hkuO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aOT3NsVH"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62138156997;
	Wed, 28 Aug 2024 18:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724869300; cv=fail; b=u75XKanu7USzpEAbmPDYbk4IDy+OB7caNPjgKa98RAwx9v/uYCZp67ow/FoL1aZKj1Knfoc6X043I5jlikvtZ9fkCNABz1DOamiZT++MmOYSXxsNc5LAGj/YLh/7wl0lPGkPI3TZNa959uar3YKnUoKMt6pDN53PWiTPTcx4j7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724869300; c=relaxed/simple;
	bh=uRlkO1tA+cccY8ls1JVetzeRMCE/rIqw4yQv365F3hg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oEQycBCI0MZw65L3p4jTw75Bozfc6D9EtayRNO5thzFe50gxsqL2GXBIfa0yo09pwijyGUVKRRHV7+P4QSzVCCuJmQF/yjUf3J/8A81taBndXY2R06O78g5V1n8nwSKiiAXS7VRicIKvBH9Etq3ApUuPy6swVUqYv5s1+cAcDAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=a421hkuO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aOT3NsVH; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47SHfUKD016673;
	Wed, 28 Aug 2024 18:19:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=VZxvPOSfXTNaI+J
	KRN5dmgtLnHpwdW0zRNwIgz5BYwU=; b=a421hkuOSPmIY002FZHq3StnMZFe5Zz
	zwpE3idA3tq0/grq7pVPPtBpWDI4eH32DyOKJNfuijXStkTDMMFBnUi3wfsQMRrr
	bBb7ANY/zwJ4f+3PEOuT2Xsum35gXNtzWGjxJzJB4ySs8Sk+zGhqHg8Ep04Hfe/w
	o7uELz/4/Kj9s2W4gV/iDk19Fj/Zxf6kEZ8Sl7N1TqGkYq+ZKHzHIUCIycdGYWfC
	ji1G2kU3pICOf9duYyNFJJaxhqKbiyr+doTBryB4074Xe+5jC0OahygyQ8Pw1oUu
	9o2vN51FOowV7/VZcRvJzAN0vTT1n073N5KurIf2onXEzCYwi6OKuBA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 419pugt2gt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Aug 2024 18:19:52 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47SGan2o035057;
	Wed, 28 Aug 2024 18:19:44 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4189suvss8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Aug 2024 18:19:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BVjusITUu8qblGMrOgXlXibv0Nq4JGS9aKe0gjMKbLaGYCvjL/sdJ6MZ4Gv7rU6eQkMqlUVmz9zp7V1+OJaE/50C0jT2G7YOQmekjBcSInMwunObImGDNGRHEG8eNNIok5lPHT6hv+BRXvB1L0FmkFBAmdpZwr2k2UWp4MgXBM3QOiQpUxozexm9VCTISv/KW6/khlEsC9fcG0GrAMo159600Ah6i+jp4zEb8cWpdTafafe8ezPxAdKtLu2t+yz6d1w217qbaayYxJTklokKF24YVcyQCqxFVolFRANrly+rxvCwCHAfEoA7G04KDeLqbLSzRpJ6QFoKoGG+2zd+tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VZxvPOSfXTNaI+JKRN5dmgtLnHpwdW0zRNwIgz5BYwU=;
 b=Ooa69cTusO4BTQMz43ZUJqrep5tSw56eK0/koi9tnB7A8C5LRzJrWei7X3usvHmNUh7YgHvb1I5xG+0hlbclMDjMskZrloVWVyLYKTpCsiUEYRFlWkXcbuHvjV19ZxHeJA2sdy/cD+qwkKUdEW6852hqkjpSA/N1QV1/uWAIODtNQhZqkqXfzjctyJNuDMxxnpnMs/guyFNZ4Dz2cbNjFosPvMTs3miMpTxxD60n6SOVJybwlyrzB+UP13Cu9A88uhP1gEr6IHbg/SjhFpM60d5Ha8PNHhrrxkhPmFFwu3xWKFMKvY6eplVTS9m86AnN6OUBGfHag4R7gU/APLrQMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VZxvPOSfXTNaI+JKRN5dmgtLnHpwdW0zRNwIgz5BYwU=;
 b=aOT3NsVH6yKmK1lWWkHJEMCMfKCdknAnXoq32esZksK3VKxYB8q4uhCKlHoiV89sOzlK5HdC0TIbIn/1lDUxV5A5P/CFTEWVEi6r7MocSQChNAEndxSPxlkcx8+wsNU4x+YwMiR9N00b2WBCG69i3ACUhvvJ+O+nYRKLLfKn110=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by CH2PR10MB4328.namprd10.prod.outlook.com (2603:10b6:610:7e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.19; Wed, 28 Aug
 2024 18:19:40 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.7918.017; Wed, 28 Aug 2024
 18:19:40 +0000
Date: Wed, 28 Aug 2024 19:19:36 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Naveen N Rao <naveen@kernel.org>, Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>, Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "David S. Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>, Shuah Khan <shuah@kernel.org>,
        Alexandre Ghiti <alexghiti@rivosinc.com>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
        loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 00/16] mm: Introduce MAP_BELOW_HINT
Message-ID: <2570b1ea-d2a4-4bcb-9bb3-8d979657c56a@lucifer.local>
References: <20240827-patches-below_hint_mmap-v1-0-46ff2eb9022d@rivosinc.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827-patches-below_hint_mmap-v1-0-46ff2eb9022d@rivosinc.com>
X-ClientProxiedBy: LO2P265CA0277.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a1::25) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|CH2PR10MB4328:EE_
X-MS-Office365-Filtering-Correlation-Id: e05102ad-382d-47c5-9242-08dcc78dfb2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?h9Bwh+5CyCo/7d+hlYnFzczbfYTh7eao2pufQJyT13VLIVQzk/NlUIzYDTO6?=
 =?us-ascii?Q?PqQwSnIvuJ6ICjp5WwDelhEP8YALtnZk/3nk2po9uP8kH1a0uIeZed6QytoH?=
 =?us-ascii?Q?N3SGavdayR2pA8MrSVUJvEio1PYsEfPNMUQ3RXPU+vJUpBQOrDvzt+YXehnx?=
 =?us-ascii?Q?Pt3m/bBCcG2FrqVf1gslgD5vpC6IBJKd6yoJnjyrkP2gMtZo04xc1P7v0WO9?=
 =?us-ascii?Q?Sbw2aiYk3c4wulgc3UH5PUDUhrxUrTobn+gyOG3mWq3AL6cdVUU3QA4L6TEL?=
 =?us-ascii?Q?FjfQGQvehCYkz0i1dwMHzhJwu6RQaF+rV9OzO42TMg+ItbYqfPi5BxFMvSBc?=
 =?us-ascii?Q?qUr/V33oD5MBDq58y2ruJZFyrsYCjvVkPRwPeYSPAsrzLmbTPkGLP/ymQGPS?=
 =?us-ascii?Q?GBKCydjc0UGG0Tr32WR2kSWXo/4N5jhTUfsIN8V9JGBPDuXJYnZ4eoMRFl5M?=
 =?us-ascii?Q?HfpT+PdX3tuU4ESZ4PlC6G+HC9xitYFV/Bz+SOYwq7wCIucq3PeffndkCu3T?=
 =?us-ascii?Q?ivUBB1iX3kcUjnGwbE5fFOnXL+NXe6ST+nRJeKnfip70LcVruIIOtI4QXhtj?=
 =?us-ascii?Q?GgXgvJxpReXnwTr0zYiQwtDWZqs8XxNL0ldHqahOnrPk2en2J5xeJJ1Pg4Zo?=
 =?us-ascii?Q?XPnITxbmLAcJrMcKm+vePdO7IxQh6xocSw/LtitSbsITVYiiv4QvIS+w+pEf?=
 =?us-ascii?Q?Xr6l1n/ZTz/9xGPXDf14JNNFc5uOPBcYEDprYXbInABL1Ix3IRFs8V15Ro0n?=
 =?us-ascii?Q?XHXP5zzJ16efbXUglDI7z+LJRr+Q8fVdVESCybWEto/hpbP9RHmHKErFF1qr?=
 =?us-ascii?Q?IA1WhGrlWx1DrH7j015ZJCpYCaE8e09gdpPMHa8E5V6Kk/4964eazzw7vHxK?=
 =?us-ascii?Q?maZ6nMm+e0Z0glOIgX/VpnVLK+0W+w2AAQEBT6S05Q9RueOU5MzqhlzRSFt8?=
 =?us-ascii?Q?9KfTgUX187tLl1ia959b9+JIAF+2mBDrDbI84cJWm9i5toHWMsKJR1N9Abfc?=
 =?us-ascii?Q?gKzyBeWZQ3+U2hNvWQEhcLNGNG9C2+HcqCI5iJ9qK4IBWJLm3jNtYRoB8PXO?=
 =?us-ascii?Q?TDLSS5sm1ZrykY4MxvO+L88KHguW+jaccV/aSjltPbY7pFQN7CeT4UduU7h4?=
 =?us-ascii?Q?fPSKDBzoP7jAxfNQa9BR6cfInU2yq8Q27HiT4MVhIBPmxAYbduLucqdmwkBM?=
 =?us-ascii?Q?0f/6jDpgPgiSldGYlB+D3miXWm2d8jV248SJGlAzvKbHEPiv+usz30E4TdSe?=
 =?us-ascii?Q?2GP8ZU74/LJvYU5JJP8VEBLJBDkDFhIAOcdr7Kg4X239xhs2x2nCYWyHk7Wb?=
 =?us-ascii?Q?uSw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+1EEe+dvbVKbyqp84+X9Co5zlItBils64pI27ncE/VjwhEbv4MvVHNYU+7bY?=
 =?us-ascii?Q?nReKGSzLJ4ZPogQbMEM4d9PV+HYPHhS0FoWLckEiLKwvYafOBIlQ6Y2vSFPu?=
 =?us-ascii?Q?b8MOWrtTgzxYV8iqVA6etuFZiv2oEEVD4PiTFCYDL1cJC/dOcQj2oSOe16mN?=
 =?us-ascii?Q?VD2gYXgKRsT7N2ZD7AD/bz0yWEMaoSgTWpSL0GqQSYXcb8olWAdK/8HHTfHP?=
 =?us-ascii?Q?F3VQ0HHEV4bx9l6pCVFtX/OZph286ZNLepVtBjiFvqs+tY5AE9sJrq5sdlwE?=
 =?us-ascii?Q?GvWkV6cEjMoGh4YNiWzmdmatXPaSNcx3/1bsLMD5XR24pBP2VvzkwCA5BH2Y?=
 =?us-ascii?Q?e9SUYpkqdTgPmmbViJlTyaBWXa8FrLt7F9NMpYwd258nUlJQ++EC8rOMBgT/?=
 =?us-ascii?Q?sXId6WHC+1DKtcGmhQPuRV6ifuNNxmzy6JYu0ZoC99gsvHDR2joyAxdwkbX9?=
 =?us-ascii?Q?tX9F01tFakD8kncISXVL49IHi8w/BekFF3+RFQh0Oe23Ma/XxAU6UXW123dQ?=
 =?us-ascii?Q?DISFUBiEBSF3gtjQzTBvkIso/tyOaWa0dZYEAtOk9+9N4BMFCwz/uJ8Gf9LX?=
 =?us-ascii?Q?GF9MTSrPj63tkUrOCBCye1FeM0TlcMxUdWGP6iYz3JElQTGVfJYF+uSeNmiH?=
 =?us-ascii?Q?zUVGEq3G8LBbTVRMoWl5MgweRCiYnDjhCLkt9oMqQTZoJoz5/lalCaQsRu2z?=
 =?us-ascii?Q?DBND4+cUfRD1Dii+c4VrqMrfRXRtDh9Ep7DigWdijh2KV1h20ggtG5EWGSq3?=
 =?us-ascii?Q?48jsoYnSb1UAn1t9C8MdNPh3wFuNx/bHKRgFawFxkjagkfCopqSQly0H4KXN?=
 =?us-ascii?Q?fug5J+WMcc9lNuc65lUNDK/u8JZj53NmKXHdaog/eM9zKVdqrcGW7hMLoNJP?=
 =?us-ascii?Q?U7E7Ls2/sO74XcHIAnHlGCenk7IPjJg4SL0KoK/1z/eNrYNr0VRYSZ5SgQpA?=
 =?us-ascii?Q?Fbr5pL88F3Wn87+ZLAgL8mMP4XXqwTVuYkWTpPv3cH3qiHdH/1KLzI5+u4KE?=
 =?us-ascii?Q?R7gGybSucj/a0IvRLT8z6dgWbCfjYhMTr2FGV3OHUp7c9y2qbUZ6eAYikvHc?=
 =?us-ascii?Q?XrVm6QMeD13O3LBfc646lD8I/N3Vrt3UahPgI9icbVI6DKUnNjIj5ED42ovg?=
 =?us-ascii?Q?7V/4cYxaMNvENigsULUs2wLy1GofUaAcBel+8GtQZhAGM3lEMlc8vtG4EbnX?=
 =?us-ascii?Q?ecUJibVynWbNctq4GWAj830KpmeWbSO5L/4Syym27ej4jFE9D6exM/iNs3pJ?=
 =?us-ascii?Q?+wRNOH5wDQcifknRgNC5SA6xQaqBf+BmLiwC2kr2ifmjwgfstf++RD5qeTPz?=
 =?us-ascii?Q?U/XSGUuM4jfbpY4qjlWfie1D7SixDfMhfcF/rG+ydFIon6QpdGHShunyjgbr?=
 =?us-ascii?Q?BCBm6wev1U4p2NJJnvwxl3p1NlBzLKPlpvU5T2M2/zbqAQk3JHbn5sNCvSca?=
 =?us-ascii?Q?ZH135k8xT4CTIkOQmkhyc1K786Zj2gB8z295fBV1mUD1jIikIEwDKLmKtq1L?=
 =?us-ascii?Q?wJDoYuS3jBpb7EZ+lOptcmYMMQcE2lTbtwvcae81twgE1ZYfMdnTeerJfPgC?=
 =?us-ascii?Q?8lfKk3iXXsPzSMPPPNBqpD275EUWPEjd4jitNE7iVuinWmARK0097XHvdW07?=
 =?us-ascii?Q?bw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mEl8fuq4VdtNMDB+MdFj/osh3pASI3kdsIgtk14MBjUA1L0X7croAvSMqSw3OG/u1NSF9EjqvSj+U7L/zeiNZbOxrhPIqlAZJbtmoPt6xLtLQU0QgpDWP3vWmz6K6cTqalkg13ucjxaZz0y1cbJVlHPQv0MZb4jLPAgBbPIH0yD+4jeRmkB2Bs9rXIUGfwmlQJBQTsboF7NDelNCjoQn6ag+F/1JuGbaMwKdWtiEaFS3dT6ALFTEuVjNwxWizqIXFTg79cQsw4vC4tUUK5xGrPvC+G7YHgC8mBTIoiZveeg6K9SqxQ7ZtkfNALiOqcZPLwmXX2UC1apDZF44weCz4zu3/zPVbsMWc/Wm90JREaxEc5xxPURwphNX8ci0UaH7Twv4Yramtq+uXvacQIHUWWxaK+g9PBxG72PrwupV8ZTYeVhdTVIzZ68nJ7Op56yCtoK22QrRgoHNifz4B2jATEcZoFgMqiw7VjZF20wUvygtTf9v31arNN2YG7IAJQ3o4zStu0i/9flszfGjLMA+xHPGiqkZfZU+nB35o+NPeerb2MV0jZxWGsCV0pYvThHQRKRU5NiH2Y2myidv97rcgaQETyMGnaUpkN0IzHPiPsM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e05102ad-382d-47c5-9242-08dcc78dfb2b
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 18:19:40.0774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fCXQG9vpDZti0R4B1uQdF0OPq+dKWvDdkaQFcQGHkSGJEoa/kJF+C2olJZparT/vLDhgMfY2y9VnNoQ2qQxUAgDEDlkv75RzrmvpEdQ9go4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4328
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-28_08,2024-08-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408280133
X-Proofpoint-GUID: NvgtYYx7-t4bJL95ZESXg4r_1H8G4njA
X-Proofpoint-ORIG-GUID: NvgtYYx7-t4bJL95ZESXg4r_1H8G4njA

On Tue, Aug 27, 2024 at 10:49:06PM GMT, Charlie Jenkins wrote:
> Some applications rely on placing data in free bits addresses allocated
> by mmap. Various architectures (eg. x86, arm64, powerpc) restrict the
> address returned by mmap to be less than the maximum address space,
> unless the hint address is greater than this value.
>
> On arm64 this barrier is at 52 bits and on x86 it is at 56 bits. This
> flag allows applications a way to specify exactly how many bits they
> want to be left unused by mmap. This eliminates the need for
> applications to know the page table hierarchy of the system to be able
> to reason which addresses mmap will be allowed to return.
>
> ---
> riscv made this feature of mmap returning addresses less than the hint
> address the default behavior. This was in contrast to the implementation
> of x86/arm64 that have a single boundary at the 5-level page table
> region. However this restriction proved too great -- the reduced
> address space when using a hint address was too small.
>
> A patch for riscv [1] reverts the behavior that broke userspace. This
> series serves to make this feature available to all architectures.

I'm a little confused as to the justification for this - you broke RISC V by
doing this, and have now reverted it, but now offer the same behaviour that
broke RISC V to all other architectures?

I mean this is how this reads, so I might be being ungenerous here :) but would
be good to clarify what the value-add is here.

I also wonder at use of a new MAP_ flag, they're a limited resource and we
should only ever add them if we _really_ need to. This seems a bit niche and
specific to be making such a big change for including touching a bunch of pretty
sensitive arch-specific code.

We have the ability to change how mmap() functions through 'personalities'
though of course this would impact every mmap() call in the process.

Overall I'm really not hugely convinced by this, it feels like userland
could find better ways of doing this (mostly you'd do a PROT_NONE mmap() to
reserve a domain and mprotect() it on allocation or mmap() over it).

So I just struggle to see the purpose myself. BUT absolutely I may be
missing context/others may have a view on the value of this. So happy to
stand corrected.

>
> I have only tested on riscv and x86. There is a tremendous amount of

Yeah, OK this is crazy, you can't really submit something as non-RFC that
touches every single arch and not test it.

I also feel like we need more justification than 'this is a neat thing that
we use in RISC V sometimes' conceptually for such a big change.

Also your test program is currently completely broken afaict (have
commented on it directly). I also feel like your test program is a little
rudimentary, and should test some edge cases close to the limit etc.

So I think this is a NACK until there is testing across the board and a little
more justification.

Feel free to respin, but I think any future revisions should be RFC until
we're absolutely sure on testing/justification.

I appreciate your efforts here so sorry to be negative, but just obviously
want to make sure this is functional and trades off added complexity for
value for the kernel and userland :)

Thanks!

> duplicated code in mmap so the implementations across architectures I
> believe should be mostly consistent. I added this feature to all
> architectures that implement either
> arch_get_mmap_end()/arch_get_mmap_base() or
> arch_get_unmapped_area_topdown()/arch_get_unmapped_area(). I also added
> it to the default behavior for arch_get_mmap_end()/arch_get_mmap_base().
>
> Link: https://lore.kernel.org/lkml/20240826-riscv_mmap-v1-2-cd8962afe47f@rivosinc.com/T/ [1]
>
> To: Arnd Bergmann <arnd@arndb.de>
> To: Paul Walmsley <paul.walmsley@sifive.com>
> To: Palmer Dabbelt <palmer@dabbelt.com>
> To: Albert Ou <aou@eecs.berkeley.edu>
> To: Catalin Marinas <catalin.marinas@arm.com>
> To: Will Deacon <will@kernel.org>
> To: Michael Ellerman <mpe@ellerman.id.au>
> To: Nicholas Piggin <npiggin@gmail.com>
> To: Christophe Leroy <christophe.leroy@csgroup.eu>
> To: Naveen N Rao <naveen@kernel.org>
> To: Muchun Song <muchun.song@linux.dev>
> To: Andrew Morton <akpm@linux-foundation.org>
> To: Liam R. Howlett <Liam.Howlett@oracle.com>
> To: Vlastimil Babka <vbabka@suse.cz>
> To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> To: Thomas Gleixner <tglx@linutronix.de>
> To: Ingo Molnar <mingo@redhat.com>
> To: Borislav Petkov <bp@alien8.de>
> To: Dave Hansen <dave.hansen@linux.intel.com>
> To: x86@kernel.org
> To: H. Peter Anvin <hpa@zytor.com>
> To: Huacai Chen <chenhuacai@kernel.org>
> To: WANG Xuerui <kernel@xen0n.name>
> To: Russell King <linux@armlinux.org.uk>
> To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> To: James E.J. Bottomley <James.Bottomley@HansenPartnership.com>
> To: Helge Deller <deller@gmx.de>
> To: Alexander Gordeev <agordeev@linux.ibm.com>
> To: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
> To: Heiko Carstens <hca@linux.ibm.com>
> To: Vasily Gorbik <gor@linux.ibm.com>
> To: Christian Borntraeger <borntraeger@linux.ibm.com>
> To: Sven Schnelle <svens@linux.ibm.com>
> To: Yoshinori Sato <ysato@users.sourceforge.jp>
> To: Rich Felker <dalias@libc.org>
> To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> To: David S. Miller <davem@davemloft.net>
> To: Andreas Larsson <andreas@gaisler.com>
> To: Shuah Khan <shuah@kernel.org>
> To: Alexandre Ghiti <alexghiti@rivosinc.com>
> Cc: linux-arch@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Palmer Dabbelt <palmer@rivosinc.com>
> Cc: linux-riscv@lists.infradead.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-mm@kvack.org
> Cc: loongarch@lists.linux.dev
> Cc: linux-mips@vger.kernel.org
> Cc: linux-parisc@vger.kernel.org
> Cc: linux-s390@vger.kernel.org
> Cc: linux-sh@vger.kernel.org
> Cc: sparclinux@vger.kernel.org
> Cc: linux-kselftest@vger.kernel.org
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
>
> ---
> Charlie Jenkins (16):
>       mm: Add MAP_BELOW_HINT
>       riscv: mm: Do not restrict mmap address based on hint
>       mm: Add flag and len param to arch_get_mmap_base()
>       mm: Add generic MAP_BELOW_HINT
>       riscv: mm: Support MAP_BELOW_HINT
>       arm64: mm: Support MAP_BELOW_HINT
>       powerpc: mm: Support MAP_BELOW_HINT
>       x86: mm: Support MAP_BELOW_HINT
>       loongarch: mm: Support MAP_BELOW_HINT
>       arm: mm: Support MAP_BELOW_HINT
>       mips: mm: Support MAP_BELOW_HINT
>       parisc: mm: Support MAP_BELOW_HINT
>       s390: mm: Support MAP_BELOW_HINT
>       sh: mm: Support MAP_BELOW_HINT
>       sparc: mm: Support MAP_BELOW_HINT
>       selftests/mm: Create MAP_BELOW_HINT test
>
>  arch/arm/mm/mmap.c                           | 10 ++++++++
>  arch/arm64/include/asm/processor.h           | 34 ++++++++++++++++++++++----
>  arch/loongarch/mm/mmap.c                     | 11 +++++++++
>  arch/mips/mm/mmap.c                          |  9 +++++++
>  arch/parisc/include/uapi/asm/mman.h          |  1 +
>  arch/parisc/kernel/sys_parisc.c              |  9 +++++++
>  arch/powerpc/include/asm/task_size_64.h      | 36 +++++++++++++++++++++++-----
>  arch/riscv/include/asm/processor.h           | 32 -------------------------
>  arch/s390/mm/mmap.c                          | 10 ++++++++
>  arch/sh/mm/mmap.c                            | 10 ++++++++
>  arch/sparc/kernel/sys_sparc_64.c             |  8 +++++++
>  arch/x86/kernel/sys_x86_64.c                 | 25 ++++++++++++++++---
>  fs/hugetlbfs/inode.c                         |  2 +-
>  include/linux/sched/mm.h                     | 34 ++++++++++++++++++++++++--
>  include/uapi/asm-generic/mman-common.h       |  1 +
>  mm/mmap.c                                    |  2 +-
>  tools/arch/parisc/include/uapi/asm/mman.h    |  1 +
>  tools/include/uapi/asm-generic/mman-common.h |  1 +
>  tools/testing/selftests/mm/Makefile          |  1 +
>  tools/testing/selftests/mm/map_below_hint.c  | 29 ++++++++++++++++++++++
>  20 files changed, 216 insertions(+), 50 deletions(-)
> ---
> base-commit: 5be63fc19fcaa4c236b307420483578a56986a37
> change-id: 20240827-patches-below_hint_mmap-b13d79ae1c55
> --
> - Charlie
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

