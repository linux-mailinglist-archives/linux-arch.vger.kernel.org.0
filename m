Return-Path: <linux-arch+bounces-8303-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A609A551B
	for <lists+linux-arch@lfdr.de>; Sun, 20 Oct 2024 18:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37E001C20383
	for <lists+linux-arch@lfdr.de>; Sun, 20 Oct 2024 16:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20CF8194C85;
	Sun, 20 Oct 2024 16:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="POhPJjOR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rcT0fZ+v"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F84194A63;
	Sun, 20 Oct 2024 16:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729441273; cv=fail; b=sOV17FDeiDTSoqe9zdizLC72td9OyBpzkYKbTEif+Whi9TR/L8u9XUzm+UGL4uDKmxjY0YDpY9KAoBcp3rkiZC76I0phUXUxj9MIcQbk1c0ESc772cJ4PgzpwFVOl7BgRbzfGUIx7HkzVQ1K+BPapRgwvaOQQhj4FpWSCmAh7qU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729441273; c=relaxed/simple;
	bh=PburVRVOXhRebpXAVJyjBDphcuYWehketyfoA8fICrw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WTAiE+WGTSR1Gh4+mUQggn8vcqb0cgBlY9LrmNLGIdWdFy6Lvh8sGraeJXB5iA9v3owWXC68XjQwzLKPrs4YkU1wfcFKfE58AV/CMpPDEjUesZ3iaExIue4CWl4qW4R4wV6o5OVEgSmccqjsTlepfByet8KWMfHzCKEOzS0C78w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=POhPJjOR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rcT0fZ+v; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49KFSriv013958;
	Sun, 20 Oct 2024 16:20:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=SGHznQQIdiH2KmEGsxVR6E28i9W2PXwoIAUXAHRKpcQ=; b=
	POhPJjOReKFHsvCdgjQhWUsi5UqGuN424WBQ9X8JbC5WgyXY1ZWaIlBqLIF9pt+C
	FYQyKLYBbVKwelxMmNAha8x37iHsZQs8q0hI1FR4Rfju0SBkbClAki84zm9SPQat
	6Usk7Q9XWaG3P9r63Odi2zl2KNL59cwxewzaWlGwm1awy4sru2NfckDJcR6slX56
	Uv4ThmzcL8DXDAcy9OhWY6jq1t0QWH1C3cu/+yvlB1eEi8xp3GWyvmXFQuzmiE0g
	e+2NeuSXkSqOuGEezrgTZLY6l273ucEb4G0FgFKJa9DYqh3VbeIuA8i8eqYgM1fJ
	APkmwVSJ0uqvNaoK33B2jQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c55e9t27-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 20 Oct 2024 16:20:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49KE3Tph035552;
	Sun, 20 Oct 2024 16:20:28 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42c3768fqb-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 20 Oct 2024 16:20:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mAV3qievVqKQ42xAqnoTRQbLXxT3L1kg1xzeZ17ShgUe4Yyw6svAxm+n2ADLlzhazhhylFjT11UUhXr8ylViMqEHsx+Mz3BJfRC3QLBlgQCBY7z8KVGpW/KCIuXY1K4WpiNV4Wv3+8rS1lZZcC8SCdMbij45WNgEMGOSPGCe1cHKNqm7Wug5K80SGqyPVYIr/9L8djEcFfBCQ4ITgAZmueYkZQoz1qw4vfhbGHvNrLGq1k/3YjAxpf36R7z0wHBLNV5WMRac1C9POZizyQOY2Lj3Tixs63ZoGhaRdR8jCBdZKMspHEczec2O94sylsnMoBsdEBCmPBIx+xYodu2NbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SGHznQQIdiH2KmEGsxVR6E28i9W2PXwoIAUXAHRKpcQ=;
 b=gTgemjrE/cTlFT/wCNrlZsBRWA4GBhIZiRpCNGPBt2JWSSnQWcxzNmljgWy/k2Nr6SoTG6FY/em0ipWIroczykhhHaQeMxNhQEeQV20GnNxeC01RwoSg87j5JTLvoYOcd1jPTwzx+eL6MYzUk+83bMru0daPDQW5pHkLXl7Dlx+ZcPXKKNghGd+3WaGdN+y/Yrrbw7h3E0IfXq5e6CfrVHRecqKZ3UHTdRVjVZzb/PEaF2Qy5emGhc5NqH9u/AsyEKZ3M4Yv23VkMWy9Hp3JK3fSBjz0oICWk+kbxAUEyCcOONTTbEBcnSEoTGVkBRXDdrYUXcxeTwY7RjkqKaZNyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SGHznQQIdiH2KmEGsxVR6E28i9W2PXwoIAUXAHRKpcQ=;
 b=rcT0fZ+vurxDYZE9fxpsGyQBn/89/qaPHz+ZYa5vc6HV9usejXHrUrh0/xelDymlqm38HxJUfKlmb4SRJprjty+GYDop8dDyGDLdkgP7uyf5y4ZyLyPAiDHbPRLPqUpMhlz8psGal2/VWJwm4OXGFx5IOLzCt6zEaINb0CHwqVU=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by DS0PR10MB6703.namprd10.prod.outlook.com (2603:10b6:8:139::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.27; Sun, 20 Oct
 2024 16:20:23 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8069.024; Sun, 20 Oct 2024
 16:20:23 +0000
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
        Jeff Xu <jeffxu@chromium.org>, Christoph Hellwig <hch@infradead.org>,
        linux-api@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v2 3/5] mm: madvise: implement lightweight guard page mechanism
