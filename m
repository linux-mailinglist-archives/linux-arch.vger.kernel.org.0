Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E69FC771331
	for <lists+linux-arch@lfdr.de>; Sun,  6 Aug 2023 03:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbjHFBxa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 5 Aug 2023 21:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjHFBxa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 5 Aug 2023 21:53:30 -0400
Received: from BN3PR00CU001.outbound.protection.outlook.com (mail-eastus2azon11020022.outbound.protection.outlook.com [52.101.56.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7442110C9;
        Sat,  5 Aug 2023 18:53:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gcamfaatu4Qosu2whZ+sqKg9ofY4xOyvJZLBPctFERiBbMek4hG0uygSV+Xu/t/kzZniO2XYm+XDMxRqnl4ztB4R5cf+MzHtltzXYnptpB+FXf1jlGiLluq5FR//XXTduycSrQSQJkHbjsP1XHQcwZAv7n7vCBvJkYtBcyISe675M1KjnBWnPwGYfsM3dMIz45rai1c5Obrr59LpDZfXoR4czlJLaXrL3wORUsQCKPGAzc/bO/73iRndBlIjbCdZVdqgpdXRWGiX1j6AvoE3kTqpXF+alUofEzyi4lQG10h5xa1DX/S6qxD0WvenDv8MuMn9/aKynus9JOkmfZYhcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+/SYCJhweDLu4BdJrhxhAbOwyJyaRFxtVAu5MXxLuOk=;
 b=OLJ+gJMw/r4030MbY9R6SC/CJ9tyctxWccJPWfB13m/vwlyv9iVcws1lE0lC7kaG3hmxZsYf/vZXZhcO0IGkSu4Bu3H1l021kZYOLMcbVvodVsZh8wQ715qydoHx56vTmHh1yfAdRXkb+ytiKBg8FMfFZTUDimfCqqbjn71DkqFV/4cKV8KDpjlvps1i1Mx9TdxnAuBEXmCNw7v07hwUJh54GnFB0jbvSIcozOb+JzPdsNGgA4Dm02AHP08/0glEAqCFpmqhd+TI+fJJMmqcLDMND56StqwzNvVxVZJZvXtlMJyg3Gmq6XmZ71rDleHtKP0DeiJ08yxDajB60G6ZqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+/SYCJhweDLu4BdJrhxhAbOwyJyaRFxtVAu5MXxLuOk=;
 b=KI3cQzqSffawETMzfv1eL3tEpx/iiyghCQ14FxZ6OWdWffsw8Ww0sWINatM6kRTh9RnmrYOnbl7umUrje88ifnD/GBBMWP8CA1pCTGSUZq024i9UCJAIxqPAj22m80IxeaXdXeJejNDEFJQmm7c6bjXsZUB+U0ou4DpGxoTLwqk=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by SJ0PR21MB1901.namprd21.prod.outlook.com (2603:10b6:a03:294::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.0; Sun, 6 Aug
 2023 01:53:25 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::d4d:7c16:fa93:9870]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::d4d:7c16:fa93:9870%5]) with mapi id 15.20.6699.000; Sun, 6 Aug 2023
 01:53:25 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Wei Liu <wei.liu@kernel.org>, Tianyu Lan <ltykernel@gmail.com>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        vkuznets <vkuznets@redhat.com>
Subject: RE: [PATCH V4 0/9] x86/hyperv: Add AMD sev-snp enlightened guest
 support on hyperv
Thread-Topic: [PATCH V4 0/9] x86/hyperv: Add AMD sev-snp enlightened guest
 support on hyperv
Thread-Index: AQHZxyxCzsivoayvP0umqaqQjq23k6/cXC9AgAAmrYA=
Date:   Sun, 6 Aug 2023 01:53:24 +0000
Message-ID: <SA1PR21MB1335D15E810C505615835D72BF0FA@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20230804152254.686317-1-ltykernel@gmail.com>
 <ZM2LDKrcXvVUVta9@liuwe-devbox-debian-v2>
 <SA1PR21MB1335A21D5D037FE88D9CF820BF0EA@SA1PR21MB1335.namprd21.prod.outlook.com>
