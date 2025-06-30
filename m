Return-Path: <linux-arch+bounces-12503-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E333AED4A0
	for <lists+linux-arch@lfdr.de>; Mon, 30 Jun 2025 08:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B98D3B193B
	for <lists+linux-arch@lfdr.de>; Mon, 30 Jun 2025 06:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67C1F1BD01F;
	Mon, 30 Jun 2025 06:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PT5WCBSq"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD2A183CC3;
	Mon, 30 Jun 2025 06:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751265135; cv=fail; b=FM6XKC4vBe2pz8EPdBStlPyy2XDFdkkS/iL5Cd9J/Mb+zxyfie7urtBSADnGOmqaeD+BzJD0FI9Ag83xDDLrIcDavQeRG/StdtscOK6h8CYk9uvG26l5XaQXCXEFcYIi8ap/JY3wHFgLZookZMtbUHCcGJ6ZrsuC9DxZnOl1Dt0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751265135; c=relaxed/simple;
	bh=lKXDLUxsBnY9PToU9H2VtR1DjF0UC6SpeuwmLV9oI6U=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YP7VIhu+fntm7jetn+Df211FFsUA+UAirPwC0xv9Q/RzA0eYDx65HsgudKseiGaNWujhM9V6sEq76u5D2KYw+c7vAXuVx2ZVeN6Z3ZAZEfGzOaDAFMS/TXhnZ/9fI6Upy0IkoJa2mLruexafyH4C3WONjDQK7B8o9HpSTCMQw1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PT5WCBSq; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751265134; x=1782801134;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=lKXDLUxsBnY9PToU9H2VtR1DjF0UC6SpeuwmLV9oI6U=;
  b=PT5WCBSqpHO7Hs4B9sAMffBquHqG74UvitKLisO9eyifsuHzFKlv2xCW
   1dJLo+nOnweArIxBSRiYXP2qigAaXbDC/H3ISarKwNRFjkoYOwSZJQ+P+
   +1xjE+rHVIP+VA4SxSkTCjWlXwGlgt1Jpb9qjvFpb67B6Mpt3ab1Q4q23
   Yk+HS7TM4qPVO6mxZM3sOSzhKaGyYIUwKgXyBgWnq0wX0lFF5I4532+tr
   cjDa1LpbjdjTzpWkPjwSboqmyqy8elN4lseYwQN71YE8zaWuVA7iqDsL4
   mPAqxnbn5wRrYSOOQrU35sPDY8sCwmk9BzwacM4iuaOVIZaEIXvG8fYEp
   g==;
X-CSE-ConnectionGUID: mpAZgtuLSJSAdsWEpNXr0g==
X-CSE-MsgGUID: QWyr2hnrSPqc7ulrbNRsHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11479"; a="64831144"
X-IronPort-AV: E=Sophos;i="6.16,277,1744095600"; 
   d="scan'208";a="64831144"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2025 23:32:13 -0700
