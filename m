Return-Path: <linux-arch+bounces-10923-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 713D2A6631D
	for <lists+linux-arch@lfdr.de>; Tue, 18 Mar 2025 00:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F19E17867B
	for <lists+linux-arch@lfdr.de>; Mon, 17 Mar 2025 23:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 942B9209696;
	Mon, 17 Mar 2025 23:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="cbBeqaNu"
X-Original-To: linux-arch@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazolkn19010007.outbound.protection.outlook.com [52.103.11.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931C9206F31;
	Mon, 17 Mar 2025 23:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.11.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742255522; cv=fail; b=Dn3zIAr5UJMz4Vx6DwueNJ0tfl1ZFOLWdrRA02wEe7R097ugLeLzHddRuhKzh+jmo9SYA1w/2LxQF46g8AOvOTRechm9f++qA2Nx+mWMjO3KKXCE0uWaWIembWi4fhuNDV1cfHqe2RXN+pUAy73YMyZ2IeM/x4CkrcxXjwat/R8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742255522; c=relaxed/simple;
	bh=8O1QjQYwXCaTFRIMpaLrTQPcdgkzMUWCLCt4VCFPepw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=N6KbFcpRy2HHNqJeNd7ElV//We+PIvOj1OaKnTsrIAJQwan28Uwbgf4im/iJcXFjo21yiJNAqy1wr3fFjgcwgWiSihFm/xEjrdH3ztU18vy0I1vy0SFguptiTyqoFcbG79Y29XbxBHcGsg2j6OX4vlrZhWYNOfhjIGQwGdwr6Gs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=cbBeqaNu; arc=fail smtp.client-ip=52.103.11.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ezw84viaaj0XNPCTe7Un99J/XI+hJVdBl37qneZI2FNsIO+r3i6/EXNmSe+vC0HYzjeHCuEXAgpTbhbjhf0K16X+BisZzz3q+fw2hBEI7R7fIylB1xtAlvu8zi1J/c3N/zB4B2W3u7LiS55FjxWpgdfi1aujuXG0Nv1unlc/nJm//oY0pYS/I0DF0PK+0cHTnyLoFA0+26CRVPuIN3LWVyiUgpqeAsNKISahLTJO4+eKzUbRyYNi9sLnjR16hclgQPGU9mSaB3dOgCWKHGBPt6BW3Hmw5lTwQd4qc0qAoaGGHLRrZaucGYutxvp0Hpxjsau03UqYw2Fluo6vC9x49Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ef1Owl4eqlRDFzCKyzrzxHFZk8bF9/C5WPA9rbqbWo=;
 b=kFIu13bUSzVcRsxlp8RX9NdM0qVpgYi6V+Ut2KgpJruBQVacK9RhL5whWRx3ttGajLVfYeVk3kFAI+fJ2sCZL2l4iuYpCWRGLLPtQojIyKz5H0gq66tYxvdxe4X74YZmvgdzyaHlkJE04a4bmQvMnellH9RQ60VishCNIrXDVQRaL3ajYvV2sW+Xncm/nMF0CBEoCyiQBIA9rADWhiDzKKqvFgQs+yu3BnFcbqvmr1VQUOtZ3gkAMXl+/LTfMKbDICBR7oE28PIV9Z9f7E1wxSBfgNOTw7Gj891oJW4VUzrZ4AbjkRZrVhZlbxPhn46Ra8EjV5fXonC/AHDS5LWMuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ef1Owl4eqlRDFzCKyzrzxHFZk8bF9/C5WPA9rbqbWo=;
 b=cbBeqaNuKquWU2kj/GP3Md4W3nIWttQ+wzb5j1IpRIGC+e2tJ7OkGczxdHZIja8qoGCSsSO6XDjf6ldHf/DiVSLijhRg3KEy9PKHr2vSFQeLUZe9sEDmZtMQgbBqJg6/eta4KJnU5ohJBSWzGoLlm+3uHd24fuLlf6svwLDrh/3iUQyV2KLOBEdzdlDQMyslLgqE/OYSR0kbWoKkyPKbxewh7V7GZ3B8TGdjwDup43Wq4f92Mmzx2N8+uuxTqpadEZdpWqDB7pXQk9o+W9ikZglQJwJDjy6CwJMH655mvtIA2IsQSwPDUmvDHeieK70e7OPFml8d60QxFL/XeQIwnQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DM8PR02MB8054.namprd02.prod.outlook.com (2603:10b6:8:17::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 23:51:53 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 23:51:53 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>
CC: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>, "will@kernel.org" <will@kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "hpa@zytor.com"
	<hpa@zytor.com>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
	"joro@8bytes.org" <joro@8bytes.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "arnd@arndb.de" <arnd@arndb.de>,
	"jinankjain@linux.microsoft.com" <jinankjain@linux.microsoft.com>,
	"muminulrussell@gmail.com" <muminulrussell@gmail.com>,
	"skinsburskii@linux.microsoft.com" <skinsburskii@linux.microsoft.com>,
	"mrathor@linux.microsoft.com" <mrathor@linux.microsoft.com>,
	"ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
	"apais@linux.microsoft.com" <apais@linux.microsoft.com>,
	"Tianyu.Lan@microsoft.com" <Tianyu.Lan@microsoft.com>,
	"stanislav.kinsburskiy@gmail.com" <stanislav.kinsburskiy@gmail.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"vkuznets@redhat.com" <vkuznets@redhat.com>, "prapal@linux.microsoft.com"
	<prapal@linux.microsoft.com>, "muislam@microsoft.com"
	<muislam@microsoft.com>, "anrayabh@linux.microsoft.com"
	<anrayabh@linux.microsoft.com>, "rafael@kernel.org" <rafael@kernel.org>,
	"lenb@kernel.org" <lenb@kernel.org>, "corbet@lwn.net" <corbet@lwn.net>
Subject: RE: [PATCH v5 10/10] Drivers: hv: Introduce mshv_root module to
 expose /dev/mshv to VMMs
Thread-Topic: [PATCH v5 10/10] Drivers: hv: Introduce mshv_root module to
 expose /dev/mshv to VMMs
Thread-Index: AQHbiKNt140GtdgK20KtRyAXlJwH1rNxYTIg
Date: Mon, 17 Mar 2025 23:51:52 +0000
Message-ID:
 <SN6PR02MB4157BE8AF5A1CDD39CF31124D4DF2@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <1740611284-27506-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1740611284-27506-11-git-send-email-nunodasneves@linux.microsoft.com>
In-Reply-To:
 <1740611284-27506-11-git-send-email-nunodasneves@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DM8PR02MB8054:EE_
x-ms-office365-filtering-correlation-id: fda1e956-e451-48d6-efad-08dd65aeb12e
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|8062599003|12121999004|19110799003|15080799006|8060799006|10035399004|440099028|3412199025|4302099013|12091999003|18061999006|30101999003|41001999003|102099032|56899033|1602099012;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?1DcNSB1lUEjhiqw3ZrcsPuKSsFY3cLQHA/ZBwmUhN5G7C9GNm85c7l92EbK2?=
 =?us-ascii?Q?3oNJXPpAdyo/s/HrK+ru6dSx0B6x/dr8mNFXrXumRkC1gqIhYO7qoGzqvfpL?=
 =?us-ascii?Q?BHwL5MyumSKFDDShn3Xkp0CgKISUCcUGXu8NOshGoY68ynZgo7WTdBeamhek?=
 =?us-ascii?Q?03BtlZUh7R4MsMAUHU6owEvre870ZZmhmouRZFORc0ad1FoiCHW+BGOi02fC?=
 =?us-ascii?Q?vW4RXTsIs4gNtBrm96O0vaZkKeR+l9OlJ0tyl7H01kf16qot1IQgfNYnmQ8E?=
 =?us-ascii?Q?tT74geWQqTE5uFnDt84Lz1LgP7q1XDc4Go/vY9yxXY+cmAJ4RI5KnDI8n8XQ?=
 =?us-ascii?Q?CUmuHCxP44tjDmcTrxmUvqC7qLgYaIOnowlOCoAIrv/VVe6y99+b27sGaM+/?=
 =?us-ascii?Q?GzRFD4/sWugB3mmGFis0YJBhJ5T9zljZE0m/cLXHREDy2Fn5kE+FjknQrhBX?=
 =?us-ascii?Q?xaSRJXxmbA8PfSlxp7y/M8D4SILG/FFB2huwF3c9oe7WXFNB/IkVPiWcuAtw?=
 =?us-ascii?Q?7YW/HpSl7zHN8MAUWO+HU3vnk5TDvoilcQws19iisfbUekSkiAW958zEbSqd?=
 =?us-ascii?Q?qME8CbX53qtx/KW7uAF9EtkAsOH27oInHQMD6GJHqoBjz9INl6yHM0O2kObT?=
 =?us-ascii?Q?sE9pV/HVcK3AX61n7raDfpdzgR6U5xcBY1QLu0X4iykFATuON2dq67jsJwgj?=
 =?us-ascii?Q?1zB02lnl6Ohyx1OWpMJ6oj9iRt/A2OIIcp5VWs1bn9YneQttabACiOgwn6Wz?=
 =?us-ascii?Q?R5F74PMDHawRnX/53NqEshlhXLuWfm5rXKak6jfvJWnuF8OJJkg2wk297b6o?=
 =?us-ascii?Q?cZ4GUv1tvZeHfYEDb+Oot9tHGJ1+YVzAO4teZosyKwq4gFeFU1T1wHncG8QF?=
 =?us-ascii?Q?WByFJYVhJXzSBqwbV2hWpe/eL5YzHPR5UxKrk4DISmTQ5H0wcv2RD/NQvRWq?=
 =?us-ascii?Q?GtJdsKzFdb8fxVQu9ctMudN4E6pT2bvVzdg64NXbr0piuxynBdjLIcc4emRG?=
 =?us-ascii?Q?V9gXfVbkJfXmGdoUUAcB4Wv9eIvYElxTebFPfGs01gZGAsZ9lAnOvctdaPjV?=
 =?us-ascii?Q?1J3UsMEEhsI/kHhFPkW4AosUUD7N0gfC7mKVRT7ieSORqhOMgXoLjrkQ4hJI?=
 =?us-ascii?Q?FhEY1UCCHPnG21RHxnCwGmQf721kVYMGNn3of2FJluWJp591xsPcM7o9sAzM?=
 =?us-ascii?Q?5e6PYp9s6A+qBjY0gKXQr6LiZAy04cX2I4VZAWayP4bPpsk+c1p8Q5klozy9?=
 =?us-ascii?Q?5LJtuVUZ5WjPeV5gNNvqk7DlNOh4Vp2CxBJckALo3i7hckqHFEL+Dm18LBwE?=
 =?us-ascii?Q?DLHjE2GPTACzRxWF4h180dgkh7idmA3INR9JC5bmg/0FQLprKhXDKMPeZLzY?=
 =?us-ascii?Q?Bi1gjHE=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?KDhWefrPtriCOhzaK/qWdZkXXieoJpsVkPPQHdG5ffH0vEZVCZdL3Aun8egk?=
 =?us-ascii?Q?HTD+fRJVA3/eIPrlzG9TLgV+f7hseAneeBB3FQlmGZHP9iyQMFqFIqfrGnq0?=
 =?us-ascii?Q?QeqBfOjc2sVHyidg6ZtjOQoKLIRgIIA1ggVMNdWP5aTfeghoqvFFXKTGV+CA?=
 =?us-ascii?Q?7e7xOyPoQ5LlGXnig6OQYix0efdC8vvTCY40dRSD67cBCcNPMYX8Wu4wWxjA?=
 =?us-ascii?Q?DJwDPfdXX9f2Xm3erQxMfU87BXcWl5U4G8Sob/ietK7Zq/f51ADxACLACj+q?=
 =?us-ascii?Q?sFTKpY0URt1F55ilwFrFRIFSbhPYyfyVBSo4pLfaGsIixgSRIPfomJJbGd01?=
 =?us-ascii?Q?gBCMOOkE8LEz7XqpLIQ0BmPnFQ6Av+/Q+WF24Y2h66BUTez/j5kQ+2CbYevI?=
 =?us-ascii?Q?PPPewgGgk5uAow9CRZrPwh7MQrQ6WOUNDEMXehrqh0q5higTUZXcE4XSlWFh?=
 =?us-ascii?Q?trLPValzQluEua7tAl+hJQNYpw1fbW3jnyN563vmmbCUycnkaXca3CLin3Yy?=
 =?us-ascii?Q?srCTyioU++3oRrol8LzdgFWBA/mgGqaXodIpZ3xrZ10qi25pmyX3pTVzj5DX?=
 =?us-ascii?Q?KEQCYTEIVTLvIYfVoWLxBLoNVwLhnxDmSZ54jd4+mwayiDU3iR4ygvhShy0I?=
 =?us-ascii?Q?FpR5m878lB5B4ek86x3h2I8WuqOgZCXQl9zAnP1nGtENtaARHAUAP87axEz0?=
 =?us-ascii?Q?JNzWm0uS+RXGoZgfwB4Lf523MIblO/Sq/BH59n2M1wktQOOeIHQEi271IyW7?=
 =?us-ascii?Q?mQwlDhNxMMz50N1UIf0Ntn/IZkuAAOIcjZ0XgzRMMP0RvmQ9deio9UsabvZy?=
 =?us-ascii?Q?ftnhzLfJhTZhQFV7VGH9eFsw8OT8y+ok1XgFVXV45vnMj0JXC7V7OHMXJ4MJ?=
 =?us-ascii?Q?h3p2pD9dMtXG8fywq6bf31qB3QtPD8nHA4TKaSaFd3tvlTXQK/m0vZVHK4tj?=
 =?us-ascii?Q?1C3hCLT8cPl3uD8d3fmU1ARxiOSrWwiPnf6b1efMOM9iaWuNaUQGCNvN6LXy?=
 =?us-ascii?Q?zoIc2/dX3Yy9wMm2MeWgJGw/OsinPxV9Xj4FY4anlRxd0RTzukEXUZL4CMeK?=
 =?us-ascii?Q?tRKhyU2IyBlC0hbFIuFkVXTD+NBXqsldc4Zvy/+2OECt5EyUMDDKhElp+0lU?=
 =?us-ascii?Q?mXEtZV5yxV3e2Ilx09rn+AtE1H84EPj3AKjFl7Q+Rq9SM86cYj0n63C54zhs?=
 =?us-ascii?Q?MXIpB7R15z9QnZFkddB5wFo9zzYfFAW9/i5+X5KjC3um/oPIeOUA9qJsLOU?=
 =?us-ascii?Q?=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: fda1e956-e451-48d6-efad-08dd65aeb12e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2025 23:51:52.7761
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR02MB8054

From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Wednesday, Fe=
bruary 26, 2025 3:08 PM
>=20

This is part 2 of my review of this large patch.

[snipping what I already reviewed or decided to skip in part 1 of my review=
 ]

> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> new file mode 100644
> index 000000000000..fed19aa80049
> --- /dev/null
> +++ b/drivers/hv/mshv_root_main.c
> @@ -0,0 +1,2329 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2024, Microsoft Corporation.
> + *
> + * The main part of the mshv_root module, providing APIs to create
> + * and manage guest partitions.
> + *
> + * Authors: Microsoft Linux virtualization team
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/fs.h>
> +#include <linux/miscdevice.h>
> +#include <linux/slab.h>
> +#include <linux/file.h>
> +#include <linux/anon_inodes.h>
> +#include <linux/mm.h>
> +#include <linux/io.h>
> +#include <linux/cpuhotplug.h>
> +#include <linux/random.h>
> +#include <asm/mshyperv.h>
> +#include <linux/hyperv.h>
> +#include <linux/notifier.h>
> +#include <linux/reboot.h>
> +#include <linux/kexec.h>
> +#include <linux/page-flags.h>
> +#include <linux/crash_dump.h>
> +#include <linux/panic_notifier.h>
> +#include <linux/vmalloc.h>
> +
> +#include "mshv_eventfd.h"
> +#include "mshv.h"
> +#include "mshv_root.h"
> +
> +/* TODO move this to mshyperv.h when needed outside driver */
> +static inline bool hv_parent_partition(void)
> +{
> +	return hv_root_partition();
> +}
> +
> +/* TODO move this to another file when debugfs code is added */
> +enum hv_stats_vp_counters {			/* HV_THREAD_COUNTER */
> +#if defined(CONFIG_X86)
> +	VpRootDispatchThreadBlocked			=3D 201,
> +#elif defined(CONFIG_ARM64)
> +	VpRootDispatchThreadBlocked			=3D 94,
> +#endif
> +	VpStatsMaxCounter
> +};

Where do these "magic" numbers come from?  Are they matching something
in the Hyper-V host?

> +
> +struct hv_stats_page {
> +	union {
> +		u64 vp_cntrs[VpStatsMaxCounter];		/* VP counters */
> +		u8 data[HV_HYP_PAGE_SIZE];
> +	};
> +} __packed;
> +
> +struct mshv_root mshv_root =3D {};

Initializer is unnecessary for global variables. They are already set to ze=
ro.

> +
> +enum hv_scheduler_type hv_scheduler_type;
> +
> +/* Once we implement the fast extended hypercall ABI they can go away. *=
/
> +static void __percpu **root_scheduler_input;
> +static void __percpu **root_scheduler_output;

The __percpu is probably in the wrong place like mentioned in earlier
patches in this series.

> +
> +static long mshv_dev_ioctl(struct file *filp, unsigned int ioctl, unsign=
ed long arg);
> +static int mshv_dev_open(struct inode *inode, struct file *filp);
> +static int mshv_dev_release(struct inode *inode, struct file *filp);
> +static int mshv_vp_release(struct inode *inode, struct file *filp);
> +static long mshv_vp_ioctl(struct file *filp, unsigned int ioctl, unsigne=
d long arg);
> +static int mshv_partition_release(struct inode *inode, struct file *filp=
);
> +static long mshv_partition_ioctl(struct file *filp, unsigned int ioctl, =
unsigned long arg);
> +static int mshv_vp_mmap(struct file *file, struct vm_area_struct *vma);
> +static vm_fault_t mshv_vp_fault(struct vm_fault *vmf);
> +static int mshv_init_async_handler(struct mshv_partition *partition);
> +static void mshv_async_hvcall_handler(void *data, u64 *status);
> +
> +static const struct vm_operations_struct mshv_vp_vm_ops =3D {
> +	.fault =3D mshv_vp_fault,
> +};
> +
> +static const struct file_operations mshv_vp_fops =3D {
> +	.owner =3D THIS_MODULE,
> +	.release =3D mshv_vp_release,
> +	.unlocked_ioctl =3D mshv_vp_ioctl,
> +	.llseek =3D noop_llseek,
> +	.mmap =3D mshv_vp_mmap,
> +};
> +
> +static const struct file_operations mshv_partition_fops =3D {
> +	.owner =3D THIS_MODULE,
> +	.release =3D mshv_partition_release,
> +	.unlocked_ioctl =3D mshv_partition_ioctl,
> +	.llseek =3D noop_llseek,
> +};
> +
> +static const struct file_operations mshv_dev_fops =3D {
> +	.owner =3D THIS_MODULE,
> +	.open =3D mshv_dev_open,
> +	.release =3D mshv_dev_release,
> +	.unlocked_ioctl =3D mshv_dev_ioctl,
> +	.llseek =3D noop_llseek,
> +};
> +
> +static struct miscdevice mshv_dev =3D {
> +	.minor =3D MISC_DYNAMIC_MINOR,
> +	.name =3D "mshv",
> +	.fops =3D &mshv_dev_fops,
> +	.mode =3D 0600,
> +};
> +
> +/*
> + * Only allow hypercalls that have a u64 partition id as the first membe=
r of
> + * the input structure.
> + * These are sorted by value.
> + */
> +static u16 mshv_passthru_hvcalls[] =3D {
> +	HVCALL_GET_PARTITION_PROPERTY,
> +	HVCALL_SET_PARTITION_PROPERTY,
> +	HVCALL_INSTALL_INTERCEPT,
> +	HVCALL_GET_VP_REGISTERS,
> +	HVCALL_SET_VP_REGISTERS,
> +	HVCALL_TRANSLATE_VIRTUAL_ADDRESS,
> +	HVCALL_CLEAR_VIRTUAL_INTERRUPT,
> +	HVCALL_REGISTER_INTERCEPT_RESULT,
> +	HVCALL_ASSERT_VIRTUAL_INTERRUPT,
> +	HVCALL_GET_GPA_PAGES_ACCESS_STATES,
> +	HVCALL_SIGNAL_EVENT_DIRECT,
> +	HVCALL_POST_MESSAGE_DIRECT,
> +	HVCALL_GET_VP_CPUID_VALUES,
> +};
> +
> +static bool mshv_hvcall_is_async(u16 code)
> +{
> +	switch (code) {
> +	case HVCALL_SET_PARTITION_PROPERTY:
> +		return true;
> +	default:
> +		break;
> +	}
> +	return false;
> +}
> +
> +static int mshv_ioctl_passthru_hvcall(struct mshv_partition *partition,
> +				      bool partition_locked,
> +				      void __user *user_args)
> +{
> +	u64 status;
> +	int ret, i;

'ret' should be initialized to 0. There's a path through this function that
never sets 'ret' and the return value would be stack garbage.

> +	bool is_async;
> +	struct mshv_root_hvcall args;
> +	struct page *page;
> +	unsigned int pages_order;
> +	void *input_pg =3D NULL;
> +	void *output_pg =3D NULL;
> +
> +	if (copy_from_user(&args, user_args, sizeof(args)))
> +		return -EFAULT;
> +
> +	if (args.status || !args.in_ptr || args.in_sz < sizeof(u64) ||
> +	    mshv_field_nonzero(args, rsvd) || args.in_sz > HV_HYP_PAGE_SIZE)
> +		return -EINVAL;
> +
> +	if (args.out_ptr && (!args.out_sz || args.out_sz > HV_HYP_PAGE_SIZE))
> +		return -EINVAL;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(mshv_passthru_hvcalls); ++i)
> +		if (args.code =3D=3D mshv_passthru_hvcalls[i])
> +			break;
> +
> +	if (i >=3D ARRAY_SIZE(mshv_passthru_hvcalls))
> +		return -EINVAL;
> +
> +	is_async =3D mshv_hvcall_is_async(args.code);
> +	if (is_async) {
> +		/* async hypercalls can only be called from partition fd */
> +		if (!partition_locked)
> +			return -EINVAL;
> +		ret =3D mshv_init_async_handler(partition);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	pages_order =3D args.out_ptr ? 1 : 0;
> +	page =3D alloc_pages(GFP_KERNEL, pages_order);
> +	if (!page)
> +		return -ENOMEM;
> +	input_pg =3D page_address(page);
> +
> +	if (args.out_ptr)
> +		output_pg =3D (char *)input_pg + PAGE_SIZE;
> +	else
> +		output_pg =3D NULL;
> +
> +	if (copy_from_user(input_pg, (void __user *)args.in_ptr,
> +			   args.in_sz)) {
> +		ret =3D -EFAULT;
> +		goto free_pages_out;
> +	}
> +
> +	/*
> +	 * NOTE: This only works because all the allowed hypercalls' input
> +	 * structs begin with a u64 partition_id field.
> +	 */
> +	*(u64 *)input_pg =3D partition->pt_id;
> +
> +	if (args.reps)
> +		status =3D hv_do_rep_hypercall(args.code, args.reps, 0,
> +					     input_pg, output_pg);
> +	else
> +		status =3D hv_do_hypercall(args.code, input_pg, output_pg);
> +
> +	if (hv_result(status) =3D=3D HV_STATUS_CALL_PENDING) {
> +		if (is_async) {
> +			mshv_async_hvcall_handler(partition, &status);
> +		} else { /* Paranoia check. This shouldn't happen! */
> +			ret =3D -EBADFD;
> +			goto free_pages_out;
> +		}
> +	}
> +
> +	if (hv_result(status) =3D=3D HV_STATUS_INSUFFICIENT_MEMORY) {
> +		ret =3D hv_call_deposit_pages(NUMA_NO_NODE, partition->pt_id, 1);
> +		if (!ret)
> +			ret =3D -EAGAIN;
> +	} else if (!hv_result_success(status)) {
> +		ret =3D hv_result_to_errno(status);
> +	}
> +
> +	/*
> +	 * Always return the status and output data regardless of result.
> +	 * The VMM may need it to determine how to proceed. E.g. the status may
> +	 * contain the number of reps completed if a rep hypercall partially
> +	 * succeeded.
> +	 */
> +	args.status =3D hv_result(status);
> +	args.reps =3D args.reps ? hv_repcomp(status) : 0;
> +	if (copy_to_user(user_args, &args, sizeof(args)))
> +		ret =3D -EFAULT;
> +
> +	if (output_pg &&
> +	    copy_to_user((void __user *)args.out_ptr, output_pg, args.out_sz))
> +		ret =3D -EFAULT;
> +
> +free_pages_out:
> +	free_pages((unsigned long)input_pg, pages_order);
> +
> +	return ret;
> +}
> +
> +static inline bool is_ghcb_mapping_available(void)
> +{
> +#if IS_ENABLED(CONFIG_X86_64)
> +	return ms_hyperv.ext_features & HV_VP_GHCB_ROOT_MAPPING_AVAILABLE;
> +#else
> +	return 0;
> +#endif
> +}
> +
> +static int mshv_get_vp_registers(u32 vp_index, u64 partition_id, u16 cou=
nt,
> +				 struct hv_register_assoc *registers)
> +{
> +	union hv_input_vtl input_vtl;
> +
> +	input_vtl.as_uint8 =3D 0;
> +	return hv_call_get_vp_registers(vp_index, partition_id,
> +					count, input_vtl, registers);
> +}
> +
> +static int mshv_set_vp_registers(u32 vp_index, u64 partition_id, u16 cou=
nt,
> +				 struct hv_register_assoc *registers)
> +{
> +	union hv_input_vtl input_vtl;
> +
> +	input_vtl.as_uint8 =3D 0;
> +	return hv_call_set_vp_registers(vp_index, partition_id,
> +					count, input_vtl, registers);
> +}
> +
> +/*
> + * Explicit guest vCPU suspend is asynchronous by nature (as it is reque=
sted by
> + * dom0 vCPU for guest vCPU) and thus it can race with "intercept" suspe=
nd,
> + * done by the hypervisor.
> + * "Intercept" suspend leads to asynchronous message delivery to dom0 wh=
ich
> + * should be awaited to keep the VP loop consistent (i.e. no message pen=
ding
> + * upon VP resume).
> + * VP intercept suspend can't be done when the VP is explicitly suspende=
d
> + * already, and thus can be only two possible race scenarios:
> + *   1. implicit suspend bit set -> explicit suspend bit set -> message =
sent
> + *   2. implicit suspend bit set -> message sent -> explicit suspend bit=
 set
> + * Checking for implicit suspend bit set after explicit suspend request =
has
> + * succeeded in either case allows us to reliably identify, if there is =
a
> + * message to receive and deliver to VMM.
> + */
> +static long

For this function, why is the return type "long" instead of "int"?  Same
question for several other functions below.  "long" works, but it's another
case of being gratuitously atypical -- unless there's a reason.

> +mshv_suspend_vp(const struct mshv_vp *vp, bool *message_in_flight)
> +{
> +	struct hv_register_assoc explicit_suspend =3D {
> +		.name =3D HV_REGISTER_EXPLICIT_SUSPEND
> +	};
> +	struct hv_register_assoc intercept_suspend =3D {
> +		.name =3D HV_REGISTER_INTERCEPT_SUSPEND
> +	};
> +	union hv_explicit_suspend_register *es =3D
> +		&explicit_suspend.value.explicit_suspend;
> +	union hv_intercept_suspend_register *is =3D
> +		&intercept_suspend.value.intercept_suspend;
> +	int ret;
> +
> +	es->suspended =3D 1;
> +
> +	ret =3D mshv_set_vp_registers(vp->vp_index, vp->vp_partition->pt_id,
> +				    1, &explicit_suspend);
> +	if (ret) {
> +		vp_err(vp, "Failed to explicitly suspend vCPU\n");
> +		return ret;
> +	}
> +
> +	ret =3D mshv_get_vp_registers(vp->vp_index, vp->vp_partition->pt_id,
> +				    1, &intercept_suspend);
> +	if (ret) {
> +		vp_err(vp, "Failed to get intercept suspend state\n");
> +		return ret;
> +	}
> +
> +	*message_in_flight =3D is->suspended;
> +
> +	return 0;
> +}
> +
> +/*
> + * This function is used when VPs are scheduled by the hypervisor's
> + * scheduler.
> + *
> + * Caller has to make sure the registers contain cleared
> + * HV_REGISTER_INTERCEPT_SUSPEND and HV_REGISTER_EXPLICIT_SUSPEND regist=
ers
> + * exactly in this order (the hypervisor clears them sequentially) to av=
oid
> + * potential invalid clearing a newly arrived HV_REGISTER_INTERCEPT_SUSP=
END
> + * after VP is released from HV_REGISTER_EXPLICIT_SUSPEND in case of the
> + * opposite order.
> + */
> +static long mshv_run_vp_with_hyp_scheduler(struct mshv_vp *vp)
> +{
> +	long ret;
> +	struct hv_register_assoc suspend_regs[2] =3D {
> +			{ .name =3D HV_REGISTER_INTERCEPT_SUSPEND },
> +			{ .name =3D HV_REGISTER_EXPLICIT_SUSPEND }
> +	};
> +	size_t count =3D ARRAY_SIZE(suspend_regs);
> +
> +	/* Resume VP execution */
> +	ret =3D mshv_set_vp_registers(vp->vp_index, vp->vp_partition->pt_id,
> +				    count, suspend_regs);
> +	if (ret) {
> +		vp_err(vp, "Failed to resume vp execution. %lx\n", ret);
> +		return ret;
> +	}
> +
> +	ret =3D wait_event_interruptible(vp->run.vp_suspend_queue,
> +				       vp->run.kicked_by_hv =3D=3D 1);
> +	if (ret) {
> +		bool message_in_flight;
> +
> +		/*
> +		 * Otherwise the waiting was interrupted by a signal: suspend
> +		 * the vCPU explicitly and copy message in flight (if any).
> +		 */
> +		ret =3D mshv_suspend_vp(vp, &message_in_flight);
> +		if (ret)
> +			return ret;
> +
> +		/* Return if no message in flight */
> +		if (!message_in_flight)
> +			return -EINTR;
> +
> +		/* Wait for the message in flight. */
> +		wait_event(vp->run.vp_suspend_queue, vp->run.kicked_by_hv =3D=3D 1);
> +	}
> +
> +	/*
> +	 * Reset the flag to make the wait_event call above work
> +	 * next time.
> +	 */
> +	vp->run.kicked_by_hv =3D 0;
> +
> +	return 0;
> +}
> +
> +static int
> +mshv_vp_dispatch(struct mshv_vp *vp, u32 flags,
> +		 struct hv_output_dispatch_vp *res)
> +{
> +	struct hv_input_dispatch_vp *input;
> +	struct hv_output_dispatch_vp *output;
> +	u64 status;
> +
> +	preempt_disable();
> +	input =3D *this_cpu_ptr(root_scheduler_input);
> +	output =3D *this_cpu_ptr(root_scheduler_output);
> +
> +	memset(input, 0, sizeof(*input));
> +	memset(output, 0, sizeof(*output));
> +
> +	input->partition_id =3D vp->vp_partition->pt_id;
> +	input->vp_index =3D vp->vp_index;
> +	input->time_slice =3D 0; /* Run forever until something happens */
> +	input->spec_ctrl =3D 0; /* TODO: set sensible flags */
> +	input->flags =3D flags;
> +
> +	vp->run.flags.root_sched_dispatched =3D 1;
> +	status =3D hv_do_hypercall(HVCALL_DISPATCH_VP, input, output);
> +	vp->run.flags.root_sched_dispatched =3D 0;
> +
> +	*res =3D *output;
> +	preempt_enable();
> +
> +	if (!hv_result_success(status))
> +		vp_err(vp, "%s: status %s\n", __func__,
> +		       hv_result_to_string(status));
> +
> +	return hv_result_to_errno(status);
> +}
> +
> +static int
> +mshv_vp_clear_explicit_suspend(struct mshv_vp *vp)
> +{
> +	struct hv_register_assoc explicit_suspend =3D {
> +		.name =3D HV_REGISTER_EXPLICIT_SUSPEND,
> +		.value.explicit_suspend.suspended =3D 0,
> +	};
> +	int ret;
> +
> +	ret =3D mshv_set_vp_registers(vp->vp_index, vp->vp_partition->pt_id,
> +				    1, &explicit_suspend);
> +
> +	if (ret)
> +		vp_err(vp, "Failed to unsuspend\n");
> +
> +	return ret;
> +}
> +
> +#if IS_ENABLED(CONFIG_X86_64)
> +static u64 mshv_vp_interrupt_pending(struct mshv_vp *vp)
> +{
> +	if (!vp->vp_register_page)
> +		return 0;
> +	return vp->vp_register_page->interrupt_vectors.as_uint64;
> +}
> +#else
> +static u64 mshv_vp_interrupt_pending(struct mshv_vp *vp)
> +{
> +	return 0;
> +}
> +#endif
> +
> +static bool mshv_vp_dispatch_thread_blocked(struct mshv_vp *vp)
> +{
> +	struct hv_stats_page **stats =3D vp->vp_stats_pages;
> +	u64 *self_vp_cntrs =3D stats[HV_STATS_AREA_SELF]->vp_cntrs;
> +	u64 *parent_vp_cntrs =3D stats[HV_STATS_AREA_PARENT]->vp_cntrs;
> +
> +	if (self_vp_cntrs[VpRootDispatchThreadBlocked])
> +		return self_vp_cntrs[VpRootDispatchThreadBlocked];
> +	return parent_vp_cntrs[VpRootDispatchThreadBlocked];
> +}
> +
> +static int
> +mshv_vp_wait_for_hv_kick(struct mshv_vp *vp)
> +{
> +	int ret;
> +
> +	ret =3D wait_event_interruptible(vp->run.vp_suspend_queue,
> +				       (vp->run.kicked_by_hv =3D=3D 1 &&
> +					!mshv_vp_dispatch_thread_blocked(vp)) ||
> +				       mshv_vp_interrupt_pending(vp));
> +	if (ret)
> +		return -EINTR;
> +
> +	vp->run.flags.root_sched_blocked =3D 0;
> +	vp->run.kicked_by_hv =3D 0;
> +
> +	return 0;
> +}
> +
> +static int mshv_pre_guest_mode_work(struct mshv_vp *vp)
> +{
> +	const ulong work_flags =3D _TIF_NOTIFY_SIGNAL | _TIF_SIGPENDING |
> +				 _TIF_NEED_RESCHED  | _TIF_NOTIFY_RESUME;
> +	ulong th_flags;
> +
> +	th_flags =3D read_thread_flags();
> +	while (th_flags & work_flags) {
> +		int ret;
> +
> +		/* nb: following will call schedule */
> +		ret =3D mshv_do_pre_guest_mode_work(th_flags);
> +
> +		if (ret)
> +			return ret;
> +
> +		th_flags =3D read_thread_flags();
> +	}
> +
> +	return 0;
> +}
> +
> +/* Must be called with interrupts enabled */
> +static long mshv_run_vp_with_root_scheduler(struct mshv_vp *vp)
> +{
> +	long ret;
> +
> +	if (vp->run.flags.root_sched_blocked) {
> +		/*
> +		 * Dispatch state of this VP is blocked. Need to wait
> +		 * for the hypervisor to clear the blocked state before
> +		 * dispatching it.
> +		 */
> +		ret =3D mshv_vp_wait_for_hv_kick(vp);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	do {
> +		u32 flags =3D 0;
> +		struct hv_output_dispatch_vp output;
> +
> +		ret =3D mshv_pre_guest_mode_work(vp);
> +		if (ret)
> +			break;
> +
> +		if (vp->run.flags.intercept_suspend)
> +			flags |=3D HV_DISPATCH_VP_FLAG_CLEAR_INTERCEPT_SUSPEND;
> +
> +		if (mshv_vp_interrupt_pending(vp))
> +			flags |=3D HV_DISPATCH_VP_FLAG_SCAN_INTERRUPT_INJECTION;
> +
> +		ret =3D mshv_vp_dispatch(vp, flags, &output);
> +		if (ret)
> +			break;
> +
> +		vp->run.flags.intercept_suspend =3D 0;
> +
> +		if (output.dispatch_state =3D=3D HV_VP_DISPATCH_STATE_BLOCKED) {
> +			if (output.dispatch_event =3D=3D
> +						HV_VP_DISPATCH_EVENT_SUSPEND) {
> +				/*
> +				 * TODO: remove the warning once VP canceling
> +				 *	 is supported
> +				 */
> +				WARN_ONCE(atomic64_read(&vp->run.vp_signaled_count),
> +					  "%s: vp#%d: unexpected explicit suspend\n",
> +					  __func__, vp->vp_index);
> +				/*
> +				 * Need to clear explicit suspend before
> +				 * dispatching.
> +				 * Explicit suspend is either:
> +				 * - set right after the first VP dispatch or
> +				 * - set explicitly via hypercall
> +				 * Since the latter case is not yet supported,
> +				 * simply clear it here.
> +				 */
> +				ret =3D mshv_vp_clear_explicit_suspend(vp);
> +				if (ret)
> +					break;
> +
> +				ret =3D mshv_vp_wait_for_hv_kick(vp);
> +				if (ret)
> +					break;
> +			} else {
> +				vp->run.flags.root_sched_blocked =3D 1;
> +				ret =3D mshv_vp_wait_for_hv_kick(vp);
> +				if (ret)
> +					break;
> +			}
> +		} else {
> +			/* HV_VP_DISPATCH_STATE_READY */
> +			if (output.dispatch_event =3D=3D
> +						HV_VP_DISPATCH_EVENT_INTERCEPT)
> +				vp->run.flags.intercept_suspend =3D 1;
> +		}
> +	} while (!vp->run.flags.intercept_suspend);
> +
> +	return ret;
> +}
> +
> +static_assert(sizeof(struct hv_message) <=3D MSHV_RUN_VP_BUF_SZ,
> +	      "sizeof(struct hv_message) must not exceed MSHV_RUN_VP_BUF_SZ");
> +
> +static long mshv_vp_ioctl_run_vp(struct mshv_vp *vp, void __user *ret_ms=
g)
> +{
> +	long rc;
> +	char *schednm;
> +
> +	schednm =3D hv_scheduler_type =3D=3D HV_SCHEDULER_TYPE_ROOT ? "root" : =
"hv";
> +
> +	if (hv_scheduler_type =3D=3D HV_SCHEDULER_TYPE_ROOT)
> +		rc =3D mshv_run_vp_with_root_scheduler(vp);
> +	else
> +		rc =3D mshv_run_vp_with_hyp_scheduler(vp);
> +
> +	if (rc)
> +		return rc;
> +
> +	if (copy_to_user(ret_msg, vp->vp_intercept_msg_page,
> +			 sizeof(struct hv_message)))
> +		rc =3D -EFAULT;
> +
> +	return rc;
> +}
> +
> +static int
> +mshv_vp_ioctl_get_set_state_pfn(struct mshv_vp *vp,
> +				struct hv_vp_state_data state_data,
> +				unsigned long user_pfn, size_t page_count,
> +				bool is_set)
> +{
> +	int completed, ret =3D 0;
> +	unsigned long check;
> +	struct page **pages;
> +
> +	if (page_count > INT_MAX)
> +		return -EINVAL;
> +	/*
> +	 * Check the arithmetic for wraparound/overflow.
> +	 * The last page address in the buffer is:
> +	 * (user_pfn + (page_count - 1)) * PAGE_SIZE
> +	 */
> +	if (check_add_overflow(user_pfn, (page_count - 1), &check))
> +		return -EOVERFLOW;
> +	if (check_mul_overflow(check, PAGE_SIZE, &check))
> +		return -EOVERFLOW;
> +
> +	/* Pin user pages so hypervisor can copy directly to them */
> +	pages =3D kcalloc(page_count, sizeof(struct page *), GFP_KERNEL);
> +	if (!pages)
> +		return -ENOMEM;
> +
> +	for (completed =3D 0; completed < page_count; completed +=3D ret) {
> +		unsigned long user_addr =3D (user_pfn + completed) * PAGE_SIZE;
> +		int remaining =3D page_count - completed;
> +
> +		ret =3D pin_user_pages_fast(user_addr, remaining, FOLL_WRITE,
> +					  &pages[completed]);
> +		if (ret < 0) {
> +			vp_err(vp, "%s: Failed to pin user pages error %i\n",
> +			       __func__, ret);
> +			goto unpin_pages;
> +		}
> +	}
> +
> +	if (is_set)
> +		ret =3D hv_call_set_vp_state(vp->vp_index,
> +					   vp->vp_partition->pt_id,
> +					   state_data, page_count, pages,
> +					   0, NULL);
> +	else
> +		ret =3D hv_call_get_vp_state(vp->vp_index,
> +					   vp->vp_partition->pt_id,
> +					   state_data, page_count, pages,
> +					   NULL);
> +
> +unpin_pages:
> +	unpin_user_pages(pages, completed);
> +	kfree(pages);
> +	return ret;
> +}
> +
> +static long
> +mshv_vp_ioctl_get_set_state(struct mshv_vp *vp,
> +			    struct mshv_get_set_vp_state __user *user_args,
> +			    bool is_set)
> +{
> +	struct mshv_get_set_vp_state args;
> +	long ret =3D 0;
> +	union hv_output_get_vp_state vp_state;
> +	u32 data_sz;
> +	struct hv_vp_state_data state_data =3D {};
> +
> +	if (copy_from_user(&args, user_args, sizeof(args)))
> +		return -EFAULT;
> +
> +	if (args.type >=3D MSHV_VP_STATE_COUNT || mshv_field_nonzero(args, rsvd=
) ||
> +	    !args.buf_sz || !PAGE_ALIGNED(args.buf_sz) ||
> +	    !PAGE_ALIGNED(args.buf_ptr))
> +		return -EINVAL;
> +
> +	if (!access_ok((void __user *)args.buf_ptr, args.buf_sz))
> +		return -EFAULT;
> +
> +	switch (args.type) {
> +	case MSHV_VP_STATE_LAPIC:
> +		state_data.type =3D HV_GET_SET_VP_STATE_LAPIC_STATE;
> +		data_sz =3D HV_HYP_PAGE_SIZE;
> +		break;
> +	case MSHV_VP_STATE_XSAVE:

Just FYI, you can put a semicolon after the colon on the above line, which
adds a null statement, and then the C compiler will accept the definition
of local variable data_sz_64 without needing the odd-looking braces.=20

See https://stackoverflow.com/questions/92396/why-cant-variables-be-declare=
d-in-a-switch-statement/19830820

I learn something new every day! :-)

> +	{
> +		u64 data_sz_64;
> +
> +		ret =3D hv_call_get_partition_property(vp->vp_partition->pt_id,
> +						     HV_PARTITION_PROPERTY_XSAVE_STATES,
> +						     &state_data.xsave.states.as_uint64);
> +		if (ret)
> +			return ret;
> +
> +		ret =3D hv_call_get_partition_property(vp->vp_partition->pt_id,
> +						     HV_PARTITION_PROPERTY_MAX_XSAVE_DATA_SIZE,
> +						     &data_sz_64);
> +		if (ret)
> +			return ret;
> +
> +		data_sz =3D (u32)data_sz_64;
> +		state_data.xsave.flags =3D 0;
> +		/* Always request legacy states */
> +		state_data.xsave.states.legacy_x87 =3D 1;
> +		state_data.xsave.states.legacy_sse =3D 1;
> +		state_data.type =3D HV_GET_SET_VP_STATE_XSAVE;
> +		break;
> +	}
> +	case MSHV_VP_STATE_SIMP:
> +		state_data.type =3D HV_GET_SET_VP_STATE_SIM_PAGE;
> +		data_sz =3D HV_HYP_PAGE_SIZE;
> +		break;
> +	case MSHV_VP_STATE_SIEFP:
> +		state_data.type =3D HV_GET_SET_VP_STATE_SIEF_PAGE;
> +		data_sz =3D HV_HYP_PAGE_SIZE;
> +		break;
> +	case MSHV_VP_STATE_SYNTHETIC_TIMERS:
> +		state_data.type =3D HV_GET_SET_VP_STATE_SYNTHETIC_TIMERS;
> +		data_sz =3D sizeof(vp_state.synthetic_timers_state);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	if (copy_to_user(&user_args->buf_sz, &data_sz, sizeof(user_args->buf_sz=
)))
> +		return -EFAULT;
> +
> +	if (data_sz > args.buf_sz)
> +		return -EINVAL;
> +
> +	/* If the data is transmitted via pfns, delegate to helper */
> +	if (state_data.type & HV_GET_SET_VP_STATE_TYPE_PFN) {
> +		unsigned long user_pfn =3D PFN_DOWN(args.buf_ptr);
> +		size_t page_count =3D PFN_DOWN(args.buf_sz);
> +
> +		return mshv_vp_ioctl_get_set_state_pfn(vp, state_data, user_pfn,
> +						       page_count, is_set);
> +	}
> +
> +	/* Paranoia check - this shouldn't happen! */
> +	if (data_sz > sizeof(vp_state)) {
> +		vp_err(vp, "Invalid vp state data size!\n");
> +		return -EINVAL;
> +	}

I don't understand the above check.  sizeof(vp_state) is relatively small s=
ince
it is effectively sizeof(hv_synthetic_timers_state), which is 200 bytes if =
I've
done the arithmetic correctly. But data_sz could be a full page (4096 bytes=
)
for the LAPIC, SIMP, and SIEFP cases, and the check would cause an error to
be returned.

> +
> +	if (is_set) {
> +		if (copy_from_user(&vp_state, (__user void *)args.buf_ptr, data_sz))
> +			return -EFAULT;
> +
> +		return hv_call_set_vp_state(vp->vp_index,
> +					    vp->vp_partition->pt_id,
> +					    state_data, 0, NULL,
> +					    sizeof(vp_state), (u8 *)&vp_state);

This is one of the cases where data from user space gets passed directly to
the hypercall. So user space is responsible for ensuring that reserved fiel=
ds
are zero'ed and for otherwise ensuring a proper hypercall input. I just
wonder if user space really does this correctly.

> +	}
> +
> +	ret =3D hv_call_get_vp_state(vp->vp_index, vp->vp_partition->pt_id,
> +				   state_data, 0, NULL, &vp_state);
> +	if (ret)
> +		return ret;
> +
> +	if (copy_to_user((void __user *)args.buf_ptr, &vp_state, data_sz))
> +		return -EFAULT;
> +
> +	return 0;
> +}
> +
> +static long
> +mshv_vp_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
> +{
> +	struct mshv_vp *vp =3D filp->private_data;
> +	long r =3D -ENOTTY;
> +
> +	if (mutex_lock_killable(&vp->vp_mutex))
> +		return -EINTR;
> +
> +	switch (ioctl) {
> +	case MSHV_RUN_VP:
> +		r =3D mshv_vp_ioctl_run_vp(vp, (void __user *)arg);
> +		break;
> +	case MSHV_GET_VP_STATE:
> +		r =3D mshv_vp_ioctl_get_set_state(vp, (void __user *)arg, false);
> +		break;
> +	case MSHV_SET_VP_STATE:
> +		r =3D mshv_vp_ioctl_get_set_state(vp, (void __user *)arg, true);
> +		break;
> +	case MSHV_ROOT_HVCALL:
> +		r =3D mshv_ioctl_passthru_hvcall(vp->vp_partition, false,
> +					       (void __user *)arg);
> +		break;
> +	default:
> +		vp_warn(vp, "Invalid ioctl: %#x\n", ioctl);
> +		break;
> +	}
> +	mutex_unlock(&vp->vp_mutex);
> +
> +	return r;
> +}
> +
> +static vm_fault_t mshv_vp_fault(struct vm_fault *vmf)
> +{
> +	struct mshv_vp *vp =3D vmf->vma->vm_file->private_data;
> +
> +	switch (vmf->vma->vm_pgoff) {
> +	case MSHV_VP_MMAP_OFFSET_REGISTERS:
> +		vmf->page =3D virt_to_page(vp->vp_register_page);
> +		break;
> +	case MSHV_VP_MMAP_OFFSET_INTERCEPT_MESSAGE:
> +		vmf->page =3D virt_to_page(vp->vp_intercept_msg_page);
> +		break;
> +	case MSHV_VP_MMAP_OFFSET_GHCB:
> +		if (is_ghcb_mapping_available())
> +			vmf->page =3D virt_to_page(vp->vp_ghcb_page);
> +		break;

If there's no GHCB mapping available, execution just continues with
vmf->page not set. Won't the later get_page() call fail? Perhaps this
should fail if there's no GHCB mapping available. Or maybe there's
more about how this works that I'm ignorant of. :-)

> +	default:
> +		return -EINVAL;
> +	}
> +
> +	get_page(vmf->page);
> +
> +	return 0;
> +}
> +
> +static int mshv_vp_mmap(struct file *file, struct vm_area_struct *vma)
> +{
> +	struct mshv_vp *vp =3D file->private_data;
> +
> +	switch (vma->vm_pgoff) {
> +	case MSHV_VP_MMAP_OFFSET_REGISTERS:
> +		if (!vp->vp_register_page)
> +			return -ENODEV;
> +		break;
> +	case MSHV_VP_MMAP_OFFSET_INTERCEPT_MESSAGE:
> +		if (!vp->vp_intercept_msg_page)
> +			return -ENODEV;
> +		break;
> +	case MSHV_VP_MMAP_OFFSET_GHCB:
> +		if (is_ghcb_mapping_available() && !vp->vp_ghcb_page)
> +			return -ENODEV;
> +		break;

Again, if no GHCB mapping is available, should this return success?

> +	default:
> +		return -EINVAL;
> +	}
> +
> +	vma->vm_ops =3D &mshv_vp_vm_ops;
> +	return 0;
> +}
> +
> +static int
> +mshv_vp_release(struct inode *inode, struct file *filp)
> +{
> +	struct mshv_vp *vp =3D filp->private_data;
> +
> +	/* Rest of VP cleanup happens in destroy_partition() */
> +	mshv_partition_put(vp->vp_partition);
> +	return 0;
> +}
> +
> +static void mshv_vp_stats_unmap(u64 partition_id, u32 vp_index)
> +{
> +	union hv_stats_object_identity identity =3D {
> +		.vp.partition_id =3D partition_id,
> +		.vp.vp_index =3D vp_index,
> +	};
> +
> +	identity.vp.stats_area_type =3D HV_STATS_AREA_SELF;
> +	hv_call_unmap_stat_page(HV_STATS_OBJECT_VP, &identity);
> +
> +	identity.vp.stats_area_type =3D HV_STATS_AREA_PARENT;
> +	hv_call_unmap_stat_page(HV_STATS_OBJECT_VP, &identity);
> +}
> +
> +static int mshv_vp_stats_map(u64 partition_id, u32 vp_index,
> +			     void *stats_pages[])
> +{
> +	union hv_stats_object_identity identity =3D {
> +		.vp.partition_id =3D partition_id,
> +		.vp.vp_index =3D vp_index,
> +	};
> +	int err;
> +
> +	identity.vp.stats_area_type =3D HV_STATS_AREA_SELF;
> +	err =3D hv_call_map_stat_page(HV_STATS_OBJECT_VP, &identity,
> +				    &stats_pages[HV_STATS_AREA_SELF]);
> +	if (err)
> +		return err;
> +
> +	identity.vp.stats_area_type =3D HV_STATS_AREA_PARENT;
> +	err =3D hv_call_map_stat_page(HV_STATS_OBJECT_VP, &identity,
> +				    &stats_pages[HV_STATS_AREA_PARENT]);
> +	if (err)
> +		goto unmap_self;
> +
> +	return 0;
> +
> +unmap_self:
> +	identity.vp.stats_area_type =3D HV_STATS_AREA_SELF;
> +	hv_call_unmap_stat_page(HV_STATS_OBJECT_VP, &identity);
> +	return err;
> +}
> +
> +static long
> +mshv_partition_ioctl_create_vp(struct mshv_partition *partition,
> +			       void __user *arg)
> +{
> +	struct mshv_create_vp args;
> +	struct mshv_vp *vp;
> +	struct page *intercept_message_page, *register_page, *ghcb_page;
> +	void *stats_pages[2];
> +	long ret;
> +	union hv_input_vtl input_vtl;
> +
> +	if (copy_from_user(&args, arg, sizeof(args)))
> +		return -EFAULT;
> +
> +	if (args.vp_index >=3D MSHV_MAX_VPS)
> +		return -EINVAL;
> +
> +	if (partition->pt_vp_array[args.vp_index])
> +		return -EEXIST;
> +
> +	ret =3D hv_call_create_vp(NUMA_NO_NODE, partition->pt_id, args.vp_index=
,
> +				0 /* Only valid for root partition VPs */);
> +	if (ret)
> +		return ret;
> +
> +	input_vtl.as_uint8 =3D 0;

I see eight occurrences in this source code file where the above statement
occurs and there is no further modification. Perhaps declare a static
variable that is initialized properly, and use it as the input parameter to=
 the
various functions.  A second static variable could have the use_target_vtl =
=3D 1
setting that is needed in three places.

> +	ret =3D hv_call_map_vp_state_page(partition->pt_id, args.vp_index,
> +					HV_VP_STATE_PAGE_INTERCEPT_MESSAGE,
> +					input_vtl,
> +					&intercept_message_page);
> +	if (ret)
> +		goto destroy_vp;
> +
> +	if (!mshv_partition_encrypted(partition)) {
> +		input_vtl.as_uint8 =3D 0;
> +		ret =3D hv_call_map_vp_state_page(partition->pt_id, args.vp_index,
> +						HV_VP_STATE_PAGE_REGISTERS,
> +						input_vtl,
> +						&register_page);
> +		if (ret)
> +			goto unmap_intercept_message_page;
> +	}
> +
> +	if (mshv_partition_encrypted(partition) &&
> +	    is_ghcb_mapping_available()) {
> +		input_vtl.as_uint8 =3D 0;
> +		input_vtl.use_target_vtl =3D 1;
> +		input_vtl.target_vtl =3D HV_NORMAL_VTL;
> +		ret =3D hv_call_map_vp_state_page(partition->pt_id, args.vp_index,
> +						HV_VP_STATE_PAGE_GHCB,
> +						input_vtl,
> +						&ghcb_page);
> +		if (ret)
> +			goto unmap_register_page;
> +	}
> +
> +	if (hv_parent_partition()) {
> +		ret =3D mshv_vp_stats_map(partition->pt_id, args.vp_index,
> +					stats_pages);
> +		if (ret)
> +			goto unmap_ghcb_page;
> +	}
> +
> +	vp =3D kzalloc(sizeof(*vp), GFP_KERNEL);
> +	if (!vp)
> +		goto unmap_stats_pages;
> +
> +	vp->vp_partition =3D mshv_partition_get(partition);
> +	if (!vp->vp_partition) {
> +		ret =3D -EBADF;
> +		goto free_vp;
> +	}
> +
> +	mutex_init(&vp->vp_mutex);
> +	init_waitqueue_head(&vp->run.vp_suspend_queue);
> +	atomic64_set(&vp->run.vp_signaled_count, 0);
> +
> +	vp->vp_index =3D args.vp_index;
> +	vp->vp_intercept_msg_page =3D page_to_virt(intercept_message_page);
> +	if (!mshv_partition_encrypted(partition))
> +		vp->vp_register_page =3D page_to_virt(register_page);
> +
> +	if (mshv_partition_encrypted(partition) && is_ghcb_mapping_available())
> +		vp->vp_ghcb_page =3D page_to_virt(ghcb_page);
> +
> +	if (hv_parent_partition())
> +		memcpy(vp->vp_stats_pages, stats_pages, sizeof(stats_pages));
> +
> +	/*
> +	 * Keep anon_inode_getfd last: it installs fd in the file struct and
> +	 * thus makes the state accessible in user space.
> +	 */
> +	ret =3D anon_inode_getfd("mshv_vp", &mshv_vp_fops, vp,
> +			       O_RDWR | O_CLOEXEC);
> +	if (ret < 0)
> +		goto put_partition;
> +
> +	/* already exclusive with the partition mutex for all ioctls */
> +	partition->pt_vp_count++;
> +	partition->pt_vp_array[args.vp_index] =3D vp;
> +
> +	return ret;
> +
> +put_partition:
> +	mshv_partition_put(partition);
> +free_vp:
> +	kfree(vp);
> +unmap_stats_pages:
> +	if (hv_parent_partition())
> +		mshv_vp_stats_unmap(partition->pt_id, args.vp_index);
> +unmap_ghcb_page:
> +	if (mshv_partition_encrypted(partition) && is_ghcb_mapping_available())=
 {
> +		input_vtl.as_uint8 =3D 0;
> +		input_vtl.use_target_vtl =3D 1;
> +		input_vtl.target_vtl =3D HV_NORMAL_VTL;
> +
> +		hv_call_unmap_vp_state_page(partition->pt_id, args.vp_index,
> +					    HV_VP_STATE_PAGE_GHCB, input_vtl);
> +	}
> +unmap_register_page:
> +	if (!mshv_partition_encrypted(partition)) {
> +		input_vtl.as_uint8 =3D 0;
> +
> +		hv_call_unmap_vp_state_page(partition->pt_id, args.vp_index,
> +					    HV_VP_STATE_PAGE_REGISTERS,
> +					    input_vtl);
> +	}
> +unmap_intercept_message_page:
> +	input_vtl.as_uint8 =3D 0;
> +	hv_call_unmap_vp_state_page(partition->pt_id, args.vp_index,
> +				    HV_VP_STATE_PAGE_INTERCEPT_MESSAGE,
> +				    input_vtl);
> +destroy_vp:
> +	hv_call_delete_vp(partition->pt_id, args.vp_index);
> +	return ret;
> +}
> +
> +static int mshv_init_async_handler(struct mshv_partition *partition)
> +{
> +	if (completion_done(&partition->async_hypercall)) {
> +		pt_err(partition,
> +		       "Cannot issue another async hypercall, while another one in pro=
gress!\n");

Two uses of word "another" in the error message is redundant.  Perhaps

	"Cannot issue async hypercall while another one is in progress!"

> +		return -EPERM;
> +	}
> +
> +	reinit_completion(&partition->async_hypercall);
> +	return 0;
> +}
> +
> +static void mshv_async_hvcall_handler(void *data, u64 *status)
> +{
> +	struct mshv_partition *partition =3D data;
> +
> +	wait_for_completion(&partition->async_hypercall);
> +	pt_dbg(partition, "Async hypercall completed!\n");
> +
> +	*status =3D partition->async_hypercall_status;
> +}
> +
> +static int
> +mshv_partition_region_share(struct mshv_mem_region *region)
> +{
> +	u32 flags =3D HV_MODIFY_SPA_PAGE_HOST_ACCESS_MAKE_SHARED;
> +
> +	if (region->flags.large_pages)
> +		flags |=3D HV_MODIFY_SPA_PAGE_HOST_ACCESS_LARGE_PAGE;
> +
> +	return hv_call_modify_spa_host_access(region->partition->pt_id,
> +			region->pages, region->nr_pages,
> +			HV_MAP_GPA_READABLE | HV_MAP_GPA_WRITABLE,
> +			flags, true);
> +}
> +
> +static int
> +mshv_partition_region_unshare(struct mshv_mem_region *region)
> +{
> +	u32 flags =3D HV_MODIFY_SPA_PAGE_HOST_ACCESS_MAKE_EXCLUSIVE;
> +
> +	if (region->flags.large_pages)
> +		flags |=3D HV_MODIFY_SPA_PAGE_HOST_ACCESS_LARGE_PAGE;
> +
> +	return hv_call_modify_spa_host_access(region->partition->pt_id,
> +			region->pages, region->nr_pages,
> +			0,
> +			flags, false);
> +}
> +
> +static int
> +mshv_region_remap_pages(struct mshv_mem_region *region, u32 map_flags,
> +			u64 page_offset, u64 page_count)
> +{
> +	if (page_offset + page_count > region->nr_pages)
> +		return -EINVAL;
> +
> +	if (region->flags.large_pages)
> +		map_flags |=3D HV_MAP_GPA_LARGE_PAGE;
> +
> +	/* ask the hypervisor to map guest ram */
> +	return hv_call_map_gpa_pages(region->partition->pt_id,
> +				     region->start_gfn + page_offset,
> +				     page_count, map_flags,
> +				     region->pages + page_offset);
> +}
> +
> +static int
> +mshv_region_map(struct mshv_mem_region *region)
> +{
> +	u32 map_flags =3D region->hv_map_flags;
> +
> +	return mshv_region_remap_pages(region, map_flags,
> +				       0, region->nr_pages);
> +}
> +
> +static void
> +mshv_region_evict_pages(struct mshv_mem_region *region,
> +			u64 page_offset, u64 page_count)
> +{
> +	if (region->flags.range_pinned)
> +		unpin_user_pages(region->pages + page_offset, page_count);
> +
> +	memset(region->pages + page_offset, 0,
> +	       page_count * sizeof(struct page *));
> +}
> +
> +static void
> +mshv_region_evict(struct mshv_mem_region *region)
> +{
> +	mshv_region_evict_pages(region, 0, region->nr_pages);
> +}
> +
> +static int
> +mshv_region_populate_pages(struct mshv_mem_region *region,
> +			   u64 page_offset, u64 page_count)
> +{
> +	u64 done_count, nr_pages;
> +	struct page **pages;
> +	__u64 userspace_addr;
> +	int ret;
> +
> +	if (page_offset + page_count > region->nr_pages)
> +		return -EINVAL;
> +
> +	for (done_count =3D 0; done_count < page_count; done_count +=3D ret) {
> +		pages =3D region->pages + page_offset + done_count;
> +		userspace_addr =3D region->start_uaddr +
> +				(page_offset + done_count) *
> +				HV_HYP_PAGE_SIZE;
> +		nr_pages =3D min(page_count - done_count,
> +			       MSHV_PIN_PAGES_BATCH_SIZE);
> +
> +		/*
> +		 * Pinning assuming 4k pages works for large pages too.
> +		 * All page structs within the large page are returned.
> +		 *
> +		 * Pin requests are batched because pin_user_pages_fast
> +		 * with the FOLL_LONGTERM flag does a large temporary
> +		 * allocation of contiguous memory.
> +		 */
> +		if (region->flags.range_pinned)
> +			ret =3D pin_user_pages_fast(userspace_addr,
> +						  nr_pages,
> +						  FOLL_WRITE | FOLL_LONGTERM,
> +						  pages);
> +		else
> +			ret =3D -EOPNOTSUPP;
> +
> +		if (ret < 0)
> +			goto release_pages;
> +	}
> +
> +	if (PageHuge(region->pages[page_offset]))
> +		region->flags.large_pages =3D true;
> +
> +	return 0;
> +
> +release_pages:
> +	mshv_region_evict_pages(region, page_offset, done_count);
> +	return ret;
> +}
> +
> +static int
> +mshv_region_populate(struct mshv_mem_region *region)
> +{
> +	return mshv_region_populate_pages(region, 0, region->nr_pages);
> +}
> +
> +static struct mshv_mem_region *
> +mshv_partition_region_by_gfn(struct mshv_partition *partition, u64 gfn)
> +{
> +	struct mshv_mem_region *region;
> +
> +	hlist_for_each_entry(region, &partition->pt_mem_regions, hnode) {
> +		if (gfn >=3D region->start_gfn &&
> +		    gfn < region->start_gfn + region->nr_pages)
> +			return region;
> +	}
> +
> +	return NULL;
> +}
> +
> +static struct mshv_mem_region *
> +mshv_partition_region_by_uaddr(struct mshv_partition *partition, u64 uad=
dr)
> +{
> +	struct mshv_mem_region *region;
> +
> +	hlist_for_each_entry(region, &partition->pt_mem_regions, hnode) {
> +		if (uaddr >=3D region->start_uaddr &&
> +		    uaddr < region->start_uaddr +
> +			    (region->nr_pages << HV_HYP_PAGE_SHIFT))
> +			return region;
> +	}
> +
> +	return NULL;
> +}
> +
> +/*
> + * NB: caller checks and makes sure mem->size is page aligned
> + * Returns: 0 with regionpp updated on success, or -errno
> + */
> +static int mshv_partition_create_region(struct mshv_partition *partition=
,
> +					struct mshv_user_mem_region *mem,
> +					struct mshv_mem_region **regionpp,
> +					bool is_mmio)
> +{
> +	struct mshv_mem_region *region;
> +	u64 nr_pages =3D HVPFN_DOWN(mem->size);
> +
> +	/* Reject overlapping regions */
> +	if (mshv_partition_region_by_gfn(partition, mem->guest_pfn) ||
> +	    mshv_partition_region_by_gfn(partition, mem->guest_pfn + nr_pages -=
 1) ||
> +	    mshv_partition_region_by_uaddr(partition, mem->userspace_addr) ||
> +	    mshv_partition_region_by_uaddr(partition, mem->userspace_addr + mem=
->size - 1))
> +		return -EEXIST;

Having to fully walk the partition region list four times for the above che=
cks
isn't the most efficient approach, but I'm guessing that creating a region =
isn't
really a hot path so it doesn't matter. And I don't know how long the regio=
n list
typically is.

> +
> +	region =3D vzalloc(sizeof(*region) + sizeof(struct page *) * nr_pages);
> +	if (!region)
> +		return -ENOMEM;
> +
> +	region->nr_pages =3D nr_pages;
> +	region->start_gfn =3D mem->guest_pfn;
> +	region->start_uaddr =3D mem->userspace_addr;
> +	region->hv_map_flags =3D HV_MAP_GPA_READABLE | HV_MAP_GPA_ADJUSTABLE;
> +	if (mem->flags & BIT(MSHV_SET_MEM_BIT_WRITABLE))
> +		region->hv_map_flags |=3D HV_MAP_GPA_WRITABLE;
> +	if (mem->flags & BIT(MSHV_SET_MEM_BIT_EXECUTABLE))
> +		region->hv_map_flags |=3D HV_MAP_GPA_EXECUTABLE;
> +
> +	/* Note: large_pages flag populated when we pin the pages */
> +	if (!is_mmio)
> +		region->flags.range_pinned =3D true;
> +
> +	region->partition =3D partition;
> +
> +	*regionpp =3D region;
> +
> +	return 0;
> +}
> +
> +/*
> + * Map guest ram. if snp, make sure to release that from the host first
> + * Side Effects: In case of failure, pages are unpinned when feasible.
> + */
> +static int
> +mshv_partition_mem_region_map(struct mshv_mem_region *region)
> +{
> +	struct mshv_partition *partition =3D region->partition;
> +	int ret;
> +
> +	ret =3D mshv_region_populate(region);
> +	if (ret) {
> +		pt_err(partition, "Failed to populate memory region: %d\n",
> +		       ret);
> +		goto err_out;
> +	}
> +
> +	/*
> +	 * For an SNP partition it is a requirement that for every memory regio=
n
> +	 * that we are going to map for this partition we should make sure that
> +	 * host access to that region is released. This is ensured by doing an
> +	 * additional hypercall which will update the SLAT to release host
> +	 * access to guest memory regions.
> +	 */
> +	if (mshv_partition_encrypted(partition)) {
> +		ret =3D mshv_partition_region_unshare(region);
> +		if (ret) {
> +			pt_err(partition,
> +			       "Failed to unshare memory region (guest_pfn: %llu): %d\n",
> +			       region->start_gfn, ret);
> +			goto evict_region;
> +		}
> +	}
> +
> +	ret =3D mshv_region_map(region);
> +	if (ret && mshv_partition_encrypted(partition)) {
> +		int shrc;
> +
> +		shrc =3D mshv_partition_region_share(region);
> +		if (!shrc)
> +			goto evict_region;
> +
> +		pt_err(partition,
> +		       "Failed to share memory region (guest_pfn: %llu): %d\n",
> +		       region->start_gfn, shrc);
> +		/*
> +		 * Don't unpin if marking shared failed because pages are no
> +		 * longer mapped in the host, ie root, anymore.
> +		 */
> +		goto err_out;
> +	}
> +
> +	return 0;
> +
> +evict_region:
> +	mshv_region_evict(region);
> +err_out:
> +	return ret;
> +}
> +
> +/*
> + * This maps two things: guest RAM and for pci passthru mmio space.
> + *
> + * mmio:
> + *  - vfio overloads vm_pgoff to store the mmio start pfn/spa.
> + *  - Two things need to happen for mapping mmio range:
> + *	1. mapped in the uaddr so VMM can access it.
> + *	2. mapped in the hwpt (gfn <-> mmio phys addr) so guest can access it=
.
> + *
> + *   This function takes care of the second. The first one is managed by=
 vfio,
> + *   and hence is taken care of via vfio_pci_mmap_fault().
> + */
> +static long
> +mshv_map_user_memory(struct mshv_partition *partition,
> +		     struct mshv_user_mem_region mem)
> +{
> +	struct mshv_mem_region *region;
> +	struct vm_area_struct *vma;
> +	bool is_mmio;
> +	ulong mmio_pfn;
> +	long ret;
> +
> +	if (mem.flags & BIT(MSHV_SET_MEM_BIT_UNMAP) ||
> +	    !access_ok((const void *)mem.userspace_addr, mem.size))
> +		return -EINVAL;
> +
> +	mmap_read_lock(current->mm);
> +	vma =3D vma_lookup(current->mm, mem.userspace_addr);
> +	is_mmio =3D vma ? !!(vma->vm_flags & (VM_IO | VM_PFNMAP)) : 0;
> +	mmio_pfn =3D is_mmio ? vma->vm_pgoff : 0;
> +	mmap_read_unlock(current->mm);
> +
> +	if (!vma)
> +		return -EINVAL;
> +
> +	ret =3D mshv_partition_create_region(partition, &mem, &region,
> +					   is_mmio);
> +	if (ret)
> +		return ret;
> +
> +	if (is_mmio)
> +		ret =3D hv_call_map_mmio_pages(partition->pt_id, mem.guest_pfn,
> +					     mmio_pfn, HVPFN_DOWN(mem.size));
> +	else
> +		ret =3D mshv_partition_mem_region_map(region);
> +
> +	if (ret)
> +		goto errout;
> +
> +	/* Install the new region */
> +	hlist_add_head(&region->hnode, &partition->pt_mem_regions);
> +
> +	return 0;
> +
> +errout:
> +	vfree(region);
> +	return ret;
> +}
> +
> +/* Called for unmapping both the guest ram and the mmio space */
> +static long
> +mshv_unmap_user_memory(struct mshv_partition *partition,
> +		       struct mshv_user_mem_region mem)
> +{
> +	struct mshv_mem_region *region;
> +	u32 unmap_flags =3D 0;
> +
> +	if (!(mem.flags & BIT(MSHV_SET_MEM_BIT_UNMAP)))
> +		return -EINVAL;
> +
> +	if (hlist_empty(&partition->pt_mem_regions))
> +		return -EINVAL;

Isn't the above check redundant, given the lookup by gfn that is
done immediately below?

> +
> +	region =3D mshv_partition_region_by_gfn(partition, mem.guest_pfn);
> +	if (!region)
> +		return -EINVAL;
> +
> +	/* Paranoia check */
> +	if (region->start_uaddr !=3D mem.userspace_addr ||
> +	    region->start_gfn !=3D mem.guest_pfn ||
> +	    region->nr_pages !=3D HVPFN_DOWN(mem.size))
> +		return -EINVAL;
> +
> +	hlist_del(&region->hnode);
> +
> +	if (region->flags.large_pages)
> +		unmap_flags |=3D HV_UNMAP_GPA_LARGE_PAGE;
> +
> +	/* ignore unmap failures and continue as process may be exiting */
> +	hv_call_unmap_gpa_pages(partition->pt_id, region->start_gfn,
> +				region->nr_pages, unmap_flags);
> +
> +	mshv_region_evict(region);
> +
> +	vfree(region);
> +	return 0;
> +}
> +
> +static long
> +mshv_partition_ioctl_set_memory(struct mshv_partition *partition,
> +				struct mshv_user_mem_region __user *user_mem)
> +{
> +	struct mshv_user_mem_region mem;
> +
> +	if (copy_from_user(&mem, user_mem, sizeof(mem)))
> +		return -EFAULT;
> +
> +	if (!mem.size ||
> +	    !PAGE_ALIGNED(mem.size) ||
> +	    !PAGE_ALIGNED(mem.userspace_addr) ||
> +	    (mem.flags & ~MSHV_SET_MEM_FLAGS_MASK) ||
> +	    mshv_field_nonzero(mem, rsvd))
> +		return -EINVAL;
> +
> +	if (mem.flags & BIT(MSHV_SET_MEM_BIT_UNMAP))
> +		return mshv_unmap_user_memory(partition, mem);
> +
> +	return mshv_map_user_memory(partition, mem);
> +}
> +
> +static long
> +mshv_partition_ioctl_ioeventfd(struct mshv_partition *partition,
> +			       void __user *user_args)
> +{
> +	struct mshv_user_ioeventfd args;
> +
> +	if (copy_from_user(&args, user_args, sizeof(args)))
> +		return -EFAULT;
> +
> +	return mshv_set_unset_ioeventfd(partition, &args);
> +}
> +
> +static long
> +mshv_partition_ioctl_irqfd(struct mshv_partition *partition,
> +			   void __user *user_args)
> +{
> +	struct mshv_user_irqfd args;
> +
> +	if (copy_from_user(&args, user_args, sizeof(args)))
> +		return -EFAULT;
> +
> +	return mshv_set_unset_irqfd(partition, &args);
> +}
> +
> +static long
> +mshv_partition_ioctl_get_gpap_access_bitmap(struct mshv_partition *parti=
tion,
> +					    void __user *user_args)
> +{
> +	struct mshv_gpap_access_bitmap args;
> +	union hv_gpa_page_access_state *states;
> +	long ret, i;
> +	union hv_gpa_page_access_state_flags hv_flags =3D {};
> +	u8 hv_type_mask;
> +	ulong bitmap_buf_sz, states_buf_sz;
> +	int written =3D 0;
> +
> +	if (copy_from_user(&args, user_args, sizeof(args)))
> +		return -EFAULT;
> +
> +	if (args.access_type >=3D MSHV_GPAP_ACCESS_TYPE_COUNT ||
> +	    args.access_op >=3D MSHV_GPAP_ACCESS_OP_COUNT ||
> +	    mshv_field_nonzero(args, rsvd) || !args.page_count ||
> +	    !args.bitmap_ptr)
> +		return -EINVAL;
> +
> +	if (check_mul_overflow(args.page_count, sizeof(*states), &states_buf_sz=
))
> +		return -E2BIG;
> +
> +	/* Num bytes needed to store bitmap; one bit per page rounded up */
> +	bitmap_buf_sz =3D DIV_ROUND_UP(args.page_count, 8);
> +
> +	/* Sanity check */
> +	if (bitmap_buf_sz > states_buf_sz)
> +		return -EBADFD;
> +
> +	switch (args.access_type) {
> +	case MSHV_GPAP_ACCESS_TYPE_ACCESSED:
> +		hv_type_mask =3D 1;
> +		if (args.access_op =3D=3D MSHV_GPAP_ACCESS_OP_CLEAR) {
> +			hv_flags.clear_accessed =3D 1;
> +			/* not accessed implies not dirty */
> +			hv_flags.clear_dirty =3D 1;
> +		} else { // MSHV_GPAP_ACCESS_OP_SET

Avoid C++ style comments.

> +			hv_flags.set_accessed =3D 1;
> +		}
> +		break;
> +	case MSHV_GPAP_ACCESS_TYPE_DIRTY:
> +		hv_type_mask =3D 2;
> +		if (args.access_op =3D=3D MSHV_GPAP_ACCESS_OP_CLEAR) {
> +			hv_flags.clear_dirty =3D 1;
> +		} else { // MSHV_GPAP_ACCESS_OP_SET

Same here.

> +			hv_flags.set_dirty =3D 1;
> +			/* dirty implies accessed */
> +			hv_flags.set_accessed =3D 1;
> +		}
> +		break;
> +	}
> +
> +	states =3D vzalloc(states_buf_sz);
> +	if (!states)
> +		return -ENOMEM;
> +
> +	ret =3D hv_call_get_gpa_access_states(partition->pt_id, args.page_count=
,
> +					    args.gpap_base, hv_flags, &written,
> +					    states);
> +	if (ret)
> +		goto free_return;
> +
> +	/*
> +	 * Overwrite states buffer with bitmap - the bits in hv_type_mask
> +	 * correspond to bitfields in hv_gpa_page_access_state
> +	 */
> +	for (i =3D 0; i < written; ++i)
> +		assign_bit(i, (ulong *)states,

Why the cast to ulong *?  I think this argument to assign_bit() is void *, =
in
which case the cast wouldn't be needed.

Also, assign_bit() does atomic bit operations. Doing such in a loop like
here will really hammer the hardware memory bus with atomic=20
read-modify-write cycles. Use __assign_bit() instead, which does
non-atomic operations. You don't need atomic here as no other
threads are modifying the bit array.

> +			   states[i].as_uint8 & hv_type_mask);

OK, so the starting contents of "states" is an array of bytes. The ending
contents is an array of bits. This works because every bit in the ending
bit array is set to either 0 or 1. Overlap occurs on the first iteration
where the code reads the 0th byte, and writes the 0th bit, which is part of
the 0th byte. The second iteration reads the 1st byte, and writes the 1st b=
it,
which doesn't overlap, and there's no overlap from then on.

Suppose "written" is not a multiple of 8. The last byte of "states" as an
array of bits will have some bits that have not been set to either 0 or 1 a=
nd
might be leftover garbage from when "states" was an array of bytes. That
garbage will get copied to user space. Is that OK? Even if user space knows
enough to ignore those bits, it seems a little dubious to be copying even
a few bits of garbage to user space.

Some comments might help here.

> +
> +	args.page_count =3D written;
> +
> +	if (copy_to_user(user_args, &args, sizeof(args))) {
> +		ret =3D -EFAULT;
> +		goto free_return;
> +	}
> +	if (copy_to_user((void __user *)args.bitmap_ptr, states, bitmap_buf_sz)=
)
> +		ret =3D -EFAULT;
> +
> +free_return:
> +	vfree(states);
> +	return ret;
> +}
> +
> +static long
> +mshv_partition_ioctl_set_msi_routing(struct mshv_partition *partition,
> +				     void __user *user_args)
> +{
> +	struct mshv_user_irq_entry *entries =3D NULL;
> +	struct mshv_user_irq_table args;
> +	long ret;
> +
> +	if (copy_from_user(&args, user_args, sizeof(args)))
> +		return -EFAULT;
> +
> +	if (args.nr > MSHV_MAX_GUEST_IRQS ||
> +	    mshv_field_nonzero(args, rsvd))
> +		return -EINVAL;
> +
> +	if (args.nr) {
> +		struct mshv_user_irq_table __user *urouting =3D user_args;
> +
> +		entries =3D vmemdup_user(urouting->entries,
> +				       array_size(sizeof(*entries),
> +						  args.nr));
> +		if (IS_ERR(entries))
> +			return PTR_ERR(entries);
> +	}
> +	ret =3D mshv_update_routing_table(partition, entries, args.nr);
> +	kvfree(entries);
> +
> +	return ret;
> +}
> +
> +static long
> +mshv_partition_ioctl_initialize(struct mshv_partition *partition)
> +{
> +	long ret;
> +
> +	if (partition->pt_initialized)
> +		return 0;
> +
> +	ret =3D hv_call_initialize_partition(partition->pt_id);
> +	if (ret)
> +		goto withdraw_mem;
> +
> +	partition->pt_initialized =3D true;
> +
> +	return 0;
> +
> +withdraw_mem:
> +	hv_call_withdraw_memory(U64_MAX, NUMA_NO_NODE, partition->pt_id);
> +
> +	return ret;
> +}
> +
> +static long
> +mshv_partition_ioctl(struct file *filp, unsigned int ioctl, unsigned lon=
g arg)
> +{
> +	struct mshv_partition *partition =3D filp->private_data;
> +	long ret;
> +	void __user *uarg =3D (void __user *)arg;
> +
> +	if (mutex_lock_killable(&partition->pt_mutex))
> +		return -EINTR;
> +
> +	switch (ioctl) {
> +	case MSHV_INITIALIZE_PARTITION:
> +		ret =3D mshv_partition_ioctl_initialize(partition);
> +		break;
> +	case MSHV_SET_GUEST_MEMORY:
> +		ret =3D mshv_partition_ioctl_set_memory(partition, uarg);
> +		break;
> +	case MSHV_CREATE_VP:
> +		ret =3D mshv_partition_ioctl_create_vp(partition, uarg);
> +		break;
> +	case MSHV_IRQFD:
> +		ret =3D mshv_partition_ioctl_irqfd(partition, uarg);
> +		break;
> +	case MSHV_IOEVENTFD:
> +		ret =3D mshv_partition_ioctl_ioeventfd(partition, uarg);
> +		break;
> +	case MSHV_SET_MSI_ROUTING:
> +		ret =3D mshv_partition_ioctl_set_msi_routing(partition, uarg);
> +		break;
> +	case MSHV_GET_GPAP_ACCESS_BITMAP:
> +		ret =3D mshv_partition_ioctl_get_gpap_access_bitmap(partition,
> +								  uarg);
> +		break;
> +	case MSHV_ROOT_HVCALL:
> +		ret =3D mshv_ioctl_passthru_hvcall(partition, true, uarg);
> +		break;
> +	default:
> +		ret =3D -ENOTTY;
> +	}
> +
> +	mutex_unlock(&partition->pt_mutex);
> +	return ret;
> +}
> +
> +static int
> +disable_vp_dispatch(struct mshv_vp *vp)
> +{
> +	int ret;
> +	struct hv_register_assoc dispatch_suspend =3D {
> +		.name =3D HV_REGISTER_DISPATCH_SUSPEND,
> +		.value.dispatch_suspend.suspended =3D 1,
> +	};
> +
> +	ret =3D mshv_set_vp_registers(vp->vp_index, vp->vp_partition->pt_id,
> +				    1, &dispatch_suspend);
> +	if (ret)
> +		vp_err(vp, "failed to suspend\n");
> +
> +	return ret;
> +}
> +
> +static int
> +get_vp_signaled_count(struct mshv_vp *vp, u64 *count)
> +{
> +	int ret;
> +	struct hv_register_assoc root_signal_count =3D {
> +		.name =3D HV_REGISTER_VP_ROOT_SIGNAL_COUNT,
> +	};
> +
> +	ret =3D mshv_get_vp_registers(vp->vp_index, vp->vp_partition->pt_id,
> +				    1, &root_signal_count);
> +
> +	if (ret) {
> +		vp_err(vp, "Failed to get root signal count");
> +		*count =3D 0;
> +		return ret;
> +	}
> +
> +	*count =3D root_signal_count.value.reg64;
> +
> +	return ret;
> +}
> +
> +static void
> +drain_vp_signals(struct mshv_vp *vp)
> +{
> +	u64 hv_signal_count;
> +	u64 vp_signal_count;
> +
> +	get_vp_signaled_count(vp, &hv_signal_count);
> +
> +	vp_signal_count =3D atomic64_read(&vp->run.vp_signaled_count);
> +
> +	/*
> +	 * There should be at most 1 outstanding notification, but be extra
> +	 * careful anyway.
> +	 */
> +	while (hv_signal_count !=3D vp_signal_count) {
> +		WARN_ON(hv_signal_count - vp_signal_count !=3D 1);
> +
> +		if (wait_event_interruptible(vp->run.vp_suspend_queue,
> +					     vp->run.kicked_by_hv =3D=3D 1))
> +			break;
> +		vp->run.kicked_by_hv =3D 0;
> +		vp_signal_count =3D atomic64_read(&vp->run.vp_signaled_count);
> +	}
> +}
> +
> +static void drain_all_vps(const struct mshv_partition *partition)
> +{
> +	int i;
> +	struct mshv_vp *vp;
> +
> +	/*
> +	 * VPs are reachable from ISR. It is safe to not take the partition
> +	 * lock because nobody else can enter this function and drop the
> +	 * partition from the list.
> +	 */
> +	for (i =3D 0; i < MSHV_MAX_VPS; i++) {
> +		vp =3D partition->pt_vp_array[i];
> +		if (!vp)
> +			continue;
> +		/*
> +		 * Disable dispatching of the VP in the hypervisor. After this
> +		 * the hypervisor guarantees it won't generate any signals for
> +		 * the VP and the hypervisor's VP signal count won't change.
> +		 */
> +		disable_vp_dispatch(vp);
> +		drain_vp_signals(vp);
> +	}
> +}
> +
> +static void
> +remove_partition(struct mshv_partition *partition)
> +{
> +	spin_lock(&mshv_root.pt_ht_lock);
> +	hlist_del_rcu(&partition->pt_hnode);
> +	spin_unlock(&mshv_root.pt_ht_lock);
> +
> +	synchronize_rcu();
> +}
> +
> +/*
> + * Tear down a partition and remove it from the list.
> + * Partition's refcount must be 0
> + */
> +static void destroy_partition(struct mshv_partition *partition)
> +{
> +	struct mshv_vp *vp;
> +	struct mshv_mem_region *region;
> +	int i, ret;
> +	struct hlist_node *n;
> +	union hv_input_vtl input_vtl;
> +
> +	if (refcount_read(&partition->pt_ref_count)) {
> +		pt_err(partition,
> +		       "Attempt to destroy partition but refcount > 0\n");
> +		return;
> +	}
> +
> +	if (partition->pt_initialized) {
> +		/*
> +		 * We only need to drain signals for root scheduler. This should be
> +		 * done before removing the partition from the partition list.
> +		 */
> +		if (hv_scheduler_type =3D=3D HV_SCHEDULER_TYPE_ROOT)
> +			drain_all_vps(partition);
> +
> +		/* Remove vps */
> +		for (i =3D 0; i < MSHV_MAX_VPS; ++i) {
> +			vp =3D partition->pt_vp_array[i];
> +			if (!vp)
> +				continue;
> +
> +			if (hv_parent_partition())
> +				mshv_vp_stats_unmap(partition->pt_id, vp->vp_index);
> +
> +			if (vp->vp_register_page) {
> +				input_vtl.as_uint8 =3D 0;
> +				(void)hv_call_unmap_vp_state_page(partition->pt_id,
> +								  vp->vp_index,
> +								  HV_VP_STATE_PAGE_REGISTERS,
> +								  input_vtl);
> +				vp->vp_register_page =3D NULL;
> +			}
> +
> +			input_vtl.as_uint8 =3D 0;
> +			(void)hv_call_unmap_vp_state_page(partition->pt_id,
> +							  vp->vp_index,
> +							  HV_VP_STATE_PAGE_INTERCEPT_MESSAGE,
> +							  input_vtl);
> +			vp->vp_intercept_msg_page =3D NULL;
> +
> +			if (vp->vp_ghcb_page) {
> +				input_vtl.use_target_vtl =3D 1;
> +				input_vtl.target_vtl =3D HV_NORMAL_VTL;
> +				(void)hv_call_unmap_vp_state_page(partition->pt_id,
> +								  vp->vp_index,
> +								  HV_VP_STATE_PAGE_GHCB,
> +								  input_vtl);
> +				vp->vp_ghcb_page =3D NULL;
> +			}
> +
> +			kfree(vp);
> +
> +			partition->pt_vp_array[i] =3D NULL;
> +		}
> +
> +		/* Deallocates and unmaps everything including vcpus, GPA mappings etc=
 */
> +		hv_call_finalize_partition(partition->pt_id);
> +
> +		partition->pt_initialized =3D false;
> +	}
> +
> +	remove_partition(partition);
> +
> +	/* Remove regions, regain access to the memory and unpin the pages */
> +	hlist_for_each_entry_safe(region, n, &partition->pt_mem_regions,
> +				  hnode) {
> +		hlist_del(&region->hnode);
> +
> +		if (mshv_partition_encrypted(partition)) {
> +			ret =3D mshv_partition_region_share(region);
> +			if (ret) {
> +				pt_err(partition,
> +				       "Failed to regain access to memory, unpinning user pages will=
 fail and crash the host error: %d\n",
> +				      ret);
> +				return;
> +			}
> +		}
> +
> +		mshv_region_evict(region);
> +
> +		vfree(region);
> +	}
> +
> +	/* Withdraw and free all pages we deposited */
> +	hv_call_withdraw_memory(U64_MAX, NUMA_NO_NODE, partition->pt_id);
> +	hv_call_delete_partition(partition->pt_id);
> +
> +	mshv_free_routing_table(partition);
> +	kfree(partition);
> +}
> +
> +struct
> +mshv_partition *mshv_partition_get(struct mshv_partition *partition)
> +{
> +	if (refcount_inc_not_zero(&partition->pt_ref_count))
> +		return partition;
> +	return NULL;
> +}
> +
> +struct
> +mshv_partition *mshv_partition_find(u64 partition_id)
> +	__must_hold(RCU)
> +{
> +	struct mshv_partition *p;
> +
> +	hash_for_each_possible_rcu(mshv_root.pt_htable, p, pt_hnode,
> +				   partition_id)
> +		if (p->pt_id =3D=3D partition_id)
> +			return p;
> +
> +	return NULL;
> +}
> +
> +void
> +mshv_partition_put(struct mshv_partition *partition)
> +{
> +	if (refcount_dec_and_test(&partition->pt_ref_count))
> +		destroy_partition(partition);
> +}
> +
> +static int
> +mshv_partition_release(struct inode *inode, struct file *filp)
> +{
> +	struct mshv_partition *partition =3D filp->private_data;
> +
> +	mshv_eventfd_release(partition);
> +
> +	cleanup_srcu_struct(&partition->pt_irq_srcu);
> +
> +	mshv_partition_put(partition);
> +
> +	return 0;
> +}
> +
> +static int
> +add_partition(struct mshv_partition *partition)
> +{
> +	spin_lock(&mshv_root.pt_ht_lock);
> +
> +	hash_add_rcu(mshv_root.pt_htable, &partition->pt_hnode,
> +		     partition->pt_id);
> +
> +	spin_unlock(&mshv_root.pt_ht_lock);
> +
> +	return 0;
> +}
> +
> +static long
> +mshv_ioctl_create_partition(void __user *user_arg, struct device *module=
_dev)
> +{
> +	struct mshv_create_partition args;
> +	u64 creation_flags;
> +	struct hv_partition_creation_properties creation_properties =3D {};
> +	union hv_partition_isolation_properties isolation_properties =3D {};
> +	struct mshv_partition *partition;
> +	struct file *file;
> +	int fd;
> +	long ret;
> +
> +	if (copy_from_user(&args, user_arg, sizeof(args)))
> +		return -EFAULT;
> +
> +	if ((args.pt_flags & ~MSHV_PT_FLAGS_MASK) ||
> +	    args.pt_isolation >=3D MSHV_PT_ISOLATION_COUNT)
> +		return -EINVAL;
> +
> +	/* Only support EXO partitions */
> +	creation_flags =3D HV_PARTITION_CREATION_FLAG_EXO_PARTITION |
> +			HV_PARTITION_CREATION_FLAG_INTERCEPT_MESSAGE_PAGE_ENABLED;
> +
> +	if (args.pt_flags & BIT(MSHV_PT_BIT_LAPIC))
> +		creation_flags |=3D HV_PARTITION_CREATION_FLAG_LAPIC_ENABLED;
> +	if (args.pt_flags & BIT(MSHV_PT_BIT_X2APIC))
> +		creation_flags |=3D HV_PARTITION_CREATION_FLAG_X2APIC_CAPABLE;
> +	if (args.pt_flags & BIT(MSHV_PT_BIT_GPA_SUPER_PAGES))
> +		creation_flags |=3D HV_PARTITION_CREATION_FLAG_GPA_SUPER_PAGES_ENABLED=
;
> +
> +	switch (args.pt_isolation) {
> +	case MSHV_PT_ISOLATION_NONE:
> +		isolation_properties.isolation_type =3D
> +			HV_PARTITION_ISOLATION_TYPE_NONE;
> +		break;
> +	}
> +
> +	partition =3D kzalloc(sizeof(*partition), GFP_KERNEL);
> +	if (!partition)
> +		return -ENOMEM;
> +
> +	partition->pt_module_dev =3D module_dev;
> +	partition->isolation_type =3D isolation_properties.isolation_type;
> +
> +	refcount_set(&partition->pt_ref_count, 1);
> +
> +	mutex_init(&partition->pt_mutex);
> +
> +	mutex_init(&partition->pt_irq_lock);
> +
> +	init_completion(&partition->async_hypercall);
> +
> +	INIT_HLIST_HEAD(&partition->irq_ack_notifier_list);
> +
> +	INIT_HLIST_HEAD(&partition->pt_devices);
> +
> +	INIT_HLIST_HEAD(&partition->pt_mem_regions);
> +
> +	mshv_eventfd_init(partition);
> +
> +	ret =3D init_srcu_struct(&partition->pt_irq_srcu);
> +	if (ret)
> +		goto free_partition;
> +
> +	ret =3D hv_call_create_partition(creation_flags,
> +				       creation_properties,
> +				       isolation_properties,
> +				       &partition->pt_id);
> +	if (ret)
> +		goto cleanup_irq_srcu;
> +
> +	ret =3D add_partition(partition);
> +	if (ret)
> +		goto delete_partition;
> +
> +	ret =3D mshv_init_async_handler(partition);
> +	if (ret)
> +		goto remove_partition;
> +
> +	fd =3D get_unused_fd_flags(O_CLOEXEC);
> +	if (fd < 0) {
> +		ret =3D fd;
> +		goto remove_partition;
> +	}
> +
> +	file =3D anon_inode_getfile("mshv_partition", &mshv_partition_fops,
> +				  partition, O_RDWR);
> +	if (IS_ERR(file)) {
> +		ret =3D PTR_ERR(file);
> +		goto put_fd;
> +	}
> +
> +	fd_install(fd, file);
> +
> +	return fd;
> +
> +put_fd:
> +	put_unused_fd(fd);
> +remove_partition:
> +	remove_partition(partition);
> +delete_partition:
> +	hv_call_delete_partition(partition->pt_id);
> +cleanup_irq_srcu:
> +	cleanup_srcu_struct(&partition->pt_irq_srcu);
> +free_partition:
> +	kfree(partition);
> +
> +	return ret;
> +}
> +
> +static long mshv_dev_ioctl(struct file *filp, unsigned int ioctl,
> +			   unsigned long arg)
> +{
> +	struct miscdevice *misc =3D filp->private_data;
> +
> +	switch (ioctl) {
> +	case MSHV_CREATE_PARTITION:
> +		return mshv_ioctl_create_partition((void __user *)arg,
> +						misc->this_device);
> +	}
> +
> +	return -ENOTTY;
> +}
> +
> +static int
> +mshv_dev_open(struct inode *inode, struct file *filp)
> +{
> +	return 0;
> +}
> +
> +static int
> +mshv_dev_release(struct inode *inode, struct file *filp)
> +{
> +	return 0;
> +}
> +
> +static int mshv_cpuhp_online;
> +static int mshv_root_sched_online;
> +
> +static const char *scheduler_type_to_string(enum hv_scheduler_type type)
> +{
> +	switch (type) {
> +	case HV_SCHEDULER_TYPE_LP:
> +		return "classic scheduler without SMT";
> +	case HV_SCHEDULER_TYPE_LP_SMT:
> +		return "classic scheduler with SMT";
> +	case HV_SCHEDULER_TYPE_CORE_SMT:
> +		return "core scheduler";
> +	case HV_SCHEDULER_TYPE_ROOT:
> +		return "root scheduler";
> +	default:
> +		return "unknown scheduler";
> +	};
> +}
> +
> +/* TODO move this to hv_common.c when needed outside */
> +static int __init hv_retrieve_scheduler_type(enum hv_scheduler_type *out=
)
> +{
> +	struct hv_input_get_system_property *input;
> +	struct hv_output_get_system_property *output;
> +	unsigned long flags;
> +	u64 status;
> +
> +	local_irq_save(flags);
> +	input =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	output =3D *this_cpu_ptr(hyperv_pcpu_output_arg);
> +
> +	memset(input, 0, sizeof(*input));
> +	memset(output, 0, sizeof(*output));
> +	input->property_id =3D HV_SYSTEM_PROPERTY_SCHEDULER_TYPE;
> +
> +	status =3D hv_do_hypercall(HVCALL_GET_SYSTEM_PROPERTY, input, output);
> +	if (!hv_result_success(status)) {
> +		local_irq_restore(flags);
> +		pr_err("%s: %s\n", __func__, hv_result_to_string(status));
> +		return hv_result_to_errno(status);
> +	}
> +
> +	*out =3D output->scheduler_type;
> +	local_irq_restore(flags);
> +
> +	return 0;
> +}
> +
> +/* Retrieve and stash the supported scheduler type */
> +static int __init mshv_retrieve_scheduler_type(struct device *dev)
> +{
> +	int ret;
> +
> +	ret =3D hv_retrieve_scheduler_type(&hv_scheduler_type);
> +	if (ret)
> +		return ret;
> +
> +	dev_info(dev, "Hypervisor using %s\n",
> +		 scheduler_type_to_string(hv_scheduler_type));
> +
> +	switch (hv_scheduler_type) {
> +	case HV_SCHEDULER_TYPE_CORE_SMT:
> +	case HV_SCHEDULER_TYPE_LP_SMT:
> +	case HV_SCHEDULER_TYPE_ROOT:
> +	case HV_SCHEDULER_TYPE_LP:
> +		/* Supported scheduler, nothing to do */
> +		break;
> +	default:
> +		dev_err(dev, "unsupported scheduler 0x%x, bailing.\n",
> +			hv_scheduler_type);
> +		return -EOPNOTSUPP;
> +	}
> +
> +	return 0;
> +}
> +
> +static int mshv_root_scheduler_init(unsigned int cpu)
> +{
> +	void **inputarg, **outputarg, *p;
> +
> +	inputarg =3D (void **)this_cpu_ptr(root_scheduler_input);
> +	outputarg =3D (void **)this_cpu_ptr(root_scheduler_output);
> +
> +	/* Allocate two consecutive pages. One for input, one for output. */
> +	p =3D kmalloc(2 * HV_HYP_PAGE_SIZE, GFP_KERNEL);
> +	if (!p)
> +		return -ENOMEM;
> +
> +	*inputarg =3D p;
> +	*outputarg =3D (char *)p + HV_HYP_PAGE_SIZE;
> +
> +	return 0;
> +}
> +
> +static int mshv_root_scheduler_cleanup(unsigned int cpu)
> +{
> +	void *p, **inputarg, **outputarg;
> +
> +	inputarg =3D (void **)this_cpu_ptr(root_scheduler_input);
> +	outputarg =3D (void **)this_cpu_ptr(root_scheduler_output);
> +
> +	p =3D *inputarg;
> +
> +	*inputarg =3D NULL;
> +	*outputarg =3D NULL;
> +
> +	kfree(p);
> +
> +	return 0;
> +}
> +
> +/* Must be called after retrieving the scheduler type */
> +static int
> +root_scheduler_init(struct device *dev)
> +{
> +	int ret;
> +
> +	if (hv_scheduler_type !=3D HV_SCHEDULER_TYPE_ROOT)
> +		return 0;
> +
> +	root_scheduler_input =3D alloc_percpu(void *);
> +	root_scheduler_output =3D alloc_percpu(void *);
> +
> +	if (!root_scheduler_input || !root_scheduler_output) {
> +		dev_err(dev, "Failed to allocate root scheduler buffers\n");
> +		ret =3D -ENOMEM;
> +		goto out;
> +	}
> +
> +	ret =3D cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "mshv_root_sched",
> +				mshv_root_scheduler_init,
> +				mshv_root_scheduler_cleanup);
> +
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to setup root scheduler state: %i\n", ret);
> +		goto out;
> +	}
> +
> +	mshv_root_sched_online =3D ret;
> +
> +	return 0;
> +
> +out:
> +	free_percpu(root_scheduler_input);
> +	free_percpu(root_scheduler_output);
> +	return ret;
> +}
> +
> +static void
> +root_scheduler_deinit(void)
> +{
> +	if (hv_scheduler_type !=3D HV_SCHEDULER_TYPE_ROOT)
> +		return;
> +
> +	cpuhp_remove_state(mshv_root_sched_online);
> +	free_percpu(root_scheduler_input);
> +	free_percpu(root_scheduler_output);
> +}
> +
> +static int mshv_reboot_notify(struct notifier_block *nb,
> +			      unsigned long code, void *unused)
> +{
> +	cpuhp_remove_state(mshv_cpuhp_online);
> +	return 0;
> +}
> +
> +struct notifier_block mshv_reboot_nb =3D {
> +	.notifier_call =3D mshv_reboot_notify,
> +};
> +
> +static void mshv_root_partition_exit(void)
> +{
> +	unregister_reboot_notifier(&mshv_reboot_nb);
> +	root_scheduler_deinit();
> +}
> +
> +static int __init mshv_root_partition_init(struct device *dev)
> +{
> +	int err;
> +
> +	if (mshv_retrieve_scheduler_type(dev))
> +		return -ENODEV;
> +
> +	err =3D root_scheduler_init(dev);
> +	if (err)
> +		return err;
> +
> +	err =3D register_reboot_notifier(&mshv_reboot_nb);
> +	if (err)
> +		goto root_sched_deinit;
> +
> +	return 0;
> +
> +root_sched_deinit:
> +	root_scheduler_deinit();
> +	return err;
> +}
> +
> +static int __init mshv_parent_partition_init(void)
> +{
> +	int ret;
> +	struct device *dev;
> +	union hv_hypervisor_version_info version_info;
> +
> +	if (!hv_root_partition() || is_kdump_kernel())
> +		return -ENODEV;
> +
> +	if (hv_get_hypervisor_version(&version_info))
> +		return -ENODEV;
> +
> +	ret =3D misc_register(&mshv_dev);
> +	if (ret)
> +		return ret;
> +
> +	dev =3D mshv_dev.this_device;
> +
> +	if (version_info.build_number < MSHV_HV_MIN_VERSION ||
> +	    version_info.build_number > MSHV_HV_MAX_VERSION) {
> +		dev_err(dev, "Running on unvalidated Hyper-V version\n");
> +		dev_err(dev, "Versions: current: %u  min: %u  max: %u\n",
> +			version_info.build_number, MSHV_HV_MIN_VERSION,
> +			MSHV_HV_MAX_VERSION);
> +	}
> +
> +	mshv_root.synic_pages =3D alloc_percpu(struct hv_synic_pages);
> +	if (!mshv_root.synic_pages) {
> +		dev_err(dev, "Failed to allocate percpu synic page\n");
> +		ret =3D -ENOMEM;
> +		goto device_deregister;
> +	}
> +
> +	ret =3D cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "mshv_synic",
> +				mshv_synic_init,
> +				mshv_synic_cleanup);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to setup cpu hotplug state: %i\n", ret);
> +		goto free_synic_pages;
> +	}
> +
> +	mshv_cpuhp_online =3D ret;
> +
> +	ret =3D mshv_root_partition_init(dev);
> +	if (ret)
> +		goto remove_cpu_state;
> +
> +	ret =3D mshv_irqfd_wq_init();
> +	if (ret)
> +		goto exit_partition;
> +
> +	spin_lock_init(&mshv_root.pt_ht_lock);
> +	hash_init(mshv_root.pt_htable);
> +
> +	hv_setup_mshv_handler(mshv_isr);
> +
> +	return 0;
> +
> +exit_partition:
> +	if (hv_root_partition())
> +		mshv_root_partition_exit();
> +remove_cpu_state:
> +	cpuhp_remove_state(mshv_cpuhp_online);
> +free_synic_pages:
> +	free_percpu(mshv_root.synic_pages);
> +device_deregister:
> +	misc_deregister(&mshv_dev);
> +	return ret;
> +}
> +
> +static void __exit mshv_parent_partition_exit(void)
> +{
> +	hv_setup_mshv_handler(NULL);
> +	mshv_port_table_fini();
> +	misc_deregister(&mshv_dev);
> +	mshv_irqfd_wq_cleanup();
> +	if (hv_root_partition())
> +		mshv_root_partition_exit();
> +	cpuhp_remove_state(mshv_cpuhp_online);
> +	free_percpu(mshv_root.synic_pages);
> +}
> +
> +module_init(mshv_parent_partition_init);
> +module_exit(mshv_parent_partition_exit);
> diff --git a/drivers/hv/mshv_synic.c b/drivers/hv/mshv_synic.c
> new file mode 100644
> index 000000000000..e7782f92e339
> --- /dev/null
> +++ b/drivers/hv/mshv_synic.c
> @@ -0,0 +1,665 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2023, Microsoft Corporation.
> + *
> + * mshv_root module's main interrupt handler and associated functionalit=
y.
> + *
> + * Authors:
> + *   Nuno Das Neves <nunodasneves@linux.microsoft.com>
> + *   Lillian Grassin-Drake <ligrassi@microsoft.com>
> + *   Vineeth Remanan Pillai <viremana@linux.microsoft.com>
> + *   Wei Liu <wei.liu@kernel.org>
> + *   Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/slab.h>
> +#include <linux/mm.h>
> +#include <linux/io.h>
> +#include <linux/random.h>
> +#include <asm/mshyperv.h>
> +
> +#include "mshv_eventfd.h"
> +#include "mshv.h"
> +
> +static u32 synic_event_ring_get_queued_port(u32 sint_index)
> +{
> +	struct hv_synic_event_ring_page **event_ring_page;
> +	volatile struct hv_synic_event_ring *ring;
> +	struct hv_synic_pages *spages;
> +	u8 **synic_eventring_tail;
> +	u32 message;
> +	u8 tail;
> +
> +	spages =3D this_cpu_ptr(mshv_root.synic_pages);
> +	event_ring_page =3D &spages->synic_event_ring_page;
> +	synic_eventring_tail =3D (u8 **)this_cpu_ptr(hv_synic_eventring_tail);
> +	tail =3D (*synic_eventring_tail)[sint_index];
> +
> +	if (unlikely(!(*event_ring_page))) {
> +		pr_debug("Missing synic event ring page!\n");
> +		return 0;
> +	}
> +
> +	ring =3D &(*event_ring_page)->sint_event_ring[sint_index];
> +
> +	/*
> +	 * Get the message.
> +	 */
> +	message =3D ring->data[tail];
> +
> +	if (!message) {
> +		if (ring->ring_full) {
> +			/*
> +			 * Ring is marked full, but we would have consumed all
> +			 * the messages. Notify the hypervisor that ring is now
> +			 * empty and check again.
> +			 */
> +			ring->ring_full =3D 0;
> +			hv_call_notify_port_ring_empty(sint_index);
> +			message =3D ring->data[tail];
> +		}
> +
> +		if (!message) {
> +			ring->signal_masked =3D 0;
> +			/*
> +			 * Unmask the signal and sync with hypervisor
> +			 * before one last check for any message.
> +			 */
> +			mb();
> +			message =3D ring->data[tail];
> +
> +			/*
> +			 * Ok, lets bail out.
> +			 */
> +			if (!message)
> +				return 0;
> +		}
> +
> +		ring->signal_masked =3D 1;
> +	}
> +
> +	/*
> +	 * Clear the message in the ring buffer.
> +	 */
> +	ring->data[tail] =3D 0;
> +
> +	if (++tail =3D=3D HV_SYNIC_EVENT_RING_MESSAGE_COUNT)
> +		tail =3D 0;
> +
> +	(*synic_eventring_tail)[sint_index] =3D tail;
> +
> +	return message;
> +}
> +
> +static bool
> +mshv_doorbell_isr(struct hv_message *msg)
> +{
> +	struct hv_notification_message_payload *notification;
> +	u32 port;
> +
> +	if (msg->header.message_type !=3D HVMSG_SYNIC_SINT_INTERCEPT)
> +		return false;
> +
> +	notification =3D (struct hv_notification_message_payload *)msg->u.paylo=
ad;
> +	if (notification->sint_index !=3D HV_SYNIC_DOORBELL_SINT_INDEX)
> +		return false;
> +
> +	while ((port =3D synic_event_ring_get_queued_port(HV_SYNIC_DOORBELL_SIN=
T_INDEX))) {
> +		struct port_table_info ptinfo =3D { 0 };
> +
> +		if (mshv_portid_lookup(port, &ptinfo)) {
> +			pr_debug("Failed to get port info from port_table!\n");
> +			continue;
> +		}
> +
> +		if (ptinfo.hv_port_type !=3D HV_PORT_TYPE_DOORBELL) {
> +			pr_debug("Not a doorbell port!, port: %d, port_type: %d\n",
> +				 port, ptinfo.hv_port_type);
> +			continue;
> +		}
> +
> +		/* Invoke the callback */
> +		ptinfo.hv_port_doorbell.doorbell_cb(port,
> +						 ptinfo.hv_port_doorbell.data);
> +	}
> +
> +	return true;
> +}
> +
> +static bool mshv_async_call_completion_isr(struct hv_message *msg)
> +{
> +	bool handled =3D false;
> +	struct hv_async_completion_message_payload *async_msg;
> +	struct mshv_partition *partition;
> +	u64 partition_id;
> +
> +	if (msg->header.message_type !=3D HVMSG_ASYNC_CALL_COMPLETION)
> +		goto out;
> +
> +	async_msg =3D
> +		(struct hv_async_completion_message_payload *)msg->u.payload;
> +
> +	partition_id =3D async_msg->partition_id;
> +
> +	/*
> +	 * Hold this lock for the rest of the isr, because the partition could
> +	 * be released anytime.
> +	 * e.g. the MSHV_RUN_VP thread could wake on another cpu; it could
> +	 * release the partition unless we hold this!
> +	 */
> +	rcu_read_lock();
> +
> +	partition =3D mshv_partition_find(partition_id);
> +	partition->async_hypercall_status =3D async_msg->status;
> +
> +	if (unlikely(!partition)) {
> +		pr_debug("failed to find partition %llu\n", partition_id);
> +		goto unlock_out;
> +	}
> +
> +	complete(&partition->async_hypercall);
> +
> +	handled =3D true;
> +
> +unlock_out:
> +	rcu_read_unlock();
> +out:
> +	return handled;
> +}
> +
> +static void kick_vp(struct mshv_vp *vp)
> +{
> +	atomic64_inc(&vp->run.vp_signaled_count);
> +	vp->run.kicked_by_hv =3D 1;
> +	wake_up(&vp->run.vp_suspend_queue);
> +}
> +
> +static void
> +handle_bitset_message(const struct hv_vp_signal_bitset_scheduler_message=
 *msg)
