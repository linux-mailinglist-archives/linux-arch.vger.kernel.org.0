Return-Path: <linux-arch+bounces-15782-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 378BED19377
	for <lists+linux-arch@lfdr.de>; Tue, 13 Jan 2026 14:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 26F7B304A7D1
	for <lists+linux-arch@lfdr.de>; Tue, 13 Jan 2026 13:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40D73816F3;
	Tue, 13 Jan 2026 13:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BHlR4DN5"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A9B231829;
	Tue, 13 Jan 2026 13:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768312197; cv=fail; b=j89HZV9h/nofSEshbh2RUxg4IqEb6LAl2VZsufCORZBcgiY3bR9AZ71P3qsyC6DDkVfzVD6VSYE9hfHEx23GaanLsACtXoNfVSc02osrL43xlVkUchvhAO4f6sV7wGYluNLFQZs9YhUD+SWhJjTR+cGJUUL3XNudXEWkMOZA3E8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768312197; c=relaxed/simple;
	bh=0yq6Oink9IT0Y43hm5zleiJmATlX8dCRAOho+76P5Xc=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=a9HMoHEZEa8DuLi04R5JGzfiAitfHYzFMl1+3fQG6i3/sgt5DApxgK3MsgWZ8s6LVjoVXzSZ+wKfIqL+FchsWhZIWyEwai8EEVlDQsY0lI+KdlmSKJ2t24RQPemwemOCaaZmD98M7qYjgHk1kJqdnfG5G6KiGGZm8JTRN4qAWW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BHlR4DN5; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768312195; x=1799848195;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=0yq6Oink9IT0Y43hm5zleiJmATlX8dCRAOho+76P5Xc=;
  b=BHlR4DN5k1Ko+kNnTNcyQ1Dpk+lUa28Pzvc2ND5WkKS/RdXn6fRuoXuk
   U/exmcdRPPku+Zd970LP/a8LIGyozwYtb7+3EL4Rf9CsSC6FIcOfIf8+w
   jpfN9EtxeRnX6C3TD6flgCAxKKHfnVHP/caPhpN850RWuJm+d4xU6HDbD
   tC5xxjIKxN6E5QzG3+2oguQhvpGBaWvn7+VEGXy7wtTrCD7OGmeXHpuvW
   wKjUGgwHmFLTxwfZcPvRMRmWIwazsC7aXp5kU7RZ6Ywa4DMOh8bZz2RK6
   2TMR4G6XXBeMEI0mWH2zyaFQhiah51CJ3+xPIVxvlRSU5B0EAKWY1Rtr5
   g==;
X-CSE-ConnectionGUID: bFhE3maJSKiU4zCBdjen4Q==
X-CSE-MsgGUID: Lw6JzzddTW+k1NGSgFPglw==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="69517985"
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="69517985"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 05:49:54 -0800
X-CSE-ConnectionGUID: FK0soldJRUWEFeW6LHCmrQ==
X-CSE-MsgGUID: qFzEJW6JQhesiMnS4XNEfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="208549586"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 05:49:54 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 13 Jan 2026 05:49:53 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Tue, 13 Jan 2026 05:49:53 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.53) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 13 Jan 2026 05:49:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ozToAI9KpESc2p6cyVqpZ3W/Pug2IzdFWa6Db0eeh7igBXPTRXNGgSZxXLf1E9SPJ2vN9b2ZIRwUef5j7WTXmXzB63sFxH6TXQ6OVSWadlL3A8SOW4cYVOTbwckZzED4atv1qMJx/nxTdC+GjFJ5X4DZjhdqv8ELTNrNnyVsk8aAXUkRI+rVsLe8vGgqV5pfnpxtxjbcbn6MwQG6vI0Ver+AygxJySD5ofs+iR4Ci6SKiZiLjPrdGSUvkgpYNJQnY3pD3GBueOGANGHosEB9J3XGYKwV7AH6MyZjP6Nt5PMRG2UbNM8Ys8xdgbJyGtTUPllf11SpxpsKmjpd+IX+dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W4EphcIRbATMe9jZYPUjzSgUQfF8V67cLPxozsH6tk8=;
 b=yttdBCigfx7BJAnPm/6KXhB5lnmK7OWZ0+IqckVzso+KIOt/3Upz3auFuzRM8mHNSURQSiyVqN++TvRxpznWonGwc9iw2DeFzS1MRF762DqjQgctWQcjHIXbsvWC74FMRt1chd36NP7DbnVlcuVBPpO8R/+zOroGkWhepC6WbisEDLz7NTv1Mcv2GVqNRXloJkJh2CwjbC2slnTXAt2aBAzc/MlWSaQG2FVXyNIlfexGppoXibXnHUisSN5a5txzPTFX0WOnVazy1gkUAt9Tf4FhS9CkBHS5P9ka9nfHrT7BlOhGepwTWTzmxzcRHbEqCC4bIiEbrafCZaerp/Ue6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DS0PR11MB6541.namprd11.prod.outlook.com (2603:10b6:8:d3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 13 Jan
 2026 13:49:41 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9499.005; Tue, 13 Jan 2026
 13:49:41 +0000
Date: Tue, 13 Jan 2026 21:49:33 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Ard Biesheuvel <ardb@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-arch@vger.kernel.org>, <linux-input@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [ardb:x86-pie-v3+i386] [x86]  c25feb76bc:
 stress-ng.getrandom.ops_per_sec 19.2% regression
Message-ID: <202601132133.b925ffea-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: s-nail v14.9.25
X-ClientProxiedBy: SI2P153CA0023.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::6)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DS0PR11MB6541:EE_
X-MS-Office365-Filtering-Correlation-Id: c881e6ea-f55a-4cfc-49a2-08de52aa99b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?qmU7Az/lW3EluNPUGhy8+taJIiIUn2F5RGK+phqYDeDaaMKTEG0oCqj2Xv?=
 =?iso-8859-1?Q?fHkcjsdzzrv+utEDj9xu7B/nFktkMtMSU5uV+AivT0vGpfY4RlnIivwsCA?=
 =?iso-8859-1?Q?OPur4Mr8ogPQedQ0mVGBSZcem4sr1xbEesm1VzqkrHgiuZspFPc303euxO?=
 =?iso-8859-1?Q?jPuiHsdVJZyy9gJKeNbFSTKhr4CKdc+kPDzFh2V059omOcYhALsbBHGKfW?=
 =?iso-8859-1?Q?trs+kbubWrHiR72xH5SMnyC6Sd5ALPfpyo3vNCbuVSnm+1OGep7IO/i49C?=
 =?iso-8859-1?Q?S4IoVbpD68ppF85581RJREJHvIAAKK235oCDpCmdMhnsvqpLSwkaj1IrYH?=
 =?iso-8859-1?Q?9RATpJPHiuXjRaZ0sHqsY9nsj+CRUf8wU/bzR1CKCVocZnQYJGV8v8EDNZ?=
 =?iso-8859-1?Q?D3tcdfu6oGoRDmkcMxT7KvdPhGWed2ZrjIVZnEelFlEOF/VYCNLWR6ZXk6?=
 =?iso-8859-1?Q?2OcSuLQhyFqgpOC1O6XUJTraaA2vSUazqs8+AVBjaSIi5S1D6LWwNrIiSC?=
 =?iso-8859-1?Q?a8viy5dEuLtQC0VVf3U77pKsjo7CX808s0240S3/INXodry2LMWbxG5E5L?=
 =?iso-8859-1?Q?UBMGEepqrCtHCraRbspwSlKpHbN+auCLaZNT8NtwjQje/v/Nl072OmRtmp?=
 =?iso-8859-1?Q?E/XYAF9LwpS9/6sznvUe/2NPWiAtHjWY9MMoMz7OcNTeeI8pnR+KKPhiNd?=
 =?iso-8859-1?Q?tC/iN1F1V0GMzW8QyEZKvdrDrwU+IXMab+Dp6i2hXksV5LEPH3bm79WY7M?=
 =?iso-8859-1?Q?R3IGZQz93C0f2WuflE4emAdlfC0zPHpi3DkMoCugkrBOmW+RI7Vtq3V0b0?=
 =?iso-8859-1?Q?FD9yV6Axbsmtx2oz4zdZfxLHte89+B4XwKa+1yVtGzIdsfpd4l/Jt3up/7?=
 =?iso-8859-1?Q?QKPmtcU/3fU7y8PWToPoPg5TON+NiUvWt9nk215qyHTz5nqIVuIo2gWa6Z?=
 =?iso-8859-1?Q?Hf+AnIgT6UJbG0q7Xg4T1PZvsqxPTJmLMMmLNz6XFqsWtzHuXDglXlSaOz?=
 =?iso-8859-1?Q?8JyP2XJ/qRzxlduzclz7E4R2eh2nxUvhCH/u/42viXWoCoURqudsLafPZv?=
 =?iso-8859-1?Q?Bvf4r/+keeJigf0+2tdP4K4VA7IKpZv3iUFOSSL2OhwSuEDsPDDugW7sNX?=
 =?iso-8859-1?Q?sbrxRDsMkNChmFF8i/upcbgjCP1TMAcxhWCZGgF7or+9N1kZgMxzm2wIyK?=
 =?iso-8859-1?Q?geOQntK9fZP29kSnteOXFc3cUe+jJbfkH3EArCVCdQyMG6tf6wcOEtlTL2?=
 =?iso-8859-1?Q?LaHXpRovk7+S6V19IiXguDti/Dods61TBUbno1chVFNuJh+LRB/Nei1ooo?=
 =?iso-8859-1?Q?OrL6P31YjniwochzVox38qhhUFtbCOp7nf7xd7BWmmMtVluPdL1/xRqNaC?=
 =?iso-8859-1?Q?81oN/NDOywzNH8THyJ45w0x0BYcGwUsOJjWhX55Txj5pxlB9EJUTkkiVRm?=
 =?iso-8859-1?Q?p6DJcgqJd0rIwLz4VB+Pl8S7vyNbEhLqNQHzcEP9zS/SAuUgZ4a1zRJahH?=
 =?iso-8859-1?Q?41euxfjrdOOYUIX5tCxGVcnhy0XH7z4v4qeG/GTqO9oA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?PYlu/0zr3pHvvs80bXQRkYouthTuruTIXv8DNBivRHlugFOZ+pGviXO7Uc?=
 =?iso-8859-1?Q?a0HQg4rmuCdpJ99Lrnjy/Qfwlc0gz6SN0HcfJhRrrqOKRsAO23FqL2l3GK?=
 =?iso-8859-1?Q?WI4m3bGNQke2BabISFJf09CRfHjUAOHbMlhfZD//YqWJ3dr1eDpuxUX2CR?=
 =?iso-8859-1?Q?iSWNm9XWHRBS1+43HyL9udDVhpkFWunnRMvp5wXJfKZc2ulnj3AFxT3l22?=
 =?iso-8859-1?Q?E9qEOqXsjphu4AkelxqBGLakKs81Z2aJpB44aX/OTlpZIkdbnyxEDjMcFp?=
 =?iso-8859-1?Q?9HjbtCnUUSwpFfNrsj17W0FdBdg517RiPg6qXHrMx/YvHiE582tEIsKtb2?=
 =?iso-8859-1?Q?Cb/+ugZ10SK9nKXiR2B80/loFr+ewsNEftlVPBkokhIQJrii9XevBu48gv?=
 =?iso-8859-1?Q?N4LMJ1p1p59AhbwW2GpY5XbWOdTyRcDaKPGIKoSL8Q2m+oryNpUDot9JdE?=
 =?iso-8859-1?Q?OLfL6zSFNhK7LnZjcO4zUoifkTb1jsdWfq2zqqAV8VgbmrI5ewNwaxC7TY?=
 =?iso-8859-1?Q?SgOSkyAasvoT7C4An1xjI6tfF78xhjr+HBQXO/AMIoyPGiOnDhvv4GSEZB?=
 =?iso-8859-1?Q?3O/UKPEdEkR8rHZrv/tQgh1/rT5KykJG+Tm9ciK3cJnWWC/GdqJ+pAxoCk?=
 =?iso-8859-1?Q?pyFfaf9mjGTXYEI6d3YA/0cV8/z+BfoWmv6/uY4/n2jx6AzMBas4rhR+HI?=
 =?iso-8859-1?Q?jN3SHbXGFTT1zEGpvTu4cM1yQ/2RBUoB/xNCMiPEEb5JR2FC4ZwXhv8WQz?=
 =?iso-8859-1?Q?fTGCrCHEH29lv6Yaxpo5/441sczxD5rgopv2uz5Mci1LhvcuFcExQBWpLL?=
 =?iso-8859-1?Q?FxyHaoWG7qWYy+c2P958yaAxXpyfb+xBbi/+PwcJnJJ3B+ciIgFGp6pXw2?=
 =?iso-8859-1?Q?ivIhJKvl1Cf1P6eP7oV/UGvvTyiID4k+kFkyn4NeEFrEytzaPJoTA5Jrle?=
 =?iso-8859-1?Q?S0hB1zBDv02D2t3utvFgbECUnRkwpsBrRzc6qjV7xI1ncibCBsoujK4MYW?=
 =?iso-8859-1?Q?Dho1xvnN7kCxFTWpIWju+lTN9ba66YFjtYI/yewH2sgrQPgZG6cmvM+6k8?=
 =?iso-8859-1?Q?/3HAPIQopW7RbCfsXJQeCJcOdWJx8ty30w1bMOcYL+Rug81ATBkJ1R7qLb?=
 =?iso-8859-1?Q?Mcilr49YNNfIu9hFD8yzAp6yjREc06H/SHRlzUACj88UAacDRcFPaXPraT?=
 =?iso-8859-1?Q?fFkg7Ob0o2AB97q9+hlWRBV09hnYsFo63x8ffsCC9YJljjdqi1d36XkTBQ?=
 =?iso-8859-1?Q?stTmLBQPv3WDBCjJUeziGuHShq5/CXkMT+Tg14btsS1vb0hU/Df7Vt8Wxx?=
 =?iso-8859-1?Q?BNyPxOTVChPGNfcDIfkfi96Obm8LkiJYd3nM9ARAgz6Uw7z4hMPqTQgAVf?=
 =?iso-8859-1?Q?7ijU7/0VAFIrkB4jdQHQpHdkOLYG4MJ1JvwSgecXQwfiKcfVfI4MvVgEd/?=
 =?iso-8859-1?Q?NiYUx01rE6GB/mutDqbHQbw0nJgKELboAB3CL4Hc4UKGP/VlITY6LW8S7K?=
 =?iso-8859-1?Q?2vZQolk9TAD3T0yG80sLUOpQR3JL9sOUy8sTXJxQr+UFIkZcUGe3b3OuKP?=
 =?iso-8859-1?Q?zQshNoo+bd6oBmem4mvTMrW/yEjwlHB+Y0Z8uOGkvpqFIzNYxGY+wNwxlq?=
 =?iso-8859-1?Q?W5tmT1jeTk6IcvBcaf0HSfjjRw/vqRm8QDGhLAKAWvDZfcpOjk7YNyXKi8?=
 =?iso-8859-1?Q?PC/4dTC5FsKlU0t4ybls3sHkMBsc2JILk++ATtVha1hw65KPJ4xko7/KOp?=
 =?iso-8859-1?Q?aA6B/DqKlYYxW8QVBUV9jJiF2bNLEfZY7fqaCB8VNz0ausEpXN+ajWEvXj?=
 =?iso-8859-1?Q?6vw1pi2ERw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c881e6ea-f55a-4cfc-49a2-08de52aa99b7
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 13:49:41.5858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mj1ny7gIRG5Reisy5y0y7h2iF93pXiik8NYZp/dn8LXDa5g9tUya8KgiTnVqSv9+VhpKO+I87rtGP7I78bGl8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6541
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 19.2% regression of stress-ng.getrandom.ops_per_sec on:


