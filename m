Return-Path: <linux-arch+bounces-11054-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D48A6D407
	for <lists+linux-arch@lfdr.de>; Mon, 24 Mar 2025 07:15:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 257F4169F4E
	for <lists+linux-arch@lfdr.de>; Mon, 24 Mar 2025 06:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8358739FD9;
	Mon, 24 Mar 2025 06:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CfmPmVl6"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2C42A1CA;
	Mon, 24 Mar 2025 06:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742796918; cv=fail; b=aFerFTOy83CmMwl8OdzIncLak5VsRbRgItwIW0uIiIkybQhDNxZwbMBqzDC8Wc74Q9nMoOJztRPsHPxSibR7P5AX4D9XgiBfmz0UEvBrpW3Nc0A2Wtr2Ioi5lIYtk/w90z0AX8V07U8+rh494yYa3cU9rPU6PfQ4iiGc+suJhxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742796918; c=relaxed/simple;
	bh=5xFXNxSuLtEHBUejyVMIT1o4yjF2wUc/g1cibZJWTXA=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=MTNDhFd2pzj3ecz+2hneBY/2p4x369Zs+oEOZvbgrlyC7RnG358YkLBd2dMiBC070pjXZ+6L/07PyyShV9KC1FwujiEuxyZ/0flQgcBiYQhaRoL0O4DWSp2w97Xy0t6uc948IOF+w3JPj7+uX4EQjsDpLRQEUKktpiZjcIMKmXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CfmPmVl6; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742796915; x=1774332915;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=5xFXNxSuLtEHBUejyVMIT1o4yjF2wUc/g1cibZJWTXA=;
  b=CfmPmVl6kk53NhmLnXpwq5UliZkKiCVuUvNjNVCadJ15XE79SfQqgRts
   uEbzxokut37FmjC9aoHLiOytPlH1lKAkuwmlTaStpakwRMOC1+N0fvziF
   fihDrbejfD6oovVWtX9pcsZYJ0ivvaJ87OqswP7nFtB51lO9mOEx8M7h0
   g+ahoN5WxbB2AihTH2ahEKR4tqlBmMgnLJQBJ/Zf7+X9cy0BZFoYTSXhl
   ex19I9q3b0ldxci8hHtE6AIotQCRFNzb9qQ0GXTVYLOmE5piOKF2WfJUz
   uwAMLpnoUGTIJG1oDWLz+r5Z2QWigwB6aaf9RaQhqMULV5m7xrO3uIBlJ
   g==;
X-CSE-ConnectionGUID: g9OyCZ61Qa+NQkZa9CMMGw==
X-CSE-MsgGUID: VSMgYLt6RtW8kCLTssq0bg==
X-IronPort-AV: E=McAfee;i="6700,10204,11382"; a="47764217"
X-IronPort-AV: E=Sophos;i="6.14,271,1736841600"; 
   d="scan'208";a="47764217"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2025 23:15:14 -0700
X-CSE-ConnectionGUID: nQmokBXMQySuJu3HklDJ2Q==
X-CSE-MsgGUID: zN3p5BKmTBuSZzlZffQ2nQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,271,1736841600"; 
   d="scan'208";a="129007066"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2025 23:15:10 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 23 Mar 2025 23:15:06 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Sun, 23 Mar 2025 23:15:06 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sun, 23 Mar 2025 23:15:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OM8yf5WHrxVsL0s6QTPqTm1twNr7fpSYPVOlxzjFzRqkXH+CPYGT6h0fhLE0QP5qhLJAW/+8KJRPm8yUzHHkGTLmR0xdoX8lOd41YqgkhdJQnrxiBxKoikGh0Fbtciaf/wXxdwB1OvELfaLuhAb8S71Sfb2S/BNdWuPY1FN8z6WHUBoYcA2+14r9T6Zp9QypFp4odWv0saudk1kYLm6RDASLErW+w7ThP1l3KR5/HdiKgYRRYn+mZ4CciXEK+yaHOVSVIDSUmo8VCdRik3HI1xh//iC9PAsIabzP4dDdpaVXGhNtDWF5cX7lKRdbYSiZjUIS0Tud3E4iKA46FJcQ6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RaaUQXrKFJ8dGZ9Fb5AR69vZdezwC5pS+ZIUjPn7waM=;
 b=t9S0GDBT+m5aXZJSmN0UZbs94aC4SDXcTBH6bWjOh3yEEADhvAXvu2+qfXHG0AVqfBuCfudbHp03SO7AWF+bESGEtVlNMvMkfkK+BiG6pAzrLQv7RoWRWbVh3ij9+F0VUW9POObK4MogCQSv09TV3Z73CEYZpbdimvOVSXIvkHlKb5OHNaaugFtjs+d0/EDuDifoVb4/ykDpJ2e6v7Mx11TnvRMGvkJHJfoxOLVzl/srgShEV5CTDoZdtebQDLx0RU2MbBtpv9aRbZ0CfX1RGMjowz89sIBKcvu8w4oCvwqRRNUPSGwzlJtHblcgRX2rFSnjMsezWd7x2sg1yVDK2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SJ2PR11MB7619.namprd11.prod.outlook.com (2603:10b6:a03:4d1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 06:15:02 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%4]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 06:15:02 +0000
