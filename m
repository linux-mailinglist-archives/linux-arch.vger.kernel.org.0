Return-Path: <linux-arch+bounces-15401-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F30CBC829
	for <lists+linux-arch@lfdr.de>; Mon, 15 Dec 2025 05:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 89F93303199A
	for <lists+linux-arch@lfdr.de>; Mon, 15 Dec 2025 04:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5672A31ED61;
	Mon, 15 Dec 2025 04:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Iijbi8m/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vj8/DUvq"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB38253F11;
	Mon, 15 Dec 2025 04:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765774299; cv=fail; b=szNZdzZ56HEycdowLbKOQxS5Yq25HcSt44wAy8/UDpk7sDOoyibdxObRUPNCXIY9k6JhDQywz+ctdrCciXcS43z52ZVFPUBwwtFVmlkCYwlYRJGpQevKK/NZyCjSqnqnWQPseI+ghZruSidZhpfFFAQ2RKei6kxqa1yAHfYJSNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765774299; c=relaxed/simple;
	bh=ORwDsv+IQNwzniQXC5ZSQfzLbFtLTSvwT/oTVr68uBM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=O3zkBTTpFqDMXOdzhR0vU363JpuVdYflaqMKVpnxKbl0VG312PtLhfWTmOdWLG+am20aaaoiTTwp8TAmt29KlkHlVOksu66m9RmGW68P1f7iENjfG3mEaT03sWI3G5rBMT5J9GScmu7g6O1Jcuq4zQdZ8RullUlE6cYwsiWke28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Iijbi8m/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vj8/DUvq; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BF0ROME936861;
	Mon, 15 Dec 2025 04:49:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=yFAwdN4AeVwuT99d
	zmpSEKGC7wm9jbqugIkIm/ObrRE=; b=Iijbi8m/I/7alLcoVGVk0pbz64LPvp65
	v4gdPvr/X/IpyYIW3CGFhU4riQUPqZJNExAlSJT7ZXTL+a06kaLmFjkBI0Ww0mSb
	Sw2ROa4yuhjrazq5cPGsbEKY6VsFbrzO+aVqIXP2Dd7EZD0GXgLiuXlW8JcbEmcg
	0G7u6pAs8gA9fy/XjUuNeiZ4kkmhl5a6RZZHbvmA5dY7y7RqupLf7HdIZnfRBzFB
	/wa1zlDClux04oaQVCHpQZc/PIYf/o3F0z3kQODEQ12DXvIOmvlwYNCEY74B2e5/
	hNBrAmCncnQ8EHsaiVcQm1LKrvqltW8jqp5eVgYppj3P2CWsc7sf0g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b0xja1b5w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Dec 2025 04:49:25 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BF1gU9L025249;
	Mon, 15 Dec 2025 04:49:24 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011028.outbound.protection.outlook.com [40.107.208.28])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4b0xk8rda6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Dec 2025 04:49:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jWASW4YHVHbW6lFNMmjnhmtOC6Kx1i8B0g1UVaIBohR0WaVaEwfeYMcYljNX0qTghUoPlA/VjkVWt8kaZ+vDPINgQauMc6hnWMGyIwMRTXsAiWpsq6l+YqWt32gcXzVF6VI81LLKrHHZ07R04mtkX0q2o/676OarUVDu0XAqre9iFZ/a9i6xR+wp+s+FgTsyr4HxWwOPTCWk6x+XKT+WpG15gC9u8KMd6gy3EDGglYQ2df74oZHtlKKajFx69MvH+SxO3QD5wqH1cAWpx+vs4fwNc1EGd99h6Qs9k3uoHc9yEOF1zqov28wjSp2uTIPQ5DuOMiEwa6FthKf+bkYl9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yFAwdN4AeVwuT99dzmpSEKGC7wm9jbqugIkIm/ObrRE=;
 b=eBJTXkh28g6RwsZxJSID5iNxgC1HuaHHk/Pf2KG0UUlKshQKPZMTn0STXBU4l/mg6wBkXI1C8jGOddbtjbF9ieWre4vum2hkP7Ur7p9lFgeme0WK5tl20I3YhM3bM1yw8kdoXiYszycaxnaIrHfW79NDUbxi6UPyPLpFkWhuvlEUsjxeBwyRvsds8HoBM1wmqppveJdY+Ec0Wqjw54WVYEWLJQPWpJN3BijChOgpPDtNcQAP8Xbpg4t1axG0DnUi5LsSYh7NAOvgb1Vj5guPwzRfWpTN7l8zz29DkdxCHScf/tNEsJxXWz9ue+TZbMPqjCClGnOaAUXTdoJ8DilISg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yFAwdN4AeVwuT99dzmpSEKGC7wm9jbqugIkIm/ObrRE=;
 b=vj8/DUvqdk3czloav+vwKEMp/hIx9NtBSukGnVo0lhlD8P0dWICgaEt7/NAcoAkvO6qj2a09pXRXv5pYQCb0S6Z+ZqYoPfpx6Ru83CIj/uq1xOM1UgDeUzsQT4KDBEEZJIX5R/rY3r1MbduMu9gdGZtbH+EGpa++Tg9XBoY4jV4=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SJ5PPFDEBD75B51.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7d7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 04:49:21 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 04:49:20 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        bpf@vger.kernel.org
