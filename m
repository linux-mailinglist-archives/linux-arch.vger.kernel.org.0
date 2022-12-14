Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF6D464CF3F
	for <lists+linux-arch@lfdr.de>; Wed, 14 Dec 2022 19:16:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237749AbiLNSQN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 14 Dec 2022 13:16:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237808AbiLNSQM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 14 Dec 2022 13:16:12 -0500
Received: from BL0PR02CU005-vft-obe.outbound.protection.outlook.com (mail-eastusazon11022025.outbound.protection.outlook.com [52.101.53.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD8FDF12;
        Wed, 14 Dec 2022 10:16:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oC/oM+QRuFpTxtXlb6PWOFvUdkMk0EK3P9W2QrHAN0n9wX29iZCHg+MgtC11TIIbZXxVoAJehW1lj0mIy6Z0oeETCoQ45PzvfLTIFmSy+9kD3fu/UiSblwoN7p2CcIixOuPQ35Ko0nnVFKlx7Z4wXBWcEeJc+jpBQascuxgB1D0nlN9uUNgwPfK2Yld3g+uM3GP/AZWkESXazs/kLJ637Uqj3I5KgcEPSbPl7JANQHokNRiCgCbordePFOmoIZak4LhlZn6+0sbQ2dR/mUimKksSWQ4+d0Q8b+JNg/4RaRlxU/+4arkd5vRgZ9xUyhomGe5jLU/cfbgzTnvkRkCm/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZBk5BmG4TZgeCXqsi0HPM6+EBq7obY83vehyjAmt1eU=;
 b=VX0V7hccXp8vUDbUWI9eUrZuJmnb+8TeCPcQM0GRDenl9J2cQX+6F0ukV+lPNwTcd7YK4DnuEqsEhp9RUguaQke4rxE78/M8JsOGNLsNjwb4TBc+PIxcksIWLKxYdp6JXWDfvHbU2/Lv1WAVkqZxrxxzxf8OsJaws5IQHOazN546EQZ2yy0XF5MOQl5ahq+VDUxCNGoBb/5bNoTW1bumbtlv6ImpDlDZyyPR8U3ccZ2cXWByU0aGG2WYbYKheOzO2mBjt7/XXRWISeS/6XCIBERuo6kFxzjQ0XqT2CqtgK7TTWV7vr6nMi6EFzXz8IYdrEpsQlyIhvkr7fRfL04BBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZBk5BmG4TZgeCXqsi0HPM6+EBq7obY83vehyjAmt1eU=;
 b=WnYZoVzxP+ztEBIlCMTtyendSOOIjjykLYWLSfrMB9jaTsUrSHGcFwuy3HdcFLAadmngN5GEmjf15CYPX9Mjydn/jDeSNG19XrOkw4xKCpTT/87fT/mabyUkokhHFCzq128A7Bw3J4dfBjHKN9W6MxFf9XFpO7QnXHvDr8HFHmY=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by MN0PR21MB3724.namprd21.prod.outlook.com (2603:10b6:208:3d2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.2; Wed, 14 Dec
 2022 18:16:00 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::1e50:78ec:6954:d6dd]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::1e50:78ec:6954:d6dd%8]) with mapi id 15.20.5944.002; Wed, 14 Dec 2022
 18:16:00 +0000
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
Subject: RE: [RFC PATCH V2 10/18] drivers: hv: Decrypt percpu hvcall input arg
 page in sev-snp enlightened guest
Thread-Topic: [RFC PATCH V2 10/18] drivers: hv: Decrypt percpu hvcall input
 arg page in sev-snp enlightened guest
Thread-Index: AQHY+8ngH2xYzlquc0+21/Qo/2cVl65t2Ahg
Date:   Wed, 14 Dec 2022 18:16:00 +0000
Message-ID: <BYAPR21MB168878729E4A76AFC9B3E053D7E09@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20221119034633.1728632-1-ltykernel@gmail.com>
 <20221119034633.1728632-11-ltykernel@gmail.com>
