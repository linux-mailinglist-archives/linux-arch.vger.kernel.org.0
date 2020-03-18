Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB9BE1892A9
	for <lists+linux-arch@lfdr.de>; Wed, 18 Mar 2020 01:17:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbgCRARV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 17 Mar 2020 20:17:21 -0400
Received: from mail-eopbgr770122.outbound.protection.outlook.com ([40.107.77.122]:38723
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727312AbgCRARU (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 17 Mar 2020 20:17:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JQYSkBRs/y7WG7IgGqZOf/jTz1FKKWXvOsiU3usfvK+BOa2qJhlGgP23PFgj42DkTafZoiFNhzad2E+8Bq+pAVopgseULTjI7eBfkRMtwUVJGSq2nXU5hTgW/eoY6bBntcLpAytYyjOe38rbv0/u4ojOoUqjVuWagqhpHK4YcDugH4If2/TNIA5ghsb6+Vpv+cy9/x+jdgCPe+vaYlAhdphRJjB6KP3jBE8nSt6ZH3dnBjSaQ1fxruJMyqwjf7RPny3mQ2qrZPhcjKdhmYcFYXsYTXboTNLcqomvl4upkKNS8T9uVvI9Is/LJAaVpmog/gY8o4ezIRmFU6SQG1Xoyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/4BE2Y3jmGOlGrOr8p+fMDPMUkxaMal7Urz/ca6sNyQ=;
 b=aBtCqAHMZ11rqYKzPgzr9pRdyXWP14JK7/0wW/ioC6diXmtNtXehMrVkE+kQHk88kZQaN5WpJHhyt+JauPPRndahEq1mfvVUyn7gKoHAlYDq/AnntwWwn83Eqs5c0WGx+uVfO98+TmGUHEGWSUdsvH9zt18AnrmL8hyQ+NqChOjvquli6F62ngtJNUBG9Tr/S4VCHdVGFpUM0pA+HMONomQe8E9aIFYYmN97Xof6VNJdzwNWdx7ysWTXuZdqPMAF/BrC1/xLfOlLuVEvaRqQyf3WSnO/awD8UUEf9g8Zngg0I+48+6Jx7O4HXJbvX75NCr6/7J9nmepzQG2IQot9wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/4BE2Y3jmGOlGrOr8p+fMDPMUkxaMal7Urz/ca6sNyQ=;
 b=Bl0A/AzMk0lM4Q6qwRwe0TeN598u/LW/9NV1W9CxnZR7O+pKAdyUAuHiNt9DNd5c3g+ME3dvZTG4UpZ40GUVi0037gOZW1UhYR4s5HK4vpd6SRwt/bR/pCAfE0nOdhC4NPurnhDaa8L2SUxkWuG+APn7OVk/A2io/xEfa5hqzEc=
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com (2603:10b6:302:a::16)
 by MW2PR2101MB1082.namprd21.prod.outlook.com (2603:10b6:302:a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.7; Wed, 18 Mar
 2020 00:17:16 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::71ee:121:71bd:6156]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::71ee:121:71bd:6156%9]) with mapi id 15.20.2835.003; Wed, 18 Mar 2020
 00:17:16 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Marc Zyngier <maz@kernel.org>
CC:     "will@kernel.org" <will@kernel.org>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        vkuznets <vkuznets@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        KY Srinivasan <kys@microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        "boqun.feng@gmail.com" <boqun.feng@gmail.com>
Subject: RE: [PATCH v6 06/10] arm64: hyperv: Add kexec and panic handlers
Thread-Topic: [PATCH v6 06/10] arm64: hyperv: Add kexec and panic handlers
Thread-Index: AQHV+hZJl+uBzJDgl0y0o8ulo9cTn6hJ908AgAN0drA=
Date:   Wed, 18 Mar 2020 00:17:16 +0000
Message-ID: <MW2PR2101MB1052178631BA0F54B3940D90D7F70@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <1584200119-18594-1-git-send-email-mikelley@microsoft.com>
        <1584200119-18594-7-git-send-email-mikelley@microsoft.com>
 <86tv2pzdpr.wl-maz@kernel.org>
