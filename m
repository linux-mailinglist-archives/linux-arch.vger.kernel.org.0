Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 856363034AF
	for <lists+linux-arch@lfdr.de>; Tue, 26 Jan 2021 06:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732667AbhAZFZf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 Jan 2021 00:25:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729061AbhAZBex (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 25 Jan 2021 20:34:53 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on20714.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5a::714])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B9DC0698CB;
        Mon, 25 Jan 2021 17:20:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dgbj2LE2xPFMBvFMlYewXttBDTsL8bc4reXeTvAfFDkAcwhooYkdHsCb5TZTSnV2gEADe8Ky0U85CJw7LVCZpqFj36fI25bn+OCK5GTg5KdlPbxOPFO730Um3soB++CoWcGCkUkStJ61RL/60l5J2xEyoKd6dc40qLF8i0uqq9v6T57Z2AqNQUk9Npu/tNVESwlSfWVS/mee5nN7UTenaqE1DMPcjVPM98oEZYALqgLJvhDbyucwu5OPKhXPDbq6yjlB0jgNaM5s048iRvzm9HhmmvQJ0MbMQY91zgOXtAWMCDTX5gAneBzbC3Ae3vXYLPVVxkwk7w2f4uMNd0feBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LhHgNsopweSSg6odUNq8LieA9tPg3GP2hVyp5Pfhsbo=;
 b=MonEK9e0/BPFJU9Q7TO/4XDome/tKLQZ2Vv+Mtbq7U54vX3XPXtOhXT10ekMRvQ8ZDWg3hAe6FjiutHnEBtUPUdujs8upjsaOOX0YqgUtdPDNbLxKjudQdZsVXsAg49ZhahAFrHkGhVeqs3K3VeRE024edSkoN8XVbwWSHr4494//wBvOFinDnviYZkrLgOPYLJ/o8pRkqTJrVpOT7J//XBMT9N8KqI62m7m6zDTE2oc6BTYjN0BARjZJKY0O+52fqoUN5FelATDGeTIBcbRoIO0tPP804A9d8I7FsfKAAYoY6xqvwp25Y9PZSoNIkKrPBaVWbr4g8f9A+hJ+ZyX6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LhHgNsopweSSg6odUNq8LieA9tPg3GP2hVyp5Pfhsbo=;
 b=cSmBeAhllLvvjMJzLAFqOkk2bvGXfY2MVjETe1O2HHDjAwk3DnOn2EuJQjhfKtsmlCNCQTdfRgcmLuyO1tLPMfEEhIAYJk+Lp9+TN3004xqrnoPN1o1JPZH4qgKCVlCA3EZmltmkzjexoGtrcl6sC/DJIxiM0CwWi+odfNTwKUc=
Received: from (2603:10b6:301:7c::11) by
 MWHPR2101MB0873.namprd21.prod.outlook.com (2603:10b6:301:7e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.6; Tue, 26 Jan
 2021 01:20:36 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2%9]) with mapi id 15.20.3825.003; Tue, 26 Jan 2021
 01:20:36 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
CC:     "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        "pasha.tatashin@soleen.com" <pasha.tatashin@soleen.com>,
        Lillian Grassin-Drake <Lillian.GrassinDrake@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
        "open list:GENERIC INCLUDE/ASM HEADER FILES" 
        <linux-arch@vger.kernel.org>
Subject: RE: [PATCH v5 09/16] x86/hyperv: provide a bunch of helper functions
Thread-Topic: [PATCH v5 09/16] x86/hyperv: provide a bunch of helper functions
Thread-Index: AQHW7yPzh/pAvh4MHU6vlr5+1/4lyKo5HCJQ
Date:   Tue, 26 Jan 2021 01:20:36 +0000
Message-ID: <MWHPR21MB159390266F2172D12FEBBDD8D7BC9@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20210120120058.29138-1-wei.liu@kernel.org>
 <20210120120058.29138-10-wei.liu@kernel.org>
