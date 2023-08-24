Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00EA3787122
	for <lists+linux-arch@lfdr.de>; Thu, 24 Aug 2023 16:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbjHXOIr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 24 Aug 2023 10:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241538AbjHXOIq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 24 Aug 2023 10:08:46 -0400
Received: from DM5PR00CU002.outbound.protection.outlook.com (mail-centralusazon11021024.outbound.protection.outlook.com [52.101.62.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C6C1BCC;
        Thu, 24 Aug 2023 07:08:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZJFmzoJCFKYnd1K+v1DDh2CF4rfmhdp9mFJwsqJnaLdYQdW2O4NMVKj6bcerJWxuxwOjvDNR0B786wyF05vcO0YKf1R2iJW7hCociyE8tAzmFfKGAzt1P/rus74I2pYdWLlAOYg4kkSJJtzvb+j+9bBCBpXBZ1tMXKXLRPLQra08ZDEYygkgLdaas6zxaG+AGfaZhTUGz0HR3VzSgnpDiMT68KXLsauUpFH/ENsQQmZz0b5sg7NYBHJvJ3Kgd+KoXvR/zq2y3JKDlvY122cvygwA4ye1SMiSZQsRzNl01TIu6EG2VeUG14HE9vjdbQFhneJHTQdPlDyRzlJLtlf6Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yHFzfq4RDUOrW9M4PUa+tYF1+lhHPYmGxSdZ44O4zwU=;
 b=XQIHD1ofglEoj6yHmTHJIbyyjmD83+KWjsM3Lyh79sFc5PFjx2yFwDDxMVblj01IWdHuxQ9y9Vq/MGJnvgo/O8cA+bEHZJEZoqSpzFx4xE/z4tKZ8FobgsM9oeuc8ep1BslSd83W07DQN7xYdsDVtZR7k3UJuIqcJLyb+J5TFMGtJ6Jv4dlodgzWAzSNpRoEVM2p3dcTzhEIHMeHwQZHYI8yFqRXHFenYGsFkirs39zLgSSHWP7Xo0b2zuCRAbnek1PwyTHsAQup1MwgrbFyq/gaZgrE4LZRZmMhOQyA93PsfplHwfxG9LB/1O79Tb3ujCImJdx3uHOLtlZILpDsNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yHFzfq4RDUOrW9M4PUa+tYF1+lhHPYmGxSdZ44O4zwU=;
 b=ODffSJNZQ4N0Exws3c8nWa9IeNnmwvAKir0DRplEnYHu09ts5Ep9VHZAh1T8VN7g+cNIawPsL0l+FYw4w80+gRtjH1nTavPM7a1SYaQKcbE4hx6m9PwyelJjFjnkFoeE4tchPBAqdG2Yze+3GmXBhgHYQ6RTajJdO11nsNqPWN0=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by MN2PR21MB1533.namprd21.prod.outlook.com (2603:10b6:208:1f5::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.6; Thu, 24 Aug
 2023 14:08:35 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::4cec:9321:1b73:6d5f]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::4cec:9321:1b73:6d5f%4]) with mapi id 15.20.6745.005; Thu, 24 Aug 2023
 14:08:35 +0000
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
Subject: RE: [PATCH v3 08/10] x86/hyperv: Use TDX GHCI to access some MSRs in
 a TDX VM with the paravisor
Thread-Topic: [PATCH v3 08/10] x86/hyperv: Use TDX GHCI to access some MSRs in
 a TDX VM with the paravisor
Thread-Index: AQHZ1mIiYhkuO3TX1UigCcdYwDJeFK/5e9zQ
Date:   Thu, 24 Aug 2023 14:08:35 +0000
Message-ID: <BYAPR21MB1688B8B8FBFA32065B08D0B7D71DA@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230824080712.30327-1-decui@microsoft.com>
 <20230824080712.30327-9-decui@microsoft.com>
