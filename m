Return-Path: <linux-arch+bounces-12946-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF22B115CF
	for <lists+linux-arch@lfdr.de>; Fri, 25 Jul 2025 03:23:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 234DD588740
	for <lists+linux-arch@lfdr.de>; Fri, 25 Jul 2025 01:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B1220408A;
	Fri, 25 Jul 2025 01:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QZW2mVr0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="M58Xp04Z"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776081F1909;
	Fri, 25 Jul 2025 01:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753406564; cv=fail; b=ASbX4v5c0ZnhiQUioH4+sJpiA9YWBgFsr7frNDh3X2wuQKtDruHfDN8vqU0cHxcAUSKpiQSeu1dV4ADM4ElCGKAUtsFOUOHNEhAesJ6RmNKEGHd7rC44Cu6QYy83WWLq3+DRAjYQLdFR7JgJxGQmNyZXtwtdlqDcQk7uePiRK6s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753406564; c=relaxed/simple;
	bh=HPVGF20diKO28NVMJINYFDCOGIef8kDTga++KEGr66Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rHlcxAVp+nqoXYm1wyPAarp+4XQCxbq5HTJ+dD/4mxW3OHk0qNlQWJNRbve2RutM+Bbrbqt5Fp3NZIvdjehIy30yiYEUBCWM1yEvklfg6uX4nw+x69gw980DHV0+3TWpWmNkiELKt9VjbWHB/E0FXJch1yAdir9rsj7cm2jLDqc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QZW2mVr0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=M58Xp04Z; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56OLmLth019865;
	Fri, 25 Jul 2025 01:21:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=c3FXw0sdNjfobu5l84oKhTYnklNdzgqHSrCKLMbpIGg=; b=
	QZW2mVr0qLg4KVebBV6NnRXH9LuueM/ZZJ/1Ap+VXouobqB3+VuJO3/x8KcGG+YI
	/glU/rYfb/uHUm01fI+MDrTmXuNNtLZm87PLtOii+uie3bHbKLw8SyWdvuB9b1yO
	sxbXVXU2fAL5w8AriqS4qNezQ6RkTTIqoh8TSs1bNmmxeCph7Vg5u+UhnGEZpSAR
	OT3IcVBOlrQlMcxDwJoMzSl0vJNwWPTqdN5arM4VKPLb6dDlLD9nRwQagaFUwIKm
	sjNZReDcrRpjN+Jttm+YDLzlxEvkOx5ztdwmliYAqwdhkFEvGz5aMjfXYwuXQN8n
	49TB7CSrwlVYiHCWNaFStw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 483w1k0646-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Jul 2025 01:21:49 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56P16IrF038445;
	Fri, 25 Jul 2025 01:21:48 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4801tcj9d7-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Jul 2025 01:21:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zVsMUz+KDTW8DBM3u/5X6NYgUaLATdQ6oLI+3Un69hDJerbkdvDmN/ozGjsvD0C7/T4l8NoIQ58qIUTCHwgWFtjWqCh44UGav0X4Pp0jil5oQ5sgBsZUyMUJqghGxTqH+6bg15YRb3jxjNOTrAfzvbs3fq91wIdl8loOwd0AID1qYzSYV7/UqKyZCv7QKXH/zUWjFlrf9hfNQE63abealGmXYUXo1dg0/W55GxaYmTXAtADbk0a0sxCbv64zZgGjN4Mw9K92gh9Q8Z51vB/QKnUEl9OfiSMLgZwtluhomtgTU0x2dDDyoUEEw17WY8NkoVitLImTX5wUK59P3qMyRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c3FXw0sdNjfobu5l84oKhTYnklNdzgqHSrCKLMbpIGg=;
 b=TYlcOP8MN//tr5V0Knucfds1EohgG0DdMhp1q1K5LRZwnLkw3X4H+QurQo2zFjEd2U5Y4y4W7I6IjhD87gonslF31IIz9SgYnGSO/pCVrmPJgbFUNcQNxRJxQtBVL1AhcopU3NPD1xm8hcZSS/SHx8lwty1KHWG+VUPAypWo+bvxeBt6KMTJLB87oX3NcGKDgL8e9/4HVQCr+8+ORyjvdkzpuA0VsDq+Mo4LyJO4FE7Ao6+xKufT5BsoUQHlXe7FzvzvRF8CS7RuObi8RAFgmsXYD12TsU+ZYSKNPCM9RCw7PEEOL9P6cXjhQdw8MM5bWYzkCgZ0hKKGxKiMBvg0Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c3FXw0sdNjfobu5l84oKhTYnklNdzgqHSrCKLMbpIGg=;
 b=M58Xp04ZZmleOTBJF/y0A5hht/Xtgm40wsvP8m3D6LBk40XqllmD1Jiq52VLT3oXu7q3nGJAqp2BIExJ5hG+kqKMHaPR3saqHaI2DZ/PcYjssluIDN/iEDjmJo3uz9/DNpewrkf8Z1YMzMKYGXxw/DIXp3Pay8k5zTbKQgijE/c=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by IA4PR10MB8351.namprd10.prod.outlook.com (2603:10b6:208:56d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.40; Fri, 25 Jul
 2025 01:21:43 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.8964.021; Fri, 25 Jul 2025
 01:21:43 +0000
From: Harry Yoo <harry.yoo@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "H . Peter Anvin" <hpa@zyccr.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@gentwo.org>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Juergen Gross <jgross@suse.de>, Kevin Brodsky <kevin.brodsky@arm.com>,
        Oscar Salvador <osalvador@suse.de>,
        Joao Martins <joao.m.martins@oracle.com>,
        Lorenzo Sccakes <lorenzo.stoakes@oracle.com>,
        Jane Chu <jane.chu@oracle.com>, Alistair Popple <apopple@nvidia.com>,
        Mike Rapoport <rppt@kernel.org>, David Hildenbrand <david@redhat.com>,
        Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Ard Biesheuvel <ardb@kernel.org>, Thomas Huth <thuth@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Ryan Roberts <ryan.roberts@arm.com>, Peter Xu <peterx@redhat.com>,
        Dev Jain <dev.jain@arm.com>, Bibo Mao <maobibo@loongson.cn>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Joerg Roedel <joro@8bytes.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, Harry Yoo <harry.yoo@oracle.com>
Subject: [PATCH v3 mm-hotfixes 5/5] x86/mm: drop unnecessary calls to sync_global_pgds() and fold into its sole user
Date: Fri, 25 Jul 2025 10:21:06 +0900
Message-ID: <20250725012106.5316-6-harry.yoo@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250725012106.5316-1-harry.yoo@oracle.com>
References: <20250725012106.5316-1-harry.yoo@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SL2P216CA0096.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:3::11) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|IA4PR10MB8351:EE_
X-MS-Office365-Filtering-Correlation-Id: fda7439a-e943-4c52-ec5d-08ddcb199d61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wgEs8NhabAup470C5HY7NZfNQUOekHNUoXV08NPRrDBGkoOpc02KgO+WVM9x?=
 =?us-ascii?Q?5/nJJCif63zP0sQRmNs1oGiSVTAoF4L8Z7vqcR9b+/emLsqXBS5x3Nia8mzn?=
 =?us-ascii?Q?yxIhDyDokKlPga7UTryIJ1v2j+mtYBV0CBhm1K+Gc3lCep+0HmXrKSYlkV0k?=
 =?us-ascii?Q?lyxz6ZGE45DQ4nl+wJLWBWweR7uC9fJQkFB93ilNYBjIzYB2DbZFiJ1oJFJv?=
 =?us-ascii?Q?w7ZLsWAO2lwciQJJGCa0nFXpijm8x8K4aNh3jMZK6LQ3sqL7WvjT7/eD2wFQ?=
 =?us-ascii?Q?Pey94mMjvi7z6UPFBFl7NUqSZKqYrGKbG5drAGCC1M31KzjyYWBqNHh0/JPn?=
 =?us-ascii?Q?Mfb3WofZg0WxLE1j7LLNfnVKg4HBeR8jbkB6Din+eMNlmCVFn0InBhtGb4ie?=
 =?us-ascii?Q?KWEcUwnZp1FFcYuzdvEFDF/DZEnMvorWemHrYP66/9cyusyqAUBvm9KndGIQ?=
 =?us-ascii?Q?ru6I6wPvyafnIHZ4QZ2I+5ewm0QJLKFlfvZ19aGgB3wuLNQZ9KxzioK10Xou?=
 =?us-ascii?Q?HNdQSGTusLp5nNseGAUR6y0AwbFXxbpeLm4BwQM071rPBUhO0kbnaSIWXw+h?=
 =?us-ascii?Q?tV1NJP6aksiPGyy6CAEQDQdPmfISlD6YRS+W+wZrzjJHvBfKbbDnyA881lRq?=
 =?us-ascii?Q?G47ooWF4nrISY34Ahb9H33/Xk1JBZrUKoYvJOzr1XH74kRJfxxNNboHXfbWH?=
 =?us-ascii?Q?5RV3FGVMm2uzO5Jv1V3+H8bgXnNE701O9SDRiKMw2h0ENbpzwtpIYnpgMWlI?=
 =?us-ascii?Q?ZnuPNH5kIPEXJGdXjBcAqGJkMG9Uj/LWIFjjVEs/dtCHharRi7nz8co3KDu3?=
 =?us-ascii?Q?wWFjZbsLnwBnoDUn9maoPVDjWyUUn7wFnYh5RdcIMTrngBhT5AmrkrRN+d9V?=
 =?us-ascii?Q?6uxGa0hSEYBWtb1LazpySMMkLJMkQ2GO+r+k01SQ12mpYWtEcFRggHWd47RD?=
 =?us-ascii?Q?YDvNwNsM+PZBvgukibpRpeVjUJFVIf2rMmcsTyPTHhVQTNGHSO+xBMI1PZGw?=
 =?us-ascii?Q?zdxsXvHO+U0Sn9AymjBFrYSE9IvSUdeTCbp8gZwAkjJHgcigcXMJ0xdXNwXX?=
 =?us-ascii?Q?0sC/M5wvrwIVnB1dajKRjmwWdFXSXjl3GdeEjCCEF2oGwUd9PbwqCgIXNSZ+?=
 =?us-ascii?Q?HHpIbXQgn0MAwMDMk07TTbFNQz31jYAWf/FZ7gjkXEXudAOWWKzOBzQxALTg?=
 =?us-ascii?Q?0VUf/sZGkqHjRwulK5Bn1G7LhoP6+EKx7jqlaqqnkVDiv4esPN0ZOvASNP6j?=
 =?us-ascii?Q?fOWjiqcDRIPI/5/1m9YLu/M27Eej8qZ16jxpKXFmVhDhm4ikBm2v3ewmissu?=
 =?us-ascii?Q?FLkB3Hy2bB32oTmT27UdsYG1pEwBk3pGaK6VB0rMvtqVCkhfg0NiP1iH/R07?=
 =?us-ascii?Q?gkmW9WJI4WI3aABs0GXg1C2jvFC/XytwNcBf6d5DdNl7wj7mDQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FL+Ci3cl0yIQvhP0Z9u61pAjqFVxkL4M3a77As9V0iwPPhw1azhS/U8dl+eZ?=
 =?us-ascii?Q?eVXhFedPqminOdMIGPzRbSg+10Kt/2Ab0vUuJw/GqZSJd6qlq091mz2nzajD?=
 =?us-ascii?Q?haINmqARBG5eneSR3mvr7Q0qQKZdtR9LgHwxVtvoProW/zKsMxpLEhyYpCqH?=
 =?us-ascii?Q?pAwKAmnd7gT4AtS5/u8EKdFpD3FQZFA/wLmIlOFet7q7y5hCBOtO2bll4+mY?=
 =?us-ascii?Q?d1xV3WdYXbiUZm0jV+rbDRseppp0/nD3SlyaWRHO22mAS6HTvlys8E8ogK6t?=
 =?us-ascii?Q?DAF29X8XMzk9ptfVK7L+HJsupTpJCvOWG60+cF1hbeeOBF7bOTwMPTvhM69g?=
 =?us-ascii?Q?a2IXQPWK+HzXthVZ4yipqmSVi5p2I+epL6KKro7m7N7Ef6CQEm82WNA92isi?=
 =?us-ascii?Q?Tth1TDCnlYjY+5dekeIbpZNeQZgzlUh5s6aHlEnGDxulF+D9grREm8iFgpP/?=
 =?us-ascii?Q?vfmynHTABI0DGwVZFYIXQ3zr0vhJxFhEXAYRqo4Do/Y2xIzpMz4qmrOeLAc+?=
 =?us-ascii?Q?3Za9MGH9ZDbd+359b9DxvMaOzvowv0ezEl666F4cXe5geBlYzTQ66s4LgLJy?=
 =?us-ascii?Q?aOYIlykhwAGHEZV/WLFQOISWdE3i1P1F5Qs7bPwjazeEbGcVF4EkOHuTTbb/?=
 =?us-ascii?Q?d4gEfTVkr7WZFKgfeLXzzSydOlMxuyjuRgE2QKSLPkVmhm1QgN89ybMcxcPJ?=
 =?us-ascii?Q?iUXmxasZqBFlUxlq8IlHgNQvd6Cwb3X6z350IUQs0KQcRQzXccC7o4DstkYM?=
 =?us-ascii?Q?TQ2d7sc06wG9+yGToopX87bsi5OVP4MWY6KGqyd8NPCfX9Ceik1VjS4GKM3r?=
 =?us-ascii?Q?X+jUrcCZauB622CLYyzwtu+SfboPVoy9NEuS1blIh+UX3xrjdeGBm9sXrkic?=
 =?us-ascii?Q?9o9wsIFsfbjQOybqCg7260zHCGlTpZtMMEv9m85ROO1h1yKR3Sq7OEbx6d/0?=
 =?us-ascii?Q?zdhZNYiU195pYhasmSDLHTPNNjnpSWYl403Fh4eJbkt/xsh4xMQQ5k4Qq5yS?=
 =?us-ascii?Q?GIvOAVSrI8n3XHO/bWhqEifxHyToJ7G9F6nuvFe/GBe5fblpU9jr4BCq2l/f?=
 =?us-ascii?Q?UpIsO/2MHytpK/4hgbQVtND/Z4AuaC530IhpfXgP756xaylr0UafsRnZhyb+?=
 =?us-ascii?Q?ZDhrmH4tfItIwvpV6ZGxCsAPR3IXOfU8AyCaKXAG5dRJ/sOo9V5lfyoFDCBG?=
 =?us-ascii?Q?fxCT+RalnuPDM3kxagnXu057K3xJphX9soEsXLQQKQYY+CdKUdlheYthSZPD?=
 =?us-ascii?Q?ffW6XUlYP4cHHeif48ZJO5LZTuuth4E6lR3SZG7CtRdyXty/XWlQFsxcmNTn?=
 =?us-ascii?Q?t52sM2a51UEOWHM5XT8LGdqLAEdMtjx+ofX983MuUOwUbauDT/xGgCq2JYIC?=
 =?us-ascii?Q?+Y0Y+XD1mTHzxhYEuOdscassiPuggSArDCx73fduBhx+TsgKHdq7Rb764oHn?=
 =?us-ascii?Q?H63uMbQgtT7so1trIER8r123SB/+078xhN+/bZLaI92wEnmLrm0PnvAtqhdk?=
 =?us-ascii?Q?/vqLrUYIDkwfbKp9HV3KdlzwkaZFPxDawUX7CYUjjYyzopNUcZx1ZTiHPgb0?=
 =?us-ascii?Q?SCJO1nQhKEmEljhGSDk1YkAsCoBkm/r9GHcex+VQ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RJGa+tpUVYcNhfwoCYsCRGijG0fjmwJ9PHzflYyG323tETpYx8c+Ofa1f6yK+uw4NZrZeIcCxzK4815cJMZG5hdHRpc9bOqFmCBf5SAC/LOPunrtwg71QIECnYwBqxLZs8lQBeuKRKMnr5gxaEdKidqO4Iyl6mmVG+iiIuzueijv8f7Wb4/qPadj9JvO3ZNF9Sg7btr18td1Ti/rFmKkaAhen5xoSEfcr9tJhbxN+8eZU1E4dKQO82EQs5lXfsdQcekMHz7s2PfMIAOTeCTePHbzqZmIgzLQktVcIuNbvUXHEFupr6GMJc+EfSBkU+hrAOB3fkq2lGJESuA9qzdHJPt3SnLMiY0jqOUWo5+kpY8LDXyl6Mt1uapKL9/GcybbWzIBVh9tG4TKG9sVTbcQnJdbapkONjUfDhYpHL/BhnEhK61V4Ug6bL2OrNLrML+QSJ5rUN3X2XLxP8j2dXL32Z13VnOp5lljlus2BBta7mmqqSHM3hyXUXzh8ljwXscVW1V6GC6K8rqEbwPXWY8lka58GsWgG4YclzSuGxy2CKzZdlGK01m0mw7gSB6XaINBGgnWC5y4x2SJx082xwwbFvD2srJRVCrfL9nVTRfVva4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fda7439a-e943-4c52-ec5d-08ddcb199d61
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 01:21:43.5346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NPl27MZinQgpkSZ4tuyJ/sWZvO0AhTG5M3aMQk/zGK1Am/fYMuYjRrLVlTnqE0EUJyhkoFzDd+m4Ejdn9EeTmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8351
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_06,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507250009
X-Proofpoint-GUID: rkpoRa01y_1Uv26A3TDikNvdXQKjMekl
X-Authority-Analysis: v=2.4 cv=LYE86ifi c=1 sm=1 tr=0 ts=6882dc2d b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=QyXUC8HyAAAA:8
 a=yPCof4ZbAAAA:8 a=dP5MOTGk7IcSfjIVwswA:9 cc=ntf awl=host:12062
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDAwOSBTYWx0ZWRfX8aSAo5EyYskV
 pLJxbAQhnDnlWnCMvcAAhELfgE6G1504oSO9AGx8dx12mSLgLHDNeh063IKoBO0KdPZOl+9gUrq
 7eC+n2/boIZjjjrol2MrsNk4nrWxHYtaciAbKRRzoJw+3GQU2QTLMvwTzX/hmjUQGrwfy8lQC1Q
 AEhRbsBKQtkt6hTugvc/2LFgBlc+1ak0haULgcukRlM79t94YMebpug/qI8+HhZkSP6x2v1/3r6
 Tpspo4snJYzVNzJRR9qCHsLGAi/SEEU9Jnud5vUzLaHVEevrOnjUwzMlSfPw9gLFZrhGS4I2SP2
 9sApON3+AlXcmbPvv4jPiLW4Zl8F9cOIY1OsUwLGHQLa8x+Kgdu3e6sT5UnF5KpM3u+2XATUigg
 Zsq4sc67a4EyQd0iW+2XsE6y5NR9GJD+lW30kwLmWJrTiWtBYd/GlKnvTg8CAyXctXXo4fIP
