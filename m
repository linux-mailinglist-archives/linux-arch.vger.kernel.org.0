Return-Path: <linux-arch+bounces-10035-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F94A28426
	for <lists+linux-arch@lfdr.de>; Wed,  5 Feb 2025 07:14:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A83E7A2F33
	for <lists+linux-arch@lfdr.de>; Wed,  5 Feb 2025 06:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A7B227B87;
	Wed,  5 Feb 2025 06:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bc5kMGlt"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF71825A644;
	Wed,  5 Feb 2025 06:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738736062; cv=fail; b=rllYEezL5GwZQm7uH3EIY5iDWU6UiqQF6IFu+APuezWT43r2/P9ZONyMEhXsXkhyf04QKMBJuxamzoqub9F9rylzAYTVIbNW0wHpHU2tLElc4v6DOKZaxzzv14shK0FA4TbCX62dzUnu8u1y5YztwTByorHGBDOjy8++SPKviRg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738736062; c=relaxed/simple;
	bh=fdMzKEHwM9+ksucGuF84+5O+H5vWCz/Uka3Uw2xtnVY=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=nTJBuTd17A6H9jTK2hvRuI3IitKuO748N7dCqJBM5YKokv2K9e8IooUEyfRNyZBxd2x7s1XU7acfIYlfd2Y7iauOJ8zcscfEdU2biI+XvlT1sKdm1gcvHHnRgS6yh9oQ/c6so1z1bsG8FkpqS4lH2h4//Fr5WoB/mPekoUC/tqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bc5kMGlt; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738736060; x=1770272060;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=fdMzKEHwM9+ksucGuF84+5O+H5vWCz/Uka3Uw2xtnVY=;
  b=bc5kMGltuUHoJPzF3Gi9q3zGuml8TRWj+WwArvcgiYs6+uAlmXvxyZR1
   dE+oMEZsavK01m/joeQjwoIOQXHeVqoh9cFvOtV0UqajSbX+RSOMSvac1
   JJlOU1eUMRtQ6kZVnm/YN+wqNICYgeranTqUMsww6fmJg5F3PyQ76Shen
   OsUyY2PyNss53ZTkO6sdwf5uxQOgudEOtnBwfuZvgHTR3MwQIKIUF39dW
   aR3MsTi3kiBMWHfFa0wNAXAG7JsJBY9LQvZ3Jtbez7Uthyr7R3M+YM5Yz
   nhDKPVbt6h1ormxIieliVCARoe9v8EAf5h4j+UPnDeEZK/stCKwvh1wvL
   w==;
X-CSE-ConnectionGUID: +unNXDwBSyGrpAy/PomgXw==
X-CSE-MsgGUID: vzDcbgSOThyvJ+08hvIAgg==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="56822053"
X-IronPort-AV: E=Sophos;i="6.13,260,1732608000"; 
   d="scan'208";a="56822053"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 22:14:19 -0800
X-CSE-ConnectionGUID: 9n2Qp2TXQXyFKfpA76si/w==
X-CSE-MsgGUID: aBPhlWE8S4q2MNCJAF6pZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,260,1732608000"; 
   d="scan'208";a="110695616"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Feb 2025 22:14:19 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 4 Feb 2025 22:14:18 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 4 Feb 2025 22:14:18 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 4 Feb 2025 22:14:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bo4zUNu+BPCkbu3YevJzhsovbIYaxEhOTyNGXaqoFTACF0d3SG+KaOXEP57q2gzY6rqgfL+DrC94ZryVVuaFRGbAyf+2CKj4zCZNYm1M69ZdOBSMOtWzUijKVO2+lKYuMNZowUfPxHmFjwlBpzHc4Pup8JSWlRgi0S/QihyEpu9cdX5XJRpddfGnPmGy+HQj0LRi+0d8j+2nsz+wLqRtnFgs47h+46CQpPvLLuASaeLkfyHRsw7274xGSvm6Ezgzsse66sO4lqGYOri2RWl6z88cw8bh7xyaXYx82/99Z7hr+cRvQO9dQQ6JRbhnVxBicJUVBo7AXAKgW9ruGL5bdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HgVdpC390ejkH2EST8BydzPMZv8zWafnPRMCe1wJHqU=;
 b=ABaxUbZd29NCqbjix7GI3e7LfTDe2OnGydeLYDslpM1DELw/gh6Z7K1qM4P3Og0OcF5eMRMeYs+YQutwnSaT32+hoo7BEe2ti51gYOKcQ5WFDVJ+4q5V4D3tK8Dqibe+ZtaJPhHLxOcUzCT+E7W6GlqecjovMiGMYZtaGYum0rbC8ijHW7MJNRZSkpehAJ+QUQx9uZ4eh7d6xCH8jUVct3m2BYKfHT4DSIMy7XqhM0ak+JlIP5hx4FNuzFE8Y//FGdGclXRTWGad+uM6dVjbLeYxgNNZeXJ6r49CQeiKkXfofWIPBSPfSGyQwwxfMGYTqm0qLPp3NcodgQZGiHFi0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Wed, 5 Feb
 2025 06:13:59 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8398.025; Wed, 5 Feb 2025
 06:13:59 +0000
