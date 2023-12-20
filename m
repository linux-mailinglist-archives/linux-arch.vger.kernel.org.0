Return-Path: <linux-arch+bounces-1141-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B91BA819CBE
	for <lists+linux-arch@lfdr.de>; Wed, 20 Dec 2023 11:28:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 722AE284E05
	for <lists+linux-arch@lfdr.de>; Wed, 20 Dec 2023 10:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F64820B05;
	Wed, 20 Dec 2023 10:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i25dig9s"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D1020B0A;
	Wed, 20 Dec 2023 10:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703068089; x=1734604089;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=v3vlIKIYe41abWN04IBkfI0cDmD2Oip+hYAHeTgi6vQ=;
  b=i25dig9sKZRFE1hn04eqF7at8+xuh3OSMo4zLN86x90Fk3EJqyrBbSYY
   qHi5IHJqeKFxOxHGGXFXE1tXLafqMuw6NsIH64BiGF13Gs5z7c/+fSKlg
   47+3EH9MO3BMFs4QwFXWi30GS8ZW+pX1HX7zUwUf3uhhhk0HsVX/W6A3/
   kAigSR4Dql9xke321jF3kXLJSKkP/YcM5WUFTIBWgytkVzlCUrFTi25HY
   aOKCKEX2MStcsKq+SYJGHg6h20/64OVXUdFXHTpiGjE9b0U2iSvVHH/Ml
   WfNy5kiJ7+q1upcP8Hm2q1cWSTf2CotXCP0RJlxyed2e4d1CJ6RKXiuu6
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="3014948"
X-IronPort-AV: E=Sophos;i="6.04,291,1695711600"; 
   d="scan'208";a="3014948"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 02:28:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="776293381"
X-IronPort-AV: E=Sophos;i="6.04,291,1695711600"; 
   d="scan'208";a="776293381"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Dec 2023 02:28:07 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 20 Dec 2023 02:28:07 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 20 Dec 2023 02:28:07 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 20 Dec 2023 02:28:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YUsNBXtEtCZBd6/7y5uRxXA1Mit7Dr/4jA0esTaZeC/lEwv2jrWAnUFJ4tEXfsaqn6x/kMaeNYKQFl63yM0bpTeo/CDG35A5jN+tMKMJdqhIkBO/mwzahKx9/DO3AmqQPvNMhsiBMX3G6/sFhEeHbbUjpg41fynIj+bvJxezUsbKBDBLFBm2urldDwEMTPpbA3BNtREh6KJDgusGO7lQoEdHk24GT4WrRXLBDIuV+DWFpxCc+UkQodSgEINd8xwsGni9qciZCKEWKT9B24/RQmotMr4p1446Fm3/RP2NRvJmVc25fo7Sbhcxi07VtUF6DTIAYeDlqP25rTmO89lwPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pF6mFdozmQz9EiiQXgOv25zoiWVLK0u+KFxzYFGT+Hc=;
 b=RM3kwAkTQuM7uYxMRFG4P6UXuULBHDPMWDLP4sZ+4rIglOyu3cMEnvLtITzm+yDXMql7XxuOCaAW/xI2V/feN3IzvXUsE8N1sf5eDcvUIRkhxN4MogEOAoNEZAoEpW8SP+1TycMakL6brE+332qv1owc0XzyfaVM7MUvtavWmfGrNSGU7TBIHYDUTP01UYtdQBKMIJVt8VOWHAi5+H/4CzsiAe4dNCBrKhsvNWOH1AmaEOfLna2hnUq7dewh/h0UceOncRWiQipMatk/W5pHBZdhA5oCgvKEIfp38NtO57uDw1AmSPE/cp6AjxBi0YwoB1mr/3xXrLmSRy3WY5Qk8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5751.namprd11.prod.outlook.com (2603:10b6:8:12::16) by
 CY5PR11MB6163.namprd11.prod.outlook.com (2603:10b6:930:28::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.38; Wed, 20 Dec 2023 10:28:04 +0000
Received: from DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::da85:3d5:65fd:4a21]) by DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::da85:3d5:65fd:4a21%7]) with mapi id 15.20.7113.016; Wed, 20 Dec 2023
 10:28:04 +0000
From: "Wang, Xiao W" <xiao.w.wang@intel.com>
To: Charlie Jenkins <charlie@rivosinc.com>, Palmer Dabbelt
	<palmer@dabbelt.com>, Conor Dooley <conor@kernel.org>, Samuel Holland
	<samuel.holland@sifive.com>, David Laight <David.Laight@aculab.com>, "Evan
 Green" <evan@rivosinc.com>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>
