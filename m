Return-Path: <linux-arch+bounces-15463-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A96CC205C
	for <lists+linux-arch@lfdr.de>; Tue, 16 Dec 2025 11:49:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 95BC6302218F
	for <lists+linux-arch@lfdr.de>; Tue, 16 Dec 2025 10:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8561523BCF3;
	Tue, 16 Dec 2025 10:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cNUocf+H";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="r0GplmiK"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0193D45948;
	Tue, 16 Dec 2025 10:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765882145; cv=fail; b=s+KLdITe7iGa4v/sy73GwWibeHWn8Veqay1GGE++JSwmCchrbgjskelN+dyYdHMBmQii2Z6LaTvKL+7BjS4U2Ho2m0CrLnq2CnpP7WRG9/l0DM33IGW7f8KzdrjbJ+muvIbNObcppKGlIwDc12DV6f2DmreTxMHeI1642YEaF4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765882145; c=relaxed/simple;
	bh=WQLFLuhc9U2S3wWvV30+SzzeMyzkCz6ZlgGVKU5weKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OjDKHMWvnKKThYnp8NmxackCQPSnPDEK5eC1Mb70JjNdx4+N28ZihK7MKI07yZemOnnem+ij9Iasp7LRQ9OdaU8kDQOcpnqVBDKe2DYP+0SiXKveEHoD9xqR/jLW+U43qchuTkqR6a3JZfC5qk11qName5h1lIUt85C1PEujHYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cNUocf+H; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=r0GplmiK; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BGACB4k338698;
	Tue, 16 Dec 2025 10:47:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=zHnGIj3GJ3gFpFAaG6
	jyab8ltQ1ExdkYtAsDUCgs9c8=; b=cNUocf+HCadEouG5DDE4npVkCrA2aHFGo4
	VfrVX8h3qSlePXudlz2Ve/WDCJhjalZUCWOm4YvChIJQvWaoWjmiM0AqvrMaUdNP
	HDFEwP2mQLRiL4d8VWdGvEs/QnKm+d/zR+OmB6elxHmYqB/ZUcLtFqTuIfePNByW
	WgUsxuhGyp/qykj7TRbVmvLTtadNP+jxUSZnlhyfA91qqBwIa5dHKQdotdu2AWxV
	kcT9B9ReEmvwcr7Jvrktn+3sU/axGNSly3wbZNfJdKYqP9L5aVFeWiWc4IVPLf2o
	ZW6RRWKisLe2NdERlcPBv/X13cxfZIScW90YwxvArWb2JDh0yLuw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b106cbq0a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Dec 2025 10:47:27 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BG8Z9rk016318;
	Tue, 16 Dec 2025 10:47:27 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010054.outbound.protection.outlook.com [40.93.198.54])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4b0xkkkuu5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Dec 2025 10:47:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nhzBDme0aycr8o0VIWtU9x+Sr5wWq4FfCQ2/lmrtHkTE60seD1Xx32vaaTHj2AeRySq1PQSa0/RGH9pUeyid2u5gPzFJ3ZH07zggee/kJl4fEow36rQi0VvzNzGjNQ9J7UExqrkuuhIPZ7G7UBaatxNhL/kmJ4QGhCoHizltV3Ny5hhmY4/pn9AJeZXNL+y3wy12Uo6bAS0sp6mUwoA0vq+Yl8ilsneMvVegdB7448ELnaU3MLoudm0HznGgL6CWu/eSHp4b8d3SOLncZzONpA6Uz3dlKmOb+/J+lkgBTn2B3gd7EskodshfwIu4FtXhlG55BhO0M4/27ZzFZFaeuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zHnGIj3GJ3gFpFAaG6jyab8ltQ1ExdkYtAsDUCgs9c8=;
 b=m7NkGhutR74/zu1R1k17GYHP7U3J5OL3PZ/ODad8GJcQNE9jcs9MeySj5Y+w7Qp4WW9Mp4ia4WOhOnW9xijgGbV9BFJ1KlKCWihMW3EWzIgJ/6rSZMdtJ9cSsyvNUT2Gei5cN7/31SFMWHFb5YvyrXF/yx51i4InB5cBH74aYC2JiyDgGsOmtTLkH51su9jaKmRzrqvLBDv0479tWZraQ8hou3NRZV7TIv+Cb8jGh9Fvl9slfI0pfbizQE2o6SwS6hGLzjfY87KJrv61hGsHjgg85AW2Ip3gkPu/6UGwpff5U1IE1dc9Qo6tX5k5Juske8U9f5hmM1us5IG0uv+QgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zHnGIj3GJ3gFpFAaG6jyab8ltQ1ExdkYtAsDUCgs9c8=;
 b=r0GplmiKBjKwfc2p/aAzuFeA12lgkhoipBjSXQKH7HGCTfWjIvCeF7cl6bfVd48O4mYxWSrsXQHnyN4ywAJrxNIALKgaGnn/3KHPtpPYp5FBDwdWAB+MNWJWQM6iu7x+mMy1O183xm/9uKCjd/5bD3tVqFjM25DMgHc2au+wfMA=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by DM4PR10MB6838.namprd10.prod.outlook.com (2603:10b6:8:106::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 10:47:22 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%6]) with mapi id 15.20.9412.011; Tue, 16 Dec 2025
 10:47:22 +0000
Date: Tue, 16 Dec 2025 10:47:21 +0000
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
        Nadav Amit <nadav.amit@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 4/4] mm/hugetlb: fix excessive IPI broadcasts when
 unsharing PMD tables using mmu_gather
Message-ID: <a70b1979-5a91-40a2-a1ba-326aff2208ae@lucifer.local>
References: <20251212071019.471146-1-david@kernel.org>
 <20251212071019.471146-5-david@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251212071019.471146-5-david@kernel.org>
