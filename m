Return-Path: <linux-arch+bounces-7098-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A8AE96ED40
	for <lists+linux-arch@lfdr.de>; Fri,  6 Sep 2024 10:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7CB9B21648
	for <lists+linux-arch@lfdr.de>; Fri,  6 Sep 2024 08:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D8C15665C;
	Fri,  6 Sep 2024 08:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RUYODZtZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CnBwi2S8"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A1A153835;
	Fri,  6 Sep 2024 08:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725610268; cv=fail; b=amCIWI29ZBPdUieIJemGTvsAtRHoHqp+gX+D9vKLkmekn12tkKlvw9AkEazyGJqYu2A3GXh6DVdli4lYxVtoPrclbEMCtwnWNFMXdwRmn9IDUgJYXh6v4UbhYWVrpspYSwvdgOtIpvMYZ24qjzlQNU3MtdIlhFw9R6fe+4IehbE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725610268; c=relaxed/simple;
	bh=KUQUYROvCQ/clJ5eQ9nJYD0sMyupJGSIFTgAXDvjupg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jG94hYEhPwyCbP2MoQpEAtRJ8M3WPrTS/6rhLt1e0aYi/a67SeZ6FUIeXqOaTQuqLwRCBaU1K9y0E6VsOyo0biwa53r3Sz28fgjzDmOolTgRpyPqONYOQenb4vOdiHuah4iBJjRf6H9lkYnOf7xqW221qgpag7qQ8aD9KzvFE3w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RUYODZtZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CnBwi2S8; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4863frAv032549;
	Fri, 6 Sep 2024 08:09:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=Cm7G4jufxBoV2AP
	fjQF1n7UETR0tQ2fV1g4gKiS/ZeM=; b=RUYODZtZ4A97L7ljPKw5z9Vo7/mDqr9
	kjHseMIMeh5Fo+Wf0IEs8pQ2h/X3baoqNY2ejjPQxa2cNuy5H16VplqcgUxRpiep
	4PhMlZqaz+IFbW82BrJ/OCNC2hhKlu+BsmiwY4zOQUBTcID1DugVy/uN8dR5b6fo
	fwtEKcdbG+GIKYZBEuwTMP4WhjdQQXwmDBRkTOsmouoSZOKnGzfwlH9oyw2go4P4
	cZ9lnM3xm2oUBMxMQNn5tC2G4jIcBZu+bHzxpNRCOkaQBuKYmOF4SbZgNutbucry
	/A72GX+ULOcjtf9mQwHFW4cu4tUntl3GBtgcTmxIaxc35RMnIdl/uFg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41fhwk91x9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Sep 2024 08:09:35 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4867HiUh000322;
	Fri, 6 Sep 2024 08:09:35 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2045.outbound.protection.outlook.com [104.47.55.45])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41fhybp5fp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Sep 2024 08:09:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=taUQjuEtcgQjRTUFomXQMv6Pkxi3fk0R3k+wmTrAHABsm63qdvg4friA7fLB+BCszhTwIwa0J9wHW18a80DMQ4Z8bGT0CydpaZngzIXugBuQIvzuRf9rb4NoKnx6C0We9FMqJjmDDUmRhF7tg7/F4UplaEyF8m9x4wnOJFExLx1gSrmlre14xeqGmHN3OOfCVyDxTOkdCw+gjUTvitJNE4k2ox7FAZg2wHJR4Sf31XxJA5pVoLC98BrkQuLj2bzgmYoAvm4DrRhRyeYz3aKPEca6FHTRXqxj+ME3yUS/AZp9sas4DeeiLGTfZSSX4aWix99xNuhcnKnXrIXTPR4E4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cm7G4jufxBoV2APfjQF1n7UETR0tQ2fV1g4gKiS/ZeM=;
 b=vf06GWFnrJLDB8AeunCfPsTW/TwSwAboHMsk3kSFGcruaWVq3nxQQVmVC53TVbaxURSSmtm0X32FxfnXKxFsFDh8Hm4qT4YxwSYLkrOePVrXAp9wjflNWVLHxpVDbPbV7+i5qKI8thV4ao6wCIE8U2/dvgkFbc7XP26YV+aDwZEImGcJOfFuNW9rDv5+jFgCljsiy8CmWL9q4d6W7Q1PtBB9I751n0cct38IqT1C6STgMBD8vcLbyvXOhOyWTdpYfPdExEtx1mRAcBmG9COiiv5PMojxC+IxPBay7wZfUyfxS9BgzQntaPjQhwCB9lfR80kjHOMc638qCnEiJHDXkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cm7G4jufxBoV2APfjQF1n7UETR0tQ2fV1g4gKiS/ZeM=;
 b=CnBwi2S8O3pHgFugPuiqeWn9ujVGMk0wnfIf61rhx5c0pgDSAj1L9ctb3ZR6WeS2o5xHmBpaCdfJgSA4gFjctk4kAgenvaLKGJIgT8a4hopsurHIpB3ocVF6ZumaKMsVuyWK5mL3suzGVW9BQiKR47hzYerPamoo61IpASX2ZHc=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by DS0PR10MB7432.namprd10.prod.outlook.com (2603:10b6:8:155::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Fri, 6 Sep
 2024 08:09:31 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.7939.016; Fri, 6 Sep 2024
 08:09:31 +0000
Date: Fri, 6 Sep 2024 09:02:48 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Charlie Jenkins <charlie@rivosinc.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@kernel.org>,
        Russell King <linux@armlinux.org.uk>, guoren <guoren@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Naveen N Rao <naveen@kernel.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "David S . Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, shuah <shuah@kernel.org>,
        Christoph Hellwig <hch@infradead.org>, Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Chris Torek <chris.torek@gmail.com>,
        Linux-Arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
        loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-abi-devel@lists.sourceforge.net
Subject: Re: [PATCH RFC v3 1/2] mm: Add personality flag to limit address to
 47 bits
Message-ID: <af6d9aa1-8b25-4f74-90ec-68791767db7a@lucifer.local>
References: <20240905-patches-below_hint_mmap-v3-0-3cd5564efbbb@rivosinc.com>
 <20240905-patches-below_hint_mmap-v3-1-3cd5564efbbb@rivosinc.com>
 <9fc4746b-8e9d-4a75-b966-e0906187e6b7@app.fastmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9fc4746b-8e9d-4a75-b966-e0906187e6b7@app.fastmail.com>
X-ClientProxiedBy: LO4P265CA0233.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:315::19) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|DS0PR10MB7432:EE_
X-MS-Office365-Filtering-Correlation-Id: 21ee1331-24b4-489f-af3a-08dcce4b3c8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0X5SFefHBI4D+Y1+A3WnzXV6/QM0R7FIe+iRpLVqQQ2BFnrp6/VsEUyZQVcQ?=
 =?us-ascii?Q?4kRe0JvsjxZoSyzERdumQT2d0eH+qJkMVEo3cN6okPuuvIW3jzSl9P33giEQ?=
 =?us-ascii?Q?zHZ7OPvrgL6YywO5T36x3tsEksAhCtqACIheH5FujeicvXMn5vlWUNk0T3f0?=
 =?us-ascii?Q?A8SIZfHtG1B34W0KZ0dfadLT8eb0F46zt+Xsxw7/Cy+4RlBbFY5pM7ghdSMq?=
 =?us-ascii?Q?W87k4pwweud+UcN5b+JX3c0vH9vyvMXdC5A4DrFnBz7SWs3R05LyEb0TYR8H?=
 =?us-ascii?Q?pNUiKJm22C90jrEv6jUNK/TgJ6mwPsJC8nbHLo9bXaWKCRj7wcYHpsyQlk5M?=
 =?us-ascii?Q?eL1f1ZIDCx+Z4xEs0mwM4LGpDOQKi8bmKz5nB4A0z5A153kkwwFkIkPiJ6xn?=
 =?us-ascii?Q?Xyf+Dtqf1OXqEX7hpsqAYLEvdki975jnET+r0YVu83FfX+fpao9qOMjsd8Kh?=
 =?us-ascii?Q?MfAL+rr5qEMrzm5eOCeoF5SB+ZNS+RYbcP84M88jHZjhSV6BDEKQC7u/oslV?=
 =?us-ascii?Q?m0END9zzjZU/XYqRcz1AoCh/+TKZHaYHlRcQT2bbwMpeY1ukrh27+KBKPXLV?=
 =?us-ascii?Q?5Ctl7ySGZtKKAtOCDjbc0pl78oSP1tQV01W6005hhgb3ftRbUjmc93XByqL3?=
 =?us-ascii?Q?1D9cKvSNSUBI9bLf9PMdr+V017XDwj7yTdKtSghkamuKKRk4oxUd6VvCY5uq?=
 =?us-ascii?Q?E3mUf6/qhAfz7plSkOz99iWVUs/ga84bQfoUcKep/ytwddwJuydmPpvhbcZ0?=
 =?us-ascii?Q?fhB3UHMH8Gob5k17IF//xlNM68hfI4JBkBvKerLX9K3KSistWriMi4i0UyEn?=
 =?us-ascii?Q?q4kVu0ChFEOVB6qc8Y5fYhJZts7FHb57zyPVaSXbdIED4/ssRC3d+uvsmdvL?=
 =?us-ascii?Q?AW3/2rSB3weAskRfBtnakqNMN7Gly2Xz3+8L+FlKtBL1LOXQNocXj8YXkNca?=
 =?us-ascii?Q?HDP8BM2WgiUzlJjv2isUs6ElvRKdWp5liLsty7nwI9i0oDhyI4jI4B1SoGeF?=
 =?us-ascii?Q?XeUmwLhMoSK/UDesk3z8mv6WcQl1X5QtjQGptB4l2pKZpa9ioV36obDHk3Og?=
 =?us-ascii?Q?qNwPH8N6mxaVL652Ir2v7OrBVNGELpVhCMfWV6r4uChuIDVcf0uyGmxPNC9/?=
 =?us-ascii?Q?3O/bZkB+fcHtKuKAy0Ghmu56az92OgUxgZmsb6O4gphdYlRhP/u1B4EjvF8J?=
 =?us-ascii?Q?Mv0sEAM0TAOqKC+SNPLTFzhtYh38jv/VVE2Egq+BeyCCUXNFjz/jeMHsMTqV?=
 =?us-ascii?Q?qSOzCDNdfinmVSiBRJwoWeqgeCNocwg2mvYw6VaU8WpdcXkVrYYLWAE/rvI8?=
 =?us-ascii?Q?QS8HBinh3DIedNc1ae6Ski46qaNvoJcBK2PRd0OkmA4NrA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dgyB4a4Y2hlHdKz4DqMf+bSimMo3TSmCu5kPW/k/HBQJYTbR8lDOjo0bSMKF?=
 =?us-ascii?Q?YKWcJnD8UQ1sLH7MDrosQWaQshwd/mQsjugEw7CyoRuafVRbZR1zxSXEuBmN?=
 =?us-ascii?Q?gXLCLicVmb6qN8gw7wV5NDFuXf6SYMAos9rrry2RuSY30RY/fAXLGDX43hqw?=
 =?us-ascii?Q?WnyAVCVFL9MAMpWzC8zN7eSB+IvIFJexGvRzToGv1SV+gpalb+udrHA8J8AV?=
 =?us-ascii?Q?ZVjqAgSYxTFEpIvCd2CrUNxmN0wkyDHGnRZwUWQexC24ZxDcT0c0xsFh8enU?=
 =?us-ascii?Q?w3g7wUBtWlhPfQxIScbxtP4eexWEmXTsAD5H3rRyqPAOTR3Gik9I34V99B6w?=
 =?us-ascii?Q?HqVkO4kiOQTbQqwYZfnjiU2pSqlNp3B80KRkuIZH3gh7650jIuWnvXhQka32?=
 =?us-ascii?Q?/i/aaTsCxqSUjS+n2rGMKPJ5biRVTW8F4ILO38nzAFPk0/6X0+CTQwRzvrvm?=
 =?us-ascii?Q?F7Kv4bCkyKmXYF9gb5tKGVqXZ3SF10Crbkc66MGp8bDMLnJNRYPsQUy2OAur?=
 =?us-ascii?Q?dqFMjzptnGTybGQd5QeyHAbGT5fgIpAG0Y7l/CpQVl99KkQyyhEkeekxFMtN?=
 =?us-ascii?Q?HGxN1WBVmS5A0OJgCR+Ikm7rfK5E8xqHzRwVThfrpzNfrKrCYQTE3m8iMCcc?=
 =?us-ascii?Q?28OoTfg9vQqiGPsiDJyhO/IyUwerdnIC6hAPrhL2tnpFKKIEf3ryGyvvWs33?=
 =?us-ascii?Q?IKZ1ktdWaxr739MGvkHPV+cX6oeR8FyIUGCbcAeInuX4UbOYlS3MPSv3l3hN?=
 =?us-ascii?Q?8V5dYoCE7kBDeS3bpU410KARNoBR8SG4VAwwpIqJ5LfwUnsp/6V3Azfg+zRZ?=
 =?us-ascii?Q?81Lln8wyhm4I8h+VywvDP6MLy1eXpqLZXrhqjxmEELu/7F+80GuQfFL3g8tE?=
 =?us-ascii?Q?1d/pHB3E0hyGvdPKl3YhJ3s6FLw+X949+pUWT2YpLIP3F0BvfzDDRLl2iZLE?=
 =?us-ascii?Q?DhAKsiCSxTnr0L+b3/23QNqKElZqSHe+q+ko6TMbpBLX97ObfnCXVSqf7hWf?=
 =?us-ascii?Q?l4Pc13OUR7H7JWrBxneODdI/zZn5AuKm+5HjfYyKYSuc66AE7BiIEzvZYs2A?=
 =?us-ascii?Q?IJEoh+GA/ycAvsgFaYaAhRl4QTHz4WYCE0txRcSzvl8++BmkhVoOtY5KWW3m?=
 =?us-ascii?Q?YFzN6QaWustpACNRF/YkI4B/nQPV1cRH8NZmIyfGUKxbVGNY625qZISrulDh?=
 =?us-ascii?Q?FYJJsVq/x1Di/PmOJlaIMNDUusVFJDaI8S75F50aWcR2XRtAgi7sMb2RLXnS?=
 =?us-ascii?Q?93Wb+m5m54FOPPSILIQ/AEQmAQ95NgNcqU2h4QihyO1dMFuJXBt13EoKq1Zn?=
 =?us-ascii?Q?Ob0SymKA7Yir5wF6eqRrF3gkU/3QcazyY3xJ9PLoIUXLAnbtmCI4SNJvGOFB?=
 =?us-ascii?Q?1F9bvSvO36xk1HikeeeSUeQK+Jg+QmFlu8+WQztQcCwdQS/+AtuHPuAPZQEk?=
 =?us-ascii?Q?OKG+LFX9Sg2keEwa2x3MW/2OYkgph8xgaphz5gJ1wjDagDuIW/sAj8QnBe6M?=
 =?us-ascii?Q?8mrW9FgtSc4Ojtg6bzr3C7pd8+KLxcsoP/Wc01QaUjiHKODA+MpyW41Hju/p?=
 =?us-ascii?Q?uiHVm5X+3iON0Hwh8Gm5WZLz2FS+tOnN2xn0L5r37Mcky1+Pd8lUToB4xDkk?=
 =?us-ascii?Q?XA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ONSmsIOWiYygRYBYWdnY8OqJncPWo4conkmEErOY0eDFVnTeDclN+dzizCoirl+xdEXa8Tn3UVYHEY1PaG0A4fHRMtY9rloTC9W2q44h3+jDa6F5/PkaA25VxMBttfvNj+ikORsEiETpd90bcyTapmpoic2Qg8hMhBlFWdjAVN451HfLoNWphkKkp9odv3QaY8I3mT0XoEwPx6y1ezLT9+W2ec1M0O5IMq6dTCJtMJC31G/5grGFEaLvu5Mp456PWEpIwvNG6iy3WchXkV5J3OwoCv3nvNavI3pRV3MiDavNYRAIDHv5KBn3kAUec+pioDVAugkFpqFwV95dJ3stx8sCEnKswekBSLdDZ9IqY+VPFz9/fT5qY1aEs16fUOIhysxUkFUewNkCjDS95uF4tuN0tTQR0D8hqzJpBgae7HEG2brdKAiZiTN6NGz2eNO9u2WWAcgGWFWv11+t4Y/5w8+3yFIoSA0iHH7Xw1ypFFsvtX9MkgNUhj+iVhs7xbSuFSiJp4QKdowNWe2Ju2pu4T2vv/j+Rz+gmnsmmviXSaezKh5dTdDJos6lytq0XaHxYeXdCh1B2ZUbhsHmAhbtAyA/MGdmfVDguLuhTw0ytNQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21ee1331-24b4-489f-af3a-08dcce4b3c8a
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 08:09:31.4687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9s73jYkzerbb6h3CHmq/B7YTV5IN+n1z+O7/A/6tkCvYb6OLlSxdd7W3tuvgRR1pdZ6GcRagfLyNotBXm1wqFGQ8KsAq8c29I+NnRBicS5k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7432
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-05_17,2024-09-05_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 mlxlogscore=883 bulkscore=0 phishscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409060057
X-Proofpoint-GUID: S6E32zhVE2Tc3a-ql_mzYMieZREipYA0
X-Proofpoint-ORIG-GUID: S6E32zhVE2Tc3a-ql_mzYMieZREipYA0

