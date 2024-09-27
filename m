Return-Path: <linux-arch+bounces-7470-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C97D398859A
	for <lists+linux-arch@lfdr.de>; Fri, 27 Sep 2024 14:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E312C1C21055
	for <lists+linux-arch@lfdr.de>; Fri, 27 Sep 2024 12:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A213F18DF6A;
	Fri, 27 Sep 2024 12:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WNNiSf6U";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ui15/Hse"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7787418B466;
	Fri, 27 Sep 2024 12:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727441548; cv=fail; b=YelqAlODcCHNeRQHjHJZkFQBKe+FCPReosG0hhVni+J9ieoInH8h+RYfKulBZq8IyMVHUeSp0C+Tgp8TgzD0/cB+hj3DVpgv+oCuiHzn1YXGlY+P65oEL9L4n3cPDVK053i2b9jbYNpvwgzLn/RQU6xxoH3rBKNuRagQDx8bzCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727441548; c=relaxed/simple;
	bh=F2ju8NVEUjG2SvwzV1wENRCZtSrbVvgIK0MdcLw6IYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bNSUEld0HinB3sV9CCPOrCzC4oTQgYqQ9wkhq5wcg8DXKn9dJrkpGpiQzwu0F35sPNTXcQhSLZ49wFapo2xZHdOUIxg9xudivo/SlgLjijqNPDGlpQhCqSA7zVICb6t7qoPHU7M7uT2gsbXW9VrclJKBTJ6aUr1ng5Ifr0djTvI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WNNiSf6U; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ui15/Hse; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48R5gn86011530;
	Fri, 27 Sep 2024 12:51:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=HYs3jzg0JLu5EL1XMO6o1UbSYzKVs8l4lN9fQT47oA0=; b=
	WNNiSf6UoDqF2QyZR4IUCmpFq55PJYRo9a22F0CNk57h6PTqKtt8+5OUf9HUhzpm
	zilPpX7ra1sNUYLagKB1Vb5H0jQzEhPYxXkyutuiKdMD2ZRYOCuILuxB9OVghj+B
	zXtwFx5bwU77/WmCuE9Ok8hX93NPZLBENE67maPlQG+ZgST96gg8p3e1OaFZid9M
	1m7/aWG6PsvX8znAt+t6B/BtXbCyjc9CFcF42cRjPAVnXKhParEaYFp1As7/MdG7
	AXDgv9n+b6aBjBgKmjn2h+Oq7/ltLNxdY30XWBbA2+h424A6qQ0RX7jeO8qARkNH
	7dNY8z7W88za9fKt8bqbFg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41sn2cyqkr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Sep 2024 12:51:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48RC6BRA031173;
	Fri, 27 Sep 2024 12:51:32 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41tkca26md-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Sep 2024 12:51:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YAFhQ30qAPZWUKNaOVaBCVfLO+x9WhBJhUHNZHiytI5cVHwg7ZYtMbI5DkGSEtR2wp+3KROBeD0ouY839JdNrFixhJK5yoesd61RAOxqlPX+UVA4tYHcypqkCN32helP45esFm0HqA7zowVe6Ac96yyCE1pgi7y1dYeRgIf4EykAmkYrD3y4UCJfc7LeXSLL+Ioh7XmbhhGIPCvh5rrBDlYTbri+mNUft7K76AhHOG/rSYOUh8Jyku9Et1XKKpropU9P+6q4YtKYfDuBe6vB4p4GEukSOkpVnxjgeBQw9YnWrT7YVrKAl1BAS5ZtuH2p13NsVmVIDBlP3CVb73zGUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HYs3jzg0JLu5EL1XMO6o1UbSYzKVs8l4lN9fQT47oA0=;
 b=RHWYf1Ax4xNARkzaYZq4TePifKFqTH7pDU/gwWkv+XeJ3vjRGzae4nY2UBeieCKMplKfrXUIpHGArbJILKNGLn1xhjIALQVxeRs8kS/nozafbjk9cpUe52WU1EtpY6bNuAWpzkk8wt6vVfvymcEcVLRaB42OKlzivoJP+MnA9VOuhjlDy49FJ2kePrO8J/OOvYey5kLsdVxPeRrAdTRNJSAITN7ZzT53bVFL/cMDKat6CoM0h1cepY1nS+3xdkXrBN19cOAcGCKnLCPCjr28eh+nT+o7wzrzacxD/su074N3LwAIpCMIMHMrebXueROQN7Wcf3UC0Ecgv08TXhgAuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HYs3jzg0JLu5EL1XMO6o1UbSYzKVs8l4lN9fQT47oA0=;
 b=Ui15/HseJVPXLKJ5yGeG1peScggygMQTimLC2kw5UiT8bgbR+us5i1oBQnBCjkBhLL4DYqpjQGIDnKB8s47xFStie4uXIwbExxY259MWM3wMlo53MkgeRQFuAoDei7ZgMj3z7aACOnju3rsMEkFvqfIMAKrFFMzBcSfrfg+RT7o=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by IA0PR10MB6820.namprd10.prod.outlook.com (2603:10b6:208:437::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.10; Fri, 27 Sep
 2024 12:51:29 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8026.009; Fri, 27 Sep 2024
 12:51:29 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        "Paul E . McKenney" <paulmck@kernel.org>, Jann Horn <jannh@google.com>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Muchun Song <muchun.song@linux.dev>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-arch@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>,
        linux-kselftest@vger.kernel.org,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [RFC PATCH 1/4] mm: pagewalk: add the ability to install PTEs
Date: Fri, 27 Sep 2024 13:51:11 +0100
Message-ID: <59e218670565accf978aeb8cf4745de4c0738773.1727440966.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <cover.1727440966.git.lorenzo.stoakes@oracle.com>
References: <cover.1727440966.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0003.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:62::15) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|IA0PR10MB6820:EE_
X-MS-Office365-Filtering-Correlation-Id: 31a2abd9-f03e-4755-b6d8-08dcdef31ae0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CTRuWcxhnS3Mqtd0e3Q54nT4QoMa+xflNxjD6mppLnVgK8Qm1c7BpNVawAw6?=
 =?us-ascii?Q?+Wed3ORXZwC/DjCO1jPRj973lBPp+ChvOJh9ItoT1nwyQOfmtsxhTPpm7hgt?=
 =?us-ascii?Q?gjJguYWSN79I6cScVjci+HH8i8YvdDO1m7arnWks4PICdIeijFLSrVP4SUEL?=
 =?us-ascii?Q?IApom956L26Q5WEq9Eq4jbXTqVS1KtxUUWjofQA0J/pu4FPQMaWXo+etG+J1?=
 =?us-ascii?Q?wbyDOBYDijzGMFkKgimUu+xHJ3fzX65YW5WNVz3u1NYNpBkM9U8Skq32NF21?=
 =?us-ascii?Q?R6+NHA5XdK2IScqari9HUJ/RBfZEeoSQ8X5FAz6Fan5L8wFv2mpqjV1Wc6jp?=
 =?us-ascii?Q?8dV6sW9iw43fgHzDZjpYVBOG88+k7IUjN59ybGpFxiWytUx0tbMSPiLmKr2L?=
 =?us-ascii?Q?hmV7pIkoJZ5KOEZfz0mOKD1a6V48vDJAy9qQb2oZCckd6UGlsUOBVq/H4v+V?=
 =?us-ascii?Q?o/HS+ovA2pCDXshQmxl1cHeBvjUSRXCyqyx+lkZZjaFNoxN5cb0o2/nO+onE?=
 =?us-ascii?Q?jpPB0R+YTM6KmHyOufso6xmipQsveL7Fe1wpuzpGTZQBl0xebWH4SrqcRV60?=
 =?us-ascii?Q?0mK3MQhyzGLb7UC0+8ceq7nau6Q0cv59VHU80ZIXyf36eT9jVrTshN7WxGCT?=
 =?us-ascii?Q?abj6sB1g974pIQavZD123ahyhAIsnNG6iB7TGlv14lEfh+SbYKL4lYCb4lMl?=
 =?us-ascii?Q?TuV0FaUrfus06oPqtjisylIJApqQBfBH94+Zl9iMhDKcJTr9vnXJn7CwEsoF?=
 =?us-ascii?Q?GXYKpMduD5ClNYlm5Bd2Bm3BY8Ks+IpfcOIXurXVJM7p7/59Ojx++x+E3cbi?=
 =?us-ascii?Q?UH3IGeQgDUiXypyDZ+21s0whXW4iyaTi/OxMSFoLislROZnY6eovZmddRVim?=
 =?us-ascii?Q?2KhLlbx3pOMBvXquWvov4I/5YcpysCM3QlLdxF1mTFC4KP3IX/e2FAPmuj7Q?=
 =?us-ascii?Q?qwJvojeAhORTBGiyAS7vOCYNjX837wZ6W8HoKn+u1xYpi1KTKDXD3Vnm8l/N?=
 =?us-ascii?Q?vmvmjbFOimyvPPZ0Y/QwOigP4KcpY4MtsNIfqnR/qwgwbnOZetqqTft2qVls?=
 =?us-ascii?Q?st+k3azqxLrnz4z3K3gUI9Sw6KaXZuTYwlZxyPsnA4Bne5cN/6xnl7TEw2P1?=
 =?us-ascii?Q?uMm9oXB6rhx517PpyjgXyYybparACJAai8YDwy6pS2SSD5D00RoW/G84MigF?=
 =?us-ascii?Q?y0DsfcL9bP27F4HJ+bql2RdPXPE8EZk6rfPXzHMh6423u8BjD1dSL80OCC9b?=
 =?us-ascii?Q?IXhVnfdg22mgvY0ISN7/oyhyIG6cZa5oUiG9GNCknbfxuHO7CXzPbPfjkJLm?=
 =?us-ascii?Q?g4OGXRXraVrmnuCNL9WTrEmsAK1MyMMYI6u3E21IL52JLw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yfnp8tQLfVy3TUKRI4jTYU/HOYPL/P2IeF1wDljhLJOWg5STcHZXrc57WAGb?=
 =?us-ascii?Q?MA4mpuVGaQNxI8meMHv0u3A1jQVbq4VlvsWiyhMObXopy9PX1qCOm0qua297?=
 =?us-ascii?Q?rQi5sE7lXa+nNn7FEp7RK2oaaHgm6wWThXs3/YpKDRqMh/SAuIUoPDlZPb0U?=
 =?us-ascii?Q?O0+Pt9HNpRd5LMQgKp7Oz1ciPgLPGDulalmeI2Fpe9m3uhwauDGRRyrcUdR2?=
 =?us-ascii?Q?GCavxAmWYfLXhzbAAbVq1SJ943e0Fa4U1jEKJN4drxRv+3AxmhMwjVezAhDU?=
 =?us-ascii?Q?EUkzgQZszsMUh78busZ5C1kyq2dYugPCVp4MwKoAk70XnFcMiJ08eLYUf8HU?=
 =?us-ascii?Q?a/X/F3OqvhgUYmcjQ1WbBpGlS1dpsGe3j3j7Ey3i7tb4GvIuRNd2CvZd8zAY?=
 =?us-ascii?Q?Z3uHz2xmaFYvvja/gtnv+IEnA7zJ5biOlvDCc8cs/TDjmQ1tIQixFKzLXRSP?=
 =?us-ascii?Q?hRoLTdbOqilqSal2p75Sk6tNafr6tHMoL158AVxzoJVeo0cQgr0OLVuiHkT1?=
 =?us-ascii?Q?dH5d7MQJ0W2hNSnn9+Zg/BNFvc72Rj+YoojQ4za+0+4PejPLgC+f6USdi/Wl?=
 =?us-ascii?Q?7Aswmw+19Q9hJMCwueJGoJVAx7lEfKwwimPBLYEMSU7qD2M8mRUS5zafKZOc?=
 =?us-ascii?Q?sFppYROVCtqQxy/xR3X2MpGYCOpd8M4+ohDSfpH1S35tZW7m2RuzQWS9PNTh?=
 =?us-ascii?Q?uXqymFIkXdyvwj6ayZtVoXXY9gvhFAX5y9eSkJ0OyjD0Jsc2xSUxR8yibism?=
 =?us-ascii?Q?/LfndRU246Z+zbLPfaShgwk0ADZ75qyW04hRo2T1Nn1LZ4NuiuOFdF8Uzd9y?=
 =?us-ascii?Q?6+CuM8Ha7Aap9JVTR5m+KPzZm6uEhRQ4lf361KRgOkjxrRA1lQictcl/r5sU?=
 =?us-ascii?Q?cqP4xws8nitlGxWZdhr2Oh00j9s/JpD7xEkY3G78S95vx37T9nhvo33goKWh?=
 =?us-ascii?Q?PYyHAhRm3uSNTXmmRJX0JoUXk0u4/6i7tYAujtgSLtgmFV0X7iYxj+07S5Dl?=
 =?us-ascii?Q?uTFnNVzNZGR2do42Sq4Bjc/z+yI0BzxBlhZs5u140XUG3SNrQT6y5b1sPvFb?=
 =?us-ascii?Q?oRu4RA+VInid9TV4QScsmBVEyefcISwwsagR7XUmPFOy8l/sZ7+MVCEEuNgQ?=
 =?us-ascii?Q?9n4oBmGoRtmdOonwpZPwzvWkmj1B/AFVY+YivWIpdhvRjbKOVbRsoK3EBfzg?=
 =?us-ascii?Q?JwYimJo0XtXMHFx2nIt32bEgixLZyBwUdnHkQEnRI3vAZQG0U+6rMn9Jb+Cr?=
 =?us-ascii?Q?omvqQz9HF4pQyv7TIhpv2b4ziCv3nqPGvXjLJHGLo7VAz6BvvIsUNjjWtPwc?=
 =?us-ascii?Q?Nqm97oai9zHltsxM70zHSR+xLwEQDNOfKvzxXyp7QRP3ZQJJEfJuT+iQ9qnR?=
 =?us-ascii?Q?QfVlDxIoR5fRnf6lXB8TjWTQMRRfALxfjrsKEDCbc97/pE5r6u4IICdaDiCn?=
 =?us-ascii?Q?B/xQD0Bb9wTY+TkRjEYDNl+oX2Vr8fUOu83ieyspK10iRx9s9VmIx3YCVKkt?=
 =?us-ascii?Q?9WHrsk7KTTDxP0heaGxTrgfqG3vAyDFz1/VM+CSAdVYGEW2o6e14Gvt1zMRv?=
 =?us-ascii?Q?UgAg46aswFBNssCutiDJtmrG935D4LojkoWI3Q3GxzJAOujDxJmJIdisBSg8?=
 =?us-ascii?Q?LQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4aKobAninOVdCaapb7SMQr5mN+MFbrPj0vXjcEOl8aJCnVTBwBrL7AveyytiBMIZzsWEjXgra/b0X4VodBD9V6k09MP6F2oUvoYTGN+uURlcVZQJpqwGOgx2KSGGodx7IBnwVrSMNtjjlNdtmtH9kFz+DFCJrm3louFtVno+TvQEP+JC/c0Ev9nP+e1EaG2Qlkq3XxFJV8XDmO4qPhBM+4o/5PFTP6wceAOiWkhCn8ZkCdvaJrO44EnZtp+SxfKpWoTralmMWV0Mdzb+HeE4ESGyZu9sAJeH6qholN+8S9z+c2xghLMz88SGtrox6oGc2RPbK0jJc+TBAMhkPyLaieHmS+uAk0Q1XwBmdJGsRmuP7j1Xvh9SGj1+t9VTvr5NDNvecAbElEnOyWB/nSkb4hAeVaXDuGWt+Xtr1BKnVtXJzqdMR/cdESrn89Hcrte236RQqtldXjbeVMaRKgnDSUKUnd2NOhN/OTXlF4kb0sxNGcOQhfyuXUlPTwpVvExbZr5x8RBGNeET3VsEu+jFzchjXxz4B8VNBECSX619xeS6RYY1HMSgm6fgGnjJrjxOOEA9XZMR2U/I3yOTAYw49mjmAaM05iXW/7TPcF8BlFM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31a2abd9-f03e-4755-b6d8-08dcdef31ae0
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 12:51:29.1633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MIOiKxZc4ELcM2rJS2w95DY2OjbaOimXPb7AJFHdSt+XAjFP6YCrJ3IWxqz6Ff7WLn3wTgzzeNVT6U3l7lBYoTEUKmXj5AJAZbMMdhpC0IM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6820
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-27_06,2024-09-27_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 adultscore=0 mlxscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409270092
X-Proofpoint-GUID: n1rpJ1_wR-pKDUoW3fYGIfORbrexpaTa
X-Proofpoint-ORIG-GUID: n1rpJ1_wR-pKDUoW3fYGIfORbrexpaTa

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

