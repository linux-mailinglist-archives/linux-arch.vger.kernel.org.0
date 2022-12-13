Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3D464BB99
	for <lists+linux-arch@lfdr.de>; Tue, 13 Dec 2022 19:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236437AbiLMSIO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Dec 2022 13:08:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236440AbiLMSIL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 13 Dec 2022 13:08:11 -0500
Received: from CO1PR02CU002-vft-obe.outbound.protection.outlook.com (mail-westus2azon11020019.outbound.protection.outlook.com [52.101.46.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF772409E;
        Tue, 13 Dec 2022 10:08:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CBzTdunr1wB6FGLVZpSG+eyQVijZb/xGK0QTamtS7Oj5KiB+K9NQOerxkQRdMN9x4VdOhARtXDTQYenhyvigAiKB9NaAmR2iWIuJi6757myjyqlWPUP+n1Us3i/JjPZ2omwWXegpe1whICKfoPpR4pisl1ylogNs9t39fSM11KdseHAbR+KS4jxw0N7CsBNdPWJjUFbvw68VVpDeYGI5k2P6jZsurLCoDI1Hly2LWJJuspU97HGBlaDiCO0f2dXhnvJBjJOWEpaqkwNvyTa7r1X/uhe6OTvgrkvn2/lKQRuogmL60OJoxcRFvL1gj2Hvk0MTHfFROSY7nDLLfI8/nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/k0sk+jUane8TxdKIK93dStS0sVP7dcfYb43PsOI6PE=;
 b=AMlgDC/Ixm0IuGwwM/COdd1pqlDe92j64b5kuIQKLy8p0WVka/N75JSdB2pY2Fd5bq85txQcteC4n3fY4IOCZ3wVYIxWhM/csHwE2NMenJXdyn+MZj9b5xW4owI4kQeGV4c41FzQ/WaOAhxFAT7R9QlDAiFYBKLo91dnJNpYLtW2uAeSZWv9gqzYTZOlcYDRWWZJsibhN7c7YUCbKENuZaX4oyr9CWHdncQ9dw6AycbmfT8G4xjGr2Brw2Sb5Z7kUz4/6UKALWMDa57ujHECw8U9LZzC80XN/8RDETNI+UpvPChMGKTGmisXCLRO5t5PSZ1sl1Vm60xxLgZh8jwd+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/k0sk+jUane8TxdKIK93dStS0sVP7dcfYb43PsOI6PE=;
 b=MvKce/ptT6g90G6cz0x4HVdib8yR+GXdFz17nCz6kbjGvXSNb9ukliaZBVHZshat34GHr2eTJAYUaFBufHAqPWnRiso80Wld1/t2Ey4lmCguFT7bBoUUHQC/8Wxw6RPmP83ZZ9SPtQmbKPsoA/L13QsoI7YP0SemJAsyfFhwugg=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by DM4PR21MB3153.namprd21.prod.outlook.com (2603:10b6:8:65::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.2; Tue, 13 Dec
 2022 18:08:07 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::1e50:78ec:6954:d6dd]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::1e50:78ec:6954:d6dd%8]) with mapi id 15.20.5944.002; Tue, 13 Dec 2022
 18:08:07 +0000
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
Subject: RE: [RFC PATCH V2 08/18] x86/hyperv: decrypt vmbus pages for sev-snp
 enlightened guest
Thread-Topic: [RFC PATCH V2 08/18] x86/hyperv: decrypt vmbus pages for sev-snp
 enlightened guest
Thread-Index: AQHY+8nnT0vZkQ8ItEWjPAL2ci+60K5sPHLw
Date:   Tue, 13 Dec 2022 18:08:07 +0000
Message-ID: <BYAPR21MB168838758CAA630B55E73DB2D7E39@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20221119034633.1728632-1-ltykernel@gmail.com>
 <20221119034633.1728632-9-ltykernel@gmail.com>
