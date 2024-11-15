Return-Path: <linux-arch+bounces-9107-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6401A9CCCD1
	for <lists+linux-arch@lfdr.de>; Fri, 15 Nov 2024 01:29:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E53941F22C47
	for <lists+linux-arch@lfdr.de>; Fri, 15 Nov 2024 00:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E381DFFD;
	Fri, 15 Nov 2024 00:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ymt7mxsu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xUD6v1vZ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CDA524C;
	Fri, 15 Nov 2024 00:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731630556; cv=fail; b=cOyOyhM1EWbe9BbpMfgWIWjzlH6zsi9wDR+eXJubd37abTXTNOERPk+E2JtH+21eqYG2fsXRLSiTeUJcSDlfAqsokPCoNAnwZ7UGrtigEubnYBxXNdgUCJkJfo7eNFCyX9lVjZLwjPqoiYdkdQEufLMHC7l6rdvClys2kjTEu4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731630556; c=relaxed/simple;
	bh=H7PBpajoypsK2DMXLUw1Eao3lK2IEZhcUaezR+b+D+k=;
	h=References:From:To:Cc:Subject:In-reply-to:Message-ID:Date:
	 Content-Type:MIME-Version; b=Xi1v0meZqNSMfcTLUHf1c5PeyAof9xL0NS4xymtjq7UvPENHTPsI51qMJaBCv9pWBUI4wFWoShWshP2CsJKoBngiUHtDTMFTgh5YyY/U0mOhzE6F1lDhQxlFsZKugp9+YVRjCqDyt/+dYPxlStOXslpoa1c3PDf6JdLVizZfl7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ymt7mxsu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xUD6v1vZ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AEMBVwT001958;
	Fri, 15 Nov 2024 00:28:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=H7PBpajoypsK2DMXLU
	w1Eao3lK2IEZhcUaezR+b+D+k=; b=Ymt7mxsuEb7sc/NGvebf96kA1eNr7GAZTG
	v0FbRdlQLeuaExnDgMDBWMrkOpLvRmIBEZDKlbUtcsLzEVgM/249UMJjmPAl1OhH
	87ntzSesg0nqeN9W5L4iIVT1sSFa5nK+oV0f5UG2DgUfeN5HaBBuP0fPKdP7LeBH
	AbhEVp+22Xo/sZz7G+cZsahoLkqKOKFxJohJR2ocNoO88EgXnheAFpxVeO9BZDaC
	8U3m9q/xbL9twXtz9QcY8mLRaVyntW4A2CswPZwpeL5yZVLg7P/9Lq+BQnO2WUJK
	QNFSkH8qwrBMeA5MYWA5xxBsghYcDsoEjN0uJDkUt0nrX09i78Gg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0k2aee5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 00:28:19 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AEMMaV3035876;
	Fri, 15 Nov 2024 00:28:18 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2046.outbound.protection.outlook.com [104.47.73.46])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42sx6bjhr0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 00:28:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sr5vuMQ5nqhwlSI6zC8295WjkYVRNiBh5guawC4+dnHha3Pb/LMxrM3nBXh+1tN3HirzQe+49hue6hD0Rs0pF6ieqarPWRdy08Awf/STqNM4wU0mJx0uwxyUgyfwBy80TwDSAzSxlAO5aQGC9OkFJhAb+Sssm6XMXIEXjI5pHPVK3rC7pPGcaPYqyPu8+E7OKs6+kSYGxTF65YMhG0tvxCnzLSUniusNnaEQNE8xRoZeSIVz9KfxWItXCdq+Rfo0wSIFAyWJl7ItvaqkBAAK+NIIgIpJdB15IBCngM5WanH2dKoEstayVzOcWp+vDc4F5bIJdDiS2Z40vhG67AumdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H7PBpajoypsK2DMXLUw1Eao3lK2IEZhcUaezR+b+D+k=;
 b=smffqGUpFim0TWNnQ4LsDKGjlgAHzQM5qym5tmqnwfp8XCS7ez7r7r3grbUPyEZeP1+DkciYaZL9RnCbtu18vQziuNjmBX68XgwbfdVGB6X6iK2phpuWvo6x49UZ197uhKnNwadixjPwPn6GNn09pjYsDxJ/21E0xaHk3HGp7UZPHvQw7vbIygylj+Snd1GfrXb6i7iHT3r86HerLB/El3xgsTk+DFYs7xNsz+4GYR4wOoUfUzeYkgbHjYDDooL7Zgc+FSMEVnCjRTO9fxlpGp059599csDMtiDt3YKXGCI02OeBqTJ5seyGapE4Mi3pF9qRlVIXBfuMElYnO8Qd3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H7PBpajoypsK2DMXLUw1Eao3lK2IEZhcUaezR+b+D+k=;
 b=xUD6v1vZB/rLUvv5YRTS+hu5+LnA8eZCDQ+DC4LtV60B0zcf9nNQY40qkiR7BJa0PuGeg8BFkIYYu74oU+Y0q3FyPczuxyXPvB67Vz4HL5CgHMlmWIPG58LyRdwngFSGRFWWETitFnWVEAYBss1/6CcWLdSXouCcAVNcZk4yUMQ=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DM4PR10MB6254.namprd10.prod.outlook.com (2603:10b6:8:8f::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.17; Fri, 15 Nov 2024 00:28:15 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%5]) with mapi id 15.20.8158.013; Fri, 15 Nov 2024
 00:28:15 +0000
