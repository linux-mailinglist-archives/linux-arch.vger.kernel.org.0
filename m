Return-Path: <linux-arch+bounces-14515-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A86D2C3475D
	for <lists+linux-arch@lfdr.de>; Wed, 05 Nov 2025 09:28:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2E3CA34AFA5
	for <lists+linux-arch@lfdr.de>; Wed,  5 Nov 2025 08:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EBD129AAEA;
	Wed,  5 Nov 2025 08:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bP7L2AXQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AOc0TaDW"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADDB292B4B;
	Wed,  5 Nov 2025 08:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762331280; cv=fail; b=VAic+ix8oBxHBl4z1si6kD/kmLmBVLaub3v5WaJdIP0T92mS/mSm8tgScL3JtzRxYgJwdfYbX5M66sjb71OQN2KJEXDjOb5KkZB6WKqF9M0ch/cUMt11JGCEZZlqelUtxC2QegMgIFM7gteZIAD0zkrtbarheRAUIuH8+9+I0wY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762331280; c=relaxed/simple;
	bh=IVJP4L/fi/6TCF19xbiG9z6SvtzLeWWemuxERD4CmTI=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=n8QjjFjq/o6+KIzfk9tA8YikfaHNOwcmPvZII2Dd7v63S4qq0M4QKqsmvRjJmFwmk4jIYWUCfpOZMNVOYqeCHvRRPG1hDGXtzSmc1jhoJSKXfLvg8HRbcUymmPi1lTgNv9e3yrr4dUlKr3FcmbKEzNNd7s3rTmFv2gjJWK5KxsI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bP7L2AXQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AOc0TaDW; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A57OIEi030035;
	Wed, 5 Nov 2025 08:27:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=2Y2c+z81hQnGoqV2kW
	EWUTsjr3DTN88wxe7HT5Qga5A=; b=bP7L2AXQACIIAGzbCV9Jw2WsFiZAVLVdhW
	XQevAkrrEGkauhF1Ytab9s/I8XSibM/wJv0hLbi9KUtts2hSZK8XVn3zlti6kFev
	s8PzKTKLKRBOqLypUp3anwAuVN6mQ0Xb8JiGriFRR9TExP+31WJyRe1JrqXWGaHr
	3UDydF8/DntKyc/OSmc8MzsOzHQHAzjEKpcoI/RUsKGEyZkLdjDOUsRFmwh1Zg6N
	4t8WJTF84bES7NZ582Y1zh24hO/3L6F7Bc97oWLIf5cMoNwHFywswogwl7WyZDw0
	MCLwnl7bh15tnzg+mYaVlgbnH18KbZxJNmzUE8zUCvjSJ6TIyp2g==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a825p839t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Nov 2025 08:27:24 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A58OVSL029595;
	Wed, 5 Nov 2025 08:27:23 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013021.outbound.protection.outlook.com [40.93.196.21])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a58nmg493-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Nov 2025 08:27:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jKMuk90f/t2a/ewnlVpwBBrUunL0b1/uh+alWjoG4quvLD1sD1pHnFCUvDC0VdDcxh+cv+z8+P2AIGL64RUCPJwo2ISCfg27SBYlg9PP5pe0YxbYCUskHglu8/9rY/3POlQWUQv/HKFjxALFwKRJKNLVVtMo2MxXTb75u2YcpKTzi0lUz2q56rjWrYKD8YSM6S2kgS3nJPR0RD7eAnpgnr4Qlr7mPgHTCx6gDca0pkp+LGQPnxFAHBFyeDDJgBtb2ZlK3AkvV0CPSaVDz0VzBx/yFb30Uw0jkV4AeMjBR8uUkdy65OxxhXZUbCsuEuGo5wZy9dd3tKJqJdzsCybzPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Y2c+z81hQnGoqV2kWEWUTsjr3DTN88wxe7HT5Qga5A=;
 b=wiUJzLs15Kq4MUbJlocPAh+ktR6fr0wOi7sT9l8kjdQ0BH0biPZScGCwzTj7/6qzKcY0evV2GlP7v0yxr4nUfGKI4cso8Fj5/G2gFEM4lwW8XkKMTP0xIRR892JgV/rsbSudxA+fxT/nwIGlT0XWy3hUM5hDPHbRAbIUVDdPHvl0kpRZgt9tK8vVuxYAaCJre/tH7H6CuHpz9kxxTvAPgsvUTurhi0LuXkh4gbMkl6EQCDrqWtHplOnl+jg1Twod/aw1xm2swf7wWem/7FV9iATUzTREFDLbppvDaTE2Yd3bv5wtX6cckkRMUEHNxFNPvTM49Rbh1Dx61R6k1AvvIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Y2c+z81hQnGoqV2kWEWUTsjr3DTN88wxe7HT5Qga5A=;
 b=AOc0TaDWniH7c7NM/0AEbw/qE7h3fgGCVWuboGHyNmkIQ1jp7gSwojatKvK/BiLHuWVvw1STq7oc7e2ANFvXTEcu2PEG2QW1aIDY6KimvQXBdiAGI5Zwmrzlb+LcRFAf+7MnWLufd0S6cWFmMQATHB6/ru6PWCs2Uid9yL9Tx9w=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DS0PR10MB6104.namprd10.prod.outlook.com (2603:10b6:8:c7::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.16; Wed, 5 Nov 2025 08:27:20 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9298.006; Wed, 5 Nov 2025
 08:27:20 +0000
References: <20251028053136.692462-1-ankur.a.arora@oracle.com>
 <20251028053136.692462-3-ankur.a.arora@oracle.com>
 <3642cfd1-7da6-4a75-80b7-00c21ab6955f@app.fastmail.com>
 <87qzumq51p.fsf@oracle.com> <aQEy6ObvE0s2Gfbg@arm.com>
 <746c2de4-7613-4f13-911c-c2c4e071ed73@app.fastmail.com>
 <87ikfqesr2.fsf@oracle.com> <aQoF1-uKTgJo89W8@arm.com>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        bpf@vger.kernel.org, Will Deacon <will@kernel.org>,
        Peter Zijlstra
 <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark
 Rutland <mark.rutland@arm.com>,
        "Haris
 Okanovic" <harisokn@amazon.com>,
        "Christoph Lameter (Ampere)"
 <cl@gentwo.org>,
        Alexei Starovoitov <ast@kernel.org>,
        "Rafael J . Wysocki"
 <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Kumar
 Kartikeya Dwivedi" <memxor@gmail.com>, zhenglifeng1@huawei.com,
        xueshuai@linux.alibaba.com, Joao Martins <joao.m.martins@oracle.com>,
        "Boris
 Ostrovsky" <boris.ostrovsky@oracle.com>,
        Konrad Rzeszutek Wilk
 <konrad.wilk@oracle.com>
Subject: Re: [RESEND PATCH v7 2/7] arm64: barrier: Support
 smp_cond_load_relaxed_timeout()
In-reply-to: <aQoF1-uKTgJo89W8@arm.com>
Date: Wed, 05 Nov 2025 00:27:18 -0800
Message-ID: <87jz04anq1.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4P221CA0028.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::33) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DS0PR10MB6104:EE_
X-MS-Office365-Filtering-Correlation-Id: da19043a-c50a-4a96-02dc-08de1c4522de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UlxZuyNiWktH0Bpb7PqIzpmsRO43ydrKPfYCReFue6Yewr0J101/CBXfZQim?=
 =?us-ascii?Q?WUalD4ZynGq2iPHV67VtkSvsZFEtL0ujblOT6WUih6DM7iwjWS/nGZMveK+D?=
 =?us-ascii?Q?wPl4bXvZomMTU+L6ycJUtxFI5pPQzbqj2xLT+KQwnpwyocaXbzs2eoI0yU3Y?=
 =?us-ascii?Q?K0e8A+toleooEDQ9b4ZDj0eWkEUSuPiinxzCoXRoxBtbf4vZLekwx0ClzyuY?=
 =?us-ascii?Q?5+VutM1nyGK4ic7OcqgFBGqdj9RuhL+Xu9XTBZMkf8AIsmbuStIjdNZCJEDF?=
 =?us-ascii?Q?yz+cG6bHqfEO/gjOOpZjcOeelWeHfqoZmZ+YmOw4JGdAs72ROOfS+2GWyuzK?=
 =?us-ascii?Q?qIo0gi0bfskLBh5iQfR4eakiodpIiGGkE1DWPiNCP/rzjJe93r27rxpo0i5s?=
 =?us-ascii?Q?YZSMNNeGnwWV1jzWQ0CJTRo9KDY5thtuKOlqLv9Zh69P3l9k+i7yciCeNWvC?=
 =?us-ascii?Q?R2hV1dx/spLU5fCeIHKnC0uBOdcpcpum6bUgJE2VfoGhJD2gyQUtl76tdUFT?=
 =?us-ascii?Q?ZE1UCpui/N+geOmsnS4PaF8n0KuE4446fqucuKXLN6QHf3dmQ2YEMIXU4+Ty?=
 =?us-ascii?Q?XsQYOT4q85pHl4llQEMKgJ6wJF1i1Y8QD6uhy04MhNPTN3ofv/zT0hLNrssy?=
 =?us-ascii?Q?ge33uT2YGY08LHCUmrb6E3I3h45PSUHJTuVZg/UIrHv3U2cSmx2R4uYVtli5?=
 =?us-ascii?Q?COSSUacL9acnHzSXlR/TINPk4KCPmhNkyc4aFB3+VnmORcCsd6n80JorjNGE?=
 =?us-ascii?Q?Jyer8PWdGmSGJGTvko/s5rwZhKw4AwXJjy+8C0ddNAqXKDbjbnq+gadGqwXk?=
 =?us-ascii?Q?pEDA9exNMMaf5lWmLMu4ExeTveDdEJzMjLsabU0LmMzQB1edByNWLI+MSMsb?=
 =?us-ascii?Q?HbIYwrhcIk2Oc9S/eRbmeBa0wGo3gtRr5HzrlnrlrTFEawDNQcOwT1qnQ4Df?=
 =?us-ascii?Q?ke+hMKwqWSCswjSrnQJcjgVcH9MtGn6xuWrCcrOn/K9aLgDRuNtAK6N3/V3Z?=
 =?us-ascii?Q?l88wx0MWBbuRiFcoQgoPcagBHP5dVGhSSJhb5nsgXYQiMhEMJhejyDWZOnSJ?=
 =?us-ascii?Q?KA800Pm1NpVRq8PfuNl9yTsYGEukcC6Bk+77qTvCRdYV03cgUZ0a96bNgRfA?=
 =?us-ascii?Q?ZrBBTN1cRP9Dc5lBf79ZUce90zwMA8DcCIhP+QvqkQpWx8toEb5aGZvEA6lp?=
 =?us-ascii?Q?6mL73UYgVrURD+vXRUfvmMixOB1Zn/E6Z4pso8LFFjdIMrBQitbNL5bgwvR3?=
 =?us-ascii?Q?9zOw/W6ml+51oVHgaQ/HkbkBvwOGCPBN28A/HOu/F3F9BmdshRWQD37gkfwi?=
 =?us-ascii?Q?M5NwvL0y3BXfkB4TftSx/rnvNMe81Dx6DM+Tz57Q9BMmKZ9+oSXH0CSMTvPA?=
 =?us-ascii?Q?HN/UnLUsbqe8MQRHZkEmb9hc3YvaqYN7HIaL9WzJn/y4SXTUmGXhs3UMTqsR?=
 =?us-ascii?Q?aQNwjeuuJV8pfsZBr640DZfzsOwZu5p/UJtbgIL3dBSmQPv3KUcQ3g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?J1PD7Hm3ShekfDczEk+OTcH/FwZc9RFb4iYeKidPLe+eIBqBligRH8vStl4j?=
 =?us-ascii?Q?yadQA/qv+bVFo2TgC96wyaMVPUv0EM58SjxqkBqoxbqqr1nv4SA1yOkQCwDP?=
 =?us-ascii?Q?rDu4SXvEHJtyCkFE3uM8xi1uo1O179ygeCR9Rb/iuta3xXj10ah0IPR6zRxz?=
 =?us-ascii?Q?h1CyfXk3cXy6mFVtBGCKBjgrTWDktYHDdEQ6u8lDO3dX5xlUu7tWZJitMQf8?=
 =?us-ascii?Q?rYYJN4mMIWR3NwPNw+YlXNtu1o7plXiUyxAcE+qnKv4mdFxAeX0WEr+uLtAc?=
 =?us-ascii?Q?STRx5vyutY38mY40DA+DKG7FKPOIoLQCZD/twQQKIP8VieJ+FvjQR4zk21Mo?=
 =?us-ascii?Q?21XqEVlULeFhYyYOwY/v0xqgrPwFZArzbTtAz9qJeZ0zNHCHLX2gb9rgqHf5?=
 =?us-ascii?Q?Cmb7ZfPYO9QbLNPPQpGiy0+GbGcajpNXKPb37/juFNk6BL5kKHMsguv36LG2?=
 =?us-ascii?Q?Critzl+0tSlZAGbXDGJjvmXdsQLKMQ6mrsS15Dh1KXE/rht2ZSkU5a2wQF11?=
 =?us-ascii?Q?xM0NNdDd7LU65an2DMzUjNLs6dz5FP5Fwl50WG2H2S8v+w7UVxpTtpQmV86a?=
 =?us-ascii?Q?+LGVH1UdIsEeHG3GzWSy+/Nd6qTD0QX4wWCNTdNl8iCrMC42eWzdYFwyfsjZ?=
 =?us-ascii?Q?Y4hZDN4ZwZo0DRwHOZCZHsB5i02WrmlGU78On5eXx912/B6vmXgWKfCRKlw1?=
 =?us-ascii?Q?V7hKL0yJ8CjtG+DMS8hOylRNC4vu27My/G1WdGbMyx4iY0+0wld92YwlpvwT?=
 =?us-ascii?Q?BZKDsiA0JW0bBHVUyO2U4qIoX9PmBULJjVMnNRfZNqtHonqVMaUvTbifL5Uc?=
 =?us-ascii?Q?0N6Y4uvk13yuWKAG8QyUr3Ew8wcaJltRz65LpMtjEt2khQZ6IyXxbtR3tmK5?=
 =?us-ascii?Q?6h+G255uCg9ACBPR0t2oQk3tk2OGUqecp5f9Ah6qPqr4hsbuww4St1DSDk5P?=
 =?us-ascii?Q?2VQXJ+SKNzWOvL/Pb6mzZbgXFg11+2Osd0n4jkiisJfsto5ihVfgJcqZ76g7?=
 =?us-ascii?Q?i1XTp3bIYJ9gS4Xae5KvHRBONmPSZ2B7YGy8mYDIG3CB1w1W5bsIYoqQjneX?=
 =?us-ascii?Q?PBgZ/6uqVKF2t/8BjABGEKjaMuNs1NZjMxpjTfZqwtIQCKwmcsp6DYEPvw2e?=
 =?us-ascii?Q?/bwyU+5mTteTdzOvBrCxBkLPJSmSGTvDTcm59qhjYLbeQ8spfZGurdsn96PX?=
 =?us-ascii?Q?cCcmu3Ayzv7mB7FdLIIERO6bKsQ2SexhaLnMj6+1T58uqtEvMfREIBMAIldy?=
 =?us-ascii?Q?cZzbuudrFlzUfaAS6ApPPd/CQyprgIXBe26r58vbasQd5KDKnR6+voJ/H1EU?=
 =?us-ascii?Q?6ZeI/dFREi/loZBQDMB/IDEaaBJbEdOKBvjMf3HLuSa/z5K/hB16aE5R787U?=
 =?us-ascii?Q?Fsh71i8sPrdDlq8txaAC01EFatYUJ+96K5VjRcFZyA80EXovdPvUSRpiOtxT?=
 =?us-ascii?Q?xflNPIWeUmG6efXguH1rrxtj5P2n06YCzIvYbeYCv/OU8+rCNF+MX4JepgJp?=
 =?us-ascii?Q?mMfZSFe7AM9HzGO1CYUU8DYjUj1/nUNtyDNH78orqK4XeuqSoeSaACBQU+EP?=
 =?us-ascii?Q?jn9zzc2njb/53Mljc+O6g8UCWdmhgJat0aX6E+dEGty3+MvGlGUX/+tXoHaO?=
 =?us-ascii?Q?zQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	J4RRNO1tAH154W1Vqwq7hAbfuW0ImHq1ohe7Sc/U1Y3OVHHvHBpnGjO4GayGvxH+R106SOSQlP8/w61gOEd2q2lDyroiex4lPKXjN+s/gnq1bXwNtB8TLHl9FiHO7SrXC/nmEq083iNMzILigaPOjnLA5oscSYiy/ctBQeWZ2oj4nzrZVfcPCS59C06/8ny1TYa9jFlfLXhM6PoqH4a9sGZwISvuT8ibopaCVD14D8jQvCzyqj4hoMqansytOeUKOpxhWRUxQ63t/X0T5fM1gf1mqULWFoxN5nconFOmmtXcDDmGy3xoMoanOKH7zCFmGT0ubymJKXs9A2UuRTDHhP4W02l4OUDldAtxVNkTS8VMDpo2A5nO5vG6wNl2NFg9qJrESunUVJKZZ7x89yEJmw+JKPrS456IlYxUbZGdjYAcxN1dRXzwxj6bUiNRh8GuQZpyMj0/8OG14SKL4faOXxD0NtGpZsEwuLpb2bw9x2F62BshvvIcb6qPbbS/vK+6U1qNKQe3teeMZiuB4ZUDkoSM4XZR5C3XbFZVmJggWQHuBd55tfPAcYoWNpy7MHbDbj59+5NHS3NDnAbrprV9IJ38OaUD32+MacpxGy2MGFo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da19043a-c50a-4a96-02dc-08de1c4522de
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 08:27:20.0144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OwGkHmvnsKkPz9YWjmeL0yMJ+2IESeBDW4RaZk2+W3FaiHOaD+wfsq/neq07r3cyI3PQpi5M4B0KEgMMUXQKDMHFmu9LJky0dhzxtEwuT8c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6104
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_03,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 suspectscore=0 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511050061
X-Proofpoint-GUID: M6E6echDcw6_93_F2L8VkZVnDtGoimIe
X-Proofpoint-ORIG-GUID: M6E6echDcw6_93_F2L8VkZVnDtGoimIe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDA1MiBTYWx0ZWRfX+Sn46IDx8E8Y
 BTwUuMZzPaKFhbu8dE2No6FdFNfVJEm0lMVBPgkEe94xkReBvDM/YSANQwj/wux9RUzGe0uPBar
 W//mOcYmKiQVt3AutZ3seuA8GYI2W8sEuZFmnvyzQgBxbTHco6jfXXcGEuAakvJgxk+SbrohTQx
 0y/WAjGQ1IZ4i0n0yieexLZ3JVoEoU3A72mQFKDsbFVzcfHpDTTi6hMMmu8aM4MohdIW+q0I9he
 rTmowbVLt1m3XuzasMuC3lXTLjKJ3zvpiHomm9il5bn4VZ78jGG0N6UNJK6nK6Rfsul9HvgdBH0
 0wjIo/D7HZ7tS0R9/fnyE76ghlDQuXPh9rD8gL3MxXiphZLAmh1x8LsnQfDBGGbA9Ko/k03Xy5b
 zXV+HEdyyLqUNWCsLarOv4XHDfaOPRthl703TAdfnKdQWisUuWI=
