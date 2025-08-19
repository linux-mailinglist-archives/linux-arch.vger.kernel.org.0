Return-Path: <linux-arch+bounces-13200-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8771B2CDBE
	for <lists+linux-arch@lfdr.de>; Tue, 19 Aug 2025 22:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95A49526566
	for <lists+linux-arch@lfdr.de>; Tue, 19 Aug 2025 20:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D8131B10B;
	Tue, 19 Aug 2025 20:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hpJSToZH"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51C22FE06A;
	Tue, 19 Aug 2025 20:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755635207; cv=fail; b=pU7nChUnxtGDtzRbML5XlUm9qVX/XJ+QrVo/Ml3h5IoE6fYoymp99UW3Kkpv6l9gAI7Fro7J6pBuygzTPP/4C+Oggo0yGc2DVneZBaTu3krlS90rnAiN5pqfsv7KMElae5s7K8hzId3K6pfKVvCv1eMi/s2vJV96kJnJqJYicHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755635207; c=relaxed/simple;
	bh=JkuPZZPWKRCceJ/Y3z52DSRCJ/dDcqqJesTjCBSuPEY=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=nlFYbEvJzRAzJk483KmpZkoMuC5CKLuZr7KWusUTi2RriugK+u7/H+fluj25p1J/Pr626Od97WLx2KxG/g1Ki4+R91GKFBs4ZXSWs5aWsBpAgfYADllOY90JR+s9W9Wiju1NvoNkJDivX4VJF3MbZuwY9svKFXJqv8IaOtNOi3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hpJSToZH; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755635206; x=1787171206;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=JkuPZZPWKRCceJ/Y3z52DSRCJ/dDcqqJesTjCBSuPEY=;
  b=hpJSToZHgjORNVYS8+8o8rQ0+3EcBFJ4eDykPZw9LifIGfjAHJ45hV0C
   tM7hpklI7U9g+I5fg5QKlE14V26gFYR4w+n5o/Yws9QB3oHdYz4az30xb
   ERqXhk8hFtiEBzbwQ7h5z4ccdZOE0HuWlsB5fROt6uaddTPGQZck/RuSY
   rPMvq7FrFx7aoLCRaQ7y00In7hO45KXdo7/GaC46IK5HvZf+Li+UGiwFH
   etO09pS9SABHZLvHPMgzI+BPuIeWGgJXFl2WiGOZjX/qDX10ltY3R6Hm2
   LF8nLYBPvH34r0yMPwDslfjsyd8m1u1vwqdUiTpqsUBHJgqnFa982gmjP
   Q==;
X-CSE-ConnectionGUID: U7LC59piSQGktw+Cmu0PeQ==
X-CSE-MsgGUID: Egm673+URHuVl+En88GIaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="57754789"
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="57754789"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 13:26:45 -0700
X-CSE-ConnectionGUID: Htsj+hWgQZqKYrpSfL4Nhg==
X-CSE-MsgGUID: O2cyMS+iShiwoTSIjtYjGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="168360159"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 13:26:44 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 19 Aug 2025 13:26:44 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 19 Aug 2025 13:26:44 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.63)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 19 Aug 2025 13:26:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nGzqunJcKJJgPFBjANnncAgeUNjha4G81X8HArW6+GOdpL5aVQkvX+r/dESYdW/R0EGk6jviJ2sjR/kMTX3aeBWbgVeOwwf19CK20eXKfUD7pPB9nNgYKg0Xz//ft+7B5wk3kpWHaaWpeXWVbd+UhJSh31aWUFpBbZgVDYHhRRB9ErrTK5U0Xs+G5uVEfOVWiJAvHcTEJSqDVVzTrOGhBc1c+2VF01cPyr7Hb+IJ9OvdDfwQxOg9NCGOq7Pn9wffl+K4Zou1qe4h6F03Bq43EUejgCy3F8yMcvHNNPsXP1B9c8yWhazFNyI9b7ThtUnN82O6hNajHo1IPjauXPkJWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fZTH5fBjS6W0ehK0OOUIHOkhBwtS+rvlbsxIipBeECY=;
 b=OUKmzqaKbXOAo9+2gtWoJd9WhMXrGl1buH4GpWZtS6JzTalG9W4K52yHpZKKuJGkJIbisSI1/dHtbZY5mj05rB/1TIL9kcdXnyk8FxTo593YWGW1nTyWxA2rVA4Gx38SqgAZRpLrK93/MI60ubR4TB8byrqL9HuZSEtNrma7xGK9ELHXo2lFLJ3NZKYrBd9l3gOKrIluBlPakQp0AUmXyacVHk0cWGLMcLqLJQcnq8+uppz/v3Bjs41w66sSrVoOZK7NOWTqmDGGsS9b+JN8HKVPcBaJG7n9FJXSalZWRfVmPlc9r0/6F7HX0m89rR6YTaKjAgebEjeIEoI6Q32FHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA0PR11MB8335.namprd11.prod.outlook.com (2603:10b6:208:493::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 20:26:41 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%2]) with mapi id 15.20.9031.023; Tue, 19 Aug 2025
 20:26:41 +0000
