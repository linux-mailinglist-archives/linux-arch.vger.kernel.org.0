Return-Path: <linux-arch+bounces-15459-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C59CC14FF
	for <lists+linux-arch@lfdr.de>; Tue, 16 Dec 2025 08:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9C3E13006713
	for <lists+linux-arch@lfdr.de>; Tue, 16 Dec 2025 07:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E05311971;
	Tue, 16 Dec 2025 07:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZUurskjK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UK/3RpcB"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605D92594B9;
	Tue, 16 Dec 2025 07:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765870489; cv=fail; b=d0smS+UX31vLP2CKagDe4vFC/FwXnhamvqE34X9RMuO6p5maYOGaFzjXS2jHK0mGUKG3VoS4wZFCcoIA0ejUDRdwzNB0xMszfOIZ+GA3jtinN8of4OqSY1R9M8NCAzW2G20qYOymld/YRmnA9kdEytRbYiHjL8TTdIubsHh/X7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765870489; c=relaxed/simple;
	bh=trlYMPIKeWN9RdsqF7bCU/c5RNBiLYYrVPo8MLIofxw=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=eoifp99M/J4+QXe2vQcQ1VbG7BSLQI5HPA5Gck9AohSAAwW3z7tDJu4hrLknSMqXHQl7kP1BqUDAPlQBA1wJ15xPVyo8k4psuIGjkVA2OOaziw999+YuTjSZt2x4tN5RkUURMibhiwuppNTK9qxCxP5yXIrshw4F8OrrTMChPg0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZUurskjK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UK/3RpcB; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BG1gXHX3442868;
	Tue, 16 Dec 2025 07:34:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=fAbrzY46z3vvxoM5JF+HTlV0gDcqie6IfuulCFGhiKY=; b=
	ZUurskjKhZj18VH/xr3eiinz7IM8yk1SWuojoJ9hC/6+5M72vMy9xIDnGPxmaRZn
	Z8mirjuRBjg9Gk/LZ462ISeWRTziNNG/XT58GdIFsKlLeo7LV4fAyKXxpAFOSUus
	dEr+97XfcHTxNK4RIzBM6prBIsbbPBQ1CEnAMPZfJdMyF/SkCdGBmWyQwOqhgPiI
	Hn1wLC8N/qR9Vx9/NcTHe83iIlghYpjcSb+hLvYgxR1sMhxR+yv4kAKdtgL/B8sI
	JlOk7up/QLuIlxVGCGIg28cmWy5zg3umbtnpMlOELtxrsHTNv+ajvYOge8je0SCO
	yXHeetXQjDt6Yj82tjtgYg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b0xja3fv9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Dec 2025 07:34:12 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BG5e9a8024758;
	Tue, 16 Dec 2025 07:34:11 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010036.outbound.protection.outlook.com [52.101.46.36])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4b0xk9wbmj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Dec 2025 07:34:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GfOdEtC29R6iqPBkEP+9AdFZmM4J/369RYm81krcqPKFg9F1fNjFg+qQsj1FlEdGPBZe4tEWpYb5KhguE8TiXdxxfXapKUcg1lypxmmcuOc6lqS/a6dbcfSRCMz8STHm2hOwqk4XEvAnoWY/84E0KKk23j5xUhIqt7IdVc4W+VYeUASRPsZ8TreAilb5b3V4yaJlAFiQT3+BxwWOw9DuDRTITaXotZJd54NvMAoIv2UyLBYjp23K2RPostHsEYmKYwrgBKDW4b55BG0+bYG0MrCa/iwV3yJMSDKFD+QICax863LlPeV82P60O1cW7G4YaNmnAZS6BbYN5N5AqQz0Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fAbrzY46z3vvxoM5JF+HTlV0gDcqie6IfuulCFGhiKY=;
 b=KLHpBeFNeDEvwLNwXdFJbLgazGQ98AlvnhXZ4K+P7Im+J1duGTAuotsjkB8TofZhoriB6NfmNToM9l/5CpVOzSKJsnchtsEYJsvdMs77J/H98xdhzbhgmUbvdVtf6N6f5WfVFB8kDp5/JESRbMCuQGSNJZrFPNPxLRo6I28P6QYYiLoUM/RUzw0RtMZAYLLIzUtN879ydsSuxGqq0dM388T5DXqQtcO6XFyRdl1fpjOqQ+mV4Zj197hUIMNpKjIQ3r605BWsCC6XMMydCv6bBcI6qDbn0RDvS0e4NpIuoOg4Md0HeYEImLH0Sl2TSSgwerCOfi4lL10mCXcQzK3BJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fAbrzY46z3vvxoM5JF+HTlV0gDcqie6IfuulCFGhiKY=;
 b=UK/3RpcBlA08xfcrzwe+s+a1SwGhVNd/BWI9GLSaHxdru3UexINMTQ56BDAXZFbeTV8+pTqylnP9GP/06KMfKAWjnMYNETWfTPXhn3CO8ZnAnJsyxWZoo6I1lPeE2+ImCztPc54K/chYEF+Nf/jDQ3uEtObRUOKS4k5Bv1ry7jI=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DS4PPFAEF42CAE1.namprd10.prod.outlook.com (2603:10b6:f:fc00::d40) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Tue, 16 Dec
 2025 07:34:08 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9412.011; Tue, 16 Dec 2025
 07:34:08 +0000