X-ClientProxiedBy: LO0P123CA0006.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:354::8) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|DM4PR10MB6838:EE_
X-MS-Office365-Filtering-Correlation-Id: 30eb1e42-185f-4c15-ae35-08de3c907da6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6P3WIPjIqZERZBkOTSgPY5a7iKkZ/ypQIOAUy8yL3xDKuJAKMIWMm8j0dTMS?=
 =?us-ascii?Q?fFMnSZg/XdhmUQU9bDRQdCz/aGHDuG3t5pxXJVKg6A49W91JN//oAdXhL2OE?=
 =?us-ascii?Q?VbUs6dWxZzvSzU3ViC/9zNG+5hNJ3d2I+Pzc2u5BNGwfMxKghRd/qjaKnFa3?=
 =?us-ascii?Q?9NBmi9qsK8iF6ph4ETM5byDmNtPw0O2arDwfEuFKZvkZvMtMzcnzX5Lnek07?=
 =?us-ascii?Q?JFrcNCQPs1AS7BOxsrLt/1NRAPTh6+cXREDJ1asO9hQ7+SyDuvawOn+Fh+z9?=
 =?us-ascii?Q?VpvMpe0wlhSJpbfAYVUv9zEa+Cp+lzVEtSHBjoqRkP1QLR9Hh83yFwdjsLHS?=
 =?us-ascii?Q?l2iMcItp+/f8jK1rP/LJLsfwbAaDeUIvi7po9BgqtQEfi2Yz+CMqKctl3+T0?=
 =?us-ascii?Q?BiuJ2yS5GfFINCKi3ppnHjjrLtaGT/3IG6hVugudG6S5ERIw3R7G9iz6WDDb?=
 =?us-ascii?Q?lUhO8Ig35SoLXvxanXywF4+bi5qP6d6eIkrotuT5+Rp4E4EnDuFkDigkGrMb?=
 =?us-ascii?Q?n7YwiXR7xkRGE2hAk7/IUit//T/PHviV1U/XNKhCasQD44qvTujESNZe1vON?=
 =?us-ascii?Q?2d8oOM90FShxRPrAj2jneKC9/l+ELPZPvBeAZHqu3P6Kn5+s41ajJutu3aev?=
 =?us-ascii?Q?U2/ZR7kIVhPR6ElD1TgQE1xITcGD12RA1x0bykrCDkGCDagu6opgkM/OvFeo?=
 =?us-ascii?Q?O21hrGNE44djsiwSI3OVIYehevlVKuvx1msnpwUtU8mnjf9K2pc0G3C4bSWN?=
 =?us-ascii?Q?p1VAj2ngyyp10Ksu7ef+pMKkd29/V7a9fFygpbRioBd8sIII3EujyeG/ldy+?=
 =?us-ascii?Q?uV3CnA/3CTSWwKaB+V31jlhfG5wGUv/iTT5L5+vRBtNTLa3j05U0ftcdIHsI?=
 =?us-ascii?Q?3op37dR7uCp/GGqQev57EDSTQiPcPkZ33LkdQmdDJ/vOiYOe/EPsZ5DBpoed?=
 =?us-ascii?Q?L9+tvRTUbCZkxL3LmBwsG6G/W+KxtE+4zXnqw4+ZbMG7f0Gm9ZlXzjtQGf4k?=
 =?us-ascii?Q?zYH51As63Q8QoM5XVEjnNIQF0rI+mJOvFceiwjAMH1LPDuEzs4pZyKyFYFrw?=
 =?us-ascii?Q?4w84jyvtGxcZXsOLcN3eow/uWnQUCxdHbKgqdJSBL+ox1brvOebXzvayC4P8?=
 =?us-ascii?Q?gH6xKJKbRf4uHtMporu4to828kzMeds2baiUxG7XTZc6SnbFczyIArJ8ItTV?=
 =?us-ascii?Q?BnzIzxcVYvhILlsbXJuNH1LUJJFv6i0T52t3/ckbDeC+qtseI4RrR/GwZUSs?=
 =?us-ascii?Q?PWcedBXYBeDENVMcL0NavLZ9ZWbkGz7SCVizXDpVu4PVVg9R9Kz8FU/+15da?=
 =?us-ascii?Q?ARMsQBgkcEj5UaL0vDEDTmfTOE6tO9QKonBQk3qRVFz1atJeOZVnUY1/b57O?=
 =?us-ascii?Q?Sni6t3unS0fy0rRVYI/V8Rks8yg0RR4g/uDpi53vqCoyVwBt0vjeNQ6ME2xu?=
 =?us-ascii?Q?hh9BJqXnYjwBFPc19zMU+G7/mFsx16FuQ4T9WXaSUxa2Hsz5dHn1EA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TNwcgXyGhQe1MlZ/5pBv6xANWtmJPsRTWH2B4W5fqku8qiVtQMfOVGDWLqNV?=
 =?us-ascii?Q?WJNktt4wbf9b2DTuV9NVUJbDIVYWZQj+5UIMlJz934hJJ/yrUCYMGodPcPG6?=
 =?us-ascii?Q?/+hmNqCUiw7Fiomi/j4ZRCfQmqGMUxEE6WTKjwuc2tp4p/+UxB6Izs/ilsBs?=
 =?us-ascii?Q?7SMd62WKG92sIIyq4YvHOMLf9IMTOesCnx5O4jD9IryAuCSfmWeCmbFMY8UD?=
 =?us-ascii?Q?W9NcRglvK05QpwUjrEZJSvdYZBOQ9SzJSbnN/LKvC9r5BvXQZ/RrfYGYlc1w?=
 =?us-ascii?Q?Sc2Ar5bCtECcG6A1MwYiQzVuI/coqYEtCtyheE/G67s7QU3j+O8L+IVPg3+o?=
 =?us-ascii?Q?hX8uYXWvGRWaBzczrtqLd4c+Jocqp1W5duRZIBpglKnHJ/zNtBr8Lky+9Tjc?=
 =?us-ascii?Q?OOxnye3vh6S3o1jf3iBaF/LvMaVXb5VoVEn5+8Z+V9Cn3rZhfLap2orEAsu8?=
 =?us-ascii?Q?c1bXvWqKtGd+diel4HOLANK1iAnvrBgLTRX5gmieX8hVggHGY0tisl35iwfF?=
 =?us-ascii?Q?yrCb8tzsdl3OFmgAVL5ste3jy1yfX/Gf8HiE3gC7baBUc2M29r/RG1E2+S8v?=
 =?us-ascii?Q?T4a2BaYAiDxEnbsC5fy7kX9a82x6TJBpdN9N4Uyuypc0ZqW25VbbZycUmH3G?=
 =?us-ascii?Q?UKQlbK6c43LQ3zblTGqo4im4wak/JoGfow6wrUi/+Byz9Ty7JhG53xF0qO0w?=
 =?us-ascii?Q?IAVu30INoFIUA70DggY8pTBk94dFdlw/CwLyzfAiHqpadn1zok832XdEgrJL?=
 =?us-ascii?Q?hknCawld1XC4Xc+PQmTQ/lUNXVCv4WX4D319pJslGVJGxfDtXtBOE15Nfvl4?=
 =?us-ascii?Q?PfHna7gDP5wwDqfumvh5o1V+fx6yz8fzQyEq+aFuG7PrsffECxDh/oCJgNS3?=
 =?us-ascii?Q?yvf66adtg/t5Pr3QDuCNQw7oEpDPkXmdqrBP7mIEYYjBQ1XVeDDwfKyNUc5v?=
 =?us-ascii?Q?DBum1i4zh698pFa8MOlE3RpN2jHlYvYhUjsJ0h70qv9fkM2smZns8uSX79SZ?=
 =?us-ascii?Q?EcUO3L7CYMqviRYq7dg3faKJnhRtlJicm5Buyr++UxQmtFrKKFlRb+a+V9tD?=
 =?us-ascii?Q?5c9lbVYLJlPiNoda0XMzNq9QSjEzRq1F4R3hgXJUeKXB4ezGv0IM8QuwhCgK?=
 =?us-ascii?Q?ij87rF5NJWil0/11lIVrQrUyEV/pNmlkQRhuTuvz/6wO6toVkVTH8+2PSUwK?=
 =?us-ascii?Q?chRuqnLGL026FFGI/6DH0fUgoZhO1+Q0njjDg8UfcfrNRoGo0k2wIJh7AHkq?=
 =?us-ascii?Q?1CR0yqgOKf/kNNV/WdydAxasFpKyCuOvkfrWN1bfYxacehBkOBPD5XpHjJ+m?=
 =?us-ascii?Q?EbkQtWraCdsh8Lgj0hwB0PKKLXmxHcp+PKRcpSMpoVh/unuOWK6Xm63ooOOI?=
 =?us-ascii?Q?+aewOIGGf9op5wMnERD11xbNnRuRkzC61WsSPpD63SoeR5XoVfaJl4hq13V9?=
 =?us-ascii?Q?4HUDSSXfvCdtM0Egh1XSS3QCg/nAK8wTfVXbh3g7Er+pXjVwQxwfO2K4ECX1?=
 =?us-ascii?Q?vRKaxEsjZcbjhL0W/6y1ujYJqsEl6R4OIHncthDKto0+CYAszScNPLpji8CN?=
 =?us-ascii?Q?rdYVJDTdT1zEyTRkkTpZu4wTd3R+j5qEttRUmblz9q+fbWglDLYi9ANsAlDQ?=
 =?us-ascii?Q?AQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	e98iCfRvuToknMufHx/i1F9o8gbYpa33a/qU8/KsCYW0fhK0zPOtVezryLKaR51F3Idqqh9omJcP5kYpYC6M2uyYzAJTPBDnkcKjrO/a8FbmrR/5W6T5HbDjVKxP22gMKQDXkUPpm6Y91/y4olnjDD4Wyl1HMQvrcdkKCi0kY7ntM90ZkudxQ6HAlq8tC8DBme0/KqocpHHP5mCkc9BXyNVUa0Yhmjpv2KLAYnqEdFSMUhF6pYvRX7PjAOEZJ/y/hQmpXz1pfb1OnPwm6fuYvI8fXXFMOhZmLuQ3INDR7HKElAcLXR4s8GZrvMwfEgGJNj+u2D2OvDBpM2r3eShu6aIx2OfCZ5s5MhkqVMYkeV88tLcn92XFQTzX07uT5oSVibJvYiLtUzLyxGLmRg6rAaDryUJVDgXp68WRJXMIpJQEBK3jtrBSNpEjHc+brrQFiEk1eCz3E8yJztOzzx/AQ0R1uANLQivpJwnCBu32GV0vQHA4+UCE1vcaqCb9NQnNWFjNq+5yJ/L+QI/KfX54jZum1oMc/QsHMsYtrCA8BcYAHLh1l45EopfuVF6C/CIuOYx54MaB5q9gGSr43FNtnIqDieq0VmqF7FqjbgadkZ0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30eb1e42-185f-4c15-ae35-08de3c907da6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 10:47:22.1447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +3JiJPGYAKOmiZimeKR2BMLCfy8pjATaxQeXLNYUmFBZMt2a/JYMMR9cXk7O1U5WEUpCwtHUH8yKnimMO/jC/W2u4Kg0vqdbNjSsKZ+RcrY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6838
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-16_02,2025-12-15_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 mlxscore=0
 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512160090
