Return-Path: <linux-arch+bounces-12878-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87247B0B95C
	for <lists+linux-arch@lfdr.de>; Mon, 21 Jul 2025 01:44:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2DD2177BCF
	for <lists+linux-arch@lfdr.de>; Sun, 20 Jul 2025 23:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B3423A578;
	Sun, 20 Jul 2025 23:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KFMrSTdN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="H6IlS58x"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8C7239E9F;
	Sun, 20 Jul 2025 23:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753055019; cv=fail; b=a9gPXgPMSiEF2vML0LzT3WzI0rGN29HBgT3/ZpbTtFNmlTe+dlykjkTU/lLXZO+W2M7ThDP/8o4GyW5jAhsri8fFt3j3CNbjKUnC+0eQm4QGdo1lrIltvoRyydhkiDR76KS7AhXa39AVaro9w0UV74Tv+ls/Nc1vmIEV0bAOKXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753055019; c=relaxed/simple;
	bh=2nxf4JlsNgpI5gw88Zv4B0E7JENDIKBWNJjQzv6MaSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K2o+sIVVn4gWYcD3jFvmDyWIHPd616XdXkaOzQnEDtueDvoQnj1HWq0o7FbYcq7fiho2bsHHHiIm4Vat7Qpeh0gVnaGj1Yo11p8qfZTIe0np9K84noZFkBptS/0eJ8vXjLuq+Wmsk6s0wEoc2AgYLb7r62PI0tAAiOXVPglX90w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KFMrSTdN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=H6IlS58x; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56KMP29N000607;
	Sun, 20 Jul 2025 23:42:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=r2Jb0+63DSb9MMjgMOmrawzICO39CIC8ZY339dYTr6A=; b=
	KFMrSTdN8xR+3u8S8bV+Y0VZo91BKedEbBQL+5Hil/fSWw8Y18wC0L0eRZdAsvqA
	EFbrxA9jF1bpIJ1itWnqozLkAmftKelyvRVsCwikOlRMYcmSOhQcEoc/Rp46MMHJ
	mX059efx4zAq/ixPzA3/XNRJFnULc5cMp9ELRPEnUyK67Uc6/gg2v2KWWsSmCTaH
	2CFcXVGILYk/vLVEJgnvMXfi39zPGL1jOegCXFd3Gb8DVyqQvr3I9jEXRpJ4zq23
	mhTgsivw04H9Y8oP8U1+7nXu0kUtOZMzj49gYwlFpp7jDZ6Amx/MsYGALBNyfBrY
	p7xj3YlO6a7rXRlbMiZ8yw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4805e29hp2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 20 Jul 2025 23:42:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56KMo47L014433;
	Sun, 20 Jul 2025 23:42:50 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02on2041.outbound.protection.outlook.com [40.107.96.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4801tdpt12-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 20 Jul 2025 23:42:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uw7gFEk5xzyDCbOoNT4y6bktlRJisxRENgZ2HIoTmiz/t88VGEnHaLjAJWlkX2N9WfQyDnUjPPuW+Lgks4nNgDUZI14piB81jq6JprmrZY+Lta3RKd5HiJvvlzV6TMZ7v5R4AmkLnskPzsGOJsqkPsTktqF48dSXk1hOFFnT2A8zyC0xlV25Kt3RFpDyewUFwGnXplVQHZXEAhL49jNGe5RAgHDgC2eH5dPFmZ5ymn468uy6mh/FU8Ft1ykn8JOpji4esokKy1joNyqutE6pCoYKJC6HBwPT951SSQ3lZRZ2ivIb2+8CHmtoQRkqRbM88K157Mm13BynnvmkPdM3fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r2Jb0+63DSb9MMjgMOmrawzICO39CIC8ZY339dYTr6A=;
 b=QZmyW4ZKVOb1uI52T4z9zvzqEnqkcOIzg61VN2OpiUpfh4GN3bqkelHZPGFEsrVFUorQr8UhXTTT/clXFeFzj1cLodEIHheMvvPFQm0bPSGqivlT+w2Rj3bFY5Z4zOweHaas7zcGDhfcGFGx335nQRfpJSVOmhMgjkTgBwAOHXOzl8/7uPeat31PmNX4JrmGdC8cdGpPfXnrcn3o9fdf4x7M+1ckVzk4qS8F+/SHrJx3KF6APq0Png+uIDoprRl9HLdTrGcSlkUBWRhK6tjfLbKrnx2BPDSwnwwzNFukJSwQy/0vwPmnWZMTWw6EssKUHGu+Yq+HHyKPq9NQpoN1Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r2Jb0+63DSb9MMjgMOmrawzICO39CIC8ZY339dYTr6A=;
 b=H6IlS58xvTDybbRUE6megpj6yONZ08WMZjdQ2ttmy+qYClfAX8Oo8vIjXhAjnTJ4EihZA2Jb94nUMRgkys88RO+I18QYnwZ+N1l/iY6o+n8rTCKmqSsZ4IHjVGltZ3p8MsmWav2ANc75jQRZ00+29lo4ScrHzhNMXMPWEQUgOdo=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by MW4PR10MB6395.namprd10.prod.outlook.com (2603:10b6:303:1ea::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.29; Sun, 20 Jul
 2025 23:42:42 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%4]) with mapi id 15.20.8943.028; Sun, 20 Jul 2025
 23:42:42 +0000
