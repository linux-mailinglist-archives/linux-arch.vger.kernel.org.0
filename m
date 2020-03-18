Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0326618927B
	for <lists+linux-arch@lfdr.de>; Wed, 18 Mar 2020 01:10:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgCRAKv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 17 Mar 2020 20:10:51 -0400
Received: from mail-bn8nam11on2094.outbound.protection.outlook.com ([40.107.236.94]:23395
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726680AbgCRAKv (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 17 Mar 2020 20:10:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XyZ1cRWvKCBhqUDoCOR8NJoPCiuXcmLoz5rt+ahl7RY+Ix6rUBaohbW+z+pVctZG1QsNrm3TcqdHbiykr4YlfWw00oNI1fP8XT4H0/3DYBFmswcuXi6lDupfJBtjAHQXvyRpQL1RQQa1ssu0uAtWXyelfL3ADC+hSmmQnXXWjUo3Xp5dkgqsZ8uF2j0l5RGwELWPoFHNkjQSxMLyzZO15puje5DsAfGT960n0q1gPftvNmZceJbSyToep8kKpqj0LleTZ9hMDGpQy+X1PbXWzktdnwjJth4HIuJZOVPrD+reoHJoTNLcf3RhKIBUmfImPSLUHVISCSlo11v9Gi+KLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p6EK4WIRO1N1cfqS2SVBmroJvI/DXTCfG2O16L+5XSk=;
 b=i2GPiMFqSDxQBhODM2dqSQMCcOJnPWhV08l+O4vNRj4aa8cNaxIvE17u4P0Vys6FIOxiwYl/PNlBFp/USLJ/7HSXtS8Rp2UihM8bRNIMjsXxyuyInq/xMt1EOYr4GdM6BEa4yHebwdWvgdWwtx4FkD8yY8jLHg/z79Ukl7Jq/qmr1fQJ1rWcWfqPCQ5dwPjJBgMkYabdISA/SIdPc69Avwf8+zwC5mCFFL3CQ7VYjG8jPPNUgr9ZdHq5Drldq3CyN7y907TgWo9gbndDmXTS5E5CJuBfqpzauUXJr69QYDMmHy/QeMMeQEIHlXRqmlY3/QBHJ1pdVmLBzSllvT4Kxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p6EK4WIRO1N1cfqS2SVBmroJvI/DXTCfG2O16L+5XSk=;
 b=U8/RboogOetM3WuEE49Nwjkxp5zStQI7Lf+1qdW0cmxatx2Usc+7VTirxieRQ1k7M7OgKScwv1vrT6BsQgbDphZPg/0KiCvHucdr4otr5oSTuaGGxm70SVYruEslFBl6vX766WdivlvgxhJkmIbK7lw2pAyck2gxTrG+N2c7Pt8=
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com (2603:10b6:302:a::16)
 by MW2PR2101MB0924.namprd21.prod.outlook.com (2603:10b6:302:10::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.3; Wed, 18 Mar
 2020 00:10:46 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::71ee:121:71bd:6156]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::71ee:121:71bd:6156%9]) with mapi id 15.20.2835.003; Wed, 18 Mar 2020
 00:10:46 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Marc Zyngier <maz@kernel.org>
CC:     "will@kernel.org" <will@kernel.org>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        vkuznets <vkuznets@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        KY Srinivasan <kys@microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        "boqun.feng@gmail.com" <boqun.feng@gmail.com>
Subject: RE: [PATCH v6 01/10] arm64: hyperv: Add core Hyper-V include files
Thread-Topic: [PATCH v6 01/10] arm64: hyperv: Add core Hyper-V include files
Thread-Index: AQHV+hZFy2PYk3vLgUeMDTQcrJxEgqhJ6u2AgAM4fwA=
Date:   Wed, 18 Mar 2020 00:10:46 +0000
Message-ID: <MW2PR2101MB1052D91D46EBDFE004B2F549D7F70@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <1584200119-18594-1-git-send-email-mikelley@microsoft.com>
        <1584200119-18594-2-git-send-email-mikelley@microsoft.com>
 <86v9n5zfrm.wl-maz@kernel.org>
