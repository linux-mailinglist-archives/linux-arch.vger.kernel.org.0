Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCAA4649747
	for <lists+linux-arch@lfdr.de>; Mon, 12 Dec 2022 01:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbiLLAEV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 11 Dec 2022 19:04:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLLAEU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 11 Dec 2022 19:04:20 -0500
Received: from CO1PR02CU002-vft-obe.outbound.protection.outlook.com (mail-westus2azon11020022.outbound.protection.outlook.com [52.101.46.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB0065C6;
        Sun, 11 Dec 2022 16:04:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e4GBV7vCXdMFmprjIV0fKIXmpdwDpjLHCq01+ldsDBxtJPErcyITLaGWIfGOFZJgsMrnU1BAacnBbtpQrk+Pz6I9wSvmxHpP2ZYOAAwPH+2MJR+qI3MVvssidLyC8LKoOHyCuHyBChxE66c+dqmsFJ3gKahjED2P09JP3pikYl/LWFm+yGAe0thqHpg6aIW4e4gcRdnxpRzPbo8kLUeoE+qIyN6k9Hbw9SeQnhSNSWdv/qVlJZeKdivDGWArDup3TgP5CKuEg0NL+DdE/D2ALnpMx5bWBm7gtxKYxzxNtb/iquuGKH7CW0rAF8roW9K2SZXaYLUaaXl8UjFKSQ0pVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MF+Gf24gntPMlDx8OptqN0N7XqoFgUBYp9Ni8SBV2ck=;
 b=nBcIOQtuKhahVl4r+jtNIeZ2FV8ioFPqojUe26DIrIpwTd6QY4aIcgPEjcm3AoO+aHHgiXLr44KxrUC7GgzWfQ5SegAGiNn7dcMZolRjIuCIX7MrICytZEOT1eaUKm/Lxp4uBj7KyxYyGiYG4X4Lsw2dzwx9nA3APSaBxeNf+P7fyJz11blS02geDny9xUHcRKN2zN4a/2gf14thzcHx/AAfz2JoTPAbGjES7os/VJbjlkqzxrTaxq4YWSAkEKUkRowfwSaIZY+JF+cyNFI2JeaiEd094NSdEVnsWtcu/oqJ3FJlNKWMevQPHw3FrMzUOkr5tlbZdANesv9C5ASdDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MF+Gf24gntPMlDx8OptqN0N7XqoFgUBYp9Ni8SBV2ck=;
 b=iPEoEYEznIP7RUaU0hYseXQCRy7NIlqhu5WS7fx2YuZ2G97TTze6WTjgCPB9njbj04jMUpfymJDXqEX6ZrzxmMsyRu0vdsuZnrYOQt+wDYIxr8AG/qCLhalJfR9ZHGIG6sbOs39p38fVPtuV2/pbC2oXpKtwsoNI+xlNV6ogfCE=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by PH0PR21MB1878.namprd21.prod.outlook.com (2603:10b6:510:15::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.1; Mon, 12 Dec
 2022 00:04:16 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::ac9b:6fe1:dca5:b817]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::ac9b:6fe1:dca5:b817%6]) with mapi id 15.20.5944.000; Mon, 12 Dec 2022
 00:04:16 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     "ak@linux.intel.com" <ak@linux.intel.com>,
        "arnd@arndb.de" <arnd@arndb.de>, "bp@alien8.de" <bp@alien8.de>,
        "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "jane.chu@oracle.com" <jane.chu@oracle.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        KY Srinivasan <kys@microsoft.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "luto@kernel.org" <luto@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "seanjc@google.com" <seanjc@google.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Sebastian, Shiny" <shiny.sebastian@intel.com>
