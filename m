Return-Path: <linux-arch+bounces-9978-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C70EFA2660D
	for <lists+linux-arch@lfdr.de>; Mon,  3 Feb 2025 22:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 621881885926
	for <lists+linux-arch@lfdr.de>; Mon,  3 Feb 2025 21:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1DCE210F58;
	Mon,  3 Feb 2025 21:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="C1tD97ez";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aKy8nfBv"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF0978F54;
	Mon,  3 Feb 2025 21:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738619382; cv=fail; b=jEEJMZvf/LEC+CPIS4vyWrxDdAqRM4kh6dZb2/KX2hhgJABPmEhpsPXzTGK8W49Um+sFBX19c4CWQKaK0zyG9QybZvwOOTJADSWT1ku3NkUSZfabfeQTeAR3l4erV15fFJoVb2TIIZgnDIIzic83QCZxynOAXFflxSakS7qafuY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738619382; c=relaxed/simple;
	bh=9tvlPqttRXu3VeInrQwBRH5odMejvBtdHcQjT6awboM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=a+wohEj31OGN0OL2wU9HEXfYf4rd/fHU8fxWlyPOUimax7od0FXaoijk+g9LSamnjsLSDqYJ4lxqj4HWR0ypjw0Y5yEEfg8sWkV04lpmaAeVxRqfZLl70xUxpD80zCeVtt5XhEZZM/L9y6hatZ22pwO/4BWs015lKLLdNKsOxAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=C1tD97ez; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aKy8nfBv; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 513JNd5N007605;
	Mon, 3 Feb 2025 21:49:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=v1O4KkB2xFFnM4LQEpkzFzzUOuPZyNrxlTPhoDkStRQ=; b=
	C1tD97ez+zdbkAIq1R+jvjlcxFS8UzxNEg+g8xtztWuKJwNjrMxEbvqB6T4haMYw
	LKaFBQ/63fP0Lloe7L+OY6mTGeYnIDPj9P8GEuU2WEyDnIi3qhtQn9t/Q2CteHAx
	Fx59IerXuKsDe7Ejt7wJp746cNUkXwtvNUmokAp3tqLeNtyIeXv0+5NhkS93jo5X
	6LhZTaaARtdxDTlvuAQvpseMR5EcQrL38uUvSpRXwhK9hG8zdthlSB++iaE/12Wn
	t/HpqxqycClNGk01164vcMnm8UFtt6Mm92dnK1B5k1yUQhF94klnLnyjQZGvm5t4
	XcdL2YlT7FxjPgfgexohKw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44hhsv3qa3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Feb 2025 21:49:19 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 513LGWIE029838;
	Mon, 3 Feb 2025 21:49:18 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44j8p270x8-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Feb 2025 21:49:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pAYZ2XkGd59hBqY3/GJ+nsiPVjuIlFbFtjE4hZsm99CP4g2VPiUF55plYK2dx/xgoss76fDLFaULDGU51BOSzLbpwlaySl9LQQvzNuRlWsZe9oNVuX3JCBboEx5sxyWdy2g0Cv7tUC/rdtHB/Eje5m4MABuXp5II4KJ00bVb9JTcN2Yjg2Ykk235bzYxG6eKtUvGFz/DIj3I/nVJ9eA48M3avAVx/edSZ0h0Ha1EvI9/phkb6trIsQYFTxKF5rLwFyTbn1rZNEDX5/ufDp6JE1AqwwQmsI32xd2HR+QMt9Aa1pw2xsRNc2Nvi6xm7wexcQ5g8aWQfjZQVuelw3+Seg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v1O4KkB2xFFnM4LQEpkzFzzUOuPZyNrxlTPhoDkStRQ=;
 b=J6K/0LF2BV0ScNJ+CJkm+jcEFXJ2W327A4WumQWX/XLtNfsxChLyQNXRAlyjhKQbunBdfmIhIhqRfvHkMqWCEyTpjEnKZgzknAFtGXf/D9QreXkdLx+JDY/Q5HCAwBc3mkBm5WL7pkE3RtUxgeG5eZi2EOmjV3864C1xjyrFckKidI8vRo2kXCZZqOiQsyWcs8iyeuGO749cgrZQmxcvtwYt5Ph2pTzfwZ7uO2oiKjYQbhSszyvJEJA2Jf1OtnLxHbtayqbHuR/ogl/FTuSeV09INnYcWL/x2Ofm4377QkKg6QRHSfeyVPoTLgHmuJgw/T+UBim+WUHMbQOL6z/OrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v1O4KkB2xFFnM4LQEpkzFzzUOuPZyNrxlTPhoDkStRQ=;
 b=aKy8nfBviKz7Q84s1wQY/zoW164xm947f3eKHgQPI7tCH5EbrGZ0PvDWYUV05SsXswqGCc5xewEs9bh0Qye6exnXJ4A4WE5IarO07CjxIiwfpuIrzptjMyce1S/sEiePd/ehmfeLRUBmJWR+Dk/3LTnM+JfqiSzg8OjomVkgQJU=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by IA1PR10MB6854.namprd10.prod.outlook.com (2603:10b6:208:425::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.23; Mon, 3 Feb
 2025 21:49:15 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%6]) with mapi id 15.20.8398.020; Mon, 3 Feb 2025
 21:49:15 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc: arnd@arndb.de, catalin.marinas@arm.com, will@kernel.org,
        peterz@infradead.org, mark.rutland@arm.com, harisokn@amazon.com,
        cl@gentwo.org, memxor@gmail.com, zhenglifeng1@huawei.com,
        joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, Ankur Arora <ankur.a.arora@oracle.com>