Cc: arnd@arndb.de, catalin.marinas@arm.com, will@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org, mark.rutland@arm.com,
        harisokn@amazon.com, cl@gentwo.org, ast@kernel.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, memxor@gmail.com, zhenglifeng1@huawei.com,
        xueshuai@linux.alibaba.com, joao.m.martins@oracle.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        Ankur Arora <ankur.a.arora@oracle.com>
Subject: [PATCH v8 00/12] barrier: Add smp_cond_load_{relaxed,acquire}_timeout()
Date: Sun, 14 Dec 2025 20:49:07 -0800
Message-Id: <20251215044919.460086-1-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR02CA0025.namprd02.prod.outlook.com
 (2603:10b6:303:16d::11) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SJ5PPFDEBD75B51:EE_
X-MS-Office365-Filtering-Correlation-Id: 41dd1d1d-891e-4fa3-2c77-08de3b954fc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VGv5ROdKWA5VsR/GJGkAW6nAkgP76QP+kmH4CGntj2JsCtChDZMsO10QrTQ2?=
 =?us-ascii?Q?q3YTY/D20rA+TSssQzD+lM1Pyb0VbNhkgaj9ho6SsKvdaoNqhuSpSHlfdbxS?=
 =?us-ascii?Q?Kh8YDAO4Z7XTXWeybA6AwH0nbU6IWfUHnlkGujhEThIM1by3yaXq9Vgh+KIv?=
 =?us-ascii?Q?XMUu7VqOI/fgkp1RH5NR4FJRZ2niiXVMF7hJ74M21oBzqYeMPAi1PEa1qtyE?=
 =?us-ascii?Q?2Riweounht5Pu99qCDq3sMwrFKZOBDqs/NC2Kwk96dxyuv1HkomP6rHPaQgb?=
 =?us-ascii?Q?Cy1QyFok38NWaLQjaRszK37rCinG6k8bBHThuw7NeeykkSu4wyhk60CPVUQs?=
 =?us-ascii?Q?mDKBjlqHeLz1dsyM1ne+1wEt9AD+Esa8qTgsoEVAT0nILuOneYPbxK78LLlp?=
 =?us-ascii?Q?5StjIkZbn5yTkaalPoEgQqoyv55rzvIFjwO/MIKaPkPpcx9h2r31sLVQN6N9?=
 =?us-ascii?Q?Eu9c9RWTJzIwc/zn2HXRGJzTgpDC3sS2vtQxsgkAqUR+OZ+bu1TMpJlUM8FB?=
 =?us-ascii?Q?iahQi9tjozak6MJVOqWELSeon+Z0SR3c0JztGFJI01QqC9QfsAIJYZfIPOCx?=
 =?us-ascii?Q?WYG75jzHaUE1IjVEDE3QZx2r+UWh1r09a4QP4OUH5iH7RI5Z8lXl0a3yXRnB?=
 =?us-ascii?Q?2E2D9oNvuICbA5wJvBP+1SBGXAxjh0DfKahZ/z42FPlHJzXWhpCmm9/Sa/u3?=
 =?us-ascii?Q?TlMw4nWCKdjZATxCWLEgqS79ZvyCm6HTIpQcE0D6E7CpdHu5wh1ZwIXOFhfd?=
 =?us-ascii?Q?2wGPGUMaPIUYovcf41/A9K+R46r1UhyBOTaZaT3Wt85R/az2iR9BWawLncSi?=
 =?us-ascii?Q?5/1EMiQLJZ+N5hQJParOY4n0VcGeyMnKT0C6/splDQlmM3hldIZBgAfanqL/?=
 =?us-ascii?Q?COtvRTBB8P3IzZJN/PTZYMV66/xse4lh0KH22iYWqK9He1AvdUsvZPzgl3Z+?=
 =?us-ascii?Q?uDkss1mmBMCY7MHh2b3ewPPX5oxWZTi6v/z7BVDa2IieP6JZuGKh2VjRpzC5?=
 =?us-ascii?Q?Kd4qbkCrjQc+qvE9q9aPXp/NJ8OdYuZWXr/82UF6RXmNZQ0sNi3zSD/3f7kN?=
 =?us-ascii?Q?nCKAdFJJpBUOwNp7arduBoSyRxzhGW816ELS26c3BP1U0DhDw4qCsq+Yvee/?=
 =?us-ascii?Q?7LGw82q6Iwy3nGXQ5TQPm7v8Nw/8WWJbjg3oIYqcKT4vuOb2H2DX7VYI8oiW?=
 =?us-ascii?Q?Fyvu7W8i+dlJH9zsBNCqz/s05tRkMEuWUFTv9X3+Duwsm62yS2DXbbbd7mmt?=
 =?us-ascii?Q?5He+WHD3NRu0dXdEzOJ/3a1fzNduxYMbhiXImPwpIlkzv/2JeaifYy9rLLaD?=
 =?us-ascii?Q?6a2k9kp8A6XCWRXIFl8AvX0aiZnJg0xziH866dCCUUulkGGbScxkmaQ/UVRH?=
 =?us-ascii?Q?849TFvspsQ6EV7LX9iqb7YwKA23Y4X7mQzvFs0kBWq8rLwGbLAzDhpHvPnjL?=
 =?us-ascii?Q?nDsU8N/CkRLOVTYNh5yuvI2Ub2j3FDJP0/mnaQpQaKAKR+nXh0R8Og=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?s7FVrBTGqBoYSlKH1ucPJGDQnp92yoit260VOQ8i48SwU8EKS5CM0US2FGtH?=
 =?us-ascii?Q?CoCQBmXmHq23OoKV6VCmIkwn3IWj21b28PYz2Ze3J4HuV7AStf8t95v9RTzZ?=
 =?us-ascii?Q?B12/QWZrHY/jfzuSDv3LFlw4H3NCv3avNUijWYycYaXBG4fnjhK65yQ4mlY3?=
 =?us-ascii?Q?06iB1sud4S67GWM+O4WsuGGd613ePm5pGEZdxNn/pn2r/6RL0IKcjfuwbiyk?=
 =?us-ascii?Q?nai6EVDFlL8c5CHQIFODamM2+vkfNpUS6azMUhRUJRlu8WZ74yUcyJY8AF35?=
 =?us-ascii?Q?Kn/X0VXrFp3pLKCbgRDt0Xqw2t1jMEw2Lx0TvEojQkra2sAMLt+Bo0cmQvmM?=
 =?us-ascii?Q?hIpBOSNsXk0PNyA6SKULTOvLM1LvdXAOI4BM1T8/lhW0EQMATdaltaMkUHN6?=
 =?us-ascii?Q?OJGqCXPYaLnoOcLpyCfTXyIaIjxfzRRQO8+WxLU3UxyveS2x3UJHHq29ymna?=
 =?us-ascii?Q?KMOVJ5HXq7rqS9yzSiDwzyzVEo3OK1hdoBZ0Ky1fnJ8gaynM7rd5PW9sLGsH?=
 =?us-ascii?Q?j3yiZa8sm7hFLeNHUKYcDmHbaNep0lXFINSIv2r67V0JLkwNlGkqB6QK3XTe?=
 =?us-ascii?Q?3MRLfLCCuZGLIP35G8Ixk4s+e3zn9Qtbtchkng46VAwSj3eEcMtBsTixytti?=
 =?us-ascii?Q?yZZ+6bFSvTPtZRSyyEug2MdVDz5Q1x2rzZ8U/O6fIdVeJudpAscjymb2pZAX?=
 =?us-ascii?Q?O5AyGRImlTxbUK/tTa5nmPPfCgp4bhtK28WPKXBRf7pdoJcXEZYh8ry56RPE?=
 =?us-ascii?Q?bCdxQfBdsnmP5qTJKyKWnPejGyc8HRC7GcaM9TzDNLWKvtDw+5BXs8tlBhp+?=
 =?us-ascii?Q?ZDIr+QcNOcJJeOFZ9JMmVYUWgdCaoiE1WhQ+czE/Xa9NZLN62NdlDvduKLIc?=
 =?us-ascii?Q?3mSTtoYmpKsh1vcbEDGOr7n1AiyL0h/JHjIDqcWfTieY/noFyTN+sQQOYJeu?=
 =?us-ascii?Q?abN9cgNHcBb4O8RNCcplHKN8ebZnX+1jgpXaMnlC7hl7QYP0AwY6GGSgOakz?=
 =?us-ascii?Q?5+MBxT5SXZHcAVkvvIgJriRN0oKe2NsasS+ePy7cbyJAzz3JCVW2yZSmmb5B?=
 =?us-ascii?Q?a9HZYe1o7k0w76hRjsMVTX1UeEYjqvZNLly3EI9sLaeW2mA5NJtnCMkenhgw?=
 =?us-ascii?Q?Qr044qqSvczVRNAsBV6UA/uJmTF8PEGnehBMxU9RLO/0vSV2SzIkxBpBbzyP?=
 =?us-ascii?Q?hoz1wyPEUpdlC4Onw+6mzmz8nOR/iplAslAM7PABVdf7EfeqxVecfbs44qmA?=
 =?us-ascii?Q?wdlP/yz7iF2yuUXLwK/+1LdUibkNGnuTRUyY84SdC+7uBOjbkDYqKpnoUqUo?=
 =?us-ascii?Q?r4I5Z+nRekqkORcjxaDUNOJBGFDKYuEmVIm7lQOex4AgmeQDNX/K/2JEsRYh?=
 =?us-ascii?Q?xfnVIqqegW18CQQ2mJQ0RVclRRWmEdWyPfSGEXP9YUDftIh/I7HttyKXtZR4?=
 =?us-ascii?Q?PPkSv3BiYn5neBvxmHbl7fbPR95sq+9bqiTi1w2ywpmpotcBR03O7m5nd3rE?=
 =?us-ascii?Q?VymaWGeNnqEyTh1e2rmr5F5iWqJBAj2VGWYRBxSH4e3De6TM0IG6iLeNep9u?=
 =?us-ascii?Q?ltg7HFQNzHvzumVndjlSiapM48iNYTwWu7hpiU9vw340Fg9roSyPR74D7z6/?=
 =?us-ascii?Q?6w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+Vy3e2lomjBgUamvZMumOoK6ITtQuEZLxvNW5DTdAXpbnH+KO/kemQko9le+g0GSnjc084PlV2Ti5WJWCNoIaWacWUjwr+T3APOGxg7TsiBXZEIY9k743lCVqAbnuuASKMWQPfA7itJ+kVOOtst1OyJ7O+CnI6Kt9AS/FdYLL1oFh0fYN4XJwQ/lLXZJ1NhLEQmgv2JDW4sZOCMt80MEFFT15DC6+sI2xvEgbWFK4xAJckoy4CPshPspBDNN2sgZY6N50Z0stfnXjb4GybDGvi72DkA2XPqM4KAet0I9D/i0DoIUDii/jtajx5hphXl2vcJlQiv8B+UJDHU4iZIjgkQ3mb3HRxQFbu9KdQMz1ZkwNER2+yeaaQWqzqoPZca1YbPqgYJPSNcj/47UUSv39LBtNwCMxBwnjxNLFTBZkjCr7FR7f5hK16CXpiwd1lsVyiATNmbgWA3H/TpmKpdCuPb7YL2fWwVoW700rblZxRw8fAmd5BMEOEI5LeEA1F8Ab15MnCClj3GNxopmil/aLyV8lu5Tbp0nS52+U3aW7rWG0eRmHg+PJsjjkOn1pYyMyYxAu3mmrBtgmqn1ZeILuV9VjeigKX9XCl/ZzAR9Q3I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41dd1d1d-891e-4fa3-2c77-08de3b954fc5
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 04:49:20.8690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AZNIJiEFS6ZLYalUyoG4xiDF9bm3s36WxD9D5WtHK8DrjClNi4mKR9S2/DfTOaoHMNRJZZeIuWLR/iQbFAOhCaeFHQPhr9doTU75aKcnA2o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFDEBD75B51
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-14_07,2025-12-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512150041
X-Authority-Analysis: v=2.4 cv=TbWbdBQh c=1 sm=1 tr=0 ts=693f9355 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=wP3pNCr1ah4A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=vggBfdFIAAAA:8 a=7CQSdrXTAAAA:8 a=JfrnYn6hAAAA:8 a=KKAkSRfTAAAA:8
 a=pGLkceISAAAA:8 a=_xGcVyy_GYjtdmyDRJIA:9 a=a-qgeE7W1pNrGK8U0ZQC:22
 a=1CNFftbPRP8L7MoqJWF3:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE1MDA0MSBTYWx0ZWRfXz42MlkTLJI0N
 sTk62kchNnkp/HoM0/ODWAggVjwEVDm3C/0GmrNtCxR8JLM9v4t2+TQ3vmnoeVa1bm53KqxT3Ef
 rhkgpprytahWIsOKKiSiiYLPUKSv2UoAks9l9k7dtofkq5W2dAdKVR52IHfFLNnX7uYMeuunXRo
 AExMGZH/k+ODTwUFqmW0g/W+6GtJFr23H/uBB7oe7GKyeD6dpRxrS3VX//jiw1cjI1yYh0wf9zU
 hI3fBjMaYPmKw7wtSvzdVS8RT4udz3+NtKkMSU8DuMygT8ruccsy20U4coKepCKdsnRa4W4nY/a
 0xRRQRaN/o9gq3V8/zi70qZxIjtBDLxuIslhs4FbXmm3RCndnSQwZIpdGlWG3t/vc5W0dkViEQD
 CvUas/amihVLnCV0IB1eZvzgudVTfQ==
