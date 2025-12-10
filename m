Return-Path: <linux-arch+bounces-15322-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BCD4CB2CFB
	for <lists+linux-arch@lfdr.de>; Wed, 10 Dec 2025 12:24:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B16A430052B4
	for <lists+linux-arch@lfdr.de>; Wed, 10 Dec 2025 11:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D61BA2F90E0;
	Wed, 10 Dec 2025 11:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eZ5b4Q4+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DguCd70e"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4959C2F99BD;
	Wed, 10 Dec 2025 11:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765365894; cv=fail; b=bzOPPojvzxcXrNaHSivNqWpPcb/7HCCpKE2afl/6UPdjH+geY863IKaaTSrybNrGJd2G0q7tMVUHZ9fmyLWSthsEWrhGasIQV17U5Mauy/MmKhzhQkkGzbP577OFFGB9OnPb4IrEmVJChEyW3A1jmLiph8nXnIZJEEIBEIKEE9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765365894; c=relaxed/simple;
	bh=IAVbgKqAxClL0RyX2hBLp7dIKuTtpAwIpcZPY2r58I4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ObxQaj5EeVORTs0NSvYjPrvdhuQIx75n33NDSCmlmVMmi2zMzWg4FerHcX5NYUwy+Je4QMN3bzsOWYeLgGPdX2zMNicS0BLP9esIr/LXVJD2EOjs9XX7RZvvh5EqcsauKssDflzDjiUYresp+jGNc7tFBtpF53XO9HHwfbj6VxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eZ5b4Q4+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DguCd70e; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BAAvdaB2961898;
	Wed, 10 Dec 2025 11:24:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=ocIMuoS56us+J4E5TX
	uTca4yO33e2w5rUhrqIibopT8=; b=eZ5b4Q4+eGuOzytd6oTQOWc2/OrJiwO2gK
	3c+FemzrOEvX6+UdSacw/4t2tpYy+eLXccmQz+2FeVcH7XSGnqhCxHjEqY2CDI1r
	e3RmpWL4zCB8gJeXNe8M4dFukymWrpb3uueahPyMlnzMUv9SU96GXfuncQqOLIMu
	Oq8T2q5TR8AqlhKeL2BjqRe0154SGXV/GdiF+GYp2zwYV3d1lMvV2eeJof98kmn5
	X8EpEEpmUjbKDcmkOS/rQSRwMZYNjZZe+OY9HZUR3U6xcM+sDupAoWxuzOOmogz0
	EVBnUZWc0uWXs2VPKOnHmQSY8jH0TVZVMa9uV4l77EB8iVyl8Cug==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ay7jnr0ug-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Dec 2025 11:24:17 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BA94TCs017580;
	Wed, 10 Dec 2025 11:24:16 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010012.outbound.protection.outlook.com [52.101.56.12])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4avaxa58wy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Dec 2025 11:24:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yEvxwLOhQEPYAnRa3yBhmebQMdG5SN0yqlIDW4tKuKQqpGx+499IlEWChd9hAgDyAPCyYBSloJEWhHgbxV8qs8u2dcvcelxoE3h/27Fr9UwAR7ZxYkJteu5fyYymiB8FcfZfnkTojTxVV7xHWHJSIp5tnPLGloOX5t+6oF4xIJJAiqLGPPU2Zr6Hp0ZUslaogmVfpJNpO5M94lBj4dSGR4h1ngKCNSBYhWdnUBrmFi8yddfiB0zD9NVj3VHRM94s93oAztL5s2yhv7Bnd5FTRHU7cz+0KGLznvaRzxNRQf1borciUzqz9mDls2PFSzphHq+9eyI/trJV4r8jhCekKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ocIMuoS56us+J4E5TXuTca4yO33e2w5rUhrqIibopT8=;
 b=CdMkxYarlp1Wnr1eXaDQGQfmB4f5rHdMaVCULliDxwq5krmxKhkh/J9gowUtZWttBLsd21dqP7mVIlRjDPJWbvXHCalGPwag4T0aVbltmGj5Wwc3BQEUMxRKKF9OHgirqResvtxzg4ObrOoPKzHIRtreutR5edu69wzy1FiyuqTVZyS3IQXs66isRkGA5aN8D3h+zAxsdLaMx5rGcv76CQWYOpEVr9pDVt7LM6nj/VE+2q72eJe2bkqAT9UnA1WhGgmXxYWZl1tJNPHYDIZwq5EY4LyvNSfMLIAqBGNK1xK8/BXpVphNcXZSuLB2RTxWxnHTnksRJdbGwI8pYqQ7Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ocIMuoS56us+J4E5TXuTca4yO33e2w5rUhrqIibopT8=;
 b=DguCd70eR0OUGD/u6nH0OJJ7WkBVsgYmt/pGB6JdOQo7byhv5XIMP4R9or3sQENJvvbtVr4WcoxFrJpyeZpbpDyEMkNszFjVtc1//SFt5OpZIIGN9JR6SYs2iWT3OM84Q0bi7t6CMaU55SLAWrCgaCOcUXsC3Ar4sXYn9cufNiw=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ2PR10MB7037.namprd10.prod.outlook.com (2603:10b6:a03:4c5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.7; Wed, 10 Dec
 2025 11:24:13 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9412.005; Wed, 10 Dec 2025
 11:24:12 +0000