References: <20241107190818.522639-1-ankur.a.arora@oracle.com>
 <20241107190818.522639-2-ankur.a.arora@oracle.com>
 <9cecd8a5-82e5-69ef-502b-45219a45006b@gentwo.org>
 <87v7wy2mbi.fsf@oracle.com>
 <88b3b176-97c7-201e-0f89-c77f1802ffd9@gentwo.org>
 <ZzYxv2RfDwegDMEf@arm.com>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: "Christoph Lameter (Ampere)" <cl@gentwo.org>,
        Ankur Arora
 <ankur.a.arora@oracle.com>, linux-pm@vger.kernel.org,
        kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        will@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        pbonzini@redhat.com, vkuznets@redhat.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, peterz@infradead.org, arnd@arndb.de,
        lenb@kernel.org, mark.rutland@arm.com, harisokn@amazon.com,
        mtosatti@redhat.com, sudeep.holla@arm.com, maz@kernel.org,
        misono.tomohiro@fujitsu.com, maobibo@loongson.cn,
        zhenglifeng1@huawei.com, joao.m.martins@oracle.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH v9 01/15] asm-generic: add barrier
 smp_cond_load_relaxed_timeout()
In-reply-to: <ZzYxv2RfDwegDMEf@arm.com>
Message-ID: <87bjyhpcgz.fsf@oracle.com>
Date: Thu, 14 Nov 2024 16:28:12 -0800
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0198.namprd03.prod.outlook.com
 (2603:10b6:303:b8::23) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DM4PR10MB6254:EE_