If a THP huge page is encountered, we make use of existing logic to split
it. Then once we reach the PTE level, we invoke the install_pte() callback
which provides a PTE entry to install. We do not support hugetlb at this
stage.

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

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/linux/pagewalk.h |  18 +++-
 mm/internal.h            |   6 ++
 mm/pagewalk.c            | 174 ++++++++++++++++++++++++++-------------
 3 files changed, 136 insertions(+), 62 deletions(-)

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
index 93083bbeeefa..1bfe45b7fa08 100644
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
@@ -1443,4 +1444,9 @@ static inline void accept_page(struct page *page)
 }
 #endif /* CONFIG_UNACCEPTED_MEMORY */
 
+/* pagewalk.c */
+int walk_page_range_mm(struct mm_struct *mm, unsigned long start,
+		unsigned long end, const struct mm_walk_ops *ops,
+		void *private);
+
 #endif	/* __MM_INTERNAL_H */
diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index 461ea3bbd8d9..c3b9624948c1 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -6,6 +6,8 @@
 #include <linux/swap.h>
 #include <linux/swapops.h>
 
+#include "internal.h"
+
 /*
  * We want to know the real level where a entry is located ignoring any
  * folding of levels which may be happening. For example if p4d is folded then
@@ -29,9 +31,23 @@ static int walk_pte_range_inner(pte_t *pte, unsigned long addr,
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
@@ -89,11 +105,14 @@ static int walk_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
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
@@ -116,7 +135,7 @@ static int walk_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
 		 */
 		if ((!walk->vma && (pmd_leaf(*pmd) || !pmd_present(*pmd))) ||
 		    walk->action == ACTION_CONTINUE ||
-		    !(ops->pte_entry))
+		    !(ops->pte_entry || ops->install_pte))
 			continue;
 
 		if (walk->vma)