Date: Sun, 20 Oct 2024 17:20:03 +0100
Message-ID: <fce49bbbfe41b82161a37b022c8eb1e6c20e1d85.1729440856.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1729440856.git.lorenzo.stoakes@oracle.com>
References: <cover.1729440856.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0132.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::11) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|DS0PR10MB6703:EE_
X-MS-Office365-Filtering-Correlation-Id: 52d524f5-c627-44a1-8729-08dcf1231951
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JWanw8PVIC1IhTNx1e3z/49NutdqR8RyrETGk0hUNCZzJHzAjjJA65qG1+C0?=
 =?us-ascii?Q?9xSh/8PG4HT10MtTvadUk+u/Wi7Dv1eHMYlDchV7V0u5eL5AEgl3spIxRx/h?=
 =?us-ascii?Q?mIQMLXiayawsvCS8DYj0S1FZCahcOZ8JZznUvdU5BaetYipD0v/C4IbpTv1V?=
 =?us-ascii?Q?wGVmPUMqjuD56dpr+pxtuBmoO7bqkNFJrJLIW4ekAnk2KsteUL9gc5rM0Kix?=
 =?us-ascii?Q?aATi7IEHS8cQmwCaNFASwwEeoNrJyRMNoJMf+NYDWxDqXx49r9iQ3+pJoKhR?=
 =?us-ascii?Q?OT6MiLm0ZnQT5GuYcO32Tbvgla8BbPaFRg1JF7ArPbLhDdBI/MdPEugN3K4+?=
 =?us-ascii?Q?sE1ZIQIBenQBbedm/lzNGRdC8L37DGR9LRXsKvakJQA2eYmPNMQcXFviJA8G?=
 =?us-ascii?Q?l4p8B5pBZw5DMgBUSC5AJNZOLNvh0qYZnhO+1Y/pcJ+ZQAvsroBY/JDIGDGl?=
 =?us-ascii?Q?qkXFETXhWkZg4mWX6CQalHPZ3GKIlMB54eXhus8SOY2K2A+pzo4lU1xWZ+15?=
 =?us-ascii?Q?hUlCcLxZEpxdg9/GrvoXfWM6qWMlAKqE5rILnb2uUu7L1ilEWmuPetkoj59k?=
 =?us-ascii?Q?2BUo5EPr+OWhPsktgSCT//A/Ud7PF3PqmVKod16HdYNOVgvwrNHhIYoVmOq6?=
 =?us-ascii?Q?19tZLSHm71UT/oJ02Mnw11Y/2sSyKBZtivbdAlc8j7eK67jDfSqbQvoAPypq?=
 =?us-ascii?Q?JhrUx3S583cdteDd/gb4zconD6Lykb/w2nBOvWSexF4P9ULOWgYc1tdtsGqq?=
 =?us-ascii?Q?0Z8VfnbEg/l0YtwSrDQAri1PTTbLkTVwKSyJAqt3b2I2EFOFj7O/N9IKjPv5?=
 =?us-ascii?Q?vHfSvP8LrQPR6JPYcLAkL0wkh4qN7WOXJY92undLxUxy/hetf1XKWYxxRn1T?=
 =?us-ascii?Q?pLa51C6Exol0nZv2l7l7d3U0GhH79rrNs1NCSyM5gx8iNkp8l7d4NnhxYARb?=
 =?us-ascii?Q?qhebcz8XgjeAz87Pg+gmvWaGhNLcptFy6KiIyhnUpqEtvjXymO3mqIMQNdpk?=
 =?us-ascii?Q?CwfsaXT7gQujt/E4IoGEMqaYsY2ecnCZBeH/quCiXhY5VEQrzfy1GFxpPQAW?=
 =?us-ascii?Q?Dz8yfoZr30TYK0u8OxFG16aGLRktK6YZzXQ+C5+kwx3EBtn4WDeC2Qd0glIA?=
 =?us-ascii?Q?8xlXGLzF+CKAw+guOD85pLRyHeM3pcmA/ga4aBDSQKMtFntvYZ+aUKu51m3x?=
 =?us-ascii?Q?EyRtoVo6zGlplT1773cQkXAgq3qp6kg40CaxHmaqmxPT3ku75eCXLW1ep3JT?=
 =?us-ascii?Q?cJm+nf3MuDcHRgUuZ3CeXdkH1mVbkI7deSpHpUYuc3L4Nh3/++bbPV+bMpzx?=
 =?us-ascii?Q?tf8ELGzB/iwFjgfrQldTOVl+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?V82zzO0GRQeahhHrp9sw4AKSIVX+aLIKDrjquNAQ8Da0ZQS6xIltpMctq9rM?=
 =?us-ascii?Q?OKG3xw17xy8mvQB7c/et/hOg404NMaYo6PD9iC2tsmvvFLBx6pd4h8ohk9PV?=
 =?us-ascii?Q?8XX5IqXEXh2k/SJnjK8cyrwLe4PUj2uh1MTHI6gsNvD18n9svrLDzn8/WC19?=
 =?us-ascii?Q?SvfaNEaf+vSRpIIG7YlqpK58GFlNlmi1/eIcD5D8FTh7NpJf6veUh3RqzqOd?=
 =?us-ascii?Q?krX9I9SRGiIMYUGpDIl0jodlwwqqUw0IoMMIAIBaeSJ2Y/vUDLsysYlCy8Af?=
 =?us-ascii?Q?qG2dey7uJ+TwzztTCh5EbaBFfLBmvdsFyEwdFBsUcLYHFCYFrJ45QgJowE7e?=
 =?us-ascii?Q?g9VsreYr1heE9Ou9B4Pbxom4TH1fealOcd9q/laV0YsdLh5QcACvuHdry8xu?=
 =?us-ascii?Q?3UCz70Cx9BbSytc6T/f9g5qv0N0JhkCNVlnlR5dnGFNpT1L6xUl5cta7gJGs?=
 =?us-ascii?Q?o7u8+s409K/IENyv99vTiWzovZrfzw9IzBuiOo2coBXClnFl6QxHOTecyfxL?=
 =?us-ascii?Q?IinxqT8dxy75h2n1EeWm7rGyLLsIIGe+03xBAuI0tzxeGGCx0cDTVX1B4gui?=
 =?us-ascii?Q?ElcrKJRBy57Xq+pCYyItPJco9+cpos/RgnQiuLUObZP3k6+ZAJVjmzwBxmQm?=
 =?us-ascii?Q?/ycdU8mObf23g1EESmPU8T6G/EqMdrI3217JEIxzz1pdb5KMVeO22fWsYihf?=
 =?us-ascii?Q?ctd0eQp2Ra3DwkhtWCvu+xdEjA8+lzXvZDFxouLOcZguJ6S15fdlr4IQds+m?=
 =?us-ascii?Q?9cBKkhB2NwJsiMdQKbvTAy4uU7xGlw6K0ip+dwt5z2qIMyK8Vl1IxY2U56Q/?=
 =?us-ascii?Q?55khKO3F1RA4JDxukyQyBogrFhUwXgrJsn9pluLyg0AP+64pU1R2LvPcL8p6?=
 =?us-ascii?Q?jrYWsLfgZ8t+InjfHZHWgJkHz7MUamD1ANjnGR9fO1PnUUDCPlBvcuioBoEF?=
 =?us-ascii?Q?LgylSszX2G7iosy98I/7I8c2EMChp0b2j8kVQDrVclETziVbmGV/30qFaNr9?=
 =?us-ascii?Q?qE8I98hbg2lVXMoK7cEVDqbRTWw8eeKrNfNovdna2wY419VZ0bvWFAMfRUsh?=
 =?us-ascii?Q?4vxJVbPud7mLB3EpUUN35llsSRDjYglfRYPC1XdMQbJM2+LTNvVfFtxPt5au?=
 =?us-ascii?Q?PUySGoQACwUvFFcjoyMSdrvM177YqjJO9T1q+yJ0VK4HhfNIN9lQEmo5D+F1?=
 =?us-ascii?Q?Y/TqcjrYZXG4ZrQpvEEDXO+SAHuGRfSN9/PUAUpofSVKClaBQmNp9FvWTyCI?=
 =?us-ascii?Q?39cXtOS6UEe0h+gswkyFK47+KlptkU5owlkAUOCPOgSy8XrQ+X2nOzl6ulh+?=
 =?us-ascii?Q?3Xsir4FX2L07bPwQCA2Ndfg+KZ867rHzF3lY6IQoymtdVRyi+E8btlB4Vr24?=
 =?us-ascii?Q?a5+4YARaPjaM5R64uJohy+uXk1kW6r6TeXm9aJravredqiDHj8u0nTvZVwz/?=
 =?us-ascii?Q?Y8RCysOK+xXoUcdpgzNn8PRL+GGZvdHlXWzKd1mpwCOG9k3FacxtKzAh2Wt4?=
 =?us-ascii?Q?9HmRvSlel8XF38fIp6MzoMn8YhmQnF4b16qj0VZRc9sKEHO56EiG7xElCr4l?=
 =?us-ascii?Q?Aa1icO50ZGKvwX2tsT8PC2dM9rCQy0qHlK2vB6ZVwC+OBHyjr/W08bZsXieg?=
 =?us-ascii?Q?QROzD6dbhvhIDvNHqQ/w2ZBjR34NxinNyQAmgEbkB/YxAaF14TycTXLQqkT0?=
 =?us-ascii?Q?F5nSeQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ziVeIkapEiASmtXs66iOYlr+Itu/CJWKvvE+B1wWHzqRnVbydNMxoWT9WOeH4T/juYSkSCAjzJa3EvorYftndgtcw9pekbHGO9f203Ceu6sBqOuLaj546oN0DXf9Jxh9rTl0T4FYvIOxZJ2gyYH8EH5ZMWJjhPBhPj4eYu3NLO08rIt66y1WaxbDcnYlXNDygoyzxfdAv9bSyGMBP9GzWk7QwsHyJ0lvFUxKypDcpg2nfaDuJ4r3Xj7HWChIhioe51F2hnfC+ULthD1rITyp2yAvkFny3c0gs0Hl8vXCtUD2KGt7bna7GGtxkbMi84v52p1rTO77ypghkNOBpbDGt8sM4p7h36ZRLruizafpu2lTuIy2Xb803cJuSXaaeIU0s+GBp1uB2viiRm0Dq5AvjfOYPCnpRW+qVxrlHdG2ffoU1vfPp2f3B8r57J25EYvSFeXVqKaMgXTz79hBzeVNySWSDiEIY2V7Kbnt7qP7pWlrG09i47wVQZ4irjX7EfQvltOZ7432K9pnMZqNzsd8hFGhC4JGb6noI4DXhZAg+/qnlmCz6ko4Osq4Y21EuNRLECxBGJRoq0CFiMDfFg0zKkmCjTOY7aN2UlZWPf3OhAY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52d524f5-c627-44a1-8729-08dcf1231951
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2024 16:20:23.2000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IboqsP9PY9gaLbXX2pa8fdCoF8H9JixOemuHEaAW352jZi9OPoA4mzQWaEGVQsWVVYuMCWGTB493gLQUELbkQcx4s9/K0An3Cz4/koRwRrI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6703
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-20_14,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 adultscore=0
 mlxscore=0 spamscore=0 mlxlogscore=931 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410200114
