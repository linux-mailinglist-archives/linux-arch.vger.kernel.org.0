Return-Path: <linux-arch+bounces-15528-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 469F3CD48CC
	for <lists+linux-arch@lfdr.de>; Mon, 22 Dec 2025 03:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1287130051BC
	for <lists+linux-arch@lfdr.de>; Mon, 22 Dec 2025 02:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8683B2E718B;
	Mon, 22 Dec 2025 02:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Bt4eM7CD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XNWe/M+n"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F67C2FE582;
	Mon, 22 Dec 2025 02:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766369438; cv=fail; b=OQNXvUkAgp7j8i/57q6+zzSZhkt5slv6su/qmJIFeKMv3gaOkwiuiT+Vh+GVLmyB2llNoCAmGTrnQnDSOnNpfPU8yl53WfO+TLofNWrZ65WtQnsl+MPLmZ8VM80UAC6yKKCMTGiKu7h8Jli7ZJ8YdZsaj8jf78lvnBa1TnyVChs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766369438; c=relaxed/simple;
	bh=ewdSYGHZajKW8rpZvMmTRX3W3+CGlCb0WIyLI9PoDMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XZjY56CRj0pvBdn62mpT6RI2+wKrOZSOCUkbHlZ1iNFdkYr+XGGZnjBc2jylPfmT9JJWnTy9TVW5gngdw77kHcAk+ZBz5IAQa/P6rSmC1qt2V9Z5SmgdwmkR0zDsxUhYt3teZ1raUEa3z7rkyF1Mj3TckWi74k4+efm/ojkPWbI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Bt4eM7CD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XNWe/M+n; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BM1LIjd1450928;
	Mon, 22 Dec 2025 02:09:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=fvdkLu1f0PlUke3y+J
	UCPt8xo8HqCmdyBIWnKBwNeVM=; b=Bt4eM7CDq182JQAH6lHgIGn6qHZQaVXlXC
	U30+lyQm6M1s2BSz/sH/qMUf9KXZBDWpv7IB6NT2DtVlWkg1nvJUR2gxYWb56XyA
	NZBUYRgcmkZEe8BX7VMOH2bu+Yz1+ToVGch7wgqkAeo/An3lepFptab2YAbK2m9P
	hPJ26sJiGykUZWk+oaZLXCsGVXmKdLJzHFlhY1xGhvpBvrE6s6aKwxLMDm3ocPyj
	71rI+my4aQioZHk89UAkrDzTh/yhCJ6vCeOKGZt93o1exCbzEq3AM+0G37iyNcCQ
	nmeehGw7YQ7DTqZA3TSYn+Gsk8bsqqKnT7P6pf3N5oEe6dVKmS6g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b6tfhr41p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Dec 2025 02:09:49 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BLLe9ql001818;
	Mon, 22 Dec 2025 02:09:48 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012008.outbound.protection.outlook.com [52.101.53.8])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4b5j86ts7w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Dec 2025 02:09:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TIoiA6/LTzh5BVC4ZjfskxpOzfs4hIw1Z9iqcDLvukO4XRPV59MFgJL17YJd3lTHsklRT+adawmSP+uMq9ztUtvjjd7/T00G3xJsK/WGrUi2XRMVzJx8v5X6Wf8Df05tfKnCzg0O7uIrMpgPucNaG2ywu15rqhskX57lhqpuzGwbw0Tt0hf0H00hUw3rNxwh+sJzdUi/Ma989F9Uij1CdPdVaGTD1FA01klwVgfLlCI43RxGVKryHnkA26Pf7mnEtiiNGZeAYarNUrIrz5/UcPrCkd97uqL6CLvNdlY+JMipLvUU6ePfE1zKisfQFClkk+mxCjEAQehEAiw57xvslw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fvdkLu1f0PlUke3y+JUCPt8xo8HqCmdyBIWnKBwNeVM=;
 b=olSN5JH16UW9x39WnaB4J4xZtq1mcJXTz4EiHemnMsOAMTeGFkDGjMtQVEmFZJdX/qZKtBVCzS4TdPSl8zYgFSHrwFbyn2l2mpdE54ZilYBWqx8lMzoqk3SAP0GAT59mFcHGfS4/Up9GZkMyNJDZPZW03/R1MaHBXW0rHb8jiQRBrD8AOqM+IK75/Wq3KSQW0ju/ZUuFU480pL3h6Tvd/MtOvU2htObRCV9sx/V2h36/CHRa9265VOycnQKNJ2VAL0/s1roTcxx3TdWMqTNLUgdcFZrOHq+6GAQfCafJYrxl9WqWwd0Aqgw+s0ZCn0xVzCyvTy1abqO/cKCQ5EFfKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fvdkLu1f0PlUke3y+JUCPt8xo8HqCmdyBIWnKBwNeVM=;
 b=XNWe/M+nADktwYiXcvmpRpe1XQRiCnsY46pssPN9axY7VB/30UqVWDHeegK4a7kiZg5Q8/sctA1Srp7DQX2y2A0OBuaTm82Po65qAr0SPScXRUD6QbalTRacaA0XDEAcJ9ob0BP1fVXdlvWQHADGlYPDtudkUVacH9VStoKyvKY=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by DS4PPF376CF97B3.namprd10.prod.outlook.com (2603:10b6:f:fc00::d13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.11; Mon, 22 Dec
 2025 02:09:27 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9434.009; Mon, 22 Dec 2025
 02:09:26 +0000
Date: Mon, 22 Dec 2025 11:09:15 +0900
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
        Nadav Amit <nadav.amit@gmail.com>, stable@vger.kernel.org,
        Ryan Roberts <ryan.roberts@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v2 4/4] mm/hugetlb: fix excessive IPI broadcasts when
 unsharing PMD tables using mmu_gather
