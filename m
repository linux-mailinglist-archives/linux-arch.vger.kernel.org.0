Return-Path: <linux-arch+bounces-12641-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D6FFB00B83
	for <lists+linux-arch@lfdr.de>; Thu, 10 Jul 2025 20:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 506B11CA5A24
	for <lists+linux-arch@lfdr.de>; Thu, 10 Jul 2025 18:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C7B2FCE13;
	Thu, 10 Jul 2025 18:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YifwonTu"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BD127145D;
	Thu, 10 Jul 2025 18:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752172630; cv=fail; b=mVrWiHB1IEpBFt7l0vPBTncQ/dlgnLpjZjHudD2Lg7K70270alg9s5VAMISKCZ8NT8wQ/V7UMqfiYrRAs+ODd7ETT7sLUwNTZFjgMhSWjL4p7qevGca6iv5VixH2fAGtavCI5qksZW9lBmChdi4gM/HMT4IPFnSZ6zYfmsRMGxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752172630; c=relaxed/simple;
	bh=m+/8Ue+XqeimPrnOG40u+7FyrKXV2XoxvD6PWVZTGjU=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=k6X7jL+iJ33Xd7c0+NjmlHiZlkhLP52Txmjoxu5pQIvTIbsglB95/FYMTsHTsr7/AbaVeZPARfMS4L/bzDX+uyqwtR0z5asbnk3WE6LWcQCXLIyvuUnC8JMenffD8A5rqRkLbYlYYnHSJzQZAQGaqBVqPraAkeCpfSj0SNY9pI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YifwonTu; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752172629; x=1783708629;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=m+/8Ue+XqeimPrnOG40u+7FyrKXV2XoxvD6PWVZTGjU=;
  b=YifwonTuHj9MGkAR13tyjhyfeVKNOCvXAbbHnogSxgrcsAhb3V6bPHrb
   deBxt3P+sw0pJG8dtKgbQ56zQ54TRkaPGZqiITpuP2sCILDX3WSpsfxGA
   S5ZM9iwVtxH2USfUyXByUHr4Of7/6HVkyfEwEf+Ewu1Ok8P4yrwZPp1kw
   Z9TDJcerFnXz0FOSeDHc5lWHltftH+zHawYpZHdwCwea6D04jMIPtF0jT
   Qu3YnXTE09xqLqc2nAUHnq1Ldhg29hmLTCLrLaCsb8F/VBty0wjHY85hM
   CN/FoYPnnA6WkI8T9enR5nm55l+hASum1WoHdH2qRCxKJbOEh2Q6wPJ/b
   w==;