From: <dan.j.williams@intel.com>
Date: Tue, 19 Aug 2025 13:26:39 -0700
To: Roman Kisel <romank@linux.microsoft.com>, <alok.a.tiwari@oracle.com>,
	<arnd@arndb.de>, <bp@alien8.de>, <corbet@lwn.net>,
	<dave.hansen@linux.intel.com>, <decui@microsoft.com>,
	<haiyangz@microsoft.com>, <hpa@zytor.com>, <kys@microsoft.com>,
	<mhklinux@outlook.com>, <mingo@redhat.com>, <rdunlap@infradead.org>,
	<tglx@linutronix.de>, <Tianyu.Lan@microsoft.com>, <wei.liu@kernel.org>,
	<linux-arch@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-hyperv@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: <apais@microsoft.com>, <benhill@microsoft.com>, <bperkins@microsoft.com>,
	<sunilmut@microsoft.com>
Message-ID: <68a4ddff258de_2709100ba@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <20250714221545.5615-16-romank@linux.microsoft.com>
References: <20250714221545.5615-1-romank@linux.microsoft.com>
 <20250714221545.5615-16-romank@linux.microsoft.com>
Subject: Re: [PATCH hyperv-next v4 15/16] Drivers: hv: Support establishing
 the confidential VMBus connection
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0009.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::22) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA0PR11MB8335:EE_
X-MS-Office365-Filtering-Correlation-Id: 090b5398-7d61-4f19-0fe4-08dddf5eb4bb
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ei9GWC9yeGNoRXI1VDlrRTBiazlJYUYyV2lzY3NTMjY4czQ0QTkrVnNMRFVj?=
 =?utf-8?B?UCtVc2JtVXNUQ3lWT2pqZzRLQUNHV3loRTlmM253WG1mcHBMNmJUN0MwMHdU?=
 =?utf-8?B?aHdiNzZZeFNMNUd0RkdaZGxDcWk0S3lrV09zeHZvVGFXcVhBT3ovN0FVby9m?=
 =?utf-8?B?bDAvTU1hNERHZUo4Wm9JQ1pjL2xDMU1ySm5rZUFteE1nT3JMdW5XKzBUNmVa?=
 =?utf-8?B?SVBacTBJQVVYSnc3bkx1UXprWVlFUFVPZUNyOEtlUm03NnNPU2tjYmRkZ09x?=
 =?utf-8?B?cExFMFhKVXVHdkF6MDlFd2hQUkxGVk1iYkxXV0ZvYmpVZmNGSGFoRWpmZ1lY?=
 =?utf-8?B?bVVsS3RiL01kUW5DTWkvWUp5T3JMQ25QNHl5MmtSRVlMRzE2MklzckNZTW1q?=
 =?utf-8?B?YmhXZjRzeHdJQnY5Wmp6S0ZTc3pBTkxxckxTMWRRUk1NOTNRMVVCbFhMTFlz?=
 =?utf-8?B?NXNwV3lpVEoreEhNL1EzQ1ZTaEJ3bWVscUc4QS9ROExnMUY0QjVUcDNYK29J?=
 =?utf-8?B?NzdLbWRuTGFLcDltQm95Yzh0SzNWajVhRlFTUXpRcStueXJRK2wvdzRVZDFt?=
 =?utf-8?B?YTBJQ2hOTDkzU2ZQRDYyNldWdUVwM3R5UEdJcnFYOEdxNGFQWnUwaHlHdmtX?=
 =?utf-8?B?S04wYkdYQ0tzOERvNDg1MXpMZ203QzVwOHUxTGNxR2RuaEhIdXVIRFFDemE0?=
 =?utf-8?B?eDdteUxZaHpFMldGY2wwR2VZRnJpQXFhcE0wU0o3SEIzMVEzVWtudGNtYWF2?=
 =?utf-8?B?aE9FbWd0NWk1NDl2c3ovTTdiVmc3Uktyd3VtZDZtRi9mbkJEaVQxNGxKOTVv?=
 =?utf-8?B?RjIzbjVFeGNyTXNRUExmVDFsWWhSUFRNSW43eGNrSEFHdVRITUV5WUw0T003?=
 =?utf-8?B?bHViQk1yL2VRaHJFQWNUT1daeFZlYjgwZUFUUlJhb3FZYW1waWMyNlB2SFdQ?=
 =?utf-8?B?SWVFbE9MN2pNUUpzQWJ0NmNlbVI3N2FqcElGV3dpRXZhRTZPcW1CVno3dFlI?=
 =?utf-8?B?SGZzZ2FTcXQzT3l3SS9TMTU2bHI3UWh1VnVlMlJGdWswSGY4b2duNzRHcndC?=
 =?utf-8?B?ZkJCUHg1SlRZaGxVcnl3QVVzN0ZwMDV4UGszWmQ3UGZROVVlUXY1VUQzb2s2?=
 =?utf-8?B?N2VpczdnYU5tT3N6T2V5dlc1ZUVvSEd1cFBsYlJ5VzZ3S1BpT1JZMUNnYTRl?=
 =?utf-8?B?aGxLNmZDc2NaQURkV2dsU0JmeVV4SWtYbStuOGdkdklaQWtyMnBVemFNZjVM?=
 =?utf-8?B?MGYzSFc3V1UyVkNoMDdiYmJNd24xOEJhKzQ3a2p5SFN6TTVJRVFHY0w3QU84?=
 =?utf-8?B?cGczZlZaaFk3dnRaR3dUR1NwbndnL2dxdFRaNmpURDZVWDdVNkZEN3RJVjht?=
 =?utf-8?B?QnhJOXZ0bkU4d09GYjdhYVJsaGpZQU45bGFYbjFIMU0xc3JhT1MraE1XS1k4?=
 =?utf-8?B?VG9GRVB6MlRKV2NVQjhFY3B0b0xLWkVVRXZNWkFhOVYxMVR6aDZxL3FKTks5?=
 =?utf-8?B?anZVVlg0ZXE3RDFGMUt1YnJFc1UwZXdoeitmRm5McDJ4ekNYbUYwdjN0ZGF5?=
 =?utf-8?B?SHQzRlRlQVFQL0dvR1BINHV6VXdTWWdBRHJ1YWhRUFJ6UXhiQ3dUUGNFZFJB?=
 =?utf-8?B?bDlMOWQxZjBIU1g2YlRLRlRheGJhL1p2bm5aSVRWcEk5b09DbG0reHdUSTRX?=
 =?utf-8?B?Um9ab3BLZjRSN0tiYTJ0U3hMRXdUQzNPZ3NHa0ZiRGdZeStVZ2ljc0hLUkRQ?=
 =?utf-8?B?dnM1dnJrWHpZUDdnd245SDQyU0M4VXpTbkZVZTVNbU5oNWNjaGdTMnZNRitZ?=
 =?utf-8?B?SnlHY241K3hOTGdEbmNqZ3JsRFRRRmFaZGtlQXV2Z09IYkVUdlFtaVI3bFpu?=
 =?utf-8?B?elhicldpMllwSTVtcS9ESjQrcGlzRndycE9xaGttc1hHN1BPQkNlenJ4bVdJ?=
 =?utf-8?B?OUlrU0FCYzZaWXRxMUxFWjBlWENKR3ZGeFpTUUZQNUVzMUNmTDd5WlJzaEI5?=
 =?utf-8?B?WVl4T3ExWGNBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2JhSTB1SHd2VmQwL1czWGIwdHlzeW1CcXVkQk8yUnpiMmljUEhDcUh0MGk2?=
 =?utf-8?B?UGl5MmxHQnRQWkVpWllVNjVSbXV6SFFhMS9Na3BwUWEydDZaSWY5UjJlZkRO?=
 =?utf-8?B?QnNaMlUyaWplMFNVMW14OURKU2llUlQyak1zTUVoVVQ5d1ZlVTNrZjN5MC92?=
 =?utf-8?B?OURtbE56R0NxcFRYRmlaV1lSejJvWEFTOHZNQTg3WldXQWpGQ3FNQzE4RTNa?=
 =?utf-8?B?N3ZRODg3SWNnMnBQeklycGd3RXlFZ3FiKzBreVVQRzFoUmFqMkF3WlJjTEsy?=
 =?utf-8?B?M09RalR5ZFIxN0R0SU56Z3h4NHJZMG1sVTJyS0hLWnEwcVJFdVRvSEk4NDJ4?=
 =?utf-8?B?WGJ2YnVvY0lsMmw3SEFIVHd1MVJqKzFNa0F6UkorWUVVVFJzRFd1aU9rZUdL?=
 =?utf-8?B?KzhSRjE0cmVlbC80UEdWM0VJUGdYSTlDRW1PV1lGOWlWODJjWjdNSWpvOEIz?=
 =?utf-8?B?c001SW0xb1R4a1RFSjNMR2t4dVlOY1JtZUtjbUdKejJHS2tQWmdlbEJpcndo?=
 =?utf-8?B?S2FMNmd0MWVFQVZsTzkxMW1oL2hBK0ZkMjU5RUEwQ0hLVmJ2VGhldnAwRHo4?=
 =?utf-8?B?cEFWbDZwZm5VZk1UZVQ5QysxdHNIaE5JMjVha20wdE5pVTBhaTF2K2VDRzNT?=
 =?utf-8?B?YUtkUzE4cStta2ZUekIvd2FNNW5xMkN2cGZCRndlb1hpYTdMZGlaU1hCVlN3?=
 =?utf-8?B?eUgzS3djNlRUQ0dtQkQ2TlF6Y3pta3JQaVBRbzBjREUxYm56OTRSUUxxeWVL?=
 =?utf-8?B?VUhlTi8wUXhzdnNZUW04YjF3TmRUcmh6UUdRSkhBUFlKNlNwbldiaWtTVDZj?=
 =?utf-8?B?NStvOTVsaDE5YWNlWTgwSCtxWE1NWW5wazF0RVI4bUdzTWFUUmxhMGU5ZjFa?=
 =?utf-8?B?UXBuSDgrUmt3Sk1ZNjdmMnJJd2ZwSVhtdHhLTHk5VmJDMzJMTGhNT05rNTlT?=
 =?utf-8?B?ck1MMG9kcmlHNmVieS9reDRFYnJNZmhaZ09tMHpyZjlCVDkxeU82NFJJN1RW?=
 =?utf-8?B?cFhMVHVHT1kzSHptS3UrdHhmTmorTUxTYkxrZFVlQUZZLy9xeDFkU3NTdm9z?=
 =?utf-8?B?SzlBU3JCSkxnYzQ1Y0Fhc0J3WnBYNlh0eHhsaEpmMUdnOExpVW9Oc3VCWGR0?=
 =?utf-8?B?ZEVrcnZ6Y2pncU5zRjVCQVZKL1d4MTVWQk5EL0FJUzVWdDU3aDJreUtObGFs?=
 =?utf-8?B?eTVpTi9WdWJWaTBnclowVUlhTXUyS3V2ZG9EVjVvQzh1UDlPUE11L29QNG5Y?=
 =?utf-8?B?aTFqbVVJS1BqK1VpcnFUWFFPcXdZRzNTcjZjbi9pVnQ2WjlPSVM5b09jY1J2?=
 =?utf-8?B?L1BDaG9qRjhGenZkWlh2blNSU3plVEc0V2NhUWhKT2pHQ0Z0cTE0b0UxVUZO?=
 =?utf-8?B?V2h5Tkg4NnNSMTlHNktiSzJTcHNPRDZycmtyWjNFQ21ZUHRSc2VWUUt6YlQ2?=
 =?utf-8?B?MThaRnU0QUJUR0xCTlJuSmozQzlwWm5HbThsT0hUNUpJVjZGekZ1bUpIQ0Rn?=
 =?utf-8?B?eEJWL2VBV0xxamlXTlhpZHgvUFRiMFNoUkY3aHVMN3dPWk9oREswakg1ODBn?=
 =?utf-8?B?TFduZGtWZXc1Y2dhL2VjLzBsQit2OEYrSXNWeFM2QStnWTA3TTM3dDNJVzZx?=
 =?utf-8?B?YUdsRFRxSEpCNTdCc0E2L3pRNEdFb3o3M2UrUUxkN2QrRzI4RlQvMGEwT0Qy?=
 =?utf-8?B?OVA2eDdERHdYZGVoeVFML3Q2akxDUkJRN2oweDM2Ty9NdzVmRDJPbmxxUjJX?=
 =?utf-8?B?ZkdzYUYzc3AwTlJTUmRHSDl5QmxJb0ErNTF5SUFLRFNPN09rN3ZXUkNraFJU?=
 =?utf-8?B?MUp5MmNreG42dDFsNGZuWW1ZRHg2UFhVWnhPbndtMzY4VFg0NnNlUzYwcnBj?=
 =?utf-8?B?TndFUlppTjZaWTZUNmQ2YisvVEo1UHBmMURjVjFmZlpBSkY0RDVSZk12bDNs?=
 =?utf-8?B?bVNDRU0vbE9KZjR2RkhDcXE4d1pUVzRiQzNuOHFsNVdaQVcxWVdKb0N6NS92?=
 =?utf-8?B?S1AyUmV1VDROK29xamFBak9UQm81UVVzN1A3R3BnTVRFb1VXS1pUelhvTkU0?=
 =?utf-8?B?dDdoSlFzbFdBZ011ZDI3L2VyZHZCT2tJdTB2MGxVNlpBdEE4SEcrTGxyS0RP?=
 =?utf-8?B?SG9BRjhNTStyY0FGckFVSm1BNWt0NGRQcWR3cVdUSGwvU1BiU2I2K1c3dUhk?=
 =?utf-8?B?WGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 090b5398-7d61-4f19-0fe4-08dddf5eb4bb
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 20:26:41.1042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b/7G7cx7NOc/NAw9zLEbHon8ahcL7m1AH5KuPGBI4e0VEYLcr6VSxDRKDqnWH1uiBDu5nPGcZNkI1G1Uy38O86W8w5YA2t337WSM4HLyr+0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8335
X-OriginatorOrg: intel.com

