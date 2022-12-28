Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C83E65858D
	for <lists+linux-arch@lfdr.de>; Wed, 28 Dec 2022 19:15:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233372AbiL1SPG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Dec 2022 13:15:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232778AbiL1SOf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 28 Dec 2022 13:14:35 -0500
Received: from CY4PR02CU008-vft-obe.outbound.protection.outlook.com (mail-westcentralusazon11022020.outbound.protection.outlook.com [40.93.200.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 963451740B;
        Wed, 28 Dec 2022 10:14:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lmZbZlch/qWkoGyjNG6PL1iAd2WXs7KI1NJU+6xnQT/yc7QZnN9kftNGCHoIHYioLbtYYx0nckju9eGyQdVsBvIZewXP+ZroC47tnAWul+shU5PRFx4wWtKZXYNVE4c8oNPxg/fK2j7bchi0KRvHiaYSFDwltAYCV/rPq/BB+8INH4Pvz8dJBBX3UcG/qaxQi828fKOZpUD7e6HBRnLefr9Yt6waNChdfiv7hRcd1qd/iTe5GsSaz1u12lKKJvmneZz+ctma9j0uWRq2WakQTeU1sVNmtxPox938oQcW8/StT9m4l/V0N4VBsqlfzr/hJOBbiZWPKEZVB41RWrrsAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OX5MgqDQHibVX6IFp0UYon6YakShHeMzzV08DLg0xD4=;
 b=a1rvuKQsRU61R7xUosa9irzjZf1YzpF2MZYolQsF0QBOzIVlfz4VrBGGivwJQEcT4Zp+hMtKMtjsuzLNyOqEukbW3b+raLx+/L0Sry+D/RunmUSOhxGDc1vtgW1PKNz572r8jFEH26qr0zeP2rgvP8sPJtwOb1nG+e9apheiZzR71KzBPgpEpEXTBnXI80r5B5XrBQz/Pd8ovxoKCt4DTTnrJxb2ESpPzSRudgH36jw+C97mlady3GvIGfHTLLW4JpgsUzlG4BSoczY4kQPpFdj7w50h2IvifwItLafb8g4fg+QVrgR6YMOnzP6AHPMbdWAw7glYD4jKJGaB0lcVbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OX5MgqDQHibVX6IFp0UYon6YakShHeMzzV08DLg0xD4=;
 b=VwfT/gg5zCdiSS/ZwnsL2M87kcpf8FvmyNC5amVNfJgphZAyWBy14Nyn+7HjxTVlNdhKfR49MjmoX/UZsss2o5SKJ2XrAjI9tvteImQBT7v6DSgbFb7wyBgNhKadjz5L+N/wtM+IZrbpUnZoOcetRANyavwvDpMaHv/Mmf+PxRA=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by CO1PR21MB1314.namprd21.prod.outlook.com (2603:10b6:303:151::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.6; Wed, 28 Dec
 2022 18:14:28 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::db1a:4e71:c688:b7b1]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::db1a:4e71:c688:b7b1%7]) with mapi id 15.20.5986.007; Wed, 28 Dec 2022
 18:14:27 +0000
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
Subject: RE: [RFC PATCH V2 13/18] x86/hyperv: Add smp support for sev-snp
 guest
Thread-Topic: [RFC PATCH V2 13/18] x86/hyperv: Add smp support for sev-snp
 guest
Thread-Index: AQHY+8nhYPfPzHVb50aJgQd/QGobaK6DyQlg
Date:   Wed, 28 Dec 2022 18:14:27 +0000
Message-ID: <BYAPR21MB16880F8B27E5BE8D5A2EB884D7F29@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20221119034633.1728632-1-ltykernel@gmail.com>
 <20221119034633.1728632-14-ltykernel@gmail.com>
