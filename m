Return-Path: <linux-arch+bounces-11365-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E874BA83491
	for <lists+linux-arch@lfdr.de>; Thu, 10 Apr 2025 01:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 241193BD2B2
	for <lists+linux-arch@lfdr.de>; Wed,  9 Apr 2025 23:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776FE21D587;
	Wed,  9 Apr 2025 23:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T3mTJZ/A"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF7621D018;
	Wed,  9 Apr 2025 23:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744241460; cv=fail; b=TQQu4RD2003i/mxmv86FV1obg27as0rJ9AxotYQhadpn1r5XJ4NLhUDWaljRdtzbESavaEL6TRzzrWtOXuTlraZpBHqvkVkZWi6bAg1WpNN5A22pR3CsPUbHoBtsA7Vb38bsSab32SXc3wB9gieaN7Eb3qyE3dihGWmR4E4UArY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744241460; c=relaxed/simple;
	bh=RWSO0WaiBWJJ08hXiesCtbiFB5wLNG0jwruUREHjD9g=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oM/TCdFA5DDsSNZO7gpVdxFnPd4JNEj8tzGq1ouLet7pp/mnLT9ni3HTc4BFpg8b5+fK8hBH9AoPrKIDcuYqego2/n2wDYVfdIg2blv9maGOxRV9PqrQwaVyM3dV+9b/uZ0tOztGaXOYqiyF26hGyM3KaigDevvzohuCdGyUqdk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T3mTJZ/A; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744241458; x=1775777458;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=RWSO0WaiBWJJ08hXiesCtbiFB5wLNG0jwruUREHjD9g=;
  b=T3mTJZ/AOgMdfOys8JLiPDhZ4O3GXBDcGGTmQjp3QCQKYycCKJGqE6ml
   nKHWhIbVjMTuYJW0olKFGLjdtGUYfqPje2HCRSBGoznvW+y7T6EcPy7iA
   VhtnWJWdZct3cdIInz0fFz5AI1Dkhdrseh7hxBTTRvcQ2D9kt1RrcFAC9
   17aMGGqesUUCqTpJSLsUgSG4dojRtWTqCO7GC0Yc9UUh40ku3q+T1AKQD
   4rrx/B3Ps6Y2V8naR8U0y77065qmVfllXjLAcmlGX4yBCfYMa4vsXRfFL
   ITm1rkzHjuuGzcYkiT/zUFTRcnvOjodyr+vM7Fz3MtStoFugWMCnCv75v
   g==;
X-CSE-ConnectionGUID: hAP2gFxwQuWdi1HLJXfESA==
X-CSE-MsgGUID: zPumDCqDTluuoP3s+woTUQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11399"; a="45865468"
X-IronPort-AV: E=Sophos;i="6.15,201,1739865600"; 
   d="scan'208";a="45865468"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 16:30:57 -0700
X-CSE-ConnectionGUID: d7+DU2Y1RsOz+n7z/sQDEg==
X-CSE-MsgGUID: vFkQpDVbT0CMVF761gO/RA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,201,1739865600"; 
   d="scan'208";a="133932843"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 16:30:57 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 9 Apr 2025 16:30:56 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 9 Apr 2025 16:30:56 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 9 Apr 2025 16:30:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gjE9bo6277re1I0eg6bXHauqaEAnlOCi3hrgfl+cJLgGr42SU23mDJg72Oeih49XdC2HFzJijnyxmbpMF0N+CAkNehQzIg3cxA6LJiaDHKi6EaZxSLHrfLdoW6N2gjug5gcng/mVBUfft+/FFqbX5u0zap4UBBa92x+mzr+0Zx8hvtV+2cuQKUmiYsYcZWmhVoR+wJ0tEg/i/V0V0T8VOZDkEYxYRdUVoXKiT5W9kMbXKOIM56SgAxFIXB8CQP6M0N3VNThDDLMjb8WQr5HTzWsdhIcCgUs4yOVLW97eF6v76a7MEkp2Yj0tjpNOXN/JjLBBeZgl4QKbZad8zeyvnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3p16+dPFs7ACQiS570v0vyyhiYEpHQSJgJQ6mtR+siE=;
 b=AAK6XSevD/RZy2tGtUYKKUiU/LjHHC22rvmkg8U49WwyBc2z9D7K+tvk95N3QUiuUs+JnuwRG8a4R7Wt47qz6/UTHhYaEJczDEOzxCbh4oXESpno8REJQDj0LUtSHkXY+4hgCJRoVnUP6Ltpo2o+V+odQSovsdnmg1K71AY4po5u2umB/JmVHU+isOOaJ+x7UgTm5saSVjvgqN4F3mptbGj4oxI3/AOFMQrr6nGGd5pV6Pvs8pKnFEssji774GU9M1flOp5PjLT3ewlLxwIWqqfPKr6BEC9J0bNBcrOBEr7Va55mDh9vBzq/quJ0xPWT0477nfY3qpVTUVBhnhTeLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH3PR11MB7346.namprd11.prod.outlook.com (2603:10b6:610:152::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.23; Wed, 9 Apr
 2025 23:30:23 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%3]) with mapi id 15.20.8606.033; Wed, 9 Apr 2025
 23:30:23 +0000