In-Reply-To: <20221119034633.1728632-11-ltykernel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=2a347991-e6d0-420f-8518-3af9cfa7cd9c;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-12-14T18:13:45Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|MN0PR21MB3724:EE_
x-ms-office365-filtering-correlation-id: 967d1f0f-0651-4ddf-7312-08daddff40ec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 69GT8AxsZApE7psS0JNLqol+kMzkKRA2n8MM5mfOsTLm/54TAfMPYgEmEI5wiS+J70mG96CxCoVz1Ml5/uja9MPT/gvBPHBvy0aD1jOC5jVVaFhxuJPwNrbqeIFHkh5Rr6M2r9HnvjgW2iNXLZyBTPf56NCHfuoJqqlmZ+OrFP3UJgFLMQC4LhrrF5Y/TM2L72s/QPwWkUwa5XCvGavs6WMi78qMJgq9numsl1ATpm0A5U6fAWqm2BtN8p8jQJoNzb4s2PRYaKEIvHnUMvBdTpqgfIOpEM8s01znGJCTCbX8NVIyTCsMq0et2dl+2Tg+lP+nwUnHS+WStjZiI5mp0hC+pzY8gfg2xWu7LO8AvjUihLjKJ+03B3L6YHmr5tXwThQc59k5eONnCytz8AUxYVO8nrCurCPOCvHx+a6QEn3SrZNcD/ubjWO4Mls0aVv+/KgMVfdk825tyu5fKAhjQ0tXN4OUK+ORKmSaPd/gojyOeqnSgCJ3U8JR2+1XIoPa1mkUAIU7+uiPco5MpCrEXSdIbO/vMHrdDXCxyuT8tZWCuVWMEVuTRHUOtSl7s48wkD1+Sv/3VwVtNZQwFLqwRo+Rv+WaIqaxMXr814ZWuJ50/FgCDsvDHCki4GgDynq7ioFxsC90boUF2CvClWLWu5JHFVBjHaYejjI+A+WrlTXctxSUyViiD/TRahcXJHdUcbWXvCNVABoyEOlEaaluglRZAX6yAFCQPKG8X4qvBlePk17Q0LnMftmwXbCWpB80pWZnzqEtc8dQr1/pCDC6XA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(396003)(136003)(366004)(39860400002)(451199015)(38070700005)(86362001)(8936002)(7406005)(921005)(122000001)(8990500004)(33656002)(7416002)(2906002)(52536014)(5660300002)(83380400001)(8676002)(66556008)(10290500003)(66446008)(41300700001)(9686003)(110136005)(4326008)(66476007)(76116006)(55016003)(186003)(26005)(38100700002)(6506007)(71200400001)(7696005)(64756008)(82950400001)(66946007)(82960400001)(54906003)(478600001)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AZEiMJIv/5K466HKuHEHue3GdHLZ2VBZ4b1jR4SVcylbVUG/xaynLoJRat11?=
 =?us-ascii?Q?LnW5QxILbepNC0k3s+A8Zn0dpggUAgml1p+JlPYvmYCufOXuQXEPWzY/DKT1?=
 =?us-ascii?Q?Lokd6loNKknsswA8/D4qe/Dj7AyVgy7icpTvhTvi6K50/dNrhlxlzeJoZ1Dn?=
 =?us-ascii?Q?C6kxq7J3iHd65kMthzI/FZHnDSfkuBWj0dqYXXMj//iZza5HrZmX58m5ucr4?=
 =?us-ascii?Q?4Eeq3rPzQUdoh4wduo9IDQXzaDAREVcWs3PQLAv47MliWO7BzJq2eeb+AKnG?=
 =?us-ascii?Q?euYYCt389UVcAosnJScyC9Z3db0QYR2nu+OCqCW7DpNg3V7+nTGGz5jpIOaJ?=
 =?us-ascii?Q?ulGUPYxYR92FSPTx9gvovdy0xE+06RU0jKybgr/iZ525+y+/lEHciTh5Zmyf?=
 =?us-ascii?Q?i601qg2fdxX+HDlOOQpkxe7wj1Uodm0qKNc1s+hgieGcW62Si+HELt4b172m?=
 =?us-ascii?Q?tqRy1424vV9gyG5XWslKSNP+RiIPGOMzZcYvbpqa1lzS/HUbk67x5x0MYQlF?=
 =?us-ascii?Q?7Q+1DaZ5aIX43vOnzlS+44zI/p0B/Agvft4Kx87lB5FxADKgS1y0+9Ddz/wq?=
 =?us-ascii?Q?1bMDEtelbd3ZSOj6Vckn/sBfGiH8vN5y+jlrDz3gbwrykEomW2PKcBr94XRc?=
 =?us-ascii?Q?hgP+0UuSle56hs0IPGhShhUxGxvo+4zv304VugaLf4dSzbGrch0rTRjnh2RU?=
 =?us-ascii?Q?paES7NiBXU8L1AO911SfBNgrjwPhs0YlKrJx+WKxWwaEfq28rCfRL1JvCi6V?=
 =?us-ascii?Q?5kV0RXoM9S+a2napG/i7Rb+hrU5xNIaqXrVDz4rKxNRrKPEiWcMS7dVGl15/?=
 =?us-ascii?Q?/vDwil772lqUKLLEmSGD4wZMXfrHOTLXfRd3shYIZ89MrP/qgmitqYqSG/Kf?=
 =?us-ascii?Q?3iZEJ8X/KVdga7krkx/xisvjbjk6w+wjiGFOiEC+tVE/BO5l77sTSKlcP1mV?=
 =?us-ascii?Q?WKIHRjwBo5yTY/fbW4EbcMGauYvC5uCo2hKlxKLk+FFZIRz7O1HwaAINC/u8?=
 =?us-ascii?Q?v/0BNg+jONvROK5ysLpYj55Shp/mOqJcH8izwZSn6AiDRju5V8aNncHy7Q3g?=
 =?us-ascii?Q?/n8SHvEmPjUp15gvO6mWraVbrNYkoJBj6z77H73bfBq0Nh3bB88nqQcr/R+W?=
 =?us-ascii?Q?ze8IauXfgKH38dl/mkg2hsXb/6mYdDTVt5C4BLZQdLIgjdI/tiEMOvU4uPtM?=
 =?us-ascii?Q?c+8wQhY1uITBPk+33pI6h1cOvPEJ+rRJk2qN3xFHp6BjXaDtUKpn8OZEXetU?=
 =?us-ascii?Q?xtZ9inZzSHpLlWK38WfMKom3kKFlYXESIK/morcwwWzBQ+iEoI0Ng3fHzqYT?=
 =?us-ascii?Q?HiU/hqQu59XNfcXikIQTRSNG5lbsny6Z+DH7DzIv+gFTU4UpvhoKUDXp2VNH?=
 =?us-ascii?Q?h+ck1/zKcBG4z4lyyByrjgulS+ejz9pupPOvDE3MRJEIQHEVvKlBu/f3ErU3?=
 =?us-ascii?Q?pxLg0iOoLUH6cDfM35+eYphBl4ZkvzgadMYTsaNvHCtEPb6izN8k576maKS1?=
 =?us-ascii?Q?LgvZhtS8DkhKC4+PEFndgBcTu7fO0/rsAAcKDHAiezSf98G6oYdDH6KH0v0t?=
 =?us-ascii?Q?APSl+tccYqfdRrC3Bf/1xVCtCXMAurElILra4CzJLwvDd+7AXYEQ95XRCHKZ?=
 =?us-ascii?Q?ag=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 967d1f0f-0651-4ddf-7312-08daddff40ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2022 18:16:00.1358
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m6USFaUX0uHmqvNDtw4MoMhaTsLyXyqkko25+E47KMgJjjLnr2TFIjN6SUrVbuQOSKZFtUdZxGTeCLhsAFF7wF5WtKPLfh7Xjv8A2q6ddkE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR21MB3724
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
>=20
> Hypervisor needs to access iput arg page and guest should decrypt
> the page.
>=20
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> ---
>  drivers/hv/hv_common.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>=20
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index 2c6602571c47..c16961e686a0 100644
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
> @@ -134,6 +136,16 @@ int hv_common_cpu_init(unsigned int cpu)
>  	if (!(*inputarg))
>  		return -ENOMEM;
>=20
> +	if (hv_isolation_type_en_snp()) {
> +		ret =3D set_memory_decrypted((unsigned long)*inputarg, 1);
> +		if (ret) {
> +			kfree(*inputarg);

After the kfree(), set *inputarg back to NULL.  There's other code that
tests the value of *inputarg to know if the per-CPU hypercall page has
been successfully allocated.

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
> +
>  	kfree(mem);
>=20
>  	return 0;
> --
> 2.25.1

