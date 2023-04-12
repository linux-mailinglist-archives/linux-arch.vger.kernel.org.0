Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFF366DF8A0
	for <lists+linux-arch@lfdr.de>; Wed, 12 Apr 2023 16:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbjDLOfK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 Apr 2023 10:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbjDLOfI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Apr 2023 10:35:08 -0400
Received: from BN6PR00CU002.outbound.protection.outlook.com (mail-eastus2azon11021025.outbound.protection.outlook.com [52.101.57.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D03698699;
        Wed, 12 Apr 2023 07:34:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GfX76pBXqQ3cTBzh3CeTzhsktmMXXNdR2tu9WLcv+EemywajCwLJxh2svG13D6BLubMJiKSvxH/maCQxNQqbd3MmBKEIIi/ibw1CnNv4JA3bczfbo4pcj4r2Be7VTbl2/1TS46hi156LvtFm8hZaRxS/TYUNlHCET5xHulyChKJemy+t6JXh0jqD/EBR0bJmDVi70YKGBk2+8/h3Dkhv5yiXC0VFVowRnpRYpLZCKlz8repDPvU3fXjbC2rpWP8Z6BR0K3ial0Nk/cuOhyxa/KYInr0uDPvWjbI9NObNdKtF5KOTdDDNlJkQIKzrN8FX06BftJvj5JO9bfYVGoKvbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wm7BaH1kAXYDHZu0ddtvS/+UvdzdU4AM33zYiHE65/g=;
 b=nZSdDsIlrC4V5DCfWCA8amNZvVBZhgtcLV5NqS/MHho2sWJJjGuHpy0tZFyWXfYp+h9kGhYoARrSjAL9WslgJkTNlqqlwkwmejwZkiMsJWty8vPuHE3NJTsa5C7g+nGfg0oKukylGFmwYIE5TCLvPP/8F6mIRXJVb7zvZ3QixAIo/yX14PNuiTJWmE8jsb+1L/BWAzTivscj58Znh1pCwFfWm2KZ1JyC8ia1AuO8dWzO9J3GNQCykhfxu/TT9MiEXd25yqi/zTBUzYM0Su6nwTKihssLisYiLiL4+mRCpL0a9a1x5jALnhwxz5olJMB2w3Ejmn4oS/iaklcSbck4ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wm7BaH1kAXYDHZu0ddtvS/+UvdzdU4AM33zYiHE65/g=;
 b=Q0Tge6DBMpsvPSl5p17/QJ7FSi+Z6k6Vu1YcgC9KaB42ETa9GgDQRLtKj6oVDfnWFa2F1WdYj/lT7eDFWXHJ+Wxr/ulYOz1XOFUpLFRzB3slcdKVU3L/dz7r4ZFVJGFJVnx/comVn/25mUZLldnqC7n8NeMDK+X+nfSarPz5Z48=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by DM6PR21MB1418.namprd21.prod.outlook.com (2603:10b6:5:25c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.4; Wed, 12 Apr
 2023 14:34:44 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::acd0:6aec:7be2:719c]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::acd0:6aec:7be2:719c%7]) with mapi id 15.20.6319.004; Wed, 12 Apr 2023
 14:34:44 +0000
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
        "sterritt@google.com" <sterritt@google.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "samitolvanen@google.com" <samitolvanen@google.com>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>
CC:     "pangupta@amd.com" <pangupta@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: RE: [RFC PATCH V4 07/17] drivers: hv: Decrypt percpu hvcall input arg
 page in sev-snp enlightened guest
Thread-Topic: [RFC PATCH V4 07/17] drivers: hv: Decrypt percpu hvcall input
 arg page in sev-snp enlightened guest
Thread-Index: AQHZZlQQ0QYT0ni+r0KiuRqdlrSObK8nypUg
Date:   Wed, 12 Apr 2023 14:34:43 +0000
Message-ID: <BYAPR21MB16885F5C627791D9F8E43055D79B9@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230403174406.4180472-1-ltykernel@gmail.com>
 <20230403174406.4180472-8-ltykernel@gmail.com>
