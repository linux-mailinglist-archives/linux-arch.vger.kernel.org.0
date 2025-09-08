Return-Path: <linux-arch+bounces-13421-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63704B49CAF
	for <lists+linux-arch@lfdr.de>; Tue,  9 Sep 2025 00:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 095564E4095
	for <lists+linux-arch@lfdr.de>; Mon,  8 Sep 2025 22:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3512DE6ED;
	Mon,  8 Sep 2025 22:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dH2IGKgY"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC831DDC3F;
	Mon,  8 Sep 2025 22:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757369093; cv=fail; b=PNvc/QJ2AzbkCXbuDgVlBKFZrvvhYbi/nvtgamrMNmXxYt2RWPuXgxivRAq6rNJEi4OdtkS2eliSdJcnTdtxQbyw0skvhkuK48gTsCSNpkjFk/hMNvIIMZqllsSh6A7N0KC50izXgElW5sFODuzjihlWzjkMtlqMUqX1PhiMtvs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757369093; c=relaxed/simple;
	bh=cjOa4ASk5GLGx311NiOP09bvyeHgyqQKo/a69b4Ddho=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=ASiXdjEScmrjtHcCf2djJsvj9ZM8iSfTtUypSA3AKYwbfUqy0YRxxVy9qRT4svGRxIOGh102o8ZeFt7l4WnX5XLzRoc/wto0HCJptKbS/2SUYnJhV2/Yu7TLMcm81ydwdNpcIWADA/Dy9IDAwOda4Dpu55S6l7BR1em+YgKpgog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dH2IGKgY; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757369092; x=1788905092;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=cjOa4ASk5GLGx311NiOP09bvyeHgyqQKo/a69b4Ddho=;
  b=dH2IGKgYpTJjojnODTrlvHZLQYC+ZHaPQrRLhycRNuzXHc3zyjHgwhDi
   mqLBq2R58Q8iP+rF6sg3+UfjL4kWhMM2uWZqMn4ATqmGiMJkW91Hd+W6c
   BZtqBOBL5HwQFt5SDFIbdgm+9FndRUvGcDy3vzfRM4UL93rZ7oftSckqS
   DS5iFAHyUanRkfjXq8BPTEQSarToL7LOugSuXvWa3fUfChCQGR81NkXdm
   w33kzgkZrqyVEdQphqUwprg5mF5AWIN+9DU7XAeklcHmjnmrVzUT2RldR
   qrPBMKSWwK1Ihizwbjjyvc//kLHQoBjk/fjixsIwCbIFpMu+kVxi6qQj2
   w==;
X-CSE-ConnectionGUID: xLS6sqfqQNa/8k8esTzYsw==
X-CSE-MsgGUID: 7PoA9f5rTeWWTuPrwcweuw==
X-IronPort-AV: E=McAfee;i="6800,10657,11547"; a="69893958"
X-IronPort-AV: E=Sophos;i="6.18,249,1751266800"; 
   d="scan'208";a="69893958"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 15:04:51 -0700
X-CSE-ConnectionGUID: oD3qmf1oRfaFqfFAhkSD+Q==
X-CSE-MsgGUID: 6QvJcLQBQ7SQy/oU0T7WNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,249,1751266800"; 
   d="scan'208";a="173035590"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 15:04:51 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 8 Sep 2025 15:04:49 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 8 Sep 2025 15:04:49 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.43)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 8 Sep 2025 15:04:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iFbuDSLC2G4hIsV2yajyhckmnlOhiTTU2JknOkoZ3kesdtdHfmqWUI1eMGFKOWeoPGuPolmxKYYSObIXCrbXXT1ifnX6gNaiqCxfUWpHjxLBAByJ0GaFti9Z5XpfbSsBXG1RtCTQdJAK/ifqpWmIzIk4GIMyiz/aF+iWEHBlfiLiZOP23qlZfbjbMJUvIHQSYUmyAm+ymyNgAc5h8rI8Diyf3mXoi5rkw3MwrowMdRPiZs7W7PRwWWjJE+obYNFxlv+KcQjY8KbfG/hOh4Ep7pX/TUow4q/xsuoZfCWUEB4YHu4AfiIoOtKBchTTZHpWD2Ucox909RJWNwkH644fiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s40j1zUlBcdX2aOaKu6feu/CqVgQQtW+c2u5lCVtXCw=;
 b=k5lj0DpiIy7CBbmgWzx+g3lH4SSjAJ7OtgOT/vaNbpgn3qU0R7lSNJGyINoEjFIXD4LjMosur8fPJQPJpUm+DG31wtJ8rqi/CCfGr3TMnydzhGJLVWGJY7xtObeaT0VZCsvTJ42Lfi+1jnqjO9aiZVmfiU0tOx3xPtMYVqtXO8LdzpdhmVDH8Uv98u4xXJjYel5DFNMwc6C+nVKriXrCaNoga+OORlzqmd+p9cQD5oHR8Rp+SWPRmB7vSmlKjVV5zPr6WD9RATJgyaAU3jCG5WGL/q1Fg8n3wqRAVuy+sOqvSs40F/yJeSA9/VcIDHRi/tD6WuP3kY+qCfl+jMyZXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA3PR11MB8118.namprd11.prod.outlook.com (2603:10b6:806:2f1::13)
 by DM4PR11MB6264.namprd11.prod.outlook.com (2603:10b6:8:a5::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.22; Mon, 8 Sep 2025 22:04:45 +0000
Received: from SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::c4e2:f07:bdaa:21ec]) by SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::c4e2:f07:bdaa:21ec%4]) with mapi id 15.20.9094.018; Mon, 8 Sep 2025
 22:04:44 +0000
