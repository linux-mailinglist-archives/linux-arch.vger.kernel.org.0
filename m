Return-Path: <linux-arch+bounces-9830-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23916A173FF
	for <lists+linux-arch@lfdr.de>; Mon, 20 Jan 2025 22:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6CE81883562
	for <lists+linux-arch@lfdr.de>; Mon, 20 Jan 2025 21:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9289F1EE02F;
	Mon, 20 Jan 2025 21:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="keYWi2oo";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nfpJ21eI"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7663F188A0E;
	Mon, 20 Jan 2025 21:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737407683; cv=fail; b=hfOjZWqJDEK2zOs3yjzbXRrzZ2S9/KY3eEYfH4kkTBqIj+F131ReXwVAkAoEqDv6Jv2zhllrwhnG9UPZ0tH16Yul+Z1aBopZThim16mxuxI5SMoaoLIx+ROgUVayzZeD3aXAPdqU/BpKNguWRzdgashMFpp24DVVjyRl8YLEO+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737407683; c=relaxed/simple;
	bh=WgawQiZcqQsudbQnfsZWTzADJPbSNBA/VQffDFkagwo=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=gOF6tcR15sBEY9MrncsQ9aNVdIItRZ/iPEGtL4FGF9gzfgOJ+5dEGTAbfHpI0q0CWuRMP+sTFQMyNMqbVg7X0wCmpbsvi5ujmQ1O8unR9BX9Gabd+FA6WkKoWRVUxkR/BMkZ4aenqmO6w7ybijT0J8p8BZMqLSJWp5f8gCQ5uMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=keYWi2oo; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nfpJ21eI; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50KGMvih001612;
	Mon, 20 Jan 2025 21:13:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=TAQoZ1WKIsTuj0ZwWM
	hcxNVA61FgPdAcJrlWcbOlo04=; b=keYWi2ooKVZ1NGr8LWohM1o9JA579/5lIc
	Je5Lz6fjuPBSbD3xzQPeInkETR/y8gtKTosCEEFzZc90tvfy1I1mJmMLaFwHhjR+
	EXlql4SEyWMXWFjIiAEUSqCiCANKpQ1qP1dbl25ctISuxEMabuBnv3fsn9snn9jU
	ThRXLyzhxmoNQ4y4RD+jo3PO+RTUobhKZies5u8u++C8mrPlvpoCcrBvH+Z8UR82
	+ZAZ3PAlfADvg4NyDuNd2S0q8uHArmFnZ+wwqp17ah0PtwQbge8/iTEnwZ3imZHE
	vcU36N6x2HaaBGfbpBsqzVzD9jk1FFqF+uVwPyEuGlUppHLJabdQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4485tm4awd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jan 2025 21:13:45 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50KJqHnR030442;
	Mon, 20 Jan 2025 21:13:44 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2045.outbound.protection.outlook.com [104.47.58.45])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 449191r162-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jan 2025 21:13:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G9xk5ftBSY8MQkkq3+vJjtcVCoP3xbdahY6xWoZkX/r5MyOwmLnH9UY186WluKRrJJXMIJi8UCIZ90FtnOWX2iMBe4uTBBR+rm+7Ly+6yIgsMjkaymU+3KpqOVqQItLlaEM2G56j0s9kNwmqZHlc8VD2dyKJfbsrnPsIQ6OtHfyH30WXzt/z1/xCIXv5euLKN/hTit2nFhWv6eks9pmDlpGL+fcJijUgjJ3/E/q2mZ3a/vdtGOIJbzr9ZowZurmLiYsxaeUONn4nQQFw5toY+/tqhWLfeJJTPTYAj/f32PX2Oo5+jzYaZNw/Kw1re4K+vnpuq9gruX4r0kLNnKx8lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TAQoZ1WKIsTuj0ZwWMhcxNVA61FgPdAcJrlWcbOlo04=;
 b=s/zAipc287hGH8LTBWkzfCibMDcdUlNAqgk9rDw3e06qzpng8sscquwYFHoXIJIlq01LVJ7G+EkmN5oVOgULN4z81Gn+eg93JfQE4uaylqUn6ZmHgZ2esIiuLO0P4n0SDaGJcQwRykLejkvB0VK66XNJl+ZZ/7o8a/YThz3UYExSRp0CxjpfyIpinp5dkVPwzhyBKbwTXRID02eC+Ud9bfhmzVcz9J3sVdtRo++Kfv5/MZCcIk31APPwzrqBiNxbXFzkNvI0aMdBpzhZIxiKN6sQVV+RWWulIPM7iqv8V8cgNk6glMK58AunV8bYLXwARlQf4OfV13MYLwQiC+7UYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TAQoZ1WKIsTuj0ZwWMhcxNVA61FgPdAcJrlWcbOlo04=;
 b=nfpJ21eIW636AUoSw5eNJjT53k7RLpa2GdoQPwpI2Enjb+ptoFJ8yNvOC8a3zxgse88Yq+1PT8uCCKGM2UC+nyTcl9kRl2R0HDGHQ5PfjoqW1mSYbl26P08cC4an16STXH7BzVx4Ea2os3wmAsykKSFm0qWR7w+BdkKeKqUD5WA=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by BY5PR10MB4164.namprd10.prod.outlook.com (2603:10b6:a03:210::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Mon, 20 Jan
 2025 21:13:27 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%3]) with mapi id 15.20.8356.020; Mon, 20 Jan 2025
 21:13:27 +0000
