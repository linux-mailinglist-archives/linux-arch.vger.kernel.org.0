Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30D5D78314E
	for <lists+linux-arch@lfdr.de>; Mon, 21 Aug 2023 21:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjHUTdW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 21 Aug 2023 15:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbjHUTdR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 21 Aug 2023 15:33:17 -0400
Received: from DM5PR00CU002.outbound.protection.outlook.com (mail-centralusazon11021014.outbound.protection.outlook.com [52.101.62.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D28DFD;
        Mon, 21 Aug 2023 12:33:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YW4kRGJuFr5mmNupJr6+r/N6e2FnJt97un+AaipbvYazMb8ucN4o46MxB/f5FgpVd8uqQ8j7cw41zGttyjN35DJ6SwbXbRmuq2pQ/p9KTn8gdqb1PYc1Z0GbFGVlAiO23WMueifq59XzMLP8x9pT06+BNeW7NFfXE0sgy0iewKckD6xmD21lSZExlB3e6Va/Il5XN2xvVyWILbFZGWG/cVLcoSBg9yuncZeE9P4b5PfLdXi5Tlz6dXwp4jaIqShDmjAv+NG+Rd1JXBY2NxaoSSU1ri7YlXYOfdqYi/mtRGuaxb83PdobNNCuKZ9ziM/vxI9M1bNTP1RVdha7u9hN5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e5T+V5LaX2t6OsjC8EOnj9nfHGqtG4tAD00Ozuw0JAU=;
 b=edpf/0tD7VcFhsQNGmEbvyP3Y77k9pRQZDA22iD0uEJkiSE0On1FURproMyT3gCsvecAvlSiM6VGqSZXSh6EWO0DpSyuus+NoTxKHDB8lQrcRYPnm3meEvIFxX6sOOn6S5wOIYX35F14aLbw9Iag34Zv2HLmi1tz7DrI+M3oSHanQZ8b0FWgzR/qfYsxtzM+ecN5R+5UCbxNd7fAlv+Vi5kE8ahJoSFCu8DNMg10OnzESdsnyHmv9aXj7ggSp3sdCGfdHFkv9KmZ31Q5uQG2zc4laymg4Dlee/xrSu28bvHjtAVbdYTt9qWb/kJnErasKWK8QlsLBsO+Dnj2bQiXng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e5T+V5LaX2t6OsjC8EOnj9nfHGqtG4tAD00Ozuw0JAU=;
 b=al9CUYaGooLAz7QTQJ1tWBsGRiz3hYBqaCwr8h5qk7bhv5+i34GGvGL44p1Dr23cGhRumBzth+yfBYqRJNd6romi9OgSv5hYW4R5rW5KVjEfBqsQB33n8Miy3fAJeF3XRBQlmrVHM2w5GIf8Ap/mdhYq/zwxF4aeepd9JeGHum8=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by PH0PR21MB1864.namprd21.prod.outlook.com (2603:10b6:510:15::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.4; Mon, 21 Aug
 2023 19:33:09 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::4cec:9321:1b73:6d5f]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::4cec:9321:1b73:6d5f%4]) with mapi id 15.20.6745.001; Mon, 21 Aug 2023
 19:33:09 +0000
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
Subject: RE: [PATCH v2 6/9] x86/hyperv: Introduce a global variable
 hyperv_paravisor_present
Thread-Topic: [PATCH v2 6/9] x86/hyperv: Introduce a global variable
 hyperv_paravisor_present
Thread-Index: AQHZ06TVJoWZTp5HxU++UB0kj/HGQ6/01qqQ
Date:   Mon, 21 Aug 2023 19:33:09 +0000
Message-ID: <BYAPR21MB1688ED81A8A54A25A7A10C44D71EA@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230820202715.29006-1-decui@microsoft.com>
 <20230820202715.29006-7-decui@microsoft.com>
