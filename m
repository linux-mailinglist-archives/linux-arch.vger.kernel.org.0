Return-Path: <linux-arch+bounces-12312-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 122D2AD3B97
	for <lists+linux-arch@lfdr.de>; Tue, 10 Jun 2025 16:46:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 831D316495B
	for <lists+linux-arch@lfdr.de>; Tue, 10 Jun 2025 14:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A1B20766C;
	Tue, 10 Jun 2025 14:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NrHY2Ho8"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A931DED52;
	Tue, 10 Jun 2025 14:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749566746; cv=fail; b=sHmsivXZEhnEKHYwVZzau0zG2de+ALL3pxPsYAQS4uEIabXDER1LtecqWMTu54KHmv59PaPLQ+6zRokHlM5V7eIxvE+dA+aYILgx4d5F0tR10P3gL6JaskrsYDe+bQvhLy6HIwEaTfibLXzZ+SFZsAiy+ujVrsWnjX+5gCqh/wo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749566746; c=relaxed/simple;
	bh=YojbAdf9CFwMJLAS6fStli0IiquCYAiJeGrh7TxrOH0=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=j18CYv8+rJF2EXGoeqiFYEkCsl6tfBgPTXW+3YK3n3Hx46ZEVEQu6ia5LDUpuwWBLUK6or5f4IKAQavLOw5Z/eC0dS1r9A8Ov+hSZT/eXS+z2+L5J4F6TvFF9e3PS6rmirqWncKxaUQCaFM82FNYABgQQf1eROztZHeC+o5t8x0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NrHY2Ho8; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749566745; x=1781102745;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=YojbAdf9CFwMJLAS6fStli0IiquCYAiJeGrh7TxrOH0=;
  b=NrHY2Ho8ki/E998/+9k/dfwi5GjTqEJRkgu+h0sYC6d20MZUP0T21hfN
   jXy2k0Rcd17sdZrCTay7W4GY8T0uD4U/++aEuIXZ+B/N9wbaeRfJpu3T/
   A7v4FtbIQsK/p8msIXrEzAAgGDlnIULDllPhZ90l5K9breUUJ4PesFgyw
   tJL6AEk0JydfNNuiUYM0o9HlpqVpgVHTouzt4mhiUCZKzrrAEVox3Qka1
   1qF51CktVfqpe4keYkchpElMmuxyTCqXhDg/NDEavt9L5hh2uY7vEY8aN
   SkP4OdEeDFdev8Pm+2I9TH5giC2QtYVgrNhAQ/oEWTCC903Aom8gI35GQ
   Q==;
X-CSE-ConnectionGUID: DapXixloQl+zmLO2vM52Zg==
X-CSE-MsgGUID: zRVbZoI7Qj+6XQx/N16W0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="51767161"
X-IronPort-AV: E=Sophos;i="6.16,225,1744095600"; 
   d="scan'208";a="51767161"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 07:45:44 -0700
