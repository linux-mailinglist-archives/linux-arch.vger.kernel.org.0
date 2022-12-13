Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E26FD64BADD
	for <lists+linux-arch@lfdr.de>; Tue, 13 Dec 2022 18:19:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235405AbiLMRTh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Dec 2022 12:19:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235729AbiLMRTf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 13 Dec 2022 12:19:35 -0500
Received: from CO1PR02CU001-vft-obe.outbound.protection.outlook.com (mail-westus2azon11021018.outbound.protection.outlook.com [52.101.47.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B63DF20F49;
        Tue, 13 Dec 2022 09:19:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PuibAHOT55kz+k3JQG+ug/WgrmxHnoygPH40hzp3s4V3RbLfY0u2vzKVzLh6QE9syuwMsfX+OiA4E3qK707oZg+uLp/ADcto0rSTTKVZbSrBts7V6gxgyoB7CYN91eGKEVEWQmTpvHHPKF+6+wK7B9HdKqdFFmxORLDMx3h53Hmv85Y5NPRHTdyb78dkPGn7Zsku98H1AKCiIyPF0rDbFu1a+2RAsYel5++px7bj4WtLVBtA4VMton2+SQoHdHQDdbYu5JNMb32xqo/klCpbut+YIfXMal1T9wgvKSDlZ+DbNA92Z5PzWd/dpRF8Q5gknNkiYrSsra316MoirAQA+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n9DGXAxsAk0gLKckNWZyG9WdTjCNcYAlpbZ45tOObls=;
 b=k4QnaoZaethbZKw+iHFc2pQOHdDocWgocec1IAkLqfTT/g62F+FAakA0BIbz2i1NjQhXRoDrTAy/lSRTh5yen7rZxYZvnIrbPr3uFw+tqopSXp5e4zd8sZUbxQwgAAuN9zv8QM77x+EurKet9vrxrMFXwW3DAtQYcnuy73y0rzi2bapDDRZ8B56BbhJign9rH0Pd9+t1UwSCS19veRuMu4UoZ+nEdWXy5omqUxS2Exd/3Ra1PeTKtLZaDS/ITxnp+4Y2z2Rv02RPN5zoQrchMpPOtNtMJriLeVLaw72iZXAGNO4acP73yW79F6RR8h5MbM4IkWDpuF2XjUeDl1o4AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n9DGXAxsAk0gLKckNWZyG9WdTjCNcYAlpbZ45tOObls=;
 b=MiyUdSPO+bq6rscKv8Eli56Y3rMCtp5Wz3tWLD/KkjPQ+4vN8MZafs4xpCgZxCNcBKrGRmRX8Qa4sDT3QhEe0tNwVFB1vUMVKiOBqewHhXyvH9WLV+ww0e4Tykrvtb/mm7xiVoWFRazXyTMa781E6HvxVxF0ZVq2OCAupxrlwJE=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by MN2PR21MB1503.namprd21.prod.outlook.com (2603:10b6:208:1f7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.0; Tue, 13 Dec
 2022 17:19:26 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::1e50:78ec:6954:d6dd]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::1e50:78ec:6954:d6dd%8]) with mapi id 15.20.5944.002; Tue, 13 Dec 2022
 17:19:26 +0000
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
Subject: RE: [RFC PATCH V2 06/18] x86/hyperv: Use vmmcall to implement hvcall
 in sev-snp enlightened guest
Thread-Topic: [RFC PATCH V2 06/18] x86/hyperv: Use vmmcall to implement hvcall
 in sev-snp enlightened guest
Thread-Index: AQHY+8mhT4urGRjzaU6DopEVErqwfq5sL68w
Date:   Tue, 13 Dec 2022 17:19:25 +0000
Message-ID: <BYAPR21MB1688016185991B6298EBF308D7E39@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20221119034633.1728632-1-ltykernel@gmail.com>
 <20221119034633.1728632-7-ltykernel@gmail.com>
