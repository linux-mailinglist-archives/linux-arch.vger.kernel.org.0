Return-Path: <linux-arch+bounces-13271-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3502BB34FD3
	for <lists+linux-arch@lfdr.de>; Tue, 26 Aug 2025 01:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 123904E29B6
	for <lists+linux-arch@lfdr.de>; Mon, 25 Aug 2025 23:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B3924DD11;
	Mon, 25 Aug 2025 23:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KPSH29g6"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB6B4A33
	for <linux-arch@vger.kernel.org>; Mon, 25 Aug 2025 23:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756166243; cv=fail; b=g9oZTNaz3U5YZKQFzM5rFBJMnrsz6FeqJRFVzEzCqZxArPciKA+yKBcA5P30+sB5vmPefgyHiX03FvAUVsvECaQwNha4qEbLMlVLXBByPJ1KmMWVeBJN5KupZZhiZrSIvFJLHhww6SC5cme922M6sI11FLdmyCV7lvAsUEdem5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756166243; c=relaxed/simple;
	bh=xwOhJxLKCgCIXWu9bnBTd17U7ioRSRe51zjVqcoJOPc=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=G/39L+4kqZch7HVvautnCVEHl6zQPvxozcBR1+5pDhK2Ri+5H2yI7+TOk7rG64BkPAC/l8UA8s4s4Ss7KDBwGkKFBlwPiPbRYB2nde64uUA/ZfZOiSsbESOW7I5GBEawmg3cVW0Pw6L0S758yj1//bDkXKY+HJY89zjCLD8dCgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KPSH29g6; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756166242; x=1787702242;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=xwOhJxLKCgCIXWu9bnBTd17U7ioRSRe51zjVqcoJOPc=;
  b=KPSH29g6LZd/Gqp5+mg16oDSGX+q8tChfCzGK+xC6K8X8gIR53ieLk6j
   neORdvdp82jvc8CupBq+yFrjHeVtuVFWXSkc/MvlGA/ixCmgfAb76C6gP
   2cHs1DzgdN/Yjf55oZaeQzejVmzYHAtEbylBbobiI08itzp07NvdvK3yl
   G4Y2MkfAQiK/6wcEcbQIJHfjB1HGZ+ll/+rKuuXavci1N1pFvK7vXOLZ/
   Hrb7TvD5SQus9DFn1Wi4quGpEDeGl3cY5g2etq5btHbdoD/EEK81idaWp
   anuU1DFKqsycZtCj5fuDPSlSkieA74EUGmBL437FOq0qMUk8Es9zStI6w
   w==;
X-CSE-ConnectionGUID: 6DjbJcbhSJeJErxTxl0OUA==
X-CSE-MsgGUID: uH4w/skpRYWHJleEOvpQMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11533"; a="75840846"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="75840846"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 16:57:22 -0700
X-CSE-ConnectionGUID: c44Of5wLQlytQ9iz+VMEKA==
X-CSE-MsgGUID: BcghnR7LSWeotmRDTGJe0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="168676590"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 16:57:22 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 25 Aug 2025 16:57:20 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 25 Aug 2025 16:57:20 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.65)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 25 Aug 2025 16:57:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pia+Rk5esj3AY8ywcCw67FhMx/ZPNoUgEtx5zbVUGrS/0FMcwT8hb8/xawo+dXIiiF9zPns6AbL77lEK9pkApVDDx0poR3f/3gqHEvuoE7ndRIdLB6s4/7HcHBcGBj91NXJhpE10Ap3OgLyjucG1xi0dj/ctP8Mv7DUYrnyVp2T2NDcMFsLvk4RHS9yKEG1jVpcF1UgQ1eIy2YAQNjq08YyUkHurcSnKO8yhX0DPcG/UeOoxN2/J+Iof0Gmmbb8SvGqHtfvGEmDLIlVPhIws8U2Pl2PVtM1ez4leRcqzYlIYgIxmpzdYJCxLM7/sboiDfWVWU+fQtKNVlhVvNdQ/BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xwOhJxLKCgCIXWu9bnBTd17U7ioRSRe51zjVqcoJOPc=;
 b=U1Ojk2bmlvVVJYeOk8jw8geI2nWjCB6/5hETUDu/w6NYfw+RthsSy3Jbpc66cnbaspP9+iDwBwrZhQ2guSQR/LdgwnODF2PlZbi2rEEMxZcEfsy0m8hB6z1tKgW27TC2ktabIN262WbzEu/PG9JWUoHyl2E+7LZZsnBshDKrAweGmSW8rgHFsd7goh2FLcXFftF+L9f6vxlDuHPPOVnJAsVFAoO3CCTnPAFFjOVcivE76x9nDHNC1nxKd8kFelYtRhUL2PWVkR4Jay6zv/tBw0TAa+0+EjRW/yEuQmMhBctkMn3WTAXzIRdz+PiWrvM6QQgYT8WFeYQ+idm9htbgIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA3PR11MB9487.namprd11.prod.outlook.com (2603:10b6:806:47e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Mon, 25 Aug
 2025 23:57:18 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%2]) with mapi id 15.20.9052.019; Mon, 25 Aug 2025
 23:57:18 +0000
