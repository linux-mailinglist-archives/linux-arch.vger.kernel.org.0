Return-Path: <linux-arch+bounces-11998-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 892CDABC8AC
	for <lists+linux-arch@lfdr.de>; Mon, 19 May 2025 22:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD4FA3B8F62
	for <lists+linux-arch@lfdr.de>; Mon, 19 May 2025 20:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34D521A45D;
	Mon, 19 May 2025 20:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Iih02Xd5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZqcvKYpq"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B2E215F5C;
	Mon, 19 May 2025 20:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747688019; cv=fail; b=THwBckSFS7C/e2LohBmQoc6Ml+rFPHnuWSOr2WWIuVW8zI2qdC0cC/YspVaoM7Xhd2lnVRkNS9aef6nsBrYHBEUE/OP1MPlfureYmmeHLraWK75RdJ41cIKimllTvnODD3uPZ7Me81C81vVphG7Acjcy5zsnnq2JIa/piu101GY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747688019; c=relaxed/simple;
	bh=+nEDNAARqnCUBEgZVKsdz+8OyGS+PT+M1Pgzzq8W0w4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WVP8IP76IctAN9eiirqPlaqoJQ/DnZt92LERAyY/nmZJsE0Q5JTmoA96fzBsz5EO630fjODbppJnePHbkIZdbi0jB+eyN2pg9F/uzhmG6UewzPukfvxhuYpD+EtbZbleyYowqUh4RchsomhHLuigBDgvGP8faKnJSKhsizrFmxw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Iih02Xd5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZqcvKYpq; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54JGMov6026200;
	Mon, 19 May 2025 20:53:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=lSMmhNkLVsU6TmwqC2fCXnxw0dv6uUxxrMIrFipq01o=; b=
	Iih02Xd5fs1MNWfO9stfWsl1g8WZUMgD/+2dcU/gBD7USEC0FpSY2R7JSCYUKC2B
	Ol05b3Fmsy1QFGXL9EKIHOOM8ljG1vHnhzpdRjzpdn4lZ71wn3ZJESh4P5zDl43p
	glXYupExhtyf7KJUOh/DGHy5lgkRhCkehnMJUPRv2IuW720OUN/3xEK4jF7+5/L+
	rg44EKnq+tEN6LoKT8rXDQi2A3R7DQWP+EiDFA43rwfw2jHz/erLBQbdr/SHmJz+
	VjAvCH0fG0P8EwOCN++5Mp0q5ZalsddI6QK0axq8yzLyKGIyF/4wXRg+M/kOGkgK
	oWGU/8JBv6leKWQCo6jX8g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46ph84kyjm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 May 2025 20:53:24 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54JItVHG017346;
	Mon, 19 May 2025 20:53:23 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2042.outbound.protection.outlook.com [104.47.70.42])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46pgw7e3p7-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 May 2025 20:53:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AkZXUdufa6BpelKL8es/GdbyhuWhrac7t8jb4kbGutIQ84r6+KrGLU2AzeYFN0anhhyRcOfZqByGgNyX1aZC2QitI5nL0x9GfPdB51ayLoAH5stjVpRh5Es36tF/UZSIqbgn1zQGFoJ1zwLvcNhsVUAc6/Iv5vJmgXgAfIjGC+8BbLGAZWhBQ3wMN2dQEErMt1tP3lrbCsAkCVlHJJNUR2sc+rf0VteGRGOndgGVqF4CdO9+CE+hEQtQ9IwTX1IO0Go8mXwuMi8H1P5RRp1vvbd4YqM2OL3okYcMbpBaSCzfa3XR2cKjmrZxENEKAEQBnw2VcMSfCEKtCLG3vIr30A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lSMmhNkLVsU6TmwqC2fCXnxw0dv6uUxxrMIrFipq01o=;
 b=pYVn85EMdhJiHhm45VK1cIcGy3fzrYlDP0ZMXGkC5fbOXVYyPhe7YqdoU1xzX11279MikcUyeDJnca+5Gg4Vhgnd5IZL+IKs+tC4mrlOAG2AV2F4/jsfaSz0xrZ2xGEar3cPxkgNJm0UbFke+xW6pX7TB1RZMu2Eulmc+G8IoQWcuwGAvFRuD09+fVXHFRQORjc0L3nHplX7WuXBKaQMSMYLA2CQWza5RC2r1eQY8HXAp+2gfggpkmr6QyKAWqvk+MTVhTRI9IDTyhyh2Uou96uCkFhWL5gu9JFGsGn6b8G/6CejjAOuz8tvLFVldl5AVHXK558CP8FLeFy5wKC4JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lSMmhNkLVsU6TmwqC2fCXnxw0dv6uUxxrMIrFipq01o=;
 b=ZqcvKYpq4ynQztvuxwGThf3PKMCh5IPEOHVxI2a7YntHKieIlWnHxf/3dR76RAQ5PwvgPS/QgvBPFskyBtG0K7WLDzNQDyEtxUSP9TZn4X+2yAm7C1f+HWIiysdrj21VvfPrrSN9kzhu8onfffGypSXZZpNSq2H8IK8EHxUXdsE=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ5PPF4B2F62DBB.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::79d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Mon, 19 May
 2025 20:53:09 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8746.030; Mon, 19 May 2025
 20:53:09 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>,
        Jann Horn <jannh@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <brauner@kernel.org>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sj@kernel.org>, Usama Arif <usamaarif642@gmail.com>
