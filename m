Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4E6778712E
	for <lists+linux-arch@lfdr.de>; Thu, 24 Aug 2023 16:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235684AbjHXOJv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 24 Aug 2023 10:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241551AbjHXOJm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 24 Aug 2023 10:09:42 -0400
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-centralusazon11020019.outbound.protection.outlook.com [52.101.61.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E95CD0;
        Thu, 24 Aug 2023 07:09:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kgWSV1tobh30B8UhT4ASWfNRNsXWUmMx/aUf6HUKp/h0JJIiifMSV0c2hkbIsfe0oB/Mvwu6iMFuSgjc1Jinh1teAJI3ic+127TPwm6lFqKJKYL9IwZAVY8sc1F1Y57+yP70gz3MnZ3t03rXQhQkFhhebZR4GVo717TgAHbU16QcYlDEGLJAm1hEHOQE3vNfEwf1ik5M4irRJ1arj6MnlG32JQrbXBq8oa89pwMjS6NN0tCuNY5gxZGNK/b1cujTNNas9m5zILUEFULzkZuHe5XxQC28j9ln/HA+eU75CHCCD4AMTqzl04HTZuse5JHwKHQBQ2+jaarmj6yn9AWrvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s6tifhp+X3tx7gSXjd1nulYOZWCp4AFW6zElIuLHH/c=;
 b=gH/QOcOxv2/HQaX9B6zckfzBAgzI2fuuqpG3X+mh2FpQHLU/Sbi4JCezpysB2Cn1xJyBZPzUywKkUqauvUD4f794SDhocye2M8eItQz7/0Pp8O70y7cqnBVunPwzQfdEDtIXRXNVyBGY5O0NN3sRitI1ixoxOFRqip77o5At6qyswh72BYq/e02UfLqgPnXSEdzEe+p7QTGbNnpecZvV0e8XfK53q3Mz4XYiASj/S3I/OAd6rzyyTm4VV7XCqCAuHfg1Yfw/eMa03SiZxP6XAJiCKF2F4AALoF9jXgW0E7AEpdNL9mjo/HTCpA5d9muLuUE3lsy7kQcU+F7mU9sNAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s6tifhp+X3tx7gSXjd1nulYOZWCp4AFW6zElIuLHH/c=;
 b=Gaz4PnUnkKGsI1bqAgTkNqCm7KZa6kk/j395N/laZNpSeRaDlHjILYk6cXsGrV3O9skYXuua+4rgZfMNWSFrsQcTsJSkFFEbB3bXq5F8YWDjdUGl5svM5lh2Xl55y/yK7IqxYX8lFk+kLvh2TCIs3tKlNn18BJ0nOPNfZ3tx9lQ=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by MN2PR21MB1533.namprd21.prod.outlook.com (2603:10b6:208:1f5::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.6; Thu, 24 Aug
 2023 14:09:28 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::4cec:9321:1b73:6d5f]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::4cec:9321:1b73:6d5f%4]) with mapi id 15.20.6745.005; Thu, 24 Aug 2023
 14:09:28 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Dexuan Cui <decui@microsoft.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "arnd@arndb.de" <arnd@arndb.de>, "bp@alien8.de" <bp@alien8.de>,
        "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "dave.hansen@intel.com" <dave.hansen@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "jane.chu@oracle.com" <jane.chu@oracle.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        KY Srinivasan <kys@microsoft.com>,
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
        "wei.liu@kernel.org" <wei.liu@kernel.org>, jason <jason@zx2c4.com>,
        "nik.borisov@suse.com" <nik.borisov@suse.com>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>,
        Anthony Davis <andavis@redhat.com>,
        Mark Heslin <mheslin@redhat.com>,
        vkuznets <vkuznets@redhat.com>,
        "xiaoyao.li@intel.com" <xiaoyao.li@intel.com>
Subject: RE: [PATCH v3 09/10] x86/hyperv: Remove hv_isolation_type_en_snp
Thread-Topic: [PATCH v3 09/10] x86/hyperv: Remove hv_isolation_type_en_snp
Thread-Index: AQHZ1mIkgkszLMzGCk6YoEr++p/GNa/5fDEg
Date:   Thu, 24 Aug 2023 14:09:28 +0000
Message-ID: <BYAPR21MB16885DE4D8C4F71F3D9F2B20D71DA@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230824080712.30327-1-decui@microsoft.com>
 <20230824080712.30327-10-decui@microsoft.com>
