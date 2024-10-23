Return-Path: <linux-arch+bounces-8471-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 546699AD06B
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2024 18:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AAFE284AF5
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2024 16:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C85D1D04A2;
	Wed, 23 Oct 2024 16:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jPn2z3d/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="j31gp08G"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35921CB301;
	Wed, 23 Oct 2024 16:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729700764; cv=fail; b=e8+Lpvyywb99A5c8872FCQRlJOrvbXG0VFEUnTy4F3bUAizCsWPaRE1PWi0zFiOo7IUXYmJrPWS35Vlw+1/15kT1LPwjJ/1pezY4K3pSMsgFOEVLGJ5pEZs7xCjjqZqD2XufC4kTlr0TJxYOCm8mCPK41spapZNtUahcTS4PZEM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729700764; c=relaxed/simple;
	bh=HgSTrNnBcX5ZiJ2obkRFHh9pnZiuitbXDi4nPmrTgHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s7tsSKbQarlLc+SueAAcEsJfXhIUjzC4og2KHSP68QIVc5sS/CeWCaHroTVCHtItRz/Wvyfr7bHjBHO+rt/N7gt10S74TVvVyYSrA9FGhkaRNq30R8Je8pBHrMKFw8rVsOFjZtJSnEAfqaB8cpYLxh8hqJmClDJPKiDOK7qBIZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jPn2z3d/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=j31gp08G; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49NFfkpS011171;
	Wed, 23 Oct 2024 16:25:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=m9e/npa4ZtTr6iLFSo4OUkRAsp4xmX97+p+Qp2ItzGg=; b=
	jPn2z3d/pR5uhPJz4Pkq2Oa5fqpQuE1++Y+2VY+hzfPtUNOPANd/EmRSrgNpBvj4
	VbgV8wr+B0NFypKsVwA5ez0W/BRTkfgcADq21gWSD+GM9lKj5cbLB/QwIXnq2Eez
	QqIviivx9b8vbMCbCy/+KUVhnn8JJXPWsVJlAca+P9rCnPi326vJhAJuLKLmXdH1
	3hsnAHtt7pYJtti8aZ+8CJl6f55aHfk2lzyE2C++uPe5b5ckM0Y+mqUOgyffpR2f
	VGMtS4gFn02qyvGyLdCewx6nunidCaWdXgLT/0S+7E5hTZdfe/6+Lex5Bo87CJXs
	0rbPv/H2yxIncoGgmdLEXA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42cqv3fqe5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 16:25:27 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49NFMqeI036049;
	Wed, 23 Oct 2024 16:25:16 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42emh2rcdt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 16:25:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CP+Uo2nabR7SnjThlwEYoxGcL5nPN1iarXeN8a4XkzIWTDOgk0nUAuITQ86Ngkbrzd5FarkaHQoPu6DA19kn0DOzx+DPcqKAxxCvNiGwMnmRsd7vNzGvVLHh1qWAiQ7l49SjT2r1u98hd4DWszEOwQD6yQQR4abQEWigsJbsn2HRKRk0BAIQONLP9q3DLaP4A7CkhAkc4/Amh4hD1qVV4YgxvKZoQHEfGddBUESPlpeBynPpPtAFz45f1qhobiE+78naWU3j0iHOKUByf806slCezfcvU+P7y7PQPIlvzO5QtrHKrMUkklIMfpB6HgyIT9iI7i3CZ7svIXvN8+2IzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m9e/npa4ZtTr6iLFSo4OUkRAsp4xmX97+p+Qp2ItzGg=;
 b=bQyPCvDZOOp78181eWcLPU7iu8H8+nTe9/8T6nZop4g+xwxE24vL7Qr+291TqzfWI0yG4Djc/xgh0jImAJ8PHKUkm4VIiRswkEtnMFUsWun90CV5zCrCUvCTf9fF2M9PkZ9cPqqKCYR4JWJFHM8+N0SDRVZnf/6YAs9ltB3+X9A9Q6uEmPJ0N32gP83bclNqwELITJsr/l9Y8uwD2Eqy9JjgDoMNsTI0MHLq1I/G3NkLdB4pCG+3bYcZLkLkuZvev69ELDLPlOcjHzRFZKGftS0WDqSXMNqOQY7daM/xC41v5ycAvOw5KWra63qrQ6CVCEfLei3hr7de9kAczYEVrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m9e/npa4ZtTr6iLFSo4OUkRAsp4xmX97+p+Qp2ItzGg=;
 b=j31gp08GAw0T6pyQwClZ58I+69ZfoUnJ5HSrTxmS3KgVinForfFK++Xw+pZdTDkzH+0CdMswtoPNkSQ+1N0nJ5Tu+7BZn2uHGXz0vn7FHt3gkUEw+VOvdxdMzsidbmUEVeHdADzatkXRDl/t2UPr6tpANDt5nWKHwZ4mTNVPUCk=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by LV3PR10MB7771.namprd10.prod.outlook.com (2603:10b6:408:1b0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Wed, 23 Oct
 2024 16:25:11 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8069.024; Wed, 23 Oct 2024
 16:25:11 +0000
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
Subject: [PATCH v3 5/5] selftests/mm: add self tests for guard page feature
Date: Wed, 23 Oct 2024 17:24:42 +0100
Message-ID: <53efeca2f9db78f7accbeb721106f5786fec9e90.1729699916.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1729699916.git.lorenzo.stoakes@oracle.com>
References: <cover.1729699916.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO3P265CA0025.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:387::6) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|LV3PR10MB7771:EE_
X-MS-Office365-Filtering-Correlation-Id: 280919a5-979e-43c6-56ff-08dcf37f4446
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|10070799003|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?quOxPF+on28JGp6Vl73nRcdVrCjY0S1uffNEJ0J7wmfugg7dQ8omyOE/2zfI?=
 =?us-ascii?Q?bm3TUdl7nLIYAeA9Lt8vIzNXcS2Y/IxbM7v1iIoGMNygrdryPPO8Q28vIfVH?=
 =?us-ascii?Q?2nbRCVFSkNW4czxWVebI/lmf4v/7VJHZ7OEZUglsZ3h2KdkOK4PBzpSYV2BX?=
 =?us-ascii?Q?dl5p5f92wzVJID2ENZB1LDqdFeihs7CtXqcX5ScQqvIio0qEHCYajymo4DTL?=
 =?us-ascii?Q?8cgVRfedX9rSOMi53dFarcc7DlW4jqYBmZXg0pBnmLWyvBbjycKV5c4AamyC?=
 =?us-ascii?Q?j9apIXiUSDkHa9LpkqkdI3ZIm0Z6G6brZNtGCI3TZTyVo6mSjIAQnOrcE8sV?=
 =?us-ascii?Q?a7lfbKNijJPLUhGlymNsEPpNOedhGCTkzmgpzc0F8ZAyWd+rwQTp3BG2zGkb?=
 =?us-ascii?Q?HJtQA712KzsCN58KD5Dq/R2STOUzn8CKhyIukg1Vg2wOd6r058rYSnyGLT68?=
 =?us-ascii?Q?9WFmi7wBd/ptfx2PyKgRWoCUfZb/NK1vrce+dwjExbRdjKPDts4I0Mp0YbWI?=
 =?us-ascii?Q?TMPGO2TR5eS3BrJstpGXcHwd8Nn70t7Tj6/Lvt2W1x3i2nxuUqzpk3Nfhl0W?=
 =?us-ascii?Q?/JI5IclxbNoGTDrikiYSb5pk1ryoSi4RbQN3O4fotGwAHD2bKjTz0q4q2oDZ?=
 =?us-ascii?Q?XGPapw0oOFWk1NRrIO+Vq6bQxS3ZP7Xn30fU3t4TN8sVLhE3+cAy4EoLsUGI?=
 =?us-ascii?Q?2uOUxkRd5JEHdHaPiAicmbKcZocDwwyiaRD5HSN+ElhRoDT8YOhhclvZEEV1?=
 =?us-ascii?Q?Hj7W7mRlfy2Upr+1MrKGGREC72ySgGJU1pJ4p90PDxRNtxRZ6EAXxfRIXaho?=
 =?us-ascii?Q?abtHmO50hRVBIeDojw+m52KifWPOUc1dsxAAvHzjknHBONakO6bhoiGUvMBH?=
 =?us-ascii?Q?YHTqEugO1rS1Vrrfw/8Hm/0kzMTR56P5v0GNSMuGVCOgELVZx6VcC0Wgli3p?=
 =?us-ascii?Q?mm9Ap93JtIRe35SCa5JPA58Sglzg5Nyis+n+EzBpwmmtbcmbh94sw/hyQ/V+?=
 =?us-ascii?Q?8zkG5RjRmwyTO/nhs3FClL9VhiAakhrxSwhTX6WQ5/y8qEaO+dwtyK84PXTb?=
 =?us-ascii?Q?M7OQK9wxKkkKPK/jDwFYut7LCGKA7bZfz2fUX4vsoPmKPG7VT2MQpEz8Glx1?=
 =?us-ascii?Q?HD0uiGz5ouCCk0j2Sbx3Iux0MO5jHtXcSIfm6JprQeZazGkSyqQsvCk1U4XB?=
 =?us-ascii?Q?90GrCPm+6f7hR3VxlsCBxWh7oprg8lwkE7CVhIznEhQhcM/0QJwKLzUfj0TG?=
 =?us-ascii?Q?HdoLmpDZqNo3FZX0OLHPxc4Xc+Ywmp/57L2wWTKQMTMPLYBUSoKO50c+Y1M2?=
 =?us-ascii?Q?/vPgCoiIaXyJelH7XGpvSkRP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(10070799003)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AVhx2PE/Tyj7FaFpRs0jqlyHAq6pefWYLw0XycS/PxKOQzt2gk7+NwNbXaqT?=
 =?us-ascii?Q?VBXWUkUD6fEYqn/aEYu+BDi+UfMWeH9tSO//pEY0Nrlkw3eAVr8Ieofk69bZ?=
 =?us-ascii?Q?0ZEG0l9FS5gO/aOqpo58S2kG6qvsXlqcIil9wJZ7GnOsAlHPyypW3DDatnvh?=
 =?us-ascii?Q?kHzQ6gazOdoTuM90XLBh31R/ynFbz+c+8UVGxl/xV8CK8DDzbbyytg64we3Z?=
 =?us-ascii?Q?hk0uytiwDZvtAxsMHqAcMVu2ln8Tlobm9ZHFLFlbSNnw4JzsJu74CY3QO1aq?=
 =?us-ascii?Q?8LPCKiV32tFa04cXBSYtTGFiGiBLedQ845uwPmZlKQ1tTjbnpMtEtT6pLl3l?=
 =?us-ascii?Q?npySAFq87QBsiitexKs+XY04YGW4++gnXt8Y4ETCRw7d7qbe/3LjBv638Byz?=
 =?us-ascii?Q?xtSkkQTqIa8czifAKpRNRww4tEBt5ncbeSRA/LAXMcfnT4SRH0ETCpBIR4wJ?=
 =?us-ascii?Q?7OPW26nM0QFwpBmq3wJJRB6Utkh19vXTOh1nG0hIqaFNFusMH99uqT2pUd/p?=
 =?us-ascii?Q?hGPm/2+N1AL4QP7IPXVvEDt/kTz800OWQ4IXj/tgbxSjOLqQGQXSe5TNOiHu?=
 =?us-ascii?Q?nmKqAtgm4swZcFQn01XPqfOPZfaoklqybjhl0I7nIFY8Fte3jCntOXxT2K/u?=
 =?us-ascii?Q?7j2+5Lsq/N4geD+UbE0LA5D9dRGQPRQ59P2/4XNMEu/SSD1Xiv4VobNosBel?=
 =?us-ascii?Q?iR44h3H37Kv5EPOOSbUHjJ1bJrPdr+KTvajyQUFUDpq30SC6ysV8RYSyzZ01?=
 =?us-ascii?Q?lVCJ5qey7Nrf4aNWN6cTYNBUfJAAkVkanxsqKZnmfRQ9mhgOeAd6Q9WdYQQN?=
 =?us-ascii?Q?jsfxJb1Hu7CJU3F2+cHBFAbpq/Yjgb2ugk3TAvIpngfZ3IdD+HJm3K6iU2sx?=
 =?us-ascii?Q?QT7G44ers/SEdiNhn/5XjUyghrkTPN6JTZ3BckhAqn8keKeEIXLNd19txKjl?=
 =?us-ascii?Q?skEK93MtkfPn1Ht/n6vlTGCNTRQ/ge647Qg9viIP6kN47wUhviB5IfM5dGGO?=
 =?us-ascii?Q?y5xpqqjer6E0mU5w2fr/AjVqiLKN5fUTUpXfFHq6J6JQGoYayIqQ8m5hnh0S?=
 =?us-ascii?Q?fYgaSQMkxiISBbTXaQLqMeW9zCTnQu/HPeUuyG07x6XT+89VEZKLO/aLLANb?=
 =?us-ascii?Q?khivmi2nD3DVhSi24es1VgKtQkZ9pEzIzBLPSdLmSSTtel34hgVP4YrF/Mel?=
 =?us-ascii?Q?wIMhFLvwbfxMtkPRXKBckMSYOJPROB3zqWdTonRlMnnwQjPrB7aRsJAkiP0D?=
 =?us-ascii?Q?xcBLTlQ1NbGx3I/cF7uIkxUPcr03SYKo6kjn1hHvTvoDUR2aqEvjOVXzYOnT?=
 =?us-ascii?Q?kiR3db9bvNv9g8l4ZgdoPBxpMZIQKOw3lsiK7lKqBATMVuoVrkex5d7ElCJz?=
 =?us-ascii?Q?m+uoW8HbWEA+vfcxMl31ng84JxtZK73mbx05A2A3LyLgQVTpcfLRM/aROvH7?=
 =?us-ascii?Q?Xqypyhuy1MpaQJwYPsoXHzltoE9TICX8Ayj4jO2ssWVMp0sYsiP94U8v/BgD?=
 =?us-ascii?Q?pi4dNstwQqyqCmtGBlVb60R5v4Wapw/audmy5HuVd8lBrmodR+V7+NM3pvNF?=
 =?us-ascii?Q?cR4SC30EUSr/yFKK+IZu63KW3Vg7HKtLD4f2EAR391vMGNiMxYUR6gwW9Tlz?=
 =?us-ascii?Q?fy+s/rmZyfhJq8VtNsOBXPmOZv4OvisjGulLwHhFqSX3roeL5242PTVUlD2u?=
 =?us-ascii?Q?s5QHpQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	OH+4UOlHgbomePLJI4BjFc8cih4JfJSfzhYvA4qYXNSaF4yGqsL3UrnQ0hFohxYEEf9EulojcV9ES3+st6FLj0TpjhwC/RjovU5Dr3Xzj4cjCsmNYr6PxKaWTumfPPMoIptUXtpGaVi7kH3uNtLtFW342/0gXdHPwAj/9ijSWLUCNRZXRm3C+rsbn30bcCbj5XGVSiXhk0ovVBuhN0tXaZ6K9VxSxlNvtRGUxtaIReklDJ0JxKoGpgUzr0MNssCBa0efz4B4KU0l1vkSd/pHDjCy0cEOIdZPJ8aQTqlTrM5UrwmoO3/VMornX2wnp3MaT8DvjuhPnRmOFEXmqBQxa7rRchVERbnBta/Yh7VmYrkfJNZG0rawE74cFLTKGtQOzHZmGSVtIjaEM55/xWcT1eD/G7LYsjpuQqKBfN5/5CFq6X5rBp2f7NFG5y7m2EBTPchzKqkl8obzOTByIhr+hl84JhxMkdOuKu3ZBF4j5NnIRKwDDqPKo+gzTxupVymVvf+2Wa7//WD2uwrJg7EVBK9R/RHDjZ0thb3LYsY93pZgKwAGIMj5xHnVq13RYnlkyIG1Vl5fqD4/D7oquJl4Hj1mbaISbePYP/XMB30fWkc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 280919a5-979e-43c6-56ff-08dcf37f4446
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 16:25:11.4393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oXMunrZi9YOONMbSAJIYwaLdItp1p0jj/wDGWyABVKbP90tkYdlag5n531nJb7YuNXtjPsddaGUTBc081ULxTunj9pGIvlEUPueLeS34UmM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7771
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-23_13,2024-10-23_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410230095
X-Proofpoint-ORIG-GUID: 7yKagatgMFEDx3YbE58izDUaabkKzlY6
X-Proofpoint-GUID: 7yKagatgMFEDx3YbE58izDUaabkKzlY6

