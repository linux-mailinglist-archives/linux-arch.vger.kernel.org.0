Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9010C6DFD5A
	for <lists+linux-arch@lfdr.de>; Wed, 12 Apr 2023 20:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjDLST6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 Apr 2023 14:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjDLST5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Apr 2023 14:19:57 -0400
Received: from DM5PR00CU002.outbound.protection.outlook.com (mail-centralusazon11021026.outbound.protection.outlook.com [52.101.62.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1982B7;
        Wed, 12 Apr 2023 11:19:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j4Gz/LALwFHtj52hiK3ZzyR8tmWzxHSSK4axhjXbutIJubEKgQX78iPq9DCJJAy0pQYZcTIJNCECyKL0mTZZhGs9RmLewtWCYvu+tGCPM5lFRAqSIaSHJkNseTZ4Jp4pnIe/MDz2Ez2GLSy3Soh1kNrYjJMdGd0mNd1Oz1gE0Rw0vrfI61H/qOG164M5Xs5BNaHhY3W4RXZ5YbEp6Dc4WkR/T7Jczt6hfDkDLVgWvpBMdlsIZm0iJbV3TQlO7rczEZl4IWkMh5zNmz9VMMtw3f9VzKUjDsDFX1DYFl75ybkFgAc5v2+3GsfJPmAMoHEW0vXei8p5UfZXxGNtfOnFew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kcnr7bHuYd55FwpfndRUTaYvk2EGoEoC+vLCCI9/3k4=;
 b=mwAoq2gDeCjUGrRWc+zQ8bUu2kZCGncAiwKtoA1n3pmMajqemoNhK+FF03HgmQVOOYFEyIj6ZAq3sFuJ749skn2GdVKLl83OKX8tqZFMLAFWrQ13XLtla49pbSiq7bPZFvWyi8jCvzCdlamauVWRKImd3b6S0N1xNzOeL2w0ykXVitwDcWLhscUBJMjN/1NFNL229c4ANORRXXvO6Ln9B91TUrVTBr1Y7JcNXOQ/QYgptWAvOvB5lhzt9SHjsuexf6pI3bLmNFPsP5+ccnNDFwhBswcfn0KZh+mek30JiGo/Xq6xt/rkyrOSvsut0FWKLB4YQyainY/jlShCz+U9cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kcnr7bHuYd55FwpfndRUTaYvk2EGoEoC+vLCCI9/3k4=;
 b=b19WByc3fbXyUVqou61Khz5y2APfAIPMy6zJDkSX8GBh0ZYlym8uuy3AXtOxUpEcFI7+wT1XVYNeaUegcWB6SxXWNTe36/IYq1rDfWlIBrSmSW7n6YldlS8lVrZdUigcrBiaykk7YcIqR7ZhTtAjAJgEPGvJblWycoeCusmzE7w=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by DM4PR21MB3755.namprd21.prod.outlook.com (2603:10b6:8:a0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.4; Wed, 12 Apr
 2023 18:19:50 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::acd0:6aec:7be2:719c]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::acd0:6aec:7be2:719c%7]) with mapi id 15.20.6319.004; Wed, 12 Apr 2023
 18:19:50 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Arnd Bergmann <arnd@arndb.de>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Long Li <longli@microsoft.com>
Subject: RE: [PATCH] Drivers: hv: move panic report code from vmbus to hv
 early init code
Thread-Topic: [PATCH] Drivers: hv: move panic report code from vmbus to hv
 early init code
