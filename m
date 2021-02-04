Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C34730F7FD
	for <lists+linux-arch@lfdr.de>; Thu,  4 Feb 2021 17:35:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238081AbhBDQbh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 4 Feb 2021 11:31:37 -0500
Received: from mail-eopbgr770131.outbound.protection.outlook.com ([40.107.77.131]:36513
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238045AbhBDQbE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 4 Feb 2021 11:31:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jUXJsBy9n+PhW8mMIsKQaDdn8ncYIH/Y5eODfSij1am/dFRRJ4KLbxVUPN/10mKy9y2YUlIjvM7mIjRH0Kbp8pUycq5Ak5LTEc8VaI3EtUs8U3n+5rll8MKEhuY8iV8mcSwiROAW3jRrzYwshmR5pHUg2aXYvTkI+r5tjQ5X+I2+CVJ1RafsDyhwuQWu3BdxnzVRynGhPS6qSPO+DEjOuCi/W79RTstfDnXnkbIyVTtWRaD5pPwJNnG/dpN2w2YABQ7Ayu/3hTAYsQtRDc3SAQk4Gdy+nISu4//tcVq2Rc7JP/R1BHAk+FY75heOwqNsK2fIJAEwEG7klzVtdzBt8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t/W8U3/FEGndkPjDi3yroOGeZX9aKIcZ0/P6pWu+Yec=;
 b=KkRxhRx/pgYpATVsyLYAzhr/G5SqZduveXVmY2t0QsoWW1u9bU6sWdiH8FimM1t+VhiTM3WZoQFdKpuDYpDgB3/6U/NAvvcOywiP7VeoRYgfqPEu1Y84bbGRcYCvKstYjWfCAdYzjZKANm2nJ2FFgAhXJ3ZO0iRoUacm12X984/4xeNl7tjMBZA4LRpAJw4sZ0En4rRsV34rEemZ80enCvEJzVZEJdT2m+FoY7XiGXudT4gc8oVYUXxr4feZuLwLfn2CZ0GEhTCCzDglenLGgQ7DO7Ant5nUU1EqT2ChlxPKgAPPDOM1hJqV7lv/9dcoHJc5hf0dKYqC58uw6g1Rwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t/W8U3/FEGndkPjDi3yroOGeZX9aKIcZ0/P6pWu+Yec=;
 b=YK4tgzwQVR54cBkBiV5ix9aPUfwQn2qHoAz++XxIJUywYk7IrlYnAp1GWunXvQ/X6vHuzZFGfjY4PAp08ce1RTuQCTHUMsFyQWR8OtdvqdiAXPXoOQKlOeQay0wGh/xTytK9GCO7FoOcqxR00bAudwu2BeYo9kSs0mhCxTpzLt0=
Received: from (2603:10b6:301:7c::11) by
 MWHPR21MB1547.namprd21.prod.outlook.com (2603:10b6:301:80::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3846.3; Thu, 4 Feb 2021 16:30:18 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2%9]) with mapi id 15.20.3846.006; Thu, 4 Feb 2021
 16:30:18 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Wei Liu <wei.liu@kernel.org>
CC:     Stephen Hemminger <sthemmin@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: RE: [PATCH 10/10] clocksource/drivers/hyper-v: Move handling of
 STIMER0 interrupts
Thread-Topic: [PATCH 10/10] clocksource/drivers/hyper-v: Move handling of
 STIMER0 interrupts
Thread-Index: AQHW9Ops9ZR2U7oM7UKPy+5kj6GCqKpDvfuAgAR94TA=
Date:   Thu, 4 Feb 2021 16:30:18 +0000
Message-ID: <MWHPR21MB15932869426E26130324DFEED7B39@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <1611779025-21503-1-git-send-email-mikelley@microsoft.com>
 <1611779025-21503-11-git-send-email-mikelley@microsoft.com>
 <20210201195327.2bkhu6sig53prwwg@liuwe-devbox-debian-v2>
