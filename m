Return-Path: <linux-arch+bounces-7499-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D3DD98A950
	for <lists+linux-arch@lfdr.de>; Mon, 30 Sep 2024 18:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37E391C22BED
	for <lists+linux-arch@lfdr.de>; Mon, 30 Sep 2024 16:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9926019047A;
	Mon, 30 Sep 2024 16:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ANl+mi9E";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qB975pIy"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9F5188714;
	Mon, 30 Sep 2024 16:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727712373; cv=fail; b=ZsiTeMUId11yQxN5eJtf2pDUtxfUuGdpwXcMVSiSij3vv7AQVI21Z1BW+nNZPCuP8sOHJsI8+0HM30IopQoeE67ORZH+Qnnqy9hDsvjPzK1Z15UOugTRAYDRAQ8Mni/eGED6tfM705cTxa9Ak7IYKUg60DPElYSi7uUS9pJqj08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727712373; c=relaxed/simple;
	bh=Npnkv+lLuXDO3wZVyTo4KofpcRVijlCDnhmalLQAoq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YfJ0+7Ns3BWJ2dytD7H2YR+mAL2lppAqULUkk3Rk7y3z8WI3Ksxa6F/vsP9FjlIeA0i7zUh6/Dfrj7uS5BvpGYq76P9IBYrMO39VaNOUxJ6szQG4gDpKFlN9l/lA8OgekVUlHLpV2hhw6oddaGlZhFdOaU54OwmdBYbhqiRllS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ANl+mi9E; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qB975pIy; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48UCS4sZ024759;
	Mon, 30 Sep 2024 16:05:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=HQ/eabWBUbgtZpA
	IegfI8AafQR3ZEEi2ZWzKP8nYzTQ=; b=ANl+mi9EduyLTsZl/ZS8fimM6YzmqjB
	dHEWcRuDPxty7iPccZNh9GHn33kexDe9hkinn7K3/8h1cMp6dHyDZYfIwhx1yV8/
	K0CdU/fWyL7blZZ7JkZ7J/7r7O+MEFtLLpHnWg5JYyOV30ZyHYtst0bXI45lsoNg
	CQXYiAZ1uyGf2ibyLxkitSpm+UYeRBv4XhV3I8DkyoGcXW/lJVNUHpNGQfwiqqJf
	7wPpFtUEeXRuPQlR6m0rvKxQKAG73CuQ8ZtSRIB0VOP2onbXCqMhcsCgqgV+HlsS
	Ewbh+L+NfK/n8nOI5zJhydIf3hK5fLLtbZVXz0kspSjDm0MPF4E4Rng==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x87d3qek-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Sep 2024 16:05:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48UFXftM017338;
	Mon, 30 Sep 2024 16:05:27 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41x88683gf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Sep 2024 16:05:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OXffBPGB8ARBd+DrKZ/kVLgvGs386WwchZi/XF4wizfaWnYXNj+GXW9QDijgAgS34LaPXqL6QbYGTBCeq7zHG4xB2VD3+ixIACTZYZJwXbhTY8KJbXAviSLsXq7RYYBrTGbYDkq/qXrs3P6FOwhDAKx5AkswR6XGTwxfOHzV6pUL5dtNFZ1ouT9jlYwjmwwvo+G1/F7aePDScof+kZEXPJvYl/M7BWPy9JsF093ZtSFkrdNBjZTJFrDTwEkTBh46XguCuXoCdEzNudzzuBKsJNGcZX5k3j8Du/xHCHgVZyeJzekRzlYFYm53lOSL15Gfy+z/Xk4JAEAi3eal+ZOidw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HQ/eabWBUbgtZpAIegfI8AafQR3ZEEi2ZWzKP8nYzTQ=;
 b=CgMOli/7Z0WufWFpdS+GPd69kR1q3714gt4qzDvD18fg41uc5nzcASj8WUyKKvbfJE7wT2Md68wYMYzmyYlZ7C6nD9OVM/atpzdUOyZx2UQU8oLOIPPz3hq+C9DTNppyB7nZ4g6P8JJpmN+otWgzGP+Kg/8lLUn7vlD95ePGGxagCbTFMZG46XEp7sj26Q+5AdaQLl00gWk0KXRwRFTkNboLyRRD2ZWy/0J9WkhFQISlAg2ZlvEnBTPAtdoOro6O04fUrEoo29d2Jlmtgy8PCNk/8NWpfsJwKYi0p+yPAzZYoTyB3L5FLzSvUnlX3BZrrdhCWbICN3ht4E7LAs7Ftg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HQ/eabWBUbgtZpAIegfI8AafQR3ZEEi2ZWzKP8nYzTQ=;
 b=qB975pIyqSvN2ZPHr5zt6rFXBLs/Yt6lUDBh4x0A9yvqDQotoONzp8lXOBbtX0dIQFEgeIjbWpB9aycRwx0G1hVSUPKOAdfyuqync7XEUnCgHSQSMlERQY7GnjOfcLW0cxREVeb/6l+cN2/YYsM2q/GO9KXfTTJ//7cmPkPObs0=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by CH2PR10MB4152.namprd10.prod.outlook.com (2603:10b6:610:79::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.14; Mon, 30 Sep
 2024 16:05:23 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8026.014; Mon, 30 Sep 2024
 16:05:23 +0000
