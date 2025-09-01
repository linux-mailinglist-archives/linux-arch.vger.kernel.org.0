Return-Path: <linux-arch+bounces-13354-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E48B3E75F
	for <lists+linux-arch@lfdr.de>; Mon,  1 Sep 2025 16:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE3167AEED9
	for <lists+linux-arch@lfdr.de>; Mon,  1 Sep 2025 14:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCFE12045AD;
	Mon,  1 Sep 2025 14:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gXGubOZY"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48EC33A025
	for <linux-arch@vger.kernel.org>; Mon,  1 Sep 2025 14:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756737478; cv=fail; b=i66tnNW+jxmIPCep9W8qxdhFBF+y3xoYJoAkDBruB7gR46KtHVRRW9zn7n10PzPPHrIsKTV3WMx5LAiq/LILsCZ/e15dhlOskmOwopB7qp983Jbc0x9kd/mwBAy2ei8p8oGowZeZBxdCdujx1havlWhyvnHbXvBNd6owQTW6VyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756737478; c=relaxed/simple;
	bh=WTFpKZaetAJxbceMxrj8tvVByBUItVagzr7TOa8DGN8=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=WB5O/1vNghCdeDwb51lr0TtvLKzVGBTDfXMObOgAFG8rBrAhV3sVOag7EZIIm3z/t24tOgNyCETQCd+1iTRDnYO4wwy75kjNRpJbxHIxd8xp9dunY0R1W7pB9QZMYKpdAy5qtjxkWJLJjj9FYUv66tkdcDN/E0S+/f9MAvfLX4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gXGubOZY; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756737477; x=1788273477;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=WTFpKZaetAJxbceMxrj8tvVByBUItVagzr7TOa8DGN8=;
  b=gXGubOZY2if7TmIG8IpEkXmyKI1FJlf9qHpSfBe6mWu+Hx6v7w5HSdYB
   MIVmTkWyz+JGLpKjNhQ2Qk485Gpfkvw6s7gbS9mOIFRRD/CjNFgqdoidr
   afLuQshcJtqxSSeJjPO3NoG2rto2c7HrcfkgU0grFezvSnPb6nxsmq95X
   ocQbdAvM1usj6NSlr6bIJLJ5cPs9iw6Q02dK0sjy5Z4S189d1Pu8EvQZo
   Jl/Jvhkopwi9P38MgJPFly3ZBYHM0XSh3Lc3HOKbn0bi97Dv5RK3YRceZ
   mE5VHjeF9cf06+dLWU1QYLrxwAZ2A79N1Rmif+1qnG788MQYsvc1+vd9N
   Q==;