X-CSE-ConnectionGUID: ndQKzCJNREO5kQ3Fn0yrsA==
X-CSE-MsgGUID: 5FZMTl3PRK2hNbN/f/fe2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,225,1744095600"; 
   d="scan'208";a="151998805"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 07:45:43 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 10 Jun 2025 07:45:42 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 10 Jun 2025 07:45:42 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (40.107.96.53) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 10 Jun 2025 07:45:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ah4BsH6zoSj8AApEc+SHOhlEK32DKubjZKZKo//27NSnejcEt9paXNjkDFTXHxfmn5TdtCqkrb5TrHtwX7fOnIem9Q4WyYEbr8WUJYHHLLkDn+HLB8dLtcJc+m2fMkY7pQw6e7WxImOv2ZPxjV+5ago1qzBtu2B0d4yXgJXoX5adqtgyRwDP8TMpzmVFdKNw5yrfRz43rlBx2TQYyqEO44fCEtZ1QoAgqWuOYgUpZbBnguqx/CymQeGQeGtI7NxCSOsNlBxCgbd/4wCNDt0wSrMH5RRMB76/yYngTTzbX6ndL75d200ez9ZKg3ZLgQsa696CLg/5PmXg+j904bz4CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p9GUhvuuG58nVlTFc2WdMCCqyDf2HpQeNywcibcB7f8=;
 b=jVdY+h8j7GLUHKlXr5HaMIZSdkiLc2+SL/NVMtYRJzitdJsAdzMe+bC+aEettIA+2hSwrIQ82zFh7uhp/yjB/ZFs12cTNZWxYlHTGOdas+4dGVPnSt2Zc+elqntaMUuH/VqT4knfTgQhqQxmqhSbnvWdN4ZyJQYsa5JU/V5j08tN7c41xy0q4yv0UjE9XNAeMHqMjCWblwbX4uWTkYuuo2ZlPrUNKWuJx5aUqwh3faf5cUpwoafDvIiPYOLplxSHRnBkmf72LnxFtmSSa76UtP/eGyLQIH7s9yHjoivSDmlr6E1pI7+DWVdPZZQ/dKNLmTNQE5224dei9bQ3jBKQVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SA0PR11MB4671.namprd11.prod.outlook.com (2603:10b6:806:9f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.31; Tue, 10 Jun
 2025 14:45:39 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8792.034; Tue, 10 Jun 2025
 14:45:39 +0000
Date: Tue, 10 Jun 2025 22:45:27 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Steven Rostedt <rostedt@goodmis.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Mathieu Desnoyers
	<mathieu.desnoyers@efficios.com>, Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Andrew Morton
	<akpm@linux-foundation.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Caleb Sander Mateos <csander@purestorage.com>, Peter Zijlstra
	<peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Borislav Petkov
	<bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
	<linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [trace:sorttable/core] [tracepoints]  4c46711561:
 WARNING:at_kernel/tracepoint.c:#check_tracepoint
Message-ID: <202506102243.b697765c-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR01CA0026.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::16) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SA0PR11MB4671:EE_
X-MS-Office365-Filtering-Correlation-Id: fb2695b8-cdcc-4787-974f-08dda82d77b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FSyW52QNINh3w6rou2iTQyChUaE8Ac+GEUB3RdJq/qQ8/+c7MHk15WCHcCix?=
 =?us-ascii?Q?hC7L2ivNig02BE1mt3o5LIP+F7+nc6pp1evcqsdorSiyViXbkX1u+8xkCK9r?=
 =?us-ascii?Q?rl76bHxY9QleBz10kD+C5gT6meLadazv2lDDsBGIYV/RrhsxntOiMxheOBP2?=
 =?us-ascii?Q?CQJyL9lCmzObPaJe5/aRuWuCQNilvef0jBGcbnfGATK0pSqdZStWEanauwwt?=
 =?us-ascii?Q?k6LaAIcYatnFeVXSZFQcGvgBUPwoIJ1u/g7yq2jsR+IqBcC4zDYwpAhHYkMD?=
 =?us-ascii?Q?iE/wK4aX5QOKDqGtGO1f9qwf3sXMTKCCtEEB1Clxo+zzn2soRMLkiKbJvFvs?=
 =?us-ascii?Q?dL+y7goBeMoozLcioGGFeq38UYM+33OD7/zm3WszFZhiHQ+V5q3BAMahyl0d?=
 =?us-ascii?Q?IMvL/J8qjU5Tkyv2XEpYeESz9708aXN9By3GyO0H5r4HD9V4P3AoCgblcloY?=
 =?us-ascii?Q?X3d9owJ+zy5Chf3bnb/E4zMnV6wRPNvJbWVgs43dabNZi2npOCiCjkzOC4cf?=
 =?us-ascii?Q?81ReQcWcw3Hoh6U7xJOU274Gr7DNbZyDpV8CrKC3Qc4zY2azgdTz2WSlL0IZ?=
 =?us-ascii?Q?xYJFG5UOmn/zK8MCeA0BFijRjFJ9/aUMwe8jk/gRFNypQ2TwMhzrM/ow5XmX?=
 =?us-ascii?Q?KKR/oglIRFkSPlQk5JyJLtjy5WxWm2zh/SexWDFmZJ2i4kgSg3DRXMiRjlN1?=
 =?us-ascii?Q?AOFPRsMYKN2t4LQ3OOAyNX0Ma303OtFw85p9/UyrxlF0TqU41TLC8v8IYcfZ?=
 =?us-ascii?Q?T6Z5kjJ6AR89WimaWbgqgXOPYoR5JJEj4rlIOqo0EDaIl3ePs+MCFl1q/g3w?=
 =?us-ascii?Q?Ccb1daum0HcC6Rz/YdFOZwGE+7HxS00GQRw597yqeEH/9outANaPJ0/m5u7l?=
 =?us-ascii?Q?aXkTh5CX3kDLtviI0Bp4t8aLW1+hEgNCdyuWFS0323wwA/1/TIY1Z2QJQqOX?=
 =?us-ascii?Q?3kUYrvilvSiOnbLOgSWsRPYdlfTT2ymhBb7jogpLpz/oH001lyw6facI3flF?=
 =?us-ascii?Q?nEC60JOxf2WdcZketc0hpk4Fh9XOPdXwOJC3DtYzTA+xKoHTY/gEdTqQXOg3?=
 =?us-ascii?Q?tlShSaScnzryHb1kqjF2dJjRQQTXwb5jNjQ6ZsMHotMOuEI4LhN9zMjtzYXX?=
 =?us-ascii?Q?gaMlbvg/ZF7kxcZOfaPw6iygdOjEs+DjNmeTGm8CRmaPlokZp9xaJlSqRXiZ?=
 =?us-ascii?Q?HqVBIUSKgSN/exMmssjrpKIdRvF61EFfeHRqoSvJ+Iz7S6ocRoq7NJ2g8NcM?=
 =?us-ascii?Q?/8AT67dnM4mXjgzfZ3o2Tqy4+X6HnscFWKOXeTuqYjTkfCdFtCOehX8kRTZG?=
 =?us-ascii?Q?0s/zofuPEE63UlfNq6TIz7cNuv1T24Z29i9ShZyd4FTFGieiH77nBl//VrPZ?=
 =?us-ascii?Q?Um+IVbE6Nx8XH4iGftX9uW6VApp6?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BvuFcLs+4ZmcJ/uousWxSq32t0U/2h04/mhQNwGNnQ7U+3fdQoetJvcze5jz?=
 =?us-ascii?Q?tw4dZZkfHwRm8am7bK+K4xPACIM5bbLpY4X8dj0Ab959iMZgzHUVGs4jaoiZ?=
 =?us-ascii?Q?aSYOuw/bO3pPnSweJddCYWcCTc5rsS8chRsIW6C8IK+ZWWkJWXFJ684swgcq?=
 =?us-ascii?Q?oq1wmNIwbDfBkTUCrAIrd2uKcxupsFQOnJeCkqcCKkqE3/OdC2NZjcgeF0SC?=
 =?us-ascii?Q?jftFk3aWA2qQ2tluXnwx1nRG4/pPJRNAQO1UoWVHKyoRqMlyGF0y8VZ6j30c?=
 =?us-ascii?Q?1AZCMSLne/xndmiBY7ktxYIsM7jxmQ6r2QOwEmC0lWFrTqeLkpLkibM0RB1Q?=
 =?us-ascii?Q?V49o6mnLEgxi4s7xI3EcnF0xi2aqdq+RZEJKLls8ioE3+Da3aV3tfd3UgPea?=
 =?us-ascii?Q?RYeOw/38ysh58rlGRsC2W2dtF08QEgvmjtvRf7gkiAoCwJIHwAgol1UqnbQc?=
 =?us-ascii?Q?iA65AhCnUbOX6K3HJ/OQ9RuTESGPHyVQ6wkjjzxu4ZMh1KIKBsqCcl6Uebd1?=
 =?us-ascii?Q?H47yT5RZT/2Fr1q8QgNuaHYjFtLqyP72S/Mdk18lSrx3bF7H5yrzzuhfEPYQ?=
 =?us-ascii?Q?HS2udaPvZIMUyKpDTDlEvUwx9vCmvAInnoFxG6aJYZ4tFb+jJxuH1HC5ukAB?=
 =?us-ascii?Q?yCJMMOksrUJE3Ty66RNCI7jYSXAMFWqWh2VSEDQ0OlWox7NsPkkE4gxIXvlJ?=
 =?us-ascii?Q?JBGzQ1HwREwcqvCFtoJvcJxuHoXXLCZJNDn7AavOVC8pcQbps6Y4HLIBWfSg?=
 =?us-ascii?Q?T40uxg4BR8C/YcwnSDlPwWPdkDIOR4myX5II3tOQTAO0Tv50hJZ1AaezPN4O?=
 =?us-ascii?Q?BFsXKRElTGUaFTR5fEYmBnXDTZ5Nr+/1SIgV1l+zH8v9NsulxXCDPLk1icUR?=
 =?us-ascii?Q?LTzh+xZvhuPptPn8Rbc5MNayaTlEOA9ZADkfeYUZd635yTgRsdZatZpIo524?=
 =?us-ascii?Q?3E71VYXhr8dI4jwUomcOLlhh5XdEdEtZMONhDnAvMEZC+1/HnPmO2JBe6OUe?=
 =?us-ascii?Q?9NXGRJvnP5yguQXPDmmhQlqHmVao2D6bpLs55ZQSX6yl355HaR6PepagahvC?=
 =?us-ascii?Q?Y03r7C+xyC7fU49jLRVDjHuGmxpE5Pcn9kyu8/WDVfLbwgHsjjA7UsQp/Wda?=
 =?us-ascii?Q?KUEMgmH84j9GGbReSlJhwNU41yZ7rU5dENUR1EDKLDx04a5NAB2KUURErZoc?=
 =?us-ascii?Q?xrqcCrcVsdNWbEoP77O/u0dC1DstRVNN9CqoXybZAP2C1PDNHlpYYOGHcPZh?=
 =?us-ascii?Q?LegOlYwL1RLC4s94C4C+M3CnaGooWDX1sUIVabNTAU6yTW7yMmiBPPYy9YM4?=
 =?us-ascii?Q?FWgBQOUaiqXHGmqKurwLzal4zWAZwHpxv3LDLGKzcCSyqgfJKZpaA2yzaPNE?=
 =?us-ascii?Q?9kuaNsMvvQrxF7c4p5I2Ww5Kg0VVWWwAUlTj7VcBaztAlxvQIkfQy/cxI3H6?=
 =?us-ascii?Q?5Vu4EL6LktO9I73qkGjn/CpgkcTtra/rO0+wi9kIst2cxo3DmDouegpfDa4t?=
 =?us-ascii?Q?z9+pl4sleicd0KY+Rv1ilYOs4ymf6F6b/1pEOtsDy7pc9LFdwlOXoEwOFTEa?=
 =?us-ascii?Q?wXPSNrJkzkVkeTx3pODBluO1pL/0JxJt08ubN/96K4afh+plT3SKgCgfOXIi?=
 =?us-ascii?Q?8A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fb2695b8-cdcc-4787-974f-08dda82d77b8
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 14:45:39.5143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iqcVbhDTi6WMiAueAKUqGU7dTJS/Rv7Jq0ViswUsqY4Fx7rY8jEnys3vK8xVfDCpxSJltZGZdVn6R8eVUSSHsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4671
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:at_kernel/tracepoint.c:#check_tracepoint" on:

