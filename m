Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC22D63B1D2
	for <lists+linux-arch@lfdr.de>; Mon, 28 Nov 2022 20:03:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbiK1TDn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 28 Nov 2022 14:03:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbiK1TDm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 28 Nov 2022 14:03:42 -0500
Received: from na01-obe.outbound.protection.outlook.com (mail-westus2azon11020017.outbound.protection.outlook.com [52.101.46.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 362E727FE5;
        Mon, 28 Nov 2022 11:03:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SBzwhEf0+tpsYz25ZuSyURt1ZT/C4AEyLAxRggn9v00sgdmIXIMOC+sBcLW5NbaxEhtPy/uqhHr4lgPwNeIcwVsNuIDm+F0yPbDMkPcSzL+9V5+CnaFdaEWuhLGjiiJEJyICiK2kzc3OxVYywkAMzl0THP5dZ79rvaKECT6Mx3UVRrXcJ9uKFnI9FpRA7mGtSs7vD7dfPCXzQAaoiKlEGuekAcaJ9UgN8I3uoryyqv93Oo5+UVOH0ZM+8f0fdAcJAZLLkX8p5lGr/Jioi5FQ8LXCM8pD7SvkLgJ/gxObTlGfRLrozxw6+KSwuvxwoppNiyAhWZx9VgJBxiOQ1Nsyxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EnAxH4w27XnZYl7oQPuhvlW9ssXyMtAmDVm3tmypsg8=;
 b=FbE9H9VE7hObyI89ZtrjeBoiqRcQUSpLkJhG1X4hdy70w0geZPPQZz1vlFGGBCYWRDNwwDyTg+plbMYOtXj71fDBfqBpddNtC0bEMbDymIHgD6fA507+vMFC7WFU+NXPyd5cd2awtvIhAQlRM/AbxPf0sXxOeKrYG2YpGIIceuXsmVQ6FxKoRzNWeREyvjtBU9fkDtUaMcJqBsnAFH3ANR839vi2Eew5IzCf94Wx0n48Q6RlrNQtyt/+yhA6APPb9xN7k137poC/eDiDdptIMYblqgti7xgYCf7esa3M+EQaSCo9Fl4cOpG6IzgZY1dpc4imhsFABj2wSI68Fg7eOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EnAxH4w27XnZYl7oQPuhvlW9ssXyMtAmDVm3tmypsg8=;
 b=Xrk6rrumF/HhmlIthwjPoX5q6urqzT24ZIbFX6m5L4+uzDV3iom83h6mwA2g8lCGnyY6Iend4Dx/x+4eIGW8eqf+nVMJxn2r3qdns83kkhECT6TIDY/xbBLSuyp1koFLll0U/SxUvsnYZMnJwXatpCQ4tldM7KBSocLXOA6KgEQ=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by LV2PR21MB3062.namprd21.prod.outlook.com (2603:10b6:408:17d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5901.4; Mon, 28 Nov
 2022 19:03:38 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::ac9b:6fe1:dca5:b817]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::ac9b:6fe1:dca5:b817%6]) with mapi id 15.20.5880.008; Mon, 28 Nov 2022
 19:03:38 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Dave Hansen <dave.hansen@intel.com>,
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
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "seanjc@google.com" <seanjc@google.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 5/6] x86/hyperv: Support hypercalls for TDX guests
Thread-Topic: [PATCH 5/6] x86/hyperv: Support hypercalls for TDX guests
Thread-Index: AQHY/0oyvJMCdibbbUqzNA0JVsxn0a5TiVBAgADyjYCAAC5pcA==
Date:   Mon, 28 Nov 2022 19:03:37 +0000
Message-ID: <SA1PR21MB1335BA9D27891F6B1BA3A988BF139@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20221121195151.21812-1-decui@microsoft.com>
 <20221121195151.21812-6-decui@microsoft.com>
 <BYAPR21MB16886270B7899F35E8A826A4D70C9@BYAPR21MB1688.namprd21.prod.outlook.com>
 <SA1PR21MB133528B2B3637D61368FF5FFBF139@SA1PR21MB1335.namprd21.prod.outlook.com>
 <b692c4da-4365-196d-9d12-33e2679c01de@intel.com>