commit: c25feb76bcb9eef1db49b4793195808b5b268bdd ("x86: Use PIE codegen for the relocatable 64-bit kernel")
https://git.kernel.org/cgit/linux/kernel/git/ardb/linux.git x86-pie-v3+i386

testcase: stress-ng
config: x86_64-rhel-9.4
compiler: gcc-14
test machine: 256 threads 2 sockets Intel(R) Xeon(R) 6768P  CPU @ 2.4GHz (Granite Rapids) with 64G memory
parameters:

	nr_threads: 100%
	testtime: 60s
	test: getrandom
	cpufreq_governor: performance


In addition to that, the commit also has significant impact on the following tests:

+------------------+---------------------------------------------------------------------------------------------+
| testcase: change | stress-ng: stress-ng.shm-sysv.ops_per_sec  7.0% regression                                  |
| test machine     | 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 256G memory |
| test parameters  | cpufreq_governor=performance                                                                |
|                  | nr_threads=100%                                                                             |
|                  | test=shm-sysv                                                                               |
|                  | testtime=60s                                                                                |
+------------------+---------------------------------------------------------------------------------------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202601132133.b925ffea-lkp@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260113/202601132133.b925ffea-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-14/performance/x86_64-rhel-9.4/100%/debian-13-x86_64-20250902.cgz/lkp-gnr-2sp4/getrandom/stress-ng/60s

commit: 
  34e6669c5d ("tools/objtool: Treat indirect ftrace calls as direct calls")
  c25feb76bc ("x86: Use PIE codegen for the relocatable 64-bit kernel")

34e6669c5d74fc8a c25feb76bcb9eef1db49b479319 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    141205 ± 18%    +121.9%     313389 ± 28%  numa-meminfo.node1.Mapped
    765384 ± 12%     +20.2%     920026 ±  8%  numa-numastat.node1.local_node
     25.36 ± 15%     +43.5%      36.40 ± 23%  sched_debug.cpu.clock.stddev
      1.98         +4655.9%      94.11        vmstat.cpu.sy
     93.03           -99.0%       0.97        vmstat.cpu.us
      0.36            +0.3        0.68 ±  4%  mpstat.cpu.all.irq%
      1.69           +94.9       96.61        mpstat.cpu.all.sys%
     96.01           -95.1        0.89 ±  2%  mpstat.cpu.all.usr%
   1360746 ±  3%     +19.9%    1632180        meminfo.Active
   1359818 ±  3%     +20.0%    1632180        meminfo.Active(anon)
    216996 ± 12%     +87.5%     406839 ± 12%  meminfo.Mapped
    630155 ±  7%     +43.2%     902385 ±  2%  meminfo.Shmem
    117.20          -100.0%       0.00        numa-vmstat.node0.nr_active_file
    117.20          -100.0%       0.00        numa-vmstat.node0.nr_zone_active_file
    114.95          -100.0%       0.00        numa-vmstat.node1.nr_active_file
     35366 ± 18%    +120.8%      78073 ± 29%  numa-vmstat.node1.nr_mapped
    114.95          -100.0%       0.00        numa-vmstat.node1.nr_zone_active_file
    765204 ± 12%     +20.2%     919955 ±  8%  numa-vmstat.node1.numa_local
 3.647e+09           -19.1%  2.952e+09        stress-ng.getrandom.getrandom_bits_per_sec
 8.553e+08           -19.2%  6.911e+08        stress-ng.getrandom.ops
  14264185           -19.2%   11525185        stress-ng.getrandom.ops_per_sec
     22088            -6.9%      20574        stress-ng.time.minor_page_faults
    256.84         +5775.5%      15090        stress-ng.time.system_time
     14971           -99.4%      93.58        stress-ng.time.user_time
      3600            -1.6%       3544        turbostat.Bzy_MHz
     60.00 ± 13%     +17.8%      70.67        turbostat.CoreTmp
      1.19          +110.9%       2.51        turbostat.IPC
     61.17 ± 11%     +15.0%      70.33        turbostat.PkgTmp
    504.27 ± 21%     +28.8%     649.34        turbostat.PkgWatt
      4.92            +4.2%       5.13        turbostat.RAMWatt
    794.46 ± 16%     +21.8%     967.76        turbostat.SysWatt
    340316 ±  3%     +19.9%     408200        proc-vmstat.nr_active_anon
    232.13          -100.0%       0.00        proc-vmstat.nr_active_file
   1083392            +6.3%    1151244        proc-vmstat.nr_file_pages
     54340 ± 12%     +87.3%     101773 ± 12%  proc-vmstat.nr_mapped
      8803 ±  2%      +7.9%       9502 ±  2%  proc-vmstat.nr_page_table_pages
    157880 ±  7%     +43.0%     225732 ±  2%  proc-vmstat.nr_shmem
    340316 ±  3%     +19.9%     408200        proc-vmstat.nr_zone_active_anon
    232.13          -100.0%       0.00        proc-vmstat.nr_zone_active_file
   1389528 ±  3%     +13.6%    1579043        proc-vmstat.numa_hit
   1125848 ±  4%     +16.8%    1315429        proc-vmstat.numa_local
   1455570 ±  3%     +13.7%    1654428        proc-vmstat.pgalloc_normal
 1.936e+10 ± 44%    +254.9%   6.87e+10        perf-stat.i.branch-instructions
  27271249 ± 44%     +23.4%   33659627        perf-stat.i.branch-misses
     13.50 ± 44%      +7.4       20.92 ±  5%  perf-stat.i.cache-miss-rate%
   2495358 ± 45%     +62.1%    4044168 ±  4%  perf-stat.i.cache-misses
 9.015e+11 ± 44%    +148.9%  2.244e+12        perf-stat.i.instructions
      0.99 ± 44%    +152.8%       2.51        perf-stat.i.ipc
      7641 ± 44%     +25.9%       9618        perf-stat.i.minor-faults
      7641 ± 44%     +25.9%       9619        perf-stat.i.page-faults
     10.72 ± 45%      +9.9       20.60 ±  6%  perf-stat.overall.cache-miss-rate%
      0.99 ± 44%    +152.6%       2.51        perf-stat.overall.ipc
 1.904e+10 ± 44%    +254.6%  6.753e+10        perf-stat.ps.branch-instructions
  26960548 ± 44%     +24.2%   33492680        perf-stat.ps.branch-misses
   2478150 ± 45%     +59.6%    3956015 ±  4%  perf-stat.ps.cache-misses
 8.868e+11 ± 44%    +148.7%  2.205e+12        perf-stat.ps.instructions
 5.433e+13 ± 44%    +146.2%  1.338e+14        perf-stat.total.instructions
      0.66 ±223%      +9.5       10.14        perf-profile.calltrace.cycles-pp._copy_to_iter.get_random_bytes_user.__x64_sys_getrandom.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00           +75.7       75.72        perf-profile.calltrace.cycles-pp.chacha_permute.chacha_block_generic.get_random_bytes_user.__x64_sys_getrandom.do_syscall_64
      0.00           +85.0       84.99        perf-profile.calltrace.cycles-pp.chacha_block_generic.get_random_bytes_user.__x64_sys_getrandom.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00           +96.6       96.64        perf-profile.calltrace.cycles-pp.get_random_bytes_user.__x64_sys_getrandom.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00           +97.2       97.20        perf-profile.calltrace.cycles-pp.__x64_sys_getrandom.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00           +97.4       97.40        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00           +97.4       97.44        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.00            +0.1        0.08        perf-profile.children.cycles-pp.__x64_sys_clock_gettime
      0.01 ±223%      +0.2        0.22 ±  2%  perf-profile.children.cycles-pp.clock_gettime
      0.68 ±223%      +9.7       10.36        perf-profile.children.cycles-pp._copy_to_iter
      5.00 ±223%     +72.3       77.26        perf-profile.children.cycles-pp.chacha_permute
      5.70 ±223%     +81.2       86.86        perf-profile.children.cycles-pp.chacha_block_generic
      9.37 ±223%     +89.7       99.03        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      9.18 ±223%     +89.8       98.96        perf-profile.children.cycles-pp.do_syscall_64
      8.05 ±223%     +90.2       98.28        perf-profile.children.cycles-pp.__x64_sys_getrandom
      7.80 ±223%     +90.4       98.19        perf-profile.children.cycles-pp.get_random_bytes_user
      0.02 ±223%      +0.1        0.12        perf-profile.self.cycles-pp.perf_mmap__read_head
      0.68 ±223%      +8.8        9.46        perf-profile.self.cycles-pp.chacha_block_generic
      0.66 ±223%      +9.4       10.02        perf-profile.self.cycles-pp._copy_to_iter
      4.99 ±223%     +71.6       76.60        perf-profile.self.cycles-pp.chacha_permute