X-Proofpoint-ORIG-GUID: _FIN8rVFT07EnmKBG9hlheBc5q9aA55x
X-Proofpoint-GUID: _FIN8rVFT07EnmKBG9hlheBc5q9aA55x

Implement a new lightweight guard page feature, that is regions of userland
virtual memory that, when accessed, cause a fatal signal to arise.

Currently users must establish PROT_NONE ranges to achieve this.

However this is very costly memory-wise - we need a VMA for each and every
one of these regions AND they become unmergeable with surrounding VMAs.

In addition repeated mmap() calls require repeated kernel context switches
and contention of the mmap lock to install these ranges, potentially also
having to unmap memory if installed over existing ranges.

The lightweight guard approach eliminates the VMA cost altogether - rather
than establishing a PROT_NONE VMA, it operates at the level of page table
entries - poisoning PTEs such that accesses to them cause a fault followed
by a SIGSGEV signal being raised.

This is achieved through the PTE marker mechanism, which a previous commit
in this series extended to permit this to be done, installed via the
generic page walking logic, also extended by a prior commit for this
purpose.

These poison ranges are established with MADV_GUARD_POISON, and if the
range in which they are installed contain any existing mappings, they will
be zapped, i.e. free the range and unmap memory (thus mimicking the
behaviour of MADV_DONTNEED in this respect).

