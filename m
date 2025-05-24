Return-Path: <linux-arch+bounces-12122-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C40AC2D32
	for <lists+linux-arch@lfdr.de>; Sat, 24 May 2025 05:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28C95A21D36
	for <lists+linux-arch@lfdr.de>; Sat, 24 May 2025 03:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3047B19AD48;
	Sat, 24 May 2025 03:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HuQkw7iM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PqSVAL0d"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D58419995E;
	Sat, 24 May 2025 03:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748056979; cv=fail; b=JpxBHTUUXJIHKgkM3Klps8Y88BpE/Y2brbjARrAJ1dwdYHbHfRizPxRRjOqUwDZOLNoYbwSZU0gV1z4yxCYSEDZRXZO0h2kYAbjLCGOmlzoDqplzVDPxZrHLVjqsiHn/paewm45i+Hj+xJlz4tyghZOQ6qgbRDhQfPfmNRKWayM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748056979; c=relaxed/simple;
	bh=cSh/kmyQ/WrJjmMzQ0zrsorKYCZsSIJHHsfdqHbunF4=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=F37WkaYVLITM2CKEAwJGG7+g1x5bctQlzJtv3wMzsfP1exkBpWp9CXUQVGxINvEwQ1ExN/X3uKKH49n4/aK8j3s3P8A37fdVuzpvkunsoKtY0Ra8ZVzUson3htFM/+Hp98/esk/gaKP8nMpqyxB+PvQ8rSlLuk3+KQjXzIqhNdU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HuQkw7iM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PqSVAL0d; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54O3K7N7009884;
	Sat, 24 May 2025 03:22:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=FYuXjYLIQ0zObQzRlB
	Bh6WOOn6yv9MIc5aQUMviIyEc=; b=HuQkw7iMDT/i+i4CcIq9ueBeSxncdUIqS3
	6nYPXw+BoJPNsgcXLI/WOIL+a7r8vnL+b05qUzUkXE3hJRmVD0cc3DYA0g55uYJx
	3B6zZ3s7O4LzYXyCf9mjdfMr5rHMegdoW7cDvO96o1P6sAXAVrGvofrxAUN/GAf7
	SbL0tHXuSJUNfsKnhLLU9TxVf4VCOrobSKt9CR+HgP84qA0fR+89qrtI8g6Fgt8x
	5g33VeifKrBecW8v6afskVo613ph5JJ/D5H4G9B9a8tkfvthb7CQJI8QKPkmDQ1U
	gZfCFfWy8Jx2HV2sJlvJSVxBWGGhTFNxYFZWK8DI7L/cvkvKb29Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46u4w3816u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 24 May 2025 03:22:18 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54O1Xec3024391;
	Sat, 24 May 2025 03:22:17 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04on2064.outbound.protection.outlook.com [40.107.102.64])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46u4j69xg6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 24 May 2025 03:22:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HzL6NGBWb4KtPXFiUYkD7uabxuzKlVwdntzImEm87vj/+ODwEbdx/DMZjwJHwcZlOFb6+rY/oKx77hEv9EkJ3MU449HNwO//+RnwiF/2q+rC3CKFvT051o8SBTESdAgj+687Z3o3qHGjwbmsPx3gFLDxVIU34IXp3YxJlkf7zOvxSIx53CvOEy3tQIz1v+cDJJDI10XyWv392qay2JYwBjDAsOX0A542mljWRHlv30zbrb4EXnMpbHatmAm1cesnnWylUjM0wfEQQUS+Yw03xVg2IzRahwSPU4TV674zy16fEiAS6N35plXxtlx7fwdOdk+o671wkN5KnvKbCg+8Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FYuXjYLIQ0zObQzRlBBh6WOOn6yv9MIc5aQUMviIyEc=;
 b=nIpl9b8agIonnOmFq4QZunI/cxkgMYuY0h0sNjY2clIqxrRIlKncYiN5JO8/Y+kcBqWqPbH/yItW4V9j5hYR1uJd9dN+14zBq5j6POF/PTOGFggaw1HSlvRE0ETa4paZYOAc0Vbr6QwaJy7K9JyC9DYjz5MprfT/zEl+LADjWhO5VbTvMF2qAwctRq1VBtv/v30qCJtZ/WwVpU5NxqSnWs441vvg+BalotNmH56XyBdlasLqHLxoXHj1KZSoHG7avUVJUaMDE5sdlf8S8rXkoCdDY6jyw2CtIjBRoh146VQdGJPgNTekPV1vIP4S227qBQpfsdjoh15+eOJPQDz/Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FYuXjYLIQ0zObQzRlBBh6WOOn6yv9MIc5aQUMviIyEc=;
 b=PqSVAL0do1gbcm181CJCJIuGIv2Su1c29rNIxwW0V0drC6G+6LfjBC61kLt5eQc1IO93MRHqPwZ/alHvgQOwcBLysfWlSkeHLBOCR7OpbVIfsu9FpgaPBfUOnSeKT9iW6ii77S65clsIa3OSfwHbJQYvdO/gXOByN+bo3vumXzg=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SJ0PR10MB4542.namprd10.prod.outlook.com (2603:10b6:a03:2da::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Sat, 24 May
 2025 03:22:14 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%6]) with mapi id 15.20.8678.028; Sat, 24 May 2025
 03:22:13 +0000