From: Harry Yoo <harry.yoo@oracle.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@gentwo.org>
Cc: "H . Peter Anvin" <hpa@zytor.com>, Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Juergen Gross <jgross@suse.com>, Kevin Brodsky <kevin.brodsky@arm.com>,
        Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>,
        Joao Martins <joao.m.martins@oracle.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Jane Chu <jane.chu@oracle.com>, Alistair Popple <apopple@nvidia.com>,
        Mike Rapoport <rppt@kernel.org>, David Hildenbrand <david@redhat.com>,
        Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, Harry Yoo <harry.yoo@oracle.com>,
        stable@vger.kernel.org
Subject: [PATCH v2 mm-hotfixes 5/5] x86/mm: drop unnecessary calls to sync_global_pgds() and fold into its sole user
Date: Mon, 21 Jul 2025 08:42:03 +0900
Message-ID: <20250720234203.9126-6-harry.yoo@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250720234203.9126-1-harry.yoo@oracle.com>
References: <20250720234203.9126-1-harry.yoo@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SEWP216CA0137.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c0::6) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|MW4PR10MB6395:EE_
X-MS-Office365-Filtering-Correlation-Id: 093436e7-0ff5-4ffa-a42b-08ddc7e71e94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1ZFmLwl+ZerztF6rtsUYTVwYP3HUxc9WFoTclMVduAd3HQu3ViTQcLJQJY0+?=
 =?us-ascii?Q?ne4YjPImymLQNGdFeYSo72hWVYXfKLEOI5ajz17ObOumCgrU3GMMeHf5U1y0?=
 =?us-ascii?Q?OWTCGqg6y3OlXjYjlCke0Qj/RoHRmf7dr0RMomcuZ8mEuNBDJz5DDNeQ2bAU?=
 =?us-ascii?Q?GGT1rHqSUj3LT4HsOAuCpCpzuP4RU6Rok8T7Ejx/xjfiapL1azfi+p5dR5dX?=
 =?us-ascii?Q?xR01ErUr6elhwbLfLlg2ySnYqPRKfkZDS66tpM4EXlhW3z135cMI6Cv9DRm6?=
 =?us-ascii?Q?uHJ7CKQ4CytWjY9JDdfhoaS5BAXpigjZkFGtPZRGK3lK8bEztfV8IlOIRFcj?=
 =?us-ascii?Q?s3uWnF5nU/qIrQawvMVI4BdZ9McvGnLuOK0Vo8GsbJ1qumODlMixL31EZSpA?=
 =?us-ascii?Q?HSE1u+Lorze3iPhYCa0YKbmgAYtmmolp/B9hoDM4p0oET7ozlzgck05wYq0L?=
 =?us-ascii?Q?Xs18qiN6XYQ76inJnLUOLkNpdUKc59FA8/0/ujIs201HCGLQtVvmkXKVfhBp?=
 =?us-ascii?Q?k0FvRcL4gyCKtB9mAT54Es6dqpVv+GPsNUCt8EBt1/33Diet7xtVVpyS9idR?=
 =?us-ascii?Q?N7PwWvgVcSA/jfqCR9WAXM12RLgSQYRt6T8NDm1VqIj/RBlRkpw8Rl+hH+Za?=
 =?us-ascii?Q?MsEnX5J+/4hbfbLDQ7jeBi0fceZOUytlwUjmHIWLJ6O0Il69+d28H96w4ZPi?=
 =?us-ascii?Q?i0Vtgc8vZifMZJVhbXydTdGx8zoMkwRQJnYm0Pm0z7zSf4THalWVHjkzalt8?=
 =?us-ascii?Q?OYKq5iykdVAvT5QYKIuv7tOUK/2a5fCdh83RK48xsEOFYJV72+cCWg2JdUFJ?=
 =?us-ascii?Q?pH6ZkqGhyMBF/8ENUUT227Qb0ySoseGrDVWV7it/KlyS2lKsC5lbDJHcsOZn?=
 =?us-ascii?Q?eEk20irrX6K4yrQJFpkI+bb97gViXLeONI9IsgT9ObD3cyqtV5KTCMZRWr7c?=
 =?us-ascii?Q?xM5C3XfWvZ+rl/qva1Bqj9XhFtbi12dfdPIlFmyg5FUAVaV+ELtkT/jKIJ3t?=
 =?us-ascii?Q?q4hfFBHsXoQHVrdN1ByOzrf6IbrRGm3Q1iWsEfEKA1IAlHa/p0YCwwD8LTTj?=
 =?us-ascii?Q?PJg5LWRVyVgfhQLoxpJrZy6wrKkvLPskHt6Fn2YLkyQQ/1TCXf0s1rAROT6J?=
 =?us-ascii?Q?MZagEwLvYXXgfS8tsOVVX2UgZunQn/JLfEyVWu6H8KNItzBLX9+kwPzLTtb8?=
 =?us-ascii?Q?HiM456L7StOrWA/PCvuCbsqginycx06VvjTDfG9WUhml3iVsiNIpupqsmNkZ?=
 =?us-ascii?Q?oYdlHScBdFaW/m1628HcKqzhN31DlUygs+O0IMSlCrFizZ8Puf0HWBf9FLzi?=
 =?us-ascii?Q?ridhxCkqxV4uykmr52FTkfkP5nidhsKFIsOdTb7W4E4qlD3gO59gNRT4bM4S?=
 =?us-ascii?Q?53tc6whAjBR1dIcqYpTix7KbyZKby6qkPCYWVGZ4k4YZ6HLKmvyrtR6YNJAe?=
 =?us-ascii?Q?H1yV2slOYegvKOUryHqmM9MfhWtlTLkH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jhc1qBiB+DecX8JWxZHqaA+525sODg6ddJGm4URrlTgKaEhWr4hd0sPHB/8n?=
 =?us-ascii?Q?GfM+a6Nyc4inzRG95nhWgJ1Fbhs/S/oDDYVjS4OzWcP32qTGju2hIhgT2FQ2?=
 =?us-ascii?Q?QoRryBK4gZ+Kcfs4YXjxh9ad0iTVZ2ZVYw8gR2jxsr661QdMKu/JGDJ5MGWM?=
 =?us-ascii?Q?cCOvbMJVJQDL+T7CSL+KFgkGBpL2P5cxO0lqw+cWDBldDaKnEs1ZNnZVD4aP?=
 =?us-ascii?Q?jACEWz7CSbh+rlAtwjX65jJe91tJS/TuI10Q6Zrk308L+BXnC2S/HMm3EJkY?=
 =?us-ascii?Q?Q6CuQ3g0RmvV6djdJCz9ZFYTeD/EkGKsOj15ap1c7k6I7zDm5ZkGr8ybZgQw?=
 =?us-ascii?Q?wSRB979lOmfNAAvdSM5/suHyBSngV0LbK185+yBbuCX2ljCs5n5yWkbE7wtX?=
 =?us-ascii?Q?r9hkWqo3FL2clUDp3lJavqEchW4z3GuinilrK9TCRweigO06eGlWIugHbLMl?=
 =?us-ascii?Q?m/vDFqmacYj0sIcMEgfSO+mWp8L/lHonjFUhG24w/OH2h3p5v7ciBtA6WKYl?=
 =?us-ascii?Q?L1XWGvANkEqMEb1c8OmwndL9NAmWJhK0rQvCutYmxRaE53XCK8p28qWGAi/L?=
 =?us-ascii?Q?prAMQckGNCr1UUd54HNWutV/+PW+Q3/6VLi9latjZmRTtchmKbVZ+bKXR8V5?=
 =?us-ascii?Q?jFxmDL3hxqiYiucQEokXFx0A/tbL+lcG9kaTQOx2q7HSwon3tfxRahG2juvT?=
 =?us-ascii?Q?uguLdwrX4pNR0WyNFSbElGE+xzQj+YUkvPPjLtR50WvGGXVs6vNGygxSAcq9?=
 =?us-ascii?Q?Aj8yE6H8KIUs/A8DmGDld9CGhx0lfMa6UvSbSA5xZzHvXTmQPhpDRUZgZGDt?=
 =?us-ascii?Q?gTvmdbf6WS9/engeWmM6dmnIb09zCz9RLtUIMkkWeu+FxQB0x0uhqNB4tKRK?=
 =?us-ascii?Q?sesdtOqiPGaNwOLFsElXxX8x3YmhZ6owd2ZfDHoGOn03XSqQ/MsygqsyuUGq?=
 =?us-ascii?Q?AHpqfOKediNmvKar2h15wPipOwPJ0cmcNUXWO1Jt7dy9ZQi633fxcxY48h5J?=
 =?us-ascii?Q?Rd89fDIFvHBDSNDT80HcFqNPpvq+Wea6nnN/yqty0lAGaKqugC44vZRgyzXs?=
 =?us-ascii?Q?hya57iLoabrQAE1T1QXfZDBHIrXgyOseHRx9lHUJ9qrceDp2j+ZZ+ohe/hx2?=
 =?us-ascii?Q?xIjNpXUYKyJG+FHWf8QJpQaPqmK99/LuiBF6hSDZQfglVi1KN5BILUNk7Qre?=
 =?us-ascii?Q?9skhBcDmYcf9yccWutdgI4EMyvxS2xKdNBSLObn7iJixM9p39PPcVURyGGiv?=
 =?us-ascii?Q?s9RbgyWIQE3p1+jK+dLjXYspzl+uQH2pYQFJtEu20ggZQFgRvj5QxvMutuHt?=
 =?us-ascii?Q?C9JAS3tsbV5Ek3/3kdpZXGaWlYqcaYizs2+Ao6Y1yn1C4s8uHK7KGHphQ9JG?=
 =?us-ascii?Q?yInJ0C4DogwJV7ZSJqe+pWcj+ZbZ6u+qyLjZYJO207lXia3zIelB1zlaymU4?=
 =?us-ascii?Q?uXXOlqDaxR3RNBS097HHBNaBULjfe4wD43v/yeSS1Zyu0aBhDqN2fQO4hB13?=
 =?us-ascii?Q?n1VcrUj2R2pRYqwIdmCWwMK7W11atk0MwNwQp8rHCvOoG5szQTn41q+CQAhi?=
 =?us-ascii?Q?MEPxIURzyBbrKafBNAbJwKXsZu4A0+dlvhOPdND6?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kOprNKC+PtKnfLGnhV9xMBVPAp13hexIUdwBVs7uSiOxSndCIgomLtCrazaLYU5JjAHYpJUS9ymAHN1EASkGUvcWmT6lcTXc1UsjalSFxYqR9gOch0rJl03uISJLavQXSdyMGZhDIm1qrdW21NeJkFM1LiJoiSp/VI6lZUaoKrruRJ7SM1gYPQ0JRgtSqcX7krULPSOdgjN6ncyzLbOPYLOjoPgEC7A67mV7z+NPBpkjz6nTAf5SqTVBJQDSEO3FLDSnrRYpycvyv67Dn7X2RznHJGiSu4xkmcd2zi059MrJ+pFhbIjwHuob+feaVoyIKtY4Lte7wJJvn78iSjV9zDxzJWKqvq9QVf/h9i/INsHSX3en1/XRWj97Kbsy57EWoVQWC4PYZ2vqoeEEz+SDYuJwh/P62UVcypvrdZjify8kaZB5JiKpXDAEla/qDGLFoQBfBhIkvQCJLP9Kd8nGy/iX0vBKqmffAQFttvTT6T7v/ItLWgqphvT31BTk46AbGlH75AzWwfbs6fN6hZlWeW5/NlB0I0ivm9omw9GLbD+qVDyhy9tMlV2tF07R+TzqRpzPEuJWP9IvhBYkRRHI9YvYfXM/lHuOFSLeiEFXkJU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 093436e7-0ff5-4ffa-a42b-08ddc7e71e94
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2025 23:42:42.3148
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BDUomHQWFjHcVbmtQ3pb4xVzS3Cj8h/GUzL2Qhr1t0Bf9J1eWyXmnlvc/jOlGF5RaYMkTD7by7hZGQS48d8PXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6395
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-20_02,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507200228
X-Authority-Analysis: v=2.4 cv=WaYMa1hX c=1 sm=1 tr=0 ts=687d7efb b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8
 a=QyXUC8HyAAAA:8 a=yPCof4ZbAAAA:8 a=dP5MOTGk7IcSfjIVwswA:9 cc=ntf
 awl=host:12061
