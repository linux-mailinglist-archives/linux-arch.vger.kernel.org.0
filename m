Return-Path: <linux-arch+bounces-10753-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33007A606F7
	for <lists+linux-arch@lfdr.de>; Fri, 14 Mar 2025 02:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CBD246329A
	for <lists+linux-arch@lfdr.de>; Fri, 14 Mar 2025 01:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EEAC2F29;
	Fri, 14 Mar 2025 01:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lb2Qplbt"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCDF12B63;
	Fri, 14 Mar 2025 01:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741914894; cv=fail; b=uUvKPPnSL5ofP6sdsbEnMA96YXIZTv+QZMlHiFZ2SCfJMEQcZIB4g6uBGEU07sGD1FGqPMGbKXmhW0tbz0VR2HEyhHCHlLjSz/MmRHFAgPmySx8jUSaVj4w0yeVepn0KeciIt0AXPtiOwO/X4qsKNh9QranMRKYc74dV3rIVWy0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741914894; c=relaxed/simple;
	bh=z0jvpxY+QfI8fFuHtrsPAQZ3aEJHP0+R5zId5QHgxpw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JMJH7KVnBJpZxXuHwrYNphgIbfG4WDdnSyOqstbmoERYlKFENwy9lUNtvWEeHjwSbYbB1MFdE7ERNmbZPbnhFHxMEjgKV2UARc1lAZfNjyEKJnWPDu6VHJNyQVUEYXmwFx4olOHLg3ojwmwOD2kscylTZWk59NFA1c6rLpphODY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lb2Qplbt; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741914892; x=1773450892;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=z0jvpxY+QfI8fFuHtrsPAQZ3aEJHP0+R5zId5QHgxpw=;
  b=Lb2Qplbtn+ayPGNRmVCfVbWGVyUV7Osf/qfsnUCvr7CzUzY+QrEXHrNw
   3m2d27Y+Bjwv4CHtlV9RKh8MASZAk/YfxqxdU7VmHAPSZUhj3ViX3LWhq
   hcs/BSAj56FlUU65B+RgtGoX3ev1Q3qTXJDxCb77ewOwDj2brJTupDEIa
   lBKAUqjp0e70cQQIi0Wyv26/qT1YHWErpPsrvDDHMUodV6OAucjZ0ESU5
   bBsUZpnaK+oYfoA/Wi++BQY3/VMQ7D90DwfeXr277/TzPNNBTMOlT20fj
   9YVdgIe8Djb1/SI42grq0NyLnV+JvG/fxtppWPM5Tg5H9HhlB0seri23R
   A==;