From: <dan.j.williams@intel.com>
Date: Mon, 8 Sep 2025 15:04:42 -0700
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Catalin Marinas
	<catalin.marinas@arm.com>, <james.morse@arm.com>,
	<linux-cxl@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-acpi@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	<linux-mm@kvack.org>, Will Deacon <will@kernel.org>, Dan Williams
	<dan.j.williams@intel.com>, Davidlohr Bueso <dave@stgolabs.net>, "H . Peter
 Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>
CC: Yicong Yang <yangyicong@huawei.com>, <linuxarm@huawei.com>, Yushan Wang
	<wangyushan12@huawei.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, "Mark
 Rutland" <mark.rutland@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, <x86@kernel.org>, Andy Lutomirski
	<luto@kernel.org>
Message-ID: <68bf52fa851d9_75e3100ac@dwillia2-mobl4.notmuch>
In-Reply-To: <20250820102950.175065-7-Jonathan.Cameron@huawei.com>
References: <20250820102950.175065-1-Jonathan.Cameron@huawei.com>
 <20250820102950.175065-7-Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v3 6/8] cache: Support cache maintenance for HiSilicon SoC
 Hydra Home Agent
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0043.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::18) To SA3PR11MB8118.namprd11.prod.outlook.com
 (2603:10b6:806:2f1::13)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB8118:EE_|DM4PR11MB6264:EE_
