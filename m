Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF8176F3020
	for <lists+linux-arch@lfdr.de>; Mon,  1 May 2023 12:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbjEAKU3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 1 May 2023 06:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjEAKU2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 1 May 2023 06:20:28 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2097.outbound.protection.outlook.com [40.107.117.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E7FE4C;
        Mon,  1 May 2023 03:20:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aV+owS5nEtqmycbG6d3cd3R7zpM2PZHbT/3NzQUWMLX6XAYtBmIZ6SqQ9udfcmD5mrTX44AqZYslt2QZt2ESymkwlpGVoBroi1A7xew+ZSP3q8txN50OurrS0UJZ01b4y7KmwEb+vbBP9Z/PkQ9j4T5QOI8oFD94mgXvC4PsjhOFYHbDb1J5aFUR4j9Yih8YE0L8Tbw2nWjKmWlqpq/GCnWnmfnjdcRgEGN5FuSutFk7rmjAJWPaTDOVttUAJDCLBlfa/NtZQatgXOhWfminjog+pSq655MpWDfyFMU3UUDCyFIuIKuEVEFwk6ZT29iUP9wPdE5S7MnL+LrrivzSNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=54lR9IngJIO59r5WLWe5pvb03f8RqEDw0q3EBc1d7GE=;
 b=nnZknbvL2LEvlcFrK65TvdyrS7KCh6bcBSirdT67RnexejimtzmPZhL0W+sf4qb+MaFfEiX031refg8C7H9XXPpopwf3zY/p7Y+rcM5aa2ENcz9NsDRsUS7dachBpM+LXuzxGq5Rwzjh9+MdxK1hsHaDtRrhzXo3qQBcHWlOPQ3nsZHPygWDOX8E5TGWoWjkAKgc3tGcqr4krqmzmLhcy0UKd5YP6lTxQdbkBamqkE9VWzi6jNc9GfCB2ZCfVeY+yhHHnN/pG0qJcVYz0iNKve626rxfOZvJoy9PFnkSyuDvj+cXtUgrV9n2yp1i2w/wM5mjuufMrj1Ef9EzoL9rAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=54lR9IngJIO59r5WLWe5pvb03f8RqEDw0q3EBc1d7GE=;
 b=LaO6YHcWSgPOWW78AUVX2SrYId4Qh15/q6xmTBt9Zr63mxrdA0stg/gDbosBbfBWwC2G/ZEqnNhwz6k8WdJHSopu/FgPkdNAQcKr+ffN+BO9dqdFj78lbpRESCWf1IL71yKGmgsgRdcvAskRWA9risJx7vib+WH9G6GHtByUsHw=
Received: from PUZP153MB0749.APCP153.PROD.OUTLOOK.COM (2603:1096:301:e6::8) by
 PUZP153MB0665.APCP153.PROD.OUTLOOK.COM (2603:1096:301:e6::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.5; Mon, 1 May 2023 10:20:22 +0000
Received: from PUZP153MB0749.APCP153.PROD.OUTLOOK.COM
 ([fe80::1cc2:aa38:1d02:9a11]) by PUZP153MB0749.APCP153.PROD.OUTLOOK.COM
 ([fe80::1cc2:aa38:1d02:9a11%2]) with mapi id 15.20.6387.005; Mon, 1 May 2023
 10:20:22 +0000
From:   Saurabh Singh Sengar <ssengar@microsoft.com>
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
Subject: RE: [EXTERNAL] [RFC PATCH V5 09/15] x86/hyperv: Add smp support for
 sev-snp guest
Thread-Topic: [EXTERNAL] [RFC PATCH V5 09/15] x86/hyperv: Add smp support for
 sev-snp guest
Thread-Index: AQHZfAsx7OPEtGqXGkOTjZ7IFQQyZK9FMnXg
Date:   Mon, 1 May 2023 10:20:22 +0000
Message-ID: <PUZP153MB07493DA8F1085DE38DB1AFB8BE6E9@PUZP153MB0749.APCP153.PROD.OUTLOOK.COM>
References: <20230501085726.544209-1-ltykernel@gmail.com>
 <20230501085726.544209-10-ltykernel@gmail.com>
In-Reply-To: <20230501085726.544209-10-ltykernel@gmail.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=9335665b-3a5b-42de-8911-c561d3eb762e;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-05-01T10:11:19Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZP153MB0749:EE_|PUZP153MB0665:EE_
x-ms-office365-filtering-correlation-id: ec096288-1538-4800-3568-08db4a2dabf8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PznExjjenAgCndaHifcFqpgz4UhoKI4o2uGFAjgzgjQj2CZ2OpTU08bo4X3MWxn0Y+Jk6n8aZ7OfQCVA0LHG2XrEfRDGqAmC0p5dMDohL/VGaOaHtQ3G4pX2pw6A5KTJFZ8imv792XvV0Z/NHgOcoxenqi5V1mZafyqeFkpU2eG7kxFDnO7skjo/bqihZJZJ3U6oAEl4JInIAb0P8BxUjtxswDA/6OJXwQkcC8NY+srNB3KiYaxCcX6pFa3qYTtJ4yNHEneOM6tCG7Q0MRypOiZM1ErO7m9txcxfcuvfHv4vuoJndZQq4ErAjnu14M4wZnH8RO6NPORTOkbsJ/XclokmRG1ksiKtArOKe1wk7AG+S8nqci11Jw7vqOPiiqXO4kV5BPhk+/hx6LpEs0EagiG3T0lVVKKqJUrxYJ+JoUyWnqu65EiQuU1yDvpZzdUA4NJZs0cUl1fJQClFNcHAvREO2oNVPBj+1oEj4jRLZNFEsbU3D6X/+TxBSasmVLrImSY1G0Wgxk+sNcM2ohvX7ma5JccxIi44AGEdZ0DS77yj06c/HpsdMC9WXroutc4riM6alN0CCGeUPoFQTgfyIgPjMivzf4bxZ9bm86HgnjF05Isl2hksVuqfV2UY4KekVfip5Oq8TmAiYWMMaCoyFJGeC+RMO052ElDbGHoMYuFtmHirQscI9ko/egxpAR5H
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZP153MB0749.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(396003)(346002)(136003)(376002)(451199021)(33656002)(86362001)(55016003)(10290500003)(478600001)(54906003)(110136005)(122000001)(7696005)(921005)(71200400001)(82960400001)(82950400001)(41300700001)(8936002)(8676002)(38100700002)(786003)(4326008)(66946007)(76116006)(64756008)(66446008)(66556008)(316002)(66476007)(83380400001)(6506007)(186003)(9686003)(53546011)(8990500004)(7416002)(7406005)(2906002)(5660300002)(38070700005)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YQhppg9kSKMkM60RTYJeu3ql5RwmUsL1adTgXEKs8NQk+WtPaKLkH3yTM31U?=
 =?us-ascii?Q?pygjQj7OIWDtSTb4Gyb+eoy4EsYen/ZL64HoQCbkn+Kf6YDcsn4fMRTvGmNh?=
 =?us-ascii?Q?+7T9IPOfi6FyfgFTYmZldgOR9RvoaQqaWwS3Na3UZxE0ROfm6tpCa2GK9AgQ?=
 =?us-ascii?Q?ajRHoMNSIC04EgKBLrFL4mG1TdUpq0Ykq1XkWnP71oiMM9KCVpdZbxZ8ESHt?=
 =?us-ascii?Q?pSsO4ii3Qr64NONSnMQKtMqWRYbIA54akvRH1FDjUgQ7yMozr0SiLdqbxh3l?=
 =?us-ascii?Q?75CeVEsE/vPuslrHClHitgO1BXn8B/4470cAGaYcVE+UqtrqW98vjLKtRBx1?=
 =?us-ascii?Q?q0BbigSBBIkJbovTQcP8W2VZUCMsFZSSShVW6d9rEla4RCdIdj+kz2EatixG?=
 =?us-ascii?Q?3nwQsxQmBzP/K/flOUFIptZD6ux3Fo2Ct+Gu2eLPlKopykv6jTQZNPPbPyMQ?=
 =?us-ascii?Q?0FoCo0RK8IrseQXMdumW4RUZM/sKR7HmfVFkCvkwaYhSbvgfTSXevRzFOAkW?=
 =?us-ascii?Q?shQTZRwHfc3MBUWVP8/DIPe3n44iu2ywrXl5Dntwn7WEC+YNP4gTTy3vQAfw?=
 =?us-ascii?Q?7MC4C5o+xJmMtJNbFt2KleylUr6KYURjmx6Cvors+KLMoMbVuZDpcAVEZWiA?=
 =?us-ascii?Q?onLjoH/6b5sLn/pKNlpq2vfV55aS/D2nc4lSpXD/NEJbocp/zmBq046pDdJG?=
 =?us-ascii?Q?BCGMuR6BK/VRj/6itG41kJIfjHmUx12sEBNkC23cTHKaOToUoCmRrIbJIUpG?=
 =?us-ascii?Q?qv9SxNLJcUg2oTOjrO8xMXmgQWVmYG7HRed67G1o6ID9oPUiBILkmfjAMOHK?=
 =?us-ascii?Q?MgOvsG6+ddunEMDTStDs56EvTrt53BEm63BzCtZGhfUBIEn288uEQ5r2KKBc?=
 =?us-ascii?Q?OxvCYvztzKjeYDltWj7uRxeVWXjhLlRJbbsYc891k/tIxvcRC1+36vGRx5GE?=
 =?us-ascii?Q?XAbkVubUHKz6BEEQWiXSj7fV3aKfOfsZduXZLFIRjohRVU4Bo1EznfqGe/dI?=
 =?us-ascii?Q?GdKYRj1LaM3x3JGGLHYg1LyGhsZNSyFosmkPjujTJQl2xvlIW/DDzfVQyQmK?=
 =?us-ascii?Q?YpI0Sch6Xl8IKgB391fVHV3usOOE+vANbdhxCV+/j/lje64EP5J+HUJR9BJI?=
 =?us-ascii?Q?Cw+ES2LIsmsDiKlMlBUqXqiwRxYPXC/z+yIAwkhpGD5hdJqT/XSSIWumbHsw?=
 =?us-ascii?Q?lAapWcObtbb+URR0eFIm43Pv61rdCEQ0SS+nEx1tFhcwvHuRX7Z/nVkJDiO/?=
 =?us-ascii?Q?VuWM/Z34Uxny0fT9eejpVOeMRS14whp7xJCn8EM/u/pqh00ca42aONRmwTnm?=
 =?us-ascii?Q?c0C+aUls5Z0GBCnbQhGk2XFvOL+FNvYedWkAXedtNKkPauFE4c2TQQ6I0ohd?=
 =?us-ascii?Q?jA2zyi8PMhM00e3E47LG766VA7HfEO9t9saAnDgn1HFVIuDJL0RFVBgpjEq8?=
 =?us-ascii?Q?PPIIaOaKFfwjC7LGaLmONUDnoxioZd+bUdaijDujmeXT/ykYHAWck7COHA7I?=
 =?us-ascii?Q?Ns8u3AZ/XXMtXiFbGQmKNRuKeNb5lihpO6HZnWeoePdJm4ukbHjZGGz/tsUR?=
 =?us-ascii?Q?GXAqp6jhN/bnDqGZVVvXGLoru7R7N2RdqZLKFnVq?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZP153MB0749.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: ec096288-1538-4800-3568-08db4a2dabf8
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2023 10:20:22.2052
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G5HJHmozMUbb2qTBHq65MfiOaxdV7pbHUogkU/xkIL8AfaVWsVCy12nlvapxak3wLh0NcLnR0oqO7XU9avMnBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZP153MB0665
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



> -----Original Message-----
> From: Tianyu Lan <ltykernel@gmail.com>
> Sent: Monday, May 1, 2023 2:27 PM
> To: luto@kernel.org; tglx@linutronix.de; mingo@redhat.com; bp@alien8.de;
> dave.hansen@linux.intel.com; x86@kernel.org; hpa@zytor.com;
> seanjc@google.com; pbonzini@redhat.com; jgross@suse.com; Tianyu Lan
> <Tianyu.Lan@microsoft.com>; kirill@shutemov.name;
> jiangshan.ljs@antgroup.com; peterz@infradead.org; ashish.kalra@amd.com;
> srutherford@google.com; akpm@linux-foundation.org;
> anshuman.khandual@arm.com; pawan.kumar.gupta@linux.intel.com;
> adrian.hunter@intel.com; daniel.sneddon@linux.intel.com;
> alexander.shishkin@linux.intel.com; sandipan.das@amd.com;
> ray.huang@amd.com; brijesh.singh@amd.com; michael.roth@amd.com;
> thomas.lendacky@amd.com; venu.busireddy@oracle.com;
> sterritt@google.com; tony.luck@intel.com; samitolvanen@google.com;
> fenghua.yu@intel.com
> Cc: pangupta@amd.com; linux-kernel@vger.kernel.org; kvm@vger.kernel.org;
> linux-hyperv@vger.kernel.org; linux-arch@vger.kernel.org
> Subject: [EXTERNAL] [RFC PATCH V5 09/15] x86/hyperv: Add smp support for
> sev-snp guest
>=20
> From: Tianyu Lan <tiala@microsoft.com>
>=20
> The wakeup_secondary_cpu callback was populated with wakeup_
> cpu_via_vmgexit() which doesn't work for Hyper-V and Hyper-V requires to
> call Hyper-V specific hvcall to start APs. So override it with Hyper-V sp=
ecific
> hook to start AP sev_es_save_area data structure.
>=20
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> ---
> Change sicne RFC v3:
>        * Replace struct sev_es_save_area with struct
>          vmcb_save_area
>        * Move code from mshyperv.c to ivm.c
>=20
> Change since RFC v2:
>        * Add helper function to initialize segment
>        * Fix some coding style
> ---
>  arch/x86/hyperv/ivm.c             | 89 +++++++++++++++++++++++++++++++
>  arch/x86/include/asm/mshyperv.h   | 18 +++++++
>  arch/x86/include/asm/sev.h        | 13 +++++
>  arch/x86/include/asm/svm.h        | 15 +++++-
>  arch/x86/kernel/cpu/mshyperv.c    | 13 ++++-
>  arch/x86/kernel/sev.c             |  4 +-
>  include/asm-generic/hyperv-tlfs.h | 19 +++++++
>  7 files changed, 166 insertions(+), 5 deletions(-)
>=20
> diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c index
> 522eab55c0dd..0ef46f1874e6 100644
> --- a/arch/x86/hyperv/ivm.c
> +++ b/arch/x86/hyperv/ivm.c
> @@ -22,11 +22,15 @@
>  #include <asm/sev.h>
>  #include <asm/realmode.h>
>  #include <asm/e820/api.h>
> +#include <asm/desc.h>
>=20
>  #ifdef CONFIG_AMD_MEM_ENCRYPT
>=20
>  #define GHCB_USAGE_HYPERV_CALL	1
>=20
> +static u8 ap_start_input_arg[PAGE_SIZE] __bss_decrypted
> +__aligned(PAGE_SIZE); static u8 ap_start_stack[PAGE_SIZE]
> +__aligned(PAGE_SIZE);
> +
>  union hv_ghcb {
>  	struct ghcb ghcb;
>  	struct {
> @@ -442,6 +446,91 @@ __init void hv_sev_init_mem_and_cpu(void)
>  	}
>  }
>=20
> +#define hv_populate_vmcb_seg(seg, gdtr_base)			\
> +do {								\
> +	if (seg.selector) {					\
> +		seg.base =3D 0;					\
> +		seg.limit =3D HV_AP_SEGMENT_LIMIT;		\
> +		seg.attrib =3D *(u16 *)(gdtr_base + seg.selector + 5);	\
> +		seg.attrib =3D (seg.attrib & 0xFF) | ((seg.attrib >> 4) & 0xF00); \
> +	}=09
						\

< snip>

>  	ghcb_set_sw_exit_info_2(ghcb, __pa(vmsa)); diff --git a/include/asm-
> generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
> index f4e4cc4f965f..959b075591b2 100644
> --- a/include/asm-generic/hyperv-tlfs.h
> +++ b/include/asm-generic/hyperv-tlfs.h
> @@ -149,6 +149,7 @@ union hv_reference_tsc_msr {
>  #define HVCALL_ENABLE_VP_VTL			0x000f
>  #define HVCALL_NOTIFY_LONG_SPIN_WAIT		0x0008
>  #define HVCALL_SEND_IPI				0x000b
> +#define HVCALL_ENABLE_VP_VTL			0x000f
>  #define HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE_EX	0x0013
>  #define HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST_EX	0x0014
>  #define HVCALL_SEND_IPI_EX			0x0015
> @@ -168,6 +169,7 @@ union hv_reference_tsc_msr {
>  #define HVCALL_RETARGET_INTERRUPT		0x007e
>  #define HVCALL_START_VP				0x0099
>  #define HVCALL_GET_VP_ID_FROM_APIC_ID		0x009a
> +#define HVCALL_START_VIRTUAL_PROCESSOR		0x0099
>  #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_SPACE 0x00af  #define
> HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_LIST 0x00b0  #define
> HVCALL_MODIFY_SPARSE_GPA_PAGE_HOST_VISIBILITY 0x00db @@ -223,6
> +225,7 @@ enum HV_GENERIC_SET_FORMAT {
>  #define HV_STATUS_INVALID_PORT_ID		17
>  #define HV_STATUS_INVALID_CONNECTION_ID		18
>  #define HV_STATUS_INSUFFICIENT_BUFFERS		19
> +#define HV_STATUS_TIME_OUT                      120
>  #define HV_STATUS_VTL_ALREADY_ENABLED		134
>=20
>  /*
> @@ -783,6 +786,22 @@ struct hv_input_unmap_device_interrupt {
>  	struct hv_interrupt_entry interrupt_entry;  } __packed;
>=20
> +struct hv_enable_vp_vtl_input {
> +	u64 partitionid;
> +	u32 vpindex;
> +	u8 targetvtl;
> +	u8 padding[3];
> +	u8 context[0xe0];
> +} __packed;
> +
> +struct hv_start_virtual_processor_input {
> +	u64 partitionid;
> +	u32 vpindex;
> +	u8 targetvtl;
> +	u8 padding[3];
> +	u8 context[0xe0];
> +} __packed;

"struct hv_enable_vp_vtl " is defined in arch/x86/include/asm/hyperv-tlfs.h=
. Please check if that can be reused in place of both the above structs.
- Saurabh

> +
>  #define HV_SOURCE_SHADOW_NONE               0x0
>  #define HV_SOURCE_SHADOW_BRIDGE_BUS_RANGE   0x1
>=20
> --
> 2.25.1

