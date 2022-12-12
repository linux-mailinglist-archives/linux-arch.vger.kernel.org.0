Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1029964A7CE
	for <lists+linux-arch@lfdr.de>; Mon, 12 Dec 2022 20:02:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232370AbiLLTCX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Mon, 12 Dec 2022 14:02:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233013AbiLLTBd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 12 Dec 2022 14:01:33 -0500
Received: from BN6PR00CU002-vft-obe.outbound.protection.outlook.com (mail-eastus2azon11021022.outbound.protection.outlook.com [52.101.57.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96509186FA;
        Mon, 12 Dec 2022 11:00:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LgycFBFjPib7HRcnI2PBmXNwrTqcxTVxHc5C0ATPFZKchoftiEEisRZ47ricAKayadjY8EpMgts38I3LjQqcBWz/ayjDcTONWGTrwLSUW3VxHxU+pgbmxMv7ASPq/LO4kiWVIweJP7B+C2Fcpb5ALXkieRkHsRSaGs/25SmqPxUO9ATjxaXcfveYosOr02vNMzjNH2XSb9NFbMKErbEGswBV8wHGqE3BvmY++UytirrN96w6x4UKuAS8lSZDqe8VUT3v0OC6aIjMZz6uFEG8lv/OEpgpweheZCNdYZB8Ba64ks/QWmNBDryCWmGMqflqxM+5f6RHGK3LtpKPpgTLBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=76H37JgUz8ozcIMUSgilJAT1eIMxlxWRclt8gawAchk=;
 b=ifccZFmBhMSfpoi/o0XHbXfjiXcY0zeKo+d6+UN22EHNuAUZodOskA1D7e52lueIgUHv0yRvOFyols7sB0jGf48e+qWy9GQYouXSD+YEgZEHB0680xRbgvputYluxc+81UtePGiwEcmfPXCt8ZQlQZlY/4unkd84tXHAkmwGR0qkCCp+LfuDTMLm3+PlYUk6ghi23J6WiehRAZuEeanrH0MW8PMpyDqmxv/6AVcVj52QtesT/KUG5PjQ/TpgGRGbtsQIDA1dR5iz/woYHxy7GUlbAd8ZZ0vafOJthxls6MlwBwxoeOtxxRG4aAfkrkQnMm/vbp3jAoYK6djSap/x3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by CD1PPFD714A2753.namprd21.prod.outlook.com (2603:10b6:340:1:0:2:0:16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.3; Mon, 12 Dec
 2022 19:00:08 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::1e50:78ec:6954:d6dd]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::1e50:78ec:6954:d6dd%8]) with mapi id 15.20.5944.002; Mon, 12 Dec 2022
 19:00:08 +0000
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
Subject: RE: [RFC PATCH V2 03/18] x86/hyperv: apic change for sev-snp
 enlightened guest
Thread-Topic: [RFC PATCH V2 03/18] x86/hyperv: apic change for sev-snp
 enlightened guest
Thread-Index: AQHY+8mg3EAGO7s3p06fCWlRWGUy2a5quS1g
Date:   Mon, 12 Dec 2022 19:00:07 +0000
Message-ID: <BYAPR21MB1688917E9C5BFC009DFD2AC3D7E29@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20221119034633.1728632-1-ltykernel@gmail.com>
 <20221119034633.1728632-4-ltykernel@gmail.com>