Message-ID: <aUioS4dkTrKgsHGP@hyeyoo>
References: <20251212071019.471146-1-david@kernel.org>
 <20251212071019.471146-5-david@kernel.org>
 <aUVHAD9G5_HKlYsR@hyeyoo>
 <d5bf88d9-aedf-4e6d-b5a0-e860bf0ed2e4@kernel.org>
 <3d9ce821-a39d-4164-a225-fcbe790ea951@kernel.org>
 <e78f5457-43fb-4656-ad53-bfda72936ef5@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e78f5457-43fb-4656-ad53-bfda72936ef5@kernel.org>
X-ClientProxiedBy: SEWP216CA0093.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2bf::8) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|DS4PPF376CF97B3:EE_
X-MS-Office365-Filtering-Correlation-Id: 97e0bea5-2e4d-4ad6-5fc6-08de40ff21e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CwCwxYT0hMaonWFciIajeVequtRWLeDAF+eec93aZ7Sj8231ztzfTn3hxU+F?=
 =?us-ascii?Q?P2t3UAZ2YCZS752TKhCD7GYq5KRr3AGifEbvxbmbOUY1jwUpofjODdzzGSEo?=
 =?us-ascii?Q?5YT8s1rZ9bWYYQK5blA7z0R3rF17HbjL5OPqNHXU3FOJ9ippN+mTAYf8rrX4?=
 =?us-ascii?Q?eXES51Pz2Xgh+uRp/TxrCJQrATKb5d8ADiHSqDB234HrZCrqhb3l441OaQLd?=
 =?us-ascii?Q?/PM+rmIZ9eWK0gztbeOvqWsVeOWtzdLlpL3pWAWaPCfULVuFiiYdmhJKZoWI?=
 =?us-ascii?Q?cv3nTo2dI/K2+GHbTnk8f4VWpB4GOv+NqWc2n7ygxH+h/Jlx4JaqkfDcvgqu?=
 =?us-ascii?Q?bdS3Y4DCXvqGp9Fv9tWRDktBMOB7WtBA3hx7XKD42cV22HzoXjAykFp+aiSa?=
 =?us-ascii?Q?T8RqIZnqo5JJOgJ7M/SQpxHFp7vGBR26u2hlGf13TTkMCq/uUNwOs9dDewHZ?=
 =?us-ascii?Q?C51N1QfhNXxqM8DFCfID5y6/iThb7AJ1+Y3co6zsRsEUACYSnzRLNn3q6TtB?=
 =?us-ascii?Q?Ge39uioG8Tc68972uRkkjSi4NOt2EpCMsqaxg4u4HBecmIj39or9DJ/oLg6w?=
 =?us-ascii?Q?Z6pkc6/L2fd8k/h8Iq9rX05zVUsb1bEDkBKjLcHAId80zCbOjR5AtpaPWQdB?=
 =?us-ascii?Q?w5Ka0+HcSHy3AXs6QjfpuwuW/7cFc06tntKR1+dj7mLK/KrIjU3BimeA+RaZ?=
 =?us-ascii?Q?MDQt605nOmCt1HQJv5ceVVPz5uqngIrmE4f0NrRiGWOJHp2H0RPSgeumxdpO?=
 =?us-ascii?Q?6auOkp46D1PlcF3UJcjhYanRruLMVbqN7d8v3l7HfHdU67cDRkwHcn8NuFzq?=
 =?us-ascii?Q?8l1PZohg5IQPvUZU1zFRaIRmNw8WVyWcYhJQoCaIfYN3r6Ntjnz03j2Jr0Pg?=
 =?us-ascii?Q?NT8fQA0XpmcRuQHquQsPzLQoFXVw1WI+hk7z7VI6ZxQe96RB19g7OybiUpec?=
 =?us-ascii?Q?WeXgvjwHlFNvFUZBhjiq5ojPBnbQUET99RWQhdVKp4jryq1lfzRry2xgvncZ?=
 =?us-ascii?Q?8H9RmusF4YIVhvOA44oZnv1yMQOZTQnKmwJbcCMP/TAY6tJrDmdURvl4YOWW?=
 =?us-ascii?Q?SSvgYOrO/1nT9k6NOxZBKlhgDxsp0e7w5cVqbY1uWaU1sP0N6pvoDwDSDs7M?=
 =?us-ascii?Q?FPC/MXGXkLiwqjitoDpJ5gO7Ej4eDjJ8bJZBxy6B++zZIqwR+1VKCcGlNwID?=
 =?us-ascii?Q?BrNqV37YvNnLQtqo3H9glXBa/oG4DoOOMwptSWrHibI80+QNq5xOXuz7q1bC?=
 =?us-ascii?Q?8YLu3kX1n8PT2+RaDqh2r/5C/YozoqL7Bucat7I/bJF0ekqNHg3FEhulVyS0?=
 =?us-ascii?Q?bbPVV1bu5PE2bqOV8bsoAvQuE8rlrm2IRQrbvryD0w/zuS5CC1dCfJDbTEMN?=
 =?us-ascii?Q?d9JLLPO8SnLvk4qEDpxdpdSMihXi395OfkmcVnEm7X/4L1XZLp/m85Q4g8OZ?=
 =?us-ascii?Q?pNXAIVU8gvolHrJlxpY1z40XYzxhSxq5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?E0rJFoH9lj1uo/zq6IgWg2y5wXYpjmDtFxBrl2qOM1Y5ggqA4Xw1asI3+Oy8?=
 =?us-ascii?Q?YMEbAMJZqlEvTk2mNM8P/7khf+5k//cfuXMonguALeZfNHQE8tqy5Ns4vBWr?=
 =?us-ascii?Q?QD473AuP2qM7UjidHvDbFodzReOaKniQF4lu5ZTK6M0EOyhlkx2NEaIl+kkE?=
 =?us-ascii?Q?WG9pMLCOqHdc0AXDfCmo/zzYmVX7Geihnvfnm+d8DiIGiCqHjMRN1imQmzxg?=
 =?us-ascii?Q?8l74u84Zfy/qqB67POhLljpIi/I//O3xAPp7mSZQItjhO3d+DnZxqLaVWH8o?=
 =?us-ascii?Q?TYDdaOGZnScdxAPEeyHw3r73uW7T0EDc4K8PbX1u3hrFqkkt2QlYZ1ZXutpP?=
 =?us-ascii?Q?wGfFw2kF53IEtZKT9dDmYZcqfqqHMOvZC4tE3Ktt7u4jC6wBateG1YvPyBAw?=
 =?us-ascii?Q?uzYJ7rlpW9cHq6IndHEwLeBYqVLtX4/AqgkTL5lyN51QiC6uulslCM+zyatP?=
 =?us-ascii?Q?O8d+m1RKp15FzhKIrJnfhL916E4P0soigX7ovLsnVdKNcSiArQ3vYFUQgEt8?=
 =?us-ascii?Q?9iOYq+D6T6q+khhUsNqpvJurPapXlV19iYW/R9wCSZMKvCeXXTIrVXuCJtZH?=
 =?us-ascii?Q?Q8drKo0sCdrxt1+BWxMT5s+x1utaVokw+etHCVOV6nCVLTmprp8hQ5/Tjd1e?=
 =?us-ascii?Q?sLqB+FgfDOdRxa1aTjglGPtsbfNEtONbCmGjGrq6qe9NTLAGK8bT2dlabwPE?=
 =?us-ascii?Q?gh6oRO6UScXJaTCg9jYPnOSHku+LpuzmvC5HQQwNJn4OZZQDReYY97CQC0DJ?=
 =?us-ascii?Q?oTB+pMNZQz8L2RCR5WPXUrw+ypumdNyrBHxzRYfHKseWybWwkaorc/019yVb?=
 =?us-ascii?Q?WYfai8q3oKUpmHvyYUfX4nAzSxLiA0j+hUoqeQXJrR0qCe8VDWmWbWnZsO6T?=
 =?us-ascii?Q?QJ7bqVrdFiLWSIySxFrLVQrKL//i+fRezW6C8zWYXc80lWRZJ1L/N5KwHvfE?=
 =?us-ascii?Q?UBTkwurQIPfiMarQ++OO8JkztRHW6SA0KAc5L8irwcre15NSnspeD2cJPZmL?=
 =?us-ascii?Q?+KrT3RO66ZvfyBgQ7lNL3dP0CGwvvrRSfJmEliQjirDPPArOrhaGzEGyPWVC?=
 =?us-ascii?Q?nFuTFmCqssmzonRLPKO9piVA0DVtxNHQPENOSnjf2nsvL2Yu9XEIyn5rFeSF?=
 =?us-ascii?Q?EVMsz9COHw9JIYpGlOMFK36J7OnxN09GImWQmYoMySgLESLyyjMe9tmNn498?=
 =?us-ascii?Q?VgAQmTGMqFTbHXIICU1S/+/mSbAt9hzUQS1hMsJpS/QO9GIIIXeS5XAdv0M6?=
 =?us-ascii?Q?vTYJgZ/d5dYp4q+KAt/9KJeneGbZnl3UfjMzUCUif71nksnND1vCDuTU+Qst?=
 =?us-ascii?Q?UjJaGxTwi7G6JPNW1FHrtINtCSkcWiHhYduvtLYz/Va5aCwww3nwFmpJbPeo?=
 =?us-ascii?Q?JPR624vVeS821zfMvguF/HaCfTQZlNDNu/H4isEsSy9qEEoiWaGE3yqpOL5y?=
 =?us-ascii?Q?fyp0OWAWrp9efzydUGjqJhSaXspAsEUfyyg8EVYJdR9Agoz7JW3E8c1+3TXv?=
 =?us-ascii?Q?TB09VeryCkcbwVKn2JQGwbbV8LhhRaG9znS8IN5fWGFVBx9Mn8PmNKaKKpEG?=
 =?us-ascii?Q?Mz8vp0bcIeaUHEspfCzxPPFvNx7c5REmM1D2qZKTn22QFNs0aEuxuV5MzTj/?=
 =?us-ascii?Q?b2Xk1uHlD1vDTDmpR4QN62Rm4vMKmTEIDqOFl74IJ7BQXtuOHFFl++jM5n9k?=
 =?us-ascii?Q?GYlHyNR00A8qGoI4wkZ2qvifzn9guukFvB/aVB73ccdhbY5BxAbWSn0oGW1Z?=
 =?us-ascii?Q?I4eb0agXaA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vmKFnyLMnSZbWvSkzbSJbIgtk6xeb4Fq3KhAFSswO0j0/Tcrj4jeucVZvLHej/+BhuF7YGQdlGRHBiyxaPzGKlkIHWN5Oi9Lupxi3LT3Wb5LSMw/pZO40Jug7hjyI36O+EsDvLODA7uiNEDSEdh7a9lqr/pEYD8TQq/6Nq0B08gUuVe54C3YOMOrmhhkaxRfbIPYIIrWGhWvlRDc3XUXFl7utbIJbB61ydJwGPxYT5ozmk7d4r/dDflUFunDy229aEe5AXfNtP1XCxOW9DgqsI+Xyz/lKtk6hMytm3omSLYW0P5daqDWPvv2WFPe2tdslEn+QlY1L/UXaeDXzzx9LT/VRFkhZ21R8ZxMgqQgg9IE3WuEWdLqn7oOqkUBlE3Pmi1pgSEsk7a+66zpWwtzqw0JQVP8f66XJkjyjFPuux6NcmzhTboNN0vAXoy0W8hmy5hWA7MRVDdY2vRGxKP6BM2dl6UaLPAUhtrM4j9/PX8BBcjAa+Ipw6QsunhGa4o/+rf/7EJKOUe7cQujK7H5GerNIUiEHQnc4MLY4jfl5TxI5frbmXInwzr8ThsWdgm3Lu5MBeCZExVY0tksI3DGg+OEeNOXtvfJ444Gs2z5dS0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97e0bea5-2e4d-4ad6-5fc6-08de40ff21e0
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2025 02:09:26.4409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ii6fNVWDRMCOfT/Qq87fqNlYbw4BldhJWPXiZZNNGTmnJFXSuDGGMd5gtMh3eRw0ZmQinkzirctOrH/g1/tuVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF376CF97B3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-21_05,2025-12-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2512220017
X-Proofpoint-ORIG-GUID: Pg0D5lmO60J-Nnm3fKQWs7FjOqoKtyOK
X-Authority-Analysis: v=2.4 cv=Z8Hh3XRA c=1 sm=1 tr=0 ts=6948a86d cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=86YlC6muG_u3XTKfDrcA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: Pg0D5lmO60J-Nnm3fKQWs7FjOqoKtyOK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIyMDAxNyBTYWx0ZWRfXxNKQrraElyrH
 nX5S3xAZQuaprJk4BjHMgMjZlYkYNXHCk/yyuh5La17i0ny355gZtrlWPH5KLZ2EWCDMD4NqY21
 zrkXa5FJXrfH+wpysu3OCbQd/tXRZWnVfV3Ej3VS4sSTu5cAHP+iy96JMcfVYbD2oBo17c+pxGd
 T4fzg4im2Kwlihmvc7/RzJNjz//FYXj1yWVxNkfsJkj7vDS9YxfsbdNbpRUF9rEHrvICgo4EZWt
 19TQdxbLEoWo64q7RsiWVwlxYnoW2+GqPJXKuAOT7/HI9cTdRmu++pAwKGMZulMob9XEZvqnPLX
 2QEbfJUaZWQZ3JrljdHdYJ8ZrpjlcDVtkOIC9R7NHV6lEV7aDQeJPdj8uM0aMhEoO9clfU9798v
 FwxaBdMJueHIuOEDtzpBQ2lIuG6GMJ2bk7dKvUAQykDp2Fl3Gc0OcH2a0AK3HO/YdkdWAyF4e1T
 Ck7FmJJCHKwy0AlrhWA==