CC: Paul Walmsley <paul.walmsley@sifive.com>, Albert Ou
	<aou@eecs.berkeley.edu>, Arnd Bergmann <arnd@arndb.de>, Conor Dooley
	<conor.dooley@microchip.com>
Subject: RE: [PATCH v12 4/5] riscv: Add checksum library
Thread-Topic: [PATCH v12 4/5] riscv: Add checksum library
Thread-Index: AQHaLWJcLVI+zc8gI0KoWfU9qfHsQrCmeFIAgAuJv6A=
Date: Wed, 20 Dec 2023 10:28:04 +0000
Message-ID: <DM8PR11MB5751D7F4F8D7297198452723B896A@DM8PR11MB5751.namprd11.prod.outlook.com>
References: <20231212-optimize_checksum-v12-0-419a4ba6d666@rivosinc.com>
 <20231212-optimize_checksum-v12-4-419a4ba6d666@rivosinc.com>
 <ZXkSlocykTJKILyn@ghost>
In-Reply-To: <ZXkSlocykTJKILyn@ghost>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5751:EE_|CY5PR11MB6163:EE_
x-ms-office365-filtering-correlation-id: 4f921bb1-b343-4132-1dc8-08dc014659f5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CVqNIlfqcfS03EcJ+/3RypYaPyvOd8ROKpryZz9hJ71tiP9+PwR5vjtSMwddVCmv+eihFWRiWF2lRUw2W9EGf3aicmmoxdP68zjc5ieuAt4qsEJxywdxaZFXrvnUKThgGqwgtp0CLaQsckl7XVUaNYFUZi+o25/CCc6Tsq08T5q4gAcBRvd2lRGjUP1+VosuwbyakVghPNHgEWFMYdWW6PxHJyo9FS04bXwbsY0uC9VRiQQPajgGfOjH+wkWRfAHXxWaW7IgfFDUv4LeSxrcSZulbtm25kvo2hF9HyOmTUuz3tsvbUTIbApjbiGV0yqICy/BWGIDTyq4djbEcDuYsYxiVHZC+oi8jkQs8OwHojJ+wURONjJMKqEO7viEJC9OChCcy6LJdpwYdfCxHJeJCe83PNNR1MxRg8wl7doPSqCp5q7hb6+5UdEoyCDSS6A5KCWAhtlvjKg6w+jEdZM+UE/BpOPjsEFGmsl2IrkngGmGZgYdFgemh/mcRRV/w8lX3/mKP+0UfbzlP8mD1E2JlSBfczMTIXvSmVqwMLtz+ieTBwT6uruAmvIX9icvajchk0EP3F7X/omvGZsq6rpMmkwORgMqTZd9erCspkiFHpG68dccDIwik/Bp8lLJm/LK
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5751.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(376002)(39860400002)(136003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(26005)(66446008)(83380400001)(9686003)(6506007)(53546011)(7696005)(478600001)(5660300002)(41300700001)(8676002)(110136005)(7416002)(4326008)(8936002)(316002)(2906002)(52536014)(71200400001)(54906003)(64756008)(66476007)(122000001)(66946007)(33656002)(86362001)(76116006)(66556008)(82960400001)(38100700002)(38070700009)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?AJWl9MuRktam980odFIO+j2bpJYE+el1iFVFB/L1c5ePT2wqk+kSm/ao?=
 =?Windows-1252?Q?bfqpSYxLz3sR2FhwsGzSvXIn87Hc8FicRb52H0jNIqSEswb54qKz8Pgo?=
 =?Windows-1252?Q?6L1NIF0WXimuzzkgCTFXAAMQEZl0xfYTPcjd6xjvL+/yeIyUkgLAfPhn?=
 =?Windows-1252?Q?RFY4lUTYheAv6yx93p3XujTOYfOEXbZCKgndO6VW02QbB0csfwIzx1+N?=
 =?Windows-1252?Q?pzFNbSD6nVfzWam1ghfa6NITmqCvhNYPXzEVVein2CoJchp/i1uVlg32?=
 =?Windows-1252?Q?kwrRW/VR34anTRt23Lj/MjgLwwHZQyC8gERUj9OEgruw//nk+5xgw5TV?=
 =?Windows-1252?Q?HtRabv0++ADnDz94rif41VlIUP8W+TNWi/JmuUjKMFakz/1vIdoI8NIk?=
 =?Windows-1252?Q?BAOYcbP81Ju6vm52UMM4RA/+Mhv+Q9uR7vQ9bANgSJuLuHFR/bKkoz/p?=
 =?Windows-1252?Q?jk7qHowo7hjCaQlUsPy5/eT+mJUd7UQk6p7nMOMB4zltSRGhcauwLzQq?=
 =?Windows-1252?Q?1Bgi58Z2h0yIjt9XpLx29Rk7jeVmO//GDLxIaFq2VHjZoyrLOEseMDHC?=
 =?Windows-1252?Q?aDRznpmtrplssrnHwdjRgkBLJLy9PY8I8ASq0CPq4RKnx8B5VO9tTZU2?=
 =?Windows-1252?Q?bhwUicWSdJ7m9dyceH5hq8IcdFxRVNdabuKbFj63nrmvD0/J7VByZT5x?=
 =?Windows-1252?Q?wzc3Tka4/w6RE+H0tDb4Ivn/JgZuZ02xv5HEZ7t+8osTDr3OOZ3TpbAG?=
 =?Windows-1252?Q?PMjF2V0Tn0AIRHG5XSDxFqVAGEq+UmeLiZ7vIq1rJYmmnxLG/3n4Mupu?=
 =?Windows-1252?Q?OZooRbLR4q2cMDWeuNPmCazbJygzAChI2QAsgyaSjuHQKhZRPSr0fMf4?=
 =?Windows-1252?Q?UYTx7Lm5/DZq1xD0REYxj2PrBKxfQn43KN9AhJQ5jF5sNjMCXf11M8q4?=
 =?Windows-1252?Q?J8Xekb5Os8rUyL+xH365gMkKFlrPtYYFUldPTohrHhWFgTXRlsqNjB5B?=
 =?Windows-1252?Q?F/UX0Aqwr0nWicWcnczMmVlQtgWtBWo+1Fh7P8mD2ef1EFp0kpRRy8Zy?=
 =?Windows-1252?Q?TKTdU6nUowEx/oMuk0px482TaEWX6vUzHbriC1qwgSR1i1HgB0cKjPOU?=
 =?Windows-1252?Q?kvWeZSnttTfHvtc6OC688hS4pcmS7lubaNDScViNkdGOlYarKSGh+LaB?=
 =?Windows-1252?Q?8Q8p6Rzoc5dHm3Vj+LxKA8bekqOOlTS0uqGI/jxbBizJcQ4yQm0jmNNX?=
 =?Windows-1252?Q?pxkhSEircnv/h6UBmDwGxfR18BeKPK0JwH/M56NSbRagI+zzn73LByo6?=
 =?Windows-1252?Q?e5B9Tl4amRorDnSj5LD4mOoiAdAppJ6H5ZWHeJTtrFCPq4mQpJyvYQhk?=
 =?Windows-1252?Q?OLsfh3sM8Am7xpP1Gjia+ZcqSaImozHsCOl8y9CkKvTs27+H+vdfqRxv?=
 =?Windows-1252?Q?JzNFR3UUk47+ydibkmTQJFo24N3jF9WYpeGqd2/JifTMOLs35i0IH+ex?=
 =?Windows-1252?Q?ggnlRHrLQRILLNLPb+/Vzw3iXHFLplXWozqXwMeIhZqXk1XEei7CDq7i?=
 =?Windows-1252?Q?8ErCgpyNPcbMfo1DAUo5hDQXJMCw8YrIo8STF53+AdsJIwgG8R514Jrh?=
 =?Windows-1252?Q?dhdL+1PJl9ShpoMdxNn+6EHFXMjA0XKQOCxLA5GuOjqvKn+m5OgbD1Le?=
 =?Windows-1252?Q?AYNis2+gIpMhWuub9yGERcpZAtl+vKVe?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f921bb1-b343-4132-1dc8-08dc014659f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2023 10:28:04.8305
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tKTvGt1tlaptBVt55Yn8sHBjuGiez4q6QYxrxFEAvREkreVg37J0HyCI7ieD167VIdx40gcPTE3vPurL+0iVug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6163
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Charlie Jenkins <charlie@rivosinc.com>
> Sent: Wednesday, December 13, 2023 10:11 AM
> To: Palmer Dabbelt <palmer@dabbelt.com>; Conor Dooley
> <conor@kernel.org>; Samuel Holland <samuel.holland@sifive.com>; David
> Laight <David.Laight@aculab.com>; Wang, Xiao W <xiao.w.wang@intel.com>;
> Evan Green <evan@rivosinc.com>; linux-riscv@lists.infradead.org; linux-
> kernel@vger.kernel.org; linux-arch@vger.kernel.org
> Cc: Paul Walmsley <paul.walmsley@sifive.com>; Albert Ou
> <aou@eecs.berkeley.edu>; Arnd Bergmann <arnd@arndb.de>; Conor Dooley
> <conor.dooley@microchip.com>
> Subject: Re: [PATCH v12 4/5] riscv: Add checksum library
>=20
> On Tue, Dec 12, 2023 at 05:18:41PM -0800, Charlie Jenkins wrote:
> > Provide a 32 and 64 bit version of do_csum. When compiled for 32-bit
> > will load from the buffer in groups of 32 bits, and when compiled for
> > 64-bit will load in groups of 64 bits.
> >
> > Additionally provide riscv optimized implementation of csum_ipv6_magic.
> >
> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> > Reviewed-by: Xiao Wang <xiao.w.wang@intel.com>
> > ---
> >  arch/riscv/include/asm/checksum.h |  13 +-
> >  arch/riscv/lib/Makefile           |   1 +
> >  arch/riscv/lib/csum.c             | 326
> ++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 339 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/riscv/include/asm/checksum.h
> b/arch/riscv/include/asm/checksum.h
> > index 2fcf864186e7..3fa04ff1eda8 100644
> > --- a/arch/riscv/include/asm/checksum.h
> > +++ b/arch/riscv/include/asm/checksum.h
> > @@ -12,6 +12,17 @@
> >
> >  #define ip_fast_csum ip_fast_csum
> >
> > +extern unsigned int do_csum(const unsigned char *buff, int len);
> > +#define do_csum do_csum
> > +
> > +/* Default version is sufficient for 32 bit */
> > +#ifndef CONFIG_32BIT
> > +#define _HAVE_ARCH_IPV6_CSUM
> > +__sum16 csum_ipv6_magic(const struct in6_addr *saddr,
> > +			const struct in6_addr *daddr,
> > +			__u32 len, __u8 proto, __wsum sum);
> > +#endif
> > +
> >  /* Define riscv versions of functions before importing asm-
> generic/checksum.h */
> >  #include <asm-generic/checksum.h>
> >
> > @@ -69,7 +80,7 @@ static inline __sum16 ip_fast_csum(const void *iph,
> unsigned int ihl)
> >  			.option pop"
> >  			: [csum] "+r" (csum), [fold_temp] "=3D&r" (fold_temp));
> >  		}
> > -		return csum >> 16;
> > +		return (__force __sum16) (csum >> 16);