In-Reply-To: <b692c4da-4365-196d-9d12-33e2679c01de@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=016cb6e8-3fc5-45c1-82dc-47d29acec223;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-11-28T18:08:33Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|LV2PR21MB3062:EE_
x-ms-office365-filtering-correlation-id: 4c9a53f9-b57a-4795-abb3-08dad17341b8
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sM5uP+LdgrzydVLXqszZNNuzGed2geN12WzashYVUTwYei4hcSADiB78ug+RTEhYTVb1S7W8bc9kDvrmiRtclC1g9gZo12cUj+fObfq+c9G+rnFMVzBNOflyliTXGnhvX5yamvtsCHJgCWMzAvV1PLbR+dVrTAKBMpdvTAkONBJaSijJgKzMcpz6Bd7oQZM0bGVuYn9eWHT3UzK2O06AEUZaPd1SpUlMW6pEePN1o1psHgFCBGUmHvN9FJoUPJZ5wYypoMcvHScWX9sbLIMEkNzfO6FXKZYuYoJ0/V2CBlR0EAZIMeU+nqTJhhyDlI2En8t/pq0oRTWNUcuvKr6bDDgILB6q/ECEMN2lxVY5S0hoHECT64tIcrw75A814ITWI4y0/6Zd2QK8lKvBahNKcrUDGWtqWCdeakhBJucRXO16GVawu1Ut9CIwLx8pofPdSyPH22oxNwxqiBbyvQ4Gz6W3F/R2WDM1aDGFNVZEsYLCA1f+iJbutcm1sgwW4ACVLZPolim9Jd3+jICbTzV/RHGdSkG/GVa/bZfASMyBhv8YA9YgSnxrq2j/VknEx0RZ8VBxESWGMs5U0CgzcYCr4bycMvEmbNMmx/J+k1sjQ7cd2baGdpYHptPjst4CZTFYXWJmlivTqHQ4E4to+3Sc/k5olpNTFo9IzdStM2bIehVIl6NhNfG1wuTsmtjKDPukinxSoRPGkVnMDVjegBzbd8kIWdf+ilgFbRAzmc96XmZvW3Gl4bC1Bes7+TLc33k7bPLsWSGkM5K6KYgOuXdMNw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(136003)(39860400002)(376002)(346002)(451199015)(2906002)(38070700005)(8990500004)(33656002)(55016003)(86362001)(53546011)(6506007)(9686003)(7696005)(26005)(186003)(38100700002)(71200400001)(122000001)(83380400001)(76116006)(66476007)(66556008)(66946007)(64756008)(66446008)(8936002)(52536014)(7416002)(4326008)(8676002)(5660300002)(82960400001)(41300700001)(10290500003)(82950400001)(110136005)(921005)(478600001)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BOihpeIiAeEmKBnGwvHWF1Y74k6GfxvPZk5vlDOVpHTp1X5YF1utyOqcQmNM?=
 =?us-ascii?Q?nQrshkUZ3w6f9hooKTadcg9YMkquAvUQtA2fcXzvDalHga2sfhfmxqGyurvD?=
 =?us-ascii?Q?UQeRD6QQbo0SoJ8ws+uk6K8DC9KFbzpshK+eEMviYpZ6UHf6uZ3tLOe4yCGN?=
 =?us-ascii?Q?wO8I0/STMf3Pyaq2W2JAXAi9kLF+OvDZVUAjFGORUXEihDkdALpyCGiyhdh5?=
 =?us-ascii?Q?BjMolexr/gC0DnWO8kqmfXYRBOfaqqeyZEuodKVqPiaFPC4crlaESqzgjExK?=
 =?us-ascii?Q?ZO0NwLX9LuCby4FE8FeaiJyhbZYYsxxbvOIMtxaGCQoPfsak6nQZoTCuPqpt?=
 =?us-ascii?Q?Acy/sROKY1m/OmtUAagASFj2dCdH+LJy7GWZL3+Wd4x8PB/vPjjzopwBhuil?=
 =?us-ascii?Q?cfBauNsO5Lm3238/QRCVGixkQQ69iZauk2NbYjEAfbxKOVynMw4oqjakUc+2?=
 =?us-ascii?Q?1Zmvxpv+qFV+gFkP9dvIaOpZXYu77HAB9cJnSPmzfUb3GqWzVQwaKrcwGjTE?=
 =?us-ascii?Q?djU9dXKzWAB3LP9ynAqbZPZ5i25ZybgQgnEJ4z5bX6e5cSs3cBtQp0Iz7kHe?=
 =?us-ascii?Q?l7pNkptKO14Un6acXwLJCQ2wPaynwsTgLc6bxYaZT1tiQjtU8LtpydPRNJ30?=
 =?us-ascii?Q?gnRwGYyptFnTnxr4WKoYzRGirnWQ06dKsg80ZOSMvyWj6DtF0vPF9CTnskem?=
 =?us-ascii?Q?vlHTWMynjxnXGPi/pjOrl8Bhk5UbBm/QyaPAoWYDQDufTjZKFN5t8OJYKZyi?=
 =?us-ascii?Q?G1c0h/wmE2XnWYPS/sx7ZLEIXmgAWfvDtU0fmPdc64DEx5U98W7jcSoy/p29?=
 =?us-ascii?Q?hxG2QXSSveVEDP6WFDoDw7ArRU8TIeyFuK7cts+kDXaB8TclsprDb2eB6dJW?=
 =?us-ascii?Q?t70znvWToaxas7SqNuA19xDWeGgRtsh4vSFaHVeBHyNRVDPxtODxKk/1bXyG?=
 =?us-ascii?Q?0WEniq15Oa8CRApwJUsN7qluaiEl2bZebIyH0qupHj5ephhYsapcGvsyAMCN?=
 =?us-ascii?Q?E1z64GfRiJUiOtYTgpjfmC7Y3JVqgNtp8bl7V/H4n+CiZhfy8ZuC0fKnSUF9?=
 =?us-ascii?Q?sn+nijPdS1TPWtAlE3dCqr24LgGzwz7iUNQ3QEvdyH32UpaZEbJ0nxzp3SPV?=
 =?us-ascii?Q?dXjE308ldd2oaUoFgjlmRbl1UufQ5iadNCAncE2uTtjXWP+shTCEjYM87p0Y?=
 =?us-ascii?Q?8GwCH6TdzmgGYht3Uzcyvum1ACF/EQd/f6iPJZL+wNZlDgxltFZBLkdc2+lr?=
 =?us-ascii?Q?beyDc5Sq6NBB/q6X4KYMRAbfvDey3qKQwOTFKbVJVAIVvcCP7tguWO6Nn+ck?=
 =?us-ascii?Q?e3fjksn37+QtXoRp3mOx2AK0NdMFjlxZlK4olMvYa2skOnWn1w95Nx92lqR9?=
 =?us-ascii?Q?0pHh1bF7bvrxNTsfZjU4OZrmKfRILVIt0xIR8LmGOgkVSD1IdwZn/RM930+G?=
 =?us-ascii?Q?b2IzcvyaIHk1M4Zke0SiBBtJnlm0bbu/JuT7keEdsQlRISBJUtcEK7Gs5ApM?=
 =?us-ascii?Q?Sh3gCJ7sJaJ8mV2XY1ydVyHyoEUzW+L2Xh9wqEywmLjdOgvoyRE3N8NOE1Xs?=
 =?us-ascii?Q?kIJrf+ikGJvFtpS29qWWFVux7Mj23OLznz/ipUz9?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c9a53f9-b57a-4795-abb3-08dad17341b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2022 19:03:37.9943
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yyoMlKq3lTnhXjrgv1k4ssUgENhhDi30NZzxQi2YwBFZixehmmTrNtYm7kcOUc5OLnY9KBttU+sm/iSTQ557aA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR21MB3062
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> From: Dave Hansen <dave.hansen@intel.com>
> Sent: Monday, November 28, 2022 7:22 AM
> [...]
> On 11/27/22 16:58, Dexuan Cui wrote:
> > +u64 hv_tdx_hypercall(u64 control, u64 input_addr, u64 output_addr)
> > +{
> > +	struct tdx_hypercall_args args =3D { };
> > +
> > +	if (!(control & HV_HYPERCALL_FAST_BIT)) {
> > +		if (input_addr)
> > +			input_addr +=3D ms_hyperv.shared_gpa_boundary;
> > +
> > +		if (output_addr)
> > +			output_addr +=3D ms_hyperv.shared_gpa_boundary;
> > +	}
>=20
> This:
>  [...]
> makes it sound like HV_HYPERCALL_FAST_BIT says whether arguments go in
> registers (fast) or memory (slow).  But this hv_tdx_hypercall() function
> looks like it takes addresses only.

Good point! When hv_tdx_hypercall() is called from hv_do_fast_hypercall8()
and hv_do_fast_hypercall16(), actually the two parameters are not memory
addresses. I'll rename the parameters to param1 and param2.=20

I also realized I need to export the function for drivers.=20

> *Is* there a register based calling convention to make Hyper-V
> hypercalls when running under TDX?

When hv_tdx_hypercall() is called from hv_do_fast_hypercall8()
and hv_do_fast_hypercall16(), the params are indeed passed via registers
rather than memory.

> Also, is this the output address manipulation fundamentally different fro=
m:
>=20
> 	output_addr =3D cc_mkdec(output_addr);
>=20
> ?  Decrypted addresses are the shared ones, right?
Yes.=20

Good point -- I'll use the updated version:

u64 hv_tdx_hypercall(u64 control, u64 param1, u64 param2)
{
        struct tdx_hypercall_args args =3D { };

        if (!(control & HV_HYPERCALL_FAST_BIT)) {
                if (param1)
                        param1 =3D cc_mkdec(param1);

                if (param2)
                        param2 =3D cc_mkdec(param2);
        }

        args.r10 =3D control;
        args.rdx =3D param1;
        args.r8  =3D param2;

        (void)__tdx_hypercall(&args, TDX_HCALL_HAS_OUTPUT);

        return args.r11;
}
EXPORT_SYMBOL_GPL(hv_tdx_hypercall);