X-CSE-ConnectionGUID: HZ8tVGlBSJm8lgIEwDc2QA==
X-CSE-MsgGUID: IxwHnkCCRNe5KnU/jQGEYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="58916090"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="58916090"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2025 07:37:56 -0700
X-CSE-ConnectionGUID: gG8u+oZESH6VMFhe/C5XTA==
X-CSE-MsgGUID: GLqu547cSc+1MNw3QQcSlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; 
   d="scan'208";a="208240003"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2025 07:37:56 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 1 Sep 2025 07:37:55 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 1 Sep 2025 07:37:55 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (40.107.95.88) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 1 Sep 2025 07:37:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DpkStVqkmgoBHBzg7gbntBd2GaSvxU5OptcP7amdkr4S6prKXCZJZFl/ewc3hKMrzlBU9Q2GU0FpxTK0GnpD4E2/77OAlLXr0FjbT6dEUeRIrBABPetHOuwPuWjYCQ9OPzqtSy/ZRzAVp/J5Tr464gvAZ2zLDM33m1iHE3W2cMNFDJXx9GPH2xl99DclSLJwK9yU8wkJMBeiWm4HPWAWThXct8PTu5aCeIYLeRPvvErtzZxwndZeVa8oGRu/2LacNDdKEERGh8e/qlFjVxc54AbMJFfjxsk+g+QnHt05YWaFwuicR1C4a7MMMBKRmPrWwY9TOvhRN7spOlglHiMd1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9/jOCCFsyc2lXhgDIdBAugwRd89wTUpkQTVAbIFeVOU=;
 b=VwUl7kv0XNoWy3refXi1tdLEn7NqPtO6o6tlFUbXecSjn94OiMxiRz62UBbNeZm5CAxUwE/fKSjXr/dDz/u2deFArtRN2YmBO/bpViFXOglvyhEq+cx+b32X2q+pMOuZ7VDSTsQRsAfxq2cKajdc5Llz/jQ/PXSVu54N9djyhOLzI8/dIb4rqeM32jXwcTPWdgRDzAKfy+9UbOqz5XB0TaDs1oi93i8fcjNXigdXQ2Udv5uiXz550vdtrU8BbfcioMTae9ax3FtM5zUbsMrsgL8qT2XhVdNG9HcuB3CWPTb7yBqLZC4cnL29AZN+qTf3C1g8RSstdl5BQ/l/EZDSjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CO1PR11MB5106.namprd11.prod.outlook.com (2603:10b6:303:93::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Mon, 1 Sep
 2025 14:37:52 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9073.021; Mon, 1 Sep 2025
 14:37:52 +0000
Date: Mon, 1 Sep 2025 22:37:44 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Dave Hansen <dave.hansen@linux.intel.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-arch@vger.kernel.org>,
	<linux-mm@kvack.org>, <oliver.sang@intel.com>
Subject: [daveh-devel:kpte] [mm]  ccbd04de39:
 BUG:KASAN:wild-memory-access_in_pmd_alloc_one_noprof
Message-ID: <202509012256.9322539b-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR01CA0035.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::13) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CO1PR11MB5106:EE_
X-MS-Office365-Filtering-Correlation-Id: 898ddfae-7c12-49d6-f1ff-08dde96521ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?F0t1Uwa/L40EfPPXE6g90OVv7Y0OVGSb7qGVuyCybOwJQzpTiqLwFF9xtOaS?=
 =?us-ascii?Q?61GT6BnQUwG+WBSmAjGpWwbZMZTCUI7CXqwfUWFN9YUQdUbHypwqSqjY+lwb?=
 =?us-ascii?Q?myzWBf8d7kQcx6IyHxYRjMTRvEXxLs3YlpeB9LcAuQVkiNhMhGEtx24jOsmg?=
 =?us-ascii?Q?SFg4rK+gwUY1VOQRQvfaQqot4bJr+IuAef2KmZYu66jUtE34lHJQpUm/fogG?=
 =?us-ascii?Q?oewwARu5O6V4XY3KoeTC9qTyhLaUag9XICgmldPix607oOr+xT60UJLYKp64?=
 =?us-ascii?Q?bGxgKx6OImd53O+wLL84vh4nRZlvOFf9/PbRbeJypnM/cF25PasFmaRSb546?=
 =?us-ascii?Q?XZuoCk3tu0bOq6KOrdeaWQajq4CzhDBK057xlEaPO69IEA/jt7F9AocuehMy?=
 =?us-ascii?Q?Zphg+UqZraQ3wmif6oUW2XNb9x3wQIuqWukqOpx4C33RHNF14K7ujj8bRZv3?=
 =?us-ascii?Q?WqB3ApB/N7cmHGCoCgt6dQABZVyUim1CmUIoqRMaImVWETm9LHL/04w1NLg6?=
 =?us-ascii?Q?P+TvaTU1aIVVYPlgAp7JmvnwJdl4eBaFPK9M/60Hhv0Jx3fofvebK+Kp95i3?=
 =?us-ascii?Q?by3U9qYqeVXYdNHb0wVvLtJRahH0Vmae1bcNAZJddFvTV9jOMKfcfIhvAsSq?=
 =?us-ascii?Q?+eKTzsXOmwCny2wPr7giDMCUD9yRetk2AjkQ8BlDr0boBg2N7iUKe4zKa9bf?=
 =?us-ascii?Q?A7gTKEAyMdwbW1Dt6zMb6QPOB9MjaZRPWGh+hkXx6AHzuCPgf+G3Yo2PO9wp?=
 =?us-ascii?Q?QVvaEbT1Ywc499LjmOli+fsHKwgRs9GkBx9jgKXu4/bNmg+tU9MkeU1EV3kq?=
 =?us-ascii?Q?NbGrJw1U51A6IN6rtN8HUcZXWJqDvxAHtc6i9O7CIls2+s4oUU2I5MgUxPfR?=
 =?us-ascii?Q?INsEwb24Tn97Hd4znpzlH9Y6Nzo03oJ5wDIjx4K+h8B/XCcUBmqoqpVqNUQ5?=
 =?us-ascii?Q?mL3rvw4QvwMpihb0Oovay4AuCyYmxd1PD5cz8vfnKRyPRbsQIVWrLPl/Gj6p?=
 =?us-ascii?Q?j160k4FuPvBiquY2dchfBBHt9z0Js3w2ZnyybvAk4EAeTpPI3Cj+xzP22zkI?=
 =?us-ascii?Q?+giEif9GvKOvFiMXxNMLWdj/qTBFrqyQbnUmQPdwB/jiYR6I4U8vWuuyzMmC?=
 =?us-ascii?Q?8j2JdyCS08JvcrttbBRVzkQVjYbD6m08WrSlNdbyiEZVVEdyJhr3JBuG72iu?=
 =?us-ascii?Q?cQQSiv5GoZjUdrdm+IGzN9rzfd0l7qrNrOG3bUoIIAa19FWJtVWXeGaoPV2E?=
 =?us-ascii?Q?49X1HlmWKRnCv8G8S39l51Co15zi+6sE7tOLHhG+89ZVJtlUUMlrrG3VNipd?=
 =?us-ascii?Q?S/ijiFL6AGQFA1tdehWmXgb74+V4TI0gzRLIxvSwH/Hl3RNTrXF53f1K9Wxu?=
 =?us-ascii?Q?g/0XHfSsALSqvrAZGVdKBI/it0/U?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l3IWmpYb8E+5f00CQzuNKXsVCuDyLK5UdE1X0SDrh420aFDJG7RgY0et7qAQ?=
 =?us-ascii?Q?0Po3dZSVt2gWXPbfJnqzNk9+a9QNbJ5zCaCTPdonuQAP4QBJnyYWB/T0hzHb?=
 =?us-ascii?Q?p4I9/jToY3TRdLFKKgUy4laNRikYuGNepFxs57p89zesSYkzz96BA8aUfRVl?=
 =?us-ascii?Q?pesGI1HTnOz/2bhokdwanJV/YUqbmtO5LGlACYkAMNKNVOshA8tBfCkKlFp/?=
 =?us-ascii?Q?4SjUjq/Fk1zaW3pVRTnO/k2P+Q1Py9NMpgI8kqQgCpOu+N+EcaAwVu8YMl5X?=
 =?us-ascii?Q?o6VRMf+fW1AUqFU4sZkf7OeXz5UYY6sTGydRngE251ymUYW7ARi+SlVZRRKb?=
 =?us-ascii?Q?cJdvx5awZc7KlxWz8SvmeK9Yr3gbZ2I5uICbkg3mUdisq4VXL0nF35W71z5w?=
 =?us-ascii?Q?06Km4iN42hJqeQtqlcEFnt7RXfmtMh0cl4gKJruUy0ElRsx5XHBOaEutjKvO?=
 =?us-ascii?Q?4xOdETyQ1PtmojjV/YC1UvGc8Pz2sXDVwMSmEc0qZwyyvpmt8VZIohbTISVY?=
 =?us-ascii?Q?9sH+MGzPt7hVxI4oEN2ImyYWGbG7f8+aLyvoYQ1TlGN8saWABaVHQHwMXriN?=
 =?us-ascii?Q?tvJ3/aRCZPiNxKJaZhW5SqF349S7HqeHsri0CP8qAxj9zYPtyuw7mxWPQ1vv?=
 =?us-ascii?Q?37DJUZvsIFGKUQqMkmcc1UB9K7KMOXlVPctB5BFDet70kvGHPlWzUkUeHiyO?=
 =?us-ascii?Q?62gdt6iejf1scj6Iy8Yqq9TyPfElsArP4ZYzuSXKavbYEiHKt+YFcOvVhADY?=
 =?us-ascii?Q?MvW5IzRFB2+C/9wsY58srRqtKjrU+pzlZCrbbgYjBk6e0HSwJxPq2mXMnPBc?=
 =?us-ascii?Q?PMJMlL3JhOp0l0Zv+6Ph9m4wb2TQ6yAyDB/0TBngIp6EPHpLH8seCeIKcYQZ?=
 =?us-ascii?Q?J9UcJZdKDc+Z8Wm13uAsTfOzxBuyGt2gqycurmioy8W1JRF3N/jwmFgYnsqN?=
 =?us-ascii?Q?rpSBZWf/Qtr3suX84zYt+S1wNTZoE0i7GIAqUU3B8f/QLU7jtJHdheJunJxi?=
 =?us-ascii?Q?LEK8jA/LKo7FAvI8De+mrmfHuwALms2vBQJCU3tOjMHDkoNrwlBwEQv83bc2?=
 =?us-ascii?Q?xNS6sn9uWvCfpYdK2T++3IEP0Uw6bTX4jvNmN9zPFsKuIWWnLjAzoVKkwMl8?=
 =?us-ascii?Q?/zS2PlN9PodfXVs2689Ps3VXTGTbh6OwN9oes8VUEATynnwgLOZS7ZTuIQGJ?=
 =?us-ascii?Q?VNgwwUGNy5VGtncfOdSA1L2Bz4P8L4g6XXSg6hR1wJ2cAyHZPitYQTZ7Gu62?=
 =?us-ascii?Q?hjaaoYtx499LAGytwun46kWXb/OKdgbjpmR1NGFmOqNZmQ+TYTf928w2XdYy?=
 =?us-ascii?Q?fHw2sB/+FWeKtKaNYn+1lSCayBWV0jGHeStFmz2atzw8sQ4U5k5sWnIueV2R?=
 =?us-ascii?Q?U2AFXZs+nUs1wreYaT6HmCViAHRjPwJWoz0w0bjcdgC3YOl9OrkmUQ0LdOf9?=
 =?us-ascii?Q?5cCXCVn+PFpwza/zgm5OWwRGhfMxCSggiHiAWK45ujB6ipwvDd6e74eYp6/F?=
 =?us-ascii?Q?J7n4CBDBzZQG2vkkOOa1i9dDfvwz3di6YcFzIWoiX/ia5qMXHARV1ztX41yS?=
 =?us-ascii?Q?CxUj1WOywaTYLtNFuSAYaOwEHuVV/aa9B+6fpRtsOdZwQlppOUzb954675/I?=
 =?us-ascii?Q?Bw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 898ddfae-7c12-49d6-f1ff-08dde96521ea
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 14:37:52.7723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Tz7BLyw7klvlsPZ+aBUK+Ca6hS6LXinzgz3UIghjMhXfdzHszEAqMvB9VIZqoBgFwV4C4WHBQ1OYB7dD8gA9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5106
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "BUG:KASAN:wild-memory-access_in_pmd_alloc_one_noprof" on:

