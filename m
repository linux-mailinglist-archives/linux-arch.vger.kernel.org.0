Return-Path: <linux-arch+bounces-13459-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A1AB505E5
	for <lists+linux-arch@lfdr.de>; Tue,  9 Sep 2025 21:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F3085629ED
	for <lists+linux-arch@lfdr.de>; Tue,  9 Sep 2025 19:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C73301008;
	Tue,  9 Sep 2025 19:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BJrkAcpp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="au62ubYd"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17EB929C328;
	Tue,  9 Sep 2025 19:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757444868; cv=fail; b=lPeRdbBgq7kaw4KaYG6doybDhb/DCEPo5cBYFX/oj0cF9nSoN8Ca0T43gVy+NAxgeTofyhJXWEALzJV95wuT9XmNB48Sha9IJwIKjO9SXJ/i2fX2++wUOsSQcQo3J+oNq8bfTMaEAaxZaAyjICJJjEsWL2Bn8+8Mmyq9anhv2TE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757444868; c=relaxed/simple;
	bh=TLRchHa9USrX3fRj9RXlKDunt7qfF10GkcBRgfUG/N4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lamK06jhJgGarbWrLuI4cBNJqfoNLBktuw5Q6DydP7+vtN2aU8XWFgTMNz3OFqzpq56u6j2K7teT0Rynwhnkn20dM77UMHjunM1fULnL1y/vI4E6zaNe8baUz27VfFe4v8/1dQCGx/DF/DzhkIvbldnhvfS/Cct8o0I8Vbv03Ig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BJrkAcpp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=au62ubYd; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 589Ftf6Y017624;
	Tue, 9 Sep 2025 19:06:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=TLRchHa9USrX3fRj9R
	XlKDunt7qfF10GkcBRgfUG/N4=; b=BJrkAcppmgXJsYRu4A2iyFUUorMkZ6CmSg
	6QppLKLqvb3Oy/nmqXyFKhC7jgFwo8+12K/bMJB9U6M4BApCb1fmFRD6shRqxm1p
	UEBFYgpsuvX4mYH7HUM1IoYHkrKFoFqvjCXDUXMKvAjYO6cM4QwGqoucQg8N9T/0
	8R7KrNiwpdF3zbCvPtB/NhjSV77Ppg1v3whxVaL/cZMGAi1RHIkFhyJtRDiPM9kN
	MINsAqgCvcCmvkMTB/WMeJHKPkpcKdsrq2VE6Mb9HYlfXadIfJ7DRNg4QWMDBX5A
	UdbtZ8pLVFU7lUN+Tp5V8Cp5UoeLzTwFuHtiMpsiP9/Pz61FA8bA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4921m2tquj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Sep 2025 19:06:35 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 589IDG1Y038737;
	Tue, 9 Sep 2025 19:06:34 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013000.outbound.protection.outlook.com [40.93.196.0])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 490bda1pu2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Sep 2025 19:06:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mS+fnaSfCftkmA4bMlxoj6VaDkHmt63Wk6z857DSbBq6GXKbE2gtz9ATQI1u4ARbj5i2pEhZp/v3iPZP8O1xmfS0S0GOO+HFNRa0FUq1VAmC1OExiZWRZ5ZrzKwEhGVwW3caQxTEBu1L4O+eaQWhqlZdkqQdhuHyWJ5n5jf42eWESmsYyrfVXQPXmAgTVg5QSYBweBP1FiLGfIkZNHAS4t0xWq48cO8MT3ac0mFQ3Nw1aESS1UPCGGxrKRDYVK8A4BXD17UEqgjE7gitX5r8I1RKAA6cb9Ck6co0MlKZbDxGvPeOsqazQMqX6A5/eGg4hL2eFkoXcq7dP5HduBF6Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TLRchHa9USrX3fRj9RXlKDunt7qfF10GkcBRgfUG/N4=;
 b=ZYZzOgxL5ahLGQTXVtgRYmVKBkKhcPfj/+MFj9xB/BayqGz7b/1OJdScKKUlvQYTnEdAuyWFUaA14mBtawNFJviRnQVbhGf7KpBDIOH1vMdFkRHy2Sp2KSDAbp+bo4iIyQvCVq9N5YX6D42n/6ql2oRRGdv+RwmLscmLJElGO/aSeMWybW3CwBC4UPdCMBEMYZ811vhbedHjtkq2pb/v+kyHHtLpLicHZurjgPEMdMoDjFW+00RYV7QizC8StbN6lEKsi2B23NkcvL/cUnsV/xGqQNqF/kLjmRVkFja1nAajWQ+08ANPmvWPSXFDV93Aos2ej9LUbw5ggWyQRIckew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TLRchHa9USrX3fRj9RXlKDunt7qfF10GkcBRgfUG/N4=;
 b=au62ubYdpBhAiWlDGRDODaWsc2nT5/u1uSa/5YjVAoA9rdDSHNSOdjID2IDNxob+mUGTd9SJKOegbwVGduve7rlg8rfsHvT/Ls4rltrTBkDCFIDGWqpBimxN+gPXj1pzPxgUH+wjBrMTOy3yp2RfqezFYn+AbA/JPKttbBfvajA=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS0PR10MB7344.namprd10.prod.outlook.com (2603:10b6:8:fe::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 19:06:30 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 19:06:30 +0000
Date: Tue, 9 Sep 2025 20:06:26 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Anthony Yznaga <anthony.yznaga@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        akpm@linux-foundation.org, andreyknvl@gmail.com, arnd@arndb.de,
        bp@alien8.de, brauner@kernel.org, bsegall@google.com, corbet@lwn.net,
        dave.hansen@linux.intel.com, dietmar.eggemann@arm.com,
        ebiederm@xmission.com, hpa@zytor.com, jakub.wartak@mailbox.org,
        jannh@google.com, juri.lelli@redhat.com, khalid@kernel.org,
        liam.howlett@oracle.com, linyongting@bytedance.com, luto@kernel.org,
        markhemm@googlemail.com, maz@kernel.org, mhiramat@kernel.org,
        mgorman@suse.de, mhocko@suse.com, mingo@redhat.com,
        muchun.song@linux.dev, neilb@suse.de, osalvador@suse.de,
        pcc@google.com, peterz@infradead.org, pfalcato@suse.de,
        rostedt@goodmis.org, rppt@kernel.org, shakeel.butt@linux.dev,
        surenb@google.com, tglx@linutronix.de, vasily.averin@linux.dev,
        vbabka@suse.cz, vincent.guittot@linaro.org, viro@zeniv.linux.org.uk,
        vschneid@redhat.com, x86@kernel.org, xhao@linux.alibaba.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH v3 00/22] Add support for shared PTEs across processes
