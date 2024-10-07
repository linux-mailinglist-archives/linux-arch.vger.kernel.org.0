Return-Path: <linux-arch+bounces-7778-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA626993400
	for <lists+linux-arch@lfdr.de>; Mon,  7 Oct 2024 18:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDF95B258F8
	for <lists+linux-arch@lfdr.de>; Mon,  7 Oct 2024 16:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E201C1DDC3C;
	Mon,  7 Oct 2024 16:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c5uusDup"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24F81DD9C7;
	Mon,  7 Oct 2024 16:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728319814; cv=fail; b=Iw3L3sVlnngK2mAYmAZvQSaD4SLPYh1Qt5pBRLh9TP+M58JUuWZQB7zjvcLSmHTt+afADg8LQhCfBJwPA22jAtJSn8JsaQ32kOafONs9FirDUm/xD+jfYDUSSw7uZAns0UZnWv3VBiivh8S3IlxTIWblFD+fhj0r+2wesqIMSGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728319814; c=relaxed/simple;
	bh=OFwAoyfO0+EhjwqcMNMAz5GU9sA56PRKeGzx1ZDcqg4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IvVcu7IeQjGeScjA2LsgRtiYO0mudWwmom/+j4dDWwxoP3NgjTMTarNliK/K4qWhqUCeFsMNkUxKeAhegMqZ8Gj3LcBKc8i7MY6TvuyJIYJ52xUqnlGjKdEgQ4qUKOSYPw7HDfBbhzPV59G5t14oW77dr1moayjvn9zQZoWLl2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c5uusDup; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728319811; x=1759855811;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=OFwAoyfO0+EhjwqcMNMAz5GU9sA56PRKeGzx1ZDcqg4=;
  b=c5uusDupTF2m52Q7ahRKTtWE3o8rQ76BcPjP7sPeJl0Vf+mQnhy228Yd
   iWnLtXjcUa/Y26/hGChBpPWEQBuUXa9WAzxyWohCzOVWFTPRJANYe/E80
   nVONxWohwYWOYf/UadQPElQdFtt9cahkA89EhI/OYmh/SmI6MLhNsw/zq
   srtNL4jVa4HGN7lNf4r+VsHQ4+IzoEuip2cdxgI16y4FgRzLp4V3I3RdA
   ON4cuZMaAzXaLKMGjJVJbYc2HhePZlqt3e7tmKNnR21Wjtkhxe3QB77c4
   Pp9ZEwv5z1N2mAsOuoZ2NHS+9hMOa4Fnc/KrSR4G4KTbO+vWeCRk+vLzp
   Q==;
X-CSE-ConnectionGUID: cXScj+RLSDuGYz+sgDyUpA==
X-CSE-MsgGUID: Hq7gpqTVRsGByzr7XF+Kzw==
X-IronPort-AV: E=McAfee;i="6700,10204,11218"; a="31180861"
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="31180861"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 09:50:09 -0700
X-CSE-ConnectionGUID: RpnXwrAsQp6joNdZetdWBA==
X-CSE-MsgGUID: i3/+o4y3TD2Jd5KJsUY2xQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="79533867"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Oct 2024 09:50:07 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 7 Oct 2024 09:50:06 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 7 Oct 2024 09:50:06 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 7 Oct 2024 09:50:06 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 7 Oct 2024 09:50:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DEi6yL2VwmgtqoP9Rq3143cudDfxbSl8HjnqPhPHXxx415LkRYCkfPRfnMFkol5kb2YY4g+9aTz21H2dJh0QRIrjKFUa1SG5t4boA+jTgohRbyHR/ZcBM5hKyFt6+OTUkb/WipG8AVwkt4fJfu73/8jYaQ1CbgBgtdyN1Oi7kvMprD8NVMuEV6Xi05r2SypXImtZkQ2vMDzaLMAdh2v/JCDX/1O3hIfIDkb3JG+N/fZd0WDkkGXEOefPpDFJsoffC8Yo+kqxFz00Wmdr0W8/n792/V9TB7CrG1fWOFRS7H1uE4G6Cb3rttQCDe4IVi9BE7XndzkcC9Au+eBOo+Vx1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dxTJLH+QLd1iiZVOit0S6F5Rq6bCDSu1W5qK2ECbVg4=;
 b=gGn0VbW1iD1c9blM4KBRv3Pw8MA//BMbm3TCLGp/POqUFLtD4caM7rBr9i7uHo5Mf0VTIf13jLFRE+c9UTMPIrdxliJ2IGNGx5jNTm+LiyR7nJjePRoc4qOnrB/4fsHn/dGX4EgR3h6z5TvpyNLykDoDPRS88mpkm6bRWH6O6jpi3XAWDIWP1aqK0+5S8+lS8ahepystVywuIpOemZ3qInKUpfAgi1poPV1PthiAzkYHskKshwys0tkHy3TToOvRVm+S9I7likb99KvPOZ5OFfBxjF+SjO0xURezqSMKSHMI/9Gtk1wBOSX2KpGQTUVa/KZ8AkNot315oeT1y6qkhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by DM3PR11MB8713.namprd11.prod.outlook.com (2603:10b6:0:45::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Mon, 7 Oct
 2024 16:50:03 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44%6]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 16:50:03 +0000