References: <20241107190818.522639-1-ankur.a.arora@oracle.com>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-pm@vger.kernel.org, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, catalin.marinas@arm.com, will@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        pbonzini@redhat.com, vkuznets@redhat.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, peterz@infradead.org, arnd@arndb.de,
        lenb@kernel.org, mark.rutland@arm.com, harisokn@amazon.com,
        mtosatti@redhat.com, sudeep.holla@arm.com, cl@gentwo.org,
        maz@kernel.org, misono.tomohiro@fujitsu.com, maobibo@loongson.cn,
        zhenglifeng1@huawei.com, joao.m.martins@oracle.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH v9 00/15] arm64: support poll_idle()
In-reply-to: <20241107190818.522639-1-ankur.a.arora@oracle.com>
Date: Mon, 20 Jan 2025 13:13:25 -0800
Message-ID: <8734hd89ze.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0057.namprd03.prod.outlook.com
 (2603:10b6:303:8e::32) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|BY5PR10MB4164:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e8417c4-de8c-4fcf-e4de-08dd399747f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JN3OB5lDIe1kqGhnjizyesMrLmg2/oV4gvIW7fUOXzQpTRqZJlc93wdyq/jP?=
 =?us-ascii?Q?z7+QckLnhH2FS66QEK+XsZkfeMyHCxidn5uVduS+O8zL85jbwUKv4OyfudCB?=
 =?us-ascii?Q?AI/6Fmd7GsNaS/I+hmGHHLmnsiZ15F64R6o2VYEAnWK+2kYWO2gpPay4ug6N?=
 =?us-ascii?Q?IdJoXmLHtR0fpMdLiyrV0NC33H2M9HySLvrwlZ8n2Xk7QbibUuHHFPH6lMXW?=
 =?us-ascii?Q?hV7rPBUevrjoamlJTRpnQKJPrSbec1yuPnP1ALb4l5Pf4j02mcQ+iQZQJg+s?=
 =?us-ascii?Q?rsPiNX6Zt3jDQMAq4sWyBD0bYJSnsb2mJwLiO4xHODKMnkSgmqsY5I8zFQKP?=
 =?us-ascii?Q?BE3r8kpU1DMG4LP4Num021l3u/7oFB8QT7BNaRHGG6CoACAPZhJ8fwA+ImRh?=
 =?us-ascii?Q?Ja/6mLUEyvY2HjJHdEH6pn/5YIVvRoJFpA1jYUDbK0f1jUAHypKmBX4LThGR?=
 =?us-ascii?Q?43zVyXysBtXIn7NcTlDuOIh1q4varaj6qwiXDLaFSTuhn78byYs8h6YqqFQC?=
 =?us-ascii?Q?TSkxAz49K9Iv+tffFTdRj+8cj2PywGLmf6n6z8BqWOaRz0V9G1UCDFlCKWuc?=
 =?us-ascii?Q?BRg9xUa2wJ0azNulmC56ALdmv+O0vRAUA2gK9qp4+wZRgKIiHxzNQ62DdcR9?=
 =?us-ascii?Q?NVNAKneb/uhLXeZZ3bCfiwBGIqA7Stri3sDAlXCfewkfCiXo9hMiGhlS22YF?=
 =?us-ascii?Q?WL0RLG/ts53wj7cEgjAiBuVPngrnY03s3Tj+DkvouZ0OtiwrmpFRw6T/58sF?=
 =?us-ascii?Q?+RpUhHY6BHcKv4th/xb3aWKp6PUmnR4Vmj5G18yTS15r4l6FGiiD1hTHdJZp?=
 =?us-ascii?Q?E40D+wiH/dDgVy1HPkBi1Emoq0AHV0dH7jeVn98mhRKl3zoluzyxYob8QwAf?=
 =?us-ascii?Q?6M5qU+GQrAg5r6Vd1tr3oy4rjMvLqW0EWpQPKkTpTJiC7ZhKLDd2aag49/VO?=
 =?us-ascii?Q?YsVhsZ76rdKnrkgyYVo8N4EX+Y9HM4FsfNZOoxd2KBVpQFOpsKzf/FsVCiFl?=
 =?us-ascii?Q?XogwsW4SjXp6NwqCL4RNiyUhZRjkURyG77lTl3iE45Lblk+U982FKo55NYAA?=
 =?us-ascii?Q?cme7eeQHZWrrI6E51TgCGISp3TmtuQcWjGk8aQkV/wbh1S0xePbTLDBsumBk?=
 =?us-ascii?Q?C0NsDSgF35yLrm9PsfZZbIjoTpaBxoIWi3tTyguyezr+8PXowKPqhU0PcOgT?=
 =?us-ascii?Q?SzI7c771nUaQ43QT+YMhpTh9V04yCGwEVRD3WvN4Lb0v7Cq46X/2MuIJogpu?=
 =?us-ascii?Q?Vqyw6MV/136+aNLrqvh5VOtttbBBcZu3ZG+W9ZmlShBNboktqQreqC9W6u8q?=
 =?us-ascii?Q?yFPR+7xKFMG/kwi3/ao1CrAs3fCRM/tik64dlB60IQxozA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bHgSNnvGPuqgKDlqWtrO0FU6zlJq4QtVWwpQFp9qTWjL0NnboCqR1neJJsDJ?=
 =?us-ascii?Q?E/6jRkJ6P8jNN0kFsZTexE3bLxKcnBgcn0MV5k6J3YCWRqhwyREZ4QDjvxZT?=
 =?us-ascii?Q?2rd+3qP+SOohr+Axbzm9T/rgj1uB1+3crAWVjVIZL2Z/Rda7ysUN0+YOpuZS?=
 =?us-ascii?Q?BfhesqwWNg22gT4oo/sVuW0UbTjtPm+VI3dlvYo2/+Kkfv0mPlqF6JAJxXw0?=
 =?us-ascii?Q?Y+gb/aSkcd+PdakUaLTT7kz3qE/4oHH4i67a/RMkr3yzrcaBmB8BA1M4KwgI?=
 =?us-ascii?Q?BVQZ0sNXXe4Sm51sWwQOlRJ/5DuiCOW16c2gM3YfRNBHDnpAgyoa2X+ILjf6?=
 =?us-ascii?Q?+hJAOLb6cay38KnzhovLjpcj1Ynqv3qQ9eGMR41KmKBoad7yzjTiPli6r68Z?=
 =?us-ascii?Q?M+xEznqGU1OJhPy5Yo52ZZUi/S/R+MUgpfW8Ki6LJzoGioqSmeAdQFz9hPRb?=
 =?us-ascii?Q?By9SEzh5ea6/bi/kcs+D0tHdzFVo9Mj1jaRbELET1fORhiFbhDSKzvB3OAOC?=
 =?us-ascii?Q?qEI53Uaf2meUJttbj7vynx10y9A2j8Z3B4PP1bH7dn+YREWlSRQb16nzHlaM?=
 =?us-ascii?Q?wl8OkhJ8Sk8jjYAjKSIGdqUqvZvpkYfvp4hdN43ZH28Z4xx7X/uOogEH+gI/?=
 =?us-ascii?Q?YSbpIlevhRb6Ps3h4EOnjHMWjQmjHk3WuROay8XpXYh+oFfq9Z3gujzHUOuH?=
 =?us-ascii?Q?OERQYRk7t4ArOzCmYssfUYu5B5Zu1LMxnnS0tQp2JIWQ9o3usDLogNaxbSk2?=
 =?us-ascii?Q?VTVKqWD9mK/wAQotaz/T96ZeYnJpHdT+romHlB63ltx6iSQmGgTFqI+WhRHj?=
 =?us-ascii?Q?ZVnYHMe8kk7veDIKyNEXVnmVfU/LK5JgK1o1CehEMWfjyWZ8fb1My/b6hlh0?=
 =?us-ascii?Q?SRONKKWjTbIXcgyvvdaa0Tbo0+NIEiCGYh8n9xqoIZWO9uhBoRY4PhNRXUjc?=
 =?us-ascii?Q?8CxA7dXFEsdBpNeRLYr3nLSSk7e56EFM/wdUcLAlfqQctQCoTci9LYXtlCoY?=
 =?us-ascii?Q?ctitiieRIW/nxVxRxP3vef4hRnzV2RKnmH+ABbhMnnQ1aOIf5sI4MM8dCJin?=
 =?us-ascii?Q?u/f8Bliv4eUFEwFO/pj78062F1FNTXFIff3gyjcgtPMxO75VSiOUzdZQj4DJ?=
 =?us-ascii?Q?3e1Rc7bgunuZJIE9ZSSkEVWKvGLWipmpNq0Kk0K4h6dRxFvj/Xrk3IPy/rB5?=
 =?us-ascii?Q?fycAZZffxPB+mZ6hY6PsBYaJJw2cq71fY24YFS2XxipDhwgG58KCLeKclzlo?=
 =?us-ascii?Q?LvvgUBKJytw8rAXjmGS4TH9UNrEEb0IqBC46DPPBvenwtQtPjmx9mbyAa7JD?=
 =?us-ascii?Q?FZF78msUUp547vNkD9bz34riKAYtSOfzicW+zJ630XSwqRrwyyO4CwcvS3rT?=
 =?us-ascii?Q?016Au0GFQEwLzkWXB8tswpbpLkPKzATofl5o9TbB1bBPok4p2qlaxYIoha0g?=
 =?us-ascii?Q?pZfOL7g9Nz9rE34fuyKi8bYBh68Pamtuhmn1QCJm+OpcTDd7YXbFvaSyboCi?=
 =?us-ascii?Q?w7b8UmFJBnWDYePwi4oHZ0pPkIjzLEx3tZtVn4oBiZY8ImnKqdCeNUu/Hba9?=
 =?us-ascii?Q?z36aYq+53j3RTeEEvXat4/OiBqXtgyH5kcK0BJ5LX2MMrJFNp5YEPgdT1p0E?=
 =?us-ascii?Q?3A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	eqnzNMzoUeaBXaJoVlicfm8/TAhuWtnkQQaWxZx07Bh5GAwxhqivLH2hlhC88loeiEzcpG/nNEdvcqIuFGTNKAycYx6jgFxQRp4McE9W1OiFmx+8EATt671vBaFN8PoHRVhGv2UAQ7bCjTMkSXuqZgbHNihPw3TR3Nj9lcuERczNHfYh5JUhZ2g2U6tVZYDMGYusQdq5ajifZmQrDsfxFfMF/Pf7MjTxE35oCY5JjxgA0Ayjb/ThwxLVZAxberpR8mIPA3uw0+g/nsipG5anRMUeR0XjIEInVzpr4d6KC45Pkq0AUDG+sL87VlzcGBx8rWXYhdGZ3snq/7wyg3zoPPv7swgGSXDTlMgxDeI54PjwMmG4k3L3wdY+Z/wlKGqDvbBix8oxbk++JaL5YeDs4oPf7t+hQm/EDmoRmyyKhk/Fpgx7IsJyREs9tt9H7SmQAOucsg2mwPWRPEy6ymwxecV1vBRrvZmnp068PqW8kRA6gSguwwJO9dcyLbNkI3OBuQa5DzO54FtGp3OadNvyvprRmA1dMjuJN+VqYE8nKnpUAeoknnyQriRUtB27P+UoN0i0+B7zMT3CFnt1qH+bKLUQ3+W3RB40fh7li/CqYF8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e8417c4-de8c-4fcf-e4de-08dd399747f6
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2025 21:13:26.9943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: efkNbzUfqRMvQDznKVLb5DhnVL7Uuhz62HAayGlUMEmOjlkStU3MjT7HswRozahrcvea+APhzPSq6ZIDB82dmJy5r21oHiYy8meaxM005S8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4164
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-20_06,2025-01-20_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 suspectscore=0 mlxscore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2501200173
X-Proofpoint-ORIG-GUID: NEJPyvhrRhTQ73SsZuZL6cGEDTIdLa5d
X-Proofpoint-GUID: NEJPyvhrRhTQ73SsZuZL6cGEDTIdLa5d


