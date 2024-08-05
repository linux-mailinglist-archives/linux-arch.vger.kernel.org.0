Return-Path: <linux-arch+bounces-6002-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A916394833F
	for <lists+linux-arch@lfdr.de>; Mon,  5 Aug 2024 22:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60060283993
	for <lists+linux-arch@lfdr.de>; Mon,  5 Aug 2024 20:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E02C16C696;
	Mon,  5 Aug 2024 20:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z5boWC9J"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0B216BE32;
	Mon,  5 Aug 2024 20:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722889273; cv=fail; b=lNpshQRQdaf+6omYQpFnI/z4KBkkVR0QthBR4J6qOoACHkkx5hAE2LgZq7wm2mqtiEPpd5qSh1p5coDGGQNsPBK4VAh2oXeAD224/qZY1tluoxoXwerYBxxfLMn3YGXLxkjEkQKROZ4k32WwD24NGxMSFmOFFbpnAFnDT4pN+vI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722889273; c=relaxed/simple;
	bh=BuewavRkYNFOGyHNgSR/IQ9nrA+dzqky5iau23SF7r4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qQCWSqW9XavjJozVL8ZFmtFEce905yWohCBFNJPMZGNjLh6HIsmJHDsp8bpUeE0hn62E8MP+EKgT67juksTBIvjxfY7awV74tAJL3KU6CVb8x111/eRhqxjbt+gn1dNZowng7n+Zzzu7vXbMvmdkYNiLOgLUZI3NrWBTBj+7WL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z5boWC9J; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722889272; x=1754425272;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=BuewavRkYNFOGyHNgSR/IQ9nrA+dzqky5iau23SF7r4=;
  b=Z5boWC9JzvVR9AEhJQOHSiBcFXrokV0Kt+K7Om54flU5+AoQvFzsRXCD
   pQ2FD5EMwjiuaxM8Gg5jK8Cya3S9pc7qPRx7f/IR5vKHMwolWY7QqOYbR
   1N9cxzHHNYQgRZhIoc8P9LWh3uF2pb+fPGEkAvXZnGKmmvrZh5WR02cPY
   pOzzUeJ6LHzgk6SwkHbrRvgkY73ap/5rEh1oUv6dWxWZNHFrb0j2mpNph
   gxNVBwzh9RC/Z90g3Liw03OeYpYXG1Ei15x5TD/gD4XruDfNnQgS+eMS7
   sOGWDQ2y7kIOB6Zhc9uduuBD8PwPS6cXwzZNN90YZAk8+7Hy7rooVcHVU
   w==;
X-CSE-ConnectionGUID: tiCYAztWTMeBZV6LtcNGVg==
X-CSE-MsgGUID: zSf9tcXFRH6Ugcq6LJ61Cw==
X-IronPort-AV: E=McAfee;i="6700,10204,11155"; a="31510235"
X-IronPort-AV: E=Sophos;i="6.09,265,1716274800"; 
   d="scan'208";a="31510235"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 13:21:11 -0700
