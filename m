Return-Path: <linux-arch+bounces-7349-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E3E97B67D
	for <lists+linux-arch@lfdr.de>; Wed, 18 Sep 2024 02:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18EF8286774
	for <lists+linux-arch@lfdr.de>; Wed, 18 Sep 2024 00:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341214C8C;
	Wed, 18 Sep 2024 00:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PWRa//Uy"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0153D69;
	Wed, 18 Sep 2024 00:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726620368; cv=fail; b=ln7yAG4fFm3F9DYVs+wNq6XplzsXUHMWVNTTFvXN3Sh0QPNoSMjPtrR2zqQQyQRpWaJbywOQ3Pm6X4SpRG0N716wzB3lar1BVa3if3Thln4hCvzkY+Uo/spVycENscOUIpxcVH2BnBshnk+CE4FW1ZYTI+yh6yQooGKr/MUjPrg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726620368; c=relaxed/simple;
	bh=kR6iYrzbboSys7UqdISziTRJjXNzJ8FTPgVHziYBHeQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ad8oCc8JuALtlbkOVM8OX2VBl0Q4e6lfsJJlkYIewtSYMPLU+ZLcImbkt6crgzXG1vca6aXFAZgwuiOGEE01yUuSMG3haZYsM/iU1+1t6A4aQCHOhfopDe9gGG5FagTIKLurtP8r9xI45zQmwps70ZfPn4vduUqhi9KImDxon5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PWRa//Uy; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726620366; x=1758156366;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=kR6iYrzbboSys7UqdISziTRJjXNzJ8FTPgVHziYBHeQ=;
  b=PWRa//UyGXKhDzQ2aYDC7BQqq86/ZEHEocu7ryWnMLCi1liZFJklU/IZ
   rODvMbk62KDCo/Rh72FAuw987EYp8RVIKKXcFS6jRhjjej3bQUli8MwXh
   D8Annd99MMAB0XzS6dBhrRpyRkWq99y7RbWmCUvYZ0WsaOh50PC+2xuiR
   XCUi2N8GgnZ/q1vGZVkDOu+3+TxTGaKAQ6iOZvcUQLDCGQfX0PIWrcx6Q
   JcxZieYoHjXErB0jADwV81zbwzW2XaLyZ6wR4wLvlpDginVRqa4rsQdUp
   b47dBFmjKM17zhNw8NBR5HzQDqh/wJaySEgmr/cUr8W9AqxRjSkUPnEkO
   Q==;
X-CSE-ConnectionGUID: eAHuidnFQAqDyCQsmHFpjw==
X-CSE-MsgGUID: 9FkktMbFSLeDan3FeGIE6A==
X-IronPort-AV: E=McAfee;i="6700,10204,11198"; a="28417548"
X-IronPort-AV: E=Sophos;i="6.10,235,1719903600"; 
   d="scan'208";a="28417548"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2024 17:46:05 -0700