Subject: [RFC PATCH 4/5] mm/madvise: add PMADV_SET_FORK_EXEC_DEFAULT process_madvise() flag
Date: Mon, 19 May 2025 21:52:41 +0100
Message-ID: <617413860ff194dfb1afedb175b2d84a457e449d.1747686021.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1747686021.git.lorenzo.stoakes@oracle.com>
References: <cover.1747686021.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0464.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1aa::19) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ5PPF4B2F62DBB:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d539bd1-4615-4c14-e6dc-08dd971729af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5YaSqfAn7z8Xwk4DIEC25QlxJqFet+9zMD6b9h1/6DtJPQES4BrVmAP9Qhdd?=
 =?us-ascii?Q?rzwt3UKk/MlC0tUQ2N8OxTgTVVwmUVvAmpqqjWLLTJpqyQjDSobOXPsbk04g?=
 =?us-ascii?Q?pU+J0HvVOvaYrfCqyB5crqVltCkCHg+tvQZRxTR7s1s/UJVOXzoZ4aCgFfhE?=
 =?us-ascii?Q?KynC1EQwNxyhfLOLbfZv0cqqjVRHvRvokSdLeYry+kv0PQCbPSBkho+wxToU?=
 =?us-ascii?Q?0PAFu9C91KH8Eo/YMyBoBiFLTDEqI+lqW3pjWDceahJRb0LrTFEwtBs/AcFm?=
 =?us-ascii?Q?jdQAREX2jEL1MBdn7czH7Hyr8GtFBTI1H/X71z7eue2mVONAuyCpt1k+9k+a?=
 =?us-ascii?Q?rd/+YRQNt4/qpetY/F9EmUsl4m3KY/IkFWezandz6760bw8syrtZrjGFEtYW?=
 =?us-ascii?Q?JPNemM2VCGAkNobKs1tVsmPqAkjBr1LFHqJau1mDAw07fzJ8kspl2VAsTOkg?=
 =?us-ascii?Q?9NzKTuIVIq1AvfPAHhchNX9AnEDE6UpUzHxw3nvSynJztMdiRSxW17UqnZtP?=
 =?us-ascii?Q?PhF4fJl4rG4/suhk16pK7rAsLTxuNJpf+SMEkPYvY9gTqnPHJzGTPSzA5Wj2?=
 =?us-ascii?Q?Cxuu7yw2+wWAfumf2DpwK9sXstAm2vI3FlMU1yuG8FgmPnU3mZ9OkJuI+2Wh?=
 =?us-ascii?Q?rbK5FqeJy7YjbwmrDz/8dVCuxnxgxvYDMWcnhFjMEbbmJVheSQlfE2zqBymR?=
 =?us-ascii?Q?aVN/5b5QE78DU2vpyKB+y9UasHV7RTa4T7mfI8LEAm/RQwW4pAngXqLtI36W?=
 =?us-ascii?Q?6SBOD0PXgO2ciLoySfb3aDfuNatmglKPPww8Pf44efuzdyZK1R+Bdad3riov?=
 =?us-ascii?Q?LwA4y0jFPGQkjN/CyK3eF2B4oSbGaJlaNuEX8yVZUORPwE097CthzclEWUHH?=
 =?us-ascii?Q?ysuGZkRTvajuXkIYbpI62ZjUATcXwnOyRyfICo2jwbDLIldiaTz03N64SlVh?=
 =?us-ascii?Q?sw0CbeBFESrGeWWMGuR1tR2Y2gHfYNU2qExOFKRkPqZOlqAFO+g6uOpiAB0o?=
 =?us-ascii?Q?wDIcPlYJ0ytcV6v9fd/dHqWgWJxtuNshlktXTlff/ofp0nhG1+RnzLpOBgBD?=
 =?us-ascii?Q?GoIPV7nHJoBYSSlnZo5XcvflYUIH8q+VXjrl+jjXtMKme9w6TtUpKR1LqEMK?=
 =?us-ascii?Q?vXdX2yfPHPoBJPmoP8c1uQjco4DVoju67UGm0FxLJ3/pZryM80TIZkf62XPz?=
 =?us-ascii?Q?AJThC1PJ0u0FDwc4J8bUILLaLLcL1zlwpWHK/c3UXJScojxBey6QizF7EIoC?=
 =?us-ascii?Q?aejl4G3QTgNxNx1MMnlKnwyVgi+DPPassaU+pMfCpX9mtX0d1aHPE6Litis8?=
 =?us-ascii?Q?KHbRp/WC7fX7FI3LI2UCYyq9XlJFe/NqGpURQJ6s7ebpJwMBdsOGhKc1Itxm?=
 =?us-ascii?Q?1zCONIn8M+2j/s/Hf+sUMpOTKCCXJbeUHURFYtLOJzXtc0lqAjdqXwHcYiMZ?=
 =?us-ascii?Q?BL6FBXi+A+g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vGUfEMwWVhmqJ9HzoKGO84xdaAG75IjBoP9tc4nJEoFlE+yozBhPNqIqKtvr?=
 =?us-ascii?Q?6QK1T7yW2kGAL/TCstkTciemLSVAPlflPB0aIEKBNqKnhMwOMQ5QyCWjCKA9?=
 =?us-ascii?Q?VxYR7h1C/BH1WtBMM8JWJSn8u3LMsEm/nOM/9l2Zhfq776jO+OvCU7fOJcPO?=
 =?us-ascii?Q?2iLYTPZMHKz/Si9MJG8AJ3lIzBR8PEJ+Fr9YDmJlNpJPsW4Kl03GD+o4KmOL?=
 =?us-ascii?Q?Wku9sQqrDaFWLbSacgnd3/u3jySYP3P7J9AL0zBBP+RTYBQGepgCiWB80EMx?=
 =?us-ascii?Q?vbhEDxlMiwHLSnID7qU06pYQF1dFH4k5CLWrUELSoqCzqdrGHl/rTUjUCzMv?=
 =?us-ascii?Q?xFhJ+otB+8/h38U0iJHF4rCe8O0UGxiyXNzyP4nJ/KnHdNuY020G8Oet5gpx?=
 =?us-ascii?Q?RQq1ELzJy7tUo9Ol58ddf4orMksIcimMg+Nlf0KW/LO/62CGAihAMGh89frR?=
 =?us-ascii?Q?1Ii9P9Wcx16FDTgN/yuts4hVhH7Fa1Ko459zUz1u46IjEAEMB270QBJoN29l?=
 =?us-ascii?Q?GGm2xnppX6RH0Nd2Gi6Ypfl0zWRVFRnb+xSROaSHEXo8wqo4jukcPXrzA7Qo?=
 =?us-ascii?Q?6XIbrpxhuEKU+wmg2RpLvtgTymrxw4hwDrE025mwVpKXy+lH1QJQ2r9+CK1B?=
 =?us-ascii?Q?BEWmzOyZtljxBjd3hu/AsFJNq7fAIlnw4K+mHsau2IHo4/eO7GIQnfTzTRCN?=
 =?us-ascii?Q?R6T3aiUfHJV/akEIziuCqvx3endjEq/13qXmYbGPLDlCiKr37ShBnM+4Oc1G?=
 =?us-ascii?Q?n5PdqPiSpzxifYT+qlqtVvWD5XQTBWSioGtHqQDXpcZM31rvk4J5sGaFqvZZ?=
 =?us-ascii?Q?+0v0GxRdS4MVgS3y2N0ge6ndUvUp9CbkQQtH2BJfuck1yPjlpYvU62l4avGm?=
 =?us-ascii?Q?XOEK+b3MNqhtZlt7ckGGDGdn31TsMkW8UKv+9tEPL9nalXZjs8+uq7Uxr8rv?=
 =?us-ascii?Q?4LC2QWOuOASXahSynEi5jmyXUUEe/2AN5BfXMVXk8kEh0Li9hr2SOi9vNk1J?=
 =?us-ascii?Q?jUFxPe3Vn7Q2m23+i76EW2mHQw+4EXoMj8OXWWhOx4pw+r1Kw+nDt1NTE+y8?=
 =?us-ascii?Q?Jofr9AMmKz9ukNCTd2euY7XChkDgNFVt6eFsnVZ+ZyOqkP/nkFqXf3BO87WK?=
 =?us-ascii?Q?UlzmSGZc53NvidfC8vxVre/nZ4SyprroIk95oeR+dKRFJEeKNvi6com6vFAe?=
 =?us-ascii?Q?/nh2CHcVk9+IbwFHtW6DfvlkHRhFARM7JC9s4RlOVAU5rBOtTjFtZSyelpw/?=
 =?us-ascii?Q?y3oPxTcjbJ2YXq6rkovcKIN+SjxhF0WCmAxcyogOQ1JzLIThnT1nSaVl8UVM?=
 =?us-ascii?Q?ZumV4B552z80YEL05noSara2q+zz4P4uK2aq5B/tLnLB7oV9D0gYwUIbsy75?=
 =?us-ascii?Q?TuRfv5zQDXMDOuCdguchFeNKLYn+OdaOfmgfX0ssBPjoCOdxt1xOajp2iynK?=
 =?us-ascii?Q?t40GPAmyFXj+8Ls4kZVbRfQFp44ObTQWBnoQsCadgFx/IgFxgEA3JERINeKg?=
 =?us-ascii?Q?nSR3NHXHLV8eirNy9JeatnCBSpOtiBcTtn43iilxJZBqO6SwbX3u9Lbu1w3k?=
 =?us-ascii?Q?MAlUrtHRcc7EADPisy5/MD0taoFWqp0qP1xHtoPg77hpVIv5MkzRjsTAYo5+?=
 =?us-ascii?Q?kQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	iAN66Fq+VuuZrSrULYHbJrGjcU0qPWfj+2TfilXRncCXGaUo3l9WOMopQtFFufvVu4Au+RPNvUfI48XKaLQOhuicZejdP7EIVjtnLswb/oju/2+DdD+mMNC6XU/tlLlmaKljta2iU2sxw2b5YK4bgUdBGXnalQ50wYd2gQY2vvL1krJnq8ZD1eUzwV7QkElU53RQGVSM1OCpk0OVGimA5sdW9lnEc1wX65uhP1yZG1Ly10xRN/MxW7bP5mImTfXCL71KDfZmHGCpQciDZI2gCJ4E92DuC8OQOHek2+XaucYCJWZbJHEulf71RvhFXLlKkOfo8boGODgaEZqczQvWSVKtfwYAFd91ICL0RmY6B33oCtHWzkLBic65Td6ZfVLhFMpEX/i9JOVW+XvbqeLQZERshBcwaBmk+zJ/UX4SfkbuG6i1Vs1r9b1PUtGhgdiwD8YD3gcrogNOA90KO8TNxiLFXlQrM1FTWavTBcrImuvjL/d0lxs8xgkkm1BlaVRPd3j/h9YZsjD4BxZHRDvwSY8lxpC/Obvz/ru8Vji0niEx/vQq/wlTULRBqu1izZqzxftpuYuvSUCXN+QZXTrTbQSNCsro3b46jlwLSi2i/Eo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d539bd1-4615-4c14-e6dc-08dd971729af
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 20:53:09.6570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JM7RI78cj88maaRHy++Kpb0m0q+rq+SrDND02Rq2EHoTLWA5JJ79P3Wy7yx0Bq1YqJ5B1iZfMY5GaceUcJFHDdXsj7gxQZhIECNdWDDEUhE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF4B2F62DBB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-19_08,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 spamscore=0
 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505070000
 definitions=main-2505190194
