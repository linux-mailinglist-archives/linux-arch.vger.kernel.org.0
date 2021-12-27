Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 281514802DE
	for <lists+linux-arch@lfdr.de>; Mon, 27 Dec 2021 18:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbhL0RiT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Dec 2021 12:38:19 -0500
Received: from mail-centralusazon11021019.outbound.protection.outlook.com ([52.101.62.19]:61173
        "EHLO na01-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230338AbhL0RiT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 27 Dec 2021 12:38:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NraZjAlEULct2JEPGVPbi1Eqcc6MzTBETcEF4Mqzy0QVPLF26MCOq/KEmeTAKvIi/fO+6LsCjJOIaqDXwObYFKi4sTSZxcMbfb600jaSpiy5wIA7gFQ9NeJGkl9/prMO+gRv6kD9uimFkqt19Qq8r9f4rjFc8855I4GsrbZeFlxAaMLaRkG5xfndFwdDPoN8enV4rDmI7ar1Q5i0SKO/Cjb5OKvlcEDvietCAvKDEr+GreJAleHwrOZ8FY8VMbyccM0pDx+jipQ+GoZyez1pnigjR9hJYRKLMwMqNra/lElFBruRzNarQudBUrHKQBoj2gZfssekTi1Tyb3OL8aMGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7uJH/mngwZ8wQroDzoHKb3qQFTvmc10x1Ntxv5oWoQA=;
 b=RMiWx+ESP9JVzvzsUkkJwcSkeViBlhT59RgzvwETJ4YiaWhu8wtXOBAlsisNpMpgR2+ZHHLLLuj1rEVqM4JQxkUYHHxmSBTDFvmtPZPNttg5Uzs4x7Gifi8AOtxeCVpWlpApdvU02XA482tMpEwZ89KnFgGtijWgXG4pcu95EOcbbIkKmdo9XJu6obwhvMepkcz+OFpiTiRuaoel2wYYBIAqr4giBiU5tXI6UHveZCBQKB5AU/Ni6qQnOprYUjArSZpZSaQnDUWcxUpOUkROVEf2NCMS8KhR4hjlcKEVFHbzZHVdxUSNECByNYEJ/9PurqHeMN6DM+E3s0MLLqHAjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7uJH/mngwZ8wQroDzoHKb3qQFTvmc10x1Ntxv5oWoQA=;
 b=ftmd69uqpFwz8fp3e+j07eNPG2tuX0pubuQhpW1x0scF9/FWi3rit5a3O+x4O7KrQ9eSMHKaltD0sp1fFwwNZJ1f7Z0O8OO6YlWjCduW8so3FD/i/Ft/Zkuf8G8P6gSn7ce/5pAmsyf5MxlPkJ4hH1sSeVGjSUDpkXYcT2tuvuE=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by SN6PR2101MB1678.namprd21.prod.outlook.com (2603:10b6:805:61::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.2; Mon, 27 Dec
 2021 17:38:09 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::4de:2eb4:7729:dd4b]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::4de:2eb4:7729:dd4b%6]) with mapi id 15.20.4867.003; Mon, 27 Dec 2021
 17:38:09 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
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
Subject: RE: [PATCH v7 2/2] PCI: hv: Add arm64 Hyper-V vPCI support
Thread-Topic: [PATCH v7 2/2] PCI: hv: Add arm64 Hyper-V vPCI support
Thread-Index: AQHX83dFKzW346rikEmeCnVJfdll/qxGoMFw
Date:   Mon, 27 Dec 2021 17:38:07 +0000
Message-ID: <MWHPR21MB1593272A454D568311C3B254D7429@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <1639767121-22007-1-git-send-email-sunilmut@linux.microsoft.com>
 <1639767121-22007-3-git-send-email-sunilmut@linux.microsoft.com>
