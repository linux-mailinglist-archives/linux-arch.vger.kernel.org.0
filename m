Return-Path: <linux-arch+bounces-14172-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF29BE4BDA
	for <lists+linux-arch@lfdr.de>; Thu, 16 Oct 2025 19:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CBD794F7AD6
	for <lists+linux-arch@lfdr.de>; Thu, 16 Oct 2025 17:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D92B32B985;
	Thu, 16 Oct 2025 16:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DECxqg5L";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nyEGdAZO"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A5A393DD0;
	Thu, 16 Oct 2025 16:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760633869; cv=fail; b=F8nOHN0buZGB67uEAjvxHNMeteOx2ApsXS1SG9N252SwBuM0ApWiRrrW618NMLRUTBhNn1P3vQ6GWHOXgxYvIcaei3dJOkxSG6JsOxkSB4Nx4E7rVPdjhuj4c8Oo73RT2nirJU5/aqFriksdenj9IB23v1Na7Ts2rEEngiQsBFs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760633869; c=relaxed/simple;
	bh=SCzLeIIO4wat7GVbIMIzGql8UgFPKhEUQB+yAK3lFvo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gGEpPJGlhYVRIiNSIQycW/5DSzGaOj7Cqcomfnt4s+dpC3V92R0ul3PRUK9ZWLgssXB6V9Acb8gNiW70cVdeP9SErwc4YDlDDwwhezhhOY++ZLByW2k1NM5dUjtmPF89Q5HjLBaZs32UcGfgOXF8njLL3bIH7tt21EJC+iGC3Pw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DECxqg5L; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nyEGdAZO; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GEVJ82018284;
	Thu, 16 Oct 2025 16:57:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Up5EO7Q/H3J/T2QJR0ORJA0xmY8D/S1Jo038LLhcxMM=; b=
	DECxqg5LFfajFwAUjuOz3l4+XLLOyDHB4g/99ydm/v0agpNrXwUHSEwSc5EW0UmQ
	Wt8X9a90+5NHZ3wtJgkaO5l+OlEtWK5dTIcoKW21CEbc/kWKv2hMsfyw1Fzz6+b5
	pO9Yc2SpviJ0rafRBKwu7O0tRM2y100j8oKSJAQReerDh900M37cb3Fyg34dcIRK
	x/Qk0GjVetsHX9HY8s3z9KBQAWjsw2naX4nXIiujo+QvVAuTCM/XKof2Uy82k9W7
	eg8FFasSe8wAD0ux3G7QJeEPH0bNEktN6wsr5Eg1fBZ+sEN/Qb92zgVgzGZf1MX9
	e8u91itDTuy/3RmATovtaQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49qdtysdty-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Oct 2025 16:57:02 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59GFLvnd024780;
	Thu, 16 Oct 2025 16:57:02 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011003.outbound.protection.outlook.com [40.93.194.3])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49qdpbxq5q-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Oct 2025 16:57:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yzaBFv/6vZ4bivaKhEf+pu1A0ExqzQMgWpomwDjvDxajOgm2dsvnhKoTdrr7bdKhrpOtqhVOk4rguiqMrXODc56aLqdVRbTdFXSL9WUNvxRSkEeLnQiTOl1qx/lCJel8q+QFAm6ti2sibS5acOXTsYpCc2kxW9kSxYx8Ko54E1JP8SJtAkg3xG8hupjgEN4ajykK1g4udN34IF8gfW9eir6oJuSArFj806+tfeUSMRtfmw+z3ZbiPH1pfzI+zTIkZurVXtieMU774XDMWfQRtRLWe2aZMdw5obb9vkQhYrVvxzQKhrMWpo+4lltguIo/bkcljpdPTG6T9oGhEHPBqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Up5EO7Q/H3J/T2QJR0ORJA0xmY8D/S1Jo038LLhcxMM=;
 b=iqfNq6fITPY5h64Yy+08OZjpkoB+4PoABy/Fun7THlwKZcNWZ6v2JZW+SnCeUORm51Q+e3RworpaAXxcIdZZ/Yox/VIY6s+FHfiVjO0ZfwaGrGqGCgIbYlnBsXaj5YTyeOKnBzOTpBhmu7xxMltTiTOKrCAtXqC13mmGFbzXWA10lFPfi7AUog9bmGayks7/fszqkfT+qnLRL5h1yDN1JRpPMpZ90CVXNrdZrxi3NEx+BbqoebmyYgc+Iysa/o9tSMkpwulNz7sJp/1Gb+9WCX0pLWYRIRGQIFlJ8rKOWBoi+zX1s3ACiEdoHf5NnT582jnmqP7ZvfTEMa0iiXm/SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Up5EO7Q/H3J/T2QJR0ORJA0xmY8D/S1Jo038LLhcxMM=;
 b=nyEGdAZOqbuO9SPUlGL6Bh3Q+F3sWPHcUtkDp/xFgAFsYfa6BMMXlHzD3QwnaX8cdkJJq3T9YokoLsLgwrqnPpObZ2Cm3rmKTXKknCjDRDYn6VnhB4R2eycLnARglwykPxGS/VpVF0zBtIGYH7gJyO4SzFruPu/UHzeII/gSl8I=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by IA1PR10MB6898.namprd10.prod.outlook.com (2603:10b6:208:422::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Thu, 16 Oct
 2025 16:56:58 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9228.011; Thu, 16 Oct 2025
 16:56:58 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Cc: arnd@arndb.de, catalin.marinas@arm.com, will@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org, mark.rutland@arm.com,
        harisokn@amazon.com, cl@gentwo.org, ast@kernel.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, memxor@gmail.com, zhenglifeng1@huawei.com,
        xueshuai@linux.alibaba.com, joao.m.martins@oracle.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: [PATCH v6 5/7] atomic: Add atomic_cond_read_*_timeout()
Date: Thu, 16 Oct 2025 09:56:44 -0700
Message-Id: <20251016165646.430267-6-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20251016165646.430267-1-ankur.a.arora@oracle.com>
References: <20251016165646.430267-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0078.namprd03.prod.outlook.com
 (2603:10b6:303:b6::23) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|IA1PR10MB6898:EE_
X-MS-Office365-Filtering-Correlation-Id: 6101fe40-babe-4d01-cf62-08de0cd50419
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bf18/UMWZnxzhUdm/m9ecEH4cD/grCYx+vZCjX5otK4qR73HS4OVLY34nk2y?=
 =?us-ascii?Q?sxWYR0EQJNFHVeRs4V0y6qadoSQW2xLHdKGo1YnW9chCmDwgA+yr61nt199R?=
 =?us-ascii?Q?hwMeN5CilA1t8/wyP2+Y63NEah9yC1zqlDTr66KBb5g75z62Oac1fuKGkXqy?=
 =?us-ascii?Q?ni77SWQa/VIegbaEuEjcK6LCg+Zr7r+EXqxZNU0SASInc/z//kI8Y60EmuWs?=
 =?us-ascii?Q?7rGlza6vJ+9U7rclhUnZJqB348akHg/ey0IsGYZT4hCTlcmvv6Lwh265SwJ1?=
 =?us-ascii?Q?o83p5LJWE5GBSCb0RHZrK/C39DuKLkWR2J/MNKD3mzZkbWmCT2K5T/GVLT+W?=
 =?us-ascii?Q?8Q5EfX7KjFvon3z1gKAyzDdbBPoODVXQx1v3PUan5w+3FVlLtfbFlWD9ysQC?=
 =?us-ascii?Q?pRZDkU8FwgUSwHxc8VnLHTECSIYSbr6nLuorpX7/6bsxoNDjZiPqX+XFR/+x?=
 =?us-ascii?Q?xCC/tEtSzjB6vr9C5TLXqf512rs1nVfCCWNpMSSD5/aJGVGAohJWtuZw5rY3?=
 =?us-ascii?Q?iF7nltNErs1Tj6UOTIPiTopN+T+0HkcCpWlKBCPWigHuCE4WaRsgMzUmK3PT?=
 =?us-ascii?Q?yWhbuuQZgdWWUxPQ4pNqpBgJRZHqF1WEW1zd8cW2JOQeeVz8C43QUy14DsVJ?=
 =?us-ascii?Q?m8A9OhEwe9hnYn3gOMUz0upGeokrcHeWaIamKfDgDTESwJ8RKOFnQ6t4gJ87?=
 =?us-ascii?Q?K9ozQBOqNwYwztyf8vrpI7LoKMZLssFDl0acBMCpFQCt82gY8vRL5Kyvm4dE?=
 =?us-ascii?Q?akNDVioycYqzmZaQOWKF9GKooHjgx7rp2fC2eFg3qIEXObZBuHbhUNQkUrQA?=
 =?us-ascii?Q?1/C4w4/U/gPCdOrq11AkeQMqCVWve58GSchJ2BYcHUSpaSs9sVLuqIhabKBW?=
 =?us-ascii?Q?75pBFIvToQCiu9pmx30qMx7zt3zQzuYgSasHR+8S4QTxR0eCwxOKiQdanaTc?=
 =?us-ascii?Q?Jxn/mhVjzH62l40QLrfQMvu62QUYS5ROhHUeTdVDpx65Nj2lnrCbYof0a5R7?=
 =?us-ascii?Q?Nuq4zFfTLPnKfatMRNjiuIqKwYaFuQQbMTunV7GwyqFabz8+zpWGW4YUcar6?=
 =?us-ascii?Q?gOrVLuzSpIEGuF7oLzhCOMQtIAs87kfp5Zcc/+ZKiVcUNlIO3oz1R6SUjZy5?=
 =?us-ascii?Q?aKsHdanzkv2SfU943TOIFMkQ1X43gouReI5FKqyc6RJdWmdVvVjKw3JvENms?=
 =?us-ascii?Q?99ZQw+y9k6pvKN7tBAnZgNUi/e2/smfrLZlEwMQsmOB03utLvrkethr0S0/H?=
 =?us-ascii?Q?Dnx0Bpg9lPPVgEjnTe0H1+QyUzEGu/vpUswzxxFkRagbhYiySbgZWZNf4qkD?=
 =?us-ascii?Q?wVSQmLP2G5FROiJ3u1Ylo3N3dlPfyKfkWsNlIKfpRNKEK0ib2Wuux6+EfB0A?=
 =?us-ascii?Q?8tvmvzXqlVr22cHNzZF/LqVWmVeQFHaOeDeBpsqMjXs1G5C/WSQtjmVRlmFE?=
 =?us-ascii?Q?gCbQLOj6I6VfkeKxv6I2LuFyJ9j7HTM/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cAF94Djdm48J7OayjYFuoj/k3dK/Hx2NhFpsqnWniZ/C1DtG3Jqps7J5e2Vs?=
 =?us-ascii?Q?84E+dTgV/m0hl6TDHLOk1g6SoXydLlZ7yCD9eHFsrg036qT4BtP+8XvOjuD/?=
 =?us-ascii?Q?iK68Bb2Yj2PDiZI16sHszPAUcOgyYFVydkGYTj+GTPiv1ggdmXmMDdyH68ZW?=
 =?us-ascii?Q?16g90/TSnwRSKOakgT4zADHrqdpI7PuDtGoawZs/hHUKmEVdbpyGNeiWoNyA?=
 =?us-ascii?Q?HlZyfjRcs6n5tX8fyC45vDJT63ThG2ENOedTaexT8FlT3Nul4Pnn3suTf8LQ?=
 =?us-ascii?Q?WbzPFxubPLXSj2mMAYKNn05SB3+74waaYjQ6OUN8PLp7fUTC/heRGSVmO2p5?=
 =?us-ascii?Q?yBcv4FtDDXI1wPksDj/tDpf/eL5np4UExC7iFDZm6uSU4IiH3SWI2TExNoxE?=
 =?us-ascii?Q?Po75rQThlCCdnKY47ijCta2/Ce4WQmdkaFiaLI+AdzXhkAw5/P7MBUWtpV5u?=
 =?us-ascii?Q?ihf6YkySjNibRule5LsoVsX7z2iOsbJgFCdr0RpVLuFyxifON5jJBVopU+6h?=
 =?us-ascii?Q?KZGYoPwRcQdP3uCeAceQ8IODPCcrH+czktjAZ6mtnvsLmkCGGDKt1SC7lo7i?=
 =?us-ascii?Q?AgchtYZLGtLcckH3zOvXDHR8sI5Ba7WSM4suqOFgUdKxJXaU6RTd4z2oZbm7?=
 =?us-ascii?Q?QG3y+stzwH181/cuAU4fRiveW8t5ymENRe8aKt+FHDch0ZZapOAFTohnUons?=
 =?us-ascii?Q?Q7AT79L6++P9ovJfAEreS9KiqM9g/UCB9wZPWbOVrMasLAY2RngtWeWCTb3F?=
 =?us-ascii?Q?2D24wdRHAVf0yRFzXe11cdYkA6Okw/inh1cFMuTBo+OhEB7ihFtcgwyy7tj9?=
 =?us-ascii?Q?0Apll0WFxS6J2Wtd184Rr5XbwOHegA2TV3qzKNpsk+Pl0PPIIWw1GHBrIddI?=
 =?us-ascii?Q?VsGFmgu4qyJMPMLOPlUIg5WAFz5RXS00PnZ3Dl0zKH0UmYAQa0km++/JrNZy?=
 =?us-ascii?Q?PT9TvOY4a1ToR5p2kJb4vL7KI8fQsZyZhFOmW00xQv2r3FApIyFwMjmQyKp+?=
 =?us-ascii?Q?XvE1jTV3bbVFG6JnouWJS4yhpMXG/CjRPK+SIvepGJQ8T9PZY7iSKnqLA3Aw?=
 =?us-ascii?Q?ZcjtgPlTj/StBhlG+GIp+vCb18rHQgG3U4dm50nnD4/fcS/uAnnjoPZrlZzo?=
 =?us-ascii?Q?JrwGtdQWtPRnfGp6hz85cFdXrYFXe3OPz/Y9npTy38I3KI/cKuMTKsRHK1fv?=
 =?us-ascii?Q?sxrCA4YPLRW23GNVZ8m0fXzwQ2t1FJppVSEbXoh5+QHgPW2PcQ3cjyeHYqXV?=
 =?us-ascii?Q?PwntwBqlm8ImxCtgsEDoBDGqUk4cRUPpWB4psrFetsLUPoETObzYXn5gz+W+?=
 =?us-ascii?Q?OY6qNTVUREqa8th9DN+20mUscrlZZ2qGhVkkQeJJalBPd6Tcc9tEkXkvB4v9?=
 =?us-ascii?Q?251b7QxUTiTUXlRDvDzsghM6kXMQVKikCQSGzb8WxPCmGz3WkiBctQocjKlo?=
 =?us-ascii?Q?8A/Qjf1aWmWV+eiiN9Hm53IelEwC3tUCOGwxDPiauhvg39rNNlPblWzMu+dT?=
 =?us-ascii?Q?U4KyUYhXtxmEggccjpzHM8ya/LH7vt4q92XOPywjWVCbsg6hVYf3S2KunnxU?=
 =?us-ascii?Q?3Qu3KY4j2G6N/M1ciVksdN7FodzxW6ARs1OfM+Vf4kwvyw2Vqa4jNWz3XZCR?=
 =?us-ascii?Q?yQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vSeQx8cepA7noEtceLp2Gj9skAObxCNDRMQYFPIEMEt8IkfXNp3mcnFj2B3o4/56Exth/Aa3Ulyoe2DVfSRslrkKUTkkm2VG1YMaigPGJjMsours8GCWZkdT9Pdn5Uh6obbn/iVOf/402qIyKHdOh31wt6LoDUKEqmMSemB+kkAG46rZVJVLVXt0mg+jmTRpGYL2SKUwq2RVik/CH50kJf+PFUywDQeo/CXq8GhJTrwYsy6bULbIKGUSsgtOCOiUtL/C3DoSI5pmeLB0UqJMf7PecOq0c7CBntbl0nhohkWr9u9/dWS6FOU6oDYBe+qrOAPnqWOTh/0PHHPNVQl9sqRU5+GtLegsCXm6RnX0ZLcYIhhcngpY3V7qaek6EvuoiJeuOTwSioi0/HDovauvh8GLuEAKk6KuKvMJ5n1l78+DtchQoO3F0TJzD0JG5TYEnbxjDHleVB/9UCP6MVXdv2d/PPRyT71fF2Gx2M6DvfLnGYIINqB1G73wzjKlzrX6Tmp3OsIUF49VIjbT1DwxGnOBTmaCp4n731OgIdPhIiGiOMdPgaFbux6jxxNAL7NNXLzOWQD7t7F8JsLeA2jRQagiwz+VNjrGwUeGdd06pyY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6101fe40-babe-4d01-cf62-08de0cd50419
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 16:56:57.0887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lgzUjsATBHIHyJr06okhP0n1ck6PceYoM0eFl79x33CEHfXIpDVcRAIyBKjBrf1PK3WZ2hgrMCwecKAL95nv2j5qLtyq4wuBpXND1FK3+VU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6898
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510160122
X-Proofpoint-GUID: qEmuulfgMqhAHdH9mL_VmbV_yGyCJ81L
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAwNyBTYWx0ZWRfXxG0S3DvWfVdj
 G+YHUuOg7VzS3d1xo8g6NVFPrI5n2zRADZg1GC1wr0693MKWfq2O5ER5uN8MRJ2vYWF46C0KVtj
 8NRoVkVpobIAgzvG+fK7Wd6clI9+OHzKGJmCCBHQN+idwExK3pswHcf46c4CClolZSNOjGi4iKL
 DeCen9zlc37gRwzqKIV95CsMuL32UWFI5sjbx5shSBial4nEk2cn5PynQbeF2+5jWmP/GiMiSC0
 eIliaF24UeNAneOcEdyizmEBwrRcO2Ool41Khh0Jw2w58ZbA/+mgPQnZ8mGWY6MlmfIz6u11/+p
 p7NM8yI/RnFqGoBlxA1mRYSF6ddnd0ndnEJZPK4PxAthOYWzc9HzvIqzMi7rkG/LBRUjbcRSt4P
 r3pGw1Amdv0VKw6/5Outf0oChg5Xmg==
X-Authority-Analysis: v=2.4 cv=OolCCi/t c=1 sm=1 tr=0 ts=68f123de b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8
 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8 a=o8YiuW5Vmrb3MwBtM-AA:9
 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-ORIG-GUID: qEmuulfgMqhAHdH9mL_VmbV_yGyCJ81L

Add atomic_cond_read_*_timeout() and, atomic64_cond_read_*_timeout(),
to provide atomic load wrappers around the cond-load timeout interfaces.

Cc: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 include/linux/atomic.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/atomic.h b/include/linux/atomic.h
index 8dd57c3a99e9..b3f77a89e9e1 100644
--- a/include/linux/atomic.h
+++ b/include/linux/atomic.h
@@ -31,6 +31,14 @@
 #define atomic64_cond_read_acquire(v, c) smp_cond_load_acquire(&(v)->counter, (c))
 #define atomic64_cond_read_relaxed(v, c) smp_cond_load_relaxed(&(v)->counter, (c))
 
+#define atomic_cond_read_acquire_timeout(v, c, t) \
+	smp_cond_load_acquire_timeout(&(v)->counter, (c), (t))
+#define atomic_cond_read_relaxed_timeout(v, c, t) \
+	smp_cond_load_relaxed_timeout(&(v)->counter, (c), (t))
+
+#define atomic64_cond_read_acquire_timeout(v, c) smp_cond_load_acquire_timeout(&(v)->counter, (c))
+#define atomic64_cond_read_relaxed_timeout(v, c) smp_cond_load_relaxed_timeout(&(v)->counter, (c))
+
 /*
  * The idea here is to build acquire/release variants by adding explicit
  * barriers on top of the relaxed variant. In the case where the relaxed
-- 
2.43.5