X-Proofpoint-GUID: Z1_PQYA8-ZASV69C8Dd1eXlqvg1gb-O1
X-Authority-Analysis: v=2.4 cv=YPSfyQGx c=1 sm=1 tr=0 ts=682b9a44 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=fbqJCjwplNoI79WyuVMA:9 cc=ntf awl=host:13185
X-Proofpoint-ORIG-GUID: Z1_PQYA8-ZASV69C8Dd1eXlqvg1gb-O1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDE5NCBTYWx0ZWRfX54y+m7QeQV9A 16I80raqMquT1sQhYkjxSoXgLa+oUenW6sYNXL6ZbMLMTL2DxsrFqls79aF1lht7wBsSm/upVpf 6bEM4fSiXdhJhkoRrnCmEmfArnghIrX6I6NDdPC+Fh2H8m8ImsFjRjZjDXOD8y2sStZ6uQM8yJZ
 /ZcrOJf7xSTVMVMbH2qtsYPaJxPk8+XFaDA0NB9vluKS5ZxXgXdapKDJiKvBqLOGBy3kQn7bcs9 ehYJt6Khm57euHffrwc8269J+qDzorrLGHlTEVmsiR9TOz9BTL5Lg75hkNHgzUP7DLJaBr1RBih 1nOZoNg4D17TyhPkZDlLhMYM6QFDgZjNQlIuryyK57UicZOi/xxmixRS1BEg/kxh6mcjbwz6Hk9
 +uHns4W9aH2F9M/PwgrK3kAocG7QsJW9ooCs7bI/AtwiOPsdFIGcIWspMylvhfESC8tS4b7N

