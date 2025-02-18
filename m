Return-Path: <linux-arch+bounces-10204-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C436A3AC62
	for <lists+linux-arch@lfdr.de>; Wed, 19 Feb 2025 00:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33F8D7A5252
	for <lists+linux-arch@lfdr.de>; Tue, 18 Feb 2025 23:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BDB92862B7;
	Tue, 18 Feb 2025 23:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JwX6soEL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jsCD3AUe"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E061D63EF;
	Tue, 18 Feb 2025 23:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739920228; cv=fail; b=HCLQUJdQ1uD9eVcw2XlBkWPkATEeQclGLkDSGJX9xVjwB8dh3sXKXn6FUejaMjgSdV5kP6ivRsudpAwcC8AW2veYp4T2aycYK/xjak/mMd+qyRW/jgfr13rQtC2YMgBkmasXyFTwQmOywlx76c29qMf5TwmHHEJmOUMVYk5vDdM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739920228; c=relaxed/simple;
	bh=qbYC2pUCaduTV7mTMmkQZBp2cyAimE7+OlzZoDRHbY4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=nS9HHcDohqfEEWmHIfhfM924YnNBXDcFb6UZ80MSBP9TYIQmUwr0p44ggkbFQIKYzAitmHFqoK6f4cfqEpxkpqd8AdLbNyht9TQB0eVLawVRMxjs9i0Iq50Mk/ZLjj8eK+TySgWBpicCJiH8WxjDZN4IScQjy4iewuWQaYbjXVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JwX6soEL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jsCD3AUe; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51IMfYGl003770;
	Tue, 18 Feb 2025 23:09:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=WNsP6ZlgCNksa0a8n78o3+vg0lVpB3kh6yGdXoYl7UU=; b=
	JwX6soELXe9mS9JTV0ndEiaYmv9Xcb7kCrj7dG1rNLfhv1Mb27MEOn6KPyJ/rR+s
	PbOUy/Y5crUo4G1sUaGR+BG8yecBRieBt1vIq/HCOd56wjoSbTVeb7uxyKTaPmI+
	NEP4FIh7ORaj7UX7T4TZFXzh0pfCVosDDfAz52vpcpJ4SEYL9/HMj9E2EHihJMXc
	JujF9qmB0Rw0mTDeReUcQHeus9i+YR1oU8XseQux6fZOO+NrXMlxt8Pe7MfsgxYx
	/uvXq0jmrkj3pwv2xIhFXDxEMpHG+gEhob3CfMQwcSlmGdfRU0uZbWxNvvwMm5GK
	SNur4eFKqVP1aznEzNeREA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44w00ngf91-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Feb 2025 23:09:46 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51IL115u010522;
	Tue, 18 Feb 2025 23:09:45 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44w07cr45b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Feb 2025 23:09:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rkb1pAjnKk5oqL+Eg5EeUk5aDWarxjacUPVi0nTmgPgZYqGOlZ8vlDvQ0tG9uv+Z54ZKWnyebxX8mCigk8kJa3NcpVLLez3rj+3SScdaIMFg6tASlyXuJsX4wGwn+Zi8g2jujW1ffvVns44FW29lKMLTszrbKs81qLvj5OR0Rott3vvJdetd3NAM+V4vVVPyz8QA7FWCpZF3VIFI1Na7LNK1CKJRXJ+DMRuEq2bTSY/JClIiqHohNhun/g/viwADl53JT7Gb/Y5q/k2AZD0aeRXGdCyE17CjrQnrO7WE7hMkz8tf9Q/g4+O6qtAkcD5h1xL2Zi4V8gQ6cetfRkJkGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WNsP6ZlgCNksa0a8n78o3+vg0lVpB3kh6yGdXoYl7UU=;
 b=flKMfN5gN/yIIZrWWyOPJ6vhL5wB2cS2zOAHqB3jRaFa0LgilNo8MYCmILqES4j40GTocmL66cqbQWNGogoMC9wflAciscWI9D0aP0QQN3yBIdzffvBVWL4PIipDhl7bIK3k/xZuv4IaBjaWATIcOCRBDLiCtO2g8MryGsK8qAnGWXouQnNgmac//8FJ81RkMYIcLYTPqUd9MD86cttgAIW+HMSDAzCMzRBBD+QxNozZc80FsCSo8BjpQJnfalS/xJDVQXn8cA+GDFK51u7Tc0vlNi7/gvrAeTo3+6L6CtRLCNjX5J0t2+0oWS6Ntx9ZbR9nPf77LHrkgoh/93TjtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WNsP6ZlgCNksa0a8n78o3+vg0lVpB3kh6yGdXoYl7UU=;
 b=jsCD3AUejx1DxwpF52Z88O6hrRlwp19CJsmj9KBkJ1KMvfo4pSTIy2GKAYuwMPQ/Q2zG4Rk6zzchfMExDuPzs0xAZaM6BjD6hVt/H88IJbmzfxLrm77HXxxhjizK2ZZnx36wt/gTDSFfWeOC/jXVDy/WdtFe7XEtWUL6zIUfGeA=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by SJ0PR10MB5629.namprd10.prod.outlook.com (2603:10b6:a03:3e2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 23:09:43 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca%4]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 23:09:42 +0000
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
In-Reply-To: <CAADnVQKLykG3akdPRTDgHDey9FW1LpixZHjLcj+eG2rhXo7V1w@mail.gmail.com>
References: <20250207012045.2129841-1-stephen.s.brennan@oracle.com>
 <20250207012045.2129841-3-stephen.s.brennan@oracle.com>
 <CAADnVQLiyezBW34dhkwZw+mWmkFAYMZUdHbOa4uYCdPbgS10SQ@mail.gmail.com>
 <87a5asghj2.fsf@oracle.com>
 <CAADnVQKLykG3akdPRTDgHDey9FW1LpixZHjLcj+eG2rhXo7V1w@mail.gmail.com>
