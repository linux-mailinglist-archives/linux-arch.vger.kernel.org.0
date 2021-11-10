Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA86B44C685
	for <lists+linux-arch@lfdr.de>; Wed, 10 Nov 2021 18:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232573AbhKJRzT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 10 Nov 2021 12:55:19 -0500
Received: from mail-cusazon11020025.outbound.protection.outlook.com ([52.101.61.25]:1059
        "EHLO na01-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232091AbhKJRzT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 10 Nov 2021 12:55:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QWpOj34dAT3FJL6Gc0SuD8xPTEZsMM2TBBBnwmF0QLCw39o2XFMB4akShRSgdfuDtdS/TpeMl+Na4SOniLOKEb2JvF7DWsVkuwMItYK+IUmuGGknbktECyFjRbI6l/hN7bZ99upYdZpLDRDN1c0YeJFOSoN3jrLQFoq1jXSdzxCvXGzWyD2kRktm0rFkhwafGjvr/u/HxMD8caQEihoUfLeXWbr4t4xOVsN9DfUHSTCM+rAHfLFQxBCs4PRhEDgfcKSUKMDa4FGw5Vvfgl5Me+oDXS780/WsoArt1rrl4HgcsRJkxB+9JJFToJh2WyXVgjkkFT4uvJAyYmgSbDd/VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RXkgvWIn7bUXipq1Qzq6FZ8Qd4ApRFuQqjDhkoaFJYc=;
 b=Q7NSRWdxZPYlmwkA3uP4VBR9c+40svAbTahbXCYsTON346JyCZjvvxRLFw+YuH6ioi/TaxkHqMll01qPRVLchmroi0/9CR+Lw8T5pJXUzjCGpz2xNlPfPML2bpqFsJB3sdLPW+KLsro17QmEL1mIUlULA70wgISpysfTpNIDZkhuIo7z7MxJZKeiR51xJWXY8NEeCoYM3Pv/L44DaGGBXq76qtdOFJC5SJ2lv65WROfEbbGD4F2urDpS+1RY3yP4NmWylhhfACXHaLPYS4CV0o+aAcwLBeIRo+U5idXLVPwQDeQznQTgC3s60R5D4D5rKIiDN9+4kE+oQRYdY74z0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RXkgvWIn7bUXipq1Qzq6FZ8Qd4ApRFuQqjDhkoaFJYc=;
 b=MpE6Dc8AA7yVBkLTHkGfLs/WQGTWHkYWafsEHFQnpglXMQZ5yY2JIZ0JHExfnPgqVCO4fxb2peVahAxUMDJ4xWNxwa9VDkO8tfeDGzhXmEb9xkmsRDTJKe88GRygmXfon1lFKkeW8AgsHo2KN77SKRBupXpCOV1IKwCpOSex6U0=
Received: from BN8PR21MB1140.namprd21.prod.outlook.com (2603:10b6:408:72::11)
 by BN8PR21MB1138.namprd21.prod.outlook.com (2603:10b6:408:71::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.1; Wed, 10 Nov
 2021 17:52:27 +0000
Received: from BN8PR21MB1140.namprd21.prod.outlook.com
 ([fe80::48fb:8577:ba03:23a5]) by BN8PR21MB1140.namprd21.prod.outlook.com
 ([fe80::48fb:8577:ba03:23a5%9]) with mapi id 15.20.4713.005; Wed, 10 Nov 2021
 17:52:27 +0000
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
Subject: RE: [EXTERNAL] Re: [PATCH v4 2/2] arm64: PCI: hv: Add support for
 Hyper-V vPCI
Thread-Topic: [EXTERNAL] Re: [PATCH v4 2/2] arm64: PCI: hv: Add support for
 Hyper-V vPCI
Thread-Index: AQHX1bderE/dJFbGykyqoP6WpgV6hqv8wAoAgAABlYCAAEjSEA==
Date:   Wed, 10 Nov 2021 17:52:26 +0000
Message-ID: <BN8PR21MB1140769D6EC879C646E7DB92C0939@BN8PR21MB1140.namprd21.prod.outlook.com>
References: <1636496060-29424-1-git-send-email-sunilmut@linux.microsoft.com>
        <1636496060-29424-3-git-send-email-sunilmut@linux.microsoft.com>
        <87v91087vj.wl-maz@kernel.org> <87tugk87m4.wl-maz@kernel.org>
In-Reply-To: <87tugk87m4.wl-maz@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=54c4b1b7-16a5-4b88-8df4-065c7b9b4d8f;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-11-10T17:46:49Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dc2357dd-af8d-4e27-9f9e-08d9a472dbcd
x-ms-traffictypediagnostic: BN8PR21MB1138:
x-microsoft-antispam-prvs: <BN8PR21MB113859D548D20F1B60AD1C62C0939@BN8PR21MB1138.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Boc6Yemki5tjnShUbDw26Mzg5sEv8ZJLWnGvKhwYtcGSx7gIXwW5dlTlJXbEQhyVuY9T4J6UPgZN5NJgSJ+4B1SmYSxDMF6eAPy3+rgQ9vppD1p/lVWF9UA1/Ef5goNJiRpoadguaokzbg959woPbo9jHs9MQ3fCDA4gqzJs9zGaZ5d09nSkl5YHfENnfCz0M2asOBkZc7f8px+StSgPhpUZmaZk03tK2tNUviqYMQ1bH6n5ZLZQywvnPaFNJGk76gbsP6z+xJnXlreEOdFQnqYslx9BqHhQJsb0a1CZaESphvCeCA9/BE9qBusn3P0JgfgZKcgiBtnmmCN07F+sIF7DOtQT8KfXIMPX1L41si0ME6QXrLrmEbsMZm6escO2HztLa5Ijob5IsqQ+slW6bz+cvHWFkeIFMDfMSF4dp8pk9ag9aLrFUQO/T+tuNFigzrfq+mSQnW5YcY+DTxhYPlA+5VaEJO6aWFO+qNksE80QIiAyruVgP4sRxCPlDOAGQSh7JBc5XssSJb9j4y3t2FL5/AfSUK80ihYoRX8xufQ3/2Ju4AZsydZBQwEklrez8jBONmXcRbMqKnM09zGJtkpeuL7ipIjW1y9eHVQgJMuOYqcLLW0loqt9BH67h9yicIw8G0/DDneS2RBil8qQGYKW6E2AaISLk6tkXrHpH9r9Y0+ZQL0KG/h+4pbBVpU2uo3P1w3CuCOc5kfNabixCA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR21MB1140.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(122000001)(10290500003)(66476007)(110136005)(83380400001)(508600001)(71200400001)(54906003)(33656002)(38100700002)(7416002)(76116006)(64756008)(66446008)(5660300002)(66946007)(316002)(8676002)(4326008)(52536014)(82950400001)(53546011)(8936002)(2906002)(8990500004)(82960400001)(9686003)(7696005)(186003)(6506007)(66556008)(86362001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ilC+QXt7j8aHvKJ7SJxMVyhfr4R71Y72QgxSxqK+6s5VBWsUI5iBEzM9b28M?=
 =?us-ascii?Q?0El3nmrI1qNKD/lFaWTyfq/2UaWR21SMs+fa8g5vS4h4X1wnd4rP98Fs/LF3?=
 =?us-ascii?Q?sF5LXGPloU7tw9bXZpoB9V70cFQXz3om1DgtH9mRklAZNovw1FbjWCT3KNEZ?=
 =?us-ascii?Q?94ysBdzTkBMYihwmpcGQjFkwOaqQpkMewtFhONxb40oIJiVfqu/3zyKnLow6?=
 =?us-ascii?Q?OWzYHsLaSbEDqYicI7g8C/MCSUOZdHzHtH/CbdDgOTmpGzYB7WXKrlA5w3bQ?=
 =?us-ascii?Q?cAmeHMSBA/z7JypMfWu6mn7sf1xvyAjHfxQwUZhckBsi/JsL2KTb0/3W7rOX?=
 =?us-ascii?Q?L2BzaDUq98hyJIFbZEHkdvCPYCRmlrYo8ZA3CenwYlxlDZdJrcnTQJP1+RbA?=
 =?us-ascii?Q?fOPGIA49QXRFdRjf2z6R4Y/a6AjomiDNlAILfeN7rvy36DzCDAnAQDfeQrBF?=
 =?us-ascii?Q?VhXlQ2i5uuFwhwuHqgYMXbidpb5oOLnuFSmFQxrAaQlBEN547Ae2YZ4R6y3d?=
 =?us-ascii?Q?syW4Rt+NM7KPal4SMNuIvmMbJrq91fLcQz53IerWk0c/UgQZLMqaS8hOSLpD?=
 =?us-ascii?Q?KYXz86iDrYUIHJAtcgRS3FSd9VCT1wqtboiGsNTQDRolhjmMNzc/wVKK0PtJ?=
 =?us-ascii?Q?Nj0HQyf+K4v20EBvNFnamMCsHWyolOXnQfBbTxZAw5ZduAM9sFbm7be3Y7tJ?=
 =?us-ascii?Q?lK/7LfQpqnCJ7GC4TG1nvzJ932f7/CQjhrblnjO0Rcb/fZGRvP/dUvmWhI1n?=
 =?us-ascii?Q?szt+YzVrTJ+MVgMVLJWKkb3l9yqO5wDswKs5br+xkmX28vAPcoK9hSExuEzK?=
 =?us-ascii?Q?YdJtSvI9afXHMXjDQgqkYlfHn6I+kIlnmPiLU5HbW/43hhe6uKjOkeGMUs77?=
 =?us-ascii?Q?vZQf/8b9H8nnvMPJwrfnrz1RlpY+YrxeSM3GKo+2OAaIi4sN6wZys+YIvE9H?=
 =?us-ascii?Q?WwAa6qSnYG7Ij8FHGwvlRhpXfyVLSSaMzcZ2Qzgy8HJzldoP0Uz2ejPniRI6?=
 =?us-ascii?Q?Sfm8oquWEs+V6p8WNKmaXDa+f0oouz+aLXVw7JmyquFHDk0vaTYe04b0TCEX?=
 =?us-ascii?Q?mIC3lYxTyrUs/gkaX6HmvXVFBBKyqgqfh50kwuSpsJbQB5bmk4zabRd6SFXs?=
 =?us-ascii?Q?xUjYIOletilTfTm18btA1TxQpu7cXtSyXZTFkZ9HpdlpObFG+jPUDIMk9D4L?=
 =?us-ascii?Q?iVnnJrynXQw748hfXZegYlRxVelv5TrCyFK7NqaZMNynv5tz25UfoJnFlcxU?=
 =?us-ascii?Q?X3LbelcolaEwAtrLJkmNXPNhzTOApcmMA621EzRoWeKCzgK1Z9T7WIWycx5l?=
 =?us-ascii?Q?hPiHiMd8xYNOUYmpHyzkaiahP+ppjSslOownbF6X9QWQs1H6CHgMszwjRj0G?=
 =?us-ascii?Q?+P5zHDR53Ztf8W8oXFLmhAjt7D+aNfiDEGDMizSbJi/Jg+a1ap29/qdfU1n+?=
 =?us-ascii?Q?e74mry5jljUj8zR9x/e74gIwZ6fQMuu6KqDYnUXH4ax0d2ZbYiIraMPJqro5?=
 =?us-ascii?Q?KcLmX+G9VaP0L9B95/Q21vjS+22cr0Vu02rp8CIe3aRAjO0hiNSUcGuk86jY?=
 =?us-ascii?Q?HAbtr3aDdbxANofnOzAb49LAFEgXIG8t5/By1Qr7DaQgb1XfWplRjA5zZEcy?=
 =?us-ascii?Q?DTxzKFlpgk2C5BBwBytUJe8S9fM1RRlokNtjGt1ajuZ8IklLoPoL9VnQWy9a?=
 =?us-ascii?Q?XSL3nZmOO8Y/DGm7zotiM93izYSeRRMJUepaDTUJKXkLeYBMnxRwRIrp0CXm?=
 =?us-ascii?Q?ZE3WnhAVVw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR21MB1140.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc2357dd-af8d-4e27-9f9e-08d9a472dbcd
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2021 17:52:26.9009
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E5cclQNQ2yPLA3vBdh6Hebyb/R7Tz2PodCrKGGC0HfgA8HoGjOqBeT+udScn6BkS/9WD5QJB1LHoCGXTjXRluQBgnxgRnQ4zPcveMcJa5yk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR21MB1138
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wednesday, November 10, 2021 5:26 AM,
Marc Zyngier <maz@kernel.org> wrote:

> > On Tue, 09 Nov 2021 22:14:20 +0000,
> > Sunil Muthuswamy <sunilmut@linux.microsoft.com> wrote:
> > >
> > > From: Sunil Muthuswamy <sunilmut@microsoft.com>
> > >
> > > Add support for Hyper-V vPCI for arm64 by implementing the arch speci=
fic
> > > interfaces. Introduce an IRQ domain and chip specific to Hyper-v vPCI=
 that
> > > is based on SPIs. The IRQ domain parents itself to the arch GIC IRQ d=
omain
> > > for basic vector management.
> > >
> > > Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> > > ---
> > > In v2, v3 & v4:
> > >  Changes are described in the cover letter.
> > >
> > >  arch/arm64/include/asm/hyperv-tlfs.h |   9 ++
> > >  drivers/pci/Kconfig                  |   2 +-
> > >  drivers/pci/controller/Kconfig       |   2 +-
> > >  drivers/pci/controller/pci-hyperv.c  | 207 +++++++++++++++++++++++++=
+-
> > >  4 files changed, 217 insertions(+), 3 deletions(-)
> >
> > [...]
> >
> > > +static int hv_pci_vec_irq_domain_activate(struct irq_domain *domain,
> > > +					  struct irq_data *irqd, bool reserve)
> > > +{
> > > +	static int cpu;
> > > +
> > > +	/*
> > > +	 * Pick a cpu using round-robin as the irq affinity that can be
> > > +	 * temporarily used for composing MSI from the hypervisor. GIC
> > > +	 * will eventually set the right affinity for the irq and the
> > > +	 * 'unmask' will retarget the interrupt to that cpu.
> > > +	 */
> > > +	if (cpu >=3D cpumask_last(cpu_online_mask))
> > > +		cpu =3D 0;
> > > +	cpu =3D cpumask_next(cpu, cpu_online_mask);
> > > +	irq_data_update_effective_affinity(irqd, cpumask_of(cpu));
> >
> > The mind boggles.
> >
> > Let's imagine a single machine. cpu_online_mask only has bit 0 set,
>=20
> single *CPU* machine
>=20
> > and nr_cpumask_bits is 1. This is the first run, and cpu is 1:
>=20
> cpu is *obviously* 0:
>=20
> >
> > 	cpu =3D cpumask_next(cpu, cpu_online_mask);
> >
> > cpu is now set to 1. Which is not a valid CPU number, but a valid
> > return value indicating that there is no next CPU as it is equal to
> > nr_cpumask_bits. cpumask_of(cpu) will then diligently return crap,
> > which you carefully store into the irq descriptor. The IRQ subsystem
> > thanks you.
> >
> > The same reasoning applies to any number of CPUs, and you obviously
> > never checked what any of this does :-(. As to what the behaviour is
> > when multiple CPUs run this function in parallel, let's not even
> > bother (locking is overrated).
> >
> > Logic and concurrency issues aside, why do you even bother setting
> > some round-robin affinity if all you need is to set *something* so
> > that a hypervisor message can be composed? Why not use the first
> > online CPU? At least it will be correct.
>=20
> Everything else holds.
>=20
> 	M.

Good call on not being able to pick cpu 0 and that being a problem for
single cpu system. The cpu initialization should have been '-1' to be able
to successfully pick cpu 0.

I don't see concurrency an issue because this was a best-case effort to
randomize the interrupt distribution across cpu's. So, even if two irq's
ended up with the same cpu, that will still work.

I also had thoughts of just using the first online cpu since this is just
temporary. So, I will go with that as that will also simplify things. Thank=
s
for your feedback.

- Sunil
