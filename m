Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7331064783F
	for <lists+linux-arch@lfdr.de>; Thu,  8 Dec 2022 22:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbiLHVw5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Dec 2022 16:52:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiLHVw4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 8 Dec 2022 16:52:56 -0500
Received: from CO1PR02CU002-vft-obe.outbound.protection.outlook.com (mail-westus2azon11020016.outbound.protection.outlook.com [52.101.46.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5DA220F6F;
        Thu,  8 Dec 2022 13:52:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=It8AE67xXeiiXej8zfOkRCduQZLK52fQT0dX5XJ6hHN1iJVV2FCg4pfylFQXb7R5WxV9z/OpbhZiVUSNs/7QphLvORFdnIusTY2e1HXMWO0xi6wZfAwip2Vv1jiY54CrcgUeiOsPJCOAoEd29YwLY4MuRokiEYnKTkKaTwzgto5LG3/niyW6WPYP6cZQR1J/cfvyJOHUdIR/wJl7ULl7qsZoqHJrAU1BnrW/6Gn2Gd/j/fEs/YjvQLiLlekv7Ci1nzLnPJ5JgSPB2RHZoh6E+2zW9zeBpesHFmbEBjU1uXQ6bciqhviGe6N27wf/WjwEtDEQyW0NDQxx18Xs64Ggkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6zz9nBGtA318sPa478c/U/NE2A5G5WnkYqfyX7xfr88=;
 b=mWB3wNBo/tActLPX2+I01raptzkcqozj44ll3mvm12a7GlxjJOdzx6Qqtnjx1TWLGYv0Akn1to0Qo4KrjVHG61USOzghIVcSxkwYj1N2CLU3FYzQoJDfJ8IflKgvLcL2JOHA1VoccZ72FlVxIwsEypb8okLOQewFSChCX2P91VlPwWFyn/29/GFyUFLFNl/KJ45RmBxgM87zUQOh7EeGXAJxLayTUcZpN9yjGCjySxfQBAaaL7Y6tT8mNNP5D/zKR7cdjpHbjtcH1OSBiHuy2yNgUH2cyzXh+56zVdDPlQo8KIwHgDIQR8Fjwv+uMVEtYaDy+t61P2zkqIV9QikvdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6zz9nBGtA318sPa478c/U/NE2A5G5WnkYqfyX7xfr88=;
 b=XjVJInRmzp7TpMsbewAYybLWh72yhoqoADyCSTbF0x5spq2lDiozCipj0jrbREmyZ2aMjUgL0X2WOdV3OLCkCBypOQn6zvD1B5RtAM8gFzdq+wma5dWh6HLdgAvA4giesRPa+odz5tP5UjurzG5MLds4W8XEAflWJBDhBlmx5pc=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by MN2PR21MB1407.namprd21.prod.outlook.com (2603:10b6:208:204::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.4; Thu, 8 Dec
 2022 21:52:45 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::ac9b:6fe1:dca5:b817]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::ac9b:6fe1:dca5:b817%4]) with mapi id 15.20.5924.004; Thu, 8 Dec 2022
 21:52:45 +0000
From:   Dexuan Cui <decui@microsoft.com>
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
Subject: RE: [RFC PATCH V2 10/18] drivers: hv: Decrypt percpu hvcall input arg
 page in sev-snp enlightened guest
Thread-Topic: [RFC PATCH V2 10/18] drivers: hv: Decrypt percpu hvcall input
 arg page in sev-snp enlightened guest
Thread-Index: AQHY+8njSw/V4BybwEWpqC99Qe/49a5kpeKw
Date:   Thu, 8 Dec 2022 21:52:45 +0000
Message-ID: <SA1PR21MB13357A3B9348705F4EB59DAFBF1D9@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20221119034633.1728632-1-ltykernel@gmail.com>
 <20221119034633.1728632-11-ltykernel@gmail.com>