Date: Mon, 24 Mar 2025 14:14:38 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Mike Rapoport <rppt@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Andrew Morton
	<akpm@linux-foundation.org>, Mark Brown <broonie@kernel.org>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, Andreas Larsson <andreas@gaisler.com>,
	"Andy Lutomirski" <luto@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Arnd
 Bergmann <arnd@arndb.de>, Borislav Betkov <bp@alien8.de>, Catalin Marinas
	<catalin.marinas@arm.com>, "David S. Miller" <davem@davemloft.net>, "Dinh
 Nguyen" <dinguyen@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Guo Ren <guoren@kernel.org>,
	Heiko Carstens <hca@linux.ibm.com>, Helge Deller <deller@gmx.de>, Huacai Chen
	<chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>, Jiaxun Yang
	<jiaxun.yang@flygoat.com>, Johannes Berg <johannes@sipsolutions.net>, "John
 Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>, Madhavan Srinivasan
	<maddy@linux.ibm.com>, Matt Turner <mattst88@gmail.com>, Max Filippov
	<jcmvbkbc@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Michal Simek
	<monstr@monstr.eu>, Palmer Dabbelt <palmer@dabbelt.com>, Richard Weinberger
	<richard@nod.at>, Russel King <linux@armlinux.org.uk>, Stafford Horne
	<shorne@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, "Thomas
 Gleinxer" <tglx@linutronix.de>, Vasily Gorbik <gor@linux.ibm.com>, "Vineet
 Gupta" <vgupta@kernel.org>, Will Deacon <will@kernel.org>,
	<linux-alpha@vger.kernel.org>, <linux-snps-arc@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-csky@vger.kernel.org>,
	<loongarch@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-mips@vger.kernel.org>, <linux-openrisc@vger.kernel.org>,
	<linux-parisc@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-riscv@lists.infradead.org>, <linux-s390@vger.kernel.org>,
	<linux-sh@vger.kernel.org>, <sparclinux@vger.kernel.org>,
	<linux-um@lists.infradead.org>, <linux-arch@vger.kernel.org>,
	<linux-mm@kvack.org>, <oliver.sang@intel.com>
Subject: [akpm-mm:mm-stable] [arch, mm]  8268af309d:
 kernel_BUG_at_include/linux/page-flags.h
