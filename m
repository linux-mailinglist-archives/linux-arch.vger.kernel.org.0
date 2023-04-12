Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 880B16DF941
	for <lists+linux-arch@lfdr.de>; Wed, 12 Apr 2023 17:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbjDLPCq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 Apr 2023 11:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbjDLPCp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Apr 2023 11:02:45 -0400
Received: from BN6PR00CU002.outbound.protection.outlook.com (mail-eastus2azon11021018.outbound.protection.outlook.com [52.101.57.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47532DC;
        Wed, 12 Apr 2023 08:02:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M2g/U+KeW5IEo0JAwkvoK5fWPwn2rNtT3uzS8f9OGbzJ1NtEKmEppjAYh0CnKM+jNCSGpxOtkDdzDXMyd6HOjZBo47JiScf3hAgsgCLYUHMLJ7l9bZ4k4cZ+Cx+F7decT6TpSUY1e8dMSnu2tqBzNfF0U/Lg0E07tY0QsTKGed+srH2wQwUUDD6lfKwBV0kpERlVgEMAK3UkqXfCatD9/NPadtDHjk3wgTp7VXpgfGLMihDGSuGDv1psaiY+fM0IRNeE4zL0MFpGyMvn/G4uQwULGLjjARPm4QS1fLGfxWdwRPBTxb69mV5sLyQXnROYBEkZlf9Y6WBxh5LmtLx99w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Rz6J1qlqD47ATrWFtLAcxBM58Cqe0SCAvaovW9G12k=;
 b=Q9GLA9eal8wPuFfncuEIw00nW/ez7KKV7npxepI25g3W+qovlzEQ3PjXyxDMBEeCpEsPWxRSseKzEYb6WVxxILzdZ0uLUdaQ28YL7V37zIE420VQrvwffQwhD4furHeriKrEg9IWtExudmJ0I5uNPc5BApz5QhS+x2tuCco/L65Y2QPRmPFCImm5/Sbq6zkzpio2aYZ0ASUFZk32UlZGTvZirnMZlADBWomYNXlzqkcWMl+G6h9g7/6azbSrBddhRnRKx5NOABtsaOGfEHE9Skw2e12YDukb2c55AR+quA/EfaiPhO6Z1+ARzYcqpX4hq9EFRCbgW2QAup51fCFr4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Rz6J1qlqD47ATrWFtLAcxBM58Cqe0SCAvaovW9G12k=;
 b=eOe51BvCxMfC8vkmyS7PR2sMGF5YI5RAZGp1tfTVYmeTP6mRXBl7a6zHrur2KQaXRUv6duBo5jEhXjesQxIoYdgeK5oEeKxCPQXE4uaSzSBBbeQNE3QXaF8j1z176P4dKa1dFYvq+XriIKQ3wxOESWkOHfjq4y+d4qKLwy90O9Y=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by CH3PR21MB4016.namprd21.prod.outlook.com (2603:10b6:610:178::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.4; Wed, 12 Apr
 2023 15:02:39 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::acd0:6aec:7be2:719c]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::acd0:6aec:7be2:719c%7]) with mapi id 15.20.6319.004; Wed, 12 Apr 2023
 15:02:32 +0000
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
CC:     "pangupta@amd.com" <pangupta@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: RE: [RFC PATCH V4 14/17] x86/hyperv/sev: Add AMD sev-snp enlightened
 guest support on hyperv
Thread-Topic: [RFC PATCH V4 14/17] x86/hyperv/sev: Add AMD sev-snp enlightened
 guest support on hyperv
Thread-Index: AQHZZlRT0ThUaqkS0k+wLQND5IeAFa8n0lkw
Date:   Wed, 12 Apr 2023 15:02:32 +0000
Message-ID: <BYAPR21MB16884681B85CE6C83CBC2B1FD79B9@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230403174406.4180472-1-ltykernel@gmail.com>
 <20230403174406.4180472-15-ltykernel@gmail.com>
