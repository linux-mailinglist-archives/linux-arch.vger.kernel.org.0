Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B27E768346C
	for <lists+linux-arch@lfdr.de>; Tue, 31 Jan 2023 18:59:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjAaR7D (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 31 Jan 2023 12:59:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjAaR7B (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 31 Jan 2023 12:59:01 -0500
Received: from DM6FTOPR00CU001-vft-obe.outbound.protection.outlook.com (mail-cusazon11020020.outbound.protection.outlook.com [52.101.61.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DCDC4221;
        Tue, 31 Jan 2023 09:59:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M7bkEnWuDCJUlq148+GH35+SjDiXPxSWti8wZdus5Tg3AUqHnFJdNTRqFiuh1yIHUFeuttwaymo6y1s7oXl3KJEZUL3qHYrR1Ip/3s0thtAMbBy9qk5Yi5y4uoVRyZiz5gTkIgOWoVqjrenj6P+NHEpUs/jntPmZOuK4/qTuLZOrjoJM+UtfuOxBskNLyZt0xvvMBPdsSwV/PFh+O4dw6ZaJkxeifFdMqcY0Jt11BvPb4Kw34pRbF/hPXnBAehaoYQTUO7VsLv6G/FnMFu9s2tU2knO0a3nv3ZXzZzq4mXOjomGrqYQWwSXBwd9PXPGCMXwENo5R+OPqeR1/U4HC3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5sNJcK8x1aOfmj8qX117wn78ZmhY2iHhBZSqEO7cKBE=;
 b=Fszo31NRwtDYChzxsyp0bQcBZjf+SJ4j9coHj6SMvvXA+DtaVyZi5OA2eDg2Nkkcl1jnLB66JF0HUfYRa94MAjjrWqeqLbeiOny8rczWwuHzqnMjEy1xAVjOpUB8NDgwsguR22RZonckY7ABlvBOXpiVZ4gHd6+9eUW8rzg34cwr2UuJP3oATeTBROMfyF9M4c1vOHkChroP8ZHDwouW6VVCpWcmn7qriES3Xzb+bWuy1/UpSX8YrJGBkXlLTBUyhd+VLDBhQSoC0Y6O1fYoFW1ZA/mLqoHCyc6L2CC0S7H+IqyAawq8iKyDe2gXFtBZyxVq8uly+DEUOJyhMdba8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5sNJcK8x1aOfmj8qX117wn78ZmhY2iHhBZSqEO7cKBE=;
 b=J5zckjfh3dZV0S/HUaIdon6LS2ISSUt5WiRmAcQd9z3d1wIBopGIjRq/8+gH8XDzKpZhZ0ovbDCTbaPZOkDXSLzT4re6fNN43AvrNK7KPg/VQG5qArM1QDypEBszMlqSGVzQ3Lx1hAN6oJCgT+N1axYc8heDVgBIwg0N2rDHzpQ=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by MW4PR21MB1954.namprd21.prod.outlook.com (2603:10b6:303:7d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.4; Tue, 31 Jan
 2023 17:58:52 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::9a9e:c614:a89f:396e]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::9a9e:c614:a89f:396e%8]) with mapi id 15.20.6086.005; Tue, 31 Jan 2023
 17:58:52 +0000
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
Subject: RE: [RFC PATCH V3 06/16] x86/hyperv: decrypt vmbus pages for sev-snp
 enlightened guest
Thread-Topic: [RFC PATCH V3 06/16] x86/hyperv: decrypt vmbus pages for sev-snp
 enlightened guest
Thread-Index: AQHZLgvDjQTVlI9XV0mK0gWfj4TPQq643k8g
Date:   Tue, 31 Jan 2023 17:58:52 +0000
Message-ID: <BYAPR21MB16882851012198FD7ADB5CD1D7D09@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230122024607.788454-1-ltykernel@gmail.com>
 <20230122024607.788454-7-ltykernel@gmail.com>
In-Reply-To: <20230122024607.788454-7-ltykernel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=2074d3c4-9a80-40a0-8d1c-6476c4f28a54;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-01-31T17:55:27Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|MW4PR21MB1954:EE_
x-ms-office365-filtering-correlation-id: aaa113a5-5ed4-48d7-18ae-08db03b4d02f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uwfXCL73JXb8ZMo/wyZMeuhfYXwHgP0CwiZn9cstEdxNeezxs/MEfcu5Hvuq/ipBPEuZhXWV2HrN3Tp/fPwBMWRHOlWlOAVxiEr2um2EdL3YiPjM5BpzDYkwOPO8j/EQ7tdm+hM4gaJa+UtYudpl3eNelQUrdddByYOjdDz+QOrn5waFSuBuSAPTuws0T8tGzrkl3w7xKewASiYfUy4akOBp3ElYt/nhZjmBQ42qSvznIPw+bUdFmHc2GV7R40c/DXyxfZl/mfA7DJfOseDSCs+mbQqlbAHKxuIeOIYCWRuvIFeDw/yIyqeFV3gTrJVcAoFyKYVvQs9K5dpy0brk66ok7RmDh3Awvbs8bHWznQMay5VJkJgTXiRNKQtdtyGdmyFMfJR2QyMOVw/fBPR2rt4MgIZaKlqnyQKWG3r7yPQUW1W5SbhCOSNye4rDkDqge45H+yXSZBQPD27t6n74AYeLDGip9tzrGyhBIzhi7OOrtiMFOkIsoQNiHasMrA3SB4pSWfF6U79sx67eLtlxOTTRuV1qUBANdRWDG7UsXvR4vUm853uzbwr8pNItfWo/vNky2zqerVr41/pzNdZrqJWMrdU7j82bHmiUq/cFpBmCuIVtkIMSPvNzmCowzR00LTSU0tGZ0OZkBWF9FxQREZQ3T+ry4DoHBIUMoJ5D8Svay9VTWwl9EO1hnDDCmwgMczzEFkAn2eZg5TcXsp6nJwiobg4ydEi3HfxmkK+m5z8jzW3iQhBMKx6aTkIVQJnWfMQfN6T5f9SEjom/zC2AJg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(376002)(366004)(346002)(136003)(451199018)(8990500004)(83380400001)(38070700005)(2906002)(7416002)(7406005)(5660300002)(64756008)(7696005)(26005)(71200400001)(66446008)(76116006)(86362001)(8936002)(6506007)(4326008)(52536014)(66946007)(66476007)(8676002)(66556008)(478600001)(9686003)(10290500003)(38100700002)(82960400001)(186003)(921005)(55016003)(122000001)(316002)(41300700001)(110136005)(54906003)(82950400001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0gvO5y85+0jrnPTK0T1FkY028Gf9PaqhmNGNjRofnx7e8SLb5Abi0hsKx0q1?=
 =?us-ascii?Q?i8fpRtykl4euYYydCH8iviJUgjk8te/aTxK/dBTuQgxtOH+PwG/cK3TsEgoW?=
 =?us-ascii?Q?XJQ/5pjkwehbj3TbevonPJWUcAZaWyXWockJYDmBd5agNSPDYef8QX3ERlod?=
 =?us-ascii?Q?Jy3iRtH37sLQCOy+TeIP8V0a01ksdMiRgb6I+xxg/o5wxPLXWHoYHN+8a0df?=
 =?us-ascii?Q?SF6CYTdvP/m7TlSHbtMf65siyUHp6HExXWcyLIf31pLV5EMKhVmrOunhTgTB?=
 =?us-ascii?Q?KR0awB5akAQHEZkiW9jyE4/TdUoq8OgOIZa35HcgGpHZPNqyUJ1chXPL+Rx4?=
 =?us-ascii?Q?sEK4FrWUWWhbc2KwxLNWTGrtIcMNpVy8GJx/x4oFZt9cDB8aX8B3AR7U/RcH?=
 =?us-ascii?Q?9RSpVcPBI+0mqvMWBRX6LInHpLW2kDbmMckr2nuU6uFbvw5IJJZp5je7zOGF?=
 =?us-ascii?Q?hmxd7pV44LxiPFCV5WzgO8cnMBjgbcHYATWR/vL0BVK63RKJseqzOxUjnTsD?=
 =?us-ascii?Q?F2ozTNqwsFZ/62o/BXqeQQsb995xGZ/5VX37VvRFwLtsi2MWV+5IWPnXFVGl?=
 =?us-ascii?Q?KMqxth4qYhj6XsHXE5PUIhGDeP1sn/hl/LUUiKonR5bZC8R5WDv49QNDaX5N?=
 =?us-ascii?Q?ndbzRLCaya46GjpqvuuamB8rohX4yji/bDA7hHi4ejeW3FZN+5PJMSbrNWSe?=
 =?us-ascii?Q?MUCMzuYZ9MojlQ8Y7zu0iQYuGEi09hdXchtTMIHJBU90hAMyP8RI1DLcm1X4?=
 =?us-ascii?Q?qlhv+MKG0fashWqmIWEND4kECbJTrl2P2/7BB+VmIXqko7PLGPmLdJo1s4xa?=
 =?us-ascii?Q?G8Ko1LCR8Tht0u+yNbRWx3qDVRrd5RLaNvXMQw/Jnqq1EzNuOtdR8oZ3NGpZ?=
 =?us-ascii?Q?b82OUhxqXKRTWEnx46ErNRKjx07Buq17QS9T/fvVLrPdwNl5B11Cvv386caA?=
 =?us-ascii?Q?BaSO5aL5m0R5qGkA8Pw4iCHjTKL4AQ21H7/fXtnN5cFjAefmCr8e6gc10wWD?=
 =?us-ascii?Q?vz+/ZfASk/X/G+Sf0csbsUh03YodKfGUSujy/kg6UTPdzcyhkY4+vcqwQ5n2?=
 =?us-ascii?Q?E9Gd/fna4yilRkP9ePUiEb8em+3StvkEhqHLCBOpCL6NqQXLMj43ePfWkmSD?=
 =?us-ascii?Q?A+7QQaj9iL70L/EMQ9jFxhGHkMevXY97/jzR+AJaahulP+4ZavMQFJJsoyY5?=
 =?us-ascii?Q?Xpaumbat5sWm8ZyhskJIcMbmQmMeM9O1s7BKIIJk36HJRuKCcBclv637ALLG?=
 =?us-ascii?Q?VwX68OGghhj/g4mc3wuSGY5swKFVlDq2mrDHIj9V1sm1KFMwLNUUg//xx5te?=
 =?us-ascii?Q?bp9/kafWhtycsPvtC0zYuXXqMXKJOlLF62AHM+qzXYJB1ZI3vyhgkevoM2Lk?=
 =?us-ascii?Q?cbGG/Y7g2m9xlF5wB0aOv6xW//rEONGzRrxGc9SX/vbhajFhZ39gq3cuNpcJ?=
 =?us-ascii?Q?fI4+Nuq5WcVX7csvwKFI/r0MS+e1glUgAFG5sKnB/s5XLVwfJAqzO0LNaByj?=
 =?us-ascii?Q?j8yk1YINghehm5q8zYr78uuA2qNiSc3uEMa+nru0H1XoIp4eirhK4JGCN4VF?=
 =?us-ascii?Q?MdsFl5TUc5JfXFX8yx3H3kSJTWtMZeDtiktyy4jCSSfqD53Ey5KNndQgT4Ub?=
 =?us-ascii?Q?tg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aaa113a5-5ed4-48d7-18ae-08db03b4d02f
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2023 17:58:52.4644
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sq3cFjebLcQy7Cozf6WbyT+YC/4dX33Sdv6nNNnxVnE3y/aiIFjO2YW5lM7RO8MEPTM1vGW9yzUtc+DjxC/RHHtR1W+bONVbk4SY3fTEsX0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB1954
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Tianyu Lan <ltykernel@gmail.com> Sent: Saturday, January 21, 2023 6:4=
6 PM
>=20

As I comment on v2 of this patch, the Subject prefix should be
"Drivers: hv: vmbus:"

> Vmbus post msg, synic event and message pages are shared

s/Vmbus/VMBus/

We're trying to be consistent about the capitalization of "VMBus"
in comments and other text. :-)

> with hypervisor and so decrypt these pages in the sev-snp guest.
>=20
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> ---
> Change since RFC V2:
>        * Fix error in the error code path and encrypt
>        	 pages correctly when decryption failure happens.
> ---
>  drivers/hv/hv.c | 33 ++++++++++++++++++++++++++++++++-
>  1 file changed, 32 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
> index 410e6c4e80d3..52edc54c8172 100644
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

Having decrypted the pages here in hv_synic_alloc(), shouldn't
there be corresponding re-encryption in hv_synic_free()?

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
> --
> 2.25.1

