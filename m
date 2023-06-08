Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6409B72828D
	for <lists+linux-arch@lfdr.de>; Thu,  8 Jun 2023 16:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236859AbjFHOVw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Jun 2023 10:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236034AbjFHOVv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 8 Jun 2023 10:21:51 -0400
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-centralusazon11020026.outbound.protection.outlook.com [52.101.61.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515202728;
        Thu,  8 Jun 2023 07:21:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JF9rV6S/pX9t2NlmKzo0n2e9HkqIJ/tMecVIUwibX1q+mHthNIGBUD/1J1g3B/WqHIgarveQ7DEPOzirlthbx7C/Oj5H2UK0bt2vzT+DnLbrbSF4dnbg5qvfQGSwF+O5ca9LwAJaxPnL7BybLJCjbBts09JIRc27itwtDekWhKpBJ0QVp5BvWNAh+D7lH4URbyN8JoR54VWcfOEqpuAU6gDIll6xOYGRJx97yRW5habFwG7WkA/CN2QqEhLbEJj9weB8joQErximzohGOYr7z/57oh1SscMijwI2XaRL0npi6u+sRJK/TAD/1YeH6UFqwMgR0igVJyaDZI0yp2Em2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7RwWcz+mvbVJkJgK5QF0qgYmBJ/xmSLkPx2AZ/+C/6Y=;
 b=Nh1NhlZRaEWmWEzyAAUqr+L1uI9fJ5DnjpUKVn1oGE2zZbRjDhM6Z+IHtKxwemS/Hzogw7Ye5HgNHyHFprfprTK8kCMg+hKYp2K6qncYfNxP/BjjZTQGxD/jUCplWEXdtxriWPmu0GVsw3OlBmvKgkEiexbj5dTFdJFcIkS28JW5zVuFk+ctdd5WUDkfwSfG6wW9S2R44CzKzuWAXhouDXXTyGF89wQDFfIc4Y2sS5DozSbWJgNJ/h9anIYUyDxTKto9X5A5ApWfpcbtwWaeyrppJgXoUHn9fP2FNLlUzT3qav2ggMgi8julBBWUt9pBw9uFrb3jTAooGnNGahaDDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7RwWcz+mvbVJkJgK5QF0qgYmBJ/xmSLkPx2AZ/+C/6Y=;
 b=N1Fm2FIj6TEM84Zgs05XQCz4qBti5V+80mFxH099jFO/8DWrimBAKIPDj1YL+wnfaDYRSDuq9VxH4lZfFuje49xo70jr7YhuCgMuZgegVo1svOnvcq093mKxGJH/fiTpsULqGtSMflBQf4IUAd28TH5ci1TL9/zebtH76YCB6ZA=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by LV2PR21MB3084.namprd21.prod.outlook.com (2603:10b6:408:17e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.0; Thu, 8 Jun
 2023 14:21:47 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::7d5d:3139:cf68:64b]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::7d5d:3139:cf68:64b%3]) with mapi id 15.20.6500.004; Thu, 8 Jun 2023
 14:21:47 +0000
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
Subject: RE: [PATCH 4/9] drivers: hv: Mark shared pages unencrypted in SEV-SNP
 enlightened guest
Thread-Topic: [PATCH 4/9] drivers: hv: Mark shared pages unencrypted in
 SEV-SNP enlightened guest
Thread-Index: AQHZlJwPTw3f3RN170SFVBSEj1BzNq+A8OOA
Date:   Thu, 8 Jun 2023 14:21:46 +0000
Message-ID: <BYAPR21MB1688ACF3B9C9D48790128A48D750A@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230601151624.1757616-1-ltykernel@gmail.com>
 <20230601151624.1757616-5-ltykernel@gmail.com>