References: <20250502085223.1316925-1-ankur.a.arora@oracle.com>
 <20250502085223.1316925-2-ankur.a.arora@oracle.com>
 <aC4dcZ2veeavM2dR@arm.com>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bpf@vger.kernel.org, arnd@arndb.de, will@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org, mark.rutland@arm.com,
        harisokn@amazon.com, cl@gentwo.org, ast@kernel.org, memxor@gmail.com,
        zhenglifeng1@huawei.com, xueshuai@linux.alibaba.com,
        joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com
Subject: Re: [PATCH v2 1/7] asm-generic: barrier: add
 smp_cond_load_relaxed_timewait()
In-reply-to: <aC4dcZ2veeavM2dR@arm.com>
Date: Fri, 23 May 2025 20:22:12 -0700
Message-ID: <87v7pqzo9n.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW2PR2101CA0002.namprd21.prod.outlook.com
 (2603:10b6:302:1::15) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SJ0PR10MB4542:EE_
X-MS-Office365-Filtering-Correlation-Id: bea64ef7-0994-4223-6289-08dd9a722d40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?njfNSeZ3MG8WflIOme7/g4oj4cgjJq7nqwudh7k64gnlThiPu5a+wUaYoh/C?=
 =?us-ascii?Q?gw5QfBmThlsuEBiCjQgtbIjPHSNeboa9vRXFws8EHXhQ+zeIhVtK/rI6ZGjc?=
 =?us-ascii?Q?p+20Ju5CbG3EAxJrK5mSM4/HHAU6jrCoqUUE0+7wMDbPkX8ugD36m7CdbRbh?=
 =?us-ascii?Q?fgOLJiIBDCPuMMBMXmSJflR5lMDbAqbYhZkShz2R+agh+9Pf2nHBP0YyFijj?=
 =?us-ascii?Q?VtCWItY5YDgpfekcIhvBAjafRUvnDIkhMM01oY7viIs1MDyVgzY/K+QLuxTj?=
 =?us-ascii?Q?tB23WBVdCf1YGLZeIDJ/IRdJRjfL1d1L8xJmVDTy+yT2ZxydYYG39xGSIv1P?=
 =?us-ascii?Q?6JKIPIwbkaz9Hfk7PjtyOYSbo/9kGVQIxqjkjogaDFzbvns0zhqLDSxRKIFB?=
 =?us-ascii?Q?ZNDh+kfu5hqwJPTpJKQw+ZBKuVdc2Ew0ur/QzSsBLTtMkVawU1YwdCkcrb/o?=
 =?us-ascii?Q?6y76VZRaJRZC/pb2pp5xXLlMYYmoogGuIu6M71UBMQRamNKDDTsbXxC0zhbF?=
 =?us-ascii?Q?8GsnDLP8VukByuU5vWSmAsTM14Z1FU6gK00lvVnRcK96hbidtAVPvOPxyaTx?=
 =?us-ascii?Q?XOysd089uN3Mqn9jb7jt5iiwaRmwIj9qP284xrukD+U2gt5O46/C2xE8RZlR?=
 =?us-ascii?Q?awQklMxthBQiUiM7bCi3X751QKQK3toWs1EOAvd5dai8ZHJRpQmmnG9Qe6ag?=
 =?us-ascii?Q?EvqciXADQN65w7WROdzwM6VdmrR/MRqYNLouMUNWhhSXRctSo0XvJxc+o42x?=
 =?us-ascii?Q?b83r4Ffo9uZZXOkaSxNOJl20yycp4iMtt5UWdnx1f3nWvPCsIHPmw2AefFMr?=
 =?us-ascii?Q?H0aukdxNTcYp8KPkMzBaLEbPEUHLTU5/QzwY9Et+WGfbFDqV/pcgydjXhafE?=
 =?us-ascii?Q?QuIwILVij4cl1tzZ8jokzzrBWqeXXo+8XHD2A1qcJuLU01p7HaxBxUU/KBfR?=
 =?us-ascii?Q?9TpUuwi7UfnmfNPAkyGj6a/Vj3HlmSldBdEVzdc5k7dZWOxiEZSP5vBhhkDb?=
 =?us-ascii?Q?emcPjLs/WLz/b3Gn1YUWCanVIRIdepqGYektW5rcWsZOHGc3v9Cg5N5P4czq?=
 =?us-ascii?Q?4+EX/slMEtgUuDYs1/7KOFJsVyUDwF9t7sWXJRUhVkS4B8ooxqFs/dGLkE1a?=
 =?us-ascii?Q?9jcaeon5PhDxTJKcsbcHRogiuFgoj7maCxAqll7+3peghCD4PyRG0DZMsAl0?=
 =?us-ascii?Q?MWFS3e/C/9VtRbj6x5x7/CgUI1BRQoyRE8x8Sa5102vVTPZGTMuxIXR55qAU?=
 =?us-ascii?Q?V2GWJPTBCVFQnjhATEcwFLY6oykwWrO4YWvustyIIjuJz5P8t/ciqoTO+hh8?=
 =?us-ascii?Q?QJqBXjUQtLssO4Ciopk5pAOvButUeDdv9A9+2IKnbRzhEzyfzQriOB+KhYIo?=
 =?us-ascii?Q?E3tf2CWYTei784GPkZk1FATn1dTlLZsvxza2R+DpahSS/Qp9w9eZQevIpdL7?=
 =?us-ascii?Q?uPXrDKI+YBo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EYYOQ2BlbkeWVuCDt+/+0o0T2sWduCXMZ+uoxBJuCc5kIz1fS27kCm4925gy?=
 =?us-ascii?Q?qmBOpWHwYwzrhsTn9A5vao92xZ/58gUZqrzFtGIlrGQmkUc9SiUUOIdI4S1r?=
 =?us-ascii?Q?+pXUfQXnqHBmAe0pukq6DQIn/+n0RYbY8idq0EZtl9Y6vJLke2HUw+2e82gK?=
 =?us-ascii?Q?9xImvTLWilyNNhBUmcD8b+Rn+vVWZX5ulrreucgsLUKIDivQOisgt4IaBxf8?=
 =?us-ascii?Q?Rtnr6s1IfiXUiNWX8RfZE+qSPC38oa94XbHqbjKMvcAjI+YxD6ZSU0UcLqrE?=
 =?us-ascii?Q?7S9aomUidckETNLxorBkuGclXw4+RGxc8+SVw12Mki0KsF7Ks4OQaaxbTQXh?=
 =?us-ascii?Q?3xsDw0ZAhqWWv3TTOpXn7hXtqnOM8Eh9sGbx1JRKCOH88l+oeocs/VOEu69R?=
 =?us-ascii?Q?2xFnG3OOpyQ7RDXm9CGx+pFS1xoENSPABmMU10QszkmSNch5/qqK0qX2ODxr?=
 =?us-ascii?Q?9hDVa0UzOrINEh7jpVPCPXVZ2551lA1eN7pa62yaoGgdPmL9qAsFS6fFiNnx?=
 =?us-ascii?Q?2/CTqDLJOKzKgWdA4b+pZGWz3hxouLBDlFoYTDfPCJjXVpPCNFMHoeqZ7Kzo?=
 =?us-ascii?Q?ZF47jizMOxnkovhEsih1Iivamch0xKKaFESOLmH1sgndj5iMCdxo0pbRLUhS?=
 =?us-ascii?Q?jZ8yB7x3Zwzhya9v7/hynf8TKTXKF6+bDyuYusgsThlzQRmSlt3U/CrVGNqD?=
 =?us-ascii?Q?L/s5fxV6n37xYXYGxyOZ2VYFxAElzZAFPXFPlTOSozEyvZa3U2JHkaRIqbWa?=
 =?us-ascii?Q?kiJlDCWq+sMnJwo4jOcSe5JhE2kJnJLieGoTWTqVPKWnQckj3p3tTrwOA1Mn?=
 =?us-ascii?Q?pwTAqu8vci4n59OPoE2balql+Yi7imRH2V8lU1V6hexTknvwevPqWvye/HZ0?=
 =?us-ascii?Q?+rpzM0kkgCFCH4FaCFpwBf8OpWrfNPJbLaxJc4TgEaiIFNXFq8xA1vNdMBdR?=
 =?us-ascii?Q?ZKN0J8qa4Yy/3UQ5wJfP/UZibEpPhwqVrRBwzjVm/kL3rc7zkWUUJL4uZupJ?=
 =?us-ascii?Q?fIdPDwzuWBXmmj0x0cps/H6XsKpHXB7PNKTnG2gB0HXhMywRA7aYvSYz18gt?=
 =?us-ascii?Q?K9B2z6ZBEW2VWHf9qgymMEy4kB8QH3TjKQp9FxvyxG9cU/gSewsiIo3er8O+?=
 =?us-ascii?Q?tZQTZQEoebTdtVnUkpAkZrMI1Q6GepEacJyROLWbFHNzKT6DbA+Rgn6KHQi8?=
 =?us-ascii?Q?j1LTGNOfrtzPpHMJcUNvzAMPg+bTNVNqVl/bojVRtFncfjk0ca29KAiOjuL4?=
 =?us-ascii?Q?9iUNsTgEtuAZr99QSAOa2FT8rvVImXgZ/+iCCwJM4Fty9yUw1ms1F3Sh3aXu?=
 =?us-ascii?Q?LLJQecqPLFAQLYOrvS+Pu9Rn33jetn6gmOWpV9aa2ytWMZ7pnO9cVEeI2JV5?=
 =?us-ascii?Q?SAF6uHiwxe98+g/p127ZRNS+1OP4zc96Lb1aVVPAC2On24g/K1ZaI9lVSHEw?=
 =?us-ascii?Q?hxGVwhPjIgnkshT+xae4V7XiRfG8bPpK3cxdUZUHtmAp4joMDl31PrKFbmIT?=
 =?us-ascii?Q?BSA24N8FLoLDWLDVGt3T62RU9n9LaGMPoAS2yOIlvbPXndHaEzoTedlYuIxm?=
 =?us-ascii?Q?fWOxbKWedj/553mDY3kh0LeZyzPRgZ2PgYT3Yst8f+23+vRhr+5/Md1TnYEZ?=
 =?us-ascii?Q?lw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lsVOG0KJcHvSwutLP7q6o3ssYWgbodknwfKAPypik2MYc/gNcullN+CXMHyaY8t80I0zrXAHB/1ZXtTe/3+HESJ6nMSW6Ly15xRG5qZ7NRlm4cCgb6hiN5P/TxQrp5BgXk6DJnYJzzlLPjdVpZXMqp/kIvW5aWwE4krMExzzz0AtzdAZP/+sJWUJkNMkifQBTfDkL6EITBKxguDF2CtSWT+P60IiPJdKaPyLDuYLgsv26LfYxg9xRr95eLSn1D6r/zxmqndCZXFB4zuMMOYBVklgPLsRLvSoM+O0Ubpsf1r3TFeAhemUAjtD3NP/5jhUIixFqlg/hk1rC0GhRzpt/I+490XR+55Duwr7EzXqTSxc9fniODS1SbEP9Je0h7BpHTUqlWBHFwaSua2y/A6vwK2rN496zE8HnoOw7QIdz4Iisp2BigeEJCcyYJWbYIdciAgZ5zb/ZW3l6hnWWeRpObzWlPG4CkMEqUmmPAN6/wnmzb4x68JHnB/AMTqv3ZvyrRz1MoJ4IKA+N4Pu6GWhRClUtIcjkPhmFGa09mmwjl60USjQx7FNG/vfln7bxhyp/HtuZ10E6NFZcDJ5lEJDvxiYoBMs6jZ5opss7fC6rS4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bea64ef7-0994-4223-6289-08dd9a722d40
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2025 03:22:13.5145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rflPzW8efK+xMrU0fyYDi4xqeHA41MQAmBkRUN4+FtDTbUDj4wUoDBS9p1hC8Um3Bby26W2GiaBricW3T3Yec0WktM5SHygnFlELWI2R6a8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4542
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-24_02,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 spamscore=0
 suspectscore=0 bulkscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505240030
