Return-Path: <linux-arch+bounces-15530-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 158C0CD4E56
	for <lists+linux-arch@lfdr.de>; Mon, 22 Dec 2025 08:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8D233006F52
	for <lists+linux-arch@lfdr.de>; Mon, 22 Dec 2025 07:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9BEB2868B4;
	Mon, 22 Dec 2025 07:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XkcaRKMO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hUa+NcRC"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6331C84AB;
	Mon, 22 Dec 2025 07:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766389677; cv=fail; b=MdD1RLlJUbpacRvVW+KigAC7IVRnVKBbeW0/GIkGP+v4l64MLnanXzSeOTLyjMzgQlM5US8WJaXfqe0eMbdL3Z2GCvqBQ/DCqBfWSlnlfkp0Q23Z6SvOyljzrf6ygBTL/yKuZCew/7E9alqTLRGngL9DZ3h6zpIUxb5WI7YzVHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766389677; c=relaxed/simple;
	bh=Jv+mZyj1JqkKi+V/qy0wGj+dDMKHP+R1rf7irvqbCj4=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=eUfe0UhbGrweTNXT7nbUZvq9ymcEtlG2Y2xIbuemvtnXQCdBBWAbdvpN4sKzDK2e+FTKJQ1Mjp4vIevJK9nRq2RmErgyIyYEGzV2xWkxhhC30U2T8zjJdjk6IPGTb555WQLsuhWyqjDnVB8rm3PbUu8fwMCHXmwtA6ZMNhkGOyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XkcaRKMO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hUa+NcRC; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BM7VpAL2044137;
	Mon, 22 Dec 2025 07:47:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=basmMb2M7qCHgtneOI
	swuJSFzcEpHXw3r2NoxJIqd+c=; b=XkcaRKMO2Glrh/nn7ny+Bk0aqQ1VB8NQHl
	2tM+xRAv2sl3kHH3sTCXPtRQ9SoQ0GKnCC9exMTXiFRAMLsHWTQpjgGdMzuxrZis
	vdg1+Zf/wYVJem3//Y5LXG5pOu4lS6ugKG7cPqQrO5OWztt0KaY485+4bR7j8n1c
	cqcV5XBLnWPSzKDVtT40JRT+I0rrEMZY9sEn+2NwhcSCwUiyixwAfkZgoTCF1Kla
	0I0wr0n6KYLWodREzolGuo2srs5Qtf3YZakvahhGF7HJX5gZR2mVYl4A4y40ggn/
	ONi4NDDvrfCBcbmatEe6slGyDyJZgBW0AzR7iGXcgwXo0aBz4/4Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b71na00ex-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Dec 2025 07:47:14 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BM4XSv0016542;
	Mon, 22 Dec 2025 07:47:14 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010005.outbound.protection.outlook.com [52.101.193.5])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4b5j8h252v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Dec 2025 07:47:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G9xcl/PkT3fUvRpTwNh8km+TeGRc3D3ZtB0qNlCCgvWIe/wcMGRSu2F5kUbweNMUiS6WfjyaoyfwRFyXWvx+eDtchWpd2oiA0umHrNSoXJbWWdB0hyu1AAjFma1Q0khimP4RbFClqzCvFMDXRuerV0/Be7BIKG9jLGX4Rod354yh8bzVZehfGBX6fGC6IH60DQ0WQPYdFbKV6+YJTllfEjWXhK5iFY/nMD47b6hMT0QhTxYiJqOD42/R+Ztj0+yQ/Gnr+OEmXiBrPJKIWrB2dngPnGnCVC6QCkDLctHYLIWBQihAPWk3oTWCtPencSP/QUJQL5xJCKA+bxOUPsGMiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=basmMb2M7qCHgtneOIswuJSFzcEpHXw3r2NoxJIqd+c=;
 b=DtXqBJ/BIwthjsYu3Sp1Oc5juIIiekYutwaJCU6W03Chl5uM93WJs5ERZ4VZreyTAFjVb+TdPBMCJ0kw9gut5Tp5XFReR5Hch5DBadTWC0GxmDekY3Ty5MD7WdBSPWG5fdrP20Z23qODNjDgvJEyI7RGcbntEI5BIIq9kqL7xREdDbpW3OEmXFlQsNalQ19MzXUKYZSFmxWEHv4MQa4Pf2i2CqQKisSC/AQwkO3JfNFoVhpBdVBWyMUIilwWPGlf/+1KM6Co04lPr+/u2BspW99xo2EyAoK92kMqRINHuQ28akKbVftpghkYIo/V2bThxgnig+TmSoINwNX0D/7iZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=basmMb2M7qCHgtneOIswuJSFzcEpHXw3r2NoxJIqd+c=;
 b=hUa+NcRCOzqEsRUpSACk5UXsmAy10YJZH4cF1WFnQqci62LSod8pAdlQacXSxn3+r/+AjlgBDYb16eNPU6oVok96AvQloAwFx54BzOzsvSqhSRh2eXS7kqKiLdyH453VSmcZXR5dPHFutovKX+NGSzA/JYDNSOjfadfTVpwhXT4=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by PH0PR10MB6436.namprd10.prod.outlook.com (2603:10b6:510:21c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.11; Mon, 22 Dec
 2025 07:47:10 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9434.009; Mon, 22 Dec 2025
 07:47:10 +0000
References: <20251215044919.460086-1-ankur.a.arora@oracle.com>
 <20251215044919.460086-2-ankur.a.arora@oracle.com>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        bpf@vger.kernel.org, arnd@arndb.de, catalin.marinas@arm.com,
        will@kernel.org, peterz@infradead.org, akpm@linux-foundation.org,
        mark.rutland@arm.com, harisokn@amazon.com, cl@gentwo.org,
        ast@kernel.org, rafael@kernel.org, daniel.lezcano@linaro.org,
        memxor@gmail.com, zhenglifeng1@huawei.com, xueshuai@linux.alibaba.com,
        joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: Re: [PATCH v8 01/12] asm-generic: barrier: Add
 smp_cond_load_relaxed_timeout()
In-reply-to: <20251215044919.460086-2-ankur.a.arora@oracle.com>
Date: Sun, 21 Dec 2025 23:47:09 -0800
Message-ID: <87cy47t0ua.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0321.namprd04.prod.outlook.com
 (2603:10b6:303:82::26) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|PH0PR10MB6436:EE_
X-MS-Office365-Filtering-Correlation-Id: 783d403b-6b1e-46f3-a773-08de412e5029
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?etd6rsx9dkBKnT7zkYdYXYok2hLdyI1WOmqKjVPaF9oaNf2QL1a9Db2YrJf0?=
 =?us-ascii?Q?ZVA8TD5/q4AALhh64h110Oqlk8PPJfY9omI2Vsjxnp3Jlz01rZ+yjckHgCeM?=
 =?us-ascii?Q?yclENpmkQUQgvcA3RkXH/ClYyDzt66s9X99SEAp6B2Fih22gehHEQ32dNTyf?=
 =?us-ascii?Q?bDKFCVz6QZHScjjPceAjwtf9ew15/ON5b3he/UntQcncDcaQ/9jtgTrZXGfd?=
 =?us-ascii?Q?J5KZXmn7UVaCKoW39reqT3UxcIEgls8GmZfFkMHtNqnhrx75hRoTWAYcoXk9?=
 =?us-ascii?Q?FklSMbSg+CpbI0AogCXPhs193P16JOmpvGQxvUqr7e5d/nHPmc5UNYecuy42?=
 =?us-ascii?Q?k8PObXfPoRItZ6LhhLookdNFBZKl2QhrBNfYsvRGW3Aez/u4b+rS+64oj7+g?=
 =?us-ascii?Q?FBnnNDVYBLw9R7i43jIngLwIJSWGX07ZsOZYrwmTBoyQn1nhGS89JidWyuMj?=
 =?us-ascii?Q?ZEpJnc73vfErDzcun5/yNxejNiFaK88f5qDvFFEfO4dewYkmBaN50K0Zwl67?=
 =?us-ascii?Q?sVNWmyW9CnaZtIus7Y46a+DPFJKkjS3V2lbFNYiMoHuPCkW3BBx8D/4p/wHK?=
 =?us-ascii?Q?3v1qRguj1jZRMIWLekKOc6hiqTp2OtOEp0U6rRXcT9Rr1JL1tMZRIdaaeSgl?=
 =?us-ascii?Q?GgRCiKQAmpwuc3ao95JETRmGrcR2hEhEHDMxILrn5/9T1Lwq6HWdFss3vl/f?=
 =?us-ascii?Q?fh06wgzEWNvR+lt5uQ+KeUFPStphTeRWoRxxcazJ+R5lfhyO7xrd1+YTCr51?=
 =?us-ascii?Q?QiH4y0s51m9GqN5Jp/5tnpq3bIe02jq0dK3MF7jmL6ClO7zbBD3abdmFypyn?=
 =?us-ascii?Q?+RR6aRLllrsh9JVr+48tvHHaZgEjjUdI2oVQ+qJi08eTTBbqqQojlnGds70E?=
 =?us-ascii?Q?zmYxRy2WB8GrISP9lgE0yzThdoGGDNYPgQCDoCOP9Qh07VAPky2yjnyqHPRw?=
 =?us-ascii?Q?irTI4AGkc9CvX2lnA9etAz16pG45HGchZ9oluFz+ONNwfzQwlDAgtQE0Xjzd?=
 =?us-ascii?Q?MzkfdT3UPQmuxNfiW1i4Yx2szRIa+g/7eCy3Ift5BVr7qsI17E5iex3uHSz9?=
 =?us-ascii?Q?aXPuTZttAn7TIP+KKszErqTAwN0g6G1bR8n7/GCSne6Q+iytnPHQuVcqGE0L?=
 =?us-ascii?Q?2hpfZiFVwpM5WZ8qUuj/hY0I5uQ/7N4fusWbSY26riZ0LLtu5zwybYrHr+pr?=
 =?us-ascii?Q?GMCkeAjO4ILPsWTUh/fU8Gn3T6cJk6A6FQht7+K1PG81ffSIj0e+c4Bl0JyJ?=
 =?us-ascii?Q?FJWu3cmpaGhCYF2t8/n2HRsTjRyM2k5ohYUW+YGYDEhNC5sS/oV2fozFhNpg?=
 =?us-ascii?Q?LUeaVQ84FzZSuaHuuxjesLhzLUWRAPdNAusjc0O0rRRQh25W9B4kyUJsc9xf?=
 =?us-ascii?Q?U6mvx/9Fv79puyQmpXjJszz02v5xRLiSLKWX/gIf5iaqqIJNPuurz9yJH17x?=
 =?us-ascii?Q?Gyi6/f1xFky98IBSkEXXXNFOug8kfvdo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MqASivuY6aqhZs+y/iZ7IeJgnVwq1BPr7V875Q6AXIkZPvJ//xjK26q2BYka?=
 =?us-ascii?Q?J6xKcpvyRnM+CrOotxW14i0BS577TlDzYeHMRuDXnq+21ryGi73/vZbUryoF?=
 =?us-ascii?Q?Ibm2QhKQksvOm8f3/PHMy8bxuASo+ur/iEwsUC7I9Z35KRZ3EnZyW5tpMA2f?=
 =?us-ascii?Q?KdeOrtTDYziXKrHZqLSsCtT1aMxsJB0CGrGhP8KmsAmYycd6ZmcAFWFsUSQr?=
 =?us-ascii?Q?QeFY+oDVgluiNB7ApFN8mX9th2DHqEIIdYTLjHlBGiFMqelf4RvWM419Sy7P?=
 =?us-ascii?Q?c6AdkdXbvTp5GVagyiqxSJwP2DHkgSF3UOSVlZpu0ndpElu20PRGHHWoPywl?=
 =?us-ascii?Q?zI9KjpDxEMe83yhlViAqb+X+SwWpoml5g7ZbIWP/8qP3TJtPNjZ/HRFJPR7H?=
 =?us-ascii?Q?DK61E31Kp6tb9/MBobo0hGhKzNYuoGzZo3Dq5ApZV1dy0P7pIJQcITZNaMog?=
 =?us-ascii?Q?0V0w3SVtZWWSIJYwdhK0oxdOP4+4FNpZsAHmypfzhLubjkVKjJCQjMEAjPdg?=
 =?us-ascii?Q?WrKofQI3tRG8d44BdGVRfL6bMFl3s4Ce/ZmQ1xSbVaJQlFw8ihCkGQCMl4Rf?=
 =?us-ascii?Q?Zpub8pairc0y/VO2UpULNKodalWSgBhFA5BMWmLLmWjZE62osRgUeObopdRF?=
 =?us-ascii?Q?bBFNp/ux9voXMKuyHyp2ir0dcTDitZ3dhzRM445m0nz2gfY5SGlbgjGbQOB/?=
 =?us-ascii?Q?glqB6awPG4GfDUMp9hgEOBIhUsWSl1k1u+TpkGq9YtVxiURngBDGMmlO1eVU?=
 =?us-ascii?Q?HuJEG76GCcckM0GyjtKmRuQdV6MqhqhqeFZj893FixBMSeIRsg+m/Bmj4hEx?=
 =?us-ascii?Q?jEspVN1Y9XJy1rLux3Koni7ZIUln3/HS6ACbwML9k6uaeegEpZl68Oc1o9XA?=
 =?us-ascii?Q?wnsCv1QegTxnPsMf31tFD5vEMJ71ohi5DNiNpcM4upjbfysE1w08XAOFf6nc?=
 =?us-ascii?Q?VKTREkiI/ydGR36UJkfXTsi09fUDQXuCDTO6TgzikniUoLe0dGS9/zQ1ocwr?=
 =?us-ascii?Q?fTIIcR+7pvtZgSYcW0gPSsXWFEJJLvxIM8H5FBTuX22v0csUmXFhmDqmwYzT?=
 =?us-ascii?Q?qIBzk4WyaPc0BnJ/ITbQs0VYY95R/yDiF7RS9DtvaaxvMWnT7KD7o/OIZQ5C?=
 =?us-ascii?Q?GA4Jqh30ke9kf6KcXxrnx2vUL/o+redOnoHPkDvzvXX3wiH1PI5SYYOEnJso?=
 =?us-ascii?Q?q94fJJIK/kYk0JGoF2CtAneAj3didnLopy7YOZJgAPGoLmcScsmNlrniA5WB?=
 =?us-ascii?Q?kBZQRxvecumZUNIYjwZR91BLYBbnpzkIAVwszSyMZOE8EUeDbrT1d5qH8foQ?=
 =?us-ascii?Q?dn36pHULTt73+zP5KlmzI05P0RQ1AYNKvN5wExk7/SwBPon4gGKUwmadAssI?=
 =?us-ascii?Q?x9zCFiwJ1SIpF9M2O6KrM9mpL/VypothhnWuzwt7DvsUdKmZ4kqPXIy7J/HO?=
 =?us-ascii?Q?RyMwx3R1O7eHV8urWkIpkk5SgWb1OToziQ70tFPrlr7yHy1oW824yE5Qp3bx?=
 =?us-ascii?Q?/AXodkVS2owS/eI+X8EP974SW0G2wYZa2AbPwmtt0acVs7h0g4v0j8+bjVwW?=
 =?us-ascii?Q?Ktj/xVesUFRFY6zPlHzRmTItGs+2FVfGVpMbEVJ2bcjHdTqggbZ8c52sJkvi?=
 =?us-ascii?Q?bF4scpuHcYDuwFh93ccLqfa9aGQcmKe0znz13eotGm2ct1Vke81aGP9oi1WM?=
 =?us-ascii?Q?2DZx/3SrwFM5w/UT9/gPTG75hRxRA1b1GzbK4WvcVb1kTpBMSO5AFZMqzJyH?=
 =?us-ascii?Q?+aF4nTOtOcHPYlOVYNBiIS/6wZA3Os4=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5hQffY662D+ZOjr/ZdN7v6XVukj37WDP+zEKV0Lr2lWC0Rs2tLaaA1ijzm3XrDserwOjpbEv4EWr7LZpPNEY+rIMnObX3w9Y5exq+0wgMi/qMsaCDkZq4zIbmo1xOGl9OtZGZVMgXPMafpGUhPQF1dhawOhPBsmn/NqZ7CkNr7+0US72Cb84hyGriLeTnMcf2Q7ph8lMYNcD13sZ4ZQY9bB+JrBsCVzxGDctDTcF22rBkyoSFleMI16g3QuegDX/yc2xLYSbKqvSWdLmd1vfV9jXeqbnGaDZQbpy4XJJtjf2fyl2LMxtjUFCZNYiI1dzjf6My7VfcGcNElFayo1HyEvuacCiPOJzEFL0g9jbBns255wfzRIvQJLJRrlLnQMeC7stZUXQ3OkGG/wCzEIajT72dBTW342wM6TocMsjomLLA8Bk8NNCebkIfFhGC7H5OZTp9Om38kbLrEVszvMA02CnBBJxiUfRSlBmap3GfjYhekZQXHrdW/QyvsW45nID3SenVO636meuyXPkqJnv7ZoB1fJi6JLcSH38C/3SzO3yj6rHf7XAibkdI5xqbIyZ7VP16WuW80nRjVXGKJDUYCpuS7m6DXlIEkHitojuhTo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 783d403b-6b1e-46f3-a773-08de412e5029
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2025 07:47:10.4658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v7qIEPQ0i4mR2KnzCZoRZvaTFI2CdV9zaR+VP2QKbBH6wuVrM81xMKYKq9uCamQDYpB5giMdG32OmABRyxJNYik6xGkWCMfx4Ml6c74NZiI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB6436
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-21_05,2025-12-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 spamscore=0 malwarescore=0 mlxscore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2512220069
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIyMDA2OSBTYWx0ZWRfX1e2bfUuWTqsj
 topCVSUDoIhWvTvucPH8j7iAacQUBRu3XaLZzXShwVn0vdMAnUo0Yxwzrqbg/xrdfK7QgtnR0Mq
 1I9SL6xkplppaXv4wXV/+8Lpqdz/wjTQ/kDKPdraRXgXAnGViokHrwPZCR/iQmFmNJjsKPjavcb
 s98Am+aj71jZVfGILo/iYVkGwAuz21x5HaVlhGJJ0VWmg174VWCHGmCZLwUbXmrcwT9WvE4YTZt
 wJap03LaLco+ZetayvXms92PJSpY4jvWHFLSVmhHDUW6XbirpDjjpVEClBtelSpXue8v36965sG
 yVA80SXpRVPasQUHFeIC3NFu+NFK8BDFOlQpwaSje8pfVVwiva00JIXjI9TjW0fg5Z6XElkyUBH
 NTIvZnttz/lkDptHQtJe4m1W47hH/DwjQf6LBtu/w8lB9KSjpJdxWRbwX2b/QPmx0iKo7Zr6EYP
 kFpRhP1l1n7dnevtXK6OWZJRkZwGqBvKzPV2YuJ8=
X-Proofpoint-GUID: FHQMD5kL14oDUSVUGR7L_cUcW-XBMt16
X-Proofpoint-ORIG-GUID: FHQMD5kL14oDUSVUGR7L_cUcW-XBMt16
X-Authority-Analysis: v=2.4 cv=DMeCIiNb c=1 sm=1 tr=0 ts=6948f782 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=wP3pNCr1ah4A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8
 a=7CQSdrXTAAAA:8 a=JfrnYn6hAAAA:8 a=uS4Eufe4lZEImDOq6lkA:9
 a=a-qgeE7W1pNrGK8U0ZQC:22 a=1CNFftbPRP8L7MoqJWF3:22 cc=ntf awl=host:12109


Ankur Arora <ankur.a.arora@oracle.com> writes:

> Add smp_cond_load_relaxed_timeout(), which extends
> smp_cond_load_relaxed() to allow waiting for a duration.
>
> We loop around waiting for the condition variable to change while
> peridically doing a time-check. The loop uses cpu_poll_relax()
> to slow down the busy-waiting, which, unless overridden by the
> architecture code, amounts to a cpu_relax().
>
> Note that there are two ways for the time-check to fail: once we have
> timed out or, if the time_expr_ns returns an invalid value (negative
> or zero).
>
> The number of times we spin before doing the time-check is specified
> by SMP_TIMEOUT_POLL_COUNT (chosen to be 200 by default) which,
> assuming each cpu_poll_relax() iteration takes ~20-30 cycles (measured
> on a variety of x86 platforms), for a total of ~4000-6000 cycles.
>
> That is also the outer limit of the overshoot when working with the
> parameters above. This might be higher or lesser depending on the
> implementation of cpu_poll_relax() across architectures.
>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Will Deacon <will@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: linux-arch@vger.kernel.org
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> ---
>
> Notes:
>
>    - the interface now breaks the time_check_expr into two parts:
>      time_expr_ns (evaluates to current time) and remaining_ns. The main
>      reason for doing this was to support WFET and similar primitives
>      which can do timed waiting.
>
>    - cpu_poll_relax() now takes an additional paramater to handle that.
>
>    - time_expr_ns can now return failure which needs a little more change
>      in organization. This was needed because rqspinlock check_timeout()
>      logic mapped naturally to the unified check in time_check_expr.
>      Breaking up the time_check_expr, however needed check_timeout() to
>      separate a clock interface (which could fail on deadlock or its
>      internal timeout check) and the timeout duration.
>
>    - given the changes in logic I've removed Catalin and Haris' R-by and
>      Tested-by.
>
>  include/asm-generic/barrier.h | 58 +++++++++++++++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
>
> diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
> index d4f581c1e21d..e25592f9fcbf 100644
> --- a/include/asm-generic/barrier.h
> +++ b/include/asm-generic/barrier.h
> @@ -273,6 +273,64 @@ do {									\
>  })
>  #endif
>
> +/*
> + * Number of times we iterate in the loop before doing the time check.
> + */
> +#ifndef SMP_TIMEOUT_POLL_COUNT
> +#define SMP_TIMEOUT_POLL_COUNT		200
> +#endif
> +
> +#ifndef cpu_poll_relax
> +#define cpu_poll_relax(ptr, val, timeout_ns)	cpu_relax()
> +#endif
> +
> +/**
> + * smp_cond_load_relaxed_timeout() - (Spin) wait for cond with no ordering
> + * guarantees until a timeout expires.
> + * @ptr: pointer to the variable to wait on
> + * @cond: boolean expression to wait for
> + * @time_expr_ns: expression that evaluates to monotonic time (in ns) or,
> + *  on failure, returns a negative value.
> + * @timeout_ns: timeout value in ns
> + * (Both of the above are assumed to be compatible with s64.)
> + *
> + * Equivalent to using READ_ONCE() on the condition variable.
> + */
> +#ifndef smp_cond_load_relaxed_timeout
> +#define smp_cond_load_relaxed_timeout(ptr, cond_expr,			\
> +				      time_expr_ns, timeout_ns)		\
> +({									\
> +	__label__ __out, __done;					\
> +	typeof(ptr) __PTR = (ptr);					\
> +	__unqual_scalar_typeof(*ptr) VAL;				\
> +	u32 __n = 0, __spin = SMP_TIMEOUT_POLL_COUNT;			\
> +	s64 __time_now = (s64)(time_expr_ns);				\
> +	s64 __timeout = (s64)timeout_ns;				\
> +	s64 __time_end = __time_now + __timeout;			\
> +									\
> +	if (__time_now <= 0)						\
> +		goto __out;						\
> +									\
> +	for (;;) {							\
> +		VAL = READ_ONCE(*__PTR);				\
> +		if (cond_expr)						\
> +			goto __done;					\
> +		cpu_poll_relax(__PTR, VAL, __timeout);			\
> +		if (++__n < __spin)					\
> +			continue;					\
> +		__time_now = (s64)(time_expr_ns);			\
> +		__timeout = __time_end - __time_now;			\
> +		if (__time_now <= 0 || __timeout <= 0)			\
> +			goto __out;					\
> +		__n = 0;						\
> +	}								\
> +__out:									\
> +	VAL = READ_ONCE(*__PTR);					\
> +__done:								\
> +	(typeof(*ptr))VAL;						\
> +})
> +#endif
> +
>  /*
>   * pmem_wmb() ensures that all stores for which the modification
>   * are written to persistent storage by preceding instructions have

Alexei Starovoitov pointed out in his review comment on patch-10 that
evaluating time_expr_ns on entry means that this is unusable in the
fastpath of something like lock acquisition (as rqspinlock does).

Something like the following should work better (it also gets rid of the
gotos.)  The only negative is that in the slowpath this would have a
larger overshoot but I think that's a reasonable tradeoff.

I'll be sending out the next version with this changed but just wanted to
gauge any preliminary opinions on this.

Thanks
Ankur

---

diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
index d4f581c1e21d..278eb51cf354 100644
--- a/include/asm-generic/barrier.h
+++ b/include/asm-generic/barrier.h
@@ -273,6 +273,73 @@ do {									\
 })
 #endif

+/*
+ * Number of times we iterate in the loop before doing the time check.
+ */
+#ifndef SMP_TIMEOUT_POLL_COUNT
+#define SMP_TIMEOUT_POLL_COUNT		200
+#endif
+
+#ifndef cpu_poll_relax
+#define cpu_poll_relax(ptr, val, timeout_ns)	cpu_relax()
+#endif
+
+/**
+ * smp_cond_load_relaxed_timeout() - (Spin) wait for cond with no ordering
+ * guarantees until a timeout expires.
+ * @ptr: pointer to the variable to wait on
+ * @cond: boolean expression to wait for
+ * @time_expr_ns: expression that evaluates to monotonic time (in ns) or,
+ *  on failure, returns a negative value.
+ * @timeout_ns: timeout value in ns
+ * (Both of the above are assumed to be compatible with s64.)
+ *
+ * Equivalent to using READ_ONCE() on the condition variable.
+ *
+ * Note on timeout overshoot: in the fastpath, we want to keep this as close
+ * to performance as smp_cond_load_relaxed(). To do that we want to defer
+ * the evaluation of the potentially expensive @time_expr_ns to the
+ * earliest time that is needed.
+ *
+ * This means that there will always be some hardware dependent duration
+ * that has already passed inside cpu_poll_relax() at the time of first
+ * evaluation. In addition, cpu_poll_relax() is not guaranteed to return
+ * at timeout boundary.
+ *
+ * In sum, expect timeout overshoot when we return due to expiration of
+ * the timeout.
+ */
+#ifndef smp_cond_load_relaxed_timeout
+#define smp_cond_load_relaxed_timeout(ptr, cond_expr,			\
+				      time_expr_ns, timeout_ns)		\
+({									\
+	typeof(ptr) __PTR = (ptr);					\
+	__unqual_scalar_typeof(*ptr) VAL;				\
+	u32 __n = 0, __spin = SMP_TIMEOUT_POLL_COUNT;			\
+	s64 __timeout = (s64)timeout_ns;				\
+	s64 __time_now, __time_end = 0;					\
+									\
+	for (;;) {							\
+		VAL = READ_ONCE(*__PTR);				\
+		if (cond_expr) 						\
+			break;						\
+		cpu_poll_relax(__PTR, VAL, __timeout);			\
+		if (++__n < __spin)					\
+			continue;					\
+		__time_now = (s64)(time_expr_ns);			\
+		if (unlikely(__time_end == 0))				\
+			__time_end = __time_now + __timeout;		\
+		__timeout = __time_end - __time_now;			\
+		if (__time_now <= 0 || __timeout <= 0) {		\
+			VAL = READ_ONCE(*__PTR);			\
+			break;						\
+		}							\
+		__n = 0;						\
+	}								\
+	(typeof(*ptr))VAL;						\
+})
+#endif
+
 /*
  * pmem_wmb() ensures that all stores for which the modification
  * are written to persistent storage by preceding instructions have

