Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2992FF8E
	for <lists+linux-arch@lfdr.de>; Thu, 30 May 2019 17:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbfE3PlT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 30 May 2019 11:41:19 -0400
Received: from mail-eopbgr710092.outbound.protection.outlook.com ([40.107.71.92]:48288
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726045AbfE3PlT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 30 May 2019 11:41:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=qGgV8eRfWlvvoiDW/7elKQndemU7clic04Xn5s4TUK13v98+khOkLv081ZpzmJ7b8Hnc8O6qi4LXADjnuTQHz3PiIXTBMVWRIu+2KifVP9rgU1BHJ38Ny/0RrhAKfgGJKhCY6Cmzv3umtodbsS7i8LdlJVBZAVKA1iCuZRMBB5s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b+wq9znLRZWjUiHdVwwJvy8mOOn1MTHnLq1q0+zW5Yo=;
 b=LKrq2tgHPVcbZ6FPfn+EHV+jgY6nOjgxsCfgGr44cMb9rVuS7lQvLzqF2p3T1h0il5NDbQFS7LCuY3Jt09MDASW7GprDIF2LVvcPP5FJ/CSccgvycRGFOOSoDS0Vz5nujGenDLbHotvWy0xz5R/IgsgcrhRO3V9nV95P5ob7g+g=
ARC-Authentication-Results: i=1; test.office365.com
 1;spf=none;dmarc=none;dkim=none;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b+wq9znLRZWjUiHdVwwJvy8mOOn1MTHnLq1q0+zW5Yo=;
 b=a1RRRke8iyfCeaHcmWsM+4v0lfjmhfzLjrqHhakE20hqJS87gKm2WFwXgAwBLiL7A/CJzfsaxv+zemL+jAxPNae4KeZD5vWvTFzWyzwyap3AhDFbW9IRd8ifs3rSLECUcK9UurJhJP3YneUItH53SOndeNP3l1I7MMfvp7yCKwg=
Received: from BYAPR21MB1221.namprd21.prod.outlook.com (2603:10b6:a03:107::12)
 by BYAPR21MB1175.namprd21.prod.outlook.com (2603:10b6:a03:104::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1965.1; Thu, 30 May
 2019 15:41:14 +0000
Received: from BYAPR21MB1221.namprd21.prod.outlook.com
 ([fe80::d005:4de8:ffbf:ba6b]) by BYAPR21MB1221.namprd21.prod.outlook.com
 ([fe80::d005:4de8:ffbf:ba6b%7]) with mapi id 15.20.1943.015; Thu, 30 May 2019
 15:41:13 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mark Salyzyn <salyzyn@android.com>,
        Peter Collingbourne <pcc@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Huw Davies <huw@codeweavers.com>
Subject: RE: [PATCH v6 18/19] x86: Add support for generic vDSO
Thread-Topic: [PATCH v6 18/19] x86: Add support for generic vDSO
Thread-Index: AQHVFvJX/FWqgsMYXUWDuWvrdwhvDKaDyyHw
Date:   Thu, 30 May 2019 15:41:13 +0000
Message-ID: <BYAPR21MB1221D54FCEC97509EEF7395CD7180@BYAPR21MB1221.namprd21.prod.outlook.com>
References: <20190530141531.43462-1-vincenzo.frascino@arm.com>
 <20190530141531.43462-19-vincenzo.frascino@arm.com>
In-Reply-To: <20190530141531.43462-19-vincenzo.frascino@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-05-30T15:41:11.5395527Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=edbd9425-16cf-4ba0-af14-008492b8a3c0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [2001:4898:80e8:2:d4d:c6de:4660:8ab7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c3085077-a364-48ec-f317-08d6e5153f49
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR21MB1175;
x-ms-traffictypediagnostic: BYAPR21MB1175:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BYAPR21MB1175430A2A9ACEC88C678E7FD7180@BYAPR21MB1175.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:651;
x-forefront-prvs: 00531FAC2C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39860400002)(366004)(346002)(136003)(199004)(189003)(6116002)(9686003)(71200400001)(55016002)(81156014)(186003)(2201001)(8676002)(6306002)(99286004)(81166006)(52536014)(10090500001)(5660300002)(476003)(110136005)(6246003)(8936002)(54906003)(4326008)(2501003)(446003)(486006)(229853002)(25786009)(966005)(68736007)(2906002)(22452003)(6506007)(71190400001)(478600001)(86362001)(316002)(53936002)(10290500003)(6436002)(14454004)(74316002)(8990500004)(66476007)(66556008)(7416002)(46003)(305945005)(76116006)(52396003)(33656002)(256004)(66946007)(102836004)(73956011)(7696005)(66446008)(64756008)(7736002)(76176011)(11346002)(41533002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR21MB1175;H:BYAPR21MB1221.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XwopYJYDuddQXyifUk232xXJbrCzN9hWVSa2ABr3VkN5sKwpX3tWGO8W4HljgFH+fh5VG6vUIBgPFzFRabxwbDfElVrsQnycHNcecx11MSqGoVN9wQz6Npbe63Au/kXxx967qlEP0j3e3WlvzpPp7OB51tf0Hl2dUnUD0ro6yrtWWr7Gy14blVwCcRZgMTRUr4KZOus4whg1bC6e/P1O/4fOseYXFDgz77YHnhHHSej2Gwy1yC4YiBKvxLYAWz7XEWGUb2RoBl6chbD/w/aFQD8YctWc2bx9uav1YEuEgCms8dC46d1h4h7POhqnGvXvxIWrXpfGFvtFhMIzWQQ5gd9wR9PyS+8ZEDLGrTp7JV1WfheTQEbLp/XuZH4e6pgvYWIP/AT2VJsoP9pT8wCtmkat6dgW0CMXLqrSjqvMG6s=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3085077-a364-48ec-f317-08d6e5153f49
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2019 15:41:13.7289
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mikelley@ntdev.microsoft.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR21MB1175
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Vincenzo Frascino <vincenzo.frascino@arm.com> On Thursday, May 30, 20=
19 7:16 AM
>=20
> The x86 vDSO library requires some adaptations to take advantage of the
> newly introduced generic vDSO library.
>=20
> Introduce the following changes:
>  - Modification of vdso.c to be compliant with the common vdso datapage
>  - Use of lib/vdso for gettimeofday
>=20
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
>
>
> diff --git a/arch/x86/include/asm/mshyperv-tsc.h b/arch/x86/include/asm/m=
shyperv-tsc.h
> new file mode 100644
> index 000000000000..99c98ccea0bf
> --- /dev/null
> +++ b/arch/x86/include/asm/mshyperv-tsc.h
> @@ -0,0 +1,76 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_X86_MSHYPER_TSCPAGE_H
> +#define _ASM_X86_MSHYPER_TSCPAGE_H
> +
> +#include <asm/hyperv-tlfs.h>
> +
> +#ifdef CONFIG_HYPERV_TSCPAGE
> +struct ms_hyperv_tsc_page *hv_get_tsc_page(void);
> +static inline u64 hv_read_tsc_page_tsc(const struct ms_hyperv_tsc_page *=
tsc_pg,
> +				       u64 *cur_tsc)
> +{
> +	u64 scale, offset;
> +	u32 sequence;
> +
> +	/*
> +	 * The protocol for reading Hyper-V TSC page is specified in Hypervisor
> +	 * Top-Level Functional Specification ver. 3.0 and above. To get the
> +	 * reference time we must do the following:
> +	 * - READ ReferenceTscSequence
> +	 *   A special '0' value indicates the time source is unreliable and we
> +	 *   need to use something else. The currently published specification
> +	 *   versions (up to 4.0b) contain a mistake and wrongly claim '-1'
> +	 *   instead of '0' as the special value, see commit c35b82ef0294.
> +	 * - ReferenceTime =3D
> +	 *        ((RDTSC() * ReferenceTscScale) >> 64) + ReferenceTscOffset
> +	 * - READ ReferenceTscSequence again. In case its value has changed
> +	 *   since our first reading we need to discard ReferenceTime and repea=
t
> +	 *   the whole sequence as the hypervisor was updating the page in
> +	 *   between.
> +	 */
> +	do {
> +		sequence =3D READ_ONCE(tsc_pg->tsc_sequence);
> +		if (!sequence)
> +			return U64_MAX;
> +		/*
> +		 * Make sure we read sequence before we read other values from
> +		 * TSC page.
> +		 */
> +		smp_rmb();
> +
> +		scale =3D READ_ONCE(tsc_pg->tsc_scale);
> +		offset =3D READ_ONCE(tsc_pg->tsc_offset);
> +		*cur_tsc =3D rdtsc_ordered();
> +
> +		/*
> +		 * Make sure we read sequence after we read all other values
> +		 * from TSC page.
> +		 */
> +		smp_rmb();
> +
> +	} while (READ_ONCE(tsc_pg->tsc_sequence) !=3D sequence);
> +
> +	return mul_u64_u64_shr(*cur_tsc, scale, 64) + offset;
> +}
> +
> +static inline u64 hv_read_tsc_page(const struct ms_hyperv_tsc_page *tsc_=
pg)
> +{
> +	u64 cur_tsc;
> +
> +	return hv_read_tsc_page_tsc(tsc_pg, &cur_tsc);
> +}
> +
> +#else
> +static inline struct ms_hyperv_tsc_page *hv_get_tsc_page(void)
> +{
> +	return NULL;
> +}
> +
> +static inline u64 hv_read_tsc_page_tsc(const struct ms_hyperv_tsc_page *=
tsc_pg,
> +				       u64 *cur_tsc)
> +{
> +	BUG();
> +	return U64_MAX;
> +}
> +#endif
> +#endif
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyp=
erv.h
> index cc60e617931c..db095a992f3e 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -7,6 +7,7 @@
>  #include <linux/nmi.h>
>  #include <asm/io.h>
>  #include <asm/hyperv-tlfs.h>
> +#include <asm/mshyperv-tsc.h>
>  #include <asm/nospec-branch.h>
>=20
>  #define VP_INVAL	U32_MAX
> @@ -387,73 +388,4 @@ static inline int hyperv_flush_guest_mapping_range(u=
64 as,
>  }
>  #endif /* CONFIG_HYPERV */
>=20
> -#ifdef CONFIG_HYPERV_TSCPAGE
> -struct ms_hyperv_tsc_page *hv_get_tsc_page(void);
> -static inline u64 hv_read_tsc_page_tsc(const struct ms_hyperv_tsc_page *=
tsc_pg,
> -				       u64 *cur_tsc)
> -{
> -	u64 scale, offset;
> -	u32 sequence;
> -
> -	/*
> -	 * The protocol for reading Hyper-V TSC page is specified in Hypervisor
> -	 * Top-Level Functional Specification ver. 3.0 and above. To get the
> -	 * reference time we must do the following:
> -	 * - READ ReferenceTscSequence
> -	 *   A special '0' value indicates the time source is unreliable and we
> -	 *   need to use something else. The currently published specification
> -	 *   versions (up to 4.0b) contain a mistake and wrongly claim '-1'
> -	 *   instead of '0' as the special value, see commit c35b82ef0294.
> -	 * - ReferenceTime =3D
> -	 *        ((RDTSC() * ReferenceTscScale) >> 64) + ReferenceTscOffset
> -	 * - READ ReferenceTscSequence again. In case its value has changed
> -	 *   since our first reading we need to discard ReferenceTime and repea=
t
> -	 *   the whole sequence as the hypervisor was updating the page in
> -	 *   between.
> -	 */
> -	do {
> -		sequence =3D READ_ONCE(tsc_pg->tsc_sequence);
> -		if (!sequence)
> -			return U64_MAX;
> -		/*
> -		 * Make sure we read sequence before we read other values from
> -		 * TSC page.
> -		 */
> -		smp_rmb();
> -
> -		scale =3D READ_ONCE(tsc_pg->tsc_scale);
> -		offset =3D READ_ONCE(tsc_pg->tsc_offset);
> -		*cur_tsc =3D rdtsc_ordered();
> -
> -		/*
> -		 * Make sure we read sequence after we read all other values
> -		 * from TSC page.
> -		 */
> -		smp_rmb();
> -
> -	} while (READ_ONCE(tsc_pg->tsc_sequence) !=3D sequence);
> -
> -	return mul_u64_u64_shr(*cur_tsc, scale, 64) + offset;
> -}
> -
> -static inline u64 hv_read_tsc_page(const struct ms_hyperv_tsc_page *tsc_=
pg)
> -{
> -	u64 cur_tsc;
> -
> -	return hv_read_tsc_page_tsc(tsc_pg, &cur_tsc);
> -}
> -
> -#else
> -static inline struct ms_hyperv_tsc_page *hv_get_tsc_page(void)
> -{
> -	return NULL;
> -}
> -
> -static inline u64 hv_read_tsc_page_tsc(const struct ms_hyperv_tsc_page *=
tsc_pg,
> -				       u64 *cur_tsc)
> -{
> -	BUG();
> -	return U64_MAX;
> -}
> -#endif
>  #endif

Vincenzo -- these changes for Hyper-V are a subset of a larger patch set
I have that moves all of the Hyper-V clock/timer code into a separate
clocksource driver in drivers/clocksource, with an include file in
includes/clocksource.  That new include file should be able to work
instead of your new mshyperv-tsc.h.  It also has the benefit of being
ISA neutral, so it will work with my in-progress patch set to support
Linux on Hyper-V on ARM64.  See https://lkml.org/lkml/2019/5/27/231
for the new clocksource driver patch set.

Michael