X-Proofpoint-GUID: AcVDYv-dbkeVkIMrJOT4WURRafi_YcaU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIwMDIyOCBTYWx0ZWRfX49h/4cDE6oQt
 vnjuQVlo2MaKBbJGnW++A6xTacnTlN9+xySr5O376z+1rN9Ax0YBHg4vxgBAemYIstWjdzBeEKe
 EfBwlZ14LaiAjYiFc/O2seSkeJJ2x8FWpT7VmO1MeYyL6/jsp9z2bnUbKieLDoZrg+E5MaUfH54
 O784ocPNdJxaf/0howFMigENrZLAD3VLvacaZ0To2exPTMeUVz7P/EDHBqWVDbiYujz5dxILTVc
 bI66mwf2XzvFbkzW8qVaK24pj/GWQ4mLzbnMA1NEeMvizVjCDV+7Ux51Tgyiw9REburka2fj88V
 TY3sil2vy4bl2ZKsKk304hql5EbeyaWmFyeiI3LBftabg55WIiyCggys8Y9Mr8zf5OKIPP3zuXF
 sAmE7lVe5Ms12VXqovCYPXHW4hReZ3Fxpq847MzzWbWImGJB0woi8SNydtkN8/VvBkjHL0/U
X-Proofpoint-ORIG-GUID: AcVDYv-dbkeVkIMrJOT4WURRafi_YcaU

