Return-Path: <linux-arch+bounces-10039-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8F5A2A25A
	for <lists+linux-arch@lfdr.de>; Thu,  6 Feb 2025 08:34:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 366ED162BA6
	for <lists+linux-arch@lfdr.de>; Thu,  6 Feb 2025 07:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C5B224AF5;
	Thu,  6 Feb 2025 07:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PIucU8ih"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA92214239;
	Thu,  6 Feb 2025 07:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738827279; cv=fail; b=Z+5eEuzohr780macVqGvr12+I9KRi5aN1td1niH8Q+FuN/BMrEmSoPmooq1CIBeAsbyow+JCTVabXgHZB6SMofClj5tj+76BbyKk+7MPCuHcLt5/GeFqk9EUGBbvHDYdZljvTk3Y/m6EYHeAzw4W08kBd0CIH9BR1peclu5VJMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738827279; c=relaxed/simple;
	bh=etaFPeyuVjpu5eDAXWgbbSM76eQ5OxjpnYI7pjiCH+4=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=B9YCuF3di4e7cXbOF+bT1OxVp28lYFCePWKfSbR6G4WftETllsf1VyAejT0Itp48Z6OHLP+eJwuXLIKHRRPTg3kuGRfnuLhrWJ2XqOHEjkR2rnPCI4GjFE+hOfZru9S5M46C+pbtipBRltECSNFGvznHBkX4Xp0+UtdD/HfHwjk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PIucU8ih; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738827274; x=1770363274;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=etaFPeyuVjpu5eDAXWgbbSM76eQ5OxjpnYI7pjiCH+4=;
  b=PIucU8ihYhloz46yprZd04yfkGp2JFC1jY8kY+4pqVxFxjge7iYxlmL2
   Sva1a9S6B8aHWlCDMgQeOs6uffkNDlq+BlOad2pI1++jY3OFkHDbbc/eN
   yPX9vR0ITiSGiVQs+O1aba66zHFKL+PpBMFHmnwxwVEYCfBwcqzRAKm/0
   fWXTeJ/9dFzfDOs52XcEEEotXaDrgegS4wwTM+rUKznk7Z080I2fI0fcY
   B6AtY8zFRODMrVgQwKKiIhpTP5qgZP3nooxPhwDay6XYA420BPIbmbVcu
   UWG7dK54NmB/Xs0Sf3UFst5Hen4aCluNhJDyNB6BhxltKFPPmbEi/T6fK
   A==;
X-CSE-ConnectionGUID: HgUYDL+NR2ynuoeeI0FhEA==
X-CSE-MsgGUID: YAtPGbU4R/u+JeZt66g3Bg==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39574834"
X-IronPort-AV: E=Sophos;i="6.13,263,1732608000"; 
   d="scan'208";a="39574834"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 23:34:32 -0800
