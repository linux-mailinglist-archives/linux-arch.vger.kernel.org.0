Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ACBA7D61D1
	for <lists+linux-arch@lfdr.de>; Wed, 25 Oct 2023 08:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbjJYGuS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 25 Oct 2023 02:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbjJYGuQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 25 Oct 2023 02:50:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 248C911F;
        Tue, 24 Oct 2023 23:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698216613; x=1729752613;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8CWOhgW0WpESHioiS7JkCgnZR5ZTxlDsqflhybK46NU=;
  b=YOPNQEgTVKxq2bQfpHIeLcwcyRln6qSqu/nxYfgBD/Jxeea5VKjZpidn
   wpw4NjrUG8KZsFcxc7cUm/v470z5pBRA0WSrRNL+dmTljRQnb+KOscfkA
   EKJ1DCM8ZSh+AjD8liiOyhpNJ+eHBzwQgfXQdnItKUZ59/umFdT3EDCju
   AN7la0NdwACY0jmV2NriEbwt2WFBWeutiEo9aiKMC+bjdZ6Jj6lrUjfAj
   fF5f8f14FrGSmZ81Fc7AgohsrSo7uej8cATQFq2tf83Y99Bp5x8iRMh1U
   zn7HiuWlilFu/JZdRTmanVBu+PDKRv9HCE93cOmqWceEjhtXSD+yPjVZO
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="451474186"
X-IronPort-AV: E=Sophos;i="6.03,249,1694761200"; 
   d="scan'208";a="451474186"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 23:50:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="758774881"
X-IronPort-AV: E=Sophos;i="6.03,249,1694761200"; 
   d="scan'208";a="758774881"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Oct 2023 23:50:09 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 24 Oct 2023 23:50:07 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 24 Oct 2023 23:50:07 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 24 Oct 2023 23:50:07 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 24 Oct 2023 23:50:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hKSyem1ns538keBMmpQXEniXcT71ZWTiyRbPHybuB0Gg9DkBBwsGyy3xaGXRt6DKXNSG2WtAS6vlS55axYdm0QRged4ZYX0d57Dn/vYDoyscgT59JnfECwZTqgD0IQk1ZF1aCW9jEobrk+Lfn0/htGPpvjpD4Xn1lgmtSWFBPU/yAgv62MZHP7hvu+sJbZvLT9Ip/HEEu5XVcr889O+TS6A6JnMy+aFHyA9QJA8kQRN5MiBH2Z0uIKm2MrDxVycl5cIgHPOVYNaGt48pvDZ//QN5QqFX760fpUAlV0ABeIiieadzRsTBnSyA4+hxW1/tGcRO2CBkGcFplgobTb1qyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ut9yjbvxS5j5fGbHbhbOnwXAo0qgIm14tRsgYD/NPnY=;
 b=WIh+JmrD+L6vD4cChnNK/+hnjCrmtappHgMX2aMnnMXs1ZP3BeC6pFNleS/vhNM2JmolH1Zu/l08J4Um0TK2Z+gXVfylyr8fuye7cgChHDuHBSDqxjFikJ4ABkUXCOzTC3phOoJgrsrFOjMeur7mobqShf1xOsdjFrzdPyGTyjp15Egc7cE/iKdTYtMxm9zEP5VHZZ7omSz1XaSfWUGoceVmDAP3bxp5n+JAL6nKkub8mzL8FWNib0lzajwVYn5B79aZCOfaKmqf0YsbsHiFZgnT0e5LaRKcJj7yWx6NPuEz2THkoF2YQKCntIGDlNGHw0mh9ObIhCYBZg76H4jKig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5751.namprd11.prod.outlook.com (2603:10b6:8:12::16) by
 CH3PR11MB7772.namprd11.prod.outlook.com (2603:10b6:610:120::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.33; Wed, 25 Oct 2023 06:50:05 +0000
Received: from DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::d070:1879:5b04:5f57]) by DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::d070:1879:5b04:5f57%4]) with mapi id 15.20.6933.019; Wed, 25 Oct 2023
 06:50:05 +0000
From:   "Wang, Xiao W" <xiao.w.wang@intel.com>
To:     Charlie Jenkins <charlie@rivosinc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor@kernel.org>,
        Samuel Holland <samuel.holland@sifive.com>,
        David Laight <David.Laight@aculab.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>
