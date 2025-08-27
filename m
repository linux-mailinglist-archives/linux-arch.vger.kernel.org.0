Return-Path: <linux-arch+bounces-13294-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 078A8B37A66
	for <lists+linux-arch@lfdr.de>; Wed, 27 Aug 2025 08:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B973E1733B5
	for <lists+linux-arch@lfdr.de>; Wed, 27 Aug 2025 06:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5BC35966;
	Wed, 27 Aug 2025 06:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QfdqdIQm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qb15iSFh"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786FF21CC61;
	Wed, 27 Aug 2025 06:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756276311; cv=fail; b=lLoMtBkeGLvzt9fT8wVwL51MsfX2DKWj9SN5Lq0VsxEofr0x0xNZGkXhy4CxB/S1BQVP134SQ/z/UI/dDTYtpygTxd/a5jtlISrnESAtOH/yC36PAQxawPNeoGAt1eKEGVcxArj70T4Ro9HITkAyHKuwaJS5ltBiyDmGY0QKXUc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756276311; c=relaxed/simple;
	bh=kJuux2vNoWA0fsDzYp9dSTkvx0Ufp2cUhN/BW8R8NUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lTGBsqSAYuHoyFlnkUM4XOFgVwvblAfCIZ+RpS324cs7MijcmqLJj8Kdo3Blwe512JZBYkgWy6/Hm29iOKtMxYyytd34H8YWepp4U3Tit6CF+pj93XGc8s+ROAEwrqG078SycmKyJQhQ9ebelp35OuNcRMO2dab5Cw659EJwaL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QfdqdIQm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qb15iSFh; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57QLLQFr003669;
	Wed, 27 Aug 2025 06:30:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=Eor+7R+cAGTW/o2ZRl
	rgf/H4CLZNB9Yto7x7CGwBY28=; b=QfdqdIQm6XI0Xb1EzmG7gmsbbnFu5A3ZAK
	g6fXxKAbFmSNaGFNasqt1ozTy4KryAQYnjCMoYrk8rcoucgBsBrrzV5VYSOCI8vz
	jrgh+qAfGlbSbGRt+Wl60WM5u2wP7nuaqcgzjl0kr+KxandV9iYQq9OIp0SJoe8j
	pkemNrPonuSn58CVdYYtFOOWDsp9MQI7LJ3F99I9w5CD2a+4wv0urQ9EBALcE9/K
	FYwFBNCw2RMKqqGbOySy3e6n8k4aSGn7LdwI2zyyP0Z8pi5SqX/JwmJhts+2T/3d
	ie0xS3MRAPLCeRHSol3do5xNC4YOr9rperf3g+Pb+O9Gc4UCGwpQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q48enxy5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Aug 2025 06:30:35 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57R30E7C012242;
	Wed, 27 Aug 2025 06:30:34 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48q43abybu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Aug 2025 06:30:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ix9epBCA3KCdnrMkXyz4vvO2gngBVdRb3//9PsOxfJJ5Qh/aQJ+CF1uuVYdUuq0qaeNn6H0r4847xaNRyQK72EqJNCMPtapY6rGqFQMEMYdLAxVAmpMoCxi4oLoBFyV7Hji6P+zGRADnynMZAOwYk/E0HbCtV0fpbNH2WU+E7GtzYGDDTWDKaLWkLJlCq2DLuyPvVQHhlneNZUc/F6A5ibiwlBw/pA3uhWACLS3vNasSt9ga8Noe2ePE6TqRk6CovsAIctRwVbpp+8i4PocckfnHYMe5CFl1X5ruDy/Hup74giSOhDyk8STbQRaIoyheMqilou4+exupv6m1vqfdsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eor+7R+cAGTW/o2ZRlrgf/H4CLZNB9Yto7x7CGwBY28=;
 b=kUn0jn3E+0b5DGjBNQs+lY+2shyGte6XdUlqO3jdjgXoK4YLCmIEs9+3oT4q+Hvv5HU/lJntebh+LA2jdEiRYkJT58etSAM4xB5RY72JuOyvyx2uaeHZkQGN0OR/SKH4IE4heXSXJN9lqz+WooXKBC3NRGBP7CLkMhJ3wt141qJU6rIrmZ0aYfsGpHJnX5h0uBe0KMprti/4KMFs8zECrWyz+x7kxajZpwca9A8RQ0cG2ZgLB+nEfuIREdErN+8GQ8GEPAketV3+e1AdiRYl1ag99WWPkECkhvp8ZR6tXjV0qMX90oS7lh6M6LtC1z8+4DWXbMDA+3HgDxlR+PGaCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eor+7R+cAGTW/o2ZRlrgf/H4CLZNB9Yto7x7CGwBY28=;
 b=qb15iSFhSiHgmDc5JGjFkQiJ5UKY3gr690U5VLHSo1221HODh3egceXv2Nx8w57A67GrYXBfFwF413V9beQbTWIDyLG6CFImVsKxZcy49eRr6r2bQbrLkVHM+eNcE2dksLKYHMiHTbQDuTifEEAZeopSvL64uO5tlxkO9s/xmzY=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by SA1PR10MB7662.namprd10.prod.outlook.com (2603:10b6:806:386::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Wed, 27 Aug
 2025 06:30:27 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.9073.010; Wed, 27 Aug 2025
 06:30:27 +0000
Date: Wed, 27 Aug 2025 15:30:11 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Dave Hansen <dave.hansen@intel.com>, Liam.Howlett@oracle.com,
        akpm@linux-foundation.org, andreyknvl@gmail.com,
        aneesh.kumar@linux.ibm.com, anshuman.khandual@arm.com,
        apopple@nvidia.com, ardb@kernel.org, arnd@arndb.de, bp@alien8.de,
        cl@gentwo.org, dave.hansen@linux.intel.com, david@redhat.com,
        dennis@kernel.org, dev.jain@arm.com, dvyukov@google.com,
        glider@google.com, gwan-gyeong.mun@intel.com, hpa@zyccr.com,
        jane.chu@oracle.com, jgross@suse.de, jhubbard@nvidia.com,
        joao.m.martins@oracle.com, joro@8bytes.org, kas@kernel.org,
        kevin.brodsky@arm.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        lorenzo.stoakes@oracle.com, luto@kernel.org, maobibo@loongson.cn,
        mhocko@suse.com, mingo@redhat.com, osalvador@suse.de,
        peterx@redhat.com, peterz@infradead.org, rppt@kernel.org,
        ryan.roberts@arm.com, stable@vger.kernel.org, surenb@google.com,
        tglx@linutronix.de, thuth@redhat.com, tj@kernel.org, urezki@gmail.com,
        vbabka@suse.cz, vincenzo.frascino@arm.com, x86@kernel.org,
        zhengqi.arch@bytedance.com
Subject: Re: [PATCH v2] mm: fix KASAN build error due to p*d_populate_kernel()
Message-ID: <aK6l81c0rWe7YGRz@hyeyoo>
References: <20250821093542.37844-1-harry.yoo@oracle.com>
 <20250821115731.137284-1-harry.yoo@oracle.com>
 <3976ef5d-a959-408a-b538-7feba1f0ab7a@intel.com>
 <aKfDrKBaMc24cNgC@hyeyoo>
 <2fb52098-3952-48f1-b6c3-bbc95ce00d8d@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2fb52098-3952-48f1-b6c3-bbc95ce00d8d@gmail.com>
X-ClientProxiedBy: SE2P216CA0036.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:116::18) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|SA1PR10MB7662:EE_
X-MS-Office365-Filtering-Correlation-Id: 54d8001c-ffa9-48d7-a3db-08dde533360f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NjVeSx22vtrQAW20YeRfaE7S1xN9ey/X7nTjfLzsiYFILo4lww8kSgy791Kx?=
 =?us-ascii?Q?QMbsSOg+sRulFFdryntOz4X/L4f81r0tDx1hWke1K4WoKjaq6XyT6ILgEZsM?=
 =?us-ascii?Q?ur1Qq1xhPVhCt4KzrbFwvSBWVPGKkA7JB9F+SxVACEgsYr6MbCzJrjGlW1/t?=
 =?us-ascii?Q?PQEDkI9x/ZgIn7hEPBIR/nkVV3ozXWewNusebaR615KZP0GFH6o0X75OvK1r?=
 =?us-ascii?Q?uoAkL/s4Cjlxo82FE2I38FCGXXw0OhUvJ4NMS8DoNgnFSD2QG25MIjd1OycK?=
 =?us-ascii?Q?xP/FBQxbNbMe2TNErQPJTn9kCfjIBReDxSvtzmPacKUfFpABSNnJsAtB/u9n?=
 =?us-ascii?Q?n5FU7X+vbhaRQ9vwt7+OtD7I+pPLvxWxaGaVWSnTBLpWrnuuiy+ADWmWnlKW?=
 =?us-ascii?Q?dSmd5J0ACFqcS+RuNUD5IIVbUteot2hZjb8tdfxs3x16bzonXIJOQQWqqe7L?=
 =?us-ascii?Q?iBryUc7I2lgmP9kDpl3k02SP1/UDZAWYyu/0oiPFGvlqfpmeKClWQ/F4Scrw?=
 =?us-ascii?Q?FKoGT2BmkznljnPXBwaiTRcWMhQeR6U6pmS/lV4NxSjTUcKl+GoLqr++A4Yn?=
 =?us-ascii?Q?T5y+omLWGwlUqXB8fCIorgJa1s8wj3KP6hBZ8i2IonoiQTI1XiBLhc94ul21?=
 =?us-ascii?Q?laqV8mrUVsqe987MyysAfWkhM7AaG1nrqUqPRKV4wLXeMnQKgXZ+Odkoxlb5?=
 =?us-ascii?Q?Ni0ryzykfAukOQ+hlsvvh+ujoWXZFT8pkzOmbbsaP9Ow9oWV1BhXBTx0IXpl?=
 =?us-ascii?Q?uaz6K0ffnQ1mS79yfdB/O9XJHNuqf696+iHiOsWpn6l1U8IxWKc80Myyct16?=
 =?us-ascii?Q?EgXmYEIahY/hNUaZ4A8146VFeowMXJ9A8aYcXEUOtNsvY3bfszPLqJ+KzsZv?=
 =?us-ascii?Q?eCbjQrIX4nIrl3ERdtZ0+VfIh8Zly8yiBR3d8TxysN0+zHwDvVAFTmkLX8XF?=
 =?us-ascii?Q?sZCLK+Llx+YkiD6jSAuUWogLxOOQssIBURsC75yhpN/WXvyxZwtZLSJn0iOV?=
 =?us-ascii?Q?rkrqDc/ZXWNz+ny+zkhugYYF5z1QFR0V8EX6gVf7jDP5n1qLLjI6Q9fXDnjK?=
 =?us-ascii?Q?nvV4xllh5BbglOrBnYZabYUVDTnsS5hKMAPM5tMIv05MxjLo4fg4OVHf7vUw?=
 =?us-ascii?Q?ocGmwY6K75ciqSAzevAagvwNZdQFb/zEObMfjm1OkO7AGIhtzpch9VccX07G?=
 =?us-ascii?Q?q857x7wLuwxUzypa9QULRbCdGOxq6QrYwBg3578EltvUpmWqQP7QxsuN53RX?=
 =?us-ascii?Q?jj+SNKXYsGuFk9IbUjGYN+fN+Ul0ZjstgGoqE1LZ9pAVRUPyEj3H/Qmlsnhg?=
 =?us-ascii?Q?RggQHSt8YX9Yg/IcwqPAKzZL3SgoODOjmJv0h6cED3ArPPHm4/RYi7AyOUHM?=
 =?us-ascii?Q?g/rFBXPX2C0Re8Nzw+0kdhIu9yvL6YRde8DHTpiq6fnl/ELYII8hcEg5dbGt?=
 =?us-ascii?Q?FXpWr0vQGOY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QLv6Bn5DWV5pl8mMsj3Ac5t9YrEzP9A5K0XiKU1Vahq8kDEv6GqmTNZvb+jr?=
 =?us-ascii?Q?30ATIm4Js1sFVRe5arODWX0aXPryNOVowJiIWSEk7pSEvCOxU23AiOGPy2V4?=
 =?us-ascii?Q?aaQoy8NexAvqq1mdlTnbo/6bOc5ZDD5SjTUIk1wTsjqr8Urk3ipOaR6eu4pD?=
 =?us-ascii?Q?awc5ocKvDdPCVDDpn4nosOvYvEJXAunkK8VyL25LfcJ9+rDY4tISkQIY+QIS?=
 =?us-ascii?Q?KIML36Hd490HjFQaELnZHMu97NDLXvbV6YHHh/urRijWmNhEzin4s54HykrH?=
 =?us-ascii?Q?ltn8xKRxD3vUogzAX0Xaigj68BI3BHCL4XjKviNyevX5Ev5D9jqqiQXI1L0o?=
 =?us-ascii?Q?8v0Da+hK8miii0mBrc5oRnJYdpfKAq8SDRjGTvtGcCGaHxxVfcsKIjWWAGMn?=
 =?us-ascii?Q?e11IZcZ4BdAZAIKbs2VtUhAUlpvzR5KmUmQ5m9YdPdrWWuGZ64CcQrPj7ZzW?=
 =?us-ascii?Q?SbAC4SjYcYUhQYzYFRmrvddEnTthaQDCOPpznJAvkBfXWytdMj2+/X7lojNe?=
 =?us-ascii?Q?cGeWhu3cqt421DLUfePzlrKcICOj3z06ar3juUaZ0vJRZrrLQ7waRZtg6A8A?=
 =?us-ascii?Q?uQVLl7Vm/hy+T24LCCWhm6mnZ7pFXuEaolxJsIA3jzixCBFdgZoZ2IygP4wz?=
 =?us-ascii?Q?tICcxe6WGNMGX5pwDjp9oP9sUJbscnA0IRI/ticoboXoD3ohC7gSJG3HeY+Q?=
 =?us-ascii?Q?E5OTFD15hPRt4MPTFpcOFoXYtiT/lFp5dUgwDVuwCXKXz9+SezznRotKg9hU?=
 =?us-ascii?Q?sw9aZRqJr5GOet9AVMQdHn+p5XA/AqL4Pt6ucUCZAHfKBwM+vugHNBQHrZKK?=
 =?us-ascii?Q?tMs/DwautDlKDptE+EnY2rwPxod/KzL/KLaYqlD6D+AY61uxZZ7mdVqVjKKU?=
 =?us-ascii?Q?7P5tyTclnlXSoQzfT/RKSY4v4mLZtIBUYaaxapHg6X7Y/6fGNfiQ/7PqLXAp?=
 =?us-ascii?Q?5VMNwjb0d+mgPjdAvExmOy8eOFDYd1cn/B8ZJ/q57Re+cLuSzPCFkGL6TkGj?=
 =?us-ascii?Q?xZFs2U5WjGeUsSVNWEsJOzMD+FFmMA1ld3EzN1Kjeouyj4NCPUQTASWdZcDZ?=
 =?us-ascii?Q?3HKBSsEwpFIWpNKt5QNsJS1wPz020/QlNfLsMFNH8tsFMwBddkoNsL0gXdSd?=
 =?us-ascii?Q?IWywtT/tYUZO1itmStifQrPs8oMsypFkgTcpCsvhS4mhovLYYxfJFsOvpD18?=
 =?us-ascii?Q?8B6mwhzaa2jurKq6GfrMfplCv8yGrdBQwGlj+558MDDrKWvMfxIafqVj2GTx?=
 =?us-ascii?Q?kd/MjhDOWLxF7IoS7/ibCUdhS1ruq3dZCK7r2pBuxkXB3Q0Mt9SnOLKa/obR?=
 =?us-ascii?Q?YHiAY52BI48eAJfTjA5OXqqLx1O96yxea6LgcShvsKBOxggUSFdOKO6Gz4Vt?=
 =?us-ascii?Q?XceeB2dzmtl3PISJl1MKGcGHFhaNdEnAX/ivhe0mXY9CAbM2ev4Ph5ejlZX+?=
 =?us-ascii?Q?SdbMsAb/KzJc4p5CQ36BkmV3ycIQhzWQOGDziPcutsOl4fSRKS77d1NQFmY/?=
 =?us-ascii?Q?ctb7NaZf9D9NscB7mI9LOonGfGfhqLCQcYFpb307mqEjl1iVh4fI55t2UGXS?=
 =?us-ascii?Q?1neh7MatHFv0O92GSSLSelaiENfrFppsaeHsKkpW?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RY7nMjcOc9Vfsozl5bGrvujYtj6uFtfjo1RL+betdop8FwR08lYTE2f/MSvVIeKFVwV4AIkZPt1G3cv8HdQdipLXOdeOIIqxU1uBK77yaSw87ZZOJkqErM6Vo7VCphSyAINo7Szxic3JKSykW1M88nNAqz7O7TFRpad/erDlZZzTA2CBsgCa3I7oD6yRNQaUD0N4p+Q5K4u8OMLQUnsK8jCtOKEnzW5WiCcrpQxdX+P/WevYDz1DSeFsuF6IUGHc79ynwcL57MvGNRPESnR4SNBGgO0bkT8/14C8fM/e4G5iFGmoIy9R9Za1aR9ZPOak0rdKgqfClJ3nUwhzJEtueQVHW8kOtXlErh4o6uHLtvkCkHkHh//n3HrHqanx//WirIcw7o4vcWUuUvm1DgMkSum3pLMwuldziSoVYMKLe/Ejp5rGDANSdKINfpX1LKgMXId3gK0QYnMOlLFUD8YEcAy1DQh43RQvCbnCvTMZPuJKq9dYbmoXu3C7NmtPXetNnLNJVk8ACrMvxLopagMlMyku3/8JQYIeabDlkCwhikqaQlYC4NiTMaLGXsmhDPhjRyAzPJscHlPlhFnun/HEuQBMClpPcJlt1wk+gpiuPUE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54d8001c-ffa9-48d7-a3db-08dde533360f
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 06:30:27.3988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PlZqQ/+DhcDmMRdVSFM1bUULv2vKMTBlHbe6cz/PNN3lsvuwSyA2tN1JtV2xC1tQJrEZyv/CC14ThVw9DK0b3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7662
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2508270052
X-Proofpoint-GUID: nHZXdJP-V0N65-u_smaoo2eBXmaSt7mL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAxNCBTYWx0ZWRfXynBPi92zDwSz
 EE2ElY1lP8/I8BTXMIPhMhTBI2IVL2kH3+r/wOcOXzMhUbbNYD5G/9Wptt+/0TnPriPljAQ5+xG
 7kKy9O1sp3s6yqN2qnaL84bo2V33iF8Oa53qkWmky3R9E/oMijcVBxAtZsHXBiV/jykE6rT6PP5
 Zkk21/oIIGFoB0Y8hDI6eBUMaNIsh99fNZ7mFtx9KD3M1NzJ6kscOQmjYzWrDXa1lw7ZjJ43L9y
 UqsbQzXj6grm2RgSIabhAELxwEaPeQYHHHvMvPOfgoi7ihee++l3CwlTc80TyhbAiJ72lFaDWIa
 WJPgVCPSbqQG1wt2bZb2nom1T7wI+EcS8isE83kVITTLMchZQaFMeu187Vbb8wEBSO1s283Y3Bm
 8p53ub9eUBGFRHPvf3VAnRcD/KSJUg==
