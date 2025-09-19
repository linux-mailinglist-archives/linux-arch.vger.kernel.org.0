Return-Path: <linux-arch+bounces-13699-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF692B8B905
	for <lists+linux-arch@lfdr.de>; Sat, 20 Sep 2025 00:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B370D1CC4034
	for <lists+linux-arch@lfdr.de>; Fri, 19 Sep 2025 22:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6687E2E1C56;
	Fri, 19 Sep 2025 22:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qwQ3XiFf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="i9t3h9lo"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A552D7D41;
	Fri, 19 Sep 2025 22:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758321631; cv=fail; b=gpk6Fi47unJkY5lG3JquPUvWC2hJJ9dC53u5OkbSEZzoMdJNfdbkmbMglQlpPMVxW3RvwDFO0mzahIRC//+hofxgCSxyQl/oc/g4fGC+IqhoicoqmK6oUf5AtSM/gBf1crRNATvroh1OJVtorrXylqPYvTMO4uVoSXOJt4bQKPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758321631; c=relaxed/simple;
	bh=j2Da9xRWTpyzCWUu431tDaXGTsmQr2AnsfvPN4BUxuA=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=VE015FhOec8llEFDD7ogyU0/fXwpD79WsZ7Ey6+llC23k3YP+/JAPKhqLd/SNd8hxsRFLbaUNKDNGnOujqnkEiwLOWp9c75r4Bp6QbknVrzKSpStiA7268D9AbgKpd/XpxYzg3SNLDPguxrJHpY6nHaokk8N+HIyHC3jQhKuZUo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=qwQ3XiFf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=i9t3h9lo; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58JDtpV1015796;
	Fri, 19 Sep 2025 22:39:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=z3rHQFK1pwmZ8O5ojb
	ijb6m22LrqHyZFnYZYy5XOFjU=; b=qwQ3XiFfLB5c8Y1TgbHkduqov5XU0qadcq
	/uHTk/JMFX0Gike5zlFf4aTvUvzUw36f65s6yYNa7ZZFQQTQVfkS/nlvX0j/jwlr
	pJky+DGv6S+zxDQcVe0fqTV6v4QMVD6GeAKA4kdmX4ln4hIsfiu15m2quA7YOSb/
	JyK7gNNbjgoWxwlxfFmtV/5TcQ8k+jTxfkgVURjImsBGGsuWSwV2yncjwxTaR4yr
	Xt2iVqRyuH5EqRFVm/mtHhjJDFJrnOOgV6wL4WwRadd0CxVDhnIMQpklGa5fWE1e
	OHDG3emqkC0Jt7ISkE9PQx/YHl99zTHvdsZBvJSyRSN/eJxuMA2w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fx96d1d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Sep 2025 22:39:57 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58JLXeS9027235;
	Fri, 19 Sep 2025 22:39:56 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012020.outbound.protection.outlook.com [40.107.200.20])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 494y2qa6ku-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Sep 2025 22:39:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IYlPASiB1UeVirUSs2q5VsCNwasQHMaY2VB6ztgu0YikiBvgEW1EhJ9dRQIEjO5G3H2AmbmvB4WQEyGkDH8DmrBaKFjlWIwLg7kiaRRkP5gAqaZz33Wn5BdWqMlv5m8uOJSGwIQO1dJF8Ka0HPVGpO/X0enb0KA/23jnNzKl6nSJo1HdL795G4N4OTqMbc78Hbkd2D9PDsHmMqAa+6xyW73l44nMMl8i7HLvInNhLcNhE72+RFOdPzgjK2nkv/t9GTnwQJ+pWBZwgTtbpbeQsaEGVO8wej7CfHHmz0yBDQ5/VdttiqkNYFEh/rHEKsMqhfVlSmTRohCD5H7LloWiMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z3rHQFK1pwmZ8O5ojbijb6m22LrqHyZFnYZYy5XOFjU=;
 b=bI+t3DSj3bBB+yzP6XrgEzJeYhfo0dcXuxnsiQpckevkf74bj7XIik6cQh5jDCvxMeftv62jE8WhfrHWL1E2wJg3yqe8Acu8PP4j+UCwY4QFSEUno8Sy+sF4X4pt9eC5ZV35dRWE1UCE7AJ0NMQgfdBnRC1DzIB16aD0J/TqHP+4ozcttqD5ra2efm182lgSz1Q3KKw4wYTjenqs2WqrXZeCcVdOwsfC0k9PsemkEaWcjOAaLsvCLU8Ame1misMZaaCFTBnD5A/dgupyFXYvyl5kroXD7jbvSXBVokWEmK1KVJIdHBtnfqTH894D4N26IaQIwWBxfejb67fhap8CIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z3rHQFK1pwmZ8O5ojbijb6m22LrqHyZFnYZYy5XOFjU=;
 b=i9t3h9loubVZYkNTAjrrcX7eAS0LAD2HsvvLEz0yzlC6tRHlMWDmaPWoqrY8q/kA4e4WGkvhAtkelt79Ej8mM2ymSdm/PRlIA5+FRuNCaMFB+4DgzqKpC6nHMa4+gbfw0i4N9x2FyyIzEbLdqe6NRjKZL4egcqjkF+LrwYLf89I=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by IA4PR10MB8493.namprd10.prod.outlook.com (2603:10b6:208:55e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Fri, 19 Sep
 2025 22:39:54 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9115.020; Fri, 19 Sep 2025
 22:39:54 +0000
References: <20250911034655.3916002-1-ankur.a.arora@oracle.com>
 <20250911034655.3916002-3-ankur.a.arora@oracle.com>
 <aMxmAuK-adVaVezk@willie-the-truck> <aM2CR3peZkQlL0S1@arm.com>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>, Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org,
        arnd@arndb.de, peterz@infradead.org, akpm@linux-foundation.org,
        mark.rutland@arm.com, harisokn@amazon.com, cl@gentwo.org,
        ast@kernel.org, memxor@gmail.com, zhenglifeng1@huawei.com,
        xueshuai@linux.alibaba.com, joao.m.martins@oracle.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH v5 2/5] arm64: barrier: Add smp_cond_load_relaxed_timeout()