X-CSE-ConnectionGUID: fzJoBzaLRF2QBIBVLovgKQ==
X-CSE-MsgGUID: 3apaCOP2RTCJWRkwhAr7cg==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="57078982"
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="scan'208";a="57078982"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 11:37:08 -0700
X-CSE-ConnectionGUID: /9dF6bRiTsuz4KV9uKaWjw==
X-CSE-MsgGUID: 0XdkRHIMTpebO4r/PMXzPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="scan'208";a="160721075"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 11:37:07 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 10 Jul 2025 11:37:07 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 10 Jul 2025 11:37:07 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.77)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 10 Jul 2025 11:37:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FXqiWoT9lX9k5H3+u6CwWAy5m58YQSfr3lAfyMxrMrzeIgrnGAAu3GmJfpNrYOE8xt7qLqZQedz17LtjYbHJbBYymtUx/w8k9eM4rUAzIpBmLCt0tlafabbBJSz0mjYZYWSxsxUJ/ryCJ3xKi71/fCnbVpDbKsEDEZ8hD9Hj/oGy2BYosUsPMyLx+ksGINK1YdR9W5o2rpBHTGxMuJnpebuUyatc/csX+aOihTAavl3J3yVpcDHBleN1J9hLeqXfE6HSFu5qpB2RzJjZmvMkZdInCmGjX0L7wfpsz+nIM9b8GIW/8Nd8cah07mXfwfdGoDfyDCM5iZ2D174R9Nw7ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/uqwdO6eGB2b1m0dlG7pcwmZPDSDKWP0faJ3GXYrnvw=;
 b=dttlqtlCPwL15uarFlyukYVKr+lx3twCy6vH2IVeAs/ETe0s1elgser10YMPEsV2mdv52GDlsIddcKQP4n6APhPIksR66tpwykFm3p4TtgEiXDXjYPlWig/mbgnxSRZhS8K5ghtvHwWV1MUwu0RWrIMLYcpnHHmCNAwSpraDnN/4QmBedYauS1WUwpWjzUDkCCnFdG26lIcucz0XQjpwc93lBBXlGoH/EwzyvzBWeq+Ub63XpgIQswoo+KUdbwag9cvMgCGiBDp8ylEzDutJvVITQgGzf61gEoLTavkxqOwSkCmWWERBFWy3bN/q4r6PsgdpVcQzpTYeCYyD2ZpaSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CO1PR11MB5108.namprd11.prod.outlook.com (2603:10b6:303:92::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Thu, 10 Jul
 2025 18:36:22 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8901.024; Thu, 10 Jul 2025
 18:36:22 +0000
From: <dan.j.williams@intel.com>
Date: Thu, 10 Jul 2025 11:36:20 -0700
To: Peter Zijlstra <peterz@infradead.org>, <dan.j.williams@intel.com>
CC: Jonathan Cameron <Jonathan.Cameron@huawei.com>, <linuxarm@huawei.com>, "H.
 Peter Anvin" <hpa@zytor.com>, Catalin Marinas <catalin.marinas@arm.com>,
	<james.morse@arm.com>, <linux-cxl@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-acpi@vger.kernel.org>,
	<linux-arch@vger.kernel.org>, <linux-mm@kvack.org>,
	<gregkh@linuxfoundation.org>, Will Deacon <will@kernel.org>, Davidlohr Bueso
	<dave@stgolabs.net>, Yicong Yang <yangyicong@huawei.com>, Yushan Wang
	<wangyushan12@huawei.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, "Mark
 Rutland" <mark.rutland@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, <x86@kernel.org>, Andy Lutomirski
	<luto@kernel.org>
Message-ID: <68700824a2161_1d3d100f4@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <20250710105913.GB542000@noisy.programming.kicks-ass.net>
References: <20250624154805.66985-1-Jonathan.Cameron@huawei.com>
 <20250625085204.GC1613200@noisy.programming.kicks-ass.net>
 <FB7122A4-BF5E-4C05-805A-2EE3240286A1@zytor.com>
 <20250625093152.GZ1613376@noisy.programming.kicks-ass.net>
 <20250625180343.000020de@huawei.com>
 <20250626105530.000010be@huawei.com>
 <686f506020726_1d3d10069@dwillia2-xfh.jf.intel.com.notmuch>
 <20250710105913.GB542000@noisy.programming.kicks-ass.net>
Subject: Re: [PATCH v2 0/8] Cache coherency management subsystem
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0141.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::26) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CO1PR11MB5108:EE_
X-MS-Office365-Filtering-Correlation-Id: 58871cb4-1a22-4c03-7df5-08ddbfe0ab41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eGxLWHBLcFljbzY4OUtqRjJ6WWxURkJ4VnVuZUVYZGpIcXBOSVFYV1dMVGxa?=
 =?utf-8?B?eFlTV1NMOEJWeGZZdTVPREpWQnBCY1JBQ2FySklLMEx3bXF5bWczWjZ5RlNC?=
 =?utf-8?B?eDcxd2hxM1h6SENtQW42K24yV2Ruam94cFFjTW45ZlRqS05abjdkc3NYTVU4?=
 =?utf-8?B?R25JNDV0NTQvekRKNVRIeUt0QTkwZEluVzlWbGd4K1RSVVloSHVTdEZxSHJX?=
 =?utf-8?B?LzAwY3F6SlFNdm9ETHFiaUpqRk5ZbmNIMlVQa2xjUjdqNkF5WmlXYTE4ZWZR?=
 =?utf-8?B?aEUySU5NcVpNL2Jyc2Y3alA4Mk5qaHdobGZkSGx2OVhQQkVJNVorWTBBT25v?=
 =?utf-8?B?L0pHNzU5c2lLN0N0Mkc1SDk1R3FiMEl2L1VqWDJMTjRzS09BUnhPMHVtQVBw?=
 =?utf-8?B?djNVajlPekJPRGxTVlNUaGhWbERmT2EzTlVJUCtXbVVNakhSQVBTRVVhZHR3?=
 =?utf-8?B?T0U4bXlieUdqRW1hdHdNVlVEL1hrcUI3ckdWUHZDblhuVEtqTlRQWVEzSGcz?=
 =?utf-8?B?WnhSaktXNXYxdTdvZUlmOXNQbGY1VmxzMU02Wmd6WEFCdTk4VXhyUjA3dFNE?=
 =?utf-8?B?NFB3cy9SZTlXZ2xDbUF2aVRGeHVid05TSlJVaXkxS244QVFqckE5aFd4bGIr?=
 =?utf-8?B?TFVxRlRJQUpHYTRFSkNXYnAycXJlb3o5dFhkZm5hay9BY1FKVC9hVUdrd1VD?=
 =?utf-8?B?aDlValRZVERUa0lEcEl1b2VJRDNuZ2JCcnUvMXI5cTRqMDlJUExBSWNINFhS?=
 =?utf-8?B?QU91NkpEeW52L1dLRm5OMm91L0w2akwwRFNpSHVaVG9oTnFicUtJdSt0cWg5?=
 =?utf-8?B?L2hBRXczNHpBZUsyWjV2cU9mSENleXUvSmJleEF0REtkb2NZMDJOWk5rSVJh?=
 =?utf-8?B?ZHMzTjZHeUVJcGhlaUluYzVlMS8xR2RwVmRlbnRxeTdGTHIzeWpUN0tnbVIz?=
 =?utf-8?B?eDYxQURMVDVtUE54UnAxQTlvVWhxcW9IcWhiVG1sVzVwR0NsUzRGOHhSOGZt?=
 =?utf-8?B?eUNzZVUzL3NjS0EzY2paS0tzZTl3clVkM1B6VytpUEVOUzFrZGxpUkFrZ2NW?=
 =?utf-8?B?RE9hckd4T25xeGkyTG9qUDRsKzZrdWxzUndkZ3JQTzVUM1NxcTEvZDBMdHpD?=
 =?utf-8?B?Uzd5c20zRWVxVks3UE5veHN3cG5ZTGZubTA3RDV0ZTI3YTMvaVV4QzVtMU5B?=
 =?utf-8?B?R3RsR1N4SGl5eFdsdkdyV2ZkeXhKOVg4dzdTTEJRTE50Q0U4NnU0Z2xHaHB2?=
 =?utf-8?B?Rm12TzdVWXJFeEhlVEROZ3E5emlaVEJiVklXRnJkeHJCMDhCdFZRMFYvdnd5?=
 =?utf-8?B?b2N4U0Q4OVRSNE9YZnlySStueEpjbkpxUGMwaEtNZ1JBdS9XVmlFWVdaOEF4?=
 =?utf-8?B?STN1YTBKdHZmeXY4cmpLdUFEY2ZjZ1gvKzVVZ1AxV3NKVTdNRGN4SWlOWUlo?=
 =?utf-8?B?a1hKVXp4dnBNQ29URHdjUUc2RUpkYlhGSlZkcWcwTThka1cyL0pxWExndG43?=
 =?utf-8?B?ZlFsNUp4TDFtNnM1T3lhNSt1RnExWVgxTTlPUHZBUndOOVpxUGF5TTFPZ2Np?=
 =?utf-8?B?WDhXb1lHVGZXaldiUExRT1BCak9wVUtYc2doWUV1UWpGRDhwN01YZ29CbHRu?=
 =?utf-8?B?Q25pWHdPQk41NTRJaVU3WGZ0NEdmMmRkdkplTTFHeDRLUktyVXI1TEYzb1lP?=
 =?utf-8?B?dHRTdlM4S2VFdzJCcUUxMW8rbWlCUm1iZUhXZDRKQzNxK3daVXl0S2FYcVI2?=
 =?utf-8?B?TUJOaXFSTlRUaXhuci9ONWU5RHdnd1VyWWkzdjljakh3cnlFdDRUVGJXZVA5?=
 =?utf-8?B?V2I3WXdRdGFkZ3AxNkpxL3lld3oySkIxZFY3QlJDNHhyeVdWL0QzVDZqRS9X?=
 =?utf-8?B?WHppdmFOazl5OVVLdW9OM0FsOG1aUjZXem5DcnNBdVVUa3pzK0hzODBUNmh6?=
 =?utf-8?Q?PVUR+07GpaU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djBGaG9TTDdhOEFqbTdzNkNsZjgwajVDTlBIdDliWkJ3QUovS2NKcXNCWUZW?=
 =?utf-8?B?Wk4rNXZqUzl5WE9hNS9hREFnaHJTaVRkV1M5VGNjYlFWV2lyM1N2WmxqSzg1?=
 =?utf-8?B?L2VlRTRySmtCTFV0NGk4WnMyeWNvdjdMbnVXdGJSSU9hL1ZuRDQxdFR1eXAx?=
 =?utf-8?B?bVI0QnRwamdBR1o5YnFtSEZQOEEwOUd0SHozY20veWtDQUh4Y1UrNHB0UFNQ?=
 =?utf-8?B?K0NmWDdwcHVIWW9jQjVEZGJzTjVrVlZOUzFybmljY0V2bkoxOUE2R2MwUzdv?=
 =?utf-8?B?WlBRNTJsWnJXbW5hZi9YR2pFOVhvSkhENEE4QzZaTG9uSW41STdXczhwdDND?=
 =?utf-8?B?SHE1YUppQzQvWkllQ1JBT2FGa0JwNysvTm5rNFhtUktTcThQSC9CSTZSbUI4?=
 =?utf-8?B?QnIvc1F4MTgvVnZhT1Qxb3Q2N0pvbUV5M1lqWkUzM3R3aGxvLzEvWkQzY3pH?=
 =?utf-8?B?Q3YyZmczWDFrVURJditqRzcyZUplT3ZTZ0pURzZoa0dmY0xzUzJZRWlObU9U?=
 =?utf-8?B?bm5sSEI1dGtPcWErSDByVEhuV09kSU5jUnluYXYyWGxtajNmNCs4em1YblNT?=
 =?utf-8?B?VW5iM0gyUlVNajROaHBmbGMrM1FrWmhzMG1wdVJhaFNwcHY0TVNnTjFLR1dH?=
 =?utf-8?B?YitQVEpRQ1BXQWN1YXJId3MzS0hNeGVYcFhNQ3FMempFSndzc1k3SU5TZGp4?=
 =?utf-8?B?ZmVsS2Y2TDlaWnlacVpab1hvSS9xSXhQS0FENVk2Z0ptV0s5bEx5VVNaRXAw?=
 =?utf-8?B?Z0IvUkpSNDV4K3FtakVHd0l4Z21HTFVwOW9nVGpVMGE1Znp3TDZ5bEpRczZL?=
 =?utf-8?B?SWJBZTJyUVdyMEd5QUJ6MGEycTE2WldQUHQ2ME1DQ05CcENmZS9WdWwxcE5l?=
 =?utf-8?B?TVFiU25ZUTBSMHp3d0Q0Z05lR3o1SzRJalFVY3NyTmVJY3FKL3hXNTI2Vkcv?=
 =?utf-8?B?Z01IYjJlYWZZWVlrVGZzcnBUVGpMU0NJK2xXb1Z2WjVadGt0b2p1SENRZldv?=
 =?utf-8?B?cU9Mc3VxU3paZklNdEVoOE01MWNHUlF0U3hUY0p2NVdnODdQR3pWdHJ6bGdC?=
 =?utf-8?B?ekJsMy81QjgvN3Zabm9pY3RsT3pkQ3lQWWF2SE16dSsreEZFNDJQRGdvM1h6?=
 =?utf-8?B?RTIwZjFYdE5sRkdYWmF5R2RvaU56aGNPWTE5aG9YTktkcHBpMFhoeVdLZVo0?=
 =?utf-8?B?MmJpbVBrTVd3M05vc25ueTkrY0ZUb0JoUDZjTGVTc3pJbVpaNzhTbFBsNGMy?=
 =?utf-8?B?QzdRZnB5T1hQajRGVFlqSXMvNmRLK2xaei9iZGh3S1ErYmdiZHFiUCtqdHJt?=
 =?utf-8?B?emlXRlRpSTE0NVNlbjk5RmVaaE1kcnp1aHlhKzRMSGYxVmo0SVc1bGErUnJZ?=
 =?utf-8?B?amxzOTNuaWtPTGNuanZoSWkrSHpqNkVxM2dudmFxUEw2TTRUMFE1WGRIencx?=
 =?utf-8?B?ZzV2ajJnMlNqVW1FVm5aNFZCKzZhbUtENFZkN0JFSW1ySE9KM1JqUGZhUVZ5?=
 =?utf-8?B?RXc2RUUxSXYvWlRQdFY4dFR4Y3dSMC9SMVAzRHJWUlpPcUtKeEJhUTNKdTR4?=
 =?utf-8?B?MnJFOG1YRnpVRDFuUnZVOE9vNExPUUdHOHl3Zk5RUDNYSWMxcU5Bd2c1aWxw?=
 =?utf-8?B?Zjc3SWQyV2lFZDhoc0NyNWlUalJvUDBWQi8zc0Y3QzYxdUtMVmdDR0RySDBB?=
 =?utf-8?B?RDd2Q3EvdjFUdENnZmdlUXordE9PbmY2Nk5CdThvNkRmaDJqcllUc0hCTTdx?=
 =?utf-8?B?bUcvQ2NzRXdMSWExUElCRVJ5S3ZUSXBTV1RmM3crVHQxbnppVlVsWU56YURE?=
 =?utf-8?B?VU9aOFdObUZFcklyVWFKWHA0YjhpaFVEaHlUUjBleXJvTVkweGZmN3NJazNH?=
 =?utf-8?B?Y1pvVGVEaC9ycDZ4bGt2cWcrNUxzbHBZekdtRmxRZGJYUEhlNVVwbUVPbzUy?=
 =?utf-8?B?dFluMkdYZlhJUzhVT01peDlocUhLY2pvZFFDYXBqUlRCcXBhWTU1ZFIxL3Nr?=
 =?utf-8?B?a3IzQU9zNUxwRVhaczd2TE5nMnFtRThLYUc2U05lMDNzSXdkZ1BUcUdia202?=
 =?utf-8?B?YlZqbnRPYjVJc2NlazcvYUtqUXo1UWFJQUEwRFYzMGtQc0h2aEZCZXZJOC95?=
 =?utf-8?B?SWkzZTVDTWprT0NlcTM0VFRCOUlTVmpqQWJlbm54dzNaNnhFdTdPa1MvVE8w?=
 =?utf-8?B?bHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 58871cb4-1a22-4c03-7df5-08ddbfe0ab41
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 18:36:22.4733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K9x3a4tM+buI55NoR+Zj0d8iy8fBIKi5BOU1DLaqecoIDcA9indQTM5FnewsJA6KEjkgR5/jCRwrriIjn1kxLAQfYFbKYyOit7V6cZb6OvQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5108
X-OriginatorOrg: intel.com

