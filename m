Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5B1044CD19
	for <lists+linux-arch@lfdr.de>; Wed, 10 Nov 2021 23:48:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233633AbhKJWvR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 10 Nov 2021 17:51:17 -0500
Received: from mail-cusazon11020024.outbound.protection.outlook.com ([52.101.61.24]:20283
        "EHLO na01-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233569AbhKJWvQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 10 Nov 2021 17:51:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WAXeoBKRIeVX3uVF4cWyq4fMFmp+xL5I6ngEXmSUgBJhi1QbmNgDlgFZHClB9pymL2c4sMz+EkoSH1gNjPk/gsv8pxeE9h3VO9fAt1XtpyFczApUh2eYsG6CUHIAy4iPxBnasoYs7W+FRHdb5z1uqiSVGHt9+TS9/6CcJT+S9vf9K8IOjcbxnTEXHJxFDI/bM4o8lwf+GfGM6fZNMdjzHbjeotPUeMW72QOBB/jQbG/+KVhRrIrnE7SxZlgggMNQHkl5Sr8d+tD3Ixbo5iHR92u1vepNLu+OThkWt8i8YuPaCMij62O8YBD91daRQz3A7bsrw8dQZb9Tx3e3UZfMjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3JdLUl7J48CDYNkvR5SrfXw7aWSZE3ofeqpCtisizsc=;
 b=TKblW/m+uLmfMVK7kiZkda9BRREr1/k7YxVBM7N4c0DF5FprC66o8+rHmhZrryWmzB6uHk5363wFJ0BenKO02b9fZcD6gw2V01wB70Io495oAuR7RER8UtjxBncrP/1KzKQVI8w+wWyb/SD6L30f71VuWOCgH6vltXFeEwK2J9+DeHnT226AMkZ18k1PS4xWyOpAKApkhYDWu9kFzFS2WS79Z1RFNDHkyTkLkBk2KtK+QpZPTpYYDmM9YXb6VqkObC3LQBgCuK+ElJngYdx/TcYFaLMoADwcNuV7JNdBjOZK5k2jk1rNe40uLKrEiuy2x1NccYG0WX/7/OO//nv2nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3JdLUl7J48CDYNkvR5SrfXw7aWSZE3ofeqpCtisizsc=;
 b=j3QOGLorzWxs/rN4KYduK6dz3wOfmCpRedeiV+zkXf8Yh1CMulTxr8+L33hIixibn01uAmXrEF9rQPDemX+ZLu+KmLXhBQU5G8pP7wAGZ1ode1lo8HzCIAnF6uqGyTx2T39cCq4NCpzhyILtskl+hH8yWNnBcW0rgRkYvmlU1fQ=
Received: from BN8PR21MB1140.namprd21.prod.outlook.com (20.179.72.139) by
 BN7PR21MB1666.namprd21.prod.outlook.com (52.135.243.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4713.3; Wed, 10 Nov 2021 22:48:24 +0000
Received: from BN8PR21MB1140.namprd21.prod.outlook.com
 ([fe80::48fb:8577:ba03:23a5]) by BN8PR21MB1140.namprd21.prod.outlook.com
 ([fe80::48fb:8577:ba03:23a5%9]) with mapi id 15.20.4713.005; Wed, 10 Nov 2021
 22:48:24 +0000
From:   Sunil Muthuswamy <sunilmut@microsoft.com>
To:     Sunil Muthuswamy <sunilmut@microsoft.com>,
        Marc Zyngier <maz@kernel.org>,
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
Thread-Index: AQHX1bderE/dJFbGykyqoP6WpgV6hqv8wAoAgAABlYCAAEjSEIAAU4WQ
Date:   Wed, 10 Nov 2021 22:48:24 +0000
Message-ID: <BN8PR21MB1140C4416E0B338A8FDBA18BC0939@BN8PR21MB1140.namprd21.prod.outlook.com>
References: <1636496060-29424-1-git-send-email-sunilmut@linux.microsoft.com>
        <1636496060-29424-3-git-send-email-sunilmut@linux.microsoft.com>
        <87v91087vj.wl-maz@kernel.org> <87tugk87m4.wl-maz@kernel.org>
 <BN8PR21MB1140769D6EC879C646E7DB92C0939@BN8PR21MB1140.namprd21.prod.outlook.com>
In-Reply-To: <BN8PR21MB1140769D6EC879C646E7DB92C0939@BN8PR21MB1140.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=54c4b1b7-16a5-4b88-8df4-065c7b9b4d8f;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-11-10T17:46:49Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 54c539aa-5bdb-4ff8-ecf5-08d9a49c33f6
x-ms-traffictypediagnostic: BN7PR21MB1666:
x-microsoft-antispam-prvs: <BN7PR21MB1666B5F85B686389BCF5617DC0939@BN7PR21MB1666.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R/3UmAUQ+ha9yYo30/33GerQpr0/ei6+Lqz4/810EhVv3L9Fy+r7i8EJxFSypPtZ9+pigpUCM2F0WY1YsxCBIS5oTKyHerQwCRS0t8fnL5fxgJBXExyp/em4wCYVvno3O6vM7I2YiV1AD+E8MMH3tfu8cuVvQgMw7GzzGegvVvNLJppbiONcUbot8ynL0miheBTC/lpm+CSyAb7lK2qard3vwtVVDAAM5LZk0AEU/rwtCGJ7hsmHvwTi6CrYCYdD693OdPVa2XE5bo1MG+0fHlOUaQ6VNFglgHcrgu9ST/ENv20OiyoP3LkdJA/cedKcYhB5AfdRw0/hdUtDt30QPu9FgvIvlCpaXRhc8WkqU6f5oq7Q236sAPd4S8Hc91hIWb4SUn+gIf/ZI7Dij+3HNH21ZyK8evsRZmGRYD+ZzWniwAyI/ytHxZLvR5tMlZg5rQ/eC2PQU9xdBjwlg3badF2+/iX9sqcVQ9ehPgWKa+9EXlzpQJQG79Fgnv56xQIir5b5HU9Zns7us/F5NIgm3+VDYcPOH6JUZkpAKbYoBOxVub+pCSak/XUc1nDRhZJytcRX1udTtN2Pvo8EC5bmVZYTlBNVtIjdIkjhTJ7TYGsKYmvv14G0PVin2AHIVkJb69KQVNMlhqH8HNKUPdAUswZUFv2iwSgGcooLnFitAtbRD6VpieBj0ieMPyjwSKBWHpBEfTF+El7l5GaxDUHmeA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR21MB1140.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(8936002)(66446008)(8676002)(64756008)(4326008)(8990500004)(186003)(38070700005)(122000001)(38100700002)(86362001)(83380400001)(2940100002)(110136005)(66556008)(7696005)(10290500003)(76116006)(7416002)(5660300002)(316002)(33656002)(82950400001)(82960400001)(54906003)(66476007)(508600001)(71200400001)(9686003)(6506007)(66946007)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OYdZ7C/69NWeeQWQayPnzAPa/5xFTzVSpt+4FklOg7+R2qHcJIFsNDEKey2u?=
 =?us-ascii?Q?h7Kg5BVNQxnWMGJ7tVXaZ4La231WVAZkDLA37F6vIr0s54QYlZtn7JBG/0Qf?=
 =?us-ascii?Q?Xl/mz5trNs6a8VgNx+1ZNzihMNjEMddWalocf+E3jkIQ7G2YyYRH9w3r08uH?=
 =?us-ascii?Q?G/O6v7kiBUVl+nkvNaofcX2uiZTXhpu5s38sdEAE5KeFFa8D2QNXwVO57QGW?=
 =?us-ascii?Q?ahEDP4jz0D5hCqrOHS22mmf/VsTXZf/6NmfUMHGslwxZmrIq5eEUqb2ZR/Fu?=
 =?us-ascii?Q?Wthz5SpyzsVJWNsRz6DqhS2cEa7ap/t7phG5axIHGmjhTkkOKBeD0CeDVeYy?=
 =?us-ascii?Q?Au1jvTjXhDW/OXUgmKEU0k28fNTVFiPliDIXspph8Gm5GMQmiJDU0h2rBYwA?=
 =?us-ascii?Q?g/PRl4XWRpAQOWLw0hAyqpPqxnkCZnlvf+jMEQ9tXScHg6wFF5D6aHLRKb9Y?=
 =?us-ascii?Q?HKfNBYvCNSlPCsDeUQwXEuYMybMNujEpgIcupSc9sLyLzHu2jnc3uxG3B2su?=
 =?us-ascii?Q?2QaeWcHhBth/Dylp1Z1cH5rA0S1e1EXiqnEQDIh/gcaBTThZ1XLRUsNN+JIO?=
 =?us-ascii?Q?o6+m+CaKxbMMDyrM/iYFvgXkh+ENNd2NJsAud8HzjoH1moHUhvRPoIRJHJ7P?=
 =?us-ascii?Q?465ZzV/GTXHsZKe5M8hkNFc/THIjeAWvE0ysRKRX2DNEfjgHDCsavIMXCOBv?=
 =?us-ascii?Q?fDeD1qTi6TbuP6eYU77j66YkzsRN6PoD1+kDTwyCmJng6ntYlDowHtnp6k1H?=
 =?us-ascii?Q?Z99hOVxbEgwTSxGFH3ydfloaOORslILgRq5/IOJhlByJZzVv+xr1CUlJd+6b?=
 =?us-ascii?Q?FV9Rz9OQ0DKOTGIAkW/eWpNUb6Rk/V++OwdG9JVuckKKlOlh3LGby+0zwdSS?=
 =?us-ascii?Q?UwGKmo+Gy/pbtDOv38/3H8bgldluWzhpgYT6W8tjJyL/7oP4bKltw2VBpxaw?=
 =?us-ascii?Q?HJViFXjyY/387dl5qXvScUrJUJB6wgXLRL176LYXP821wasf9xJOuB3LsIiW?=
 =?us-ascii?Q?7ZU8m+qHV16UWXcpHoFjGN81DxJQmGHfcWo/LKz/OWcfnCao4s2Xpp8TiabK?=
 =?us-ascii?Q?81WWIDHBLXkM3gswWVKfQQsa2gz2RA5MnxIRkmO0Xga0SQjMosOy0WBWGOiR?=
 =?us-ascii?Q?LbQzs82dLZ5gKxwsDoiMhYoMEDg/l84Fv+zJ0asj1ScjJhtOKRcDkteTpKCv?=
 =?us-ascii?Q?OYSIOpBx/XQJPWecZAzHs/kS89/Qa4v7YWhgMkkHKiqFTUDt6sq9h3Ju3fxG?=
 =?us-ascii?Q?1dlkiNp1qgQwMth1LS70xnJ2+gN8js5DC2x8d8t6wJdbJAyX33lIBkFKrVPs?=
 =?us-ascii?Q?cN7Y/gD3qTN6FxrLQZkXVXMHq5nVZ+mJMSRUtyvy1yXj9+NiVPPWUE1q+uTA?=
 =?us-ascii?Q?/o1gWiURdGgAEOiRLweXGkIel07EGQ8mC4A0/B7YD+PFsvbAuhZhpewPVBX0?=
 =?us-ascii?Q?qgSJJP//jrUEMv2sZ5GhAPaa+k4+eht9MVgvnVWuj+Xx8tJ814ecW6+fxl1u?=
 =?us-ascii?Q?9SLrua6ivzW5Fm/yEBHtUaaAQManmllvOWwaXFWsQXExqhzZH9J6TuATHyk/?=
 =?us-ascii?Q?vJJAYMy9Mf5vMxZjr68cueI+xd1736Q454rOIozL/4w+r6PinKsWxUf964PE?=
 =?us-ascii?Q?gAHeZztgfDRrGzNx3TXbJVYItmivaDXVx+AzKGes0PA9ARF6e/mHafrksUmB?=
 =?us-ascii?Q?GpzlvZ+HmnE9EgC9EcXxYJNxA1lInRyo6d44S7OVBaMdMf3bf799pp71j/sX?=
 =?us-ascii?Q?bioji6qlmA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR21MB1140.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54c539aa-5bdb-4ff8-ecf5-08d9a49c33f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2021 22:48:24.2320
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZzOz+8a97RLD09nIgnUMbqrgT69Bh9Yb8S6+4V5u1pzd61Ka6jgrlvlj7Mcl1m0mehGy1g3haHbvqdezn2h/NDAFvTFmbVX+/Gz0EflZ5X8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR21MB1666
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> > > On Tue, 09 Nov 2021 22:14:20 +0000,
> > > Sunil Muthuswamy <sunilmut@linux.microsoft.com> wrote:
> > > >
> > > > From: Sunil Muthuswamy <sunilmut@microsoft.com>
> > > >
> > > > Add support for Hyper-V vPCI for arm64 by implementing the arch spe=
cific
> > > > interfaces. Introduce an IRQ domain and chip specific to Hyper-v vP=
CI that
> > > > is based on SPIs. The IRQ domain parents itself to the arch GIC IRQ=
 domain
> > > > for basic vector management.
> > > >
> > > > Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> > > > ---
> > > > In v2, v3 & v4:
> > > >  Changes are described in the cover letter.
> > > >
> > > >  arch/arm64/include/asm/hyperv-tlfs.h |   9 ++
> > > >  drivers/pci/Kconfig                  |   2 +-
> > > >  drivers/pci/controller/Kconfig       |   2 +-
> > > >  drivers/pci/controller/pci-hyperv.c  | 207 +++++++++++++++++++++++=
+++-
> > > >  4 files changed, 217 insertions(+), 3 deletions(-)
> > >
> > > [...]
> > >
> > > > +static int hv_pci_vec_irq_domain_activate(struct irq_domain *domai=
n,
> > > > +					  struct irq_data *irqd, bool reserve)
> > > > +{
> > > > +	static int cpu;
> > > > +
> > > > +	/*
> > > > +	 * Pick a cpu using round-robin as the irq affinity that can be
> > > > +	 * temporarily used for composing MSI from the hypervisor. GIC
> > > > +	 * will eventually set the right affinity for the irq and the
> > > > +	 * 'unmask' will retarget the interrupt to that cpu.
> > > > +	 */
> > > > +	if (cpu >=3D cpumask_last(cpu_online_mask))
> > > > +		cpu =3D 0;
> > > > +	cpu =3D cpumask_next(cpu, cpu_online_mask);
> > > > +	irq_data_update_effective_affinity(irqd, cpumask_of(cpu));
> > >
> > > The mind boggles.
> > >
> > > Let's imagine a single machine. cpu_online_mask only has bit 0 set,
> >
> > single *CPU* machine
> >
> > > and nr_cpumask_bits is 1. This is the first run, and cpu is 1:
> >
> > cpu is *obviously* 0:
> >
> > >
> > > 	cpu =3D cpumask_next(cpu, cpu_online_mask);
> > >
> > > cpu is now set to 1. Which is not a valid CPU number, but a valid
> > > return value indicating that there is no next CPU as it is equal to
> > > nr_cpumask_bits. cpumask_of(cpu) will then diligently return crap,
> > > which you carefully store into the irq descriptor. The IRQ subsystem
> > > thanks you.
> > >
> > > The same reasoning applies to any number of CPUs, and you obviously
> > > never checked what any of this does :-(. As to what the behaviour is
> > > when multiple CPUs run this function in parallel, let's not even
> > > bother (locking is overrated).
> > >
> > > Logic and concurrency issues aside, why do you even bother setting
> > > some round-robin affinity if all you need is to set *something* so
> > > that a hypervisor message can be composed? Why not use the first
> > > online CPU? At least it will be correct.
> >
> > Everything else holds.
> >
> > 	M.
>=20
> Good call on not being able to pick cpu 0 and that being a problem for
> single cpu system. The cpu initialization should have been '-1' to be abl=
e
> to successfully pick cpu 0.
>=20
> I don't see concurrency an issue because this was a best-case effort to
> randomize the interrupt distribution across cpu's. So, even if two irq's
> ended up with the same cpu, that will still work.
>=20
> I also had thoughts of just using the first online cpu since this is just
> temporary. So, I will go with that as that will also simplify things. Tha=
nks
> for your feedback.
>=20
> - Sunil

But, yes, for the concurrency, I do see a possibility of a race condition
with the last cpu check and 'cpumask_next' call where it could lead
to a failure. v5 moves this to the first online cpu and that should
fix this issue.

- Sunil