Any existing poison entries will be left untouched. There is no nesting of
poisoned pages.

Poisoned ranges are NOT cleared by MADV_DONTNEED, as this would be rather
unexpected behaviour, but are cleared on process teardown or unmapping of
memory ranges.

Ranges can have the poison property removed by MADV_GUARD_UNPOISON -
'remedying' the poisoning. The ranges over which this is applied, should
they contain non-poison entries, will be untouched, only poison entries
will be cleared.

We permit this operation on anonymous memory only, and only VMAs which are
non-special, non-huge and not mlock()'d (if we permitted this we'd have to
drop locked pages which would be rather counterintuitive).

Suggested-by: Vlastimil Babka <vbabka@suse.cz>
Suggested-by: Jann Horn <jannh@google.com>
Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 arch/alpha/include/uapi/asm/mman.h     |   3 +
 arch/mips/include/uapi/asm/mman.h      |   3 +
 arch/parisc/include/uapi/asm/mman.h    |   3 +
 arch/xtensa/include/uapi/asm/mman.h    |   3 +
 include/uapi/asm-generic/mman-common.h |   3 +
 mm/madvise.c                           | 168 +++++++++++++++++++++++++
 mm/mprotect.c                          |   3 +-
 mm/mseal.c                             |   1 +
 8 files changed, 186 insertions(+), 1 deletion(-)

