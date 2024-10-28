Return-Path: <linux-arch+bounces-8651-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F08EF9B32F0
	for <lists+linux-arch@lfdr.de>; Mon, 28 Oct 2024 15:14:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 205B51C21DF5
	for <lists+linux-arch@lfdr.de>; Mon, 28 Oct 2024 14:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521131DD88E;
	Mon, 28 Oct 2024 14:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oTR6D5ig";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lz5xZUr4"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3045C1DD866;
	Mon, 28 Oct 2024 14:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730124874; cv=fail; b=g4udleIP6QTP4s9iSOAyAIiXk2k6RgCmgSSNSJYirmFwpoqfOeDc+OiBC1ie5Y/1gwvzgeV70TNIk9TZgXBQDQrEnkjHgCCTUxCRcJQ/Ytvb6rjpc+nhSr7BBgYUhtiJQA0+ZmfzaRCWaqw1q00WHwR5pHrCMHS3M/q0ribEy2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730124874; c=relaxed/simple;
	bh=UMXPNyMhuG8K3Sa4CmNpk9M3JSqkXu/o90O4N0El2xg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=frOs29Jgacbanig8D2EmwpThhQV/PeT5gAT4EOrnKgopiB/ZomBpFTp6AIwm6MQ0sTY4ouMWzT3CNoElNUoDsHmc8p3tWcKWvJ8F0tP393DIlxYm+PR+hpjSPdwItbekqYMLxBuO90tGYMIxZeXZR15SjVgNnIHhIsy9ro/iZQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oTR6D5ig; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lz5xZUr4; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49SBSf4N004612;
	Mon, 28 Oct 2024 14:13:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=A5pNDtupVIY/6qMld72YpfiKd1tj229APGKKEth5+Rc=; b=
	oTR6D5igk8PgibPbT79AZWmzg2p7dMQDqHW4fCm3KBiaIt8FaPEmojH2spQFMHjM
	BwdlZN5wtItrc+134+rUCe5w1TUAJk42FkGcOiJyZGYK79vWiov5moeQ22jcBSTO
	yvhlazHBzQ3o5caOoVTVAcWL1WXDz/iOCbq/Uk57Re0C+5KV5dHVUiHgBqUVabm0
	icTyw6ub4/C3sN1W9eU0ZBLb88xzG+jjepKXgf9SMzjHLB/7p/v6n+5YTdnR9Ypt
	S9s5VRfhrcuesoa9nsU5efc0475UjPSvZe9ynJkw2eHj6XX77Y5trE9xZA5W6dRJ
	CBxHHgNyqXU2qL04rVxe6Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grdqax6b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Oct 2024 14:13:56 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49SCvBwh004210;
	Mon, 28 Oct 2024 14:13:55 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42jb2ska6s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Oct 2024 14:13:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EH8Anm1L+MzXDzGqNspmFo8Gi8ydjbEz0/fvGxIjO85gYJuec76Cx9UX3eCBRZkR91j8ErzMSy0ZpaFvLDHfWNX0PEW4TddpNilBkifvzduGZNEMScH+/eJlPR54hw994eV4O27Q3yrPgjBCZ20R39GlHbpfczdBkkQWx/orAF5Jobs1XsC6P3JSmOvp6LV94gDAAQplzJnL8yavyabUEz1NiPFovcbwAfAGh6Y4rlXFVdG7O5wo3zyGlKCMQpvQZ95ws2uOyyysVa7lrfbmhAg98ZSm3Bg1rQ183xeLJfmPJICrQfGpQV00lZNnn3Bkunc9OPTHdzpKgxHf7c4UFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A5pNDtupVIY/6qMld72YpfiKd1tj229APGKKEth5+Rc=;
 b=MTzSvLWvL1QaDZlngvF4M+R4ENHa5eWKQxAVRPbPQQQccTvW04/PuGulIB2Is7KXT8R1rANNYD7rO7k/+yRYAMXvfr9SQPHZxAM0CIH6SZgN7XDBic9aisJ1o1QUltDFo3CL55yu36x93BcKlHoL/Twra4Qu/MdkPFSaa7WkNHFvCFhTibj2nQ256WiSxqOB2GrJrm/PsUiTgdH50Iz9VRcP9+UK0FxdLIcyEnn1LmRzfdpaQszIKMjQGsKWyhWpQ2e2MljE++pIK+BXqZf3K33gkthQNVpQd1BR0/6nIxX8rO87EL5bxPsFan1Xgf5egNoCOpNP64lvZPrhq13WQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A5pNDtupVIY/6qMld72YpfiKd1tj229APGKKEth5+Rc=;
 b=lz5xZUr48f2XDBVSHPBAnBu6GF9RkSAL/VEqmq89E4apyvJ79XdRIFdmsJRYeUQ1ADDep8ZZCZ+zS+H+76aYams8Q6GdP/sJrzr+hJvyvtdbvcqfVHAJMlDxGNEqlrZf2Iapq9vEO1MNaCv8Ol6zHNXLEWM268Wk9PaoENEIQl4=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by SJ2PR10MB7598.namprd10.prod.outlook.com (2603:10b6:a03:540::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Mon, 28 Oct
 2024 14:13:49 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8093.024; Mon, 28 Oct 2024
 14:13:49 +0000
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
Subject: [PATCH v4 4/5] tools: testing: update tools UAPI header for mman-common.h
Date: Mon, 28 Oct 2024 14:13:30 +0000
Message-ID: <ada462fa73fa1defc114242e446ab625b8290b71.1730123433.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1730123433.git.lorenzo.stoakes@oracle.com>
References: <cover.1730123433.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0254.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::26) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|SJ2PR10MB7598:EE_
X-MS-Office365-Filtering-Correlation-Id: 6169548a-e65a-49ab-2336-08dcf75abe31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jymrb880Fy7ku9es9xPmc4LxrYNJuE5G9/311BYtuMZRhEalnSxyRjWgHSvY?=
 =?us-ascii?Q?GYi6SX7F9yhZk6HJJEeo6hNP5s7+X3Rc0ND+Kb9DRWoyT7UmboOwKmGzwDSr?=
 =?us-ascii?Q?svZ3qUP4zKj4+yrzmAlLnPaVTRu/Fj8GodCy5L6EKYRA6t3kgQ7HmVoghj9q?=
 =?us-ascii?Q?rDwd/HG/8ajcWx/SvZQCbG6cRs+19n+08RqeRZSPVgkujk8/kn8JfAr5BX77?=
 =?us-ascii?Q?6AJnCgcTqmmGfo7y5VOqeEYp1LjZqk2k2eZbmCuNBRNoDnhgOuDbKxL1G+WP?=
 =?us-ascii?Q?2z6YuimvxVDl9zcQZRicYTKvdLGNf0N9Bk6Q8AmhyZe9gajpKkKtzJ6SCF6S?=
 =?us-ascii?Q?axGkRZh17DSkAT2KGcxzAd017kc0c2ve3bA4HocO1UxCNuInLZVOjtPs1SM1?=
 =?us-ascii?Q?Lmkf/co2GAz0cTz61WMxn+DcWAXwaaTtwJSi6w+i3MnaiU0OL18U9xK7dPMS?=
 =?us-ascii?Q?EGxqa7N33C1X5GqdTESWk/5bSkf6ASoDuxuij4BNBc5uHWbu7QfGVOLp+JRP?=
 =?us-ascii?Q?/a8cg7EX63ZvoTp68xPMxWNm4ASiBfH+ItUSq5aXZZJwClYAtRH5yK+ZEDGW?=
 =?us-ascii?Q?6m8sLAnpRLnsAd9w+jWNMx4+L6efzyEZ0suDHYSc3WtNL6SnJB81fRkol6PP?=
 =?us-ascii?Q?E1vbwMx2ocKHluXJddAGHsWtmQnJ/JcUrZErEZxDPyKUH5GgCf2sPzer/32+?=
 =?us-ascii?Q?O8icxap8KrnEGBekkL3aydeA+EEQIGEK2b29k/EHqBXdT8xQ5a2giHeDR0Ur?=
 =?us-ascii?Q?dzJ9YDTrQMElZOAS0/DEkBUB4AkXR2pcea19aZAqgfjZ7opLblHTODjL9yiD?=
 =?us-ascii?Q?gS1ZaZAfaHj7tAAQyBLIc38K1deFTCZcu0r8WIOpBzq4RIoES5nDTfuRNu7S?=
 =?us-ascii?Q?xlATcLzn7kQFRrp0N6WKzcNoTjGlj8LxZqIXOr7BJ0JqhgaOTaCimQJddpek?=
 =?us-ascii?Q?NI782I3Qh0ysVFZ/7S45J0pbap3rKjiXtcpjH4uHgyuXTjiW8s7JGTgtTLh8?=
 =?us-ascii?Q?okbs10E5MISVNGdaj+o9NOqWB4k3u4uzot5UDFEHDQHes1Ytmk0/I/VuVmBt?=
 =?us-ascii?Q?gNbJnOmq+fZ0JMUV1KuWs3KS3XUg1GSmQQNfQr93nCvwBdf+eDr/TOHFRiiX?=
 =?us-ascii?Q?+KIhrvosYUbyPq4/ybrXnPi+4/hoYDz0L/NL2mY4OxdppFKfrN47M5xUjx0W?=
 =?us-ascii?Q?KWZ1/j2Ri6oQJfVW63YR5GXN8tkPiTS9NX7C+d3nMkc+c5IuIdU3mGbhcMui?=
 =?us-ascii?Q?CUbTsaPOanRUZLH/wgV8ZUamhY6Cm4WegU/tYi2MQ/04/X2wz0qJxG2nIiks?=
 =?us-ascii?Q?p0rj0SfokX2OwYd8uxnvuOzJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?C8pjiRDnqv2c1gHVO52UfHiPmXPFzzoom8qUb9bcl/WJZyflmvWr0F8CfZiq?=
 =?us-ascii?Q?xZY+KwNpIIIciIz4HkL3JmGpxh7wSMIkQ1qj2YLpaHovnZJ7r81OP2140sCu?=
 =?us-ascii?Q?tNCgqzGNVuHYASk0oZX9iijSXXcPDTWJIv/g3yhAAhQo42xVCwwXbPIi2iXQ?=
 =?us-ascii?Q?C+oHZMHqUndWeEKB14Yk75vm2iuHYF7+0TLnPeo/yI8Scy1fPCXHHziieOk0?=
 =?us-ascii?Q?UUMGE9Z2n1KjLB80ibu1WNFsx4h9lAM+TA13TZfQLEINTpUwUkNZaqVR/UBl?=
 =?us-ascii?Q?XcsPszJMyfC35sqelIytzOXxH2Y9puSMcXih6zN/N8llWu3cSlH0vW+5z4YZ?=
 =?us-ascii?Q?PU5Rn0vRuANVryIaq8iOvlCNZ8ZIw+EeyBy4jr5Qslpydlx0dTzLhAy8Ivk4?=
 =?us-ascii?Q?ygj4WfYi7afGT0GDJrIs3uuk/c/o1wj4VAObZwNBf1gRMYJSV4Fqlj4JR5sd?=
 =?us-ascii?Q?nFfnqEUPeWPPQL8OR1tc1PWcz0ieS3PYD26OUfJ87XMNq6GJyKbYuCm43jzU?=
 =?us-ascii?Q?xp0ZRL4HtfZCXS7u51CWoJF0gz/yzgAq4lDhc6nqf7BcPZa2RXEwp48ht52Y?=
 =?us-ascii?Q?+uAUhFGi0g6T/ojW5I9S0cw0JIiGRQCs6JKxy9/cnRbbow6bN6JvvYEs9mh5?=
 =?us-ascii?Q?/wa6NmNSL+bHpROtyPa5YUBCvLV1XfxlgU4/Q5f5ufBCSzCMTFuVwtjFChh2?=
 =?us-ascii?Q?qX9KdZIWZqWaVv4VrMG3pg/pT8CPwa0TqC/I4VZjbwoglO4yiv0JK3y/flq3?=
 =?us-ascii?Q?0m6SIxtT8WNxt43+2WAI/QXQSsS8CMTRZLAyChUsLKG7K6KYK1SGYptMrkMf?=
 =?us-ascii?Q?dHKrpNpNqtHHkxoqBzYJkEiVbql+I3j6ZHn49pn+roOq/ZEARcltTO2mEw8i?=
 =?us-ascii?Q?kw9CDXV1ONeZG0bBT3eEEMx5yhsrirhvKyTcs+tsUPsILA3444OVq0CfCEYq?=
 =?us-ascii?Q?eM/ufBLCKYz2rLuldec75o8u1pHvsS5L2pS30uKridBVMykpOOjKZl/H65GG?=
 =?us-ascii?Q?RNa2KCWMpu3LONDeBuJm5XDt2XbQtz2FjGg7e0LZZhKCagNgSzhYA9SuuGWx?=
 =?us-ascii?Q?GI8dvdWpT+5KesaBIZBhVGb5hElCKW44ycUnRGW3o8DlsKvoS/Tdu7PbL7ht?=
 =?us-ascii?Q?zMRNwDFDR90GlDmFD4L8bUvoHnCCAbBx4mvPJ8RM1hDaziHEqQ83l3eeEyUP?=
 =?us-ascii?Q?zHCGoFP6NPCBgeWM45Y0GXH6LbqIBl0UxkPwmgNHgHcKcB+7N8pRmGXnx5OO?=
 =?us-ascii?Q?pWNL/omOGOE8guoItjejpgqBrT46guibg4a2A2pSkN4qjdgBucg0Ceg4xtnc?=
 =?us-ascii?Q?VLXgHt7OedTQ71qJ4uRI71hU27a0LeVc+SZBJBYhthdauexWfh/ZCm1tWhyR?=
 =?us-ascii?Q?viixrMoviYtSOVmNIDa8ZDTUUk9DeGn8bwJWUBcvhGttJZSZUXT3d6FWAYcR?=
 =?us-ascii?Q?pFpmDCOlLtRvZCLPuLGR9EN792KMlNRZcml61kBPQhsY7XCvxxZh7BLQS41I?=
 =?us-ascii?Q?xRU+cQ0cSehdPYW1kuOvOCrrHGNITr0fIEdRH/H45KbAHBZH6jgDDKkS4Bxr?=
 =?us-ascii?Q?Xo8KWWzqX/0+AEE1XzmsT6zkuQH3hvlnFp0dC2j0KRjjuRKCoppZpklGnjw7?=
 =?us-ascii?Q?4g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RE3zJL1Z/SZbpDwmTa9/mJDqK9A+u8z+xCZuMDIiEDZ0UjL7wZEBRsnArtB2kiTU2DoNYEjh8K9gZ4HzWbkKp1NjTFN29JUdc6WDiyX8bPAicu4RTaEVzsn6FtydiR/UFw5kq46LaPnMOLEoFlT6PfO1BbR5a/GrFojy7GHipZYc9C/YjpPmK6+NnGlc8jqDbBcj1lzA53cLGDAd8NXkJfIp4WGvHDrwHWPqm5ASNIiOo52rh3W8bO55828W1JZBVlBd89sbUtHVeCljnEpV/jVLxPzgsaR4GDD1pzwolmWbVuOu8dQefjtrEr+u6qSZTvM4ha3ny8Hz7jz1oUFvcmtALS4Z4nYhvySlG8luYgP6VIj7yY/S1NVQQnsJCMMmAyKV2GpSAJBUbkFLz7rCTTKdmc4hCyt1Ws3QQndBz5v/KyVO1GuJXb/4zPHlJOi7LFpPg2yngB3sFy2IZ0r/C46v8ZV8SWMOg5plxMehtz3xQPUmDfSxsH1A9Bz66K7+XLV5mwMbVucxgmCrMqeJK07YucdQqPku2BQWR5Fh4UkYvdoSAhlMtWrUv4bI61ovzDJLHY7e+n/dFCbQqrkZTTfCZFtqE1C9ngkCGPEDj94=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6169548a-e65a-49ab-2336-08dcf75abe31
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 14:13:49.0929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AFZb+3tYW06Qs0ZVmSqoH+AmmlOmyZ7vHyVqMj1MDFpqTRuWB8qPMoYlgrDOYro71FTeBLvx54raFcFViwzGrHk4PWtvuvxXtCdERCpXxUY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7598
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-28_04,2024-10-28_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 phishscore=0 malwarescore=0 mlxlogscore=853 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410280114
X-Proofpoint-GUID: jAQvTpL3l-vo0R5vLRkPJWGXZ85bPRze
X-Proofpoint-ORIG-GUID: jAQvTpL3l-vo0R5vLRkPJWGXZ85bPRze

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