In-Reply-To: <20221119034633.1728632-4-ltykernel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=63ac7aba-b3aa-4c11-8dc8-905e127ec2fb;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-12-12T18:34:31Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|CD1PPFD714A2753:EE_
x-ms-office365-filtering-correlation-id: 8c2a0a1c-678b-41ec-cfab-08dadc731650
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D6SdcrjUrNm1E8PKolrMKtR03XTYegFwbiA+pS3ZP95v7ecvm8MIBibxd8DdPLWAdKVEIQlVwZ98bd8osX363i5v0EWVS/T3590nDbG6ZFc52hif+ESxb1PdOOPZ5e7TPsz1Y6nZo57oKXw23oCcdcRPZ/iJD/TAgPXJWD7Irl/bbmYxeMByVzzzKX9kXFl5hewm1XniSmnCofpaxXe3y9TXDGjK3WY+GPM7/Lui6eg/wW2Bu529Hg9piNFKb832CSDw/xU508+6RJ8b22Gw03qouVmh9KC6XJLW32j9NMSaU1RqlcyaRK8hQnAB3BFyuDASZz4fOhzi2ZfrAv8f9prVS5D/DkrXYJA0ZScyu2uzmaBtk7japIT8VmY1eAvfIg0ylG9iB9DAkX6FzHUydNlr8p3vXhAbOIsmEDVpr9QHgsqj1Rap+w+bF4zTMClg7GZ7wSdsG/VDHGAl8xQFNP4Oljg5kP4CaCCF8hz5reJG/6TEF40oi1r4woI4eZKTFlWAYEl+DRZmRqEenin0+/bsN+2yrUFRndncCwBwgwLZfpiEjMVKrfbaCRvzvLzCQXDnMmDDx2oFLEiZlxrPd++aO53C9wUy4uuzA3bKbTHSqw5SDI8uMJlUvPYjmqDWzgzwIkLQ3Q8HVbrGSKq/p8qCb/gmG270xaPAzB/uJ9rzrTn0TJILTskIdp8LL43ul/h1Hnxaz5LV/Ixjp2t7BQONn3V4aRjFXeNwaolitf3HskWPOnhUel2CVfCrf+salXYSJoVMi14wAd+82IoGJA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(39860400002)(136003)(366004)(376002)(451199015)(82950400001)(33656002)(6506007)(86362001)(921005)(7696005)(55016003)(38100700002)(8990500004)(10290500003)(9686003)(38070700005)(122000001)(83380400001)(7406005)(66946007)(82960400001)(186003)(71200400001)(478600001)(8936002)(26005)(54906003)(7416002)(66556008)(4326008)(66446008)(5660300002)(316002)(52536014)(110136005)(76116006)(8676002)(66476007)(2906002)(41300700001)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZkIvGV99HBaTrA6TSGOqLFOw7Jql3e+Z2IeUM39sJ9iMyYkbTKyraAlWSRZd?=
 =?us-ascii?Q?kRezvTF5J1zm/QjTSPhtCFfB3lCz1Kzl/CID587AMSIBLPc9u9BD+512zSP/?=
 =?us-ascii?Q?GMp6Jg+CZ2aPx6MP6Zg8jEzTDxDdBo91Z+D/zczcVw7RMD689r962Qj75mIh?=
 =?us-ascii?Q?LdxoxxxV5YZJn0m5Ko1StW6hk1Em1W9WhYpQklV5GFvYKgF3zmNhznSf8KMX?=
 =?us-ascii?Q?sK+WnI95s4Z7vj2KSFtqmjyjTfejs08OraTF67G18aCFPYdZxHKaPMYdWU18?=
 =?us-ascii?Q?s1B7fjAZL4XsId5kONltEIUgPWALLZkmOzfDujtfHwEOGxqlJEDmWrbz3S1q?=
 =?us-ascii?Q?NK78d9f2qDW5Gc3FK6bBihCxEQC2KbAIMzCNhwXh/S8V0vnsBTiUjXQJYRI4?=
 =?us-ascii?Q?bL6wr0x5BjAIBPKf4ItgaowJQ8R4VGsGB+Pa77zanO8JBA4EiqkmgMyVLaw+?=
 =?us-ascii?Q?72RwAz8CaQ83kcmr9oxQOWTH09kc6Uxsum5TKGoZyR5rbGqAjMmLB3JDuzuH?=
 =?us-ascii?Q?kXSEeRE/a4kf4IlyfPmCLarbd4VPRJKA4ztHNqTp7jzOsoeMOEqMIoaGFB0u?=
 =?us-ascii?Q?E25UxtNCtxtKH0VB/nGHK1KTnMEfJIdOMr4OT5riM0Y1FYsNzPjybziaHwIE?=
 =?us-ascii?Q?iOnywuJ/gVpzuor77e0g0DrwYuGEUevovm22+VBD4tf59/+jP1BTBAJeDZxC?=
 =?us-ascii?Q?NQdZgKeYoMZaNOwIlL1vvwV7F+zTHWiNF1kG2pG//WhF5GzgosG0HgQ1cbY3?=
 =?us-ascii?Q?vMCRzTZYvyjV2EYkmdc9Jjdsw+oM3x3WeyjKdOeBXSjrEjCatCNytKgmpWUp?=
 =?us-ascii?Q?2sW9N7JUGz7Z7Sxjq8NwJphiaPFNYw2+UERmHSDy3jbV0UYX4Qf+P5P4kfJ0?=
 =?us-ascii?Q?UqBZLbjFyzc96C/GWPPgPzJtI4zwsvkZ9AlfDsb6GxROGF3ugQ33wuzfDybw?=
 =?us-ascii?Q?6Do67lPmQzshMkZP3iL46sCrZgCSGJZz5d7TFktxVQez2JbKBpyT76rNouu/?=
 =?us-ascii?Q?3hTShElgDm5oTrcvg3S7w1H4spMumkHJreHCqltd96mnaxFnvBbtt/MUBz8H?=
 =?us-ascii?Q?DFWliNz1So2Y2OdYkI1jzW7QDZjfTqqTNPOUV6bvf698fWv5GJSg0RDycR/7?=
 =?us-ascii?Q?ibDgA9yuQKWvmJUdEqQZGyKMWKcJAJBdE52MSX2R7guv+I4Fq8enW9WO+yqK?=
 =?us-ascii?Q?unjXmH0yvokTdrfcEH6CtaFgPsqnEebiWFDVgxh8iyKkFkdmqK0exm1j7DgA?=
 =?us-ascii?Q?YyYQaz8wxTIY2/rEii6utx6g8Ou8ZFqDVDcc9x+lDLIPD6TINmXb+fCKnmPh?=
 =?us-ascii?Q?V2d26iVLeY9E7f97JWTf3Ia8ip6y7c655BsIC4+cP5TakVYDl4ZYOFgUCVSw?=
 =?us-ascii?Q?5+M8ZOq/RUXqMjux94AkfNv/mcgCZy5v0gBRArBvVAhML5elcjc7NKpIRS3c?=
 =?us-ascii?Q?BQ/zicr1592A83id5RZIMPqXWm8NXMZoSdnCy+acWx0TCWTIcGRhqqF1t/Bu?=
 =?us-ascii?Q?ZdgI44Q+HRDi7cBwoAhs02UbhW/cmQTwi1SqwfPZpLTe5dtadD6pMXZIuwBa?=
 =?us-ascii?Q?nSfguAbxO4HvAFOjM8bQr25GN75/N6bqxz4KbIcjrqZwiImhPatpcZx1W00P?=
 =?us-ascii?Q?GQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c2a0a1c-678b-41ec-cfab-08dadc731650
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2022 19:00:07.9778
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gc7mRqBIsFFYkqqUUL2gH5xWgwt/XmhKMRzQWJi8F/EGan05GF9TK0rdQHm5edgdDyklQTdg2nZzBg2/+Iu1VWa8ywSiRyB/K42lBES0eBM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CD1PPFD714A2753
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Tianyu Lan <ltykernel@gmail.com> Sent: Friday, November 18, 2022 7:46 PM
> 
> Hyperv sev-snp enlightened guest doesn't support x2apic and