Subject: RE: [PATCH v7 2/4] riscv: Checksum header
Thread-Topic: [PATCH v7 2/4] riscv: Checksum header
Thread-Index: AQHZ6yms6aorkSEK5k6453Q63ctFM7BaOtGA
Date:   Wed, 25 Oct 2023 06:50:05 +0000
Message-ID: <DM8PR11MB575134C301E7E17E72281CFAB8DEA@DM8PR11MB5751.namprd11.prod.outlook.com>
References: <20230919-optimize_checksum-v7-0-06c7d0ddd5d6@rivosinc.com>
 <20230919-optimize_checksum-v7-2-06c7d0ddd5d6@rivosinc.com>
In-Reply-To: <20230919-optimize_checksum-v7-2-06c7d0ddd5d6@rivosinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5751:EE_|CH3PR11MB7772:EE_
x-ms-office365-filtering-correlation-id: 81a6e41c-cb3e-49bd-fdc3-08dbd5269ee2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0G5O4QCxAhLRMXw3MxEpwyuMlv0US9UEwUsuACUjqg/URne6Us6KzrrY5tFQnGxMn0MxXU4NXrZO7UeGaYlFVPVdD85fskrL7ZjBf4oGn4NIyaaskfA/qHagWYVV+3/MXk46mMx1QaTgDbEz9HqqxhvNJzxdBDL7tN3djC1n7oWqqiGGZ8uOWHGnm8T7qEtve3csJuQpnjVC9L6NEYgJidtcezYY86T9014T/TYRfBJ2CrjL8IZRbSBP2ro0jVhbVUTv01wL6A1Koipxrlj5S25of6X0eN+HX3Av47jAsa1nVSnBgtzow3exD9ruh+5DsJDSvSZSFodlVyaBB0q17YNyRFEwk/QfoP99CrZ6L9WDumakUZsx9dugI7T+82y/xhNW/T4xqROhKzx0tpru8grlWJU+xS12is4jl0BWQXjCXaFrEcT4yC/19Tr3vvH+aOWb6nzi6O/cX/R+fRcLV7uCd5ZFrXko3FA64XxCWhe9TCFYvAwvOPSyeCW2RUOexELELT7+fAgERhTLsnIJB2Eey2s4LmcPPkiNt+uljdt34xO+J1UzwAHchbOuuZgQju5OC3Kdiq69Wty/0nZ/+Qfeo602ZBwT7ZdRPn8igSI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5751.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(366004)(396003)(136003)(39860400002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(38070700009)(55016003)(83380400001)(7416002)(2906002)(38100700002)(71200400001)(8676002)(33656002)(52536014)(82960400001)(26005)(53546011)(122000001)(4326008)(8936002)(7696005)(64756008)(9686003)(86362001)(6506007)(316002)(478600001)(966005)(76116006)(5660300002)(66446008)(110136005)(54906003)(66556008)(66946007)(41300700001)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?1yzIe1PoURBJ1OeXU2VzBkhO/55jBQguVqE9CJtyYThvd6m9J11CaLU/?=
 =?Windows-1252?Q?hrwJuYRE2O4v5yEoTedU2XVyX03gGO2BrzCcj34uVaLYQXc+OdGnlePq?=
 =?Windows-1252?Q?w3t8WNJls+QoWNuszYY3KIS0/lMd7eqwW/9f3sH4opzbvnGFOUkBpRkr?=
 =?Windows-1252?Q?jriacQaxcYB9GzUwsUhgBp3l02k31vci6Aij8ZNXH2iGFOlbJM5VIY1R?=
 =?Windows-1252?Q?NLfrQ5FOFPjqBfCqREbLv/kcZkv5JUXMiE293wddVdrtTJo2O3y7MZrz?=
 =?Windows-1252?Q?BmqGaj+IEWk4skGYZnHBsFBQhi1yXc6a7FMs+k5KDjwIr9wa9jpULiE5?=
 =?Windows-1252?Q?/ufBs9WVVHwqXepsGX0RYMdVC3vvtzMH4qVyEbbnQYkzBfoOx7lrnt4j?=
 =?Windows-1252?Q?Jx/SfkiROAoS1er5AADdlyzgvHYrY+MYOmVAJsbyWiUFx8Dt9JH/YaSU?=
 =?Windows-1252?Q?aA3cjPEaRN5rozBIQbbe5QvV35qPpcXPRZl6sQATQFele3laqsEQZC3w?=
 =?Windows-1252?Q?2LOno0L4nlgHvD4bubLucNfLXl/6Z0HZEW1oNP8AaEZfgUdaYMeTnRBQ?=
 =?Windows-1252?Q?vpAPsnPRvJp0SlczO93X4xTWcbLeyXerWwpBff3xMVYn/y39IwexJcQv?=
 =?Windows-1252?Q?sjnL37Kt7ELWOp4l1yMFVfJFBjknCj1tI2Tl8YmlTxyXzShT98YOaBep?=
 =?Windows-1252?Q?IRZjIV9J1s65VIhqjT5Fj+SZiet3PTo5+YrzL9v7CmsDRWh50K6q2DrQ?=
 =?Windows-1252?Q?7/qoZKL4XqHhpAlY7VB9LmPcs5dzs244SIIcHFKcfauqAMBfih7G+iIJ?=
 =?Windows-1252?Q?23BPQboqNrMTP7s5FaGZyBg5+dFgg6pX8RFuaHzsB/LM9szmbwjWa4LN?=
 =?Windows-1252?Q?lf8lVqKE9+kuNkHr60bYGWZ8KDUbZxWDTwOvXFIt6JFf7hkEiuYu76Ll?=
 =?Windows-1252?Q?pbml8xVXOn1yBBGR4zHLGdtQNWy/hoaTmr+rSR/Ty6r84oE5VbBNnZGh?=
 =?Windows-1252?Q?eiKlLVGWmR9ESPEdwHlVkPax/sKiidaT5TrU+ZX9jwJ82P+dH4R37aeJ?=
 =?Windows-1252?Q?XzCOq2qdh3wjK2eY0no9nVXCx2dvMM/lKFumGGkPxucWu0q/LFj6TalS?=
 =?Windows-1252?Q?ccXI0BQxAs6GcM890aXiInmzjF0R8xZIf3skyCg8ZZ/XWS1S7uUaxnJ1?=
 =?Windows-1252?Q?UjNr5bpKp2IBpZrAk5mQf9lLpnkpEK1+00JwBiquUf2MfnPAITYVhjXD?=
 =?Windows-1252?Q?uob5NMR5zRLkjPhFsrH+xhlYowBStL++eDlCEnDx8khdlCJVxRaWJpjr?=
 =?Windows-1252?Q?PcRefCiwOVjotZ9KAMo8mn4GgiP+K+2EntA7kCXbLvnnI6RqEaxasA+M?=
 =?Windows-1252?Q?tBNrq2uwBOiJ7s0r0t+KvZJ5A7e55CA84KXljFPcDiDoDElM4DRyH5Cc?=
 =?Windows-1252?Q?7v7sQ+cLc5EoMplvBiOqHgUdpd2Mou1xffJUcxALi83v884nUpTBwgGj?=
 =?Windows-1252?Q?RoDVU1p+NwG3hIN3arcDO3Tl7813xqRMU9wV72/PkQOvwmqf651QHxER?=
 =?Windows-1252?Q?ajEvfQpk35e5u964LrZ4zV1Qtalj5pFWsFo9hXcNpkpwGs3Vcp04Q6dg?=
 =?Windows-1252?Q?GUCWYuWzIueDxSre8Da6IN3HrV9P7qnZJdoNzl0h5MUDK3/ecCtt4AZA?=
 =?Windows-1252?Q?ftso72W150xZNyr2aLp8z3iZwe5ersbU?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5751.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81a6e41c-cb3e-49bd-fdc3-08dbd5269ee2
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2023 06:50:05.3721
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EbwYgF6V8G69WdsD1uOEFWdI9vzvcEctAbMcc4Ska6q5MivlmR5wuiklUr3DTxW8Vgr1qU9wPsj8WpAL9DPeSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7772
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Charlie,

> -----Original Message-----
> From: linux-riscv <linux-riscv-bounces@lists.infradead.org> On Behalf Of
> Charlie Jenkins
> Sent: Wednesday, September 20, 2023 2:45 AM
> To: Charlie Jenkins <charlie@rivosinc.com>; Palmer Dabbelt
> <palmer@dabbelt.com>; Conor Dooley <conor@kernel.org>; Samuel Holland
> <samuel.holland@sifive.com>; David Laight <David.Laight@aculab.com>;
> linux-riscv@lists.infradead.org; linux-kernel@vger.kernel.org; linux-
> arch@vger.kernel.org
> Cc: Paul Walmsley <paul.walmsley@sifive.com>; Albert Ou
> <aou@eecs.berkeley.edu>; Arnd Bergmann <arnd@arndb.de>
> Subject: [PATCH v7 2/4] riscv: Checksum header
>=20
> Provide checksum algorithms that have been designed to leverage riscv
> instructions such as rotate. In 64-bit, can take advantage of the larger
> register to avoid some overflow checking.
>=20
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
>  arch/riscv/include/asm/checksum.h | 79
> +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 79 insertions(+)
>=20
> diff --git a/arch/riscv/include/asm/checksum.h
> b/arch/riscv/include/asm/checksum.h
> new file mode 100644
> index 000000000000..dc0dd89f2a13
> --- /dev/null
> +++ b/arch/riscv/include/asm/checksum.h
> @@ -0,0 +1,79 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * IP checksum routines
> + *
> + * Copyright (C) 2023 Rivos Inc.
> + */
> +#ifndef __ASM_RISCV_CHECKSUM_H
> +#define __ASM_RISCV_CHECKSUM_H
> +
> +#include <linux/in6.h>
> +#include <linux/uaccess.h>
> +
> +#define ip_fast_csum ip_fast_csum
> +
> +#include <asm-generic/checksum.h>
> +
> +/*
> + * Quickly compute an IP checksum with the assumption that IPv4 headers
> will
> + * always be in multiples of 32-bits, and have an ihl of at least 5.
> + * @ihl is the number of 32 bit segments and must be greater than or equ=
al
> to 5.
> + * @iph is assumed to be word aligned.

Not sure if the assumption is always true. It looks the implementation in "=
lib/checksum.c" doesn't take this assumption.
The ip header can comes after a 14-Byte ether header, which may start from =
a word-aligned or DMA friendly address.

> + */
> +static inline __sum16 ip_fast_csum(const void *iph, unsigned int ihl)
> +{
> +	unsigned long csum =3D 0;
> +	int pos =3D 0;
> +
> +	do {
> +		csum +=3D ((const unsigned int *)iph)[pos];
> +		if (IS_ENABLED(CONFIG_32BIT))
> +			csum +=3D csum < ((const unsigned int *)iph)[pos];
> +	} while (++pos < ihl);
> +
> +	/*
> +	 * ZBB only saves three instructions on 32-bit and five on 64-bit so no=
t
> +	 * worth checking if supported without Alternatives.
> +	 */
> +	if (IS_ENABLED(CONFIG_RISCV_ISA_ZBB) &&
> +	    IS_ENABLED(CONFIG_RISCV_ALTERNATIVE)) {
> +		unsigned long fold_temp;
> +
> +		asm_volatile_goto(ALTERNATIVE("j %l[no_zbb]", "nop", 0,
> +					      RISCV_ISA_EXT_ZBB, 1)
> +		    :
> +		    :
> +		    :
> +		    : no_zbb);
> +
> +		if (IS_ENABLED(CONFIG_32BIT)) {
> +			asm(".option push				\n\
> +			.option arch,+zbb				\n\
> +				not	%[fold_temp], %[csum]
> 	\n\
> +				rori	%[csum], %[csum], 16		\n\
> +				sub	%[csum], %[fold_temp], %[csum]
> 	\n\
> +			.option pop"
> +			: [csum] "+r" (csum), [fold_temp] "=3D&r" (fold_temp));
> +		} else {
> +			asm(".option push				\n\
> +			.option arch,+zbb				\n\
> +				rori	%[fold_temp], %[csum], 32	\n\
> +				add	%[csum], %[fold_temp], %[csum]
> 	\n\
> +				srli	%[csum], %[csum], 32		\n\
> +				not	%[fold_temp], %[csum]
> 	\n\
> +				roriw	%[csum], %[csum], 16		\n\
> +				subw	%[csum], %[fold_temp], %[csum]
> 	\n\
> +			.option pop"
> +			: [csum] "+r" (csum), [fold_temp] "=3D&r" (fold_temp));
> +		}
> +		return csum >> 16;
> +	}
> +no_zbb:
> +#ifndef CONFIG_32BIT
> +	csum +=3D (csum >> 32) | (csum << 32);

Just like patch 3/4 does, we can call ror64(csum, 32).

BRs,
Xiao

> +	csum >>=3D 32;
> +#endif
> +	return csum_fold((__force __wsum)csum);
> +}
> +
> +#endif // __ASM_RISCV_CHECKSUM_H
>=20
> --
> 2.42.0
>=20
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
