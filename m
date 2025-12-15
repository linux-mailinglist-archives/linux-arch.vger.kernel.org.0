Return-Path: <linux-arch+bounces-15395-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 072CECBC7D8
	for <lists+linux-arch@lfdr.de>; Mon, 15 Dec 2025 05:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9AAFB300729A
	for <lists+linux-arch@lfdr.de>; Mon, 15 Dec 2025 04:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56552D543E;
	Mon, 15 Dec 2025 04:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ol5Ok4oa";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VXagWdQJ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48FB1E0DD8;
	Mon, 15 Dec 2025 04:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765774272; cv=fail; b=eT0tXEaLhSZCJ7oMU9ZHItf7gNEuECmBfyCB4AzOiuZBBthb6KJMU82KF+TPyxl/8dyFMB1V208g7irAdpkMuoxhjB6cm4QLnxfJnCxD6prxRh0B1VoYv7esWiKxyKvGX6B0ooNvjnNzsZrgUf+F56wLXMjyJNyKrTJ1JEwvpgg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765774272; c=relaxed/simple;
	bh=kSUCLLCvs184nHLKCu044ZI9rllsTIq+/u9I9Ig+RNM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WFzfVGhve0l/3+KH0yOog7C632jCv0yGObtp61wjzM9qZDlAIOChzyZfK4NLhn3bnckXNrv42/vJnx4QABxndGW48QGuzcQRk1aY5O7bXnPbBWsbJSb01/eXax8r2E1l9txD58PLVb6m8GqiP1IOnPXlD/AUvfOSPiIGHZDdxGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ol5Ok4oa; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VXagWdQJ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BF0Fx7D982081;
	Mon, 15 Dec 2025 04:49:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=p3ugmiucsT7MPRQrsuTGwdXGivxpKP7hC4wP4Iwyc5w=; b=
	Ol5Ok4oayK0Z1BuNwUoTDxH4F9nNHap4WoB23cPFiD+pqQVDSYUrlBZfjPHqDgxK
	aVK8B9wK6Aq2VVzDJL02PX/fa7IOBzfyS5sYFegY0jPeUjmlAp20QGV2MtlhvJnj
	vsWJMwd8TkdiOBJTtaw40AfPG/Z3w8nbKFHh3+uSczpQtpapAIRdziokZCAkQT5i
	wCBmSxia1x/0AmH3e7n+YnG2JBq/ARRm4ZEDdJiSW91bs3LIT4VTAdkj4RhDpyUe
	omLPZkGxQciYbHPa/szq+tlT8ehQgHXbkznFW9h+2pufvRfqDGDJ3oW7/5eRVHls
	wp4j4MAA1PwUFNTTq3sGgg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b0yruhaa9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Dec 2025 04:49:39 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BF3De06025232;
	Mon, 15 Dec 2025 04:49:39 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010050.outbound.protection.outlook.com [52.101.193.50])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4b0xk8rdf5-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Dec 2025 04:49:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mY13hv+9G1LEQrcyb7vxZxkAr2cjJ6JgrEqnXzcozU6OSBGvBM86oU+r3axJDJB1li8nNC/D75um/J5fUHiJ7QKajMvHBc7sLSrZYvGIPZM62I6fDoohXgxtRrceilzao70PdKiEy5KSBNev5rN7TNc0wvNOk6BQdaSL4fbm7C3i1N5qBCMjBPUOP1sbZACJmef/WzmPWoYWPh3avNexA0s9c0WARQFdfANgLKsZGjm4JrMKMxG+HLqxj9mYwilFIAqkOvxG1XGL5R70jvvHqp3TmmCQPGB60ryy5EBPY718ZEUqzAHmxumyoonNiQT8S/8yldLTX+VjjRamba/zjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p3ugmiucsT7MPRQrsuTGwdXGivxpKP7hC4wP4Iwyc5w=;
 b=WDL8IFfm2iU3Zb72XqRq16/1vSjXgveNNw0BD7TE8sDPUFvbDoVtBKyIJwKEWBvscCyBMu/kAVaSactjUgs1cW52WLgl+TxehH1UJXWzC8MpvLP/D/ionDpQ84d7FR649q5W6yIyIOfCpTI2sTGIfoGvWVH1hikcZYAqiYhcW44dEtFp4VXyUP7fj1OUBspZY6twkvdKv5tiuFiK11K5icHr10vMkaQ7gd8Ty5KOZeqzAgvwMQEkEeIk58YxSvsQn7QlpnwvKm2pNJi6eK6srjIwoYszcBqtDaEWZZJJ6WLHfajqZMyIgsDnTR11ml0JQVriVwoxfnykPqGB16KAAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p3ugmiucsT7MPRQrsuTGwdXGivxpKP7hC4wP4Iwyc5w=;
 b=VXagWdQJm+p+D/qBMXyMBV2eIofdMjoTRZKEulmZ2iScnWBQ4g5v0baNGEMylgxossRR1JLgwoShw1G8cnbDBVJQd6wXZUQByscNbqf6ki4lwGZ1aMLP2cq4QqbeR5PLYEMjj/l/gAsgzuqeb3aD0IceDohRDiWxT8m4mVYs6NM=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SJ5PPFDEBD75B51.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7d7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 04:49:37 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 04:49:36 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        bpf@vger.kernel.org