Date: Mon, 30 Sep 2024 17:05:19 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        "Paul E . McKenney" <paulmck@kernel.org>, Jann Horn <jannh@google.com>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Muchun Song <muchun.song@linux.dev>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-arch@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>,
        linux-kselftest@vger.kernel.org,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: Re: [RFC PATCH 1/4] mm: pagewalk: add the ability to install PTEs
Message-ID: <6dd04d20-6dcb-44a0-8c28-9e8c6b414e4d@lucifer.local>
References: <cover.1727440966.git.lorenzo.stoakes@oracle.com>
 <59e218670565accf978aeb8cf4745de4c0738773.1727440966.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59e218670565accf978aeb8cf4745de4c0738773.1727440966.git.lorenzo.stoakes@oracle.com>
X-ClientProxiedBy: LO4P123CA0389.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18f::16) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|CH2PR10MB4152:EE_
X-MS-Office365-Filtering-Correlation-Id: ae5cf984-c393-44a5-47fe-08dce169b09c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9tiQ8lR1GVUZ7z6338f94A7Ke1GToCeBYx+4I4LwvIIqTm4QCVGDxau5w+MY?=
 =?us-ascii?Q?1BPLMeklScIfEWj4AnRpj6lae+vh3ebgYXkfrSAv46s+9bTiokS6g3bX1g52?=
 =?us-ascii?Q?9v2jUyv0/z3NACDtowqZ6PK+1YbyzUwkjbiawBEmTgogrislI3iWKW/qHIX1?=
 =?us-ascii?Q?mbPibwrNRDvNqckFpcJ/DgiJ+z9TpKxjQeFwlzv7gk32hucDoazMKDZYdXj3?=
 =?us-ascii?Q?WaO2dcB0AmsTILwQ6P7xtc+H/XnNMlSk86IH9wWn4+SZtn1edPjyQ2f4OQ/z?=
 =?us-ascii?Q?moizaQXL03DAN0Go3GBetZFk2F/F4y8eIjlptNmx8O0YM2cg0KiUkra189Au?=
 =?us-ascii?Q?309OAf9Uauh0MYBplTaapYYEbs7QzUJrBjPkVWR72BX04k28VkDOJhjKr3r8?=
 =?us-ascii?Q?u3WnOVqaTlUlSccwCbvdCAqLVamroYAfXkNnWqdXB43DSwBqwx4GkjADyQ4F?=
 =?us-ascii?Q?XSOESjGB4QXCWPzkghNNVne6XYMmbJssw4XRx0yR/l+UO/t6DPplPPx1Mobm?=
 =?us-ascii?Q?Zg1Dx/iuR+SF2RTRgXo8tOg+duZa9XU7mj/j2APRzsNzKBZHMUB+sI8DwymY?=
 =?us-ascii?Q?Zmc3h+0/YXdMS5da0Phih2tbZQcSS9Oy0JlnhgpFIWTqjUqWyBfPmDYQRyWt?=
 =?us-ascii?Q?6VMinzDCUS7Kj5m/r+Mgw/oTSdh/t3CESm0pRdMC0X31/5wNax4N+fKGni6I?=
 =?us-ascii?Q?sZ222SzgZquUgy/gxRguwlV55iVJBcPIN9kU80BBuGr1oidTCxbr9wP5jyl1?=
 =?us-ascii?Q?Kb2bnxjrn1Wf7FUJyVvfMVmVnAdW4s0v0poRPIeyDBrbkqVP3uJuxncWponM?=
 =?us-ascii?Q?KJ/HB8VmW+8DP/NgVFJJpRbIa5vuobVWUt3LQsguRc5DN2ANkcLodHkWTNUt?=
 =?us-ascii?Q?ypBbRvGmyEuwD5nwpYA1UDC+5L8sC9GvXev4W1k8GHb0/ieAOSIJVXAXol7P?=
 =?us-ascii?Q?ip80lkHL04py6fy5PGVqfZAqa/OOBSpesLI7GMgfq3ta69kANikHd6PcMWh4?=
 =?us-ascii?Q?FN7yjN0aPmD18z9eey9pDm9cy/w6tYq8IGXe2CPdOSHkbh5IlMNKSTyRF248?=
 =?us-ascii?Q?F91Ih5rBOZvBtM/mSjwX0quuLdJJDqEl/ocjcCYEGWos+Xq4uMwKTM7djNGA?=
 =?us-ascii?Q?UBwMTJccv1tLMVBSJzEVGgkzxl8p46hsGgOnIWbByk35DNDMQORNlWq5+oLq?=
 =?us-ascii?Q?6TvefRT+knZat/uxqOQwZPDWiQ58+MRTzgUJFI7E8QKxYn6uLcXB96TKR2d2?=
 =?us-ascii?Q?R7jqfqxsaScMUEQ/oehFacdxbc6aOSwT0eXpyC5QKRUIeQSXgx0pNIbzjled?=
 =?us-ascii?Q?XfUdzRZGmWvE4pEeDOHD26YUBFQIU13u1QMM+16pRpC/8Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Jp4biRAniMbRNO7rnjMh+ABfMPaSo5iO6454hBwMyXc0BuPv/RbWKtLxQXgX?=
 =?us-ascii?Q?FwWsOrnmrZJdvND9hYMe0K0+cu0DbUsuV3YrYruDI+UBe5XYbkyjkze/HjzM?=
 =?us-ascii?Q?1w2yMlQtyOo204wwCRwKsRcagc0yD6V3mql/dbqh8V0pSlLBN0ZePbs+sD93?=
 =?us-ascii?Q?/8xtf4lv8+teFA8eVY0owRHm48Y4ZXaAO1uSdZNqiFQe/JD9HHIt2472tp7o?=
 =?us-ascii?Q?vpNpaF3CORUO8BGLGtTQWlH1vQXtQ51wQvymmlvYqsnMu0UT8IASwQjArgMT?=
 =?us-ascii?Q?JMceRG+vopkKMPiV4//su1z+ac/M3w/s2dwsMplvnOMFPUVpgVoVnchsa9ZY?=
 =?us-ascii?Q?bcZM16DQ8NtR5grD0Yk/+nsEmaQ4XSWZ1bX0Y0vvLOS14obS8UkePVd7O2b4?=
 =?us-ascii?Q?ALS16Eb/VA/8F3phHIJZ/BL3OoCEq8OBgcUzmlynkw5m+afhGO39dteo7ZVy?=
 =?us-ascii?Q?ccpl0qhyRW2KbWXwk8YQTzX6aFryUMRmkcc1A4a/+Zn1CvxKkfYjNA9qhQpS?=
 =?us-ascii?Q?DTxvtnhZnaEjEjewScTprHlv8z+qPLG8pNXvk1em//x2AaGiEzMUgmiSVNqN?=
 =?us-ascii?Q?68QY7izOrKMMPaiLry7NHwVfZyjyQQYM26SM9ZxTiEvO32mRuSI3NLGzr6Ip?=
 =?us-ascii?Q?rRljJwNiRVsbB6HmMMVsjcOlG7BcQ9+dLfbUgYUgG6Y7599aaOdWXR5uvXcj?=
 =?us-ascii?Q?FCi/rFVrXC9MA0KtnWIAb/LL8Fxzdzn06IDR4Uq/GsBSETBZRQSU4vuv8x1l?=
 =?us-ascii?Q?JStcC4EwJd9Op/L0u9utOMiGbjCjGSCTgJmCYQIwk3DOsK68B7aA4rNzi0YW?=
 =?us-ascii?Q?BZQGi3Cp1tVUvtC9tSN18pbuMKvjIsCA7AxdRk6w7V4N/GJuKgS7b5NR0fE7?=
 =?us-ascii?Q?cxpDndINEb/wFY4yLy5llFlxSjrB5v0bCbDd9BMJUSaSERDX7A9ulx5xR0xN?=
 =?us-ascii?Q?e7lFc9znw391Ig6c/UtyqaXw1QdEnqdZaVs/WUJabotXCeZr6mq7C0w4K/25?=
 =?us-ascii?Q?XTbFa4OIfKAR1olQSX1o7uiWp4ON5EMQWEvApTzhbEFciVj+tNLJ+kVGOsCj?=
 =?us-ascii?Q?h7QvnqdvsJ/rCDrZcNgEsVQvFv2qvo2gcDEv976omE0ivBytkzb8/j5pQ5Xx?=
 =?us-ascii?Q?K+X0P/lLul61vqeQ7E6LDTtd71taxdq09qb0Or3cRCAO+rfyvtNUt1Muwd2I?=
 =?us-ascii?Q?h2sQjuwKIPyXOBqgjdq4JqG/d2AcEz9xJJ11MJ5ejSfsL1WMG40X7ca6cE7v?=
 =?us-ascii?Q?uTpUv3NBuz8S7zRn8ULv4NHZ8aSXO5SqSe4RpzQE4dMkbfYzVZFJViivhYye?=
 =?us-ascii?Q?lZTLmzDe2bespspMC729X1hc0ThRX8bd+fojIZYvI2N7ifXNMKG2kOCmMxQM?=
 =?us-ascii?Q?yONv3RXCo6gUrlScT6cjkp7f8QHWxkU18sUd6JANQbr8aMrvfwLisQKL0FWa?=
 =?us-ascii?Q?cyhCL44uZ+1y9BShPYB/WhyhrQsDq9fKyrm/Bt5lYN5Q9IKODDQ+EEf74bQy?=
 =?us-ascii?Q?HIm+CEjKQHarNiN8duxrwAM76U8eUm238kMvF4KjGkIwTGP0AZaBbPTzC+bc?=
 =?us-ascii?Q?6cxg8IGszdjP81d9qhEkSZiLrvuey9S5Pip10h4X5FgWVdUBbrEifJucwHdR?=
 =?us-ascii?Q?Sg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	f/Ren/QJ4kHwT2kenfyXWocHrEXRuYF992yXZmfoha3g6SF3j5eu0XMDX6QMRN/uBuqw7mbJ1X7+BLEaJgAa7MSTk4Rv9ZxHRUh3pHniMPHuzj0/d27LHbojJvJfijVTeUqI4nuPzJRf81gC139a7TrDcPT1qB+Bj6mubhhsBwtsLuzBY3dI6Ay6dy4cPo29ROqXrIxmN2snsYOSzExSGjWICbo4KMLShsJPUA4Bsd0YK9L24CYr9JpPBywna2MwOviGjadnwn43Gef1Qb8kBXsfTQL3jK/N0m7+QI1TSccTI+hvOujdEy8B0oji1IPAyF+6762npIshcx99QxX1FXdQXes508atyRrP18BsKpzRqw1L3WjiKitP+zGaA86LHJK4Yp/bJDq/YQxy1JVtP2Sx2jwsZPm8F9zXsvDGr7aFEYHcP7XXswnOVSwgJYl1yV0HF42xsLQLYg2GDHyQLl6osqPzc9RUFV3Gin9guy/GZ4zgzJe4wdSi7UjjyEYdq0z3seRGriCxAyngkgtW4+X1+mZvynu5K//zfswe5LAc+8X5SDYkVT4l7OVlPOni208PNoviMOfPDfNphmh9jkb2ZZ+4OWS42QkVOf7aMYo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae5cf984-c393-44a5-47fe-08dce169b09c
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 16:05:23.3238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IpnJkNS8xOae3d+UNWhoggMXPe0YZ54n2ZxhMKVgJ9iv6mHk/2DrNywicDGlDSTL/v4ZlAgpE70tgEZkcTl7SsqH/FKI0VT3yyA1AhxJwBk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4152
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-09-30_15,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409300115
X-Proofpoint-GUID: l-9dtfG3RijMl3DpciyT-un0b-E_gFf3
X-Proofpoint-ORIG-GUID: l-9dtfG3RijMl3DpciyT-un0b-E_gFf3

