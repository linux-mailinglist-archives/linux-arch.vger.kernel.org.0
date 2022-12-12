Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA7F64A82D
	for <lists+linux-arch@lfdr.de>; Mon, 12 Dec 2022 20:41:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232885AbiLLTlh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Dec 2022 14:41:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232254AbiLLTlf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 12 Dec 2022 14:41:35 -0500
Received: from CY4PR02CU007-vft-obe.outbound.protection.outlook.com (mail-westcentralusazon11021020.outbound.protection.outlook.com [40.93.199.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E517F642A;
        Mon, 12 Dec 2022 11:41:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=epUxm+JQ3/kBhrPYPte0GQrhKBu2SelDdBSs/CEtuXVdSpcX0XM1tQzn7phpCTY4+lm0m3HtwfCYwDDAmTck9L6QWre8JXfxjCTWhCwtPejVB+ojbbyPVFE0dJLq319dk1+VU1zfKgRlvrmbR0PZkqPpfOoMD17jRrW/EDYwfVuUmFazLe5tgt6DP2JqiEZeP5vx478QjodcTfcOrVUzSM71spyIDhzhUINHZlI9/LzUUtKgovQOKsqexeoDhmbUjxPu45PK42RTmR3bKnGO4Zsqb7KejjQ74XXfmQfgx3uYHwszxbo2M5xEH78K/pEaT66OTOnlZK3Jt5WCAo0ahg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F4rl6EpjvuFVOzlpJDWQsharFzL3jV3LB1+DsB93r+8=;
 b=PFLcKXJZf1A1zu7LP2iQFfbcyDz9XNXONbn+B0dAm2nX4fHe8bQKMgwZgFdEB/5IsFSr7ppUwRIiL0K285FC4XtFGFfyO563j6td+EErnsl6cQnp6oXx1SdHJAI32mOf8QbFjECUvLXKV/RynnMXWW2lWVcDdRKpT/Tq4Afiw5CXbVuGO312iJrXW6hZFmuXGuILIR1EztcJgnmV1qmnGFSyhRxvQswzPWMAuHPv47UA7x+DkRchlHiFO1CDvoXFoCWjAdmHYz19hFhcHkj/x5k9wjpd2JoQ+0/4/RyUujhn7ESu9ZK3W0eeqnWtQw3ng0PAXgJ7wna5lN8v56fJvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F4rl6EpjvuFVOzlpJDWQsharFzL3jV3LB1+DsB93r+8=;
 b=hRKgVW+6G6cD4nXxdXCWCtamO27zVodArvftFlcttahLuf3EUyVySXqJB2pIrT1j5xV7cetmJqngjz5QPppf8Vvj8C3olRrelwhi+57In9RQ7Tl1HTJzUTqdB6/+eBO0CXVINmsipJ6PLWCtaI4rjTzmeuduypZpt4FVReXFGfw=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by DS7PR21MB3365.namprd21.prod.outlook.com (2603:10b6:8:81::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.2; Mon, 12 Dec
 2022 19:41:29 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::1e50:78ec:6954:d6dd]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::1e50:78ec:6954:d6dd%8]) with mapi id 15.20.5944.002; Mon, 12 Dec 2022
 19:41:29 +0000
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
Subject: RE: [RFC PATCH V2 04/18] x86/hyperv: Decrypt hv vp assist page in
 sev-snp enlightened guest
Thread-Topic: [RFC PATCH V2 04/18] x86/hyperv: Decrypt hv vp assist page in
 sev-snp enlightened guest
Thread-Index: AQHY+8mdW+AXk/uLVkmNd40J6d9ARq5qxxFA
Date:   Mon, 12 Dec 2022 19:41:29 +0000
Message-ID: <BYAPR21MB168851BAABC0BEA0790C5A4BD7E29@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20221119034633.1728632-1-ltykernel@gmail.com>
 <20221119034633.1728632-5-ltykernel@gmail.com>