Date: Tue, 18 Feb 2025 15:09:41 -0800
Message-ID: <878qq2df4a.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SJ0PR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::10) To PH8PR10MB6597.namprd10.prod.outlook.com
 (2603:10b6:510:226::20)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|SJ0PR10MB5629:EE_
X-MS-Office365-Filtering-Correlation-Id: f22c5718-6014-4af7-e9e6-08dd507153eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VXB4QTV1dkRkcUtQMTJxUDQwV1Rlc2FjL1F2R29YbU5QemtleFl5QUp2c1J0?=
 =?utf-8?B?MzdUR1ZYdHREa3owd1o3MFpJblM2cjdzNFlSTy80VkVBemhlOGhPRjNycit5?=
 =?utf-8?B?d1U0b2V5YS9WaERhZUczaFJDTE1lRXltcjE5SXBCR1d5eG1yZy9OdzJXaXNk?=
 =?utf-8?B?NUJmOGVBNldlOHpSOXQzU0ROOFE3WStQcnpuY2hMUTFHb0hNTHhRNWJRdVZr?=
 =?utf-8?B?TFBNVmNURjlRR1VnMjZ0ZC9TWWFINzVxOWpjalh3TFQvMWZlVU8yNnFqYmFs?=
 =?utf-8?B?WUFQeUt4c2ZxRVdtU2NheWl3eCs4WnRFOVdSY0RjMm9pNklrVXVMSnNxU29S?=
 =?utf-8?B?YVR6SlJlOFo4K2Z5V1RIQWRoajZUNzQvODNlK3gweG1rSldoTTE5UUh2OENr?=
 =?utf-8?B?OXpIUmdoc044TUlpR3lDV0lVR3FMZ09oQkQ0ZkgyU0E0NXIraFoxQVhyT09v?=
 =?utf-8?B?aEt1R1lwdFBRdVVYZFJTaUcxVGZPWWo2cWs4dVhqTTdSd2RZUEJGOWFpbFgv?=
 =?utf-8?B?bVBqSFQvdHFHR1lTMmJmSTZLdkhWZ29rWEcxditEdDd6T01sNEkzanVWSTNB?=
 =?utf-8?B?MGdoNlhaSUtQdTh1K3FOdlBwWStrdXB1ZlIwU3VZYVhTQzJ3SjlCRWdlTU50?=
 =?utf-8?B?blBDM2Y5elhuaElzQWdPQTNFaFFrWUtUQ0VhMUxxdEd3Q3NUdzJ5Vy9RODk2?=
 =?utf-8?B?TDhzdXZzUE9CT2tDNTY4ak5WM0hjWlkyRTFaZ1MwYlFUQ0FLaklHZFBpVm11?=
 =?utf-8?B?UHhYLytYaUQ3ZVExaGZUZDNRNlI0ZFRySU95YVVDMm5oMUtkZVZzYXcwekwz?=
 =?utf-8?B?bmEySXZEcGNJd0xXZHUwRElDR3ZNYmsvd0JjcWd6TUN3ckExbS9nQUJiV0Jz?=
 =?utf-8?B?RVlmOVNDNkNKWmRMdUt3U3pWWHZXTkw5YThJdTdCVThNazArTk1BRXZ2NWhC?=
 =?utf-8?B?N3VJUEF0NWQ1M25SaTgzOEhpYmorY29tZkpyTDdSOGdDZE4ya1VQbjlBUDh0?=
 =?utf-8?B?SmNZeGlCeDZSTFRzQ1BZblpxL2dZa28yRVYxZXorR21lT2pwampjeUlkSkVK?=
 =?utf-8?B?UktaQzRqTGRabEtkdkdIbGRLQzZxaURUWVdxbzJDcmdiQ0NjRS9ER3JGRlk5?=
 =?utf-8?B?V0IrR1RmRW83MUdZVnFhV1BBcDJhVHhodGFoa3hlMnN2QlNHdUcrU2tjUEJ0?=
 =?utf-8?B?UUVVa3J1VWJrZjdUbUtZRTFtTFVUQ1hzcUlMaXUwZGFmdVJaOTN0dTdHSzVM?=
 =?utf-8?B?ajNyUzdoMm4wRFJsYUoxUUlVNmNsd2tuZjgraXdxNEJSa0pJSlZmaU1WWitB?=
 =?utf-8?B?T0l0WVR4WEd6R01oYVV2QW9XM3VZNCs4Mm1PNFRHM1FlUzVyQmhNY2NIMksr?=
 =?utf-8?B?R3JjTld3TEFVVVZZcHF6Q08wWXdrSU5oUTd3WnhzRjBjd0p0OHZFeXRXb0VZ?=
 =?utf-8?B?Z0lzenl4bUVqU1VsTXQ5VlQ2M0tEZEt4SStZNHpQSVB2VXRoY0loT1cxSUhn?=
 =?utf-8?B?amkxWTZvL0c1OU91RHRSY21tVzlkYXJSMk1iM3JZVE5tTDYzWm1CZlVWRlBI?=
 =?utf-8?B?V1EyWitqMnpLRUt4WGVQZTh2cDg1aFFrUVBqYWtJT2dhaCt6SU5CMlJpM2RC?=
 =?utf-8?B?YkhkTXNOVjI1ZktuSm1EcW9nRks3YjBBdCszS2NNYkJBSlRoWWFTRCtRUEha?=
 =?utf-8?B?VGkvUmhLT21pazU5eitNTmYvSnlmSFhsQW9JQ0Y5djZTYmNmVjJDQlBFODl2?=
 =?utf-8?B?N3A1VVEzMDZzU3NyUVBldGlVdG80M1Zzb0ZWZlhzeUZnVG0zaStzb2M2M0dH?=
 =?utf-8?B?REFZL1lVZVpiQ2xRVjNBa0FYRGxMWmdVanNYWGxBYTJhZ1JJRWNBYWM2Y00y?=
 =?utf-8?Q?86qQ43oCKgJ2O?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6597.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WkFVellsNy81eGpZSE9PRDRyOW1abHBoZDcxSDJFaWtrVkxwTU5taFV4SkpH?=
 =?utf-8?B?aTRpRUhhc1NGSTVZSTlnQzlYQnRpTm9yV2VLTVFjVlRPRTI4VkFIU2tsS0VC?=
 =?utf-8?B?a1dkK1kzQnJzK2ZleUJaNHhKSkJYTGZlaThpb1dpQnlNMFpnVXRMYXlHTjRH?=
 =?utf-8?B?QWVOcDczYmdXQXZCSmtzN3B0cUg4S3J4VDh0L200ekorQkJLaDVrdXdtVzJU?=
 =?utf-8?B?cS9uVzJyOEd1MXovRTI1cDU3Q3o1Q0NCL1lKS0RMczA3TjJIdS9lUWlCZFIy?=
 =?utf-8?B?TmlWN3lwMjVqZk9GTFgrRUt0TWlQalBCWVBSVk9jN0lUSjlPdHZVQVh3S25h?=
 =?utf-8?B?K2QycTQ1SjVVNzRReWl5UTQxTG55VWVueGtuNzZZa2Y5L2JrR0VDLzFJdE5V?=
 =?utf-8?B?Q28xYmFFdy9aNDBlakpZdWM4Yk5yd1MxSkdZd21KeFdvVnBCc0FnSitCNXZ5?=
 =?utf-8?B?SGJlODdsL0F2dWNQSUgvemNTVzF3a29nVVpJM2EzTjJsU1IybjYrMTg5TVVt?=
 =?utf-8?B?QkFJVEhPUXB5eGsvZ0E1T1I4dk5keGh3dFVubGc0NXRUQU16V2tUWlluSHdh?=
 =?utf-8?B?azh6TTMzTG41SDNtZUVCa2lLOWJxM0dISmpWdnV3RGY2THVsYysvdVFhU1E4?=
 =?utf-8?B?d0lxSlpsdENRTjNvRFMxdVR6Vm0xSlRJMDl2bGtqbzR6amtjR0NRQmdMMnVr?=
 =?utf-8?B?SEE1Tk9hbzBFdXg2aGwyaVZtZmJnYkNrL1Qvb2RSZHZaUlJmQWVUaHFKVWNq?=
 =?utf-8?B?b0NvYVlXK2JMNmdXMC85ZzQzVmkzeTllMGF1cFd5cWZ2QlJxeFJucnVjRDdU?=
 =?utf-8?B?Nnd1YlFpdmhUV1QyN2ZBUGdrbmYwSFRLeGhaRk1MdGlENnF3Tm9rZ3ZzcHdm?=
 =?utf-8?B?RWd0R1pUaG0zT0ZnbTByK25ic3ZwN2xWb0FFMndNOEFCY0JYTEpUZXpsUGtn?=
 =?utf-8?B?MFcyNTFkYlhDM0g2VUFZT0NLRzJFallZM1hPSFlwTDFjK2F1UW5NLzdTT1Mw?=
 =?utf-8?B?RlM5amFwTlpmSVVFKytzZ1FuUlVHL1FxK2Yza0duTEVxbXROQnk4WnB3djNI?=
 =?utf-8?B?cW9jbElpUU85K1JSQTNpR2x2RFdHMW90ejdJd3pzU3ZuNmJ6OWYzWHFXdzRR?=
 =?utf-8?B?RVlSTmJpbjRjTENTeG1KeEpiOU1uZVc5aVpYTXRPMGt5dFFwdWdUSDljMlRU?=
 =?utf-8?B?MVpWZjlGY3VxK0tIajZKaEZKZ2JaTEswQ1E1M21DdDJmUHZRaEYrcHdwS2kw?=
 =?utf-8?B?WjZlVHBVL3hHYkhWT2xVbjZiU0tSZW5pa0hRejNGT1FBVUtSNnVUa3VPOGVo?=
 =?utf-8?B?MW8rWVZHekRYc2RQWkw0ZHAwYnQxbFF6TDVwT2xBQUUwMVVrelRIcFZmWWox?=
 =?utf-8?B?ajFVUDJOekpBakFiNC9qc3l5VXpBaUJmbXpOTTlwZm9IMjhRbTh0UG5Uc0Rt?=
 =?utf-8?B?czBCZlVjZXBzRXlEdmhOZ1hZQXdDUGZDMFllU1FwRHo0MVIrYlNuUmNPWC9L?=
 =?utf-8?B?QlNndStRZC80SldvenRZTmNwczg4TndrZWo4NXdVeDFTNVZCWUUrNEUzeEFK?=
 =?utf-8?B?dFVURFpGUWwyMzdQSkFwbCtUTllrMmVldTIzL1R6VVlXVzFTNmYvamUrbVpD?=
 =?utf-8?B?QW55T01IZHR4b2tXWnhDOC9zbjMyTWFTaXk2VHZrVFRib3hUT2daSW1ETGVE?=
 =?utf-8?B?dFlQSzFVWmpvSnJ3S1NoWVZjWVE5ZDEzV2hHc2FiRXRGRU56TjVFRlFQVm5j?=
 =?utf-8?B?V0dCdER5ZXZneExjb0R0aVZxTVY1aStkM2Jyc0ZLdUhGQytiSzBKU0JqQVRE?=
 =?utf-8?B?K1o2OHBVekNUd2xvc1haajRmcnZxRTdUZVNvNm82d3hoZWhFQkJmL3lUNlpP?=
 =?utf-8?B?YTI1R0FVSE9INTRsOTRBMkUzWk5vYXVmK1V1ODZGeHM1ZFl4TmJ1Z3I5anpL?=
 =?utf-8?B?N0QvTTRtUlZ2aFlGWWJDQlkwbFZJZGpsS1oreWM4MHRPU0lGZ3F5bmI5a0NJ?=
 =?utf-8?B?T25RUldHdkNGSkR1TUNOSWh3OXpsVnhwNUR6Qk9ST2tUSEFoTkhTT1JTQW8y?=
 =?utf-8?B?dFNlWndRcytNandJWVp6SWNkWlNZUHVpLzdRdi9pc2N4dTZ5MDlObnJHZGF6?=
 =?utf-8?B?NHhnNmtEUUdweU5zWGo3cVFvNFQzdHJJUkV5Y3YzS3hRVGJoYWt0SEZsRWZt?=
 =?utf-8?B?Tmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2qPxDycVHEKLomEgm1wGUBTR46/b1RbGEGEx+T2jyAhS5YiPRImMtoztXQ+YEP8ToQZwT2dKSHvULWwEHnyckFQ+PxugDtMQBq4g3mmyhD1twH22zKqTEOQlky3C9IyqccbmJlQmvur8BMkm3FNbApniJq0KzWz6GaoAx7vy+3dk6Yxf1uU5A7ShpxlguwPnsHMRBmSQXBZLpS7L29sqXZSeirDGGcwOJgJAE5M5UoabGA01PmQ5VE+s6Fc+RJNNI+fkGURzsZDpUMCnCn+XPnavTazUGLM1Hn4vTLjp9mTcA547X2Mf7aGFbffw6WnbJg2lj9m3zl5xz3c0Pu/O3u4O3/e6n/Q5pKiJ0wjr4S5whxLzSnVo/O7lf1ph9IAG51J2x2OboDokcaL257KDURCu7T/8Zna1oBaz0fef+N8GRtTohC8ta9IJ8o14XzidMefy8+t2sddpy3ldFkGmtWcb+ZLIxpaW+HVqg3KCcOI2UBsqy6SnV/jcr1DXNejOBYEnzeUlnQXdfHIyoTFDNW0jrdN7bXKYGISak7hxCGJSw7dq4nBrJ2ybN17SK40wUap439wv3dmGCrF1njJQsAacJhqNqgxdHQ6fDYHy0hw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f22c5718-6014-4af7-e9e6-08dd507153eb
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 23:09:42.8216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: APlBaAOMcnFfXoeu+uEei3Bz41oUyJUX4FfT3C04TJ1KT78lledOEFy6wTpUyW98RMtjbA3bQNj6gev3Ttu90n6uOGTCBp1T/hKx301iQlo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5629
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-18_11,2025-02-18_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502180155
X-Proofpoint-ORIG-GUID: WAWgcxRKevVX-rJ22icTVapGOQlmTQWl
X-Proofpoint-GUID: WAWgcxRKevVX-rJ22icTVapGOQlmTQWl

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
> On Tue, Feb 11, 2025 at 3:59=E2=80=AFPM Stephen Brennan
[...]
>> We can dust that off and include it for a new version of this series.
>> I'd be curious of what you'd like to see for kernel modules? A
>> three-level tree would be too complex, in my opinion.
>
> What is the use case for vars in kernel modules?