X-CSE-ConnectionGUID: i/7qJ78/RL6tpVOG76IiqQ==
X-CSE-MsgGUID: Nar5fEvtTEuHx0RLB1UHoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,235,1719903600"; 
   d="scan'208";a="100054591"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Sep 2024 17:46:05 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 17 Sep 2024 17:46:04 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 17 Sep 2024 17:46:04 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 17 Sep 2024 17:46:04 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 17 Sep 2024 17:46:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L5EM4bhwW8u8DiunSVtgjgFjTNuFKZAnFr6OHa3kUR0cd5Suti2LEDYT6PcyRo56UX6g2vN9xspipDc+6WxGbhIqu+cyaOw5A2/vYMqkr0/FuJTEBPKp6gn4HV37BdSHAw6lZmzvXAsMOVusEMXQjAykIvEG03hfRetNoZfon8e4X6bZT0bL5Q4zq5336YhBBbP4lDo5QSm3IdQ0tKks1LRM7zRrAL2ZX7feY7Yv5L/cojxeQTx7Tsr5kBIcZ4Ra6AsXEEhCCebUWzEoRRwXoWWTtpPngfOwJzWGVvw2hXwDHB6nyTWDn/DqxMRf6bk2XXeG2rT2tFEVKiXh7AgATA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kR6iYrzbboSys7UqdISziTRJjXNzJ8FTPgVHziYBHeQ=;
 b=rO5bQyccdeU2fnLmJGtNokaLm5uZYoHJ2gykjzPyMUQm4fSYgpJO8aNTqRSndtg17uGgMyCisqZmii5kLvIvPLmO3qBX93+xNgtNpoPKtHt7Hi8b2BP1aHeauNgrdxSFDA0GKHKSkkhapcAUQKfjZkde9wVCVdjO1frBM2/qbCNNYLAZB0G3DWmqpqMzQ8RbdS9H84ir/jdZtSGZuK+yoIeblKH4NNBUHhWsk9hED2bGYM4fUK3qnWJkKrXbTOJUlBVXg2BkSO+oBC2O9emOTLz/CXqLjSszeDjlNxKekmLExpqIJCu7ikXYtxRMTJI3ZW8avWtFx1aD+cdNnjov0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BYAPR11MB2854.namprd11.prod.outlook.com (2603:10b6:a02:c9::12)
 by PH8PR11MB7120.namprd11.prod.outlook.com (2603:10b6:510:214::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.22; Wed, 18 Sep
 2024 00:45:56 +0000
Received: from BYAPR11MB2854.namprd11.prod.outlook.com
 ([fe80::8a98:4745:7147:ed42]) by BYAPR11MB2854.namprd11.prod.outlook.com
 ([fe80::8a98:4745:7147:ed42%5]) with mapi id 15.20.7962.022; Wed, 18 Sep 2024
 00:45:56 +0000
From: "Vivi, Rodrigo" <rodrigo.vivi@intel.com>
To: "cl@gentwo.org" <cl@gentwo.org>, "tursulin@ursulin.net"
	<tursulin@ursulin.net>, "Nikula, Jani" <jani.nikula@intel.com>, "Shyti, Andi"
	<andi.shyti@intel.com>, "Wilson, Chris P" <chris.p.wilson@intel.com>, "Brost,
 Matthew" <matthew.brost@intel.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "will@kernel.org" <will@kernel.org>, "Lahtinen, Joonas"
	<joonas.lahtinen@intel.com>
CC: lkp <lkp@intel.com>, "oe-kbuild-all@lists.linux.dev"
	<oe-kbuild-all@lists.linux.dev>, "intel-gfx@lists.freedesktop.org"
	<intel-gfx@lists.freedesktop.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"peterz@infradead.org" <peterz@infradead.org>, "mingo@redhat.com"
	<mingo@redhat.com>, "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
	"longman@redhat.com" <longman@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devnull+cl.gentwo.org@kernel.org"
	<devnull+cl.gentwo.org@kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>, "jani.nikula@linux.intel.com"
	<jani.nikula@linux.intel.com>
Subject: Re: [PATCH v3] Avoid memory barrier in read_seqcount() through load
 acquire
Thread-Topic: [PATCH v3] Avoid memory barrier in read_seqcount() through load
 acquire
Thread-Index: AQHbCPfSbMHvUgFAeEOTikxQIve9sLJctkwA
Date: Wed, 18 Sep 2024 00:45:56 +0000
Message-ID: <38ef8fac250e9e2591df8e949d5638e5c4abf2ad.camel@intel.com>
References: <20240912-seq_optimize-v3-1-8ee25e04dffa@gentwo.org>
	 <202409132135.ki3Mp5EA-lkp@intel.com>
	 <766fe92a-13da-f299-0ecf-f8a477d58a79@gentwo.org>
	 <20240917073703.GB27290@willie-the-truck> <87r09i1ou6.ffs@tglx>
In-Reply-To: <87r09i1ou6.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.4 (3.52.4-1.fc40) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR11MB2854:EE_|PH8PR11MB7120:EE_
x-ms-office365-filtering-correlation-id: 62cd10f3-0808-4619-cb14-08dcd77b41c6
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018|921020;
x-microsoft-antispam-message-info: =?utf-8?B?alFyYythSjVyQzNOSjRkUUcrN2ZSM0tGZGpnSUFMRmZ1VFhPZjlFNk9VQTgy?=
 =?utf-8?B?U2h1d2R5Zi9XWVZJQmNvZ29wa0RmRUFPV0RudFgwckJ1WGExckJGSjk1SjUv?=
 =?utf-8?B?aGZNbERFekpLM0N4eGwzYk15dmpGaVcvZDFiR3R6ZXhuWitFNTZZY1FEV3Jm?=
 =?utf-8?B?L2xoYk4yZEhaOWVBV0hBREdCN2xaaFluYjZ1VzNYbVN2VFpwN1ltSnRzTG1W?=
 =?utf-8?B?MDkzMENjc2hSaFd6b3BhM0hHWGlGdVFCaUxVZ0V0b0MrOGdwNkl0cjhRQUdI?=
 =?utf-8?B?OC9vMjVvamFFV1Y5NFE0ZzE5emw0OGhQVnZZcHJCK2xFYzgwNkpOQmU5TFV2?=
 =?utf-8?B?TVBBbWo3aE9tZFAvdlhhMjlHdlR6eVpKMmZQdXdlbFZMODQrL0xrSmQ5VW8w?=
 =?utf-8?B?S1lJMEUyYjFmWmdhZnQyeEI4Q3REZFlzNU8rZGNtSjk0L3dNdTNGZno5Z3hz?=
 =?utf-8?B?SVRaNW85dkl5MkdLK3BMdHBNL1pJSzhIUE5pVmFPZW0wSEllY2FVRmFGc2VQ?=
 =?utf-8?B?eG0wNlZwbWtmT0VudUJNalNvSW8rc3Q1blE5OTdreTJuN3NQbmVWeEFnd05D?=
 =?utf-8?B?Z3FOK3d5cEQzT01nQk9MRTZ6amhBY20rc0xsQjNtR3B1cXZzZnRFYjhSWDA4?=
 =?utf-8?B?NERzT051Wnk4NnpQR2FwY1BydFV0R3dzeXNjQ043YXNKN3gvRkIraTYyMUVX?=
 =?utf-8?B?OHpVUDA2eTByZ0Y2anN0Q0NNLzBJdTNvclA4Mm4reEVLYkNYTEZhS2ovVWhR?=
 =?utf-8?B?YzBwMmwwK2EydDJuTnRrS0dJUi9YT0RzYjUrRmQ4UXlwRXg0RlhNNjREenpo?=
 =?utf-8?B?UWc1a0p3SUs0V1BWN2VZLzlhYllXdStENmZEWVlHa3MwUSt1VVBoNTdjVk9w?=
 =?utf-8?B?QWhSZjlZMHFFY1pGUVdVbC9QUW9GNkdZeEtyaDl1VExxbzk3WlA5UyswSlZt?=
 =?utf-8?B?bHFTOWN0Wm5Qdzl6UmZFUXRPcG9uNENQK250VnlGOGI5NitDL0VYeTJJazB6?=
 =?utf-8?B?eEVPbHFJWGwrTitwWFRvTVN4dk53KytvKytDU0FLNFFmNXBpazNKeVhDTi9O?=
 =?utf-8?B?LzJHUEsxelEvNjgvckVoYXkxRmJLOFBjSENTZmttRVJDVU9jbmZrc1VOZUVz?=
 =?utf-8?B?eUptTmxZcDdQZEFkeU1SQVI4VkJEUnJ4TDhtMEpjTyswYXRmRkFTcE5HcGJn?=
 =?utf-8?B?YW5qb0phUmhDMjJlUG5rMmJTSTlRekhmdTFUdUVmKy9RQ0dhYStReUVsTTJL?=
 =?utf-8?B?VEtrQnh5UUNFc0x4dllOOWFvN21CWU5EZkl1cEk2NFM5VkViRUlJWGZoOEFT?=
 =?utf-8?B?bVQrM1l6aG1FYWthUmFkNEpXWmxtTEpKSVdwcURIdWIvSWdyQVlYOTlNSlB3?=
 =?utf-8?B?RmJuZmJMNTR5QUx2d3hzemNyL3FqSTJpT2tSaWtCTnlaTDNCVjFkWXdPbDEw?=
 =?utf-8?B?NDVEU3c4SjM0djhQdEd3NVpRQkJacjhKTEVBemh0T001eHhkVVk4b0NheDFz?=
 =?utf-8?B?T2w0TXBsdUI1RnFQbDd0UFQvYjUzZTRIL1Y3bjFSbzRWSkFIZDJXZytULzRV?=
 =?utf-8?B?QnpIRWJXY3hLUHdOSGRnVlgzeEdHNE1sb2dFTGxBalQ1MENYTm9tT2NuWllH?=
 =?utf-8?B?Z2hxeFA1MXJudXIyb2pYRHVOeXYzbFNJR2wxd1NVMTVRZ0w3YkxpQWFGRXpj?=
 =?utf-8?B?aTR3S0NZNyt6T3FmczJTL0NCRUJ5VkFVQ1hLVkhRYWRwSmg4VEtvbENKLzht?=
 =?utf-8?B?ZThSZ0crcVlURSsxeXZCdXFCa010cTFjM0dWY05JSjdBNmp5TElMeGRGSlVp?=
 =?utf-8?B?TjhnZXI1Sm1sU0VLbFJlUFVtbHlwblV5aFRCcjRKRDFSeHJDSDc5WUJDQ2xi?=
 =?utf-8?B?YjcwL3UxNWlGY2Fybmp2Vlh6OFBEejZZTWN5di9kWFFSTXNJckUxZVBDaVpr?=
 =?utf-8?Q?igOkU6GjFBk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2854.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OGxTQlJDVXZKSGtMNkxxU3N1YTNVSytKMnE5TUpMcEdNdE9zSlBaRlNkblBN?=
 =?utf-8?B?WGRBN0FadGJIbktGTElMVkhlWnV2MFZoUVh4WFQ4czVtQ1hENHZmajhxbXUv?=
 =?utf-8?B?ZS9BTThRY2hIb0hCb2p4djhtMUN0TDF3U1VMQXVXbnNqdTZPQ2k1L2RuNHVs?=
 =?utf-8?B?a21hUVU5WG96VmZoYXZDUkxTMWZLajJOcGJpNmRjT3dzMVRiTndGMTh5UFcw?=
 =?utf-8?B?VmR5QjR4Vm1QcEhGQUMvZDNiRGdwVFJWUzVwZmdQMkVuWlZueG1vRUlzR0ZT?=
 =?utf-8?B?Q1M1ZVJXR1Q3cncvTmhjeG5kWFRZRlNJNEFzOFlxL3lNeE9pbXR4cHZxTDBZ?=
 =?utf-8?B?UW9Ec1lqbGVydWJTbWpURGhua3R3WXNTdi9mTTJMRmMwV0NZcFBjODlkLzBz?=
 =?utf-8?B?Q1kzRkdWV04vOFEybEJnNGlYaGQyV2NzQlNTR1V0alNQdEpscmFBZzVPUGRS?=
 =?utf-8?B?NFA5TUlRVm53S0hpdVZxQ3NseklrdHdjTzZuMkdDbXBiNE80UkxYL29BNU9s?=
 =?utf-8?B?RXdBRkpuTHBrUzA0QmJwak9oQ2lSak5ZRDFHenA4SG9jck81VlNPVWxoeDBy?=
 =?utf-8?B?bDI5eXJBUjNuTnl6K2pqaldXS1R1TkE1cUljLy8yU05TNE4yN2dZd2xWSi9P?=
 =?utf-8?B?RUpkOFlUTUJZS0R4dUwvNHRhbmplNVFSZitqbE9oM0YzU211ZHpnZThpUVJN?=
 =?utf-8?B?NFlHdlE4Vy9kS0hkTWNCcUcrM2pDcDM3YXBRMEE0eHFRbWgrVzYrVnBVRzB4?=
 =?utf-8?B?OFM1TG1raUpxV0xCOWVGWFlVeVFlVnQ2a0l5dVExQ2hEdmNZTWVIdHRGRkIr?=
 =?utf-8?B?TTFwRzZEaWNnNFRLNDFENjhBUEtadWhYTXJrODcxbUFLZWpQR0gxYmw1RnBE?=
 =?utf-8?B?R0w0ZUExSnNvb0w5YmRWZG1Da20xU0xlT3pwVXk5NG5qb1NTTDVMZDROLzQz?=
 =?utf-8?B?V2hDY3NXM0sraTYwbGxxWlQ5Q01JWFNlcWt1K29YcFFWYjU3ajU5OVNldTZB?=
 =?utf-8?B?NG5KMkJWUllVSklDQ05QajJFcjZFRzVrS3VYTTdxZFBZRm1LVVNtd0ovVmZy?=
 =?utf-8?B?QUlQbjlnTnlxMXA3c0sxdldRRkgxaFNVVVYyQ0c5RURZUXZDd1JGOXhsbFNH?=
 =?utf-8?B?TGQ3RXQyTS9MaU5BYWM4MGY4MWZBYURRcUFvZzNyVlgwTGdFQkdqYXFaNHFa?=
 =?utf-8?B?ME1SWVJweGFicW0zQ3ArYWNOdkhsZlBmUEVHaVFCbkUzL0tUcjN4YXVOdWxQ?=
 =?utf-8?B?dy9rdmhHV0FXY1UxZkt4VTdNUmF5NlZNME41MjBMcjAzaUZ5TThWQWFSenAw?=
 =?utf-8?B?Um5hd09ON1BVOHQrQTFMcUE2ZldGMjlnNEVYc0E3VjRxbnZnWUxibzRUVnRQ?=
 =?utf-8?B?OVk1ZTQ3akJKbHNVMUNxdDBucnNCcVUvdUt2RkF2SG1ISG9Temk1NE5Xd0RV?=
 =?utf-8?B?NHhsbjI5aU01dlJtRVNPc29wVE1ETzFPL0VxMlhFc3cxZzdFRVEvL3Z5OFli?=
 =?utf-8?B?Q25zRlR2TldzczRTdWswblNCeXhjREdKZUhaUHQ4bVYxNnpGNzFaV29sYTlk?=
 =?utf-8?B?Q2JOVnNrdlJnN29GVzJFcEFVWTltQndjTGZDbXlMbmxNWVNaQXlSVk9HVFBX?=
 =?utf-8?B?TEtUeklvbnRNUGdLbTVQM0ZlcGovQmlyOGh5QXVaK3Fja1RGcUlINmpRUFZ1?=
 =?utf-8?B?MWF6WjByOUZqL01iVFNjR2pVdld6YUZXVkozbVp4QXFYVHpCd3krSVphdGND?=
 =?utf-8?B?b1JvRFVaaDdYTXlSU1RYYWRveThFcWtrd2JDVU5ZenNoQ1lMWUQvVG9jUUl1?=
 =?utf-8?B?MDFrZ2VrSytsNVU1dnp2OVFQUVJjcGk2a0J1ZlhHR1FXQitpcUMweVNtbSsz?=
 =?utf-8?B?TVN0cmgwRjhnU01IazhMUmNCSWR3NCtUTUdkMTl0SHZFdlJPNmo3b3dhY3pv?=
 =?utf-8?B?bW9VQjlyQ09hd1FjL2Z0bVRxQzNQQVRid1FpMWJzcWt2cE11aUdYSGJMemd0?=
 =?utf-8?B?akk3dXo4ZnRTVXRqcEZ6Y1FRUkVaaDE3eHUrd25ncm5ncS9hV0hkSFBVVVo3?=
 =?utf-8?B?c3hzK0V5VFhuQlROUDZKM0E3dnMvMlNzRWg0V2wyQVd6NHB6bjE5MFo3VTFp?=
 =?utf-8?B?Q0w4NjAyYlk3c0FJRDVtMmV6QWRqOWYxVnNyN2ZZTnhaNmxzRVhBY1VORmVL?=
 =?utf-8?B?emc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F3FEC2890724C441A161C7932FEB01EA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2854.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62cd10f3-0808-4619-cb14-08dcd77b41c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2024 00:45:56.3881
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EbORzNOIjf2A8Rxa6cz2Krzb0zlkfZLPEHNwXweLD7Fxzo2jayYxBQmWoq2soa2bmNDDyemYVUzlwYWQawgsIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7120
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI0LTA5LTE3IGF0IDEzOjUwICswMjAwLCBUaG9tYXMgR2xlaXhuZXIgd3JvdGU6
DQo+IENjKyBpOTE1IHBlb3BsZQ0KPiANCj4gT24gVHVlLCBTZXAgMTcgMjAyNCBhdCAwODozNywg
V2lsbCBEZWFjb24gd3JvdGU6DQo+ID4gT24gTW9uLCBTZXAgMTYsIDIwMjQgYXQgMTA6NTI6MThB
TSAtMDcwMCwgQ2hyaXN0b3BoIExhbWV0ZXINCj4gPiAoQW1wZXJlKSB3cm90ZToNCj4gPiA+IE9u
IEZyaSwgMTMgU2VwIDIwMjQsIGtlcm5lbCB0ZXN0IHJvYm90IHdyb3RlOg0KPiA+ID4gDQo+ID4g
PiA+ID4gPiBkcml2ZXJzL2dwdS9kcm0vaTkxNS9ndC9pbnRlbF90bGIuaDoyMTo0NzogZXJyb3I6
IG1hY3JvDQo+ID4gPiA+ID4gPiAic2VxcHJvcF9zZXF1ZW5jZSIgcmVxdWlyZXMgMiBhcmd1bWVu
dHMsIGJ1dCBvbmx5IDEgZ2l2ZW4NCj4gPiA+IA0KPiA+ID4gRnJvbSAxNWQ4NmJjOTU4OWYxNjk0
N2M1ZmIwZjM0ZDI5NDdlYWNkNDhmODUzIE1vbiBTZXAgMTcgMDA6MDA6MDANCj4gPiA+IDIwMDEN
Cj4gPiA+IEZyb206IENocmlzdG9waCBMYW1ldGVyIDxjbEBnZW50d28ub3JnPg0KPiA+ID4gRGF0
ZTogTW9uLCAxNiBTZXAgMjAyNCAxMDo0NDoxNiAtMDcwMA0KPiA+ID4gU3ViamVjdDogW1BBVENI
XSBVcGRhdGUgSW50ZWwgRFJNIHVzZSBvZiBzZXFwcm9wX3NlcXVlbmNlDQo+ID4gPiANCj4gPiA+
IE9uZSBvZiBJbnRlbHMgZHJpdmVycyB1c2VzIHNlcXByb3Bfc2VxdWVuY2UoKSBmb3IgaXRzIHRs
Yg0KPiA+ID4gc2VxdWVuY2luZy4NCj4gPiA+IFdlIGFkZGVkIGEgcGFyYW1ldGVyIHNvIHRoYXQg
d2UgY2FuIHVzZSBhY3F1aXJlLiBJdHMgcHJldHR5IHNhZmUNCj4gPiA+IHRvDQo+ID4gPiBhc3N1
bWUgdGhhdCB0aGlzIHdpbGwgd29yayB3aXRob3V0IGFjcXVpcmUuDQo+ID4gPiANCj4gPiA+IFNp
Z25lZC1vZmYtYnk6IENocmlzdG9waCBMYW1ldGVyIDxjbEBsaW51eC5jb20+DQo+ID4gPiAtLS0N
Cj4gPiA+IMKgZHJpdmVycy9ncHUvZHJtL2k5MTUvZ3QvaW50ZWxfdGxiLmggfCAyICstDQo+ID4g
PiDCoDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiA+ID4g
DQo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2k5MTUvZ3QvaW50ZWxfdGxiLmgN
Cj4gPiA+IGIvZHJpdmVycy9ncHUvZHJtL2k5MTUvZ3QvaW50ZWxfdGxiLmgNCj4gPiA+IGluZGV4
IDMzNzMyN2FmOTJhYy4uODE5OThjNGNkNGZiIDEwMDY0NA0KPiA+ID4gLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2k5MTUvZ3QvaW50ZWxfdGxiLmgNCj4gPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9p
OTE1L2d0L2ludGVsX3RsYi5oDQo+ID4gPiBAQCAtMTgsNyArMTgsNyBAQCB2b2lkIGludGVsX2d0
X2ZpbmlfdGxiKHN0cnVjdCBpbnRlbF9ndCAqZ3QpOw0KPiA+ID4gDQo+ID4gPiDCoHN0YXRpYyBp
bmxpbmUgdTMyIGludGVsX2d0X3RsYl9zZXFubyhjb25zdCBzdHJ1Y3QgaW50ZWxfZ3QgKmd0KQ0K
PiA+ID4gwqB7DQo+ID4gPiAtCXJldHVybiBzZXFwcm9wX3NlcXVlbmNlKCZndC0+dGxiLnNlcW5v
KTsNCj4gPiA+ICsJcmV0dXJuIHNlcXByb3Bfc2VxdWVuY2UoJmd0LT50bGIuc2Vxbm8sIGZhbHNl
KTsNCj4gPiA+IMKgfQ0KPiA+IA0KPiA+IFlpa2VzLCB3aHkgaXMgdGhlIGRyaXZlciB1c2luZyB0
aGUgc2VxbG9jayBpbnRlcm5hbHMgaGVyZT8gSXQncyBhDQo+ID4gYml0IG9mDQo+ID4gYSBwaXR5
LCBhcyBhIHF1aWNrIGdyZXAgc3VnZ2VzdCB0aGF0IHRoaXMgaXMgdGhlIF9vbmx5XyB1c2VyIG9m
DQo+ID4gJ3NlcWNvdW50X211dGV4X3QnLCB5ZXQgaXQncyBzdGlsbCBoYXZpbmcgdG8gd29yayBh
cm91bmQgdGhlIEFQSS4NCj4gDQo+IFdoeSB0aGUgaGVsbCBjYW4ndCBpOTE1IHVzZSB0aGUgcHJv
cGVyIGludGVyZmFjZXMgYW5kIGhhcyB0byBieXBhc3MNCj4gdGhlDQo+IGNvcmUgY29kZT8gSnVz
dCBiZWNhdXNlIEMgYWxsb3dzIHRoYXQgZG9lcyBub3QgbWFrZSBpdCBjb3JyZWN0Lg0KPiANCj4g
Q2FuIHRoZSBpOTE1IHBlb3BsZSBwbGVhc2UgcmVtb3ZlIHRoaXMgYmxhdGFudCB2aW9sYXRpb24g
b2YgbGF5ZXJpbmc/DQoNClllYXAsIHdlIGdvdHRhIHJlbW92ZSB0aGlzLiBKdXN0IG5lZWQgdG8g
YmUgY2FyZWZ1bCBvbiB0aGlzIFRMQg0KaW52YWxpZGF0aW9uIGNvZGUgd2l0aG91dCBjYXVzaW5n
IHNvbWUgZnVubnkgZGVhZGxvY2tzLi4uDQoNCj4gDQo+IFRoYW5rcywNCj4gDQo+IMKgwqDCoMKg
wqDCoMKgIHRnbHgNCj4gDQoNCg==

