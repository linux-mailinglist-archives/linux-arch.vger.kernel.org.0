Return-Path: <linux-arch+bounces-15516-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AAC0CCF8F0
	for <lists+linux-arch@lfdr.de>; Fri, 19 Dec 2025 12:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3E66330065A3
	for <lists+linux-arch@lfdr.de>; Fri, 19 Dec 2025 11:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB2930216D;
	Fri, 19 Dec 2025 11:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="agc/vUYJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="a4UFgDio"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A4F2FFF9C;
	Fri, 19 Dec 2025 11:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766143322; cv=fail; b=gJr7AwQ2pSLB3yykGJLhZwwJ/1aYJ5dX0VyPS7qhum0ba20ifxFuguhMg635JeFJLbkS1OjaRp9sszU2NT/kWqk4NlirWe7oZk0z4rcbI5T0TFTCArmHejIlYXeaoQ2ddhR8P0WsU9hq2dyciS2dy8FLYTXWm0wCJAaC3cjt4LY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766143322; c=relaxed/simple;
	bh=uUPY++q04+AqAbnrMdk96Zkoz09KHTUcejxrQXVCXEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AO7ebkW/ZqPPKiWZyRNR4e3ucBxey5tEf2AILmUwDLeyDoePfznBdXZmGPU0/qaiK5NOaocfXOvREHLOYog7b0lwK0R+6xk40o/+0Egc3+ALsMq3dmBw5pES9NfIzsJvpH6a+qY5H8sPJ6/BxOGFtNgw7Uxkkjlq3ccWC+SR1Xo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=agc/vUYJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=a4UFgDio; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BJ4m61k2997525;
	Fri, 19 Dec 2025 11:21:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=+XfWf6FKdLeykryPGI
	Y51JQx9P1T9MMQxqjG+IcUX2s=; b=agc/vUYJmzGwOWK5RpBf6OK4TAXnQuyChn
	fWL7v60B4gWxXSfIpjAzK2Cp3Dwx5PeZfnW3PDPkhMAEVLzAe0rhMlyZg0k8leru
	qZ+pyZ35b7VdpsTZumMJdMPbrTQZQOT6iEmuJe6fuRLJj2xYQePmeaoKvv6tJZfZ
	X/EFpLNREUsOgT5RIoBG30WIYjMMJw5zR19rjCuyjPJXHeFMOX9l2jm1mCQTxWxK
	Cc/tC6i26iZh8LdkVPJpTYkkwIqaXEnRwunnvN86lJgdbmwLr2urfhlK21hpHV5y
	9zB4sxioYcAEleF2hENjNZ9sOQPdsL6R41kpVxuSTfdYfoiRXJrA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b4r290ym4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Dec 2025 11:21:00 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BJ9VMnK035621;
	Fri, 19 Dec 2025 11:20:59 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013055.outbound.protection.outlook.com [40.93.196.55])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4b4qtsjg5d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Dec 2025 11:20:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IQbKXUdhONNKgjM3WPfAfvrDwPA1urgRcxtFaCRO2A9IXaJ+Hm6NDqjlr9dQacP8hTqVhAzFG30313p916b5TCZ0eARXglNnhVYX7hwkaONgBCzYHJarCwYQTtXy/BHPrjoOJPe/Te4kceRPpnlPL3lH0vorGX+BTwK63dfawTEnod/RQEyELhOaR0TdQ9skHbPJdtvo/5QRhwjtNJTiykblsQRYZwrglL1F1GjGVRj5/dXDH5Zv3IF4hudRfCcgF/oithhJ4eXjFaRgF01WX11o3nsT+AfStzi8MRo4m0za4Lv700wZXshf833yHxi/+a3rG8fUFlYreOlNeZ0NpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+XfWf6FKdLeykryPGIY51JQx9P1T9MMQxqjG+IcUX2s=;
 b=Or+v2ZcSZVHHIJhVPL9edTeFpd561m1pp7tg7T9h5EmbPc2XJqEPJLOOlasIEONMk0SHmTjUq0svjHTywWuih4nOtbLcmrF+3SLw58DLoCtGr66BxzHWX2q7pUvUajzsaGjGrEs860sudo9x/+wPEU/bv6dGW0OzbLSYWCh0EdXunGWlAfBve0jVMwwqlB3cajNzihVWE9NBhx05mKZyG+E/2rIuwxHvJGTjLrEleHIndab/P92DtNCAaZuUXWO9wTS621Si4VbfMXG+Z7vQt27PF4Eo5a9ARkp8tH2/L/KTGxQ17i0MNWZnoo61ZHYBrbpHgmaAfojBtrShf4OTyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+XfWf6FKdLeykryPGIY51JQx9P1T9MMQxqjG+IcUX2s=;
 b=a4UFgDioUR+Y2SuFp1F7DveGQqveY2/Z+WjOEqONzU8dTOeZl2PjFSneMX/Vt8sCPSrgLVtR/KgNgGAqWtZh44dFIaM6hayn+4CBOH2cbzaJb5I17CUDDPXLzIYpaz8RNX66JyOfBoP/sp/WXX8XqQCX2DJdlPujW3cBAvr4Qp8=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by PH3PPFAEC321F49.namprd10.prod.outlook.com (2603:10b6:518:1::7be) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.9; Fri, 19 Dec
 2025 11:20:56 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9434.001; Fri, 19 Dec 2025
 11:20:56 +0000
