Return-Path: <linux-arch+bounces-8256-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E3899A2EF1
	for <lists+linux-arch@lfdr.de>; Thu, 17 Oct 2024 22:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94EAB1C2238A
	for <lists+linux-arch@lfdr.de>; Thu, 17 Oct 2024 20:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D920722913A;
	Thu, 17 Oct 2024 20:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OAp/1SyS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="iRSr+/+j"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA196229118;
	Thu, 17 Oct 2024 20:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729197812; cv=fail; b=Ngnk8j4HvufyaY5Lc9Mo2o5KCDXEW6fMC+zm/ILG5qXvEj90v+6OE+QDzqjKerokmaGSDNCQSL9fT/oobL4wuaP+CeJwjesSHnk/8rNeICOouXcyA3199e1Fgox557Zj1kFvv4kaDHoxzi2klJFqZ0sStcOvwDJMpKVQo49bhuU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729197812; c=relaxed/simple;
	bh=i2BWEZvg5N6ekd6YZfDt4VKQbhuivxhjme7fb8k90S0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VKO/wxuAavm6+CS1m3tPqAL9W3HPuC1vEk+IDl6pw/5eFBOOMFqBSvpMo8CWOSqY9u5e9pogRgf0xl7loVbI3nvCRgXxa7xRhUop2DMAPflIirxkpnRJobyOLLMH56Sam8s26qDjnn9WShCi+ZO6i0M/v66dvBRiSjx5nyPc2lE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OAp/1SyS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=iRSr+/+j; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49HFBvsg024511;
	Thu, 17 Oct 2024 20:43:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=mjxjOr5wbvhvGFQe1h5NBiR5xNC7dPyxjLQzSwUhIwM=; b=
	OAp/1SySMGppl18V/KhFgU2tOSo3vG/Sy80u2kK5aWj6JYi6ePtpuNbE8XIi0d9K
	JS4L037IWJ3PfmLcMyJvdFZSJDk0COugmTu9QxDTlnPVr8ehFQPeZTLIZBCZNIac
	iPm0wG1UFKO7se2yj4vl6xXH+/euuBmUC6IRgjUqQxF8k/bHrFpGDH5khUB6lDWA
	RhAINtscNMxmvGqPwr5OmVBoQR4cRXaJ4K7bkuSBxy9qFEhna0osOiIabBIZFxug
	fSD8uf/vPdJcTilLXUwUE3Ha1SVetW+qDwBfDKick32G9eN2L0+POoi3bYKm5z3L
	JImrUwlhvnxjoDPbhIqLPQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427fhcpyra-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 20:43:01 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49HJMt9V010406;
	Thu, 17 Oct 2024 20:43:01 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2043.outbound.protection.outlook.com [104.47.55.43])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 427fjh3tdj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 20:43:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uy+INrThlIIDsngA/8TMuSKYW13u9bphqdMPddFOvrOiZOKPTVrNtlarMhXfo8RlAcNtvj02YBTMw2kvEKbht8DN+A97L5i8oXAcxwgNXkwO1NvV/CHOdYn9QCb5czlOEZIX4gYZclvnFFqk9rlTNVFPVQKfTL9EOQOAma2a8lCYmdj0PtBQU7+2wOxo4vuZS8J26lKQwnbjqEdhvbezKzSDZT/vl0yEFX6f9OfRRYodMzLHZXI8/jOyvzYNx2VTomFneL6oH2dmLrpdVhrWFDA3/1KSv+FQVwPXnSqlncwKmAcBnw1RR7s58naxB6xroyUYgdh7OZeARhAy77G9ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mjxjOr5wbvhvGFQe1h5NBiR5xNC7dPyxjLQzSwUhIwM=;
 b=JODkMTEJQ++0A/yyBIW0WuTvt9hnfrEqsjuOMcsOyL3cQ7EiPIlJYZoIGtKex2ZbqiJ6ZSmg+wUdqhb8np28fZWGt7T1hswc+X52bj59M47Drg9xCctfIl+fItDkcnsBklgJHyk9cV82gHAFf0V6UX+zecOVBT0QpnOk2WKuHOnMkrfIj2ixLoBMOx7Bdfk3+/RDzYp6pYmXUxoYnzmY2vI4dyCwQTlY9vWmL+zx1VArupvgHzgKBrvTNpTwQzm6rzkFGpLGtBRN/oDdmcwpIpcxH/VnJfjbxJTKi/2bDXEF0/5LMxK4sWcJksVYfeD0Fr9b9m0Y0jRWGbuws5KGvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mjxjOr5wbvhvGFQe1h5NBiR5xNC7dPyxjLQzSwUhIwM=;
 b=iRSr+/+jPHC4uEpBBTPosZgS0zvqAscXYOjYRk+jEJOMZCnbUIhvVpvExgvXMKaIM1N//bS7lHRsEhTTVX5nikqn+plHbBiQEJaxZBSkb2ZFBdnOimyLXGoYaxqNcTAaVbhl0yLax8JHK3r5pht9ICozLUhSJU2bllmky+ninbE=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by DS7PR10MB5974.namprd10.prod.outlook.com (2603:10b6:8:9e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 20:42:56 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 20:42:56 +0000
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
        Jeff Xu <jeffxu@chromium.org>, Christoph Hellwig <hch@infradead.org>