The use case would be the same as for the core kernel. My primary
motivation is to allow drgn to understand the types of global variables,
and that extends to kernel modules too.

>> module BTF size increased by 53.2%.
>
> This is the sum of all mods with vars divided by
> the sum of all mods without?

That was a poorly done comparison, so let me provide this one that I did
using 6.13 and these patches. It was essentially a localmodconfig for a
VM instance, so I could still do better by picking a popular
distribution config. But I think this is far more representative.

MODULE                   BASE   COMP    CHG     PCT
drm.ko                   115833 123410  7577    6.54%
iscsi_boot_sysfs.ko      2627   5380    2753    104.80%
joydev.ko                1816   2289    473     26.05%
libcxgbi.ko              24556  25266   710     2.89%
drm_vram_helper.ko       22325  22751   426     1.91%
nvme-tcp.ko              25044  25973   929     3.71%
vfat.ko                  3448   3953    505     14.65%
btrfs.ko                 275139 343686  68547   24.91%
libiscsi.ko              21177  21977   800     3.78%
xt_owner.ko              449    803     354     78.84%
nft_ct.ko                4912   6157    1245    25.35%
iscsi_ibft.ko            3967   4463    496     12.50%
pcspkr.ko                283    682     399     140.99%
crc32-pclmul.ko          390    771     381     97.69%
nf_conntrack.ko          23686  28191   4505    19.02%
iscsi_tcp.ko             16827  17750   923     5.49%
nft_fib.ko               835    1117    282     33.77%
nf_reject_ipv6.ko        699    981     282     40.34%
rfkill.ko                4233   6410    2177    51.43%
dm-region-hash.ko        6214   6496    282     4.54%
cxgb3i.ko                35469  37078   1609    4.54%
dm-mirror.ko             7576   8191    615     8.12%
pvpanic-pci.ko           174    574     400     229.89%
crct10dif-pclmul.ko      146    525     379     259.59%
nvme-fabrics.ko          17341  18124   783     4.52%
kvm-amd.ko               47302  51914   4612    9.75%
crc8.ko                  221    405     184     83.26%
ib_iser.ko               27769  29116   1347    4.85%
sg.ko                    4234   5656    1422    33.59%
intel_rapl_common.ko     5678   8446    2768    48.75%
bochs.ko                 35643  36997   1354    3.80%
sha1-ssse3.ko            790    1305    515     65.19%
kvm-intel.ko             53802  59220   5418    10.07%
nft_chain_nat.ko         279    714     435     155.91%
vmlinux                  5484970        7330096 1845126 33.64%
sha256-ssse3.ko          851    1378    527     61.93%
nf_nat.ko                6341   7240    899     14.18%
configs.ko               72     256     184     255.56%
xt_comment.ko            151    507     356     235.76%
ccp.ko                   30433  34782   4349    14.29%
cxgb3.ko                 44981  47504   2523    5.61%
crypto_simd.ko           1331   1613    282     21.19%
iptable_filter.ko        855    1456    601     70.29%
qedi.ko                  70653  72786   2133    3.02%
drm_kms_helper.ko        63238  65000   1762    2.79%
cnic.ko                  117074 117790  716     0.61%
failover.ko              780    1216    436     55.90%
nft_redir.ko             874    1529    655     74.94%
serio_raw.ko             708    1234    526     74.29%
nf_defrag_ipv6.ko        1520   2253    733     48.22%
nf_defrag_ipv4.ko        306    770     464     151.63%
nft_reject_ipv4.ko       517    939     422     81.62%
nft_nat.ko               1192   1732    540     45.30%
nft_reject_inet.ko       554    976     422     76.17%
fuse.ko                  32181  41859   9678    30.07%
nft_compat.ko            3705   4404    699     18.87%
zstd_compress.ko         42597  43622   1025    2.41%
tls.ko                   15140  20683   5543    36.61%
virtio_pci.ko            8456   9193    737     8.72%
blake2b_generic.ko       1364   1699    335     24.56%
cryptd.ko                3697   4297    600     16.23%
xor.ko                   1358   1879    521     38.37%
intel_rapl_msr.ko        2851   3440    589     20.66%
kvm.ko                   177060 256377  79317   44.80%
cxgb4.ko                 215865 220844  4979    2.31%
bnx2i.ko                 39524  41477   1953    4.94%
dm-round-robin.ko        1795   2123    328     18.27%
virtio_pci_legacy_dev.ko 909    1191    282     31.02%
qla4xxx.ko               79040  82694   3654    4.62%
nfs.ko                   108350 169642  61292   56.57%
libata.ko                47301  66188   18887   39.93%
ghash-clmulni-intel.ko   578    997     419     72.49%
nf_reject_ipv4.ko        706    988     282     39.94%
nft_reject.ko            820    1196    376     45.85%
sunrpc.ko                127496 197841  70345   55.17%
nft_fib_ipv4.ko          803    1257    454     56.54%
scsi_transport_iscsi.ko  40419  57633   17214   42.59%
lockd.ko                 36144  42137   5993    16.58%
drm_shmem_helper.ko      32555  33043   488     1.50%
nvme-core.ko             50275  58298   8023    15.96%
iw_cm.ko                 13405  14796   1391    10.38%
mdio.ko                  857    1041    184     21.47%
bnx2.ko                  20354  21611   1257    6.18%
net_failover.ko          1742   2187    445     25.55%
ip_set.ko                11812  13093   1281    10.84%
libcxgb.ko               8698   8980    282     3.24%
dm-multipath.ko          8124   8898    774     9.53%
grace.ko                 462    890     428     92.64%
virtio_net.ko            12322  14896   2574    20.89%
qed.ko                   228735 232231  3496    1.53%
cdc-acm.ko               2923   3679    756     25.86%
i2c-piix4.ko             1124   2341    1217    108.27%
pvpanic-mmio.ko          177    625     448     253.11%
virtio_scsi.ko           3154   3898    744     23.59%
uio.ko                   2602   4295    1693    65.07%
nft_fib_ipv6.ko          956    1410    454     47.49%
cec.ko                   28370  29266   896     3.16%
qemu_fw_cfg.ko           1601   3476    1875    117.11%
ttm.ko                   23672  25727   2055    8.68%
sd_mod.ko                9976   13030   3054    30.61%
xfs.ko                   574594 926637  352043  61.27%
libiscsi_tcp.ko          17444  17911   467     2.68%
ib_cm.ko                 32324  62373   30049   92.96%
aesni-intel.ko           3370   4922    1552    46.05%
drm_client_lib.ko        27449  27794   345     1.26%
virtio_pci_modern_dev.ko 2537   2819    282     11.12%
rdma_cm.ko               32504  51823   19319   59.44%
fat.ko                   11958  13297   1339    11.20%
dm-log.ko                6529   6986    457     7.00%
pata_acpi.ko             9231   9700    469     5.08%
ata_piix.ko              10998  12598   1600    14.55%
ipt_REJECT.ko            956    1311    355     37.13%
drm_ttm_helper.ko        33160  33544   384     1.16%
be2iscsi.ko              55078  56993   1915    3.48%
i2c-smbus.ko             582    973     391     67.18%
cuse.ko                  8435   9241    806     9.56%
nft_fib_inet.ko          579    995     416     71.85%
ib_core.ko               103656 123701  20045   19.34%
pulse8-cec.ko            9153   9890    737     8.05%
pvpanic.ko               494    1087    593     120.04%
dm-mod.ko                31377  35265   3888    12.39%
raid6_pq.ko              2774   4207    1433    51.66%
nft_reject_ipv6.ko       517    939     422     81.62%
cxgb4i.ko                47490  49021   1531    3.22%
ata_generic.ko           9008   9666    658     7.30%
vboxvideo.ko             47622  48844   1222    2.57%
ip_tables.ko             3109   3564    455     14.63%

