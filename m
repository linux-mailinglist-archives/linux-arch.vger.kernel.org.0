Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D35236DF88A
	for <lists+linux-arch@lfdr.de>; Wed, 12 Apr 2023 16:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbjDLOcZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 Apr 2023 10:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbjDLOcY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Apr 2023 10:32:24 -0400
Received: from DM5PR00CU002.outbound.protection.outlook.com (mail-centralusazon11021021.outbound.protection.outlook.com [52.101.62.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 692D810C0;
        Wed, 12 Apr 2023 07:32:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MvIG6ItK3xbl+eFMJhk8pUEdl4xC8gxhjPAhSMke7PzrlWelulI8LLAv/4bInQPkjwnsXLY04Cm+eeCzglhHf3QUArn+8voi2e6Bz/TjRjg2QtehBtQAV8Nh63ADSJVuUQJS3rnSz4zcW9DVtL1hc6eBkpyftVNUAv3ybeIp4XAtnP4ftxFccHgQGg053rVrc7mgqG4HsQE0biyIPO+y2Fwr006kdSNYFpoixqMPlS7cvliDDl14VOz6Qr8G0XZ2RTZXkAqZMlw9ILYQ/x0EHmteBxRGqDAwYMvD2f4Cl1Ptx6HC9aOD66yiYbSjLSgmdo0EEVfa5cJM6NjgYmzcXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=82J2yBwDtd+iYQ+ywXRpFlgELpnhOVK8KiJKapbXo9w=;
 b=MoAoLripP9/fHMAFGvW1rz1ulLlz1HdZY2BhX4p8l0DffMOt1d8mtDVO5og/yQ+Clv2cob5wSfD+hmAKeWovERnPKKinrH0jjv9go9yODFDFwCsefXL7PPpot4BlFv4l1xT4MpfiTaXtIuRQihUxJIYh2AYiDgsgk6SO3pRGUQZaE8hDfh9DNyY+5/4Y+owQTkGhCtEPEWDxJq2p2+Asffc91yZhm6xLL7aOQD05alh0q9ult1zd0zKbMGG/1DNNsyn5Hvxcho2aAz9sFdIcemR4PWsM/8x0v7+Ykc6oT+Bx5nU8wsDFguA0NN1tcTUTkrxqL3v5PMr96y1InotJ+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=82J2yBwDtd+iYQ+ywXRpFlgELpnhOVK8KiJKapbXo9w=;
 b=Sf2Nz12N8KOhUSDq6m1+v6sFlwsUIcNzguAt97toneeNizMyjZvCM790VOTmOTrELxkUlymAy/lGwSPcxR8I7vG4jEXEiHRvTM+x5453tfHbmzZHt8xCtGCAY3LMscjqp9qDeUPiuWJStRTyM+AEcrAaxZNscrdZgQg9IZ9GqZw=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by DM4PR21MB3584.namprd21.prod.outlook.com (2603:10b6:8:a4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.3; Wed, 12 Apr
 2023 14:32:19 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::acd0:6aec:7be2:719c]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::acd0:6aec:7be2:719c%7]) with mapi id 15.20.6319.004; Wed, 12 Apr 2023
 14:32:19 +0000
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
Subject: RE: [RFC PATCH V4 06/17] x86/hyperv: decrypt VMBus pages for sev-snp
 enlightened guest
Thread-Topic: [RFC PATCH V4 06/17] x86/hyperv: decrypt VMBus pages for sev-snp
 enlightened guest
Thread-Index: AQHZZlP4KhAtAWHoZ0CkaGoCwKH4eq8nyLrA
Date:   Wed, 12 Apr 2023 14:32:18 +0000
Message-ID: <BYAPR21MB16882B5A167C985B516B6E5FD79B9@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230403174406.4180472-1-ltykernel@gmail.com>
 <20230403174406.4180472-7-ltykernel@gmail.com>
