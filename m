Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8480264CF5F
	for <lists+linux-arch@lfdr.de>; Wed, 14 Dec 2022 19:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237048AbiLNS0G (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 14 Dec 2022 13:26:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbiLNS0C (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 14 Dec 2022 13:26:02 -0500
Received: from CY4PR02CU008-vft-obe.outbound.protection.outlook.com (mail-westcentralusazon11022019.outbound.protection.outlook.com [40.93.200.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE37D6452;
        Wed, 14 Dec 2022 10:25:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZdWg1f8BWey99IxdukqFwW019MRgpBSAzrueh6qYP2WeLPeSglM3OsUvzl5nhz4TDOotYnAyfkwkunS2vLLeDJj17bVmZG2M1b3ef40pZHJ0aFPSsPO4aZUc0WyQpZKGq1AI+9OFNpKx74hRM2IIx2h9eO+VMYMCel34bRtyecLtf+Bezekq56qcOPWlGdgJOFbAVn4KCT53J04qsZfbUehOiwU8S7FPtNelR5yfueMJ5Y+JwjuKjvi9s6XUwU8n0W+Y4ICYWaMLlco3UJ/itg9BjXv4VsHQuEW/ZrXLTG2hb29TdaBkyUfsRdp9VbKeyNaOXnDyb1JXmHq8TBLqpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7fk0EgCQUxlr62vnjETjL575ycCcNuSWtDNp5VgNTcM=;
 b=KbRNDL8SNLEwdaGmPf4ZcL+q2UGK4kUMTS/hg8SvpMxHAwZtjuObEeJ1QshcKo4Iw+xtVDtZ14I43euNo91kYAhOI0dc128OtWhl7t5YYlFrc0oGMg8kB72TziKZWpBz5beVncAVsC+AbwYvJI8dsGCIEp8hu1QhyeR3IFPbpuxeXZGYfaMluizSXtM4E3pOMkd0792IVXUty5uF7ZWLkJUBmkQQq5w+ZCWNanQFsx+mOX8Vp/VDAKLS6v2wYhkHuNY0iiospQ7BtyLdbHGoaO1oaeIzXBE3F9IHyC9SGtYkH1YtHNdCF7LB+6a/tgncuYNg6C/WwC3SNHQ6bvDqAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7fk0EgCQUxlr62vnjETjL575ycCcNuSWtDNp5VgNTcM=;
 b=evXy0d8cwamCgmwsD/xu33bEhcuLAWqDbOprcybe8m/+LUlvPt4cE9a0zcJRRgRe+r6RZxezeKsCaJDMjeKqzjF7F8am5ndTq1TEy25Go7JPrM9RomhI2/p7mMC1rL/rtRFe1KHIop/UHeNuxHGzOjsbEvNeqgKQpYemwwYGEMU=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by DM4PR21MB3106.namprd21.prod.outlook.com (2603:10b6:8:62::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.2; Wed, 14 Dec
 2022 18:25:51 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::1e50:78ec:6954:d6dd]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::1e50:78ec:6954:d6dd%8]) with mapi id 15.20.5944.002; Wed, 14 Dec 2022
 18:25:51 +0000
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
Subject: RE: [RFC PATCH V2 11/18] Drivers: hv: vmbus: Decrypt vmbus ring
 buffer
Thread-Topic: [RFC PATCH V2 11/18] Drivers: hv: vmbus: Decrypt vmbus ring
 buffer
Thread-Index: AQHY+8nks7byEPp9Pki0iDJ5fPY3nK5t2S1A
Date:   Wed, 14 Dec 2022 18:25:51 +0000
Message-ID: <BYAPR21MB1688329AFB42391E92051E9CD7E09@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20221119034633.1728632-1-ltykernel@gmail.com>
 <20221119034633.1728632-12-ltykernel@gmail.com>
In-Reply-To: <20221119034633.1728632-12-ltykernel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=e667620e-166b-4d21-946a-1aa91b931bc3;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-12-14T18:17:51Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|DM4PR21MB3106:EE_
x-ms-office365-filtering-correlation-id: 09e6244b-003f-4d59-73a8-08dade00a156
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0tVlSxmid9YU5t/o0r3HNAhSh56wfWdfaxbHKnuGl+DPZBD33t49AAtzFAM350q+NyJ5Ed9o8RYdwg8GAnB4Td2FLJbPurNxNv7M/MB1xPnP5Lymgn+t7DrjTuMzXkeSfLVoJmFajE2wrmBvzJ0zGnPpuxvLCp9YsYFWEFHVVoTzjKK/bi5X8bdYaOtU0yFjKn4vEhx1VzfeE+wzH9cPA8V00GrZbMiensZge7lYuZkKdb4IunxcmhShgFd/vmrw7cKwS03eY63aSqLS60FbUvjcpRERYseqCWGBbTHlkfMAEzzrm1va/Q/KuqTgL3Qg7HIyncPUENZ+qmg+ucmGmSupM9pxHRV/+bc8mKuliRxneBxDHA6zsqQv9z/a7p4yzsPrDHGvEdb+wgRZBogkKxqLXqOkSyLF/zUO5M4qrXiYyiKmVqAko7jcRSYKeV4tGHC+t9kRvShernn3GjQ+uTnhtUsJZGEYGz0O01Nkm53RFpMIxtCbW7fkFFKM0GatKLapJTh+tKcwsy3Tbp21MuJ1HcL3PiPfPDGtgdaydHk6HIJdiohuHRV4LxQtK4ejL09ntRWbm3NiZ/AYIYtu8++010InY3ELOSiXJ1gW967JP4v/kJ6FW7L793jP4y/hDPO6DF6Gx9RbURq7z8eFLHO/PzvTlwg0p5aNWL9l9R+dqGk4QZdoqocr/UtJJHE7BLx1UY0vpbBTSDO49h6ytY2E/nPzcbZWD8nJ9sgIXll0mFZfRLj5savx7MVCA579dXwJOUHjqhL1jdtJrVA/jA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(366004)(346002)(136003)(376002)(451199015)(33656002)(8936002)(64756008)(7406005)(7416002)(5660300002)(52536014)(41300700001)(2906002)(8990500004)(55016003)(38070700005)(478600001)(6506007)(66476007)(26005)(7696005)(82950400001)(9686003)(921005)(186003)(82960400001)(83380400001)(86362001)(122000001)(76116006)(66946007)(316002)(10290500003)(4326008)(8676002)(71200400001)(54906003)(110136005)(66446008)(38100700002)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zl1p/296A95Hopnhpz+gRiKyPgRDdFZrqmS9HS1HSd1lgsZLe2Mu0VH+F4yY?=
 =?us-ascii?Q?9KMCB6y0UGlAJyK5C1+Rl9oHCmyMFhricIa2yUSoqq3dBoiJuCgSPFEeHJ47?=
 =?us-ascii?Q?GowfxtCzxk8GMV2YacMwQX9rqLRVaM8atn1xRlgJHbsy6pmlKszvtfpP4IuI?=
 =?us-ascii?Q?Q3M+PKdsaAS+P3hOANojTSS3qmLm8xidy94pWOsT98502II6Knu9uBs2+tuB?=
 =?us-ascii?Q?JjlZe9cb+hLQHFLHszYk9cK24Nu+TXhqy799L1UVvWrOsEI2jtZpvrC9eRJL?=
 =?us-ascii?Q?/MQqAvhqEOVhUv80EPy11d/bIvoan3OKnmoxeycBt4jDgGAx/GAtOypQweEy?=
 =?us-ascii?Q?8dCrqWP4xzDof0U/HTObP7WUFnrXd2NsJnTIHcQVkcP7WmgEFyal2tzK2Wlo?=
 =?us-ascii?Q?5LGtfOjf0fnkFyS4zcgX5Znmdf5FjjH/LORj82zw7fvqDAN5Xjc0Z8U/JAqv?=
 =?us-ascii?Q?7B6t+4+sPGm/FcUNa8JFhPgmeFKr9kRS22QxJoHn6+/buzVCJumHJWJ/z3LT?=
 =?us-ascii?Q?a80aGKRKUUR/nccFC67sb0DJCkIXdVfYhW61CwffLhCOjQLcdgMPzmkC4L15?=
 =?us-ascii?Q?BxcV4GCKgAhkOfQeIppO/XxGo1xlkOm/xhvhHjiaGnxstWKnv71FcKEF14eY?=
 =?us-ascii?Q?4gqmMjKZIEnVHpVY1k9xl+A1DvUPHD80IxcJaz/TzpEbKdCCmIjNXYBneQhL?=
 =?us-ascii?Q?ZocbFlW0Qejz6g2bsT2vwCfx21z44+B7st2aTY2yGk/a1gt1ch5nMKdxiZt7?=
 =?us-ascii?Q?ovnEZjvM09qsrQGiUdzTt4FkCnlEF9aM87TxrS4Tn972b1L907ks9MyrsvuW?=
 =?us-ascii?Q?lU/oLhzdIzkHoXzJmNoCU6M9unmn/zmAvYysHyUsH5rIo6VK3V22TmheXjF7?=
 =?us-ascii?Q?/nN0EPaLKXGIORzNdlwK3QCbg5GDdMTUx5+5sY9gOWPje4pDLIcr5lBTtoCE?=
 =?us-ascii?Q?qm47rrZhoEZ9jp3EsXZ4LZQsOhfFz7PXkdAaiqRHG/5AzoXaHb1hEZ1ompsQ?=
 =?us-ascii?Q?rVf1GyYx950EQ0iIRzeCsKn0KyTEGqWHR/02TrkT9rRhHzegNbycZPXEwSLJ?=
 =?us-ascii?Q?Baf+sEe+yWlgdl1WL/XJhtJ2jyJHDkeV32JaPYgjEr1osK2nsVGqDnfAcfEF?=
 =?us-ascii?Q?wbeZ82YT0BAR6xnUU/aGYcZliBm36AfD9ZJXUGgTJ40m30caANnjjBM9qxu1?=
 =?us-ascii?Q?qpKmdGJe7ZJZ/SWYggpDEfiwNBtikWlKRGECxixeu5WejMQ9QVRSV8fnm7n6?=
 =?us-ascii?Q?q0rXF1WiLjVLyR8mSZT6Q5FtWcKWKXy9zMtsGdAxNN5QAcYLuhEsHSoTGvsJ?=
 =?us-ascii?Q?7K8Cz6NYf0EJXBwD667KQoSQX1rldnimyC+u3VSUwXDbM3hMdFTrs9dev/4v?=
 =?us-ascii?Q?SvQiX7NdON0B1NyNRH5RjIFRYlk+O/kYRFNnhqjMIELbaYxko1rp3gMT/J7z?=
 =?us-ascii?Q?jFzMgylYW7qHtxHYHR5kI+QYaSC5J3c/YacUR7/5gZUr6vTUvNvwRRjwY9iw?=
 =?us-ascii?Q?0uom30tSxvGTA3VKko4QdxtaKuWVColUJ1aESaASXpUp2c2uA5OrZf7Bx03y?=
 =?us-ascii?Q?xzB8PHdv2prh5mM9bqyGsoJc0VQ2JJzTxxRWtgPwOfeCniKMRok8kMdUkdT0?=
 =?us-ascii?Q?YA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09e6244b-003f-4d59-73a8-08dade00a156
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2022 18:25:51.3885
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T1LE1N+vjJnZv3qQeEdB80DJsjxABo4RPIRY+T3uRZbStAGkYUvskPQC77cALDlBrMsZlHk1JtZoBDBO4v8EA6g6SyUnkuX/3TWLGQRWsGI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR21MB3106
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
> The ring buffer is remapped in the hv_ringbuffer_init()
> and it should be with decrypt flag in order to share it
> with hypervisor in sev-snp enlightened guest.

FWIW, the change in this patch is included in Patch 9
in my vTOM-related patch series.

>=20
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> ---
>  drivers/hv/ring_buffer.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/hv/ring_buffer.c b/drivers/hv/ring_buffer.c
> index 59a4aa86d1f3..391995c76be7 100644
> --- a/drivers/hv/ring_buffer.c
> +++ b/drivers/hv/ring_buffer.c
> @@ -18,6 +18,7 @@
>  #include <linux/slab.h>
>  #include <linux/prefetch.h>
>  #include <linux/io.h>
> +#include <linux/set_memory.h>
>  #include <asm/mshyperv.h>
>=20
>  #include "hyperv_vmbus.h"
> @@ -233,14 +234,18 @@ int hv_ringbuffer_init(struct hv_ring_buffer_info *=
ring_info,
>=20
>  		ring_info->ring_buffer =3D (struct hv_ring_buffer *)
>  			vmap(pages_wraparound, page_cnt * 2 - 1, VM_MAP,
> +				hv_isolation_type_en_snp() ?
> +				pgprot_decrypted(PAGE_KERNEL_NOENC) :
>  				PAGE_KERNEL);

Note that pgprot_decrypted(PAGE_KERNEL_NOENC) can always be
used, as it does nothing in a normal VM.  Its use doesn't need to be
conditional on the isolation type.

>=20
> +		if (hv_isolation_type_en_snp())
> +			memset(ring_info->ring_buffer, 0x00, page_cnt * PAGE_SIZE);

My version of the change always does the zero'ing, but only of
the first page, as Hyper-V expects the ring buffer header page to be
clean.  The initial contents of the rest of the ring buffer doesn't
really matter.

> +
>  		kfree(pages_wraparound);
>  		if (!ring_info->ring_buffer)
>  			return -ENOMEM;
>  	}
>=20
> -

The above looks like a spurious whitespace change.

>  	ring_info->ring_buffer->read_index =3D
>  		ring_info->ring_buffer->write_index =3D 0;
>=20
> --
> 2.25.1