X-Proofpoint-ORIG-GUID: 0gSaJYgh3u3InpNITuDGZqwcxrhhlI_P
X-Proofpoint-GUID: 0gSaJYgh3u3InpNITuDGZqwcxrhhlI_P
X-Authority-Analysis: v=2.4 cv=et/SD4pX c=1 sm=1 tr=0 ts=694138bf b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=pKZnElRZrDUNvwj5VfYA:9
 a=MK45fKWU_Qe-xWZO:21 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12110
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE2MDA5MSBTYWx0ZWRfX7ckRXdeiZkt0
 EPnRbu4VG8x87NpCnp4hb+zciZo+o6sqtTtUFP/WX+AY22DphoNm8ByJEx3xELjnLVU/ZNd78lc
 fQdt38mncsokdtFh1JCTFpIE/PNTnOM+6pUQEnEknO3Yuc01/SJfNa6ugWFRBD0+M5HrgYJT5PY
 AOWWA5k9Gz06cRgsASob9IP/KDIn3Z4dbnSfXNXxVtFwyTJ5ThwSJ2ZXwzQgRSr0epEmo7CihGG
 uRKPL2n7Anyc4b3YRGCZl5Y5foSj3Bojqi3Q5Iwfc8UpeDJ3jGeIWPNnPklC6JjBjP/vzY4t6fb
 84nk4wdBXoRJ11yteKYEHbrjQLN4weyuiw4kEFrAZExwq1G+Ba3EzBAbBdl6yKnbpmYE8agvq8P
 1hqOrBvhtZ5qJeZkBYojgtWIAA9+9ZFfr4rcA98HWt3s6vXO92U=

