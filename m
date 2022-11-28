Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07F17639F17
	for <lists+linux-arch@lfdr.de>; Mon, 28 Nov 2022 02:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiK1Bzx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 27 Nov 2022 20:55:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiK1Bzw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 27 Nov 2022 20:55:52 -0500
Received: from DM4PR02CU001-vft-obe.outbound.protection.outlook.com (mail-centralusazon11022026.outbound.protection.outlook.com [52.101.63.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B76B85D;
        Sun, 27 Nov 2022 17:55:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AV3jbPYe/TZIkwZY3oYVu0dteJtRXYrsmkQaUGQpbCHLdQ63uNUFdE4raz9RIg8pLBY5MEnhnz194uwoj365wGB2IsTLd3l36TCnDx2hkZyMmUswcFnGIEYmBsDCNjtrOqGSVzZxvNu/NUEqLs+CDinaC0I5QxEafTwo0a/mS+VwuLfJ+rBEnOTLxJbuA8AWQPhvS8B7xFoQUKXsgDpEgDdRkpGIBKS/Izdd2OsCYa968sBEFnGH5/CUUq/4o5AIPi0+Map4D5lxNHiup7gbWTJkjx+m0ijodBawglRZpS6ZULhdhGGiixL103h4s6ksDJpdhalWG3pOYGDW9xrxgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bv1/jLwJ0VuiHLwCler8JWBbBNZbne88ovFow/4buAM=;
 b=HMe4aYMYC+mTis5LHWQaBwtLHXywhssw3K7rM/eNnqlbgU+/IyOSJuGCiDWooSslHkjZBr4BRwOo4PXuGwTYKcuc3gro5mquYr6Y4Zh9l7tIWQbb2NZuC6JS0noAJOF0sGLdH7vEQW3W7zqCCvxUAvGMKeVCh8ejjlnTppakUMOtRTwlQkAK8FtuU8gMqlV8aSWR8bV9HoGSblDsudfEch8udUUMgVnoTkSoFWdLlIRi0IZHKOVGGIdIKpS1xQGLBCME7eGtStvWxWUi9+yuuhePe/nj6N8WxnopYiHYowWJgLk64R5rqXiZMoYSsqHvV9r7uz6Veng0EyJJkc/Lug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bv1/jLwJ0VuiHLwCler8JWBbBNZbne88ovFow/4buAM=;
 b=Kg/7lGFofK3hKfAvh63kPJp7V993i9C2etkZLAEXRGTtlEbFfXi+bLwD4RXw147rKIbKZYNrhX/v5coZva2h+zyh6trdLOpoXNdjMaeCqYR2rcjgYKp0/SFWWIkRJks0mE/khmqvIZjShurMB/cPO/ww6MszEPuSxm3UQA+PSV8=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by CH2PR21MB1512.namprd21.prod.outlook.com (2603:10b6:610:8f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8; Mon, 28 Nov
 2022 01:55:48 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::ac9b:6fe1:dca5:b817]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::ac9b:6fe1:dca5:b817%6]) with mapi id 15.20.5880.008; Mon, 28 Nov 2022
 01:55:48 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
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
        "seanjc@google.com" <seanjc@google.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 5/6] x86/hyperv: Support hypercalls for TDX guests
Thread-Topic: [PATCH 5/6] x86/hyperv: Support hypercalls for TDX guests
Thread-Index: AQHY/0oyvJMCdibbbUqzNA0JVsxn0a5TiVBAgAAHpACAAAXx4A==
Date:   Mon, 28 Nov 2022 01:55:48 +0000
Message-ID: <SA1PR21MB1335AD4B41015A870797151DBF139@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20221121195151.21812-1-decui@microsoft.com>
 <20221121195151.21812-6-decui@microsoft.com>
 <BYAPR21MB16886270B7899F35E8A826A4D70C9@BYAPR21MB1688.namprd21.prod.outlook.com>
 <SA1PR21MB133528B2B3637D61368FF5FFBF139@SA1PR21MB1335.namprd21.prod.outlook.com>
 <2708216c-9914-e49b-72eb-a2995ee68259@linux.intel.com>