Subject: [PATCH 4/4] selftests/mm: add self tests for guard page feature
Date: Thu, 17 Oct 2024 21:42:38 +0100
Message-ID: <8b1add3c511effb62d68183cae8a954d8339286c.1729196871.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <cover.1729196871.git.lorenzo.stoakes@oracle.com>
References: <cover.1729196871.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0105.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:191::20) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|DS7PR10MB5974:EE_
X-MS-Office365-Filtering-Correlation-Id: 0568faa4-f6f6-48a9-f027-08dceeec4756
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KlXYLE+sqEfFMwDgDjumHLO9Z1J6CvRpcvTLMgjRsFgbaTk+WL0ZkDyZtTWz?=
 =?us-ascii?Q?Srd8KqfbsujSRLt9Ie7eA6tpDKXQDLarhBPQxHF1PnoJIM7qXSXKweNsqshF?=
 =?us-ascii?Q?XpLoTsbaWCa9nZj1ke8icMgeBYz1n9PwvMGiBcfd+D5fUX/2gRLG1EZSPLE0?=
 =?us-ascii?Q?ictngLts2DJZgLhzIhah9vEvPUIsMa6fD8Mv9FjAuGgizH1uCjvtrk7ikY1M?=
 =?us-ascii?Q?NfxOruJeN8+ACq12O9ExNVBJpfuQzGzdnFleisoTrfxx5k/2jh4h4DFKNFDN?=
 =?us-ascii?Q?AuUqlDoK6IreC8AbtUXSpWp2YDglQTXD6ZOtZdmMSyY2UNulnBDh5MAh7g23?=
 =?us-ascii?Q?LW394dHinBBA0N8RkFLSHqZGqJIjsbnMvAobq21SqT22rtP0YZchV6SwjOSh?=
 =?us-ascii?Q?lv72APTt43kIPe9kBeDrubd5FvwEiLAOdQviJM0Prk1FYJt/6VHLUk+BfWt5?=
 =?us-ascii?Q?TI0nCxcp3vYrNOP9uL2Jw9/IFng2qslwTF2BTARSwTt/iAZ/WeAFlMQ2EKvd?=
 =?us-ascii?Q?/icM3prj6V7vFQ0yYCS1sMJ22LCXN0GpjmY64xhMAf1eJA5+VGy4jjTLFhbO?=
 =?us-ascii?Q?pvUl0IaxxvCIqmqPPZniNRLFMM35neEaSI8j9rDXMUea6mHzx5tGZBHfPQS8?=
 =?us-ascii?Q?767g9Ng6Tj/NKkwnKI+eSagdQgdQXmuFFFFIshGygd/+Gt2GiMiN7w1rgnjY?=
 =?us-ascii?Q?48N2JtseE/+X6UUkVThXbChZpyBKT6ATr/n+5xpGM35hDNHD0YaYdzNl/oD7?=
 =?us-ascii?Q?GyD8hAGgt9MKUXVCqZI9FhBZG+fBBYNFbwiPCKkTtBU0akbemgGadsdQOe9S?=
 =?us-ascii?Q?z0AdVmuWDITNMFkp/1oGHxoMd9Quem5lWlNJ41eYeMIRUyq9fMi6xOtTW0wD?=
 =?us-ascii?Q?o3r8M3MSlO8GJU+JPsySreOts3feu4JqzjnP4F1PJifamCq5D7mjQ/ZG+MXS?=
 =?us-ascii?Q?dATDFJTDhKUHUEdz+Wo069DOK1OdyWEAKLrmd5Co98bdxUcXqk1hNxhz0xC/?=
 =?us-ascii?Q?g1St/W0/ClKzvu6L7gXIzqdx+SuYa2CQaYQumTJKZum/LSF/5jTHf6TQ/uXr?=
 =?us-ascii?Q?bfFREPApJEKFEvMuDFFT95WsgwcNdMEUCEt3C2eWipSCBGITS21eBkiC0RGB?=
 =?us-ascii?Q?jTqmq0aHLadwjLF1COs5ltJLdZgs/H1N8aLcAlaAU22vcXhREuFnMVkywAC+?=
 =?us-ascii?Q?IuWYqVTg3W/1Q/0Ch3AbGq6W6NmQRnSfRyG0YhhO4IkTMwapA0kJ4bu9SaOF?=
 =?us-ascii?Q?tBxdS7bGXJ9z1CSkXIcy5yEF347ZUR+wQ+ZF83l1nR0X4mwYK0vIp/THa5x1?=
 =?us-ascii?Q?9LfubLI6pSbkKfZHntXX6pLh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FWVj69PC51iEuYP4xFt1a76f16tPuuYvQGD9aw55ZwnFr0jGO+8hnPj75/Ta?=
 =?us-ascii?Q?HP5Xa3yGuHW60WWS6z1XN2YKsmR610gGUNN7fA7aCOtHqfE6OJornn8Li+7O?=
 =?us-ascii?Q?gDEb56GzIhd3e7IVfLUNTSND1TBeaTRWuJ98HRQOJmsee8WrI8j5IpJ+rQ+j?=
 =?us-ascii?Q?qS49om1/dV2GdyFKpzmTrzNGNHWjpOPUQuYq28CxT4lDGFiKKkxSkxEFISPR?=
 =?us-ascii?Q?RswMDf9gKGdAJrslGJcsc2qn5ArX2LggFCpTUD2d+zam+SqjHHO87Fnid8rF?=
 =?us-ascii?Q?TjfBycmMrazdDRk3VdPZiqy2eVR1vhUdf8PygJJH1/vhNS8uOo66OZgVWVYe?=
 =?us-ascii?Q?4aS8fCwSuXhq6SNOGgB4VUEq5KIbzBTiBw4yk8b6EAbtW/Uc0hU1LZxkzXdR?=
 =?us-ascii?Q?bZOiGlYAZpA5waZVn7T2GxSRAPggEGSH6UygRp95/b+/52HKTdEsrbUgaj5d?=
 =?us-ascii?Q?G0Ed/jKvizZ/uBsouzZFEBKGtFJgfv2xoKf8DGdtColg4T6I+FMZLCEy/uUp?=
 =?us-ascii?Q?v7sGVX/Ky06d2kB92vj9OD5V/EkgAJVi+0CsHbZag6StgWrtBk1IxNO4d5zA?=
 =?us-ascii?Q?0c5lYyd/hfJKZ9bSUlN921BZG0aCnKZ4zXfjV/xws1IeNZd+QDmWuVChT2sh?=
 =?us-ascii?Q?KgNBorNiqWS5JjQdZ2w30pJCkVtKoQLuYV9KQudPc6eRS698iqZdsTTHJ0bt?=
 =?us-ascii?Q?Zf+U+4Lp2MtjDtcGbrTU0gjnlvbftWBcY16ncfiboWeHk0Z6Egth5yh0YaFC?=
 =?us-ascii?Q?TNnw/EZsGKzeMerO9A+B0+GFaihGIHGgEnfQ6vTuducQB3ns7Bf0cUqjalMS?=
 =?us-ascii?Q?UUBqof5TUOepFf5ukm3b8KFRbenaD7eGCP9/36f+jK7OfksCD5QxDfYEq43X?=
 =?us-ascii?Q?4OVlo6dHpi4fxI4lp9gN6gWsQC7cdClANIryWEmKdzMVyupZuqxnsSFixsmZ?=
 =?us-ascii?Q?rVrunC+Ssb5UhaikVpg5YwgWMbLPovpz3Gb28yaWAi3f99NZtFFyBUHq1FnG?=
 =?us-ascii?Q?Ns2w4CfedZaxY3cOaBvnLO9A5uyNi3WGtjVJ3O2HOmBXYknOEmMTfZJuXRYB?=
 =?us-ascii?Q?5zVT4snJASPMZkfr/RjkhVZ/TfGNPMfD8AQ+jrmcnchWiq6Pg06cJozOGuZp?=
 =?us-ascii?Q?7ITVwYZnIu7ykhXib+LDdbaDEnjqmRlEw4cn/5CJpMknXEHU6uJALFoNfEM3?=
 =?us-ascii?Q?D474M9wv8yJoxIZksVOs7T410GwlmOIgbeLHGNVBx/nicQUtFCxTBn+H3/Mk?=
 =?us-ascii?Q?QVC8c0dMflNplQ7bAvi2kszDWIvrRgyMXwEUEmRrU25TVXrNZJcbQYuFr6cj?=
 =?us-ascii?Q?ALct3z3lq3FdteJUULYb2v7oyfY9TLjbFfwyRIURAuTo9yVrlGeCf0v5L+g2?=
 =?us-ascii?Q?Rxs2fwvI31tlHrnr9n/II35Tnhh5ZzvKU1KjFLU2pDiRlWY1iiiEvXg2g1h7?=
 =?us-ascii?Q?VrlncJTNfV/KiYldhlzYhIk7oTgdNbn9bB034kIHflp7hfvWw/DJyvURGFDo?=
 =?us-ascii?Q?tXj/Pu45IB5ybSOBD8tn5AJ6OfJKaVMwAefdaBIPRxMukhkKeLXCBOCpt+XV?=
 =?us-ascii?Q?F9exF2PhjwAF/kL/9CufJOo6qFN+BQrzdBPUczW01cSwDeH7mLLqlx+uibuS?=
 =?us-ascii?Q?rg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	04IdAJTyJc6CGpLI/yDpzFed1E2pY9pCFLXiEQEbR8YvY3uMzrvz5+r7cIivnXKRlWemHh8AD+rOxs85M2xNVUpDjVmUYemJN6fZSD5Lm4JFOAKwQOMGFdjtoLVpshG1F/ov6CkUP1g+9UwWcmmlpMywUta+3nN8hX4MvzNCuh9pCULRYYpSxN3tex50ub8YiWvcHkl/hG19RTLUPqbFt2kBhpunYHzVacoLcvvZunT43EGSbKarBg1x5rSl2wE7Odhr0/qUqOMabEawot4xfZ4JVdQxCetZR7zzVjeVrIELo1mB7LduvtlKnj0IXy2mZp2Z3zJ1o6kymoTj0B4Cnr/ahpOJZ1HXfvfRJmgDzF43XZpypyrXT1VMv7JTasL+QI46WkMfsoYO/CskT+ecDr1o3uuLiUBRB74vUtfcTGWwokTJk5epILzo++Ihm/JwI3H2N4Gcwja9dsbd7LtXLWwuI+l2Gm0zI+MBgZzeJFGJ8FNmHPZq4lpTwF9jr6zHTSTS+Jm23ccBp1z7po79X1jVd79wakTqYJelwfnfqobPMpr/msJBv2f2UwiSdJR875YkPhEBHAGm2kt2juOZZ6mqkUJ5fcXFATyfWTAdS1c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0568faa4-f6f6-48a9-f027-08dceeec4756
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 20:42:56.0310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EUF5vtC6Y9VQoLi62ktxGtokhKhnN3FvZFMVLA3AWylfF2Dy3ilOsOSBHMN0o4Zm0rDT1rRDfLFNmHUcQ4g/85lIiK9wN1qCa2fpO89fV6E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5974
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-17_23,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 spamscore=0 mlxscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410170139
X-Proofpoint-GUID: N2SY7OGOE6phBldDY_DAovJ8Y1yR9Xii
X-Proofpoint-ORIG-GUID: N2SY7OGOE6phBldDY_DAovJ8Y1yR9Xii