Cc: arnd@arndb.de, catalin.marinas@arm.com, will@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org, mark.rutland@arm.com,
        harisokn@amazon.com, cl@gentwo.org, ast@kernel.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, memxor@gmail.com, zhenglifeng1@huawei.com,
        xueshuai@linux.alibaba.com, joao.m.martins@oracle.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        Ankur Arora <ankur.a.arora@oracle.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH v8 08/12] locking/atomic: scripts: build atomic_long_cond_read_*_timeout()
Date: Sun, 14 Dec 2025 20:49:15 -0800
Message-Id: <20251215044919.460086-9-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20251215044919.460086-1-ankur.a.arora@oracle.com>
References: <20251215044919.460086-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0278.namprd03.prod.outlook.com
 (2603:10b6:303:b5::13) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SJ5PPFDEBD75B51:EE_
X-MS-Office365-Filtering-Correlation-Id: a9f474fd-97ba-4061-123d-08de3b95595c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8ana0yXII2h0aztjmdi7z+DyTtxeKsmBr/YcQUfHYYrD6SeWckUuNgEVt1DK?=
 =?us-ascii?Q?rMLjdhgrbXPq5WK+wYQpIsXi0fprYjTWZEsDninoOQ3xtZaioooudxeuth6A?=
 =?us-ascii?Q?2LiqbJE7+vG/P9EraaIS9DCQ08DS5rQLyJ2ed1oPPCj1OJNPfQHhiA25URth?=
 =?us-ascii?Q?H93F96DmZ2pqvwF+qquFH1xmSTlslRIYRm6S4um8bzLPG4/AfYxqQH9WB2Fy?=
 =?us-ascii?Q?4+av485y0CANar40LjTjr5lMP3JNQ46B7d3j9yEMuA2lCd/ZPlnbKSe6gt+H?=
 =?us-ascii?Q?6/rP6kD1RtEGkRL6ca9IsKaQb243kmfuBkDRnFa8zedibr+xBQw3i+g02yo2?=
 =?us-ascii?Q?7wvWjpE0cWJUcp59wYPzEfc/grorf+HegVGLV2+QxiBl7XEcHPOr7TNM5/kk?=
 =?us-ascii?Q?FRUjsTqgJkTnYJMzlgboOPYJ1F5LBaKPkpXrID82KZp5tC0PreefzcOHvgIk?=
 =?us-ascii?Q?On1jl8Uq9vwtG2fp8ED3XmyPfeAdAlwoghZqi0LDLFAhCYi0h6v0IeoBcT8S?=
 =?us-ascii?Q?le0h8PRdI1uRSe3QqTYH+Z43soY2Om8xEnwI8VusDBpfJ5dakZyF4gXtFnKw?=
 =?us-ascii?Q?2xez85ROzEXi96HkZTQhSGMG08k9DBJ6eNiKHuolGgg/0PChAKy1VzmsccwY?=
 =?us-ascii?Q?rSObVIxEFNvXEjH7P8WWk6RbxS6VtDCJfZCThwshq7QuYxtJ1JNwi0BiD9tU?=
 =?us-ascii?Q?+dwol9UeJYRtCsWSpuPLgUNbjJDGCqRqERANwNyvMd1m7FsNvvcVWevpAvp3?=
 =?us-ascii?Q?g67Gf8BIBDM5s2kW41aHmDQvE4yWoA+ed0UVQRfNhAxswh0Y7hbIaj7tn0o0?=
 =?us-ascii?Q?leifHBu8hFD39XRSP9zbImoBGax3C4GJS6U8309mSB37zYVF5yjGztYTC+aE?=
 =?us-ascii?Q?tRvh/6FSGqjAI3agl7oEA8Vylgg3dU0ZwJKf4yYjl2f4rqO52WkosF9vj0f9?=
 =?us-ascii?Q?9HsiHKBjlc5qMQihLPO4ctp6746CBIeXDFsKq7uI7k81JajNAMgRsauk9Wuc?=
 =?us-ascii?Q?7S/rn5TS7C5ebGmyIX5r1C3fiOXObE4FojczujcXdlCrvZs/Q9X/bxST57E6?=
 =?us-ascii?Q?foEHVbhFpSw7eEeDXdqcfwHRsD1nVAE+zmfM9BsJsChyGuKpoTAS9QOztz2P?=
 =?us-ascii?Q?7sQz6WdahzaPl8SCFrK7IBhU+q9nct3EcNh5zbthmS1+FKExzMnWc1GHaDE/?=
 =?us-ascii?Q?+lxfBMmqBP3q/p/LdS0JUuoevYqM2NcMZljhHGa1ZX0V2k/2BouvRkqnjwbr?=
 =?us-ascii?Q?hrXxfSveCGtaGC1IOeR2F2Hxa7hVSTfLsK0OqVOUTfu5RZ4QUb+NgiTfGGwD?=
 =?us-ascii?Q?LA+nRElYJdl+Sj5draQ2VcqU6U2X1mijyEydCqJprWh8BjZyuLi0MM00IVjh?=
 =?us-ascii?Q?ELoZg3I0PdCIgtUIhz0P6eCCsBAoiD1OA7/z1/EAThOnfrIv7EUjVmY1cyrT?=
 =?us-ascii?Q?D0U2o0f6ctxMVBKDxzfzDinWQQr1ULj6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iNWbYJBk5mxufAqWx5Y/kws2byE4hVow4c6lf55XWkMDd3ajgJOuAZ16h6cZ?=
 =?us-ascii?Q?GMjj9yZpw4c4Gie7lNYzd5RpYC0FPpPw4O0YO/0C3jv0Te33VUbgstA6Vt5j?=
 =?us-ascii?Q?6qQSk0n0hMCPkpi+WqI3AEC4d0i1ycQEyj9e+fzve8OygxcPvdQkGTOO78TS?=
 =?us-ascii?Q?04TWUqb3Azrp9Eupgqaps+6BXtEpcqQqH1AJRtmv8oBEtWwC/rEVUvGJW5TL?=
 =?us-ascii?Q?qzU6MNh0iEtnZi8T85aRbuZgy34yiJcUdJaJS8ksXQWpwoPfjEXsXRZGegyI?=
 =?us-ascii?Q?9N6Px3NqFmbk3NCu3+y/GONDrvkgiJ+R1EHAioAqluyLBn3yvGzWDjLYkzko?=
 =?us-ascii?Q?AUcU5G5IG5KrY3TAis3eRRq1kvKKpng3ipqsKu5FB/lHQ/f+jUrY+kb2Tw9y?=
 =?us-ascii?Q?NQvZlVTciXymu0YPdM8oxRbVTL1CAT/w/8FgJZX4tpouBrlyLrlvJoOtfUJL?=
 =?us-ascii?Q?cCeLTpOD3auK1ryDqbHTMFlt4UeS3zypk1OjeOlXTGZdRjZmEr0anGX9hRtJ?=
 =?us-ascii?Q?xl9WhhSZC5W7PrMK2rxQ6yjJH09B4eeGy8JQhQISzrGKWY9CPV2BGoE5qHND?=
 =?us-ascii?Q?umgdBmMJFTquDG/4SIw6iCo7qIjzx3n7z553kCE5YFSFmTVGNi6zbi5Fw1GK?=
 =?us-ascii?Q?O+QbjLVSIZXwoUoeb8IPBIfeIuI1DROUvO2wqx9TkwSeUYobT7AYUrzLk64M?=
 =?us-ascii?Q?O3bZXvUF8ZKcLSmuuUNSJsd8oKilfMmaglDg7r9BUwC60AjPhLjTYRF0Wvbk?=
 =?us-ascii?Q?qCvg7YiWeAiXC6QVmpHdKvg8J5cZW9stPDIUaF7gm7LXuVXpCPRl3O+hPrcI?=
 =?us-ascii?Q?182Y9IYPWADzSI78aN9ieNlVlq8rGaUam+1pPn46rMSX6MpmxDmzcXRFplyt?=
 =?us-ascii?Q?4rGRR6ql8u50TQ6H2Qy4k3HPzwcEfM77dwrs+Tjo06cwOyQ5x1wA7XJbsaVY?=
 =?us-ascii?Q?TodWiBCQ1UBz6oPTasDtqxfGULlSisaD7vETGiNyHILyjmd29CRLQm0316UR?=
 =?us-ascii?Q?NtDVjhbmGVha9AL9B4mv5pko//o6G+xozQNuw1NtdBFXCn8Qeix84QynvT5U?=
 =?us-ascii?Q?VyJsXLFWIR6FfRBfZL0EH4VDC6/ow2MlwW1aA6BUpasLLHuK2PfU9LS0nb93?=
 =?us-ascii?Q?jqDuoYF3WSt65iZs32h7W8DqXmPhe0XMJCvLc/h4rzo6r5B7hfKsALHBwRdr?=
 =?us-ascii?Q?vNINWnngapCkjqkOmcd2eKbS3d9Ol/pvVccQf/99sh92uQD1i+60T9mzggpv?=
 =?us-ascii?Q?nJVL4Z45GN4VvasQwEftcpAHwsFvrxYedveiXqw8DFmsKDZgdb94jZ5YVShe?=
 =?us-ascii?Q?Du9jYRBJ2TCVT+QU4AetHlCde29+5Mb2EgaJv1UIWPl5a6mSJN4Eq72/A7lJ?=
 =?us-ascii?Q?gznlleMVuZ5H/zixHr9GgotuIpFAqUdyOjhIM/Tqs8jFSctoDFdxqQ0FXQqY?=
 =?us-ascii?Q?AGTGwj2GLuAV6YkZKhqxOoDA75YMIyExVq3jpnGB3S94kvsetGHYIYTNvHwZ?=
 =?us-ascii?Q?rAG+Ab9OR8SoT6QaesVT0OhXdLWbhOws4kNDNl+NqsG4QDj8d2KilXqfCthb?=
 =?us-ascii?Q?HmkGGcoUrMHPXbrNth9nQWmi9T/Cd9NIeccwKr2lI2WGWOVf4QqhUMJmCmia?=
 =?us-ascii?Q?ZA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5pIhl5I0MrMg7qfoLCXWkuD9wizmQq/4IUflkP0/hl8aJdOLwuutYVuYdoeQAHxSbRQTHdizmWJ9MbpDV5YSxxhzc5jp1TexsmPpiMvffOOcHxIa4nTLKgWuo/biNRgXT6pxvogoVEoUk9t4+NbO4n5B0iGDefb78eANB9MdKfmBnkWatkgtjS5EyN/+m7wKwV9Xag3jHWmwr4aOMUWrV+qHk8ibbiEEo1khr446FADZk92CYiWJGzq8UY0cWx+dF7qtMSs+xdnTrC+I/Lf8Z5Z/lra7rXdBwzLh4T4kNAwVFHqmzp5KMZ+x1OKsOWBeL6EMKoE8lzAsTIcw2IJnv7wsLBtrOES0O2Xpn8Gr0OhYgLunYgXjtW0e/oXugLiyKPuCevM1VDhTFFFVpM95Kebq7UNX5OjCdF143ZPEp2pfJcV/1wL1dHz6n2LUUSr3B5r1H2YIsRG6RvF/oJEIgZVnh/NHSe6eJgazSC3OAVEvAFb6fxcsTEbN7DRf54MJR/i3kFYnvJJHw/PFv4dAvtrbbzLCPeX5Ws1ao6ta5GRAEuapfTGEqR7KkZacpJ9G23aU0l5aOYGfu1wkzhiEIVByNL6mqs4W0Y+3R9OSg8o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9f474fd-97ba-4061-123d-08de3b95595c
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 04:49:36.9582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 51pZZOHheXqg7RQac7ENGWAsGWSrcKMMI4fZaYCD4uTBKZgW6KMOFUzdk7PgbOS2aLWmXTZyhHZ5Q695zZgxdInCLaNtcvLJs+Pg3QfNI10=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFDEBD75B51
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-14_07,2025-12-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512150041
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE1MDA0MSBTYWx0ZWRfX9PanJrlKBHC9
 eAuNCLdJxHgAGmIwqrwHReGIYL+sqQRqAB0mIdhYuupaBYbBySPPhv/ppJkW93TuBqKhaBGm23x
 Xuhp+pAOdmqTSLQvaqGEez+vgfI/u5HBAC3p/tyF42kovqSbIVAnchRFzXoPtZaesd5OXiUln10
 TSrgMX3SczzRXEdN95acPSBE16VPL7povKOTL3+l1ljIZy0zDzTZrh11KG2xs8Z/ONqKPR4LL1i
 TSjYS3Z9kzMz2zeM66LxpY/W0+ikHgHlo18S8c7siA3vokg3X80HBLmVc450iM5TmLxhwnp3ttc
 CrUEQAcb1dm4VWHc2nsOsX+JzTpOtL6b1dCtEhHcJxRQvn6btrO/QI8ac6fpRyFUISGzcg6KnFN
 DyjMLI+8XblpmkTN7QREzoV+bvIkww==