Date: Wed, 10 Dec 2025 11:24:12 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, Will Deacon <will@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>,
        Harry Yoo <harry.yoo@oracle.com>,
        Laurence Oberman <loberman@redhat.com>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>, Liu Shixin <liushixin2@huawei.com>
Subject: Re: [PATCH v1 3/4] mm/rmap: fix two comments related to
 huge_pmd_unshare()
Message-ID: <b763a569-260f-4a1f-8fe7-9c0241ef8540@lucifer.local>
References: <20251205213558.2980480-1-david@kernel.org>
 <20251205213558.2980480-4-david@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251205213558.2980480-4-david@kernel.org>
X-ClientProxiedBy: LO4P123CA0374.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18e::19) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ2PR10MB7037:EE_
X-MS-Office365-Filtering-Correlation-Id: 3756e98e-f3c6-476e-2fbd-08de37dea53e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1JkhJPpnsekvPKOBw+L70DQOvpGomHBVKC009eGXogpwFvxRYQfgScwxfrRW?=
 =?us-ascii?Q?lSg7cHQMvpEjfJit8O7C1xC7XBILXzGpYZOvs8R9aTHZxHjOc/gtK82dHUQQ?=
 =?us-ascii?Q?3rYgZE+rOCRVfctuKV1WlDMfWT97HqIUJmWKhfhmZEB69ei37UdVdL7TKgB3?=
 =?us-ascii?Q?aF+FntHBai1odAhIToSWuTV8fnyvB0muhcpt+ckBJjNpxPZeeZDXRNOM9m12?=
 =?us-ascii?Q?NwM9bkjBp6lufkSIwrE33iNhMi9Q1+/W4RB8zXvih8hOegJjXyLgrEIpvfCT?=
 =?us-ascii?Q?RYk+rA3EMHeKGJ9+qJWbJ3vuTt8az5l8K3ixZqFGdQnNYFHkbojAjX4HZ4uy?=
 =?us-ascii?Q?iuweWdT7iWX6KPdaq3cUQsRp0cvAt2ym+KbrbU0ZFB2LnsfE9F0trw96cWS7?=
 =?us-ascii?Q?uflfE646ULyDvsZyouroZNbh5MaX25LMwZ7EIu6Q/gCU+vgSxSAKuRU/Bic/?=
 =?us-ascii?Q?KWzftJKR8vGsPj7O21SJa/LjICok2ETG+a02t6s3P7MqVNDc1LqczDLXikgs?=
 =?us-ascii?Q?NEz39SFGuGz3yC+5NGJO5jJlVdkiBizynkiTNk2aRQHcH+mDxYX0ZqKPfNO1?=
 =?us-ascii?Q?+K+rTVgPf+hjL9UTNKeJH3/myk3BSeBFvryv4p8WRC+U0yblvCN89a6ATAJO?=
 =?us-ascii?Q?1x1N/pfT2i9/lnV3ubj35Q2ZCp8Z7fXsi1J69Q9sJ3h8cuqD+krcPfCClVV3?=
 =?us-ascii?Q?42MvSlKYzGwWXCHTBmZIUyf0uOYGdUNLhyLQmsaYU2hi3Y1Q8naZiFY0blT5?=
 =?us-ascii?Q?FgxRnSEvGC+8v1ee5RRCVwKxHMO6I6EWNgKcK8PV0OBSEfFYcyO74H9vHFxw?=
 =?us-ascii?Q?lLQvWaOTEAatuXm4dzFkOHgqlFw6gzXsiaEwpeIJz6Yc+NVXTwVyiN53IhQA?=
 =?us-ascii?Q?OYtQ3dZX7mcNVs1sD3+Gkzr1hWPrrIK8sqfW2JAscArVXG4huNZzyh8Ym/ay?=
 =?us-ascii?Q?D7GZQIywGEQQRH1MBOF2C1TEf3AEv0t6pDjuInDNJ+sfBDtyRIIsfpxtUwcq?=
 =?us-ascii?Q?s2cFIZKKAw8GLtuUV9RzkVUEG1379yzmiTypTPKB2yP8cT8r+QsXwI1pSzpY?=
 =?us-ascii?Q?1K1E1zqAXX4Z2U0etLtHRTzsX7q7s8+jlDu+v3f1CYqHUUO66te4jF0p4teh?=
 =?us-ascii?Q?aqjrP1nF91T1ZBr25rVHedKemgLDSmHjDwWHZFZR8IjGOMiYTFqwyFDmE5Yw?=
 =?us-ascii?Q?Sq2lgyCMPfGmVWx/h762lA3azDRsLXx1Re5njCCgOArXCzI/iDC+y6yMoeWF?=
 =?us-ascii?Q?0H86MPKLZ60w7LD6NKGUIplI25tg2JdxWi8Xg2fZv00S4QBAIP0ykoRygwRI?=
 =?us-ascii?Q?JsW7GzJol2JvGC2zDG6eVJC4C3PVSITcYAHCTX4/ix74iYfkbtK8a56W7GMW?=
 =?us-ascii?Q?XfotRKdSySqC/kdg8uCym0iwwYpDX/fH+T2x1UqccWbh89YZK22gM3UAjcQT?=
 =?us-ascii?Q?RsMMW1EpCm/Vf53+jfWVaMYEWUATpB+a?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QIx2wKl6Bf91+KkYlNm9aVd7vOSxhCClDMBG87eNsLdBjGSqB5s0A/wyloud?=
 =?us-ascii?Q?uyEpqZeUlsJIdgntumb5bM4OJ0n3ZazDpWV4bqnJRZhf2ui9/ufFmQc7XBX3?=
 =?us-ascii?Q?kRX7Gsyt1rT76RkwSGtTclef41HnULuWPvtKZrzySyncyCw+i0jxYQekA1yt?=
 =?us-ascii?Q?2MpKhsQmdSUJ8ecDjVc/I2vZUBn87rh/+0UqNeXS1RkG48k6JKlVhXVWkO/6?=
 =?us-ascii?Q?v6eYzcYw4rNdI6PDb2Fsv+jr1QxOrpOsMDEWkQ+O9PdtPQOf5UGdSn8MJCiU?=
 =?us-ascii?Q?jzlJSRmog8yk02Eij8d5pmJc5bd/ojA2LpKC8SXbbc3zDnWVZexH/7stup/i?=
 =?us-ascii?Q?3+1tomkNJsHEeL20lSHN+oKHmWKbZFaILBlS4ep+Afl4akvNresdkogbDJ93?=
 =?us-ascii?Q?Th1I5bqQj7skG5Ht00niZdFpayMOgGqNh56scO3BDyI7cNRIGex16TqiKH6k?=
 =?us-ascii?Q?jTgONFAhBvK4ebS9MVL2p9g5Mpn3cPe/ybLA2Vi5uqMeO8Us+40KAhQE7CTT?=
 =?us-ascii?Q?bomZhnqNDHcRkY2bgk0mnBw/86Hgner7U7k36d8ehELv/iv0muaWUX+kXd2o?=
 =?us-ascii?Q?+qrSfQQ9J2QFsg4SXLZrt1OQurtJIyoLqFER7JsaxyBbIsU9wSVdHVl5Cjdh?=
 =?us-ascii?Q?35JE46s6rnylkx23RF/AdilU4hBe1DOef6bWxlPSscO4zZLLxv4jI5wjrJPq?=
 =?us-ascii?Q?8P2DTJfhcHeVxLs2mQzsOqfgTmao2Y+vWzcGshFb+Pn3deiXGQZF7mPeWNNh?=
 =?us-ascii?Q?zGqbsaYb0KaNq0ZTFpHzuM2z/xFNnL2/o3WknT6pSHoisFnXerYwCWJ7pzM7?=
 =?us-ascii?Q?oP9VBRZ66ZCQ42+j7Qon2A6zHM06q+g//h13zqbrGW+IpxsLwELf7Yg8Sxqw?=
 =?us-ascii?Q?ZVgcsUyv7SHY0hsL5iP0vOZQ6Gcp38SwJj6+rvB7j0MAX3f9RIq7pwtzPJiJ?=
 =?us-ascii?Q?pZdpTLBw8Rxa5V+UNREIRg5XOHjhba0hPsa75gCrN6+nry6SSOCj1JG1LYpz?=
 =?us-ascii?Q?FGDQy0ofQSCE7pe1EaL+Mc2Ljs/Ht3jLq+PMHuucQm1ZR6edQVu9VT3kIcNJ?=
 =?us-ascii?Q?WKDw1mm+EH4/SJxlatToV+swQSFs8EzfN7Y+1PRZcCzFQTEzNgx60jDgKlBc?=
 =?us-ascii?Q?z1dVb8R6GkGLuvGwbnNbCMp12dSOfO00Ys4Ar37X2aivmRCRz/eeBfQtlxpE?=
 =?us-ascii?Q?sbUUY+WB2IBShdQeG7eoiasAOW60ur9ZXULebLlB+vYU9Cevh79U22Y/qlwJ?=
 =?us-ascii?Q?ILzDergBjCAUY/we3Cg2eEhHB8dyQ6TNnN+C/gARyy+MewnGL1LxrglwY5dw?=
 =?us-ascii?Q?naujH+L+nH9sMSl80YcA+TNaNiSRjMDIY4YuDTFzCKqazoWM2cxMPqQrj0xC?=
 =?us-ascii?Q?AR9tO0iCqFzlZLmQXS00M+zrFo0gqHqzIfv7xbetSySmLkWxfW+Tkry+MnB/?=
 =?us-ascii?Q?vC+XACZ2+lNl7qODprj7ery8Q1iTVTnC3N2e42GtyMH5HnJXJZyGTDRcQ/OL?=
 =?us-ascii?Q?lAISrHSQbEccmUmIConCuOCnF2HYKCA5n/u+gBIDNpHHH9W7BRYtIVePdYVY?=
 =?us-ascii?Q?rfsZmPK3vm9bnmJl73chONElA9DKSHXOSCdFBSuJfdZXfWbtljns1AV0537d?=
 =?us-ascii?Q?fg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7dn0vocIpFYYd+pbuLFXFDtTlWLtQ9uiqBlPrHtM1TGGcgidwI37k1+/PfVQHil5TrYDQy9hMS/nbZE5lj0nqkx3KroFAXtQOfX772xsUn07zHkpSC84en7g5YRduSRgAp7bf8M0Zorl26nDqPK50hpHnPGKitWfCcWFfbqBzk/UmYQ83O7LnIYVvGDF3JSJNRLDlh5Z9F5VD1z/U5S6TbExm929YBJ69uJ9neL5RQQrro/cFG4UCNl6Y4Fpw2bXHGqR6JR6KnJ8Q2j6o0TCM1qFk0MIo8rHPg4TtA3sJp1Z6YXB1P21Bw7hStToylKXIl2WQqJHELxKauVF5pfDsVE2tATFMVNLBJPDJyITkvR9JpoO8agIao2s/CaVoWqUYz8YdqTNSjKOD1u28pyAnZGOMVk7e62EouTwYOBFDvkLQP0P1K48jNCU816LhynnPARzS0bWHj9LeudCSJikffeJBOoevN4hPDO9TqihZ06gmY7MOuzpsj8oYnXGkQDArIvC76I9PfYGTSicfeQbLWmSKsHhShfGXtKq6VPgWLw0ZRfbdnnOFKiUyHh6LY39nFvmEMQN4ari0szuIqPIv2Bd0QAdzkXiVj1LYYERh/Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3756e98e-f3c6-476e-2fbd-08de37dea53e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 11:24:12.8812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bnO61hiSS8kRBrpGII9UUV0vwqM2E4gamLM+vJh46p8D3z7cbuth/Y8Au6gjF6CaT2mndHOmbnnkUf4cg8KBA2WcDMzXk6UOc1YA4TtFQjY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7037
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-09_05,2025-12-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 bulkscore=0 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512100091
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEwMDA5MSBTYWx0ZWRfX7mPJpuYw7pUG
 jUmpM4c6SUvnWQmEdWNp6xYmhO3Y0jnyqRsWp0d4mJL85+D4myXv4GYCHYIX7F5gMQ0e7u1D/cV
 PTUcPoc4ExdqkV4K0USG7pNz9NkEJmgnckkvx0k1M9DHLYor+XNqqo6Fx5bIW8NF8WqR2s5i87U
 jTwESRjQTntPiOw8FppQKmb4yUiNMh8RMe3hb7GH9Unl4KIVHKc976r9ZRKuxWkcM9AlRJSY6LW
 CleOVUlplGEetpdsqomLG5KN0nWl8vz/3KpkVkfvD06HHv9VLjinjy3jI7LYhe9ndndUDk+7b2I
 U0Fois1bS/3xg28lhHDaX1O+VswLD13pwSrmbuAgW3sKd+JOpCeQu3AYE73qZXZ0CwWoRXVDbN4
 yHRZtphMgKDdJvmKzXFY8IPrqxmNEQ==
