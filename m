Return-Path: <linux-arch+bounces-10867-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E752AA62286
	for <lists+linux-arch@lfdr.de>; Sat, 15 Mar 2025 01:08:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A6B516DD2B
	for <lists+linux-arch@lfdr.de>; Sat, 15 Mar 2025 00:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC49C366;
	Sat, 15 Mar 2025 00:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EHAAWgDT"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1C29450;
	Sat, 15 Mar 2025 00:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741997298; cv=fail; b=LsNm1XdykRZgnWIuG6hL7X7G70i/V2Mbsc6k0jeU2XynFw5BGDeh+YSqsIAxIy23zZo9im0y+35cy64H+rW8rs9eUoaRDYBmaoFntomVJEi1uJQ7gJCxsLp1/yWMoyNZO+VOYM0ZlGZZ/z/bXzm4WkbEDNL5UNkSw3avYPk70/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741997298; c=relaxed/simple;
	bh=D1pgaBv5jN5jtVEgHOXRBWtblrg9fFVH8luP72efHU8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XNPDZkSTGWSnJfReSdG2V04yFFpdH157JslXIE7XMrUKXCBT6NlgMVqxZS7fFhce1GCK/r3JcsczQ1faEXNBEGk1jizF5pAMXzmhJOOx13ZspjcsEcrywzlOWVy04++pI5hpR/kK4HE0B7VQX41Qb+9QdA1aQ64w32TmWvzGD2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EHAAWgDT; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741997297; x=1773533297;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=D1pgaBv5jN5jtVEgHOXRBWtblrg9fFVH8luP72efHU8=;
  b=EHAAWgDTyOf1/VMCitpsEZ+IivTfNqmlOHFCDVHtmnwYQRQcg1vvPLWU
   9+sllSzZygV2aqpLhmL/I1ldPXdQhummv3ZLGv/Oz0sXKj+UfSmyX6hBF
   eAdlKQMinnbfF216g8JX5xSt54D32rasmUQ8rlVNeitZNIpFqaqVUoWuy
   2vW5iyl0GpVmmE00qd4LCaA0UQlYPzdBRsWGA2DPduMsO/r2PRzNhIEkm
   i/2GaMURoZLH1wNn0YppI9CVBH/qVFCN03+ndP8YUm+5hzoXHS04Lwols
   7Xhufsv62OQpiMdsdffGd5ADZHPObz4Aww1tElUEOje1//D16GAXb+seE
   Q==;
X-CSE-ConnectionGUID: mrOE13DhTE+aFhRod7SZSQ==
X-CSE-MsgGUID: YZVEa9T0SE6BHqm/k9Xa7g==
X-IronPort-AV: E=McAfee;i="6700,10204,11373"; a="47062910"
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="47062910"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 17:08:16 -0700
X-CSE-ConnectionGUID: l2unhzlQTYWG5Jqrtyln9w==
X-CSE-MsgGUID: CcGW2VJRQOCq5c7RJ6vNdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="121458017"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 17:08:16 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 14 Mar 2025 17:08:15 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 14 Mar 2025 17:08:15 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 14 Mar 2025 17:08:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jNELbEipcRSVAFJ47Z+d08IeOIKmWlxUe3B2loQfIYwTYWaJ0UURGHC8zt7VKbb/ecrcciB6V31zvb0XfynRSTz4FOx4eQUDxDJmQwkWjSsJl7nFNP1esOaWgnerdUXo6PG+ebd0G32/iv5PYseJmAIxDdQwXJmALDDiAWOSN0RJzvv38eRNO4r+xbsSoA/iaYTXTkJTwuhLRc7u+u9myF0DmyBPNC3s+48463tniBCk+4nD1ary2DUjkWcE7sT9Ge0tyS39N+4CnRMFD5i4dleYpQ77xOtKvYexfm3H8T4Fd+gdVYQacwV3a55E+ZkR6G2mAIY8DrnZuTSExe0LZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GhlLl3MdMlODiymt2qs3eYjgh4EC809D577HogoR5PU=;
 b=XOu3cinKn2f/eGRz977jRapBSq8m9XPzBJKzgr1Z//RaZqn4sUaYzoh1E7NiALDxpAK9bEj9dTkG+Zgnx5wS9ifAR7Z6/GJgHbiJYA/HfPkvVWUwdmKlDcA4L3fl15J3M3hphJU9aFBfLerr48Pd97lBgj346lNk3N6it/04AycFMZWgoc46KmPhwdzRTipSwXLzrRuYDtQ7znXFtYupiHBX5ulS2j85ZQS7GArluMYDhkFsFYA05UpzFWiPn1/oG5eH2tZKU8boNgV92LEMeiXG9j6XL1S0HTepbPP96AjnJhVacUPNgJJAUg2HmbDHZAfqzSg/fWIl3q+G4lcWyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ1PR11MB6273.namprd11.prod.outlook.com (2603:10b6:a03:458::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Sat, 15 Mar
 2025 00:08:10 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8534.027; Sat, 15 Mar 2025
 00:08:10 +0000