X-MS-Office365-Filtering-Correlation-Id: 46f75d19-53da-4fd2-6f42-08dd050c649c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?H7KZJ08Gli8Gzc+4SqrYZcKMhZgn2+zu4N+HjUqhMjR1mIfuvHuJd63sXj3m?=
 =?us-ascii?Q?UJtQ7CDhMFbg3tgUwXYpa7+yxQp1WLwM0DrE+uVVIc6sV3bycIFCq4+r64t3?=
 =?us-ascii?Q?Mvr2XzX8+tQ+Np6l11fefLdf3mekJHu8oy1CikhAe3WebKiiFI5nTbaBNFes?=
 =?us-ascii?Q?O3bpWKie/jSeUfgw/x3SGwERmvuwIyS8UZMCHRSxPd5amOp4FQNf61cK6YpW?=
 =?us-ascii?Q?jXwze9AlnRozi2EQDxQ4PVMm7n6csI/ji1Qzr89drBjx2zhN7E3w1r5poItR?=
 =?us-ascii?Q?wvciG3WyTqg8okn2XWe6IpVMfPj0P4lTtTaTPW7yXKwzqDaM15bgbrpMCZGC?=
 =?us-ascii?Q?/yhuS2UELXfATkf30VyZKNoQLThKLEMOHqrfjl1ZKvC0/RxjxHan5M0aF+r3?=
 =?us-ascii?Q?ZJrMFzEcIbjiQcvNw8C2kqe2+p38+YK3fE60XoggUFeU6D3KlZ/cIcj2OpYS?=
 =?us-ascii?Q?zm3d/sgGH/MMp9liIBRn/jkfvQC63i7eDhjIE+RwEx7GPfikYBC567HGGsFk?=
 =?us-ascii?Q?dxkby2r0XhNc7GaErxFCXbE3Srogo2XIZu50oPjH5XSBo+lTh4zRYQvcR4Mx?=
 =?us-ascii?Q?Q3jxDc5ZgDhkMOd85mz5vsiO5WKZGr/zgJ4hFGutzNeFwX87Kmze7Nhnp6Cf?=
 =?us-ascii?Q?Cyj+o8CpT1VplJwYVh5aRplIYeS9S2fy14azGwDDFKmoa/C+oyIyE6uMmkaf?=
 =?us-ascii?Q?22t+inxCgjnRPCyobaAkFv9wrfOLobmvxZZ8NUetRB8ejYi4m25ew2pvIUyW?=
 =?us-ascii?Q?7F0bP0COGGU4Nlx0umuedLBmhsGOkE1DI6/oJusYp1qgfETX5TfNk8uJXerG?=
 =?us-ascii?Q?ljIqwvv8ZNxYb/YtS+Kwb6IptMMxSAnYVuE+za588EZ1KXzs1Wpm7z0fJdkq?=
 =?us-ascii?Q?fsu1AernzZvtxUj5u4jw8GKYRVpVCNECgY3JkJ7nnG2XwK03BghvcTynG+HB?=
 =?us-ascii?Q?pY5wggUoaGfO27C0z8pCHSPiB8+AdHM25VpkhOf23xPr8+wLzlm5ZWos9/vK?=
 =?us-ascii?Q?bNDa95HiZKAJscyG7AiuOOku7Xpf8Jso7M0qpb2PD5mdTv1DBN3huu7PBQrQ?=
 =?us-ascii?Q?Jpu5aP/V3oDKzyiNiGoSh37ZkX3MdkYo0pFyjOme84tpnj/jg9rCEygdnAIO?=
 =?us-ascii?Q?iy80+TeexRuO0BDbPl140h+dR/XiWdozRbHOPYPZ8PAVHNwSfCqK+ItTCJ4x?=
 =?us-ascii?Q?yz7PeEf/qbcY1IsMRwqi+KCsDmYrK4u56XKwqbxvCTdbUAvm6CFnU5Kstuf8?=
 =?us-ascii?Q?cXqp3f7dSCozLR9VlWyGDuH+n2dp4jv0JZgoGN/kYlRTx8k1lIjDFHYWnoq2?=
 =?us-ascii?Q?ySlpyOyGKxgPE94UpfHODJPF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tsba99cKjHQnqiFwDvGQKDx3jPczrqrBaLX68IoJriETOp+KNCuP+xepl1g2?=
 =?us-ascii?Q?7H8e7qv87nXs0VFgqe9HAEnAVKGxNqNv1ztokQdhpTFd9x/2itukLqf23yCA?=
 =?us-ascii?Q?5+WWx8KzCge3qzJ3pGtqooCwJ34AiDcPuAWY2Nt/tlC6ySfdV9+GMREkKcse?=
 =?us-ascii?Q?X5MY07/aJC588Ji9xLmdwBsCKJT9+ArTcvozS/VY6v/5LR7sgC/HPC6hRi2k?=
 =?us-ascii?Q?7atic5NvbMCl52VTmVjmpBiEdcGe2bcV3lbvSFDa3op5TzKzdCXMK7fWE3kv?=
 =?us-ascii?Q?dqUgO61QgB7/8sg+HTuiTz6l7rvpg7xk+P0hBwfaW5LRzrT3VZTqahtwQJn7?=
 =?us-ascii?Q?kP4wCFgiNf3rhPNfKDiTiJW9G3Uv7N37OAVJKZAj6ZMIfN3Q0Seww8jKVB+5?=
 =?us-ascii?Q?8ohBxR+vByEclyCI7t83RM5ftKL0KTHwoFxbkYZ18uzDshJmOpOotA7UKI0r?=
 =?us-ascii?Q?ZryZZS7dPVCR8plPZchhr9ZR2fgMbzI79Vd2IW4E7luux0wQXKH0XyT4ctbW?=
 =?us-ascii?Q?MjhSpZjiJwDWp16rQvW+/UriQ/5NiWkI7ZUvlkg/XmKafW2DKSRUkHOBQfY+?=
 =?us-ascii?Q?fZk46t6m0g95uDPWARcnaK3bVbeZjvwIS5AMh6dVGDyjqrb5cZiJwnxwFRGV?=
 =?us-ascii?Q?C8T4fjnqTlKmFR3g0Ux/pspAy10Sf49Xr9CBc7WAcU5d+m7bkGO7Y5ZWgWBz?=
 =?us-ascii?Q?LDpKAQr6Y42CIoSuimBvmSNQPR//fe876ShrRtxEQFFSFMVb//qAuw53U+GO?=
 =?us-ascii?Q?kSlrlJPVtRhLZev43gjMSSxebsxwzCXzZj5XOS+XMv3aKYYhBLgrmGOVKUte?=
 =?us-ascii?Q?omhv2JfJR6QCHj0x6JDnhwfNVHUDefAhujz+jc8N46M3gqRJnDH3udshTWeG?=
 =?us-ascii?Q?KVmTgd9TsF0SNMUD+0n+hEmO0yzEQRq02iBJubwfRKRj1kuFsWQDXGLtpPfV?=
 =?us-ascii?Q?tFm7z/jCyqYOmh3R3Zkyjjme3D0t6oUpFABWUnPdxYlLV7CuYW93KTUMg+hP?=
 =?us-ascii?Q?juM0SUb6llGXoM5PP1r6sqq4sR8xomlGIhC3QtMY/duAQzH8IV1Qmg/ZlIXm?=
 =?us-ascii?Q?vvdX7ysGodELtJ9JaBSGboSnVALAYx9qrrsIH+dvj2Vz5FIxhhZaSzuzLH64?=
 =?us-ascii?Q?N/rTg7xig9Qs4yjdwESJUpOeTUuQ38zvvGuUtBTm2btI+8Lu7Sxz9OBrQZjr?=
 =?us-ascii?Q?bWtg2y/Z8ByU9PMTC8YHVIgq7nJmFZUmVh6Zn6F32pdHg2LCqjFsZaOPRdCN?=
 =?us-ascii?Q?vnTcueyapcKRCgDTK1VWwd00J20v9hJU7IDR2wC+F/l1CybJTl5KYnjiJAMJ?=
 =?us-ascii?Q?PgRoqo01AfhXUgp9qUusmiY2f/FMrt752i78AUhLUsRCen/Z0sQWph/Tnoyp?=
 =?us-ascii?Q?bp7ULnxrwrKUJ/dyN3g4XjtozQSeqjqqmgeDVXLFDa+i1HS8kSxCoNlwaiLz?=
 =?us-ascii?Q?gQT4PtvFmMZyeZL8GanM7sdeUvI85znzPgVmfSd/VZCc68idScb3WX9GETqa?=
 =?us-ascii?Q?f5KTitCFfy369fVnDriIcGQjHfhX7n29c5yITGVUytCLt7h9t7XbdnzqJhdK?=
 =?us-ascii?Q?bRv4rIA/wJH+D2bKjbMqShu9r8xQGLLsEi3qzoxe?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	d2fXifMXK9Yi4qyFqVf0BbNZb/EsdKTPBTgyN0nPWF2Y4CE7T2qE+OP8kS8Tm6as986yyQ9XscCC08g7ZMPjjRPGDajqpCQ53rnsA9/KRxgKziIohU4him9DOC9i7W8j5fg6n/xwjA7WHEThMocA4T8UyRYIzY6ShVIAtGqxMqs4kx+55UgnE4bQNva/kGARt51MjONKCPCJP56iS5GdI1lm3O8YE1YO9VUTeUh2K3OLUAnq6BQVXCpzONJakAC03bPSSeuEEFzTFsJgFIhDuaufwa+Nk3mZg0lx/KL9Vdy2dsfYaaKgCfkGEB3TzlIafwrWn0Aq3VIuk3aYkvvgpALPEjWEEw2xjELwMtNiI5obwVE3e8X0FX6KqIoHljH9SgV6E27+ENHhZLi7XczZXJnGbzBmcPcWlJc9VlfDirh3JUuFtpklS0iHP7c61fwbOBjICgG4aaUhlEyltuMPg5xcQ/+Q84wzLdmywq86Gvfl/HzC8zhPSbxQ5R7bgtmHLPzHLoUgSLXDLD/PjiO743I8lfWEZHPnh6XL0TymJLnOnz41gnP7EwLbWhs6Q9TAfHMrFlqA9iCtNK+36CvMEIZSXtYtNS5nZNngR8EpOqE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46f75d19-53da-4fd2-6f42-08dd050c649c
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 00:28:14.9765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xRadW7rRTKKB6qJdJS92Nmq74XDVatEb4bhgdhafbFCcfN91pfMTeuqWjF9eJefiLM75Kcevkbxd2EJrx8eS2+1Y+mpoWTW9e0dvob+Oeig=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6254
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_05,2024-11-14_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411150002
X-Proofpoint-ORIG-GUID: 6Ly4F6r34L_hLCmKaNVkDiNmgKq4balV
X-Proofpoint-GUID: 6Ly4F6r34L_hLCmKaNVkDiNmgKq4balV