In-Reply-To: <20210120120058.29138-10-wei.liu@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-01-26T01:20:33Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=ee96a613-364c-473d-91f4-0ca971953cbd;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [66.75.126.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e5ac5807-3614-473b-e93b-08d8c19895d6
x-ms-traffictypediagnostic: MWHPR2101MB0873:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR2101MB0873D306AA49F54FDF6FAE58D7BC9@MWHPR2101MB0873.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tRO3gqor9xIEnyzEvz0Nj9P3PT+uvz0sV56Lptj9FWuYbLBw+rEvgFP8vfzMJ/UnlCGqQz/SyDtND1l19zY1uT8U/Is1bnMwWEtas2KEhJG3W2bvebORGQZdYgFDTLApU6q4VZtJELEgvWcv+qZHjWNqxUsg8eH/T0NpQqLE8is+6Tevyg26YVz9resv1iAhu+YUEtNjR8MJcskslIBeqSG6cVkLWae1ELIlHBFRCYdCAfn4KS7NRkQBt7nX847J/QIyw+HbKLn5DXGdOAYIf/BPpTC9lIdKKPLDqNpW81T7H0AJInmkoLhctaGjT9U3oLAB/GDj8Z9S8aUW0IHb1evL91M3HGcD5loq+3/6l86okuOUbUdmPY9Gnv6G9sgipV+ibUXmjIHpRrPK10uJnGrWQ04Sqf2hnpnkhavwnp7ysOHgaHTZGgTcWoCwmOBwEi7IkZId8yauQnCSpVpLgEIi2F3zp6pU1Hs2jhD5PReS0TufOS+9v3+rpU9bvqE9Eb12adjUli5IgVNYQ3fi9w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(136003)(396003)(376002)(39860400002)(478600001)(52536014)(66446008)(71200400001)(55016002)(8936002)(7416002)(54906003)(4326008)(66946007)(76116006)(64756008)(110136005)(83380400001)(9686003)(66476007)(66556008)(86362001)(7696005)(6506007)(8990500004)(82960400001)(82950400001)(33656002)(8676002)(26005)(186003)(316002)(10290500003)(30864003)(5660300002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?K3WtcMHHgVouNQ1zHfePW0YSpSFDlxTKaqNQgDufAaY7p/fozyhDOQ+j/sIg?=
 =?us-ascii?Q?fXJntPQQq/Vyxod/uLEAfA1Bqlf9Sm0VpTwBxOLqjuzP2KRbHLLSPQ6XO6gH?=
 =?us-ascii?Q?CY7RqbQ3cLmc/trbAnFZ6ZqpKUgGOM2/iTj0B80AlcYyDQFEkAKrV7lhtgqe?=
 =?us-ascii?Q?C31M7TLP87F/JiLjJJwKUbJCYPHxBlM7UkeUJD+FREIEa4mGkGrnxc1qX3FF?=
 =?us-ascii?Q?XqFCddJfKaLRSFS4EcYuIjaDz3qWrYEWpphVGU7Pu16vcdOIbBNHIrKXHDu+?=
 =?us-ascii?Q?0Gl4MbTz5WBqL28qdivpgRJv4CnhdaDGc5337jJHD9OHU+XlSu8Z4rhf+Man?=
 =?us-ascii?Q?BSUwVutj0xN95td/RaZxUDBpEscweipjXueBhxfS62+l28WKxvne3T7OGkiI?=
 =?us-ascii?Q?yQxgi8r4SFmgex4OsFVkRxy9LX3ou6hMH0XFdAXxRX0TiZdAPwhqUI8EocpL?=
 =?us-ascii?Q?uKsrop7d/W/IPygLTEDFA9TpYt2N82kury8d0SdqdzEvc760LwGvSDi9sgSl?=
 =?us-ascii?Q?zHzr8GYonmqZcLYuUga9oYrdMQmSBr2XOLmDao0KQxcxrjA+SjFQyPjMBPXh?=
 =?us-ascii?Q?k5XnPz2e3r6DHzlNDl2Lq8mCpyV38lsVN4o7FENJL1LAs3C+naaqfI8MB0Hk?=
 =?us-ascii?Q?pyzD3bERrVOF1XKE6//EAiiiqra98TuCFgO3ZAohnkMt6mVJ5gtNEswsA+NL?=
 =?us-ascii?Q?O2r7Lz7M+RfIZ7N+5vKm2/kRcz60/dnoioQCmtDWgtKTSfZt3EbG8pTrzuxI?=
 =?us-ascii?Q?ilL7BQCsUjcxchJOmZBMqoMjrCdooHe67DZmH3BZg7enUfw1ffIdFGrN6mJe?=
 =?us-ascii?Q?JXjoJ5FdNrgeBEafZJB0YgXJWtY8rj0B2Y5OleCVsuyjoskEb1lurelE5zOo?=
 =?us-ascii?Q?Wri+SnAqUWWsnwGZ40/Tn+Dv0J0BOvw3k0Of5t1DGuute8NJMueULct9TJpx?=
 =?us-ascii?Q?AKuAQWvG/OHO8vYM4A1ZdroIBU91AFlTrDpqir+2XzpVWwNrjY+Sn7IEfo7g?=
 =?us-ascii?Q?FzT54QvrZuFPRHpQ/MK6ojFD2/7LuVeuqpc/Ibhc5TRd+c4hcvpAyuBHlK9z?=
 =?us-ascii?Q?bl7KcPUT?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5ac5807-3614-473b-e93b-08d8c19895d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2021 01:20:36.4075
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n0VntmHLiG2h9hvmX4StQ9fSggOl2m+qcHoKvwNuj0aAr1PAbmqQHYCja6+Y53pCLj8R/Yacm+n1i3Abg6hPZhmUKbrMc2h5ppxIjgqucco=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2101MB0873
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Wei Liu <wei.liu@kernel.org> Sent: Wednesday, January 20, 2021 4:01 A=
M
>=20
> They are used to deposit pages into Microsoft Hypervisor and bring up
> logical and virtual processors.
>=20
> Signed-off-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
> Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> Co-Developed-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
> Co-Developed-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> Co-Developed-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> ---
> v4: Fix compilation issue when CONFIG_ACPI_NUMA is not set.
>=20
> v3:
> 1. Add __packed to structures.
> 2. Drop unnecessary exports.
>=20
> v2:
> 1. Adapt to hypervisor side changes
> 2. Address Vitaly's comments
> ---
>  arch/x86/hyperv/Makefile          |   2 +-
>  arch/x86/hyperv/hv_proc.c         | 225 ++++++++++++++++++++++++++++++
>  arch/x86/include/asm/mshyperv.h   |   4 +
>  include/asm-generic/hyperv-tlfs.h |  67 +++++++++
>  4 files changed, 297 insertions(+), 1 deletion(-)
>  create mode 100644 arch/x86/hyperv/hv_proc.c
>=20
> diff --git a/arch/x86/hyperv/Makefile b/arch/x86/hyperv/Makefile
> index 89b1f74d3225..565358020921 100644
> --- a/arch/x86/hyperv/Makefile
> +++ b/arch/x86/hyperv/Makefile
> @@ -1,6 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  obj-y			:=3D hv_init.o mmu.o nested.o
> -obj-$(CONFIG_X86_64)	+=3D hv_apic.o
> +obj-$(CONFIG_X86_64)	+=3D hv_apic.o hv_proc.o
>=20
>  ifdef CONFIG_X86_64
>  obj-$(CONFIG_PARAVIRT_SPINLOCKS)	+=3D hv_spinlock.o
> diff --git a/arch/x86/hyperv/hv_proc.c b/arch/x86/hyperv/hv_proc.c
> new file mode 100644
> index 000000000000..706097160e2f
> --- /dev/null
> +++ b/arch/x86/hyperv/hv_proc.c
> @@ -0,0 +1,225 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/types.h>
> +#include <linux/version.h>
> +#include <linux/vmalloc.h>
> +#include <linux/mm.h>
> +#include <linux/clockchips.h>
> +#include <linux/acpi.h>
> +#include <linux/hyperv.h>
> +#include <linux/slab.h>
> +#include <linux/cpuhotplug.h>
> +#include <linux/minmax.h>
> +#include <asm/hypervisor.h>
> +#include <asm/mshyperv.h>
> +#include <asm/apic.h>
> +
> +#include <asm/trace/hyperv.h>
> +
> +#define HV_DEPOSIT_MAX_ORDER (8)
> +#define HV_DEPOSIT_MAX (1 << HV_DEPOSIT_MAX_ORDER)

Is there any reason to not let the maximum be 511, which is
how many entries will fit on the hypercall input page?  The
max could be define in terms of HY_HYP_PAGE_SIZE so that
the logical dependency is fully expressed. =20

> +
> +/*
> + * Deposits exact number of pages
> + * Must be called with interrupts enabled
> + * Max 256 pages
> + */
> +int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
> +{
> +	struct page **pages;
> +	int *counts;
> +	int num_allocations;
> +	int i, j, page_count;
> +	int order;
> +	int desired_order;
> +	u16 status;
> +	int ret;
> +	u64 base_pfn;
> +	struct hv_deposit_memory *input_page;
> +	unsigned long flags;
> +
> +	if (num_pages > HV_DEPOSIT_MAX)
> +		return -E2BIG;
> +	if (!num_pages)
> +		return 0;
> +
> +	/* One buffer for page pointers and counts */
> +	pages =3D page_address(alloc_page(GFP_KERNEL));
> +	if (!pages)

Does the above check work?  If alloc_pages() returns NULL, it looks like
page_address() might fault.

> +		return -ENOMEM;
> +
> +	counts =3D kcalloc(HV_DEPOSIT_MAX, sizeof(int), GFP_KERNEL);
> +	if (!counts) {
> +		free_page((unsigned long)pages);
> +		return -ENOMEM;
> +	}
> +
> +	/* Allocate all the pages before disabling interrupts */
> +	num_allocations =3D 0;
> +	i =3D 0;
> +	order =3D HV_DEPOSIT_MAX_ORDER;
> +
> +	while (num_pages) {
> +		/* Find highest order we can actually allocate */
> +		desired_order =3D 31 - __builtin_clz(num_pages);
> +		order =3D min(desired_order, order);

The above seems redundant since request sizes larger than the
max have already been rejected.

> +		do {
> +			pages[i] =3D alloc_pages_node(node, GFP_KERNEL, order);
> +			if (!pages[i]) {
> +				if (!order) {
> +					ret =3D -ENOMEM;
> +					goto err_free_allocations;
> +				}
> +				--order;
> +			}
> +		} while (!pages[i]);

The duplicative test of !pages[i] is somewhat annoying.  How about
this:

		while{!pages[i] =3D alloc_pages_node(node, GFP_KERNEL, order) {
			if (!order) {
				ret =3D -ENOMEM;
				goto err_free_allocations;
			}
			--order;
		}

or if you don't like doing an assignment in the while test:

		while(1) {
			pages[i] =3D alloc_pages_node(node, GFP_KERNEL, order);
			if (page[i])
				break;
			if (!order) {
				ret =3D -ENOMEM;
				goto err_free_allocations;
			}
			--order;
		}

> +
> +		split_page(pages[i], order);
> +		counts[i] =3D 1 << order;
> +		num_pages -=3D counts[i];
> +		i++;
> +		num_allocations++;

Incrementing both I and num_allocations in the loop seems
redundant, especially since num_allocations isn't used in the loop.
Could num_allocations be assigned the value of i once the loop
is exited?  (and num_allocations would not need to be initialized to 0.)=20
Would also have to do the assignment in the error case.

> +	}
> +
> +	local_irq_save(flags);
> +
> +	input_page =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> +
> +	input_page->partition_id =3D partition_id;
> +
> +	/* Populate gpa_page_list - these will fit on the input page */
> +	for (i =3D 0, page_count =3D 0; i < num_allocations; ++i) {
> +		base_pfn =3D page_to_pfn(pages[i]);
> +		for (j =3D 0; j < counts[i]; ++j, ++page_count)
> +			input_page->gpa_page_list[page_count] =3D base_pfn + j;
> +	}
> +	status =3D hv_do_rep_hypercall(HVCALL_DEPOSIT_MEMORY,
> +				     page_count, 0, input_page,
> +				     NULL) & HV_HYPERCALL_RESULT_MASK;

Similar comment about how hypercall status is checked.

> +	local_irq_restore(flags);
> +
> +	if (status !=3D HV_STATUS_SUCCESS) {
> +		pr_err("Failed to deposit pages: %d\n", status);
> +		ret =3D status;
> +		goto err_free_allocations;
> +	}
> +
> +	ret =3D 0;
> +	goto free_buf;
> +
> +err_free_allocations:
> +	for (i =3D 0; i < num_allocations; ++i) {
> +		base_pfn =3D page_to_pfn(pages[i]);
> +		for (j =3D 0; j < counts[i]; ++j)
> +			__free_page(pfn_to_page(base_pfn + j));
> +	}
> +
> +free_buf:
> +	free_page((unsigned long)pages);
> +	kfree(counts);
> +	return ret;
> +}
> +
> +int hv_call_add_logical_proc(int node, u32 lp_index, u32 apic_id)
> +{
> +	struct hv_add_logical_processor_in *input;
> +	struct hv_add_logical_processor_out *output;
> +	int status;
> +	unsigned long flags;
> +	int ret =3D 0;
> +#ifdef CONFIG_ACPI_NUMA
> +	int pxm =3D node_to_pxm(node);
> +#else
> +	int pxm =3D 0;
> +#endif

It seems like the above #ifdef'ery might be better fixed in
include/acpi/acpi_numa.h, where there's already a null definition
of pxm_to_node() in case CONFIG_ACPI_NUMA isn't defined.  There
should also be a null definition of node_to_pxm() in that file.

> +
> +	/*
> +	 * When adding a logical processor, the hypervisor may return
> +	 * HV_STATUS_INSUFFICIENT_MEMORY. When that happens, we deposit more
> +	 * pages and retry.
> +	 */
> +	do {
> +		local_irq_save(flags);
> +
> +		input =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> +		/* We don't do anything with the output right now */
> +		output =3D *this_cpu_ptr(hyperv_pcpu_output_arg);
> +
> +		input->lp_index =3D lp_index;
> +		input->apic_id =3D apic_id;
> +		input->flags =3D 0;
> +		input->proximity_domain_info.domain_id =3D pxm;
> +		input->proximity_domain_info.flags.reserved =3D 0;
> +		input->proximity_domain_info.flags.proximity_info_valid =3D 1;
> +		input->proximity_domain_info.flags.proximity_preferred =3D 1;
> +		status =3D hv_do_hypercall(HVCALL_ADD_LOGICAL_PROCESSOR,
> +					 input, output);
> +		local_irq_restore(flags);
> +
> +		if (status !=3D HV_STATUS_INSUFFICIENT_MEMORY) {

The 'and' with HV_HYPERCALL_RESULT_MASK isn't coded anywhere for this
hypercall, and 'status' is declared as 'int'.

> +			if (status !=3D HV_STATUS_SUCCESS) {
> +				pr_err("%s: cpu %u apic ID %u, %d\n", __func__,
> +				       lp_index, apic_id, status);
> +				ret =3D status;
> +			}
> +			break;
> +		}
> +		ret =3D hv_call_deposit_pages(node, hv_current_partition_id, 1);
> +	} while (!ret);
> +
> +	return ret;
> +}
> +
> +int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flag=
s)
> +{
> +	struct hv_create_vp *input;
> +	u16 status;
> +	unsigned long irq_flags;
> +	int ret =3D 0;
> +#ifdef CONFIG_ACPI_NUMA
> +	int pxm =3D node_to_pxm(node);
> +#else
> +	int pxm =3D 0;
> +#endif

Same comment.

> +
> +	/* Root VPs don't seem to need pages deposited */
> +	if (partition_id !=3D hv_current_partition_id) {
> +		ret =3D hv_call_deposit_pages(node, partition_id, 90);

Perhaps add a comment about the value "90".  Was it
empirically determined?

> +		if (ret)
> +			return ret;
> +	}
> +
> +	do {
> +		local_irq_save(irq_flags);
> +
> +		input =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> +
> +		input->partition_id =3D partition_id;
> +		input->vp_index =3D vp_index;
> +		input->flags =3D flags;
> +		input->subnode_type =3D HvSubnodeAny;
> +		if (node !=3D NUMA_NO_NODE) {
> +			input->proximity_domain_info.domain_id =3D pxm;
> +			input->proximity_domain_info.flags.reserved =3D 0;
> +			input->proximity_domain_info.flags.proximity_info_valid =3D 1;
> +			input->proximity_domain_info.flags.proximity_preferred =3D 1;
> +		} else {
> +			input->proximity_domain_info.as_uint64 =3D 0;
> +		}
> +		status =3D hv_do_hypercall(HVCALL_CREATE_VP, input, NULL);
> +		local_irq_restore(irq_flags);
> +
> +		if (status !=3D HV_STATUS_INSUFFICIENT_MEMORY) {

Same problems with the status check.

> +			if (status !=3D HV_STATUS_SUCCESS) {
> +				pr_err("%s: vcpu %u, lp %u, %d\n", __func__,
> +				       vp_index, flags, status);
> +				ret =3D status;
> +			}
> +			break;
> +		}
> +		ret =3D hv_call_deposit_pages(node, partition_id, 1);
> +
> +	} while (!ret);
> +
> +	return ret;
> +}
> +
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyp=
erv.h
> index 67f5d35a73d3..4e590a167160 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -80,6 +80,10 @@ extern void  __percpu  **hyperv_pcpu_output_arg;
>=20
>  extern u64 hv_current_partition_id;
>=20
> +int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages);
> +int hv_call_add_logical_proc(int node, u32 lp_index, u32 acpi_id);
> +int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flag=
s);
> +
>  static inline u64 hv_do_hypercall(u64 control, void *input, void *output=
)
>  {
>  	u64 input_address =3D input ? virt_to_phys(input) : 0;
> diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hype=
rv-tlfs.h
> index 87b1a79b19eb..ec53570102f0 100644
> --- a/include/asm-generic/hyperv-tlfs.h
> +++ b/include/asm-generic/hyperv-tlfs.h
> @@ -142,6 +142,8 @@ struct ms_hyperv_tsc_page {
>  #define HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST_EX	0x0014
>  #define HVCALL_SEND_IPI_EX			0x0015
>  #define HVCALL_GET_PARTITION_ID			0x0046
> +#define HVCALL_DEPOSIT_MEMORY			0x0048
> +#define HVCALL_CREATE_VP			0x004e
>  #define HVCALL_GET_VP_REGISTERS			0x0050
>  #define HVCALL_SET_VP_REGISTERS			0x0051
>  #define HVCALL_POST_MESSAGE			0x005c
> @@ -149,6 +151,7 @@ struct ms_hyperv_tsc_page {
>  #define HVCALL_POST_DEBUG_DATA			0x0069
>  #define HVCALL_RETRIEVE_DEBUG_DATA		0x006a
>  #define HVCALL_RESET_DEBUG_SESSION		0x006b
> +#define HVCALL_ADD_LOGICAL_PROCESSOR		0x0076
>  #define HVCALL_RETARGET_INTERRUPT		0x007e
>  #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_SPACE 0x00af
>  #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_LIST 0x00b0
> @@ -413,6 +416,70 @@ struct hv_get_partition_id {
>  	u64 partition_id;
>  } __packed;
>=20
> +/* HvDepositMemory hypercall */
> +struct hv_deposit_memory {
> +	u64 partition_id;
> +	u64 gpa_page_list[];
> +} __packed;
> +
> +struct hv_proximity_domain_flags {
> +	u32 proximity_preferred : 1;
> +	u32 reserved : 30;
> +	u32 proximity_info_valid : 1;
> +} __packed;
> +
> +/* Not a union in windows but useful for zeroing */
> +union hv_proximity_domain_info {
> +	struct {
> +		u32 domain_id;
> +		struct hv_proximity_domain_flags flags;
> +	};
> +	u64 as_uint64;
> +} __packed;
> +
> +struct hv_lp_startup_status {
> +	u64 hv_status;
> +	u64 substatus1;
> +	u64 substatus2;
> +	u64 substatus3;
> +	u64 substatus4;
> +	u64 substatus5;
> +	u64 substatus6;
> +} __packed;
> +
> +/* HvAddLogicalProcessor hypercall */
> +struct hv_add_logical_processor_in {
> +	u32 lp_index;
> +	u32 apic_id;
> +	union hv_proximity_domain_info proximity_domain_info;
> +	u64 flags;
> +};

__packed is missing from this struct definition

> +
> +struct hv_add_logical_processor_out {
> +	struct hv_lp_startup_status startup_status;
> +} __packed;
> +
> +enum HV_SUBNODE_TYPE
> +{
> +    HvSubnodeAny =3D 0,
> +    HvSubnodeSocket,
> +    HvSubnodeAmdNode,
> +    HvSubnodeL3,
> +    HvSubnodeCount,
> +    HvSubnodeInvalid =3D -1
> +};

Are these values defined by Hyper-V?  If so, explicitly coding the
value of each enum member might be better.

> +
> +/* HvCreateVp hypercall */
> +struct hv_create_vp {
> +	u64 partition_id;
> +	u32 vp_index;
> +	u8 padding[3];
> +	u8 subnode_type;
> +	u64 subnode_id;
> +	union hv_proximity_domain_info proximity_domain_info;
> +	u64 flags;
> +} __packed;
> +
>  /* HvRetargetDeviceInterrupt hypercall */
>  union hv_msi_entry {
>  	u64 as_uint64;
> --
> 2.20.1