In-Reply-To: <86tv2pzdpr.wl-maz@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-03-18T00:17:14.3914622Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=06d771c6-fa45-43a5-a66c-28d22cd31720;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 52277958-efeb-485b-8db4-08d7cad1b726
x-ms-traffictypediagnostic: MW2PR2101MB1082:|MW2PR2101MB1082:|MW2PR2101MB1082:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW2PR2101MB108239E533F6170E17ACFCCDD7F70@MW2PR2101MB1082.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 03468CBA43
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(199004)(10290500003)(55016002)(498600001)(7696005)(5660300002)(9686003)(54906003)(2906002)(7416002)(8990500004)(33656002)(52536014)(6506007)(6916009)(76116006)(71200400001)(186003)(66946007)(66476007)(66446008)(64756008)(66556008)(4326008)(8676002)(86362001)(81156014)(8936002)(81166006)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1082;H:MW2PR2101MB1052.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6n84OLM6A5Iwmsbs3TjZP+KBHOqiyEnw9nqxfCwiFuB7RjTp58vYtzY25yNd7xlyQnr63FN8UwNFTf3iwHWhJ6S3OgshVCu/DYCA/rJiOD6Or8ZV4m5GSfhSTC69B0OFyseU0rHABi7PLQX8B1WJW9/Hu/YaYCyoGDvfp3uuEypj4mQIwIj/TmqNVx9dY5bn1uzFK5avOcgmv07FrQwf3FxutjLxI/MV9oDLEOgLhMjPNUszYUjckSgL9Yjd9pmEoLeawyRRQwi4MN8828qjA8jrE6jzq7dhZ0bvD9ygg2P2BpT0v+QJ36Y9TFh7XNoP8elP6q0GtsxgwHz7UWrrt5LlTRvXU+2gQ/CF3WSCNrKXHIUW045P7bAqX+qABCq9ykJ/206yr6TlyQ+xpqoU0mW9b1pCKnkyVHfMaH7HYNVvBNE68cKiXdFT+u5BjR5x
x-ms-exchange-antispam-messagedata: aiWh54zu7vNKJv1MDmqHfppDTRIWMbApnZ9Ewim8f6SdPn8jJzhlrQdsZezmMLdNS5EkISEmu8wJ2O2w2ohffTmfIeQFZwvv4/Kn5PC2TRz6h4XV9v8ZOmvQZ5ibpszanA1VA/wZMPTxGCQ/asld/g==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52277958-efeb-485b-8db4-08d7cad1b726
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2020 00:17:16.4108
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9ai0XWvW77VjK8QV56HLlruDmO2FE/+dWEP0uI0AGMhgE9e/IVfpcTkGiwbWzPKlhgIb1oFteQZEghy2YIGTn7uVnI2F2I/0+NnEwTfOZB0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1082
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Marc Zyngier <maz@kernel.org>  Sent: Sunday, March 15, 2020 11:16 AM
>=20
> On Sat, 14 Mar 2020 15:35:15 +0000,
> Michael Kelley <mikelley@microsoft.com> wrote:
> >
> > Add functions to set up and remove kexec and panic
> > handlers, and to inform Hyper-V about a guest panic.
> > These functions are called from architecture independent
> > code in the VMbus driver.
> >
> > This code is built only when CONFIG_HYPERV is enabled.
> >
> > Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> > ---
> >  arch/arm64/hyperv/hv_core.c  | 61
> ++++++++++++++++++++++++++++++++++++++++++++
> >  arch/arm64/hyperv/mshyperv.c | 26 +++++++++++++++++++
> >  2 files changed, 87 insertions(+)
> >
> > diff --git a/arch/arm64/hyperv/hv_core.c b/arch/arm64/hyperv/hv_core.c
> > index 4aa6b8f..8d6de9f 100644
> > --- a/arch/arm64/hyperv/hv_core.c
> > +++ b/arch/arm64/hyperv/hv_core.c
> > @@ -199,3 +199,64 @@ void hv_get_vpreg_128(u32 msr, struct
> hv_get_vp_register_output *res)
> >  	kfree(output);
> >  }
> >  EXPORT_SYMBOL_GPL(hv_get_vpreg_128);
> > +
> > +void hyperv_report_panic(struct pt_regs *regs, long err)
> > +{
> > +	static bool panic_reported;
> > +	u64 guest_id;
> > +
> > +	/*
> > +	 * We prefer to report panic on 'die' chain as we have proper
> > +	 * registers to report, but if we miss it (e.g. on BUG()) we need
> > +	 * to report it on 'panic'.
> > +	 */
> > +	if (panic_reported)
> > +		return;
> > +	panic_reported =3D true;
>=20
> How does this work when multiple vcpus are crashing at once? Are you
> guaranteed to be single-threaded at this point?

I'll need to go research.  If not, the above should be an atomic
test-and-set.

>=20
> > +
> > +	guest_id =3D hv_get_vpreg(HV_REGISTER_GUEST_OSID);
> > +
> > +	/*
> > +	 * Hyper-V provides the ability to store only 5 values.
> > +	 * Pick the passed in error value, the guest_id, and the PC.
> > +	 * The first two general registers are added arbitrarily.
> > +	 */
> > +	hv_set_vpreg(HV_REGISTER_CRASH_P0, err);
> > +	hv_set_vpreg(HV_REGISTER_CRASH_P1, guest_id);
> > +	hv_set_vpreg(HV_REGISTER_CRASH_P2, regs->pc);
> > +	hv_set_vpreg(HV_REGISTER_CRASH_P3, regs->regs[0]);
> > +	hv_set_vpreg(HV_REGISTER_CRASH_P4, regs->regs[1]);
>=20
> How about reporting useful information, a pointer to some data
> structure describing the fault? As it is, the usefulness of this is
> pretty dubious.

Yes, it is dubious.  The version with more data describing the fault is
hyperv_report_panic_msg() below, which is provided by newer versions
of Hyper-V, including all versions for ARM64.  So the above function
should never get called on ARM64.  While we could stub it out, I'd
like to keep the notification to Hyper-V just in case
hyperv_report_panic_msg() is not available for some reason I can't
currently anticipate.  The important thing is the notification, and
the register values aren't really important.  I'll add a comment to
that effect.

>=20
> > +
> > +	/*
> > +	 * Let Hyper-V know there is crash data available
> > +	 */
> > +	hv_set_vpreg(HV_REGISTER_CRASH_CTL, HV_CRASH_CTL_CRASH_NOTIFY);
> > +}
> > +EXPORT_SYMBOL_GPL(hyperv_report_panic);
> > +
> > +/*
> > + * hyperv_report_panic_msg - report panic message to Hyper-V
> > + * @pa: physical address of the panic page containing the message
> > + * @size: size of the message in the page
> > + */
> > +void hyperv_report_panic_msg(phys_addr_t pa, size_t size)
> > +{
> > +	/*
> > +	 * P3 to contain the physical address of the panic page & P4 to
> > +	 * contain the size of the panic data in that page. Rest of the
> > +	 * registers are no-op when the NOTIFY_MSG flag is set.
> > +	 */
> > +	hv_set_vpreg(HV_REGISTER_CRASH_P0, 0);
> > +	hv_set_vpreg(HV_REGISTER_CRASH_P1, 0);
> > +	hv_set_vpreg(HV_REGISTER_CRASH_P2, 0);
> > +	hv_set_vpreg(HV_REGISTER_CRASH_P3, pa);
> > +	hv_set_vpreg(HV_REGISTER_CRASH_P4, size);
> > +
> > +	/*
> > +	 * Let Hyper-V know there is crash data available along with
> > +	 * the panic message.
> > +	 */
> > +	hv_set_vpreg(HV_REGISTER_CRASH_CTL,
> > +	       (HV_CRASH_CTL_CRASH_NOTIFY | HV_CRASH_CTL_CRASH_NOTIFY_MSG));
> > +}
> > +EXPORT_SYMBOL_GPL(hyperv_report_panic_msg);
> > diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.=
c
> > index ae6ece6..c58940d 100644
> > --- a/arch/arm64/hyperv/mshyperv.c
> > +++ b/arch/arm64/hyperv/mshyperv.c
> > @@ -23,6 +23,8 @@
> >
> >  static void (*vmbus_handler)(void);
> >  static void (*hv_stimer0_handler)(void);
> > +static void (*hv_kexec_handler)(void);
> > +static void (*hv_crash_handler)(struct pt_regs *regs);
>=20
> Why is this in the arch-specific code? Yes, it lives in the x86 arch
> code too, but I don't see what prevents it from being moved to the
> vmbus_drv.c code.

