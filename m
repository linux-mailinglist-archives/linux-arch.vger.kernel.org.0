Return-Path: <linux-arch+bounces-8621-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BAF59B1608
	for <lists+linux-arch@lfdr.de>; Sat, 26 Oct 2024 09:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFD4B1C20EBF
	for <lists+linux-arch@lfdr.de>; Sat, 26 Oct 2024 07:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81B11B6D19;
	Sat, 26 Oct 2024 07:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Td8QLuAb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qLkb7MQE"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B25190663;
	Sat, 26 Oct 2024 07:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729928458; cv=fail; b=bvz0AJ3HoeV0FeBEtfZZoegcZWIaA4ieN0ead9DWMX2cG8qV0nGj4PRWaW9o45nTJT3mxmtTmuGPTj4K6osUcUwKI2KbIhhsxw1wggDLrX3vFTpNdesN0Ai1EGuMgOAplCG5C63yfq0zvtbm8k2OskyzW4wEeno7m4FU4xzfxyc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729928458; c=relaxed/simple;
	bh=wSl/7kwNMNwJMVbzC9ifx3oTlzYMKtfVmEMSF+vTyY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QIzwZ+Do9IuBaIb+Hi4e4FyMxF3woYMJAG8WijgDT3t8yPiH7Dj7okou1p/5v3yvzq0svL57IFjWxt4doUqx9KqIK6YZIUZUVS8P4r4ltb0pUvG0oWa/gzLF4GZVDIietGoTJIIdA0OZ9lOJJlgNcmNk6h+/d90NrTPhLqqQijw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Td8QLuAb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qLkb7MQE; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49Q3G6C9024667;
	Sat, 26 Oct 2024 07:40:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=3eccfF6wIUHVeHYPX1
	nR/WS+TJKA9F+I+YKUruhtW4c=; b=Td8QLuAbUkz1sj0Ah3yCka47+pdLQ8Gsar
	AqCcvp9sPJVjWDNRfrBpIGt/3E3yfFRT4fbjPDMRf6j6Gmv1y9fvHJaMU5YnfN/k
	Qeeh07Gr6/iSbxWOeWxxGx36k+2LySy8TkyMeDC9z2vr4GI6xyBH5A5j2B0r4MtU
	Iw8DecjO08+LouaQUtqIOLaXD5KX8TYu0+y5z9VWVNN1xu0wbCwaJR6bh3I8E7Ap
	skYkZyMSGrm10Es8X+MuxIMKSomXLhWjqE7XBw3j710Gk3EKfMKws62X1jI+88Ds
	IyVehasgHJxpjzOGojK9D0djXAqy8X7T1g6K3nK5DFMfGQ54ZBdA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grc8r62b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 26 Oct 2024 07:40:14 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49Q3Dl7q019188;
	Sat, 26 Oct 2024 07:40:14 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2042.outbound.protection.outlook.com [104.47.55.42])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42gpv3w2pv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 26 Oct 2024 07:40:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RgxDCWFsw4VbpIAfyKFzLB9qfilWIJuDRJUEi2M1tvUJrK5grfKSAf8owLZ1kPxOeB5k10uZokkiLz9tPXuTnZ5wLuRPGRtlwAd4P67ETgA+V8BqM02qWIAubFHHlv1ZkDXOgKzxFpxcdbf0nSkb7nhUj/cjCNliamH6JBueGrxfk/RYKB1susCN1MbDXTPLVh6Urs1GmM2r3rGYVXVCQmEJrsG6ukIyQlFW+welBkWqHYelOzEj5VY7EenWMPO3t3yCcqcWVl4JA/6p6E9fvyujvBXOhmpl8eNo/aNDKUFSwLJcVmFS7Vt6w8Nz2vkRo2WIFMmVSyAqGDO3PAxxyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3eccfF6wIUHVeHYPX1nR/WS+TJKA9F+I+YKUruhtW4c=;
 b=QEGQIBW4woowI4GdVDULvQdc0ZAX8mM+mnGkjcS+nFs9ErEmRk1k3SlHSEt5l8EwTuiLgcHek/C6NeysB7DuzRbOGU3RiztglpS5O1/GgCi/GmQJ4LFyGjrQkDLUp8KEP5PHSWoUKkdLoX7nK+K3KF6glyUK7rL3fokaoXGjz8YYyZm5iEZZGpHAAlj1wcb+jfiyuyZd6Xm0uEEoSmN4sqXwPVkyI6AvUvm6dSwBLUj/tx8aCQQppuJCefcQVZ2PxJByTXX8B6YZP73dd7xphVjyMT1xEe/i8ZF1gov8ii0KNGTpTCydcAnWwBcNUWbByxtkEqkR/5x9aljnzEECVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3eccfF6wIUHVeHYPX1nR/WS+TJKA9F+I+YKUruhtW4c=;
 b=qLkb7MQEYEDKs4T8nMK8sHh80o3C7QXhTA0faDq9enrBFbcQSyufKVXDMCCi7/wdkdXaNyeiwOevCnYn5a/gIio9FIfL6z4sXcfXrAOHaZ1GDa29UZINqntm+d7LFe4NO6tV+KP4QSPYNLxqNB53NkkYMWR2vzB/IWdFqObLilc=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by BN0PR10MB4854.namprd10.prod.outlook.com (2603:10b6:408:123::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Sat, 26 Oct
 2024 07:40:11 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8093.014; Sat, 26 Oct 2024
 07:40:11 +0000
Date: Sat, 26 Oct 2024 08:40:07 +0100
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
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>, Arnd Bergmann <arnd@kernel.org>,
        linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-arch@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>,
        linux-kselftest@vger.kernel.org,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Jeff Xu <jeffxu@chromium.org>, Christoph Hellwig <hch@infradead.org>,
        linux-api@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v3 3/5] mm: madvise: implement lightweight guard page
 mechanism
