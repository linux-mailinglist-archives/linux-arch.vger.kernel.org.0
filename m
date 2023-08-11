Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B07D77849F
	for <lists+linux-arch@lfdr.de>; Fri, 11 Aug 2023 02:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbjHKAlp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Aug 2023 20:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbjHKAlo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 10 Aug 2023 20:41:44 -0400
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-centralusazon11020027.outbound.protection.outlook.com [52.101.61.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8AAD2D55;
        Thu, 10 Aug 2023 17:41:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ovm/s4kI+kFTbFsi78PKciHbbkckl8rTpr6eMnVBr4ennO8mzTlYbw9ZrTBaoOErQ9nU8gaP/5O/Zr0egPEQxrP2dsd0AQvf3P2xOcQ+cXHab356rAjrN/NaeSKcBIVHNyUwDYdh4Dq/nx+x9hms55q5huPt9Sg9OtEAF+LGExAl1yEANTgAXFdFlOm38h49b5KKmvPMjS++8tWGN8I5SeO1+CRCZdw2iM442OsM9gOiAfhx4zmDDpYi6ZjyKf4J4PGzIdSjKmHaT1wFvG102YMLPAKy1OOf93j9YP6LrXRI2nVNX0gj7tAoX5nVMeqQH/kmm35TgkUywAr7dXs6ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oBkxf0RD79VczzInFbz6nIWbHrHe2uLw9gH7BV8Ztds=;
 b=aS+izWFEN7cHUxel3cmEnnGasnkqSHFR6HE46V0jfVFmZsymcM0PaEi5NytxrS+s8JvGnH7AEX+mtxlcM60owGmSxU6abMXuEftiMpaGoEdsVuFJNCchLywOs912RVmMw2AzDyG5ubTdFhioOzG4Xc3V2YJtMrsNfqRDrJkS063wZ3pAEVEndFW5Xs9LxMWKP7qvvY3iDeL63UnCzKdU9kzyXYYj3YQ5uf7IGgHmr7d25yGrnutwRr05ao/of3mGtfpSN5RA74NeGVEeajdB6w4gddwXUQnzQlRituQRmE5feD2NqiMXrzO8dw0uXJhw/MNSzAbgn7hrD8kFPKDvfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oBkxf0RD79VczzInFbz6nIWbHrHe2uLw9gH7BV8Ztds=;
 b=IepJP20U1xKlcb6+esYyGdYbOYm9ybgr3MCjD+4kBppZzo3+zxbuTdp2KMMhjDIVgfUn8nr+TuyPO7RFOQuX1gPY5tsiSfLDhNSyQv/NCj5PiqKj9tVn8gnRio+iwo0uLtYf1xLF0klic6pV2CQdaLE21g+idoG/UrtArstpjr0=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by SJ0PR21MB1933.namprd21.prod.outlook.com (2603:10b6:a03:291::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.7; Fri, 11 Aug
 2023 00:41:41 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::d4d:7c16:fa93:9870]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::d4d:7c16:fa93:9870%5]) with mapi id 15.20.6699.004; Fri, 11 Aug 2023
 00:41:41 +0000
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
Subject: RE: [PATCH V5 8/8] x86/hyperv: Add hyperv-specific handling for
 VMMCALL under SEV-ES
Thread-Topic: [PATCH V5 8/8] x86/hyperv: Add hyperv-specific handling for
 VMMCALL under SEV-ES
Thread-Index: AQHZy6RhPBYrrI8P7UWrutHWJPbAbq/kQckQ
Date:   Fri, 11 Aug 2023 00:41:40 +0000
Message-ID: <SA1PR21MB13355EA2AA95AF3237F1F0ACBF10A@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20230810160412.820246-1-ltykernel@gmail.com>
 <20230810160412.820246-9-ltykernel@gmail.com>