In-Reply-To: <20230403174406.4180472-7-ltykernel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=659b0fb6-da3b-4d19-9530-638611e9ba06;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-04-12T14:25:55Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|DM4PR21MB3584:EE_
x-ms-office365-filtering-correlation-id: 0bd57b9c-1d9d-4e3d-f276-08db3b62b86e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LnLlxwGGKRPsURK/EKv3n34cPO5pbGuaVtfC4E5n7cIPMHvjdeNEpcIz0o6akwNosi5KZthxmVHtuxhwacbIAymJFjrgJ0Vc9Gs0FVb/92x3WjcsFx9G0Di0i4aKeWDz0QbwKT2C+g/USgy+7Jzc6/+1+/P9rQT6Qg+5z4OqyGC4igO7T+4o0UoKbalIUFYSyiAgWKRf+3ed2knk7uNrWWldMF7G+j6Z5HHbMEGa89tpJfLRrsg7GqMWs419aq3UXW+VSa7gPfJ4XH3jmjaGhEbo9GSt9kj1PVP5bPI6qrJqu/mQpY1QUyoEhCYtim7fPpco3FnNvCXK7GX2p1qReA5lgrpBHikg3jaNOWRQedJMsYfcvKFoKh1bSjU6yEz1d+2NQ9m0SJrrO4sZFyvNefsGCRLQFpwvxffDcPzRr4canKy5HY2b3CrALyJw8z04XH+NGjHab3Rz038qVSspJi474cR4Lx8fE3aq6VWeRFqWGOX59PVkZBJ1aundvBVuI9HoL1LVP2ty5cYzRVcE83Nf+3kRJM/wZ/MCsAXhHOR4+QOal1omuiWykdxcZVhHjehWRzH2i19zcrhGPiNNq7DWkhTvJHU77Ovaj1sooMjPS6Y9zeWkt8KUgIphWAT3uH4+FGH5AVtPCOLHlUS/o1jynndeJ0o6MBqJoOuBW5t0To9xhCe+4sH5+zn+a22Q
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:cs;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(376002)(396003)(346002)(39860400002)(451199021)(10290500003)(54906003)(786003)(316002)(110136005)(478600001)(83380400001)(186003)(33656002)(55016003)(26005)(6506007)(9686003)(122000001)(38100700002)(921005)(38070700005)(86362001)(82950400001)(82960400001)(71200400001)(7696005)(8990500004)(41300700001)(64756008)(76116006)(66476007)(66556008)(4326008)(8676002)(66446008)(66946007)(5660300002)(7406005)(7416002)(2906002)(8936002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BU61NWykFoP+fatcF2oAH63XjNSHEjub6j4uliA7k5lsbwBAhDex84JQ3QAz?=
 =?us-ascii?Q?qHb1bTpn8kYrdJV8iVOMbd8Yc4xRMdWn6gDiTytIPVHmwqIxIFrYeXYW5x0M?=
 =?us-ascii?Q?xlo1hwzOHQdf5FiBjgWhNTGJ9iNRZUrA3vYbQ5iQCSEO8OITDCwQkrZgoYLQ?=
 =?us-ascii?Q?7r4bBF0dXL05XMEuTMoWddnsaBW2yLx+KZ4plzPtXeLf6XSRqGwFSpCrdZbZ?=
 =?us-ascii?Q?n234VjrrXyA+rdqsPtvCUoz5G4YS2mmXtFLxPK8rlK9kQoEwyf9EZ46WgimR?=
 =?us-ascii?Q?+zvVW3ywPWomzlNm8hzHBy392pT90amiYFf7IdXc75qdGQnE2lTa8BvmFUSq?=
 =?us-ascii?Q?56E2IcPXn9Wx1UhpJSQOx//IypuLPo/250vnLjeRWGfUZ7yMaecEoZSLxUs0?=
 =?us-ascii?Q?HSX5s8babJwEfqKYl/9cwRR7n6AHOXozImYRj7kRu40lMgVGmUtsNyamQPKs?=
 =?us-ascii?Q?VCZ+bP00zZdaeqBRnNLhlZaIogM7pOcPcaHXacCWIuvW50CuOKY6pmYFviQL?=
 =?us-ascii?Q?uKOtyNb6oMq2SUaS311dCN2676txmrqpnbbxSjIrpvylruggD4E6IA7tg0rC?=
 =?us-ascii?Q?sMnSUzBrpplpEyLJp50/y+IU55xdM03V0Xh+sD2hbvYgUc0PaM8Lfe0ezjoz?=
 =?us-ascii?Q?xbbJQACrHDBg0foOQY9zPDSq1bw5DYAZqMrWAuouoVTKLn9Vjv2du9yMfHh8?=
 =?us-ascii?Q?0/DBP9WbLDJbjORliOAir3VvEXgS7FMwlfeKJu2I2+JnBQ2EPnqDEwB3jMOL?=
 =?us-ascii?Q?plTtRAx68+SLZNwFAXnvK7h4/xrrCBaZyDkT+4U+aoRYoW+2YmZ37Zp+wDKI?=
 =?us-ascii?Q?yz1rvPhPUuibQHszTT5NY4+d/i7EKdlFNccHyjzOecrMQWN4EOPlVuijL1iC?=
 =?us-ascii?Q?z5cHEJHDsHQoe5Hp0xCbGJJ7u0yfgBX8kQ5DOIMcdJ7YCrICv2aBEHE+kpWC?=
 =?us-ascii?Q?yYQx0gO+DsQ34RwAHROeXo9DecVnQpBWehgPycIoSD/nCPMY7LS0r2o7NQES?=
 =?us-ascii?Q?2y35kZQFXNdDARsbo5Z7GoJTdsRj/IRQOb9xin68QJ5c0fnW1M67rCw2N4D7?=
 =?us-ascii?Q?X03bD8+qSmDqUHtou7ZhACDvhFvX2Z/5iqjw5lemOeqViGOqK9zoANoawnYN?=
 =?us-ascii?Q?aBwIEWcCzpO2V37UFSL4LW+a9Ldq0+Vx9tWYa0Lo5FH+1TYxRUXIoVicWYwA?=
 =?us-ascii?Q?KFDvscD982wRLh9IXNHhmB9KjttzIXYG1oaGZnUHKJdbZbHWBuXwMEtJJE7v?=
 =?us-ascii?Q?2XH2ZlHkzH6dt0RkgOC6+o+1yaJKyATusGZmt4RVOOIsQMvEmZABo5zUlcC5?=
 =?us-ascii?Q?ddFFvYBL7hlo4QnMJD0ux5T3kU32W1yNLkhMxw2enw+wDxmzsgQ/kEWsNNzx?=
 =?us-ascii?Q?NUMTtbxE3i+DpuMh3qwXv68o2NF4MDr3jL7qNoyicogpdRUwBMHcTaCbrh8q?=
 =?us-ascii?Q?YmdEutB3E95Ylh98HQ1BfVXloQf2/oGSbYMuK/8iEZJouXwrAY6mKyrZBX38?=
 =?us-ascii?Q?BwpwQWiOgirICSfrW0QGZiXWGtakwY5Ppn9ExZKQsUlbaLfl2TPKuXhDDMSs?=
 =?us-ascii?Q?i+jYk6wuWXNDLIH1ydh+jqDWVqe0oD8G0itJWVUA6ATm4bEc73BO06LgiPb1?=
 =?us-ascii?Q?nA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bd57b9c-1d9d-4e3d-f276-08db3b62b86e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2023 14:32:19.0039
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VWniapfn0FWUu6+0k0kiNe7aPI2yEhk1at4R5JS2t5NFw9u4pjaqwotkrqlch5yqp9KmL9PurUEeH5+vjYsREECsXvQtLAouNa7jKDVoKCo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR21MB3584
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Tianyu Lan <ltykernel@gmail.com> Sent: Monday, April 3, 2023 10:44 AM
>=20

The Subject prefix for this patch is still wrong.  I previously commented o=
n
this. :-(   It should be Drivers: hv: vmbus:=20


> VMBus post msg, synic event and message pages are shared
> with hypervisor and so decrypt these pages in the sev-snp guest.
>=20
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> ---
> Change since RFC V3:
>        * Set encrypt page back in the hv_synic_free()
>=20
> Change since RFC V2:
>        * Fix error in the error code path and encrypt
>        	 pages correctly when decryption failure happens.
> ---
>  drivers/hv/hv.c | 42 +++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 41 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
> index 008234894d28..e09cea8f2f04 100644
> --- a/drivers/hv/hv.c
> +++ b/drivers/hv/hv.c
> @@ -20,6 +20,7 @@
>  #include <linux/interrupt.h>
>  #include <clocksource/hyperv_timer.h>
>  #include <asm/mshyperv.h>
> +#include <linux/set_memory.h>
>  #include "hyperv_vmbus.h"
>=20
>  /* The one and only */
> @@ -117,7 +118,7 @@ int hv_post_message(union hv_connection_id connection=
_id,
>=20
>  int hv_synic_alloc(void)
>  {
> -	int cpu;
> +	int cpu, ret;
>  	struct hv_per_cpu_context *hv_cpu;
>=20
>  	/*
> @@ -168,9 +169,39 @@ int hv_synic_alloc(void)
>  			pr_err("Unable to allocate post msg page\n");
>  			goto err;
>  		}
> +
> +		if (hv_isolation_type_en_snp()) {
> +			ret =3D set_memory_decrypted((unsigned long)
> +				hv_cpu->synic_message_page, 1);
> +			if (ret)
> +				goto err;
> +
> +			ret =3D set_memory_decrypted((unsigned long)
> +				hv_cpu->synic_event_page, 1);
> +			if (ret)
> +				goto err_decrypt_event_page;
> +
> +			ret =3D set_memory_decrypted((unsigned long)
> +				hv_cpu->post_msg_page, 1);
> +			if (ret)
> +				goto err_decrypt_msg_page;
> +
> +			memset(hv_cpu->synic_message_page, 0, PAGE_SIZE);
> +			memset(hv_cpu->synic_event_page, 0, PAGE_SIZE);
> +			memset(hv_cpu->post_msg_page, 0, PAGE_SIZE);
> +		}
>  	}
>=20
>  	return 0;
> +
> +err_decrypt_msg_page:
> +	set_memory_encrypted((unsigned long)
> +		hv_cpu->synic_event_page, 1);
> +
> +err_decrypt_event_page:
> +	set_memory_encrypted((unsigned long)
> +		hv_cpu->synic_message_page, 1);
> +
>  err:
>  	/*
>  	 * Any memory allocations that succeeded will be freed when
> @@ -191,6 +222,15 @@ void hv_synic_free(void)
>  		free_page((unsigned long)hv_cpu->synic_event_page);
>  		free_page((unsigned long)hv_cpu->synic_message_page);
>  		free_page((unsigned long)hv_cpu->post_msg_page);
> +
> +		if (hv_isolation_type_en_snp()) {
> +			set_memory_encrypted((unsigned long)
> +				hv_cpu->synic_message_page, 1);
> +			set_memory_encrypted((unsigned long)
> +				hv_cpu->synic_event_page, 1);
> +			set_memory_encrypted((unsigned long)
> +				hv_cpu->post_msg_page, 1);
> +		}

The re-encryption must be done *before* pages are freed!

Furthermore, if the re-encryption fails, we should not free
the page as it would pollute the free memory pool.  The best
we can do is leak the memory.  See Patch 5 in Dexuan's
TDX series, which does the same thing (but still doesn't
get it quite right, per my comments).

Michael

>  	}
>=20
>  	kfree(hv_context.hv_numa_map);
> --
> 2.25.1