X-Proofpoint-ORIG-GUID: lAbfSPfFal47Kk7GmMBndxk2TyHwZrsG
X-Proofpoint-GUID: lAbfSPfFal47Kk7GmMBndxk2TyHwZrsG

This series adds waited variants of the smp_cond_load() primitives:
smp_cond_load_relaxed_timeout(), and smp_cond_load_acquire_timeout().

As the name suggests, the new interfaces are meant for contexts where
you want to wait on a condition variable for a finite duration. This is
easy enough to do with a loop around cpu_relax(). There are, however,
architectures (ex. arm64) that allow waiting on a cacheline instead.

So, these interfaces handle a mixture of spin/wait with a
smp_cond_load() thrown in. The interfaces are:

   smp_cond_load_relaxed_timeout(ptr, cond_expr, time_expr, timeout)
   smp_cond_load_acquire_timeout(ptr, cond_expr, time_expr, timeout)

The parameters, time_expr, timeout determine when to bail out.

Also add tif_need_resched_relaxed_wait() which wraps the pattern used
in poll_idle() and abstracts out details of the interface and those
of the scheduler.

In addition add atomic_cond_read_*_timeout(), atomic64_cond_read_*_timeout(),
and atomic_long wrappers to the interfaces.

Finally update poll_idle() and resilient queued spinlocks to use them.

