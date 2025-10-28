Return-Path: <linux-arch+bounces-14368-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 65FD4C12F37
	for <lists+linux-arch@lfdr.de>; Tue, 28 Oct 2025 06:33:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 22C574FB073
	for <lists+linux-arch@lfdr.de>; Tue, 28 Oct 2025 05:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72192C032E;
	Tue, 28 Oct 2025 05:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qpl5tzAR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hUtPs4Qv"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B2F29D268;
	Tue, 28 Oct 2025 05:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761629544; cv=fail; b=qIy1sKz8E3Vq7Z8ORjxbeUN/JMWPcjK392Y2LaXKDtF1P3nUQIefMuL2g58hY7AIunRzr+Dwhpd229wG/Vc/GVN1XyWCMAkEZQPJsHuJBpTgoBxyQ4xPfESoORaYViNNEKJE+tXbfUxFDra5nMM0RoNbknQI8ocQHTwctrDFQpM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761629544; c=relaxed/simple;
	bh=cJ7UMYqgoOJ6NkQ+fy4obUyhJgGQ6nC1WqLO7TA2M9M=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=lrjBSblUZ1PHAS+Q3efU2QMg27izHLnMwbo0gfwQFe7jcbpg/3p08bVKB04ed8QWsOymOQk+X0T1piyEhGdDFTKFHf0hSWVFV6U8nI2u/j9skWJ7d0WFvc00P9F5F6S4M71O7BkJCZKsfK2RYg20ernjN9awBH1X9tYQ38frwJc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=qpl5tzAR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hUtPs4Qv; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59S5Nhxn028399;
	Tue, 28 Oct 2025 05:31:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=YYMZGIgVqGM3Ia7k
	DrKLFPbsPVGWf5wrKmd77I1h8hg=; b=qpl5tzARuXAlLAGnLU4JMZANP11OkeXV
	j0wqw67Mpi5zOIt1p8GM4BZhr0HH790L3JNfk0vQxgWyrBI69R5XlmCebeZF0Wrm
	5MimQTkPkB6xaU2AMT5WJdjgFX6gvoAxSQ2pV1+A8FDCJz7I6ZrkFrwpBRs5kaKI
	KZTeuf+CUdDVfEjXmvOT3AA8PcbtPL69fUG/F3n6wjG+gq/jI2ghnVt43M4OqoJ5
	NYTEtmq5zSdWF2vRap5UyRBsjnKdat3mjYurMhcB3L9WlFUQZ7WtQPl6RPXrMxFa
	Dwbhv4X5JWFSh2q/JxgRR7Ad5KYl4sapKGbHwN0gYFBcCf1W6dCuNw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a23gvjj9n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Oct 2025 05:31:45 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59S2iEDm034916;
	Tue, 28 Oct 2025 05:31:44 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012003.outbound.protection.outlook.com [52.101.43.3])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a19pf3qn1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Oct 2025 05:31:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jGIq1ggkZjFfv2cSRDQCEzhDUZD+lHFvwDGot6w+sU2QeqbxT/iDpZ9ddROYuDXU7kIUVe7Q+KAngOxW1jqDV3Htla/DonESIKahiLfxQFqT0L1Ay5qOze+cBi50EekFFY3QT9wTcqaTbbY3JDmLj1HORHOsKtDrFaezs2cbbImKhkz/wgMUwR+8GUVURuBYqkUBbqLTJZ5hViq7Q38w197gCWTyqNv69X1q/WaMWJIja6jUHhE2NSSoFjktXnggIE6xFZAhLqR6W+ol1gLqlM04JLyCjmwBZN4vUcE7CaoL1kun/C2IGCPvS9u+23D5b6JUH6sxkd/AHds4w3MukA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YYMZGIgVqGM3Ia7kDrKLFPbsPVGWf5wrKmd77I1h8hg=;
 b=mNt3QwSgjWQWQkXId6IWPvsldRAzBZ6jt6MOdMooXjVwahhIZpL9kUpRZ6xx+b3kBvDiAm0hGD5glFzH1C4xp0/tBifVRfCZE8l5XCdQ0CsbEGdl85vX5SIgia8y6j3166S1xVuNJAWZbt2Es8siLoaU+mQ7hnUrNkNgs9JMLysgG8ljrFiccAWcL54+AK3ZSKNGCOec+YGbcuDfRuJ/8rnJJgQxYe6snqwD4Rbp621GiFoBrrvFiFfSwJ6NxBfxhv7TPKQyJ5hLquRNOFa+lWVqLlTkBEckduoKnu14HxoyyhJyr/CAd+GA9SzxW1jaoCPcopgD90kaJPSoy2Le1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YYMZGIgVqGM3Ia7kDrKLFPbsPVGWf5wrKmd77I1h8hg=;
 b=hUtPs4Qv5OYko9YTe9GeRSgLKNUmJ5Bnj/Jpn2o7T09Wp6TrTr6uB0PK1LcAl0j8JgN927uY9fz+shGMRmXNW1SZb6eVDJyudqMwE+xRbsSy0rK/sLryfgL0mpIKqWpn/uUjaVL4t4JgOgF1IHbSS1rwXnNK3WFy7GI2C7cxku8=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DS0PR10MB7152.namprd10.prod.outlook.com (2603:10b6:8:f1::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.18; Tue, 28 Oct 2025 05:31:39 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9275.011; Tue, 28 Oct 2025
 05:31:38 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        bpf@vger.kernel.org
Cc: arnd@arndb.de, catalin.marinas@arm.com, will@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org, mark.rutland@arm.com,
        harisokn@amazon.com, cl@gentwo.org, ast@kernel.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, memxor@gmail.com, zhenglifeng1@huawei.com,
        xueshuai@linux.alibaba.com, joao.m.martins@oracle.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: [RESEND PATCH v7 0/7] barrier: Add smp_cond_load_*_timeout()
Date: Mon, 27 Oct 2025 22:31:29 -0700
Message-Id: <20251028053136.692462-1-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0355.namprd03.prod.outlook.com
 (2603:10b6:303:dc::30) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DS0PR10MB7152:EE_
X-MS-Office365-Filtering-Correlation-Id: 451a2172-364a-48bc-992b-08de15e3445e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?84s+6qQpvAYZ4uVjw4K/tSIIrAfOh3BopiJ8v0BqcBEqGW+BaeTa+9Vi1DBe?=
 =?us-ascii?Q?xzb4J3UmeQS5l3/AfcVaRffuSRkMdP5CJ9e/A2DiJ/WyLL1qXJjw9re/oahs?=
 =?us-ascii?Q?kpUFDZL95h/SfrWNxDOueKOMSvesILwJtQh8rH2u2quv6TBlK0zYcZkoqO1i?=
 =?us-ascii?Q?lj0K8OXPD2NjhWCLxn0bgUxrIvpZ1SNYLd2zuRhnaaGxkR3tWDcdf3ZDvpqR?=
 =?us-ascii?Q?HYpyOxEDqdspmLk1kwi/wRs3dLSO/BbtHgETk4NqTXZd8s8TbRlL44eOXFDb?=
 =?us-ascii?Q?QaTi14HZTNm2c+7QYhkhpqDSK3yoVDKPkpzrhXNEMKdJtyBLEQYhyQE29jTe?=
 =?us-ascii?Q?1RF3o/m2c2u/OsmVN/NC08JcUCLlJvsQrXRORa3dswcWGU02PSRwQv2FOtrr?=
 =?us-ascii?Q?WCHlrWQRWcAkgKY9aJa0v03OcGmUy4c/tHrunOWJnnM42U9tOZ9t7mhcq0L/?=
 =?us-ascii?Q?r6VwCRAt7UtRTqZ7n52C7sV8gtC8OSbSWyQ9hpX+asov9rr1Vody04GhI8In?=
 =?us-ascii?Q?U7A/l3Fp1n2NAXT342bBBhdaM+AJTNL2qQsix/y4a5z8L8ShACU+r38esncK?=
 =?us-ascii?Q?bcRWKuUCkJ5fQ6Ugqvs3r7pQvCwDonkR8OSU2Dk/phAEqPWcRwssji/4Gfka?=
 =?us-ascii?Q?vjE+x9mHd7FVPcRvz/dNFg7WOf6FF5fKAvQN7t46FY1oZ7UJvma/JM38Txct?=
 =?us-ascii?Q?ohTVLzluD7vXZzOXDBSOtyImLJi1EzJX7tvW8CXCW+TkYNz0j5jHOh6bZ+Ev?=
 =?us-ascii?Q?Z9zTVwcx1WmT1wce8539qgRbbCTO1iqTGZfg7EMQM0LQLNAsFjMCSgNWbcLr?=
 =?us-ascii?Q?Z7uHAs+VHpxl80qCh3uwBy7s7SMwgy7blf6qTm17iO+nDhE+lNg2SAJs1iZi?=
 =?us-ascii?Q?Z9MPi/jn6p4Npk5eBdbOIf9GSSO7OE2MQS+l1MwkIwVSoqwa96xPO5vlpnZj?=
 =?us-ascii?Q?zl5vVK+ziYcrpaZ4Jy2U7WBKKX4gz5sRXZ5Y6xFtx++SRubfl100oFzuAQ/e?=
 =?us-ascii?Q?kyI6aWTOpvAfIqt5Xplh37nnsOf0WVfvhRiAd8u+2QpIYeIea/tVq10PuO5C?=
 =?us-ascii?Q?CRJXkzZVtzyK4pgSiVSgvYHTM+Lngkj5VMutWfnwtCgtsDqBJzbhPcx01l9b?=
 =?us-ascii?Q?ByeSc3FB6uFfZfg96pYGGxV2rna3toNegQM1mKjGzP19lyrNEtE4oLd/5/cM?=
 =?us-ascii?Q?7XcN7c8gD2E7XXfVGTo7VpWgBxR0h++knIMzBz8s9ZJp4vflH9iO/w+KCTXD?=
 =?us-ascii?Q?W8BLJ36IsjYLgXexA+mVlSJ9sLj6HMRO1aZ1RtFgLG1EiSEtTRz9VFbaW+z/?=
 =?us-ascii?Q?OP6nPNnacCf2htvNIsj5tBPsXqZiqtx6ouutbycbMfbY76jg9yx7blSRixkj?=
 =?us-ascii?Q?dwpcQfWOKKRpe5atATOZLRzvSlwmGbJ9GsbWLiyD99DZHvmwQ9RUHfqM3HFv?=
 =?us-ascii?Q?1cAbnbr3/EU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MRC0+nhd89/xP8fX5a/7K/V80g1wB6G8M71AgKHEiI/ti+Pn4ikgtrQ+pt4l?=
 =?us-ascii?Q?0pr/0Ed5NTqxw4s0qJ1VFCzZITuilE/ng3pzGeUYBYKDHcVeKLata2fVIcGr?=
 =?us-ascii?Q?bqG3yT9rlnw2s8bp2K7stmllFuykvdb0WvciJUUuKUff+p5HLyR0B07OWOUR?=
 =?us-ascii?Q?4uYI7GWTyVCSF9Lh2avaqGLuNs5xmhcMykHs9J84f7Z2WPUZIVvOctxEWFFP?=
 =?us-ascii?Q?v5kT3LXSXfz4bZIa4f+JYQXMDUeZk/l6NfFp+5MEPwzvwoFpAK2poLYDXS6t?=
 =?us-ascii?Q?6eLsxeR7Hv1gwzVGxl9szhOBELh5kODKo7+lRbRmBG1AGVYSqK8eSShV9tY/?=
 =?us-ascii?Q?sszVHhBVKJIgYsaOapHmPeZUMsTaTEFKrhkL16knlWB6WLhGBJAP4Fj8XgEa?=
 =?us-ascii?Q?Mxxy/Kj/94+F96HsgsYTdlzdZPreM3ns7btKNWBCJy5WWPCdPaKOvhYASc4H?=
 =?us-ascii?Q?18mriaF1jXphOhkkgYcwQXFC4gz4lUxPsURT5piXrPM/lxteivRw1JAzFKVK?=
 =?us-ascii?Q?kR7JohYcGBgdqVrQvowYPLUHelzUaebiMk29b7ZZ/Kf5LfgU7+m/Nv4JNc/9?=
 =?us-ascii?Q?lW9H7SkFnumNB2khiazYNr22O9i+JcBkldyw91fUxf6IA47Y8eKKfGM0n/JZ?=
 =?us-ascii?Q?2COWk80e0PAMRtE2oIWoXhTnRvi0WIxksLrXvwLK44aHTSkZuegPzKFCxNK+?=
 =?us-ascii?Q?409urk+HNchaZ2v/L78bDUXMlg2FYR3eL4FkoAtxGP28lRqGoUCWfLzA+Hrm?=
 =?us-ascii?Q?uCZ5A3W8PQgGa1SECKpI7wOBd9Sey8fkn+VGRwyrFOB1GuIl+DcubDCnscXf?=
 =?us-ascii?Q?Z1N3WARRcESsvvLJVE9tbt++CbTYgfZ7ne6Z/bjru5PDKYQEk1dm9+D6CgZg?=
 =?us-ascii?Q?9l+CweL1QxMq9of+8U9eONfLAewb/jtd/86yI5kGsxAX8f2nVawUwT/5+13R?=
 =?us-ascii?Q?Xu3NufMyKx9hs3uhHfuRonC7f3h7U+jyLHAgVPfSZEo4CnX28sjFg11OPsnq?=
 =?us-ascii?Q?A8XWmPpdJjgVKzMI0PlLD9jsQpRe+PfrUddyPaQlEs4bsszbyhFv7mtoqGQi?=
 =?us-ascii?Q?GjRyyYuPvFarqFYR8pwsPwF4/4fhXn2ExYzzHsqgh40XO1jcJhfOJSSEV08i?=
 =?us-ascii?Q?EcNNYQjKk0uHu04VGuMxyLwFth88fjTTXkCpS8+SP59jAEqk67ESz/ShFkK2?=
 =?us-ascii?Q?vyZSpEu0aeauRaPl7+tm2g60UDgGyfLf3ztmpclwGU1dahvN4/3/GqLa1vxE?=
 =?us-ascii?Q?WXssc3xeDUi1LyYhSKnftHaNPqdPKAN9fXQ+nLOWLiKyPGpIfRTUNDoIZI9K?=
 =?us-ascii?Q?i0usctnEEHf5+gA0C6LUs1Bhcba3+FfdLC6pW3h86oOc88W4qdmbLtl/hR13?=
 =?us-ascii?Q?ZL5jRbdV7Yqc3yHu/tz7xV03elzYXuB0mH/OSFHf+0lYpknBrZe5WpDa0vT1?=
 =?us-ascii?Q?dw2foZMiVnDMbLLgc/AroO1ipuCFlQxIk2s5UD/305fxH9m7vVwSlO5d76u5?=
 =?us-ascii?Q?7IElO0ISnVAbad5aZDBXTjq5c/RjxrYPFc9/uTeOzFj/u/omLrvgt6PbtjQF?=
 =?us-ascii?Q?Ke7/2274G0/golSvG23aftdQHWCXTw/PjQosQVi/WENLGcxJJJSCRRAL76TN?=
 =?us-ascii?Q?yw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VddxOQlZcLmeD+dCyZsimdAxoB1iu2Jt+OXSuNU4lvuXIeAQYb1OeNxjI91jIR0qe5iM/9YMosVin7cnVB5jqrzOs4eLd+By9r6ZTgSlfYEGcKF9bfFyLTNk31e7s/zzdlfPL3zeTTt7Z5r7Al2b4rR84XI8aKTN/jicjdvjEpkd2tUUsP8x7N+66baTmdeonF1UcO6D9HOMVHlz4utdzJPGTKHo5FZeZTVMEBlAEQqVssu9KUJCtgNcr1StX8V52xxaS343cYv2lFqwtTAPBulhbpjBdpiyaC6Dk7ZvYHlUWpwvIYHWIY12hl14+rcvdEZo4NzEarLI7as/YH769ohV4XAt3qEfdcmhp5wGVVUWeTON3Owkxoc0EaxHpcz5zuB5XRUukD7+rpf/QFAe6MhlC49BWpIMGVKkPs3K7dajGVoor/lm6QEgtrFd0NsKcekz4NKRoFxqk1+/xmz4ZzwAfOZqEJReBaHNKe/EAe3JhZj+7uEYZNwCmyWVf1fMRvAD0FmeJrHJ6KDi2gJdZmtXpgFexRKrN/W0fIBKBrIL/zkrBTiOXhfc+XzUxQAigWHb3lgPrdtqOy7ZgPyrtyoxhvDHDY67smIBTIRJkhM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 451a2172-364a-48bc-992b-08de15e3445e
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 05:31:38.8482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j4QeKFXSMgVDQjmQ4lavNk77w4j93DQW925QRttBAmL5QMJNGDW+Q8emLA7Ql5hoximc4POqET9C4FucFXdgXXmLT/DJmqMEid9fUiT7vPY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7152
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_02,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 suspectscore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510280046
X-Proofpoint-GUID: FE8uflbVgA3S6UhbOqfx5s217Cp4fDZf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDA1OCBTYWx0ZWRfXwxeSKSyE7lWm
 juFYGhgP36CxWUm3l+WsBFxmhkK7le0nWn0F2v1D+TiolNCDEuuFam9H2Xmg/1c6lUjF0ERLY8e
 r6hfHMqLXiWumqb6TJRh7SbZbIFJbeOFmErNoqNYK82EEH1IgcK0RiwbBRZSO6U/lb/dP3Uckia
 6s7jGvLqO2PN+l1wWFtPhT5X3M1llDW9tCuQzz0XbD7bmdC/I1u4X2y/br85Yzc6PfRimN5cc84
 hruXLMNTQQ/E9xRgDuHr/YtFmTRSMDwHVNYte6NgkMww7kYnfLNph59Or4whsen8K3Ia05py+Xb
 I4nntamJqqu8t8jBu/jde0/dV8IjhvwiiZdS3ACxvyxtrrV6ucSgcZXc2wT8XrcNoJq4Dzvo09j
 pEDHJu5p2hjeuxAmd0L6klPNr0YwHt4D6pwaa//9aHlmnz7DZoE=
X-Authority-Analysis: v=2.4 cv=HsN72kTS c=1 sm=1 tr=0 ts=69005541 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=vggBfdFIAAAA:8 a=7CQSdrXTAAAA:8 a=JfrnYn6hAAAA:8 a=KKAkSRfTAAAA:8
 a=pGLkceISAAAA:8 a=QXDmnoQuuVSgSO7tUmQA:9 a=a-qgeE7W1pNrGK8U0ZQC:22
 a=1CNFftbPRP8L7MoqJWF3:22 a=cvBusfyB2V15izCimMoJ:22 cc=ntf awl=host:12124
X-Proofpoint-ORIG-GUID: FE8uflbVgA3S6UhbOqfx5s217Cp4fDZf

[ Added linux-pm to Cc for the poll_idle() changes. ]

This series adds waited variants of the smp_cond_load() primitives:
smp_cond_load_relaxed_timeout(), and smp_cond_load_acquire_timeout().

As the name suggests, the new interfaces are meant for contexts where
you want to wait on a condition variable for a finite duration.  This is
easy enough to do with a loop around cpu_relax(). However, some
architectures (ex. arm64) also allow waiting on a cacheline. So, these
interfaces handle a mixture of spin/wait with a smp_cond_load() thrown
in.

The interfaces are:
   smp_cond_load_relaxed_timeout(ptr, cond_expr, time_check_expr)
   smp_cond_load_acquire_timeout(ptr, cond_expr, time_check_expr)

The added parameter, time_check_expr, determines the bail out condition.

Also add the ancillary interfaces atomic_cond_read_*_timeout(), and
atomic64_cond_read_*_timeout(), both of which are wrappers around
smp_cond_load_*_timeout().

Update poll_idle() and resilient queued spinlocks to use these
interfaces.

Changelog:

  v6 [1]:
   - fixup missing timeout parameters in atomic64_cond_read_*_timeout()
   - remove a race between setting of TIF_NEED_RESCHED and the call to
     smp_cond_load_relaxed_timeout(). This would mean that dev->poll_time_limit
     would be set even if we hadn't spent any time waiting.
     (The original check compared against local_clock(), which would have been
     fine, but I was instead using a cheaper check against _TIF_NEED_RESCHED.)
   (Both from meta-CI bot)

  v5 [2]:
   - use cpu_poll_relax() instead of cpu_relax().
   - instead of defining an arm64 specific
     smp_cond_load_relaxed_timeout(), just define the appropriate
     cpu_poll_relax().
   - re-read the target pointer when we exit due to the time-check.
   - s/SMP_TIMEOUT_SPIN_COUNT/SMP_TIMEOUT_POLL_COUNT/
   (Suggested by Will Deacon)

   - add atomic_cond_read_*_timeout() and atomic64_cond_read_*_timeout()
     interfaces.
   - rqspinlock: use atomic_cond_read_acquire_timeout().
   - cpuidle: use smp_cond_load_relaxed_tiemout() for polling.
   (Suggested by Catalin Marinas)

   - rqspinlock: define SMP_TIMEOUT_POLL_COUNT to be 16k for non arm64

  v4 [3]:
    - naming change 's/timewait/timeout/'
    - resilient spinlocks: get rid of res_smp_cond_load_acquire_waiting()
      and fixup use of RES_CHECK_TIMEOUT().
    (Both suggested by Catalin Marinas)

  v3 [4]:
    - further interface simplifications (suggested by Catalin Marinas)

  v2 [5]:
    - simplified the interface (suggested by Catalin Marinas)
       - get rid of wait_policy, and a multitude of constants
       - adds a slack parameter
      This helped remove a fair amount of duplicated code duplication and in hindsight
      unnecessary constants.

  v1 [6]:
     - add wait_policy (coarse and fine)
     - derive spin-count etc at runtime instead of using arbitrary
       constants.

Haris Okanovic tested v4 of this series with poll_idle()/haltpoll patches. [7]

Any comments appreciated!

Thanks!
Ankur

 [1] https://lore.kernel.org/lkml/20250911034655.3916002-1-ankur.a.arora@oracle.com/
 [2] https://lore.kernel.org/lkml/20250911034655.3916002-1-ankur.a.arora@oracle.com/
 [3] https://lore.kernel.org/lkml/20250829080735.3598416-1-ankur.a.arora@oracle.com/
 [4] https://lore.kernel.org/lkml/20250627044805.945491-1-ankur.a.arora@oracle.com/
 [5] https://lore.kernel.org/lkml/20250502085223.1316925-1-ankur.a.arora@oracle.com/
 [6] https://lore.kernel.org/lkml/20250203214911.898276-1-ankur.a.arora@oracle.com/
 [7] https://lore.kernel.org/lkml/2cecbf7fb23ee83a4ce027e1be3f46f97efd585c.camel@amazon.com/

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: linux-arch@vger.kernel.org

Ankur Arora (7):
  asm-generic: barrier: Add smp_cond_load_relaxed_timeout()
  arm64: barrier: Support smp_cond_load_relaxed_timeout()
  arm64: rqspinlock: Remove private copy of
    smp_cond_load_acquire_timewait()
  asm-generic: barrier: Add smp_cond_load_acquire_timeout()
  atomic: Add atomic_cond_read_*_timeout()
  rqspinlock: Use smp_cond_load_acquire_timeout()
  cpuidle/poll_state: Poll via smp_cond_load_relaxed_timeout()

 arch/arm64/include/asm/barrier.h    | 13 +++++
 arch/arm64/include/asm/rqspinlock.h | 85 -----------------------------
 drivers/cpuidle/poll_state.c        | 29 +++-------
 include/asm-generic/barrier.h       | 63 +++++++++++++++++++++
 include/linux/atomic.h              | 10 ++++
 kernel/bpf/rqspinlock.c             | 31 +++++------
 6 files changed, 108 insertions(+), 123 deletions(-)

-- 
2.43.5


