Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 872925A45A
	for <lists+linux-arch@lfdr.de>; Fri, 28 Jun 2019 20:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbfF1Slj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 28 Jun 2019 14:41:39 -0400
Received: from mail-eopbgr680096.outbound.protection.outlook.com ([40.107.68.96]:59556
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726497AbfF1Sli (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 28 Jun 2019 14:41:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fExCDPy2DRiTZAkM2VeUX6WX+vcLVkzEFrt6yAnj5bEkbLV/D1nwbyiOnNTM3htUHvVJvWmX/BObemY2qH3QEyyWJ+KDZUdBwZ9Ii+lR5bWFvvszfnxVephhe/wWT/jf97ElIBFXZK+rU4/nkLNVJqIszEYrW6tY/JlDcLUabrWhWEZOl5DQgj+8qKtzlRccym5uhaWBXj8OiFLuFjscN4IWqOIKbPULudow53u8+rMgT9jQTfsZsLUXPLpuMVek/frHdntTMJQvJksHSo8NM+FzZe4BwMYYYfUH7NVzaBBqXu+eT7cbTaKRDGFQJmoPt0jm4/fo57tQdPQ11psKVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mLwjYMi/BBolilHTYkIuishxYaJTpZbSDu6cNT6co3s=;
 b=bE45Itfz0p6WciEKE9dKPByIEds8lxtkHtBt9K0HzCUVlwlJV6JJlW74EC5Hj/9XOXqd8O02OvVhdnaDyBTFKplKPsl8D32VxGBieNbWS8Kfr8rj+ROazYfQOm3+383/ZSxJOZoD2zdK6oucVqONMoyg1FF6KECZ4dQk38jlTdWhiIpurYCZWeVxW/HuE6t9Zi7aPKzeE2mVl4leWB/anRtOPzC7aYRFxakuxbPF3BJpLs8FyqXJsQxs/rPnYfGFvpj0m9FxAuweMN/4C3pHZC2t4+3G/f73FeTzw5whMTTAA11dpwiN1FlelJCkmJtrGud1fRtqbt9kuWdJEdKnHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=microsoft.com;dmarc=pass action=none
 header.from=microsoft.com;dkim=pass header.d=microsoft.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mLwjYMi/BBolilHTYkIuishxYaJTpZbSDu6cNT6co3s=;
 b=Lb3lcQCJ12mg4HhBY+MWgt8+bXn6kYN3YYTjyBNCTiAgbP2JdUaHJMJoGcnMOKYU9uKqAIbElR3y439rl8mx1iOxlkXkrdBkedGSpOc0zzx7ztm6bhmE8RSoCmftKCUBaoGanmho9T6Q/o/zAincWfCG6a6KMn2afrurIySzyOA=
Received: from BL0PR2101MB1348.namprd21.prod.outlook.com (20.177.244.150) by
 BL0PR2101MB0979.namprd21.prod.outlook.com (52.132.20.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.4; Fri, 28 Jun 2019 18:40:56 +0000
Received: from BL0PR2101MB1348.namprd21.prod.outlook.com
 ([fe80::4814:2790:9342:9582]) by BL0PR2101MB1348.namprd21.prod.outlook.com
 ([fe80::4814:2790:9342:9582%2]) with mapi id 15.20.2052.005; Fri, 28 Jun 2019
 18:40:56 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     Sasha Levin <sashal@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Salyzyn <salyzyn@android.com>,
        Peter Collingbourne <pcc@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Huw Davies <huw@codeweavers.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: RE: [PATCH v6 18/19] x86: Add support for generic vDSO
Thread-Topic: [PATCH v6 18/19] x86: Add support for generic vDSO
Thread-Index: AQHVFvJX/FWqgsMYXUWDuWvrdwhvDKaDyyHwgBdL5YCAAKgjAIAMJX0AgAHb0oCAADMqgIAAGq6AgAAKXgCAB3oPIA==
Date:   Fri, 28 Jun 2019 18:40:56 +0000
Message-ID: <BL0PR2101MB1348C26A569D83E9D7BB03CDD7FC0@BL0PR2101MB1348.namprd21.prod.outlook.com>
References: <20190530141531.43462-1-vincenzo.frascino@arm.com>
 <20190530141531.43462-19-vincenzo.frascino@arm.com>
 <BYAPR21MB1221D54FCEC97509EEF7395CD7180@BYAPR21MB1221.namprd21.prod.outlook.com>
 <alpine.DEB.2.21.1906141313150.1722@nanos.tec.linutronix.de>
 <20190614211710.GQ1513@sasha-vm>
 <alpine.DEB.2.21.1906221542270.5503@nanos.tec.linutronix.de>
 <20190623190929.GL2226@sasha-vm>
 <alpine.DEB.2.21.1906240006090.32342@nanos.tec.linutronix.de>
 <BYAPR21MB135202F46C4B023B51EBBFD0D7E00@BYAPR21MB1352.namprd21.prod.outlook.com>
 <alpine.DEB.2.21.1906240221550.32342@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1906240221550.32342@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-06-28T18:40:54.3514619Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=12c4760d-43f5-416f-b56a-135069a968d4;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 70d38258-35d1-4317-571d-08d6fbf82869
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BL0PR2101MB0979;
x-ms-traffictypediagnostic: BL0PR2101MB0979:
x-microsoft-antispam-prvs: <BL0PR2101MB09791FE051D90F996EBA6326D7FC0@BL0PR2101MB0979.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 00826B6158
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(346002)(136003)(39860400002)(396003)(366004)(189003)(199004)(4744005)(76116006)(4326008)(73956011)(446003)(10290500003)(478600001)(11346002)(5660300002)(68736007)(6246003)(71190400001)(71200400001)(33656002)(486006)(6436002)(25786009)(66066001)(99286004)(8990500004)(66476007)(14444005)(102836004)(256004)(66946007)(186003)(6916009)(7696005)(26005)(76176011)(54906003)(229853002)(6506007)(64756008)(66446008)(476003)(10090500001)(66556008)(86362001)(7736002)(305945005)(14454004)(74316002)(53936002)(52536014)(7416002)(316002)(2906002)(22452003)(9686003)(8676002)(8936002)(3846002)(6116002)(81156014)(81166006)(55016002)(41533002);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0979;H:BL0PR2101MB1348.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: bHsin/NqNsXiytgX5zQnA258TkoJJuSoswu0uRaEiI76OTPz/cktBkMt7i6upscG7j3ppy/2eAT5Q4SUBudM8NoQFkxXW+8bpPN7vrDm01FgjR/2wNj7Gh/kJAlrHEF+vn7NnWOQeTFcBuOroI9fqO8yMd4FW3kDb4puD51K+E/GsmootqPGrRzbI5tF7gG69jxEhZVmiOvm4RlHmLMvCwkZ+52sTWzduP0VbuR1jw25SKAXuJTTz1jFJd4t61F4nsghE6+/GJgLvojhD/+CjxqWKma/UUiwhyCUDcShceWLSiOzyXL+7GqWf0t/94cTJ/XBN/dozmr/3Nd3uk0nECBwmtRdam7x19rimz56hLkfw6dd6WsRjhVlmyuGoLCS5bXyXJw6os/nG9CddCDuF8bJb7sQE6BhFRsDNgs91Lk=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70d38258-35d1-4317-571d-08d6fbf82869
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2019 18:40:56.6446
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mikelley@ntdev.microsoft.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0979
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de> Sent: Sunday, June 23, 2019 5:25=
 PM
>=20
> I don't care whether this goes into 5.3 or later. If you can provide me
> rebased self contained patches on top of
>=20
>   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/vdso
>=20
> I'm happy to pull them in on top.
>=20

I've sent out "v4" of the patch set to create a Hyper-V clocksource, based
on the above tree.  It is contained to Hyper-V code, plus updating a #inclu=
de
statement in two of the VDSO files and in one KVM file.  If the KVM file
update is problematic, the patch set can just wait until 5.3-rc1.

Michael
