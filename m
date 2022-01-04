Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 867F5484873
	for <lists+linux-arch@lfdr.de>; Tue,  4 Jan 2022 20:23:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236491AbiADTXv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Jan 2022 14:23:51 -0500
Received: from mail-cusazon11020017.outbound.protection.outlook.com ([52.101.61.17]:13777
        "EHLO na01-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235922AbiADTXu (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 4 Jan 2022 14:23:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kHITf/pHbVHtNIiWcPpm+qDuieJbP+Dy4FUbLwEWzgj35nQEEgsWSn/5vLKqhASiU0hiUxfdIvASGS4sHlI64phU96Z8MiSTs7FsS81fpvo3QdZ0liQx++zxiV4LUPu1fONvFPdMGYRfblXZx0MYGk2shJSME6vf/gv1W4Q0rj5oPSXyUbiOaLkLj3yOxCKeiH5M/h2JbMY4LoBXWcHU8beSuMrR9SWSv+nnZpADgH5U6kx5nXd3PhD8E7zFgmI7Y8UcZXCJRV4QQ7krv56gqt77SPS0hDQ0+tuiMlL6/LqpqHyLAoR8yG2XY0RaqXq8glezDu4gPgF0NLmufECKtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3a32eCy897DpivCn7SChJkewUvEzR/0Bn4d+uAHhBZg=;
 b=QLkzrcE9LlRKNUYFruQkg+N46LRi1qcLmmooYETRXfTG5DVlFCDHfKvsW5h2PL0je3XLInfcRcSyCW+YLc5tV0naLfuTps59upZ8BrJmJxP1mT2jDPm1ShOoee8nq8WmNpXWwTIYyCtceF/FqMhCw8lXhpF1DqLXFcQY0BMkp8PQm3j8rMgh2qq4X+u2Tw9hfq5puOpb+bsZWURCf/lrUMs7PgQ+QX8O/zMzI78gYSXcoKBevgld1+Bq5OH7STWCdN+ym3p6IrrQUYuekxRJrEA4pwoRs+nb250pL8zE/mZNyJDfAkPFZx1Obkp8ZTMQhm+5UDg8h8QbF8xj2+XrGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3a32eCy897DpivCn7SChJkewUvEzR/0Bn4d+uAHhBZg=;
 b=bpH2JLeIn1jIRVbakYTr2MbVKcFRTVDQl1+TCrRsr6lFdYW3kGfow6hLu68vBkH/xM6nBLhZuXylie1S66eDXYuAMgtZ/Z2kgDj5w8cT+P7ePtyZ7HU1MKOuaPVoSD3CNRgLXvavHEZxBs8TSq6JC4fiOHqRaxS9WIxMpuEL6EI=
Received: from BN8PR21MB1140.namprd21.prod.outlook.com (2603:10b6:408:72::11)
 by CY4PR21MB1586.namprd21.prod.outlook.com (2603:10b6:910:90::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.1; Tue, 4 Jan
 2022 19:23:41 +0000
Received: from BN8PR21MB1140.namprd21.prod.outlook.com
 ([fe80::404e:3ab7:b377:74a2]) by BN8PR21MB1140.namprd21.prod.outlook.com
 ([fe80::404e:3ab7:b377:74a2%6]) with mapi id 15.20.4867.003; Tue, 4 Jan 2022
 19:23:41 +0000
From:   Sunil Muthuswamy <sunilmut@microsoft.com>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        Sunil Muthuswamy <sunilmut@linux.microsoft.com>,
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
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: RE: [PATCH v7 2/2] PCI: hv: Add arm64 Hyper-V vPCI support
Thread-Topic: [PATCH v7 2/2] PCI: hv: Add arm64 Hyper-V vPCI support
Thread-Index: AQHX83c+n2zBUkZpb0GUEdehpEoIoqxGqhWAgAytifA=
Date:   Tue, 4 Jan 2022 19:23:41 +0000
Message-ID: <BN8PR21MB11403EEA28B7029B32BB8B4AC04A9@BN8PR21MB1140.namprd21.prod.outlook.com>
References: <1639767121-22007-1-git-send-email-sunilmut@linux.microsoft.com>
 <1639767121-22007-3-git-send-email-sunilmut@linux.microsoft.com>
 <MWHPR21MB1593272A454D568311C3B254D7429@MWHPR21MB1593.namprd21.prod.outlook.com>
In-Reply-To: <MWHPR21MB1593272A454D568311C3B254D7429@MWHPR21MB1593.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=16d6b1a8-2b41-4c86-a58f-b6b517debcd0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-12-27T17:04:43Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3e5c72ee-226c-403d-5b21-08d9cfb7b7ba
x-ms-traffictypediagnostic: CY4PR21MB1586:EE_
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <CY4PR21MB15865FF49C1DD2899523CE4FC04A9@CY4PR21MB1586.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: btBTjyDuObTIEmhXLHVlQuXcZ2LE1koPNDnjw7sU0D1cbY1dlhvMFLhDAdbk7MC+UTyeDyAdZLbc5FDz4bCwqQ3a4WxEosByb+fgv0UtG8Dvbed3I7l6bu93D9rIzYN7Zn6PpcMvGGCX394OPSxqNN9Oa6FJQUTAm5NoFYfc1gQo9BdgPJ6HG4LWxMDURhg27zHDP68sIVmRlNd5ihD2+PSPAtXme41RUgWjPqy21ChsTUL8ukLQ9upKZy8fbJuiGODj3Mc1E/NihfXLVR/FGB5fE5VVgX8d7+dU/wd+DL1IQqGkrCyzekF/AyEMgLmaxdo1jJAZuER9RNoT5sUwxYnlUtrMA3o4DDs8+zrdJEcEYhJUeI2O4dYbNS9VFPGWrjt7SQ80sIaZY9542zB1xOSsvaSnY+fBBa6nEtwehQJuWsCbua83MOXOMGrW2N/2JzcFqiEjLBbVLz+RkhYn2IYMMhxBTtsHGRT5WITv7zVCj4n6ptWX0gumtpRzfZEvagxQwDXSSP2EJaaUrDQm6//GMPkGAHxD7n1YIDcb2KgsfxUL578hxiIb87yD7oRisTWvHIctl1tm/NSMtpkZqjUlVYJQMLDyx+bJUn9XecdWdLzdUTX9kTdTFw15n8LBy2dP37gWo1sw5Z80uTd5cDoXfFeLUXuAm5HI9KGFsrJfEAxGYgzEzWXaMuoBVagZ98uiOYIvc/0QzLVn9P9E/qitOz7nXiOrq9DOJ1MOBzP1sY78TXnLeVbkjmbYbsHXybBIOPBE1NOlnxVD4zm0gQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR21MB1140.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(7696005)(9686003)(82950400001)(82960400001)(10290500003)(5660300002)(86362001)(8936002)(6506007)(64756008)(38070700005)(66476007)(921005)(66556008)(8676002)(4326008)(66446008)(38100700002)(122000001)(71200400001)(7416002)(508600001)(2906002)(110136005)(55016003)(66946007)(76116006)(83380400001)(33656002)(54906003)(8990500004)(186003)(52536014)(316002)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?227NpmrMo8M/nstNfuNZ9XF4clCfSLlh26iAvz9de2pum0SBViVwGKbE/uye?=
 =?us-ascii?Q?PYiTA3Zt68Yf2Oi0N51kHPo0rjQMf7bP58ziSiRKoAOWuWc774GA7L1XVjcE?=
 =?us-ascii?Q?zYGalfNExpW2LLxXdBTRG0wUG7u0XxeVYQtfTwCR6SS84AcZbT580VCmrkdp?=
 =?us-ascii?Q?suy+KKWTexDYNxDbdNMwn8jBZo8jQlMy2tuiVLoe5CuMWdZDZgKNsuJmBnsW?=
 =?us-ascii?Q?EDfBAls7fc8ryvhN5HcRgY4rwSuGR7+W0M+tioYlSg+0lPOmKSDd7IuEjCkh?=
 =?us-ascii?Q?8KVsER4BqBkUVJtPCVDKt355FMioaHeJc81tzfLsb6LC3jSuvPlnR7d6mdKx?=
 =?us-ascii?Q?G20gRCj0j+g0xWDWunzC958n9U4XLxoZhU728bSasFkWtVxnuT++7nE4rfcj?=
 =?us-ascii?Q?A/Ay9ZGuLOqhIjJ1iHwlxAE5zB1Pp/6NGhKmVFy48Jz8d/M1JKQayGz8rsMU?=
 =?us-ascii?Q?EP/0NRlNShmcgm21uM2/ZonIq8rE6o5oRzVgELXgFZBXc0HD2gBYhq/xWpIb?=
 =?us-ascii?Q?nhD2cBLMFIaN/RIR6WKEEFO22cSLmtIdXPIRzSzbw8ndQ3At4LoVnTc3GTWm?=
 =?us-ascii?Q?VjSdawGAqtnrG0fJ6IdwluSHbeglMsO+I1utkRzkHdeJeVtrZbv1abOwwgh6?=
 =?us-ascii?Q?hkpnIjgns4nuX80R0sRk+pqKy3ncYtW0rD2YnkDHBCEQwY+rwYQd6ql2PmTt?=
 =?us-ascii?Q?7S0/qSx8uSINmVjb/Wrphcpuu9vStyyCnwm8QinGxCoDfClJwrjITXFCd0Xu?=
 =?us-ascii?Q?RWWyyWP0UEJtTqSKKYaNFYTj6SPw7II14XvO8yCPNN7LL9xos1igwYsnM9PU?=
 =?us-ascii?Q?sdeR5vaB9hV9zhJDyxYfZ9icnAk0Eeg7LdyED/7EAE/FRQKK3/tu5FyX/ATx?=
 =?us-ascii?Q?6Wgqo3sUoQ7AhtTfGVvGQ6zw4I3I2yaSgII5RCoq9QxawuNELX8pYe/u1XU/?=
 =?us-ascii?Q?KNb0g3M0qTPefRgTToxt5C1xbSN2UwwMKeAGSmaARo6PivaViY5+j3WSk2JL?=
 =?us-ascii?Q?dMW2MuJn9Ojw5rs7BY2/gePCikn9E/WPVj5dAAMaJfW5UO8KtOpV7nEhsNkA?=
 =?us-ascii?Q?SgeL3f4Yun3+SROpu7Qz4x9fkbRRJPNFAcJpMFLQZkbDpai9aOzQSEY3fhMB?=
 =?us-ascii?Q?KUJpCDXPV9KpOdNaYvgnzLGi6IJjsyNTvYPrgGQKMPRg7GzEjiKEUEgz4q+G?=
 =?us-ascii?Q?B/pHCrhpYTqWPOKNY/xYHHJ3xIRXnUPYBsjVnvmtkXOv+J0PiDlJFjZ4W/wT?=
 =?us-ascii?Q?m5NoyEjiHbOtQPGnk2D8liffCvt5BRqXI/wC5xLnhM1rxDlBB7B6QtzXIrCH?=
 =?us-ascii?Q?psKGs5PWiDkMId3hbrt3T0yxfcLId4/ai33MdlTsgBaaNi3x7RbXajd74H1X?=
 =?us-ascii?Q?YF0CHRXH4S0epzN2yN5jh74sTlOP7T2JdQnNjnlKtFV9XKBP/c2SU4WCgATY?=
 =?us-ascii?Q?ycscJl8kmYaD4svZ1lqXhLF4lOlcMOGkgF3misUaBEmESjcWHDFFGrVGCm4T?=
 =?us-ascii?Q?SaILlO41pOrFODIURZlgK4lhv7xZHolQVZUvWchngLdiprQId3ctv+skkjxx?=
 =?us-ascii?Q?mk8yhJov/OhDjiFkY+NUWVQu+ARBKvpDK2bmYLGHtrtoRNcDSoFdcjAyvteZ?=
 =?us-ascii?Q?vuSJd9tflGydjizWrCfDRXtT1bXzE05Yueh0wAZqh+PZbyagEmB16aYJiJgi?=
 =?us-ascii?Q?2bMTatWkoGoWutVNSg6LgnWdO7rrGv22Gu/hNmg48RoQawD61Q9xfrXDb8hX?=
 =?us-ascii?Q?2u5IViRK0Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR21MB1140.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e5c72ee-226c-403d-5b21-08d9cfb7b7ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2022 19:23:41.6294
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O3wzQsuINnlYmPE0yR31Gc4/qFaYChVBOucVOSpnzsdF0cWeGbgMZHltlWbbrv8WQnBw23F5hFd4sGGfIdQ4c/OSLYdeowYOWy9/EwRt6bI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB1586
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 27 Dec 2021 17:38:07 +0000,
"Michael Kelley (LINUX)" <mikelley@microsoft.com> wrote:
>=20
> From: Sunil Muthuswamy <sunilmut@linux.microsoft.com> Sent: Friday,
> December 17, 2021 10:52 AM
> >
> > Add arm64 Hyper-V vPCI support by implementing the arch specific
> > interfaces. Introduce an IRQ domain and chip specific to Hyper-v vPCI t=
hat
> > is based on SPIs. The IRQ domain parents itself to the arch GIC IRQ dom=
ain
> > for basic vector management.
> >
> > Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> > ---
> > In v2, v3, v4, v5, v6 & v7:
> >  Changes are described in the cover letter.
> >
> >  arch/arm64/include/asm/hyperv-tlfs.h |   9 +
> >  drivers/pci/Kconfig                  |   2 +-
> >  drivers/pci/controller/Kconfig       |   2 +-
> >  drivers/pci/controller/pci-hyperv.c  | 241
> ++++++++++++++++++++++++++-
> >  4 files changed, 251 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/arm64/include/asm/hyperv-tlfs.h
> b/arch/arm64/include/asm/hyperv-tlfs.h
> > index 4d964a7f02ee..bc6c7ac934a1 100644
> > --- a/arch/arm64/include/asm/hyperv-tlfs.h
> > +++ b/arch/arm64/include/asm/hyperv-tlfs.h
> > @@ -64,6 +64,15 @@
> >  #define HV_REGISTER_STIMER0_CONFIG	0x000B0000
> >  #define HV_REGISTER_STIMER0_COUNT	0x000B0001
> >
> > +union hv_msi_entry {
> > +	u64 as_uint64[2];
> > +	struct {
> > +		u64 address;
> > +		u32 data;
> > +		u32 reserved;
> > +	} __packed;
> > +};
> > +
> >  #include <asm-generic/hyperv-tlfs.h>
> >
> >  #endif
> > diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> > index 43e615aa12ff..d98fafdd0f99 100644
> > --- a/drivers/pci/Kconfig
> > +++ b/drivers/pci/Kconfig
> > @@ -184,7 +184,7 @@ config PCI_LABEL
> >
> >  config PCI_HYPERV
> >  	tristate "Hyper-V PCI Frontend"
> > -	depends on X86_64 && HYPERV && PCI_MSI &&
> PCI_MSI_IRQ_DOMAIN && SYSFS
> > +	depends on ((X86 && X86_64) || ARM64) && HYPERV && PCI_MSI
> && PCI_MSI_IRQ_DOMAIN && SYSFS
> >  	select PCI_HYPERV_INTERFACE
> >  	help
> >  	  The PCI device frontend driver allows the kernel to import arbitrar=
y
> > diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kc=
onfig
> > index 93b141110537..2536abcc045a 100644
> > --- a/drivers/pci/controller/Kconfig
> > +++ b/drivers/pci/controller/Kconfig
> > @@ -281,7 +281,7 @@ config PCIE_BRCMSTB
> >
> >  config PCI_HYPERV_INTERFACE
> >  	tristate "Hyper-V PCI Interface"
> > -	depends on X86 && HYPERV && PCI_MSI && PCI_MSI_IRQ_DOMAIN
> && X86_64
> > +	depends on ((X86 && X86_64) || ARM64) && HYPERV && PCI_MSI
> && PCI_MSI_IRQ_DOMAIN
> >  	help
> >  	  The Hyper-V PCI Interface is a helper driver allows other drivers t=
o
> >  	  have a common interface with the Hyper-V PCI frontend driver.
> > diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controll=
er/pci-
> hyperv.c
> > index ead7d6cb6bf1..02ba2e7e2618 100644
> > --- a/drivers/pci/controller/pci-hyperv.c
> > +++ b/drivers/pci/controller/pci-hyperv.c
> > @@ -47,6 +47,8 @@
> >  #include <linux/msi.h>
> >  #include <linux/hyperv.h>
> >  #include <linux/refcount.h>
> > +#include <linux/irqdomain.h>
> > +#include <linux/acpi.h>
> >  #include <asm/mshyperv.h>
> >
> >  /*
> > @@ -614,7 +616,236 @@ static int hv_msi_prepare(struct irq_domain
> *domain, struct device *dev,
> >  {
> >  	return pci_msi_prepare(domain, dev, nvec, info);
> >  }
> > -#endif /* CONFIG_X86 */
> > +#elif defined(CONFIG_ARM64)
> > +/*
> > + * SPI vectors to use for vPCI; arch SPIs range is [32, 1019], but lea=
ving a bit
> > + * of room at the start to allow for SPIs to be specified through ACPI=
 and
> > + * starting with a power of two to satisfy power of 2 multi-MSI
> requirement.
> > + */
> > +#define HV_PCI_MSI_SPI_START	64
> > +#define HV_PCI_MSI_SPI_NR	(1020 - HV_PCI_MSI_SPI_START)
> > +#define DELIVERY_MODE		0
> > +#define FLOW_HANDLER		NULL
> > +#define FLOW_NAME		NULL
> > +#define hv_msi_prepare		NULL
> > +
> > +struct hv_pci_chip_data {
> > +	DECLARE_BITMAP(spi_map, HV_PCI_MSI_SPI_NR);
> > +	struct mutex	map_lock;
> > +};
> > +
> > +/* Hyper-V vPCI MSI GIC IRQ domain */
> > +static struct irq_domain *hv_msi_gic_irq_domain;
> > +
> > +/* Hyper-V PCI MSI IRQ chip */
> > +static struct irq_chip hv_arm64_msi_irq_chip =3D {
> > +	.name =3D "MSI",
> > +	.irq_set_affinity =3D irq_chip_set_affinity_parent,
> > +	.irq_eoi =3D irq_chip_eoi_parent,
> > +	.irq_mask =3D irq_chip_mask_parent,
> > +	.irq_unmask =3D irq_chip_unmask_parent
> > +};
> > +
> > +static unsigned int hv_msi_get_int_vector(struct irq_data *irqd)
> > +{
> > +	return irqd->parent_data->hwirq;
> > +}
> > +
> > +static void hv_set_msi_entry_from_desc(union hv_msi_entry
> *msi_entry,
> > +				       struct msi_desc *msi_desc)
> > +{
> > +	msi_entry->address =3D ((u64)msi_desc->msg.address_hi << 32) |
> > +			      msi_desc->msg.address_lo;
> > +	msi_entry->data =3D msi_desc->msg.data;
> > +}
> > +
> > +/*
> > + * @nr_bm_irqs:		Indicates the number of IRQs that were
> allocated from
> > + *			the bitmap.
> > + * @nr_dom_irqs:	Indicates the number of IRQs that were allocated
> from
> > + *			the parent domain.
> > + */
> > +static void hv_pci_vec_irq_free(struct irq_domain *domain,
> > +				unsigned int virq,
> > +				unsigned int nr_bm_irqs,
> > +				unsigned int nr_dom_irqs)
> > +{
> > +	struct hv_pci_chip_data *chip_data =3D domain->host_data;
> > +	struct irq_data *d =3D irq_domain_get_irq_data(domain, virq);
>=20
> FWIW, irq_domain_get_irq_data() can return NULL.   Maybe that's an
> error in the "should never happen" category.   Throughout kernel code,
> some callers check for a NULL result, but a lot do not.
>=20

Marc's response to this comment makes sense. Will keep this as is, going
by that.

> > +	int first =3D d->hwirq - HV_PCI_MSI_SPI_START;
> > +	int i;
> > +
> > +	mutex_lock(&chip_data->map_lock);
> > +	bitmap_release_region(chip_data->spi_map,
> > +			      first,
> > +			      get_count_order(nr_bm_irqs));
> > +	mutex_unlock(&chip_data->map_lock);
> > +	for (i =3D 0; i < nr_dom_irqs; i++) {
> > +		if (i)
> > +			d =3D irq_domain_get_irq_data(domain, virq + i);
>=20
> Same here.
>=20

Same response as above.

> > +		irq_domain_reset_irq_data(d);
> > +	}
> > +
> > +	irq_domain_free_irqs_parent(domain, virq, nr_dom_irqs);
> > +}
> > +
> > +static void hv_pci_vec_irq_domain_free(struct irq_domain *domain,
> > +				       unsigned int virq,
> > +				       unsigned int nr_irqs)
> > +{
> > +	hv_pci_vec_irq_free(domain, virq, nr_irqs, nr_irqs);
> > +}
> > +
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
> > +	struct irq_data *d;
> > +	int ret;
> > +
> > +	fwspec.fwnode =3D domain->parent->fwnode;
> > +	fwspec.param_count =3D 2;
> > +	fwspec.param[0] =3D hwirq;
> > +	fwspec.param[1] =3D IRQ_TYPE_EDGE_RISING;
> > +
> > +	ret =3D irq_domain_alloc_irqs_parent(domain, virq, 1, &fwspec);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/*
> > +	 * Since the interrupt specifier is not coming from ACPI or DT, the
> > +	 * trigger type will need to be set explicitly. Otherwise, it will be
> > +	 * set to whatever is in the GIC configuration.
> > +	 */
> > +	d =3D irq_domain_get_irq_data(domain->parent, virq);
>=20
> And here.
>=20

Same response as above.

> > +
> > +	return d->chip->irq_set_type(d, IRQ_TYPE_EDGE_RISING);
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
>=20
> This error path doesn't clean up correctly.  While parent IRQs allocated
> in previous iterations of the loop is cleaned up, the parent IRQ
> allocated in the current iteration is not.
>=20

'irq_domain_set_hwirq_and_chip' really shouldn't fail. If you still feel
that we should address this, I can.

> > +
> > +		pr_debug("pID:%d vID:%u\n", (int)(hwirq + i), virq + i);
> > +	}
> > +
> > +	return 0;
> > +
> > +free_irq:
> > +	hv_pci_vec_irq_free(domain, virq, nr_irqs, i);
> > +
> > +	return ret;
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
>=20
> Using the cpu_online_mask may work correctly, though its usage here
> raises a red flag for me.  The problem is that the CPU selected can go of=
fline
> immediately after the above line of code, as the cpus_read_lock() does
> not appear to be held anywhere in the call stack.  If the CPU is only
> a temporary placeholder and will never actually be targeted with the
> interrupt, then maybe the online/offline state doesn't matter.   But if
> that's the case, I'd suggest using the cpu_present_mask instead of the
> cpu_online_mask.  Hyper-V doesn't hot-add CPUs, so cpu_present_mask
> should be stable even if the cpus_read_lock() isn't held, and the code
> doesn't incorrectly imply that it's important for the CPU to be online.
>=20
> Michael
>=20

Thanks. I can change this to 'cpu_present_mask' in the next iteration.

- Sunil