X-CSE-ConnectionGUID: zMpdl3/uQ8eACQ0cVZQYTQ==
X-CSE-MsgGUID: jxjXj82qRoacZZSe0h14tg==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="54430960"
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="54430960"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 18:14:51 -0700
X-CSE-ConnectionGUID: Jzyx+TgwS0uCT0H4MXRd0w==
X-CSE-MsgGUID: tIAWMlOgT1u+lki2BBBnVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="121076461"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 18:14:51 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 13 Mar 2025 18:14:50 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 13 Mar 2025 18:14:50 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 13 Mar 2025 18:14:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CpUtpHFm+MM4Pmju8mu57/8uVDaze5LlqYwQ4lQpxYtzA6GzsL3MeRDbadkGggmT4DRk3sgmxUH57Y1CJZRWHK9WfLdkLSPYiBAxLHlyh0Dy+XmhgbrkzBBxS2aZbaiFysRxZ57x1HXynQzMEkDN3yBfP2bJt9IZ11TOWfGtbWhaPWCbMCl2hbev/h/ZWfS7M5OCIFRun/TA9IW0clJ7I53/lvks1w2B/HknYJQwGDhquDKCP8hnWYiwPd9HF19gmkn52hQ8PO1xP2rX14gwkDXSnzBoKIezkSsZLi6VZj1AiSEGzSt0a4HDLEJ/SsMTk0c+/ogIIESB4pQnN55pYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pFQ97dJksSjPk9neJIJb9zlX+rdxnq6JQ0yl3xQl8L4=;
 b=LaUFt5vP+bVS+HJwIOSysRo0yTM5Hn3RIGFQoxB1M7sc1v/rebmVtDLypbG2epyn4dkLbdGzdL1iNuqWqqCGQicGEUZb4ASbPBqSGVSfUloqrjjazuM4LR7fS84IAEUfKKfr3HJr0XrF0SMuBu56F8zCFQaGd6EhxKwEH7YEdh0mDxKbCddK0h1mWuEm18gFHZRZdFR4nF8lfIbH5QdtwmdDo0tg6iWCUCTkXGZMT54GhXktnTDhoPvxLgC5amNcb851fFP1kxkAaZKHvdJSjDfyAj5xwvffqUQuQk5hMu9udqizXllCaKBTQ6Kf3YauTEUQs8S4fc8YW3/EqvmpWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CO1PR11MB4932.namprd11.prod.outlook.com (2603:10b6:303:98::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Fri, 14 Mar
 2025 01:14:32 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8534.027; Fri, 14 Mar 2025
 01:14:32 +0000
Date: Thu, 13 Mar 2025 18:14:28 -0700
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
Subject: Re: [RFC PATCH v2 07/22] coco/tsm: Add tsm and tsm-host modules
Message-ID: <67d382f43dc5d_201f02945a@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250218111017.491719-1-aik@amd.com>
 <20250218111017.491719-8-aik@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250218111017.491719-8-aik@amd.com>
X-ClientProxiedBy: MW4PR04CA0347.namprd04.prod.outlook.com
 (2603:10b6:303:8a::22) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CO1PR11MB4932:EE_
X-MS-Office365-Filtering-Correlation-Id: 69826a42-ed36-4b1c-48cf-08dd6295936b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3QCWzWIcAWesL/LbHedoCwkNKrhWSekVBhSif0Hu5/Jhl8hVMKa7iZ7Ntt7W?=
 =?us-ascii?Q?QIrp244KGqx95vDW3LduzJixKgLfJxzsvGa0m4AU1LZTksmDg7cVR2H5S68L?=
 =?us-ascii?Q?V/GhUM82T38cPLlQ7JcPPBml2W/KhALLGtBjQaQoDuOhunDVGBD7t2elp507?=
 =?us-ascii?Q?nR0Pk+cw2bNQ9w57ANV0ePu0AnxA4lFZuF41pp30MxuqPYl3/asCkVhq1xDE?=
 =?us-ascii?Q?7egoRqfxyO/WFt2CoqKKzwqvLbmufb9MWq4tCnnNudFdERnm38Bo4wdn8X2Z?=
 =?us-ascii?Q?JKu0sb1UACh9gT2I0rKkbugnFTsWpoUxFwq3ojOPGsz+d4CjkOgjmwr6Gh4u?=
 =?us-ascii?Q?v8/Fm2lT/TlBbV4inLfbrpnsvAWFjoqMn6SmNF61t80UIln3qtaX1LcMs2W/?=
 =?us-ascii?Q?OSCVFr8gcgZhRakERCmboQoiWEB8Qvyt8IHtrslTcEAQpWOhAR2MulHBkZC0?=
 =?us-ascii?Q?RDXrfw9QJYiv66ER6vxJ9nD42ewhdzDNdgqPVM4aRTzUw/HpSYnV/c8xzpXg?=
 =?us-ascii?Q?js9rwX+/xyTcvUs7k6ZxHjMc4xAH6Zgm+Nr2z+NPZfdjmrqgSH6zAou0ju6a?=
 =?us-ascii?Q?faDlfHlEGb8f+2pxGlNQ5CgxZdCwNMoIzS4mIwJKvXN3NxhRReiiV0fq8YCj?=
 =?us-ascii?Q?PFaVO4kmlhf7CkIqs8y9eZO5wE6bk4l4j4sDtS6MzqUR/Q6Cz+yk5mASkxI6?=
 =?us-ascii?Q?keunR0Plj6UjSXVNWSmWa52fsUJgQNvD9pjBBDa+RJdfKBRToxIq6kaOosGb?=
 =?us-ascii?Q?0B1kzlUBul8HQTLNaq5Qh8gWWWoXgHbxHrnLT2/qQgN+nyceH4oCWFdBGG0z?=
 =?us-ascii?Q?DKLNOVFSUnCOH8PQI6jRYNCOA+SAb8ZG64MzdXmqgagFWqniOhGLXmw5GFPx?=
 =?us-ascii?Q?XDJB9lrjbjxkATAPTEeeNOmQA1Khk/Uvtb5Z1/OoE3lUAjQg/UfTe0KQkyj0?=
 =?us-ascii?Q?vumOEoI5XKGHWBPuaE9cTWG9nZO/2zT2HFonq6LnAg6c2JJXKcgt7M5YAf+i?=
 =?us-ascii?Q?W+HUP0ST64lDw/OBnmRxVvp9dfvnYhQMLRmxWG6iBqjt6X4TM7nhBXO6UiRg?=
 =?us-ascii?Q?ljCb0OX5N8EuoZAhrN3+Svxo2VTFydLoSf0x6Et3roRhvFdGCSWfgyOcekdR?=
 =?us-ascii?Q?syeeQz6ADhcg2ZPpOzqrw5YoClgjoyEgVTKnyk28YqrNqyEEGn/Ksjb71/cz?=
 =?us-ascii?Q?+PjG9a8lsYUTZqvQyUycN2q2ghvBLblYsoBeGvjNhhF2F54Hoj3kIJsFcpfS?=
 =?us-ascii?Q?O6vnm4k5N4TnOSKzJ5EqTvVOjy9Mxi5wk8Ix81Yj1kTBea2kljm9m5TA/X8T?=
 =?us-ascii?Q?k4Q31Z7xeJub0wNi1oMTEZlqs0wDzK27KEa3PfajwBnZMC87Zm12VWBCyo3D?=
 =?us-ascii?Q?FTTPtKkMbM43hTrXKzdpttSBi3Dk+jLB+nNc5h+nWwN44KKVKA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yFcQk2RUCEci4M2zuWN0CN/KNZhz98rOI1KI0BZB5T7W9LBnaZuexca0etkQ?=
 =?us-ascii?Q?ky+p1nFDisu+pLQwmCwxyRfS/2IosLbL30xZDys701GinKm54Pd+ErlB/t6o?=
 =?us-ascii?Q?ysGxpYO1HnRbg9iEXXP5lVjkuGhxw5sA6BG0xp3qygsTgqCQvXzru46gpJbI?=
 =?us-ascii?Q?cBdmT+MPl1VLmD+2E/T3NUbFvQaEc2yLOdlHNt99b94IDSezViumyXGQ02vl?=
 =?us-ascii?Q?IoZv5E1ksxdjOSn7UFIxzqRpcTLfXTdjjCQB+FFn8fM/5Bwv6K6ZNkhG+dyV?=
 =?us-ascii?Q?xR6p5HRbMThkbjziEZPVpw9G4FCMtT49LA0b9aPZjQ+l83dV+mkJmhrhOzo8?=
 =?us-ascii?Q?OuuXeSjOr28ZLQAYr+Slw1aUIqnOSMofuv3Rzamb/yfqbv/VU8TtTgzK3K2c?=
 =?us-ascii?Q?ouXGiNzCD+ljq9I9qmyGiS/P6CXHTAmy5Fy1OvQedYdPzvH3egdpQLSxZSjX?=
 =?us-ascii?Q?JnN/HAEI/pEZgj5HNrHQhU58kZ1elZrGWo135dcMTvpXNO3oNmNB2suBLjgg?=
 =?us-ascii?Q?ZgyxMnoc2h3hmuY1vJmF3H+p9bbSeHbLtdBX/0O9LE8V5nr/T6+BkvBn95en?=
 =?us-ascii?Q?hJEdfbUh+SlZXrqgoKu1F434a5YIV7qEHvrUbgkYOo27z30BO0/r5q9ZMUlC?=
 =?us-ascii?Q?PqYQ1XtxGrcGcpAWTNgVmKOGCgj+M+AnNao/l9wK5IiwfqushAOvvPGuyh+H?=
 =?us-ascii?Q?Eavu6nzapsG4gNAlseWhNi/aDhNlAhKlLvcbFpYl0TnvaQr17l2YXCY76s34?=
 =?us-ascii?Q?2s+l/RCOWdHXWKMSCX27YI4qywW/WitPCqmpA9A6lt7Wo7dlbJFOt3f5DcV+?=
 =?us-ascii?Q?xnH4ePt70Yt3kUGL/o8SH8jQAVbk8eRc8j/O0UAJ25xTsZjGp2/kyeROGVzD?=
 =?us-ascii?Q?/TkVlX1PezWkQzuNBs6mUbCKuk7YUnxjZRsqqET15zJs3t5YoG2Wwf7PvwVB?=
 =?us-ascii?Q?NfijK0aKwZdXoVOp9iGyxC04RZBFaq1qXSzcJ3FqsDcrtu59arSM84hXrFK/?=
 =?us-ascii?Q?caHvoY5OMaBgYVFXdn1nf+8T6bgoCFKWOAQ9x6di9bGzrX0QyeHWNYjDU5SE?=
 =?us-ascii?Q?Ai5EKXDjZD3wwFiRqHwTTg2TZfs8rQc2wlByI9Iq4/8+5usOAt1uRgsnBNgR?=
 =?us-ascii?Q?QQM6jBj52F1aUxd+C0Nt44NmG3x4kGPBlonJT3ue+N0hJIPE/7tai94IR784?=
 =?us-ascii?Q?TpxRjQS3HIWxa4PJ4tLpiVCeOx4KjFUOIjWvgl5/MSqF22weOwDeBBnSj/y9?=
 =?us-ascii?Q?Lfnv4l1k/H8A84QioM21quaO7CDuXrW9ThatyPv8RJpxNBEvL7so4RMN7gJx?=
 =?us-ascii?Q?R+fm7iGeW+R8AoOeTvQRjtxt4aUhWdqapHbI/qIGb7yO/CR3rCmJPnGAh1Ya?=
 =?us-ascii?Q?RUlejk4zFz/HjWZ1KFbIzdun5priA8wM2Zuf8JlV4PfX7S8sPX8uoEz8Jt54?=
 =?us-ascii?Q?umQv4etk8GvUpu+ICDzRG2lLeZU6Ho9Z7ktBZGNSJP42vgP0TCzVuCfEmHGc?=
 =?us-ascii?Q?XR6DuXO8Hk099Uwi3aJ61HLm9TCtpQXsqIrlNN8mAf4A1Fy/IF3Tkbr+m5s9?=
 =?us-ascii?Q?TKBJ8WqqBRdseHlM+no78TY15OPamF1djFYtuCONl4m8sfrAUndJ0fu3hLJv?=
 =?us-ascii?Q?pg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 69826a42-ed36-4b1c-48cf-08dd6295936b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 01:14:32.0617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GzXuKrNt9LBDqmkVtFpqxEpFQiCabAsqpDXB8S7yXT9BfKgjuq9RJ3smQ6/WM8req4lbblA7QcsnUXWNW1BF0tu1rq87jkcLwcXDVppJPuI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4932
X-OriginatorOrg: intel.com

Alexey Kardashevskiy wrote:
> The TSM module is a library to create sysfs nodes common for hypervisors
> and VMs. It also provides helpers to parse interface reports (required
> by VMs, visible to HVs). It registers 3 device classes:
> - tsm: one per platform,
> - tsm-dev: for physical functions, ("TDEV");
> - tdm-tdi: for PCI functions being assigned to VMs ("TDI").
> 
> The library adds a child device of "tsm-dev" or/and "tsm-tdi" class
> for every capable PCI device. Note that the module is made bus-agnostic.

There was some discussion on the merits of "TDEV" and "TDI" objects in
the PCI/TSM thread [1], I will summarize the main objections here:

 * PCI device security is a PCI device property. That security property is
   not strictly limited to the platform TEE Security Manager (TSM) case.
   The PCI device authentication enabling, mentioned as "Lukas's CMA" in
   the cover letter, adds a TSM-independent authentication and device
   measurement collection ABI. The PCI/TSM proposal simply aims to reuse
   that ABI and existing PCI device object lifecycle expectations.

 * PCI device security is a PCI specification [2]. The acronym soup of PCI
   device security (TDISP, IDE, CMA, SPDM, DOE) is deeply entangled with
   PCI specifics. If other buses grow the ability to add devices to a
   confidential VM's TCB that future enabling need not be encumbered by
   premature adherence to the TDEV+TDI object model, the bus can do what
   makes sense for its specific mechanisms. The kernel can abstract common
   attributes and ABI without the burden of a new object model.

[1]: http://lore.kernel.org/67b8e5328fd41_2d2c294e5@dwillia2-xfh.jf.intel.com.notmuch
[2]: http://lore.kernel.org/67c128dcb5c21_1a7729454@dwillia2-xfh.jf.intel.com.notmuch

> New device nodes provide sysfs interface for fetching device certificates
> and measurements and TDI interface reports.
> Nodes with the "_user" suffix provide human-readable information, without
> that suffix it is raw binary data to be copied to a guest.
> 
> The TSM-HOST module adds hypervisor-only functionality on top. At the
> moment it is:
> - "connect" to enable/disable IDE (a PCI link encryption);
> - "TDI bind" to manage a PCI function passed through to a secure VM.
> 
> A platform is expected to register itself in TSM-HOST and provide
> necessary callbacks. No platform is added here, AMD SEV is coming in the
> next patches.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
[..]
> diff --git a/drivers/virt/coco/host/tsm-host.c b/drivers/virt/coco/host/tsm-host.c
> new file mode 100644
> index 000000000000..80f3315fb195
> --- /dev/null
> +++ b/drivers/virt/coco/host/tsm-host.c
[..]
> +static ssize_t tsm_dev_status_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	struct tsm_dev *tdev = container_of(dev, struct tsm_dev, dev);
> +	struct tsm_dev_status s = { 0 };
> +	int ret = tsm_dev_status(tdev, &s);
> +	ssize_t ret1;

I know this is just an RFC, but...

> +
> +	ret1 = sysfs_emit(buf, "ret=%d\n"

What does "ret" mean to userspace?

> +			  "ctx_state=%x\n"

This violates the one property per file sysfs expectation.

> +			  "tc_mask=%x\n"

Is this the Link IDE traffic class?

> +			  "certs_slot=%x\n"
> +			  "device_id=%x:%x.%d\n"
> +			  "segment_id=%x\n"

These last 2 lines are all redundant information relative to the PCI
device name, right?

> +			  "no_fw_update=%x\n",
> +			  ret,
> +			  s.ctx_state,
> +			  s.tc_mask,
> +			  s.certs_slot,
> +			  (s.device_id >> 8) & 0xff,
> +			  (s.device_id >> 3) & 0x1f,
> +			  s.device_id & 0x07,
> +			  s.segment_id,
> +			  s.no_fw_update);
> +
> +	tsm_dev_put(tdev);

I would not expect sysfs to need to manage device references. If the
device is registered sysfs is live and the reference is already
elevated. If the device is unregistered, sysfs is disabled and attribute
handlers are no longer executing.

[..]
> +static ssize_t tsm_tdi_status_user_show(struct device *dev,
> +					struct device_attribute *attr,
> +					char *buf)
> +{
> +	struct tsm_tdi *tdi = container_of(dev, struct tsm_tdi, dev);
> +	struct tsm_dev *tdev = tdi->tdev;
> +	struct tsm_host_subsys *hsubsys = (struct tsm_host_subsys *) tdev->tsm;
> +	struct tsm_tdi_status ts = { 0 };
> +	char algos[256] = "";
> +	unsigned int n, m;
> +	int ret;
> +
> +	ret = tsm_tdi_status(tdi, hsubsys->private_data, &ts);
> +	if (ret < 0)
> +		return sysfs_emit(buf, "ret=%d\n\n", ret);
> +
> +	if (!ts.valid)
> +		return sysfs_emit(buf, "ret=%d\nstate=%d:%s\n",
> +				  ret, ts.state, tdisp_state_to_str(ts.state));
> +
> +	n = snprintf(buf, PAGE_SIZE,
> +		     "ret=%d\n"
> +		     "state=%d:%s\n"
> +		     "meas_digest_fresh=%x\n"
> +		     "meas_digest_valid=%x\n"
> +		     "all_request_redirect=%x\n"
> +		     "bind_p2p=%x\n"
> +		     "lock_msix=%x\n"
> +		     "no_fw_update=%x\n"
> +		     "cache_line_size=%d\n"
> +		     "algos=%#llx:%s\n"
> +		     "report_counter=%lld\n"
> +		     ,
> +		     ret,
> +		     ts.state, tdisp_state_to_str(ts.state),
> +		     ts.meas_digest_fresh,
> +		     ts.meas_digest_valid,
> +		     ts.all_request_redirect,
> +		     ts.bind_p2p,
> +		     ts.lock_msix,
> +		     ts.no_fw_update,
> +		     ts.cache_line_size,
> +		     ts.spdm_algos, spdm_algos_to_str(ts.spdm_algos, algos, sizeof(algos) - 1),
> +		     ts.intf_report_counter);
> +
> +	n += snprintf(buf + n, PAGE_SIZE - n, "Certs digest: ");
> +	m = hex_dump_to_buffer(ts.certs_digest, sizeof(ts.certs_digest), 32, 1,
> +			       buf + n, PAGE_SIZE - n, false);
> +	n += min(PAGE_SIZE - n, m);
> +	n += snprintf(buf + n, PAGE_SIZE - n, "...\nMeasurements digest: ");
> +	m = hex_dump_to_buffer(ts.meas_digest, sizeof(ts.meas_digest), 32, 1,
> +			       buf + n, PAGE_SIZE - n, false);
> +	n += min(PAGE_SIZE - n, m);
> +	n += snprintf(buf + n, PAGE_SIZE - n, "...\nInterface report digest: ");
> +	m = hex_dump_to_buffer(ts.interface_report_digest, sizeof(ts.interface_report_digest),
> +			       32, 1, buf + n, PAGE_SIZE - n, false);
> +	n += min(PAGE_SIZE - n, m);
> +	n += snprintf(buf + n, PAGE_SIZE - n, "...\n");

More sysfs expectation violations...

Let's start working on what the Plumbers feedback to Lukas on his
attempt to export PCI CMA device evidence through sysfs means for the
TSM side. I do not expect it will all be strictly reusable but the
transport and some record formats should be unified. Specifically I want
to start the discussion about collaboration and differences among
PCI-CMA-netlink and PCI-TSM-netlink. For example, device measurements
are ostensibly common, but interface reports are unique to the TSM flow.

