Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8495639E60
	for <lists+linux-arch@lfdr.de>; Mon, 28 Nov 2022 01:07:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbiK1AHg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 27 Nov 2022 19:07:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiK1AHf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 27 Nov 2022 19:07:35 -0500
Received: from na01-obe.outbound.protection.outlook.com (mail-eastusazon11022021.outbound.protection.outlook.com [52.101.53.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02137DFF;
        Sun, 27 Nov 2022 16:07:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ps0/+uTdLT2Lb3SdpTBiQ0w3/bybwA8EFSS6rrP1ZeGVGL12+IKvh2Hx/hbLBUt5Q8QBoT1i/P9+AQqM4XZJNLdJwj8tInjwn3N4R2uqFvSoCga3+5tWLDvex8BxuyZ/V3ViQLUBOtwn52ifZ1+C43lGMvNYURR2LNuXUZr5UxMBocVVf2n66CkWOBZh0aOgSVG3BdQ+EI0MdJ7c3M2wDw2LAg1hLbq01O9c3D54lzNW/LBDfFiOzyo70SHfa2hSSKbFuEOTJiMJLj0NOLNOSLDMgNlxZgysDVB9R8fjoq+hdOQqylQTD6XB1jsI0BAbdfZPWwd3FLZXkT2Fi2HNzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5up1F28+jo1VikTgJw/mtcMFE2/BEF6zo3lobL5rUqY=;
 b=nYNDADUECcaJ/Wm/GsPMR0FaXZKf2Fg7slOKjMwdpnHcZ//V7O38ZsUk17q1+FUuj7Vp2eOiSHc1QXywIsOhFBJDc2Twh1U+JbraUoN8dSfCEhua8zmRVn1NezoKi0IWW7M0aG6ATAS6sWAIkN9s4YQ+HkYtb5sRH7AQV5AIyxSEbXSJb6iYLOlAFp7r09OpMPhbOVJtYwtZFHN43iwMshpxRGBDzDHf4X2KwM3rTBh9jKzwMXUXbI9i/LqhjbEo5Uw43ICyuBAo0C7YnioQWdKuYv3Gd94E9zFB8WwTpzpCf0xE1jehJEQnvoysZSaRzz6PVFLhPlLQz/AQLlFmgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5up1F28+jo1VikTgJw/mtcMFE2/BEF6zo3lobL5rUqY=;
 b=Gc+JCyL2InpygBubyNKwbAJVXLv/2B84bMXY1mxCooNVyStJytwXtyG/y1ZiwQ+jSkcwxjBhdTCsRGEo+aouNMt+pQGjjW7NWClTxwyEG+W66U23HEc44O35aB/XyMk5fMsegM7aYLQJMiF6moh9nGVS+IzcHIwahgPHd+bN9rk=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by PH0PR21MB3027.namprd21.prod.outlook.com (2603:10b6:510:d2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8; Mon, 28 Nov
 2022 00:07:28 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::ac9b:6fe1:dca5:b817]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::ac9b:6fe1:dca5:b817%6]) with mapi id 15.20.5880.008; Mon, 28 Nov 2022
 00:07:28 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
CC:     "ak@linux.intel.com" <ak@linux.intel.com>,
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/6] x86/tdx: Retry TDVMCALL_MAP_GPA() when needed
Thread-Topic: [PATCH 2/6] x86/tdx: Retry TDVMCALL_MAP_GPA() when needed
Thread-Index: AQHY/uuA5M0FGuMnSkmqWvcQ39Wr/q5MgaOAgAbXRAA=
Date:   Mon, 28 Nov 2022 00:07:27 +0000
Message-ID: <SA1PR21MB13352BBC75217A9D019351DEBF139@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20221121195151.21812-1-decui@microsoft.com>
 <20221121195151.21812-3-decui@microsoft.com>
 <20221122000100.bizske6iltfgdwcu@box.shutemov.name>
 <SA1PR21MB133596B911C6A45142B83B52BF0C9@SA1PR21MB1335.namprd21.prod.outlook.com>
 <BYAPR21MB168849571A1FF2CD9BFD8579D70C9@BYAPR21MB1688.namprd21.prod.outlook.com>
