Return-Path: <linux-arch+bounces-11386-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27824A85067
	for <lists+linux-arch@lfdr.de>; Fri, 11 Apr 2025 02:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C7571B8532C
	for <lists+linux-arch@lfdr.de>; Fri, 11 Apr 2025 00:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6341D1FDA;
	Fri, 11 Apr 2025 00:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aW4aqJTj"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CC1802;
	Fri, 11 Apr 2025 00:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744329830; cv=fail; b=FepXb+2HUs+nEs5sHi496oIVmMlrFeMgAldRFYe+0VG9S5O2QG/dnyoRhlNEPaUJEvPZJOCBZ/oqVkRvD2qk+14Uz9dDGPx7+0zGSGTJzxW+z8vTiV3g5uK9NK3E2ETwKNVOqTqU6Gd9gvqdb8cFDPzZPG6IIAiiQx4WVi1j27Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744329830; c=relaxed/simple;
	bh=mnNoftkda5PsUVmvp6S7DrQqt0zELHdyizjnlx1T/bM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OERFzBN7YDj96o/+PksoCxvzEwgCE4JU1ZIP4Vy1+BUj0oFQ20UKnHOjzyrcqfBOntKSlTYEP47/DC3A5fD5IDMvbVxtzazvVPBqGydfujBWf6o75jBsByvQGSYnGWiO45JLnLsm794csz7JsY//g40dU627xGUL81OK9QZusSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aW4aqJTj; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744329828; x=1775865828;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=mnNoftkda5PsUVmvp6S7DrQqt0zELHdyizjnlx1T/bM=;
  b=aW4aqJTju3BGweQfGFTKnO9lEMzicWPGx9xHCOWlQAH67aAYCalWNl/O
   5T9m5licdoIcg+KjKCLtY+746h4fksFd3IRreSMXIoqju+x+9IJUnF62/
   MNU0pgIN4aEOtpJYrYEcrMJ9Tq7uARhULJbE8IpFGTjW/kB6yNYowcheE
   P5GUylzdvBKo3fk4pvgYzeCEH+0v5i0WWw4vOL8nmAPDZ/5bn/Y6DK5yA
   zrZI00e9yKYx65VJV6mL6yuGwcl5BbQiJ4kLANFnN1BGhHv2zzAXSJX3m
   bAM3r/Z1yqKyMQko4zTx5Puo4rWmFNkpm5mH9f4EbYb3ieTVvjfD46KjD
   w==;
X-CSE-ConnectionGUID: Mziugt/kS6erHwPIsHGEkw==
X-CSE-MsgGUID: wbaBYwFUREirA8IqgHe7xA==
X-IronPort-AV: E=McAfee;i="6700,10204,11400"; a="45112628"
X-IronPort-AV: E=Sophos;i="6.15,203,1739865600"; 
   d="scan'208";a="45112628"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 17:03:46 -0700