Date: Fri, 14 Mar 2025 17:08:05 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Alexey Kardashevskiy <aik@amd.com>, <x86@kernel.org>
CC: <kvm@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-arch@vger.kernel.org>, "Sean
 Christopherson" <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>,
	"Tom Lendacky" <thomas.lendacky@amd.com>, Ashish Kalra
	<ashish.kalra@amd.com>, Joerg Roedel <joro@8bytes.org>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, Bjorn Helgaas
	<bhelgaas@google.com>, Dan Williams <dan.j.williams@intel.com>, "Christoph
 Hellwig" <hch@lst.de>, Nikunj A Dadhania <nikunj@amd.com>, Michael Roth
	<michael.roth@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, Joao Martins
	<joao.m.martins@oracle.com>, Nicolin Chen <nicolinc@nvidia.com>, Lu Baolu
	<baolu.lu@linux.intel.com>, Steve Sistare <steven.sistare@oracle.com>, "Lukas
 Wunner" <lukas@wunner.de>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>, Dionna Glaze
	<dionnaglaze@google.com>, Yi Liu <yi.l.liu@intel.com>,
	<iommu@lists.linux.dev>, <linux-coco@lists.linux.dev>, Zhi Wang
	<zhiw@nvidia.com>, AXu Yilun <yilun.xu@linux.intel.com>, "Aneesh Kumar K . V"
	<aneesh.kumar@kernel.org>, Alexey Kardashevskiy <aik@amd.com>
Subject: Re: [RFC PATCH v2 10/22] KVM: SVM: Add uAPI to change RMP for MMIO
Message-ID: <67d4c4e5b711a_12e3129414@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250218111017.491719-1-aik@amd.com>
 <20250218111017.491719-11-aik@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250218111017.491719-11-aik@amd.com>
X-ClientProxiedBy: MW4PR03CA0267.namprd03.prod.outlook.com
 (2603:10b6:303:b4::32) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ1PR11MB6273:EE_