***************************************************************************************************
lkp-spr-r02: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 256G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-14/performance/x86_64-rhel-9.4/100%/debian-13-x86_64-20250902.cgz/lkp-spr-r02/shm-sysv/stress-ng/60s

commit: 
  34e6669c5d ("tools/objtool: Treat indirect ftrace calls as direct calls")
  c25feb76bc ("x86: Use PIE codegen for the relocatable 64-bit kernel")

34e6669c5d74fc8a c25feb76bcb9eef1db49b479319 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    499796 ± 23%     +33.9%     669008 ± 24%  numa-meminfo.node0.AnonPages
     55471 ± 79%    +104.3%     113310 ± 40%  numa-numastat.node1.other_node
     19.54            +4.3       23.85        mpstat.cpu.all.sys%
     23.08           +20.0%      27.70        mpstat.max_utilization_pct
    124946 ± 23%     +33.9%     167294 ± 24%  numa-vmstat.node0.nr_anon_pages
     55471 ± 79%    +104.3%     113310 ± 40%  numa-vmstat.node1.numa_other
     18.25 ±  7%     +36.2%      24.85 ± 22%  perf-sched.sch_delay.max.ms.[unknown].[unknown].[unknown].[unknown].[unknown]
     18.25 ±  7%     +36.2%      24.85 ± 22%  perf-sched.total_sch_delay.max.ms
    364644            -7.9%     335945        vmstat.system.cs
    315205            +2.3%     322604        vmstat.system.in
      5776 ±  3%     -14.4%       4945 ±  3%  perf-c2c.DRAM.local
     10075           -12.2%       8845        perf-c2c.DRAM.remote
      7204           -12.3%       6320        perf-c2c.HITM.remote
     18556           -10.0%      16695        perf-c2c.HITM.total
     14630           +33.8%      19571        sched_debug.cfs_rq:/.avg_vruntime.avg
      7398 ±  9%     +60.0%      11839 ±  7%  sched_debug.cfs_rq:/.avg_vruntime.min
    174.02 ±  4%     +13.5%     197.54 ±  4%  sched_debug.cfs_rq:/.runnable_avg.avg
    173.82 ±  4%     +13.5%     197.28 ±  4%  sched_debug.cfs_rq:/.util_avg.avg
     21.82 ± 16%     +33.9%      29.21 ± 18%  sched_debug.cfs_rq:/.util_est.avg
     78.04 ±  8%     +11.4%      86.91 ±  4%  sched_debug.cfs_rq:/.util_est.stddev
     14610           +33.8%      19544        sched_debug.cfs_rq:/.zero_vruntime.avg
      7398 ±  9%     +59.9%      11829 ±  7%  sched_debug.cfs_rq:/.zero_vruntime.min
      3141           -13.4%       2720 ±  2%  sched_debug.cpu.nr_switches.stddev
    636.20           +21.1%     770.33        turbostat.Avg_MHz
     21.99            +4.6       26.61        turbostat.Busy%
     65.16            -3.2       61.92        turbostat.C1E%
     12.48            -1.4       11.06        turbostat.C6%
     60.39           -10.0%      54.35        turbostat.CPU%c1
      0.38           -11.8%       0.34        turbostat.IPC
   2143617           +12.0%    2400504        turbostat.NMI
    433.52            +2.5%     444.32        turbostat.PkgWatt
     24.67            -2.2%      24.11        turbostat.RAMWatt
    548105            -1.2%     541578        proc-vmstat.nr_active_anon
     94151            +1.6%      95647        proc-vmstat.nr_mapped
     24345 ±  3%      -6.7%      22703 ±  3%  proc-vmstat.nr_page_table_pages
    219544            -2.2%     214606        proc-vmstat.nr_shmem
    548105            -1.2%     541578        proc-vmstat.nr_zone_active_anon
  37786403            -8.1%   34715344        proc-vmstat.numa_hit
  37553119            -8.2%   34480850        proc-vmstat.numa_local
  39821469            -8.1%   36607213        proc-vmstat.pgalloc_normal
  54193632 ±  2%      -5.2%   51380280 ±  2%  proc-vmstat.pgfault
  38799735            -8.3%   35597616        proc-vmstat.pgfree
   5331325            -6.9%    4963469        proc-vmstat.unevictable_pgs_scanned
    199852           +26.7%     253131        stress-ng.shm-sysv.nanosecs_per_shmat_call
    351330           +28.3%     450754        stress-ng.shm-sysv.nanosecs_per_shmdt_call
    182368           +28.1%     233637        stress-ng.shm-sysv.nanosecs_per_shmget_call
    796981            -7.0%     741169        stress-ng.shm-sysv.ops
     13290            -7.0%      12360        stress-ng.shm-sysv.ops_per_sec
     66452            -2.8%      64601        stress-ng.time.involuntary_context_switches
  53480084 ±  2%      -5.3%   50668106 ±  2%  stress-ng.time.minor_page_faults
      4602           +23.3%       5676        stress-ng.time.percent_of_cpu_this_job_got
      2547           +26.1%       3211        stress-ng.time.system_time
    217.53            -8.5%     199.05        stress-ng.time.user_time
  10869031            -7.8%   10016582        stress-ng.time.voluntary_context_switches
      3.02           -13.9%       2.60        perf-stat.i.MPKI
 1.102e+10            +7.4%  1.183e+10        perf-stat.i.branch-instructions
      0.75            -0.1        0.69        perf-stat.i.branch-miss-rate%
  80729871            -1.4%   79583495        perf-stat.i.branch-misses
     31.78            -1.1       30.72        perf-stat.i.cache-miss-rate%
 1.685e+08            -7.9%  1.551e+08        perf-stat.i.cache-misses
 5.318e+08            -4.6%  5.072e+08        perf-stat.i.cache-references
    376543            -7.9%     346811        perf-stat.i.context-switches
      2.58           +12.8%       2.90        perf-stat.i.cpi
 1.443e+11           +21.1%  1.748e+11        perf-stat.i.cpu-cycles
     18797           +15.3%      21669        perf-stat.i.cpu-migrations
    856.11           +31.5%       1125        perf-stat.i.cycles-between-cache-misses
 5.584e+10            +7.2%  5.988e+10        perf-stat.i.instructions
      0.39           -11.2%       0.35        perf-stat.i.ipc
      9.62            -5.8%       9.06 ±  2%  perf-stat.i.metric.K/sec
    876497 ±  2%      -5.3%     829909 ±  2%  perf-stat.i.minor-faults
    902246 ±  2%      -5.4%     853818 ±  2%  perf-stat.i.page-faults
      3.02           -14.2%       2.59        perf-stat.overall.MPKI
      0.73            -0.1        0.67        perf-stat.overall.branch-miss-rate%
     31.68            -1.1       30.57        perf-stat.overall.cache-miss-rate%
      2.58           +12.9%       2.92        perf-stat.overall.cpi
    856.97           +31.6%       1127        perf-stat.overall.cycles-between-cache-misses
      0.39           -11.5%       0.34        perf-stat.overall.ipc
 1.084e+10            +7.4%  1.164e+10        perf-stat.ps.branch-instructions
  79335480            -1.4%   78206975        perf-stat.ps.branch-misses
 1.657e+08            -8.0%  1.525e+08        perf-stat.ps.cache-misses
  5.23e+08            -4.6%  4.988e+08        perf-stat.ps.cache-references
    370379            -7.9%     341116        perf-stat.ps.context-switches
 1.419e+11           +21.1%  1.719e+11        perf-stat.ps.cpu-cycles
     18488           +15.3%      21312        perf-stat.ps.cpu-migrations
 5.492e+10            +7.2%   5.89e+10        perf-stat.ps.instructions
    862011 ±  2%      -5.3%     816105 ±  2%  perf-stat.ps.minor-faults
    887340 ±  2%      -5.4%     839624 ±  2%  perf-stat.ps.page-faults
  3.34e+12            +7.3%  3.584e+12        perf-stat.total.instructions
      8.47            -1.9        6.59        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
      8.46            -1.9        6.58        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
     30.66            -1.8       28.89        perf-profile.calltrace.cycles-pp.osq_lock.rwsem_down_write_slowpath.down_write.ipcget.__x64_sys_shmget
      7.71            -1.7        6.01        perf-profile.calltrace.cycles-pp.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call.do_syscall_64
      7.71            -1.7        6.01        perf-profile.calltrace.cycles-pp.__x64_sys_exit_group.x64_sys_call.do_syscall_64.entry_SYSCALL_64_after_hwframe
      7.71            -1.7        6.01        perf-profile.calltrace.cycles-pp.do_group_exit.__x64_sys_exit_group.x64_sys_call.do_syscall_64.entry_SYSCALL_64_after_hwframe
      7.71            -1.7        6.02        perf-profile.calltrace.cycles-pp.x64_sys_call.do_syscall_64.entry_SYSCALL_64_after_hwframe
      7.46            -1.6        5.82        perf-profile.calltrace.cycles-pp.exit_mm.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
      7.46            -1.6        5.81        perf-profile.calltrace.cycles-pp.__mmput.exit_mm.do_exit.do_group_exit.__x64_sys_exit_group
      7.44            -1.6        5.80 ±  2%  perf-profile.calltrace.cycles-pp.exit_mmap.__mmput.exit_mm.do_exit.do_group_exit
     11.73            -1.6       10.17 ±  2%  perf-profile.calltrace.cycles-pp._Fork
     34.38            -1.5       32.84        perf-profile.calltrace.cycles-pp.shmget
     34.34            -1.5       32.80        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.shmget
     34.33            -1.5       32.80        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.shmget
     34.30            -1.5       32.77        perf-profile.calltrace.cycles-pp.ipcget.__x64_sys_shmget.do_syscall_64.entry_SYSCALL_64_after_hwframe.shmget
     34.31            -1.5       32.78        perf-profile.calltrace.cycles-pp.__x64_sys_shmget.do_syscall_64.entry_SYSCALL_64_after_hwframe.shmget
     11.37            -1.5        9.88 ±  2%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe._Fork
     11.37            -1.5        9.88 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe._Fork
     11.36            -1.5        9.88 ±  2%  perf-profile.calltrace.cycles-pp.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe._Fork
     11.36            -1.5        9.88 ±  2%  perf-profile.calltrace.cycles-pp.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe._Fork
     10.82            -1.4        9.45 ±  2%  perf-profile.calltrace.cycles-pp.copy_process.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe
     10.45            -1.3        9.16 ±  2%  perf-profile.calltrace.cycles-pp.dup_mm.copy_process.kernel_clone.__do_sys_clone.do_syscall_64
     32.73            -1.2       31.52        perf-profile.calltrace.cycles-pp.down_write.ipcget.__x64_sys_shmget.do_syscall_64.entry_SYSCALL_64_after_hwframe
     32.60            -1.2       31.41        perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.ipcget.__x64_sys_shmget.do_syscall_64
      5.21            -1.2        4.03        perf-profile.calltrace.cycles-pp.common_startup_64
      5.18            -1.2        4.01        perf-profile.calltrace.cycles-pp.start_secondary.common_startup_64
      5.18            -1.2        4.01        perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.common_startup_64
      5.18            -1.2        4.01        perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      9.62            -1.2        8.46 ±  2%  perf-profile.calltrace.cycles-pp.dup_mmap.dup_mm.copy_process.kernel_clone.__do_sys_clone
      4.42            -1.0        3.41        perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      4.24            -1.0        3.26        perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      4.14            -1.0        3.18        perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
      3.53            -0.8        2.75        perf-profile.calltrace.cycles-pp.free_pgtables.exit_mmap.__mmput.exit_mm.do_exit
      2.79            -0.6        2.18        perf-profile.calltrace.cycles-pp.unlink_anon_vmas.free_pgtables.exit_mmap.__mmput.exit_mm
      2.43 ±  3%      -0.5        1.88 ±  3%  perf-profile.calltrace.cycles-pp.unmap_vmas.exit_mmap.__mmput.exit_mm.do_exit
      2.35 ±  3%      -0.5        1.82 ±  3%  perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.exit_mmap.__mmput.exit_mm
      2.29 ±  3%      -0.5        1.78 ±  3%  perf-profile.calltrace.cycles-pp.zap_pmd_range.unmap_page_range.unmap_vmas.exit_mmap.__mmput
      2.03 ±  2%      -0.5        1.53        perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      2.23 ±  3%      -0.5        1.73 ±  3%  perf-profile.calltrace.cycles-pp.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas.exit_mmap
      1.93 ±  2%      -0.5        1.45        perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      3.93            -0.5        3.48 ±  2%  perf-profile.calltrace.cycles-pp.anon_vma_clone.anon_vma_fork.dup_mmap.dup_mm.copy_process
      9.37            -0.4        8.93        perf-profile.calltrace.cycles-pp.osq_lock.rwsem_down_write_slowpath.down_write.ksys_shmctl.do_syscall_64
      0.67 ±  2%      -0.4        0.25 ±100%  perf-profile.calltrace.cycles-pp.__vma_start_write.dup_mmap.dup_mm.copy_process.kernel_clone
      1.66            -0.4        1.26        perf-profile.calltrace.cycles-pp.anon_vma_interval_tree_insert.anon_vma_clone.anon_vma_fork.dup_mmap.dup_mm
      1.93            -0.4        1.55 ±  3%  perf-profile.calltrace.cycles-pp.ordered_events__queue.process_simple.reader__read_event.perf_session__process_events.record__finish_output
      1.94            -0.4        1.56 ±  3%  perf-profile.calltrace.cycles-pp.process_simple.reader__read_event.perf_session__process_events.record__finish_output.cmd_record
      1.93            -0.4        1.55 ±  3%  perf-profile.calltrace.cycles-pp.queue_event.ordered_events__queue.process_simple.reader__read_event.perf_session__process_events
      1.63 ±  4%      -0.4        1.26 ±  4%  perf-profile.calltrace.cycles-pp.zap_present_ptes.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas
      1.95            -0.4        1.60        perf-profile.calltrace.cycles-pp.reader__read_event.perf_session__process_events.record__finish_output.cmd_record
      1.95            -0.4        1.60        perf-profile.calltrace.cycles-pp.cmd_record
      1.95            -0.4        1.60        perf-profile.calltrace.cycles-pp.perf_session__process_events.record__finish_output.cmd_record
      1.95            -0.4        1.60        perf-profile.calltrace.cycles-pp.record__finish_output.cmd_record
      1.58 ±  5%      -0.3        1.24 ±  5%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault
      1.43 ±  3%      -0.3        1.09 ±  6%  perf-profile.calltrace.cycles-pp.copy_page_range.dup_mmap.dup_mm.copy_process.kernel_clone
      1.40 ±  3%      -0.3        1.07 ±  7%  perf-profile.calltrace.cycles-pp.copy_p4d_range.copy_page_range.dup_mmap.dup_mm.copy_process
      5.74            -0.3        5.42 ±  2%  perf-profile.calltrace.cycles-pp.anon_vma_fork.dup_mmap.dup_mm.copy_process.kernel_clone
      1.38 ±  5%      -0.3        1.09 ±  5%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault
      1.38 ±  5%      -0.3        1.08 ±  5%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.63 ±  2%      -0.3        0.35 ± 70%  perf-profile.calltrace.cycles-pp.down_write.unlink_anon_vmas.free_pgtables.exit_mmap.__mmput
     10.00            -0.3        9.71        perf-profile.calltrace.cycles-pp.down_write.ksys_shmctl.do_syscall_64.entry_SYSCALL_64_after_hwframe.shmctl
      1.23 ±  3%      -0.3        0.94 ±  7%  perf-profile.calltrace.cycles-pp.copy_pte_range.copy_p4d_range.copy_page_range.dup_mmap.dup_mm
      9.95            -0.3        9.68        perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.ksys_shmctl.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.10            -0.3        0.84 ±  2%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      1.08            -0.3        0.82 ±  2%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      1.19            -0.2        0.94        perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      1.15 ±  6%      -0.2        0.91 ±  6%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      1.11 ±  6%      -0.2        0.88 ±  6%  perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.88 ±  5%      -0.2        0.66 ±  9%  perf-profile.calltrace.cycles-pp.copy_present_ptes.copy_pte_range.copy_p4d_range.copy_page_range.dup_mmap
      0.98 ±  7%      -0.2        0.78 ±  5%  perf-profile.calltrace.cycles-pp.do_read_fault.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      0.99 ±  7%      -0.2        0.78 ±  5%  perf-profile.calltrace.cycles-pp.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
      0.94 ±  7%      -0.2        0.75 ±  5%  perf-profile.calltrace.cycles-pp.filemap_map_pages.do_read_fault.do_fault.__handle_mm_fault.handle_mm_fault
      0.80 ±  2%      -0.2        0.61 ±  2%  perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.75            -0.2        0.57        perf-profile.calltrace.cycles-pp.poll_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      0.70 ±  2%      -0.2        0.54 ±  2%  perf-profile.calltrace.cycles-pp.tick_nohz_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      0.88            -0.1        0.73        perf-profile.calltrace.cycles-pp.up_write.ipcget.__x64_sys_shmget.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.79 ±  5%      -0.1        0.65 ±  3%  perf-profile.calltrace.cycles-pp.tlb_finish_mmu.exit_mmap.__mmput.exit_mm.do_exit
      0.78 ±  5%      -0.1        0.64 ±  4%  perf-profile.calltrace.cycles-pp.__tlb_batch_free_encoded_pages.tlb_finish_mmu.exit_mmap.__mmput.exit_mm
      0.77 ±  5%      -0.1        0.64 ±  4%  perf-profile.calltrace.cycles-pp.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages.tlb_finish_mmu.exit_mmap.__mmput
      0.80            -0.1        0.66        perf-profile.calltrace.cycles-pp.rwsem_wake.up_write.ipcget.__x64_sys_shmget.do_syscall_64
      0.79            -0.1        0.68        perf-profile.calltrace.cycles-pp.mm_init.dup_mm.copy_process.kernel_clone.__do_sys_clone
      1.20 ±  2%      +0.2        1.37 ±  3%  perf-profile.calltrace.cycles-pp.down_write.anon_vma_clone.anon_vma_fork.dup_mmap.dup_mm
      0.51            +0.2        0.71        perf-profile.calltrace.cycles-pp.up_write.do_shmat.__x64_sys_shmat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.36 ±  2%      +0.2        1.57 ±  3%  perf-profile.calltrace.cycles-pp.down_write.anon_vma_fork.dup_mmap.dup_mm.copy_process
      1.30 ±  2%      +0.2        1.53 ±  3%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.anon_vma_fork.dup_mmap.dup_mm
      0.98 ±  2%      +0.2        1.21 ±  3%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.anon_vma_clone.anon_vma_fork.dup_mmap
      1.42            +0.3        1.68        perf-profile.calltrace.cycles-pp.do_mmap.do_shmat.__x64_sys_shmat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.98            +0.3        1.26        perf-profile.calltrace.cycles-pp.osq_lock.rwsem_down_write_slowpath.down_write.__shm_close.__mmap_region
      1.19            +0.3        1.48        perf-profile.calltrace.cycles-pp.__mmap_region.do_mmap.do_shmat.__x64_sys_shmat.do_syscall_64
      1.05            +0.3        1.34        perf-profile.calltrace.cycles-pp.__shm_close.__mmap_region.do_mmap.do_shmat.__x64_sys_shmat
      1.03            +0.3        1.33        perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.__shm_close.__mmap_region.do_mmap
      1.04            +0.3        1.34        perf-profile.calltrace.cycles-pp.down_write.__shm_close.__mmap_region.do_mmap.do_shmat
      0.70 ±  3%      +0.3        1.01 ±  4%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_down_write_slowpath.down_write.anon_vma_fork.dup_mmap
      0.00            +0.5        0.53        perf-profile.calltrace.cycles-pp.rwsem_wake.up_write.remove_vma.vms_complete_munmap_vmas.do_vmi_align_munmap
      0.00            +0.6        0.56        perf-profile.calltrace.cycles-pp.up_write.remove_vma.vms_complete_munmap_vmas.do_vmi_align_munmap.ksys_shmdt
      0.20 ±122%      +0.6        0.78 ±  3%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_down_write_slowpath.down_write.anon_vma_clone.anon_vma_fork
      0.00            +0.7        0.68        perf-profile.calltrace.cycles-pp.rwsem_wake.up_write.do_shmat.__x64_sys_shmat.do_syscall_64
      0.80            +0.8        1.57        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irq.rwsem_down_write_slowpath.down_write.ipcget
      0.84            +0.8        1.61        perf-profile.calltrace.cycles-pp._raw_spin_lock_irq.rwsem_down_write_slowpath.down_write.ipcget.__x64_sys_shmget
      1.41            +0.8        2.21        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irq.rwsem_down_write_slowpath.down_write.do_shmat
      1.44            +0.8        2.24        perf-profile.calltrace.cycles-pp._raw_spin_lock_irq.rwsem_down_write_slowpath.down_write.do_shmat.__x64_sys_shmat
      1.16            +1.1        2.28        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irq.rwsem_down_read_slowpath.down_read.ksys_shmctl
      1.34            +1.1        2.48        perf-profile.calltrace.cycles-pp.rwsem_down_read_slowpath.down_read.ksys_shmctl.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.17            +1.1        2.31        perf-profile.calltrace.cycles-pp._raw_spin_lock_irq.rwsem_down_read_slowpath.down_read.ksys_shmctl.do_syscall_64
      6.63            +1.1        7.78        perf-profile.calltrace.cycles-pp.osq_lock.rwsem_down_write_slowpath.down_write.__shm_close.remove_vma
      1.36            +1.2        2.52        perf-profile.calltrace.cycles-pp.down_read.ksys_shmctl.do_syscall_64.entry_SYSCALL_64_after_hwframe.shmctl
      8.30            +1.3        9.63        perf-profile.calltrace.cycles-pp.shmdt
      8.28            +1.3        9.61        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.shmdt
      8.28            +1.3        9.61        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.shmdt
      7.22            +1.3        8.56        perf-profile.calltrace.cycles-pp.__shm_close.remove_vma.vms_complete_munmap_vmas.do_vmi_align_munmap.ksys_shmdt
      7.15            +1.4        8.51        perf-profile.calltrace.cycles-pp.down_write.__shm_close.remove_vma.vms_complete_munmap_vmas.do_vmi_align_munmap
      7.11            +1.4        8.46        perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.__shm_close.remove_vma.vms_complete_munmap_vmas
      8.08            +1.4        9.47        perf-profile.calltrace.cycles-pp.ksys_shmdt.do_syscall_64.entry_SYSCALL_64_after_hwframe.shmdt
      7.88            +1.4        9.32        perf-profile.calltrace.cycles-pp.do_vmi_align_munmap.ksys_shmdt.do_syscall_64.entry_SYSCALL_64_after_hwframe.shmdt
      7.78            +1.5        9.24        perf-profile.calltrace.cycles-pp.vms_complete_munmap_vmas.do_vmi_align_munmap.ksys_shmdt.do_syscall_64.entry_SYSCALL_64_after_hwframe
      7.65            +1.5        9.14        perf-profile.calltrace.cycles-pp.remove_vma.vms_complete_munmap_vmas.do_vmi_align_munmap.ksys_shmdt.do_syscall_64
      6.98            +1.5        8.46        perf-profile.calltrace.cycles-pp.osq_lock.rwsem_down_write_slowpath.down_write.do_shmat.__x64_sys_shmat
      0.00            +2.1        2.09        perf-profile.calltrace.cycles-pp.__radix_tree_lookup.ksys_shmctl.do_syscall_64.entry_SYSCALL_64_after_hwframe.shmctl
      8.83            +2.2       11.04        perf-profile.calltrace.cycles-pp.down_write.do_shmat.__x64_sys_shmat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      8.78            +2.2       10.98        perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.do_shmat.__x64_sys_shmat.do_syscall_64
     13.37            +2.4       15.73        perf-profile.calltrace.cycles-pp.shmctl
     13.33            +2.4       15.70        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.shmctl
     13.32            +2.4       15.69        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.shmctl
     13.09            +2.4       15.50        perf-profile.calltrace.cycles-pp.ksys_shmctl.do_syscall_64.entry_SYSCALL_64_after_hwframe.shmctl
     10.96            +2.7       13.62        perf-profile.calltrace.cycles-pp.shmat
     10.93            +2.7       13.59        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.shmat
     10.93            +2.7       13.60        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.shmat
     10.91            +2.7       13.58        perf-profile.calltrace.cycles-pp.do_shmat.__x64_sys_shmat.do_syscall_64.entry_SYSCALL_64_after_hwframe.shmat
     10.91            +2.7       13.58        perf-profile.calltrace.cycles-pp.__x64_sys_shmat.do_syscall_64.entry_SYSCALL_64_after_hwframe.shmat
      7.93            -1.7        6.19        perf-profile.children.cycles-pp.x64_sys_call
      7.91            -1.7        6.18        perf-profile.children.cycles-pp.__x64_sys_exit_group
      7.91            -1.7        6.18        perf-profile.children.cycles-pp.do_group_exit
      7.91            -1.7        6.17        perf-profile.children.cycles-pp.do_exit
      7.47            -1.6        5.82        perf-profile.children.cycles-pp.exit_mm
      7.46            -1.6        5.82        perf-profile.children.cycles-pp.__mmput
      7.45            -1.6        5.80        perf-profile.children.cycles-pp.exit_mmap
     11.77            -1.6       10.20 ±  2%  perf-profile.children.cycles-pp._Fork
     34.40            -1.5       32.86        perf-profile.children.cycles-pp.shmget
     34.31            -1.5       32.78        perf-profile.children.cycles-pp.__x64_sys_shmget
     34.30            -1.5       32.78        perf-profile.children.cycles-pp.ipcget
     11.36            -1.5        9.88 ±  2%  perf-profile.children.cycles-pp.kernel_clone
     11.36            -1.5        9.88 ±  2%  perf-profile.children.cycles-pp.__do_sys_clone
     10.82            -1.4        9.45 ±  2%  perf-profile.children.cycles-pp.copy_process
     10.45            -1.3        9.16 ±  2%  perf-profile.children.cycles-pp.dup_mm
      5.21            -1.2        4.03        perf-profile.children.cycles-pp.common_startup_64
      5.21            -1.2        4.03        perf-profile.children.cycles-pp.cpu_startup_entry
      5.20            -1.2        4.03        perf-profile.children.cycles-pp.do_idle
      5.18            -1.2        4.01        perf-profile.children.cycles-pp.start_secondary
      9.64            -1.2        8.47 ±  2%  perf-profile.children.cycles-pp.dup_mmap
      4.44            -1.0        3.43        perf-profile.children.cycles-pp.cpuidle_idle_call
      4.26            -1.0        3.28        perf-profile.children.cycles-pp.cpuidle_enter
      4.26            -1.0        3.27        perf-profile.children.cycles-pp.cpuidle_enter_state
      3.57            -0.8        2.78        perf-profile.children.cycles-pp.free_pgtables
      3.03 ±  2%      -0.6        2.38 ±  3%  perf-profile.children.cycles-pp.asm_exc_page_fault
      2.80            -0.6        2.18        perf-profile.children.cycles-pp.unlink_anon_vmas
      2.51 ±  3%      -0.6        1.95 ±  3%  perf-profile.children.cycles-pp.unmap_vmas
      2.43 ±  3%      -0.5        1.89 ±  3%  perf-profile.children.cycles-pp.unmap_page_range
      2.53 ±  2%      -0.5        1.99 ±  4%  perf-profile.children.cycles-pp.exc_page_fault
      2.52 ±  2%      -0.5        1.98 ±  4%  perf-profile.children.cycles-pp.do_user_addr_fault
      2.37 ±  3%      -0.5        1.84 ±  3%  perf-profile.children.cycles-pp.zap_pmd_range
      2.31 ±  3%      -0.5        1.80 ±  3%  perf-profile.children.cycles-pp.zap_pte_range
      2.76 ±  2%      -0.5        2.27        perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      2.63 ±  2%      -0.5        2.16        perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      3.94            -0.5        3.49 ±  2%  perf-profile.children.cycles-pp.anon_vma_clone
      2.13 ±  3%      -0.4        1.70 ±  4%  perf-profile.children.cycles-pp.handle_mm_fault
      2.06 ±  3%      -0.4        1.64 ±  4%  perf-profile.children.cycles-pp.__handle_mm_fault
      1.67            -0.4        1.28        perf-profile.children.cycles-pp.anon_vma_interval_tree_insert
      1.93            -0.4        1.55 ±  3%  perf-profile.children.cycles-pp.ordered_events__queue
      1.70 ±  4%      -0.4        1.32 ±  4%  perf-profile.children.cycles-pp.zap_present_ptes
      1.94            -0.4        1.56 ±  3%  perf-profile.children.cycles-pp.process_simple
      2.20            -0.4        1.82        perf-profile.children.cycles-pp.rwsem_spin_on_owner
      1.93            -0.4        1.56 ±  3%  perf-profile.children.cycles-pp.queue_event
      2.01            -0.4        1.64        perf-profile.children.cycles-pp.cmd_record
      1.95            -0.4        1.60        perf-profile.children.cycles-pp.reader__read_event
      1.95            -0.4        1.60        perf-profile.children.cycles-pp.perf_session__process_events
      1.95            -0.4        1.60        perf-profile.children.cycles-pp.record__finish_output
      1.43 ±  3%      -0.3        1.09 ±  6%  perf-profile.children.cycles-pp.copy_page_range
      1.67 ±  4%      -0.3        1.34 ±  5%  perf-profile.children.cycles-pp.do_fault
      1.40 ±  3%      -0.3        1.07 ±  7%  perf-profile.children.cycles-pp.copy_p4d_range
      1.14            -0.3        0.81        perf-profile.children.cycles-pp._raw_spin_lock
      5.74            -0.3        5.42 ±  2%  perf-profile.children.cycles-pp.anon_vma_fork
      1.48 ±  4%      -0.3        1.19 ±  5%  perf-profile.children.cycles-pp.do_read_fault
      1.23 ±  4%      -0.3        0.95 ±  7%  perf-profile.children.cycles-pp.copy_pte_range
      1.40 ±  5%      -0.3        1.13 ±  5%  perf-profile.children.cycles-pp.filemap_map_pages
      1.11 ±  2%      -0.3        0.84        perf-profile.children.cycles-pp.__vma_start_write
      1.19            -0.3        0.92        perf-profile.children.cycles-pp.kmem_cache_free
      1.64            -0.3        1.38 ±  2%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      1.61            -0.3        1.36 ±  2%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.99            -0.2        0.74        perf-profile.children.cycles-pp.wake_up_q
      1.19            -0.2        0.95        perf-profile.children.cycles-pp.intel_idle
      0.29            -0.2        0.05        perf-profile.children.cycles-pp.idr_find
      1.10            -0.2        0.87        perf-profile.children.cycles-pp.kmem_cache_alloc_noprof
      0.89 ±  5%      -0.2        0.67 ±  9%  perf-profile.children.cycles-pp.copy_present_ptes
      0.93            -0.2        0.72        perf-profile.children.cycles-pp.try_to_wake_up
      1.10            -0.2        0.89        perf-profile.children.cycles-pp.__schedule
      0.90 ±  5%      -0.2        0.72 ±  6%  perf-profile.children.cycles-pp.next_uptodate_folio
      0.75            -0.2        0.57        perf-profile.children.cycles-pp.poll_idle
      0.97 ±  4%      -0.2        0.79 ±  3%  perf-profile.children.cycles-pp.__tlb_batch_free_encoded_pages
      0.96 ±  4%      -0.2        0.79 ±  3%  perf-profile.children.cycles-pp.free_pages_and_swap_cache
      0.63            -0.2        0.46        perf-profile.children.cycles-pp.shm_add_rss_swap
      1.26            -0.2        1.10 ±  2%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.45 ±  9%      -0.2        0.30 ±  3%  perf-profile.children.cycles-pp.ktime_get
      0.63            -0.1        0.48        perf-profile.children.cycles-pp.__anon_vma_interval_tree_remove
      0.63            -0.1        0.49        perf-profile.children.cycles-pp.__vma_enter_locked
      0.80 ±  5%      -0.1        0.66 ±  4%  perf-profile.children.cycles-pp.tlb_finish_mmu
      0.62            -0.1        0.48        perf-profile.children.cycles-pp.newseg
      0.64            -0.1        0.50        perf-profile.children.cycles-pp.vm_area_dup
      0.79            -0.1        0.66        perf-profile.children.cycles-pp.handle_softirqs
      0.49            -0.1        0.35        perf-profile.children.cycles-pp.__pi_memset
      1.15 ±  2%      -0.1        1.02 ±  2%  perf-profile.children.cycles-pp.tick_nohz_handler
      0.74            -0.1        0.61        perf-profile.children.cycles-pp.schedule
      0.70 ±  6%      -0.1        0.57 ±  3%  perf-profile.children.cycles-pp.folios_put_refs
      0.79            -0.1        0.68        perf-profile.children.cycles-pp.mm_init
      0.50            -0.1        0.38        perf-profile.children.cycles-pp.__slab_free
      0.75            -0.1        0.63        perf-profile.children.cycles-pp.__irq_exit_rcu
      0.59 ±  8%      -0.1        0.47 ±  7%  perf-profile.children.cycles-pp.folio_remove_rmap_ptes
      0.41            -0.1        0.30 ±  2%  perf-profile.children.cycles-pp.ret_from_fork
      0.41            -0.1        0.30 ±  2%  perf-profile.children.cycles-pp.ret_from_fork_asm
      0.43            -0.1        0.33 ±  2%  perf-profile.children.cycles-pp.__kmem_cache_alloc_bulk
      0.42            -0.1        0.32        perf-profile.children.cycles-pp.__pcs_replace_empty_main
      0.52            -0.1        0.42        perf-profile.children.cycles-pp.wake_up_new_task
      0.60            -0.1        0.50        perf-profile.children.cycles-pp.schedule_preempt_disabled
      0.49            -0.1        0.39        perf-profile.children.cycles-pp.__memcg_slab_free_hook
      0.43            -0.1        0.32        perf-profile.children.cycles-pp.exit_to_user_mode_loop
      0.55 ±  2%      -0.1        0.45        perf-profile.children.cycles-pp.rcu_core
      0.48            -0.1        0.38        perf-profile.children.cycles-pp.rcu_do_batch
      0.70            -0.1        0.61        perf-profile.children.cycles-pp.pcpu_alloc_noprof
      0.38            -0.1        0.28        perf-profile.children.cycles-pp.task_work_run
      0.17 ± 29%      -0.1        0.08 ±  5%  perf-profile.children.cycles-pp.tick_irq_enter
      0.17 ± 29%      -0.1        0.08 ±  5%  perf-profile.children.cycles-pp.irq_enter_rcu
      0.53            -0.1        0.44        perf-profile.children.cycles-pp.select_task_rq_fair
      0.99 ±  2%      -0.1        0.90 ±  2%  perf-profile.children.cycles-pp.update_process_times
      0.35 ±  2%      -0.1        0.27        perf-profile.children.cycles-pp.__fput
      0.31            -0.1        0.23 ±  3%  perf-profile.children.cycles-pp.__x64_sys_openat
      0.37 ±  2%      -0.1        0.29 ±  2%  perf-profile.children.cycles-pp.__flush_smp_call_function_queue
      0.31 ±  2%      -0.1        0.23 ±  3%  perf-profile.children.cycles-pp.do_sys_openat2
      0.28            -0.1        0.20 ±  2%  perf-profile.children.cycles-pp.do_filp_open
      0.28 ±  2%      -0.1        0.20        perf-profile.children.cycles-pp.path_openat
      0.38            -0.1        0.30 ±  2%  perf-profile.children.cycles-pp.update_sg_wakeup_stats
      0.34            -0.1        0.26        perf-profile.children.cycles-pp.flush_smp_call_function_queue
      0.39            -0.1        0.32        perf-profile.children.cycles-pp.sched_balance_find_dst_group
      0.29            -0.1        0.22 ±  2%  perf-profile.children.cycles-pp.stress_shm_sysv_check
      0.32 ±  3%      -0.1        0.24 ±  4%  perf-profile.children.cycles-pp.__put_anon_vma
      0.32            -0.1        0.25        perf-profile.children.cycles-pp.schedule_idle
      0.34 ±  2%      -0.1        0.27        perf-profile.children.cycles-pp.raw_spin_rq_lock_nested
      0.29 ±  2%      -0.1        0.22 ±  2%  perf-profile.children.cycles-pp.finish_dput
      0.30            -0.1        0.23        perf-profile.children.cycles-pp.mas_find
      0.26 ±  2%      -0.1        0.19 ±  4%  perf-profile.children.cycles-pp.clockevents_program_event
      0.31 ±  2%      -0.1        0.24        perf-profile.children.cycles-pp.sched_ttwu_pending
      0.32            -0.1        0.25        perf-profile.children.cycles-pp.alloc_pages_mpol
      0.30            -0.1        0.23        perf-profile.children.cycles-pp.finish_task_switch
      0.27 ±  2%      -0.1        0.21 ±  2%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.31            -0.1        0.24        perf-profile.children.cycles-pp.__alloc_frozen_pages_noprof
      0.29            -0.1        0.22 ±  2%  perf-profile.children.cycles-pp.__dentry_kill
      0.45            -0.1        0.39 ±  2%  perf-profile.children.cycles-pp.__percpu_counter_init_many
      0.25            -0.1        0.19 ±  3%  perf-profile.children.cycles-pp.___slab_alloc
      0.27            -0.1        0.21 ±  2%  perf-profile.children.cycles-pp.lock_vma_under_rcu
      0.24 ±  4%      -0.1        0.19 ±  5%  perf-profile.children.cycles-pp.wp_page_copy
      0.35            -0.1        0.30        perf-profile.children.cycles-pp.__pick_next_task
      0.24 ±  2%      -0.1        0.18 ±  2%  perf-profile.children.cycles-pp.kernel_wait4
      0.14 ±  2%      -0.1        0.08 ±  4%  perf-profile.children.cycles-pp.shmctl_do_lock
      0.20 ±  3%      -0.1        0.14 ±  2%  perf-profile.children.cycles-pp.kthread
      0.34            -0.1        0.28        perf-profile.children.cycles-pp.pick_next_task_fair
      0.25            -0.1        0.20 ±  2%  perf-profile.children.cycles-pp.alloc_pages_noprof
      0.23 ±  2%      -0.1        0.17 ±  2%  perf-profile.children.cycles-pp.evict
      0.22 ±  2%      -0.1        0.17        perf-profile.children.cycles-pp.do_wait
      0.35 ±  2%      -0.1        0.30        perf-profile.children.cycles-pp.osq_unlock
      0.24 ±  2%      -0.1        0.18 ±  2%  perf-profile.children.cycles-pp.mas_next_slot
      0.23 ±  2%      -0.1        0.18 ±  2%  perf-profile.children.cycles-pp.__percpu_counter_sum
      0.24 ±  5%      -0.1        0.19 ±  5%  perf-profile.children.cycles-pp.set_pte_range
      0.35            -0.1        0.30        perf-profile.children.cycles-pp.__memcg_slab_post_alloc_hook
      0.22            -0.1        0.17        perf-profile.children.cycles-pp.get_page_from_freelist
      0.25            -0.0        0.20        perf-profile.children.cycles-pp.unlink_file_vma_batch_process
      0.25 ±  2%      -0.0        0.20        perf-profile.children.cycles-pp.enqueue_task
      0.18            -0.0        0.13 ±  2%  perf-profile.children.cycles-pp.schedule_tail
      0.23 ±  3%      -0.0        0.18 ±  2%  perf-profile.children.cycles-pp.ttwu_do_activate
      0.24            -0.0        0.19        perf-profile.children.cycles-pp.enqueue_task_fair
      0.19 ±  3%      -0.0        0.14 ±  4%  perf-profile.children.cycles-pp.__pte_offset_map_lock
      0.21 ±  2%      -0.0        0.16        perf-profile.children.cycles-pp._exit
      0.17 ±  2%      -0.0        0.12 ±  3%  perf-profile.children.cycles-pp.fput
      0.18 ±  2%      -0.0        0.14 ±  4%  perf-profile.children.cycles-pp.do_shared_fault
      0.23 ±  2%      -0.0        0.19 ±  3%  perf-profile.children.cycles-pp.wake_q_add
      0.27            -0.0        0.23 ±  2%  perf-profile.children.cycles-pp.sched_balance_rq
      0.20 ±  3%      -0.0        0.16 ±  3%  perf-profile.children.cycles-pp.sync_regs
      0.07 ±  5%      -0.0        0.02 ± 99%  perf-profile.children.cycles-pp.rcu_sched_clock_irq
      0.18 ±  2%      -0.0        0.14 ±  3%  perf-profile.children.cycles-pp.shmem_get_folio_gfp
      0.25            -0.0        0.21        perf-profile.children.cycles-pp.sched_balance_newidle
      0.18 ±  2%      -0.0        0.14 ±  4%  perf-profile.children.cycles-pp.__do_fault
      0.21 ±  5%      -0.0        0.17 ±  7%  perf-profile.children.cycles-pp.__pte_alloc
      0.17            -0.0        0.13 ±  2%  perf-profile.children.cycles-pp.shmem_fault
      0.20 ±  2%      -0.0        0.16 ±  3%  perf-profile.children.cycles-pp.__shmem_file_setup
      0.21 ±  2%      -0.0        0.16 ±  3%  perf-profile.children.cycles-pp.enqueue_entity
      0.22 ±  2%      -0.0        0.18 ±  2%  perf-profile.children.cycles-pp.unlink_file_vma_batch_add
      0.23            -0.0        0.19        perf-profile.children.cycles-pp.update_sg_lb_stats
      0.20 ±  3%      -0.0        0.16 ±  2%  perf-profile.children.cycles-pp.__mmdrop
      0.17 ±  2%      -0.0        0.13 ±  3%  perf-profile.children.cycles-pp.shmem_evict_inode
      0.28            -0.0        0.24        perf-profile.children.cycles-pp.mas_store
      0.15 ±  2%      -0.0        0.11 ±  4%  perf-profile.children.cycles-pp.pthread_rwlock_unlock
      0.18            -0.0        0.14 ±  2%  perf-profile.children.cycles-pp.dequeue_task_fair
      0.06 ±  6%      -0.0        0.02 ± 99%  perf-profile.children.cycles-pp.get_partial_node
      0.16 ±  2%      -0.0        0.12 ±  3%  perf-profile.children.cycles-pp.acct_collect
      0.15 ±  6%      -0.0        0.12 ±  5%  perf-profile.children.cycles-pp.folio_add_file_rmap_ptes
      0.16 ±  2%      -0.0        0.13 ±  3%  perf-profile.children.cycles-pp.ipc_addid
      0.12 ±  5%      -0.0        0.08 ±  5%  perf-profile.children.cycles-pp.worker_thread
      0.17 ±  2%      -0.0        0.13 ±  3%  perf-profile.children.cycles-pp.__rb_erase_color
      0.16 ±  2%      -0.0        0.13        perf-profile.children.cycles-pp.__cond_resched
      0.21 ±  2%      -0.0        0.18        perf-profile.children.cycles-pp.sched_balance_find_src_group
      0.14            -0.0        0.11 ±  4%  perf-profile.children.cycles-pp.rmqueue
      0.15            -0.0        0.12 ±  4%  perf-profile.children.cycles-pp.shmem_undo_range
      0.16            -0.0        0.13 ±  3%  perf-profile.children.cycles-pp.__account_obj_stock
      0.17 ±  2%      -0.0        0.14 ±  3%  perf-profile.children.cycles-pp.obj_cgroup_charge_account
      0.17 ±  2%      -0.0        0.14        perf-profile.children.cycles-pp.dequeue_entities
      0.21            -0.0        0.18        perf-profile.children.cycles-pp.update_sd_lb_stats
      0.11            -0.0        0.08 ±  4%  perf-profile.children.cycles-pp.lookup_fast
      0.15 ±  2%      -0.0        0.12 ±  4%  perf-profile.children.cycles-pp.setproctitle
      0.18 ±  6%      -0.0        0.15 ±  4%  perf-profile.children.cycles-pp.tlb_flush_mmu
      0.12 ±  3%      -0.0        0.09 ±  4%  perf-profile.children.cycles-pp.ttwu_queue_wakelist
      0.14 ±  4%      -0.0        0.11        perf-profile.children.cycles-pp.__rb_insert_augmented
      0.14            -0.0        0.11        perf-profile.children.cycles-pp.new_inode
      0.12            -0.0        0.09        perf-profile.children.cycles-pp.__rmqueue_pcplist
      0.14 ±  3%      -0.0        0.12 ±  4%  perf-profile.children.cycles-pp.dequeue_entity
      0.12 ±  3%      -0.0        0.09 ±  5%  perf-profile.children.cycles-pp.__mt_dup
      0.15 ±  2%      -0.0        0.12 ±  3%  perf-profile.children.cycles-pp.refill_obj_stock
      0.15 ±  2%      -0.0        0.12 ±  3%  perf-profile.children.cycles-pp.try_to_block_task
      0.11            -0.0        0.08 ±  4%  perf-profile.children.cycles-pp.intel_idle_xstate
      0.09 ±  7%      -0.0        0.06 ± 45%  perf-profile.children.cycles-pp.prctl
      0.08 ±  5%      -0.0        0.05        perf-profile.children.cycles-pp.__task_rq_lock
      0.12 ±  3%      -0.0        0.09        perf-profile.children.cycles-pp.__do_wait
      0.08 ±  5%      -0.0        0.06 ±  8%  perf-profile.children.cycles-pp.open_last_lookups
      0.11 ±  3%      -0.0        0.08 ±  5%  perf-profile.children.cycles-pp.link_path_walk
      0.14 ±  5%      -0.0        0.12 ±  4%  perf-profile.children.cycles-pp.__free_frozen_pages
      0.11 ±  5%      -0.0        0.08 ±  8%  perf-profile.children.cycles-pp.pmd_install
      0.12 ±  3%      -0.0        0.09 ±  7%  perf-profile.children.cycles-pp.alloc_thread_stack_node
      0.12 ±  3%      -0.0        0.09 ±  4%  perf-profile.children.cycles-pp.vms_clear_ptes
      0.10 ±  5%      -0.0        0.07        perf-profile.children.cycles-pp.__mmap
      0.11 ±  4%      -0.0        0.09 ±  4%  perf-profile.children.cycles-pp.free_frozen_page_commit
      0.07 ±  5%      -0.0        0.05 ± 45%  perf-profile.children.cycles-pp.strchrnul@plt
      0.14 ±  5%      -0.0        0.12 ±  8%  perf-profile.children.cycles-pp.pte_alloc_one
      0.10 ±  5%      -0.0        0.07 ±  9%  perf-profile.children.cycles-pp.__vmalloc_node_noprof
      0.10 ±  5%      -0.0        0.07 ±  9%  perf-profile.children.cycles-pp.__vmalloc_node_range_noprof
      0.08 ±  6%      -0.0        0.05 ±  7%  perf-profile.children.cycles-pp.do_perf_trace_sched_wakeup_template
      0.11 ±  4%      -0.0        0.09        perf-profile.children.cycles-pp.__shmem_get_inode
      0.12 ±  3%      -0.0        0.10 ±  3%  perf-profile.children.cycles-pp.tlb_remove_table_rcu
      0.09 ±  4%      -0.0        0.07 ±  5%  perf-profile.children.cycles-pp.wait_task_zombie
      0.14            -0.0        0.12 ±  4%  perf-profile.children.cycles-pp.sched_balance_update_blocked_averages
      0.06 ±  7%      -0.0        0.04 ± 44%  perf-profile.children.cycles-pp.inode_init_always_gfp
      0.08 ±  5%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.__snprintf_chk@plt
      0.08 ±  4%      -0.0        0.06        perf-profile.children.cycles-pp.__anon_vma_interval_tree_augment_rotate
      0.11 ±  3%      -0.0        0.09        perf-profile.children.cycles-pp.hugetlb_file_setup
      0.08 ±  4%      -0.0        0.06        perf-profile.children.cycles-pp.process_one_work
      0.08 ±  4%      -0.0        0.06        perf-profile.children.cycles-pp.run_posix_cpu_timers
      0.09 ±  4%      -0.0        0.07        perf-profile.children.cycles-pp.__put_user_4
      0.09 ±  4%      -0.0        0.07        perf-profile.children.cycles-pp.stress_set_proc_state
      0.13            -0.0        0.11 ±  3%  perf-profile.children.cycles-pp.update_rq_clock_task
      0.07 ±  5%      -0.0        0.05 ±  7%  perf-profile.children.cycles-pp.smpboot_thread_fn
      0.06 ±  6%      -0.0        0.04 ± 44%  perf-profile.children.cycles-pp.rmqueue_bulk
      0.10            -0.0        0.08        perf-profile.children.cycles-pp.alloc_inode
      0.08            -0.0        0.06        perf-profile.children.cycles-pp.allocate_slab
      0.08            -0.0        0.06        perf-profile.children.cycles-pp.perf_event_mmap
      0.08            -0.0        0.06        perf-profile.children.cycles-pp.update_rq_clock
      0.07            -0.0        0.05        perf-profile.children.cycles-pp.vfs_read
      0.09            -0.0        0.07        perf-profile.children.cycles-pp.mas_wr_node_store
      0.09            -0.0        0.07        perf-profile.children.cycles-pp.shmem_alloc_and_add_folio
      0.25            -0.0        0.23 ±  2%  perf-profile.children.cycles-pp.update_load_avg
      0.08 ±  5%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.folio_batch_move_lru
      0.08 ±  5%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.release_task
      0.10 ±  4%      -0.0        0.08 ±  4%  perf-profile.children.cycles-pp.vma_interval_tree_remove
      0.09 ±  4%      -0.0        0.07 ±  5%  perf-profile.children.cycles-pp.vm_mmap_pgoff
      0.18 ±  2%      -0.0        0.16 ±  3%  perf-profile.children.cycles-pp.mmap_region
      0.09 ±  5%      -0.0        0.08 ±  6%  perf-profile.children.cycles-pp.free_pcppages_bulk
      0.07 ±  6%      -0.0        0.06 ±  9%  perf-profile.children.cycles-pp.asm_sysvec_call_function_single
      0.08 ±  4%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.__madvise
      0.07            -0.0        0.05 ±  7%  perf-profile.children.cycles-pp.perf_iterate_sb
      0.10            -0.0        0.08 ±  4%  perf-profile.children.cycles-pp.sched_balance_domains
      0.07            -0.0        0.05 ±  7%  perf-profile.children.cycles-pp.switch_mm_irqs_off
      0.08            -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.__smp_call_single_queue
      0.08            -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.__snprintf_chk
      0.09            -0.0        0.07 ±  5%  perf-profile.children.cycles-pp.rcu_all_qs
      0.08 ±  5%      -0.0        0.06        perf-profile.children.cycles-pp.mas_dup_alloc
      0.08 ±  5%      -0.0        0.06        perf-profile.children.cycles-pp.vsnprintf
      0.07 ±  5%      -0.0        0.05        perf-profile.children.cycles-pp.__folio_batch_release
      0.07 ±  5%      -0.0        0.05        perf-profile.children.cycles-pp.ksys_read
      0.11 ±  4%      -0.0        0.09 ±  7%  perf-profile.children.cycles-pp.mas_walk
      0.08 ±  6%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.lru_add_drain_cpu
      0.07            -0.0        0.05 ±  8%  perf-profile.children.cycles-pp.__page_cache_release
      0.09            -0.0        0.07 ±  6%  perf-profile.children.cycles-pp.entry_SYSCALL_64
      0.07 ±  5%      -0.0        0.05 ±  7%  perf-profile.children.cycles-pp.madvise_do_behavior
      0.08 ±  5%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.arch_exit_to_user_mode_prepare
      0.15 ±  2%      -0.0        0.13 ±  2%  perf-profile.children.cycles-pp.shm_destroy
      0.08 ±  6%      -0.0        0.06        perf-profile.children.cycles-pp.__memcg_kmem_charge_page
      0.08 ±  6%      -0.0        0.06        perf-profile.children.cycles-pp.perf_event_mmap_event
      0.07 ±  7%      -0.0        0.05        perf-profile.children.cycles-pp.mod_memcg_lruvec_state
      0.07 ±  5%      -0.0        0.05 ±  8%  perf-profile.children.cycles-pp.exit_notify
      0.07 ±  7%      -0.0        0.05 ±  7%  perf-profile.children.cycles-pp.alloc_pid
      0.08 ±  6%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.__wp_page_copy_user
      0.08 ±  6%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.copy_mc_enhanced_fast_string
      0.07            -0.0        0.06 ±  8%  perf-profile.children.cycles-pp.__x64_sys_madvise
      0.07            -0.0        0.06 ±  8%  perf-profile.children.cycles-pp.do_madvise
      0.07 ±  7%      -0.0        0.05 ±  8%  perf-profile.children.cycles-pp.mas_next_node
      0.07 ±  5%      -0.0        0.06        perf-profile.children.cycles-pp.vm_normal_page
      0.08 ±  4%      -0.0        0.07        perf-profile.children.cycles-pp.__wake_up_sync_key
      0.10 ±  3%      -0.0        0.09        perf-profile.children.cycles-pp.ksys_write
      0.06 ±  6%      -0.0        0.05        perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.06 ±  6%      -0.0        0.05        perf-profile.children.cycles-pp._find_next_and_bit
      0.06 ±  6%      -0.0        0.05        perf-profile.children.cycles-pp.sched_balance_find_dst_group_cpu
      0.06 ±  6%      -0.0        0.05        perf-profile.children.cycles-pp.shuffle_freelist
      0.09            -0.0        0.08 ±  4%  perf-profile.children.cycles-pp.kfree
      0.07            -0.0        0.06        perf-profile.children.cycles-pp.mas_store_gfp
      0.07            -0.0        0.06        perf-profile.children.cycles-pp.native_sched_clock
      0.08            -0.0        0.07        perf-profile.children.cycles-pp.__wake_up_common
      0.06            -0.0        0.05        perf-profile.children.cycles-pp._find_next_or_bit
      0.06            -0.0        0.05        perf-profile.children.cycles-pp.arch_get_unmapped_area_topdown
      0.06            -0.0        0.05        perf-profile.children.cycles-pp.prep_new_page
      0.06            -0.0        0.05        perf-profile.children.cycles-pp.sched_clock_cpu
      0.06            -0.0        0.05        perf-profile.children.cycles-pp.vms_gather_munmap_vmas
      0.05            +0.0        0.06 ±  6%  perf-profile.children.cycles-pp.on_each_cpu_cond_mask
      0.05            +0.0        0.06 ±  6%  perf-profile.children.cycles-pp.smp_call_function_many_cond
      0.06            +0.0        0.08 ±  4%  perf-profile.children.cycles-pp.up_read
      0.25 ±  4%      +0.0        0.29 ±  5%  perf-profile.children.cycles-pp.task_tick_fair
      2.58            +0.0        2.63        perf-profile.children.cycles-pp.up_write
      0.00            +0.1        0.06 ±  8%  perf-profile.children.cycles-pp.__shm_open
      0.05 ±  7%      +0.1        0.11        perf-profile.children.cycles-pp.ipc_obtain_object_check
      0.05            +0.1        0.11 ±  4%  perf-profile.children.cycles-pp.ipc_obtain_object_idr
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.shm_mmap
      0.04 ± 50%      +0.1        0.11 ±  6%  perf-profile.children.cycles-pp.__mutex_lock
      0.00            +0.1        0.09        perf-profile.children.cycles-pp.radix_tree_next_chunk
      1.95            +0.2        2.12        perf-profile.children.cycles-pp.rwsem_wake
      1.51            +0.2        1.74        perf-profile.children.cycles-pp.do_mmap
      1.43            +0.2        1.68        perf-profile.children.cycles-pp.__mmap_region
      1.33            +0.3        1.63        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      1.37            +1.1        2.52        perf-profile.children.cycles-pp.rwsem_down_read_slowpath
      1.37            +1.2        2.54        perf-profile.children.cycles-pp.down_read
      8.31            +1.3        9.64        perf-profile.children.cycles-pp.shmdt
     56.16            +1.3       57.51        perf-profile.children.cycles-pp.osq_lock
     87.26            +1.4       88.62        perf-profile.children.cycles-pp.do_syscall_64
     87.27            +1.4       88.63        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      8.08            +1.4        9.47        perf-profile.children.cycles-pp.ksys_shmdt
      7.92            +1.4        9.35        perf-profile.children.cycles-pp.do_vmi_align_munmap
      7.80            +1.4        9.25        perf-profile.children.cycles-pp.remove_vma
      7.80            +1.5        9.26        perf-profile.children.cycles-pp.vms_complete_munmap_vmas
      8.26            +1.6        9.90        perf-profile.children.cycles-pp.__shm_close
      0.18 ±  2%      +2.2        2.36        perf-profile.children.cycles-pp.__radix_tree_lookup
     13.40            +2.4       15.75        perf-profile.children.cycles-pp.shmctl
     13.09            +2.4       15.50        perf-profile.children.cycles-pp.ksys_shmctl
     63.32            +2.6       65.87        perf-profile.children.cycles-pp.down_write
     10.97            +2.7       13.62        perf-profile.children.cycles-pp.shmat
     10.91            +2.7       13.58        perf-profile.children.cycles-pp.__x64_sys_shmat
     10.91            +2.7       13.58        perf-profile.children.cycles-pp.do_shmat
     62.44            +2.7       65.18        perf-profile.children.cycles-pp.rwsem_down_write_slowpath
      4.61            +3.0        7.59        perf-profile.children.cycles-pp._raw_spin_lock_irq
      5.90            +4.4       10.32        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      1.66            -0.4        1.26        perf-profile.self.cycles-pp.anon_vma_interval_tree_insert
      2.17            -0.4        1.80        perf-profile.self.cycles-pp.rwsem_spin_on_owner
      1.92            -0.4        1.54 ±  3%  perf-profile.self.cycles-pp.queue_event
      0.28            -0.3        0.02 ± 99%  perf-profile.self.cycles-pp.idr_find
      0.95            -0.2        0.70        perf-profile.self.cycles-pp._raw_spin_lock
      1.00 ±  2%      -0.2        0.76 ±  4%  perf-profile.self.cycles-pp.zap_present_ptes
      1.19            -0.2        0.95        perf-profile.self.cycles-pp.intel_idle
      0.85 ±  5%      -0.2        0.64 ±  9%  perf-profile.self.cycles-pp.copy_present_ptes
      0.84            -0.2        0.66 ±  2%  perf-profile.self.cycles-pp.down_write
      0.74            -0.2        0.56        perf-profile.self.cycles-pp.poll_idle
      0.83 ±  5%      -0.2        0.67 ±  6%  perf-profile.self.cycles-pp.next_uptodate_folio
      0.42 ±  9%      -0.2        0.27 ±  3%  perf-profile.self.cycles-pp.ktime_get
      0.61            -0.1        0.47        perf-profile.self.cycles-pp.__anon_vma_interval_tree_remove
      0.61            -0.1        0.46 ±  2%  perf-profile.self.cycles-pp.__vma_enter_locked
      0.47            -0.1        0.34        perf-profile.self.cycles-pp.__pi_memset
      0.63            -0.1        0.50 ±  2%  perf-profile.self.cycles-pp.up_write
      0.47 ±  2%      -0.1        0.35 ±  2%  perf-profile.self.cycles-pp.__vma_start_write
      0.57 ±  9%      -0.1        0.45 ±  7%  perf-profile.self.cycles-pp.folio_remove_rmap_ptes
      0.48            -0.1        0.37 ±  2%  perf-profile.self.cycles-pp.__slab_free
      0.47 ±  2%      -0.1        0.37 ±  2%  perf-profile.self.cycles-pp.anon_vma_clone
      0.65            -0.1        0.55        perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.54            -0.1        0.45        perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.57 ±  7%      -0.1        0.48 ±  4%  perf-profile.self.cycles-pp.folios_put_refs
      0.41            -0.1        0.32 ±  2%  perf-profile.self.cycles-pp.dup_mmap
      0.32            -0.1        0.24        perf-profile.self.cycles-pp.__kmem_cache_alloc_bulk
      0.33 ±  2%      -0.1        0.26 ±  2%  perf-profile.self.cycles-pp.unlink_anon_vmas
      0.52            -0.1        0.45        perf-profile.self.cycles-pp.rwsem_down_write_slowpath
      0.33            -0.1        0.26        perf-profile.self.cycles-pp.__memcg_slab_free_hook
      0.29 ±  5%      -0.1        0.22 ±  6%  perf-profile.self.cycles-pp.zap_pte_range
      0.27 ±  2%      -0.1        0.21 ±  2%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.32            -0.1        0.26        perf-profile.self.cycles-pp.update_sg_wakeup_stats
      0.30 ±  2%      -0.1        0.24 ±  2%  perf-profile.self.cycles-pp.free_pages_and_swap_cache
      0.35            -0.1        0.29        perf-profile.self.cycles-pp.osq_unlock
      0.20 ±  2%      -0.0        0.15 ±  2%  perf-profile.self.cycles-pp.__percpu_counter_sum
      0.18 ±  2%      -0.0        0.14 ±  2%  perf-profile.self.cycles-pp.lock_vma_under_rcu
      0.23 ±  2%      -0.0        0.19        perf-profile.self.cycles-pp.wake_q_add
      0.25 ±  5%      -0.0        0.20 ±  4%  perf-profile.self.cycles-pp.filemap_map_pages
      0.20 ±  3%      -0.0        0.16 ±  3%  perf-profile.self.cycles-pp.sync_regs
      0.14 ±  5%      -0.0        0.10        perf-profile.self.cycles-pp.wake_up_q
      0.23            -0.0        0.19 ±  2%  perf-profile.self.cycles-pp.kmem_cache_alloc_noprof
      0.18 ±  2%      -0.0        0.14 ±  5%  perf-profile.self.cycles-pp.anon_vma_fork
      0.16 ±  2%      -0.0        0.12 ±  3%  perf-profile.self.cycles-pp.mas_next_slot
      0.20 ±  2%      -0.0        0.16 ±  3%  perf-profile.self.cycles-pp.kmem_cache_free
      0.16 ±  3%      -0.0        0.12 ±  3%  perf-profile.self.cycles-pp.fput
      0.07            -0.0        0.03 ± 70%  perf-profile.self.cycles-pp.__put_anon_vma
      0.10 ±  5%      -0.0        0.06        perf-profile.self.cycles-pp.ipc_addid
      0.06            -0.0        0.02 ± 99%  perf-profile.self.cycles-pp._find_next_and_bit
      0.15 ±  6%      -0.0        0.11 ±  9%  perf-profile.self.cycles-pp.folio_add_file_rmap_ptes
      0.14            -0.0        0.11        perf-profile.self.cycles-pp.cpuidle_enter_state
      0.22 ±  2%      -0.0        0.19        perf-profile.self.cycles-pp.mas_store
      0.15 ±  2%      -0.0        0.12 ±  3%  perf-profile.self.cycles-pp.__rb_erase_color
      0.14 ±  3%      -0.0        0.11 ±  4%  perf-profile.self.cycles-pp.__rb_insert_augmented
      0.17 ±  2%      -0.0        0.14 ±  3%  perf-profile.self.cycles-pp.update_sg_lb_stats
      0.11            -0.0        0.08 ±  4%  perf-profile.self.cycles-pp.intel_idle_xstate
      0.11 ±  3%      -0.0        0.08        perf-profile.self.cycles-pp.try_to_wake_up
      0.12 ±  4%      -0.0        0.09        perf-profile.self.cycles-pp.__schedule
      0.18            -0.0        0.16 ±  3%  perf-profile.self.cycles-pp.__memcg_slab_post_alloc_hook
      0.10 ±  5%      -0.0        0.07 ±  6%  perf-profile.self.cycles-pp.vma_interval_tree_remove
      0.10            -0.0        0.08 ±  4%  perf-profile.self.cycles-pp.___slab_alloc
      0.09            -0.0        0.07 ±  5%  perf-profile.self.cycles-pp.__cond_resched
      0.09 ±  4%      -0.0        0.07 ± 11%  perf-profile.self.cycles-pp.stress_shm_sysv_child
      0.10 ±  4%      -0.0        0.08 ±  5%  perf-profile.self.cycles-pp.mas_walk
      0.08            -0.0        0.06        perf-profile.self.cycles-pp.__anon_vma_interval_tree_augment_rotate
      0.11            -0.0        0.09        perf-profile.self.cycles-pp.acct_collect
      0.08            -0.0        0.06        perf-profile.self.cycles-pp.run_posix_cpu_timers
      0.07            -0.0        0.05        perf-profile.self.cycles-pp.switch_mm_irqs_off
      0.12            -0.0        0.10        perf-profile.self.cycles-pp.ksys_shmdt
      0.11 ±  4%      -0.0        0.09 ±  5%  perf-profile.self.cycles-pp.__account_obj_stock
      0.07            -0.0        0.05 ±  7%  perf-profile.self.cycles-pp.shmem_get_folio_gfp
      0.09 ±  5%      -0.0        0.07 ±  5%  perf-profile.self.cycles-pp.set_pte_range
      0.10 ±  4%      -0.0        0.09 ±  4%  perf-profile.self.cycles-pp.update_rq_clock_task
      0.07 ±  7%      -0.0        0.05 ±  7%  perf-profile.self.cycles-pp.refill_obj_stock
      0.07            -0.0        0.06 ±  6%  perf-profile.self.cycles-pp.native_sched_clock
      0.08            -0.0        0.07        perf-profile.self.cycles-pp.menu_select
      0.06            -0.0        0.05        perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.06            -0.0        0.05        perf-profile.self.cycles-pp.obj_cgroup_charge_account
      0.09            +0.0        0.10        perf-profile.self.cycles-pp.ksys_shmctl
      0.07 ±  5%      +0.0        0.08 ±  4%  perf-profile.self.cycles-pp.rwsem_down_read_slowpath
      0.05            +0.0        0.07        perf-profile.self.cycles-pp.up_read
      0.00            +0.1        0.06 ±  6%  perf-profile.self.cycles-pp.down_read
      0.00            +0.1        0.09        perf-profile.self.cycles-pp.radix_tree_next_chunk
     55.71            +1.3       57.03        perf-profile.self.cycles-pp.osq_lock
      0.17 ±  2%      +2.2        2.34        perf-profile.self.cycles-pp.__radix_tree_lookup
      5.90            +4.4       10.32        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