X-Authority-Analysis: v=2.4 cv=FtgF/3rq c=1 sm=1 tr=0 ts=68aea60b b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=jCrrCIGzjgQ4ZX09L1IA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12069
X-Proofpoint-ORIG-GUID: nHZXdJP-V0N65-u_smaoo2eBXmaSt7mL

On Fri, Aug 22, 2025 at 06:02:40PM +0200, Andrey Ryabinin wrote:
> On 8/22/25 3:11 AM, Harry Yoo wrote:
> > On Thu, Aug 21, 2025 at 10:36:12AM -0700, Dave Hansen wrote:
> >> On 8/21/25 04:57, Harry Yoo wrote:
> >>> However, {pgd,p4d}_populate_kernel() is defined as a function regardless
> >>> of the number of page table levels, so the compiler may not optimize
> >>> them away. In this case, the following linker error occurs:
> > 
> > Hi, thanks for taking a look, Dave!
> > 
> > First of all, this is a fix-up patch of a mm-hotfixes patch series that
> > fixes a bug (I should have explained that in the changelog) [1].
> > 
> > [1] https://lore.kernel.org/linux-mm/20250818020206.4517-1-harry.yoo@oracle.com
> > 
> > I think we can continue discussing it and perhaps do that as part of
> > a follow-up series, because the current patch series need to be backported
> > to -stable and your suggestion to improve existing code doesn't require
> > -stable backports.
> > 
> > Does that sound fine?
> > 
> >> This part of the changelog confused me. I think it's focusing on the
> >> wrong thing.
> >>
> >> The code that's triggering this is literally:
> >>
> >>>                         pgd_populate(&init_mm, pgd,
> >>>                                         lm_alias(kasan_early_shadow_p4d));
> >>
> >> It sure _looks_ like it's unconditionally referencing the
> >> 'kasan_early_shadow_p4d' symbol. I think it's wrong to hide that with
> >> macro magic and just assume that the macros won't reference it.
> >>
> >> If a symbol isn't being defined, it shouldn't be referenced in C code.:q
>  
> That's not exactly the case for the kernel. It historically relied on being
> compiled with optimization and compiler being able to eliminate unused references.
> AFAIR BUILD_BUG_ON() works like that, there are also plenty of code like
> 
> if  (IS_ENABLED(CONFIG_SOMETHING))
> 	ptr = &something;
> else
> 	ptr = &something_else; 
> 
> e.g. irq_remaping_prepare();