X-Authority-Analysis: v=2.4 cv=V/990fni c=1 sm=1 tr=0 ts=68313b6a b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=7CQSdrXTAAAA:8 a=zRqbISh11YqQD7CphrQA:9 a=a-qgeE7W1pNrGK8U0ZQC:22 cc=ntf awl=host:13206
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI0MDAzMCBTYWx0ZWRfXzy9OdfhDVEf9 10zSj/euslvnrCHRHkiIyNMtRVcW/9HGiK1JK+HY1hTYLS3irPK+8FMmKlQcMxIegrysq/MAvEA M/1XUSJMQ9zcDkQMOr1+zomQD0R/XpNLEytLRTZU7Ld9gSxMjvwdZFExNqLdtSVJs6tu2Il8xrz
 TFcjgDNtmZWvEBDjviNN1HJvSK+398JgvQkhS50AHMiRdo90m+0lTt8tL4JlSXd0uSBR8tjUl5L Dd/fMnr8CzoCRDUbiOCHNsQKm9hh7UabMyMR4UwZYoJSFrWVrjS1Bp52waJOV2MFL/0q5keuZhZ 7QBX1XyIOVifz+whv268BC12hvDcOrA9lY1jF8ea/6GCkaUHi+An/5niwl8OU+I3VA19KsvKosX
 MrdDypv/l+PHUFMHwza2ephFBi2Rsn9wVSSfwrwsrFS9oT0jl1QTxpgqwmcIIQ3M0jw1toAr
