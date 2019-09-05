Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA2CAAAEA8
	for <lists+linux-arch@lfdr.de>; Fri,  6 Sep 2019 00:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387662AbfIEWrJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 5 Sep 2019 18:47:09 -0400
Received: from mail-eopbgr720133.outbound.protection.outlook.com ([40.107.72.133]:29120
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726073AbfIEWrI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 5 Sep 2019 18:47:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FjFUTx/oo0QyHMcEuM9dREjJ4rr3fJpRn8i+6A5MEqxPDaLWfOXFmuQU2tJw2JpOQpG0W+w/7kukjdWtqiMfB7mM8HllAJb/XMJqt79rdxCFmGiwNYZr58LZyqxXAakrGTpwkKA/h1emqE7XC6j9Qi/qD/oRyt5Vvz1tTTg/FwSSTDYB/FkopvCRQCCeRca4HXvh/YslapAsoQNDBSfcHnYN2/o40a5f8fcoob275Q878b1K0gOJ3iaUdC7QLVpRo8/zDGmyvbbmYoyIRAqPpc+5Ktcz9M/EW7ZbP26ID886fZ496iSp1pACoE8lKfAFnahZ30G5XbystiiI5clmQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WamlG1JEr0ZoR83E8/3dBW9zjNcaFF2VYbF4Hl3/EMc=;
 b=gpxr8LMw1aYnKvCjjyOrsAN0BhnDhqP6l5ZemoJRvor7IsEX7mugciyySv5nl3/uOAydT9b6ERQctgW12mJAeAMk9HMTJOR4pwALX6C4KlPod/muQFbImmqD4GOxGKPqtXHK5akgfAAYuf0FeFfXC4irDQx+ImNSJBwvLi5AFTPsN1dye4LkuXI6HKX9epsEByyeBZ3jBo7VIyzz5WJHbJvMu9o+f6iiRsBSRBIaSXcEe/4pQqY4jzptj0dLtDoOBQ5MePdUDU7viVlfbUFqgnFfVgwiGYLqCPJ+D/YIdZJQkYd/dnf78CBljPmHpFOVJzdxUc4kYBYGOc0DVYrdwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WamlG1JEr0ZoR83E8/3dBW9zjNcaFF2VYbF4Hl3/EMc=;
 b=kJ53qBFcu+2dtI5C2DimPIkUliTUEJn4qsZkTiaAd7QDCEDlTasaOZjeNG+w+GT+WrnRLvdgOU9rdt3lfzP4n6SFLcqZQs5YrUneknqi1BGhqoIhQm5SyehjaHowtDSIrHSwBC8X49MOCWDHh16Z7c8quoIbyxlOKKnMdid3lqI=
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com (52.132.114.19) by
 SN6PR2101MB1101.namprd21.prod.outlook.com (52.132.115.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.7; Thu, 5 Sep 2019 22:47:05 +0000
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::dd56:aa4f:204f:86a4]) by SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::dd56:aa4f:204f:86a4%3]) with mapi id 15.20.2263.005; Thu, 5 Sep 2019
 22:47:04 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     "arnd@arndb.de" <arnd@arndb.de>, "bp@alien8.de" <bp@alien8.de>,
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
CC:     "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Dexuan Cui <decui@microsoft.com>
Subject: [PATCH v5 0/3] Enhance Hyper-V for hibernation
Thread-Topic: [PATCH v5 0/3] Enhance Hyper-V for hibernation
Thread-Index: AQHVZDvWiJN7KE4mZkeEB0PYga91Ow==
Date:   Thu, 5 Sep 2019 22:47:03 +0000
Message-ID: <1567723581-29088-1-git-send-email-decui@microsoft.com>
Reply-To: Dexuan Cui <decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR19CA0019.namprd19.prod.outlook.com
 (2603:10b6:300:d4::29) To SN6PR2101MB0942.namprd21.prod.outlook.com
 (2603:10b6:805:4::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.8.3.1
x-originating-ip: [13.77.154.182]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ad674e58-72cb-4523-7400-08d73252f85f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR2101MB1101;
x-ms-traffictypediagnostic: SN6PR2101MB1101:|SN6PR2101MB1101:
x-ms-exchange-transport-forked: True
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <SN6PR2101MB1101361C4FA9D3915CEA4DAEBFBB0@SN6PR2101MB1101.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 015114592F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(136003)(366004)(396003)(346002)(376002)(189003)(199004)(4326008)(36756003)(6512007)(25786009)(99286004)(6436002)(4744005)(7416002)(6306002)(81156014)(81166006)(8676002)(53936002)(386003)(6506007)(107886003)(6636002)(4720700003)(316002)(54906003)(110136005)(50226002)(22452003)(8936002)(52116002)(3450700001)(66066001)(2906002)(2501003)(43066004)(1511001)(10090500001)(66476007)(86362001)(66556008)(64756008)(26005)(66946007)(66446008)(966005)(3846002)(6116002)(2201001)(305945005)(2616005)(71200400001)(476003)(102836004)(14444005)(256004)(71190400001)(5660300002)(478600001)(10290500003)(6486002)(7736002)(14454004)(486006)(186003)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB1101;H:SN6PR2101MB0942.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2r1vk+t36mkVYdm1fZB4LblYUG8a6xPd+OamFvPjopusZzpBJI+/MzjqIFxV9adlhfx7Ip2W4HHuiYjmsL77jPMvDOFamstPWLwmX8VVNDiSCD8OFY5aOYwuFCvwiFZsn+BqsxIv6GQXiMdmKbEALAFsHuvhlZbP5+Xv9VRAfutgk8KEjjrP23a1bONCC8cWx/IcBy8Lqhl9rNFrD5iQ7N3rM9xH3YF+R1qnqTPx5cwPzZ8vPiallLCspWAiS81uuswlAnAjx1lVErpJGNlni2KosUWRAwGFzHmLEv6W/4Dt2Ba9Ml+9UrVkP2FTzL5+/l4njRu48sDZ16dW0HS2fiaWyyrKNyq+ReNUUbljTEpwKuqT81AE9yBNZRi9dl852qrrw/VDbA9Qdh/p8CmZZkWeVhs3lCoIdyOJx7wwbRo=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad674e58-72cb-4523-7400-08d73252f85f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2019 22:47:04.4409
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jYbyvubFjne8htuDvdIGdXVhXlI8xq5Og1l33vTHFvbZIH5puCUQBqFvXWmX0gpJNii7ompYt0EB3UKA2mR2CA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1101
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This patchset (consisting of 3 patches) was part of the v4 patchset (consis=
ting
of 12 patches):
    https://lkml.org/lkml/2019/9/2/894

I realized these 3 patches must go through the tip.git tree, because I have
to rebase 2 of the 3 patches due to recent changes from others in the tip
tree.

All the 3 patches are now rebased to the tip tree's timers/core branch:
https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/log/?h=3Dtimers=
/core
, and all the 3 patches have Michael Kelley's Signed-off-by's.

Please review.

Thanks!
Dexuan

Dexuan Cui (3):
  x86/hyper-v: Suspend/resume the hypercall page for hibernation
  x86/hyper-v: Implement hv_is_hibernation_supported()
  clocksource/drivers: Suspend/resume Hyper-V clocksource for
    hibernation

 arch/x86/hyperv/hv_init.c          | 40 ++++++++++++++++++++++++++++++++++=
++++
 drivers/clocksource/hyperv_timer.c | 25 ++++++++++++++++++++++++
 include/asm-generic/mshyperv.h     |  2 ++
 3 files changed, 67 insertions(+)

--=20
1.8.3.1