X-CSE-ConnectionGUID: csAJn/haQ4+B7AprE/eBhw==
X-CSE-MsgGUID: yNqNv+JiQyqwYUjLyN9ZYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,203,1739865600"; 
   d="scan'208";a="133906674"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 17:03:47 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 10 Apr 2025 17:03:46 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 10 Apr 2025 17:03:46 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 10 Apr 2025 17:03:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HpPW4ZoLTQYH7Qfo4m9zPOfY1d74KLmYHWZEcohDM8Qpy/eMYMEg2oNd/Hh1uQiJk5QTeo5jffmNtZf/UmDJOtl20ZFgqg3Kef/CQgcW8NgNnerx+j0KKwXoy33rvdJ6NKRxU68qFFGcxu/LneR1VG/riih3Ms5nPQDuuymJwUO1SKzt6xUixtWAqPqwyTcFP0VK2A3cmx0CA41gSTd18wu56kowMSZLnfDYdfaEG6OoZzLHqc35sf+bwwOOkrHO63agJVe9RzJ9W/cSoN47BciUEZTwr4wW9O6LFeXpCeQqsqoEyl+M7MHoTt+lSKtinLmz6swCNS+gtlrx5qnOgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H3fe0YI9AZX1bi9KEJ9IwQy/FZ2PaDvqO77eqw9TFl8=;
 b=UV/f0ziPoOGKBMygrDIPgb+4mKWQe59A4+KWkUFWZ+G2YSqX07bIc33sYlL9zb4D5Pnx8duqQoN3AGU7zuikm91pPseSl5/OezQLFUPbGGgGlRK+Z3TSJaeQyUQ8GOY1ACCrMp36/a0HMzj9Dn0rBGK98+PSMkYUH51CM42zvgLLM6xbIa2bhooiVFfapIUWOnspfFxNSYKVxbmnAy/kdRmFDtqNtRb0lT73M0u6q7WfjF5pQK4lEEaGeg4rdKiLLMIIDZPCCC1Cvxovx8tlmzjni4x1XJMd7PuDR/xik5K4pJSPdWrMIB09zyfAJUR7vr5Cv2ncEP662lP2GCNmKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB6996.namprd11.prod.outlook.com (2603:10b6:806:2af::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Fri, 11 Apr
 2025 00:03:37 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%3]) with mapi id 15.20.8606.033; Fri, 11 Apr 2025
 00:03:37 +0000
Date: Thu, 10 Apr 2025 17:03:31 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Michael Kelley <mhklinux@outlook.com>, Dan Williams
	<dan.j.williams@intel.com>, Roman Kisel <romank@linux.microsoft.com>, "Robin
 Murphy" <robin.murphy@arm.com>, "aleksander.lobakin@intel.com"
	<aleksander.lobakin@intel.com>, "andriy.shevchenko@linux.intel.com"
	<andriy.shevchenko@linux.intel.com>, "arnd@arndb.de" <arnd@arndb.de>,
	"bp@alien8.de" <bp@alien8.de>, "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>, "corbet@lwn.net" <corbet@lwn.net>,
	"dakr@kernel.org" <dakr@kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "decui@microsoft.com" <decui@microsoft.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>, "hch@lst.de" <hch@lst.de>,
	"hpa@zytor.com" <hpa@zytor.com>, "James.Bottomley@hansenpartnership.com"
	<James.Bottomley@hansenpartnership.com>, "Jonathan.Cameron@huawei.com"
	<Jonathan.Cameron@huawei.com>, "kys@microsoft.com" <kys@microsoft.com>,
	"leon@kernel.org" <leon@kernel.org>, "lukas@wunner.de" <lukas@wunner.de>,
	"luto@kernel.org" <luto@kernel.org>, "m.szyprowski@samsung.com"
	<m.szyprowski@samsung.com>, "martin.petersen@oracle.com"
	<martin.petersen@oracle.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "quic_zijuhu@quicinc.com"
	<quic_zijuhu@quicinc.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "will@kernel.org"
	<will@kernel.org>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-scsi@vger.kernel.org"
	<linux-scsi@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>
CC: "apais@microsoft.com" <apais@microsoft.com>, "benhill@microsoft.com"
	<benhill@microsoft.com>, "bperkins@microsoft.com" <bperkins@microsoft.com>,
	"sunilmut@microsoft.com" <sunilmut@microsoft.com>, Suzuki K Poulose
	<suzuki.poulose@arm.com>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>
Subject: RE: [PATCH hyperv-next 5/6] arch, drivers: Add device struct
 bitfield to not bounce-buffer
Message-ID: <67f85c5349acf_71fe294ac@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250409000835.285105-1-romank@linux.microsoft.com>
 <20250409000835.285105-6-romank@linux.microsoft.com>
 <0eb87302-fae8-4708-aaf8-d16e836e727f@arm.com>
 <0ab2849a-5c03-4a8c-891e-3cb89b20b0e4@linux.microsoft.com>
 <67f703099f124_71fe2949e@dwillia2-xfh.jf.intel.com.notmuch>
 <SN6PR02MB4157328CAB1EBD021093DD3FD4B72@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <SN6PR02MB4157328CAB1EBD021093DD3FD4B72@SN6PR02MB4157.namprd02.prod.outlook.com>
