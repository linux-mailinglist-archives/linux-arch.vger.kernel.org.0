Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 437DC7473F2
	for <lists+linux-arch@lfdr.de>; Tue,  4 Jul 2023 16:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbjGDOTh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Jul 2023 10:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjGDOTg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Jul 2023 10:19:36 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2132.outbound.protection.outlook.com [40.107.94.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38755E41;
        Tue,  4 Jul 2023 07:19:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KeyKYM1jNCUsykCr3MBRzmzd/ulTfb7aLqr8SHUJPfLgTX/mkVohcitnRI/Q0LTjLCkYhdY7gXHlYKe8Sgsva9reVhOlyyy4kmcRbqc8s22f6xx0lG4ndtw8qa9wQcyy5pXtrMRzNbjIxmsUeRPVvo6d622YU1zUqpodEPebsY31rs9TdQV/PS3QeKNnz+6XDeEFm+fXlOzp9iboYrk2MKysmUC21LAd4IQqhv/nVTc9+/z38a1Eh2gMJd5AIj/jk71UuZQLKwCGwT/HmWnnEeWDAbrnTMtO6pGtOO+0ZcZNFur4fs+9PPBhAE3yXwsLgBO9Z5G7TKPeUqHcg/nAPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8r89cw6x6o3aan3uHBjSF9a+MO6EykyaRJPFp3fYGzI=;
 b=dRBRFAN31DKbnuAgWallK6ixr7cU2pX+YLw3zofUU71ivWVI9o40BQHcjdKoIpJPprfliGQoFmM6lJt8UmIQEQosvtA4hpL4B3rR+MGnk7g58bSkiAsrPgml/demzsm0QKbRZ697B85pG44+hkfNpc89Ve2HYg5wXqgbtetAkPnItH7mcnPQ7sd00ULQJe2CA6EehlcqU6Qw03nE4jC9GTONAzwDktvE/tPkx87CXAzOjv3Gq7orf0zgcwrYh0rD1r17IaVm2t0LvaZHI0/h1WBL5Wiel5KAaTL1wal8+xoxIVtpN7Ya5G4+5DUoQSLHg08HU5bQxvTU85b3UGhvuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8r89cw6x6o3aan3uHBjSF9a+MO6EykyaRJPFp3fYGzI=;
 b=PjgG1sIWA1b4+kRS5ioQ3dZ1obrpk8hrn+naoZYn3btIXaH7V+XCN+zdM03k6XqFFts0kKyAlnv+jcpF8OmlktmxJ7UIstTOzr72qG68SBHJd/s5FK6Nm01hZR5Y2whFMh5M2CRy45b2r42jvsVfn/BO2yFAyJqYeIv5aZ6xjz8=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by CY5PR21MB3733.namprd21.prod.outlook.com (2603:10b6:930:d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.8; Tue, 4 Jul
 2023 14:19:32 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::4295:75a9:26d2:e64]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::4295:75a9:26d2:e64%5]) with mapi id 15.20.6588.006; Tue, 4 Jul 2023
 14:19:32 +0000
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
Subject: RE: [PATCH V2 4/9] drivers: hv: Mark percpu hvcall input arg page
 unencrypted in SEV-SNP enlightened guest
Thread-Topic: [PATCH V2 4/9] drivers: hv: Mark percpu hvcall input arg page
 unencrypted in SEV-SNP enlightened guest
Thread-Index: AQHZqKawEswy81hKaEC9zSZS+zSGUK+ps5nw
Date:   Tue, 4 Jul 2023 14:19:32 +0000
Message-ID: <BYAPR21MB16886841ADC253FDAF247DFFD72EA@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230627032248.2170007-1-ltykernel@gmail.com>
 <20230627032248.2170007-5-ltykernel@gmail.com>