Date: Wed, 9 Apr 2025 16:30:17 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Roman Kisel <romank@linux.microsoft.com>, Robin Murphy
	<robin.murphy@arm.com>, <aleksander.lobakin@intel.com>,
	<andriy.shevchenko@linux.intel.com>, <arnd@arndb.de>, <bp@alien8.de>,
	<catalin.marinas@arm.com>, <corbet@lwn.net>, <dakr@kernel.org>,
	<dan.j.williams@intel.com>, <dave.hansen@linux.intel.com>,
	<decui@microsoft.com>, <gregkh@linuxfoundation.org>,
	<haiyangz@microsoft.com>, <hch@lst.de>, <hpa@zytor.com>,
	<James.Bottomley@hansenpartnership.com>, <Jonathan.Cameron@huawei.com>,
	<kys@microsoft.com>, <leon@kernel.org>, <lukas@wunner.de>, <luto@kernel.org>,
	<m.szyprowski@samsung.com>, <martin.petersen@oracle.com>, <mingo@redhat.com>,
	<peterz@infradead.org>, <quic_zijuhu@quicinc.com>, <tglx@linutronix.de>,
	<wei.liu@kernel.org>, <will@kernel.org>, <iommu@lists.linux.dev>,
	<linux-arch@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-doc@vger.kernel.org>, <linux-hyperv@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
	<x86@kernel.org>
CC: <apais@microsoft.com>, <benhill@microsoft.com>, <bperkins@microsoft.com>,
	<sunilmut@microsoft.com>, Suzuki K Poulose <suzuki.poulose@arm.com>,
	<linux-coco@lists.linux.dev>
Subject: Re: [PATCH hyperv-next 5/6] arch, drivers: Add device struct
 bitfield to not bounce-buffer
Message-ID: <67f703099f124_71fe2949e@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250409000835.285105-1-romank@linux.microsoft.com>
 <20250409000835.285105-6-romank@linux.microsoft.com>
 <0eb87302-fae8-4708-aaf8-d16e836e727f@arm.com>
 <0ab2849a-5c03-4a8c-891e-3cb89b20b0e4@linux.microsoft.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0ab2849a-5c03-4a8c-891e-3cb89b20b0e4@linux.microsoft.com>