In-Reply-To: <20230403174406.4180472-8-ltykernel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=9cb0b9c9-5f3a-4ae3-9a0b-476d2c665b6e;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-04-12T14:32:33Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|DM6PR21MB1418:EE_
x-ms-office365-filtering-correlation-id: 0062bc41-3adc-48cb-e249-08db3b630edc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SCLfjruXFNZJfKg82dHRdbkeXMMa7KhEzc9HuX2ts6+ioI8fZvYbMkHnohq6wDV0ycU1+4/MymQGJ9KkRp1Yyl/R7V574z0CPPu75+ZBaZAOPNk5TI0T1RPsIgqMXsty0jNTNzGG/Esslrgvud6yZxQCMXLgZstzI3UZRmeI1Mr+vFHyO3wSP03uYNddX9bjvdZCyP9e+/KFHItD4M8omDj25KQq0h7FxHe4M+JqWqsZf+h37wJAbtNHcEjksR1vwNeLWdkZQmQUUnxalweJ06txqIpG7XKeyid2QpU64UQdQSCJA71ZwqMn/frUHcW3vaOpsn/vll+AwJEAlHDmHtMDrYfjOVRo24aL3MaXf49qDpBIBlJKpoiQItHjhC0Pzvm0Ij/LQiZXm88CfzUoOEVJy+hmGzgtlc+ld2KD444cvEXJ5zbLAkP7OcVxPehqWl2tJafoeV6FdCjqUQq2SvHyqJ4TbguRfobwEp9TgB9bPsEmX3GpQnpW4+omA6D78BKVaiKZQCvePzHfS0ZTUzHiTsoUUMgj3XVNS3+exvIsN5wAurZJNh2YHZlNcUTfYfdhziP/YJPmUHzaP3az+DjuxPOAwQzszU8hugWhIkZqBQbj+nybOai4TDJcesAp7t9NNq/N9pTkme6sZkPvuKuSa8h385Rw/9w7VPDh8OjU3gvo1lvHPL0WKjWbAkDK
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:cs;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(346002)(136003)(39860400002)(376002)(451199021)(5660300002)(54906003)(7416002)(7406005)(10290500003)(478600001)(71200400001)(7696005)(786003)(8936002)(52536014)(316002)(41300700001)(26005)(110136005)(66946007)(66446008)(4326008)(64756008)(66556008)(66476007)(8676002)(76116006)(6506007)(9686003)(2906002)(186003)(83380400001)(8990500004)(122000001)(921005)(82960400001)(82950400001)(55016003)(33656002)(86362001)(38100700002)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kTbZpoIIQa1RadsFX0xuSpTMA2MjgGbWY4bzX22UMB9bB/tHHM5AzPmeeu2C?=
 =?us-ascii?Q?niZCfRD5vcMXrnBLjZRQPF24IOCQj9jJ4dcQOF3I69Ed3J8XpK43T9xZa4ga?=
 =?us-ascii?Q?iN+r8K1eEqjOcJPYcxdBDWdDESyJnaAP8dA589oAPX6UqHJUmI1ZeBai2o6h?=
 =?us-ascii?Q?h9hOszE2JHRqL9GlMp0C9kQgw0BecUWRxIkS0rmQL7NnWkoHKX59V5IKhkdP?=
 =?us-ascii?Q?LcJVaGRFHiyVtU/3CV/N84gvLcCUnV1bs0Sk4/N9Jxs0Sloxr3YMy2OJDxzb?=
 =?us-ascii?Q?dOKLMDXrUlaKmefUlmYWBqGZs6pwLi+AMAw7RHHEG+JHbUUt7J0CRSFMwRzK?=
 =?us-ascii?Q?FovQelc+QGIJC2YroiM2Z7lcKKyKlJ2D2OP8K74x0UO2dEeYGXMiUsvMAGzt?=
 =?us-ascii?Q?RZJXvknLidgHBSh1w/pZem4QKq8QX6/LTyLWv6eu33xWsW8jrGyNT+d8cviz?=
 =?us-ascii?Q?s/MNFkmCFsOeP+5aM7NW+UfCiKVP0RYA5pFfI7DqP+CmFehCqxngm/dieRq0?=
 =?us-ascii?Q?SAR22+rxX7kU9/r5OuM7t+H9SFaU9t4Y+TUrYgFG4OtMDfC6u0YsWM+yY2ZR?=
 =?us-ascii?Q?gryAd3OyGrOD9qS0gKGQj5sycEwtRb3kvkkkRIVUZZQzVYzpJsb490wCOUbk?=
 =?us-ascii?Q?mCzy7bnm6zxp0DAkdnUMGou/iSg5gQuLBwp9rEj12Er7D6TCthk9t7ylN3ye?=
 =?us-ascii?Q?oS072neDzpQSsYSCcRaCgkejKTjIrx/gqEXrGXdAqCHWGuR5SIiHuvutYpBH?=
 =?us-ascii?Q?4DDFAoZzE6c+gNZqOeKlhGL18XHSGPysVLQgFnwLnHoTA1fUT7FHHZDzvi46?=
 =?us-ascii?Q?GhNOYv4zi+yXa8jyukIATN9xvjjgpCPSxDPjbcMECSpn7OhxZm/FCeBcJv8J?=
 =?us-ascii?Q?DlD2GY5RML5380jCmBwJ4SqUqh857tilMcemVkyjFvRsO+02CWMJ1HCOPbQ1?=
 =?us-ascii?Q?a5GvHA3Iox/WWzRhDieXavy7x5Wb56oaTwI65Wzxy7qU61t+cKVi5eWxW7ZT?=
 =?us-ascii?Q?TJFoBQTShNxjRt0UCrg813msxYBK+u8J5rH3nE6Go2qebRDA0Z0tJV51wdjA?=
 =?us-ascii?Q?6sEAIHCrR8ByB/brSVit2GkbZ1JNspYh6fxdZLHZPLhHiQuRzvJ/K6FY2Pds?=
 =?us-ascii?Q?iAhBKoMY2KOnclQl6y9ITQk9GoGLs0/GF+0lhzhpWanjTakoHRHFQ+tVVlKi?=
 =?us-ascii?Q?7BkBtjCwTVAfIdNvj0KQWpOso3w65Dsl7lcHznvL+BwoB+Fu1ROVLMAotNts?=
 =?us-ascii?Q?td+eziZtFDGvckt64LsJvb8UiaU7WPILfKK0oqTaWoWyTqBjzY/ma1nRbPW4?=
 =?us-ascii?Q?cWpCwdLND8qqzzh9UB81lYWmon0IyZmIn2/MIoE6VvN/A6oOxcfuz6ApU2B8?=
 =?us-ascii?Q?v4Zvt1vwgXiwWaDNevy5Vclj3LwcEA1DlL9N8RiuKaL61ZsctzmezDEVlxzA?=
 =?us-ascii?Q?ojbRpops8yaUk0EDGmFatQExnkxrfOGXhuWU0UoZjmQTEZjjrV2X649Oziq8?=
 =?us-ascii?Q?wjkr4JSvivKy6kkcOeyG6YxrWvRJfL2GYVzwrS02GUK1+SJhTdOKtWCDINhb?=
 =?us-ascii?Q?UVTju2SvjlSU6QVzx6Hwe3J5iC9Sy0YSFH6aPo0ApOkAUEJzZRAegbcLKkB4?=
 =?us-ascii?Q?eA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0062bc41-3adc-48cb-e249-08db3b630edc
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2023 14:34:43.9700
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VMUuDDOyQ9CY0wUWhSRuiEi/OVg+InvhNqyMZhvUp22AWq7dOLO0aJCEiek3VrDJLMbLINLlqIA1tzOp9R/T+hxMsovfn6H3l0qxlLAnerI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1418
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Tianyu Lan <ltykernel@gmail.com> Sent: Monday, April 3, 2023 10:44 AM
>=20
> Hypervisor needs to access iput arg page and guest should decrypt
> the page.
>=20
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> ---
> Change since RFC V3:
> 	* Use pgcount to decrypt memory.
>=20
> Change since RFC V2:
> 	* Set inputarg to be zero after kfree()
> 	* Not free mem when fail to encrypt mem in the hv_common_cpu_die().
> ---
>  drivers/hv/hv_common.c | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index e3b04e978932..455432d49fd3 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -21,6 +21,7 @@
>  #include <linux/ptrace.h>
>  #include <linux/slab.h>
>  #include <linux/dma-map-ops.h>
> +#include <linux/set_memory.h>
>  #include <asm/hyperv-tlfs.h>
>  #include <asm/mshyperv.h>
>=20
> @@ -128,6 +129,7 @@ int hv_common_cpu_init(unsigned int cpu)
>  	u64 msr_vp_index;
>  	gfp_t flags;
>  	int pgcount =3D hv_root_partition ? 2 : 1;
> +	int ret;
>=20
>  	/* hv_cpu_init() can be called with IRQs disabled from hv_resume() */
>  	flags =3D irqs_disabled() ? GFP_ATOMIC : GFP_KERNEL;
> @@ -137,6 +139,17 @@ int hv_common_cpu_init(unsigned int cpu)
>  	if (!(*inputarg))
>  		return -ENOMEM;
>=20
> +	if (hv_isolation_type_en_snp()) {
> +		ret =3D set_memory_decrypted((unsigned long)*inputarg, pgcount);
> +		if (ret) {
> +			kfree(*inputarg);
> +			*inputarg =3D NULL;
> +			return ret;
> +		}
> +
> +		memset(*inputarg, 0x00, PAGE_SIZE);

The memset() needs to use pgcount * PAGE_SIZE.

> +	}
> +
>  	if (hv_root_partition) {
>  		outputarg =3D (void **)this_cpu_ptr(hyperv_pcpu_output_arg);
>  		*outputarg =3D (char *)(*inputarg) + HV_HYP_PAGE_SIZE;
> @@ -156,6 +169,7 @@ int hv_common_cpu_die(unsigned int cpu)
>  {
>  	unsigned long flags;
>  	void **inputarg, **outputarg;
> +	int pgcount =3D hv_root_partition ? 2 : 1;
>  	void *mem;
>=20
>  	local_irq_save(flags);
> @@ -171,7 +185,12 @@ int hv_common_cpu_die(unsigned int cpu)
>=20
>  	local_irq_restore(flags);
>=20
> -	kfree(mem);
> +	if (hv_isolation_type_en_snp()) {
> +		if (!set_memory_encrypted((unsigned long)mem, pgcount))
> +			kfree(mem);
> +	} else {
> +		kfree(mem);
> +	}
>=20
>  	return 0;
>  }
> --
> 2.25.1

