Return-Path: <linux-arch+bounces-10692-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AAC2A5E992
	for <lists+linux-arch@lfdr.de>; Thu, 13 Mar 2025 02:52:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2FAE3A9CEE
	for <lists+linux-arch@lfdr.de>; Thu, 13 Mar 2025 01:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1632AD31;
	Thu, 13 Mar 2025 01:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QsVL51oP"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70436FC5;
	Thu, 13 Mar 2025 01:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741830729; cv=fail; b=AdvxxtXBCkeIWoTU9P9NwzJGvylBKWf6ZRDjmVs7KxswELhXmebrFn0Srp3ZC3G4vANC0OiluboOH0zyMNLx1KlQvMe+/EblH80M4VB4X2QcwRU4DDyuwhG1LfXkgYB8qbnbvRuRcqdcm03qMx0GBCapdLG/qwAr4sacZYv8aso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741830729; c=relaxed/simple;
	bh=PzFmJ6VS+xtrPGvGN9F9icu8NZYRQDGJpvXx89kQ8zE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RjD1Bo7LsQmR68x94PlmV446jg8tllXdjnKDnoV9Z2L0cGWqs+KXiobGjI3lBMqz23CgHwaD6fcvhbaNhzGhQSnwuOwLVg8VwBLUUNivo6e1DVDxrUc2+pPkpk4NHPx/MNSpxfgi2PZQucStDZy+S0cPaLCu19VkEhU5KQXRDwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QsVL51oP; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741830727; x=1773366727;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=PzFmJ6VS+xtrPGvGN9F9icu8NZYRQDGJpvXx89kQ8zE=;
  b=QsVL51oPSUPPBTIG+rUKkl19QWi8BFE9yp9DmFHBAMDS0w8fChi40PYx
   Nzi6YSyWS6XlMbHet24/L66lXDf7N61/5687uLPVMYvE84Ay5FdzUgy73
   v838NAwLTf/CLFOW6TzuXQ4v3Z9Agt0hSnPvIZ5cGLwEXPI/PbuhSsr9P
   SE54X6q2sMcRCgVZ0tJHOGW6bhJpPuxk3R6bbS69lHJ7Zc65EOV6Y90Hr
   rMPLsPKTE71jRhXdsAiyIz9rXQkyIEDHg2QTL7EjQm93PG53102ooqA4M
   MN7s7gFJVAPporjHVYVs1JPumGlKectrqtM7Tm63ZTiXxHZ6XsobXGMVl
   Q==;
X-CSE-ConnectionGUID: rk2nRVKMQNuO3ixtFVkNFw==
X-CSE-MsgGUID: 4pS/timvSOmn+YcHj23qVQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="60473420"
X-IronPort-AV: E=Sophos;i="6.14,243,1736841600"; 
   d="scan'208";a="60473420"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 18:52:06 -0700
