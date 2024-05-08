Return-Path: <linux-arch+bounces-4259-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F858BF4D4
	for <lists+linux-arch@lfdr.de>; Wed,  8 May 2024 05:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E09B1C215FC
	for <lists+linux-arch@lfdr.de>; Wed,  8 May 2024 03:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C121312E70;
	Wed,  8 May 2024 03:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mmIgx4be"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9A9125AE;
	Wed,  8 May 2024 03:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715137632; cv=fail; b=FE4rpUm6yw6d6frjflxUyGsP5cPX0qBKQmoWOuumV/a9Oea1EENrVO40pUFVtAx67jf0pH3JYzqugWZ7uLr6hUnI2e7Oy3JrbBZ/pvg2KGSd8mNCZeQ9LSTMdvtgPgPU+GAfKBW+U+kjS9XeGm/IbjRt0yfUfuEN6/DpLcw+8yI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715137632; c=relaxed/simple;
	bh=G7IT+m6++i1QkleRuYraHetl6tBw3G9jCnngpiWmyzI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gpNz7P/CrOEfKYfIIknL9CHwZma9KbEFS7LCe3uwm7YWjpV4fIc1PNb/GhsqLrEt7a+zYFOKBjtKcVCT+UOZzsyBpWKzN37rhc2xXQVl6R6YS+BUNpJA/SlAEn8tLckGH7lo70Uj91lzcz1uz91EiE6B5ZGjRy0QR5C/jfBYbaE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mmIgx4be; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715137630; x=1746673630;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=G7IT+m6++i1QkleRuYraHetl6tBw3G9jCnngpiWmyzI=;
  b=mmIgx4beC3D0jbcswn5OhppX/Fpk+elLiG7C1zX+LADrISdg73U0Hq2N
   5oCsT3Uf9h8i9vSNuol8/y/JlLvP0ApRBJ29H+JfRti3d429mNExjnOAK
   nK3vywUy2Y1A/CvoeGHaRBnNu5HVsBHgyG7rZ2BoyRt0Ed5eC7PcijtuE
   btSQkYWU0X3q1kS+xds0lm6Ib7BHZvvP7tkTWuPqFhSdZcCY1Bf4O4Luf
   ZRwfHMwTVNMSreGE7jDi+z8ioOxmV8jyZ1pfSVAEXJKTO5RGb+mZnV1RB
   037d1OZ6VQT3vxF8p6vj4J18FfU/2UbOLn4lgCwjWHJqquMpKgC3uJ77j
   g==;
X-CSE-ConnectionGUID: 9YiuxFheRcOdCoSGMjfA0A==
X-CSE-MsgGUID: pZVEDmbaR+KqaY6Ola19Zg==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="22128564"
X-IronPort-AV: E=Sophos;i="6.08,144,1712646000"; 
   d="scan'208";a="22128564"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 20:07:10 -0700
