Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A998264ABA5
	for <lists+linux-arch@lfdr.de>; Tue, 13 Dec 2022 00:41:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233918AbiLLXla (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Dec 2022 18:41:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233761AbiLLXl3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 12 Dec 2022 18:41:29 -0500
Received: from CO1PR02CU001-vft-obe.outbound.protection.outlook.com (mail-westus2azon11021023.outbound.protection.outlook.com [52.101.47.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A98B21AA01;
        Mon, 12 Dec 2022 15:41:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jT2p9PvydCdVk773U7PyuDEU2/oWBNClS74opL4YN3NV6NT8x6kfod4HuMCJ54hu4osYpDce5oStk2ZkD5Urgz1FjV2+Zjda29Svcc+LPqxh+q6Pn2oCsN7x3ivQLdjj5m5ECcEh6ZqY4jCCHrAfJFze8J95HXXddS3mQtK36CGASnEXJac14yp2aXeKPTK6eZLihP3hTdxXWCBCuWoNdLiuOhCPVAPKpz6DKxI4SgFmzbL5nKxK8YcEIWyuJSrLONLY6tlyFeJI7zYGtJvotMrYfoB5u4y0A8s3Wun+8jf0tj4ztJOv4nJxhmQxUrwYtqegj6zHyd8wX+wABqh3oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dg/H7kmk9bFsF9Li6AqwcD05i/dRdV5pttlbfEZf52w=;
 b=aBki50cl9MMvELiuAcL0tnEj+secmHdgbQo1UtLlLFtWhu9eZ3a4kCpwEeCkHt+DltWqDbLOs1WnMAfEHEJ1Sh8CrNdIbkpqMex7Y6fH8oM8OPbi8nf/iWKX6ILmdfvwvSohEoKOsed7vC+OC58mqFdwm61EtayTw6PHqNJAc8/XLgT0l3JEy/kv+i2Fi7sXAdcWWHfIprW4zFYlKzT6pogr3ho/G+4re00iMX8Iy9Vame+hx80wI0+xa112BhzXdkyCmESM1htzO0OVTb3zu78mjzKD6b5WC6/XUhFVn1xv8McW5/4+ce5rVzL3IACy2MgS+CVrzfGz/4ZfavxXUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dg/H7kmk9bFsF9Li6AqwcD05i/dRdV5pttlbfEZf52w=;
 b=BwH6ODwsrTyMYEA/aNYh0evYKmdgBGuj4fF8yPpfFmyusowL1zrzKF+qNPWJ+8S2Lo+d7O+niyYtzArOHMEiAP4lJMQNd/XS0bysaNaxyEvnF7lf9jRuvpx6eW9R342m9zlU04QPdRZKKVwxYft+iNkGjtronZ9xJk3BqTLBtSg=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by PH0PR21MB1909.namprd21.prod.outlook.com (2603:10b6:510:1a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.1; Mon, 12 Dec
 2022 23:41:22 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::1e50:78ec:6954:d6dd]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::1e50:78ec:6954:d6dd%8]) with mapi id 15.20.5944.002; Mon, 12 Dec 2022
 23:41:22 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Tianyu Lan <ltykernel@gmail.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "seanjc@google.com" <seanjc@google.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "jgross@suse.com" <jgross@suse.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "kirill@shutemov.name" <kirill@shutemov.name>,
        "jiangshan.ljs@antgroup.com" <jiangshan.ljs@antgroup.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "ashish.kalra@amd.com" <ashish.kalra@amd.com>,
        "srutherford@google.com" <srutherford@google.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "anshuman.khandual@arm.com" <anshuman.khandual@arm.com>,
        "pawan.kumar.gupta@linux.intel.com" 
        <pawan.kumar.gupta@linux.intel.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "daniel.sneddon@linux.intel.com" <daniel.sneddon@linux.intel.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "sandipan.das@amd.com" <sandipan.das@amd.com>,
        "ray.huang@amd.com" <ray.huang@amd.com>,
        "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
        "michael.roth@amd.com" <michael.roth@amd.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "venu.busireddy@oracle.com" <venu.busireddy@oracle.com>,
        "sterritt@google.com" <sterritt@google.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "samitolvanen@google.com" <samitolvanen@google.com>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: RE: [RFC PATCH V2 05/18] x86/hyperv: Get Virtual Trust Level via
 hvcall
Thread-Topic: [RFC PATCH V2 05/18] x86/hyperv: Get Virtual Trust Level via
 hvcall
Thread-Index: AQHY+8njFYnmYWgVVUSo8TRftAUpqa5rCOyg
Date:   Mon, 12 Dec 2022 23:41:22 +0000
Message-ID: <BYAPR21MB1688987551ECAB717D62D301D7E29@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20221119034633.1728632-1-ltykernel@gmail.com>
 <20221119034633.1728632-6-ltykernel@gmail.com>
In-Reply-To: <20221119034633.1728632-6-ltykernel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=41cae89b-9d32-4136-a637-94d4f974f653;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-12-12T23:19:57Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|PH0PR21MB1909:EE_
x-ms-office365-filtering-correlation-id: 19fbe7f3-9f1a-4cf2-5bab-08dadc9a6077
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4gG6irClOtsffuW4f7hkpMPPtm6gRSQEWK4mR1u97VJcIxyX5Zpfpd3PvMeohlYB6HiuA1rsFbk/FYnvfFOB0TbLHarAPNV8mabA0cT/30uViEdhTENfssnRzMwMCftuqSQDwPU/fRUinbfjB0SsPrtckIVbmy0O+SETlQwiWVnyDhxnKAXGr5Y4poGI6RbI0G7bSVLSSjN/yZUHQdhjoYl52JIQfvsmbwq1C2zflFSb7LVrdV+n0pBbVaT/+3898o9/iLo5zUnaueerNEs/2oY/uAwcO5VyXQUhB1j2INVnrxmZsYgCt3c+joxNLf/toczqt0kS1NFuNJXxwTauI4N5NdhiyezVZZb/6VZtj4ZStsWQy12ah4RmEeMbCQhJmOP4n+eXQCg50omA1j+SXxqJp1/Dkg06uAkxlMOK9quM6l6PB1/NIuN9kJJ7NpXtoZWd31RC2QrSw5WOUbh8kNbF/j6kH6uLWmUjcG4rakG2m8cyruuXKTXfJFUUXGIgOPc71J4C/FFIO88fGBKlZBQxB+rJA3TO59/YBR3WlLFlJcShsjfji6XsMK5Jrkgz+eiBQJwwNQX3zW3QpcWNQ4XlGFgmESvWXBQwxQIErQtrHH4nEHYFjqaVIZP2Dut5r3n1qtdXArMCvTGYnvibUKssLKIkUcp9b/z3Wxnmga//h2znNWbdlS+hAUAmYoz3MTMd+ue7dlrV88VuBCx9KH9pcMy56qrvwRtETrzBYNGD3+dJ7BtM+nVXFKCAWsm3EIRVTBqHpriqM0niBTJI0w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(346002)(376002)(39860400002)(366004)(451199015)(52536014)(41300700001)(7416002)(8936002)(7406005)(10290500003)(110136005)(54906003)(38070700005)(8676002)(66476007)(4326008)(66946007)(76116006)(86362001)(66556008)(64756008)(66446008)(316002)(2906002)(8990500004)(478600001)(33656002)(83380400001)(55016003)(921005)(38100700002)(82960400001)(82950400001)(71200400001)(7696005)(9686003)(6506007)(122000001)(26005)(5660300002)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RdedEWVsnYvwxgXe5tUaUhU62/uiMNbHXLOGWJaiGerAymNrLOCZrLPtB7mA?=
 =?us-ascii?Q?iHhmg9NIG47WbpDT2t1bimIRgJ3kXYPapqKz0wpVMMl3Vpxe3mtZbUg503L4?=
 =?us-ascii?Q?wuMQABJ7QpL1e+7QJDN2QzbTrgLHvYcVYQzH4fUn+oPQw4KDP4yHw/6YVsjk?=
 =?us-ascii?Q?QOmUXbzz0Qhln03PjqHzD6DElQ4+EPPoXCxySx/QM/j26niARXONTc6khZIU?=
 =?us-ascii?Q?9ObWjK8JDJ12WEdHHn0udUPIxKECH6sD4qy3mG3xNmr9yFHMA9+DT7aP05GM?=
 =?us-ascii?Q?qyv3AETW58j6vipZ3x2nzqSA1VteE58an6PN9nwBaehDe+PVp4oeQLVoiFTg?=
 =?us-ascii?Q?SV7rfA4fHkrds0RPxK1ueft/y1m5lfpQnhbzqgi1VM/M5AGDkLOIVVCiT90i?=
 =?us-ascii?Q?dMwdvzVine46ahyFBr2JgLfYh6D6Z1hsMGs6nMMaK0cKKBS74Y3qSvSYMHcC?=
 =?us-ascii?Q?H9rA505RcmAiNhMx4uRkpxGkhTQKfHZ5DdDpTn4wHdqUZZ5XbHl7Pol/b2hi?=
 =?us-ascii?Q?xuFcCEb9872XaU7dSwyU+lxnnD+a/mww07XZeIdJf2DfuQDWbdX6CwbT2d99?=
 =?us-ascii?Q?z3S6UsT1NY3z4+TrKA2vEe0k2kxCHe9dVkxPclgt5/7dOxwii+SrfFO33fx0?=
 =?us-ascii?Q?Qsj88bzpGsRr3vETYw7Om5KhLaADpnMS475HXAQufnIoJ0brQXvvEapKTI60?=
 =?us-ascii?Q?5wgzo6/tLVCsblnq2D8keJSpHkD4jqrPwOlUacQrJTzTf6nmReMowUSl5as+?=
 =?us-ascii?Q?MXDtBu81V2CNlXQkvNRrLoveCNRjD8gliErpx933VcSy+RzN0fyyfaqacjYd?=
 =?us-ascii?Q?xmTHz/ezWtPq1YTOm8DgJhPj1UZlKhd26Tv0ACORHJ3e/BqBXdAxM01jMash?=
 =?us-ascii?Q?xuhxOGTji+Q4Z6VccqLsbvN9f7jERC2YOLZAPrnl+9wzoqzungUyj19UsE9v?=
 =?us-ascii?Q?r53euAbR7jMNdGCCELVujICcKnKCKhqq3iOUh6ZzOotdMN635yFnxkyZMRT9?=
 =?us-ascii?Q?B+ThSRzx3iQVLNEA6RP480WUy8jy/gmzytl36KgNkgtUGbUsPnfFR1VQCuLg?=
 =?us-ascii?Q?5ouCGYTXGMW5bBUJTKqSzKOMaZe6JpXX73cc1oWhaZBfggluzrDmOoY/Kat3?=
 =?us-ascii?Q?9bE+n5K7jvBsmbyKp+WbTr5wXb+4Up2/++6KLw8igwsXmwkda6N7pERK3XnH?=
 =?us-ascii?Q?HoQdIPSBT9JAtOj6jkr/cSz0h8Toirai0Gu4gruKgY9GLkU04NM4OvKXMPAT?=
 =?us-ascii?Q?LnYf7XFFvC1UdCQknlHOUVN5v0O2EDSYOGM/R2duFP7/Deb1rTfBc6f50csy?=
 =?us-ascii?Q?OpDIB9LMk350Bx51RWQMivS88wCDXxAIS+X1i4oEfWOE6YqbjssLJiD7Tnm5?=
 =?us-ascii?Q?fVwfVIJ/PSCKp9+/pGXPBJmBRwgjJLGUmAxhJ/1VBFyM0HQnOO2dfLQV7TOl?=
 =?us-ascii?Q?SCTsTvoB1gAOrWO1u0hqo8jHRWHip8B9fr+mZq4OvQT8atjpdKrl8P541IrL?=
 =?us-ascii?Q?ntn43f9DesNoJ4MtCnHJSXGThfKWzhZcgGXPishr7+MwdN7JWcWDQy008yGE?=
 =?us-ascii?Q?w1Mnt/9x5eQGYn1X3kDrn4zW68l6/Dsy2oN394JS3uu89K/F31cuzq55+nx9?=
 =?us-ascii?Q?/g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19fbe7f3-9f1a-4cf2-5bab-08dadc9a6077
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2022 23:41:22.7387
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6Yp004L3pLtQstj0gUAQqW2TWs5BLmRYdsj1S6lFPg5POzIiRsi5piAagdx0zSPPDmEM54TEhc3I+6fJ6rF1/qSTyL8CL7IWkstj0Og5GTk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR21MB1909
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Tianyu Lan <ltykernel@gmail.com> Sent: Friday, November 18, 2022 7:46=
 PM
>=20
> sev-snp guest provides vtl(Virtual Trust Level) and get it from
> hyperv hvcall via HVCALL_GET_VP_REGISTERS.

Two general comments:

1) Could this patch be combined with Patch 9 of the series?  It seems
like they go together since Patch 9 is the consumer of the VTL.

