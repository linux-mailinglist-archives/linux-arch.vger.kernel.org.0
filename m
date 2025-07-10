Return-Path: <linux-arch+bounces-12642-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C020CB00BA4
	for <lists+linux-arch@lfdr.de>; Thu, 10 Jul 2025 20:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 640DA1CA728D
	for <lists+linux-arch@lfdr.de>; Thu, 10 Jul 2025 18:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87B12FCFCD;
	Thu, 10 Jul 2025 18:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cRDQryum"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA3A18E25;
	Thu, 10 Jul 2025 18:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752173175; cv=fail; b=MhAJrE9tfdtWlOPIh26t8HcbHeBNOne4CUws22XNKChrvGYTmi8WLUyrWuAQUPm88K3yU06/o3KMGIbeB2Kzrvzx7dCIsTqKxP2WyYORHemchjCEgIRKQYlQt3t1+jCf8HIXUxMt7dBdo6iIAx2U0/SBM7U2CVMGt1S809S6JS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752173175; c=relaxed/simple;
	bh=lmdNDX/TGoB+G3OxSJnrJHpjkpet+CzXcDSpD9ECtEM=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=OMCdb1si+1lOaiR8SY8lOXC0HaohsDf8IIScF4vNNisG/3ZCNHxNe1TgLov0LdDLGiZB+kWu0fe14IgkcYJ8/3sUiCYERfwvuC1aOA83/p3rJ+iJbKmZwpbu8yeqQ4pAu8Sm8zOMWefm4eDNyqn19gFVV2roqagIFwsHEhS2dtc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cRDQryum; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752173173; x=1783709173;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=lmdNDX/TGoB+G3OxSJnrJHpjkpet+CzXcDSpD9ECtEM=;
  b=cRDQryumYJlGOE7M/ihUlpBgG1HS4LZH4TqJ4KaqPK7cAhGB1q+in5It
   iMFVu2s2ik80qGQGDW8NYi90FJO2BWFI5n6jtW1CR48chnttSSJb0Mx0f
   Ao1c2UsNh70xqsK2WLndfpyk35w6qCAMjICIfMXtE4/zEskQG84wL2Vef
   OvkeG2827RDemMoSTJyVR9TlIx+JSYhOzOcQx/QcAQiJLxA7CiRnHb4xx
   e43rhtWDEzServ3LnQqKGBHZqmMmnQ9uukgFK2jo52qBadn02WcAi8jfX
   N/q6KyYdQRA/bBYXU3MceWzj9s5O5q1hM/863qbg897MCvnLoY19HHUUq
   Q==;