X-CSE-ConnectionGUID: goPwhfFCSN6yW6YRcepbfA==
X-CSE-MsgGUID: N0Q6RtpHQbm4i01rvTcKQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,277,1744095600"; 
   d="scan'208";a="190546483"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2025 23:32:12 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 29 Jun 2025 23:32:12 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Sun, 29 Jun 2025 23:32:12 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.48) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 29 Jun 2025 23:32:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jm3ibPiz8nq82fgULLw9JLex9D9uhZ+J2uR9JEsapAiHQRITxaPjv/dbR39+cLrXa7i3VQksDoKsJY/qxgSfVZ6FXskO9HRGR4C6hkuKrUwkF2ZM1LUz04WoqUZ3/hoLS+lREunaHaaezHYbwNGyPWD7vQpSkc9selH184LVF78QbtdL+paYt1HpSERDthL+RW7lD/8nnESUmlPJdYmCCl0iAbi3hfavvNxPJvL266QBQ5QZEQqU83V+9+TzhFP35Omi85ie7q6c8+KuhhV30XrnvZ3838Of8Srz9ntUykXB7CN1BXBZo7P34FYM3oj2x24GRROLf9LdzkKVmfREUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yAA7j+Hoknom19q2xZJviwuVU613ftQPHu1kMWxUbIo=;
 b=UEBY3nYhtNwuepjEXldBItKvGg/zEO8ZlVdEFJc0o1Vrq8zR0W2DsCiWDKtq8ezx/eu+fy1/81ixiqSQKt44rcjYbL8OzxjEXmPNyeLyBrulTuaGiK7/rHcleLKpgzImSriJOZ0n/Mskbf/+JO9Ud/NfaZ0Yz3k6OXOkt6MOnCBhz9MZlIzu3PnybZo53r9Y/Hd754CBjuU6YIF1Ye4e6mPDlVCSe04O1nNOG01Re5kgJAXYuOrBGKlf1NRhd4VBQMZhhOibEbf/H4O3eriYkMuAOv38RaaTWLN0snLcyvuMbW7VJuxYo0P2DCGVXNPpubgIzTZeI8Boh2IEahNqmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5674.namprd11.prod.outlook.com (2603:10b6:510:ec::10)
 by SA1PR11MB8350.namprd11.prod.outlook.com (2603:10b6:806:387::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.26; Mon, 30 Jun
 2025 06:32:10 +0000
Received: from PH0PR11MB5674.namprd11.prod.outlook.com
 ([fe80::77d3:dfb2:3bd:e02a]) by PH0PR11MB5674.namprd11.prod.outlook.com
 ([fe80::77d3:dfb2:3bd:e02a%6]) with mapi id 15.20.8880.021; Mon, 30 Jun 2025
 06:32:10 +0000
Date: Mon, 30 Jun 2025 14:31:52 +0800
From: Philip Li <philip.li@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
CC: kernel test robot <lkp@intel.com>, <llvm@lists.linux.dev>,
	<oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-hexagon@vger.kernel.org>, <sparclinux@vger.kernel.org>,
	<linux-sh@vger.kernel.org>, Dinh Nguyen <dinguyen@kernel.org>, Simon Schuster
	<schuster.simon+binutils@siemens-energy.com>, Linux-Arch
	<linux-arch@vger.kernel.org>, Christian Brauner <brauner@kernel.org>
Subject: Re: kernel/fork.c:3088:2: warning: clone3() entry point is missing,
 please fix
Message-ID: <aGIvWBeEQuy7QgfK@rli9-mobl>
References: <202506282120.6vRwodm3-lkp@intel.com>
 <2ef5bc91-f56d-4c76-b12e-2797999cba72@app.fastmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2ef5bc91-f56d-4c76-b12e-2797999cba72@app.fastmail.com>
X-ClientProxiedBy: SG2PR04CA0156.apcprd04.prod.outlook.com (2603:1096:4::18)
 To PH0PR11MB5674.namprd11.prod.outlook.com (2603:10b6:510:ec::10)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5674:EE_|SA1PR11MB8350:EE_
X-MS-Office365-Filtering-Correlation-Id: 134cf638-1d97-417e-660c-08ddb79fd75f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hc91xZJmYEXkZBZiD5JGb9/f/7UqwZPEtyQN34YNASnseUaXNFNG8jsWFWTU?=
 =?us-ascii?Q?lmYAqHdoLBw5TFuSBKQvI9A7PB8e9Oi9d1evppoQv2A3VmR6MOXCWL7yI9I6?=
 =?us-ascii?Q?Qaf6GRLxk7aE+B6xq9a1kejrgTiTokAOFYKPE8X0LToBSv+LfO+G1m3iVDRC?=
 =?us-ascii?Q?OayCpnKAgCEA50uePV/6a5gGQ7CQM7dFOvNK37tDHbVgB2/kXW2QLDORzeW7?=
 =?us-ascii?Q?1AMqLsUSOZjZdvMp6F+izUP5pzEycXJprucw4rDOQHQ3Rli7pRj7sAxdQzP3?=
 =?us-ascii?Q?OKHreYVO+T8j8MkSSpRFZs6n5j+UQhcsHC4BCJ4WIbGRhL10DwtavIa0x8Lx?=
 =?us-ascii?Q?7YV7LdJaiNF20mb+Tfq3afobEyp1fZbYV9fDkKdi9rIknGX4ACCbypgNK3A6?=
 =?us-ascii?Q?k30Ky6xGaiIeBXunlx308p462xV360fth+tnFbLJ8uhA1cNt8Y4rckSedahq?=
 =?us-ascii?Q?i0yyotUKe76FH3wZXD5gNtA5xkgYoWDIGXIq2RQEtt4FlR5cH+tUMZL/uAHf?=
 =?us-ascii?Q?de4jgJCXeWgFFn/ecmJxVV+Fr2U5SalO3Cth3WCu5gBTKYUKCxZ9fIgg4JwO?=
 =?us-ascii?Q?lKThKS7bFIgnKiCyyX05iB5SZGC4S0yhLrziqgDwR7yH3ou6jgEj98W4FrxK?=
 =?us-ascii?Q?hTauRij6Sn/WB1MDiZYuT9rz1nBz4HQz7N2IePC8N8Sfx1aCyD/9aCVhkeDh?=
 =?us-ascii?Q?F82Y8xPWbyqeD5EQgqBQ5kzOwaPskw4Qdk3wstqguIvzMEAEsmOfFbdOAym2?=
 =?us-ascii?Q?BwIp1qqylb4dDElpy+Ko8v9TNcZlC5EkYDRxvYLXSBCdE8Oh427aAceBxdYX?=
 =?us-ascii?Q?tVcIZ7pKQmX76KDqZukQrFbBfu+Q/HRruarTnViyl4F1YMU4Nsxg2Z+V8yt7?=
 =?us-ascii?Q?NE+YWx32sjmhnqAh7Zpjk+CbfdBF/lfwF99Qv6DmT6tCzRaNdlPC1E7QacaP?=
 =?us-ascii?Q?+R4V4djx/i3yxvrtMl36rfE8qXodrudWOwXE2k7tdLDZIjUp8sCS32byjNhZ?=
 =?us-ascii?Q?84rVQZjuN750LrU8FNvpXQAK5DE6jRcPR5DdZsquvH3rdX6UxWjnm/9Cvf1X?=
 =?us-ascii?Q?iJCHdnZ99LEPG+SAky+JeShqDtTKIsO0fvvxWSHiVBOGnd+zkBCGp9ESaBYE?=
 =?us-ascii?Q?iV/F1gkWQHyNJ95gcvii/m3JpWQQmuw6im5xw8JufBGypD+jMS2Tt0GIuOdK?=
 =?us-ascii?Q?EeS1cB5OQekBO8phPtzpM8qv3ngAd7bbXzFnn7Ub9nX6PSz7xmW6Tv2elGZV?=
 =?us-ascii?Q?6tl31K4Phiz1ZM9UcU+Qu7fy/qXwcLjuPaHbE3ciPyhJL7OP5622sROZrHVZ?=
 =?us-ascii?Q?lr5jX4y4NO/8Kl0OoVtskAHs3RCIT0heo71DkUIS/AEfUCFe60stDvkosRf8?=
 =?us-ascii?Q?IzQ/A9DOb/VLjs9x5LLosW9JTgkC?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5674.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D+9MlsRCpPLYHOIgG0xhRi5g2xQqeWK3JQLF3OvDeyTMydbWpN8cPd2qWK5x?=
 =?us-ascii?Q?aKmNxMfvLDGhksyzke9XgZmvIegUCXruxPQlxyCz6oZyLoLHnPncxGu9ABfm?=
 =?us-ascii?Q?TjpQhI/Ave6/z76dtFc5a6P1g4HRbM3nDljRjGdWSJzARILQhld3bOdQNxTG?=
 =?us-ascii?Q?C3R6d9Or5tf+yZHzrTQrFzZbq7w5gzivRpy3gkAs2H+w5vH6ZV3cbBnQ5U4J?=
 =?us-ascii?Q?U024ulkV8a0zrtLYx9ZSjxNisnS6eknFoayvpkG01JmGetg5/O7ty/lpxMJa?=
 =?us-ascii?Q?KUfs4SRW5J03GzYbVmDnSlW6gXIMW0dc23IcU1EvW6Dz8npggzA2obyQdTYo?=
 =?us-ascii?Q?J/pR4ALswYz00rUJ8F7ibNRxJLOQb+5HcdNpGbFOBh9j3EN6N/jFVauOPQp4?=
 =?us-ascii?Q?TJ1BBFZYDdCkaPpk4J4QxcGvJWwtL3KiFZxttYPzYi7wmKC37oaX9oA3WJGT?=
 =?us-ascii?Q?ZmN9YOJrHU1PmCAf3LTHC0eo+x9W7L3y3C3lE0g0hr0fe7YtHDJ7hRHOvJz1?=
 =?us-ascii?Q?XnwbLl+NUDKv8R90dvgnCJJS9E4sG9lyiaZVnUx8eslCy3MDTYfeWAo/WU+d?=
 =?us-ascii?Q?B5iLjnuHRJn7Y+1INq84AkFxfccAJ9GhUu7ZshNsknIsi2MgZcLP4k3AyvLR?=
 =?us-ascii?Q?sBoAPTD99QSWAG+jYGRwgoeSky8We4jl+i4WffliDhSh+0Tx7v3od6cBYSG4?=
 =?us-ascii?Q?B7tr4qpeWeNeSOiAwDz/fG8anbCggAY98ZeDyDfH7wiblbKpAOdjDd4AhCWj?=
 =?us-ascii?Q?Oz6pPX23UI8VyLhYKjxgeQ/QjHS+I8OU5WT7MrAXoDpg/64WHQbT5lIP8h2Y?=
 =?us-ascii?Q?LN3QwfqzKIrjsWqYSq/D9nr6ZsnjmX9q9jDQbbw94kg6Ooo4mTWnp4HE0XbT?=
 =?us-ascii?Q?LPEfYgCIqJ1NesA1eT12Zwb69UvKJwSbh1zPImXaUz6PDJ/K8e6A/rgBrqkP?=
 =?us-ascii?Q?WPbbCLL9kc2DeiJK0tQcuAoIorX3K2M+azO1IAmmyyAGnBmGMe9JGOY67nn2?=
 =?us-ascii?Q?NQRiX1iGrRVo4IPS0D4m4K3Cddk2xn2g1czRGa8cOGe3957C0dk6BGwx+/aw?=
 =?us-ascii?Q?ZNf0rZ+O2sBUPK4ytbhBfJdRoUecqPbotoACMeq1oeZv+pJFiKwCYZblGafA?=
 =?us-ascii?Q?Drtet5iiOEjancCr32eXcm33TCNLd85NHvoLnTRh7wW8QHfIj19QYriP49s3?=
 =?us-ascii?Q?FOesI0klLzGH2svSwAK2E/o9Si4pUTwBkHRSFgEgqjbvoL9fVjF+WrEkqPgz?=
 =?us-ascii?Q?nS9KBjRcyQUqpaqZIK971Jjz0vdSpT7FxOhgKvvGKzwRuQGK2dtlKC3p30lo?=
 =?us-ascii?Q?lWaGZ9s8k3mlXcssgM354fJVi7PGwGwf2yb/mj8tH4j1lmRo2jM33yf2WIia?=
 =?us-ascii?Q?BuvlVsNK+RlDqIrt679xkT5MEHyP2uACLha+gyiieGGq4WBqh0QCH9nN3laT?=
 =?us-ascii?Q?5KYwydRpP8mw1D8ZlfeBRR5esJZwnxVRdSaW+Um282yj7Mczb6dAByWgEAA8?=
 =?us-ascii?Q?lfxJra4NoahXhc8bwD+0FfI/U1kMfWMXBdK7ofwDVOOgmM24pHJLvhS/IY4v?=
 =?us-ascii?Q?55yGiDItSdIkozlpJ8sSSF9sDrRn2ve+G+6mKGsL?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 134cf638-1d97-417e-660c-08ddb79fd75f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5674.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 06:32:10.0241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MZTBbi5sCi6M5fWWal7tBJ+7j4HHPuy0gF0yFDr9+3XjU1JiL9p2piuCVD/REfEtRV8QxmSWwaGwqc0r7fZ2HA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8350
X-OriginatorOrg: intel.com

On Mon, Jun 30, 2025 at 08:14:16AM +0200, Arnd Bergmann wrote:
> On Sat, Jun 28, 2025, at 21:59, kernel test robot wrote:
> > Hi Arnd,
> >
> > FYI, the error/warning still remains.
> >
> > date:   12 months ago
> > config: hexagon-randconfig-2002-20250626 
> > (https://download.01.org/0day-ci/archive/20250628/202506282120.6vRwodm3-lkp@intel.com/config)
> > commit: 505d66d1abfb90853e24ab6cbdf83b611473d6fc clone3: drop __ARCH_WANT_SYS_CLONE3 macro
> >> kernel/fork.c:3088:2: warning: clone3() entry point is missing, please fix [-W#warnings]
> 
> My patch only moved the warning about the four broken architectures
> (hexagon, sparc, sh, nios2) that have never implemented the clone3
> syscall from commit 7f192e3cd316 ("fork: add clone3"), over six years
> ago.

Sorry for the false positive, I will configure the bot to avoid sending
this again.

> 
> I usually try to fix warnings when I get them, but the entire point
> why these still exist is that they require someone to add the
> syscall with the correct calling conventions for the respective
> architecture and make sure this actually works correctly.
> 
> I don't think any of those architecture maintainers are paying
> attention to the build warnings or the lkp reports, and they are
> clearly not trying to fix them any more, so maybe it's better to
> just stop testing them in lkp.

Thanks for the comments, we will consider to adjust the priority for
the related archs. Also welcome more inputs for how to test and report
out issues of these archs.

> 
>     Arnd
> 

