Return-Path: <linux-arch+bounces-12609-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D339AFF863
	for <lists+linux-arch@lfdr.de>; Thu, 10 Jul 2025 07:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FE427B758F
	for <lists+linux-arch@lfdr.de>; Thu, 10 Jul 2025 05:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C631E27E7E3;
	Thu, 10 Jul 2025 05:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H4SRkcGM"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CAE712CDA5;
	Thu, 10 Jul 2025 05:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752125009; cv=fail; b=a8dWlqCNkfwu719B8UXzvzxCp8TtpZmkgOnZiJH1kSBF+Zf4p6fYYGVqPVIun6V6snjxFbEUmzvkDNNfiKPC2R5l3Ynrj65SXWFlsEAZfPAHYEUAmji6MQpWzv0cEu798sX/fGgPXd4MKhYvORTYH0yoPn3uqKqXIcxcMd4DSPI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752125009; c=relaxed/simple;
	bh=bI2YcP3JpX8YLM9eZ+Tjbd1pkRKEVYJKiuxjkAsvF6E=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=D23JzJSDhFhvjtp1GFcFKRYffugqApvzCZi+wWFtorT01l1t+IjhnuX4r1329QB8xRS1Skmxm9VK7snEw4dni0nDVLdRfl7opBFGDJ5pWQyNy5+3IrIvR2umPbTxFPk6kx6o+T0NrhWsX0q7SP91I/l/Tkv0hJfc83e4yktgejU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H4SRkcGM; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752125008; x=1783661008;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=bI2YcP3JpX8YLM9eZ+Tjbd1pkRKEVYJKiuxjkAsvF6E=;
  b=H4SRkcGMX6F80XbY+6OQXnOHXbfMmsxpXjafwXoRrBZlqCGNfdub+4SD
   W7Yy1UNZrTIGBVJg5KTBeefqpoq3JcJTmlEiy/Tr4f/puzmVMjfLBbsb5
   u78/cxivYp1edVlNvGPXinvkG+9pEE8RhPfFfxlfjh3IhPeT8AKK/TgiY
   KN+Kvpp4lsiK0cNDipns8yKvS3wVnv3Ju6S3ley0Wi/l/4AtmVVnVqzrV
   wYCGb1231NsDtGjCY7yzxJJZfmZhiyhjszK0bscA+BT3oUO04N0u7LKik
   ITbfBitqrRut7nlpMuFHsE94m2/nL3kO0WAPL6uLqGZ+nLWDZxehA06dS
   Q==;
X-CSE-ConnectionGUID: pF096RyGQny0Al6YX0B15Q==
X-CSE-MsgGUID: UbKpWfOvQiWiMFKRCfnuGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="54323303"
X-IronPort-AV: E=Sophos;i="6.16,299,1744095600"; 
   d="scan'208";a="54323303"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 22:23:27 -0700
