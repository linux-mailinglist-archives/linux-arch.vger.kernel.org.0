Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3B33C62CE
	for <lists+linux-arch@lfdr.de>; Mon, 12 Jul 2021 20:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236019AbhGLSoM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Jul 2021 14:44:12 -0400
Received: from mail-mw2nam10on2129.outbound.protection.outlook.com ([40.107.94.129]:40142
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235961AbhGLSoL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 12 Jul 2021 14:44:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AvduFH0qh+3HemIa/BbE1JslFWugljmtYg8F1+lwIuVJuu4iDr6y+xKE9KaYOdjjDCiCsxih9PE0ID2S3LMpP4ty9t6LyVlm9KmaIZxrmqncKEMqBCmJILLE9Pe6z7HrypTSEjKKaXeIIofsq1ahf3JWXFtJdnStzzmKfOWd1/VZNzNPCB9kicPOBEBxsDKk9KiQd14VwuYtCrmM1K19a50F7jedEKB7R9rATX/oLs/JxPp0VC/mfrrTFsha2G3b9t/IzDBEXhJk3JAb7bG3ZbINXIPRXzl7+ZI2L16TJhI8Tf7laHpiHNy02HClAhbx/z+2As9uJFfiH6mzwE+/8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LmqSURLeSpDNDUehAquS1nNQIxmhXsdpAxOJvZ4eaKw=;
 b=ZjeJgiqVtz0pDmQjJfw15tF3FS+BBVxfR2gyimCL8BhPwzpZFVX5slaLwOVG2/ELSRJpwTvgPEHFk9QLj89QBGLdV3mpKdJDnXWLlOamA0pKe0X/e4rANx+prKGJoCHvp1BzjzB/6Q0fd5AhKjI5oYg2uokrCVisa2ilfWvWeW3UmykRDieYABTyj+GT+8X49rz1ozOdk1oZUxju85VAwoxsPdGeRj6fnHpI2xGgaaMrA9lZydfJ9/qwtvEOMo+6T9ny8qFZn7YFAJw228igfFo3ZqZDbX0ZOmmPU9b34E5FgNv/IpY+FMXpgmKAOBQDNEQYQVO0ETodKLxdxJtQ/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LmqSURLeSpDNDUehAquS1nNQIxmhXsdpAxOJvZ4eaKw=;
 b=gtuI8OTlAdJda8MzLuA40LPYkviL5YCI+lFh6n1eSfNLgBCBuqSupt0aroJSd1QDUH7h3T5Y7bGcSmdJKHGhH1lJ+x4cbA7Upx+Zk1aPF+RyASpPu0Wye1JeMLWj05IGIoUXwfk9HOJl8r4fCThzD/QdiN1yAmZT4jARDF5e6gg=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MWHPR21MB0701.namprd21.prod.outlook.com (2603:10b6:300:128::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.0; Mon, 12 Jul
 2021 18:41:21 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::cdf4:efd:7237:3c19]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::cdf4:efd:7237:3c19%7]) with mapi id 15.20.4331.009; Mon, 12 Jul 2021
 18:41:21 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Wei Liu <wei.liu@kernel.org>
CC:     Stephen Hemminger <sthemmin@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>, "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: RE: [PATCH 1/3] Drivers: hv: Make portions of Hyper-V init code be
 arch neutral
Thread-Topic: [PATCH 1/3] Drivers: hv: Make portions of Hyper-V init code be
 arch neutral
Thread-Index: AQHXds2rhqT2D+K6s0CIElMrT3pK6Ks/qI8AgAADDgA=
Date:   Mon, 12 Jul 2021 18:41:21 +0000
Message-ID: <MWHPR21MB15930361106EDB7183D3505CD7159@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <1626060316-2398-1-git-send-email-mikelley@microsoft.com>
 <1626060316-2398-2-git-send-email-mikelley@microsoft.com>
 <20210712182400.yze3wochnyccaflw@liuwe-devbox-debian-v2>