From: <dan.j.williams@intel.com>
Date: Mon, 25 Aug 2025 16:57:16 -0700
To: Roman Kisel <romank@linux.microsoft.com>, <dan.j.williams@intel.com>
CC: <Tianyu.Lan@microsoft.com>, <alok.a.tiwari@oracle.com>,
	<apais@microsoft.com>, <arnd@arndb.de>, <benhill@microsoft.com>,
	<bp@alien8.de>, <bperkins@microsoft.com>, <corbet@lwn.net>,
	<dave.hansen@linux.intel.com>, <decui@microsoft.com>,
	<haiyangz@microsoft.com>, <hpa@zytor.com>, <kys@microsoft.com>,
	<linux-arch@vger.kernel.org>, <linux-coco@lists.linux.dev>
Message-ID: <68acf85c42fb7_75db100d@dwillia2-mobl4.notmuch>
In-Reply-To: <0e808267-7955-4a37-8726-2a4e3040dd11@linux.microsoft.com>
References: <68a4ddff258de_2709100ba@dwillia2-xfh.jf.intel.com.notmuch>
 <20250825222126.356372-1-romank@linux.microsoft.com>
 <68aceb1ad6569_75e310067@dwillia2-mobl4.notmuch>
 <0e808267-7955-4a37-8726-2a4e3040dd11@linux.microsoft.com>