References: <20251215044919.460086-1-ankur.a.arora@oracle.com>
 <20251215044919.460086-11-ankur.a.arora@oracle.com>
 <CAADnVQKYoE85HFAOE5OBFpKbXej=h12m4DVvHuPViJSjAncK4A@mail.gmail.com>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Ankur Arora <ankur.a.arora@oracle.com>,
        LKML
 <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Power
 Management <linux-pm@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Arnd
 Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will
 Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        Andrew
 Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>, harisokn@amazon.com,
        Christoph Lameter <cl@gentwo.org>,
        Alexei Starovoitov
 <ast@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano
 <daniel.lezcano@linaro.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>, zhenglifeng1@huawei.com,
        xueshuai@linux.alibaba.com, joao.m.martins@oracle.com,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>, konrad.wilk@oracle.com
Subject: Re: [PATCH v8 10/12] bpf/rqspinlock: Use
 smp_cond_load_acquire_timeout()
In-reply-to: <CAADnVQKYoE85HFAOE5OBFpKbXej=h12m4DVvHuPViJSjAncK4A@mail.gmail.com>
Date: Mon, 15 Dec 2025 23:34:07 -0800
Message-ID: <874ipqc234.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MW4PR04CA0387.namprd04.prod.outlook.com
 (2603:10b6:303:81::32) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DS4PPFAEF42CAE1:EE_
