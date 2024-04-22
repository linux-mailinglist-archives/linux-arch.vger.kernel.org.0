Return-Path: <linux-arch+bounces-3848-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA7E8AC39C
	for <lists+linux-arch@lfdr.de>; Mon, 22 Apr 2024 07:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72C411C20BFD
	for <lists+linux-arch@lfdr.de>; Mon, 22 Apr 2024 05:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87B61759F;
	Mon, 22 Apr 2024 05:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bIh8C5IH"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95EE15E89;
	Mon, 22 Apr 2024 05:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713763485; cv=fail; b=F/gk/clIifJ2rGeOlGvtDO+ZUmC3MtE/9r8VGj/1wmuKOdDEpXVttyT9bCBy3R/YCEMtoEISOwLLRfUfTB2G7RdaJYZ5WypRvRohwWaABsg0Ie71tJbyM+s/KdGm8++FoY1mjeW+19DnSHCcx0JxyJYhEMTo2M+6jQmvazys0Ok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713763485; c=relaxed/simple;
	bh=zyEwYN5+tGwj7XX3rM4gpvUU7Q5FjjCRAsFD3u0vgTc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TDsu+kNTn0Tey2ngV59wBZxH8vq5j1MbOAYZdxPQRa7qgqPrlZPCihEGqu6ZCu6aYEXoG18iozaP77M29m8tNwQErVtOl0lvzjhmszDD0vStpfC/UZLCj5Zj9xBJoG4i/P+Vf/B9pPrx8kj+d/VCQjdjDZ9ltyC01uVE0BGEQr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bIh8C5IH; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713763484; x=1745299484;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zyEwYN5+tGwj7XX3rM4gpvUU7Q5FjjCRAsFD3u0vgTc=;
  b=bIh8C5IHLA8vVnTGLFRsMaC4XX0mqeOewuWRaTHhMcnAl7DgmSN9za9j
   n+YqWt5nlR8H1mZvXbRiKsm4GsGR7WTGle7fYq1fhM3+hgwmZOBGt7R9l
   PIIS3Su5agatvmbagwnlXKugcPjUiUPi2c9IldTtdF7x+XNucHbF93yRf
   bnPgmPc4ecm/482E1C/2xzJoAukSSv3CBx1pNVGQXMgp5NNw7U9804KeB
   RsVRC/c+E/lUCrZbRPNzkOoqLTs7jjqjv8l2GUJ4wroLAHfPyQFOXx8rc
   NfpKpY+fmKIrpj5nOXk1IFF4FKx/3r8Y7cCqxzJRg1Xw4wWfaI18lYAIf
   w==;
X-CSE-ConnectionGUID: xSGZTWmGRzuhgYccHS494A==
X-CSE-MsgGUID: FwXL8jxZSDq2e+x+5cG7Pg==
X-IronPort-AV: E=McAfee;i="6600,9927,11051"; a="9403685"
X-IronPort-AV: E=Sophos;i="6.07,219,1708416000"; 
   d="scan'208";a="9403685"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2024 22:24:43 -0700
X-CSE-ConnectionGUID: L1/aRo7bRwSOOtW+3240kQ==
X-CSE-MsgGUID: UWiXMbtWTXmxqBO2t1u0Ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,219,1708416000"; 
   d="scan'208";a="23948542"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Apr 2024 22:24:42 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 21 Apr 2024 22:24:42 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 21 Apr 2024 22:24:41 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 21 Apr 2024 22:24:41 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 21 Apr 2024 22:24:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ch7mwOZxlW8nZ3u70k8rGD+kLlgjqNcSMEvYpjbUf6BqwHw2x3+HezzZ5mnxpLcSSdkcKFpMKXTAKCRCQq4RAkD53NqJ7eXN3VvByUy1Ity1NFzSy7+3bB5mTnX//a/4bROvO3R5FeV5zmOEh9eXh438OutcsreTAVNKxE1QY+6GD38Ewm64nDvzhkVKR6uCsb9g+s/Pz72YOcnNfP3WOyqFRX2wJvlreB+uUZ91oNpk4CFGkllPKXpMMklyT/l/ob2oubyvg8GcpCBejYboAlO9KzHFfuMbKff8IGy3cyTXGmblzrBcDk+yD0cwP0tDbfTBYxHKe9NKZFbqG4r/8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zyEwYN5+tGwj7XX3rM4gpvUU7Q5FjjCRAsFD3u0vgTc=;
 b=e8mNZmqnBpDxyM8lq1CgziRtOVHCOhYSezxy69M0qSCAzZuSUNycRVUbG27/R1xyKOa6iA65Q8iFHCt0QZMtP+bNMI8ZKBM36Y62UQEOpZ1l2XDc4U6qtmLsuynCr4o/gk1eLT7Kx2NxIaQEWm0BVKuYnt2k7A+ihjQ08pUuw3ghNdXtKVR4uduChCKXy7y/w1Ceenj/a1dSjYfs/JbuQofcppG9LkovX1JOQ/OTqvaqDstjWVMH1AcwYO3C/W8YizqJeuDpV9uMkyR9SR66UOAWuc9+O1dBgJXbJJTTClAr2XVLgr8cobHiU+0AH6jGbbkr8NpelPDSJymJG29fpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5751.namprd11.prod.outlook.com (2603:10b6:8:12::16) by
 CY5PR11MB6187.namprd11.prod.outlook.com (2603:10b6:930:25::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.12; Mon, 22 Apr 2024 05:24:39 +0000
Received: from DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::abaf:6ba7:2d70:7840]) by DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::abaf:6ba7:2d70:7840%2]) with mapi id 15.20.7519.018; Mon, 22 Apr 2024
 05:24:39 +0000