@@ -148,11 +167,14 @@ static int walk_pud_range(p4d_t *p4d, unsigned long addr, unsigned long end,
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
@@ -167,7 +189,7 @@ static int walk_pud_range(p4d_t *p4d, unsigned long addr, unsigned long end,
 
 		if ((!walk->vma && (pud_leaf(*pud) || !pud_present(*pud))) ||
 		    walk->action == ACTION_CONTINUE ||
-		    !(ops->pmd_entry || ops->pte_entry))
+		    !(ops->pmd_entry || ops->pte_entry || ops->install_pte))
 			continue;
 
 		if (walk->vma)
@@ -196,18 +218,22 @@ static int walk_p4d_range(pgd_t *pgd, unsigned long addr, unsigned long end,
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
@@ -231,18 +257,22 @@ static int walk_pgd_range(unsigned long addr, unsigned long end,
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
@@ -334,6 +364,11 @@ static int __walk_page_range(unsigned long start, unsigned long end,
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
@@ -341,7 +376,7 @@ static int __walk_page_range(unsigned long start, unsigned long end,
 			return err;
 	}
 
-	if (is_vm_hugetlb_page(vma)) {
+	if (is_hugetlb) {
 		if (ops->hugetlb_entry)
 			err = walk_hugetlb_range(start, end, walk);
 	} else
@@ -380,47 +415,7 @@ static inline void process_vma_walk_lock(struct vm_area_struct *vma,
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
- *
- * Locking:
- *   Callers of walk_page_range() and walk_page_vma() should hold @mm->mmap_lock,
- *   because these function traverse vma list and/or access to vma's data.
- */
-int walk_page_range(struct mm_struct *mm, unsigned long start,
+int walk_page_range_mm(struct mm_struct *mm, unsigned long start,
 		unsigned long end, const struct mm_walk_ops *ops,
 		void *private)
 {
@@ -479,6 +474,57 @@ int walk_page_range(struct mm_struct *mm, unsigned long start,
 	return err;
 }
 
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
+	/* For internal use only. */
+	if (ops->install_pte)
+		return -EINVAL;
+
+	return walk_page_range_mm(mm, start, end, ops, private);
+}
+
 /**
  * walk_page_range_novma - walk a range of pagetables not backed by a vma
  * @mm:		mm_struct representing the target process of page table walk
@@ -494,7 +540,7 @@ int walk_page_range(struct mm_struct *mm, unsigned long start,
  * walking the kernel pages tables or page tables for firmware.
  *
  * Note: Be careful to walk the kernel pages tables, the caller may be need to
- * take other effective approache (mmap lock may be insufficient) to prevent
+ * take other effective approaches (mmap lock may be insufficient) to prevent
  * the intermediate kernel page tables belonging to the specified address range
  * from being freed (e.g. memory hot-remove).
  */
@@ -511,7 +557,7 @@ int walk_page_range_novma(struct mm_struct *mm, unsigned long start,
 		.no_vma		= true
 	};
 
-	if (start >= end || !walk.mm)
+	if (start >= end || !walk.mm || ops->install_pte)
 		return -EINVAL;
 
 	/*
@@ -556,6 +602,9 @@ int walk_page_range_vma(struct vm_area_struct *vma, unsigned long start,
 		return -EINVAL;
 	if (start < vma->vm_start || end > vma->vm_end)
 		return -EINVAL;
+	/* For internal use only. */
+	if (ops->install_pte)
+		return -EINVAL;
 
 	process_mm_walk_lock(walk.mm, ops->walk_lock);
 	process_vma_walk_lock(vma, ops->walk_lock);
@@ -574,6 +623,9 @@ int walk_page_vma(struct vm_area_struct *vma, const struct mm_walk_ops *ops,
 
 	if (!walk.mm)
 		return -EINVAL;
+	/* For internal use only. */
+	if (ops->install_pte)
+		return -EINVAL;
 
 	process_mm_walk_lock(walk.mm, ops->walk_lock);
 	process_vma_walk_lock(vma, ops->walk_lock);
@@ -623,6 +675,10 @@ int walk_page_mapping(struct address_space *mapping, pgoff_t first_index,
 	unsigned long start_addr, end_addr;
 	int err = 0;
 
+	/* For internal use only. */
+	if (ops->install_pte)
+		return -EINVAL;
+
 	lockdep_assert_held(&mapping->i_mmap_rwsem);
 	vma_interval_tree_foreach(vma, &mapping->i_mmap, first_index,
 				  first_index + nr - 1) {
-- 
2.46.2