> +{
> +	int bank_idx, vps_signaled =3D 0, bank_mask_size;
> +	struct mshv_partition *partition;
> +	const struct hv_vpset *vpset;
> +	const u64 *bank_contents;
> +	u64 partition_id =3D msg->partition_id;
> +
> +	if (msg->vp_bitset.bitset.format !=3D HV_GENERIC_SET_SPARSE_4K) {
> +		pr_debug("scheduler message format is not HV_GENERIC_SET_SPARSE_4K");
> +		return;
> +	}
> +
> +	if (msg->vp_count =3D=3D 0) {
> +		pr_debug("scheduler message with no VP specified");
> +		return;
> +	}
> +
> +	rcu_read_lock();
> +
> +	partition =3D mshv_partition_find(partition_id);
> +	if (unlikely(!partition)) {
> +		pr_debug("failed to find partition %llu\n", partition_id);
> +		goto unlock_out;
> +	}
> +
> +	vpset =3D &msg->vp_bitset.bitset;
> +
> +	bank_idx =3D -1;
> +	bank_contents =3D vpset->bank_contents;
> +	bank_mask_size =3D sizeof(vpset->valid_bank_mask) * BITS_PER_BYTE;
> +
> +	while (true) {
> +		int vp_bank_idx =3D -1;
> +		int vp_bank_size =3D sizeof(*bank_contents) * BITS_PER_BYTE;
> +		int vp_index;
> +
> +		bank_idx =3D find_next_bit((unsigned long *)&vpset->valid_bank_mask,
> +					 bank_mask_size, bank_idx + 1);
> +		if (bank_idx =3D=3D bank_mask_size)
> +			break;
> +
> +		while (true) {
> +			struct mshv_vp *vp;
> +
> +			vp_bank_idx =3D find_next_bit((unsigned long *)bank_contents,
> +						    vp_bank_size, vp_bank_idx + 1);
> +			if (vp_bank_idx =3D=3D vp_bank_size)
> +				break;
> +
> +			vp_index =3D (bank_idx << HV_GENERIC_SET_SHIFT) + vp_bank_idx;

This would be clearer if just multiplied by bank_mask_size instead of shift=
ing.
Since the compiler knows the constant value of bank_mask_size, it should ge=
nerate
the same code as the shift.

> +
> +			/* This shouldn't happen, but just in case. */
> +			if (unlikely(vp_index >=3D MSHV_MAX_VPS)) {
> +				pr_debug("VP index %u out of bounds\n",
> +					 vp_index);
> +				goto unlock_out;
> +			}
> +
> +			vp =3D partition->pt_vp_array[vp_index];
> +			if (unlikely(!vp)) {
> +				pr_debug("failed to find VP %u\n", vp_index);
> +				goto unlock_out;
> +			}
> +
> +			kick_vp(vp);
> +			vps_signaled++;
> +		}
> +
> +		bank_contents++;
> +	}
> +
> +unlock_out:
> +	rcu_read_unlock();
> +
> +	if (vps_signaled !=3D msg->vp_count)
> +		pr_debug("asked to signal %u VPs but only did %u\n",
> +			 msg->vp_count, vps_signaled);
> +}
> +
> +static void
> +handle_pair_message(const struct hv_vp_signal_pair_scheduler_message *ms=
g)
> +{
> +	struct mshv_partition *partition =3D NULL;
> +	struct mshv_vp *vp;
> +	int idx;
> +
> +	rcu_read_lock();
> +
> +	for (idx =3D 0; idx < msg->vp_count; idx++) {
> +		u64 partition_id =3D msg->partition_ids[idx];
> +		u32 vp_index =3D msg->vp_indexes[idx];
> +
> +		if (idx =3D=3D 0 || partition->pt_id !=3D partition_id) {
> +			partition =3D mshv_partition_find(partition_id);
> +			if (unlikely(!partition)) {
> +				pr_debug("failed to find partition %llu\n",
> +					 partition_id);
> +				break;
> +			}
> +		}
> +
> +		/* This shouldn't happen, but just in case. */
> +		if (unlikely(vp_index >=3D MSHV_MAX_VPS)) {
> +			pr_debug("VP index %u out of bounds\n", vp_index);
> +			break;
> +		}
> +
> +		vp =3D partition->pt_vp_array[vp_index];
> +		if (!vp) {
> +			pr_debug("failed to find VP %u\n", vp_index);
> +			break;
> +		}
> +
> +		kick_vp(vp);
> +	}
> +
> +	rcu_read_unlock();
> +}
> +
> +static bool
> +mshv_scheduler_isr(struct hv_message *msg)
> +{
> +	if (msg->header.message_type !=3D HVMSG_SCHEDULER_VP_SIGNAL_BITSET &&
> +	    msg->header.message_type !=3D HVMSG_SCHEDULER_VP_SIGNAL_PAIR)
> +		return false;
> +
> +	if (msg->header.message_type =3D=3D HVMSG_SCHEDULER_VP_SIGNAL_BITSET)
> +		handle_bitset_message((struct hv_vp_signal_bitset_scheduler_message *)
> +				      msg->u.payload);
> +	else
> +		handle_pair_message((struct hv_vp_signal_pair_scheduler_message *)
> +				    msg->u.payload);
> +
> +	return true;
> +}
> +
> +static bool
> +mshv_intercept_isr(struct hv_message *msg)
> +{
> +	struct mshv_partition *partition;
> +	bool handled =3D false;
> +	struct mshv_vp *vp;
> +	u64 partition_id;
> +	u32 vp_index;
> +
> +	partition_id =3D msg->header.sender;
> +
> +	rcu_read_lock();
> +
> +	partition =3D mshv_partition_find(partition_id);
> +	if (unlikely(!partition)) {
> +		pr_debug("failed to find partition %llu\n",
> +			 partition_id);
> +		goto unlock_out;
> +	}
> +
> +	if (msg->header.message_type =3D=3D HVMSG_X64_APIC_EOI) {
> +		/*
> +		 * Check if this gsi is registered in the
> +		 * ack_notifier list and invoke the callback
> +		 * if registered.
> +		 */
> +
> +		/*
> +		 * If there is a notifier, the ack callback is supposed
> +		 * to handle the VMEXIT. So we need not pass this message
> +		 * to vcpu thread.
> +		 */
> +		struct hv_x64_apic_eoi_message *eoi_msg =3D
> +			(struct hv_x64_apic_eoi_message *)&msg->u.payload[0];
> +
> +		if (mshv_notify_acked_gsi(partition, eoi_msg->interrupt_vector)) {
> +			handled =3D true;
> +			goto unlock_out;
> +		}
> +	}
> +
> +	/*
> +	 * We should get an opaque intercept message here for all intercept
> +	 * messages, since we're using the mapped VP intercept message page.
> +	 *
> +	 * The intercept message will have been placed in intercept message
> +	 * page at this point.
> +	 *
> +	 * Make sure the message type matches our expectation.
> +	 */
> +	if (msg->header.message_type !=3D HVMSG_OPAQUE_INTERCEPT) {
> +		pr_debug("wrong message type %d", msg->header.message_type);
> +		goto unlock_out;
> +	}
> +
> +	/*
> +	 * Since we directly index the vp, and it has to exist for us to be her=
e
> +	 * (because the vp is only deleted when the partition is), no additiona=
l
> +	 * locking is needed here
> +	 */
> +	vp_index =3D
> +	       ((struct hv_opaque_intercept_message *)msg->u.payload)->vp_index=
;
> +	vp =3D partition->pt_vp_array[vp_index];
> +	if (unlikely(!vp)) {
> +		pr_debug("failed to find VP %u\n", vp_index);
> +		goto unlock_out;
> +	}
> +
> +	kick_vp(vp);
> +
> +	handled =3D true;
> +
> +unlock_out:
> +	rcu_read_unlock();
> +
> +	return handled;
> +}
> +
> +void mshv_isr(void)
> +{
> +	struct hv_synic_pages *spages =3D this_cpu_ptr(mshv_root.synic_pages);
> +	struct hv_message_page **msg_page =3D &spages->synic_message_page;
> +	struct hv_message *msg;
> +	bool handled;
> +
> +	if (unlikely(!(*msg_page))) {
> +		pr_debug("Missing synic page!\n");
> +		return;
> +	}
> +
> +	msg =3D &((*msg_page)->sint_message[HV_SYNIC_INTERCEPTION_SINT_INDEX]);
> +
> +	/*
> +	 * If the type isn't set, there isn't really a message;
> +	 * it may be some other hyperv interrupt
> +	 */
> +	if (msg->header.message_type =3D=3D HVMSG_NONE)
> +		return;
> +
> +	handled =3D mshv_doorbell_isr(msg);
> +
> +	if (!handled)
> +		handled =3D mshv_scheduler_isr(msg);
> +
> +	if (!handled)
> +		handled =3D mshv_async_call_completion_isr(msg);
> +
> +	if (!handled)
> +		handled =3D mshv_intercept_isr(msg);
> +
> +	if (handled) {
> +		/*
> +		 * Acknowledge message with hypervisor if another message is
> +		 * pending.
> +		 */
> +		msg->header.message_type =3D HVMSG_NONE;
> +		/*
> +		 * Ensure the write is complete so the hypervisor will deliver
> +		 * the next message if available.
> +		 */
> +		mb();
> +		if (msg->header.message_flags.msg_pending)
> +			hv_set_non_nested_msr(HV_MSR_EOM, 0);
> +
> +#ifdef HYPERVISOR_CALLBACK_VECTOR
> +		add_interrupt_randomness(HYPERVISOR_CALLBACK_VECTOR);
> +#endif
> +	} else {
> +		pr_warn_once("%s: unknown message type 0x%x\n", __func__,
> +			     msg->header.message_type);
> +	}
> +}
> +
> +int mshv_synic_init(unsigned int cpu)
> +{
> +	union hv_synic_simp simp;
> +	union hv_synic_siefp siefp;
> +	union hv_synic_sirbp sirbp;
> +#ifdef HYPERVISOR_CALLBACK_VECTOR
> +	union hv_synic_sint sint;
> +#endif
> +	union hv_synic_scontrol sctrl;
> +	struct hv_synic_pages *spages =3D this_cpu_ptr(mshv_root.synic_pages);
> +	struct hv_message_page **msg_page =3D &spages->synic_message_page;
> +	struct hv_synic_event_flags_page **event_flags_page =3D
> +			&spages->synic_event_flags_page;
> +	struct hv_synic_event_ring_page **event_ring_page =3D
> +			&spages->synic_event_ring_page;
> +
> +	/* Setup the Synic's message page */
> +	simp.as_uint64 =3D hv_get_non_nested_msr(HV_MSR_SIMP);
> +	simp.simp_enabled =3D true;
> +	*msg_page =3D memremap(simp.base_simp_gpa << HV_HYP_PAGE_SHIFT,
> +			     HV_HYP_PAGE_SIZE,
> +			     MEMREMAP_WB);
> +
> +	if (!(*msg_page))
> +		return -EFAULT;
> +
> +	hv_set_non_nested_msr(HV_MSR_SIMP, simp.as_uint64);
> +
> +	/* Setup the Synic's event flags page */
> +	siefp.as_uint64 =3D hv_get_non_nested_msr(HV_MSR_SIEFP);
> +	siefp.siefp_enabled =3D true;
> +	*event_flags_page =3D memremap(siefp.base_siefp_gpa << PAGE_SHIFT,
> +				     PAGE_SIZE, MEMREMAP_WB);
> +
> +	if (!(*event_flags_page))
> +		goto cleanup;
> +
> +	hv_set_non_nested_msr(HV_MSR_SIEFP, siefp.as_uint64);
> +
> +	/* Setup the Synic's event ring page */
> +	sirbp.as_uint64 =3D hv_get_non_nested_msr(HV_MSR_SIRBP);
> +	sirbp.sirbp_enabled =3D true;
> +	*event_ring_page =3D memremap(sirbp.base_sirbp_gpa << PAGE_SHIFT,
> +				    PAGE_SIZE, MEMREMAP_WB);
> +
> +	if (!(*event_ring_page))
> +		goto cleanup;
> +
> +	hv_set_non_nested_msr(HV_MSR_SIRBP, sirbp.as_uint64);
> +
> +#ifdef HYPERVISOR_CALLBACK_VECTOR
> +	/* Enable intercepts */
> +	sint.as_uint64 =3D 0;
> +	sint.vector =3D HYPERVISOR_CALLBACK_VECTOR;
> +	sint.masked =3D false;
> +	sint.auto_eoi =3D hv_recommend_using_aeoi();
> +	hv_set_non_nested_msr(HV_MSR_SINT0 + HV_SYNIC_INTERCEPTION_SINT_INDEX,
> +			      sint.as_uint64);
> +
> +	/* Doorbell SINT */
> +	sint.as_uint64 =3D 0;
> +	sint.vector =3D HYPERVISOR_CALLBACK_VECTOR;
> +	sint.masked =3D false;
> +	sint.as_intercept =3D 1;
> +	sint.auto_eoi =3D hv_recommend_using_aeoi();
> +	hv_set_non_nested_msr(HV_MSR_SINT0 + HV_SYNIC_DOORBELL_SINT_INDEX,
> +			      sint.as_uint64);
> +#endif
> +
> +	/* Enable global synic bit */
> +	sctrl.as_uint64 =3D hv_get_non_nested_msr(HV_MSR_SCONTROL);
> +	sctrl.enable =3D 1;
> +	hv_set_non_nested_msr(HV_MSR_SCONTROL, sctrl.as_uint64);
> +
> +	return 0;
> +
> +cleanup:
> +	if (*event_ring_page) {
> +		sirbp.sirbp_enabled =3D false;
> +		hv_set_non_nested_msr(HV_MSR_SIRBP, sirbp.as_uint64);
> +		memunmap(*event_ring_page);
> +	}
> +	if (*event_flags_page) {
> +		siefp.siefp_enabled =3D false;
> +		hv_set_non_nested_msr(HV_MSR_SIEFP, siefp.as_uint64);
> +		memunmap(*event_flags_page);
> +	}
> +	if (*msg_page) {
> +		simp.simp_enabled =3D false;
> +		hv_set_non_nested_msr(HV_MSR_SIMP, simp.as_uint64);
> +		memunmap(*msg_page);
> +	}
> +
> +	return -EFAULT;
> +}
> +
> +int mshv_synic_cleanup(unsigned int cpu)
> +{
> +	union hv_synic_sint sint;
> +	union hv_synic_simp simp;
> +	union hv_synic_siefp siefp;
> +	union hv_synic_sirbp sirbp;
> +	union hv_synic_scontrol sctrl;
> +	struct hv_synic_pages *spages =3D this_cpu_ptr(mshv_root.synic_pages);
> +	struct hv_message_page **msg_page =3D &spages->synic_message_page;
> +	struct hv_synic_event_flags_page **event_flags_page =3D
> +		&spages->synic_event_flags_page;
> +	struct hv_synic_event_ring_page **event_ring_page =3D
> +		&spages->synic_event_ring_page;
> +
> +	/* Disable the interrupt */
> +	sint.as_uint64 =3D hv_get_non_nested_msr(HV_MSR_SINT0 + HV_SYNIC_INTERC=
EPTION_SINT_INDEX);
> +	sint.masked =3D true;
> +	hv_set_non_nested_msr(HV_MSR_SINT0 + HV_SYNIC_INTERCEPTION_SINT_INDEX,
> +			      sint.as_uint64);
> +
> +	/* Disable Doorbell SINT */
> +	sint.as_uint64 =3D hv_get_non_nested_msr(HV_MSR_SINT0 + HV_SYNIC_DOORBE=
LL_SINT_INDEX);
> +	sint.masked =3D true;
> +	hv_set_non_nested_msr(HV_MSR_SINT0 + HV_SYNIC_DOORBELL_SINT_INDEX,
> +			      sint.as_uint64);
> +
> +	/* Disable Synic's event ring page */
> +	sirbp.as_uint64 =3D hv_get_non_nested_msr(HV_MSR_SIRBP);
> +	sirbp.sirbp_enabled =3D false;
> +	hv_set_non_nested_msr(HV_MSR_SIRBP, sirbp.as_uint64);
> +	memunmap(*event_ring_page);
> +
> +	/* Disable Synic's event flags page */
> +	siefp.as_uint64 =3D hv_get_non_nested_msr(HV_MSR_SIEFP);
> +	siefp.siefp_enabled =3D false;
> +	hv_set_non_nested_msr(HV_MSR_SIEFP, siefp.as_uint64);
> +	memunmap(*event_flags_page);
> +
> +	/* Disable Synic's message page */
> +	simp.as_uint64 =3D hv_get_non_nested_msr(HV_MSR_SIMP);
> +	simp.simp_enabled =3D false;
> +	hv_set_non_nested_msr(HV_MSR_SIMP, simp.as_uint64);
> +	memunmap(*msg_page);
> +
> +	/* Disable global synic bit */
> +	sctrl.as_uint64 =3D hv_get_non_nested_msr(HV_MSR_SCONTROL);
> +	sctrl.enable =3D 0;
> +	hv_set_non_nested_msr(HV_MSR_SCONTROL, sctrl.as_uint64);
> +
> +	return 0;
> +}
> +
> +int
> +mshv_register_doorbell(u64 partition_id, doorbell_cb_t doorbell_cb, void=
 *data,
> +		       u64 gpa, u64 val, u64 flags)
> +{
> +	struct hv_connection_info connection_info =3D { 0 };
> +	union hv_connection_id connection_id =3D { 0 };
> +	struct port_table_info *port_table_info;
> +	struct hv_port_info port_info =3D { 0 };
> +	union hv_port_id port_id =3D { 0 };
> +	int ret;
> +
> +	port_table_info =3D kmalloc(sizeof(*port_table_info), GFP_KERNEL);
> +	if (!port_table_info)
> +		return -ENOMEM;
> +
> +	port_table_info->hv_port_type =3D HV_PORT_TYPE_DOORBELL;
> +	port_table_info->hv_port_doorbell.doorbell_cb =3D doorbell_cb;
> +	port_table_info->hv_port_doorbell.data =3D data;
> +	ret =3D mshv_portid_alloc(port_table_info);
> +	if (ret < 0) {
> +		kfree(port_table_info);
> +		return ret;
> +	}
> +
> +	port_id.u.id =3D ret;
> +	port_info.port_type =3D HV_PORT_TYPE_DOORBELL;
> +	port_info.doorbell_port_info.target_sint =3D HV_SYNIC_DOORBELL_SINT_IND=
EX;
> +	port_info.doorbell_port_info.target_vp =3D HV_ANY_VP;
> +	ret =3D hv_call_create_port(hv_current_partition_id, port_id, partition=
_id,
> +				  &port_info,
> +				  0, 0, NUMA_NO_NODE);
> +
> +	if (ret < 0) {
> +		mshv_portid_free(port_id.u.id);
> +		return ret;
> +	}
> +
> +	connection_id.u.id =3D port_id.u.id;
> +	connection_info.port_type =3D HV_PORT_TYPE_DOORBELL;
> +	connection_info.doorbell_connection_info.gpa =3D gpa;
> +	connection_info.doorbell_connection_info.trigger_value =3D val;
> +	connection_info.doorbell_connection_info.flags =3D flags;
> +
> +	ret =3D hv_call_connect_port(hv_current_partition_id, port_id, partitio=
n_id,
> +				   connection_id, &connection_info, 0, NUMA_NO_NODE);
> +	if (ret < 0) {
> +		hv_call_delete_port(hv_current_partition_id, port_id);
> +		mshv_portid_free(port_id.u.id);
> +		return ret;
> +	}
> +
> +	// lets use the port_id as the doorbell_id
> +	return port_id.u.id;
> +}
> +
> +void
> +mshv_unregister_doorbell(u64 partition_id, int doorbell_portid)
> +{
> +	union hv_port_id port_id =3D { 0 };
> +	union hv_connection_id connection_id =3D { 0 };
> +
> +	connection_id.u.id =3D doorbell_portid;
> +	hv_call_disconnect_port(partition_id, connection_id);
> +
> +	port_id.u.id =3D doorbell_portid;
> +	hv_call_delete_port(hv_current_partition_id, port_id);
> +
> +	mshv_portid_free(doorbell_portid);
> +}
> diff --git a/include/uapi/linux/mshv.h b/include/uapi/linux/mshv.h
> new file mode 100644
> index 000000000000..9468f66c5658
> --- /dev/null
> +++ b/include/uapi/linux/mshv.h
> @@ -0,0 +1,287 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/*
> + * Userspace interfaces for /dev/mshv* devices and derived fds
> + *
> + * This file is divided into sections containing data structures and IOC=
TLs for
> + * a particular set of related devices or derived file descriptors.
> + *
> + * The IOCTL definitions are at the end of each section. They are groupe=
d by
> + * device/fd, so that new IOCTLs can easily be added with a monotonicall=
y
> + * increasing number.
> + */
> +#ifndef _UAPI_LINUX_MSHV_H
> +#define _UAPI_LINUX_MSHV_H
> +
> +#include <linux/types.h>
> +
> +#define MSHV_IOCTL	0xB8
> +
> +/*
> + *******************************************
> + * Entry point to main VMM APIs: /dev/mshv *
> + *******************************************
> + */
> +
> +enum {
> +	MSHV_PT_BIT_LAPIC,
> +	MSHV_PT_BIT_X2APIC,
> +	MSHV_PT_BIT_GPA_SUPER_PAGES,
> +	MSHV_PT_BIT_COUNT,
> +};
> +
> +#define MSHV_PT_FLAGS_MASK ((1 << MSHV_PT_BIT_COUNT) - 1)
> +
> +enum {
> +	MSHV_PT_ISOLATION_NONE,
> +	MSHV_PT_ISOLATION_COUNT,
> +};
> +
> +/**
> + * struct mshv_create_partition - arguments for MSHV_CREATE_PARTITION
> + * @pt_flags: Bitmask of 1 << MSHV_PT_BIT_*
> + * @pt_isolation: MSHV_PT_ISOLATION_*
> + *
> + * Returns a file descriptor to act as a handle to a guest partition.
> + * At this point the partition is not yet initialized in the hypervisor.
> + * Some operations must be done with the partition in this state, e.g. s=
etting
> + * so-called "early" partition properties. The partition can then be
> + * initialized with MSHV_INITIALIZE_PARTITION.
> + */
> +struct mshv_create_partition {
> +	__u64 pt_flags;
> +	__u64 pt_isolation;
> +};
> +
> +/* /dev/mshv */
> +#define MSHV_CREATE_PARTITION	_IOW(MSHV_IOCTL, 0x00, struct mshv_create_=
partition)
> +
> +/*
> + ************************
> + * Child partition APIs *
> + ************************
> + */
> +
> +struct mshv_create_vp {
> +	__u32 vp_index;
> +};
> +
> +enum {
> +	MSHV_SET_MEM_BIT_WRITABLE,
> +	MSHV_SET_MEM_BIT_EXECUTABLE,
> +	MSHV_SET_MEM_BIT_UNMAP,
> +	MSHV_SET_MEM_BIT_COUNT
> +};
> +
> +#define MSHV_SET_MEM_FLAGS_MASK ((1 << MSHV_SET_MEM_BIT_COUNT) - 1)
> +
> +/**
> + * struct mshv_user_mem_region - arguments for MSHV_SET_GUEST_MEMORY
> + * @size: Size of the memory region (bytes). Must be aligned to PAGE_SIZ=
E
> + * @guest_pfn: Base guest page number to map
> + * @userspace_addr: Base address of userspace memory. Must be aligned to
> + *                  PAGE_SIZE
> + * @flags: Bitmask of 1 << MSHV_SET_MEM_BIT_*. If (1 << MSHV_SET_MEM_BIT=
_UNMAP)
> + *         is set, ignore other bits.
> + * @rsvd: MBZ
> + *
> + * Map or unmap a region of userspace memory to Guest Physical Addresses=
 (GPA).
> + * Mappings can't overlap in GPA space or userspace.
> + * To unmap, these fields must match an existing mapping.
> + */
> +struct mshv_user_mem_region {
> +	__u64 size;
> +	__u64 guest_pfn;
> +	__u64 userspace_addr;
> +	__u8 flags;
> +	__u8 rsvd[7];
> +};
> +
> +enum {
> +	MSHV_IRQFD_BIT_DEASSIGN,
> +	MSHV_IRQFD_BIT_RESAMPLE,
> +	MSHV_IRQFD_BIT_COUNT,
> +};
> +
> +#define MSHV_IRQFD_FLAGS_MASK	((1 << MSHV_IRQFD_BIT_COUNT) - 1)
> +
> +struct mshv_user_irqfd {
> +	__s32 fd;
> +	__s32 resamplefd;
> +	__u32 gsi;
> +	__u32 flags;
> +};
> +
> +enum {
> +	MSHV_IOEVENTFD_BIT_DATAMATCH,
> +	MSHV_IOEVENTFD_BIT_PIO,
> +	MSHV_IOEVENTFD_BIT_DEASSIGN,
> +	MSHV_IOEVENTFD_BIT_COUNT,
> +};
> +
> +#define MSHV_IOEVENTFD_FLAGS_MASK	((1 << MSHV_IOEVENTFD_BIT_COUNT) - 1)
> +
> +struct mshv_user_ioeventfd {
> +	__u64 datamatch;
> +	__u64 addr;	   /* legal pio/mmio address */
> +	__u32 len;	   /* 1, 2, 4, or 8 bytes    */
> +	__s32 fd;
> +	__u32 flags;
> +	__u8  rsvd[4];
> +};
> +
> +struct mshv_user_irq_entry {
> +	__u32 gsi;
> +	__u32 address_lo;
> +	__u32 address_hi;
> +	__u32 data;
> +};
> +
> +struct mshv_user_irq_table {
> +	__u32 nr;
> +	__u32 rsvd; /* MBZ */
> +	struct mshv_user_irq_entry entries[];
> +};
> +
> +enum {
> +	MSHV_GPAP_ACCESS_TYPE_ACCESSED =3D 0,
> +	MSHV_GPAP_ACCESS_TYPE_DIRTY,
> +	MSHV_GPAP_ACCESS_TYPE_COUNT		/* Count of enum members */
> +};
> +
> +enum {
> +	MSHV_GPAP_ACCESS_OP_NOOP =3D 0,
> +	MSHV_GPAP_ACCESS_OP_CLEAR,
> +	MSHV_GPAP_ACCESS_OP_SET,
> +	MSHV_GPAP_ACCESS_OP_COUNT		/* Count of enum members */
> +};

