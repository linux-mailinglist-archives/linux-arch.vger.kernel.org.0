Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54F597473EC
	for <lists+linux-arch@lfdr.de>; Tue,  4 Jul 2023 16:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbjGDOSv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Jul 2023 10:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbjGDOSu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Jul 2023 10:18:50 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F142E42;
        Tue,  4 Jul 2023 07:18:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hu4YG+mkL70qRqJr0VRnTT/hgqmBgQYPXUqwTe8Z/abSZ3nh0ogQDUZxqEOziEZrZ6KGL5UxHeWJW/6QFs53Q0DxZHZVuzBNaMMuxSXXhF6syLDe9EFZPKi1YvRDCkQVxETo6sqdoH5FB+ISBo8mRiX6zwE2Y9PkROcpFdABm53cvo9cH9yFpmwiGvazCLU/LYm1KCbeJ80WHFvedFXH2wvcP6I3rSAX21zEaE3caDN6IjOsUH/1ld4odGUTfnkqlCUNjorUyDnObTdpmZ5tyalePdazdlxX3oAQVh4fYXRGX2IHrG2lCmpCIztJ5V+A9f+t0Xiz9PGBDqMauv8AcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VhYGpDBS5Qb3u9Ej7tTMTcwrOPpuzoMkOLoWSKzqnOk=;
 b=YqMziQlEy8WQIIljInI29JNEgHNRlyWNz12K8xNe7Glr0ApSO1JzhmIOgRY1YvLpkFTNcTvYmOHZEK5u012MvzkeLesBGHjtq2/t3ZbPim13jqN7Xl51CSMbCx9jddGp46kCshB0Xb4fU/OCrQhsdaZMQRkT5ZFRJNK9KhVbJlJIm1uTMCh1BBPVTmYTVoFTAw94DACVGomwsBXR5haprvf5zv/SV6ERUm3CkEy2WTqa9Qc5HFL0vjftPJ/nFWHnLbu0lUtPqqrd5MwSAVCxvAFgQtOllOLcrbQS10iJA4692ueiRDWxfjjrEcIcmiQzMfMKraf1Wq9YYxzs50ciQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VhYGpDBS5Qb3u9Ej7tTMTcwrOPpuzoMkOLoWSKzqnOk=;
 b=dCbtwaVnSVvyI+F3Lmqx4masXnD2Npo07fsleAh93dVWRwzUXslMFXwKDz7OTcOYGKwoKvm+qdLJ7AwAtrx4dMSOIFS6YvM751WW9t1PrxqP4vD+3nQk6tvjOnJ9IMWtuWwqUsmZTy6HdjYzSWIIXYnjtYaPT3NdrDp/DVKYSQE=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by CY5PR21MB3733.namprd21.prod.outlook.com (2603:10b6:930:d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.8; Tue, 4 Jul
 2023 14:18:46 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::4295:75a9:26d2:e64]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::4295:75a9:26d2:e64%5]) with mapi id 15.20.6588.006; Tue, 4 Jul 2023
 14:18:45 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Tianyu Lan <ltykernel@gmail.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "arnd@arndb.de" <arnd@arndb.de>
CC:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>
Subject: RE: [PATCH V2 3/9] x86/hyperv: Mark Hyper-V vp assist page
 unencrypted in SEV-SNP enlightened guest
Thread-Topic: [PATCH V2 3/9] x86/hyperv: Mark Hyper-V vp assist page
 unencrypted in SEV-SNP enlightened guest
Thread-Index: AQHZqKat1Yy1yLrRF0S2NXkjYuxAe6+ps26A
Date:   Tue, 4 Jul 2023 14:18:45 +0000
Message-ID: <BYAPR21MB1688D1207B957D63839EF398D72EA@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230627032248.2170007-1-ltykernel@gmail.com>
 <20230627032248.2170007-4-ltykernel@gmail.com>
