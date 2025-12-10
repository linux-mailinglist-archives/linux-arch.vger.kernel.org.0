Return-Path: <linux-arch+bounces-15324-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C94CB33AE
	for <lists+linux-arch@lfdr.de>; Wed, 10 Dec 2025 15:56:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C04C304D0F7
	for <lists+linux-arch@lfdr.de>; Wed, 10 Dec 2025 14:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8791724BBEB;
	Wed, 10 Dec 2025 14:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IXPlJ2JK"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765DE24A063
	for <linux-arch@vger.kernel.org>; Wed, 10 Dec 2025 14:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765378565; cv=fail; b=BWjQNoiOzMWSgf7AprFuPLJt+gLM8qsoL7jH269Prj2NTK6oo60mPJdXQSnuFhdOwFP2oCLqw1LuNVTRv7nx248VpEWsDU2VURimarkpFInPWAarLAW1eTLjhI38KWbiE/Zr+BHJSEpPBujfGssb7i/vk8iy6e8bJDStIkCHkug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765378565; c=relaxed/simple;
	bh=NFRWTh8+cGvquOUjKhghqG1yWywc41hQh5SZfj/EUn8=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=iweRQ0xNpb+KKTsk8mwhu8qmxBPTtBNae85T5TjVViRSG5ioJ2IdQcA7Fuz6LPgZk3B7C79AlDaQAHXv+rw1fTAYfvmhtq6YEZOcfxe0lfhUde6/pvszsdGHN0g6OsJMtEfi9JvuwEka6Y1/EgfvTa7PPqwMYKri0XYTpJXq5QI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IXPlJ2JK; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765378563; x=1796914563;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=NFRWTh8+cGvquOUjKhghqG1yWywc41hQh5SZfj/EUn8=;
  b=IXPlJ2JK31EUTgGidtwh0hwdGwBehrlyR9ajWPrqzaOJfNRGKhDnW56h
   RZk7ZAkJ4LMfZ32mb/6ktNOgm56qUTqI4DW9rDNrkQ50tsd5D2rArKgjN
   aSP+970YBpjChWUn9Tdwl1UI2QBUDMImzz33HNg6jPNppVBX6hzlY4gA7
   K11yguhMCkOQJD3BMvaWO7wFz37BjQut+AT47FnqcxDeQKfGeFkUzVvx2
   SomF0AZOsAPKGYR+sfn5cKLNmMHCq5dytufboR8TuhCfmYc5wCbuCKO5O
   dkptIG4fON4cI6msafkWnhCPEcALNXCRYW8dnAZLVghG0uf0MJsirbbf6
   g==;
X-CSE-ConnectionGUID: 91R6quECTWCCzrIN64AnCg==
X-CSE-MsgGUID: trdYWV3BT1aqER3I7isLgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11638"; a="71214670"
X-IronPort-AV: E=Sophos;i="6.20,264,1758610800"; 
   d="scan'208";a="71214670"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2025 06:56:02 -0800
