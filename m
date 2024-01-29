Return-Path: <linux-arch+bounces-1812-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE6D841518
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jan 2024 22:23:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AFCAB20D15
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jan 2024 21:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09CC5157E87;
	Mon, 29 Jan 2024 21:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RtCrPygT"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E0376020;
	Mon, 29 Jan 2024 21:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.55.52.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706563389; cv=fail; b=GeyZ5ewxZq3s8zGWkpTpu31B4eIeK64JmaSHgJogxMuETdEyONDRmhFhNlwq+CqXfwrMqi9Ryjv8uWrvADb64xEiI+471gUzLhRuuvIseEousOourSeY5O2BM9dnZYoYWaVaeYAo25N8xrfONV7Dv76cd6M65stp0cFALnxBZXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706563389; c=relaxed/simple;
	bh=xf2LulBxSHt1RXtMDFIPRSjtyr/+41Rt3BsU+P0GoPM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LGLg23+XmW/36hnDCuRaCuNpaw08z1mJU93zgMFOE4vDyBpIn/bms6GOZJBl4H5nVziwCqtwraPi1iZfH5S6PpxURUUod6k6ThZQKYWER6C/O8Z1D0h84XufYSa4ylDEC3NK/E/0456MEOWhIce6OjkJA7Kz0ApdkTJNTuJDLZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RtCrPygT; arc=fail smtp.client-ip=192.55.52.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706563388; x=1738099388;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=xf2LulBxSHt1RXtMDFIPRSjtyr/+41Rt3BsU+P0GoPM=;
  b=RtCrPygTNYhk6j0DB6mC4n3QV0jnuRGUfrgXhGq7QVrpxri1u5/WY9aI
   yG1tqDjjiW8Lnx1E5a9vcRZ+zijHInX1rtKph4kHc9sMtLtMRQjG8o7G5
   E2C6uJWKa2ScOAPuFCFr1Qxs+8bikxyOGKVYqrt2BeV1vF1HeGF+4V7f+
   hpl2kuixBgYf/DxNIoKAwVmA5sOLzxAHepDsThMjJ3fWgUCwvaizrKBl1
   95Gu7k0vdv/2OMTwqAXuQGtDtEyKj3/H+Gs+aHfuLzTg+16PxBx+I5RW2
   MZafykOFNgPrtiuLaFDrc81N5k+IVVlSt/Bdzb4C0GJtDAPYWhXZHddZg
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="402724972"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="402724972"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 13:23:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="29665336"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Jan 2024 13:23:06 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Jan 2024 13:23:05 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Jan 2024 13:23:04 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 29 Jan 2024 13:23:04 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 29 Jan 2024 13:23:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PWOVCKNFzN1h2HM4CXCNHVhKjHG2tIWYpKgdXTpz8jH8ziCnivdhvY0KCDzKhLS/VK8+er7q8paSRvKNgA+YpejSFT/A+ksWwz6rBmHEOdIX8L1tIfOzg5dLkqfIHENiKXXleTi8ctwalHIC7XFRkL9WZlJLTQQemwfOGbZnioSR0t4xPMDC+ykHuk9HrjrMI6fuZ/3LQtOi2mL6m+zV16zfLxze6DoyabmRRXf45PHxZRN4ex8IGTOyjjA0ULbME66p+b4H8MapGMThIENGMAKt8JCKBXap7q2Qj8A304liEUwFlBa/d1ClwYVsDaGut/pr8upDNg/IYRc7M2ZAfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QXcEM6n8Mlu0TNPiuBMLJ7Z58qv+am10UXwvZtprJ/Y=;
 b=AKyEnmTXghq+4yc06hnitg37uHWSKtIQwWKLjOu7QRSGgCgFvbK4FZHkz7Oq1cwwWb8Fma2ZtHx0cYiHd3YJKVUGQrICzye9Spis5DWUucMVW59vDqz6wCPll9qIrhefBen0A7iEYesQ7bCltMYunsKdHL/XRjtm1j7/wQXAOWh2uZsZbaRq2B7MRo1OZ2wmPPb0RDAbMPTqmYoYBTSMbOa7hTRbWErPzEnVPTvjRUB/IRMpNBcbApWGKIalG9JJsX8/qZUeeheAEDYFV2oYRFqINR1HYtyj5/Gu8N/M7a3ut98A+0RVX8R4pOGQscsAxCyWID4/Tmzg1+7aTWSHOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA0PR11MB8356.namprd11.prod.outlook.com (2603:10b6:208:486::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 21:23:01 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 21:23:00 +0000
Date: Mon, 29 Jan 2024 13:22:57 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Dan Williams
	<dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Dave
 Jiang" <dave.jiang@intel.com>
CC: <linux-kernel@vger.kernel.org>, Mathieu Desnoyers
	<mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-arch@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>,
	<linux-cxl@vger.kernel.org>, <nvdimm@lists.linux.dev>
Subject: Re: [RFC PATCH 0/7] Introduce cache_is_aliasing() to fix DAX
 regression
Message-ID: <65b8173160ec8_59028294b3@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240129210631.193493-1-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240129210631.193493-1-mathieu.desnoyers@efficios.com>
X-ClientProxiedBy: MW4PR04CA0154.namprd04.prod.outlook.com
 (2603:10b6:303:85::9) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA0PR11MB8356:EE_
X-MS-Office365-Filtering-Correlation-Id: a5b2ef27-e674-4689-f5a1-08dc21107863
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zsnBSDozb3/ffc7kYoQFDMlE9qWFLDjgOvoLiGM12zsV9x37HlRNd04bjOuUvqxWDLfO8cjNU4U5XY5LJk74uJiDfmzSGirNTdyqZRoF+S3SCs5giATbtA44IYjtGdPomyUSmCeQJZvQWkF3PMVs7ZivbsibA2VRd/bRC67S9P4SQnDF6Hhgm0mWtAl2vdF/VIdIWlc3BF4oHZhHOXnE93dkEgKn7x9dLjXSd08AbMlrYWO4IacdYIciDxwtLUkVN0x8MYwO3PxlBO60nI6SX3lU8kSEWqGvnH2RpQrjtevqYX1DaR+7ZyOjiO52hT6AfOYhNeGPacDSizWA0HQHX6sfTnZqtTTSWatbWKQTST+4vzPtBkbB5N1Tpa0IH9D3zGOZrZjwlT0U16F3mI0tH2TtIzVCsZEops7iST2fOHSe21WAP1aFQ1s0TR3wRogVQnbJ1uW8i1GgjyUDy37esVSBaHoTmFWG6OL7DL3JOEvyXIAC2B/bJQhTGzrvanYDeopCg0LdWLJTNqnOdURB8/Qnzdzgwa1g2iadIeY5R3AKZcyVlNE4D3C9BlS9bojx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(366004)(39860400002)(396003)(376002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(41300700001)(82960400001)(38100700002)(110136005)(316002)(6506007)(86362001)(54906003)(6636002)(66946007)(6486002)(66476007)(8676002)(8936002)(5660300002)(6512007)(9686003)(26005)(478600001)(2906002)(4326008)(6666004)(66556008)(66899024)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ryZT/I9SaDFZZPlWVMLCR99jTOfFnjAtK/CUVJHmOsDfp7vKH8S5tQ3mVR3y?=
 =?us-ascii?Q?QNH0SMWJ/01ZHcuxO3tJrD2ffM28bYTL7kDS6LvcOWepiSET5bKq8lUFj8dJ?=
 =?us-ascii?Q?ZKTJT8IH+Fjke77KK+3D1LbrbP0iJdEexv3g1HBUggkL0DD7Ald4UdzHQZmx?=
 =?us-ascii?Q?O35To9sJ5uCMcARKs9HkFZxJpxl7c3/UIicJWszayetfOARcBH3kK/1OiKHK?=
 =?us-ascii?Q?m4TdMec1v8HeDKm+hJXqA01zA2s1Nu9zfWVlo+bfSdu1oJNrWPvv2cGhJb/f?=
 =?us-ascii?Q?oCfowA4hXTbpMrDH8fm4ZEsejicFdjsfEru8oB+ei334FCIu556w+y12O8it?=
 =?us-ascii?Q?PLBVh1NcI8yI4NdRxA2vOCv/GBVb1Jern9RVwpQh3zkQ/jEg0mlHdI757ZOw?=
 =?us-ascii?Q?P0aYebyLLEHzoiZQlMmZPSvQDnDtl5MEvHcLXaUGbDxiPL2LX/TkIiHq0h8L?=
 =?us-ascii?Q?T5TEM9u6axshW+5pt/1bEXkDtfjs2gOgajDwHeKGa4tB3i81wIsR/9A5VTKh?=
 =?us-ascii?Q?M7VTsfaNDJkmC0h+norGzO0F9M+8wg19W/d6RUfZfJ1md48haAhdWpFkCz+O?=
 =?us-ascii?Q?Cuhy8sISalj+FEMwmWR0NnsKYTw3JFbnC0rWWGFJIfpgoEHYEFLxR0OcBExV?=
 =?us-ascii?Q?9tWG19lNbXeISHajOX0JkoA4wvJKCLk2NzgiIAjL994xNCu56F3Ie7iV9qED?=
 =?us-ascii?Q?DMbFhTfb5CTJUsAyQEjvPqOFbgnBpbYBOICUf2kGOoEnas32phXEyyU4mJ5H?=
 =?us-ascii?Q?5tWqVwaxKrMu5jg7j8Op4A03ef4ok7pVtbTWD+Gew5fe4kKH2l0z250OVizv?=
 =?us-ascii?Q?b/t9mSONGDxP+P/mw8Sc4W9i4PMGkTe/RUnZZYs+93kNwJ+jchevieFYRlDo?=
 =?us-ascii?Q?pH5RXVo1y+chUcQM9f7sDFmCh4BQyDA4rjtHx3M89LUNedsdt3TmjYGt6Vaf?=
 =?us-ascii?Q?yhkorypBS/FzUJ915pkxDUDhznaTIUUfIZYSEJweW3x8gD5q7fEVfsu60+M8?=
 =?us-ascii?Q?m8Ve1TBDsZ5JiHAj19cGe9Cw+eb5i5fj1DTK4M3AdodrPnbBKwBUV/5an630?=
 =?us-ascii?Q?xsIfyrB0LntpQ+bEEx+Nu2i9N1QkNBHcRtt3Pb6k8TiNKdwvFT37isgcaEAh?=
 =?us-ascii?Q?3+7GSeJ/EfG/oaUCufhNKieUQok0fBHL/DDTnwMF2W0UFsYD8WDZ5l6diiZo?=
 =?us-ascii?Q?TxRI7hPGGi0nOVgX+GYNRkzmlQuP2a1tHfX408TizHV1pti0TaME40o6Iqok?=
 =?us-ascii?Q?95YlJs2Ro1N1cNOBJZ0s5/v+GOQpRMs8CzAEiflZcqvCCzRS9xyutw+7j1N2?=
 =?us-ascii?Q?BBeUQMLXkMiqkwcSOwQ1H1z+pQRRxJhmx5hhLPgVPwT6tc4Xs/vtv0oxrBP0?=
 =?us-ascii?Q?jIhcFUGJsIjalIVLCt8+phvEQa8smcK8bdeebca0ZglnSs9Qmmj5tRHzSnn5?=
 =?us-ascii?Q?WrXELSWY+liQP/5cWXUq/Nms+0qAkBjYw4zfgVBjOBVsSi0X6C5Y0hHbHDQO?=
 =?us-ascii?Q?p+Dd06Ur8igXgedkU+dNmwGcU2BpsFWzQmWLHuQ6exERmHew6SnXSHAq6DGs?=
 =?us-ascii?Q?65tLR3lqMRzNL5Pc1ft6Z0qTUfXX0wLcDV10AY8l+JTxSCLT27Pvn1RcKqR1?=
 =?us-ascii?Q?sQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a5b2ef27-e674-4689-f5a1-08dc21107863
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 21:23:00.3944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8SRYYS57A5c7woHxV2xKq8Tb0KoqrSmhw8O6CB1P4wypFQwIbJbofTLnlhvhnkLeiB9m8WhbF+uygE1eaCyAk7WbyuxkEI8Wz5lIrncsffk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8356
X-OriginatorOrg: intel.com

Mathieu Desnoyers wrote:
> This commit introduced in v5.13 prevents building FS_DAX on 32-bit ARM,
> even on ARMv7 which does not have virtually aliased dcaches:
> 
> commit d92576f1167c ("dax: does not work correctly with virtual aliasing caches")
> 
> It used to work fine before: I have customers using dax over pmem on
> ARMv7, but this regression will likely prevent them from upgrading their
> kernel.
> 
> The root of the issue here is the fact that DAX was never designed to
> handle virtually aliased dcache (VIVT and VIPT with aliased dcache). It
> touches the pages through their linear mapping, which is not consistent
> with the userspace mappings on virtually aliased dcaches. 
> 
> This patch series introduces cache_is_aliasing() with new Kconfig
> options:
> 
>   * ARCH_HAS_CACHE_ALIASING
>   * ARCH_HAS_CACHE_ALIASING_DYNAMIC
> 
> and implements it for all architectures. The "DYNAMIC" implementation
> implements cache_is_aliasing() as a runtime check, which is what is
> needed on architectures like 32-bit ARMV6 and ARMV6K.
> 
> With this we can basically narrow down the list of architectures which
> are unsupported by DAX to those which are really affected.
> 
> Feedback is welcome,

Hi Mathieu, this looks good overall, just some quibbling about the
ordering.

I would introduce dax_is_supported() with the current overly broad
interpretation of "!(ARM || MIPS || SPARC)" using IS_ENABLED(), then
fixup the filesystems to use the new helper, and finally go back and
convert dax_is_supported() to use cache_is_aliasing() internally.

Separately, it is not clear to me why ARCH_HAS_CACHE_ALIASING_DYNAMIC
needs to exist. As long as all paths that care are calling
cache_is_aliasing() then whether it is dynamic or not is something only
the compiler cares about. If those dynamic archs do not want to pay the
.text size increase they can always do CONFIG_FS_DAX=n, right?