X-CSE-ConnectionGUID: j2HXu1B0QrahPx+rrCaz0Q==
X-CSE-MsgGUID: t4iJJxeXRxWs9TPp+dTWgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,299,1744095600"; 
   d="scan'208";a="156453411"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 22:23:27 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 9 Jul 2025 22:23:25 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 9 Jul 2025 22:23:25 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.81)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 9 Jul 2025 22:23:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P7GaO9PPEYX+4VUTK9R4D8KbcW9iyvVIi/0GR4OGL9XaJLRmlUuCSC4W+ADEyl+eMm6laLvnTF5Fj7tZ25WZmZQXd3AlpPVTHUXakAWUJhmBchO0/0Hx0vaQtG/XhdaiWomKfGArYW1VNJrwvVfmYqDVMPCIC6TULFfKephKnozzX890s2sFZ5CdnBZLeUmszzpRWb+eHrpWQv/fG1xsM7eCKBOHTCp71Pu+2pcBJlG+KMoWavM4MYWfTfkZ53NKBDY7KJw6WaEly2ebxSShI9rNzBZoCbe1Qp4kp+YF/5OMqpAA0CMl1qQHoFqBp+Hf471MgK5XhRFnCJjDxYRCew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aqxSTeGUHubH9RxPvXQxf2Bef9n1lFFVG57Wk9BlCDU=;
 b=ynnps9TvpR1quBvjDDTGbZR8cgaYZJs+6kY7yAPvzKLLLb6XWZyuUmUnWvq95PwpO7fAPdaoOm8k9cVeYggvEITQGJROnRwSF/R1omD607+XZNKe3WrZAcRZbohSWauZApFcHqmVVynD8iyIzj/dCllxdimwMOkoWruCID4sYc70kd1/i2Kr0oyagrqG+Wbn+lc7uY1sh3vaACS1ADaQXbFlZrIk9KJKVZLh8WnfmT4mRnQekf7UMIKW6srW94Hy/L34I7w5N+sRa8Usl3l5uuvza+J+EwQQ/LNngpn1hUs8TU7VypR1SJkZrv/XRz5iLWOsqWo/WwZ+upAakR+KMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH8PR11MB7992.namprd11.prod.outlook.com (2603:10b6:510:25b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.29; Thu, 10 Jul
 2025 05:22:42 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8901.024; Thu, 10 Jul 2025
 05:22:42 +0000
From: <dan.j.williams@intel.com>
Date: Wed, 9 Jul 2025 22:22:40 -0700
To: Peter Zijlstra <peterz@infradead.org>, "H. Peter Anvin" <hpa@zytor.com>
CC: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Catalin Marinas
	<catalin.marinas@arm.com>, <james.morse@arm.com>,
	<linux-cxl@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-acpi@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	<linux-mm@kvack.org>, <gregkh@linuxfoundation.org>, Will Deacon
	<will@kernel.org>, Dan Williams <dan.j.williams@intel.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Yicong Yang <yangyicong@huawei.com>,
	<linuxarm@huawei.com>, Yushan Wang <wangyushan12@huawei.com>, "Lorenzo
 Pieralisi" <lpieralisi@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	"Dave Hansen" <dave.hansen@linux.intel.com>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, <x86@kernel.org>, Andy Lutomirski <luto@kernel.org>
Message-ID: <686f4e20c57cd_1d3d100b7@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <20250625093152.GZ1613376@noisy.programming.kicks-ass.net>
References: <20250624154805.66985-1-Jonathan.Cameron@huawei.com>
 <20250625085204.GC1613200@noisy.programming.kicks-ass.net>
 <FB7122A4-BF5E-4C05-805A-2EE3240286A1@zytor.com>
 <20250625093152.GZ1613376@noisy.programming.kicks-ass.net>
Subject: Re: [PATCH v2 0/8] Cache coherency management subsystem
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR04CA0020.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::30) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH8PR11MB7992:EE_
X-MS-Office365-Filtering-Correlation-Id: a0736f00-90e0-47c4-4148-08ddbf71cb8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S0pXT3BBWjRpTFROWGpIVDVuTlZiKzJEUGZZM21zQTlnQytIdlBGQU1yWm4x?=
 =?utf-8?B?RFB1WFhQU3NnNUE2NUlCRHFGWkpIK1BIaWZNWVhieUdhbnJpNGlscWtBNDZC?=
 =?utf-8?B?SW9VdmNYNnBZZ2FrL3VRWVlPWS9nUng2S0l1YVZOL2pjWW9URVZVdUk1V0xL?=
 =?utf-8?B?NFBKOEQ2d1E1VmhnVmJUcnhaeUN3aDNCaTlzYzJxNmxoVEw2VCtBdm8reGpy?=
 =?utf-8?B?clBOQUZyRHBveEFnUjV3M043WVEvQVY3VFlNTXRrdDA3VTR5aWhXaWNzM1VB?=
 =?utf-8?B?WTl0RW01MnVjYWhWMG1QOGFpaHM4ZDRLWGNBUmZYS2dDN2VOa1hnOG9NSEl6?=
 =?utf-8?B?eW9pTWlpV2RhTXV4THhXcklNb0VKbkovbTZGajcvWjUwcjBLelpRREJCb1RS?=
 =?utf-8?B?RUtQV2FrdFF2MzIvZ3N0ekJ0VjNxbjlNdWpXSXMrai91MmdLWm82bkZmOGNN?=
 =?utf-8?B?RS9PS1RHc2JobEFRUmpPaytiaDdma3ZlV3dqem9QT1oxWEIzZDhYcU9kMDRO?=
 =?utf-8?B?OUF4MmJ6S2Fnd0pxS1g2OUl6bER3YXYrZHRqNUNjNk1XOG1Bc3lVcXpzRnVJ?=
 =?utf-8?B?RThUNmV2R0sycTk4cjZkY1NVb0RpSWJaRzZNQmVYVnhleklpdkErNThOc3pX?=
 =?utf-8?B?bEQ0cTVpUmpaWldzVmIzd0NNMHlmM2s3OW51YVRWMjBvbzlNS1ozYXhJYnRR?=
 =?utf-8?B?WE9xWC9zMWpvV2F4Y3F2RjI0WGFrRmFJdU1BOC9DVGlyT2RHUFAxYUFCcnZ3?=
 =?utf-8?B?RDFkak9RdlAxRnJZWVBhblNqdytsNGROV2JBbFl4YzlXMTNnUG9CcitibHJl?=
 =?utf-8?B?OGhVcFhaNnZCK0greFZQaDYvT2VlWWozMjFydjNaQVpuNlVTeU9iWFc3WXdE?=
 =?utf-8?B?Nm9pL2xJa1p2WkljS3ZoeHgyVlZNU2tvdmUzNmszS0pKNEZobXpTQ3lhWlY2?=
 =?utf-8?B?UGdjYm54Y3diMGlCRWNvaDZyeVRvdk5kRXY1WDVsSHNqcHRaOGVhSkI5OGpi?=
 =?utf-8?B?UzE1aE5UREwrZUw1Um9LaU9lQThjbWZrVUNwZU90K0dwUmNaak1CMzRtZGZN?=
 =?utf-8?B?c2VqaFlEN2hsd1FyQkw2T0wzODhoRVM4dEg3alZrSzNaVXA3bCtVdmJhVFRa?=
 =?utf-8?B?Z1BOQ0tEN1RLM3VhMVUrZHZ2TFlrejhJWFd4dktOa3o4SjNMVU9vVitsUU1E?=
 =?utf-8?B?ZVIvWk0yeW9oL2hZNjZtdmI0TVRqb29WU0VIc25nSks4Rk9tK3I4Rm5ZcU04?=
 =?utf-8?B?b2d4UEE4UHhHMEJZY1cvOWVjdHVsdm94L3R0QVdQdkNmUEtybDRKVzFmVHNZ?=
 =?utf-8?B?Zk5pd2dGc01DSExqbUZSV0JrRTVIbVB6Znp2bDRLL3ErQzhBdzU0R21hSVUv?=
 =?utf-8?B?ZG9OaEhPaFJvTGQ0c3dvNFJwQUZaTzJXQk9SWFpwbU1XME9HVHZ0akkzSmw3?=
 =?utf-8?B?dWlIeXZTdFV2MitZaVFNS05oWjd6cVBDOW9MNWEvWkRXMVUzUENxRndxaHFn?=
 =?utf-8?B?SUQ3Q2wwZ0JXSGJSUjNvNFJ1RkhRN3dDL1NwVmpjeDBzanpJSm5qMVRMTkV0?=
 =?utf-8?B?Z01mSGRmdWZadVFKTHo3eTBQRjhVNFRlRHVCMnVlVU5BYlJzVFBHNk4rNUl1?=
 =?utf-8?B?Z2ZROUpsb2NhZEUzQk00OG9vT1NZWGtMRUVSbko5ZDViLy9qR0h5dmo2c28r?=
 =?utf-8?B?bjdZTUlleTlhaTFTWHFTeWZvRkpZbXRZc281OEJXcWo0NFN3WXpVWDZ6aVlX?=
 =?utf-8?B?cGEvRWlZY2dGQklibUV0amxqa3RSd1NjMFk3dncxVDh6R212aS9WQTVQQ25a?=
 =?utf-8?B?MU5NVTZTeGpHbFRVMThEM3VPbVZXTWt5dXk0TkdTOXNFQzUrVldMbUw1V25Y?=
 =?utf-8?B?d2x2aWd1RkJmUjREU01kL1NGT0ZHM0EzdG5rZ2FBRkMxNHJ5bG1sQ2lOUUZX?=
 =?utf-8?Q?oMPQL68vRtk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTFxenpwcDZxeDJ4ZFEwVmhNUkZIM3l5VUk1THg1KzhTVHRzOWlzNVY2d1BF?=
 =?utf-8?B?eFFtVmFENjFxbmR6Q2gycVk2TE1JSEZBOTIzN2k0bjd0aFdMZzZUOEZqR3Js?=
 =?utf-8?B?YkkyMnc3KzBIMkNES3dEdmpUYXEwVCtjaDUxc2RXanFQaFFNNEVtcm82OTZk?=
 =?utf-8?B?UkZTa3FWUDN0K0RlL3VSSXFVOTVIYW44YTd3MDJjTU1zdGxKdTlZeXNaYmVU?=
 =?utf-8?B?d3FDSEMyMUIvRmRXaVB3QVo3a2ZUUFZEQzVWK3hGZnZFdGtHMnZHdm1uTk45?=
 =?utf-8?B?TjFmbFFlbFJOZURaQ0xUSE9JVndJc2xUMlkvNnZVMkVlQk0rVFp5ajllQk92?=
 =?utf-8?B?RjZraDYrQ2hxb2pjNlV6U2ZVNit0Qnk3Rnpzc3ZNZGttbTJIZXFyN0kvUUMv?=
 =?utf-8?B?TUZObWlIZEU3OVU1cStNbTdzNDM4Zm9jMUFNU1hwcjFMbFlUVXF4cmdoYjdN?=
 =?utf-8?B?N09hZ0tYTWI1aXRITzNXamF1M0lMZnpBM1JQTVN2TGd2ZzFJR3RNUFovNTBI?=
 =?utf-8?B?VTcwQ081elRZcHpDM1FmMzVwekJLeXllRHdxNGZrbWZKZzkzZ3NzeW1OcitW?=
 =?utf-8?B?SE5KU2IwbkdpSEl6NWVFMnBMbzZTN0lvM1lXOHZtU01KVlVQcXRWYVJ6U0hO?=
 =?utf-8?B?Ymk3Z2M2TnpObUFhR04xRnIzV21GTlo1dWxwMmVEUDZmMk4yeGpCVFhveDZl?=
 =?utf-8?B?T2t5RXpJT0dwZ0VETmJtSUdsMVE4UG00WDJacTV4TU56alk5M01VQ0VYeTlE?=
 =?utf-8?B?NDhvMi9TUkFQUVNqblJuL2pjS05jZ0RjdHNLUi9YQ1J1WHdJdFFVajFTeVVB?=
 =?utf-8?B?aUlReVRPc0lDNEJJSW9nZ2Z6TTlQbWtrVXR0UFd2SzByWGU3MXhhdzRDSzd0?=
 =?utf-8?B?clE3a3pIdVgzZ212ODgyVlV6UUdvQ09LdGZZaEdWUDhUajAwNzdZVXVaODE3?=
 =?utf-8?B?REIzbUhHS1dnbm1UM2xHVHFiS0Y3Vkprbk1MZnRXa01KWXgvWXc4Wlk3VUdK?=
 =?utf-8?B?UmpuNHpnei9pUVhFVU4wWnZJdGJlbGk2M0xHQkZjclk1b1NjbHp0U0ErNzhI?=
 =?utf-8?B?a25xM24xT3ZSa3NRYmJxTTNHRWNKcUtFazRxWlh4dmwzL3h1dlczbi9wb3BJ?=
 =?utf-8?B?TFZYdWhZRGFLMjhVcmFEZEQwZHlNR0xobUpsUU1qdyt1QThkK2dNTXJCQUVr?=
 =?utf-8?B?MjdvU3lWZjNvckJDaERIMlFPZUxFRVkwVWgwU2wyaTZRU3pqSFdDM1Z4QTJJ?=
 =?utf-8?B?a0l1V09ERW5KeXNYT2JSckdRVUlMcjJiVmV6enFyMjROT2FuM01ybWtMd1Ix?=
 =?utf-8?B?VjRzcFhlaXR6WFpMLzN2YzJXMCs2M0pmOEdQUUtYbWwzRzgrMXovT0ZmRjRO?=
 =?utf-8?B?T0ZnUHR1YWlrOXpqTU5KR3k3VzV4VEpxRzJiMjFsREJ0K3VEUkRPL2M5SkJJ?=
 =?utf-8?B?WUtZNEpybWo5RGFaM1VLK0hpRU9LeldDcGgveUM3Q3Y2blJ1NWRuSmVGMUxI?=
 =?utf-8?B?ZkNTdDBoR0hQcWdQUjExMFFrUDJIS0pqUFYxaURuQkNsTElVT1JNeUkyQnJ2?=
 =?utf-8?B?OVpkc1pnejJlMGl3WmlYNklKUkx3ejkrekMxYmRPZTNBZy96dFpyeDhkNHJK?=
 =?utf-8?B?eUpVN3lScUZhdTAyb1VSM1Z1UHUyVzNscytJdy91clNlL3Bib0JMcW1rN2d3?=
 =?utf-8?B?Q2NCZkExMDB3L2RBRFMvT01LeFRodG90aEFVUUxkVTZLNHdBcFU2NzJjOGhP?=
 =?utf-8?B?alppVCtVUkVYMEhPKzduMUpXOGZxWUx2VEU5Y3J2RFNkWXRnd21NNFNXSVho?=
 =?utf-8?B?YzFwS3FLOE1nWGJtdjUrcEhIMUNxMDQ3Q1h4YWlWemVDR1FYRkJLK1k5aXll?=
 =?utf-8?B?ZzF3NTJrTGo4QW5SekJDeHE1VlpwZndoVUhXMlU4cndJZ0x0aFVkZ09zWEpS?=
 =?utf-8?B?NmJMZG9leXEwd1M1ZHN1ZjVZcEFsVVNnSndNZVVmWlhYVjJOcW8wanBFeVpz?=
 =?utf-8?B?U1kyZ05tRTVUdHBRUTUyYklzYTNBZzBvV2w0d1BtNWhVWXB4MWFxSXZzYk9Q?=
 =?utf-8?B?NVdnNExhb29MSXg2cElVTjB6b2c5d1dGYnVpWXl4Mks5b1IwU2tXcWhCVHBZ?=
 =?utf-8?B?QktCTnlaRllYK21teHJQNGRvNUNWM0JMQ0F2U2paMjBpUlVvTEg2M05zNW9G?=
 =?utf-8?B?OWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a0736f00-90e0-47c4-4148-08ddbf71cb8d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 05:22:42.6179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WQEUmBjfRr1+y7wrJiFaDiaRm41tEvq9U7R1YwlIsbLtlKsL9BSzL47hmspzh903JVXOpnChGMDTE1jUccBRbyw+DjwlLWUa4xYy9JMzb/8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7992