In-Reply-To: <SA1PR21MB1335A21D5D037FE88D9CF820BF0EA@SA1PR21MB1335.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=37bda7a6-2038-4d7f-8679-761f964c4b79;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-08-05T23:33:40Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|SJ0PR21MB1901:EE_
x-ms-office365-filtering-correlation-id: 9f4b3dae-895a-4420-9d42-08db961febd4
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3u63/I7h8khU+Dth06r9s7+Sr75PX5PjMCj6zLHFX1sBi8DK+wDco1OGiZ3q3nijhDDSWMMh7R3qlqcwPBlkL6ZH/mke0SyCMrBclbXoSPIdRWJuu4PSx74fZLCLd2cvP8CeIIF8rJTg+bQge4mdu8iwDu7m2qNBcCFnIUcN5ed6yqAjMZLitTRo5uXZgBif2hofq6rhUaoF7JRPEoUJHTSP20g2mR+bhbvUcgE1C7gjanPYxxLUrYIB9oNmWU2PfyYDE4ClT777jG+cQZck7FpDFGMyeOytDLAY80nZ7QuZSuix4nSpr3x9w4IhZR7g7FCDpLKj7yX5NSt8yxjsbkDpyoq+1W4ovWgX7pLe3QssRFFL2bgK7up89wADi5zUvq3LuDWHzspiTeAucQWkz6Qc6HdlcwWBy8QijWA5KkbFYbEg1OJG8pck/nczcKiNxrBbS0RIL7NDm4qV+dJh+iQNVlZEQMqyiLNrJKFepAmJWsy0FzIC1waNXfyGi91svr2o328PS7wm94TON0kR02obqtx0lYncDXS5sY8Bqx6wDVScJBRhiVkogp5GJbW1HP/qvayJnszhAXZnCcAQ0Qw5aGuFE3Eoqyjex9jS0rOa8L2jeU/mMttWIQhe8iyGRJ2LmRaQAbPiUES8Sr2lMhDlylpTdd99683189Gm9Z1+66joy7fd0EnodzGl5Yqa
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(346002)(376002)(396003)(39860400002)(451199021)(1800799003)(186006)(7696005)(9686003)(478600001)(110136005)(54906003)(10290500003)(966005)(38070700005)(33656002)(8990500004)(2906002)(5660300002)(4744005)(86362001)(52536014)(7416002)(8676002)(8936002)(38100700002)(82950400001)(82960400001)(122000001)(41300700001)(6506007)(26005)(53546011)(66556008)(66476007)(66446008)(64756008)(66946007)(76116006)(71200400001)(55016003)(4326008)(786003)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YzCp/0BBvNVApJgxy+OLOcKsEzZxayR/zw9aU4dzaqypmfHI3b3e1LodetEb?=
 =?us-ascii?Q?h67FB1WzUgpiS4L7dBkltrGFSFa3WCHaPfjaSa0mMEcqF/s+Ce+QR4kmLC4y?=
 =?us-ascii?Q?cpNm7YZdMTnLjs43EhEiqqO234MHwUWXstD5vnivtcP4kluCNspMbbhO2xlO?=
 =?us-ascii?Q?ZEyARJXLYzxPoDIFutBZzhXyemqN1IB75xPUVk9gFExlwoeR2xTaAevQbIyL?=
 =?us-ascii?Q?Y/tOKK2cly/yPywnWZDSTMaNQz/0lEfxpdUssyM2KcVqr8tZkyWoExwDrJpX?=
 =?us-ascii?Q?cFEMRqxQ8Pj1p4B8kultcYJudpZPIVceYXJOJ+SYqNk6yTnjwTVgEEo5TgEp?=
 =?us-ascii?Q?VgcYBEdtm4IYLTUvFb2/7AX9/bWWNV7r41300wrYxJe6NGfvdm2MlZh9/ocE?=
 =?us-ascii?Q?REGkpX9y3DOkNBMQiNCV6vfHue8hraVIAHLBot047sNjiqd/pOXXkPVDzrzo?=
 =?us-ascii?Q?pelSzxdRyQ67rHrruT6psFLUI4FPbYI0KFyKDiRTi4MauAWpfkMAmibe/6ER?=
 =?us-ascii?Q?fw79vYxuUOAEcdaOu0Kn/yaMRnkQ0ReeTJD5tsks/14YqBZFPKNMJFWT6I/D?=
 =?us-ascii?Q?Sq09t4F38ungbC7Tp3aHQs+0pwWRSNm3Au6Hz5Yc7yGZK6u6EiRJX1vcsOth?=
 =?us-ascii?Q?+3f2QNHWifhLUG1TtdY9WASN3AT+RHBqP0s2sTxNfQ/pXirSXgJpjb22HTra?=
 =?us-ascii?Q?St8VFG3WFhtZkmJa45NFgaJG/2iorbwMLfZ1zQJE3ZY2XQf04TrhiC5W5Qvs?=
 =?us-ascii?Q?rSg7JTrr9hBRrCGJ1hXgIA1NZnGZMOMgpMGDylvcd+1KFEAwMt+4tBymEh77?=
 =?us-ascii?Q?cOEXrrQBuZfeXbEwVBrHlwaviBpSc3ZsBzRkJwkZ1R/bDqRE9BaHcd5WhQcF?=
 =?us-ascii?Q?AWEVEEb4tXVhiiGkA1u/PvSjZWv0+AuACEqNdGmDwt0QWz85XNVvjUgclKDJ?=
 =?us-ascii?Q?9K/zLHnus/zC0ICImfFAIBywEW7TmBz8agrL5X0DZde4ByDOGEONiqftEbiA?=
 =?us-ascii?Q?/esTqVEmsMqwlKSpCWQnosYewgB4xHkgPmF0BNZbW4zK24zBt6gnzJquJH7x?=
 =?us-ascii?Q?BoZhh/oAQdd/y0v539DhOYGgseYek86eLl2opZMxQgJq4HdRVYbvlwaIoFXJ?=
 =?us-ascii?Q?W1iKs+QGVpe+gep5YhYmui/0JKEnb7wlRXuYY571d5scG+Py2HKeaEAev48i?=
 =?us-ascii?Q?1HcwOoUWd3LP3LNSfwm08MpeT7erJOtpfk1OAYJUif9aFBjTVWiwXl2KFpNm?=
 =?us-ascii?Q?e/Ut+ZZrgGMiouMDI32iJ7bnyNQyd1FKdN88K3eGE/wZ1JyQnOCy+GXPlv76?=
 =?us-ascii?Q?alEGikQwRBaaOlx0ZaD5HaWRjCqCGygJq2vAlAlV+wbMKYGiO+iHchxLKGTa?=
 =?us-ascii?Q?mfLOlA3Xy6HLUz6e48IfCvk3Rc9uFGJHi7fsJGxNSCqc8qhCf4108XT6wrzU?=
 =?us-ascii?Q?FqPNlHtWsR3/sU4ok7P+C8qnhjcJ/MhRWu2eMppF9R12C27jhOXbx+rIQOXp?=
 =?us-ascii?Q?HqxKMqOGP9LZBhiux/X4G7dm5JFKCYE7aXGXebD+ehPo6pJkna9nOdIZ7NOk?=
 =?us-ascii?Q?qexxkEeNu0bVppO115fslbA+GBu6uBXhY205tTyR?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f4b3dae-895a-4420-9d42-08db961febd4
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2023 01:53:24.7447
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R83+hCrbyua1PN1k1suybUJpQQVLAvEnBgVsCnQs/KTUr386PRl2Naxf2h9dRzBUrT0aQkIqkwri1BBe7+rdbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR21MB1901
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> From: Dexuan Cui
> Sent: Saturday, August 5, 2023 4:37 PM
> [...]
> > From: Wei Liu <wei.liu@kernel.org>
> > Sent: Friday, August 4, 2023 4:35 PM
> > To: Tianyu Lan <ltykernel@gmail.com>
> >  [...]
> > On Fri, Aug 04, 2023 at 11:22:44AM -0400, Tianyu Lan wrote:
> > > From: Tianyu Lan <tiala@microsoft.com>
> > [...]
> > > Tianyu Lan (9):
> [...]
> > >   x86/hyperv: Use vmmcall to implement Hyper-V hypercall in sev-snp .=
..
>=20
> Unluckily this commit causes a crash on Intel CPUs (see the below call-tr=
ace).
>=20
> I made a fix here:
> https://github.com/dcui/linux/commit/c4db45f6256248435b2a303b264ecbb
> 41320c41d
> I guess Wei can squash the fix into Tianyu's commit in the hyperv-next
> branch?

I also made a patch to fix the ARM64 build:
https://github.com/dcui/linux/commit/a559709c612de2a212e288ef1a8b0abfabb168=
e5
