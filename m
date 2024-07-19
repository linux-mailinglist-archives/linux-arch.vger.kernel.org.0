Return-Path: <linux-arch+bounces-5512-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCEA937209
	for <lists+linux-arch@lfdr.de>; Fri, 19 Jul 2024 03:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 319ED1F21D77
	for <lists+linux-arch@lfdr.de>; Fri, 19 Jul 2024 01:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 177581392;
	Fri, 19 Jul 2024 01:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EEOafQDm"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7AFA35
	for <linux-arch@vger.kernel.org>; Fri, 19 Jul 2024 01:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721352793; cv=fail; b=Gi52QBvPLDS0tUAIuw0Agan19nO8yIIRXpaMXcgVMuZcMrP1f0KqMFXRSClgcxQ2MTRTdGv51Q1pKXB+CW9gjEDh2PSUAogr8v4CTPdOeKs7KzeG2D330zxzA3IiUisTomCH9IlMPBlFmxYFofQJJ/8kosFvdnvvahIgPlxp1jM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721352793; c=relaxed/simple;
	bh=y/wx++sOG7CYabtiilfKDczmCaX/BiUpTsY4OAopr1c=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=RPxIQkKOHCih8d38GGUAeG7Fdp3setO4crf8RHbQJkp7slMUEt593ZlyDCIeFYCWpn5K+3HQ6dirH+Nlldn6LE0nAjbvUPWrnWBCgmvqoxVaNFO/uWXxIg7dU6cFZICBQhthu6KuTvoalaX5psOA68RzhhftSjsAVauRWBI+mtc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EEOafQDm; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721352791; x=1752888791;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=y/wx++sOG7CYabtiilfKDczmCaX/BiUpTsY4OAopr1c=;
  b=EEOafQDmGsd708SMLKYXTy5CDVSxx1fylh/0KejiuDcQw4JIIfXSbOwS
   AiQS5SC1jSevWRtYYzj3ZwubdU2kl/p59yjUIew0BdGloRh/zPWKw6WFY
   JjZn12A4TLMqbEPywiQDX8xqqRnR7blxRTlt4ou7ARsxjfqNyAIAIAlXg
   QNQR1r7503rx+b+i8+jTBSgFAQ2ji1DoXvIBVIDASbAbTi3uoEEiHogEv
   q2Mxd+IQYtkmXCqfwJlKfBlt4hNtcg1N05OFVABAA4dz6mOC1p6PyyD5f
   OVXZ2izWHL/KJBXovoNIul4zosM4mD6zM5JOrNMqkpO/O+VM2aTfZpJnS
   g==;
X-CSE-ConnectionGUID: u7QtXCv7Tc6rxSQtYMg+QA==
X-CSE-MsgGUID: WCpFu7itQ1W4djRvpXPWcw==
X-IronPort-AV: E=McAfee;i="6700,10204,11137"; a="30107247"
X-IronPort-AV: E=Sophos;i="6.09,219,1716274800"; 
   d="scan'208";a="30107247"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2024 18:33:10 -0700