X-MS-Office365-Filtering-Correlation-Id: c00ec338-250c-4da3-c7fe-08de3c757f84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TTlDcWNEZDBBMm1HenFZSVBqVzZMZVMzeENlTWZsTlJscjBVZStDb3ZWTyt1?=
 =?utf-8?B?VXlWbldyMzFQV05vZStsQVprMU5EdHBySXlFMGVvTTVMUGVNSGs2TWRlRmxX?=
 =?utf-8?B?VkFyZFlKS0lSNXoxdjlkRUdWaG9zcjJnSm1aTmp1OEc3Rjk4eUVROU5QdnZM?=
 =?utf-8?B?ZDhvUnVFWUx5OTIra0E2NnFhQ0xSdUp4NmpITktsZUpJTm1rVDFJVFkyeVBq?=
 =?utf-8?B?OEVxZmRSVU9CRURtRmZyMHJmaWFiVFZEVWc0UWQ5bXZVRkRjNVpCMHpkMVpQ?=
 =?utf-8?B?TlJpRzV3SmpObEcwWmxPZXpMbW1Fa0UvVkdZRm00TzdrbXhUbmpkRnlMQWZT?=
 =?utf-8?B?Sk5SU3NvVUQrZitXREs4elUzRlBWaHp4aWt6a08wOVlQZGp0R2RrUnVvWlln?=
 =?utf-8?B?K2xJcHZzK24vTmNjbzJCK2xZL1dyTG9zemJuSURwZXNGZHoyWnZuRU5wQlZa?=
 =?utf-8?B?WGt1S1R4YkhUWUE0UmFXOTNjcEZkOStMR2drcy9Zd01OeTlHRHBpdkdYc2FV?=
 =?utf-8?B?UFU4Z0RtV3dSeW5NQ052S1NXTy83aDRpdmFsOWtCSFlYWUIzNlFrQkxkZS9C?=
 =?utf-8?B?U29SRndSWjF5L01CaGxHN2xOTGUvdVVKbnhiS2pYeURxeDdGTkFVekhSOFY2?=
 =?utf-8?B?K0lWTUtEek1iU1NubWZNL0JoVGtqR0VPN2k5QXA3Q0dqdzBYMFlnL2NhV0Ju?=
 =?utf-8?B?MVJJbEFBSjlEVEJaRmpQMXJ2U2dTbFNYenV0UStTcUg1bjJ2bkZTa1Vzc1NW?=
 =?utf-8?B?MG81Y1Zja3FBQStKWWs4cGwveGw5TlM4ZVhoL3Q0SmFhbWlRdVowSWlKSmZE?=
 =?utf-8?B?ZWJKbGRmaFBTNDJBZGluZjBJYU8wRjJkM2Y2RFNqd2FQbjVPY20vTTdxSlBa?=
 =?utf-8?B?S0ZrU3dSQTRSK1VRVDJVNnREdGYwdlVVZnVRWXRXSWpJMlNHdGdrWmM3dC9m?=
 =?utf-8?B?RGxoTEU2NUEyZnZYVUVwd1JxNUF5a0t4Q0tGcWxkV3BBeGJIODN3VFpNd2tE?=
 =?utf-8?B?dXpoOG1Ob1RKUldmQUE3S3dKOU9TVGFqRENEeGN0NUpMaFRvRlJHOHlkMWJl?=
 =?utf-8?B?ODBGS3dwclR3UHBlRHBWU1VCNVhhczlQSm82dml2QktCTlZ3bGVDcStnSE4z?=
 =?utf-8?B?ako1SXppcHJZZEpDMGVabXRHNzZsM3dwVzRmNWJidFQyTkkzQitMeDFxTTF3?=
 =?utf-8?B?Tk5jaTB5aDVwMUdXWCtOQm9UYlZsSVExVXIwUkhzWEJYVWpLQ3gxRysxejJi?=
 =?utf-8?B?RHRqZU4zN1ZURTN0c2ZlZmNLejhWODNCbGVHM2dVbnAzUTRTTXFLNnBPRTFW?=
 =?utf-8?B?VmlKWnowOHVzSENaV2w4UmFSRFMrNUtTaW9jZk0rSW9ZcmtwcE85d0diNnJI?=
 =?utf-8?B?UWF3WEJPTTZpV3VTQlhESEdrak9jMk1hbkpTZjYrYW1pb2d4YU91bTVMRW9v?=
 =?utf-8?B?SVRiYVU3N3NxZzR6MUFzaTZqcktrZWV2U3BTOXJsRDVmSkpWR1Yvd0w5d3Vj?=
 =?utf-8?B?RE0vSzlaQ3V5Ukd5bFZLU0s1UVZQUVBuRkV4ZENVdzFJaGllamFLNTNBSGtG?=
 =?utf-8?B?ZFNHMHFMci9ueERQdVUyTytobUlRaE5xVzVDU1lWYnlrTHBBcmhrQjhqVElk?=
 =?utf-8?B?djl0QTExd3ZaWXdNWjhvbVdEQzZkVjRCa2twZ1R1SHl6TlQrcXp4cGgyN0Ny?=
 =?utf-8?B?dHU1Y2thWVEwak5VYStIV1FMRGZDM2tGaE8zTFMrSXlRMEZFK1FqcXV0T2I4?=
 =?utf-8?B?UmV3Z3dvc2J2c2NnVlBqUnNaQ1B1NzM2SVZSTzlhZUROQy9OT0lsVjQ0Z3hy?=
 =?utf-8?B?cGFtMjJPbGZXOU9aUzQ4UUFQMDZEdURzTk9YQzU4ekFzTmZtQ2hhK1kwU1Fq?=
 =?utf-8?B?V0ZFbXFaUmRQTjB0TG9KY01TYWd4R2tEdldsci9wZm81N2g1ZmM4aXBOTGlP?=
 =?utf-8?Q?KIfQ4UcXG9ovmsI2uN+xtuYItibh3F4j?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?azlWNXlDSCtXM1owS2kzWXo5Qi9DV1NxaFN2SHo1aTJWMmF0ZkFjTzJXNXgw?=
 =?utf-8?B?MThRejlEODVnWDRMOWoxeWFVaG5NTDZjd0ZWY3pqMVdmT2xwYXRDVW9IYlZV?=
 =?utf-8?B?WDhqWGJGSFl6cllDN1gzaUovQW1BUDFCYVdmajFZUVRiMVYveUU4Qm1pWDIz?=
 =?utf-8?B?b0c1MlVHTG5GTHQrMnhVcU1aZVo0cWpNdXkxeisveFN1QVJjK2FheEdsQ1Nv?=
 =?utf-8?B?dytUZUgxZy9ESTVQeTFrdWhaaDlXcTVQc0Ztc0JMRHZWS3E3Z1JXK2NHQ0dz?=
 =?utf-8?B?dzM0bkhaY0dMV3pocnhGbDc0Q1llcDl4TWVmSHFqWHVldGQ5WUw4dVlyMXJj?=
 =?utf-8?B?WFRpb3l2Z1MrSlc1MDJ6cDQwUSt1KzFsaDVULy9qNmxjMDB0RU82a2kyN20y?=
 =?utf-8?B?RDhkcVUwSUo4NFFTK3Q2enpDaCttRDNFVG5PM05EWWVCcTBJN0Zwd0hmeUly?=
 =?utf-8?B?bWpmcGIvaUpReVd1emg3aGQxQzhZQkRBanFBVnFyV2VmblEybmNyZGR0UC9p?=
 =?utf-8?B?T24wNVNYSSs2cEhHMkltakgvSUc0MHhtUnB0bHAwMk9nOVdUQVk4ZWVjTlE4?=
 =?utf-8?B?ZXptL2NjUWpraWNzbXJsZlBLQ2lYb0orM3A4cnlVOHI5VDQzblg2Y0RHRTdy?=
 =?utf-8?B?ZGdZUXlHd2hRN2V1K1ZIcFljU0wwQ2I5ck5VUGxPMFIxVlpia1k3a0o0STY4?=
 =?utf-8?B?NFNyaUVtZnRsWTNOU2pyaEF0NFhEMnFVRm4rU0l2WGdJMDdFaDlGN1I0ZEZL?=
 =?utf-8?B?blR0VzU0OStvTHVBSWpmYkt3c0t3MjViTXdJdFFOaVdiaTlHNy85Qk9HOEMr?=
 =?utf-8?B?d2hGMEFLdzduRGZONjB2SmdVbHdRdVJBWlZFYkkxZWMzU3ZNbXVudUtlU2pU?=
 =?utf-8?B?NkZNbzVkQVFRZ0ZoMVZuL21qdTVLeFBQUVhPdFZvTW5VQlEvaDdtamliVk01?=
 =?utf-8?B?VmlZRFFxM0I0SlBRbW1tbVUvbWlkV2tpa05wWU1yMHpzcDhCZ0RzNFRQbUZk?=
 =?utf-8?B?Zmg5OWtYS09wNk5jQVVNNnBtWUJSd2xSYVVhYlFtVm9OZXA3eGVOOC9PK25W?=
 =?utf-8?B?Y0MvTHJPdlNFWjhrWnN3RG04YlFtNVVlYmttVWE0a09GU0tLVWk1Vkpvd3dO?=
 =?utf-8?B?NkRWbkFMTFcyMU1Kd1hBTk1UaU1zbHRsNmdJZVQ5WG05akJUSjMrc3c0TVUr?=
 =?utf-8?B?N0l3RkhsQWpzWFYvVlFsMGJOWDQ1SGZSdGYyMDlSZjlYdTY5Rkw0TERUeXpI?=
 =?utf-8?B?Y0R6NWRRRHdIVnFUN0dHdHlGa2lnVmFmcUNzWm9RZFRsUnkyQlplbDRWR1pa?=
 =?utf-8?B?YjlQREJjY0E4K2VVUEJveEZPZi9oRENyeHRBT0dHUXh0S2VyMjlEckxJbm5G?=
 =?utf-8?B?eGFOTGp2WkdhSGNNVFN1Tzh6b0FvVzNHam5oSkZ6MXFrQUVXLzZIVHVrVHZL?=
 =?utf-8?B?bmY4OVhXWVVxOTRnYTYwa3hSdzNCRWlsQkFZeVBaSEdTeEdqWHpMV1lhL2dq?=
 =?utf-8?B?a09CdVFRM2VKR1dnZTl4Z1RscnNCVnRsbXljdHBDdlZyWTdEOTlkc01lV3BN?=
 =?utf-8?B?WEUzN280ZkIrY2JTK2Q4Z2pOMTlEUEZJOVZJcm1sYW53VUVjK3ZqNGlrUjd1?=
 =?utf-8?B?L1k0aEJXRk9JV0Q1ODdnVjRjYktLbE5tbjlXMFlhTVVMNkVJK21BQ2NXYjJa?=
 =?utf-8?B?RnJOYXIvdlY4QUtpdUxqb1JEcHM2YzFUS2pXM3U2UnNsQUdLd0JNdnlSZnRC?=
 =?utf-8?B?dHBKTXo5bTFNVFc0Q2NnMXZYU09jOTlJVGNkb3ZUK3Fhc3l1Ly9OWDdONE9x?=
 =?utf-8?B?bGJMblBsNHlPd3hPbUZmR1QxZmxmUkV0YXc0bkcvNVgxWndHMEJ3VG5sbjZz?=
 =?utf-8?B?bjkwYTg3Q0pPRWo4SFFERjZlZUw2K0RwMDBKZ3RVZEYvRXJQZ2VKUEtzU2Vr?=
 =?utf-8?B?MVd4RG01b1lxOVBMcE1SSU44cXRBTDF0WUpCbUQxcDE1Y1BvbEMzRW5seUFu?=
 =?utf-8?B?UEgyK3BWc2hjeEFZeWhkS1VhbWtkOUtnemY1dEhlQytRN1hFV1EvK1ovWUhG?=
 =?utf-8?B?VE4yb2svT3pVWFIxQklCRzFZdTVHREZ5OVFhb3ZRSlRicDE2YlFTZkk2VXd0?=
 =?utf-8?B?bzdZanFONWpKOGgwdVE2dS9DOGRoeFJmdHR0Z2J3SXV3eEZKQi82ZEt3ZXc5?=
 =?utf-8?B?NEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	T8EH+eOx2bdjBl3TcbiAexlIFXnCQXNfZnOfeIAK5MDlWMPNrht3aRpxNk57rWV4gWVuBfYBAcmxzyUrs+W8CoVtATfGh15IYDAyGLiZxj6wR3WQIGOBW1VETR6WFqcVuZ6OSo8jgkw9utwYaBVoU+Ayd/YFLGibOUgKySs7sm/wITWheRPa9+qG2u+fRYiDie42Fj8ku9bGi3Q4EfG0qHkZ7CQUvaFynX0A9J/MpjgK4rAjgod6S1BqZifaj4gpf3cfzmsVblO2eLGprNDsfPulQiKSUT54PTGNZhSgMq9nWe8LNwgRCxPF9RjaXmGS6+PZFg2Jm0dJukikqqMIhoxT8e4oTTYOu8mZHfmjxHGhi3S0s70bTmEy2uYo6YV0ZrGk3TtAAvHhhghrKKRjeRWS2RMjqObjRkphfAQxv2AGz+bN3mBCP56GYPjBI0uV+nzIglbrHhVqkHLVntayZYKCe6eI2BJXOtTi2DMQd7tdeiK1qXis0Rsv8YU/R73da58G5MLYfngFPX1q12jpg3S3QFGnnHdDst8eRzS1ZviKIl6Zv/RDK+boniGhYcHPWiqucVe7cKLP7uy+VDvr/nk67ingELGmRKigK6ymLb4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c00ec338-250c-4da3-c7fe-08de3c757f84
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 07:34:08.3038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0cc8DARy6ED0Qo1ahwaaDHE8eKAevWkY56ct42eshIP3uckfrst4Q6qRK8qNp9w3r1f9XYOpYQxOWchsnyi+fknboGB/awygMk8VVrkrChM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFAEF42CAE1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-16_01,2025-12-15_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512160061
X-Authority-Analysis: v=2.4 cv=TbWbdBQh c=1 sm=1 tr=0 ts=69410b74 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8 a=45ocHdjcDIs8bpFY1qgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE2MDA2MSBTYWx0ZWRfX1QtXvUS4sKSc
 h+xSZOhtwYHjbvVH41eHgtU5o2GcHpXYi962LGTqbR7MTqJsA/3iurKFJ+g1XxhSbH7dvkGsImi
 juQZi5GNt7wTKSNYswQjMyGbA7tA1nZtDd4lTAUgHlW8lIBbww6OH4ccl2FghPqDGOuDRlAsBu6
 MB3r+vWgoJ0xiueWu/NCOizLMAqBwHQZ4wunsl47e65OVKzLH+yXLWY/CI2r703+mIjARtybhRF
 CxP2l8zth2K4929sKf9ewrhkjLYK51m3d1G6AK1TXzoathv2L5PvRR4LwSnnITcTAnD4s4/tvuc
 yE2E8qBveQkB7mtpCWzfWqK6I0B1LL6wUHm5ASQLLVdUvJN7ZY6pWNe4aeqdSqtvF1YQ6qmm9m/
 Vvkr/3CEQ9i8KMZHr5KHrpqLtdPUrg==
