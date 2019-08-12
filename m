Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA9D48A671
	for <lists+linux-arch@lfdr.de>; Mon, 12 Aug 2019 20:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbfHLSmV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Aug 2019 14:42:21 -0400
Received: from mail-eopbgr800120.outbound.protection.outlook.com ([40.107.80.120]:40800
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726090AbfHLSmU (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 12 Aug 2019 14:42:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KwUWtl/jY+jx8KH5HFjXb4v8kszhtGfnLLa+Td53HFPGwpmzgof6u+JyY0O44mqeSDpNxlHkSHGWgQwGyRyPczJTbXj5kg3dMI36UuYr2TdqS7dWnHxf6jv9IxGI9pmqoVajV20TFx6V0vFS2p9A61li4BamLDt598RCLhD95kcjQhpRSmtR/PJCXRFqdfIWZ0UMYDOd/0GFohf+ZCHqPjh5ddI4N3ABtgNRWvOdRP58iuKP29tH/9CnPu+PiwIdztCbRAo0ph84h40h/YpQ3MUK7i1VFK7nhYhoN2NC++6G0GYWrOZqUj1uPZ/8XC8zFAosmuoKce9+UhI1HNeEdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cjH38107+ukbM+m4bfRUwdnJgoOpsmCjMKQw6qinwJM=;
 b=EhfnwoVGmafPeNSgSX0CjveetgIuPcyytfSetQxPOoZqkQY6LI93tW5hsf4k1W97xr177YP1yM6ERbqzepiieomtmpht66UpwOjGikNjMKIlodtze6qrYrBi5KB9q8tfSL3pturXeKF7FdtBRwI2gPeK/yHnV5P+ILlM9DlUmueqOXBjvC+i6dZlJG9PdCuc+gsKqVwdH06d8Q7LAnFCcCnb6GLUb/SQMvwOphBTfvV/ydtRsdQeDwD0k/67IHbIjNNEAl/1UQTNkUjokbI9Dt/Qh4PLGDvegxnXjlLpU75Y3upytj0FoCo0VnxJZl3t6G/w3TeWBfSzb4l6XUZb8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cjH38107+ukbM+m4bfRUwdnJgoOpsmCjMKQw6qinwJM=;
 b=Y6+sszg80TLKy+vzxkOxC1aExlQOmyDIGXctUbqYtNAL2I6UQ+M4qlH0S4ShkNyWtY6LNueK+69cpaqx92cLW2UariIBobuO+2pgrOnEplzTNd4j3QA0rvUszbGj7cRf2xZKjDfXHVg7rA4r9BBfS+OGoimgor/jwFZ7/NQKcFI=
Received: from DM5PR21MB0137.namprd21.prod.outlook.com (10.173.173.12) by
 DM5PR21MB0764.namprd21.prod.outlook.com (10.173.172.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.2178.6; Mon, 12 Aug 2019 18:41:38 +0000
Received: from DM5PR21MB0137.namprd21.prod.outlook.com
 ([fe80::9558:216:27ca:5dfd]) by DM5PR21MB0137.namprd21.prod.outlook.com
 ([fe80::9558:216:27ca:5dfd%2]) with mapi id 15.20.2157.011; Mon, 12 Aug 2019
 18:41:38 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     "lantianyu1986@gmail.com" <lantianyu1986@gmail.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "ashal@kernel.org" <ashal@kernel.org>
CC:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: RE: [PATCH 2/2] clocksource/Hyper-V:  Add Hyper-V specific sched
 clock function
Thread-Topic: [PATCH 2/2] clocksource/Hyper-V:  Add Hyper-V specific sched
 clock function
Thread-Index: AQHVReKqPvPCosA5s02OPHGb8bfYZKb37vnQ
Date:   Mon, 12 Aug 2019 18:41:38 +0000
Message-ID: <DM5PR21MB01371937B0E72671C4B7C990D7D30@DM5PR21MB0137.namprd21.prod.outlook.com>
References: <20190729075243.22745-1-Tianyu.Lan@microsoft.com>
 <20190729075243.22745-3-Tianyu.Lan@microsoft.com>
In-Reply-To: <20190729075243.22745-3-Tianyu.Lan@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-08-12T18:41:36.6177014Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=5c6862ef-aced-4cd7-9a8f-9ce8de1d440f;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e26f9ef9-302e-4cca-5fc0-08d71f54b5e3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600158)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM5PR21MB0764;
x-ms-traffictypediagnostic: DM5PR21MB0764:|DM5PR21MB0764:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR21MB0764E38AEF2127C1889F4638D7D30@DM5PR21MB0764.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-forefront-prvs: 012792EC17
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(396003)(39860400002)(376002)(346002)(136003)(199004)(189003)(6506007)(256004)(71190400001)(8676002)(2501003)(71200400001)(9686003)(7696005)(74316002)(81166006)(86362001)(7736002)(33656002)(6246003)(6436002)(110136005)(26005)(8936002)(53936002)(55016002)(8990500004)(305945005)(99286004)(186003)(3846002)(76176011)(4326008)(10090500001)(54906003)(4744005)(229853002)(81156014)(6116002)(7416002)(5660300002)(102836004)(2201001)(2906002)(446003)(10290500003)(22452003)(316002)(25786009)(478600001)(476003)(66946007)(64756008)(486006)(1511001)(66556008)(11346002)(66446008)(76116006)(66066001)(52536014)(66476007)(14454004)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0764;H:DM5PR21MB0137.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: q1jqyBBHagg1W206lzd2qBBSzkbP9NFwlxJ6mePFvmqxf/FwZeuXL3Qv9GR6DzF7JLRcgmn5blxcRc718ejBHkI/ejaXnVw+aD2DN4uI6XFs/EzBgGADK9502G88zhPAuN9/27ZSOK73NkxIAuRXbQ/IflGBwXmeHfWd1WJA4c18+FJCLzP+1w/j5q+pj2SWWaHca+w5AgwDbFCDFX3YgwVHB4BMS3Wx9GEoJ8FtiE0Roky2NhOxGXo4MGPfbgkg9Mm4Q8Z6xi+alQfP9jbeJSMYoExjE2O6OtWCzM0khpw/FyZhTlRsDhlYB6b4fTnB26w7pm8bCK25w4s+Fy5d9m5yJDTYXj95a6ZSi8CT3oUAIlJUFBNG1fQUyTjwIvch9dgZbFHlLHhK76ne+JBXmkTaaQGISPrG6k5RqzYdXbM=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e26f9ef9-302e-4cca-5fc0-08d71f54b5e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2019 18:41:38.3516
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gyr2CDaMiveqLbpXXrVrpgpgMhG1RpQ06UmPP7fUB9hkioIVNlXEVViJz6OKvkBrxQ2My9gcSFrvgm3RhAZ0mzvrFMlIs0ReYWl/sWksqk0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0764
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Tianyu Lan <Tianyu.Lan@microsoft.com>  Sent: Monday, July 29, 2019 12=
:53 AM
>=20
> Hyper-V guests use the default native_sched_clock() in pv_ops.time.sched_=
clock
> on x86.  But native_sched_clock() directly uses the raw TSC value, which
> can be discontinuous in a Hyper-V VM. Add the generic hv_setup_sched_cloc=
k()
> to set the sched clock function appropriately. On x86, this sets pv_ops.t=
ime.
> sched_clock to read the Hyper-V reference TSC value that is scaled and ad=
justed
> to be continuous.
>=20
> Also move the Hyper-V reference TSC initialization much earlier in the bo=
ot
> process so no discontinuity is observed when pv_ops.time.sched_clock
> calculates its offset.
>=20
> Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
> ---
>  arch/x86/hyperv/hv_init.c          |  2 --
>  arch/x86/kernel/cpu/mshyperv.c     |  8 ++++++++
>  drivers/clocksource/hyperv_timer.c | 22 ++++++++++++----------
>  include/asm-generic/mshyperv.h     |  1 +
>  4 files changed, 21 insertions(+), 12 deletions(-)
>=20

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
