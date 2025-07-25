Return-Path: <linux-arch+bounces-12945-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52AF2B115D0
	for <lists+linux-arch@lfdr.de>; Fri, 25 Jul 2025 03:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7662E4E3668
	for <lists+linux-arch@lfdr.de>; Fri, 25 Jul 2025 01:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145BC202C46;
	Fri, 25 Jul 2025 01:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IAKpQB+J";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="v7QyZthg"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2681EDA2A;
	Fri, 25 Jul 2025 01:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753406563; cv=fail; b=D68TcuEJ3IMSnQevvr305mixwIIGp7WA0JVapaJwgapuLSpNx1qAYBUYQEgO4TkK04h5u/KW9fIPQ1+shQ8wAnX34LiTw7KNrkZARjYZychnmBd3jotHLf4NsXGZwKebEm7wGX8Fa0+F3L0YZgtEiqQyusmks9mJ1TVbh30G05U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753406563; c=relaxed/simple;
	bh=s+TbFl34ugozVYXLRUb0IbpW5kG3IYkHfOvYvKCE8hA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=HC1l1cDhLBhLOXcr8JyDOW9/2bJgtXkG7a9UGkohTIGA00q1zCW3pbVQWaXkYYy1s9jIas5oAKshhFwWCzt9wqcG2n5Pginl1A+dxlE53LWzJ3DMkZg3upsQkKoXcd3Ei2NjMHMacuV0L7oAWP1HUGnjc6vb1co02Mg+T6aswFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IAKpQB+J; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=v7QyZthg; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56OLorxo008506;
	Fri, 25 Jul 2025 01:21:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=X30Zk8g0q0J/xkso
	ai/pa69hn8gqsG6cgk8ZVsvNT3Q=; b=IAKpQB+JEQOWneU9++hb78+vPnxzofLL
	ajaQKSg7gB8s6ua5wSu8uuKkMCXAGfGgRLI9tu/6Ycqyto6HmIXGHk9mt1ZTde5u
	vMW+YTsv4eiU+xBdwZHItlEFxdJZkxLP4X47l+y5FutodTAFnnjqWogyW7QD/xrx
	0UYx5kesME3qRtdUA+/W5xfJ+2PvIzFsRs4xMm+rGmbhNx4MMi0jW7joaEq9P1ys
	5kC2nN/qxPAIDcV31S+eA0qZ2YjzBZF1uzbPdFJusnYw9SIHOmfmwMEKVz2u36wq
	Mcc7vG/QPPSnAbHk6hb9g/F+F2q0jINwdyNLx3xXHhoa7thLrIQRIw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 483w3wg5yg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Jul 2025 01:21:29 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56ONYUgS014501;
	Fri, 25 Jul 2025 01:21:28 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2065.outbound.protection.outlook.com [40.107.236.65])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4801tjuhby-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Jul 2025 01:21:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P7s+h1LOGus+VSyDtrMbglIS9H5rBgLMg62cmYO1fPaKCICckm6RWkrf0YhzZ4hDTD/6+RXVx/7ZHK55re1mbWSrTcADoo0ZQNIbqmLx95YkLdLfi02oenBjCRJ1qEVW9vRqdt78tgDBVxgavX2eVh9inIo88WmJ/cXRJD9iI0X9skvHpLB1HmQYAZx2HAE/wanyvis4B3ehgwCKsfMqR5qsDiJKz9OKSslx9lLkbymIRAU2KnhqiVptEP0SnKxcEfFCfY4KGS1mll/wq9F10je+CrIgp+njGwU4KURS7KD//Hs+6GZj+QDORJMZfw/AjdTemApSvx1Cv6gGXfYwng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X30Zk8g0q0J/xksoai/pa69hn8gqsG6cgk8ZVsvNT3Q=;
 b=DmDdqpDq0MUJ3XXFlPxhQ31vOSRSvPQn1bDlaWh4ITxhWW3mXuqdnDsuWfRa/iOraGe4LDFY2uWIluuvRxxvekOyCBCzhJw8h/rTKTDS40DtX/OMgEwfqu3+zQ4PVdEMnxNf4r2GBqQLdWFybJKdJbljYCQz+tcuBSlp8JNGj2ElTrqdkh6tNNWp9GX+m/DKGwyiFFpiq8HgCoNDm53gxnLlLSqWi8xKpp0E+oWNeSaiqdPNzs3GvEQtORENQXZBCcsXh7m/syJ64bdWlI+V+RfBN/BwMFkuCXftntJgMWUtT2jYCMY+JamclrJZ/7NwwYIw7jT3Ta68QPTZ0wp9rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X30Zk8g0q0J/xksoai/pa69hn8gqsG6cgk8ZVsvNT3Q=;
 b=v7QyZthg0/LgJDrbPbOdJyWAkO/I4UgGYP4zhqwEae3TYcxkAP68GKicjyXc+Rn8fgy99vevtTa5UT7DDcdQq/UuDrhRTvfvKiIaBCIQaIHOp9AgUPYC+GKDi91cPvm9GdYaheS+tL/hxfCgDXyGSt5Z7WSvymKti6UeTQ3DILA=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by IA4PR10MB8351.namprd10.prod.outlook.com (2603:10b6:208:56d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.40; Fri, 25 Jul
 2025 01:21:25 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.8964.021; Fri, 25 Jul 2025
 01:21:25 +0000
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
Subject: [PATCH v3 mm-hotfixes 0/5] mm, arch: a more robust approach to sync top level kernel page tables
Date: Fri, 25 Jul 2025 10:21:01 +0900
Message-ID: <20250725012106.5316-1-harry.yoo@oracle.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SL2P216CA0077.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2::10) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|IA4PR10MB8351:EE_
X-MS-Office365-Filtering-Correlation-Id: c9a40f0d-f552-4c13-75ac-08ddcb1992a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?18rXopz5bVyFz6dkOyUTrtKEsWOPguvwBChoyfJEdOZSMcwJZ2BAjMIvhxDa?=
 =?us-ascii?Q?NX/2jqR9tXHTfBsk0KDKlNhY3YFDoITf1hlUtQZln8Ruo/O9YXvurkaLYgSc?=
 =?us-ascii?Q?NJKyGLwE4VHnTPTlyZhKoVLSQ4xrE2RUgBzV/htPDm5E1/vI5vyKyAEME4Vq?=
 =?us-ascii?Q?TQyySnbHH/MYYk+FmlPC9fMkELgIZDsogkXnL2OLUs0hQfhl8LoJhke/bXHi?=
 =?us-ascii?Q?4Pm66jfBBzLxsbMfxE8bdwN2Ri8RkaUgqhRhS6p09hsm6pSEPenVko65kKDr?=
 =?us-ascii?Q?D+/KzuaYjQ1MwOeNXGMATa36uKKn1FIFDss3HQXVRM6Yh7k07Xb122UvtuEe?=
 =?us-ascii?Q?ScxeQFanc+DxwQgPh1umS9Ghl6UIUV7GaifrPiVx6d/LFhoPdRtc4j6wNZe5?=
 =?us-ascii?Q?RP9uQ0uiRcpVmv4ubNI1pBddx/9yUSDC9gFUeUU8S6o/JxhGx1uS1udYkcc/?=
 =?us-ascii?Q?gUzKqp/DriyIarYOZV71p0Vt1IsHGKdCwwtVsqLvZxYhz3TLE0hh81piR1r5?=
 =?us-ascii?Q?/zN2juRkUmllCA7YPVrlHWKoYWvZBklWuup+QEXes2o+pXlYOhKbggRGoiB6?=
 =?us-ascii?Q?j24MwSQpUplgbArRTiOB4vdM4sgmtA8ItKQuI7DJ3f/Rhyk7Ifnkjj5WEcvi?=
 =?us-ascii?Q?op6FHrVoBv91SOtcRrm67Wn+UOzfbjtShiSxe5QduNb+hGD2qLLs0mYN4Qvz?=
 =?us-ascii?Q?2p2e6p+yYr7x/03AReEqsg0JUX4iaH6TTLfegBjksRx5quFTGsVBXU4lPMmW?=
 =?us-ascii?Q?hkL7JxxtVW60pkAXQcGk9JwcgGQF8ErmH4YhHZwi+gHp40yNiQWP5KB9Vp+l?=
 =?us-ascii?Q?BwJfmiqTHah2M3eO1JHKj5Iy4DamuxmjoBpZoYqIDkZTMO6xJ5jPxQ0zPkak?=
 =?us-ascii?Q?9obVj2VdbtnRddKXimmV8yi7L+QXJzCZW5GvT13IdOjZdh0Bjd4Bj4gjBbPB?=
 =?us-ascii?Q?NB1X03AdEqTyCq4vtnmjHiLAw++atGrLv/1HHfLRG3V+m90pnRZSNmTztNCH?=
 =?us-ascii?Q?pwe7Pg4Y8uqwvQ6Q+E0EhohqSWJy3i0++IIKRNPRvG9uS/eZy+V1FzxoiF1+?=
 =?us-ascii?Q?kyGX35g0SlJ31QBn0PqsN8d+MygjiZxjOxhQoZIkNai2WBYTz5puMRQDoT+u?=
 =?us-ascii?Q?p4jM+P1FekKvivwyyKtQ+EDGDt83big7G0UFAK59VmLk+kFaadYoAJQeVAy7?=
 =?us-ascii?Q?ZMvUr1vmNVOme8kT4spHpxmX9aAIwlhxJ/sT8kBbkcLOz9TInTeUTChgeu8W?=
 =?us-ascii?Q?x1JWGdkKRFPs4UUMU45iumuQ3LM0tF3UlXlvNoLNH1wk9bz0z0bHzN2PgRlU?=
 =?us-ascii?Q?hQH329O7Ar+mSQ/TD4fBywbIIZ0p00lFP0IUUnEe19/GQHeTngBplLqC9INk?=
 =?us-ascii?Q?gl7XoCWETmgM8FHGr6XUDhm2rwCEGTkrz/fXPuxnIyi/lobAABs25Upw/lj1?=
 =?us-ascii?Q?UeQ+rRcv7HI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bqeYQ0/xJfB+W0J0WBhoYKRxbeDDij+/g20NMzf3HmTb+6PSxzg9BXa9n3Wq?=
 =?us-ascii?Q?QP3RHWxySsxrzlY2F7vR5lqK06orMaEUPUYtVPh+OwKirU5fciK4a7Gc0KYK?=
 =?us-ascii?Q?UJWcbczvycgeM/GKyZzWrktK+MK2e+7ksnyKiGa+tV5aMbGz1GfOTUaxRk7c?=
 =?us-ascii?Q?DotPuoA/N3BNL2FoXy7mlS/WeuKSwuXHLD4qLut6+pMW4EEIHC+D6isTJC8u?=
 =?us-ascii?Q?IcOPQXWr4v+jvxR5Y30E18dJjq/u55mh5iy4DA9/8fsyauY1wITtFC8DddR8?=
 =?us-ascii?Q?bOXSWuPv+d7KGpw+zVbqGqum2e1FuQrP5P2H3pC4CBwNFD4ObNhRWCS8T7Sr?=
 =?us-ascii?Q?XULIdA3+YIy2OHpLZ2hYzxEU7jT2IQq2ZawPp26H+XRPZ9rRqaefPCZvghhR?=
 =?us-ascii?Q?mq5SYKyiRz1Jm9FvTCjOLk/5CMN7+kUeDkFzwbn45ncpvJS90OjsYJYGtHYx?=
 =?us-ascii?Q?mMeZs47IuCpIPDi22VBklxTaHERvsmVQNq+Sd/KVa/AoPHGDisx3kvjUS7tY?=
 =?us-ascii?Q?+T86tap8Hbvx7m1Hz8ggcv/YWnXQM7ziuMSCJkk9a/L5xi9ijJZ5E8M2oMec?=
 =?us-ascii?Q?j0+LmqMs+hTOAiGPYTOlK3vi191fqj7rYIZJZ2DcC84eFwsH/wtCm9JioB0s?=
 =?us-ascii?Q?KYZ529PmYuST0qTxv54h0YnrKJLj9dUsf8OuGExZCBGAQx6Vl07SSNQ7Ayt9?=
 =?us-ascii?Q?cEBx8mf6FAwXwIDVzDL/xht+9PRthLblGE5pfqaFN28uedv/SUGDs7T2GSFo?=
 =?us-ascii?Q?auzxtAD/ulKWKj6wuiGqHvYHrD2xrNau7HBu+jFxE9f2qSJtb5SFmUq0y3q1?=
 =?us-ascii?Q?XIpXHJ6gxiuGRj93C9Pbb3AnpxZXpuBufo+1yyCeOfS1b5i9PEnrKO1XGEke?=
 =?us-ascii?Q?eROVXQ+IHrGO0+EPaPahBFkeqRIChTQQYzOLC0vG4Xi5qwHsrgvqAYvp7ttW?=
 =?us-ascii?Q?VZzjhbPbhEvjxTtETZrxmqvqYFZKGNaMbRTrRuR97D3zUIPLXfaxq8RyvWD7?=
 =?us-ascii?Q?tx9vbwEIRp4M+EjZ6oMoJs6KgfS5J9diPIt5vYYIhMxPR7iWi0/POs++hHrf?=
 =?us-ascii?Q?416fpF1ooPAUP4z+A9Ry8tag1dvsX+/ijsJ/wg3uIzEC2Lx6vRTmaCA0RS1N?=
 =?us-ascii?Q?MUPOp7C9QppFaBloAR03ype6++hBIPtAPHfzadvJB5rW2oSNhZJSQwa9/B5m?=
 =?us-ascii?Q?oZanGtY9ZXV4LqfbDzCtroIQCCtskVMgxU9nCGITJLjwsCtczhQYTR/W73sy?=
 =?us-ascii?Q?t55TjqMNPJYZiR1lB9pM/vMb6BceobxlNkknM5QSLc6x4hCGXlx5O3P5jdfg?=
 =?us-ascii?Q?g9l2t499HX8DPQr2NgLxFeGU4FZpPvkfYG9hAqm22v/n6DJOjIYV6RG3eF5P?=
 =?us-ascii?Q?WME0ESOVLYhcF8UsF5WOxtGp0ErhVfrP5Sh9Chufn0b0d4vBBhi4l4IdlozF?=
 =?us-ascii?Q?cyVUT44w0J/oY0EuCZ554jB3CzV/6/CBtuJEtaKkFnJ/PVxcehaHtWtIEuLf?=
 =?us-ascii?Q?saDIYb5RzvixUQdrBtbnLAkonqEHdcszH4d3p3rJjVXqIjEAh0+aML+0SIev?=
 =?us-ascii?Q?CZ8LGrYquJe88UiWazmFyIppybgB6Jo4knlD/LhQ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GnfBjG3oJ4xbRLgsuXwgz75P69dX0/PbkV333qwUaUarg/HSQQ1nas4+/ThpnOD3yTNtB0eFFKGOkS/uZMO5S36XtI+c8gMR31yCcb+N96EFasKcDskdRqS1qCNq7mpUyUXoFZc/fvsV1vCxgnxqtLF4CDuNV0khaOitruxJKT1e84qTzv2NTdgf3Ou9bB/a8LWoJVCyxHRezu51q2AHyYP792Ri0aYlTNQb4ci5Du24QGgi1oNMG7SCxUQ4dGBP9SbyRMTcsQNkadxpFoY3+03VpFnnogLx1BaDDAMVRkvjvKawf8IRIVKy33Ye8D6xzl0nStIfey2qLGrUv3OkAdOf6X/HyLxbHHGYmdCUras14R3IGJLWnKRsHnyQ5QmlFOCGz1HqICDApTYfBQx/HOJX32xCAcxrRm0PYgMfGq8xr1+KuI/g4xN5gYrE7DW0KN7Gg1HKOxNP227yasFS65SXH/JEQ09grXnrsAG3zfbPhSs/ey58Ie80tLUUrA8Vgy86BcqZ3vRYOR5suuxXL2h/5JtvRrykqdRQU4+OdGtSXFED+nbpSwfw3N1UNXPDoTayMX53zGWtHQpqUTgGI5Me0iPXNEq0Lg30uudDW04=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9a40f0d-f552-4c13-75ac-08ddcb1992a6
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 01:21:25.4793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bSW44aViftQRAd+BgOs3PQhh3IbdfSCqubdp4Tqk0Go7O9qlCq/VmMZ7j84koCKk23lQNs25JksM31ZmTzHsog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8351
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_06,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507250009
X-Proofpoint-ORIG-GUID: pKRDfDWyFG9lO-1oUFxDCfSoXnaCahDB
X-Proofpoint-GUID: pKRDfDWyFG9lO-1oUFxDCfSoXnaCahDB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDAwOSBTYWx0ZWRfXwqasLZz/vPyq
 tRMQujIurzW0qlpL/F2Lu9H/DTMA3xnkwQ96ekTOizjvKNYKkHXdNXHxFMdDpdXiQXkoUsWIPh0
 kIBsKTsMyDwzCLoITtZ60CnUxwVG3ibDTCgaI6XmiLmzzzaLTpuB3np3zMU55ObjN1j8hzTEsB+
 r6CAynct/EDbXDS6H3xFqhPODm5WDv4AOKm8jFAKXiF+oULBXCn2YQuSPxiSS+ac3TgSpfeYcxt
 5eRQ5iFhXxirt220jy6D/yuNCuGgcgqWqL9A/IYPuBT2Vk5JFR/3iROok9CK5vAgrVOJTno9S+Q
 FVe+DT4WR4etJFCVBnipV2Bptu2/Pg96ONLYrtWYMYRXGgMGUhA1npFrPYTqIPRDanLnL0p9aF3
 bCZ9VJ1Ti5Xnsrsi4yjygf/mx/iXKNlI2W8wgbBdfpziOekJr6jD2A8rdObJFWfUFXxTuCWA
