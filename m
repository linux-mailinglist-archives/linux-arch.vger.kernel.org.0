Return-Path: <linux-arch+bounces-10881-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFDB6A623B0
	for <lists+linux-arch@lfdr.de>; Sat, 15 Mar 2025 02:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C59FD19C1C3B
	for <lists+linux-arch@lfdr.de>; Sat, 15 Mar 2025 01:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C77199B8;
	Sat, 15 Mar 2025 01:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UAG+Zegz"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D700F4C8E;
	Sat, 15 Mar 2025 01:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742001072; cv=fail; b=ZoMRm1FYlBUFIcIuFGcHDpAu3zpzFllVi+woXUWdL35Po83qknCon/8OEeN+W6VEse6lp3zYTpOfIwWyD+UloeWZOnGFHHjT0jWNi9t4wW+iunIDaYhsKSBwhMLHDcouteb1yJIEqUGWm6ZfxjEc2FrkTyKc0Iesx7kvDIrSKxI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742001072; c=relaxed/simple;
	bh=cC/ECdImOITsEBFscO2auLmDFWYBaXffHEaYyEoq7Ws=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qYKLsh0nLzxLBvfDm+DFGQchX0yCwhxFZAT0JUflrMgc3kXcHg0M2TSi3KSU09FgtZjH1tIA2tzUjMQGEp8ma1CQNs+KDuAuuTHL2vKGRE3/DEgswfmWSL3KPGAeE2ieyrvfIziOSg7e0As4S3FKI1TJ1nkj3DhirmC+pKndpY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UAG+Zegz; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742001071; x=1773537071;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=cC/ECdImOITsEBFscO2auLmDFWYBaXffHEaYyEoq7Ws=;
  b=UAG+Zegz1caeyIUprkprUteDTn2UOuTxXZENBIYwsj6PhztGh8o2/xyB
   QKZKAHNP2hrAb7Nk2dWbPy9BAsnfJmAE8mZp779gfeFkGTJapu/1q0Wdk
   6bp7Xoo+mIOILkrqwZFiNGRzfZXOq1QgrZL7szg+J8NXnf9dVp1XXftVi
   XVuBEpRXEcKO7biMgXV6BLpNfDHLPNY1sBQSPecO4fCa01Ya6CD23Cx2K
   Gm1yj1fFytetmPXpaVs/jdCd1CQG4NVKwzYUosPgJbiPzpf4NXfe4Oh30
   hsWPhHJIiP3VUyP7tz+TgYLdVlpJm38jGO/yZnfETjLZSauoajMRZ0tB/
   g==;