In-Reply-To: <2708216c-9914-e49b-72eb-a2995ee68259@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=1cd92a20-be23-4fac-bb32-c09962529ec2;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-11-28T01:42:56Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|CH2PR21MB1512:EE_
x-ms-office365-filtering-correlation-id: 577d2be8-4c0e-4c75-afd2-08dad0e3abf3
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u7ZkYg5u2l4exbrsTOMX/FxE8rC5gQuhYDcyEW5DY4FP8jDF2Dn5SRm1PqBpJTL2/VUH+K6W+zfYkoLWc7Qug0qgT1xcc4+5egkjM9AldRGUN+i5xzXngmCLKEBZ2G74q3MIWonSpghan+t8yw0Jpt57hqrEci+9OTXAAhkPiltTwsjUjGhVGTOdrC+dxxId+BWYt9KXPeUm2klZU9baePuCSTeG3zgnnQgPAm0Uwk9cWWyi5QOfGw8llwpBjbFbHdkphJawtVdN5VZGkhSbesXeLXjX3VqgAuZ0+LOYK5bY6vtrnUSHJR53vWP4tHEvfILuB9ztyoeIXT0H6CurMyk0A3kGaaCL/sSOxanoAA/WZMPFC11DX21wn4FtYczsDirX0Zw1kywu0sJ9luyI78IuExOD3Por6/57JCwivNjoKiHGUxK3dizLn1BjQI72Sd8WaLqEKYJsCq8KRiwFU2WiaPmuQoEMyopFUi/Zt/dB81zgY0Qb8wS1N9jDSZkuC/uwQ6+fJegQYHepbn21/sUxYckm+mlb3tXj4BVxLFK5iQTGBZye4e5oJPLMYmh6limJBp4BUF3R0GAGp+t/efLEmaIK9FhkqPJMG0xEFe1dJYOU6ZL55BIuV6PxneWVkRd8tdSeXsqMs5y1n8vBBhH5nwmCV9+LB3ao7iOM18H8/aaJ9FX+HPjg3FzVza5AKMIG2e1Bx0GP87ZNAICgnvyak9uj1HVBIdbvGJOD5NSJ2QvQkMd7HDR84AJfmuC5mq4QDOpTu+tuLOa63TuEJGVEI3cN9QdDp28po6cn6wrnjJRxoHpWcAzLdWaUHDAv/0Bqh0EVJXG/4Ba58cdu9A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(346002)(39860400002)(366004)(136003)(451199015)(86362001)(33656002)(55016003)(316002)(4326008)(41300700001)(5660300002)(66946007)(76116006)(66556008)(66476007)(64756008)(66446008)(8676002)(6506007)(110136005)(26005)(71200400001)(9686003)(7696005)(186003)(10290500003)(478600001)(966005)(38070700005)(921005)(82960400001)(82950400001)(38100700002)(8936002)(7416002)(52536014)(122000001)(4744005)(8990500004)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mWEIHxw0J74G42IfU+nvprqF3aLU87487sJhrm0vxQkpJ7OpEw7ffiHF8AO5?=
 =?us-ascii?Q?3wXPnEvJazReoZ/RiYSOiI8oEO7umalNQ8q1PBvhmp7rRNoACKU6ncqkY1gh?=
 =?us-ascii?Q?wvmpBpC6uC3xoAhq2Q+lZ++4UMw1CILqxkOSYkF0W8fCI9VCWDnENV65J5Zt?=
 =?us-ascii?Q?6CVDLJeVjPkXUcUfpOWd2GACphMEAquNSl/oJl0OvKi+X9tZVQet09gkAT7a?=
 =?us-ascii?Q?qYa896HpLOY4LbM9yGR7JzwlBd8+yHECMhCGcUsmmv/bBKapBukSC+crLIda?=
 =?us-ascii?Q?mqTjP69tWCq0mjakHT3R0cBpwafLUpgX83coO3o+xqYNDb1VOyOa/R6Jbhae?=
 =?us-ascii?Q?FFjzljImwrUceVpe3n2aMJNnf1dG0x5VyyGVGQwofA+JpBK3WiIwJKDESncC?=
 =?us-ascii?Q?rZvPb78+ff5E97RH1SnXQk/yYWNJXbstVENHbYZ5SpG4VWR7j1jRojNkNVJC?=
 =?us-ascii?Q?LNpAJRTIvUQT3vFs6tQ9lgOdAF6hQcfdJH6jvHCqaRM6c7aJcIuQa9k5YBmU?=
 =?us-ascii?Q?megt8aJeayeiNaDoQpoj0lcvPzCMrMsNX++n9CJIQVKh808DlfM537L17LKc?=
 =?us-ascii?Q?DY4e69/9Cu9MVVxim3zkWH957UtnaljWI5EhbQ9qeJheBRd+hCxcNdD5fz19?=
 =?us-ascii?Q?n4lYglu+Oy1kJITnLxVgCCK1FRQXoaepIYj4d434jL+TdANqT/5KalChsdb8?=
 =?us-ascii?Q?VWUGhzUqrbrNW08qLhMA16kE2lz84kHyS0klUGDBjGDcmkS1JCRP0UPjPxNN?=
 =?us-ascii?Q?+AnwwiOsjusG67UEsdFr+r6BYaxmQxmxShMOl92thjsS/8idQ54k8omj8ovk?=
 =?us-ascii?Q?8fuyjrAX60KNcYMwYED+Xi/+ZOTTgaDx8ZlazWsuPloNg0Cyncdz9wNy8EiU?=
 =?us-ascii?Q?6lpTKIcxM6YNr6mSx7tB8FUegq7GHvH12Wi40nsj4fjUP8FJP2YFX1yLsTdZ?=
 =?us-ascii?Q?8LFhLH4MGanW7KKr7+YVnHvHUlipE4KSDBOE3GOMaY8En0YKnRAOo+EhS01l?=
 =?us-ascii?Q?pUkh6gpIM5djsGn9vrBcTqvTrlHD+a2Px1sceffPZkoZDiX+BDlYUwpoIxR4?=
 =?us-ascii?Q?bt5EnXpLN/FsiuUlugWOjmfrCUWrip+zt5GdkWv+769buEbxi/MrIR8SyM0M?=
 =?us-ascii?Q?y+uF432vCP2GTRu/CEEJG/CCTs9wEWIeIfup6yIKv+e01zumnak1ZDx5OJZx?=
 =?us-ascii?Q?z0VfqbapewNm+/423omaPRaD483F3/aDOIUdqJO/1+NxwmF/MrVjd49dPJ3k?=
 =?us-ascii?Q?sY2grFiUxImIiQ7RaMA1nXRhN7SrGkJlAkzO6qnoUEWTzkJUEWfm1A5PMDiu?=
 =?us-ascii?Q?NHp62ugRT7gO1rH/TiLl6wft5dPPRl+3/tMByGMETUytIT9qKmCueNUk/W01?=
 =?us-ascii?Q?38teC/7X+DfuRilTbIbrtrqfJmUOP15Li/joBoXUeefuXbPjhdLSo/FSgJqq?=
 =?us-ascii?Q?c/4LBbSvwLxNmGK6YPEj34Ro+oJ0OJ/AJnLI83X6X8q7/ynrgr0/iSrpj2qZ?=
 =?us-ascii?Q?btp6oJx0i6xAa3YD7OI2IjLneBaUHv0MOJnyjpk54+HgLbTP3i3GLxIBe7la?=
 =?us-ascii?Q?HhnDdInMwk+rdg0NWUI/vDnFh1p2Is/MJXDtk1zj?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 577d2be8-4c0e-4c75-afd2-08dad0e3abf3
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2022 01:55:48.6757
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x8PDpUH1aYISTTddBODvJEFXFZARBCKiMc4ZyPHoUMg4e4h43+jV6ybkTmt/zdnvpZC9if3Nb7YwZ2W6jPr2eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR21MB1512
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> From: Sathyanarayanan Kuppuswamy
> <sathyanarayanan.kuppuswamy@linux.intel.com>
> > +
> > +u64 hv_tdx_hypercall(u64 control, u64 input_addr, u64 output_addr)
> > +{
> > +	struct tdx_hypercall_args args =3D { };
>=20
> I think you mean initialize to 0.
Yes, it's the same as "struct tdx_hypercall_args args =3D { 0 };"

I was educated to use "{ }", which is said to be more preferred,=20
compared to "{ 0 } ":

https://lwn.net/ml/linux-kernel/YG1qF8lULn8lLJa/@unreal/
https://lwn.net/ml/linux-kernel/MW2PR2101MB0892AC106C360F2A209560A8BF759@MW=
2PR2101MB0892.namprd21.prod.outlook.com/