X-Authority-Analysis: v=2.4 cv=Jt7xrN4C c=1 sm=1 tr=0 ts=6882dc1a b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=QyXUC8HyAAAA:8 a=Wp_yvSgtYhLj8l1fxlgA:9 cc=ntf
 awl=host:12061

v2: https://lore.kernel.org/linux-mm/20250720234203.9126-1-harry.yoo@oracle.com/

v2 -> v3:
  - Rebased onto mm-hotfixes-unstable (e89f90f1a588 ("sprintf.h requires stdarg.h"))

  - Fixed kernel test robot reports

  - Moved arch-independent ARCH_PAGE_TABLE_SYNC_MASK and
    arch_sync_kernel_mappings() declarations to <linux/pgtable.h>.

    Moved x86-64 version of ARCH_PAGE_TABLE_SYNC_MASK
    from asm/pgalloc.h to arch/x86/include/asm/pgtable_64_types.h

    Now, any code that wants to use ARCH_PAGE_TABLE_SYNC_MASK and
    arch_sync_kernel_mappings() will include <linux/pgtable.h>.

  - Dropped Cc: stable from patch 4-5 as technically they are not fixing
    bugs.

# The problem: It is easy to miss/overlook page table synchronization

Hi all,

During our internal testing, we started observing intermittent boot
failures when the machine uses 4-level paging and has a large amount
of persistent memory:

  BUG: unable to handle page fault for address: ffffe70000000034
  #PF: supervisor write access in kernel mode
  #PF: error_code(0x0002) - not-present page
  PGD 0 P4D 0 
  Oops: 0002 [#1] SMP NOPTI
  RIP: 0010:__init_single_page+0x9/0x6d
  Call Trace:
   <TASK>
   __init_zone_device_page+0x17/0x5d
   memmap_init_zone_device+0x154/0x1bb
   pagemap_range+0x2e0/0x40f
   memremap_pages+0x10b/0x2f0
   devm_memremap_pages+0x1e/0x60
   dev_dax_probe+0xce/0x2ec [device_dax]
   dax_bus_probe+0x6d/0xc9
   [... snip ...]
   </TASK>

It turns out that the kernel panics while initializing vmemmap
(struct page array) when the vmemmap region spans two PGD entries,
because the new PGD entry is only installed in init_mm.pgd,
but not in the page tables of other tasks.

And looking at __populate_section_memmap():
  if (vmemmap_can_optimize(altmap, pgmap))                                
          // does not sync top level page tables
          r = vmemmap_populate_compound_pages(pfn, start, end, nid, pgmap);
  else                                                                    
          // sync top level page tables in x86
          r = vmemmap_populate(start, end, nid, altmap);

In the normal path, vmemmap_populate() in arch/x86/mm/init_64.c
synchronizes the top level page table (See commit 9b861528a801
("x86-64, mem: Update all PGDs for direct mapping and vmemmap mapping
changes")) so that all tasks in the system can see the new vmemmap area.

However, when vmemmap_can_optimize() returns true, the optimized path
skips synchronization of top-level page tables. This is because
vmemmap_populate_compound_pages() is implemented in core MM code, which
does not handle synchronization of the top-level page tables. Instead,
the core MM has historically relied on each architecture to perform this
synchronization manually.

We're not the first party to encounter a crash caused by not-sync'd
top level page tables: earlier this year, Gwan-gyeong Mun attempted to
address the issue [1] [2] after hitting a kernel panic when x86 code
accessed the vmemmap area before the corresponding top-level entries
were synced. At that time, the issue was believed to be triggered
only when struct page was enlarged for debugging purposes, and the patch
did not get further updates.

It turns out that current approach of relying on each arch to handle
the page table sync manually is fragile because 1) it's easy to forget
to sync the top level page table, and 2) it's also easy to overlook that
the kernel should not access the vmemmap and direct mapping areas before
the sync.

# The solution: Make page table sync more code robust 

To address this, Dave Hansen suggested [3] [4] introducing
{pgd,p4d}_populate_kernel() for updating kernel portion
of the page tables and allow each architecture to explicitly perform
synchronization when installing top-level entries. With this approach,
we no longer need to worry about missing the sync step, reducing the risk
of future regressions.

The new interface reuses existing ARCH_PAGE_TABLE_SYNC_MASK,
PGTBL_P*D_MODIFIED and arch_sync_kernel_mappings() facility used by
vmalloc and ioremap to synchronize page tables.

pgd_populate_kernel() looks like this:
  #define pgd_populate_kernel(addr, pgd, p4d)                    \
  do {                                                           \
         pgd_populate(&init_mm, pgd, p4d);                       \
         if (ARCH_PAGE_TABLE_SYNC_MASK & PGTBL_PGD_MODIFIED)     \
                 arch_sync_kernel_mappings(addr, addr);          \ 
  } while (0) 

It is worth noting that vmalloc() and apply_to_range() carefully
synchronizes page tables by calling p*d_alloc_track() and
arch_sync_kernel_mappings(), and thus they are not affected by
this patch series.

This patch series was hugely inspired by Dave Hansen's suggestion and
hence added Suggested-by: Dave Hansen.

Cc stable because lack of this series opens the door to intermittent
boot failures.

[1] https://lore.kernel.org/linux-mm/20250220064105.808339-1-gwan-gyeong.mun@intel.com
[2] https://lore.kernel.org/linux-mm/20250311114420.240341-1-gwan-gyeong.mun@intel.com
[3] https://lore.kernel.org/linux-mm/d1da214c-53d3-45ac-a8b6-51821c5416e4@intel.com
[4] https://lore.kernel.org/linux-mm/4d800744-7b88-41aa-9979-b245e8bf794b@intel.com 

Harry Yoo (5):
  mm: move page table sync declarations to linux/pgtable.h
  mm: introduce and use {pgd,p4d}_populate_kernel()
  x86/mm/64: define ARCH_PAGE_TABLE_SYNC_MASK and
    arch_sync_kernel_mappings()
  x86/mm/64: convert p*d_populate{,_init} to _kernel variants
  x86/mm: drop unnecessary calls to sync_global_pgds() and fold into its
    sole user

 arch/x86/include/asm/pgalloc.h          | 20 +++++++++++++
 arch/x86/include/asm/pgtable_64_types.h |  3 ++
 arch/x86/mm/init_64.c                   | 37 ++++++++++++++-----------
 arch/x86/mm/kasan_init_64.c             |  8 +++---
 include/asm-generic/pgalloc.h           | 16 +++++++++++
 include/linux/pgtable.h                 | 17 ++++++++++++
 include/linux/vmalloc.h                 | 16 -----------
 mm/kasan/init.c                         | 10 +++----
 mm/percpu.c                             |  4 +--
 mm/sparse-vmemmap.c                     |  4 +--
 10 files changed, 90 insertions(+), 45 deletions(-)

-- 
2.43.0