Peter Zijlstra wrote:
> On Wed, Jul 09, 2025 at 10:32:16PM -0700, dan.j.williams@intel.com wrote:
> 
> > Theoretically there could be a threshold at which a CLFLUSHOPT loop is a
> > better option, but I would rather it be the case* that software CXL
> > cache management is stop-gap for early generation CXL platforms.
> 
> So isn't the problem that CLFLUSH and friends take a linear address
> rather than a physical address? I suppose we can use our 1:1 mapping in
> this case, is all of CXL in the 1:1 map?

Currently CXL on the unplug path does:

arch_remove_memory() /* drop direct map */
cxl_region_invalidate_memregion() /* wbinvd_on_all_cpus() */
cxl_region_decode_reset() /* physically unmap memory */

...and on the plug path:
cxl_region_decode_commit() /* physically map memory */.
cxl_region_invalidate_memregion() /* wbinvd_on_all_cpus() */
arch_add_memory() /* setup direct map */

Moving this to virtual address based flushing would need some callbacks
from the memory_hotplug code to run flushes for memory spaces that are
being physically reconfigured.

...unplug:

arch_remove_memory()
    clwb_on_all_cpus_before_unmap()
cxl_region_decode_reset()

...plug:

cxl_region_decode_commit()
arch_add_memory()
    clflushopt_on_all_cpus_before_use()

However, this raises a question in my mind. Should not all memory
hotplug drivers in the kernel be doing cache management when the
physical contents of a memory range may have changed behind a CPUs back?

Unless I am missing something it looks like the ACPI memory hotplug
driver, for example, has never considered that an unplug/replug event
may leave stale data in the CPU cache.

I note drm_clflush_pages() is existing infrastructure and perhaps CXL
should uplevel/unify on that common helper?

