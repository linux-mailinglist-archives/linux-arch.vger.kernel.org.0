Return-Path: <linux-arch+bounces-5998-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B02A9482D0
	for <lists+linux-arch@lfdr.de>; Mon,  5 Aug 2024 22:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31DA61C21898
	for <lists+linux-arch@lfdr.de>; Mon,  5 Aug 2024 20:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F33116BE06;
	Mon,  5 Aug 2024 20:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ihV6MqsS"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA69115B56E;
	Mon,  5 Aug 2024 20:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722888251; cv=fail; b=ei2B+9WEc2Hrz1pcCSNbFKN2skqjmX4Rjyg7fF7TfWNKo7rqGvwbBb9NyXqcHxivl1cy4ohYEyHEBdz/FNMUwRkll7c/RasfJyJbyWL1xhCtFzp9FnalEpnTJ0kVD6L/haXKf8GO7ZEj4P1BDX5DAtTo0+FFeTfI3SJolfU7izw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722888251; c=relaxed/simple;
	bh=gvMMPTtBCfqDza8OR53faAF/Ybt1pn1FFiwdeNCuofk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kvT9BcTMmV3ogCxL6fmi0ilvCYIU8CMTzlDfGru+p3aXbGOd/6UF4ZroS3eH62Y6pBJB4+CLa2X+iHAXgRidVtHyHZUdgs8e3KJJAnBYVjpZWqQP8rfZ/kBzvWjzVwpmhY2CNyBBlDToWCI1OZmSKNCDEwCb71Webm8s5/xiG2k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ihV6MqsS; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722888249; x=1754424249;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=gvMMPTtBCfqDza8OR53faAF/Ybt1pn1FFiwdeNCuofk=;
  b=ihV6MqsS3UdmKqtI/tBuwKmhCgOav3+AGlvaaG//pYtPCpwFftJrPzUJ
   pbD6O3hmB2M5DGRVSBR4nbsLz3szYSyY2lxyY7wpUbx6vP61p/alerVhR
   aAsOdVnNTYVqjI/u/VGjCXlchQ8Vrh/T78CAvLHsLVsTUsp/QmPAxGIbs
   RgPRoRbzYKgVFPwsY7accy/udePCLv7KMK331Gh+sl+40FXy31vNuCvtU
   GwTFiMc0iCp54ZLHSgFqs1aQajNpnymZ3PbSNIyM92G6tfmuIqE+Z6XJt
   KL4mOb/+lg3FJlsGrT+krTAR9aP+/+Fw5j8n/wy7ZZguPNcK4jrtNNLCx
   g==;
X-CSE-ConnectionGUID: eFAtm6UnTT2lxBs4NP9Jow==
X-CSE-MsgGUID: zJwawLD/QDmdPZy79b4Q+A==
X-IronPort-AV: E=McAfee;i="6700,10204,11155"; a="21020054"
X-IronPort-AV: E=Sophos;i="6.09,265,1716274800"; 
   d="scan'208";a="21020054"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 13:04:08 -0700