In-Reply-To: <86v9n5zfrm.wl-maz@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-03-18T00:10:44.0699642Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=279715c3-fe97-4c2a-8dbf-83894911492b;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8f20517b-d554-45f8-772b-08d7cad0ce93
x-ms-traffictypediagnostic: MW2PR2101MB0924:|MW2PR2101MB0924:|MW2PR2101MB0924:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW2PR2101MB09246E0EC1A9ADE60661DCB1D7F70@MW2PR2101MB0924.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 03468CBA43
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(346002)(136003)(396003)(376002)(366004)(199004)(55016002)(9686003)(8676002)(26005)(30864003)(8936002)(186003)(81156014)(8990500004)(316002)(81166006)(86362001)(66946007)(7416002)(66556008)(966005)(66476007)(66446008)(64756008)(54906003)(76116006)(4326008)(6916009)(33656002)(478600001)(5660300002)(6506007)(10290500003)(7696005)(52536014)(2906002)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0924;H:MW2PR2101MB1052.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0GzC2Len+Wx9oFKsXp+hbm+MRpmBs+R/5NLXbmLaDIYAXBAM0KZnyZAc5Cbna2TdYukWO397pGzAhe4Pbowc5I5fJjXCdnAEymqZ67yUX7gXl0gKSXim70beBWQAk87/ClAaqaif4z+SHB7XOLplS67W4v3Zxs+kkwNC4IhMQBpPQE/zM0Vmq7Y4ejXFS8i+oAnrluX9qqVwceWbkXsh8rKXozUMwVy2FAsvrwtaaF7Y8w07SK7FhKqT8O/WcMLkcKgEGIuFst7KWxg2KCit6svepo4SXj30BbJSPFUKofvXJMWHiCU7qDQaPXigp5nbmg3/y3WiwfwZTdm1fn7O2MqJJ92Uj/wuG4NacG9tH+FYGE+GhdM+4d1w8z0A985NknWd/GD6688AXKTxkd7RxUYC+VGzZbyyhEqoKhUgOBsJBL8qKMAgctITWhUDPxqrCrivQEbEG46nyC8wZ6eVMSMfVZHfJ3cTqeRLNGHj2wsMhR3czZxqLMCbQWpj5pm7S0IOyPK9gxuEj9hkeDdimw==
x-ms-exchange-antispam-messagedata: fOSMeLysDsIw5q7HMqc82jvsbhLb+nvMBlz9p5iBjmA3qrdYfAoRE+nzbs6bYeJohQPyI/Ggw5xZyRHJZcCibRQBmw55Tjhpc2D0cocmnCCOSp6BapceKv3XG5xpMEwsx1Qt/T7YsR+oAO2W1ylaCg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f20517b-d554-45f8-772b-08d7cad0ce93
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2020 00:10:46.2534
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FfyXdLT4TS+zM8aZQ8y2RFaR5CSNMcsk3MfSCaU/VtPTTo1pdDgQaFDxtEnc3YLClzKFy5UMQau3QU3Pu42F88WhAy2zUp8QWA+ay+oRejA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0924
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Marc Zyngier <maz@kernel.org> Sent: Sunday, March 15, 2020 10:31 AM
>=20
> On Sat, 14 Mar 2020 15:35:10 +0000,
> Hi Michael,
>=20
> Michael Kelley <mikelley@microsoft.com> wrote:
> >
> > hyperv-tlfs.h defines Hyper-V interfaces from the Hyper-V Top Level
> > Functional Spec (TLFS). The TLFS is distinctly oriented to x86/x64,
> > and Hyper-V has not separated out the architecture-dependent parts into
> > x86/x64 vs. ARM64. So hyperv-tlfs.h includes information for ARM64
> > that is not yet formally published. The TLFS is available here:
> >
> >   docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/reference/=
tlfs
> >
> > mshyperv.h defines Linux-specific structures and routines for
> > interacting with Hyper-V on ARM64, and #includes the architecture-
> > independent part of mshyperv.h in include/asm-generic.
> >
> > Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> > ---
> >  MAINTAINERS                          |   2 +
> >  arch/arm64/include/asm/hyperv-tlfs.h | 413
> +++++++++++++++++++++++++++++++++++
> >  arch/arm64/include/asm/mshyperv.h    | 115 ++++++++++
> >  3 files changed, 530 insertions(+)
> >  create mode 100644 arch/arm64/include/asm/hyperv-tlfs.h
> >  create mode 100644 arch/arm64/include/asm/mshyperv.h
>=20
> So this is a pretty large patch, mostly containing constants and other
> data structures that don't necessarily make sense immediately (or at
> least, I can't make sense of it without reading all the other 9
> patches and going back to patch #1).
>=20
> Could you please consider splitting this into more discreet bits that
> get added as required by the supporting code?