On Fri, Dec 12, 2025 at 08:10:19AM +0100, David Hildenbrand (Red Hat) wrote:
> As reported, ever since commit 1013af4f585f ("mm/hugetlb: fix
> huge_pmd_unshare() vs GUP-fast race") we can end up in some situations
> where we perform so many IPI broadcasts when unsharing hugetlb PMD page
> tables that it severely regresses some workloads.
>
> In particular, when we fork()+exit(), or when we munmap() a large
> area backed by many shared PMD tables, we perform one IPI broadcast per
> unshared PMD table.
>
> There are two optimizations to be had:
>
> (1) When we process (unshare) multiple such PMD tables, such as during
>     exit(), it is sufficient to send a single IPI broadcast (as long as
>     we respect locking rules) instead of one per PMD table.
>
>     Locking prevents that any of these PMD tables could get reuse before
>     we drop the lock.
>
> (2) When we are not the last sharer (> 2 users including us), there is
>     no need to send the IPI broadcast. The shared PMD tables cannot
>     become exclusive (fully unshared) before an IPI will be broadcasted
>     by the last sharer.
>
>     Concurrent GUP-fast could walk into a PMD table just before we
>     unshared it. It could then succeed in grabbing a page from the
>     shared page table even after munmap() etc succeeded (and supressed
>     an IPI). But there is not difference compared to GUP-fast just
>     sleeping for a while after grabbing the page and re-enabling IRQs.
>
>     Most importantly, GUP-fast will never walk into page tables that are
>     no-longer shared, because the last sharer will issue an IPI
>     broadcast.
>
>     (if ever required, checking whether the PUD changed in GUP-fast
>      after grabbing the page like we do in the PTE case could handle
>      this)
>
> So let's rework PMD sharing TLB flushing + IPI sync to use the mmu_gather
> infrastructure so we can implement these optimizations and demystify the
> code at least a bit. Extend the mmu_gather infrastructure to be able to
> deal with our special hugetlb PMD table sharing implementation.
>
> We'll consolidate the handling for (full) unsharing of PMD tables in
> tlb_unshare_pmd_ptdesc() and tlb_flush_unshared_tables(), and track
> in "struct mmu_gather" whether we had (full) unsharing of PMD tables.
>
> Because locking is very special (concurrent unsharing+reuse must be
> prevented), we disallow deferring flushing to tlb_finish_mmu() and instead
> require an explicit earlier call to tlb_flush_unshared_tables().
>
> From hugetlb code, we call huge_pmd_unshare_flush() where we make sure
> that the expected lock protecting us from concurrent unsharing+reuse is
> still held.
>
> Check with a VM_WARN_ON_ONCE() in tlb_finish_mmu() that
> tlb_flush_unshared_tables() was properly called earlier.
>
> Document it all properly.
>
> Notes about tlb_remove_table_sync_one() interaction with unsharing:
>
> There are two fairly tricky things:
>
> (1) tlb_remove_table_sync_one() is a NOP on architectures without
>     CONFIG_MMU_GATHER_RCU_TABLE_FREE.
>
>     Here, the assumption is that the previous TLB flush would send an
>     IPI to all relevant CPUs. Careful: some architectures like x86 only
>     send IPIs to all relevant CPUs when tlb->freed_tables is set.
>
>     The relevant architectures should be selecting
>     MMU_GATHER_RCU_TABLE_FREE, but x86 might not do that in stable
>     kernels and it might have been problematic before this patch.
>
>     Also, the arch flushing behavior (independent of IPIs) is different
>     when tlb->freed_tables is set. Do we have to enlighten them to also
>     take care of tlb->unshared_tables? So far we didn't care, so
>     hopefully we are fine. Of course, we could be setting
>     tlb->freed_tables as well, but that might then unnecessarily flush
>     too much, because the semantics of tlb->freed_tables are a bit
>     fuzzy.
>
>     This patch changes nothing in this regard.
>
> (2) tlb_remove_table_sync_one() is not a NOP on architectures with
>     CONFIG_MMU_GATHER_RCU_TABLE_FREE that actually don't need a sync.
>
>     Take x86 as an example: in the common case (!pv, !X86_FEATURE_INVLPGB)
>     we still issue IPIs during TLB flushes and don't actually need the
>     second tlb_remove_table_sync_one().
>
>     This optimized can be implemented on top of this, by checking e.g., in
>     tlb_remove_table_sync_one() whether we really need IPIs. But as
>     described in (1), it really must honor tlb->freed_tables then to
>     send IPIs to all relevant CPUs.
>
> Further note that the ptdesc_pmd_pts_dec() in huge_pmd_share() is not a
> concern, as we are holding the i_mmap_lock the whole time, preventing
> concurrent unsharing. That ptdesc_pmd_pts_dec() usage will be removed
> separately as a cleanup later.
>
> There are plenty more cleanups to be had, but they have to wait until
> this is fixed.
>
> Fixes: 1013af4f585f ("mm/hugetlb: fix huge_pmd_unshare() vs GUP-fast race")
> Reported-by: Uschakow, Stanislav" <suschako@amazon.de>
> Closes: https://lore.kernel.org/all/4d3878531c76479d9f8ca9789dc6485d@amazon.de/
> Tested-by: Laurence Oberman <loberman@redhat.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: David Hildenbrand (Red Hat) <david@kernel.org>

After discussion on v1 4/4, and running a git range-diff between the two, this
LGTM, so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  include/asm-generic/tlb.h |  74 ++++++++++++++++++++++-
>  include/linux/hugetlb.h   |  19 +++---
>  mm/hugetlb.c              | 121 ++++++++++++++++++++++----------------
>  mm/mmu_gather.c           |   7 +++
>  mm/mprotect.c             |   2 +-
>  mm/rmap.c                 |  25 +++++---
>  6 files changed, 179 insertions(+), 69 deletions(-)
>
> diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
> index 1fff717cae510..706416babb3d6 100644
> --- a/include/asm-generic/tlb.h
> +++ b/include/asm-generic/tlb.h
> @@ -364,6 +364,20 @@ struct mmu_gather {
>  	unsigned int		vma_huge : 1;
>  	unsigned int		vma_pfn  : 1;
>
> +	/*
> +	 * Did we unshare (unmap) any shared page tables? For now only
> +	 * used for hugetlb PMD table sharing.
> +	 */
> +	unsigned int		unshared_tables : 1;
> +
> +	/*
> +	 * Did we unshare any page tables such that they are now exclusive
> +	 * and could get reused+modified by the new owner? When setting this
> +	 * flag, "unshared_tables" will be set as well. For now only used
> +	 * for hugetlb PMD table sharing.
> +	 */
> +	unsigned int		fully_unshared_tables : 1;
> +
>  	unsigned int		batch_count;
>
>  #ifndef CONFIG_MMU_GATHER_NO_GATHER
> @@ -400,6 +414,7 @@ static inline void __tlb_reset_range(struct mmu_gather *tlb)
>  	tlb->cleared_pmds = 0;
>  	tlb->cleared_puds = 0;
>  	tlb->cleared_p4ds = 0;
> +	tlb->unshared_tables = 0;
>  	/*
>  	 * Do not reset mmu_gather::vma_* fields here, we do not
>  	 * call into tlb_start_vma() again to set them if there is an
> @@ -484,7 +499,7 @@ static inline void tlb_flush_mmu_tlbonly(struct mmu_gather *tlb)
>  	 * these bits.
>  	 */
>  	if (!(tlb->freed_tables || tlb->cleared_ptes || tlb->cleared_pmds ||
> -	      tlb->cleared_puds || tlb->cleared_p4ds))
> +	      tlb->cleared_puds || tlb->cleared_p4ds || tlb->unshared_tables))
>  		return;
>
>  	tlb_flush(tlb);
> @@ -773,6 +788,63 @@ static inline bool huge_pmd_needs_flush(pmd_t oldpmd, pmd_t newpmd)
>  }
>  #endif
>
> +#ifdef CONFIG_HUGETLB_PMD_PAGE_TABLE_SHARING
> +static inline void tlb_unshare_pmd_ptdesc(struct mmu_gather *tlb, struct ptdesc *pt,
> +					  unsigned long addr)
> +{
> +	/*
> +	 * The caller must make sure that concurrent unsharing + exclusive
> +	 * reuse is impossible until tlb_flush_unshared_tables() was called.
> +	 */
> +	VM_WARN_ON_ONCE(!ptdesc_pmd_is_shared(pt));
> +	ptdesc_pmd_pts_dec(pt);
> +
> +	/* Clearing a PUD pointing at a PMD table with PMD leaves. */
> +	tlb_flush_pmd_range(tlb, addr & PUD_MASK, PUD_SIZE);
> +
> +	/*
> +	 * If the page table is now exclusively owned, we fully unshared
> +	 * a page table.
> +	 */
> +	if (!ptdesc_pmd_is_shared(pt))
> +		tlb->fully_unshared_tables = true;
> +	tlb->unshared_tables = true;
> +}
> +
> +static inline void tlb_flush_unshared_tables(struct mmu_gather *tlb)
> +{
> +	/*
> +	 * As soon as the caller drops locks to allow for reuse of
> +	 * previously-shared tables, these tables could get modified and
> +	 * even reused outside of hugetlb context, so we have to make sure that
> +	 * any page table walkers (incl. TLB, GUP-fast) are aware of that
> +	 * change.
> +	 *
> +	 * Even if we are not fully unsharing a PMD table, we must
> +	 * flush the TLB for the unsharer now.
> +	 */
> +	if (tlb->unshared_tables)
> +		tlb_flush_mmu_tlbonly(tlb);
> +
> +	/*
> +	 * Similarly, we must make sure that concurrent GUP-fast will not
> +	 * walk previously-shared page tables that are getting modified+reused
> +	 * elsewhere. So broadcast an IPI to wait for any concurrent GUP-fast.
> +	 *
> +	 * We only perform this when we are the last sharer of a page table,
> +	 * as the IPI will reach all CPUs: any GUP-fast.
> +	 *
> +	 * Note that on configs where tlb_remove_table_sync_one() is a NOP,
> +	 * the expectation is that the tlb_flush_mmu_tlbonly() would have issued
> +	 * required IPIs already for us.
> +	 */
> +	if (tlb->fully_unshared_tables) {
> +		tlb_remove_table_sync_one();
> +		tlb->fully_unshared_tables = false;
> +	}
> +}
> +#endif /* CONFIG_HUGETLB_PMD_PAGE_TABLE_SHARING */
> +
>  #endif /* CONFIG_MMU */
>
>  #endif /* _ASM_GENERIC__TLB_H */
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 03c8725efa289..63b248c6bfd47 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -240,8 +240,9 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
>  pte_t *huge_pte_offset(struct mm_struct *mm,
>  		       unsigned long addr, unsigned long sz);
>  unsigned long hugetlb_mask_last_page(struct hstate *h);
> -int huge_pmd_unshare(struct mm_struct *mm, struct vm_area_struct *vma,
> -				unsigned long addr, pte_t *ptep);
> +int huge_pmd_unshare(struct mmu_gather *tlb, struct vm_area_struct *vma,
> +		unsigned long addr, pte_t *ptep);
> +void huge_pmd_unshare_flush(struct mmu_gather *tlb, struct vm_area_struct *vma);
>  void adjust_range_if_pmd_sharing_possible(struct vm_area_struct *vma,
>  				unsigned long *start, unsigned long *end);
>
> @@ -271,7 +272,7 @@ void hugetlb_vma_unlock_write(struct vm_area_struct *vma);
>  int hugetlb_vma_trylock_write(struct vm_area_struct *vma);
>  void hugetlb_vma_assert_locked(struct vm_area_struct *vma);
>  void hugetlb_vma_lock_release(struct kref *kref);
> -long hugetlb_change_protection(struct vm_area_struct *vma,
> +long hugetlb_change_protection(struct mmu_gather *tlb, struct vm_area_struct *vma,
>  		unsigned long address, unsigned long end, pgprot_t newprot,
>  		unsigned long cp_flags);
>  void hugetlb_unshare_all_pmds(struct vm_area_struct *vma);
> @@ -300,13 +301,17 @@ static inline struct address_space *hugetlb_folio_mapping_lock_write(
>  	return NULL;
>  }
>
> -static inline int huge_pmd_unshare(struct mm_struct *mm,
> -					struct vm_area_struct *vma,
> -					unsigned long addr, pte_t *ptep)
> +static inline int huge_pmd_unshare(struct mmu_gather *tlb,
> +		struct vm_area_struct *vma, unsigned long addr, pte_t *ptep)
>  {
>  	return 0;
>  }
>
> +static inline void huge_pmd_unshare_flush(struct mmu_gather *tlb,
> +		struct vm_area_struct *vma)
> +{
> +}
> +
>  static inline void adjust_range_if_pmd_sharing_possible(
>  				struct vm_area_struct *vma,
>  				unsigned long *start, unsigned long *end)
> @@ -432,7 +437,7 @@ static inline void move_hugetlb_state(struct folio *old_folio,
>  {
>  }
>
> -static inline long hugetlb_change_protection(
> +static inline long hugetlb_change_protection(struct mmu_gather *tlb,
>  			struct vm_area_struct *vma, unsigned long address,
>  			unsigned long end, pgprot_t newprot,
>  			unsigned long cp_flags)
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 3c77cdef12a32..7fef0b94b5d1e 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -5096,8 +5096,9 @@ int move_hugetlb_page_tables(struct vm_area_struct *vma,
>  	unsigned long last_addr_mask;
>  	pte_t *src_pte, *dst_pte;
>  	struct mmu_notifier_range range;
> -	bool shared_pmd = false;
> +	struct mmu_gather tlb;
>
> +	tlb_gather_mmu(&tlb, vma->vm_mm);
>  	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm, old_addr,
>  				old_end);
>  	adjust_range_if_pmd_sharing_possible(vma, &range.start, &range.end);
> @@ -5122,12 +5123,12 @@ int move_hugetlb_page_tables(struct vm_area_struct *vma,
>  		if (huge_pte_none(huge_ptep_get(mm, old_addr, src_pte)))
>  			continue;
>
> -		if (huge_pmd_unshare(mm, vma, old_addr, src_pte)) {
> -			shared_pmd = true;
> +		if (huge_pmd_unshare(&tlb, vma, old_addr, src_pte)) {
>  			old_addr |= last_addr_mask;
>  			new_addr |= last_addr_mask;
>  			continue;
>  		}
> +		tlb_remove_huge_tlb_entry(h, &tlb, src_pte, old_addr);
>
>  		dst_pte = huge_pte_alloc(mm, new_vma, new_addr, sz);
>  		if (!dst_pte)
> @@ -5136,13 +5137,13 @@ int move_hugetlb_page_tables(struct vm_area_struct *vma,
>  		move_huge_pte(vma, old_addr, new_addr, src_pte, dst_pte, sz);
>  	}
>
> -	if (shared_pmd)
> -		flush_hugetlb_tlb_range(vma, range.start, range.end);
> -	else
> -		flush_hugetlb_tlb_range(vma, old_end - len, old_end);
> +	tlb_flush_mmu_tlbonly(&tlb);
> +	huge_pmd_unshare_flush(&tlb, vma);
> +
>  	mmu_notifier_invalidate_range_end(&range);
>  	i_mmap_unlock_write(mapping);
>  	hugetlb_vma_unlock_write(vma);
> +	tlb_finish_mmu(&tlb);
>
>  	return len + old_addr - old_end;
>  }
> @@ -5161,7 +5162,6 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
>  	unsigned long sz = huge_page_size(h);
>  	bool adjust_reservation;
>  	unsigned long last_addr_mask;
> -	bool force_flush = false;
>
>  	WARN_ON(!is_vm_hugetlb_page(vma));
>  	BUG_ON(start & ~huge_page_mask(h));
> @@ -5184,10 +5184,8 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
>  		}
>
>  		ptl = huge_pte_lock(h, mm, ptep);
> -		if (huge_pmd_unshare(mm, vma, address, ptep)) {
> +		if (huge_pmd_unshare(tlb, vma, address, ptep)) {
>  			spin_unlock(ptl);
> -			tlb_flush_pmd_range(tlb, address & PUD_MASK, PUD_SIZE);
> -			force_flush = true;
>  			address |= last_addr_mask;
>  			continue;
>  		}
> @@ -5303,14 +5301,7 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
>  	}
>  	tlb_end_vma(tlb, vma);
>
> -	/*
> -	 * There is nothing protecting a previously-shared page table that we
> -	 * unshared through huge_pmd_unshare() from getting freed after we
> -	 * release i_mmap_rwsem, so flush the TLB now. If huge_pmd_unshare()
> -	 * succeeded, flush the range corresponding to the pud.
> -	 */
> -	if (force_flush)
> -		tlb_flush_mmu_tlbonly(tlb);
> +	huge_pmd_unshare_flush(tlb, vma);
>  }
>
>  void __hugetlb_zap_begin(struct vm_area_struct *vma,
> @@ -6399,7 +6390,7 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
>  }
>  #endif /* CONFIG_USERFAULTFD */
>
> -long hugetlb_change_protection(struct vm_area_struct *vma,
> +long hugetlb_change_protection(struct mmu_gather *tlb, struct vm_area_struct *vma,
>  		unsigned long address, unsigned long end,
>  		pgprot_t newprot, unsigned long cp_flags)
>  {
> @@ -6409,7 +6400,6 @@ long hugetlb_change_protection(struct vm_area_struct *vma,
>  	pte_t pte;
>  	struct hstate *h = hstate_vma(vma);
>  	long pages = 0, psize = huge_page_size(h);
> -	bool shared_pmd = false;
>  	struct mmu_notifier_range range;
>  	unsigned long last_addr_mask;
>  	bool uffd_wp = cp_flags & MM_CP_UFFD_WP;
> @@ -6452,7 +6442,7 @@ long hugetlb_change_protection(struct vm_area_struct *vma,
>  			}
>  		}
>  		ptl = huge_pte_lock(h, mm, ptep);
> -		if (huge_pmd_unshare(mm, vma, address, ptep)) {
> +		if (huge_pmd_unshare(tlb, vma, address, ptep)) {
>  			/*
>  			 * When uffd-wp is enabled on the vma, unshare
>  			 * shouldn't happen at all.  Warn about it if it
> @@ -6461,7 +6451,6 @@ long hugetlb_change_protection(struct vm_area_struct *vma,
>  			WARN_ON_ONCE(uffd_wp || uffd_wp_resolve);
>  			pages++;
>  			spin_unlock(ptl);
> -			shared_pmd = true;
>  			address |= last_addr_mask;
>  			continue;
>  		}
> @@ -6522,22 +6511,16 @@ long hugetlb_change_protection(struct vm_area_struct *vma,
>  				pte = huge_pte_clear_uffd_wp(pte);
>  			huge_ptep_modify_prot_commit(vma, address, ptep, old_pte, pte);
>  			pages++;
> +			tlb_remove_huge_tlb_entry(h, tlb, ptep, address);
>  		}
>
>  next:
>  		spin_unlock(ptl);
>  		cond_resched();
>  	}
> -	/*
> -	 * There is nothing protecting a previously-shared page table that we
> -	 * unshared through huge_pmd_unshare() from getting freed after we
> -	 * release i_mmap_rwsem, so flush the TLB now. If huge_pmd_unshare()
> -	 * succeeded, flush the range corresponding to the pud.
> -	 */
> -	if (shared_pmd)
> -		flush_hugetlb_tlb_range(vma, range.start, range.end);
> -	else
> -		flush_hugetlb_tlb_range(vma, start, end);
> +
> +	tlb_flush_mmu_tlbonly(tlb);
> +	huge_pmd_unshare_flush(tlb, vma);
>  	/*
>  	 * No need to call mmu_notifier_arch_invalidate_secondary_tlbs() we are
>  	 * downgrading page table protection not changing it to point to a new
> @@ -6904,18 +6887,27 @@ pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
>  	return pte;
>  }
>
> -/*
> - * unmap huge page backed by shared pte.
> +/**
> + * huge_pmd_unshare - Unmap a pmd table if it is shared by multiple users
> + * @tlb: the current mmu_gather.
> + * @vma: the vma covering the pmd table.
> + * @addr: the address we are trying to unshare.
> + * @ptep: pointer into the (pmd) page table.
> + *
> + * Called with the page table lock held, the i_mmap_rwsem held in write mode
> + * and the hugetlb vma lock held in write mode.
>   *
> - * Called with page table lock held.
> + * Note: The caller must call huge_pmd_unshare_flush() before dropping the
> + * i_mmap_rwsem.
>   *
> - * returns: 1 successfully unmapped a shared pte page
> - *	    0 the underlying pte page is not shared, or it is the last user
> + * Returns: 1 if it was a shared PMD table and it got unmapped, or 0 if it
> + *	    was not a shared PMD table.
>   */
> -int huge_pmd_unshare(struct mm_struct *mm, struct vm_area_struct *vma,
> -					unsigned long addr, pte_t *ptep)
> +int huge_pmd_unshare(struct mmu_gather *tlb, struct vm_area_struct *vma,
> +		unsigned long addr, pte_t *ptep)
>  {
>  	unsigned long sz = huge_page_size(hstate_vma(vma));
> +	struct mm_struct *mm = vma->vm_mm;
>  	pgd_t *pgd = pgd_offset(mm, addr);
>  	p4d_t *p4d = p4d_offset(pgd, addr);
>  	pud_t *pud = pud_offset(p4d, addr);
> @@ -6927,18 +6919,36 @@ int huge_pmd_unshare(struct mm_struct *mm, struct vm_area_struct *vma,
>  	i_mmap_assert_write_locked(vma->vm_file->f_mapping);
>  	hugetlb_vma_assert_locked(vma);
>  	pud_clear(pud);
> -	/*
> -	 * Once our caller drops the rmap lock, some other process might be
> -	 * using this page table as a normal, non-hugetlb page table.
> -	 * Wait for pending gup_fast() in other threads to finish before letting
> -	 * that happen.
> -	 */
> -	tlb_remove_table_sync_one();
> -	ptdesc_pmd_pts_dec(virt_to_ptdesc(ptep));
> +
> +	tlb_unshare_pmd_ptdesc(tlb, virt_to_ptdesc(ptep), addr);
> +
>  	mm_dec_nr_pmds(mm);
>  	return 1;
>  }
>
> +/*
> + * huge_pmd_unshare_flush - Complete a sequence of huge_pmd_unshare() calls
> + * @tlb: the current mmu_gather.
> + * @vma: the vma covering the pmd table.
> + *
> + * Perform necessary TLB flushes or IPI broadcasts to synchronize PMD table
> + * unsharing with concurrent page table walkers.
> + *
> + * This function must be called after a sequence of huge_pmd_unshare()
> + * calls while still holding the i_mmap_rwsem.
> + */
> +void huge_pmd_unshare_flush(struct mmu_gather *tlb, struct vm_area_struct *vma)
> +{
> +	/*
> +	 * We must synchronize page table unsharing such that nobody will
> +	 * try reusing a previously-shared page table while it might still
> +	 * be in use by previous sharers (TLB, GUP_fast).
> +	 */
> +	i_mmap_assert_write_locked(vma->vm_file->f_mapping);
> +
> +	tlb_flush_unshared_tables(tlb);
> +}
> +
>  #else /* !CONFIG_HUGETLB_PMD_PAGE_TABLE_SHARING */
>
>  pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
> @@ -6947,12 +6957,16 @@ pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
>  	return NULL;
>  }
>
> -int huge_pmd_unshare(struct mm_struct *mm, struct vm_area_struct *vma,
> -				unsigned long addr, pte_t *ptep)
> +int huge_pmd_unshare(struct mmu_gather *tlb, struct vm_area_struct *vma,
> +		unsigned long addr, pte_t *ptep)
>  {
>  	return 0;
>  }
>
> +void huge_pmd_unshare_flush(struct mmu_gather *tlb, struct vm_area_struct *vma)
> +{
> +}
> +
>  void adjust_range_if_pmd_sharing_possible(struct vm_area_struct *vma,
>  				unsigned long *start, unsigned long *end)
>  {
> @@ -7219,6 +7233,7 @@ static void hugetlb_unshare_pmds(struct vm_area_struct *vma,
>  	unsigned long sz = huge_page_size(h);
>  	struct mm_struct *mm = vma->vm_mm;
>  	struct mmu_notifier_range range;
> +	struct mmu_gather tlb;
>  	unsigned long address;
>  	spinlock_t *ptl;
>  	pte_t *ptep;
> @@ -7229,6 +7244,7 @@ static void hugetlb_unshare_pmds(struct vm_area_struct *vma,
>  	if (start >= end)
>  		return;
>
> +	tlb_gather_mmu(&tlb, mm);
>  	flush_cache_range(vma, start, end);
>  	/*
>  	 * No need to call adjust_range_if_pmd_sharing_possible(), because
> @@ -7248,10 +7264,10 @@ static void hugetlb_unshare_pmds(struct vm_area_struct *vma,
>  		if (!ptep)
>  			continue;
>  		ptl = huge_pte_lock(h, mm, ptep);
> -		huge_pmd_unshare(mm, vma, address, ptep);
> +		huge_pmd_unshare(&tlb, vma, address, ptep);
>  		spin_unlock(ptl);
>  	}
> -	flush_hugetlb_tlb_range(vma, start, end);
> +	huge_pmd_unshare_flush(&tlb, vma);
>  	if (take_locks) {
>  		i_mmap_unlock_write(vma->vm_file->f_mapping);
>  		hugetlb_vma_unlock_write(vma);
> @@ -7261,6 +7277,7 @@ static void hugetlb_unshare_pmds(struct vm_area_struct *vma,
>  	 * Documentation/mm/mmu_notifier.rst.
>  	 */
>  	mmu_notifier_invalidate_range_end(&range);
> +	tlb_finish_mmu(&tlb);
>  }
>
>  /*
> diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
> index 247e3f9db6c7a..030a162a263ba 100644
> --- a/mm/mmu_gather.c
> +++ b/mm/mmu_gather.c
> @@ -426,6 +426,7 @@ static void __tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm,
>  #endif
>  	tlb->vma_pfn = 0;
>
> +	tlb->fully_unshared_tables = 0;
>  	__tlb_reset_range(tlb);
>  	inc_tlb_flush_pending(tlb->mm);
>  }
> @@ -468,6 +469,12 @@ void tlb_gather_mmu_fullmm(struct mmu_gather *tlb, struct mm_struct *mm)
>   */
>  void tlb_finish_mmu(struct mmu_gather *tlb)
>  {
> +	/*
> +	 * We expect an earlier huge_pmd_unshare_flush() call to sort this out,
> +	 * due to complicated locking requirements with page table unsharing.
> +	 */
> +	VM_WARN_ON_ONCE(tlb->fully_unshared_tables);
> +
>  	/*
>  	 * If there are parallel threads are doing PTE changes on same range
>  	 * under non-exclusive lock (e.g., mmap_lock read-side) but defer TLB
> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index 283889e4f1cec..5c330e817129e 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -652,7 +652,7 @@ long change_protection(struct mmu_gather *tlb,
>  #endif
>
>  	if (is_vm_hugetlb_page(vma))
> -		pages = hugetlb_change_protection(vma, start, end, newprot,
> +		pages = hugetlb_change_protection(tlb, vma, start, end, newprot,
>  						  cp_flags);
>  	else
>  		pages = change_protection_range(tlb, vma, start, end, newprot,
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 748f48727a162..d6799afe11147 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -76,7 +76,7 @@
>  #include <linux/mm_inline.h>
>  #include <linux/oom.h>
>
> -#include <asm/tlbflush.h>
> +#include <asm/tlb.h>
>
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/migrate.h>
> @@ -2008,13 +2008,17 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>  			 * if unsuccessful.
>  			 */
>  			if (!anon) {
> +				struct mmu_gather tlb;
> +
>  				VM_BUG_ON(!(flags & TTU_RMAP_LOCKED));
>  				if (!hugetlb_vma_trylock_write(vma))
>  					goto walk_abort;
> -				if (huge_pmd_unshare(mm, vma, address, pvmw.pte)) {
> +
> +				tlb_gather_mmu(&tlb, mm);
> +				if (huge_pmd_unshare(&tlb, vma, address, pvmw.pte)) {
>  					hugetlb_vma_unlock_write(vma);
> -					flush_tlb_range(vma,
> -						range.start, range.end);
> +					huge_pmd_unshare_flush(&tlb, vma);
> +					tlb_finish_mmu(&tlb);
>  					/*
>  					 * The PMD table was unmapped,
>  					 * consequently unmapping the folio.
> @@ -2022,6 +2026,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>  					goto walk_done;
>  				}
>  				hugetlb_vma_unlock_write(vma);
> +				tlb_finish_mmu(&tlb);
>  			}
>  			pteval = huge_ptep_clear_flush(vma, address, pvmw.pte);
>  			if (pte_dirty(pteval))
> @@ -2398,17 +2403,20 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
>  			 * fail if unsuccessful.
>  			 */
>  			if (!anon) {
> +				struct mmu_gather tlb;
> +
>  				VM_BUG_ON(!(flags & TTU_RMAP_LOCKED));
>  				if (!hugetlb_vma_trylock_write(vma)) {
>  					page_vma_mapped_walk_done(&pvmw);
>  					ret = false;
>  					break;
>  				}
> -				if (huge_pmd_unshare(mm, vma, address, pvmw.pte)) {
> -					hugetlb_vma_unlock_write(vma);
> -					flush_tlb_range(vma,
> -						range.start, range.end);
>
> +				tlb_gather_mmu(&tlb, mm);
> +				if (huge_pmd_unshare(&tlb, vma, address, pvmw.pte)) {
> +					hugetlb_vma_unlock_write(vma);
> +					huge_pmd_unshare_flush(&tlb, vma);
> +					tlb_finish_mmu(&tlb);
>  					/*
>  					 * The PMD table was unmapped,
>  					 * consequently unmapping the folio.
> @@ -2417,6 +2425,7 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
>  					break;
>  				}
>  				hugetlb_vma_unlock_write(vma);
> +				tlb_finish_mmu(&tlb);
>  			}
>  			/* Nuke the hugetlb page table entry */
>  			pteval = huge_ptep_clear_flush(vma, address, pvmw.pte);
> --
> 2.52.0
>