In-reply-to: <aM2CR3peZkQlL0S1@arm.com>
Date: Fri, 19 Sep 2025 15:39:52 -0700
Message-ID: <874isygj7r.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0316.namprd04.prod.outlook.com
 (2603:10b6:303:82::21) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|IA4PR10MB8493:EE_
X-MS-Office365-Filtering-Correlation-Id: aff56ca8-4b31-450a-ca0f-08ddf7cd73c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?i4dsvMspiIjJlHVEJz9zc6DznwtuAjtKyJYelh38XZdhLCyyliYIE+04HWWE?=
 =?us-ascii?Q?8kuZYJXh0B+HTBrLIq7wddKYLPoS8wLn8qEvl6c78dB6Iz8BOgiUrW5tTaip?=
 =?us-ascii?Q?kDpSbS3Hn1VqHoq1TuwcWXhIM6VgqNl1dz9wvnrfLS0Fu0KBRAbv5lKN2H21?=
 =?us-ascii?Q?kt3tr3Eq4RkdpRzJ70gOujC2ZsCY99XjRf+R4qMERCa453Oy32mL60mDi8Gq?=
 =?us-ascii?Q?jaj8WFpy5nOFND6jlAgMuEqNmqpAN6ueuOifWWNOB3GO+OstK4bc5o+fRQEl?=
 =?us-ascii?Q?7StwuxIpTEeMDmPDqkU8IDkxpP1UOGKWPyT59WrKgcr1kxnQKFLw4HS3krRH?=
 =?us-ascii?Q?XBKIakqxcwblCWAIdLlQL9rGnmmLItdH6HRm+OfGxtzRVc4qKxUSkqttnn2m?=
 =?us-ascii?Q?KddJU4uIXgD+/E8cElKL1N0bsd/HZ3exqBTwm/F5Ep9XnPsnaHmzbDEbU8LI?=
 =?us-ascii?Q?zpq3F2G8UpXV2F9YEbwjc9W/Ck+q/6IoHBcM30mA56jzpxFoMG16wnQ8MZX+?=
 =?us-ascii?Q?SVOQBd+Hn1ntIy+u0oySuhb2y9e29fBCASeFyZxKvYjjhrt7Zmwj/uxlGeml?=
 =?us-ascii?Q?ZorSFy+gXpxkxp7V9ZI64NZ7e8AIXMU1AeYy23fv3pfZfshmVgyE0mE29IVl?=
 =?us-ascii?Q?enwdadNTvr8gsCk+X4lDdmr/kv46mAbNf7y3+hWSCUN+tACWRMn1QOASGX92?=
 =?us-ascii?Q?2IjGtUIay/qFOQ3sUr3dX28TGeIOypWR7lWf17lH5XK8NL1UQGO8LdQrBHPX?=
 =?us-ascii?Q?UW0pxOe/2tySpLjqfJVJoLDSDOqCWWvmstmlr0kFNCdc3wI2CubmAPex+SsC?=
 =?us-ascii?Q?t4XbmR32a4f7MIpMUtg9iwTYPjjCUF+Tr3WUzX7kvFBpqHasN2Rh7U2EU73K?=
 =?us-ascii?Q?MhYFnrbsW4SHW0ORPDLz3vw/3PhMm5k3xGVKFS90M3Eo6lE10zI6AvmtaFvp?=
 =?us-ascii?Q?HuqEYMctUsZVhOzRq0qYPk6hTIe7ZMQcJfWIz+5llpMY0oGYTG2HzWXysGEu?=
 =?us-ascii?Q?yxDCoba5MfkxgQHTU8lUqjZMXb/Boo4qxazH3E4kkxDxSA0ZKRMWaTLDXi4X?=
 =?us-ascii?Q?KQsz9WqW4sS15c85dhYdWo3V7rxn/PG3u26XI4ztbIV61bUqRgeervd3qAA8?=
 =?us-ascii?Q?x3dq1aqaHe9MVWt/Sq8x+aVMbqYD5fbAb6iBvMNTMwqa2iXExGYEezRTBaBt?=
 =?us-ascii?Q?3onv0T6Qg6PaRiyR8wBEFd9uaYMN4UG5JXRUYKDnV7OzN2nok1JsapYq7TWt?=
 =?us-ascii?Q?faREh1gnVlFF6h8A+hnNdXuQZFP00vELbxShbLpTk5uRWMf/doWz3SYyWKpb?=
 =?us-ascii?Q?Ufd8Ijh5OLtdNNRGEo+ff7uCvpPFQXgwy/DeQZp7kbKK1a9PVMvpx6iE00T8?=
 =?us-ascii?Q?KyUsqCaWHJfvt6dpuwpP3YaZL9xKQCIg9a5mB0b8epPTzuOfBA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZOMeHUtD2DnTIAuuqIPQ/lCt25Hyl8YFrB31dP6digRCZp8KY66kb0lAtica?=
 =?us-ascii?Q?Lejlj0/MXQfC0E0vUQCGnRT5mGKGnYgmQ1D88aO605OAoMETBpsYzFuZ5cQq?=
 =?us-ascii?Q?Jt1kOOvHNwSio8PNkeIA/ltFlYL/6eO1wtVRc7SRuL4HLmbfhkbcoXOX1+Lf?=
 =?us-ascii?Q?csbdZbSmI++Miwgz0/2K1U4f+gMtRGCsyD4laoljLmUtx5me0xZ1vMRnUpjZ?=
 =?us-ascii?Q?6fJSDAvj9JWnYnRvpHTb9S10AomX37riW8Z1yIOYfP0hBXgke/s/a4zoZTJb?=
 =?us-ascii?Q?LavtXIeaDWz+GJ+kDhPUPGs2wCHn22aMRXJjTOINOcBK2oc5ggvsKYxwDlxZ?=
 =?us-ascii?Q?x2/to5JTW0Pe3XduKod/V3oQuCdJn6nMJ23H/wS0p4tspYjC71dMaqTacDYt?=
 =?us-ascii?Q?HNsKDiV8hjJzE6CEqkgyiVdJ0WQvTbn7Sw0+Nqw6tsFH8T8wOOJa9Pz9zUUU?=
 =?us-ascii?Q?z47/uU3qd8xawZR/nMuTgCyM1bETs3e9KI1YYtSBv3jG4Mg+CdGHUeuYQzV2?=
 =?us-ascii?Q?c/mfiiggLxqd+f3Nc4daafg5oCug1Ew91BKQTvnWqVW/SCJdYQyHcVAhvT6t?=
 =?us-ascii?Q?qHM7Fu3Oib5J5PovvnhnFyhvFE+Wgdkt4/YCDiVjlkaILWoHitAPrwss5R2a?=
 =?us-ascii?Q?FFwaD0QLwFhocHpR1WQeYMinftwSwgw7ZDJRIG/WsOMrmMyd8gN7Bl8PkDOa?=
 =?us-ascii?Q?1wjAFw+fsSQ8+0FZkXn/hxuaZLBEByw6dr236EYlS//uA8T+AHsogB0zI8cb?=
 =?us-ascii?Q?hkIIdklbRb9MG68QrRvkwb0LfwHvdNuvP0JfFelc88y5dMZAZrSH4ExsP+cT?=
 =?us-ascii?Q?eMO/jpCTxTNERu9EIX8QpG0993IY6+mIInRmGx/OaowNQvJi9joVuOuMRlFW?=
 =?us-ascii?Q?n+rAFkcYggu9Ar3xGCIPVPNbJEZ2VPOAliwcZljR5xRbO8xsFR46qL8Bwzjx?=
 =?us-ascii?Q?TEHVImy2oybznR9CDijuLZAHIDnBDsrO1x2/O435ayAbYiw9Fqsy+KOlkD5n?=
 =?us-ascii?Q?BXz4QHE0as1J04kdUYnI8grVWBsQguvwRaNJ+qvdIbx/1PL/nfRfJDdVrrUN?=
 =?us-ascii?Q?cvfSa7ph3cOPn95JtmIhg3lVieHAqnaeFEur/qtzbGmfiJp+2jhwiHVdYZu3?=
 =?us-ascii?Q?T/LzFaX3rJpMy1U0LJWv41tJNB24RpdM/tmQLBYJO3jibsNVSt4cEzG5IA5j?=
 =?us-ascii?Q?PEHwfpU/vH75AHHee7pKWy/zeqepXlqyUeHHAIZfGpXFnRzyy4acLo4bb+/7?=
 =?us-ascii?Q?SKFbCTuAdhzoEB99+u2KMtuocWY64D8S19aeHEroq93DgdI855E1dJ2TCI9S?=
 =?us-ascii?Q?N+AmALDOi3FMlI+CbWOBmDr21qlloiMdYsYg0fPw917mGTNZ98Air9avHz1C?=
 =?us-ascii?Q?5QHpUg5vFdWJnu8JGQKnXdqXQPI7G4DzVXwMPaVul/dgm15CX1R/scTAeca/?=
 =?us-ascii?Q?dBqxEV0Xz81tTRHRpV7sIYdQpmWkhq7KFN1TAQLsSTfwMvgBB/g5nRoWR/6B?=
 =?us-ascii?Q?w3J13A0M2YTiqCQFShYh2jFBZPXko/UpmxhCVruHT9A6K3K+DGwiX8jdiN7E?=
 =?us-ascii?Q?FwOQeUqNnwPTnQeLSDBSgjw3lMpcfEZgfiiYYLNrPCS+ZaqBTUCwPJBwumCP?=
 =?us-ascii?Q?kQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0rrzFHl9Kh/5oDjvthRtA3TTP7dZs8mmH60Nytj/b63kIqGEH91sz83vtQ0tv+qkrYr3OixYd+BQzYMR8Qpg8qa4CZPLIOtybt5sFcGJA8wIoL2U+hTJWu7aKxSjQh4soOt59vmHabdpLfhg5suRSZoESruNqKJ3BTw5yYpc7eazHzVFiBKE3HnH3+HjnrSQxAoL6HqHBMFu0P2THaQHPaBE8sspjGrXK2ClwIMnYbA7XXNaHAQpDQ8VVUZZW6Czuil4g+tzVsyNVoBn0m+dQX2K0KT+nr7e7v5C14cqOdZ9qZFtYOwpE8eMwD6sChkijTIVPlWtyTQbPwGxQNOJ+YAeDdUaZGsGCtZOiAtD4ymRDrIqr1RypNrjLP6Fl8h2uw9gZokn6sKx2nNby26qGYpWB+Vk2KcsMhGwCT2KJ7C5FSzHJ1sGPd/gLZbaI2+CTPQ8NupmrnpwFeRPFt2dS2Qhvmbgxi7zH/GXqMjSfdLqjMGl+TIzNb6zL8o+XGsaNZhLclqhRI3hrEy99LjdkRZ+5mVODPsRlwfpCw8K/V+AiiQM44SwBKzNQZUeA4/gRb+cYLl+JQ/7jQEEs2SGEfFDJ4yEX+FgXV1Vz30yCkk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aff56ca8-4b31-450a-ca0f-08ddf7cd73c8
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 22:39:54.0535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EAiu/0ctFwfp8IWe8Oqsd6aiEoucTM5dZ6nmQBrow3/D6W8hIRPI+zTEUVTJ3ikSdAYPvJuU1A/zWJY0V/C3rPs6Ir8qCQzQbyaXBVC0UZU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8493
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-19_03,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=756 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509190212
X-Proofpoint-ORIG-GUID: g8Lhbp2UTkF2lAt0Qz7ccnvCAhcDwMKJ
X-Proofpoint-GUID: g8Lhbp2UTkF2lAt0Qz7ccnvCAhcDwMKJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfXzOEA2ER8yLYw
 sJ4ovtEzQBasbB8vRCS7mIxlwvjD7FGpAni4zXgttUd465fl1sSJ9vSRoC0tqjxlNIl/OW0sq7R
 3sQoR/4Y7bGkRuteG9XUaZ1MRxitvZVtevwUqP9AZsIQLKNnGBoYpNDjV/I5ldWVVqjjjRN91bK
 bvrRFTTshUac4C8bu6nAIl2Al82axFjsuNaN7Wxg087KqXU6shsZp5b2+O5r0nnTEdNluidZdSb
 HUqbqZIMVEhuX2SEKnO+TSru/I7swY6YPHSquWc1NmzxJ5LV71U0dgsJJDY6ZgaeEv6NGROh8pX
 csJ5ccbVoJK+6O+RSMrhre3mGz+RFIUufoH0vVlExpflsr9LVd6Ok1omzVmClWkb5oNmbFias63
 R0reLh/0C/7q8zVNkH94pSsn7aOH/A==
