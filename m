Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43319661F2C
	for <lists+linux-arch@lfdr.de>; Mon,  9 Jan 2023 08:24:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236231AbjAIHYy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 9 Jan 2023 02:24:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236306AbjAIHYr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 Jan 2023 02:24:47 -0500
Received: from DM4PR02CU001-vft-obe.outbound.protection.outlook.com (mail-centralusazon11022018.outbound.protection.outlook.com [52.101.63.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C1712778;
        Sun,  8 Jan 2023 23:24:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HTXTrqYs9e0H7QDiKw4ls1fN2igH5tTyI/WbcbSxwn0LEPMfi6IBXDZw3XiKxmyoWYXJrL6+6eRvPSQWF9ZrLO+JmLDOj0p5PkrV9bshZLkRBmBwQQ+66UWgynDQvdspgIiaHvevavHTWA+w5pYkt4opsiocM1M2lGQ/8yOumJVwchvGPssSLhkuXZaTRD+P7LzIgLTgKHiDiI57ttoUucl+09Vjt0yF09wGeeOjRh+QLVr9YT80CKX/ArkHyBBhRulDg61anQiyn9oxhpfWC0mkmaEYcvHS23SvsXTUWIKbBXp0/0LOhcGzzWmFv8sCFs31pmpyhPho99fvgSeJZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZAhuGzmF/lEmAQDOC+WqMfGD4LPe4vwQoa4GcyY/hp8=;
 b=gonP5L53/jmY+Ylzyg3v5UnK7kjB6nZFmML//tnIUOu4JsvW/AVWsJhNoIBvqiRoZUadw1YJjr/pMM9pTlVBNXaTWlz7zT62zszZ1OVH83qQzX1wWcdAk9khdhK0vY08u9cHwuSL4v3evYIQ66JJtxSsR0NuFvGeiKso+w43NPnERsqSpsj/GjWsO/roLfmcwlJxPfPheQjaUkKfxyUnXYSLomo8HbewVv0xh+C/LEPPlwDVeHglJVIU0AcwmQG5lfCWjLhuYx2LezEUcDsaSvaAv0ZhxqWunRn6pSmqePrVSnaVRS0FPhXdR0BOtPiL/RHqUFykXl++9dpFYIb3NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZAhuGzmF/lEmAQDOC+WqMfGD4LPe4vwQoa4GcyY/hp8=;
 b=Xo3aNyRTjJJWmqf3b9aMllXiRHNRP+HI+mdzE8kyunYcxSJAwMnJHt96vVSTazg5riFoSmI6U3vEcubD5Io0TG18Gl9iUC4LMyOpNERh0enIIYMMDBa1TjrFu/qqlzMpydW9U54VwI8VvpqCGDDD3DJ2f8eO0oVYhiCbuac97ic=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by DM4PR21MB3442.namprd21.prod.outlook.com (2603:10b6:8:a7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.10; Mon, 9 Jan
 2023 07:24:37 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::c14e:c8f3:c27a:af3d]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::c14e:c8f3:c27a:af3d%5]) with mapi id 15.20.6023.003; Mon, 9 Jan 2023
 07:24:37 +0000
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
Subject: RE: [RFC PATCH V2 06/18] x86/hyperv: Use vmmcall to implement hvcall
 in sev-snp enlightened guest
Thread-Topic: [RFC PATCH V2 06/18] x86/hyperv: Use vmmcall to implement hvcall
 in sev-snp enlightened guest
Thread-Index: AQHY+8miz1D/IfZDCUGN1LRG8ul9c66V/j/w
Date:   Mon, 9 Jan 2023 07:24:37 +0000
Message-ID: <SA1PR21MB13354DDE24CC95A6690951B7BFFE9@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20221119034633.1728632-1-ltykernel@gmail.com>
 <20221119034633.1728632-7-ltykernel@gmail.com>
