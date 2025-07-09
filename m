Return-Path: <linux-arch+bounces-12599-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A0BAFE9E7
	for <lists+linux-arch@lfdr.de>; Wed,  9 Jul 2025 15:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3AB5188BE93
	for <lists+linux-arch@lfdr.de>; Wed,  9 Jul 2025 13:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13DFA21CC74;
	Wed,  9 Jul 2025 13:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZAkodD1+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kyvVAS7x"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A3E149C4D;
	Wed,  9 Jul 2025 13:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752067111; cv=fail; b=njgeT45itbMzAAhH7rX1+O2h7CXdpAIfadEzhTxjq6eR+kZe0CAQPId8pvZmglVrstlGS8WGLDtwLS6FgnUYA4oPPV4l1PJ5VXsBKwGx7xx8tCVpc3C2E/pPQ2DimXXbmuFwOGFQsjaBm0U9yatnaiWFbxxwgIn7+bry9nafY2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752067111; c=relaxed/simple;
	bh=AtWvIxH5NIUMF4B8Qfm7eHKCQvbPcK+w6BgyQlZ/jJo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ej7ggc4ajp5XP1n0FRqJxVSTCxAkdfHxn0Lq2mGKr50a0BmVCM+ttHof1mQaJHdAg19o1TjAiML0tWA1bm8oi8fTFMQeCsDI+oJmtEs+sm6Jt/4WdDm7HWxbpl2/MVag0bibcDUODfAWYKbxbc5iaHkmBQYywkOisWDEzQ9Y400=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZAkodD1+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kyvVAS7x; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5699jULP027207;
	Wed, 9 Jul 2025 13:17:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=wNKnvunkDqROstJL
	+8Y2ThvLCZqsrxwOV2DK9R25mAs=; b=ZAkodD1+G1emAisngU6iqUdPl+hARyFn
	5BzW6cQibTKAuziaM6ANt+dRthdF0bbEC74TFkHyoqN9kDBwmoZ1m1OdWDHdtFDK
	hty1eDg7PQGYpaaWkotyH8J4Ra6E+SpUnYU5NbEDL5HCeTWWkJOjyXn4o9QCr8xg
	XIIfzmtqhlp7xMEUmBM4Ao7GeoBFuJkNmA/KudB5j8KlhLER/bxACvphSVfaGAsO
	z3BhwctguX2Siqel3k7gdFbnbxXwv4wwVPauocX1CljcBUx5W1ufw5F/bikieXW8
	MmbSFhGynfBcL7oXgE1cqVbmshO6YFdQ7y8cJg5zz6wG7SCnMJV+Kg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47sp2rgbsq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Jul 2025 13:17:30 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 569D4Ren021505;
	Wed, 9 Jul 2025 13:17:29 GMT
Received: from cy4pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11010036.outbound.protection.outlook.com [40.93.198.36])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ptgaxtar-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Jul 2025 13:17:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S5msny2F/uYMckqN5iVphuk+b3RXc69eKi7s87tGbrF9Wz5l8LvDkNpBYSu+VVKRjh9p86hA47syiWji8NMqeypy4RnnpER+kxQ5Race4WPlNtBZWNgr9uVgO4Cmoi8xJDHgtCTyCYbaVLE9da7CZPAXX6ZwqjPx9j813nzq4opr8G686WXF/mLcsx+KxiAGbJs18q3iWvE1LPh2OAolcWKv9RcqU3Wf15p0x2aO+umglzDm3+JMJZnb6JPXnP6t51W0NrjFjOztzMAdNTs2a2uVZTznoEQ40w0dlDDyNuCZVRvEl3VOZmzJ+izIr2xWeBj5fCit+eMqTL1tUX+s0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wNKnvunkDqROstJL+8Y2ThvLCZqsrxwOV2DK9R25mAs=;
 b=cs+dOhhoFDSrsSM2X51/Op2WS3gBL7t1dhl4vNUPtuUNoLasHrjigI3wPkdWoI/2QlLSImrMNRoSy4DZTm9n8IymJhQcn7QoSPjASGwTXYbN+TQcV4binVt6vbVFFdSZw6RcIijrpxlkZqNtxwkHP3vW0T/yD6kwKeQzQrveXhjfNQt85w8athsHyv4gYPlNzDcM1bQ1kBo5VtiQpoTl6nByj9i4fTvSrAIFEN1+oLuM/gGwfwMYY+xuN3gvoRxLHoL2n2IlYYmEu0aBbGtcblE1d920dvl9Nwp1Lr2Rm4WhGRe92eEkpRap1ESKuS2KD78ulYi/RwuCESkiux7uuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wNKnvunkDqROstJL+8Y2ThvLCZqsrxwOV2DK9R25mAs=;
 b=kyvVAS7xtwfFSz+RNtQWqZtFrq3/gq1KB2jlRwVEkJ4WzTd1Hq2wg5jFpSNU+Zf9ulbkLZu9c9FZU6Uxj7F5nMQ887MWEtLiI5TRuRYNiQ+Gy1GwQp6xGlz4BRya5XZT509aXnZ7iC+GsTQcxddU/H+M/p2H2t6bagqbP/W7ihU=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by BLAPR10MB4914.namprd10.prod.outlook.com (2603:10b6:208:30d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.21; Wed, 9 Jul
 2025 13:17:24 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%4]) with mapi id 15.20.8901.028; Wed, 9 Jul 2025
 13:17:24 +0000