Date: Wed, 5 Feb 2025 14:13:48 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Vadim Fedorenko <vadfed@meta.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Willem de Bruijn <willemb@google.com>,
	Jason Xing <kerneljasonxing@gmail.com>, <netdev@vger.kernel.org>,
	<linux-alpha@vger.kernel.org>, <linux-mips@vger.kernel.org>,
	<linux-parisc@vger.kernel.org>, <sparclinux@vger.kernel.org>,
	<linux-arch@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linus:master] [net_tstamp]  4aecca4c76:
 redis.get_total_throughput_rps 1.5% improvement
Message-ID: <202502051330.4d2f403b-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0043.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::12) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CO1PR11MB4820:EE_
X-MS-Office365-Filtering-Correlation-Id: d3f9a637-3f63-4568-19ed-08dd45ac4771
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?YuridmflQj7rADobsu+cKS20UCYXWLt17Y9yRiJjAw12JrD5eSlyCYmo0W?=
 =?iso-8859-1?Q?1w6c66V+Hv2cC54InFA3rKGT9CERm50EMg1pgCaS4BphhDu2N4ECNMYkNZ?=
 =?iso-8859-1?Q?ODxm/msOwu9uSofNhTP/h0x9phCcwgrkDuB3BOGThaqQl5rVxlrbTIQmnd?=
 =?iso-8859-1?Q?4QxAFdxLbZxvxKEz0POFbT5eesKybbWdushUMP3M3eRbSoWo4x3x8ZDV4V?=
 =?iso-8859-1?Q?oy46LdI2gLhcbibhx8AxC6SShd4hdcnowO7CKOF71C/Za7NgpUeqMSSVni?=
 =?iso-8859-1?Q?6XvJOWf451PKx+HMvOuzNGYRnxfn/WP6D9OkX77LtXNUDX6eLV95b826l3?=
 =?iso-8859-1?Q?8BMlBM6MIDPqDsAazfd8HWwhvpONS9XYQOUaeP5nAVcvfNopYPMW2xcCiV?=
 =?iso-8859-1?Q?TK24syIBmqT5hJOS3nN3PyBMXF+dbpBiuD1CnMX4e/siU5Dv0vhOJLkSWq?=
 =?iso-8859-1?Q?w3SjOlNg5J3YepLypQ1ieuStjRdZXh1R9vuzmC5IGy/D4FSx065XLy4LG2?=
 =?iso-8859-1?Q?2F+kGvP6zg8AFhjKr5fpV1efHgzEabArqp08deG+zBx7wna+HOtVvfZjDi?=
 =?iso-8859-1?Q?VITn8ICHY09FGxRyFUCJIzMG+8wqHZ/e95c/IQph1InvbEYog7uQwUAMiF?=
 =?iso-8859-1?Q?cY+sysyhsr5bg5UOrIT/A0c25gxhs/Ybgymkh4hvedTY94e/33cud0Oawy?=
 =?iso-8859-1?Q?bpaJjWEr3SLWB3exuPIkRKp2aLUVnl950QmocC6A2MtGtlMHDMg1VAWpcS?=
 =?iso-8859-1?Q?ZqIC9pDUtOie/BV+mLCzj1nM8PPlpwUmfAQt9rwSm/7pUdoqGklfhQjWBl?=
 =?iso-8859-1?Q?2d7jJv7y1ymj4QflLdAkn+PxEHY/4aqewVjXEIvZZ+Auks/GneEC5cC6/C?=
 =?iso-8859-1?Q?bDCN+ITdLUH68hQyRS2v3XznQ04DFETHhF1C9NM9uR9mSiMtvbGz+qO0us?=
 =?iso-8859-1?Q?gzNGTF5sqZgyttDAwnFl9o2h6+4A/wKaY5AZCeOSBsf8lUgmC4lGAiOP/g?=
 =?iso-8859-1?Q?mhTi/syvISyCjwccG+qVO/lr0HzJ9/v95rQMfB9Mt4jz0u3xAlv+9QGRW9?=
 =?iso-8859-1?Q?xjkN/gq2anL48oC8O9f99Y7HWJy65aw7lgqkgdA6zZuMZZshRf9X1kTaFW?=
 =?iso-8859-1?Q?R8bgmREwSB+fD0asGuY2ZY2r7yb/HIzdpGeZdYJg/xvhb0VjgoUwnngXGh?=
 =?iso-8859-1?Q?ZYcgRboUT4RfvM65CBOCkFpaFztBMTELirxeZv/g7HyJvBe3pbuRxEfcK8?=
 =?iso-8859-1?Q?heF2YRxbe26lnb8+EhJduSzYW+dA5wxN4LTtGRJYmHzPtL3XJEF/4VsH/l?=
 =?iso-8859-1?Q?VRLm7YurjWSDARtXUCngyAoBzk7YaF5X1iOjRILffah7N8j0NLDMdkOhbA?=
 =?iso-8859-1?Q?CGKQE5+0SVHZxbR7lm/GISvD4vOtOSzA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?6q4ksXm4ujZ9qQmiJ1nQNDa0hh3idpE7LOSvMTlYmEbf+nDr/GLQx5bpN2?=
 =?iso-8859-1?Q?XUWnq85rbsbzLi/gjy3IFqt9Lj4JcFvTJnJjp/xn5jqnWfpc6RfmAp2BS6?=
 =?iso-8859-1?Q?fXh+OdmUoYJMxXT7UBhJ1j8SCt2jfGB8nZ332NERw3RGfyu11x9xCeiyXL?=
 =?iso-8859-1?Q?R7F73r1LGIm011XUiMb+0R/1/uGPjRhhDAaVck76jVpb/f0HJ0rd8pRe7/?=
 =?iso-8859-1?Q?85zoPTNIuP6w2GFnH1C8x5kmB54irvPTZ/hs7pjz9ZDGABFY8qAZk8DEDl?=
 =?iso-8859-1?Q?up2YXI6RmYFg6SuQeMhkSjFfPGKlVK9elj41/nScSxeSl/vvbel1vo04Ro?=
 =?iso-8859-1?Q?Y0NVXtzPoo5/b589cyGLo6QCEffoMMzMoROAOr85c5tKnfrNK9ZpveKWva?=
 =?iso-8859-1?Q?LTAnIFxfeZrSyu/XyB/9j7jiCyX7UczjWdWXJknZQUU+j1Th9YR/mWrNeF?=
 =?iso-8859-1?Q?zUch4rVVGZ0nm0XTeR3TMcYl6hfrU8g3hqbmx1wfbu95baFMb9PtcIE+km?=
 =?iso-8859-1?Q?gCkWwszJvNrzSNUzrTlSCWVOOezeA8mGo0/xTvoYvhylotif+YBogvbMv+?=
 =?iso-8859-1?Q?WX9vUq+jO8hFOaHIn0xKRqNWjFpYdzi8wV50mn9RsrDDGV1YB63pBHT+EH?=
 =?iso-8859-1?Q?BEjbzXhmpDBTZv5JYlnGHEXjjqsEZHNHj5KyBFc7FqSwuqV62RzUpV+VOY?=
 =?iso-8859-1?Q?WSdexCHwNnAljild0SLx1c3IyMqP0OHnZU1u2IXBj7RmN+usBBmHRjkxG8?=
 =?iso-8859-1?Q?P9ymC6bYMUVoVKBAVWurkEe/vjqVtN6MT6Zga+HCRlII39MQf3cUs/oYBk?=
 =?iso-8859-1?Q?21F9ahf29uxxITVn7y+cTS6hmePYci4scFbAxjEmzcZFAdZSgjgN+SON3t?=
 =?iso-8859-1?Q?9lF3AnF+CEXAsVJYkM0fh9yCPLDqH/4ESlaHfVCDNy0N9UjN3wrHs3GM/I?=
 =?iso-8859-1?Q?mqXVd8v0chq+8lO/wO86raf1uFPO3dxNsVSU/6pcDla+lN/iX8ordkGETJ?=
 =?iso-8859-1?Q?enNiSwIpLvLF/4pQObygjwQ79l5h5xuwhZdWpYXMMrcByG7Sm+2I/QPhyM?=
 =?iso-8859-1?Q?u3H0tcvzeQB/tDRfDk0wfh4PAiszrHOfKuDL4sqy4XFDhL6JLnJl9zqdNj?=
 =?iso-8859-1?Q?Vg57jCVkguPDYNML9SU/Cks7mW3Yw9M9vJGONuuM4vJX+LDcAXZ0q31Z5W?=
 =?iso-8859-1?Q?oY0pk34eyQSvdmd6pM+FJSaZ66o0bUXmaGGerN5N2aer9TEs7VsifKV9u8?=
 =?iso-8859-1?Q?bc4edLihHllEG3eUdJENIPr1kHgaf8FhO2lxM4fS8xxlmX67X1LIQezXwx?=
 =?iso-8859-1?Q?mdAs0gxsCkTP0ZikZCMWYv7T+uEZYPM3jsOMqR/0dt3ZdVOfsz4/uTfInv?=
 =?iso-8859-1?Q?gy+qqUdrNy+uL5BcRE7g0uY8hqGGepobEbqnPY/eaDYTcUVGwKeXCi9B3t?=
 =?iso-8859-1?Q?D0IqlTI+8rT3EIAAcO54Z0BR58/o/PdalhD2EhtIubLHvUm/ltUy57J73k?=
 =?iso-8859-1?Q?WTAYwxA6/OT/Xa9JMXUQeHXA1jVQtiWDJZaRcuJRUldzXAzaTDlcZSNQ1H?=
 =?iso-8859-1?Q?K6E9CL1VdFmZjhZUwVbJAM5Gj89swl4MM4UyqSV4tfAkgC8m6KK51hho6E?=
 =?iso-8859-1?Q?zti2NlYedHUteA0LXNSeSGwq6kvwdNytuvPsVZ5zqfOcs+WeqR//8Lhg?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d3f9a637-3f63-4568-19ed-08dd45ac4771
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 06:13:59.2742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: naDAWKJ9unNpIAvC0aEpwM51dr3gKm5vrvXu6n4u0FJH0qJBEndGntbGu2H8H75hKwiJvpxMNfMjMQqKTWDvKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4820
X-OriginatorOrg: intel.com


