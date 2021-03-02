Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEFF632B4A0
	for <lists+linux-arch@lfdr.de>; Wed,  3 Mar 2021 06:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232746AbhCCFW4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 Mar 2021 00:22:56 -0500
Received: from mail-mw2nam12on2139.outbound.protection.outlook.com ([40.107.244.139]:27680
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238298AbhCBBmO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 1 Mar 2021 20:42:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U2NqP5NfegrT2tWzbjsy4YmZTEYpoIaOmOiJrdOouHF8X9BsBxuVwxVUbyKb8nXoMGJMwWMu7/Xj5TjBEBQjVHKFyqAwLXQW6zviZSnzvQNFi72hVGST8Jp13tIsA4av0xtYS5HGol+55sVsC1vekr/1PDL6USTdnP89SaSCSMt9Og7+ZZtcHUVCRbrrpfgO+gJEaDzXXN7uP4Z10VMRgc5imkIHs+Dzqr3g9i5lHm10ELBmSvtncRVQ1ibkdv3Nx44bAF34xf7SmsmSHlkea/ikg8lcCBzUeqWzocevnO7rj9t/XtjoidCokCSVVFjljay99M3wOPRgbRGlNDGGDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KqNS2x7olHvXWP1Jr1ZcMN8sklvzokYmn/Is2mOX4nM=;
 b=OX9NM7uuwMnKtx8NCSUSrpSG3MqnSQidT5VSS1rrahdGlyeppXASro/9RxXHKWPOl/AJLC2etYpbjm4f1BcYoH9b21RwKZdy1feluQpLzTSmOpgMYDvpjVwjCffFjXsEmh3fMUwYlYElBEgebf3IoLCVxEEV2aZ5+XN/MLPUCfuhIxRQguGzE9C66Io+haYWo/8obxs4J7ra0skSSS8g1ZzvcyrgDH09LAa+bpGnbm/r62NgO4rx8Jw/L/NKPuFkO0r3+T2FuRvwEEQ/xjJBYrcINvHSoOhafFyAwwippZAxzbJQlH9SK08upTVa5sVeDIQp9H/YQM0YdOFcsXtiHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KqNS2x7olHvXWP1Jr1ZcMN8sklvzokYmn/Is2mOX4nM=;
 b=WWZMvC0KiKxgIvP9Fw8TNjDrLTK9MwAogzo24zshePOYA0/yr0TXxJEQJL+804EH2TPVpNTrExfvMNfkTyHBgEsbil/Da6WvbxX7ROM+bnUxmUeaqhh5kvPnY1gZM4E7CPgNIwBIWy64cxGdUk0S9hsVjGA4W4Ogs8w3kBQHKtA=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MWHPR21MB1579.namprd21.prod.outlook.com (2603:10b6:301:81::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.2; Tue, 2 Mar
 2021 01:40:37 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2%9]) with mapi id 15.20.3912.016; Tue, 2 Mar 2021
 01:40:37 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: RE: [PATCH v2 10/10] clocksource/drivers/hyper-v: Move handling of
 STIMER0 interrupts
Thread-Topic: [PATCH v2 10/10] clocksource/drivers/hyper-v: Move handling of
 STIMER0 interrupts
Thread-Index: AQHXDjh3b7sfn0hZqU2r+eHOEjUhQKpveW4AgABzygA=
Date:   Tue, 2 Mar 2021 01:40:37 +0000
Message-ID: <MWHPR21MB1593624A8C63F3FF7240B44BD7999@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <1614561332-2523-1-git-send-email-mikelley@microsoft.com>
 <1614561332-2523-11-git-send-email-mikelley@microsoft.com>
 <cb190ed5-66f3-bdf7-aa97-b1fe0c49e282@linaro.org>