In-Reply-To: <20221119034633.1728632-9-ltykernel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=e16f318b-cc8b-4799-af70-c1d7cc3288cc;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-12-13T17:40:37Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|DM4PR21MB3153:EE_
x-ms-office365-filtering-correlation-id: b44efb54-80f7-4fce-b6ce-08dadd34fcb0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UJ+F8Mielwv5w6vT0HFYXuMsNZOYfj3ewJy6h2UA32xmrX/Beo/0tYS1vuo+Uz6vxRqfJ8z3uLlMQJ3XKPTE3DAvUnxBakSdqD8X6V8bvgUamzjYMqkHl5L2KlhS4EWMdXei8rO2hOYkBtNEPHLsfxFy1tomUUz/RUSTF/KZ8PlmB4+VmC0m9ssVDgHwO5XBo5dk09lmg3wJz1VzsGN3U4CQxhVO5nkOLAhlGfGPeehcSuVgOKdkGxpu+UyuqyEvWLjJt7FcqsYYCv1/SjSW/+6LFOD68x8/FcbG2sOS66sBjMgXzH0D28+z6Uebw28ZRGpHDv/AnJ7wyr3xZjmxK9ia/SrQoKvq2V7BrG9Ag/m/0Unt5LCM0LsRMUlR1VtMZGnDEwWfwW9ltMmtpx6mm/fyh1ymd1W0M/mha3+lOCNirMCWpl8/90dPbEBjWV1sxx4Y0fy7PKKyk3AIuQz/Rn4E6vSeHEKJ8q1E10nta2HDKl/7fv6G3OeIebCNx86mspung/MaPhmuM6P7slAs+0glR0eGp7yhnKNeTwazshUhSI97sDptoWxhtgYYMXMjjN/x5sYkqRTY8CDEivP+/6G24h1DP7bhQyyXvICOa8yjqBoxl3tir9HKyURusWjXnvYrrr+QHhbHoXQqwJbO+NFpzhRs0Yof3BMIMXOvokfHvK+DQOBw99noS1eSTjsGqgPiLbjBFMwv0nq7YYa/1qyOaelSaO/wI4UXRfKRs7Xnze8WRhkV0sFf4DBzmVBGEDMgUzrci9fAeQR5wzH6EQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(136003)(366004)(346002)(396003)(451199015)(186003)(33656002)(86362001)(478600001)(110136005)(10290500003)(54906003)(316002)(921005)(38070700005)(55016003)(82960400001)(82950400001)(83380400001)(122000001)(38100700002)(9686003)(26005)(7696005)(6506007)(7406005)(7416002)(8990500004)(2906002)(71200400001)(52536014)(8676002)(41300700001)(66446008)(8936002)(4326008)(64756008)(5660300002)(76116006)(66946007)(66476007)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Q0xrslXeLuXQEcreNllCyVTP0AjOmIZ9D9ohyjoXGBcOOmzrtTB+yc9oAWeZ?=
 =?us-ascii?Q?FCq31TlAaWtgU2QyHYke49n+xyvBekowZnOis0m5I6CmZCMvjtGhLA3M+YMh?=
 =?us-ascii?Q?YfMhMuyIIatPhC+M38KjObhGxdyYin4J5W8FMAeOQiBraGToMhdoe1awxmf1?=
 =?us-ascii?Q?z1Rd5VlrmAs85gJsEEeVucsAP9NpUmJMSiIonxBhL5iuLE9LneaOQLH4q7Ge?=
 =?us-ascii?Q?JtHbbAnLLFA8QWq9Kdr91tGkOjgqSC1h15z21qAKLKYttHYeLKzXhUx0sr8y?=
 =?us-ascii?Q?DAi5VnUj4PIy18L/YdsxR1viEYg7gDdT2Q58lbKGZtu4lH3RElKpPHG0nD4z?=
 =?us-ascii?Q?td1C2IqxSzQrMTGMSnuZqe9Q9YTDXln45YRM7Ot25hC1WgpWkiIN3RZj3FEW?=
 =?us-ascii?Q?k1CCcOFfvoXLu0Ke7DGpw3MMGjmH2auy+7W9qWBm2Udf8JqeDQWjHEyLrz0Y?=
 =?us-ascii?Q?RYb0IHulPrimWxCKzHt1mB8G8qFpBNR+VMyFETKkqwRIOusPI3c/Ls11A5pU?=
 =?us-ascii?Q?NiDI/oDkh36g8WWqCJADiBQk9P+M5z6ZTf6Bn5EDuHtSqf+GcK3yV7UNgTBg?=
 =?us-ascii?Q?f6/Ibh07vJJzH0FqMxa5ajyheqbNnb3d12m8RqSYeZ3WDCBi0L78KHbTrPDB?=
 =?us-ascii?Q?CJRX9Qe1TeRyu02CRursVKtdiYCnw1PxC8R43Vud3QNeDUMRQSvmhbtgyL46?=
 =?us-ascii?Q?vz9YdzAK5msYCNE83lrOD5QEk4rtXAzGn0QSPZYK4MQRnPuDbMe/Vm123Llo?=
 =?us-ascii?Q?TBFf53RbCQTS8KpGuF/+Mv1i2HIaL7gjQ+Gkz69uIQYB7hYkP8QSQIpUBuxl?=
 =?us-ascii?Q?bkshlENmIL8UzFRP2L4NKPylnjHYfRxUYrIOVjnPfsH6/etRFuWUJ3nrCsgk?=
 =?us-ascii?Q?UO+FUjqdK4llTxZTZkeQTz3a9I4PFJ8Otoe3OkC/o07EpgSHvuwZwGKGhR0W?=
 =?us-ascii?Q?FHTZB+L1z4HY1SXsXYqskRzJYes7Qs9bc/7vwvZOdlB+creBNZvbfFFfTUJ/?=
 =?us-ascii?Q?yvKBqmJkQcwMSLGns6ByorUgDkHg/xdWZTqQLuj/xTl+M3BqtJmoJUw/sDcW?=
 =?us-ascii?Q?qi77UYADjg5Di08Y18r2/sBlUJqRtFeu0EHRBMokme6IahH/8E9UQOK2VVMg?=
 =?us-ascii?Q?zXvvlvPKYDsyFh5NsSKzqa2UWDZa6Kyg5nRrrhD9WgkYHt9hfvnhOdbSUsLD?=
 =?us-ascii?Q?UA7iOptdC4A1Xor+9nCvAOhvXJ5yKfTzXkfn0iuZHxQ0QHreDaDN6LIzCytR?=
 =?us-ascii?Q?jEKaHbGf0wMv5xWMkn+apmPvmgK0E8O9I2rhJ94E8zaaznE0GP+Y8aRx+nz1?=
 =?us-ascii?Q?iqieeqlX1UZrHDqrY6xKKmKQR+wOtYMwxfuFibDz9xZxUow1REGvhyEr8Rgt?=
 =?us-ascii?Q?O23CFZZIbRfVfVjIKAEWK+xdnSej8c3Oh1Aq5t217V48re2RvkE/STM3uHv8?=
 =?us-ascii?Q?By423RDIU7YT+b3W4ZF/wcerUMhFho9qQRug8GHNxoI9E+AWMnveQWhMOPZU?=
 =?us-ascii?Q?5m+GmEGx13c/qOpmbkoT/2ozjBLBBS/g7uyecIwg33hZyZ+TQMfFh9sfYwSF?=
 =?us-ascii?Q?Syjdin07oxv0fLpXLxjz5h3XFFP3jen/5ENeD1YiH8CHwxNOyRRSUApVD4KQ?=
 =?us-ascii?Q?tA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b44efb54-80f7-4fce-b6ce-08dadd34fcb0
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2022 18:08:07.3355
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qjH0r0qVkFJT5/hoBDR6D2VnSBLgmLjhMB7CeZq9jev+05uLakfyP0oJKULYeKf7ZY43Qs9NuxJaYW/j6dsL3TPdGKYSdZl61C/mqmzbymE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR21MB3153
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

