Return-Path: <linux-arch+bounces-13517-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D97A5B555D2
	for <lists+linux-arch@lfdr.de>; Fri, 12 Sep 2025 20:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E1395C5049
	for <lists+linux-arch@lfdr.de>; Fri, 12 Sep 2025 18:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6AAD322DC5;
	Fri, 12 Sep 2025 18:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jvSRg0NK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="a4rlePXc"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F69F19994F;
	Fri, 12 Sep 2025 18:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757700437; cv=fail; b=m7/folgUWY/fYqslM7jEMN7V32d/tjv9b52OMvfs7uY5GkryE2at46+Bb68qny1LUkxYheDaUgX0uFfqnlfaNGrlEFLgQ71Z3Srz9XPsJD92vMhk6SoFLt1cC79DELXUt8s5lg6srOfKNpbR36FCpAj7yQnep0pJwcqAKPL+0Fk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757700437; c=relaxed/simple;
	bh=XYcxYDmnkTrUGWc8uWZ2IE6McR9eunOEtLmPr4PUMM4=;
	h=References:From:To:Cc:Subject:In-reply-to:Message-ID:Date:
	 Content-Type:MIME-Version; b=AS9LHAgSA6PENth9rPpRLyCEY9FeMW2GD1GqE3EPsSuNi8DevyveCC4U1w3M5bJr0Bnt2q7iXoe+MMm/pWytWlXizvMjs+8oX4hBqO6GAo3YxKBDBB/J7uGAucSnA91feyF/KrcelRIfwbQgKhAltnxDNLDdj8lXWQEA0N2BXLc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jvSRg0NK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=a4rlePXc; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58CHtrkk023754;
	Fri, 12 Sep 2025 18:06:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=XYcxYDmnkTrUGWc8uW
	Z2IE6McR9eunOEtLmPr4PUMM4=; b=jvSRg0NKJSFAVdxYMVNuZ+OhQ3ykUsMxmA
	Vqar0ijSiHyeSLdpJ5psgn5Ep99qdVMO53n13/tSSc/PPXPmOZMUEQyyH5YOTKhy
	GYgMUhpcMs+5J8md/PHWV1GEF2CqZY6eH0XeA4JtCGpu3lFi5uf1H861gEu6MWDk
	tBb3ShbLiAv8eE5KNzn4KINhoBdGCcZR/lvuttR7+f+LvrB2wHesQJ9SHqwM8KOC
	CM6j7gMvl423ZSh8jHaOWHPYY7DDdq4UeVViijqkIT67yqbI5XDKiDNXTcOwHJXX
	0bnt1GB7j8rwbQBl5CFsP4RRV/IVRHEo5H0ERIjD5XPfb6BTD8Vg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4922x98q0c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Sep 2025 18:06:51 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58CHaSDj026540;
	Fri, 12 Sep 2025 18:06:49 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011013.outbound.protection.outlook.com [52.101.62.13])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 490bde8q0b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Sep 2025 18:06:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U03Gons2MuhXB+gfgqgkqFoXzu27Uy5noiRtORnR9FEhgZaUqOLkA6xkf69V4FO9qaO05LLY4/T2XzPn1B4iQyCIE5Llz/JYzIWPvZXcmrn3HA+zXQEj65VvM8V68spEpmEJw8NwVeiWOWhIaLUf0NuKKSa+/BxdAtngX1FSPYsl4Z2UPmUL2QgX06o0yrMDYaiLyliwNBIcqR6iy057rBRLHDY1fjXIfX+2d4mjhW2xB31XtnZVHFDHfNaWPTVvLkCe/2BDWaH8GTUCo2yPK2AsULQySMzc5l7CidLThNAK1l3lp4aUhrbVZWn5TR9c21G+DAkJ+Bb9MdNzrj/0mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XYcxYDmnkTrUGWc8uWZ2IE6McR9eunOEtLmPr4PUMM4=;
 b=RrVXSbH+HivpEsEba2+U2ukrVLRBiv8WXSGE+eyr7q6K1k2HECTKrtlLiOqy9COjEsARn9ghZvVUligVBIqwDEzZoTMDYb0+ev2iUOzDXFr3PZ8G+L78Zbh6Y3ILtHmxunoHrF1ATpRS9ptHynv01oEkQsrqMC4YaE7K3RL20NxYHWe+KezY8y/8T3GC+svywo98fWmgx/3hCjvQXWJOyLrtChuswfRKwOTsjOJB0AEXhXgIIZt/tBsmVomd7XEQ77BY5WTxWiHs7tSVkMxOsDgA7Ok6ZR64oh7/CLhLupXL8pgel6jFzYou36x+wX7LglDNN7TBzNDLdPSPEpLUQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XYcxYDmnkTrUGWc8uWZ2IE6McR9eunOEtLmPr4PUMM4=;
 b=a4rlePXcSlOl7zyB1gblyvxmY0CwAk2TySfVMvBFGQ/RHFpEMM+mA732zz8cVvR4PS0XVAU5BRo9yZ0Mv4Tj+p0XNDd40X/1BF0FJ7S69bbICerIqZi1TD0rG2usN/Dp2/vX7upLLikvRd4oAs1JbXGR586mtXcrfgDD4/k8LJE=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CH3PR10MB7330.namprd10.prod.outlook.com (2603:10b6:610:12f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.18; Fri, 12 Sep
 2025 18:06:47 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9052.013; Fri, 12 Sep 2025
 18:06:46 +0000
References: <20250911034655.3916002-1-ankur.a.arora@oracle.com>
 <20250911034655.3916002-6-ankur.a.arora@oracle.com>
 <aMLdZyjYqFY1xxFD@arm.com>
 <CAP01T74XjRJGzT7BV3PYQOQOwZVud3nL7HfcW3kzU_fPFekNHg@mail.gmail.com>
 <87o6rgk5xd.fsf@oracle.com> <aMPyiKuzGh4L4gD8@arm.com>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Ankur Arora <ankur.a.arora@oracle.com>,
        Kumar Kartikeya Dwivedi
 <memxor@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org,
        arnd@arndb.de, will@kernel.org, peterz@infradead.org,
        akpm@linux-foundation.org, mark.rutland@arm.com, harisokn@amazon.com,
        cl@gentwo.org, ast@kernel.org, zhenglifeng1@huawei.com,
        xueshuai@linux.alibaba.com, joao.m.martins@oracle.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH v5 5/5] rqspinlock: Use smp_cond_load_acquire_timeout()
