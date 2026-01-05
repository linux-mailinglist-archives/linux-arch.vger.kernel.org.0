Return-Path: <linux-arch+bounces-15655-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED39CF2EB1
	for <lists+linux-arch@lfdr.de>; Mon, 05 Jan 2026 11:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D3EA73031972
	for <lists+linux-arch@lfdr.de>; Mon,  5 Jan 2026 10:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701D02F1FFE;
	Mon,  5 Jan 2026 10:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KJkmHbTB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qeXfsj/s"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29602F25F5;
	Mon,  5 Jan 2026 10:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767607646; cv=fail; b=d9Hnj6odcODU5YtBRQ/0od7Jtn5P9Ujyl9qUlw/ZG+f+qp0bPPU81xd/VmVyGCBC+slOT5tHSzq6iPmO0t1QeKEb3qny3Y8/+MG4pVyedUav88CA4r0WOq5/bk39CNentlgNpFwrhk4yuPiRbxcsf8TMy/KLpwxb4PGD81gsAk4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767607646; c=relaxed/simple;
	bh=GVYJaKa8FA/H5bNFQl6G53Eh2uVrrkZJ8rrx+BhYKUs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OfxnSpb90dj4v5aZ5yih14UgOTBHw9giQfog/DhkOU9IWcba4v943s+zXgpqoeTR65SKSnCbfoWY+ObifXyyUfFh+0XcbFBDYaoOsSyYSmhlWAWgyMNuc1s1Feka6Mg5tjKrCfP+j36yCwmyajz3u1gzAXKAqCfP7ubLB/oVz2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KJkmHbTB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qeXfsj/s; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6053OBEn298866;
	Mon, 5 Jan 2026 10:06:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=5ZDOOgrz7ktZu/6cZriGaS0Nz9og5GU1FCaRBXpCldw=; b=
	KJkmHbTB8zbvVSiIwNuFvq+Hp7ucG82/PQDu1ZxKbXwaw2UlB0sFg+QYLVU0SUIG
	d/zBQG2qraqROPhPrtVubm+/RSBJnvR/18IdXtKaOZbTCIaekLbrKd+CUElXsRsR
	lzi96/+W1GSS+TD1eqFxp8wOlSP2LBf0s+G+bIUqvfVu/y7Yz6YNs9hmouA1Lthh
	GTVv6p+G7jwREAweVT8wj3zzsFpBqHw43w4k3DJ03OtdpzuBwTKs/9hERaSmr8cV
	4L0bJM2A3AxyGzjkFSvCpFB/O28XFNxaLPzuyu1gmZTdJEAyjGGu+lS6e5ZonNPG
	61duVMA+ev98uLp2quS69w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bev641f7r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Jan 2026 10:06:43 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 6057SpfU015607;
	Mon, 5 Jan 2026 10:06:42 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011060.outbound.protection.outlook.com [40.93.194.60])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4besj6xx6j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Jan 2026 10:06:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vv7xkK0H8YJgvIL9qdtOFCQoVrQ+c50Ztnm6ZP/GXmXijKbA9asEK8DtDYwl18vaPXkY06AgZtyGdgnuqtRRG0CBCPG7l50X1ja34OiVnFg2t8f5ZIqOd7p3D5S0BfOvoY2fOO7NMoT6Lpmme5FUX9Wcptbgcv7vHdS+iPyFMxcivEHJjmXdkLCT6cZMQzX41b5ft0sGkqnQS6zj1TAeMtKCTjBQ1MEJw2mg+vYf9ufrgSKrCfKeUDQcq5RIGXJ6W1H7nc0qgCSi84vYrb4yar/9pU8qso8ycI571xby6jw7HweJgiJPlGOzqgxGa58P5XOp+2ga1nKH2qhurmhq2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ZDOOgrz7ktZu/6cZriGaS0Nz9og5GU1FCaRBXpCldw=;
 b=n/IghHHTI2uj5FNTKA+PArnSKDLfnohXYCGSvupxbwu2PplQuhejCVlgLYr6XS9pwHOoa/Lm4zowkLON/3fFZZjoYHyK2xdx/1WBrKmxYqrbt83GLVIEBDM9vJGl8FQXnWciKeMLXyuUA0KwRWvCVi7VlIf2xaTTXcGLMQ+R8TKrwGKsAKYdx87kGSVUZhEjI1nqPicU9ei5+4CcBW0AFbPKmoRPbQZO9BXUr0UALAp3rMFQBte8aE+idyJ57PVLTBL0MnZW4O1x4iMdRByw0FGUVNYq5VXWHuZNpYXJLaVgpSPZy5k2T3rjxBh90cCnEzARQHXGfR0NIiSgh94Isg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ZDOOgrz7ktZu/6cZriGaS0Nz9og5GU1FCaRBXpCldw=;
 b=qeXfsj/sAYN3eLRu+pgGNcJ/Mmps/uBig+WzjWG3QRz0lpBXqSDtNFit11r52aWMMU2x/+jMjB//Gqds6d1quX6/J0YB/Mst3meVtXukClNMbRVXAK7vlDalJjCbeMJZXiPAmYTOh56CHME6Yy/DGGuGiWxLxJ0pF0rwBhR5vQE=
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54) by CH4PR10MB8076.namprd10.prod.outlook.com
 (2603:10b6:610:247::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 10:06:39 +0000
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::ba87:9589:750c:6861]) by DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::ba87:9589:750c:6861%8]) with mapi id 15.20.9478.004; Mon, 5 Jan 2026
 10:06:39 +0000
