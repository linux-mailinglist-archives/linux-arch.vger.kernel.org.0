Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD7F6DF7FD
	for <lists+linux-arch@lfdr.de>; Wed, 12 Apr 2023 16:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjDLOHO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 Apr 2023 10:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjDLOHN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Apr 2023 10:07:13 -0400
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-cusazon11020027.outbound.protection.outlook.com [52.101.61.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA5B71738;
        Wed, 12 Apr 2023 07:07:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SZEgzD/spTYShf0WxtyjRURth384AFJ6RQ3x5zhAO05iIt/XxtWwriv7qnv5pGZfMHQ+onhxGGQ2d/Tn2Sea2BbIxfocxQN3sCSqjGDtm51CKc7QgQWhd0XXg3lAYNIF523pTbDL3gxs9gAJhv9hnYI2jhV14HrPTl4I52QM7rlAsMOX9kXUJMcHw1aTdtiK8sPvAaMpaFl7TF62+qwOoWnpwBHWSIagH083N3aSyK4z83IjtqSReCLDUkU2CjS74+Nf+8kkFj5a3POudsbYn4l2BDdYoZTE9DMdnj/5r4AHfgKs92Z5fN6SpXbAShE84URlsHAQ48PN4bcXSFQaxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VXHXczecqLkMDme4iWTMgKfmKpGNZGUVDNOlglxwJ9c=;
 b=mV5RhLWVVLjbIsQrxxZfbEok3C/dsGrNvgT0nVHm+TlEZCOCZwnEWP1kBiWEoTw+3M40FOcDCgXdz0Jtlh4L5qqA2t050yE0HlIw5CY6qyziLKB6Vqbh0KXD5+HK93TwPo9Iwhe37fUkyD4PY+GB/rkhFQI0CTfiF8HSSWTyMVxh8jhKID4wLa75D+Ge4BNhkHO/yYcNnBFTeW4HO+QfIdfVZ7wUtC/THW33V0f25UFITX4G8JsNTcDgPBcQdPhlstv4w756Unoy3S8QDgoaVghYrWjIyiR2AoMtoWyEq2cFNbFoxgQ4wmkF2F6c80dwzbE2Y/hgIoNqEu1Wpp1nxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VXHXczecqLkMDme4iWTMgKfmKpGNZGUVDNOlglxwJ9c=;
 b=NveEYpy9E1nb+ZB3PBxUshorDdGHPHQmIcP0vcBAKZJn3wZyoTyIWQpREix56pG3E8qG6mX/s7KzBJIz4AQUnjQbi+if/BqdIbH+uky/oEGvdS4XurkPJjACXHjI49fncYjewhXPiTjrGRqrSEnYafmtvsY41z0yFeV5ISWJSXo=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by DM6PR21MB1323.namprd21.prod.outlook.com (2603:10b6:5:175::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.4; Wed, 12 Apr
 2023 14:07:09 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::acd0:6aec:7be2:719c]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::acd0:6aec:7be2:719c%7]) with mapi id 15.20.6319.004; Wed, 12 Apr 2023
 14:07:09 +0000
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
CC:     "pangupta@amd.com" <pangupta@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: RE: [RFC PATCH V4 02/17] Drivers: hv: vmbus: Decrypt vmbus ring
 buffer
Thread-Topic: [RFC PATCH V4 02/17] Drivers: hv: vmbus: Decrypt vmbus ring
 buffer
Thread-Index: AQHZZlPxGO6+lcTgakya9SZiTz4M1K8nwAAw
Date:   Wed, 12 Apr 2023 14:07:09 +0000
Message-ID: <BYAPR21MB1688575EF76512437278B873D79B9@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230403174406.4180472-1-ltykernel@gmail.com>
 <20230403174406.4180472-3-ltykernel@gmail.com>