In-Reply-To: <20221119034633.1728632-7-ltykernel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=ee0f7f4b-f84c-4864-8544-5ef7e5cf3ed6;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-01-09T07:20:54Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|DM4PR21MB3442:EE_
x-ms-office365-filtering-correlation-id: f2b4f56a-fd29-445d-19eb-08daf2129054
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mcAVrYN+gWyEM9zAjNjhvNgiejNXGAZwu99kWXcygO1X9X/rOmdFXZvhoXPq6CqkeMZbsNgDj6z9d6p0feonjJnSfGThdyX06OfLXsEHXzOwNrFv5Njt/ZVOWNMgjmp8ZVB0QT1MpO49kYf8ZDDx56yCdA5B/6uE8Ydjdp08+68u98PSijxab/KzYz+gd9JcEZkY8mhSpwRjRkGYonqm7Y0uetHAkuxVA0Hm3+tnf+uNRJPC4jep7izAGFL6QZ0Kgtx8YPBgU1zCerKWAankVSD5O8YWed0zNr7IFt4igftuB0FIhvs3AeyrV/mkd62EmuR6Zo19p/QCjGuE1+jEqEmt+ZM1Y7t8ZxjGKVgl6q2AN7kon5gHTcWBxFpXK8PQAoIEznYCfLHHym80yuDQwYmkHOT2MUKULh8DTUqZ+6W01RwtgqiwfGt+1dJ558u15yY7rU9Qv2947nzpJ5eoADf6JlnkYKhiGgOeOfK4cOPyPtlG9O0BmAKmKsWFKzB77c8s3UssEsWOAqPjvsX2DuMNziX/PeyzuHavNMQ9rcaaM823CBjyI/O2ujIBP5L0sTLb4lPqv1jd2jmEcxcdy6DBCfL64c7Oi1yg2OpULHHROk/45U02TJOcipnSc+No5WYFG6MGzyKzoqa2LwkLi7tpAtcWmOH3EbhXPbyiVrgkkekD/feVF4XQMsN5IgtxathTPvalBomedTZaI3qRC0fcJx3MuB/PIcvBfJ0w0aK+5DTBRFu+vhophfJVmR6QIbfUXEQV/q6ieFjo7264nQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(396003)(39860400002)(346002)(136003)(451199015)(54906003)(6506007)(82950400001)(82960400001)(71200400001)(316002)(7696005)(33656002)(8990500004)(38070700005)(478600001)(2906002)(10290500003)(55016003)(86362001)(110136005)(921005)(122000001)(41300700001)(66946007)(7416002)(7406005)(9686003)(26005)(186003)(5660300002)(64756008)(66556008)(66476007)(66446008)(4326008)(8676002)(52536014)(8936002)(38100700002)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BENG16WvMTQDwYtj6etruca+8BBP2sqybVZjOJEJCailx0cIF943hKF4dR0m?=
 =?us-ascii?Q?MqA3zWBuKRjkHvokWTcYLJPOALPPSv30UbFCCpdVhcQTwU9VjuemXIuBnIZe?=
 =?us-ascii?Q?l/E4OT0696RiYylNLKkBXAM84Zglt/nedVhqKhgP3KJo6ip5U31N5zuXdiud?=
 =?us-ascii?Q?kz8JjT94LUhHNDI05Ugp6KL6N25U4h2UQEd5Dj2sL56+a406jRyPcbZsQzRO?=
 =?us-ascii?Q?yxUyLKCcoZiFvtWmuxEC78WEVLR+NSzsJkmiTX6AEBNmZDVvDU3YKNhkGGg8?=
 =?us-ascii?Q?BybZR68e6y2NiCaqWzgPSgkKQDUZzsUIRYnSamtsuL+ULCRSpJsfT4dMohCm?=
 =?us-ascii?Q?cwd1ep4AhEv6/VDTWkFmf1fCQqU8/y+cB5M+y0ryl2o07kxI3kAykbFrY8EB?=
 =?us-ascii?Q?+GJm3COQwNLIqIGovgjBCsSusAARMtPzalWvBSda1Juel08rwUkzTOquSlle?=
 =?us-ascii?Q?+luk0pnVi0ZG6XccHlh7njspm4XKpNNyeD7Yo53y3LZpL7dRPUN7jHjE++hS?=
 =?us-ascii?Q?VIfqdngAFCNGNHvVQTV56NBnX4pQrZr8AbDB3K8qIk+i1IZlKeDcCVL0BoPL?=
 =?us-ascii?Q?L1gTxpnlpoWVxUO/gzj98voR/UvJXUSbuzExnQgculh7UnWwjPfvDLCaFspP?=
 =?us-ascii?Q?EiVs8/+q59khWd7BOOghElwexfqbTX1JIU74Y0v09BA3wiEaxoSaCq+jlEAV?=
 =?us-ascii?Q?dv6PwJ203gVmKy7376aMR/RDBWx/Nfdnbq/rxOG+CDFsQm5oqcsa/OsCBhz7?=
 =?us-ascii?Q?7TqeWXUWkmo/JRggapUx30pGf0Hox+R8b6uXoTSB+SbjQy88c5kcBwyUzVPk?=
 =?us-ascii?Q?AYpXxhG/KMQUgJxmONZ8lJ0lMPxYxFGvYUGzaIGvlMnD5vDHoob3oNpLPUGw?=
 =?us-ascii?Q?/4cWHReg2CEacGExAAEUwZ3ILNN/EwtjEXdCCCtSSZYSX58h6MTvwiwewhrs?=
 =?us-ascii?Q?xNiSkV0fOUn0AtV/5ZwzFCe3HJPHCDjFhvZMEsw9fXxsyHNibtUubIMnsl0R?=
 =?us-ascii?Q?ZtIJjVQjBiLS5mtf1Afw6Y5fNYYht+yGc9xj9MufLCUBgq1/LvKy1arHyjlM?=
 =?us-ascii?Q?n+QTV/5abG10akDHF3OJRlY18gFQcdIxb27IBUX83sQk9IKYjSunz4tmS4sQ?=
 =?us-ascii?Q?nLnscHoe2stGTgKyYKKpFkcVucJqGbjqr4PGIYs7jZl7f0Ssuy/wu4ArExss?=
 =?us-ascii?Q?oV6fjNFwA4YjTe/eh2TDe6czbKM45UFhZIsp0e43kNyKGgDFVfLEyqSw0EGe?=
 =?us-ascii?Q?6+vMyn4EbLCHU5BN0kg83SU5U+YeA4tuMZJ35Wmq2MkSUwyIQXOwRbvPBnE0?=
 =?us-ascii?Q?3vCyveLxhV34pz45ZD+errKJgBL+EZre+W39ifYzWcSVqeBwWK03oRm8vtcS?=
 =?us-ascii?Q?G7LRGADoX6tu/GnXDd27einhTn8lIaEnFrJi34DyevF9iz/51e/cBr1LLqa4?=
 =?us-ascii?Q?f4H09CrtJ2jyri6p0VnXy9Wwj6I99vhk3We46YEsQgLvIzj050rxyo533xE7?=
 =?us-ascii?Q?w978rBNXqFMrbeuOs7PZbbd9N+9lOQ8944AEkztNjnJyNZmPhQg6mvQGkkHm?=
 =?us-ascii?Q?+pQUS1pQdaymrXnY+SJ0KPbXjEO9nfKr7uYM8pr3?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2b4f56a-fd29-445d-19eb-08daf2129054
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2023 07:24:37.0954
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xePuhYPwG8bnTl39P1U7LgGxdFdxCHLQvpZn1PPfg8wwp1jpqqXGx5L8qimu4yblvfb8igwY9T1Bjhip8yJ7Jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR21MB3442
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -45,16 +45,25 @@ static inline u64 hv_do_hypercall(u64 control, void
> *input, void *output)
>  	u64 hv_status;
>=20
>  #ifdef CONFIG_X86_64
> -	if (!hv_hypercall_pg)
> -		return U64_MAX;
> +	if (hv_isolation_type_en_snp()) {
> +		__asm__ __volatile__("mov %4, %%r8\n"
> +				"vmmcall"
> +				: "=3Da" (hv_status), ASM_CALL_CONSTRAINT,
> +				"+c" (control), "+d" (input_address)
> +				:  "r" (output_address)
> +				: "cc", "memory", "r8", "r9", "r10", "r11");

Add a "return hv_status;" here to avoid chaning the indentation below?

> +	} else {
> +		if (!hv_hypercall_pg)
> +			return U64_MAX;
>=20
> -	__asm__ __volatile__("mov %4, %%r8\n"
> -			     CALL_NOSPEC
> -			     : "=3Da" (hv_status), ASM_CALL_CONSTRAINT,
> -			       "+c" (control), "+d" (input_address)
> -			     :  "r" (output_address),
> -				THUNK_TARGET(hv_hypercall_pg)
> -			     : "cc", "memory", "r8", "r9", "r10", "r11");
> +		__asm__ __volatile__("mov %4, %%r8\n"
> +				CALL_NOSPEC
> +				: "=3Da" (hv_status), ASM_CALL_CONSTRAINT,
> +				"+c" (control), "+d" (input_address)
> +				:  "r" (output_address),
> +					THUNK_TARGET(hv_hypercall_pg)
> +				: "cc", "memory", "r8", "r9", "r10", "r11");
> +	}
>  #else