X-ClientProxiedBy: MW4P222CA0010.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::15) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH3PR11MB7346:EE_
X-MS-Office365-Filtering-Correlation-Id: 34bef753-baad-4f25-e357-08dd77be7fe1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UIBGUgVDfVU/CMjZ270Vmo/zBgqypowOMU3K5Zyq3b/qj6ygA+hkBVrXm28c?=
 =?us-ascii?Q?cE8NmnnBaUkcaaxACUYxJODnahKiTY44RwS+gyd0DsSjvJxPcCr6XHKrNXc6?=
 =?us-ascii?Q?cZMhkQxalnrAQxRxBZ73Jy63YAYGlub3BJVo4Oyhwi/o5j0ZtyX2XNLYMwsB?=
 =?us-ascii?Q?hARNrq2Fm5zXHLqkX4bDadJd1uAkTWQat25RX+9PKusWd77OrP0sjuqRq4cJ?=
 =?us-ascii?Q?deb1zyFY5qwqAGPN3mSA0516xp2NR8clJi8+0en2zDnNLUVZsX5b9AYvZlaM?=
 =?us-ascii?Q?7X/Lrf2GTJnlmKlvZLNYS/6Nm3yA9UFOt/GmeWqk9jhae+cqw61/uCuWbH0u?=
 =?us-ascii?Q?DKoygLzxw8iQ6NJQbx0VPwtKy9XHKnVLJY2grb3qMhsOpOpMpPM1pVVdu8pU?=
 =?us-ascii?Q?BL2GlelDHg2wuhJh/Zs+f/qGbBFuB9guyoi85YQyOvBDEjffcga+oeWh3bSw?=
 =?us-ascii?Q?WvXssU4eV+nJ+w6VA/oZvonZFDjnubGjeuxyUMK1dytRiqzXI9AkCwT4tgG8?=
 =?us-ascii?Q?/UxsJbtjPCYW1n0wDaTKGuBOGfb9V3ROlyNNcqqrB4ZjIN4PurVEhGq4gw8C?=
 =?us-ascii?Q?ZrvQqHpkyLOq3XuXfx/l5eIMFxUr1ILFyZLy0y6wtNB5ygq/4yqBh/fM1QKm?=
 =?us-ascii?Q?d3kxUHcvrceuAmXwOT2stxnYrLjX+Z2s9Z7Wrx2bVRn28koVIBTc+nEm824M?=
 =?us-ascii?Q?YAq5MP8HWHgNLeoWOkCLUMNhLzcxB2EWMevkwKYg9rHEmIv3khreoexkCFdk?=
 =?us-ascii?Q?DoayacO0lW4s+YItNYWfytzlyIZjrlwKGSj7QF7dc25zHmYqibWbi1hTPE6+?=
 =?us-ascii?Q?mz3UG1bbtGaqqoaN0JDyySOkFCloqtNYvdTkw2CPiCwCBXCSG6T1IwDJfAv/?=
 =?us-ascii?Q?tSGdaRRZ1JU+Hac/AdaWyEppXzeKAaLt/N4JouhX4Q/drZ0XFJ2ssZ1aXE+W?=
 =?us-ascii?Q?RbUFb9c6n5xd78XCnvu00T35eS7O0aYnr53CDL+YLR+GQ/nE/LlQqyqKRF63?=
 =?us-ascii?Q?6MeVoEKk1E+qtwcsrGbLBJUhzFXnWapJQGIt/wEh0wJ43rZSexEx3LRHW+me?=
 =?us-ascii?Q?cv0JUH3J3Av1tzNArqgVRxp6068KN8zkZvMuNipQMF6fiV452sda1ja8xn7G?=
 =?us-ascii?Q?bx0PmpHR5+we6e7zqdk6J+KxpvOESENcnc33MF18lfXXoHxAqvUHjnyF8/gw?=
 =?us-ascii?Q?PA9Oy/9d7dTE5hILSF7GWGofzaUvho4O8+ZKC/xmxsJSa+NZLo1Ogh6CId6A?=
 =?us-ascii?Q?ifg3dPUDvRrGfPCe7J0kzeNrsBZYolm1KEW7+orjZ66owkGdd6QaTPFpqhC8?=
 =?us-ascii?Q?UaZzwS0XxFlznsU130NThwVotpZx6NwgWnJV/bqIErYoVJUFJ9OC0mZ4u5s2?=
 =?us-ascii?Q?QjXSjKjcpDPjicCI9yh1BUm37q4Ei5l8JbpRR5zMdgBF31WVmQpaYBQysuA5?=
 =?us-ascii?Q?SzSzesa2vLFw+c3BNoISwueccgxOBAqOMGn1y7phi1/gb5yy8NOELw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lJwOmZkUbEZ2bEkDII0iAyGNThBNXKUvhQ/gjmuOBlplEOJWjZJMXfZKtDCp?=
 =?us-ascii?Q?+t8ZWQAHP8+cuaXDRVvqxzinVYI4FwJsM/Id1FQwD4HnAQEEcA1C+zJpcbco?=
 =?us-ascii?Q?fB3TarXASZpd5mmOJuavBKrblwuxqzQFrYgKU+qUKh6RFivClRl0mkLAtheS?=
 =?us-ascii?Q?t88ReYGfmDLg2YvG/EpXZDECS8nQ57cNYdpuj3dZT3cXYb46B78aVY9xlGwq?=
 =?us-ascii?Q?hnFPQfO8Wz6nqpSA0/bhpOvegWcdMz2ROw1vs/mmYhysKQ5b6OmGrcpIUzDU?=
 =?us-ascii?Q?v8wW2M7ZlnA9kJDQksEl65Ii5vXjQQ9TmD06JxL+yA0qZ+SCKPDnsvrfCVfM?=
 =?us-ascii?Q?PaRWG6LpS+0vuqM6gNfXB84dIOcjZdp3zHX7mGzN9py2mmghQTmfqe1GCmoV?=
 =?us-ascii?Q?LoUY1KsjP2p2AgaKJ5oIkDNRbqeuRxbBabg0sJT50y5PZI87KwJmTqtS1VuF?=
 =?us-ascii?Q?gwbKbkO2qBG6HO8D8bM958CjU/Wp2y5IP8EsqQvKzAKWJb6d3eqxM7wyX3os?=
 =?us-ascii?Q?dkowX81tlngXKbpEFsvrrJw3GUKIAmTVIJLwSn4Knnaog7tS3v2tCIzunyBR?=
 =?us-ascii?Q?bUHfak2EHRQ8ZroSCP7ZNyW+QL6HuqkZyrZQfoAJ4zN9OGqvhXlRASk5Ksoz?=
 =?us-ascii?Q?860rQCQwFX0/hdffkVg5nK/ARbdgEuUwv5ZghZlsHJx+pI5nXoilh0GDjrEC?=
 =?us-ascii?Q?t3vLaWcJdFHU9le++yb6W0rjJx4kJ2IjpdSmPYi7v8vE3TMtF+h5TsGzjyXV?=
 =?us-ascii?Q?uDcDkFKCvShC24uLmHuZzGnB7xGh1NhNQTvj5GKTofvzj5w+CIhMtI9OABOU?=
 =?us-ascii?Q?fEFd8U0YCRZD8f4PtXZi6LIrBW6OPE/AHFSK6Vo54ztjd8kwDZvttBd3VjN4?=
 =?us-ascii?Q?PJgdCFad1cXV3PUjyImLEWqVtStm9FjrRCiuym/vDHiAnB3a6PiM1WwmNKrG?=
 =?us-ascii?Q?mVZpEHOfpku0UuKWUv+Yy7qrf5U2z5RSyPr0loKtPhok132CCo1f5PDuu+EP?=
 =?us-ascii?Q?T+6wzpVAImdJX9CUEzrXLcH5cIMTdU98BRjgRIo8t7BbokINwdncP5VNx0GC?=
 =?us-ascii?Q?GCpy97GB3B7lBYmLMcS6htRedWusRIjJfW0V/2/cyiuOzlPXN779bGPlJPsJ?=
 =?us-ascii?Q?p0jfLQ0gHvAY8BdVUooSDC9sXaQwMre72GhSceLdvk+HvUAQaDBcTOR4rzM6?=
 =?us-ascii?Q?8/Yy5YZO6xOFIkglNoydnvbwWcYmHBtE6Cp1xio4UHp5eaA/YqGSZDNnlLkP?=
 =?us-ascii?Q?lki/PLlmEKjkP42vh6oEJ5YBDDqD/cxFI+nvk7Byg69dRzre3pfobtZ9eACh?=
 =?us-ascii?Q?kBTojaUEEJmKiE3LWixkfjRAevgfQf8ulJNEZILhsQmMvAEfuUlwae0mlX5A?=
 =?us-ascii?Q?jELPrNTDFgHMZppGQDcKdywfJzOuIQAFjrP6j37Xc5GublnfeJ1SYqAm4b0r?=
 =?us-ascii?Q?gmVfwxAodKZN1odlp4gPEiibZUizCT2yxYiRK3r/3KNNgSFxF4RgA0qkoRVM?=
 =?us-ascii?Q?3FfR2MSewgET7f/zMSAGAlMsfHXVjO0yOFojlJ2H10tcMMmWn1RoK/QmXodK?=
 =?us-ascii?Q?skbAVucw/LE7Ve9NFodNqi9Qkjtj8BF1NuiBglUvM0BlNbm6KSBJXu+R7ivq?=
 =?us-ascii?Q?zA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 34bef753-baad-4f25-e357-08dd77be7fe1
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 23:30:23.1654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m7rrjYjIQ9P18pUcE4Q8IlhLz2eeSUVU5IVIJlwq2inRlMT4Usi2bpsl2ngJ75lxLZ9NluBgzjO2m5TI1G7z5W9YHndvivBMariCceD+6Cg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7346
X-OriginatorOrg: intel.com