Yes, I'll do this in the next version.

>=20
> So here's only a few sparse comments:
>=20
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 58bb5c4..398cfdb 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -7809,6 +7809,8 @@ F:	arch/x86/include/asm/trace/hyperv.h
> >  F:	arch/x86/include/asm/hyperv-tlfs.h
> >  F:	arch/x86/kernel/cpu/mshyperv.c
> >  F:	arch/x86/hyperv
> > +F:	arch/arm64/include/asm/hyperv-tlfs.h
> > +F:	arch/arm64/include/asm/mshyperv.h
> >  F:	drivers/clocksource/hyperv_timer.c
> >  F:	drivers/hid/hid-hyperv.c
> >  F:	drivers/hv/
> > diff --git a/arch/arm64/include/asm/hyperv-tlfs.h b/arch/arm64/include/=
asm/hyperv-
> tlfs.h
> > new file mode 100644
> > index 0000000..5e6a087
> > --- /dev/null
> > +++ b/arch/arm64/include/asm/hyperv-tlfs.h
> > @@ -0,0 +1,413 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +
> > +/*
> > + * This file contains definitions from the Hyper-V Hypervisor Top-Leve=
l
> > + * Functional Specification (TLFS):
> > + * https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/=
reference/tlfs
> > + *
> > + * Copyright (C) 2019, Microsoft, Inc.
> > + *
> > + * Author : Michael Kelley <mikelley@microsoft.com>
> > + */
> > +
> > +#ifndef _ASM_HYPERV_TLFS_H
> > +#define _ASM_HYPERV_TLFS_H
> > +
> > +#include <linux/types.h>
> > +
> > +/*
> > + * All data structures defined in the TLFS that are shared between Hyp=
er-V
> > + * and a guest VM use Little Endian byte ordering.  This matches the d=
efault
> > + * byte ordering of Linux running on ARM64, so no special handling is =
required.
> > + */
> > +
> > +
> > +/*
> > + * While not explicitly listed in the TLFS, Hyper-V always runs with a=
 page
> > + * size of 4096. These definitions are used when communicating with Hy=
per-V
> > + * using guest physical pages and guest physical page addresses, since=
 the
> > + * guest page size may not be 4096 on ARM64.
> > + */
> > +#define HV_HYP_PAGE_SHIFT	12
> > +#define HV_HYP_PAGE_SIZE	(1 << HV_HYP_PAGE_SHIFT)
>=20
> Probably worth writing this as 1UL to be on the safe side.

Agreed.

>=20
> > +#define HV_HYP_PAGE_MASK	(~(HV_HYP_PAGE_SIZE - 1))
> > +
> > +/*
> > + * These Hyper-V registers provide information equivalent to the CPUID
> > + * instruction on x86/x64.
> > + */
> > +#define HV_REGISTER_HYPERVISOR_VERSION		0x00000100 /*CPUID
> 0x40000002 */
> > +#define	HV_REGISTER_PRIVILEGES_AND_FEATURES	0x00000200 /*CPUID
> 0x40000003 */
> > +#define	HV_REGISTER_FEATURES			0x00000201 /*CPUID
> 0x40000004 */
> > +#define	HV_REGISTER_IMPLEMENTATION_LIMITS	0x00000202 /*CPUID
> 0x40000005 */
> > +#define HV_ARM64_REGISTER_INTERFACE_VERSION	0x00090006 /*CPUID
> 0x40000001 */
> > +
> > +/*
> > + * Feature identification. HvRegisterPrivilegesAndFeaturesInfo returns=
 a
> > + * 128-bit value with flags indicating which features are available to=
 the
> > + * partition based upon the current partition privileges. The 128-bit
> > + * value is broken up with different portions stored in different 32-b=
it
> > + * fields in the ms_hyperv structure.
> > + */
> > +
> > +/* Partition Reference Counter available*/
> > +#define HV_MSR_TIME_REF_COUNT_AVAILABLE		BIT(1)
> > +
> > +/* Synthetic Timers available */
> > +#define HV_MSR_SYNTIMER_AVAILABLE		BIT(3)
> > +
> > +/* Reference TSC available */
> > +#define HV_MSR_REFERENCE_TSC_AVAILABLE		BIT(9)
> > +
> > +
> > +/*
> > + * This group of flags is in the high order 64-bits of the returned
> > + * 128-bit value. Note that this set of bit positions differs from wha=
t
> > + * is used on x86/x64 architecture.
> > + */
> > +
> > +/* Crash MSRs available */
> > +#define HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE	BIT(8)
>=20
> It is confusing that you don't have a single bit space for all these
> flags. It'd probably help if you had a structure describing this
> 128bit value in multiple 32bit or 64bit words, and indicating which
> field the bit position is relevant to.