X-Proofpoint-ORIG-GUID: JVkfMBTDxC24EomoZS4kw3Mw20F18JOQ
X-Proofpoint-GUID: JVkfMBTDxC24EomoZS4kw3Mw20F18JOQ


Catalin Marinas <catalin.marinas@arm.com> writes:

> Hi Ankur,
>
> Sorry, it took me some time to get back to this series (well, I tried
> once and got stuck on what wait_policy is supposed to mean, so decided
> to wait until I had more coffee ;)).

I suppose that's as good a sign as any that the wait_policy stuff needs
to change ;).

> On Fri, May 02, 2025 at 01:52:17AM -0700, Ankur Arora wrote:
>> diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
>> index d4f581c1e21d..a7be98e906f4 100644
>> --- a/include/asm-generic/barrier.h
>> +++ b/include/asm-generic/barrier.h
>> @@ -273,6 +273,64 @@ do {									\
>>  })
>>  #endif
>>
>> +/*
>> + * Non-spin primitive that allows waiting for stores to an address,
>> + * with support for a timeout. This works in conjunction with an
>> + * architecturally defined wait_policy.
>> + */
>> +#ifndef __smp_timewait_store
>> +#define __smp_timewait_store(ptr, val) do { } while (0)
>> +#endif
>> +
>> +#ifndef __smp_cond_load_relaxed_timewait
>> +#define __smp_cond_load_relaxed_timewait(ptr, cond_expr, wait_policy,	\
>> +					 time_expr, time_end) ({	\
>> +	typeof(ptr) __PTR = (ptr);					\
>> +	__unqual_scalar_typeof(*ptr) VAL;				\
>> +	u32 __n = 0, __spin = 0;					\
>> +	u64 __prev = 0, __end = (time_end);				\
>> +	bool __wait = false;						\
>> +									\
>> +	for (;;) {							\
>> +		VAL = READ_ONCE(*__PTR);				\
>> +		if (cond_expr)						\
>> +			break;						\
>> +		cpu_relax();						\
>> +		if (++__n < __spin)					\
>> +			continue;					\
>> +		if (!(__prev = wait_policy((time_expr), __prev, __end,	\
>> +					  &__spin, &__wait)))		\
>> +			break;						\
>> +		if (__wait)						\
>> +			__smp_timewait_store(__PTR, VAL);		\
>> +		__n = 0;						\
>> +	}								\
>> +	(typeof(*ptr))VAL;						\
>> +})
>> +#endif
>> +
>> +/**
>> + * smp_cond_load_relaxed_timewait() - (Spin) wait for cond with no ordering
>> + * guarantees until a timeout expires.
>> + * @ptr: pointer to the variable to wait on
>> + * @cond: boolean expression to wait for
>> + * @wait_policy: policy handler that adjusts the number of times we spin or
>> + *  wait for cacheline to change (depends on architecture, not supported in
>> + *  generic code.) before evaluating the time-expr.
>> + * @time_expr: monotonic expression that evaluates to the current time
>> + * @time_end: compared against time_expr
>> + *
>> + * Equivalent to using READ_ONCE() on the condition variable.
>> + */
>> +#define smp_cond_load_relaxed_timewait(ptr, cond_expr, wait_policy,	\
>> +					 time_expr, time_end) ({	\
>> +	__unqual_scalar_typeof(*ptr) _val;;				\
>> +	_val = __smp_cond_load_relaxed_timewait(ptr, cond_expr,		\
>> +					      wait_policy, time_expr,	\
>> +					      time_end);		\
>> +	(typeof(*ptr))_val;						\
>> +})
>
> IIUC, a generic user of this interface would need a wait_policy() that
> is aware of the arch details (event stream, WFET etc.), given the
> __smp_timewait_store() implementation in patch 3. This becomes clearer
> in patch 7 where one needs to create rqspinlock_cond_timewait().