In-Reply-To: <20230601151624.1757616-5-ltykernel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=f4d57aae-549a-4b6b-ac8d-55d7cf382fd0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-06-08T13:28:04Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|LV2PR21MB3084:EE_
x-ms-office365-filtering-correlation-id: 7967aa45-ad21-4e11-5f6b-08db682bb147
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BfGyLikCZcTvw2RG+dgon+n6/D7HjrV8hloB+F2ZRFufrn071Z2BtchWNGHZLvR0bfDRdgvs90fP3bheCEZSPjn1QS5Z0oHIW/8Qv9FMlG0qwzHEpZfIFDznVSVvomiXwG1maLEComjsjX1/Ou1xMO325L/QqhqHgv/2duuKsUgeQJBh4Z2ewsDKngBLRww97rSceEYd85sjGnkEtd4ukH2dTk61Zvz2waWdpFBWFLt0+7y6pR7vSRS6cuuJ3VASyU9wENNVrSm8hEuDx/9JyAm4CVDpgz2AjxvP/NDDIM2q5NoXfirfFrW//VOlqPCV4KDeuhyXNh2C7zXBANpXtE6cuc/0LpF/vOl/aRqINOnHPReDJMai0gJBdcoX3UYFC3zYGVgdGabnm2vd1V4bS3gLFXGiyYqf0aKxStFRAYcmtmSp825aAY3yqBiQeIz7YZRv7iiDrwsyd8TwlOcnSoICAZ0t1JN9cyWncDXPi65/lgtszsFLBSTVVSbumoyxDUyv7CLC5qzP3Bgg0ZhIVix7ZBGlTlgAQeer9IHYz6CCyCgFfvV+aasJA7arWn6iMmbI61msPTHjmw2UIr/p5nq8Xy1USrl6QOl/DMI8vpajIJo/2KFsrlgIvw8bCeekNqhkWun21KUppQxY3N0ICh/0YPFmxTzU3IwRkDsKWxJjvCpJBpaxAgV7RRflK5bD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(346002)(366004)(376002)(451199021)(316002)(41300700001)(110136005)(5660300002)(7416002)(54906003)(921005)(82960400001)(82950400001)(122000001)(52536014)(10290500003)(4326008)(64756008)(66946007)(66476007)(66556008)(66446008)(76116006)(8936002)(8676002)(478600001)(71200400001)(38070700005)(7696005)(2906002)(8990500004)(86362001)(38100700002)(186003)(55016003)(9686003)(33656002)(6506007)(26005)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tQtoaCYfNRI5skq7EylbEgiBr34lq7sVGTgCJyRHa67DPn+0f0wujXV6QXPa?=
 =?us-ascii?Q?8JmH3kP3BKa3gQYH0jdpxy4Kqy9ihQgbbW+tnwAv7Y04P1mfWXAcY83On33f?=
 =?us-ascii?Q?DMHtP1DDnB9Vc7jW+FYKE8e+kWOgJZkUaBjwAWCj3uTyQga30SLuP2F5Yhkf?=
 =?us-ascii?Q?8JxqtbMeLxewyLN4n7chcijR49SV9xRwmEEaq6iUhuSGoQENBFdN3m4nBjjs?=
 =?us-ascii?Q?0XzvRAjiQMQJVdyTzT6s64D0jqhyKqYmhOOSiuTcdMm5HvbYxoYo6NHRW7Xw?=
 =?us-ascii?Q?cnKXwBqLnAMojzBu03dJkQH+xisB1Cd/Y0of2sZ0AzTkL/6tcQz3eqP6DVZF?=
 =?us-ascii?Q?3zwE+kE9CvEqKpL8/lP1glk/tfuQwdaXmby/zB/6rXhLma25nYQbVOKExvre?=
 =?us-ascii?Q?TBEcj/Fhu63bgX9Owx5aL77tO+dvZUpa43vHg/JVnoMOcaGTaZfLvdkTXmAm?=
 =?us-ascii?Q?vy+4v5xuUx16HGe2+2Um1jazBrNBbVsw5AkVMFEWIynq0HkFle5iDRRW+bs2?=
 =?us-ascii?Q?ummTvzTV2IhYxtXu6blvaecA4Ym1SewWDAHkKEtVEQ11Tk6aYEuxK+80gcuz?=
 =?us-ascii?Q?I+Sl4MbsCPr8RcuyLxzQmRc1Zu0aG0hL2thRUH/tjuBnzMUJeZUdT1YwQvKY?=
 =?us-ascii?Q?xbTb3as/BS7GO5x5mOU4q3xqZ2+nIMmsUcmXpDrb+0JCm0wfva91MYfeEylh?=
 =?us-ascii?Q?7Og62ZfTBtp8H7AlMSlnd1NEUZsg2LeiOymRi6pufs1/5WzAFG5smj9LnzTa?=
 =?us-ascii?Q?wWUgE1MyfyqWE40K9o/EunV/aOmOyIXpbDdBEIejHgLWZeGZSv45KjSmYhVZ?=
 =?us-ascii?Q?HPWNgyF+oIddGnk9WrL6L4ggko1+7CTumphGMhnuL4C2pFEuCMEncRvtXNwe?=
 =?us-ascii?Q?ZdtMDIjxDuDl5PPgn0Z2Hnm/ggG9/KW+Y954g2ZujlZoSsFydkyjCF832zl6?=
 =?us-ascii?Q?7TAFt8vIXIz1p/r5nOpDkTATJFseEmdm3RItvn940/v4PnlbhxzP12CDRA3v?=
 =?us-ascii?Q?Eqe1aXXIeVzpWoXRwnFL42sKGnvyYhTCyU3u95Cr7mxAQcwYCqhTUVQS+JBA?=
 =?us-ascii?Q?xS6mpFC39PzdNVmXrh82Gto40viA7g9uPE5a0b8OKgBqipmcnyJiyr8W/78T?=
 =?us-ascii?Q?Z3An5HFjaMu9+52NUAZtD2ReZkUFYCuDmOTJ9QsXG6aU6+rChaGYLjeqOHNY?=
 =?us-ascii?Q?07M+RQuOVYxh6SIFi9LCfLgyYiOOicHsleews++6jXQuuR/Y0Gnbi64tSZOp?=
 =?us-ascii?Q?4VLxaQi54oZNs5aPO+SsEffH6hv5CGKYYRQQwqZQIAc21sxFWT96g2edzNiJ?=
 =?us-ascii?Q?ZpgaNcQOpAXCG7MYhP8nFKbXMyy1XAkGgau2Gz2FnPqbr8FeZNwp2AW3wvbi?=
 =?us-ascii?Q?K5RpMfmW2Lv1S/zfh7Mtp1SZpB3xg0xwXECxqihy+cGwctu108BLxHvbWRFW?=
 =?us-ascii?Q?q8xYq1NS/a7+dZ3BsnI+vQSRwduLgWOxZlbCwSWVzAN+YStdU83SZDkt6zL5?=
 =?us-ascii?Q?EDVI6UiGb+asvZDcJ2YyP83caCs2C2u0FzqMA0qQ/OK4ONDwo4Dn7Lu0dr5e?=
 =?us-ascii?Q?4VZ6XNyfvomOCIcYY9wCcFrnaVmitG//BxMoHn7Qjp6je76dTuSGlcajtETN?=
 =?us-ascii?Q?aw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7967aa45-ad21-4e11-5f6b-08db682bb147
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2023 14:21:47.0183
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aj4iXLBMyGqjFq6m+ogBITEQIAfBBNDDQ+9ZQAjYv89Kp61BGoKrde3u196tjt+L/7vjZWXol1jgDfsrcqLjIBPt2G4b4P8AFxudAIc3VgE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR21MB3084
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Tianyu Lan <ltykernel@gmail.com> Sent: Thursday, June 1, 2023 8:16 AM
>=20
> Hypervisor needs to access iput arg, VMBus synic event and

