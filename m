Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59A0A64BAFD
	for <lists+linux-arch@lfdr.de>; Tue, 13 Dec 2022 18:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236105AbiLMRaQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Dec 2022 12:30:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235962AbiLMRaK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 13 Dec 2022 12:30:10 -0500
Received: from CO1PR02CU002-vft-obe.outbound.protection.outlook.com (mail-westus2azon11020014.outbound.protection.outlook.com [52.101.46.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A425D22BED;
        Tue, 13 Dec 2022 09:30:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZjoRiF9P0XhMHo/ju5OWtgh1Q3gRvnoX6qIIxnmc8K6htdPQDmNCi41C5WIXK4j5s76L+24B0A/nZ1VLbjqRzneAN/r5SOe5WCv0zNrv1ggmsna3iMe8nxzggXdCFSpZrZvTG4+c0MG3j5BxGglVgeiNRh+DGAREcaBumt/4G479p84LxPkC4TZgMnro8QjpEEO+f7TwOnI3u35LnbDRX8AWLdUZ0TwZFGIrjrusjtHgtsMfeK2yJo42FEc8AP3wg/SqO+BZusUktSOhlCBpJafAA0PxDd+DPRYQhvJ3lzxCBSgNW4+eOT7Zivqe1Lj5+VvgEGQvZKp1MRZFlJzU0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EfNzmAgtS2G7InUCiqCMUVR7OQcAZQhtkwb35IGbUpo=;
 b=SD+xL/2UovUThGDE+zQ03o0sR/x3lDQpfApEcsBVVa6s7aldWdjywAyI5Lea8A9L/P1e++HW66AaxoB/ZeBw2bBJcDDDIFvzEJzRzph+ev9JFBGk88CNCfE5JAjVDgyqtC4YuEcWd+vyGWI5ujKnixLT2034dl9jL/+oLS/3Obm1/ddxBoGfL0UUojesEamwrFcUwUXugKl7Ao0Cx77pP5Q/YItCN1FyZ+G8Wwd3t+Zsaf/GXeiZCNiRGSiEVMxssrSBj1LnK7iASrTh2CdCw1FkYEVHE8PNW22ufpAMbj6p1wFqmmmm1vWpIljYMfpAHX5rJkdVR3X4+0yAqCQyrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EfNzmAgtS2G7InUCiqCMUVR7OQcAZQhtkwb35IGbUpo=;
 b=GuOuhBK2wS9kF7ozyEgLhRKGtXIGQbblcQj7pk56TztzptSK+uVBCXV/6YuUg01rloMvNwyxeUUUI54U+IPf7FvsX7YsgWsxnllddfJh3dLEMeO2eNrz8YIO6kgzx+ydDgwnKcC6O+Yh8+/C0qZs6eaGnnlq5ZnR0b2Vmpvjqwc=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by DS7PR21MB3479.namprd21.prod.outlook.com (2603:10b6:8:90::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.2; Tue, 13 Dec
 2022 17:30:07 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::1e50:78ec:6954:d6dd]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::1e50:78ec:6954:d6dd%8]) with mapi id 15.20.5944.002; Tue, 13 Dec 2022
 17:30:06 +0000
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
Subject: RE: [RFC PATCH V2 07/18] clocksource: hyper-v: decrypt hyperv tsc
 page in sev-snp enlightened guest
Thread-Topic: [RFC PATCH V2 07/18] clocksource: hyper-v: decrypt hyperv tsc
 page in sev-snp enlightened guest
Thread-Index: AQHY+8ngUVhmmnBNCk6VoJ0gSzEd765sOGFQ
Date:   Tue, 13 Dec 2022 17:30:06 +0000
Message-ID: <BYAPR21MB16887BAC34B73C9D9BA9FC33D7E39@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20221119034633.1728632-1-ltykernel@gmail.com>
 <20221119034633.1728632-8-ltykernel@gmail.com>