Subject: RE: [PATCH v2 0/6] Support TDX guests on Hyper-V
Thread-Topic: [PATCH v2 0/6] Support TDX guests on Hyper-V
Thread-Index: AQHZCdOx4/lLVD2s2Ei32W/opnxeCK5pYxqg
Date:   Mon, 12 Dec 2022 00:04:16 +0000
Message-ID: <SA1PR21MB13350E3B6BA663E9CD4CE02EBFE29@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20221207003325.21503-1-decui@microsoft.com>
In-Reply-To: <20221207003325.21503-1-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=c37ed06a-fe17-4c01-9875-3e9571071b29;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-12-11T23:50:42Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|PH0PR21MB1878:EE_
x-ms-office365-filtering-correlation-id: b399739d-6899-4452-a013-08dadbd468bc
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0kpw/1z4J1+jZ8Qmou9NtFbPYux3+WautLuBS1EGiQihrMdnx7zxevAMtv/XOK+1Sxf9qiTrYcP6WQMp5y6XgQtVsHwoKmFyovVmHkbx0D19WNuyt9SaeLiIoh1FPZnlngXSOns3n4ZKY1wPGHvCIyNoTNL0nQ21L/5F+M8FMpuRh2DiGEx/Cp3baiM0AE6y7pVRMk3QvO3tkgSxU4d6tc5YMXChByH+b/TvMuWmmUL+zQMYRvyAvntlp9w57ySQglN3MrRcNTWmJkdH3f2SueC/DJvsF83itgoS1a+Inxg6cQc3e1r25bFvy+S+XEhM3jF4i+YDTKb2Xm9QEVht7GeEOn1m5gTyTHr0Ni8U50f8rM65z9/1qlzAnpq0XxUv5DxW2M6BrXIryZtyN0yrJVvA6Crxi32lEpDY+cRq6HJ+C16kXBSTFJ7DXG6SgTckulhjoj9zqCoDhD+bR4ebnT8cXFr4vG9iZCf9ANZrlyY+E/lHyYRoqkQKQ6LhOVsX0W9BzqzIROB7HuPyBHH58UrYQ/VQQm4FIu1Er11IKg3bIkbfdjBCKudPZ7HgfYvpFywqRrv7aNTSHwETQUSzfib+ktdpmzFvTON6AuTJP/FfdLjtN3knKQyM1ITj1lOd5u8p2CnHKIQaYeUtzuSGd3JVPeKO/p7TeNdmZjevqQ2zWn9Q/Eh9RQacKamUg6vOde7ENMe5YBl4oZOj/11qI4DMKKHrM72s8tIBX35TSg4Ew9GirAzhp6BR7D3EiKzlb8XpEDjEHdpvE4Jmu/9Kdg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(39860400002)(136003)(346002)(366004)(451199015)(55016003)(86362001)(33656002)(2906002)(478600001)(8990500004)(6506007)(71200400001)(9686003)(7696005)(26005)(41300700001)(5660300002)(186003)(4326008)(52536014)(8676002)(66556008)(76116006)(66946007)(66476007)(54906003)(64756008)(110136005)(66446008)(10290500003)(6636002)(7416002)(8936002)(4744005)(316002)(122000001)(921005)(38070700005)(38100700002)(82960400001)(82950400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5BGIh7l53SK/5uWMqCZ/U7/f3q9yC2wmzu693I78HwF6isvo5rxhfbuHgLMj?=
 =?us-ascii?Q?YhnKxcaCYD9lgZst/oCOk54qGkIDWWOgm4MziO/U8NqVJijIEW+dLeNInvJj?=
 =?us-ascii?Q?aNdgOtZF2oXtF7cNqZZvbyu7VTR3QLaiTV1Y9ifzNJw8owFKCdpL26oWCWTx?=
 =?us-ascii?Q?WHkJCv9nexaL8fXr3LmlPt4wzyxkcaQy0RBOAoO6EYu2lZein6f0sQ8FPygu?=
 =?us-ascii?Q?kJBM35haqEF5LQsU/HhGHx+duAqVM/GJiAufrVb996a7Ec+m4vEOX0hv4GPD?=
 =?us-ascii?Q?Pmc5tNoWws1b5nXVKJHOX08EYZ9rziEmdff4VHyuSnPws+zV63OgwuvpcX57?=
 =?us-ascii?Q?j6ERvvNgEyYFcRscOQxlPSmqxvXI9GyGgBM6lVQejTFTpppEsUb4JBsNr7LR?=
 =?us-ascii?Q?8uXgXUsrRu9Q9NERj2e2kLZl+s/uLhoyI0nYPqMOyWtEgIxpjx3wF11V1tXo?=
 =?us-ascii?Q?83FH9ny3JKkafrSiuIMTFHhBfD87XWk95XmpHVNmfd4AUFeoQ9IyEHHfKSux?=
 =?us-ascii?Q?+Cy9YAz3+Q7WrkmncY2OBfsP/zdL5L24AGwXdDyZJ7JSutvrsbL1Ke4opqPq?=
 =?us-ascii?Q?G4Y/wAHiS5v2qLIsAN1CC7IJZgMHR4gDYVBVTqEnG3uOATTI95EMVwjOzIyv?=
 =?us-ascii?Q?tEgdkdCn/ysMu4Qz2+80kjDkEHGBpDFr0c0KJSfz5SKp2szvUcXl3bmqTdm4?=
 =?us-ascii?Q?zlIefvNdQMSI4VxBAwJYh1y2x6B/21USR07zDnjsSk5AKZH774WvErhUcY6R?=
 =?us-ascii?Q?H1jErLSo3EAgPNSOok1ym1Wqqh5DNi0liNVyOxi0i6jTFpjgAhnUITzYEVPl?=
 =?us-ascii?Q?cp4BbVs634Qiq3qwUVk/mZW7b5RgNj8yn0QVpICpdjuWCrsgpAEjlMfvRfjy?=
 =?us-ascii?Q?Hp/cHPUOlNTJgltn5JZENbXJ9PwMGqOmk486xw9+Y/DyodDYGjRa/VKYJ8wR?=
 =?us-ascii?Q?2FiJFWLhSIoZmKERD1/I4xidzQbufsFxhpDMhV4N6ndg/EPtD2ue8EcJJU+V?=
 =?us-ascii?Q?GEx+wUEOpQ8oLoeqKHeh9TH9Vl2ebo/PDtXeZ8GXhWcJ7+TFgzCwwJPHYK//?=
 =?us-ascii?Q?GNvoLXaWzumHO0A2txEK7xqV63cjDbPIfm/SQ9X9eSIK74Vkm+fyTY6+0HMC?=
 =?us-ascii?Q?rmZ26+UPUFDkfBJPjTWSpk+zL2KC8HYqc+PVAqBuLDUYrjcGwewBwdiy3n27?=
 =?us-ascii?Q?7PfEWV1VFU7bLwV2GTIeUtGtyDyd59xODPPJc4WqloJBAJimspLPy7k9ldMJ?=
 =?us-ascii?Q?JQ0xdLd+8Q8wKEG3OMsBsEQfsmNMQbsqnMdCQJON7xQx0eJyPvkcYWwDb2ii?=
 =?us-ascii?Q?TONNgADDvpgR0E0ULf51ouXdFWPD4yRoJOkurEyD1fkh7Usv7PR8az0MvyCf?=
 =?us-ascii?Q?Zx5l8eev7PupK7rWfb4Qct5jlVq3y+V1q4N66Orfc6NFWHMrstxAzKoki/yn?=
 =?us-ascii?Q?SJ5BiQdH+ZcOvgAJrSyRAmKgnVykTpjJgvlYwrMeGSoNk1wg4AD8IuEtYz6l?=
 =?us-ascii?Q?3Z0NlWAbGKrGYvULP8AEC/Ih63cBr1gIrlHVhxXNkAgVSsEKyXUQ93tr06xl?=
 =?us-ascii?Q?0SDDLhn0bEGh0OeF3/ZFZabjS7QoDj0V35VvH874?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b399739d-6899-4452-a013-08dadbd468bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2022 00:04:16.2775
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KjUmnXCyvsYxy3jiqA8fM6gxfNmBJ+AX7SZpN3MI+BWRPRtetYwV/p2fcvTmNLfbdc9reXCHiMpOEPVQUT6Smg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR21MB1878
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> From: Dexuan Cui <decui@microsoft.com>
> Sent: Tuesday, December 6, 2022 4:33 PM
> [...]
>=20
> This patchset adds the Hyper-V specific code so that a TDX guest can run
> on Hyper-V. Please review. Thanks!

Hi Kiril, Sathyanarayanan, thanks for your comments. It'd be great if you
can comment on other patches.

Hi Dave, can you please also share your thoughts, especially for
patch 1, 2, 4 and 5?

Thanks,
-- Dexuan