X-CSE-ConnectionGUID: HWsGH+NLQZ2wMnMzJKVStQ==
X-CSE-MsgGUID: kbt5OP/pRO2uWBYa0hC+SQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,265,1716274800"; 
   d="scan'208";a="55955805"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Aug 2024 13:21:10 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 5 Aug 2024 13:21:10 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 5 Aug 2024 13:21:10 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 5 Aug 2024 13:21:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C+A0fsANf4VY2UmfYU0jeXNjbF90gTX4ETaAPflBkhQs4YuCAfBTc5PSLJFFn4vTsGNeIDMx/b0u7wKs0Lzro7l+ndWSX1fOPr3g8LaTW6BFRCa9yYqYAXhduPEZuhdhQTFE4leU7kYKhhwucUfH5a5xlqYz48RZZWDs14R9a/5L4LmMBK+c5V4mhvT2MQ6U1t/fDdCguqY/JaGZJ3NWlYFDKhMTrv1CvNBbWgCvKlBrM9wa/Bz8wxZWEgwAXlVGrqhDZQrqmWgWj8eToNfzgZZgEGz0k1/+w2qciu3NuXKCD95xK/HzFPAsgfmVQQjn7zmkMkdDWLmmwLQcOMjMrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mu2MEYGgmeSIMzuSCuS5kZlPDZ4hTB2lUGjm/Ii2nBI=;
 b=lyZoCbdsaC+1LYq6BUwzp0eHrqk1Yg+xjVW0r5hAoSG7C4+DGpIufT2CdJan5azvULGPBRa1DRWlH0d1GfbPq58JbNAJQjdATBgwnY2JYeKEmvMyC92Ou/MSqwry0673wr8lLgl/L46k2KVPUa391DKxKOBs6NpIRUQXsiiXy26mjAEIZk1FUQpx3RLfEjTXB3YwV0osOmEdcdebR978eI6jbrUkBATq55AN3UgBYC8w8Om7tZylNuF4atvrkfVPKNwlEYpmrLesCRaODdtrHeW7eVPGNQU7qRoiWK9kF2KpRDiRnG4rekr4C86n2dapc0OsLdtR66/Qj5SMf4BKcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY5PR11MB6258.namprd11.prod.outlook.com (2603:10b6:930:25::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Mon, 5 Aug
 2024 20:21:07 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.7828.021; Mon, 5 Aug 2024
 20:21:07 +0000
Date: Mon, 5 Aug 2024 13:21:02 -0700
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
Subject: Re: [PATCH v3 22/26] mm: numa_memblks: use
 memblock_{start,end}_of_DRAM() when sanitizing meminfo
Message-ID: <66b1342e8af7f_c1448294af@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240801060826.559858-1-rppt@kernel.org>
 <20240801060826.559858-23-rppt@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240801060826.559858-23-rppt@kernel.org>
X-ClientProxiedBy: MW3PR06CA0007.namprd06.prod.outlook.com
 (2603:10b6:303:2a::12) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY5PR11MB6258:EE_
X-MS-Office365-Filtering-Correlation-Id: f1674411-a020-46c6-959c-08dcb58c2369
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5/hLNhKXOp/wopfuvWURvPy2csfDMapvPvWULjbnGLntOjrw7dB2r0gvJDZD?=
 =?us-ascii?Q?ZV2/Uv+cUyzxeB/8y6bTkq6aSXhNMUhJJGXvPhfERoykTBKNd3J0d6gNbI0j?=
 =?us-ascii?Q?vBCE2TvuWxSQ5BDFXphDdfpywhugVzOHp79ortqPw79F0uXses81JeXHMhEf?=
 =?us-ascii?Q?uE46jewOR3NcipCIAkz0g1y/EhRclNuoBlAqdibL30lLebAWcJz5oWnNB5jg?=
 =?us-ascii?Q?ZwSA7u3WGyEa6jvk15tq/oc2jGnO7YxYV8A3ukZjRIr04SBX95/fVmH+dIi5?=
 =?us-ascii?Q?TFdEIh1mBQBtshxmnvdDtvm+dLQ/lr4mquntKplse64eHlYa7eVU6RwpuxPX?=
 =?us-ascii?Q?1kaCI35umf2kYzbnHUeibmbg4oPkHhYZsWW66k16TYx6VKsM2yZdpfHGygK+?=
 =?us-ascii?Q?uNHenfhbAd6ZcJTz2g39NZfzZ0gId+X5IAXFbchCojr36v0XThXMM0dCGvv4?=
 =?us-ascii?Q?JKzm9XGsqRCQBNJSCZ7Fz/ysA67Q5cHMK51OLEAWfCTrCBIquehC5qmQN/Zy?=
 =?us-ascii?Q?vcK1RI7N0h/JJdge9I9rptZXVRYexRr+JD6huNKZdvAgdH18UkkrimP6UEnA?=
 =?us-ascii?Q?ngy5VeON4Sb+7GpdEbMQsyObP37d0JNKipMpu3wlD6OupJgwRYML2oc0c6T3?=
 =?us-ascii?Q?W/MSQ+EckIVYZFXeyeuJc9Aam2NFthm1lvFCXiFxFPVN8RWGSIi4SzEMQqwu?=
 =?us-ascii?Q?noOy79xZ/hpMwirIoB6ZVgPTWxO5Wqui+2cZGquF+uNnaKl/JR6irkk3D/pW?=
 =?us-ascii?Q?UBnaFgUvSoMP4Pd6jClxgRp7MVE54zVC2G2UY8J1eKWC5S5pnsOS6EnI1tY1?=
 =?us-ascii?Q?CnwZvsNhtHhyYIprgKUG/buemaHgwxaWHyLmRtxST3JrClTa/yNW6wlS6rfk?=
 =?us-ascii?Q?UHlQQmvHOGzdlq+e+b4QNmsceNTbTwlkjZrOBrmU7VtEanLpyN/xJGLvD5Bx?=
 =?us-ascii?Q?FmR8ALZW3/Isr3E3jbxuJo10w4822vzuVxCaHWXLeaqmPwH1RDQfrp3wYEw2?=
 =?us-ascii?Q?MmXBFHcmPVZ+dUMtnSGSNzyKA3v+1I/dfa7nkut4/mEDSbsXQrXy5KI+7Z3R?=
 =?us-ascii?Q?kILcmcmfDqcrmpExBgNLTzjABhrxurbE16TP113QKUpe/yd+TcoyVLBwO2f9?=
 =?us-ascii?Q?YZgMX9zfM8F3c3twBJlPVd0j+uUBgY3zi5BCn2fnHThZCjBcungFjiLor18f?=
 =?us-ascii?Q?KrPfz8NIoCyLm+j6gDS3jdV1rN/dXvIJrvR2vrcMciACmyz+q15Ep8CA2lue?=
 =?us-ascii?Q?5w8AtEkqacM3cQql5onLyVOyYNnVqt5bLcsAEIb7vUyEumbdOtonurRy7cA7?=
 =?us-ascii?Q?bWIv9IbxbC/MUTRWIo1TMJV4vCUeb/iee9jAcgLcmfmpdw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iFsfRUyhChQiP/AmE9jWK2aK1duROCk1H8QMEi3foHXT2CJtxAhKvHrtSjK5?=
 =?us-ascii?Q?pigF20pQ3GC0yaeRZWHatP53tQTfX5wOx/vew2qVhgzGEU4bApUvEN5hBPq3?=
 =?us-ascii?Q?eOChNkRK2RNkz+4PDr0NKg+sz7YwQDDeKjkoqsUbbbn/QpghTFFJVkkmbD71?=
 =?us-ascii?Q?dOEFcalvZot5AIBPbleXC8quVecX6PQ7zc8QoCoqy8Hn4RwrEoNcC/Uij+vt?=
 =?us-ascii?Q?G758usKnBIrLW/aKvNIqsBZ7prX2kiQX8NkUFYfxuag/JwfURr3bWYnruA2y?=
 =?us-ascii?Q?ecfjWLojooKz7rB8/8Ej5W3/Q9LtSuow2VKfwyZUbkRaol/2JQ073ZVn/GUT?=
 =?us-ascii?Q?24WMlb0iIo4oTiT+wijQkAlX0dhQ0W8ltsIt/gKGIbzIcWJx1Kq+vscnBPyE?=
 =?us-ascii?Q?WnPJUgQMTWxPOcKh+2S8i3wEKJtkbwmc7GyfyqX5TS/na5x3bTtJ6/XoaGZ8?=
 =?us-ascii?Q?H0pv041tyPiMLx4gBReZ923eikU/f/PDrhO5I1WuGTaO8tymfc9uDq/bhrph?=
 =?us-ascii?Q?IZwvsdkvdJKUvLvGi5ksupeBcmeyraUbHiWZZ3O0z8RrDtywfgv9gmN9tCzp?=
 =?us-ascii?Q?7JfrkrPuLaC98f3uSwxA0ZEc2suaTenUUWcRV31G2uA55FPfHqsQv20DFKlR?=
 =?us-ascii?Q?jacIDuGcrVltV0oyyf2cxNRk5sBTr0NCu9TtPUNgo93OuFDVpdlreFj7QZg4?=
 =?us-ascii?Q?YSyxxL6Fd7Vf3VpuZQ+twnHAbgyTOItgabPoNWlUrLqv4G1HAIaps44S0UeH?=
 =?us-ascii?Q?OWrH6w0y+L/0YRxAQEsH8EkNkv1vER2rk6jLMuIQEzL3riG6R4dls5NbNPV/?=
 =?us-ascii?Q?dVPFffdKOhK/4AJuf9b+b1eI30WtWJsm533UGDchunRKUrOENekzt2tonOkM?=
 =?us-ascii?Q?0RlsQWnuBOk3S8YHTwASiDEkNRy7amh3BSPikOYZKzC9sHxejCQJLpDV4ukh?=
 =?us-ascii?Q?If70Fn3kcs6yIgTbJrrSFX6L88K0nZILk2WbxGWlLdSNBbfDUStDH6FaVkm1?=
 =?us-ascii?Q?H1v4j2lQgKiMlPifTqaQvUgWQ0Ewo7RsjucOkwqm5KxGQR0J7KdOp/xMq7Ti?=
 =?us-ascii?Q?lJbreyDlBKsm3Z5Z+GVA1PCpWK4Oge3z9W7w9nqqxtyMCZ2ZaOxQVhEgYZ10?=
 =?us-ascii?Q?6EWnf8PAq6tAuCKvSKDE5yItCHkAEIMe8SXxadCybCwBi7Qu05f38hXuGqYx?=
 =?us-ascii?Q?tIwPDBcuArlCjFuQHnTNLouMEOxvX7tQ3oACpaS7n/wTqR6dD+ZeAD+CLrkF?=
 =?us-ascii?Q?Nxk/F/iDyXQqJp1vCLZl7+nnBxsbPnrZyYeEm+g0oSJSTxwfBG/76a5XjOHK?=
 =?us-ascii?Q?i25C0QtLh2UtwqLbE6ZQkRzat+8+eIZmnz8TyRJnxNpEUav/OUqJXneY50TB?=
 =?us-ascii?Q?azMa+DmA4AN82ibeWOh/vKmw6vqPqbg1xVVOjESHqJFaCV3j9IGUjyv8E7h6?=
 =?us-ascii?Q?gfmnCfzXpeJCrYgC02kq0qq3AtlIwdx35/xSiB85geQGWhqfgTTeXAsH+anB?=
 =?us-ascii?Q?wwmc+hUG2bcQzC6u+ZHsT/E9Iun6Qqw+vEhdboLZ9cLzbSBaQ+bqmBeFzok+?=
 =?us-ascii?Q?nJNRdlFOFeBNQg6OEPvK1YEyode4CxBkBYNUDIcszr0QVONCtX7ogLgw6zdk?=
 =?us-ascii?Q?Jw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f1674411-a020-46c6-959c-08dcb58c2369
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 20:21:07.4932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MEzwWds33SHBk8qstNssCtrKUwsn+ZACMsh7FCUu9KebU3PnbkmYs5yNOomom4pz1qsZxJP2I6dNkSSloGut1HLUQ1PtGSxyk7pGXAK+hDs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6258
X-OriginatorOrg: intel.com

Mike Rapoport wrote:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> numa_cleanup_meminfo() moves blocks outside system RAM to
> numa_reserved_meminfo and it uses 0 and PFN_PHYS(max_pfn) to determine
> the memory boundaries.
> 
> Replace the memory range boundaries with more portable
> memblock_start_of_DRAM() and memblock_end_of_DRAM().

Can you say a bit more about why this is more portable? Is there any
scenario for which (0, max_pfn) does the wrong thing?