In-reply-to: <aMPyiKuzGh4L4gD8@arm.com>
Message-ID: <875xdnk0ju.fsf@oracle.com>
Date: Fri, 12 Sep 2025 11:06:45 -0700
Content-Type: text/plain
X-ClientProxiedBy: MW4PR02CA0024.namprd02.prod.outlook.com
 (2603:10b6:303:16d::9) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CH3PR10MB7330:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d5d49c6-a591-4905-9ef7-08ddf227234e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?P8rz9SMYaRGBgWz+oBfN0E4xD25NFVaJWkHLzHLngeEGHSCwBVz7vGx2E1Ct?=
 =?us-ascii?Q?kxVf6iEyxNym8WWAupHGvB9w5Rnjm/Sdiu3JeMTpMUskaKA1v4PN/vqJwin3?=
 =?us-ascii?Q?KzfIr+zvIZ5PYdKhOCEkXfOKvZS+6ucg/YMmKBqKGHraKDpcdFH38g/wqmNr?=
 =?us-ascii?Q?KBo728/MZY5S/PPadMd1h+r08A8L2I69viHKkVddwfuJFKj2x381YBkiK2Sb?=
 =?us-ascii?Q?rcMmOBnYLqkoBOY6AEkFcKzhXBa6+OkYjXB3lje6R2xtzRd3MYiTn9gofhDp?=
 =?us-ascii?Q?apFWhhJZn6BkWZzZpuxQNcLWlFBlwB9CS7xLHc/QH8Xj7mYE4Ad4+8WGVyPS?=
 =?us-ascii?Q?0A3cUIfIygFCCREojxD74VWyvAU/XBMzH7rg9ZvZs5WhMs5e3lNy7Fwxzxcx?=
 =?us-ascii?Q?1OFqQjqrCUTKMeyPdgyDllSD5b7QD0zB4fB3f6YNw7X9zpRDxp35e3z1GPmd?=
 =?us-ascii?Q?2O/nTOvWHkSSGUjeRnPHW48d3E2nOeNFcOWPUoHF9jtaaC8j+Fs3Cp4hRv2y?=
 =?us-ascii?Q?HDRpfE/7Bo13ELSvK6D3gW0gBAK12ZfLHhk1bbYNjL/ZXbxhRzy3DLbO2wF4?=
 =?us-ascii?Q?vdY9OCVgr5mSVi7ZXXG/Z1ialpp+OYGtKvt/K+X0jNaRpVj2z5TJ+frKNjVZ?=
 =?us-ascii?Q?BUkm96QjCQJxAIGzZkP04esR4ezCG8ahl/PhfbIaTwk6pJJQiv1sPMY7buVZ?=
 =?us-ascii?Q?zRY5lgJzeDQJvo42Usv9+4HjVuLsaEc3vJKVO5qQ5/gXOlkH+SDaIxVG+XYd?=
 =?us-ascii?Q?ADs83kKsJ54HwoyOJKZM1VoQNXnShRO1y3JIq53fXxSRF9N/yRPsDm6b8oWc?=
 =?us-ascii?Q?PyXoYBtidTbFvK3RYCvVf+m4gw3JPr6HcMGNgC+0y56leoY5gcW6mQb/o2Dm?=
 =?us-ascii?Q?qtzJzWEPfPLsM5Knyy8t6OBHTEPPWaZ7aFcRj2tW5M/LIw/lAwWjEFyZmplX?=
 =?us-ascii?Q?ZTCDtSmP8x/KEbQk7GjXgfhq2fqQ4YAuc+Dh4IpEmlkIG92hNPNYLAXbXIUO?=
 =?us-ascii?Q?4+xbtdm9d9aLf3lPKIxDEHFqnFQGFOLMXc1JjxZd81JmRsFrYb3yL9AeQvIN?=
 =?us-ascii?Q?ZFCrCF899BWUhSi2MABJiwgaxKr22Jxquq1MlNlV/kPRqynAmvHMXz+761Th?=
 =?us-ascii?Q?D8/VivNAwvYINc524aT8fn+2ouIa6LTpHdnPQW24r34k8eKcncpgEDg5Y+LG?=
 =?us-ascii?Q?a3xFQCF4ZHmStY4MFKpkZ/2oI2abSHOsGf2OG0hB0prmjfwxmu+oajwH2x5a?=
 =?us-ascii?Q?O0hOl/FBJN08sx+F7sa1xmkprHo0vpInz7m07oZud/oGt4Dc9nWVq0tgMI/8?=
 =?us-ascii?Q?sdP4GACHIu6RgPilWfTTHdu2g1Oy/fE8eofD5trY0O96yxYxQyPTtvwN3qQF?=
 =?us-ascii?Q?WEPhgORo8uVG97L5paBSQy40YF03HAClSn0eRUStfYrPMP7OG9PZetXs+D/z?=
 =?us-ascii?Q?AJXYBeaRQDE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FueapFG2Fi33+zWnQJuua39QMFQA3O0KX4vfdMx1uHn7vdRlssGVG/T8/3Hi?=
 =?us-ascii?Q?zRzvXDT89zgSoX/meIQRF94pl5gK/jYB6GRd3jLVN5aPKwSAb+73LpzVPWlU?=
 =?us-ascii?Q?UWFDeP5bRZhgZG4I+QCfPj4oeLOI9Rlr+pBL1B00lhNfDFxnOjLpZL6w2aXN?=
 =?us-ascii?Q?GczJED6z+gh8xvzKZ7+kbX9E1aQlUJodlLx7aeL8Nbh/lRMHMAZY8oliQ6oQ?=
 =?us-ascii?Q?B0EqcFcgVhp/WsCxMWkqsoWJLvzT+/x6jE4UbxtenWuiDjtIaPUjgZWVcG3l?=
 =?us-ascii?Q?3In5rpwXzC1zrl4NYJpZVg2n8O9pB+1Cy3BXGtIvLWAuk1ibZX3jwFF0oSE5?=
 =?us-ascii?Q?7WEcbV5e6IeJK/m1SnGm7rOycdDtxarSTZpl3QIPIDP5d84KM0RA6LUtLo9F?=
 =?us-ascii?Q?6NktHvhCLZ3vgHb5p7q99eK9ueU7GvuNzHJ9moD2fm0P6oCKpMYCEK8pD3ky?=
 =?us-ascii?Q?qwUkjfXQNsjtKYthvIM+f6xnnkwsOpnAOaR66E4cWWxOn2KE4edUc8YIpsUJ?=
 =?us-ascii?Q?KIAt5Wk7uRNmbNXiTDvFklX8wfLM14lVs/XrQL0C7yWFZ1+ix3FBK0fqo+mz?=
 =?us-ascii?Q?luFwIN3f1Kuxt0LaGu2ejFTzlUSvUJlHRmIgzrEF2/MsoEfMGDvS+Wf1LZAm?=
 =?us-ascii?Q?ZRtjf5LtTY2d1KRLd8XPnCv2R9t+Q41PoMtxXdaSKKNLk0MdJipTz4+I1Hf1?=
 =?us-ascii?Q?vZw7uywI7bXe2Q9zImSNZfE3up6lAxHbFNaVe0LIdNr1peej0KyVnebKXNJT?=
 =?us-ascii?Q?Wh1lUshxGm8ZAhJATHClpxHZEGOyFsgM/DNkQECHaWjN0kp+OLyNzHOgaKYX?=
 =?us-ascii?Q?S3UGI3x9EirkhaFV4mmGFAlrS8BCRK07dG/77MJzerfcSCODB0VJUPSFXDOT?=
 =?us-ascii?Q?NrqQuTk1fZh+3ZieauOMbNV12DvBuIL3zcPa6Aa7YaNbU+TiFyWVTGsktAlt?=
 =?us-ascii?Q?uWY91RP7eCTWHC8vjcbszco3Ya1nl4wRZQa3W3//CzVLNicIqsL5xdsqprZI?=
 =?us-ascii?Q?84xkdXhLnElBHSWlFaQ9CwnY5+2oKsonR5avouHDwdwhb3OQS9/Cn/kssDAS?=
 =?us-ascii?Q?vlmEGxUGfMno3xF0qcX6a5l5Ils6vhrud4C5HjOaCcCCcIV7ACDub01sql4J?=
 =?us-ascii?Q?pFjf/WUa1EDarXTwT4ixGZZlLigRhbpoGPbrgrUN+JZNX+aOE1wJceNaCHGX?=
 =?us-ascii?Q?6Zggx7/e+Ki2KSL61SejZkTBf/3eP6BFjgOxexnmN4jxBTtzAypNt6LuubpD?=
 =?us-ascii?Q?W98thjkNveM+PXpFr78vOD/0JZOMUMb90TVHjSdF0tPZWP+tpEvP9BCcc9Wp?=
 =?us-ascii?Q?yL08cH8Xfg9DM0UCPZ6z6lqddTEH33aYpSckTtvfeioSaAzwLifRpvriJK9F?=
 =?us-ascii?Q?QrgiyFM1uEwfhWXqNa3jHPzW4DVhAiMvL9M4A7GEdGNCHirD7gZPi+u+uUSz?=
 =?us-ascii?Q?9mHfqnuwpFx6Ol9MC3ktr3FF2R60Z+4wDUCY4ays31rbtJ3CpIHq38ik7IK+?=
 =?us-ascii?Q?4w3fcOX6iYp1i4SUrp2iBcdd29ZpjI8l5WKZ9BECi9fagE6MOE78hMV+KxBj?=
 =?us-ascii?Q?sYwG4mAP7W5b7pxKerwuXuPu1IDIdkmQt6OqrxXe0SE0k+3s5h85hH/CFkUL?=
 =?us-ascii?Q?5A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	CGjZd1NlD5hj/LPgLyvybm8wpgQ0vYxETqTeEXE/MTMIcxAslfe2LOJmDQKM63we9ggRypZGAmq8fpvHxBhhOYmiYC4zrKTtAfFC5U7NqhaCvMyoxelTard/fnB7kmAyph4ONCrSfP6rDw7fYu89+mN5gry08xti1ciLBuQQHITgxz23yx2QjyYQyv3kpRv2Bu2kd4rX1Xqm7zU5+ZbYUeQaQxrjwNiZb9OAAJzHNijKsaV7JnhnYvXitflRrYIR4MSse2xGSvx5a7qqYWRQadv87edk4a5uYc5O1J+2Dt6O7LH5XoZ3ZQ5bvJ7eIMnyvxOq3s5fJZhSBGMw8Cm57BvHcyGqe95FqiXBko5nCo2CmfYRThSR4JMnH3mAPv8O/2KdG573Md4dNbyvWpdumK3c/ITl2d+A7/PkeQerggO9KP4mMjtq8rGGdEaDZbjcR07HGndb15y1aWDuWKChOT8+atUOlYP0Z+dsCRpDIwGw0nmHZ8HWNZT21DyK/CIW3/HxpGDZF1xVrf452Uc3B4i5BTLdi1Wd2pP/W0p7hdgnQ42IeeYnb5JLLPTtiQ2VDMDtDL7JyuUeEprsOczev44Jh1sxzJcqQQ4xmPVPJeE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d5d49c6-a591-4905-9ef7-08ddf227234e
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 18:06:46.8668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L8DQwZaLGgJjidyv4pMFXNiyH62rkfuXEj8lQTrXMnPD4Oc33oPEiJXIISIpxepJtPrz9tB5mow4MgFJLhqB9CUlaEIvxFevkmivjPr/3eA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7330
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_06,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxlogscore=921
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509120164
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE2NiBTYWx0ZWRfX3lKZaQnrDG4q
 80EakebnwkFmO6Io/hC4n+iShBA2d2pFLsBSot0OeBDeHKbaqjQLke8u9OZDS6W674EIqaPz3xe
 RpALJJ/iQ2SQPJZeDs4WAwZpUZy7RE2VgYZvotoqlYB7bgmL79+BySClT6KS1V+KtT+aSue/ZJm
 D/75g+/9oxgNS/YWJvIxK7uDS/+AL+0jta+QqUS/Yr/+qhYKb07b3agqhQuyCoWSOUcWsWqN5Jt
 4JDmKPavTJc6LvN+BYGBlqiyLlp94snMCr5rW+gDZWlPJxTBKmHZ2Yt8EYj4bQ68DapLeKB3nmR
 dgAPJ31575tyXuwNHOOnS54fr2tlIlyIIntcDMRnGU9XOk48X8m0fWC5MatM/hLrvO8jO6dmomq
 tIOWy9w5xvCfshRUgaQLAGjS90HpKg==