Subject: [PATCH 1/4] asm-generic: barrier: Add smp_cond_load_relaxed_timewait()
Date: Mon,  3 Feb 2025 13:49:08 -0800
Message-Id: <20250203214911.898276-2-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250203214911.898276-1-ankur.a.arora@oracle.com>
References: <20250203214911.898276-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4P222CA0006.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::11) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|IA1PR10MB6854:EE_
X-MS-Office365-Filtering-Correlation-Id: 86186d80-b3e1-4ebc-a0ed-08dd449c9a84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vd8i3fjUbDRIPTtUb/kJ1vzuuUXnToKKcKmSgAMQtGtUYolAVyzCfa89amd8?=
 =?us-ascii?Q?4BDEBTa5Ed96a3Lec52NB2HUGAxIyY9x0YCeH4DoDO+5J2e7R6M4+422yuzz?=
 =?us-ascii?Q?0BwfIse/5cO/gU9J/DI1iHvzSwUO+FuXppUw+4sbNL1X3WmDjkxcvx8MBzdm?=
 =?us-ascii?Q?dqVyhRJcP+zrGA5vnifUDiJ0ttfY3kfwiUXOkh547ce6dgiVyT4g4KBv11/6?=
 =?us-ascii?Q?RaEfSPKYWxSWuSvmL2JJ5KQ4Ygur7pGC07+CqosS/HcOHsQABJ3+UEogUpV6?=
 =?us-ascii?Q?2pPAFq12EROimsLxDs6vfcMYHiR4vbZ2F4J9fWqyCRabkZ4KOyZAPxhOsG8Y?=
 =?us-ascii?Q?JjkiXYD8IPjhYEcHYU+OX5/A8JPYTB7a5WLUx/oQN6C8i4s24mKF88MEyFjK?=
 =?us-ascii?Q?7gxDoeUyQ6f9iicFkalw21yq8VdQEVU7ZaVUl+OSjoG0CduCxwM3wzCNgA58?=
 =?us-ascii?Q?xsyWVYG7rOHDghJ6561WQ+XmArtGDC8qLhQg6JNpUJCzDlZaKUa38VviA8UN?=
 =?us-ascii?Q?kNscdXHChAqbDLJVjVgD7wFMMk98QXaia3k54Q1BqprsAZmszGrXaOdn+ED3?=
 =?us-ascii?Q?CKg8Jt06fTWs4WwmBfukxQYZGmuXmeV8pAkPsZqJFLB60ZX14OIUhBo8rTVE?=
 =?us-ascii?Q?RKPLW6QYEdN89tESc/pQQgfzbbJKQveRs6dZQZ7Ck8ZcOC5Bm8rp6kSqi/OC?=
 =?us-ascii?Q?0/nbTdreqYIV/2oOABANVKbqRmXsI3GXxLYGpei7CM6QutjHPuxskoaL4cw0?=
 =?us-ascii?Q?7cxVqMbS1A3nRJDWKOmAdCpSpUs83yFmLAfUPmqcHb5IqJjA5KopbkPqjDLs?=
 =?us-ascii?Q?iR5qiIvarVMQkEQ0Ta05j4IoAd1e/NGV4N0cm6sJf+5l0zCV2DWBguc/LLt/?=
 =?us-ascii?Q?MggtZVK+BDZ7jq8SrXPN94p2uF1px+e04pZEz+oeZk9+0Bxer0LdSLyuXU5N?=
 =?us-ascii?Q?ANu9Km3GOwLQc2HTfGfeNMheQaJmOLcefnumEj8a73ONCZjcdLilN/sPkL57?=
 =?us-ascii?Q?NupODpMo7R+vpJc3rtZmsHgR/HXBJnnqNjJ7F+qE44UowNpWWn0RKO13CPsJ?=
 =?us-ascii?Q?Rec9ogRwIeC3ZZ/eAGbEVGJExLBCTbDjOaXyp/CwOU3QvSpacN5bylC7hMOz?=
 =?us-ascii?Q?n6nWsc6ycVhfG08XQTipTS0saSCrAKPTI4SIWwSsNC/+3GjwUvNlmB0JZTq+?=
 =?us-ascii?Q?8rS6SXyDcCXJebtnpfJVrtJat7nSl+GrHcA11xICE0DP6yigIRwITNAQY5aB?=
 =?us-ascii?Q?8Xeow8NP08dIzC/L4iR2ZxHFmyL3Z4zWo/fBEIXDrlwFlbF8JkMpgkasIPr/?=
 =?us-ascii?Q?JOe88NcLHQhoO6+phLw0VX0OG+m4y2OylMAHUozaEP44GVdNjPjllRvcZyZy?=
 =?us-ascii?Q?cOPy2M1PUDmD3+5lBa9G375oPCtA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tVYmnpf4kWJ0D8fd6/ot4S048vmGWeT25R0jCrVSdSGBzLx4iQErjX5udDhe?=
 =?us-ascii?Q?BPze9rgumoMx5yzJbJmVo9mge9+OjGNt4UiYxmRteHuuZPOZsGZVp5aruHO6?=
 =?us-ascii?Q?RpD/ZpfGdXAYutU7opfjX4bAR+1s8UDiE4HESzAQvdr0S/zr7fM//3wpOeBC?=
 =?us-ascii?Q?dlSTKFe1v41dteNo/SMl7gWGD38U3vAaqWyCznH6JthVyRBQUa1OE+FvwCen?=
 =?us-ascii?Q?f7QHx4IAz1WxaOrEf/00cuQaXsnj1Dfm8fWvKaiibVtsz63yzuQQdeaglQr7?=
 =?us-ascii?Q?Fpr1FL76O5+6Fzn1RDQFP9K5qeip2myyYaMDck4NN5NL9OHa/NKbdSIPVsE2?=
 =?us-ascii?Q?kTEM7Xz3sS2MCv12/WvV+jggftsEenPYO5Lmu5vJFBSEY2knTMpxYFM6PpNV?=
 =?us-ascii?Q?nnpEymLplP44/cWWUfpiY0vMN3O1r9iF5x1w9a/HQx/HqDxCwvXldwbOEWKu?=
 =?us-ascii?Q?rnNpRJdTfS3JQZw6q/MP9W8j2Sv+3r/OCSr19YbEOUrAV7SlW6uatvnO2i4X?=
 =?us-ascii?Q?K4gvQ3JCm8a3iHvKU2MBNBGWa0yw3tWDfbkeRKNBJWwijKTmstD/d+Bn100F?=
 =?us-ascii?Q?3g6IbqJEMbXMp3HqlbV9AWwvvmmv5aZPhvN5PA4R61jSLZ1a8veDXeBCYclc?=
 =?us-ascii?Q?QnPKtQnTjNp+43RauqCJVRmux1U4ifbj8IW+5rvNh8H3GNiqQGvmUoxbjyaU?=
 =?us-ascii?Q?dNwBTtTLoDpuxqsuOl8JMBLm02uOfeenaxn9qvNJSN5pkuPwP9g6qVdNgdlr?=
 =?us-ascii?Q?5swe1iBFvu5nCvaTOs3aFedKmkO7fdcJrkgxN6onB3xmXeT6gO7chZpTzyb7?=
 =?us-ascii?Q?78yqW+l0SldqSwTLDUul5V+5OY+SzKL0XGwnnGDbTTkDaMlcrzLq0hCAR9CZ?=
 =?us-ascii?Q?U/hHb40lqTDWhVswoGaBiHZUaa8+GQugXqqdFOK8xi1kCf02jCTMpMjQ5/bJ?=
 =?us-ascii?Q?Scri2c2D/5S23F2p30OWs3Kj39aOsD3JHVz8bc0hL15KPt9Fy+iwzHIolsyG?=
 =?us-ascii?Q?AhcYesehZjccJitulY9oLjH6eUS+SvRK//m1FIGnRPSn/QHHyK0KIzDKsG/2?=
 =?us-ascii?Q?UD0TcVkAYAGv3LDxBPUx0ttyDbkBsPNQl4RqpKexa3M3beIgUqOFfi8eAEqo?=
 =?us-ascii?Q?JF3bDgulx2sX0xUmUEbt9mIMEnPaSFSH0rUicmhD8nKiWHURVAVUMjUxIv03?=
 =?us-ascii?Q?IwqiAOvpHB3Ou5u0HwNiKZ40hs/OJZNMoRancXfnw38ZHcN3FOKT2vtJ3gCR?=
 =?us-ascii?Q?lhJRl98+crtTl0pMczXN7HMqFbA8F4MDPl5wMuuSOHb9vuMHUFnoTCi3pPHg?=
 =?us-ascii?Q?eBlDm8W0X+f4DdSY4ATW69GCBaAtBlQsnpPzumHVpiiRsXLeySOvZsbVkLyl?=
 =?us-ascii?Q?4MKNWBuJVIVez+kb7c/qN26KDr8riWVWrqXYC9Owr4kLrE6q93eywFbofnK3?=
 =?us-ascii?Q?p9zpOGLPOZaZlQ2EQcykBRmBX2g9G0Xyy2JmIeVxU4Ok1ZT+f/0Z5WqIj+g/?=
 =?us-ascii?Q?oBfFUR413BLBtgWNTnYjLkd8zMZu0+AYcUTNXMBMSt1vyWWxKdPJTxGtspWA?=
 =?us-ascii?Q?4MpgPKlQNHHNyklG5qo19UHWnhQ0Vkj97QbJuIjqcYFLMrC9lpZutZMhd2ar?=
 =?us-ascii?Q?RA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nSPQzj/i3j4TAj+1AK8tuIP4Nt23OQXCaA+0ikuMK+cH9e3vLIfrEACy57fzeWwYfuxOfO1XJBRq2+p53Tm37Ms9go2P5jwM9XB/kltA/iPIP/v8psLp7FakuEvnGgOxc6hLUBZBF4XNdVTwBBiQVolzCFKpBj6oRl7OOzZ6WpVbCe4Y5/CFZVn0jfhIQLv6xPiGL2r1Yz/nb6cDWY0R8/poTwllQr8lDLJ3fA30a567BR1aq1hCYZmFSW67iJHR1DAn3kbTfk8TQOqR5PY479th9+NRUxQn8H47MBoVfv0a2eCeRFGoLe3MoPQ04XcBuEmfyG6OowKnYPlr2Ror6UKlRgAJ2uhU+wQd6QHaz9ejHQlv9vQZKtFPSycquP1r0fQMhngVQiFYmvgI97Km4WMt2mARSCcAyVfrNePlNgnybPdqZM6ncZSa6kE6vTRdZcwbHxBWIMzIsDpJlNlv8QoChviB/safMKWEqGor4jZa7zyBvUUoSs/k+0K2yWoAjIqdXTBtGoZr8HmvLZFqJI/KyRw6rugkWq/OSKC588dOUqArWCSqaSwGjIM7hRSsqfZopeS6+VXFDWOepIusm9tGpBTxHM8PS9Z42yILYPs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86186d80-b3e1-4ebc-a0ed-08dd449c9a84
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 21:49:15.5738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VQXPv6GV/jHg2nBPR/C7WYWZhK5aZr9rMi1EWo+iyR6hr8q7AuRICxSXkjGZxA1jltPEcq5PF3ZPGCTqToZj6mQ0QJY/wgjfHfpwARvsKY4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6854
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-03_09,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 suspectscore=0
 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502030158