Utilise the kselftest harmness to implement tests for the guard page
implementation.

We start by implement basic tests asserting that guard pages can be
installed, removed and that touching guard pages result in SIGSEGV. We also
assert that, in removing guard pages from a range, non-guard pages remain
intact.

We then examine different operations on regions containing guard markers
behave to ensure correct behaviour:

* Operations over multiple VMAs operate as expected.
* Invoking MADV_GUARD_INSTALL / MADV_GUARD_REMOVE via process_madvise() in
  batches works correctly.
* Ensuring that munmap() correctly tears down guard markers.
* Using mprotect() to adjust protection bits does not in any way override
  or cause issues with guard markers.
* Ensuring that splitting and merging VMAs around guard markers causes no
  issue - i.e. that a marker which 'belongs' to one VMA can function just
  as well 'belonging' to another.
* Ensuring that madvise(..., MADV_DONTNEED) and madvise(..., MADV_FREE)
  do not remove guard markers.
* Ensuring that mlock()'ing a range containing guard markers does not
  cause issues.
* Ensuring that mremap() can move a guard range and retain guard markers.
* Ensuring that mremap() can expand a guard range and retain guard
  markers (perhaps moving the range).
* Ensuring that mremap() can shrink a guard range and retain guard markers.
* Ensuring that forking a process correctly retains guard markers.
* Ensuring that forking a VMA with VM_WIPEONFORK set behaves sanely.
* Ensuring that lazyfree simply clears guard markers.
* Ensuring that userfaultfd can co-exist with guard pages.
* Ensuring that madvise(..., MADV_POPULATE_READ) and
  madvise(..., MADV_POPULATE_WRITE) error out when encountering
  guard markers.