Date: Mon, 7 Oct 2024 11:49:58 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
CC: Niklas Schnelle <schnelle@linux.ibm.com>, Brian Cain <bcain@quicinc.com>,
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz
	<luiz.dentz@gmail.com>, Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
	<mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Dave Airlie
	<airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Dave Airlie
	<airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Thomas
 =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, Rodrigo Vivi
	<rodrigo.vivi@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, "Maciej W. Rozycki" <macro@orcam.me.uk>,
	Heiko Carstens <hca@linux.ibm.com>, <linux-kernel@vger.kernel.org>,
	<linux-hexagon@vger.kernel.org>, <linux-bluetooth@vger.kernel.org>,
	<dri-devel@lists.freedesktop.org>, <virtualization@lists.linux.dev>,
	<spice-devel@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>,
	<linux-serial@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Arnd
 Bergmann <arnd@kernel.org>
Subject: Re: [PATCH v6 3/5] drm: handle HAS_IOPORT dependencies
Message-ID: <hd6o7i467etrkgjxajfr2brsdi7gkmzm7lbcwpcgljueayh3v6@6sxzjr4mowve>
References: <20241007-b4-has_ioport-v6-0-03f7240da6e5@linux.ibm.com>
 <20241007-b4-has_ioport-v6-3-03f7240da6e5@linux.ibm.com>
 <3wh4nsirm5kjapft47oe3gaqgzdjwlhzku5lrctb4hhfjxicv3@n2sow3o36chc>
 <c58ab639-f0de-4cea-b745-13e9cfe0e588@app.fastmail.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <c58ab639-f0de-4cea-b745-13e9cfe0e588@app.fastmail.com>