In-Reply-To: <20230627032248.2170007-5-ltykernel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=88f7213c-0a2e-45e2-87f6-a5b29ae95380;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-07-04T14:18:49Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|CY5PR21MB3733:EE_
x-ms-office365-filtering-correlation-id: 8f590eea-bb5d-4ee0-8692-08db7c99afc1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +KUO00Ym1ol6BSoSlRhStyJ/NrOaPjJ5s8pIvnwKYcsjyXpRMY+Xq0cJ+uhvK5URd8Du5uywfXuPgkl/ksc5rb0CPAzEa3W+RMcq1+W0oxShRjarOcC6jFtRNaIR3Z4XEknh6ZdeUuA57AxCGRkPgag7W6cMEI8apIWN50keq86f6U+1Kst1VpLHWulnNHDmpLWNnxmBZKWBeIk+K6sTY4EI10rGVlkGjNWKOIVbgae77145GfngdpRZAsoFEyxSKTbA+BYLesQ1ZvoqtfXzotgH0ZH22wo8Lxfgqc2o/R32tdDKigNtjcNc86P9DsAeEwl7SiwL5qYZxP0Smg68P1fA7bSQo48pBcRCdIHifM6uac9N66RH+6r4X/wC9grjvcCfYq6dlhBEInzn6lQONbzQWnk2IOzRw3cE/v2Zi2ezu9zmKo/WVHsM9I8pNgmHtboNMWZyWwaZk63dYh7LS62ewbjSH1opTjAF8l8Z4p8WN3Xhmv+DQy4dcNVVsri6pRUTDpaGWbSgM1anIPIoNrOIRTwCH1hQY2s1Nwzpdo7kghCf0kxWuAAH9fYxl8GW6zBVQp+NTJCjGWMSeKQHgROoTSa4cM8nEGDSKtW3Pgeumh+HfckhGC/Cx3wSoO7KkjbNzbwrob82vooJCMrG/ZC47NgNIC2Dh/qyVjbRMEDDtJ7SdSPl9yKz3xUF5JgI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(376002)(346002)(396003)(366004)(451199021)(8676002)(8936002)(54906003)(110136005)(478600001)(26005)(9686003)(41300700001)(52536014)(33656002)(71200400001)(7416002)(2906002)(5660300002)(86362001)(7696005)(64756008)(316002)(66476007)(122000001)(55016003)(66556008)(76116006)(38100700002)(4326008)(66446008)(66946007)(38070700005)(921005)(8990500004)(82960400001)(82950400001)(6506007)(10290500003)(186003)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1+txPqNuJ9e9q0ZwtHJbByy9QpK9M8HpLgOGqaW/WnmOo7ElYKagVL2xEKBo?=
 =?us-ascii?Q?K1e6B951HDyMtU8U37Gv32NBFLo28DQ00IswbNdAkXjuA/RMHkXxYbHtTpUX?=
 =?us-ascii?Q?8rPkDZq/9HvCwhKUMSK+/It3u03mzDiup9nNFFo3wPdBk0ngJM5E2t2N4DDZ?=
 =?us-ascii?Q?qeJAEqgXsOrhKeJQSzHV4QnTidP1j29pCNyeF3Tnd3bgzzUn0vfzZUK/5YW9?=
 =?us-ascii?Q?flK8j4mzmUakXfnMqlprQShgWaPQx3mfJPkzPwcFplfEHc5RfTO5CKVbIIIJ?=
 =?us-ascii?Q?Wcvf+DYHSfqbSt68J5VonaKNYQPrysOD11lxKZzQPWP7Lg6gBxcGdzOEGlTj?=
 =?us-ascii?Q?gnmZPb3lZkxvn6dvmorIWov77YZHuj9bS4SeI7pQApGl8pKjs+hnmIPS7XyP?=
 =?us-ascii?Q?Oru+6qzz9RIWfUvy99q9otCs3w5qqdYCgZ6K+BAKu6bV5GLYeusOpVi6vxoj?=
 =?us-ascii?Q?fJ+Xyr/0j0yLm6u2LoJNjMrTp7smmBjWAULQv23zLVA2SMOJaymcx+mmAbak?=
 =?us-ascii?Q?8eTGDaLubOywz4wneIbiA/+BjO2qxbnNiKND6ogNigSRd2/hOY1uGwB7S575?=
 =?us-ascii?Q?dXHYQSLYsD2Knv7koV5+LjUj81O/e83O2u6Rw8cUEEDzF6nuM5CqDOZtV45Z?=
 =?us-ascii?Q?XF7kkEM4tMprtpyZU2a5V57g/Duze7+97gMf5QzQKUOYWRxpmJJh8JxP80Yj?=
 =?us-ascii?Q?ZELl4ClaRXyamir6Q7AyfrXC0O4QrkPkVYVuuv7fp5OLqNf71Hl1H4xiaD0W?=
 =?us-ascii?Q?2nRgr5XyHfp19mNB1T6q8yGz5HMkRjxCpTxxYwLgyJhfm7EVmAruKkF+Xz7N?=
 =?us-ascii?Q?pBxGijyNEee3PA+WIXXij2aL0mS1Wm6yttR3K/w92M/mOelr9YNnJcv8hW8W?=
 =?us-ascii?Q?5qYWqF55IQF4VcuEXyCscDRmusxyxKIA+9PuR5FQvr9SUX07dnh910ZJuxKf?=
 =?us-ascii?Q?SIqhhcYnWJ4dwQWm/zcMuvQgWoBTEb/lqBZ3Q9TWiEUH1A6IZ97NDGqyuzlE?=
 =?us-ascii?Q?EocBM86HbSWt4FFtMBflYf/IuVJ5vgtXZRfK9a4ghL2ehUqjChqsw5IxOApf?=
 =?us-ascii?Q?sX91BBHSBGR0RzQez6N3RiSfaAke6v1r9zyGWqZT9sW/FiW7K0gqq3yRM3cT?=
 =?us-ascii?Q?fKMSbBomJx8UAETtx2Xcvq0J9orBRbrafeMxPrLsvpBOKW57SvNaY7HF1wby?=
 =?us-ascii?Q?D3yKAonI/Dx4Nuyvck/EtY3o6APcro9vkNx7k2CTvwr5jL/3qeZVA+Wan1yf?=
 =?us-ascii?Q?pURnB9sS6HbUZhUfWFuUAnJlaRTsN2FRHbi+Qr6Nhfsr2AIPPpk9ae0xqWgD?=
 =?us-ascii?Q?/NJhjMzsXIdg66HSkVkrFJaHsxahXOQYbU8iffr458vg7nmnYzJSo+bzn82i?=
 =?us-ascii?Q?gLvH+ZLdAeWxClQCzcKXd5/nwgCau3TVppCAzNtAsxRJ3ve7ukMRr9vAfsQ5?=
 =?us-ascii?Q?fkWelrJZXzTQjf/qZSgVNqvSHr73Swqe9yeF3dIVM58lgMzt/rhchE/iWFxO?=
 =?us-ascii?Q?MPPOajde8mXu1pxjF4oDBKJtDN+aef27LQmq8/QEQl+D0zEwGsEXARo8Wb9Z?=
 =?us-ascii?Q?AY4c0gHNPJ9Q4mTTm/nz/cVnlIXe8UVcomTpJqp7hR9kR+MXo6WX5P4AdjlB?=
 =?us-ascii?Q?HQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f590eea-bb5d-4ee0-8692-08db7c99afc1
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2023 14:19:32.3326
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g5Qcpx7AOeDtBue9klkb0hcDXFm0LzjfLls/j1l/bGrwxvvr52Mqq5QzW3jua2ETakofvdd+zW6tNnlt/LPoU5SYZt4AR56CKqqDknDvACk=
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
> Hypervisor needs to access input arg, VMBus synic event and
> message pages. Mark these pages unencrypted in the SEV-SNP
> guest and free them only if they have been marked encrypted
> successfully.
>=20
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> ---
>  drivers/hv/hv.c        | 57 +++++++++++++++++++++++++++++++++++++++---
>  drivers/hv/hv_common.c | 13 ++++++++++
>  2 files changed, 67 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
> index de6708dbe0df..ec6e35a0d9bf 100644
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
> @@ -78,7 +79,7 @@ int hv_post_message(union hv_connection_id connection_i=
d,
>=20
>  int hv_synic_alloc(void)
>  {
> -	int cpu;
> +	int cpu, ret =3D -ENOMEM;
>  	struct hv_per_cpu_context *hv_cpu;
>=20
>  	/*
> @@ -123,26 +124,76 @@ int hv_synic_alloc(void)
>  				goto err;
>  			}
>  		}
> +
> +		if (hv_isolation_type_en_snp()) {
> +			ret =3D set_memory_decrypted((unsigned long)
> +				hv_cpu->synic_message_page, 1);
> +			if (ret) {
> +				pr_err("Failed to decrypt SYNIC msg page: %d\n", ret);
> +				hv_cpu->synic_message_page =3D NULL;
> +
> +				/*
> +				 * Free the event page here so that hv_synic_free()
> +				 * won't later try to re-encrypt it.
> +				 */
> +				free_page((unsigned long)hv_cpu->synic_event_page);
> +				hv_cpu->synic_event_page =3D NULL;
> +				goto err;
> +			}
> +
> +			ret =3D set_memory_decrypted((unsigned long)
> +				hv_cpu->synic_event_page, 1);
> +			if (ret) {
> +				pr_err("Failed to decrypt SYNIC event page: %d\n", ret);
> +				hv_cpu->synic_event_page =3D NULL;
> +				goto err;
> +			}
> +
> +			memset(hv_cpu->synic_message_page, 0, PAGE_SIZE);
> +			memset(hv_cpu->synic_event_page, 0, PAGE_SIZE);
> +		}
>  	}
>=20
>  	return 0;
> +
>  err:
>  	/*
>  	 * Any memory allocations that succeeded will be freed when
>  	 * the caller cleans up by calling hv_synic_free()
>  	 */
> -	return -ENOMEM;
> +	return ret;
>  }
>=20
>=20
>  void hv_synic_free(void)
>  {
> -	int cpu;
> +	int cpu, ret;
>=20
>  	for_each_present_cpu(cpu) {
>  		struct hv_per_cpu_context *hv_cpu
>  			=3D per_cpu_ptr(hv_context.cpu_context, cpu);
>=20
> +		/* It's better to leak the page if the encryption fails. */
> +		if (hv_isolation_type_en_snp()) {
> +			if (hv_cpu->synic_message_page) {
> +				ret =3D set_memory_encrypted((unsigned long)
> +					hv_cpu->synic_message_page, 1);
> +				if (ret) {
> +					pr_err("Failed to encrypt SYNIC msg page: %d\n", ret);
> +					hv_cpu->synic_message_page =3D NULL;
> +				}
> +			}
> +
> +			if (hv_cpu->synic_event_page) {
> +				ret =3D set_memory_encrypted((unsigned long)
> +					hv_cpu->synic_event_page, 1);
> +				if (ret) {
> +					pr_err("Failed to encrypt SYNIC event page: %d\n", ret);
> +					hv_cpu->synic_event_page =3D NULL;
> +				}
> +			}
> +		}
> +
>  		free_page((unsigned long)hv_cpu->synic_event_page);
>  		free_page((unsigned long)hv_cpu->synic_message_page);
>  	}
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index 4b4aa53c34c2..2d43ba2bc925 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -24,6 +24,7 @@
>  #include <linux/kmsg_dump.h>
>  #include <linux/slab.h>
>  #include <linux/dma-map-ops.h>
> +#include <linux/set_memory.h>
>  #include <asm/hyperv-tlfs.h>
>  #include <asm/mshyperv.h>
>=20
> @@ -359,6 +360,7 @@ int hv_common_cpu_init(unsigned int cpu)
>  	u64 msr_vp_index;
>  	gfp_t flags;
>  	int pgcount =3D hv_root_partition ? 2 : 1;
> +	int ret;
>=20
>  	/* hv_cpu_init() can be called with IRQs disabled from hv_resume() */
>  	flags =3D irqs_disabled() ? GFP_ATOMIC : GFP_KERNEL;
> @@ -378,6 +380,17 @@ int hv_common_cpu_init(unsigned int cpu)
>  			outputarg =3D (void **)this_cpu_ptr(hyperv_pcpu_output_arg);
>  			*outputarg =3D (char *)(*inputarg) + HV_HYP_PAGE_SIZE;
>  		}
> +
> +		if (hv_isolation_type_en_snp()) {
> +			ret =3D set_memory_decrypted((unsigned long)*inputarg, pgcount);
> +			if (ret) {
> +				kfree(*inputarg);
> +				*inputarg =3D NULL;
> +				return ret;
> +			}
> +
> +			memset(*inputarg, 0x00, pgcount * PAGE_SIZE);
> +		}
>  	}
>=20
>  	msr_vp_index =3D hv_get_register(HV_REGISTER_VP_INDEX);
> --
> 2.25.1

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