Agreed. I've seen this pattern in many places.

> > A fair point, and that's what KASAN code has been doing for years.
> > 
> >> The right way to do it is to have an #ifdef in a header that avoids
> >> compiling in the reference to the symbol.
> > 
> > You mean defining some wrapper functions for p*d_populate_kernel() in
> > KASAN with different implementations based on ifdeffery?
> > 
> > Just to clarify, what should be the exact ifdeffery to cover these cases?
> > #if CONFIG_PGTABLE_LEVELS == 4 and 5, or
> > #ifdef __PAGETABLE_P4D_FOLDED and __PAGETABLE_PUD_FOLDED ?
> > 
> 
> I think ifdef should be the same as for symbol, so '#if CONFIG_PGTABLE_LEVELS > 4'
> for *_p4d and '#if CONFIG_PGTABLE_LEVELS > 3' for *_pud

Right.

> > I have no strong opinion on this, let's hear what KASAN folks think.
> > 
> 
> So, I think we have following options:
> 
> 1. Macros as you did.
> 2. Hide references in function under  '#if CONFIG_PGTABLE_LEVELS > x', like Dave suggested.
> 3. It should be enough to just add if in code like
>             if (CONFIG_PGTABLE_LEVELS > 4)
> 		pgd_populate_kernel(addr, pgd,
>                                           lm_alias(kasan_early_shadow_p4d));
> Compiler should be able to optimize it away.
> 
> 4. I guess that the link error is due to enabled CONFIG_DEBUG_VIRTUAL=y
> lm_alias() ends up with __phys_addr_symbol() function call which compiler can't optimize away.
> Technically we can declare __phys_addr_symbol() with __attribute__((pure)), so compiler will
> be able to optimize away this call, because the result should be unused.
> But I'm not sure we really want that, because it's debug function and even if the result is unused
> we might want to still have a check if symbol address is correct.
> 
> 
> I would probably prefer 3rd option, but I don't really have very strong opinion, so either way is fine.

I also prefer 3rd option (but 1st or 2nd is also fine to me)

That's two votes, I'll do 2nd option in the follow-up series unless
Dave or somebody else objects?

-- 
Cheers,
Harry / Hyeonggon

