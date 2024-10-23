Return-Path: <linux-arch+bounces-8469-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AEAB59AD05E
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2024 18:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF6BA1C216A3
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2024 16:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E86A1CEEBD;
	Wed, 23 Oct 2024 16:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OQGzpDXG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="C+a2OfwT"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BCB1CC150;
	Wed, 23 Oct 2024 16:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729700747; cv=fail; b=trxKmSowWdfvCFAkybe4jGIckStlfCANH6SCT6ctHTsBrjK8gYWPjYh1WUaDWBm7GJ7b+zQBUk9JMCMuYi3doTI9mITqt/ZBwZhhQ6czAhqjrVvSm1EkSFbIwg57jDE1TXZ6WAM8ePFcAefuU/ySx6HoTK8KBdYyaAf7nPJeoEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729700747; c=relaxed/simple;
	bh=UMXPNyMhuG8K3Sa4CmNpk9M3JSqkXu/o90O4N0El2xg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AIm/WmRudhVCA1OQAd4hdAQIwiK7bIRVFVhmOA6PMMzf69p520F8t2Mkeruq3g5IAiXlZ6S+KpA8svk7MSbvRyWYpy3nnYUr6LPdHQErUI2sVT6zQSghCk2DNAJgBAUxZG0MrD/mGgg7hVSPh60iAbtU+uq9u302StorNF9/xTQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OQGzpDXG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=C+a2OfwT; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49NFfeeR012091;
	Wed, 23 Oct 2024 16:25:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=A5pNDtupVIY/6qMld72YpfiKd1tj229APGKKEth5+Rc=; b=
	OQGzpDXGsAWINKUQV0qdWiS5B3rKRYaQNnQkgfMdCJ8BkiAZA58PdwjuFMsRAKZx
	QWj4UfSfBROWqjbiqWodDaXmBNc2Og4eMMKIAp8vgEiD6fk6rPl7PGn+HeglojAm
	Vfkd69Sy3hxOb1lGalnfAXZNHGNRlacKziK0FhS6WI3ICUzm05u6CumLCn09EGRH
	wC/d31bVCb6HOvfRaBCMrFXenQiH9n67gDO2zF96pr7ZAy2xiQNcNi0lj939bZ3A
	jM1d8bBNP+qfmJbfZLg+gPYFbR5L8u6G5DnygGekhJoZX94YSIDs7oy0lgNZ2rmU
	dbaPsLFmlXVSz+OGzQ24sg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c53urhtd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 16:25:12 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49NG9cBJ025412;
	Wed, 23 Oct 2024 16:25:11 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42emh9rd4k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 16:25:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s2oCC2EW+/xPUlDvbvVIhEaqkB8+sKKfxkCNGSaZwmijAWMgHzKSm2SDrCoCaoI276I3m1zOvLoHv0A/892WDVWqvgER9P1fm026hk1zM+SAoH7HzAUZbtCFLWHtb2N8RKlxxDpwlvcQTqzuQJ552upvtMYHF67b6pFdmD4nZY7ZUG7TmS0pwnpGc9QFV2SyDq+9EOauv54MWJrBaqmVKWq4qlFG8ldV3EpF+fAUjjNQLfH3BY+31AkUM3Aed8nzifQQgi5P5yugzmJZtXDylDWClUTWgzgtBORizDXjN6X7Q63bXfMLV8mpbybevXjHsdL5oRpmxkYZXNXcC3E3aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A5pNDtupVIY/6qMld72YpfiKd1tj229APGKKEth5+Rc=;
 b=OJZewXa2mkWIjTUFRMJ6rUNbWiCCsqRArThHSLDoY/vEF71i9hYIg6DaIHcQ6UJ05z4exnYHTx+ljJVX9gO6P2N1G9WTKTlPmxQKkmVqTlmvhkK93CLPukaLydyKGhA/wuUS5tuZNNew9wItRnodSry2I3e/bQd63fLyI9OAbEJPKqqxgBp7Om3oyQMhvHFSY3yN+guKYuwaneuyVchTJmjjIPRd7Mxy77xe+oorwSdv1vCr6tUsTl/eSq1dlEcau4qKxcC/TfHDiQIVtzR9vvZUrNg6+IQA7h0cbU5/MmjXqPcSyT+9BLbSPSHlyowRy8ZTwJb71H06HisqI0HoMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A5pNDtupVIY/6qMld72YpfiKd1tj229APGKKEth5+Rc=;
 b=C+a2OfwTiiK3bLDOi6o7NEQEWwm6GFi8Cp76qXwfmYkAKhazAiHXLZ8IFCzCjGg9h98uE7uqt/QxHmoB+gsPiRUHdn1gsZjeNIi8cx+1HJgg9oYpV2oW/LBp1LwxZziKlmtDGPloRtRpUWOPxJPEFOA2Gaz0GcWaf6hREFDk11Y=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by LV3PR10MB7771.namprd10.prod.outlook.com (2603:10b6:408:1b0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Wed, 23 Oct
 2024 16:25:08 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8069.024; Wed, 23 Oct 2024
 16:25:08 +0000
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
Subject: [PATCH v3 4/5] tools: testing: update tools UAPI header for mman-common.h
Date: Wed, 23 Oct 2024 17:24:41 +0100
Message-ID: <c3e259919d5b876b9a71ba14fe8d6cb85d51f164.1729699916.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1729699916.git.lorenzo.stoakes@oracle.com>
References: <cover.1729699916.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0219.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:b::15) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|LV3PR10MB7771:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bb91279-36f2-4e60-807b-08dcf37f41d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|10070799003|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UykFLxwYQiABzcvJJjn/1yVbnojflyAI9XIDBYYDe8nGrAjEU3/jJebGgNfX?=
 =?us-ascii?Q?o+4Fo1MRJGn3nXFYuSP8PSqjWRwlsZEp9XiPIvo5Jy2DoebRLIrI1/M46eJV?=
 =?us-ascii?Q?ZqagXkwngHVoZXcIsrChuREL4MYuhs1MG8H052oNkaJ7IRdrOQsnW5cvcRK0?=
 =?us-ascii?Q?yIDM522VWJds7KG6fsWfz/vhKm7HptlK/4yRSpuq/B4+PVOpnKcnVLc5IdmM?=
 =?us-ascii?Q?iNSc8cc+XinmJy3nfxO4a/hKCZ20yKwBS/z8CJoyRA7C18VkmMPQlMo2zmUF?=
 =?us-ascii?Q?73w9c8KC2UOEMK507wX16Lz/dIGY8LD4K1byPCeK0XwyslDwqzZ6EIah3HVL?=
 =?us-ascii?Q?/G+aADhih0LZ+5wibiJhU6j90cKJF4cJvME0/MT675+WdyStTHGLKzCm6pmn?=
 =?us-ascii?Q?CzrVVqop9BxIAY++5mHhUfhpbkza5umSdilSefb9RT/cCQ6oayx+95gSbWed?=
 =?us-ascii?Q?lp6Q+UKDks/z9FWbSnxWasMS5Ut8QEcokChuZ3Rkz968lBMBzRLMxWTcIDgw?=
 =?us-ascii?Q?KS4mP+YXzDjPqOjfkXEBourN8qP88ZgZcEJ+SQjhrOqkEaGPTi+Uopa0PdyW?=
 =?us-ascii?Q?AEiigH9sYHd02nMEwHNSAfUDyxWL/K+jm9yTVdb5DIrIIV+Gyo6+34ZQCWw9?=
 =?us-ascii?Q?djGzhNpaPIizmKqvmbv6QWHuI8d3kMm6BXO7bJe5sHrT3X7bRXPuq5V+X8/K?=
 =?us-ascii?Q?ZrKAjyrhp4rJ85o2xWcBNi+FNxVSz4gupTKEgYCFH2g570FB2srjyjc5vE8a?=
 =?us-ascii?Q?QgLQCrCveqTLsUg8nfGInGGRLeQbvYIEoRrL+MSsnSXcww3MCPt3cGYCL4i8?=
 =?us-ascii?Q?GdoUGt2qnExBDNhpUuKno50aF8yI2rccJWknRjmzJXybjlD2CWjGhte5IB9Q?=
 =?us-ascii?Q?0CVpgZFHWu6VI/4wCcqT+Z0KdpOiZvND1scWsOAWqnXaaxotydatnkBjl+3E?=
 =?us-ascii?Q?3UkObLuSyB1djadD6RRN3VbatBLN+d8O6HADXbqgMZsovw7Ffi/tZ1/Kpgf/?=
 =?us-ascii?Q?HrfrJmdzROx/vatqNUUQIBkSVb8kXPSIga9uVpd0uNEzBwY3a/yGxWr43p/9?=
 =?us-ascii?Q?gNrca8zwbO3MtlekNZJauXm2O1VuTqy/KxnH+eITfoVAeWHiuXP/UXHgxWgf?=
 =?us-ascii?Q?7OeDu9wnlvQ0XxuSH9UPZu5g69VZavSpOiFIUHpEr+7DwAmq3RmF/HCz3WEt?=
 =?us-ascii?Q?hFAMeZxnpLNk+Qj72ImCpFcAthi5cfX9omwTB9/3yGZR5ZBeICN4LUdyRywz?=
 =?us-ascii?Q?ir67ivFx/f74ye86RcO41TzNz3BxsvMQ29NH+fq8GVMyfvOBSIL3qeUSlFOY?=
 =?us-ascii?Q?IZ5D9MIIuxHX6OgIqvuBpYyW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(10070799003)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YikuZoNCf8R6tlLMSPFEZaE8R91Vepny4VnxZhlgZEOvcU117OEDu9LTMMmE?=
 =?us-ascii?Q?o2djcjhkKHIY2lBOrB1xQbrdBzNpadMrVE6TBrQ2NURj5+PSeiolbzHu3dte?=
 =?us-ascii?Q?UaCTxBddd6ISR8Y4MurTlykt8WlLNTabB2mMk/HAfYjxRkai3ejYaz0q71bn?=
 =?us-ascii?Q?SeabMPFK8iIMJ1wCeAGiZ7QdwcCh25vnB+eo/uDPhuZSpKovYDVJlYhIjVyK?=
 =?us-ascii?Q?GhA+qOKrtyFy/iu0RoJvXWpB7zQHAWPul3vhhBF6Id/ICWLxwcP+TP7sKGRZ?=
 =?us-ascii?Q?fC3FKJ2k1qr2sya++C7Qy3hSwegNL7q+3u12S4fLQrYptmMeOhmkK0XR0c0A?=
 =?us-ascii?Q?3JYS/a+NPkSstnSYfThh6cZxWc3Eh2A2YktEgTTweyBv3DX4pGXCcSGaChM3?=
 =?us-ascii?Q?cQ2uaz5U5gKSKYRJb+AJkQ+3PpRudygQml3pHzXZIIGCOuwzRMu/HpBZNAA8?=
 =?us-ascii?Q?r9NniwKcVDdDznq4gLwBHyIGe4dz98MfZ9PNhRtPuoBm50/F8HxMqUD2oujZ?=
 =?us-ascii?Q?bxGQwj40tNAymk1wmb4xjc+FA7+aIQ20kwRx46rrP26ZGF6tQ603qKHTn5TJ?=
 =?us-ascii?Q?HkEB9NqheKASkwHqaUWUaSzwxBFIgXe44CtImtRq8LGN5mCwtTF9enqFLc/j?=
 =?us-ascii?Q?jmR1zuVlINy8EWsp5Xaxs1waoo99d29SLgF8zFYtFrOQi4aMint3HRTR6Tj0?=
 =?us-ascii?Q?831gbj9aee4hZ0PdiGCKoMl8XtGBbZAR3f5lveTa2AYjtFGI6eGOrYRLEQmV?=
 =?us-ascii?Q?+WPxHR2rjSlHJcN1SYVoVpUgG0kpT0knZR7QOErbc0VM/wkD631VSNPX0Apg?=
 =?us-ascii?Q?B/Yzotb2lBEWSyznppCfpVJfzvgRhYl7peUPttYsjjzEzqCv5KLI20nNS7b1?=
 =?us-ascii?Q?txOjUnr+qidwhEA87opjEEpjrclXgJRUNcDNVnKOKw87/ylv7Fc23oBL5UGd?=
 =?us-ascii?Q?xeqK5QERh40+z/N4eVafN1ceypp7aZRQ18BTg5qjStle/qjVWfAiwnwmxvUw?=
 =?us-ascii?Q?abuEWZxJC/iWdObsaJhqD/oYyX+pED8gk38MrITC+LklMrX8MdISG0C86uK0?=
 =?us-ascii?Q?dqXKRwZRPHBYI8n6DiEBIIc2XJEUppSVjWvgI1AaT/amWP5/S8bMesB8uUkY?=
 =?us-ascii?Q?jg3Ox5TCdCyWYP/s4AqLAUyvAoTLxk3kAl8Egfx5/d8tBOAD4yzcdrziLlIe?=
 =?us-ascii?Q?lYXvIKI1rgstNvdXVK9MnAkgUYQQgZoM01+ZMkCcRDh6unoJLpWTZfJUw9jt?=
 =?us-ascii?Q?pXI0dHPgYu3tQbPY2orgp/6v3jUnfRinDm8rfjkziDPolgSTW1j0yLrdKd9p?=
 =?us-ascii?Q?YvNYm5thTfAypWENd6zfYlNQHpWUNsZ+SwgYzU8GlkpMJQApIO1T4eeZr1As?=
 =?us-ascii?Q?PJiKvNw569p8ZUcPNWw8KkxQrLvrp0D2moVgZ0Vvua6FBHbhiWd6WrnpYuUO?=
 =?us-ascii?Q?/MmevmNBpVpVIugnuQDBCAz913yQK+F6wQCtuuH3W5R8vn+lB2rsXmUeDGA6?=
 =?us-ascii?Q?6jf6T5Es3v19/BRAGn+xor7Jo52vvAe1PT7oYW9FKatgJ9S3Lx/mkkkQZjfR?=
 =?us-ascii?Q?yX+q+mXTjqN6/KVSd5UplWwA/E1ZcYKWkug5T3nQEifCFDwFWaX+NO/A/GMb?=
 =?us-ascii?Q?sZbgbeNbhRXyRVESBpCIGa1eQKxCrQtDyrjt/OAShr0HfrW5l8bukNjGVN3N?=
 =?us-ascii?Q?AT2nOA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gqVKXU/AjOmdGGfQVN5LagOoJuyneNPpXo8rIlcZj1SCEQwCFB11yc3NPjJfIh17bzGE3QAgzigwV7g8GBzB5Js90lijTPSIIhJtNdHIJB3yUcU+qK0uTlMJ/1Oo3gee7NqLi/DSoLLiEL1pqj6UF0exCXMm8EqeQRE+18Jgvt8aHwN0fRkFaWpDxJKyjMPo4cr5f3wR8f3TFZhwPo03DUHi9OxSkA5K9tngh8ZY3SL6YiN9A9VrrVjENTisBNGvhOQZeK7LEvaP2yk1GlybEReqvTY3VOT8vS54Ld/Px5bq0btIzubQEf7OKPGsKSKmDXQWgni77kymHqhK6Tk2HA0C+9C9y0wOyVzg8PO8DmnGVO4wUQazHUGbQ3HHDjukSJiBY/YyyTIsP9l8/BSPKWGGT/F4jlhFaNHCQVc3dbKKTmD9exaB7W6Q0kVTlGWc4cz7KhnYGlZdEkkpGFmmtMVmSGnRlK4auTh5O7BdChuB71StJdd/diOxvA71Nf3vZwzoJkRpFmbLRjwhxIUwpNcHMJNbSNNN+xTP740VlIk1CfLHIB2eYPIR464rd0QpwL/BICa7dP3omRb4VjoPGY7XArpRTmnymOWHnUXyOMo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bb91279-36f2-4e60-807b-08dcf37f41d5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 16:25:07.9085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RwiTvHlPuPImutbls+xxjc06+TlU9mzD4b/ohW+2xvnfEK/kCrYrc98PRWAwCbznvyMQLQ5y+wG+CimZkddYFQgt+2Q8SneH4CXTy8XiWcQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7771
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-23_13,2024-10-23_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 mlxlogscore=858 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410230102
X-Proofpoint-GUID: XemlPcOgAzeYzwjS2KKly0v-vLs_O2Iw
X-Proofpoint-ORIG-GUID: XemlPcOgAzeYzwjS2KKly0v-vLs_O2Iw

Import the new MADV_GUARD_INSTALL/REMOVE madvise flags.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 tools/include/uapi/asm-generic/mman-common.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/include/uapi/asm-generic/mman-common.h b/tools/include/uapi/asm-generic/mman-common.h
index 6ce1f1ceb432..1ea2c4c33b86 100644
--- a/tools/include/uapi/asm-generic/mman-common.h
+++ b/tools/include/uapi/asm-generic/mman-common.h
@@ -79,6 +79,9 @@
 
 #define MADV_COLLAPSE	25		/* Synchronous hugepage collapse */
 
+#define MADV_GUARD_INSTALL 102		/* fatal signal on access to range */
+#define MADV_GUARD_REMOVE 103		/* unguard range */
+
 /* compatibility flags */
 #define MAP_FILE	0
 
-- 
2.47.0