Utilise the kselftest harmness to implement tests for the guard page
implementation.

We start by implement basic tests asserting that guard pages can be
established (poisoned), cleared (remedied) and that touching poisoned pages
result in SIGSEGV. We also assert that, in remedying a range, non-poison
pages remain intact.

We then examine different operations on regions containing poison markers
behave to ensure correct behaviour:

* Operations over multiple VMAs operate as expected.
* Invoking MADV_GUARD_POISION / MADV_GUARD_REMEDY via process_madvise() in
  batches works correctly.
* Ensuring that munmap() correctly tears down poison markers.
* Using mprotect() to adjust protection bits does not in any way override
  or cause issues with poison markers.
* Ensuring that splitting and merging VMAs around poison markers causes no
  issue - i.e. that a marker which 'belongs' to one VMA can function just
  as well 'belonging' to another.
* Ensuring that madvise(..., MADV_DONTNEED) does not remove poison markers.
* Ensuring that mlock()'ing a range containing poison markers does not
  cause issues.
* Ensuring that mremap() can move a poisoned range and retain poison
  markers.
* Ensuring that mremap() can expand a poisoned range and retain poison
  markers (perhaps moving the range).
* Ensuring that mremap() can shrink a poisoned range and retain poison
  markers.
* Ensuring that forking a process correctly retains poison markers.
* Ensuring that forking a VMA with VM_WIPEONFORK set behaves sanely.
* Ensuring that lazyfree simply clears poison markers.
* Ensuring that userfaultfd can co-exist with guard pages.
* Ensuring that madvise(..., MADV_POPULATE_READ) and
  madvise(..., MADV_POPULATE_WRITE) error out when encountering
  poison markers.
* Ensuring that madvise(..., MADV_COLD) and madvise(..., MADV_PAGEOUT) do
  not remove poison markers.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 tools/testing/selftests/mm/.gitignore    |    1 +
 tools/testing/selftests/mm/Makefile      |    1 +
 tools/testing/selftests/mm/guard-pages.c | 1168 ++++++++++++++++++++++
 3 files changed, 1170 insertions(+)
 create mode 100644 tools/testing/selftests/mm/guard-pages.c

diff --git a/tools/testing/selftests/mm/.gitignore b/tools/testing/selftests/mm/.gitignore
index 689bbd520296..8f01f4da1c0d 100644
--- a/tools/testing/selftests/mm/.gitignore
+++ b/tools/testing/selftests/mm/.gitignore
@@ -54,3 +54,4 @@ droppable
 hugetlb_dio
 pkey_sighandler_tests_32
 pkey_sighandler_tests_64
+guard-pages
diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index 02e1204971b0..15c734d6cfec 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -79,6 +79,7 @@ TEST_GEN_FILES += hugetlb_fault_after_madv
 TEST_GEN_FILES += hugetlb_madv_vs_map
 TEST_GEN_FILES += hugetlb_dio
 TEST_GEN_FILES += droppable
+TEST_GEN_FILES += guard-pages
 
 ifneq ($(ARCH),arm64)
 TEST_GEN_FILES += soft-dirty