X-OriginatorOrg: intel.com

Peter Zijlstra wrote:
> On Wed, Jun 25, 2025 at 02:12:39AM -0700, H. Peter Anvin wrote:
> > On June 25, 2025 1:52:04 AM PDT, Peter Zijlstra <peterz@infradead.org> wrote:
> > >On Tue, Jun 24, 2025 at 04:47:56PM +0100, Jonathan Cameron wrote:
> > >
> > >> On x86 there is the much loved WBINVD instruction that causes a write back
> > >> and invalidate of all caches in the system. It is expensive but it is
> > >
> > >Expensive is not the only problem. It actively interferes with things
> > >like Cache-Allocation-Technology (RDT-CAT for the intel folks). Doing
> > >WBINVD utterly destroys the cache subsystem for everybody on the
> > >machine.
> > >
> > >> necessary in a few corner cases. 
> > >
> > >Don't we have things like CLFLUSH/CLFLUSHOPT/CLWB exactly so that we can
> > >avoid doing dumb things like WBINVD ?!?
> > >
> > >> These are cases where the contents of
> > >> Physical Memory may change without any writes from the host. Whilst there
> > >> are a few reasons this might happen, the one I care about here is when
> > >> we are adding or removing mappings on CXL. So typically going from
> > >> there being actual memory at a host Physical Address to nothing there
> > >> (reads as zero, writes dropped) or visa-versa. 
> > >
> > >> The
> > >> thing that makes it very hard to handle with CPU flushes is that the
> > >> instructions are normally VA based and not guaranteed to reach beyond
> > >> the Point of Coherence or similar. You might be able to (ab)use
> > >> various flush operations intended to ensure persistence memory but
> > >> in general they don't work either.
> > >
> > >Urgh so this. Dan, Dave, are we getting new instructions to deal with
> > >this? I'm really not keen on having WBINVD in active use.
> > >
> > 
> > WBINVD is the nuclear weapon to use when you have lost all notion of
> > where the problematic data can be, and amounts to a full reset of the
> > cache system. 
> > 
> > WBINVD can block interrupts for many *milliseconds*, system wide, and
> > so is really only useful for once-per-boot type events, like MTRR
> > initialization.
> 
> Right this... But that CXL thing sounds like that's semi 'regular' to
> the point that providing some infrastructure around it makes sense. This
> should not be.

"Regular?", no. Something is wrong if you are doing this regularly. In
current CXL systems the expectation is to suffer a WBINVD event once per
server provisioning event.

Now, there is a nascent capability called "Dynamic Capacity Devices"
(DCD) where the CXL configuration is able to change at runtime with
multiple hosts sharing a pool of memory. Each time the physical memory
capacity changes, cache management is needed.

For DCD, I think the negative effects of WBINVD are a *useful* stick to
move device vendors to stop relying on software to solve this problem.
They can implement an existing CXL protocol where the device tells CPUs
and other CXL.cache agents to invalidate the physical address ranges
that the device owns.

In other words, if WBINVD makes DCD inviable that is a useful outcome
because it motivates unburdening Linux long term with this problem.

In the near term though, current CXL platforms that do not support
device-initiated-invalidate still need coarse cache management for that
original infrequent provisioning events. Folks that want to go further
and attempt frequent DCD events with WBINVD get to keep all the pieces.