Yes, if a caller can't work with the __smp_cond_timewait_coarse() etc,
they would need to know the mechanics of how to do that on each arch.

I meant the two policies to be somewhat generic, but having to know
the internals is a problem.

> The __spin count can be arch specific, not part of some wait_policy,
> even if such policy is most likely implemented in the arch code (as the
> generic caller has no clue what it means). The __wait decision, again, I
> don't think it should be the caller of this API to decide how to handle,
> it's something internal to the API implementation based on whether the
> event stream (or later WFET) is available.
>
> The ___cond_timewait() implementation in patch 4 sets __wait if either
> the event stream of WFET is available. However, __smp_timewait_store()
> only uses WFE as per the __cmpwait_relaxed() implementation. So you
> can't really decouple wait_policy() from how the spinning is done, in an
> arch-specific way.

Agreed.

> In this implementation, wait_policy() would need to
> say how to wait - WFE, WFET. That's not captured (and I don't think it
> should, we can't expand the API every time we have a new method of
> waiting).

The idea was both the wait_policy and the arch specific interface would
evolve together and so once __cmpwait_relaxed() supports WFET, the
wait_policy would also change alongside.

However, as you say, for users that define their own wait_policy, the
interface becomes a mess to maintain.

> I still think this interface can be simpler and fairly generic, not with
> wait_policy specific to rqspinlock or poll_idle. Maybe you can keep a
> policy argument for an internal __smp_cond_load_relaxed_timewait() if
> it's easier to structure the code this way but definitely not for
> smp_cond_*().

