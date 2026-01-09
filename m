Return-Path: <linux-arch+bounces-15720-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C420BD08163
	for <lists+linux-arch@lfdr.de>; Fri, 09 Jan 2026 10:07:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C2DA300E3ED
	for <lists+linux-arch@lfdr.de>; Fri,  9 Jan 2026 09:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119E7358D1F;
	Fri,  9 Jan 2026 09:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oqVzSFgn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xXNkoW0w"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD64358D17;
	Fri,  9 Jan 2026 09:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767949622; cv=fail; b=h3VQ9zFtWfGxhfFyClABtzwDRQsBavXSO8Dz1AQXonFLDLCHtOWnoofRKvsIh65fOzzZIqBLqh3DJhO86H3GdGdcsTdJY71Xy8C+5oFJ78xbk1v24gZv12ImXcNBgd2xSbNxbRXLhMdyRxbHR/mJ8sz2yILCUFXK/mfNXLP7gho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767949622; c=relaxed/simple;
	bh=2fjjAfZagefNp6gmfctQRbm3TDqqstZIiVySkMaZCio=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=KcddOnTyRY9cPK8/j7I6OPkpfDZr1/e0IsYecG29mFFIcZjr3nhM0Qi/uORKhnM2wFytc30chlu/+JZaE5KfYD0Ugncw4W8ywcrok8AFGapFsiSB0X1CsU1m1FnXGIMM2Pz8MPSbYzYcpuxQrYzZrUW4XIlCujjHkYgE4UTgnCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oqVzSFgn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xXNkoW0w; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6097bdCF3070430;
	Fri, 9 Jan 2026 09:06:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=mOtlHWLpbnQmO9MWGC
	L8u7MmmdbMucfSoTmUlmlc89k=; b=oqVzSFgnszBP0bLFHDVwWzkQIF2+Q6y7uf
	nykcIvnOcygP7fG3PHPQeafA8GI8kp7IzScbWKNihmPNEQ10JiKUd1d5JHP/eYfL
	5Hwf8+HZRd98CXJEclolPmTTFR2IpvU/msa7JuvEhxvQpZ0aeLRSRcmJGt/vZ/h3
	tFX5vuDJwzWkgEjMYIbYTNOVIbFpBfG9D0eHVjwwmeAVlQQ5WrdXyoGNhZkTARWa
	acejIdF4fTdvt4hVX7FZYlwEMFj47ZmmjlOhCu3So0dJbW7Y1n1GgWPaDcLztAY5
	VfTn0gb6eHSUvX+arsfZ1nEGnNBofXmU3DIPXCI7nSxySCp4wzNQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bjwecg30b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Jan 2026 09:06:37 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 6098ME2U026510;
	Fri, 9 Jan 2026 09:06:36 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012001.outbound.protection.outlook.com [40.107.200.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4besjpdtdu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Jan 2026 09:06:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yrgyt3mg8qFLD8QeoJQWNxz4ngYUofpAfAPJM6CMNjM1jdWXeGfBkJ80DfciYjHt8F8gu5GgKEj+wCFshMRPf3+v0cQadF+NMJ2RQFTOjhTND250glUONeSyQv2Tu6OCPniwgY83n0ac3r54mjJcUszrm42DVNaslFI+85wXeBXtiqDdXAQwi2gOViQK/cDRW24dzNGo9HAObIVtvTFZWGs3xwpPQGVgGlRi1HpPyGGxex3It6NaM08nAg+q/Uag0bXX9g+GJpdOcUDYa7O+HxHH6e+ggM1z3UPD3+dl7vk8zBB3Wt7AB55RhJetOFaH671pXpVvJUV0/3PjhkB6sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mOtlHWLpbnQmO9MWGCL8u7MmmdbMucfSoTmUlmlc89k=;
 b=GzpgbeDbvXT9gNCQdX9iUpjXvNnnWRMw0kUPfLzmHgOKxWaP2kDQ/CGoDK/fOY9qEP248zWKBGbJ37hznmobl5SUXDvNhKzbRnwftWUTar1iDlGeoMN06w1uKOqvqLG3Ucx1iwuliZrZ3Or2+pjG9mZVGjl1WMm7D03UZX3jT/CmDnS4R7EUZM4xGSsuX/jzZyf7BEj6R3h9TVnxWAD4Z76NyUC4B67Q/uyo2Tg3uk6AXj0df1Amr6bhkrqeBxVDdrd737P12MEVkHWeZQDQ+nD0Y8i1bUKPeGNBM6SUA085hrQiA2Pd7OGvZ355PSnMYxiNtG89tOkWFGa+T43Hdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mOtlHWLpbnQmO9MWGCL8u7MmmdbMucfSoTmUlmlc89k=;
 b=xXNkoW0wHbcu75fb7RVjUaZKOnYuhLnf2iocrtj6/cwddnUqDagHDkeMOeyce6o4DC1Ypkfs8JHmYNHoYvXHnb/LfrukV3YY+GZox9PwUXqa1Gyrr/pDcIbkex6AfQ5nujBDe+y1iM8vEWp7SOL5rh/JwmT/EW0mtrxiQAmwIw4=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by BL3PR10MB6116.namprd10.prod.outlook.com (2603:10b6:208:3bb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Fri, 9 Jan
 2026 09:06:33 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9499.003; Fri, 9 Jan 2026
 09:06:33 +0000
References: <20251215044919.460086-1-ankur.a.arora@oracle.com>
 <20251215044919.460086-3-ankur.a.arora@oracle.com>
 <aWAjU_QS7kwcyCse@willie-the-truck>
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
Subject: Re: [PATCH v8 02/12] arm64: barrier: Support
 smp_cond_load_relaxed_timeout()
In-reply-to: <aWAjU_QS7kwcyCse@willie-the-truck>
Date: Fri, 09 Jan 2026 01:06:32 -0800
Message-ID: <87zf6nnoiv.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0290.namprd03.prod.outlook.com
 (2603:10b6:303:b5::25) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|BL3PR10MB6116:EE_
X-MS-Office365-Filtering-Correlation-Id: f63b24ad-f587-491b-11a9-08de4f5e62ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?u36CU6C/GbZK9bcXtPe8P+8+IL6F/ZxQlHZSV3PwvqpLSS3Zt/tGQ+xAXbrc?=
 =?us-ascii?Q?ju/tHCpQ/JrSupKmPgmDrfkPWQXfPaeum8N/49xXVnvnsFZ4nRWagz17y5mD?=
 =?us-ascii?Q?5oEvxAv7ewJh/vKFvKU8CrX8jzXqYRPeINHNW46vCFV/qrAGxywUbOdUKkXk?=
 =?us-ascii?Q?Qj4kQMSZsINbxdjRTiZlhdPSNtMegymfomg0sx7TpLnLS/dqrXcghJoq2cb9?=
 =?us-ascii?Q?dn7IVR1iSioaMFSB7yMr4fuJ0Kb2tbVbpjv85f/a2bMDWwKzoN/O7dwrsTAv?=
 =?us-ascii?Q?SAY+2beKDGDx2UCiZGavwWpljkafd6ozqhjh/3AQvRYheyflLdIoaUz/vk5K?=
 =?us-ascii?Q?04bvzEbySHQkxIoA/PM/FqWZuG35HK0+34N0u9srmoMKk9SZIZe22A879jyP?=
 =?us-ascii?Q?l8Tg4J0d4aAZ4vwyjGwWfc4gmj3gh+6+eVtY3wgCz6lO3qXS0vPewIph3PLz?=
 =?us-ascii?Q?LtNj0fLRgaesltVeycQNk7Sm6o4F00KB/tuiPTEWKBtjXvYZxlC1yMZ5VBNL?=
 =?us-ascii?Q?Qa/DAdm2pbYdTDN7Q2VKdJ8xF2DRr3adES9RLqn38QpF4EbKPei1IHs24Maj?=
 =?us-ascii?Q?ivYzPCjwoqsTKFSE+KARyIJ9WSNa1pYohhnpxyX4CHTNGAHl46ewlocoTYGI?=
 =?us-ascii?Q?zH9eyrPXB+l9UC6dEq7kz3trbUzFphpERfS0Ulweq6NRJ6h7TtnlMVAelMDo?=
 =?us-ascii?Q?g9+Kp8VESZ8E2lw129KCWWRI6G3grNWU4K0ZQ1PRcBWT7zDVaeqUsMM+dIMN?=
 =?us-ascii?Q?00iwMwYu+jhFQNHkQdTmgmBvOCq9HPp7tCbnVuRmnQXgOwLeWlIc9lDS5r+5?=
 =?us-ascii?Q?JAoVIWPWFZIb/WTxznCwbH12DCLPKGeU601//xAmAlABWclyKf0Hs2Ll7pwd?=
 =?us-ascii?Q?JJZjMNxaoeSXIaTIQLbKQv09setES2+u2CMvw3cD8h2Cn0BjP7vV9tkZUmRl?=
 =?us-ascii?Q?auiFnv4ENFGhDsmNDxpYTfqYPfNUqsMpMA/N/M9cXKQMm5Tw5+K4320wO5+d?=
 =?us-ascii?Q?wjiQfoI6Qb1ue85C6958ZrrGmn/hHnUla+Infx/yCDLHaPv1gER8rb+yl7JK?=
 =?us-ascii?Q?a//66QveiNLVZMYh1aXX33xofqJZ3yQl9IWTgzEZy2G6VIwMAGi4c6xqhIxf?=
 =?us-ascii?Q?9QECxDq1b72ki4c2gRUnxvSLU+D9Nkoe8Yn4whXKLo0dXA8eTZhHrFhiAdIb?=
 =?us-ascii?Q?6ql0ZYlvBQm9OpsSapLtquD/mKBzp+sG2cQihc6PNMob71EuBKf5uqHdU9Mg?=
 =?us-ascii?Q?yIEo42NvE7futcbw43FvT0hCOrsYPPw0tDeta5ZjSX2MT4RGu29UaQctRrwF?=
 =?us-ascii?Q?/1YYJSyXQG9kD7Z5/zynXWEicSxT+4l0WTL6dXfxJFNcFqaOylMcbbTnv6Gm?=
 =?us-ascii?Q?WeBMJdLVYjkNSrioAqyy9nkqFOodStPyye+/Nooqu889deG3FZiD1P9FkeX1?=
 =?us-ascii?Q?bJfwX891GV3Ua5VR3wAsJNUXH7YfrhEq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SiJHQSbyvwBIzS1zqNZ6mOutywBAAquy4jgly3FOJ6EnQEDMml/jyKmwoH0d?=
 =?us-ascii?Q?Mgh8VXUs7P9MYv13P8R7ofRU0uja4b7rpLzrpEEOjImFIV2KMpapEUH/A875?=
 =?us-ascii?Q?nWBFLutJLo2FTZJ1zu0idzQBsiWc7HYOwjtTlSn23Cf+DuZix8N7w5Zxo6Ow?=
 =?us-ascii?Q?tiR9xAOKxFWSEm4TaiDLlhgq9wwTPMYvTGJYkBKpIZKGbZLeKL4oBMdGzUGQ?=
 =?us-ascii?Q?QRMAk7qolfVfhCPI/0CBsycmkLkRIrAZxZIi0w2YpwcpTchfBpLPFk6oHoMv?=
 =?us-ascii?Q?wLYr1u2mVkrqhvvBSPgNVw1+QDuNgE30+WF17gfIGeBpQob63NMAZxXWUamB?=
 =?us-ascii?Q?jl9fWwBoJXl7PEBJ5iSCYQ9O/knz3lHEVym352NJNsSpiaAbZRxwbKwIUfLb?=
 =?us-ascii?Q?UYFiFXwmKImQs1wq5h6polbPOjCbys+IinC0CCBabg1qwY9b+F3UI4HufiOi?=
 =?us-ascii?Q?QhCXq+FaZnTNp1Eyg8SBONzBBeCf/Va6P4ea7DNgG7jsZuZdrFsaoTflBxj7?=
 =?us-ascii?Q?HPg6QJRCGjl64mvgiIcHm2qkbFSzo0fCGTsoAqdbtoZB86KueQMDowVIWwuP?=
 =?us-ascii?Q?K7w78KQYnbinygaHPkOmEm7aNAQ5olvhpaJ2n8CTOwvXd921wSksSNLSReLs?=
 =?us-ascii?Q?ytE3iahjl0w0r1yn6EolmQ320TjVz5YEQ1vpMnmAiCvLwXbEC5Vhixgt+5km?=
 =?us-ascii?Q?CtPyaF3fQJJMQrh5ICMYCIO4kKpw4QAmpGT7zXflV3kHKqdEulnrsIibOWuz?=
 =?us-ascii?Q?LEMXGdqDsiZ0i+KtIn7SSRJaMEO+b1oThEmQDpmpOFe5FFhAgAbCwD6QvqxD?=
 =?us-ascii?Q?8MXMIo6S4sdTswE5d9v8yBUIvC9ZroKs3ThZXicHNEzcSs1ib2hXMVlgHuwr?=
 =?us-ascii?Q?D93OW1u0U951mJn2zj2zM6PePto0k2b4cdar8LUZb6Zq/D5LU/naYb4cWTkM?=
 =?us-ascii?Q?jwQYYJ+mC+iUF5gKCSjCyPTElF3kFAp5iUQVVbFvZeDpwODycVUpqpyP8Kfw?=
 =?us-ascii?Q?G2H4HBMnGYgdhskK+wHaTD4I2sNMiHfFNkXWH1a+HeAWFfhR22xi2gvsHxL3?=
 =?us-ascii?Q?PiRgFT4kFG2fFyQ7LULsi8p6UqGfxK4I2PrIHJEuLUQX3O4Zu0GvW/jqOjBJ?=
 =?us-ascii?Q?QN5Sbds569YpX7p6X2ZnuQ+JVN4IEGsUYQPF6gnJlVdGI4qrM42oCXIZCroh?=
 =?us-ascii?Q?OIrOGIxBjqUfW4N3T4PsaImEq07zhxRGCBoZuoLkun6QdJM2Htqnf9JYyMYA?=
 =?us-ascii?Q?kU8w2LeYNC7z9Nz3Ru+CaKgbihOibh9D+acZIMvC1xUcd3vzESVHEh8Olrmn?=
 =?us-ascii?Q?9nvhjQtXAIpp3LCYFS75MlqXxobNrQHlbrH7HzBd+pjDj+SLuWtjshPjsqS4?=
 =?us-ascii?Q?BgjNbaTXT+bShcEWJbDady8U0SxDpnvyN5yg3xZvqB+qTtdDoP3wfsL99gk1?=
 =?us-ascii?Q?MD/lnSXak2vBYvQUuH8QAXhnDhJWmbrZWiByDcuHJSJfwkuvNjvMlC+RsU4l?=
 =?us-ascii?Q?bcc/tJVEwmJFfinWT7lsbnfa3Wj61K/rnR9RvVjaulY/Kaq9+k5ufWv69yD7?=
 =?us-ascii?Q?sertuFXahHJR8klxKuP+8HA8e2O1luGOdenaxlgjCn36ExExAeW+kYzGMaBv?=
 =?us-ascii?Q?iI1ZIzEcI2yX8oAe0pl28RDvxtaEAmaHzLZR1141X2wW1u5SqQNXkt6T9vx9?=
 =?us-ascii?Q?gFIwhws37Luv1QFD2R9TiR/KSFQfrmYCL6KXWsZ2WVH/vyGJ7sUYdNcoMcoc?=
 =?us-ascii?Q?b1XdDCB1WK8F0DhGph59n/55mQXo3gg=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	oZtQzQG6x9tDPVHrAu5uRnoEZgFBy7m/vIMUckWzn6fLfoit3NS6T/DaB8UT1Dfqchyaek/I+v7S3uBgxAmZwnX/ro9zUxLFZtwW37ZzvONu1TZl7Dq2J6dxv41M1BouZFut/AkfhCDrexo741Bm7Y+g4LUXCTG08ntGIyiw68hDF2a+/P+VGBtMRL5uWvQ6kNMtbYbjNkqjBSpoASaIFvKwtVuz3OumCBCEHTsSLAAVloYl5QyZAZekrJyqa2sts0qPdM/QQ0exay+MBL7brtBLloaoGKBQFIdW/EFaqFT6RRVi0qswiJOWqhaRr/WyXzsZI4TXjz0nwJHfgFSg41zTKuH3Mhzpw6FRFEX/EyxQM/qf3q6mAh2hbIvEAC3Rz4t1qCX0UmUdlQ67+XIlN8UniBTBke3WcEgxToNIZNCq+I8xd3394qS7R66W/YqEvOF77B8LZcmQpuJaqtYcIsiOdlwRF7J04U3AlZRhIXH8Dh1gPXaC9+qxiT6C7CWpinj2rKCingeev5bWnXZJnVeytCsRNr6nSUzkWxFMk8k8Hu+dFDo+YBKoyDdzXxk1RicQhSpAb3eLB7vP1ccN6Cqr399vZ3aPGapB/zZgwnQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f63b24ad-f587-491b-11a9-08de4f5e62ae
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 09:06:33.7556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W/Tb/jSDgaSyoDMHumoginkcWagXBhLF0SlnHt8mE14/5M2LBzETou8xap4ZoPis19L9vmzSDQwzcspjfFk3abY/PwELd96pciEU4N1dOa0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6116
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_02,2026-01-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 spamscore=0 suspectscore=0 mlxscore=0 mlxlogscore=796 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2601090064
X-Proofpoint-ORIG-GUID: TFZNcWEcCyKQ2VjMbny2gsWMMWMGK6cK
X-Authority-Analysis: v=2.4 cv=Vrsuwu2n c=1 sm=1 tr=0 ts=6960c51d b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8
 a=JfrnYn6hAAAA:8 a=yPCof4ZbAAAA:8 a=vCsAaxQ3v4rsUVRk0TYA:9
 a=a-qgeE7W1pNrGK8U0ZQC:22 a=1CNFftbPRP8L7MoqJWF3:22 cc=ntf awl=host:12110
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDA2NCBTYWx0ZWRfX6dqk2PQeO+Em
 7Nc/NtsSASBC35BWbKTwWAOO3Gc+1cVHbdp+2cf3Zx8ne7CYu/imIvRlhl/rjt3djIqQoHiEf86
 H18Yqo2ueiZkt2vCV+bgdXkPFAvBgAuOr4p66NBGsjSvo48R/QO2rCOYYJfuzbRGHQCqwOGMhQD
 CAJ9JvzFbCbn8C7CWbRY/9ngdMS87lBHRQQBB8bmvtcPfrU6fBIZ4DeSem3RDCx6mT30uaNJU86
 z/J0i4pQZ9AjZtnDQ8iEP8vIdzOML0sHi1tmSZEO7VpDKr+aQLYapPTEupBS3D5zkXlVsBomSFC
 ZkZ7q7AwOU1CB5uXnrjaCbVa/kt4M3eTj0wpKJ7xFt7SBfoy4Tjn+1d7/cbAgKMTPMyLQTa2mJL
 TWtWyRYqoZvC9G2pN+gQDElA3shevZDskByO/MsOIhreB/iuyL1JfYgoxACNZ/b/jD2nA9FB/n1
 yxcqR3Xb4WlnWVNmEiUl/lUkfbzWMh+BJgBe6dEE=
X-Proofpoint-GUID: TFZNcWEcCyKQ2VjMbny2gsWMMWMGK6cK


Will Deacon <will@kernel.org> writes:

> On Sun, Dec 14, 2025 at 08:49:09PM -0800, Ankur Arora wrote:
>> Support waiting in smp_cond_load_relaxed_timeout() via
>> __cmpwait_relaxed(). To ensure that we wake from waiting in
>> WFE periodically and don't block forever if there are no stores
>> to ptr, this path is only used when the event-stream is enabled.
>>
>> Note that when using __cmpwait_relaxed() we ignore the timeout
>> value, allowing an overshoot by upto the event-stream period.
>> And, in the unlikely event that the event-stream is unavailable,
>> fallback to spin-waiting.
>>
>> Also set SMP_TIMEOUT_POLL_COUNT to 1 so we do the time-check in
>> each iteration of smp_cond_load_relaxed_timeout().
>>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Suggested-by: Will Deacon <will@kernel.org>
>> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
>> ---
>>
>> Notes:
>>    - cpu_poll_relax() now takes an additional parameter.
>>
>>    - added a comment detailing why we define SMP_TIMEOUT_POLL_COUNT=1 and
>>      how it ties up with smp_cond_load_relaxed_timeout().
>>
>>    - explicitly include <asm/vdso/processor.h> for cpu_relax().
>>
>>  arch/arm64/include/asm/barrier.h | 21 +++++++++++++++++++++
>>  1 file changed, 21 insertions(+)
>>
>> diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
>> index 9495c4441a46..6190e178db51 100644
>> --- a/arch/arm64/include/asm/barrier.h
>> +++ b/arch/arm64/include/asm/barrier.h
>> @@ -12,6 +12,7 @@
>>  #include <linux/kasan-checks.h>
>>
>>  #include <asm/alternative-macros.h>
>> +#include <asm/vdso/processor.h>
>>
>>  #define __nops(n)	".rept	" #n "\nnop\n.endr\n"
>>  #define nops(n)		asm volatile(__nops(n))
>> @@ -219,6 +220,26 @@ do {									\
>>  	(typeof(*ptr))VAL;						\
>>  })
>>
>> +/* Re-declared here to avoid include dependency. */
>> +extern bool arch_timer_evtstrm_available(void);
>> +
>> +/*
>> + * In the common case, cpu_poll_relax() sits waiting in __cmpwait_relaxed()
>> + * for the ptr value to change.
>> + *
>> + * Since this period is reasonably long, choose SMP_TIMEOUT_POLL_COUNT
>> + * to be 1, so smp_cond_load_{relaxed,acquire}_timeout() does a
>> + * time-check in each iteration.
>> + */
>> +#define SMP_TIMEOUT_POLL_COUNT	1
>> +
>> +#define cpu_poll_relax(ptr, val, timeout_ns) do {			\
>> +	if (arch_timer_evtstrm_available())				\
>> +		__cmpwait_relaxed(ptr, val);				\
>> +	else								\
>> +		cpu_relax();						\
>> +} while (0)
>
> Acked-by: Will Deacon <will@kernel.org>

Thanks!

--
ankur