Any reason these two enums explicitly set the first value to 0, while
earlier enums do not?  This is another case of there being a difference,
and me wondering if it's just gratuitous or if there's a specific reason.
Consistency is a good thing!

> +
> +/**
> + * struct mshv_gpap_access_bitmap - arguments for MSHV_GET_GPAP_ACCESS_B=
ITMAP
> + * @access_type: MSHV_GPAP_ACCESS_TYPE_* - The type of access to record =
in the
> + *               bitmap
> + * @access_op: MSHV_GPAP_ACCESS_OP_* - Allows an optional clear or set o=
f all
> + *             the access states in the range, after retrieving the curr=
ent
> + *             states.
> + * @rsvd: MBZ
> + * @page_count: in: number of pages
> + *              out: on error, number of states successfully written to =
bitmap
> + * @gpap_base: Base gpa page number
> + * @bitmap_ptr: Output buffer for bitmap, at least (page_count + 7) / 8 =
bytes
> + *
> + * Retrieve a bitmap of either ACCESSED or DIRTY bits for a given range =
of guest
> + * memory, and optionally clear or set the bits.
> + */
> +struct mshv_gpap_access_bitmap {
> +	__u8 access_type;
> +	__u8 access_op;
> +	__u8 rsvd[6];
> +	__u64 page_count;
> +	__u64 gpap_base;
> +	__u64 bitmap_ptr;
> +};
> +
> +/**
> + * struct mshv_root_hvcall - arguments for MSHV_ROOT_HVCALL
> + * @code: Hypercall code (HVCALL_*)
> + * @reps: in: Rep count ('repcount')
> + *	  out: Reps completed ('repcomp'). MBZ unless rep hvcall
> + * @in_sz: Size of input incl rep data. <=3D HV_HYP_PAGE_SIZE
> + * @out_sz: Size of output buffer. <=3D HV_HYP_PAGE_SIZE. MBZ if out_ptr=
 is 0
> + * @status: in: MBZ
> + *	    out: HV_STATUS_* from hypercall
> + * @rsvd: MBZ
> + * @in_ptr: Input data buffer (struct hv_input_*). If used with partitio=
n or
> + *	    vp fd, partition id field is populated by kernel.
> + * @out_ptr: Output data buffer (optional)
> + */
> +struct mshv_root_hvcall {
> +	__u16 code;
> +	__u16 reps;
> +	__u16 in_sz;
> +	__u16 out_sz;
> +	__u16 status;
> +	__u8 rsvd[6];
> +	__u64 in_ptr;
> +	__u64 out_ptr;
> +};
> +
> +/* Partition fds created with MSHV_CREATE_PARTITION */
> +#define MSHV_INITIALIZE_PARTITION	_IO(MSHV_IOCTL, 0x00)
> +#define MSHV_CREATE_VP			_IOW(MSHV_IOCTL, 0x01, struct mshv_create_vp)
> +#define MSHV_SET_GUEST_MEMORY		_IOW(MSHV_IOCTL, 0x02, struct mshv_user_m=
em_region)
> +#define MSHV_IRQFD			_IOW(MSHV_IOCTL, 0x03, struct mshv_user_irqfd)
> +#define MSHV_IOEVENTFD			_IOW(MSHV_IOCTL, 0x04, struct mshv_user_ioevent=
fd)
> +#define MSHV_SET_MSI_ROUTING		_IOW(MSHV_IOCTL, 0x05, struct mshv_user_ir=
q_table)
> +#define MSHV_GET_GPAP_ACCESS_BITMAP	_IOWR(MSHV_IOCTL, 0x06, struct mshv_=
gpap_access_bitmap)
> +/* Generic hypercall */
> +#define MSHV_ROOT_HVCALL		_IOWR(MSHV_IOCTL, 0x07, struct mshv_root_hvcal=
l)

