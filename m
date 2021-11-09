Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADCAB44B3A7
	for <lists+linux-arch@lfdr.de>; Tue,  9 Nov 2021 20:59:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244087AbhKIUCa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 9 Nov 2021 15:02:30 -0500
Received: from mail-cusazon11021021.outbound.protection.outlook.com ([52.101.62.21]:50723
        "EHLO na01-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S244043AbhKIUC3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 9 Nov 2021 15:02:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LcKp+F9L99yclt8DIfFfVlCczJJVrS7itaiZUPow0X8KErhG33nTKsLIO2eAY5nHSozhzOnCyAYz5lK1KDhGdDhSTUg6Kcd0yBCwvJhhKaD3whpYs9zwB6TqUdjE1X5TuX76u2mE6wrAghzEviL6T+aRe1EQJQP2HgficgwFwC2y31+1KuFtkn63tFQIyxTxPPCthQfIVT75TV7U6I4xF695+7/ei0aTYnE4E1JdgyorCr5dxSd8JeW9t6+DK8hYgbEomM+IHLakN0nYPzSA+9igQw/FxHnXoLMV+ZF9dwzJ2YEadxa/H8o0orVAtNCAiEpYa3mwnY8QDSn0Ru1FWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KkL0OrppIFlT/RAj7nncL1hMiQrBflJGXZYlpB1R9QY=;
 b=FacvhrtJwDs5kpIGe8Ye62i6K0FtFAb9b3vB8FeHuLB3j/JvYQc/k2J96xsIPqJ9AGjI/jYK2MnJvlvdIcKU8KduzC+QQum5gq88BKm6aVjcSc1enWbJIrrQC5hqJFfvMlRqKqg3QNP/2ZkZVS74cNsRoI1AnwN+/fuyUQHxDP2GSpuGMnHAEhLMHG84W4I11hEDqGdCuRzDPUIXySP/tWcWkzZDp+aDGLjLlgDdCBhEmY/XWfn5OJehRWWl/o2CxkjNdC1ui8plXau+9nmNBk/vNrzfN8q9m9VnRTLskjVU9DaU38xZ/6ACzPyAuNDXa9Pc6i4HJrzeMqEv0+36pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KkL0OrppIFlT/RAj7nncL1hMiQrBflJGXZYlpB1R9QY=;
 b=B5nLsllwqPl5ccq0QrS52ePwYJpNL0GocDpAc+NUURcIe5qMN3O7b1n1NgUezeQoxYn819USeF2zk7K9YeDgPPbph3RQ6YOmS/CDPxf7vH6UjzqZonSDRLTZc4NZkv98GyUQOmvjHKqmTviuONtyNIY59XX64vMb3/K/H72TNp8=
Received: from BN8PR21MB1140.namprd21.prod.outlook.com (2603:10b6:408:72::11)
 by BN6PR21MB0739.namprd21.prod.outlook.com (2603:10b6:404:93::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.3; Tue, 9 Nov
 2021 19:59:39 +0000
Received: from BN8PR21MB1140.namprd21.prod.outlook.com
 ([fe80::48fb:8577:ba03:23a5]) by BN8PR21MB1140.namprd21.prod.outlook.com
 ([fe80::48fb:8577:ba03:23a5%9]) with mapi id 15.20.4713.005; Tue, 9 Nov 2021
 19:59:39 +0000
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
Subject: RE: [EXTERNAL] Re: [PATCH v3 2/2] arm64: PCI: hv: Add support for
 Hyper-V vPCI
Thread-Topic: [EXTERNAL] Re: [PATCH v3 2/2] arm64: PCI: hv: Add support for
 Hyper-V vPCI
Thread-Index: AQHXwRPJfc88rRp3+kGAJBZn+crNwKviKogAgBmVX8A=
Date:   Tue, 9 Nov 2021 19:59:39 +0000
Message-ID: <BN8PR21MB1140993E5135043F2542EAB7C0929@BN8PR21MB1140.namprd21.prod.outlook.com>
References: <1634226794-9540-1-git-send-email-sunilmut@linux.microsoft.com>
        <1634226794-9540-3-git-send-email-sunilmut@linux.microsoft.com>
 <87lf2itwf3.wl-maz@kernel.org>
In-Reply-To: <87lf2itwf3.wl-maz@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=8c328f50-0b81-4974-972f-aca7e119fb51;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-11-09T19:36:02Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ca15191c-c247-4d9f-ae73-08d9a3bb7688
x-ms-traffictypediagnostic: BN6PR21MB0739:
x-microsoft-antispam-prvs: <BN6PR21MB0739D5638E225E30DE7FBF61C0929@BN6PR21MB0739.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qW0z3FhZnCDOCkeD49r+2ngIwcV5Cww0CvbWoGZWLxI5nCvllifKUlK2ExmIsKYyU3cSg3WFtR831NCHu5bFwbNcsTckuYNf9S403yTmFVp5pH37ziCjyHnzEXkndVAYpQQkqyDFUJF5XWneHSPDKoR/OEMWBmtXIL/cMxM8k3I8jYqNfd3165yVSGOgBRcoqQ/R/IZ2hgvxP+Pl6PDklhU1QmlglhCVb93KEtk320hWlA8Q9uQmfhuAkso2b1Tt+BuV1oX5rdxbU3mkoAv9u2kC3eNxvEE71+gzi1T5bBxN1orrURUfXIilymXdTkhSitUv2ZpkI0gmdQlmwch4VyIqojFX2UPKBXnwuAzjWkkMw37UZrgD9LS5PJMi6ju7nH1LazzZ/oKfWZTDQfBVwNX/1F0beFTXZaPPgLcpm2TX/tS0u70DvHyLlL7StcfeYMOshtIy2k7We+C04u/CNSGfSWKKsU/zd7JNMRSgxO7ittBaUzIyf1iQCpBiI0eHz6bcwrOzTBHoARl6y5bO8WoRnyfHHwXDG1MIXh4ab/4DuENbmKE9dWSHa0IZ8OKUrJTEcjBdx74qrWAV9ySg3AET5xu3Tzr21/Fx0se/CajZUGpQbeumBzYeySX3cMcl48Ckcaq1Kbe/moFfiV+RAPsePT+YY86bojSC37Q+xkLJpDSZO46V0R3BvwHgIYyR1Q9kNZCrzWnejd2IoI6gcQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR21MB1140.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(64756008)(55016002)(66476007)(66556008)(7416002)(7696005)(66946007)(83380400001)(8936002)(71200400001)(8990500004)(66446008)(53546011)(86362001)(9686003)(52536014)(316002)(6506007)(186003)(8676002)(10290500003)(33656002)(82950400001)(110136005)(76116006)(38070700005)(82960400001)(54906003)(508600001)(5660300002)(4326008)(122000001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8EhWZ0B3sepaRrjyTAOyI9lq21ubSzlDU1COcpinTJJD+aerWA6XWVElBDHK?=
 =?us-ascii?Q?+Bicgq+cxnQ3LWzuKXqV3lH0GuZvsLDJtXuwGfCalsl9HOY55wyCztiLB9HN?=
 =?us-ascii?Q?tJTg5ALNt5XnRCqszlTw0nD7Z+xDczMPbkBVVZ0tVBweVWd4NF5WZ8pTtorn?=
 =?us-ascii?Q?uuSYiV0JpAWmjaunGY38KUlD/RlObFqj9p1mdWMq5ursR+OOyHWZhQhlT1lB?=
 =?us-ascii?Q?NmcUEFVqGhSPgOEljunyfFoADEKSfhfBgr6gcijKjftxdH/LJd/ZDTNouU6o?=
 =?us-ascii?Q?A/TcNQ36q7BR7MeunnZVPl1hpemlGORstBusNPTJwB4Cp76ta0zNQk1MI+OV?=
 =?us-ascii?Q?7JVL5M7PNhOfhF0KjYAIY6DhhpTP0xvt30lmedtqgU34XwBit23+i59pzurS?=
 =?us-ascii?Q?kajvhfaHrAselETXGljgLaaQPHtCJNeADpMlGhMHroL863zVqgOJwF6tT4jl?=
 =?us-ascii?Q?UI+avnZ3Q6iDZ8MfHC1Oto4E8/7eRFRsyg0I5pZs/VtlUErnBUreNAx26TW2?=
 =?us-ascii?Q?cH+wSV1PoWdnVzuHWeOkubBX5cDpPJ4LNQjGUtlGEvitQYCAws8f4AOCQehp?=
 =?us-ascii?Q?y+6vs8BhPSe51Ipni8In7Doql51Rjjeshg157+u4J0DXOq5gfQXjNjAXFoxN?=
 =?us-ascii?Q?sLucXXuYbcyp/Gm3/1/EUNY8b3NKjKFgAMcOlaVWtmiKjVQ1VDnsXkdLr4JA?=
 =?us-ascii?Q?mE1U2Amfe1yocSyb61ezqQUeRSweCCKpyJAI9aXi6sfjgMoDvwh32+so9fxE?=
 =?us-ascii?Q?sY6SFeZ9ezRr10PYsxH/6U8otunBeQecOeKsOUEoViZ3JZq8QuYhdzyetHZc?=
 =?us-ascii?Q?m8fDU9elRzdprwj6ru0thY88I4mu5PCqTPtkj8HCyrP7OS3X83UY61jKaqD+?=
 =?us-ascii?Q?Vbhzj9vPQqQxaASmR6wCU3oYaOS2Ab+4CA/ZfDrr0x48+B4l6rjTNCPnqjj1?=
 =?us-ascii?Q?Bw8jO1dz8JCuMtLjZ0hGc4ClDun5b2wvg8zxGcPO7lEPlFSFT3FIl35QFQIU?=
 =?us-ascii?Q?LxQBQKmbBq2uwhxipAy0Hvc5tAmRAEGp7z5nsAUBRQ6ZBUQwmJgAsEjDNAUL?=
 =?us-ascii?Q?PIJWYPGrH3lV8MmVtORty2BxLFMxZhJBg/04CmglMlkNI/mwupWx8KcpOrnm?=
 =?us-ascii?Q?TWy9WAU3rKgZRzYLDnVKv8A8GFBGlwlc5O9JEllBq8hZui2qhRx51NKYb8FE?=
 =?us-ascii?Q?lyeiYbjU068Xez46JhOM1lngzyti6QPQ66v3Z2XZazBfKyzFXuLfPdttQ4nD?=
 =?us-ascii?Q?VAcOuQOGHlC7Jx18lFW87lsmL3cqw9/JoZBKV5gx7midsgENN8PIIAONgdnq?=
 =?us-ascii?Q?KEINp5YkhNg08AnmrljFY+MOlrHGNyREo+0d+yuoZfS0h5eZGvDUaBDFF/o+?=
 =?us-ascii?Q?54s7MCHDm/RPSqDhe10/Wi4E3hG36gA9zZBQFnsr8UT1LPkn9GI0mP1A3RlV?=
 =?us-ascii?Q?iF/QRU3AcX48RNrS3pJXTgwzWP6OsjBUf25Ar0LPSF+IIf5HtoYIFny+3Ke/?=
 =?us-ascii?Q?TiYYrN89a/mgh2yIdt7laJb7mlyoL2huRUzTPZ6deBPDcspO5Uc1wqV9vRwx?=
 =?us-ascii?Q?Sg4Ufx2gH6H+0wtCuW27K9KsG1PqYq68WMg9AgS9B3RDsd/EtM01zRuKwVmG?=
 =?us-ascii?Q?yFpOLQ2oEiD+WLJ5tnMgfDEtsBei21DOdb//CDRZheqLbfKKGPpHW2e27GFa?=
 =?us-ascii?Q?DSW2+hX2a2T0LO+CLT4zXEJ8MMiF4eL7cJb7LQ7uXwM8JMitfVO0yy26iT92?=
 =?us-ascii?Q?0u+g4UKfZg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR21MB1140.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca15191c-c247-4d9f-ae73-08d9a3bb7688
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2021 19:59:39.0937
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WT6kld80Woftf71QEmomv6Bn4W8U/GKeU0Ioc/nq/MBYX3Fhoe1IzlJQEyul5yIYGMoXy3HRR239M9JrgQksMAZ/OU0lu8IdPAwOaSTUnvM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR21MB0739
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sunday, October 24, 2021 5:55 AM,
Marc Zyngier <maz@kernel.org> wrote:

> > From: Sunil Muthuswamy <sunilmut@microsoft.com>
> >
> > Add support for Hyper-V vPCI for ARM64 by implementing the arch specifi=
c
> > interfaces. Introduce an IRQ domain and chip specific to Hyper-v vPCI t=
hat
> > is based on SPIs. The IRQ domain parents itself to the arch GIC IRQ dom=
ain
> > for basic vector management.
> >
> > Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> > ---
> > In v2 & v3:
> >  Changes are described in the cover letter.
> >
> > +unsigned int hv_msi_get_int_vector(struct irq_data *irqd)
> > +{
> > +	irqd =3D irq_domain_get_irq_data(hv_msi_gic_irq_domain, irqd->irq);
> > +
> > +	return irqd->hwirq;
>=20
> Really??? Why isn't this just:
>=20
> 	return irqd->parent_data->hwirq;
>=20
> instead of reparsing the whole hierarchy?

Thanks, getting addressed in v4.

> > +static int hv_pci_vec_irq_domain_activate(struct irq_domain *domain,
> > +					  struct irq_data *irqd, bool reserve)
> > +{
> > +	/* All available online CPUs are available for targeting */
> > +	irq_data_update_effective_affinity(irqd, cpu_online_mask);
>=20
> This looks odd. Linux doesn't use 1:N distribution with the GIC, so
> the effective affinity of the interrupt never targets all CPUs.
> Specially considering that the first irq_set_affinity() call is going
> to reset it to something more realistic.
>=20
> I don't think you should have this at all, but I also suspect that you
> are playing all sort of games behind the scenes.

Thanks for the '1:N' comment. The reason for having this is that Hyper-V
vPCI compose MSI msg code (i.e. 'hv_compose_msi_msg') needs to have
some IRQ affinity to pass to the hypervisor. For x86, the 'x86_vector_domai=
n'
takes care of that in the 'x86_vector_activate' call. But, GIC v3 doesn't
implement a '.activate' callback and so at the time of the MSI composition
there is no affinity associated with the IRQ, which causes the Hyper-V
MSI compose message to fail. The idea for doing the above was to have
a temporary affinity in place to satisfy the MSI compose message until
the GIC resets the affinity to something real. And, when the GIC will
reset the affinity, the 'unmask' callback will cause the Hyper-V vPCI code
to retarget the interrupt to the 'real' cpu.
=20
In v4, I am changing the ' hv_pci_vec_irq_domain_activate' callback to
pick a cpu for affinity in a round-robin fashion. That will stay in affect
until the GIC will set the right affinity and the vector will get retargete=
d.

> > +
> > +	return 0;
> > +}
> > +
> > +static const struct irq_domain_ops hv_pci_domain_ops =3D {
> > +	.alloc	=3D hv_pci_vec_irq_domain_alloc,
> > +	.free	=3D hv_pci_vec_irq_domain_free,
> > +	.activate =3D hv_pci_vec_irq_domain_activate,
> > +};
> > +
> > +int hv_pci_irqchip_init(struct irq_domain **parent_domain,
> > +			bool *fasteoi_handler,
> > +			u8 *delivery_mode)
> > +{
> > +	static struct hv_pci_chip_data *chip_data;
> > +	struct fwnode_handle *fn =3D NULL;
> > +	int ret =3D -ENOMEM;
> > +
> > +	chip_data =3D kzalloc(sizeof(*chip_data), GFP_KERNEL);
> > +	if (!chip_data)
> > +		return ret;
> > +
> > +	mutex_init(&chip_data->map_lock);
> > +	fn =3D irq_domain_alloc_named_fwnode("Hyper-V ARM64 vPCI");
> > +	if (!fn)
> > +		goto free_chip;
> > +
> > +	hv_msi_gic_irq_domain =3D acpi_irq_create_hierarchy(0,
> HV_PCI_MSI_SPI_NR,
> > +							  fn,
> &hv_pci_domain_ops,
> > +							  chip_data);
> > +
> > +	if (!hv_msi_gic_irq_domain) {
> > +		pr_err("Failed to create Hyper-V ARMV vPCI MSI IRQ
> domain\n");
> > +		goto free_chip;
> > +	}
> > +
> > +	*parent_domain =3D hv_msi_gic_irq_domain;
> > +	*fasteoi_handler =3D true;
> > +
> > +	/* Delivery mode: Fixed */
> > +	*delivery_mode =3D 0;
>=20
> I discussed this to death in the previous patch.

Thanks, getting fixed in v4 as part of the move to pci-hyperv.c

> > +
> > +	return 0;
> > +
> > +free_chip:
> > +	kfree(chip_data);
> > +	if (fn)
> > +		irq_domain_free_fwnode(fn);
> > +
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL(hv_pci_irqchip_init);
> > +
> > +void hv_pci_irqchip_free(void)
> > +{
> > +	static struct hv_pci_chip_data *chip_data;
> > +
> > +	if (!hv_msi_gic_irq_domain)
> > +		return;
> > +
> > +	/* Host data cannot be null if the domain was created successfully */
> > +	chip_data =3D hv_msi_gic_irq_domain->host_data;
> > +	irq_domain_remove(hv_msi_gic_irq_domain);
>=20
> No. Once an interrupt controller is enabled, it should never go away,
> because we have no way to ensure that all the corresponding interrupts
> are actually gone. Unless you can prove that at this stage, all
> devices are gone and cannot possibly generate any interrupt, this is
> actively harmful.

Thanks for the comment. Getting fixed in v4.

> >
> > @@ -1597,6 +1602,7 @@ static struct irq_chip hv_msi_irq_chip =3D {
> >  	.irq_compose_msi_msg	=3D hv_compose_msi_msg,
> >  	.irq_set_affinity	=3D hv_set_affinity,
>=20
> This really is irq_chip_set_affinity_parent.

Yes, but I didn't touch this because that is original code. But, I am updat=
ing this
in v4 now.

> >  	.irq_ack		=3D irq_chip_ack_parent,
> > +	.irq_eoi		=3D irq_chip_eoi_parent,
> >  	.irq_mask		=3D hv_irq_mask,
> >  	.irq_unmask		=3D hv_irq_unmask,
> >  };
>=20
> Overall, please kill this extra module, move everything into
> pci-hyperv.c and drop the useless abstractions. Once you do that, the
> code will be far easier to reason about.
>=20

Thanks, yes, this is getting addressed in v4.

- Sunil