commit: ccbd04de39826d130b67374e68599e128b53acab ("mm: Actually mark kernel page table pages")
https://git.kernel.org/cgit/linux/kernel/git/daveh/devel.git kpte

in testcase: boot

config: x86_64-randconfig-001-20250829
compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+-------------------------------------------------------------------------------+------------+------------+
|                                                                               | a2440f9328 | ccbd04de39 |
+-------------------------------------------------------------------------------+------------+------------+
| BUG:KASAN:wild-memory-access_in_pmd_alloc_one_noprof                          | 0          | 11         |
| Oops:general_protection_fault,probably_for_non-canonical_address#:#[##]KASAN  | 0          | 11         |
| KASAN:maybe_wild-memory-access_in_range[#-#]                                  | 0          | 11         |
| RIP:pmd_alloc_one_noprof                                                      | 0          | 11         |
| Kernel_panic-not_syncing:Fatal_exception                                      | 0          | 11         |
+-------------------------------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202509012256.9322539b-lkp@intel.com


[ 1.250500][ T0] BUG: KASAN: wild-memory-access in pmd_alloc_one_noprof+0x34/0x7f 
[    1.251149][    T0] Write of size 8 at addr fefefefefefefefe by task swapper/0
[    1.251674][    T0]
[    1.251837][    T0] CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 6.17.0-rc3-00002-gccbd04de3982 #1 PREEMPT  a53390bc94bb546224a464bcf114b97da0f198de
[    1.252806][    T0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[    1.253538][    T0] Call Trace:
[    1.253770][    T0]  <TASK>
[ 1.253980][ T0] dump_stack_lvl (lib/dump_stack.c:123) 
[ 1.254351][ T0] kasan_report (mm/kasan/report.c:597) 
[ 1.254674][ T0] ? pmd_alloc_one_noprof+0x34/0x7f 
[ 1.255130][ T0] kasan_check_range (mm/kasan/generic.c:183 mm/kasan/generic.c:189) 
[ 1.255486][ T0] pmd_alloc_one_noprof+0x34/0x7f 
[ 1.255930][ T0] __pud_alloc (mm/memory.c:6427) 
[ 1.256247][ T0] preallocate_vmalloc_pages (include/linux/mm.h:2838 arch/x86/mm/init_64.c:1336) 
[ 1.256651][ T0] mm_core_init (mm/mm_init.c:2776) 
[ 1.256981][ T0] start_kernel (init/main.c:959) 
[ 1.257311][ T0] x86_64_start_reservations (arch/x86/kernel/head64.c:175) 
[ 1.257701][ T0] x86_64_start_kernel (arch/x86/kernel/ebda.c:57) 
[ 1.258068][ T0] common_startup_64 (arch/x86/kernel/head_64.S:419) 
[    1.258426][    T0]  </TASK>
[    1.258641][    T0] ==================================================================
[    1.259211][    T0] Disabling lock debugging due to kernel taint
[    1.259661][    T0] Oops: general protection fault, probably for non-canonical address 0xfefefefefefefefe: 0000 [#1] KASAN
[    1.260447][    T0] KASAN: maybe wild-memory-access in range [0xf7f817f7f7f7f7f0-0xf7f817f7f7f7f7f7]
[    1.261096][    T0] CPU: 0 UID: 0 PID: 0 Comm: swapper Tainted: G    B               6.17.0-rc3-00002-gccbd04de3982 #1 PREEMPT  a53390bc94bb546224a464bcf114b97da0f198de
[    1.262163][    T0] Tainted: [B]=BAD_PAGE
[    1.262457][    T0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 1.263181][ T0] RIP: pmd_alloc_one_noprof+0x34/0x7f 
[ 1.263671][ T0] Code: e8 eb 5f d1 ff 48 81 fd 00 11 6e b1 75 24 48 bb fe fe fe fe fe fe fe fe e8 d3 5f d1 ff be 08 00 00 00 48 89 df e8 91 7d 0a 00 <80> 0b 04 bb c0 0d 00 00 e8 b9 5f d1 ff 89 df 31 c9 31 d2 81 cf 00
All code
========
   0:	e8 eb 5f d1 ff       	call   0xffffffffffd15ff0
   5:	48 81 fd 00 11 6e b1 	cmp    $0xffffffffb16e1100,%rbp
   c:	75 24                	jne    0x32
   e:	48 bb fe fe fe fe fe 	movabs $0xfefefefefefefefe,%rbx
  15:	fe fe fe 
  18:	e8 d3 5f d1 ff       	call   0xffffffffffd15ff0
  1d:	be 08 00 00 00       	mov    $0x8,%esi
  22:	48 89 df             	mov    %rbx,%rdi
  25:	e8 91 7d 0a 00       	call   0xa7dbb
  2a:*	80 0b 04             	orb    $0x4,(%rbx)		<-- trapping instruction
  2d:	bb c0 0d 00 00       	mov    $0xdc0,%ebx
  32:	e8 b9 5f d1 ff       	call   0xffffffffffd15ff0
  37:	89 df                	mov    %ebx,%edi
  39:	31 c9                	xor    %ecx,%ecx
  3b:	31 d2                	xor    %edx,%edx
  3d:	81                   	.byte 0x81
  3e:	cf                   	iret
	...

Code starting with the faulting instruction
===========================================
   0:	80 0b 04             	orb    $0x4,(%rbx)
   3:	bb c0 0d 00 00       	mov    $0xdc0,%ebx
   8:	e8 b9 5f d1 ff       	call   0xffffffffffd15fc6
   d:	89 df                	mov    %ebx,%edi
   f:	31 c9                	xor    %ecx,%ecx
  11:	31 d2                	xor    %edx,%edx
  13:	81                   	.byte 0x81
  14:	cf                   	iret
	...
[    1.265038][    T0] RSP: 0000:ffffffffb0e07e68 EFLAGS: 00010046
[    1.265467][    T0] RAX: 0000000000000000 RBX: fefefefefefefefe RCX: ffffffffab0f6f61
[    1.266023][    T0] RDX: 0000000000000000 RSI: ffffffffb0e42740 RDI: 0000000000000002
[    1.266586][    T0] RBP: ffffffffb16e1100 R08: 0000000000000000 R09: 0000000000000000
[    1.267144][    T0] R10: 0000000000000007 R11: ffffffffb0e42740 R12: dffffc0000000000
[    1.267700][    T0] R13: fffffbfff6163097 R14: ffffffffb16e1100 R15: 0000000000000000
[    1.268258][    T0] FS:  0000000000000000(0000) GS:0000000000000000(0000) knlGS:0000000000000000
[    1.268884][    T0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.269347][    T0] CR2: ffff88843ffff000 CR3: 0000000098328000 CR4: 00000000000000b0
[    1.269906][    T0] Call Trace:
[    1.270134][    T0]  <TASK>
[ 1.270350][ T0] __pud_alloc (mm/memory.c:6427) 
[ 1.270668][ T0] preallocate_vmalloc_pages (include/linux/mm.h:2838 arch/x86/mm/init_64.c:1336) 
[ 1.271068][ T0] mm_core_init (mm/mm_init.c:2776) 
[ 1.271396][ T0] start_kernel (init/main.c:959) 
[ 1.271723][ T0] x86_64_start_reservations (arch/x86/kernel/head64.c:175) 
[ 1.272112][ T0] x86_64_start_kernel (arch/x86/kernel/ebda.c:57) 
[ 1.272476][ T0] common_startup_64 (arch/x86/kernel/head_64.S:419) 
[    1.272824][    T0]  </TASK>
[    1.273034][    T0] Modules linked in:
[    1.273309][    T0] ---[ end trace 0000000000000000 ]---
[ 1.273688][ T0] RIP: pmd_alloc_one_noprof+0x34/0x7f 
[ 1.274194][ T0] Code: e8 eb 5f d1 ff 48 81 fd 00 11 6e b1 75 24 48 bb fe fe fe fe fe fe fe fe e8 d3 5f d1 ff be 08 00 00 00 48 89 df e8 91 7d 0a 00 <80> 0b 04 bb c0 0d 00 00 e8 b9 5f d1 ff 89 df 31 c9 31 d2 81 cf 00
All code
========
   0:	e8 eb 5f d1 ff       	call   0xffffffffffd15ff0
   5:	48 81 fd 00 11 6e b1 	cmp    $0xffffffffb16e1100,%rbp
   c:	75 24                	jne    0x32
   e:	48 bb fe fe fe fe fe 	movabs $0xfefefefefefefefe,%rbx
  15:	fe fe fe 
  18:	e8 d3 5f d1 ff       	call   0xffffffffffd15ff0
  1d:	be 08 00 00 00       	mov    $0x8,%esi
  22:	48 89 df             	mov    %rbx,%rdi
  25:	e8 91 7d 0a 00       	call   0xa7dbb
  2a:*	80 0b 04             	orb    $0x4,(%rbx)		<-- trapping instruction
  2d:	bb c0 0d 00 00       	mov    $0xdc0,%ebx
  32:	e8 b9 5f d1 ff       	call   0xffffffffffd15ff0
  37:	89 df                	mov    %ebx,%edi
  39:	31 c9                	xor    %ecx,%ecx
  3b:	31 d2                	xor    %edx,%edx
  3d:	81                   	.byte 0x81
  3e:	cf                   	iret
	...

Code starting with the faulting instruction
===========================================
   0:	80 0b 04             	orb    $0x4,(%rbx)
   3:	bb c0 0d 00 00       	mov    $0xdc0,%ebx
   8:	e8 b9 5f d1 ff       	call   0xffffffffffd15fc6
   d:	89 df                	mov    %ebx,%edi
   f:	31 c9                	xor    %ecx,%ecx
  11:	31 d2                	xor    %edx,%edx
  13:	81                   	.byte 0x81
  14:	cf                   	iret


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250901/202509012256.9322539b-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