How does lack of support for x2apic factor into the code below?  I
didn't see anything specific to the x2apic, but maybe I'm just not
knowledgeable about the association.

> apic page read/write operation. Bypass these requests. ipi
> request maybe returned with timeout error code and add retry
> mechanism.
> 
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> ---
>  arch/x86/hyperv/hv_apic.c         | 79 ++++++++++++++++++++++++-------
>  include/asm-generic/hyperv-tlfs.h |  1 +
>  2 files changed, 63 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
> index fb8b2c088681..214354d20833 100644
> --- a/arch/x86/hyperv/hv_apic.c
> +++ b/arch/x86/hyperv/hv_apic.c
> @@ -66,9 +66,15 @@ static u32 hv_apic_read(u32 reg)
>  		rdmsr(HV_X64_MSR_TPR, reg_val, hi);
>  		(void)hi;
>  		return reg_val;
> -
> +	case APIC_ID:
> +		if (hv_isolation_type_en_snp())
> +			return smp_processor_id();

Hmmm.  The Linux processor ID is not always equal to the APIC ID.
The specific case I'm aware of is a VM with multiple NUMA nodes,
where the number of vCPUs in a NUMA node is not a power of 2.
In that case, there's a gap in the APIC IDs, but not in the Linux
processor IDs.  But even outside that specific case, there's no
guarantee that the Linux processor IDs match the APIC IDs.