X-Proofpoint-GUID: MY2yT5wnNRDqZpifAV8sCbMuh6OoD5GU
X-Authority-Analysis: v=2.4 cv=SvidKfO0 c=1 sm=1 tr=0 ts=69395861 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=i0EeH86SAAAA:8 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=IKJS8UAx4gGAL1X2X-cA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: MY2yT5wnNRDqZpifAV8sCbMuh6OoD5GU

On Fri, Dec 05, 2025 at 10:35:57PM +0100, David Hildenbrand (Red Hat) wrote:
> PMD page table unsharing no longer touches the refcount of a PMD page
> table. Also, it is not about dropping the refcount of a "PMD page" but
> the "PMD page table".
>
> Let's just simplify by saying that the PMD page table was unmapped,
> consequently also unmapping the folio that was mapped into this page.
>
> This code should be deduplicated in the future.
>
> Fixes: 59d9094df3d7 ("mm: hugetlb: independent PMD page table shared count")
> Cc: Liu Shixin <liushixin2@huawei.com>
> Signed-off-by: David Hildenbrand (Red Hat) <david@kernel.org>

LGTM, so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  mm/rmap.c | 20 ++++----------------
>  1 file changed, 4 insertions(+), 16 deletions(-)
>
> diff --git a/mm/rmap.c b/mm/rmap.c
> index f955f02d570ed..748f48727a162 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -2016,14 +2016,8 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>  					flush_tlb_range(vma,
>  						range.start, range.end);
>  					/*
> -					 * The ref count of the PMD page was
> -					 * dropped which is part of the way map
> -					 * counting is done for shared PMDs.
> -					 * Return 'true' here.  When there is
> -					 * no other sharing, huge_pmd_unshare
> -					 * returns false and we will unmap the
> -					 * actual page and drop map count
> -					 * to zero.
> +					 * The PMD table was unmapped,
> +					 * consequently unmapping the folio.
>  					 */
>  					goto walk_done;
>  				}
> @@ -2416,14 +2410,8 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
>  						range.start, range.end);
>
>  					/*
> -					 * The ref count of the PMD page was
> -					 * dropped which is part of the way map
> -					 * counting is done for shared PMDs.
> -					 * Return 'true' here.  When there is
> -					 * no other sharing, huge_pmd_unshare
> -					 * returns false and we will unmap the
> -					 * actual page and drop map count
> -					 * to zero.
> +					 * The PMD table was unmapped,
> +					 * consequently unmapping the folio.
>  					 */
>  					page_vma_mapped_walk_done(&pvmw);
>  					break;
> --
> 2.52.0
>