I really don't like having the ioctl numbers here overlap with the /dev/msh=
v ioctls.
There's just no need to overlap. But I realize changing it now is a big has=
sle.

> +
> +/*
> + ********************************
> + * VP APIs for child partitions *
> + ********************************
> + */
> +
> +#define MSHV_RUN_VP_BUF_SZ 256
> +
> +/*
> + * Map various VP state pages to userspace.
> + * Multiply the offset by PAGE_SIZE before being passed as the 'offset'
> + * argument to mmap().
> + * e.g.
> + * void *reg_page =3D mmap(NULL, PAGE_SIZE, PROT_READ|PROT_WRITE,
> + *                       MAP_SHARED, vp_fd,
> + *                       MSHV_VP_MMAP_OFFSET_REGISTERS * PAGE_SIZE);
> + */

This is interesting.  I would not have thought PAGE_SIZE is available
in the UAPI.  You must use something like the getpagesize() call. I know
the root partition can only run with a 4K page size, but the symbol
"PAGE_SIZE" is probably kernel code only.

> +enum {
> +	MSHV_VP_MMAP_OFFSET_REGISTERS,
> +	MSHV_VP_MMAP_OFFSET_INTERCEPT_MESSAGE,
> +	MSHV_VP_MMAP_OFFSET_GHCB,
> +	MSHV_VP_MMAP_OFFSET_COUNT
> +};
> +
> +/**
> + * struct mshv_run_vp - argument for MSHV_RUN_VP
> + * @msg_buf: On success, the intercept message is copied here. It can be
> + *           interpreted using the relevant hypervisor definitions.
> + */
> +struct mshv_run_vp {
> +	__u8 msg_buf[MSHV_RUN_VP_BUF_SZ];
> +};
> +
> +enum {
> +	MSHV_VP_STATE_LAPIC,		/* Local interrupt controller state (either arch)=
 */
> +	MSHV_VP_STATE_XSAVE,		/* XSAVE data in compacted form (x86_64) */
> +	MSHV_VP_STATE_SIMP,
> +	MSHV_VP_STATE_SIEFP,
> +	MSHV_VP_STATE_SYNTHETIC_TIMERS,
> +	MSHV_VP_STATE_COUNT,
> +};
> +
> +/**
> + * struct mshv_get_set_vp_hvcall - arguments for MSHV_[GET,SET]_VP_STATE

s/hvcall/state/

> + * @type: MSHV_VP_STATE_*
> + * @rsvd: MBZ
> + * @buf_sz: in: 4k page-aligned size of buffer
> + *          out: Actual size of data (on EINVAL, check this to see if bu=
ffer
> + *               was too small)
> + * @buf_ptr: 4k page-aligned data buffer
> + */
> +struct mshv_get_set_vp_state {
> +	__u8 type;
> +	__u8 rsvd[3];
> +	__u32 buf_sz;
> +	__u64 buf_ptr;
> +};
> +
> +/* VP fds created with MSHV_CREATE_VP */
> +#define MSHV_RUN_VP			_IOR(MSHV_IOCTL, 0x00, struct mshv_run_vp)
> +#define MSHV_GET_VP_STATE		_IOWR(MSHV_IOCTL, 0x01, struct mshv_get_set_v=
p_state)
> +#define MSHV_SET_VP_STATE		_IOWR(MSHV_IOCTL, 0x02, struct mshv_get_set_v=
p_state)
> +/*
> + * Generic hypercall
> + * Defined above in partition IOCTLs, avoid redefining it here
> + * #define MSHV_ROOT_HVCALL			_IOWR(MSHV_IOCTL, 0x07, struct mshv_root_h=
vcall)
> + */
> +
> +#endif
> --
> 2.34.1