In-Reply-To: <20210201195327.2bkhu6sig53prwwg@liuwe-devbox-debian-v2>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-02-04T16:30:16Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=bb452e40-5289-408c-8675-3563220a7adc;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 50caafb6-77dc-4653-cf1b-08d8c92a28e8
x-ms-traffictypediagnostic: MWHPR21MB1547:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR21MB154762F1CC92F030B9453529D7B39@MWHPR21MB1547.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DNcV9nVJLIoCuLf9qGkTFQt0x8bI0orljxkIntr2uT6fVjFe5xOzujtjVo35ix2BPaS2k6jDR8SfvxxKHpgRdrAXzAk9WzcepLCjeAigXTsWpGR+gahZ+qFXOWpBOmoPj4//mbwl4aMNyyKvndFXQLasNME3M00ej+fEhP7U860v/ZR8HuKQwnWz7HEEaPaV3EgkC6mQ/rJqUvx1lhi8Ui9ElEuVFPhLhPPlFN3ZE0KJ0Sl2GA2dA2ItT/JMHgG5MuKdwwOF+zxza8uM1QpE5VJBg4D4eqabNp5G+C57KdcPFRlpJ8kFc/qfuE305CfgJ4aEqAlnThhpcAXQjdAXMkwxL+704qWsB5gim0K6moLlTKWT1dchvcmj8MCMUZQdEmzveHKmT0aj84HdRpEW1P351Q93A2sO9UXRtQ2TNGbAIphClzThJ5enQCGr0HfznrowQehPVMXkDX2Lop7zIJSid/Q/DYbtVvmqrFTRrmAX3YxRGliSOUg9TIBdJB4VGiOyycJYj3jXuP+PFz5CmQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(396003)(346002)(136003)(366004)(9686003)(66446008)(7416002)(6916009)(66946007)(4326008)(82960400001)(86362001)(8676002)(71200400001)(82950400001)(76116006)(64756008)(54906003)(8936002)(33656002)(10290500003)(55016002)(8990500004)(2906002)(66476007)(7696005)(4744005)(6506007)(52536014)(26005)(186003)(478600001)(316002)(66556008)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?gpP2X04db61WlmUgbsB21mi2UwthWlDxf2kcVv/YAr0mtiH8O0b1X1gWDftM?=
 =?us-ascii?Q?p7nsYfe3mgY5boP4cyvzdHfLKgmezKXlfyUC27n9DgvC3xbt+wR2SUasuwJn?=
 =?us-ascii?Q?FOvfE4XIkNHUKLQPwNDQ0ewb9EOBJKGCy8gKpySDKBw8EovLTDl/cjKXSrap?=
 =?us-ascii?Q?MfxzCXfn9IC/7OJtYcdQ3OUgg241MjN4N6/SrhSRUGEsR8lb4R1Llid1nFDS?=
 =?us-ascii?Q?FglBKR9y9oLgo74VuSLfHHb2i4WMp7IBQxEXoBRUY7jdkXwEf/ar7E9MwmAA?=
 =?us-ascii?Q?F1Tzb0nhdPMQPn34v1lns3VnN7z96sUY5Tx71kw5BixLThEPCaI1Tk8G9Kvo?=
 =?us-ascii?Q?jOV8RUfNozrGBv8glv7B4XRx5BuEQUmnqgbK8WLQsZk2+WcSXOPvJ31iCySt?=
 =?us-ascii?Q?Y9LqQ/Weq1rzl5FvDX6T7dVrgGNoP7XZ8SrioP5x0a4G9eTaEmXcsUpi9Ns+?=
 =?us-ascii?Q?PKa7GORv12MpXHMIsDMAIkI9xKBQo5x334zEzauY5R6QtZCfIVqVRpo9djVZ?=
 =?us-ascii?Q?/nYfbCrLbIreHM52Lyl6utsPoKkNS5rwHgeFSEpJtpjZ/ah8hhRvCU+sxbH+?=
 =?us-ascii?Q?esWm3pb3XZNp+D1GoDERTZyhYzqCL4gvtbXCBskFex/5F6DJ7ldknWLmIlCO?=
 =?us-ascii?Q?vIeAjZTlNn7ET6tslaNH/JCTr1ZkInXMZBL9mCSD6Gm705WtvUGn74S8uTSt?=
 =?us-ascii?Q?wVeWdAkm+GMrIHy0pV6wwRUUI2qVsscChzXc+BjCsp0buhIZfFFX5HHCyV4d?=
 =?us-ascii?Q?oGQ8WJCD1cURESmaRa8ADPmKc3rRPeDU2x8WP36QohqulHjbbtFZDSTPWLtt?=
 =?us-ascii?Q?7b3LhL3ciqyVGWAgGfgXlixOPvECxpLyZsBTYec+SPMXgBg/jXhzogbv+Md7?=
 =?us-ascii?Q?1rnGFBex/dQF1Dif1C4sb38Ai5CwUHfTqnNq7iBwdwsV7jMCyzNwhXRg+N63?=
 =?us-ascii?Q?ZMmxjJb/Q7ptAO7GNT8pajjD6QhlNn02mYJsAq77b7cZoZOKmvOatEwhdBBg?=
 =?us-ascii?Q?wLYjN0DBtQixqaK7+zlyey2NMQtFlkC46fuD8EscUHN0AWBfjS/ZbSD4JHlO?=
 =?us-ascii?Q?6JKmNUWcFEVjDgfIUBztBXhqh3B7gHxZtHcJvLsD0xWfwa5PA2XdB349Xo+s?=
 =?us-ascii?Q?EvHar9mK7LKfIUHHlfw+f/LTthWowhdBoSS0BbruJ2q71lMeRjMV7m54GSU9?=
 =?us-ascii?Q?SM59JSCU2VG0anuHDLFvQLtEaj2DgRIXvMbQJ98gtiq6CdMV7yVkoWKzAdRM?=
 =?us-ascii?Q?oNu7qE9InBiPI+0y8vGzaC4kcL3/KLuOPfvfsI8Ghz7A5bylfgPkamY4tvP4?=
 =?us-ascii?Q?phl3gV9XqVgJgd45F4/u2rBD?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50caafb6-77dc-4653-cf1b-08d8c92a28e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2021 16:30:18.3981
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oHt0upCYz8KWvotKDAVkLhroHPcw+r4maRH8dMo02O0Tkj6KN/5thHXV1NVigtbAVafueZjzvt2M15T8MqyNUBQ1+fO44zE8It98CLKd8k0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB1547
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Wei Liu <wei.liu@kernel.org> Sent: Monday, February 1, 2021 11:53 AM
>=20
> On Wed, Jan 27, 2021 at 12:23:45PM -0800, Michael Kelley wrote:
> [...]
> > +static int hv_setup_stimer0_irq(void)
> > +{
> > +	int ret;
> > +
> > +	ret =3D acpi_register_gsi(NULL, HYPERV_STIMER0_VECTOR,
> > +			ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_HIGH);
>=20
> When IO-APIC is enabled on x86, acpi_register_gsi calls
> mp_map_gsi_to_irq. That function then calls mp_find_ioapic. Is
> HYPERV_STIMER0_VECTOR, when used as a GSI, associated with an IO-APIC?
> If not, wouldn't mp_find_ioapic return an error causing
> acpi_register_gsi to fail?
>=20
> Ah, it appears that this function is not called on x86. I haven't
> checked how ARM handles GSI, but presumably this works for you.  It
> would be good if a comment can be added to clarify things.
>=20
> Wei.

Will do.

Michael