In-Reply-To: <20230824080712.30327-9-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=ded9ef48-8009-4130-bcac-915fcecbccce;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-08-24T14:07:27Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|MN2PR21MB1533:EE_
x-ms-office365-filtering-correlation-id: 07bc8b97-dd94-4a94-9a1e-08dba4ab9b32
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v2Fp515EYkf8yct/JIYXb/8tx53vV9j+IYRfE8Dsv44w6pvbw68RvabUYu7SQsFrf0iZX6hL5sPdBuCl26NW/krlbxtl8zZTlWDwpkNpuEdU37ArBfBV7P90Fugizk6wYM893CUl3AZhqCFQp46ARPblqmzazWmzXqxki2WtqYDtVJUoCB0eyNPjAK1Y6PjdbofixauLryw52ZXz6qWUgmM3TmQNr5rBUQYBe4idkPo0jDOraZp8ciwsgC6jauuFqaw2pPM7QhFGo26a0gByi/LTxNYKmbb0i9mZRQnewNeE8S+LpoCeh17iGKZS4javpvhedZ09rPTV2uPa52TmsAiViRyIuXwXWeF+FWNDhqfGAsCcp2qBMdww5DU8CNaBThOVzqfq8Pw31FbE2XM3vZ3Cw3fglafKkjj60u6pUaYyjHjzYA2rubLXFGH0REE1hI21IKbvO+Kuaoha0SvTtkr6zyBRH+rs1aEVLta9Y0byayT8YHHMcySaaDfJzVWA1gmBOD+HWV0SEEXl2RaTuPXcbOKNODRiK5SD3jmWfhqIEuz4gSi1NHJ35XFPVrVprMwBfH52xzMYNjsji0J7HIyD6xRSGCxg42byRtkxEnBvJY80Ie8YkcJmbXM/EhMwOAqb4+TqT4yiH72urCtMTO5QvgqOaFJZW6X5TTZ5lxI4WwkwvqYGdunuaryy6FK8hAn+aSywAOFBuWY0meWfMw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(136003)(366004)(39860400002)(451199024)(1800799009)(186009)(7696005)(6506007)(71200400001)(10290500003)(9686003)(478600001)(83380400001)(26005)(2906002)(7416002)(7406005)(110136005)(54906003)(8990500004)(316002)(64756008)(52536014)(66476007)(76116006)(66946007)(41300700001)(66556008)(4326008)(8936002)(8676002)(5660300002)(921005)(33656002)(38100700002)(55016003)(82960400001)(86362001)(82950400001)(122000001)(38070700005)(12101799020)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PLsxAvgZ3sL4tvY1uZl/SlwbqmsEMqxE9ZelpklPYpDkYqdUEp2y7m8tpVs0?=
 =?us-ascii?Q?naHosM104c0OZIbJrL1tFz1MRmjX1eIdJOZr+VEPnyPgaIt8rLRP4Zyp1qgk?=
 =?us-ascii?Q?f4e6E1c5GQbJqWiI5rqyQi16wnZqB99oJ88huYLSQyVAggeu2TUSpp39rtYQ?=
 =?us-ascii?Q?r0VvjEi2vFaZiDog4oA7fnMM5Zvnoz3OgE/UdiG4DjvGRZKskAfBCW/wBNY5?=
 =?us-ascii?Q?EWxzQxl133iGdEgjUOJuZfWkQo9eKAgEF1MkRkiCtFg+eoRBIsY7iEc3jSXm?=
 =?us-ascii?Q?AFuXtUzrjSSInY2xkk/NajaVJfcWBan7z0M5dUnnwbdS72AUZt5B1T+4lKJ6?=
 =?us-ascii?Q?DNdydMyI3bFQj3PweYhWZ+NzeGC5DSvVV79O5h+7YPJP1JrP12u6NY0nXtHu?=
 =?us-ascii?Q?HSYcyXroS13lcZXHaJtWJIlEmgYq5XRqMqrDTh1T/yr/gq1Yi/TqEAs9Eoq/?=
 =?us-ascii?Q?bYGQUoOCZnxSfl/u3Ema5kJrDFPwNdR1hNjtwPLDoHBMh3M9FGWsgSqpFp5r?=
 =?us-ascii?Q?2YghJj4xI3b1ADrwLwGBXgPt7OUMswWD02iCGYxtkRCVzMNXn8M6VcchKA0r?=
 =?us-ascii?Q?bxYTHr0IAlMdzqQYjkhmUVLG0T+3xUJoDzG9W/9RhxK/aQDNuEssLgZxhng9?=
 =?us-ascii?Q?91/MZQ112C453AYBj/4Ny9/s8WIp3y0radel/9f1FdKck2KdOSO4akUabJpz?=
 =?us-ascii?Q?Rt5+dfjMquAnotgzD5Np3sU2YN8mRw+m1JurywkntcFvvBUvr7Zpxk68spQX?=
 =?us-ascii?Q?OrhlTp2YCGVTFJBEFscpGK53di7CfAMq9xP/PBMrgWGiBmgSjtfZRWnyGqAc?=
 =?us-ascii?Q?BM9xmyF6XwkBeypOVhSxNbASZdkTSYD2kEoFOl/ORRUMrIKTvR7+Sjld1fPn?=
 =?us-ascii?Q?mHnKZ/pv+waWI1FcbTDt0nCCXd4IRlDEsdFTy6H5G32N9YJkVIM6Fj1DQEFN?=
 =?us-ascii?Q?deumuaQ028LHbAEu8da90k8wpK/SuV2fkLlya5o3dGdCQ65MDNAJen2QKb+y?=
 =?us-ascii?Q?Y/Qs3cPH2v5T7r6LuotAzD8khvmrFLyBSpp/eqm80x5LRjK4ktRQkgP8jqOs?=
 =?us-ascii?Q?27/8BHFt49XHuRwYRX8CC7F+lW65mTIbB1fGJ9olfeJ6h1Yv90CEbvcDQZBT?=
 =?us-ascii?Q?z4WKlJX0kCW3tnERLtO3XpGoRDXUlRt0gAa0G7i99D7AXiPOoDoMN49GaPJu?=
 =?us-ascii?Q?g20SbOY29RRSL0WtoL2NakAY6R4h8jOk1IAllg6JZpjzi7uwtP3RbOuztqob?=
 =?us-ascii?Q?cujRfBowcR4BWaAQCGvwmlJcTEOmjmyjvCAHVGBT9XPRM0wwBH0/kRxblXcS?=
 =?us-ascii?Q?wip1NGT8mSwQVKhaAiM3WGMLZEoUk435xc3vZD4R4QxMRGnav4+XrhFY3UBG?=
 =?us-ascii?Q?TGArj23HAkoJ/DlnaMWxRRy7ti6lH0eGc5YN+mHbmMb/fJEkVTvQIHilykMz?=
 =?us-ascii?Q?Xfbkq6OXFKuzfmt2kXGjbkchZUaDIjMN8zq26ZhFKdq7yYIA1/DU2mvcESws?=
 =?us-ascii?Q?VtcAnfBON8TtSIdmpFHS0ycmYjLVbKb2wj/jfslTyyCvNhF+B0DT1SMl98E8?=
 =?us-ascii?Q?kYdsbxokNfDXvBkd+02FVR5bYaApPtbM6o8DeTmmn7jLsLom9Bhogl6IFZaS?=
 =?us-ascii?Q?hQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07bc8b97-dd94-4a94-9a1e-08dba4ab9b32
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2023 14:08:35.3092
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YTsdxs3h1K9OKEbkeVW7BW3+qX1zeKkUW3ozwfSeW3hMDYveF7Of3v/BylinCKjpU+KMfU5L5Jw0lFaai1zFfcPETS5p5nCaoQFLucQ9SmI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR21MB1533
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com> Sent: Thursday, August 24, 2023 1:07=
 AM
