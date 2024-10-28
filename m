Return-Path: <linux-arch+bounces-8668-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 180E79B3D36
	for <lists+linux-arch@lfdr.de>; Mon, 28 Oct 2024 22:59:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B1491C21175
	for <lists+linux-arch@lfdr.de>; Mon, 28 Oct 2024 21:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC5C51FF7B7;
	Mon, 28 Oct 2024 21:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IrWB3QD2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DXNqRnVV"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4931DED5D;
	Mon, 28 Oct 2024 21:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730152226; cv=fail; b=aIPxceGzQFWSw4RBH3jfpz2+Y/K60KIH+Lu+rQzeC0uPQCrsL8DyVSbFIpHcylXXOgAgM/bydDK5hq3W7O+Im5lWAVABpwWcjj0xSvC8+CScCj5pUvqlQlrprMsQs8THf/WJZvIaKnceI/NFepulfsIbS4820Ynhg91VbC7Y/+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730152226; c=relaxed/simple;
	bh=7YOd1e9qnKxEePbjDBwTjSL5EW+0W/NcC7TauAUMQks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Vhqym6J0C5SyD8rPCdSPm9bIxWnq6rgPt8RkHePKmk40EdNJaQ41sDDhZCdp7g7D/37pQYrqzNMsCpCZQBzpt54ZgIoDgZn9k5oSp5r9jrxx8RDLTUWcTO9/w+CEw3QriqWW0yvex4gyIxlvDxvjGEDMr/3Aeq7d65LaCbQn018=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IrWB3QD2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DXNqRnVV; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49SKtZk3032518;
	Mon, 28 Oct 2024 21:49:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=/RRVun6DcYnmm2IIvb
	oeeOrLjzAg9HqpcY9yAt1oLLQ=; b=IrWB3QD24h50E1sZAfhXxXSj7GN1p/y3YD
	7rwE3L/VErx0+JWVGSObYwuDTxxgtyjYvbwcxB+ZiLIn9osa8bynaDjQPqlYt7ck
	6nSdnvw+CiFym2b6bV58l0WjCwdPmlQLiz5KA/sa913QYgrXPBs5WvAQrZe/B6v8
	vjVj576DBovwKqRwu+5zv5DV/k828C4BcAWSFzKwt6mLt+6A2trjavUTwXeNt+Le
	8dp8uriuqC5KVE6RSTN+4+v3EJAbMwb4BleAaaP9OWlG4XitLSd9JlsyD+r5NHNP
	A4LDsQpRW26x5HZn80QdDRS3sBD3tmpjJWJNu0XiPpNTbzfRgFOA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grc1v0ef-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Oct 2024 21:49:46 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49SL2UM6011745;
	Mon, 28 Oct 2024 21:49:45 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2040.outbound.protection.outlook.com [104.47.58.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42hnabfef6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Oct 2024 21:49:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xFVEA1TaDZSZNASyTqYHS2oeGBGcboLxYlxbIhVzr6mw2uVOf2J9zbnSM6PIu29oa9n9SIGNzjFSsg7tOlAbEVUx0Am+DZL3OSISgbgQ2ARmXnjaqV/1B5xF3cYmLxIYnVHtScBWFpUWaTMrOoLnAiDojpQQQ8iViDUmBRg5qlNUle50iPhww4nHtFfnq7Blho8+5czQjrr5X/ohnn3h6GqaplKj9rtsN+F7YPfoYez198wi5gK2EcercJVsdBUXG8hpjjBgEQUI57GSj3qoRM5XG4LCmt/+Z+TkuDXio4DKefTCFy+Hxxq4D8Lp/9WV5El69WN/mfiVKYP675VZMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/RRVun6DcYnmm2IIvboeeOrLjzAg9HqpcY9yAt1oLLQ=;
 b=gwM7pBetnA2KVxa1zsDL4X45ycds9OVQdeAkzm6rxDKE9AGrQSi01O2I7mol45cMC+2BE4/DA1CmhPI+MI8LfgTpqFyp0FzsrAqoYairF4+G44UIcsfLUe8hYR36uiUxSk6jSOHHG0QaUpx4B8nx7trLviLOepXCBLXGkQFMUFSF5hIXePmYS3108/PKeVBbaX+OKWd7c1boz02fZdrbPrUbDpr6zczxN557qjRr8l2kOlNz+FwWZ6ulY7UwpUZL2ilIyx23yaHyqp4Zs081mi2TrIrRqjLTtZ4FewCSr9uKruvt//3Knv7Hj6K1eia+ZxCerG2kfIxw2yJ3WVQUwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/RRVun6DcYnmm2IIvboeeOrLjzAg9HqpcY9yAt1oLLQ=;
 b=DXNqRnVVEb8P28qaGg8kehGGLCmMzyjh4VTPHp3AzY9AteqQgxSllI2MxakwUKdi7PosJNuViY4CnPmAdaAJ1lYqbfHNWwj1VnZCdY4753UKByyz1W0JKaXWw+7adQCZ25ehzybVEbfKYl+OAR/XW23Co6KBuxaAXu0yfaJVB9E=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by CH3PR10MB7835.namprd10.prod.outlook.com (2603:10b6:610:1af::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Mon, 28 Oct
 2024 21:49:42 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8093.024; Mon, 28 Oct 2024
 21:49:42 +0000
Date: Mon, 28 Oct 2024 21:49:38 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        "Paul E . McKenney" <paulmck@kernel.org>, Jann Horn <jannh@google.com>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Muchun Song <muchun.song@linux.dev>,
        Richard Henderson <richard.henderson@linaro.org>,
        Matt Turner <mattst88@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>, Arnd Bergmann <arnd@kernel.org>,
        linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-arch@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>,
        linux-kselftest@vger.kernel.org,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Jeff Xu <jeffxu@chromium.org>, Christoph Hellwig <hch@infradead.org>,
        linux-api@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v3 1/5] mm: pagewalk: add the ability to install PTEs
Message-ID: <5f623df5-6361-4aba-a43c-72d68f5f1ca4@lucifer.local>
References: <cover.1729699916.git.lorenzo.stoakes@oracle.com>
 <9be732fd0e897453116b433fe2f468ef7795602e.1729699916.git.lorenzo.stoakes@oracle.com>
 <D57Q27X7GB4O.3P6DI32885K96@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D57Q27X7GB4O.3P6DI32885K96@kernel.org>
X-ClientProxiedBy: LO4P265CA0131.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c6::12) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|CH3PR10MB7835:EE_
X-MS-Office365-Filtering-Correlation-Id: e18bf3f0-3546-42c6-e78b-08dcf79a6dc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?I2M0cbZT0G0zWOEHC9q649POqNs2BjkRulxI+pX3VjKgaf6+TVzmna65BLae?=
 =?us-ascii?Q?6QjA3sVMkLN3lwdXw7BpodjYx51jUg4Dzgqfx5GRSN4EzLRyh1dh265+KUlU?=
 =?us-ascii?Q?fRrSO1fksbUE6sN8t+QNc1BwvOK1U4XhZqLQbOwrKQmK1Cpbmflb+uyTU6IQ?=
 =?us-ascii?Q?mAswnZuDaCbCmxcyZHUVWp62TKIdheYVDcOD8Pn2HRJJe0CkhxHJPZQQTCmg?=
 =?us-ascii?Q?1LpiO2ApuZivCuWz/tTTNq2P0d7+pSv4lzyB2+3t0Ev0u0shrihN5/DhH7mV?=
 =?us-ascii?Q?dFPgJrqJLf/rdM1gvYxRLv5M3U25HfHQ1ly2RjcJRgjiL2SWRlI/chWWxvnC?=
 =?us-ascii?Q?apIxSeVBC/xjJMklUP9BQtSpPfXFKxcxDFPe7324MLpBsaHJRNX2f1vP0ezY?=
 =?us-ascii?Q?QBDp7STgaSaDC7azG+bMk5sp3vOB4NuTdBBkfIrXy3Zv4rbe0k5f6Nw7NAvU?=
 =?us-ascii?Q?d5/yzshweYJO32S/me1NgmAqbQvif4BlnyKTsZi756ku1tAIjYOV1qZjgSlX?=
 =?us-ascii?Q?2/PzGSUaqvdym3l1C2hn6Z9GfKztabzx6r5sze95fBI9rEWB3zqKyyg+/YnR?=
 =?us-ascii?Q?bfOJJ30zIErz18Q0/bzyC3T0QuqsoAKEDDV3UaFNqpOpo4hBWeYkfdik89U1?=
 =?us-ascii?Q?BhOSkn3YiL+XZfG04r8K6R6kcigc6IF2GTcHmCd8bHVsfhYdtPmRb90kfe+5?=
 =?us-ascii?Q?qtOXr73rtPuu9WGu1sStUyrU90NEYoHECu7CYo6++4H96A0nJ3A+rLTWFrD3?=
 =?us-ascii?Q?GIyABVx7KquDPnb1x3unBGIaPat0M8xSgttotpGYtuELoKWFYY/DimjcS+AY?=
 =?us-ascii?Q?DPwx8JMFrH/w1GerpeyY9+FX7CdynIov0RmrYZm6BnQizNJoujqE9jTbHRug?=
 =?us-ascii?Q?9pKQ+4hhGHsWbaaWkckhVNQgIFVPPXePDgGH8Axobw0/rm9f7vut921ttBG6?=
 =?us-ascii?Q?nOIhixebngrqr5nW5pzdEGk+MQuVESbHyIO1NazsZX6BlrUnvCrhoxnaK4H2?=
 =?us-ascii?Q?q+4esT0ggeGg0oBKSyp1Ge9BvW9eKGsT7InZP2ZlXq4W9YoA0CdF1BJvlXdp?=
 =?us-ascii?Q?gX9qJ58UbCu6FAEBh5LUpC7lI2XOCI/8g0UmlhCabFAZi1qfQ7yz9839lAhy?=
 =?us-ascii?Q?3G9ZV5+ISD8F3eAFAEerwFC2XGrjZp6+GM2pU+8hnGUCOu2tMkVeUjUnUCQP?=
 =?us-ascii?Q?/OaIAJ5eBdHunpqFgCnwCEXexK/hshH/CeBYah9CIUSOEyrN08/PI4Y1nfxP?=
 =?us-ascii?Q?+53CczrsEYpwYBcLCDN0Df+U22KJLjDlYXFahvy5nswvemRE1DWvmG+0A1h0?=
 =?us-ascii?Q?OHY+j1pUJ23ecmOiTqLB+wQk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/rXk/Jhxw1G0SEcWXcIpd74Uy5i9FluJKF7E4SpkjvITmsFvT4tgOw8Sbi3s?=
 =?us-ascii?Q?ISOYQ7nFpZO6Vb3E9jtQxriVns5EY2n2vnjPWOif0YoJa/DHzgexwBuAoeEe?=
 =?us-ascii?Q?7wgpu/hyznbzpLnaALoBurAJXDhftz5ZBi7TMjrwPcB13Kuv6cI6dLt8ctGd?=
 =?us-ascii?Q?QwtTxpu7sTYOxvgRCCgdCaIR2mVoQNqE3n06qxn6RAzsIJ2ft6WIbBU41oM4?=
 =?us-ascii?Q?JzOq7ea5DPBS7pbuQn/ffWuyWmNiSiGOme06SrKqYmSl0ICx1z2b39F6rrSA?=
 =?us-ascii?Q?+4PdoM7uGjlDK1yYQoT3zcyeymCBuSMRHHuwdawbgTiAnu4m5NHa7KIuQhGr?=
 =?us-ascii?Q?N0uLIumiXxsfbZLDOZq+/88b/TkkLIlLsBm63BKWBSTYIGzZNGAVq3o7wWcg?=
 =?us-ascii?Q?hiioZ1NkB55HWTDYag4XqcCd8dSOUQlSONq4o0WTBEZhpIBFqndWBWaK7xBg?=
 =?us-ascii?Q?mrSTUtGyz3yZMOnT/OCmkZ/Kc2rjZ1Qb0O9UO/EvHwq2VmYKdkolvKl/WRno?=
 =?us-ascii?Q?SvKGiHR1mB5CtO4zSnirIFV853VxSSDhQnBAto3pMMqs3UTezspm1R70ANOE?=
 =?us-ascii?Q?04cwIBL9+5KvRecdslblH83e/rRWUCQt+XDsnizdQF+2SefmS0o5I3FbzGm1?=
 =?us-ascii?Q?fYOb2Mnxq9X9IzJPYlaeQKFMJoYeRUTzTKLGX03xrntnbhZWXBN0K7cpudH4?=
 =?us-ascii?Q?oN3Hvm87OKBtW0kBFibb1+8q2eBQGpdT7Ca9M0Vs7TER4oXO1z5OiGSZ5dE7?=
 =?us-ascii?Q?2K0BexH8RYB/iv3km35ZhYYUKGGAYdv3V9H9oTgHpelgGqLBvHegpe0cetkn?=
 =?us-ascii?Q?BFvZdmZGzOpViqsuSfVtvLIJhdbjMvZB3Y+dWy4N+IyGSzP1UODPJ5/JcW2l?=
 =?us-ascii?Q?TpT1UvUGrofaBmq1uFfcTUr0jqSRtKGogOUOdMsJeAu1qFfIRPag6LDKR17H?=
 =?us-ascii?Q?PFtNjsgWdJcOdNEFZxv8QJPIfI4eRaJd1WLBKuiq42dOJ02+QGyBsVj1bCFo?=
 =?us-ascii?Q?yW/dlX1sF8ZXkL5O1aJt+eMFR6Uo5y8+adhCSB3XNCaDmvoCrT9Vau7JttLE?=
 =?us-ascii?Q?rXTKI/HfLvUsljT/GDULOESYHoqAyzEaSbV7iTSLHxmHoCytrSrfKrfDywiG?=
 =?us-ascii?Q?aPy6LpDjjCtXG0weEqiNS+i1EkhHtHb/OxtPtoQPDS8JAGw7iAZAnXeSmtsG?=
 =?us-ascii?Q?RuKDAwdBw9EnJPe3goInsEEFCYBCw1jGxbfq/2hIfnNvvun9GXT05bxmAXPW?=
 =?us-ascii?Q?dJzppwCw+gbI/psFwRm6bVUnqDs5ZxbfqNG/Q3vTU55w96DH+1p/UMG9CIW+?=
 =?us-ascii?Q?/JKUAS5eK6IAEwkxFWwyek1VFqJoSSaFamQeSWcwK79IbflyXIa6ZxPdPsFp?=
 =?us-ascii?Q?tk5uBc1rzjsGZMnp9aiFm5Z4gP6Qo/rL7x6Hvdk7+prxcmYz5UtNG1xaG60e?=
 =?us-ascii?Q?NCxhAjMzbETYwOuG7IlY+qNaLAIB5DTnAE50q30IaJ+yvNckFAf/ChUgW/p2?=
 =?us-ascii?Q?SZT7/5qk+ZtebOBJJiYNVCIHArBzeQ0sc3qL/CcFrViaU69J0J7cMrdqb/Wq?=
 =?us-ascii?Q?23P5+R/4HAyBBBYU/7fZcI9H7J+06e0AxsiZNH+rcuPlw7vU8BM9vkWdJhXv?=
 =?us-ascii?Q?ag=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SN9FUt2t/MhdQV3WLGJfJaDilzfMfCxopDN2u3HUMv6OTk5QHYw13uIY95PcBsWlGpBfpck357PH4Ud5MEIDucvaYJru+ioodLJostCNCZzgAKWhP0LihgdteP5Tb3Ko77YX4i0KiDTzDKmE9oHk4gBPP+NVZtHTTJE9yXhOoniakuXgiRF4v7/zkLYEoLMM9WjrelZpNAOq8scIvLTZVrG93YXs4BsWCUCW2ttkL+bK+7jhrRSExBABBUhUDYvqq1jfskMbzydrXr1WBH9Z6meVdGrxLDft6iqeaHWsxOFyNN0UziVVZi6lSq5qTkS4GfYgF8SPvwji9iAOlgnGL8/jYPC5elAaSOuOcde/D2MQjK4548an6ZZrSr7YVG0C2rkc1wgWEqu/mAhBCPocl9etduCSBJgetQEd0ZhdkOQtPRcf6DyRf4M+EUf45SglN1AKIGOfOIksPMmlGltumpJHUqy2Gwjmr1eM8nqAp314Kcj7kbQhG+txEqOVl5i2MTuLwmJ55DoZ3sSu64TI1JKMLv9uLoL2e0mn0+wm+hk+gwGtdzPeaQ659cBhIq1o7ln8ZvgV4LFV8t5D8pgYDZhudlKar6gJjwdIZQEwxvg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e18bf3f0-3546-42c6-e78b-08dcf79a6dc1
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 21:49:42.0965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fDn4RAx+8lcanBT9+e4DfneHpsow7sKbuXs131E6c26OMK2dGoV/Cjbep1neKaztD5s5PDoIMvGbpps5O1j3+UDJlv/YtxDYP5Kn7W/dKd4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7835
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-28_10,2024-10-28_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 bulkscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410280170
X-Proofpoint-GUID: YzYrklb0yPOB0rQU5FuSXaF0vcWrvhoV
X-Proofpoint-ORIG-GUID: YzYrklb0yPOB0rQU5FuSXaF0vcWrvhoV