ALL MODS                 9153268        11895301        2742033 29.96%
vmlinux                  5484970        7330096 1845126 33.64%
TOTAL                    14638238       19225397        4587159 31.34%

So this shows a 1.8 MiB increase in vmlinux size, or 33.6%.
And for these modules in aggregate, an increase of 2.7 MiB or 30.0%.

> Any outliers there?
> I would expect modules to have few global variables.

In terms of outliers, there are groups that stand out to me:

1. Large percentage increases are usually always for modules that had
very tiny BTF before. The module system inherently creates a few
global variables for each module, so there's always a slight constant
increase of the BTF size (184 bytes, as far as I can tell), and in those
cases it can be a quite large percentage. Here's an example,
"configs.ko" which comes from the CONFIG_IKCONFIG enablement:

BEFORE:
    $ bpftool btf dump file ../build_pahole_novars/kernel/configs.ko -B ../=
build_pahole_novars/vmlinux
    [127877] CONST '(anon)' type_id=3D11124
    [127878] ARRAY '(anon)' type_id=3D127877 index_type_id=3D21 nr_elems=3D=
1
    [127879] CONST '(anon)' type_id=3D127878

AFTER:
    $ bpftool btf dump file ../build_pahole_vars/kernel/configs.ko -B ../bu=
ild_pahole_vars/vmlinux
    [162827] CONST '(anon)' type_id=3D11124
    [162828] ARRAY '(anon)' type_id=3D162827 index_type_id=3D21 nr_elems=3D=
