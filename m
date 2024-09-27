Return-Path: <linux-arch+bounces-7469-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E457D988592
	for <lists+linux-arch@lfdr.de>; Fri, 27 Sep 2024 14:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12D691C213DC
	for <lists+linux-arch@lfdr.de>; Fri, 27 Sep 2024 12:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBCB518D62F;
	Fri, 27 Sep 2024 12:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VBh2TWJF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OJcKLFOp"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C28A18CC1C;
	Fri, 27 Sep 2024 12:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727441546; cv=fail; b=uvA4bxXyV9YIsokCdM/oHMpnDMm9w57Uzw8Ifzr7VnZddd10gSmJ8Ojl2SlUWAmc7nDcldlBNOHpu7pS+LGKXuzwcjEkJKjYC+NAr9OaST0wCl7z2cneSjNZOtp0uTmIc3tKWM82V2+LWk/O0p/T+bK8ufCZHHt9kTzkUnkj46w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727441546; c=relaxed/simple;
	bh=idzKkaV6DoD1gpaL9neUbnCU8M2HwXxYgtiGDNCCH68=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=IH2WOMVgirWXoHRbGP6VxL17p2ACxXO/S9pKHaS7tjuVAGjKIoAoGYk+bT8Z5rgc2ZhyXdHM6czG5zZVPEfvN+WBYk49aBanF8fAwtNodFuhsmnloi/zKit6E6QxQ8Eg8V37GuTVNaAFv8QFAJvhHHpU7Xuk3izjlD6RBs9eK4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VBh2TWJF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OJcKLFOp; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48R5hJZC027287;
	Fri, 27 Sep 2024 12:51:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:content-transfer-encoding
	:content-type:mime-version; s=corp-2023-11-20; bh=brc/iiONqZTjOh
	M8gVgkUDdVfGeGuXK+1Gg2KXtZB1c=; b=VBh2TWJFEEDFjv3YBPxYtyKvYN7LLC
	RXHrgb1+LuY+2TfmvGMvmgJQMTFnNkay6LvrrJwNUrDGgystbcT9m52yfOjsdtDq
	URVnD6OVTzfxGRo9cZ5z5RPwHyns46udqk9WXxXhzfjzRHfG/6j7ToSs/rw2qzz2
	pKGI2CfzTOJPwsn9eT2H2a0ogUN6e0yaTsMu8sWABP/P1dgG494II692BtQlIpf5
	5n8gWX4p4uexlMqLOKV8FTreupIF7LQPwnFHCAFyPTGDIe6dV/BqbWtdcd7FyYGn
	Lp6dLjYGNADLh9Eix/Df2Ls091ge9nAVhuBXcJ0edWh/8bHev40Y62SA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41smx3d4gu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Sep 2024 12:51:31 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48RC1vvi026092;
	Fri, 27 Sep 2024 12:51:30 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41smkdeq08-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Sep 2024 12:51:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wbsq8seUyiqH4FNayr25r5P3Bht0bJCJXHrzBjgsr8U71bT5Ww5cWXLFwMcClww3NU/3RtMCccXD+S4VmeWO8RmJ/vpMXqm2FCAHB2Jargltwt7gACjekaQM1YziFSwurzavUR/xRTP1KTqHgOg4qYAW4tFAGmq14nz9yPtnm9BJt3qadELvGeTd+JOV2lMRpBaZIzZAtB/a8oPJAuJOsnnUKG9ezq1mMQ0A9z9yS82HKBOJKlnnsLL1qF72mEhqvNj3N8IM3vt+fDKjZBq3yp6LRwb/wOwGPImbbXtBOa4CVhGJafeHD4L8JnhsFF0viYJAzvYtMsI76AtWlt2eIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=brc/iiONqZTjOhM8gVgkUDdVfGeGuXK+1Gg2KXtZB1c=;
 b=HavmYuZDkAll7SVPbapwHw0YXiTVLbVx26M2D2vZeViQ8foCJ63J0zc3+MgVkoNTGDustGNeVpjjJmdrsiaNG/SiwkO1M4HCZ2sbOSxeCdF3Ti09z8BN493wsdAyJ7HnVv/CIXxge6qHLy1utBT515PwaEE3h9+PW1EFl7JmZO6uk87n3kv6mEmQb/ibJE4JNBKPSWo5q8YHAIt50sCzOl/V0ThRqlQ2KfHChKyYVMNs9RXB860ob6GWjtNMRjJWBzCG/8Yd7/Zh7m5+QGaXg7BxwH11bdlCnXNCNz4OV7U3dklq4uJJ3KcqXK7WyDYLhwx97Vt0Bb50x2L3gajAbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=brc/iiONqZTjOhM8gVgkUDdVfGeGuXK+1Gg2KXtZB1c=;
 b=OJcKLFOpInmLjjwYVAJeQYFmet0ThGXWqEU1jA6qgHgbuzqXU0iJ7fHqTUfr+8SALSCwn0QpsRADWZDnrs7peg0pDyRXWSIOUj+RdIY+XbAqBUE/d+uqR4EwMu4cBMY2NPhfpK2Cmw81Qgfl2sYPHrBiAWW5xJPsw2kpWVZGtVc=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by IA0PR10MB6820.namprd10.prod.outlook.com (2603:10b6:208:437::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.10; Fri, 27 Sep
 2024 12:51:26 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8026.009; Fri, 27 Sep 2024
 12:51:26 +0000
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
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Vlastimil Babka <vbabka@suze.cz>
Subject: [RFC PATCH 0/4] implement lightweight guard pages
Date: Fri, 27 Sep 2024 13:51:10 +0100
Message-ID: <cover.1727440966.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.46.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0362.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a3::14) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|IA0PR10MB6820:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a45d72c-12bf-46aa-fee9-08dcdef3191b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eDDE2nio0Ed4AeBK4kYVmickYhvOFsaNbVy2g/WdEOsH9bLSpgryVZNyUZJD?=
 =?us-ascii?Q?yaBQjMw+7BzAhadmSYvSE90tan1JGhgBgVJ2Y9+jnmY5uLIH+FciVJYA/4qx?=
 =?us-ascii?Q?nzebckAAqNB1wAA4XtTaTwxbChe/RUhJPqGphSIZH6p3S4cfcEw+js27tPlO?=
 =?us-ascii?Q?/L9YHAfKwHnT/tqQEJWki6PeA9ylcs6R6Zzav9WVTYjD+bdSRqo3rd1Ti73w?=
 =?us-ascii?Q?IKg1++N5esOp5tRfyXw0uBCI3k9fUS9HkXgHJQ7MKi+HrqIfYqWOnTi5zDU7?=
 =?us-ascii?Q?F+Cxyocu3MvZs9NSMgzM9rI2zoUe0OT2BxUjaFuJGdkHNMzKfoNMyC/z9AsW?=
 =?us-ascii?Q?jAUG2y7N6zK7wXRfoOwtYQ6A6/TNbqqErLB3fQwg4LW6xmqON3ldC818/r/M?=
 =?us-ascii?Q?1959gZNrAOjrsPk+nk55FyrfhziGO6jTGMr+KZGao/KJtEz2bGEzqfAjYmUp?=
 =?us-ascii?Q?A+CH53nM+DsSjf6DGiZbAoD8YT5sPEFE/VjCALyKqJDMpvGQW5cJB1f5/WWm?=
 =?us-ascii?Q?jAKAG9KiWAO20VtUHp85AZ0EMH/xy2HkasOUqslGMk/HKNrAFId/eCRrK3x3?=
 =?us-ascii?Q?u9XN/2DBpxnMkIeRHR338EWfEavlS0tHIV5UvSgGjmv15c9lrOxm1tPq/E3A?=
 =?us-ascii?Q?HHGBhnYNyPTGyQ9V6wnPbFf3Sn+9YTR37yw4GR9cVo7pvxMe8F7yp71F7Gw0?=
 =?us-ascii?Q?gqAWQS3sdJbWPh7OurcmCpmIpYPJn5C93jNWF7ZZbpA3mDVhnbJ+hGquN5NC?=
 =?us-ascii?Q?9iDh2tgjdH+fNcBt5nkiHMS/ximbR2JhDlX47NL9J1KVKawJGC5rJ2ZQDLM+?=
 =?us-ascii?Q?37umWYx+Oc0xehi35RS2+zdJtFFTrY5xQ/b6dJwucYhCAPqWjVSNbJ6eHU5R?=
 =?us-ascii?Q?JzfIxZWQMgCayCKW3lbHWzDwJ0ncbNdVDUY6atnQHqcokZWho4bbqzO50f8e?=
 =?us-ascii?Q?a5cYtN110957Q29TE2vjNVvAs+hscErqzzYHbVpid3vI2j9KdJKTAQtHsZdr?=
 =?us-ascii?Q?T+DPKrJIR3N7HrHNAfU6ZawRwzF8b+YEekaJYOiFMjLG4cz8wgJHaJclCqB2?=
 =?us-ascii?Q?rspgdrvXnzDexJ60SZf2raziwbNaBQX4dQ5vfVRfiCqvz1KMK6bdmcYaGlyZ?=
 =?us-ascii?Q?hlg7mLq1TX9i5YyG2SlMSQEj2tu0Wn/+V7301UwWImNE3QeANIlcjdFz2gg3?=
 =?us-ascii?Q?hdARU3k4obvPnLi/2Sy75SrvqccldZh+faNEU9QQX58H+uWh6RF1N0BqgS+D?=
 =?us-ascii?Q?JqDGjSP3iDeX08ShUtF6fIvEUvnyC1DucE203w92XJQIJOBZ3ZwablBF/dBl?=
 =?us-ascii?Q?dgHu06jtJSt17xZ38yUx0LtXyygYbUaUjP8OFviqI+oLbQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oppQ4deq6qcHDJ413K52oHbMUKrD/71D3r7hsJvvcTiD1ilBE6iHJtxpwMhy?=
 =?us-ascii?Q?tXW5jApKuV3/DTIPoI+yEGZY97QRef8+Wyx5GZt/CizTs4TKGng/7wY71OCI?=
 =?us-ascii?Q?jYuKiQ8QOLF9ceg5S+QzhnJiJDWEN5j8o2dbuRiT48+/I2qFD9CtLNn0d/7M?=
 =?us-ascii?Q?9DkwHMfPLfusP/zYu9fG3+ppC56UQS4M+51XbWnybzmeLM3twkvageJEm+xQ?=
 =?us-ascii?Q?/pjdr1Sb4NTEN4uPNpMsyC1EokCcM4qpIAUbwtbdDD5eYb+oA0cFzmjq+j64?=
 =?us-ascii?Q?Oukrdh8kr3Zhm3gvtm1fThfArqX6wcSO6zpegBNzbuDAxm2tIsAB4vGiCXec?=
 =?us-ascii?Q?NfzUU0qvg/DPC3goNTN3+0h+7HszRSqxLdBDusAAhwr1JPrfRrJjVBpn8fkR?=
 =?us-ascii?Q?aWs8GRkgYuXiVXLZmK4wdR48fMbTRdYrJcTVY8Ci++tdCoQTNiz5joswPrNT?=
 =?us-ascii?Q?fTJQPreGaFD0Ddtu4ogSZr0iO3FsVPMJx6fsR9bkPGVFgEcQ3X5DweTiZJfJ?=
 =?us-ascii?Q?pzBfQnq4qzPyD2do7idbMJOngojQVZfEJ/S0hv2ZDgVWYu4vPoD6oI4RkAPH?=
 =?us-ascii?Q?MWG2/4pHMT77AsC+XT7A39ktvNHXGtozm6xAIMSe+2G7vtwwgYQ9oTkx0I4K?=
 =?us-ascii?Q?+pYFX7EGTnRMi6AgRf/sDng5z3KlJDjma6AdRfXVjfeSIvenp6/RDLJ82X94?=
 =?us-ascii?Q?mjZzeWQ44vOWtNile7dRzc3mpDb1uvcsLqDXVVYvhs5Ykl1z9nFlNgyjwkMQ?=
 =?us-ascii?Q?Z0iWgYQCpjzmdOPx9MBf/A9sgEh1iL249udCgpMCAQho24xxQSarvjiVJ2kW?=
 =?us-ascii?Q?Bv8YoVxkSvOy/F2o/UcyE9Ca6SqxFb7FnVEJZadcuhXacjndm0TVpd0zk5dy?=
 =?us-ascii?Q?ZSGGraJoDyXVu74YcDFxgSxE1Num+U1NvMDzMCp9PBhaTo/2lABuDWruZgbs?=
 =?us-ascii?Q?7uP8U02Ps95QLP9YUEe8+8TTq7YTl1zR2Hu+/2Y8ZW12xk8YOgyt9uzTwcpi?=
 =?us-ascii?Q?TdkV3EEHvvCA4ViF86+321PbV4puI2OxQWUg1PX9xfFX9MBQXBPNHQOGtnua?=
 =?us-ascii?Q?LeE+ZmEUGN8cwtH47EQctWL9ro47aRxJwYvx0DqZ3HRz2JwP9J8p5GCYr4+N?=
 =?us-ascii?Q?DrWNVKSv4I96XCtQc7zCPuAyhkgLMKQ+XcUsnMIJk+HDxehAz/LP3NRNeS05?=
 =?us-ascii?Q?gIV3m6CGfXeK3lwyN72qf53GfvJaQY8P6P1C/iCuVc1pGF7MtZLab0Zhv1gt?=
 =?us-ascii?Q?HShhICA98uGSjH6fOc6xthutYsk/KQWNGdhDc3fYp4zaBVRS9AaiC5MCJLXv?=
 =?us-ascii?Q?Cbd/9e7ZvVS9pKmBlgqa4pzF074RvnAl+UD0zncs6z4QVxCCr8LaFz/qJCyN?=
 =?us-ascii?Q?eIZy8BuvZpJV4pCX155MculUNkiY2b8g+oHbD+mQVIoMPuUSCMz0ENi+hpsK?=
 =?us-ascii?Q?lMGti2+mI0QkaNEXWjgD+K5cYvns2MbjQ9bLT/DGgc8OFxOQDonxlFPBwXHk?=
 =?us-ascii?Q?bw9aLBJOBiyI3piH5LoYcZZ8NIRLyIaz0vd791MlwOMa4AanBOOvpnBxea9+?=
 =?us-ascii?Q?rSE7MmUWmjxn3VS2b1sXsZchbQtcAJ0zo0vjj/e0Ipd8pkOpuV9hxxP3mDul?=
 =?us-ascii?Q?+Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1SfJMcyH1H42zHQMtffdiUyuSR0JawG8ba/A2UBXR+o72bud5OvyDME/Q2WNYINsJxxElJ4FwGH1wSmlsBsIRaGCjZbKKya+Z7PY12Hh9VsG4lgaTsMEXDDK74/KiMrXL8x/KOQE6vjnTgm6Gg59e4rxi/xxF7VQBWJvqcaHdtNm6MRjSvxc+ZkLwjRAomaXircO77UoTr/z1FE5MN1mEG4lCNhhc5kosJ9HSl1MDReAi5iSnk5Vfh5beY7l8QEv1iaFXu6Vw9Le4p+LzPGQVbtLuzuilEPtfiAsH/3J0iLCzaVRaE/1OFH+bKpRksaHcqxs93kH1UudlgG7OMX7TnNfgR1KCvSWXDkcUbe5+h/0iCTIQgCzVhxMGQuMUvejArcJ4S6vweuuOfULxzXxsnUWBeHsRVWSoa2IrZYx0i5NK/n9yx3KcMFb2O7ZCfXKmHj+6soAO2qxel/x98pjtC+dK9M6OeeoiWj00+SNoIAR6DIrsaoWaQ0ZaaUmkb4PF0xdfdmY4xYBgJUtnNIkbYWaJAUoTxvBLMUw7ZbTdH32qAg4jpYFk6soNHULdEUrdIPckRho2CvIyAhTA+Ldswnwqsk+sArDQuo9j2rF0IY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a45d72c-12bf-46aa-fee9-08dcdef3191b
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 12:51:26.1000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wDoJKOv6eAE/l+o9vnEj1Xo+aK7EBfYdhgIsL/LSeC0RqtiZXUC7OREadJO0w4ln3SFlt7AWJLvZIyguZiLr+xvHJXvzhUroM23U4gpQkLc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6820
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-27_06,2024-09-27_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=466
 phishscore=0 mlxscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409270092