Message-ID: <98c8ac9e-e158-40e7-9855-b333b31880ef@lucifer.local>
References: <20250820010415.699353-1-anthony.yznaga@oracle.com>
 <5b7e71e8-4e31-4699-b656-c35dce678a80@redhat.com>
 <aL9DsGR8KimEQ44H@casper.infradead.org>
 <bff57a63-4383-4890-8c68-8778b3a75571@oracle.com>
 <3fb2b394-fa75-4576-ad8d-6480741f0c1b@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3fb2b394-fa75-4576-ad8d-6480741f0c1b@redhat.com>
X-ClientProxiedBy: AS4P189CA0048.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:659::12) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS0PR10MB7344:EE_
X-MS-Office365-Filtering-Correlation-Id: ef114f96-cd3b-454b-e63d-08ddefd3fc48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qUzqdxQncZzT4h3lh5qes73uz/qU0HjJ+NUv6jyg69rtpS9LOjEym5Peq83S?=
 =?us-ascii?Q?5hSI0bmV3aPIo8cNPCHu0TSIvgIQ159/rCYo9Q2fmvEg1UMdbEvTx36bHXRy?=
 =?us-ascii?Q?jFF+B2jDam5rCvdItUoGDv/UmKuOzVfeR1sXDiQ9KcBZs8fvLD3kQE3jLw60?=
 =?us-ascii?Q?XCFcRieTfq4kC59Vm2JquKqs0trK3jpZ8n+xgXSWQKKQv42AH5oseiZK8rBX?=
 =?us-ascii?Q?eimbJ2Krh8pQ/j2Ozos1elCf9MrMjwe/EIxlUVBwKLb8PRZ0R7lUil+cZOzD?=
 =?us-ascii?Q?f2tfozM/bPpFHblMdGnCaUP0eQf2jxUpWgSbMaxtKK95ZbuL5BmuKglIj3ME?=
 =?us-ascii?Q?rTpVmYA2FhZAAvc7SVi7EviCxl7YBTAqtTE9zUsvpXu/qmPthMPRx/EcJP+T?=
 =?us-ascii?Q?Kf2hT1WtBuuG8/RdgJhjTTy+XhlMT6tQZVYOL8SAXutolWjxuRfmO8yN/eSF?=
 =?us-ascii?Q?IWToH/eW5I+mnNqgEKlbdWOe0jM05PNYjaiB7aSKyNnMTh8MaxanhO1+aVwD?=
 =?us-ascii?Q?r29QW9s+jUMzbI6S+CCu1T06NEnbFcZzj6GKG+M2jipMrnohCLUC//sUBgGJ?=
 =?us-ascii?Q?yu3IyriOe0izo3CwfLY/dNEF33ikpFF7Jx/kLb6e6QEzjN18ol45Es+70Wv7?=
 =?us-ascii?Q?67iGtZaR0CZngml5YfW9i7wGGReHdLdgjk5jQWQUQlnSurdXE4/wJibfMGeA?=
 =?us-ascii?Q?EyQnuj39R2vSD+ohiRG2rqu1SN1SEvuKrWFz1InEIrZg+CNPAMQr3gJIvWL2?=
 =?us-ascii?Q?2IlLTsFgkny9Zm7ThIrVEYgRw9duslQEJc/uiok0Bkwx3ZfCLl/Nz5s7jhNJ?=
 =?us-ascii?Q?rQBKpXJaN42gO3Bp5PHxQRVzriqiB8a5yGFbANZX0bz7EA5Iy7JqERn5vQgj?=
 =?us-ascii?Q?N0nbIeQPgaECMN85Hs2bT7KTJQzw5TIMazm6vyZkn/V8we8Mm6befuQFXzSe?=
 =?us-ascii?Q?EvTxrhnIVQX3LSvdp+o6mH+iAROv/4dK8NlpF7qp1uoG+Moi60bFeP8XvjbR?=
 =?us-ascii?Q?0wh/xQGB3Nui26CJcRXbvy6VXwhgwPZStsiihWKkgQy5FuJT6vBPoQtlFEbd?=
 =?us-ascii?Q?RI3g7hS/g7WvJh5070K6RTm9Ini/OwyWYt7gXi9UPSqyugv8HGCw4BfeVzt/?=
 =?us-ascii?Q?riTP4zQYR8YmvnllLXuiVVXlE48mlPH8rvOC3GsGzMn1rB0YAKGIDk1wrvmn?=
 =?us-ascii?Q?uEtcDwoK1mvm/dzGboR8BP2wE/5IsAUvBaXF4M159fju4Jyh3V7KMz/EPVpY?=
 =?us-ascii?Q?8mHVZ0xxD0m+osyAfS6KtymD4Abe3UI5i5jvDo1nybTcBieoz1m71O20NY/l?=
 =?us-ascii?Q?kEN12L8YGNBZ937BrtLjPNK2JawuFuhOqBtHT27NcaEoUcHpWDctX3Xh9Y+6?=
 =?us-ascii?Q?B0hulkQIE5bG+H5GmqPvd6/3dm96urt9ULyWn8UAGrVZvgvSq5+KWT3+arwO?=
 =?us-ascii?Q?Nc1XbnffitA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4Og4uEhlcEX+coFHO406d2Xsqc+KiAC659dmJD+WgrvUEoq5vV/hlx473HgQ?=
 =?us-ascii?Q?GlpFNsB7YQJYmt5JsCap3eBkIVj0+Jwkn4ZBApoFC3rRINedUeutTIOwHpnd?=
 =?us-ascii?Q?jfKckCEoUoMIJiI6KMCs7CGZ1hXwCxEDaEw5yCFBr5wGFlrLF/fB8wS0/A1S?=
 =?us-ascii?Q?GD/WPdiVlbN/rjNTvvEYIOy7NnwvA6C9yMYOrkDink7A2EsqsQtvLrgkrrE2?=
 =?us-ascii?Q?hTkeYWuiqgZZ6tE/h06ysWqct0ET82EwnNTKK1tEbsCbfp2Thy8zDafeDoZw?=
 =?us-ascii?Q?rcdL+Kf87+JARK0lIFrxNZrkRtIvf/3NSu/mXFujLcWIpGsVFfPBCKAxoon4?=
 =?us-ascii?Q?ETQxKW5QKX+Q42kJIBV9SwziZMC6hwkdGfPMlDIMU2IZkV8G4Y+YaPZY+yoq?=
 =?us-ascii?Q?ekwhO9MYNJ5UWxMRLIzgqgGOfrti98pcNVdkjXm0DiSvrrP/WGgTESY5fnbh?=
 =?us-ascii?Q?JAgQgyle+V2+YFuzE8WYGJkkaDjm5Lve4gCcq6ijh/Yynfj5FZvjAie9qiSk?=
 =?us-ascii?Q?G20PtjjrZBXdvu79sGAHWY9zs0/KCPSPGxnqLexZEYzpwcodfobG41MuWAXA?=
 =?us-ascii?Q?F6luPkGcwjU2lE9UQvc09sREa2X0Zbhol2wm8bEcGMXiE9ysrRHLyancrgPn?=
 =?us-ascii?Q?GIbRBHndfjSzyx0UFFdtbLIsaWBugnuYgIInYwtOT/v8foOWx+eulPL3qdxR?=
 =?us-ascii?Q?TEEAG37kcoMEJTEz++cDAwBanN9+0j3kEcd2W8GD3Vr96FLWuo2UVvePgv5+?=
 =?us-ascii?Q?rE5KMb8CaH7XoJ0oIefIibDfkhBXD98NfVG31ZF2Od20Px8qYtU4Au4cuHQO?=
 =?us-ascii?Q?/BVIry0LKmXwA510fidG4Y1AU50C0HONy2x1kHNEz2Mr53BWVxWAnnho0veo?=
 =?us-ascii?Q?T4csSOeADcKj4Nd+8HABTLydFQT95gy8BqMx+ekmNkRui2NAXhrEmW30pk5I?=
 =?us-ascii?Q?aI6IXI8oPtXTs5ZQx9reurnECyhd+DXHxdhYFTvmLgsvTylXoGomhDpZP3jd?=
 =?us-ascii?Q?BMd9dO99iyiFJ68zWbL186TcV7FgQDnkfiRHeWVxIT3us9NZF00AiKEi1zdZ?=
 =?us-ascii?Q?tMFWslo03T2hscxuRfUDbKGl0bfkz1Y4FakE8749JhWZtbR06YtqI4IXVqMC?=
 =?us-ascii?Q?xHbCpSDi7QbGdKZ6o/5tW6ATFqys82De7ueFftMRrR5Za6fqGuJwroBfpTVs?=
 =?us-ascii?Q?uY3HVEZeSYTcoeXmo298zkJ51/IQw3prhtMu/OM3nhPDVKdBUztN6XSWKcip?=
 =?us-ascii?Q?tdiGIilTc10d8pAaYD6eGsVKDd/hoavrX6AbYWtOyB46OfmS8mKlGteo1Jxe?=
 =?us-ascii?Q?7yl7/2wTzdEx1g2YAyb5e2MuDxxDJfJ2Jp32Xp0kkwe+9Dzp7hEKWVQppCWZ?=
 =?us-ascii?Q?snBGr+k/Jx3LOwBjiPuP6ylz9tGmvL+KEchGBMF25a4waFLzyQj86pZgOue6?=
 =?us-ascii?Q?MphbqpfKRV/H+LhkZpjAMy3SIZjDFHm5QoTG8JRQekS6clnKk9OuYCchmTpH?=
 =?us-ascii?Q?GJOdD3Tdh3sXSEEjiLumpsRAEdBalsQXaRRLuxVRsPzYitCWMONfz+jZalYY?=
 =?us-ascii?Q?JeI4Je0YpGN+sEBiDkj4OamO+b1+jwLAW5PlZFiKFh47F3Z1epx8s7E1e54T?=
 =?us-ascii?Q?nA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	F9c/Rn77zq8dIV49phBA29rRa9HYatvAvUhFafVvXjkWZjmFMinxCoC0E7rEzMtCo39Q0nErqEDGFMdvUvdH487yDpGXcEHj1yq+ckHtvghxl9GI/cuBXmkpa+MQavuN8wkt+U0VKpMJ0oAtAF2dAgNZ2MeK+LTjlofrRV/GJbfmG/FlrpK6oLVHc6x6pI4hItvZDr6FH5+wf/CLqVWfWOfnCmWCQ2HcQ0fhnJ3Bkxbh2y0cgwuSiy7yKqXHEFs8WyD/v8si3AJK7z2DOINhmJfTMHbLaqqc7VVIj0wHCm8sIrZls9bRQ+VC5Q+V+giEONi2h0xiu1H1BHIEHBYUhGe5a13OqfgQYJ7ROVyUtWi6OTHexnjJDmX27tKJn5O5lBHPREq5rqpJ8v81KwuAW/lXSdCkFtd6dNv6Olugu7DEv0efq/SJwxr64fcXRW6JU6arkA+rBuuLPpcbETnyW2EJvRc2ZXywHFjcz20GQ2G+uv5LUxkVoj5jcSMQrVWWZgnf6H4QrsJjaEyS9y0m1+D7CZx6rydpIpbJBrPz8N36uq7YIwxZWcxDRgJhv2gYDUT7CZF0wsAE3CkoiwiuZ/h1aK6P+oaeJ5mxsYvga+U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef114f96-cd3b-454b-e63d-08ddefd3fc48
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 19:06:30.7118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sZHrJWeDhtYd09jZ4MDMZqZ3ru7kb5eV6W0SI/8j/5+Er8ig/O/pSs7xrdc8mOdtm+qljJPrDmv8UxzePuBuegbQxeHyA0VQchheqFJZofM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7344
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_03,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=676 adultscore=0 spamscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509090188
X-Proofpoint-GUID: FpwIp0mS0bH1uihKVakDrlGk-37anltw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1MSBTYWx0ZWRfXxv9zbGZKxGdr
 HjeqqVwaXVgPSkw7vZ3xvaseWb1id+G92n0sCxxGSbh7yt/WmkWubtHFYqnmwhsOojMky5hu2CT
 LEswP5N3uW5i1ON5uXnVzXCgFoExLb0M499yAcNIXbiZb5h0luiifIhG64K6AgmEKDutxBtgE2T
 0LQcjpiCU+4+uG9H2A8D5I0lVFz+U9czRhYA2m+YrIvT8DtWt/JXeuC50hGIeXmz7L2Y2kc1+ha
 F8NYqAfjNBsCguBm/yjk9lGPO97ZN41NPt8Lh5k7/bYWhSOKVzdkkYPp46g4BZTMN1PR5Bu8tEy
 npx4HQENqJaZUi5uNjHOd9CRuilQq1h7xZqCWavSN4kTOeRIUSODC0lwIwGzLVDDQQlsBgZ+/D6
 YAoM+AMZ75G2rJfe9kctIfwpZyNrEA==
X-Authority-Analysis: v=2.4 cv=Dp5W+H/+ c=1 sm=1 tr=0 ts=68c07abb b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=2YMlhS3hTSgktRbhzRYA:9
 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12083
X-Proofpoint-ORIG-GUID: FpwIp0mS0bH1uihKVakDrlGk-37anltw

On Tue, Sep 09, 2025 at 09:53:35AM +0200, David Hildenbrand wrote:
> We have to be very careful here to not create a mess (this is all going to
> be unchangeable API later), and getting the opinion from other VMA handling
> folks (i.e., Lorenzo, Liam, Vlastimil, Pedro) will be crucial.

BTW I am 100% planning to take a look here and reply properly, just working
through a backlog atm :) [as usual :P]

Cheers, Lorenzo