What specific code is trying to read the APIC ID this way? That use
case may influence choosing an alternate method of getting the
APIC ID that will be correct in all cases.

> +		fallthrough;
>  	default:
> -		return native_apic_mem_read(reg);
> +		if (!hv_isolation_type_en_snp())
> +			return native_apic_mem_read(reg);
> +		else
> +			return 0;

At first glance, just silently returning zero seems dangerous.
Is it a scenario that we never expect this to happen?  Or is there a
known set of scenarios where we know it is OK to return zero?  If
the former, what about using WARN_ON_ONCE(1) to catch any
unexpected uses?

In any case, a comment with an explanation would help folks
in the future who look at this code.

>  	}
>  }
> 
> @@ -82,7 +88,8 @@ static void hv_apic_write(u32 reg, u32 val)
>  		wrmsr(HV_X64_MSR_TPR, val, 0);
>  		break;
>  	default:
> -		native_apic_mem_write(reg, val);
> +		if (!hv_isolation_type_en_snp())
> +			native_apic_mem_write(reg, val);

Same here.  Doing nothing seems dangerous.

>  	}
>  }
> 
> @@ -106,6 +113,7 @@ static bool __send_ipi_mask_ex(const struct cpumask *mask, int vector,
>  	struct hv_send_ipi_ex *ipi_arg;
>  	unsigned long flags;
>  	int nr_bank = 0;
> +	int retry = 5;
>  	u64 status = HV_STATUS_INVALID_PARAMETER;
> 
>  	if (!(ms_hyperv.hints & HV_X64_EX_PROCESSOR_MASKS_RECOMMENDED))
> @@ -144,8 +152,10 @@ static bool __send_ipi_mask_ex(const struct cpumask *mask, int vector,
>  		ipi_arg->vp_set.format = HV_GENERIC_SET_ALL;
>  	}
> 
> -	status = hv_do_rep_hypercall(HVCALL_SEND_IPI_EX, 0, nr_bank,
> +	do {
> +		status = hv_do_rep_hypercall(HVCALL_SEND_IPI_EX, 0, nr_bank,
>  			      ipi_arg, NULL);
> +	} while (status == HV_STATUS_TIME_OUT && retry--);

Since the u64 status returned by hv_do_hypercall contains other fields besides
just the hypercall result, test "hv_result(status)" instead of just "status"

> 
>  ipi_mask_ex_done:
>  	local_irq_restore(flags);
> @@ -159,6 +169,7 @@ static bool __send_ipi_mask(const struct cpumask *mask, int vector,
>  	struct hv_send_ipi ipi_arg;
>  	u64 status;
>  	unsigned int weight;
> +	int retry = 5;
> 
>  	trace_hyperv_send_ipi_mask(mask, vector);
> 
> @@ -212,8 +223,11 @@ static bool __send_ipi_mask(const struct cpumask *mask, int vector,
>  		__set_bit(vcpu, (unsigned long *)&ipi_arg.cpu_mask);
>  	}
> 
> -	status = hv_do_fast_hypercall16(HVCALL_SEND_IPI, ipi_arg.vector,
> -				     ipi_arg.cpu_mask);
> +	do {
> +		status = hv_do_fast_hypercall16(HVCALL_SEND_IPI, ipi_arg.vector,
> +						ipi_arg.cpu_mask);
> +	} while (status == HV_STATUS_TIME_OUT && retry--);
> +

Same here. Test "hv_result(status)".


>  	return hv_result_success(status);
> 
>  do_ex_hypercall:
> @@ -224,6 +238,7 @@ static bool __send_ipi_one(int cpu, int vector)
>  {
>  	int vp = hv_cpu_number_to_vp_number(cpu);
>  	u64 status;
> +	int retry = 5;
> 
>  	trace_hyperv_send_ipi_one(cpu, vector);
> 
> @@ -236,26 +251,48 @@ static bool __send_ipi_one(int cpu, int vector)
>  	if (vp >= 64)
>  		return __send_ipi_mask_ex(cpumask_of(cpu), vector, false);
> 
> -	status = hv_do_fast_hypercall16(HVCALL_SEND_IPI, vector, BIT_ULL(vp));
> +	do {
> +		status = hv_do_fast_hypercall16(HVCALL_SEND_IPI, vector, BIT_ULL(vp));
> +	} while (status == HV_STATUS_TIME_OUT || retry--);
> +

Same here.  And I think you want "&&" like in the previous two cases
instead of "||".

>  	return hv_result_success(status);
>  }
> 
>  static void hv_send_ipi(int cpu, int vector)
>  {
> -	if (!__send_ipi_one(cpu, vector))
> -		orig_apic.send_IPI(cpu, vector);
> +	if (!__send_ipi_one(cpu, vector)) {
> +		if (!hv_isolation_type_en_snp())
> +			orig_apic.send_IPI(cpu, vector);
> +		else
> +			WARN_ON_ONCE(1);
> +	}
>  }
> 
>  static void hv_send_ipi_mask(const struct cpumask *mask, int vector)
>  {
> -	if (!__send_ipi_mask(mask, vector, false))
> -		orig_apic.send_IPI_mask(mask, vector);
> +	if (!__send_ipi_mask(mask, vector, false)) {
> +		if (!hv_isolation_type_en_snp())
> +			orig_apic.send_IPI_mask(mask, vector);
> +		else
> +			WARN_ON_ONCE(1);
> +	}
>  }
> 
>  static void hv_send_ipi_mask_allbutself(const struct cpumask *mask, int vector)
>  {
> -	if (!__send_ipi_mask(mask, vector, true))
> -		orig_apic.send_IPI_mask_allbutself(mask, vector);
> +	unsigned int this_cpu = smp_processor_id();
> +	struct cpumask new_mask;
> +	const struct cpumask *local_mask;
> +
> +	cpumask_copy(&new_mask, mask);
> +	cpumask_clear_cpu(this_cpu, &new_mask);
> +	local_mask = &new_mask;
> +	if (!__send_ipi_mask(local_mask, vector, true)) {
> +		if (!hv_isolation_type_en_snp())
> +			orig_apic.send_IPI_mask_allbutself(mask, vector);
> +		else
> +			WARN_ON_ONCE(1);
> +	}
>  }
> 
>  static void hv_send_ipi_allbutself(int vector)
> @@ -265,14 +302,22 @@ static void hv_send_ipi_allbutself(int vector)
> 
>  static void hv_send_ipi_all(int vector)
>  {
> -	if (!__send_ipi_mask(cpu_online_mask, vector, false))
> -		orig_apic.send_IPI_all(vector);
> +	if (!__send_ipi_mask(cpu_online_mask, vector, false)) {
> +		if (!hv_isolation_type_en_snp())
> +			orig_apic.send_IPI_all(vector);
> +		else
> +			WARN_ON_ONCE(1);
> +	}
>  }
> 
>  static void hv_send_ipi_self(int vector)
>  {
> -	if (!__send_ipi_one(smp_processor_id(), vector))
> -		orig_apic.send_IPI_self(vector);
> +	if (!__send_ipi_one(smp_processor_id(), vector)) {
> +		if (!hv_isolation_type_en_snp())
> +			orig_apic.send_IPI_self(vector);
> +		else
> +			WARN_ON_ONCE(1);
> +	}
>  }
> 
>  void __init hv_apic_init(void)
> diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
> index fdce7a4cfc6f..6e2a090e2649 100644
> --- a/include/asm-generic/hyperv-tlfs.h
> +++ b/include/asm-generic/hyperv-tlfs.h
> @@ -208,6 +208,7 @@ enum HV_GENERIC_SET_FORMAT {
>  #define HV_STATUS_INVALID_PORT_ID		17
>  #define HV_STATUS_INVALID_CONNECTION_ID		18
>  #define HV_STATUS_INSUFFICIENT_BUFFERS		19
> +#define HV_STATUS_TIME_OUT			0x78
> 
>  /*
>   * The Hyper-V TimeRefCount register and the TSC
> --
> 2.25.1