It's useful in certain cases to be able to default-enable an madvise() flag
for all newly mapped VMAs, and for that to survive fork/exec.

The natural place to specify something like this is in an madvise()
invocation, and thus providing this functionality as a flag to
process_madvise() makes sense.

We intentionally limit this only to flags that we know should function
correctly without issue, and to be conservative about this, so we initially
limit ourselves only to MADV_HUGEPAGE, MADV_NOHUGEPAGE, that is - setting
the VM_HUGEPAGE, VM_NOHUGEPAGE VMA flags.

We implement this functionality by using the mm_struct->def_flags field.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/uapi/asm-generic/mman-common.h |  1 +
 mm/madvise.c                           | 43 +++++++++++++++++++++++++-
 2 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
index 58c8a3fadf99..6998ea0ecc6d 100644
--- a/include/uapi/asm-generic/mman-common.h
+++ b/include/uapi/asm-generic/mman-common.h
@@ -94,5 +94,6 @@
 /* process_madvise() flags */
 #define PMADV_SKIP_ERRORS (1U << 0) /* Skip VMAs on errors, but carry on. Implies no error on unmapped. */
 #define PMADV_NO_ERROR_ON_UNMAPPED (1U << 1) /* Never report an error on unmapped ranges. */
+#define PMADV_SET_FORK_EXEC_DEFAULT (1U << 2) /* Set the behavior as a default that survives fork/exec. */
 
 #endif /* __ASM_GENERIC_MMAN_COMMON_H */