X-Proofpoint-ORIG-GUID: _CX02jqr3iHHD-HTitgiqJqAAYEv9HW4
X-Proofpoint-GUID: _CX02jqr3iHHD-HTitgiqJqAAYEv9HW4

Userland library functions such as allocators and threading implementations
often require regions of memory to act as 'guard pages' - mappings which,
when accessed, result in a fatal signal being sent to the accessing
process.

The current means by which these are implemented is via a PROT_NONE mmap()
mapping, which provides the required semantics however incur an overhead of
a VMA for each such region.

With a great many processes and threads, this can rapidly add up and incur
a significant memory penalty. It also has the added problem of preventing
merges that might otherwise be permitted.

This series takes a different approach - an idea suggested by Vlasimil
Babka (and before him David Hildenbrand and Jann Horn - perhaps more - the
provenance becomes a little tricky to ascertain after this - please forgive
any omissions!)  - rather than locating the guard pages at the VMA layer,
instead placing them in page tables mapping the required ranges.

Early testing of the prototype version of this code suggests a 5 times
speed up in memory mapping invocations (in conjunction with use of
process_madvise()) and a 13% reduction in VMAs on an entirely idle android
system and unoptimised code.

We expect with optimisation and a loaded system with a larger number of
guard pages this could significantly increase, but in any case these
numbers are encouraging.