X-ClientProxiedBy: MW4PR04CA0331.namprd04.prod.outlook.com
 (2603:10b6:303:8a::6) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|DM3PR11MB8713:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f791c8e-80da-4dd8-8e16-08dce6f01729
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kl/i8TqfVLPYSdBOw/17ehhNWApAJSi4St7jDYsWJa4pHDqKv5NiiAPtb0wE?=
 =?us-ascii?Q?7r1eG+VdLCbqCuebTNPWaLJiw8FGjrzFidBnGO0jZaU2e9Ai5rSR6BdUR9JD?=
 =?us-ascii?Q?PhNkRXp/405+V7xGefueQyrlE9j2ejfno1lUhJiMfs6uTQNw6ufZPK0nQNQs?=
 =?us-ascii?Q?hCGv2a0IIbKRSAl9/jAhu45jfJeO80pWFhcsRyzf+BZ5HfX5ugg7Qoo+kn13?=
 =?us-ascii?Q?VOWWt7HD+PsjtbpltUkbcx3670jHpmwXkOh8JdsJ9S+nTIsgCH7r2wQ2X7pL?=
 =?us-ascii?Q?PRNajphFm5bYo3jCnCZtzQmbwOElH5qU7b44J6wEJ1rQusoyPPpKj2IFNL4r?=
 =?us-ascii?Q?2uUOvZemLcwVymx2j8Ri63TL012OC7D1PBepWqvDeBQxUFFAh2aGmrhDKc0q?=
 =?us-ascii?Q?abQ2uWoCnm4yvDjvl0kOsT+BcKyOsPWmP3Xk9O2WU0MVeWaesgqUY5YPbp8L?=
 =?us-ascii?Q?SWkzoZJWMEd+EGvhZAnfF1/R0WV+W4+BYz9V/KjqycUvmpa9PrOJ8VJOFNNL?=
 =?us-ascii?Q?wW+uPC4jArhSUI5eKz3ecOMJ2dqjaJA5MvSfDJkc0/Mvx2gIhTOkZjzT7+/s?=
 =?us-ascii?Q?L7aapfxyROYpjY14AqB+NJu3IqDGYevRrfl9KU9G/oSal38A3ZK5fSSN3n9+?=
 =?us-ascii?Q?ai6SzPC2Q6mQl2XzVN6HcIgFoz049AdZtdsKcEXqYZCPuhECx9lRqCLXjvle?=
 =?us-ascii?Q?UswaplGBzqbciC9PssMgNgLVzAKuF0oGDI9G0/CB3IGUJ4VG0sLZyTUNhfg7?=
 =?us-ascii?Q?YH05dEiBDxluwtQFg5eupJYykmeDXZ3tT/0qqK8RtE6cnhfF2/WZmBtBQ+N9?=
 =?us-ascii?Q?huUArjYVZeBdCyleCUYJNXM7jKKlfaI+KwpFVtNF1Sf8fczJfRCia6Z30I3r?=
 =?us-ascii?Q?vlJUBsb+9Wa6Vf1mrdicaoCHVaoryP5v1IM0AZh7+O+Y6lgAZEU8Cp27uqeJ?=
 =?us-ascii?Q?rkj9G1J4qcJpL/MeXpn1iahnlxGInQyLj9quTisG2j59HNAtpb0dT1iqKhaW?=
 =?us-ascii?Q?uCFNiTHz4lhS2uM+vePhZCzaBpaxvRox33gQ21Xw7JcB+piBDSXL24KMAXhP?=
 =?us-ascii?Q?mrl4dqf+jiwnIhp5XbtMuZxfpMTBjROBb6ElmV/EHGkF/1dzalWpTsww1+bC?=
 =?us-ascii?Q?fbuc/g7N7ps4VCDOHGigKx6hvDaDDMskjmn2KF9iI/ENWmm2Oh4NItnbEBhs?=
 =?us-ascii?Q?N+mzCHum+4D+PESaGPx5cB2LI+sXthrUfDHnUx1mMKy71NbVQKp5X4Lki2T6?=
 =?us-ascii?Q?QPwELGw/dIQr3aJGTA4uLwhryKITYHszRCf2bf9dCQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IFXJtJJZy8Z4r6k1khdCvtTYPnZdu+x4fCeSaaUrDkohviVNnZ3wHjsOZ2VI?=
 =?us-ascii?Q?BzGvHwfueW2OxZuh0wpCoKonAZT7StEtnUhFL/0YeGD2WNM1pr15wXzzwzT0?=
 =?us-ascii?Q?79kLz1e48vnHT+qJOe9eqxh+4V5yIPi/8kF1wRI6KU5BMTpZLFPyegOmRZf4?=
 =?us-ascii?Q?nUYtWY0fAZ3XQAssgYhWGmU1YHohNjA9/e+0tBSqbgWxAGoV6nTAQ6m1PDrt?=
 =?us-ascii?Q?ps7WWDpJWdfTq9zUDtg4hE2bGY9OEPt10ADJGYw5fFEDFoh+qXNoCp2MA9Q8?=
 =?us-ascii?Q?8/zdKYJq6ddVHc+ZvQP3TLpAcgo2XW2KhCz9z5cdC50oa+UZ5xCYRV0julct?=
 =?us-ascii?Q?E5/fxcZ+s3JujGlVIet4ncBJkZW6sqXvIpEpUdHcCk1efywW6t0B/t9tb3oJ?=
 =?us-ascii?Q?G2CnTJuytRAAp9lxYWTOdCJgAKpIj7f6uRwH442TqqT4dDwsqun8Be4VyWyu?=
 =?us-ascii?Q?Ycf11S3WQPx3pOgN1M1RH+wl5VzUVkmM5Zyfr2wfaJ15ypJgWC4q4+OwLKSq?=
 =?us-ascii?Q?w1/c1T5lZDDJ9yLSwszlyChhluxKKtKZUiSGAt6vukZwMPk7DS1eG/zN41nw?=
 =?us-ascii?Q?XHlzVBAgAv2SRYKzYf8iIHnDPw+ywReRnJAi1rzVIvWV7gx/x3LAIeBNry5m?=
 =?us-ascii?Q?E5TaOs5wemJ8nwc2eb7X6DQ3SIIXpgSKWZagob8qvi8LV/IzDGJJHUEAQTMj?=
 =?us-ascii?Q?9nPjlsq2dWXdtFWdNyOy3jmGRWEg4PvFN4YsZ2L+wCt7eXaxnn46cYlwlkWO?=
 =?us-ascii?Q?IUVGRM5Q9bQe1cuh9oIiTfBrcaGA/K132TQVA9J97CFZiCUtr1Djgyo0YPaL?=
 =?us-ascii?Q?YiLdA1cGNxPoSs0elaZ63bLxfkZUFw85vBGT280QqqrDY6B3UM2FvUY5WUxk?=
 =?us-ascii?Q?8hmgRk/x5ywWAlGm0jl4ImKPON8mLUbkUIkkt3QS03cRthhmOwxOOp03kN3g?=
 =?us-ascii?Q?bNsko9FcAIFLcGN0XjML0167N2ZVFwojfPzp9n7x1gXCFM92mzPGk+B2aLIQ?=
 =?us-ascii?Q?0NG0TG7rkQV8REhgMcLb2LP4SvhGfgyG+8RTUXEM14dpl+WanG2iM8ta+NKy?=
 =?us-ascii?Q?pc40GYeBT5dFHvxxPXOY2HR0H301G8HNyH9imy3y0qpUSyLzG689VcnSSvRA?=
 =?us-ascii?Q?PHwRRCHSjSBmJiCdeF5XY2IYZEdmDqFl7ELDTPAeQSeHsja/pyLU9wg46G1U?=
 =?us-ascii?Q?Vhqm7zKqq4MOOgexXn/jIU2jsVFBUZ6AxsadraQRY/YACbt7QHu1kaZhGRtw?=
 =?us-ascii?Q?C+0Oc3kLQldl1N16dehMFCEUhWnkYuXFu3YDSHRwhDiJEf/q6J2BcWPzTVV9?=
 =?us-ascii?Q?kTtLkJESIHrSDl49mdzM+M3bFqMjalmCgGlBjEpgq56Whe4KN9RG0swhXc8X?=
 =?us-ascii?Q?RNnXl99Chrv0m23JwXVwxmGbhXWw+FFVj5vForgsRT1CdUUwKwGW59WWWHOo?=
 =?us-ascii?Q?X7H0jX9qOJVR84dcGfphJUXCi8mQpJFR2DI5vJdXcZOo8VBLfhXpB/kYydFu?=
 =?us-ascii?Q?BQ/h8wCiTsbKteVtoWlxrXHSvKb+2u8o3/ECajkQX4i7vbf4UGmjhkPMi28U?=
 =?us-ascii?Q?NWT67NRzJOGAV60PLv9OjTxYuHX2tOY+uEUQTH0Jytby53/dPfSbF1Bg4OFc?=
 =?us-ascii?Q?aQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f791c8e-80da-4dd8-8e16-08dce6f01729
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 16:50:03.7339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SeUwTSqQi39236NRy/iCgObo/VXjmTH+JZC0SO7an2TPq901kNPa1fimxXlzu6gQeaQGCx6NmbmiXRdT+lO3BAzJYeea4bY9UuxTZOV4FKM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8713
X-OriginatorOrg: intel.com

