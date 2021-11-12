Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7A744DF46
	for <lists+linux-arch@lfdr.de>; Fri, 12 Nov 2021 01:47:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234518AbhKLAuM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 11 Nov 2021 19:50:12 -0500
Received: from mail-cusazon11021018.outbound.protection.outlook.com ([52.101.62.18]:56535
        "EHLO na01-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234146AbhKLAuL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 11 Nov 2021 19:50:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L6XY1oTnLoE7PjYdN8OWXWMsUVPq4BbEzWVpkkDrWDhNbvZCwG0tZA4B/BoLqouBEjqoZ1+dIUO+rv6YucEbOYprc71+WgztERbXAaXtRZBwbVdXoKK8tJ5qMw28dRgMFXGX75iipgL8RHX0z9RMjeSIFaQdQHnxekyJmashDYQWLALd1Qj7Ho9t249ruV6A0S4TcLIw2vAibGiUg3TngnBlTrM+b5SGeGQdPVK5TSJkiRQu14U9Tj8b7Y4Py53yvvmlph5fc0ov1LHIHMSxE3CvW3p5/BPsAivMcOmDqWmsiksS3lHUvYTsOjF9R2Cr4uAGtkhe90RH3EzKISWH5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y8//uVln7dkhW23rhahTx2BgVW0LU0B1VRLs3tOSMQk=;
 b=h34ZKgw/rs/0nhNmV3mwBEeyQ3B5cY/OJks/YvNYWx77yE3xooWjaijFMtuZFGBfFEBcUzpy+PXwME93FsHT8QJ8lUAY9ytiQ/eLtUwsEnhCdb+OuMJ3902bkf/f0ivohC0yFthhqU/UpQHshWJ8OYjiWZ4mdRYySUDxT2e6GYqfJXPDroaeiIgCF+Z5Ra2+jVS9yfK+YP4GujCuUEABLmyFlxYWS+PM1tXsRTj2eHckEu48PjxqpI11ZAY/NGsdi6xm0hUGI/5mO2zQ3WiOWLi5AMCQOA1fWVdzvcgYQ46BpeygV55Nse2D5Jk2IWCpc4tQ2LuSbLyTucbNh1bMdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y8//uVln7dkhW23rhahTx2BgVW0LU0B1VRLs3tOSMQk=;
 b=OrZehmLQ9nABSmrFEPEklqOTlEtTmlFrX06mHnpYsGL5ZnjhhkNDutSnKAMGM932NrevN3z1Km4RCk5xbx1yQePe2IWICULM2NcLkQ15c9c/Gg4RQUXOFUTQu7+Q7EzgmY/g6KsNfkGlgl4T6gWs0FvlrOFUNCvZjzIoDkrRv/I=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MW4PR21MB1969.namprd21.prod.outlook.com (2603:10b6:303:7c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.10; Fri, 12 Nov
 2021 00:47:18 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::b01f:ac55:463a:dd91]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::b01f:ac55:463a:dd91%4]) with mapi id 15.20.4669.002; Fri, 12 Nov 2021
 00:47:18 +0000
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
Subject: RE: [PATCH v5 1/2] PCI: hv: Make the code arch neutral by adding arch
 specific interfaces
Thread-Topic: [PATCH v5 1/2] PCI: hv: Make the code arch neutral by adding
 arch specific interfaces
Thread-Index: AQHX1muR3b5Wq4hIPkGDVCirjqOIj6v/D70A
Date:   Fri, 12 Nov 2021 00:47:17 +0000
Message-ID: <MWHPR21MB1593837874B0400A5F400DA1D7959@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <1636573510-23838-1-git-send-email-sunilmut@linux.microsoft.com>
 <1636573510-23838-2-git-send-email-sunilmut@linux.microsoft.com>
