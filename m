Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E41E66DB57E
	for <lists+linux-arch@lfdr.de>; Fri,  7 Apr 2023 22:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbjDGU4g (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 7 Apr 2023 16:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjDGU4f (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 7 Apr 2023 16:56:35 -0400
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-cusazon11020017.outbound.protection.outlook.com [52.101.61.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B22917ABA;
        Fri,  7 Apr 2023 13:56:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mzSXUdWcutYQQv40wvGpe3lxKNlx+xXEWIUEq70rkptx4rXboU9mzoqC78PrZ3E3xnNvh2DKqqfNFbzO3bD0hVAxSAGHZfXs4widMLj+zd9CP2+3vo2g7i+PebFFN0LsFvuQWeDdFkpX+IUuhB+VMlW5DUqJHc93Mwl3pbVh7fZIuVQTcUpetSvslqab6MvZ4OSxYqE9GfI/EYKv1qMxpGuBAK1/HlGG7905lyTfcNb9tWioEsGbPf5MdDYAJOWdP4FbE+0ElL8BNSPnz9EVRMAUyAS/kAi4Iy+e9eiNEB94eBaEvLdnI8lE0v0UOKhIJf5PnWtaDOF6KaIY9IPIkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/nKn6z4qDhxYKm5r2PIC+wUGyN7CqyyfbBinmtZvxN8=;
 b=GVnwLp27XNkats1kky5A3k57ZVwYwOWjpTe5Q2QbWfcFmawzo4FUlyFoMJ8JmS5SQuwkHjS1Kkyx2dYmQUoWIx/quAv48i1J2+6JkqmcdZRk6W722WOjF7eNyhUMCTNqIUwN4BK0l+lgEEoUKH0jcW7p5v4M/0wkr1g/HcichpKZ+YgUCCR+FdixanGSkqXvzY65KZjT3umMd20dI295OMMnBWnk2XbFTABjrKxcU/cCapZ5Ekk6jHh090F6ohO0q/+CHV6eTVvHO8s50Uk+od2qeWUCZ7gho8rdAB/4azoI59a713SGH+rF1q31iD9C7hYq7s5i40ZL5VwvzGcB3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/nKn6z4qDhxYKm5r2PIC+wUGyN7CqyyfbBinmtZvxN8=;
 b=BYZ6aw/QEYru1Yb7JhaRwZpz7UohJNLiuMHelBVjDaZCCZ0LfXS1wL4S+BP8x64bwA8cFrQwteHorlNlHffGiObZk6LGM5EWQ0hZLg38oGuRoppLHkU2IEvSUhduQnLQmUQ/+obHMP+eS4eC7d5x+b5ji+bCgcvNxR8DPx28byE=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by BY5PR21MB1507.namprd21.prod.outlook.com (2603:10b6:a03:231::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.20; Fri, 7 Apr
 2023 20:56:30 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::acd0:6aec:7be2:719c]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::acd0:6aec:7be2:719c%7]) with mapi id 15.20.6298.018; Fri, 7 Apr 2023
 20:56:30 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
        Saurabh Sengar <ssengar@linux.microsoft.com>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "jgross@suse.com" <jgross@suse.com>,
        "mat.jonczyk@o2.pl" <mat.jonczyk@o2.pl>
Subject: RE: [PATCH v4 5/5] x86/hyperv: VTL support for Hyper-V
Thread-Topic: [PATCH v4 5/5] x86/hyperv: VTL support for Hyper-V
Thread-Index: AQHZZtQDm7r7516jUUWroUo0jRWt9K8eVKeAgAIBzDA=
Date:   Fri, 7 Apr 2023 20:56:29 +0000
Message-ID: <BYAPR21MB1688E43D583B016AA3DAD906D7969@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <1680598864-16981-1-git-send-email-ssengar@linux.microsoft.com>
 <1680598864-16981-6-git-send-email-ssengar@linux.microsoft.com>
 <20230406140743.GA1443@skinsburskii.localdomain>
In-Reply-To: <20230406140743.GA1443@skinsburskii.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=5a44cace-9304-4bc1-bb69-41cd463c906b;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-04-07T20:46:39Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|BY5PR21MB1507:EE_
x-ms-office365-filtering-correlation-id: 4cdd923b-c369-4228-487d-08db37aa8fd7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T2ii7xLwtp0vvoUuYvLzTfz92LuyqIXpzJoxwAOu0Fzp/7tNJSLKmUfWpdcR14hOh2mP42yY9CJC8pkwhPGADQR1NAEMTbBVXxAVhjWLe0gAhVM8r2dNJkcFCmge+SfHcPgCKzXf63NTIFytZKoCe8ydhFDzgEu0kfSXzewXRb6wuMG41DXm21EBvk+zun3kjjgCKj8bJw1rru72r4OjYYs3dxLSizv6hhPqke3oBMxpvjO2uNoyodK+gGgcM+g/UKCWnNYBUsgfhXWHMMBi+WjGnnoMhgfI8YDU44ViqWZd1XBTTX42D3WkdAasMMnoBm0Ql78DBPOAPdCmad1q2rJb1L/l0DsRfrhrfxKdOPUgcbZ3lmnByXzsQ3oTldgbX7xBrTlr1cMrOWtrXGyrDC9IGmDWMEUcHk7nZIjLMHtI8loDHvbWlotKu1HVfmKHkJ/XQHT3K11LMCkNnyiJoW7FUscT6rbLwS4nwe+5U34+pna3FDWivmKy+OLSxRNj2P1ThT4I4cG/CyK8fsbwn1svcEU8fGzd+RuMKG1LLvdmKs+puuz3n1C/tThJ4ZulumRkILb0V66q/Lf2iSU4CUUo5OtR9FZLy7zWEIoqxFPkFmpMrGIE11+H/i6+C8qRI+Lw6tbG8gLBbHb4qFh/FQ+4Icpyr/9r2Gb8c3CKm/I=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:cs;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(396003)(136003)(366004)(451199021)(8936002)(41300700001)(71200400001)(7696005)(55016003)(52536014)(8990500004)(38070700005)(83380400001)(316002)(110136005)(38100700002)(786003)(54906003)(122000001)(82960400001)(82950400001)(5660300002)(186003)(4326008)(7416002)(8676002)(33656002)(66476007)(10290500003)(478600001)(86362001)(66946007)(66556008)(64756008)(76116006)(9686003)(6506007)(2906002)(66446008)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5Okya/Wr9BZxuPRVpZiMWp2qmoq7xp7lHhm4RDHvnzIG6VSn4+XY/6u4s30R?=
 =?us-ascii?Q?8p3TggT/1E7VF9axHgWx/AQKMsQgtPiN0YOTTq+lhOdssKNbbK+NvlV2fIQi?=
 =?us-ascii?Q?nBao60HhY1eSFT5LavfDYXP+36wexkpPWZRv1sOH1DkTddcVLhLJWYwOmycp?=
 =?us-ascii?Q?rO9BQkOqxhjjC/af8O6WLDH4pAD+T1CSabPrwfm7pZt0elrJJG+D4PbQt3QU?=
 =?us-ascii?Q?0Gb+coP8kAylYsFPKFuvbOsPXxyZ0gyaWDHBIyAF1juWmGksdp2g3MD8/DXZ?=
 =?us-ascii?Q?hGh2khIAyloVdXPaIpqX3RyjnBbKZxPp6DmzbWUzjRCn5/A5heVxHa1QHT3O?=
 =?us-ascii?Q?8Wdd2bBbKBligFe96/DXkKd3g3GSVeLSHINKVkOcr+XhfmCOdBJhL1iIUsx1?=
 =?us-ascii?Q?r0C0A6HOfP1VLTjKb72uHOpfDeRqMQ067n2D95UZGhgpTlLCbL77osgx5bAR?=
 =?us-ascii?Q?EK071ihRpIagwixpuWwzoqrf/v702ngxcicSaBu+H28pK6Y8QHeJY9kuErXN?=
 =?us-ascii?Q?t9KKBZtcn/EeMXBmP3dxawjTi0wA5jFPf8X9raZaQHm8Vk2cHYw88DZUrcHC?=
 =?us-ascii?Q?DDG8f7/CU2pvT4Fa0qf7Ad8RW/GPZaYd6rRNdCgCkh+qMiAOA/g++jWgJLNE?=
 =?us-ascii?Q?3hOGcODW4P1KUQCjv0crvFG3ZDDRhqzzMtC7eJso4g91C/J6U8rztCMGWp2N?=
 =?us-ascii?Q?bsmf4IGphENs5ZAfGO/5En8mAha1kwNfEvjo/oNem/yPSzajq84F9IV2DUt7?=
 =?us-ascii?Q?uhXEGKMkTu9ZNLzEGrQSa97hdxiUOB6MFAfGurht6ofUFcSC7vDQciB5QzAv?=
 =?us-ascii?Q?/cAMSFcLW7gZbCjbHyZMNfkAgmfNwx4doi3LAq/Jfq0m2iav4R4jO/jrNpwy?=
 =?us-ascii?Q?HABZTyykYzu60o+d21+tto/72uEKrp9mBghWNZAZzDZcffUt50RqlIf6czfA?=
 =?us-ascii?Q?946yfeJLoHLmMWg72c1zu0E6Bhu2DbLG91231CskdcNxTaIwGpnoYpCBUyIq?=
 =?us-ascii?Q?cKKjplxhIo1+M2fhcLHosA9yl7QA8t49Sz9VK2FybJfCX8IQLA3yi6yt0vzV?=
 =?us-ascii?Q?0fXt4BIPANs9TO5581LZlTzFgttR+azk/YoDKNBpEcjXGViAKYNqmyQn+o41?=
 =?us-ascii?Q?i2nKRk3d063bsJ26syyapZM6j+EONGpeyO2N6ZX9e66MPVyNVhjoTXFGe5ag?=
 =?us-ascii?Q?1gmP5Jzg7DxE2fxyfMVBgnbeF+sRDTajmljZWgA6reJ7r/UuYEmc8c/pqg1K?=
 =?us-ascii?Q?1KClmTBVtU4Gah0xJxu5tyuWiNt3D6pe36mCnlFbqOFhf+N9cYT964lN6X4I?=
 =?us-ascii?Q?78GKnyzR0SLJAGbaADmNsmlUWTtDLSU+QUNEGLmjMchHjn+8QVKk7GyptlFx?=
 =?us-ascii?Q?+z5VZTxDnHNKxcwdwS5kZO7GWsWoOH+u0bOh0h0U/53HZ3y3Rinez95pil9g?=
 =?us-ascii?Q?wappYlrNpYPUIyfIXroCzeqZZ8qMVgXEKg2sa2DcwjyYTZAPKABhDkNHv5tD?=
 =?us-ascii?Q?LMV4yIZzZGaiX7vu1uHovDNkjReyX5kwpqpDwdygU7sMorYt7npGXFXeZyYc?=
 =?us-ascii?Q?KMtf74yq2e+ax+ZKgIDw8ZeCiaAEihPaAS5ghjfna2iIoq+oLaM4+Di7w5bs?=
 =?us-ascii?Q?6w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cdd923b-c369-4228-487d-08db37aa8fd7
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2023 20:56:30.0169
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6QTlCmExll7sb/Mu860yZHXqWnW8rFqX00cHZ13opMIcEEsbPOB7MAOwB2Vq77rPb6d2QquQ5vxajp4J/2bMTRowhmEmotNrTWYe8oC+GGw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR21MB1507
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent: Thursd=
ay, April 6, 2023 7:08 AM
>=20
> On Tue, Apr 04, 2023 at 02:01:04AM -0700, Saurabh Sengar wrote:

[snip]

> > --- /dev/null
> > +++ b/arch/x86/hyperv/hv_vtl.c
> > @@ -0,0 +1,227 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (c) 2023, Microsoft Corporation.
> > + *
> > + * Author:
> > + *   Saurabh Sengar <ssengar@microsoft.com>
> > + */
> > +
> > +#include <asm/apic.h>
> > +#include <asm/boot.h>
> > +#include <asm/desc.h>
> > +#include <asm/i8259.h>
> > +#include <asm/mshyperv.h>
> > +#include <asm/realmode.h>
> > +
> > +extern struct boot_params boot_params;
> > +static struct real_mode_header hv_vtl_real_mode_header;
> > +
> > +void __init hv_vtl_init_platform(void)
> > +{
> > +	pr_info("Linux runs in Hyper-V Virtual Trust Level\n");
> > +
> > +	x86_init.irqs.pre_vector_init =3D x86_init_noop;
> > +	x86_init.timers.timer_init =3D x86_init_noop;
> > +
> > +	x86_platform.get_wallclock =3D get_rtc_noop;
> > +	x86_platform.set_wallclock =3D set_rtc_noop;
>=20
> Nit: this code is VTL feature and hypevisor specific.
> Defining vtl_get_rtc_noop instead of exporting get_rtc_noop would allow t=
o make
> this series less intrusive to the rest of x86 generic code.
>=20
> Reviewed-by: Stanislav Kinsburskii <stanislav.kinsburskii@gmail.com>
>=20

Saurabh's initial version of the code did define its own version of
get/set_rtc_noop().  I had suggested that he use the existing functions
from x86 generic code, and KY had also commented about re-using
existing code wherever possible.  :-)   My suggestion was partly because
the VTL code is already re-using x86_init_noop(), and then just to avoid
code duplication.  Admittedly, there's not much code being duplicated
in these stub functions.  I slightly prefer re-using the existing functions=
,
but don't feel strongly about it.

Michael
