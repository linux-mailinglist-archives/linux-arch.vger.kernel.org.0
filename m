Return-Path: <linux-arch+bounces-10045-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A088A2B7C1
	for <lists+linux-arch@lfdr.de>; Fri,  7 Feb 2025 02:21:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99A241671E3
	for <lists+linux-arch@lfdr.de>; Fri,  7 Feb 2025 01:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0192E7D3F4;
	Fri,  7 Feb 2025 01:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="euX4Um3p";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oreDiCHr"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242E62417EF;
	Fri,  7 Feb 2025 01:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738891284; cv=fail; b=bCVQvS6MHZjIi5668mrqGw+RjgESaWZxdH+a3PWtzuC641N6dxEtXzyWfvP3KWqBvMZwR5uPA7ie6s3IdXdmAWMn8ca26+LiuftbDKGpHKj0CNs8pdJey5Nj+obwH7aEJznnmAXkdgqzWYoFXUKhYaK4rBU3hlIGsH1DpvJcBRg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738891284; c=relaxed/simple;
	bh=QUYfgGRhi0TwTGaKy5Al6N+Nv7sVotDNO65l4atUT14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JBzioL4OFXivGoABWEuFfi/BhmACZxqBp7aAuQ0XYrF1vpSEoeYrHlJznl5AG0z2TP9OcJrufqju84ENtya/6x7aqMQ27xdT9sg/H2jiAUwCHaEXhi91ZGPR3FpoXzAv19riKazGiuI67DOzLjwm6RN29Yl4v2BBpYpQj/OxWXs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=euX4Um3p; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oreDiCHr; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5170MrUg029083;
	Fri, 7 Feb 2025 01:20:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=GAleTSn3aKbMSnrtGtVDgfhp/Kp68OP4sIdwgjJzvf8=; b=
	euX4Um3puM733thMGUL1RIsefm0DjQgkhU6F6zGDi2yKhlegZOztKmcihGII0w+p
	qKCS0UBSH6Abu+VDkjzwcSpyUPOEOuoc/MQgArb2urREhhx41ylHE8E6vkCxDWzD
	vyhG8tRXiWPOnnOXJVU9Kjvs4qPxft+F10paijb0Uh0I+/TbpWJcykI3xTsSXuqf
	+tcya0PXtRlDwA5PbQ5t8tWzRfCw3Bky8M3SsydZcABHtgo6Z1PiUr/+z8AQLDjB
	+vV1JFKJ81SPAKH2pVf+UITIieJLD//9DZPkdYWY3wJxy4YsDYQg3KAob2ekr6XD
	o4ivII+XjKb8Y0ru6LXCEQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44n0nb0ukj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Feb 2025 01:20:57 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5170p70T028002;
	Fri, 7 Feb 2025 01:20:56 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44j8dqx72n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Feb 2025 01:20:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QevvI01JgpbiSkrpfBDlBTKSkg7cBauNoLLS8hAGiSag8eTejhSerXY+D7rWBzNPxyYGkwNhjeMiXicd04PQJTOk67XIRxwV1OS3XA9CKUIE4IJGpGnt9tgfHkyaIVIFMseuGRecDebsYB9SyrEld/4XxVzEt9Jw0sv2mBzdqWTJ9Rb8vD76Eb06dApWbyGcQPk+/BGmxXiOR/TpHq5+PiWYp424LccDqSZNeIeO1NHdqprlbuTVeBMiwXBUxC2URCd8RsDCmuy7Mjo5ezeY8ZnykSc69t2ezTxM26DGKUWLvQwclI+SPlhyuwcbXEcI8RP70MLR5bZ8NpHbe/rOQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GAleTSn3aKbMSnrtGtVDgfhp/Kp68OP4sIdwgjJzvf8=;
 b=EDE9Ka//drlBnPwep4Gfnrg/6VWVAkyP2PgBt1mHGzPL5I4ccOt+E9xyM4A2s/sLeZhp2DNs4F6a8Y2G21kJd9chkDwkbqcDmB1LlhAcouBoeHe7q1h5zwDkE9tck4QcPIQz6plhn79yLyeclZPeWMxMdqWGl0z3YaK66XTqwR0DwrYmjHQ08b4MQVfl1EKYQB2R0Y9Z8rKfspOTSjUzrMTPhlr7V9UfbJrqhW5Wf32HPBPyojF4eBSHJydJ10ZOgLvWd8yx1aDt7YDGUYHO/ZmBS5IJqUzhyRCRtxBY3+JRyNzcBf0Gmx3kQkZVXnb7N9nBulYNZc2DOOjSSxV0VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GAleTSn3aKbMSnrtGtVDgfhp/Kp68OP4sIdwgjJzvf8=;
 b=oreDiCHrYLgcv56Ruq7chhlvyw6B9o8NnbX3xE8I665IY0jgyAfxR/xgYktnlnHaQFwhhwHJy1wZ/5wqiTMRaZKmi0QZmvq0nkt16BX6v+XIB76fN9f2mwIDbxp4K0ieR3jQ30tP1Q9k1hYse/4TsAZqfKvg/K0goj1RzrkiOdg=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by MN2PR10MB4319.namprd10.prod.outlook.com (2603:10b6:208:1d0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.10; Fri, 7 Feb
 2025 01:20:54 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca%4]) with mapi id 15.20.8422.010; Fri, 7 Feb 2025
 01:20:52 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Masahiro Yamada <masahiroy@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>, Kees Cook <kees@kernel.org>,
        KP Singh <kpsingh@kernel.org>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Sami Tolvanen <samitolvanen@google.com>,
        Eduard Zingerman <eddyz87@gmail.com>, linux-arch@vger.kernel.org,
        Stanislav Fomichev <sdf@fomichev.me>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Jann Horn <jannh@google.com>, Ard Biesheuvel <ardb@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>, Hao Luo <haoluo@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kbuild@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        Nathan Chancellor <nathan@kernel.org>, linux-debuggers@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>, Song Liu <song@kernel.org>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH 1/2] kallsyms: output rodata to ".kallsyms_rodata"