Message-ID: <202503241424.d16223ec-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: KU1PR03CA0042.apcprd03.prod.outlook.com
 (2603:1096:802:19::30) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SJ2PR11MB7619:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fd8a4e9-c65c-406f-03c1-08dd6a9b3640
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tLfDImqnl39dokVuAWKSNqvYVAmOz/miZIfyOYIw3HhkADWgA7e4xd/gNFa6?=
 =?us-ascii?Q?/jweVANufQyxt8TJr8BjLttHk7wWEJa7SS3bBrYqIRDlk6yJuu1ZGCcXAvfq?=
 =?us-ascii?Q?q5gcAytDzYaGQ2kBOI2p4kaHpkef9OZ7iGFscqK8btkZ/tXOZ2glPa8lhlLo?=
 =?us-ascii?Q?eeKKZZKO87nepCeKNRnyEWulKwXvDgHot9zig1EdrlDrpW2lLmGUELjfEAwY?=
 =?us-ascii?Q?RJmLzZFvG1RqRiTZgfs5pC/vPE+hX6zBaBCQ+k12EpS/cwvsYmMzHjZI4Hmk?=
 =?us-ascii?Q?q/X/rLOA73qJzUL6zsuMn979qqzxM4JuBUkjc3mvPPRuzq9LFOm9x4B+gg/T?=
 =?us-ascii?Q?eE1zi3xcSX2hgm1rVc4+rownm3HiPwRgkWVQAwSclLvcDtsbSbS0zJ1HhdJQ?=
 =?us-ascii?Q?kETBNhA3dBb9F2TLyzCNinFoyFGHqlUsVfUeftP2ZbnHwOW2liVTd6Hi3z5r?=
 =?us-ascii?Q?Pd70B8SD7a8mNoFUPUu1JonxgWJfPljJhs5EYhcCTamxqJkG8jOMt6jtMcyi?=
 =?us-ascii?Q?k0LSSkj83XYMRQ85r1dxpOcbpTvXPB844M05CVjBFk4ytJdztyTaesItGTZj?=
 =?us-ascii?Q?Z0g1r7W8+4ueo5HLVzwi2UI6Im/GrOllZLyYRnDThiLn3Pn9eJMLWVvP1s43?=
 =?us-ascii?Q?8DCpOnSfZdvNuWrQ/XRWtGS6vAGO7p5mu9WzFJFHeR8wsxCg6JbKqpJ53lMY?=
 =?us-ascii?Q?qXykuzY6+5ZD4ln1GidzW7No4aq6wrUJUK4JMx6RJzmobTkk8XZ+1Jh7JdGG?=
 =?us-ascii?Q?H/4Rh+u/asSBwnGHTRH0hk/snLaZEKtMsAtnHZnah3Ihlbi9GyDhKEKNdCXo?=
 =?us-ascii?Q?4FcSGeQkIDCUPGbhenrOEXpS1oZBraKgB2mFJPUmLbNCtHXM/2B9PRhO3lKp?=
 =?us-ascii?Q?nf0SoBvE7xMBxPzKlMjNZMWl2FB6xmNNH68X4v2FAiD4mB/4HeJXUqblTpwO?=
 =?us-ascii?Q?urhNJZRKCcmLQa68q1BRTrKm7AAN4WusVoRZyEXbq/svy5+RZmlEk0tLyItx?=
 =?us-ascii?Q?caUV1ZmHqdWI5hQSU/7UWxihIhFZOlbTk3t42PKuejMbNldbYhzRcn30q5Hq?=
 =?us-ascii?Q?mbi/XtRMFot4PzrEEjxI7t6wBXbe4nCeSNEr71jDeHRjG783xCiwSGeEVRrx?=
 =?us-ascii?Q?vdwI5NCJ5kV/YEUXKtpsn/UYvmVccXIg6kwwMLb3Ega9LFIbpg089nMQRcjf?=
 =?us-ascii?Q?tiDZktBHMKxBemcORAF8mCw6RCMvJyqKjFb6dca2hLQfyXBwiUnC8x7LmT52?=
 =?us-ascii?Q?gJEpsln+dr08PFj165IvwhygwdR2y4YnLJGeLRmlUe4UlSyMhEa43igGq9zg?=
 =?us-ascii?Q?RCC89uOO94NwHI1DdA7ULCLux6FlDY3HW37c653/ra+i7+WiLz4zuHry/tVW?=
 =?us-ascii?Q?lcHWtQzv2RtVIOFNvAr2iUyVGgvk?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lDQKWlG5jKSK9CRmtiPPZyE67namW02sdqgE6lQivDbEoPLmYTkCu5G50Myd?=
 =?us-ascii?Q?ZWTcIqpMVowdsVj4jMcMpjrENqNFPYD42VPgD/LcWiZurpsdrf7McycXMdxN?=
 =?us-ascii?Q?pFA+/mFR+2KaUyVLYISO8zh77DHDhv7bGinnDeMoiiiVg47iqaFieVGFqveI?=
 =?us-ascii?Q?N0kPIkfqZ0DicpJPMP/ECRvQ5bYvCOZU0swAlnNOlZVyJghbC8wglUIvdtDf?=
 =?us-ascii?Q?ZFQg1y1LnYSnm+EmBPzYsxSvv57X/0XLzrDJWgfze519Mc58Y2uzPy0GDFNc?=
 =?us-ascii?Q?B/9G90pJjUYz4dHI575k9A75HLGu+4Xz9E1gPGYp6k6gFAUb3G7ixBVrhtKC?=
 =?us-ascii?Q?s2VRtbslU4dUpoce7yP7vPYElFEnR9/D/9FwLcaB35hKwKTwPvyPoe7w+QDB?=
 =?us-ascii?Q?XllKTcBr3NCdvjFpkhXLrCrZ8ZpebIB9SBnjo7MAja9MHg0meNThg4VDI3UO?=
 =?us-ascii?Q?6pvYJuvaGbPCePnQe/K2T5O+bx8YzQAI4BSzXpDKmqNcytMmzMKz2FRWIjqX?=
 =?us-ascii?Q?M+mJt2qI7YLQxVKv3rB0SEmGDjtrBBd+uaMu94vED6qiv+ceZvnkuoLDggPG?=
 =?us-ascii?Q?7Okfd+y+VFafxr+lZCO7CVg8osz//p5HvHbRuMVtTZtrKNRcnvuhDlRaW+s8?=
 =?us-ascii?Q?gNlThvUu/WjlOyNcI3usiSlQzArC703A15EK1FQV/S+AsLqx4unR6dNZnTSm?=
 =?us-ascii?Q?5VCYmyaFQmvjQwzsgFG4gs0x9cOm39VJOX3aHJqz8mibUMcGKlZjQKqIqctX?=
 =?us-ascii?Q?d0v3Zh35I46MViILmWVwWtIj6M3HHwr4in6b/dSi2LDXXq4EIumb6Ey/9fa3?=
 =?us-ascii?Q?wOyHxiZJSRvijU58YlnusLp/qN4ZDYMB5wy73iySlvcRVzmAmb/N4NI1qIcu?=
 =?us-ascii?Q?rGJNNa/J7xPlMC2k3/5VMlVu0OBcq0LmON805wN9I8TF9EzI2Tb6Ke6OnJ/x?=
 =?us-ascii?Q?oXa+JQDwnuHfUrg/DhipRfagNPycvoU9OBKbcRRS+6zlBVqJTaYVebCPk6ai?=
 =?us-ascii?Q?UXgJ5NULLIrk7GuTL8vTTMMZFJY7seZJLOh+2Vy9KUifRCmiExEXQjCSwI8s?=
 =?us-ascii?Q?wNVvTpkes51kN2Rydz+jhJHuIXYTW5nU6YMjiw9NKyR7+Zw1o23aSrCuJ9wE?=
 =?us-ascii?Q?opRwDAll+HmA31Avj4VGhUx27CnDPPYLcSO1mxgEphMLaY9aiKtj0lBWITzu?=
 =?us-ascii?Q?2ipasOeb18hKMv9U/UjPO0SNtYnOip9BLB1K/JJEDKf4dkWkORapG7HH7Kkv?=
 =?us-ascii?Q?cFRh4yX0YbYYAx5lcia9Wlh1A23nVXYK6/iHHTCyHmOIApzgYN3yx5iNcJ/L?=
 =?us-ascii?Q?+t1rkSamkgttSHbxIwC2+o7NlULa6mxLJZLKvz1DkCiVKZPBvBXoqwCPRNzM?=
 =?us-ascii?Q?XE39yVJv48HAKWvg7SfOsjUnj77qkSFgGFSUbWJIqcuHNULTdGtWx52Si56p?=
 =?us-ascii?Q?rnSB136nvikkMwxAI5CpWZiQ723UKFbcDpkzQwPUkbwCUsOVBw4ffMFADcXB?=
 =?us-ascii?Q?Qw2xKDmriX6GOy52h11PyhCtFyxc0vN0NAb+H82HoLy0DYl/UMEuaDtl9Q3w?=
 =?us-ascii?Q?GWPKs/CuvlNGltHHwcOQlBShr7k+WfkUAlY6gzE8bB9xYWHlgZi88VXZeanU?=
 =?us-ascii?Q?4A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fd8a4e9-c65c-406f-03c1-08dd6a9b3640
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 06:15:02.2686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ET6Iug8DPGFi7DBkiGNq7/B3+TMCJgqjUmvebCXJ9p2w/3zrPWVnmzoeqn6r6Vb0Ie8KaYlhlJlYelc8cAwkLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7619
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "kernel_BUG_at_include/linux/page-flags.h" on:

commit: 8268af309d07d1c6279080b4e6fd16ec75cc977c ("arch, mm: set max_mapnr when allocating memory map for FLATMEM")
https://git.kernel.org/cgit/linux/kernel/git/akpm/mm.git mm-stable

in testcase: boot

config: i386-randconfig-062-20250319
compiler: clang-20
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+------------------------------------------+------------+------------+
|                                          | d319c8b491 | 8268af309d |
+------------------------------------------+------------+------------+
| boot_successes                           | 6          | 0          |
| boot_failures                            | 0          | 6          |
| kernel_BUG_at_include/linux/page-flags.h | 0          | 6          |
| Oops:invalid_opcode:#[##]PREEMPT_SMP     | 0          | 6          |
| EIP:reserve_bootmem_region               | 0          | 6          |
| Kernel_panic-not_syncing:Fatal_exception | 0          | 6          |
+------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202503241424.d16223ec-lkp@intel.com


[    0.478410][    T0] ------------[ cut here ]------------
[    0.478822][    T0] kernel BUG at include/linux/page-flags.h:536!
[    0.479312][    T0] Oops: invalid opcode: 0000 [#1] PREEMPT SMP
[    0.479768][    T0] CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 6.14.0-rc6-00357-g8268af309d07 #1
[    0.480470][    T0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 0.481260][ T0] EIP: reserve_bootmem_region (include/linux/page-flags.h:536) 
[ 0.481683][ T0] Code: 5d c3 01 f1 89 c8 ba e1 38 f4 c3 e8 1e 37 8e fc 0f 0b b8 90 e2 62 c4 e8 e2 05 5e fc 01 f1 89 c8 ba be 85 f7 c3 e8 04 37 8e fc <0f> 0b b8 80 e2 62 c4 e8 c8 05 5e fc 55 89 e5 53 57 56 83 ec 10 89
All code
========
   0:	5d                   	pop    %rbp
   1:	c3                   	ret
   2:	01 f1                	add    %esi,%ecx
   4:	89 c8                	mov    %ecx,%eax
   6:	ba e1 38 f4 c3       	mov    $0xc3f438e1,%edx
   b:	e8 1e 37 8e fc       	call   0xfffffffffc8e372e
  10:	0f 0b                	ud2
  12:	b8 90 e2 62 c4       	mov    $0xc462e290,%eax
  17:	e8 e2 05 5e fc       	call   0xfffffffffc5e05fe
  1c:	01 f1                	add    %esi,%ecx
  1e:	89 c8                	mov    %ecx,%eax
  20:	ba be 85 f7 c3       	mov    $0xc3f785be,%edx
  25:	e8 04 37 8e fc       	call   0xfffffffffc8e372e
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	b8 80 e2 62 c4       	mov    $0xc462e280,%eax
  31:	e8 c8 05 5e fc       	call   0xfffffffffc5e05fe
  36:	55                   	push   %rbp
  37:	89 e5                	mov    %esp,%ebp
  39:	53                   	push   %rbx
  3a:	57                   	push   %rdi
  3b:	56                   	push   %rsi
  3c:	83 ec 10             	sub    $0x10,%esp
  3f:	89                   	.byte 0x89

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	b8 80 e2 62 c4       	mov    $0xc462e280,%eax
   7:	e8 c8 05 5e fc       	call   0xfffffffffc5e05d4
   c:	55                   	push   %rbp
   d:	89 e5                	mov    %esp,%ebp
   f:	53                   	push   %rbx
  10:	57                   	push   %rdi
  11:	56                   	push   %rsi
  12:	83 ec 10             	sub    $0x10,%esp
  15:	89                   	.byte 0x89
[    0.483177][    T0] EAX: 00000000 EBX: c425df50 ECX: 00000000 EDX: 00000000
[    0.483712][    T0] ESI: 017ffc00 EDI: ffffffff EBP: c425df34 ESP: c425df2c
[    0.484248][    T0] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00210046
[    0.484846][    T0] CR0: 80050033 CR2: 00000000 CR3: 04b48000 CR4: 00000090
[    0.485376][    T0] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[    0.485907][    T0] DR6: fffe0ff0 DR7: 00000400
[    0.486253][    T0] Call Trace:
[ 0.486494][ T0] ? __die_body (arch/x86/kernel/dumpstack.c:478) 
[ 0.486822][ T0] ? die (arch/x86/kernel/dumpstack.c:?) 
[ 0.487099][ T0] ? do_trap (arch/x86/kernel/traps.c:? arch/x86/kernel/traps.c:197) 
[ 0.487409][ T0] ? do_error_trap (arch/x86/kernel/traps.c:217) 
[ 0.487752][ T0] ? reserve_bootmem_region (include/linux/page-flags.h:536) 
[ 0.488153][ T0] ? exc_overflow (arch/x86/kernel/traps.c:301) 
[ 0.488490][ T0] ? handle_invalid_op (arch/x86/kernel/traps.c:254) 
[ 0.488869][ T0] ? reserve_bootmem_region (include/linux/page-flags.h:536) 
[ 0.489271][ T0] ? exc_invalid_op (arch/x86/kernel/traps.c:316) 
[ 0.489619][ T0] ? handle_exception (arch/x86/entry/entry_32.S:1055) 
[ 0.489996][ T0] ? exc_overflow (arch/x86/kernel/traps.c:301) 
[ 0.490332][ T0] ? reserve_bootmem_region (include/linux/page-flags.h:536) 
[ 0.490733][ T0] ? exc_overflow (arch/x86/kernel/traps.c:301) 
[ 0.491068][ T0] ? reserve_bootmem_region (include/linux/page-flags.h:536) 
[ 0.491470][ T0] memmap_init_reserved_pages (mm/memblock.c:2203) 
[ 0.491887][ T0] free_low_memory_core_early (mm/memblock.c:?) 
[ 0.492302][ T0] memblock_free_all (mm/memblock.c:2272 include/linux/atomic/atomic-arch-fallback.h:546 include/linux/atomic/atomic-long.h:123 include/linux/atomic/atomic-instrumented.h:3261 include/linux/mm.h:67 mm/memblock.c:2273) 
[ 0.492659][ T0] mem_init (arch/x86/mm/init_32.c:735) 
[ 0.492952][ T0] mm_core_init (mm/mm_init.c:2730) 
[ 0.493271][ T0] start_kernel (init/main.c:958) 
[ 0.493604][ T0] i386_start_kernel (arch/x86/kernel/head32.c:79) 
[ 0.493969][ T0] startup_32_smp (arch/x86/kernel/head_32.S:292) 
[    0.494317][    T0] Modules linked in:
[    0.494604][    T0] ---[ end trace 0000000000000000 ]---
[ 0.495009][ T0] EIP: reserve_bootmem_region (include/linux/page-flags.h:536) 
[ 0.495422][ T0] Code: 5d c3 01 f1 89 c8 ba e1 38 f4 c3 e8 1e 37 8e fc 0f 0b b8 90 e2 62 c4 e8 e2 05 5e fc 01 f1 89 c8 ba be 85 f7 c3 e8 04 37 8e fc <0f> 0b b8 80 e2 62 c4 e8 c8 05 5e fc 55 89 e5 53 57 56 83 ec 10 89
All code
========
   0:	5d                   	pop    %rbp
   1:	c3                   	ret
   2:	01 f1                	add    %esi,%ecx
   4:	89 c8                	mov    %ecx,%eax
   6:	ba e1 38 f4 c3       	mov    $0xc3f438e1,%edx
   b:	e8 1e 37 8e fc       	call   0xfffffffffc8e372e
  10:	0f 0b                	ud2
  12:	b8 90 e2 62 c4       	mov    $0xc462e290,%eax
  17:	e8 e2 05 5e fc       	call   0xfffffffffc5e05fe
  1c:	01 f1                	add    %esi,%ecx
  1e:	89 c8                	mov    %ecx,%eax
  20:	ba be 85 f7 c3       	mov    $0xc3f785be,%edx
  25:	e8 04 37 8e fc       	call   0xfffffffffc8e372e
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	b8 80 e2 62 c4       	mov    $0xc462e280,%eax
  31:	e8 c8 05 5e fc       	call   0xfffffffffc5e05fe
  36:	55                   	push   %rbp
  37:	89 e5                	mov    %esp,%ebp
  39:	53                   	push   %rbx
  3a:	57                   	push   %rdi
  3b:	56                   	push   %rsi
  3c:	83 ec 10             	sub    $0x10,%esp
  3f:	89                   	.byte 0x89

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	b8 80 e2 62 c4       	mov    $0xc462e280,%eax
   7:	e8 c8 05 5e fc       	call   0xfffffffffc5e05d4
   c:	55                   	push   %rbp
   d:	89 e5                	mov    %esp,%ebp
   f:	53                   	push   %rbx
  10:	57                   	push   %rdi
  11:	56                   	push   %rsi
  12:	83 ec 10             	sub    $0x10,%esp
  15:	89                   	.byte 0x89


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250324/202503241424.d16223ec-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