X-MS-Office365-Filtering-Correlation-Id: 915105a2-ffb4-4114-ac67-08dd6355785d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Md2uz/PrQ+XGXecCeqYLxZ6iE9qKfQ2chDGczYRrInAIGaz1gG2BXkzkMJo3?=
 =?us-ascii?Q?0nrDABLnjW2ELFmcVmnf2ylubLoh2OuG9hVhiyayt6+XtZf84L9ao+kPF8aZ?=
 =?us-ascii?Q?jEy+8lhmjXfieDcISbJPdiNjKlWLf0XNEtnkvDYJw1gQN+AtSCeMCAsvdzLn?=
 =?us-ascii?Q?kMMewhPyU/oOrbwEkHwy3xXhhu+jP4U91HgZRiMTmtY7xNn1Ea3O549JTJAi?=
 =?us-ascii?Q?2hHGnwu6rr7YjRTlSKcbqPjSHvTSiMgU2lu5bchHBWFopae/mhXEZlbtlbHv?=
 =?us-ascii?Q?HiNVhSQPL7x8X64UbvqLbnMbSHaFapDorYN7XH1Db3M3OR7P7egPxNExdHCL?=
 =?us-ascii?Q?vr1EtzKblrPJnDxak9iJMh0g1dPfPDep+iEuaW2InmFj+ZxyM2SvcLRuTGfV?=
 =?us-ascii?Q?XFlk0snrpr4zAmI2UHipWIeYNCjLvIy3hG8jCrb/lwzHXHK9WKTYLC2nEZhR?=
 =?us-ascii?Q?k5h+0xpkEVKZj6zIG+PSR/KxaMuO/5LFWP2tNqJcjYrzuRqIbrStQJ+JgwPH?=
 =?us-ascii?Q?LXLaAMCAgzdhXwSRjHD8v+GzbdOBeeWmO5r/QI2dr5FgW44j5Xmh0qgqtyPO?=
 =?us-ascii?Q?swb/Ls1mHlL0dxvaCycKOWuH6n/eY+siKG5ThJhr31Lsk/GjXV077dx6qyq/?=
 =?us-ascii?Q?R5a8v9gWkHn5HFsMD6UivWy6R5sPERCh6GbZ/evipX2IbzLSFE6aSbqgvhXP?=
 =?us-ascii?Q?fgQylzkXScXsMgfZZJ+0UveZBm+348MC7uZ7ig0oPjsZJV2M+R9LHgUY+V6S?=
 =?us-ascii?Q?zt/Bw/uU7MvhiK5yBgumbPYT7bUgWxM6SoO5l1K0vGrNkcW3gGenuucIBsOw?=
 =?us-ascii?Q?XFEpCydW4uETlcXYlXIiA/Z2rzzOVr/frVQWn9ey9QZ50svKKjnV6xfPKBaW?=
 =?us-ascii?Q?e4/VNWW+aH0o/u8Q34WEutNVQmmmuUvq2AqWOX30hNFdKUNefMcjPNYHnSZh?=
 =?us-ascii?Q?Foh4YI9tU8fmS1DqW+fIFqd05WVOLqe6JnbwPqmrYeYs1UZfMqTmESEf/XyL?=
 =?us-ascii?Q?tl+4C0XPVM0uTJOMDEE8llyqdyL+2f89+UI8kPyYBuS3oygwmqte6PeStNzo?=
 =?us-ascii?Q?NnPFyBRIrQPLxM7OxUM2W9ylM7KsoWg5gT8QJaQdktUJ4yVkqkYi2jPr/VvC?=
 =?us-ascii?Q?PIfLqM4g97o4rSYOTlKV85wKkcuyk+IrMpqC+p+smbJDc/RzMNBKMNqpPNQ/?=
 =?us-ascii?Q?5plsqB8NvanGj+Mk2tCpkFACdTQGessa0qtSR/wicx4Fr/QF1gN1rVlQEe7s?=
 =?us-ascii?Q?0+P0BpDRKJuDzMiN8b0zGvIbLU+jZvvMO8qRGubeL5Wnj2LHkeZ2XeKKCzfo?=
 =?us-ascii?Q?eqLClX62t3TFMPecnbXqjEgyZKnDpU3rq5o2WbCeGdU/Lg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Z7uTy6HIS9pn9lH7WsPZtdD8p7sYgxT+GLG4z3Fdj8AuWf3tu7eW1+ePd/0f?=
 =?us-ascii?Q?bXp44LQewRJ2QLhyVB7QsS/N8loTFuY6ojL2biYfUvfeGmOP0zUFe7tEFK81?=
 =?us-ascii?Q?EzGCVo7oAi3i/2pOKOxmUov9Y+bRRRVdWFZ71Lq6N3XddGPaYhbFZsPuz03o?=
 =?us-ascii?Q?A2umWYzXb+x4CourewHkd3uCCyXiQNEHc5rZ0/dmeUQns8qB9NYksvP60dvX?=
 =?us-ascii?Q?YZh+xwJjN2pxm38J8ZRyOSGqFszAkipIR20U/WQDD4JUAP+0/EgMr4J4//zT?=
 =?us-ascii?Q?BiD4bMr0+jp76h+C+COWeCefJYTkIrO59Q3Mvza8qS4X1xfFMvTsHPDzpGMc?=
 =?us-ascii?Q?aWnX36l1TNRUckLq66ffQ/Hmt07meJENu2A+A2AT+bfF6mKIlSeGctudVRHu?=
 =?us-ascii?Q?XuYSJ0T7E3Reuv+O7E/VWZcUL8T6N4xRM20DeZQu+bSsyD0u5dKFOBK0OWPp?=
 =?us-ascii?Q?A7YgLk+GgrPSkInHJdv2+AV75xTukLxu0vnCCl/+/Nt1CgBKF9IUfgc29GWA?=
 =?us-ascii?Q?NHK6w05Pq3eOLnjXlvaKLcartMxF4mzC79v0AFqzziFU0O3+9sE0TuE/kVAW?=
 =?us-ascii?Q?uJv7OlTbTPNNPIC9nJvfgbrp7vswze7u92pqmobLwD5ma+b7YQRABLhvtgdh?=
 =?us-ascii?Q?/Z92Uaf5m1uUnd4XbK48+s8ums/Jqxi5Olx2oFD9NKHKuP23BULxRAFkt9d5?=
 =?us-ascii?Q?hKMqQ8JQd2w4UTyeGrUBJfKfo/hhBTI4rWHCxmoEZ0seMGlZqpNx7pk/pBca?=
 =?us-ascii?Q?8oqo3MGSuCu6FcM6hFpxT3BDUJ+bHaLhR/h0riMmEdGXO6ACwEfONhiN1CrT?=
 =?us-ascii?Q?DjzxQ6LM2tgneh3YgxUoVsDxhVnfYgyqvG8bbeh3CkLLqA/soLkWal/VCpLt?=
 =?us-ascii?Q?uEnf+P2Y/NRcQyz6sp+v05FAzy6h/e9yVlI/38fJcf823lyZ3uQv1qguoiu6?=
 =?us-ascii?Q?oneB4f0uOw+vEHZMbJaCTDdG8V/+DjxA2psfyxUcKZB73MDDsRp+KaO/muA9?=
 =?us-ascii?Q?2G4O7LUT9TrZ5H7U8d3RUJ4X9v45CTzYmS23ZC0IbN7BoBWfN7+ZOyMte+DM?=
 =?us-ascii?Q?HblFxOoobXKZR6TQS+9hydmOF/AP5niRdH+C0CmKuYgiYzb7cKtDQSXqlHiu?=
 =?us-ascii?Q?xlnbMz2BlfGTa9bUMaecSj8mn9Hcgzd0nUGJzo3fAjOkjAXlGuRmidVMA8Gi?=
 =?us-ascii?Q?cZw8HzLLYpWJYyBK3fyiQcQPDaILhvV+cAt1fCPiWenD8qZtGsAm3LE2R4mV?=
 =?us-ascii?Q?Q/hpXpVBN93M0zSSy83BKNsyBAKNf0XbEXePrDsAmApozp7Xe2NXlAFWbCdb?=
 =?us-ascii?Q?/dMJEeruzMVzNr6wsFJCIEXBFGWVei/bzMgtsx1UZQ6Rnu4zEKnv0wvlFf/8?=
 =?us-ascii?Q?1gJpFn6xkftjNlZVyQnhhTyWr6JhyHkq0Lo0+GJdtXXaRIzgrECiA2XF9D6h?=
 =?us-ascii?Q?OJevpTGUcIF3NvaLm1B1bMRBbd/63UzTWKRpGBFGBKJuZVn84fxDsFq7bkJZ?=
 =?us-ascii?Q?mS20Jt1wUzerCMiE6RTuFE0lR5/a8f6LG5rFVIuK+7XdV7u9PxlwzCUftChP?=
 =?us-ascii?Q?zNgd+sjTxMyf0svrHQvWa6HzsD7IeYbhpVND3MdFd7UHnvC6cSSa54ZQbb3g?=
 =?us-ascii?Q?WQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 915105a2-ffb4-4114-ac67-08dd6355785d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2025 00:08:10.0470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ztsWKyxRpIlERGAU3Fr2uhlXOX0gyMvlIg2LtNCWgnbQnqppt2T9WotAKqLqaNm10DCeB80zuuIRkbphAzslGSUzLr/KQYXmy5Nv0n1JX3g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6273