I'll add this in the next version.

>=20
> [...]
>=20
> > +/* Define the hypercall status result */
> > +
> > +union hv_hypercall_status {
> > +	u64 as_uint64;
>=20
> nit: it'd be more consistent if as_uint64 was actually a uint64 type.

Agreed.

>=20
> > +	struct {
> > +		u16 status;
> > +		u16 reserved;
> > +		u16 reps_completed;  /* Low 12 bits */
> > +		u16 reserved2;
> > +	};
> > +};
> > +
> > +/* hypercall status code */
> > +#define HV_STATUS_SUCCESS			0
> > +#define HV_STATUS_INVALID_HYPERCALL_CODE	2
> > +#define HV_STATUS_INVALID_HYPERCALL_INPUT	3
> > +#define HV_STATUS_INVALID_ALIGNMENT		4
> > +#define HV_STATUS_INSUFFICIENT_MEMORY		11
> > +#define HV_STATUS_INVALID_CONNECTION_ID		18
> > +#define HV_STATUS_INSUFFICIENT_BUFFERS		19
> > +
> > +/* Define input and output layout for Get VP Register hypercall */
> > +struct hv_get_vp_register_input {
> > +	u64 partitionid;
> > +	u32 vpindex;
> > +	u8  inputvtl;
> > +	u8  padding[3];
> > +	u32 name0;
> > +	u32 name1;
> > +} __packed;
> > +
> > +struct hv_get_vp_register_output {
> > +	u64 registervaluelow;
> > +	u64 registervaluehigh;
> > +} __packed;
> > +
> > +#define HV_FLUSH_ALL_PROCESSORS			BIT(0)
> > +#define HV_FLUSH_ALL_VIRTUAL_ADDRESS_SPACES	BIT(1)
> > +#define HV_FLUSH_NON_GLOBAL_MAPPINGS_ONLY	BIT(2)
>=20
> I"m curious: Are these supposed to be PV'd TLB invalidation
> operations?

Yes, they are.  Hyper-V provides PV TLB flush hypercalls on ARM64, but
this patch set doesn't use those hypercalls.  I'll remove the definitions.

>=20
> > +#define HV_FLUSH_USE_EXTENDED_RANGE_FORMAT	BIT(3)
> > +
> > +enum HV_GENERIC_SET_FORMAT {
> > +	HV_GENERIC_SET_SPARSE_4K,
> > +	HV_GENERIC_SET_ALL,
> > +};
> > +
> > +/*
> > + * The Hyper-V TimeRefCount register and the TSC
> > + * page provide a guest VM clock with 100ns tick rate
> > + */
> > +#define HV_CLOCK_HZ (NSEC_PER_SEC/100)
> > +
> > +/*
> > + * The fields in this structure are set by Hyper-V and read
> > + * by the Linux guest.  They should be accessed with READ_ONCE()
> > + * so the compiler doesn't optimize in a way that will cause
> > + * problems.  The union pads the size out to the page size
> > + * used to communicate with Hyper-V.
> > + */
> > +struct ms_hyperv_tsc_page {
> > +	union {
> > +		struct {
> > +			u32 tsc_sequence;
> > +			u32 reserved1;
> > +			u64 tsc_scale;
> > +			s64 tsc_offset;
> > +		} __packed;
> > +		u8 reserved2[HV_HYP_PAGE_SIZE];
> > +	};
> > +};
> > +
> > +/* Define the number of synthetic interrupt sources. */
> > +#define HV_SYNIC_SINT_COUNT		(16)
> > +/* Define the expected SynIC version. */
> > +#define HV_SYNIC_VERSION_1		(0x1)
> > +
> > +#define HV_SYNIC_CONTROL_ENABLE		(1ULL << 0)
> > +#define HV_SYNIC_SIMP_ENABLE		(1ULL << 0)
> > +#define HV_SYNIC_SIEFP_ENABLE		(1ULL << 0)
> > +#define HV_SYNIC_SINT_MASKED		(1ULL << 16)
> > +#define HV_SYNIC_SINT_AUTO_EOI		(1ULL << 17)
> > +#define HV_SYNIC_SINT_VECTOR_MASK	(0xFF)
>=20
> Let's me guess: a PV interrupt controller? Do you really need this?
> Specially as I don't see any PV irqchip driver in this submission...
>=20