diff --git a/arch/alpha/include/uapi/asm/mman.h b/arch/alpha/include/uapi/asm/mman.h
index 763929e814e9..71e13f27742d 100644
--- a/arch/alpha/include/uapi/asm/mman.h
+++ b/arch/alpha/include/uapi/asm/mman.h
@@ -78,6 +78,9 @@
 
 #define MADV_COLLAPSE	25		/* Synchronous hugepage collapse */
 
+#define MADV_GUARD_POISON 102		/* fatal signal on access to range */
+#define MADV_GUARD_UNPOISON 103		/* revoke guard poisoning */
+
 /* compatibility flags */
 #define MAP_FILE	0
 
diff --git a/arch/mips/include/uapi/asm/mman.h b/arch/mips/include/uapi/asm/mman.h
index 9c48d9a21aa0..1a2222322f77 100644
--- a/arch/mips/include/uapi/asm/mman.h
+++ b/arch/mips/include/uapi/asm/mman.h
@@ -105,6 +105,9 @@
 
 #define MADV_COLLAPSE	25		/* Synchronous hugepage collapse */
 
+#define MADV_GUARD_POISON 102		/* fatal signal on access to range */
+#define MADV_GUARD_UNPOISON 103		/* revoke guard poisoning */
+
 /* compatibility flags */
 #define MAP_FILE	0
 
