Return-Path: <linux-arch+bounces-13326-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D3BB3B59D
	for <lists+linux-arch@lfdr.de>; Fri, 29 Aug 2025 10:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EAF41BA01F0
	for <lists+linux-arch@lfdr.de>; Fri, 29 Aug 2025 08:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6679929ACD8;
	Fri, 29 Aug 2025 08:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YFbnOEGE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Nn47keV+"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD1128AB16;
	Fri, 29 Aug 2025 08:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756455198; cv=fail; b=rpnuAMgRS5Jp7VLzv8P6WL474auG2lwr5fb2ka6bcAPwSoMU/i03yai4sVfxmAfphoDbdFQCLuxl4Y9mxbg0CtyjLbb3XbgN8LTR+Ah1kTs/nV90y9oaXi16v4uhonoSw4TKi4+x67RstNqztBgePmFaULo5tsnrkOOnPGT8Aog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756455198; c=relaxed/simple;
	bh=lY7h91zI+h4Tb10mYsaxkkN0TR2qL3zh5CmfgdO7d10=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I+qjwkeH7qCmgbCpXVPyd2GKW96mdTvcM2dNbNq3ZGdxf97O/DWaoo9hv3s5mXitI/wvK4hMBqbYpXWHhFGNXECHr3FEmrUJfwj3SuWA8wO5BKzqaaqhCeHRFHEDxhvv/QWLQQfsEb+hAlY8KkfK50OXFFOi3aNCPDNzP8B6c0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YFbnOEGE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Nn47keV+; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57T8469Y009484;
	Fri, 29 Aug 2025 08:07:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=nrGLxqdv1Kv9bpzRL/VUYCiz5QIRxusPb3VYRtQxtG4=; b=
	YFbnOEGEvfWnJZg34KpHj+R9QLdYvW+JwuKtjkYs5arhPvxkCo8MjQYgn3Krwv8Z
	KZdKpXmoVW1QQ+UvtqGE2kpsGSaPCl4+LxwFSWL9luEAv8tPa5K1w0hpNa0AZhZB
	5mEWSc/IPlPUQaAbluJXDOqVD5P2IS9wZmzAmqU3FkaRkZXnPQL3CyHaFAEFjzrH
	xX6s/vTrGc6tTyOwdg4KZjctdF8CTgJebquUOWKp8Xa8wsDe+ad+VRO8Lr/2/EEZ
	oyw6c8fdCk4k9+B7sVI0/avasbI65x3DKKRw/Zm0HJPYBndZFvgOOLvY+czSxr02
	DlxZYpw8PIQmVMbyK+xBjg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48r8twgqkb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Aug 2025 08:07:54 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57T7j8LN014642;
	Fri, 29 Aug 2025 08:07:52 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48q43cv9d3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Aug 2025 08:07:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TRWNW95gQiNSFDm2og5blse/QlYrBh+FF1SB2IK0voauExxcZfSkunR+CCBwR5x2Ndjs5ODo4Jd0OfQMsX8MfwxII8ZZKZRwzFqePH9ICsX4ayCB0hAH4LvEnphVx64uMLenNkk05GPeE0ju8ZRFd4YVGsSmN6B1SD78Ic5HOSuwCP5Zh0gNoG0Nu5WaBMATHE8CMelyBINzoCz77otVhR9y/qjFhENzJUmpn2YMWSg2i/mb2MRRuvBmLX8O6l11FUM6bg322MyMGb2OTCm2zlQBCgihZcgKoTA82h/1j2ZAzEJA6IcubJQW2TWEmNQpgigwGxEK6iRHadm/ppqTwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nrGLxqdv1Kv9bpzRL/VUYCiz5QIRxusPb3VYRtQxtG4=;
 b=fy2Vo6FLMB7fYV93m0LxN2FIAlCLqfFADvU0hdn7alX3f7pzxX3jqfBacBuZbu3V28vhjdYEhzgTlrkO2EQw6GoJF7PftuZ1DHV3HFi+kmeO2297WmJCM1n3T0MBxqAUUFViXm1gASDxMpWKHeFYYnDylgH/zXTB6z/alkBjT1wXM2MFtEceGFblvSLkoLtEBpmtAjdxAUuuocmJgDs0z6qFROfAyE//PsUccCVTmyISZMAzypw2vYHc+kSJFJfSITHT2IXlQVcn/jmeo00jWz19dR63ThvQ1jv9yHc3p/PTja1dZJR7v36KgRrpz8/T0XVJqKA58SqDL/h4vnb1lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nrGLxqdv1Kv9bpzRL/VUYCiz5QIRxusPb3VYRtQxtG4=;
 b=Nn47keV+e5ymwifJ+/EV0f5v1nf0FSmgTdFKZ9BKTEgM4uua9y8sOXQq4r0icNW3dRQxL1bhlWXgdH15WtBVICJ9rVoCC+/mJobbwmq7Jq5sQII3daYr7BLQfpSJmngn8guUO+fzyv4MoQmcqCPVgGZWSphHnL0ZqbkmCuCzOyI=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by MN0PR10MB6008.namprd10.prod.outlook.com (2603:10b6:208:3c8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Fri, 29 Aug
 2025 08:07:47 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9052.013; Fri, 29 Aug 2025
 08:07:46 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Cc: arnd@arndb.de, catalin.marinas@arm.com, will@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org, mark.rutland@arm.com,
        harisokn@amazon.com, cl@gentwo.org, ast@kernel.org, memxor@gmail.com,
        zhenglifeng1@huawei.com, xueshuai@linux.alibaba.com,
        joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com
Subject: [PATCH v4 4/5] asm-generic: barrier: Add smp_cond_load_acquire_timewait()
Date: Fri, 29 Aug 2025 01:07:34 -0700
Message-Id: <20250829080735.3598416-5-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250829080735.3598416-1-ankur.a.arora@oracle.com>
References: <20250829080735.3598416-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0179.namprd03.prod.outlook.com
 (2603:10b6:303:8d::34) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|MN0PR10MB6008:EE_
X-MS-Office365-Filtering-Correlation-Id: c18e9481-e838-40ea-6bed-08dde6d3231a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TlUhuZZlICyKcq5zoJJlZcCkpF5JmQZCnuV4qCbK6/Aquw38O7bZSo+d/8oy?=
 =?us-ascii?Q?YLL0uFuc25HevHV13F8m0t+6uYjFclEo7Ih7Y6aQGDXkZaIBsFhX2ouC4iBp?=
 =?us-ascii?Q?caQqUf+9fAzvnMNCY2SAYJcmgxfCBWX6L2t0IUxva25mleTc8yvL2PASgvrj?=
 =?us-ascii?Q?JnThSNWkRHb4ZTGsAxFeWxtaokoTQpC6DnxS/vHc9O6cK/8nUAdZ0Ejln8Fl?=
 =?us-ascii?Q?PN6tmOCrzC+rLp4vxLlXAJutCXainrULXtuwKzsagIh2eHCk5dQaPiRr9agr?=
 =?us-ascii?Q?6sB6cBjQRUJObnXqZipeRdobLdn7d4CjXPCj39v43b7NuPpVtrVWNNJ+NxVT?=
 =?us-ascii?Q?dT1biDQJtHDF0dmfKnpJJWpqdjFI3AD7GRHD/B1bM+KPcHC2tn8ih1kAZ1D+?=
 =?us-ascii?Q?8j1eBar2QQ7OQKVdeL0dy47goxwraFxOGR/SOr+2pqKyye1eU+tzuSD8dlX5?=
 =?us-ascii?Q?bwPqhpZ5W2o1/dVlvDipBJG+sDnWAtflWjL0wUZJZk8/0A8Y4YZYmc3WRSA6?=
 =?us-ascii?Q?a6mRP6l5xEBSrJBzzZlNzqFHUvFlA09QwLkzfBmnKMBSWnAQKC2viix6/yYE?=
 =?us-ascii?Q?1qmN0UW1YRbXIpg0+ZJbpNETOBzTM+ck7y5K1V/Mb+ejLQnOH166/H2nuDKD?=
 =?us-ascii?Q?fVrrrFRpg+NYh9ANMm4t5p3fJIwYyC6t0tYH2Ou91dGWK8734/EiM9V6QCRK?=
 =?us-ascii?Q?+eJx9kQdTbhhYJDKlAoKXUxS9GnLHKaCEdFkVi4tn3SCKgBri6kwC/lSgwsL?=
 =?us-ascii?Q?TGOCt9WrPAf+sBJg95Cggj5do4WReGmMSyvDDZQwp+Zm0tza/tqjfgfGD9jg?=
 =?us-ascii?Q?2sDmykZbnVsUO72vRbxFJ/cKlCgJDdaAySXjRu0rM/MPmJZMbXLoezDV9xpo?=
 =?us-ascii?Q?M0irbZ6WL6w+02OOaNAbZLf7Lvt6oVbx5OkIcUnmWJTxymWgmhLU/F11XMw7?=
 =?us-ascii?Q?HrN2vrYTZZ+zvrr7IU/UKOTRICYlhzBv0Khj1Uef/bI8ewNUIlnS9CCuSO3v?=
 =?us-ascii?Q?jtMlQ5KFs4f+saIlc2uwFKA7GzTcOek/Gi5Rq+GLtS9EkOxHrM5V2hTIUkM1?=
 =?us-ascii?Q?e9Inyco8hO5NEBgIOldXUZM8KEi+SDKtfCIy00Ehu4NsBtVN0olMfVvEH+kU?=
 =?us-ascii?Q?wHA0i7P9KCpXilDGPFFR/hIDzETMPuuFJFi5cALQS/4jk3XoDgSGkoWXW7JC?=
 =?us-ascii?Q?2mERGF7cNAh5dB2BA0D/mn4wPexZ6I7TIss1FPxHRcT4Snn2W8LYJsketiXo?=
 =?us-ascii?Q?147h+B9/igdLkjax4j5vJFimCkt2UbyPfeKa1ZVBqn3wsmWUci4aY4eDvt0c?=
 =?us-ascii?Q?wiSnctm22Jf5TA1568HIa30o1dNEYkqTNAI1l2b3YuABH3KHugxfnHy50Fp6?=
 =?us-ascii?Q?xcumlfJEa9mdv6waNV+vf8rXxDoMGAb3xFW74j1VgMr8AJNzU2z/h3dNt5+s?=
 =?us-ascii?Q?Hes+9+DQjww=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YzKbzHePNAVkvIeWp2/PieeUl9W+SsGxrYCBAoTOActRga8N8X8Bm/wMAbUo?=
 =?us-ascii?Q?8jWgvCEuKVfsiFIlJGwtUiT/Osa18LA+vrrEE4LTLPTsmFUkcK0GMP1JxnlQ?=
 =?us-ascii?Q?9/LKM9dxVWYN1c10BH1jb2ROoFsgrKqq3plTbTVZSPKb/hZn3rRHzF4rV9bJ?=
 =?us-ascii?Q?kNi1nOEkdJtTHhxljhT43GkTZil+GMAhuE9oQOaRUogUYRLZA3S3Kv07rp8X?=
 =?us-ascii?Q?S18DfK5850Rn2mPaBk8wRmA9qvkQQTy7qOpFrS1QwYU+Oangy5h2+UyFQ90o?=
 =?us-ascii?Q?IjO20+njpjJ3PfDhF6atu26ZEvbvAudJ5qrQpB/ecXCb8Go02R0W2f7sg7SN?=
 =?us-ascii?Q?2VwXsXvvLVBTGvDXuOhTu0oIj4jpXp50b5GmllDd8KgKs7FbC57tKuqanUJn?=
 =?us-ascii?Q?GqOvnH7i9+OjJkPUvHiDY9BZSUOBgIZ2ORTbR08aXAdP57DlQKz9YsQUdXdN?=
 =?us-ascii?Q?Dm6oinppfKmcgrA0bUljHuCzAX2bAFlnvXvOk97rxH86DzyHk95aln0pnOoC?=
 =?us-ascii?Q?rAu3vpu7v2477qfoh/jbNjjF8+ScATbIQ+CyeOQ9wh8d/Azy1xDMKGgNYfT1?=
 =?us-ascii?Q?PlVj7K7kUeBnCG0I8P+4DM5g6LZ4/0iOGfaWlI4JrpuljQvxJ5B8Arr6ZXJN?=
 =?us-ascii?Q?NBCXEki5a95JUcjhYVE/4+SHYkduHuuVbJImHcBSKaNT9110M3MlR3cHY5BN?=
 =?us-ascii?Q?UffaLCbC91oaqPiZpLVyORTCzRebVrcwJQWAazjKURaa0gSbphslABQkeHvn?=
 =?us-ascii?Q?ZDi0j+z//LMnUHVr7aYZissuTf8DRH7tKYFQ/OsNRFnQQIHmUy8pVX2XG6A1?=
 =?us-ascii?Q?QyCLkomWf7PDeTd3kZTdDW2te0/vIV58vNhM6kMd2E4zXmIv55G9Wad+SeI2?=
 =?us-ascii?Q?BYX/sf1yOmf+8/x7w0DrdelPauqwRbqCeJd4KSGPvzwMs+ZXgMLfKVgVrcyJ?=
 =?us-ascii?Q?ywkBfV8x1tys13wlv4ENciGUW8rxCSszA8Fn396Vfj7Tn1Vyx1uK2iPJ1ln+?=
 =?us-ascii?Q?vSZmHJJV1mSei9l6yJtGqyK5DnnMLpQVKmNL/0Ks7prVkHI2uUsYYRqBoVv/?=
 =?us-ascii?Q?cVQvMMLMAHKvoU4OVnSEb/h+Vu3IDQwWQ758SQCTpXA8Tvfo30pmcghsPzm2?=
 =?us-ascii?Q?c3IetVRxEKmZfdKmWU99Njl2+YMdAFPrRpMeMKvLqw0s6LqgLw4219ozfkOr?=
 =?us-ascii?Q?V/HbUSbqgyfw1NrM3sj4WKcU6bjSGjEr2YEJO6IqrnxHYPlHeODKJp79hneT?=
 =?us-ascii?Q?FNDC7ZQmIVeYnyOshB4s4QIBl9xTu6R7QQ1VU0UyMafZC7NbCBRxvWVWNaYJ?=
 =?us-ascii?Q?xcsB0nOX/NmRD7XtdAHMXKIftMkZhcG3mOi6IQO6cWuux1bgqZsqxg4wfcZL?=
 =?us-ascii?Q?WzrhPYEpEJ89vVJvEtrFPlk1napM1JBS87Fnh0EfS45rO6nLwsRhnA1D5XqH?=
 =?us-ascii?Q?1c0KlsJJF70Lv4zaO1PZjBJ0655opNwnO3M2m+r2SKyJ/2hv1GscK/lf2csY?=
 =?us-ascii?Q?tyPsudHwpQ246RhLIRVUQMAYrE4tF5oCfRjXbnPcBeezw7MnKYqI+5a1InU5?=
 =?us-ascii?Q?mgcah0DSAd8GYgBoQVsVcI7dGgqBfV+egxsDFNp6zcsszlmA92UpfzM/T8c9?=
 =?us-ascii?Q?dw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Y3MxKmT/HoKu19jikUnZr8HFbKUbE5zLDyzDtLxn7pkim8SRaYd3ErInvEXrSbxqDOG6jXPvzBhC4yrGMK9CQR6hWkSMRVvoB+aQYxIDuxs4Ykc+eRNgsG+pC2jyAn14wYM7tctK3I+ZYXeVoP5r0GARFNPv3OUlzvCmnik/RbP2Xw7yNOHykZjxzTiqug3G2V02w42sCLvxjMumjRFKI4PEIOimvwRtrmMrMZd86vYzJZQN0IJPTEFggRtk7ablGPQx61ZE+lpP572INVn/QgubKoLAieF1ErnLKbgoxGV8GDcxqnVhlHELWyMTfT5XCPRNbKUGPw0nxpWlirnIxC1Hb3QciJBibO8Z0kvfZDGxSyidGMkQ6VR9fqwEuA2uCIK4x4uIZIcqvtZ7GldEzyxhSK+i/qnFEWUfaM8/ep/UhV8R97tdsp2IY6myhC5D4qbJ5B9XtktKVJqG5pBcjcbiPfq3fdoUl5N9amcrRotbfUQDccfrRneIDapznlP8KX852inDA1WKcy6MlvHFEbFnXSeFnuGAN3HxFbYyKaakglhrjECxy3BOrY+XEpO7ymUzlQyZ395l3QvqCB455oB6Q6g72BlTdX8sHaBbTAQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c18e9481-e838-40ea-6bed-08dde6d3231a
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 08:07:46.8990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /M3kU0ouFoA1jwGsDWqMberUWAeLdRzWIiCWIBPX6ZdCdVUR/7g11W8MMT0YagPfZVXNDJMczvF9BshKLg0ResXOZE5aiU/p/BSqJIbohXY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB6008
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-29_02,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 bulkscore=0 phishscore=0 adultscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508290066
X-Proofpoint-ORIG-GUID: VnjpFRP9dYhLdhUuJAb3mwJuZgruhBFt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI0MDE4NCBTYWx0ZWRfX135wFIO+JC2p
 dyvWmMv19iE64hcQ5RZUNrfIuEVm/q2Q39DtP/bmIDwPTMSgdNpGzfQnogv9zxXbz6LOmu8dIxX
 sU7Rd10wYsHrroc8qx/mbonKrsWvpaNoa4+S9f5Unejj7253K6/TnzkfCd+kgvEgjsBIzKD1dwB
 oaOVCnirIG1I1Qv1ltWCabRe6TlyPxRosuCh5DVTqDmRj4js8MhuhjkgQPTb3p/CKn5eKF7xqyc
 Yjx+nwhkkk53EEx36cWceOfWbqi0A2g59qI09CQmCO0faq/UeQGZgvT4k6bU7J6XEFK4hTF0kbZ
 XyWgoPHW8JfgK0h+rLyHpLr6z7ZAiHnJ5mCJ/nNLK2bBh69WYQ8bnKNW33spEqi0tJfQNacJj5H
 Vex1PFT+OOno3fPra9oN67MKP1v3bA==
X-Proofpoint-GUID: VnjpFRP9dYhLdhUuJAb3mwJuZgruhBFt
X-Authority-Analysis: v=2.4 cv=IciHWXqa c=1 sm=1 tr=0 ts=68b15fda b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=2OwXVqhp2XgA:10
 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=JfrnYn6hAAAA:8
 a=yPCof4ZbAAAA:8 a=MLEp7nxARRIokO7p85AA:9 a=a-qgeE7W1pNrGK8U0ZQC:22
 a=1CNFftbPRP8L7MoqJWF3:22 cc=ntf awl=host:13602

Add the acquire variant of smp_cond_load_relaxed_timewait(). This
reuses the relaxed variant, with an additional LOAD->LOAD
ordering.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-arch@vger.kernel.org
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 include/asm-generic/barrier.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
index c87d6fd8746f..58e510e37b87 100644
--- a/include/asm-generic/barrier.h
+++ b/include/asm-generic/barrier.h
@@ -308,6 +308,28 @@ do {									\
 })
 #endif
 
+/**
+ * smp_cond_load_acquire_timewait() - (Spin) wait for cond with ACQUIRE ordering
+ * until a timeout expires.
+ *
+ * Arguments: same as smp_cond_load_relaxed_timeout().
+ *
+ * Equivalent to using smp_cond_load_acquire() on the condition variable with
+ * a timeout.
+ */
+#ifndef smp_cond_load_acquire_timewait
+#define smp_cond_load_acquire_timewait(ptr, cond_expr, time_check_expr)	\
+({									\
+	__unqual_scalar_typeof(*ptr) _val;				\
+	_val = smp_cond_load_relaxed_timewait(ptr, cond_expr,		\
+					      time_check_expr);		\
+									\
+	/* Depends on the control dependency of the wait above. */	\
+	smp_acquire__after_ctrl_dep();					\
+	(typeof(*ptr))_val;						\
+})
+#endif
+
 /*
  * pmem_wmb() ensures that all stores for which the modification
  * are written to persistent storage by preceding instructions have
-- 
2.31.1