In-Reply-To: <20221119034633.1728632-11-ltykernel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=e1afd893-8a7a-49ac-be25-3720fda30ee6;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-12-08T21:47:56Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|MN2PR21MB1407:EE_
x-ms-office365-filtering-correlation-id: 6e0ba0c0-2c8c-4d19-8113-08dad9668a55
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eUQdyQycN07U/Tt3G/7ycDlgaFLL1Z2bSHOf9AlAiYmd6RP9Wr8Qcw8s6M3ahJJ5ZISbUbTjj/qB/DFKaH2XLTChMqcVgbU+McYNG707QeuKFkViL0YznjNNH1GEP+1UyZm0AGUQNe5Om9Eksptt57th9y59TFFQtbkg9q9ahMTdrxcH6LfBzH82Ph0ZYvMDzRkVGqKfjJKKZpRZwqBwt5jHf5IILmcItbdyJIfM/XoZEkb9cjmu1hjv5m6pKIAabQuJ8YiMWPQtISShqwV+rQtrH+44EcPR+BwxmkFwrb8fLGzll7AP8rtC3mt8z96dLoXq0MepSt0W23qYopiLBcxwncknedVYxH+kl9meUft5QeMlIizeIMUTjRSR+Rdc2hxeTgj0eVRUPSZ3y+tk3WhjOkZcVfxpBEW6xI2GT+0xmPXwtmJen8OlbQSPaRRL+V59sBNtRkjIT1z3gfWjrIgMOTk0Pw7D1WG/c3jPLyEg46XMSLPgDJ7rYwGJXXUFwe5W4u7h2xZzcQgLRxQJGoNa6ODqbP2BMxvBjK7nm59oa7gsqj7Dv6RLxnxDnn6uG6nr7yI5eaM+8ot/e0ty8QaicmEZ6NbdUqdILZPCT371mYhr3VKsBhhIR4H7P1kEBKmuYMBhD2hgl7+R5BR8GunLpiY/vczJvUp0yfB5B/r8bJ5UF8t3/6qKDgWDEZ18xB08RZOiMW+AOKdKw9deG4DTotNHrlOo3dJLcTcSYw4B0v4y9kqQ2WpbLuKjqPR5gcxFO7x/X3roJqORaUdFbA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(376002)(366004)(39860400002)(136003)(451199015)(8936002)(5660300002)(7416002)(83380400001)(26005)(76116006)(7406005)(71200400001)(110136005)(9686003)(4326008)(33656002)(10290500003)(86362001)(66946007)(55016003)(186003)(316002)(7696005)(66446008)(54906003)(52536014)(8676002)(38100700002)(66476007)(6506007)(66556008)(64756008)(41300700001)(82950400001)(8990500004)(82960400001)(122000001)(38070700005)(2906002)(478600001)(921005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Gr4ufqpHxUItFDHp+ucXxHsY885KN3v7GFe+hs8H+WttObiAU6Nzsmfvibxp?=
 =?us-ascii?Q?kKuqN0/T8PmzHIxkMrt2PGLLZGA3yrX1JUKPB/M39N38tTqlcxw6UoZmcJtT?=
 =?us-ascii?Q?QTnrKA4POh7nOoCKzIL9gCM5ohIUbA/lgf2MsLrmTEY0nto0z3QXOyyLBJgT?=
 =?us-ascii?Q?YW8IuZea6P3LrGv7JRqQCccyNY7amtoeWhwed9NtxsgLbtnpauTuUaXfr+Y8?=
 =?us-ascii?Q?ejytSv35a6wNIuAyAKxmpodqJFce/t19CfdsEUqMdKhvBcQCNvU+FhCR+JVU?=
 =?us-ascii?Q?RsMSCY9vJ52erkhnbY8Lv0vUDdwmsoUUHfZbeQrQOrV+YcajpjIVxY31JxPc?=
 =?us-ascii?Q?MjxmPywggmbzGg6JvRLq6Zm0I2cVK92w4u/u6TXk1uZ3n2300X5Bjn7EImWG?=
 =?us-ascii?Q?AVe+Ac8YB+Sz7Q/2+spFq9jIGwxmgCH0IrtJTBD2uGKfFudkjorbukPzKq8e?=
 =?us-ascii?Q?jQ7ZoiDvFNz54wmQR0xM0MKaVFTpMeLgJyLWxrFe1iqnm32RcaEcxm9P/KNF?=
 =?us-ascii?Q?tSljMoZWzB7KHeGljfNDUuXOFOwkP8MxdeCq5g/I3fKAumSiaqfRkJ6OFKba?=
 =?us-ascii?Q?uRcehlzL+jAUhRYf6Nl5rGz9C51AHCFy+gPMu78O4R+cD0iHpJtIAOZUriZ9?=
 =?us-ascii?Q?tbvyXkmfijq7LqnXOdoDOEzOAUVA0Zo4HKJ0OQ0R+9iNFI8HPYIf/pARydsJ?=
 =?us-ascii?Q?5nBqEepKN6HE/zq8Z0DlCBXiUIN6sgkkkn4MeOETMqrPTeWhAlAJ4qlEEHGw?=
 =?us-ascii?Q?2wRORAoxJnDwdP9e4TQosvth8RQEs9KIPAYxPLQuzK5YnSVS0ZUj1LIMM/SM?=
 =?us-ascii?Q?Nn065WOh5TU0KW2NORIr0QqcCrIJ77oZVZjWuvhR6Fg2awv0HfX6y2S65ijn?=
 =?us-ascii?Q?7cOZESSUNmn8hulWVCW8qhwdxiroOVRNK8I33IVl7CL+ZP0BUmHVWOxU5orN?=
 =?us-ascii?Q?pO7AfdRRjV5OAexe5/0sQlQKVAhUUpA5dw7FIXpCtQQn+9NOGczm+f8coNyg?=
 =?us-ascii?Q?HI8QdwRsPEjVt/NXkuCaS85CZKN+0r9gPk5+c+I6nbv2hdxIg90sQ/o0ZNe2?=
 =?us-ascii?Q?8ISD7w0WnQ43MAC5m89Y/RhzpUyL4CJ96gtpUDR7IscrAPkTML8nIhWjguWr?=
 =?us-ascii?Q?R6+0Ik3Cfdylhnj23RQHfjJGVaXuhYC4hI3XqUtr7hiHvDFcBnC14hO0IE3Q?=
 =?us-ascii?Q?eCIhFOqUFaoPxCUeWgXQofuYYw00cWv19uF+SfFmgMsUQkcyBvGNp9mhrDAp?=
 =?us-ascii?Q?mtheXzZZaWQ9DNuYHuGT0QwNa5NFJLKN9uOjmJbPf+LpLD8zB5Y1VJs4IndW?=
 =?us-ascii?Q?7H7kLHzQV1vTy7oinc54iNlfdmvDXqMHr2yUslJ1J9KyaAuQJhwr0reDCCMc?=
 =?us-ascii?Q?zFOSUXMnpVk7QkmAIZJy5S9amBmEIaWV6E7lFfRBMVyEjboyOMSOVIiXs0MC?=
 =?us-ascii?Q?YX+efYmfF1XgAtckpXN3OJ8NVRiMA38UQAuhsQKzwVeLMveIh4pbS+6f77jM?=
 =?us-ascii?Q?I6oSUX4S5JbZ56lK12omQLiafKO14rE5g8AsBzqTZXQ8Kx5RvIdeC9/y4tr3?=
 =?us-ascii?Q?lSx9TnIJxkqWt82n86fBdISPTics3kAc5FuGtGmR?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e0ba0c0-2c8c-4d19-8113-08dad9668a55
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2022 21:52:45.6629
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1vmZE2R4ulXDwM+QNt9slX4s+RenIBeXIqfMDskyx+vTnaa1ShxDP/I8aiYhU/0/ozLb2riGz3QBylWUChCTbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR21MB1407
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> From: Tianyu Lan <ltykernel@gmail.com>
> Sent: Friday, November 18, 2022 7:46 PM
> [...]
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> @@ -125,6 +126,7 @@ int hv_common_cpu_init(unsigned int cpu)
>  	u64 msr_vp_index;
>  	gfp_t flags;
>  	int pgcount =3D hv_root_partition ? 2 : 1;
> +	int ret;
>=20
>  	/* hv_cpu_init() can be called with IRQs disabled from hv_resume() */
>  	flags =3D irqs_disabled() ? GFP_ATOMIC : GFP_KERNEL;
> @@ -134,6 +136,16 @@ int hv_common_cpu_init(unsigned int cpu)
>  	if (!(*inputarg))
>  		return -ENOMEM;
>=20
> +	if (hv_isolation_type_en_snp()) {
> +		ret =3D set_memory_decrypted((unsigned long)*inputarg, 1);

Is it possible hv_root_partition=3D=3D1 here? If yes, the pgcount is 2.

> +		if (ret) {
> +			kfree(*inputarg);
> +			return ret;
> +		}
> +
> +		memset(*inputarg, 0x00, PAGE_SIZE);
> +	}
> +
>  	if (hv_root_partition) {
>  		outputarg =3D (void **)this_cpu_ptr(hyperv_pcpu_output_arg);
>  		*outputarg =3D (char *)(*inputarg) + HV_HYP_PAGE_SIZE;
> @@ -168,6 +180,9 @@ int hv_common_cpu_die(unsigned int cpu)
>=20
>  	local_irq_restore(flags);
>=20
> +	if (hv_isolation_type_en_snp())
> +		set_memory_encrypted((unsigned long)mem, 1);

If set_memory_encrypted() fails, we should not free the 'mem'.

> +
>  	kfree(mem);
>=20
>  	return 0;