OK -- I'll see about moving it to arch independent code.

>=20
> >
> >  static int vmbus_irq;
> >  static long __percpu *vmbus_evt;
> > @@ -137,3 +139,27 @@ void hv_remove_stimer0_irq(int irq)
> >  	}
> >  }
> >  EXPORT_SYMBOL_GPL(hv_remove_stimer0_irq);
> > +
> > +void hv_setup_kexec_handler(void (*handler)(void))
> > +{
> > +	hv_kexec_handler =3D handler;
> > +}
> > +EXPORT_SYMBOL_GPL(hv_setup_kexec_handler);
> > +
> > +void hv_remove_kexec_handler(void)
> > +{
> > +	hv_kexec_handler =3D NULL;
> > +}
> > +EXPORT_SYMBOL_GPL(hv_remove_kexec_handler);
> > +
> > +void hv_setup_crash_handler(void (*handler)(struct pt_regs *regs))
> > +{
> > +	hv_crash_handler =3D handler;
> > +}
> > +EXPORT_SYMBOL_GPL(hv_setup_crash_handler);
> > +
> > +void hv_remove_crash_handler(void)
> > +{
> > +	hv_crash_handler =3D NULL;
> > +}
> > +EXPORT_SYMBOL_GPL(hv_remove_crash_handler);
> > --
> > 1.8.3.1
> >
> >
>=20
> Thanks,
>=20
> 	M.
>=20
> --
> Jazz is not dead, it just smells funny.