On Fri, Sep 27, 2024 at 01:51:11PM GMT, Lorenzo Stoakes wrote:
> The existing generic pagewalk logic permits the walking of page tables,
> invoking callbacks at individual page table levels via user-provided
> mm_walk_ops callbacks.
>
> This is useful for traversing existing page table entries, but precludes
> the ability to establish new ones.
>
> Existing mechanism for performing a walk which also installs page table
> entries if necessary are heavily duplicated throughout the kernel, each
> with semantic differences from one another and largely unavailable for use
> elsewhere.
>
> Rather than add yet another implementation, we extend the generic pagewalk
> logic to enable the installation of page table entries by adding a new
> install_pte() callback in mm_walk_ops. If this is specified, then upon
> encountering a missing page table entry, we allocate and install a new one
> and continue the traversal.
>
> If a THP huge page is encountered, we make use of existing logic to split
> it. Then once we reach the PTE level, we invoke the install_pte() callback
> which provides a PTE entry to install. We do not support hugetlb at this
> stage.
>
> If this function returns an error, or an allocation fails during the
> operation, we abort the operation altogether. It is up to the caller to
> deal appropriately with partially populated page table ranges.
>
> If install_pte() is defined, the semantics of pte_entry() change - this
> callback is then only invoked if the entry already exists. This is a useful
> property, as it allows a caller to handle existing PTEs while installing
> new ones where necessary in the specified range.
>
> If install_pte() is not defined, then there is no functional difference to
> this patch, so all existing logic will work precisely as it did before.
>
> As we only permit the installation of PTEs where a mapping does not already
> exist there is no need for TLB management, however we do invoke
> update_mmu_cache() for architectures which require manual maintenance of
> mappings for other CPUs.
>
> We explicitly do not allow the existing page walk API to expose this
> feature as it is dangerous and intended for internal mm use only. Therefore
> we provide a new walk_page_range_mm() function exposed only to
> mm/internal.h.
>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  include/linux/pagewalk.h |  18 +++-
>  mm/internal.h            |   6 ++
>  mm/pagewalk.c            | 174 ++++++++++++++++++++++++++-------------
>  3 files changed, 136 insertions(+), 62 deletions(-)
>
> diff --git a/include/linux/pagewalk.h b/include/linux/pagewalk.h
> index f5eb5a32aeed..9700a29f8afb 100644
> --- a/include/linux/pagewalk.h
> +++ b/include/linux/pagewalk.h
> @@ -25,12 +25,15 @@ enum page_walk_lock {
>   *			this handler is required to be able to handle
>   *			pmd_trans_huge() pmds.  They may simply choose to
>   *			split_huge_page() instead of handling it explicitly.
> - * @pte_entry:		if set, called for each PTE (lowest-level) entry,
> - *			including empty ones
> + * @pte_entry:		if set, called for each PTE (lowest-level) entry
> + *			including empty ones, except if @install_pte is set.
> + *			If @install_pte is set, @pte_entry is called only for
> + *			existing PTEs.
>   * @pte_hole:		if set, called for each hole at all levels,
>   *			depth is -1 if not known, 0:PGD, 1:P4D, 2:PUD, 3:PMD.
>   *			Any folded depths (where PTRS_PER_P?D is equal to 1)
> - *			are skipped.
> + *			are skipped. If @install_pte is specified, this will
> + *			not trigger for any populated ranges.
>   * @hugetlb_entry:	if set, called for each hugetlb entry. This hook
>   *			function is called with the vma lock held, in order to
>   *			protect against a concurrent freeing of the pte_t* or
> @@ -51,6 +54,13 @@ enum page_walk_lock {
>   * @pre_vma:            if set, called before starting walk on a non-null vma.
>   * @post_vma:           if set, called after a walk on a non-null vma, provided
>   *                      that @pre_vma and the vma walk succeeded.
> + * @install_pte:        if set, missing page table entries are installed and
> + *                      thus all levels are always walked in the specified
> + *                      range. This callback is then invoked at the PTE level
> + *                      (having split any THP pages prior), providing the PTE to
> + *                      install. If allocations fail, the walk is aborted. This
> + *                      operation is only available for userland memory. Not
> + *                      usable for hugetlb ranges.
>   *
>   * p?d_entry callbacks are called even if those levels are folded on a
>   * particular architecture/configuration.
> @@ -76,6 +86,8 @@ struct mm_walk_ops {
>  	int (*pre_vma)(unsigned long start, unsigned long end,
>  		       struct mm_walk *walk);
>  	void (*post_vma)(struct mm_walk *walk);
> +	int (*install_pte)(unsigned long addr, unsigned long next,
> +			   pte_t *ptep, struct mm_walk *walk);
>  	enum page_walk_lock walk_lock;
>  };
>
> diff --git a/mm/internal.h b/mm/internal.h
> index 93083bbeeefa..1bfe45b7fa08 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -12,6 +12,7 @@
>  #include <linux/mm.h>
>  #include <linux/mm_inline.h>
>  #include <linux/pagemap.h>
> +#include <linux/pagewalk.h>
>  #include <linux/rmap.h>
>  #include <linux/swap.h>
>  #include <linux/swapops.h>
> @@ -1443,4 +1444,9 @@ static inline void accept_page(struct page *page)
>  }
>  #endif /* CONFIG_UNACCEPTED_MEMORY */
>
> +/* pagewalk.c */
> +int walk_page_range_mm(struct mm_struct *mm, unsigned long start,
> +		unsigned long end, const struct mm_walk_ops *ops,
> +		void *private);
> +
>  #endif	/* __MM_INTERNAL_H */
> diff --git a/mm/pagewalk.c b/mm/pagewalk.c
> index 461ea3bbd8d9..c3b9624948c1 100644
> --- a/mm/pagewalk.c
> +++ b/mm/pagewalk.c
> @@ -6,6 +6,8 @@
>  #include <linux/swap.h>
>  #include <linux/swapops.h>

We need to add an include here for asm/tlbflush.h I believe to make
update_mmu_cache() available, this was overlooked as for x86 this is included
through some other header.

I will add on respin.

>
> +#include "internal.h"
> +
>  /*
>   * We want to know the real level where a entry is located ignoring any
>   * folding of levels which may be happening. For example if p4d is folded then
> @@ -29,9 +31,23 @@ static int walk_pte_range_inner(pte_t *pte, unsigned long addr,
>  	int err = 0;
>
>  	for (;;) {
> -		err = ops->pte_entry(pte, addr, addr + PAGE_SIZE, walk);
> -		if (err)
> -		       break;
> +		if (ops->install_pte && pte_none(ptep_get(pte))) {
> +			pte_t new_pte;
> +
> +			err = ops->install_pte(addr, addr + PAGE_SIZE, &new_pte,
> +					       walk);
> +			if (err)
> +				break;
> +
> +			set_pte_at(walk->mm, addr, pte, new_pte);
> +			/* Non-present before, so for arches that need it. */
> +			if (!WARN_ON_ONCE(walk->no_vma))
> +				update_mmu_cache(walk->vma, addr, pte);
> +		} else {
> +			err = ops->pte_entry(pte, addr, addr + PAGE_SIZE, walk);
> +			if (err)
> +				break;
> +		}
>  		if (addr >= end - PAGE_SIZE)
>  			break;
>  		addr += PAGE_SIZE;
> @@ -89,11 +105,14 @@ static int walk_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
>  again:
>  		next = pmd_addr_end(addr, end);
>  		if (pmd_none(*pmd)) {
> -			if (ops->pte_hole)
> +			if (ops->install_pte)
> +				err = __pte_alloc(walk->mm, pmd);
> +			else if (ops->pte_hole)
>  				err = ops->pte_hole(addr, next, depth, walk);
>  			if (err)
>  				break;
> -			continue;
> +			if (!ops->install_pte)
> +				continue;
>  		}
>
>  		walk->action = ACTION_SUBTREE;
> @@ -116,7 +135,7 @@ static int walk_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
>  		 */
>  		if ((!walk->vma && (pmd_leaf(*pmd) || !pmd_present(*pmd))) ||
>  		    walk->action == ACTION_CONTINUE ||
> -		    !(ops->pte_entry))
> +		    !(ops->pte_entry || ops->install_pte))
>  			continue;
>
>  		if (walk->vma)
> @@ -148,11 +167,14 @@ static int walk_pud_range(p4d_t *p4d, unsigned long addr, unsigned long end,
>   again:
>  		next = pud_addr_end(addr, end);
>  		if (pud_none(*pud)) {
> -			if (ops->pte_hole)
> +			if (ops->install_pte)
> +				err = __pmd_alloc(walk->mm, pud, addr);
> +			else if (ops->pte_hole)
>  				err = ops->pte_hole(addr, next, depth, walk);
>  			if (err)
>  				break;
> -			continue;
> +			if (!ops->install_pte)
> +				continue;
>  		}
>
>  		walk->action = ACTION_SUBTREE;
> @@ -167,7 +189,7 @@ static int walk_pud_range(p4d_t *p4d, unsigned long addr, unsigned long end,
>
>  		if ((!walk->vma && (pud_leaf(*pud) || !pud_present(*pud))) ||
>  		    walk->action == ACTION_CONTINUE ||
> -		    !(ops->pmd_entry || ops->pte_entry))
> +		    !(ops->pmd_entry || ops->pte_entry || ops->install_pte))
>  			continue;
>
>  		if (walk->vma)
> @@ -196,18 +218,22 @@ static int walk_p4d_range(pgd_t *pgd, unsigned long addr, unsigned long end,
>  	do {
>  		next = p4d_addr_end(addr, end);
>  		if (p4d_none_or_clear_bad(p4d)) {
> -			if (ops->pte_hole)
> +			if (ops->install_pte)
> +				err = __pud_alloc(walk->mm, p4d, addr);
> +			else if (ops->pte_hole)
>  				err = ops->pte_hole(addr, next, depth, walk);
>  			if (err)
>  				break;
> -			continue;
> +			if (!ops->install_pte)
> +				continue;
>  		}
>  		if (ops->p4d_entry) {
>  			err = ops->p4d_entry(p4d, addr, next, walk);
>  			if (err)
>  				break;
>  		}
> -		if (ops->pud_entry || ops->pmd_entry || ops->pte_entry)
> +		if (ops->pud_entry || ops->pmd_entry || ops->pte_entry ||
> +		    ops->install_pte)
>  			err = walk_pud_range(p4d, addr, next, walk);
>  		if (err)
>  			break;
> @@ -231,18 +257,22 @@ static int walk_pgd_range(unsigned long addr, unsigned long end,
>  	do {
>  		next = pgd_addr_end(addr, end);
>  		if (pgd_none_or_clear_bad(pgd)) {
> -			if (ops->pte_hole)
> +			if (ops->install_pte)
> +				err = __p4d_alloc(walk->mm, pgd, addr);
> +			else if (ops->pte_hole)
>  				err = ops->pte_hole(addr, next, 0, walk);
>  			if (err)
>  				break;
> -			continue;
> +			if (!ops->install_pte)
> +				continue;
>  		}
>  		if (ops->pgd_entry) {
>  			err = ops->pgd_entry(pgd, addr, next, walk);
>  			if (err)
>  				break;
>  		}
> -		if (ops->p4d_entry || ops->pud_entry || ops->pmd_entry || ops->pte_entry)
> +		if (ops->p4d_entry || ops->pud_entry || ops->pmd_entry ||
> +		    ops->pte_entry || ops->install_pte)
>  			err = walk_p4d_range(pgd, addr, next, walk);
>  		if (err)
>  			break;
> @@ -334,6 +364,11 @@ static int __walk_page_range(unsigned long start, unsigned long end,
>  	int err = 0;
>  	struct vm_area_struct *vma = walk->vma;
>  	const struct mm_walk_ops *ops = walk->ops;
> +	bool is_hugetlb = is_vm_hugetlb_page(vma);
> +
> +	/* We do not support hugetlb PTE installation. */
> +	if (ops->install_pte && is_hugetlb)
> +		return -EINVAL;
>
>  	if (ops->pre_vma) {
>  		err = ops->pre_vma(start, end, walk);
> @@ -341,7 +376,7 @@ static int __walk_page_range(unsigned long start, unsigned long end,
>  			return err;
>  	}
>
> -	if (is_vm_hugetlb_page(vma)) {
> +	if (is_hugetlb) {
>  		if (ops->hugetlb_entry)
>  			err = walk_hugetlb_range(start, end, walk);
>  	} else
> @@ -380,47 +415,7 @@ static inline void process_vma_walk_lock(struct vm_area_struct *vma,
>  #endif
>  }
>
> -/**
> - * walk_page_range - walk page table with caller specific callbacks
> - * @mm:		mm_struct representing the target process of page table walk
> - * @start:	start address of the virtual address range
> - * @end:	end address of the virtual address range
> - * @ops:	operation to call during the walk
> - * @private:	private data for callbacks' usage
> - *
> - * Recursively walk the page table tree of the process represented by @mm
> - * within the virtual address range [@start, @end). During walking, we can do
> - * some caller-specific works for each entry, by setting up pmd_entry(),
> - * pte_entry(), and/or hugetlb_entry(). If you don't set up for some of these
> - * callbacks, the associated entries/pages are just ignored.
> - * The return values of these callbacks are commonly defined like below:
> - *
> - *  - 0  : succeeded to handle the current entry, and if you don't reach the
> - *         end address yet, continue to walk.
> - *  - >0 : succeeded to handle the current entry, and return to the caller
> - *         with caller specific value.
> - *  - <0 : failed to handle the current entry, and return to the caller
> - *         with error code.
> - *
> - * Before starting to walk page table, some callers want to check whether
> - * they really want to walk over the current vma, typically by checking
> - * its vm_flags. walk_page_test() and @ops->test_walk() are used for this
> - * purpose.
> - *
> - * If operations need to be staged before and committed after a vma is walked,
> - * there are two callbacks, pre_vma() and post_vma(). Note that post_vma(),
> - * since it is intended to handle commit-type operations, can't return any
> - * errors.
> - *
> - * struct mm_walk keeps current values of some common data like vma and pmd,
> - * which are useful for the access from callbacks. If you want to pass some
> - * caller-specific data to callbacks, @private should be helpful.
> - *
> - * Locking:
> - *   Callers of walk_page_range() and walk_page_vma() should hold @mm->mmap_lock,
> - *   because these function traverse vma list and/or access to vma's data.
> - */
> -int walk_page_range(struct mm_struct *mm, unsigned long start,
> +int walk_page_range_mm(struct mm_struct *mm, unsigned long start,
>  		unsigned long end, const struct mm_walk_ops *ops,
>  		void *private)
>  {
> @@ -479,6 +474,57 @@ int walk_page_range(struct mm_struct *mm, unsigned long start,
>  	return err;
>  }
>
> +/**
> + * walk_page_range - walk page table with caller specific callbacks
> + * @mm:		mm_struct representing the target process of page table walk
> + * @start:	start address of the virtual address range
> + * @end:	end address of the virtual address range
> + * @ops:	operation to call during the walk
> + * @private:	private data for callbacks' usage
> + *
> + * Recursively walk the page table tree of the process represented by @mm
> + * within the virtual address range [@start, @end). During walking, we can do
> + * some caller-specific works for each entry, by setting up pmd_entry(),
> + * pte_entry(), and/or hugetlb_entry(). If you don't set up for some of these
> + * callbacks, the associated entries/pages are just ignored.
> + * The return values of these callbacks are commonly defined like below:
> + *
> + *  - 0  : succeeded to handle the current entry, and if you don't reach the
> + *         end address yet, continue to walk.
> + *  - >0 : succeeded to handle the current entry, and return to the caller
> + *         with caller specific value.
> + *  - <0 : failed to handle the current entry, and return to the caller
> + *         with error code.
> + *
> + * Before starting to walk page table, some callers want to check whether
> + * they really want to walk over the current vma, typically by checking
> + * its vm_flags. walk_page_test() and @ops->test_walk() are used for this
> + * purpose.
> + *
> + * If operations need to be staged before and committed after a vma is walked,
> + * there are two callbacks, pre_vma() and post_vma(). Note that post_vma(),
> + * since it is intended to handle commit-type operations, can't return any
> + * errors.
> + *
> + * struct mm_walk keeps current values of some common data like vma and pmd,
> + * which are useful for the access from callbacks. If you want to pass some
> + * caller-specific data to callbacks, @private should be helpful.
> + *
> + * Locking:
> + *   Callers of walk_page_range() and walk_page_vma() should hold @mm->mmap_lock,
> + *   because these function traverse vma list and/or access to vma's data.
> + */
> +int walk_page_range(struct mm_struct *mm, unsigned long start,
> +		unsigned long end, const struct mm_walk_ops *ops,
> +		void *private)
> +{
> +	/* For internal use only. */
> +	if (ops->install_pte)
> +		return -EINVAL;
> +
> +	return walk_page_range_mm(mm, start, end, ops, private);
> +}
> +
>  /**
>   * walk_page_range_novma - walk a range of pagetables not backed by a vma
>   * @mm:		mm_struct representing the target process of page table walk
> @@ -494,7 +540,7 @@ int walk_page_range(struct mm_struct *mm, unsigned long start,
>   * walking the kernel pages tables or page tables for firmware.
>   *
>   * Note: Be careful to walk the kernel pages tables, the caller may be need to
> - * take other effective approache (mmap lock may be insufficient) to prevent
> + * take other effective approaches (mmap lock may be insufficient) to prevent
>   * the intermediate kernel page tables belonging to the specified address range
>   * from being freed (e.g. memory hot-remove).
>   */
> @@ -511,7 +557,7 @@ int walk_page_range_novma(struct mm_struct *mm, unsigned long start,
>  		.no_vma		= true
>  	};
>
> -	if (start >= end || !walk.mm)
> +	if (start >= end || !walk.mm || ops->install_pte)
>  		return -EINVAL;
>
>  	/*
> @@ -556,6 +602,9 @@ int walk_page_range_vma(struct vm_area_struct *vma, unsigned long start,
>  		return -EINVAL;
>  	if (start < vma->vm_start || end > vma->vm_end)
>  		return -EINVAL;
> +	/* For internal use only. */
> +	if (ops->install_pte)
> +		return -EINVAL;
>
>  	process_mm_walk_lock(walk.mm, ops->walk_lock);
>  	process_vma_walk_lock(vma, ops->walk_lock);
> @@ -574,6 +623,9 @@ int walk_page_vma(struct vm_area_struct *vma, const struct mm_walk_ops *ops,
>
>  	if (!walk.mm)
>  		return -EINVAL;
> +	/* For internal use only. */
> +	if (ops->install_pte)
> +		return -EINVAL;
>
>  	process_mm_walk_lock(walk.mm, ops->walk_lock);
>  	process_vma_walk_lock(vma, ops->walk_lock);
> @@ -623,6 +675,10 @@ int walk_page_mapping(struct address_space *mapping, pgoff_t first_index,
>  	unsigned long start_addr, end_addr;
>  	int err = 0;
>
> +	/* For internal use only. */
> +	if (ops->install_pte)
> +		return -EINVAL;
> +
>  	lockdep_assert_held(&mapping->i_mmap_rwsem);
>  	vma_interval_tree_foreach(vma, &mapping->i_mmap, first_index,
>  				  first_index + nr - 1) {
> --
> 2.46.2
>

