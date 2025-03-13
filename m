Return-Path: <linux-arch+bounces-10751-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 619EAA600A8
	for <lists+linux-arch@lfdr.de>; Thu, 13 Mar 2025 20:09:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB3023AA868
	for <lists+linux-arch@lfdr.de>; Thu, 13 Mar 2025 19:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19AF51F12FF;
	Thu, 13 Mar 2025 19:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EMGYvs4G"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCEC1531C1;
	Thu, 13 Mar 2025 19:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741892973; cv=fail; b=uIcfQO70ZCx8ns0bc+9H3MlXlmKzLffJgkDqAufvj5qCLKV+vRAITer5DQg53rcaPtWiowzQPznzPEtkh8VpXUbdTaxraUgJHFNbQCatFQw6s8fZLlS5vARPfq68SmsRORyTUA7CZWT924T01jHNdeoWDSt/EnRuHIr09bXINTk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741892973; c=relaxed/simple;
	bh=R2BfbirKiwSynoK4nD4EXCBFsqSFVW+q5yMZEg521/M=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ouTP9dAUQN2s5YZGTfhNzobjvOnIa3Sf1ADSb46rZt3lOME9Qu5EHmXvEcmSS4OwQwzPDl7qj7NIgEhh8vMaqgovG6M8oSZR7ynoPohxHaSDGA2lZHKliaSByIPmLWShws/9DYpJbaOJhYKjqfScIXMHpJNppLiZT2e01mgP9rI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EMGYvs4G; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741892970; x=1773428970;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=R2BfbirKiwSynoK4nD4EXCBFsqSFVW+q5yMZEg521/M=;
  b=EMGYvs4G8hOl5XniFHrHQYicHCogSXiQmakJ+vPdDm1EXNP7apbYwkLm
   xwUe+Y1nagJU7cOKwlJi+KutZITPCIeaArB142umD2fllwpR3em3rcT95
   0CuDGU3By01zVuBIpyscvaz7NCCBbHMOJ4G3JFux9M9N+aMV4OtOwRn+N
   B2rhDqnNSOqE60NxUkzhY7R10b528jQutCNcQ3HGcuJlQJogmY/xGXf7t
   XoIm5dtqwL4udxKtWxA2zUMG8mDCon4QkhGrfXFqdGsio1+r4qmipf660
   ynnsvTJN7fJplvHFot1KLCYVkpvOT/s/wtGxXyuZ7kbUF6eLJhZTLJlzw
   w==;
X-CSE-ConnectionGUID: J0oPqjIKR2WFluDwjecYfw==
X-CSE-MsgGUID: ig/hHz+DRMidtLnxvjQviw==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="60432641"
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; 
   d="scan'208";a="60432641"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 12:09:29 -0700