Catalin Marinas <catalin.marinas@arm.com> writes:

> On Fri, Nov 08, 2024 at 11:41:08AM -0800, Christoph Lameter (Ampere) wrote:
>> On Thu, 7 Nov 2024, Ankur Arora wrote:
>> > > Calling the clock retrieval function repeatedly should be fine and is
>> > > typically done in user space as well as in kernel space for functions that
>> > > need to wait short time periods.
>> >
>> > The problem is that you might have multiple CPUs polling in idle
>> > for prolonged periods of time. And, so you want to minimize
>> > your power/thermal envelope.
>>
>> On ARM that maps to YIELD which does not do anything for the power
>> envelope AFAICT. It switches to the other hyperthread.
>
> The issue is not necessarily arm64 but poll_idle() on other
> architectures like x86 where, at the end of this series, they still call
> cpu_relax() in a loop and check local_clock() every 200 times or so
> iterations. So I wouldn't want to revert the improvement in 4dc2375c1a4e
> ("cpuidle: poll_state: Avoid invoking local_clock() too often").
>
> I agree that the 200 iterations here it's pretty random and it was
> something made up for poll_idle() specifically and it could increase the
> wait period in other situations (or other architectures).
>
> OTOH, I'm not sure we want to make this API too complex if the only
> user for a while would be poll_idle(). We could add a comment that the
> timeout granularity can be pretty coarse and architecture dependent (200
> cpu_relax() calls in one deployment, 100us on arm64 with WFE).

Yeah, agreed. Not worth over engineering this interface at least not
until there are other users. For now I'll just add a comment mentioning
that the time-check is only coarse grained and architecture dependent.

--
ankur