X-CSE-ConnectionGUID: Iax6tnZ+Sf6GH4kpQyuEjg==
X-CSE-MsgGUID: F9qzUElmRPaRTNIMaZQRRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,243,1736841600"; 
   d="scan'208";a="125680671"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 18:52:05 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 12 Mar 2025 18:52:05 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 12 Mar 2025 18:52:05 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.47) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 12 Mar 2025 18:52:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S61gjNkEW3ByxMpxvaXmImx3h2ta5Txnih2DZozYcAqL2eLqUnUhF0TYyXzt34Bx6TwsBx8xdrvMJrmnHlgRVY+xRSn+45WKZvbA3s9w7oX6GMMM5KErTeefsniaaHjS3jNoToiWpjo2lJ8Km53c8xPvjQMYqdfNU0lNlKxvM64y5yn8HJ/Y7QLri5busy4+hGtDzkrafBgMqlsitgnk0IEGPw6Df5SGuBK/rlsJ2grTFTg8FmHCnQ/O6NzUvQtjYiBt/cEEhY31cypeEMSQ60MqKIEoR2TMKI88dHcAr/f/LPlpUMGAqJgWF6GUdGwdydv0ba9QWasAIGOVdCKFkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N92Uhwxduc17jaelL64DhUPIypmGVNLXLO9gmHwIzbE=;
 b=tQpHcC0rB3HdX530xhxqM3W035i4ww+8RuJ6fenUn8wEa9ZghfWCUt7ejD/bNF0UBB4v6UVM0A9qTXEz/D7XuHRyppTVP/nD87XYZYCCnCNzUAdhBgVjT/6oI2AF2TP2vJyau/P+StmHpX1+EzedMkSvLnUrhxsNn8+eINQHZ7zWhvaHuQFMO8X+aCSt2kEuq5ZHyjfReCf3ecswXsympony2xdsx/PfUX+EJOO7EwsJJD11hEWPQjVAF+H8Z+U3a2AzwYBIC2M3oJl7Ohs2MSX28fauqyfXYBcDreguAwr92agvZmVoz9iw11WBRBth0Zz/U9A8t7PZ05ANBJRUCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW4PR11MB6864.namprd11.prod.outlook.com (2603:10b6:303:21b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Thu, 13 Mar
 2025 01:52:03 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 01:52:02 +0000
Date: Wed, 12 Mar 2025 18:51:58 -0700
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
Subject: Re: [RFC PATCH v2 06/22] KVM: X86: Define tsm_get_vmid
Message-ID: <67d23a3e6667_201f0294ed@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250218111017.491719-1-aik@amd.com>
 <20250218111017.491719-7-aik@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250218111017.491719-7-aik@amd.com>
X-ClientProxiedBy: MW4PR03CA0085.namprd03.prod.outlook.com
 (2603:10b6:303:b6::30) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW4PR11MB6864:EE_
X-MS-Office365-Filtering-Correlation-Id: 607cc6a1-4ffc-400f-72bd-08dd61d1a664
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bYx6Wa8kItd/kMfeZqj3vL1Ks9MjmPNB1aQbWAIo7iCeIvKqbeZgDsLtzUz+?=
 =?us-ascii?Q?/CQiXcOlNucEhR+uu6vxIR0stfzylju7j0n7dODBEXhVWO4t7ef4pkvAf+wt?=
 =?us-ascii?Q?N1+59UjpmsBEXNV1VxD6yViGsD7GkBX3j4a7Yb3AbJPJxKOGaMhpvhFD6e3M?=
 =?us-ascii?Q?FMGoDMt4t+pI9fwi3WO98dtaX12YOWev0CkcMlBTtiG7JwuQVpaetbldLZqj?=
 =?us-ascii?Q?FdmXt98dphSPIusg+tphoJUoJhDlNf/d1rq73xXgWHHabIp9em1e2okYxqtC?=
 =?us-ascii?Q?/bKM4ud+GQFWWm+Ktz2dpPSsXzcYpl4DCq2tIacvgA0r4yWP6loH5F17RMl9?=
 =?us-ascii?Q?61dHmYFUZl4EW+/glwB+LnskQYsBIR05zacAprfFYgqrpg2p4/TxHSrJnRGa?=
 =?us-ascii?Q?TE4y9qMJV/2AKi3f35oYQFpdQ67/XGPMK3/Z+5SGvGVT78BBQlVugbDCaWFg?=
 =?us-ascii?Q?hNxO5FuojCU1m3MjhFG3muLOwBLTJgt7rxObwZC31P+Mad1UojiH+ZKWbv2p?=
 =?us-ascii?Q?foo3esGDvjGS1q7wWx1xXs4A1uslntJ7LMgghXfyFCSEaES4n+UrfaAB34Bk?=
 =?us-ascii?Q?1eDcdFKbd6cLZ5XcoPNZjh2MsdOmOQW+gkjzLx3RuREVZxfjzcX3TFBeKx+4?=
 =?us-ascii?Q?QKriMxadNYf51DXbJBnuluf3wHnrMUSq1eDVKlOPfMMIr05KeLpyJoFVau3K?=
 =?us-ascii?Q?pLOEApW24f/yJMY4YpHVYijj/ZH7Zy0GyCWImWWcK4VSXw3EMyze+Xu9p9TM?=
 =?us-ascii?Q?xxS0x8LqXr6w3tHPZxikwwbEhWR6ETDQwgeMBc8Xu9kYe+ZFgdaSqRpnHB/K?=
 =?us-ascii?Q?pKvA7QHt6LyonW3nd5UwqBo8bvfgdRcR4EUiJQ/j4Hl/6JYEw8XWYi4v+uLg?=
 =?us-ascii?Q?PTWWv2+mPbxOKeAJLP33aox3fmYtgmPLk7LMk/psm+/1Q6QeFi8d0d1QNSYn?=
 =?us-ascii?Q?F/OJO+v2i/cjxuGmUNVfiyzefwzO+48yehE3k46AT2pTY1KlhnmRvrH08bvM?=
 =?us-ascii?Q?EfmdgDW3Az2XomZZ7PJNC3pKVxiHl0gWDaSPDlWqf6Of9jj8iFtAvMme6/yY?=
 =?us-ascii?Q?1zfGrMFvPCXZe46xKG5Z0TlT4OYrredLc3oJ+5lw3ikx5XSAxresJeP1Saw8?=
 =?us-ascii?Q?gzjDvPN4E5Bn1uYbG+POkqKGWhufKhts3qVCDPGDkSLZmlAUW2+UIBJAF80R?=
 =?us-ascii?Q?utNOveO2RSpBU78Recz7WY8vSMUNljkQeKEYxn68KW8V8bnihUsXFxqsf9JY?=
 =?us-ascii?Q?rIy6Fzzl1uMXxjt2tv8ZpWwZecj0sOqSsN+TWGnRDZPkT3h3M4HFhhehbnD2?=
 =?us-ascii?Q?UEbKwaVW5hSwUffo4MF6dyR+g9KB8RWoEzR5a6QgYbD5iaBPb8DEjzEcOzll?=
 =?us-ascii?Q?2SfOtnBRXi3XSib5rshLSxWARJIF?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hOICFFbLmQsdvrR07FIRf8ZaHDvNREjj+QWZtfhedp0GM6sK3q03Bve+oO/6?=
 =?us-ascii?Q?Icqthwj4/noHvkmFRXqm/aBcyEoPmkOF0KdaUcfW+HFSdRy16jbnEdEOLSWe?=
 =?us-ascii?Q?YmtgLWCcWhOz0ehrKBwOmJzWpQKH9PKeU80M3mAbnhqXsj6MwOXlcP25ebfc?=
 =?us-ascii?Q?tCT/AlY3wG00FbqrrSF106HVWY6F2f9zJKjq+wGeU0m1ee9TxayxlIgEPRYG?=
 =?us-ascii?Q?rVcUR+Y6UE+24GrEHDMysx75jTptRjR1cXPFNcsAq7K7j7OsQaqlfB/IONgb?=
 =?us-ascii?Q?shi6xlY3S3+waydvHjtRKoptm93szVLtQt977bZE+yxXcirlMIJHjeAFNE+V?=
 =?us-ascii?Q?u9bBqaGt0Hpg7QacAXjpzlKNqx0BRIqgVGM1s5thoYkFn/U7FY8mkTcYILWw?=
 =?us-ascii?Q?agu2zfjVHv+xdAIrjzNGwJWnCN0TK6mWXSxlOgGYnXdhUTmE+v7QOBIhmfL7?=
 =?us-ascii?Q?3QJ9Pqfe8WLD3DnbXio2iP5Y5JddyO6ZHEjF+RC5c+x7P71J59Xu58BxR/pW?=
 =?us-ascii?Q?CDy4Q1xyMBhfaOHTtkpckhZcS5sx2S2qA8aSiQMYKnJLQVs4qC5uEdSEH948?=
 =?us-ascii?Q?0xHeMnCscdLZivYKu7vg+8Piq3lM2fL2Hq8VlHCyCorUesinAMh0wwDajK3Q?=
 =?us-ascii?Q?tMwatvvIAfJ/Sppj+nZyYqnkJqVeXl74PhYwR5P/oE/BUzIWtoVNWy/rnay5?=
 =?us-ascii?Q?8idRBFE+QCcRj7yH6TmZGL8+Tz3OcD9kmbwATdko5pYlTe8tMijRoDaMxIlJ?=
 =?us-ascii?Q?xddpHtJbQV8KnThxBsCfVPRc0W91hxnRSN5xKvbSEx5XO+sOGiNKYymiwIfP?=
 =?us-ascii?Q?BxfmFhij/6yOXgTmK1R8ulMfxkh174x6qC+8rZnHt/V92E4F6qELJqTS8tbp?=
 =?us-ascii?Q?advynvUocjE3yYhijhdIuabS4jWAY7fBFXd+IIpqroXS1OZ1zKx1EOQNEcgO?=
 =?us-ascii?Q?LAp/C+Y5/KJk2aR17XCNuY0uw8vktMDU7mLArSZskAjP3Y5l2RJUBSLPW6J4?=
 =?us-ascii?Q?QTtUsIfZ/ZHAc3kpb68VPKkDxgobAy2UwfkOKj7OY3RxUfkcx+9KEaSk+PIS?=
 =?us-ascii?Q?Io1f3hRpYZiGvyMSi/HVMweUGLtNJZpgpZLGT7hJ5c6G+SJszlS4ERhrNB5i?=
 =?us-ascii?Q?LQif7gkyU1bGxqxE9GxNn5/CQvhuKhj38+SJxZKXxmoJp4IL+6FXH8hjMsyl?=
 =?us-ascii?Q?TV+jRrIcIdKgyX36J7jv+diNDw06qcltKQFIappYtnMW8IrZnFc2gQJtE3vZ?=
 =?us-ascii?Q?/kC7op44tjXJ1V4VFqMoLUSkM6L2STGutwHOuHDKXcd2HdeMfTqP+5pQRgKy?=
 =?us-ascii?Q?oO3EiHmD5/VApOfAsX4qIa90UVSscaSVbb+5Oa0tYEKQbti3AUvgqjVcfoYw?=
 =?us-ascii?Q?2wEC7pAYkexJtJ2bRUGeaxh1bEJoFWAasqfn2Nm41linzzMD0lrCsW6UOGrQ?=
 =?us-ascii?Q?sF8KItnE8OKI89O0yWF5I60xwLmLbeXUOKRdIXbqfSncgmocPHGiTbXQ+wWF?=
 =?us-ascii?Q?eAIJ4oTmAEX7J+GAIr9HzsNprUiVDoIThWUA26CRpgVG/ZsJcJmnwppYgCDd?=
 =?us-ascii?Q?XAl4ZwABtqFVnsQ5qPLFkvRNqT825BbPXYJ0M5Hszvfx+fEOtMsTBBUKxXGn?=
 =?us-ascii?Q?5A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 607cc6a1-4ffc-400f-72bd-08dd61d1a664
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 01:52:02.6052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EmSQJBf8sM7bqtr9OaP6wlb7o7q0x5LS3Fb3Cw9CmRWVaQJFjV2a7lCsS6a6aHxokodGPirch5We3X6ghe6tNY9x/KqjURbZXg2lBkYNWEU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6864
X-OriginatorOrg: intel.com

Alexey Kardashevskiy wrote:
> In order to add a PCI VF into a secure VM, the TSM module needs to
> perform a "TDI bind" operation. The secure module ("PSP" for AMD)
> reuqires a VM id to associate with a VM and KVM has it. Since
> KVM cannot directly bind a TDI (as it does not have all necesessary
> data such as host/guest PCI BDFn). QEMU and IOMMUFD do know the BDFns
> but they do not have a VM id recognisable by the PSP.
> 
> Add get_vmid() hook to KVM. Implement it for AMD SEV to return a sum
> of GCTX (a private page describing secure VM context) and ASID
> (required on unbind for IOMMU unfencing, when needed).
> 
> Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
> ---
>  arch/x86/include/asm/kvm-x86-ops.h |  1 +
>  arch/x86/include/asm/kvm_host.h    |  2 ++
>  include/linux/kvm_host.h           |  2 ++
>  arch/x86/kvm/svm/svm.c             | 12 ++++++++++++
>  virt/kvm/kvm_main.c                |  6 ++++++
>  5 files changed, 23 insertions(+)
> 
> diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
> index c35550581da0..63102a224cd7 100644
> --- a/arch/x86/include/asm/kvm-x86-ops.h
> +++ b/arch/x86/include/asm/kvm-x86-ops.h
> @@ -144,6 +144,7 @@ KVM_X86_OP_OPTIONAL(alloc_apic_backing_page)
>  KVM_X86_OP_OPTIONAL_RET0(gmem_prepare)
>  KVM_X86_OP_OPTIONAL_RET0(private_max_mapping_level)
>  KVM_X86_OP_OPTIONAL(gmem_invalidate)
> +KVM_X86_OP_OPTIONAL(tsm_get_vmid)
>  
>  #undef KVM_X86_OP
>  #undef KVM_X86_OP_OPTIONAL
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index b15cde0a9b5c..9330e8d4d29d 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1875,6 +1875,8 @@ struct kvm_x86_ops {
>  	int (*gmem_prepare)(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, int max_order);
>  	void (*gmem_invalidate)(kvm_pfn_t start, kvm_pfn_t end);
>  	int (*private_max_mapping_level)(struct kvm *kvm, kvm_pfn_t pfn);
> +
> +	u64 (*tsm_get_vmid)(struct kvm *kvm);
>  };
>  
>  struct kvm_x86_nested_ops {
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index f34f4cfaa513..6cd351edb956 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -2571,4 +2571,6 @@ long kvm_arch_vcpu_pre_fault_memory(struct kvm_vcpu *vcpu,
>  				    struct kvm_pre_fault_memory *range);
>  #endif
>  
> +u64 kvm_arch_tsm_get_vmid(struct kvm *kvm);
> +
>  #endif
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 7640a84e554a..0276d60c61d6 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -4998,6 +4998,16 @@ static void *svm_alloc_apic_backing_page(struct kvm_vcpu *vcpu)
>  	return page_address(page);
>  }
>  
> +static u64 svm_tsm_get_vmid(struct kvm *kvm)
> +{
> +	struct kvm_sev_info *sev = &to_kvm_svm(kvm)->sev_info;
> +
> +	if (!sev->es_active)
> +		return 0;
> +
> +	return ((u64) sev->snp_context) | sev->asid;
> +}
> +

Curious why KVM needs to be bothered by a new kvm_arch_tsm_get_vmid()
and a vendor specific cookie "vmid" concept. In other words KVM never
calls kvm_arch_tsm_get_vmid(), like other kvm_arch_*() support calls.

Is this due to a restriction that something like tsm_tdi_bind() is
disallowed from doing to_kvm_svm() on an opaque @kvm pointer? Or
otherwise asking an arch/x86/kvm/svm/svm.c to do the same?

Effectively low level TSM drivers are extensions of arch code that
routinely performs "container_of(kvm, struct kvm_$arch, kvm)".

