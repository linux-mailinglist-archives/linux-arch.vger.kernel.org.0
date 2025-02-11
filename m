Return-Path: <linux-arch+bounces-10119-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 074A7A31A10
	for <lists+linux-arch@lfdr.de>; Wed, 12 Feb 2025 00:59:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B6181652D5
	for <lists+linux-arch@lfdr.de>; Tue, 11 Feb 2025 23:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05470271803;
	Tue, 11 Feb 2025 23:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WdXFZoVq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mM+3J/SU"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC2C271800;
	Tue, 11 Feb 2025 23:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739318381; cv=fail; b=m2eOft1hZsIIsCfCPLjC8pQSnToJBlFSHfLbw1QDMr6X4tH77F0mozPk7lhIcLmM5lrXcU3hzBExGG7n+uT849FAWtNlnWt9UD5CCz3l0y6wpHRe/kSCozuVdFHE+ImIYLTbcPp5lbZHD21YazSjfN6qdxEgy88pZ5CIbyWxGAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739318381; c=relaxed/simple;
	bh=MvNQpDn0mBp67qtvQpU8tirLh1GX3vvlSErGH8ASDNk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=NaROagrJ3N9JjK87+cW4+yTQ321p+2Kp+uQBfDVZyOHvFFnnb40Pe8BVI2Lm5cNomjg01N8ZYvzyyjOdqDEJPpibhcRhA+OgRJY50FimZa3cnK75dRy8OfuwAAJ8rsEUzHIRZopYdg+CogJudn8a0gMUwPiu3BE06UZXvpB9VQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WdXFZoVq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mM+3J/SU; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51BLffqm013206;
	Tue, 11 Feb 2025 23:59:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=BQIPzTGW0NLpGH9aslthIGO75mzW+1C/kcI0orbOTOI=; b=
	WdXFZoVqqSCFa8jcEfbrgrPt2kpk2HA3RAl+t2F5/ejG7pb8HLmMPqHQ+kQ4jBIS
	leWtuOSU+JDSvN4DVOr3dFf1povkIntjySzuOB9klGoXSKa5ObsMO/KC7s2LEgsQ
	0WSwYlDM5IT/9UR3GtoBODtw9HjjmTXDteKKySz0K/V+Lq5hDCLPiyT7WkXXMgtp
	FtMIIc126E6gk1ccHXD2S9Im38cGzfM3yxr7/mGtF0fDaYMQ1Ruj9ySqL3VMC6t2
	LFblFq+KhRKkpVmPBpZZ/1j/VnZtOuk1uaPvVKkdrWJQE62ae7O5L8d+AnyCeiNq
	hedFKFOz1mJetMY1UCM2WA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0tn6agq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Feb 2025 23:59:04 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51BLxjaB009748;
	Tue, 11 Feb 2025 23:59:03 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44nwqftq2n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Feb 2025 23:59:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wUy5hIWdhQkNavgaxuF3QiG3RIXs+G1NUJD1ErlEJRvPfqKc+ETk+6/QPsfGNJVme80LgN06O/afJRe+G8kpZDoAyOf/VSItjYOxt41VagOn7187ExUwx5GSdXljEvWUZuS2G5qFg1zGD9lF0YkXL5Z/yLhKVyjJFZk1VDKGx8eUwnD0gqhwxl7y52xJbna91xJo3lKaUVUlasw3j+O9Gw6emT8CT0ssn/xXP+YnK0Oti89XdcQoiyZG0JDeBKSBzgOGG11YyUNYECROtXnfT5iyeOCDHG+edWmYlFz8YIoP5TtTiYBP7yerYu+QB9cmp6YI8U84hErDjOB6J/Q7SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BQIPzTGW0NLpGH9aslthIGO75mzW+1C/kcI0orbOTOI=;
 b=WSgj4v45U7W0lbrs2QwDJ/cw37ZUJdQzk2D5KSGIgtCgQF7F5IXVeNzjWdCK2hjMpdkdI2XR5IJaV+NE/5CTSsGusuKGe5NogpQLAS6EGRhPosvfABUQVSbzFtgOqpvRksBRRlecKD6x7IrGDQZxg8j1wYr4VQv8jC1moL6dGoLnTFIgBqn4xg5Xkk6Q+1nLtEaNpR4wJVzGYmHDQM48cijcOjqNNzgq5S6UoHUDckml5pDIdP+INdcWr8SkifmpdmSbpVwBLglNTa8q0AES0kWKJmNgvL87H8WXtUwHN2VFG0OoIvlnH7AlEP0tinTcs36O4sbbNn8epQ1To1NrRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BQIPzTGW0NLpGH9aslthIGO75mzW+1C/kcI0orbOTOI=;
 b=mM+3J/SU142flRhFdhC7kX9WF5EV3QIG6/Z/uagLSl4wJOPL5ybrUJNmNYj0WUx9S8WgVwB94PcYEqa7s87sfrh7sP5Yid2qLOCvuEoXlRU1TYlpWbuh6Gpakot/J0ituj/0Ml1kiqoTUvr0DFpjjqGvWfQb+yvYTCnyZAhgK34=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by SA2PR10MB4475.namprd10.prod.outlook.com (2603:10b6:806:118::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Tue, 11 Feb
 2025 23:58:59 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca%4]) with mapi id 15.20.8422.015; Tue, 11 Feb 2025
 23:58:59 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>,
        Andrii Nakryiko
 <andrii@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>, Kees Cook
 <kees@kernel.org>,
        KP Singh <kpsingh@kernel.org>,
        Martin KaFai Lau
 <martin.lau@linux.dev>,
        Sami Tolvanen <samitolvanen@google.com>,
        Eduard
 Zingerman <eddyz87@gmail.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Stanislav Fomichev <sdf@fomichev.me>,
        Kent Overstreet
 <kent.overstreet@linux.dev>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Jann Horn <jannh@google.com>, Ard Biesheuvel <ardb@kernel.org>,
        Yonghong
 Song <yonghong.song@linux.dev>, Hao Luo <haoluo@google.com>,
        Andrew Morton
 <akpm@linux-foundation.org>,
        Linux Kbuild mailing list
 <linux-kbuild@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>, linux-debuggers@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>, Song
 Liu <song@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, bpf
 <bpf@vger.kernel.org>