X-CSE-ConnectionGUID: 9Q+EBwvDSoKO6KCHmH/Ffw==
X-CSE-MsgGUID: gyxlT3fLTbazShuouvOERw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="116325120"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Feb 2025 23:34:31 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 5 Feb 2025 23:34:31 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 5 Feb 2025 23:34:31 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 5 Feb 2025 23:34:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=awPpYv0+YXAoiyVRna4ZD4SJiWnTfK4JzQsRlGjfks7sL+ftBTrwf2DFrxoF+ojRR6De7S9G0K/4PtsUmtexd7Xzg1Y8qRknwpEqk+X1rIbNEScayV5j74LZM2SQGMx1sEk6N/Nk5NAMTQ0ORd9DqGybKsT/p8uTiIWOiKhivanJM1Ukrr942o64oTiZrh5bT/jfCacTB93/pd6dECw4MS0yuHd78cjSnCMIoTsuycZe7ywOhM2I+AszK73HHanG/ZUZR3LE6gVG4uLVFuXtMujontA8hviX64oyXF+2f07l8kLytTcO5gZDWJXYrih8FCPRfJSk4dgSdedETGW7Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yz1z7Dzhuyo0dvJJeaJNtoCpSPXo/O9hnj/Q2c+4Pvw=;
 b=eUpTEOXl4RHwEhP35UEUWryvd+JnXvyJm+nx70mUxNwnA5csZ6f8uAuIPMuVx5pP+m/R9CMHrCvhco/XmWgSb8ALAnnddY4gXX2sJBEuxIE3xh63jobcgqriiaVl9YwdrH69nJ4Xi9nQyzVfz/0DcJ1SXbvMXyB4/A1YxdNUBddTXcQNuOdDxUXxuNx8NHqlYnj2JOKTbhV1pTAKN5eyxEmYCW+ymWpOjYPegxa5OdQsxBy37uhm1LlsPbW7trTuxAjRNOLBmJhPCeiyicnri6hEEgACcj/6o9mZJRkhJU8sgpSELykajW1niVWmKqg4icLUNMe3Qeys1r4MWi8q0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH0PR11MB4853.namprd11.prod.outlook.com (2603:10b6:510:40::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.10; Thu, 6 Feb
 2025 07:34:25 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8398.025; Thu, 6 Feb 2025
 07:34:25 +0000
Date: Thu, 6 Feb 2025 15:34:08 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Qi Zheng <zhengqi.arch@bytedance.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, Kevin Brodsky
	<kevin.brodsky@arm.com>, Alexander Gordeev <agordeev@linux.ibm.com>,
	Alexandre Ghiti <alex@ghiti.fr>, Alexandre Ghiti <alexghiti@rivosinc.com>,
	Andreas Larsson <andreas@gaisler.com>, Aneesh Kumar K.V
	<aneesh.kumar@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, David Hildenbrand <david@redhat.com>, "David
 Rientjes" <rientjes@google.com>, Hugh Dickins <hughd@google.com>, Jann Horn
	<jannh@google.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Matthew
 Wilcox" <willy@infradead.org>, Mike Rapoport <rppt@kernel.org>, Muchun Song
	<muchun.song@linux.dev>, Nicholas Piggin <npiggin@gmail.com>, Palmer Dabbelt
	<palmer@dabbelt.com>, Peter Zijlstra <peterz@infradead.org>, Ryan Roberts
	<ryan.roberts@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Vishal Moola
	<vishal.moola@gmail.com>, Will Deacon <will@kernel.org>, Yu Zhao
	<yuzhao@google.com>, <linux-arch@vger.kernel.org>, <linux-mm@kvack.org>,
	<virtualization@lists.linux.dev>, <x86@kernel.org>, <oliver.sang@intel.com>
Subject: [linus:master] [x86]  0b6476f939:  will-it-scale.per_process_ops
 24.8% improvement
Message-ID: <202502061550.43601a45-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KL1PR01CA0023.apcprd01.prod.exchangelabs.com
 (2603:1096:820::35) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH0PR11MB4853:EE_
X-MS-Office365-Filtering-Correlation-Id: e8be5836-a0a5-4223-6b6d-08dd4680ae41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?unJDmjJfP9FE+6a4EZPTT5tHSbqw0PQmN2esl9q0eJCPDHZi5Kk1HSBlul?=
 =?iso-8859-1?Q?FSE6R79t5w2Q49zBTc01MlsNV/2OjIn80vG5BNjG6Q1QKbFjK3n60gy1/Y?=
 =?iso-8859-1?Q?YSs+jvlTFFuxRHCJvQk1uxNSuux+PT1yIeHOInJVaXcqd2hOYl3AhSk83S?=
 =?iso-8859-1?Q?4fLRUElyqotc/5Ir+sXACJtYhd7qMhI1EuOIDD9lXAv912Jw1K40rOxWki?=
 =?iso-8859-1?Q?FWv44rCGtA/MrDBof1G1Mo0MHWHQ1mKrMfk5XTosIgk4NOYxFCDPko+mbp?=
 =?iso-8859-1?Q?IrVoHho/Nsc8WHGCc4nMFmuXcN3Cvy2kXd1gEFL92WAI+hfkJdaOg+eg8b?=
 =?iso-8859-1?Q?OSABQBsaNi5OJSF0Sq9CujxQwRhae/MeVw1JxlPQHntP3FBnKwRowW4H50?=
 =?iso-8859-1?Q?4ma67zAjPrzoiTsti4rKizzu+TVuSA3a+Zo0fcE6CX6TEl9FBJJkBEq0Ws?=
 =?iso-8859-1?Q?FChmxv6eoPhA3QUFpXaw4LaXUlB7K+vrPoJlSxdzL18pSoSSjinTcWKgKE?=
 =?iso-8859-1?Q?RD4lt4Y4wWRIr5SkaWAw7nEmt/d0rpFPgiDT/FifLJhCdrpLr+jP0IP5tm?=
 =?iso-8859-1?Q?xJ675fOK8cZvwrA+83m+pVg2l1Z4iRIRE3c6W58xadKB38QGIkm2rY73l4?=
 =?iso-8859-1?Q?Lmp3Em+jF+pZl6SkhV+SEKdV/SjVPtGw3jkddvIvosNR8KGrS0MplTGcPi?=
 =?iso-8859-1?Q?DGVGdvvZXoDpQby4aCXGIU0iwOgBdov5UAKJd4LJiGH3gvztyW9OzRrjUy?=
 =?iso-8859-1?Q?Qn2+FScn9TwgU18IGRYXL23p5QmyPp++TINrDBUVT2Sd4JhaJ5smp4NRHH?=
 =?iso-8859-1?Q?ESjzzheopYY5u+JHqZjU66sP7owFXWCtM5/iFNPw1EH2FwS8enP/IEtAnj?=
 =?iso-8859-1?Q?fBVNg0QfjpIGkl+/KHF1j0aNrRtwHnfzrvTxezb9o0W/N79aqz8AHvk53K?=
 =?iso-8859-1?Q?8D4ihfXVIZEAeijL/bUaJcn8QZS4FsHZpOHC1XOOwDAOUFXz9fxaeQZ6kA?=
 =?iso-8859-1?Q?g5sMkPtPhx8Mkn3sns5b2IL7ZLAocZYgHGgqLsmmLfg4VnVGrWcdaSSZ+e?=
 =?iso-8859-1?Q?o/CmIkjWtG8wkQc8c6d04+4D86HmtmmwEAC4/mz/WBioPlH2EIJcTk5ahc?=
 =?iso-8859-1?Q?1dge3n9k0hOzXj+CxifHjlFXAlTSR5QkMzM6K+Te9211SS7fa2X6IWvHf8?=
 =?iso-8859-1?Q?VOCZJoGkN8zwxSAU1z2xPABVHNtNFrA5Czj6p0uuLEMmUJXmGNSnsGIK/h?=
 =?iso-8859-1?Q?XEXX9qis2Fm8unfht21tJyKEzEwJRpfRvngtxlLE4QPbKVFrmPGBLNLQez?=
 =?iso-8859-1?Q?l9Z7iV1sNVIHX7/TkxV8LskMsPNRa+3DwQXtgiLWzXMZAzRm97+b6YunDk?=
 =?iso-8859-1?Q?EdfnzeAgv3lPxfPBBw5ASQ13BLbe3Yfw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?Q8yQhRZQRVecwNOos5RdPhI/dSTgc3ALdD8fF1q5XBbnT7kBGc/3fEsla+?=
 =?iso-8859-1?Q?M9bHNsCGTwHEt5NfwW3p1jYIfdsXUcW0tq/oCJk0+/PNxfAT0ymBvgpmzv?=
 =?iso-8859-1?Q?6+cKG1lerIONXMzX+Lt3S5qIh38rSYAnP40pln+pRqJWwndFaHiUsXY+t8?=
 =?iso-8859-1?Q?n03RHafyd4Szh8ZwDzIGygIQstIg9G0n3/fK6iEIv5GASpUKm6u8zZaV00?=
 =?iso-8859-1?Q?/iUmczDGIeEKokZf7O01Y+TgOvx+nZukUoG3K1MBLV8DZw/Q6FQBDUTTVf?=
 =?iso-8859-1?Q?FIbc8gpHQnvovEQfCuufYyhFKyiixiEmXKWnRKPL9C5qciwzzqvBw1NLMF?=
 =?iso-8859-1?Q?mg1ISU7oOl1pbtLuoBSJMcNnHYOQcYU1DSdTmzWdCOOrbs3vt3juOYdfJM?=
 =?iso-8859-1?Q?kaFZNm3vyPk9MwACiKMTSMUdEU2H6FXaUVqLRZleQMxXgdk4kCDLQY1W1z?=
 =?iso-8859-1?Q?5k48GkO18OTe+shk1A4wyIV0sGuE69MvCuyMani7ZijU4fBA8+MAlqglP0?=
 =?iso-8859-1?Q?gTI3RShhODb+Gi4dlBcrOW/7sPBEzT7NTrLivhodLn4hZyKp2jOwgzRN0a?=
 =?iso-8859-1?Q?3GBSeLBRhlj/jY3ke79AuHi8EKB1kBcqf/a8ley9BKWWV3gJNkIgCVzWmI?=
 =?iso-8859-1?Q?QDDn6T2/pUn7vIJERz6nCv3mxlo/kzBFQFUIqZomoFiw3GFFTRrVcna+TT?=
 =?iso-8859-1?Q?BSwb606ouEP6RCVV/Dy61ztB6Rs9XUubJix528rAAQTlNTDF2k30LLgx5F?=
 =?iso-8859-1?Q?imk3+5yGwl63ip0K78/prANHY/tzrMlwIzMumu5eK5QrOYMCvwMRLdh3e0?=
 =?iso-8859-1?Q?7VquEEqK/5w54GxYeTv45RhFAjJH6Nn55kmZMHQmGblKU4gmMToCctGpnL?=
 =?iso-8859-1?Q?j56bpFhkbgnWu1ffRQhZud73ZBX9BKykMprnndeKobJJASAtXgxFEB1X69?=
 =?iso-8859-1?Q?TYhNt+Bueaaw7ww75/D2RI7dPocFVeIC9nQSgksAxDjUzNgBNFnpVT+tlW?=
 =?iso-8859-1?Q?sqPJ0SrjJu1979lJg0M40GXsafREK3UHbj1e6QEJ0XRCI9aigBjYfacuSa?=
 =?iso-8859-1?Q?SKcgdpqzFU5PIoDs3CRmnVD5h6HZpM8W9spqwjFZVqrXF18YD4XFlM0pdz?=
 =?iso-8859-1?Q?BNTsis9+2myeB4BeicPXSJ0NPeeBwf+mjt3Mb1e9aWuJkrpkUUAMfK6cZT?=
 =?iso-8859-1?Q?8aGiqDBSgSh7d/lFMAmBQ2cE9AwIN3G/RHoOoAsg74/C1JSafE1pBZMoPF?=
 =?iso-8859-1?Q?g9MjQFmdbLImXP0EiDKyFJKJV7dlEpM8oJWLYY939x7tOCkl+dPijslB0J?=
 =?iso-8859-1?Q?VqGqt2EPD8Lq7vdJOe+iv2b/kW1Yb8lWsRlX5LXOD1igFOhptE9dCVFumf?=
 =?iso-8859-1?Q?aCjxiboDX5B2kiQS1yMOyUgLcTQ5sMa7Bui44T2X4qTGx/u6tF+/tNd6Ll?=
 =?iso-8859-1?Q?FuWJjOVATg806czFGKToNEGgV5LWCRxmLkAaWOpUfY02LiP+lrknkvGago?=
 =?iso-8859-1?Q?aIIGvIOLExjF+xRoM74lm+UeKMI9AvG75YESROqs/eyaPswyIRioOrh+U8?=
 =?iso-8859-1?Q?OSxTGumGlfyPepJ4mg/6eSJ/ir2cPytLnTV6LUAriyyrkfVk5BpVbl3ZOe?=
 =?iso-8859-1?Q?/YJPtngeFUyNSa033Jjkgz2XEiPTk8ZOCaEEgcju6BnpK9SftIAMxhtg?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e8be5836-a0a5-4223-6b6d-08dd4680ae41
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 07:34:25.5515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s/1scnOzGtq4U3M0xSzIupvRJusHl+zRhGSaXmHuXQRfkwYuj+Ix0/4WhNxioDmrKiw+KET2n+4g9WL5Y5ToLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4853
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 24.8% improvement of will-it-scale.per_process_ops on:


commit: 0b6476f93998a20a537ee025f124618488ea36a7 ("x86: pgtable: convert __tlb_remove_table() to use struct ptdesc")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master


testcase: will-it-scale
config: x86_64-rhel-9.4
compiler: gcc-12
test machine: 104 threads 2 sockets (Skylake) with 192G memory
parameters:

	nr_task: 100%
	mode: process
	test: malloc1
	cpufreq_governor: performance






Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250206/202502061550.43601a45-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-9.4/process/100%/debian-12-x86_64-20240206.cgz/lkp-skl-fpga01/malloc1/will-it-scale

commit: 
  deab5a355e ("riscv: pgtable: move pagetable_dtor() to __tlb_remove_table()")
  0b6476f939 ("x86: pgtable: convert __tlb_remove_table() to use struct ptdesc")

deab5a355e5283d3 0b6476f93998a20a537ee025f12 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    214844 ± 24%     -35.0%     139635        meminfo.AnonHugePages
   1117061 ±  5%     +17.1%    1307823        meminfo.Shmem
    128.89 ±  4%      -9.0%     117.23        vmstat.procs.r
      4271           +13.2%       4836        vmstat.system.cs
     40.16           -11.3       28.85        mpstat.cpu.all.soft%
     50.30            +9.6       59.92        mpstat.cpu.all.sys%
      8.49            +1.7       10.14        mpstat.cpu.all.usr%
   3031595           +24.8%    3784029        will-it-scale.104.processes
     29149           +24.8%      36384        will-it-scale.per_process_ops
   3031595           +24.8%    3784029        will-it-scale.workload
    184544 ± 36%     -86.7%      24541        numa-meminfo.node0.Shmem
   1067073 ±  3%     +39.3%    1486342        numa-meminfo.node1.FilePages
   2565157 ±  9%     +13.8%    2919521        numa-meminfo.node1.MemUsed
    932093 ±  7%     +37.6%    1282346        numa-meminfo.node1.Shmem
 1.455e+09 ±  2%     +18.1%  1.718e+09        numa-numastat.node0.local_node
 1.454e+09 ±  2%     +18.2%  1.719e+09        numa-numastat.node0.numa_hit
  1.37e+09           +31.6%  1.803e+09        numa-numastat.node1.local_node
  1.37e+09           +31.6%  1.804e+09        numa-numastat.node1.numa_hit
      1148 ±  7%     -74.0%     299.00        perf-c2c.DRAM.remote
      7675 ±  3%     -30.7%       5319        perf-c2c.HITM.local
    373.33 ± 18%     -72.7%     102.00        perf-c2c.HITM.remote
      8048 ±  4%     -32.6%       5421        perf-c2c.HITM.total
     46142 ± 36%     -86.7%       6139        numa-vmstat.node0.nr_shmem
 1.454e+09 ±  2%     +18.2%  1.719e+09        numa-vmstat.node0.numa_hit
 1.455e+09 ±  2%     +18.1%  1.718e+09        numa-vmstat.node0.numa_local
    266935 ±  3%     +39.1%     371355        numa-vmstat.node1.nr_file_pages
    233190 ±  7%     +37.4%     320356        numa-vmstat.node1.nr_shmem
  1.37e+09           +31.6%  1.804e+09        numa-vmstat.node1.numa_hit
  1.37e+09           +31.6%  1.803e+09        numa-vmstat.node1.numa_local
    460912 ±  3%      +9.9%     506403        proc-vmstat.nr_active_anon
    182574            -1.3%     180138        proc-vmstat.nr_anon_pages
    104.76 ± 24%     -34.8%      68.31        proc-vmstat.nr_anon_transparent_hugepages
   1155550            +4.1%    1203477        proc-vmstat.nr_file_pages
    279114 ±  5%     +17.2%     327040        proc-vmstat.nr_shmem
    460912 ±  3%      +9.9%     506403        proc-vmstat.nr_zone_active_anon
     50633 ± 16%     +22.2%      61886        proc-vmstat.numa_hint_faults
 2.824e+09           +24.7%  3.523e+09        proc-vmstat.numa_hit
 2.824e+09           +24.7%  3.521e+09        proc-vmstat.numa_local
     10504 ±131%    +192.8%      30754        proc-vmstat.numa_pages_migrated
    156397 ±  4%     +51.5%     236908        proc-vmstat.numa_pte_updates
 2.888e+09           +24.6%  3.599e+09        proc-vmstat.pgalloc_normal
 9.135e+08           +24.8%   1.14e+09        proc-vmstat.pgfault
 2.888e+09           +24.6%  3.598e+09        proc-vmstat.pgfree
     10504 ±131%    +192.8%      30754        proc-vmstat.pgmigrate_success
      2.67           -26.1%       1.98        perf-stat.i.MPKI
 1.866e+10           +25.5%  2.342e+10        perf-stat.i.branch-instructions
      0.54            -0.0        0.53        perf-stat.i.branch-miss-rate%
  99562288           +23.4%  1.229e+08        perf-stat.i.branch-misses
 2.431e+08            -7.2%  2.255e+08        perf-stat.i.cache-misses
 7.178e+08            -7.5%  6.639e+08        perf-stat.i.cache-references
      4192           +14.0%       4778        perf-stat.i.context-switches
      3.12           -20.6%       2.48        perf-stat.i.cpi
    247.31 ±  2%      +6.7%     263.90        perf-stat.i.cpu-migrations
      1168            +7.4%       1254        perf-stat.i.cycles-between-cache-misses
 9.086e+10           +25.6%  1.141e+11        perf-stat.i.instructions
      0.32           +25.8%       0.40        perf-stat.i.ipc
      0.12 ± 13%     -24.4%       0.09        perf-stat.i.major-faults
     57.63           +25.4%      72.26        perf-stat.i.metric.K/sec
   2997221           +25.4%    3757891        perf-stat.i.minor-faults
   2997221           +25.4%    3757891        perf-stat.i.page-faults
      2.68           -26.1%       1.98        perf-stat.overall.MPKI
      0.53            -0.0        0.52        perf-stat.overall.branch-miss-rate%
      3.13           -20.6%       2.48        perf-stat.overall.cpi
      1168            +7.4%       1255        perf-stat.overall.cycles-between-cache-misses
      0.32           +26.0%       0.40        perf-stat.overall.ipc
 1.859e+10           +25.6%  2.334e+10        perf-stat.ps.branch-instructions
  99198137           +23.4%  1.224e+08        perf-stat.ps.branch-misses
 2.422e+08            -7.2%  2.248e+08        perf-stat.ps.cache-misses
 7.152e+08            -7.5%  6.616e+08        perf-stat.ps.cache-references
      4176           +14.0%       4759        perf-stat.ps.context-switches
    246.44 ±  2%      +6.7%     262.97        perf-stat.ps.cpu-migrations
 9.052e+10           +25.6%  1.137e+11        perf-stat.ps.instructions
      0.12 ± 13%     -23.9%       0.09        perf-stat.ps.major-faults
   2985845           +25.4%    3745052        perf-stat.ps.minor-faults
   2985845           +25.4%    3745052        perf-stat.ps.page-faults
 2.766e+13           +24.9%  3.455e+13        perf-stat.total.instructions
  52114425 ±  5%     +39.1%   72514731        sched_debug.cfs_rq:/.avg_vruntime.avg
  24708162 ± 11%     +93.2%   47729882        sched_debug.cfs_rq:/.avg_vruntime.min
  17754158 ±  3%     -14.5%   15172231        sched_debug.cfs_rq:/.avg_vruntime.stddev
  48499502 ±  6%     +14.4%   55505163        sched_debug.cfs_rq:/.left_deadline.max
   8816245 ±  9%     +18.1%   10407676        sched_debug.cfs_rq:/.left_deadline.stddev
  48499431 ±  6%     +13.9%   55252174        sched_debug.cfs_rq:/.left_vruntime.max
   8812699 ±  9%     +17.8%   10385626        sched_debug.cfs_rq:/.left_vruntime.stddev
    491538 ± 16%     -23.7%     374926        sched_debug.cfs_rq:/.load.max
    354.99           -21.9%     277.32        sched_debug.cfs_rq:/.load_avg.avg
    798.56 ± 10%     -23.9%     608.00        sched_debug.cfs_rq:/.load_avg.max
    153.36 ±  5%     -33.3%     102.30        sched_debug.cfs_rq:/.load_avg.stddev
  52114431 ±  5%     +39.1%   72514695        sched_debug.cfs_rq:/.min_vruntime.avg
  24708179 ± 11%     +93.2%   47729882        sched_debug.cfs_rq:/.min_vruntime.min
  17754155 ±  3%     -14.5%   15172192        sched_debug.cfs_rq:/.min_vruntime.stddev
      1.96 ± 20%     -43.2%       1.11        sched_debug.cfs_rq:/.removed.runnable_avg.avg
     11.48 ±  8%     -22.1%       8.94        sched_debug.cfs_rq:/.removed.runnable_avg.stddev
      1.96 ± 20%     -43.2%       1.11        sched_debug.cfs_rq:/.removed.util_avg.avg
     11.47 ±  8%     -22.1%       8.94        sched_debug.cfs_rq:/.removed.util_avg.stddev
  48499431 ±  6%     +13.9%   55252174        sched_debug.cfs_rq:/.right_vruntime.max
   8812699 ±  9%     +17.8%   10385626        sched_debug.cfs_rq:/.right_vruntime.stddev
      2288 ±  3%    +309.9%       9379        sched_debug.cfs_rq:/.runnable_avg.max
    231.94 ±  2%    +270.0%     858.23        sched_debug.cfs_rq:/.runnable_avg.stddev
     93.29 ±  3%      -8.3%      85.56        sched_debug.cfs_rq:/.util_avg.stddev
    537.20 ±  6%     +18.1%     634.25        sched_debug.cfs_rq:/.util_est.avg
      1355           +15.9%       1571        sched_debug.cfs_rq:/.util_est.max
    191.53 ± 11%     +21.2%     232.19        sched_debug.cfs_rq:/.util_est.stddev
     22.91 ±  7%     -27.5%      16.62        sched_debug.cpu.clock.stddev
      1057 ± 25%     +50.4%       1591        sched_debug.cpu.curr->pid.min
      0.00 ±  9%     -26.5%       0.00        sched_debug.cpu.next_balance.stddev
      7279           +10.6%       8052        sched_debug.cpu.nr_switches.avg
     17374 ±  3%     +14.7%      19923        sched_debug.cpu.nr_switches.max
      4459 ±  3%     +11.6%       4978        sched_debug.cpu.nr_switches.min
      2400 ±  3%     +12.6%       2703        sched_debug.cpu.nr_switches.stddev
      0.00 ± 70%    +200.0%       0.00        sched_debug.cpu.nr_uninterruptible.avg
     16.28 ±  5%     +36.2%      22.17        sched_debug.cpu.nr_uninterruptible.max
    -20.67           +40.3%     -29.00 ±  3%  sched_debug.cpu.nr_uninterruptible.min
     20.65 ±  5%     -41.4%      12.10        perf-sched.sch_delay.avg.ms.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.alloc_pages_noprof.pte_alloc_one
     21.15 ±  8%     -47.0%      11.22        perf-sched.sch_delay.avg.ms.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.folio_alloc_mpol_noprof.vma_alloc_folio_noprof
     22.51 ±  4%     -38.8%      13.77        perf-sched.sch_delay.avg.ms.__cond_resched.__anon_vma_prepare.__vmf_anon_prepare.do_anonymous_page.__handle_mm_fault
      4.68 ± 45%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.__do_fault.do_read_fault.do_pte_missing.__handle_mm_fault
     28.18 ± 32%     -50.2%      14.03        perf-sched.sch_delay.avg.ms.__cond_resched.__kmalloc_node_noprof.alloc_slab_obj_exts.allocate_slab.___slab_alloc
     21.24 ± 18%     -30.4%      14.79        perf-sched.sch_delay.avg.ms.__cond_resched.__put_anon_vma.unlink_anon_vmas.free_pgtables.vms_clear_ptes
     23.09 ±  6%     -38.4%      14.23        perf-sched.sch_delay.avg.ms.__cond_resched.__tlb_batch_free_encoded_pages.tlb_finish_mmu.vms_clear_ptes.part
      0.35 ±  5%     -25.6%       0.26        perf-sched.sch_delay.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
     22.80 ± 15%     -33.9%      15.06        perf-sched.sch_delay.avg.ms.__cond_resched.down_write.__anon_vma_prepare.__vmf_anon_prepare.do_anonymous_page
     21.73 ± 30%     -54.0%      10.00        perf-sched.sch_delay.avg.ms.__cond_resched.down_write.__mmap_new_vma.__mmap_region.do_mmap
     19.09 ± 20%     -39.3%      11.58        perf-sched.sch_delay.avg.ms.__cond_resched.down_write.unlink_anon_vmas.free_pgtables.vms_clear_ptes
     22.47 ± 23%     -40.9%      13.29        perf-sched.sch_delay.avg.ms.__cond_resched.down_write.vms_gather_munmap_vmas.do_vmi_align_munmap.do_vmi_munmap
     22.05 ±  9%     -37.5%      13.79        perf-sched.sch_delay.avg.ms.__cond_resched.down_write_killable.__vm_munmap.__x64_sys_munmap.do_syscall_64
     22.85 ± 10%     -44.7%      12.64        perf-sched.sch_delay.avg.ms.__cond_resched.down_write_killable.vm_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.38 ± 43%    +288.4%       5.34        perf-sched.sch_delay.avg.ms.__cond_resched.dput.__fput.__x64_sys_close.do_syscall_64
      0.09 ± 91%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.dput.terminate_walk.path_openat.do_filp_open
      6.39 ± 15%     +34.3%       8.58        perf-sched.sch_delay.avg.ms.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
      4.35 ±100%    +296.2%      17.23        perf-sched.sch_delay.avg.ms.__cond_resched.khugepaged.kthread.ret_from_fork.ret_from_fork_asm
     24.01 ± 16%     -40.5%      14.28        perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.__anon_vma_prepare.__vmf_anon_prepare.do_anonymous_page
     24.01 ±  6%     -50.3%      11.94        perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.__mmap_new_vma
     21.86 ±  4%     -41.2%      12.85        perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_alloc.__mmap_new_vma.__mmap_region
      0.50 ±  4%     -52.5%       0.24        perf-sched.sch_delay.avg.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     21.32 ±  2%     -38.1%      13.20        perf-sched.sch_delay.avg.ms.__cond_resched.unmap_vmas.vms_clear_ptes.part.0
     21.30 ±  6%     -40.8%      12.60        perf-sched.sch_delay.avg.ms.__cond_resched.zap_pmd_range.isra.0.unmap_page_range
     23.53           -48.6%      12.08        perf-sched.sch_delay.avg.ms.__cond_resched.zap_pte_range.zap_pmd_range.isra.0
      7.44 ± 44%     -71.4%       2.13        perf-sched.sch_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      0.30 ± 31%     -67.2%       0.10        perf-sched.sch_delay.avg.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.53 ± 43%     -96.4%       0.02        perf-sched.sch_delay.avg.ms.irq_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.71 ±124%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
     22.49 ±  2%     -39.7%      13.56        perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown].[unknown]
     15.16 ±  2%     -40.6%       9.01        perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
     19.71           -42.3%      11.36        perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
     15.44 ± 42%     -99.9%       0.02        perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown].[unknown]
     22.42 ± 30%     -33.3%      14.96        perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
     24.65 ± 34%     -37.1%      15.51        perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown].[unknown]
      0.17 ± 14%     -20.2%       0.13        perf-sched.sch_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      8.56 ± 24%     -72.9%       2.32        perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range.do_poll.constprop.0.do_sys_poll
      0.20 ± 23%    +112.4%       0.43        perf-sched.sch_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      2.38 ± 25%     -57.9%       1.00        perf-sched.sch_delay.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.98 ±  6%     -48.2%       0.50        perf-sched.sch_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.66 ±  8%     -71.4%       0.19        perf-sched.sch_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      7.76           -42.0%       4.50        perf-sched.sch_delay.avg.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      1.40 ± 16%     -36.3%       0.89        perf-sched.sch_delay.avg.ms.wait_for_partner.fifo_open.do_dentry_open.vfs_open
      1.24 ±  5%     -30.2%       0.87        perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
     77.79 ±  5%     -42.6%      44.67        perf-sched.sch_delay.max.ms.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.alloc_pages_noprof.pte_alloc_one
     75.22 ±  4%     -43.6%      42.43        perf-sched.sch_delay.max.ms.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.folio_alloc_mpol_noprof.vma_alloc_folio_noprof
     79.88 ±  5%     -43.6%      45.02        perf-sched.sch_delay.max.ms.__cond_resched.__anon_vma_prepare.__vmf_anon_prepare.do_anonymous_page.__handle_mm_fault
     15.34 ±104%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__do_fault.do_read_fault.do_pte_missing.__handle_mm_fault
     73.97 ±  6%     -42.0%      42.93        perf-sched.sch_delay.max.ms.__cond_resched.__kmalloc_node_noprof.alloc_slab_obj_exts.allocate_slab.___slab_alloc
     73.90 ±  3%     -44.2%      41.27        perf-sched.sch_delay.max.ms.__cond_resched.__put_anon_vma.unlink_anon_vmas.free_pgtables.vms_clear_ptes
     79.70 ±  3%     -43.0%      45.46        perf-sched.sch_delay.max.ms.__cond_resched.__tlb_batch_free_encoded_pages.tlb_finish_mmu.vms_clear_ptes.part
     64.55 ± 11%     -37.1%      40.60        perf-sched.sch_delay.max.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
     77.50 ±  2%     -44.9%      42.72        perf-sched.sch_delay.max.ms.__cond_resched.down_write.__anon_vma_prepare.__vmf_anon_prepare.do_anonymous_page
     73.57 ±  8%     -43.3%      41.70        perf-sched.sch_delay.max.ms.__cond_resched.down_write.__mmap_new_vma.__mmap_region.do_mmap
     71.79 ± 12%     -38.8%      43.95        perf-sched.sch_delay.max.ms.__cond_resched.down_write.unlink_anon_vmas.free_pgtables.vms_clear_ptes
     75.01 ±  8%     -45.1%      41.17        perf-sched.sch_delay.max.ms.__cond_resched.down_write.vms_gather_munmap_vmas.do_vmi_align_munmap.do_vmi_munmap
     79.10 ±  3%     -43.4%      44.79        perf-sched.sch_delay.max.ms.__cond_resched.down_write_killable.__vm_munmap.__x64_sys_munmap.do_syscall_64
      4.85 ± 50%     -77.2%       1.10        perf-sched.sch_delay.max.ms.__cond_resched.down_write_killable.exec_mmap.begin_new_exec.load_elf_binary
     78.55 ±  3%     -44.9%      43.30        perf-sched.sch_delay.max.ms.__cond_resched.down_write_killable.vm_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      6.43 ± 68%    +596.9%      44.84        perf-sched.sch_delay.max.ms.__cond_resched.dput.__fput.__x64_sys_close.do_syscall_64
      0.16 ± 99%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.dput.terminate_walk.path_openat.do_filp_open
     78.90 ±  2%     -36.5%      50.06        perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.__anon_vma_prepare.__vmf_anon_prepare.do_anonymous_page
     76.78 ±  3%     -41.8%      44.70        perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.__mmap_new_vma
     78.34 ±  4%     -43.0%      44.68        perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_alloc.__mmap_new_vma.__mmap_region
     65.25 ±  4%     -34.8%      42.55        perf-sched.sch_delay.max.ms.__cond_resched.remove_vma.vms_complete_munmap_vmas.do_vmi_align_munmap.do_vmi_munmap
     18.41 ± 13%     -36.9%      11.62        perf-sched.sch_delay.max.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     59.66 ± 17%     -58.8%      24.60        perf-sched.sch_delay.max.ms.__cond_resched.task_work_run.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
     77.02 ±  4%     -41.7%      44.88        perf-sched.sch_delay.max.ms.__cond_resched.unmap_vmas.vms_clear_ptes.part.0
     78.92 ±  5%     -43.4%      44.71        perf-sched.sch_delay.max.ms.__cond_resched.zap_pmd_range.isra.0.unmap_page_range
     78.32 ±  4%     -43.3%      44.41        perf-sched.sch_delay.max.ms.__cond_resched.zap_pte_range.zap_pmd_range.isra.0
     41.81 ± 38%     -59.2%      17.06        perf-sched.sch_delay.max.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      5.49 ± 35%     -66.2%       1.86        perf-sched.sch_delay.max.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.65           -98.9%       0.03        perf-sched.sch_delay.max.ms.irq_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.87 ± 94%    -100.0%       0.00        perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
     79.90 ±  3%     -42.9%      45.64        perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown].[unknown]
     79.26 ±  3%     -43.7%      44.59        perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
     78.87 ±  3%     -40.4%      47.00        perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
     63.06 ±  8%     -51.1%      30.87        perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown]
     54.83 ±  5%    -100.0%       0.02        perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown].[unknown]
     72.66 ±  8%     -40.5%      43.24        perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
     72.46 ±  5%     -43.6%      40.86        perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown].[unknown]
     66.08 ±  8%     -70.1%      19.76        perf-sched.sch_delay.max.ms.schedule_hrtimeout_range.do_poll.constprop.0.do_sys_poll
      4.79 ± 41%    +493.0%      28.39        perf-sched.sch_delay.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
     49.69 ± 11%     -63.1%      18.35        perf-sched.sch_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
     79.86 ±  3%     -42.8%      45.66        perf-sched.sch_delay.max.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      4.77 ± 12%     -17.9%       3.91        perf-sched.sch_delay.max.ms.wait_for_partner.fifo_open.do_dentry_open.vfs_open
     41.80 ± 33%     -76.6%       9.78        perf-sched.sch_delay.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      9.68 ±  3%     -39.4%       5.86        perf-sched.total_sch_delay.average.ms
     81.19 ±  3%     -38.3%      50.06        perf-sched.total_sch_delay.max.ms
     82.15           -15.1%      69.71        perf-sched.total_wait_and_delay.average.ms
     72.47           -11.9%      63.84        perf-sched.total_wait_time.average.ms
     42.00 ±  6%     -42.4%      24.21        perf-sched.wait_and_delay.avg.ms.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.alloc_pages_noprof.pte_alloc_one
     45.01 ±  4%     -38.8%      27.54        perf-sched.wait_and_delay.avg.ms.__cond_resched.__anon_vma_prepare.__vmf_anon_prepare.do_anonymous_page.__handle_mm_fault
    153.64 ±141%   +2435.1%       3894        perf-sched.wait_and_delay.avg.ms.__cond_resched.__do_fault.do_read_fault.do_pte_missing.__handle_mm_fault
     46.18 ±  6%     -38.4%      28.46        perf-sched.wait_and_delay.avg.ms.__cond_resched.__tlb_batch_free_encoded_pages.tlb_finish_mmu.vms_clear_ptes.part
     44.09 ±  9%     -37.5%      27.58        perf-sched.wait_and_delay.avg.ms.__cond_resched.down_write_killable.__vm_munmap.__x64_sys_munmap.do_syscall_64
     45.70 ± 10%     -44.7%      25.28        perf-sched.wait_and_delay.avg.ms.__cond_resched.down_write_killable.vm_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
     48.03 ± 16%     -40.5%      28.57        perf-sched.wait_and_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.__anon_vma_prepare.__vmf_anon_prepare.do_anonymous_page
     43.71 ±  4%     -41.2%      25.69        perf-sched.wait_and_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_alloc.__mmap_new_vma.__mmap_region
     55.76 ±  4%     -13.6%      48.20        perf-sched.wait_and_delay.avg.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    337.45 ± 10%    +210.9%       1049        perf-sched.wait_and_delay.avg.ms.__cond_resched.task_work_run.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
     42.63 ±  2%     -38.1%      26.41        perf-sched.wait_and_delay.avg.ms.__cond_resched.unmap_vmas.vms_clear_ptes.part.0
     42.61 ±  6%     -40.8%      25.21        perf-sched.wait_and_delay.avg.ms.__cond_resched.zap_pmd_range.isra.0.unmap_page_range
     47.06           -48.6%      24.17        perf-sched.wait_and_delay.avg.ms.__cond_resched.zap_pte_range.zap_pmd_range.isra.0
    562.58 ±  8%     -28.1%     404.28        perf-sched.wait_and_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
     44.97 ±  2%     -39.7%      27.12        perf-sched.wait_and_delay.avg.ms.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown].[unknown]
     30.32 ±  2%     -40.6%      18.02        perf-sched.wait_and_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
     39.80 ±  2%     -42.9%      22.72        perf-sched.wait_and_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
      6.24 ±  2%     -16.0%       5.24        perf-sched.wait_and_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
    125.41 ±  2%     -14.3%     107.45        perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     18.83           -30.8%      13.04        perf-sched.wait_and_delay.avg.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
    462.33           +16.8%     540.00        perf-sched.wait_and_delay.count.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.alloc_pages_noprof.pte_alloc_one
      1041 ±  3%     +52.3%       1586        perf-sched.wait_and_delay.count.__cond_resched.__anon_vma_prepare.__vmf_anon_prepare.do_anonymous_page.__handle_mm_fault
      1373 ±  8%     +30.4%       1791        perf-sched.wait_and_delay.count.__cond_resched.__tlb_batch_free_encoded_pages.tlb_finish_mmu.vms_clear_ptes.part
    167.33 ± 10%     +22.5%     205.00        perf-sched.wait_and_delay.count.__cond_resched.down_write_killable.__vm_munmap.__x64_sys_munmap.do_syscall_64
    123.00 ±  8%     +15.4%     142.00        perf-sched.wait_and_delay.count.__cond_resched.kmem_cache_alloc_noprof.__anon_vma_prepare.__vmf_anon_prepare.do_anonymous_page
    457.67 ±  4%      +9.7%     502.00        perf-sched.wait_and_delay.count.__cond_resched.kmem_cache_alloc_noprof.vm_area_alloc.__mmap_new_vma.__mmap_region
      1266 ±  4%     -58.1%     531.00        perf-sched.wait_and_delay.count.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      6.33 ± 39%     -84.2%       1.00        perf-sched.wait_and_delay.count.__cond_resched.task_work_run.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
    280.33 ±  3%     +10.9%     311.00        perf-sched.wait_and_delay.count.__cond_resched.unmap_vmas.vms_clear_ptes.part.0
    722.33           +22.0%     881.00        perf-sched.wait_and_delay.count.__cond_resched.zap_pmd_range.isra.0.unmap_page_range
      1746 ±  6%     -22.7%       1350        perf-sched.wait_and_delay.count.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown].[unknown]
      6015 ±  4%     +23.9%       7454        perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    434.52 ± 92%     -79.4%      89.35        perf-sched.wait_and_delay.max.ms.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.alloc_pages_noprof.pte_alloc_one
    159.75 ±  5%     -43.6%      90.05        perf-sched.wait_and_delay.max.ms.__cond_resched.__anon_vma_prepare.__vmf_anon_prepare.do_anonymous_page.__handle_mm_fault
      1059 ±141%    +267.6%       3894        perf-sched.wait_and_delay.max.ms.__cond_resched.__do_fault.do_read_fault.do_pte_missing.__handle_mm_fault
    159.40 ±  3%     -43.0%      90.92        perf-sched.wait_and_delay.max.ms.__cond_resched.__tlb_batch_free_encoded_pages.tlb_finish_mmu.vms_clear_ptes.part
    158.19 ±  3%     -43.4%      89.58        perf-sched.wait_and_delay.max.ms.__cond_resched.down_write_killable.__vm_munmap.__x64_sys_munmap.do_syscall_64
    157.11 ±  3%     -44.9%      86.61        perf-sched.wait_and_delay.max.ms.__cond_resched.down_write_killable.vm_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
    157.80 ±  2%     -36.5%     100.12        perf-sched.wait_and_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.__anon_vma_prepare.__vmf_anon_prepare.do_anonymous_page
    156.68 ±  4%     -43.0%      89.37        perf-sched.wait_and_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_alloc.__mmap_new_vma.__mmap_region
    154.05 ±  4%     -41.7%      89.77        perf-sched.wait_and_delay.max.ms.__cond_resched.unmap_vmas.vms_clear_ptes.part.0
    157.84 ±  5%     -43.4%      89.41        perf-sched.wait_and_delay.max.ms.__cond_resched.zap_pmd_range.isra.0.unmap_page_range
    156.64 ±  4%     -43.3%      88.81        perf-sched.wait_and_delay.max.ms.__cond_resched.zap_pte_range.zap_pmd_range.isra.0
    159.80 ±  3%     -42.9%      91.27        perf-sched.wait_and_delay.max.ms.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown].[unknown]
    158.51 ±  3%     -43.7%      89.17        perf-sched.wait_and_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
    271.41 ± 59%     -65.4%      94.01        perf-sched.wait_and_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
    103.47 ± 10%     -61.6%      39.70        perf-sched.wait_and_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
     21.35 ±  7%     -43.3%      12.10        perf-sched.wait_time.avg.ms.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.alloc_pages_noprof.pte_alloc_one
     21.15 ±  8%     -47.0%      11.22        perf-sched.wait_time.avg.ms.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.folio_alloc_mpol_noprof.vma_alloc_folio_noprof
     22.51 ±  4%     -38.8%      13.77        perf-sched.wait_time.avg.ms.__cond_resched.__anon_vma_prepare.__vmf_anon_prepare.do_anonymous_page.__handle_mm_fault
    156.06 ±136%   +2395.8%       3894        perf-sched.wait_time.avg.ms.__cond_resched.__do_fault.do_read_fault.do_pte_missing.__handle_mm_fault
     28.18 ± 32%     -50.2%      14.03        perf-sched.wait_time.avg.ms.__cond_resched.__kmalloc_node_noprof.alloc_slab_obj_exts.allocate_slab.___slab_alloc
     21.24 ± 18%     -30.4%      14.79        perf-sched.wait_time.avg.ms.__cond_resched.__put_anon_vma.unlink_anon_vmas.free_pgtables.vms_clear_ptes
     23.09 ±  6%     -38.4%      14.23        perf-sched.wait_time.avg.ms.__cond_resched.__tlb_batch_free_encoded_pages.tlb_finish_mmu.vms_clear_ptes.part
     22.80 ± 15%     -33.9%      15.06        perf-sched.wait_time.avg.ms.__cond_resched.down_write.__anon_vma_prepare.__vmf_anon_prepare.do_anonymous_page
     21.73 ± 30%     -54.0%      10.00        perf-sched.wait_time.avg.ms.__cond_resched.down_write.__mmap_new_vma.__mmap_region.do_mmap
     19.09 ± 20%     -39.3%      11.58        perf-sched.wait_time.avg.ms.__cond_resched.down_write.unlink_anon_vmas.free_pgtables.vms_clear_ptes
     22.47 ± 23%     -40.9%      13.29        perf-sched.wait_time.avg.ms.__cond_resched.down_write.vms_gather_munmap_vmas.do_vmi_align_munmap.do_vmi_munmap
     22.05 ±  9%     -37.5%      13.79        perf-sched.wait_time.avg.ms.__cond_resched.down_write_killable.__vm_munmap.__x64_sys_munmap.do_syscall_64
     22.85 ± 10%     -44.7%      12.64        perf-sched.wait_time.avg.ms.__cond_resched.down_write_killable.vm_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.38 ± 43%    +288.4%       5.34        perf-sched.wait_time.avg.ms.__cond_resched.dput.__fput.__x64_sys_close.do_syscall_64
      4.36 ±100%    +309.6%      17.85        perf-sched.wait_time.avg.ms.__cond_resched.khugepaged.kthread.ret_from_fork.ret_from_fork_asm
     24.01 ± 16%     -40.5%      14.28        perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_noprof.__anon_vma_prepare.__vmf_anon_prepare.do_anonymous_page
     24.01 ±  6%     -50.3%      11.94        perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.__mmap_new_vma
     21.86 ±  4%     -41.2%      12.85        perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_alloc.__mmap_new_vma.__mmap_region
      7.18 ± 35%    +651.1%      53.94        perf-sched.wait_time.avg.ms.__cond_resched.shmem_inode_acct_blocks.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_write_begin
     55.26 ±  4%     -13.2%      47.96        perf-sched.wait_time.avg.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    307.79 ± 12%    +232.9%       1024        perf-sched.wait_time.avg.ms.__cond_resched.task_work_run.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
     21.32 ±  2%     -38.1%      13.20        perf-sched.wait_time.avg.ms.__cond_resched.unmap_vmas.vms_clear_ptes.part.0
     21.30 ±  6%     -40.8%      12.60        perf-sched.wait_time.avg.ms.__cond_resched.zap_pmd_range.isra.0.unmap_page_range
     23.53           -48.6%      12.08        perf-sched.wait_time.avg.ms.__cond_resched.zap_pte_range.zap_pmd_range.isra.0
    555.14 ±  7%     -27.6%     402.14        perf-sched.wait_time.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      2.45 ± 10%     -16.8%       2.04        perf-sched.wait_time.avg.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
     22.49 ±  2%     -39.7%      13.56        perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown].[unknown]
     15.16 ±  2%     -40.6%       9.01        perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
     20.09 ±  3%     -43.4%      11.36        perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
     15.44 ± 42%     -99.9%       0.02        perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown].[unknown]
     22.42 ± 30%     -33.6%      14.89        perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
     24.65 ± 34%     -37.1%      15.51        perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown].[unknown]
      5.26           -10.1%       4.73        perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
    124.75 ±  2%     -14.0%     107.26        perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     11.08 ±  3%     -22.9%       8.53        perf-sched.wait_time.avg.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.81 ± 25%     -36.1%       0.52        perf-sched.wait_time.avg.ms.wait_for_partner.fifo_open.do_dentry_open.vfs_open
    383.95 ±113%     -88.4%      44.67        perf-sched.wait_time.max.ms.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.alloc_pages_noprof.pte_alloc_one
     75.22 ±  4%     -43.6%      42.43        perf-sched.wait_time.max.ms.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.folio_alloc_mpol_noprof.vma_alloc_folio_noprof
     79.88 ±  5%     -43.6%      45.02        perf-sched.wait_time.max.ms.__cond_resched.__anon_vma_prepare.__vmf_anon_prepare.do_anonymous_page.__handle_mm_fault
      1073 ±138%    +262.8%       3894        perf-sched.wait_time.max.ms.__cond_resched.__do_fault.do_read_fault.do_pte_missing.__handle_mm_fault
     73.97 ±  6%     -42.0%      42.93        perf-sched.wait_time.max.ms.__cond_resched.__kmalloc_node_noprof.alloc_slab_obj_exts.allocate_slab.___slab_alloc
     73.90 ±  3%     -44.2%      41.27        perf-sched.wait_time.max.ms.__cond_resched.__put_anon_vma.unlink_anon_vmas.free_pgtables.vms_clear_ptes
     79.70 ±  3%     -43.0%      45.46        perf-sched.wait_time.max.ms.__cond_resched.__tlb_batch_free_encoded_pages.tlb_finish_mmu.vms_clear_ptes.part
     77.50 ±  2%     -44.9%      42.72        perf-sched.wait_time.max.ms.__cond_resched.down_write.__anon_vma_prepare.__vmf_anon_prepare.do_anonymous_page
     73.57 ±  8%     -43.3%      41.70        perf-sched.wait_time.max.ms.__cond_resched.down_write.__mmap_new_vma.__mmap_region.do_mmap
     71.79 ± 12%     -38.8%      43.95        perf-sched.wait_time.max.ms.__cond_resched.down_write.unlink_anon_vmas.free_pgtables.vms_clear_ptes
     75.01 ±  8%     -45.1%      41.17        perf-sched.wait_time.max.ms.__cond_resched.down_write.vms_gather_munmap_vmas.do_vmi_align_munmap.do_vmi_munmap
     79.10 ±  3%     -43.4%      44.79        perf-sched.wait_time.max.ms.__cond_resched.down_write_killable.__vm_munmap.__x64_sys_munmap.do_syscall_64
     78.55 ±  3%     -44.9%      43.30        perf-sched.wait_time.max.ms.__cond_resched.down_write_killable.vm_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      6.43 ± 68%    +596.9%      44.84        perf-sched.wait_time.max.ms.__cond_resched.dput.__fput.__x64_sys_close.do_syscall_64
     78.90 ±  2%     -36.5%      50.06        perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_noprof.__anon_vma_prepare.__vmf_anon_prepare.do_anonymous_page
     76.78 ±  3%     -41.8%      44.70        perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.__mmap_new_vma
     78.34 ±  4%     -43.0%      44.68        perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_alloc.__mmap_new_vma.__mmap_region
     65.25 ±  4%     -34.8%      42.55        perf-sched.wait_time.max.ms.__cond_resched.remove_vma.vms_complete_munmap_vmas.do_vmi_align_munmap.do_vmi_munmap
     26.48 ± 61%   +1762.1%     493.04        perf-sched.wait_time.max.ms.__cond_resched.shmem_inode_acct_blocks.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_write_begin
     77.02 ±  4%     -41.7%      44.88        perf-sched.wait_time.max.ms.__cond_resched.unmap_vmas.vms_clear_ptes.part.0
     78.92 ±  5%     -43.4%      44.71        perf-sched.wait_time.max.ms.__cond_resched.zap_pmd_range.isra.0.unmap_page_range
     78.32 ±  4%     -43.3%      44.41        perf-sched.wait_time.max.ms.__cond_resched.zap_pte_range.zap_pmd_range.isra.0
     79.90 ±  3%     -42.9%      45.64        perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown].[unknown]
     79.26 ±  3%     -43.7%      44.59        perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
    219.00 ± 90%     -78.5%      47.00        perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
     63.06 ±  8%     -51.1%      30.87        perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown]
     54.83 ±  5%    -100.0%       0.02        perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown].[unknown]
     72.66 ±  8%     -40.5%      43.24        perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
     72.46 ±  5%     -43.6%      40.86        perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown].[unknown]
    113.37 ± 39%     -60.1%      45.24        perf-sched.wait_time.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
     53.78 ±  8%     -60.3%      21.36        perf-sched.wait_time.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
     24.08 ±  8%     -23.4        0.68        perf-profile.calltrace.cycles-pp.tlb_remove_table_rcu.rcu_do_batch.rcu_core.handle_softirqs.run_ksoftirqd
     22.27 ± 10%     -22.3        0.00        perf-profile.calltrace.cycles-pp.__folio_put.tlb_remove_table_rcu.rcu_do_batch.rcu_core.handle_softirqs
     22.26 ± 10%     -22.3        0.00        perf-profile.calltrace.cycles-pp.__mem_cgroup_uncharge.__folio_put.tlb_remove_table_rcu.rcu_do_batch.rcu_core
     21.39 ±  7%     -21.4        0.00        perf-profile.calltrace.cycles-pp.uncharge_batch.__mem_cgroup_uncharge.__folio_put.tlb_remove_table_rcu.rcu_do_batch
     20.48 ±  5%     -20.5        0.00        perf-profile.calltrace.cycles-pp.page_counter_uncharge.uncharge_batch.__mem_cgroup_uncharge.__folio_put.tlb_remove_table_rcu
     18.09 ±  3%     -18.1        0.00        perf-profile.calltrace.cycles-pp.page_counter_cancel.page_counter_uncharge.uncharge_batch.__mem_cgroup_uncharge.__folio_put
     38.58           -12.7       25.86        perf-profile.calltrace.cycles-pp.kthread.ret_from_fork.ret_from_fork_asm
     38.58           -12.7       25.86        perf-profile.calltrace.cycles-pp.ret_from_fork.ret_from_fork_asm
     38.58           -12.7       25.86        perf-profile.calltrace.cycles-pp.ret_from_fork_asm
     38.57           -12.7       25.85        perf-profile.calltrace.cycles-pp.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     38.52           -12.7       25.82        perf-profile.calltrace.cycles-pp.run_ksoftirqd.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     38.51           -12.7       25.82        perf-profile.calltrace.cycles-pp.handle_softirqs.run_ksoftirqd.smpboot_thread_fn.kthread.ret_from_fork
     38.50           -12.7       25.82        perf-profile.calltrace.cycles-pp.rcu_core.handle_softirqs.run_ksoftirqd.smpboot_thread_fn.kthread
     38.48           -12.7       25.80        perf-profile.calltrace.cycles-pp.rcu_do_batch.rcu_core.handle_softirqs.run_ksoftirqd.smpboot_thread_fn
      2.58 ± 11%      -1.8        0.82        perf-profile.calltrace.cycles-pp.__slab_free.kmem_cache_free.rcu_do_batch.rcu_core.handle_softirqs
      1.07 ± 11%      -0.5        0.54        perf-profile.calltrace.cycles-pp.free_frozen_pages.tlb_remove_table_rcu.rcu_do_batch.rcu_core.handle_softirqs
      1.00 ±  5%      -0.3        0.73        perf-profile.calltrace.cycles-pp.vm_area_free_rcu_cb.rcu_do_batch.rcu_core.handle_softirqs.run_ksoftirqd
      0.53 ±  2%      -0.0        0.50        perf-profile.calltrace.cycles-pp.__lruvec_stat_mod_folio.folio_remove_rmap_ptes.zap_present_ptes.zap_pte_range.zap_pmd_range
      0.59            -0.0        0.57        perf-profile.calltrace.cycles-pp.folio_remove_rmap_ptes.zap_present_ptes.zap_pte_range.zap_pmd_range.unmap_page_range
      0.75            +0.1        0.81        perf-profile.calltrace.cycles-pp.zap_present_ptes.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas
      0.54 ±  3%      +0.1        0.67        perf-profile.calltrace.cycles-pp.clear_page_erms.get_page_from_freelist.__alloc_frozen_pages_noprof.alloc_pages_mpol.folio_alloc_mpol_noprof
      0.59 ±  4%      +0.1        0.73        perf-profile.calltrace.cycles-pp.__memcg_slab_post_alloc_hook.kmem_cache_alloc_noprof.__anon_vma_prepare.__vmf_anon_prepare.do_anonymous_page
      0.85            +0.2        1.00        perf-profile.calltrace.cycles-pp.entry_SYSRETQ_unsafe_stack.__mmap
      0.85 ±  2%      +0.2        1.00        perf-profile.calltrace.cycles-pp.entry_SYSRETQ_unsafe_stack.__munmap
      0.58            +0.2        0.75        perf-profile.calltrace.cycles-pp.mas_preallocate.__mmap_new_vma.__mmap_region.do_mmap.vm_mmap_pgoff
      0.59            +0.2        0.77        perf-profile.calltrace.cycles-pp.flush_tlb_func.flush_tlb_mm_range.tlb_finish_mmu.vms_clear_ptes.vms_complete_munmap_vmas
      0.72 ±  3%      +0.2        0.91        perf-profile.calltrace.cycles-pp.__memcg_slab_post_alloc_hook.kmem_cache_alloc_noprof.vm_area_alloc.__mmap_new_vma.__mmap_region
      0.72            +0.2        0.91        perf-profile.calltrace.cycles-pp.perf_event_mmap_event.perf_event_mmap.__mmap_region.do_mmap.vm_mmap_pgoff
      0.93            +0.2        1.14        perf-profile.calltrace.cycles-pp.error_entry.__mmap
      0.95            +0.2        1.16        perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.__mmap
      1.00            +0.2        1.22        perf-profile.calltrace.cycles-pp.unlink_anon_vmas.free_pgtables.vms_clear_ptes.vms_complete_munmap_vmas.do_vmi_align_munmap
      1.03            +0.2        1.26        perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.__munmap
      0.78            +0.2        1.01        perf-profile.calltrace.cycles-pp.mas_wr_node_store.mas_store_prealloc.__mmap_new_vma.__mmap_region.do_mmap
      0.83            +0.2        1.06        perf-profile.calltrace.cycles-pp.perf_event_mmap.__mmap_region.do_mmap.vm_mmap_pgoff.do_syscall_64
      0.89 ±  3%      +0.2        1.13        perf-profile.calltrace.cycles-pp.kmem_cache_alloc_noprof.__anon_vma_prepare.__vmf_anon_prepare.do_anonymous_page.__handle_mm_fault
      0.87            +0.2        1.11        perf-profile.calltrace.cycles-pp.unmapped_area_topdown.vm_unmapped_area.arch_get_unmapped_area_topdown.__get_unmapped_area.do_mmap
      0.89            +0.2        1.13        perf-profile.calltrace.cycles-pp.vm_unmapped_area.arch_get_unmapped_area_topdown.__get_unmapped_area.do_mmap.vm_mmap_pgoff
      0.77            +0.2        1.02        perf-profile.calltrace.cycles-pp.mas_wr_node_store.mas_store_gfp.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap
      0.85            +0.3        1.11        perf-profile.calltrace.cycles-pp.flush_tlb_mm_range.tlb_finish_mmu.vms_clear_ptes.vms_complete_munmap_vmas.do_vmi_align_munmap
      1.01            +0.3        1.28        perf-profile.calltrace.cycles-pp.arch_get_unmapped_area_topdown.__get_unmapped_area.do_mmap.vm_mmap_pgoff.do_syscall_64
      0.98            +0.3        1.25        perf-profile.calltrace.cycles-pp.vms_gather_munmap_vmas.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap.__x64_sys_munmap
      0.95            +0.3        1.23        perf-profile.calltrace.cycles-pp.mas_store_prealloc.__mmap_new_vma.__mmap_region.do_mmap.vm_mmap_pgoff
      1.18            +0.3        1.50        perf-profile.calltrace.cycles-pp.__get_unmapped_area.do_mmap.vm_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.30            +0.3        1.65        perf-profile.calltrace.cycles-pp.__cond_resched.zap_pmd_range.unmap_page_range.unmap_vmas.vms_clear_ptes
      1.79            +0.4        2.15        perf-profile.calltrace.cycles-pp.__vmf_anon_prepare.do_anonymous_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      1.82            +0.4        2.19        perf-profile.calltrace.cycles-pp.__irqentry_text_end
      0.92 ±  2%      +0.4        1.29        perf-profile.calltrace.cycles-pp.get_page_from_freelist.__alloc_frozen_pages_noprof.alloc_pages_mpol.folio_alloc_mpol_noprof.vma_alloc_folio_noprof
      1.66            +0.4        2.03        perf-profile.calltrace.cycles-pp.__anon_vma_prepare.__vmf_anon_prepare.do_anonymous_page.__handle_mm_fault.handle_mm_fault
      1.28 ±  2%      +0.4        1.65        perf-profile.calltrace.cycles-pp.kmem_cache_alloc_noprof.vm_area_alloc.__mmap_new_vma.__mmap_region.do_mmap
      2.14 ±  8%      +0.4        2.53        perf-profile.calltrace.cycles-pp.__memcg_kmem_charge_page.__alloc_frozen_pages_noprof.alloc_pages_mpol.alloc_pages_noprof.pte_alloc_one
      1.08            +0.4        1.48        perf-profile.calltrace.cycles-pp.__mmap_prepare.__mmap_region.do_mmap.vm_mmap_pgoff.do_syscall_64
      0.18 ±141%      +0.4        0.59        perf-profile.calltrace.cycles-pp.__mod_memcg_state.__memcg_kmem_charge_page.__alloc_frozen_pages_noprof.alloc_pages_mpol.alloc_pages_noprof
      1.07            +0.4        1.49        perf-profile.calltrace.cycles-pp.__alloc_frozen_pages_noprof.alloc_pages_mpol.folio_alloc_mpol_noprof.vma_alloc_folio_noprof.alloc_anon_folio
      1.40            +0.4        1.83        perf-profile.calltrace.cycles-pp.vm_area_alloc.__mmap_new_vma.__mmap_region.do_mmap.vm_mmap_pgoff
      1.17            +0.4        1.60        perf-profile.calltrace.cycles-pp.alloc_pages_mpol.folio_alloc_mpol_noprof.vma_alloc_folio_noprof.alloc_anon_folio.do_anonymous_page
      1.18            +0.4        1.62        perf-profile.calltrace.cycles-pp.folio_alloc_mpol_noprof.vma_alloc_folio_noprof.alloc_anon_folio.do_anonymous_page.__handle_mm_fault
      1.29            +0.4        1.73        perf-profile.calltrace.cycles-pp.vma_alloc_folio_noprof.alloc_anon_folio.do_anonymous_page.__handle_mm_fault.handle_mm_fault
      1.57            +0.5        2.04        perf-profile.calltrace.cycles-pp.clear_page_erms.get_page_from_freelist.__alloc_frozen_pages_noprof.alloc_pages_mpol.alloc_pages_noprof
      1.47            +0.5        1.95        perf-profile.calltrace.cycles-pp.mas_store_gfp.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap.__x64_sys_munmap
      0.00            +0.5        0.51        perf-profile.calltrace.cycles-pp.__cmd_record
      0.00            +0.5        0.51        perf-profile.calltrace.cycles-pp.lru_add.folio_batch_move_lru.__folio_batch_add_and_move.do_anonymous_page.__handle_mm_fault
      0.00            +0.5        0.51        perf-profile.calltrace.cycles-pp.perf_session__process_events.record__finish_output.__cmd_record
      0.00            +0.5        0.51        perf-profile.calltrace.cycles-pp.reader__read_event.perf_session__process_events.record__finish_output.__cmd_record
      0.00            +0.5        0.51        perf-profile.calltrace.cycles-pp.record__finish_output.__cmd_record
      0.00            +0.5        0.53        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.__munmap
      0.76 ± 10%      +0.5        1.29        perf-profile.calltrace.cycles-pp.rcu_cblist_dequeue.rcu_do_batch.rcu_core.handle_softirqs.run_ksoftirqd
      2.34 ±  5%      +0.5        2.88        perf-profile.calltrace.cycles-pp.alloc_anon_folio.do_anonymous_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      0.00            +0.6        0.55        perf-profile.calltrace.cycles-pp.try_charge_memcg.__memcg_kmem_charge_page.__alloc_frozen_pages_noprof.alloc_pages_mpol.alloc_pages_noprof
      0.00            +0.6        0.58        perf-profile.calltrace.cycles-pp.find_mergeable_anon_vma.__anon_vma_prepare.__vmf_anon_prepare.do_anonymous_page.__handle_mm_fault
      0.00            +0.6        0.60        perf-profile.calltrace.cycles-pp.mas_empty_area_rev.unmapped_area_topdown.vm_unmapped_area.arch_get_unmapped_area_topdown.__get_unmapped_area
      0.86 ±  2%      +0.9        1.78        perf-profile.calltrace.cycles-pp.get_page_from_freelist.__alloc_frozen_pages_noprof.alloc_pages_mpol.alloc_pages_noprof.get_free_pages_noprof
      0.97            +1.0        1.92        perf-profile.calltrace.cycles-pp.__alloc_frozen_pages_noprof.alloc_pages_mpol.alloc_pages_noprof.get_free_pages_noprof.tlb_remove_table
      3.43            +1.0        4.39        perf-profile.calltrace.cycles-pp.__mmap_new_vma.__mmap_region.do_mmap.vm_mmap_pgoff.do_syscall_64
      1.03 ±  2%      +1.0        2.01        perf-profile.calltrace.cycles-pp.alloc_pages_mpol.alloc_pages_noprof.get_free_pages_noprof.tlb_remove_table.___pte_free_tlb
      1.11 ±  2%      +1.0        2.10        perf-profile.calltrace.cycles-pp.get_free_pages_noprof.tlb_remove_table.___pte_free_tlb.free_pud_range.free_p4d_range
      1.08 ±  2%      +1.0        2.08        perf-profile.calltrace.cycles-pp.alloc_pages_noprof.get_free_pages_noprof.tlb_remove_table.___pte_free_tlb.free_pud_range
      1.73            +1.0        2.74        perf-profile.calltrace.cycles-pp.___pte_free_tlb.free_pud_range.free_p4d_range.free_pgd_range.free_pgtables
      1.17            +1.0        2.18        perf-profile.calltrace.cycles-pp.tlb_remove_table.___pte_free_tlb.free_pud_range.free_p4d_range.free_pgd_range
      4.57            +1.0        5.59        perf-profile.calltrace.cycles-pp.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas.vms_clear_ptes
      0.00            +1.1        1.10        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.rmqueue_bulk.__rmqueue_pcplist.rmqueue
      0.00            +1.1        1.12        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.rmqueue_bulk.__rmqueue_pcplist.rmqueue.get_page_from_freelist
      0.00            +1.1        1.13        perf-profile.calltrace.cycles-pp.__irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.rmqueue_bulk.__rmqueue_pcplist
      0.00            +1.1        1.13        perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.rmqueue_bulk.__rmqueue_pcplist.rmqueue.get_page_from_freelist
      0.00            +1.1        1.13        perf-profile.calltrace.cycles-pp.handle_softirqs.__irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.rmqueue_bulk
      0.00            +1.1        1.13        perf-profile.calltrace.cycles-pp.rcu_core.handle_softirqs.__irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.00            +1.1        1.13        perf-profile.calltrace.cycles-pp.rcu_do_batch.rcu_core.handle_softirqs.__irq_exit_rcu.sysvec_apic_timer_interrupt
      0.00            +1.1        1.13        perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.rmqueue_bulk.__rmqueue_pcplist.rmqueue
      2.51            +1.2        3.70        perf-profile.calltrace.cycles-pp.free_pud_range.free_p4d_range.free_pgd_range.free_pgtables.vms_clear_ptes
      2.57            +1.2        3.81        perf-profile.calltrace.cycles-pp.free_p4d_range.free_pgd_range.free_pgtables.vms_clear_ptes.vms_complete_munmap_vmas
      2.66            +1.3        3.92        perf-profile.calltrace.cycles-pp.free_pgd_range.free_pgtables.vms_clear_ptes.vms_complete_munmap_vmas.do_vmi_align_munmap
      2.51            +1.4        3.92        perf-profile.calltrace.cycles-pp.get_page_from_freelist.__alloc_frozen_pages_noprof.alloc_pages_mpol.alloc_pages_noprof.pte_alloc_one
      3.89            +1.5        5.41        perf-profile.calltrace.cycles-pp.free_pgtables.vms_clear_ptes.vms_complete_munmap_vmas.do_vmi_align_munmap.do_vmi_munmap
      1.08 ±  4%      +1.7        2.75        perf-profile.calltrace.cycles-pp.rmqueue_bulk.__rmqueue_pcplist.rmqueue.get_page_from_freelist.__alloc_frozen_pages_noprof
      1.21 ±  3%      +1.7        2.93        perf-profile.calltrace.cycles-pp.__rmqueue_pcplist.rmqueue.get_page_from_freelist.__alloc_frozen_pages_noprof.alloc_pages_mpol
      1.46 ±  3%      +1.8        3.22        perf-profile.calltrace.cycles-pp.rmqueue.get_page_from_freelist.__alloc_frozen_pages_noprof.alloc_pages_mpol.alloc_pages_noprof
      5.98            +1.8        7.77        perf-profile.calltrace.cycles-pp.__mmap_region.do_mmap.vm_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.51 ±  2%      +1.8        7.36        perf-profile.calltrace.cycles-pp.pte_alloc_one.__pte_alloc.do_anonymous_page.__handle_mm_fault.handle_mm_fault
      4.85 ±  3%      +1.9        6.70        perf-profile.calltrace.cycles-pp.__alloc_frozen_pages_noprof.alloc_pages_mpol.alloc_pages_noprof.pte_alloc_one.__pte_alloc
      5.72 ±  2%      +1.9        7.58        perf-profile.calltrace.cycles-pp.__pte_alloc.do_anonymous_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      4.90 ±  3%      +1.9        6.78        perf-profile.calltrace.cycles-pp.alloc_pages_mpol.alloc_pages_noprof.pte_alloc_one.__pte_alloc.do_anonymous_page
      7.89            +1.9        9.80        perf-profile.calltrace.cycles-pp.zap_pmd_range.unmap_page_range.unmap_vmas.vms_clear_ptes.vms_complete_munmap_vmas
      5.02 ±  3%      +1.9        6.93        perf-profile.calltrace.cycles-pp.alloc_pages_noprof.pte_alloc_one.__pte_alloc.do_anonymous_page.__handle_mm_fault
      8.23            +2.0       10.19        perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.vms_clear_ptes.vms_complete_munmap_vmas.do_vmi_align_munmap
      8.39            +2.0       10.39        perf-profile.calltrace.cycles-pp.unmap_vmas.vms_clear_ptes.vms_complete_munmap_vmas.do_vmi_align_munmap.do_vmi_munmap
      7.38            +2.1        9.52        perf-profile.calltrace.cycles-pp.do_mmap.vm_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
      7.85            +2.2       10.08        perf-profile.calltrace.cycles-pp.vm_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
      8.20            +2.3       10.50        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
      8.76            +2.4       11.18        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__mmap
     18.64            +2.6       21.24        perf-profile.calltrace.cycles-pp.do_anonymous_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
     19.06            +2.8       21.81        perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
     19.55            +3.0       22.50        perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
     11.86            +3.0       14.90        perf-profile.calltrace.cycles-pp.__mmap
     20.35            +3.2       23.53        perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
     20.40            +3.2       23.59        perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault
     20.80            +3.3       24.09        perf-profile.calltrace.cycles-pp.asm_exc_page_fault
     17.14 ±  2%      +3.8       20.93        perf-profile.calltrace.cycles-pp.vms_clear_ptes.vms_complete_munmap_vmas.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap
     17.72 ±  2%      +4.0       21.67        perf-profile.calltrace.cycles-pp.vms_complete_munmap_vmas.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap.__x64_sys_munmap
     20.37            +4.8       25.12        perf-profile.calltrace.cycles-pp.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64
     20.63            +4.8       25.42        perf-profile.calltrace.cycles-pp.do_vmi_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe
     20.93            +4.8       25.76        perf-profile.calltrace.cycles-pp.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
     20.99            +4.8       25.84        perf-profile.calltrace.cycles-pp.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
     21.29            +4.9       26.22        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
     21.82            +5.0       26.86        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__munmap
     24.54            +5.6       30.17        perf-profile.calltrace.cycles-pp.__munmap
     11.34 ± 12%     +11.3       22.67        perf-profile.calltrace.cycles-pp.kmem_cache_free.rcu_do_batch.rcu_core.handle_softirqs.run_ksoftirqd
      8.21 ± 14%     +13.2       21.41        perf-profile.calltrace.cycles-pp.__put_partials.kmem_cache_free.rcu_do_batch.rcu_core.handle_softirqs
      7.51 ± 15%     +13.3       20.79        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.free_pcppages_bulk.free_frozen_page_commit.free_frozen_pages.__put_partials
      7.99 ± 14%     +13.3       21.28        perf-profile.calltrace.cycles-pp.free_pcppages_bulk.free_frozen_page_commit.free_frozen_pages.__put_partials.kmem_cache_free
      8.06 ± 14%     +13.3       21.36        perf-profile.calltrace.cycles-pp.free_frozen_pages.__put_partials.kmem_cache_free.rcu_do_batch.rcu_core
      7.47 ± 15%     +13.3       20.77        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.free_pcppages_bulk.free_frozen_page_commit.free_frozen_pages
      8.02 ± 14%     +13.3       21.34        perf-profile.calltrace.cycles-pp.free_frozen_page_commit.free_frozen_pages.__put_partials.kmem_cache_free.rcu_do_batch
     26.28 ±  8%     -24.9        1.42        perf-profile.children.cycles-pp.tlb_remove_table_rcu
     24.16 ± 10%     -24.2        0.00        perf-profile.children.cycles-pp.__folio_put
     24.15 ± 10%     -24.1        0.00        perf-profile.children.cycles-pp.__mem_cgroup_uncharge
     23.35 ±  6%     -23.2        0.16        perf-profile.children.cycles-pp.uncharge_batch
     22.37 ±  4%     -22.2        0.15        perf-profile.children.cycles-pp.page_counter_uncharge
     19.74 ±  2%     -19.6        0.13        perf-profile.children.cycles-pp.page_counter_cancel
     38.58           -12.7       25.86        perf-profile.children.cycles-pp.kthread
     38.58           -12.7       25.86        perf-profile.children.cycles-pp.ret_from_fork
     38.58           -12.7       25.86        perf-profile.children.cycles-pp.ret_from_fork_asm
     38.57           -12.7       25.85        perf-profile.children.cycles-pp.smpboot_thread_fn
     38.52           -12.7       25.82        perf-profile.children.cycles-pp.run_ksoftirqd
     42.22           -11.6       30.60        perf-profile.children.cycles-pp.handle_softirqs
     42.19           -11.6       30.58        perf-profile.children.cycles-pp.rcu_core
     42.18           -11.6       30.57        perf-profile.children.cycles-pp.rcu_do_batch
      3.33 ± 11%      -2.1        1.25        perf-profile.children.cycles-pp.__slab_free
      1.34 ±  7%      -1.1        0.27        perf-profile.children.cycles-pp._raw_spin_trylock
      1.05 ± 81%      -1.0        0.09        perf-profile.children.cycles-pp.uncharge_folio
      0.81 ±  3%      -0.6        0.20        perf-profile.children.cycles-pp.__free_pages
      1.08 ± 21%      -0.4        0.68        perf-profile.children.cycles-pp.__mod_memcg_state
      1.10 ±  6%      -0.2        0.85        perf-profile.children.cycles-pp.vm_area_free_rcu_cb
      1.90            -0.1        1.77        perf-profile.children.cycles-pp.__lruvec_stat_mod_folio
      0.48            -0.1        0.42        perf-profile.children.cycles-pp.__folio_mod_stat
      0.55            -0.1        0.50        perf-profile.children.cycles-pp.folio_add_new_anon_rmap
      0.29 ±  2%      -0.0        0.25        perf-profile.children.cycles-pp.up_write
      0.09 ±  5%      -0.0        0.05        perf-profile.children.cycles-pp.cmd_record
      0.09 ±  5%      -0.0        0.05        perf-profile.children.cycles-pp.handle_internal_command
      0.09 ±  5%      -0.0        0.05        perf-profile.children.cycles-pp.main
      0.09 ±  5%      -0.0        0.05        perf-profile.children.cycles-pp.run_builtin
      0.60 ±  2%      -0.0        0.57        perf-profile.children.cycles-pp.folio_remove_rmap_ptes
      0.09            -0.0        0.07        perf-profile.children.cycles-pp.page_counter_try_charge
      0.10 ±  4%      -0.0        0.08        perf-profile.children.cycles-pp.sized_strscpy
      0.14 ±  3%      -0.0        0.13        perf-profile.children.cycles-pp.get_pfnblock_flags_mask
      0.11            -0.0        0.10        perf-profile.children.cycles-pp.down_read_trylock
      0.10            +0.0        0.11        perf-profile.children.cycles-pp.task_tick_fair
      0.14            +0.0        0.15        perf-profile.children.cycles-pp.up_read
      0.05            +0.0        0.06        perf-profile.children.cycles-pp.anon_vma_compatible
      0.05            +0.0        0.06        perf-profile.children.cycles-pp.folio_add_lru
      0.05            +0.0        0.06        perf-profile.children.cycles-pp.khugepaged_enter_vma
      0.05            +0.0        0.06        perf-profile.children.cycles-pp.mas_prev_setup
      0.11            +0.0        0.12        perf-profile.children.cycles-pp.can_vma_merge_right
      0.08            +0.0        0.09        perf-profile.children.cycles-pp.security_mmap_addr
      0.06            +0.0        0.07        perf-profile.children.cycles-pp._find_next_bit
      0.06            +0.0        0.07        perf-profile.children.cycles-pp.tlb_gather_mmu
      0.33 ±  2%      +0.0        0.35        perf-profile.children.cycles-pp.down_write
      0.16 ±  2%      +0.0        0.18        perf-profile.children.cycles-pp.sched_tick
      0.08 ±  5%      +0.0        0.10        perf-profile.children.cycles-pp.mas_data_end
      0.15 ±  3%      +0.0        0.17        perf-profile.children.cycles-pp.vma_merge_new_range
      0.07            +0.0        0.09        perf-profile.children.cycles-pp.mas_destroy
      0.07            +0.0        0.09        perf-profile.children.cycles-pp.mas_put_in_tree
      0.09            +0.0        0.11        perf-profile.children.cycles-pp.userfaultfd_unmap_complete
      0.05            +0.0        0.07        perf-profile.children.cycles-pp.mas_prev_range
      0.39 ±  3%      +0.0        0.41        perf-profile.children.cycles-pp._raw_spin_lock
      0.11 ±  4%      +0.0        0.13        perf-profile.children.cycles-pp.___pte_offset_map
      0.15 ±  3%      +0.0        0.17        perf-profile.children.cycles-pp.rcu_segcblist_enqueue
      0.26 ±  3%      +0.0        0.29        perf-profile.children.cycles-pp.update_process_times
      0.03 ± 70%      +0.0        0.06        perf-profile.children.cycles-pp.get_vma_policy
      0.18 ± 12%      +0.0        0.21        perf-profile.children.cycles-pp.cgroup_rstat_updated
      0.19 ±  4%      +0.0        0.22        perf-profile.children.cycles-pp.malloc
      0.19            +0.0        0.22        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.09            +0.0        0.12        perf-profile.children.cycles-pp.may_expand_vm
      0.05            +0.0        0.08        perf-profile.children.cycles-pp.static_key_count
      0.08            +0.0        0.11        perf-profile.children.cycles-pp.refill_obj_stock
      0.11            +0.0        0.14        perf-profile.children.cycles-pp.setup_object
      0.43            +0.0        0.46        perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.43            +0.0        0.46        perf-profile.children.cycles-pp.hrtimer_interrupt
      0.40 ±  3%      +0.0        0.43        perf-profile.children.cycles-pp.ordered_events__queue
      0.41 ±  3%      +0.0        0.44        perf-profile.children.cycles-pp.process_simple
      0.37 ±  2%      +0.0        0.40        perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.40 ±  3%      +0.0        0.43        perf-profile.children.cycles-pp.queue_event
      0.30            +0.0        0.33        perf-profile.children.cycles-pp.tick_nohz_handler
      0.05 ±  8%      +0.0        0.09        perf-profile.children.cycles-pp.kfree
      0.09 ±  5%      +0.0        0.13        perf-profile.children.cycles-pp.vm_get_page_prot
      0.03 ± 70%      +0.0        0.07        perf-profile.children.cycles-pp.handle_pte_fault
      0.34            +0.0        0.38        perf-profile.children.cycles-pp.lru_gen_add_folio
      0.18            +0.0        0.22        perf-profile.children.cycles-pp.security_mmap_file
      0.10            +0.0        0.14        perf-profile.children.cycles-pp.mas_wr_store_entry
      0.08            +0.0        0.12        perf-profile.children.cycles-pp.remove_vma
      0.12            +0.0        0.16        perf-profile.children.cycles-pp.__vm_enough_memory
      0.23 ±  2%      +0.0        0.27        perf-profile.children.cycles-pp.testcase
      0.09 ±  5%      +0.0        0.13        perf-profile.children.cycles-pp.vma_set_page_prot
      0.14 ±  3%      +0.0        0.19        perf-profile.children.cycles-pp.down_write_killable
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.__kmalloc_node_noprof
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.alloc_slab_obj_exts
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.cap_mmap_addr
      0.11            +0.1        0.16        perf-profile.children.cycles-pp.cap_vm_enough_memory
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.cond_accept_memory
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.ksys_mmap_pgoff
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.mt_free_rcu
      0.11            +0.1        0.16        perf-profile.children.cycles-pp.policy_nodemask
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.vm_stat_account
      0.46            +0.1        0.51        perf-profile.children.cycles-pp.lru_add
      0.46 ±  2%      +0.1        0.51        perf-profile.children.cycles-pp.perf_session__process_events
      0.46 ±  2%      +0.1        0.51        perf-profile.children.cycles-pp.record__finish_output
      0.25            +0.1        0.30        perf-profile.children.cycles-pp.mas_leaf_max_gap
      0.07 ±  7%      +0.1        0.12        perf-profile.children.cycles-pp.mas_next_range
      0.23 ±  2%      +0.1        0.28        perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.05 ±  8%      +0.1        0.11        perf-profile.children.cycles-pp.__anon_vma_interval_tree_remove
      0.24 ±  8%      +0.1        0.30        perf-profile.children.cycles-pp.obj_cgroup_charge
      0.45 ±  2%      +0.1        0.51        perf-profile.children.cycles-pp.reader__read_event
      0.17 ± 16%      +0.1        0.23        perf-profile.children.cycles-pp.__count_memcg_events
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.__thp_vma_allowable_orders
      0.00            +0.1        0.06        perf-profile.children.cycles-pp._find_first_bit
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.get_any_partial
      0.34 ±  4%      +0.1        0.40        perf-profile.children.cycles-pp.lru_gen_del_folio
      0.76            +0.1        0.82        perf-profile.children.cycles-pp.zap_present_ptes
      0.20 ±  2%      +0.1        0.26        perf-profile.children.cycles-pp.free_unref_folios
      0.25            +0.1        0.31        perf-profile.children.cycles-pp.lock_vma_under_rcu
      0.26            +0.1        0.33        perf-profile.children.cycles-pp.shuffle_freelist
      0.18            +0.1        0.25        perf-profile.children.cycles-pp.mas_prev
      0.00            +0.1        0.07        perf-profile.children.cycles-pp.mas_node_count_gfp
      0.24 ±  5%      +0.1        0.32        perf-profile.children.cycles-pp.memcpy_orig
      0.30            +0.1        0.38        perf-profile.children.cycles-pp.cfree
      0.28 ±  2%      +0.1        0.36        perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.00            +0.1        0.08        perf-profile.children.cycles-pp.strlen
      0.46            +0.1        0.54        perf-profile.children.cycles-pp.__pte_offset_map_lock
      0.37            +0.1        0.45        perf-profile.children.cycles-pp.__put_anon_vma
      0.34            +0.1        0.43        perf-profile.children.cycles-pp.mas_next_slot
      0.35            +0.1        0.44        perf-profile.children.cycles-pp.mas_update_gap
      0.40            +0.1        0.49        perf-profile.children.cycles-pp.native_irq_return_iret
      0.38 ±  3%      +0.1        0.47        perf-profile.children.cycles-pp.perf_iterate_sb
      0.34            +0.1        0.43        perf-profile.children.cycles-pp.sync_regs
      0.31            +0.1        0.40        perf-profile.children.cycles-pp.___perf_sw_event
      0.28            +0.1        0.37        perf-profile.children.cycles-pp.mas_wr_store_type
      0.25            +0.1        0.35        perf-profile.children.cycles-pp.mas_pop_node
      0.31            +0.1        0.41        perf-profile.children.cycles-pp.mas_rev_awalk
      0.37            +0.1        0.48        perf-profile.children.cycles-pp.__perf_sw_event
      0.39            +0.1        0.50        perf-profile.children.cycles-pp.mas_prev_slot
      0.49            +0.1        0.60        perf-profile.children.cycles-pp.find_mergeable_anon_vma
      0.24            +0.1        0.36        perf-profile.children.cycles-pp.security_vm_enough_memory_mm
      0.53            +0.1        0.65        perf-profile.children.cycles-pp.__call_rcu_common
      0.12 ± 47%      +0.1        0.25        perf-profile.children.cycles-pp.obj_cgroup_uncharge_pages
      0.55 ±  2%      +0.1        0.69        perf-profile.children.cycles-pp.rcu_all_qs
      0.46 ±  2%      +0.1        0.61        perf-profile.children.cycles-pp.mas_empty_area_rev
      0.71            +0.2        0.87        perf-profile.children.cycles-pp.try_charge_memcg
      0.53            +0.2        0.69        perf-profile.children.cycles-pp.native_flush_tlb_local
      0.67            +0.2        0.83        perf-profile.children.cycles-pp.mas_walk
      0.59            +0.2        0.77        perf-profile.children.cycles-pp.flush_tlb_func
      0.44            +0.2        0.62        perf-profile.children.cycles-pp.allocate_slab
      0.59            +0.2        0.77        perf-profile.children.cycles-pp.mas_preallocate
      0.74            +0.2        0.93        perf-profile.children.cycles-pp.perf_event_mmap_event
      0.70            +0.2        0.91        perf-profile.children.cycles-pp.mas_alloc_nodes
      0.61            +0.2        0.83        perf-profile.children.cycles-pp.___slab_alloc
      0.94            +0.2        1.16        perf-profile.children.cycles-pp.error_entry
      0.00            +0.2        0.22        perf-profile.children.cycles-pp.__memcg_kmem_uncharge_page
      1.00            +0.2        1.23        perf-profile.children.cycles-pp.unlink_anon_vmas
      0.84            +0.2        1.07        perf-profile.children.cycles-pp.perf_event_mmap
      0.89            +0.2        1.13        perf-profile.children.cycles-pp.vm_unmapped_area
      0.90            +0.2        1.14        perf-profile.children.cycles-pp.entry_SYSCALL_64
      0.88            +0.2        1.12        perf-profile.children.cycles-pp.unmapped_area_topdown
      1.00            +0.3        1.25        perf-profile.children.cycles-pp.mas_find
      0.86            +0.3        1.12        perf-profile.children.cycles-pp.flush_tlb_mm_range
      1.02            +0.3        1.29        perf-profile.children.cycles-pp.arch_get_unmapped_area_topdown
      0.96            +0.3        1.24        perf-profile.children.cycles-pp.mas_store_prealloc
      1.00            +0.3        1.28        perf-profile.children.cycles-pp.vms_gather_munmap_vmas
      1.19            +0.3        1.51        perf-profile.children.cycles-pp.__get_unmapped_area
      1.32 ±  3%      +0.3        1.66        perf-profile.children.cycles-pp.__memcg_slab_post_alloc_hook
      1.84            +0.4        2.19        perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      1.79            +0.4        2.15        perf-profile.children.cycles-pp.__vmf_anon_prepare
      1.83            +0.4        2.20        perf-profile.children.cycles-pp.__irqentry_text_end
      1.67            +0.4        2.05        perf-profile.children.cycles-pp.__anon_vma_prepare
      2.14 ±  8%      +0.4        2.55        perf-profile.children.cycles-pp.__memcg_kmem_charge_page
      1.10            +0.4        1.51        perf-profile.children.cycles-pp.__mmap_prepare
      1.41            +0.4        1.84        perf-profile.children.cycles-pp.vm_area_alloc
      1.19            +0.4        1.63        perf-profile.children.cycles-pp.folio_alloc_mpol_noprof
      1.99            +0.4        2.44        perf-profile.children.cycles-pp.syscall_return_via_sysret
      1.29            +0.5        1.74        perf-profile.children.cycles-pp.vma_alloc_folio_noprof
      2.01            +0.5        2.47        perf-profile.children.cycles-pp.__cond_resched
      1.58            +0.5        2.07        perf-profile.children.cycles-pp.mas_wr_node_store
      2.35 ±  5%      +0.6        2.90        perf-profile.children.cycles-pp.alloc_anon_folio
      1.74            +0.6        2.30        perf-profile.children.cycles-pp.mas_store_gfp
      0.82 ±  9%      +0.6        1.40        perf-profile.children.cycles-pp.rcu_cblist_dequeue
      2.19            +0.6        2.82        perf-profile.children.cycles-pp.clear_page_erms
      2.79            +0.8        3.60        perf-profile.children.cycles-pp.kmem_cache_alloc_noprof
      0.32 ± 13%      +0.9        1.24        perf-profile.children.cycles-pp.free_one_page
      3.45            +1.0        4.42        perf-profile.children.cycles-pp.__mmap_new_vma
      1.11            +1.0        2.11        perf-profile.children.cycles-pp.get_free_pages_noprof
      1.17            +1.0        2.18        perf-profile.children.cycles-pp.tlb_remove_table
      1.73            +1.0        2.75        perf-profile.children.cycles-pp.___pte_free_tlb
      4.58            +1.0        5.61        perf-profile.children.cycles-pp.zap_pte_range
      3.66 ±  3%      +1.1        4.78        perf-profile.children.cycles-pp.__irq_exit_rcu
      4.13 ±  3%      +1.2        5.29        perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      4.09 ±  3%      +1.2        5.25        perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      2.51            +1.2        3.70        perf-profile.children.cycles-pp.free_pud_range
      2.58            +1.2        3.82        perf-profile.children.cycles-pp.free_p4d_range
      2.66            +1.3        3.92        perf-profile.children.cycles-pp.free_pgd_range
      3.91            +1.5        5.45        perf-profile.children.cycles-pp.free_pgtables
      6.00            +1.8        7.80        perf-profile.children.cycles-pp.__mmap_region
      5.52 ±  2%      +1.8        7.36        perf-profile.children.cycles-pp.pte_alloc_one
      5.73 ±  2%      +1.9        7.58        perf-profile.children.cycles-pp.__pte_alloc
      1.19 ±  4%      +1.9        3.08        perf-profile.children.cycles-pp.rmqueue_bulk
      8.00            +1.9        9.93        perf-profile.children.cycles-pp.zap_pmd_range
      1.44 ±  3%      +2.0        3.40        perf-profile.children.cycles-pp.__rmqueue_pcplist
      8.24            +2.0       10.21        perf-profile.children.cycles-pp.unmap_page_range
      8.40            +2.0       10.40        perf-profile.children.cycles-pp.unmap_vmas
      1.78 ±  3%      +2.0        3.81        perf-profile.children.cycles-pp.rmqueue
      7.39            +2.2        9.54        perf-profile.children.cycles-pp.do_mmap
      7.86            +2.2       10.09        perf-profile.children.cycles-pp.vm_mmap_pgoff
     18.66            +2.6       21.26        perf-profile.children.cycles-pp.do_anonymous_page
     19.07            +2.8       21.83        perf-profile.children.cycles-pp.__handle_mm_fault
      4.44            +2.8        7.24        perf-profile.children.cycles-pp.get_page_from_freelist
      6.11 ±  2%      +2.9        9.01        perf-profile.children.cycles-pp.alloc_pages_noprof
     19.56            +3.0       22.51        perf-profile.children.cycles-pp.handle_mm_fault
     11.93            +3.1       14.99        perf-profile.children.cycles-pp.__mmap
     20.37            +3.2       23.54        perf-profile.children.cycles-pp.do_user_addr_fault
     20.41            +3.2       23.60        perf-profile.children.cycles-pp.exc_page_fault
     20.93            +3.3       24.24        perf-profile.children.cycles-pp.asm_exc_page_fault
      7.04            +3.3       10.38        perf-profile.children.cycles-pp.__alloc_frozen_pages_noprof
      7.25            +3.4       10.65        perf-profile.children.cycles-pp.alloc_pages_mpol
     17.15 ±  2%      +3.8       20.94        perf-profile.children.cycles-pp.vms_clear_ptes
     17.77 ±  2%      +4.0       21.76        perf-profile.children.cycles-pp.vms_complete_munmap_vmas
     20.38            +4.8       25.13        perf-profile.children.cycles-pp.do_vmi_align_munmap
     20.64            +4.8       25.42        perf-profile.children.cycles-pp.do_vmi_munmap
     20.94            +4.8       25.77        perf-profile.children.cycles-pp.__vm_munmap
     21.00            +4.8       25.85        perf-profile.children.cycles-pp.__x64_sys_munmap
     24.64            +5.7       30.30        perf-profile.children.cycles-pp.__munmap
     29.62            +7.2       36.81        perf-profile.children.cycles-pp.do_syscall_64
     30.76            +7.4       38.17        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     13.79 ± 11%     +13.3       27.05        perf-profile.children.cycles-pp.kmem_cache_free
     10.51 ± 13%     +14.7       25.17        perf-profile.children.cycles-pp.free_frozen_pages
      9.05 ± 13%     +15.3       24.34        perf-profile.children.cycles-pp.__put_partials
      8.80 ± 14%     +15.4       24.21        perf-profile.children.cycles-pp.free_pcppages_bulk
      9.14 ± 14%     +15.6       24.71        perf-profile.children.cycles-pp.free_frozen_page_commit
     17.87 ± 11%     +16.7       34.59        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
     17.67 ± 11%     +16.8       34.47        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     19.67 ±  2%     -19.5        0.12        perf-profile.self.cycles-pp.page_counter_cancel
      3.20 ± 11%      -2.0        1.18        perf-profile.self.cycles-pp.__slab_free
      1.32 ±  7%      -1.1        0.25        perf-profile.self.cycles-pp._raw_spin_trylock
      1.04 ± 82%      -1.0        0.08        perf-profile.self.cycles-pp.uncharge_folio
      0.81 ±  3%      -0.6        0.20        perf-profile.self.cycles-pp.__free_pages
      1.04 ± 23%      -0.4        0.64        perf-profile.self.cycles-pp.__mod_memcg_state
      0.70 ±  8%      -0.1        0.59        perf-profile.self.cycles-pp.__lruvec_stat_mod_folio
      0.20 ±  8%      -0.1        0.11        perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.09            -0.0        0.07        perf-profile.self.cycles-pp.sized_strscpy
      0.14 ±  3%      -0.0        0.12        perf-profile.self.cycles-pp.get_pfnblock_flags_mask
      0.06            -0.0        0.05        perf-profile.self.cycles-pp.do_vmi_munmap
      0.14            +0.0        0.15        perf-profile.self.cycles-pp.vm_mmap_pgoff
      0.05            +0.0        0.06        perf-profile.self.cycles-pp._find_next_bit
      0.05            +0.0        0.06        perf-profile.self.cycles-pp.mas_destroy
      0.07            +0.0        0.08        perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.11            +0.0        0.12        perf-profile.self.cycles-pp.lru_add
      0.15            +0.0        0.16        perf-profile.self.cycles-pp.do_vmi_align_munmap
      0.06            +0.0        0.07        perf-profile.self.cycles-pp.folio_add_new_anon_rmap
      0.06            +0.0        0.07        perf-profile.self.cycles-pp.rcu_do_batch
      0.06            +0.0        0.07        perf-profile.self.cycles-pp.tlb_gather_mmu
      0.06            +0.0        0.07        perf-profile.self.cycles-pp.tlb_remove_table
      0.08 ±  6%      +0.0        0.09        perf-profile.self.cycles-pp.mas_data_end
      0.07 ±  7%      +0.0        0.08        perf-profile.self.cycles-pp.__anon_vma_prepare
      0.22 ±  2%      +0.0        0.23        perf-profile.self.cycles-pp.down_write
      0.07 ±  7%      +0.0        0.08        perf-profile.self.cycles-pp.mas_put_in_tree
      0.13 ±  3%      +0.0        0.14        perf-profile.self.cycles-pp.up_read
      0.39 ±  2%      +0.0        0.41        perf-profile.self.cycles-pp.queue_event
      0.09 ±  5%      +0.0        0.11        perf-profile.self.cycles-pp.can_vma_merge_right
      0.06 ±  7%      +0.0        0.08        perf-profile.self.cycles-pp.flush_tlb_func
      0.09 ±  5%      +0.0        0.11        perf-profile.self.cycles-pp.mas_alloc_nodes
      0.10            +0.0        0.12        perf-profile.self.cycles-pp.___pte_offset_map
      0.09            +0.0        0.11        perf-profile.self.cycles-pp.free_unref_folios
      0.07            +0.0        0.09        perf-profile.self.cycles-pp.lock_vma_under_rcu
      0.09            +0.0        0.11        perf-profile.self.cycles-pp.may_expand_vm
      0.06            +0.0        0.08        perf-profile.self.cycles-pp.__perf_sw_event
      0.11            +0.0        0.13        perf-profile.self.cycles-pp.arch_get_unmapped_area_topdown
      0.11            +0.0        0.13        perf-profile.self.cycles-pp.asm_exc_page_fault
      0.08            +0.0        0.10        perf-profile.self.cycles-pp.unmap_vmas
      0.08            +0.0        0.10        perf-profile.self.cycles-pp.userfaultfd_unmap_complete
      0.15            +0.0        0.17        perf-profile.self.cycles-pp.__mmap_new_vma
      0.10 ±  4%      +0.0        0.12        perf-profile.self.cycles-pp.__mmap
      0.10 ±  4%      +0.0        0.12        perf-profile.self.cycles-pp.find_mergeable_anon_vma
      0.10 ±  4%      +0.0        0.12        perf-profile.self.cycles-pp.free_pcppages_bulk
      0.13 ±  3%      +0.0        0.15        perf-profile.self.cycles-pp.mas_store_prealloc
      0.13 ±  3%      +0.0        0.15        perf-profile.self.cycles-pp.mas_update_gap
      0.08 ±  6%      +0.0        0.10        perf-profile.self.cycles-pp.free_pgd_range
      0.16 ±  3%      +0.0        0.18        perf-profile.self.cycles-pp.__vm_munmap
      0.17 ±  2%      +0.0        0.19        perf-profile.self.cycles-pp.malloc
      0.15 ±  3%      +0.0        0.17        perf-profile.self.cycles-pp.rcu_segcblist_enqueue
      0.12 ±  4%      +0.0        0.14        perf-profile.self.cycles-pp.___slab_alloc
      0.05 ±  8%      +0.0        0.08        perf-profile.self.cycles-pp.vms_clear_ptes
      0.08 ±  5%      +0.0        0.11        perf-profile.self.cycles-pp.down_write_killable
      0.17 ±  9%      +0.0        0.20        perf-profile.self.cycles-pp.lru_gen_add_folio
      0.18            +0.0        0.21        perf-profile.self.cycles-pp.flush_tlb_mm_range
      0.10            +0.0        0.13        perf-profile.self.cycles-pp.alloc_pages_mpol
      0.09            +0.0        0.12        perf-profile.self.cycles-pp.do_user_addr_fault
      0.09            +0.0        0.12        perf-profile.self.cycles-pp.vm_get_page_prot
      0.07            +0.0        0.10        perf-profile.self.cycles-pp.__vm_enough_memory
      0.16            +0.0        0.19        perf-profile.self.cycles-pp.alloc_pages_noprof
      0.12 ±  6%      +0.0        0.15        perf-profile.self.cycles-pp.free_pages_and_swap_cache
      0.07            +0.0        0.10        perf-profile.self.cycles-pp.policy_nodemask
      0.08            +0.0        0.11        perf-profile.self.cycles-pp.refill_obj_stock
      0.06            +0.0        0.09        perf-profile.self.cycles-pp.vma_set_page_prot
      0.15 ±  3%      +0.0        0.18        perf-profile.self.cycles-pp.__pte_offset_map_lock
      0.13 ±  3%      +0.0        0.16        perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.22 ±  2%      +0.0        0.25        perf-profile.self.cycles-pp.testcase
      0.20 ±  2%      +0.0        0.23        perf-profile.self.cycles-pp.unmap_page_range
      0.11 ±  4%      +0.0        0.14        perf-profile.self.cycles-pp.cap_vm_enough_memory
      0.11 ±  4%      +0.0        0.14        perf-profile.self.cycles-pp.mas_preallocate
      0.14 ±  3%      +0.0        0.18        perf-profile.self.cycles-pp.tlb_finish_mmu
      0.21 ±  2%      +0.0        0.25        perf-profile.self.cycles-pp.unmapped_area_topdown
      0.12 ±  3%      +0.0        0.16        perf-profile.self.cycles-pp.mas_empty_area_rev
      0.08 ±  5%      +0.0        0.12        perf-profile.self.cycles-pp.mas_wr_store_entry
      0.34 ±  3%      +0.0        0.38        perf-profile.self.cycles-pp._raw_spin_lock
      0.15 ±  3%      +0.0        0.19        perf-profile.self.cycles-pp.do_mmap
      0.53 ±  3%      +0.0        0.57        perf-profile.self.cycles-pp.kmem_cache_free
      0.17 ±  4%      +0.0        0.21        perf-profile.self.cycles-pp.lru_gen_del_folio
      0.07            +0.0        0.11        perf-profile.self.cycles-pp.free_p4d_range
      0.09            +0.0        0.13        perf-profile.self.cycles-pp.perf_event_mmap
      0.09            +0.0        0.13        perf-profile.self.cycles-pp.security_vm_enough_memory_mm
      0.16 ±  5%      +0.0        0.20        perf-profile.self.cycles-pp.folios_put_refs
      0.12            +0.0        0.16        perf-profile.self.cycles-pp.mas_prev
      0.12            +0.0        0.16        perf-profile.self.cycles-pp.security_mmap_file
      0.38 ±  4%      +0.0        0.42        perf-profile.self.cycles-pp.__free_one_page
      0.07 ±  7%      +0.0        0.11        perf-profile.self.cycles-pp.__get_unmapped_area
      0.17 ±  2%      +0.0        0.21        perf-profile.self.cycles-pp.perf_event_mmap_event
      0.19 ±  2%      +0.0        0.24        perf-profile.self.cycles-pp.shuffle_freelist
      0.16 ±  2%      +0.0        0.21        perf-profile.self.cycles-pp.rmqueue
      0.03 ± 70%      +0.0        0.08        perf-profile.self.cycles-pp.__x64_sys_munmap
      0.20            +0.0        0.25        perf-profile.self.cycles-pp.cfree
      0.10            +0.0        0.15        perf-profile.self.cycles-pp.__mmap_prepare
      0.10            +0.0        0.15        perf-profile.self.cycles-pp.vm_area_alloc
      0.18            +0.0        0.23        perf-profile.self.cycles-pp.do_syscall_64
      0.05            +0.0        0.10        perf-profile.self.cycles-pp.__anon_vma_interval_tree_remove
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.__thp_vma_allowable_orders
      0.00            +0.1        0.05        perf-profile.self.cycles-pp._find_first_bit
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.anon_vma_compatible
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.exc_page_fault
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.get_any_partial
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.irqentry_exit_to_user_mode
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.mas_prev_range
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.mas_prev_setup
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.mt_free_rcu
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.setup_object
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.syscall_exit_to_user_mode_prepare
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.vm_stat_account
      0.21            +0.1        0.26        perf-profile.self.cycles-pp.mas_leaf_max_gap
      0.12            +0.1        0.17        perf-profile.self.cycles-pp.zap_present_ptes
      0.16 ± 15%      +0.1        0.21        perf-profile.self.cycles-pp.__count_memcg_events
      0.02 ±141%      +0.1        0.07        perf-profile.self.cycles-pp.remove_vma
      0.18 ±  2%      +0.1        0.23        perf-profile.self.cycles-pp.unlink_anon_vmas
      0.19 ±  8%      +0.1        0.25        perf-profile.self.cycles-pp.obj_cgroup_charge
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.get_vma_policy
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.handle_pte_fault
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.kfree
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.static_key_count
      0.21            +0.1        0.27        perf-profile.self.cycles-pp.__munmap
      0.21            +0.1        0.27        perf-profile.self.cycles-pp.do_anonymous_page
      0.23 ±  4%      +0.1        0.29        perf-profile.self.cycles-pp.memcpy_orig
      0.30            +0.1        0.36        perf-profile.self.cycles-pp.mas_store_gfp
      0.27 ±  4%      +0.1        0.33        perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.27            +0.1        0.34        perf-profile.self.cycles-pp.___perf_sw_event
      0.19 ±  2%      +0.1        0.26        perf-profile.self.cycles-pp.vms_gather_munmap_vmas
      0.23            +0.1        0.30        perf-profile.self.cycles-pp.__rmqueue_pcplist
      0.00            +0.1        0.07        perf-profile.self.cycles-pp.mas_next_range
      0.17 ±  5%      +0.1        0.24        perf-profile.self.cycles-pp.handle_mm_fault
      0.25            +0.1        0.32        perf-profile.self.cycles-pp.mas_rev_awalk
      0.31            +0.1        0.38        perf-profile.self.cycles-pp.__mmap_region
      0.32            +0.1        0.39        perf-profile.self.cycles-pp.mas_next_slot
      0.29 ±  6%      +0.1        0.37        perf-profile.self.cycles-pp.perf_iterate_sb
      0.13 ±  3%      +0.1        0.21        perf-profile.self.cycles-pp.vms_complete_munmap_vmas
      0.00            +0.1        0.08        perf-profile.self.cycles-pp.strlen
      0.26            +0.1        0.34        perf-profile.self.cycles-pp.mas_wr_store_type
      0.32            +0.1        0.41        perf-profile.self.cycles-pp.mas_find
      0.40            +0.1        0.49        perf-profile.self.cycles-pp.native_irq_return_iret
      0.34            +0.1        0.43        perf-profile.self.cycles-pp.sync_regs
      0.23            +0.1        0.32        perf-profile.self.cycles-pp.mas_pop_node
      0.39 ±  2%      +0.1        0.48        perf-profile.self.cycles-pp.__memcg_slab_free_hook
      0.37            +0.1        0.47        perf-profile.self.cycles-pp.mas_prev_slot
      0.33            +0.1        0.43        perf-profile.self.cycles-pp.__call_rcu_common
      0.28            +0.1        0.38        perf-profile.self.cycles-pp.__handle_mm_fault
      0.05 ±141%      +0.1        0.15        perf-profile.self.cycles-pp.obj_cgroup_uncharge_pages
      0.38            +0.1        0.49        perf-profile.self.cycles-pp.get_page_from_freelist
      0.00            +0.1        0.11        perf-profile.self.cycles-pp.tlb_remove_table_rcu
      0.42            +0.1        0.53        perf-profile.self.cycles-pp.rcu_all_qs
      0.42            +0.1        0.53        perf-profile.self.cycles-pp.__alloc_frozen_pages_noprof
      0.37            +0.1        0.49        perf-profile.self.cycles-pp.rmqueue_bulk
      0.37 ±  3%      +0.1        0.49        perf-profile.self.cycles-pp.mas_wr_node_store
      0.31 ± 11%      +0.1        0.45        perf-profile.self.cycles-pp.free_frozen_page_commit
      0.61            +0.2        0.76        perf-profile.self.cycles-pp.mas_walk
      0.51            +0.2        0.66        perf-profile.self.cycles-pp.native_flush_tlb_local
      0.59            +0.2        0.75        perf-profile.self.cycles-pp.try_charge_memcg
      0.72            +0.2        0.89        perf-profile.self.cycles-pp.free_pud_range
      0.69 ±  2%      +0.2        0.86        perf-profile.self.cycles-pp.__memcg_slab_post_alloc_hook
      1.08 ± 11%      +0.2        1.28        perf-profile.self.cycles-pp.__memcg_kmem_charge_page
      0.81            +0.2        1.02        perf-profile.self.cycles-pp.entry_SYSCALL_64
      0.94            +0.2        1.15        perf-profile.self.cycles-pp.error_entry
      0.76            +0.2        0.98        perf-profile.self.cycles-pp.kmem_cache_alloc_noprof
      1.15 ±  2%      +0.2        1.38        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      1.34            +0.3        1.66        perf-profile.self.cycles-pp.__cond_resched
      1.82            +0.4        2.17        perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      1.83            +0.4        2.20        perf-profile.self.cycles-pp.__irqentry_text_end
      1.97            +0.4        2.41        perf-profile.self.cycles-pp.syscall_return_via_sysret
      1.85            +0.5        2.33        perf-profile.self.cycles-pp.zap_pmd_range
      0.82 ± 10%      +0.6        1.39        perf-profile.self.cycles-pp.rcu_cblist_dequeue
      2.08            +0.6        2.66        perf-profile.self.cycles-pp.clear_page_erms
      3.26            +0.8        4.11        perf-profile.self.cycles-pp.zap_pte_range
     17.66 ± 11%     +16.8       34.47        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