2) What is the bigger picture motivation for this patch and Patch 9
being part of the patch series for support fully enlightened SEV-SNP
guests?  Won't the VTL always be 0 in such a guest?  The code currently
assumes VTL 0, so it seems like this patch doesn't change anything.  Or
maybe there's a scenario that I'm not aware of where the VTL is
other than 0.

>=20
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> ---
>  arch/x86/hyperv/hv_init.c      | 35 ++++++++++++++++++++++++++++++++++
>  include/asm-generic/mshyperv.h |  2 ++
>  2 files changed, 37 insertions(+)
>=20
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 4600c5941957..5b919d4d24c0 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -390,6 +390,39 @@ static void __init hv_get_partition_id(void)
>  	local_irq_restore(flags);
>  }
>=20
> +static u8 __init get_current_vtl(void)

The name get_current_vtl() seems to imply that there might be a
"previous" VTL, or that the VTL might change over time.  I'm not aware
that either is the case.  Couldn't this just be get_vtl()?

> +{
> +	u64 control =3D ((u64)1 << HV_HYPERCALL_REP_COMP_OFFSET) | HVCALL_GET_V=
P_REGISTERS;

Simplify by using HV_HYPERCALL_REP_COMP_1.

> +	struct hv_get_vp_registers_input *input =3D NULL;
> +	struct hv_get_vp_registers_output *output =3D NULL;

It doesn't seem like the above two initializations to NULL are needed.

> +	u8 vtl =3D 0;
> +	int ret;

The result of hv_do_hypercall() should always be a u64.

> +	unsigned long flags;
> +
> +	local_irq_save(flags);
> +	input =3D *(struct hv_get_vp_registers_input **)this_cpu_ptr(hyperv_pcp=
u_input_arg);
> +	output =3D (struct hv_get_vp_registers_output *)input;
> +	if (!input || !output) {

Don't need to check both values since one is assigned from the other. :-)

> +		pr_err("Hyper-V: cannot allocate a shared page!");

Error message text isn't correct.

> +		goto done;

Need to do local_irq_restore() before goto done.

> +	}
> +
> +	memset(input, 0, sizeof(*input) + sizeof(input->element[0]));
> +	input->header.partitionid =3D HV_PARTITION_ID_SELF;
> +	input->header.inputvtl =3D 0;
> +	input->element[0].name0 =3D 0x000D0003;

This constant should go in one of the hyperv-tlfs.h header files.  If I
recall correctly, we're currently treating VTLs as x86-specific, so should
go in arch/x86/include/asm/hyperv-tlfs.h.

> +
> +	ret =3D hv_do_hypercall(control, input, output);
> +	if (ret =3D=3D 0)

Use hv_result_success(ret).

> +		vtl =3D output->as64.low & 0xf;

The 0xF mask should be defined in the hyperv-tlfs.h per
above.

> +	else
> +		pr_err("Hyper-V: failed to get the current VTL!");

Again, drop the word "current".  And the exclamation mark isn't needed. :-)

> +	local_irq_restore(flags);
> +
> +done:
> +	return vtl;
> +}
> +
>  /*
>   * This function is to be invoked early in the boot sequence after the
>   * hypervisor has been detected.
> @@ -527,6 +560,8 @@ void __init hyperv_init(void)
>  	if (hv_is_isolation_supported())
>  		swiotlb_update_mem_attributes();
>  #endif
> +	/* Find the current VTL */
> +	ms_hyperv.vtl =3D get_current_vtl();