Date: Thu,  6 Feb 2025 17:20:43 -0800
Message-ID: <20250207012045.2129841-2-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250207012045.2129841-1-stephen.s.brennan@oracle.com>
References: <20250207012045.2129841-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR17CA0017.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::30) To PH8PR10MB6597.namprd10.prod.outlook.com
 (2603:10b6:510:226::20)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|MN2PR10MB4319:EE_
X-MS-Office365-Filtering-Correlation-Id: 48fdc792-7f05-4f7f-4dc0-08dd4715a9f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?f7l82P8RuQKfoOnSF0DCr1TJgNLdHzi84aDUchOkphPUP5nc+s4sYit4EtQ1?=
 =?us-ascii?Q?asQSRBKw0t22BrrHvbu7ux7KdhYpNKw0lV4hS628bjfmnS8CsYMqYY443zci?=
 =?us-ascii?Q?yYBApHDl3nG1ynSX8NKr3gB5gn7HURYl0KTTnqPweXJujJg5IA6bFmlZb8Jz?=
 =?us-ascii?Q?yYcu/z+A9sdsrbaldaz0LC49+EERmSt6PtAL4wcelJhWayrOVzdxGG6izUeJ?=
 =?us-ascii?Q?d1eqI3gs5pOhciODi8OlD6fh64qko5BeCUPn7lrNgDIOYODAfGwCt5HJwMCL?=
 =?us-ascii?Q?rT1rWnoVBIiwKXJwgd5VsK+luxxwlJQcrbOS+Q4d41smcJpk7h7GZvlvtapX?=
 =?us-ascii?Q?7+x8sm6gte/wdSF+aB7w17OfcX/rxlo+G8lacmBqXMJa3A8VEZLAzMjVRQZC?=
 =?us-ascii?Q?Ga00yFiyV8pe5Rqz9Wf3HrzDvxXzduM6afJd2YoJv5LVKNcMa71ugWiDFpK1?=
 =?us-ascii?Q?WaGmdgQxpcwc9FsbP2tWjh2fzTnWTncNUyin7k5YpA9QeMF/j+GHHky2QOBM?=
 =?us-ascii?Q?FR4WhbdxmJE5yv7rVO5K0Rwel5NvRsbb+CgdN2Gm4meEry9lElls5y7yGih+?=
 =?us-ascii?Q?XAEr2CXlkTAw8TZQekNHPcjrHIKGBlhKMfXlPECTzctKp2M4JlXLE5F7xJdB?=
 =?us-ascii?Q?3MCjvo2GsUtdVVa88OQ7OD2qQLlHyL7WZhzHCaReQBbDstzW7uiMYLqIcCpQ?=
 =?us-ascii?Q?rEEoBN84bcYwcXF/20iYiNSQ6/U8WN/auGDvWYpqxXrDqG2clbHBUePaunoP?=
 =?us-ascii?Q?1Lhm5Z2zffeNkiRweiT7QHRvQ5k4jQJ6+KRn2B+KxmdiLBYIRzYZwnu4/vwx?=
 =?us-ascii?Q?+SLdWyw9kvHfG/XaHfF6fM0qdoL/0mZMhnhbuAa5ouu5TY9ifjRviYzDnmcf?=
 =?us-ascii?Q?3PpnJ5XKGJ/7OkWU0BSsJYjYDCJU/BU7IB5C+lKzLJL72444y/SZZZkTT7Gt?=
 =?us-ascii?Q?GaXLbc86XYFXYkHA1FahusWP3oNwtdGZF6vPkXBSp/+iH9g+80pw/eE3q3fj?=
 =?us-ascii?Q?ixWecFUMcbvUpiTvlpWvYm1p4GJskxlnYHEdY8JF/okS8wN+KtM+fBoMYeDB?=
 =?us-ascii?Q?GmnuHO2C/8ui8Zy6xGPILiQGLcaFuti5Tqn5bIQuDD76qF/zmr/N0hlWgtQU?=
 =?us-ascii?Q?+xrarX7EfZFBPsmvHoS5aa5Q9XBlo8GlK6bkBm25dZ6zQOVhal+FQPIWrcim?=
 =?us-ascii?Q?fylg90MT5aMWXYCHDTc+AhBjbxMBbi33wVKW+JXL+As/tlAWhrAICpHIc2nT?=
 =?us-ascii?Q?EZTcBt6/qw9hM1n4FiVrZ/cOjh/Y7Xxjqwd+fgAt9joGuTCU5wonA00p6OkS?=
 =?us-ascii?Q?2vtN+aA3/PJLjxH2OXgIr5/Xr0I0S5o8qj8lrD6ivvLxISPmivJPnQasA/fr?=
 =?us-ascii?Q?WL9iRmJvMUgtnBkMJMufwwrMIoZl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6597.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AFBMhxM4mlUFqAgenheiP8WQ3djy1sX6R4ffmhfDyEMNi/0fxf7nEV5rwEmL?=
 =?us-ascii?Q?vrQaar6JkfQXmG//b6kv2s5U8bApJYVVunWC+BTnXYvHttT+tCxAjYAmydhf?=
 =?us-ascii?Q?OQSNow89IhbCsi9+x1sCsTStbJogT+4vRGI5SL+C+Tk9BHQLojRWqGtYjfkf?=
 =?us-ascii?Q?wnxVVG3n+XQaQxj5aysAC3T3seLrC6R4xEKCuwqyYFvt984QFvJ62DkftMSB?=
 =?us-ascii?Q?8/pUXMjTRckpSOOrn0bylm4Th5H75ni2rxtkYy8UPzn1paRRSLnyIId9UDPM?=
 =?us-ascii?Q?Jp2Dinw0ER/zTOJGyAorzugorsFahPn5YrgHrWqGemwdti3wPJO1CKoqhBR4?=
 =?us-ascii?Q?8WXAKnj3WNCydZzF0DKVs1w3SbnASc5NJNSe1V11KpJ68cFzGVk3s8Qdofu3?=
 =?us-ascii?Q?BOkEiAZojAiWmgGgOYVkGrme9qsFC5IGubb0lk5c0dV/0t67qcIX2Q3cGhUy?=
 =?us-ascii?Q?mzkmzpr+txjpYmQW57HgIU4d6UI5gr2dJo4NgkwjWDHvDqC6h+NZTYVYI+Jr?=
 =?us-ascii?Q?Sw7xqTSUSEpSGSyRVTncd/v4W5+qNigq3KvHUqQdjWDQVYJhgYeGCA4eOU3d?=
 =?us-ascii?Q?E80BuWnUWVk+1jp0PW2B1nh3VnYskgZWfDG6+LZuCrZC1OmmkMigTOsS8MlO?=
 =?us-ascii?Q?KfB0P/veHvOeR7jj7FcFyMWxVco97ahePFp3YIPW7MHEBpVCtaMMsnTh32Na?=
 =?us-ascii?Q?5300dd0bZnbtbgHTV4IQLXdo05x7aoSVYjtBRncVS80L0CjrWiXhpd0yNgNt?=
 =?us-ascii?Q?7N60+TF9lPYugz1q1uc6hoGuxJMDqJQvDJNlKPhhMNP6nHjWcyWS4vXHR2oB?=
 =?us-ascii?Q?cXa9WsseNotRnM+oa88a7tF21qEI9F+b7JnZoX8gj+PBBYLWb7tFo3sEI2my?=
 =?us-ascii?Q?QIbnX1xn4ogcDWwXGONNlCedGeDf3PhS8++GYe0fJyHuKdt5G7m+vEuVOuR7?=
 =?us-ascii?Q?O9Iu8f7lu67wE9yGwvY4Q++sBiXdEB2m65mO0CkmuK4WUqvxJOH7xUfMp8Es?=
 =?us-ascii?Q?T8sFOhdo/fNvNNDFd4Fypp56WUxqT6/9ZPNRYC8lXD3jgMqFOpyh7eyn41zf?=
 =?us-ascii?Q?/+6KE+KydpAgazfFNyD44r2BuI7TY8xLd92IqepCtxEQCFZna2sNX0OaESM4?=
 =?us-ascii?Q?uc+Ff6Fo10no6OjevzGn9++isxXG/6gb5j4vxw+77h2cM4v6ztRDjT2vxx/W?=
 =?us-ascii?Q?D+cAGTlxy+wu/aQXuJsYCIQCgJQ+A2/i1Bt8qufS1ZwCsHHhaD8ToLeyuKDz?=
 =?us-ascii?Q?gTk6PEH26IrL9pInYX9XF/CrRwL5y0n6jAvIHyNNNR9DZ/KlHPITVPxvSTdC?=
 =?us-ascii?Q?n189Ny98rW+cuNsmUTFI+LPmABC/I49gY5m6TW36cEdKF4AV+t54JQVMRFbP?=
 =?us-ascii?Q?AewKC3+Gv8sRGqjBGZp4CQe7//Kxcn9d7V94F+xE4aFJBG59FKHgLmrRKHx6?=
 =?us-ascii?Q?c1QwCOsAMsn3e8OwUQ/8AgnrqDRRdIb0sGcjCKcCobkizoYc6RC4VUiEkDXb?=
 =?us-ascii?Q?S0OhgSJhVjWOj2XVg14JSLuTGoooYaYbo1Z4i+er6LmTEvkjJNNG2QHHTOiU?=
 =?us-ascii?Q?i/K5U+wEI1dmjCMrnTOlcIamoU5Oaq71fhVDTMI+KL5tAcIbVZXWtrK/r2uq?=
 =?us-ascii?Q?mQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zdBQcZJfVF3ETO8q7jnIaFSFmrTh5c6E9E1lNM4mFiYdQXOIoUvPxLC2gR7dIwnHKXAdKG/aYSs5BXc0FSMcIEpEKjKkfxxCvwOoCi/cXKJOUevdPFOBAS7/SKHD8kdHEw7h0Ui3zUUhu0SklZFtnDPePEcz17oK8FofE7AzBebc7SxUYV/bpw0bPMS308YrfJD6tssyWqGYBAGawBSTa26x0CcPPXgkQoMKt7QMKbY/mkAX9LzV/qZKi02YIyLXN69Jkty8FXmy2xBQ6zL5CdzAQXi/qa6itFnRZLcfRaDoQFPxk17SHnLHCrHjZioPKHEnEFS+v0lUmtl3N5eOO0kRqqwlLwKzr4KUV/ai60EgY1A2ZzVL7uBig1LBl9Ou9gwRcjJ4xzD9fYfuibPNJix6gdn2NPocb+kDVQuQos5XxBEkFoFWQFvpS9zwL06nDzi96XsKLjZZdXdcJTWuy2I5M0flNDBzSffhGZT1G/2QzFNME2BgTMvTRmetUv3K/03ob7t0bXVbuTnGzrWbT9qQGdZ0uYIg24QF5pFfAogr5e0A9BBjN1kuycIEq0jNJEbyF53PVy//d+qRcwSX4tuLd6tN8tFMmzQnKn3osDA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48fdc792-7f05-4f7f-4dc0-08dd4715a9f1
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 01:20:52.9252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jvzsLgNPlLYVH07OKREUr+l0SMYRo2L/af1sB76Shzyt4HNn6vOWPGeGeX6X2yb2ANLxJySE9ewA2uJv6M7xkzwfQQY4pQ7A/8IQwux0edw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4319
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-07_01,2025-02-05_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502070008
X-Proofpoint-ORIG-GUID: ErVYL6PWoVJstQGf2dcMD_LFEPzO5hyl
X-Proofpoint-GUID: ErVYL6PWoVJstQGf2dcMD_LFEPzO5hyl