Message-ID: <70d12456-1274-4876-a45f-a4c5fad87a61@lucifer.local>
References: <cover.1729699916.git.lorenzo.stoakes@oracle.com>
 <415da1e6c5828d96db3af480d243a7f68ccabf6d.1729699916.git.lorenzo.stoakes@oracle.com>
 <20241023161205.003ad735d5f6ec50ec2eb054@linux-foundation.org>
 <a10c26ea-3a48-452c-a02d-7522eefd494d@lucifer.local>
 <20241025171131.9ceabcec32ff4c569d87875f@linux-foundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025171131.9ceabcec32ff4c569d87875f@linux-foundation.org>
X-ClientProxiedBy: LO0P123CA0005.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:354::17) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|BN0PR10MB4854:EE_
X-MS-Office365-Filtering-Correlation-Id: ae6b0381-a88a-42b4-c894-08dcf5916bf8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3mDP7f/uTPv5cP54Dqwh7+DmPLfUhsD6+AUA9sCpf8lnyn921XTng0sAJfeD?=
 =?us-ascii?Q?zDgsePwTyyEu5v2xaZJus+t4wkh4kocq+qwe2DGwK+EMsKL4ayWcAhjmAWZK?=
 =?us-ascii?Q?oO/USUsfrudCruw0NcBXVJRX8RnQ/vIH3TXca4qL6SDCy1lLutTbWPWyBQlR?=
 =?us-ascii?Q?+LiM8+aCcTOx3xcUJXs5hFQV0uUGII08aaLsvx+0Kjw4v4a/JFDx0P9oTuyZ?=
 =?us-ascii?Q?/nSKAf1+b0HNmVkOLHUZb6lQTE7mfMD5HRRNG8HmmfokUcPHvZiTzMYO7dNC?=
 =?us-ascii?Q?MRDP9HOG0Jq1Y/daGqs52Qs0/dLvoNjd55hfNIjMPPra/MdAGw+WMLz6l75k?=
 =?us-ascii?Q?MLOqGKCZaNRKKoqNa3fRSCwwf5jv2poxz8db/9KquQd1mdjQlaYPfCZtUcpc?=
 =?us-ascii?Q?xNKcAos1bYy4Hky7A//FtU6+YJD9tYQ+QKOabqmsMz+gyIAEaqtlS5dZQd92?=
 =?us-ascii?Q?QrfZqaUFFC5T6TgNZY1HBFOnE/id9X2ICRWApVcLdjo1MWLY4OHOpAY66ynn?=
 =?us-ascii?Q?XKxZw09qZwJhdohtyaL1l/f0vEExWc7mPNwvzhg95wlnEk+Rcpawkf+6srEK?=
 =?us-ascii?Q?CxMBOISLXdwcDMXUA0Kqz0Mx28KiHMb7ubDZR/SCiNRQGhA2d10PT+KwOU9E?=
 =?us-ascii?Q?fy5Jc1ZLFaJ60su6QX7ulIGkTiSZ00yd2CgwWNEkTLoAJVh8cTOaABwT7cdW?=
 =?us-ascii?Q?TWcyOrnJHiw2kanO5hXlo0gKYuXKAoLkRZhArc0ISijN09dD/EA3aUoE+4up?=
 =?us-ascii?Q?Bq0CxTbcpMrrZWvqBhnR0jl9qnpz2QMizDdFxfdMdXvtp4gCJNEgVKuBs4go?=
 =?us-ascii?Q?QkcBcj18i0jRMRgTj/aToPzZNjeNbVRXYHxifySYUndscVCq9HZf2Ufp4mEj?=
 =?us-ascii?Q?IeeHnokE4tRWrbliR9MnUUK1b1z+Q7BFE3EE8riKFxyOwLo3D+ARpyowofcB?=
 =?us-ascii?Q?pxI8vUgzob9k1juun06RMeftbwMFjVrkgQVa463n/87sCmMzwJUFlWT/iIsl?=
 =?us-ascii?Q?YVz7eLDCOgq+nBDQCoUZ0BUky3DLre8VrJsa1T51W3XbDXBxDh3CXQYgx+FC?=
 =?us-ascii?Q?4cVSKUl62rCf3w4cR8AsLxK14JENYPyuzOe8i2hEL6Eai8FEd0EOzSaxLUmd?=
 =?us-ascii?Q?Qg00sQn44Q9SU0skrOGljns38n08lK382KJBm7xFyTyZxHZ+Vwmlu9BF1S/K?=
 =?us-ascii?Q?VNJUqHUcJaGnpEAl6vz+S148hTm/su9cEh4zS/XMRAIUDU32G2ASbUlsNuOK?=
 =?us-ascii?Q?FaZQmMQDVF9MyYO9Zw2NUrhZUaLUiiPx5sn5tSvdltqeB5kAQdBOKiSPJ242?=
 =?us-ascii?Q?tMjhi1BFE3DuE6IvltIRJfLt?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?q0GT2vlYQKlOST24b6EdWBsaZ+wNR6zkwvwbluG/CEu2CN/as85mQJXkbuhr?=
 =?us-ascii?Q?X5jrn1X8Oep5b6Y14tZEdL3owG0daFXjVNLcA+3jj/p1Mvny+oe6UcvyegqE?=
 =?us-ascii?Q?+mULm2XRI/ZxwgKXAIvnpELoo2jMoJjCoyILep37rEaTlVocU43rEhv2UA+X?=
 =?us-ascii?Q?VODERh+TYfIARftMAer0BsCdQeEZoEh1NVFfdKBnScYC1kMn85t8tqNCx+6T?=
 =?us-ascii?Q?Vw3+g+rTKqZYEwTtvwtf17d0hd0zdy3sIZj+9oI0Kf7J0jYqlF7M2wcFEphP?=
 =?us-ascii?Q?xUXB2oeb6AFYxmjMq0raORFi6qePD9Pg3529Am5zW0YtKM3OJDyZ8s6LLtuL?=
 =?us-ascii?Q?m+MgA+c4QeshIkmpmtb3JvzZNI3gbBMKJ+i2vhXEkSluLB1rnoIqrVpGhrUz?=
 =?us-ascii?Q?IG/Edx28oEvDl7epLTkbmSaso2KjghVxDg/R2mE4djnt7brMQ4/ep2hD89oe?=
 =?us-ascii?Q?6lNc4UaZHfaPo1+Pw/5rXSijcyyQU+8S3sUW0gdjokFQ4TP+ifsDQV93N1/o?=
 =?us-ascii?Q?ppAdwG0NAGy+iZeEejQQH811n3tfky8UuwG8Em9vHevwzuxGJVv+yMV1z8Pu?=
 =?us-ascii?Q?Y16HinnLP8vN03x8H/p0dlt6esx07v+l3rQeSUNyi7Qh8SBQYe/5j+QYN1VJ?=
 =?us-ascii?Q?MLt4e0UZGHHgcwnctsS8h3qIdtFjkeKFgG2/gLsTl14ztksb9alxrhRI2+KI?=
 =?us-ascii?Q?1DVSoxcfH3SoOHvsfwj2fO+xnA4u3ZteJUKCV+VniQkYWffZ4rgXfP8Mavo0?=
 =?us-ascii?Q?sm4zB70/uxIAQFOoFPBzgJGyXb7p9/DwO7nHtxWkY11CHAHb0dpO+Qqf/MmG?=
 =?us-ascii?Q?YBMQoovDHbNsWngLtFEKWsdS5WNmWV3s349uiJ07k8Goo68+StVvoRNu4NXG?=
 =?us-ascii?Q?jAY6nxGkke+ui9ZrsKTWRb35b1xSkFq+JD1u/zoAojk3fz3M0QYptXyKn5ci?=
 =?us-ascii?Q?V4GeJA8ICwmeiHwKAiMlunEDrlgkkKroHuD2xA9uD9s7oFtRiOZLSTzRjCiU?=
 =?us-ascii?Q?3WPXCqP3d5TbHcGeIhOgDYkY6xfiS5nqiRHrhkXn3iJvhNlMUiOMYgDTk47h?=
 =?us-ascii?Q?MYKiMkS+p/bOXXVfaKYH2DNoLvEJ6dmtEdEMQ7iqhVDGdRfNQbtcxkKaOguJ?=
 =?us-ascii?Q?6HgFg8kZSJQxTdkSbZAaK77HNwcOqYnRxOBv2P+0JJB39BSfdiwP/j9fkChD?=
 =?us-ascii?Q?mdmkD6aIFWrpPFdFz3N6EvTix2DwlXamU8ZMEWCNoWP7dSFJdLjFNtUK1NDZ?=
 =?us-ascii?Q?1Ypo7uJQELk8JKw1gKzZjGAlUXaaWQSTwnVLvdsFd+dGElcb+2035ShewSi6?=
 =?us-ascii?Q?3XodvNM5flN6EK+Ch53YIPRatlAS1NqKJA8NTbnTmTnt2WO80QHtlmEcAssp?=
 =?us-ascii?Q?/AOoY9xgeLupwdJHA6sf1mSBWSy+JxmMk6WvaYJxQJENYx6crGFxMIZ2/2CC?=
 =?us-ascii?Q?88eIQLVH8kcAzNxUY8WMnY5aKKcCZymbPrmdJ+NjrgqAMAO2pCei/Pu4IDYg?=
 =?us-ascii?Q?Q4wWzEAwQD5kZY1HjqndfHF0bcgzcwjBnyKxEXxGQCqFjb5/W4/UfYqfg6tM?=
 =?us-ascii?Q?OIH7+fKVRBAnDMtf7UvqPxNPMiRbsC5gN5KKg8oiM7P4VqZk3lXrmDHJyDuz?=
 =?us-ascii?Q?ww=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4kWyJC96Z2NxM/yaCFz/iZpO8QZd/5NxlmACGZ95Ugvk291ByEsn6QVeVwUEnUzE/aD7AGzgTFw9KbbREb7DPD/UF3MxHbSgytg4f38Sud1n0my2XDPmFdAnWUVax5xDdV/44z+SYqKyuPoqckEC1X0YCID+ANEbA0FipkYjm5tLanp/r6dwqrjhjJPk9B90p3QQOtPA9SRGv5As2gJAsdisp6juu/VW8xwx9JEDI5fYCgWS5/MZoiR0w3nXMMH+ZwUJ08g1OcquqiTxj2PQb4MlzlT8u3oAFQG5/i4dbJH9QDKpmy10N/k7KR0zlh8GVECCEpM9MfyUSTpriuShAze3r5o6QWbMfzxFLK9EHFfatT1yZq+gJyh6qd+0wsGyt7mqv0poz6FKrTnh2dOgxzvZUpyacdIY8d6Hc/XUYXy6TElgbdEsaMQvJXmNX3/BJx6On5RPXR1/JXtMlkZ3QZ9nnqMJMujrOOsG8BJTCtvwaMPc7KFUkus+Vk1hIjOKG3K5EKtE2LMrOx511xPgMrc3sEtRDHRVnTcMk5HtftUapOnqVwek5ulmie91hDvrDKnY4+OBtBxKz1rHCTWQ2uhx4fZLROrIpG0m++fVbAQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae6b0381-a88a-42b4-c894-08dcf5916bf8
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2024 07:40:11.2737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IcUcbQvlu5+XZ0BasIzH28NznQrZR5gbR2PLcqowoKfd582DA15Rbaa5LDJTlUtb2loum4CO98ONm8N04g4nNCwcFKqyKWeUHEMg14rExYQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4854
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-25_14,2024-10-25_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxscore=0 phishscore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410260062
X-Proofpoint-GUID: cmNxyKpHzK6GyATXT_gepeQxeyQH5T95
X-Proofpoint-ORIG-GUID: cmNxyKpHzK6GyATXT_gepeQxeyQH5T95