Note there's a v4 :)

On Mon, Oct 28, 2024 at 10:29:44PM +0200, Jarkko Sakkinen wrote:
> On Wed Oct 23, 2024 at 7:24 PM EEST, Lorenzo Stoakes wrote:
> > The existing generic pagewalk logic permits the walking of page tables,
> > invoking callbacks at individual page table levels via user-provided
> > mm_walk_ops callbacks.
> >
> > This is useful for traversing existing page table entries, but precludes
> > the ability to establish new ones.
> >
> > Existing mechanism for performing a walk which also installs page table
> > entries if necessary are heavily duplicated throughout the kernel, each
> > with semantic differences from one another and largely unavailable for use
> > elsewhere.
> >
> > Rather than add yet another implementation, we extend the generic pagewalk
> > logic to enable the installation of page table entries by adding a new
> > install_pte() callback in mm_walk_ops. If this is specified, then upon
> > encountering a missing page table entry, we allocate and install a new one
> > and continue the traversal.
> >
> > If a THP huge page is encountered at either the PMD or PUD level we split
> > it only if there are ops->pte_entry() (or ops->pmd_entry at PUD level),
> > otherwise if there is only an ops->install_pte(), we avoid the unnecessary
> > split.
>
> Just for interest: does this mean that the operation is always
> "destructive" (i.e. modifying state) even when install_pte() does not
> do anything, i.e. does the split alway happen despite what the callback
> does? Not really expert on this but this paragraph won't leave me
> alone :-)

