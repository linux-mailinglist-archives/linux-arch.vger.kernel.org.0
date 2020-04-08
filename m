Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D89101A2A3C
	for <lists+linux-arch@lfdr.de>; Wed,  8 Apr 2020 22:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728841AbgDHUTw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 8 Apr 2020 16:19:52 -0400
Received: from mail-dm6nam12on2121.outbound.protection.outlook.com ([40.107.243.121]:35425
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726891AbgDHUTv (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 8 Apr 2020 16:19:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K0zXQZ8IIY8lQ2+SmlqgKN6XqyG0bzqyoO1V71rUWKDVQD8LDNmguCKZ+J6lc3CXwaxPUOAH0cwEsV1eKPwq0OBqfeFR56GwtG8LNuoFF3QnEyM8blvEFU3dDijKCueWmvwh3A/ouEYtvrK2COEidxGGA8eGE6F2Hcy29HeuIUuSeLVxpJmsGYsiAEImp9P1LXld7TbHKXsY+LKva9Bbo1NxYSKBtKpoMn74xnEC7X3KCCqBHCGLdUTTGiP3g8NpJiQ12LCRrCTnI1AXl1UgD2J+i4Ct3Y/jy9yLNvNhuwx66BUiBVGK+cigEESncA9SZZy4SZ79naBKLZ6YS5YQ9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vqX0uOBUZZq1mMBJZG/TsuyKJXLWyKd3Z47NmKnK7LU=;
 b=gTtUn5/YP1q7jTK9R/9MEiVPWlMPUeT6uYwQ8u/aPYqkwkGOKyuiQ5bf0cJCP/EypPPKyPG/+bsiBrWbs36LMcxcXu0z0KsKLZuzQFAJuIDXDysZe79zslm73PZ5AHfkR8aVGAVcZXzxSAxM0P43/vtG3rAoWowb7+KEFbDgzqJ53Ois1Vg6Q/wjcrVGbtLotuMkJ2LkbO9ufkVfjtXTL3ppSIhmAW3YIUyBkg7OyMlqVjxykfrQPrS/vdwXulru5DH+v3fA/12qmQnvrUvjOG6n5L/opmiAH6t5rrw5Mf5ogkndXhT8wU0g/rIBH0129dJdfAxZsw8BI8SiDoEqYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vqX0uOBUZZq1mMBJZG/TsuyKJXLWyKd3Z47NmKnK7LU=;
 b=XZpUByJWt5KJAAPnGO6Hpke7oQd8p9HUWhhKSTJ4v+4Y7Eglz0eTuyp+3hLzZPgTgG7JZkawQnYuQeUEdEwbVpvr7zTkIfGEp8yg6wICl39u6tvH9/8SRaJeNjyVOcNoAb6NztsSxfjAiziuBC7uII6sxkHTupf48A/4DIZTTEY=
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com (2603:10b6:302:a::16)
 by MW2PR2101MB0921.namprd21.prod.outlook.com (2603:10b6:302:10::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.9; Wed, 8 Apr
 2020 20:19:47 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::71ee:121:71bd:6156]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::71ee:121:71bd:6156%9]) with mapi id 15.20.2900.012; Wed, 8 Apr 2020
 20:19:47 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     "ltykernel@gmail.com" <ltykernel@gmail.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <liuwe@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>
CC:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        vkuznets <vkuznets@redhat.com>
Subject: RE: [PATCH V4 6/6] x86/Hyper-V: Report crash data in die() when
 panic_on_oops is set
Thread-Topic: [PATCH V4 6/6] x86/Hyper-V: Report crash data in die() when
 panic_on_oops is set
Thread-Index: AQHWDCuMQ3aW2IzR1UuBUYCKtr2r9ahvrWpQ
Date:   Wed, 8 Apr 2020 20:19:47 +0000
Message-ID: <MW2PR2101MB10524CB8CBF3FE49C2EDAA8DD7C00@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20200406155331.2105-1-Tianyu.Lan@microsoft.com>
 <20200406155331.2105-7-Tianyu.Lan@microsoft.com>
