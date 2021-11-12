Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8042844DF50
	for <lists+linux-arch@lfdr.de>; Fri, 12 Nov 2021 01:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234589AbhKLAxA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 11 Nov 2021 19:53:00 -0500
Received: from mail-cusazon11021020.outbound.protection.outlook.com ([52.101.62.20]:46655
        "EHLO na01-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234546AbhKLAxA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 11 Nov 2021 19:53:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kQPPzn8uJuTmg56zhLvXf9MinUnzMRPNTshFR1pBdsW+ZuA/rsSglJVCarDIj9VFNOk6NCgzsKpGb+r0ggLIG6ipoFG0HkeuVPId2RMQNLTYAdmqLYW2c7z4cBENGqbppJEZKl1IyZSWQ23dguvQqJAEZCnGu1kjGF3p+i20tOaGV+S7QG67J1+TlPear7I1KDxSZq7j0H2ufbxxmmBzywA1wQFhndLU+26+s4LHiJpr9aE2j1t/XPLaDYkvZeoa+TECVgqVjsweEZrq+N7qfaZQjRpmWqR43MD21uC9f0dVNgEwPEPdaVs/d2VuiBsWT5M4Iq0nBZWNuMFiwgbmXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oymulsOOOXSRXjVrU0NJ8J+bTrz44gMVDajrrgtGqXo=;
 b=hKrHsA6nlq3cwwVvULwPObMWORWeoJ/EKGqJ7uqTP1CiLU1PS+c8w6QWIYUVIKkTixRVWm2wAqNLIA14qvYreaY7lvjT5h//bOlXS9/YyB+yJ9dJI/sXCF/dlGhiwmDU7hWpXhKYpe6tAJQGWsS0Zjy+t/Gc9MBmgR9lLMjhy6NOfBjNXMDTJV+w5vKcJprVPocMMLGRbjCk6GH7NaOVTcTlvw8kMlNe95Ed/EoFLAS7iFrZIWUpK+ONPkTtYAKpTc8ILxQEY0oCq9CcobaLH2KQfZGJ5UCByl+JPNq48IssiBSyM5/OQa30FwqDZU/Mtt4CA3TSiFCf2jnikljjIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oymulsOOOXSRXjVrU0NJ8J+bTrz44gMVDajrrgtGqXo=;
 b=U3dEeK1B9DXMNnJmYhmnEBSjs7MXJizWYc6ZfoELK3xlbwnBohsLXJMd0pZyaI5bEcIneUFf0/2XcgG+HTzINEtzNQm2ab2Crw0FChhKLdZ5o+Kuh4D6vDDYj3OuJq8cxVQcbIK/s0gW0ds8q6d5l4ybPVRciLU/1G+aimGP71c=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MW4PR21MB1969.namprd21.prod.outlook.com (2603:10b6:303:7c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.10; Fri, 12 Nov
 2021 00:50:07 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::b01f:ac55:463a:dd91]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::b01f:ac55:463a:dd91%4]) with mapi id 15.20.4669.002; Fri, 12 Nov 2021
 00:50:07 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Sunil Muthuswamy <sunilmut@linux.microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "maz@kernel.org" <maz@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "robh@kernel.org" <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "arnd@arndb.de" <arnd@arndb.de>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Sunil Muthuswamy <sunilmut@microsoft.com>
Subject: RE: [PATCH v5 2/2] arm64: PCI: hv: Add support for Hyper-V vPCI
Thread-Topic: [PATCH v5 2/2] arm64: PCI: hv: Add support for Hyper-V vPCI
Thread-Index: AQHX1muWUKNVFx3PLU2btjDmVCQGjqv/ENuA
Date:   Fri, 12 Nov 2021 00:50:06 +0000
Message-ID: <MWHPR21MB1593AF30DB2EC06B057FC283D7959@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <1636573510-23838-1-git-send-email-sunilmut@linux.microsoft.com>
 <1636573510-23838-3-git-send-email-sunilmut@linux.microsoft.com>