diff --git a/mm/madvise.c b/mm/madvise.c
index fd94ef27f909..9ea36800de3c 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1869,6 +1869,40 @@ SYSCALL_DEFINE3(madvise, unsigned long, start, size_t, len_in, int, behavior)
 	return do_madvise(current->mm, start, len_in, behavior);
 }
 
+/*
+ * Are we permitted to set an madvise() behavior by default across the virtual
+ * address space, surviving fork/exec?
+ */
+static bool can_set_default_behavior(int behavior)
+{
+	switch (behavior) {
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	case MADV_HUGEPAGE:
+	case MADV_NOHUGEPAGE:
+		return true;
+#endif
+	default:
+		return false;
+	}
+}
+
+static void set_default_behavior(struct mm_struct *mm, int behavior)
+{
+	switch (behavior) {
+	case MADV_HUGEPAGE:
+		mm->def_flags &= ~VM_NOHUGEPAGE;
+		mm->def_flags |= VM_HUGEPAGE;
+		break;
+	case MADV_NOHUGEPAGE:
+		mm->def_flags &= ~VM_HUGEPAGE;
+		mm->def_flags |= VM_NOHUGEPAGE;
+		break;
+	default:
+		WARN_ON(1);
+		break;
+	}
+}
+
 /* Perform an madvise operation over a vector of addresses and lengths. */
 static ssize_t vector_madvise(struct mm_struct *mm, struct iov_iter *iter,
 			      int behavior, int flags)