[ add linux-coco ]

Roman Kisel wrote:
> 
> 
> On 4/9/2025 9:03 AM, Robin Murphy wrote:
> > On 2025-04-09 1:08 am, Roman Kisel wrote:
> >> Bounce-buffering makes the system spend more time copying
> >> I/O data. When the I/O transaction take place between
> >> a confidential and a non-confidential endpoints, there is
> >> no other way around.
> >>
> >> Introduce a device bitfield to indicate that the device
> >> doesn't need to perform bounce buffering. The capable
> >> device may employ it to save on copying data around.
> > 
> > It's not so much about bounce buffering, it's more fundamentally about 
> > whether the device is trusted and able to access private memory at all 
> > or not. And performance is hardly the biggest concern either - if you do 
> > trust a device to operate on confidential data in private memory, then 
> > surely it is crucial to actively *prevent* that data ever getting into 
> > shared SWIOTLB pages where anyone else could also get at it. At worst 
> > that means CoCo VMs might need an *additional* non-shared SWIOTLB to 
> > support trusted devices with addressing limitations (and/or 
> > "swiotlb=force" debugging, potentially).
> 
> Thanks, I should've highlighted that facet most certainly!

One would hope that no one is building a modern device with trusted I/O
capability, *and* with a swiotlb addressing dependency. However, I agree
that a non-shared swiotlb would be needed in such a scenario.