In-Reply-To: <20230403174406.4180472-3-ltykernel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=e75eca53-fd4f-4ed4-a366-2ee72c7d6a2e;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-04-12T13:54:41Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|DM6PR21MB1323:EE_
x-ms-office365-filtering-correlation-id: 64c9244f-b496-47e5-3d68-08db3b5f349a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tBvfs2goo8Og6Ey8P2bROiVgbsgcmI4CQK3R40eo3s+knNVN+WhPIiRFHK+0iB6t9ZKrWuYBaLFqD3GIAKtKoskDVcwhlYS+A1UtrLVbJnQnnje581J8+IrivTgsJyL8x8L/iaHurvh3LRxxzui5yT+ZTRottIPGa68GvIKEsFB7RAl8A49FUhA8DmUzrhXQBVTU7p4ZCfxFajnX7AOrXZNsjZafvnL+hjm5TsNZ4cEyIppS1Gn0kPSXNN5aBSYu+HCn3TzvMyZqar80/JQ9aZI06+NbKAoqHamgBfGytD1Q/2E8AdAdGoEtdnR01PUQJMm/P2pLXJOLYWxY2e59EOPhtc+MYGrvnvF1b+e1KWkP1p6aNTUjaY9LMQpWhtLBmGIazWpHKxZyoeOSGIsxpNa7A3dy62mDEvcNgKidd37OES6wInbQszGO7jNsdig9Qa5bi+gtPrfiVHv/guNEPPMr8Orf5BbDr3/VJlxHGf/MKG/kieE3svC4o4iZuFaivO5yCI5Cif0dsoC7hl3LSS63kDFJTRXeKM/7RrhcDuRia0wbtaRvMMoJk63gdOhrz/47rTdOFV0TZ9uIo+qXH9ZFz2wueRfZbldBqzCSK3R3miVgOeGXZZU8yIErPRhau1VsNDFRxedABC5crF3XiAi8stdjyOOzqXDYAmfmYls43xvabPzZD1DirzFtEH37
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:cs;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(396003)(39860400002)(136003)(346002)(451199021)(316002)(38070700005)(33656002)(7696005)(7406005)(2906002)(10290500003)(478600001)(71200400001)(110136005)(786003)(55016003)(8936002)(921005)(122000001)(52536014)(64756008)(76116006)(66476007)(66446008)(66556008)(8676002)(66946007)(82950400001)(82960400001)(4326008)(54906003)(186003)(83380400001)(38100700002)(41300700001)(5660300002)(6506007)(26005)(9686003)(86362001)(8990500004)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?miBlyaSKEHbPkJopwpn4y4u2rhx0smYmoWhN0IXOaC6423bBZ2QMXKdshW6N?=
 =?us-ascii?Q?OWeqKwqLHKeUeA9T+wWUCdylnD0fXyl/dGhS6/WDCe8xhkqgpjxw1/BI7nCf?=
 =?us-ascii?Q?CUynnDRl7dHn+Vs57NE4f+4hZEOFc4yKHe8ZilV5wdjZTvoknt4r0omOxmRE?=
 =?us-ascii?Q?4dE8VS3Tx1LFd0w77JlbwTiTEhWPpFg6mlxSjeyUUknEYua2ODK1bd5JPvIR?=
 =?us-ascii?Q?egLpjZMl0ubYcArc4yy0rQXzOySaEwm9C55gNEsHA44JLJwy/crMmzshCDS7?=
 =?us-ascii?Q?s5mwiFbuyFBhdT1suNpCDMzuWQHy4mAw8kYmE8Qbzj9wCZF1RwDJyrSu9Txs?=
 =?us-ascii?Q?FsMCcbaTjBzH9lLTCFk7HxAcGPpCQVVv1UkfR+t+5LxvK10VqMy2ygj9W/ek?=
 =?us-ascii?Q?2eiTXoQB7LSCDXqakN1alvnwRveDsx98JPYnJkXHiSrQfYS2+fjQSWyvIE/Z?=
 =?us-ascii?Q?XVMZbDwkqxFDM3JQq8wEvT8HUHqPtCQdpxU7xvNPkx/mm2QEax8Mj87obw6I?=
 =?us-ascii?Q?numUwjBjPNB3z3HLl5hjOz7X+LS+eAm3TXsU5TtlL3thKwaERnLHVbgbFkPT?=
 =?us-ascii?Q?ctIzKPiMkcV2Q/lBAJ7KzJcf+7X03QSWTyFIfbxv/0GKKXM7q36ewsTab4sY?=
 =?us-ascii?Q?Yn0hlA++ZM5NhGaZjQeXNWih6Pl9ieECTyXGXAfCHUf8DwEcmSqaqUNIhrnJ?=
 =?us-ascii?Q?OKbWZ5L7Ca3s1GGKZJ+Xj+eUfKKq7Sb6vraEyR8VHjZsPnUKDTbtqb+1rP6N?=
 =?us-ascii?Q?LrADaEDxS6XXczVpcJXHEupPL2XO30/IGydhiguHt4wAH6dlgUIpgVHf9dkn?=
 =?us-ascii?Q?rHIvH3M7OCBT/dP0A3ceo/SZbEnnwSMbktAF9VapP5cf1ys6lxdbrB3mo/tb?=
 =?us-ascii?Q?2Y3N/WspN0h0AQfFtFwRY2/SusCR6ueWnPWd4/Aapz21+DMAZHCoE3fE5KlO?=
 =?us-ascii?Q?U4gQCt98F412O7L4AtZV2HBhRB34yEtOUFHi1MrsVviqMr6UJwsSC+vuohEH?=
 =?us-ascii?Q?C5GtMYsH1NFv5cp+wr0YJ3koVaiNRxpWgAOFEvTORQImjY1WG7alvwlKYkdA?=
 =?us-ascii?Q?gSl33qaIRfiLMyiFFpnvbCY9Q69NcclIbu7Pj3r8CKeOvsul4c24UeY7sFWp?=
 =?us-ascii?Q?y82ANUjHaxTvHvEoFsdzODfcAsOIoC9AUoqI0AaOsyc/vWjKElhmyf827t6B?=
 =?us-ascii?Q?HN7BcRtajJAAxFaCZRgr3ZtW9VjoTA7lEdI8ZY+yyz2+R/GfHQ5CNyiplrSh?=
 =?us-ascii?Q?q5ncJot66DI8yNE9OOeuqyB4COjmAaB97BZWcyO2RRLAytU/fjbb4uQ+k9ya?=
 =?us-ascii?Q?cYWUN5bK3o7Cv++20fV9w+b/9s8PgwuaHEaeTEcaK5gCWIbsmkPBvZiCB59w?=
 =?us-ascii?Q?XfmEACFdUvJPJJDygf0IrHer/EmvTR3tA9xV0wmmxceUHSCtUq8ZUp4viVvs?=
 =?us-ascii?Q?Yff10Fboac2kv+vPBq5UohEyxykEEjRoehze3ECv0MP+7Hw0Gpj9FRbL6mWs?=
 =?us-ascii?Q?Wl0rl/f1yHtRT+YphupR6oQZXgI2YcDwxBpte6D0Q3x+jGOxdcZLD0AnwBZD?=
 =?us-ascii?Q?quTXpLUNjE6Y/nkxxJCa4G9ov5UFXbp/lddMPIeAZY7IgxdvscP0ekRgFHbl?=
 =?us-ascii?Q?kQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64c9244f-b496-47e5-3d68-08db3b5f349a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2023 14:07:09.3184
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KACmHRkZs/vTMSyAuAAwTqvLhcfJOhzRMIWyzYnEplEym9CdQf8LpoWZ+qoBza63pctAKOi2xceDKJDuhmT4wLcToKzRisakXxy0wM4Z73g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1323
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Tianyu Lan <ltykernel@gmail.com> Sent: Monday, April 3, 2023 10:44 AM
>=20
> The ring buffer is remapped in the hv_ringbuffer_init()
> and it should be with decrypt flag in order to share it
> with hypervisor in sev-snp enlightened guest.

This is the wrong commit message and subject for this patch.  The v3 versio=
n
of this patch had the correct information about the VP Assist Page.

>=20
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> ---
>  arch/x86/hyperv/hv_init.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index a5f9474f08e1..9f3e2d71d015 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -18,6 +18,7 @@
>  #include <asm/hyperv-tlfs.h>
>  #include <asm/mshyperv.h>
>  #include <asm/idtentry.h>
> +#include <asm/set_memory.h>
>  #include <linux/kexec.h>
>  #include <linux/version.h>
>  #include <linux/vmalloc.h>
> @@ -113,6 +114,11 @@ static int hv_cpu_init(unsigned int cpu)
>=20
>  	}
>  	if (!WARN_ON(!(*hvp))) {
> +		if (hv_isolation_type_en_snp()) {
> +			WARN_ON_ONCE(set_memory_decrypted((unsigned long)(*hvp), 1));
> +			memset(*hvp, 0, PAGE_SIZE);
> +		}
> +
>  		msr.enable =3D 1;
>  		wrmsrl(HV_X64_MSR_VP_ASSIST_PAGE, msr.as_uint64);
>  	}
> --
> 2.25.1