In-Reply-To: <20230824080712.30327-10-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=b287b392-4aae-4d76-9abf-4a2d06d32190;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-08-24T14:08:38Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|MN2PR21MB1533:EE_
x-ms-office365-filtering-correlation-id: abd99bba-99b4-4ce2-3a19-08dba4abbadc
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WekgATvN+OsaXMo/xvQ57qnhdgHSn3t4ShIT4dUAch2HVbKsaiC+bVntoLRhbpgvjPwOkxSZx1VbLE+UCo8Mfuh3nFxXbfU9BWFHw+Tsu48W8GWKGPh+m9WsTsIbrYRC7GqJ2bw09FrekRCbGdaXxHNyVb9wzBnd9adCKkuj1zVgXsRoESHUuCvBT8bVsZxwFhw6DY/tOY/mMYoZrDsyUIFQmAwptOcx7r+U/cQat+Xso6lpUMvb7T1b40fy2595fIy2TX4oIUGOUj3JA0S6rUNc8iaDAAz0Qw1BCGg2ECyWZg3AcltjY4uJ32+PpG1ogO7AXm22tJNauOXWcI3RCAdWH+z30EqTlN0zyaPQwrh8C+DzYVfcYTWAgCABB5JeqgkAW4R9cweItVrcTRNgIkyesZ90A3btN9dA5nW1Si7L5Qjxz1hRhOOQ6XSnsikSfd01f5rm+R5RzW0i89UX2I7+tpto3URr4BDxoynaTL3TabvZ90X8y2YMPwN+cPWf4hmGEeZ37Dlpf1YSAQ0+fSIIM3abW6DD3rp3oLkXIkmqcpygdsEuYtjP1NoyQjvEKwPAIlIgghCJApgx07RkqX4h2/ElYG8F1I/dzjctrXBEPcbwLXX7Uja/bchN8iRSP5FS430DzBdNBAeZO1yXeytmlEgplPGdWn8CrlomE8f7FMGG1EyznprX6S3uFBy88uwEun1Q4kC1gq00j3n5EQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(136003)(366004)(39860400002)(451199024)(1800799009)(186009)(7696005)(6506007)(71200400001)(10290500003)(9686003)(478600001)(83380400001)(26005)(2906002)(7416002)(7406005)(110136005)(54906003)(8990500004)(316002)(64756008)(52536014)(66476007)(76116006)(66946007)(41300700001)(66556008)(4326008)(8936002)(8676002)(5660300002)(921005)(33656002)(38100700002)(55016003)(82960400001)(86362001)(82950400001)(122000001)(38070700005)(12101799020)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BZxD34V3tZCy/j9DD9z3Ard3Srixhb3uiQM40U+tRAN/z10qHNVJ0A2Zcd5A?=
 =?us-ascii?Q?ZM7SbNnnlILose3NHjmzaiTFTQKL37kHk4WMLkNDGhOIdqUCBp2Oy0qJBFuM?=
 =?us-ascii?Q?PrASiZbgj4TDXujfHdJla0B8ay7PxfiJZ/O+jrw5Gahg3nhr6+ZQL4jhwDXR?=
 =?us-ascii?Q?4OdaQ9JFRgdxeoRPo1kMrsVw1+PHQwpJPCIK+QAr8hDU9ADTl3pStcXC5CCn?=
 =?us-ascii?Q?4B4Q8PlvDsz8cQWcj7BATTkO0L0c4NRbDsMaU092R4sf4co8m5bkwDH/TOzp?=
 =?us-ascii?Q?6ZBwDa3I2gNOUK8VqVBUH814h83ba+gROUKjarOwUJSOm4cwRkx/pEhgIKPO?=
 =?us-ascii?Q?Vlak0EdrqybqahKqjIzzcjvMoZLOKQraU6el/iNxXuMAIZKQEB7HGP2P1s4h?=
 =?us-ascii?Q?wSi0j2UrxWbiGYHBmojMEiZ9Wl4xKsIkXVVYcpBwWHZXXh8JWXkV/931o52O?=
 =?us-ascii?Q?OE61uOdLvVH3/WEY79sClUSAivBPd3rVKCzOludl7ZbN67LZBr74qqcVHAVT?=
 =?us-ascii?Q?PlfOdXZcAVsvPOCawc/WvSwPsAMZWh8XJHmLZZoYgphFEFG00FdyrLJuDrqr?=
 =?us-ascii?Q?ZbIX5OvgPLpUrIDV1EkgZ9oVaMTxkDT/lSGQ0EqlxNrpgg43REuTksbU6pHc?=
 =?us-ascii?Q?4hmaR42SLuTew8uZ0attus6VSA0WiJWdwep+xztY3e6EtxBlX7R9aWK94EC0?=
 =?us-ascii?Q?oMmGX0Dl6w9LhtbKWjvWXrCQuhFfUSLiQBe7ZxyLc1DCjQ14GLcgK8a0unz5?=
 =?us-ascii?Q?wJj9assKAbE3C3qJy6QtnoirTZhr9cEDZ0RLy2w35Gyfd9zC8sMst2kLG3rD?=
 =?us-ascii?Q?zvzGOXYmB4CjWJWwUS57RwZeD3sQP0FDKGmP+zJqsmiGpQXHJ1UTw1hxpF92?=
 =?us-ascii?Q?87XTqJIuaCB4Pc/CdqLK9mA1saCffF0syDM44d8jpMUVK90VzUwxHMojpZ3y?=
 =?us-ascii?Q?CDUcTCtsJlIKksUzAflQy7k2Webn28ry79YL74Q0PqQDzXcVLwLaUfppC6NL?=
 =?us-ascii?Q?6SymzxtmJDJy5dftPIc7MfAR1zCZBfryTfrss2M8ZO14tBvueQQuj8YYgvJu?=
 =?us-ascii?Q?Yr5muybnTLCJoM58L7MY4cTwFdhdSQ7O+FOHoq2uSw/fjWkfY/d+4QXKlUgz?=
 =?us-ascii?Q?KxSF32ZWJftsmCSOxjYGAYoqyp8n0Gk/dunkh6Yy2oumz/Ak7g7Bp3J6Dpnk?=
 =?us-ascii?Q?jfR9BwI7BS5uOJ2IZmNndDup1JATQlA8jRCOCkoIwTJR94q135H0QyU7WxfF?=
 =?us-ascii?Q?ci3VIayx42WrrkNpgpnzYOeSMkFBGT/+y1FknHnzDg60JMHZSu9nXrhmLcXI?=
 =?us-ascii?Q?lGSlCtPXSOX5kExF2KiEaUlpKMQU9SmLZxDQte0PFRcrNZ59chYmpwXP1rnn?=
 =?us-ascii?Q?sHuXXWColYEL6BT4+eYrj1JdJC/O5zo38FAMzIH9b9BLl/iD099bkpLDb0T3?=
 =?us-ascii?Q?OSEfk8TDPhyVmXwxKTGausv6eAeDdDVFRPGgIQd69mj8o2SgJxw4plc990df?=
 =?us-ascii?Q?WA2dBtN5cyB3+nRbnEoiKSBJpb9US8f1u1fTZWT8yyqntCq6avgkhjBEryK9?=
 =?us-ascii?Q?I++bjxJuOUkxbUABEhuLHFEY953udFNqEzUK96y13nYsXXY7GLOH1TY/ii+d?=
 =?us-ascii?Q?Sg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abd99bba-99b4-4ce2-3a19-08dba4abbadc
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2023 14:09:28.4300
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RnPu7/btVW+atl/8CYR3IPATZUFY2X84OeEe3OmEsMk3AL5qcRG/mAY9fudng6tHdmBEZMssgLsctYBiKHBhQDfJo4H+f29VlfIGI0fv168=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR21MB1533
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com> Sent: Thursday, August 24, 2023 1:07=
 AM