From: John Garry <john.g.garry@oracle.com>
To: chenhuacai@kernel.org, kernel@xen0n.name, jiaxun.yang@flygoat.com,
        tsbogend@alpha.franken.de, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        luto@kernel.org, peterz@infradead.org, arnd@arndb.de, x86@kernel.org
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-arch@vger.kernel.org,
        vulab@iscas.ac.cn, gregkh@linuxfoundation.org, rafael@kernel.org,
        dakr@kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH 4/4] x86/cpu/topology: Make cpumask_of_node() robust against NUMA_NO_NODE
Date: Mon,  5 Jan 2026 10:05:47 +0000
Message-ID: <20260105100547.287332-5-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260105100547.287332-1-john.g.garry@oracle.com>
References: <20260105100547.287332-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7PR17CA0003.namprd17.prod.outlook.com
 (2603:10b6:510:324::23) To DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPFEAFA21C69:EE_|CH4PR10MB8076:EE_
X-MS-Office365-Filtering-Correlation-Id: cbf8405d-55fa-43ae-2369-08de4c421e18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?e4kQcPMu9tXEatGz9r+1Vt90ZTF653GhC0mFQdTQyeK2Z1GhU7WAV4NQKt8N?=
 =?us-ascii?Q?tBB/X6s8xelM7x0Pya0RK+fpVqq2RyWi1SPBa7rI9XFUrmFocLIGJxMRD2ma?=
 =?us-ascii?Q?LTlXRx9aNB15ypxVCN9lahVVkae6H/c7Ckeg4CTUb8QNhRyENBgA9qmVHLbq?=
 =?us-ascii?Q?/8x466OjFw5usKYDz2XEuNrE4zeSb+oIAOFB+lRzAtmLa4DkPzJt+Rcol6N2?=
 =?us-ascii?Q?AF1yilY3LnfWBK5fwi5agXxWGHu754pJadigBPN9jE/FjLN8JjFnhbH6jlmL?=
 =?us-ascii?Q?n/oqqXylRrNIaAMPc2PWWSARNdPTVe/+Xfm664Gqamo+KCaSLaH+LjvsVsZm?=
 =?us-ascii?Q?3kzp43d41IbjzDKH8IhCwLJkgVfRxqufgn0Uq97PRxZ3fdl4MANFsQ48TWVs?=
 =?us-ascii?Q?Q8SobNBvynXLLRhy/yrGgDRKyktvtr/6WlgsTaG+GwEF5R/ctXl8uj5vw1fu?=
 =?us-ascii?Q?gX8svUu30vO514aGJBCa6YGBS9afqLFrq36PJpV5hn6TIl8BcrS2/sKME8yY?=
 =?us-ascii?Q?cEGub+CdnHB5Ke/gfi8b9pqpAZ3pScGd1+y0U+Xfx8ghM32Ou13jqW0pNWWP?=
 =?us-ascii?Q?aEnlTuVY2ZdTlf1WJXxPuI8JQJYoSEntM0D/HLq+vYU1EPuRMhVCRnPlcTQ6?=
 =?us-ascii?Q?AiZz/kRQl1hODLqgMzPiulNh/QxhzBuV0o4CLwudLJCEWTlqvVe+9o5uWKyc?=
 =?us-ascii?Q?+ymTc/rlnAz2QvcXpzrMNuD+wkQF3aHTGPOux5XsyfWDuW80QjKMWhRQxL50?=
 =?us-ascii?Q?2iHETZ5E8lNEN5VNpjAAxnWmVCL0NdwrDZCdFVXQnK/0gNYwe5me9qK/ve/Q?=
 =?us-ascii?Q?Pb72XmPJmJVu3dMm8ZWf9OKNudFk3qrCpIhDtuCyr26ufCpnPpEd+2x03KeV?=
 =?us-ascii?Q?+z2fDPG8jhBGmTvFA5qNu1UNazr4BTkuTWoXRXKfYKTWKW9XNTWaywAOotVa?=
 =?us-ascii?Q?F6YO+L5xJke86RIKwvpBgZ1yr/BiquPwiPgq0J14OXEJaOwfka+BLNGkUO3r?=
 =?us-ascii?Q?0GWT/h9CbjE6NJ8CvS4gKgxtqPhHBL9ptqJhS9ijwJfiRU629MCOABOJXiI9?=
 =?us-ascii?Q?ptbLSCZmajc4RhNUEdNeRrxwcRT+qrYJiRebhHKfyJVdJszeKbNFixwE+5/n?=
 =?us-ascii?Q?gSuhYTHQJZabj9VScErroarmgOW35IEEuRo5lFflEybIiz5MiMyVA2AYsOTb?=
 =?us-ascii?Q?nrrz8Uhx1EssmHRMnnVpxUZpVmB5FvfYp/MBUYY+uwsm6x/sFTwnp6N3bYym?=
 =?us-ascii?Q?xMJwTc+1NZroAMkQmWz3IiSDEV044162UjZ5YGB+D68DHuvPtn30YpEbtqgU?=
 =?us-ascii?Q?Q6oeDhBJj6Zyq6Qn22TZaobMzq+5bkpxzhKlbTGmefXJofOYt1zUVt47rk31?=
 =?us-ascii?Q?TnBsIxfll9+WBNsrRD5+YTaoCi3nEldbEKNkxCMwwvje6ojAbV8M+UMz/5l/?=
 =?us-ascii?Q?553vqZ/kQPHImuD/X5N8cv/pIaSa1/DjIFzlXGh+OUxCcKudwBDaorFt3TR1?=
 =?us-ascii?Q?JeQUvvLzD6F2vwY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFEAFA21C69.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ccmJpNZ7MmmcKlGjI+VOnv+lMOp9mez434YLLJQw65nXm3+WjWwL14+2EZmj?=
 =?us-ascii?Q?uDEqUudJd/CC1kit8qQONRvYvq+WmlQ2GtSApAmarSjkU9G3c0Emz3EcJ3kp?=
 =?us-ascii?Q?lI1qSH80mepLRxM2kanpyuCKAPsXGgIjhTnRCS0zghpqiCzDmgutD95vjAYk?=
 =?us-ascii?Q?BE7Z5h8i1ZZlvoYxpvSd4A8+f6zzr7+C6jhGQqeqkYLHvT2u6BpdoPz+plZR?=
 =?us-ascii?Q?AnPTjDLXv21K5yPRwDL6Jnr4KuY+UcS+GIvrYFHRnfF7E06xzMGZvK9ZomDK?=
 =?us-ascii?Q?0DWelA7A0qRXvTv7x/FF0J4404WF3tqlOMizJQThkLa3pt0GufK1Bm7qeTp1?=
 =?us-ascii?Q?GpFhdsEEpczk6SWoOSw4934aYyKBmM7gD5yCYgh5iWzqIqUR6g7KYuFWYaWr?=
 =?us-ascii?Q?7rPKA+s+GwikX8okUsFEMzw7azaEkS1qev7UxH1WP0PLw1RZ+b/HpIao6Q6x?=
 =?us-ascii?Q?GVbLZfHJG93xDx5SfZL+iEeHUeEbDNINIIUxgMlI9rLcatrolHaomiIpMjyl?=
 =?us-ascii?Q?Db5Ee0rBcWzBFoEVhZ3sVLD3BhZN4Kjkn95qPsnYjdDEqXKP6c6KWg0eMaqW?=
 =?us-ascii?Q?5xPBvc4f+veKxGueXqxemNz7spH5aQQLkfKhFv0LlQDIihB0uEVwxjoZBcPx?=
 =?us-ascii?Q?RrSskYM+v4p9d6n9Txwc0ri4Tfp3jWV3oYpkLEoaUkxBh1O47mgI7dJPG77W?=
 =?us-ascii?Q?Hc43uyaBf0hg6ZPCBPpp8HDPgDGEjnBwAtpxcTbHVo4PE5AIghp2cdQMjXqM?=
 =?us-ascii?Q?pqs/p8OKNoBLshe0VriH9Z4duH4qtLHEmw3Sxvfy8/jjkSDCu+7OAMci3zcb?=
 =?us-ascii?Q?yy0TBI6BfMxG2xNeuHaP6ogeVcSpxXG+wXhnbA4qvqVnzB1f//mYLvv4W+LL?=
 =?us-ascii?Q?wMpanNuH+EgZgrIUriiRw6HjBMkA2dYGVcAB2yid7rf3yzNesenfra+gfysW?=
 =?us-ascii?Q?sIYwd7lDYiFRd24n/e5xdhq/O7M6wHMb+WowZ/pR6tgjnWPLzuiFwOS16MVP?=
 =?us-ascii?Q?UD3W/mfYA1BurjhlELGH3u2GAlGksrzFf+dB2+WS/gi1BLlV5q7DmrX6RBRd?=
 =?us-ascii?Q?cP0izRov5ZeavczkEWjQEwENvV42+v7dsYWHq0OJtBjVonvX8BSYIbCBEYT2?=
 =?us-ascii?Q?k8Upr8Y3uyQGtNbv2pOHnaDd/n3MWAqJPAjFwkqMuy2xtG7HixTwwFo0o/gD?=
 =?us-ascii?Q?V5J0bb2rmG5TF26S2dj6i5HqMk8Zu3X3X89UeoCDMipL6wKEve/ov2kQmDKF?=
 =?us-ascii?Q?9CYvSlR9hhrbFAGyHrXPIcXO5VrLpMksKQ1QuAxRyEqQ0iMU6UjJqWHyNIvH?=
 =?us-ascii?Q?TKQXAMUZ8UXgGkspXkaevlRF2niqiXfJgJQO8D4KqHmLJN6/7LmTgVw6ML4O?=
 =?us-ascii?Q?4+Q+sSJXlu+D5suVw8iQbh5K6h0aa37Cl3eUXjkIVoVcoFyxIPf+n5u6j4Yi?=
 =?us-ascii?Q?vbTJ+njNd/E8jIDJo4gUvrumTzyg/z2vw07+YS5IkTFObiL/R11XwANlkeQ1?=
 =?us-ascii?Q?DzDk9m6WhIpk+oO/gKGMnNHQcVE9BBL/7PxDlYDNsHW0CcMJ//cR7qYGq4Kd?=
 =?us-ascii?Q?jLZMQWs33T4N5PCxxVUmPwfJl+5yBIGBvNqPEgpUqInSPaiZqDnMf8h8g21j?=
 =?us-ascii?Q?5rgOR4s7SXHOGM3GMSVJrmgm7VRJPFWaCXJQyUb5WJZEut6xes8+gsXco8uf?=
 =?us-ascii?Q?aFaEu6uM2SI5ieBjVkigoR9MNtqtEBWBNzq+d5MSU+G6vhM9EncM6ZMUKWFK?=
 =?us-ascii?Q?axMLXwbSWA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Z9MzNu0s3PQUS2rDZ4qUD/BwSRf5nRnc3e/a+DlCbc3+63in80aggBHFaTNSt+dMNNlsmL5pvtWZ7n+wAaQagoet7gxBHUQR7UqmcAseOw6fgJxYNrfLjRzYmQXyUIVNSZHT2wxazxQGsueN/jGZz2gos2ez7evqztGD5FIamWAHDqSiI5NWt6LA/tJrEZenG0p72HEHzuZ+8I23vqbK+WS4qh2kXFK0dUHVvhHcHqTnLZWUgimQ5TYfjbqoZCwT+7WuIbyb5UcTg5cihrToPRMGUdzc6Fz3YoQfefFuRFrf19cdj7gsS5QiwIbml17MXb0l5sHKrv5eC3MYYz4o7fyjfFTOJe0L+S4mFV0r4DhWLNbfeUYfmVkRjZ4eYZmVUcLhO4nVjWHKHj/YoWeq3J1+EaUBHWpIn0SKqDgl5S0ZoAq3CUmAAfSJtmw12l+ODB9Vfe1UEiwxkKFuRnh1Q/0jTfzdIPoYOA0erFGKPHsK3X/kZ66rI+AlNEa2RWCw/mg9wcCuaGeRaWq78GCydaTvVFacnSiNBhiIU0GiYOe1dbrgpipPQrLXNW38DlJibrGNXu5FRCjdibcFRjReiDVm4dflwNKMh/VKMkexDi0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbf8405d-55fa-43ae-2369-08de4c421e18
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFEAFA21C69.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2026 10:06:39.1345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PS+mGBMS7EJmkEuojYl/tlI8VcgcqKEG6qWVvfwUo3UZUOZVsdZlCzRi9CKWFCUn9vev8Jwf2KGOzShhaw4uOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR10MB8076
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_01,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2601050089
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA1MDA4OSBTYWx0ZWRfX9bAFFmq5BGVH
 uG7P4P3vTZ32H9b9UCuknvpMNCWFW+HZurBwXUdWG6IruFqPbDfwGgpVV/ak7+4Mw2buwqNzdJV
 ykOiQDizXthouiYn4jyn1ZRCsq3vDGveK7H4xNGWnHxdq+WtTO5wJGZjM1ye2Wj1zmFbXost8Gb
 ixwwCQdSt/FJqhUw73v/6PRH4dlTiAilFWztpv9ymHPLCtJF1MxzgSt2SuOsSrICOYH5Tj/jjeZ
 VUdyOzoIkBhVqfoVxL2TdrAfwe251h9B9bT+HnWi1V5xnjEtxTS+aytwHlVY/8u2DbV5rdZZr46
 Jxg9IDBlOfGGP1/Y3/E6vvRXiRBW+8RD5Q90V7nVCI+yTw5ocsg62oFEqbDmH5F04fmboAXPKXZ
 DipceSSw/P0NBWafm52sSBpljZAuegSUOw8/pPVdjbupX71yYEV5i0bCdG01DemK5zas8l1i+pz
 oB2h3nW2EbHcxvDbfRg==
