Return-Path: <linux-arch+bounces-13458-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 551DEB5054C
	for <lists+linux-arch@lfdr.de>; Tue,  9 Sep 2025 20:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 505721C67312
	for <lists+linux-arch@lfdr.de>; Tue,  9 Sep 2025 18:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F592550CA;
	Tue,  9 Sep 2025 18:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BZyDGr7R";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JpztSG0q"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D97274B4D;
	Tue,  9 Sep 2025 18:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757442661; cv=fail; b=okOoSlYXZQfYepEAQOWLlqWsHji1AA0FlJWYm6BhgZUU35yPCZfOKb86jwFtU+/ZoWlca2wnsuLw79oSlfgWRnomcPrYHdAI/RcAaMaxnAum1DjXZt2JXx5y0pZljqCNKv9VpvkNaOfkc8O0UmdxeXkJuMjLXMfaV9jsiSxEr+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757442661; c=relaxed/simple;
	bh=SSeqs9F5a2O6nTJyYouUFG8r8ktC/0caiSC6TQcY1lA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BC7EwZwBCtv5ZC6he2cTB8tyzv1NRvxC3zSuOtXGhxyQJcKoFbS8arB7aEeFGipwbjUNp//9ktXbAeeMu/uW2zU3qYLq35kfaeT2s+WrzYvO3qtZfHLH7+wkxaBG71Ch0KFVeUnBl12m4AbKW8D5bV3Kw9zrlKp890KRJERzn8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BZyDGr7R; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JpztSG0q; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 589Ftfn2030067;
	Tue, 9 Sep 2025 18:29:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=KlpjHfefaO/+M5QKAAngXli8jGg4oMRKYYAPFmiIVfs=; b=
	BZyDGr7RhQzqzk1q39hjOAPjp6t38kk8tuXgWE5+8/kWYsrFt01FsAMF+Ncj8Lpi
	P0papNEsdDqXTgM93tkZA1vAlFQnpuD7Mbx+pr0ZWq2+5theS/6taqNyJd2onKB2
	0k+t0E/quAJO+ar6J23Q1uDKgJZxm5QW0/WERe/0O7CrpedeMI+aM7yMXOHGAe9q
	uZl3NnmV+isxugmNbuxd2lzqCKUffDmZyeC2xlCXeFe+tCBHgCz4lDXGI3jaKDZ7
	oMz0YKbh6EYnQ3VYg1hJagvD8hgBRLYELyuqVjHPTtG3iGcnIT9b/zCsm0MGhbZE
	BeG5xLsDbW8fR5dp/qez0g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4922x92j70-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Sep 2025 18:29:32 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 589HiU2t038809;
	Tue, 9 Sep 2025 18:29:30 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 490bda0enf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Sep 2025 18:29:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=haCJTr0//8of1HftAAgJwnD00+9+y41ESHZkFBF1cShgHiuntVInxxiRS+NZ5M4EmdoOBePkisC+u8BciHa9k6gffRojbM4Tgw2EQBluO+u2AOjhHpEsCCHN5j+lSsl6KSRmPU4QflS6EX7CYknLXJ/Ei+b59sqfnaZm5nR35TT3xDd5Tnm5iTq44UjV9xrydsg6zewfOdm1GNEqLYT8Emy06czYScXxV6HicIO5wuSJHtxB4nAGyI7qp+CoB5x+RHTyuxI010YYwiehklufgmcOaoXBqT40XsWCf1Wq590mqZnw27hyTy/TbAdcloJ767JY6mWploO2hYByveHrZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KlpjHfefaO/+M5QKAAngXli8jGg4oMRKYYAPFmiIVfs=;
 b=iMn8jLpTWT6i5selmulKBhANYrA9bP1CljkBT5OM+XWIJVvGquBqkFeRivrr4c//X0gYkGyTtck0BkeDY4Veu72VI9ll44KAFmuedZHSg+tKO2Kq5qBXfsGFLRuPeTSYAiixSTGY6REoGeRpHjmu0vIjAEZ/LWHMf1LlhP40vnkZKrv1fwFrpskNeLxSbsphLWhwEE2F0s6nfPsXAUP7gY+433zkp2z+ZBGrD0Z4oT14iwwxbYCh9ecm3lRWp1RXK9c8eIXevSvIyEz1vxDEB5lGFD7FfFKgQfdFRTNP4DK9XXZDadmOZPGKv+bB6emSX7NFkqfXaMi1FjQ1Y9J6Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KlpjHfefaO/+M5QKAAngXli8jGg4oMRKYYAPFmiIVfs=;
 b=JpztSG0q0aZf1Umu4x2RGKQtGyQhhxFI730McF3+1QIwKT7hiTb7m7IZLK0lR0ngDifC8+ncAZhY0ZzZsiAXHMKpQZHx7oMYg66LVZGY/Jb4FJYZSRLGMwJNaz22nzMN2NJ5guTlt4NS64T92a2ResQeuYMkvwJZ01MdVT8KmJY=