X-Authority-Analysis: v=2.4 cv=N/QpF39B c=1 sm=1 tr=0 ts=68cddbbd b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=7CQSdrXTAAAA:8 a=nmsX3Zs_rI3fUacf85gA:9
 a=a-qgeE7W1pNrGK8U0ZQC:22 cc=ntf awl=host:12083


Catalin Marinas <catalin.marinas@arm.com> writes:

> On Thu, Sep 18, 2025 at 09:05:22PM +0100, Will Deacon wrote:
>> > +/* Re-declared here to avoid include dependency. */
>> > +extern bool arch_timer_evtstrm_available(void);
>> > +
>> > +#define smp_cond_load_relaxed_timeout(ptr, cond_expr, time_check_expr)	\
>> > +({									\
>> > +	typeof(ptr) __PTR = (ptr);					\
>> > +	__unqual_scalar_typeof(*ptr) VAL;				\
>> > +	bool __wfe = arch_timer_evtstrm_available();			\
>> > +									\
>> > +	for (;;) {							\
>> > +		VAL = READ_ONCE(*__PTR);				\
>> > +		if (cond_expr)						\
>> > +			break;						\
>> > +		if (time_check_expr)					\
>> > +			break;						\
>> > +		if (likely(__wfe))					\
>> > +			__cmpwait_relaxed(__PTR, VAL);			\
>> > +		else							\
>> > +			cpu_relax();					\
>>
>> It'd be an awful lot nicer if we could just use the generic code if
>> wfe isn't available. One option would be to make that available as
>> e.g. __smp_cond_load_relaxed_timeout_cpu_relax() and call it from the
>> arch code when !arch_timer_evtstrm_available() but a potentially cleaner
>> version would be to introduce something like cpu_poll_relax() and use
>> that in the core code.
>>
>> So arm64 would do:
>>
>> #define SMP_TIMEOUT_SPIN_COUNT	1
>> #define cpu_poll_relax(ptr, val)	do {				\
>> 	if (arch_timer_evtstrm_available())				\
>> 		__cmpwait_relaxed(ptr, val);				\
>> 	else								\
>> 		cpu_relax();						\
>> } while (0)
>>
>> and then the core code would have:
>>
>> #ifndef cpu_poll_relax
>> #define cpu_poll_relax(p, v)	cpu_relax()
>> #endif
>
> A slight problem here is that we have two users that want different spin
> counts: poll_idle() uses 200, rqspinlock wants 16K. They've been
> empirically chosen but I guess it also depends on what they call in
> time_check_expr and the resolution they need. From the discussion on
> patch 5, Kumar would like to override the spin count to 16K from the
> current one of 200 (or if poll_idle works with 16K, we just set that as
> the default; we have yet to hear from the cpuidle folk).
>
> I guess on arm64 we'd first #undef it and redefine it as 1.

I think you mean 16k? I have some (small) misgivings about that code
choosing the same value for all platforms but that could easily be
addressed if it becomes an issue at some point.

> The
> non-event stream variant is for debug only really, I'd expect it to
> always have it on in production (or go for WFET).


> So yeah, I think the above would work. Ankur proposed something similar
> in the early versions but I found it too complicated (a spin and wait
> policy callback populating the spin variable). Your proposal looks a lot
> simpler.

Yeah. This looks a much simpler way of abstracting the choice of the mechanism,
polling/waiting/some mixture to the architecture without needing any separate
policy etc.

--
ankur

