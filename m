Return-Path: <linux-arch+bounces-15730-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B796D0BF9D
	for <lists+linux-arch@lfdr.de>; Fri, 09 Jan 2026 19:58:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 195543009C0F
	for <lists+linux-arch@lfdr.de>; Fri,  9 Jan 2026 18:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B3D2D3738;
	Fri,  9 Jan 2026 18:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KOek/FQK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="u9oOh9y0"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA3929B77E;
	Fri,  9 Jan 2026 18:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767985079; cv=fail; b=WqLTliNjKD3cvLxYj2vCbyCjgXly1SypbSHvMSBHNmaubRi4VwTrA4dS29ay5WVFiPHQ+x3uNPjOGuBWuwybioPhvaF9HV2QR1h6Q/0Phg9uA2HsP9PNsjSmOKUiuwBEnys/k4IjmnuW+SmbpBz9tmANNvYIsHf/ps/O9IML2c8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767985079; c=relaxed/simple;
	bh=jGDXX0feLg/mXWtCLlM0H4bVUE8Vs1o2USLiEyEqghs=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=KW9wtgjfsOAH9PVBpLsCMUY/UL7dz6jtXY3MwLNzeyPcqZX/oYHm+eb9Ky0oYlDo88FuwWr2ha+d5aAN5yG/Xp9lJQjaOljJiC2BVndmLLXJ4Qhq53z5FFUOO741cKlv8nIMpyd/Hi65PzT8Pc4mllVoI9IB0ZHjmjvPFQktgDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KOek/FQK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=u9oOh9y0; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 609IB3iZ3621350;
	Fri, 9 Jan 2026 18:57:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=8Qg5DY9uFzu9o+WqH1
	/gZ9N6LYvAFFePcEr09QWguuY=; b=KOek/FQKc5lCEeJ1VZfY8N/Y+ikww/KZYN
	K0kU5H280KCZZtEwgFVzGi86kkkzBHGVLD2INtIjgy8y8j8GFYCUimSdWKVOHi9M
	hPVEWWzwwxXnNF+hy5GgCtC//idDrAyMGp3hcROfOoE5rt1jh2Y/BrotKC+HEGcF
	qbbtsY3YKlQcp9703+GHU+Bsgtnj2toc4bL1SMTWLxh3FxLTLCaMJM/2trsJpgf1
	nXEZHa823X9smkBZWb8vEGfJ5iM9S1VZQNz78ctwcUAjcmapddLpYbjBZdRjZjjg
	8K+S1jSbhydXki9Dgbk6DCh8eNfoa4W4h+rt6ABFV4UqmUNTuCJg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bk6qm825e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Jan 2026 18:57:22 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 609I1GnA015397;
	Fri, 9 Jan 2026 18:55:23 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011009.outbound.protection.outlook.com [40.93.194.9])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4besjces79-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Jan 2026 18:55:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A+hqNdNyH4bZgYzCltksRTjSzwwIW960lPkKg0F7Hh1ayrILIqD0WMJqvoTuDq67qRnZMauurXlJUQbCr8yevttkrBTKvVfiXNhbb9bmBiP2ADr8xP0lbhAkXdr0UxIL2ygWsIIP2hOiamrG8NXN2mhlXvhyBUbjohz5HmzE+/SQ8PuODTIRRqJM2z24tZkfzj1cfd4KNhdOH83K64oCAVHx8EOuJv5NBo42obGNthQ+F3b7jFWv702F0Kc4ZNn1SC/gD2FCOgeBnFkCIdrHwElhhBpbHdNTx2RSgFgruY7eKmvTQQM9Kb07CjoFE46HaFEs5cTkRncMWmPVABF94g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Qg5DY9uFzu9o+WqH1/gZ9N6LYvAFFePcEr09QWguuY=;
 b=oMwGzDJHL6dc+MEcrXHNZXDXXeiPUktqnbdjKMdms/J0Cnq2UfDT7uohb132nSGBe/a+/5S8j3SpD+pMaqIXNQh+8AMSMQvx34p1fJJlQ8e4x0SBH2GDTBXpCQ8Yp9SNzAkS8EvHmixBc/hyY2tWuNPFNDHlf0dnY6Q/6+31lny5XeoeA5N7fMvxJg72ct5elUbdjGrwm7KUwLOHvB0kxua0tOBmO/bcXTvs6isLz9SJtgYItubkSwaInw2Tk9GkzFa55V5fRe0sELsVC1pTvitvCnDVbsgrmmSb+vYKGBUYOKiIArJi1fDxY0OpcDQ+yAwkAL9q4VAEbtCuWghEhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Qg5DY9uFzu9o+WqH1/gZ9N6LYvAFFePcEr09QWguuY=;
 b=u9oOh9y0nSORpv54av7ZCodPotn0Bhqy/Tt+B59UqkT8zPZJqBMJyEx0OICj2uytS/A1Xas33h4a4Bhz6JN1PN4C+zETVkw4G+LoOLrSbhu0DPxlOc3Tejkb4/ZW7x6GgIEqSrxqRLgJRC3ex+VZ8+1onbSjA1f34VEdZuYJ3Zs=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by IA4PR10MB8686.namprd10.prod.outlook.com (2603:10b6:208:56f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.5; Fri, 9 Jan
 2026 18:55:20 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9499.003; Fri, 9 Jan 2026
 18:55:19 +0000
References: <20251215044919.460086-1-ankur.a.arora@oracle.com>
 <20251215044919.460086-5-ankur.a.arora@oracle.com>
 <aWAjMbSqN2g7v58Z@willie-the-truck> <874iovp34a.fsf@oracle.com>
 <aWENsQywXuM880_l@willie-the-truck>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Will Deacon <will@kernel.org>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, bpf@vger.kernel.org, arnd@arndb.de,
        catalin.marinas@arm.com, peterz@infradead.org,
        akpm@linux-foundation.org, mark.rutland@arm.com, harisokn@amazon.com,
        cl@gentwo.org, ast@kernel.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, memxor@gmail.com, zhenglifeng1@huawei.com,
        xueshuai@linux.alibaba.com, joao.m.martins@oracle.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH v8 04/12] arm64: support WFET in smp_cond_relaxed_timeout()
