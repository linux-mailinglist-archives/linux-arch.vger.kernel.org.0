Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 614AFBFF61
	for <lists+linux-arch@lfdr.de>; Fri, 27 Sep 2019 08:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725820AbfI0Gti (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 27 Sep 2019 02:49:38 -0400
Received: from mail-eopbgr1320134.outbound.protection.outlook.com ([40.107.132.134]:8263
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725812AbfI0Gti (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 27 Sep 2019 02:49:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HkIc+d4zHGh+xPMd4nW6BTB7DZ2nYCeMmPsCdqAGshqlR1+NqtAEP5DgJfwu5y4i3mzzisbp6j9kDqSTAVzEjelhAfH26mB+kzGumKzMbh47JLFU9RspiEZQF+j9iT8xVd+k8RH6KaW0gLbmNfcMtHceO0953t6c8K7VcRW7+sjk72KqkvvzUeYQzLUECzRTF0noxLdxPqL2HZSvNWOu9KuPSIrfLBvft7TYsQ2nYK8OUN0aZatRmDHDILmYoDTabgu3MnQYnJMy0R0MJM8yb2lBQrE+iWx6uOT8THS2OoPKa8NF9AmK48ASPofxjnZLDxOSaoqNwR9xpyVgtTc7RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oYc8G/ttPt0J2xy7FkwsOD56/5VRUyPGEPWavnvvb7s=;
 b=SWpxNyEL0Vsb7xdcRP/O+5yV3d+8DgJAjNSyPqnauxU1At9uwTdsduJRn1nHkgB0/kv9ZNEWksSYzsV/7DkwrMuE5oEmJ/UIytPH+M4k/m9cwT235G1gEQhtT/LIRAbYrYq/EP0tOnIugU3gmW8UBgdISSpX+H0g/jB+5YsmtG3WIRw2Ll/UV3OvQm80tShN3worNOLFlFpqp6JsBvdgiRvxVACoH0a0E8bIhdSzxC1PzEXCIpWVjtamM/dpGlKImGUsQazLezK5yjMMuvWCfoe/ONY5zb8OhpUJl3GOk2b8Q3PPGIy77YG8eyfOGQHbX0DPAM1eWVqDaalINy/aGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oYc8G/ttPt0J2xy7FkwsOD56/5VRUyPGEPWavnvvb7s=;
 b=VRR4Ff7pC/cL41kQO5Wv6pzw45JEQtsd2XpB6w9ChzXpnpmN0SxVVcflaK+3oVjsIR75kuj1Qc/hFazoSmNlaz4fFd3H54ypKMVPI07el6QX9dCTXXq4N0dbRr2jfBZPxMkIW9rjxlcWS8JvxRXp5KVV4lgOq5vZbiowViCOOhM=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0138.APCP153.PROD.OUTLOOK.COM (10.170.188.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.2; Fri, 27 Sep 2019 06:48:53 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::fc44:a784:73e6:c1c2]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::fc44:a784:73e6:c1c2%7]) with mapi id 15.20.2327.009; Fri, 27 Sep 2019
 06:48:53 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     vkuznets <vkuznets@redhat.com>
CC:     "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>, "bp@alien8.de" <bp@alien8.de>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "hpa@zytor.com" <hpa@zytor.com>, KY Srinivasan <kys@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: RE: [PATCH v5 1/3] x86/hyper-v: Suspend/resume the hypercall page for
 hibernation
Thread-Topic: [PATCH v5 1/3] x86/hyper-v: Suspend/resume the hypercall page
 for hibernation
Thread-Index: AQHVdFddc0vkIIkGmEOkqRoIHJJIFqc/CHEA
Date:   Fri, 27 Sep 2019 06:48:52 +0000
Message-ID: <PU1P153MB01695A159E9843B4E1EC13AEBF810@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <1567723581-29088-1-git-send-email-decui@microsoft.com>
 <1567723581-29088-2-git-send-email-decui@microsoft.com>
 <87ef0372wv.fsf@vitty.brq.redhat.com>
In-Reply-To: <87ef0372wv.fsf@vitty.brq.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-09-27T06:48:51.2878957Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=da16a730-ee30-4582-b8df-bb4da2a05b46;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2601:600:a280:7f70:557a:f14b:ea25:465f]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5b5bbd45-5edc-46d8-d7d4-08d74316c2e8
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: PU1P153MB0138:|PU1P153MB0138:|PU1P153MB0138:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <PU1P153MB013893DAFB4FF4AD0552FC6CBF810@PU1P153MB0138.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0173C6D4D5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(366004)(136003)(376002)(346002)(396003)(189003)(199004)(14444005)(4326008)(256004)(81166006)(99286004)(7696005)(2906002)(55016002)(102836004)(229853002)(6916009)(6506007)(71200400001)(71190400001)(476003)(81156014)(6116002)(8676002)(86362001)(46003)(11346002)(15650500001)(25786009)(186003)(486006)(76176011)(8936002)(9686003)(22452003)(52536014)(33656002)(10090500001)(6436002)(66446008)(446003)(305945005)(8990500004)(74316002)(10290500003)(7416002)(7736002)(54906003)(66476007)(66556008)(64756008)(76116006)(66946007)(478600001)(316002)(5660300002)(14454004)(6246003)(107886003);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0138;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EdT5y2i2PR0TN3hSfRWfZw0XW1CTDDE/iRKCB515lfZgw62K4N+kpsV7rIDLm+4QpDpNM5La9R1NGXLppLEl8Z91mwkmIapfG5PDvXfkQ3oqIq7gtzSLuHJ3xGnSFkLaTgIbSz2wk4JLm3rsBsxfghiQMTeFCxAxgSIl7j88APLh2EDZf9KW2DCy1q+08usM6y76hzDDkRx4KWby0NRCetRPDxa7wojKkOmzUNSoxhkWxj5RNjRG4cZAwW4YaLX01CPJN1So14kWO0UNycOAm4QepCzcGpdN05537nfj9tQv9aV/M9jxFb6KdfBW5I7K/CjdEHriI9qXBWieCZPCm4ui5VPWyKW2oyXdKo78K1VxRe1h4DtcjVibiQJxVZdSSvgVBuYv+qmNZD9yX8j2+s7cHKV6p1q5wlm7kuY2nL4=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b5bbd45-5edc-46d8-d7d4-08d74316c2e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2019 06:48:53.0188
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +tUps0hlqGHaNF9fFRPvcfbNcL0tCWLoIhuSD5zTscDGLd2My8tBneU8UJSkakAGLS+0Qn8IqqxesCyToVVLug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0138
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> From: Vitaly Kuznetsov <vkuznets@redhat.com>
> Sent: Thursday, September 26, 2019 3:44 AM
> > [...]
> > +static int hv_suspend(void)
> > +{
> > +	union hv_x64_msr_hypercall_contents hypercall_msr;
> > +
> > +	/* Reset the hypercall page */
> > +	rdmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
> > +	hypercall_msr.enable =3D 0;
> > +	wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
> > +
>=20
> (trying to think out loud, not sure there's a real issue):
>=20
> When PV IPIs (or PV TLB flush) are enabled we do the following checks:
>=20
> 	if (!hv_hypercall_pg)
> 		return false;
>=20
> or
>         if (!hv_hypercall_pg)
>                 goto do_native;
>=20
> which will pass as we're not invalidating the pointer. Can we actually
> be sure that the kernel will never try to send an IPI/do TLB flush
> before we resume?
>=20
> Vitaly

When hv_suspend() and hv_resume() are called by syscore_suspend()
and syscore_resume(), respectively, all the non-boot CPUs are disabled and
only CPU0 is active and interrupts are disabled, e.g. see

hibernate() ->=20
  hibernation_snapshot() ->
    create_image() ->
      suspend_disable_secondary_cpus()
      local_irq_disable()

      syscore_suspend()
      swsusp_arch_suspend
      syscore_resume

      local_irq_enable
      enable_nonboot_cpus


So, I'm pretty sure no IPI can happen between hv_suspend() and hv_resume().
self-IPI is not supposed to happen either, since interrupts are disabled.

IMO TLB flush should not be an issue either, unless the kernel changes page
tables between hv_suspend() and hv_resume(), which is not the case as I
checked the related code, but it looks in theory that might happen, say, in
the future, so if you insist we should save the variable "hv_hypercall_pg"
to a temporary variable and set the "hv_hypercall_pg" to NULL before we
disable the hypercall page, I would be happy to post a new version of this
patch, or we can keep this patch as is and I can make an extra patch.

Thanks,
-- Dexuan
