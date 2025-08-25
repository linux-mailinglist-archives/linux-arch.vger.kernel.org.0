Return-Path: <linux-arch+bounces-13269-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53376B34F7A
	for <lists+linux-arch@lfdr.de>; Tue, 26 Aug 2025 01:01:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 755517B2BF1
	for <lists+linux-arch@lfdr.de>; Mon, 25 Aug 2025 23:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A52271475;
	Mon, 25 Aug 2025 23:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CXwDzz9D"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B80319E975
	for <linux-arch@vger.kernel.org>; Mon, 25 Aug 2025 23:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756162912; cv=fail; b=FNM2TLHSyBPPuyYKiOOt9ibwFNzuDuw9DvOPN6K7lWFz4AivCVune7YzSN44k7AWZuK2zSHTWxVeuPc6vW3siYlpyvh4mgDU7pOzd3+x131wfOGVzwLf1+LFViHvk70EvFwcihcmj80wobts7zcdXYknOOmU5oRuzpin92QRisw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756162912; c=relaxed/simple;
	bh=Es/+WtauxYbYpGDS8c3HmqWySvybm/CatFTBC4/qels=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=YTulExst9cRLaTpVUYtXW5PYHLhmzPzjUz+qxsgjSxZkclG9ZxPYVq+a4MwBhc/ReT83P6OfJcMFU0MZ/fPGcCsvq01xDEMaOKu8uKaPkNyBfP8P3HtsuUhVsjFGSyCWf/17IXm5yJI/MMYd/vsWOAzmvYtsbt1tsaLzM8AJHLs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CXwDzz9D; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756162911; x=1787698911;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=Es/+WtauxYbYpGDS8c3HmqWySvybm/CatFTBC4/qels=;
  b=CXwDzz9DDPhb2XvL9s3pi4CY+73dq6IlQK24S07nD66BRrl1HPMkYdtp
   qXuCE5nGdxh94H2BRp2JmPALYfxXzgBMx6Qm4GIE63K9BVGrbTy0wnNg+
   q8yNjfHxQuJ8gclR3kAxmY1yGdET80siv7VDHO0mqWXAkwFl94QeJnk0Z
   ayQiUDjd3tdIgmxBmXtb8jW4yXjVVSECydWz69O+vOUlmnzywegV7rex/
   BwhlQVWYbHgXDFf7H48tSPmGA3l/1ayGR1zWbLDpTZjrKLSJTADlXUvus
   x+ANTI5YGbYMO1xB803vy9QjubSwU5BdlpQcKVR26jEXlimPi8a2Hp1KP
   g==;
X-CSE-ConnectionGUID: 6Tek+pVTRZGOQ0hBqk2XQw==
X-CSE-MsgGUID: JLhQxXzPSHSZzQMEQE3bSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11533"; a="75984712"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="75984712"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 16:01:50 -0700
X-CSE-ConnectionGUID: U0/ITKj3Sm2nRAjKFwLJow==
X-CSE-MsgGUID: KXeuX9GuSA2l8Usrl7sHjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="168625628"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 16:01:50 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 25 Aug 2025 16:01:37 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 25 Aug 2025 16:01:37 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.68)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 25 Aug 2025 16:01:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lT6u2FqNqO1/7E/6Z9CpnGUnf6+gf3mIHtmpu3vi9WT6vWV2s6G+YUS15XCtQxH8nkv/KM2WCZo0WjLLttCHTwm0r3iRiJudVis02ScwwZoSJhH6vr95gNpzYWoynooW2BiptkZuM0GR7zmwzhw6JuPkqH3MsaPuLaVp+w8aXNX3mgPhD2Zl/+/5UqWd7l4wcFTczeJSg4HTZld9b11qK06dvy74cDv7K6/Qw5IzuHWRaHEtLAhDrY1Ylf3EqY312QHstru0fwFBay8c7DBxusRtwkBOvxe8vnJsoTNwnhOLMHYz4jwMMTWDSL1VnOxnUVEaHaoUAiWElUMIyznKxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Es/+WtauxYbYpGDS8c3HmqWySvybm/CatFTBC4/qels=;
 b=JAOlTn4ahtWlIPYPgvgpATY8bivWZ+Mm/FvApuf6H4H9r2b9cxWKcLf7W14OBB4NpfpooBRFgVbpCV6bReOmyBh1uJspNBwiRDT+hMx/mfIAEeShcIgWEpYatZTe07oiP34y6Vb7S2qWCyLEXyYXXKmPGTvsP+svbKKfKvj0/gvP+wFkyAP4r387R19+XnKtzMjAez5iXdKOgqPMxWCLVsMIcxxObVipXqmpSdomvqTzlXdTJXmEVCXdxCIAmo98Q1d6Hgvf9z92YDVDcQGr+WlV/Sl4stMk8u4h95hQeboUDtY0jiXGuYWY/BoXLeChKasafzqyt9laF6KylKozOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB9502.namprd11.prod.outlook.com (2603:10b6:8:295::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Mon, 25 Aug
 2025 23:00:44 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%2]) with mapi id 15.20.9052.019; Mon, 25 Aug 2025
 23:00:44 +0000