In-reply-to: <aWENsQywXuM880_l@willie-the-truck>
Date: Fri, 09 Jan 2026 10:55:18 -0800
Message-ID: <87y0m6mx9l.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0133.namprd04.prod.outlook.com
 (2603:10b6:303:84::18) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|IA4PR10MB8686:EE_
X-MS-Office365-Filtering-Correlation-Id: 40c09037-ce9b-4d80-6314-08de4fb0a2a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?i1aGq6kX+LHs+M8DvrsHwOSOrR8joZW+MTd8gBrb+4CLa7cXa4UWkcOGJMxo?=
 =?us-ascii?Q?vufMG92ot/suzWaM1kTVhoGROoMLZllJGLNR/0B37ZTFdnmcMoahY1Or5iFO?=
 =?us-ascii?Q?VZ71t4liymZT208jNuTuO6we096QM7Bnzhgj/Z0cox54pxRsfdBAsxWemrgW?=
 =?us-ascii?Q?OyUcRuBTQkr1gsqZ3n6Hq0sv+H6vp2DEmCMHukUOeZ+DgrUgrFTgA6IHLjdv?=
 =?us-ascii?Q?zzEwAfB8TGdNm+39XLESGtLp9olUhr5KETjSg+ywPwBkoELu2PdILohbbBqk?=
 =?us-ascii?Q?QHIoqd+jW421opVBmfOFkNVj76HLxwCSltvza/8HY4tTTAoRLeC4t6KFtiAE?=
 =?us-ascii?Q?jpraHAV0T3veWCXBLtUpWjBZ0fITNTISD0mVpw011IgtUiCjCwJOxi2WZyf8?=
 =?us-ascii?Q?Wm2uSct6d+ylGKLgpNaMq7vcixONRusLENtLXl34GSZLJJr6mcH6BRRjzZyQ?=
 =?us-ascii?Q?CTEhFPrSkTiyHxeAUPSlhDyrsFQcchQs1137V/xnlVhmGLksQJq+T14nt1kY?=
 =?us-ascii?Q?vUM9N66BqgAtR+i/1aSqeyQfJ2B8Ivq08g+85MLJWPPNVEw4pwYh2wpCq31x?=
 =?us-ascii?Q?1+EDRKX5OQYLyfE+3LxsuFRBIBtgJgnrr5n1Nu3vkTD+rMxr9QJsdEfTuJXe?=
 =?us-ascii?Q?OoXowkKl0sizUsp0hkjKVmQAI3FSGWB5srAF0JUcp2h8j9u6yz6P66YGGvm7?=
 =?us-ascii?Q?0fHYoZSKGKxWPFi5zzK/DuT7hds+b/rkg0OV7WvtMnC2KgHvzQBE4YTf6nYZ?=
 =?us-ascii?Q?ZXOGHDZoLn56b8fAvsJWb6Sm5SCJ8VG+HCD9avFIH3KM+XUlKuY98/2Njpuo?=
 =?us-ascii?Q?c6hvzuR09oYa5czXg9eCJIF6jqgGbS9/eLYejwe7C0dGGwb4PLkQMGLWu58I?=
 =?us-ascii?Q?q+ImUSLjBF65/Y98i0odyvoDKxkY8bNe+BVXCJ63Tay38QDF4WP49Yb2ptgp?=
 =?us-ascii?Q?q1ysbSM5Xz7w7b3L66H+PxZkOQdMaXI3+9mgdCbahlKM7dTCOLL4Vzosv6Jd?=
 =?us-ascii?Q?k1VoeN56qqjvMVnx1Qopm4+NlJGYY5BSJucuG70sZqIbVVrZ7vAcigTcOlpw?=
 =?us-ascii?Q?UE0SpsvJ7N+fyenBwK8EZEJ1roU5hHOYbRdVTjcbh4vEKc9H/XWAApyP+Bn1?=
 =?us-ascii?Q?9+n9SlDKXegCwB2tmAgrFmC0cY+1YbFjpunkYRNoGHTbD8s5fAqaqLjATjhw?=
 =?us-ascii?Q?RufMoVe0PgDABWZCCRmBvXo80Oe2AQ82gZ+0BVZViaIC3yFrmt5jjzOwEfYI?=
 =?us-ascii?Q?VLqGEymufad8KJKOMHCldaDJiWNGvdWk3QhRIZjr9canvziX6AcKmpEdRiKv?=
 =?us-ascii?Q?mXIrVtjLvTB1UJm2OjaL3Sb2TyDUbMqOU9Fpq7PsH3+qqB5jcHpO5bZJbDwP?=
 =?us-ascii?Q?8CwprzUgBMS/XzfHZJ0PMDVf4uorCFn8tdvCL8HgOLEKfMI4DW0bf83daKNg?=
 =?us-ascii?Q?pKsPOKHQUPKvsR1s6+AatP7y/HxvPVNL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WYDtaVturTvPLlPEJSbZgRYISmBG4bJlO0vZCaCy6BGfNZnXa2umjkdXmtLw?=
 =?us-ascii?Q?wgqzAlsOMt24VAt1rBimComI3eW+UtlMCLNDaZu9Zta4Z35dCm/WEDmig4dT?=
 =?us-ascii?Q?03KAv9CME8iyvDV7MWH/7/mBzSge/kBnUzs9YkRm5g72NYgsoClIy+WZos8j?=
 =?us-ascii?Q?Sv2FSxsoydL7FCeYGoDYxzSUTtPkbi0tMb0GFoQ+D9JriNf4YxHhSJ8FDPAe?=
 =?us-ascii?Q?nvwdf+cLibzXB822Uc7TZlVT8NYc1Go9dAj9txWlYroVXv/K+bXV+n1s3rAz?=
 =?us-ascii?Q?av/x1sNVENJzOL1YM0g5K0uK8SvfF8y0ru7F1sCv4pgJwGtCaVqQDRGczpe5?=
 =?us-ascii?Q?SkI7OTgmBV2bamM8jNK1oz/CqVNjlJ7BwJeSkX1AipMNSA6GGdLMxmodMF4u?=
 =?us-ascii?Q?J/TIXQI4HWpqOOq19AXEFV1n7uRjncqT3GZ33RkfKW4VYad3UlGusmyoBNmE?=
 =?us-ascii?Q?9Pn1xj9AWCyrdV13ngky47T9QVMdIxum5cxQdEuipd8D6Vew6hZNfddFrS02?=
 =?us-ascii?Q?3ZWczcYctZWuKbW3Py0hS9OxfQcRONdlyKGbicf1uj0+/LVJaWZLP6YlUnw3?=
 =?us-ascii?Q?dKDZ0QXO2aj9cku13PKh0e2ZWwelvPDgBYf2ZST3KgYfj4j4zPQudFzkiuoY?=
 =?us-ascii?Q?WC1NLvzMEluXb2MvbS6LJIkwh3pNONA++lqBX+U3qIFOktkf/M3V6BhJaf+A?=
 =?us-ascii?Q?lDdKR4dlQapXN3gMQaCOu/3GLfYN6dOlzaySwhUQx28JkVWnLYqvsDn2izrB?=
 =?us-ascii?Q?lvB01YSeBwuqmlMHHDA6OlN7Q2KC+QkIX4Qj2DYK5hP6AaPhoysiF5fT8eIu?=
 =?us-ascii?Q?tE+kMk4Qc6A5UsiZvyFEOVIgnv3WAH9rVkN4fH3RT6Ljjcwa0iIVZgcPnlwS?=
 =?us-ascii?Q?qP5k3vRlERc3uk+l98S6ABRMP2AtNga1lkQFvrd660sZ6/mLaX8Zv3ILzrBx?=
 =?us-ascii?Q?O96GvPinPsgkHh37dHBsmAfpJMie5UevokDhaLRLVzUHrF2QTJw2dpljGpO+?=
 =?us-ascii?Q?Phc491gvkAJQcjrfSpb8ort/O2uD3/Q5ucne4jbaFViqJMpUZX6bqbRTbFKb?=
 =?us-ascii?Q?lGoqc4KSyWfu9KRimm1gHsbLgjHZ9WH1TE/eEJSB4XV7ZPsFjMhE+lkM+QHz?=
 =?us-ascii?Q?g2FpLqXhuHg07Gbc9fdAu8dY34czXidVY+erXkdcIBh6Y36m/VDFwzMEhkSu?=
 =?us-ascii?Q?RQjygnkx6c9uJzdyr3lyTqv3IJO6HlXLlmMI0DwCmHJF8j0eeHvOmhJmshVQ?=
 =?us-ascii?Q?e3sjc6UfT2ILhRXNkjGmP10Ar/hFoVBifasXdY82u85/0RIR6VJGKDz8mohX?=
 =?us-ascii?Q?vEgE/tiH/Qdb68bpZBejOwthS4q7+ANJPoWC7dXqITyFUqWCc1wQLgNq3LJX?=
 =?us-ascii?Q?1IPHMgdVV8OvjnnN6nbVyiNkluOphxcdpb3DkJBi5tW27dCo1HqUKAAjJ4OE?=
 =?us-ascii?Q?oZi6V1LngFSkbhzG9eg8wOvHTtsTXP8UFudZcqz1GcHoxkPzct2LvIuLB6rD?=
 =?us-ascii?Q?8ztP9irb5+wp/etb4k7WFrKmXHTWpIDJTZOT79kvrk2a4abj2sHu9OhlTxBE?=
 =?us-ascii?Q?LdjJiTFOlImopRiMqrGVP2zPnNFxKnPouqaYDe5M+6Yj/oLxxCJcT+7HnQoF?=
 =?us-ascii?Q?lONi+lvXdbmtMIKaxZ7stFQEAjoGPbKqL4BJ07v2nqCSJu8y5Z4vuD6sQAz6?=
 =?us-ascii?Q?JD13Q3DUmWchakugThk8xVyVZrawW5A7WUuaG/+fhSAhU/7IdAZwhN2m2dEs?=
 =?us-ascii?Q?Z/bpZrkdryNTfxL9VRFCCI2BVbw731U=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	W7ujt65jTgaur7tUmpiBiKuGlfO0q/kIbsVG8+ec3pxfl9K5Z97MhKU0cf6Eb4CDMR+NuR0bToQxaSidL0Jpo/oB6mXn6kcXXdghHbRj6NUkm3GpU0nu0U9v3q1kXwo/FHv5HNj3pFcdQpIBYw5LJytKML1BbtlwVSlGsB/K0vZffwiRQ/PkqsIpfOFtXv1wqBSzrffwJr74sOyoS1DiDjNsXXDAEUmafBBgWlECwUmjkzvQqqKhlyg7hvPewae26rgunQG5J26ZzPwsrgftZjspuXfrFkplW6UmxsGw4xcpPAP2+z6x5tMBYyk3tXGu8qMPKw3m6As1nvMauWm2tAP3PYw4tzXkQNzC2ppHFdyMxiUS8/NTKrCiHD18f9nTmwcFQKu+dgJhhhzyhX+6cv8x1VuCKefrB3URnLhefV8VPKDPdCfIUxgofNoL99kiADNWp6iX3llSHSAdD/+IykcsWMuo1NkBCmjsS4Kj4HdmhY5LgBIZIpyeh9L0gfmsthFuyT0g2+J7gfhoGCuA7njzkQJ3D3h5DydnisQgq54Fi4apXz6wlOg9yWLnhNvorg5v0Gcv6Nw7uJYaX5NrFFlgwJm0Tasjalv1qeAy0vk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40c09037-ce9b-4d80-6314-08de4fb0a2a6
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 18:55:19.7367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V0xWS1kC+d+ihOpHmKErQ/rEA6EDhd1b6mViasCvlYvae3AC8tD/knV1MzwdF21TeN0BVnepNactpAWjcl5kw3AySRZQSB3YFZxH6eodBzs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8686
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_05,2026-01-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2601090146
X-Proofpoint-GUID: cPmcZ1XBqMWRXfQVclAjyZhgRv6hkcCo
X-Proofpoint-ORIG-GUID: cPmcZ1XBqMWRXfQVclAjyZhgRv6hkcCo
X-Authority-Analysis: v=2.4 cv=Dckaa/tW c=1 sm=1 tr=0 ts=69614f92 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8
 a=IChBzuphTGjYc73sMGwA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDE0NiBTYWx0ZWRfX5Ds7JHMLGqct
 BT24lBg/MRs/Uqj6kh5qqeY9n1a68qG65Oy2+01+4j0CHCas7W/BhA4KXIGFjbIr/zmlZJd1nE0
 Ql4VbwvwzvXcaNgvGHfkIFKIrIOjCBx02DVWKbxW9PVk8LJ1BKrSq8AtuPBasLN3l9TrBcLIPVh
 S0rDHA04uiSL4fkAPk4K5ZjDXdkO/VtX6J6X8PLwRWINAVDs6uCQZ9EuF+3Mrb10DxoOZZwHFT5
 UlPKHUeAglo7K6cdSemWjBqGTFqTp57c6F8eHImsv0lpKlWxa6eUhYMBHf6CqJPLeNkKD4PDeBZ
 JYhQF5D62iCx6lVynrvRn8ms5OM8Cvz1mdwjTwuq77rhcE2nLsO0I4JcVNY9MxYGeyE3YkjmKjj
 G9EUKqLeuwhERj8smmNfZZ8erN1mhdZCh0y8XFzjoq2WZDyv/PQm5aN/pJGf38ChFj3jOuyScVm
 zqxW7NBK4p5y+U8mIMA==