commit: 4c4671156167615772fe0019b7aa80002d8c15b6 ("tracepoints: Add verifier that makes sure all defined tracepoints are used")
https://git.kernel.org/cgit/linux/kernel/git/trace/linux-trace sorttable/core

in testcase: boot

config: x86_64-randconfig-072-20250609
compiler: gcc-11
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+-------------------------------------------------------------+------------+------------+
|                                                             | e271ed52b3 | 4c46711561 |
+-------------------------------------------------------------+------------+------------+
| WARNING:at_kernel/tracepoint.c:#check_tracepoint            | 0          | 11         |
| RIP:check_tracepoint                                        | 0          | 11         |
+-------------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202506102243.b697765c-lkp@intel.com


[    9.273626][    T1] ------------[ cut here ]------------
[    9.274045][    T1] Unused tracepoints found
[ 9.274105][ T1] WARNING: CPU: 0 PID: 1 at kernel/tracepoint.c:688 check_tracepoint (kernel/tracepoint.c:688 (discriminator 3)) 
[    9.275256][    T1] Modules linked in:
[    9.275575][    T1] CPU: 0 UID: 0 PID: 1 Comm: swapper Not tainted 6.15.0-12427-g4c4671156167 #1 PREEMPTLAZY
[    9.276336][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 9.277119][ T1] RIP: 0010:check_tracepoint (kernel/tracepoint.c:688 (discriminator 3)) 
[ 9.277642][ T1] Code: 0f 00 80 3d 46 b9 4b 02 00 75 21 48 c7 c7 71 17 8d 83 e8 d1 1d 0f 00 48 c7 c7 a4 d1 f1 82 c6 05 2a b9 4b 02 01 e8 8a 39 f0 ff <0f> 0b 48 89 df e8 16 2a 0f 00 48 8b 33 48 c7 c7 bd d1 f1 82 e8 f9
All code
========
   0:	0f 00 80 3d 46 b9 4b 	sldt   0x4bb9463d(%rax)
   7:	02 00                	add    (%rax),%al
   9:	75 21                	jne    0x2c
   b:	48 c7 c7 71 17 8d 83 	mov    $0xffffffff838d1771,%rdi
  12:	e8 d1 1d 0f 00       	call   0xf1de8
  17:	48 c7 c7 a4 d1 f1 82 	mov    $0xffffffff82f1d1a4,%rdi
  1e:	c6 05 2a b9 4b 02 01 	movb   $0x1,0x24bb92a(%rip)        # 0x24bb94f
  25:	e8 8a 39 f0 ff       	call   0xfffffffffff039b4
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	48 89 df             	mov    %rbx,%rdi
  2f:	e8 16 2a 0f 00       	call   0xf2a4a
  34:	48 8b 33             	mov    (%rbx),%rsi
  37:	48 c7 c7 bd d1 f1 82 	mov    $0xffffffff82f1d1bd,%rdi
  3e:	e8                   	.byte 0xe8
  3f:	f9                   	stc

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	48 89 df             	mov    %rbx,%rdi
   5:	e8 16 2a 0f 00       	call   0xf2a20
   a:	48 8b 33             	mov    (%rbx),%rsi
   d:	48 c7 c7 bd d1 f1 82 	mov    $0xffffffff82f1d1bd,%rdi
  14:	e8                   	.byte 0xe8
  15:	f9                   	stc