From: Harry Yoo <harry.yoo@oracle.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@gentwo.org>
Cc: "H . Peter Anvin" <hpa@zytor.com>, Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Juergen Gross <jgross@suse.com>, Kevin Brodsky <kevin.brodsky@arm.com>,
        Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>,
        Joao Martins <joao.m.martins@oracle.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Jane Chu <jane.chu@oracle.com>, Alistair Popple <apopple@nvidia.com>,
        Mike Rapoport <rppt@kernel.org>,
        Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, Harry Yoo <harry.yoo@oracle.com>
Subject: [RFC V1 PATCH mm-hotfixes 0/3] mm, arch: A more robust approach to sync top level kernel page tables
Date: Wed,  9 Jul 2025 22:16:54 +0900
Message-ID: <20250709131657.5660-1-harry.yoo@oracle.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SEWP216CA0055.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2bd::6) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|BLAPR10MB4914:EE_
X-MS-Office365-Filtering-Correlation-Id: 5991f853-b6b5-45a3-e5ed-08ddbeeaf1a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cGoF9gj+rRflM5bLK2qiNCGd1FmQPJ9M9gtI48ShZ59+7TcZVkVFbWJ9cw2j?=
 =?us-ascii?Q?UJ3qX+AWMaTnzP41A2p01Ivdntz+knir1gyxzCWE7ga/E0P6MBgUa8KlL0Rv?=
 =?us-ascii?Q?IOhLJittW/rx+w4e5yjsv/hyaT6FfTNMhl+7NZWBvxHKjisiH+SKAUbnVye5?=
 =?us-ascii?Q?Mz1xCacv6qDGuaiq8gzvsIQBtS2fJvKli2fEcPyqQzEByjx1o8sCFh7FPdH9?=
 =?us-ascii?Q?eGkLQfwfIuPDB/7T25BDFKsWhuyRw3yC5aeS7Xnleos10HRv6m6VZDSqoZnd?=
 =?us-ascii?Q?PutMuLYETJphcIYYGfbYhR98yKT/0/RT++8E9ilobKoSWbqanca7VGSpbh3C?=
 =?us-ascii?Q?9KWYjImwYQNtMSLD+B2o2fD76Bb2/c5eHq2a2FOr3z+62pHPVVegogCyif5u?=
 =?us-ascii?Q?Mhq5UpKW5M8J+26dk8v5rtsAoutmSeZNTKaSbZdQC5r+/wTbdbov083qwW7b?=
 =?us-ascii?Q?kB+/FUAAqO400eeYf9ESEpX2UXQ9LixfV2lZg64WmpLx+BYim0Ys/1+L9HuM?=
 =?us-ascii?Q?JP8k5sZ/dDhh+051fAOVUZ4J574SSyxU766afB1RaJVq8p7UFZDkFbJzxZdN?=
 =?us-ascii?Q?57pf67qmQBUXg0s+Sb3UafKKqekGpcacbWvwAE1i6bqviWvqvtp2p7oBEFg5?=
 =?us-ascii?Q?Lb6B7I+whi42TMbcnE9gyWRNgcG5I23RbE3B7F3/fCTHkNd8P6N/KzIRhBzB?=
 =?us-ascii?Q?7UkUSvMYJU9ivhnZy72NLcabkHIMP/7n4ijvwXZ6Th67PWpx4fImQgFU1saM?=
 =?us-ascii?Q?+U4YCoW7e+/ORodR1c2f0v8GmSMuTI0/xNxoIR2RI8owx0JGflEUt/8LmVPf?=
 =?us-ascii?Q?eAKCLxrXG3o0j4XJAoZovgKgWpzP/AS/7LR6Q3VedF/kumkubjd3iZYTJ6R3?=
 =?us-ascii?Q?zjFlImwoD7JkoKhmfXob+Q6RJL5253pSh/iaXd6Qm8KEUzOtZuO3K5rkKBVa?=
 =?us-ascii?Q?DSyli7UPpSggJOHYCySWQeTJInhJa1UQIW1SiN+Lnu73AS/+OZBhtj9F03+m?=
 =?us-ascii?Q?umKObt+sxjwv4dbG8+23Lff6YVk4CVaSRGDKloJihpLW7DjzKKeHZTCld6Q5?=
 =?us-ascii?Q?IaweL/s83MZmtu5uwfSJmBPogw7e2g9Dna8TXPYeHisg0wNxP94v7nhBfk7n?=
 =?us-ascii?Q?gcoNbgUBVhauZGPtnG/4NJLfvzBdGML4AgSAhkwn38+Amd+5aLdiiD3Oy18T?=
 =?us-ascii?Q?nLYoVyKScD2BHgLqXBlm6nCKAL28Y7iSTSjjClEoJA967HkSHVnHCsx/Nz76?=
 =?us-ascii?Q?YejapbNx91KpP5JHL0wSu19RkXx8sTzL8C/+BLZlt9RDoZFjoFfdBoZJhmli?=
 =?us-ascii?Q?PDYoi9BkUJQFfGWaMZr9OmDlPKrTetyzJ+ajDnmrZ0YYU0N/uruIeB8LaCAy?=
 =?us-ascii?Q?r29q5ghGh6g6fb4CPoIYH4ROyLGswDAmyzdxPsF37pLNnzpU++5NfLRxwTNv?=
 =?us-ascii?Q?3of2Ri6ORuQ3T+mZc6PBRV+vmQTOpnemiXxNmcAPp1zQzIbqw+FvuTAOzFpg?=
 =?us-ascii?Q?NI+g6Ki4AlC2hZw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KaicH7y2xC+//GLVEZH8grOvsqCNSPHaksSLBaGaw7Iuff0x0I5w0slL5ydb?=
 =?us-ascii?Q?UmcT6sD6VmvmJOLcnHRxEb2oGSnyEfpFT2IRj2nlZtUD0FTd9pnS2be/6kvj?=
 =?us-ascii?Q?rKXUe9v9GuKTPmjJ/qCrDspedFTNrjdPzL6+S2WMvkRTYSZCV1TVdFbfs0Io?=
 =?us-ascii?Q?8GFykXovI4FQait1V0nYfGQ4z6Lym/iASpDBlHY7LoNXQ/XQ/HgK5l5hiuPs?=
 =?us-ascii?Q?7qBYtkscNH+GelwxMZNTycOcUbnO58uhrXOwoSk6C5dpAa4b1szDMoQLNMui?=
 =?us-ascii?Q?QLO5997ixNytC/zzvUHb52PanKw5QpOYM6Lbfu+I2+v7tSR0Gh789EPaI3Ov?=
 =?us-ascii?Q?Yp7wtgIMTgSOJSbe5qrL2oHl35Zle5Ja4Pqed2avi0TymTsRf5BxrZBQShmS?=
 =?us-ascii?Q?Ax9TS6k+hRt06VK7kGFIljWEI5TE7I7KNhzJa7YChmsJFa0G9itGX6Cmvl04?=
 =?us-ascii?Q?42w4RR0DKAP6tr2c/DTrDgyiqEGzLHeI7P5SOwcLXinHYeRj47l96C/kgwJa?=
 =?us-ascii?Q?hcCYd40M9UR47wnn7GzTf4kWpZ9nmcpotTRajxhaTMD/o5dzInI4dlKPwT3T?=
 =?us-ascii?Q?J7nGEQt7tDCsHZRksj/PjX37H/7xtUEg8fUkgTbDvFsvMLUzosGl9U/yR8T3?=
 =?us-ascii?Q?uXG05DFu2G3Ib2OFPmA9rXPbBJmJ0qnMSaJcUqgmlxpOJ6c0y0H1t+JSd/sZ?=
 =?us-ascii?Q?6uz2cIP6PamtuoE4oTMXlWEjlPx7ux8PyH4wWsBX4hAGZreEMsy33haTg6Ey?=
 =?us-ascii?Q?zUBa/v+UsUEVvUepBp74SHQU7DFgLevqJ+2q9Hn0+zV1vyU3TIuoLb44rHrF?=
 =?us-ascii?Q?V4UBEy47zDLWE+T6/JEcxnYElayEsr1KIcNbvoI1xKPAaU8oGudeJZNtPbd+?=
 =?us-ascii?Q?zTeACFr7c867R79mpKVJxkOpPP6AKYFHvU9ZadbzumaEsKPQYvvBy3T4N0MH?=
 =?us-ascii?Q?xGN+2K1HijhNpGpUxRAziuBPAgxtbZiQOU11lH7nJ3pYkXiYnelLlKwZgXCB?=
 =?us-ascii?Q?x8bqXjDfIAyIz06QiMWP224DVvVVmA4jvCw/+7pz197u70UyklX45E3/ReOz?=
 =?us-ascii?Q?9gU3CjrJSzhRHfrZPrU3co35V3V7lyyCw68E0xSoIySBBxOUcq0zlyOL+Ni2?=
 =?us-ascii?Q?+MI3ty7/CNSHGPWCxNrUb0J6qfnys1ssOLKSVOYBvBgpxvmQohtF8KdSrE3X?=
 =?us-ascii?Q?wntrJls/o2hER8viQp2volSCRUyCKNYddzLcFfDYtfGqowzJWcZwGLKCNcTS?=
 =?us-ascii?Q?tBhCFNji5pw3RvMZtQfUZHPYJBzfBqFmU2lBQyH0tk5NfTwmD+R5OYLE30Nv?=
 =?us-ascii?Q?/c4EB06Wok+uBhC12JHd+b6Yie7SlaUaq6po4F4Pvctd2Rv8OI+gW3/BT6IX?=
 =?us-ascii?Q?FT/7BPn45Qkqqh7sui04oIzP95b9mTUJXQ6M+7IRiq/aFAHtPGWq+cospf0A?=
 =?us-ascii?Q?WIsVSilW8vGDeMcXLA+mFhFXalZG5yBw6VkeDIheviKpXZCLVtvLRWLesbF2?=
 =?us-ascii?Q?NbWx5hMWtemJYQukrg09O0AwR5iZCaqI2/Jjihe3F0tWKl8s5mFWXeqiQV9J?=
 =?us-ascii?Q?yugR/Vxu5GzeubDmTDxzR600O6u36vT4lLU3Peu+?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	l4U4AmKeRqyMqdJ4vtgV9RWTaon6E23OTW+/LI6yhKTtDtn3ZRsgmSxUK1Lqm+FrAZcCUhhKs5VvEmIkW4mQDQ73xJCSwO/9/fLghHk0IRSiruMvMSCTbpznTkAOW9c3Ks5FGDSJJMuM2S0cRjQylzBIr9P6kr+6Pq4416wstemQY74CjkIsI0SJ6w0KGHbsHww+oSQB4cgWhauPgWPCoz9m15beFZN/9d+qVmv2XziajL1NbiS8IkDUMQksvGnE3rSSGqB3UPfi9N9mhSS08FS0n/KT6FU4zBTe67Iwwegt1fPL7qsinnwAgkkrHzqEA95oqzoexBWq3cV7jIMXZItiwmiQPFXGZHcuVnjvH6c+oXsd1efJQkoPr/apwUF8lIrvPn4cZ9AbUU1BJfDizwugaXH6tAJRY956H0UnHnmDIX3/wXSaaqgFC9zWaqYl2Q5UyHwCJGMEvgbrRRasESqDl9D9xs2+J9FjO7+liiWsRNOnJt5REbD7WEXn2iI1515ujm+6GTGIzS25FddTTfzBeEdOuLjU+YPWRKTwoAOz1XXSpQLIZ2lDDSeg7iOJc2wqBW5/+VufoO9HFD1iddm070XneQ9bwgHXQ2Gf/s8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5991f853-b6b5-45a3-e5ed-08ddbeeaf1a9
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 13:17:24.4603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UuzuIZxmwKB/Zzx7Iq6c+3nlGY9thu8GC50Vxsty/L9QQCDf8XX1YYepkAprJjwP7APuGgJx4DoUNpRLGdrGxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4914
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_02,2025-07-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507090119
X-Authority-Analysis: v=2.4 cv=e4EGSbp/ c=1 sm=1 tr=0 ts=686e6bea cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=XaHTuPSUgyWGxnsc4b8A:9
X-Proofpoint-GUID: Tvv6auSB7fXBD1BKlplbeAli7wXgsQgP
X-Proofpoint-ORIG-GUID: Tvv6auSB7fXBD1BKlplbeAli7wXgsQgP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDExOSBTYWx0ZWRfX1qGFpmeKRLtj QDTFXlWUu1KA9cqZTHW1gSM+EbEnHFxaR1mTUVWnudYSfnyeHBZUiyHYPwfBeqeSIMYD4n5Dv+R RZAH/jsMkXeQzB5hgmt38ZecwNVryD5jsrNAZP6YePnySklKEl1xwBDNsa4skHfvtH69L5pk+FT
 3Le0HGmWcQxQ8JpATSOkIORGMgqCQkPgpKXqorbqtpJfieJ4VqtsorR7tvcbG72Y+fKZgdMvzjY dJsvLah5vWAnVfwwK3tv3YzOmzW9kwDAMhMkUgFTO0gOK3zgSUlyxcZVYTJ2jr8zKp4U6SjOV9w z8dKlFjSM8TE9PFD+3IwWF1C9OSDIxzAdmzynb9jm7XVRw1dwOxsVCRYt4A9+8AsZzUfi6d3m0U
 XfJBuu5L7+GhhsM0e1+wcDECVXfJddENMx/X+7GmAZRPkrDsgGahjyYAkc5PN6MPz5g4mALy

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
the kernel should not access vmemmap / direct mapping area before the sync.