X-Proofpoint-GUID: gvQ9bUnD67dGxim4Xg6XTnKfHW0zuc9c
X-Proofpoint-ORIG-GUID: gvQ9bUnD67dGxim4Xg6XTnKfHW0zuc9c

Add smp_cond_load_relaxed_timewait(), a timed variant of
smp_cond_load_relaxed(). This is useful for cases where we want to
wait on a conditional variable but don't want to wait indefinitely.

The timeout is supported by extending the smp_cond_load_relaxed()
interface to specify a time-check expression and an associated
time-limit.

The generic version is implemented as the usual cpu_relax() spin-wait
loop with a periodic evaluation of the time-check expression. To
minimize the numbers of instructions executed in each iteration of
the loop, limit the frequency of the time-check to once every
smp_cond_time_check_count.
(The inner loop in poll_idle() has a substantially similar structure
and constraints as smp_cond_load_relaxed_timewait(), so we reuse the
same value for smp_cond_time_check_count.)

Architecture specific versions can implement this by waiting on a
cacheline to change and an out-of-band mechanism to allow for the
time check.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: linux-arch@vger.kernel.org
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 include/asm-generic/barrier.h | 48 +++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
index d4f581c1e21d..31de8ed2a05e 100644
--- a/include/asm-generic/barrier.h
+++ b/include/asm-generic/barrier.h
@@ -273,6 +273,54 @@ do {									\
 })
 #endif
 