In-Reply-To: <20230403174406.4180472-15-ltykernel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=9a1229e2-a6ed-4685-b5c2-a5a409036695;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-04-12T15:00:21Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|CH3PR21MB4016:EE_
x-ms-office365-filtering-correlation-id: 7b7a1c72-724d-425a-44e6-08db3b66f156
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EzKirbmC8DYbbzW/HF2htT+iekCKLapB9zarh7N2Kqr10lyc+UM2RLesdmqt1eQ15mxMTAmRz5AODzAFHWLjqhVuPoTJwDhWoHqkeBRZqBqH8RBaoY9zi5czYSzP4cvCh/g/vUs1CxAZvQl0mHRiPD/S5KMh7Es5qVYMVDUISCJkJtPCUFMtGjgwFvGeUhXd+el0r5Ebk1J+7DTtvsqvx7m0Oi8HGcOMdbX6IiiHykiEhFMo3Yop4evaRA/a0gKyLSPNNcp7flVldzv2cATZTc5hykeNnZ6wSbq/mx36Qwzgt/f6XK5BnXiMGKBGH75lyDHhNIrxLd2OiPM9wqkp0140UBvwITVzqeIYOD5b/3ngNncynkfUrqpu/uG1uWhvSeHPEeVUf2fs515LksX4aTU/rKMLw9i2c1lyfeAAsFH3aw0OgSwt9JqNXImTJOWxqrjNczUger4ZdHGM/adY44Rbh/RRcZdMpdKk+FUEeG6UTK5WFFCdYTL5sGWbTg+Z7huc2L7TgLLD2h8qtiL98j7EjeABTJdaTigdWqs6PbN93hg7nO0s42LpKtczYuy+VWWpmAV2MBRgxAygZLCqdgaAMRSo+m054H9LYvdADM6DVYwj6xQKSxsrrtFUV53ZiO/SVkpxUGMQftkbp4mzS2YUryJLCAojwAwizUnwhcmPeYDIunKLsIWlgj7Qye6G
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:cs;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(396003)(136003)(39860400002)(376002)(451199021)(33656002)(38100700002)(122000001)(7406005)(7416002)(5660300002)(52536014)(30864003)(2906002)(786003)(38070700005)(8676002)(55016003)(86362001)(8936002)(4326008)(66556008)(64756008)(66476007)(66946007)(66446008)(82950400001)(82960400001)(41300700001)(921005)(83380400001)(76116006)(26005)(316002)(54906003)(9686003)(110136005)(8990500004)(6506007)(10290500003)(7696005)(186003)(478600001)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9674VDfsr7bZfu2vpHPNe2YfhSNUXTLnE7GQWl0JbD6ebq62P1LqYZnr0StF?=
 =?us-ascii?Q?jVKcRtuQ/idyMvLIB3iKVwMcMNLMEMRO7LABPxNurcyLNbYMAErgNjccodEQ?=
 =?us-ascii?Q?R7eJxJDcVYw51kS5m5KBU/sqJvC8++DC3FYgV3GHGOXAqVD7kukkUpsjzzU6?=
 =?us-ascii?Q?1IJmSWYKDgbUa0mgbSpStJ9fx5P2B7PcLymBWGge5dE7+ugkKqafqQnl7t0o?=
 =?us-ascii?Q?9Gf9RUproRkxBDkhjM9fErjDuiXM8UJqbQ2y0Dy/o6i6m6xqiITYvloBC1tk?=
 =?us-ascii?Q?lFNqlMgqMIhCBaQ67iA5CuVIjgCZNBTEHa8NSD7fO9ybK2QAO0/VkeaZwmPT?=
 =?us-ascii?Q?oGSPswqpgNcybK8gGD/s04T8TdugS98g3Bna7x4e9Ro6FkDr0iM78uDg7jfj?=
 =?us-ascii?Q?+zIH8yLixO0N/xLJOwj9B2HyDFf0kQCJbVQX3t9yg0nFSjsPjiXeZ64lKpiT?=
 =?us-ascii?Q?/OltAvOxuzuYDShsfbCho+q1U3n322BMQsciMMBz2f8by73MR4uSgd90w22F?=
 =?us-ascii?Q?rlvm8GcDVJec/YFZ06vHYt2WcsCwb1q4KruHJ0Akygooefy3/jAjhJZkYkVB?=
 =?us-ascii?Q?8B/SCNS/Ad5miplvnTn5OO78bKqQZn85xX1mz3NJTPoefU9slBO1jioI4C4u?=
 =?us-ascii?Q?Us9RLykiYblOZXzLS7GtkB62mNMAoyyYg/pon13KF8z46kdZgiooxhRhokhK?=
 =?us-ascii?Q?YmLmF65/aN5lu1d+SlFvYB70qjzdc0FABxRwvw1AC355RVl2PUc2ksd5Y5m7?=
 =?us-ascii?Q?YYz4yg/rU79ikvp+D9xDk6NgWyQY4yYrNvsG05qx8T8WbChhhGcy/LdS9kh6?=
 =?us-ascii?Q?lVH70PxPaxxJI4PP/z9H7EcwCeC+k8nquuTfvl/47h+ra0s1uF/P1IPFXuA+?=
 =?us-ascii?Q?RO5hrWDtyZWREWsMmZHwCVkS6oLJ4W12KnWBpICQvbonyLXQZ3bUqhxvGnGH?=
 =?us-ascii?Q?ME1ZVW/fq5+mIGAQRB/CzLR8TSQuFSaOf2SOZQoOZWTCCTT23VeaJxVWbsba?=
 =?us-ascii?Q?CrgP7eAkEvZZiNoZVfSoOHo4DZVO/5xCMRaTVQOhcrF5UVC+LAxbMuOFgkPM?=
 =?us-ascii?Q?2rO4OGvfFfzSigntFHf6RWnqPhERDpzgqs2bzTy4aOxUByTkAzFgsNdteOAM?=
 =?us-ascii?Q?b+zEbJp9zBrOrCPJZghbsZsA8Jmvbw6toNgxpxG1hvh+7OmNmcxGvqy7EYvB?=
 =?us-ascii?Q?dsa8+P6aAPMzWnqQGMHD7/52/YgoW6LznF6xkgXkF/op3cWSYZ0QrMkSnoS4?=
 =?us-ascii?Q?o3unQHn/x+Tp9x1UdDgdWSVpnOrjFWZDXw3o5EiqZhKJw/xj6RjWmLIm5KsK?=
 =?us-ascii?Q?NfzK7lmWO3jUKA4Jo6hY15O/r1l3poKscer0gmdUgkTQV/2JZI+GBJ3aCxAJ?=
 =?us-ascii?Q?IhnXIWSd/dHVX13NihX+FY/BbRdC2eRmks1gWO9JJf5stH55rzG5yX0yJ9+5?=
 =?us-ascii?Q?qvZ8F23gonSg34UQ9TLhofdebmS4XpnNL2D7220bPDVXeaNiTHkwpelO9g6p?=
 =?us-ascii?Q?+RobNrpR/RUmWouvFIDRVAOMbIUEXsYaKi9PHES60Y6nKiRZbLXibhHtmYvM?=
 =?us-ascii?Q?6a9KYavg6PtlhvxFvDEN9J9RY1z8BkoHCUJto/+G2AbUalrT0uzN6fQJJvCv?=
 =?us-ascii?Q?MQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b7a1c72-724d-425a-44e6-08db3b66f156
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2023 15:02:32.4118
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1wc2NFks/GBFN+uyTFsA4q/jvErmEEhtws/m9bH1mCOBgyYe0o6ihf3OvuoDynff/Bsjznl89ipzzLlgdkrHWtKca1/e5g9wRv+ikAj1WIk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR21MB4016
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Tianyu Lan <ltykernel@gmail.com> Sent: Monday, April 3, 2023 10:44 AM
>