* Ensuring that madvise(..., MADV_COLD) and madvise(..., MADV_PAGEOUT) do
  not remove guard markers.

If any test is unable to be run due to lack of permissions, that test is
skipped.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 tools/testing/selftests/mm/.gitignore    |    1 +
 tools/testing/selftests/mm/Makefile      |    1 +
 tools/testing/selftests/mm/guard-pages.c | 1239 ++++++++++++++++++++++
 3 files changed, 1241 insertions(+)
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
index 000000000000..7db9c913e9db
--- /dev/null
+++ b/tools/testing/selftests/mm/guard-pages.c
@@ -0,0 +1,1239 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#define _GNU_SOURCE
+#include "../kselftest_harness.h"
+#include <asm-generic/mman.h> /* Force the import of the tools version. */
+#include <assert.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <linux/userfaultfd.h>
+#include <setjmp.h>
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
+/*
+ * Ignore the checkpatch warning, as per the C99 standard, section 7.14.1.1:
+ *
+ * "If the signal occurs other than as the result of calling the abort or raise
+ *  function, the behavior is undefined if the signal handler refers to any
+ *  object with static storage duration other than by assigning a value to an
+ *  object declared as volatile sig_atomic_t"
+ */
+static volatile sig_atomic_t signal_jump_set;
+static sigjmp_buf signal_jmp_buf;
+
+/*
+ * Ignore the checkpatch warning, we must read from x but don't want to do
+ * anything with it in order to trigger a read page fault. We therefore must use
+ * volatile to stop the compiler from optimising this away.
+ */
+#define FORCE_READ(x) (*(volatile typeof(x) *)x)
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
+		if (write)
+			*ptr = 'x';
+		else
+			FORCE_READ(ptr);
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
+	if (sigaction(SIGSEGV, &act, NULL))
+		ksft_exit_fail_perror("sigaction");
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
+	ASSERT_EQ(madvise(ptr, page_size, MADV_GUARD_INSTALL), 0);
+
+	/* Establish that 1st page SIGSEGV's. */
+	ASSERT_FALSE(try_read_write_buf(ptr));
+
+	/* Ensure we can touch everything else.*/
+	for (i = 1; i < NUM_PAGES; i++) {
+		char *curr = &ptr[i * page_size];
+
+		ASSERT_TRUE(try_read_write_buf(curr));
+	}
+
+	/* Establish a guard page at the end of the mapping. */
+	ASSERT_EQ(madvise(&ptr[(NUM_PAGES - 1) * page_size], page_size,
+			  MADV_GUARD_INSTALL), 0);
+
+	/* Check that both guard pages result in SIGSEGV. */
+	ASSERT_FALSE(try_read_write_buf(ptr));
+	ASSERT_FALSE(try_read_write_buf(&ptr[(NUM_PAGES - 1) * page_size]));
+
+	/* Remove the first guard page. */
+	ASSERT_FALSE(madvise(ptr, page_size, MADV_GUARD_REMOVE));
+
+	/* Make sure we can touch it. */
+	ASSERT_TRUE(try_read_write_buf(ptr));
+
+	/* Remove the last guard page. */
+	ASSERT_FALSE(madvise(&ptr[(NUM_PAGES - 1) * page_size], page_size,
+			     MADV_GUARD_REMOVE));
+
+	/* Make sure we can touch it. */
+	ASSERT_TRUE(try_read_write_buf(&ptr[(NUM_PAGES - 1) * page_size]));
+
+	/*
+	 *  Test setting a _range_ of pages, namely the first 3. The first of
+	 *  these be faulted in, so this also tests that we can install guard
+	 *  pages over backed pages.
+	 */
+	ASSERT_EQ(madvise(ptr, 3 * page_size, MADV_GUARD_INSTALL), 0);
+
+	/* Make sure they are all guard pages. */
+	for (i = 0; i < 3; i++) {
+		char *curr = &ptr[i * page_size];
+
+		ASSERT_FALSE(try_read_write_buf(curr));
+	}
+
+	/* Make sure the rest are not. */
+	for (i = 3; i < NUM_PAGES; i++) {
+		char *curr = &ptr[i * page_size];
+
+		ASSERT_TRUE(try_read_write_buf(curr));
+	}
+
+	/* Remove guard pages. */
+	ASSERT_EQ(madvise(ptr, NUM_PAGES * page_size, MADV_GUARD_REMOVE), 0);
+
+	/* Now make sure we can touch everything. */
+	for (i = 0; i < NUM_PAGES; i++) {
+		char *curr = &ptr[i * page_size];
+
+		ASSERT_TRUE(try_read_write_buf(curr));
+	}
+
+	/*
+	 * Now remove all guard pages, make sure we don't remove existing
+	 * entries.
+	 */
+	ASSERT_EQ(madvise(ptr, NUM_PAGES * page_size, MADV_GUARD_REMOVE), 0);
+
+	for (i = 0; i < NUM_PAGES * page_size; i += page_size) {
+		char chr = ptr[i];
+
+		ASSERT_EQ(chr, 'x');
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
+	/*
+	 * Now mark the whole range as guard pages and make sure all VMAs are as
+	 * such.
+	 */
+
+	/*
+	 * madvise() is certifiable and lets you perform operations over gaps,
+	 * everything works, but it indicates an error and errno is set to
+	 * -ENOMEM. Also if anything runs out of memory it is set to
+	 * -ENOMEM. You are meant to guess which is which.
+	 */
+	ASSERT_EQ(madvise(ptr_region, 100 * page_size, MADV_GUARD_INSTALL), -1);
+	ASSERT_EQ(errno, ENOMEM);
+
+	for (i = 0; i < 10; i++) {
+		char *curr = &ptr1[i * page_size];
+
+		ASSERT_FALSE(try_read_write_buf(curr));
+	}
+
+	for (i = 0; i < 5; i++) {
+		char *curr = &ptr2[i * page_size];
+
+		ASSERT_FALSE(try_read_write_buf(curr));
+	}
+
+	for (i = 0; i < 20; i++) {
+		char *curr = &ptr3[i * page_size];
+
+		ASSERT_FALSE(try_read_write_buf(curr));
+	}
+
+	/* Now remove guar pages over range and assert the opposite. */
+
+	ASSERT_EQ(madvise(ptr_region, 100 * page_size, MADV_GUARD_REMOVE), -1);
+	ASSERT_EQ(errno, ENOMEM);
+
+	for (i = 0; i < 10; i++) {
+		char *curr = &ptr1[i * page_size];
+
+		ASSERT_TRUE(try_read_write_buf(curr));
+	}
+
+	for (i = 0; i < 5; i++) {
+		char *curr = &ptr2[i * page_size];
+
+		ASSERT_TRUE(try_read_write_buf(curr));
+	}
+
+	for (i = 0; i < 20; i++) {
+		char *curr = &ptr3[i * page_size];
+
+		ASSERT_TRUE(try_read_write_buf(curr));
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
+	ASSERT_EQ(madvise(ptr_region, 100 * page_size, MADV_GUARD_INSTALL), 0);
+	for (i = 0; i < 100; i++) {
+		char *curr = &ptr_region[i * page_size];
+
+		ASSERT_FALSE(try_read_write_buf(curr));
+	}
+	ASSERT_EQ(madvise(ptr_region, 100 * page_size, MADV_GUARD_REMOVE), 0);
+	for (i = 0; i < 100; i++) {
+		char *curr = &ptr_region[i * page_size];
+
+		ASSERT_TRUE(try_read_write_buf(curr));
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
+	/* We want guard markers at start/end of each VMA. */
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
+	/* Now guard in one step. */
+	count = process_madvise(pidfd, vec, 6, MADV_GUARD_INSTALL, 0);
+
+	/* OK we don't have permission to do this, skip. */
+	if (count == -1 && errno == EPERM)
+		ksft_exit_skip("No process_madvise() permissions, try running as root.\n");
+
+	/* Returns the number of bytes advised. */
+	ASSERT_EQ(count, 6 * page_size);
+
+	/* Now make sure the guarding was applied. */
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
+	/* Now do the same with unguard... */
+	count = process_madvise(pidfd, vec, 6, MADV_GUARD_REMOVE, 0);
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
+/* Assert that unmapping ranges does not leave guard markers behind. */
+TEST_F(guard_pages, munmap)
+{
+	const unsigned long page_size = self->page_size;
+	char *ptr, *ptr_new1, *ptr_new2;
+
+	ptr = mmap(NULL, 10 * page_size, PROT_READ | PROT_WRITE,
+		   MAP_ANON | MAP_PRIVATE, -1, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+
+	/* Guard first and last pages. */
+	ASSERT_EQ(madvise(ptr, page_size, MADV_GUARD_INSTALL), 0);
+	ASSERT_EQ(madvise(&ptr[9 * page_size], page_size, MADV_GUARD_INSTALL), 0);
+
+	/* Assert that they are guarded. */
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
+	/* Assert that they are now not guarded. */
+	ASSERT_TRUE(try_read_write_buf(ptr_new1));
+	ASSERT_TRUE(try_read_write_buf(ptr_new2));
+
+	/* Cleanup. */
+	ASSERT_EQ(munmap(ptr, 10 * page_size), 0);
+}
+
+/* Assert that mprotect() operations have no bearing on guard markers. */
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
+	/* Guard the middle of the range. */
+	ASSERT_EQ(madvise(&ptr[5 * page_size], 2 * page_size,
+			  MADV_GUARD_INSTALL), 0);
+
+	/* Assert that it is indeed guarded. */
+	ASSERT_FALSE(try_read_write_buf(&ptr[5 * page_size]));
+	ASSERT_FALSE(try_read_write_buf(&ptr[6 * page_size]));
+
+	/* Now make these pages read-only. */
+	ASSERT_EQ(mprotect(&ptr[5 * page_size], 2 * page_size, PROT_READ), 0);
+
+	/* Make sure the range is still guarded. */
+	ASSERT_FALSE(try_read_buf(&ptr[5 * page_size]));
+	ASSERT_FALSE(try_read_buf(&ptr[6 * page_size]));
+
+	/* Make sure we can guard again without issue.*/
+	ASSERT_EQ(madvise(&ptr[5 * page_size], 2 * page_size,
+			  MADV_GUARD_INSTALL), 0);
+
+	/* Make sure the range is, yet again, still guarded. */
+	ASSERT_FALSE(try_read_buf(&ptr[5 * page_size]));
+	ASSERT_FALSE(try_read_buf(&ptr[6 * page_size]));
+
+	/* Now unguard the whole range. */
+	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_GUARD_REMOVE), 0);
+
+	/* Make sure the whole range is readable. */
+	for (i = 0; i < 10; i++) {
+		char *curr = &ptr[i * page_size];
+
+		ASSERT_TRUE(try_read_buf(curr));
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
+	/* Guard the whole range. */
+	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_GUARD_INSTALL), 0);
+
+	/* Make sure the whole range is guarded. */
+	for (i = 0; i < 10; i++) {
+		char *curr = &ptr[i * page_size];
+
+		ASSERT_FALSE(try_read_write_buf(curr));
+	}
+
+	/* Now unmap some pages in the range so we split. */
+	ASSERT_EQ(munmap(&ptr[2 * page_size], page_size), 0);
+	ASSERT_EQ(munmap(&ptr[5 * page_size], page_size), 0);
+	ASSERT_EQ(munmap(&ptr[8 * page_size], page_size), 0);
+
+	/* Make sure the remaining ranges are guarded post-split. */
+	for (i = 0; i < 2; i++) {
+		char *curr = &ptr[i * page_size];
+
+		ASSERT_FALSE(try_read_write_buf(curr));
+	}
+	for (i = 2; i < 5; i++) {
+		char *curr = &ptr[i * page_size];
+
+		ASSERT_FALSE(try_read_write_buf(curr));
+	}
+	for (i = 6; i < 8; i++) {
+		char *curr = &ptr[i * page_size];
+
+		ASSERT_FALSE(try_read_write_buf(curr));
+	}
+	for (i = 9; i < 10; i++) {
+		char *curr = &ptr[i * page_size];
+
+		ASSERT_FALSE(try_read_write_buf(curr));
+	}
+
+	/* Now map them again - the unmap will have cleared the guards. */
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
+	/* Now make sure guard pages are established. */
+	for (i = 0; i < 10; i++) {
+		char *curr = &ptr[i * page_size];
+		bool result = try_read_write_buf(curr);
+		bool expect_true = i == 2 || i == 5 || i == 8;
+
+		ASSERT_TRUE(expect_true ? result : !result);
+	}
+
+	/* Now guard everything again. */
+	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_GUARD_INSTALL), 0);
+
+	/* Make sure the whole range is guarded. */
+	for (i = 0; i < 10; i++) {
+		char *curr = &ptr[i * page_size];
+
+		ASSERT_FALSE(try_read_write_buf(curr));
+	}
+
+	/* Now split the range into three. */
+	ASSERT_EQ(mprotect(ptr, 3 * page_size, PROT_READ), 0);
+	ASSERT_EQ(mprotect(&ptr[7 * page_size], 3 * page_size, PROT_READ), 0);
+
+	/* Make sure the whole range is guarded for read. */
+	for (i = 0; i < 10; i++) {
+		char *curr = &ptr[i * page_size];
+
+		ASSERT_FALSE(try_read_buf(curr));
+	}
+
+	/* Now reset protection bits so we merge the whole thing. */
+	ASSERT_EQ(mprotect(ptr, 3 * page_size, PROT_READ | PROT_WRITE), 0);
+	ASSERT_EQ(mprotect(&ptr[7 * page_size], 3 * page_size,
+			   PROT_READ | PROT_WRITE), 0);
+
+	/* Make sure the whole range is still guarded. */
+	for (i = 0; i < 10; i++) {
+		char *curr = &ptr[i * page_size];
+
+		ASSERT_FALSE(try_read_write_buf(curr));
+	}
+
+	/* Split range into 3 again... */
+	ASSERT_EQ(mprotect(ptr, 3 * page_size, PROT_READ), 0);
+	ASSERT_EQ(mprotect(&ptr[7 * page_size], 3 * page_size, PROT_READ), 0);
+
+	/* ...and unguard the whole range. */
+	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_GUARD_REMOVE), 0);
+
+	/* Make sure the whole range is remedied for read. */
+	for (i = 0; i < 10; i++) {
+		char *curr = &ptr[i * page_size];
+
+		ASSERT_TRUE(try_read_buf(curr));
+	}
+
+	/* Merge them again. */
+	ASSERT_EQ(mprotect(ptr, 3 * page_size, PROT_READ | PROT_WRITE), 0);
+	ASSERT_EQ(mprotect(&ptr[7 * page_size], 3 * page_size,
+			   PROT_READ | PROT_WRITE), 0);
+
+	/* Now ensure the merged range is remedied for read/write. */
+	for (i = 0; i < 10; i++) {
+		char *curr = &ptr[i * page_size];
+
+		ASSERT_TRUE(try_read_write_buf(curr));
+	}
+
+	/* Cleanup. */
+	ASSERT_EQ(munmap(ptr, 10 * page_size), 0);
+}
+
+/* Assert that MADV_DONTNEED does not remove guard markers. */
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
+		char *curr = &ptr[i * page_size];
+
+		*curr = 'y';
+	}
+
+	/* Guard every other page. */
+	for (i = 0; i < 10; i += 2) {
+		char *curr = &ptr[i * page_size];
+		int res = madvise(curr, page_size, MADV_GUARD_INSTALL);
+
+		ASSERT_EQ(res, 0);
+	}
+
+	/* Indicate that we don't need any of the range. */
+	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_DONTNEED), 0);
+
+	/* Check to ensure guard markers are still in place. */
+	for (i = 0; i < 10; i++) {
+		char *curr = &ptr[i * page_size];
+		bool result = try_read_buf(curr);
+
+		if (i % 2 == 0) {
+			ASSERT_FALSE(result);
+		} else {
+			ASSERT_TRUE(result);
+			/* Make sure we really did get reset to zero page. */
+			ASSERT_EQ(*curr, '\0');
+		}
+
+		/* Now write... */
+		result = try_write_buf(&ptr[i * page_size]);
+
+		/* ...and make sure same result. */
+		ASSERT_TRUE(i % 2 != 0 ? result : !result);
+	}
+
+	/* Cleanup. */
+	ASSERT_EQ(munmap(ptr, 10 * page_size), 0);
+}
+
+/* Assert that mlock()'ed pages work correctly with guard markers. */
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
+		char *curr = &ptr[i * page_size];
+
+		*curr = 'y';
+	}
+
+	/* Lock. */
+	ASSERT_EQ(mlock(ptr, 10 * page_size), 0);
+
+	/* Now try to guard, should fail with EINVAL. */
+	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_GUARD_INSTALL), -1);
+	ASSERT_EQ(errno, EINVAL);
+
+	/* OK unlock. */
+	ASSERT_EQ(munlock(ptr, 10 * page_size), 0);
+
+	/* Guard first half of range, should now succeed. */
+	ASSERT_EQ(madvise(ptr, 5 * page_size, MADV_GUARD_INSTALL), 0);
+
+	/* Make sure guard works. */
+	for (i = 0; i < 10; i++) {
+		char *curr = &ptr[i * page_size];
+		bool result = try_read_write_buf(curr);
+
+		if (i < 5) {
+			ASSERT_FALSE(result);
+		} else {
+			ASSERT_TRUE(result);
+			ASSERT_EQ(*curr, 'x');
+		}
+	}
+
+	/*
+	 * Now lock the latter part of the range. We can't lock the guard pages,
+	 * as this would result in the pages being populated and the guarding
+	 * would cause this to error out.
+	 */
+	ASSERT_EQ(mlock(&ptr[5 * page_size], 5 * page_size), 0);
+
+	/*
+	 * Now remove guard pages, we permit mlock()'d ranges to have guard
+	 * pages removed as it is a non-destructive operation.
+	 */
+	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_GUARD_REMOVE), 0);
+
+	/* Now check that no guard pages remain. */
+	for (i = 0; i < 10; i++) {
+		char *curr = &ptr[i * page_size];
+
+		ASSERT_TRUE(try_read_write_buf(curr));
+	}
+
+	/* Cleanup. */
+	ASSERT_EQ(munmap(ptr, 10 * page_size), 0);
+}
+
+/*
+ * Assert that moving, extending and shrinking memory via mremap() retains
+ * guard markers where possible.
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
+	/* Place guard markers at both ends of the 5 page span. */
+	ASSERT_EQ(madvise(ptr, page_size, MADV_GUARD_INSTALL), 0);
+	ASSERT_EQ(madvise(&ptr[4 * page_size], page_size, MADV_GUARD_INSTALL), 0);
+
+	/* Make sure the guard pages are in effect. */
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
+	/* Make sure the guard markers are retained. */
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
+ * guard markers where possible.
+ *
+ * Expanding should retain guard pages, only now in different position. The user
+ * will have to remove guard pages manually to fix up (they'd have to do the
+ * same if it were a PROT_NONE mapping).
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
+	/* Place guard markers at both ends of the 5 page span. */
+	ASSERT_EQ(madvise(ptr, page_size, MADV_GUARD_INSTALL), 0);
+	ASSERT_EQ(madvise(&ptr[4 * page_size], page_size, MADV_GUARD_INSTALL), 0);
+
+	/* Make sure the guarding is in effect. */
+	ASSERT_FALSE(try_read_write_buf(ptr));
+	ASSERT_FALSE(try_read_write_buf(&ptr[4 * page_size]));
+
+	/* Now expand to 10 pages. */
+	ptr = mremap(ptr, 5 * page_size, 10 * page_size, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+
+	/*
+	 * Make sure the guard markers are retained in their original positions.
+	 */
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
+	/*
+	 * Again, make sure the guard markers are retained in their original positions.
+	 */
+	ASSERT_FALSE(try_read_write_buf(ptr));
+	ASSERT_FALSE(try_read_write_buf(&ptr[4 * page_size]));
+
+	/*
+	 * A real user would have to remove guard markers, but would reasonably
+	 * expect all characteristics of the mapping to be retained, including
+	 * guard markers.
+	 */
+
+	/* Cleanup. */
+	munmap(ptr, 20 * page_size);
+}
+/*
+ * Assert that moving, extending and shrinking memory via mremap() retains
+ * guard markers where possible.
+ *
+ * Shrinking will result in markers that are shrunk over being removed. Again,
+ * if the user were using a PROT_NONE mapping they'd have to manually fix this
+ * up also so this is OK.
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
+	/* Place guard markers at both ends of the 5 page span. */
+	ASSERT_EQ(madvise(ptr, page_size, MADV_GUARD_INSTALL), 0);
+	ASSERT_EQ(madvise(&ptr[4 * page_size], page_size, MADV_GUARD_INSTALL), 0);
+
+	/* Make sure the guarding is in effect. */
+	ASSERT_FALSE(try_read_write_buf(ptr));
+	ASSERT_FALSE(try_read_write_buf(&ptr[4 * page_size]));
+
+	/* Now shrink to 3 pages. */
+	ptr = mremap(ptr, 5 * page_size, 3 * page_size, MREMAP_MAYMOVE);
+	ASSERT_NE(ptr, MAP_FAILED);
+
+	/* We expect the guard marker at the start to be retained... */
+	ASSERT_FALSE(try_read_write_buf(ptr));
+
+	/* ...But remaining pages will not have guard markers. */
+	for (i = 1; i < 3; i++) {
+		char *curr = &ptr[i * page_size];
+
+		ASSERT_TRUE(try_read_write_buf(curr));
+	}
+
+	/*
+	 * As with expansion, a real user would have to remove guard pages and
+	 * fixup. But you'd have to do similar manual things with PROT_NONE
+	 * mappings too.
+	 */
+
+	/*
+	 * If we expand back to the original size, the end marker will, of
+	 * course, no longer be present.
+	 */
+	ptr = mremap(ptr, 3 * page_size, 5 * page_size, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+
+	/* Again, we expect the guard marker at the start to be retained... */
+	ASSERT_FALSE(try_read_write_buf(ptr));
+
+	/* ...But remaining pages will not have guard markers. */
+	for (i = 1; i < 5; i++) {
+		char *curr = &ptr[i * page_size];
+
+		ASSERT_TRUE(try_read_write_buf(curr));
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
+	/* Establish guard apges in the first 5 pages. */
+	ASSERT_EQ(madvise(ptr, 5 * page_size, MADV_GUARD_INSTALL), 0);
+
+	pid = fork();
+	ASSERT_NE(pid, -1);
+	if (!pid) {
+		/* This is the child process now. */
+
+		/* Assert that the guarding is in effect. */
+		for (i = 0; i < 10; i++) {
+			char *curr = &ptr[i * page_size];
+			bool result = try_read_write_buf(curr);
+
+			ASSERT_TRUE(i >= 5 ? result : !result);
+		}
+
+		/* Now unguard the range.*/
+		ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_GUARD_REMOVE), 0);
+
+		exit(0);
+	}
+
+	/* Parent process. */
+
+	/* Parent simply waits on child. */
+	waitpid(pid, NULL, 0);
+
+	/* Child unguard does not impact parent page table state. */
+	for (i = 0; i < 10; i++) {
+		char *curr = &ptr[i * page_size];
+		bool result = try_read_write_buf(curr);
+
+		ASSERT_TRUE(i >= 5 ? result : !result);
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
+	/* Guard the first 5 pages. */
+	ASSERT_EQ(madvise(ptr, 5 * page_size, MADV_GUARD_INSTALL), 0);
+
+	pid = fork();
+	ASSERT_NE(pid, -1);
+	if (!pid) {
+		/* This is the child process now. */
+
+		/* Guard will have been wiped. */
+		for (i = 0; i < 10; i++) {
+			char *curr = &ptr[i * page_size];
+
+			ASSERT_TRUE(try_read_write_buf(curr));
+		}
+
+		exit(0);
+	}
+
+	/* Parent process. */
+
+	waitpid(pid, NULL, 0);
+
+	/* Guard markers should be in effect.*/
+	for (i = 0; i < 10; i++) {
+		char *curr = &ptr[i * page_size];
+		bool result = try_read_write_buf(curr);
+
+		ASSERT_TRUE(i >= 5 ? result : !result);
+	}
+
+	/* Cleanup. */
+	ASSERT_EQ(munmap(ptr, 10 * page_size), 0);
+}
+
+/* Ensure that MADV_FREE retains guard entries as expected. */
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
+	/* Guard range. */
+	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_GUARD_INSTALL), 0);
+
+	/* Ensure guarded. */
+	for (i = 0; i < 10; i++) {
+		char *curr = &ptr[i * page_size];
+
+		ASSERT_FALSE(try_read_write_buf(curr));
+	}
+
+	/* Lazyfree range. */
+	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_FREE), 0);
+
+	/* This should leave the guard markers in place. */
+	for (i = 0; i < 10; i++) {
+		char *curr = &ptr[i * page_size];
+
+		ASSERT_FALSE(try_read_write_buf(curr));
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
+	/* Guard range. */
+	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_GUARD_INSTALL), 0);
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
+/* Ensure that MADV_COLD, MADV_PAGEOUT do not remove guard markers. */
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
+	/* Guard range. */
+	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_GUARD_INSTALL), 0);
+
+	/* Ensured guarded. */
+	for (i = 0; i < 10; i++) {
+		char *curr = &ptr[i * page_size];
+
+		ASSERT_FALSE(try_read_write_buf(curr));
+	}
+
+	/* Now mark cold. This should have no impact on guard markers. */
+	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_COLD), 0);
+
+	/* Should remain guarded. */
+	for (i = 0; i < 10; i++) {
+		char *curr = &ptr[i * page_size];
+
+		ASSERT_FALSE(try_read_write_buf(curr));
+	}
+
+	/* OK, now page out. This should equally, have no effect on markers. */
+	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_PAGEOUT), 0);
+
+	/* Should remain guarded. */
+	for (i = 0; i < 10; i++) {
+		char *curr = &ptr[i * page_size];
+
+		ASSERT_FALSE(try_read_write_buf(curr));
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
+		ksft_exit_skip("No userfaultfd permissions, try running as root.\n");
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
+	/* Guard the range. This should not trigger the uffd. */
+	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_GUARD_INSTALL), 0);
+
+	/* The guarding should behave as usual with no uffd intervention. */
+	for (i = 0; i < 10; i++) {
+		char *curr = &ptr[i * page_size];
+
+		ASSERT_FALSE(try_read_write_buf(curr));
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
2.47.0