Roman Kisel wrote:
> To establish the confidential VMBus connection the CoCo VM guest
> first attempts to connect to the VMBus server run by the paravisor.
> If that fails, the guest falls back to the non-confidential VMBus.
> 
> Implement that in the VMBus driver initialization.
> 
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> ---
>  drivers/hv/vmbus_drv.c | 189 ++++++++++++++++++++++++++++-------------
>  1 file changed, 130 insertions(+), 59 deletions(-)
> 
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
[..]
> @@ -1401,41 +1474,42 @@ static int vmbus_bus_init(void)
>  		}
>  	}
>  
> -	ret = hv_synic_alloc();
> -	if (ret)
> -		goto err_alloc;
> -
> -	works = alloc_percpu(struct work_struct);
> -	if (!works) {
> -		ret = -ENOMEM;
> -		goto err_alloc;
> -	}
> -
>  	/*
> -	 * Initialize the per-cpu interrupt state and stimer state.
> -	 * Then connect to the host.
> +	 * Attempt to establish the confidential VMBus connection first if this VM is
> +	 * a hardware confidential VM, and the paravisor is present.
> +	 *
> +	 * All scenarios here are:
> +	 *	1. No paravisor,
> +	 *  2. Paravisor without VMBus relay, no hardware isolation,
> +	 *  3. Paravisor without VMBus relay, with hardware isolation,
> +	 *  4. Paravisor with VMBus relay, no hardware isolation,
> +	 *  5. Paravisor with VMBus relay, with hardware isolation.
> +	 *
> +	 * In the cloud, scenarios 1, 4, 5 are most common, and outside the cloud,
> +	 * scenario 1 should be the most common at the moment. Detecting of the Confidential
> +	 * VMBus support below takes that into account running `vmbus_alloc_synic_and_connect()`
> +	 * only once (barring any faults not related to VMBus) in these cases. That is true
> +	 * for the scenario 2, too, albeit it might be not as feature-rich as 1, 4, 5.
> +	 *
> +	 * However, the code will be doing much more work in scenario 3 where it will have to
> +	 * first initialize lots of structures for every CPU only to likely tear them down later
> +	 * and start again, now without attempting to use Confidential VMBus, thus taking a
> +	 * performance hit. Such systems are rather uncomoon today, don't support more than
> +	 * ~300 CPUs, and are rarely used with many dozens of CPUs. As the time goes on, that
> +	 * will be even less common. Hence, the preference is to not specialize the code for
> +	 * that scenario.

I read this blurb looking for answers to my question below, no luck, and
left further wondering what is the comment trying to convey to future
maintenance?

>  	 */
> -	cpus_read_lock();
> -	for_each_online_cpu(cpu) {
> -		struct work_struct *work = per_cpu_ptr(works, cpu);
> +	ret = -ENODEV;
> +	if (ms_hyperv.paravisor_present && (hv_isolation_type_tdx() || hv_isolation_type_snp())) {
> +		is_confidential = true;

In comparison to PCIe TDISP where there is an explicit validation step
of cryptographic evidence that the platform is what it claims to be, I
am missing the same for this.

I would expect something like a paravisor signed golden measurement with
a certificate that can be built-in to the kernel to validate that "yes,
in addition to the platform claims that can be emulated, this bus
enumeration is signed by an authority this kernel image trusts."

My motivation for commenting here is for alignment purposes with the
PCIe TDISP enabling and wider concerns about accepting other devices for
private operation. Specifically, I want to align on a shared
representation in the device-core (struct device) to communicate that a
device is either on a bus that has been accepted for private operation
(confidential-vmbus today, potentially signed-ACPI-devices tomorrow), or
is a device that has been individually accepted for private operation
(PCIe TDISP). In both cases there needs to be either a golden
measurement mechanism built-in, or a userspace acceptance dependency in
the flow.

Otherwise what mitigates a guest conveying secrets to a device that is
merely emulating a trusted bus/device?