On Sun, Dec 21, 2025 at 01:24:44PM +0100, David Hildenbrand (Red Hat) wrote:
> On 12/19/25 14:59, David Hildenbrand (Red Hat) wrote:
> > On 12/19/25 14:52, David Hildenbrand (Red Hat) wrote:
> > > On 12/19/25 13:37, Harry Yoo wrote:
> > > > On Fri, Dec 12, 2025 at 08:10:19AM +0100, David Hildenbrand (Red Hat) wrote:
> > > > > As reported, ever since commit 1013af4f585f ("mm/hugetlb: fix
> > > > > huge_pmd_unshare() vs GUP-fast race") we can end up in some situations
> > > > > where we perform so many IPI broadcasts when unsharing hugetlb PMD page
> > > > > tables that it severely regresses some workloads.
> > > > > 
> > > > > In particular, when we fork()+exit(), or when we munmap() a large
> > > > > area backed by many shared PMD tables, we perform one IPI broadcast per
> > > > > unshared PMD table.
> > > > > 
> > > > 
> > > > [...snip...]
> > > > 
> > > > > Fixes: 1013af4f585f ("mm/hugetlb: fix huge_pmd_unshare() vs GUP-fast race")
> > > > > Reported-by: Uschakow, Stanislav" <suschako@amazon.de>
> > > > > Closes: https://lore.kernel.org/all/4d3878531c76479d9f8ca9789dc6485d@amazon.de/
> > > > > Tested-by: Laurence Oberman <loberman@redhat.com>
> > > > > Cc: <stable@vger.kernel.org>
> > > > > Signed-off-by: David Hildenbrand (Red Hat) <david@kernel.org>
> > > > > ---
> > > > >     include/asm-generic/tlb.h |  74 ++++++++++++++++++++++-
> > > > >     include/linux/hugetlb.h   |  19 +++---
> > > > >     mm/hugetlb.c              | 121 ++++++++++++++++++++++----------------
> > > > >     mm/mmu_gather.c           |   7 +++
> > > > >     mm/mprotect.c             |   2 +-
> > > > >     mm/rmap.c                 |  25 +++++---
> > > > >     6 files changed, 179 insertions(+), 69 deletions(-)
> > > > > 
> > > > > @@ -6522,22 +6511,16 @@ long hugetlb_change_protection(struct vm_area_struct *vma,
> > > > >     				pte = huge_pte_clear_uffd_wp(pte);
> > > > >     			huge_ptep_modify_prot_commit(vma, address, ptep, old_pte, pte);
> > > > >     			pages++;
> > > > > +			tlb_remove_huge_tlb_entry(h, tlb, ptep, address);
> > > > >     		}
> > > > >     next:
> > > > >     		spin_unlock(ptl);
> > > > >     		cond_resched();
> > > > >     	}
> > > > > -	/*
> > > > > -	 * There is nothing protecting a previously-shared page table that we
> > > > > -	 * unshared through huge_pmd_unshare() from getting freed after we
> > > > > -	 * release i_mmap_rwsem, so flush the TLB now. If huge_pmd_unshare()
> > > > > -	 * succeeded, flush the range corresponding to the pud.
> > > > > -	 */
> > > > > -	if (shared_pmd)
> > > > > -		flush_hugetlb_tlb_range(vma, range.start, range.end);
> > > > > -	else
> > > > > -		flush_hugetlb_tlb_range(vma, start, end);
> > > > > +
> > > > > +	tlb_flush_mmu_tlbonly(tlb);
> > > > > +	huge_pmd_unshare_flush(tlb, vma);
> > > > 
> > > > Shouldn't we teach mmu_gather that it has to call
> > > 
> > > I hope not :) In the worst case we could keep the
> > > flush_hugetlb_tlb_range() in the !shared case in. Suboptimal but I am
> > > sick and tired of dealing with this hugetlb mess.
> > > 
> > > 
> > > Let me CC Ryan and Catalin for the arm64 pieces and Christophe on the
> > > ppc pieces: See [1] where we convert away from some
> > > flush_hugetlb_tlb_range() users to operate on mmu_gather using
> > > * tlb_remove_huge_tlb_entry() for mremap() and mprotect(). Before we
> > >      would only use it in __unmap_hugepage_range().
> > > * tlb_flush_pmd_range() for unsharing of shared PMD tables. We already
> > >      used that in one call path.
> > 
> > To clarify, powerpc does not select ARCH_WANT_HUGE_PMD_SHARE, so the
> > second change does not apply to ppc.
> > 
> 
> Okay, the existing hugetlb mmu_gather integration is hell on earth.
> 
> I *think* to get everything right (work around all the hacks we have) we might have to do a
> 
> 	tlb_change_page_size(tlb, sz);
> 	tlb_start_vma(tlb, vma);
> 
> before adding something to the tlb and a tlb_end_vma(tlb, vma) if we
> don't immediately call tlb_finish_mmu() already.