From: <dan.j.williams@intel.com>
Date: Mon, 25 Aug 2025 16:00:42 -0700
To: Roman Kisel <romank@linux.microsoft.com>, <dan.j.williams@intel.com>
CC: <Tianyu.Lan@microsoft.com>, <alok.a.tiwari@oracle.com>,
	<apais@microsoft.com>, <arnd@arndb.de>, <benhill@microsoft.com>,
	<bp@alien8.de>, <bperkins@microsoft.com>, <corbet@lwn.net>,
	<dave.hansen@linux.intel.com>, <decui@microsoft.com>,
	<haiyangz@microsoft.com>, <hpa@zytor.com>, <kys@microsoft.com>,
	<linux-arch@vger.kernel.org>, <linux-coco@lists.linux.dev>
Message-ID: <68aceb1ad6569_75e310067@dwillia2-mobl4.notmuch>
In-Reply-To: <20250825222126.356372-1-romank@linux.microsoft.com>
References: <68a4ddff258de_2709100ba@dwillia2-xfh.jf.intel.com.notmuch>
 <20250825222126.356372-1-romank@linux.microsoft.com>
Subject: Re: [PATCH hyperv-next v4 15/16] Drivers: hv: Support establishing
 the confidential VMBus connection
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0179.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::34) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB9502:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bafbc65-3269-4c1a-abe2-08dde42b38d5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UHNYMnN2MUQ3Ukx6S3ZzSlIvMG5EOWhFWDdrdkpwZzV1SnpvbGJkN2NKRmFH?=
 =?utf-8?B?dWJrSTFlbU9RTlNGdFNLL0p2cEhqM1lGanpYK1Z6M0xISmM4eVdtTVhNTmkr?=
 =?utf-8?B?WGJ0MzB3QnNHUU1OekU3bGtHbHR0d3lNYTV2Rmx2ZW1hMEh1em41bHdwbGZk?=
 =?utf-8?B?UVh1c1FOYUVTTklvRCt5T1hHR1NpWjBzZ0N2ei9QZEYvL0pwMFJtRExYSm1G?=
 =?utf-8?B?VHNDeGFKemxRaGI2K0FtVUQzZHJ6a3k4Q21ZVzMraGFzWWxlYjQwL2F3M3FN?=
 =?utf-8?B?V2FUb25WY015eklTY05aeE1JbWxNMCtwRlE3TndZNFFGR1p6WEllN2ZMeFFl?=
 =?utf-8?B?b2FFajRwSlhLWjN4VXNZd25KVGY5bEROWTNCWCtOWG00NGVUQ21Fdys3ekJK?=
 =?utf-8?B?NVMvQUFPNUY0NG10dFczKzZqaTBHaTk2YmR1UHJuVHNCVTNmMzBUTUlNVzJ2?=
 =?utf-8?B?MFM3NFpKWWJ0TkNZckhEZFlZc2lEQVhSaEtUbWVlOWhzeU1DSWl6d3pjSFNp?=
 =?utf-8?B?UHJoUlp5dmJ6WjVnRWFaMDZsYi9sSWVDMEdjVDdGc29DVElMNkdvZG94L1Mv?=
 =?utf-8?B?bkJBdlFrdGNiMTM4Tjh2ZDF3d3kxalVkdjNRRHlsd2tWRjlkS2xjYThSMkRz?=
 =?utf-8?B?SmJ5eHBWS3VWamFkQnJ5bjZDRU9DY29ESlBBbnFnd0VzVEttbGNIRXJFZmEx?=
 =?utf-8?B?YzgvazBFZFZZTDBidXlJVFNJVnl6U2h6ZFVhT0hBL244cm1QVEczZkRNZlRH?=
 =?utf-8?B?YmpzNzJBVEhhUlZNUzJlMHF2aXpzN0lQcDFyQlFnMklmVkRaS1VXSFlMRVBp?=
 =?utf-8?B?OCtocC9WYWFpbFVrTW9kSExMc281c2dHeXVqQmRrZTIrcTk3MWZWQm0wZGpC?=
 =?utf-8?B?K215cHQzdUp1d2dEcG4rVGV3U1MzU3hKTHEyR3Q1eGtFb2hSRDJxYU0rOFdP?=
 =?utf-8?B?SVVteHFaQUViclVoeHY3YVVTc2M5c2ltc0tNRlc5NElaSjhTN1VKbEJobGw0?=
 =?utf-8?B?UXpCTmxodHZjV3dneW1BVnVHZ3V1aTUrMU9UYzFOZ3A2YVd4VEVNWXoxUVhL?=
 =?utf-8?B?RDVmcmlVeHFWcm50QUY4Qk84WHNUVUhGSkkxQ1VJeng1ZWRWbks1b0g1Y0RV?=
 =?utf-8?B?K0VNN1VWd1kxUW1DQjY3SHVVcTRVYmlYMFJZbXlaNk5aMXplOEovV01NaWFW?=
 =?utf-8?B?SlVQc0toRjRiUkdnZ08vV1VaYlV0YzBoSEhVRjN5c2dxL01LMzZBakZPMmU3?=
 =?utf-8?B?WVJLMUR1TzdYS1lqN2hQU0FJdUFYQXpWZEttbHFnam9pOUdFUmV5WGFxeUZI?=
 =?utf-8?B?bEYxUnN3UngyNmZLV25XMmY3cjluczB6NWlUR05makN6RUIwUGExRFVKUC9k?=
 =?utf-8?B?VUVxWlBITkZRRVkySXY1T3BVVWdheW1VY2kxdmVuYkRLVVpublpLNjV6OVBU?=
 =?utf-8?B?ekZrRCtzeUFiQUM5UGF2MW45UnlJemhBQ0JKUmtyTmU0OUIxMVNhbVBzaDlw?=
 =?utf-8?B?SFdVaktmbkxBK3lRRXN4NlYzaEI4SFU2VHlEa28xODV3WUFBMW90aU1GWFM1?=
 =?utf-8?B?Mk1VbEdncHc1bGcyMWVheDZOVHRYc3dpUSt5NG9FbEhQbXBJMDk4Y3NEcWNP?=
 =?utf-8?B?cWt6V3dMUVIvWWRObjRPb3l5Y01yRGgrWExRdmQ1ZkE3MXROaG5lMW8yWVh1?=
 =?utf-8?B?QnQ2ZUF2MVhybnVxVUFETFFHcEdNT1g1QlhJYzZ0SEVqZ2tXSE9COUVlYlJH?=
 =?utf-8?B?OXFXV1N3UnVCQTNIQ0lCY3J4a1hlTlc2NXZnZ25tWjlaSHlOZ2hYSkxQY1ZJ?=
 =?utf-8?B?WEVUaGtEcnd0OHNNZ2JsK093SnUxR2o5dER0UEtGNU1JdGFnc28wY1B0VU5P?=
 =?utf-8?B?dW44YmFIdE1BMXpEUmZzSW1QQmNOdU1tOU1SWXFrZ3RpWTVwTFpxRlYwVVFa?=
 =?utf-8?Q?ZZayqNwBCSE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXRoQ2JFMDRGZ0xSa0dmMUZRUVRmNm5BL0FTQTBiM0JmcU5kakp2N29XVzBW?=
 =?utf-8?B?TnI3cC8xdFFWR002N0YzV2NaUWZlQzZKeG4vQ1N0UkZvWFdMSGppQVM3MjlP?=
 =?utf-8?B?OFZnemdCTFpBb0gwck5USHZYTkFKaDJJR2tkSW9vd0tJcmFOMTNZeVpnaFM2?=
 =?utf-8?B?UEdYeUk3UVpKWHAvc2lIRUJ3aVo3Q2h1cnVVQVcxM2VrZzlqdkhGYWI5SC9N?=
 =?utf-8?B?TFpZbDNWTXh0QzdOMjdwRmFSN1o3NDRJeWxLZkVXVC9NemV2MmJIQU44am9T?=
 =?utf-8?B?Q2ZvbitEdVZ0TExKMUtWWEl1cFVtSHdvZXU1UUdjZzBhaUx0MTdBTEFLSXRE?=
 =?utf-8?B?OU5tdndkc3A3eXhtcGJ1U1JkWUV6cWxCZTI0MVl5SzhrOHVtNHArMEwwQ1gy?=
 =?utf-8?B?NmRLWkdraXZOMkNWdzZWVVlJSUpraE1iMzgwc2pNV1ZqeEdjNzBpb3M1YnFk?=
 =?utf-8?B?Z2JCaHNiRS8wbllZUER4T1lBZUlJZU1tTmpFR2xpUHlTS3lMcG1MOVFxMU03?=
 =?utf-8?B?MU5iR0s2N3Z4Nzg3cjFKM2V5V0hpQjNMQU9pdnFISU4vcTZaTnVkdlYyZ0FY?=
 =?utf-8?B?ckZWclJNTXF1Y3ZZWGN5Zy9XYXQvV3N2U09abjlBRWp2RzdlM1ZZWWlKTHNi?=
 =?utf-8?B?U3N5ZittU1drcTc5TjlvMG5PN0RRdEpVYWlTL0NlbEQ0TFJRbTh1ejUvT1R5?=
 =?utf-8?B?cHlSZWk0cHlwRUw1empNRTVzQnZBeVBUbE0wRHBkSXlUZVZrd0RFTFJOQ1VS?=
 =?utf-8?B?a3pVQzFsN21vKzFFbzZUemdpUmt5cmNRcTBjL1VVOUYwSkF6VVZaSWMvNTNu?=
 =?utf-8?B?aTEvSTNsZmJETEtNZTBxQzVBa2Z3VWVlQ1hwMy82eHpzamd3a3JURW9YcGZG?=
 =?utf-8?B?eHJhb0M3RnNzbENDUUE0cmNkOUM2L0p6UUlHcldPbW9nZ2hjYkhIemZyYzJ2?=
 =?utf-8?B?QW5nNldBdzR6WEtBZnNBT1N5VUFSYmVuL0tXekdFTWJib3BDZjhKeFUyU1VB?=
 =?utf-8?B?bUxlWm1EL3lOK2g4OVFHTVNOZ1RjTXpDVi9lRjkrS0hDRFlVY0YrUFBNSVZS?=
 =?utf-8?B?dkg3MzJjZXNjNUFTZmxoNUJQQjZ5WWtvRFlaQ0FyaEVnWDlPVnFObHdhd1cw?=
 =?utf-8?B?cnV0M1JLSHZTa2JMODVLOHAwUlloV25jaC80ZjhDTVVVL0dZdFBmM0g1MEhR?=
 =?utf-8?B?SEtXeXFMNG5aNktMa0RLYS95djlwb1RUNmY1NjllMWcvNzVndWxvSlk5RnBB?=
 =?utf-8?B?WlA3dEZxWTVKYVdXZU5OYzc5SHp4bFdCWGUweGthTDFDb3FBZ3lxRHlROWhV?=
 =?utf-8?B?UDRhNG4rV2dRTFZ0K0w3a3NTVGZ2MGFBTnJUVzUxZDR2bTljL2pwL0t4OTJE?=
 =?utf-8?B?OHBRRGN1SEZUVkNUbWc4UHBWdWpEUkY0WDZMMWo4WHNicHFGR21MUTBxeno1?=
 =?utf-8?B?MTNWNTB6cnRkSGJZZUZWdnVlTS9tSDAyQTdhSktEZE1lRk91VENydVUySnFq?=
 =?utf-8?B?cDVCR2p2bGFFK2RFcWtCWVpoK0ZpSkhPU0pTeTZ1djdsOTh0dHhEU2tGQnh4?=
 =?utf-8?B?ZzZWRjZOZ1NvN1lxWFNnVlpsanBTUG81NzdTZnFZYys4cVNCUWhXTEdaaHda?=
 =?utf-8?B?TmFqRUxtUmt4T0luWXd5RjAvaU54N21QbTVreEJpZVFyYXhVZlBBcjFxd3Fv?=
 =?utf-8?B?TTJoTTZ3WFJINzB0WkJZd3dvdHJJdkg5UHdmbHYvL0pMQS9XY21KenBIWGdv?=
 =?utf-8?B?M2g4aUhRSDQ1YWJsUlNrS3dmNTUxMk5hWnlKTndLektnck9scGZ3dVRjUStL?=
 =?utf-8?B?eWRjRXRvOHV4djNOM0JKMEw2WXFNMVBrbEtOUnN4R2xPckczSEtXSmNNWDBa?=
 =?utf-8?B?bTRBM0VWQm82MlVId1pKaXlIdkNDbmhVRE55Q2RpQ01Uck9TZEJqV1dZL1l5?=
 =?utf-8?B?VFBkamdJQWFlUzdGNExGRE9KbGlnTTdqRENEalA2UVVEeGM1OTFtbjNlWUlV?=
 =?utf-8?B?akk0aWJvUVJFU1o3Zklnck5LaHdNRlk3MGIwMi9nYVNyUjBLUnpPYnlCT2k1?=
 =?utf-8?B?b2pSYnhXN1ZLWkpxN0owb1c5bDRsZTBjV3puSnBtRG9UMkZUNU9DeFp3Qkkx?=
 =?utf-8?B?dG81VWRTYzQvNkk3OHJCNFB1QTh4b1I5ZVM2WEhLT2E0TTRRdFpRaE9KcFFU?=
 =?utf-8?B?YXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bafbc65-3269-4c1a-abe2-08dde42b38d5
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 23:00:44.6050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SCyd4HGrgtLss5XRUDTRdSG7NB/6+beeJr4uIY05hxsqJXguxd/8/zzk0u2qtPt1WqhsiPqQ4g4+NtJs8pQfNexHZuVyfvFYlVnKvwktAUc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB9502
X-OriginatorOrg: intel.com