In-Reply-To: <1636573510-23838-3-git-send-email-sunilmut@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=560e9958-680c-4bf2-a6f6-c49518c89557;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-11-12T00:47:20Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0e72934f-5ce0-42d1-a601-08d9a5765f2b
x-ms-traffictypediagnostic: MW4PR21MB1969:
x-microsoft-antispam-prvs: <MW4PR21MB196933D3E6D1261516DC2582D7959@MW4PR21MB1969.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7dPikVxEg6siSDP/7aKbV+adSH2wLrj6WIkc2yGORKKVmQBnEvpD/E/+hnOTLCkou2xV1Gs/0APagjOQjDmXjGN7VOC57v5lDd+IOubOftUdMthWtr3onpqRc1yt5NhutJHbs3NOnb81FyuhPXex7tiBOv7Pzp2TndUfij7rfyAaVYeh3d3v9LhLa59BcEBHOCaNuyksCLaEq0Ibf+z2YfbkuGQK4GP9g9CNlr04F29z/G8I6sDchX/fxUU1CwIVpjy9xmyWiXO1Z4uxMMBZxO3vy28GP/Qx77WwqGdbVFP/jduQI4Q0s9RFdgbyK8ePYO3ZMKk9o05IFVw5RGp60gGJnamE77fTfgrwQcHLLRE60kt4c5wejv8gcVv6Xgn2cx5PABfhILtb1wyCkhfs3k8OGNjv2QnifYyM/ri/ZrjwPK/oB1GH/1X0ujgI/4ztHW7J9BtknrGl1hi+CNrnkgnHRYmQN4B1UMsWxJrJHJW0qcXlAT2RVy7U8SAhDFlFW8MPs42oU7Jf4XDmwbtVwLYOvTEAe1VLAA56F5yk5Z+e6nLnoApEzdm+P+C+9w5cV2LyB+/1el+CGJgQLwBbrEYCHM8QTy4J0BddZ+LgiX2Sau2GSW5W5biheafcADWJMJUx8R/cp73Gtsa4PUzUVdVwtq78YxQX6+uDhWkvZpJ5USJXOR9t8TAEWa6QQ44uZwLfy3OsFO+lQGPyUwiRPhaFzAV3fkTXxXrgp8ogHyI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(33656002)(71200400001)(10290500003)(508600001)(52536014)(66946007)(86362001)(9686003)(76116006)(26005)(186003)(7416002)(107886003)(4326008)(7696005)(6506007)(8936002)(8676002)(110136005)(64756008)(66476007)(316002)(54906003)(66446008)(66556008)(5660300002)(82960400001)(82950400001)(83380400001)(2906002)(38070700005)(921005)(38100700002)(122000001)(8990500004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8u8bEz7avCWRNnaNUPz6FF4mk5ia/orMtBsmJ5+XjNyfh79zAvVYcqLcggXo?=
 =?us-ascii?Q?J4WjVAk6R3JcfZ42Rs34hzgaf1V35dhS1vyxkgyp1RodyJQ+u5LQTlvo3UgA?=
 =?us-ascii?Q?fKGyVCG6vfA8JoI73jlFMp+srFFzXbUMuvhnFe4X9lDnBv09DzmXPa0hVDvW?=
 =?us-ascii?Q?f9ACqHAuOo03hjrI+zHqNlr5IA2uESSWJyvMjlCyOZWc/KOTrlQxmi1lUhJs?=
 =?us-ascii?Q?niD8XUM52yWzxcE25rzeKeRc1Rh6bBFqPH0sRGciFwB50D4pd/IS+Xb8NDF3?=
 =?us-ascii?Q?NV+FrDwiMXBbcIb/UeD+4RaZnuz+r3hC3whzcR+uQbto4nt+3QGS1IMO/uhF?=
 =?us-ascii?Q?gmrdV6QqhGK0Bpq6lNH+/wvXDyXBig9ymvgzkj5hLiNdztryPwtgkaOmTnKP?=
 =?us-ascii?Q?qpnniCTaAAj8dGs1zQuUyqjE1oTsdesPx/SP7ltOBHLeHTJuLkQZZrLyQEye?=
 =?us-ascii?Q?fcUOceXrtiim6gqsn8mAPOIDJv0F3O4MMTe1PVK/im4LwqL2x3MnS796tATS?=
 =?us-ascii?Q?vC9UegxRb8ereFHzrCSEm5IC4eOD1UpYELO667hqGIILJEG7GIgK0cNyydbC?=
 =?us-ascii?Q?z1b2Ptq+ZOh2bxVB3aoPIqGPKDdgswe0dU/HNWGjQosH+rHXhXXr1vR4yum5?=
 =?us-ascii?Q?r0F39hZWYpA6IaEDdZjO8KqG+ph2SP1qYV1Ufmbzn7NRzcMH9agMx+HG2VLT?=
 =?us-ascii?Q?VKbexhJ10Ammgx4mf92GsmYSUGwRoEVJo1U+N8oy4+GbBV8q+/ltLe4PoA1H?=
 =?us-ascii?Q?fs/Gr3EpW8UGHUbHdIi7qsC00fj4yfa68LhQ2Ggbqj8Gg0jRPjuZkNt/IOoP?=
 =?us-ascii?Q?JKad/6urFGiBuBCEkkN4AJ36DAvWNGAOIh250tJ/XlVBwvoBKgMBn7+i1YQv?=
 =?us-ascii?Q?Tr7VqnbXpTryweg4eQXy1DdJlK3KMz5TPGjF5U4nOChoxo3ZQ9EVhlC6gKUd?=
 =?us-ascii?Q?V+halk264Se3THCbyMpaAE4m3jsxuZS1jIyIYVXqORYRP8jAqLvxzntAV55G?=
 =?us-ascii?Q?aMORlTfcJC7tjZjEYQSIA/t8y5QrB8ZthR/bvArSpJIFTG7PlkJZ7eEtbORm?=
 =?us-ascii?Q?BS2m2dScn6jZSHw5anEovXCRQS3WC3UsUCsAYNHj0HTEQWYfHX+lCww5+tr1?=
 =?us-ascii?Q?jOCNzXr77bsHskvVxFKgjzoXJUjA8ZSk0+9eS8/xVK4eWB+8HxlG5PODM0gF?=
 =?us-ascii?Q?ldQzh/Tl/jenHbQ1xwRrwnlT7p4DDomW3tyJkbUuNT/eI5NP7JmAU4e4FsQE?=
 =?us-ascii?Q?PWgMs81Hw2DThCIVBCOVRLwfzV9X6OHNthZjtOo2gtN1Lr1V9nb2p/bnE60R?=
 =?us-ascii?Q?DI87Qpz358Eq5K6fvrsnkB2tMakXNeB+N0CchS0/b6a8Knt4JndwRlzgXSHn?=
 =?us-ascii?Q?V6TRGi06IH6zOZRBtu0Q5DH7S1g+y0nCQaoX2z6oRy3dPUZlRvvNKD6LwdCz?=
 =?us-ascii?Q?PWMfWX0+FYvcKfMmvP6+Ni9Q5abv6uW+2WqNuTiW0Vvpmj1lkohZCHzur2N2?=
 =?us-ascii?Q?/bHYnRDcd9qiodrUJEHDz63BFdsza1egLk3ft19KL7ckRgLQISn22t01OPVc?=
 =?us-ascii?Q?A1UxYVvcGJgJ/de+gHx6pPbleece02YfXOlmHluV+I0tXvf6sWh2VUUNnCaP?=
 =?us-ascii?Q?R2t3a8EHS8I+Q6xHau1rGwF9pSgF36iSCRIraR8rXbTXuOX7l/DdWaNLhOVj?=
 =?us-ascii?Q?jnjZxQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e72934f-5ce0-42d1-a601-08d9a5765f2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2021 00:50:06.9756
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kpBa4wsM+oEEm1i7+TNeDzpAYkGnbDKN9d53VPVgd8hL9zV6spyzMYsstXFizferB+BzxVXmQI3u2MXAnRgFTXfa4SX1wc6h3wXNoN3q1SA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB1969
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Sunil Muthuswamy <sunilmut@linux.microsoft.com> Sent: Wednesday, Nove=
mber 10, 2021 11:45 AM
>=20
> Add support for Hyper-V vPCI for arm64 by implementing the arch specific
> interfaces. Introduce an IRQ domain and chip specific to Hyper-v vPCI tha=
t
> is based on SPIs. The IRQ domain parents itself to the arch GIC IRQ domai=
n
> for basic vector management.
>=20
> Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> ---
> In v2, v3, v4 & v5:
>  Changes are described in the cover letter.
>=20
>  arch/arm64/include/asm/hyperv-tlfs.h |   9 ++
>  drivers/pci/Kconfig                  |   2 +-
>  drivers/pci/controller/Kconfig       |   2 +-
>  drivers/pci/controller/pci-hyperv.c  | 204 ++++++++++++++++++++++++++-
>  4 files changed, 214 insertions(+), 3 deletions(-)
>=20

[snip]

> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller=
/pci-hyperv.c
> index 03e07a4f0e3f..b13e3ae5a34f 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -47,6 +47,8 @@
>  #include <linux/msi.h>
>  #include <linux/hyperv.h>
>  #include <linux/refcount.h>
> +#include <linux/irqdomain.h>
> +#include <linux/acpi.h>
>  #include <asm/mshyperv.h>
>=20
>  /*
> @@ -614,7 +616,202 @@ static int hv_msi_prepare(struct irq_domain *domain=
, struct device *dev,
>  {
>  	return pci_msi_prepare(domain, dev, nvec, info);
>  }
> -#endif // CONFIG_X86
> +#elif defined(CONFIG_ARM64)
> +/*
> + * SPI vectors to use for vPCI; arch SPIs range is [32, 1019], but leavi=
ng a bit
> + * of room at the start to allow for SPIs to be specified through ACPI a=
nd
> + * starting with a power of two to satisfy power of 2 multi-MSI requirem=
ent.
> + */
> +#define HV_PCI_MSI_SPI_START	64
> +#define HV_PCI_MSI_SPI_NR	(1020 - HV_PCI_MSI_SPI_START)
> +#define DELIVERY_MODE		0
> +#define FLOW_HANDLER		NULL
> +#define FLOW_NAME		NULL
> +#define hv_msi_prepare		NULL
> +
> +struct hv_pci_chip_data {
> +	DECLARE_BITMAP(spi_map, HV_PCI_MSI_SPI_NR);
> +	struct mutex	map_lock;
> +};
> +
> +/* Hyper-V vPCI MSI GIC IRQ domain */
> +static struct irq_domain *hv_msi_gic_irq_domain;
> +
> +/* Hyper-V PCI MSI IRQ chip */
> +static struct irq_chip hv_arm64_msi_irq_chip =3D {
> +	.name =3D "MSI",
> +	.irq_set_affinity =3D irq_chip_set_affinity_parent,
> +	.irq_eoi =3D irq_chip_eoi_parent,
> +	.irq_mask =3D irq_chip_mask_parent,
> +	.irq_unmask =3D irq_chip_unmask_parent
> +};
> +
> +static unsigned int hv_msi_get_int_vector(struct irq_data *irqd)
> +{
> +	return irqd->parent_data->hwirq;
> +}
> +
> +static void hv_set_msi_entry_from_desc(union hv_msi_entry *msi_entry,
> +				       struct msi_desc *msi_desc)
> +{
> +	msi_entry->address =3D ((u64)msi_desc->msg.address_hi << 32) |
> +			      msi_desc->msg.address_lo;
> +	msi_entry->data =3D msi_desc->msg.data;
> +}
> +
> +static void hv_pci_vec_irq_domain_free(struct irq_domain *domain,
> +				       unsigned int virq, unsigned int nr_irqs)
> +{
> +	struct hv_pci_chip_data *chip_data =3D domain->host_data;
> +	struct irq_data *irqd =3D irq_domain_get_irq_data(domain, virq);
> +	int first =3D irqd->hwirq - HV_PCI_MSI_SPI_START;
> +
> +	mutex_lock(&chip_data->map_lock);
> +	bitmap_release_region(chip_data->spi_map,
> +			      first,
> +			      get_count_order(nr_irqs));
> +	mutex_unlock(&chip_data->map_lock);
> +	irq_domain_reset_irq_data(irqd);
> +	irq_domain_free_irqs_parent(domain, virq, nr_irqs);
> +}
> +
> +static int hv_pci_vec_alloc_device_irq(struct irq_domain *domain,
> +				       unsigned int nr_irqs,
> +				       irq_hw_number_t *hwirq)
> +{
> +	struct hv_pci_chip_data *chip_data =3D domain->host_data;
> +	unsigned int index;
> +
> +	/* Find and allocate region from the SPI bitmap */
> +	mutex_lock(&chip_data->map_lock);
> +	index =3D bitmap_find_free_region(chip_data->spi_map,
> +					HV_PCI_MSI_SPI_NR,
> +					get_count_order(nr_irqs));
> +	mutex_unlock(&chip_data->map_lock);
> +	if (index < 0)
> +		return -ENOSPC;
> +
> +	*hwirq =3D index + HV_PCI_MSI_SPI_START;
> +
> +	return 0;
> +}
> +
> +static int hv_pci_vec_irq_gic_domain_alloc(struct irq_domain *domain,
> +					   unsigned int virq,
> +					   irq_hw_number_t hwirq)
> +{
> +	struct irq_fwspec fwspec;
> +
> +	fwspec.fwnode =3D domain->parent->fwnode;
> +	fwspec.param_count =3D 2;
> +	fwspec.param[0] =3D hwirq;
> +	fwspec.param[1] =3D IRQ_TYPE_EDGE_RISING;
> +
> +	return irq_domain_alloc_irqs_parent(domain, virq, 1, &fwspec);
> +}
> +
> +static int hv_pci_vec_irq_domain_alloc(struct irq_domain *domain,
> +				       unsigned int virq, unsigned int nr_irqs,
> +				       void *args)
> +{
> +	irq_hw_number_t hwirq;
> +	unsigned int i;
> +	int ret;
> +
> +	ret =3D hv_pci_vec_alloc_device_irq(domain, nr_irqs, &hwirq);
> +	if (ret)
> +		return ret;
> +
> +	for (i =3D 0; i < nr_irqs; i++) {
> +		ret =3D hv_pci_vec_irq_gic_domain_alloc(domain, virq + i,
> +						      hwirq + i);
> +		if (ret)
> +			goto free_irq;
> +
> +		ret =3D irq_domain_set_hwirq_and_chip(domain, virq + i,
> +						    hwirq + i,
> +						    &hv_arm64_msi_irq_chip,
> +						    domain->host_data);
> +		if (ret)
> +			goto free_irq;
> +
> +		pr_debug("pID:%d vID:%u\n", (int)(hwirq + i), virq + i);
> +	}
> +
> +	return 0;
> +
> +free_irq:
> +	hv_pci_vec_irq_domain_free(domain, virq, nr_irqs);
> +
> +	return ret;
> +}
> +
> +/*
> + * Pick the first online cpu as the irq affinity that can be temporarily=
 used
> + * for composing MSI from the hypervisor. GIC will eventually set the ri=
ght
> + * affinity for the irq and the 'unmask' will retarget the interrupt to =
that
> + * cpu.
> + */
> +static int hv_pci_vec_irq_domain_activate(struct irq_domain *domain,
> +					  struct irq_data *irqd, bool reserve)
> +{
> +	int cpu =3D cpumask_first(cpu_online_mask);
> +
> +	irq_data_update_effective_affinity(irqd, cpumask_of(cpu));
> +
> +	return 0;
> +}
> +
> +static const struct irq_domain_ops hv_pci_domain_ops =3D {
> +	.alloc	=3D hv_pci_vec_irq_domain_alloc,
> +	.free	=3D hv_pci_vec_irq_domain_free,
> +	.activate =3D hv_pci_vec_irq_domain_activate,
> +};
> +
> +static int hv_pci_irqchip_init(void)
> +{
> +	static struct hv_pci_chip_data *chip_data;
> +	struct fwnode_handle *fn =3D NULL;
> +	int ret =3D -ENOMEM;
> +
> +	chip_data =3D kzalloc(sizeof(*chip_data), GFP_KERNEL);
> +	if (!chip_data)
> +		return ret;
> +
> +	mutex_init(&chip_data->map_lock);
> +	fn =3D irq_domain_alloc_named_fwnode("Hyper-V ARM64 vPCI");
> +	if (!fn)
> +		goto free_chip;
> +
> +	/*
> +	 * IRQ domain once enabled, should not be removed since there is no
> +	 * way to ensure that all the corresponding devices are also gone and
> +	 * no interrupts will be generated.
> +	 */
> +	hv_msi_gic_irq_domain =3D acpi_irq_create_hierarchy(0, HV_PCI_MSI_SPI_N=
R,
> +							  fn, &hv_pci_domain_ops,
> +							  chip_data);
> +
> +	if (!hv_msi_gic_irq_domain) {
> +		pr_err("Failed to create Hyper-V ARMV vPCI MSI IRQ domain\n");

Typo in the above error message:  "ARMV" should be "ARM64".

> +		goto free_chip;
> +	}
> +
> +	return 0;
> +
> +free_chip:
> +	kfree(chip_data);
> +	if (fn)
> +		irq_domain_free_fwnode(fn);
> +
> +	return ret;
> +}
> +
> +static struct irq_domain *hv_pci_get_root_domain(void)
> +{
> +	return hv_msi_gic_irq_domain;
> +}
> +#endif //CONFIG_ARM64

Use "C" style comments.

Michael