diff --git a/tools/testing/selftests/mm/guard-pages.c b/tools/testing/selftests/mm/guard-pages.c
new file mode 100644
index 000000000000..2ab0ff3ba5a0
--- /dev/null
+++ b/tools/testing/selftests/mm/guard-pages.c
@@ -0,0 +1,1168 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#define _GNU_SOURCE
+#include "../kselftest_harness.h"
+#include <assert.h>
+#include <fcntl.h>
+#include <setjmp.h>
+#include <errno.h>
+#include <linux/userfaultfd.h>
+#include <signal.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/ioctl.h>
+#include <sys/mman.h>
+#include <sys/syscall.h>
+#include <sys/uio.h>
+#include <unistd.h>
+
+/* These may not yet be available in the uAPI so define if not. */
+
+#ifndef MADV_GUARD_POISON
+#define MADV_GUARD_POISON	102
+#endif
+
+#ifndef MADV_GUARD_UNPOISON
+#define MADV_GUARD_UNPOISON	103
+#endif
+
+volatile bool signal_jump_set;
+sigjmp_buf signal_jmp_buf;
+
+static int userfaultfd(int flags)
+{
+	return syscall(SYS_userfaultfd, flags);
+}
+
+static void handle_fatal(int c)
+{
+	if (!signal_jump_set)
+		return;
+
+	siglongjmp(signal_jmp_buf, c);
+}
+
+static int pidfd_open(pid_t pid, unsigned int flags)
+{
+	return syscall(SYS_pidfd_open, pid, flags);
+}
+
+/*
+ * Enable our signal catcher and try to read/write the specified buffer. The
+ * return value indicates whether the read/write succeeds without a fatal
+ * signal.
+ */
+static bool try_access_buf(char *ptr, bool write)
+{
+	bool failed;
+
+	/* Tell signal handler to jump back here on fatal signal. */
+	signal_jump_set = true;
+	/* If a fatal signal arose, we will jump back here and failed is set. */
+	failed = sigsetjmp(signal_jmp_buf, 0) != 0;
+
+	if (!failed) {
+		if (write) {
+			*ptr = 'x';
+		} else {
+			const volatile char *chr = ptr;
+
+			/* Force read. */
+			(void)*chr;
+		}
+	}
+
+	signal_jump_set = false;
+	return !failed;
+}
+
+/* Try and read from a buffer, return true if no fatal signal. */
+static bool try_read_buf(char *ptr)
+{
+	return try_access_buf(ptr, false);
+}
+
+/* Try and write to a buffer, return true if no fatal signal. */
+static bool try_write_buf(char *ptr)
+{
+	return try_access_buf(ptr, true);
+}
+
+/*
+ * Try and BOTH read from AND write to a buffer, return true if BOTH operations
+ * succeed.
+ */
+static bool try_read_write_buf(char *ptr)
+{
+	return try_read_buf(ptr) && try_write_buf(ptr);
+}
+
+FIXTURE(guard_pages)
+{
+	unsigned long page_size;
+};
+
+FIXTURE_SETUP(guard_pages)
+{
+	struct sigaction act = {
+		.sa_handler = &handle_fatal,
+		.sa_flags = SA_NODEFER,
+	};
+
+	sigemptyset(&act.sa_mask);
+	if (sigaction(SIGSEGV, &act, NULL)) {
+		perror("sigaction");
+		ksft_exit_fail();
+	}
+
+	self->page_size = (unsigned long)sysconf(_SC_PAGESIZE);
+};
+
+FIXTURE_TEARDOWN(guard_pages)
+{
+	struct sigaction act = {
+		.sa_handler = SIG_DFL,
+		.sa_flags = SA_NODEFER,
+	};
+
+	sigemptyset(&act.sa_mask);
+	sigaction(SIGSEGV, &act, NULL);
+}
+
+TEST_F(guard_pages, basic)
+{
+	const unsigned long NUM_PAGES = 10;
+	const unsigned long page_size = self->page_size;
+	char *ptr;
+	int i;
+
+	ptr = mmap(NULL, NUM_PAGES * page_size, PROT_READ | PROT_WRITE,
+		   MAP_PRIVATE | MAP_ANON, -1, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+
+	/* Trivially assert we can touch the first page. */
+	ASSERT_TRUE(try_read_write_buf(ptr));
+
+	ASSERT_EQ(madvise(ptr, page_size, MADV_GUARD_POISON), 0);
+
+	/* Establish that 1st page SIGSEGV's. */
+	ASSERT_FALSE(try_read_write_buf(ptr));
+
+	/* Ensure we can touch everything else.*/
+	for (i = 1; i < NUM_PAGES; i++) {
+		ASSERT_TRUE(try_read_write_buf(&ptr[i * page_size]));
+	}
+
+	/* Establish a guard page at the end of the mapping. */
+	ASSERT_EQ(madvise(&ptr[(NUM_PAGES - 1) * page_size], page_size,
+			  MADV_GUARD_POISON), 0);
+
+	/* Check that both guard pages result in SIGSEGV. */
+	ASSERT_FALSE(try_read_write_buf(ptr));
+	ASSERT_FALSE(try_read_write_buf(&ptr[(NUM_PAGES - 1) * page_size]));
+
+	/* Unpoison the first. */
+	ASSERT_FALSE(madvise(ptr, page_size, MADV_GUARD_UNPOISON));
+
+	/* Make sure we can touch it. */
+	ASSERT_TRUE(try_read_write_buf(ptr));
+
+	/* Unpoison the last. */
+	ASSERT_FALSE(madvise(&ptr[(NUM_PAGES - 1) * page_size], page_size,
+			     MADV_GUARD_UNPOISON));
+
+	/* Make sure we can touch it. */
+	ASSERT_TRUE(try_read_write_buf(&ptr[(NUM_PAGES - 1) * page_size]));
+
+	/*
+	 *  Test setting a _range_ of pages, namely the first 3. The first of
+	 *  these be faulted in, so this also tests that we can poison backed
+	 *  pages.
+	 */
+	ASSERT_EQ(madvise(ptr, 3 * page_size, MADV_GUARD_POISON), 0);
+
+	/* Make sure they are all poisoned. */
+	for (i = 0; i < 3; i++) {
+		ASSERT_FALSE(try_read_write_buf(&ptr[i * page_size]));
+	}
+
+	/* Make sure the rest are not. */
+	for (i = 3; i < NUM_PAGES; i++) {
+		ASSERT_TRUE(try_read_write_buf(&ptr[i * page_size]));
+	}
+
+	/* Unpoison them. */
+	ASSERT_EQ(madvise(ptr, NUM_PAGES * page_size, MADV_GUARD_UNPOISON), 0);
+
+	/* Now make sure we can touch everything. */
+	for (i = 0; i < NUM_PAGES; i++) {
+		ASSERT_TRUE(try_read_write_buf(&ptr[i * page_size]));
+	}
+
+	/* Now unpoison everything, make sure we don't remove existing entries */
+	ASSERT_EQ(madvise(ptr, NUM_PAGES * page_size, MADV_GUARD_UNPOISON), 0);
+
+	for (i = 0; i < NUM_PAGES * page_size; i += page_size) {
+		ASSERT_EQ(ptr[i], 'x');
+	}
+
+	ASSERT_EQ(munmap(ptr, NUM_PAGES * page_size), 0);
+}
+
+/* Assert that operations applied across multiple VMAs work as expected. */
+TEST_F(guard_pages, multi_vma)
+{
+	const unsigned long page_size = self->page_size;
+	char *ptr_region, *ptr, *ptr1, *ptr2, *ptr3;
+	int i;
+
+	/* Reserve a 100 page region over which we can install VMAs. */
+	ptr_region = mmap(NULL, 100 * page_size, PROT_NONE,
+			  MAP_ANON | MAP_PRIVATE, -1, 0);
+	ASSERT_NE(ptr_region, MAP_FAILED);
+
+	/* Place a VMA of 10 pages size at the start of the region. */
+	ptr1 = mmap(ptr_region, 10 * page_size, PROT_READ | PROT_WRITE,
+		    MAP_FIXED | MAP_ANON | MAP_PRIVATE, -1, 0);
+	ASSERT_NE(ptr1, MAP_FAILED);
+
+	/* Place a VMA of 5 pages size 50 pages into the region. */
+	ptr2 = mmap(&ptr_region[50 * page_size], 5 * page_size,
+		    PROT_READ | PROT_WRITE,
+		    MAP_FIXED | MAP_ANON | MAP_PRIVATE, -1, 0);
+	ASSERT_NE(ptr2, MAP_FAILED);
+
+	/* Place a VMA of 20 pages size at the end of the region. */
+	ptr3 = mmap(&ptr_region[80 * page_size], 20 * page_size,
+		    PROT_READ | PROT_WRITE,
+		    MAP_FIXED | MAP_ANON | MAP_PRIVATE, -1, 0);
+	ASSERT_NE(ptr3, MAP_FAILED);
+
+	/* Unmap gaps. */
+	ASSERT_EQ(munmap(&ptr_region[10 * page_size], 40 * page_size), 0);
+	ASSERT_EQ(munmap(&ptr_region[55 * page_size], 25 * page_size), 0);
+
+	/*
+	 * We end up with VMAs like this:
+	 *
+	 * 0    10 .. 50   55 .. 80   100
+	 * [---]      [---]      [---]
+	 */
+
+	/* Now poison the whole range and make sure all VMAs are poisoned. */
+
+	/*
+	 * madvise() is certifiable and lets you perform operations over gaps,
+	 * everything works, but it indicates an error and errno is set to
+	 * -ENOMEM. Also if anything runs out of memory it is set to
+	 * -ENOMEM. You are meant to guess which is which.
+	 */
+	ASSERT_EQ(madvise(ptr_region, 100 * page_size, MADV_GUARD_POISON), -1);
+	ASSERT_EQ(errno, ENOMEM);
+
+	for (i = 0; i < 10; i++) {
+		ASSERT_FALSE(try_read_write_buf(&ptr1[i * page_size]));
+	}
+
+	for (i = 0; i < 5; i++) {
+		ASSERT_FALSE(try_read_write_buf(&ptr2[i * page_size]));
+	}
+
+	for (i = 0; i < 20; i++) {
+		ASSERT_FALSE(try_read_write_buf(&ptr3[i * page_size]));
+	}
+
+	/* Now unpoison the range and assert the opposite. */
+
+	ASSERT_EQ(madvise(ptr_region, 100 * page_size, MADV_GUARD_UNPOISON), -1);
+	ASSERT_EQ(errno, ENOMEM);
+
+	for (i = 0; i < 10; i++) {
+		ASSERT_TRUE(try_read_write_buf(&ptr1[i * page_size]));
+	}
+
+	for (i = 0; i < 5; i++) {
+		ASSERT_TRUE(try_read_write_buf(&ptr2[i * page_size]));
+	}
+
+	for (i = 0; i < 20; i++) {
+		ASSERT_TRUE(try_read_write_buf(&ptr3[i * page_size]));
+	}
+
+	/* Now map incompatible VMAs in the gaps. */
+	ptr = mmap(&ptr_region[10 * page_size], 40 * page_size,
+		   PROT_READ | PROT_WRITE | PROT_EXEC,
+		   MAP_FIXED | MAP_ANON | MAP_PRIVATE, -1, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+	ptr = mmap(&ptr_region[55 * page_size], 25 * page_size,
+		   PROT_READ | PROT_WRITE | PROT_EXEC,
+		   MAP_FIXED | MAP_ANON | MAP_PRIVATE, -1, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+
+	/*
+	 * We end up with VMAs like this:
+	 *
+	 * 0    10 .. 50   55 .. 80   100
+	 * [---][xxxx][---][xxxx][---]
+	 *
+	 * Where 'x' signifies VMAs that cannot be merged with those adjacent to
+	 * them.
+	 */
+
+	/* Multiple VMAs adjacent to one another should result in no error. */
+	ASSERT_EQ(madvise(ptr_region, 100 * page_size, MADV_GUARD_POISON), 0);
+	for (i = 0; i < 100; i++) {
+		ASSERT_FALSE(try_read_write_buf(&ptr_region[i * page_size]));
+	}
+	ASSERT_EQ(madvise(ptr_region, 100 * page_size, MADV_GUARD_UNPOISON), 0);
+	for (i = 0; i < 100; i++) {
+		ASSERT_TRUE(try_read_write_buf(&ptr_region[i * page_size]));
+	}
+
+	/* Cleanup. */
+	ASSERT_EQ(munmap(ptr_region, 100 * page_size), 0);
+}
+
+/*
+ * Assert that batched operations performed using process_madvise() work as
+ * expected.
+ */
+TEST_F(guard_pages, process_madvise)
+{
+	const unsigned long page_size = self->page_size;
+	pid_t pid = getpid();
+	int pidfd = pidfd_open(pid, 0);
+	char *ptr_region, *ptr1, *ptr2, *ptr3;
+	ssize_t count;
+	struct iovec vec[6];
+
+	ASSERT_NE(pidfd, -1);
+
+	/* Reserve region to map over. */
+	ptr_region = mmap(NULL, 100 * page_size, PROT_NONE,
+			  MAP_ANON | MAP_PRIVATE, -1, 0);
+	ASSERT_NE(ptr_region, MAP_FAILED);
+
+	/* 10 pages offset 1 page into reserve region. */
+	ptr1 = mmap(&ptr_region[page_size], 10 * page_size,
+		    PROT_READ | PROT_WRITE,
+		    MAP_FIXED | MAP_ANON | MAP_PRIVATE, -1, 0);
+	ASSERT_NE(ptr1, MAP_FAILED);
+	/* We want poison markers at start/end of each VMA. */
+	vec[0].iov_base = ptr1;
+	vec[0].iov_len = page_size;
+	vec[1].iov_base = &ptr1[9 * page_size];
+	vec[1].iov_len = page_size;
+
+	/* 5 pages offset 50 pages into reserve region. */
+	ptr2 = mmap(&ptr_region[50 * page_size], 5 * page_size,
+		    PROT_READ | PROT_WRITE,
+		    MAP_FIXED | MAP_ANON | MAP_PRIVATE, -1, 0);
+	ASSERT_NE(ptr2, MAP_FAILED);
+	vec[2].iov_base = ptr2;
+	vec[2].iov_len = page_size;
+	vec[3].iov_base = &ptr2[4 * page_size];
+	vec[3].iov_len = page_size;
+
+	/* 20 pages offset 79 pages into reserve region. */
+	ptr3 = mmap(&ptr_region[79 * page_size], 20 * page_size,
+		    PROT_READ | PROT_WRITE,
+		    MAP_FIXED | MAP_ANON | MAP_PRIVATE, -1, 0);
+	ASSERT_NE(ptr3, MAP_FAILED);
+	vec[4].iov_base = ptr3;
+	vec[4].iov_len = page_size;
+	vec[5].iov_base = &ptr3[19 * page_size];
+	vec[5].iov_len = page_size;
+
+	/* Free surrounding VMAs. */
+	ASSERT_EQ(munmap(ptr_region, page_size), 0);
+	ASSERT_EQ(munmap(&ptr_region[11 * page_size], 39 * page_size), 0);
+	ASSERT_EQ(munmap(&ptr_region[55 * page_size], 24 * page_size), 0);
+	ASSERT_EQ(munmap(&ptr_region[99 * page_size], page_size), 0);
+
+	/* Now poison in one step. */
+	count = process_madvise(pidfd, vec, 6, MADV_GUARD_POISON, 0);
+
+	/* OK we don't have permission to do this, skip. */
+	if (count == -1 && errno == EPERM)
+		ksft_exit_skip("No process_madvise() permissions\n");
+
+	/* Returns the number of bytes advised. */
+	ASSERT_EQ(count, 6 * page_size);
+
+	/* Now make sure the poisoning was applied. */
+
+	ASSERT_FALSE(try_read_write_buf(ptr1));
+	ASSERT_FALSE(try_read_write_buf(&ptr1[9 * page_size]));
+
+	ASSERT_FALSE(try_read_write_buf(ptr2));
+	ASSERT_FALSE(try_read_write_buf(&ptr2[4 * page_size]));
+
+	ASSERT_FALSE(try_read_write_buf(ptr3));
+	ASSERT_FALSE(try_read_write_buf(&ptr3[19 * page_size]));
+
+	/* Now do the same with unpoison... */
+	count = process_madvise(pidfd, vec, 6, MADV_GUARD_UNPOISON, 0);
+
+	/* ...and everything should now succeed. */
+
+	ASSERT_TRUE(try_read_write_buf(ptr1));
+	ASSERT_TRUE(try_read_write_buf(&ptr1[9 * page_size]));
+
+	ASSERT_TRUE(try_read_write_buf(ptr2));
+	ASSERT_TRUE(try_read_write_buf(&ptr2[4 * page_size]));
+
+	ASSERT_TRUE(try_read_write_buf(ptr3));
+	ASSERT_TRUE(try_read_write_buf(&ptr3[19 * page_size]));
+
+	/* Cleanup. */
+	ASSERT_EQ(munmap(ptr1, 10 * page_size), 0);
+	ASSERT_EQ(munmap(ptr2, 5 * page_size), 0);
+	ASSERT_EQ(munmap(ptr3, 20 * page_size), 0);
+	close(pidfd);
+}
+
+/* Assert that unmapping ranges does not leave poison behind. */
+TEST_F(guard_pages, munmap)
+{
+	const unsigned long page_size = self->page_size;
+	char *ptr, *ptr_new1, *ptr_new2;
+
+	ptr = mmap(NULL, 10 * page_size, PROT_READ | PROT_WRITE,
+		   MAP_ANON | MAP_PRIVATE, -1, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+
+	/* Poison first and last pages. */
+	ASSERT_EQ(madvise(ptr, page_size, MADV_GUARD_POISON), 0);
+	ASSERT_EQ(madvise(&ptr[9 * page_size], page_size, MADV_GUARD_POISON), 0);
+
+	/* Assert that they are poisoned. */
+	ASSERT_FALSE(try_read_write_buf(ptr));
+	ASSERT_FALSE(try_read_write_buf(&ptr[9 * page_size]));
+
+	/* Unmap them. */
+	ASSERT_EQ(munmap(ptr, page_size), 0);
+	ASSERT_EQ(munmap(&ptr[9 * page_size], page_size), 0);
+
+	/* Map over them.*/
+	ptr_new1 = mmap(ptr, page_size, PROT_READ | PROT_WRITE,
+			MAP_FIXED | MAP_ANON | MAP_PRIVATE, -1, 0);
+	ASSERT_NE(ptr_new1, MAP_FAILED);
+	ptr_new2 = mmap(&ptr[9 * page_size], page_size, PROT_READ | PROT_WRITE,
+			MAP_FIXED | MAP_ANON | MAP_PRIVATE, -1, 0);
+	ASSERT_NE(ptr_new2, MAP_FAILED);
+
+	/* Assert that they are now not poisoned. */
+	ASSERT_TRUE(try_read_write_buf(ptr_new1));
+	ASSERT_TRUE(try_read_write_buf(ptr_new2));
+
+	/* Cleanup. */
+	ASSERT_EQ(munmap(ptr, 10 * page_size), 0);
+}
+
+/* Assert that mprotect() operations have no bearing on guard poison markers. */
+TEST_F(guard_pages, mprotect)
+{
+	const unsigned long page_size = self->page_size;
+	char *ptr;
+	int i;
+
+	ptr = mmap(NULL, 10 * page_size, PROT_READ | PROT_WRITE,
+		   MAP_ANON | MAP_PRIVATE, -1, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+
+	/* Poison the middle of the range. */
+	ASSERT_EQ(madvise(&ptr[5 * page_size], 2 * page_size,
+			  MADV_GUARD_POISON), 0);
+
+	/* Assert that it is indeed poisoned. */
+	ASSERT_FALSE(try_read_write_buf(&ptr[5 * page_size]));
+	ASSERT_FALSE(try_read_write_buf(&ptr[6 * page_size]));
+
+	/* Now make these pages read-only. */
+	ASSERT_EQ(mprotect(&ptr[5 * page_size], 2 * page_size, PROT_READ), 0);
+
+	/* Make sure the range is still poisoned. */
+	ASSERT_FALSE(try_read_buf(&ptr[5 * page_size]));
+	ASSERT_FALSE(try_read_buf(&ptr[6 * page_size]));
+
+	/* Make sure we can poison again without issue.*/
+	ASSERT_EQ(madvise(&ptr[5 * page_size], 2 * page_size,
+			  MADV_GUARD_POISON), 0);
+
+	/* Make sure the range is, yet again, still poisoned. */
+	ASSERT_FALSE(try_read_buf(&ptr[5 * page_size]));
+	ASSERT_FALSE(try_read_buf(&ptr[6 * page_size]));
+
+	/* Now unpoison the whole range. */
+	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_GUARD_UNPOISON), 0);
+
+	/* Make sure the whole range is readable. */
+	for (i = 0; i < 10; i++) {
+		ASSERT_TRUE(try_read_buf(&ptr[i * page_size]));
+	}
+
+	/* Cleanup. */
+	ASSERT_EQ(munmap(ptr, 10 * page_size), 0);
+}
+
+/* Split and merge VMAs and make sure guard pages still behave. */
+TEST_F(guard_pages, split_merge)
+{
+	const unsigned long page_size = self->page_size;
+	char *ptr, *ptr_new;
+	int i;
+
+	ptr = mmap(NULL, 10 * page_size, PROT_READ | PROT_WRITE,
+		   MAP_ANON | MAP_PRIVATE, -1, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+
+	/* Poison the whole range. */
+	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_GUARD_POISON), 0);
+
+	/* Make sure the whole range is poisoned. */
+	for (i = 0; i < 10; i++) {
+		ASSERT_FALSE(try_read_write_buf(&ptr[i * page_size]));
+	}
+
+	/* Now unmap some pages in the range so we split. */
+	ASSERT_EQ(munmap(&ptr[2 * page_size], page_size), 0);
+	ASSERT_EQ(munmap(&ptr[5 * page_size], page_size), 0);
+	ASSERT_EQ(munmap(&ptr[8 * page_size], page_size), 0);
+
+	/* Make sure the remaining ranges are poisoned post-split. */
+	for (i = 0; i < 2; i++) {
+		ASSERT_FALSE(try_read_write_buf(&ptr[i * page_size]));
+	}
+	for (i = 2; i < 5; i++) {
+		ASSERT_FALSE(try_read_write_buf(&ptr[i * page_size]));
+	}
+	for (i = 6; i < 8; i++) {
+		ASSERT_FALSE(try_read_write_buf(&ptr[i * page_size]));
+	}
+	for (i = 9; i < 10; i++) {
+		ASSERT_FALSE(try_read_write_buf(&ptr[i * page_size]));
+	}
+
+	/* Now map them again - the unmap will have cleared the poison. */
+	ptr_new = mmap(&ptr[2 * page_size], page_size, PROT_READ | PROT_WRITE,
+		       MAP_FIXED | MAP_ANON | MAP_PRIVATE, -1, 0);
+	ASSERT_NE(ptr_new, MAP_FAILED);
+	ptr_new = mmap(&ptr[5 * page_size], page_size, PROT_READ | PROT_WRITE,
+		       MAP_FIXED | MAP_ANON | MAP_PRIVATE, -1, 0);
+	ASSERT_NE(ptr_new, MAP_FAILED);
+	ptr_new = mmap(&ptr[8 * page_size], page_size, PROT_READ | PROT_WRITE,
+		       MAP_FIXED | MAP_ANON | MAP_PRIVATE, -1, 0);
+	ASSERT_NE(ptr_new, MAP_FAILED);
+
+	/* Now make sure poisoning is as expected. */
+	for (i = 0; i < 10; i++) {
+		bool result = try_read_write_buf(&ptr[i * page_size]);
+
+		if (i == 2 || i == 5 || i == 8) {
+			ASSERT_TRUE(result);
+		} else {
+			ASSERT_FALSE(result);
+		}
+	}
+
+	/* Now poison everything again. */
+	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_GUARD_POISON), 0);
+
+	/* Make sure the whole range is poisoned. */
+	for (i = 0; i < 10; i++) {
+		ASSERT_FALSE(try_read_write_buf(&ptr[i * page_size]));
+	}
+
+	/* Now split the range into three. */
+	ASSERT_EQ(mprotect(ptr, 3 * page_size, PROT_READ), 0);
+	ASSERT_EQ(mprotect(&ptr[7 * page_size], 3 * page_size, PROT_READ), 0);
+
+	/* Make sure the whole range is poisoned for read. */
+	for (i = 0; i < 10; i++) {
+		ASSERT_FALSE(try_read_buf(&ptr[i * page_size]));
+	}
+
+	/* Now reset protection bits so we merge the whole thing. */
+	ASSERT_EQ(mprotect(ptr, 3 * page_size, PROT_READ | PROT_WRITE), 0);
+	ASSERT_EQ(mprotect(&ptr[7 * page_size], 3 * page_size,
+			   PROT_READ | PROT_WRITE), 0);
+
+	/* Make sure the whole range is still poisoned. */
+	for (i = 0; i < 10; i++) {
+		ASSERT_FALSE(try_read_write_buf(&ptr[i * page_size]));
+	}
+
+	/* Split range into 3 again... */
+	ASSERT_EQ(mprotect(ptr, 3 * page_size, PROT_READ), 0);
+	ASSERT_EQ(mprotect(&ptr[7 * page_size], 3 * page_size, PROT_READ), 0);
+
+	/* ...and unpoison the whole range. */
+	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_GUARD_UNPOISON), 0);
+
+	/* Make sure the whole range is remedied for read. */
+	for (i = 0; i < 10; i++) {
+		ASSERT_TRUE(try_read_buf(&ptr[i * page_size]));
+	}
+
+	/* Merge them again. */
+	ASSERT_EQ(mprotect(ptr, 3 * page_size, PROT_READ | PROT_WRITE), 0);
+	ASSERT_EQ(mprotect(&ptr[7 * page_size], 3 * page_size,
+			   PROT_READ | PROT_WRITE), 0);
+
+	/* Now ensure the merged range is remedied for read/write. */
+	for (i = 0; i < 10; i++) {
+		ASSERT_TRUE(try_read_write_buf(&ptr[i * page_size]));
+	}
+
+	/* Cleanup. */
+	ASSERT_EQ(munmap(ptr, 10 * page_size), 0);
+}
+
+/* Assert that MADV_DONTNEED does not remove guard poison markers. */
+TEST_F(guard_pages, dontneed)
+{
+	const unsigned long page_size = self->page_size;
+	char *ptr;
+	int i;
+
+	ptr = mmap(NULL, 10 * page_size, PROT_READ | PROT_WRITE,
+		   MAP_ANON | MAP_PRIVATE, -1, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+
+	/* Back the whole range. */
+	for (i = 0; i < 10; i++) {
+		ptr[i * page_size] = 'y';
+	}
+
+	/* Poison every other page. */
+	for (i = 0; i < 10; i += 2) {
+		ASSERT_EQ(madvise(&ptr[i * page_size],
+				  page_size, MADV_GUARD_POISON), 0);
+	}
+
+	/* Indicate that we don't need any of the range. */
+	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_DONTNEED), 0);
+
+	/* Check to ensure poison markers are still in place. */
+	for (i = 0; i < 10; i++) {
+		bool result = try_read_buf(&ptr[i * page_size]);
+
+		if (i % 2 == 0) {
+			ASSERT_FALSE(result);
+		} else {
+			ASSERT_TRUE(result);
+			/* Make sure we really did get reset to zero page. */
+			ASSERT_EQ(ptr[i * page_size], '\0');
+		}
+
+		/* Now write... */
+		result = try_write_buf(&ptr[i * page_size]);
+
+		/* ...and make sure same result. */
+		if (i % 2 == 0) {
+			ASSERT_FALSE(result);
+		} else {
+			ASSERT_TRUE(result);
+		}
+	}
+
+	/* Cleanup. */
+	ASSERT_EQ(munmap(ptr, 10 * page_size), 0);
+}
+
+/* Assert that mlock()'ed pages work correctly with poison markers. */
+TEST_F(guard_pages, mlock)
+{
+	const unsigned long page_size = self->page_size;
+	char *ptr;
+	int i;
+
+	ptr = mmap(NULL, 10 * page_size, PROT_READ | PROT_WRITE,
+		   MAP_ANON | MAP_PRIVATE, -1, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+
+	/* Populate. */
+	for (i = 0; i < 10; i++) {
+		ptr[i * page_size] = 'y';
+	}
+
+	/* Lock. */
+	ASSERT_EQ(mlock(ptr, 10 * page_size), 0);
+
+	/* Now try to poison, should fail with EINVAL. */
+	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_GUARD_POISON), -1);
+	ASSERT_EQ(errno, EINVAL);
+
+	/* OK unlock. */
+	ASSERT_EQ(munlock(ptr, 10 * page_size), 0);
+
+	/* Poison first half of range, should now succeed. */
+	ASSERT_EQ(madvise(ptr, 5 * page_size, MADV_GUARD_POISON), 0);
+
+	/* Make sure poison works. */
+	for (i = 0; i < 10; i++) {
+		bool result = try_read_write_buf(&ptr[i * page_size]);
+
+		if (i < 5) {
+			ASSERT_FALSE(result);
+		} else {
+			ASSERT_TRUE(result);
+			ASSERT_EQ(ptr[i * page_size], 'x');
+		}
+	}
+
+	/*
+	 * Now lock the latter part of the range. We can't lock the poisoned
+	 * pages, as this would result in the pages being populated and the
+	 * poisoning would cause this to error out.
+	 */
+	ASSERT_EQ(mlock(&ptr[5 * page_size], 5 * page_size), 0);
+
+	/*
+	 * Now unpoison, we do not permit mlock()'d ranges to be remedied as it is
+	 * a non-destructive operation.
+	 */
+	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_GUARD_UNPOISON), 0);
+
+	/* Now check that everything is remedied. */
+	for (i = 0; i < 10; i++) {
+		ASSERT_TRUE(try_read_write_buf(&ptr[i * page_size]));
+	}
+
+	/* Cleanup. */
+	ASSERT_EQ(munmap(ptr, 10 * page_size), 0);
+}
+
+/*
+ * Assert that moving, extending and shrinking memory via mremap() retains
+ * poison markers where possible.
+ *
+ * - Moving a mapping alone should retain markers as they are.
+ */
+TEST_F(guard_pages, mremap_move)
+{
+	const unsigned long page_size = self->page_size;
+	char *ptr, *ptr_new;
+
+	/* Map 5 pages. */
+	ptr = mmap(NULL, 5 * page_size, PROT_READ | PROT_WRITE,
+		   MAP_ANON | MAP_PRIVATE, -1, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+
+	/* Place poison markers at both ends of the 5 page span. */
+	ASSERT_EQ(madvise(ptr, page_size, MADV_GUARD_POISON), 0);
+	ASSERT_EQ(madvise(&ptr[4 * page_size], page_size, MADV_GUARD_POISON), 0);
+
+	/* Make sure the poison is in effect. */
+	ASSERT_FALSE(try_read_write_buf(ptr));
+	ASSERT_FALSE(try_read_write_buf(&ptr[4 * page_size]));
+
+	/* Map a new region we will move this range into. Doing this ensures
+	 * that we have reserved a range to map into.
+	 */
+	ptr_new = mmap(NULL, 5 * page_size, PROT_NONE, MAP_ANON | MAP_PRIVATE,
+		       -1, 0);
+	ASSERT_NE(ptr_new, MAP_FAILED);
+
+	ASSERT_EQ(mremap(ptr, 5 * page_size, 5 * page_size,
+			 MREMAP_MAYMOVE | MREMAP_FIXED, ptr_new), ptr_new);
+
+	/* Make sure the poison is retained. */
+	ASSERT_FALSE(try_read_write_buf(ptr_new));
+	ASSERT_FALSE(try_read_write_buf(&ptr_new[4 * page_size]));
+
+	/*
+	 * Clean up - we only need reference the new pointer as we overwrote the
+	 * PROT_NONE range and moved the existing one.
+	 */
+	munmap(ptr_new, 5 * page_size);
+}
+
+/*
+ * Assert that moving, extending and shrinking memory via mremap() retains
+ * poison markers where possible.
+ *
+ * - Expanding should retain, only now in different position. The user will have
+ *   to unpoison manually to fix up (they'd have to do the same if it were a
+ *   PROT_NONE mapping)
+ */
+TEST_F(guard_pages, mremap_expand)
+{
+	const unsigned long page_size = self->page_size;
+	char *ptr, *ptr_new;
+
+	/* Map 10 pages... */
+	ptr = mmap(NULL, 10 * page_size, PROT_READ | PROT_WRITE,
+		   MAP_ANON | MAP_PRIVATE, -1, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+	/* ...But unmap the last 5 so we can ensure we can expand into them. */
+	ASSERT_EQ(munmap(&ptr[5 * page_size], 5 * page_size), 0);
+
+	/* Place poison markers at both ends of the 5 page span. */
+	ASSERT_EQ(madvise(ptr, page_size, MADV_GUARD_POISON), 0);
+	ASSERT_EQ(madvise(&ptr[4 * page_size], page_size, MADV_GUARD_POISON), 0);
+
+	/* Make sure the poison is in effect. */
+	ASSERT_FALSE(try_read_write_buf(ptr));
+	ASSERT_FALSE(try_read_write_buf(&ptr[4 * page_size]));
+
+	/* Now expand to 10 pages. */
+	ptr = mremap(ptr, 5 * page_size, 10 * page_size, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+
+	/* Make sure the poison is retained in its original positions. */
+	ASSERT_FALSE(try_read_write_buf(ptr));
+	ASSERT_FALSE(try_read_write_buf(&ptr[4 * page_size]));
+
+	/* Reserve a region which we can move to and expand into. */
+	ptr_new = mmap(NULL, 20 * page_size, PROT_NONE,
+		       MAP_ANON | MAP_PRIVATE, -1, 0);
+	ASSERT_NE(ptr_new, MAP_FAILED);
+
+	/* Now move and expand into it. */
+	ptr = mremap(ptr, 10 * page_size, 20 * page_size,
+		     MREMAP_MAYMOVE | MREMAP_FIXED, ptr_new);
+	ASSERT_EQ(ptr, ptr_new);
+
+	/* Again, make sure the poison is retained in its original
+	 * positions. */
+	ASSERT_FALSE(try_read_write_buf(ptr));
+	ASSERT_FALSE(try_read_write_buf(&ptr[4 * page_size]));
+
+	/*
+	 * A real user would have to unpoison, but would reasonably expect all
+	 * characteristics of the mapping to be retained, including poison
+	 * markers.
+	 */
+
+	/* Cleanup. */
+	munmap(ptr, 20 * page_size);
+}
+/*
+ * Assert that moving, extending and shrinking memory via mremap() retains
+ * poison markers where possible.
+ *
+ * - Shrinking will result in markers that are shrunk over being removed. Again,
+ *   if the user were using a PROT_NONE mapping they'd have to manually fix this
+ *   up also so this is OK.
+ */
+TEST_F(guard_pages, mremap_shrink)
+{
+	const unsigned long page_size = self->page_size;
+	char *ptr;
+	int i;
+
+	/* Map 5 pages. */
+	ptr = mmap(NULL, 5 * page_size, PROT_READ | PROT_WRITE,
+		   MAP_ANON | MAP_PRIVATE, -1, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+
+	/* Place poison markers at both ends of the 5 page span. */
+	ASSERT_EQ(madvise(ptr, page_size, MADV_GUARD_POISON), 0);
+	ASSERT_EQ(madvise(&ptr[4 * page_size], page_size, MADV_GUARD_POISON), 0);
+
+	/* Make sure the poison is in effect. */
+	ASSERT_FALSE(try_read_write_buf(ptr));
+	ASSERT_FALSE(try_read_write_buf(&ptr[4 * page_size]));
+
+	/* Now shrink to 3 pages. */
+	ptr = mremap(ptr, 5 * page_size, 3 * page_size, MREMAP_MAYMOVE);
+	ASSERT_NE(ptr, MAP_FAILED);
+
+	/* We expect the poison marker at the start to be retained... */
+	ASSERT_FALSE(try_read_write_buf(ptr));
+
+	/* ...But remaining pages will not have poison markers. */
+	for (i = 1; i < 3; i++) {
+		ASSERT_TRUE(try_read_write_buf(&ptr[i + page_size]));
+	}
+
+	/*
+	 * As with expansion, a real user would have to unpoison and fixup. But
+	 * you'd have to do similar manual things with PROT_NONE mappings too.
+	 */
+
+	/*
+	 * If we expand back to the original size, the end marker will, of
+	 * course, no longer be present.
+	 */
+	ptr = mremap(ptr, 3 * page_size, 5 * page_size, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+
+	/* Again, we expect the poison marker at the start to be retained... */
+	ASSERT_FALSE(try_read_write_buf(ptr));
+
+	/* ...But remaining pages will not have poison markers. */
+	for (i = 1; i < 5; i++) {
+		ASSERT_TRUE(try_read_write_buf(&ptr[i + page_size]));
+	}
+
+	/* Cleanup. */
+	munmap(ptr, 5 * page_size);
+}
+
+/*
+ * Assert that forking a process with VMAs that do not have VM_WIPEONFORK set
+ * retain guard pages.
+ */
+TEST_F(guard_pages, fork)
+{
+	const unsigned long page_size = self->page_size;
+	char *ptr;
+	pid_t pid;
+	int i;
+
+	/* Map 10 pages. */
+	ptr = mmap(NULL, 10 * page_size, PROT_READ | PROT_WRITE,
+		   MAP_ANON | MAP_PRIVATE, -1, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+
+	/* Poison the first 5 pages. */
+	ASSERT_EQ(madvise(ptr, 5 * page_size, MADV_GUARD_POISON), 0);
+
+	pid = fork();
+	ASSERT_NE(pid, -1);
+	if (!pid) {
+		/* This is the child process now. */
+
+		/* Assert that the poisoning is in effect. */
+		for (i = 0; i < 10; i++) {
+			bool result = try_read_write_buf(&ptr[i * page_size]);
+
+			if (i < 5) {
+				ASSERT_FALSE(result);
+			} else {
+				ASSERT_TRUE(result);
+			}
+		}
+
+		/* Now unpoison the range.*/
+		ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_GUARD_UNPOISON), 0);
+
+		exit(0);
+	}
+
+	/* Parent process. */
+
+	/* Parent simply waits on child. */
+	waitpid(pid, NULL, 0);
+
+	/* Child unpoison does not impact parent page table state. */
+	for (i = 0; i < 10; i++) {
+		bool result = try_read_write_buf(&ptr[i * page_size]);
+
+		if (i < 5) {
+			ASSERT_FALSE(result);
+		} else {
+			ASSERT_TRUE(result);
+		}
+	}
+
+	/* Cleanup. */
+	ASSERT_EQ(munmap(ptr, 10 * page_size), 0);
+}
+
+/*
+ * Assert that forking a process with VMAs that do have VM_WIPEONFORK set
+ * behave as expected.
+ */
+TEST_F(guard_pages, fork_wipeonfork)
+{
+	const unsigned long page_size = self->page_size;
+	char *ptr;
+	pid_t pid;
+	int i;
+
+	/* Map 10 pages. */
+	ptr = mmap(NULL, 10 * page_size, PROT_READ | PROT_WRITE,
+		   MAP_ANON | MAP_PRIVATE, -1, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+
+	/* Mark wipe on fork. */
+	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_WIPEONFORK), 0);
+
+	/* Poison the first 5 pages. */
+	ASSERT_EQ(madvise(ptr, 5 * page_size, MADV_GUARD_POISON), 0);
+
+	pid = fork();
+	ASSERT_NE(pid, -1);
+	if (!pid) {
+		/* This is the child process now. */
+
+		/* Poison will have been wiped. */
+		for (i = 0; i < 10; i++) {
+			ASSERT_TRUE(try_read_write_buf(&ptr[i * page_size]));
+		}
+
+		exit(0);
+	}
+
+	/* Parent process. */
+
+	waitpid(pid, NULL, 0);
+
+	/* Poison should be in effect.*/
+	for (i = 0; i < 10; i++) {
+		bool result = try_read_write_buf(&ptr[i * page_size]);
+
+		if (i < 5) {
+			ASSERT_FALSE(result);
+		} else {
+			ASSERT_TRUE(result);
+		}
+	}
+
+	/* Cleanup. */
+	ASSERT_EQ(munmap(ptr, 10 * page_size), 0);
+}
+
+/* Ensure that MADV_FREE frees poison entries as expected. */
+TEST_F(guard_pages, lazyfree)
+{
+	const unsigned long page_size = self->page_size;
+	char *ptr;
+	int i;
+
+	/* Map 10 pages. */
+	ptr = mmap(NULL, 10 * page_size, PROT_READ | PROT_WRITE,
+		   MAP_ANON | MAP_PRIVATE, -1, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+
+	/* Poison range. */
+	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_GUARD_POISON), 0);
+
+	/* Ensure poisoned. */
+	for (i = 0; i < 10; i++) {
+		ASSERT_FALSE(try_read_write_buf(&ptr[i * page_size]));
+	}
+
+	/* Lazyfree range. */
+	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_FREE), 0);
+
+	/* This should simply clear the poison markers. */
+	for (i = 0; i < 10; i++) {
+		ASSERT_TRUE(try_read_write_buf(&ptr[i * page_size]));
+	}
+
+	/* Cleanup. */
+	ASSERT_EQ(munmap(ptr, 10 * page_size), 0);
+}
+
+/* Ensure that MADV_POPULATE_READ, MADV_POPULATE_WRITE behave as expected. */
+TEST_F(guard_pages, populate)
+{
+	const unsigned long page_size = self->page_size;
+	char *ptr;
+
+	/* Map 10 pages. */
+	ptr = mmap(NULL, 10 * page_size, PROT_READ | PROT_WRITE,
+		   MAP_ANON | MAP_PRIVATE, -1, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+
+	/* Poison range. */
+	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_GUARD_POISON), 0);
+
+	/* Populate read should error out... */
+	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_POPULATE_READ), -1);
+	ASSERT_EQ(errno, EFAULT);
+
+	/* ...as should populate write. */
+	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_POPULATE_WRITE), -1);
+	ASSERT_EQ(errno, EFAULT);
+
+	/* Cleanup. */
+	ASSERT_EQ(munmap(ptr, 10 * page_size), 0);
+}
+
+/* Ensure that MADV_COLD, MADV_PAGEOUT do not remove poison markers. */
+TEST_F(guard_pages, cold_pageout)
+{
+	const unsigned long page_size = self->page_size;
+	char *ptr;
+	int i;
+
+	/* Map 10 pages. */
+	ptr = mmap(NULL, 10 * page_size, PROT_READ | PROT_WRITE,
+		   MAP_ANON | MAP_PRIVATE, -1, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+
+	/* Poison range. */
+	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_GUARD_POISON), 0);
+
+	/* Ensured poisoned. */
+	for (i = 0; i < 10; i++) {
+		ASSERT_FALSE(try_read_write_buf(&ptr[i * page_size]));
+	}
+
+	/* Now mark cold. This should have no impact on poison markers. */
+	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_COLD), 0);
+
+	/* Should remain poisoned. */
+	for (i = 0; i < 10; i++) {
+		ASSERT_FALSE(try_read_write_buf(&ptr[i * page_size]));
+	}
+
+	/* OK, now page out. This should equally, have no effect on markers. */
+	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_PAGEOUT), 0);
+
+	/* Should remain poisoned. */
+	for (i = 0; i < 10; i++) {
+		ASSERT_FALSE(try_read_write_buf(&ptr[i * page_size]));
+	}
+
+	/* Cleanup. */
+	ASSERT_EQ(munmap(ptr, 10 * page_size), 0);
+}
+
+/* Ensure that guard pages do not break userfaultd. */
+TEST_F(guard_pages, uffd)
+{
+	const unsigned long page_size = self->page_size;
+	int uffd;
+	char *ptr;
+	int i;
+	struct uffdio_api api = {
+		.api = UFFD_API,
+		.features = 0,
+	};
+	struct uffdio_register reg;
+	struct uffdio_range range;
+
+	/* Set up uffd. */
+	uffd = userfaultfd(0);
+	if (uffd == -1 && errno == EPERM)
+		ksft_exit_skip("No uffd permissions\n");
+	ASSERT_NE(uffd, -1);
+
+	ASSERT_EQ(ioctl(uffd, UFFDIO_API, &api), 0);
+
+	/* Map 10 pages. */
+	ptr = mmap(NULL, 10 * page_size, PROT_READ | PROT_WRITE,
+		   MAP_ANON | MAP_PRIVATE, -1, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+
+	/* Register the range with uffd. */
+	range.start = (unsigned long)ptr;
+	range.len = 10 * page_size;
+	reg.range = range;
+	reg.mode = UFFDIO_REGISTER_MODE_MISSING;
+	ASSERT_EQ(ioctl(uffd, UFFDIO_REGISTER, &reg), 0);
+
+	/* Poison the range. This should not trigger the uffd. */
+	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_GUARD_POISON), 0);
+
+	/* The poisoning should behave as usual with no uffd intervention. */
+	for (i = 0; i < 10; i++) {
+		ASSERT_FALSE(try_read_write_buf(&ptr[i * page_size]));
+	}
+
+	/* Cleanup. */
+	ASSERT_EQ(ioctl(uffd, UFFDIO_UNREGISTER, &range), 0);
+	close(uffd);
+	ASSERT_EQ(munmap(ptr, 10 * page_size), 0);
+}
+
+TEST_HARNESS_MAIN
-- 
2.46.2


