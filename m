Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7F86E9D17
	for <lists+linux-arch@lfdr.de>; Thu, 20 Apr 2023 22:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232486AbjDTUYB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 20 Apr 2023 16:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232243AbjDTUXe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 20 Apr 2023 16:23:34 -0400
Received: from DM5PR00CU002.outbound.protection.outlook.com (mail-centralusazon11021023.outbound.protection.outlook.com [52.101.62.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC0EC30C6;
        Thu, 20 Apr 2023 13:22:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e9+XE7dMSwDOQ9dYMWjpyJa2E1Hmy9foeVIRYGbOhcKys6oOA8lWalGTOM8i4B0WzTB9oit1ZdMWFWerv5U+ZESyRqMYX+UriIcIS7GrAjHagN6c9zaWxPSjmh6CihhUs+uSs6wawN4t5Gt9BFVntMfLJ7rV+WThd63+en94duzO0kpVpFv3CXdlhTR+xNH4k1yWZ+ycSosFwwXqyyKuTDH1R6Zn3fTH9kqzjnvIEUYu7RzIYxLSqPOzD6xE3vDDwow5V17qDJgFm9MkOlWciC+vWYymcMbJMSmqj8v/5G69ocrKed3MQ4+0UkROTMxVy0aUyiU3MUILDC4Xtl2YmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Gn7k2dcY7DkGXf28ERQ2GIbawCPseo+qSSk4uVEc8I=;
 b=nfTWjqVOR3fbwOlNboW2q6vTdomLJNTxBu2Ca+XcXCAmKXtIi6J2C0+lySpAU0eHsY+OCLSXTxrgC3zBhiQ6Z9zCj72hoK+4rRSvMl39nIL3GK0e12YteQSSx7XoiDOepIHeDR9AYW9HoEEkwxP8ppEba3X6ZojU6QMQwtVvi4P2moGcfw+AiYA9se0hieyswJHAlinMXoQfzzlAFgMlzLlaFWg4nP2UJOHakiyuoFRLvpEZTbiZfBYjlvNPD0kswnPdFdJeOyszYircnkCbF0+n7GPDtPtZA23NMVrOJiEs9Gz05kTH6OBXCZLI9QoaLmLiOMSui3lRMRxQMLW/+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Gn7k2dcY7DkGXf28ERQ2GIbawCPseo+qSSk4uVEc8I=;
 b=dhGFuEZMM2oOCHzn4IyxXm9lTw0Hk89aWt5n6uaQpjJM85PH7aUMp4Nh34RXd5dOqiQz/JWKdLh6R4GUZneafqdi5TCf17qb/FqScSh4h0cCTROzowceA0fWVC2WqV1QrnC6HSkZCJKnYGaHK1ETAUQCIKU9WUPpg+YOdXY77Zk=
Received: from PH7PR21MB3263.namprd21.prod.outlook.com (2603:10b6:510:1db::16)
 by PH7PR21MB3165.namprd21.prod.outlook.com (2603:10b6:510:1d5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.11; Thu, 20 Apr
 2023 20:22:40 +0000
Received: from PH7PR21MB3263.namprd21.prod.outlook.com
 ([fe80::4d56:4d4b:3785:a1ca]) by PH7PR21MB3263.namprd21.prod.outlook.com
 ([fe80::4d56:4d4b:3785:a1ca%5]) with mapi id 15.20.6319.004; Thu, 20 Apr 2023
 20:22:40 +0000
From:   Long Li <longli@microsoft.com>
To:     "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Arnd Bergmann <arnd@arndb.de>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: RE: [PATCH v3] Drivers: hv: move panic report code from vmbus to hv
 early init code
Thread-Topic: [PATCH v3] Drivers: hv: move panic report code from vmbus to hv
 early init code
Thread-Index: AQHZczVCedgvuINebkSiTc1TJQlTQq80pQGw
Date:   Thu, 20 Apr 2023 20:22:40 +0000
Message-ID: <PH7PR21MB32635E38640C3719638A7185CE639@PH7PR21MB3263.namprd21.prod.outlook.com>
References: <1681960046-9502-1-git-send-email-longli@linuxonhyperv.com>
In-Reply-To: <1681960046-9502-1-git-send-email-longli@linuxonhyperv.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=2858fb27-27b7-49c0-b535-7dffcf18e329;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-04-20T20:21:38Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3263:EE_|PH7PR21MB3165:EE_
x-ms-office365-filtering-correlation-id: d805dd9b-b65b-4a32-49a7-08db41dcfd8e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6SiEJ4rEH88Sb4Vhu4ITQU/VJRdrOuMKjK6d7lOo/d06ImXVdpA1j/Bv5g5cldYH5KzkilKv19bndfcuuKnojwAIyXfZ0Z6onjRHR5Qs5mvSJHloIug3plJ9UUBXWZzOnV5nM3GPyyVKNQ1oHfNx9BGzjiPk+cszRyhFbnhXOAmeA3SiwwBA77IVCImVUCwsE5syrEigc4iNq3HYpl+xb/PipDeU1j144rupmYd5HC5OM5XkyoQB8IaxFNmu85C9peNu4c1LMrVhizwBZ7MiLSsiAmwT/PwWeFqw/FJzB7KudCfzEkY/KjDqoRsJ8EKCNMtbGkTqjlB54NPY97xb2x7MfIgc9+AcnhROseVh8U1X7m1vPs/FZ3jcLO4nq2W9PaJzOMEfma0b97p1xkGtq8WoIf6Rnu7ruLuytD5kU3CGCnmOA8iiCe1LS/KlY2tkLThThfcmN95gqG/qhbtRkVDXSjWN1O3Vc5oi1f/OhFaNopthGRgEjRS2QOIrWKobmO5qm1KxpuYYeAkbXKd5WZPzFh01rgz9bibJaM2FyUOcxOoSpqPxsqrFyS7JTC6QxsHVmK2Swv9PDBagnb+LzxLlJV4RQTjov6lyR64zMUTcCeHXtDM/KnXOXKycuIDNKdxpAvZ1XhKKCmIGeYm7dijF17MKubnCkxfN1MwSX+E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3263.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(136003)(376002)(346002)(366004)(451199021)(110136005)(86362001)(33656002)(83380400001)(9686003)(6506007)(26005)(478600001)(54906003)(71200400001)(7696005)(66476007)(66556008)(82950400001)(82960400001)(41300700001)(38070700005)(786003)(316002)(38100700002)(122000001)(55016003)(10290500003)(66446008)(4326008)(76116006)(8676002)(8936002)(66946007)(64756008)(186003)(30864003)(2906002)(5660300002)(8990500004)(52536014)(579004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bvT7ZRlxXOj+WzwYNTm+sn0TSH3Kxb8cxqsEP9AqHNriw0ODVh1EjPF/HSH6?=
 =?us-ascii?Q?5tBAqM2iBSgQjnedlr6ZOA1UWsogUGVT2SIS2u/VG/MUiYM8KhAP+MiZCHCx?=
 =?us-ascii?Q?Ygdgb9v8zBZchtbfRAWPICPBoLXa6z62Ovmk26vR3bXcM2ZnrHVERWW7KVeC?=
 =?us-ascii?Q?e5EtRMOjf7y1qVtMOxciuJNOLyPkKHgLxukxnjYMH24TpSj9JA3hU9F3BxCq?=
 =?us-ascii?Q?td2nSXeMzwQFOL7T/6WIgEElNN3F+Yuc7cj3H+IVYFCwxT825Vs2aBI2bcY0?=
 =?us-ascii?Q?L6jtK6/skGXSU0e0/bpmmt6B8coH2xB4rYZg/dLyTlG5rIY+RkxUcFbe9fcV?=
 =?us-ascii?Q?A6boqwpaxcP8txeFOB5X3xvHvlPSfM8p1KNjZlVOP6VbHcjy8JmUftQjtCWA?=
 =?us-ascii?Q?jbmXL/xcKJsSd3DzgJgQS8dSCHrfaVRVZE/wtcYntPpThe7vbyFDntuDzNxa?=
 =?us-ascii?Q?h65BCwO/uLYygA2dn5Gnq1lTk/62W4g7NT5ZoTE2DR3LT/eoBpq1SWv5DOhy?=
 =?us-ascii?Q?P+omOgiRBm8nERP5Sc8B9YxgrzjyC3wFhfT5CT9iAYcUQPQLDWHJJXlqbIRb?=
 =?us-ascii?Q?Zv9cWiW5zpxd0jMbl7WDgfrB68l+hLgV/3U1tkAfw0XOd9GRx0rzG3Mb2JVz?=
 =?us-ascii?Q?Ud7FH2RfAbvXAfF9Lp6UdgXUfFl68cA4CJAdSktMMJmj1HVtK5cIN0NPrkki?=
 =?us-ascii?Q?+wRB4pdGBQ/XvgSyY6Gazeo8k/244U1+KYleTeLh+yqrTHTDm9IZ3ltYamcX?=
 =?us-ascii?Q?WtwxT++swp2h2PTL7eqZGmpzrg2yCR9fhWPPdNb4qGMMQuNKyJktGMaXtKIl?=
 =?us-ascii?Q?0UTZGyCOz/CGpItX3zrL7FlRnyMtB9PgS5f1bpyQOfvMuj8ADGrWfL/hwBNP?=
 =?us-ascii?Q?swZT1M9UwFGOffe7QmnVB/7F6dtHHROSx7ddb47kR12EMZJGJe48NLEBe8f3?=
 =?us-ascii?Q?lp4Hzdt3DgZvf/LMQeAYejB946OzhCew7J5JKUDaApcd4XWSAcGhXt83sHkt?=
 =?us-ascii?Q?aNl6Mb35jTsrjurOJdYrtfwq3BJAsB4fp3hdoBY/4UqBbIQpQjtb9NL5RtiG?=
 =?us-ascii?Q?1ryd2D9n0yc1Z50p+QqzBloJw12iv6RzthK019MjzKx5GQjGBGD1YzQdwq+A?=
 =?us-ascii?Q?apgJsltin5k5+t4cBid3WPZ3kXfgIoiQkkD/lBtANrOUO4MziOzT6kiqHnNw?=
 =?us-ascii?Q?RQQcdbGoX5D+wJNy0Hlnj2B5cSfuTA+cV+NAaAQAcPfEcLon981spLHIFOht?=
 =?us-ascii?Q?7B9mrJcg0DTzNljep2Ec20SbAY5rDTP8SzcDIWgVD09CDHtIQzIWPbeXzOoV?=
 =?us-ascii?Q?+dqqnKjr2qC3e5HSZauw2qMze2AZ64aYaOAXLCKWEfeylbwLNXE3N4cJCo2F?=
 =?us-ascii?Q?U9CpBIwMav0QPhuKbAfClS9KEkQpNr0TwbT2p5BTJ1WgrrJeIB9qXOoA99DM?=
 =?us-ascii?Q?/7qxMFXy+Q1yoLbM4Do0KLMO9JiZ5p8yZBUWnlTKKjsyFu46YaDMQEqKkVRv?=
 =?us-ascii?Q?z54LcBpbUFAxDqmmJc6eCRYln+TxJk1URkrunMzcMxKq37Hgsd4IYYH11xZt?=
 =?us-ascii?Q?d+JLPhmtBqGsEchAPXPcBx249HUq0qsv3g1Cm9ms?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR21MB3263.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d805dd9b-b65b-4a32-49a7-08db41dcfd8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2023 20:22:40.5119
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vxn7rK6asO4zDqxmLNEgp11+fn6+be4SWYyI2qQs0+y/5aO/3afjvh3czgj1nbczBUI4AAtP0Ac4MdWtHVnqZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR21MB3165
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> Subject: [PATCH v3] Drivers: hv: move panic report code from vmbus to hv
> early init code

Hi Wei,

Please discard this patch. It seems there are some other changes not in lin=
ux-next.

I'm rebasing to hyperv-next and will send an updated version.

Long

>=20
> From: Long Li <longli@microsoft.com>
>=20
> The panic reporting code was added in commit 81b18bce48af
> ("Drivers: HV: Send one page worth of kmsg dump over Hyper-V during
> panic")
>=20
> It was added to the vmbus driver. The panic reporting has no dependence o=
n
> vmbus, and can be enabled at an earlier boot time when Hyper-V is initial=
ized.
>=20
> This patch moves the panic reporting code out of vmbus. There is no
> functionality changes. During moving, also refactored some cleanup functi=
ons
> into hv_kmsg_dump_unregister().
>=20
> Signed-off-by: Long Li <longli@microsoft.com>
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>
>=20
> ---
> Change log v3:
> 1. Rebase to latest upstream code
>=20
> Change log v2:
> 1. Check on hv_is_isolation_supported() before reporting crash dump 2.
> Remove hyperv_report_reg(), inline the check condition instead 3. Remove
> the test NULL on hv_panic_page when freeing it
>=20
>  drivers/hv/hv.c        |  36 -------
>  drivers/hv/hv_common.c | 231
> +++++++++++++++++++++++++++++++++++++++++
>  drivers/hv/vmbus_drv.c | 190 ---------------------------------
>  3 files changed, 231 insertions(+), 226 deletions(-)
>=20
> diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c index
> 4e1407d59ba0..de6708dbe0df 100644
> --- a/drivers/hv/hv.c
> +++ b/drivers/hv/hv.c
> @@ -38,42 +38,6 @@ int hv_init(void)
>  	return 0;
>  }
>=20
> -/*
> - * Functions for allocating and freeing memory with size and
> - * alignment HV_HYP_PAGE_SIZE. These functions are needed because
> - * the guest page size may not be the same as the Hyper-V page
> - * size. We depend upon kmalloc() aligning power-of-two size
> - * allocations to the allocation size boundary, so that the
> - * allocated memory appears to Hyper-V as a page of the size
> - * it expects.
> - */
> -
> -void *hv_alloc_hyperv_page(void)
> -{
> -	BUILD_BUG_ON(PAGE_SIZE <  HV_HYP_PAGE_SIZE);
> -
> -	if (PAGE_SIZE =3D=3D HV_HYP_PAGE_SIZE)
> -		return (void *)__get_free_page(GFP_KERNEL);
> -	else
> -		return kmalloc(HV_HYP_PAGE_SIZE, GFP_KERNEL);
> -}
> -
> -void *hv_alloc_hyperv_zeroed_page(void)
> -{
> -	if (PAGE_SIZE =3D=3D HV_HYP_PAGE_SIZE)
> -		return (void *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
> -	else
> -		return kzalloc(HV_HYP_PAGE_SIZE, GFP_KERNEL);
> -}
> -
> -void hv_free_hyperv_page(unsigned long addr) -{
> -	if (PAGE_SIZE =3D=3D HV_HYP_PAGE_SIZE)
> -		free_page(addr);
> -	else
> -		kfree((void *)addr);
> -}
> -
>  /*
>   * hv_post_message - Post a message using the hypervisor message IPC.
>   *
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c index
> 6d40b6c7b23b..64f9ceca887b 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -17,8 +17,11 @@
>  #include <linux/export.h>
>  #include <linux/bitfield.h>
>  #include <linux/cpumask.h>
> +#include <linux/sched/task_stack.h>
>  #include <linux/panic_notifier.h>
>  #include <linux/ptrace.h>
> +#include <linux/kdebug.h>
> +#include <linux/kmsg_dump.h>
>  #include <linux/slab.h>
>  #include <linux/dma-map-ops.h>
>  #include <asm/hyperv-tlfs.h>
> @@ -54,6 +57,10 @@ EXPORT_SYMBOL_GPL(hyperv_pcpu_input_arg);
>  void * __percpu *hyperv_pcpu_output_arg;
> EXPORT_SYMBOL_GPL(hyperv_pcpu_output_arg);
>=20
> +static void hv_kmsg_dump_unregister(void);
> +
> +static struct ctl_table_header *hv_ctl_table_hdr;
> +
>  /*
>   * Hyper-V specific initialization and shutdown code that is
>   * common across all architectures.  Called from architecture @@ -62,6
> +69,12 @@ EXPORT_SYMBOL_GPL(hyperv_pcpu_output_arg);
>=20
>  void __init hv_common_free(void)
>  {
> +	unregister_sysctl_table(hv_ctl_table_hdr);
> +	hv_ctl_table_hdr =3D NULL;
> +
> +	if (ms_hyperv.misc_features &
> HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE)
> +		hv_kmsg_dump_unregister();
> +
>  	kfree(hv_vp_index);
>  	hv_vp_index =3D NULL;
>=20
> @@ -72,10 +85,203 @@ void __init hv_common_free(void)
>  	hyperv_pcpu_input_arg =3D NULL;
>  }
>=20
> +/*
> + * Functions for allocating and freeing memory with size and
> + * alignment HV_HYP_PAGE_SIZE. These functions are needed because
> + * the guest page size may not be the same as the Hyper-V page
> + * size. We depend upon kmalloc() aligning power-of-two size
> + * allocations to the allocation size boundary, so that the
> + * allocated memory appears to Hyper-V as a page of the size
> + * it expects.
> + */
> +
> +void *hv_alloc_hyperv_page(void)
> +{
> +	BUILD_BUG_ON(PAGE_SIZE <  HV_HYP_PAGE_SIZE);
> +
> +	if (PAGE_SIZE =3D=3D HV_HYP_PAGE_SIZE)
> +		return (void *)__get_free_page(GFP_KERNEL);
> +	else
> +		return kmalloc(HV_HYP_PAGE_SIZE, GFP_KERNEL); }
> +EXPORT_SYMBOL_GPL(hv_alloc_hyperv_page);
> +
> +void *hv_alloc_hyperv_zeroed_page(void)
> +{
> +	if (PAGE_SIZE =3D=3D HV_HYP_PAGE_SIZE)
> +		return (void *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
> +	else
> +		return kzalloc(HV_HYP_PAGE_SIZE, GFP_KERNEL); }
> +EXPORT_SYMBOL_GPL(hv_alloc_hyperv_zeroed_page);
> +
> +void hv_free_hyperv_page(unsigned long addr) {
> +	if (PAGE_SIZE =3D=3D HV_HYP_PAGE_SIZE)
> +		free_page(addr);
> +	else
> +		kfree((void *)addr);
> +}
> +EXPORT_SYMBOL_GPL(hv_free_hyperv_page);
> +
> +static void *hv_panic_page;
> +
> +/*
> + * Boolean to control whether to report panic messages over Hyper-V.
> + *
> + * It can be set via /proc/sys/kernel/hyperv_record_panic_msg
> + */
> +static int sysctl_record_panic_msg =3D 1;
> +
> +/*
> + * sysctl option to allow the user to control whether kmsg data should
> +be
> + * reported to Hyper-V on panic.
> + */
> +static struct ctl_table hv_ctl_table[] =3D {
> +	{
> +		.procname	=3D "hyperv_record_panic_msg",
> +		.data		=3D &sysctl_record_panic_msg,
> +		.maxlen		=3D sizeof(int),
> +		.mode		=3D 0644,
> +		.proc_handler	=3D proc_dointvec_minmax,
> +		.extra1		=3D SYSCTL_ZERO,
> +		.extra2		=3D SYSCTL_ONE
> +	},
> +	{}
> +};
> +
> +static int hv_die_panic_notify_crash(struct notifier_block *self,
> +				     unsigned long val, void *args);
> +
> +static struct notifier_block hyperv_die_report_block =3D {
> +	.notifier_call =3D hv_die_panic_notify_crash, };
> +
> +static struct notifier_block hyperv_panic_report_block =3D {
> +	.notifier_call =3D hv_die_panic_notify_crash, };
> +
> +/*
> + * The following callback works both as die and panic notifier; its
> + * goal is to provide panic information to the hypervisor unless the
> + * kmsg dumper is used [see hv_kmsg_dump()], which provides more
> + * information but isn't always available.
> + *
> + * Notice that both the panic/die report notifiers are registered only
> + * if we have the capability HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE
> set.
> + */
> +static int hv_die_panic_notify_crash(struct notifier_block *self,
> +				     unsigned long val, void *args) {
> +	struct pt_regs *regs;
> +	bool is_die;
> +
> +	/* Don't notify Hyper-V unless we have a die oops event or panic. */
> +	if (self =3D=3D &hyperv_panic_report_block) {
> +		is_die =3D false;
> +		regs =3D current_pt_regs();
> +	} else { /* die event */
> +		if (val !=3D DIE_OOPS)
> +			return NOTIFY_DONE;
> +
> +		is_die =3D true;
> +		regs =3D ((struct die_args *)args)->regs;
> +	}
> +
> +	/*
> +	 * Hyper-V should be notified only once about a panic/die. If we will
> +	 * be calling hv_kmsg_dump() later with kmsg data, don't do the
> +	 * notification here.
> +	 */
> +	if (!sysctl_record_panic_msg || !hv_panic_page)
> +		hyperv_report_panic(regs, val, is_die);
> +
> +	return NOTIFY_DONE;
> +}
> +
> +/*
> + * Callback from kmsg_dump. Grab as much as possible from the end of
> +the kmsg
> + * buffer and call into Hyper-V to transfer the data.
> + */
> +static void hv_kmsg_dump(struct kmsg_dumper *dumper,
> +			 enum kmsg_dump_reason reason)
> +{
> +	struct kmsg_dump_iter iter;
> +	size_t bytes_written;
> +
> +	/* We are only interested in panics. */
> +	if (reason !=3D KMSG_DUMP_PANIC || !sysctl_record_panic_msg)
> +		return;
> +
> +	/*
> +	 * Write dump contents to the page. No need to synchronize; panic
> should
> +	 * be single-threaded.
> +	 */
> +	kmsg_dump_rewind(&iter);
> +	kmsg_dump_get_buffer(&iter, false, hv_panic_page,
> HV_HYP_PAGE_SIZE,
> +			     &bytes_written);
> +	if (!bytes_written)
> +		return;
> +	/*
> +	 * P3 to contain the physical address of the panic page & P4 to
> +	 * contain the size of the panic data in that page. Rest of the
> +	 * registers are no-op when the NOTIFY_MSG flag is set.
> +	 */
> +	hv_set_register(HV_REGISTER_CRASH_P0, 0);
> +	hv_set_register(HV_REGISTER_CRASH_P1, 0);
> +	hv_set_register(HV_REGISTER_CRASH_P2, 0);
> +	hv_set_register(HV_REGISTER_CRASH_P3,
> virt_to_phys(hv_panic_page));
> +	hv_set_register(HV_REGISTER_CRASH_P4, bytes_written);
> +
> +	/*
> +	 * Let Hyper-V know there is crash data available along with
> +	 * the panic message.
> +	 */
> +	hv_set_register(HV_REGISTER_CRASH_CTL,
> +			(HV_CRASH_CTL_CRASH_NOTIFY |
> +			 HV_CRASH_CTL_CRASH_NOTIFY_MSG));
> +}
> +
> +static struct kmsg_dumper hv_kmsg_dumper =3D {
> +	.dump =3D hv_kmsg_dump,
> +};
> +
> +static void hv_kmsg_dump_unregister(void) {
> +	kmsg_dump_unregister(&hv_kmsg_dumper);
> +	unregister_die_notifier(&hyperv_die_report_block);
> +	atomic_notifier_chain_unregister(&panic_notifier_list,
> +					 &hyperv_panic_report_block);
> +
> +	hv_free_hyperv_page((unsigned long)hv_panic_page);
> +	hv_panic_page =3D NULL;
> +}
> +
> +static void hv_kmsg_dump_register(void) {
> +	int ret;
> +
> +	hv_panic_page =3D hv_alloc_hyperv_zeroed_page();
> +	if (!hv_panic_page) {
> +		pr_err("Hyper-V: panic message page memory allocation
> failed\n");
> +		return;
> +	}
> +
> +	ret =3D kmsg_dump_register(&hv_kmsg_dumper);
> +	if (ret) {
> +		pr_err("Hyper-V: kmsg dump register error 0x%x\n", ret);
> +		hv_free_hyperv_page((unsigned long)hv_panic_page);
> +		hv_panic_page =3D NULL;
> +	}
> +}
> +
>  int __init hv_common_init(void)
>  {
>  	int i;
>=20
> +	if (hv_is_isolation_supported())
> +		sysctl_record_panic_msg =3D 0;
> +
>  	/*
>  	 * Hyper-V expects to get crash register data or kmsg when
>  	 * crash enlightment is available and system crashes. Set @@ -84,8
> +290,33 @@ int __init hv_common_init(void)
>  	 * kernel.
>  	 */
>  	if (ms_hyperv.misc_features &
> HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE) {
> +		u64 hyperv_crash_ctl;
> +
>  		crash_kexec_post_notifiers =3D true;
>  		pr_info("Hyper-V: enabling crash_kexec_post_notifiers\n");
> +
> +		/*
> +		 * Panic message recording (sysctl_record_panic_msg)
> +		 * is enabled by default in non-isolated guests and
> +		 * disabled by default in isolated guests; the panic
> +		 * message recording won't be available in isolated
> +		 * guests should the following registration fail.
> +		 */
> +		hv_ctl_table_hdr =3D register_sysctl("kernel", hv_ctl_table);
> +		if (!hv_ctl_table_hdr)
> +			pr_err("Hyper-V: sysctl table register error");
> +
> +		/*
> +		 * Register for panic kmsg callback only if the right
> +		 * capability is supported by the hypervisor.
> +		 */
> +		hyperv_crash_ctl =3D
> hv_get_register(HV_REGISTER_CRASH_CTL);
> +		if (hyperv_crash_ctl & HV_CRASH_CTL_CRASH_NOTIFY_MSG)
> +			hv_kmsg_dump_register();
> +
> +		register_die_notifier(&hyperv_die_report_block);
> +		atomic_notifier_chain_register(&panic_notifier_list,
> +					       &hyperv_panic_report_block);
>  	}
>=20
>  	/*
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c index
> 9a63a0d9f596..1c65a6dfb9fa 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -30,7 +30,6 @@
>  #include <linux/panic_notifier.h>
>  #include <linux/ptrace.h>
>  #include <linux/screen_info.h>
> -#include <linux/kdebug.h>
>  #include <linux/efi.h>
>  #include <linux/random.h>
>  #include <linux/kernel.h>
> @@ -50,26 +49,12 @@ static struct device  *hv_dev;
>=20
>  static int hyperv_cpuhp_online;
>=20
> -static void *hv_panic_page;
> -
>  static long __percpu *vmbus_evt;
>=20
>  /* Values parsed from ACPI DSDT */
>  int vmbus_irq;
>  int vmbus_interrupt;
>=20
> -/*
> - * Boolean to control whether to report panic messages over Hyper-V.
> - *
> - * It can be set via /proc/sys/kernel/hyperv_record_panic_msg
> - */
> -static int sysctl_record_panic_msg =3D 1;
> -
> -static int hyperv_report_reg(void)
> -{
> -	return !sysctl_record_panic_msg || !hv_panic_page;
> -}
> -
>  /*
>   * The panic notifier below is responsible solely for unloading the
>   * vmbus connection, which is necessary in a panic event.
> @@ -90,54 +75,6 @@ static struct notifier_block
> hyperv_panic_vmbus_unload_block =3D {
>  	.priority	=3D INT_MIN + 1, /* almost the latest one to execute */
>  };
>=20
> -static int hv_die_panic_notify_crash(struct notifier_block *self,
> -				     unsigned long val, void *args);
> -
> -static struct notifier_block hyperv_die_report_block =3D {
> -	.notifier_call =3D hv_die_panic_notify_crash,
> -};
> -static struct notifier_block hyperv_panic_report_block =3D {
> -	.notifier_call =3D hv_die_panic_notify_crash,
> -};
> -
> -/*
> - * The following callback works both as die and panic notifier; its
> - * goal is to provide panic information to the hypervisor unless the
> - * kmsg dumper is used [see hv_kmsg_dump()], which provides more
> - * information but isn't always available.
> - *
> - * Notice that both the panic/die report notifiers are registered only
> - * if we have the capability HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE
> set.
> - */
> -static int hv_die_panic_notify_crash(struct notifier_block *self,
> -				     unsigned long val, void *args)
> -{
> -	struct pt_regs *regs;
> -	bool is_die;
> -
> -	/* Don't notify Hyper-V unless we have a die oops event or panic. */
> -	if (self =3D=3D &hyperv_panic_report_block) {
> -		is_die =3D false;
> -		regs =3D current_pt_regs();
> -	} else { /* die event */
> -		if (val !=3D DIE_OOPS)
> -			return NOTIFY_DONE;
> -
> -		is_die =3D true;
> -		regs =3D ((struct die_args *)args)->regs;
> -	}
> -
> -	/*
> -	 * Hyper-V should be notified only once about a panic/die. If we will
> -	 * be calling hv_kmsg_dump() later with kmsg data, don't do the
> -	 * notification here.
> -	 */
> -	if (hyperv_report_reg())
> -		hyperv_report_panic(regs, val, is_die);
> -
> -	return NOTIFY_DONE;
> -}
> -
>  static const char *fb_mmio_name =3D "fb_range";  static struct resource
> *fb_mmio;  static struct resource *hyperv_mmio; @@ -1379,89 +1316,6 @@
> static irqreturn_t vmbus_percpu_isr(int irq, void *dev_id)
>  	return IRQ_HANDLED;
>  }
>=20
> -/*
> - * Callback from kmsg_dump. Grab as much as possible from the end of the
> kmsg
> - * buffer and call into Hyper-V to transfer the data.
> - */
> -static void hv_kmsg_dump(struct kmsg_dumper *dumper,
> -			 enum kmsg_dump_reason reason)
> -{
> -	struct kmsg_dump_iter iter;
> -	size_t bytes_written;
> -
> -	/* We are only interested in panics. */
> -	if ((reason !=3D KMSG_DUMP_PANIC) || (!sysctl_record_panic_msg))
> -		return;
> -
> -	/*
> -	 * Write dump contents to the page. No need to synchronize; panic
> should
> -	 * be single-threaded.
> -	 */
> -	kmsg_dump_rewind(&iter);
> -	kmsg_dump_get_buffer(&iter, false, hv_panic_page,
> HV_HYP_PAGE_SIZE,
> -			     &bytes_written);
> -	if (!bytes_written)
> -		return;
> -	/*
> -	 * P3 to contain the physical address of the panic page & P4 to
> -	 * contain the size of the panic data in that page. Rest of the
> -	 * registers are no-op when the NOTIFY_MSG flag is set.
> -	 */
> -	hv_set_register(HV_REGISTER_CRASH_P0, 0);
> -	hv_set_register(HV_REGISTER_CRASH_P1, 0);
> -	hv_set_register(HV_REGISTER_CRASH_P2, 0);
> -	hv_set_register(HV_REGISTER_CRASH_P3,
> virt_to_phys(hv_panic_page));
> -	hv_set_register(HV_REGISTER_CRASH_P4, bytes_written);
> -
> -	/*
> -	 * Let Hyper-V know there is crash data available along with
> -	 * the panic message.
> -	 */
> -	hv_set_register(HV_REGISTER_CRASH_CTL,
> -	       (HV_CRASH_CTL_CRASH_NOTIFY |
> HV_CRASH_CTL_CRASH_NOTIFY_MSG));
> -}
> -
> -static struct kmsg_dumper hv_kmsg_dumper =3D {
> -	.dump =3D hv_kmsg_dump,
> -};
> -
> -static void hv_kmsg_dump_register(void) -{
> -	int ret;
> -
> -	hv_panic_page =3D hv_alloc_hyperv_zeroed_page();
> -	if (!hv_panic_page) {
> -		pr_err("Hyper-V: panic message page memory allocation
> failed\n");
> -		return;
> -	}
> -
> -	ret =3D kmsg_dump_register(&hv_kmsg_dumper);
> -	if (ret) {
> -		pr_err("Hyper-V: kmsg dump register error 0x%x\n", ret);
> -		hv_free_hyperv_page((unsigned long)hv_panic_page);
> -		hv_panic_page =3D NULL;
> -	}
> -}
> -
> -static struct ctl_table_header *hv_ctl_table_hdr;
> -
> -/*
> - * sysctl option to allow the user to control whether kmsg data should b=
e
> - * reported to Hyper-V on panic.
> - */
> -static struct ctl_table hv_ctl_table[] =3D {
> -	{
> -		.procname       =3D "hyperv_record_panic_msg",
> -		.data           =3D &sysctl_record_panic_msg,
> -		.maxlen         =3D sizeof(int),
> -		.mode           =3D 0644,
> -		.proc_handler   =3D proc_dointvec_minmax,
> -		.extra1		=3D SYSCTL_ZERO,
> -		.extra2		=3D SYSCTL_ONE
> -	},
> -	{}
> -};
> -
>  /*
>   * vmbus_bus_init -Main vmbus driver initialization routine.
>   *
> @@ -1525,38 +1379,6 @@ static int vmbus_bus_init(void)
>  	if (ret)
>  		goto err_connect;
>=20
> -	if (hv_is_isolation_supported())
> -		sysctl_record_panic_msg =3D 0;
> -
> -	/*
> -	 * Only register if the crash MSRs are available
> -	 */
> -	if (ms_hyperv.misc_features &
> HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE) {
> -		u64 hyperv_crash_ctl;
> -		/*
> -		 * Panic message recording (sysctl_record_panic_msg)
> -		 * is enabled by default in non-isolated guests and
> -		 * disabled by default in isolated guests; the panic
> -		 * message recording won't be available in isolated
> -		 * guests should the following registration fail.
> -		 */
> -		hv_ctl_table_hdr =3D register_sysctl("kernel", hv_ctl_table);
> -		if (!hv_ctl_table_hdr)
> -			pr_err("Hyper-V: sysctl table register error");
> -
> -		/*
> -		 * Register for panic kmsg callback only if the right
> -		 * capability is supported by the hypervisor.
> -		 */
> -		hyperv_crash_ctl =3D
> hv_get_register(HV_REGISTER_CRASH_CTL);
> -		if (hyperv_crash_ctl & HV_CRASH_CTL_CRASH_NOTIFY_MSG)
> -			hv_kmsg_dump_register();
> -
> -		register_die_notifier(&hyperv_die_report_block);
> -		atomic_notifier_chain_register(&panic_notifier_list,
> -
> 	&hyperv_panic_report_block);
> -	}
> -
>  	/*
>  	 * Always register the vmbus unload panic notifier because we
>  	 * need to shut the VMbus channel connection on panic.
> @@ -1581,8 +1403,6 @@ static int vmbus_bus_init(void)
>  	}
>  err_setup:
>  	bus_unregister(&hv_bus);
> -	unregister_sysctl_table(hv_ctl_table_hdr);
> -	hv_ctl_table_hdr =3D NULL;
>  	return ret;
>  }
>=20
> @@ -2878,13 +2698,6 @@ static void __exit vmbus_exit(void)
>  	vmbus_free_channels();
>  	kfree(vmbus_connection.channels);
>=20
> -	if (ms_hyperv.misc_features &
> HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE) {
> -		kmsg_dump_unregister(&hv_kmsg_dumper);
> -		unregister_die_notifier(&hyperv_die_report_block);
> -		atomic_notifier_chain_unregister(&panic_notifier_list,
> -
> 	&hyperv_panic_report_block);
> -	}
> -
>  	/*
>  	 * The vmbus panic notifier is always registered, hence we should
>  	 * also unconditionally unregister it here as well.
> @@ -2892,9 +2705,6 @@ static void __exit vmbus_exit(void)
>  	atomic_notifier_chain_unregister(&panic_notifier_list,
>=20
> 	&hyperv_panic_vmbus_unload_block);
>=20
> -	free_page((unsigned long)hv_panic_page);
> -	unregister_sysctl_table(hv_ctl_table_hdr);
> -	hv_ctl_table_hdr =3D NULL;
>  	bus_unregister(&hv_bus);
>=20
>  	cpuhp_remove_state(hyperv_cpuhp_online);
> --
> 2.32.0