Subject: Re: [PATCH 2/2] btf: Add the option to include global variable types
In-Reply-To: <CAADnVQLiyezBW34dhkwZw+mWmkFAYMZUdHbOa4uYCdPbgS10SQ@mail.gmail.com>
References: <20250207012045.2129841-1-stephen.s.brennan@oracle.com>
 <20250207012045.2129841-3-stephen.s.brennan@oracle.com>
 <CAADnVQLiyezBW34dhkwZw+mWmkFAYMZUdHbOa4uYCdPbgS10SQ@mail.gmail.com>
Date: Tue, 11 Feb 2025 15:58:57 -0800
Message-ID: <87a5asghj2.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SJ0PR05CA0208.namprd05.prod.outlook.com
 (2603:10b6:a03:330::33) To PH8PR10MB6597.namprd10.prod.outlook.com
 (2603:10b6:510:226::20)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|SA2PR10MB4475:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d788982-bc88-4cfc-a831-08dd4af80d11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OGlYYWtpSDN2bnNOSUZVdnE0TVRJRnpFTGU3Sml6MEZwSFBub0dyVU02U0hF?=
 =?utf-8?B?UkxDR0VXZllaU2tGNE1pbGM5YldJenJCVWZXUGJHTWxJNWFXbkdYU1VRaE93?=
 =?utf-8?B?TkZ1SWtzb1FJMnhCODdwMENobnMwK3NBemJrNnB0T0VWUTFSS1h2SVgyVDU0?=
 =?utf-8?B?R3VmUG1zZmM4VnhTRVFCRElybUpqT00yYjVzSWN0MUVxL0t6UmFIYzB2MVRz?=
 =?utf-8?B?VHlITjl6c1Q2K2JJZktRaGNZUFBJOUZmRS8wK0tkbWQycjltcUNjWVBpTEk3?=
 =?utf-8?B?NlRReHU4RjY3Q0svMXNLbGVRU3pJVXdpZTBwdDc5TnE4eU42ZGxsRkxzU2h1?=
 =?utf-8?B?YS9qRjl3ZnpFeWN6ZmtmR3B1LzRiblV5bE9jN1ZWSzdSNTE3SWxnOWx3dHIr?=
 =?utf-8?B?aGZIVUNZYmJMU3puMjI3elcvS1BLWjAxWi9EalJtQUZyVTBnb1pXVDFzUXFp?=
 =?utf-8?B?bXhsWW8zQ0JDNUd3M3JiVnZ5cnVVOUl4eUtSY2F0VVRZZjUrajJja1RrdXJL?=
 =?utf-8?B?NjFsbXcrelNIWWdocUdZakR5L29Td0RqTzMxNGhlVHE1eWtIemtmMmd3NEpR?=
 =?utf-8?B?UnRHb3hVMy93a3JNd05Mczc3MFQwb3Zvak5EWkhvNzl1VFJHRGJEQ0w0dnN2?=
 =?utf-8?B?eUp2MGhjbmFyT01yYkM3MURrQnJETkVoQUJucVNXZU5DNTNsZjFuRWpHZEpw?=
 =?utf-8?B?S05sQWlSR0ZxdVVzQjd4a3FKbDBwSit0bE5pNVlMbEZIM2pDSjM5YWJ5NGsx?=
 =?utf-8?B?NjcwQ2NYV2xmcVE5T0RkRDl2ZkhkS3BGcUhoWjNEVEpkZWxOUWUrTzFkTkxE?=
 =?utf-8?B?eWFGcjlmUTFiVktTS3R1NWhBVUxrb1pub1RGN1hHWGpCQ2U5bzdiQ2FGcjhZ?=
 =?utf-8?B?NzkySmttRlE5QytGMzZXam1sTlU3b21mbk81UmJ2N0oybzlJQmtrSk1KN3hV?=
 =?utf-8?B?aTdZWGVtMmtJNEhwbG9ITlBaZitjejU3T0UreUJMMURXZHBoMnpDUDZkaWVH?=
 =?utf-8?B?OC9vVjZBNmE5KzR6WlJsVGd0NWFSMVhBb1VpWVZFYTZHMTJOQndORFRnc3cv?=
 =?utf-8?B?UGdCcnhadmxBTnA2alZiNlEyQUN0Rlkxb284SCtzOXN3cVJlV05zNzNYN0ts?=
 =?utf-8?B?TCtCY2JKWE5IQkNwaEdWZUd4dmFxbEJDWEJ3VE5XdENXeVhGOW00bHlMZUFr?=
 =?utf-8?B?ZDYxb1Awc3h3R0tUNGV0MUErQ0lROW1ra0s5K20yQVVaQXJGbUJ4Z0dtbDVi?=
 =?utf-8?B?THpkR2oyZmJUM3dBK3h5N082dytWVG9ZQSt6SXhKOGZNMVZjaHJZS2RCaHls?=
 =?utf-8?B?K2xQclNaWS9MZ1d2UWxHZ0M5MmJ2WUkwUDdlQjM1ZVJNR2x4YWNxbVJsR1U3?=
 =?utf-8?B?OVVnK3hkYmV1YUZZQ00xNUJueE1yNUpTbXpsVzgwTDZvQU5vYnZXNCtmMzJ2?=
 =?utf-8?B?eERiOWRBV0xuNklnd1MyUVhVSnJ4QlZkZk5CSG8rNW9rL2NRMFpFQUNKT3lP?=
 =?utf-8?B?NEpZSDhZVU1CKysrTGlnZHVJNEJiTmpXMFkvcWxZV0hvQ1dvZXY1aFZZT3B5?=
 =?utf-8?B?bS9RK2NjNVJxcXk5dlEyY3NGZksrMmxPMkhXTXJyRWlhdnpyeS96Y2Ywb0ZG?=
 =?utf-8?B?eXhMNkpadDlNeWhJRGtyYkNYc1VORkN4cW0vUEtCQVRFb0JRUFMzYmc2eXVq?=
 =?utf-8?B?VnI2NXlUT2VKMzg4RDk3N3U1VmduS3RNbW9VTUxROXFaQkgydld2QW5ONDdZ?=
 =?utf-8?B?QngzeHBuYjlUZ3QzaUszaVZ1MXpxMjQwa05HRjJhQjRwbVpwZlA1V2I1TGF1?=
 =?utf-8?B?RFZURG9GaTdSa3lWU1FkUFN2cjRoaGJ1bXRkZkFURHU3WFpzV3NCMDFLVGZu?=
 =?utf-8?Q?QmxVIamdZx9zn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6597.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NTlKNE9JVjJNYVI4ejlTSklkMGtHcUpQSit6cTlqRE9qSi90WmFRQmJhUXdJ?=
 =?utf-8?B?bUtlWHB6MXJxdU5KTkM5N3B4cFBCbi9zejRndTZmbkFPQTlqT2xsTS94ZGdU?=
 =?utf-8?B?NWhGOHpmcWxmeWR4QmRDQitoNXk1WnYvcDk2UE8zaTNnekpIejUveGRKdUpC?=
 =?utf-8?B?VjdYZitvOURNdytiNFJFY0ZyRlhLY04wa0NhSC9GY3AvaFBzbmR1SFg4QXNw?=
 =?utf-8?B?ZHIyMzIzejUvVTdSa01icGdjaTZxaDh3WEh0YU9zWWJGeWZkdjRrKzducnhy?=
 =?utf-8?B?KzhEWGoxSWhIZ1Z2UXZFek9XTGVqVXVGWmx4S3d4YkQxQndZUVFIUkFWMFFY?=
 =?utf-8?B?cE9KajVNMlNad0lqQUUwdys5RExTV2xaSlNpTWc1TDNncjIzVEJBQzlwZHJk?=
 =?utf-8?B?OFhKR2d6V0VXWFVBM3V3M04wOWN6VTNwWnVheTNJN3NtUTFINURiQmgxRUEx?=
 =?utf-8?B?dldtMzB6QkVqK29rODBMU2FWOGFXZUhZTDhCbmk3UGw2REt5d3BGWlNYWXBZ?=
 =?utf-8?B?RVQwbGVrYlNqTXYxTnlRbG41OEZMbE9qcFBqNENQUW1iWFJQUnRaZjBMNCtF?=
 =?utf-8?B?a0dqRUd3dWVUdnlMcHEvUjhyTEJkU0ExbFovMFRSOFFGM0V6UzllQjFBZTYz?=
 =?utf-8?B?VFpJMmpGamZna1Y1alMyV2pVbWNBd0JUK094ZVZvQ0tEN0ZoS3lzdWx6WWRO?=
 =?utf-8?B?OW0wTTNaZkZTUmtFLzBJbWJyZWl3RkFSY0lnclNkWGlQU1NpbzA4aTdMeFBF?=
 =?utf-8?B?WEFvOTl0UEFaZWRiVzlJRnBZZGwzeWtjY211NnpCdmtjVCt4bE9YNVlPc1RW?=
 =?utf-8?B?TU1rWlJ0d3l6Q2xvREdURktiSS92SVNZdXJlcHlXalZTSDJZdnI0aEhYdEZ4?=
 =?utf-8?B?OUVXMlA1cmtaMkZWSzZaVDBxUmk4YzFBMUtsQ3VqVDRxUDF3cEFsbURlbzg1?=
 =?utf-8?B?OFZvZGhZdE50TFQ3dndxT2lqNWJ1ZnZqMHVGbHFXUGFaZ080UEpxaEMzc2lY?=
 =?utf-8?B?b3BJMlVqTXVGWVIvclVocldJOTNxMjJOUEVlakx0bEs3d3JBcGg1WDRrRXpE?=
 =?utf-8?B?YzlRTU9YYkgwNUpJQlN3TnlMT3U5cnovcGZQdzM5TmVVczh3Zlc5TDVuOTBV?=
 =?utf-8?B?bkRIbVl6bTZMUCtCMjRDVzNsTmMyQmVZMXFWcTZYUDhrN1dHMXFuenVGVjRl?=
 =?utf-8?B?ZzlMWUtFb2FLeWNhS2pxMjRudTBERVN1WmRIS2dKQzBrWkd2QXBPRjNxcVVZ?=
 =?utf-8?B?OUdZaXpFcDU5QVQ1T1pGMll4QVRDRVllRk9UMCtienVxckpPdzVaNkFrSDJT?=
 =?utf-8?B?TWtQYzA1V0xCdlRTeTBQcFUvY0RZd3VWdVFYOEt0QkpNRk9HdEc3ZHRlSWhr?=
 =?utf-8?B?YlZqZkQwY0F0WEJBV3gxWFYyTS94bTZCVkFnV0NnR2FsS1NrNjc2alRKbDUv?=
 =?utf-8?B?aitBVVBFZEc2MmJHU3cwdDNpSGx2WlBlR3JsME1mRkNkUE11VTA5VFhDcGd4?=
 =?utf-8?B?RC9LWVk0OTFzWHRGZmY2QzVCSVMxdDNXZlVsbm4wek1LZUpZeEpmTC9oYmor?=
 =?utf-8?B?aXpNcUJtSnFyRyszR0VwODlFTkVyR1ZxeSt1YXhsd1pUdzhhd0kwcTkzQS9I?=
 =?utf-8?B?T28wcFUreFdVVkwvVlExczdoT3VtMnJwSWNoU2RoVko4TmErbWlUWW5NTGVK?=
 =?utf-8?B?ZUY5cHdkSm9XZGc3aTVNVkRTT0QvaXhhY1ppVm13VjVxcmhJZWVmTmJvMzRB?=
 =?utf-8?B?UDRuYkF1SjhURW9YWTM3eGpBOE8wOWdwSkhsd0JGQm5Hd0krY3ZGVG4xR1cv?=
 =?utf-8?B?TXBnTmpnZDcwRjAvMEJkSDFyZmQ1K1N5RmI0NEtnUGlDRGM3bnYvTXVIN1hZ?=
 =?utf-8?B?SlpGZ1VxbkNLSmYrWjU1aEdaTnFRUWNxN2p1UENYS2U0QlBaY0IrMGVuZy90?=
 =?utf-8?B?MGZWYytocFRTQUtCcW1VTjYxZ0hjZEZsNXFiUXZlL1lINVh1R1g0bEZDWDdB?=
 =?utf-8?B?N0U3S01NelZ0Z3FOTFRZZ0QyK2x4aWxWNXNKWGptcXcwRmpQQ0xBSC9VakJU?=
 =?utf-8?B?Q2MrakhCRHR6aktQamNVRVdYSVptSEJqU3FYN2ZqZWNwalpFR3BqejBQVzRa?=
 =?utf-8?B?R1pnQ1FsT2JDVG5hYVBZZHZEaWxDTDFTY3dYTUxiRUp5cWxzT3FMMTVsSFo5?=
 =?utf-8?B?SXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BL/oELgkCVzf6SOgkD2JSTbEjqL85t2Xw7wmWpYA/P+ooMSVPLm1tiKa1NeF4a0KMDEhdsAvb1kmrHgT53uBfKQsG8FjEt7lbTu38FaXGc0WRF08cUax41W47+F7+ICHhsA/z9TRHuZK7Af9h4mcqyFbDivVtIgqtKsugCV+PbTakhxQIy4++QikZoZFlNpMXfQGnizOUjXHEA5tY8k9pVqAnQq9Jx9Dt3dKdYqAnMVanPy0Zve7FFqOebeR2Y3d2OIEc7rznI3YrZaYMBQ0R0SjtBPU6KdBN/gQgX2wq4yREBICgsK/ZeAa6w6lv7GtPv20kOGLW/EeJYbOTPOIPMi2+34797pBXa/Xx8mL92ANP3SOv7RQL9wptaBCOhSGGCkkzYYMPjzOjP+88TY5wHdt4YonKpPJDwrRB4AFJtvr/G+90Qi0U13P8u7/RQxvH+XnYtdW8ObIB/rpsasHnWz/llpc6gmCG7/6TySIBhhfA687jfMS1MIUt7hTLAdyQraCgzSPKEOrxILG+48rvZ3f4hRZCTcT8myOa1pIWhSgWP0XcYGWYYRbl9E81xDLy+deXm8q5RwsOCyEwp0tuNbZtmszqA+TFxhHJ89rg4g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d788982-bc88-4cfc-a831-08dd4af80d11
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 23:58:59.0609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +5ldyz6h5cJDlvAk6fLkwxBksx0bLjWRGGOeelgjXNKb73fC+xFPDfALoHv4M107CAzGJuuzBBPZ03+fZ53qA5Xgn8TxEGs2G1eVMKTG/qU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4475
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-11_10,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502110160
X-Proofpoint-GUID: h80bpJAjMYdHyNSB7XNlvwiHxqgQlx6-
X-Proofpoint-ORIG-GUID: h80bpJAjMYdHyNSB7XNlvwiHxqgQlx6-

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
> On Thu, Feb 6, 2025 at 5:21=E2=80=AFPM Stephen Brennan
> <stephen.s.brennan@oracle.com> wrote:
>> When the feature was implemented in pahole, my measurements indicated
>> that vmlinux BTF size increased by about 25.8%, and module BTF size
>> increased by 53.2%. Due to these increases, the feature is implemented
>> behind a new config option, allowing users sensitive to increased memory
>> usage to disable it.
>>
>
> ...
>> +config DEBUG_INFO_BTF_GLOBAL_VARS
>> +       bool "Generate BTF type information for all global variables"
>> +       default y
>> +       depends on DEBUG_INFO_BTF && PAHOLE_VERSION >=3D 128
>> +       help
>> +         Include type information for all global variables in the BTF. =
This
>> +         increases the size of the BTF information, which increases mem=
ory
>> +         usage at runtime. With global variable types available, runtim=
e
>> +         debugging and tracers may be able to provide more detail.
>
> This is not a solution.
> Even if it's changed to 'default n' distros will enable it
> like they enable everything and will suffer a regression.
>
> We need to add a new module like vmlinux_btf.ko that will contain
> this additional BTF data. For global vars and everything else we might ne=
ed.

Fair enough. I believe I had shared Alan Maguire's proof-of-concept for
that idea a while back for an older version of this feature:

https://lore.kernel.org/all/20221104231103.752040-10-stephen.s.brennan@orac=
le.com/

We can dust that off and include it for a new version of this series.
I'd be curious of what you'd like to see for kernel modules? A
three-level tree would be too complex, in my opinion.

As a separate note for this patch series, we discovered that variables
declared twice, where one is declared "__weak", will result in two DWARF
variable declarations, and thus two BTF variables. This trips up the BTF
validation code. So this series as it is cannot move forward. I'm
submitting a fix to dwarves today.

Thanks,
Stephen