Date: Fri, 19 Dec 2025 20:20:45 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, Will Deacon <will@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>,
        Laurence Oberman <loberman@redhat.com>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>, Liu Shixin <liushixin2@huawei.com>
Subject: Re: [PATCH v2 2/4] mm/hugetlb: fix two comments related to
 huge_pmd_unshare()
Message-ID: <aUU1DY4206FibsLf@hyeyoo>
References: <20251212071019.471146-1-david@kernel.org>
 <20251212071019.471146-3-david@kernel.org>
 <aUTYE9fHf5Fq3eHa@hyeyoo>
 <506fef86-5c3b-490e-94f9-2eb6c9c47834@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <506fef86-5c3b-490e-94f9-2eb6c9c47834@kernel.org>
X-ClientProxiedBy: SE2P216CA0156.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c1::16) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|PH3PPFAEC321F49:EE_
X-MS-Office365-Filtering-Correlation-Id: c0f71098-20cc-4591-c48b-08de3ef0adcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xjT9sTPoYbaPh441kMxjnCNZHlFWaQp4bMk089J3I7uzkUgV50cxzR0Jr0Wl?=
 =?us-ascii?Q?mKpqP3Q69+piNGKph8awbOWla4lzMiD2pVkfsXTEPzZh1pYfaT5tcYETclZ0?=
 =?us-ascii?Q?51JvrXpHBzJJFvzYFG/uy/4xSkx8Uzl3bJYTGJMRIuhWr8JPM6uxrwnU8Tay?=
 =?us-ascii?Q?QxeKACkAsiDEwvYV+CWqGfWigMzwu+LZWMYRE9JAku925T9JuSsGajHHlsTr?=
 =?us-ascii?Q?91eqyi19NAF46572dWbuXu1SoeOLWNXTKO/STkegftb00OjAP/Gu0rl+6FOB?=
 =?us-ascii?Q?tmBXEeBkjnxp9G9iVrRUe2ztVWgl8EMANTtDqZX/iy8zOtIV0n+Rq17vwkey?=
 =?us-ascii?Q?vyJpNm2e1K5cySPDme9EHUW2JwZjAYBs67PAjjSBkd9btg6XaHl9HwSC+0wk?=
 =?us-ascii?Q?gnJghRT4dpzqLN/cHKJrRHWlCnq+Iejw/40E2rJ+e95xjVx8YXOy5WPdSzDa?=
 =?us-ascii?Q?T8T8dBaE+zh/LW220d/6GzkJNywVADN8ryPWysdSY6c38HX7XAiFPnybAhb9?=
 =?us-ascii?Q?IGJNcPmfucZ8s7A/sBw+/vMdjZbg/ACPpgqzdf9hcXx03xZVN4k8/PFFDUeW?=
 =?us-ascii?Q?dzHl4xbFMlxeGCuQ3ORYgG+ttzL3aKKdfloyatISlfOvb1K9xZMBWMHiD+C0?=
 =?us-ascii?Q?OkEtgkoFR7J6uXJR4x5zEJg8MMVAU+3Vml579uor2LqpPKkz0q+Rk9EPSEiM?=
 =?us-ascii?Q?vbLGwEogzEe/2tMk3YwbMcWENtSApMmRkmqQZLyFl7mi2D1kFdsS7yagbKTB?=
 =?us-ascii?Q?cPYsziAIQWtApUgudezJ5eoDq7HBwVtjUicTD/lyO1Las/ZAARUU4E7r2Ux5?=
 =?us-ascii?Q?Bjk9KrOhAxqNk5sbBaiprhwWx4QjRGch7Wav2T69hbqMIQaG98GpuUkNvQX3?=
 =?us-ascii?Q?1YuRb9QfZU7Nka71ufVGlQP03/OUQT3V7zsnY5NKDDgh2YZ2uSx5zcEa4V7z?=
 =?us-ascii?Q?YlcZdvwE/dyrDSTsb3n/m8rqcpfKsku6QlXaXG3AWzrs5ZhPIrCIJ0SDJKVl?=
 =?us-ascii?Q?u8EhNhPr9c1BXjFEO2yqDCyqAtfu/YVqyebLgEPJCHUPvDijvMOdlW2PZrWp?=
 =?us-ascii?Q?052ovdXrUmJ//AFuwuxa4OT4Re2w91edhXRMp4aMAK5znoh23UZ8bdVd89xD?=
 =?us-ascii?Q?DyUcYpIwys8Eo45hfMWWnCQtD3IuyskiZdBY1wx5mxt46KQsS+4LTXegC+bc?=
 =?us-ascii?Q?8VTMZ6N/6lDABtdo0pX68EpuP6uBCcjv59m2KE6m0BELQB1TBZNNPJ/uRzua?=
 =?us-ascii?Q?UxApxcVT9XZ2+NcsjR+V/VviA/etXTqhuU4Aela52+AuRPUyP6OrEj1Upf+k?=
 =?us-ascii?Q?XgPqaAvtQQ8+JTMv2ulScUBEYpykMAx9jLykHXeeS+AwKYafJaENJ0AS37PZ?=
 =?us-ascii?Q?pomifEz6PgHBpB5yl6sIWAOAFx2QM01VxlWTa0O3i4cReamevwYGnQa/RZ9l?=
 =?us-ascii?Q?63QJhEYemdW0xMa7dvk1r1gHd/+W3TQZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fwfRAYqswjY3vPFxaEN3qwyImLvp2cZVl8S3B4M5NODf/qEN7lsQm8D+LS1m?=
 =?us-ascii?Q?90saUypy+QyRUHfAd9CyhqPR7A06oSsJiU+Nz8EHf3zlB37M3XnbQszEmvoY?=
 =?us-ascii?Q?bJqJIqAqrbByWSMQcJHpTs7diSAueJV4jqjflRvFYf7hwWX7jvliFqppc3Yt?=
 =?us-ascii?Q?+fMnA3Ot13VU/G2HvgBBkrWGekcX8KjtSD4qxXyXYn7+T87iOBiZDKqqEPAN?=
 =?us-ascii?Q?ZaDfTFnB066OQi9uM3NxhY+8a8x9rzmm58ADF3w4rHiXpjSvWi+h4oS7Zd/V?=
 =?us-ascii?Q?eTjqV0LvUHKXP98nBc+8L4MkNFQKk3x6Gx3pRIQN+P7bhmGVRk18+LqtDyLo?=
 =?us-ascii?Q?cfB4qHup54aNr6Dwk1f4/YWWoHM0uzgj4S8I2JsFcat22Dr2RMLzi0FEY0Lh?=
 =?us-ascii?Q?4lLrE7v01mVdILkWwL+NCR4cKH6xROBp450x2f1FQqO6x8INeO0apwOgcFHM?=
 =?us-ascii?Q?H9XX/iR8ORkMusWkHpZCkKzsA6zlHUDNhWOc51YRZd1xdZiEZDUCqcTgDCdO?=
 =?us-ascii?Q?HpdYZhRxNOtoBJpIsldMjxJTensKAVgB77Jy6eD2ag8+flWjMd5iVf4P/AeJ?=
 =?us-ascii?Q?zrZlmDYOP0k/3V8G/UyPDFrIjVEsdP1pZnjgh+giWpluF8+wdjAh8ayvM5my?=
 =?us-ascii?Q?ReDy4aHHcxlz0kBFONFQj3WzkgQChezZ9VB8A4ROtE9eNFeRJE0g+RdnwY/W?=
 =?us-ascii?Q?HV8WEnn3SNpZAEQZY7Ps7zqGCxiFy5K5e00JVEqcb2risXDt96daO805aK5q?=
 =?us-ascii?Q?qmlxk8AWKN6sFQO/32s1yagU2MGyJSUlANIbifxZmG5ZAc4fJagQr4tVcVlp?=
 =?us-ascii?Q?7xVkpscYIg+mZLjVLhuKTHilah5HRn58epOCVgYIQKWgmjhGTMBp8y6vfLsj?=
 =?us-ascii?Q?vL2VDhjMrpGrz1hcrb0s9mXk/nSqYU8SMuh+SU+rNYEBQdpPzQAU+/8oJNmo?=
 =?us-ascii?Q?Km5XEY7GaCp22KAmNUxs5Z631Apj2FpKnWY3AlAWiQ2KPNYAhgXfvdGrxKnY?=
 =?us-ascii?Q?fj6qJlBRqYqLwOfx1ew998qfx0a7TLAFEPnAGrVOO21yLnpQl5uIXI9KL8of?=
 =?us-ascii?Q?jMCMB9VtayjcGYlUGvKaPZt5KWMbstDaWQJWDp2r+5VkSgIV9xE+oBelcyBc?=
 =?us-ascii?Q?gbbU6q43Rc6aCx7Bp7JeM94vdyrMeNpiCpnHnQV0uSqf3JW8pUnzfqfifiUU?=
 =?us-ascii?Q?ZzvKaDy0YbBa86tsoBQWsVKpFcknRWlWLvgeScuzAZONSWtiRRtRL3F9+Aah?=
 =?us-ascii?Q?eZMnMiwXkXJV2HWTbMfvrNoqjsq9BFfThDNwp1NHRdWq0OqiqTjqZeZGzhxC?=
 =?us-ascii?Q?HPk/BTpn0gsf1ej/OZYeGP2hRE1/rWHujX87Lz+TDEo27Hxx7b7yF3Ebk0p/?=
 =?us-ascii?Q?i/LofJ9BCB5mIwGo5faa4nYfyEbcEZWx3nP2hQvHh9eyJK9FtvQUUXejxFO4?=
 =?us-ascii?Q?hidQEFFJ+IecSWra8tTnNaydixZHV/ixxMy97nbcYtU6FafQb6W5XwYpMHcV?=
 =?us-ascii?Q?PJUhorSdn6k4MoVlGCAQYJovrgOStUnA8Tk7TJQn5hyT/KNPZY2WIpD90BKo?=
 =?us-ascii?Q?Tx8lDOi47lo6h9TQFVW6iZ4nfhXvGsvUfZgMOR9v?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	46B1FcesYxvXaKx2gyTszAGnst425dvArbtVj5Cra2ZVo4z3J83Jb7pdc0YJmfKsFgz4XjdjwJvRv19dl9C65JBtANN9sLunVy4QVb++GhII0A81ke3ws1vaGqqqTVokcY0XXtbKA3VPrBZu1jz2nonAwjURWVOk4Q9Zo9xGEYMfnz4Vgp7sfu7OQqRubK2g5Ik16FrcGkIb7AYACvVx6k+l/ebxQiLzQ6DRrjCRL49aeiuNzso7IY32zq3wp7nXE2rfEdS3lI3yHfNyufDyO2XrRKodTAEJ5XRnyCpxm81aCVLT6NHSGN+l2bGnx0BGU56y8BUjFifaf1uetpZaogu1ePWmaDmoX/+XcwQ7wK22Ex2atL+3cHR9ghyVM09lxo7SKIBVRlIDGjWB/Ngo6g7R9M6/1t7abEuPPbAgm/qLf7hxLO1zBFgMFzn+E2kB67fQDcZg05WLzBqQrVoZiuZdPtnrRqOQzqfwm6wJ1/0F0eKHvo/reijR5fEfB78ZT2JATJzGjOcWxQHPN/UoYuVvQESVH9k+Ije+biu8nHJm3ojjR58X1P1pQxkKyNkrQIQzqQKVgoxrVAW9NM23ehLZTix7DQYh35vr8EctBsI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0f71098-20cc-4591-c48b-08de3ef0adcb
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2025 11:20:56.4081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O6F6OE1sapWcWrHB2O9lb+xOAty/f5g1SY/ChbJc08mlc2li2Bh4M37gR10UxEgDNpk/Du67oTp3bWYtsEWYCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFAEC321F49
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-19_03,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2512190093
X-Authority-Analysis: v=2.4 cv=WZgBqkhX c=1 sm=1 tr=0 ts=6945351c b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=fwyzoN0nAAAA:8 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=i0EeH86SAAAA:8
 a=VwQbUJbxAAAA:8 a=F77qi8yhoWA2iRx2qmUA:9 a=CjuIK1q_8ugA:10
 a=Sc3RvPAMVtkGz6dGeUiH:22 cc=ntf awl=host:12110