X-CSE-ConnectionGUID: p75aqZFPRh2UZ5zjbYDq/Q==
X-CSE-MsgGUID: HwGgAH80StegNB5sxMvPrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="54439086"
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="scan'208";a="54439086"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 11:46:12 -0700
X-CSE-ConnectionGUID: zxDU7YaORmO6IKRL3N/+Gg==
X-CSE-MsgGUID: 8gbzyv2JTOeWgymzX7K29g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="scan'208";a="156650290"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 11:46:13 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 10 Jul 2025 11:46:12 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 10 Jul 2025 11:46:12 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (40.107.102.79)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 10 Jul 2025 11:46:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tzxLBXCJrieIOfQSIvrZe0V6EWptp9wuoKlVqRfusY8dZTi9Et3HfSdUAtf/r+TK4sgWHLhE0RyNJ1i5M7nJvZo6+4LL6Hb5OscXLFiPKOyUZPUwvMGqAee/9vefgDmaysjJ7e7urlrlTWbH33Kt7KTZitwHeQKcfmhG0p/Qnt3U2bfrhi3DoBLekIsel12+vbDLyVrHn1v+nC1ZZmNXGRH+EUZnjrNIhGVgE8u6pvj9wjRD5VQyKbiMEn/azNmOrE4v2gs3VcUYlb1uqAWwIh8Q/YuipIqb5sjQTnrAJCV7NvM0+cKfbjSctcPTJx21Sp3gG732xxi0CZwUiP7qMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cqqz4Yj7pTTSPxECjQHKhi2z3cR/15eYn/NaFOO+hU8=;
 b=Mbcos1/vRiiJ5gWHeVFhquoYPm2XBktYoDo2+i5PsGOm35cRJ3qVrWrOSB8sx0y3vwHYIjiOAHqU548CghgUpl0mWsBaLhVM6sSmY60c9x8nLySz721P35EM1CgKHvfMg34KIZzTULpKrEboFsfQ7dbb83N18FcC7OCjBG7JleNcOZxTQnO7ob5XEtwk4p1/EZhy3q9JVW22mQO8HT4Ffps9rEuBbVze+TN+09GGZjQPSUaGUQpes2tLWU7nH9wi9pwAoAK/w0mh+Wtq35UnwRyElWw7BeA+C0C08MUT2U4xS3tiCYC86EfwR9VSoZYnnm2LanGZBGdw2cLaLegZDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB7328.namprd11.prod.outlook.com (2603:10b6:8:104::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Thu, 10 Jul
 2025 18:45:42 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8901.024; Thu, 10 Jul 2025
 18:45:41 +0000
From: <dan.j.williams@intel.com>
Date: Thu, 10 Jul 2025 11:45:40 -0700
To: Peter Zijlstra <peterz@infradead.org>, <dan.j.williams@intel.com>
CC: "H. Peter Anvin" <hpa@zytor.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>,
	<james.morse@arm.com>, <linux-cxl@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-acpi@vger.kernel.org>,
	<linux-arch@vger.kernel.org>, <linux-mm@kvack.org>,
	<gregkh@linuxfoundation.org>, Will Deacon <will@kernel.org>, Davidlohr Bueso
	<dave@stgolabs.net>, Yicong Yang <yangyicong@huawei.com>,
	<linuxarm@huawei.com>, Yushan Wang <wangyushan12@huawei.com>, "Lorenzo
 Pieralisi" <lpieralisi@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	"Dave Hansen" <dave.hansen@linux.intel.com>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, <x86@kernel.org>, Andy Lutomirski <luto@kernel.org>
Message-ID: <68700a5428a2f_1d3d1008b@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <20250710105622.GA542000@noisy.programming.kicks-ass.net>
References: <20250624154805.66985-1-Jonathan.Cameron@huawei.com>
 <20250625085204.GC1613200@noisy.programming.kicks-ass.net>
 <FB7122A4-BF5E-4C05-805A-2EE3240286A1@zytor.com>
 <20250625093152.GZ1613376@noisy.programming.kicks-ass.net>
 <686f4e20c57cd_1d3d100b7@dwillia2-xfh.jf.intel.com.notmuch>
 <20250710105622.GA542000@noisy.programming.kicks-ass.net>
Subject: Re: [PATCH v2 0/8] Cache coherency management subsystem
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0188.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::13) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB7328:EE_
X-MS-Office365-Filtering-Correlation-Id: dbe1602d-1261-4302-c014-08ddbfe1f8b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WnV2Rm5saVluSytmVzlobkVweFlUNXNhZ211aTVOaDFZYXdNd244bHRSUlR5?=
 =?utf-8?B?c0VwcEJjS3NFeVZLdy9lMzNBSXF5YnNaeGcwNGUvV1hPVTYyUXk0L29LVHNM?=
 =?utf-8?B?N0NKRnFFWVZaVXNBTnhadWVscEo0VzkrWEw4SldmbzRYeDBOSWtaMFlJd3J2?=
 =?utf-8?B?QTZSRHFBM3BqUjZaVW1KanYvTldWYnNVNEs0MGhoM1E2N05qdDlPWkswd2Nu?=
 =?utf-8?B?aloyd0NKc1NEUnc5OXZNWkRZZmtjSjgreXc3bndMSGRDTGROZDZMZ1BhT0Vs?=
 =?utf-8?B?cGFQWVdWS1ZkZVd2RENBRDN6aVFaVnVxT25uV2VteUFVY3FWM292OFNIc2Ji?=
 =?utf-8?B?d2puRVhHWlBYN3Y3ckVham9QR1JiczN6RFVjVTYrcm01NlFNcm9UOStJRElW?=
 =?utf-8?B?TWpEbWJWZ0NRUjQxNWhYWlZkN1ZxT2NKcndFZVU2cWxjT1RPNDJLVmRMOEk3?=
 =?utf-8?B?NXhodWk5OENGNUJOMkhyL0JEa3pTQVNzOEN1V2hNS1hmSjkyeWQ4VktabDk3?=
 =?utf-8?B?OHN1TzhLUFZMTkdVSElaS0tZRU9ZYm5MdHVWSFBnMHJhYWFSaDErUjVONWFu?=
 =?utf-8?B?NGx0SmR2QmJEM3Evek5nOHFyR1BUa3NxR09tUG1CR05NTFFOZzZFZndXTUlk?=
 =?utf-8?B?R3VSUjArcVptWS9EYS8vNGZuTlQxeFVYYnU5bGg0MXBoWUdHVndJcUpSYW1Y?=
 =?utf-8?B?eDF4SjZUemMydEZzZFpGbXpCSzl2Uk5Nd1Znd1BmekZGOUFLMXE1bFdrNnQr?=
 =?utf-8?B?M0dBZGNQQnpPUkVybWV0TEMySnRlc0VlK1k5cUg2bjcyLzZLMmNxVk5rT0Vs?=
 =?utf-8?B?MCt3N3l4SElkZTZHbm5MMExtS3FZaFJHY21BUm41RXhRalMrb1VUUHNodlor?=
 =?utf-8?B?Y3AxbGI1TEo4UkJkelNPQ2s0cVJIVGUwV09neGFpQnhYUDZWZkF1Uy9kNWt2?=
 =?utf-8?B?TmxvdVF4K282S3Q0dlh5dXVTeHdldm1xVDhad2xtV0NLTEFONDFZTzdrUVU2?=
 =?utf-8?B?M0EzUnNycHdpVGo1SkJ0K2cxQktiRmU3R2I3UU10VEtWUEJaa2xNenBJaGg2?=
 =?utf-8?B?d0d0ZWk5QXF6WG5xMnVqdUtDM1hQZUZKSHpmd285WG12U3lDWDM0OVZGcFRK?=
 =?utf-8?B?L0I5T3NYazJTWEVwNVJIcUtOYWJnRXpUUlpNL3JNNGNyaVZML241M1BBNVB3?=
 =?utf-8?B?bWU3Q3FpenRhZWdJK1pzc2ZRb3lhZldWRUx0MTRSK0lrQVFoVkxHejliek9z?=
 =?utf-8?B?UVZhRVpwV1h6RTl6eGJ4OFV2YWtCd3pkUzh3aXFyK20wdC9CQzRjYmhOTUls?=
 =?utf-8?B?Z2dPWkJNV0ZpWTRocnNHVktHOXd6Nm5VQUZJcDdZQmhjeXdBVzJkMys4QlhN?=
 =?utf-8?B?MW5ER0FpYkxuVnlsUlZxeFdGTEg2cy9BTUdZeG1LWmtyY3FEQnBYQW1qQ1c1?=
 =?utf-8?B?elNtMUhMSWViK0dlLyttZE1OVkJ2YWZFZ1lnOUUyd2xaVnBzOW92YlJ3WUdK?=
 =?utf-8?B?RktZVHpnZFhuT1g5aWVHZ2RYcC9rUVB4VE1tM21zV21BdDNHdGxic3Z2Kzgv?=
 =?utf-8?B?ZGFiRTRqZGh4d215MGgzenRjcFVKTStZUU1BaHpkLzhkWFJNN2xrcEJmUFFW?=
 =?utf-8?B?YU5memIzRlZzVHNZV05GeHU4VTB0YkY0R1N6Sm9IeHZqbGdERlBUUXMvRnha?=
 =?utf-8?B?dmJZSzB1NFFlYVZKU3RrcDNsaFBVbWtTYjJxUmQ5UEN1STFSbkVCdGNGbGRG?=
 =?utf-8?B?MjMyQ1BVS01qSXVsWkk0VkxRZ2tMcWp0TkYyQ3lBclduMXlKYXNNejc2TDBT?=
 =?utf-8?B?S0FGN0Z4SEhSZTNEYlVORys4dStBVWk5blFKU3RQMzdtUE5KOW0va0pYT2JM?=
 =?utf-8?B?YmNvNFNnTXJJS003U2V3NHpqRkNKSDFseEQvQ0FrQ1Zzd2dON0lrb1Q4b09P?=
 =?utf-8?Q?C6A5d53AED8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVJYOTlFKzBLQlZtaVZjTERMNXZRQ2d1Q25RM29iSVdDTUplSEZVT1NrZS84?=
 =?utf-8?B?S3Rpa0hmd0lMRnh2UmtqWDRLRER1WldURkJuRDE0YVRlTVFKcGJSZTlDb2N1?=
 =?utf-8?B?ZTY5L0Y4TDJKcjhyd2QySGIvWkZDVFlGQmpNZ3FUV2JIcno4WE00ZFlaVzhD?=
 =?utf-8?B?NGp6QjdUQlVTN3FESk8yclFybk4zdHJmUHVEaHlRTTVOeVVoajl5WmRieUNl?=
 =?utf-8?B?cGk2cW9TdkFqUUI4UThweXBsM2krS0xYYWU2UXJrV1ZDSkpaWFM2Y3F1Smpu?=
 =?utf-8?B?c3k1aUVNemtmbEJVL2N6Qnl1SkxtRG5wVVVHaHhrd2MrNzhkRnQwc0J4SlhC?=
 =?utf-8?B?K3djTENUSlgzNmN1VTdPOHhlcisrb0NhOUpCTGZrUXhxRkY3OEIzN3M2NWFz?=
 =?utf-8?B?Wi81aXdLNTB2dFdlSmV0Ujl2WnhOR0psQU1uVFp5bXMwTDBTdEV1T0FTT1BU?=
 =?utf-8?B?N0xrMkcxUDRaQ3ozN1JXVWUxWk9jbjhWeG1WSTF1ci9QanNYOTJxSzI3MGtJ?=
 =?utf-8?B?VE50MDFJNG50NXJBbkZYMm5WNFJWeGRLYWF5NERGa25ONUN6MHdHWGxYdDA1?=
 =?utf-8?B?aS9hcG1UanViZkltUXowMWxRWkQzZkdNTVRzYnhTcXgyaTh5VnJRM0FJR1pT?=
 =?utf-8?B?eW9qM25SNGxSdjcxcVdSSnZ1Skc4cjl0UThYMitadzludHNqKzU0R05vakxh?=
 =?utf-8?B?OHlTZ0xBQ2tpNHRlbmZjUlFaMXFFU0xzc1NvWnN6VmhiWFlOSEhoa0V5eXFC?=
 =?utf-8?B?RXBVd1BRanlaUjZjaEV4dzJ3Mm9naEVUeUN6c3JyOE9YMHJKU083dmdFdGov?=
 =?utf-8?B?UUt1SmZ4TFlNTWV5Yndlc0I4OUNIdllmMEJkTjF2dnpMY0h5QzllRThscXRv?=
 =?utf-8?B?UlYzT1R6bkorZVJMUmU5dWQxSCtlb3Zkd21SakdtTitpRGRSekZQUzl3MDNy?=
 =?utf-8?B?WHVlbTA0aXRFck9WdUp0ZG1lRTI5c2VCWkYvd0s1MXdKcmJjWmlJYlZ0ZmYw?=
 =?utf-8?B?SDhnVythRGNiY1dnN2dScXYxeVdzaTdTMU1yV0d3ZnJGN1l3WlE1MjBLVjM2?=
 =?utf-8?B?MFRkNFhOdUJRa0d0OHc1L2wvSEhoOUlaajhlVTVEcWtQbzFBY3pGWjYzWU5k?=
 =?utf-8?B?dGp5TFc3b1FUNG1qUkNWenNVMXM3ZVByRnUxaGF5b3cyRUxLejJ1R3lDTHZI?=
 =?utf-8?B?aC8vV2pwbjAzMjdVSEJOWDV1QWk4eFZDOVFmMkpvVzdJbWJnYzlHcWowTkJl?=
 =?utf-8?B?aXU1emd6aXZhdmJ6M0t5UkE1ZEgyem11RnZhOEoyYkhyK1IvaU5YZ0pSOFFT?=
 =?utf-8?B?QVdpc0ozN2d0dzZPczh4MG8vUG8wL1ppMTRwc1EwaktNbE5nQ2tOdWpveGFN?=
 =?utf-8?B?V3EzU3lBbkpzS1Y4VE1BZks0WDcwMzlCZ3ZlMnZPWGpHNUY5VGE0dkN5cEpX?=
 =?utf-8?B?SHFqaS96dXptbHY5Tm1wUFBVR3E5V1didUdQS0MwM0tkTVJTSW5OZ09uZlpN?=
 =?utf-8?B?cmx3d0ozYjRVWis1aW9vVVRPYWlxejUyRXpKS3NKQzlkQUY4QmUyMVQwdVYw?=
 =?utf-8?B?NDU4cENzVVhMbWRZZWgzRzJockJ2ZHdaNXROODNXYXROTkxXMkx2MEhDbnA0?=
 =?utf-8?B?OGcva2dPb0Q3N3RSdzA3Mk1kS3NOVjRQZWRlQ2VraXdOQjZSN0FtYnlRWnlo?=
 =?utf-8?B?V2syVEJBY3RxNE5XZlJBaU8xN1VjMFBEMFFLSlpjcVJSQ3dYUVhwT1dkUGxw?=
 =?utf-8?B?UkhkNW0rRzBqakhmT1pma1NqVmJMakF0ZUtKRVZ6ZUh6dmV4amdSdlBPb3VH?=
 =?utf-8?B?dytYZGZ0R0dJVUxOUUFHaTlyUWFhRFUxVm42R0t5Vkhjc1RoMWM4U3Q1MTZk?=
 =?utf-8?B?d0VKbTlRU1RqU0VWdGVaQTNORmhFVERXNmtaWnorS2dTUGpUWWJxa2pVZmJZ?=
 =?utf-8?B?VEVuQW4xbWNSSzh4cUhWaW8rd1U2TFdlWlc4Y1VZR0dzYnBtK2Zocnp2MFpW?=
 =?utf-8?B?OHBPZk93RzF6MVpCYVQzblpnUnBPR3FPblVNTm5IdURaVFg0eDVqMHp6c1lI?=
 =?utf-8?B?YXhLR2xkaW0yNXRkYWJ4Ym5EUHMrV2hDcktLeE9aQmpVQjAvRW05cUZkZGtD?=
 =?utf-8?B?dVFlcUhUd0psQlA4VnBnM1RWM0dwUnhTSEtKdlhpam8zRDloTEVzcTlwNEp5?=
 =?utf-8?B?NVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dbe1602d-1261-4302-c014-08ddbfe1f8b9
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 18:45:41.9346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XLBtR0w+z3gsepMXzSqFFuJFM8QQGZHV1AF1izCgCxWCcQACK8ZbHqKaLNOkWfWjGbectFq7kFihBCTIbp5FGUC8AT3KUPaj1ZyD2g7YhUQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7328
X-OriginatorOrg: intel.com

