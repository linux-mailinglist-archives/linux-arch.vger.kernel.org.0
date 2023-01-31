Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08C9D68348C
	for <lists+linux-arch@lfdr.de>; Tue, 31 Jan 2023 19:02:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjAaSCR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 31 Jan 2023 13:02:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231557AbjAaSCJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 31 Jan 2023 13:02:09 -0500
Received: from DM6FTOPR00CU001-vft-obe.outbound.protection.outlook.com (mail-cusazon11020019.outbound.protection.outlook.com [52.101.61.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46AE91F5DF;
        Tue, 31 Jan 2023 10:02:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Snh2oRUHXXgVjlE2ReRkpI2NSR0CI9lx/d5k1QR1Yq89rDwGOhTVX4aDRGeZoV1fnYuUof8ULT7wbGfGYvYN45kHr4N9w7buEijuzn/u09liQOW3acT2j/PXavQC7QyxfM/FesV7fOiGNrffDG9Xr9tYGgon1BPUpE60N1MuXBeEqKSOdIUg5186V3ziC6Z4+XMBQFzsRwnrTkEKXbxFl96FGeK6Nu4ZYJ7vgnECgUaWA9GvvAgp0IP63pT6D78qljKXRDeRqP15CYVhdIz+I2G/ko9eSfknvDyi7aFCblkat4YaaHoLOvUvbPMgxjC1d7xjyW7IioT3r6iSy+s8oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LSQTdQo0jay1/ptPzCLU6vOiEHihmvvozvG9SrqeFvI=;
 b=lOalTIn/WkFU3uR4JB18q3/R17umS4WcSlGFG9WlS5akelsNaAh+M5Ma7B7cHQOuB8dte87WzmpfdFiAibDFRinoaHiRpXnp9+Xn1vkk0yDEKQgeWTZfyqACQPYdMMEeLpCgmmg3vCRZAFJEtPLKo03nOJKyxE6nUus5E0eXvD68fUFZsIYiQfD8WHGLUT62C6bhKXvXH0ZxNKs7khmrjDi1WdApKrRmhjznRDLqUmi/ahD7yCk2xjuNkPV3lrTSKGMOsouZAPVq0DMa/hR9iyri8enSyzn74RnAYjcDtBvUSTc2OMTJlSlgCotW4MH0cS1khsraiAZF9K/49P+R4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LSQTdQo0jay1/ptPzCLU6vOiEHihmvvozvG9SrqeFvI=;
 b=fp9cEV2zoMxwFh+H8YehVoMmPXKHXGTxsw5p+UZUH8T2e+GXXcTa6PpS9n8AQNI3PdDG31//fEKjR+V+GBi2n0ofOBhcei7V/nF43QX9aLJsOsxpQoZLlq5ig9gwiA6B6oEPEmQ6DMyLQuR6Juv6ekdbyB6uMZzUov6gpW8d8IM=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by MW4PR21MB1954.namprd21.prod.outlook.com (2603:10b6:303:7d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.4; Tue, 31 Jan
 2023 18:02:00 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::9a9e:c614:a89f:396e]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::9a9e:c614:a89f:396e%8]) with mapi id 15.20.6086.005; Tue, 31 Jan 2023
 18:02:00 +0000
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
Subject: RE: [RFC PATCH V3 07/16] drivers: hv: Decrypt percpu hvcall input arg
 page in sev-snp enlightened guest
Thread-Topic: [RFC PATCH V3 07/16] drivers: hv: Decrypt percpu hvcall input
 arg page in sev-snp enlightened guest
Thread-Index: AQHZLgvEgycEZ2x4pEuyt/dy5bzs3a6430tQ
Date:   Tue, 31 Jan 2023 18:02:00 +0000
Message-ID: <BYAPR21MB16880F982D51474B0911D528D7D09@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230122024607.788454-1-ltykernel@gmail.com>
 <20230122024607.788454-8-ltykernel@gmail.com>