Subject: Re: [PATCH hyperv-next v4 15/16] Drivers: hv: Support establishing
 the confidential VMBus connection
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR16CA0013.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::26) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA3PR11MB9487:EE_
X-MS-Office365-Filtering-Correlation-Id: 404fe19f-5de2-4d40-9051-08dde4331fbf
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dGgyT3FoNjRZSkY3d2tIa1poQkd5L1h3QmNCZlJmbkRUMzc0dndIcnBrZDVj?=
 =?utf-8?B?RVBBT3NYM0t0WW51dzh5MTJ4SEdvNmU5b0dDeWJkdEQ2a1ppY2lSVFBrYWdx?=
 =?utf-8?B?d1d4eTZWbjkxWVExa2lGT3lQMzdWSnI4SCtIYlUzVVcvUzVBT3NOZ1N2YlJm?=
 =?utf-8?B?VFNRRExIZysyRVoyN0JraE5qa3U0WGVrMGNLTnByU0dIYU90WWNyMk1RMGRU?=
 =?utf-8?B?dEVyTU5Dd0xqM2JNb2hNR3RsVGk1RGhRQkxZdFdPMHlYN2Q4VTc2SURmSzBR?=
 =?utf-8?B?OHZ0cEdUQTlCKzNUWWJncUUwSjc0TVhqeWtEeFJQRVo1MXk1THp4YitySFFM?=
 =?utf-8?B?TnFFa2NjOGtyQncyRWp2VFdnbWlzUVhhREpINlBoZHJGanlnNmVxMm5FWFVk?=
 =?utf-8?B?TjBaZVc2OVhGOEtVOXdSdXZzMVlVbjNjZFVnRmhEcnhJanJsZ3dtbFpCOXYw?=
 =?utf-8?B?MWVmMDJlK1ljb3NsRDJzZ0UydEg1K080TE9LMUJ5ajBZVU9XYW9TQ3hmdHFV?=
 =?utf-8?B?akJoWnBIaDhzeTMyL3hIdmpSY3ZtWExmeHN4aVFLS2I4djZBa0RLNG5hK0o2?=
 =?utf-8?B?aXQ0T21YUXo5ZWxGZ1E3Rzd3YlZBWWl2T2hoR2JyTTRya0RySXhHN3RTaVEx?=
 =?utf-8?B?SnEwK2tMRGwzdGZOM3htY0M5SFZ2bjNwaGsvdTdVdStSM1pYQVNIdWtPVjEv?=
 =?utf-8?B?VWtsSjUwcjBvUWNHNm5YTS9XaXdiSHdRR1NQNGpUMW1xbnNtVlU2ek1GYUNo?=
 =?utf-8?B?UG9mK0FKeW5LN1JIRVpOVGJQcDZiN050QVhIVUpaMEI1bmtDWjFhOWp4OW5m?=
 =?utf-8?B?ZndIMmxlZ2N6WG5zUnNrTitqQ3hvdXRQbis3bk4weGFVbU54V1h5b2FKN0dW?=
 =?utf-8?B?UTZXV01oMjZQR3pHY2ZqT2tFT2pKQUZMRm9kYmg1dmtza2FaZ25mS3Q1eDM1?=
 =?utf-8?B?RktMeU5iK0RNNWlYc0srMmsxNWRyK2pVYk12S0tzNGlqZHZSZFhES2VNRzlU?=
 =?utf-8?B?YWxlS1lRaDdyVHZOT0tKVS9jdkpoREZwYVV4ZVkxbXhZVTc0MGJuTHFZcEll?=
 =?utf-8?B?bDNySXFYd2JIQ2VCNE9kM0l2U2RuMWQ4bjZjaTdFS3EwSXRId2NxVGR5bGhR?=
 =?utf-8?B?aVVVam0ydDBYcGZzL0NuQ09vUC90KzliSzhGYXF1UXBTSHMyY2loQzFwS3lv?=
 =?utf-8?B?TDdDbHh1RnJWaWJpcWxNZnI5VnI4ZTB6Unpoa3lBbFdwUGtkKzZRT1ZBcnJN?=
 =?utf-8?B?UTVmR3RzK3FZKzFqOW5LbVdUVitsZ3NqNkkxb3FVOHdxSEFXelBXRkhEczhN?=
 =?utf-8?B?ellmSG5uZVE1RFJDdk4vWHl6R0tWMVN1VTV1eGEvOGg0UVRENURvK0pJT0xp?=
 =?utf-8?B?WTJ3dVN4SlZBYjREaHZrUStsM3hHakJaZmtjckhoU2I4ZlNaQzhEVTZReGNN?=
 =?utf-8?B?QVZadFl3TEtzcjV0U3ArbENiVW9aZXZLMjFkVGV0aElkVVMxVklremhsTk9L?=
 =?utf-8?B?djFmM09VSnFOa3pTM2ZaYmhOOUJTYmk4ZEdRYVpxWjlrMnQwTWNuL1JxaUpa?=
 =?utf-8?B?Nk1qNW9jLzliWW5oM0xOVVh6ZUZkRFpIWURwUnpUalFNLzMvSGlhN1RORHFK?=
 =?utf-8?B?a1g3V2MwdmZja2EzU0RWT2RWWTJvcEFBM1F5KzFKM3VGNEdsdVJzMk9BNVE1?=
 =?utf-8?B?M0VxU1NGOHpFLythTytzVWhrVG5QeGxodysxU3poVzZySmVBM3dZK0t4OHJm?=
 =?utf-8?B?WFFTY1RhZWVubTl6ejhEOWNWL1NIVzFONG9WN3h4UHdmazNSMUdoMnMzSXNo?=
 =?utf-8?B?YnkySFJJQnBmOGU4UmcvaWhxTjZUMWEzekJ5Ymh6Mll1cGVzbllFeDNiR2Zk?=
 =?utf-8?B?eE1Sa2MvaWVKZGdNN0NMWUFlM3YvOHIxbFY5a05vOUtNSGx6b1FsUm1OOGxB?=
 =?utf-8?Q?Ds02rdRLO30=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVlBN1pZcjlySHl0dGRUcUtjcmY2TTlOUStOZXBFK29aQzUrbFJ2V1VJSmxu?=
 =?utf-8?B?TzBsWHJ5cW1Rak1PaG9uQzFDUmpFbEdMajd6U3RMK3p1NVZMbjZ2SXBIeitt?=
 =?utf-8?B?NzhMNVlMd2Z4L0hTYW9mT3o1RDBMNGFSNzRpT3BrSmZOL25MYU5xYStPeTJW?=
 =?utf-8?B?TVJxNmpYYWFOanF6cDRXL2NIY0pWSU9TSXMxUkplSk1IOTM1RnBYUm44d05o?=
 =?utf-8?B?cUdlU0tHeWtZMWNTNGU4R1JoanJuNFI2VjhINjhLYlpLRjNBOTlWRVE5ZzN1?=
 =?utf-8?B?UVdRand4SGFoa1RmTnZSN25TRFltd1RiV09kRmN6ZENHUGc0b21UTjFwekRt?=
 =?utf-8?B?elloMTkySy9KcGZXdzJlaGlUMW4vcU12QVJZaEdIZmptOGlFMEc0WTJDek5y?=
 =?utf-8?B?Rit1dXZiUVluZzFRN1oycjNNam5VOGlmaDl2YlhSWUhCWFJzWElzUDN3Si9H?=
 =?utf-8?B?cWREeGlVRDJmNTM0UkFha3RWcDZnUWd3bUczSGJxdmtSV2srdHZBUEJJT0hl?=
 =?utf-8?B?N3VrMGZXaCs0NGk1bmVEMDI1NmVwUGVwVlRqMWo0ejlvT3IrLzJWQVBoRDZS?=
 =?utf-8?B?M1Bsd0I1U3cxTWV1bjZZQmRkeFp4RWJhUG5tZmRRSmIweDRlOEkvM3J1UzlT?=
 =?utf-8?B?dHFjSU5DVjlnbWUwRWlkZzFtaXkzOU1tK3JUN1pHRmhZRTJ0cWZMdkpFMkJa?=
 =?utf-8?B?ZnRkczJUeVpCU01LL1NkSnhLR05YNTNZeExqK3NYVThwbU1SSXFDcGxhSk5q?=
 =?utf-8?B?c3Jyb2lmbjJ4RlhVOVlMVTNsdlkrKzlQZFJ5bFZhTGxjeHI5WGViUFppQnpI?=
 =?utf-8?B?MUFxdkpUbTVsZGJpV255eU92SWNUTVpBZ1IwZW5vVmFvekhzSHR2V3lsdXg4?=
 =?utf-8?B?cEZpeHZsaGNtMmRNMWJnOGt0bE5WTXMrTk1aWjdFZVppWitESkcvUkFsaE9y?=
 =?utf-8?B?YlRoMDE3ajR4djNFOEMyckZPLzRhYjkvdmxVNHRTRnc5S1Y4QXBpNXdsUkVs?=
 =?utf-8?B?RnI0VWxRU0cwOWNUM0dBeHRDNXpDcXZqNDJ0S2ZBZEJhN3dlNFZrSlQ0NGV5?=
 =?utf-8?B?M2UvSjY0bk1WaGZsWmhDbjlybkN2dXEzUVdSY051UFFRaHBkUmN2VDhVWEpJ?=
 =?utf-8?B?cHFkcUQxeFMwLzB2SW16WkthcWVSVmRzQm1GT2s5NVdhOCtkeE5lcjJwY004?=
 =?utf-8?B?N2ZzMnFhMUNBcVJUdUs5QTVUMFRIQmZMMEIrZGdQKzkzdW1vK1V0eVdrL2Vp?=
 =?utf-8?B?NFV0TGdVckQ0eXYrUHlGTE1zNEFhVmpWeE1UamhoSWl4cFd3OXZnSUt4RVhs?=
 =?utf-8?B?dWFPL1JpKzgzRFpFSm5hbm9ZWFAyQTJ0TWsrVDhnT0djTDNHempzTjRKdk1r?=
 =?utf-8?B?aHJ5bWRreWVnbmlVeVhsSkFITmYvdFVUVG5wVFN5QW9qMUkxUW9uMXNBNElL?=
 =?utf-8?B?YktIdS80Q0tudFIyL0x5RDdBVVpQWHlnTVk5Z0hsV2F0SVF6ZlNNcVFWNS9B?=
 =?utf-8?B?MmtwbXFkVm1UNjFnOUNkbk52RllLczhPKzRMNTJsT2s3THZqSXRRd2g5aGU4?=
 =?utf-8?B?OUNzWktEOEt5d2ZtU3B3U1pkSzhpZGJiOVZrK1dIcmVwMjA3UmlvKzBWTGZm?=
 =?utf-8?B?RGVkaEtPM2ZSM1VQNklnOWljaEh6SHpnSDkwRk9QamFvMC9ZTkNJSnpIZ0x6?=
 =?utf-8?B?UUc3K0RjVldqeVFWOFhEOGEvNHRlNjJVcmU0ZlNuU2pyd25UZnhkK3FEYU5a?=
 =?utf-8?B?aGZieHRuZFRISS84SDRHZDdYN0N1U0I2NG9IcnJwTG5KZXZoUkp1T1hmUkNQ?=
 =?utf-8?B?WXJSS3NIY2J0dGdEcDVyRENITkNZUjY1UThRWjcrdXp5Z0h2TUZUaEtVa2Q5?=
 =?utf-8?B?U0tGOWlOalhBRDIxcnlvQkliUE1KZ2JHRFFTdExQcG1hTWJEcElaSFhHYlpE?=
 =?utf-8?B?ZXR2dnpVYk9SUjkrTWtURkVyTzRyVkdrTERrQ3NPazlWMEgzTnYxRkZKa1l1?=
 =?utf-8?B?RnczaStoeXFOcStRK2dUblRzS04rMXFSa3FacFJyS3lWNVpDMWo1VThuN0VI?=
 =?utf-8?B?MlU3ZnRQclVsM0w5S0Nvd0U5QkFOdkdydGppdnRCMTVCWEJFWkE4Y3U2NHRM?=
 =?utf-8?B?dWpMMVhZZ0FWQkErd3ArUmZPTlR4VGVOK0dRc0dMaDh5ZEJwbGlvaWFSTHNs?=
 =?utf-8?B?anc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 404fe19f-5de2-4d40-9051-08dde4331fbf
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 23:57:18.5136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fDCT9deEgHRrZJRShy/Ag6NON4IMxK7i9/KZ2AVSCIYBApaS5IXdb+IqRof69Ts8jiZ04maaMDAk2GbXxmuHKqglPtDooi8nM1+K/I3NLOg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB9487
X-OriginatorOrg: intel.com

Roman Kisel wrote:
[..]
> Trying to understand the question, thinking out loud. The paravisor is
> running within the same GPA space as the guest, the host/hv cannot
> access the CPU context and the memory assigned to the paravisor and the
> guest until they share the pages, the paravisor is measured and goes
> through attestation. From that, the customer has the control over the
> chain of trust. They can rebuild the paravisor if they wish to do so.

Ah, that is the detail I was missing the paravisor is provided by the
tenant so it could be measured by secure boot or similar mechanism the
tenant uses to measure the kernel and/or initrd image.

I also now realize this is not trying to enable device drivers other
than existing VMBUS drivers that do not need to have explicit knowledge
that the transport channel is now encrypted.

So, carry on, sorry for the noise. TDISP is trying to solve a wholly
different problem in its support for unmodified drivers without
something like a VMBUS abstraction to secure the communication channel.