X-Proofpoint-ORIG-GUID: SDv4MouWo3TR3J9wvY56hiKvrB2ByLYJ
X-Proofpoint-GUID: SDv4MouWo3TR3J9wvY56hiKvrB2ByLYJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE5MDA5NCBTYWx0ZWRfX+1iKGbonFlUT
 jacZk0agKva5qwTUfR6VxXg5rmjr9VBBWCrQZY106/1g/BgvrQzyUII5vmrovlQFat2wsYnMbue
 FLKFgSvawZEHLMK0oB4mjPmNDK0oNn21taKKutK3LNR91XVkAR1moGjAA3GTCAmQ+6kPNE7wXi9
 fUPtviatbMVrpXKIIdRKZY3LDAzAD5YFFTHXrprBJW8kmeSbGUBGzoYRBbrH6gCwtiz1UZc+NzN
 6XdtdOUjlp9cs8mZ2dRzCpo/ySVQqSxslLe+w9KP9RJgpSluGDltx7GJjNtT1zJ1qiD77gy1glY
 x7oKvPH9Cbp5YTYg2KH74Cdll2SASZWFd1jLmrVvwfjzJN0ryJ+0ZJREA6fIs+dsbCOClSkbwJw
 udFkLhCmR54SYgG86Jz4RFf63xDMmWnyzIi4l1BuKujEGhMg12/v/gi5yo7nFYyDECxtDK9i3I7
 2X/bMi9pzGal47vB5vExAL1x47Fx3PTQIdy0woQg=