diff --git a/arch/parisc/include/uapi/asm/mman.h b/arch/parisc/include/uapi/asm/mman.h
index 68c44f99bc93..380905522397 100644
--- a/arch/parisc/include/uapi/asm/mman.h
+++ b/arch/parisc/include/uapi/asm/mman.h
@@ -75,6 +75,9 @@
 #define MADV_HWPOISON     100		/* poison a page for testing */
 #define MADV_SOFT_OFFLINE 101		/* soft offline page for testing */
 
+#define MADV_GUARD_POISON 102		/* fatal signal on access to range */
+#define MADV_GUARD_UNPOISON 103		/* revoke guard poisoning */
+
 /* compatibility flags */
 #define MAP_FILE	0
 
diff --git a/arch/xtensa/include/uapi/asm/mman.h b/arch/xtensa/include/uapi/asm/mman.h
index 1ff0c858544f..e8d5affceb28 100644
--- a/arch/xtensa/include/uapi/asm/mman.h
+++ b/arch/xtensa/include/uapi/asm/mman.h
@@ -113,6 +113,9 @@
 
 #define MADV_COLLAPSE	25		/* Synchronous hugepage collapse */
 
+#define MADV_GUARD_POISON 102		/* fatal signal on access to range */
+#define MADV_GUARD_UNPOISON 103		/* revoke guard poisoning */
+
 /* compatibility flags */
 #define MAP_FILE	0
 
diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
index 6ce1f1ceb432..5dfd3d442de4 100644
--- a/include/uapi/asm-generic/mman-common.h
+++ b/include/uapi/asm-generic/mman-common.h
@@ -79,6 +79,9 @@
 
 #define MADV_COLLAPSE	25		/* Synchronous hugepage collapse */
 
+#define MADV_GUARD_POISON 102		/* fatal signal on access to range */
+#define MADV_GUARD_UNPOISON 103		/* revoke guard poisoning */
+
 /* compatibility flags */
 #define MAP_FILE	0
 
diff --git a/mm/madvise.c b/mm/madvise.c
index e871a72a6c32..7b9a357b84d2 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -60,6 +60,8 @@ static int madvise_need_mmap_write(int behavior)
 	case MADV_POPULATE_READ:
 	case MADV_POPULATE_WRITE:
 	case MADV_COLLAPSE:
+	case MADV_GUARD_POISON:
+	case MADV_GUARD_UNPOISON:
 		return 0;
 	default:
 		/* be safe, default to 1. list exceptions explicitly */
@@ -1017,6 +1019,166 @@ static long madvise_remove(struct vm_area_struct *vma,
 	return error;
 }
 
+static bool is_valid_guard_vma(struct vm_area_struct *vma, bool allow_locked)
+{
+	vm_flags_t disallowed = VM_SPECIAL | VM_HUGETLB;
+
+	/*
+	 * A user could lock after poisoning but that's fine, as they'd not be
+	 * able to fault in. The issue arises when we try to zap existing locked
+	 * VMAs. We don't want to do that.
+	 */
+	if (!allow_locked)
+		disallowed |= VM_LOCKED;
+
+	if (!vma_is_anonymous(vma))
+		return false;
+
+	if ((vma->vm_flags & (VM_MAYWRITE | disallowed)) != VM_MAYWRITE)
+		return false;
+
+	return true;
+}
+
+static bool is_guard_pte_marker(pte_t ptent)
+{
+	return is_pte_marker(ptent) &&
+		is_guard_swp_entry(pte_to_swp_entry(ptent));
+}
+
+static int guard_poison_pud_entry(pud_t *pud, unsigned long addr, unsigned long next,
+				  struct mm_walk *walk)
+{
+	pud_t pudval = pudp_get(pud);
+
+	/* Do not split a huge pud - we do nothing with these so just ignore. */
+	if (pud_trans_huge(pudval) || pud_devmap(pudval))
+		walk->action = ACTION_CONTINUE;
+
+	return 0;
+}
+
+static int guard_poison_pmd_entry(pmd_t *pmd, unsigned long addr, unsigned long next,
+				  struct mm_walk *walk)
+{
+	pmd_t pmdval = pmdp_get(pmd);
+
+	/* Do not split a huge pmd - we do nothing with these so just ignore. */
+	if (pmd_trans_huge(pmdval) || pmd_devmap(pmdval))
+		walk->action = ACTION_CONTINUE;
+
+	return 0;
+}
+
+static int guard_poison_pte_entry(pte_t *pte, unsigned long addr,
+				  unsigned long next, struct mm_walk *walk)
+{
+	pte_t pteval = ptep_get(pte);
+
+	/*
+	 * If not a guard marker, simply abort the operation. We return a value
+	 * > 0 indicating a non-error abort.
+	 */
+	return !is_guard_pte_marker(pteval);
+}
+
+static int guard_poison_install_pte(unsigned long addr, unsigned long next,
+				    pte_t *ptep, struct mm_walk *walk)
+{
+	/* Simply install a PTE marker, this causes segfault on access. */
+	*ptep = make_pte_marker(PTE_MARKER_GUARD);
+
+	return 0;
+}
+
+static const struct mm_walk_ops guard_poison_walk_ops = {
+	.pud_entry		= guard_poison_pud_entry,
+	.pmd_entry		= guard_poison_pmd_entry,
+	.pte_entry		= guard_poison_pte_entry,
+	.install_pte		= guard_poison_install_pte,
+	.walk_lock		= PGWALK_RDLOCK,
+};
+
+static long madvise_guard_poison(struct vm_area_struct *vma,
+				 struct vm_area_struct **prev,
+				 unsigned long start, unsigned long end)
+{
+	long err;
+
+	*prev = vma;
+	if (!is_valid_guard_vma(vma, /* allow_locked = */false))
+		return -EINVAL;
+
+	/*
+	 * If we install poison markers, then the range is no longer
+	 * empty from a page table perspective and therefore it's
+	 * appropriate to have an anon_vma.
+	 *
+	 * This ensures that on fork, we copy page tables correctly.
+	 */
+	err = anon_vma_prepare(vma);
+	if (err)
+		return err;
+
+	/*
+	 * Optimistically try to install the guard poison pages first. If any
+	 * non-guard pages are encountered, give up and zap the range before
+	 * trying again.
+	 */
+	while (true) {
+		/* Returns < 0 on error, == 0 if success, > 0 if zap needed. */
+		err = walk_page_range_mm(vma->vm_mm, start, end,
+					 &guard_poison_walk_ops, NULL);
+		if (err <= 0)
+			return err;
+
+		/*
+		 * OK some of the range have non-guard pages mapped, zap
+		 * them. This leaves existing guard pages in place.
+		 */
+		zap_page_range_single(vma, start, end - start, NULL);
+
+		if (fatal_signal_pending(current))
+			return -EINTR;
+		cond_resched();
+	}
+}
+
+static int guard_unpoison_pte_entry(pte_t *pte, unsigned long addr,
+				    unsigned long next, struct mm_walk *walk)
+{
+	pte_t ptent = ptep_get(pte);
+
+	if (is_guard_pte_marker(ptent)) {
+		/* Simply clear the PTE marker. */
+		pte_clear_not_present_full(walk->mm, addr, pte, false);
+		update_mmu_cache(walk->vma, addr, pte);
+	}
+
+	return 0;
+}
+
+static const struct mm_walk_ops guard_unpoison_walk_ops = {
+	.pte_entry		= guard_unpoison_pte_entry,
+	.walk_lock		= PGWALK_RDLOCK,
+};
+
+static long madvise_guard_unpoison(struct vm_area_struct *vma,
+				   struct vm_area_struct **prev,
+				   unsigned long start, unsigned long end)
+{
+	*prev = vma;
+	/*
+	 * We're ok with unpoisoning mlock()'d ranges, as this is a
+	 * non-destructive action.
+	 */
+	if (!is_valid_guard_vma(vma, /* allow_locked = */true))
+		return -EINVAL;
+
+	return walk_page_range(vma->vm_mm, start, end,
+			       &guard_unpoison_walk_ops, NULL);
+}
+
 /*
  * Apply an madvise behavior to a region of a vma.  madvise_update_vma
  * will handle splitting a vm area into separate areas, each area with its own
@@ -1098,6 +1260,10 @@ static int madvise_vma_behavior(struct vm_area_struct *vma,
 		break;
 	case MADV_COLLAPSE:
 		return madvise_collapse(vma, prev, start, end);
+	case MADV_GUARD_POISON:
+		return madvise_guard_poison(vma, prev, start, end);
+	case MADV_GUARD_UNPOISON:
+		return madvise_guard_unpoison(vma, prev, start, end);
 	}
 
 	anon_name = anon_vma_name(vma);
@@ -1197,6 +1363,8 @@ madvise_behavior_valid(int behavior)
 	case MADV_DODUMP:
 	case MADV_WIPEONFORK:
 	case MADV_KEEPONFORK:
+	case MADV_GUARD_POISON:
+	case MADV_GUARD_UNPOISON:
 #ifdef CONFIG_MEMORY_FAILURE
 	case MADV_SOFT_OFFLINE:
 	case MADV_HWPOISON:
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 0c5d6d06107d..d0e3ebfadef8 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -236,7 +236,8 @@ static long change_pte_range(struct mmu_gather *tlb,
 			} else if (is_pte_marker_entry(entry)) {
 				/*
 				 * Ignore error swap entries unconditionally,
-				 * because any access should sigbus anyway.
+				 * because any access should sigbus/sigsegv
+				 * anyway.
 				 */
 				if (is_poisoned_swp_entry(entry))
 					continue;
diff --git a/mm/mseal.c b/mm/mseal.c
index ece977bd21e1..21bf5534bcf5 100644
--- a/mm/mseal.c
+++ b/mm/mseal.c
@@ -30,6 +30,7 @@ static bool is_madv_discard(int behavior)
 	case MADV_REMOVE:
 	case MADV_DONTFORK:
 	case MADV_WIPEONFORK:
+	case MADV_GUARD_POISON:
 		return true;
 	}
 
-- 
2.47.0