X-Authority-Analysis: v=2.4 cv=db6NHHXe c=1 sm=1 tr=0 ts=690b0a6c b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8
 a=tDYS_kGuMHhywfeGTG4A:9 a=a-qgeE7W1pNrGK8U0ZQC:22 cc=ntf awl=host:12124


Catalin Marinas <catalin.marinas@arm.com> writes:

> On Mon, Nov 03, 2025 at 01:00:33PM -0800, Ankur Arora wrote:
>>     /**
>>     * smp_cond_load_relaxed_timeout() - (Spin) wait for cond with no ordering
>>     * guarantees until a timeout expires.
>>     * @ptr: pointer to the variable to wait on
>>     * @cond: boolean expression to wait for
>>     * @time_expr: time expression in caller's preferred clock
>>     * @time_end: end time in nanosecond (compared against time_expr;
>>     * might also be used for setting up a future event.)
>>     *
>>     * Equivalent to using READ_ONCE() on the condition variable.
>>     *
>>     * Note that the expiration of the timeout might have an architecture specific
>>     * delay.
>>     */
>>     #ifndef smp_cond_load_relaxed_timeout
>>     #define smp_cond_load_relaxed_timeout(ptr, cond_expr, time_expr, time_end_ns)	\
>>     ({									\
>>             typeof(ptr) __PTR = (ptr);					\
>>             __unqual_scalar_typeof(*ptr) VAL;				\
>>             u32 __n = 0, __spin = SMP_TIMEOUT_POLL_COUNT;		\
>>             u64 __time_end_ns = (time_end_ns);				\
>>                                                                         \
>>             for (;;) {							\
>>                     VAL = READ_ONCE(*__PTR);				\
>>                     if (cond_expr)					\
>>                             break;					\
>>                     cpu_poll_relax(__PTR, VAL, __time_end_ns);		\
>
> With time_end_ns being passed to cpu_poll_relax(), we assume that this
> is always the absolute time. Do we still need time_expr in this case?
> It works for WFET as long as we can map this time_end_ns onto the
> hardware CNTVCT.

So I like this idea. Given that we only promise a coarse granularity we
should be able to get by with using a coarse clock of our choosing.

However, maybe some callers need a globally consistent clock just in
case they could migrate and do something stateful in the cond_expr?
(For instance rqspinlock wants ktime_mono. Though I don't think these
callers can migrate.)

> Alternatively, we could pass something like remaining_ns, though not
> sure how smp_cond_load_relaxed_timeout() can decide to spin before
> checking time_expr again (we probably went over this in the past two
> years ;)).

I'm sure it is in there somewhere :).
This one?: https://lore.kernel.org/lkml/aJy414YufthzC1nv@arm.com/.
Though the whole wait_policy thing confused the issue somewhat there.

Though that problem exists for both remaining_ns and for time_end_ns
with WFE. I think we are fine so long as SMP_TIMEOUT_POLL_COUNT is
defined to be 1.

For now, I think it makes sense to always pass the absolute deadline
even if the caller uses remaining_ns. So:

#define smp_cond_load_relaxed_timeout(ptr, cond_expr, time_expr, remaining_ns)	\
({									\
	typeof(ptr) __PTR = (ptr);					\
	__unqual_scalar_typeof(*ptr) VAL;				\
	u32 __n = 0, __spin = SMP_TIMEOUT_POLL_COUNT;			\
	u64 __time_start_ns = (time_expr);				\
	s64 __time_end_ns = __time_start_ns + (remaining_ns);		\
									\
	for (;;) {							\
		VAL = READ_ONCE(*__PTR);				\
		if (cond_expr)						\
			break;						\
		cpu_poll_relax(__PTR, VAL, __time_end_ns);		\
		if (++__n < __spin)					\
			continue;					\
		if ((time_expr) >= __time_end_ns) {			\
			VAL = READ_ONCE(*__PTR);			\
			break;						\
		}							\
		__n = 0;						\
	}								\
	(typeof(*ptr))VAL;						\
})

--
ankur