Roman Kisel wrote:
[..]
> This doesn't replace TDISP, I'll do a better job of supplementing the code changes
> with documentation and comments! Any suggestions are greatly appreciated.

No, I am not asking for documentation and comments and I am asking how
any of the security claims are validated by this partially enabled L2
guest?

> A fully-enlightened Linux guest could just use TDISP once support for that is available
> in the Linux kernel. Before it is, the non-fully enlightened Linux guests (they can only deal
> with accepting memory and sharing memory with the host) could rely on the paravisor to talk
> to such devices. The TDISP device will be connected to the paravisor, and the paravisor will
> provide the paravirtualized storage and network over the VMBus channels to the Linux guest.

Yes, that is understood, again that is not the question.

> The patch set is a building block for building a confidential I/O path for the non-fully
> enlightened Linux guests. It would be great to have the Linux storage and network stack not
> to share pages with the host (and not bounce-buffer) if the storage and network are
> paravirtualized && use the Confidential VMBus. In the first version of the patchset I had
> patches for that, yet that was considered too naive to be merged in the main line kernel so
> I dropped them. But even without that, this patch series protects the control plane and the
> data plane from the host with the exception of the pages the guest might use for bounce-buffering
> although it could've avoided that in this case.

The question is what protects against the paravisor lying about its
identity? If the L2 guest is partially aware that a paravisor is
providing confidentiality then it needs some interaction with a relying
party to say "yes, this paravisor is indeed what it claims to be". Is
that some indicator passed over an established / trusted channel that I
overlooked?

> I mentioned that the paravisor will be handling the TDISP device for such guests.
> As folks might know, we use the OpenHCL paravisor which is a Linux kernel with the VTL
> mode patches we've been upstreaming (links to the repos are in the cover letter), and
> the OpenVMM running in the user land. The question would be if TDISP isn't available
> in the Linux kernel, how one would get it working in the OpenHCL paravisor that itself
> runs Linux? The SEV guest device in the paravisor kernel is being extended to handle
> TIO. Once TDISP support is available in the mainline kernel, the paravisor will switch
> to using the mainline implementation.

Either the L2 is unenlightened and has all its mapping attempts trapped
and redirected to be encrypted, or the L2 is partially enlightened and
at a minimum validates the identity of the paravisor.