The patch subject prefix of "x86/hyperv/sev:" doesn't make sense.
There's no pathname like that in the kernel code.  I think it should just b=
e
"x86/sev:".
=20
> Enable #HV exception to handle interrupt requests from hypervisor.
>=20
> Co-developed-by: Lendacky Thomas <thomas.lendacky@amd.com>
> Co-developed-by: Kalra Ashish <ashish.kalra@amd.com>
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> ---
> Change since RFC V3:
>        * Check NMI event when irq is disabled.
>        * Remove redundant variable
> ---
>  arch/x86/include/asm/mem_encrypt.h |   2 +
>  arch/x86/include/uapi/asm/svm.h    |   4 +
>  arch/x86/kernel/sev.c              | 314 ++++++++++++++++++++++++-----
>  arch/x86/kernel/traps.c            |   2 +
>  4 files changed, 266 insertions(+), 56 deletions(-)
>=20
> diff --git a/arch/x86/include/asm/mem_encrypt.h
> b/arch/x86/include/asm/mem_encrypt.h
> index b7126701574c..9299caeca69f 100644
> --- a/arch/x86/include/asm/mem_encrypt.h
> +++ b/arch/x86/include/asm/mem_encrypt.h
> @@ -50,6 +50,7 @@ void __init early_set_mem_enc_dec_hypercall(unsigned lo=
ng
> vaddr, int npages,
>  void __init mem_encrypt_free_decrypted_mem(void);
>=20
>  void __init sev_es_init_vc_handling(void);
> +void __init sev_snp_init_hv_handling(void);
>=20
>  #define __bss_decrypted __section(".bss..decrypted")
>=20
> @@ -73,6 +74,7 @@ static inline void __init sme_encrypt_kernel(struct boo=
t_params
> *bp) { }
>  static inline void __init sme_enable(struct boot_params *bp) { }
>=20
>  static inline void sev_es_init_vc_handling(void) { }
> +static inline void sev_snp_init_hv_handling(void) { }
>=20
>  static inline int __init
>  early_set_memory_decrypted(unsigned long vaddr, unsigned long size) { re=
turn 0; }
> diff --git a/arch/x86/include/uapi/asm/svm.h b/arch/x86/include/uapi/asm/=
svm.h
> index 80e1df482337..828d624a38cf 100644
> --- a/arch/x86/include/uapi/asm/svm.h
> +++ b/arch/x86/include/uapi/asm/svm.h
> @@ -115,6 +115,10 @@
>  #define SVM_VMGEXIT_AP_CREATE_ON_INIT		0
>  #define SVM_VMGEXIT_AP_CREATE			1
>  #define SVM_VMGEXIT_AP_DESTROY			2
> +#define SVM_VMGEXIT_HV_DOORBELL_PAGE		0x80000014
> +#define SVM_VMGEXIT_GET_PREFERRED_HV_DOORBELL_PAGE	0
> +#define SVM_VMGEXIT_SET_HV_DOORBELL_PAGE		1
> +#define SVM_VMGEXIT_QUERY_HV_DOORBELL_PAGE		2
>  #define SVM_VMGEXIT_HV_FEATURES			0x8000fffd
>  #define SVM_VMGEXIT_TERM_REQUEST		0x8000fffe
>  #define SVM_VMGEXIT_TERM_REASON(reason_set, reason_code)	\
> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
> index 6445f5356c45..7fcb3b548215 100644
> --- a/arch/x86/kernel/sev.c
> +++ b/arch/x86/kernel/sev.c
> @@ -122,6 +122,152 @@ struct sev_config {
>=20
>  static struct sev_config sev_cfg __read_mostly;
>=20
> +static noinstr struct ghcb *__sev_get_ghcb(struct ghcb_state *state);
> +static noinstr void __sev_put_ghcb(struct ghcb_state *state);
> +static int vmgexit_hv_doorbell_page(struct ghcb *ghcb, u64 op, u64 pa);
> +static void sev_snp_setup_hv_doorbell_page(struct ghcb *ghcb);
> +
> +union hv_pending_events {
> +	u16 events;
> +	struct {
> +		u8 vector;
> +		u8 nmi : 1;
> +		u8 mc : 1;
> +		u8 reserved1 : 5;
> +		u8 no_further_signal : 1;
> +	};
> +};
> +
> +struct sev_hv_doorbell_page {
> +	union hv_pending_events pending_events;
> +	u8 no_eoi_required;
> +	u8 reserved2[61];
> +	u8 padding[4032];
> +};
> +
> +struct sev_snp_runtime_data {
> +	struct sev_hv_doorbell_page hv_doorbell_page;
> +};
> +
> +static DEFINE_PER_CPU(struct sev_snp_runtime_data*, snp_runtime_data);
> +
> +static inline u64 sev_es_rd_ghcb_msr(void)
> +{
> +	return __rdmsr(MSR_AMD64_SEV_ES_GHCB);
> +}
> +
> +static __always_inline void sev_es_wr_ghcb_msr(u64 val)
> +{
> +	u32 low, high;
> +
> +	low  =3D (u32)(val);
> +	high =3D (u32)(val >> 32);
> +
> +	native_wrmsr(MSR_AMD64_SEV_ES_GHCB, low, high);
> +}
> +
> +struct sev_hv_doorbell_page *sev_snp_current_doorbell_page(void)
> +{
> +	return &this_cpu_read(snp_runtime_data)->hv_doorbell_page;
> +}
> +
> +static u8 sev_hv_pending(void)
> +{
> +	return sev_snp_current_doorbell_page()->pending_events.events;
> +}
> +
> +#define sev_hv_pending_nmi	\
> +		sev_snp_current_doorbell_page()->pending_events.nmi
> +
> +static void hv_doorbell_apic_eoi_write(u32 reg, u32 val)
> +{
> +	if (xchg(&sev_snp_current_doorbell_page()->no_eoi_required, 0) & 0x1)
> +		return;
> +
> +	BUG_ON(reg !=3D APIC_EOI);
> +	apic->write(reg, val);
> +}
> +
> +static void do_exc_hv(struct pt_regs *regs)
> +{
> +	union hv_pending_events pending_events;
> +
> +	while (sev_hv_pending()) {
> +		pending_events.events =3D xchg(
> +			&sev_snp_current_doorbell_page()->pending_events.events,
> +			0);
> +
> +		if (pending_events.nmi)
> +			exc_nmi(regs);
> +
> +#ifdef CONFIG_X86_MCE
> +		if (pending_events.mc)
> +			exc_machine_check(regs);
> +#endif
> +
> +		if (!pending_events.vector)
> +			return;
> +
> +		if (pending_events.vector < FIRST_EXTERNAL_VECTOR) {
> +			/* Exception vectors */
> +			WARN(1, "exception shouldn't happen\n");
> +		} else if (pending_events.vector =3D=3D FIRST_EXTERNAL_VECTOR) {
> +			sysvec_irq_move_cleanup(regs);
> +		} else if (pending_events.vector =3D=3D IA32_SYSCALL_VECTOR) {
> +			WARN(1, "syscall shouldn't happen\n");
> +		} else if (pending_events.vector >=3D FIRST_SYSTEM_VECTOR) {
> +			switch (pending_events.vector) {
> +#if IS_ENABLED(CONFIG_HYPERV)
> +			case HYPERV_STIMER0_VECTOR:
> +				sysvec_hyperv_stimer0(regs);
> +				break;
> +			case HYPERVISOR_CALLBACK_VECTOR:
> +				sysvec_hyperv_callback(regs);
> +				break;
> +#endif
> +#ifdef CONFIG_SMP
> +			case RESCHEDULE_VECTOR:
> +				sysvec_reschedule_ipi(regs);
> +				break;
> +			case IRQ_MOVE_CLEANUP_VECTOR:
> +				sysvec_irq_move_cleanup(regs);
> +				break;
> +			case REBOOT_VECTOR:
> +				sysvec_reboot(regs);
> +				break;
> +			case CALL_FUNCTION_SINGLE_VECTOR:
> +				sysvec_call_function_single(regs);
> +				break;
> +			case CALL_FUNCTION_VECTOR:
> +				sysvec_call_function(regs);
> +				break;
> +#endif
> +#ifdef CONFIG_X86_LOCAL_APIC
> +			case ERROR_APIC_VECTOR:
> +				sysvec_error_interrupt(regs);
> +				break;
> +			case SPURIOUS_APIC_VECTOR:
> +				sysvec_spurious_apic_interrupt(regs);
> +				break;
> +			case LOCAL_TIMER_VECTOR:
> +				sysvec_apic_timer_interrupt(regs);
> +				break;
> +			case X86_PLATFORM_IPI_VECTOR:
> +				sysvec_x86_platform_ipi(regs);
> +				break;
> +#endif
> +			case 0x0:
> +				break;
> +			default:
> +				panic("Unexpected vector %d\n", vector);
> +				unreachable();
> +			}
> +		} else {
> +			common_interrupt(regs, pending_events.vector);
> +		}
> +	}
> +}
> +
>  static __always_inline bool on_vc_stack(struct pt_regs *regs)
>  {
>  	unsigned long sp =3D regs->sp;
> @@ -179,18 +325,19 @@ void noinstr __sev_es_ist_enter(struct pt_regs *reg=
s)
>  	this_cpu_write(cpu_tss_rw.x86_tss.ist[IST_INDEX_VC], new_ist);
>  }
>=20
> -static void do_exc_hv(struct pt_regs *regs)
> -{
> -	/* Handle #HV exception. */
> -}
> -
>  void check_hv_pending(struct pt_regs *regs)
>  {
>  	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
>  		return;
>=20
> -	if ((regs->flags & X86_EFLAGS_IF) =3D=3D 0)
> +	/* Handle NMI when irq is disabled. */
> +	if ((regs->flags & X86_EFLAGS_IF) =3D=3D 0) {
> +		if (sev_hv_pending_nmi) {
> +			exc_nmi(regs);
> +			sev_hv_pending_nmi =3D 0;
> +		}
>  		return;
> +	}
>=20
>  	do_exc_hv(regs);
>  }
> @@ -231,68 +378,35 @@ void noinstr __sev_es_ist_exit(void)
>  	this_cpu_write(cpu_tss_rw.x86_tss.ist[IST_INDEX_VC], *(unsigned long *)=
ist);
>  }
>=20
> -/*
> - * Nothing shall interrupt this code path while holding the per-CPU
> - * GHCB. The backup GHCB is only for NMIs interrupting this path.
> - *
> - * Callers must disable local interrupts around it.
> - */
> -static noinstr struct ghcb *__sev_get_ghcb(struct ghcb_state *state)
> +static bool sev_restricted_injection_enabled(void)
> +{
> +	return sev_status & MSR_AMD64_SNP_RESTRICTED_INJ;
> +}
> +
> +void __init sev_snp_init_hv_handling(void)
>  {
>  	struct sev_es_runtime_data *data;
> +	struct ghcb_state state;
>  	struct ghcb *ghcb;
> +	unsigned long flags;
>=20
>  	WARN_ON(!irqs_disabled());
> +	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP) ||
> !sev_restricted_injection_enabled())
> +		return;
>=20
>  	data =3D this_cpu_read(runtime_data);
> -	ghcb =3D &data->ghcb_page;
> -
> -	if (unlikely(data->ghcb_active)) {
> -		/* GHCB is already in use - save its contents */
> -
> -		if (unlikely(data->backup_ghcb_active)) {
> -			/*
> -			 * Backup-GHCB is also already in use. There is no way
> -			 * to continue here so just kill the machine. To make
> -			 * panic() work, mark GHCBs inactive so that messages
> -			 * can be printed out.
> -			 */
> -			data->ghcb_active        =3D false;
> -			data->backup_ghcb_active =3D false;
> -
> -			instrumentation_begin();
> -			panic("Unable to handle #VC exception! GHCB and Backup
> GHCB are already in use");
> -			instrumentation_end();
> -		}
> -
> -		/* Mark backup_ghcb active before writing to it */
> -		data->backup_ghcb_active =3D true;
>=20
> -		state->ghcb =3D &data->backup_ghcb;
> +	local_irq_save(flags);
>=20
> -		/* Backup GHCB content */
> -		*state->ghcb =3D *ghcb;
> -	} else {
> -		state->ghcb =3D NULL;
> -		data->ghcb_active =3D true;
> -	}
> +	ghcb =3D __sev_get_ghcb(&state);
>=20
> -	return ghcb;
> -}
> +	sev_snp_setup_hv_doorbell_page(ghcb);
>=20
> -static inline u64 sev_es_rd_ghcb_msr(void)
> -{
> -	return __rdmsr(MSR_AMD64_SEV_ES_GHCB);
> -}
> -
> -static __always_inline void sev_es_wr_ghcb_msr(u64 val)
> -{
> -	u32 low, high;
> +	__sev_put_ghcb(&state);
>=20
> -	low  =3D (u32)(val);
> -	high =3D (u32)(val >> 32);
> +	apic_set_eoi_write(hv_doorbell_apic_eoi_write);
>=20
> -	native_wrmsr(MSR_AMD64_SEV_ES_GHCB, low, high);
> +	local_irq_restore(flags);
>  }
>=20
>  static int vc_fetch_insn_kernel(struct es_em_ctxt *ctxt,
> @@ -553,6 +667,69 @@ static enum es_result vc_slow_virt_to_phys(struct gh=
cb
> *ghcb, struct es_em_ctxt
>  /* Include code shared with pre-decompression boot stage */
>  #include "sev-shared.c"
>=20
> +/*
> + * Nothing shall interrupt this code path while holding the per-CPU
> + * GHCB. The backup GHCB is only for NMIs interrupting this path.
> + *
> + * Callers must disable local interrupts around it.
> + */
> +static noinstr struct ghcb *__sev_get_ghcb(struct ghcb_state *state)
> +{
> +	struct sev_es_runtime_data *data;
> +	struct ghcb *ghcb;
> +
> +	WARN_ON(!irqs_disabled());
> +
> +	data =3D this_cpu_read(runtime_data);
> +	ghcb =3D &data->ghcb_page;
> +
> +	if (unlikely(data->ghcb_active)) {
> +		/* GHCB is already in use - save its contents */
> +
> +		if (unlikely(data->backup_ghcb_active)) {
> +			/*
> +			 * Backup-GHCB is also already in use. There is no way
> +			 * to continue here so just kill the machine. To make
> +			 * panic() work, mark GHCBs inactive so that messages
> +			 * can be printed out.
> +			 */
> +			data->ghcb_active        =3D false;
> +			data->backup_ghcb_active =3D false;
> +
> +			instrumentation_begin();
> +			panic("Unable to handle #VC exception! GHCB and Backup
> GHCB are already in use");
> +			instrumentation_end();
> +		}
> +
> +		/* Mark backup_ghcb active before writing to it */
> +		data->backup_ghcb_active =3D true;
> +
> +		state->ghcb =3D &data->backup_ghcb;
> +
> +		/* Backup GHCB content */
> +		*state->ghcb =3D *ghcb;
> +	} else {
> +		state->ghcb =3D NULL;
> +		data->ghcb_active =3D true;
> +	}
> +
> +	return ghcb;
> +}
> +
> +static void sev_snp_setup_hv_doorbell_page(struct ghcb *ghcb)
> +{
> +	u64 pa;
> +	enum es_result ret;
> +
> +	pa =3D __pa(sev_snp_current_doorbell_page());
> +	vc_ghcb_invalidate(ghcb);
> +	ret =3D vmgexit_hv_doorbell_page(ghcb,
> +				       SVM_VMGEXIT_SET_HV_DOORBELL_PAGE,
> +				       pa);
> +	if (ret !=3D ES_OK)
> +		panic("SEV-SNP: failed to set up #HV doorbell page");
> +}
> +
>  static noinstr void __sev_put_ghcb(struct ghcb_state *state)
>  {
>  	struct sev_es_runtime_data *data;
> @@ -1281,6 +1458,7 @@ static void snp_register_per_cpu_ghcb(void)
>  	ghcb =3D &data->ghcb_page;
>=20
>  	snp_register_ghcb_early(__pa(ghcb));
> +	sev_snp_setup_hv_doorbell_page(ghcb);
>  }
>=20
>  void setup_ghcb(void)
> @@ -1320,6 +1498,11 @@ void setup_ghcb(void)
>  		snp_register_ghcb_early(__pa(&boot_ghcb_page));
>  }
>=20
> +int vmgexit_hv_doorbell_page(struct ghcb *ghcb, u64 op, u64 pa)
> +{
> +	return sev_es_ghcb_hv_call(ghcb, NULL, SVM_VMGEXIT_HV_DOORBELL_PAGE,
> op, pa);
> +}
> +
>  #ifdef CONFIG_HOTPLUG_CPU
>  static void sev_es_ap_hlt_loop(void)
>  {
> @@ -1393,6 +1576,7 @@ static void __init alloc_runtime_data(int cpu)
>  static void __init init_ghcb(int cpu)
>  {
>  	struct sev_es_runtime_data *data;
> +	struct sev_snp_runtime_data *snp_data;
>  	int err;
>=20
>  	data =3D per_cpu(runtime_data, cpu);
> @@ -1404,6 +1588,19 @@ static void __init init_ghcb(int cpu)
>=20
>  	memset(&data->ghcb_page, 0, sizeof(data->ghcb_page));
>=20
> +	snp_data =3D memblock_alloc(sizeof(*snp_data), PAGE_SIZE);
> +	if (!snp_data)
> +		panic("Can't allocate SEV-SNP runtime data");
> +
> +	err =3D early_set_memory_decrypted((unsigned long)&snp_data-
> >hv_doorbell_page,
> +					 sizeof(snp_data->hv_doorbell_page));
> +	if (err)
> +		panic("Can't map #HV doorbell pages unencrypted");
> +
> +	memset(&snp_data->hv_doorbell_page, 0, sizeof(snp_data-
> >hv_doorbell_page));
> +
> +	per_cpu(snp_runtime_data, cpu) =3D snp_data;
> +
>  	data->ghcb_active =3D false;
>  	data->backup_ghcb_active =3D false;
>  }
> @@ -2044,7 +2241,12 @@ DEFINE_IDTENTRY_VC_USER(exc_vmm_communication)
>=20
>  static bool hv_raw_handle_exception(struct pt_regs *regs)
>  {
> -	return false;
> +	/* Clear the no_further_signal bit */
> +	sev_snp_current_doorbell_page()->pending_events.events &=3D 0x7fff;
> +
> +	check_hv_pending(regs);
> +
> +	return true;
>  }
>=20
>  static __always_inline bool on_hv_fallback_stack(struct pt_regs *regs)
> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> index d29debec8134..1aa6cab2394b 100644
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -1503,5 +1503,7 @@ void __init trap_init(void)
>  	cpu_init_exception_handling();
>  	/* Setup traps as cpu_init() might #GP */
>  	idt_setup_traps();
> +	sev_snp_init_hv_handling();
> +
>  	cpu_init();
>  }
> --
> 2.25.1