Yeah. I think that's probably the way to do this. The main reason I felt
that we need an explicit wait_policy was to address the rqspinlock case
but as you point out, that makes the interface unmaintainable.

So, this should work (see below for one proviso), for most users:

    #define smp_cond_load_relaxed_timewait(ptr, cond_expr,
     				       time_expr, time_end, slack_us)

(Though, I would use slack_us instead of slack_ns and also keep time_expr
and time_end denominated in us.)

And users like rqspinlock could use __smp_cond_load_relaxed_timewait()
with a policy argument where they can combine rqspinock policy plus
with the common wait policy so wouldn't need to know the internals of
the waiting mechanisms.

> Another aspect I'm not keen on is the arbitrary fine/coarse constants.
> Can we not have the caller pass a slack value (in ns or 0 if it doesn't
> care) to smp_cond_load_relaxed_timewait() and let the arch code decide
> which policy to use?

Yeah, as you probably noticed, that's pretty much how what they are
implemented internally already.

> In summary, I see the API something like:
>
> #define smp_cond_load_relaxed_timewait(ptr, cond_expr,
> 				       time_expr, time_end, slack_ns)

Ack.

> We can even drop time_end if we capture it in time_expr returning a bool
> (like we do with cond_expr).

I'm not sure we can combine time_expr, time_end. Given that we have two
ways to wait: spin and wait, both with different granularity, just a
binary check won't suffice.

For switching between wait and spin, we would also need to compare the
granularity of the mechanism, derive the time-remaining, check against
slack etc.

Thanks for the comments. Most helpful.

--
ankur