On Fri, Sep 06, 2024 at 07:17:44AM GMT, Arnd Bergmann wrote:
> On Thu, Sep 5, 2024, at 21:15, Charlie Jenkins wrote:
> > Create a personality flag ADDR_LIMIT_47BIT to support applications
> > that wish to transition from running in environments that support at
> > most 47-bit VAs to environments that support larger VAs. This
> > personality can be set to cause all allocations to be below the 47-bit
> > boundary. Using MAP_FIXED with mmap() will bypass this restriction.
> >
> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
>
> I think having an architecture-independent mechanism to limit the size
> of the 64-bit address space is useful in general, and we've discussed
> the same thing for arm64 in the past, though we have not actually
> reached an agreement on the ABI previously.

The thread on the original proposals attests to this being rather a fraught
topic, and I think the weight of opinion was more so in favour of opt-in
rather than opt-out.

>
> > @@ -22,6 +22,7 @@ enum {
> >  	WHOLE_SECONDS =		0x2000000,
> >  	STICKY_TIMEOUTS	=	0x4000000,
> >  	ADDR_LIMIT_3GB = 	0x8000000,
> > +	ADDR_LIMIT_47BIT = 	0x10000000,
> > };
>
> I'm a bit worried about having this done specifically in the
> personality flag bits, as they are rather limited. We obviously
> don't want to add many more such flags when there could be
> a way to just set the default limit.

Since I'm the one who suggested it, I feel I should offer some kind of
vague defence here :)

We shouldn't let perfect be the enemy of the good. This is a relatively
straightforward means of achieving the aim (assuming your concern about
arch_get_mmap_end() below isn't a blocker) which has the least impact on
existing code.

Of course we can end up in absurdities where we start doing
ADDR_LIMIT_xxBIT... but again - it's simple, shouldn't represent an
egregious maintenance burden and is entirely opt-in so has things going for
it.

>
> It's also unclear to me how we want this flag to interact with
> the existing logic in arch_get_mmap_end(), which attempts to
> limit the default mapping to a 47-bit address space already.

How does ADDR_LIMIT_3GB presently interact with that?

>
> For some reason, it appears that the arch_get_mmap_end()
> logic on RISC-V defaults to the maximum address
> space for the 'addr==0' case which is inconsistentn with
> the other architectures, so we should probably fix that
> part first, possibly moving more of that logic into a
> shared implementation.
>
>       Arnd