No, the above definitions aren't needed.  I'll remove them.

Hyper-V does provide a limited synthetic interrupt controller that's
implemented entirely in architecture independent code and has been
used on the x86 side since the beginning of Hyper-V support.  It
pre-dates me by a lot of years, and I've never considered whether it
should be modeled as an irqchip.

> [...]
>=20
> > diff --git a/arch/arm64/include/asm/mshyperv.h b/arch/arm64/include/asm=
/mshyperv.h
> > new file mode 100644
> > index 0000000..60b3f68
> > --- /dev/null
> > +++ b/arch/arm64/include/asm/mshyperv.h
> > @@ -0,0 +1,115 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +
> > +/*
> > + * Linux-specific definitions for managing interactions with Microsoft=
's
> > + * Hyper-V hypervisor. The definitions in this file are specific to
> > + * the ARM64 architecture.  See include/asm-generic/mshyperv.h for
> > + * definitions are that architecture independent.
> > + *
> > + * Definitions that are specified in the Hyper-V Top Level Functional
> > + * Spec (TLFS) should not go in this file, but should instead go in
> > + * hyperv-tlfs.h.
> > + *
> > + * Copyright (C) 2019, Microsoft, Inc.
> > + *
> > + * Author : Michael Kelley <mikelley@microsoft.com>
> > + */
> > +
> > +#ifndef _ASM_MSHYPERV_H
> > +#define _ASM_MSHYPERV_H
> > +
> > +#include <linux/types.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/clocksource.h>
> > +#include <linux/irq.h>
> > +#include <linux/irqdesc.h>
> > +#include <linux/arm-smccc.h>
> > +#include <asm/hyperv-tlfs.h>
> > +
> > +/*
> > + * Define the IRQ numbers/vectors used by Hyper-V VMbus interrupts
> > + * and by STIMER0 Direct Mode interrupts. Hyper-V should be supplying
> > + * these values through ACPI, but there are no other interrupting
> > + * devices in a Hyper-V VM on ARM64, so it's OK to hard code for now.
>=20
> I'm not convinced it is OK. If you don't try to do the right thing
> now, what is the incentive to do it later? Starting to hard code
> things is akin to going back to the ARM board files of old. Been
> there, managed to fix it, not going back to it again anytime soon.

I'll check back with the Hyper-V guys on getting appropriate values
assigned in ACPI.

>=20
> > + * The "CALLBACK_VECTOR" terminology is a left-over from the x86/x64
> > + * world that is used in architecture independent Hyper-V code.
> > + */
> > +#define HYPERVISOR_CALLBACK_VECTOR 16
> > +#define	HV_STIMER0_IRQNR	   17
> > +
> > +extern u64 hv_do_hvc(u64 control, ...);
> > +extern u64 hv_do_hvc_fast_get(u64 control, u64 input1, u64 input2, u64=
 input3,
> > +		struct hv_get_vp_register_output *output);
> > +
> > +/*
> > + * Declare calls to get and set Hyper-V VP register values on ARM64, w=
hich
> > + * requires a hypercall.
> > + */
> > +extern void hv_set_vpreg(u32 reg, u64 value);
> > +extern u64 hv_get_vpreg(u32 reg);
> > +extern void hv_get_vpreg_128(u32 reg, struct hv_get_vp_register_output=
 *result);
