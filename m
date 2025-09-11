Return-Path: <linux-arch+bounces-13492-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C58B52760
	for <lists+linux-arch@lfdr.de>; Thu, 11 Sep 2025 05:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 998621C20584
	for <lists+linux-arch@lfdr.de>; Thu, 11 Sep 2025 03:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CCE9256C61;
	Thu, 11 Sep 2025 03:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hEv8hw+m";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qNC4j3xr"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A302472BC;
	Thu, 11 Sep 2025 03:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757562454; cv=fail; b=ays1wWz2Y2F9loabqclOCY0pAUhkNL69vLYm+Ifh4ClSVseVpDk1XvnFT/knfJZydHmZD0Dpv6p6ShnCLDV9nYwybj8ef8dkIISVcr+GiL2bjXxDY2F4Tr/EbhQppsDVbVBaWrRP0F2PaNzi1ct4TsX1efG714ONPiYVB042RcM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757562454; c=relaxed/simple;
	bh=ORLknrWC6cH/REeq/ys3jjTPLJgwmtA2Wsztt+E+SE0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g3PJwRr5Zf6N5P+WDkbc9aaQm32raMU+cpbzU/xSURugr1UEZE+vVTWqKy0Ef5kkcSfGVllVZKbNZFHTm02jfDo3Z23hSs50/nT/CwhlhUANHBXfhJPveoUfqErcR3PXqJcRRfNi7PLzxim3LJtm42RVXSGPYh2lFC4OD/kCvLc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hEv8hw+m; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qNC4j3xr; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ALgUEr014361;
	Thu, 11 Sep 2025 03:47:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=XZk5DWzWuqvBNDu2xwV3s+M5cdTIJw/wMznYofZfcO4=; b=
	hEv8hw+mFuIvjU4mtezJ0ZO3w1NXeptN4L8/h4K57cIcyeAN/dPW7BpJzLPLhYl/
	Mw7VXea2bpljF3lLdOC/Z7t3HVBrFUEapCmltFtdg2Kr72mwmfN0LVkmmQJLojc3
	FZiJYoMfMt0onIgR4801pAZikp6wmUqTB1Th79aQt/aNZcqi6jBpLXhKuY5WYMqP
	XnMGB4rPCa6wNCplyhhZvAOyYQh17dIEYzt8oZt2NpT07KRskSXwcXZUyujjzOKp
	xE+WB2J2B0QLlIFdmCAxOHTFtjspaT8lTikvlT6zKXPFX95Myu+LhHbCBw/uO3eH
	U625MucBzBc8DkiSaW96HQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4922shwaj6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Sep 2025 03:47:01 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58B3kH1V012878;
	Thu, 11 Sep 2025 03:47:00 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013025.outbound.protection.outlook.com [40.107.201.25])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 490bdc2cef-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Sep 2025 03:47:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EOXFDasNPzPVw8FeVstL5LW490am5XwJpt7jtO6Arln/7uvunsj10JDlAJcHYtoafWye0E2liD7A2fXTkWpthqltr+xPvChcNMxcAWh0UNorQAhWhPLM2XBiTgUo9epLNq84Q1UXL/e2wZ61SHBkExO3zojp2fOFLFS7+JunpDfqHLayMnjQJOE5p68mgHPDnCdeki8PHXwk5c43QfEL8qg9JZSDukwkeoCObah8IKwpJ9ltFcfEnqN1FcbsdjwQzFVxQ7ECbFwcW913vtzmiggix7syqLiH2OAbJZvo5Kdcfs3/DOFb2DFAlN5qd4oqFgg1Ce5166H5C828IkXSUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XZk5DWzWuqvBNDu2xwV3s+M5cdTIJw/wMznYofZfcO4=;
 b=QXVl7YVcjAD4nioxKI8bGr3eSHpjcRkKPoxqA3Gxc62f2rVnpODREJgwmDpAthaNOQt3FPCdEYT1f35yLb0zPGfFqMzBftJV39HjODki4QPLemUOpO8jhTcKDdjHrgUbHnh+j/PNO30OrMayGISk+5Jho35pQ8JC47oYa9KQwcvnNbFBRRy5V9kpbHdbx2D+lzPa71NaXU8lyuRRjaNSEvZAMS4TGNLYw9Kjy0yw87Wyn+h3MNIQpQRUxzL6S0SlT8xF1g6EqGElmo+NVOgC/HbtYSbschRMGKj0IXvc4UJZ2X85kTRBgsC/QvPFxfoDagCXf8v36X8QJbny+5L//A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XZk5DWzWuqvBNDu2xwV3s+M5cdTIJw/wMznYofZfcO4=;
 b=qNC4j3xrBVZ/+CwywpaNRWkpKC1lp+nDvOCSwUktZe2aaNGVrOSQeTj/IuNbUDrF9Vua3EL9nqCtEB5BPl3bpPJTuWjP4M5vpE8xZhu2+Q4m6/kQpmeo4IJ+eBBVAAr1tFALcRnUtAYuuYrSHNAfFNnj7mySO/AHFhWDeKJ9P3o=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DS4PPF6C5A39D55.namprd10.prod.outlook.com (2603:10b6:f:fc00::d26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 03:46:58 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9052.013; Thu, 11 Sep 2025
 03:46:58 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Cc: arnd@arndb.de, catalin.marinas@arm.com, will@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org, mark.rutland@arm.com,
        harisokn@amazon.com, cl@gentwo.org, ast@kernel.org, memxor@gmail.com,
        zhenglifeng1@huawei.com, xueshuai@linux.alibaba.com,
        joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com
Subject: [PATCH v5 1/5] asm-generic: barrier: Add smp_cond_load_relaxed_timeout()
Date: Wed, 10 Sep 2025 20:46:51 -0700
Message-Id: <20250911034655.3916002-2-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250911034655.3916002-1-ankur.a.arora@oracle.com>
References: <20250911034655.3916002-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0277.namprd04.prod.outlook.com
 (2603:10b6:303:89::12) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DS4PPF6C5A39D55:EE_
X-MS-Office365-Filtering-Correlation-Id: d5de8e6f-01d8-41ba-0762-08ddf0e5dbbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2txeqL6NokE3Yrl8IogitVHPNYpr2USSaDEBSOg+ApsDP6xgnU9cgTmnjzBs?=
 =?us-ascii?Q?hI0ZpaL/7zw20joCXbjf+hCGHidQAuybZJaXsSRNKU8rtNMS+pCzi1Kfn+lB?=
 =?us-ascii?Q?GxHBIRMYBLcB8R5pO60YTEvpyYxoTYyFQ7/lNX/CU3Uof53PemaoAv5KLMLi?=
 =?us-ascii?Q?ILDiFZb4OzIvNXQyMMHxe4EVBO8f6Nr++AaDHcecoHnUIh5P3PTCOkh8e5AG?=
 =?us-ascii?Q?+4CkquySmVOZi+v/iqFPqFNftDD0NKnqquhCKNQiCG09g96zJ78E3wkWL06W?=
 =?us-ascii?Q?xJd+lGQ0W+aqr/EESwoO3j/RWDVm2+NBq9Pc0/yNpA6MA/gFrBfBI6A/yJAr?=
 =?us-ascii?Q?qkXsN6pjpPTX+2KRW3LQsViL/GDxvtRse3ZfLJFQ273QE6g1o1hrlzXSViLZ?=
 =?us-ascii?Q?gNizN+Crpk1/vg+nBv9zfiPof7/qZqPUJyh/GYqTaPKi5sR4BhTwabtO9Y7d?=
 =?us-ascii?Q?TF2omvRq28oBqhyUqTHDkAXzo1iq8H2R/MxaexJ556fKAxvALPjJ089Mhijc?=
 =?us-ascii?Q?eAsGwosKIbJ4+687u4nh8rud1sEJIkxfY1D3feOSfgWLScBI0Niml1RUFIVB?=
 =?us-ascii?Q?9bqLq4T7tZeGceU2LfXBPPz1Awl93qQtqi6DesNz719380A5Ek6vE1xbQJAX?=
 =?us-ascii?Q?EH3SY/sxfkpe/RYVjiQ4+xWOkNybmaTqmdhGkdnGOwGD+cc8RQGyUsynDFA5?=
 =?us-ascii?Q?AvXVm72R+/Y92HDk2FHUDBr6gZrpxyKbEVpmVNTNL78JXUm9fD7Q+Z6a23in?=
 =?us-ascii?Q?RCJAtGBszLl/quC74SeB+cYDdYDzeLVOmidL6QdQjsvl2Kw2imcKaehtQT7M?=
 =?us-ascii?Q?E6JtP/DPb49EzFJtWKB+CMMC6RO3yA3+34DUN2P0hAB6J28ubljWb0b07Uo1?=
 =?us-ascii?Q?Mo/Fc8Djd1rV23Dl0wNAnazWOErqeFSHA0ytAKaAQ1ldQr2et1PiqE70eYs2?=
 =?us-ascii?Q?uwMDjZ8/UvKBPLQr+M7E1M/DjNl+x51zFDgp9RxiwUSd+mNobQnkWfYQGJuf?=
 =?us-ascii?Q?w+7f0lJeSBYvOFerRNNIL+XyAkjUUw2lA0KkO/bHDHpqF80BQfq7iB5SglJJ?=
 =?us-ascii?Q?MaTDkbRrgSLuPltcWv2yf1WHfYShKq6vv9L6CqkgJwJ6S/OYHGoqcGDVlIUM?=
 =?us-ascii?Q?llswZintRUwT1pgHNRjsesN+GbqUqFNZ8inAehZk+GUW8KJ1N6FzRC8ieqXs?=
 =?us-ascii?Q?pwbZq+Z8XHB4Vmqz52swdjUj5D9GB/c/yRw5B+rf/zUh08Qg4MIaqFnf80Fj?=
 =?us-ascii?Q?45frOvUUiApjNSW+zQdCIJE+MfzHlLf3MT7NLhJx07fgkKaSIQP0ces+CoGo?=
 =?us-ascii?Q?/hxCD2GGcMEDUId3tvZY5bRFjrjslrXg0WMM2JKUla6aB9PpsmQ58zG0a6ZE?=
 =?us-ascii?Q?DZdrIPg36xj5T16M2rBtj7ZIVKgMeJbrMMISiLQEntgdNbs/FD17ysh+ibSe?=
 =?us-ascii?Q?3O+B1xCuP60=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7WIc5TyOPUar18LfQ0wb9syDjdT0/jeztQhALSW2ajm8aiIf3f/gC25RnduQ?=
 =?us-ascii?Q?URSKrUk2PQ7SPFxshzF2eMFYGWQNjIbnriVQfZsRjdtx+92TiONU9PkJ7iad?=
 =?us-ascii?Q?wDvQaa3/bdh4ehmyL3QZUZ9hRN8RoYEfhmCI3eNj1Sm6s7SjEI17FSBmMtdC?=
 =?us-ascii?Q?YiLa7ADsrRpcOxPzGuMX4RogNmMtctVQhKtFWg1Z5jSOB40YyXEBcZLRpNQm?=
 =?us-ascii?Q?sWwf4c3NpuQ4M9aJg35VNXMFzG+yS5ow0wOBYIw042YwgHyig1Zm2R2919Oy?=
 =?us-ascii?Q?k1zLt40/qdXhkAFNEBmjL608VVBSC51mDMz83CEWr9rT2qW8e/3uUoSeWlFU?=
 =?us-ascii?Q?FI6ZL/A+xOzyrg66Z/2TiA7YAQ8aifD20V5Husi8o+HZHbDaNiDHxBzd3+L+?=
 =?us-ascii?Q?r6DdPtg99KEEtNWQxqSDOeY9uhwzSy7FMHeqcc0m5Jr/cl2S/xaBbmhbcslU?=
 =?us-ascii?Q?0Vh4j4KQcRAdHjOmSuo7UoXjsLae+yg9wwjLLrk6qqUHDYafy2i4mGNvkYeV?=
 =?us-ascii?Q?kM79N2eTfRjgW2aniuI84H5r19oFBSYJVzbFYRglJpZL/vPXkepXMbaycV7S?=
 =?us-ascii?Q?+e374CwCLCMB9FIVQVm7rw18llK1taDNnS2O72EW1GnDoBr66uZyaRAHMvPG?=
 =?us-ascii?Q?WeUo89dJQe3+eK7mW+mRivgXo/Aq5JWUQkW1g2pcPM0ZjTaSpBNtrPLuafRV?=
 =?us-ascii?Q?f2AFIFgVbB6B5MPRkbeYPZjXjFHjQp55yrn1W3sBTlmlj05Pw3uOCnSN43ZG?=
 =?us-ascii?Q?9iNVPYZYvH4Tco0wUpblFzDQi/xzCYWt0m6IyOTTLzuegPFCkSs/d/NO7X85?=
 =?us-ascii?Q?u/RHgmCdt4kZqEFgqAjCrniQ2piyYEOQDyyB/HBVqwF2bpw9fZZ94fvr6ADc?=
 =?us-ascii?Q?LGRgv3fTOeYfJPUMECNf/gRgTDvNhHWdGY6vo5HodZpvSQeALVFrVW1JbMHp?=
 =?us-ascii?Q?HrTI++RlDkckXVexveMK5CfY80xHexJ5WRIsSxxWOsxwB3z9WQ1q9UiepRiS?=
 =?us-ascii?Q?yaRKuoX7ZjdE/2HJll3YHnzFzOxB9SlVcBVDld70fH971bjPsT5mLFryVy+u?=
 =?us-ascii?Q?fpOMwh0Xh9uD3saDCpNLCNRWZJXyvTlUJujvo/+i7biON+nGhamWnBojG5CT?=
 =?us-ascii?Q?rhft71uS2T7T0kqBJI5ES+kCzVmGcfT1ooW2OoEBLU8gdpcFXhPUkaUbd1bN?=
 =?us-ascii?Q?QOjOdeTDp9eKAqEgjKipEnHI5cZ9E+jtv+JZMQUdD1TuXbX+UrsJvTzgYNA1?=
 =?us-ascii?Q?vIA/D85nTI6uninOhufopP7c0O5l81EDPBwO0lRVy2qp0ttDYeqhoKnDCOQY?=
 =?us-ascii?Q?AfmB87gYLM/gIOCCzPqS/NFOCbi8AtTx0/fzEuH7J0NXh4vUOGUIcvaLQPdw?=
 =?us-ascii?Q?QTa08R5e9vD6IPGFYhWAAF6wXS3+1aiIf6UlTKu4yZRmu4cIIKZaH2gqSHZB?=
 =?us-ascii?Q?9W7IStSWs+kC36lwSv/n9kMd32bcMK2ID20Nu5//E3Ie10biSHApuD+OCbEX?=
 =?us-ascii?Q?eiJ3mCVENBpJQzwuCwGepg6DFop2vXJ/a7GxfkSX14Yj6sur80rAbzhRXoki?=
 =?us-ascii?Q?AwrUR32Ng45hUgy6ghjGSwDhUA1Gd2Hi7lPiKFzh5LSV1eD8Jdw2p7opWHXj?=
 =?us-ascii?Q?tw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qcU4VfBoSyeFlSbLNgTT+t/nqWDErp9fM1JMwrK20/hMSl1gCZYva3xfb76xgEgzKwCe77It2NqfQ0ZioaMNmNQjS6ZADPXbFWssLz8AhWDMkw1qUJDiH0gh8OAHFXD6us9+60zOMi4/iyh4Wr1a1hUWlKkUQpbg8GUJTT5Nz7Pgdag5I+Regv0xgbtDYx7XvaniAsRCkWU2d2wfGAmveRqoNiN+zj6/ldM9pUXIf/EUBaS3lOPGMDoWa0Juk9LAdqEknnwf4qvBwGKQNqhB4aajvWot0O+RO0o7u6oaOg660tk6CS5ogkdM9E41OvcL7QAausc4T53BVY1OaIk9dFGtgCycbTg+KmKmMo+aEBrSCJCksNuagdjcjsWAQFabn1fUwxGo9bhsPRcZxOn1EPsXvlW4WkvRHTVIawiid+wmYC7SbvlOlwm1kEKv+OkLMdgAPPoVIkGNiph2EU97Rqx1HzzKkuIdrek/iu81/occcbmVDv0jvYv1vBuLou7kp+66zBW2bYwI3sUBsEQfiEUtl1gycBvcvdtAsAdO2m+g0bVV1Em4MPieTR8pPKJU1Y8Ns+n//LSaXFYpFkqkDQbnjGAaV5W9C4O8CtGE6PE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5de8e6f-01d8-41ba-0762-08ddf0e5dbbd
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 03:46:58.2982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RVhcdJjDfpxIn0g8I/zNdVDEToyjoqXW35RYr4ugiVTl/XNkSA0x5aE5zMA2YhbdOjsrgnQynyyOS3CO1IwdVeWFm07U4XJ47MWQ0wQaMlE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF6C5A39D55
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509110030
X-Authority-Analysis: v=2.4 cv=esTfzppX c=1 sm=1 tr=0 ts=68c24635 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=JfrnYn6hAAAA:8
 a=vggBfdFIAAAA:8 a=yPCof4ZbAAAA:8 a=L6dDZDBz5GL0lWFFP4gA:9
 a=a-qgeE7W1pNrGK8U0ZQC:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE2NSBTYWx0ZWRfX6ZP69U/HsOoN
 HbDNWgA+VieI3w2dav/8KzUWeQezFqruLW1qb+1t4nHFvCZNjhP+kafVDcoRYXFIG0TOIzG4Y2s
 bA8q6Xyk7pVyG5r5e4iYubA5mIJCILLHchskOpoSxaNZbs44dqrfXiS5TPYGIOilxEa2j3CUGat
 AxrldHUJIwXfrxm70q+8UBBZjGLBUeqnouJjbYruCDRzL062feyosQMTyam/umOzZuTfYPLk9H5
 Y730EBCuelNRfVX9c8zt0wlabXKoNV97vtNfzBqmaPOl+hnrMG/vZsnaEqaxBGR0WfK6SuklwtA
 6P0FF8QGiPsLwNk57nPMXBlo6bkVO05PVtpr1EI83/0hwFSn6H3cFOdkxjAmDhVJy5UI9yJPcCN
 A/OJvuK5
X-Proofpoint-GUID: ndoTVGKgoqsw9b7dmSTAx7sbyMq54NGk
X-Proofpoint-ORIG-GUID: ndoTVGKgoqsw9b7dmSTAx7sbyMq54NGk

Add smp_cond_load_relaxed_timeout(), which extends
smp_cond_load_relaxed() to allow waiting for a duration.

The additional parameter allows for the timeout check.

The waiting is done via the usual cpu_relax() spin-wait around the
condition variable with periodic evaluation of the time-check.

The number of times we spin is defined by SMP_TIMEOUT_SPIN_COUNT
(chosen to be 200 by default) which, assuming each cpu_relax()
iteration takes around 20-30 cycles (measured on a variety of x86
platforms), amounts to around 4000-6000 cycles.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-arch@vger.kernel.org
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Haris Okanovic <harisokn@amazon.com>
Tested-by: Haris Okanovic <harisokn@amazon.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 include/asm-generic/barrier.h | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
index d4f581c1e21d..8483e139954f 100644
--- a/include/asm-generic/barrier.h
+++ b/include/asm-generic/barrier.h
@@ -273,6 +273,41 @@ do {									\
 })
 #endif
 