X-CSE-ConnectionGUID: Y5M7dRpyQbGM7mNR9YwDXg==
X-CSE-MsgGUID: yiEO2cRlQ/Sv+IdMv4ZW/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,264,1758610800"; 
   d="scan'208";a="196531807"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2025 06:56:02 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 10 Dec 2025 06:56:01 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Wed, 10 Dec 2025 06:56:01 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.10) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 10 Dec 2025 06:55:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NsEK2AiexXklyvVC9KuWAlC2jtQsW3Li5sHJ/YG5zRm6m8QVUEc7qHLKQHjBuqGSM0W9voOv0ShMehWOiLV0rOiz/0rNVbV7KhvbTmOgj80PSVsmeUdfjGkDhHuYXKGZdJX19HUVSME0pkUBPqhOpX0/iJyx6I7IeOMjb26u7l0b6A+oNI3tM+9BsYROuJX6XvgfQVjEA5Egl1arCoBEZEjno+H076sGeWmgI8V6BiW6xGPyM3urrI0xlN89P6yjzMo0LZK2Pim1V+5BU2B7Gbj+Q7KkwRXya0m6Ws2VWJmMlFP2Md749i0+TCzRneP70SLV6KPOb33kE9KdQuETtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eymuh32uAm6WxTmrKHr7vQaQ6Dl6poJruWRvk3tSsBs=;
 b=XmfNRdNORrFnI4TaP8Mau98XMWzSSnO24c31HAf4zV6Won3UODcnn4y5pGSWCEUJVB4LkMp6adW7RcVyopYmkvPB6ECEKDcO6aT+WxGqHZPWzH2nL33cVMgH9wxwr9Ns3PayD9gRYc4khsRcrM0TricUHfPCWRwF9GAiO3GNaZ49S8Cx4BlNop7CZ/OwP11vKNS/JLkspYo+25eDikpk/vqzb3MVaELyDxYmxHTfKAqwsSSPDtMSOU0Oyyn88cREe4U9tot4hWrTIjNdg5eS8FgrXqiklwJzl52OQhtWZcnHMnNf1Kc4/E+S/uSm1BUZTnf6sk9xh52OPed2G4ZPVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH0PR11MB5901.namprd11.prod.outlook.com (2603:10b6:510:143::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.7; Wed, 10 Dec
 2025 14:55:56 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9412.005; Wed, 10 Dec 2025
 14:55:56 +0000
Date: Wed, 10 Dec 2025 22:55:40 +0800
From: kernel test robot <oliver.sang@intel.com>
To: David Hildenbrand <david@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Andrew Morton
	<akpm@linux-foundation.org>, <suschako@amazon.de>, Laurence Oberman
	<loberman@redhat.com>, <aneesh.kumar@kernel.org>, Arnd Bergmann
	<arnd@arndb.de>, Jann Horn <jannh@google.com>, Liam Howlett
	<liam.howlett@oracle.com>, Liu Shixin <liushixin2@huawei.com>, "Lorenzo
 Stoakes" <lorenzo.stoakes@oracle.com>, Muchun Song <muchun.song@linux.dev>,
	Nadav Amit <nadav.amit@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
	"Oscar Salvador" <osalvador@suse.de>, Peter Zijlstra <peterz@infradead.org>,
	"Prakash Sangappa" <prakash.sangappa@oracle.com>, Rik van Riel
	<riel@surriel.com>, Vlastimil Babka <vbabka@suse.cz>, Will Deacon
	<will@kernel.org>, Lance Yang <lance.yang@linux.dev>,
	<linux-arch@vger.kernel.org>, <linux-mm@kvack.org>, <oliver.sang@intel.com>
Subject: [linux-next:master] [mm/hugetlb]  0e1ad0324a:
 WARNING:at_mm/mmu_gather.c:#tlb_finish_mmu
Message-ID: <202512102246.ee3d6d07-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: KU2P306CA0053.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:3d::19) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH0PR11MB5901:EE_
X-MS-Office365-Filtering-Correlation-Id: 695cf257-7195-467d-9c58-08de37fc3933
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4YlotVGBgLzzrd04KY4HTyt5lFFQMUU9EUZ5y3ywef11A9AFobDzA/ozgTEt?=
 =?us-ascii?Q?KB8OR2XNK5bM+CMt6Gv68bAlB7ltEP8rY6DPB/475V64t3RinvDaMvYaSUfA?=
 =?us-ascii?Q?AQdmeqqwWTFy5JCe8ryZx411yoRYsd/RDqzo9MmqW5KAm+uP4R5zYo3UPkcf?=
 =?us-ascii?Q?At30qBwGy8moQwu+Qbq2eUwIkRwR32yD5AezEq4+80oORaGPgWQEvSIYzHYJ?=
 =?us-ascii?Q?trs/IgtZWpMgaf+vRWOl2OzmDfSI/m67ziGCqAiuS8gHL75f/af/xJHiyXcL?=
 =?us-ascii?Q?I+qAMifvSToXjTNO2XSPpv289F+4+nwcWIzAv//vsh9wRlS3waGABLZtgA+9?=
 =?us-ascii?Q?/IuKVDXRXAgqn1hFWGd2OEHtLwzKjm6LYsK+64xt5eN8OXiethqbNk1AbO9e?=
 =?us-ascii?Q?rUJfEPeSktCKQDB5xmNx1ivkWMKfNxWdZeLvcOQD7gCB2de5XpUBiIIMRXKF?=
 =?us-ascii?Q?gU1vQ9HN8PTNRoJq+S6PqxCVUfsyKRWdNvAMYmF9A5ZQb/pVsBDLRhIcQmV0?=
 =?us-ascii?Q?O51Xk36HTWwxkJcalhI9HM4LYzq2T0IwYhJi9YrILqPJBy44WC672tbRCSn6?=
 =?us-ascii?Q?V0fW6t2dyivo4U2Mae46PFEkYi/wQi8QH0a5xc1OzcK3Ink7N3ZLXkUOs5O+?=
 =?us-ascii?Q?jSMc5Ms3iF/9tMsWiLYd+j9G8W6+JS8gKOM/f0j/p1dUGJtYJsOfj1VWwFC5?=
 =?us-ascii?Q?AODqBeB2eYqGY+6y0KXtdJ87ZWqg8KUJPl+KU+dFlprI8+/VfYO/Wz+QhzM0?=
 =?us-ascii?Q?6t54e1zNVa3xEVclBanntxyn1dxA01oeyFq6rYRlzmHRhMMFds4z47hd5YGw?=
 =?us-ascii?Q?3rLvEPSSsCT7uGsi2ULTwXgC+OEjOGo6NgtkLyWIcQ1mVPhDyQQBsewrGs1J?=
 =?us-ascii?Q?QXM34Bpkfc+3x2HR1jKz66lfLS4Cc0Z/VhGDthj/WOUkzzhWYyRZRpS935J0?=
 =?us-ascii?Q?aiBfV9ssb4FkSy4qZbdRu8bfHkvyxYjnKdMsMNi82Kf4lnLakohF39HMXGrG?=
 =?us-ascii?Q?KqD3xwHNi6Dkjalmb8FR5PZZHI/30XsKKyRWg3EVPQURwrTXvNxqVvGgmyAA?=
 =?us-ascii?Q?13AUjWdNbsKpZaeU5LK+jrLoLR8SrhU02fSY9CgL3j0k/Hr/nspBLa7jgQ61?=
 =?us-ascii?Q?BJcgByhDjBkEckr/oY1cEu+5yIF+ARzWyFzozonE6eyb3UzhtM9Alg2kee6k?=
 =?us-ascii?Q?A6RQ0U4Joss8KUUEXiK0uAMnZ7OQNVYQId40A3tU9coqum1hS1walS98eCvM?=
 =?us-ascii?Q?kJREXEVjx892PGjYJm6qb+cErVxU6cwuGVgi6SkGWVQ79AsYEGflxIVSOhnS?=
 =?us-ascii?Q?ejpB29nbruh6O+mttWKtKn20+F1moulTj67aw/HJL2OxhEEuarFGNqV7cduK?=
 =?us-ascii?Q?vWaTDsxeyBDJPCmDSw/I90BNW+LdTbNZ5JTTpGPsjscuUNldQmxhmbmRYtQR?=
 =?us-ascii?Q?WxonEOfeeoFPWpTb5lQblTMN+QggIk0FPO5yfdk9XyRRo+YPciLDzQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QgKGyxJeZ4d5NjeQGAJ1NGu4i9Ih//a7L6A16sgVRGnmj0Hv/4Q6kjyYaKgP?=
 =?us-ascii?Q?5dbWagzJp0xCDegiAltJ/E09aw3eIfE3zXM6hsqsH2zSkKTlW5rBz102T9+3?=
 =?us-ascii?Q?PfCMGlIeZtXI2DVFsaiIDtXvxjo2uhAYuEBnfXuBdXqXiW1aMRszIDQxi7qD?=
 =?us-ascii?Q?AuIMU9wUAT1bY5GGTNZgck8pkzl3s3cZavtvzf1+sRs/QYLXPbkXnRq3PEY/?=
 =?us-ascii?Q?lVz9CXo7XxklsPi/m3CrmfsoKN+wU8y8ZrXHpPZsi22kvP6IC/A7aPnYnC2Y?=
 =?us-ascii?Q?mITvgrLZ6pN9oGkAOc9HVcn7c3c0G8chbIN38NA6+AH94G3r7k0yL6QbEVUQ?=
 =?us-ascii?Q?UwBIGc8I6OzDL+cSUPyGm5B1F+FUIu/Lyu3PA/BhvAvZoytqc0KN24Mu7JUR?=
 =?us-ascii?Q?PmUvuQVJkYwxQqwFkDzlOWhDWFVTwLhMktC3Idy+YZIJb+/FTi8oifI14Ksl?=
 =?us-ascii?Q?7hQBoA66U5k4w2xj1UVfcb8WL1sAcaUK39B48dfIf0snZ7Nm5QJmwcRz9yc4?=
 =?us-ascii?Q?QnPLFdUoaPZ4KvqR/96N+yUJE0V0nV2bk6DQ1/FUxRim5hDfOPjyHTsj6QoE?=
 =?us-ascii?Q?wNOGf7Y1g/17Hd/N6zZzv99NyrjgViE74YxDHjKfVQ4//2IJuOWXd9/z4C+j?=
 =?us-ascii?Q?dLJU1BIeSx7XlZ57qfLLlDWfsbLZJJjL6a7g76IA7p/TDEW/JJUi20IDbywN?=
 =?us-ascii?Q?xAOq7oFbWEoqjEWy+Gb+R2i9mjVep1MoE/GfEZJCf3WMgqXzzqjfUryjpYPm?=
 =?us-ascii?Q?FE7LEZhcsZyIQTzmCBzRW2fgjB+g1+a48vyRb9EYfx8Da+FmQ+XYJ2G6KsVJ?=
 =?us-ascii?Q?7kCMzOlM4NGcRvXVjGGE//5lpE7YoHFB9a4gM+bUzaIkriRxm0DDxpSQoUV8?=
 =?us-ascii?Q?rQtwNMW1kb5KeFUTdVR9hYGY6OTiiYTz0VF9+YqE9bZPJl/cxuczrycCrqlz?=
 =?us-ascii?Q?tu6Ke0bkrzACrGp8uqbNjM4DjbOageiEA9L9X2C0VMHBtpUGI/6N6FXPEI/C?=
 =?us-ascii?Q?Xks1Rdndb0a5IDC0AGCiiA0/HhgJY2/zif9fIr2/rxK4nJ3En43o7PXTVE2e?=
 =?us-ascii?Q?+J1wCnpDVxLEMp4led/eNn2Wo5YzMAICkmtZeR0+GQc+jQ3V5mihn+y6/I1u?=
 =?us-ascii?Q?Pbb3R/aHnNwvJMADmglHk73odBfTWl92+2af4nSJh7nL6GxXUEqat8IhhEdJ?=
 =?us-ascii?Q?VU/bOqO+r2EWlqRXg0XXFMMuKmCbJJ2vDltKz3+WeRhduCP/ro1hi1LjZDJG?=
 =?us-ascii?Q?f4yKFzHdegucL9eWZnk0GVJHuEWtmmg3klIKI4nNPMI/ztDyvnBxveE7mo5l?=
 =?us-ascii?Q?sYGpuAuDiSEkj1Je+odX4sVgETHRINiMYjzeCRbSVPrY8K1VH94sHj5HTMAj?=
 =?us-ascii?Q?kaDjpN1vawiEicD7iuVDoo75Rd85Wj9lKmpI8wUzjX1nr/VCsN2UNGqYLIrz?=
 =?us-ascii?Q?decKkOzkqO4qMqqH7Ffz11BsAcM5yhzPVHmpLtbSTPnyejIRKhxzzTe9hVnN?=
 =?us-ascii?Q?BkTVrYg/wFLgZ/4yY1ZY2oDFzmerxBhoq5a7J87opaFqu24G4W5Sr0M9VVYV?=
 =?us-ascii?Q?qZFuveBXIA84+0wJ/p9V/nB2pmtsOEvuuCnd8NfL/iwEkqZWlEaGb7i6alPx?=
 =?us-ascii?Q?yQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 695cf257-7195-467d-9c58-08de37fc3933
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 14:55:56.5494
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: deUZC4U7r5u8MtCI5iDO2WD4lRZJNev8uN/tyLtcJU/qzdvgYhgx3ZB7Zmk28Gye3vnB2xY/Z5Ns75WDZdlsbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5901
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:at_mm/mmu_gather.c:#tlb_finish_mmu" on:

commit: 0e1ad0324aabb5aef3ef409de9a395cda7ee6098 ("mm/hugetlb: fix excessive IPI broadcasts when unsharing PMD tables using mmu_gather")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

in testcase: boot

config: x86_64-randconfig-004-20251209
compiler: gcc-14
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 32G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+--------------------------------------------+------------+------------+
|                                            | ef8ae3fc3a | 0e1ad0324a |
+--------------------------------------------+------------+------------+
| WARNING:at_mm/mmu_gather.c:#tlb_finish_mmu | 0          | 12         |
| RIP:tlb_finish_mmu                         | 0          | 12         |
+--------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202512102246.ee3d6d07-lkp@intel.com


[    5.210750][   T44] ------------[ cut here ]------------
[    5.211469][   T44] WARNING: CPU: 0 PID: 44 at mm/mmu_gather.c:475 tlb_finish_mmu (mm/mmu_gather.c:475)
[    5.212311][   T44] Modules linked in:
[    5.212737][   T44] CPU: 0 UID: 0 PID: 44 Comm: modprobe Tainted: G                T   6.18.0-rc5-00395-g0e1ad0324aab #1 PREEMPT
[    5.214003][   T44] Tainted: [T]=RANDSTRUCT
[    5.214515][   T44] RIP: 0010:tlb_finish_mmu (mm/mmu_gather.c:475)
[    5.215083][   T44] Code: 66 89 47 20 e8 90 fb ff ff ff 86 dc 00 00 00 5d c3 0f 1f 84 00 00 00 00 00 55 48 89 e5 41 54 53 48 89 fb f6 47 21 10 74 04 90 <0f> 0b 90 48 8b 03 8b 80 dc 00 00 00 ff c8 7e 10 80 4b 20 01 48 89
All code
========
   0:	66 89 47 20          	mov    %ax,0x20(%rdi)
   4:	e8 90 fb ff ff       	call   0xfffffffffffffb99
   9:	ff 86 dc 00 00 00    	incl   0xdc(%rsi)
   f:	5d                   	pop    %rbp
  10:	c3                   	ret
  11:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
  18:	00 
  19:	55                   	push   %rbp
  1a:	48 89 e5             	mov    %rsp,%rbp
  1d:	41 54                	push   %r12
  1f:	53                   	push   %rbx
  20:	48 89 fb             	mov    %rdi,%rbx
  23:	f6 47 21 10          	testb  $0x10,0x21(%rdi)
  27:	74 04                	je     0x2d
  29:	90                   	nop
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	90                   	nop
  2d:	48 8b 03             	mov    (%rbx),%rax
  30:	8b 80 dc 00 00 00    	mov    0xdc(%rax),%eax
  36:	ff c8                	dec    %eax
  38:	7e 10                	jle    0x4a
  3a:	80 4b 20 01          	orb    $0x1,0x20(%rbx)
  3e:	48                   	rex.W
  3f:	89                   	.byte 0x89

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	90                   	nop
   3:	48 8b 03             	mov    (%rbx),%rax
   6:	8b 80 dc 00 00 00    	mov    0xdc(%rax),%eax
   c:	ff c8                	dec    %eax
   e:	7e 10                	jle    0x20
  10:	80 4b 20 01          	orb    $0x1,0x20(%rbx)
  14:	48                   	rex.W
  15:	89                   	.byte 0x89