X-Authority-Analysis: v=2.4 cv=TL9Iilla c=1 sm=1 tr=0 ts=693f9364 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=wP3pNCr1ah4A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8
 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8 a=LKnZA62imwlViN-40TMA:9
 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-GUID: VgN5-Uvmq1jXdT_eJGjeKgbfrNkK4er7
X-Proofpoint-ORIG-GUID: VgN5-Uvmq1jXdT_eJGjeKgbfrNkK4er7

Add the atomic long wrappers for the cond-load timeout interfaces.

Cc: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 include/linux/atomic/atomic-long.h | 18 +++++++++++-------
 scripts/atomic/gen-atomic-long.sh  | 16 ++++++++++------
 2 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/include/linux/atomic/atomic-long.h b/include/linux/atomic/atomic-long.h
index f86b29d90877..e6da0189cbe6 100644
--- a/include/linux/atomic/atomic-long.h
+++ b/include/linux/atomic/atomic-long.h
@@ -11,14 +11,18 @@
 
 #ifdef CONFIG_64BIT
 typedef atomic64_t atomic_long_t;
-#define ATOMIC_LONG_INIT(i)		ATOMIC64_INIT(i)
-#define atomic_long_cond_read_acquire	atomic64_cond_read_acquire
-#define atomic_long_cond_read_relaxed	atomic64_cond_read_relaxed
+#define ATOMIC_LONG_INIT(i)			ATOMIC64_INIT(i)
+#define atomic_long_cond_read_acquire		atomic64_cond_read_acquire
+#define atomic_long_cond_read_relaxed		atomic64_cond_read_relaxed
+#define atomic_long_cond_read_acquire_timeout	atomic64_cond_read_acquire_timeout
+#define atomic_long_cond_read_relaxed_timeout	atomic64_cond_read_relaxed_timeout
 #else
 typedef atomic_t atomic_long_t;