This way, rather than having separate VMAs specifying which parts of a
range are guard pages, instead we have a VMA spanning the entire range of
memory a user is permitted to access and including ranges which are to be
'guarded'.

After mapping this, a user can specify which parts of the range should
result in a fatal signal when accessed.

By restricting the ability to specify guard pages to memory mapped by
existing VMAs, we can rely on the mappings being torn down when the
mappings are ultimately unmapped and everything works simply as if the
memory were not faulted in, from the point of view of the containing VMAs.

This mechanism in effect poisons memory ranges similar to hardware memory
poisoning, only it is an entirely software-controlled form of poisoning.

Any poisoned region of memory is also able to 'unpoisoned', that is, to
have its poison markers removed.

The mechanism is implemented via madvise() behaviour - MADV_GUARD_POISON
which simply poisons ranges - and MADV_GUARD_UNPOISON - which clears this
poisoning.

Poisoning can be performed across multiple VMAs and any existing mappings
will be cleared, that is zapped, before installing the poisoned page table
mappings.

There is no concept of 'nested' poisoning, multiple attempts to poison a
range will, after the first poisoning, have no effect.

Importantly, unpoisoning of poisoned ranges has no effect on non-poisoned
memory, so a user can safely unpoison a range of memory and clear only
poison page table mappings leaving the rest intact.