When vmlinux is linked, the rodata from kallsyms is placed arbitrarily
within the .rodata section. The linking process is repeated several
times, since the kallsyms data size changes, which shifts symbols,
requiring re-generating the data and re-linking.

BTF is generated during the first link only. For variables, BTF includes
a BTF_K_DATASEC for each data section that may contain a variable, which
includes the variable's name, type, and offset within the data section.
Because the size of kallsyms data changes during later links, the
offsets of variables placed after it in .rodata will change. This means
that BTF_K_DATASEC information for those variables becomes inaccurate.

This is not currently a problem, because BTF currently only generates
variable data for percpu variables. However, the next commit will add
support for generating BTF for all global variables, including for the
.rodata section.

We could re-generate BTF each time vmlinux is linked, but this is quite
expensive, and should be avoided at all costs. Further as each chunk of
data (BTF and kallsyms) are re-generated, there's no guarantee that
their sizes will converge anyway.

Instead, we can take advantage of the fact that BTF only cares to store
the offset of variables from the start of their section. Therefore, so
long as the kallsyms data is stored last in the .rodata section, no
offsets will be affected. Adjust kallsyms to output to .rodata.kallsyms,
and update the linker script to include this at the end of .rodata.

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---
 include/asm-generic/vmlinux.lds.h | 1 +
 scripts/kallsyms.c                | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 54504013c7491..9284f0e502e27 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -463,6 +463,7 @@ defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER_CLANG)
 		. = ALIGN(8);						\
 		BOUNDED_SECTION_BY(__tracepoints_ptrs, ___tracepoints_ptrs) \
 		*(__tracepoints_strings)/* Tracepoints: strings */	\
+		*(.kallsyms_rodata)					\
 	}								\
 									\
 	.rodata1          : AT(ADDR(.rodata1) - LOAD_OFFSET) {		\
diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 03852da3d2490..743d3dd453599 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -365,7 +365,7 @@ static void write_src(void)
 	printf("#define ALGN .balign 4\n");
 	printf("#endif\n");
 
-	printf("\t.section .rodata, \"a\"\n");
+	printf("\t.section .kallsyms_rodata, \"a\"\n");
 
 	output_label("kallsyms_num_syms");
 	printf("\t.long\t%u\n", table_cnt);
-- 
2.43.5