Hello,

kernel test robot noticed a 1.5% improvement of redis.get_total_throughput_rps on:


commit: 4aecca4c76808f3736056d18ff510df80424bc9f ("net_tstamp: add SCM_TS_OPT_ID to provide OPT_ID in control message")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master


testcase: redis
config: x86_64-rhel-9.4
compiler: gcc-12
test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
parameters:

	all: 1
	sc_overcommit_memory: 1
	sc_somaxconn: 65535
	thp_enabled: never
	thp_defrag: never
	cluster: cs-localhost
	cpu_node_bind: even
	nr_processes: 4
	test: set,get
	data_size: 1024
	n_client: 5
	requests: 68000000
	n_pipeline: 3
	key_len: 68000000
	cpufreq_governor: performance






Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250205/202502051330.4d2f403b-lkp@intel.com

=========================================================================================
all/cluster/compiler/cpu_node_bind/cpufreq_governor/data_size/kconfig/key_len/n_client/n_pipeline/nr_processes/requests/rootfs/sc_overcommit_memory/sc_somaxconn/tbox_group/test/testcase/thp_defrag/thp_enabled:
  1/cs-localhost/gcc-12/even/performance/1024/x86_64-rhel-9.4/68000000/5/3/4/68000000/debian-12-x86_64-20240206.cgz/1/65535/lkp-icl-2sp7/set,get/redis/never/never