X-CSE-ConnectionGUID: 7A7zNTOwTeWVPiGmCmlLSw==
X-CSE-MsgGUID: OA90VCHZQDyCbqXMPEQ8jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; 
   d="scan'208";a="126091618"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 12:09:29 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Thu, 13 Mar 2025 12:09:28 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 13 Mar 2025 12:09:28 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 13 Mar 2025 12:09:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FCtjrDVqLfd4T/TKAyzs8CVxhjn88hZ4buG/0BAnDmO5Yzeztmci0dh+o4CkEIauxFnuaNCnL3eBr24ToqtPcxSgZ6oZWTdkOur+0xsifhVOlMVKp7qM9QpLORaOpAVqq/V5ION2WKo/SX0evJIV7J5z6kDGGq7f9fnoSHNOxSYMu2X2K/7V9AAIbi7kg/I9shiw6JgQXnEX8AGQ6lliJXka5UoLH0ASMYQ+e5nbhpTHBlnYKV9AH+2yqVZD9eiEz+gk8bP4K74uM9utu1htCSaxrSY+U0VCrCOgSGjQdeTQG8B/Sm7zkLbztuFTfAPeejylVy/5PrQc4eA7AYrmmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CHrcVssxYu1BFhUPVRywLBBc28BDEO6ZfnU4knmY8lM=;
 b=QSkhXwDHPnxn8DU+iV6TKYCKETmNs3p1DD/Sj5jCZyi01Wn4FoZYt2t40Lj/G/CP9o0kvJoIlsJI6fDK0rWQHQw0/W4hxK9ayQK50opxe6wntrltGDvTFy+JUvdRMhZKeFBmOoTcsqym+rr4gf2/MmZAu0q0OA1QmGfgBe4dKPusMcB769D6bJ23TB17Dvc1W9btoxRYoCS0FvN4BpS2kbSRi0rNPj+tPTgtl+6N85Hl/4CJcAoqgBs3jzvvsSWStqW/JnCyF/vFFCz5/vg267he3zcE3rR61zyFqPE6g18U2SS3PJDKctHsO+XYp/o2s8FPMcjciEMVDtzLxKouxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB6504.namprd11.prod.outlook.com (2603:10b6:8:8d::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.27; Thu, 13 Mar 2025 19:09:25 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8534.027; Thu, 13 Mar 2025
 19:09:25 +0000
Date: Thu, 13 Mar 2025 12:09:20 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Alexey Kardashevskiy <aik@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, <x86@kernel.org>
CC: <kvm@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-arch@vger.kernel.org>, "Sean
 Christopherson" <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>,
	"Tom Lendacky" <thomas.lendacky@amd.com>, Ashish Kalra
	<ashish.kalra@amd.com>, Joerg Roedel <joro@8bytes.org>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, Bjorn Helgaas
	<bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>, Nikunj A Dadhania
	<nikunj@amd.com>, Michael Roth <michael.roth@amd.com>, Vasant Hegde
	<vasant.hegde@amd.com>, Joao Martins <joao.m.martins@oracle.com>, "Nicolin
 Chen" <nicolinc@nvidia.com>, Lu Baolu <baolu.lu@linux.intel.com>, "Steve
 Sistare" <steven.sistare@oracle.com>, Lukas Wunner <lukas@wunner.de>,
	"Jonathan Cameron" <Jonathan.Cameron@huawei.com>, Suzuki K Poulose
	<suzuki.poulose@arm.com>, Dionna Glaze <dionnaglaze@google.com>, Yi Liu
	<yi.l.liu@intel.com>, <iommu@lists.linux.dev>, <linux-coco@lists.linux.dev>,
	Zhi Wang <zhiw@nvidia.com>, AXu Yilun <yilun.xu@linux.intel.com>, "Aneesh
 Kumar K . V" <aneesh.kumar@kernel.org>
Subject: Re: [RFC PATCH v2 06/22] KVM: X86: Define tsm_get_vmid
Message-ID: <67d32d60bf4f4_1198729418@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250218111017.491719-1-aik@amd.com>
 <20250218111017.491719-7-aik@amd.com>
 <67d23a3e6667_201f0294ed@dwillia2-xfh.jf.intel.com.notmuch>
 <7719c1ad-84b8-40e2-9ce7-93248a410ebd@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7719c1ad-84b8-40e2-9ce7-93248a410ebd@amd.com>
X-ClientProxiedBy: MW4PR03CA0209.namprd03.prod.outlook.com
 (2603:10b6:303:b8::34) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB6504:EE_
X-MS-Office365-Filtering-Correlation-Id: a03ad3fd-34d6-4226-dcb7-08dd626291dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8ujD0d7yD0uFS3TTf/SrIL2N4Q6TWWfRPtjKp/LsXukDbpUGbf3AljeyyyDZ?=
 =?us-ascii?Q?ZHMCmOc3/YuDfQMqCxATMMv3BIyQqv8aY7DSPQBKXduBzSaL6AEugB0K/UQp?=
 =?us-ascii?Q?cEI8DXr6HSF7MQiT4FaZaUMwgmUNW7dc643/GZvJTrBonU0JCTGi7Pplcf2g?=
 =?us-ascii?Q?mGNG27hgCs/HvUCIGH+yN4K6Gg6txepuBgHPaDPv/e/sRp+IUZSdxaaEAxFe?=
 =?us-ascii?Q?QTN1fz4Xah69AfussyCNrAAVA71GMun1yAgYwJFLmoO6qKQMd0dVpgs45L9l?=
 =?us-ascii?Q?V93sBYEbWOFIUW/P3m3ILaeFlXC6NlezBymkalmvoweHXUj2yQPmC7uXZTLd?=
 =?us-ascii?Q?+72nz4JAkxh2vq97ZpAMtVfx/aHH+y+9PoXCYyCWrPqMriX6uvNDGHejNcHd?=
 =?us-ascii?Q?t84RbSt5ZZMnEqDoABGYOIEGs8iQGuUsI+z2u2OUAYJviWT4j7rRD8jB1BSn?=
 =?us-ascii?Q?uL7ldgRvdBFe70lUCjAd+2UUbaAGLCiA3oHxNoLFfS6H7Dp8q6ZXRFE4sey8?=
 =?us-ascii?Q?hVdIJkHQRRbvjHov9YaljXlsxSd2W74K1o2wB92CnB6rdyfUuh3QRMMvH67a?=
 =?us-ascii?Q?gA5H9MppkiUAa9a3JkpHp8FHBPvnzG+RVhpMgmBcQvRWopBIhpShSir1qIC5?=
 =?us-ascii?Q?b9+YaW1/DrAi8pNNX/a9ewsE5IlAuFgnQLs8obwitZe7imDt6zNZqb0vDaXo?=
 =?us-ascii?Q?M/kz4LZWsENbV/Zqb4Wqkk7vuzfuEQCje0E7+JTr19B3PV7eSex3sZRVIy94?=
 =?us-ascii?Q?LoonBUNuKF2WqHYhj4GyFwPRt3KixWabiqA2UmsqNGAQ1R9nmew87kShs/6a?=
 =?us-ascii?Q?HBu1rhMhQcDO8BpdCUjj/tsbt+JlTzba4z5KeOW+PChtu2AScFvSyuO8FkIn?=
 =?us-ascii?Q?0WP3CyKkRksDcWCuqr3xk9HFXeiBLFf7SrI/TT9NtrLg7GEXpoh8s8o8sljr?=
 =?us-ascii?Q?zgjxHcnw5gZDeWirBdQItJ2xOAKn4LWbviA0W5amp9yWRtGSjzrGIfJ4EAP4?=
 =?us-ascii?Q?S+Ql1J++7EM+ZQK92C6Lzn7OtB8xU1Ruige1GE74gs/wRl5rsrHgPpw2YRbf?=
 =?us-ascii?Q?yn765R4h/58Yroj+s/LVJBjDOJH936QtA5mHm9ef1v7AgnUh569MufQ/RHB3?=
 =?us-ascii?Q?aHIe3fa00EE04fY24H2QLtz3D5hyIBlbkV9mqXQF9I5CLDGMcbk02yFnn8Tq?=
 =?us-ascii?Q?dncBfBqDwbPJ1kRaW+i9hV1bPlTeb64bnWeW0H0y9s33C00xx+FRUCIs2laU?=
 =?us-ascii?Q?pk5p3eug2hc6aHWZoZlEA3rzZcbCG0SD9SJtqkyUnfJqzA8La3mUQW4ytujF?=
 =?us-ascii?Q?HbFPXNTHfiok+fIL9kQeIWI+O3+rwonPv8Iavw6dWHDTtHfzg4PUq2WTCgVc?=
 =?us-ascii?Q?6eADZ54QiaaJfzZaqh6BYYaqXMLA?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R1A+guZrrXbEpcQx+8wKLp5fDJFl9Pu4bg8/ui6bG6lbZPKBysI8bOgRuIZc?=
 =?us-ascii?Q?R/HYc2mLosfefAuHX3ns3bB7YdeJ2phSBguC4KJ6PBg+ewlGlbma88+ukQSM?=
 =?us-ascii?Q?2Qt7rmP6xpFU1Gfzs//wdzYiqoNSxwt8B9rxGUObwGPQpXbsO/NG4r74sxdH?=
 =?us-ascii?Q?qkNvrjxoQkaf8pQfXGCF25R16xs52tAhYe0xHPg13fFcjKeiG/qHRn1/B5wp?=
 =?us-ascii?Q?WR8V3DDT5POGPRl3sxw+r2+2cnvPDQVIzj4GqhR5jdYc47NrVF5qUOHHmmit?=
 =?us-ascii?Q?5eAsN4eJ661baDVLz+FMF4mkhqMJcNleXNXcuu0ke6ppJ96+CtLc30F9f362?=
 =?us-ascii?Q?2FTsKgvZ22QxzMqwVm/AYd7xltcuKy1a5kpy3QmBYTzRr3arLpYMkPNb4slD?=
 =?us-ascii?Q?RkbT0hJ8UO8YenpSfermwB1n6+sWEfnsGW3nMj7oAEc/AJLCeVcJNyI7tK+q?=
 =?us-ascii?Q?o+miAmw72LXyl47umI00sHi6NOduf/f9UqbsEcDFETNOgmPLx+NC0accxDq9?=
 =?us-ascii?Q?MwxfaPUJLV1Ln0fvS18+e7Aa+gU7fRfjJg5GHkZuJj2Yy3fM+tU23b/GcPPk?=
 =?us-ascii?Q?jPn0HJ/oMwAb4FE8BGpkOdMA6fEo8ejinSc76JaqI/FrApJ2DTU2Cx4SMERE?=
 =?us-ascii?Q?k4fR/7IOyG7ZHH+qhY/kegnDdkfPFQHz/mXGw1IhoQJLFpQVdCQSEufwLQyz?=
 =?us-ascii?Q?PnqHWiQNhUNh6nnqYwvF1aDGq6sI0J88gBL2cubVnQL9H8lg+/CBcRq63sPR?=
 =?us-ascii?Q?ri8riqKnEcXqBTMYFJ7MMBo82YUhYVTbIKm21VUS7Nr4+/UX83s5OwY7hZa4?=
 =?us-ascii?Q?agaJLSTzpD4buRh7lJ43cO7l44OGg3CYora0mo0+WKl+u0Q/cbOmyVlLaaYy?=
 =?us-ascii?Q?/Zw0TAwG/LAx6A4oUSW/0r2wmydbUgsJNhreA7AKQ5IH0jNjM9WUrPSqQFmD?=
 =?us-ascii?Q?sP2DfWhViKJ7nxv0KC+zcOiYzN1tww4gi0/x1//3MnXaql+Wv+G6VrbCmWRD?=
 =?us-ascii?Q?nliy4PCCof1KaOrnD7BTu8jX5vFUSpSYz7m2CgHIecQWVP3NiZ+EZbVpRSlL?=
 =?us-ascii?Q?fWep/Yto2Z1mPKsohjakP0iT63Wx3BsKLtv6nS571vQ5EdGI1RMbDy9Di6CU?=
 =?us-ascii?Q?vLNbvinkRTO/vS6vXRP+CyZ6jhv+Bb1ahaNjaqcDSvcTJf7mFaaWJMsWt9Dr?=
 =?us-ascii?Q?JtT7WBPP4sVKIvsP1wTzfDLK05iWr724FGp7Ymn8SVcfna7SiMu4751JB229?=
 =?us-ascii?Q?lfcKcXVlcczVdMNsZBx/pT+jb/4sN3uiqXH2rIVJ8103ZgsG9Futw+znJhYH?=
 =?us-ascii?Q?cLx9uu6EtPICh5BSnAj9kdZkYwzRyZWAQohOLETZO0VFklr23CN4MKha/16A?=
 =?us-ascii?Q?Gb/dYbJAcQbMoRoQ0msJX/Xcat75uuHcgg457uKnYUutClrqDfxuRLTyC0hs?=
 =?us-ascii?Q?2IwQ+6FvSfMB2+3ImTKTbMwD3oHO4axXXUnIdKYCBlyHKWlbUBlVRAvsKbmD?=
 =?us-ascii?Q?9sU85UOQeF+D0XC5RPsd56XehkaqD161X36XPtKAe6EgauL+fzK10trwr6rQ?=
 =?us-ascii?Q?Uw2eYstUbzg/oEiY0s97aavJihTPF14v6JPkJ+Kq0uBw74w0GoyODviH2u+l?=
 =?us-ascii?Q?6A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a03ad3fd-34d6-4226-dcb7-08dd626291dd
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 19:09:25.1432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3BVIJv/g0yBUgH2a5dR1lHLwCJDaMupHSPUH8wqXqnS3bjH0goUic+V4IUQWCgVoIHLjG5+q3EYCBqAfMUD5b4wpLC1TU3gJcEWXJ+4NYdI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6504
X-OriginatorOrg: intel.com

Alexey Kardashevskiy wrote:
> 
> 
> On 13/3/25 12:51, Dan Williams wrote:
> > Alexey Kardashevskiy wrote:
> >> In order to add a PCI VF into a secure VM, the TSM module needs to
> >> perform a "TDI bind" operation. The secure module ("PSP" for AMD)
> >> reuqires a VM id to associate with a VM and KVM has it. Since
> >> KVM cannot directly bind a TDI (as it does not have all necesessary
> >> data such as host/guest PCI BDFn). QEMU and IOMMUFD do know the BDFns
> >> but they do not have a VM id recognisable by the PSP.
> >>
> >> Add get_vmid() hook to KVM. Implement it for AMD SEV to return a sum
> >> of GCTX (a private page describing secure VM context) and ASID
> >> (required on unbind for IOMMU unfencing, when needed).
> >>
> >> Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
> >> ---
> >>   arch/x86/include/asm/kvm-x86-ops.h |  1 +
> >>   arch/x86/include/asm/kvm_host.h    |  2 ++
> >>   include/linux/kvm_host.h           |  2 ++
> >>   arch/x86/kvm/svm/svm.c             | 12 ++++++++++++
> >>   virt/kvm/kvm_main.c                |  6 ++++++
> >>   5 files changed, 23 insertions(+)
> >>
> >> diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
> >> index c35550581da0..63102a224cd7 100644
> >> --- a/arch/x86/include/asm/kvm-x86-ops.h
> >> +++ b/arch/x86/include/asm/kvm-x86-ops.h
> >> @@ -144,6 +144,7 @@ KVM_X86_OP_OPTIONAL(alloc_apic_backing_page)
> >>   KVM_X86_OP_OPTIONAL_RET0(gmem_prepare)
> >>   KVM_X86_OP_OPTIONAL_RET0(private_max_mapping_level)
> >>   KVM_X86_OP_OPTIONAL(gmem_invalidate)
> >> +KVM_X86_OP_OPTIONAL(tsm_get_vmid)
> >>   
> >>   #undef KVM_X86_OP
> >>   #undef KVM_X86_OP_OPTIONAL
> >> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> >> index b15cde0a9b5c..9330e8d4d29d 100644
> >> --- a/arch/x86/include/asm/kvm_host.h
> >> +++ b/arch/x86/include/asm/kvm_host.h
> >> @@ -1875,6 +1875,8 @@ struct kvm_x86_ops {
> >>   	int (*gmem_prepare)(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, int max_order);
> >>   	void (*gmem_invalidate)(kvm_pfn_t start, kvm_pfn_t end);
> >>   	int (*private_max_mapping_level)(struct kvm *kvm, kvm_pfn_t pfn);
> >> +
> >> +	u64 (*tsm_get_vmid)(struct kvm *kvm);
> >>   };
> >>   
> >>   struct kvm_x86_nested_ops {
> >> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> >> index f34f4cfaa513..6cd351edb956 100644
> >> --- a/include/linux/kvm_host.h
> >> +++ b/include/linux/kvm_host.h
> >> @@ -2571,4 +2571,6 @@ long kvm_arch_vcpu_pre_fault_memory(struct kvm_vcpu *vcpu,
> >>   				    struct kvm_pre_fault_memory *range);
> >>   #endif
> >>   
> >> +u64 kvm_arch_tsm_get_vmid(struct kvm *kvm);
> >> +
> >>   #endif
> >> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> >> index 7640a84e554a..0276d60c61d6 100644
> >> --- a/arch/x86/kvm/svm/svm.c
> >> +++ b/arch/x86/kvm/svm/svm.c
> >> @@ -4998,6 +4998,16 @@ static void *svm_alloc_apic_backing_page(struct kvm_vcpu *vcpu)
> >>   	return page_address(page);
> >>   }
> >>   
> >> +static u64 svm_tsm_get_vmid(struct kvm *kvm)
> >> +{
> >> +	struct kvm_sev_info *sev = &to_kvm_svm(kvm)->sev_info;
> >> +
> >> +	if (!sev->es_active)
> >> +		return 0;
> >> +
> >> +	return ((u64) sev->snp_context) | sev->asid;
> >> +}
> >> +
> > 
> > Curious why KVM needs to be bothered by a new kvm_arch_tsm_get_vmid()
> > and a vendor specific cookie "vmid" concept. In other words KVM never
> > calls kvm_arch_tsm_get_vmid(), like other kvm_arch_*() support calls.
> > 
> > Is this due to a restriction that something like tsm_tdi_bind() is
> > disallowed from doing to_kvm_svm() on an opaque @kvm pointer? Or
> > otherwise asking an arch/x86/kvm/svm/svm.c to do the same?
> 
> I saw someone already doing some sort of VMID thing

Reference?

> and thought it is a good way of not spilling KVM details outside KVM.

...but it is not a KVM detail. It is an arch specific TSM cookie derived
from arch specific data that wraps 'struct kvm'. Now if the rationale is
some least privelege concern about what code can have a container_of()
relationship with an opaque 'struct kvm *' pointer, let's have that
discussion.  As it stands nothing in KVM cares about
kvm_arch_tsm_get_vmid(), and I expect 'vmid' does not cover all the ways
in which modular TSM drivers may interact with arch/.../kvm/ code.

For example TDX Connect needs to share some data from 'struct kvm_tdx',
and it does that with an export from arch/x86/kvm/vmx/tdx.c, not an
indirection through virt/kvm/kvm_main.c.

> > Effectively low level TSM drivers are extensions of arch code that
> > routinely performs "container_of(kvm, struct kvm_$arch, kvm)".
> 
> The arch code is CCP and so far it avoided touching KVM, KVM calls CCP 
> when it needs but not vice versa. Thanks,

Right, and the observation is that you don't need to touch
virt/kvm/kvm_main.c at all to meet this data sharing requirement.