To address this, Dave Hansen suggested [3] [4] introducing
{pgd,p4d}_populate_kernel() for updating kernel portion
of the page tables and allow each architecture to explicitly perform
synchronization when installing top-level entries. With this approach,
we no longer need to worry about missing the sync step, reducing the risk
of future regressions.
 
This patch series implements Dave Hansen's suggestion and hence added
Suggested-by: Dave Hansen.

This is an RFC primarily because this involves non-trivial change and
I would like to fix it in a way that aligns with community consensus.

Cc stable because lack of this series opens the door to intermittent
boot failures.

[1] https://lore.kernel.org/linux-mm/20250220064105.808339-1-gwan-gyeong.mun@intel.com
[2] https://lore.kernel.org/linux-mm/20250311114420.240341-1-gwan-gyeong.mun@intel.com
[3] https://lore.kernel.org/linux-mm/d1da214c-53d3-45ac-a8b6-51821c5416e4@intel.com
[4] https://lore.kernel.org/linux-mm/4d800744-7b88-41aa-9979-b245e8bf794b@intel.com 

Harry Yoo (3):
  mm: introduce and use {pgd,p4d}_populate_kernel()
  x86/mm: define p*d_populate_kernel() and top level page table sync
  x86/mm: convert {pgd,p4d}_populate{,_init} to _kernel variant

 arch/x86/include/asm/pgalloc.h |  41 +++++++++
 arch/x86/mm/init_64.c          | 147 ++++++++++++++++-----------------
 arch/x86/mm/kasan_init_64.c    |   8 +-
 include/asm-generic/pgalloc.h  |   4 +
 include/linux/pgalloc.h        |   0
 mm/kasan/init.c                |  10 +--
 mm/percpu.c                    |   4 +-
 mm/sparse-vmemmap.c            |   4 +-
 8 files changed, 130 insertions(+), 88 deletions(-)
 create mode 100644 include/linux/pgalloc.h

-- 
2.43.0