In-Reply-To: <20221119034633.1728632-7-ltykernel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=fd3bca26-1a03-43d2-bf71-8c8d7a67c50e;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-12-13T16:54:57Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|MN2PR21MB1503:EE_
x-ms-office365-filtering-correlation-id: 200a28ec-29e4-458e-7b83-08dadd2e2f46
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: or17FyabKLikmMGkTzNvhWegKH/Gf9vhbXNpcG93mxvikFLAQzjLtbRpdWGYmmJtN6VQW8+XkFhsQFGlZu/WYYrvrmj4b2K4sQkuAz7B1gvHSz04GPBg83YWlPvENlVV1mKFF8bUxrvmRQXbqu32fBtIylx/aZVCajef0wCVFDGfZ2dX4LIJt0OiFfwctyjA5+hoWeXA7mV7DgDLSzdCtCauunA6seqcp1ZSmVFzuxXT9LpJrLj79z7b3WX80yr9dZtrDCDf3KHQltKra130W6b3S2zoWzY4hRZUkL2cStt0VgGoytGOAO2ESS/HFCPO7t59Gc207LA7PoWmNcB0DM6NtVXTVmxenc4ujqt7WTXrKPNDNQVq9UMgu2Thzv/yMhgEZ/0UbvvkH4MliUZhcJmLXmV1G0/jqF2lZJT0PCfusAqIVhlNig1AaHt8hZGDwQRPl+i8J4bFBUX+QxHKCQrbyQGOKs9+YIRyeOUizGboRWzHFolnmNDlh6Y54KzHGl2lF21TapeL+fuuEUf3hr00emArpNS6mFdrPZW/wAFKOuFvtAVPczHL9xOM/0gGSjs2qH5UMhnjkPuhHyU9pIdJTPqaO6SXPLVVdnjzqWvvN2bHs6Atq0g/cHTjpaCuGI6R6PGexkx4lXa6WYZTFSSBp06yi4RkD85FCj6BsDoqO5vBxMdWgMJ9bfQqipseplxBcPupfOj1qAY762UGA3XHWj5h8W5EKOX+l7iUZa/puC3udPSUODV7mVhn0++gdYVEJQuwB8F69qKrZFFSHg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(396003)(39860400002)(136003)(366004)(451199015)(26005)(6506007)(7696005)(9686003)(186003)(478600001)(8990500004)(82950400001)(82960400001)(83380400001)(33656002)(55016003)(122000001)(921005)(38070700005)(38100700002)(86362001)(10290500003)(71200400001)(52536014)(66446008)(66946007)(5660300002)(64756008)(66476007)(66556008)(8676002)(7406005)(76116006)(4326008)(7416002)(8936002)(41300700001)(54906003)(2906002)(110136005)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?feqwup2VG8aFscu8WH4TnlGuFZB5eBZqOEwIfd/67EvUnSqPs+sXk31FjJ14?=
 =?us-ascii?Q?L3crOy+MJVxjYJhD9ZJ/RadvR3L43Gf741XGA0bCIMGzaqeCC+pMFHlBeTr+?=
 =?us-ascii?Q?ujJDsv+PhM7mzVnZGD7nwR528KaX3d11t/F+9l16Zs5NiU44ClyN/Vub/4oH?=
 =?us-ascii?Q?iCTz05qb0fX/lchRpCSrKWfS1pWO2DGeFtI7DXIwsZNf5oOOaKqDxwDT75up?=
 =?us-ascii?Q?w0mjypzuVSVUQtUsp8aGqo2/c0gsaDZpM0Tv8o6WZxeSg3uPFbvMrM3T6RpV?=
 =?us-ascii?Q?kXhGzwLbpoDvjwKOyuGWSCGAIqKhxGT6/RsSacSKd1jiKuj+Se4Gd0PDxlZ5?=
 =?us-ascii?Q?G3Zw16Vrl38lm4GdsDm4fVEqVtyRedc+w56//b1lVYdZLZzRWGbrqkudj26U?=
 =?us-ascii?Q?Xg96HSyVuLzz4ZIo7W1NgHi3B8Az/myV96G1frdwTTAKa/EUDNs4pgyY/msc?=
 =?us-ascii?Q?Vm4iT14aOH1FuU4hVR7iOrRvmZ4fudrLssfJcQtAhAtDWkjioZFAInGA8BDm?=
 =?us-ascii?Q?O9/IWM9PKvInO8S28qQ5urdvc/3SKS5u7d0ztSCTvpTdlBCdBtPUX8teDAHu?=
 =?us-ascii?Q?K7tz1DIesfouxd+ewcAhFaXvV5sMWrTE1MaO7IUmJoiHcX0O4assAhw6grDL?=
 =?us-ascii?Q?I95L9hRPZ+YNHc0UXTeiUNFyA/646ySQSRB0hVjT7gcFdww/FWEN2eF/L/kr?=
 =?us-ascii?Q?zn213DWnHhXaZ12rGlF9GdLvYHNqJw4TVGH5u0Dq7eALur8Qf5vmMnDo8SDP?=
 =?us-ascii?Q?2VX+XhoGCakMvK5FL7aKU+lhhhcSX07wiXfYKlM8UKo4XCGK8fTBmDtM33OH?=
 =?us-ascii?Q?lPOlz+dpLbEMNuGf11V8phga+yuUEHOwyzcCqS3qP/ZikgrPmjZ5iOIWgpc2?=
 =?us-ascii?Q?O8eL9nk0UMBskGmfTijJJOdmJs503dVypJdMvUd4dfUiHopsDvVQMKt7nrmr?=
 =?us-ascii?Q?tJoNhFnvy1vdS8vWEDqzDQ7AGh2EGkXjOibvLqzlTbJNu2uM6LkdCAV5FA6i?=
 =?us-ascii?Q?97KdXcwyx7llTmtdXar9bOlqhK5VNQVN8I2rlM9/UPeTZAzpXXtyVUM5JMgd?=
 =?us-ascii?Q?GlOXh6r/QX0WaxDB3WdcXs39sqwWF/fOepRzeDNkxDVu6QLDpqAmrq7BnrrI?=
 =?us-ascii?Q?UvollRyNFpplCTHtFfGwZA3CqnoO46soQHf8i074CkD9+jlVQfRA747Lg6Wi?=
 =?us-ascii?Q?cFRNljFnMw4SYVO8PTuaCZWe9Is+y8NFYG02VSQxIZKigCE1WznDnf9GiQVX?=
 =?us-ascii?Q?Nx/PqkLKDkzbYmBcdjBsUrR56Mcfo8zzu7PQ9T7e+dIqiuGmtHfDwSieIVqg?=
 =?us-ascii?Q?KrCPskxxQgUq+x2sMwT9fhr+QZGEfLdpGZaRM/dc1mL4sLuHgyXAPKG4Yvve?=
 =?us-ascii?Q?90Po0RvzXy46uzXKTJHxtUepeWerO5PHKFNr6x+5H2za0TX64tuMdUcy3b74?=
 =?us-ascii?Q?ASb0uhOZhSohX2jXx7Xde936BnDFHuxMcEwvzFVTUmvACyGVGod2IxhEKVOH?=
 =?us-ascii?Q?pNRkdiEwrBzGr/ZthTRLwrEdUpeTdWsuqZfQtSysVs9tcP1XqZ5GkNWT+mXF?=
 =?us-ascii?Q?yuu+DfWfpNn0nn2c2eYRI4s6oJW8rDB1e2gCeBErqoAeCWivP/PHTMcu1GiA?=
 =?us-ascii?Q?rA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 200a28ec-29e4-458e-7b83-08dadd2e2f46
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2022 17:19:25.7103
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MQI3qbDMhKTRRG7D+2iiduJXiIDxm3NSJevQAl8AQg/WTBqzDHnbbv/Ies+riqovwmd+Afyv4TOYPrwoGlHsiSKEU5qRIwhaD2Wd+iSAYc0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR21MB1503
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
> In sev-snp enlightened guest, hvcall needs to use vmmcall to trigger