I notice that this type conversion comes in after V10. This change should g=
o to patch 3/5.

BRs,
Xiao

[...]
> > +
> > +/*
> > + * Perform a checksum on an arbitrary memory address.
> > + * Will do a light-weight address alignment if buff is misaligned, unl=
ess
> > + * cpu supports fast misaligned accesses.
> > + */
> > +unsigned int do_csum(const unsigned char *buff, int len)
> > +{
> > +	if (unlikely(len <=3D 0))
> > +		return 0;
> > +
> > +	/*
> > +	 * Significant performance gains can be seen by not doing alignment
> > +	 * on machines with fast misaligned accesses.
> > +	 *
> > +	 * There is some duplicate code between the "with_alignment" and
> > +	 * "no_alignment" implmentations, but the overlap is too awkward to
> be
> > +	 * able to fit in one function without introducing multiple static
> > +	 * branches. The largest chunk of overlap was delegated into the
> > +	 * do_csum_common function.
> > +	 */
> > +	if (static_branch_likely(&fast_misaligned_access_speed_key))
> > +		return do_csum_no_alignment(buff, len);
> > +
> > +	if (((unsigned long)buff & OFFSET_MASK) =3D=3D 0)
> > +		return do_csum_no_alignment(buff, len);
> > +
> > +	return do_csum_with_alignment(buff, len);
> > +}
> >
> > --
> > 2.43.0
> >
>=20
> There is potentially a code size concern here. These changes do require
> alternatives, and as such it increases the resulting binary size. The
> bloat-o-meter script reports that the do_csum function grows to twice
> the size with this patch:
>=20
> Function                                     old     new   delta
> do_csum                                      238     514    +276
>=20
> The other functions are harder to measure because they get inlined or
> are not included in generic code. However the do_csum is the most
> impacted because of the misaligned access behavior.
>=20
> The performance improvements afforded by alternatives (with the Zbb
> extension) and with the misaligned access checking are significant. In
> my testing these optimizations alone contribute to over a 20% performance
> improvement.
>=20
> - Charlie