X-CSE-ConnectionGUID: 6EE4ZFoBQBOWU/5T+sSn2A==
X-CSE-MsgGUID: UhpL5fWcTIO9hFPXI5kNdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,144,1712646000"; 
   d="scan'208";a="28710840"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 May 2024 20:06:52 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 7 May 2024 20:06:52 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 7 May 2024 20:06:52 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 7 May 2024 20:06:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UNZz4kWskSeV8rcURLCFOSRGBcXsiUl8mQEqdC9uoVuQZ2jKVp1lqp5Wh1C98sHnAaHZ5FMZFXRZDh70du8ppSGnGrFojJtgjTSjSxkvg8Q2qcOOXoDn6wMbHAPQT8c2Q46U2TsFlThTNG7wUUv+0GYF1breUEzdngCKc1tUf+qoe1DYQerPgjFge4O4+f2rNMycyOOJfqxDADLYRQKahR9Wx2pvzmNpgxHcAec4XD1ix3e7eSW5vQ35TY1XUNky1/YT//h2GKajydwbLMfL3i93M9+6H0s7v8nXEToBX46pbHOdvIuDV74Mp3oYRVvrnzwSl8a5KE9VjnX1dzU33A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D3wMUJ8zsuD8Lfi2fbq30gcZNOmZo9necqMpkiv7Zrc=;
 b=eBYo0PnEBr9EfUf6Ff1b9FoMkzTzelzQm6Yg2cbr8NGVXq8q0UHNfMEkqHWl0aimFu66kQk9OdUldIy8faXu8tmK+g4Gh+2ZHeYwdcjnhedrixyV2WyH4iYgOd5TTgeSbiaTDks6wR720zk7LaNKdhwWbyyNxSn42g8PRb/WxAS6AfTSWmSKRvB6RiTByCC3UoRp0Y/uyaqAR2lgRvTG8udEacS0bbxeK6pAbuOVJn6Wfbet+wnlMsdLlXC4L1wUgrqxbqbY+90u0wpDonCvR3DR0NJCp/mkIC/eQGM0oVoUXLMxSuA1t2I3PClG4X0k/i7UXJAxzC3rl85iih7toA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8393.namprd11.prod.outlook.com (2603:10b6:806:373::21)
 by CH3PR11MB8093.namprd11.prod.outlook.com (2603:10b6:610:139::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45; Wed, 8 May
 2024 03:06:50 +0000
Received: from SA1PR11MB8393.namprd11.prod.outlook.com
 ([fe80::1835:328e:6bb5:3a45]) by SA1PR11MB8393.namprd11.prod.outlook.com
 ([fe80::1835:328e:6bb5:3a45%4]) with mapi id 15.20.7544.041; Wed, 8 May 2024
 03:06:50 +0000
Date: Wed, 8 May 2024 11:06:45 +0800
From: Yujie Liu <yujie.liu@intel.com>
To: Wei Yang <richard.weiyang@gmail.com>
CC: kernel test robot <lkp@intel.com>, <arnd@arndb.de>, <rppt@kernel.org>,
	<oe-kbuild-all@lists.linux.dev>, <linux-arch@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [PATCH] mm/memblock: discard .text/.data if
 CONFIG_ARCH_KEEP_MEMBLOCK not set
Message-ID: <ZjrsRSryTFOZpT8o@yujie-X299>
References: <20240506012104.10864-1-richard.weiyang@gmail.com>
 <202405071200.YgYuuCBu-lkp@intel.com>
 <20240507084350.mc6e46gecyzaqnhb@master>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240507084350.mc6e46gecyzaqnhb@master>
X-ClientProxiedBy: SG2PR04CA0180.apcprd04.prod.outlook.com
 (2603:1096:4:14::18) To SA1PR11MB8393.namprd11.prod.outlook.com
 (2603:10b6:806:373::21)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8393:EE_|CH3PR11MB8093:EE_
X-MS-Office365-Filtering-Correlation-Id: 813f9219-7250-412b-0a5a-08dc6f0be799
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZwC2EdCJAvaqem8WQ6+5QjR26f/Gv3wRv67D95bqEosdd6L+H4iiXBIhz2Mq?=
 =?us-ascii?Q?2W6h260ikwkNzeSqO37i16DRrZvcbRdnDSlKZuznYwLXeUlCvF/k0IFFzRED?=
 =?us-ascii?Q?DA8+04hwS0LF1lRendkm0s14C3ktCyI9CEeyURhZe97qwl4cMeSLl1cqFf3r?=
 =?us-ascii?Q?pFLA9QYbR2PSa7tSutKBuToxREVMNEZ3Gq5DRvn251t6CuR8PARADtRzofMp?=
 =?us-ascii?Q?IICsUdMAZR7Pdbphb4PCR6Lb+7WrswmiCXqo4n7VTD8V6REik2eFvZhtoXLQ?=
 =?us-ascii?Q?RzTmSN9PKtqaH2RmD0N+iwN8uV2XilOP6m4roGow7QeP4sArj/VPAAOzCwwp?=
 =?us-ascii?Q?imw9Zxa1tivI87/9t6yRiBSYQ31ypS3OHHmGBr2fC5O6jcIRq1uv0IZ1KdjJ?=
 =?us-ascii?Q?8j8JFhn0WCsDm7zL2GwG/jnJmbBTKYENcm4mX5yvH3b9t/29setx+dwTlvte?=
 =?us-ascii?Q?IYCfFUka2fbLpWH5h3XrITK8inNBq7gUUN8j0kpITZCL1/a2Egi2rC9djHGS?=
 =?us-ascii?Q?jOiwxvESsetgl2isDz5rSWOQ7mh8XXnYrMrMRczdp+wnQhAXYFrNYIXONdv5?=
 =?us-ascii?Q?bmwyT6eTbpiWKCWFuz2KwMhzt5VlfpHa0QC0FrDIKTgiYqhi6Jz91SL/O2nS?=
 =?us-ascii?Q?HqLnrwIUBLtyY1atHQwHR9Y0Fo7+oIfZfhieHowzhyLgfWjG+LcG3yKE4WSd?=
 =?us-ascii?Q?pVuu1otENnoqOZyDj3t6vXt7xFMlfzO51o3QLI0eeE/uqk8b/DabqMTXP0Ey?=
 =?us-ascii?Q?0OhzEgYZugRApTmHhIQrHffNuLIPhu/hw1eNKYybBtcpbBEJZE1UCKhA2+c6?=
 =?us-ascii?Q?SkRz0vQBD8Nkz3jFEio/3j6WFtfyg9Mkda/Sgdszi2jntMVBJyMrxmtyswUR?=
 =?us-ascii?Q?nVhLdlYh2KvBW24AwHz4frAPA3J3bTjVcNXWPezvjRMrWrE+2FpaQmlhaBwI?=
 =?us-ascii?Q?DjQtGab+g+ovtUKAog5zA4Ob2S471fGkHh7t+DjxypHRi7/hhA9ab4qJVtam?=
 =?us-ascii?Q?vEBjlgDHIBGTy6/2QpopH8I3Icv6Om6w6/KalE/b9fl2x0J1BSht81Jz0FTA?=
 =?us-ascii?Q?gCOH19ZYbbKuX6PDYDMAmFqWOc38a+l55M1Mht5BAxW3jjcZOUe5rorvndXM?=
 =?us-ascii?Q?s78QRLwNT107BBsBK/66y/zCMJIpn88pZ2XDBWN2lA9KDy8hITTsZ7oINJY4?=
 =?us-ascii?Q?6B/aqRa2H42zhYYlhtlKu9fAM2BVNjPlJ0HwSaReci1oXKmPHFmQu0ptyAs?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8393.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?N1pYivZHFC67mU3onq7OWEjeuCEX1ygB+EnVDhxRBuPPXdPx9pLM+nKpqtPt?=
 =?us-ascii?Q?lbJFiwjkbZkBKjXQo6TU+9wmpCSZvapcH+e1szKth0l7zCGjk6Kf+yvmgv+w?=
 =?us-ascii?Q?8lhmzg35IlVv+T1a8p7fmI4tZfU7ObxDl1St3DkZ1gTj5pe+6XoqV/7VkmsR?=
 =?us-ascii?Q?eWe/VRw/9Zm9aNEA9fdVrff9cp0Hv6pEIRZRDFLC0kmJJFLkw6krz6F6hF0z?=
 =?us-ascii?Q?TDfJq2dEQZkhXX9xKF6p4HP03akBUbL4+tMppM/qfoZ3CtOydjIzRc7FBuox?=
 =?us-ascii?Q?pHhFM5I6prt1fkzuJ3TKs00novZuhsrwzV3N932MU0rrSCoMWrkoz2+C3iPO?=
 =?us-ascii?Q?lBr9LyepGI/cjeyMil7IGGosJAJvuy71RZUNp3f7+SxC6Vmcmdqjx6yDVWSf?=
 =?us-ascii?Q?DrZXN3w8RMVENy1oKbx1ZbsC69Yg191PYnJAGUrOtpS6yZXnQVbQXllHAyO0?=
 =?us-ascii?Q?1Nb3KvREYWzPVk2ygoZK8kDYIBlV2ce1LV8qDnfLzQ0PLjBmM3ll0lxh9kBd?=
 =?us-ascii?Q?1XxfT4b8fJFuPhB3DnoplJWfvPVKAAk1PkWcf2xyT4d4KvdMnJVVzEyYCca4?=
 =?us-ascii?Q?E6ibrRZCWRAg+uzeIwz/Z6X9gh5d8p/cxi555E/aqL26R9gCqQsHeEpA0kJC?=
 =?us-ascii?Q?kDL5bjtTqfGFau6DTfpNnfiUczgegn4c15oWN4WOqk6VD+PDglfFTp4b8vAl?=
 =?us-ascii?Q?Mb/i2lUfF3nyJhdDNd+msn9ZOkE/uT/vlg2v8pSdfxYxNf8PGFu0r+iuhzb6?=
 =?us-ascii?Q?9uvFzguiu/O8MMlAmPOqwNQob0pp4bXxIDQlbX0+nnjg3Cv0OiKPxCAegXWj?=
 =?us-ascii?Q?mh9JfODHHrp3jOatCHoPXSbluyfPFK6TPSflqBi9+3bwjxkGASs1E/zOu0SQ?=
 =?us-ascii?Q?rR7WAhqyTnav+2uahYQQhTsffYROcmbVSv3lht6Rf0RK/CjEzcFedoUdVNa+?=
 =?us-ascii?Q?kTnr6QRKDHJXcAQVT7CQ3lsuZrm+UvsogYR3hnQCf+Vfiz6QDW689rW18ZlX?=
 =?us-ascii?Q?1E752BZyaZRQvoVLdJkxUvLjDgozxCjk848EClXYY/7rTgdIcJ4BPzrNIX5V?=
 =?us-ascii?Q?VQvdDoiv7jrooJ57/CGDRGmrSqxPP/0xFyEcDWkDys45OLjDOclBrYDkl8yi?=
 =?us-ascii?Q?IxL6eY3WGlc4YkgG0S29ZMdSL3Tu7SlEV+0mAW1bIX8S//0tRepvcNcYXqHz?=
 =?us-ascii?Q?DQxjSgb/Vx/MqemPPyonUb6B0CgfQZE9xFIrjvG3PI8tTPZCIipoHkYlV6Lm?=
 =?us-ascii?Q?CVczYBmkMfzQciC5eHyllL6VngDAmWr7t7aAGNp652eku40pOt/DO9hX3dqc?=
 =?us-ascii?Q?jQi/bt2ZfE6V/8fJT8wlWQ3CHx65wKiJ65vkr6ITrqIus5DemvWTxF8xUyHF?=
 =?us-ascii?Q?ESZCQ5Aaya4aaekJ6xnsOJ54virr4gZk2bV4zaGd0IINZR+y70x+KexEXtxW?=
 =?us-ascii?Q?W5IXMNvgJtqthlX/FAamk0muVX/T6d7e2mUcMKFFpQ5BxmhgaHPzg3UUikCq?=
 =?us-ascii?Q?WD7Nm9n+e2dOJxW2enKrOyg7XVlwWU0gbK11ilFMwDqDfedZzV3ECqPviPgI?=
 =?us-ascii?Q?+vUF9Sd3H5nZRzjXhO47onIWNhgwNF+mgmkLjyOW?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 813f9219-7250-412b-0a5a-08dc6f0be799
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8393.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 03:06:50.2096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qJvIQbN7J1mbCKiJhsM/xRhZVIv1mCKdRfljCzb0KsOhEUnhHWT9SIsN5/UKo6Y7cJS+SnwtouJcKku1LVEZBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8093
X-OriginatorOrg: intel.com

On Tue, May 07, 2024 at 08:43:50AM +0000, Wei Yang wrote:
> On Tue, May 07, 2024 at 01:13:05PM +0800, kernel test robot wrote:
> >Hi Wei,
> >
> >kernel test robot noticed the following build warnings:
> >
> >[auto build test WARNING on akpm-mm/mm-everything]
> >
> >url:    https://github.com/intel-lab-lkp/linux/commits/Wei-Yang/mm-memblock-discard-text-data-if-CONFIG_ARCH_KEEP_MEMBLOCK-not-set/20240506-092345
> >base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
> >patch link:    https://lore.kernel.org/r/20240506012104.10864-1-richard.weiyang%40gmail.com
> >patch subject: [PATCH] mm/memblock: discard .text/.data if CONFIG_ARCH_KEEP_MEMBLOCK not set
> >config: powerpc-allnoconfig
> >compiler: powerpc-linux-gcc (GCC) 13.2.0
> >reproduce (this is a W=1 build):
> >
> >If you fix the issue in a separate patch/commit (i.e. not just a new version of
> >the same patch/commit), kindly add following tags
> >| Reported-by: kernel test robot <lkp@intel.com>
> >| Closes: https://lore.kernel.org/oe-kbuild-all/202405071200.YgYuuCBu-lkp@intel.com/
> >
> >All warnings (new ones prefixed by >>):
> >
> >>> powerpc-linux-ld: warning: orphan section `.mbinit.text' from `mm/memblock.o' being placed in section `.mbinit.text'
> >>> powerpc-linux-ld: warning: orphan section `.mbinit.text' from `mm/memblock.o' being placed in section `.mbinit.text'
> >>> powerpc-linux-ld: warning: orphan section `.mbinit.text' from `mm/memblock.o' being placed in section `.mbinit.text'
> >
> >-- 
> >0-DAY CI Kernel Test Service
> >https://github.com/intel/lkp-tests/wiki
> 
> >reproduce (this is a W=1 build):
> >        git clone https://github.com/intel/lkp-tests.git ~/lkp-tests
> >        git remote add akpm-mm https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git
> >        git fetch akpm-mm mm-everything
> >        git checkout akpm-mm/mm-everything
> >        b4 shazam https://lore.kernel.org/r/20240506012104.10864-1-richard.weiyang@gmail.com
> >        # save the config file
> >        mkdir build_dir && cp config build_dir/.config
> >        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-13.2.0 ~/lkp-tests/kbuild/make.cross W=1 O=build_dir ARCH=powerpc olddefconfig
> >        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-13.2.0 ~/lkp-tests/kbuild/make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash
> 
> Can I reproduce this on x86? I don't have a powerpc machine.

The above steps are cross compiling for powerpc target on x86
machine, so you can just follow the steps to reproduce on x86.

Thanks,
Yujie