On Fri, Oct 25, 2024 at 05:11:31PM -0700, Andrew Morton wrote:
> On Thu, 24 Oct 2024 08:25:46 +0100 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
>
> > I actually do plan to extend this work to support shmem and file-backed
> > mappings in the future as a revision to this work.
>
> Useful, thanks.  I pasted this in.
>
> > >
> > > (generally, it would be nice to include the proposed manpage update at
> > > this time, so people can review it while the code change is fresh in
> > > their minds)
> >
> > It'd be nice to have the man pages live somewhere within the kernel so we
> > can do this as part of the patch change as things evolve during review, but
> > obviously moving things about like that is out of scope for this discussion
> > :)
>
> Yes, that would be good.  At present the linkage is so poor that things
> could get lost.

Things _have_ got lost. I don't see MADV_DONTNEED_LOCKED in the madvise()
man page for instance...

(I intend actually to send a patch for that alongside my changes.)

>
> I guess one thing we could do is to include the proposed manpage update
> within the changelogs.  That way it's stored somewhere and gets reviewed
> alongside the patches themselves.

Hm it won't be a diff but I do like the idea... let me come up with
something.

>
> > I do explicitly intend to send a manpage update once this series lands
> > however.
>
> That's late, IMO.  Sometimes reviewing manpage updates leads people to
> ask "hey.  what about X" or "hey, that's wrong".  Michael Kerrisk was
> good at finding such holes, back in the day.
>

Right, this is the problem with having the manpages in a separate repo, it
seems presumptious to _assume_ this will land in 6.13 though I hope it
does, but if I get a patch accepted in the manpages they may ship a version
that has information that is simply invalid...

Really would be nice to integrate it here :)

Michael Kerrisk is a hero, writes with a power of clarity I could only
dream of :) understandable that he may be rather tired of having to
maintain all this however...