+#ifndef SMP_TIMEOUT_SPIN_COUNT
+#define SMP_TIMEOUT_SPIN_COUNT		200
+#endif
+
+/**
+ * smp_cond_load_relaxed_timeout() - (Spin) wait for cond with no ordering
+ * guarantees until a timeout expires.
+ * @ptr: pointer to the variable to wait on
+ * @cond: boolean expression to wait for
+ * @time_check_expr: expression to decide when to bail out
+ *
+ * Equivalent to using READ_ONCE() on the condition variable.
+ */
+#ifndef smp_cond_load_relaxed_timeout
+#define smp_cond_load_relaxed_timeout(ptr, cond_expr, time_check_expr)	\
+({									\
+	typeof(ptr) __PTR = (ptr);					\
+	__unqual_scalar_typeof(*ptr) VAL;				\
+	u32 __n = 0, __spin = SMP_TIMEOUT_SPIN_COUNT;			\
+									\
+	for (;;) {							\
+		VAL = READ_ONCE(*__PTR);				\
+		if (cond_expr)						\
+			break;						\
+		cpu_relax();						\
+		if (++__n < __spin)					\
+			continue;					\
+		if (time_check_expr)					\
+			break;						\
+		__n = 0;						\
+	}								\
+	(typeof(*ptr))VAL;						\
+})
+#endif
+
 /*
  * pmem_wmb() ensures that all stores for which the modification
  * are written to persistent storage by preceding instructions have
-- 
2.43.5