Received: from MW6PR10MB7660.namprd10.prod.outlook.com (2603:10b6:303:24b::12)
 by MW4PR10MB6323.namprd10.prod.outlook.com (2603:10b6:303:1e2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 18:29:26 +0000
Received: from MW6PR10MB7660.namprd10.prod.outlook.com
 ([fe80::41fa:92d3:28b9:2a15]) by MW6PR10MB7660.namprd10.prod.outlook.com
 ([fe80::41fa:92d3:28b9:2a15%5]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 18:29:26 +0000
Message-ID: <46b59f85-bacb-4e60-97d3-cbcd3c7b77c2@oracle.com>
Date: Tue, 9 Sep 2025 11:29:20 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/22] Add support for shared PTEs across processes
To: David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, andreyknvl@gmail.com,
        arnd@arndb.de, bp@alien8.de, brauner@kernel.org, bsegall@google.com,
        corbet@lwn.net, dave.hansen@linux.intel.com, dietmar.eggemann@arm.com,
        ebiederm@xmission.com, hpa@zytor.com, jakub.wartak@mailbox.org,
        jannh@google.com, juri.lelli@redhat.com, khalid@kernel.org,
        liam.howlett@oracle.com, linyongting@bytedance.com,
        lorenzo.stoakes@oracle.com, luto@kernel.org, markhemm@googlemail.com,
        maz@kernel.org, mhiramat@kernel.org, mgorman@suse.de, mhocko@suse.com,
        mingo@redhat.com, muchun.song@linux.dev, neilb@suse.de,
        osalvador@suse.de, pcc@google.com, peterz@infradead.org,
        pfalcato@suse.de, rostedt@goodmis.org, rppt@kernel.org,
        shakeel.butt@linux.dev, surenb@google.com, tglx@linutronix.de,
        vasily.averin@linux.dev, vbabka@suse.cz, vincent.guittot@linaro.org,
        viro@zeniv.linux.org.uk, vschneid@redhat.com, x86@kernel.org,
        xhao@linux.alibaba.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
References: <20250820010415.699353-1-anthony.yznaga@oracle.com>
 <5b7e71e8-4e31-4699-b656-c35dce678a80@redhat.com>
 <aL9DsGR8KimEQ44H@casper.infradead.org>
 <bff57a63-4383-4890-8c68-8778b3a75571@oracle.com>
 <3fb2b394-fa75-4576-ad8d-6480741f0c1b@redhat.com>
Content-Language: en-US
From: Anthony Yznaga <anthony.yznaga@oracle.com>
In-Reply-To: <3fb2b394-fa75-4576-ad8d-6480741f0c1b@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR01CA0037.prod.exchangelabs.com (2603:10b6:a03:94::14)
 To MW6PR10MB7660.namprd10.prod.outlook.com (2603:10b6:303:24b::12)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7660:EE_|MW4PR10MB6323:EE_
X-MS-Office365-Filtering-Correlation-Id: c03a5709-13b9-40b3-39d2-08ddefcece33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TFVJRGFHeG9zNTdPS01IeC9NdkxvWHAvMTltVExtWVh0R2lCQVJEY094bUFZ?=
 =?utf-8?B?MlVYVTFUcHFKdUNtU3Z4aG5WWmtFc01acjBGaGc0OUdCcEhLaE5PbHhqTE55?=
 =?utf-8?B?ZEMxMmpTZnRIck5HYTU0N0pTQ251TnJoL2pjdHNGRGNSMzZKSWM5YXJoUFBi?=
 =?utf-8?B?RG1jTTJtUk5LbzJlbDd5UzNnKzZiVlorRlFDVmJjN28zaFdKSXNyTVkwM2dU?=
 =?utf-8?B?cHBNcVBveHlJYzB0M2RNYlI3UGxybnRvREJEbWxpUS8yMXhybkVVSnMvL2pX?=
 =?utf-8?B?OWxVdWY5YnRaOStOS2tHczB5TklxNWlQQmljMU5tRWUwVTBNNWszV2VuaUs2?=
 =?utf-8?B?YWdNWllHQ2pmckZzNitpd0I5V2xPUm9VZ3lkeUxQeHNkbndrUGhMVmtFaThi?=
 =?utf-8?B?Wi9VdkVOWVpFQmhibjZEMk1VV3VFMzRBMjdiUCs4Z3JKY1IrOG9iQ0k2VVlB?=
 =?utf-8?B?NUhiZExMSWZPUzI0WGErNVBTT0xUQ2JKMXFWUHArNHNUbXNCRzAxcTFYdlV4?=
 =?utf-8?B?VHZ4cTNBQjU5eUdraWd6OStCM0FKTzE2Ym0rZlQ2K2ZwcjRuRFlKQmNCQTJS?=
 =?utf-8?B?NVJWemlSQ3RHRnE1VGhWQTI1TkpOcmYvbFMwY0lEcHQyNGxSQjM4bC9iUnNh?=
 =?utf-8?B?RFNvVlpja0taYUtZbG9IT1FrU1JCbGw1VnpPMi9xN0dnTk9YY0RTeHc3UWkx?=
 =?utf-8?B?bVB3MTg2QTEwVVdoZFV6SHN6VVNkTFVaVm93VmF4cm5wMEZxUS8xcUkvTzcr?=
 =?utf-8?B?L2J5Zk1lQzhTb0ZrOHpTZ0wyVmxaWGlUNkJzNDBsVW9ma3Blb3NMNmZpc3lU?=
 =?utf-8?B?UGZjNm5yTFFKWDR5Q0NybkU0NFlGeDZ1WEZsSlZCTEtCVkNOREh3TXNxdHll?=
 =?utf-8?B?YWtaV2xWbXFNdjFvYUlIaGdYQzVFU2ltYnA0cFAvdlVWV1QrN0FMYzFyNDhu?=
 =?utf-8?B?Qmlkc0wyaDBCbEZmLzhxajg5WU1meXRoeGJwdVNlS2hVNVZiNm4yL0VScUNO?=
 =?utf-8?B?UThyWFZnVmNrb1d5dXE0Z082Wm5jTlAraC9Ba0paSE1JM0Fzb0FDc2JyNFdw?=
 =?utf-8?B?SzdCckhyV1kyWHNBMS9hRDJuZlkzRk5JVnFvTEZzT1BiRmFTUEFHTjM0Rk1H?=
 =?utf-8?B?NUVralFxeUZORFEzaHZJVytCaE9XeXIrMWF0WE1VRUFsYklLeUxubEVqMlNP?=
 =?utf-8?B?L2hYNzMrN1Zweis2bW9QeEpncEFBRTZhN25iTzkrcFJsMjFXdGFHa0lmN1g1?=
 =?utf-8?B?QU9TL1FWc2I2OG5mUEtkQ1psK0doMmh5aUdBRncwZmZidFk3enNYRW1UQXlw?=
 =?utf-8?B?bjlTZDUwb3FHdTBjZWU1UkFJWERTM2dodWV6ampjb2k4SmRwcmlFczRVa0wr?=
 =?utf-8?B?Tm5HbjRoR1RDMFRyY3MrR2FucjErM2ZqZzlYT1FXWkpuSy9CejBTOWtNMzZG?=
 =?utf-8?B?RHozbnZnM0UzODhCN3FmRUxsL1ZCVXh3UlFFd3dUNFM5WTczN0pWbEhWZW9t?=
 =?utf-8?B?OXdwSjAxOUliMFQyTmNUNEk2MkNjU2d0V1I5TTViUW0wZUJmaTNkaDlWV1Nx?=
 =?utf-8?B?QW5Mak42T3BXdTUxSzl6UTkwL2RuOVhjUldJeEdvRW1jd1B5cFRVMzJwSVRD?=
 =?utf-8?B?RWxWQXVaZ1ludnR6UG0wVmd3dU5yTWxURUJsSHE4ZjlXcjhya1VobzNKSElX?=
 =?utf-8?B?clg3eTljUytqb2ZjZE0rZkNISGk5K1pxbnNKeGpYZHdRdjF1Y1hwU0JtVWo4?=
 =?utf-8?B?VmVUWmpLZFRINnArMDNlR0FmV3k1V3FpTklKM1hidVlORTU2THdYNzFSVFNi?=
 =?utf-8?B?bDR5RWVvbWxtWHduV04wNGhPUkg0d2kwUWJVelRqU3pVTmp3ZHErUHpDYW85?=
 =?utf-8?B?ZHptSlZzNnhTNlp1ZUp0M29nd25UQlZXMGdtT0R0YkY2Nnd5UzkzekRQSWtD?=
 =?utf-8?Q?jtEH0qR56JE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7660.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dTNOaDlLYmRvY2luaXZxa2NsampNSEc1RHZIM2RXd1NLZ2VmYVhkU0RwYURU?=
 =?utf-8?B?d3BjK3doRGtsYWttREgzRzZOQVVHbnBrVWJEbC9Od3lQdWNkTmhTZm8zMzFG?=
 =?utf-8?B?U1pRV2ZiOWhuTmVuaERza1dVc1FHM0RrTldvY1dtWmZSWDY1QXliL0VtNE9V?=
 =?utf-8?B?QUlEclpmYXVidW1UbEpOOFhOMEEzUjdRbE56bnVlTTJxbEVkTktvbWhmRGxn?=
 =?utf-8?B?RXhHQm5hV3hQbUdPU1NzTFpTV1pSdkViUWk1VXZYTVJEVnY5Y2pQL1lORW1x?=
 =?utf-8?B?dkl6VzJGQTdqcTlEVjducVVCQVZIbkJEMFp1M0ppV1ltajBQM2czN0FvVW9Y?=
 =?utf-8?B?UHNFVHMvOEN4SjBnMzU3RjlBZkVKd25TOEpiNlFDbFBOdmxFaW91NGI1Ymww?=
 =?utf-8?B?VURzVlY5dGc2SjQ3ck9ObnBJMEV6RmxwZjBibk1JRGJXSWxORVFuYU5Scklo?=
 =?utf-8?B?S2ZkS3AxM1I4dkQyYjhQYzViQWJEbEgvdTM0Ykp3NFBTaUg0eVI2My9Kbngw?=
 =?utf-8?B?cUxDZVozWHh3SGNmQXd2QVc1NUo0d2Y2d3RCcExhL3ptWnZwV29EUnpTM1hs?=
 =?utf-8?B?QlZFckZBNmxlVk1SM0JSWVNTL3dqTElWS2ZGUmI5UWdzRkxVRExGQU8vd1NH?=
 =?utf-8?B?T3B2YzhKa1pGeURnNDBnQXh3UmtJRWUwd2NkRFk3Vm9rY04wTzU1dm9Fbm0v?=
 =?utf-8?B?RGwraHFVQWZyZi84SFYwVEVmOTdGVGUwR0JSMFZiNlRXWFRWdGM0WVJRclk5?=
 =?utf-8?B?V0dCSmR4SGxQNWJBQTJEbXpHalhicEIzMlhSRnliSGJCSDJvcDlZeW5EQ05P?=
 =?utf-8?B?QUNsVmRhTmI3bndTNjUxN2ZFQ0JmUlBKUklRTmk0YkhLdkhZSHZmdmkxc1J2?=
 =?utf-8?B?cjZhR3hYMmtkL0twMElrNnpIb2xzMEtxdjdPS0Y3VFhFeTRhcitKSnBOWkxn?=
 =?utf-8?B?Y2pyNWd1M3g2R3NGQjZqU2JVbG8zdEczTTJLQys1VnJrc2RpK0pPSW9sdklW?=
 =?utf-8?B?MEhoOFJzcFovalBOZ1J6VS9WNDNhVlRhREthYWJOS09meEFPb0I5YWR2RGty?=
 =?utf-8?B?MWhXOXRmM2ozU0JVc2g1czVob055YnFyZk04SHFxVzJzSXNHSUhjRS9ySVBw?=
 =?utf-8?B?cDUxSEpuUy9QQVljb1VyWHFwemk2dTdOOWtRZVY2WnZvSFU0aUE5cG1yNEhF?=
 =?utf-8?B?UnU4MkJtWUJQQ2JSVUZ5SGpQVUJxdnJRZ2o5aWVKdGlGaWhESEN2VDExTE5B?=
 =?utf-8?B?eUVtRk5hWEthZ0ZEVEd4cTA3MzYrVXZjb004aW1KZy9tK2psYnpqSTRlSzQr?=
 =?utf-8?B?OEI1ZGNzcExud3RybUxDSEg1S0JUVWdYTTYvU2FlbThVbWtHUURueGNVSmsy?=
 =?utf-8?B?M0diSUZSVmw3cXRhYlJOT3lwUFZ1c2NPajBQamxXM05aamtYVStEZFB4eHpU?=
 =?utf-8?B?bGRVdWlWUTkwOVh2TGoxREs1Z1M1RitmT3ZyVGNUOTZYbzlBeTZxem5POW1U?=
 =?utf-8?B?OUF3K3UvdXgzWEt5YWNuNXljdm1GU1J2Q3orRmM4Q0FMSEpOMWxOTnNIWlBJ?=
 =?utf-8?B?Q3lUZ1R1ZDRpODRpZHRlbGhWUStYK01heVEzcWtHNGd4WEQzZUdqcFljSURt?=
 =?utf-8?B?V1pwNE9paS9SNDJlcnQ5UCtvQWxwb3dQQVNNS3pmRU9mQnZId1JVMDBsVmw5?=
 =?utf-8?B?WGl6RDhTczZ2cjJtYWQydlRtcXp3eEluWFprNnlVc1RudTJBVkw5OThiSzUy?=
 =?utf-8?B?VmIya0lZZVFGU1c0VGNFZit3QXlwNHljNUFiSjJENTQ4aXZWaTdMeUh1RUo1?=
 =?utf-8?B?KzYrYktjbEZ6V0JZeXFCWUtXV1ZUSkVHNU9FcitRcjJlRW5qSVlYVzdGbkl2?=
 =?utf-8?B?TzB3UFpncUhaS2xDZG9ic0lkNithQ0Y5eURpODh5T0ZscGJ5ZTlQSU9IT0ll?=
 =?utf-8?B?bHJBTVF2bmh4QVZuS0VTbHJKNW5LdWlmbFVjVms5TVFyNmg4djE0Rm92M0lP?=
 =?utf-8?B?bUlPYUtpYyt4Z1MxL0tBYW5vZUtaeHBDUld5Rndrb1ByYXQ2YUl3QjJNem4r?=
 =?utf-8?B?VElVZWxlekhDY2JSeEhFNmFJZzRacUl3RW9PYUdycFY1czhOV1JWMTY3V3Zt?=
 =?utf-8?B?S1k3ZTMvMGFoSDBETlIxZkZSL2RrWk9pVGxZdkw3WUFGUFFNc1pDT0JmZ0Iy?=
 =?utf-8?B?Z3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Y1t9LlJeVfyLyYiCKWD76XTgv5E/sz/Gz0DqdhLi7UmDRbO27DoZN1tX9uvhC+pVsPuO/W1CYtRUwanzDaahdKl6bhRqznOsMrbikUEUpY7TBjJ3213sRR+nE/bMpNg+sA9P18j8QdfuOtzHxE+3RCvYzXIVd3/KJwTmHsk42++lf9xTdrrdGEyfs7FD9KGLCn1lB2KUEipdqkfJYuClfD1TaoZtBbV04iGbgxgC4cpCmUS0dzQNp9D+5qvh9XzrkEYhERlDxrdNLl7P2Rhn+O467lHAUeOiC+sD2AzRZdYKtGEwSxryZZ8zWXzt766RuZooabEjoTx1aK4T0HrTDW4fnBY4U/SyuqXNMDzu9yWKx/Voi6K/9FgHDXIsbyiCU2sqmb2dzxyT6MZLQvu7rQEkcfQIR5eEcJUlMAzuV6TYD4uQVh5joXb4w6p6xrLlHcRIZXq3JYfglkpqp3vKTk5NiTCoCD5X3NuYhSc+mD0XFrPnz+4tFfvowZ5H97yFjk7O/qVAJkvhxjuTPMqfSai+yny0covwpNNjF+wqN0C8iMQVNMpbtxhil8Ug+HDb4QY4qeVkS2IIB2qu5UR7mWNP50d+O6tQKsrKVaGAugY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c03a5709-13b9-40b3-39d2-08ddefcece33
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7660.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 18:29:26.4661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vBN/zLTqxVLs2Za9TWnXG5FdwWAu7WOG0cg7rsDmK6tx5Hy2m8eAsY9XIuAoChIYcga5MpLEWO7/JdjfX6JqUosNA42U0Yk4b7wZLgr1Ff0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6323
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_03,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509090181
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE2NiBTYWx0ZWRfX1G2MKIaZcdzz
 nnDSoN53Qjse6SAlzOchgfepfXdW9n/DH1f2uW+TqpudDoqK/peaZQLEOP/PRpxuZNJtvdoIt7F
 DkAVRvVZeNfpxvgCQX9dHCBKpOszW/0Q0gTqQP85aMsDPXsATxuVqJnYw2VGV1jCl6bSyAhoOuu
 teKrbW+WZYaYRBK4v+YWPTplKDcwjv95bWFUAA7QVI8zq+vT5tE85W5S6qey35vs0AqS0PAGyVY
 AOretndcb5RVN/H3cBrR5o1S9fCb1MqKNiXDmJkwIujQcUb4FOCTUYvWE8LPBeXY6PIzEPkAb4w
 WG2B/VhUmBsxMBBqyfJtqUOt5qBwqB7udClzYFiyDUX/McBWGzJo8DP4uR1pkVULbZnzg8hMbID
 ou2sBcquhsL2tj5noQYAKAzfX3tp6w==
X-Proofpoint-GUID: heEsYBaCFwm7knGMPfyLqdGJM5nTkxCf
X-Proofpoint-ORIG-GUID: heEsYBaCFwm7knGMPfyLqdGJM5nTkxCf
X-Authority-Analysis: v=2.4 cv=LYY86ifi c=1 sm=1 tr=0 ts=68c0720c b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=WM0DrG0ODZRfWrdGdycA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12083



On 9/9/25 12:53 AM, David Hildenbrand wrote:
> On 08.09.25 23:14, Anthony Yznaga wrote:
>>
>>
>> On 9/8/25 1:59 PM, Matthew Wilcox wrote:
>>> On Mon, Sep 08, 2025 at 10:32:22PM +0200, David Hildenbrand wrote:
>>>> In the context of this series, how do we handle VMA-modifying 
>>>> functions like
>>>> mprotect/some madvise/mlock/mempolicy/...? Are they currently 
>>>> blocked when
>>>> applied to a mshare VMA?
>>>
>>> I haven't been following this series recently, so I'm not sure what
>>> Anthony will say.  My expectation is that the shared VMA is somewhat
>>> transparent to these operations; that is they are faulty if they span
>>> the boundary of the mshare VMA, but otherwise they pass through and
>>> affect the shared VMAs.
>>>
>>> That does raise the interesting question of how mlockall() affects
>>> an mshare VMA.  I'm tempted to say that it should affect the shared
>>> VMA, but reasonable people might well disagree with me and have
>>> excellent arguments.
> 
> Right, I think there are (at least) two possible models.
> 
> (A) It's just a special file mapping.
> 
> How that special file is orchestrated is not controlled through VMA 
> change operations (mprotect etc) from one process but through dedicated 
> ioctl.
> 
> (B) It's something different.
> 
> VMA change operations will affect how that file is orchestrated but not 
> modify how the VMA in each process looks like.
> 
> 
> I still believe that (A) is clean and (B) is asking for trouble. But in 
> any case, this is one of the most vital parts of mshare integration and 
> should be documented clearly.
> 
>>>
>>>> And how are we handling other page table walkers that don't modify 
>>>> VMAs like
>>>> MADV_DONTNEED, smaps, migrate_pages, ... etc?
>>>
>>> I'd expect those to walk into the shared region too.
>>
>> I've received conflicting feedback in previous discussions that things
>> like protection changes should be done via ioctl. I do thing somethings
>> are appropriate for ioctl like map and unmap, but I also like the idea
>> of the existing APIs being transparent to mshare so long as they are
>> operating entirely with an mshare range and not crossing boundaries.
> 
> We have to be very careful here to not create a mess (this is all going 
> to be unchangeable API later), and getting the opinion from other VMA 
> handling folks (i.e., Lorenzo, Liam, Vlastimil, Pedro) will be crucial.
> 
> So if can you answer the questions I raised in more detail? In 
> particular how it works with the current series or what the current 
> long-term plans are?

With respect to the current series there are some deficiencies. For 
madvise(), there are some advices like MADV_DONTNEED that will operate 
on the shared page table without taking the needed locks. Many will fail 
for various reasons. I'll add a check to reject trying to apply advise 
to msharefs VMAs. The plan is to add an ioctl for applying advice to the 
memory in an mshare region. If it makes sense to make it more 
transparent then I think that's something could come later.

Things like migrate_pages() that use the rmap to get to VMAs are in 
better shape because they will naturally find the real VMA with its 
vm_mm pointing to an mshare mm.

Another area I'm currently working on is ensuring mmu notifiers work. 
There is some locking trickery to work out there.

Currently the plan is to add ioctls for protections changes, advice, and 
whatever else makes sense. I'm definitely open to feedback on any aspect 
of this.



> 
> Thanks!
> 