X-Proofpoint-GUID: 79ptkbxR632oP-BlF8K0XXNttvOZnJc7
X-Proofpoint-ORIG-GUID: 79ptkbxR632oP-BlF8K0XXNttvOZnJc7
X-Authority-Analysis: v=2.4 cv=LYY86ifi c=1 sm=1 tr=0 ts=68c4613b b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=7CQSdrXTAAAA:8 a=pGLkceISAAAA:8 a=dX-lX1ajrAD65Xeq-oQA:9
 a=a-qgeE7W1pNrGK8U0ZQC:22 cc=ntf awl=host:13614


Catalin Marinas <catalin.marinas@arm.com> writes:

> On Thu, Sep 11, 2025 at 02:58:22PM -0700, Ankur Arora wrote:
>>
>> Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:
>>
>> > On Thu, 11 Sept 2025 at 16:32, Catalin Marinas <catalin.marinas@arm.com> wrote:
>> >>
>> >> On Wed, Sep 10, 2025 at 08:46:55PM -0700, Ankur Arora wrote:
>> >> > Switch out the conditional load inerfaces used by rqspinlock
>> >> > to smp_cond_read_acquire_timeout().
>> >> > This interface handles the timeout check explicitly and does any
>> >> > necessary amortization, so use check_timeout() directly.
>> >>
>> >> It's worth mentioning that the default smp_cond_load_acquire_timeout()
>> >> implementation (without hardware support) only spins 200 times instead
>> >> of 16K times in the rqspinlock code. That's probably fine but it would
>> >> be good to have confirmation from Kumar or Alexei.
>> >>
>> >
>> > This looks good, but I would still redefine the spin count from 200 to
>> > 16k for rqspinlock.c, especially because we need to keep
>> > RES_CHECK_TIMEOUT around which still uses 16k spins to amortize
>> > check_timeout.
>>
>> By my count that amounts to ~100us per check_timeout() on x86
>> systems I've tested with cpu_relax(). Which seems quite reasonable.
>>
>> 16k also seems safer on CPUs where cpu_relax() is basically a NOP.
>
> Does this spin count work for poll_idle()? I don't remember where the
> 200 value came from.

Just reusing the value of POLL_IDLE_RELAX_COUNT which is is defined as
200.

For the poll_idle() case I don't think the value of 200 makes sense
for all architectures, so they'll need to redefine it (before defining
ARCH_HAS_OPTIMIZED_POLL which gates poll_idle().)

--
ankur