In-Reply-To: <20230627032248.2170007-4-ltykernel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=e85e6e00-7750-4fc6-a731-7add7aad8420;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-07-04T14:18:12Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|CY5PR21MB3733:EE_
x-ms-office365-filtering-correlation-id: 9612da5a-3560-4386-4597-08db7c999414
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 61eg36IaLQAgQEOmzLXZyi2qbM2hMKlDGgLKJnew4w3G1FtJxUMmn8+U/N38K+8Rrby1aqhgdlaQEtk1+HIxVzKbz6kse3Fx6OCm3vJXwhXYp84NiRRvRigTFCAwt5/DFPtaBkcIdu0+AvTK1UpkSRSJs9B431brQv2q4+2OzkUa1rs716Ne53xUXlvbcZBvgTQF6ykguI0AiX2Ev2ugc21o/B9C094LDVFX3kcHm7y8h6Ts7KaHVPhRe1gxD6MLC8FxpjVVYViKYwCG4t4TGvpv425Dd6LOKKodpL/vQMVMaN96ktrUKm/cCs6whcSn+x/c0YZs5wdUN2STd9POf9li3cy5iGI0dQRy3R+8HC0Uoy/yxKumrQYAsAMyc6dUcV9moSV7C0HjWYc96i7bdVm/j+gm24M7l1doQNcR50Evnpbr/diqIDYv6jIsxhJ9vf16o+uXfrD1b3r4wOc2Nn3GnTqF7ez0um51KBsbl+qupomS74cqqr6zdujxlqDJgBEG5c8ol/hrA05prXzjHUlHAtOzoZ3y5eHmHBFmOZMp0a8e/10jv9WlukhcxJN9tiAatKd0tcexK8k1o+nXjSZJe2ZPKP8nSzfxuLOv7yBuASsS6ws0yPkT25dlr+SNQ22kbi+Pebt68ns6SHRKmb6f3N0tLTcN7vnbZQSMPyk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(376002)(346002)(396003)(366004)(451199021)(8676002)(8936002)(54906003)(110136005)(478600001)(26005)(9686003)(41300700001)(52536014)(33656002)(71200400001)(7416002)(2906002)(5660300002)(86362001)(7696005)(64756008)(316002)(66476007)(122000001)(55016003)(66556008)(76116006)(38100700002)(4326008)(66446008)(66946007)(38070700005)(921005)(8990500004)(82960400001)(82950400001)(6506007)(10290500003)(186003)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hi1JR1Sij0qakY8Y00u8IqsdAMP/LgbJVkll1XL9EqqmT97o4eUlxpzsV0Ij?=
 =?us-ascii?Q?47WIomb5fGvFFrxdi1BGYgRPks9VNPXuBoNeXVtnfDPiSFoP9ZMKCeLnZvLP?=
 =?us-ascii?Q?/CqPbXeEctPU4eSdV8lkHHsEf8A951qFUiW3XzTRz2ftUEHH/JxpF9Mzp8RO?=
 =?us-ascii?Q?lDs0uub4dDeE/E2Ob1xMY2W1o/tx5Gmitkn1CgfV1A6D/Ej3PBKW/Jb5Hp73?=
 =?us-ascii?Q?KcrcF/Vx+v6Ha1aNMgfElKToPLEes23p4Smwr0QtVaSOnh66uLfrqjwtlHE2?=
 =?us-ascii?Q?KHTIGmL8JGNidE5AUyrNNYQE7fvw8qdpwaLN81CFmb08vkPaif4pSK8g8VLO?=
 =?us-ascii?Q?xg70IxCPhUVyLNYNoia2Dzwngaii6HEliH7tOUnLlluwTARyNdNP1tqmCdBh?=
 =?us-ascii?Q?Gq4QFzMlhJG9IGsGuZG/326F6plEMmq44B+udBWxaTylFsfbzxAjHLbZfjsO?=
 =?us-ascii?Q?gPnGDIVz3Ui01YEHHTzakWwL3R21z1KVchLczxE4Ad4u6OFe+VjpqkBVPrXS?=
 =?us-ascii?Q?JF9bUDJq7D1SRF51Ck5IcUVkvE8sk+vJKMMUWiXFXPxeFM/gv0VibPn49X6p?=
 =?us-ascii?Q?siBzHU7EfDpZfWg7qdMU+P4UzuwwCr2PxyMgmQruu0kkA9TlxDT85RDuW6oE?=
 =?us-ascii?Q?QGczfQNoIZ59vMUU/R754fTPUx/CAA+CJjlmHz1bBeppf1GHEbknJXOJIvoG?=
 =?us-ascii?Q?E2zrlpVDpVzn3G3774o+P3SSbJHvEngF7uzmpjnw8ME0zjiXjtyOZm2UuReu?=
 =?us-ascii?Q?SvEGJiwwGsgeMSNRkV6sfsAIOjvEszPkYAI0f03fca1n9dzYNlqOdTkEOG+d?=
 =?us-ascii?Q?OGSzNf9hszlRGsDVUdwBCf+Jq84eRwg3i6Z5/DCqjJ7zCfqDkFjn/0a/rPK0?=
 =?us-ascii?Q?nyMguyPrM6X5NsTKHNJaJhryb+jAyrxVFg0t0ohP8Doa23i08DCx2Y0hpjF3?=
 =?us-ascii?Q?RhwZgNJxIZV6OlYznXJmEwtIkVd30vpYmHpVqaBE8NfIDmXSQtVxvAZAimjW?=
 =?us-ascii?Q?S1Cg31qLbZwtAfqMaRRBKsVDbX33bBBevdrmbEdd2vmuKnodzJmJ0U2Q0Q7U?=
 =?us-ascii?Q?lCML4tvWhQWUp+23FtnTq0dWOpNeSH+1VYMw33VK9ZaZKfc1XBPhUXj5Pmro?=
 =?us-ascii?Q?w9PLWuSSoURJQ2raqxxhU6nsFHjG+blI3ySkOri52Wd/S8QdZO8Xw8Td/1CY?=
 =?us-ascii?Q?/xmhUV1Z5sGhgPyCJWP4QG9kLLbQqJuncNak4gxKfqhz/ncM+LXZMpFMkPpG?=
 =?us-ascii?Q?yJ0F+QDoRd/Ghjl/Ru0AEY5oHOg8qzHSmmbVoYhx/huglk3TjIO9f6Tjn+vB?=
 =?us-ascii?Q?oGZ1ZiSSLOHKsFY4ExsLlPLEBfTxzReMd3EDCXV+E9fVu9sIrm9M1mAKhVHQ?=
 =?us-ascii?Q?C8pmKsR00JlzYAZmqkkl0BtkHP2ycOv0aIqX2gegyqusNTJE1gN1rwuMRe1P?=
 =?us-ascii?Q?NawJ28T4pxBVwp0eDC7F5WamOBlM/+w9jCTYTAbKUnpWeDhbehk/Qo/lh2Hn?=
 =?us-ascii?Q?3qrOjwlLvHO/CJ+ZgnpXaSm7jeMpNO/3V6UNSEMG1uKbpxhnuCPTmnUynGvp?=
 =?us-ascii?Q?SfcgabOcoXwmAty9EZiKOIfpXfNpFSQbjMnzje7um11P7RSt112OyjJvWMpP?=
 =?us-ascii?Q?tg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9612da5a-3560-4386-4597-08db7c999414
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2023 14:18:45.8689
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VZ7AexwcLdRqxpiiPROh7TY9vra5N1MEmpFzG44QCrecxzxRl1QwnvxBrTLC3vlcUqBry4pq9177wUOuO+4ra2fqZaRUzqUOIaV/+FkQ5jw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR21MB3733
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Tianyu Lan <ltykernel@gmail.com> Sent: Monday, June 26, 2023 8:23 PM
>=20
> hv vp assist page needs to be shared between SEV-SNP guest and Hyper-V.
> So mark the page unencrypted in the SEV-SNP guest.
>=20
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> ---
>  arch/x86/hyperv/hv_init.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 1ba367a9686e..b004370d3b01 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -18,6 +18,7 @@
>  #include <asm/hyperv-tlfs.h>
>  #include <asm/mshyperv.h>
>  #include <asm/idtentry.h>
> +#include <asm/set_memory.h>
>  #include <linux/kexec.h>
>  #include <linux/version.h>
>  #include <linux/vmalloc.h>
> @@ -106,8 +107,21 @@ static int hv_cpu_init(unsigned int cpu)
>  		 * in hv_cpu_die(), otherwise a CPU may not be stopped in the
>  		 * case of CPU offlining and the VM will hang.
>  		 */
> -		if (!*hvp)
> +		if (!*hvp) {
>  			*hvp =3D __vmalloc(PAGE_SIZE, GFP_KERNEL | __GFP_ZERO);
> +
> +			/*
> +			 * Hyper-V should never specify a VM that is a Confidential
> +			 * VM and also running in the root partition. Root partition
> +			 * is blocked to run in Confidential VM. So only decrypt assist
> +			 * page in non-root partition here.
> +			 */
> +			if (*hvp && hv_isolation_type_en_snp()) {
> +				WARN_ON_ONCE(set_memory_decrypted((unsigned
> long)(*hvp), 1));
> +				memset(*hvp, 0, PAGE_SIZE);
> +			}
> +		}
> +
>  		if (*hvp)
>  			msr.pfn =3D vmalloc_to_pfn(*hvp);
>=20
> --
> 2.25.1

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