Drop "current" in the comment and function name.

>=20
>  	return;
>=20
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyper=
v.h
> index bfb9eb9d7215..68133de044ec 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -46,6 +46,7 @@ struct ms_hyperv_info {
>  		};
>  	};
>  	u64 shared_gpa_boundary;
> +	u8 vtl;
>  };
>  extern struct ms_hyperv_info ms_hyperv;
>=20
> @@ -55,6 +56,7 @@ extern void * __percpu *hyperv_pcpu_output_arg;
>  extern u64 hv_do_hypercall(u64 control, void *inputaddr, void *outputadd=
r);
>  extern u64 hv_do_fast_hypercall8(u16 control, u64 input8);
>  extern bool hv_isolation_type_snp(void);
> +extern bool hv_isolation_type_en_snp(void);

This declaration of hv_isolation_type_en_snp() shouldn't be needed here
as it has already been added to arch/x86/include/asm/mshyperv.h.

The declaration of hv_isolation_type_snp() occurs both places, but I
think that's some sloppiness from the past that could be fixed.  In fact,
hv_isolation_type_snp() occurs *twice* in include/asm-generic/mshyperv.h.

>=20
>  /* Helper functions that provide a consistent pattern for checking Hyper=
-V hypercall
> status. */
>  static inline int hv_result(u64 status)
> --
> 2.25.1