Will Deacon <will@kernel.org> writes:

> On Fri, Jan 09, 2026 at 01:05:57AM -0800, Ankur Arora wrote:
>>
>> Will Deacon <will@kernel.org> writes:
>>
>> > On Sun, Dec 14, 2025 at 08:49:11PM -0800, Ankur Arora wrote:
>> >> +#define __CMPWAIT_CASE(w, sfx, sz)						\
>> >> +static inline void __cmpwait_case_##sz(volatile void *ptr,			\
>> >> +				       unsigned long val,			\
>> >> +				       s64 timeout_ns)				\
>> >> +{										\
>> >> +	unsigned long tmp;							\
>> >> +										\
>> >> +	if (!alternative_has_cap_unlikely(ARM64_HAS_WFXT) || timeout_ns <= 0) {	\
>> >> +		asm volatile(							\
>> >> +		"	sevl\n"							\
>> >> +		"	wfe\n"							\
>> >> +		"	ldxr" #sfx "\t%" #w "[tmp], %[v]\n"			\
>> >> +		"	eor	%" #w "[tmp], %" #w "[tmp], %" #w "[val]\n"	\
>> >> +		"	cbnz	%" #w "[tmp], 1f\n"				\
>> >> +		"	wfe\n"							\
>> >> +		"1:"								\
>> >> +		: [tmp] "=&r" (tmp), [v] "+Q" (*(u##sz *)ptr)			\
>> >> +		: [val] "r" (val));						\
>> >> +	} else {								\
>> >> +		u64 ecycles = arch_timer_read_counter() +			\
>> >> +				NSECS_TO_CYCLES(timeout_ns);			\
>> >> +		asm volatile(							\
>> >> +		"	sevl\n"							\
>> >> +		"	wfe\n"							\
>> >> +		"	ldxr" #sfx "\t%" #w "[tmp], %[v]\n"			\
>> >> +		"	eor	%" #w "[tmp], %" #w "[tmp], %" #w "[val]\n"	\
>> >> +		"	cbnz	%" #w "[tmp], 2f\n"				\
>> >> +		"	msr s0_3_c1_c0_0, %[ecycles]\n"				\
>> >> +		"2:"								\
>> >> +		: [tmp] "=&r" (tmp), [v] "+Q" (*(u##sz *)ptr)			\
>> >> +		: [val] "r" (val), [ecycles] "r" (ecycles));			\
>> >> +	}									\
>> >
>> > Why not have a separate helper for the WFXT version and avoid the runtime
>> > check on timeout_ns?
>>
>> My main reason for keeping them together was that a separate helper
>> needed duplication of a lot of the __CMPWAIT_CASE and __CMPWAIT_GEN
>> stuff.
>>
>> Relooking at it, I think we could get by without duplicating the
>> __CMPWAIT_GEN (the WFE helper just needs to take an unused timeout_ns
>> paramter).
>>
>> But, it seems overkill to get rid of the unnecessary check on timeout_ns
>> (which AFAICT should be well predicted) and the duplicate static branch.
>
> tbh, I was actually struggling to see what the check achieves. In fact,
> why is 'timeout_ns' signed in the first place? Has BPF invented time
> travel now? :p

Worse. I had to invent it for them :D.

The BPF rqspinlock needs to be able to return failure (-EDEADLOCK, -ETIMEDOUT).
What seemed to me to be the most natural way was for the clock used by
rqspinlock itself returning either the clock value or an error value.

So that necessitated the top level timeout_ns to be signed.

Now the error would get filtered out by smp_cond_load_relaxed_timeout()
so cpu_poll_relax() should be called with a positive value of timeout_ns.

> If the requested timeout is 0 then we should return immediately (or issue
> a WFET which will wake up immediately).
>
> If the requested timeout is negative, then WFET may end up with a really
> long timeout, but that should still be no worse than a plain WFE.

cpu_poll_relax() should not be called with 0 or a negative value.
I'll add a comment to that effect.

> If the check is only there to de-multiplex __cmpwait() vs
> __cmpwait_relaxed_timeout() as the caller, then I think we should just
> avoid muxing them in the first place.

Yes that's a good point. That the only reason that check exists. And we can
do without it since cpu_poll_relax() has all the information it needs to
do the de-multiplexing.

> The duplication argument doesn't
> hold a lot of water when the asm block is already mostly copy-paste.

Fair enough.

--
ankur