Well no as I say (perhaps not clearly) if something already exists we don't
even split huge pages. We only do so if you explicitly ask to examine page
tables levels below those where a huge page may exist.

The guard page code goes to great lengths to avoid this in all cases and
doesn't split at all.

>
> >
> > We do not support hugetlb at this stage.
> >
> > If this function returns an error, or an allocation fails during the
> > operation, we abort the operation altogether. It is up to the caller to
> > deal appropriately with partially populated page table ranges.
> >
> > If install_pte() is defined, the semantics of pte_entry() change - this
> > callback is then only invoked if the entry already exists. This is a useful
> > property, as it allows a caller to handle existing PTEs while installing
> > new ones where necessary in the specified range.
> >
> > If install_pte() is not defined, then there is no functional difference to
> > this patch, so all existing logic will work precisely as it did before.
> >
> > As we only permit the installation of PTEs where a mapping does not already
> > exist there is no need for TLB management, however we do invoke
> > update_mmu_cache() for architectures which require manual maintenance of
> > mappings for other CPUs.
> >
> > We explicitly do not allow the existing page walk API to expose this
> > feature as it is dangerous and intended for internal mm use only. Therefore
> > we provide a new walk_page_range_mm() function exposed only to
> > mm/internal.h.
> >
> > Reviewed-by: Jann Horn <jannh@google.com>
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > ---
> >  include/linux/pagewalk.h |  18 +++-
> >  mm/internal.h            |   6 ++
> >  mm/pagewalk.c            | 227 +++++++++++++++++++++++++++------------
> >  3 files changed, 182 insertions(+), 69 deletions(-)
> >
> > diff --git a/include/linux/pagewalk.h b/include/linux/pagewalk.h
> > index f5eb5a32aeed..9700a29f8afb 100644
> > --- a/include/linux/pagewalk.h
> > +++ b/include/linux/pagewalk.h
> > @@ -25,12 +25,15 @@ enum page_walk_lock {
> >   *			this handler is required to be able to handle
> >   *			pmd_trans_huge() pmds.  They may simply choose to
> >   *			split_huge_page() instead of handling it explicitly.
> > - * @pte_entry:		if set, called for each PTE (lowest-level) entry,
> > - *			including empty ones
> > + * @pte_entry:		if set, called for each PTE (lowest-level) entry
> > + *			including empty ones, except if @install_pte is set.
> > + *			If @install_pte is set, @pte_entry is called only for
> > + *			existing PTEs.
> >   * @pte_hole:		if set, called for each hole at all levels,
> >   *			depth is -1 if not known, 0:PGD, 1:P4D, 2:PUD, 3:PMD.
> >   *			Any folded depths (where PTRS_PER_P?D is equal to 1)
> > - *			are skipped.
> > + *			are skipped. If @install_pte is specified, this will
> > + *			not trigger for any populated ranges.
> >   * @hugetlb_entry:	if set, called for each hugetlb entry. This hook
> >   *			function is called with the vma lock held, in order to
> >   *			protect against a concurrent freeing of the pte_t* or
> > @@ -51,6 +54,13 @@ enum page_walk_lock {
> >   * @pre_vma:            if set, called before starting walk on a non-null vma.
> >   * @post_vma:           if set, called after a walk on a non-null vma, provided
> >   *                      that @pre_vma and the vma walk succeeded.
> > + * @install_pte:        if set, missing page table entries are installed and
> > + *                      thus all levels are always walked in the specified
> > + *                      range. This callback is then invoked at the PTE level
> > + *                      (having split any THP pages prior), providing the PTE to
> > + *                      install. If allocations fail, the walk is aborted. This
> > + *                      operation is only available for userland memory. Not
> > + *                      usable for hugetlb ranges.
>
> Given that especially walk_page_range_novma() has bunch of call sites,
> it would not hurt to mention here simply that only for mm-internal use
> with not much other explanation.

We explicitly document this in multiple places. A user will very quickly
discover this is not available.

I will adjust this blurb if I need to do a respin.

>
> >   *
> >   * p?d_entry callbacks are called even if those levels are folded on a
> >   * particular architecture/configuration.
> > @@ -76,6 +86,8 @@ struct mm_walk_ops {
> >  	int (*pre_vma)(unsigned long start, unsigned long end,
> >  		       struct mm_walk *walk);
> >  	void (*post_vma)(struct mm_walk *walk);
> > +	int (*install_pte)(unsigned long addr, unsigned long next,
> > +			   pte_t *ptep, struct mm_walk *walk);
> >  	enum page_walk_lock walk_lock;
> >  };
> >
> > diff --git a/mm/internal.h b/mm/internal.h
> > index 508f7802dd2b..fb1fb0c984e4 100644
> > --- a/mm/internal.h
> > +++ b/mm/internal.h
> > @@ -12,6 +12,7 @@
> >  #include <linux/mm.h>
> >  #include <linux/mm_inline.h>
> >  #include <linux/pagemap.h>
> > +#include <linux/pagewalk.h>
> >  #include <linux/rmap.h>
> >  #include <linux/swap.h>
> >  #include <linux/swapops.h>
> > @@ -1451,4 +1452,9 @@ static inline void accept_page(struct page *page)
> >  }
> >  #endif /* CONFIG_UNACCEPTED_MEMORY */
> >
> > +/* pagewalk.c */
> > +int walk_page_range_mm(struct mm_struct *mm, unsigned long start,
> > +		unsigned long end, const struct mm_walk_ops *ops,
> > +		void *private);
> > +
> >  #endif	/* __MM_INTERNAL_H */
> > diff --git a/mm/pagewalk.c b/mm/pagewalk.c
> > index 5f9f01532e67..f3cbad384344 100644
> > --- a/mm/pagewalk.c
> > +++ b/mm/pagewalk.c
> > @@ -3,9 +3,14 @@
> >  #include <linux/highmem.h>
> >  #include <linux/sched.h>
> >  #include <linux/hugetlb.h>
> > +#include <linux/mmu_context.h>
> >  #include <linux/swap.h>
> >  #include <linux/swapops.h>
> >
> > +#include <asm/tlbflush.h>
> > +
> > +#include "internal.h"
> > +
> >  /*
> >   * We want to know the real level where a entry is located ignoring any
> >   * folding of levels which may be happening. For example if p4d is folded then
> > @@ -29,9 +34,23 @@ static int walk_pte_range_inner(pte_t *pte, unsigned long addr,
> >  	int err = 0;
> >
> >  	for (;;) {
> > -		err = ops->pte_entry(pte, addr, addr + PAGE_SIZE, walk);
> > -		if (err)
> > -		       break;
> > +		if (ops->install_pte && pte_none(ptep_get(pte))) {
> > +			pte_t new_pte;
> > +
> > +			err = ops->install_pte(addr, addr + PAGE_SIZE, &new_pte,
> > +					       walk);
> > +			if (err)
> > +				break;
> > +
> > +			set_pte_at(walk->mm, addr, pte, new_pte);
> > +			/* Non-present before, so for arches that need it. */
> > +			if (!WARN_ON_ONCE(walk->no_vma))
> > +				update_mmu_cache(walk->vma, addr, pte);
> > +		} else {
> > +			err = ops->pte_entry(pte, addr, addr + PAGE_SIZE, walk);
> > +			if (err)
> > +				break;
> > +		}
> >  		if (addr >= end - PAGE_SIZE)
> >  			break;
> >  		addr += PAGE_SIZE;
> > @@ -89,11 +108,14 @@ static int walk_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
> >  again:
> >  		next = pmd_addr_end(addr, end);
> >  		if (pmd_none(*pmd)) {
> > -			if (ops->pte_hole)
> > +			if (ops->install_pte)
> > +				err = __pte_alloc(walk->mm, pmd);
> > +			else if (ops->pte_hole)
> >  				err = ops->pte_hole(addr, next, depth, walk);
> >  			if (err)
> >  				break;
> > -			continue;
> > +			if (!ops->install_pte)
> > +				continue;
> >  		}
> >
> >  		walk->action = ACTION_SUBTREE;
> > @@ -109,18 +131,19 @@ static int walk_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
> >
> >  		if (walk->action == ACTION_AGAIN)
> >  			goto again;
> > -
> > -		/*
> > -		 * Check this here so we only break down trans_huge
> > -		 * pages when we _need_ to
> > -		 */
> > -		if ((!walk->vma && (pmd_leaf(*pmd) || !pmd_present(*pmd))) ||
> > -		    walk->action == ACTION_CONTINUE ||
> > -		    !(ops->pte_entry))
> > +		if (walk->action == ACTION_CONTINUE)
> >  			continue;
> > +		if (!ops->install_pte && !ops->pte_entry)
> > +			continue; /* Nothing to do. */
> > +		if (!ops->pte_entry && ops->install_pte &&
> > +		    pmd_present(*pmd) &&
> > +		    (pmd_trans_huge(*pmd) || pmd_devmap(*pmd)))
> > +			continue; /* Avoid unnecessary split. */
> >
> >  		if (walk->vma)
> >  			split_huge_pmd(walk->vma, pmd, addr);
> > +		else if (pmd_leaf(*pmd) || !pmd_present(*pmd))
> > +			continue; /* Nothing to do. */
> >
> >  		err = walk_pte_range(pmd, addr, next, walk);
> >  		if (err)
> > @@ -148,11 +171,14 @@ static int walk_pud_range(p4d_t *p4d, unsigned long addr, unsigned long end,
> >   again:
> >  		next = pud_addr_end(addr, end);
> >  		if (pud_none(*pud)) {
> > -			if (ops->pte_hole)
> > +			if (ops->install_pte)
> > +				err = __pmd_alloc(walk->mm, pud, addr);
> > +			else if (ops->pte_hole)
> >  				err = ops->pte_hole(addr, next, depth, walk);
> >  			if (err)
> >  				break;
> > -			continue;
> > +			if (!ops->install_pte)
> > +				continue;
> >  		}
> >
> >  		walk->action = ACTION_SUBTREE;
> > @@ -164,14 +190,20 @@ static int walk_pud_range(p4d_t *p4d, unsigned long addr, unsigned long end,
> >
> >  		if (walk->action == ACTION_AGAIN)
> >  			goto again;
> > -
> > -		if ((!walk->vma && (pud_leaf(*pud) || !pud_present(*pud))) ||
> > -		    walk->action == ACTION_CONTINUE ||
> > -		    !(ops->pmd_entry || ops->pte_entry))
> > +		if (walk->action == ACTION_CONTINUE)
> >  			continue;
> > +		if (!ops->install_pte && !ops->pte_entry && !ops->pmd_entry)
> > +			continue;  /* Nothing to do. */
> > +		if (!ops->pmd_entry && !ops->pte_entry && ops->install_pte &&
> > +		    pud_present(*pud) &&
> > +		    (pud_trans_huge(*pud) || pud_devmap(*pud)))
> > +			continue; /* Avoid unnecessary split. */
> >
> >  		if (walk->vma)
> >  			split_huge_pud(walk->vma, pud, addr);
> > +		else if (pud_leaf(*pud) || !pud_present(*pud))
> > +			continue; /* Nothing to do. */
> > +
> >  		if (pud_none(*pud))
> >  			goto again;
> >
> > @@ -196,18 +228,22 @@ static int walk_p4d_range(pgd_t *pgd, unsigned long addr, unsigned long end,
> >  	do {
> >  		next = p4d_addr_end(addr, end);
> >  		if (p4d_none_or_clear_bad(p4d)) {
> > -			if (ops->pte_hole)
> > +			if (ops->install_pte)
> > +				err = __pud_alloc(walk->mm, p4d, addr);
> > +			else if (ops->pte_hole)
> >  				err = ops->pte_hole(addr, next, depth, walk);
> >  			if (err)
> >  				break;
> > -			continue;
> > +			if (!ops->install_pte)
> > +				continue;
> >  		}
> >  		if (ops->p4d_entry) {
> >  			err = ops->p4d_entry(p4d, addr, next, walk);
> >  			if (err)
> >  				break;
> >  		}
> > -		if (ops->pud_entry || ops->pmd_entry || ops->pte_entry)
> > +		if (ops->pud_entry || ops->pmd_entry || ops->pte_entry ||
> > +		    ops->install_pte)
> >  			err = walk_pud_range(p4d, addr, next, walk);
> >  		if (err)
> >  			break;
> > @@ -231,18 +267,22 @@ static int walk_pgd_range(unsigned long addr, unsigned long end,
> >  	do {
> >  		next = pgd_addr_end(addr, end);
> >  		if (pgd_none_or_clear_bad(pgd)) {
> > -			if (ops->pte_hole)
> > +			if (ops->install_pte)
> > +				err = __p4d_alloc(walk->mm, pgd, addr);
> > +			else if (ops->pte_hole)
> >  				err = ops->pte_hole(addr, next, 0, walk);
> >  			if (err)
> >  				break;
> > -			continue;
> > +			if (!ops->install_pte)
> > +				continue;
> >  		}
> >  		if (ops->pgd_entry) {
> >  			err = ops->pgd_entry(pgd, addr, next, walk);
> >  			if (err)
> >  				break;
> >  		}
> > -		if (ops->p4d_entry || ops->pud_entry || ops->pmd_entry || ops->pte_entry)
> > +		if (ops->p4d_entry || ops->pud_entry || ops->pmd_entry ||
> > +		    ops->pte_entry || ops->install_pte)
> >  			err = walk_p4d_range(pgd, addr, next, walk);
> >  		if (err)
> >  			break;
> > @@ -334,6 +374,11 @@ static int __walk_page_range(unsigned long start, unsigned long end,
> >  	int err = 0;
> >  	struct vm_area_struct *vma = walk->vma;
> >  	const struct mm_walk_ops *ops = walk->ops;
> > +	bool is_hugetlb = is_vm_hugetlb_page(vma);
> > +
> > +	/* We do not support hugetlb PTE installation. */
> > +	if (ops->install_pte && is_hugetlb)
> > +		return -EINVAL;
> >
> >  	if (ops->pre_vma) {
> >  		err = ops->pre_vma(start, end, walk);
> > @@ -341,7 +386,7 @@ static int __walk_page_range(unsigned long start, unsigned long end,
> >  			return err;
> >  	}
> >
> > -	if (is_vm_hugetlb_page(vma)) {
> > +	if (is_hugetlb) {
> >  		if (ops->hugetlb_entry)
> >  			err = walk_hugetlb_range(start, end, walk);
> >  	} else
> > @@ -380,47 +425,14 @@ static inline void process_vma_walk_lock(struct vm_area_struct *vma,
> >  #endif
> >  }
> >
> > -/**
> > - * walk_page_range - walk page table with caller specific callbacks
> > - * @mm:		mm_struct representing the target process of page table walk
> > - * @start:	start address of the virtual address range
> > - * @end:	end address of the virtual address range
> > - * @ops:	operation to call during the walk
> > - * @private:	private data for callbacks' usage
> > - *
> > - * Recursively walk the page table tree of the process represented by @mm
> > - * within the virtual address range [@start, @end). During walking, we can do
> > - * some caller-specific works for each entry, by setting up pmd_entry(),
> > - * pte_entry(), and/or hugetlb_entry(). If you don't set up for some of these
> > - * callbacks, the associated entries/pages are just ignored.
> > - * The return values of these callbacks are commonly defined like below:
> > - *
> > - *  - 0  : succeeded to handle the current entry, and if you don't reach the
> > - *         end address yet, continue to walk.
> > - *  - >0 : succeeded to handle the current entry, and return to the caller
> > - *         with caller specific value.
> > - *  - <0 : failed to handle the current entry, and return to the caller
> > - *         with error code.
> > - *
> > - * Before starting to walk page table, some callers want to check whether
> > - * they really want to walk over the current vma, typically by checking
> > - * its vm_flags. walk_page_test() and @ops->test_walk() are used for this
> > - * purpose.
> > - *
> > - * If operations need to be staged before and committed after a vma is walked,
> > - * there are two callbacks, pre_vma() and post_vma(). Note that post_vma(),
> > - * since it is intended to handle commit-type operations, can't return any
> > - * errors.
> > - *
> > - * struct mm_walk keeps current values of some common data like vma and pmd,
> > - * which are useful for the access from callbacks. If you want to pass some
> > - * caller-specific data to callbacks, @private should be helpful.
> > +/*
> > + * See the comment for walk_page_range(), this performs the heavy lifting of the
> > + * operation, only sets no restrictions on how the walk proceeds.
> >   *
> > - * Locking:
> > - *   Callers of walk_page_range() and walk_page_vma() should hold @mm->mmap_lock,
> > - *   because these function traverse vma list and/or access to vma's data.
> > + * We usually restrict the ability to install PTEs, but this functionality is
> > + * available to internal memory management code and provided in mm/internal.h.
> >   */
> > -int walk_page_range(struct mm_struct *mm, unsigned long start,
> > +int walk_page_range_mm(struct mm_struct *mm, unsigned long start,
> >  		unsigned long end, const struct mm_walk_ops *ops,
> >  		void *private)
> >  {
> > @@ -479,6 +491,80 @@ int walk_page_range(struct mm_struct *mm, unsigned long start,
> >  	return err;
> >  }
> >
> > +/*
> > + * Determine if the walk operations specified are permitted to be used for a
> > + * page table walk.
> > + *
> > + * This check is performed on all functions which are parameterised by walk
> > + * operations and exposed in include/linux/pagewalk.h.
> > + *
> > + * Internal memory management code can use the walk_page_range_mm() function to
> > + * be able to use all page walking operations.
> > + */
> > +static bool check_ops_valid(const struct mm_walk_ops *ops)
> > +{
> > +	/*
> > +	 * The installation of PTEs is solely under the control of memory
> > +	 * management logic and subject to many subtle locking, security and
> > +	 * cache considerations so we cannot permit other users to do so, and
> > +	 * certainly not for exported symbols.
> > +	 */
> > +	if (ops->install_pte)
> > +		return false;
> > +
> > +	return true;
>
> or "return !!(ops->install_pte);"
>
> > +}
>
> Alternatively one could consider defining "struct mm_walk_internal_ops",
> which would be only available in internal.h but I guess there is good
> reasons to do it way it is.

Yes.

>
> > +
> > +/**
> > + * walk_page_range - walk page table with caller specific callbacks
> > + * @mm:		mm_struct representing the target process of page table walk
> > + * @start:	start address of the virtual address range
> > + * @end:	end address of the virtual address range
> > + * @ops:	operation to call during the walk
> > + * @private:	private data for callbacks' usage
> > + *
> > + * Recursively walk the page table tree of the process represented by @mm
> > + * within the virtual address range [@start, @end). During walking, we can do
> > + * some caller-specific works for each entry, by setting up pmd_entry(),
> > + * pte_entry(), and/or hugetlb_entry(). If you don't set up for some of these
> > + * callbacks, the associated entries/pages are just ignored.
> > + * The return values of these callbacks are commonly defined like below:
> > + *
> > + *  - 0  : succeeded to handle the current entry, and if you don't reach the
> > + *         end address yet, continue to walk.
> > + *  - >0 : succeeded to handle the current entry, and return to the caller
> > + *         with caller specific value.
> > + *  - <0 : failed to handle the current entry, and return to the caller
> > + *         with error code.
> > + *
> > + * Before starting to walk page table, some callers want to check whether
> > + * they really want to walk over the current vma, typically by checking
> > + * its vm_flags. walk_page_test() and @ops->test_walk() are used for this
> > + * purpose.
> > + *
> > + * If operations need to be staged before and committed after a vma is walked,
> > + * there are two callbacks, pre_vma() and post_vma(). Note that post_vma(),
> > + * since it is intended to handle commit-type operations, can't return any
> > + * errors.
> > + *
> > + * struct mm_walk keeps current values of some common data like vma and pmd,
> > + * which are useful for the access from callbacks. If you want to pass some
> > + * caller-specific data to callbacks, @private should be helpful.
> > + *
> > + * Locking:
> > + *   Callers of walk_page_range() and walk_page_vma() should hold @mm->mmap_lock,
> > + *   because these function traverse vma list and/or access to vma's data.
> > + */
> > +int walk_page_range(struct mm_struct *mm, unsigned long start,
> > +		unsigned long end, const struct mm_walk_ops *ops,
> > +		void *private)
> > +{
> > +	if (!check_ops_valid(ops))
> > +		return -EINVAL;
> > +
> > +	return walk_page_range_mm(mm, start, end, ops, private);
> > +}
> > +
> >  /**
> >   * walk_page_range_novma - walk a range of pagetables not backed by a vma
> >   * @mm:		mm_struct representing the target process of page table walk
> > @@ -494,7 +580,7 @@ int walk_page_range(struct mm_struct *mm, unsigned long start,
> >   * walking the kernel pages tables or page tables for firmware.
> >   *
> >   * Note: Be careful to walk the kernel pages tables, the caller may be need to
> > - * take other effective approache (mmap lock may be insufficient) to prevent
> > + * take other effective approaches (mmap lock may be insufficient) to prevent
> >   * the intermediate kernel page tables belonging to the specified address range
> >   * from being freed (e.g. memory hot-remove).
> >   */
> > @@ -513,6 +599,8 @@ int walk_page_range_novma(struct mm_struct *mm, unsigned long start,
> >
> >  	if (start >= end || !walk.mm)
> >  		return -EINVAL;
> > +	if (!check_ops_valid(ops))
> > +		return -EINVAL;
> >
> >  	/*
> >  	 * 1) For walking the user virtual address space:
> > @@ -556,6 +644,8 @@ int walk_page_range_vma(struct vm_area_struct *vma, unsigned long start,
> >  		return -EINVAL;
> >  	if (start < vma->vm_start || end > vma->vm_end)
> >  		return -EINVAL;
> > +	if (!check_ops_valid(ops))
> > +		return -EINVAL;
> >
> >  	process_mm_walk_lock(walk.mm, ops->walk_lock);
> >  	process_vma_walk_lock(vma, ops->walk_lock);
> > @@ -574,6 +664,8 @@ int walk_page_vma(struct vm_area_struct *vma, const struct mm_walk_ops *ops,
> >
> >  	if (!walk.mm)
> >  		return -EINVAL;
> > +	if (!check_ops_valid(ops))
> > +		return -EINVAL;
> >
> >  	process_mm_walk_lock(walk.mm, ops->walk_lock);
> >  	process_vma_walk_lock(vma, ops->walk_lock);
> > @@ -623,6 +715,9 @@ int walk_page_mapping(struct address_space *mapping, pgoff_t first_index,
> >  	unsigned long start_addr, end_addr;
> >  	int err = 0;
> >
> > +	if (!check_ops_valid(ops))
> > +		return -EINVAL;
> > +
> >  	lockdep_assert_held(&mapping->i_mmap_rwsem);
> >  	vma_interval_tree_foreach(vma, &mapping->i_mmap, first_index,
> >  				  first_index + nr - 1) {
>
> So I took a random patch set in order to learn how to compile Fedora Ark
> kernel out of any upstream tree (mm in this case), thus making noise
> here.
>
> With this goal, which mainly to be able to do such thing once or twice
> per release cycle:
>
> Tested-by: Jarkko Sakkinen <jarkko@kernel.org>
>
> BR, Jarkko

Thanks!