On Mon, Oct 07, 2024 at 02:50:11PM +0000, Arnd Bergmann wrote:
>On Mon, Oct 7, 2024, at 14:39, Lucas De Marchi wrote:
>> as an example:
>> $ git grep -lw outb -- drivers/gpu/drm/
>> drivers/gpu/drm/gma500/cdv_device.c
>> drivers/gpu/drm/i915/display/intel_vga.c
>> drivers/gpu/drm/qxl/qxl_cmd.c
>> drivers/gpu/drm/qxl/qxl_irq.c
>> drivers/gpu/drm/tiny/bochs.c
>> drivers/gpu/drm/tiny/cirrus.c
>>
>> you are adding the dependency on xe, but why are you keeping i915 out?
>> What approach did you use to determine the dependency?
>
>I did a lot of 'randconfig' build testing on earlier versions
>(and this version) of the series, which eventually catches
>all of them. The i915 driver depends on CONfIG_X86 since it
>is only used in Intel PC chipsets that already rely on PIO.
>
>The XE driver is also used for add-on cards, so the drivers
>can be built on all architectures including those that do
>not support PCI I/O space access. Adding the dependency on
>i915 as well wouldn't be wrong, but is not required for
>correctness.

ok, makes sense. I missed the indirect dependency already present in
i915. Thanks.

For the xe part,

Acked-by: Lucas De Marchi <lucas.demarchi@intel.com>

Lucas De Marchi

>
>I also sent a patch for vmwgfx, which can be used on arm64.
>arm64 currently always sets HAS_IOPORT, so my patch is not
>required as a dependency for [PATCH v6 5/5], but we eventually
>want this so HAS_IOPORT can become optional on arm64.
>
>      Arnd