In-Reply-To: <20230820202715.29006-7-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=cfb085e1-2e77-4201-87c1-f2506136f544;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-08-21T14:51:33Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|PH0PR21MB1864:EE_
x-ms-office365-filtering-correlation-id: 492770dd-236a-415a-9af2-08dba27d738d
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UBuLIhLP+wKgtpe+ChaZOkJ+DBy1wkOuFnc4qI+FITnPQNdHtL1ltr+/VQo8Q6SjQEdUkPtre4wQsnCrgJWrKfQXLZSbC+IbV+SUFGw2/P+XLUepm4hCYzG60CuTJpP+W0R52i6ZqXSzZagm1QC6ye9bVFY79OSt0V/+qpaM+XRaO80rwIdld8lRknOV5eaXe/3Zt/f5L8cxbLMWNlzg5/RsHed69eyGcTyhD8taxlqU6/nDoGKrjVDOhwtzznuxRHo/F7pUj1wM6UmTthNSZvvEzJOskVrl2RzeneuBGewyP8T6bIcGEryIK7C4YXr1uad05s0lXcHiKdp6kaELL3lNyZehy2vXBKAv+yvWz1xqmn9FUPhz0bNlr3rPcUrGNyHEjW2l1+OQYObfGZZPOqjpTI/oRYdnJmMa6qQjz/YBIrM6VEou6U+DDaVPn07bCTFVivZL17rZuZ5fn+iAH5k1btX0tzTK0dH3a7CTH8flaWsh3xufta00O6hAhXgEyB5LdLP5BUuQimzN5oHZL5dzN6EqDEpqr4tLksy9/uCKxL92tJBeOxc/fbHvvseV1P7KdGjIBu0YK03rRQ/cE0LvbTqh6RdN/6tjwgbZ7Oz4x6X0ZBVDif0uKTmG/Uz+0yWlf9Ejy+b2KBCiIAEZGKFm+sQa/3bcs2jKg+cv9YT3kaFER4IrznIrl1t/xjgrJVZPwiWibTeYwY58jo1PZJIZk1smM3yNTwuT52og8gGqm/ZqHzXOCiZoKZgFUjks
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(396003)(136003)(39860400002)(346002)(1800799009)(186009)(451199024)(2906002)(7406005)(7416002)(38100700002)(83380400001)(38070700005)(30864003)(122000001)(921005)(8990500004)(55016003)(76116006)(66946007)(110136005)(66556008)(66476007)(64756008)(66446008)(316002)(54906003)(71200400001)(41300700001)(478600001)(33656002)(10290500003)(12101799020)(86362001)(6506007)(7696005)(9686003)(4326008)(82960400001)(5660300002)(26005)(82950400001)(8676002)(52536014)(8936002)(309714004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8ZYfwFN+eUxKiK04AThbilwZFWi+aWFpzLSKs8yWGBCNxuJT6Ll3fJp7/OnP?=
 =?us-ascii?Q?iVX7gKGm/jk6M4axDKK4NSBifM96ZyGxwOj9yUSnzz0uBEHUHyuFu6S8DJsp?=
 =?us-ascii?Q?43VXJg6aLPDjy7EewBHbaMWs8ovBRwLxKyFBE70ekJGDerScPxAkr33O7DNi?=
 =?us-ascii?Q?sODyLA6l7gfbRSBSlTLEQsPUgHUpQuMjzYTqRJCJXH/ZBBWtvYNQEYqS9dob?=
 =?us-ascii?Q?fOpI4f+xmaiVn1lGUbZtPvUJ6gh1A5i8O95tRoledTwyOnmMVBO+mDziNmk1?=
 =?us-ascii?Q?mtLbQT6ojKz50SiR19WXg7slXXQJG7z0nE6faway+PtyJ8XoPbjg8rxh8x/w?=
 =?us-ascii?Q?hjhcddMByZVrQqi3s00YsGpf1Qqhw4LO31ftzF2/futEYF/HEt/mncb4ewNX?=
 =?us-ascii?Q?h9eYdLxZc89ns4nKoEa5xjhWNsY+mN2UTELTnMGTpdarEoE425vrtyMDLFdO?=
 =?us-ascii?Q?UzzDK28kP94zId8jChOrPM8hHgqKfYXRmLlBOYIhGj1p8iMMINwmmydnMBJl?=
 =?us-ascii?Q?+K8GDWvclQdmpuSv0ih/BNJTMiB2RhqPDl5/ZAxOGG5MVH3Y1jJe1G+8oseW?=
 =?us-ascii?Q?tqvfRPwVbnQqxvWiaBOJteDvNZbe5SeWVYkJ7PTeiaf8DdWJM9ZwUvrcwy5q?=
 =?us-ascii?Q?XF0sfo90c18O3s/EFIjz0QRqgW5INKq/wtKOgD+hvsI0HViOTB624Sp4Z/GB?=
 =?us-ascii?Q?j7ljOQpiVJuAV1p02Dqn+lo3jbb3rrENErCwwGT0oMd8u2vIcLnjkPRxsI+3?=
 =?us-ascii?Q?yRgq9ysXk6r9CB20QZmQGlTM6vWH7KpJIqd1vnP9hsXP7LpwpskgLDq8w5ly?=
 =?us-ascii?Q?rQslTkiKBFHJkzC0xWder8arfgD7xYkPB7JTUyZW3fm8y97pvIId8qY1izHG?=
 =?us-ascii?Q?I2sd/awfhhTbSYmOAL3/TqNoeogXsiKw606QRq03jBDvFuJ3IggX2HQSN9GA?=
 =?us-ascii?Q?mg31AuQ6bEODzK4unGFw+6kHbY/3rPcwPD9oUCVuZSvpmVkS8jpDMlm5VvBN?=
 =?us-ascii?Q?Q9ZQp54nywAUKXxefgvTOPu9HkSX5C5kbky4glXegH1iJ3GduAMJdLjWchb3?=
 =?us-ascii?Q?N8FYn4N+wrQSjciq1O5vKKTMt8zSBx5hRvmot9i+SdSfqBf1PIYRSNXT1haK?=
 =?us-ascii?Q?Ruj4Cvb7jNIsJcYbI6+4iTiUKst9Gx8WeiNGNdZVvc9Y8UQ1UFS7vK2vwvI+?=
 =?us-ascii?Q?lHxc9d6TzYibGVoQWTD9DT6Iqz3A7dIxqNgaqLXy8puSR0XDoqawBaTQlHDO?=
 =?us-ascii?Q?wzKBRqOWz55JetyqtfQH7tB+psrAh2b5uzmMFzQHsYDOOs99eI6IqF9Gj8UI?=
 =?us-ascii?Q?HI5TpOpu3Y/NHZ2qgbQfVHagBWIfx8mQHAVHC0FlJqkAHpUBgZT44GvdTCyK?=
 =?us-ascii?Q?NSs0yKL01AxADi1xFDzem2Ub9TG/faz2b5LnvZJN6ZhEL4rQWC3bPT+YVYYg?=
 =?us-ascii?Q?w0Jp1EbaqBGPuyu7mCZ3+CenDfGofSPudZ6v0+qWH5rLHe3FXSXAzAYkuR4D?=
 =?us-ascii?Q?TGZR+tnNHUYSSbjTbpQKnqYp/fuPsA/OftG7N+U5Robv6X3SdeEpkmJHDfFu?=
 =?us-ascii?Q?ZRulDYLdiXvjdpP51uWgvaX2jUDhkhYpPUhDCPihTDVKbNxZX1WOIf23bimF?=
 =?us-ascii?Q?UQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 492770dd-236a-415a-9af2-08dba27d738d
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2023 19:33:09.5864
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PWydfcd5JFLNKCs0+GQkhV+S2m8MWLapqK9+xSU5IpUMM+QzFgWcGIAbpyj7eU1qU2ZpRP1rYhl4Mmq1KuzT6Ols4L4ZctUQGd6Z5ok1rSI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR21MB1864
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com> Sent: Sunday, August 20, 2023 1:27 P=
M
>=20
> The new variable hyperv_paravisor_present is set only when the VM
> is a SNP/TDX with the paravisor running: see ms_hyperv_init_platform().
>=20
> In many places, hyperv_paravisor_present can replace

You said "In many places".  Are there places where it can't replace
ms_hyperv.paravisor_present?  It looks like all the uses are gone
after this patch.

> ms_hyperv.paravisor_present, and it's also used to replace
> hv_isolation_type_snp() in drivers/hv/hv.c.
>=20
> Call hv_vtom_init() when it's a VBS VM or when hyperv_paravisor_present
> is true (i.e. the VM is a SNP/TDX VM with the paravisor).
>=20
> Enhance hv_vtom_init() for a TDX VM with the paravisor.
>=20
> The biggest motive to introduce hyperv_paravisor_present is that we
> can not use ms_hyperv.paravisor_present in arch/x86/include/asm/mshyperv.=
h:
> that would introduce a complicated header file dependency issue.

The discussion in this commit messages about hyperv_paravisor_present
is a bit scattered and confusing.  I think you are introducing the global v=
ariable
to solve the header file dependency issue.  Otherwise, the ms_hyperv field
would be equivalent.  Then you are using hyperv_paravisor_present for
several purposes, including to decide whether to call hv_vtom_init() and
to simplify the logic in drivers/hv/hv.c.  Maybe you could reorganize
the commit message a bit to be more direct regarding the purpose.

>=20
> In arch/x86/include/asm/mshyperv.h, _hv_do_fast_hypercall8()
> is changed to specially handle HVCALL_SIGNAL_EVENT for a TDX VM with the
> paravisor, because such a VM must use TDX GHCI (see hv_tdx_hypercall())
> for this hypercall. See vmbus_set_event() -> hv_do_fast_hypercall8() ->
> _hv_do_fast_hypercall8() -> hv_tdx_hypercall().

Embedding the special case for HVCALL_SIGNAL_EVENT within
hv_do_fast_hypercall8() is not consistent with how this special case
is handled for SNP.  For SNP, the special case is coded directly into
vmbus_set_event().  Any reason not to do the same for TDX + paravisor?

>=20
> In hv_common_cpu_init(), don't decrypt the hyperv_pcpu_input_arg
> for a TDX VM with the paravisor, just like we don't decrypt the page
> for a SNP VM with the paravisor.
>=20
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
>=20
> Changes in v2: None
>=20
>  arch/x86/hyperv/hv_apic.c       |  4 ++--
>  arch/x86/hyperv/hv_init.c       |  4 ++--
>  arch/x86/hyperv/ivm.c           | 20 ++++++++++++++++++--
>  arch/x86/include/asm/mshyperv.h |  9 ++++++---
>  arch/x86/kernel/cpu/mshyperv.c  | 13 ++++++++++---
>  drivers/hv/connection.c         |  2 +-
>  drivers/hv/hv.c                 | 12 ++++++------
>  drivers/hv/hv_common.c          |  6 +++++-
>  include/asm-generic/mshyperv.h  |  1 +
>  9 files changed, 51 insertions(+), 20 deletions(-)
>=20
> diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
> index cb7429046d18d..8958836500d01 100644
> --- a/arch/x86/hyperv/hv_apic.c
> +++ b/arch/x86/hyperv/hv_apic.c
> @@ -179,7 +179,7 @@ static bool __send_ipi_mask(const struct cpumask *mas=
k, int
> vector,
>=20
>  	/* A fully enlightened TDX VM uses GHCI rather than hv_hypercall_pg. */
>  	if (!hv_hypercall_pg) {
> -		if (ms_hyperv.paravisor_present || !hv_isolation_type_tdx())
> +		if (hyperv_paravisor_present || !hv_isolation_type_tdx())
>  			return false;
>  	}
>=20
> @@ -239,7 +239,7 @@ static bool __send_ipi_one(int cpu, int vector)
>=20
>  	/* A fully enlightened TDX VM uses GHCI rather than hv_hypercall_pg. */
>  	if (!hv_hypercall_pg) {
> -		if (ms_hyperv.paravisor_present || !hv_isolation_type_tdx())
> +		if (hyperv_paravisor_present || !hv_isolation_type_tdx())
>  			return false;
>  	}
>=20
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index c1c1b4e1502f0..933a53ef81197 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -658,8 +658,8 @@ bool hv_is_hyperv_initialized(void)
>  	if (x86_hyper_type !=3D X86_HYPER_MS_HYPERV)
>  		return false;
>=20
> -	/* A TDX guest uses the GHCI call rather than hv_hypercall_pg. */
> -	if (hv_isolation_type_tdx())
> +	/* A TDX VM with no paravisor uses TDX GHCI call rather than hv_hyperca=
ll_pg */
> +	if (hv_isolation_type_tdx() && !hyperv_paravisor_present)
>  		return true;
>  	/*
>  	 * Verify that earlier initialization succeeded by checking
> diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
> index 6c7598d9e68a3..920ecb85802b8 100644
> --- a/arch/x86/hyperv/ivm.c
> +++ b/arch/x86/hyperv/ivm.c
> @@ -497,13 +497,29 @@ int hv_snp_boot_ap(int cpu, unsigned long start_ip)
>=20
>  void __init hv_vtom_init(void)
>  {
> +	enum hv_isolation_type type =3D hv_get_isolation_type();
>  	/*
>  	 * By design, a VM using vTOM doesn't see the SEV setting,
>  	 * so SEV initialization is bypassed and sev_status isn't set.
>  	 * Set it here to indicate a vTOM VM.
>  	 */

The above comment applies just to the case HV_ISOLATION_TYPE_SNP,
not to the entire switch statement, so it should be moved under the
case.

> -	sev_status =3D MSR_AMD64_SNP_VTOM;
> -	cc_vendor =3D CC_VENDOR_AMD;
> +	switch (type) {
> +	case HV_ISOLATION_TYPE_VBS:
> +		fallthrough;
> +
> +	case HV_ISOLATION_TYPE_SNP:
> +		sev_status =3D MSR_AMD64_SNP_VTOM;
> +		cc_vendor =3D CC_VENDOR_AMD;
> +		break;
> +
> +	case HV_ISOLATION_TYPE_TDX:
> +		cc_vendor =3D CC_VENDOR_INTEL;
> +		break;
> +
> +	default:
> +		panic("hv_vtom_init: unsupported isolation type %d\n", type);
> +	}
> +
>  	cc_set_mask(ms_hyperv.shared_gpa_boundary);
>  	physical_mask &=3D ms_hyperv.shared_gpa_boundary - 1;
>=20
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyp=
erv.h
> index 24d7f662a8beb..2a4c7dcf64038 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -43,6 +43,7 @@ static inline unsigned char hv_get_nmi_reason(void)
>=20
>  #if IS_ENABLED(CONFIG_HYPERV)
>  extern int hyperv_init_cpuhp;
> +extern bool hyperv_paravisor_present;
>=20
>  extern void *hv_hypercall_pg;
>=20
> @@ -76,7 +77,7 @@ static inline u64 hv_do_hypercall(u64 control, void *in=
put, void *output)
>  	u64 hv_status;
>=20
>  #ifdef CONFIG_X86_64
> -	if (hv_isolation_type_tdx())
> +	if (hv_isolation_type_tdx() && !hyperv_paravisor_present)
>  		return hv_tdx_hypercall(control,
>  					cc_mkdec(input_address),
>  					cc_mkdec(output_address));
> @@ -134,7 +135,9 @@ static inline u64 _hv_do_fast_hypercall8(u64 control,=
 u64 input1)
>  	u64 hv_status;
>=20
>  #ifdef CONFIG_X86_64
> -	if (hv_isolation_type_tdx())
> +	if (hv_isolation_type_tdx() &&
> +		(!hyperv_paravisor_present ||
> +		 control =3D=3D (HVCALL_SIGNAL_EVENT | HV_HYPERCALL_FAST_BIT)))

See comment above.  This would be more consistent with SNP if it were
handled directly in vmbus_set_event().

>  		return hv_tdx_hypercall(control, input1, 0);
>=20
>  	if (hv_isolation_type_en_snp()) {
> @@ -188,7 +191,7 @@ static inline u64 _hv_do_fast_hypercall16(u64 control=
, u64 input1, u64 input2)
>  	u64 hv_status;
>=20
>  #ifdef CONFIG_X86_64
> -	if (hv_isolation_type_tdx())
> +	if (hv_isolation_type_tdx() && !hyperv_paravisor_present)
>  		return hv_tdx_hypercall(control, input1, input2);
>=20
>  	if (hv_isolation_type_en_snp()) {
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyper=
v.c
> index 14baa288b1935..3dff2ef43bc73 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -40,6 +40,12 @@ bool hv_root_partition;
>  bool hv_nested;
>  struct ms_hyperv_info ms_hyperv;
>=20
> +/*
> + * Used in modules via hv_do_hypercall(): see arch/x86/include/asm/mshyp=
erv.h.
> + * Exported in drivers/hv/hv_common.c to not break the ARM64 build.
> + */
> +bool hyperv_paravisor_present __ro_after_init;
> +
>  #if IS_ENABLED(CONFIG_HYPERV)
>  static inline unsigned int hv_get_nested_reg(unsigned int reg)
>  {
> @@ -429,6 +435,8 @@ static void __init ms_hyperv_init_platform(void)
>  			ms_hyperv.shared_gpa_boundary =3D
>  				BIT_ULL(ms_hyperv.shared_gpa_boundary_bits);
>=20
> +		hyperv_paravisor_present =3D !!ms_hyperv.paravisor_present;
> +
>  		pr_info("Hyper-V: Isolation Config: Group A 0x%x, Group B 0x%x\n",
>  			ms_hyperv.isolation_config_a, ms_hyperv.isolation_config_b);
>=20
> @@ -443,7 +451,7 @@ static void __init ms_hyperv_init_platform(void)
>  			/* A TDX VM must use x2APIC and doesn't use lazy EOI. */
>  			ms_hyperv.hints &=3D ~HV_X64_APIC_ACCESS_RECOMMENDED;
>=20
> -			if (!ms_hyperv.paravisor_present) {
> +			if (!hyperv_paravisor_present) {
>  				/*
>  				 * The ms_hyperv.shared_gpa_boundary_active in
>  				 * a fully enlightened TDX VM is 0, but the GPAs
> @@ -534,8 +542,7 @@ static void __init ms_hyperv_init_platform(void)
>=20
>  #if IS_ENABLED(CONFIG_HYPERV)
>  	if ((hv_get_isolation_type() =3D=3D HV_ISOLATION_TYPE_VBS) ||
> -	    ((hv_get_isolation_type() =3D=3D HV_ISOLATION_TYPE_SNP) &&
> -	    ms_hyperv.paravisor_present))
> +	    hyperv_paravisor_present)
>  		hv_vtom_init();
>  	/*
>  	 * Setup the hook to get control post apic initialization.
> diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
> index 02b54f85dc607..7f64fc942323b 100644
> --- a/drivers/hv/connection.c
> +++ b/drivers/hv/connection.c
> @@ -484,7 +484,7 @@ void vmbus_set_event(struct vmbus_channel *channel)
>=20
>  	++channel->sig_events;
>=20
> -	if (hv_isolation_type_snp())
> +	if (hv_isolation_type_snp() && hyperv_paravisor_present)

This code change seems to be more properly part of Patch 9 in the
series when hv_isolation_type_en_snp() goes away.

>  		hv_ghcb_hypercall(HVCALL_SIGNAL_EVENT, &channel->sig_event,
>  				NULL, sizeof(channel->sig_event));
>  	else
> diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
> index 28bbb354324d6..20bc44923e4f0 100644
> --- a/drivers/hv/hv.c
> +++ b/drivers/hv/hv.c
> @@ -109,7 +109,7 @@ int hv_synic_alloc(void)
>  		 * Synic message and event pages are allocated by paravisor.
>  		 * Skip these pages allocation here.
>  		 */
> -		if (!hv_isolation_type_snp() && !hv_root_partition) {
> +		if (!hyperv_paravisor_present && !hv_root_partition) {
>  			hv_cpu->synic_message_page =3D
>  				(void *)get_zeroed_page(GFP_ATOMIC);
>  			if (hv_cpu->synic_message_page =3D=3D NULL) {
> @@ -128,7 +128,7 @@ int hv_synic_alloc(void)
>  			}
>  		}
>=20
> -		if (!ms_hyperv.paravisor_present &&
> +		if (!hyperv_paravisor_present &&
>  		    (hv_isolation_type_en_snp() || hv_isolation_type_tdx())) {
>  			ret =3D set_memory_decrypted((unsigned long)
>  				hv_cpu->synic_message_page, 1);
> @@ -226,7 +226,7 @@ void hv_synic_enable_regs(unsigned int cpu)
>  	simp.as_uint64 =3D hv_get_register(HV_REGISTER_SIMP);
>  	simp.simp_enabled =3D 1;
>=20
> -	if (hv_isolation_type_snp() || hv_root_partition) {
> +	if (hyperv_paravisor_present || hv_root_partition) {
>  		/* Mask out vTOM bit. ioremap_cache() maps decrypted */
>  		u64 base =3D (simp.base_simp_gpa << HV_HYP_PAGE_SHIFT) &
>  				~ms_hyperv.shared_gpa_boundary;
> @@ -249,7 +249,7 @@ void hv_synic_enable_regs(unsigned int cpu)
>  	siefp.as_uint64 =3D hv_get_register(HV_REGISTER_SIEFP);
>  	siefp.siefp_enabled =3D 1;
>=20
> -	if (hv_isolation_type_snp() || hv_root_partition) {
> +	if (hyperv_paravisor_present || hv_root_partition) {
>  		/* Mask out vTOM bit. ioremap_cache() maps decrypted */
>  		u64 base =3D (siefp.base_siefp_gpa << HV_HYP_PAGE_SHIFT) &
>  				~ms_hyperv.shared_gpa_boundary;
> @@ -336,7 +336,7 @@ void hv_synic_disable_regs(unsigned int cpu)
>  	 * addresses.
>  	 */
>  	simp.simp_enabled =3D 0;
> -	if (hv_isolation_type_snp() || hv_root_partition) {
> +	if (hyperv_paravisor_present || hv_root_partition) {
>  		iounmap(hv_cpu->synic_message_page);
>  		hv_cpu->synic_message_page =3D NULL;
>  	} else {
> @@ -348,7 +348,7 @@ void hv_synic_disable_regs(unsigned int cpu)
>  	siefp.as_uint64 =3D hv_get_register(HV_REGISTER_SIEFP);
>  	siefp.siefp_enabled =3D 0;
>=20
> -	if (hv_isolation_type_snp() || hv_root_partition) {
> +	if (hyperv_paravisor_present || hv_root_partition) {
>  		iounmap(hv_cpu->synic_event_page);
>  		hv_cpu->synic_event_page =3D NULL;
>  	} else {
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index 4c858e1636da7..c0b0ac44ffa3c 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -40,6 +40,9 @@
>  bool __weak hv_root_partition;
>  EXPORT_SYMBOL_GPL(hv_root_partition);
>=20
> +bool __weak hyperv_paravisor_present;
> +EXPORT_SYMBOL_GPL(hyperv_paravisor_present);
> +
>  bool __weak hv_nested;
>  EXPORT_SYMBOL_GPL(hv_nested);
>=20
> @@ -382,7 +385,8 @@ int hv_common_cpu_init(unsigned int cpu)
>  			*outputarg =3D (char *)mem + HV_HYP_PAGE_SIZE;
>  		}
>=20
> -		if (hv_isolation_type_en_snp() || hv_isolation_type_tdx()) {
> +		if (!hyperv_paravisor_present &&
> +		    (hv_isolation_type_en_snp() || hv_isolation_type_tdx())) {
>  			ret =3D set_memory_decrypted((unsigned long)mem, pgcount);
>  			if (ret) {
>  				/* It may be unsafe to free 'mem' */
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyper=
v.h
> index f577eff58ea0b..94f87a0344590 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -176,6 +176,7 @@ extern int vmbus_interrupt;
>  extern int vmbus_irq;
>=20
>  extern bool hv_root_partition;
> +extern bool hyperv_paravisor_present;
>=20
>  #if IS_ENABLED(CONFIG_HYPERV)
>  /*
> --
> 2.25.1

