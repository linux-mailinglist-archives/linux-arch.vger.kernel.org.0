Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9E58778402
	for <lists+linux-arch@lfdr.de>; Fri, 11 Aug 2023 01:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232848AbjHJXPc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Aug 2023 19:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjHJXPb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 10 Aug 2023 19:15:31 -0400
Received: from BN6PR00CU002.outbound.protection.outlook.com (mail-eastus2azon11021019.outbound.protection.outlook.com [52.101.57.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090C02694;
        Thu, 10 Aug 2023 16:15:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=De9CaRovfiwxGsmFH3uNbZNfon31Df39vdvt8ltA6wP3sPRBS88y7s0IhVROcpPW3JZAvrzowBunvDDv+HFxWCpUTvwd4j2wcpADYv77nI+c0vCip50A4tniB8lXgowhtjbSjdOudBJ9J2UhBWi8atNMAMhy5jVFh+ooprwqtGZ/LYlH9giMBtv+qh8RMImDKn1GlVS8xFW6/x9u1jr74Ue9X1XKKb5oQu+lGXC3ZCgj1Ek6jVrzkBbJ1WmYjRiSVGYb/YbruZ4beyhiIpgaEZxtIGgVzWzLJipnzfpQP3jIT7xhGRpyfUclRqX8KssSM0lMzP99IZCBV1Z5Lp9wOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IPphD0mJlrwTI2BfBIgGGLhNrmwlq6nF+a64L+Amn+I=;
 b=ENxHmh0TqapwAI5Qb8Vi8X1Ix+9EYxwlIB5GJ3DLU0Lmm/cqW2JBZbbDUhycgFcJKwH1n0g/RE4blNxNI4vsAm/5Lm7MivOLjnY1tLaM+30TUnLY1GJ6G1dFL2MYew37GwLCgo62YfdYAzlN1yxbd7bW0UDgh3y3XmraLGBAb1nWsmffe4Oyaa+ySBQYlx/w9vmkxsFsgu856j5hVvBGOoU8G8SP78Vm8XgDW3y46V034TAs2HRSzVCpFan1nXgomXLXvW3r59ZoRJCioCfCqGSOa8N0/mbnTqBe9Bh986LZ76FbcQu9cEkFvk0u2kq0qrNguLUv58HhH9Ty3Pgm2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IPphD0mJlrwTI2BfBIgGGLhNrmwlq6nF+a64L+Amn+I=;
 b=IQePO999Sdxgq68oENcyND91CNi4ql02+q9to+TtlSs+CwYNXS0HOdtGRd2lkbSJDj0g3iAXM/ZBUme+FcZqRVVfhZ/KJO1RT1qrPOSYCu4vk/ucS6wfeHqS4lpFLYeuKiBGWZU8YuRr5OqhPDuT99Av0bTDeHdsg0ld17TsHoE=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by MW4PR21MB2044.namprd21.prod.outlook.com (2603:10b6:303:11f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.7; Thu, 10 Aug
 2023 23:15:27 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::d4d:7c16:fa93:9870]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::d4d:7c16:fa93:9870%5]) with mapi id 15.20.6699.004; Thu, 10 Aug 2023
 23:15:27 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Tianyu Lan <ltykernel@gmail.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>
CC:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        vkuznets <vkuznets@redhat.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Subject: RE: [PATCH V5 4/8] drivers: hv: Mark percpu hvcall input arg page
 unencrypted in SEV-SNP enlightened guest
Thread-Topic: [PATCH V5 4/8] drivers: hv: Mark percpu hvcall input arg page
 unencrypted in SEV-SNP enlightened guest
Thread-Index: AQHZy6RZfj8+SZAvtE6uKuux/tfw96/kKSng
Date:   Thu, 10 Aug 2023 23:15:27 +0000
Message-ID: <SA1PR21MB13357158D0A64F47DDAC6BB3BF13A@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20230810160412.820246-1-ltykernel@gmail.com>
 <20230810160412.820246-5-ltykernel@gmail.com>