@@ -1882,8 +1916,12 @@ static ssize_t vector_madvise(struct mm_struct *mm, struct iov_iter *iter,
 		.flags = flags,
 	};
 	bool can_skip = flags & PMADV_SKIP_ERRORS;
+	bool set_default = flags & PMADV_SET_FORK_EXEC_DEFAULT;
 	size_t skipped = 0;
 
+	if (set_default && !can_set_default_behavior(behavior))
+		return -EINVAL;
+
 	total_len = iov_iter_count(iter);
 
 	ret = madvise_lock(mm, behavior);
@@ -1931,6 +1969,8 @@ static ssize_t vector_madvise(struct mm_struct *mm, struct iov_iter *iter,
 		if (can_skip && madv_behavior.saw_error) {
 			skipped++;
 			madv_behavior.saw_error = false;
+		} else if (set_default) {
+			set_default_behavior(mm, behavior);
 		}
 
 		iov_iter_advance(iter, iter_iov_len(iter));
@@ -1951,7 +1991,8 @@ static ssize_t vector_madvise(struct mm_struct *mm, struct iov_iter *iter,
 
 static bool check_process_madvise_flags(unsigned int flags)
 {
-	unsigned int mask = PMADV_SKIP_ERRORS | PMADV_NO_ERROR_ON_UNMAPPED;
+	unsigned int mask = PMADV_SKIP_ERRORS | PMADV_NO_ERROR_ON_UNMAPPED |
+		PMADV_SET_FORK_EXEC_DEFAULT;
 
 	if (flags & ~mask)
 		return false;
-- 
2.49.0