[    5.217110][   T44] RSP: 0000:ffff888103fc7c28 EFLAGS: 00010202
[    5.217747][   T44] RAX: 0000000000000000 RBX: ffff888103fc7cc8 RCX: ffff888103fc7c68
[    5.218585][   T44] RDX: ffff888102b85000 RSI: ffff888103fc7cc8 RDI: ffff888103fc7cc8
[    5.219466][   T44] RBP: ffff888103fc7c38 R08: 00007fffffffe000 R09: 00007ffffffff000
[    5.220295][   T44] R10: 0000000094692512 R11: ffff888101b54948 R12: 00007ffeaa1ad000
[    5.221108][   T44] R13: 0000000000000000 R14: ffff888103f70a00 R15: ffff888102b85000
[    5.221923][   T44] FS:  0000000000000000(0000) GS:0000000000000000(0000) knlGS:0000000000000000
[    5.222854][   T44] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    5.223545][   T44] CR2: ffff88883ffff000 CR3: 000000010172b000 CR4: 00000000000406b0
[    5.224429][   T44] Call Trace:
[    5.224782][   T44]  <TASK>
[    5.225096][   T44]  setup_arg_pages (fs/exec.c:674)
[    5.225621][   T44]  load_elf_binary (fs/binfmt_elf.c:1028 (discriminator 1))
[    5.226127][   T44]  ? exec_binprm (fs/exec.c:1670 fs/exec.c:1702)
[    5.226612][   T44]  ? __lock_release+0x4e/0x120
[    5.227188][   T44]  ? exec_binprm (fs/exec.c:1670 fs/exec.c:1702)
[    5.227678][   T44]  ? __this_cpu_preempt_check (lib/smp_processor_id.c:65)
[    5.228270][   T44]  exec_binprm (fs/exec.c:1672 fs/exec.c:1702)
[    5.228746][   T44]  bprm_execve (fs/exec.c:1754)
[    5.229212][   T44]  kernel_execve (fs/exec.c:1922)
[    5.229754][   T44]  call_usermodehelper_exec_async (kernel/umh.c:109)
[    5.230368][   T44]  ? umh_complete (kernel/umh.c:64)
[    5.230867][   T44]  ret_from_fork (arch/x86/kernel/process.c:164)
[    5.231341][   T44]  ? umh_complete (kernel/umh.c:64)
[    5.231813][   T44]  ret_from_fork_asm (arch/x86/entry/entry_64.S:258)
[    5.232321][   T44]  </TASK>
[    5.232643][   T44] irq event stamp: 469
[    5.233065][   T44] hardirqs last  enabled at (477): __up_console_sem (arch/x86/include/asm/irqflags.h:26 arch/x86/include/asm/irqflags.h:109 arch/x86/include/asm/irqflags.h:151 kernel/printk/printk.c:345)
[    5.234028][   T44] hardirqs last disabled at (484): __up_console_sem (kernel/printk/printk.c:343 (discriminator 3))
[    5.235062][   T44] softirqs last  enabled at (504): handle_softirqs (kernel/softirq.c:469 (discriminator 2) kernel/softirq.c:650 (discriminator 2))
[    5.236041][   T44] softirqs last disabled at (493): __do_softirq (kernel/softirq.c:657)
[    5.236959][   T44] ---[ end trace 0000000000000000 ]---


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20251210/202512102246.ee3d6d07-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