-#define ATOMIC_LONG_INIT(i)		ATOMIC_INIT(i)
-#define atomic_long_cond_read_acquire	atomic_cond_read_acquire
-#define atomic_long_cond_read_relaxed	atomic_cond_read_relaxed
+#define ATOMIC_LONG_INIT(i)			ATOMIC_INIT(i)
+#define atomic_long_cond_read_acquire		atomic_cond_read_acquire
+#define atomic_long_cond_read_relaxed		atomic_cond_read_relaxed
+#define atomic_long_cond_read_acquire_timeout	atomic_cond_read_acquire_timeout
+#define atomic_long_cond_read_relaxed_timeout	atomic_cond_read_relaxed_timeout
 #endif
 
 /**
@@ -1809,4 +1813,4 @@ raw_atomic_long_dec_if_positive(atomic_long_t *v)
 }
 
 #endif /* _LINUX_ATOMIC_LONG_H */
-// eadf183c3600b8b92b91839dd3be6bcc560c752d
+// 475f45a880d1625faa5116dcfd6e943e4dbe1cd5
diff --git a/scripts/atomic/gen-atomic-long.sh b/scripts/atomic/gen-atomic-long.sh
index 9826be3ba986..874643dc74bd 100755
--- a/scripts/atomic/gen-atomic-long.sh
+++ b/scripts/atomic/gen-atomic-long.sh
@@ -79,14 +79,18 @@ cat << EOF
 
 #ifdef CONFIG_64BIT
 typedef atomic64_t atomic_long_t;