X-Proofpoint-ORIG-GUID: rkpoRa01y_1Uv26A3TDikNvdXQKjMekl

Now that p*d_populate_kernel{,init}() handles page table synchronization,
calling sync_global_pgds() is no longer necessary. Remove those
redundant calls.

Additionally, since arch_sync_kernel_mappings() is now the only remaining
caller of sync_global_pgds(), fold the function into its user.

Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
---
 arch/x86/mm/init_64.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index e4922b9c8403..f1507de3b7a3 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -228,7 +228,7 @@ static void sync_global_pgds_l4(unsigned long start, unsigned long end)
  * When memory was added make sure all the processes MM have
  * suitable PGD entries in the local PGD level page.
  */
-static void sync_global_pgds(unsigned long start, unsigned long end)
+void arch_sync_kernel_mappings(unsigned long start, unsigned long end)
 {
 	if (pgtable_l5_enabled())
 		sync_global_pgds_l5(start, end);
@@ -236,11 +236,6 @@ static void sync_global_pgds(unsigned long start, unsigned long end)
 		sync_global_pgds_l4(start, end);
 }
 
-void arch_sync_kernel_mappings(unsigned long start, unsigned long end)
-{
-	sync_global_pgds(start, end);
-}
-
 /*
  * NOTE: This function is marked __ref because it calls __init function
  * (alloc_bootmem_pages). It's safe to do it ONLY when after_bootmem == 0.
@@ -746,13 +741,11 @@ __kernel_physical_mapping_init(unsigned long paddr_start,
 			       unsigned long page_size_mask,
 			       pgprot_t prot, bool init)
 {
-	bool pgd_changed = false;
-	unsigned long vaddr, vaddr_start, vaddr_end, vaddr_next, paddr_last;
+	unsigned long vaddr, vaddr_end, vaddr_next, paddr_last;
 
 	paddr_last = paddr_end;
 	vaddr = (unsigned long)__va(paddr_start);
 	vaddr_end = (unsigned long)__va(paddr_end);
-	vaddr_start = vaddr;
 
 	for (; vaddr < vaddr_end; vaddr = vaddr_next) {
 		pgd_t *pgd = pgd_offset_k(vaddr);
@@ -781,12 +774,8 @@ __kernel_physical_mapping_init(unsigned long paddr_start,
 						 (pud_t *) p4d, init);
 
 		spin_unlock(&init_mm.page_table_lock);
-		pgd_changed = true;
 	}
 
-	if (pgd_changed)
-		sync_global_pgds(vaddr_start, vaddr_end - 1);
-
 	return paddr_last;
 }
 
@@ -1580,8 +1569,6 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
 		err = -ENOMEM;
 	} else
 		err = vmemmap_populate_basepages(start, end, node, NULL);
-	if (!err)
-		sync_global_pgds(start, end - 1);
 	return err;
 }
 
-- 
2.43.0