X-ClientProxiedBy: MW4P221CA0015.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::20) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB6996:EE_
X-MS-Office365-Filtering-Correlation-Id: 25d889e4-b760-4cd8-4b29-08dd788c4eb4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7LRGjYv6OBWBDJh4L7gCIGWSapIMx65/dO7o3pS7OlSsj9Jdijz64gSJ9Huk?=
 =?us-ascii?Q?/qdJJ9Zu6MGTPy3fgWP4mBymyKob0Pg/XAZTclSkocOsk+tvKKRxs3D5jjLG?=
 =?us-ascii?Q?o4+HO+lfHHrITKPVLOSDNuMqCD2I1Bwg9tMsLIPg8O8N5n401T20Ch9Vx6p6?=
 =?us-ascii?Q?JWSckjxftL5exGB9Jv379ZiAMLDk3wHFo2hMqoENzjcntoOn7cqXHj72mJ5U?=
 =?us-ascii?Q?XF9Aauqyi3f3J81kHFsyeGO16d/DCPi+6vL7SyCvc9lxRLObSHCiaeOY8ryF?=
 =?us-ascii?Q?TPNzM2XNl4XosEavgO61heye2lm55j4rCxsfZy+fHVosg/eIGQEswl0XxlvB?=
 =?us-ascii?Q?aBEVCDpZ8IM2Ep50fvlgcp4tJM8sYJPAzCWOR/UzUPX4VcIrEsvQxlkCTES2?=
 =?us-ascii?Q?sxpq1H/Vy/WP1ADJE4Mwou6TZ1dGNbGpDvgVwbvCmEB7B15oqbc7WN285kCW?=
 =?us-ascii?Q?12lLWf6lSSZuirHw8+jqRLgMJ79n4Nrzz+FAwYGwP3u1T72wT+jYDNwqlZw+?=
 =?us-ascii?Q?q5hl6fr06LS3IBMuroxIyaeuxbsJ09Pdw466UBsYUs8PTaSQm3tTtoDUQQes?=
 =?us-ascii?Q?0zvIpQrn+I44e9Sfdt0n3UwdIqP5NhajIV/81aUSiOHjG2yIq4Up535NPzyj?=
 =?us-ascii?Q?2VMDSwg3sguOdwJwD3EJ6zGPv3ZJA5YWRxPONEgBcQCLjxtyTU5Gb32KDZ8D?=
 =?us-ascii?Q?V5cOg3rKNPjuj3VWV4cq/LFVQ36+wEUXaFrt3aXg27viiYXVHV/uhAbQx86n?=
 =?us-ascii?Q?xXYn89FYN3SWCPyU++YiqEVmQr1CNRAQzuPpAC5cMkxN3PspJxHyIEn9ShYY?=
 =?us-ascii?Q?UX/EbIAyvqt5N5pXiwqZGVz8Wk8FCRmMt0yqnx9ZbMTBiAU3ZYYP4W6Stp0A?=
 =?us-ascii?Q?JNeVCs98pjA5ZeLO4ksIf2g2+Mjx2jb9k57++whGzGEmSazjSXHdypU10XJn?=
 =?us-ascii?Q?5AZ3boww8ZAWETS9rp/dkgC8S73lcUD13+RTk0SZ2beIFZKRFJinYzweCovl?=
 =?us-ascii?Q?Vdc+KenpFNRQ68w/Eqdq7QRYpebB1KV09uUEoFXbsZbYf2vPkGkA4wcKci5x?=
 =?us-ascii?Q?4h0XgW8yabhs53tueCnAuKH+5RwMJ6SPjvJ6K4FVZTa6IJaKt1rqOMvh9u4s?=
 =?us-ascii?Q?UeueEFozDhabILJyoEEmo8vHHTBLnGn91NiRoJJdrQU7BqrVAj2/kbvqEenS?=
 =?us-ascii?Q?HhbafoAVVPfWywn2W2VXB75qPoS3GpJen3a338YAlaSE/qyQcnYTkMY9Pi68?=
 =?us-ascii?Q?G140ysnt76T48nd70q7swon/nGpTpBaeEs+3Unc2+ftfIVOHQ092woEyPAgb?=
 =?us-ascii?Q?+c1g3PLNpE7L2kK11pZsYjnbPsnyBbHNYGMML73MuW9r7IQS9mO/fgqFvOFf?=
 =?us-ascii?Q?rjQ//WVWgxRtkgOnBXBSwxPvY1BnX3vrj9nEX+NK8e87vr1+yptOztRLJONk?=
 =?us-ascii?Q?3NVXuFFtzMi9jkhvAmBNsLVPH3SqcD8asgHQIgUu+0A64oGKtIThyg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?S4ISyuL7xOYNB+c7vsjGBEet7NpP63WLQWnSw10Ejlc0YVLBdGN7CD6nDl0L?=
 =?us-ascii?Q?lSGoKHkLrEH9X46llXFkCEqGPjyqXk2Nfl6FRAO9+wQhQAAZ3p0FqylTqK8M?=
 =?us-ascii?Q?SGQsDDmaZOGTd8bQoqXsFHm6qtqGGfC6VgtxOcJ8ZEfIx5QsoOXMe/Ka4BcV?=
 =?us-ascii?Q?gh5zhu3BDzEqBtunPF3617/kIc8vCo7prQyXDAI3lpClmBsVSG9uwpp1niTT?=
 =?us-ascii?Q?nzhwkkrsKkxVZ+c81fOlUUwmpf5gAzzapcHwgQ9eYOoLriFO4ScdBrNzmS79?=
 =?us-ascii?Q?gXVno//KIioNga09s2IrGFFMrFNlbB6t2NMoNIb7IUctp+3vzxIE+2vFa1bv?=
 =?us-ascii?Q?ofxVgoA9iPw8js+0S/MFQ6XMGntgVCZd+x0rw/Hp5XmLf1coJrBB/ruTKJg8?=
 =?us-ascii?Q?YhE9yPVLlaSCYD34/SLx4dEfA0yTXcM1cUI6uAEfrB3SsPYa4YWSOM/lxISK?=
 =?us-ascii?Q?qNuI3M1hVTqdDxXEJtjja+OA4mdBIpHSnWsbiQdUUZ3y23S5cQ9NB1xPzhqX?=
 =?us-ascii?Q?g+Fr5h17W9MDzrcjfd7mG43Ndx2xHKKYmL3mKBPpNS+RVP+51oMHpctYDBvE?=
 =?us-ascii?Q?X+SeU51cv1w/+eylWaDGgptwJC2GjyjzYrFmXfSBBzeb/V1D3nA7FxhYjsFX?=
 =?us-ascii?Q?HxirCr7TzuepJ2gEmIhAYU14gmxmi7unFT4PoZwuufOSMSERiejjxhWS/TCX?=
 =?us-ascii?Q?FmfGDdSu9ErSnvqf0XgLalEsXbxSJsSTz9/cx5tHsA8lOlFLSeA6D+/MG9+U?=
 =?us-ascii?Q?DKjI5g5BEOVDFNFu+L4Nzm7eCDmOp/eDJ2aCjaMYxcIl3wQBi2bJAdtiikD0?=
 =?us-ascii?Q?X7P3n/cD59EBvYqC4GNegFDiHFHIOVukPM6Q3PhtXNCwJm3ZGaYF7Fv1UYv0?=
 =?us-ascii?Q?j4eIBxExRzIwA9Khcnv7pRME21L11GYpQtI7jfh2JRGMXWyLa03m6xkCZtk6?=
 =?us-ascii?Q?WHE0eJQZ2rjUa2o7q7jkp3XUIwDj26UejHp+uKKwNE2tL/jUAtaHFpN7ad7A?=
 =?us-ascii?Q?uGH6SUoBztvOjV7W2vnxCa2Cbg1SQ8inYJmtRucPNpLAfxtQgGBP/Gt72xS6?=
 =?us-ascii?Q?jW0qaV0gOIR9R8+AIf7xKqfsevAQyPBUq67QYjgNhRWtXAFzsZY1OaouhLvs?=
 =?us-ascii?Q?UZIVDq9cug65Kavk2+FCxhNeCMQZK5jaRYW3UL3bQ0trrToqSlIroApgClMN?=
 =?us-ascii?Q?I+m3EKmNJzRvBfk28CwmOCEfReqfs32jj7Ae/M6RfCZkP36b24SBImFrB5jw?=
 =?us-ascii?Q?GnNlcW25BV3s6yJv5liGCkU8bbpM/Sm6H/eX/CmTiGY03ZYDWSSgSvugb1U7?=
 =?us-ascii?Q?wMgJ+ev+lPcKj5diGJn5Kx7KxTAp/2inTgXl+y1hk+XhFtV5gI8TtaNqssjk?=
 =?us-ascii?Q?KDaojLYDk6B+EHSDp8n+QKbu+KJ2St9sy6mAy8VXuTZ79d/+/rDlLiOIg8W5?=
 =?us-ascii?Q?tbTrFDGLMJ/q2X9Ac3nNUvx4ChBexz7k5lIJFiQQr9SUucFl78Ui6CtiZNdF?=
 =?us-ascii?Q?l1IGFDqp5BkgKkeMwFZG7jK46oHImVZKXGyYVsLWm++FhZjYtVb/aaodB7XT?=
 =?us-ascii?Q?ileLvtThsOE1AryMYcPB9FFi+Z11WPBWBnBfHDYEPUZdgZd963IrVjr1z0u0?=
 =?us-ascii?Q?nQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 25d889e4-b760-4cd8-4b29-08dd788c4eb4
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 00:03:36.9668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bBGp51c+yqkP+3LGtXsNO/yQi8x0KKNrAA3agJpkJ8JwOxLTaf/YV4ThH0fZ61M4xwDk+k2BF3ivnTIeyx09JWxJmlzr6OOv45+Izu0Du14=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6996
X-OriginatorOrg: intel.com