> > +
> > +/*
> > + * Use the Hyper-V provided stimer0 as the timer that is made
> > + * available to the architecture independent Hyper-V drivers.
> > + */
> > +#define hv_init_timer(timer, tick) \
> > +		hv_set_vpreg(HV_REGISTER_STIMER0_COUNT + (2*timer), tick)
> > +#define hv_init_timer_config(timer, val) \
> > +		hv_set_vpreg(HV_REGISTER_STIMER0_CONFIG + (2*timer), val)
> > +#define hv_get_current_tick(tick) \
> > +		(tick =3D hv_get_vpreg(HV_REGISTER_TIME_REFCOUNT))
> > +
> > +#define hv_get_simp(val) (val =3D hv_get_vpreg(HV_REGISTER_SIPP))
> > +#define hv_set_simp(val) hv_set_vpreg(HV_REGISTER_SIPP, val)
> > +
> > +#define hv_get_siefp(val) (val =3D hv_get_vpreg(HV_REGISTER_SIFP))
> > +#define hv_set_siefp(val) hv_set_vpreg(HV_REGISTER_SIFP, val)
> > +
> > +#define hv_get_synic_state(val) (val =3D hv_get_vpreg(HV_REGISTER_SCON=
TROL))
> > +#define hv_set_synic_state(val) hv_set_vpreg(HV_REGISTER_SCONTROL, val=
)
> > +
> > +#define hv_get_vp_index(index) (index =3D hv_get_vpreg(HV_REGISTER_VPI=
NDEX))
> > +
> > +#define hv_signal_eom()	hv_set_vpreg(HV_REGISTER_EOM, 0)
> > +
> > +/*
> > + * Hyper-V SINT registers are numbered sequentially, so we can just
> > + * add the SINT number to the register number of SINT0
> > + */
> > +#define hv_get_synint_state(sint_num, val) \
> > +		(val =3D hv_get_vpreg(HV_REGISTER_SINT0 + sint_num))
> > +#define hv_set_synint_state(sint_num, val) \
> > +		hv_set_vpreg(HV_REGISTER_SINT0 + sint_num, val)
> > +
> > +#define hv_get_crash_ctl(val) \
> > +		(val =3D hv_get_vpreg(HV_REGISTER_CRASH_CTL))
> > +#define hv_get_time_ref_count(val) \
> > +		(val =3D hv_get_vpreg(HV_REGISTER_TIME_REFCOUNT))
> > +#define hv_get_reference_tsc(val) \
> > +		(val =3D hv_get_vpreg(HV_REGISTER_REFERENCE_TSC))
> > +#define hv_set_reference_tsc(val) \
> > +		hv_set_vpreg(HV_REGISTER_REFERENCE_TSC, val)
> > +#define hv_enable_vdso_clocksource()
> > +#define hv_set_clocksource_vdso(val) \
> > +		((val).vdso_clock_mode =3D VDSO_CLOCKMODE_NONE)
> > +
> > +#if IS_ENABLED(CONFIG_HYPERV)
>=20
> I don't think this guards anything useful.

You are probably right.  I'll double-check.

>=20
> > +#define hv_enable_stimer0_percpu_irq(irq)	enable_percpu_irq(irq, 0)
> > +#define hv_disable_stimer0_percpu_irq(irq)	disable_percpu_irq(irq)
>=20
> and this looks pretty premature.

I'm not sure I understand your comment about "premature".  Could
you clarify?

>=20
> > +#endif
> > +
> > +/* ARM64 specific code to read the hardware clock */
> > +#define hv_get_raw_timer() arch_timer_read_counter()
> > +
> > +/* SMCCC hypercall parameters */
> > +#define HV_SMCCC_FUNC_NUMBER	1
> > +#define HV_FUNC_ID	ARM_SMCCC_CALL_VAL(			\
> > +				ARM_SMCCC_STD_CALL,		\
> > +				ARM_SMCCC_SMC_64,		\
> > +				ARM_SMCCC_OWNER_VENDOR_HYP,	\
>=20
> This is only defined in patch #2...

Indeed. :-(   I'll fix as part of breaking up this patch into smaller
pieces.

Michael

>=20
> > +				HV_SMCCC_FUNC_NUMBER)
> > +
> > +#include <asm-generic/mshyperv.h>
> > +
> > +#endif
>=20
> Thanks,
>=20
> 	M.
>=20
> --
> Jazz is not dead, it just smells funny.
