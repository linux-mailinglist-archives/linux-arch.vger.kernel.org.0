Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33947434F12
	for <lists+linux-arch@lfdr.de>; Wed, 20 Oct 2021 17:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbhJTPce (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 20 Oct 2021 11:32:34 -0400
Received: from mail-mw2nam12on2097.outbound.protection.outlook.com ([40.107.244.97]:16352
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230192AbhJTPcd (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 20 Oct 2021 11:32:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YsElfGfJfJUHfzYe/1Bdj+iczxocvfYHtyIp4YwWC5QVi5Ug8Gq2TNR8v/sXIfDsOsBocj8m+rG4R14QYRfoKI5LPTaDurfR1V42KI+HiRKBODpfZ665+ID/SJIiwI6rFSq+MA5K+ufsEycUfEDsWzWMDTvEZZjIn3/eHXaYGqj7+HdUr3+KCD31FZb5Jlj7nh1Wu8MtvH1D5Jv9ScAgi03JzAlFOCkQpZUGCOdvR8xNaG3bIuem2pqmDUXSCV0w8eHfhapO9zrEUUPE6byC6f+tsjzZYwownZUDvIU24f+DqABM7Srj76yMyBzxZwcExdeWyeD7vxEhg8dkGNvXVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/bmfmh5cxTnczRNgaxLufAYBXXS7U/cF7c6c8x+88sg=;
 b=lRFmfJQrQVO6V1X4I8M7Vvblbhp3OCIgaN0xUR5maNoqkhSsHdcXRfL43fh082cLOcEFBrnPkZqFAJoOPKrW0s7sICMIOy3vr0Ffu0sxpobxH4v9FRr+nIS6tgbqDvhSfU7AY88OaOClP0mJENRC5D2P4M73q77XpvghXNJGJKz8v5Oy6uByGRIxR/H8pz76v9VScIxG8b8MUnTZOXY2X+YsgN2Uqu1vZHAu5IZOMkHhm7yTNeZM3DrWYDQ4S4nMCijC5MO2D99jPeC6XTXbz6MlsHeLxr/44hRlw9ABDOiz1OATzONWOLPU7pPVA5q6tSbv2iOFwXhYNIZkmdjFRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/bmfmh5cxTnczRNgaxLufAYBXXS7U/cF7c6c8x+88sg=;
 b=VzrWecZEx2ZK21iYEG+q1oJDmafEAxF1WKVwwqRj0vvhp288KMqbDluzFRd/5ILVa1rsVf5xXibLJ0w6WMglRgCsn8pZNv4PGhZFsrIH6dnZd1ot0J/wWN9jLta2L4nTbA7j1JubjJbIZ5moSE+UjZUSITNx+ayaQ0nnoe+VmhM=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MWHPR21MB0862.namprd21.prod.outlook.com (2603:10b6:300:77::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.4; Wed, 20 Oct
 2021 15:30:15 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::240b:d555:8c74:205c]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::240b:d555:8c74:205c%4]) with mapi id 15.20.4649.004; Wed, 20 Oct 2021
 15:30:15 +0000
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
Subject: RE: [PATCH v3 2/2] arm64: PCI: hv: Add support for Hyper-V vPCI
Thread-Topic: [PATCH v3 2/2] arm64: PCI: hv: Add support for Hyper-V vPCI
Thread-Index: AQHXwRPNGc6MFuj3UEWxVFUe+tFxpavcCqeQ
Date:   Wed, 20 Oct 2021 15:30:15 +0000
Message-ID: <MWHPR21MB15930056B36BAF44D5A52619D7BE9@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <1634226794-9540-1-git-send-email-sunilmut@linux.microsoft.com>
 <1634226794-9540-3-git-send-email-sunilmut@linux.microsoft.com>
In-Reply-To: <1634226794-9540-3-git-send-email-sunilmut@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=0282d205-c102-46d7-b1c8-6d487a044076;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-10-20T15:23:16Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b7ef42c6-efc6-488d-02b2-08d993de8416
x-ms-traffictypediagnostic: MWHPR21MB0862:
x-microsoft-antispam-prvs: <MWHPR21MB086210BDF3749A0E5425377AD7BE9@MWHPR21MB0862.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2Wk65zK5j2Xb3jlqOvSwoqgwPwF3Y0mtdW+ezr8G2yOxavmZ04DUbIhfJqATnn7FfDPO0m8b03/HAxJQJRECvNrBRJ0r4LtQE/6TQULHOpF6DuE7lNTk6noRL4+flEY0oDB/7SUD0QvovQNLid5m2IykUQqeM4CFeV1hU/lEnrEtg2EPPjfTwOC+Prko6Rd/6MRp5+7sc0LmXV42Hh1Q1DpXVTx4TMZovfB/qbIspNJ9Xhj/KXBYYYKFiSG+6BfK+2f6howBeJQ6fTjkroHh1z66Zo+S3GboVR98KG9xOmdSc+TmsYo7u9F2VhcGmF3f7awKXlA868iXrUHdCNxXjRSqrHutwU/oRTYEeA2JA4TiGkOcJJ+Ss6ILFahBpJlh81rE9gMcIJ6Hi+iKJAu/nAQKbVwnKsw7OUnRi9qXYfMrt3mCzyYBV+J4On/OtP/0JKLhqyFCtvL7jAobiyl7xZl2sXgHLTDPY8f0dfcbFhxaG8baNrWs/HGTKgWNcthNWI+44uHf3Ro3SIOxNokFtGciNw2b+DPFsTPBRAjan5tEXim5GEUqYoKUMte2r9PpiibSdAEhrhHe/q2SS/xi46jAz2+RpUYZ8fqSxU+EnPtIe9j3+4pwnlXs+LEo5LgKFyswj2B2orhHDhSeiWTCtjNsK0YTgx4HN8E+8fwpxsQgLVtxai1xVP9G7idBKRLURvvbvk+sIdyek80sbh0i7RsVmZKYvJcANNFS+JWCaSQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(9686003)(122000001)(83380400001)(4326008)(7416002)(107886003)(2906002)(76116006)(8676002)(10290500003)(38100700002)(82960400001)(82950400001)(316002)(55016002)(508600001)(64756008)(66946007)(66446008)(186003)(66556008)(66476007)(52536014)(6506007)(71200400001)(7696005)(26005)(921005)(54906003)(8990500004)(8936002)(33656002)(38070700005)(5660300002)(110136005)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NcjErlzbv908q7t6LbLRdn0XxFbJvCbJgcUI+zb+yP9Ke4M+XqdGDUF5CoG7?=
 =?us-ascii?Q?DBB3SZ6Zaoix+d3dwammuSnjDwe2iUJ9Dpem53U7tYCF/8d9N3zGoygsX1pi?=
 =?us-ascii?Q?ejEtuNBzfE4tMENrCgJavp9IJ2nTArSbyilHPNiPXvl9IJxtsUbCg9wQe8UG?=
 =?us-ascii?Q?2hTDIomE4NBC4WmGbyFB+QajDcbwpg0hkKVCswYJb7fQhCV6PAG2YjXJzkap?=
 =?us-ascii?Q?6UIWrxJxHtyu2cDaGw+VwiCVD81cE8Omm+VXxf+B+xxmUNR+/hJ01iukv2W7?=
 =?us-ascii?Q?o7bVBcnOGwOrgY+OnJQ6OC4qAnWi5ke6wu2rwYTpHVgYfWW76KE7xa8+lmHx?=
 =?us-ascii?Q?VSJMbrj8lnmEb0SGuv39zCkZT/gxcGUyWDzAS7hIqW0fTg6PIAng9fP4UMRN?=
 =?us-ascii?Q?c49TDNAP29ebVb1YjEp5V55B2VgoMavbwmh6CsPL+H+9WwS3d16KfT/XxA8a?=
 =?us-ascii?Q?rsHTLuqfzEOmDUIS41V24G1Vp03WYz2saBiXBR8DeDDfiD5jp3p0rJD9R8Gm?=
 =?us-ascii?Q?1yOmdnaxmMhNNY0TFzBM7TB/mmU9oWxmyBUQy717t+V4a9vzT5wb2fulk4hm?=
 =?us-ascii?Q?zVKjdK2tl6XkAGq4ii54OiEaTCIl5mZf9dUzdAf2JkV7FgcjDnsHvMLY8BaQ?=
 =?us-ascii?Q?ig726/MIXWWUVl4pr5hPt/pOUGo1EPucaODIf01UeW0+hX6ISUE6KzRXt2uv?=
 =?us-ascii?Q?slR8lpt0Sk/jyVvX3hd1Xd8ZXth5+FoTg5grp3cZASt55lK9RYjBldVT7Pgx?=
 =?us-ascii?Q?4gfSmmXtaSrFTvgz4NEDX0JM7PPwmDuqJlBWPttqM1QkupNVqIpenYw69Gcd?=
 =?us-ascii?Q?xf1BbaX3j57Ul/hRUJCLrhLj8u8bSw8GXr3J7NpBz3O5FM0ImsAMMfQF288X?=
 =?us-ascii?Q?5UtBCqriaw81Nz2qgZQAp86i5BXJ+0fr6YRUebPmBIqH78SyRx7YZ5lTPOna?=
 =?us-ascii?Q?q8P62zW5aFLjYSgN870l7F92FBJi++t3Um33vpCSMGCN+iYYyr/XdK5ytWYb?=
 =?us-ascii?Q?ohW2qxccXqBiYwIxpUBooIYuANHK2gudJyHOfhCJg6wN4YKqo32Nt5PZUAdL?=
 =?us-ascii?Q?U9dsuKfrWKDT3nGoLlZai2mfiJ9dKBXMcUTUPyFaNRnAOwmML7z8by3uav6F?=
 =?us-ascii?Q?yjWndD6Uy8dwZ55TyZyx7qLpZwpsQH8KhKS2P5w575anPmDPhytdl3x3hV9Q?=
 =?us-ascii?Q?0kOjYKVfJhzondiblDgqUu7rBzRxO3M1UGaZsygHs4pWQxe2ZdorYplJzs0m?=
 =?us-ascii?Q?9UIezcN7+sKAtiIC2v9Odgcx4Vk7R3KZBRpJBb/Yh/nxOXVwIwrpTnWjH0zQ?=
 =?us-ascii?Q?/6mCjHnW+E4C5L69NYdfhwrekdJbEM+jx20UmW1EU6rLIrbAa3fhS/yEuim5?=
 =?us-ascii?Q?LMRwRkfDTxdUC5gNNr+H8RHAGjt3jAgi9P5QBKlQ28y07gWYUt6BbL63aquE?=
 =?us-ascii?Q?fbSOQgnJAi4pNp71vnDldSvaHUbf1zXb?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7ef42c6-efc6-488d-02b2-08d993de8416
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2021 15:30:15.6464
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mikelley@ntdev.microsoft.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0862
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Sunil Muthuswamy <sunilmut@linux.microsoft.com> Sent: Thursday, Octob=
er 14, 2021 8:53 AM
>=20
> Add support for Hyper-V vPCI for ARM64 by implementing the arch specific
> interfaces. Introduce an IRQ domain and chip specific to Hyper-v vPCI tha=
t
> is based on SPIs. The IRQ domain parents itself to the arch GIC IRQ domai=
n
> for basic vector management.
>=20
> Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> ---
> In v2 & v3:
>  Changes are described in the cover letter.
>=20
>  arch/arm64/include/asm/hyperv-tlfs.h        |   9 +
>  drivers/pci/Kconfig                         |   2 +-
>  drivers/pci/controller/Kconfig              |   2 +-
>  drivers/pci/controller/pci-hyperv-irqchip.c | 210 ++++++++++++++++++++
>  drivers/pci/controller/pci-hyperv.c         |   6 +
>  5 files changed, 227 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/arm64/include/asm/hyperv-tlfs.h b/arch/arm64/include/as=
m/hyperv-tlfs.h
> index 4d964a7f02ee..bc6c7ac934a1 100644
> --- a/arch/arm64/include/asm/hyperv-tlfs.h
> +++ b/arch/arm64/include/asm/hyperv-tlfs.h
> @@ -64,6 +64,15 @@
>  #define HV_REGISTER_STIMER0_CONFIG	0x000B0000
>  #define HV_REGISTER_STIMER0_COUNT	0x000B0001
>=20
> +union hv_msi_entry {
> +	u64 as_uint64[2];
> +	struct {
> +		u64 address;
> +		u32 data;
> +		u32 reserved;
> +	} __packed;
> +};
> +
>  #include <asm-generic/hyperv-tlfs.h>
>=20
>  #endif
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index 0c473d75e625..36dc94407510 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -184,7 +184,7 @@ config PCI_LABEL
>=20
>  config PCI_HYPERV
>  	tristate "Hyper-V PCI Frontend"
> -	depends on X86_64 && HYPERV && PCI_MSI && PCI_MSI_IRQ_DOMAIN && SYSFS
> +	depends on (X86_64 || ARM64) && HYPERV && PCI_MSI && PCI_MSI_IRQ_DOMAIN=
 && SYSFS
>  	select PCI_HYPERV_INTERFACE
>  	help
>  	  The PCI device frontend driver allows the kernel to import arbitrary
> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kcon=
fig
> index 326f7d13024f..15271f8a0dd1 100644
> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -280,7 +280,7 @@ config PCIE_BRCMSTB
>=20
>  config PCI_HYPERV_INTERFACE
>  	tristate "Hyper-V PCI Interface"
> -	depends on X86 && HYPERV && PCI_MSI && PCI_MSI_IRQ_DOMAIN && X86_64
> +	depends on (X86_64 || ARM64) && HYPERV && PCI_MSI && PCI_MSI_IRQ_DOMAIN
>  	help
>  	  The Hyper-V PCI Interface is a helper driver allows other drivers to
>  	  have a common interface with the Hyper-V PCI frontend driver.
> diff --git a/drivers/pci/controller/pci-hyperv-irqchip.c b/drivers/pci/co=
ntroller/pci-hyperv-irqchip.c
> index 36fa862f8bc5..ccecd14b6601 100644
> --- a/drivers/pci/controller/pci-hyperv-irqchip.c
> +++ b/drivers/pci/controller/pci-hyperv-irqchip.c
> @@ -52,6 +52,216 @@ int hv_msi_prepare(struct irq_domain *domain, struct =
device *dev,
>  }
>  EXPORT_SYMBOL(hv_msi_prepare);
>=20
> +#elif CONFIG_ARM64

This should be

#elif defined(CONFIG_ARM64)

> +
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
> +static struct irq_chip hv_msi_irq_chip =3D {
> +	.name =3D "MSI",
> +	.irq_set_affinity =3D irq_chip_set_affinity_parent,
> +	.irq_eoi =3D irq_chip_eoi_parent,
> +	.irq_mask =3D irq_chip_mask_parent,
> +	.irq_unmask =3D irq_chip_unmask_parent
> +};
> +
> +unsigned int hv_msi_get_int_vector(struct irq_data *irqd)
> +{
> +	irqd =3D irq_domain_get_irq_data(hv_msi_gic_irq_domain, irqd->irq);
> +
> +	return irqd->hwirq;
> +}
> +EXPORT_SYMBOL(hv_msi_get_int_vector);
> +
> +void hv_set_msi_entry_from_desc(union hv_msi_entry *msi_entry,
> +				struct msi_desc *msi_desc)
> +{
> +	msi_entry->address =3D ((u64)msi_desc->msg.address_hi << 32) |
> +			      msi_desc->msg.address_lo;
> +	msi_entry->data =3D msi_desc->msg.data;
> +}
> +EXPORT_SYMBOL(hv_set_msi_entry_from_desc);
> +
> +int hv_msi_prepare(struct irq_domain *domain, struct device *dev,
> +		   int nvec, msi_alloc_info_t *info)
> +{
> +	return 0;
> +}
> +EXPORT_SYMBOL(hv_msi_prepare);
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
> +						    hwirq + i, &hv_msi_irq_chip,
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
> +static int hv_pci_vec_irq_domain_activate(struct irq_domain *domain,
> +					  struct irq_data *irqd, bool reserve)
> +{
> +	/* All available online CPUs are available for targeting */
> +	irq_data_update_effective_affinity(irqd, cpu_online_mask);
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
> +int hv_pci_irqchip_init(struct irq_domain **parent_domain,
> +			bool *fasteoi_handler,
> +			u8 *delivery_mode)
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
> +	hv_msi_gic_irq_domain =3D acpi_irq_create_hierarchy(0, HV_PCI_MSI_SPI_N=
R,
> +							  fn, &hv_pci_domain_ops,
> +							  chip_data);
> +
> +	if (!hv_msi_gic_irq_domain) {
> +		pr_err("Failed to create Hyper-V ARMV vPCI MSI IRQ domain\n");
> +		goto free_chip;
> +	}
> +
> +	*parent_domain =3D hv_msi_gic_irq_domain;
> +	*fasteoi_handler =3D true;
> +
> +	/* Delivery mode: Fixed */
> +	*delivery_mode =3D 0;
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
> +EXPORT_SYMBOL(hv_pci_irqchip_init);
> +
> +void hv_pci_irqchip_free(void)
> +{
> +	static struct hv_pci_chip_data *chip_data;
> +
> +	if (!hv_msi_gic_irq_domain)
> +		return;
> +
> +	/* Host data cannot be null if the domain was created successfully */
> +	chip_data =3D hv_msi_gic_irq_domain->host_data;
> +	irq_domain_remove(hv_msi_gic_irq_domain);
> +	hv_msi_gic_irq_domain =3D NULL;
> +	kfree(chip_data);
> +}
> +EXPORT_SYMBOL(hv_pci_irqchip_free);
> +
>  #endif

Particularly for a large number of lines under an #ifdef, it's customary to=
 add
a comment to clarify what test the #endif is closing.  So:

#endif /* CONFIG_ARM64 */

>=20
>  MODULE_LICENSE("GPL v2");
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller=
/pci-hyperv.c
> index 2d3916206986..a77d0eaedac3 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -44,6 +44,7 @@
>  #include <linux/delay.h>
>  #include <linux/semaphore.h>
>  #include <linux/irq.h>
> +#include <linux/irqdomain.h>
>  #include <linux/msi.h>
>  #include <linux/hyperv.h>
>  #include <linux/refcount.h>
> @@ -1204,6 +1205,8 @@ static int hv_set_affinity(struct irq_data *data, c=
onst struct cpumask *dest,
>  static void hv_irq_mask(struct irq_data *data)
>  {
>  	pci_msi_mask_irq(data);
> +	if (data->parent_data->chip->irq_mask)
> +		irq_chip_mask_parent(data);
>  }
>=20
>  /**
> @@ -1321,6 +1324,8 @@ static void hv_irq_unmask(struct irq_data *data)
>  		dev_err(&hbus->hdev->device,
>  			"%s() failed: %#llx", __func__, res);
>=20
> +	if (data->parent_data->chip->irq_unmask)
> +		irq_chip_unmask_parent(data);
>  	pci_msi_unmask_irq(data);
>  }
>=20
> @@ -1597,6 +1602,7 @@ static struct irq_chip hv_msi_irq_chip =3D {
>  	.irq_compose_msi_msg	=3D hv_compose_msi_msg,
>  	.irq_set_affinity	=3D hv_set_affinity,
>  	.irq_ack		=3D irq_chip_ack_parent,
> +	.irq_eoi		=3D irq_chip_eoi_parent,
>  	.irq_mask		=3D hv_irq_mask,
>  	.irq_unmask		=3D hv_irq_unmask,
>  };
> --
> 2.25.1

Modulo the minor #elif and #endif comments above, and the fact that I have
limited expertise in IRQ domain hierarchies,

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