[    9.279195][    T1] RSP: 0000:ffff888100343de0 EFLAGS: 00010246
[    9.279737][    T1] RAX: 0000000000000000 RBX: ffffffff838d2300 RCX: 0000000000000000
[    9.280402][    T1] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[    9.281016][    T1] RBP: ffffffff838d2330 R08: 0000000000000000 R09: 0000000000000000
[    9.281704][    T1] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff81415df1
[    9.282299][    T1] R13: 0000000000000000 R14: ffffffff83ffe070 R15: 0000000000000007
[    9.283030][    T1] FS:  0000000000000000(0000) GS:0000000000000000(0000) knlGS:0000000000000000
[    9.283729][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    9.284277][    T1] CR2: ffff88843ffff000 CR3: 000000000325b000 CR4: 00000000000406b0
[    9.284954][    T1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    9.285557][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    9.286283][    T1] Call Trace:
[    9.286548][    T1]  <TASK>
[ 9.286775][ T1] for_each_tracepoint_range (kernel/tracepoint.c:519) 
[ 9.287202][ T1] ? utsname_sysctl_init (kernel/tracepoint.c:696) 
[ 9.287624][ T1] ? allocate_probes (kernel/tracepoint.c:687) 
[ 9.288011][ T1] for_each_kernel_tracepoint (kernel/tracepoint.c:769) 
[ 9.288462][ T1] init_tracepoints (kernel/tracepoint.c:710) 
[ 9.288921][ T1] do_one_initcall (arch/x86/include/asm/atomic.h:23 include/linux/atomic/atomic-arch-fallback.h:457 include/linux/jump_label.h:262 include/trace/events/initcall.h:48 init/main.c:1274) 
[ 9.289283][ T1] do_initcalls (init/main.c:1334 init/main.c:1351) 
[ 9.289815][ T1] kernel_init_freeable (init/main.c:1587) 
[ 9.290257][ T1] ? rest_init (init/main.c:1465) 
[ 9.290622][ T1] kernel_init (init/main.c:1475) 
[ 9.290956][ T1] ret_from_fork (arch/x86/kernel/process.c:154) 
[ 9.291381][ T1] ? rest_init (init/main.c:1465) 
[ 9.291777][ T1] ret_from_fork_asm (arch/x86/entry/entry_64.S:255) 
[    9.292235][    T1]  </TASK>
[    9.292472][    T1] irq event stamp: 77440
[ 9.292849][ T1] hardirqs last enabled at (77448): __up_console_sem (arch/x86/include/asm/paravirt.h:660 (discriminator 3) arch/x86/include/asm/irqflags.h:151 (discriminator 3) kernel/printk/printk.c:344 (discriminator 3)) 
[ 9.293657][ T1] hardirqs last disabled at (77457): __up_console_sem (kernel/printk/printk.c:342 (discriminator 3)) 
[ 9.294517][ T1] softirqs last enabled at (77277): handle_softirqs (arch/x86/include/asm/preempt.h:27 kernel/softirq.c:426 kernel/softirq.c:607) 
[ 9.295766][ T1] softirqs last disabled at (77268): __irq_exit_rcu (kernel/softirq.c:453 kernel/softirq.c:680) 
[    9.296883][    T1] ---[ end trace 0000000000000000 ]---
[    9.297510][    T1] Tracepoint vector_free_moved unused
[    9.298267][    T1] Tracepoint x86_fpu_before_restore unused
[    9.298966][    T1] Tracepoint x86_fpu_after_restore unused
[    9.299735][    T1] Tracepoint x86_fpu_init_state unused
[    9.300344][    T1] Tracepoint sched_migrate_task unused
[    9.300977][    T1] Tracepoint sched_move_numa unused
[    9.301669][    T1] Tracepoint sched_stick_numa unused
[    9.302300][    T1] Tracepoint sched_swap_numa unused
[    9.302927][    T1] Tracepoint pelt_cfs_tp unused
[    9.303520][    T1] Tracepoint pelt_rt_tp unused
[    9.304074][    T1] Tracepoint pelt_dl_tp unused
[    9.304638][    T1] Tracepoint pelt_hw_tp unused
[    9.305447][    T1] Tracepoint pelt_irq_tp unused
[    9.306091][    T1] Tracepoint pelt_se_tp unused
[    9.306656][    T1] Tracepoint sched_cpu_capacity_tp unused
[    9.307293][    T1] Tracepoint sched_overutilized_tp unused
[    9.307874][    T1] Tracepoint sched_util_est_cfs_tp unused
[    9.308500][    T1] Tracepoint sched_util_est_se_tp unused
[    9.309081][    T1] Tracepoint sched_compute_energy_tp unused
[    9.309766][    T1] Tracepoint ipi_raise unused
[    9.310226][    T1] Tracepoint ipi_send_cpumask unused
[    9.310894][    T1] Tracepoint ipi_entry unused
[    9.311664][    T1] Tracepoint ipi_exit unused
[    9.312189][    T1] Tracepoint rcu_utilization unused
[    9.312811][    T1] Tracepoint rcu_watching unused
[    9.313451][    T1] Tracepoint rcu_callback unused
[    9.314046][    T1] Tracepoint rcu_segcb_stats unused
[    9.314662][    T1] Tracepoint rcu_batch_start unused
[    9.315267][    T1] Tracepoint rcu_invoke_kvfree_callback unused
[    9.316055][    T1] Tracepoint rcu_invoke_kfree_bulk_callback unused
[    9.316819][    T1] Tracepoint rcu_sr_normal unused
[    9.317407][    T1] Tracepoint rcu_batch_end unused
[    9.318013][    T1] Tracepoint rcu_barrier unused
[    9.318582][    T1] Tracepoint timer_base_idle unused
[    9.319097][    T1] Tracepoint itimer_state unused
[    9.319645][    T1] Tracepoint itimer_expire unused
[    9.320249][    T1] Tracepoint alarmtimer_suspend unused
[    9.320870][    T1] Tracepoint psci_domain_idle_enter unused
[    9.321531][    T1] Tracepoint psci_domain_idle_exit unused
[    9.322292][    T1] Tracepoint powernv_throttle unused
[    9.323017][    T1] Tracepoint pstate_sample unused
[    9.323674][    T1] Tracepoint clock_enable unused
[    9.324230][    T1] Tracepoint clock_disable unused
[    9.324860][    T1] Tracepoint clock_set_rate unused
[    9.325512][    T1] Tracepoint power_domain_target unused
[    9.326160][    T1] Tracepoint xdp_bulk_tx unused
[    9.326808][    T1] Tracepoint xdp_redirect_map unused
[    9.327461][    T1] Tracepoint xdp_redirect_map_err unused
[    9.328108][    T1] Tracepoint mm_vmscan_node_reclaim_begin unused
[    9.328955][    T1] Tracepoint mm_vmscan_node_reclaim_end unused
[    9.329615][    T1] Tracepoint vma_mas_szero unused
[    9.330225][    T1] Tracepoint vma_store unused
[    9.330846][    T1] Tracepoint nfs_local_open_fh unused
[    9.331579][    T1] Tracepoint dma_fence_emit unused
[    9.332215][    T1] Tracepoint cdns3_stream_transfer_split unused
[    9.333057][    T1] Tracepoint cdns3_stream_transfer_split_next_part unused
[    9.333947][    T1] Tracepoint cdns3_map_request unused
[    9.334586][    T1] Tracepoint cdns3_mapped_request unused
[    9.335344][    T1] Tracepoint tcp_hash_md5_unexpected unused
[    9.336029][    T1] Tracepoint tcp_hash_md5_mismatch unused
[    9.336782][    T1] Tracepoint tcp_ao_wrong_maclen unused
[    9.337443][    T1] Tracepoint tcp_ao_mismatch unused
[    9.338140][    T1] Tracepoint tcp_ao_key_not_found unused
[    9.338828][    T1] Tracepoint tcp_ao_rnext_request unused
[    9.339595][    T1] Tracepoint tcp_ao_synack_no_key unused
[    9.340242][    T1] Tracepoint tcp_ao_snd_sne_update unused
[    9.340979][    T1] Tracepoint tcp_ao_rcv_sne_update unused
[    9.341729][    T1] Tracepoint rpc_socket_reset_connection unused


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250610/202506102243.b697765c-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