X-Authority-Analysis: v=2.4 cv=W6w1lBWk c=1 sm=1 tr=0 ts=695b8d33 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=-ifFEn60uaXn-cCPb6gA:9
X-Proofpoint-GUID: -kvctUX7uti3xqURFZ6OMtDnfrpabXfH
X-Proofpoint-ORIG-GUID: -kvctUX7uti3xqURFZ6OMtDnfrpabXfH

The arch definitions of cpumask_of_node() cannot handle NUMA_NO_NODE -
which is a valid index - so add checks for this.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 arch/x86/include/asm/topology.h | 2 ++
 arch/x86/mm/numa.c              | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index 1fadf0cf520c5..b51f2e771a582 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -69,6 +69,8 @@ extern const struct cpumask *cpumask_of_node(int node);
 /* Returns a pointer to the cpumask of CPUs on Node 'node'. */
 static inline const struct cpumask *cpumask_of_node(int node)
 {
+	if (node == NUMA_NO_NODE)
+		return cpu_all_mask;
 	return node_to_cpumask_map[node];
 }
 #endif
diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index 7a97327140df8..0be94f4682232 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -408,6 +408,8 @@ void numa_remove_cpu(unsigned int cpu)
  */
 const struct cpumask *cpumask_of_node(int node)
 {
+	if (node == NUMA_NO_NODE)
+		return cpu_all_mask;
 	if ((unsigned)node >= nr_node_ids) {
 		printk(KERN_WARNING
 			"cpumask_of_node(%d): (unsigned)node >= nr_node_ids(%u)\n",
-- 
2.43.5