X-Proofpoint-ORIG-GUID: VDhtVfjL7KKhnjgGlzYbXpaj2XdrS4YJ
X-Proofpoint-GUID: VDhtVfjL7KKhnjgGlzYbXpaj2XdrS4YJ


Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Sun, Dec 14, 2025 at 8:51=E2=80=AFPM Ankur Arora <ankur.a.arora@oracle=
.com> wrote:
>>
>>  /**
>>   * resilient_queued_spin_lock_slowpath - acquire the queued spinlock
>>   * @lock: Pointer to queued spinlock structure
>> @@ -415,7 +415,9 @@ int __lockfunc resilient_queued_spin_lock_slowpath(r=
qspinlock_t *lock, u32 val)
>>          */
>>         if (val & _Q_LOCKED_MASK) {
>>                 RES_RESET_TIMEOUT(ts, RES_DEF_TIMEOUT);
>> -               res_smp_cond_load_acquire(&lock->locked, !VAL || RES_CHE=
CK_TIMEOUT(ts, timeout_err, _Q_LOCKED_MASK) < 0);
>> +               smp_cond_load_acquire_timeout(&lock->locked, !VAL,
>> +                                             (timeout_err =3D clock_dea=
dlock(lock, _Q_LOCKED_MASK, &ts)),
>> +                                             ts.duration);
>
> I'm pretty sure we already discussed this and pointed out that
> this approach is not acceptable.

Where? I don't see any mail on this at all.

In any case your technical point below is quite reasonable. It's better
to lead with that instead of peremptorily declaring what you find
acceptable and what not.

> We cannot call ktime_get_mono_fast_ns() first.
> That's why RES_CHECK_TIMEOUT() exists and it does
> if (!(ts).spin++)
> before doing the first check_timeout() that will do ktime_get_mono_fast_n=
s().
> Above is a performance critical lock acquisition path where
> pending is spinning on the lock word waiting for the owner to
> release the lock.
> Adding unconditional ktime_get_mono_fast_ns() will destroy
> performance for quick critical section.

Yes that makes sense.

This is not ideal, but how about something like this:

  #define smp_cond_load_relaxed_timeout(ptr, cond_expr,                 \
                                      time_expr_ns, timeout_ns)         \
  ({                                                                    \
        typeof(ptr) __PTR =3D (ptr);                                      \
        __unqual_scalar_typeof(*ptr) VAL;                               \
        u32 __n =3D 0, __spin =3D SMP_TIMEOUT_POLL_COUNT;                  =
 \
        s64 __timeout =3D (s64)timeout_ns;                                \
        s64 __time_now, __time_end =3D 0;                                 \
                                                                        \
        for (;;) {                                                      \
                VAL =3D READ_ONCE(*__PTR);                                \
                if (cond_expr)                                          \
                        break;                                          \
                cpu_poll_relax(__PTR, VAL, __timeout);                  \
                if (++__n < __spin)                                     \
                        continue;                                       \
                __time_now =3D (s64)(time_expr_ns);                       \
                if (unlikely(__time_end =3D=3D 0))                         =
 \
                        __time_end =3D __time_now + __timeout;            \
                __timeout =3D __time_end - __time_now;                    \
                if (__time_now <=3D 0 || __timeout <=3D 0) {               =
 \
                        VAL =3D READ_ONCE(*__PTR);                        \
                        break;                                          \
                }                                                       \
                __n =3D 0;                                                \
        }                                                               \
                                                                        \
        (typeof(*ptr))VAL;                                              \
  })

The problem with this version is that there's no way to know how much
time has passed in the first cpu_poll_relax()). So for the waiting case
this has a builtin overshoot of up to __timeout for the WFET case.
And ~100us for WFE and ~2us for x86 cpu_relax.

Of course we could specify a small __timeout value for the first iteration
which would help WFET.

Anyway let me take another look at this tomorrow.

But, that is more complexity.

Opinions?

--
ankur