In-Reply-To: <20221119034633.1728632-5-ltykernel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=a6585880-8f6b-482a-9694-d0e2547944a7;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-12-12T19:24:15Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|DS7PR21MB3365:EE_
x-ms-office365-filtering-correlation-id: f4f592a0-2648-4063-aa6d-08dadc78dd51
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y5ct8hRXSv4f3HCxeGMCohaQ2YC7ii9bMgFPa5Fjm86UcU25Ww6h9q6nvs99QGkh5Ni92suQb6j6x7IrRPJ7iIsG09I9xnDveWnPtTLZXvnzd28QOqPW17odoC6TvgmTAEEQe4gIVFkE8qgs1WJpH+JVBwpizFXgZ00WzefEgf6j3rQpDDWsqDYvfUDpZRUQ6mYuWdwczgNao0+RbjiZTIiARhezbPRmRbII3R8Ye5Ycp8HtBrYzv4iXtIBo7EYJrT3eZaFMgZB0gueHhz3QDeW7AbgORseKqfztxtmqlakQRHuQyr7b6OceRS7tU6zm3+R/u9SqKR82IfN/9dd31BWdyiAXfQ/HTjUXc9fegE8O9B5x1oQ2kIe9dCJjvSUAFNHfXycW2UKaNq/q5TvXIVeKTkpgAI3reMxqa2L4wSsi0M0cqRponBEkryLylKhA1jk6+Y81h++4KfaHrJrrqx+MVuaebVZgfM4zZ4gv8LlERpl0dMd5jiv+bYdYgFPsZGULMeNNHtcUw9zJ+RKMFxcS5xtfzqgIDQ3soD8SvWtjOuaO5HgWaUDigoeOTIfJPClLbsL1y7G7g42UINh6jysh18sRchfUFNu1zt8mN6PkkXpcY7DMIVjS5inYctgSzPXEVsobS2jYoia+Y8vebqX57dEgV+KY97qfXiKnajtwwPGOfFoRuKqO8rmgdS+bTgVhmmD+4Sf9J4o0ZqB3iEVFGAdWp69ONRr9hUUrp6SRHh2JPNGO4ulvv8GdFU727+AgWT2fLfDLdYiyoUmYMPxxjrU8krOTh1JO684w7wo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(136003)(366004)(396003)(39860400002)(451199015)(66946007)(66446008)(921005)(38070700005)(8676002)(4326008)(66476007)(66556008)(83380400001)(76116006)(54906003)(64756008)(71200400001)(10290500003)(316002)(110136005)(41300700001)(2906002)(122000001)(8990500004)(86362001)(38100700002)(8936002)(82960400001)(82950400001)(52536014)(7416002)(7406005)(55016003)(5660300002)(6506007)(7696005)(478600001)(966005)(9686003)(33656002)(186003)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?a6acX+2nFwGsUJAmgP/VqSVYPlvxRjh3/2jm0mvlH9g5dy6R065ZjT1tx6vj?=
 =?us-ascii?Q?w8HcJeCB49CiqSh4i26pEd5kiNPjqxHAfpp+CiCSqPujhuFdOnEK2dwK8IQo?=
 =?us-ascii?Q?oXYWBq8Qnj/BZiwHPONiJ/Z9jjZmTfLrcF1SPmUZ5tojeQ0wajPPUp34cGdu?=
 =?us-ascii?Q?e7nSRJp1JJiTghknnPz/9+/Fm4vbAoXyeW8tyMpmZEUXVVWuFuF7USpLRXBm?=
 =?us-ascii?Q?FYger1NcLgeayHpk/+8KY7/jiBitT32ujQFUjvUaeSf4W5f967ooLbNDPFf8?=
 =?us-ascii?Q?QqVimktQaa8tN+BkHiM/ibWhUhwJxUv4UKZBQqIW5E+VI+ia/K6r1f+9dpSx?=
 =?us-ascii?Q?l11ptLgpncXZJEEa7r74OwwYwxgeCdo1q+YRa/9kfWKhngbjnTDB4gZc77mM?=
 =?us-ascii?Q?XpsGZD9l3lSfDbY7wdB5cs4M9AvjJatz4WA8YxhPAPM2sS64UhyqJZxWCjQN?=
 =?us-ascii?Q?7L+EDABrZf/YUzD9KuSWyJRq1NkIaoFXJw3bRcnmvFyeLU5oSRQmaUvalxbo?=
 =?us-ascii?Q?mORD+7Ftk1QqXBFYPIet7tBCsKPV24QCKp/WqJ+LEr7zilPFyjKjeWZNeZAh?=
 =?us-ascii?Q?Tiv3j1AEFp2OEwNP/fMggTH7ViQ+qBR6i25cjC51u4kkdf6dNk9jgF7/Y0+c?=
 =?us-ascii?Q?bVhdujCcnBVLQ1P226U0vtx4nSm4BX49LNR2URXd7gFCbt7pthSa98UlNhzt?=
 =?us-ascii?Q?qAmdm86olB5/SrsHyb4d00ao7Kzf21YJGTtNf9EYdntewq7jxenAyzZ4OD+q?=
 =?us-ascii?Q?kXjIp0dYkkNeH5jvukgz7iI7Aib0fNCQr9lPGcZYgxK3V/TVLq7DtJskJN+P?=
 =?us-ascii?Q?u3HrJp9HQqIaM1IWifn5GdxJdy+qzsEg/0DNmwN82A1BkOR5qcY8MGMQ4jp0?=
 =?us-ascii?Q?Ea4a5DxHl7Bx0zb7QCtjV4NqqBNpiJgk4dCewOhmjC/pFkXWBeu+jZHM6a5z?=
 =?us-ascii?Q?in5nFpTuRG24/dcv8iDvd/AXBRoq2b6EsxSMQYevRQWhyfZUTDXere68RdSv?=
 =?us-ascii?Q?gABEEluIGQC0KaJMko1xpqdOhS0RZl8tjGAGlNlXZ3JrYl7RKEkFbfyjQPuh?=
 =?us-ascii?Q?IqTRrWs2E1GURytPHD0D75OeAm9fDN0Y1HxVyiHxKSAcbkv/aep7N4hsldba?=
 =?us-ascii?Q?jBPZNnWx1y11pUR+Wr1xOaXtIz1eUy9bT+8KWPOGlOQSgps5m3lFiNnedMQG?=
 =?us-ascii?Q?qnzypiede/FW1Ur9hQcAh2S0FMddJnrHHmz/aarKJicKNRgJh9JysQsFkBfK?=
 =?us-ascii?Q?UDkNzpuh6/2l6K4edllRpbizWB2efnTxtN6QOqvijdMhNZzcb9gmtgjmSupX?=
 =?us-ascii?Q?XA5OQYDawScFAkioQsq9sib8LY1QwJSv8Xqy2iKhuUb2nDCpXksQ5XXPjE5l?=
 =?us-ascii?Q?G8o1MrooPgfuzU2pSGalRvpftLn7hdPaxWyUkqbNCCkG0Rqz96Ll8nCS3Bss?=
 =?us-ascii?Q?mE1QuviMqsP94xtyop0EKHLzOIKKschqmrUNJ7PuQbDyXJcy3KByacwdVnJH?=
 =?us-ascii?Q?5pLiQgesYBVIa350LbAiKLblaDhcqEkuqdy1I+iphuWnMTuGOVg646VPOg1u?=
 =?us-ascii?Q?L5tBC0BwBjldMgWAhjkCeoipqXRGkxmYFShqplJNhJkh1yw/ip81rOfgff9y?=
 =?us-ascii?Q?bQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4f592a0-2648-4063-aa6d-08dadc78dd51
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2022 19:41:29.3180
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T5pGe4kxcwk9TFIqLSryl6kBNBINzLIxsaGWKTq9l4WazXqStkCUNl1iBolUk7APxtupYiq4BSQ+tKjO/Dbiov/MSYhki4QQgjdn1QCIusQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR21MB3365
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Tianyu Lan <ltykernel@gmail.com> Sent: Friday, November 18, 2022 7:46=
 PM