commit: 
  34ea1df802 ("Merge branch 'net-mlx5-hw-counters-refactor'")
  4aecca4c76 ("net_tstamp: add SCM_TS_OPT_ID to provide OPT_ID in control message")

34ea1df802f79d44 4aecca4c76808f3736056d18ff5 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
  18491785            +2.1%   18880098        proc-vmstat.numa_hint_faults
  18483590            +2.0%   18850441        proc-vmstat.numa_hint_faults_local
      8589 ± 97%    +255.7%      30553 ± 17%  proc-vmstat.numa_pages_migrated
  21039386            +2.2%   21505792        proc-vmstat.numa_pte_updates
      8589 ± 97%    +255.7%      30553 ± 17%  proc-vmstat.pgmigrate_success
     25696 ± 12%     +14.4%      29397        proc-vmstat.pgreuse
    252371            +1.5%     256108        redis.get_avg_throughput_rps
     67.36            -1.5%      66.38        redis.get_avg_time_sec
   1009486            +1.5%    1024432        redis.get_total_throughput_rps
    269.45            -1.5%     265.52        redis.get_total_time_sec
    257.67            -1.1%     254.83        redis.time.percent_of_cpu_this_job_got
    337.27            -2.4%     329.05        redis.time.system_time
 3.957e+09            +1.3%  4.008e+09        perf-stat.i.branch-instructions
  38469227            +1.6%   39070923        perf-stat.i.branch-misses
     32.20            +0.8       33.01        perf-stat.i.cache-miss-rate%
    136208            +1.2%     137857        perf-stat.i.context-switches
      1.34            -1.0%       1.32        perf-stat.i.cpi
 1.948e+10            +1.3%  1.974e+10        perf-stat.i.instructions
      9.12            +2.2%       9.32        perf-stat.i.metric.K/sec
    224090            +2.5%     229667        perf-stat.i.minor-faults
    224090            +2.5%     229667        perf-stat.i.page-faults
      1.33           -34.1%       0.88 ± 70%  perf-stat.overall.cpi
    714.76           -33.9%     472.47 ± 70%  perf-stat.overall.cycles-between-cache-misses
 1.095e+08           -34.2%   72001076 ± 70%  perf-stat.ps.cache-references
     15.93            -0.8       15.15        perf-profile.calltrace.cycles-pp.tcp_write_xmit.__tcp_push_pending_frames.tcp_sendmsg_locked.tcp_sendmsg.sock_write_iter
     15.95            -0.7       15.22        perf-profile.calltrace.cycles-pp.__tcp_push_pending_frames.tcp_sendmsg_locked.tcp_sendmsg.sock_write_iter.vfs_write
     14.40            -0.7       13.72        perf-profile.calltrace.cycles-pp.tcp_write_xmit.__tcp_push_pending_frames.tcp_sendmsg_locked.tcp_sendmsg.__sys_sendto
     14.43            -0.6       13.79        perf-profile.calltrace.cycles-pp.__tcp_push_pending_frames.tcp_sendmsg_locked.tcp_sendmsg.__sys_sendto.__x64_sys_sendto
     21.35            -0.6       20.74        perf-profile.calltrace.cycles-pp.tcp_sendmsg_locked.tcp_sendmsg.sock_write_iter.vfs_write.ksys_write
     21.50            -0.5       20.96        perf-profile.calltrace.cycles-pp.tcp_sendmsg.sock_write_iter.vfs_write.ksys_write.do_syscall_64
     16.98            -0.5       16.44        perf-profile.calltrace.cycles-pp.tcp_sendmsg_locked.tcp_sendmsg.__sys_sendto.__x64_sys_sendto.do_syscall_64
     17.15            -0.5       16.66        perf-profile.calltrace.cycles-pp.tcp_sendmsg.__sys_sendto.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hwframe
     21.61            -0.5       21.14        perf-profile.calltrace.cycles-pp.sock_write_iter.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     22.26            -0.4       21.84        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
     21.76            -0.4       21.34        perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     22.24            -0.4       21.82        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     21.95            -0.4       21.53        perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     22.65            -0.4       22.24        perf-profile.calltrace.cycles-pp.write
     17.28            -0.4       16.87        perf-profile.calltrace.cycles-pp.__sys_sendto.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hwframe.__send
     17.30            -0.4       16.92        perf-profile.calltrace.cycles-pp.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hwframe.__send
     17.49            -0.4       17.12        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__send
     17.51            -0.4       17.14        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__send
     17.92            -0.4       17.57        perf-profile.calltrace.cycles-pp.__send
      0.57            +0.0        0.62 ±  3%  perf-profile.calltrace.cycles-pp.skb_do_copy_data_nocache.tcp_sendmsg_locked.tcp_sendmsg.sock_write_iter.vfs_write
      0.74 ±  2%      +0.1        0.79 ±  3%  perf-profile.calltrace.cycles-pp.tcp_stream_alloc_skb.tcp_sendmsg_locked.tcp_sendmsg.__sys_sendto.__x64_sys_sendto
      1.34            +0.1        1.40        perf-profile.calltrace.cycles-pp.__inet_lookup_skb.tcp_v4_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish.__netif_receive_skb_one_core
      3.85            +0.1        3.94        perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      1.87 ±  3%      +0.1        1.97        perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      5.14            +0.1        5.24        perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.common_startup_64
      5.14            +0.1        5.25        perf-profile.calltrace.cycles-pp.start_secondary.common_startup_64
      5.54            +0.1        5.64        perf-profile.calltrace.cycles-pp.common_startup_64
      5.13            +0.1        5.24        perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.common_startup_64
     10.08            +0.1       10.20        perf-profile.calltrace.cycles-pp.do_epoll_ctl.__x64_sys_epoll_ctl.do_syscall_64.entry_SYSCALL_64_after_hwframe.epoll_ctl
     10.48            +0.1       10.61        perf-profile.calltrace.cycles-pp.__x64_sys_epoll_ctl.do_syscall_64.entry_SYSCALL_64_after_hwframe.epoll_ctl
     11.15            +0.1       11.28        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.epoll_ctl
     11.03            +0.1       11.18        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.epoll_ctl
      6.79            +0.2        6.95        perf-profile.calltrace.cycles-pp.dictFind
     12.44            +0.2       12.62        perf-profile.calltrace.cycles-pp.epoll_ctl
     15.91            +0.2       16.10        perf-profile.calltrace.cycles-pp.tcp_v4_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish.__netif_receive_skb_one_core.process_backlog
     16.00            +0.2       16.21        perf-profile.calltrace.cycles-pp.ip_protocol_deliver_rcu.ip_local_deliver_finish.__netif_receive_skb_one_core.process_backlog.__napi_poll
     16.03            +0.2       16.24        perf-profile.calltrace.cycles-pp.ip_local_deliver_finish.__netif_receive_skb_one_core.process_backlog.__napi_poll.net_rx_action
     16.78            +0.2       17.01        perf-profile.calltrace.cycles-pp.process_backlog.__napi_poll.net_rx_action.handle_softirqs.do_softirq
     16.54            +0.2       16.78        perf-profile.calltrace.cycles-pp.__netif_receive_skb_one_core.process_backlog.__napi_poll.net_rx_action.handle_softirqs
     16.80            +0.2       17.04        perf-profile.calltrace.cycles-pp.__napi_poll.net_rx_action.handle_softirqs.do_softirq.__local_bh_enable_ip
     20.70            +0.3       20.96        perf-profile.calltrace.cycles-pp.net_rx_action.handle_softirqs.do_softirq.__local_bh_enable_ip.__dev_queue_xmit
     21.08            +0.3       21.34        perf-profile.calltrace.cycles-pp.handle_softirqs.do_softirq.__local_bh_enable_ip.__dev_queue_xmit.ip_finish_output2
     21.15            +0.3       21.42        perf-profile.calltrace.cycles-pp.do_softirq.__local_bh_enable_ip.__dev_queue_xmit.ip_finish_output2.__ip_queue_xmit
     21.23            +0.3       21.50        perf-profile.calltrace.cycles-pp.__local_bh_enable_ip.__dev_queue_xmit.ip_finish_output2.__ip_queue_xmit.__tcp_transmit_skb
     22.73            +0.3       23.03        perf-profile.calltrace.cycles-pp.__dev_queue_xmit.ip_finish_output2.__ip_queue_xmit.__tcp_transmit_skb.tcp_write_xmit
     23.44            +0.3       23.77        perf-profile.calltrace.cycles-pp.__ip_queue_xmit.__tcp_transmit_skb.tcp_write_xmit.__tcp_push_pending_frames.tcp_sendmsg_locked
     22.94            +0.3       23.28        perf-profile.calltrace.cycles-pp.ip_finish_output2.__ip_queue_xmit.__tcp_transmit_skb.tcp_write_xmit.__tcp_push_pending_frames
     26.32            +0.4       26.68        perf-profile.calltrace.cycles-pp.__tcp_transmit_skb.tcp_write_xmit.__tcp_push_pending_frames.tcp_sendmsg_locked.tcp_sendmsg
     30.37            -1.5       28.92        perf-profile.children.cycles-pp.tcp_write_xmit
     30.39            -1.4       29.03        perf-profile.children.cycles-pp.__tcp_push_pending_frames
     38.37            -1.1       37.23        perf-profile.children.cycles-pp.tcp_sendmsg_locked
     38.66            -1.0       37.67        perf-profile.children.cycles-pp.tcp_sendmsg
      1.32            -0.9        0.38 ±  2%  perf-profile.children.cycles-pp.tcp_event_new_data_sent
      1.80 ±  2%      -0.9        0.88 ±  2%  perf-profile.children.cycles-pp.tcp_check_space
      1.19 ±  2%      -0.9        0.27 ±  4%  perf-profile.children.cycles-pp.__mod_timer
      1.22 ±  2%      -0.9        0.30 ±  3%  perf-profile.children.cycles-pp.sk_reset_timer
     66.87            -0.5       66.34        perf-profile.children.cycles-pp.do_syscall_64
     67.19            -0.5       66.67        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     21.61            -0.5       21.15        perf-profile.children.cycles-pp.sock_write_iter
     21.82            -0.4       21.39        perf-profile.children.cycles-pp.vfs_write
     22.02            -0.4       21.60        perf-profile.children.cycles-pp.ksys_write
     17.29            -0.4       16.88        perf-profile.children.cycles-pp.__sys_sendto
     22.78            -0.4       22.37        perf-profile.children.cycles-pp.write
     17.31            -0.4       16.94        perf-profile.children.cycles-pp.__x64_sys_sendto
     18.00            -0.4       17.65        perf-profile.children.cycles-pp.__send
      0.23 ±  5%      -0.1        0.16 ±  6%  perf-profile.children.cycles-pp.tcp_event_data_recv
      0.12 ±  4%      +0.0        0.13 ±  3%  perf-profile.children.cycles-pp.validate_xmit_skb
      0.38 ±  2%      +0.0        0.40 ±  3%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.30 ±  4%      +0.0        0.32 ±  3%  perf-profile.children.cycles-pp.pick_next_task_fair
      0.51 ±  2%      +0.0        0.54 ±  2%  perf-profile.children.cycles-pp._copy_from_iter
      0.18 ±  5%      +0.0        0.21 ±  2%  perf-profile.children.cycles-pp.tcp_schedule_loss_probe
      1.35            +0.1        1.40        perf-profile.children.cycles-pp.__inet_lookup_skb
      1.49            +0.1        1.56        perf-profile.children.cycles-pp.tcp_stream_alloc_skb
      0.76            +0.1        0.83        perf-profile.children.cycles-pp.skb_do_copy_data_nocache
      4.02            +0.1        4.09        perf-profile.children.cycles-pp.cpuidle_enter
      4.00            +0.1        4.07        perf-profile.children.cycles-pp.cpuidle_enter_state
      0.24 ±  5%      +0.1        0.32 ±  5%  perf-profile.children.cycles-pp.release_sock
      4.22            +0.1        4.32        perf-profile.children.cycles-pp.cpuidle_idle_call
      1.93 ±  2%      +0.1        2.03        perf-profile.children.cycles-pp.intel_idle
      5.53            +0.1        5.63        perf-profile.children.cycles-pp.do_idle
      5.14            +0.1        5.25        perf-profile.children.cycles-pp.start_secondary
      5.54            +0.1        5.64        perf-profile.children.cycles-pp.common_startup_64
      5.54            +0.1        5.64        perf-profile.children.cycles-pp.cpu_startup_entry
     10.12            +0.1       10.24        perf-profile.children.cycles-pp.do_epoll_ctl
     10.50            +0.1       10.63        perf-profile.children.cycles-pp.__x64_sys_epoll_ctl
     12.76            +0.2       12.93        perf-profile.children.cycles-pp.epoll_ctl
      6.88            +0.2        7.05        perf-profile.children.cycles-pp.dictFind
     15.94            +0.2       16.13        perf-profile.children.cycles-pp.tcp_v4_rcv
     16.04            +0.2       16.25        perf-profile.children.cycles-pp.ip_local_deliver_finish
     16.02            +0.2       16.23        perf-profile.children.cycles-pp.ip_protocol_deliver_rcu
     16.55            +0.2       16.78        perf-profile.children.cycles-pp.__netif_receive_skb_one_core
     16.81            +0.2       17.05        perf-profile.children.cycles-pp.__napi_poll
     16.78            +0.2       17.02        perf-profile.children.cycles-pp.process_backlog
     21.54            +0.3       21.79        perf-profile.children.cycles-pp.handle_softirqs
     20.72            +0.3       20.98        perf-profile.children.cycles-pp.net_rx_action
     21.16            +0.3       21.43        perf-profile.children.cycles-pp.do_softirq
     21.31            +0.3       21.60        perf-profile.children.cycles-pp.__local_bh_enable_ip
     22.76            +0.3       23.06        perf-profile.children.cycles-pp.__dev_queue_xmit
     22.96            +0.3       23.29        perf-profile.children.cycles-pp.ip_finish_output2
     23.46            +0.3       23.80        perf-profile.children.cycles-pp.__ip_queue_xmit
     26.38            +0.3       26.72        perf-profile.children.cycles-pp.__tcp_transmit_skb
      1.13 ±  2%      -1.0        0.18 ±  3%  perf-profile.self.cycles-pp.__mod_timer
      1.79 ±  2%      -0.9        0.87 ±  2%  perf-profile.self.cycles-pp.tcp_check_space
      0.22 ±  6%      -0.1        0.15 ±  7%  perf-profile.self.cycles-pp.tcp_event_data_recv
      0.48            +0.0        0.50 ±  2%  perf-profile.self.cycles-pp.mod_objcg_state
      0.32 ±  2%      +0.0        0.34        perf-profile.self.cycles-pp.call
      0.50 ±  2%      +0.0        0.52 ±  2%  perf-profile.self.cycles-pp._copy_from_iter
      0.17 ±  4%      +0.0        0.19 ±  3%  perf-profile.self.cycles-pp.ip_finish_output2
      0.11 ±  9%      +0.0        0.14 ±  3%  perf-profile.self.cycles-pp.tcp_event_new_data_sent
      0.27 ±  4%      +0.0        0.30 ±  3%  perf-profile.self.cycles-pp.__alloc_skb
      0.21            +0.0        0.24 ±  3%  perf-profile.self.cycles-pp.kfree_skbmem
      0.36 ±  3%      +0.0        0.40        perf-profile.self.cycles-pp._raw_spin_lock_bh
      0.56 ±  2%      +0.0        0.60 ±  2%  perf-profile.self.cycles-pp.kmem_cache_free
      0.13 ±  5%      +0.0        0.17 ±  5%  perf-profile.self.cycles-pp.vfs_write
      0.00            +0.1        0.06 ±  9%  perf-profile.self.cycles-pp.__x64_sys_sendto
      0.08 ±  8%      +0.1        0.14 ±  4%  perf-profile.self.cycles-pp.sock_write_iter
      0.02 ± 99%      +0.1        0.09 ± 11%  perf-profile.self.cycles-pp.__sys_sendto
      3.40            +0.1        3.50        perf-profile.self.cycles-pp.tcp_sendmsg_locked
      1.93 ±  2%      +0.1        2.03        perf-profile.self.cycles-pp.intel_idle
      0.00            +0.1        0.11 ±  5%  perf-profile.self.cycles-pp.__tcp_push_pending_frames
      6.66            +0.1        6.78        perf-profile.self.cycles-pp.dictFind
      0.00            +0.1        0.13 ±  2%  perf-profile.self.cycles-pp.tcp_sendmsg




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


