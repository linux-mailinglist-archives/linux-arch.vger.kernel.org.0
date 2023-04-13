Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5896E177E
	for <lists+linux-arch@lfdr.de>; Fri, 14 Apr 2023 00:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbjDMWdL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 13 Apr 2023 18:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbjDMWdI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 13 Apr 2023 18:33:08 -0400
Received: from DM5PR00CU002.outbound.protection.outlook.com (mail-centralusazon11021023.outbound.protection.outlook.com [52.101.62.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F5F868D;
        Thu, 13 Apr 2023 15:32:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V5NKn/9ZKNKODqi0Coay+l5NZw2G1KOWTyOp09C3UNXhsGYhrv57m+f9OP6vVB6uKM66Y8YQpkv7FV6UBjKSE7f25mJfezCKjMtX+b0oJ/QctlTx45UVtrKoerMqwVm0kSRe3eod20KpHGFU9dzcLs4FvS49/aGIKVNp9BXy6hCKAeCHMMTU7TTEehAjMO3z9CIp5iEsFSxZe4zpyVsGF8G18S85iI7kzDM5iHWqlkFVu2iruP88bJa2mezIOXE3omnvHMrzRglVEgqR8XKRzMbhASOqEGFn7m+lBugrBlkD9IBqsGUMI/xuR6JVpzuwpdRAuzF2u/BSq/qifoNc1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wLJlvTTX+PoEh0xYCoQP08qiZdA2+roMhs0I+JVubJ4=;
 b=jsiM6OEjeQKpYblqmDgsnurySQRbV7FRM7ZHbpeFksfPN4VqzUknMB/E/8EAZVYrtHIASjy8VJM7p7d5yiCLqxQWBfewn5t+KgpSI3Uq6qw2WVq2u3P0AzCu0//Ss71I1xxbn+g/IO3sQPUEgnWsbYffH7WQCDWhUzuEl4F6v7o8beJonnXTXq0E03cB2LYTaviyyiwbTo2MDsNHxsTBkbQUrdfHUr17+pUfQ2KCB7KaVYQ30VQa5eau8R8ZtdL8Me95nQPdesNw9JTxl34PfbamFDkLg/+vQqNdAUuDZsMbjAufgPZNo4d4H4rnCcUlkmboUUxI8UT2wttsXRXDlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wLJlvTTX+PoEh0xYCoQP08qiZdA2+roMhs0I+JVubJ4=;
 b=H5t35TKe14MOQAxMcFMynUa+YBLlBENiV5VaHJ7kT29SwuUeF8S6l7aTZGmoebdhpmraZOkPtmPcSkoDGiDitIQe7+p4bAKNYK2Fs4KUwBCNsqoqELGCFSsL5qg6jt8EZTuplqcRUNLK8n7CoAuDoS4ZAbIkU5/H0SX8vrJWq7E=
Received: from PH7PR21MB3263.namprd21.prod.outlook.com (2603:10b6:510:1db::16)
 by DS7PR21MB3100.namprd21.prod.outlook.com (2603:10b6:8:74::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.4; Thu, 13 Apr
 2023 22:31:57 +0000
Received: from PH7PR21MB3263.namprd21.prod.outlook.com
 ([fe80::4d56:4d4b:3785:a1ca]) by PH7PR21MB3263.namprd21.prod.outlook.com
 ([fe80::4d56:4d4b:3785:a1ca%4]) with mapi id 15.20.6319.004; Thu, 13 Apr 2023
 22:31:57 +0000
From:   Long Li <longli@microsoft.com>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Arnd Bergmann <arnd@arndb.de>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: RE: [PATCH] Drivers: hv: move panic report code from vmbus to hv
 early init code
Thread-Topic: [PATCH] Drivers: hv: move panic report code from vmbus to hv
 early init code
Thread-Index: AQHZbBrIb0S6TsvepkeYbCWE5fxcFK8n/ocAgAHX1JA=
Date:   Thu, 13 Apr 2023 22:31:57 +0000
Message-ID: <PH7PR21MB3263259B4301760E64356843CE989@PH7PR21MB3263.namprd21.prod.outlook.com>
References: <1681179010-17811-1-git-send-email-longli@linuxonhyperv.com>
 <BYAPR21MB168862BDB7C49AFB7E611E89D79B9@BYAPR21MB1688.namprd21.prod.outlook.com>
In-Reply-To: <BYAPR21MB168862BDB7C49AFB7E611E89D79B9@BYAPR21MB1688.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=41bb7049-8d4b-4340-bc3f-040c1f13f879;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-04-12T17:57:50Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3263:EE_|DS7PR21MB3100:EE_
x-ms-office365-filtering-correlation-id: a3f874db-f52d-4c5d-834a-08db3c6ee412
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tp9xOIh+1e6i7zjuqYH0hQia4kA7c/aQjMbnoVQ9lk0Gwx30yqHpd35L6Mji6r4qilGstR2IQEdc3MiUdwl2rZFrdQzD3iK+lbgmYxfAB75j7ZCw9GfapI4Zd5rSXcNm1/SAlv7E6FL6rR1fr6lWTBHJ8O2AnjdK1wuOV9LEfavvmwQ3MOFQ1hZiQMMUzZlvhY5xf3zGQixyq0NuYRrRyZJFhLpb0RmPRXbv3KhoODovjjt0FMgtVZLC1w5/38dm/wJLzGaf/omw5leLuG3tEakShh6iZiAA0JyV0UNLVswxvrD/n7lEZzoEqbRlB6usVEU4L3l0y1bpA9JEIdwGhDrsvMfbrLf38IIqz3LElIw+CPro+uT5EGzvsHrZ7vE/LQBX3/kW/9IVIuvMTJRVKr91H3MzanZGYhauePZiZw4IZfMyJgXWOXplLp6Dw6D1Uqphw14TEU/G4Sd9DlX8SlnyWDlcFZS8gaRP9WAY3HJgx8QKhq5/jP+8NjBmyYEUhjy2BjA0NT85Sk9IGx3HUOuH8bOzi6JlQLlYMyyQVeviOYU5SfjGIghQbj/Kn/PPPBb3Y5MTfNHfm3TmQXNfW9Y5pNvhXDERyN1GR1hI8Hfdd17k141QaGggNif9PFdNR+4llp/fqRABnsIZCmmGnBVVOHaRO3OGeIeebdpkl0k=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:cs;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3263.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(136003)(346002)(396003)(366004)(451199021)(10290500003)(54906003)(110136005)(478600001)(82950400001)(52536014)(8676002)(86362001)(38070700005)(2906002)(8990500004)(30864003)(33656002)(66946007)(55016003)(8936002)(82960400001)(786003)(316002)(5660300002)(41300700001)(66556008)(4326008)(64756008)(76116006)(38100700002)(122000001)(9686003)(186003)(6506007)(26005)(83380400001)(66476007)(66446008)(7696005)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2r30b3E2YHdwmgnY/bWkJt9+EaLvdjQBmQMt6MlEwl4Gilwb9lvQP4rKxa7f?=
 =?us-ascii?Q?fMhDtCBLEzbcJy+8W/jZo0sQHmqB0Odr3WZ+pDaarOwIOtZMC1EV5lXoiLqH?=
 =?us-ascii?Q?GLMSooiCNnSeWC5QCLBPtEytz6OFeADlltA4hhWXT2Rql0q5CPLRYmNX/Me/?=
 =?us-ascii?Q?IygLCHGopXhX+qePKJp4xHuEk6uLCl8OTv9GElqRbE/Q0uA579TNFKT2YF6Y?=
 =?us-ascii?Q?XWvoogwye/bfDpbH3GtThks1u4slw031vRD6zgyN7OJ91/OUGg/P405gIVaC?=
 =?us-ascii?Q?GBT6wbO3ZpM/hD4wTdx7m11B53BBnMIs2I75VyRYb2f3pxlTOwGLi8U1MHoq?=
 =?us-ascii?Q?/Nyg1T8JRvjhLulMlkJQVw2gZ/4yIivrPdc0ZaY2X3jLhb+TVqHTYDxgZSmd?=
 =?us-ascii?Q?V7ygIuIIAD0g86e/+ZUQtL9H+sxyyp6b0/ENjpG+VitNITyzZE0Lq49pwZ3T?=
 =?us-ascii?Q?4cQX3Yx7TyzXuE92yYzS3yv4doBVUGbUUa4BKSfArXvSt+H/HNIeH878vYxa?=
 =?us-ascii?Q?f5gVAxyY0Yvts5y45dMNIcClbP6wgxY5ZV1i9ybjjZ2tB0DxxyzCsMWXYTBG?=
 =?us-ascii?Q?is4yTeFjpP14nSM6gyyTvyPqXiS5SnJh6RwxlPo53V9bkaDdnreB8fFeQKQ5?=
 =?us-ascii?Q?EnQLQyAm+flDPXlzC54gsCP+GjcM27NWFANHViU4ctKLJ8ne+dNJBZU8JcFq?=
 =?us-ascii?Q?iAesEuYtkSn2Mdzd0dwCqP2NTYnyggBf2l8eesT+NeQOtR55AyMDriXjA0GC?=
 =?us-ascii?Q?3OcDfgTqkVOA06+JRUHj0Ux93pV/mCSxluYSROFbbdLHjpI0AGUpXknknU7B?=
 =?us-ascii?Q?y5YSSQNDqZnEXwq2W1z2t7YTdP41/CqJPGEtXu+v7kwM7vuMncDwo53eCsUn?=
 =?us-ascii?Q?rVh31kjOaOZJGnTTSyfGhWnzkZ0OOeSJt6OoCxpVK4vLJY0OfrZpiFT3wnHt?=
 =?us-ascii?Q?tN3pUk8fMGU/dcQo6LSy17RrxbjrS7a3kwGq4f4c/hjfQkBGbdpXFjjrmViP?=
 =?us-ascii?Q?0zB2IPwUuDJaipX9mYMJbPbqXu0nEvAwPov1wvrEJefjFlDLXqNpqa64BSpU?=
 =?us-ascii?Q?c7BFDNoPYqaXpzY/HndQkoPgdr8YhT6RheZaCIOBxWyLCRRRCUfpaAUF80eo?=
 =?us-ascii?Q?OEVGgCreQScNOtvQQqQCMncVogko4KWyJ0zc1IB2J/aPg+yctcguUxWKPFmS?=
 =?us-ascii?Q?r0BFspSbmEhQYnBntEzLHUVwzLvAJtSxwJ9VboJ5Yw9yBmW+K3HXjf2L8umG?=
 =?us-ascii?Q?yiofraza42749kqYTjw9J2fAP4WpnF7FpX0ywFVjc5yuwRnXSmaisvm/8dTh?=
 =?us-ascii?Q?4RJ+4pzAhlH3cmU5xjsYF6w+wBFlzlLKPBfYaWDcS3nT7PslPc9wM1fBIa+d?=
 =?us-ascii?Q?CRjb3pJvGgFcCuNQHiC/Gc3BsxrLqRnXqO9tedeSi3jetnA6KcTxVKiRDjCy?=
 =?us-ascii?Q?puAgnsRlFzCTefQOcEmBJzwu9hMDzEyZszNOJ0WDTFGk1+RQT08B/4nsfhLB?=
 =?us-ascii?Q?HehTQdmx4SZIEV4qQZ8AFqN7Kernb041McTlq5TOjqkHLL0FiE6fMTcv3Vda?=
 =?us-ascii?Q?Klq/3kkERcWQi7DuKS94D+HMQ2Zy4xYvGtli7SXS?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR21MB3263.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3f874db-f52d-4c5d-834a-08db3c6ee412
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2023 22:31:57.3036
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0NFeiXnsaUp6g+Y62NNFkm0FkmExaFN+/xQva2iNy+jw3JitMydrYKuysTzHDXkI00bZDIXWUlXca3QQoSPccQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR21MB3100
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

>Subject: RE: [PATCH] Drivers: hv: move panic report code from vmbus to hv
>early init code
>
>From: longli@linuxonhyperv.com <longli@linuxonhyperv.com> Sent: Monday,
>April 10, 2023 7:10 PM
>>
>> The panic reporting code was added in commit 81b18bce48af
>> ("Drivers: HV: Send one page worth of kmsg dump over Hyper-V during
>> panic")
>>
>> It was added to the vmbus driver. The panic reporting has no
>> dependence on vmbus, and can be enabled at an earlier boot time when
>> Hyper-V is initialized.
>>
>> This patch moves the panic reporting code out of vmbus. There is no
>> functionality changes. During moving, also refactored some cleanup
>> functions into hv_kmsg_dump_unregister(), and removed unused function
>> hv_alloc_hyperv_page().
>>
>> Signed-off-by: Long Li <longli@microsoft.com>
>> ---
>>  drivers/hv/hv.c                |  36 ------
>>  drivers/hv/hv_common.c         | 227
>+++++++++++++++++++++++++++++++++
>>  drivers/hv/vmbus_drv.c         | 186 ---------------------------
>>  include/asm-generic/mshyperv.h |   1 -
>>  4 files changed, 227 insertions(+), 223 deletions(-)
>>
>> diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c index
>> 8b0dd8e5244d..88eca08c7030 100644
>> --- a/drivers/hv/hv.c
>> +++ b/drivers/hv/hv.c
>> @@ -38,42 +38,6 @@ int hv_init(void)
>>  	return 0;
>>  }
>>
>> -/*
>> - * Functions for allocating and freeing memory with size and
>> - * alignment HV_HYP_PAGE_SIZE. These functions are needed because
>> - * the guest page size may not be the same as the Hyper-V page
>> - * size. We depend upon kmalloc() aligning power-of-two size
>> - * allocations to the allocation size boundary, so that the
>> - * allocated memory appears to Hyper-V as a page of the size
>> - * it expects.
>> - */
>> -
>> -void *hv_alloc_hyperv_page(void)
>> -{
>> -	BUILD_BUG_ON(PAGE_SIZE <  HV_HYP_PAGE_SIZE);
>> -
>> -	if (PAGE_SIZE =3D=3D HV_HYP_PAGE_SIZE)
>> -		return (void *)__get_free_page(GFP_KERNEL);
>> -	else
>> -		return kmalloc(HV_HYP_PAGE_SIZE, GFP_KERNEL);
>> -}
>> -
>> -void *hv_alloc_hyperv_zeroed_page(void)
>> -{
>> -	if (PAGE_SIZE =3D=3D HV_HYP_PAGE_SIZE)
>> -		return (void *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
>> -	else
>> -		return kzalloc(HV_HYP_PAGE_SIZE, GFP_KERNEL);
>> -}
>> -
>> -void hv_free_hyperv_page(unsigned long addr) -{
>> -	if (PAGE_SIZE =3D=3D HV_HYP_PAGE_SIZE)
>> -		free_page(addr);
>> -	else
>> -		kfree((void *)addr);
>> -}
>> -
>>  /*
>>   * hv_post_message - Post a message using the hypervisor message IPC.
>>   *
>> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c index
>> 52a6f89ccdbd..d696c2110349 100644
>> --- a/drivers/hv/hv_common.c
>> +++ b/drivers/hv/hv_common.c
>> @@ -17,8 +17,11 @@
>>  #include <linux/export.h>
>>  #include <linux/bitfield.h>
>>  #include <linux/cpumask.h>
>> +#include <linux/sched/task_stack.h>
>>  #include <linux/panic_notifier.h>
>>  #include <linux/ptrace.h>
>> +#include <linux/kdebug.h>
>> +#include <linux/kmsg_dump.h>
>>  #include <linux/slab.h>
>>  #include <linux/dma-map-ops.h>
>>  #include <asm/hyperv-tlfs.h>
>> @@ -54,6 +57,10 @@ EXPORT_SYMBOL_GPL(hyperv_pcpu_input_arg);
>>  void * __percpu *hyperv_pcpu_output_arg;
>> EXPORT_SYMBOL_GPL(hyperv_pcpu_output_arg);
>>
>> +static void hv_kmsg_dump_unregister(void);
>> +
>> +static struct ctl_table_header *hv_ctl_table_hdr;
>> +
>>  /*
>>   * Hyper-V specific initialization and shutdown code that is
>>   * common across all architectures.  Called from architecture @@
>> -62,6 +69,12 @@ EXPORT_SYMBOL_GPL(hyperv_pcpu_output_arg);
>>
>>  void __init hv_common_free(void)
>>  {
>> +	unregister_sysctl_table(hv_ctl_table_hdr);
>> +	hv_ctl_table_hdr =3D NULL;
>> +
>> +	if (ms_hyperv.misc_features &
>HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE)
>> +		hv_kmsg_dump_unregister();
>> +
>>  	kfree(hv_vp_index);
>>  	hv_vp_index =3D NULL;
>>
>> @@ -72,6 +85,195 @@ void __init hv_common_free(void)
>>  	hyperv_pcpu_input_arg =3D NULL;
>>  }
>>
>> +/*
>> + * Functions for allocating and freeing memory with size and
>> + * alignment HV_HYP_PAGE_SIZE. These functions are needed because
>> + * the guest page size may not be the same as the Hyper-V page
>> + * size. We depend upon kmalloc() aligning power-of-two size
>> + * allocations to the allocation size boundary, so that the
>> + * allocated memory appears to Hyper-V as a page of the size
>> + * it expects.
>> + */
>> +
>> +void *hv_alloc_hyperv_zeroed_page(void)
>> +{
>> +	if (PAGE_SIZE =3D=3D HV_HYP_PAGE_SIZE)
>> +		return (void *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
>> +	else
>> +		return kzalloc(HV_HYP_PAGE_SIZE, GFP_KERNEL); }
>> +EXPORT_SYMBOL_GPL(hv_alloc_hyperv_zeroed_page);
>> +
>> +void hv_free_hyperv_page(unsigned long addr) {
>> +	if (PAGE_SIZE =3D=3D HV_HYP_PAGE_SIZE)
>> +		free_page(addr);
>> +	else
>> +		kfree((void *)addr);
>> +}
>> +EXPORT_SYMBOL_GPL(hv_free_hyperv_page);
>> +
>> +static void *hv_panic_page;
>> +static int sysctl_record_panic_msg =3D 1;
>> +
>> +static int hyperv_report_reg(void)
>> +{
>> +	return !sysctl_record_panic_msg || !hv_panic_page; }
>
>Nit:  The above function is used in only one place.  The code could easily=
 just go
>inline.  Putting the code inline would probably be clearer anyway.
>
>> +
>> +static int hv_die_panic_notify_crash(struct notifier_block *self,
>> +				     unsigned long val, void *args);
>> +
>> +static struct notifier_block hyperv_die_report_block =3D {
>> +	.notifier_call =3D hv_die_panic_notify_crash, };
>> +
>> +static struct notifier_block hyperv_panic_report_block =3D {
>> +	.notifier_call =3D hv_die_panic_notify_crash, };
>> +
>> +/*
>> + * The following callback works both as die and panic notifier; its
>> + * goal is to provide panic information to the hypervisor unless the
>> + * kmsg dumper is used [see hv_kmsg_dump()], which provides more
>> + * information but isn't always available.
>> + *
>> + * Notice that both the panic/die report notifiers are registered
>> +only
>> + * if we have the capability HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE
>set.
>> + */
>> +static int hv_die_panic_notify_crash(struct notifier_block *self,
>> +				     unsigned long val, void *args) {
>> +	struct pt_regs *regs;
>> +	bool is_die;
>> +
>> +	/* Don't notify Hyper-V unless we have a die oops event or panic. */
>> +	if (self =3D=3D &hyperv_panic_report_block) {
>> +		is_die =3D false;
>> +		regs =3D current_pt_regs();
>> +	} else { /* die event */
>> +		if (val !=3D DIE_OOPS)
>> +			return NOTIFY_DONE;
>> +
>> +		is_die =3D true;
>> +		regs =3D ((struct die_args *)args)->regs;
>> +	}
>> +
>> +	/*
>> +	 * Hyper-V should be notified only once about a panic/die. If we will
>> +	 * be calling hv_kmsg_dump() later with kmsg data, don't do the
>> +	 * notification here.
>> +	 */
>> +	if (hyperv_report_reg())
>> +		hyperv_report_panic(regs, val, is_die);
>> +
>> +	return NOTIFY_DONE;
>> +}
>> +
>> +/*
>> + * Callback from kmsg_dump. Grab as much as possible from the end of
>> +the kmsg
>> + * buffer and call into Hyper-V to transfer the data.
>> + */
>> +static void hv_kmsg_dump(struct kmsg_dumper *dumper,
>> +			 enum kmsg_dump_reason reason)
>> +{
>> +	struct kmsg_dump_iter iter;
>> +	size_t bytes_written;
>> +
>> +	/* We are only interested in panics. */
>> +	if (reason !=3D KMSG_DUMP_PANIC || !sysctl_record_panic_msg)
>> +		return;
>> +
>> +	/*
>> +	 * Write dump contents to the page. No need to synchronize; panic
>should
>> +	 * be single-threaded.
>> +	 */
>> +	kmsg_dump_rewind(&iter);
>> +	kmsg_dump_get_buffer(&iter, false, hv_panic_page,
>HV_HYP_PAGE_SIZE,
>> +			     &bytes_written);
>> +	if (!bytes_written)
>> +		return;
>> +	/*
>> +	 * P3 to contain the physical address of the panic page & P4 to
>> +	 * contain the size of the panic data in that page. Rest of the
>> +	 * registers are no-op when the NOTIFY_MSG flag is set.
>> +	 */
>> +	hv_set_register(HV_REGISTER_CRASH_P0, 0);
>> +	hv_set_register(HV_REGISTER_CRASH_P1, 0);
>> +	hv_set_register(HV_REGISTER_CRASH_P2, 0);
>> +	hv_set_register(HV_REGISTER_CRASH_P3,
>virt_to_phys(hv_panic_page));
>> +	hv_set_register(HV_REGISTER_CRASH_P4, bytes_written);
>> +
>> +	/*
>> +	 * Let Hyper-V know there is crash data available along with
>> +	 * the panic message.
>> +	 */
>> +	hv_set_register(HV_REGISTER_CRASH_CTL,
>> +			(HV_CRASH_CTL_CRASH_NOTIFY |
>> +			 HV_CRASH_CTL_CRASH_NOTIFY_MSG));
>> +}
>> +
>> +static struct kmsg_dumper hv_kmsg_dumper =3D {
>> +	.dump =3D hv_kmsg_dump,
>> +};
>> +
>> +static void hv_kmsg_dump_unregister(void) {
>> +	kmsg_dump_unregister(&hv_kmsg_dumper);
>> +	unregister_die_notifier(&hyperv_die_report_block);
>> +	atomic_notifier_chain_unregister(&panic_notifier_list,
>> +					 &hyperv_panic_report_block);
>> +
>> +	if (hv_panic_page) {
>
>No need to explicitly test for NULL.  hv_free_hyperv_page() handles that c=
ase
>already.
>
>> +		hv_free_hyperv_page((unsigned long)hv_panic_page);
>> +		hv_panic_page =3D NULL;
>> +	}
>> +}
>> +
>> +static void hv_kmsg_dump_register(void) {
>> +	int ret;
>> +
>> +	hv_panic_page =3D hv_alloc_hyperv_zeroed_page();
>> +	if (!hv_panic_page) {
>> +		pr_err("Hyper-V: panic message page memory allocation
>failed\n");
>> +		return;
>> +	}
>> +
>> +	ret =3D kmsg_dump_register(&hv_kmsg_dumper);
>> +	if (ret) {
>> +		pr_err("Hyper-V: kmsg dump register error 0x%x\n", ret);
>> +		hv_free_hyperv_page((unsigned long)hv_panic_page);
>> +		hv_panic_page =3D NULL;
>> +	}
>> +}
>> +
>> +/*
>> + * sysctl option to allow the user to control whether kmsg data
>> +should be
>> + * reported to Hyper-V on panic.
>> + */
>> +static struct ctl_table hv_ctl_table[] =3D {
>> +	{
>> +		.procname	=3D "hyperv_record_panic_msg",
>> +		.data		=3D &sysctl_record_panic_msg,
>> +		.maxlen		=3D sizeof(int),
>> +		.mode		=3D 0644,
>> +		.proc_handler	=3D proc_dointvec_minmax,
>> +		.extra1		=3D SYSCTL_ZERO,
>> +		.extra2		=3D SYSCTL_ONE
>> +	},
>> +	{}
>> +};
>> +
>> +static struct ctl_table hv_root_table[] =3D {
>> +	{
>> +		.procname	=3D "kernel",
>> +		.mode		=3D 0555,
>> +		.child		=3D hv_ctl_table
>> +	},
>> +	{}
>> +};
>> +
>>  int __init hv_common_init(void)
>>  {
>>  	int i;
>> @@ -84,8 +286,33 @@ int __init hv_common_init(void)
>>  	 * kernel.
>>  	 */
>>  	if (ms_hyperv.misc_features &
>HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE)
>> {
>> +		u64 hyperv_crash_ctl;
>> +
>>  		crash_kexec_post_notifiers =3D true;
>>  		pr_info("Hyper-V: enabling crash_kexec_post_notifiers\n");
>> +
>> +		/*
>> +		 * Panic message recording (sysctl_record_panic_msg)
>> +		 * is enabled by default in non-isolated guests and
>> +		 * disabled by default in isolated guests; the panic
>> +		 * message recording won't be available in isolated
>> +		 * guests should the following registration fail.
>> +		 */
>> +		hv_ctl_table_hdr =3D register_sysctl_table(hv_root_table);
>> +		if (!hv_ctl_table_hdr)
>> +			pr_err("Hyper-V: sysctl table register error");
>> +
>> +		/*
>> +		 * Register for panic kmsg callback only if the right
>> +		 * capability is supported by the hypervisor.
>> +		 */
>> +		hyperv_crash_ctl =3D hv_get_register(HV_REGISTER_CRASH_CTL);
>> +		if (hyperv_crash_ctl & HV_CRASH_CTL_CRASH_NOTIFY_MSG)
>> +			hv_kmsg_dump_register();
>> +
>> +		register_die_notifier(&hyperv_die_report_block);
>> +		atomic_notifier_chain_register(&panic_notifier_list,
>> +					       &hyperv_panic_report_block);
>>  	}
>>
>>  	/*
>> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c index
>> d24dd65b33d4..96fb596ab68f 100644
>> --- a/drivers/hv/vmbus_drv.c
>> +++ b/drivers/hv/vmbus_drv.c
>> @@ -28,7 +28,6 @@
>>  #include <linux/panic_notifier.h>
>>  #include <linux/ptrace.h>
>>  #include <linux/screen_info.h>
>> -#include <linux/kdebug.h>
>>  #include <linux/efi.h>
>>  #include <linux/random.h>
>>  #include <linux/kernel.h>
>> @@ -63,11 +62,6 @@ int vmbus_interrupt;
>>   */
>>  static int sysctl_record_panic_msg =3D 1;
>>
>> -static int hyperv_report_reg(void)
>> -{
>> -	return !sysctl_record_panic_msg || !hv_panic_page;
>> -}
>> -
>>  /*
>>   * The panic notifier below is responsible solely for unloading the
>>   * vmbus connection, which is necessary in a panic event.
>> @@ -88,54 +82,6 @@ static struct notifier_block
>> hyperv_panic_vmbus_unload_block =3D {
>>  	.priority	=3D INT_MIN + 1, /* almost the latest one to execute */
>>  };
>>
>> -static int hv_die_panic_notify_crash(struct notifier_block *self,
>> -				     unsigned long val, void *args);
>> -
>> -static struct notifier_block hyperv_die_report_block =3D {
>> -	.notifier_call =3D hv_die_panic_notify_crash,
>> -};
>> -static struct notifier_block hyperv_panic_report_block =3D {
>> -	.notifier_call =3D hv_die_panic_notify_crash,
>> -};
>> -
>> -/*
>> - * The following callback works both as die and panic notifier; its
>> - * goal is to provide panic information to the hypervisor unless the
>> - * kmsg dumper is used [see hv_kmsg_dump()], which provides more
>> - * information but isn't always available.
>> - *
>> - * Notice that both the panic/die report notifiers are registered
>> only
>> - * if we have the capability HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE
>set.
>> - */
>> -static int hv_die_panic_notify_crash(struct notifier_block *self,
>> -				     unsigned long val, void *args)
>> -{
>> -	struct pt_regs *regs;
>> -	bool is_die;
>> -
>> -	/* Don't notify Hyper-V unless we have a die oops event or panic. */
>> -	if (self =3D=3D &hyperv_panic_report_block) {
>> -		is_die =3D false;
>> -		regs =3D current_pt_regs();
>> -	} else { /* die event */
>> -		if (val !=3D DIE_OOPS)
>> -			return NOTIFY_DONE;
>> -
>> -		is_die =3D true;
>> -		regs =3D ((struct die_args *)args)->regs;
>> -	}
>> -
>> -	/*
>> -	 * Hyper-V should be notified only once about a panic/die. If we will
>> -	 * be calling hv_kmsg_dump() later with kmsg data, don't do the
>> -	 * notification here.
>> -	 */
>> -	if (hyperv_report_reg())
>> -		hyperv_report_panic(regs, val, is_die);
>> -
>> -	return NOTIFY_DONE;
>> -}
>> -
>>  static const char *fb_mmio_name =3D "fb_range";  static struct resource
>> *fb_mmio;  static struct resource *hyperv_mmio; @@ -1377,98 +1323,6 @@
>> static irqreturn_t vmbus_percpu_isr(int irq, void *dev_id)
>>  	return IRQ_HANDLED;
>>  }
>>
>> -/*
>> - * Callback from kmsg_dump. Grab as much as possible from the end of
>> the kmsg
>> - * buffer and call into Hyper-V to transfer the data.
>> - */
>> -static void hv_kmsg_dump(struct kmsg_dumper *dumper,
>> -			 enum kmsg_dump_reason reason)
>> -{
>> -	struct kmsg_dump_iter iter;
>> -	size_t bytes_written;
>> -
>> -	/* We are only interested in panics. */
>> -	if ((reason !=3D KMSG_DUMP_PANIC) || (!sysctl_record_panic_msg))
>> -		return;
>> -
>> -	/*
>> -	 * Write dump contents to the page. No need to synchronize; panic
>should
>> -	 * be single-threaded.
>> -	 */
>> -	kmsg_dump_rewind(&iter);
>> -	kmsg_dump_get_buffer(&iter, false, hv_panic_page,
>HV_HYP_PAGE_SIZE,
>> -			     &bytes_written);
>> -	if (!bytes_written)
>> -		return;
>> -	/*
>> -	 * P3 to contain the physical address of the panic page & P4 to
>> -	 * contain the size of the panic data in that page. Rest of the
>> -	 * registers are no-op when the NOTIFY_MSG flag is set.
>> -	 */
>> -	hv_set_register(HV_REGISTER_CRASH_P0, 0);
>> -	hv_set_register(HV_REGISTER_CRASH_P1, 0);
>> -	hv_set_register(HV_REGISTER_CRASH_P2, 0);
>> -	hv_set_register(HV_REGISTER_CRASH_P3,
>virt_to_phys(hv_panic_page));
>> -	hv_set_register(HV_REGISTER_CRASH_P4, bytes_written);
>> -
>> -	/*
>> -	 * Let Hyper-V know there is crash data available along with
>> -	 * the panic message.
>> -	 */
>> -	hv_set_register(HV_REGISTER_CRASH_CTL,
>> -	       (HV_CRASH_CTL_CRASH_NOTIFY |
>HV_CRASH_CTL_CRASH_NOTIFY_MSG));
>> -}
>> -
>> -static struct kmsg_dumper hv_kmsg_dumper =3D {
>> -	.dump =3D hv_kmsg_dump,
>> -};
>> -
>> -static void hv_kmsg_dump_register(void) -{
>> -	int ret;
>> -
>> -	hv_panic_page =3D hv_alloc_hyperv_zeroed_page();
>> -	if (!hv_panic_page) {
>> -		pr_err("Hyper-V: panic message page memory allocation
>failed\n");
>> -		return;
>> -	}
>> -
>> -	ret =3D kmsg_dump_register(&hv_kmsg_dumper);
>> -	if (ret) {
>> -		pr_err("Hyper-V: kmsg dump register error 0x%x\n", ret);
>> -		hv_free_hyperv_page((unsigned long)hv_panic_page);
>> -		hv_panic_page =3D NULL;
>> -	}
>> -}
>> -
>> -static struct ctl_table_header *hv_ctl_table_hdr;
>> -
>> -/*
>> - * sysctl option to allow the user to control whether kmsg data
>> should be
>> - * reported to Hyper-V on panic.
>> - */
>> -static struct ctl_table hv_ctl_table[] =3D {
>> -	{
>> -		.procname       =3D "hyperv_record_panic_msg",
>> -		.data           =3D &sysctl_record_panic_msg,
>> -		.maxlen         =3D sizeof(int),
>> -		.mode           =3D 0644,
>> -		.proc_handler   =3D proc_dointvec_minmax,
>> -		.extra1		=3D SYSCTL_ZERO,
>> -		.extra2		=3D SYSCTL_ONE
>> -	},
>> -	{}
>> -};
>> -
>> -static struct ctl_table hv_root_table[] =3D {
>> -	{
>> -		.procname	=3D "kernel",
>> -		.mode		=3D 0555,
>> -		.child		=3D hv_ctl_table
>> -	},
>> -	{}
>> -};
>> -
>>  /*
>>   * vmbus_bus_init -Main vmbus driver initialization routine.
>>   *
>> @@ -1535,35 +1389,6 @@ static int vmbus_bus_init(void)
>>  	if (hv_is_isolation_supported())
>>  		sysctl_record_panic_msg =3D 0;
>
>The above two lines of code should move as well.  Otherwise we have a
>window during early boot where the panic message might be dumped to the
>Hyper-V host in a CVM.

I'm sending v2 to address all the comments.

Thanks,
Long