Otherwise the policy around "a device should not even be allowed to
bounce buffer any private page" is a userspace responsibility to either
not load the driver, not release secrets to this CVM, or otherwise make
sure the device is only ever bounce buffering private memory that does
not contain secrets.

> > Also whatever we do for this really wants to tie in with the nascent 
> > TDISP stuff as well, since we definitely don't want to end up with more 
> > than one notion of whether a device is in a trusted/locked/private/etc. 
> > vs. unlocked/shared/etc. state with respect to DMA (or indeed anything 
> > else if we can avoid it).
> 
> Wouldn't TDISP be per-device as well? In which case, a flag would be
> needed just as being added in this patch.
> 
> Although, there must be a difference between a device with TDISP where
> the flag would be the indication of the feature, and this code where the
> driver may flip that back and forth...
> 
> Do you feel this is shoehorned in `struct device`? I couldn't find an
> appropriate private (== opaque pointer) part in the structure to store
> that bit (`struct device_private` wouldn't fit the bill) and looked like
> adding it to the struct itself would do no harm. However, my read of the
> room is that folks see that as dubious :)
> 
> What would be your opinion on where to store that flag to tie together
> its usage in the Hyper-V SCSI and not bounce-buffering?

The name and location of a flag bit is not the issue, it is the common
expectation of how and when that flag is set.

tl;dr Linux likely needs a "private_accepted" flag for devices

Like Christoph said, a driver really has no business opting itself into
different DMA addressing domains. For TDISP we are also being careful to
make sure that flipping a device from shared to private is a suitably
violent event. This is because the Linux DMA layer does not have a
concept of allowing a device to have mappings from two different
addressing domains simultaneously.

In the current TDISP proposal, a device starts in shared mode and only
after validating all of the launch state of the CVM, device
measurements, and a device interface report is it granted access to
private memory. Without dumping a bunch of golden measurement data into
the kernel that validation can really only be performed by userspace.

Enter this vmbus proposal that wants to emulate devices with a paravisor
that is presumably within the TCB at launch, but the kernel can not
really trust that until a "launch state of the CVM + paravisor"
attestation event.

Like PCIe TDISP the capability of this device to access private memory
is a property of the bus and the iommu. However, acceptance of the
device into private operation is a willful policy action. It needs to
validate not only the device provenance and state, but also the Linux
DMA layer requirements of not holding shared or swiotlb mappings over
the "entry into private mode operation" event.

All that said, I would advocate to require a userspace driven "device
accept" event for all devices, not just TDISP, that want to enter
private operation. Maybe later circle back to figure out if there is a
lingering need for accepting devices via golden measurement, or other
means, to skip the userpace round-trip dependency.

A "private_capable" flag might also make sense, but that is really a
property of a bus that need not be carried necessarily in 'struct
device'.

So for this confidential vmbus SCSI device to mesh with the mechanisms
needed for TDISP I would expect it continues to launch in swiotlb mode
by default. Export an attribute via hv_bus->dev_groups to indicate that
the device is "private_capable" and then require userspace to twiddle a
private_accepted flag with some safety for in-flight DMA.