Changelog:

  v7 [0]:
   - change the interface to separately provide the timeout. This is
     useful for supporting WFET and similar primitives which can do
     timed waiting (suggested by Arnd Bergmann).

   - Adapting rqspinlock code to this changed interface also
     necessitated allowing time_expr to fail.
   - rqspinlock changes to adapt to the new smp_cond_load_acquire_timeout().

   - add WFET support (suggested by Arnd Bergmann).
   - add support for atomic-long wrappers.
   - add a new scheduler interface tif_need_resched_relaxed_wait() which
     encapsulates the polling logic used by poll_idle().
     - interface suggested by (Rafael J. Wysocki).

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
      This helped remove a fair amount of duplicated code duplication and in
      hindsight unnecessary constants.

  v1 [6]:
     - add wait_policy (coarse and fine)
     - derive spin-count etc at runtime instead of using arbitrary
       constants.

Haris Okanovic tested v4 of this series with poll_idle()/haltpoll patches. [7]

Comments appreciated!

Thanks
Ankur

 [0] https://lore.kernel.org/lkml/20251028053136.692462-1-ankur.a.arora@oracle.com/
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
Cc: bpf@vger.kernel.org
Cc: linux-arch@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-pm@vger.kernel.org

Ankur Arora (12):
  asm-generic: barrier: Add smp_cond_load_relaxed_timeout()
  arm64: barrier: Support smp_cond_load_relaxed_timeout()
  arm64/delay: move some constants out to a separate header
  arm64: support WFET in smp_cond_relaxed_timeout()
  arm64: rqspinlock: Remove private copy of
    smp_cond_load_acquire_timewait()
  asm-generic: barrier: Add smp_cond_load_acquire_timeout()
  atomic: Add atomic_cond_read_*_timeout()
  locking/atomic: scripts: build atomic_long_cond_read_*_timeout()
  bpf/rqspinlock: switch check_timeout() to a clock interface
  bpf/rqspinlock: Use smp_cond_load_acquire_timeout()
  sched: add need-resched timed wait interface
  cpuidle/poll_state: Wait for need-resched via
    tif_need_resched_relaxed_wait()

 arch/arm64/include/asm/barrier.h     | 23 ++++++++
 arch/arm64/include/asm/cmpxchg.h     | 72 ++++++++++++++++-------
 arch/arm64/include/asm/delay-const.h | 25 ++++++++
 arch/arm64/include/asm/rqspinlock.h  | 85 ----------------------------
 arch/arm64/lib/delay.c               | 13 +----
 drivers/cpuidle/poll_state.c         | 27 ++-------
 drivers/soc/qcom/rpmh-rsc.c          |  9 +--
 include/asm-generic/barrier.h        | 84 +++++++++++++++++++++++++++
 include/linux/atomic.h               | 10 ++++
 include/linux/atomic/atomic-long.h   | 18 +++---
 include/linux/sched/idle.h           | 29 ++++++++++
 kernel/bpf/rqspinlock.c              | 72 ++++++++++++++---------
 scripts/atomic/gen-atomic-long.sh    | 16 ++++--
 13 files changed, 295 insertions(+), 188 deletions(-)
 create mode 100644 arch/arm64/include/asm/delay-const.h

-- 
2.31.1