X-CSE-ConnectionGUID: 6aXleJnSSlWVO34HoV7WWQ==
X-CSE-MsgGUID: bhuNJxCkQzmoU7THoO9fBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,265,1716274800"; 
   d="scan'208";a="60642076"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Aug 2024 13:04:07 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 5 Aug 2024 13:04:06 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 5 Aug 2024 13:04:06 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 5 Aug 2024 13:04:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AwsKSP7LfpnczwpFA5MhcpjniQhHHkPOEIvi6j65kLEM7OcIHhOEYunYjOzkRMaXsuCwABMyZWOuRc50GJNeL4OUG5UcstnO9758UBgw880td1DyCXhBVt6Vzqhva1PLzHnn++QXDg94P5LexRfblsDlT2jg+CzWRXZcw+6pRI3PCTURAIGUzkf7k/DMNHrmDyNgOPPKgw4XyBU4B3OI2u5fv2thaNA3Sgukpw0hBTEjg1/qL5ClJ+8KhqDdbjJHF62S2tIUbsM+3DvkhXZXuG2LDEhdCQCsGh9mtuY6H0T4BZmbToKF360R4VAq87ia8MRNZo0M94+0h0BkQT5cjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iV+O/S6aqiFnVBSFZXDWyFOkMJi5LlcaZMh+dQeT8Vs=;
 b=MZwpb+3JfhLVuJQZqoVJOji+Eugej+GX+QUI1oLtctbsiTPbzId+345PAtEmSVxlvef7EyJFQUKf/lmIA4zm723nsZBroBGmOCTQd/ZNhuRteaZKQ9gU6BONiNTu26ZqQmrDI3759pmTLu5Dau5a82QH+jmuoJT2AO6nR/ZExUM1+yRfta4ZT/m+NpWZLyPg6AJkzv4DBtrGpGufzdSUWYvLZEGbvgQjUIR08iWMNfEz7jATDWF/SqVN45f6b1OUY1YfRCJ4WXb/wpwAU2l/uWJk+WPoprjH+XVMsT/TH9AwJcvV7PIP2rrSelU5dDJUXrs+DvaAedvuhnRZONiZ5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB7652.namprd11.prod.outlook.com (2603:10b6:8:14e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.25; Mon, 5 Aug
 2024 20:04:02 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.7828.021; Mon, 5 Aug 2024
 20:04:02 +0000
Date: Mon, 5 Aug 2024 13:03:56 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Mike Rapoport <rppt@kernel.org>, <linux-kernel@vger.kernel.org>
CC: Alexander Gordeev <agordeev@linux.ibm.com>, Andreas Larsson
	<andreas@gaisler.com>, Andrew Morton <akpm@linux-foundation.org>, "Arnd
 Bergmann" <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas
	<catalin.marinas@arm.com>, Christophe Leroy <christophe.leroy@csgroup.eu>,
	Dan Williams <dan.j.williams@intel.com>, Dave Hansen
	<dave.hansen@linux.intel.com>, David Hildenbrand <david@redhat.com>, "David
 S. Miller" <davem@davemloft.net>, Davidlohr Bueso <dave@stgolabs.net>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, Heiko Carstens
	<hca@linux.ibm.com>, Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar
	<mingo@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, "John Paul Adrian
 Glaubitz" <glaubitz@physik.fu-berlin.de>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Jonathan Corbet <corbet@lwn.net>, "Michael
 Ellerman" <mpe@ellerman.id.au>, Mike Rapoport <rppt@kernel.org>, "Palmer
 Dabbelt" <palmer@dabbelt.com>, "Rafael J. Wysocki" <rafael@kernel.org>, "Rob
 Herring" <robh@kernel.org>, Samuel Holland <samuel.holland@sifive.com>,
	"Thomas Bogendoerfer" <tsbogend@alpha.franken.de>, Thomas Gleixner
	<tglx@linutronix.de>, Vasily Gorbik <gor@linux.ibm.com>, Will Deacon
	<will@kernel.org>, Zi Yan <ziy@nvidia.com>, <devicetree@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-cxl@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-mips@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-riscv@lists.infradead.org>,
	<linux-s390@vger.kernel.org>, <linux-sh@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>, <loongarch@lists.linux.dev>,
	<nvdimm@lists.linux.dev>, <sparclinux@vger.kernel.org>, <x86@kernel.org>
Subject: Re: [PATCH v3 11/26] x86/numa: use get_pfn_range_for_nid to verify
 that node spans memory
Message-ID: <66b1302ce5fd3_c1448294d3@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240801060826.559858-1-rppt@kernel.org>
 <20240801060826.559858-12-rppt@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240801060826.559858-12-rppt@kernel.org>
X-ClientProxiedBy: MW4PR04CA0084.namprd04.prod.outlook.com
 (2603:10b6:303:6b::29) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB7652:EE_
X-MS-Office365-Filtering-Correlation-Id: 66bce9ea-f518-496f-180e-08dcb589c05c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xacjKR1u4PYQ5OBAsNL4DHHO6Ub/XjGPhPQsQyUXiFyRJx02o/kx4YLDGqYX?=
 =?us-ascii?Q?wd4S7HSrf6L0SN9wE3/Bp+xZ2V70T1TdAiC6U2ZdCHukIEwJe1CipqLbAAr1?=
 =?us-ascii?Q?/pTKIuGaHxkvCR0Toj8+Qa690eUDPz5/sTxsX5O4itWzhbC6BqvCQd/1TeAq?=
 =?us-ascii?Q?QxG5NYMUX7FAo1O3oPK88+jcWRv3ooPYKZ2yEjcH45oBNqSlFYTNlNQ5xBcw?=
 =?us-ascii?Q?O7uz2dsfRskRfSwT0t+yfVo7N/41VrRgn12v9j+cVBIPNn7ZIb+BwjS6jGN/?=
 =?us-ascii?Q?Js+nE+UNNuCoQ3rHBoynYjdyNNnHvVgGJOP2PKogj9BTYFhy0gNOs40fux4o?=
 =?us-ascii?Q?LjiZYl6xkcl7xUuPPoUGTBJXKIRMIYDW2EEvzpNuDCKl4xkV/CRgetbgDi4T?=
 =?us-ascii?Q?xkP6FrgTanIjxhIrZxeTXjBucoqKSCHE2B5AmzeyKU39Glu7rKnbkvJPtuXP?=
 =?us-ascii?Q?5alyDMcxz/MoG8Pttn/LIYCZX+gCrcEXPbEYUwiMEHWsSd5aGC1l85N7uucm?=
 =?us-ascii?Q?fWwr5AVI5kfEYT8A6wXYK0KW/U8R4ZaSLjH+Z4p7MWtrdtUqF18xEADAMNvj?=
 =?us-ascii?Q?q9vl9MDH3KHwgbE3HvMVhDersxxKlEREH5Vd9GJ2PQ8RTECtEWn1/p8gpUJe?=
 =?us-ascii?Q?/cW7IhtD/jDBPT61GvCQo5dUhlqAnv4WlcTT9T/Vv950jxHmkui/3tmEN1gp?=
 =?us-ascii?Q?5V5HolOXWq0SBCe6C9PGxwYgWBuys66UvPQt4Mn2CZzsjnL9qhG01fbBpku3?=
 =?us-ascii?Q?JHZB7nK+0o5ZQ7re7TVyBBJ9x/aoZdlU50+txYfUiWFIMqY6jANj7N2KbRfk?=
 =?us-ascii?Q?cSr4pM8X6VjJaT7ZCbbaUe3Pt6GZjGnU1BePKFtgr5SSycKveYkFJj/plf87?=
 =?us-ascii?Q?i4mZV1FvL3dMiHudzUmD30b5oF18pgnCg458VVQ5LS6Fm8fo8eKoDzEkuTsJ?=
 =?us-ascii?Q?mS2njLJCfjttSMeBmAnZWQ++F8cKUVbxusP1fdgSkfo7Sn4R0WHD5qntIoSV?=
 =?us-ascii?Q?wcx6AVP3h47/kZx99fXYa9vjLVh8FTzjdPU8i48Qz+yWbu8EAGEhhCTCiQRT?=
 =?us-ascii?Q?KxvFqIdDPj5J8YQxidCcjzGf3gDv6oatJI4Kwu+QiJf6jFFTyGINFvQOPp/j?=
 =?us-ascii?Q?Z6M+yO9/ip/JtaKDCmaCwNzwOqukNNFbTSpeWNPl9rT2aWtB7c/YrcoT6rHb?=
 =?us-ascii?Q?YAwwBCSqmFWks3NVgZG67EZ3QMbHKi0piEQjHV/5i37NWHjH01nrJRMXlnPM?=
 =?us-ascii?Q?49Ap6nNjFpA2QtzZK8wEgWCaKVFMYjeNtjTDM4CqKlF5V/TFnVl4xU7RQhWu?=
 =?us-ascii?Q?lNMw5su3LYnyev/66KyQYNj7EwwvSp3IBvVNL2eQiQzarg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?q6pvbEs8YN30Sjt4fU9avaSXxAtlUdTOLJZurTazcUNK120OXr6VshubgueB?=
 =?us-ascii?Q?9qbIImvQA4m4tTKaOfN40cH7jN8pv5GbvgNenYUsJkxXyD9XlH/vy+CvyDQZ?=
 =?us-ascii?Q?VK1qWa6+MT6fCcuKA0oAAHY2UvchzD2gQ2y4UFYW9MzodaB/wJEPXExk221z?=
 =?us-ascii?Q?ENPkAi0zNFA7SVHdFG9a9Hh9u8ZGdW6H34SiwDgEnVYlUoa+OxKOOM36Af/G?=
 =?us-ascii?Q?sSGueG9vN5C5PtXujZLLS4oFyGQ7zp+HkvgnIaCWFTAKH0/hOnf0s39lshsx?=
 =?us-ascii?Q?Zs69Z+uYN8SuPT1hQDWsjMVtDVSeeTdJA2OLLk0lTLYu3a+ulk4UJw2SuQyp?=
 =?us-ascii?Q?VeY6mP7hrxLO5iu+EgF5v/RcIQEAul94Ew+sLtrSemxWejm7x9UHRiDY2UV6?=
 =?us-ascii?Q?E+DOffVL83gTrsaUneFXJVLtzbXzWmcLwHEphxwCCXMWbH7bRoee8o/i4NIm?=
 =?us-ascii?Q?S6V/5L8cRX57AezJLWSWp0eyLsRSzNFF55I4MROm89yfIkMAH6tf1obhhyxz?=
 =?us-ascii?Q?zNwT8d19v6CIvfqRbxwXefi4NEDwmlJQywa0JZRX8WOdODjiTaM4eFVFaNRI?=
 =?us-ascii?Q?+o8WJ6bCOyTmqv1cIZLvTjESX8ZnpmkjPzu0x87dxyZ74uLcoZ6dyNCOpVHt?=
 =?us-ascii?Q?+UwaxAK5opfirJnEbZua+ZnSBRcL21uGjiZSlxHvx/unTGgU8cE3U/RELjeC?=
 =?us-ascii?Q?pnZcQEqqixsku5xbYNuhupoChCPKz5RIA59v1PnTLUHmK5b6kbR2RgjX+BUD?=
 =?us-ascii?Q?8duE3IUBwJkXL47ydBkABNWZakb/F/K7ZexhEig4BHm5rB6KK5tDHHsiirLC?=
 =?us-ascii?Q?lIXVtG7E2OJmbP0rPtjwSGreq2vHhiHg6OU/VPrQekqql8VrUVJeztR7dW5I?=
 =?us-ascii?Q?3ICdKyZwQjab401t8rNSGjK/dwTMuKjQmn04w6OIB/TtUmAWg2HRTSu72KcX?=
 =?us-ascii?Q?zZNr+yH+GXXJaLZ3vb5gy702oBsgoLfcBNYh2cCRUkqIIDl35SVy+ZGnoMmK?=
 =?us-ascii?Q?PuF74TzH9fNtBK3uwYkUjKGgpMItjvXeFE3+f5crOOzxQ8jrYHc6NL5TaLd9?=
 =?us-ascii?Q?pZQe/YLg1Tw5eRE/tzGS1KDvuSz9EbOvhhhimaO74Wd0MQmryLDAQluJhyaV?=
 =?us-ascii?Q?hLHdS8FrDEuvPzz4Ais0fF/5PybqILv6wvakRbh51O0zDHlytn70qYTFc2XQ?=
 =?us-ascii?Q?aWJqv5+elQD59n/gjBa2NBdTBD1p1vEWluXETsIsLT6ZDQqQTxLpoXRf/IEJ?=
 =?us-ascii?Q?3IAA134AyIXsXTzN1QPDkWz8MEJqZ2cvFXXDhyXVDAlXRlVFkNbxRspK807t?=
 =?us-ascii?Q?Ss761KYQQpn3y1mNjgUdmu7eHA0hXJ5oGhM6NCzgmW7QDeG0wnfQY0lPDrnl?=
 =?us-ascii?Q?QLXYeiSfEqpXFxvTKsu+dGhZ3eyIWIxIyMmK3I8DcSPXCyK127TJXA65xT4y?=
 =?us-ascii?Q?v5G0o0HKnfN9N6/CfLlmNs4KUknmuqLL/wjl2EsLeb+vbtUY2wXljTHLJzs+?=
 =?us-ascii?Q?vW9zQujSjSynKWK27njlQnPoVssT9dcPuAyX41i/25nQwPk0Kt9jPhOyhWJ5?=
 =?us-ascii?Q?T/NVMPhnQmHB2IqUiYYe7J1X3os5XPAYy//mkXl0Kda71Q5GZqW10hHVQk6w?=
 =?us-ascii?Q?hg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 66bce9ea-f518-496f-180e-08dcb589c05c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 20:04:02.3657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qsA7khBGfY8KD9u1OdYKRWqzNeZ44AviUYeyABvEIY6n3ybooeIo8/mwo4wyxr0wcZ51k+slWMOeOUikABlE1tGzbYbcAbgh0B5IgURxyqw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7652
X-OriginatorOrg: intel.com

Mike Rapoport wrote:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> Instead of looping over numa_meminfo array to detect node's start and
> end addresses use get_pfn_range_for_init().
> 
> This is shorter and make it easier to lift numa_memblks to generic code.
> 
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Tested-by: Zi Yan <ziy@nvidia.com> # for x86_64 and arm64
> ---
>  arch/x86/mm/numa.c | 13 +++----------
>  1 file changed, 3 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
> index edfc38803779..cfe7e5477cf8 100644
> --- a/arch/x86/mm/numa.c
> +++ b/arch/x86/mm/numa.c
> @@ -521,17 +521,10 @@ static int __init numa_register_memblks(struct numa_meminfo *mi)
>  
>  	/* Finally register nodes. */
>  	for_each_node_mask(nid, node_possible_map) {
> -		u64 start = PFN_PHYS(max_pfn);
> -		u64 end = 0;
> +		unsigned long start_pfn, end_pfn;
>  
> -		for (i = 0; i < mi->nr_blks; i++) {
> -			if (nid != mi->blk[i].nid)
> -				continue;
> -			start = min(mi->blk[i].start, start);
> -			end = max(mi->blk[i].end, end);
> -		}
> -
> -		if (start >= end)
> +		get_pfn_range_for_nid(nid, &start_pfn, &end_pfn);
> +		if (start_pfn >= end_pfn)

Assuming I understand why this works, would it be worth a comment like:

"Note, get_pfn_range_for_nid() depends on memblock_set_node() having
 already happened"

...at least that context was not part of the diff so took me second to
figure out how this works.