+#ifndef smp_cond_time_check_count
+/*
+ * Limit how often smp_cond_load_relaxed_timewait() evaluates time_expr_ns.
+ * This helps reduce the number of instructions executed while spin-waiting.
+ */
+#define smp_cond_time_check_count	200
+#endif
+
+/**
+ * smp_cond_load_relaxed_timewait() - (Spin) wait for cond with no ordering
+ * guarantees until a timeout expires.
+ * @ptr: pointer to the variable to wait on
+ * @cond: boolean expression to wait for
+ * @time_expr_ns: evaluates to the current time
+ * @time_limit_ns: compared against time_expr_ns
+ *
+ * Equivalent to using READ_ONCE() on the condition variable.
+ *
+ * Note that the time check in time_expr_ns can be synchronous or
+ * asynchronous.
+ * In the generic version the check is synchronous but kept coarse
+ * to minimize instructions executed while spin-waiting.
+ */
+#ifndef __smp_cond_load_relaxed_spinwait
+#define __smp_cond_load_relaxed_spinwait(ptr, cond_expr, time_expr_ns,	\
+					 time_limit_ns) ({		\
+	typeof(ptr) __PTR = (ptr);					\
+	__unqual_scalar_typeof(*ptr) VAL;				\
+	unsigned int __count = 0;					\
+	for (;;) {							\
+		VAL = READ_ONCE(*__PTR);				\
+		if (cond_expr)						\
+			break;						\
+		cpu_relax();						\
+		if (__count++ < smp_cond_time_check_count)		\
+			continue;					\
+		if ((time_expr_ns) >= (time_limit_ns))			\
+			break;						\
+		__count = 0;						\
+	}								\
+	(typeof(*ptr))VAL;						\
+})
+#endif
+
+#ifndef smp_cond_load_relaxed_timewait
+#define smp_cond_load_relaxed_timewait  __smp_cond_load_relaxed_spinwait
+#endif
+
 /*
  * pmem_wmb() ensures that all stores for which the modification
  * are written to persistent storage by preceding instructions have
-- 
2.43.5


