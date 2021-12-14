Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E05054739BE
	for <lists+linux-arch@lfdr.de>; Tue, 14 Dec 2021 01:47:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244511AbhLNArD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 Dec 2021 19:47:03 -0500
Received: from mail-co1nam11lp2170.outbound.protection.outlook.com ([104.47.56.170]:9383
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233802AbhLNArD (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 13 Dec 2021 19:47:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JC8jvn5T5D5Q6XabL4ULekJ/3X+BVpTW2yIZiaR2Gc58XB7Bhfxrmsf4GRRzBrxL/3Uq3U+siCi6hjGlXa5r/DyDNxrWjGLsuFTUErTJZZLxD7i8gAUR6VJ/erND6rUq3Dv7J/B2jBtbUsF/1NtqbvJiDC+4HRnDBmrXo5gtlD0ZjHxWCG000V0MR7pDjjZXJ/XwxCxDqqQmV8HTx0aeeRzQt5E0SmFRY3/vDvv2H7CW5V1TKmFVuLSL+QZB2dcKWiUUTrDv1bSyyVzLCtywX9ruW1j7WIp7fus/4PukjttI+PGfrRqdGBTY4BrTzxWvmv3Hpq9PdCfgHdEzDi/OJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g1T9Z/x99VfOQnRWyEaPpcOLzuGRvEgRoL3IbK2og7o=;
 b=NdMmTRQTpPP5onD+HmQ+txvPKkwYmA8//gcA55xHiqmAc0EAb5Ou9oh495x7MDNRiJpjBD5GbzOIvAYY/CeFZKuOoW0MtwHSjx4iB1RPteSjtUijsVQJA1oZKv2Ij5AfooJOcd+HgQkkfaLlLQ5AxoGGUk2GvxHMi3fbGrgxGdFdT24BVkRK9ZHSexwXlv4yBX5+QE+Xi4jKx1oNpJVgKtG+LtK92LmF1eYeGmASrdcmWkFSieK5xaD8Ju45oljpZLXdjbBldQQtD0Px8vM7uPUkw7rd9nH+MOcxvIwkuQWBt4MDjuDSAq8+kEJjVchXl+6a6sssAmEKDuHNCc8uTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g1T9Z/x99VfOQnRWyEaPpcOLzuGRvEgRoL3IbK2og7o=;
 b=Ub0WJvFgImPYdZiN+cktFCfDMls/0l4g2vHJrA9HK2mFQSnj8V/Rp1vlT62PKqHKyMI83mxFH7dG+Qsf90HVdHHquctsu4+8QWyuDDIx9cb9g/wfFyyuZpHyVy4NqAJzHCOUMuZWpM1DuJYhR8CaJwiPE/Ep2O6aGCAk58iCQrI=
Received: from BN8PR21MB1140.namprd21.prod.outlook.com (2603:10b6:408:72::11)
 by DM5PR21MB1851.namprd21.prod.outlook.com (2603:10b6:3:87::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.5; Tue, 14 Dec
 2021 00:46:59 +0000
Received: from BN8PR21MB1140.namprd21.prod.outlook.com
 ([fe80::b5b2:afd4:68e0:cade]) by BN8PR21MB1140.namprd21.prod.outlook.com
 ([fe80::b5b2:afd4:68e0:cade%7]) with mapi id 15.20.4823.005; Tue, 14 Dec 2021
 00:46:59 +0000
From:   Sunil Muthuswamy <sunilmut@microsoft.com>
To:     Marc Zyngier <maz@kernel.org>,
        Sunil Muthuswamy <sunilmut@microsoft.com>
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
Subject: RE: [EXTERNAL] Re: [PATCH v6 2/2] arm64: PCI: hv: Add support for
 Hyper-V vPCI
Thread-Topic: [EXTERNAL] Re: [PATCH v6 2/2] arm64: PCI: hv: Add support for
 Hyper-V vPCI
Thread-Index: AQHX3FmOZOjXOoUUfkSC0w1opVcY7awLANCAgCZKjcA=
Date:   Tue, 14 Dec 2021 00:46:59 +0000
Message-ID: <BN8PR21MB114040F48FB7F3988BA95032C0759@BN8PR21MB1140.namprd21.prod.outlook.com>
References: <1637225490-2213-1-git-send-email-sunilmut@linux.microsoft.com>
        <1637225490-2213-3-git-send-email-sunilmut@linux.microsoft.com>
 <875yso6tbi.wl-maz@kernel.org>
In-Reply-To: <875yso6tbi.wl-maz@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=fee5e140-dd0f-45bb-83a7-6e329258b4ed;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-12-14T00:32:10Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a9991329-9e52-4f50-7a29-08d9be9b3cd2
x-ms-traffictypediagnostic: DM5PR21MB1851:EE_
x-microsoft-antispam-prvs: <DM5PR21MB1851848F91E7AA20D72A7387C0759@DM5PR21MB1851.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /9ecqgErj1RPMzxO60/kG+umLIxqbEJlLg5K6XTWBFR9Cocmx2sqdngwLCwpsGTu2YbaXohres+JHt9jMiaVw7D8NlLVvTS1WhzZp5bcmM1XZp2N6tTG3w253a2gX85mdyjL4+jh7kpqjZ8Tkm7xke+obe1zGZokyzL8UemLtbuRhpbktH3LQeVfyHI5r5eUiaCLWsfYiUAO3m/tDBUYOA2zH1GhZCn3Rce9XUpcLYlGqB9kKRHC1/5CT+yDnYVtN0A01bHz5PnS7KOUJ3R9RXLZYUTyVB6L+BkIEeK75k1jchWoeTwRFMoQoCP/bPHVFGgNdopoOJrcXogsbeCMI63PQcsZ3mc+RikF0V+teg/YfVNekE6NdKzZqtSDtf367k3QpUln+Gr2FchUJlc4HkwJmhAzQ2827QcmabGvblRH1SSQogouYQQdh0bc5Ter+TrBdJZe2bRgkwjTAudhoaXPojgwflsqAaONXRkAiNFs/aGv3fik4rJLWKjEX+PEjsJwXEh0UYCFin1Kf0gQsUuazSHBJO+gF2EQvC4mwR9a5gthQEA4tGSO36wfsN0fDI1n+r10CFyggRhFUP6R6MyLk3szqHizX62UtZmuaEVgU+3n6e+2q+42OTQ+z8WwyDepp4Sy+bDvhtIMpXXZD269F7iAHfu4AMUFzuDptkzzS5DYLg0O9bLYEDRCp4V/6gvnPSh4NYl9Sf0108HrDCWBV/xCXquR8YhylAsNfIwGFsT7VTPUIQy2sdjTrcNW
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR21MB1140.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38070700005)(122000001)(76116006)(64756008)(38100700002)(4326008)(66476007)(66556008)(8676002)(7696005)(5660300002)(7416002)(54906003)(53546011)(66446008)(110136005)(316002)(8936002)(508600001)(71200400001)(66946007)(86362001)(10290500003)(82950400001)(186003)(55016003)(52536014)(33656002)(9686003)(8990500004)(83380400001)(6506007)(2906002)(82960400001)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?n6SSDuRmMj1TDQgr39zvgyS3Pqb07SkjIBSAd29923Lq8OZul818ISQSgZuF?=
 =?us-ascii?Q?5zDWfNjWUbU6xDKsy40b2ctliF0LJ351y5wstRvPbBd8GZDI70YWlwysB252?=
 =?us-ascii?Q?juHFsgsxeED5hRksClDABQISdsOAmq4ZjDKmIqN+dQ5Dhq4DdmS2w/Bls0Xp?=
 =?us-ascii?Q?vIDsPMHv5j0ukNL1aidBCo4F01Cfl+qDFIWIyY55ROskQSAyv8IV3oQR7hp/?=
 =?us-ascii?Q?NVI9jcodSTtPzZDdl62g7PSi84X20RZDuZQED9GOgvg0qD0LA8zvQiZTmBPM?=
 =?us-ascii?Q?mfIgefN/xIcwqqGQ9id6Jr+Mu5kULsVveJnl+VofiZFzc9anRJywLIdFnHdy?=
 =?us-ascii?Q?t/U9mdeBhEjFnmPxmw6KT/w+4l3ov50HxWV4EwcytKnfwAohOv1cVds18ETl?=
 =?us-ascii?Q?aXzZjBbSOpVvIbHXZc0sl8C+tl9P8L7uRuBWnMBypcT5Umf+rwfSXRmXi03k?=
 =?us-ascii?Q?gsXbz2CQDnipAjCs86zfCf8dmrIOYJP3GElzGBTCVxILUMwk44GnodYd6FG8?=
 =?us-ascii?Q?wYCzVryk6BCkkDXbK89gAsTo83W8naM/WsVcy6FMh2oytHt9cfIZ7wq1QbEW?=
 =?us-ascii?Q?7jjI0X/FgJHn0eztj8tRh2aOOOpRBkQflaiLQebH38+mFQNr7WXmEMc2A9Lk?=
 =?us-ascii?Q?ogrFEacWWyhZD3yMOJ6D6AlP0KuQbly7mGWSmSOQ0xzxKl+ka/NyQG+8CHOj?=
 =?us-ascii?Q?Wlzxy0s4RZ+MVLHvbQMbxqauETne9nmbnirxYt69iZ5LmZe/VWhx7IzdaioR?=
 =?us-ascii?Q?RY8frsjDPW9mL0oo82fJS6f6e5l46r0VXN5lWTFUrf9p7wfh71KbJaJEB5Cd?=
 =?us-ascii?Q?eR/B4PbMlcjx1X544xJ2MbVYXA7WMNGr5zZSD5ZmdN1S2kyT3WB/35dn8RhN?=
 =?us-ascii?Q?Gl5u15T1+L7q2HLrCYMotkZ8zOXasBPtAn3hk/EDWzKo7Ima9b99cUkz7k3p?=
 =?us-ascii?Q?CGOTe+9kA913Ei7/pOq4fEYD9kd97ugZpXWIbVezYes1vdKI/ZnRa7sjddvo?=
 =?us-ascii?Q?eQm4eezlzIqj0Kw5abPgk5SYuAUu+Lv8JfSAChzQSZ6f6WeezbtyYL8FbT3w?=
 =?us-ascii?Q?0n6Nxl7S7d5EesazB5/Js0Kb/dbqENKm0RS+wS6aUrBOYNLMP5V1bhlmFhmB?=
 =?us-ascii?Q?hDNpmovuFlPStzOgQdvfPMhWlTIAXuvAByoVM5mQyp5xUXzWfwOEXac6NsBS?=
 =?us-ascii?Q?8KdWSE6HT6Kd/8PyinjNr4s+I28qPnOcD384nX/vDwf4g9hSa1/JSdaWOziC?=
 =?us-ascii?Q?eue51cYl7albB2wrHYlgDjVCnsUygQRP2wYvsQkEmfVKG1y39Xlv3cFUbezR?=
 =?us-ascii?Q?hdjdii9mqxoc8wjCOnQTGZUuHvcnX61rwtv6vNP6qaCaXWU2yPrZ3SPpT4st?=
 =?us-ascii?Q?WWzFKOpXv45xOlUiHYCAo1eV+11B12Kv6Jmjw6SZd1pfpBz9ZZYfpWOthn9O?=
 =?us-ascii?Q?AUtNFQXairG1sfK46w6XUbQ90g7NqZVI6lq0oR7yALMyO/ZgplDNbZSYub2V?=
 =?us-ascii?Q?fpP5tH0olLw58+NVe9IjPb/cA5Y7KVMXlcBjy7sMkwB0Th59mfG7Vbce0HxO?=
 =?us-ascii?Q?StYGIL5mdnry1bkXo+PtZxVff/crImLRKEhxPrLP9DTRPxh7t0efropdkWaG?=
 =?us-ascii?Q?5Wa1jChRQUuh6pOEG8qemqEp7QR93ubJnGfC51IvgWmGBv929o6YtquEx8hb?=
 =?us-ascii?Q?hgWeTHJd8AxdL67TCY0iqc/blzKgKH9sGmdoteEfypFRH4YRMovLuoASzOTG?=
 =?us-ascii?Q?BGkFHh1Y8Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR21MB1140.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9991329-9e52-4f50-7a29-08d9be9b3cd2
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2021 00:46:59.7471
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vihonr5MSLRlOc0CED3HVXhGUOehxrjmYf2y6FZ+U7MigWcrO2x+5gZ5mn9WF4uKZ1bqFtJpNX5zjoGAJtf1dNA0Ck5M3u5dF35ae2uu2Ls=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB1851
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Friday, November 19, 2021 7:47 AM,
Marc Zyngier <maz@kernel.org> wrote:

[nip..]

> > +static int hv_pci_vec_alloc_device_irq(struct irq_domain *domain,
> > +				       unsigned int nr_irqs,
> > +				       irq_hw_number_t *hwirq)
> > +{
> > +	struct hv_pci_chip_data *chip_data =3D domain->host_data;
> > +	unsigned int index;
> > +
> > +	/* Find and allocate region from the SPI bitmap */
> > +	mutex_lock(&chip_data->map_lock);
> > +	index =3D bitmap_find_free_region(chip_data->spi_map,
> > +					HV_PCI_MSI_SPI_NR,
> > +					get_count_order(nr_irqs));
> > +	mutex_unlock(&chip_data->map_lock);
> > +	if (index < 0)
> > +		return -ENOSPC;
> > +
> > +	*hwirq =3D index + HV_PCI_MSI_SPI_START;
> > +
> > +	return 0;
> > +}
> > +
> > +static int hv_pci_vec_irq_gic_domain_alloc(struct irq_domain *domain,
> > +					   unsigned int virq,
> > +					   irq_hw_number_t hwirq)
> > +{
> > +	struct irq_fwspec fwspec;
> > +
> > +	fwspec.fwnode =3D domain->parent->fwnode;
> > +	fwspec.param_count =3D 2;
> > +	fwspec.param[0] =3D hwirq;
> > +	fwspec.param[1] =3D IRQ_TYPE_EDGE_RISING;
> > +
> > +	return irq_domain_alloc_irqs_parent(domain, virq, 1, &fwspec);
>=20
> I think you are missing the actual edge configuration here. Since the
> interrupt specifier doesn't come from either DT or ACPI, nobody will
> set the trigger type, and you have to do it yourself here. At the
> moment, you will get whatever is in the GIC configuration.
>=20

I see, thanks. So, just a call of irq_set_irq_type(IRQ_TYPE_EDGE_RISING)?

> > +}
> > +
> > +static int hv_pci_vec_irq_domain_alloc(struct irq_domain *domain,
> > +				       unsigned int virq, unsigned int nr_irqs,
> > +				       void *args)
> > +{
> > +	irq_hw_number_t hwirq;
> > +	unsigned int i;
> > +	int ret;
> > +
> > +	ret =3D hv_pci_vec_alloc_device_irq(domain, nr_irqs, &hwirq);
> > +	if (ret)
> > +		return ret;
> > +
> > +	for (i =3D 0; i < nr_irqs; i++) {
> > +		ret =3D hv_pci_vec_irq_gic_domain_alloc(domain, virq + i,
> > +						      hwirq + i);
> > +		if (ret)
> > +			goto free_irq;
> > +
> > +		ret =3D irq_domain_set_hwirq_and_chip(domain, virq + i,
> > +						    hwirq + i,
> > +						    &hv_arm64_msi_irq_chip,
> > +						    domain->host_data);
> > +		if (ret)
> > +			goto free_irq;
> > +
> > +		pr_debug("pID:%d vID:%u\n", (int)(hwirq + i), virq + i);
> > +	}
> > +
> > +	return 0;
> > +
> > +free_irq:
> > +	hv_pci_vec_irq_domain_free(domain, virq, nr_irqs);
> > +
> > +	return ret;
>=20
> How about the interrupts that have already been allocated?

Not sure I am fully following. If you are referring to the failure path and=
 the
interrupts that were allocated, then I am calling ' hv_pci_vec_irq_domain_f=
ree'
which should free the interrupts from the bitmap and the parent irq domain.
Can you please clarify?
=20
>=20
> > +}
> > +
> > +/*
> > + * Pick the first online cpu as the irq affinity that can be temporari=
ly used
> > + * for composing MSI from the hypervisor. GIC will eventually set the =
right
> > + * affinity for the irq and the 'unmask' will retarget the interrupt t=
o that
> > + * cpu.
> > + */
> > +static int hv_pci_vec_irq_domain_activate(struct irq_domain *domain,
> > +					  struct irq_data *irqd, bool reserve)
> > +{
> > +	int cpu =3D cpumask_first(cpu_online_mask);
> > +
> > +	irq_data_update_effective_affinity(irqd, cpumask_of(cpu));
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
> > +static int hv_pci_irqchip_init(void)
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
>=20
> This will appear in debugfs. I'd rather you keep it short, sweet and
> without spaces. "hv_vpci_arm64" seems better to me.

Sure, will fix in next version.

> >
> > @@ -1619,6 +1820,7 @@ static struct irq_chip hv_msi_irq_chip =3D {
> >  	.irq_compose_msi_msg	=3D hv_compose_msi_msg,
> >  	.irq_set_affinity	=3D irq_chip_set_affinity_parent,
> >  	.irq_ack		=3D irq_chip_ack_parent,
> > +	.irq_eoi		=3D irq_chip_eoi_parent,
> >  	.irq_mask		=3D hv_irq_mask,
> >  	.irq_unmask		=3D hv_irq_unmask,
>=20
> You probably want to avoid unconditionally setting callbacks that may
> have side effects on another architecture (ack on arm64, eoi on x86).

Thanks. Will fix in next version.

Is there some other feedback that would like to see get addressed in the
current patch? Trying to close down on all remaining feedback items here.

- Sunil