X-CSE-ConnectionGUID: 6JOJ4iBfQ2Oh+XxquxWXBg==
X-CSE-MsgGUID: UmFg5MluRVGo1uDAFhJbjQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11373"; a="65626050"
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="65626050"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 18:11:10 -0700
X-CSE-ConnectionGUID: sBLq8/13RjatFfB6YTv2iA==
X-CSE-MsgGUID: /EQ6jJgIQTmIyzP6sJCi+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="152374414"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Mar 2025 18:11:09 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 14 Mar 2025 18:11:08 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 14 Mar 2025 18:11:08 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 14 Mar 2025 18:11:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tQuLD/waTS/utm3rWpXY8gKjJzbFcHPLgYxGDOhGqeEyIrA6565t+zsFG3Er2sWfQi5qoG0vqZqHr79wAytYUUQ3DqbOhU1vIIWU5uVp8IoINVf2O4isEL32csnULbTkADZ3Y5R9HDzpbqmpZyVYUJg9AOOxjetS09W7122MkGXk5881TC6wgVH4nrgbQMNyqzzpuUR9/xUnoWFyz5GbpHgu3a6E6MGUB0tNmc2ooBV7LtpE5waQvm4wLd47XrQSGd9YpRXv21mO69m7xTbOPeVCngju8WEcIaFAIjw7UsJ/Pyv8sY0X8PrxvGIJZViG7zogTKKJsRl5c9Qifj+s9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LvIpbRD/dQK0nI23gpjg6SQq0zr8DHsGVOL3p78140c=;
 b=Uh7/Q1Et3nqyWBOlJbVeWd0QugjkC+vEX4WR/8ydzAeDOYT4cbc2gEWl+FzUN2PToHNMV7k1d17WKFENDBs0j1R7OINrryf3BmhoQnFaYcFeZASOH7tQ8V+XPduxAe6lJ47NUgHfLZNjyz9KibXp6TANlwqNPT6tIYTxL9BdbQBXzuuTP+kaXbzEgiTje3NRrFSCgDK7L6uzTE224/G9bSwSN6EnDj8+MoTLtvtTepzuSvRUcWCbWFzFq+tLXfDKwu8TkbEQA8Fjkjac8lR8rq5DrjljYafqU0iHLh2xq3nzW4rIOhonpW8UqqngsibjZE1DBSuy1klNIWMOS+TxLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM6PR11MB4660.namprd11.prod.outlook.com (2603:10b6:5:2ad::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Sat, 15 Mar
 2025 01:11:06 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8534.027; Sat, 15 Mar 2025
 01:11:05 +0000
Date: Fri, 14 Mar 2025 18:11:01 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Alexey Kardashevskiy <aik@amd.com>
CC: Xu Yilun <yilun.xu@linux.intel.com>, <x86@kernel.org>,
	<kvm@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-arch@vger.kernel.org>, "Sean
 Christopherson" <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>,
	"Tom Lendacky" <thomas.lendacky@amd.com>, Ashish Kalra
	<ashish.kalra@amd.com>, Joerg Roedel <joro@8bytes.org>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>, Robin Murphy <robin.murphy@arm.com>, "Kevin
 Tian" <kevin.tian@intel.com>, Bjorn Helgaas <bhelgaas@google.com>, "Dan
 Williams" <dan.j.williams@intel.com>, Christoph Hellwig <hch@lst.de>, "Nikunj
 A Dadhania" <nikunj@amd.com>, Michael Roth <michael.roth@amd.com>, Vasant
 Hegde <vasant.hegde@amd.com>, Joao Martins <joao.m.martins@oracle.com>,
	"Nicolin Chen" <nicolinc@nvidia.com>, Lu Baolu <baolu.lu@linux.intel.com>,
	"Steve Sistare" <steven.sistare@oracle.com>, Lukas Wunner <lukas@wunner.de>,
	"Jonathan Cameron" <Jonathan.Cameron@huawei.com>, Suzuki K Poulose
	<suzuki.poulose@arm.com>, Dionna Glaze <dionnaglaze@google.com>, Yi Liu
	<yi.l.liu@intel.com>, <iommu@lists.linux.dev>, <linux-coco@lists.linux.dev>,
	Zhi Wang <zhiw@nvidia.com>, "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>
Subject: Re: [RFC PATCH v2 14/22] iommufd: Add TIO calls
Message-ID: <67d4d3a5622f9_12e3129480@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250218111017.491719-1-aik@amd.com>
 <20250218111017.491719-15-aik@amd.com>
 <Z72GmixR6NkzXAl7@yilunxu-OptiPlex-7050>
 <2fe6b3c6-3eed-424d-87f0-34c4e7e1c906@amd.com>
 <20250226130804.GG5011@ziepe.ca>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250226130804.GG5011@ziepe.ca>
X-ClientProxiedBy: MW4PR03CA0221.namprd03.prod.outlook.com
 (2603:10b6:303:b9::16) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM6PR11MB4660:EE_
X-MS-Office365-Filtering-Correlation-Id: 22c3414b-d3cc-4e1d-98d2-08dd635e429a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qlPWKt8tRXU8pnpHWdTwJVoEKUE3sf5CaROyFAselNgrs6JdJIK1ktppVTGz?=
 =?us-ascii?Q?FudMPmwbmQcBu/Yq2hyhVqhA4GWQJzEZ7PKfzMbUpEijWP+Ya6k9ePfz1BJA?=
 =?us-ascii?Q?furJYkpR82+HGt6wG3JlWHilhgCZEBfomoX8M0uK7qIfeMjtth2hfj+Fr1dU?=
 =?us-ascii?Q?4JtDiJubEJi8stgsa2+jgBPfTQzIyeO84/pZUqynFI6r4WIcTUrjTRdPxVvG?=
 =?us-ascii?Q?SPu5vwrnJGfI5Zh8+ByrbEZ/+ZoP2zqHr6AaRNqxup96mfaef1fafXDwTa4f?=
 =?us-ascii?Q?TjYfe1OzC6roq1q97cP6lstv7vJXIpoUp5e07wuoeooV6RpbHCY8oUnSMD15?=
 =?us-ascii?Q?ItEBEpCB1ZrSkLtcwMMM74iNi1qctPXkULG4iW0SGATqU8NfzITwOWo2AAwe?=
 =?us-ascii?Q?70u+gcVcxKlrCKYTbcpCyCo9VIq8QlGLX7+Mc8IJPWlpAaFNfXFDSdXgfDgc?=
 =?us-ascii?Q?FvKgymCKSpwxXwMpu5g8GG0rYQCUjZL1WOJKGoQu6R/CqIoiq1t8am+gB2av?=
 =?us-ascii?Q?ikTCtXk9sRNNl/RJ/L+cIo5YMOj6X2S3RcLiRVi3lWYUFf+vVxoDFtedmK+j?=
 =?us-ascii?Q?ZQ4TY4mxrdCFyfv71aNwz+MLECZPHOq+2nOIUiJ0G3PaR/tQ/8VPWaibQ/cA?=
 =?us-ascii?Q?qnNA1HBLFCaulqeakCOfsz4chQsA1XR4PG3tOfdVbk9Mzk/OUVlpLUEATC87?=
 =?us-ascii?Q?PCUOWbnwfYW1u3aQMxWxgQ9pm2R8IdEjdH7ct1pdlmwxkR1SPDhyLPtOBdzZ?=
 =?us-ascii?Q?6tY0EAowcsN8b9SGF8peYDNaaBmdBsp5f4+jZql4SXVO7HIReWkHA4uHrYvD?=
 =?us-ascii?Q?jWkzlINXKhgwAVwOq87a0PrHOn3+IbZxG/YX2SOnNvw9ddGM5Zctz3+EiePU?=
 =?us-ascii?Q?ds4cXeG4ziUyycwAv6d74dFwMeyN31HrsaQr79AYmtltTqVPCkauhygBpkRn?=
 =?us-ascii?Q?c2GiziTS5LBQBVUVTgZG+1K0eHRYNzyA3SxZKUQppaJeesxerl8lpbwVm5FK?=
 =?us-ascii?Q?Btu6WD2HeXCWhBKoX6hGJYMn+1DNqkVqNmZ7CORl8v7KJAhZkQ9uPTcN1Z9l?=
 =?us-ascii?Q?hcO6Oo3hXfaqAnfPpO5+bR6rulpGouJeTblVajks6SIDw9Ge7DkTm6BayQPK?=
 =?us-ascii?Q?VtCrLg3XtawtSJNEi+nVNrXiDRGR/m38FJcXPL3jJg6c4nYxSVSoduS9Fv1x?=
 =?us-ascii?Q?7/X+FFf15Jcbo6S4T6B5jgLJIs3uwD1zpRn7thKXaHyapZaAdc7A/t1hMYBT?=
 =?us-ascii?Q?wRmlAD2l2HrfC2uUtcSe/HooLYdX94a/Ha93rTWmzNculzWF7pF/CQ8i2Y5t?=
 =?us-ascii?Q?D9aw6wwayzPyWkJf5FYEIuIWQ/a5WjoZJUNOBc3+nojpFq0ZafLMQcK8fL7x?=
 =?us-ascii?Q?lt5G+EasVbF9cGqVGdlgn8TOyht8?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6+UPmsxEE9lsvq2DsnwL0meSkLyRzyaxtHZLTKpcA/hUcn6FDLgzoIzQ6AHi?=
 =?us-ascii?Q?3EqtC1pUDcts7zEsOq6iNqlzdJFRQskV6it7afNZg6KHTrMxygVreoAIO+/x?=
 =?us-ascii?Q?MAtrpiB52rFLC7agonvaKts6frzbAFFr4UuJoUtlmo1TW8UFrIdDYxuoeyj2?=
 =?us-ascii?Q?ZN/xxJkz9O6arZSdFb5aYTHITHB34VTE8so40j0dn81ed5sbWiIyoMRr5JQI?=
 =?us-ascii?Q?3W6aoj9fmVq8vLnfdXGdwAn/vYIS2WPR+Y9V2fatuQVx22x2wi4SdpWY4fzd?=
 =?us-ascii?Q?R0xsMmupkvfddKqowaEW180T7+p1Oefzt5IWdrJe6nsl/6/Qg0ijWOFXDOj+?=
 =?us-ascii?Q?5nee+YK/rT00iKDlw0QejrY66VqhgdB6QwyHr2g4zf3TxwzbqyJccSeNHGML?=
 =?us-ascii?Q?DFy2AJRg8BwneTGfSTYvdkq8xb9kCMiDyI7A4Hf8NRVLy8pJJw9Lbfc3dMP4?=
 =?us-ascii?Q?TKZAV21AcKKkxCEL/TTRGtAS3pM9b4YYe/ay6fQkOb7SWvLuQfj2l7h3kq6w?=
 =?us-ascii?Q?BdS7ZQQprs7MW+h8drxsv3ipm+fzpuZvG2HbpMMIqGOaOa0fkWcqda/1p1c5?=
 =?us-ascii?Q?lztXxym7ZOv3yccBejWna14ikQUE7v/N2g+aZinw7EUiw+pc8eXNwzTifkY0?=
 =?us-ascii?Q?Y46u7cuCbGvHI8+rLhUcjg4mCkNRO3fYJSf5WOO8KX+pXgNbIEiijuwiHAdr?=
 =?us-ascii?Q?oqIGDn0ox12yfcN92i5cYHasG9AK7/okI+EUmArSc38asNx6rsYvgBDrJaVj?=
 =?us-ascii?Q?8+3bkptB6MCGeSuJi/usg4WBV5thT3q0sNyuORq1VlE+FL1TNPNoTJX5N2Bx?=
 =?us-ascii?Q?jL4qjxNPIJoCC5QoAS6TIwAoYiQSH6Dx+mYkAH644jmtIBt6K84qjbhEcW6r?=
 =?us-ascii?Q?8OgMf0lgLrNTUCOWrZ1vmVgNvS+oUg2O8n+d7zPuWAot8+4sFoLH1T07VBPc?=
 =?us-ascii?Q?RUlVSVpqhICr6p867sdps3XADunsNPkfYEXFq7DE8/gm3xEEJ42Han5/HI+C?=
 =?us-ascii?Q?+O5Ntnqt3CVai12mLj2TtsrLRgnHVPUDYw9HgYPaTJ2rdqNcrVkLxvZ5DqFG?=
 =?us-ascii?Q?6puej3ZDfRh8Kmy90ZGw2ZcpRBQyRzBpOgEuDqbKUb597Sh2D6XpgN1GoifS?=
 =?us-ascii?Q?NKxZroGkSGgEsrPW9X1dOyT3usi7bgBS8sBmpJIh+zhGhkn2nP9TndaJD/Ku?=
 =?us-ascii?Q?Qsa9v5AePGxIcA387NY+8gASAZXYWkOE9gT1EHRI2vj/4nWFlt2RdWh6xw+a?=
 =?us-ascii?Q?4LjdiAk1QVIkK5CmOvbTmnEvaSgSA7tk1YgpVBHy/lidy2UWHEVtZqmOsU34?=
 =?us-ascii?Q?GSCL9SYQRWJrlQ7D/MLSAhtaEJX5CG0LqiivAWfDkzqtBAJgaMVEuq6yQa4T?=
 =?us-ascii?Q?UKGU6gvnLs+9qzlQD/MEUZQ2qQtCayHp8fb8PUSGvugVatrFuWGAYtjWC4Nt?=
 =?us-ascii?Q?vCIlYBKm2iikjIZAdSfxv2U1map2feX4WUkIkgfgqSx79VsSVuYEYt9qAcRk?=
 =?us-ascii?Q?5QTscryAKggN2PQExPQpbugW+KPL5tIzQ+ZkJv1xK8iWk4vdrhPR2hwkX4rQ?=
 =?us-ascii?Q?aguph4bwyGBCGG/QYwhDQ1/cBmNo/S+kfnjhB3AqrnLIAtmp0yhbVGTqWNI0?=
 =?us-ascii?Q?DQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 22c3414b-d3cc-4e1d-98d2-08dd635e429a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2025 01:11:05.3594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AT0arrLSykrUNlAlatbMmm1sIPKPkJ3JdNZAENQp3SpWPmJDbTGUTDMPIMKcDzAgn52WIQb1bLLMnM0hVh64Gp4H2EC+xzRFqHIy78/AF0M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4660
X-OriginatorOrg: intel.com

Jason Gunthorpe wrote:
> On Wed, Feb 26, 2025 at 11:12:32AM +1100, Alexey Kardashevskiy wrote:
> > > I still have concern about the vdevice interface for bind. Bind put the
> > > device to LOCKED state, so is more of a device configuration rather
> > > than an iommu configuration. So seems more reasonable put the API in VFIO?
> > 
> > IOMMUFD means pretty much VFIO (in the same way "VFIO means KVM" as 95+% of
> > VFIO users use it from KVM, although VFIO works fine without KVM) so not
> > much difference where to put this API and can be done either way. VFIO is
> > reasonable, the immediate problem is that IOMMUFD's vIOMMU knows the guest
> > BDFn (well, for AMD) and VFIO PCI does not.
> 
> I would re-enforce what I said before, VFIO & iommufd alone should be
> able to operate a TDISP device and get device encrpytion without
> requiring KVM.

Without requiring KVM, but still requiring a TVM context per TDISP
expectations?

I.e. I am still trying to figure out if you are talking about
device-authentication and encryption without KVM, TDISP without a
TVM (not sure what that is), or TDISP state management relative to a
shared concept of a "TVM context" that KVM also references.

> It makes sense that if the secure firmware object handles (like the
> viommu, vdevice, vBDF) are accessed through iommufd then iommufd will
> relay operations against those handles.

Yes, that tracks.