X-CSE-ConnectionGUID: 7X558f7CRsepC1Iqeuuj+Q==
X-CSE-MsgGUID: MwcwJWR/RkmgOLiF/aVwkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,219,1716274800"; 
   d="scan'208";a="81589683"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Jul 2024 18:33:10 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 18 Jul 2024 18:33:09 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 18 Jul 2024 18:33:09 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 18 Jul 2024 18:33:09 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 18 Jul 2024 18:33:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s+qwwuKq2ao1v//qvoW0Y5dDK9CPcP0+hMk4v0rpJQiuNh4yntitqQgTKvX5z/NwmFMf4v7LgP+AzaNOQtPRPVtojcmVDIdn3KLEkPiU9hnQsyqBjE+tK9A7WujsfhvzwCvpSmT/ZkqnBDLQIeeuyWjadkCYIDtxL9WnG8nJVQ6ljCnBQl6JHfSuDFvBcsx9KUhY9gfw62t4OWN4axxcO735VCOlW/7k3NDvMDQCW6lpoRJc3mZigc6eWNoIzIU1qmYpgdXOzSqWjVajQ2yLgnmRUMMAdbxikYKijfsfj+t9U5YWoTV2E6c+8SIZS+GR+T3Xr0a9h6U5xx3UujbvXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=suue0+s6zjHluM3pELWyYD8h+X+UqyjROfhIRuegcew=;
 b=HduzXfDGf0nSFMsKmDO1S3vbEM4+sdsDQi0hp9NpPJK8eWNN6keLoSw3+6Gr3tXDDrSBiHFE6P/PADK3Jx1yXA80lhHj2D9RmUrBEFBWFVm2/e5EZkpYGPUKYmeRwKU5G/fUGaexJDN70Ah/BknPfQ0C+Hd09FxaP512yuC+awH2eU0EyY2WXTrFAprIY4BRaM8DpKsNGsyDpQY2NYBR6+Tt7dqTDFar8eAD3gV8l34zD4k4Tj7rEhnc/59ofJYGbfFDmXm9stRxQRqE97gth8nOzogtW2BMaumjG06jjeYMyv6U4IQScRqQHNrUi4nr5cRaUnVRzwUzuifbcR4OHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB6039.namprd11.prod.outlook.com (2603:10b6:8:76::6) by
 MN6PR11MB8170.namprd11.prod.outlook.com (2603:10b6:208:47c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Fri, 19 Jul
 2024 01:33:01 +0000
Received: from DS7PR11MB6039.namprd11.prod.outlook.com
 ([fe80::3f0c:a44c:f6a2:d3a9]) by DS7PR11MB6039.namprd11.prod.outlook.com
 ([fe80::3f0c:a44c:f6a2:d3a9%3]) with mapi id 15.20.7784.013; Fri, 19 Jul 2024
 01:33:01 +0000
Date: Fri, 19 Jul 2024 09:32:52 +0800
From: kernel test robot <lkp@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
CC: <oe-kbuild-all@lists.linux.dev>, <linux-arch@vger.kernel.org>
Subject: [arnd-asm-generic:syscall-tbl-6.11 57/98]
 arch/parisc/kernel/sys_parisc.c: linux/mm.h is included more than once.
Message-ID: <ZpnCRCOIAjA9A5LK@rli9-mobl>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR04CA0152.apcprd04.prod.outlook.com (2603:1096:4::14)
 To DS7PR11MB6039.namprd11.prod.outlook.com (2603:10b6:8:76::6)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB6039:EE_|MN6PR11MB8170:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cc2a520-8136-4218-3996-08dca792b9ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+oeH3feU2B3LZ5tpEjaci8VELPaEYj/gpFiTDww0kvAUNva4WBVSQQz2N2VU?=
 =?us-ascii?Q?GE8CrKQs7tjyagi1jc0WiDK1pTpmhggc8YD4ZXX3++NaYxVs5vPhixjZ2hbn?=
 =?us-ascii?Q?cwUFPjHd1juG/Czgj2yRoOUj3bSo5mlogC6pckeLmjj6NSCHD8OerHQJHRdQ?=
 =?us-ascii?Q?p0V5iqA8S+8+CJyemP+6IzW9njyCl7CJBACA46RknK90/S773hbjVxGqWvev?=
 =?us-ascii?Q?WqKI4d3EmyBNNSYDE1MDAybiZiLU/VPAQHz2E71EK88xCmBxm9KGGaeP/HcJ?=
 =?us-ascii?Q?6Q9JOMscgbM1YNervRxY5qxXyj68pdlZDDLhBxo907X6Szg/55J8wfvs3hWx?=
 =?us-ascii?Q?bycV9j3zSarFvvJ40o+BmQ49MiKE7uGWNE7o6ooFzrcr19Db/Pwa1HLtjYsC?=
 =?us-ascii?Q?f3AZ0hP2pxaG3gymg1umi+A1VlaH/7G6tu1wPxqYjFEgEk0XRug7Qmy4Dpy3?=
 =?us-ascii?Q?MgSes9bSEzh8woU8S5Tug/Kjktl1ZeNLL4GF6iCPWIhmQqz+ZiCiP/aB7m8G?=
 =?us-ascii?Q?WZgLPyNCrIDn0GFfASsMrr9RgZ7pmUemLbxAvNeEdg5ud9cNog6aWgfPLuv3?=
 =?us-ascii?Q?7loUNuVym+Iujn1jwSBp5nlx740Ri3Xa2IX7UEMdLGkl6FnY1FjRR1trKKQM?=
 =?us-ascii?Q?2s/XYe7YqxDAUsIvs9bYpjOC6ueYNkU7pZHgwxyeVdF6y5r30d3wHsSo11a/?=
 =?us-ascii?Q?fCzA/H+z8+oek7A4tqUzbbD+oMGv3K1My0YQ1BAaaDe+7surLKCL4T/QaLDc?=
 =?us-ascii?Q?cZ0TmrB+ZoqkJ5RFFmDY8OvkU/TCVdqPOg7erLwdt2wsQujnLPMQRDBnkVTc?=
 =?us-ascii?Q?1kStcNorzKvJzitmt0+RVMSwuP1RQavMFsnymrfa0hWl7KjVWh1PiwrTBmSa?=
 =?us-ascii?Q?dM7ksfWQZ0101czQwIgcVC/2WnVCxz9Bvqej9ClY1W6P8zk1DsyKHaiTn05d?=
 =?us-ascii?Q?YOf7o2eMRydeE8zuG+BteLRsv7wnwUowLYUb0Gu/2WNt/aCqYGXzQ92A+upG?=
 =?us-ascii?Q?FO+Smqm/QXJZmrYx94Ft17DjAq/rOz0HEMSpW+4OEMO6dqRWCcaK00rpKiHi?=
 =?us-ascii?Q?akdg6C4i4thMch4r8RwZ80517yDBiQtz0pXFzNfahIzUvJZck3Ei+QP95GPn?=
 =?us-ascii?Q?3YivK3sgmBrPhPQ51Khl/661KEk7zJwQxx6kmDUFMCoKM/i7667zXQV+upzS?=
 =?us-ascii?Q?zLB+c1M/pJhhAbzGYSVduHFyeEpuvhT0a9OSeP34bCEDMFAyFTmmii+lQs4E?=
 =?us-ascii?Q?4lZ2dJOXFTpL6wavxMLIQnHyAALVNN/Oj9RT7nVcZvea/a6DHM3zBkNBRiIV?=
 =?us-ascii?Q?ck4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB6039.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sJqV76zkco39HHpeFrtGtJsN3z9KEx1MDBklMwTPxvjFwHyLyEz71kIZGkmP?=
 =?us-ascii?Q?OfjD036oRpvTXeA41QNpVEXx0yxqWzNuM1vA4SRhw6tv+ySbizSfPj5VO84E?=
 =?us-ascii?Q?FPRmyd9Kaa2CFXETZIf2/9/D5EIWFNTXszt5KQ5j1p97KSCJ7MuldoB4YztB?=
 =?us-ascii?Q?CHyGcTFL1lDlHCrgzLig4O9po4qwcq29iM+ziBZhSo3TE1HlW4h/Mmbx+dgM?=
 =?us-ascii?Q?9tZUnyi2v/1w8QllC8sciYZLZ8+0F6vz/adeOQnrM+NmhH1UojykYEK/B63/?=
 =?us-ascii?Q?Tog2zzCDn+uxVbYan0dL0AmNwUKv2cRmCm//j/A0O+UedGUHJyJgB4G8OxFp?=
 =?us-ascii?Q?nmkdqJtuEOWqi5vY2i/UVqqzVSJFU0bREh6E95oNXOa3bwMPaMoGlH40PgIG?=
 =?us-ascii?Q?q7Vp3Ygn7eqRrtCz85DvZweLDIQ7SLmETNsgq+LR0JV9qClxaE1SenXYK5eM?=
 =?us-ascii?Q?5VeN4kfk3OvaqsACeAlaKZqQtv+ZIY1cCBHH90O98Gq38lY8S5o/wF3Lgqni?=
 =?us-ascii?Q?fK1uToWUPVnT/ZLDQGBCRe8Q3V+ZJLheTIx9SQq2U6BQc3SrSby0OY7P2zSN?=
 =?us-ascii?Q?wEahXC9StVfEiZNa6T3l9foZgLZ4PbfuIrh6wN6sc9MoZOKPo8tr68h/Sxfk?=
 =?us-ascii?Q?ifluyGhGGiulRiN61AYfLe3v93c7IkwRZEje6T8MFXZPJpHEDETxnuYeO+zZ?=
 =?us-ascii?Q?a3+QU18Mp00+TcMY1KKGUaWmKr4P5T+oa9ru8w3ScYjZ3Xyuc5KYIvR2J57C?=
 =?us-ascii?Q?ImXv4Xmi3DrB5PKcKKODBpTao+SeU2WsbRudAGUmzeNWj1x8/v9uVwQXiNS+?=
 =?us-ascii?Q?G7rz72+N1+FMoNSyaUZyKBB5UTwOC9Rum4+F7GlU6L1V7xTuxiy6xhAitn7l?=
 =?us-ascii?Q?8qOqu3jujfV6MeFwt0/Oon1Vq2O95EgBXtEsZS8zj6vjta2OtQ8tNKbruOf8?=
 =?us-ascii?Q?LsArJsxQSO/fzJ0Ewkl9IsgQvUZsb6fk6honxVFP53YMqhummXZLKuiyZglZ?=
 =?us-ascii?Q?2gCUcPUar3DISrWM47lCUEGTGEWtoJa/BRzi44p0+3odCEb+FJPcTYR0AbAQ?=
 =?us-ascii?Q?0qUoAkT6NZTF6Mt8iY4JdySgOI2hJZRyEpqMKf++F4oPr9B10iKKwq80ELaQ?=
 =?us-ascii?Q?scDXiTcXPVIEXPNMZsYTUkakN+Lv6pHmf9McqU8zG8JNWJ0D4RBwzQa3sr9R?=
 =?us-ascii?Q?JTVAv+ztM/UTUT7IvFnVAkoXzKlmOp84RtPq69YdOOmb01wDzebSBotHvBu5?=
 =?us-ascii?Q?1VFHoN8rK+yM1WSncgOhgWMyqYTm9N9Cd4rBwdiCvGyC7zHw6Govf3DBUt5/?=
 =?us-ascii?Q?a4H+gzOzOXP9gbXlm1hWnGxDiNKBcR8oHcFf5gtBAlBvhQiEQqrebWuAqPzW?=
 =?us-ascii?Q?5jEcjQePcknkEhYfjYpfkvroXpuKjjjD+bsmyMxmz4X8LcXJ9EsBWkmMxAoz?=
 =?us-ascii?Q?+qjxIy3zKqEABxH1jz5Lva8C3Ctz02/d41D5ZmIj1UKMrz3B0vrgyg12H5aT?=
 =?us-ascii?Q?UwUHS0XFSVmRHZ2+35dpvFaGubSBPfEniXjBIknBhLjFLI0BfgI5N0UpyVsd?=
 =?us-ascii?Q?RpFYQwEQSvlxlfyDg0SCj9FAN2ZFvGhNzoQpJUtorFjmupSSC7DFiH+OFw9x?=
 =?us-ascii?Q?6w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cc2a520-8136-4218-3996-08dca792b9ed
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB6039.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 01:33:01.2466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jZlJKf39qkk7Jwsv9SupYSq0IBeRsZyKhZzP6pLj1I4nnrzYB0HmMVBNwTr0RWnul+vJHuYvXlyA85Y+ai1NvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8170
X-OriginatorOrg: intel.com

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git syscall-tbl-6.11
head:   9a99991d90521113a738c2a4761a4147fe4b31ca
commit: 6dd7c7b7b787ca6273ef9ce283af778a15c25ff8 [57/98] parisc SYSCALL_DEFINE
:::::: branch date: 6 days ago
:::::: commit date: 13 days ago
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/r/202407190136.aEBZ4oyY-lkp@intel.com/

includecheck warnings: (new ones prefixed by >>)
>> arch/parisc/kernel/sys_parisc.c: linux/mm.h is included more than once.

vim +17 arch/parisc/kernel/sys_parisc.c

     2	
     3	/*
     4	 *    PARISC specific syscalls
     5	 *
     6	 *    Copyright (C) 1999-2003 Matthew Wilcox <willy at parisc-linux.org>
     7	 *    Copyright (C) 2000-2003 Paul Bame <bame at parisc-linux.org>
     8	 *    Copyright (C) 2001 Thomas Bogendoerfer <tsbogend at parisc-linux.org>
     9	 *    Copyright (C) 1999-2020 Helge Deller <deller@gmx.de>
    10	 */
    11	
    12	#include <linux/uaccess.h>
    13	#include <asm/elf.h>
    14	#include <linux/file.h>
    15	#include <linux/fs.h>
    16	#include <linux/linkage.h>
  > 17	#include <linux/mm.h>
    18	#include <linux/mman.h>
    19	#include <linux/sched/signal.h>
    20	#include <linux/sched/mm.h>
    21	#include <linux/shm.h>
    22	#include <linux/syscalls.h>
    23	#include <linux/utsname.h>
    24	#include <linux/personality.h>
    25	#include <linux/random.h>
    26	#include <linux/compat.h>
    27	#include <linux/elf-randomize.h>
  > 28	#include <linux/mm.h>
    29	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