s/iput/input/

> message pages. Mask these pages unencrypted in the sev-snp

s/Mask/Mark/

> guest and free them only if they have been marked encrypted
> successfully.
>=20
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> ---
>  drivers/hv/hv.c        | 57 +++++++++++++++++++++++++++++++++++++++---
>  drivers/hv/hv_common.c | 24 +++++++++++++++++-
>  2 files changed, 77 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
> index de6708dbe0df..94406dbe0df0 100644
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
> +				 * Free the event page here and not encrypt
> +				 * the page in hv_synic_free().
> +				 */

Let's tweak the wording of the comment:

				/*
				 * Free the event page here so that hv_synic_free()
				 * won't later try to re-encrypt it.
				 */

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
> index 179bc5f5bf52..bed9aa6ac19a 100644
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
> @@ -368,6 +370,17 @@ int hv_common_cpu_init(unsigned int cpu)
>  	if (!(*inputarg))
>  		return -ENOMEM;
>=20
> +	if (hv_isolation_type_en_snp()) {
> +		ret =3D set_memory_decrypted((unsigned long)*inputarg, pgcount);
> +		if (ret) {
> +			kfree(*inputarg);
> +			*inputarg =3D NULL;
> +			return ret;
> +		}
> +
> +		memset(*inputarg, 0x00, pgcount * PAGE_SIZE);
> +	}
> +
>  	if (hv_root_partition) {
>  		outputarg =3D (void **)this_cpu_ptr(hyperv_pcpu_output_arg);
>  		*outputarg =3D (char *)(*inputarg) + HV_HYP_PAGE_SIZE;
> @@ -387,7 +400,9 @@ int hv_common_cpu_die(unsigned int cpu)
>  {
>  	unsigned long flags;
>  	void **inputarg, **outputarg;
> +	int pgcount =3D hv_root_partition ? 2 : 1;
>  	void *mem;
> +	int ret;
>=20
>  	local_irq_save(flags);
>=20
> @@ -402,7 +417,14 @@ int hv_common_cpu_die(unsigned int cpu)
>=20
>  	local_irq_restore(flags);
>=20
> -	kfree(mem);
> +	if (hv_isolation_type_en_snp()) {
> +		ret =3D set_memory_encrypted((unsigned long)mem, pgcount);
> +		if (ret)
> +			pr_warn("Hyper-V: Failed to encrypt input arg on cpu%d: %d\n",
> +				cpu, ret);
> +		/* It's unsafe to free 'mem'. */
> +		return 0;
> +	}
>=20
>  	return 0;
>  }
> --
> 2.25.1