>=20
> In ms_hyperv_init_platform(), do not distinguish between a SNP VM with
> the paravisor and a SNP VM without the paravisor.
>=20
> Replace hv_isolation_type_en_snp() with
> !ms_hyperv.paravisor_present && hv_isolation_type_snp().
>=20
> The hv_isolation_type_en_snp() in drivers/hv/hv.c and
> drivers/hv/hv_common.c can be changed to hv_isolation_type_snp() since
> we know !ms_hyperv.paravisor_present is true there.
>=20
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
>=20
> Changes in v2:
>   Rebased to Tianyu's v7 SNP patchset: the changes are small.
>     In hyperv_init_ghcb() and hyperv_init(), added the test of
> hyperv_paravisor_present, which was missed in v1.
>     Updated the test before the call of get_vtl().
>     Updated the test in hv_do_hypercall() and friends.
>     Updated the test for hv_smp_prepare_cpus().
>=20
> Changes in v3:
>   hyperv_paravisor_present -> ms_hyperv.paravisor_present
>=20
>=20
>  arch/x86/hyperv/hv_init.c       |  8 ++++----
>  arch/x86/hyperv/ivm.c           | 12 +-----------
>  arch/x86/include/asm/mshyperv.h | 11 ++++-------
>  arch/x86/kernel/cpu/mshyperv.c  | 10 ++++------
>  drivers/hv/hv.c                 |  4 ++--
>  drivers/hv/hv_common.c          |  8 +-------
>  include/asm-generic/mshyperv.h  |  3 +--
>  7 files changed, 17 insertions(+), 39 deletions(-)
>=20

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