In-Reply-To: <20230810160412.820246-9-ltykernel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=fe8b1ec8-dfb0-47dc-b379-8d02b46cba06;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-08-11T00:41:15Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|SJ0PR21MB1933:EE_
x-ms-office365-filtering-correlation-id: 59d214aa-b9aa-4b83-ffc2-08db9a03baa4
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ids7VSVsRad33i8/o7w5JO8ieV96pQsm4euSaIlzG0JAzWcehsX0SyiWCoMlSCKx0JsPD16HNshXwW0otDv2R3kJOdJ3aL5/FGm/6gJzJYPFCmoW5NsYXsIM2+KLAmyx0woyJTVseu8rIzitJ7eBhj7pY4SiQHNEPvS2+f0fmleB84WT2uRx0XvDcVsViiglo5jcFx1kslQ5o48fRAKMTmt8TXkA7zSlfg6Xm8NSBWQB1R5pHfNR6nEbes2nZeXYPyHoOsrg4e3MdFeL6kAfrATSAE/ojlJsIgbKne2Pq6UE659bvFkQ2mbKBuQVYsnDRRGjrTu7mvI0AqjeS/PGJ8IBiRp7iliQXHiEMz1KrgH7LhErmJ3Sc2G9lZLBxzwInpvcYKoI3iAftOixKOuHsp64BxoM8QOLB0skSgkUgMXEXKqrHxbfW3FBaDkTWqoyeDKOnQShl6g99Nm+waNDjWIHrOGvia5JM15Wsc+T7Yg05oEacGC/F48mWG6wwW7bQUZFsiO0ZntzXN3VkTGI5AVJnpysrNBFRirbLOlriTjP88WGlbbrZI/i9hCkj9JwMl0uiyLUK6Gg+xqb7POA4ZlrpVn6koF6FzzKO/G2/hbzTiBrv/An9m5de9ZYMe6FAv0zitvFpO9ciu+6g+1Il7dk5NaYBTOJeAQMUmkWngKvn2htSCPQdHZCQn4d20pRGr3IJuU9qNcIo7DNE3pxhg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(346002)(396003)(136003)(366004)(1800799006)(451199021)(186006)(921005)(41300700001)(6506007)(5660300002)(8936002)(7416002)(107886003)(52536014)(26005)(122000001)(33656002)(12101799016)(8676002)(86362001)(558084003)(38070700005)(38100700002)(10290500003)(55016003)(82950400001)(82960400001)(8990500004)(478600001)(54906003)(66446008)(66476007)(110136005)(66556008)(9686003)(7696005)(66946007)(4326008)(6636002)(316002)(64756008)(76116006)(71200400001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rszZ3WcAdXdfAOkfhWsLNmzFObFQvK5k7zWGvQaAlFYEyffNLT+0IxKbd4/r?=
 =?us-ascii?Q?7NEm5PWQ0Ae0h0eamODRd9FSUB/8gmtFp4lXxTLFa3EQfy6gfj3o8fp11uGK?=
 =?us-ascii?Q?9jNiJsssbiHD1itya1TEXDn0Oq6NzQBS2eqPUmB4nCXePUz3Lq0uHz00xUlv?=
 =?us-ascii?Q?UQVIVX05dU0KO7oyAhIJID9Ydw8gH31jiNo71IhVrMwzkN5kkfVH5M5GhxeI?=
 =?us-ascii?Q?0rO/1BovYbxYIQUG4ZLoPkobb1czEfYKkoJwZT67mu3KmHFeFCVYfUpLRL4z?=
 =?us-ascii?Q?JzHlGBtj2m26t0Yh+RYjv6onZWfwsw5UhK88ss0Q9E4c/d2sJecKraLeclG7?=
 =?us-ascii?Q?HpXzS4zQUIRY6p2Q9iKQOGHXoOffDuiHE8FvJGQFXicAJMkCppujUPWPl/XP?=
 =?us-ascii?Q?0cHpzYFj6f2qX5GDycwJidyan6a0Y9jNXokYZCbi+WcjPMdYmjyHJUi9Dd+T?=
 =?us-ascii?Q?lGc3DCEcw4GD6pDxTrayEIBiOQIQbvVZBV2Y5zqtAAL0flulFSfZ5/KJ9YuK?=
 =?us-ascii?Q?zsRH3YdvbQAiuvYzWhfQHyyxEt6np9aI0ypQ2hSuxYf2GeeZZHR5k8Cy+FpG?=
 =?us-ascii?Q?RcA9BvpBC3asfbj0cbWxpbzVtBJQHk9AM9TIDZjaEB/xjBwQ/gnMtOpcF+l8?=
 =?us-ascii?Q?tpas/AwiWd41G72v3fBsrWQ0rk3hdx04ivs5R3r/SDcphcOot3v/YHVl2KnX?=
 =?us-ascii?Q?9KmZahN1wXQ3rlD1qQY49h4h79N/vnyvX9qEUoxbq8mWt/DPt7CUiwKVW2v3?=
 =?us-ascii?Q?u3CdB4A/A82wl1y+iRIn4KsJ2yAi8Mk24SUN/AcrqvoDjT/8lLt4XRh3zn79?=
 =?us-ascii?Q?382w7JIBTMae55XOevNzpM1KjnIq5brHtXE78mlGD+Y0jsKMzUATHKnUbIbe?=
 =?us-ascii?Q?HvJTQdag9YDFPOo1kSZVn+yxhN0mvT9XJxiuhNEIiPalveaQGyCfbj/EOr53?=
 =?us-ascii?Q?KUmKwLAvR5EBSOFz8LmT5EMigBK1DWMHgfjFXyH8OGoUTJzCtHFIv3p18fbl?=
 =?us-ascii?Q?iQLjpr1c90oi2WljktodlZTDcA59jXfd+pOt7Gwgg26QZxgcupybjexUP+QX?=
 =?us-ascii?Q?9lYKsFePs/hY+qZSE/9FyP7hxjJR1iFa9QrHd9aQot6e7pfNYUlMw57KmeiR?=
 =?us-ascii?Q?wHtVp+963ZovXQshAMWV7iVkHnyjDqZ0kwwPR9CGc48i+jUNtUvq2oUkipO8?=
 =?us-ascii?Q?u9eZvNfuoWi1Gbx6+2hIBRfwVGQeYcKxjNzJbN4HSt+9Tuksbw24uWZi5Rhc?=
 =?us-ascii?Q?DKLRDpKvRD/rwkq3Ll6Z3jLhvk7qpPmHtW94JP4ssAalrEHYXltNu14Qofhr?=
 =?us-ascii?Q?UOcEhBby0CGX7d4RNNHmoRrL+Ofbytf0CPqx0G4KuPwI9gEaLg8ZcFzduZm4?=
 =?us-ascii?Q?iMo9SOywOgAuE5aUf4sT7Hp5J+p7g7vEMQrKh/Whm7UjKaaz0d+115kMXQdJ?=
 =?us-ascii?Q?06Nd/bvRGAtul7qjQDinrVSzT1XaObbPdMTZ/VpDb5GPCUhYZH2WJbh6dHn2?=
 =?us-ascii?Q?LK7Y21nLVeEE8fO+vPX0nUiT6hJlzs98waWLAZZ0E8Gbd9FWiN2BFScjqXGj?=
 =?us-ascii?Q?jAg4dNaAChu7lhuPC90Sq+Kb4RwMX3CBwyQJdFLf?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59d214aa-b9aa-4b83-ffc2-08db9a03baa4
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2023 00:41:40.9969
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BDA9OV0g81iMHcCq+NBytsqxRih4hx3VoYOkTTzoP6sIS5H8Xqqejui8M8q0EJKSmniX8EKTD4ZxxC21JYL7oA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR21MB1933
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> From: Tianyu Lan <ltykernel@gmail.com>
> Sent: Thursday, August 10, 2023 9:04 AM
> [...]
> Add Hyperv-specific handling for faults caused by VMMCALL
> instructions.
>=20
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>

Reviewed-by: Dexuan Cui <decui@microsoft.com>