From: "Wang, Xiao W" <xiao.w.wang@intel.com>
To: Thorsten Blum <thorsten.blum@toblux.com>, Arnd Bergmann <arnd@arndb.de>
CC: Palmer Dabbelt <palmer@rivosinc.com>, Charlie Jenkins
	<charlie@rivosinc.com>, Namhyung Kim <namhyung@kernel.org>, Huacai Chen
	<chenhuacai@kernel.org>, Youling Tang <tangyouling@loongson.cn>, Tiezhu Yang
	<yangtiezhu@loongson.cn>, Jinyang He <hejinyang@loongson.cn>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] bitops: Change function return types from long to int
Thread-Topic: [PATCH] bitops: Change function return types from long to int
Thread-Index: AQHak3OZaQtUtvzCc06TYzDBL0U7LrFzv9wQ
Date: Mon, 22 Apr 2024 05:24:39 +0000
Message-ID: <DM8PR11MB5751439B2053D1AD07BB8AD9B8122@DM8PR11MB5751.namprd11.prod.outlook.com>
References: <20240420223836.241472-1-thorsten.blum@toblux.com>
In-Reply-To: <20240420223836.241472-1-thorsten.blum@toblux.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5751:EE_|CY5PR11MB6187:EE_
x-ms-office365-filtering-correlation-id: 893c935a-ea06-45cf-0a5f-08dc628c81d8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|7416005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?Windows-1252?Q?WpgoOS0uViW75RmxLSEW703bkkIq2I60/CVvl3zmLMHdxGshSur/i8xy?=
 =?Windows-1252?Q?N/a6QL1wHnYVPNNNfEvR5iJFaGbzecLwwtaebyRD222x5UfhU11C44tv?=
 =?Windows-1252?Q?nWTDJNZxxEJMPIxDIWP4I2sEaacb43Bo4tVgw2cnzqnPATSVOe2C0EDQ?=
 =?Windows-1252?Q?+OOvRLUYL6lqQDHCzGJppegoPP8IvanAyJKQCZAQT/kXFZi7CFy9Lb69?=
 =?Windows-1252?Q?E6xfG7HvLBXPAkoXskabl+kfTQsjz9W6gZANrXCs2VTg8MorSASn+Sdq?=
 =?Windows-1252?Q?eD3dBSKKEaVat0J8wMdVC6PP5/2vZBF+BrNgk5+kJSm6TtDCEIc9jtE0?=
 =?Windows-1252?Q?hxVCdFdZ7whn4R4cpH+2QQ4fimWC6YNmDoQnNprZQLKxOkYSKtZsCwn2?=
 =?Windows-1252?Q?JwVCXl3F8W+goyNuhMYuiH4rWzgeaSuwuHhSdcBRLiFhG7O+vY2zwjM8?=
 =?Windows-1252?Q?XLAuGhflbXFWSeX2/1Msm+Bjg7zYF32F0TEEWkqRfl7ixL8KtvEqGkje?=
 =?Windows-1252?Q?y8k/U2GPl/Xa76/YMCJJppc7k6cAkxOhHR7gagvN+FgHT97fo6aAoW9Q?=
 =?Windows-1252?Q?7eUdf34xG82ZRkRXd9wJv8/q+QnMgnZ3+biChOR4DekpWO3jDXYibaYX?=
 =?Windows-1252?Q?OZgxEt6SlznTFuq/gYPgQ8dxzOuMqXsm2Suc+C2CnMg2hv+WpAJskagJ?=
 =?Windows-1252?Q?aaVInYODCu9D0YEYofh0vyjkL7+jMYEGQ5Qtct6yQOLYrCxZpX279Wef?=
 =?Windows-1252?Q?s1QisvVG3VZjPxeUgcJrDbk3/YFYQqRseR+7T3p8uhtJIOeRXKb4YVNp?=
 =?Windows-1252?Q?jcTFhUJramMFkg0vwjRZ2RwD6nh/sNkGdHCXiCzqK1yyD+STpuWIGMKu?=
 =?Windows-1252?Q?4KV7z4CH3mPILiORCNegbBDr536z9I9WtSr26yTHDf1qlLlgHsjhmEcM?=
 =?Windows-1252?Q?nJj9l6++hBdkUN/N6uOEHRuTvGGcWVN3fNpQnJ55+EtKwF9Mxd4KVfto?=
 =?Windows-1252?Q?DEgMUEmjUEdRZ1nzbI0kzjQ/0INxZGhopWzUCia1F2Vd+lUguBc7zTom?=
 =?Windows-1252?Q?jmlnPndBE3niKxL+8DR2sWMTcvGdcol0Xxl3NS9iEokGZ6It0V7Xd/Nd?=
 =?Windows-1252?Q?wJTwT54TC6dw3Oxb9wAU2ke+AtRHKiqEv4oMsYLwrDCuwNSLSA2gtuQt?=
 =?Windows-1252?Q?rj6OtgwHFOCxu70oBn5U1DjeKF/rlU4jFsKblOgIZGLm7/NeM6oU2q31?=
 =?Windows-1252?Q?wA4p1KKvis7hTFxBZF+JkA9PFjj+9cXeR6ZBXS2nFl8FMxij153m6IW2?=
 =?Windows-1252?Q?yaaXG5DZZ7ZP6FDc/KQw3t2dZ/L9v7fB2CaPLEIjP/eKYNzKCyNW48W0?=
 =?Windows-1252?Q?vKhdSGHQB6yLydVTQ8Eg3ZTmuQ+5OgeIhDI/B0bxszbZXSCIQBALCScv?=
 =?Windows-1252?Q?C7/UwGupwPZ3jcdDf1wiJg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5751.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?eGCFFZXWuJDvszm0yAcd0sRxqvdLlos+0SwUpQPKw59m30W48l8kpyK0?=
 =?Windows-1252?Q?BnuzoEcXaAe27tx9Vax/UYAYDwd4AruWVT9NcJ16Pz5dCaTEmsgXC7Tn?=
 =?Windows-1252?Q?gpQu2p35tNZjlRK0QplGArVFFNsQn43Muc+F/eG1t8zMQ0kog3Vft7sv?=
 =?Windows-1252?Q?XfurpSWMf6B2v3LByUF4g7/xWIlpnwZPjM5CXjyPEEEwfV/GlelQDtFP?=
 =?Windows-1252?Q?hU1c7UU81tFL7Wcy2VKsi2iaoo1YL5ybwbh5dFYiYZhiuuUgr9Su9kRe?=
 =?Windows-1252?Q?gHmxbKQ7hSqkjlU+azI492lPQEmbyzdRvxVa6KZc/mRSdGRcgxutt6fd?=
 =?Windows-1252?Q?bAjuzYUr0yt9vRaj3RhDT9+F7rqXaiUB62Lk/awiTk3PjuR9NhGH234b?=
 =?Windows-1252?Q?QTMpbI+EdSF4OsGO616hq2z1wrNOsnBdpKw4HsopwtnMOvKnegidsU1f?=
 =?Windows-1252?Q?sXn95/u9y3mGnNLIxLXx3CO4P5DlGV4CZ5Avo6jMTxXZ7+y716K4arPY?=
 =?Windows-1252?Q?8VfopOxRf5jGX089rWhq9PNw22NpE4nCsNXY4YMLr9rAXlQzZX0YJBq3?=
 =?Windows-1252?Q?2mR41fo2b0dzGQH8pwfgsBALfxlaugT8FbAriYaRjiFEjAAEcfEofw4n?=
 =?Windows-1252?Q?qcg+kMfN4BR0gc1kgeNI9UXDFKzvYUE8QkrSpFyFA2JE37IkKi9t7rma?=
 =?Windows-1252?Q?3ciYcLz4ot1yK+/8zIcoLAHuSNw/fhksQpSJ9H1P6USEdA7NjV832DS1?=
 =?Windows-1252?Q?lX6Nk5wWjI8OS0ulrVELe/6JL6yPQaJRM6ZnWOw5jbjVETtTSEfe58eF?=
 =?Windows-1252?Q?EMzR4GXi+pL886hQCCjdmNrD3Mx3Lm1nyPyWbsDHQSqVeop37EhmzSK6?=
 =?Windows-1252?Q?2pv2xmk5tS3gupHzw+/DqX09BQ5aU8RSUbYO+DbHW1RnZIl2O/nqd2q+?=
 =?Windows-1252?Q?NEKYc3DcZhxgLz01KB+dNMwNnBWi2XTGaH4wE6Fjuhz6BHdZAvXo0eUV?=
 =?Windows-1252?Q?F4ofOmieAYR9IdspHhWIjDUdYKkLHaMSHNQemQ7OkKCYTDDAGDhTetm0?=
 =?Windows-1252?Q?jDSMK9YWOYC58WZiWzn/al6fuCmCIa8zxM2hGTyysRw/GI2kwIJzv4Ya?=
 =?Windows-1252?Q?ck3ze2cmKfrhqgl13SPHQ80BiPOTwfKmb0Rb4tGiRNBLK4uNHcx4JpmR?=
 =?Windows-1252?Q?7m6Mi6Fo4GDxPbdKzSLanlITdKq6u74bbf1ECygzmmAPBbbzP0FE6fVL?=
 =?Windows-1252?Q?ijxsVQFCmkgQGTE0qnvuAeIjmEPaD5BPNfapEH+rhuJz8X/iLvl5/iBt?=
 =?Windows-1252?Q?6ZMu9PJ4z40i//dg9i2vOQgDBj/ayybIY4kc0TMksYWwIwGDZchINYid?=
 =?Windows-1252?Q?cUVjaLNOifSvdG3yrHWIS8+niCzIJzVJYdH0+lFQ1g+snxqVJNTnaMG8?=
 =?Windows-1252?Q?gN7iOwPfUNO4RmMPh8WDrJM/gvGXBzvSKLC+YksVnomrUFgqnl4k7eur?=
 =?Windows-1252?Q?Umj8AouXJZmiAdO3HrHwTkLrdD9gxTHLcJfT9ZE4NPdLtFlrABdcv7tN?=
 =?Windows-1252?Q?CQ5qasd1vtCbWXO8Kx8p69sLgO5rsjZaSEWdDK+Jjqaw5teDawMTR8+R?=
 =?Windows-1252?Q?5aj/ZF8m/s6dxMPjskJW6r0B1sqPpDo3W8tSfCHVbJ1M2wR7e94zAY/V?=
 =?Windows-1252?Q?YHRTA1SQtjcTZ3qhsOhQx8x2jJdfA6fG?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5751.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 893c935a-ea06-45cf-0a5f-08dc628c81d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2024 05:24:39.2509
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VfuAtt42f59sl3f9MTdlLZQb10SLjqG6oHeyJZu7UyyerAK0cMEe+L5Jr54MU66O+Stz8m8IIUIMT0LklyLonw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6187
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Thorsten Blum <thorsten.blum@toblux.com>
> Sent: Sunday, April 21, 2024 6:39 AM
> To: Arnd Bergmann <arnd@arndb.de>
> Cc: Wang, Xiao W <xiao.w.wang@intel.com>; Palmer Dabbelt
> <palmer@rivosinc.com>; Charlie Jenkins <charlie@rivosinc.com>; Namhyung
> Kim <namhyung@kernel.org>; Huacai Chen <chenhuacai@kernel.org>; Youling
> Tang <tangyouling@loongson.cn>; Tiezhu Yang <yangtiezhu@loongson.cn>;
> Jinyang He <hejinyang@loongson.cn>; linux-arch@vger.kernel.org; linux-
> kernel@vger.kernel.org; Thorsten Blum <thorsten.blum@toblux.com>
> Subject: [PATCH] bitops: Change function return types from long to int
>=20
> Change the return types of bitops functions (ffs, fls, and fns) from
> long to int. The expected return values are in the range [0, 64], for
> which int is sufficient.
>=20
> Additionally, int aligns well with the return types of the corresponding
> __builtin_* functions, potentially reducing overall type conversions.

Could we change the return types to "int", instead of "unsigned int"?
https://gcc.gnu.org/onlinedocs/gcc/Other-Builtins.html says that these __bu=
iltin_*
functions return "int".

>=20
> Many of the existing bitops functions already return an int and don't
> need to be changed. The bitops functions in arch/ should be considered
> separately.
>=20
> Adjust some return variables to match the function return types.
>=20
> With GCC 13 and defconfig, these changes reduced the size of a test
> kernel image by 5,432 bytes on arm64 and by 248 bytes on riscv; there
> were no changes in size on x86_64, powerpc, or m68k.

I guess your test is based on 64bit arch, right?

BRs,
Xiao