In-Reply-To: <cb190ed5-66f3-bdf7-aa97-b1fe0c49e282@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-03-02T01:40:36Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=a58234c0-cab0-43df-a0f8-f798f4825b51;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 79c67d5b-ea1d-4c83-33a0-08d8dd1c2e59
x-ms-traffictypediagnostic: MWHPR21MB1579:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR21MB157916DBDF96E733C92251A4D7999@MWHPR21MB1579.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m58oiJdxXfXiMOqLqGJNaozQFufcSbPyc3wA5N/7E+jK8NEvZSS+WLP5FlfBtc5UA2ZUVKKxt9sxk16qP+pfzAtQsGJSq+0j8q+XDJGes4szX1qrSn6fkDfHekrQpC+MmaYh/ZS9NvRFhunD9qxLcGCOkv58x9AElWtYqUkGo61b9vetXAdSoe2NUrvU94leKWBAhgv2fIvHgGS6KmRNkOwnDJBtYLw1eEppsh6ztdBpunioZo50B+tS/3hbPN4kKybF3LuQnmMX7emH1gz8VojWWKPqn3Bed5YFugP01Anwvtjei5xpF0orBBXYTQmbZhNhk61ZB/MfNugqXG+c5N7Xyhq1LnfEuiemoHR5ErRA8/7DHicAHYM29RJBK0laDESxPTiCbNmv0GYDUGooqGvroYgLGm5TqBEpe7CPhXC5rBPM1EL9YXq/ikQs+fwCOSVq9TGZmmZhFIEOJ0r7flnL959K7GX4WowFHjCI2e9dDIQDy1vMmCmh5CKtyC+0P1dOOYgudgL6G7qrC8DJbTv/ElFML7cg27T/YoT/ambZJIJocu2Q3Yxd57ag8iZo
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(366004)(346002)(39860400002)(376002)(82960400001)(7416002)(64756008)(316002)(83380400001)(478600001)(66446008)(52536014)(8936002)(6506007)(26005)(5660300002)(33656002)(76116006)(71200400001)(921005)(66476007)(66556008)(2906002)(7696005)(8676002)(54906003)(9686003)(110136005)(53546011)(8990500004)(55016002)(10290500003)(66946007)(86362001)(82950400001)(4326008)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?AxtIyHULGZM3QnepBTTSy3IOOlqTUDZquggRTeq9RMzER0xch12JBl5qlKu2?=
 =?us-ascii?Q?BilQcIIOwCa3sun4BdFfYZmkxQ0qcKh/5/gett/kcyqhSZO9xqys5rWmlQaa?=
 =?us-ascii?Q?eAclpM6DMlkmx4PYTWQxswwd+xxaBoVrhM2UCsdRMql/h/pYlKZw0MVmTRay?=
 =?us-ascii?Q?chplBZPtmbtv/Pu2MYP4ghIxQhnebNAyxSkIcO3zWDlaaYmv8GQzgdfy4pAO?=
 =?us-ascii?Q?2bwvcEtD60L6PhMVz+bsmi0ArmxxwxLGY9bELjPscQGQMDsleqOPO9hkezFY?=
 =?us-ascii?Q?uu3Wy2hhlAyrwCDIsJ1fXm7PVdBzLU6FxtyMBkBHxy796sxkNJ5GDjw+ynS/?=
 =?us-ascii?Q?96YX9SIuV/TOqoy4aU6ZKrQJXZqcsn+R01I0Wiq/1Eu/PoY1PV8cAP4shlJz?=
 =?us-ascii?Q?HJPggmf47aOeEh6JTuQsr12N4Ha+BmB4nqEezMh3iSOoVFNxbegwIO9e1AVS?=
 =?us-ascii?Q?mlxEHq/qX56n35+i1qoFE5M3cmvzsPW8oXx83F8TKFqU1g35x8XWy0wGkbSS?=
 =?us-ascii?Q?vWGten0ncHKhlLU9+gAxFtvzzUZ1kARDOZ3NL4myPbN9RSJRRZvM+Z46hJgY?=
 =?us-ascii?Q?osCL66RhLyD3/SFAvJL/5wxsv849VQW1q1ySj8e+whGpKFYoHfY4HCvGlPJ+?=
 =?us-ascii?Q?DNDXSZDye+OqamvU25+9ZiWtMPvijG0R+Wt1YxsIf4mI5w5E9eJBwOGT7Z2i?=
 =?us-ascii?Q?CTnH15KLt+4kfeZBbVVbU3dkjoZZye+uArQOC3imviE8PWU4sKDZnc9CTSLJ?=
 =?us-ascii?Q?pNMv8ezuLsyNKUPPUGAJat6SBDK1Cg9N3obbX0eaQq40s/PU8nwemsR3Xl9o?=
 =?us-ascii?Q?3+QcKAVUXEVueCDcg5E+WLBslBS6mHeOccWymrw51izLlNwXF8HS3OVERc1P?=
 =?us-ascii?Q?lN7bud+mJj+lqyr3sH8CA5HDAJSlHD2MstXyJzVlecMUw5F6JRq69dtqOQbd?=
 =?us-ascii?Q?0ALOP0gmGVpGfQMSZNwhD7tEVcaNDKV6L5CCRUfqZkVx2vdT1ShiqK6Y58dv?=
 =?us-ascii?Q?dGqdiH7YkXZNf1MK820rkagBL9WRvlO6jdRu1+8Y2GdRZE7P+hr3r4/ebwhA?=
 =?us-ascii?Q?oJbmsyTlT/+WDWN0HvBC7ABgjK87sRAO1SIZQQe1Oov2krpQI8BLFzNsA/yr?=
 =?us-ascii?Q?gd74PCOzlO2lbRsZ4Q9Bp1LwydvdEpCn09Skp+2pT82gBnjpcIxOA5q2Hf0P?=
 =?us-ascii?Q?GkggiqOa5Ck4qxfSOdeByP/SnHLxhFqMS++PFPGcgmeR2dBUcDoi+TjFWX86?=
 =?us-ascii?Q?/Cy46F8D3R195EtHq0f74jRm1s+omJAgfCz8kP5k5hO3HcrRu7eHD5OOJmIV?=
 =?us-ascii?Q?Igs5yubKFDpkYYz5U/2y4XJn?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79c67d5b-ea1d-4c83-33a0-08d8dd1c2e59
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2021 01:40:37.7676
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /Ia246mVJTCqwiE+8rsPAxn0K85LyQxMryKa/GZZ7+AJ9SRlia5nve9LYwGhpQ85oasdR/6X0rg+xkvXF1FdIk39/jwR96B7IJVIee4jazg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB1579
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Daniel Lezcano <daniel.lezcano@linaro.org> Sent: Monday, March 1, 202=
1 10:45 AM
>=20
> On 01/03/2021 02:15, Michael Kelley wrote:
> > STIMER0 interrupts are most naturally modeled as per-cpu IRQs. But
> > because x86/x64 doesn't have per-cpu IRQs, the core STIMER0 interrupt
> > handling machinery is done in code under arch/x86 and Linux IRQs are
> > not used. Adding support for ARM64 means adding equivalent code
> > using per-cpu IRQs under arch/arm64.
> >
> > A better model is to treat per-cpu IRQs as the normal path (which it is
> > for modern architectures), and the x86/x64 path as the exception. Do th=
is
> > by incorporating standard Linux per-cpu IRQ allocation into the main
> > SITMER0 driver code, and bypass it in the x86/x64 exception case. For
> > x86/x64, special case code is retained under arch/x86, but no STIMER0
> > interrupt handling code is needed under arch/arm64.
> >
> > No functional change.
> >
> > Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> > ---
> >  arch/x86/hyperv/hv_init.c          |   2 +-
> >  arch/x86/include/asm/mshyperv.h    |   4 -
> >  arch/x86/kernel/cpu/mshyperv.c     |  10 +--
> >  drivers/clocksource/hyperv_timer.c | 180 ++++++++++++++++++++++++++---=
--------
> >  include/asm-generic/mshyperv.h     |   5 --
> >  include/clocksource/hyperv_timer.h |   3 +-
> >  6 files changed, 132 insertions(+), 72 deletions(-)
> >
> > diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> > index 9af4f8a..9d10025 100644
> > --- a/arch/x86/hyperv/hv_init.c
> > +++ b/arch/x86/hyperv/hv_init.c
> > @@ -327,7 +327,7 @@ static void __init hv_stimer_setup_percpu_clockev(v=
oid)
> >  	 * Ignore any errors in setting up stimer clockevents
> >  	 * as we can run with the LAPIC timer as a fallback.
> >  	 */
> > -	(void)hv_stimer_alloc();
> > +	(void)hv_stimer_alloc(false);
> >
> >  	/*
> >  	 * Still register the LAPIC timer, because the direct-mode STIMER is
> > diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/msh=
yperv.h
> > index 5433312..6d4891b 100644
> > --- a/arch/x86/include/asm/mshyperv.h
> > +++ b/arch/x86/include/asm/mshyperv.h
> > @@ -31,10 +31,6 @@ static inline u64 hv_get_register(unsigned int reg)
> >
> >  void hyperv_vector_handler(struct pt_regs *regs);
> >
> > -static inline void hv_enable_stimer0_percpu_irq(int irq) {}
> > -static inline void hv_disable_stimer0_percpu_irq(int irq) {}
> > -
> > -
> >  #if IS_ENABLED(CONFIG_HYPERV)
> >  extern int hyperv_init_cpuhp;
> >
> > diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyp=
erv.c
> > index 41fd84a..cebed53 100644
> > --- a/arch/x86/kernel/cpu/mshyperv.c
> > +++ b/arch/x86/kernel/cpu/mshyperv.c
> > @@ -90,21 +90,17 @@ void hv_remove_vmbus_handler(void)
> >  	set_irq_regs(old_regs);
> >  }
> >
> > -int hv_setup_stimer0_irq(int *irq, int *vector, void (*handler)(void))
> > +/* For x86/x64, override weak placeholders in hyperv_timer.c */
> > +void hv_setup_stimer0_handler(void (*handler)(void))
> >  {
> > -	*vector =3D HYPERV_STIMER0_VECTOR;
> > -	*irq =3D -1;   /* Unused on x86/x64 */
> >  	hv_stimer0_handler =3D handler;
> > -	return 0;
> >  }
> > -EXPORT_SYMBOL_GPL(hv_setup_stimer0_irq);
> >
> > -void hv_remove_stimer0_irq(int irq)
> > +void hv_remove_stimer0_handler(void)
> >  {
> >  	/* We have no way to deallocate the interrupt gate */
> >  	hv_stimer0_handler =3D NULL;
> >  }
> > -EXPORT_SYMBOL_GPL(hv_remove_stimer0_irq);
> >
> >  void hv_setup_kexec_handler(void (*handler)(void))
> >  {
> > diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/h=
yperv_timer.c
> > index cdb8e0c..b2bf5e5 100644
> > --- a/drivers/clocksource/hyperv_timer.c
> > +++ b/drivers/clocksource/hyperv_timer.c
> > @@ -18,6 +18,9 @@
> >  #include <linux/sched_clock.h>
> >  #include <linux/mm.h>
> >  #include <linux/cpuhotplug.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/irq.h>
> > +#include <linux/acpi.h>
> >  #include <clocksource/hyperv_timer.h>
> >  #include <asm/hyperv-tlfs.h>
> >  #include <asm/mshyperv.h>
> > @@ -43,14 +46,13 @@
> >   */
> >  static bool direct_mode_enabled;
> >
> > -static int stimer0_irq;
> > -static int stimer0_vector;
> > +static int stimer0_irq =3D -1;
> > +static long __percpu *stimer0_evt;
>=20
> Why not
>=20
> static DEFINE_PER_CPU(long, stimer0_evt);
>=20
> no need of allocation /free ?
>=20

Indeed!  I'll make that simplification in v3 of the patch set.

Michael
