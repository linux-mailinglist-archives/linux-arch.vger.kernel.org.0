Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86A3344B356
	for <lists+linux-arch@lfdr.de>; Tue,  9 Nov 2021 20:38:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242002AbhKITln (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 9 Nov 2021 14:41:43 -0500
Received: from mail-cusazon11021018.outbound.protection.outlook.com ([52.101.62.18]:26783
        "EHLO na01-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231249AbhKITlm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 9 Nov 2021 14:41:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QoxTWKwgMEqR6xQDkbqalPFfWhBndAlAvzAS1idKXXFAXOBP5K93RoZkbFCe0fDwJnTpFSdgYbUi5wyOSePFEeoenprkUGYln/L2/RS6kKOXMVl5BL+wjSu/iy0IC0NSrWBKGZnkkU6KlYj0tesUWKLoC/L/Zfc4IAIYGhw1ShC+c+Y8ra1cTm1+NqEKVhsR7JCUxiEhYX1+RzmwrT60aopcBVPRVCeoW7hdKfnDPH4Tz240P5u3AwjXLfQraO57yAmMSCQuc9FVcfBErPtJNDK42DbdXDGtd+hoc42zgx37KvOeW1YZi8smz0IDXVyeNn0zMvRveMinEl2wUmQ6ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9o+JExxJax92CQkzT6VOdtUJFCJb7mhds/1xyi5mL5I=;
 b=EGgs1rK2SQJzKx03XRMdE5rEVDp3wlGX7SDlGM11BkcqjYO9p8HaEi/FRpX+pw576wflUMtFjJhSeYEpxqgHMG7Sg3MTFV/L3xky55G5lmbbzaQp7S1iUk2XjAOZNbsAuAJmUE99/mUwUNf8O0KkCgcrb3saP82f7mfzhRD7dHWVZImWgqOWPmLwekGKbLdqdxlW19Fjj9PzzmOgTfH2RvdqjgxJ5XKViwx8l6mo7IjafSqPdRVPa7Pg3+7UrV6Wy2hrHXYrqt/AfHRCDyTUqrKgAzUR/n+/BULZjdHkoo2M84DaXDUJ2pLJXJvlPiRkKRPmRQr8HmQ59TMRwbtuCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9o+JExxJax92CQkzT6VOdtUJFCJb7mhds/1xyi5mL5I=;
 b=gYIAGJmOBIvF/hJcTaPVJ8ri7tXP5+A91NwrF/x/28iz5AnVlPGn5PjI7qInr9dhhssAwDsQ+1rRHkOvPZ8gmmwvaiNJFS9Fjs91aUeG5WtInahF/vi2uH2yQf6sRRMk8rxGlroqsBXASC6D8WTptTXY55/4jT3/GSntGno4CCg=
Received: from BN8PR21MB1140.namprd21.prod.outlook.com (2603:10b6:408:72::11)
 by BN8PR21MB1140.namprd21.prod.outlook.com (2603:10b6:408:72::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.3; Tue, 9 Nov
 2021 19:38:52 +0000
Received: from BN8PR21MB1140.namprd21.prod.outlook.com
 ([fe80::48fb:8577:ba03:23a5]) by BN8PR21MB1140.namprd21.prod.outlook.com
 ([fe80::48fb:8577:ba03:23a5%9]) with mapi id 15.20.4713.005; Tue, 9 Nov 2021
 19:38:52 +0000
From:   Sunil Muthuswamy <sunilmut@microsoft.com>
To:     Marc Zyngier <maz@kernel.org>,
        Sunil Muthuswamy <sunilmut@linux.microsoft.com>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "robh@kernel.org" <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "arnd@arndb.de" <arnd@arndb.de>, "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH v3 1/2] PCI: hv: Make the code arch neutral
 by adding arch specific interfaces
Thread-Topic: [EXTERNAL] Re: [PATCH v3 1/2] PCI: hv: Make the code arch
 neutral by adding arch specific interfaces
Thread-Index: AQHXwRPKo1wIQ2n9aUePdw/5KVA2saviH+yAgBmZKqA=
Date:   Tue, 9 Nov 2021 19:38:51 +0000
Message-ID: <BN8PR21MB1140E751D4B23E6DED1149C3C0929@BN8PR21MB1140.namprd21.prod.outlook.com>
References: <1634226794-9540-1-git-send-email-sunilmut@linux.microsoft.com>
        <1634226794-9540-2-git-send-email-sunilmut@linux.microsoft.com>
 <87mtmyty6e.wl-maz@kernel.org>
In-Reply-To: <87mtmyty6e.wl-maz@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=2bcd0c2e-1986-4920-9d58-78652846cec1;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-11-09T19:11:38Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4ea16ecc-bd81-4fec-9452-08d9a3b88f2b
x-ms-traffictypediagnostic: BN8PR21MB1140:
x-microsoft-antispam-prvs: <BN8PR21MB11405F77713FF76422DAE5EBC0929@BN8PR21MB1140.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GcH9KjpWaRdn+XgjnxlhqEulewxDfzbCsIVw5liWfbP0bCyHuRq3MaPROXNPX7mszDXKVXjZeF9d0MWBxwmRMfVU2r2/LQmBsOqP6Arla4f64wf+sWgHkaPdiUDSAkMOxc7aDn32uWoAPeJEpTjsJOHjD2JkHUEHfDlWh6R+vjaSk2dUBrhvZ2jUrZBtMDFBBWJ0TrWO0DvWFM01b0qCfMxofdk3JUqYalwJ1ED2miM01c3ZdItY0JZ24gIFh30phbBtqw/CYfH5egrgtU1LhxgWa/2qa4CepJyQmgeFT4R33OphDD5h1nSFKPF47iIySAfoaN394BwnJv4QCuq+EljgaI6IZ0MraCBTPosEPgusdiBUoQWwfns67HLN2TW4WQW2MkfNF6hFnDD3EwL+VhU6khplnlClrpSBgfJmd2XPM0unUQjJRAfmdDK37tzdbhHsBmJgcaxl6nzJ/GZH7QYycmbU6oi7E+sAEiFlMM9aE6Cgd3Kz0cMhhRzsAHPNhxxHXERqchhAbS8ELd7+KHN879FxUP0jh1uJXriMEq+c/qIGrElZGZlwgpqVQoFziRthEE2LI+YFv4W/zF8vaiidJnF/nd6TiYEBSR5eVwlNpgg74uNxStvcf8jP670/gZN0Y3mMXw/6PIxuZOqpdLJZvg9Bqaskzs9FlBZ9PW9ixe04/t2+L/sYl1ESgtaqW3xRcDxvcGKMoD9esSZHhw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR21MB1140.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(52536014)(71200400001)(4326008)(8936002)(508600001)(5660300002)(53546011)(66476007)(82960400001)(2906002)(9686003)(186003)(38070700005)(38100700002)(66446008)(82950400001)(7696005)(110136005)(54906003)(83380400001)(33656002)(122000001)(8676002)(10290500003)(66556008)(66946007)(316002)(8990500004)(64756008)(6506007)(7416002)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pcRDXs/07I0USwnaA+X624acMkLRjzSPpYqubqUx7JSxL2+F4aSk93Su9zch?=
 =?us-ascii?Q?RzEHX5jD/3UXB9s7UYKvGy3kiFGyZDCNRfHAdbYzs2vNyniZvoHLsM61hssj?=
 =?us-ascii?Q?/QlGpA50o2XzOXf+BXpunAoJpz16xzauGhL5BSZnuKFphiK+ubHV1x94Racn?=
 =?us-ascii?Q?gjSjWoj7+x2Ky84g1zFLBjU8f3HnNwqUkJniN+lqtNTqnMsMZrIjNdSBBMPE?=
 =?us-ascii?Q?ED4gQxWnOBU781DXE69/x95DyAvgNHyh4mz7fQh9+KRnLhrjHzSqIIO/6bM6?=
 =?us-ascii?Q?kc17FJa2esgfQl3Loul5ABzQ+mUiKO8QclyBrq4fMCnNcn80q0awiKDktjy0?=
 =?us-ascii?Q?MtiksxrBWcNHPiTRKCOGXn+ovl9v1fy/CVCXM6B4NHuZNXWkEyXQUP/WqMgX?=
 =?us-ascii?Q?TEarauwYRcypqlcgELpp/RdgsWUnzfZMBLTv8CDFK9FLsSE4m0RZ8FdgXq1e?=
 =?us-ascii?Q?rCrgh/fVcATWxSOxUtDF9Afk+i51FAvcl/tAeXr9NLE6HkzMxCbmNkNEbpkM?=
 =?us-ascii?Q?YQcZfNyddk+C+jIUio22hOtTZnzTsJRr2pFpsMtmE21AQuG1hrgmemGHTr70?=
 =?us-ascii?Q?93afUQ1pnI+rDgDHGVwLQewDq5SQnQKXZhwGQ1O1LIF7QOSLgplSkAJTYZYj?=
 =?us-ascii?Q?6iV+5QQRIQ1t5zBuLW6sfuWJi+mYsWnZSzuKDrZv0ub/2ItUsgAC4ywULgdn?=
 =?us-ascii?Q?n5FbCzlDZd7Lc4Ia9MCb6DsTj84Z73II/HCTPsVQT5Q7T8KHUT5oG1hnFriA?=
 =?us-ascii?Q?lkPn5JQEDw4/KJFxz15Fvd+qwo9HlWwRKa4DEPiVzDhlYUUMQiIyUeIbfRrJ?=
 =?us-ascii?Q?n+8HThdCO7BgdMYqCXv5k1Mwd6O2Jf3pMUjW83VoGraY+x7CGY+v2gcKo/t0?=
 =?us-ascii?Q?0SD1kQNEt2PIak1Rg5OZ+OXYIA7MguMJ5WpdVJzc477+mUL9bI8Z3nI7dCLu?=
 =?us-ascii?Q?XdxIikKnVb9d990H0dZP3hfFwNbPcD0ITXjaRYIOJ1NyfjAu0MzfT43896F3?=
 =?us-ascii?Q?X5dIkDTrsALJBlPpnltYCrJ7lakwzdzHJZGAQmJK7iYEkrxRIu1jOg/Q0dlk?=
 =?us-ascii?Q?fvz8qH0LfTC7RJFYjONlCO9oLgFJQSmwcX/7MmxPG1XQKQ8A4N4/0zU83nmt?=
 =?us-ascii?Q?n6T4oWARFWS7yMGDQsFrPOGTBG61tGap4tNkE63iStM4QVhuH4/+TDy6gQst?=
 =?us-ascii?Q?xUEYtcnFz2zpNLG8Dc0AWP6RM7ac5EvkR/1jCjHWsXj9YwGt4rNCj7teVfT9?=
 =?us-ascii?Q?7qk1qWctisgghk22cq1GUYCG4/fLBDqzAFLuQv5WEmpCRYUB6J6y6z6TbtIH?=
 =?us-ascii?Q?xfB/PWnHtXzJ9/gIxXywFO+yroTUfrtaKiR58qcRrLiBn9qSbuPLIx46so3B?=
 =?us-ascii?Q?Yb1cFBiYp0QF9NoshgakZHvn0zw3Ko0JG87j9q1liG2X8dx6dqICN9gDOt4K?=
 =?us-ascii?Q?bOgcY7bs01ikj+zyEfYznt+xWlIq3TSINDhrOOqNjHDVNCRXHWWQRqQzaIqt?=
 =?us-ascii?Q?7iXqP+qsxijltySK4cfJIH7K3565h0/TRadrDaVl5Tb4pu/BIOlYrYIN0gC+?=
 =?us-ascii?Q?Vr0gk4qZhdE8fBrlvWX50hR802LQoTSirwNxWTPeC1Eg5EC4OOLpNobY5DJf?=
 =?us-ascii?Q?kY71ObuYI93qIdcxWMLCuPTKFBNtsRItW2IcaXChDFn9BoEriEVUNRMYoDYF?=
 =?us-ascii?Q?ewEgPG8mSsaSJ2SBrWzIA+iSSfvCQcDP9SZgNnE1af/o9atftUsLwsWqSfcT?=
 =?us-ascii?Q?1+ccYgjPxg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR21MB1140.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ea16ecc-bd81-4fec-9452-08d9a3b88f2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2021 19:38:51.9444
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r0gxstcAw1OAbvav8Zt8Tl6+7IH87UW8VMMokX9nq3h1AKBS8Nita+sYRBstEwXE88hfeMqcEWV/lG3MMKFRv/ringasScrxk+u5YkIX1eY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR21MB1140
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sunday, October 24, 2021 5:17 AM,
Marc Zyngier <maz@kernel.org> wrote:

> > From: Sunil Muthuswamy <sunilmut@microsoft.com>
> >
> > Encapsulate arch dependencies in Hyper-V vPCI through a set of interfac=
es,
> > listed below. Adding these arch specific interfaces will allow for an
> > implementation for other arch, such as ARM64.
> >
> > Implement the interfaces for X64, which is essentially just moving over=
 the
> > current implementation.
>=20
> Nit: use architecture names and capitalisation that match their use in
> the kernel (arm64, x86) instead of the MS-specific lingo.

Thanks, will fix in v4.

> > +
> > +#ifdef CONFIG_X86_64
> > +int hv_pci_irqchip_init(struct irq_domain **parent_domain,
> > +			bool *fasteoi_handler,
> > +			u8 *delivery_mode)
> > +{
> > +	*parent_domain =3D x86_vector_domain;
> > +	*fasteoi_handler =3D false;
> > +	*delivery_mode =3D APIC_DELIVERY_MODE_FIXED;
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL(hv_pci_irqchip_init);
>=20
> Why do you need to export any of these symbols? Even if the two
> objects are compiled separately, there is absolutely no need to make
> them two separate modules.
>=20
> Also, returning 3 values like this makes little sense. Pass a pointer
> to the structure that requires them and populate it as required. Or
> simply #define those that are constants.

Thanks. In v4, I am moving everything back to pci-hyperv.c and this
will get addressed as part of that.

> > +
> > +void hv_pci_irqchip_free(void) {}
> > +EXPORT_SYMBOL(hv_pci_irqchip_free);
> > +
> > +unsigned int hv_msi_get_int_vector(struct irq_data *data)
> > +{
> > +	struct irq_cfg *cfg =3D irqd_cfg(data);
> > +
> > +	return cfg->vector;
> > +}
> > +EXPORT_SYMBOL(hv_msi_get_int_vector);
> > +
> > +void hv_set_msi_entry_from_desc(union hv_msi_entry *msi_entry,
> > +				struct msi_desc *msi_desc)
> > +{
> > +	msi_entry->address.as_uint32 =3D msi_desc->msg.address_lo;
> > +	msi_entry->data.as_uint32 =3D msi_desc->msg.data;
> > +}
> > +EXPORT_SYMBOL(hv_set_msi_entry_from_desc);
> > +
> > +int hv_msi_prepare(struct irq_domain *domain, struct device *dev,
> > +		   int nvec, msi_alloc_info_t *info)
> > +{
> > +	return pci_msi_prepare(domain, dev, nvec, info);
> > +}
> > +EXPORT_SYMBOL(hv_msi_prepare);
>=20
> This looks like a very unnecessary level of indirection, given that
> you end-up with an empty callback in the arm64 code. The following
> works just as well and avoids useless callbacks:
>=20
> #ifdef CONFIG_ARM64
> #define pci_msi_prepare	NULL
> #endif

Will get addressed in v4.

> >
> > +static struct irq_domain *parent_domain;
> > +static bool fasteoi;
> > +static u8 delivery_mode;
>=20
> See my earlier comment about how clumsy this is.

Thanks. Getting fixed in v4 as part of moving things back to pci-hyperv.c

> >  	/*
> > -	 * Honoring apic->delivery_mode set to APIC_DELIVERY_MODE_FIXED
> by
> > -	 * setting the HV_DEVICE_INTERRUPT_TARGET_MULTICAST flag results
> in a
> > +	 * For x64, honoring apic->delivery_mode set to
> > +	 * APIC_DELIVERY_MODE_FIXED by setting the
> > +	 * HV_DEVICE_INTERRUPT_TARGET_MULTICAST flag results in a
> >  	 * spurious interrupt storm. Not doing so does not seem to have a
> >  	 * negative effect (yet?).
>=20
> And what does it mean on other architectures?

The same applies to other architectures. Will address the comment update
In v4.

> >  	 */
> > @@ -1347,7 +1349,7 @@ static u32 hv_compose_msi_req_v1(
> >  	int_pkt->wslot.slot =3D slot;
> >  	int_pkt->int_desc.vector =3D vector;
> >  	int_pkt->int_desc.vector_count =3D 1;
> > -	int_pkt->int_desc.delivery_mode =3D APIC_DELIVERY_MODE_FIXED;
> > +	int_pkt->int_desc.delivery_mode =3D delivery_mode;
> >
> >  	/*
> >  	 * Create MSI w/ dummy vCPU set, overwritten by subsequent retarget
> in
> > @@ -1377,7 +1379,7 @@ static u32 hv_compose_msi_req_v2(
> >  	int_pkt->wslot.slot =3D slot;
> >  	int_pkt->int_desc.vector =3D vector;
> >  	int_pkt->int_desc.vector_count =3D 1;
> > -	int_pkt->int_desc.delivery_mode =3D APIC_DELIVERY_MODE_FIXED;
> > +	int_pkt->int_desc.delivery_mode =3D delivery_mode;
> >  	cpu =3D hv_compose_msi_req_get_cpu(affinity);
> >  	int_pkt->int_desc.processor_array[0] =3D
> >  		hv_cpu_number_to_vp_number(cpu);
> > @@ -1397,7 +1399,7 @@ static u32 hv_compose_msi_req_v3(
> >  	int_pkt->int_desc.vector =3D vector;
> >  	int_pkt->int_desc.reserved =3D 0;
> >  	int_pkt->int_desc.vector_count =3D 1;
> > -	int_pkt->int_desc.delivery_mode =3D APIC_DELIVERY_MODE_FIXED;
> > +	int_pkt->int_desc.delivery_mode =3D delivery_mode;
> >  	cpu =3D hv_compose_msi_req_get_cpu(affinity);
> >  	int_pkt->int_desc.processor_array[0] =3D
> >  		hv_cpu_number_to_vp_number(cpu);
> > @@ -1419,7 +1421,6 @@ static u32 hv_compose_msi_req_v3(
> >   */
> >  static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *=
msg)
> >  {
> > -	struct irq_cfg *cfg =3D irqd_cfg(data);
> >  	struct hv_pcibus_device *hbus;
> >  	struct vmbus_channel *channel;
> >  	struct hv_pci_dev *hpdev;
> > @@ -1470,7 +1471,7 @@ static void hv_compose_msi_msg(struct irq_data
> *data, struct msi_msg *msg)
> >  		size =3D hv_compose_msi_req_v1(&ctxt.int_pkts.v1,
> >  					dest,
> >  					hpdev->desc.win_slot.slot,
> > -					cfg->vector);
> > +					hv_msi_get_int_vector(data));
> >  		break;
> >
> >  	case PCI_PROTOCOL_VERSION_1_2:
> > @@ -1478,14 +1479,14 @@ static void hv_compose_msi_msg(struct irq_data
> *data, struct msi_msg *msg)
> >  		size =3D hv_compose_msi_req_v2(&ctxt.int_pkts.v2,
> >  					dest,
> >  					hpdev->desc.win_slot.slot,
> > -					cfg->vector);
> > +					hv_msi_get_int_vector(data));
> >  		break;
> >
> >  	case PCI_PROTOCOL_VERSION_1_4:
> >  		size =3D hv_compose_msi_req_v3(&ctxt.int_pkts.v3,
> >  					dest,
> >  					hpdev->desc.win_slot.slot,
> > -					cfg->vector);
> > +					hv_msi_get_int_vector(data));
> >  		break;
> >
> >  	default:
> > @@ -1601,7 +1602,7 @@ static struct irq_chip hv_msi_irq_chip =3D {
> >  };
> >
> >  static struct msi_domain_ops hv_msi_ops =3D {
> > -	.msi_prepare	=3D pci_msi_prepare,
> > +	.msi_prepare	=3D hv_msi_prepare,
> >  	.msi_free	=3D hv_msi_free,
> >  };
> >
> > @@ -1625,12 +1626,13 @@ static int hv_pcie_init_irq_domain(struct
> hv_pcibus_device *hbus)
> >  	hbus->msi_info.flags =3D (MSI_FLAG_USE_DEF_DOM_OPS |
> >  		MSI_FLAG_USE_DEF_CHIP_OPS | MSI_FLAG_MULTI_PCI_MSI |
> >  		MSI_FLAG_PCI_MSIX);
> > -	hbus->msi_info.handler =3D handle_edge_irq;
> > -	hbus->msi_info.handler_name =3D "edge";
> > +	hbus->msi_info.handler =3D
> > +		fasteoi ? handle_fasteoi_irq : handle_edge_irq;
> > +	hbus->msi_info.handler_name =3D fasteoi ? "fasteoi" : "edge";
>=20
> The fact that you somehow need to know what the GIC is using as a flow
> handler is a sure sign that you are doing something wrong. In a
> hierarchical setup, only the root of the hierarchy should ever know
> about that. Having anything there is actively wrong.

Thanks, comments below.

> >  	hbus->msi_info.data =3D hbus;
> >  	hbus->irq_domain =3D pci_msi_create_irq_domain(hbus->fwnode,
> >  						     &hbus->msi_info,
> > -						     x86_vector_domain);
> > +						     parent_domain);
> >  	if (!hbus->irq_domain) {
> >  		dev_err(&hbus->hdev->device,
> >  			"Failed to build an MSI IRQ domain\n");
> > @@ -3531,13 +3533,21 @@ static void __exit exit_hv_pci_drv(void)
> >  	hvpci_block_ops.read_block =3D NULL;
> >  	hvpci_block_ops.write_block =3D NULL;
> >  	hvpci_block_ops.reg_blk_invalidate =3D NULL;
> > +
> > +	hv_pci_irqchip_free();
> >  }
> >
> >  static int __init init_hv_pci_drv(void)
> >  {
> > +	int ret;
> > +
> >  	if (!hv_is_hyperv_initialized())
> >  		return -ENODEV;
> >
> > +	ret =3D hv_pci_irqchip_init(&parent_domain, &fasteoi, &delivery_mode)=
;
> > +	if (ret)
> > +		return ret;
>=20
> Having established that the fasteoi thing is nothing but a bug, that
> the delivery_mode is a constant, and that all that matters is actually
> the parent domain which is a global pointer on x86, and something that
> gets allocated on arm64, you can greatly simplify the whole thing:
>=20
> #ifdef CONFIG_X86
> #define DELIVERY_MODE	APIC_DELIVERY_MODE_FIXED
> #define FLOW_HANDLER	handle_edge_irq
> #define FLOW_NAME	"edge"
>=20
> static struct irq_domain *hv_pci_get_root_domain(void)
> {
> 	return x86_vector_domain;
> }
> #endif
>=20
> #ifdef CONFIG_ARM64
> #define DELIVERY_MODE	0
> #define FLOW_HANDLER	NULL
> #define FLOW_NAME	NULL
> #define pci_msi_prepare	NULL
>=20
> static struct irq_domain *hv_pci_get_root_domain(void)
> {
> 	[...]
> }
> #endif

Thanks. I have followed the above suggestion in v4.

> as once you look at it seriously, the whole "separate file for the IRQ
> code" is totally unnecessary (as Michael pointed out earlier), because
> the abstractions you are adding are for most of them unnecessary.

V4 will get rid of the separate file for the IRQ chip and that's getting
moved back to pci-hyperv.c and that should address this comment.
Thanks.

- Sunil