The Subject prefix for this patch should be "Drivers: hv: vmbus:"

> Vmbus int, synic and post message pages are shared with hypervisor
> and so decrypt these pages in the sev-snp guest.
>=20
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> ---
>  drivers/hv/connection.c | 13 +++++++++++++
>  drivers/hv/hv.c         | 32 +++++++++++++++++++++++++++++++-
>  2 files changed, 44 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
> index 9dc27e5d367a..43141225ea15 100644
> --- a/drivers/hv/connection.c
> +++ b/drivers/hv/connection.c
> @@ -215,6 +215,15 @@ int vmbus_connect(void)
>  		(void *)((unsigned long)vmbus_connection.int_page +
>  			(HV_HYP_PAGE_SIZE >> 1));
>=20
> +	if (hv_isolation_type_snp() || hv_isolation_type_en_snp()) {

This decryption should be done only for a fully enlightened SEV-SNP
guest, not for a vTOM guest.

> +		ret =3D set_memory_decrypted((unsigned long)
> +				vmbus_connection.int_page, 1);
> +		if (ret)
> +			goto cleanup;

This cleanup path doesn't work correctly.  It calls
vmbus_disconnect(), which will try to re-encrypt the memory.
But if the original decryption failed, re-encrypting is the wrong
thing to do.

It looks like this same bug exists in current code if the decryption
of the monitor pages fails or if just one of the original memory
allocations fails.  vmbus_disconnect() doesn't know whether it
should re-encrypt the pages.

> +
> +		memset(vmbus_connection.int_page, 0, PAGE_SIZE);
> +	}
> +
>  	/*
>  	 * Setup the monitor notification facility. The 1st page for
>  	 * parent->child and the 2nd page for child->parent
> @@ -372,6 +381,10 @@ void vmbus_disconnect(void)
>  		destroy_workqueue(vmbus_connection.work_queue);
>=20
>  	if (vmbus_connection.int_page) {
> +		if (hv_isolation_type_en_snp())
> +			set_memory_encrypted((unsigned long)
> +				vmbus_connection.int_page, 1);
> +
>  		hv_free_hyperv_page((unsigned long)vmbus_connection.int_page);
>  		vmbus_connection.int_page =3D NULL;
>  	}
> diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
> index 4d6480d57546..f9111eb32739 100644
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
> @@ -168,6 +169,29 @@ int hv_synic_alloc(void)
>  			pr_err("Unable to allocate post msg page\n");
>  			goto err;
>  		}
> +
> +		if (hv_isolation_type_en_snp()) {
> +			ret =3D set_memory_decrypted((unsigned long)
> +				hv_cpu->synic_message_page, 1);
> +			ret |=3D set_memory_decrypted((unsigned long)
> +				hv_cpu->synic_event_page, 1);
> +			ret |=3D set_memory_decrypted((unsigned long)
> +				hv_cpu->post_msg_page, 1);
> +
> +			if (ret) {
> +				set_memory_encrypted((unsigned long)
> +					hv_cpu->synic_message_page, 1);
> +				set_memory_encrypted((unsigned long)
> +					hv_cpu->synic_event_page, 1);
> +				set_memory_encrypted((unsigned long)
> +					hv_cpu->post_msg_page, 1);
> +				goto err;

Same kind of cleanup problem here.  Some of the memory may have
been decrypted, but some may not have.  Re-encrypting all three pages
risks re-encrypting a page that failed to be decrypted, and that might
cause problems.

> +			}
> +
> +			memset(hv_cpu->synic_message_page, 0, PAGE_SIZE);
> +			memset(hv_cpu->synic_event_page, 0, PAGE_SIZE);
> +			memset(hv_cpu->post_msg_page, 0, PAGE_SIZE);
> +		}
>  	}
>=20
>  	return 0;
> @@ -188,6 +212,12 @@ void hv_synic_free(void)
>  		struct hv_per_cpu_context *hv_cpu
>  			=3D per_cpu_ptr(hv_context.cpu_context, cpu);
>=20
> +		if (hv_isolation_type_en_snp()) {
> +			set_memory_encrypted((unsigned long)hv_cpu->synic_message_page, 1);
> +			set_memory_encrypted((unsigned long)hv_cpu->synic_event_page, 1);
> +			set_memory_encrypted((unsigned long)hv_cpu->post_msg_page, 1);

This cleanup doesn't always work correctly.  There are multiple memory
allocations in hv_synic_alloc().  If some succeeded, but some failed, then
might get here with some memory that was allocated but not decrypted.
Trying to re-encrypt that memory before freeing it could cause problems.

> +		}
> +
>  		free_page((unsigned long)hv_cpu->synic_event_page);
>  		free_page((unsigned long)hv_cpu->synic_message_page);
>  		free_page((unsigned long)hv_cpu->post_msg_page);
> --
> 2.25.1