In-Reply-To: <BYAPR21MB168849571A1FF2CD9BFD8579D70C9@BYAPR21MB1688.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=14cc37f2-9a35-4b1e-9c6b-34c156199a7b;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-11-23T02:56:11Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|PH0PR21MB3027:EE_
x-ms-office365-filtering-correlation-id: f503f92a-89d0-41ed-c138-08dad0d48905
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Cueva5WThufK8yCY+7ydpBeUaMc0bCdY3ZPq+wPMhQoGz396lh0ym43rTZGzTOarCqtB8boOvatal/HSG+GJYWbQDFZPBJ/uh6tIXeiiOf+PGHa8kkJj7Hr5lxKFf4QrJJIJx5uovSm3JsVJzu9lI2HFpRhHbkmxl3BP5b7L9ooMYwniJORqHy4ofxJVMJQf8OJ14SqrzOf7vNggbCXChyOr5U0lKDS+7eekQbsm4LL3As2MUlCtCbea0+DWmzqhmQn1MkNUj7nBzNtpPLjVjgFl4VvZTUcJbx9ZKRqCy2vqsDWlD96HNQeB5u/oKgIaM3v8k4oC4Xy//gR7Rkfp1Bvdwnx5GYr1i9/xhOKguFP8zECDwN1PQcwK+T0PhF4QoBTQLMQW395XECkJSGGEKaX05zQ2O56mpiVxz7skmWL8wPoyOlnym1OL4PPsGaDXS0SN3lx+LWSIn6VKJicL5lb/Up8JNwHgyuAiwLsDLiBsMLSrzkKHCAOifzkDnzzuWLD1gVOU/PuSOTXylk4OYnXqblywSmR3LPRGy00ZkF0kXnj6IbJ38mtcWIx4FC3qWDThumgF56W95cLIez2QsUog+3YdiyNYjQb4QmoKaWwb4OoWYmaOaOsYVoHgJDb/504GklzDARlhNYeG7j1qtsyvTKfEl/B8RZPL57AlM90gCepbXYDL1Gmizmr/LTezz5GXb9orwxjZH05QZTaFvRIYk6LkDvRGxTDxUexGMgOPU118V8QI9UCVAo8zXij1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(136003)(396003)(366004)(376002)(451199015)(110136005)(71200400001)(33656002)(10290500003)(64756008)(66556008)(66446008)(4326008)(66946007)(66476007)(8936002)(8676002)(52536014)(41300700001)(5660300002)(54906003)(76116006)(316002)(7416002)(38100700002)(83380400001)(82950400001)(82960400001)(55016003)(122000001)(38070700005)(86362001)(478600001)(9686003)(186003)(6506007)(26005)(7696005)(2906002)(8990500004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?z9+W5FCO5mnFKB7n9Zx7pp7qTuEDc9KaE0IZbrzreEXxQtScW3AmRtR7E/Dl?=
 =?us-ascii?Q?pGJ6A144EqVdqCocD1bxgPl+OnakfUqR7X7NGuTliv3Jd4up/JGDi5gAGKqm?=
 =?us-ascii?Q?n28f89bRIofJzNxUisE1OpeOTmaJGlhO7N+KpqX0lqxJqdoFziQQvD6u4Mrc?=
 =?us-ascii?Q?mc37v6n9h3cyy4KKeEdIIWOGRTZ+5bDV4p5d1B0Um35EBb3Cj3cX+QYqQcYn?=
 =?us-ascii?Q?OxiSC/U4TI/i+dgXckoPrT/WFsXjcCtvZPXrkaLcR/6CxJPPydjvgurMGlPo?=
 =?us-ascii?Q?DIHPYd6kqo0Epg+/wZaz3RzSUIyFkzswSMvUcnhSFy0uIZYHZfVcmhI+bkXA?=
 =?us-ascii?Q?jRx3lsocgT9ID4xFFmcDcq1PCh3q1FHs8WZNu3zXmmV7yOalm5TbPbsu7noR?=
 =?us-ascii?Q?CuizvEN4kmbvcNJM6tLmTavZWWG6eCOBXCNGv3CBQT9IO3hHgFvzY3RIhH/1?=
 =?us-ascii?Q?N+Jc+aX9QiJkDrzX+g4num72hX7yrhogxJF0+lx5WFo2PLvUsc3P1IY9d82E?=
 =?us-ascii?Q?tcgScL0Cwx/ob2Kk+cTXoj2zq0wYbH3RI0a5RM1OrBV1u0WJFClJlTQbuOIX?=
 =?us-ascii?Q?7mmkDFRufZR2zaTzYbmtaxoQb5hHlSbup9Q5KSm0ekLtXxuq1Q8YwMOY22qR?=
 =?us-ascii?Q?7PjIYDL9nqlXZWnsDq0cEEP1oL4dU5cYP8IReaTjXlAf8uDybWBzyhsgna3c?=
 =?us-ascii?Q?0yJSekRd43JhVVZ6GlD6M6QaHteoDVPAw5shPiYsvd4gCPESP4KIypnFMOaV?=
 =?us-ascii?Q?arbN9mIB52c8phaC0g3KFn5ScjhtnFMeNUg2AAUJHnfBWf1eOEqIrtAhF/sa?=
 =?us-ascii?Q?L5cprSeerJ6ZwGoAXlkueB2DxD4i6Jnk/aTLY+oidUxdhPilsO9LLU0XGSey?=
 =?us-ascii?Q?StGNKIhcM37jYDwmVSt7bUfUBXL9hsK/O+CAGO0LEUz9CdqZtog4djduDXAV?=
 =?us-ascii?Q?MDmfLQ/y1Nt4aGlSnp6UmHRf44dpT/sGrhfiFjsMMaP6qYE+Mx0tCvm+6KOK?=
 =?us-ascii?Q?lPh/PX/HTCrzfL/bDbU/R7p9skDBYtSuN+BcxDJ/Lud6hGEEg7OR1b5TxUBH?=
 =?us-ascii?Q?TEULpjkzu8uwgYGMhAiAPMp/tttvqtRrGm/CAmXYLIN5io6R6aSNk45MQJ5o?=
 =?us-ascii?Q?m/PuKu+/sFHULuvb/cGxJgE9XgErwDnaSFTw5T9psSHFdhM6OdY9VTM+gSV/?=
 =?us-ascii?Q?Eg2cMV5wy4qwXdpGmwT+eZsfXVJfes861yObUYJkmMQLH1VjIABmwLYwwUF7?=
 =?us-ascii?Q?wyGf8EJFuwdOXeeVOTF13/LHXn71pZSUANnJS9MGQf71RUwoNaHz4tVflboG?=
 =?us-ascii?Q?NXFVEDJRr8p6ll0z3LU7rxxtOEB1XF/+il44uR/fveP22FsefOzZd/HoG+yi?=
 =?us-ascii?Q?q+P3akdc9Npv9CBchsCAYhpYvuUaiQ9TyY+uCc3T5EE7PGXnO+IK8zmhODs1?=
 =?us-ascii?Q?yw9WRlPM6NJe424qwDpXbtaj6nRY/6qnf+TANSMqoflaj7W006rSaVOWGOr0?=
 =?us-ascii?Q?1Yo99RPYpL7TVcyvmlD5/0LsxSI25ngZvGfO9Ri8Dg7SMUdtmO8HgFeyL/Hr?=
 =?us-ascii?Q?MOHPzH8R+dhgHyNuXlUKuj9WzwQN/yFMV7kWhzs3?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f503f92a-89d0-41ed-c138-08dad0d48905
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2022 00:07:27.6690
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rxx8uDV2DTKdwxIa6ZiFpuNvRi06vrpURueMlggIGKBSNC9yzcimY72V02ePCPYG/3UPz4yfvU4i+OPDmJaqgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR21MB3027
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> From: Michael Kelley (LINUX) <mikelley@microsoft.com>
> Sent: Wednesday, November 23, 2022 5:30 AM
> > [...]
> > static bool tdx_map_gpa(phys_addr_t start, phys_addr_t end, bool enc)
> > {
> >         int max_retry_cnt =3D 1000, retry_cnt =3D 0;
> >         struct tdx_hypercall_args args;
> >         u64 map_fail_paddr, ret;
> >
> >         while (1) {
> >                 args.r10 =3D TDX_HYPERCALL_STANDARD;
> >                 args.r11 =3D TDVMCALL_MAP_GPA;
> >                 args.r12 =3D start;
> >                 args.r13 =3D end - start;
> >                 args.r14 =3D 0;
> >                 args.r15 =3D 0;
> >
> >                 ret =3D __tdx_hypercall(&args, TDX_HCALL_HAS_OUTPUT);
> >                 if (!ret)
> >                         break;
>=20
> The above test is redundant and can be removed.  The "success" case is
> implicitly handled by the test below for !=3D TDVMCALL_STATUS_RETRY.

Good point. Will remove the redundant test.

> >                 if (ret !=3D TDVMCALL_STATUS_RETRY)
> >                         break;
> >                 /*
> >                  * The guest must retry the operation for the pages in
> the
> >                  * region starting at the GPA specified in R11. Make su=
re
> R11
> >                  * contains a sane value.
> >                  */
> >                 map_fail_paddr =3D args.r11 ;
> >                 if (map_fail_paddr < start || map_fail_paddr >=3D end)
> >                         return false;
> >
> >                 if (map_fail_paddr =3D=3D start) {
> >                         retry_cnt++;
> >                         if (retry_cnt > max_retry_cnt)
> >                                 return false;
> >                 } else {
> >                         retry_cnt =3D 0;;
> >                         start =3D map_fail_paddr;
>=20
> Just summarizing the code, we increment the retry count if the hypercall
> returns STATUS_RETRY but did nothing (i.e., map_fail_paddr =3D=3D start).=
  But
> if the hypercall returns STATUS_RETRY after making at least some progress=
,
> then we reset the retry count.   So in the worst case, for example, if th=
e
> hypercall processed only one page on each invocation, the loop will conti=
nue
> until completion, without hitting any retry limits.  That scenario seems
> plausible and within the spec.

Exactly.

> Do we have any indication about the likelihood of the "RETRY but did
> nothing" case? The spec doesn't appear to disallow this case, but does
> Hyper-V actually do this?  It seems like a weird case.
>=20
> Michael

Yes, Hyper-V does do this, according to my test. It looks like this is not
because the operation is too time-consuming -- it looks like there is some
Hyper-V specific activity going on.