In-Reply-To: <1639767121-22007-3-git-send-email-sunilmut@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=16d6b1a8-2b41-4c86-a58f-b6b517debcd0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-12-27T17:04:43Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 924a9f41-09a8-4dfb-1aaf-08d9c95fa601
x-ms-traffictypediagnostic: SN6PR2101MB1678:EE_
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <SN6PR2101MB16786EB8642184286F6D1457D7429@SN6PR2101MB1678.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r2jrlF6cztVNlFeRsw6sgkelvaXXCu4Tv/Fa5QrwRjjnI3X4f1IpAGTtiSTmfxitxgXXlgSicpGoR6Ho6PHOUY9rVRY67BqW5lBOIE2Vw4VxfVdIuzxvwADZwvNg1CQUzGqF3GlJKbyPyAo+vUIOX00RTWRkkE8E/QbEm0jQDhbLWn7OdEieAsXUauChall/iBfDfv/Jp8OExDZwRyk2F1M9E1Vcx56Fsfscfr5YepMNtSQ9ayjJZxNHXnVcMekZy18vYvBg24AUByJa23Q3cglHv0mggIBwBVFxzKYuJxbR3Uq7xFHHuw+m1X7vydCsHuwP+Epzvd/WXc3zLAtV1OR3eZ7ESLSg9GlQaxXJtBlByED8pD/41h4Kx584P16/2AiyL4fXxKEeWzD/OOsYt9dm+5bJ2WZI9cr8AixLoFR3lCPx9MR+ll5bq3sNKJqhVZjm8HPmSIzcacuM8wBM2jWIRAqgVTUOou22TIXuz+0pzWdTR1qHNRL7WbEKVf+vrqvhGMxJxz+O6+BXvsA9cayb/e5HxoNJSIq7jqmhDPMY5R1/BaJKMZZD9Y3qOPnUHhW+SgqNQrykxaeF0l9mTY4KupF1lVkPdPr7YoaQ5ZO0/r8ycO24tZe3nuQLxIP6BT6lsB/8vsANWrmAUmOK79xfBjVJH+4San7c7MCEBfyLMhUxgamgDscfd6LlJ8S33Ktpl6DFE9cMcTkC2lOfkbL0/cPZGuONTseDbRy7C68dzTONxY24P3kFPteFJeACPPuNb64JSXd5aJ+sTw2FZg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(122000001)(107886003)(38100700002)(54906003)(110136005)(82950400001)(83380400001)(38070700005)(921005)(82960400001)(186003)(26005)(2906002)(76116006)(8676002)(52536014)(64756008)(66556008)(66476007)(66946007)(8936002)(55016003)(86362001)(4326008)(33656002)(7416002)(8990500004)(5660300002)(30864003)(71200400001)(7696005)(9686003)(6506007)(10290500003)(508600001)(316002)(66446008)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?b9V8wIMMYVOJljvVbT1/dDbb0Csb3uLKkHXMgxzOCAeVgVRDbfdkIlucGDVV?=
 =?us-ascii?Q?qp0hO17UHH3cS3z8Q34bI2MmggaTOrRWwanYixx4cdzE0YiNtIPdHm7WlJSw?=
 =?us-ascii?Q?gBF22JXDbxcUWhlb0dLoJmYp5EF4hJB/zWdGckRqkCIaOVHXonYFTZa60Uwv?=
 =?us-ascii?Q?Cyuwho/UgCoRo1GhN5c9OQcpxf6rXYhm5mItqb2ys55r4yJOad5sZL42Gers?=
 =?us-ascii?Q?5Z6xOF6YpaHFm8Za1byfV2PNN2M/B/xlXwP/O4GfPHbihS6M5DthyMJZqohN?=
 =?us-ascii?Q?2/csMjtYQleUS3TonR0QPwJUYxdHG7N90FWEOBDQGkE2SosJBAphmRXNlEui?=
 =?us-ascii?Q?RzB6DcoZaLZDy+c9XHUQUvMIwQQNcyIL+6putF55CITjovaaQH5zFITjbZVn?=
 =?us-ascii?Q?bolNJD7yEAPKvkgxij1+qzoRMeiCSLi9s08+GRceuBNRYjfjgIaV5giweNF6?=
 =?us-ascii?Q?kozUlr/DVdDJ6ah3TSPHHsDesbvJVE2Ap8FN6+Cozp8SYMQklTDDcIggOWbJ?=
 =?us-ascii?Q?1DaxJbJUPclckByfaL3JvBK9Ez20aKF/R8s0QgUkXDm4WhnvMzzbdPVXfrZa?=
 =?us-ascii?Q?Q1kVIXKxbgIh8YgN9tw7eNoosJVHIiBPwdUGQvHswIZ+5eWbiVSJzyw3zN+T?=
 =?us-ascii?Q?jHR5u4vuw4hPfGByliXS0GjjGjMArApZLgWk7zAlb/G+HiDBSwHrcM3s1/g9?=
 =?us-ascii?Q?tyT9xsHDX5vNbgfwHhhEsj+tlVDUra0WjkREo+YkHoKs70C8rYlZg3Nea627?=
 =?us-ascii?Q?A3Zia0XDthrEhu0oCePY5j7F3AgIOp3wwptWL2qIMBC5hkrvETmEuLuFhILy?=
 =?us-ascii?Q?jhM6QvPqODxKOMCgXRitiopBwBVxXp9wRlezIRDG3PnFnrVLgUX1XHLVZSTa?=
 =?us-ascii?Q?2TWxTpndeZ0udNGkCuFtvNAN+tajVaXXrQqY53qv5IDD3jAqb2rQzQZkVE5G?=
 =?us-ascii?Q?01jwdP0EGBdO8yZz+w/Ibdx80nQjnmXxBVRtqBe4zXnfVZGTAfNoNdr9w0d5?=
 =?us-ascii?Q?fLOmwbr6F8RGvol/mgily8hoMPmd7C8AMH60cDbZTDmpKsH85454O/hgYqFA?=
 =?us-ascii?Q?sVq/oLol02yx75tXACXg7RHel3SdbdJUAfWzNoK0Rr1uCgUjqiN7abbcZG4i?=
 =?us-ascii?Q?TQqqQwYeAUwlu1G69VeVlm4nDyS27DD1Ik/LywZOaxs11QZF1EZPH/ZnDWGK?=
 =?us-ascii?Q?yS0gRG/4mhXojVBPT4WAL9ex1rUGMN6huFM1Qbj3wFHmP3esX4aoi3VO7NHl?=
 =?us-ascii?Q?MBbFr9+Hd4jYpz2Sd7yM76h0d8zjGdPZ3gcmZ5zm8Q9D66rjN7xhaOmXs2G+?=
 =?us-ascii?Q?aXDIGo4qmA50AF2arErb6nsQZjOOV2BtxK14LO4soDrCREYKbAKIK/tR1Wtd?=
 =?us-ascii?Q?eiRAZh+UAZklpSDsUuF0MS1mPZ7irogK6EFersXAvvw93Kudq3xxZTBv0STI?=
 =?us-ascii?Q?mIkoY4oCNyv6d6AMy/+7Gp+VUO5tebzA9Lffjm8s1SvRLThWCMwDnMw+RF3Q?=
 =?us-ascii?Q?P3HSDpN82tSvXRgCn49skefKdA9I9eMnQhXSxg03Gm6Q0n7o/4qzebPPUITK?=
 =?us-ascii?Q?Auu85dUdNyZRvo+1FpqOIU9Dda8JRnbFQ/uWV+ZjSxanwxKuUBKhVeQJNRiK?=
 =?us-ascii?Q?S7w8Yo78iTGjg2xPZFDa0oRKoPz0wLwT4Dd4PD1y362W+LuWh0XxAtM5e05D?=
 =?us-ascii?Q?1V+l8A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 924a9f41-09a8-4dfb-1aaf-08d9c95fa601
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Dec 2021 17:38:09.2502
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KWHNb3sY+/vjSJFBE+HZlzRnOiv6fpQptefL5sBlSy3pTyx73bC2ZGDhbsfO9fgVyvon/MUFjo8yIqVhsdax048xYubrvknR/1Z8sydA9Qs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1678
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Sunil Muthuswamy <sunilmut@linux.microsoft.com> Sent: Friday, Decembe=
r 17, 2021 10:52 AM
>=20
> Add arm64 Hyper-V vPCI support by implementing the arch specific
> interfaces. Introduce an IRQ domain and chip specific to Hyper-v vPCI tha=
t
> is based on SPIs. The IRQ domain parents itself to the arch GIC IRQ domai=
n
> for basic vector management.
>=20
> Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> ---
> In v2, v3, v4, v5, v6 & v7:
>  Changes are described in the cover letter.
>=20
>  arch/arm64/include/asm/hyperv-tlfs.h |   9 +
>  drivers/pci/Kconfig                  |   2 +-
>  drivers/pci/controller/Kconfig       |   2 +-
>  drivers/pci/controller/pci-hyperv.c  | 241 ++++++++++++++++++++++++++-
>  4 files changed, 251 insertions(+), 3 deletions(-)
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
> index 43e615aa12ff..d98fafdd0f99 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -184,7 +184,7 @@ config PCI_LABEL
>=20
>  config PCI_HYPERV
>  	tristate "Hyper-V PCI Frontend"
> -	depends on X86_64 && HYPERV && PCI_MSI && PCI_MSI_IRQ_DOMAIN && SYSFS
> +	depends on ((X86 && X86_64) || ARM64) && HYPERV && PCI_MSI && PCI_MSI_I=
RQ_DOMAIN && SYSFS
>  	select PCI_HYPERV_INTERFACE
>  	help
>  	  The PCI device frontend driver allows the kernel to import arbitrary
> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kcon=
fig
> index 93b141110537..2536abcc045a 100644
> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -281,7 +281,7 @@ config PCIE_BRCMSTB
>=20
>  config PCI_HYPERV_INTERFACE
>  	tristate "Hyper-V PCI Interface"
> -	depends on X86 && HYPERV && PCI_MSI && PCI_MSI_IRQ_DOMAIN && X86_64
> +	depends on ((X86 && X86_64) || ARM64) && HYPERV && PCI_MSI && PCI_MSI_I=
RQ_DOMAIN
>  	help
>  	  The Hyper-V PCI Interface is a helper driver allows other drivers to
>  	  have a common interface with the Hyper-V PCI frontend driver.
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller=
/pci-hyperv.c
> index ead7d6cb6bf1..02ba2e7e2618 100644
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
> @@ -614,7 +616,236 @@ static int hv_msi_prepare(struct irq_domain *domain=
, struct device *dev,
>  {
>  	return pci_msi_prepare(domain, dev, nvec, info);
>  }
> -#endif /* CONFIG_X86 */
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
> +/*
> + * @nr_bm_irqs:		Indicates the number of IRQs that were allocated from
> + *			the bitmap.
> + * @nr_dom_irqs:	Indicates the number of IRQs that were allocated from
> + *			the parent domain.
> + */
> +static void hv_pci_vec_irq_free(struct irq_domain *domain,
> +				unsigned int virq,
> +				unsigned int nr_bm_irqs,
> +				unsigned int nr_dom_irqs)
> +{
> +	struct hv_pci_chip_data *chip_data =3D domain->host_data;
> +	struct irq_data *d =3D irq_domain_get_irq_data(domain, virq);

FWIW, irq_domain_get_irq_data() can return NULL.   Maybe that's an
error in the "should never happen" category.   Throughout kernel code,
some callers check for a NULL result, but a lot do not.

> +	int first =3D d->hwirq - HV_PCI_MSI_SPI_START;
> +	int i;
> +
> +	mutex_lock(&chip_data->map_lock);
> +	bitmap_release_region(chip_data->spi_map,
> +			      first,
> +			      get_count_order(nr_bm_irqs));
> +	mutex_unlock(&chip_data->map_lock);
> +	for (i =3D 0; i < nr_dom_irqs; i++) {
> +		if (i)
> +			d =3D irq_domain_get_irq_data(domain, virq + i);

Same here.

> +		irq_domain_reset_irq_data(d);
> +	}
> +
> +	irq_domain_free_irqs_parent(domain, virq, nr_dom_irqs);
> +}
> +
> +static void hv_pci_vec_irq_domain_free(struct irq_domain *domain,
> +				       unsigned int virq,
> +				       unsigned int nr_irqs)
> +{
> +	hv_pci_vec_irq_free(domain, virq, nr_irqs, nr_irqs);
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
> +	struct irq_data *d;
> +	int ret;
> +
> +	fwspec.fwnode =3D domain->parent->fwnode;
> +	fwspec.param_count =3D 2;
> +	fwspec.param[0] =3D hwirq;
> +	fwspec.param[1] =3D IRQ_TYPE_EDGE_RISING;
> +
> +	ret =3D irq_domain_alloc_irqs_parent(domain, virq, 1, &fwspec);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Since the interrupt specifier is not coming from ACPI or DT, the
> +	 * trigger type will need to be set explicitly. Otherwise, it will be
> +	 * set to whatever is in the GIC configuration.
> +	 */
> +	d =3D irq_domain_get_irq_data(domain->parent, virq);

And here.

> +
> +	return d->chip->irq_set_type(d, IRQ_TYPE_EDGE_RISING);
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

This error path doesn't clean up correctly.  While parent IRQs allocated
in previous iterations of the loop is cleaned up, the parent IRQ
allocated in the current iteration is not.

> +
> +		pr_debug("pID:%d vID:%u\n", (int)(hwirq + i), virq + i);
> +	}
> +
> +	return 0;
> +
> +free_irq:
> +	hv_pci_vec_irq_free(domain, virq, nr_irqs, i);
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

Using the cpu_online_mask may work correctly, though its usage here
raises a red flag for me.  The problem is that the CPU selected can go offl=
ine
immediately after the above line of code, as the cpus_read_lock() does
not appear to be held anywhere in the call stack.  If the CPU is only
a temporary placeholder and will never actually be targeted with the
interrupt, then maybe the online/offline state doesn't matter.   But if
that's the case, I'd suggest using the cpu_present_mask instead of the
cpu_online_mask.  Hyper-V doesn't hot-add CPUs, so cpu_present_mask
should be stable even if the cpus_read_lock() isn't held, and the code
doesn't incorrectly imply that it's important for the CPU to be online.

Michael

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
> +	fn =3D irq_domain_alloc_named_fwnode("hv_vpci_arm64");
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
> +		pr_err("Failed to create Hyper-V arm64 vPCI MSI IRQ domain\n");
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
> +#endif /* CONFIG_ARM64 */
>=20
>  /**
>   * hv_pci_generic_compl() - Invoked for a completion packet
> @@ -1227,6 +1458,8 @@ static void hv_msi_free(struct irq_domain *domain, =
struct msi_domain_info *info,
>  static void hv_irq_mask(struct irq_data *data)
>  {
>  	pci_msi_mask_irq(data);
> +	if (data->parent_data->chip->irq_mask)
> +		irq_chip_mask_parent(data);
>  }
>=20
>  /**
> @@ -1343,6 +1576,8 @@ static void hv_irq_unmask(struct irq_data *data)
>  		dev_err(&hbus->hdev->device,
>  			"%s() failed: %#llx", __func__, res);
>=20
> +	if (data->parent_data->chip->irq_unmask)
> +		irq_chip_unmask_parent(data);
>  	pci_msi_unmask_irq(data);
>  }
>=20
> @@ -1618,7 +1853,11 @@ static struct irq_chip hv_msi_irq_chip =3D {
>  	.name			=3D "Hyper-V PCIe MSI",
>  	.irq_compose_msi_msg	=3D hv_compose_msi_msg,
>  	.irq_set_affinity	=3D irq_chip_set_affinity_parent,
> +#ifdef CONFIG_X86
>  	.irq_ack		=3D irq_chip_ack_parent,
> +#elif defined(CONFIG_ARM64)
> +	.irq_eoi		=3D irq_chip_eoi_parent,
> +#endif
>  	.irq_mask		=3D hv_irq_mask,
>  	.irq_unmask		=3D hv_irq_unmask,
>  };
> --
> 2.25.1
>=20