>=20
> When the paravisor is present, a SNP VM must use GHCB to access some
> special MSRs, including HV_X64_MSR_GUEST_OS_ID and some SynIC MSRs.
>=20
> Similarly, when the paravisor is present, a TDX VM must use TDX GHCI
> to access the same MSRs.
>=20
> Implement hv_tdx_msr_write() and hv_tdx_msr_read(), and use the helper
> functions hv_ivm_msr_read() and hv_ivm_msr_write() to access the MSRs
> in a unified way for SNP/TDX VMs with the paravisor.
>=20
> Do not export hv_tdx_msr_write() and hv_tdx_msr_read(), because we never
> really used hv_ghcb_msr_write() and hv_ghcb_msr_read() in any module.
>=20
> Update arch/x86/include/asm/mshyperv.h so that the kernel can still build
> if CONFIG_AMD_MEM_ENCRYPT or CONFIG_INTEL_TDX_GUEST is not set, or
> neither is set.
>=20
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
>=20
> Changes in v2: None
>=20
> Changes in v3:
>   hv_tdx_read_msr -> hv_tdx_msr_read
>   hv_tdx_write_msr -> hv_tdx_msr_write
>   Do not export hv_tdx_msr_write() and hv_tdx_msr_read().
>   included <uapi/asm/vmx.h>
>   Updated arch/x86/include/asm/mshyperv.h so that the kernel
>     can still build if CONFIG_AMD_MEM_ENCRYPT and/or
>     CONFIG_INTEL_TDX_GUEST are not set.
>=20
>  arch/x86/hyperv/hv_init.c       |  8 ++--
>  arch/x86/hyperv/ivm.c           | 69 +++++++++++++++++++++++++++++++--
>  arch/x86/include/asm/mshyperv.h |  8 ++--
>  arch/x86/kernel/cpu/mshyperv.c  |  8 ++--
>  4 files changed, 77 insertions(+), 16 deletions(-)

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