On Fri, Dec 19, 2025 at 07:11:00AM +0100, David Hildenbrand (Red Hat) wrote:
> On 12/19/25 05:44, Harry Yoo wrote:
> > On Fri, Dec 12, 2025 at 08:10:17AM +0100, David Hildenbrand (Red Hat) wrote:
> > > Ever since we stopped using the page count to detect shared PMD
> > > page tables, these comments are outdated.
> > > 
> > > The only reason we have to flush the TLB early is because once we drop
> > > the i_mmap_rwsem, the previously shared page table could get freed (to
> > > then get reallocated and used for other purpose). So we really have to
> > > flush the TLB before that could happen.
> > > 
> > > So let's simplify the comments a bit.
> > > 
> > > The "If we unshared PMDs, the TLB flush was not recorded in mmu_gather."
> > > part introduced as in commit a4a118f2eead ("hugetlbfs: flush TLBs
> > > correctly after huge_pmd_unshare") was confusing: sure it is recorded
> > > in the mmu_gather, otherwise tlb_flush_mmu_tlbonly() wouldn't do
> > > anything. So let's drop that comment while at it as well.
> > > 
> > > We'll centralize these comments in a single helper as we rework the code
> > > next.
> > > 
> > > Fixes: 59d9094df3d7 ("mm: hugetlb: independent PMD page table shared count")
> > > Reviewed-by: Rik van Riel <riel@surriel.com>
> > > Tested-by: Laurence Oberman <loberman@redhat.com>
> > > Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > > Acked-by: Oscar Salvador <osalvador@suse.de>
> > > Cc: Liu Shixin <liushixin2@huawei.com>
> > > Signed-off-by: David Hildenbrand (Red Hat) <david@kernel.org>
> > > ---
> > 
> > Looks good to me,
> > Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
> > 
> > with a question below.
> 
> Hi Harry,
> 
> thanks for the review!

No problem!
I would love to review more, as long as my time & ability allows ;)

