Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E71D34C12B
	for <lists+linux-arch@lfdr.de>; Mon, 29 Mar 2021 03:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbhC2Bfj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 28 Mar 2021 21:35:39 -0400
Received: from mga04.intel.com ([192.55.52.120]:9888 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230209AbhC2BfY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 28 Mar 2021 21:35:24 -0400
IronPort-SDR: BRoDK96CPyFbcNjiCvLWg45CcrNFuxzxn+q5jWwNKCmRDBayVKlN6KoMcyKDkwarh+nZmZbgrw
 rdarzxtR43HQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9937"; a="189204133"
X-IronPort-AV: E=Sophos;i="5.81,285,1610438400"; 
   d="scan'208";a="189204133"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2021 18:35:24 -0700
IronPort-SDR: 3OnYc4reE3mBx0xx2TBrBEdlwziLi7HjDKDFWRUBHfunsKIJDM1QQWrb+BVf58G1M5KJOojGGq
 lI3XkuczvN6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,285,1610438400"; 
   d="scan'208";a="606193074"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by fmsmga006.fm.intel.com with ESMTP; 28 Mar 2021 18:35:23 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Sun, 28 Mar 2021 18:35:23 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Sun, 28 Mar 2021 18:35:23 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Sun, 28 Mar 2021 18:35:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VbvUume1AMZG1bMZ0EK31cV+xchex/cexicm6ztwC/xZQYIxuWC3o4YUu7oHbxu/kHDEEmd/olcsjLAhiwq3Fhc6TViO/G1kPfyz5Ka+rVkb6thfa4HZO7qNvsKBMIss978mmIrc4tSSOumCgtDMARLObK9r89v7Y7S4wzaJEUZSqb3OShD+DrStEdzrbBZEj+PMEPmDSeefTN7NmVlB35fZzE8Fis/0D3kCeT4cxZqUWKkqnxZcyJOKx9xJS7SG7J2MdXygv01DECh8W77ogJXQxoLJm5pyK1NZZJw4cHPd/wKcGdDCQM81/PNEgrfHq0sR6UBUzPwlXx3giicIMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ay8TMmJ++2GJdBf7EWjPTAnf1cCb7gNzJ19byz4mjw=;
 b=YVzKE4WosVRut8kCQTTj//0akhjfIfLdr3SC/zO8EYIzRo14v+nIzzwakYtF5jg9ud6s0tKOyeT+KBiDQqOxF76CRrHWZhZgjv4HgZ7KEqQYRv8ajy8r9UgSDnZdBOhKUh+PgN5oEG0snHNB4/gkXt8mtWFpoO6ymY6j280eW+qqQtp+nQTR5GdT6q+5yZYTbSWMtTs6zMVPTBfeduCwzYekECwGNRlRshEG3kKCZi+DoA6RfX7XLxxpP3XOYEPF0scVyw+I1+h+Y8VD+5/EYafnBHN07rS5Tu4ZS9TxV3ECAom+dKzfKLWC3keo8Nl8ESAfz3OpPj8ff6MbCssBIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ay8TMmJ++2GJdBf7EWjPTAnf1cCb7gNzJ19byz4mjw=;
 b=u/DX/kYhvaEdHbMUGTBhNPannLaSs2aqRDefhuYJOx8lA/ZONkC9mEysKJnE+KwH2IjHkNftja78aAwafaR7E8gNsMHdrjIzHD3+J+lcX49p94nISQoVItvKvzdZBu7WyCxMsAZ6S5ZXkhnnag3f8xpqZNyQyU361husRYP8uwY=
Received: from BY5PR11MB3893.namprd11.prod.outlook.com (2603:10b6:a03:183::26)
 by BYAPR11MB3253.namprd11.prod.outlook.com (2603:10b6:a03:77::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26; Mon, 29 Mar
 2021 01:35:22 +0000
Received: from BY5PR11MB3893.namprd11.prod.outlook.com
 ([fe80::297b:a818:3bfb:f897]) by BY5PR11MB3893.namprd11.prod.outlook.com
 ([fe80::297b:a818:3bfb:f897%6]) with mapi id 15.20.3977.033; Mon, 29 Mar 2021
 01:35:22 +0000
From:   "Tan, Ley Foon" <ley.foon.tan@intel.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        "will@kernel.org" <will@kernel.org>,
        "danielwa@cisco.com" <danielwa@cisco.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "daniel@gimpelevich.san-francisco.ca.us" 
        <daniel@gimpelevich.san-francisco.ca.us>
CC:     "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        microblaze <monstr@monstr.eu>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "openrisc@lists.librecores.org" <openrisc@lists.librecores.org>,
        "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>
Subject: RE: [PATCH v3 09/17] nios2: Convert to GENERIC_CMDLINE
Thread-Topic: [PATCH v3 09/17] nios2: Convert to GENERIC_CMDLINE
Thread-Index: AQHXIkY9EWGkIZwlLUepcXMICy4iU6qaMsdw
Date:   Mon, 29 Mar 2021 01:35:21 +0000
Message-ID: <BY5PR11MB38934E74AF74D40379E46AB9CC7E9@BY5PR11MB3893.namprd11.prod.outlook.com>
References: <cover.1616765869.git.christophe.leroy@csgroup.eu>
 <85b1dc6339351cbc46d179e8fdb9dfc398e58303.1616765870.git.christophe.leroy@csgroup.eu>
In-Reply-To: <85b1dc6339351cbc46d179e8fdb9dfc398e58303.1616765870.git.christophe.leroy@csgroup.eu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: csgroup.eu; dkim=none (message not signed)
 header.d=none;csgroup.eu; dmarc=none action=none header.from=intel.com;
x-originating-ip: [42.189.153.48]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3136e626-5230-45dc-23e7-08d8f252eb33
x-ms-traffictypediagnostic: BYAPR11MB3253:
x-microsoft-antispam-prvs: <BYAPR11MB325308E3D7134732CEAD512ECC7E9@BYAPR11MB3253.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sp4Dol+Ce3nl3hU/fv/D/GUIKDOUypkeJE/zMbaTQm+QnbmSVuL0jjK/ZMXtf2p7SdDLd0pSfuuiImYjWC2pohxUpt1MyaTp/n5BOxXpfN/WBOGp7vCgEznkbRin7gx1gHK5syIi7vYCGx6bo5oW/nQregC+QI2Lc8qopP2qA9DfcDk3t/JvlXYMZq4TEgdN/mJvI6XjsorSmY5zyom8Avm/HFtuAaNjka1tiEhIxIcZtUHfq4l9WC7+J8KYLdl5+olfQCFc7XfDN1T1MZmR4UU/UjID50WgHr/PtQ8N6gYizCrfwNDixADhfDSQmwqUI7NDVT4gWSrBU2L7yDNup4v7Yen8cG9V88vMkCYCborUb5Qdlz75Vsvyu5KuZNQ2okqrZO6KQOXbl3Q128Z8hMeMGBYzb6U58EGDrj1E6cStukiiNcoI0lkl5pLZ+yN7XKJb0yPfvQAC0nSLee/lB67769TkYbOvzbF3t6xeeG6FaLrn+6Fj/1YuIOjE3EZWL50BepT7041SZs3mEYdPjSb4c6g89nDqa70MC1WmyfoN3C38OC8qu38D4qSZqlMzrMkf2AsBvH+HkXAXJLE7g/ve9C0e351D1SjDMD7041qURhXVi7FyjSKfVIDn/IS6p73+6cVBrCMoSjHQPrx7A941nQU7qd0TUDdLvhlRXmqOh3fDsFehe9OH42eV9GNu
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB3893.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(346002)(136003)(396003)(366004)(376002)(8936002)(38100700001)(316002)(83380400001)(54906003)(76116006)(66946007)(66446008)(5660300002)(8676002)(66556008)(64756008)(66476007)(7416002)(478600001)(4326008)(110136005)(53546011)(2906002)(55016002)(9686003)(52536014)(86362001)(71200400001)(26005)(33656002)(186003)(7696005)(6506007)(41533002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?qG30XGx1ArCsOPyfjuxDCzCGIxsdK9sVdtWTrycEB0bBZl1DAzQSe6MJaEOw?=
 =?us-ascii?Q?fKwOr7ob9iSZmk4lSHK+dVaRvtzc1/vvfzbQuvGjjq8Acx2Uzjj4QOCsAMA4?=
 =?us-ascii?Q?6DobvsLMhKufv6PsBcV3FoHHUqhSWwUzakvMWneHFqoyBFMiM5DcQPkxEM+V?=
 =?us-ascii?Q?eoArLPer2IGntmEqs8mNnmHIWABfd2uDS5oWEMD13fIoX9Schn07FRRHAotI?=
 =?us-ascii?Q?RXTrVZaAFm1qOg8y4JPH/YtfoxlbbS1lgxPRBi4ny36JeHdFCW77OFP1D8ua?=
 =?us-ascii?Q?lSB0vBoDd2qIhw8PXL3tiYfAkmy0ET/r/MeWMvWtX0gjZFD2rckSu3fd/4yZ?=
 =?us-ascii?Q?6d6P/njxZCCFWAyZl6DFrlJClVFIf2Lu1DP7hRNLwM4eQuz3fqzEHDed87Lk?=
 =?us-ascii?Q?ZvDH5sav+GwpUUjw1RAbwi16nHC5xwxiL1uiYiamrbDrv/ra4h2lXmCmF/yk?=
 =?us-ascii?Q?TzrhiYhxuYTgLsRxNJ5HZv7WzkEigvdq0QsCLlqyDgdkj+/0z/cLrVNeb80W?=
 =?us-ascii?Q?2wSvn8REbgHtejy1n3/b3om8NSEe+R7xgkTseEnFIbhj+aFJe7qKZdmBkiY5?=
 =?us-ascii?Q?do1zP2icP3vdavYhTj81JRCeI5R1Y13JoAJpEQnx/Cu9tdAQJx9fhM8luiyn?=
 =?us-ascii?Q?6mV3ygmDJvjUTGSknoQWLBNjAO7C7lNzb0t0MHV6qNi45QV+YMyMBpBsuiMp?=
 =?us-ascii?Q?AK0rEuaMuYOvSZZwWdMjwLjULKPtX65KFgs7u0H4QZG+lIyfESMcu5K4mKfO?=
 =?us-ascii?Q?ljfN4MHne8IAXdoQUU8SvOodGvEAnDT9H1PJetgxUfiC7oa04tEGtEt1KG7c?=
 =?us-ascii?Q?aia5+lQEMGpVKDQPNDi2d0OyKUjRJ+J1uth0georYToydJMdG0wIY4rb5xgB?=
 =?us-ascii?Q?HXQJUFQfhTpHiTUAMD1fBoD9QkAyKkRiByUTj5AyqM4vWkUnO7K4+XZpwNVk?=
 =?us-ascii?Q?LjomyGnfjOrMIfrLfAIysCBW3G6xwqnpWtPjgV9mcvUMDP9+JDlNMmaKQlEp?=
 =?us-ascii?Q?+x9xQ/mpCxZu0BeG/6dE9aBUXXPxCI4MSTFbcnMKDa+snCvmFI+KMamONbGC?=
 =?us-ascii?Q?JU6yudXQYXtJqOUIWiSTlokL9qu1xx/vgyDTMcL8u2ArLjpFJbp2ScplBcPT?=
 =?us-ascii?Q?S2lWf5mcn0q83OUpHuGioRBeopGLkqtbHsweMOEpW5EDjXkz5U/gBcGfkI8J?=
 =?us-ascii?Q?00xd41Yk5sgyWZfN1omxCwnXbq2CVn2RXoaeI9MP2NYS5GKpAuj4U4wm6Zsd?=
 =?us-ascii?Q?0FbDXcF1H84zchNGCeIKFBgW6tI18NFXDiOExz+Ra5daCgTs2LyAEDCfdxMR?=
 =?us-ascii?Q?J2gtbbxgIAD8YK/c+DHzOsrf?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB3893.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3136e626-5230-45dc-23e7-08d8f252eb33
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2021 01:35:21.8933
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EORUlTAMEmVGyPJ9IXxT10ifW8qQlyWaELYLStNmnpr+Szh6mpMwUAPTHgqsnwEvoe/BmzqwOe5+1m1EIpQbUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3253
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



> -----Original Message-----
> From: Christophe Leroy <christophe.leroy@csgroup.eu>
> Sent: Friday, March 26, 2021 9:45 PM
> To: will@kernel.org; danielwa@cisco.com; robh@kernel.org;
> daniel@gimpelevich.san-francisco.ca.us
> Cc: linux-arch@vger.kernel.org; devicetree@vger.kernel.org; linuxppc-
> dev@lists.ozlabs.org; linux-kernel@vger.kernel.org; linuxppc-
> dev@lists.ozlabs.org; linux-arm-kernel@lists.infradead.org; microblaze
> <monstr@monstr.eu>; linux-mips@vger.kernel.org; Tan, Ley Foon
> <ley.foon.tan@intel.com>; openrisc@lists.librecores.org; linux-
> hexagon@vger.kernel.org; linux-riscv@lists.infradead.org; x86@kernel.org;
> linux-xtensa@linux-xtensa.org; linux-sh@vger.kernel.org;
> sparclinux@vger.kernel.org
> Subject: [PATCH v3 09/17] nios2: Convert to GENERIC_CMDLINE
>=20
> This converts the architecture to GENERIC_CMDLINE.
>=20
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/nios2/Kconfig        | 24 +-----------------------
>  arch/nios2/kernel/setup.c | 13 ++++---------
>  2 files changed, 5 insertions(+), 32 deletions(-)
>=20
> diff --git a/arch/nios2/Kconfig b/arch/nios2/Kconfig index
> c24955c81c92..f66c97b15813 100644
> --- a/arch/nios2/Kconfig
> +++ b/arch/nios2/Kconfig
> @@ -90,31 +90,9 @@ config NIOS2_ALIGNMENT_TRAP
>=20
>  comment "Boot options"
>=20
> -config CMDLINE_BOOL
> -	bool "Default bootloader kernel arguments"
> -	default y
> -
> -config CMDLINE
> -	string "Default kernel command string"
> -	default ""
> -	depends on CMDLINE_BOOL
> -	help
> -	  On some platforms, there is currently no way for the boot loader to
> -	  pass arguments to the kernel. For these platforms, you can supply
> -	  some command-line options at build time by entering them here.  In
> -	  other cases you can specify kernel args so that you don't have
> -	  to set them up in board prom initialization routines.
> -
> -config CMDLINE_FORCE
> -	bool "Force default kernel command string"
> -	depends on CMDLINE_BOOL
> -	help
> -	  Set this to have arguments from the default kernel command string
> -	  override those passed by the boot loader.
> -
>  config NIOS2_CMDLINE_IGNORE_DTB
>  	bool "Ignore kernel command string from DTB"
> -	depends on CMDLINE_BOOL
> +	depends on CMDLINE !=3D ""
>  	depends on !CMDLINE_FORCE
>  	default y
>  	help

Missing " select GENERIC_CMDLINE" ?




> diff --git a/arch/nios2/kernel/setup.c b/arch/nios2/kernel/setup.c index
> d2f21957e99c..42464f457a6d 100644
> --- a/arch/nios2/kernel/setup.c
> +++ b/arch/nios2/kernel/setup.c
> @@ -20,6 +20,7 @@
>  #include <linux/initrd.h>
>  #include <linux/of_fdt.h>
>  #include <linux/screen_info.h>
> +#include <linux/cmdline.h>
>=20
>  #include <asm/mmu_context.h>
>  #include <asm/sections.h>
> @@ -108,7 +109,7 @@ asmlinkage void __init nios2_boot_init(unsigned r4,
> unsigned r5, unsigned r6,
>  				       unsigned r7)
>  {
>  	unsigned dtb_passed =3D 0;
> -	char cmdline_passed[COMMAND_LINE_SIZE] __maybe_unused =3D
> { 0, };
> +	char cmdline_passed[COMMAND_LINE_SIZE] =3D { 0, };
>=20
>  #if defined(CONFIG_NIOS2_PASS_CMDLINE)
>  	if (r4 =3D=3D 0x534f494e) { /* r4 is magic NIOS */ @@ -127,14 +128,8 @@
> asmlinkage void __init nios2_boot_init(unsigned r4, unsigned r5, unsigned=
 r6,
>=20
>  	early_init_devtree((void *)dtb_passed);
>=20
> -#ifndef CONFIG_CMDLINE_FORCE
> -	if (cmdline_passed[0])
> -		strlcpy(boot_command_line, cmdline_passed,
> COMMAND_LINE_SIZE);
> -#ifdef CONFIG_NIOS2_CMDLINE_IGNORE_DTB
> -	else
> -		strlcpy(boot_command_line, CONFIG_CMDLINE,
> COMMAND_LINE_SIZE);
> -#endif
> -#endif
> +	if (cmdline_passed[0] ||
> IS_ENABLED(CONFIG_NIOS2_CMDLINE_IGNORE_DTB))
> +		cmdline_build(boot_command_line, cmdline_passed,
> COMMAND_LINE_SIZE);
>=20
>  	parse_early_param();
>  }
> --
> 2.25.0