X-MS-Office365-Filtering-Correlation-Id: 74d058ce-75a6-4d6a-559a-08ddef23b793
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cStwcUw1TEpEclR1OWR0aS9PNGVOYVJzb3RyZkZObm1jb0xlRzJPQmFBbmlG?=
 =?utf-8?B?cG5ITjZRMHlaYmQzZ0hRWlYzV2RZRUdRL2pLT1V3YjErR0gvbzhhM2t3Q01o?=
 =?utf-8?B?c05rMDNReWpnWHU4bEJnQ3lVYWdKaHRWZFduNXNZc1lqdmh3UkpneEc1NzEx?=
 =?utf-8?B?MW9ZVGl6M2lWYVpyUVR5MXk0SkxtdHhSbDQxVFhEN3o0bk5vUUtpWG0rdDkr?=
 =?utf-8?B?ZG14MWUvMHN2aGlSaTdRaWFpMTFxaWxhSU83TnVLem9GdWV2ZU10QmJZOGFT?=
 =?utf-8?B?ZkZBa2JoYXVpeWFJdWpaMTdKTy9jTjJIZjRMdmRsNk4xY1FYSXBHVCt3cGsv?=
 =?utf-8?B?eDA3L1RscStqeGI2QUdUQzlDbTBqbnk5U3pVWTNCdHlGZWxjYlBrMjZZWlRH?=
 =?utf-8?B?ZTBpZ0laeXBLVXhHaEsrb1l3SGxQTHZrbE9zTzRQRTNhZTVoTzQ1THZYMGxs?=
 =?utf-8?B?TVdPYkhBa0RxVUZCUndDeFQ3eVQzR0k1cjBFM0d3WmFLZzVhc1JKZVVIQzNC?=
 =?utf-8?B?RjRxVGtsSmxjUm92VkVyQXZRYVdOSlZXMjFQb2kzeURpRGEwTlRGRG1jTjBl?=
 =?utf-8?B?YVdReEFMOVRoZS9uQUVHZFpGVnZVMWVqMjJXNkhIZjNPRXNoQTNINHVjUHRO?=
 =?utf-8?B?Mkh6VVJpOWZhcm1uYzJxUnNaOTZEUXVxcXJDd3Rpdnp6OExSYTJwNzJMbGlJ?=
 =?utf-8?B?YlcvVE5IM0xzS2JjOEhna0ppRUtDdGpJQngycmdVMy9FWU15TDl2Mm5INVIv?=
 =?utf-8?B?Nnk3aVZwdUp3L05jNFNnOURMemVtM1lhZDg1M0UvRUJKLzhnRi9BTjRhWGNs?=
 =?utf-8?B?SDRISlFNTVh0MGE0WkM5RUN3WFBoQlFaY3ZwdXJBNmM1cDgrQ1R3MWxnLzli?=
 =?utf-8?B?eFpmUUdMaElDU0VBSFUwOUtxRTVyMnhrcDdmNTZBZFhCMGRwL1llVGY2dnZy?=
 =?utf-8?B?SWlDamxQa0VvdnE4S3hkVnZVTmloMG9WMUttdmg3dHpFT1RQdWpGTW9UaXRS?=
 =?utf-8?B?Tytmb0RpaXJVY3VUK0RqL0NNSXVwRWF0eUp4OWQ0QVkrYU9qVGt5cW5NY1JP?=
 =?utf-8?B?cFVOWjZBcjhjSTFjVGg1Y2hKVEdLR2ltSVVyNXk5RkNjZ2oySEhTSkg3bGNB?=
 =?utf-8?B?d092M0dOZ3JmWGZkMTA2K3lkbDNPQ1lMVnNvSXFqRjBFck51YVc2NERrK2Nj?=
 =?utf-8?B?VkhZcjN2bWJmQjhzME1JNE9jcnVmdVNScnUrSFdhN21PdzBrbHU3d2FhaG5U?=
 =?utf-8?B?Ui9Zd3BTSFZPNkJvT2hEMk5zbUhVVi9BdTN0cDBKMmdvOWdXU3JrTVMxZTF6?=
 =?utf-8?B?TkRsTWJyc0FrZ1JPd0QzQmszbkdiWnNqZVpOWU9oU3RLSmI2UVI0QVA0NmpZ?=
 =?utf-8?B?V0dpeHhwZWRRWkgzVkcrcmJmOTU4MnFNTWdmdmJVZ1RyemdvU0FweldjNWN6?=
 =?utf-8?B?NW0zL0ZxYjhTQklXb2ZIMTZlSnNKU290SWlUd0RkOWdjTzRRSDdDTzFnWnpJ?=
 =?utf-8?B?b3dsQVh1UDdsR1NFbEdKdml5b3drSkNHLzRGdkJkUUovTFZ0MllBZnhkVkdx?=
 =?utf-8?B?SktuTTBpV0dGQkZGUm13ZGczWVhycWpQalBRbGdENU55VUN2cjJBWUJuOWEv?=
 =?utf-8?B?aENXMUNHZVVlWTd3bWQ2UUVOMjRvRWpKTUF4R2ZCVTlXeWdFYkdoWm1VRjR6?=
 =?utf-8?B?SjhCSjJwaVIyK2w5Smd2SmRWNDVraEVCRW1la2grS3B3WjBCWkFaVzAyc0V5?=
 =?utf-8?B?bi81dnkyMmtuS2E1TE9UTkE2SFEwYlNEQmlxZDdvUzhVbjZmTmd6cFhiOVN2?=
 =?utf-8?B?aUxyMityRUFTZ1ZTRzRmTmNZVngxc2p5SmZuTWFsZ25CL3ltUE9NdTB1SHFF?=
 =?utf-8?B?aGxaZ3RKZ2NFd2JmMlNjSUt3S2dZYmgyOE9JV0NwUkorUzFqVVlUWWowanlk?=
 =?utf-8?B?MkhsVXN5Q0FmUStKS09pc3JNeEtQYy93WUZvUXpJcCtSRkI2bFJ1VUtnZCtl?=
 =?utf-8?B?eXRuZ0tDb0F3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB8118.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXF3MWE0bU1GYWNNYXFWK0oxM2FkQ2p1a291REpSVngwSFJwNDB5YWNjNVEw?=
 =?utf-8?B?SjJVcFpmZ0k0bjNYT0FDa0tMU0JqWjJFd25YM25hMHo3Z2pKRUpydVBFbHdL?=
 =?utf-8?B?RVJNL09VdFB2cmlaK05XUXNxVmppZXVIVnhpeldQWEMvOUpyalJsRnE2UUxI?=
 =?utf-8?B?b3FTd0dXaW5QNUhJMVpnSkd5MlhHSmJROElRRjhFMFJIZ0xKQVYyZnpzY1hn?=
 =?utf-8?B?N01xZGREa0hQNkozRmJFeHM4WlIyVSsyRGd6aXFzTEUrSmRicHY5WitMd1Uv?=
 =?utf-8?B?amVJbzQ2bDZKYkVXeEp5WVRFMDg4alNUU3dkZXJjZjZMU1c0bDFPa0ZvczhQ?=
 =?utf-8?B?KzRzU1U5TDdudmxaWmh0U1hlYW95QXpoWWVOcmwzOEdDMVdXOHYyNlhlWExU?=
 =?utf-8?B?bmhLWC9BeFlSQUlyeFRuak00Q1hKUjhqVjFrZ0lmdmptZlNmU2VHM3ZzWHJ3?=
 =?utf-8?B?cnhHaVA4UFIrWDJid2RIdGdEcVdvUkNrWHJYVkdMaEJJS2oweDBzVEx6ZlYw?=
 =?utf-8?B?OFA0TTBac0pDUFplTTBOMGUxNlZxcWRvaWgwUFV1YUNKVExZVEtna1p4anZk?=
 =?utf-8?B?SVBIN3dmTXNIQTc1bU83TTlTb0htRmxjbGhIUDg1WXk5WUlHOVphWE5NQ3hv?=
 =?utf-8?B?M1FMbVB1WHk5STQvbWdwTXJoMGdNajd0Yy8xaklrS25BdURqN0RGdnJHWERj?=
 =?utf-8?B?c3FWRnZBYU9QY2ZLZ1VNRjlzUk44S2JCSnBjQlBkK055dEpXb1FBK3BuQ0NL?=
 =?utf-8?B?ZlNncUEvSm1PL0xaZURKTTdaNHBXN0VuV1BSeU02c1J5RjhSd0tZNE8zb1Q1?=
 =?utf-8?B?cWQ1QTlibGdNZUxBSzRRYVBDdkRRNTlKbDhqSHZwcFlGcW5nbzR4Q0tBVTdD?=
 =?utf-8?B?MGJOWmp0VEhHUDViVU1sUnVUVWZ4MzBhTjVvQUhJSnVOTDZTbmt4MTY1d0Yw?=
 =?utf-8?B?SSsrUkxUSW5tQTZaQTlSL3ZsUU5wS0txdVJBUVl6amltS3I3Y0RyWjFmR1ps?=
 =?utf-8?B?RWtnNUJSNlBkVGFtZmsyZS9uc0tCWmZtTWxzM1RvUSt5dFlObkt4L0xJRVlQ?=
 =?utf-8?B?RlZtTlNsNHJjeEV6a0thWWZsQjFMU1JrV0FRR0V1MWt4L0pZdGZodURQTTJH?=
 =?utf-8?B?U2ZpTDZsaEppMmM1QmUrRDdpdmliNm5jSHd2U2IrU1poTkI3WmJTV3VVbzln?=
 =?utf-8?B?TlZNNWdkUjlnV2tDdkYrYUhta01LcU9EeUZnd0lkODBGTElaMmxYRzNsR1Ns?=
 =?utf-8?B?UVV6RlU4TFJLYnIvMTB4VmZ0VGNYNmxvaWJ6cFRKZFh6SThBazlxV05qN05r?=
 =?utf-8?B?Uzg4VXE1azAwMzMzVWRkK0t6YWNaaGl0dE14SDFOdVJQLzZzTHNIWTdpMTRs?=
 =?utf-8?B?cE9WQWZwMFRTV0NHeXFzMStRV0V6NHhUS1ZzQmF6SWpnZGs4Z1hZVTV6QkFI?=
 =?utf-8?B?enMyRzJtYmM0cHVDVExIaGhqK2FVL29XeitSSXlSaUJBTGRXVUgrTDdVMHVJ?=
 =?utf-8?B?N01sclJwNSt2dXhEMnhBWHdOUEl1cjBzSWlpeXRISFI3MDcwWDNMSFFIS2Ey?=
 =?utf-8?B?UURlNEx0Sld0OHBheXNOaFAwdmRpMG12ekw2ZERyY2NRbFZxOFRLVWxpd242?=
 =?utf-8?B?MHRaYitWeUFKdzZmT3o5TnphRGhVTTBETG9GZitZWll1SlRZTjRlOGplcERP?=
 =?utf-8?B?QlJub1M1VFV4NGpHdFBndjc2SVQyaUZTZm9yMTA5eXo3Q1RsVm82K1dVRWM2?=
 =?utf-8?B?VTdCaWVXazVkSDF6TStTQ1c5d016L3Y5K0tIWlEvWThmc1M0VW1zVkQ2VGNV?=
 =?utf-8?B?Yk42U1prQk9YL0dOeWo2VTI2SVpwVjVKblpubEZJUkYzVjEwc3VlUEhENWNq?=
 =?utf-8?B?ZnZjVWwvU3FWQW9YbkdyTTNqd1J1bG5YTWJZRHkvUjIvVXVrSmNEN0ZWb2N3?=
 =?utf-8?B?bXlHWUhmcnM2dkpEWU1EZnp4ZHhWWEZGZUxlMDZ6U1l1VjJxR01hQVJuMDUz?=
 =?utf-8?B?TCtHaTgvT01GMjZoR2VsM3NDU2tpK1c2b2hTYjlieXd2SU9ubTIycHQ2U3Bq?=
 =?utf-8?B?Q2hkUmd4Y0lNbEZKOVJRU0JnMk1CaHJ4M3Y0TFl4MkpHSWZQaXZzUTE3OFFD?=
 =?utf-8?B?VXp4bmxMeUJOdUtRRUpMYlk5bmp6cXZkcS9BZHRodGxUR05wWEVrMDJXbC96?=
 =?utf-8?B?NXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 74d058ce-75a6-4d6a-559a-08ddef23b793
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB8118.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 22:04:44.1875
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Bsz44khtpkOzg1o2Ipb9XwA7ByHiz4zBmk4zV8h8ZlLIybjZBVtsoMM4ZwlNyFzt9zS+faMKC5epGU4kgOCtRTdsmBDZAia2fM4dhT+EOQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6264
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> From: Yushan Wang <wangyushan12@huawei.com>
> 
> Hydra Home Agent is a device used to maintain cache coherency. Add support
> of explicit cache maintenance operations for it.
> 
> Memory resource of HHA conflicts with that of HHA PMU. A workaround is
> implemented here by replacing devm_ioremap_resource() to devm_ioremap() to
> workaround the resource conflict check.
> 
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> Co-developed-by: Yicong Yang <yangyicong@hisilicon.com>
> Signed-off-by: Yushan Wang <wangyushan12@huawei.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
[..]
> +static int hisi_soc_hha_probe(struct platform_device *pdev)
> +{
> +	struct hisi_soc_hha *soc_hha;
> +	struct resource *mem;
> +	int ret;
> +
> +	soc_hha = cache_coherency_device_alloc(&hha_ops, struct hisi_soc_hha,
> +					       ccd);
> +	if (!soc_hha)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, soc_hha);
> +
> +	mutex_init(&soc_hha->lock);
> +
> +	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!mem)
> +		return -ENODEV;
> +
> +	/*
> +	 * HHA cache driver share the same register region with HHA uncore PMU
> +	 * driver in hardware's perspective, none of them should reserve the
> +	 * resource to itself only.  Here exclusive access verification is
> +	 * avoided by calling devm_ioremap instead of devm_ioremap_resource to
> +	 * allow both drivers to exist at the same time.
> +	 */
> +	soc_hha->base = ioremap(mem->start, resource_size(mem));
> +	if (IS_ERR_OR_NULL(soc_hha->base)) {
> +		ret = dev_err_probe(&pdev->dev, PTR_ERR(soc_hha->base),
> +				"failed to remap io memory");
> +		goto err_free_ccd;
> +	}
> +
> +	ret = cache_coherency_device_register(&soc_hha->ccd);
> +	if (ret)
> +		goto err_iounmap;
> +
> +	return 0;
> +
> +err_iounmap:
> +	iounmap(soc_hha->base);
> +err_free_ccd:
> +	cache_coherency_device_free(&soc_hha->ccd);

I understand that this scheme works because ccd is the first member and
that is forced at alloc the same way fwctl does it. However, fwctl hides
confusing code like this behind put_device() in the free path. So I would
say if you want to borrow the "_alloc(ops, drv_struct, member)" approach do
also hide the "offsetof(drv_struct, member) == 0" in the object release
path and not have eye-popping code like:

    cache_coherency_device_free(&soc_hha->ccd)

...that throws away the allocation side cleverness into a cloud of reader
confusion. Either make this an actual "device" or otherwise have a kref.