Now that p*d_populate_kernel{,init}() handles page table synchronization,
calling sync_global_pgds() is no longer necessary. Remove those
redundant calls.

Additionally, since arch_sync_kernel_mappings() is now the only remaining
caller of sync_global_pgds(), fold the function into its user.

Cc: stable@vger.kernel.org
Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
---
 arch/x86/mm/init_64.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index e4922b9c8403..f1507de3b7a3 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -228,7 +228,7 @@ static void sync_global_pgds_l4(unsigned long start, unsigned long end)
  * When memory was added make sure all the processes MM have
  * suitable PGD entries in the local PGD level page.
  */
-static void sync_global_pgds(unsigned long start, unsigned long end)
+void arch_sync_kernel_mappings(unsigned long start, unsigned long end)
 {
 	if (pgtable_l5_enabled())
 		sync_global_pgds_l5(start, end);
@@ -236,11 +236,6 @@ static void sync_global_pgds(unsigned long start, unsigned long end)
 		sync_global_pgds_l4(start, end);
 }
 
-void arch_sync_kernel_mappings(unsigned long start, unsigned long end)
-{
-	sync_global_pgds(start, end);
-}
-
 /*
  * NOTE: This function is marked __ref because it calls __init function
  * (alloc_bootmem_pages). It's safe to do it ONLY when after_bootmem == 0.
@@ -746,13 +741,11 @@ __kernel_physical_mapping_init(unsigned long paddr_start,
 			       unsigned long page_size_mask,
 			       pgprot_t prot, bool init)
 {
-	bool pgd_changed = false;
-	unsigned long vaddr, vaddr_start, vaddr_end, vaddr_next, paddr_last;
+	unsigned long vaddr, vaddr_end, vaddr_next, paddr_last;
 
 	paddr_last = paddr_end;
 	vaddr = (unsigned long)__va(paddr_start);
 	vaddr_end = (unsigned long)__va(paddr_end);
-	vaddr_start = vaddr;
 
 	for (; vaddr < vaddr_end; vaddr = vaddr_next) {
 		pgd_t *pgd = pgd_offset_k(vaddr);
@@ -781,12 +774,8 @@ __kernel_physical_mapping_init(unsigned long paddr_start,
 						 (pud_t *) p4d, init);
 
 		spin_unlock(&init_mm.page_table_lock);
-		pgd_changed = true;
 	}
 
-	if (pgd_changed)
-		sync_global_pgds(vaddr_start, vaddr_end - 1);
-
 	return paddr_last;
 }
 
@@ -1580,8 +1569,6 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
 		err = -ENOMEM;
 	} else
 		err = vmemmap_populate_basepages(start, end, node, NULL);
-	if (!err)
-		sync_global_pgds(start, end - 1);
 	return err;
 }
 
-- 
2.43.0