Peter Zijlstra wrote:
> On Wed, Jul 09, 2025 at 10:22:40PM -0700, dan.j.williams@intel.com wrote:
> 
> > "Regular?", no. Something is wrong if you are doing this regularly. In
> > current CXL systems the expectation is to suffer a WBINVD event once per
> > server provisioning event.
> 
> Ok, so how about we strictly track this once, and when it happens more
> than this once, we error out hard?
> 
> > Now, there is a nascent capability called "Dynamic Capacity Devices"
> > (DCD) where the CXL configuration is able to change at runtime with
> > multiple hosts sharing a pool of memory. Each time the physical memory
> > capacity changes, cache management is needed.
> > 
> > For DCD, I think the negative effects of WBINVD are a *useful* stick to
> > move device vendors to stop relying on software to solve this problem.
> > They can implement an existing CXL protocol where the device tells CPUs
> > and other CXL.cache agents to invalidate the physical address ranges
> > that the device owns.
> > 
> > In other words, if WBINVD makes DCD inviable that is a useful outcome
> > because it motivates unburdening Linux long term with this problem.
> 
> Per the above, I suggest we not support this feature *AT*ALL* until an
> alternative to WBINVD is provided.
> 
> > In the near term though, current CXL platforms that do not support
> > device-initiated-invalidate still need coarse cache management for that
> > original infrequent provisioning events. Folks that want to go further
> > and attempt frequent DCD events with WBINVD get to keep all the pieces.
> 
> I would strongly prefer those pieces to include WARNs and or worse.

That is fair. It is not productive for the CXL subsystem to sit back and
hope that people notice the destructive side-effects of wbinvd and hope
that leads to device changes.

This discussion has me reconsidering that yes, it would indeed be better
to clflushopt loop over potentially terabytes on all CPUs. That should
only be suffered rarely for the provisioning case, and for the DCD case
the potential add/remove events should be more manageable.

drm already has drm_clflush_pages() for bulk cache management, CXL
should just align on that approach.