>=20
> hv vp assist page is shared between sev snp guest and hyperv. Decrypt
> the page when use it.
>=20
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> ---
>  arch/x86/hyperv/hv_init.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>=20
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 29774126e931..4600c5941957 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -30,6 +30,7 @@
>  #include <clocksource/hyperv_timer.h>
>  #include <linux/highmem.h>
>  #include <linux/swiotlb.h>
> +#include <linux/set_memory.h>
>=20
>  int hyperv_init_cpuhp;
>  u64 hv_current_partition_id =3D ~0ull;
> @@ -112,6 +113,11 @@ static int hv_cpu_init(unsigned int cpu)
>  		}
>  		WARN_ON(!(*hvp));
>  		if (*hvp) {
> +			if (hv_isolation_type_en_snp()) {
> +				WARN_ON_ONCE(set_memory_decrypted((unsigned long)(*hvp), 1) !=3D 0);

The "!=3D 0" isn't needed.

> +				memset(*hvp, 0, PAGE_SIZE);
> +			}
> +
>  			msr.enable =3D 1;
>  			wrmsrl(HV_X64_MSR_VP_ASSIST_PAGE, msr.as_uint64);
>  		}
> @@ -228,6 +234,12 @@ static int hv_cpu_die(unsigned int cpu)
>=20
>  	if (hv_vp_assist_page && hv_vp_assist_page[cpu]) {
>  		union hv_vp_assist_msr_contents msr =3D { 0 };
> +
> +		if (hv_isolation_type_en_snp())
> +			WARN_ON_ONCE(set_memory_encrypted(
> +				    (unsigned long)hv_vp_assist_page[cpu],
> +				    1) !=3D 0);
> +

The re-encryption should not be done here (or anywhere else, for
that matter) since the VP assist pages are never freed.   The Hyper-V
synthetic MSR pointing to the page gets cleared, but the memory isn't
freed.  If the CPU should come back online later, the previously allocated
VP assist page is reused.   The decryption in hv_cpu_init() is done only
when a new page is allocated to use as a VP assist page.  So just leave
the page decrypted here, and it will get reused in its decrypted state.

This handling of the VP assist page is admittedly a bit weird.  But
it is needed.  See discussion with Vitaly Kuznetsov here:
https://lore.kernel.org/linux-hyperv/878rkqr7ku.fsf@ovpn-192-136.brq.redhat=
.com/

Michael

>  		if (hv_root_partition) {
>  			/*
>  			 * For root partition the VP assist page is mapped to
> --
> 2.25.1