In-Reply-To: <20230810160412.820246-5-ltykernel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=e8be2fc6-a0ff-4ab3-9f56-c931800c19f9;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-08-10T23:13:07Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|MW4PR21MB2044:EE_
x-ms-office365-filtering-correlation-id: 7dcfe40b-b3bb-4c5a-ab17-08db99f7aef4
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jzXUozsLm0sTtHfjytG7bodf3JfnxbJlLTn5u0eAwzcRWi8ZRnJyObzxjkkMm1tUQYJmq9LGnqU0bCoDff8ldqNyGMv/KmqEBXDLszE66dsnG5Szojtajaqo3MKD92IQuRlwaI1D81FgLW/mCB0jblUPp08srbll04v7w3ojkfUXQW4B6HuoHmmG+1yBPQS0/VrsFBLoiMf0Evx80PR8ARM8sSjKdtoHrM1wm+fxv4nzMoiobOw1eINiTjKYmh3MpdhHbioGbjVhCcGN6xX5z9+ro4RNBFxXSrhdUXNQlWPp6zD+ehPzZ67V6Tr1DX/A8E0JrqrI1hgdLAReoJTfEZxOKbAAcKC/1CAz5Mdra1mbV5Jnh6tOiGjL6k/aEmKs2fjkbxmwkj2hiAk4xqm2c1CznHuPw7IIE4hfuRTnZ6E7/Jzbbbc5jAX9G06ZPpO8wsxvkXTJev89TeHds9IW1O483pwjg28s7LEUTLk+HH9HOhMoNvlbDABnTsM74r1XbPMnc/XJHuQNPZDFZhL+OQo+Ll167x7REAtIqHhekz59IpAG/i1cdlSctHkqmhuoy2lQwH2jpVR1b4bmqZTCZEHzL8kC0KI/51/hmduUDTGveAe4wcfBpPlcSGdCAaFEs4J/EgmZDhdxQJUiH6eTKI0mEn61xYY9Li/PTHoVZSpIsYI4MW2lzgLts2jMnrOrQKPsqNRA1XTEDdDsvgIvBQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(366004)(376002)(136003)(346002)(451199021)(1800799006)(186006)(55016003)(82960400001)(82950400001)(38070700005)(83380400001)(38100700002)(921005)(8990500004)(86362001)(122000001)(10290500003)(2906002)(4744005)(110136005)(54906003)(478600001)(33656002)(66556008)(7696005)(9686003)(5660300002)(41300700001)(66476007)(12101799016)(6636002)(76116006)(66446008)(4326008)(316002)(64756008)(66946007)(8676002)(8936002)(7416002)(52536014)(107886003)(26005)(71200400001)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mNWN0EJDj8+acitO32H7du8ui8FVEc5+zqbr+j0wfvftDKPl+eCA0Se9ArmQ?=
 =?us-ascii?Q?fLV8Th0HQWctec+uBfYSfh45HtAtuIfpIaorb4QNlkafeLmyxMoLrtrSBqeU?=
 =?us-ascii?Q?0Sc9Swhs8jFoVtXoDivzJTCU2k3mIV7U+Tmq5W8ltQSCLK70XmEEbYUS8pT0?=
 =?us-ascii?Q?hI8+bD9OJBU7AbjiTkfOlVrCmWhWyvuboNLXb9fqZD/tKLEnywUxZZkQU9zF?=
 =?us-ascii?Q?hagFdujZUGLqFilLOIFH6+x8o+muwmokku4U+jBKzustQg8PA2Vavj5mdEUd?=
 =?us-ascii?Q?uuW6H0lKtVsc7jdhn7kXpROx7jfE2WcN9MOhtA5FiYnOBsRmhWQQF6UdiIhm?=
 =?us-ascii?Q?6qjylOOrq1AeGzr7xFVfDDomdwojpBt7bTgnrf0/XJtCYS37qf2M9f0ijvLh?=
 =?us-ascii?Q?DvCLPWk6vyi0P/Y+hC//rGgOMAJSSqND1m/lhXnbumPKKVo+Lcm3JYrtjBGb?=
 =?us-ascii?Q?mY7d+6wJCWrxG8NsMsda0PBwsRPCrdqAReGabzweZag+vj/Io4wCZrIO7jp2?=
 =?us-ascii?Q?VMtFS1tKQSWUPrDNUJdPsDxD0TMdik2lRmzw1dCw0L4wqTOxy3noAQ3fbrRT?=
 =?us-ascii?Q?nBVgD54fKCIxyQ8fFOW0j5dg/2/zrujguqIZFa43cJ/hOhYoMQzTgYDuEF3R?=
 =?us-ascii?Q?fT4ubeWVQgXJR8uDxiEdrVzZaF4HO9E3Bs5iMdujb86AkyeWMwGdkAIDMlP9?=
 =?us-ascii?Q?tzhaI0NMB0uDT8n01jiSyT6Xvbtuy+L6qFkGFcUdLpEiBQEY7MTg8qEBIDwq?=
 =?us-ascii?Q?jVgE8POCCcc5giArmAjQmTZ+wJ6T2pBCpJoGbQBQQB8W7pNZUnlxe/AASc1k?=
 =?us-ascii?Q?0GSrnaB6SCjSQamXVwnsl10mmGlVTBUSCBT1nP+7clOpyZKQaJ1fEWSd9jaB?=
 =?us-ascii?Q?awiXEzQ+hUHNNqz3oJGoj06TDTBJ0Iak559QF0BZxm9RxJ0ICWqzPRnF7Q1U?=
 =?us-ascii?Q?zm+rU2uQ9Nh9kQgFEx6sUM3mJzTQPnGPF4CgxH+BAJm3JiUNlvbcnzmAMR04?=
 =?us-ascii?Q?S/A7tDkGrAME9dCCD75I7IVnCrcf66593y74JZqvxyE4PBIf4YGQLQa3eS6Z?=
 =?us-ascii?Q?p20tQrxubdAIGxcPlXFE6DbIb4O7mXGp+CyPdTWrGTk9rBIHR1uM0xxzT4I8?=
 =?us-ascii?Q?rxOogb5XoOH7dFHe/jiy1zKse2h2eS4B46ZVhH6w72NCsPSUSORWcKHixyVt?=
 =?us-ascii?Q?3SLqMGMWR7VZWG1OfQJGO7BM5txNTWYFnvLcs+S0gMZV8Dn3LaAq5qkJVLD6?=
 =?us-ascii?Q?F0dx0u68pZa3LdIx+R9Twp1F0rFg8PzGNh8RAbSb2WZYjMcGqWtnNSQXlzCn?=
 =?us-ascii?Q?Dkm5noi0sLlZqCZIWKq9qYzqxwCxOt79stYBP+9JeZp/XpPhKn9EQx/5Nr8T?=
 =?us-ascii?Q?HqJy+eUcT8Tt6Oj97r47b5UAXdPXGuZFYjAFr4Ng8MGtCOnUQif4xHxVqL/D?=
 =?us-ascii?Q?joBc5f+8nDC0SUdmesH28QSaVsJS7I9A7Rb2zR1d/0gTwfVTSJKXsqgr7c/1?=
 =?us-ascii?Q?XHYWtSrZ2/CaFBc1i72kGqnGUAADL7jktyl+fUWPPZOz+YNpVUS/LRpr9K9o?=
 =?us-ascii?Q?sItA4OxkP+WKr+yTYI4ghlTearTXE2xTMTzwL+NK?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dcfe40b-b3bb-4c5a-ab17-08db99f7aef4
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2023 23:15:27.4234
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bh+uyjtm+X6LS4uz9VAo1VRRfT2wJztg4pycKlCMKpMgMpNaEDRbkkoPHVMHpS46345VQohJATRCmcE3AjGRsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB2044
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> From: Tianyu Lan <ltykernel@gmail.com>
> Sent: Thursday, August 10, 2023 9:04 AM
>  [...]
> Hypervisor needs to access input arg, VMBus synic event and
> message pages. Mark these pages unencrypted in the SEV-SNP
> guest and free them only if they have been marked encrypted
> successfully.
>=20
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>

Reviewed-by: Dexuan Cui <decui@microsoft.com>