Michael Kelley wrote:
> From: Dan Williams <dan.j.williams@intel.com> Sent: Wednesday, April 9, 2025 4:30 PM
[..]
> > Like PCIe TDISP the capability of this device to access private memory
> > is a property of the bus and the iommu. However, acceptance of the
> > device into private operation is a willful policy action. It needs to
> > validate not only the device provenance and state, but also the Linux
> > DMA layer requirements of not holding shared or swiotlb mappings over
> > the "entry into private mode operation" event.
> 
> To flesh this out the swiotlb aspect a bit, once a TDISP device has
> gone private, how does it prevent the DMA layer from ever doing
> bounce buffering through the swiotlb? My understanding is that
> the DMA layer doesn't make any promises to not do bounce buffering.
> Given the vagaries of memory alignment, perhaps add in a virtual
> IOMMU, etc., it seems like a device driver can't necessarily predict
> what DMA operations might result in bounce buffering. Does TDISP
> anticipate needing a formal way to tell the DMA layer "don't bounce
> buffer"? (and return an error instead?) Or would there be a separate
> swiotlb memory pool that is private memory so that bounce buffer
> could be done when necessary and still maintain confidentiality?

I expect step 1 is just add some rude errors / safety for attempting to
convert the mode of a device while it has any DMA mappings established,
and explicit failures for attempts to fallback to swiotlb for
'private_accepted' devices.

The easiest way to enforce that a device does not cross the
shared/private boundary while DMA mappings are live is to simply not
allow that transition while a driver is bound (i.e. "dev->driver" is
non-NULL).