What does "hvcall" refer to here?  Is this a Hyper-V hypercall, or just
a generic hypervisor call?

> vmexit and notify hypervisor to handle hypercall request.
>=20
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> ---
>  arch/x86/include/asm/mshyperv.h | 66 ++++++++++++++++++++++-----------
>  1 file changed, 45 insertions(+), 21 deletions(-)
>=20
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyp=
erv.h
> index 9b8c3f638845..28d5429e33c9 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -45,16 +45,25 @@ static inline u64 hv_do_hypercall(u64 control, void *=
input, void *output)
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
>  	u32 input_address_hi =3D upper_32_bits(input_address);
>  	u32 input_address_lo =3D lower_32_bits(input_address);
> @@ -82,12 +91,18 @@ static inline u64 hv_do_fast_hypercall8(u16 code, u64=
 input1)
>  	u64 hv_status, control =3D (u64)code | HV_HYPERCALL_FAST_BIT;
>=20
>  #ifdef CONFIG_X86_64
> -	{
> +	if (hv_isolation_type_en_snp()) {
> +		__asm__ __volatile__(
> +				"vmmcall"
> +				: "=3Da" (hv_status), ASM_CALL_CONSTRAINT,
> +				"+c" (control), "+d" (input1)
> +				:: "cc", "r8", "r9", "r10", "r11");
> +	} else {
>  		__asm__ __volatile__(CALL_NOSPEC
> -				     : "=3Da" (hv_status), ASM_CALL_CONSTRAINT,
> -				       "+c" (control), "+d" (input1)
> -				     : THUNK_TARGET(hv_hypercall_pg)
> -				     : "cc", "r8", "r9", "r10", "r11");
> +				: "=3Da" (hv_status), ASM_CALL_CONSTRAINT,
> +				"+c" (control), "+d" (input1)
> +				: THUNK_TARGET(hv_hypercall_pg)
> +				: "cc", "r8", "r9", "r10", "r11");

The above 4 lines appear to just have changes in indentation.  Maybe
there's value in having the same indentation as the new code you've
added, so I won't object if you want to keep the changes.

>  	}
>  #else
>  	{
> @@ -113,14 +128,21 @@ static inline u64 hv_do_fast_hypercall16(u16 code, =
u64 input1, u64 input2)
>  	u64 hv_status, control =3D (u64)code | HV_HYPERCALL_FAST_BIT;
>=20
>  #ifdef CONFIG_X86_64
> -	{
> +	if (hv_isolation_type_en_snp()) {
>  		__asm__ __volatile__("mov %4, %%r8\n"
> -				     CALL_NOSPEC
> -				     : "=3Da" (hv_status), ASM_CALL_CONSTRAINT,
> -				       "+c" (control), "+d" (input1)
> -				     : "r" (input2),
> -				       THUNK_TARGET(hv_hypercall_pg)
> -				     : "cc", "r8", "r9", "r10", "r11");
> +				"vmmcall"
> +				: "=3Da" (hv_status), ASM_CALL_CONSTRAINT,
> +				"+c" (control), "+d" (input1)
> +				: "r" (input2)
> +				: "cc", "r8", "r9", "r10", "r11");
> +	} else {
> +		__asm__ __volatile__("mov %4, %%r8\n"
> +				CALL_NOSPEC
> +				: "=3Da" (hv_status), ASM_CALL_CONSTRAINT,
> +				"+c" (control), "+d" (input1)
> +				: "r" (input2),
> +				THUNK_TARGET(hv_hypercall_pg)
> +				: "cc", "r8", "r9", "r10", "r11");

Same here.  Above 5 lines appear to be changes only in indentation.

>  	}
>  #else
>  	{
> @@ -177,6 +199,7 @@ int hv_map_ioapic_interrupt(int ioapic_id, bool level=
, int vcpu,
> int vector,
>  		struct hv_interrupt_entry *entry);
>  int hv_unmap_ioapic_interrupt(int ioapic_id, struct hv_interrupt_entry *=
entry);
>  int hv_set_mem_host_visibility(unsigned long addr, int numpages, bool vi=
sible);
> +int hv_snp_boot_ap(int cpu, unsigned long start_ip);

This declaration doesn't seem to belong in this patch.  It should be
in Patch 13 of the series.

>=20
>  #ifdef CONFIG_AMD_MEM_ENCRYPT
>  void hv_ghcb_msr_write(u64 msr, u64 value);
> @@ -191,6 +214,7 @@ static inline void hv_ghcb_terminate(unsigned int set=
, unsigned
> int reason) {}
>  #endif
>=20
>  extern bool hv_isolation_type_snp(void);
> +extern bool hv_isolation_type_en_snp(void);

This declaration seems to be a duplicate that doesn't belong in
this patch.

>=20
>  static inline bool hv_is_synic_reg(unsigned int reg)
>  {
> --
> 2.25.1