-#define ATOMIC_LONG_INIT(i)		ATOMIC64_INIT(i)
-#define atomic_long_cond_read_acquire	atomic64_cond_read_acquire
-#define atomic_long_cond_read_relaxed	atomic64_cond_read_relaxed
+#define ATOMIC_LONG_INIT(i)			ATOMIC64_INIT(i)
+#define atomic_long_cond_read_acquire		atomic64_cond_read_acquire
+#define atomic_long_cond_read_relaxed		atomic64_cond_read_relaxed
+#define atomic_long_cond_read_acquire_timeout	atomic64_cond_read_acquire_timeout
+#define atomic_long_cond_read_relaxed_timeout	atomic64_cond_read_relaxed_timeout
 #else
 typedef atomic_t atomic_long_t;
-#define ATOMIC_LONG_INIT(i)		ATOMIC_INIT(i)
-#define atomic_long_cond_read_acquire	atomic_cond_read_acquire
-#define atomic_long_cond_read_relaxed	atomic_cond_read_relaxed
+#define ATOMIC_LONG_INIT(i)			ATOMIC_INIT(i)
+#define atomic_long_cond_read_acquire		atomic_cond_read_acquire
+#define atomic_long_cond_read_relaxed		atomic_cond_read_relaxed
+#define atomic_long_cond_read_acquire_timeout	atomic_cond_read_acquire_timeout
+#define atomic_long_cond_read_relaxed_timeout	atomic_cond_read_relaxed_timeout
 #endif
 
 EOF
-- 
2.31.1