> > >   mm/hugetlb.c | 24 ++++++++----------------
> > >   1 file changed, 8 insertions(+), 16 deletions(-)
> > > 
> > > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > > index 51273baec9e5d..3c77cdef12a32 100644
> > > --- a/mm/hugetlb.c
> > > +++ b/mm/hugetlb.c
> > > @@ -5304,17 +5304,10 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
> > >   	tlb_end_vma(tlb, vma);
> > >   	/*
> > > -	 * If we unshared PMDs, the TLB flush was not recorded in mmu_gather. We
> > > -	 * could defer the flush until now, since by holding i_mmap_rwsem we
> > > -	 * guaranteed that the last reference would not be dropped. But we must
> > > -	 * do the flushing before we return, as otherwise i_mmap_rwsem will be
> > > -	 * dropped and the last reference to the shared PMDs page might be
> > > -	 * dropped as well.
> > > -	 *
> > > -	 * In theory we could defer the freeing of the PMD pages as well, but
> > > -	 * huge_pmd_unshare() relies on the exact page_count for the PMD page to
> > > -	 * detect sharing, so we cannot defer the release of the page either.
> > > -	 * Instead, do flush now.
> > 
> > Does this mean we can now try defer-freeing of these page tables,
> > and if so, would it be worth it?
> 
> There is one very tricky thing:
> 
> Whoever is the last owner of a (previously) shared page table must unmap any
> contained pages (adjust mapcount/ref, sync a/d bit, ...).

Right.

> So it's not just a matter of deferring the freeing, because these page tables
> will still contain content.

I was (and maybe still) bit confused while reading the old comment as
it implied (or maybe I just misread) that by deferring freeing of page tables
we don't have to flush TLB in __unmap_hugepage_range() and can flush later
instead.

> I first tried to never allow for reuse of shared page tables, but precisely
> that resulted in most headakes.

I see your pain there...

> So I don't see an easy way to achieve that (and I'm also not sure if we want
> to add any further complexity to this).

Fair enough.

Thanks for answering!

> -- 
> Cheers
> 
> David

-- 
Cheers,
Harry / Hyeonggon