Thread-Index: AQHZbBrIXKpVmEbp0USJTDlm/9VdPa8n+GKQ
Date:   Wed, 12 Apr 2023 18:19:50 +0000
Message-ID: <BYAPR21MB168862BDB7C49AFB7E611E89D79B9@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <1681179010-17811-1-git-send-email-longli@linuxonhyperv.com>
In-Reply-To: <1681179010-17811-1-git-send-email-longli@linuxonhyperv.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=41bb7049-8d4b-4340-bc3f-040c1f13f879;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-04-12T17:57:50Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|DM4PR21MB3755:EE_
x-ms-office365-filtering-correlation-id: 989d7009-fc63-4e25-8258-08db3b82813d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sFCrWQNESaMDw521fXtJnUYS6hRAex1XSLquC9j8WoWVR5EPqEnw514V5dsqaHFBOL9W3Q21uzMYbjfBh++bvTnRoBwL0Z051KYkHJYNcMZC+Mel1NdWF1WfuoS76vgHfUoikmbNVruu3WNU7InRNx80Q8y87SeU1KGIRVGpzP+WVnxlimOOUfJis4kwpxRiQ1EgQ9GP+u50HGkGdY1RLdH4MwxBNahPawrSgip9iTdmt5/6/IDADZJtDxFXktNH4yecPzSklLnw17VXPhvr4oMV/lWgNAOPmxU7ZU7Q0pfg4/HNpsPoSNEOBeMAYVf27mQsZqvCHFvYY0G3DwIjWfSUdQyTsQjixD4Vnohirfrsbz6HuYx9o5M+E/0pE76+J68DeIyAU91C95PPZqdhmgZk1OX3vHiOsxILbe5v/8mPEt17PwoZkW+Uk7jn58OKz2yn5n5EoRHdJd4deZYI+WU9L4USRPxAS5danA8ccMWjol1G88vi71Gs3HO1pCfTu66wrEFNRXrnfL13MPJWRO6MVKqMwx1Ytiket9sDrHhng4aL+BAiatMgr9XR+DIFKX36a/uEwcIYayNkIA4jovm07MD4ghrNlaXGIjGOUNIpcdzA9gtGuT4DrEU26XAwY0yEcFymH7iFrZaOqowZ73TQO89YtG+r5+azyfvB5lY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:cs;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(366004)(346002)(376002)(451199021)(10290500003)(478600001)(316002)(110136005)(38100700002)(122000001)(54906003)(82960400001)(82950400001)(83380400001)(9686003)(107886003)(186003)(26005)(55016003)(6506007)(33656002)(71200400001)(7696005)(41300700001)(8936002)(8676002)(38070700005)(64756008)(66446008)(66476007)(66556008)(4326008)(8990500004)(76116006)(66946007)(2906002)(786003)(30864003)(86362001)(52536014)(5660300002)(579004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NPCb2ZFfVlK8AQturFKBmBV49umKrVkZC7wcMBYc0I9O+L3ZJiSVaAu2s9/o?=
 =?us-ascii?Q?Tt6fAhoR9gxcEIaXALmmyGFWhUS4NGwQWDfBfE97G2SIazTpHm+1JlGCmB5k?=
 =?us-ascii?Q?A6k7yE+pt+aqonq4b5htO4oHOqfL1OPlEN5gVC6OXnnFrzbNjCK5IFoGB+Nn?=
 =?us-ascii?Q?ns7CSTCNWL90IV5Mog0U0MBs5LvjMEq1p2KD4CUvcNWu4ESUUi9d6PqVF3zY?=
 =?us-ascii?Q?kl7r8fBG4924YEC2TdYwDJ97F4FYtsLUmwCGGJZpF4+HTVlVqzyQ9osvlTJS?=
 =?us-ascii?Q?zyvanPEbnHhEaOpJPmE+7fPGm2F3/EfOjtp/N0RniKe0UDSlvKgyj+Z4QROG?=
 =?us-ascii?Q?G3d1fTwnaUW8tRB3DdZwJGx0oSYIUGfMt5VOCgmWzD3Iv+kpi5ir7sitMRYx?=
 =?us-ascii?Q?6FFq2bEFk9Is5CwO/HcMmIqQbXnyFo4QxRPjS1DX+7RiDod1v76PRa7HLPhV?=
 =?us-ascii?Q?wi+fOTCu8QQaU9ap+JgV7bXb8xrkqg1AG2BbJr0QpBeQFuav/zajcR3dcTuN?=
 =?us-ascii?Q?tRXdpn7s8+5F8VPQEhh9T7QgcphkcPFbHC+qopPF9+aftMQDiKeyQbaM+Wag?=
 =?us-ascii?Q?3IgQCFaJQN3VbtWh36QNId43cp4D/Q9g3sk5Oe0Tzlo6SNjvC0+8xCIQ75Um?=
 =?us-ascii?Q?I0wk4jQM4v56gAuveWIGbSRj45NEaMB/g4jY6+PUuppMLYYngSlTB3nHwL7s?=
 =?us-ascii?Q?+VLMSsjvSlSYh7UWuQkKKx05izX1Tw+rI/wEQJqGcMzTMQcve1EshSZII4se?=
 =?us-ascii?Q?usy1dYgDl2FHNNvfl3bBzlFZ5TWJw9RyOw+EdnmniPxBgoFGfe4cVVknUloG?=
 =?us-ascii?Q?Cyu5uWEHkxRCBy6r68L2l9oO/2nPu8xfFHM2q6/N7EAutbmlVVQTyHwwfkdJ?=
 =?us-ascii?Q?s5Y+HrfzpIga68WBtk+S7zJaaSWxlQG1ELxo4uRZ1aDTintmxoh3JyDMY/Lz?=
 =?us-ascii?Q?AfMBW0ldL0d9tj1ax06/8gsWVHJpOSudfrmaIQrwe+q+cb2LtLS6ZsG+0H61?=
 =?us-ascii?Q?z1oZprpKcS3j/Wh+rOu8tJHAM5Lp455oZKTeczhAt0NFrLWw+TjUBOJ1stmr?=
 =?us-ascii?Q?Aa32WP5R7ARMpNO69jev8jOb/oFykiM8Bsu18FAOPYwsy5NctW+zYXyNQDmb?=
 =?us-ascii?Q?q2Eof7/qaIQ5RLIdUTlX1Phy4szLzbmY6bti5JJBK7v4Rfyg7c8y3gmGSXRX?=
 =?us-ascii?Q?f50pt2wW1dGWdIMdExdLr21W4O0W9BjJDxTcdTWvfr9JToF4SeiPypzbPuJc?=
 =?us-ascii?Q?Gnc5MpJlCURDFSwxOqSTsaMJPakUQ7ioCYbDuksC9qKavfric+KDA4rzRQcu?=
 =?us-ascii?Q?9p9799u0sGmbA/Ty1xtE9HCIXdQtD5qEpVgAXfiwTPW7HOgmUUQegHdGcYAu?=
 =?us-ascii?Q?BBSBqQHgNuRt8BcMAYjC2X5l68C34jm7f0qqf64144EUe0d8P11JFwEMgVIm?=
 =?us-ascii?Q?0ixc3Xx5BDMtwWe+f0n8rVHJUUAO6eOz0o6x9ja35wBNKPR33Brwphx3JUNh?=
 =?us-ascii?Q?S6+aBgrNVgtSO8m+yp5vyp/dytSDZtENqylumlh6mQwS+4HGnnZcY5kxWQC8?=
 =?us-ascii?Q?LC1eUJTBMUJAo2BQPvHxxcUle4XhmyKwxjG7o8UWxXFe22gQf2fPeUk0x7hD?=
 =?us-ascii?Q?uw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 989d7009-fc63-4e25-8258-08db3b82813d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2023 18:19:50.3079
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VUtTy84adznwFvuzj0KDjZVF1LbGekC6qw/j9z9m4UtHaUVU7JijTVSv5FdsBj54KYsw2h6Kz4g2Eo+E2Yw+6y4kTrav/CZ9r6+MwnU8S+k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR21MB3755
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: longli@linuxonhyperv.com <longli@linuxonhyperv.com> Sent: Monday, Apr=
il 10, 2023 7:10 PM
>=20
> The panic reporting code was added in commit 81b18bce48af
> ("Drivers: HV: Send one page worth of kmsg dump over Hyper-V during panic=
")
>=20
> It was added to the vmbus driver. The panic reporting has no dependence
> on vmbus, and can be enabled at an earlier boot time when Hyper-V is
> initialized.
>=20
> This patch moves the panic reporting code out of vmbus. There is no
> functionality changes. During moving, also refactored some cleanup
> functions into hv_kmsg_dump_unregister(), and removed unused function
> hv_alloc_hyperv_page().
>=20
> Signed-off-by: Long Li <longli@microsoft.com>
> ---
>  drivers/hv/hv.c                |  36 ------
>  drivers/hv/hv_common.c         | 227 +++++++++++++++++++++++++++++++++
>  drivers/hv/vmbus_drv.c         | 186 ---------------------------
>  include/asm-generic/mshyperv.h |   1 -
>  4 files changed, 227 insertions(+), 223 deletions(-)
>=20
> diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
> index 8b0dd8e5244d..88eca08c7030 100644
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
> -void hv_free_hyperv_page(unsigned long addr)
> -{
> -	if (PAGE_SIZE =3D=3D HV_HYP_PAGE_SIZE)
> -		free_page(addr);
> -	else
> -		kfree((void *)addr);
> -}
> -
>  /*
>   * hv_post_message - Post a message using the hypervisor message IPC.
>   *
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index 52a6f89ccdbd..d696c2110349 100644
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
>  EXPORT_SYMBOL_GPL(hyperv_pcpu_output_arg);
>=20
> +static void hv_kmsg_dump_unregister(void);
> +
> +static struct ctl_table_header *hv_ctl_table_hdr;
> +
>  /*
>   * Hyper-V specific initialization and shutdown code that is
>   * common across all architectures.  Called from architecture
> @@ -62,6 +69,12 @@ EXPORT_SYMBOL_GPL(hyperv_pcpu_output_arg);
>=20
>  void __init hv_common_free(void)
>  {
> +	unregister_sysctl_table(hv_ctl_table_hdr);
> +	hv_ctl_table_hdr =3D NULL;
> +
> +	if (ms_hyperv.misc_features & HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE)
> +		hv_kmsg_dump_unregister();
> +
>  	kfree(hv_vp_index);
>  	hv_vp_index =3D NULL;
>=20
> @@ -72,6 +85,195 @@ void __init hv_common_free(void)
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
> +void *hv_alloc_hyperv_zeroed_page(void)
> +{
> +	if (PAGE_SIZE =3D=3D HV_HYP_PAGE_SIZE)
> +		return (void *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
> +	else
> +		return kzalloc(HV_HYP_PAGE_SIZE, GFP_KERNEL);
> +}
> +EXPORT_SYMBOL_GPL(hv_alloc_hyperv_zeroed_page);
> +
> +void hv_free_hyperv_page(unsigned long addr)
> +{
> +	if (PAGE_SIZE =3D=3D HV_HYP_PAGE_SIZE)
> +		free_page(addr);
> +	else
> +		kfree((void *)addr);
> +}
> +EXPORT_SYMBOL_GPL(hv_free_hyperv_page);
> +
> +static void *hv_panic_page;
> +static int sysctl_record_panic_msg =3D 1;
> +
> +static int hyperv_report_reg(void)
> +{
> +	return !sysctl_record_panic_msg || !hv_panic_page;
> +}

Nit:  The above function is used in only one place.  The code could
easily just go inline.  Putting the code inline would probably be
clearer anyway.

> +
> +static int hv_die_panic_notify_crash(struct notifier_block *self,
> +				     unsigned long val, void *args);
> +
> +static struct notifier_block hyperv_die_report_block =3D {
> +	.notifier_call =3D hv_die_panic_notify_crash,
> +};
> +
> +static struct notifier_block hyperv_panic_report_block =3D {
> +	.notifier_call =3D hv_die_panic_notify_crash,
> +};
> +
> +/*
> + * The following callback works both as die and panic notifier; its
> + * goal is to provide panic information to the hypervisor unless the
> + * kmsg dumper is used [see hv_kmsg_dump()], which provides more
> + * information but isn't always available.
> + *
> + * Notice that both the panic/die report notifiers are registered only
> + * if we have the capability HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE set.
> + */
> +static int hv_die_panic_notify_crash(struct notifier_block *self,
> +				     unsigned long val, void *args)
> +{
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
> +	if (hyperv_report_reg())
> +		hyperv_report_panic(regs, val, is_die);
> +
> +	return NOTIFY_DONE;
> +}
> +
> +/*
> + * Callback from kmsg_dump. Grab as much as possible from the end of the=
 kmsg
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
> +	 * Write dump contents to the page. No need to synchronize; panic shoul=
d
> +	 * be single-threaded.
> +	 */
> +	kmsg_dump_rewind(&iter);
> +	kmsg_dump_get_buffer(&iter, false, hv_panic_page, HV_HYP_PAGE_SIZE,
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
> +	hv_set_register(HV_REGISTER_CRASH_P3, virt_to_phys(hv_panic_page));
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
> +static void hv_kmsg_dump_unregister(void)
> +{
> +	kmsg_dump_unregister(&hv_kmsg_dumper);
> +	unregister_die_notifier(&hyperv_die_report_block);
> +	atomic_notifier_chain_unregister(&panic_notifier_list,
> +					 &hyperv_panic_report_block);
> +
> +	if (hv_panic_page) {

No need to explicitly test for NULL.  hv_free_hyperv_page() handles that
case already.

> +		hv_free_hyperv_page((unsigned long)hv_panic_page);
> +		hv_panic_page =3D NULL;
> +	}
> +}
> +
> +static void hv_kmsg_dump_register(void)
> +{
> +	int ret;
> +
> +	hv_panic_page =3D hv_alloc_hyperv_zeroed_page();
> +	if (!hv_panic_page) {
> +		pr_err("Hyper-V: panic message page memory allocation failed\n");
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
> +/*
> + * sysctl option to allow the user to control whether kmsg data should b=
e
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
> +static struct ctl_table hv_root_table[] =3D {
> +	{
> +		.procname	=3D "kernel",
> +		.mode		=3D 0555,
> +		.child		=3D hv_ctl_table
> +	},
> +	{}
> +};
> +
>  int __init hv_common_init(void)
>  {
>  	int i;
> @@ -84,8 +286,33 @@ int __init hv_common_init(void)
>  	 * kernel.
>  	 */
>  	if (ms_hyperv.misc_features & HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE) {
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
> +		hv_ctl_table_hdr =3D register_sysctl_table(hv_root_table);
> +		if (!hv_ctl_table_hdr)
> +			pr_err("Hyper-V: sysctl table register error");
> +
> +		/*
> +		 * Register for panic kmsg callback only if the right
> +		 * capability is supported by the hypervisor.
> +		 */
> +		hyperv_crash_ctl =3D hv_get_register(HV_REGISTER_CRASH_CTL);
> +		if (hyperv_crash_ctl & HV_CRASH_CTL_CRASH_NOTIFY_MSG)
> +			hv_kmsg_dump_register();
> +
> +		register_die_notifier(&hyperv_die_report_block);
> +		atomic_notifier_chain_register(&panic_notifier_list,
> +					       &hyperv_panic_report_block);
>  	}
>=20
>  	/*
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index d24dd65b33d4..96fb596ab68f 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -28,7 +28,6 @@
>  #include <linux/panic_notifier.h>
>  #include <linux/ptrace.h>
>  #include <linux/screen_info.h>
> -#include <linux/kdebug.h>
>  #include <linux/efi.h>
>  #include <linux/random.h>
>  #include <linux/kernel.h>
> @@ -63,11 +62,6 @@ int vmbus_interrupt;
>   */
>  static int sysctl_record_panic_msg =3D 1;
>=20
> -static int hyperv_report_reg(void)
> -{
> -	return !sysctl_record_panic_msg || !hv_panic_page;
> -}
> -
>  /*
>   * The panic notifier below is responsible solely for unloading the
>   * vmbus connection, which is necessary in a panic event.
> @@ -88,54 +82,6 @@ static struct notifier_block hyperv_panic_vmbus_unload=
_block =3D
> {
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
> - * if we have the capability HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE set.
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
>  static const char *fb_mmio_name =3D "fb_range";
>  static struct resource *fb_mmio;
>  static struct resource *hyperv_mmio;
> @@ -1377,98 +1323,6 @@ static irqreturn_t vmbus_percpu_isr(int irq, void =
*dev_id)
>  	return IRQ_HANDLED;
>  }
>=20
> -/*
> - * Callback from kmsg_dump. Grab as much as possible from the end of the=
 kmsg
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
> -	 * Write dump contents to the page. No need to synchronize; panic shoul=
d
> -	 * be single-threaded.
> -	 */
> -	kmsg_dump_rewind(&iter);
> -	kmsg_dump_get_buffer(&iter, false, hv_panic_page, HV_HYP_PAGE_SIZE,
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
> -	hv_set_register(HV_REGISTER_CRASH_P3, virt_to_phys(hv_panic_page));
> -	hv_set_register(HV_REGISTER_CRASH_P4, bytes_written);
> -
> -	/*
> -	 * Let Hyper-V know there is crash data available along with
> -	 * the panic message.
> -	 */
> -	hv_set_register(HV_REGISTER_CRASH_CTL,
> -	       (HV_CRASH_CTL_CRASH_NOTIFY | HV_CRASH_CTL_CRASH_NOTIFY_MSG));
> -}
> -
> -static struct kmsg_dumper hv_kmsg_dumper =3D {
> -	.dump =3D hv_kmsg_dump,
> -};
> -
> -static void hv_kmsg_dump_register(void)
> -{
> -	int ret;
> -
> -	hv_panic_page =3D hv_alloc_hyperv_zeroed_page();
> -	if (!hv_panic_page) {
> -		pr_err("Hyper-V: panic message page memory allocation failed\n");
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
> -static struct ctl_table hv_root_table[] =3D {
> -	{
> -		.procname	=3D "kernel",
> -		.mode		=3D 0555,
> -		.child		=3D hv_ctl_table
> -	},
> -	{}
> -};
> -
>  /*
>   * vmbus_bus_init -Main vmbus driver initialization routine.
>   *
> @@ -1535,35 +1389,6 @@ static int vmbus_bus_init(void)
>  	if (hv_is_isolation_supported())
>  		sysctl_record_panic_msg =3D 0;

The above two lines of code should move as well.  Otherwise we have a
window during early boot where the panic message might be dumped
to the Hyper-V host in a CVM.

>=20
> -	/*
> -	 * Only register if the crash MSRs are available
> -	 */
> -	if (ms_hyperv.misc_features & HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE) {
> -		u64 hyperv_crash_ctl;
> -		/*
> -		 * Panic message recording (sysctl_record_panic_msg)
> -		 * is enabled by default in non-isolated guests and
> -		 * disabled by default in isolated guests; the panic
> -		 * message recording won't be available in isolated
> -		 * guests should the following registration fail.
> -		 */
> -		hv_ctl_table_hdr =3D register_sysctl_table(hv_root_table);
> -		if (!hv_ctl_table_hdr)
> -			pr_err("Hyper-V: sysctl table register error");
> -
> -		/*
> -		 * Register for panic kmsg callback only if the right
> -		 * capability is supported by the hypervisor.
> -		 */
> -		hyperv_crash_ctl =3D hv_get_register(HV_REGISTER_CRASH_CTL);
> -		if (hyperv_crash_ctl & HV_CRASH_CTL_CRASH_NOTIFY_MSG)
> -			hv_kmsg_dump_register();
> -
> -		register_die_notifier(&hyperv_die_report_block);
> -		atomic_notifier_chain_register(&panic_notifier_list,
> -						&hyperv_panic_report_block);
> -	}
> -
>  	/*
>  	 * Always register the vmbus unload panic notifier because we
>  	 * need to shut the VMbus channel connection on panic.
> @@ -1588,8 +1413,6 @@ static int vmbus_bus_init(void)
>  	}
>  err_setup:
>  	bus_unregister(&hv_bus);
> -	unregister_sysctl_table(hv_ctl_table_hdr);
> -	hv_ctl_table_hdr =3D NULL;
>  	return ret;
>  }
>=20
> @@ -2818,13 +2641,6 @@ static void __exit vmbus_exit(void)
>  	vmbus_free_channels();
>  	kfree(vmbus_connection.channels);
>=20
> -	if (ms_hyperv.misc_features & HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE) {
> -		kmsg_dump_unregister(&hv_kmsg_dumper);
> -		unregister_die_notifier(&hyperv_die_report_block);
> -		atomic_notifier_chain_unregister(&panic_notifier_list,
> -						&hyperv_panic_report_block);
> -	}
> -
>  	/*
>  	 * The vmbus panic notifier is always registered, hence we should
>  	 * also unconditionally unregister it here as well.
> @@ -2833,8 +2649,6 @@ static void __exit vmbus_exit(void)
>  					&hyperv_panic_vmbus_unload_block);
>=20
>  	free_page((unsigned long)hv_panic_page);
> -	unregister_sysctl_table(hv_ctl_table_hdr);
> -	hv_ctl_table_hdr =3D NULL;
>  	bus_unregister(&hv_bus);
>=20
>  	cpuhp_remove_state(hyperv_cpuhp_online);
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyper=
v.h
> index 8845a2eca339..df0dbccd719a 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -186,7 +186,6 @@ void __init hv_common_free(void);
>  int hv_common_cpu_init(unsigned int cpu);
>  int hv_common_cpu_die(unsigned int cpu);
>=20
> -void *hv_alloc_hyperv_page(void);
>  void *hv_alloc_hyperv_zeroed_page(void);
>  void hv_free_hyperv_page(unsigned long addr);
>=20
> --
> 2.32.0