The actual mechanism by which the page table entries are specified makes
use of existing logic - PTE markers, which are used for the userfaultfd
UFFDIO_POISON mechanism.

Unfortunately PTE_MARKER_POISONED is not suited for the guard page
mechanism as it results in VM_FAULT_HWPOISON semantics in the fault
handler, so we add our own specific PTE_MARKER_GUARD and adapt existing
logic to handle it.

We also extend the generic page walk mechanism to allow for installation of
PTEs (carefully restricted to memory management logic only to prevent
unwanted abuse).

We ensure that zapping performed by, for instance, MADV_DONTNEED, does not
remove guard poison markers, nor does forking (except when VM_WIPEONFORK is
specified for a VMA which implies a total removal of memory
characteristics).

It's important to note that the guard page implementation is emphatically
NOT a security feature, so a user can remove the poisoning if they wish. We
simply implement it in such a way as to provide the least surprising
behaviour.

An extensive set of self-tests are provided which ensure behaviour is as
expected and additionally self-documents expected behaviour of poisoned
ranges.

Suggested-by: Vlastimil Babka <vbabka@suze.cz>
Suggested-by: Jann Horn <jannh@google.com>
Suggested-by: David Hildenbrand <david@redhat.com>

Lorenzo Stoakes (4):
  mm: pagewalk: add the ability to install PTEs
  mm: add PTE_MARKER_GUARD PTE marker
  mm: madvise: implement lightweight guard page mechanism
  selftests/mm: add self tests for guard page feature

 arch/alpha/include/uapi/asm/mman.h       |    3 +
 arch/mips/include/uapi/asm/mman.h        |    3 +
 arch/parisc/include/uapi/asm/mman.h      |    3 +
 arch/xtensa/include/uapi/asm/mman.h      |    3 +
 include/linux/mm_inline.h                |    2 +-
 include/linux/pagewalk.h                 |   18 +-
 include/linux/swapops.h                  |   26 +-
 include/uapi/asm-generic/mman-common.h   |    3 +
 mm/hugetlb.c                             |    3 +
 mm/internal.h                            |    6 +
 mm/madvise.c                             |  158 +++
 mm/memory.c                              |   18 +-
 mm/mprotect.c                            |    3 +-
 mm/mseal.c                               |    1 +
 mm/pagewalk.c                            |  174 ++--
 tools/testing/selftests/mm/.gitignore    |    1 +
 tools/testing/selftests/mm/Makefile      |    1 +
 tools/testing/selftests/mm/guard-pages.c | 1168 ++++++++++++++++++++++
 18 files changed, 1525 insertions(+), 69 deletions(-)
 create mode 100644 tools/testing/selftests/mm/guard-pages.c

--
2.46.2