Good point, indeed!

> tlb_change_page_size() will set page_size accordingly (as required for
> ppc IIUC).

Right. PPC wants to flush TLB when the page size changes.

> tlb_start_vma()->tlb_update_vma_flags() will set tlb->vma_huge for ...
> some very good reason I am sure.

:)

> So something like the following might do the trick:
> 
> From b0b854c2f91ce0931e1462774c92015183fb5b52 Mon Sep 17 00:00:00 2001
> From: "David Hildenbrand (Red Hat)" <david@kernel.org>
> Date: Sun, 21 Dec 2025 12:57:43 +0100
> Subject: [PATCH] tmp
> 
> Signed-off-by: David Hildenbrand (Red Hat) <david@kernel.org>
> ---
>  mm/hugetlb.c | 12 +++++++++++-
>  mm/rmap.c    |  4 ++++
>  2 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 7fef0b94b5d1e..14521210181c9 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -5113,6 +5113,9 @@ int move_hugetlb_page_tables(struct vm_area_struct *vma,
>  	/* Prevent race with file truncation */
>  	hugetlb_vma_lock_write(vma);
>  	i_mmap_lock_write(mapping);
> +
> +	tlb_change_page_size(&tlb, sz);
> +	tlb_start_vma(&tlb, vma);
>  	for (; old_addr < old_end; old_addr += sz, new_addr += sz) {
>  		src_pte = hugetlb_walk(vma, old_addr, sz);
>  		if (!src_pte) {
> @@ -5128,13 +5131,13 @@ int move_hugetlb_page_tables(struct vm_area_struct *vma,
>  			new_addr |= last_addr_mask;
>  			continue;
>  		}
> -		tlb_remove_huge_tlb_entry(h, &tlb, src_pte, old_addr);
>  		dst_pte = huge_pte_alloc(mm, new_vma, new_addr, sz);
>  		if (!dst_pte)
>  			break;
>  		move_huge_pte(vma, old_addr, new_addr, src_pte, dst_pte, sz);
> +		tlb_remove_huge_tlb_entry(h, &tlb, src_pte, old_addr);
>  	}
>  	tlb_flush_mmu_tlbonly(&tlb);
> @@ -6416,6 +6419,8 @@ long hugetlb_change_protection(struct mmu_gather *tlb, struct vm_area_struct *vm
>  	BUG_ON(address >= end);
>  	flush_cache_range(vma, range.start, range.end);
> +	tlb_change_page_size(tlb, psize);
> +	tlb_start_vma(tlb, vma);
>  	mmu_notifier_invalidate_range_start(&range);
>  	hugetlb_vma_lock_write(vma);
> @@ -6532,6 +6537,8 @@ long hugetlb_change_protection(struct mmu_gather *tlb, struct vm_area_struct *vm
>  	hugetlb_vma_unlock_write(vma);
>  	mmu_notifier_invalidate_range_end(&range);
> +	tlb_end_vma(tlb, vma);
> +
>  	return pages > 0 ? (pages << h->order) : pages;
>  }
> @@ -7259,6 +7266,9 @@ static void hugetlb_unshare_pmds(struct vm_area_struct *vma,
>  	} else {
>  		i_mmap_assert_write_locked(vma->vm_file->f_mapping);
>  	}
> +
> +	tlb_change_page_size(&tlb, sz);
> +	tlb_start_vma(&tlb, vma);
>  	for (address = start; address < end; address += PUD_SIZE) {
>  		ptep = hugetlb_walk(vma, address, sz);
>  		if (!ptep)
> diff --git a/mm/rmap.c b/mm/rmap.c
> index d6799afe11147..27210bc6fb489 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -2015,6 +2015,8 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>  					goto walk_abort;
>  				tlb_gather_mmu(&tlb, mm);
> +				tlb_change_page_size(&tlb, huge_page_size(hstate_vma(vma)));
> +				tlb_start_vma(&tlb, vma);
>  				if (huge_pmd_unshare(&tlb, vma, address, pvmw.pte)) {
>  					hugetlb_vma_unlock_write(vma);
>  					huge_pmd_unshare_flush(&tlb, vma);
> @@ -2413,6 +2415,8 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
>  				}
>  				tlb_gather_mmu(&tlb, mm);
> +				tlb_change_page_size(&tlb, huge_page_size(hstate_vma(vma)));
> +				tlb_start_vma(&tlb, vma);
>  				if (huge_pmd_unshare(&tlb, vma, address, pvmw.pte)) {
>  					hugetlb_vma_unlock_write(vma);
>  					huge_pmd_unshare_flush(&tlb, vma);
> -- 
> 2.52.0
> 
> 
> 
> But now I'm staring at it and wonder whether we should just defer the TLB flushing changes
> to a later point and only focus on the IPI flushes.

You mean defer TLB flushing to which point? For unmapping or
changing permission of VMAs, flushing at VMA boundary already makes sense?

Or if you meant batching TLB flushes in try_to_{migrate,unmap}_one()...

/me starts wondering...

"Hmm... for RMAP, we already have TLB flush batching
 via struct tlbflush_unmap_batch. Why not use this framework
 when unmapping shared hugetlb pages as well?"

> Doing only that with mmu_gather looks *really* weird, and I don't want to
> introduce some other mechanism just for that batching purpose.
> 
> Hm ...
> 
> -- 
> Cheers
> 
> David

-- 
Cheers,
Harry / Hyeonggon

