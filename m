Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5B8A6E82D8
	for <lists+linux-arch@lfdr.de>; Wed, 19 Apr 2023 22:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjDSUpO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Apr 2023 16:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjDSUpN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Apr 2023 16:45:13 -0400
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-cusazon11020014.outbound.protection.outlook.com [52.101.61.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9121E171D;
        Wed, 19 Apr 2023 13:45:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V587pXYfUgg79TKZ3PXlmEffEuU50vkbBcSWEwfHuTOCMXwPrgi7kjvsP+CGAWyt/ZM2laA1jmDxPU9J5U+FsdFtPPNFMGT3paGimMFZy9Q7V+kI09+94p31Js+hj/No7ZSMXuMfeeuDhruAWk2UFAvU6LxKl/1qwQjowHx3FBd3mBePETKVUpmKDUjBfK0TLf3d05t8ddHABxeMnhkkTtoCqf4thisPAfOGgNnC1JTQvM1HR+KLJpJodGaEM4+iKwYqMmiC1SUi5gFV3bQRCnPDPha09HhLPtoTtMGrc8qLNuZV2TzZIi7dvzL+joab0rU2YBpcVa4/0uWXKZmh2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rZQYNnsvN4sM3nBYVfhj4LpcgRTq4sIzGcVR22DVA04=;
 b=hnOJ/O0S1lED3Ys28MDY637qXxn5EixxT+8MI+WafWeTcfweHf0K1k9tnHnnSCrSntsVK3rXCxtdkBdTKEmXgdPzDJm5T2kEv/N3GVR5hN4RzlVKm+2TYyg5vXUnPqGAPMbM4gnDE9wC7sixNaCDNjHEaARELVE7BDTS5FMj5Pzj1nlFddl4GhhN7oDQIpTtzmhBnXJTJWtzWVd/6tNnRMRdEmghaybLVpEvJvnz/fyTTD0YXQ1uBQl8t5L1c9f4KX5aFQRvxZ3lrUUaq4/uK7O5GgFMccyP3YmOH55pG9wQWW+3xaiIs6XeLNN2CzkMiiGmXvHuiwTUFAE39eygbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rZQYNnsvN4sM3nBYVfhj4LpcgRTq4sIzGcVR22DVA04=;
 b=O4wcYP9icz/2lVvmGsZlPtMX72P90bIMx5A/U2QcKpt0Q1RVKYWcJX4dGvfXwjnYH5TW51YO2e7V6bIYwA+ZwP3o9hGMyfjhT/Q7nqTfeLoxwVAJk/BZmYMBe9ab3AvkNZMGtzPc/lOQnMxm6JgF1I0jV0O/hvyrC3ezrbbOwj0=
Received: from PH7PR21MB3263.namprd21.prod.outlook.com (2603:10b6:510:1db::16)
 by DM4PR21MB3658.namprd21.prod.outlook.com (2603:10b6:8:a1::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.1; Wed, 19 Apr 2023 20:45:09 +0000
Received: from PH7PR21MB3263.namprd21.prod.outlook.com
 ([fe80::4d56:4d4b:3785:a1ca]) by PH7PR21MB3263.namprd21.prod.outlook.com
 ([fe80::4d56:4d4b:3785:a1ca%5]) with mapi id 15.20.6319.004; Wed, 19 Apr 2023
 20:45:09 +0000
From:   Long Li <longli@microsoft.com>
To:     Wei Liu <wei.liu@kernel.org>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>
CC:     "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: RE: [PATCH v2] Drivers: hv: move panic report code from vmbus to hv
 early init code
Thread-Topic: [PATCH v2] Drivers: hv: move panic report code from vmbus to hv
 early init code
Thread-Index: AQHZbnA36uYZUGk2cUK4b/5QWwYrIq8sr9aAgAM4vwCAAYLigIABtyeg
Date:   Wed, 19 Apr 2023 20:45:09 +0000
Message-ID: <PH7PR21MB3263DDDD57A1EDD219CC645CCE629@PH7PR21MB3263.namprd21.prod.outlook.com>
References: <1681435612-19282-1-git-send-email-longli@linuxonhyperv.com>
 <BYAPR21MB1688377B56A9A844EAABEEDAD79E9@BYAPR21MB1688.namprd21.prod.outlook.com>
 <ZD2dxHaq8NDzpfYw@liuwe-devbox-debian-v2>
 <ZD7iT/+Uil3jTuNO@liuwe-devbox-debian-v2>
In-Reply-To: <ZD7iT/+Uil3jTuNO@liuwe-devbox-debian-v2>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=389cf2d0-3378-4a76-a574-1bd476db736b;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-04-19T20:44:34Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3263:EE_|DM4PR21MB3658:EE_
x-ms-office365-filtering-correlation-id: 04ccdea4-d764-44ac-ff2c-08db4116f755
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 87GbtMLl0L8hQZGKMbhuOo/qbu8yj+LSmAY8EqQ2taV5U6Ulp8cMpWaSdAku8Bh8evTb1LQ81ZA5sODDbbNokCsxOx6QkooWFn7EKnRqXXBP8UrqBUaFF0pQ+3Djpc49vzXpV8MC+50jIM1Gb6l8K6bp2mhseYkld68pfsJg3fmG1/iBZHKhQBAaqinjgNsjCxjsNKlXApiw3dKOf7JVW8m4B0/mkCzuoCNOfRzYmGqEwkIl5ACdBZK0UmZxro+ydkhk77pXdIGKUBGoxoJkBRik1hMnQ9ZlTyrZ1ZfUpMLk/UPmAZ9UaRhY0wUHJ8rQRr+36Y0crnzlaIU5eFbwwm5sSCjl0ZeWEQGwDK0+DneC7sEFh8FZqC3bEtJtX0r2BdksF+leMIwd41dtGBXPyzW7HfqvLXRTzlNQiZ8m+Ahvr/UikO5KDwxfyps/WeYY1H50aFj52t8ge2pKPsg8iFUB5/TyROrdmL0gXGuHDf1ZOIVXB2a6O1hMkcWsXZ59vT+teYUgLt5e8PIjU/WUh7IJ4ZA4OkOTfTeRoQnfUTNoljjuTk1kwPkUde3s7xoqi59oWMxnz7c1FlvYKU53cdUXOXDGSxlbjxI8K8gVcBuHpjVSpRMM2Hj3kXGhYP850/Uvo7kJrcx42exKVgt3keVYGIispj1gTtwoG1FGM9Y=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3263.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(396003)(376002)(39860400002)(366004)(451199021)(33656002)(76116006)(6636002)(4326008)(786003)(54906003)(316002)(110136005)(66946007)(66556008)(66476007)(66446008)(64756008)(41300700001)(478600001)(55016003)(71200400001)(10290500003)(5660300002)(8990500004)(8676002)(8936002)(52536014)(2906002)(38070700005)(86362001)(122000001)(38100700002)(6506007)(9686003)(26005)(82950400001)(83380400001)(82960400001)(186003)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?02qlVLgvlIP9airK4se7I7IQULdkCz/kVuw4QqtBClj0yqHmSU7S+WIxg5+K?=
 =?us-ascii?Q?GcXBvOrMcEhbKIn+bdTrR/vU6ayZaK+h+QdR9u6uSltqLoaTRm1qgTaaZhXw?=
 =?us-ascii?Q?ehE4gXak90IG6SlmVqzVssTiK6l/vrnurZch2gkKPB2lnuzJXuJ4ScQRHDNJ?=
 =?us-ascii?Q?CTPW89MNIsBmpx2ath0GwewdeYi6xckYv6Qph2a7ak3zDeB/xUkO2xJj4kar?=
 =?us-ascii?Q?mX3lkOlXdY59rXS4/BS/324loNH1PWO2SQ59VXLUPdmXbRDQz7tftL8f8+rp?=
 =?us-ascii?Q?6XoDV3QSbyG0xOQIjADsxRe3tZG1aFIPlX3JAkQSLDHZ5/epTAfMtZaUQskL?=
 =?us-ascii?Q?JHvOhrvCurWzR0Vdl2OuJcRvKVt95fMKsRBz/M0DpKSpn0FCKO/538rFj/HQ?=
 =?us-ascii?Q?CGd++zM2GJ14YqCHckyN51bANSWjNXWXyH+Lo1b2E//svRqahL+NkVJi/zIh?=
 =?us-ascii?Q?7BzFyFdT/bP3iUQD3xTgzY72idOCGkb4Qsh6kFJ0yke4Dpn7Wk3bOMrUp0LE?=
 =?us-ascii?Q?Dqj5JWFsKHXjYaWm0+ATMHU1nS6dCkCfrOlJk2KTvoCvWKiJtcpaQykvHZiC?=
 =?us-ascii?Q?P/zIfdKS8Cfvs2SP+inDmi182Ix1dlbZevKkhsm3py1Q8k+gCfwtVlO5OJop?=
 =?us-ascii?Q?2ibpZLduUBVOy6wNgZ6ygB8xG45wawZB1zUpuCNpqAJ4Fl608LV3PP+Pb5J/?=
 =?us-ascii?Q?3MBhN+JypslddypUecKJ0aUyC3aDomY7NZwXtW2QttUvaHCp/tKXwJpYGaMn?=
 =?us-ascii?Q?fjs4wlQ+IJkQuAMMzjV9fXLqiff2DelI/w7ifGNwTrnTrFhNXrwe9ivfiY9Z?=
 =?us-ascii?Q?h1wkM6JK6APOGxQ/2YMPE20T3oCrh2ejQFN5GEv+kW2QbZrLcD4rQLCmwChL?=
 =?us-ascii?Q?G+tHoN/RpeNZb/iFBK4ogsHDSdbn7tzhu0hzeYqde7NhR3tckUt1MGHIQdD0?=
 =?us-ascii?Q?mXIgz0sh/hHitKvrzi2GHMyOy+Cq3sIlPixJSy3FSsqoiJS+QlIL0UteBG1i?=
 =?us-ascii?Q?s2zS3HkPXS//3Kqf2Ghopl61b7OxQiyPL/i38+0VKTYALptNxGjfoITkJ8Vz?=
 =?us-ascii?Q?BkD96qvlbp5glRGtTjPQCLSNcbW++uHS0F/i68dMHUNq24pQYvPuNKmCQfgH?=
 =?us-ascii?Q?0VYWlVNUiqVFVksN6Sudc0xLGVoB+9gV+0j6Yb1r1c0UeIEGJ456/8Ny7QgM?=
 =?us-ascii?Q?u3KYEKj/7hezMupT20bUKMBsk/Ah6YkYvpL2JBXC9WYoj1jQF+figVo10Ptm?=
 =?us-ascii?Q?p5qJVwzz67x6dKZily+swhQpHd27GpdYNIMLl0Ks5SsTQO33aIYAJRofvC3W?=
 =?us-ascii?Q?LG3zrSrHikPNVUAH2qkMCJc/l4fvy4hEyo0CzVP0zpEebCMVUaNZbgrkAKRE?=
 =?us-ascii?Q?Y/BXVyOqnWzl8l6ezRz6nfxDRWcKwlxsf7Q5JjKirDgQz50DWmNoDh6YY0iT?=
 =?us-ascii?Q?Uzzi7v4KFdrC8LvkZqdQ4tfVuWLvX1MdxMDTPxRKfIiNq4V0EO8XbJ7WQppg?=
 =?us-ascii?Q?nlVNhFSTuBx328AJazmlFn0lAUCPqXxnhdZa7ewGYMVWn8IRlZV3b7u3R4Za?=
 =?us-ascii?Q?d8mV+Cc/oRUHF0QLSnT62P2B9mttd3RGvSdvn8vv?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR21MB3263.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04ccdea4-d764-44ac-ff2c-08db4116f755
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2023 20:45:09.7221
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: waPOWZKoRI/Ji1fAsNzMEOnKS7KnTZUvjDEzacfkkOQw80zvGNjRpqiKSQ++CL97AGH8JPpfuvIt5M66OyOV+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR21MB3658
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

>Subject: Re: [PATCH v2] Drivers: hv: move panic report code from vmbus to =
hv
>early init code
>
>On Mon, Apr 17, 2023 at 07:28:04PM +0000, Wei Liu wrote:
>> On Sat, Apr 15, 2023 at 06:16:11PM +0000, Michael Kelley (LINUX) wrote:
>> > From: longli@linuxonhyperv.com <longli@linuxonhyperv.com> Sent:
>> > Thursday, April 13, 2023 6:27 PM
>> > >
>> > > The panic reporting code was added in commit 81b18bce48af
>> > > ("Drivers: HV: Send one page worth of kmsg dump over Hyper-V
>> > > during panic")
>> > >
>> > > It was added to the vmbus driver. The panic reporting has no
>> > > dependence on vmbus, and can be enabled at an earlier boot time
>> > > when Hyper-V is initialized.
>> > >
>> > > This patch moves the panic reporting code out of vmbus. There is
>> > > no functionality changes. During moving, also refactored some
>> > > cleanup functions into hv_kmsg_dump_unregister(), and removed
>> > > unused function hv_alloc_hyperv_page().
>> > >
>> > > Signed-off-by: Long Li <longli@microsoft.com>
>> > > ---
>> > >
>> > > Change log v2:
>> > > 1. Check on hv_is_isolation_supported() before reporting crash
>> > > dump 2. Remove hyperv_report_reg(), inline the check condition
>> > > instead 3. Remove the test NULL on hv_panic_page when freeing it
>> > >
>> > >  drivers/hv/hv.c                |  36 ------
>> > >  drivers/hv/hv_common.c         | 229
>+++++++++++++++++++++++++++++++++
>> > >  drivers/hv/vmbus_drv.c         | 199 ----------------------------
>> > >  include/asm-generic/mshyperv.h |   1 -
>> > >  4 files changed, 229 insertions(+), 236 deletions(-)
>> >
>> > Reviewed-by: Michael Kelley <mikelley@microsoft.com>
>>
>> Applied to hyperv-next. Thanks.
>
>This broke allmodconfig. I've removed it from the tree. Please fix and res=
end.
>
>Thanks,
>Wei.

I'm rebasing the patch to latest hyper-v branch, and send v3.

Thanks,
Long