In-Reply-To: <20200406155331.2105-7-Tianyu.Lan@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-04-08T20:19:45.6671367Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=73197f4a-2e50-4b6b-b494-c5b7595feb6f;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2069d018-3cd5-4b1b-f9f9-08d7dbfa2f4d
x-ms-traffictypediagnostic: MW2PR2101MB0921:|MW2PR2101MB0921:|MW2PR2101MB0921:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW2PR2101MB09218BE4B31DF3FD8D6A9730D7C00@MW2PR2101MB0921.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:277;
x-forefront-prvs: 0367A50BB1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1052.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(346002)(366004)(396003)(376002)(136003)(39860400002)(66446008)(478600001)(8936002)(8676002)(64756008)(66556008)(81156014)(8990500004)(76116006)(5660300002)(81166007)(4744005)(10290500003)(66946007)(7416002)(7696005)(52536014)(33656002)(71200400001)(110136005)(6506007)(54906003)(86362001)(66476007)(4326008)(316002)(82950400001)(2906002)(186003)(82960400001)(9686003)(55016002)(26005)(921003)(1121003);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JHNG894KAE/rFoUAte4/6X42aDFXRvCXpzPUkqy7Lx6Qd9V8lc7hL8G4HaUtk7HHmH30KKpVdEZ24FfanMiE/Wvjn42js/XBCW1/pHi9NMVTQg++pxGJg78S2ZtwFPFQlVDF9kcEUcR3ILyb+L+yJEoQHT5J3Nvw2IiqG1R7SZiO1GUr8IiyNjsZTceITHrVZjhxD2Ks+LWIgNJ+yQL3KFSIjPJoVBi7KS2HvuUlF+gJAVZelyLJtsPf4wPRbMEAa0G5IPcPcGIlljQ9FNF/rnb07vk09heAa080wRKygJ4tzvDhq8Ereo1aEG74T/SBVzEMzxo3388dw7EqSNgp++Xom0LeRAYPfErk8JWrA9wNbilpw+RFsZgxCiHS7sgqPYEo3mH/JDM7BcncSzlZAEnVpH0NAluD+SWjx8EucD8ZQ+QX8QQeIHPA2pJi5ExbIcGB6rNKqJp+C+MKNwIAzbjXiRJAuNRyMPq4tB4uHEZn72im7UdZgHTkUv2M11bZ
x-ms-exchange-antispam-messagedata: 0Ekn5c52LtJ2Kui1X6cgdqyx0+P5sfYzeqX++yFLOFpT0XX8zC7tM9jP1CG0Uso95RImCpGng5y8fs6nopNesaO+ifX1GmpLXxVw/RsGqozDk31pO7InjbVi/3Z+ZVk1JEXuI8P04PQbvVhTJCBCmw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2069d018-3cd5-4b1b-f9f9-08d7dbfa2f4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2020 20:19:47.6391
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: thMmeVQWNE56XlDRYqlH+YrvK8rkHZVdEmVoAtzSKfghuExHbBsopc9yOQsOP+01ExmKMZkUXsU69gpAl2uCkLl2RfIjEK/tz5H0b2BL+e4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0921
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Tianyu Lan <Tianyu.Lan@microsoft.com> Sent: Monday, April 6, 2020 8:5=
4 AM
>=20
> When oops happens with panic_on_oops unset, the oops
> thread is killed by die() and system continues to run.
> In such case, guest should not report crash register
> data to host since system still runs. Check panic_on_oops
> and return directly in hyperv_report_panic() when the function
> is called in the die() and panic_on_oops is unset. Fix it.
>=20
> Fixes: 7ed4325a44ea ("Drivers: hv: vmbus: Make panic reporting to be more=
 useful")
> Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
> ---
> Change since v3:
> 	- Fix compile error.
>         - Add fix commit in the change log
> ---
>  arch/x86/hyperv/hv_init.c      | 6 +++++-
>  drivers/hv/vmbus_drv.c         | 5 +++--
>  include/asm-generic/mshyperv.h | 2 +-
>  3 files changed, 9 insertions(+), 4 deletions(-)

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
