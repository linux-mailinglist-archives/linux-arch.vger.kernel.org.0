Return-Path: <linux-arch+bounces-13123-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35313B21CCE
	for <lists+linux-arch@lfdr.de>; Tue, 12 Aug 2025 07:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B05C7A6692
	for <lists+linux-arch@lfdr.de>; Tue, 12 Aug 2025 05:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2A01CD1F;
	Tue, 12 Aug 2025 05:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WJGi0sp7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HbD0IVtK"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47066311C34;
	Tue, 12 Aug 2025 05:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754975939; cv=fail; b=DyoXtqX9x7uPKxl+sI/mjPquk0DM544Kw5wL1wP8gUbrd0TwH4JyhSMf8FoX9hYCr2TiJ13w0BwdX9OE9l32SCmknq4XqezpyQg8+ID8i2EselCtVS/4XJuM8NM04UwnF3rOh2FmRTlFQFwjT8aKpHHNFgyFJogkL74DKTtIAvM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754975939; c=relaxed/simple;
	bh=1AsB6DVR4vKvjUHO2qscIH8bdPKHYLbJAI+oYmLs0Mo=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=b4FTEly9/vVd5VeT+1p1FRzd6eCQndCTp6KCq/T2QXyc59e8300Ru+QMYBhTYgeqg2L9N0FB2F0QTSlWbTw6sMT8Lz3zrZgyso1c4YLSc1LT7fmenwtPenmp3bUFfg8dmI/hETqc0fbjrBpcup9FimYlijowolT6ldbzBP9zSec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WJGi0sp7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HbD0IVtK; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57C0u9YD011195;
	Tue, 12 Aug 2025 05:18:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=kTuSRS5HOMOW7NKu7x
	9WnxOls2MSOmtpIfqtYi5fQA0=; b=WJGi0sp7ksT+AkBLOB6Vish02Q2g3ihbEL
	F4luFEouN1f6c7LPJSIcpPlD8KJd09Qt/MXXkMz7ExsT3gX/Ht/DKZ4axr1i/vhB
	LG5Alt6QdharKAs+wvMN2OKL4c2W3wemqzUTrIGgBS7GqgVCoiEp+DT7ugKSQ2s2
	Br3CC4svKk4//fyey2QbLb1MIWxLlYIQQdZwvyFERn79F47UMKIGDHpqEzrkvgDe
	t80ehMv6STIWN11vigAZqcd9Wne3PuOwpRdZtONECLeaijBtSo537j0Uwx0id4mH
	Tu2nAKF+ClCAcEpGa9VwN4wJL4nIgS7ZMKzmV0uIQSke+PFUtHYQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dwxv3vtu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Aug 2025 05:18:21 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57C5098E038531;
	Tue, 12 Aug 2025 05:18:20 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48dvsg1wh9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Aug 2025 05:18:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YJCVDKZz1utz2kSX8vtwXcrc+Jpv50sDJBDBjpKUskDgSzvVirO0ET8Sqh+dyCtuAAm6Nul3VAEoomdE0EzwkMMq950S8cauOkcUhsBrOAqqP3Wl9uueZy9GmXfjzsB9nh5TYnRtScNVQQgEM4bTM9V23aBvaAtDqakgm7S/fTxlvXwZFJaQvxhgWg1r9PBI6xChN7dn+cAxOATzXg/YufeQooDLkJJG2Y1GWvO/bhhnzFqmDTVdAKLw+F7MR9d47kEjUqOafAklUjkiAkESEnyy53oreJuaznVMFqhL24CPp1AM18ogDbHxOBgDkSsd6Uj+iQygVWzOlHfCb9p0NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kTuSRS5HOMOW7NKu7x9WnxOls2MSOmtpIfqtYi5fQA0=;
 b=bKq9K/5u7uc+qHp+uLOiTJrzo1FNloe8OGP9MN3WKwcjQPh78Z4yC/zlAPNhJSNxhL1TLnMVP0SLpbtaI2HOaNrEiTTQCaV9T1/sq3P6k8o2TsK6FhvqgQakr/7PKVQKPo9E661vVOQ5eBtjrxbG8qchfk5ii9nN8YeHNhaAJoQnZHtMyl9qNpfI7P3bk15S0b+/I/GiVJpybz2dp71TDkaaX5ogjweTeWTw+0oVFiKkTM6iPsgnwuLO8fywQqSYIHRB2oRJGATxRYX5btsDYzDuyLQTfSaY1AoWMc8s0ITBFxAGI1vgoa6THYJby1OstmeKavk7+m8wvbUPcoA4rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kTuSRS5HOMOW7NKu7x9WnxOls2MSOmtpIfqtYi5fQA0=;
 b=HbD0IVtKcIuAl4tN+OvF5KDbwmnigkg3IJjJW7JtrdkDpoaztCx8SitdQQzYur/O4RpsiFK2CejMBqYwobQA9ZJpEuxKk7oBmtYcIe6mXWs1Nf86M4WGKg+IiCRiyUJtq4HISoZnekfe90CUggf8nVuIR59W5PQpOgnI+1V9+YA=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CY5PR10MB6047.namprd10.prod.outlook.com (2603:10b6:930:3c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Tue, 12 Aug
 2025 05:18:17 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9009.018; Tue, 12 Aug 2025
 05:18:17 +0000
References: <20250627044805.945491-1-ankur.a.arora@oracle.com>
 <20250627044805.945491-4-ankur.a.arora@oracle.com>
 <aJXFpKEm7-abCAFc@arm.com>
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
Subject: Re: [PATCH v3 3/5] asm-generic: barrier: Add
 smp_cond_load_acquire_timewait()
In-reply-to: <aJXFpKEm7-abCAFc@arm.com>
Date: Mon, 11 Aug 2025 22:18:15 -0700
Message-ID: <87wm796ru0.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0212.namprd04.prod.outlook.com
 (2603:10b6:303:87::7) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CY5PR10MB6047:EE_
X-MS-Office365-Filtering-Correlation-Id: dba43f63-28ce-403b-edd5-08ddd95fa4e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Id0K3ElqnSp9VkN4JtyR1ATPreh3Z0Bc0UeBuFpAiRjlP1JylgEydBelz7Qz?=
 =?us-ascii?Q?e9b8/cOakjHJwxBE3rR5BQQBqy7mDkgYjLvoRv1jaO2oj3lcPIz0YTXZmDPo?=
 =?us-ascii?Q?tcnxFCSJmym5aiPAXxMiqYLBCp4cJqwWVjGrIr3mechBYFtiCGzGFeujn/XO?=
 =?us-ascii?Q?T7l+OlKbVxmsnuNngfG/2Z7IKNh+DVz/S1Szc8tx0kvSTiZGH57TkYxfO/4W?=
 =?us-ascii?Q?tJR7XvApzqt0BFTqj/HDcz/IbqaIhcvamViCxm9I+sWfqVqK83ZmfVrTUuF+?=
 =?us-ascii?Q?3qsXN05L/3RuQ4vfH51Jyl+FOU0Tiog0cC9wcFJpIWtJP9ssLNFNWMmsQ9i8?=
 =?us-ascii?Q?QcS0DMJDaAUzR3+MrCC3WlHrhUuwSnm+SI0RHR5i1vdQbYrv76voguP5WYAs?=
 =?us-ascii?Q?XgFK1ylEHbaLftJ/yBP2pSHJqGqqqMDXu5Sw1HpNwBF4enFYoEtvEYz89v8D?=
 =?us-ascii?Q?u46WOC2cqwjIngc2hgCFDQmlFmoM3XLpuWTqxrGjk/dxAMum6QvBsB1CZXRS?=
 =?us-ascii?Q?8EIzhmlrHDL9uJEMNJIMH68WltzaNlg86Ms3ixBaY9FnCJkFkpgRd8uFvjNZ?=
 =?us-ascii?Q?8tr5YBlEfoZrekgKIli6baESVoaA0A59B+vEtD4Vs6U3TlqoEXjRngJjQWjf?=
 =?us-ascii?Q?2aPdeH4WclY61KUSLaNWH/DaquVYWdVuFhmseBis0LH5APjrnwA+8xfnh6/K?=
 =?us-ascii?Q?0Xdz3TEf+Itu5+OuMXRP0HRVYp0JlCQElDC5Vm7OTUQ+8ksoPr7l+sWuPtZv?=
 =?us-ascii?Q?KKwG06Hq8iblAiIEpqV/ejw9CeJLCDuMOiVJrjqoGq6+Wk9U1Px4dXrPFvB8?=
 =?us-ascii?Q?eauuJLKz9jVNw047UwLXiBfzDlvlhucXehxgDjovhGTk2uXRmsbZiqzoyCtx?=
 =?us-ascii?Q?tdUgZsA9etIqUYNAdazwQ7Qz4TFBKCDYF8SgpYAH1/OuX+d2RrtjDio7uPpW?=
 =?us-ascii?Q?XrrIt0x2C9lwITtt1uYcqpJlDMimo5lN4pEiMmqyhVmwI8Cs47xxiyv9Chkx?=
 =?us-ascii?Q?HojZQRBslzHJyqns7MeGXZSupUcXT3E9fe4Oewg3N31L9+JInofkkafDRHl6?=
 =?us-ascii?Q?7JklrVHLhZq1PSMoo0MwNPHVpsvOb5AXss3PW/qLVyRD/Yo8OeKSAwEvvIph?=
 =?us-ascii?Q?/0Le9Jm/SSk9tk53OlD7wihGI3EQm3xY/X7V0T9xafM4ZggjzDHaN09pZcUp?=
 =?us-ascii?Q?kQBFjs2jodKe/yqBdriY4sXHDR8TWh//OheORPkqJKujX6HFUA/6+q23Lx29?=
 =?us-ascii?Q?zQWpRHsa/FeI4wQZzK19O9Fb3U2pe8VaSoVVE7d8feOYXfY8xwT/WFnCcWHa?=
 =?us-ascii?Q?zG+2bqYAAmiLDIKI6zDfwQzEdP9U+n/oSzeUVpTcggxWtgkhK6se+OhCDYa2?=
 =?us-ascii?Q?R6GOHyAR48XS0BVE/EV6nrS+bi3DhCeYUATSInLCNdkb7I5qq4epcdAYSNk5?=
 =?us-ascii?Q?b4p6ULehsIQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3ACA3JR4YWCtDjzxv0mLSQPcGVXwSbaew+f++M6Re8I/ujq78smJ+J5F2Wgj?=
 =?us-ascii?Q?eizY0+Hht6Kq7mr7gvo8O/bqnon/dNyaJ98xWID+PDbdOoXCXEcYoteMKAbt?=
 =?us-ascii?Q?lBGR4Jp5aw8tr9x0lYBW2ectJr8WYw3XblDw5z9I7B1gYwuSDGHgh9KhtCFr?=
 =?us-ascii?Q?4oYQHw0hGs2dMbMkRjO4gC9zPXVDuDIe4cglH2xYxjzyqfoGemthN2jmam50?=
 =?us-ascii?Q?FT6uHcN1gUezFxZSuznFxTEnKV0NoEV71bGJO1afMvRY3QK3SDB9KChGUkwt?=
 =?us-ascii?Q?fXjKAvEteSnYBp4IdcAeNKtXSlHBdjDHRuN0D9voVe5cfV7syCo9xqSQgVhd?=
 =?us-ascii?Q?PggI9f87ZG+5MW8NH4NWpOpTjyHhPKakymjnxIq1vv+IWwMZ2LF6znsfFb2P?=
 =?us-ascii?Q?/f281Kl0pHZYN20poJdpH5kv5+h8VQtyEIPRHd70u//gKLLTaDn4dVFkRtwH?=
 =?us-ascii?Q?kWiZCCk6RwO/4KiMb3uGiuJlIi/9ee0c51rhS5X7FXzibpBJnmKeJDDxGw3a?=
 =?us-ascii?Q?abJjT0e8X0sPC1smnXK0wJ/NUpN0n1tZJu9KuXt2pcpw/No4EdchNlKw1Kxm?=
 =?us-ascii?Q?uBIRDpFVLqidjB4f8gCY7YZz6s++01xqRSmy9tc6GXM1rjnP09F2lsGbJebU?=
 =?us-ascii?Q?2J+DvTHc124vSd6p+4OVykyWpEyo3PljNIV+WJlKa6EPJ2C5taPbPgvM34/K?=
 =?us-ascii?Q?EEetXO1jWvMY58pm+es8jq584MuLuKS9MkuBsMKtqsEJzrXkrLGFAI66cNx8?=
 =?us-ascii?Q?XxI7eplNTLu7MA+OH78qNqtHKMNOsEZ/dxV7jECMFYZGTpbyKXM+IeVaAuPe?=
 =?us-ascii?Q?cUcZbJ3Bo1nzSMZTbF4GQc6NvNucVEXyjy7xqveNsN/+vorSdpDIPXLTqfoA?=
 =?us-ascii?Q?e0wBfJOJgnjzotwuE875KGlytFdohrC1hreADC8UpDgiMruXNFUZg2VmrJ+h?=
 =?us-ascii?Q?m6Hr4s9hX6DzmgFxMedDblClUhaghO4cBoNUwam9DkMBD6cdFVfSox4fYZS2?=
 =?us-ascii?Q?/1ZPFUiHhctFlrabPEKvY/IgYNC4m5x86/WMj7szXWklJpFx3JAZFzemO1bX?=
 =?us-ascii?Q?1ozqbKncVNI0ltGRtEdMHrZbabLbHxrfafBaF7bhDr9ZKEUYuwWgK8wI6eQ+?=
 =?us-ascii?Q?KzQmdo9F1WTS1fTiQKhAPU1JW7BMsXCi7g5B7BPRyXxaPKw75s7CNZxoEmP3?=
 =?us-ascii?Q?wfjXXPgrT4JCgbVpjv1Tc0KMvfiRz+TEbLARbBTLN/kmCrjZOhZIiOHpo7Dx?=
 =?us-ascii?Q?8I/pfgfmf/6RwtcHvdzfci+JvXTYRwTbNb9sg2RBOQ/rsjX3oz0/I36njHzA?=
 =?us-ascii?Q?48ePmVy6WIw9qExgpdQAQFecWr/Rg6ywgnJfi806vtXGX6y9eqcGQD9aBCUP?=
 =?us-ascii?Q?cGERpW7pMvoWag+x3KOjTa4xfW10wz0iDJdKQ75LgnxprIzdGLYeJGVxP9Y1?=
 =?us-ascii?Q?zs75Xn+HD1FuWcU9R6DI41X/T3CNARDW/vcNaMvgkv6OQ40ddRevJeXns6Ai?=
 =?us-ascii?Q?+sALVa3ymHB+qcWY4EoSOsSBB8ZZF5tGIQ32+0m8RcvXoVNQbzYlY4xiKDxY?=
 =?us-ascii?Q?lvO5OobWYSTM+PVQIzZQKoBlmSoSNi9Mrr2xhMen6oaTtl8wfdJWnsE3Q3hQ?=
 =?us-ascii?Q?aw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5E7q8+/X9LtQKzYcmPrfIsdRrqMxZNK1r4pZ/ZGo3QDxx0tjJ3sx16QYpfsi4KMBzZ9gw5EAEkW2lMvyHkRZrYyjtsxrjWfGeXJDVXAEUm/P5OBpLx5pCP+LdoHD6O52zralmyy1gKrpQAUa754ipjYrkSqKjVYrLJ3vXokQWrKcOQlKI9OY7ZQYGuYDEAJ576jDbxsy0Q4iIJ1C8qitl/k1v0k/ZefMYtxoVWK+Eo+9Bk1d1TblvqVaitTnAzISGtjugfWIvaHII2xmYxro0VYloPcOjhgY5bRXjoskDxOkweabRX/TQVJpYf1QE1K2qjPQ1KhsiN15PEpJ2WA692HCkEMx8xfvKgJEj0iaq7Fs7BJ0Dwz9yu16JoiZwFg0nyl5Qwqi/AhTqov4KuxqMyxuLZI9hT2fcG00daGGp6zTn7wU3IKn5UumDgCaXW8nYgp8xn5826p87o9s7Lyc5J5sXMUL3voytkM1fDw+mvY23J4qQJ0z/N1F3PuOi/87fdtI0LnJ+E3klwmCeBeKxcefGW0Fg82MinsYE/UMpxlb0nYaYlSBMCJs7qWVVsBPiqbFYQPNhFm7sELnhyh9UKun8tTHxg5LK5wpGurZi0I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dba43f63-28ce-403b-edd5-08ddd95fa4e5
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 05:18:17.7474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XupRsh7kfx1tNIj39nEKOQuCnaNNQfqBYJdlK1oc7Tnly97G9cEeM8z49JnZNDhZmVXlYeLDJRzBZf1/QekRfZ/szw+6lfoXrNJDubeg3wY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6047
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_01,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 spamscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508120047
X-Proofpoint-GUID: WifJiY_biKLwws_Gz5NBd5qQI1jt1voA
X-Proofpoint-ORIG-GUID: WifJiY_biKLwws_Gz5NBd5qQI1jt1voA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDA0NyBTYWx0ZWRfX0w3IaEaSFrBJ
 PpxSkEcfm3IVF3Ghr+PavcHVRNkTma53LZ7R91eGz/bxbMWDjeblCiGt8pMB+Yn78yYf8N59n5A
 jCS0nm0PpgePp6JBLz1u/cGRt7xvHGxd/CBTd+2ymR5jkumu6Rn/NcNI+fMm/C9RqkYi0yv5Xv4
 Z68kGS4d9NulmCVez0CBmlzndq/I0SVljMourKPLobDdkRC437LAM0l3dvTGVozw3AdhTbTPlXn
 jCNhACWKSuZrigBNGYqgQNN852dcF931dWkzkXe4cOOLQWQZBKlo+UNLQ65ubNeCBaZogDM5Gud
 wyb3b7VEa2KCF3NNDmmzLpJ4vvE3SfKD0JqJT+KHtOsd4Qu+rxQJZBLuqtUGkxO2zmDuWexGf8O
 pyqDIep1DGqO4koZMiWLa2e3+/VQ7Lm+MKT/BwvpH0Qe5usDus4c9MgaqlXgMGRpWrGWT3VL
X-Authority-Analysis: v=2.4 cv=KJZaDEFo c=1 sm=1 tr=0 ts=689ace9d b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=2OwXVqhp2XgA:10
 a=GoEa3M9JfhUA:10 a=7CQSdrXTAAAA:8 a=lRLK-eTyG3jIob72pwwA:9
 a=a-qgeE7W1pNrGK8U0ZQC:22 cc=ntf awl=host:12070


Catalin Marinas <catalin.marinas@arm.com> writes:

> On Thu, Jun 26, 2025 at 09:48:03PM -0700, Ankur Arora wrote:
>> diff --git a/arch/arm64/include/asm/rqspinlock.h b/arch/arm64/include/asm/rqspinlock.h
>> index 9ea0a74e5892..f1b6a428013e 100644
>> --- a/arch/arm64/include/asm/rqspinlock.h
>> +++ b/arch/arm64/include/asm/rqspinlock.h
>> @@ -86,7 +86,7 @@
>>
>>  #endif
>>
>> -#define res_smp_cond_load_acquire(v, c) smp_cond_load_acquire_timewait(v, c, 0, 1)
>> +#define res_smp_cond_load_acquire(v, c) smp_cond_load_acquire_timewait(v, c, 0ULL, 1ULL, 0)
>>
>>  #include <asm-generic/rqspinlock.h>
>>
>> diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
>> index 8299c57d1110..dd7c9ca2dff3 100644
>> --- a/include/asm-generic/barrier.h
>> +++ b/include/asm-generic/barrier.h
>> @@ -388,6 +388,28 @@ static inline u64 ___smp_cond_spinwait(u64 now, u64 prev, u64 end,
>>  	(typeof(*ptr))_val;						\
>>  })
>>
>> +/**
>> + * smp_cond_load_acquire_timewait() - (Spin) wait for cond with ACQUIRE ordering
>> + * until a timeout expires.
>> + *
>> + * Arguments: same as smp_cond_load_relaxed_timeout().
>> + *
>> + * Equivalent to using smp_cond_load_acquire() on the condition variable with
>> + * a timeout.
>> + */
>> +#ifndef smp_cond_load_acquire_timewait
>> +#define smp_cond_load_acquire_timewait(ptr, cond_expr,			\
>> +				       time_expr, time_end,		\
>> +				       slack) ({			\
>> +	__unqual_scalar_typeof(*ptr) _val;				\
>> +	_val = smp_cond_load_relaxed_timewait(ptr, cond_expr,		\
>> +					      time_expr, time_end,	\
>> +					      slack);			\
>> +	/* Depends on the control dependency of the wait above. */	\
>> +	smp_acquire__after_ctrl_dep();					\
>> +	(typeof(*ptr))_val;						\
>> +})
>> +#endif
>
> Using #ifndef in the generic file is the correct thing to do, it allows
> architectures to redefine it. Why we have a similar #ifndef in the arm64
> rqspinlock.h, no idea, none of the arm64 maintainers acked that patch
> (shouldn't have gone in really, we were still discussing the
> implementation at the time; I also think it's slightly wrong).
>
> Your change above to rqspinlock.h makes this even more confusing when
> you look at the overall result with all the patches applied. We end up
> with the same macro in asm/rqspinlock.h but with different number of
> arguments.

I agree that my change doesn't improve on matters at all.

Just to lay out the problem, rqspinlock defines this in the common code:

  #ifndef res_smp_cond_load_acquire
  #define res_smp_cond_load_acquire(v, c) smp_cond_load_acquire(v, c)
  #endif

And, the definition of res_smp_cond_load_acquire() (only on arm64)
essentially uses smp_cond_load_acquire_timewait() such that it will
be equivalent to smp_cond_load_acquire() but one that's guaranteed
to terminate.

> I'd start with ripping out the current arm64 implementation, add a
> generic implementation to barrier.h and then override it in the arch
> code.

The problem is that rqspinlock code is mostly written as if it is
working with smp_cond_load_acquire().

Fixing it needs some amount of refactoring. I had preliminary patches
patches to do that, but my preference was to send those out after
the barrier changes.

If you feel that is best done as part of this series, I can add those
patches to v4.


Thanks for the comments!

--
ankur