1
    [162829] CONST '(anon)' type_id=3D162828
    [162830] VAR '____versions' type_id=3D162829, linkage=3Dstatic
    [162831] DATASEC '__versions' size=3D64 vlen=3D1
            type_id=3D162830 offset=3D0 size=3D64 (VAR '____versions')
    [162832] VAR 'orc_header' type_id=3D8667, linkage=3Dstatic
    [162833] DATASEC '.orc_header' size=3D20 vlen=3D1
            type_id=3D162832 offset=3D0 size=3D20 (VAR 'orc_header')
    [162834] VAR '__this_module' type_id=3D312, linkage=3Dglobal
    [162835] DATASEC '.gnu.linkonce.this_module' size=3D1344 vlen=3D1
            type_id=3D162834 offset=3D0 size=3D1344 (VAR '__this_module')

What is, I think interesting, is that the types in that module were
totally useless to begin with, because they were used by a variable
which didn't even get emitted. So while this is a substantial
percentage-wise increase, I think it's a net improvement for this and
other modules.

2. The largest absolute increases come from large, complex modules like
xfs, kvm, sunrpc, btrfs, etc. For example, xfs had 5696 VAR
declarations. What is disappointing is how much of this is due to
automatically-generated "variables" from macros (e.g. tracepoints):
Here is a list of variable prefixes like that:

  print_fmt_*
  trace_event_fields_*
  trace_event_type_funcs_*
  event_*
  __SCK__tp_func_*
  __bpf_trace_tp_map_*
  __event_*
  event_class_*
  TRACE_SYSTEM_*
  __TRACE_SYSTEM_*
  __tracepoint_*

These are, unfortunately, all valid declarations produced by macros and
they correspond to valid symbols as well. If you look at the kallsyms
for the modules (and core kernel), these variables are present there as
well. It may indeed make sense to have kallsyms entries for them: I
don't know.

These are all, as far as I'm concerned, totally uninteresting types. If
you want to access any of this data, you probably already know its type
and wouldn't need a BTF declaration. Unfortunately, the flip side is
that I don't think we have a good way to automatically detect these,
outside of prefix matching, which quickly goes out of date as the kernel
changes, and can have false positives as well. For kernel modules, many
of these may appear in separate ELF sections, but for vmlinux, they
don't. I'd be happy to eliminate types for these auto-generated kinds of
variables, if we could somehow annotate them so that pahole knows to
ignore them. For instance, maybe we cauld use

__attribute__((btf_decl_tag("btf_omit")))

as an instruction to pahole to omit declarations for these things?

Thanks,
Stephen

> So before we decide on what to do with vars in mods lets figure out
> the need.