In-Reply-To: <20210712182400.yze3wochnyccaflw@liuwe-devbox-debian-v2>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=bf2ff2de-5f9b-4e3b-b0a2-9bec2ca6dd4f;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-07-12T18:34:55Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1f6293ce-7f21-4793-4b21-08d94564a4d5
x-ms-traffictypediagnostic: MWHPR21MB0701:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR21MB07018A05B1A2A6C436E876FED7159@MWHPR21MB0701.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:612;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BIvQH9MGW/jUMZPwMmLkbqRC+qNuauhPBewfHQ9WO8tgjpWKlZZMGhNpe1pk9Q3V7zp8Mzx7NybNSoTLU+7o5gu6drvUc38u3fmNR6+tHoaSSnV+4cnE18Ak+44x/Few+O3mrd3CVnJcJz5xKe1oDIYWAa6CiVDPTXl9SUFwE/R+gqSYbLYmg/al/WMf4czczea5248HS0AsN82+KpHU8mnE+RMHSEal5Am5bQY3E6E8SrQV3d7bxBM/EvwDPysQ24I1gqLHsfJxEGBlop0SZHVKNfZfvzN0m01q6d3FnLWqzePj6Fh5DKq5I1/O7gZAQnlnNpkDcEZbDdPB8gVcZNPfdYZcZs8QreSBGAoMe9iEBzoXxvyEUuAJMaCvGp4AldOnPJRPbsZk/xN0yF6tDnJ+/w2RInKUDCeKgMw4NuL293TIwRCq68o+y6f0+hzdmwnxjWne3Ybwf6yr8aeQU2MUtfXLq0K+W0tz3Ej11wNLkVKV3K5mMMMp/LGnuObLVvQ1kF8Gp8qYTWOcE26Ra0nmnpFxFdudhsoMeUcRkA8HXfDkDtpmUaWLjdVfAHJhqCesT5UhRQKmGHIDkxxbeOtY8sZ3A39fcytce5P5cWAIeMFD5qb2VTiMrsdhNsjKVMEpVRkjIJzyb4uES/eQFQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(9686003)(54906003)(2906002)(76116006)(66476007)(82960400001)(186003)(7416002)(66446008)(64756008)(66946007)(6916009)(66556008)(6506007)(82950400001)(86362001)(26005)(316002)(71200400001)(7696005)(55016002)(122000001)(10290500003)(33656002)(38100700002)(83380400001)(8936002)(4326008)(8990500004)(478600001)(8676002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bmj7NKc3z1BKbKm+0yzIVIdBiV4yRBMlDHLk1SKFeD4EytMpi4Vu3KchFMfO?=
 =?us-ascii?Q?wkAaZZBXBU1BJZ+MdUXCcDT80D/DIpE7HdYi2eh1RKWiXOoL0bPV7HlcTKug?=
 =?us-ascii?Q?W1xNNKNSbpdYxc0tAtQo47XqIPGhTuIfuu1BJRshjl0EnzpERUNaMg+F/ZtI?=
 =?us-ascii?Q?VCHhQ/3fftIAnI7WpEoGUkCWxIE5zXKrFPU7eJGjx6zi11sQjCN5skyL4r9x?=
 =?us-ascii?Q?ItiqvcM9M4LzQrpsTHU7x57C4nremkL5A8rmUcy9xSHPfnOtDzHa35AE7BKW?=
 =?us-ascii?Q?Rlt8pwpOFGexzooDpswBLtzYR5kphXxjNuEgT5/gf6kOI65kZNpdX6ipwPTr?=
 =?us-ascii?Q?OyRE4WSOW/ZMYhOTdpMgX7gn2z17S9u+OU4WF66ZrxGF59B5vP0abvkmdh7Y?=
 =?us-ascii?Q?aIHIcmFjXePZ0+O+/x9tb5hNmlLR6pQeVMJc10sSmwMtM9Bsc0A6/O5COycn?=
 =?us-ascii?Q?76A7AtHmygGgjWxIc3xerea8tla9dhwrNX2R5iyMnin2TksdsuQqMWFadP72?=
 =?us-ascii?Q?Bd/JzG4U3sPjrCf9MZDl6T1wjch/X5OxlMnpY6J0DdqDF+quXfXG32rPcpG0?=
 =?us-ascii?Q?X1lKMo6htZMPtW2K9/dvBL9kk4Xi11x9chcJvnkzx3K/c/ejvqrDDN8SWT1w?=
 =?us-ascii?Q?V9Pntm9c6to0s2Kk4mTTaQU81ByjDbUrtYv68GrV6l1OsC1GMVQOqd5L1kXa?=
 =?us-ascii?Q?zZuPIBGl8n7nna+TCadhbFLiH+5vrLhcjNJayxoQzBs/E+HvCHPib8MDnVoK?=
 =?us-ascii?Q?pcJTqXeL5mbGP06RAEJj3vTCki9oJnsTw5uUs16jfKsWGYzLdtjUCMzJ7kbP?=
 =?us-ascii?Q?HPXzPtuL2ck9qjBfGBbuB6NnVbjtVrCWcC6xdQmTO5E/dJuHaSyBivJgm4zy?=
 =?us-ascii?Q?PoBnCBSKVZfiKlqKgaqU/pD9zczzFzqshupkKchUUGVfaPJwq5GpsSTYwtN/?=
 =?us-ascii?Q?DD1dto4+IKD7xa6H7Lt4AkSktFxFdgKZ4YlkrhvWAQ9Cg1PtQYqxspyqWW8M?=
 =?us-ascii?Q?jnsgU8cpMYHn+uyk1ovBYMeuIyILV+nT9mdMzsXjtSR9cqdq8XeGHzx0d1B5?=
 =?us-ascii?Q?68NEQqVRwFSXpq6A/M0Lpi1rS4LpBrIcSn3tY9CdqP4C7oisrPzWcVq16WaJ?=
 =?us-ascii?Q?Rpsn9iiP18lfG3pJ6hXpa6bjHU2h8ff6OeZJI6Pr8DRKiJIjX2C1ifGV4nL1?=
 =?us-ascii?Q?5btKeuMZ7IGE+JsiJF2+mmVPbU8+52YctEKptil0Aj1UdkwIEEGcCABPalGm?=
 =?us-ascii?Q?8X+rT9LqTOlIaROIEMVaQEkuKHqFpgH7Dr0CUgfFeVz7eQfkMTXt91Pb+dRD?=
 =?us-ascii?Q?74eFNwM+ggtG2yy1IiuxjnNL?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f6293ce-7f21-4793-4b21-08d94564a4d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2021 18:41:21.2134
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C1olOb1kw89wY8A/HHzv/81D5CYvuaZ3GbOHUzYWa1fr7ComSJtV/So+6lk0pdHrvT2/8ViHpSq09NQof60BMczWXJ1LsV9SkXip5EhOkXI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0701
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Wei Liu <wei.liu@kernel.org> Sent: Monday, July 12, 2021 11:24 AM
>=20
> On Sun, Jul 11, 2021 at 08:25:14PM -0700, Michael Kelley wrote:
> [...]
> > +int hv_common_cpu_init(unsigned int cpu)
> > +{
> > +	void **inputarg, **outputarg;
> > +	u64 msr_vp_index;
> > +	gfp_t flags;
> > +	int pgcount =3D hv_root_partition ? 2 : 1;
> > +
> > +	/* hv_cpu_init() can be called with IRQs disabled from hv_resume() */
> > +	flags =3D irqs_disabled() ? GFP_ATOMIC : GFP_KERNEL;
> > +
> > +	inputarg =3D (void **)this_cpu_ptr(hyperv_pcpu_input_arg);
> > +	*inputarg =3D kmalloc(pgcount * HV_HYP_PAGE_SIZE, flags);
>=20
> This is changed from alloc_pages to kmalloc. Does it ensure the
> alignment is still correct?
>=20
> Wei.

It does.  The alignment guarantee made by kmalloc() was changed a
couple of years ago.  See commit 59bb47985c1d.  Here's the current text
from the comments preceding kmalloc():

* The allocated object address is aligned to at least ARCH_KMALLOC_MINALIGN
 * bytes. For @size of power of two bytes, the alignment is also guaranteed
 * to be at least to the size.

Michael