In-Reply-To: <1636573510-23838-2-git-send-email-sunilmut@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=3ad9aa78-f9a9-481f-ab02-dd1dda25329e;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-11-12T00:43:20Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e5bbe099-065b-4920-5651-08d9a575fa72
x-ms-traffictypediagnostic: MW4PR21MB1969:
x-microsoft-antispam-prvs: <MW4PR21MB196998199101F4FA177B0570D7959@MW4PR21MB1969.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:972;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IrF6S48vvYZyliWHnjnIGCw59xsIwQY9YI0asrimpEHZ2q7DTcJHQiXq16Nq8uhbUJaEze4OZspir1LqVvlG/OKWbgWeNXjgG/7IOdCWxFjhJmMfQMqQgQqGwJGOOGDz4L4S1dxdQ0ANXygAiEycN+kelargP+grkW8JUeDoALmBxvk3U3a9bExsBdD9EiVsNqKnbmrBrouckQX1iw8u4eFtTCy+Gn2ZSywfruO/+H7xS+OkcmETJ1NLyaoO8PKAlp1cZ8en2iUt8/AeYKVvm5EkqHfkjDX1W/JYtt58jND7za4BShIfIa1iMtdt8F5QlaAuhw+NU+gdxdheAgoqe/YYZApsuzxIKFsNGidav3PgYMqwYVcSc8YuhE424dr9bShel9TNwsQRF8hqY1vgzpPZqNprV4uWzCNo0mz7kKAwhpfGBnNS31qcx82ftPI0/roNWeYZwELICTal2uGdws6qW0MxQjxRnWYvf/3bo6HCVmNBkluO6jtUJaHktACABPVe/wJXeBYoYvbSzvy7FdDb5UwoRmbDKgISqzU209K3Os7WJoVtTEcaoIC46bqLgPyX1s2v4/8YM7WVLLz/5mgb5/2PEz6IdvXkS+UTqALemPtijc3OntQrB3RTxF8hDEoRXTtaTTlq/8OuDpcrdwMNbeCQY1xN5nQ8EiE2Tkc0F57jkHR5/PA5FYDPurHnltxeiVHSmrjq3s08s1dgxJKv9K70dtxHN0jjWPJ3iok=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(33656002)(71200400001)(10290500003)(508600001)(52536014)(66946007)(86362001)(9686003)(76116006)(26005)(186003)(7416002)(107886003)(4326008)(7696005)(6506007)(8936002)(8676002)(110136005)(64756008)(66476007)(316002)(54906003)(66446008)(66556008)(5660300002)(82960400001)(82950400001)(83380400001)(2906002)(38070700005)(921005)(38100700002)(122000001)(8990500004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZAbGTHag30r8nnf78LbO1adLZzExx9pcx3LA7G/j4HJT8Zkj2S3CDVy4Yjw2?=
 =?us-ascii?Q?7VuAGWXNDGapBoCx0i6u6RxHIV6r3/4y0yVBY6O0TimYla9pSXAgtzmn57VB?=
 =?us-ascii?Q?eiVXN/uJvrhC/s7TibRg+ZH1WMASLLeoLcFSHxDojOgs8tlCQr++EucLLKh2?=
 =?us-ascii?Q?bxWNC4XxIHshjQvgg+YKAehuYmZbZrqmK5rUN15KtMIiAeCbesQcpEaKkHmF?=
 =?us-ascii?Q?uROFcfrl5SwayBgIMU0PhFaUVnjX07jGiMj03VGlD1/KESbUGfgQ2xr3j643?=
 =?us-ascii?Q?FTfSEKfrxjYFHJ92M8eJ7xOHbXVSl5ZBq3gcjjVsus1ei+emiwpP5ftrmppv?=
 =?us-ascii?Q?t6kXe8+Jo4CmSHeowcYKvtDjo9o2GDEW48dQP5iqUAPf1rkEN+Ww5UZkF5lu?=
 =?us-ascii?Q?MsIFKcZ3lD8d94We7dCsQ5S+kKk2J6aTZ5vRYrPGB54+vgodvCXQYC2uAYqf?=
 =?us-ascii?Q?URQdLINXqFgBmWyPNS7Vp1P00uF8HJqssmzSAmlPMirlhpI6ZlbsKuIVivvb?=
 =?us-ascii?Q?gbQTUm61OGVe4eF3KSiKkbL8Y4/ZqhMmwT5seYAUNXZd7R2gtmRMBMXRqZvS?=
 =?us-ascii?Q?SPI29Q6MkcFoLgk/Ih6nBZX71SlZKpiauGO3LQo4DKivFefot27KEF2CzWVs?=
 =?us-ascii?Q?dEyXJ17dcugTJDyE5bLbstz17/BgGbHcpVT0DUGzuvyC61TRqiblHG2956SG?=
 =?us-ascii?Q?1NabJme3rLebtyXMz7uTEu/c8fdbfs73lCeSbHZ17I/6C3nGyf2FdydUUl4i?=
 =?us-ascii?Q?KIljVWiR53eqGnfg0S+tFZdJEaKDB3JYe5yXmXZVezC9MNlJv56mWy61Hzmv?=
 =?us-ascii?Q?pkOELLT70/NKOaZN8eIGOxWCCefee/kLI4d0EaU1UoAfrXgsSeNBpePn0CYb?=
 =?us-ascii?Q?jo4fVrU0LkHmyFLUfMS/Es0+dNCSv84wqGGtaJH6XgLNDinYsq8Un77KLvWi?=
 =?us-ascii?Q?0AUJ5C9m//84CkjX+zWF3R48YE2DtzQcIdw/LtZzwm5HoJK7pQzX0dZzd89h?=
 =?us-ascii?Q?VDkHUY4cy8YPrk0DYstoBc6Za1v/tW07J4GoGd+mv+XrjdEN7HapepVwyyMJ?=
 =?us-ascii?Q?CmbRJZRFDk7qy8ccl+3N5/tk1xFzsgt0Zcx0hNIjlu+HfIaUBX1BCiA2lAPj?=
 =?us-ascii?Q?zXs1Aquoh08lM+c0s4AIUPwJtLisPxfmLNQI742qwryceWiY7ITeI/JcrifJ?=
 =?us-ascii?Q?RHLvVzrnPc6fRvs3ck5qAcezrjhu2ZjMUjdshJp3cc9i6gnou3XKf60ijdDS?=
 =?us-ascii?Q?PKbpOEpbo33uk+BIsiFFGta/tVgRxF5vKEC+kGDAQx08IhMzODeZvSQ7yBvM?=
 =?us-ascii?Q?ppk397pEVCY313RfxiqeuuJDatwem4Tlf3fdFtGGkSuyDSQ/aX2hAmTBWzI2?=
 =?us-ascii?Q?CpsebDYrGw4D1OAN+PKSE7k4Zpg4ZpqELmt6UIzkAEegCEwW9j3JqHk2kdVn?=
 =?us-ascii?Q?7rjOI0nYcIDJAByBRd6q3EyiK+T7gweHMM5LBQMEdW7oamua25gIDMZ2Zwsh?=
 =?us-ascii?Q?6RntkALHc3/nEJtD+xXuhKVRHbNvqMTA/G9VJPcN7rn3VJrr7Z/gsKe7kmVM?=
 =?us-ascii?Q?OeS9Z1ML7mMyXPFR3pv8XUPgWZWvwHaQUM1tDhrOhC6kUr+s/RRXVzVXkJg6?=
 =?us-ascii?Q?uepAyVnUiRAjAlBlFJm+nBinUE8GLHxVt7qR1cPajA3bM1AVAs1RT6YpDr5H?=
 =?us-ascii?Q?lExhJg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5bbe099-065b-4920-5651-08d9a575fa72
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2021 00:47:17.9970
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BH72vDvH3/de621zEnKG/QmkZR84eMrXEob5J57B80oTYinNbjfXpobAqtL5OSgkp5uvQwTowZV5XgjEqffVdsGhSMOgJn0uOpfvXYkAVFE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB1969
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Sunil Muthuswamy <sunilmut@linux.microsoft.com> Sent: Wednesday, Nove=
mber 10, 2021 11:45 AM
>=20
> Encapsulate arch dependencies in Hyper-V vPCI through a set of
> arch-dependent interfaces. Adding these arch specific interfaces will
> allow for an implementation for other architectures, such as arm64.
>=20
> There are no functional changes expected from this patch.
>=20
> Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> ---
> In v2, v3, v4 & v5:
>  Changes are described in the cover letter. No change from v4 -> v5.
>=20
>  arch/x86/include/asm/hyperv-tlfs.h  | 33 ++++++++++++
>  arch/x86/include/asm/mshyperv.h     |  7 ---
>  drivers/pci/controller/pci-hyperv.c | 79 ++++++++++++++++++++---------
>  include/asm-generic/hyperv-tlfs.h   | 33 ------------
>  4 files changed, 87 insertions(+), 65 deletions(-)
>=20

[snip]

> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller=
/pci-hyperv.c
> index eaec915ffe62..03e07a4f0e3f 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -43,9 +43,6 @@
>  #include <linux/pci-ecam.h>
>  #include <linux/delay.h>
>  #include <linux/semaphore.h>
> -#include <linux/irqdomain.h>
> -#include <asm/irqdomain.h>
> -#include <asm/apic.h>
>  #include <linux/irq.h>
>  #include <linux/msi.h>
>  #include <linux/hyperv.h>
> @@ -583,6 +580,42 @@ struct hv_pci_compl {
>=20
>  static void hv_pci_onchannelcallback(void *context);
>=20
> +#ifdef CONFIG_X86
> +#define DELIVERY_MODE	APIC_DELIVERY_MODE_FIXED
> +#define FLOW_HANDLER	handle_edge_irq
> +#define FLOW_NAME	"edge"
> +
> +static int hv_pci_irqchip_init(void)
> +{
> +	return 0;
> +}
> +
> +static struct irq_domain *hv_pci_get_root_domain(void)
> +{
> +	return x86_vector_domain;
> +}
> +
> +static unsigned int hv_msi_get_int_vector(struct irq_data *data)
> +{
> +	struct irq_cfg *cfg =3D irqd_cfg(data);
> +
> +	return cfg->vector;
> +}
> +
> +static void hv_set_msi_entry_from_desc(union hv_msi_entry *msi_entry,
> +				       struct msi_desc *msi_desc)
> +{
> +	msi_entry->address.as_uint32 =3D msi_desc->msg.address_lo;
> +	msi_entry->data.as_uint32 =3D msi_desc->msg.data;
> +}
> +
> +static int hv_msi_prepare(struct irq_domain *domain, struct device *dev,
> +			  int nvec, msi_alloc_info_t *info)
> +{
> +	return pci_msi_prepare(domain, dev, nvec, info);
> +}
> +#endif // CONFIG_X86

Nit:  Use "C" style comments. I.e.:

#endif /* CONFIG_X86 */

Michael