In-Reply-To: <20230122024607.788454-8-ltykernel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=1e3810b9-ccbb-4cef-bb4f-e415031d4df9;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-01-31T17:58:58Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|MW4PR21MB1954:EE_
x-ms-office365-filtering-correlation-id: 012b88cc-8703-4bb4-4fe6-08db03b5402f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LYuOZNyAT4AOsWK5yonYNsLadB7AFGrz6ATeDYTjwWdHvZJ0hBWZjBFsbRWEPS6M8+FOwDNKhvlxskwbrfGLmsNMsPSX6Gq9OPNroaVEWLoWJBvF6ppH61fOFp4A56hARCclq4sGINiZIs8keXKrg5rZf/eRiqoTK+rdz9JK7k1CWnRVgUeZpA8Mz6LM0Nvq1l9abgvUMl6cA5qkOmIIU3lxRFSd08y4WnWecfhZQxrGSqJa2iY/pZvZ5uDedS+w0JLpd4le7g8s6K2GO/cU/MScJwuwYXoMg+VflYRhw7gt5NYntdO4un89g/IMcZpz2Ez92XuzsQjY7QVJpH2u1hqn3VgLSEOxcK/kTNcGL9kwXMpmdiDUzV/BUBH8baKuXNV3eTCVj6Bd5fikt4ObxmpNuSaBUgB+MJ+vNvBAH9ax4wzMZXCsY4VfC1b+al6dvKCGvUtEM2zbKJB9O3UBh26oAInHNsaNACwGfOqqb8aRgNEjo/mZ+dMSjUg0mWgUQcZ3XF0wtt4Y1AUyY49prUp0/+UVzLh/EfYt54QvHqh757/Hp2jAKG73f61b1/PriP9Y28qWy8K2SeR1+Qb/GhAkoPbJGxHWxFsB6MY1NIoeLmreMFFKPMS83Et5E5lzytrLBNyWHCWYyLm8ctT8NxrlahPnGYmV3wpiibl5vLKhKX/PyooOGC4zmUggKVv88Qcu5atmcy5vFsZ4g1iAZV3eaftf6FlQin8aHX3/+q0Ub9qRJ19i0eUccgVv8YIksoRAFVHQsiwnfi6UXzKh9A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(376002)(366004)(346002)(136003)(451199018)(8990500004)(83380400001)(38070700005)(2906002)(7416002)(7406005)(5660300002)(64756008)(7696005)(26005)(71200400001)(66446008)(76116006)(86362001)(8936002)(6506007)(4326008)(52536014)(66946007)(66476007)(8676002)(66556008)(478600001)(9686003)(10290500003)(38100700002)(82960400001)(186003)(921005)(55016003)(122000001)(316002)(41300700001)(110136005)(54906003)(82950400001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?g8T2EY/evH3LfbiX6YVI3OmIw9b8qoiCQWAw4CCvHVs1G8aMlmQBYSICl8tA?=
 =?us-ascii?Q?zmdapWRyUwDWMw2LV2Z85/+Xv2wwsnUXUHLCxAAf2Yb5VavF2YCfKZQXiT8O?=
 =?us-ascii?Q?E5fxaFAdoKeWEZerBTzoSbNExNoB2Je5tvoTe5/1er9sTTU/3znWoonHjzVJ?=
 =?us-ascii?Q?MNctVM+1jG3T4M7acZA0gddnYOWj1QF4PzOfnDZvEJVxLV70RFQZ4Tw4mi6T?=
 =?us-ascii?Q?xjDGsWH7QnEX3mn7jX4yKHbE7ffwIw8edCHtN8vKArPEQI/gtM1RfRuTwfjD?=
 =?us-ascii?Q?0YlH9/i/iZY3uxwkTcWt7E+teWpl8298pv9FUra80AvjjcGsrwnB9VTUuBT6?=
 =?us-ascii?Q?U4d5bNNmXtPP4ZQ5gE5hbZ1eT06sWKARknPeRNYDwjdrYyiwFMHSeRnZq7HJ?=
 =?us-ascii?Q?JsC9l5nRssZw5Rs8rMl9dzOSUwK33SdD1p0L51Q9Z5BcfqIUp4d3F6ay9KfT?=
 =?us-ascii?Q?POOBBOLh8owielwt4SACqW8oNI4aJvMrvm53FIyK7zsTpug3OLm6E2lbZ8My?=
 =?us-ascii?Q?AGXGf9gp7xKzSPbLa8gCpnKDSXU8l9bZwAmYuIrsiDMRgOOJoiCNBCS34UGO?=
 =?us-ascii?Q?1f6sf7aDTULO8E1GvpNLnSRkfv1YleFq8OdzCDuHVD3ji2+mm/8BV6wVhFvn?=
 =?us-ascii?Q?Abj6e4Tsl2Tif8Cj1LcO0WCsT21k2d8C9Us92peRkIkxmOJufUrqrIq74mU4?=
 =?us-ascii?Q?ZX1jvGjjLgH3BRB+L/2CGNFLWhB0byrF+gL0Ry1y7buKWrG4y+crg+2GA9Vd?=
 =?us-ascii?Q?UGfiNIkMaOAC2EwyVQHH84Y6U/zn38uSg5EA6/Yl1dxFXVa0A5NYTkdHiEqP?=
 =?us-ascii?Q?xY+9QsXy647SdN8EebXlXFtB2RvOu2WsvKfFUI9bcPq07U9m3egJ/RJ28eAq?=
 =?us-ascii?Q?d+qGwYyj5QemKg+o+08PKVBskWM2qln78HilyKMPokOVNSadFp19xlO3KLDP?=
 =?us-ascii?Q?bsgXkkRfzdtPuaISTQj2g35Ow4LJNiei+jUyTtJ62NeI20pzOdy9kqHOtwOn?=
 =?us-ascii?Q?XtmyR77Pp2fZIyY8/2b/Qse93MADrD5CsyKXpYWwokHmOVlkmZH9zdUBLLHm?=
 =?us-ascii?Q?NSqFxxx2oMans7f4W/gRJtYTT6rs90O9BwhwI95/gTwDPT9RqlQxEFIXziuK?=
 =?us-ascii?Q?MIqoTC3lgGlOrUhieg+rDGtT+jPMnulQoE60OziVSTo0lcVTolxUv7DLVGml?=
 =?us-ascii?Q?EMmzKJel+r83ITTh8uKHgCycaaicp4m8Z78+Bqj34fZnUEEm9fcGDusW8Q/i?=
 =?us-ascii?Q?q+KPU6GshNs9gDPdnRn5mq8SH82GdzX8XckiUUIU6XpecPwCZVGR30Et8xSn?=
 =?us-ascii?Q?EW2pEwVKGeCd2+7S6AAXKQMuek/uN97A2Sny/MZHKos0aO+U0wEMLbLtOkJS?=
 =?us-ascii?Q?FFBtSLI8edkObUhB4X8QvlpzKzpwsYovXGHe3H2LhFrtqCDzs6MqTF5DQTgA?=
 =?us-ascii?Q?eL2d4N1FDLREQQLlRrXY1CuCkaUcd3fD0S/9Q5zlx6cT0y0O9lN6gj5SZkCU?=
 =?us-ascii?Q?RJI2e1+XdqyP4SxEyow7jpCvCzSaAlpQ705t5H17CxdGf0CQFC6pX12+ntXC?=
 =?us-ascii?Q?LvB4lWdozd56vFSYMpKqbUO1UbyEgXKOr2lV3wjsQWTA/ek/EfMDp3+IOiwQ?=
 =?us-ascii?Q?6w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 012b88cc-8703-4bb4-4fe6-08db03b5402f
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2023 18:02:00.3551
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qb1cWE7ZXLDMP6ZjlVdPZPI8nb25stB6RbIwLwEsVR3NdMKK/sYEIfPBBFNW968wVlm/DiLPYfE0SMdQx2qVsM62XGsKbYwRhZ2KMgBXXpE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB1954
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Tianyu Lan <ltykernel@gmail.com> Sent: Saturday, January 21, 2023 6:4=
6 PM
>=20
> Hypervisor needs to access iput arg page and guest should decrypt
> the page.
>=20
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> ---
> Change since RFC V2:
> 	* Set inputarg to be zero after kfree()
> 	* Not free mem when fail to encrypt mem in the hv_common_cpu_die().
> ---
>  drivers/hv/hv_common.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index f788c64de0bd..205b6380d794 100644
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
> @@ -125,6 +126,7 @@ int hv_common_cpu_init(unsigned int cpu)
>  	u64 msr_vp_index;
>  	gfp_t flags;
>  	int pgcount =3D hv_root_partition ? 2 : 1;
> +	int ret;
>=20
>  	/* hv_cpu_init() can be called with IRQs disabled from hv_resume() */
>  	flags =3D irqs_disabled() ? GFP_ATOMIC : GFP_KERNEL;
> @@ -134,6 +136,17 @@ int hv_common_cpu_init(unsigned int cpu)
>  	if (!(*inputarg))
>  		return -ENOMEM;
>=20
> +	if (hv_isolation_type_en_snp()) {
> +		ret =3D set_memory_decrypted((unsigned long)*inputarg, pgcount);

You used "pgcount" here in response to a comment on v2 of the
patch.  But the corresponding re-encryption in hv_common_cpu_die()
uses a fixed value of "1".   The two cases should be consistent.  Either
assert that hv_root_partition will never be true in an SNP VM, in which
case hard coding "1" is OK.  Or properly calculate the number of pages
in both cases so they are consistent.

> +		if (ret) {
> +			kfree(*inputarg);
> +			*inputarg =3D NULL;
> +			return ret;
> +		}
> +
> +		memset(*inputarg, 0x00, PAGE_SIZE);
> +	}
> +
>  	if (hv_root_partition) {
>  		outputarg =3D (void **)this_cpu_ptr(hyperv_pcpu_output_arg);
>  		*outputarg =3D (char *)(*inputarg) + HV_HYP_PAGE_SIZE;
> @@ -168,7 +181,12 @@ int hv_common_cpu_die(unsigned int cpu)
>=20
>  	local_irq_restore(flags);
>=20
> -	kfree(mem);
> +	if (hv_isolation_type_en_snp()) {
> +		if (!set_memory_encrypted((unsigned long)mem, 1))
> +			kfree(mem);
> +	} else {
> +		kfree(mem);
> +	}
>=20
>  	return 0;
>  }
> --
> 2.25.1