Ankur Arora <ankur.a.arora@oracle.com> writes:

> This patchset adds support for polling in idle via poll_idle() on
> arm64.
>
> There are two main changes in this version:
>
> 1. rework the series to take Catalin Marinas' comments on the semantics
>    of smp_cond_load_relaxed() (and how earlier versions of this
>    series were abusing them) into account.

There was a recent series adding resilient spinlocks which might also have
use for an smp_cond_load_{acquire,release}_timeout() interface.
(https://lore.kernel.org/lkml/20250107192202.GA36003@noisy.programming.kicks-ass.net/)

So, unless anybody has any objection I'm planning to split out this
series into two parts:
  - adding smp_cond_load_*_timeout() (with an arm64 implementation)
  - arm64 support for poll_idle() and haltpoll


Ankur

>    This also allows dropping of the somewhat strained connections
>    between haltpoll and the event-stream.
>
> 2. earlier versions of this series were adding support for poll_idle()
>    but only using it in the haltpoll driver. Add Lifeng's patch to
>    broaden it out by also polling in acpi-idle.
>
> The benefit of polling in idle is to reduce the cost of remote wakeups.
> When enabled, these can be done just by setting the need-resched bit,
> instead of sending an IPI, and incurring the cost of handling the
> interrupt on the receiver side. When running on a VM it also saves
> the cost of WFE trapping (when enabled.)
>
> Comparing sched-pipe performance on a guest VM:
>
> # perf stat -r 5 --cpu 4,5 -e task-clock,cycles,instructions,sched:sched_wake_idle_without_ipi \
>   perf bench sched pipe -l 1000000 -c 4
>
> # no polling in idle
>
>  Performance counter stats for 'CPU(s) 4,5' (5 runs):
>
>          25,229.57 msec task-clock                       #    2.000 CPUs utilized               ( +-  7.75% )
>     45,821,250,284      cycles                           #    1.816 GHz                         ( +- 10.07% )
>     26,557,496,665      instructions                     #    0.58  insn per cycle              ( +-  0.21% )
>                  0      sched:sched_wake_idle_without_ipi #    0.000 /sec
>
>             12.615 +- 0.977 seconds time elapsed  ( +-  7.75% )
>
>
> # polling in idle (with haltpoll):
>
>  Performance counter stats for 'CPU(s) 4,5' (5 runs):
>
>          15,131.58 msec task-clock                       #    2.000 CPUs utilized               ( +- 10.00% )
>     34,158,188,839      cycles                           #    2.257 GHz                         ( +-  6.91% )
>     20,824,950,916      instructions                     #    0.61  insn per cycle              ( +-  0.09% )
>          1,983,822      sched:sched_wake_idle_without_ipi #  131.105 K/sec                       ( +-  0.78% )
>
>              7.566 +- 0.756 seconds time elapsed  ( +- 10.00% )
>
> Tomohiro Misono and Haris Okanovic also report similar latency
> improvements on Grace and Graviton systems (for v7) [1] [2].
> Lifeng also reports improved context switch latency on a bare-metal
> machine with acpi-idle [3].
>
> The series is in four parts:
>
>  - patches 1-4,
>
>     "asm-generic: add barrier smp_cond_load_relaxed_timeout()"
>     "cpuidle/poll_state: poll via smp_cond_load_relaxed_timeout()"
>     "cpuidle: rename ARCH_HAS_CPU_RELAX to ARCH_HAS_OPTIMIZED_POLL"
>     "Kconfig: move ARCH_HAS_OPTIMIZED_POLL to arch/Kconfig"
>
>    add smp_cond_load_relaxed_timeout() and switch poll_idle() to
>    using it. Also, do some munging of related kconfig options.
>
>  - patches 5-7,
>
>     "arm64: barrier: add support for smp_cond_relaxed_timeout()"
>     "arm64: define TIF_POLLING_NRFLAG"
>     "arm64: add support for polling in idle"
>
>    add support for the new barrier, the polling flag and enable
>    poll_idle() support.
>
>  - patches 8, 9-13,
>
>     "ACPI: processor_idle: Support polling state for LPI"
>
>     "cpuidle-haltpoll: define arch_haltpoll_want()"
>     "governors/haltpoll: drop kvm_para_available() check"
>     "cpuidle-haltpoll: condition on ARCH_CPUIDLE_HALTPOLL"
>     "arm64: idle: export arch_cpu_idle"
>     "arm64: support cpuidle-haltpoll"
>
>     add support for polling via acpi-idle, and cpuidle-haltpoll.
>
>   - patches 14, 15,
>      "arm64/delay: move some constants out to a separate header"
>      "arm64: support WFET in smp_cond_relaxed_timeout()"
>
>     are RFC patches to enable WFET support.
>
> Changelog:
>
> v9:
>
>  - reworked the series to address a comment from Catalin Marinas
>    about how v8 was abusing semantics of smp_cond_load_relaxed().
>  - add poll_idle() support in acpi-idle (Lifeng Zheng)
>  - dropped some earlier "Tested-by", "Reviewed-by" due to the
>    above rework.
>
> v8: No logic changes. Largely respin of v7, with changes
> noted below:
>
>  - move selection of ARCH_HAS_OPTIMIZED_POLL on arm64 to its
>    own patch.
>    (patch-9 "arm64: select ARCH_HAS_OPTIMIZED_POLL")
>
>  - address comments simplifying arm64 support (Will Deacon)
>    (patch-11 "arm64: support cpuidle-haltpoll")
>
> v7: No significant logic changes. Mostly a respin of v6.
>
>  - minor cleanup in poll_idle() (Christoph Lameter)
>  - fixes conflicts due to code movement in arch/arm64/kernel/cpuidle.c
>    (Tomohiro Misono)
>
> v6:
>
>  - reordered the patches to keep poll_idle() and ARCH_HAS_OPTIMIZED_POLL
>    changes together (comment from Christoph Lameter)
>  - threshes out the commit messages a bit more (comments from Christoph
>    Lameter, Sudeep Holla)
>  - also rework selection of cpuidle-haltpoll. Now selected based
>    on the architectural selection of ARCH_CPUIDLE_HALTPOLL.
>  - moved back to arch_haltpoll_want() (comment from Joao Martins)
>    Also, arch_haltpoll_want() now takes the force parameter and is
>    now responsible for the complete selection (or not) of haltpoll.
>  - fixes the build breakage on i386
>  - fixes the cpuidle-haltpoll module breakage on arm64 (comment from
>    Tomohiro Misono, Haris Okanovic)
>
> v5:
>  - rework the poll_idle() loop around smp_cond_load_relaxed() (review
>    comment from Tomohiro Misono.)
>  - also rework selection of cpuidle-haltpoll. Now selected based
>    on the architectural selection of ARCH_CPUIDLE_HALTPOLL.
>  - arch_haltpoll_supported() (renamed from arch_haltpoll_want()) on
>    arm64 now depends on the event-stream being enabled.
>  - limit POLL_IDLE_RELAX_COUNT on arm64 (review comment from Haris Okanovic)
>  - ARCH_HAS_CPU_RELAX is now renamed to ARCH_HAS_OPTIMIZED_POLL.
>
> v4 changes from v3:
>  - change 7/8 per Rafael input: drop the parens and use ret for the final check
>  - add 8/8 which renames the guard for building poll_state
>
> v3 changes from v2:
>  - fix 1/7 per Petr Mladek - remove ARCH_HAS_CPU_RELAX from arch/x86/Kconfig
>  - add Ack-by from Rafael Wysocki on 2/7
>
> v2 changes from v1:
>  - added patch 7 where we change cpu_relax with smp_cond_load_relaxed per PeterZ
>    (this improves by 50% at least the CPU cycles consumed in the tests above:
>    10,716,881,137 now vs 14,503,014,257 before)
>  - removed the ifdef from patch 1 per RafaelW
>
> Please review.
>
> [1] https://lore.kernel.org/lkml/TY3PR01MB111481E9B0AF263ACC8EA5D4AE5BA2@TY3PR01MB11148.jpnprd01.prod.outlook.com/
> [2] https://lore.kernel.org/lkml/104d0ec31cb45477e27273e089402d4205ee4042.camel@amazon.com/
> [3] https://lore.kernel.org/lkml/f8a1f85b-c4bf-4c38-81bf-728f72a4f2fe@huawei.com/
>
> Ankur Arora (10):
>   asm-generic: add barrier smp_cond_load_relaxed_timeout()
>   cpuidle/poll_state: poll via smp_cond_load_relaxed_timeout()
>   cpuidle: rename ARCH_HAS_CPU_RELAX to ARCH_HAS_OPTIMIZED_POLL
>   arm64: barrier: add support for smp_cond_relaxed_timeout()
>   arm64: add support for polling in idle
>   cpuidle-haltpoll: condition on ARCH_CPUIDLE_HALTPOLL
>   arm64: idle: export arch_cpu_idle
>   arm64: support cpuidle-haltpoll
>   arm64/delay: move some constants out to a separate header
>   arm64: support WFET in smp_cond_relaxed_timeout()
>
> Joao Martins (4):
>   Kconfig: move ARCH_HAS_OPTIMIZED_POLL to arch/Kconfig
>   arm64: define TIF_POLLING_NRFLAG
>   cpuidle-haltpoll: define arch_haltpoll_want()
>   governors/haltpoll: drop kvm_para_available() check
>
> Lifeng Zheng (1):
>   ACPI: processor_idle: Support polling state for LPI
>
>  arch/Kconfig                              |  3 ++
>  arch/arm64/Kconfig                        |  7 +++
>  arch/arm64/include/asm/barrier.h          | 62 ++++++++++++++++++++++-
>  arch/arm64/include/asm/cmpxchg.h          | 26 ++++++----
>  arch/arm64/include/asm/cpuidle_haltpoll.h | 20 ++++++++
>  arch/arm64/include/asm/delay-const.h      | 25 +++++++++
>  arch/arm64/include/asm/thread_info.h      |  2 +
>  arch/arm64/kernel/idle.c                  |  1 +
>  arch/arm64/lib/delay.c                    | 13 ++---
>  arch/x86/Kconfig                          |  5 +-
>  arch/x86/include/asm/cpuidle_haltpoll.h   |  1 +
>  arch/x86/kernel/kvm.c                     | 13 +++++
>  drivers/acpi/processor_idle.c             | 43 +++++++++++++---
>  drivers/cpuidle/Kconfig                   |  5 +-
>  drivers/cpuidle/Makefile                  |  2 +-
>  drivers/cpuidle/cpuidle-haltpoll.c        | 12 +----
>  drivers/cpuidle/governors/haltpoll.c      |  6 +--
>  drivers/cpuidle/poll_state.c              | 27 +++-------
>  drivers/idle/Kconfig                      |  1 +
>  include/asm-generic/barrier.h             | 42 +++++++++++++++
>  include/linux/cpuidle.h                   |  2 +-
>  include/linux/cpuidle_haltpoll.h          |  5 ++
>  22 files changed, 252 insertions(+), 71 deletions(-)
>  create mode 100644 arch/arm64/include/asm/cpuidle_haltpoll.h
>  create mode 100644 arch/arm64/include/asm/delay-const.h


--
ankur