X-OriginatorOrg: intel.com

Alexey Kardashevskiy wrote:
> The TDI bind operation moves the TDI into "RUN" state which means that
> TEE resources are now to be used as encrypted, or the device will
> refuse to operate. This requires RMP setup for MMIO BARs which is done
> in 2 steps:
> - RMPUPDATE on the host to assign host's MMIO ranges to GPA (like RAM);
> - validate the RMP entry which is done via TIO GUEST REQUEST GHCB message
> (unlike RAM for which the VM could just call PVALIDATE) but TDI bind must
> complete first to ensure the TDI is in the LOCKED state so the location
> of MMIO is fixed.
> 
> The bind happens on the first TIO GUEST REQUEST from the guest.
> At this point KVM does not have host TDI BDFn so it exits to QEMU which
> calls VFIO-IOMMUFD to bind the TDI.
> 
> Now, RMPUPDATE need to be done, in some place on the way back to the guest.
> Possible places are:
> a) the VFIO-IOMMUFD bind handler (does not know GPAs);
> b) QEMU (can mmapp MMIO and knows GPA);

Given the guest_memfd momentum to keep private memory unmapped from the
host side do you expect to align with the DMABUF effort [1] to teach KVM
about convertible MMIO where the expectation is that convertible MMIO
need never be mmapped on the host side?

[1]: http://lore.kernel.org/20250123160827.GS5556@nvidia.com