In-Reply-To: <20221119034633.1728632-8-ltykernel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=62760ebd-8162-43c1-b90a-c9684783e3ed;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-12-13T17:26:04Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|DS7PR21MB3479:EE_
x-ms-office365-filtering-correlation-id: f682d1f2-47d3-47e9-074a-08dadd2fad3b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6NLqHZwlaHwyhXavYL+pePxsQgyLWQdVirOdrLaKKNwbSnmlHQvPd7d8NxFesvTE4tP5++M0WMZ9uoShRwQ0HozxHxv5ZSXgZTPDw/fkro7UUXm+AjYA6VIMrtcUtGCRW82xD53UlDU2k3vzExyv/GlxeD66rvuIiNZzevyBHICtqgwtQEMSHXFjw6l1ZtKA+wdc2/w4/7zFhg6JUt9lAyYeoWtbrJLpurtK3JiX74MNfuup/rWztxG8GfbFGyWFD1GFaissZhh6CUJB44zAf1TRCxmFZocLcChZDvLicMjGtyr9PtFqovPJKpy2DdmRl+X+ANstRhLjRsoJhVuS5xHNv7NdJDDplyKDR+N+5uRJwsDV1xqr5fzZn9xeNgqBrCq7a7f6JDFqzW5wp21yAR2PePThV2h3LEK38OyfJbHlCmJXLglU2AvzQKMZ8x/iRIGw6vI332PeRMTIz0vJKo4ng4lNyyHuL9daAim7Wbh6onw9KmtEu615O3uMnOQL3xmnuNFI9B/l8VxPy1+dt8ftmfs6NAr6bU6K8Bhg7kRKWRKzSnHpUpKl86NGjkPZbJFCQtIHOROSGoS7oOX+Mzc3/s/RdQMKTcBWLHAzpqlbuhrsUFs/MYifjJ7e2Jbkpvfz8wsWESDX+kWxgoaz+6FgRGQulZ/q8VoQdUnmsKemOMEQFQrgniR463dQXYNRD4WqHkoRfx9xG3agnJphONxTARu8Y1mNUUZ8OR2jzCL05L4kftYuHl+/tPBh0WABqQgDtqxSQEAXSnVH6OMfeA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(136003)(366004)(39860400002)(396003)(451199015)(110136005)(316002)(8990500004)(54906003)(2906002)(7416002)(33656002)(7406005)(86362001)(8936002)(52536014)(5660300002)(41300700001)(66476007)(38070700005)(921005)(64756008)(8676002)(66446008)(4326008)(66946007)(38100700002)(76116006)(66556008)(82960400001)(82950400001)(122000001)(55016003)(10290500003)(71200400001)(6506007)(478600001)(186003)(7696005)(26005)(83380400001)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LiPv8GNCU+y167vVBslqGcZdVIJQfDkke8aFZ6fPNR9gag44OGHc+rLo6y1e?=
 =?us-ascii?Q?h7OAHjlIoKHOMO8WWI7TutUXPd5P8tMIRAKN5BgMF0DVlU3NY+c74fl9a7Yi?=
 =?us-ascii?Q?Ov/h9+Zyt2kYX9tl6h1V7cI1xXiEMfXBjF6Ra0sTOiucEyN0T4A+0GRWHJ/B?=
 =?us-ascii?Q?6qskPP2j4KeHYulrMbXKK5QRqhmBnV/sX7XQMWMB0YMFs3Tc0GAF22N2k5Oz?=
 =?us-ascii?Q?gIQgAtSO+7HkbYRqnl3P+r7zkuGsoTFzc18ftSL09xFBZ4WoVfTu5E06iawx?=
 =?us-ascii?Q?G6wNipOlHJAq6ju5jkfgYSjmcBAs8PteqBi0YTlY0h8iWVrZsBBDvnQU8fvy?=
 =?us-ascii?Q?tJiTf+Z2yoEkeupv0u5N/o6WdhEmlPFOhAmUkMXaFbajX7pfQwtM7dGpWaVc?=
 =?us-ascii?Q?UlTvUUfXN1eGledhMwewryLVz4U3zPAfh6vgZP5cMftz3VO8VsR0BincvO/D?=
 =?us-ascii?Q?jHaAR5mQuKu11PO/oAoEWea6CawF6NbRTqF7jrJsQSVI1TsPRyHWgyK1Y1bZ?=
 =?us-ascii?Q?+22TLTH9Ex7VCOOdTf4HoehLJCzNS7L8aW63M9zmNjfkJwBoXo3hfIko8Ufs?=
 =?us-ascii?Q?AF9GdFZK36TMnK8WRu6qRsbZj6OwvNWuU99n92gR8GbIY/CSipDmSW0tlKku?=
 =?us-ascii?Q?aIJO/fl8zYl83aF/FdbqokydWZOkSkTGsWgpam7csfQ2S4P31TlrE1St011B?=
 =?us-ascii?Q?DZNZ7yLLqpwCtYo2NuhI2MaYYHHKITNpq7T5TbEjVT/LDvWmcO3IWDDKFxOF?=
 =?us-ascii?Q?Vk6yxcjb+9hIjO+PunTeTOTktmNlouxslGrq/5ICyeLvsFIfhAbf4hO2qIzK?=
 =?us-ascii?Q?Rd2IU0EZL4k/GHUCwvpA7Jh8VP7tx2JbngS/zCmLt6ytlF8PySI6qtyIzfWA?=
 =?us-ascii?Q?MF+sH2EHRq/jqpsYCSt4H/zqNpv7DKvZSL1/fhzwQ+EK7j/yAAnkBxO9XXmy?=
 =?us-ascii?Q?79B5VFwC33eYIiWrqJYoPZSOvZd3rLoMjJTmA5DoOlg0yt67mACgsQHWNUd0?=
 =?us-ascii?Q?5D2idsAeeO4mfZ12Yy9kOxkX3Bqj+Svo3S/P/C7SckhFss+gTFrWO5oSDnxb?=
 =?us-ascii?Q?x4kYw3jEZBgWVD7ow2boJpmky69rBwre0IE0DHumCIHgUSA7TOJBu7kLi7wm?=
 =?us-ascii?Q?BkCxp1JFkYjQqZ6ZbSn7tKJiSPP1rzv8S0k87xiKAP9nMgpjhtJFyJEhuyCK?=
 =?us-ascii?Q?t4wYROAC1l7Y8h4K3WJoqGpQi79GdKpyVBofu28VdjIEY4pSLwAi5SaJw41n?=
 =?us-ascii?Q?GFjS4KaCxreM9AQI16dpmqWgbk/pjUNcgL0B36IUbRuF/gDBvBejRpHgLARv?=
 =?us-ascii?Q?mydbDpAIZjMB6/dJKwqL5mU4TVmH9lycZGNnXC9/3W0ScVxkDp/Rf/YX2/CK?=
 =?us-ascii?Q?eZMTHP/ehjrrfjh4KCBvG9Tf7DrI70O4TWl8x2mYULlqneAmfV7yujH9V+95?=
 =?us-ascii?Q?XiOMmK6foK9CId862vU7ld61ex5eawii8IBkSl0gHUiaNv1s4k2cVy9LBmNt?=
 =?us-ascii?Q?2u90zpUgzTCSy8M4tFoU1vOp/AXfnwRM7Fd3KnAeM5l8sjYtciHtbzfOC60N?=
 =?us-ascii?Q?PRN0npQHKTDkl/13i/PiC/haVF05hvinDGlSI6+rT9jKQVtVNkDwjBEM8dZV?=
 =?us-ascii?Q?Dw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f682d1f2-47d3-47e9-074a-08dadd2fad3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2022 17:30:06.5562
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BeN2rht3ASDr1sUTRp/Bj9LSR/ec5TGGoGeyFqZVxVfqE749L40YVN4MjaAnPwZJeuIqDT/hEGfS034S14EShUmuqR2P37EDbTJbE68sVXo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR21MB3479
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Tianyu Lan <ltykernel@gmail.com> Sent: Friday, November 18, 2022 7:46=
 PM
>

Previous patches to the Hyper-V clocksource driver have not been very
consistent in the Subject line prefix, but let's use
"clocksource/drivers/hyper-v:" since it has been used the most.

> Hyper-V tsc page is shared with hypervisor and it should be decrypted
> in sev-snp enlightened guest when it's used.
>=20
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> ---
>  drivers/clocksource/hyperv_timer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyp=
erv_timer.c
> index bb47610bbd1c..aa68eebed5ee 100644
> --- a/drivers/clocksource/hyperv_timer.c
> +++ b/drivers/clocksource/hyperv_timer.c
> @@ -364,7 +364,7 @@ EXPORT_SYMBOL_GPL(hv_stimer_global_cleanup);
>  static union {
>  	struct ms_hyperv_tsc_page page;
>  	u8 reserved[PAGE_SIZE];
> -} tsc_pg __aligned(PAGE_SIZE);
> +} tsc_pg __bss_decrypted __aligned(PAGE_SIZE);
>=20
>  struct ms_hyperv_tsc_page *hv_get_tsc_page(void)
>  {
> --
> 2.25.1