In-Reply-To: <20221119034633.1728632-14-ltykernel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=77d1214b-a7bf-4579-bd3b-1bcae01c8a75;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-12-28T17:17:47Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|CO1PR21MB1314:EE_
x-ms-office365-filtering-correlation-id: e82954dc-214a-4ff6-1cc3-08dae8ff5b9b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4voCSqaX1xZONCesZOdiN8P9w77isBCcRqHnRkddQsk53zUy7bEtkK2i/KlB+8aMUNXs4S4X3kzpZSRrYX5nOiIbnJAQK0atswUwmJ2y5iFI5DqKiry82vKKwKhqHw07gLZHcjTrLh+5Ca4U8syQ54dsO9owzQtYZ7VE4Zs9EBfL7stDfBruZl7KlyhEIYPPEEucP1tYsF43RPcAY1eyTlZ3omVA4/149Gb3WxgVVkQPtUYJTYEyoRrPHT4tSlqfneeOGdCp2fh8rvXXFmKWqn4Ojj+5ZhYA2ybob8JbAEA+0fIs9N6CdsFeO+OtePZmpc9SF0Uv+NCEzMz/l5hTCdiFd1tgD1D4at1Z/Cyza3AnmWPICyex4X4rw9ljDfgcOuGA+iCRakm6xH0d1sWV1Rx//GAttp+68Ls85eWvX7r+Uv6jI7G4iqKSfDBhzMKAHhCrxmyDarADwEiIuUY/07xscDV/fAoptyBNkw3NXTCLsGV3CedaEsxRVIFliNfU1Ps45ksv2TBKYnsbTjyvYdavbSmd2GbpQXVgmT5JVZfvOO77INr2Hbcl2ovl9xeiDx6XwNL9EK6VR9pRyZ3GIRUsCgDlUJJhTjOf67yTcm/AVVCO+1JzxFVbyw6YjiQw+S3ykFGajk6Z2A1UWP1wi6liLxlJheJEwqF9iMMdjgVb5qFOLGkDpEqYrCz4mnSdEjk1cXRCZp73pWGJqFV8WvdjBxZhozeTj8MlmBNgJ8Y3YtNBO0xLvJp9fK71QBDqHvVdeIzr6WfMwHkbg8EBEg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(376002)(346002)(396003)(136003)(451199015)(83380400001)(86362001)(82950400001)(5660300002)(122000001)(38070700005)(41300700001)(2906002)(8936002)(921005)(8990500004)(38100700002)(82960400001)(30864003)(52536014)(7406005)(7416002)(7696005)(6506007)(26005)(186003)(316002)(4326008)(9686003)(8676002)(478600001)(71200400001)(110136005)(64756008)(66446008)(54906003)(10290500003)(66946007)(76116006)(66476007)(66556008)(55016003)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DlVpTQBIg5bOTnwAyHBCaRCEnZpVTLU6bc+qtlkljR580x/pRqi97zkxYQr2?=
 =?us-ascii?Q?7f9Uz/O7RXJUdGK3QEs5/WYLWAp9gOVvm6eWdxbV5/1wgSscGiTWIJ+P8BwW?=
 =?us-ascii?Q?BAVDwBAwvsFcCkdxJTShP+ewMHUWTTCkUaJt6po0oeGrLmhk/HC2sH5im7Dx?=
 =?us-ascii?Q?oyjVk5iVNTlxgXczz9QgyDDL6gzCoGZg1ETZz42yzsQPHjVp+yqBlzoE4XEY?=
 =?us-ascii?Q?2AmDIoAlk2IXvO+c1Av7Q70VLSJD5Y5fiuY3jfulrpByAQulGIy8u8XPww5F?=
 =?us-ascii?Q?DFLbTAWsQdrrck5ad2l0dRlJ48NwxcaEoozfXwIT2Xjp09HhwQN74nj84HMu?=
 =?us-ascii?Q?u4tZ4GBu0JGL3BghVWh/oPB8+Ql51EGAK+rDM1B4wVstwvwUmXY2ZsrIPGcj?=
 =?us-ascii?Q?AN5QDhl6xRQcGyahFICY1OApVO4CaGTYj85pSHlJmvAATiNAB2UhI+5KuUR7?=
 =?us-ascii?Q?RgOC2xcLNtJftI88g0Ujhq/mWPYmZ7fULZXwipDkkxGNDLBR0k31m2L4F7AQ?=
 =?us-ascii?Q?fjNZHxpfpWj4pvOKHmuyIflWvXjMgLm+EJdMb/BLAiZ714qLWp/5o31Hg4Mt?=
 =?us-ascii?Q?qkmzwQLwR2orWbtrY8zgjeLsAjZeEiuXoKDDQD4wAu6aKJEato20w5ghlfWW?=
 =?us-ascii?Q?//TCqyPeMhiXtP2IPfJ6ZbwbjUSTVPMJG59tU0pMUBh5jtzTY6ZkbGvkIM0G?=
 =?us-ascii?Q?mZhF+4tIYx7OvgsELj11RbtQCf5LXfikuNgsSe0r9mmg9jTfGv3E0RYMHyEv?=
 =?us-ascii?Q?mTR/4ONWzaPWymGUVQB//nKJPig+SH6ttMrX6mjzIihLJJSKqk6qUIqQ79fR?=
 =?us-ascii?Q?4PRMoeI6YvwjmbGIfJ1VEzhGZakeDrdz5VVafKGamdc7Lu6a2+QGzWxkq2jK?=
 =?us-ascii?Q?8YJbICV2NIAfNPbzIbzaEhOHg/RS/eHGIDDP4xqLvjhBt9AJ5qeom0rQvsnP?=
 =?us-ascii?Q?c2E64DZuzKCU1yES4nIFG9oVreSAaoefJiXUExYJvrG65MYGXsSGj8HBNyvk?=
 =?us-ascii?Q?j6GT/eF6ZBoZpYFQEO/SFZM/REe1tIdhXx89+J1F0Vz5K5UkiuuxRY9vDygD?=
 =?us-ascii?Q?U0U7D4wJIYR2V5CgLtD2CLfuud0H+LTiIwX+RETbFQTdSeB5T16mc8ilLsWh?=
 =?us-ascii?Q?7YnrIMyER7NIAbAS5ghtJhFmi5gc1STzimOw1e7z2C6xQylPoV0ov1K0NdZn?=
 =?us-ascii?Q?5DHu6UOooN/lhG3dIgBvf8jlug4WyMbDHIjSFDHIDNuR0euC53KqM06QZ9T2?=
 =?us-ascii?Q?g2hLex+YZV3Du2fpF7qNneMJw6Qw6KYomUQzfC9NItIrn4q8JLJHjgAEv4D2?=
 =?us-ascii?Q?QZH1NghYKGPPV7HajjTVgPA4yseQsraCbvGuUa3uod6Q9KGxNz3X+hnIGs/L?=
 =?us-ascii?Q?4CGMn0sGY6IT4x9PRaGdwaSe6AVlekDasPFYDmlgheTMj4c4nQejr6Q1Rd6Q?=
 =?us-ascii?Q?+AZHj6qf4621p30T3teWhAIPS1sUgNURw5i0oT6X1f7eQzK03a/HIxUPqDA8?=
 =?us-ascii?Q?KT1JE9tEZgG57AxuzYFbRLeTHKV6sh2+kKiv5igHFWlwsvuvqMp7KAkdb9ae?=
 =?us-ascii?Q?dsluQKsM3R756akuSDbSYSnKkMIDmSxwhD1I+EBDk3oeEl8K1r0hRV69jr50?=
 =?us-ascii?Q?QQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e82954dc-214a-4ff6-1cc3-08dae8ff5b9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Dec 2022 18:14:27.7386
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BzgFSFh3f+obqevYRxBVNJAE8Ww0tywrcCPtWkSvJDZ5ZTmPr3H+gC6ipTQD5TUOlqN4F1faXcbS1E+qxOG6eSKEjNqBehYnjd3Wc2hTD6o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR21MB1314
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
> The wakeup_secondary_cpu callback was populated with wakeup_
> cpu_via_vmgexit() which doesn't work for Hyper-V. Override it
> with Hyper-V specific hook which uses HVCALL_START_VIRTUAL_
> PROCESSOR hvcall to start AP with vmsa data structure.
>=20
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> ---
>  arch/x86/include/asm/sev.h        |  13 +++
>  arch/x86/include/asm/svm.h        |  55 ++++++++++-
>  arch/x86/kernel/cpu/mshyperv.c    | 147 +++++++++++++++++++++++++++++-
>  include/asm-generic/hyperv-tlfs.h |  18 ++++
>  4 files changed, 230 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
> index ebc271bb6d8e..e34aaf730220 100644
> --- a/arch/x86/include/asm/sev.h
> +++ b/arch/x86/include/asm/sev.h
> @@ -86,6 +86,19 @@ extern bool handle_vc_boot_ghcb(struct pt_regs *regs);
>=20
>  #define RMPADJUST_VMSA_PAGE_BIT		BIT(16)
>=20
> +union sev_rmp_adjust {
> +	u64 as_uint64;
> +	struct {
> +		unsigned long target_vmpl : 8;
> +		unsigned long enable_read : 1;
> +		unsigned long enable_write : 1;
> +		unsigned long enable_user_execute : 1;
> +		unsigned long enable_kernel_execute : 1;
> +		unsigned long reserved1 : 4;
> +		unsigned long vmsa : 1;
> +	};
> +};
> +
>  /* SNP Guest message request */
>  struct snp_req_data {
>  	unsigned long req_gpa;
> diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
> index 0361626841bc..fc54d3e7f817 100644
> --- a/arch/x86/include/asm/svm.h
> +++ b/arch/x86/include/asm/svm.h
> @@ -328,8 +328,61 @@ struct vmcb_save_area {
>  	u64 br_to;
>  	u64 last_excp_from;
>  	u64 last_excp_to;
> -	u8 reserved_6[72];
> +
> +	/*
> +	 * The following part of the save area is valid only for
> +	 * SEV-ES guests when referenced through the GHCB or for
> +	 * saving to the host save area.
> +	 */

It seems unexpected to add these SEV-ES specific fields to a structure
with a comment that says for legacy and SEV-MEM guests. There's already
a struct sev_es_save_area  with a comment that says for SEV-ES and
SEV_SNP guests, and that struct seems to have most or all of what is being
added here.  Hopefully there's a way to use struct sev_es_save_area,
perhaps with some minor tweaks if necessary.

> +	u8 reserved_7[72];
>  	u32 spec_ctrl;		/* Guest version of SPEC_CTRL at 0x2E0 */
> +	u8 reserved_7b[4];
> +	u32 pkru;
> +	u8 reserved_7a[20];
> +	u64 reserved_8;		/* rax already available at 0x01f8 */
> +	u64 rcx;
> +	u64 rdx;
> +	u64 rbx;
> +	u64 reserved_9;		/* rsp already available at 0x01d8 */
> +	u64 rbp;
> +	u64 rsi;
> +	u64 rdi;
> +	u64 r8;
> +	u64 r9;
> +	u64 r10;
> +	u64 r11;
> +	u64 r12;
> +	u64 r13;
> +	u64 r14;
> +	u64 r15;
> +	u8 reserved_10[16];
> +	u64 sw_exit_code;
> +	u64 sw_exit_info_1;
> +	u64 sw_exit_info_2;
> +	u64 sw_scratch;
> +	union {
> +		u64 sev_features;
> +		struct {
> +			u64 sev_feature_snp			: 1;
> +			u64 sev_feature_vtom			: 1;
> +			u64 sev_feature_reflectvc		: 1;
> +			u64 sev_feature_restrict_injection	: 1;
> +			u64 sev_feature_alternate_injection	: 1;
> +			u64 sev_feature_full_debug		: 1;
> +			u64 sev_feature_reserved1		: 1;
> +			u64 sev_feature_snpbtb_isolation	: 1;
> +			u64 sev_feature_resrved2		: 56;
> +		};
> +	};
> +	u64 vintr_ctrl;
> +	u64 guest_error_code;
> +	u64 virtual_tom;
> +	u64 tlb_id;
> +	u64 pcpu_id;
> +	u64 event_inject;
> +	u64 xcr0;
> +	u8 valid_bitmap[16];
> +	u64 x87_state_gpa;
>  } __packed;
>=20
>  /* Save area definition for SEV-ES and SEV-SNP guests */
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyper=
v.c
> index f0c97210c64a..b266f648e5cd 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -41,6 +41,10 @@
>  #include <asm/realmode.h>
>  #include <asm/e820/api.h>
>=20
> +#define EN_SEV_SNP_PROCESSOR_INFO_ADDR	 0x802000
> +#define HV_AP_INIT_GPAT_DEFAULT		0x0007040600070406ULL
> +#define HV_AP_SEGMENT_LIMIT		0xffffffff

The above three definitions would benefit from some comments explaining
what they are.

> +
>  /* Is Linux running as the root partition? */
>  bool hv_root_partition;
>  struct ms_hyperv_info ms_hyperv;
> @@ -232,6 +236,136 @@ static void __init hv_smp_prepare_boot_cpu(void)
>  #endif
>  }
>=20
> +static u8 ap_start_input_arg[PAGE_SIZE] __bss_decrypted __aligned(PAGE_S=
IZE);
> +static u8 ap_start_stack[PAGE_SIZE] __aligned(PAGE_SIZE);
> +
> +int hv_snp_boot_ap(int cpu, unsigned long start_ip)
> +{
> +	struct vmcb_save_area *vmsa =3D (struct vmcb_save_area *)
> +		__get_free_page(GFP_KERNEL | __GFP_ZERO);
> +	struct desc_ptr gdtr;
> +	u64 ret, retry =3D 5;
> +	struct hv_enable_vp_vtl_input *enable_vtl_input;
> +	struct hv_start_virtual_processor_input *start_vp_input;
> +	union sev_rmp_adjust rmp_adjust;
> +	void **arg;
> +	unsigned long flags;
> +
> +	*(void **)per_cpu_ptr(hyperv_pcpu_input_arg, cpu) =3D ap_start_input_ar=
g;

I don't understand the above.  It seems like the hyperv_pcpu_input_arg is b=
eing
set to the same static location for all APs.  The static location gets over=
written in
hv_common_cpu_init(), so maybe everything works.  But it seems like
ap_start_input_arg can just be used directly in this function without havin=
g to
update hyperv_pcpu_input_arg.

> +
> +	hv_vp_index[cpu] =3D cpu;

The hv_vp_index[cpu] is also updated in hv_common_cpu_init().  Is there a
reason to initialize the value here?  This code also assumes that Linux CPU
numbers and Hyper-V VP indices are the same.  I've always observed that the=
y
are indeed the same, but Hyper-V doesn't guarantee that.  Hence we set the
value in hv_common_cpu_init() based on reading the per-CPU synthetic
register that contains the VP index.

> +
> +	/* Prevent APs from entering busy calibration loop */
> +	preset_lpj =3D lpj_fine;

I wonder if this is really needed.  In a SEV-SNP guest that isn't running o=
n
Hyper-V, how is this handled?

> +
> +	/* Replace the provided real-mode start_ip */
> +	start_ip =3D (unsigned long)secondary_startup_64_no_verify;

Any reason to update this global value?  The starting IP is passed to Hyper=
-V
via the VMSA, so it doesn't seem like a global update is needed.

> +
> +	native_store_gdt(&gdtr);
> +
> +	vmsa->gdtr.base =3D gdtr.address;
> +	vmsa->gdtr.limit =3D gdtr.size;
> +
> +	asm volatile("movl %%es, %%eax;" : "=3Da" (vmsa->es.selector));
> +	if (vmsa->es.selector) {
> +		vmsa->es.base =3D 0;
> +		vmsa->es.limit =3D HV_AP_SEGMENT_LIMIT;
> +		vmsa->es.attrib =3D *(u16 *)(vmsa->gdtr.base + vmsa->es.selector + 5);
> +		vmsa->es.attrib =3D (vmsa->es.attrib & 0xFF) | ((vmsa->es.attrib >> 4)=
 & 0xF00);
> +	}

The above "if" statement is repeated four times with different registers.  =
Seems=20
like a helper function could easily encapsulate it, though not the "asm vol=
atile"
statement.

> +
> +	asm volatile("movl %%cs, %%eax;" : "=3Da" (vmsa->cs.selector));
> +	if (vmsa->cs.selector) {
> +		vmsa->cs.base =3D 0;
> +		vmsa->cs.limit =3D HV_AP_SEGMENT_LIMIT;
> +		vmsa->cs.attrib =3D *(u16 *)(vmsa->gdtr.base + vmsa->cs.selector + 5);
> +		vmsa->cs.attrib =3D (vmsa->cs.attrib & 0xFF) | ((vmsa->cs.attrib >> 4)=
 & 0xF00);
> +	}
> +
> +	asm volatile("movl %%ss, %%eax;" : "=3Da" (vmsa->ss.selector));
> +	if (vmsa->ss.selector) {
> +		vmsa->ss.base =3D 0;
> +		vmsa->ss.limit =3D HV_AP_SEGMENT_LIMIT;
> +		vmsa->ss.attrib =3D *(u16 *)(vmsa->gdtr.base + vmsa->ss.selector + 5);
> +		vmsa->ss.attrib =3D (vmsa->ss.attrib & 0xFF) | ((vmsa->ss.attrib >> 4)=
 & 0xF00);
> +	}
> +
> +	asm volatile("movl %%ds, %%eax;" : "=3Da" (vmsa->ds.selector));
> +	if (vmsa->ds.selector) {
> +		vmsa->ds.base =3D 0;
> +		vmsa->ds.limit =3D HV_AP_SEGMENT_LIMIT;
> +		vmsa->ds.attrib =3D *(u16 *)(vmsa->gdtr.base + vmsa->ds.selector + 5);
> +		vmsa->ds.attrib =3D (vmsa->ds.attrib & 0xFF) | ((vmsa->ds.attrib >> 4)=
 & 0xF00);
> +	}
> +
> +	vmsa->efer =3D native_read_msr(MSR_EFER);
> +
> +	asm volatile("movq %%cr4, %%rax;" : "=3Da" (vmsa->cr4));
> +	asm volatile("movq %%cr3, %%rax;" : "=3Da" (vmsa->cr3));
> +	asm volatile("movq %%cr0, %%rax;" : "=3Da" (vmsa->cr0));
> +
> +	vmsa->xcr0 =3D 1;
> +	vmsa->g_pat =3D HV_AP_INIT_GPAT_DEFAULT;
> +	vmsa->rip =3D (u64)start_ip;
> +	vmsa->rsp =3D (u64)&ap_start_stack[PAGE_SIZE];
> +
> +	vmsa->sev_feature_snp =3D 1;
> +	vmsa->sev_feature_restrict_injection =3D 1;
> +
> +	rmp_adjust.as_uint64 =3D 0;
> +	rmp_adjust.target_vmpl =3D 1;
> +	rmp_adjust.vmsa =3D 1;
> +	ret =3D rmpadjust((unsigned long)vmsa, RMP_PG_SIZE_4K,
> +			rmp_adjust.as_uint64);
> +	if (ret !=3D 0) {
> +		pr_err("RMPADJUST(%llx) failed: %llx\n", (u64)vmsa, ret);
> +		return ret;
> +	}
> +
> +	local_irq_save(flags);
> +	arg =3D (void **)this_cpu_ptr(hyperv_pcpu_input_arg);
> +	if (unlikely(!*arg)) {
> +		ret =3D -ENOMEM;
> +		goto done;
> +	}

This code seems unnecessary.  Just use ap_start_input_arg directly.
No need to disable interrupts.

> +
> +	if (ms_hyperv.vtl !=3D 0) {
> +		enable_vtl_input =3D (struct hv_enable_vp_vtl_input *)*arg;
> +		memset(enable_vtl_input, 0, sizeof(*enable_vtl_input));
> +		enable_vtl_input->partitionid =3D -1;
> +		enable_vtl_input->vpindex =3D cpu;
> +		enable_vtl_input->targetvtl =3D ms_hyperv.vtl;
> +		*(u64 *)&enable_vtl_input->context[0] =3D __pa(vmsa) | 1;
> +
> +		ret =3D hv_do_hypercall(HVCALL_ENABLE_VP_VTL, enable_vtl_input, NULL);
> +		if (ret !=3D 0) {

Use hv_result_success() to test the hypercall result.

> +			pr_err("HvCallEnableVpVtl failed: %llx\n", ret);
> +			goto done;
> +		}
> +	}
> +
> +	start_vp_input =3D (struct hv_start_virtual_processor_input *)*arg;
> +	memset(start_vp_input, 0, sizeof(*start_vp_input));
> +	start_vp_input->partitionid =3D -1;
> +	start_vp_input->vpindex =3D cpu;
> +	start_vp_input->targetvtl =3D ms_hyperv.vtl;
> +	*(u64 *)&start_vp_input->context[0] =3D __pa(vmsa) | 1;
> +
> +	do {
> +		ret =3D hv_do_hypercall(HVCALL_START_VIRTUAL_PROCESSOR,
> +				      start_vp_input, NULL);
> +	} while (ret =3D=3D HV_STATUS_TIME_OUT && retry--);

Use hv_result() to check for HV_STATUS_TIME_OUT.

> +
> +	if (ret !=3D 0) {

Use hv_result_success().

> +		pr_err("HvCallStartVirtualProcessor failed: %llx\n", ret);
> +		goto done;
> +	}
> +
> +done:
> +	local_irq_restore(flags);

The entry to this function allocates a page for the VMSA. Does
that page ever get freed?

> +	return ret;
> +}
> +
>  static void __init hv_smp_prepare_cpus(unsigned int max_cpus)
>  {
>  #ifdef CONFIG_X86_64
> @@ -241,6 +375,16 @@ static void __init hv_smp_prepare_cpus(unsigned int =
max_cpus)
>=20
>  	native_smp_prepare_cpus(max_cpus);
>=20
> +	/*
> +	 *  Override wakeup_secondary_cpu callback for SEV-SNP
> +	 *  enlightened guest.
> +	 */
> +	if (hv_isolation_type_en_snp())
> +		apic->wakeup_secondary_cpu =3D hv_snp_boot_ap;
> +
> +	if (!hv_root_partition)
> +		return;
> +
>  #ifdef CONFIG_X86_64
>  	for_each_present_cpu(i) {
>  		if (i =3D=3D 0)
> @@ -489,8 +633,7 @@ static void __init ms_hyperv_init_platform(void)
>=20
>  # ifdef CONFIG_SMP
>  	smp_ops.smp_prepare_boot_cpu =3D hv_smp_prepare_boot_cpu;
> -	if (hv_root_partition)
> -		smp_ops.smp_prepare_cpus =3D hv_smp_prepare_cpus;
> +	smp_ops.smp_prepare_cpus =3D hv_smp_prepare_cpus;
>  # endif
>=20
>  	/*
> diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hype=
rv-tlfs.h
> index 6e2a090e2649..7072adbf5540 100644
> --- a/include/asm-generic/hyperv-tlfs.h
> +++ b/include/asm-generic/hyperv-tlfs.h
> @@ -139,6 +139,7 @@ struct ms_hyperv_tsc_page {
>  #define HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST	0x0003
>  #define HVCALL_NOTIFY_LONG_SPIN_WAIT		0x0008
>  #define HVCALL_SEND_IPI				0x000b
> +#define HVCALL_ENABLE_VP_VTL			0x000f
>  #define HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE_EX	0x0013
>  #define HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST_EX	0x0014
>  #define HVCALL_SEND_IPI_EX			0x0015
> @@ -156,6 +157,7 @@ struct ms_hyperv_tsc_page {
>  #define HVCALL_MAP_DEVICE_INTERRUPT		0x007c
>  #define HVCALL_UNMAP_DEVICE_INTERRUPT		0x007d
>  #define HVCALL_RETARGET_INTERRUPT		0x007e
> +#define HVCALL_START_VIRTUAL_PROCESSOR		0x0099
>  #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_SPACE 0x00af
>  #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_LIST 0x00b0
>  #define HVCALL_MODIFY_SPARSE_GPA_PAGE_HOST_VISIBILITY 0x00db
> @@ -763,6 +765,22 @@ struct hv_input_unmap_device_interrupt {
>  	struct hv_interrupt_entry interrupt_entry;
>  } __packed;
>=20
> +struct hv_enable_vp_vtl_input {
> +	u64 partitionid;
> +	u32 vpindex;
> +	u8 targetvtl;
> +	u8 padding[3];
> +	u8 context[0xe0];

It looks like the 0xe0 comes from the Hyper-V TLFS, but your
code is doing something different -- it's setting the VMSA address
instead of putting the context values inline. =20

> +} __packed;
> +
> +struct hv_start_virtual_processor_input {
> +	u64 partitionid;
> +	u32 vpindex;
> +	u8 targetvtl;
> +	u8 padding[3];
> +	u8 context[0xe0];

Same here.

> +} __packed;
> +
>  #define HV_SOURCE_SHADOW_NONE               0x0
>  #define HV_SOURCE_SHADOW_BRIDGE_BUS_RANGE   0x1
>=20
> --
> 2.25.1

