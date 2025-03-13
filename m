Return-Path: <linux-arch+bounces-10742-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78662A5FC54
	for <lists+linux-arch@lfdr.de>; Thu, 13 Mar 2025 17:43:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F36627A6698
	for <lists+linux-arch@lfdr.de>; Thu, 13 Mar 2025 16:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54672267B77;
	Thu, 13 Mar 2025 16:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="iFTmTlDb"
X-Original-To: linux-arch@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azolkn19010003.outbound.protection.outlook.com [52.103.10.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FD723BD13;
	Thu, 13 Mar 2025 16:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.10.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741884214; cv=fail; b=by6DexlRIz7AxAN5EvCOEFBi07SJ/xG9dAzwqHzU6yyHRX0Hxlf9dHiyCWTvwH8rtsDM2HCdzUtDJACwyeDyVTH63zruXJrS6rHisfQcM3BU80XOLbKM7MyDIOnMsiLiauOHbd2wx7zQeEgRlpZFl7agP9EulekGdovI4DFbYjg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741884214; c=relaxed/simple;
	bh=Hv8xbeatAf6up0FJbif+H07nR8QUUkt2ecxxsZ2cP5g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DdGVMtgS4tzWmTpPmRYv3HuMkIQQXbIRKUSXn1Fqe2isKwpyuRufOOUwnUl5KxhsTjSaUBzYbn+uRDNBDAlQnGPzMP9JX2n7eDRNNm8TpBPnsbJa/10/NvyfOSk9kYBtmMP74GxpL9GgkiAfR/Y3BST9isfNOUM86YcNO/DvokI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=iFTmTlDb; arc=fail smtp.client-ip=52.103.10.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fn+9YPv0+LFm/uf8E+xgeb8EUdoJAG/05ls+m9stfqnOOijJvdDolPOZldKX1JnKf1TLIuEdFXowzf+5U3NsENwnDI6hMfDiWZk62ay+cSyZ4mvgDdT4J60GPSvMHXgqbmKelJx2/LRyocmpXz6tuBKwfic6byfRu7Cybh5fRNZJa0H6CNMaxwmairvgtoP5ZCCxVQ4DT1yyQWCzi6/KyBPsabGArrOTOPIAugDT1qWS9nwRAvHPedSA3qhMtFK/SrZkANv+C7kV8MMqtO6OgYJq3UwYko83u5gpugSncnr6uj9h0ye7NAXSL1sipv0gkvtOqJUKYV4eoLMhPnfFKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mYhV6o9BkYm2TIzxACnX40Dr2ewBN6RHSfcWnmYrBOY=;
 b=n8SQs3Xq9AaOj2MMZNUVU7A7w1pJ5o003+NtbvZhGXb5DavDLd/2EK6SmdQ8CaEn34tSFRpuzH8058fGWUZL5RyfJO9qNrP0oD8YkgGHGYOVsJFk4Q6u5JKkf0HqyvDUcXS/i30fBJTPPCB1wB1cHq6im29HPKxvQMdPoQrX59punAVZTeeAdLz6hU6vv3cFsNnNoDtbJjEpUN2H4ZLBN8WWAcdtOspV3zW2/37Q0/uz0objAC17uX2y6rlOWLij9qLJmULNALAfvIvdr0zv2xfU8+Bw21nhYHaJikjrmp3P4QcoZboLr5K6dm+Bhe/bX/kJ2c/it+4ePIX3iQC8/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mYhV6o9BkYm2TIzxACnX40Dr2ewBN6RHSfcWnmYrBOY=;
 b=iFTmTlDbwC+bPbA8l2ifclUDgPRAxgfHXyt/9dvzRFu66FVIiBHb3p39h9rdimJ+WP4QO9QKYDlr+LLXGtOxtXpC2boRRJndyYJnWkS5fT+JkOSL+P+tC3odBz8AqxqMK6+vCk1xx8al4rEN2UAgQTW1fwhCCVRuk5HGr8qBnQ3jGelFIRgeFkjFit5jXIMLZTMgdTLF1Cu9xXQKedG0x090M1KbAHr3d7fiG8z6OWQ9O1UUKA4lGuxdewVeINffBzc7m4Q4SQLcA2AdqkpNA//xnCkWkSKYurv798j2e6BA757+CyxxjIGXVWy+pkdNDo0k51Az3G6VHRbAPS/phw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by BY5PR02MB7025.namprd02.prod.outlook.com (2603:10b6:a03:238::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Thu, 13 Mar
 2025 16:43:24 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 16:43:24 +0000
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
Thread-Index: AQHbiKNt140GtdgK20KtRyAXlJwH1rNuG4iA
Date: Thu, 13 Mar 2025 16:43:24 +0000
Message-ID:
 <SN6PR02MB4157C3F431CD26EDA05E4AD4D4D32@SN6PR02MB4157.namprd02.prod.outlook.com>
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
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|BY5PR02MB7025:EE_
x-ms-office365-filtering-correlation-id: 16e009d1-70c2-43e6-d3ca-08dd624e2c19
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799003|15080799006|12121999004|8060799006|8062599003|461199028|3412199025|440099028|12091999003|41001999003|30101999003|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?wKvl6PQhWAg2D3pB9vR74qAluxCCgJG4aVi5W1Attu/wX3o1KWxgVTr1cr4s?=
 =?us-ascii?Q?IdYqEJQWmdhcu/NZqr27ctJxbp2r1Rf32t9Fxh81KZMZwxavD+vmyTLmw1J5?=
 =?us-ascii?Q?tBOV1rYdm+3RvrOax0GS2DH83IoWDguizMtHWU/agzVTECrk/ZiZT2yofE3F?=
 =?us-ascii?Q?FHvVmnFyZ1Aouk12fXnHYCunTrhAavFdJtN5CMt9BF7TkxxkJuetLhxAh5Nk?=
 =?us-ascii?Q?VI+HA1z6Dx6lrwdnRiHBHXRbbRXvmIUfn0VYlX/CFA00ndQ6YXuvxf+nUujm?=
 =?us-ascii?Q?JxkSLrsXZlwDbpOJMl6W/QzpmjaMGNTUG9GP1yDVHtxnitkfVwgL3dC35mxv?=
 =?us-ascii?Q?Cg3ULndAQeBM8onaCfXa/YzkAT76w7QiUKLKoHVHHLpC8ybjjTZNNXHlLJ9s?=
 =?us-ascii?Q?1GlJoMHW92uLHB7U5iVbIuvVRudwvkbYVZI2WOV25apWCbMmkmKzv0EltIj7?=
 =?us-ascii?Q?3qLACpU4r8W2aiZ8H7nyp4fw6TktVPxsEwU0cpxgPjHTDA+2lBSWerL396uV?=
 =?us-ascii?Q?CXXp4iueU9mR4WQ2Xg65MFH5dDekNFERpJpLqdfTGj/T7KVek7xKjvrtm8g4?=
 =?us-ascii?Q?QUxb1m10OXUrkyore3gzW9SYXiFDHJu60ZJlY1+gWvMKmDbrw0kRZWo3zh8b?=
 =?us-ascii?Q?7RzZvzh77Ytdtw2BbyoWDyLFaaEtRG+2i7SRsZXtctsAnIl9M/ob97o+7Gxx?=
 =?us-ascii?Q?35/RIiIrb4LHXFTUgbXeZ8t/dQ1vy02k4MCKaanD50wGnia/6y4FmRwvY7Ah?=
 =?us-ascii?Q?8oE2opCIE5oZQiIDoVKrYl418cSK60lqmGpR37YqD+y9kt3ara2KrL0VZ2v3?=
 =?us-ascii?Q?uXvuGJVbBl4jbAZNnc/cSmHOqEBUFQhk5O0gBVS5VNqavjlfNNZi7rfJzMvP?=
 =?us-ascii?Q?RvlumH/x2FdE5PYCWQaXXzCw5o+5RbRP93uPxdlwenxsLJXWprDv9B2c6qLb?=
 =?us-ascii?Q?PH2UGHkfeWYZzLh7AaNNurhNlqfTBxWQ+/ZIJjT87RupXgYCMfxP4xr+rKXX?=
 =?us-ascii?Q?BEHkcN/Cx7rHf+n5FwQsSKaujTdGOBprAlONbKm6hUdOgkgH1thssY3CByWx?=
 =?us-ascii?Q?UgF+4s/Tgk8BwjlSCNlnnchc566df3Sa5bRImoq6TfmbiLKVeB739+sFGPIQ?=
 =?us-ascii?Q?QHLySb3YQ6uHW9RBJ36Vb3rfN68AzEGE5jBM8mTygjucbn4juMtpCXQ=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Ozv08uVTaK0EDfmYPghzKQSNM+bEahLVILI2VZGG4Gg7CD/f27IMrhDL8uks?=
 =?us-ascii?Q?R6xzWcFwIgH7e8TkRrPi2ymTSjQst9rXG4+l4JmAyKgBBH+n0IFBMCqln833?=
 =?us-ascii?Q?+5q0p9kD2fABZNhX6LVWl+rDswW8f/7bMsHMpD0+m7h1eTJiyxTBOfJvwcbg?=
 =?us-ascii?Q?gEXOHgB5j3+ay+HVvRqvfyXRY2b3GLci1SA31zrhaXkIVdMv1v/3bEaUh5Gd?=
 =?us-ascii?Q?+OXjojJIK5TT+BFG7fyFHLjWlIZRM7AhIXE0P8KX1PP1frfZoJP8MZ/ViY5e?=
 =?us-ascii?Q?ag5Qv8GHYcM2zFkzlcWywxjqN1RNj/+YfgFpYH9/XHZQwTVBeFSWkAymPlub?=
 =?us-ascii?Q?GIXjz/+zJCv18Rc1YQXrJnwVEOAEf13aldIu2DIGZ6tP4Poj6IllhoYXVhyo?=
 =?us-ascii?Q?9rh8zvcuXERxt/NSNLenNnKmJo4ZyDmSbsptrHlgn4B/IDufLyS02Ruy6Xk9?=
 =?us-ascii?Q?PAe1t8AfoXpawVEEyy7yAiXHfe4sM7ROXA9I6MJBSEL+ss0cjKxAgqY1ySzu?=
 =?us-ascii?Q?l+/ydv3XDj0WPnQGXYxwPfBAaS0RVQoEXZ8bYc6Aq7kzKPY/2ZQ6hUMjK6sh?=
 =?us-ascii?Q?xuocYrvo7heByVWAG2Wdqb4TjtvX8rDWBkWOwouISWz38GaMTBxfcimVvBa8?=
 =?us-ascii?Q?a/y7JSZx5c/PqAqrDnV76vVkpMr2DliqCpC2ikf+eIPF7xa3RIi612Yk5Dsx?=
 =?us-ascii?Q?WumBkGuw7gz4HoM9mzKmcxBOfrc1Dkxopemc+3OuWi5P790/jvoVkY5tVXz6?=
 =?us-ascii?Q?76c9W5ZcDxXt3d1Rch5PQYthe2SRLPXHBzs5csskGrwMUOJrJxtX0U1SW8Qz?=
 =?us-ascii?Q?+JH4Hd4+tOg2FVC78j7wgoj35NdzCvLq8NyJK06+IucMA2W0c66/JH7l1997?=
 =?us-ascii?Q?Ml2fI5X9rJVWwX+FaYY8YtGu3IxUb+rnWTCh5MAb8/3nqebLw/PH1zuNJqve?=
 =?us-ascii?Q?WmDY7su3kjnPCn7CDI6AGl61uIWuItOomcVOodVaOVC5WV1RSgzXTeJUXZgJ?=
 =?us-ascii?Q?i0HdU/2J0PrdxgBn3rQHyNqNX3kYa4EYRyNTfUgIzRzqx+8dKNOV7ILa4O8X?=
 =?us-ascii?Q?35PHoE+Hmkztx5tEYtUO5biqQ7o7GhDMU3Uw8/zq+YNX5VqYvRNL1bhyCipA?=
 =?us-ascii?Q?7QMHPbkbf6wC4+H8l9upkYithpHwE5sFvHRs0aXjn5Hndp1Sfa37T2u6rg03?=
 =?us-ascii?Q?A7a4/yhfsmMcD9A7tVcNxA/UGVcsRIs2Q544izO8JdXrP/SCzYdyvjTjF2Q?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 16e009d1-70c2-43e6-d3ca-08dd624e2c19
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2025 16:43:24.3103
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB7025

From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Wednesday, Fe=
bruary 26, 2025 3:08 PM
>=20

I've done a partial review of the code in this patch.  See comments inline
as usual.

I'd like to still review most of the code in mshv_root_main.c, and maybe
some of mshv_synic.c and include/uapi/linux/mshv.c. I'll send a separate
email with those comments when I complete them. The patch is huge, so
I'm breaking my review comments into two parts.

I've glanced through mshv_eventfd.c, mshv_eventfd.h, and mshv_irq.c,
but I don't have enough knowledge/expertise in these areas to add any
useful comments, so I'm not planning to review them further.

> Provide a set of IOCTLs for creating and managing child partitions when
> running as root partition on Hyper-V. The new driver is enabled via
> CONFIG_MSHV_ROOT.
>=20
> A brief overview of the interface:
>=20
> MSHV_CREATE_PARTITION is the entry point, returning a file descriptor
> representing a child partition. IOCTLs on this fd can be used to map
> memory, create VPs, etc.
>=20
> Creating a VP returns another file descriptor representing that VP which
> in turn has another set of corresponding IOCTLs for running the VP,
> getting/setting state, etc.
>=20
> MSHV_ROOT_HVCALL is a generic "passthrough" hypercall IOCTL which can be
> used for a number of partition or VP hypercalls. This is for hypercalls
> that do not affect any state in the kernel driver, such as getting and
> setting VP registers and partition properties, translating addresses,
> etc. It is "passthrough" because the binary input and output for the
> hypercall is only interpreted by the VMM - the kernel driver does
> nothing but insert the VP and partition id where necessary (which are
> always in the same place), and execute the hypercall.
>=20
> Co-developed-by: Wei Liu <wei.liu@kernel.org>
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> Co-developed-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> Co-developed-by: Praveen K Paladugu <prapal@linux.microsoft.com>
> Signed-off-by: Praveen K Paladugu <prapal@linux.microsoft.com>
> Co-developed-by: Mukesh Rathor <mrathor@linux.microsoft.com>
> Signed-off-by: Mukesh Rathor <mrathor@linux.microsoft.com>
> Co-developed-by: Jinank Jain <jinankjain@microsoft.com>
> Signed-off-by: Jinank Jain <jinankjain@microsoft.com>
> Co-developed-by: Muminul Islam <muislam@microsoft.com>
> Signed-off-by: Muminul Islam <muislam@microsoft.com>
> Co-developed-by: Anirudh Rayabharam <anrayabh@linux.microsoft.com>
> Signed-off-by: Anirudh Rayabharam <anrayabh@linux.microsoft.com>
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> ---
>  .../userspace-api/ioctl/ioctl-number.rst      |    2 +
>  drivers/hv/Makefile                           |    5 +-
>  drivers/hv/mshv.h                             |   30 +
>  drivers/hv/mshv_common.c                      |  161 ++
>  drivers/hv/mshv_eventfd.c                     |  833 ++++++
>  drivers/hv/mshv_eventfd.h                     |   71 +
>  drivers/hv/mshv_irq.c                         |  128 +
>  drivers/hv/mshv_portid_table.c                |   84 +
>  drivers/hv/mshv_root.h                        |  321 +++
>  drivers/hv/mshv_root_hv_call.c                |  876 +++++++
>  drivers/hv/mshv_root_main.c                   | 2329 +++++++++++++++++
>  drivers/hv/mshv_synic.c                       |  665 +++++
>  include/uapi/linux/mshv.h                     |  287 ++
>  13 files changed, 5791 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/hv/mshv.h
>  create mode 100644 drivers/hv/mshv_common.c
>  create mode 100644 drivers/hv/mshv_eventfd.c
>  create mode 100644 drivers/hv/mshv_eventfd.h
>  create mode 100644 drivers/hv/mshv_irq.c
>  create mode 100644 drivers/hv/mshv_portid_table.c
>  create mode 100644 drivers/hv/mshv_root.h
>  create mode 100644 drivers/hv/mshv_root_hv_call.c
>  create mode 100644 drivers/hv/mshv_root_main.c
>  create mode 100644 drivers/hv/mshv_synic.c
>  create mode 100644 include/uapi/linux/mshv.h
>=20
> diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst
> b/Documentation/userspace-api/ioctl/ioctl-number.rst
> index 6d1465315df3..66dcfaae698b 100644
> --- a/Documentation/userspace-api/ioctl/ioctl-number.rst
> +++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
> @@ -370,6 +370,8 @@ Code  Seq#    Include File                           =
                Comments
>  0xB7  all    uapi/linux/remoteproc_cdev.h                            <ma=
ilto:linux-
> remoteproc@vger.kernel.org>
>  0xB7  all    uapi/linux/nsfs.h                                       <ma=
ilto:Andrei Vagin
> <avagin@openvz.org>>
>  0xB8  01-02  uapi/misc/mrvl_cn10k_dpi.h                              Mar=
vell CN10K DPI driver
> +0xB8  all    uapi/linux/mshv.h                                       Mic=
rosoft Hyper-V /dev/mshv driver

Hmmm. Doesn't this mean that the mshv ioctls overlap with the Marvell
CN10K DPI ioctls? Is that intentional? I thought the goal of the central
registry in ioctl-number.rst is to avoid overlap.

> +                                                                     <ma=
ilto:linux-hyperv@vger.kernel.org>
>  0xC0  00-0F  linux/usb/iowarrior.h
>  0xCA  00-0F  uapi/misc/cxl.h
>  0xCA  10-2F  uapi/misc/ocxl.h
> diff --git a/drivers/hv/Makefile b/drivers/hv/Makefile
> index 2b8dc954b350..976189c725dc 100644
> --- a/drivers/hv/Makefile
> +++ b/drivers/hv/Makefile
> @@ -2,6 +2,7 @@
>  obj-$(CONFIG_HYPERV)		+=3D hv_vmbus.o
>  obj-$(CONFIG_HYPERV_UTILS)	+=3D hv_utils.o
>  obj-$(CONFIG_HYPERV_BALLOON)	+=3D hv_balloon.o
> +obj-$(CONFIG_MSHV_ROOT)		+=3D mshv_root.o
>=20
>  CFLAGS_hv_trace.o =3D -I$(src)
>  CFLAGS_hv_balloon.o =3D -I$(src)
> @@ -11,7 +12,9 @@ hv_vmbus-y :=3D vmbus_drv.o \
>  		 channel_mgmt.o ring_buffer.o hv_trace.o
>  hv_vmbus-$(CONFIG_HYPERV_TESTING)	+=3D hv_debugfs.o
>  hv_utils-y :=3D hv_util.o hv_kvp.o hv_snapshot.o hv_utils_transport.o
> +mshv_root-y :=3D mshv_root_main.o mshv_synic.o mshv_eventfd.o mshv_irq.o=
 \
> +	       mshv_root_hv_call.o mshv_portid_table.o
>=20
>  # Code that must be built-in
>  obj-$(subst m,y,$(CONFIG_HYPERV)) +=3D hv_common.o
> -obj-$(subst m,y,$(CONFIG_MSHV_ROOT)) +=3D hv_proc.o
> +obj-$(subst m,y,$(CONFIG_MSHV_ROOT)) +=3D hv_proc.o mshv_common.o
> diff --git a/drivers/hv/mshv.h b/drivers/hv/mshv.h
> new file mode 100644
> index 000000000000..0340a67acd0a
> --- /dev/null
> +++ b/drivers/hv/mshv.h
> @@ -0,0 +1,30 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2023, Microsoft Corporation.
> + */
> +
> +#ifndef _MSHV_H_
> +#define _MSHV_H_
> +
> +#include <linux/stddef.h>
> +#include <linux/string.h>
> +#include <hyperv/hvhdk.h>
> +
> +#define mshv_field_nonzero(STRUCT, MEMBER) \
> +	memchr_inv(&((STRUCT).MEMBER), \
> +		   0, sizeof_field(typeof(STRUCT), MEMBER))
> +
> +int hv_call_get_vp_registers(u32 vp_index, u64 partition_id, u16 count,
> +			     union hv_input_vtl input_vtl,
> +			     struct hv_register_assoc *registers);
> +
> +int hv_call_set_vp_registers(u32 vp_index, u64 partition_id, u16 count,
> +			     union hv_input_vtl input_vtl,
> +			     struct hv_register_assoc *registers);
> +
> +int hv_call_get_partition_property(u64 partition_id, u64 property_code,
> +				   u64 *property_value);
> +
> +int mshv_do_pre_guest_mode_work(ulong th_flags);
> +
> +#endif /* _MSHV_H */
> diff --git a/drivers/hv/mshv_common.c b/drivers/hv/mshv_common.c
> new file mode 100644
> index 000000000000..d97631dcbee1
> --- /dev/null
> +++ b/drivers/hv/mshv_common.c
> @@ -0,0 +1,161 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2024, Microsoft Corporation.
> + *
> + * This file contains functions that are called from one or more modules=
: ROOT,
> + * DIAG, or VTL. If any of these modules are configured to build, this f=
ile is

What are the DIAG and VTL modules?  I see only a root module in the Makefil=
e.

> + * built and just statically linked in.
> + *
> + * Authors: Microsoft Linux virtualization team
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/mm.h>
> +#include <asm/mshyperv.h>
> +#include <linux/resume_user_mode.h>
> +
> +#include "mshv.h"
> +
> +#define HV_GET_REGISTER_BATCH_SIZE	\
> +	(HV_HYP_PAGE_SIZE / sizeof(union hv_register_value))
> +#define HV_SET_REGISTER_BATCH_SIZE	\
> +	((HV_HYP_PAGE_SIZE - sizeof(struct hv_input_set_vp_registers)) \
> +		/ sizeof(struct hv_register_assoc))
> +
> +int hv_call_get_vp_registers(u32 vp_index, u64 partition_id, u16 count,
> +			     union hv_input_vtl input_vtl,
> +			     struct hv_register_assoc *registers)
> +{
> +	struct hv_input_get_vp_registers *input_page;
> +	union hv_register_value *output_page;
> +	u16 completed =3D 0;
> +	unsigned long remaining =3D count;
> +	int rep_count, i;
> +	u64 status =3D HV_STATUS_SUCCESS;
> +	unsigned long flags;
> +
> +	local_irq_save(flags);
> +
> +	input_page =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	output_page =3D *this_cpu_ptr(hyperv_pcpu_output_arg);
> +
> +	input_page->partition_id =3D partition_id;
> +	input_page->vp_index =3D vp_index;
> +	input_page->input_vtl.as_uint8 =3D input_vtl.as_uint8;
> +	input_page->rsvd_z8 =3D 0;
> +	input_page->rsvd_z16 =3D 0;
> +
> +	while (remaining) {
> +		rep_count =3D min(remaining, HV_GET_REGISTER_BATCH_SIZE);
> +		for (i =3D 0; i < rep_count; ++i)
> +			input_page->names[i] =3D registers[i].name;
> +
> +		status =3D hv_do_rep_hypercall(HVCALL_GET_VP_REGISTERS, rep_count,
> +					     0, input_page, output_page);
> +		if (!hv_result_success(status))
> +			break;
> +
> +		completed =3D hv_repcomp(status);
> +		for (i =3D 0; i < completed; ++i)
> +			registers[i].value =3D output_page[i];
> +
> +		registers +=3D completed;
> +		remaining -=3D completed;
> +	}
> +	local_irq_restore(flags);
> +
> +	return hv_result_to_errno(status);
> +}
> +EXPORT_SYMBOL_GPL(hv_call_get_vp_registers);
> +
> +int hv_call_set_vp_registers(u32 vp_index, u64 partition_id, u16 count,
> +			     union hv_input_vtl input_vtl,
> +			     struct hv_register_assoc *registers)
> +{
> +	struct hv_input_set_vp_registers *input_page;
> +	u16 completed =3D 0;
> +	unsigned long remaining =3D count;
> +	int rep_count;
> +	u64 status =3D HV_STATUS_SUCCESS;
> +	unsigned long flags;
> +
> +	local_irq_save(flags);
> +	input_page =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> +
> +	input_page->partition_id =3D partition_id;
> +	input_page->vp_index =3D vp_index;
> +	input_page->input_vtl.as_uint8 =3D input_vtl.as_uint8;
> +	input_page->rsvd_z8 =3D 0;
> +	input_page->rsvd_z16 =3D 0;
> +
> +	while (remaining) {
> +		rep_count =3D min(remaining, HV_SET_REGISTER_BATCH_SIZE);
> +		memcpy(input_page->elements, registers,
> +		       sizeof(struct hv_register_assoc) * rep_count);
> +
> +		status =3D hv_do_rep_hypercall(HVCALL_SET_VP_REGISTERS, rep_count,
> +					     0, input_page, NULL);
> +		if (!hv_result_success(status))
> +			break;
> +
> +		completed =3D hv_repcomp(status);
> +		registers +=3D completed;
> +		remaining -=3D completed;
> +	}
> +
> +	local_irq_restore(flags);
> +
> +	return hv_result_to_errno(status);
> +}
> +EXPORT_SYMBOL_GPL(hv_call_set_vp_registers);
> +
> +int hv_call_get_partition_property(u64 partition_id,
> +				   u64 property_code,
> +				   u64 *property_value)
> +{
> +	u64 status;
> +	unsigned long flags;
> +	struct hv_input_get_partition_property *input;
> +	struct hv_output_get_partition_property *output;
> +
> +	local_irq_save(flags);
> +	input =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	output =3D *this_cpu_ptr(hyperv_pcpu_output_arg);
> +	memset(input, 0, sizeof(*input));
> +	input->partition_id =3D partition_id;
> +	input->property_code =3D property_code;
> +	status =3D hv_do_hypercall(HVCALL_GET_PARTITION_PROPERTY, input, output=
);
> +
> +	if (!hv_result_success(status)) {
> +		local_irq_restore(flags);
> +		return hv_result_to_errno(status);
> +	}
> +	*property_value =3D output->property_value;
> +
> +	local_irq_restore(flags);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(hv_call_get_partition_property);
> +
> +/*
> + * Handle any pre-processing before going into the guest mode on this cp=
u, most
> + * notably call schedule(). Must be invoked with both preemption and
> + * interrupts enabled.
> + *
> + * Returns: 0 on success, -errno on error.
> + */
> +int mshv_do_pre_guest_mode_work(ulong th_flags)
> +{
> +	if (th_flags & (_TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL))
> +		return -EINTR;
> +
> +	if (th_flags & _TIF_NEED_RESCHED)
> +		schedule();
> +
> +	if (th_flags & _TIF_NOTIFY_RESUME)
> +		resume_user_mode_work(NULL);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(mshv_do_pre_guest_mode_work);
> diff --git a/drivers/hv/mshv_eventfd.c b/drivers/hv/mshv_eventfd.c
> new file mode 100644
> index 000000000000..8dd22be2ca0b
> --- /dev/null
> +++ b/drivers/hv/mshv_eventfd.c
> @@ -0,0 +1,833 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * eventfd support for mshv
> + *
> + * Heavily inspired from KVM implementation of irqfd/ioeventfd. The basi=
c
> + * framework code is taken from the kvm implementation.
> + *
> + * All credits to kvm developers.
> + */
> +
> +#include <linux/syscalls.h>
> +#include <linux/wait.h>
> +#include <linux/poll.h>
> +#include <linux/file.h>
> +#include <linux/list.h>
> +#include <linux/workqueue.h>
> +#include <linux/eventfd.h>
> +
> +#if IS_ENABLED(CONFIG_X86_64)
> +#include <asm/apic.h>
> +#endif
> +#include <asm/mshyperv.h>
> +
> +#include "mshv_eventfd.h"
> +#include "mshv.h"
> +#include "mshv_root.h"
> +
> +static struct workqueue_struct *irqfd_cleanup_wq;
> +
> +void mshv_register_irq_ack_notifier(struct mshv_partition *partition,
> +				    struct mshv_irq_ack_notifier *mian)
> +{
> +	mutex_lock(&partition->pt_irq_lock);
> +	hlist_add_head_rcu(&mian->link, &partition->irq_ack_notifier_list);
> +	mutex_unlock(&partition->pt_irq_lock);
> +}
> +
> +void mshv_unregister_irq_ack_notifier(struct mshv_partition *partition,
> +				      struct mshv_irq_ack_notifier *mian)
> +{
> +	mutex_lock(&partition->pt_irq_lock);
> +	hlist_del_init_rcu(&mian->link);
> +	mutex_unlock(&partition->pt_irq_lock);
> +	synchronize_rcu();
> +}
> +
> +bool mshv_notify_acked_gsi(struct mshv_partition *partition, int gsi)
> +{
> +	struct mshv_irq_ack_notifier *mian;
> +	bool acked =3D false;
> +
> +	rcu_read_lock();
> +	hlist_for_each_entry_rcu(mian, &partition->irq_ack_notifier_list,
> +				 link) {
> +		if (mian->irq_ack_gsi =3D=3D gsi) {
> +			mian->irq_acked(mian);
> +			acked =3D true;
> +		}
> +	}
> +	rcu_read_unlock();
> +
> +	return acked;
> +}
> +
> +#if IS_ENABLED(CONFIG_ARM64)
> +static inline bool hv_should_clear_interrupt(enum hv_interrupt_type type=
)
> +{
> +	return false;
> +}
> +#elif IS_ENABLED(CONFIG_X86_64)
> +static inline bool hv_should_clear_interrupt(enum hv_interrupt_type type=
)
> +{
> +	return type =3D=3D HV_X64_INTERRUPT_TYPE_EXTINT;
> +}
> +#endif
> +
> +static void mshv_irqfd_resampler_ack(struct mshv_irq_ack_notifier *mian)
> +{
> +	struct mshv_irqfd_resampler *resampler;
> +	struct mshv_partition *partition;
> +	struct mshv_irqfd *irqfd;
> +	int idx;
> +
> +	resampler =3D container_of(mian, struct mshv_irqfd_resampler,
> +				 rsmplr_notifier);
> +	partition =3D resampler->rsmplr_partn;
> +
> +	idx =3D srcu_read_lock(&partition->pt_irq_srcu);
> +
> +	hlist_for_each_entry_rcu(irqfd, &resampler->rsmplr_irqfd_list,
> +				 irqfd_resampler_hnode) {
> +		if (hv_should_clear_interrupt(irqfd->irqfd_lapic_irq.lapic_control.int=
errupt_type))
> +			hv_call_clear_virtual_interrupt(partition->pt_id);
> +
> +		eventfd_signal(irqfd->irqfd_resamplefd);
> +	}
> +
> +	srcu_read_unlock(&partition->pt_irq_srcu, idx);
> +}
> +
> +#if IS_ENABLED(CONFIG_X86_64)
> +static bool
> +mshv_vp_irq_vector_injected(union hv_vp_register_page_interrupt_vectors =
iv,
> +			    u32 vector)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < iv.vector_count; i++) {
> +		if (iv.vector[i] =3D=3D vector)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
> +static int mshv_vp_irq_try_set_vector(struct mshv_vp *vp, u32 vector)
> +{
> +	union hv_vp_register_page_interrupt_vectors iv, new_iv;
> +
> +	iv =3D vp->vp_register_page->interrupt_vectors;
> +	new_iv =3D iv;
> +
> +	if (mshv_vp_irq_vector_injected(iv, vector))
> +		return 0;
> +
> +	if (iv.vector_count >=3D HV_VP_REGISTER_PAGE_MAX_VECTOR_COUNT)
> +		return -ENOSPC;
> +
> +	new_iv.vector[new_iv.vector_count++] =3D vector;
> +
> +	if (cmpxchg(&vp->vp_register_page->interrupt_vectors.as_uint64,
> +		    iv.as_uint64, new_iv.as_uint64) !=3D iv.as_uint64)
> +		return -EAGAIN;
> +
> +	return 0;
> +}
> +
> +static int mshv_vp_irq_set_vector(struct mshv_vp *vp, u32 vector)
> +{
> +	int ret;
> +
> +	do {
> +		ret =3D mshv_vp_irq_try_set_vector(vp, vector);
> +	} while (ret =3D=3D -EAGAIN && !need_resched());
> +
> +	return ret;
> +}
> +
> +/*
> + * Try to raise irq for guest via shared vector array. hyp does the actu=
al
> + * inject of the interrupt.
> + */
> +static int mshv_try_assert_irq_fast(struct mshv_irqfd *irqfd)
> +{
> +	struct mshv_partition *partition =3D irqfd->irqfd_partn;
> +	struct mshv_lapic_irq *irq =3D &irqfd->irqfd_lapic_irq;
> +	struct mshv_vp *vp;
> +
> +	if (!(ms_hyperv.ext_features &
> +	      HV_VP_DISPATCH_INTERRUPT_INJECTION_AVAILABLE))
> +		return -EOPNOTSUPP;
> +
> +	if (hv_scheduler_type !=3D HV_SCHEDULER_TYPE_ROOT)
> +		return -EOPNOTSUPP;
> +
> +	if (irq->lapic_control.logical_dest_mode)
> +		return -EOPNOTSUPP;
> +
> +	vp =3D partition->pt_vp_array[irq->lapic_apic_id];
> +
> +	if (!vp->vp_register_page)
> +		return -EOPNOTSUPP;
> +
> +	if (mshv_vp_irq_set_vector(vp, irq->lapic_vector))
> +		return -EINVAL;
> +
> +	if (vp->run.flags.root_sched_dispatched &&
> +	    vp->vp_register_page->interrupt_vectors.as_uint64)
> +		return -EBUSY;
> +
> +	wake_up(&vp->run.vp_suspend_queue);
> +
> +	return 0;
> +}
> +#else /* CONFIG_X86_64 */
> +static int mshv_try_assert_irq_fast(struct mshv_irqfd *irqfd)
> +{
> +	return -EOPNOTSUPP;
> +}
> +#endif
> +
> +static void mshv_assert_irq_slow(struct mshv_irqfd *irqfd)
> +{
> +	struct mshv_partition *partition =3D irqfd->irqfd_partn;
> +	struct mshv_lapic_irq *irq =3D &irqfd->irqfd_lapic_irq;
> +	unsigned int seq;
> +	int idx;
> +
> +	WARN_ON(irqfd->irqfd_resampler &&
> +		!irq->lapic_control.level_triggered);
> +
> +	idx =3D srcu_read_lock(&partition->pt_irq_srcu);
> +	if (irqfd->irqfd_girq_ent.guest_irq_num) {
> +		if (!irqfd->irqfd_girq_ent.girq_entry_valid) {
> +			srcu_read_unlock(&partition->pt_irq_srcu, idx);
> +			return;
> +		}
> +
> +		do {
> +			seq =3D read_seqcount_begin(&irqfd->irqfd_irqe_sc);
> +		} while (read_seqcount_retry(&irqfd->irqfd_irqe_sc, seq));
> +	}
> +
> +	hv_call_assert_virtual_interrupt(irqfd->irqfd_partn->pt_id,
> +					 irq->lapic_vector, irq->lapic_apic_id,
> +					 irq->lapic_control);
> +	srcu_read_unlock(&partition->pt_irq_srcu, idx);
> +}
> +
> +static void mshv_irqfd_resampler_shutdown(struct mshv_irqfd *irqfd)
> +{
> +	struct mshv_irqfd_resampler *rp =3D irqfd->irqfd_resampler;
> +	struct mshv_partition *pt =3D rp->rsmplr_partn;
> +
> +	mutex_lock(&pt->irqfds_resampler_lock);
> +
> +	hlist_del_rcu(&irqfd->irqfd_resampler_hnode);
> +	synchronize_srcu(&pt->pt_irq_srcu);
> +
> +	if (hlist_empty(&rp->rsmplr_irqfd_list)) {
> +		hlist_del(&rp->rsmplr_hnode);
> +		mshv_unregister_irq_ack_notifier(pt, &rp->rsmplr_notifier);
> +		kfree(rp);
> +	}
> +
> +	mutex_unlock(&pt->irqfds_resampler_lock);
> +}
> +
> +/*
> + * Race-free decouple logic (ordering is critical)
> + */
> +static void mshv_irqfd_shutdown(struct work_struct *work)
> +{
> +	struct mshv_irqfd *irqfd =3D
> +			container_of(work, struct mshv_irqfd, irqfd_shutdown);
> +
> +	/*
> +	 * Synchronize with the wait-queue and unhook ourselves to prevent
> +	 * further events.
> +	 */
> +	remove_wait_queue(irqfd->irqfd_wqh, &irqfd->irqfd_wait);
> +
> +	if (irqfd->irqfd_resampler) {
> +		mshv_irqfd_resampler_shutdown(irqfd);
> +		eventfd_ctx_put(irqfd->irqfd_resamplefd);
> +	}
> +
> +	/*
> +	 * It is now safe to release the object's resources
> +	 */
> +	eventfd_ctx_put(irqfd->irqfd_eventfd_ctx);
> +	kfree(irqfd);
> +}
> +
> +/* assumes partition->pt_irqfds_lock is held */
> +static bool mshv_irqfd_is_active(struct mshv_irqfd *irqfd)
> +{
> +	return !hlist_unhashed(&irqfd->irqfd_hnode);
> +}
> +
> +/*
> + * Mark the irqfd as inactive and schedule it for removal
> + *
> + * assumes partition->pt_irqfds_lock is held
> + */
> +static void mshv_irqfd_deactivate(struct mshv_irqfd *irqfd)
> +{
> +	if (!mshv_irqfd_is_active(irqfd))
> +		return;
> +
> +	hlist_del(&irqfd->irqfd_hnode);
> +
> +	queue_work(irqfd_cleanup_wq, &irqfd->irqfd_shutdown);
> +}
> +
> +/*
> + * Called with wqh->lock held and interrupts disabled
> + */
> +static int mshv_irqfd_wakeup(wait_queue_entry_t *wait, unsigned int mode=
,
> +			     int sync, void *key)
> +{
> +	struct mshv_irqfd *irqfd =3D container_of(wait, struct mshv_irqfd,
> +						irqfd_wait);
> +	unsigned long flags =3D (unsigned long)key;
> +	int idx;
> +	unsigned int seq;
> +	struct mshv_partition *pt =3D irqfd->irqfd_partn;
> +	int ret =3D 0;
> +
> +	if (flags & POLLIN) {
> +		u64 cnt;
> +
> +		eventfd_ctx_do_read(irqfd->irqfd_eventfd_ctx, &cnt);
> +		idx =3D srcu_read_lock(&pt->pt_irq_srcu);
> +		do {
> +			seq =3D read_seqcount_begin(&irqfd->irqfd_irqe_sc);
> +		} while (read_seqcount_retry(&irqfd->irqfd_irqe_sc, seq));
> +
> +		/* An event has been signaled, raise an interrupt */
> +		ret =3D mshv_try_assert_irq_fast(irqfd);
> +		if (ret)
> +			mshv_assert_irq_slow(irqfd);
> +
> +		srcu_read_unlock(&pt->pt_irq_srcu, idx);
> +
> +		ret =3D 1;
> +	}
> +
> +	if (flags & POLLHUP) {
> +		/* The eventfd is closing, detach from the partition */
> +		unsigned long flags;
> +
> +		spin_lock_irqsave(&pt->pt_irqfds_lock, flags);
> +
> +		/*
> +		 * We must check if someone deactivated the irqfd before
> +		 * we could acquire the pt_irqfds_lock since the item is
> +		 * deactivated from the mshv side before it is unhooked from
> +		 * the wait-queue.  If it is already deactivated, we can
> +		 * simply return knowing the other side will cleanup for us.
> +		 * We cannot race against the irqfd going away since the
> +		 * other side is required to acquire wqh->lock, which we hold
> +		 */
> +		if (mshv_irqfd_is_active(irqfd))
> +			mshv_irqfd_deactivate(irqfd);
> +
> +		spin_unlock_irqrestore(&pt->pt_irqfds_lock, flags);
> +	}
> +
> +	return ret;
> +}
> +
> +/* Must be called under pt_irqfds_lock */
> +static void mshv_irqfd_update(struct mshv_partition *pt,
> +			      struct mshv_irqfd *irqfd)
> +{
> +	write_seqcount_begin(&irqfd->irqfd_irqe_sc);
> +	irqfd->irqfd_girq_ent =3D mshv_ret_girq_entry(pt,
> +						    irqfd->irqfd_irqnum);
> +	mshv_copy_girq_info(&irqfd->irqfd_girq_ent, &irqfd->irqfd_lapic_irq);
> +	write_seqcount_end(&irqfd->irqfd_irqe_sc);
> +}
> +
> +void mshv_irqfd_routing_update(struct mshv_partition *pt)
> +{
> +	struct mshv_irqfd *irqfd;
> +
> +	spin_lock_irq(&pt->pt_irqfds_lock);
> +	hlist_for_each_entry(irqfd, &pt->pt_irqfds_list, irqfd_hnode)
> +		mshv_irqfd_update(pt, irqfd);
> +	spin_unlock_irq(&pt->pt_irqfds_lock);
> +}
> +
> +static void mshv_irqfd_queue_proc(struct file *file, wait_queue_head_t *=
wqh,
> +				  poll_table *polltbl)
> +{
> +	struct mshv_irqfd *irqfd =3D
> +			container_of(polltbl, struct mshv_irqfd, irqfd_polltbl);
> +
> +	irqfd->irqfd_wqh =3D wqh;
> +	add_wait_queue_priority(wqh, &irqfd->irqfd_wait);
> +}
> +
> +static int mshv_irqfd_assign(struct mshv_partition *pt,
> +			     struct mshv_user_irqfd *args)
> +{
> +	struct eventfd_ctx *eventfd =3D NULL, *resamplefd =3D NULL;
> +	struct mshv_irqfd *irqfd, *tmp;
> +	unsigned int events;
> +	struct fd f;
> +	int ret;
> +	int idx;
> +
> +	irqfd =3D kzalloc(sizeof(*irqfd), GFP_KERNEL);
> +	if (!irqfd)
> +		return -ENOMEM;
> +
> +	irqfd->irqfd_partn =3D pt;
> +	irqfd->irqfd_irqnum =3D args->gsi;
> +	INIT_WORK(&irqfd->irqfd_shutdown, mshv_irqfd_shutdown);
> +	seqcount_spinlock_init(&irqfd->irqfd_irqe_sc, &pt->pt_irqfds_lock);
> +
> +	f =3D fdget(args->fd);
> +	if (!fd_file(f)) {
> +		ret =3D -EBADF;
> +		goto out;
> +	}
> +
> +	eventfd =3D eventfd_ctx_fileget(fd_file(f));
> +	if (IS_ERR(eventfd)) {
> +		ret =3D PTR_ERR(eventfd);
> +		goto fail;
> +	}
> +
> +	irqfd->irqfd_eventfd_ctx =3D eventfd;
> +
> +	if (args->flags & BIT(MSHV_IRQFD_BIT_RESAMPLE)) {
> +		struct mshv_irqfd_resampler *rp;
> +
> +		resamplefd =3D eventfd_ctx_fdget(args->resamplefd);
> +		if (IS_ERR(resamplefd)) {
> +			ret =3D PTR_ERR(resamplefd);
> +			goto fail;
> +		}
> +
> +		irqfd->irqfd_resamplefd =3D resamplefd;
> +
> +		mutex_lock(&pt->irqfds_resampler_lock);
> +
> +		hlist_for_each_entry(rp, &pt->irqfds_resampler_list,
> +				     rsmplr_hnode) {
> +			if (rp->rsmplr_notifier.irq_ack_gsi =3D=3D
> +							 irqfd->irqfd_irqnum) {
> +				irqfd->irqfd_resampler =3D rp;
> +				break;
> +			}
> +		}
> +
> +		if (!irqfd->irqfd_resampler) {
> +			rp =3D kzalloc(sizeof(*rp), GFP_KERNEL_ACCOUNT);
> +			if (!rp) {
> +				ret =3D -ENOMEM;
> +				mutex_unlock(&pt->irqfds_resampler_lock);
> +				goto fail;
> +			}
> +
> +			rp->rsmplr_partn =3D pt;
> +			INIT_HLIST_HEAD(&rp->rsmplr_irqfd_list);
> +			rp->rsmplr_notifier.irq_ack_gsi =3D irqfd->irqfd_irqnum;
> +			rp->rsmplr_notifier.irq_acked =3D
> +						      mshv_irqfd_resampler_ack;
> +
> +			hlist_add_head(&rp->rsmplr_hnode,
> +				       &pt->irqfds_resampler_list);
> +			mshv_register_irq_ack_notifier(pt,
> +						       &rp->rsmplr_notifier);
> +			irqfd->irqfd_resampler =3D rp;
> +		}
> +
> +		hlist_add_head_rcu(&irqfd->irqfd_resampler_hnode,
> +				   &irqfd->irqfd_resampler->rsmplr_irqfd_list);
> +
> +		mutex_unlock(&pt->irqfds_resampler_lock);
> +	}
> +
> +	/*
> +	 * Install our own custom wake-up handling so we are notified via
> +	 * a callback whenever someone signals the underlying eventfd
> +	 */
> +	init_waitqueue_func_entry(&irqfd->irqfd_wait, mshv_irqfd_wakeup);
> +	init_poll_funcptr(&irqfd->irqfd_polltbl, mshv_irqfd_queue_proc);
> +
> +	spin_lock_irq(&pt->pt_irqfds_lock);
> +	if (args->flags & BIT(MSHV_IRQFD_BIT_RESAMPLE) &&
> +	    !irqfd->irqfd_lapic_irq.lapic_control.level_triggered) {
> +		/*
> +		 * Resample Fd must be for level triggered interrupt
> +		 * Otherwise return with failure
> +		 */
> +		spin_unlock_irq(&pt->pt_irqfds_lock);
> +		ret =3D -EINVAL;
> +		goto fail;
> +	}
> +	ret =3D 0;
> +	hlist_for_each_entry(tmp, &pt->pt_irqfds_list, irqfd_hnode) {
> +		if (irqfd->irqfd_eventfd_ctx !=3D tmp->irqfd_eventfd_ctx)
> +			continue;
> +		/* This fd is used for another irq already. */
> +		ret =3D -EBUSY;
> +		spin_unlock_irq(&pt->pt_irqfds_lock);
> +		goto fail;
> +	}
> +
> +	idx =3D srcu_read_lock(&pt->pt_irq_srcu);
> +	mshv_irqfd_update(pt, irqfd);
> +	hlist_add_head(&irqfd->irqfd_hnode, &pt->pt_irqfds_list);
> +	spin_unlock_irq(&pt->pt_irqfds_lock);
> +
> +	/*
> +	 * Check if there was an event already pending on the eventfd
> +	 * before we registered, and trigger it as if we didn't miss it.
> +	 */
> +	events =3D vfs_poll(fd_file(f), &irqfd->irqfd_polltbl);
> +
> +	if (events & POLLIN)
> +		mshv_assert_irq_slow(irqfd);
> +
> +	srcu_read_unlock(&pt->pt_irq_srcu, idx);
> +	/*
> +	 * do not drop the file until the irqfd is fully initialized, otherwise
> +	 * we might race against the POLLHUP
> +	 */
> +	fdput(f);
> +
> +	return 0;
> +
> +fail:
> +	if (irqfd->irqfd_resampler)
> +		mshv_irqfd_resampler_shutdown(irqfd);
> +
> +	if (resamplefd && !IS_ERR(resamplefd))
> +		eventfd_ctx_put(resamplefd);
> +
> +	if (eventfd && !IS_ERR(eventfd))
> +		eventfd_ctx_put(eventfd);
> +
> +	fdput(f);
> +
> +out:
> +	kfree(irqfd);
> +	return ret;
> +}
> +
> +/*
> + * shutdown any irqfd's that match fd+gsi
> + */
> +static int mshv_irqfd_deassign(struct mshv_partition *pt,
> +			       struct mshv_user_irqfd *args)
> +{
> +	struct mshv_irqfd *irqfd;
> +	struct hlist_node *n;
> +	struct eventfd_ctx *eventfd;
> +
> +	eventfd =3D eventfd_ctx_fdget(args->fd);
> +	if (IS_ERR(eventfd))
> +		return PTR_ERR(eventfd);
> +
> +	hlist_for_each_entry_safe(irqfd, n, &pt->pt_irqfds_list,
> +				  irqfd_hnode) {
> +		if (irqfd->irqfd_eventfd_ctx =3D=3D eventfd &&
> +		    irqfd->irqfd_irqnum =3D=3D args->gsi)
> +
> +			mshv_irqfd_deactivate(irqfd);
> +	}
> +
> +	eventfd_ctx_put(eventfd);
> +
> +	/*
> +	 * Block until we know all outstanding shutdown jobs have completed
> +	 * so that we guarantee there will not be any more interrupts on this
> +	 * gsi once this deassign function returns.
> +	 */
> +	flush_workqueue(irqfd_cleanup_wq);
> +
> +	return 0;
> +}
> +
> +int mshv_set_unset_irqfd(struct mshv_partition *pt,
> +			 struct mshv_user_irqfd *args)
> +{
> +	if (args->flags & ~MSHV_IRQFD_FLAGS_MASK)
> +		return -EINVAL;
> +
> +	if (args->flags & BIT(MSHV_IRQFD_BIT_DEASSIGN))
> +		return mshv_irqfd_deassign(pt, args);
> +
> +	return mshv_irqfd_assign(pt, args);
> +}
> +
> +/*
> + * This function is called as the mshv VM fd is being released.
> + * Shutdown all irqfds that still remain open
> + */
> +static void mshv_irqfd_release(struct mshv_partition *pt)
> +{
> +	struct mshv_irqfd *irqfd;
> +	struct hlist_node *n;
> +
> +	spin_lock_irq(&pt->pt_irqfds_lock);
> +
> +	hlist_for_each_entry_safe(irqfd, n, &pt->pt_irqfds_list, irqfd_hnode)
> +		mshv_irqfd_deactivate(irqfd);
> +
> +	spin_unlock_irq(&pt->pt_irqfds_lock);
> +
> +	/*
> +	 * Block until we know all outstanding shutdown jobs have completed
> +	 * since we do not take a mshv_partition* reference.
> +	 */
> +	flush_workqueue(irqfd_cleanup_wq);
> +}
> +
> +int mshv_irqfd_wq_init(void)
> +{
> +	irqfd_cleanup_wq =3D alloc_workqueue("mshv-irqfd-cleanup", 0, 0);
> +	if (!irqfd_cleanup_wq)
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
> +void mshv_irqfd_wq_cleanup(void)
> +{
> +	destroy_workqueue(irqfd_cleanup_wq);
> +}
> +
> +/*
> + * --------------------------------------------------------------------
> + * ioeventfd: translate a MMIO memory write to an eventfd signal.
> + *
> + * userspace can register a MMIO address with an eventfd for receiving
> + * notification when the memory has been touched.
> + * --------------------------------------------------------------------
> + */
> +
> +static void ioeventfd_release(struct mshv_ioeventfd *p, u64 partition_id=
)
> +{
> +	if (p->iovntfd_doorbell_id > 0)
> +		mshv_unregister_doorbell(partition_id, p->iovntfd_doorbell_id);
> +	eventfd_ctx_put(p->iovntfd_eventfd);
> +	kfree(p);
> +}
> +
> +/* MMIO writes trigger an event if the addr/val match */
> +static void ioeventfd_mmio_write(int doorbell_id, void *data)
> +{
> +	struct mshv_partition *partition =3D (struct mshv_partition *)data;
> +	struct mshv_ioeventfd *p;
> +
> +	rcu_read_lock();
> +	hlist_for_each_entry_rcu(p, &partition->ioeventfds_list, iovntfd_hnode)
> +		if (p->iovntfd_doorbell_id =3D=3D doorbell_id) {
> +			eventfd_signal(p->iovntfd_eventfd);
> +			break;
> +		}
> +
> +	rcu_read_unlock();
> +}
> +
> +static bool ioeventfd_check_collision(struct mshv_partition *pt,
> +				      struct mshv_ioeventfd *p)
> +	__must_hold(&pt->mutex)
> +{
> +	struct mshv_ioeventfd *_p;
> +
> +	hlist_for_each_entry(_p, &pt->ioeventfds_list, iovntfd_hnode)
> +		if (_p->iovntfd_addr =3D=3D p->iovntfd_addr &&
> +		    _p->iovntfd_length =3D=3D p->iovntfd_length &&
> +		    (_p->iovntfd_wildcard || p->iovntfd_wildcard ||
> +		     _p->iovntfd_datamatch =3D=3D p->iovntfd_datamatch))
> +			return true;
> +
> +	return false;
> +}
> +
> +static int mshv_assign_ioeventfd(struct mshv_partition *pt,
> +				 struct mshv_user_ioeventfd *args)
> +	__must_hold(&pt->mutex)
> +{
> +	struct mshv_ioeventfd *p;
> +	struct eventfd_ctx *eventfd;
> +	u64 doorbell_flags =3D 0;
> +	int ret;
> +
> +	/* This mutex is currently protecting ioeventfd.items list */
> +	WARN_ON_ONCE(!mutex_is_locked(&pt->pt_mutex));
> +
> +	if (args->flags & BIT(MSHV_IOEVENTFD_BIT_PIO))
> +		return -EOPNOTSUPP;
> +
> +	/* must be natural-word sized */
> +	switch (args->len) {
> +	case 0:
> +		doorbell_flags =3D HV_DOORBELL_FLAG_TRIGGER_SIZE_ANY;
> +		break;
> +	case 1:
> +		doorbell_flags =3D HV_DOORBELL_FLAG_TRIGGER_SIZE_BYTE;
> +		break;
> +	case 2:
> +		doorbell_flags =3D HV_DOORBELL_FLAG_TRIGGER_SIZE_WORD;
> +		break;
> +	case 4:
> +		doorbell_flags =3D HV_DOORBELL_FLAG_TRIGGER_SIZE_DWORD;
> +		break;
> +	case 8:
> +		doorbell_flags =3D HV_DOORBELL_FLAG_TRIGGER_SIZE_QWORD;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	/* check for range overflow */
> +	if (args->addr + args->len < args->addr)
> +		return -EINVAL;
> +
> +	/* check for extra flags that we don't understand */
> +	if (args->flags & ~MSHV_IOEVENTFD_FLAGS_MASK)
> +		return -EINVAL;
> +
> +	eventfd =3D eventfd_ctx_fdget(args->fd);
> +	if (IS_ERR(eventfd))
> +		return PTR_ERR(eventfd);
> +
> +	p =3D kzalloc(sizeof(*p), GFP_KERNEL);
> +	if (!p) {
> +		ret =3D -ENOMEM;
> +		goto fail;
> +	}
> +
> +	p->iovntfd_addr =3D args->addr;
> +	p->iovntfd_length  =3D args->len;
> +	p->iovntfd_eventfd =3D eventfd;
> +
> +	/* The datamatch feature is optional, otherwise this is a wildcard */
> +	if (args->flags & BIT(MSHV_IOEVENTFD_BIT_DATAMATCH)) {
> +		p->iovntfd_datamatch =3D args->datamatch;
> +	} else {
> +		p->iovntfd_wildcard =3D true;
> +		doorbell_flags |=3D HV_DOORBELL_FLAG_TRIGGER_ANY_VALUE;
> +	}
> +
> +	if (ioeventfd_check_collision(pt, p)) {
> +		ret =3D -EEXIST;
> +		goto unlock_fail;
> +	}
> +
> +	ret =3D mshv_register_doorbell(pt->pt_id, ioeventfd_mmio_write,
> +				     (void *)pt, p->iovntfd_addr,
> +				     p->iovntfd_datamatch, doorbell_flags);
> +	if (ret < 0)
> +		goto unlock_fail;
> +
> +	p->iovntfd_doorbell_id =3D ret;
> +
> +	hlist_add_head_rcu(&p->iovntfd_hnode, &pt->ioeventfds_list);
> +
> +	return 0;
> +
> +unlock_fail:
> +	kfree(p);
> +
> +fail:
> +	eventfd_ctx_put(eventfd);
> +
> +	return ret;
> +}
> +
> +static int mshv_deassign_ioeventfd(struct mshv_partition *pt,
> +				   struct mshv_user_ioeventfd *args)
> +	__must_hold(&pt->mutex)
> +{
> +	struct mshv_ioeventfd *p;
> +	struct eventfd_ctx *eventfd;
> +	struct hlist_node *n;
> +	int ret =3D -ENOENT;
> +
> +	/* This mutex is currently protecting ioeventfd.items list */
> +	WARN_ON_ONCE(!mutex_is_locked(&pt->pt_mutex));
> +
> +	eventfd =3D eventfd_ctx_fdget(args->fd);
> +	if (IS_ERR(eventfd))
> +		return PTR_ERR(eventfd);
> +
> +	hlist_for_each_entry_safe(p, n, &pt->ioeventfds_list, iovntfd_hnode) {
> +		bool wildcard =3D !(args->flags & BIT(MSHV_IOEVENTFD_BIT_DATAMATCH));
> +
> +		if (p->iovntfd_eventfd !=3D eventfd  ||
> +		    p->iovntfd_addr !=3D args->addr  ||
> +		    p->iovntfd_length !=3D args->len ||
> +		    p->iovntfd_wildcard !=3D wildcard)
> +			continue;
> +
> +		if (!p->iovntfd_wildcard &&
> +		    p->iovntfd_datamatch !=3D args->datamatch)
> +			continue;
> +
> +		hlist_del_rcu(&p->iovntfd_hnode);
> +		synchronize_rcu();
> +		ioeventfd_release(p, pt->pt_id);
> +		ret =3D 0;
> +		break;
> +	}
> +
> +	eventfd_ctx_put(eventfd);
> +
> +	return ret;
> +}
> +
> +int mshv_set_unset_ioeventfd(struct mshv_partition *pt,
> +			     struct mshv_user_ioeventfd *args)
> +	__must_hold(&pt->mutex)
> +{
> +	if ((args->flags & ~MSHV_IOEVENTFD_FLAGS_MASK) ||
> +	    mshv_field_nonzero(*args, rsvd))
> +		return -EINVAL;
> +
> +	/* PIO not yet implemented */
> +	if (args->flags & BIT(MSHV_IOEVENTFD_BIT_PIO))
> +		return -EOPNOTSUPP;
> +
> +	if (args->flags & BIT(MSHV_IOEVENTFD_BIT_DEASSIGN))
> +		return mshv_deassign_ioeventfd(pt, args);
> +
> +	return mshv_assign_ioeventfd(pt, args);
> +}
> +
> +void mshv_eventfd_init(struct mshv_partition *pt)
> +{
> +	spin_lock_init(&pt->pt_irqfds_lock);
> +	INIT_HLIST_HEAD(&pt->pt_irqfds_list);
> +
> +	INIT_HLIST_HEAD(&pt->irqfds_resampler_list);
> +	mutex_init(&pt->irqfds_resampler_lock);
> +
> +	INIT_HLIST_HEAD(&pt->ioeventfds_list);
> +}
> +
> +void mshv_eventfd_release(struct mshv_partition *pt)
> +{
> +	struct hlist_head items;
> +	struct hlist_node *n;
> +	struct mshv_ioeventfd *p;
> +
> +	hlist_move_list(&pt->ioeventfds_list, &items);
> +	synchronize_rcu();
> +
> +	hlist_for_each_entry_safe(p, n, &items, iovntfd_hnode) {
> +		hlist_del(&p->iovntfd_hnode);
> +		ioeventfd_release(p, pt->pt_id);
> +	}
> +
> +	mshv_irqfd_release(pt);
> +}
> diff --git a/drivers/hv/mshv_eventfd.h b/drivers/hv/mshv_eventfd.h
> new file mode 100644
> index 000000000000..332e7670a344
> --- /dev/null
> +++ b/drivers/hv/mshv_eventfd.h
> @@ -0,0 +1,71 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * irqfd: Allows an fd to be used to inject an interrupt to the guest.
> + * ioeventfd: Allow an fd to be used to receive a signal from the guest.
> + * All credit goes to kvm developers.
> + */
> +
> +#ifndef __LINUX_MSHV_EVENTFD_H
> +#define __LINUX_MSHV_EVENTFD_H
> +
> +#include <linux/poll.h>
> +
> +#include "mshv.h"
> +#include "mshv_root.h"
> +
> +/* struct to contain list of irqfds sharing an irq. Updates are protecte=
d by
> + * partition.irqfds.resampler_lock
> + */
> +struct mshv_irqfd_resampler {
> +	struct mshv_partition	    *rsmplr_partn;
> +	struct hlist_head	     rsmplr_irqfd_list;
> +	struct mshv_irq_ack_notifier rsmplr_notifier;
> +	struct hlist_node	     rsmplr_hnode;
> +};
> +
> +struct mshv_irqfd {
> +	struct mshv_partition		    *irqfd_partn;
> +	struct eventfd_ctx		    *irqfd_eventfd_ctx;
> +	struct mshv_guest_irq_ent	     irqfd_girq_ent;
> +	seqcount_spinlock_t		     irqfd_irqe_sc;
> +	u32				     irqfd_irqnum;
> +	struct mshv_lapic_irq		     irqfd_lapic_irq;
> +	struct hlist_node		     irqfd_hnode;
> +	poll_table			     irqfd_polltbl;
> +	wait_queue_head_t		    *irqfd_wqh;
> +	wait_queue_entry_t		     irqfd_wait;
> +	struct work_struct		     irqfd_shutdown;
> +	struct mshv_irqfd_resampler	    *irqfd_resampler;
> +	struct eventfd_ctx		    *irqfd_resamplefd;
> +	struct hlist_node		     irqfd_resampler_hnode;
> +};
> +
> +void mshv_eventfd_init(struct mshv_partition *partition);
> +void mshv_eventfd_release(struct mshv_partition *partition);
> +
> +void mshv_register_irq_ack_notifier(struct mshv_partition *partition,
> +				    struct mshv_irq_ack_notifier *mian);
> +void mshv_unregister_irq_ack_notifier(struct mshv_partition *partition,
> +				      struct mshv_irq_ack_notifier *mian);
> +bool mshv_notify_acked_gsi(struct mshv_partition *partition, int gsi);
> +
> +int mshv_set_unset_irqfd(struct mshv_partition *partition,
> +			 struct mshv_user_irqfd *args);
> +
> +int mshv_irqfd_wq_init(void);
> +void mshv_irqfd_wq_cleanup(void);
> +
> +struct mshv_ioeventfd {
> +	struct hlist_node    iovntfd_hnode;
> +	u64		     iovntfd_addr;
> +	int		     iovntfd_length;
> +	struct eventfd_ctx  *iovntfd_eventfd;
> +	u64		     iovntfd_datamatch;
> +	int		     iovntfd_doorbell_id;
> +	bool		     iovntfd_wildcard;
> +};
> +
> +int mshv_set_unset_ioeventfd(struct mshv_partition *pt,
> +			     struct mshv_user_ioeventfd *args);
> +
> +#endif /* __LINUX_MSHV_EVENTFD_H */
> diff --git a/drivers/hv/mshv_irq.c b/drivers/hv/mshv_irq.c
> new file mode 100644
> index 000000000000..f956e125afb4
> --- /dev/null
> +++ b/drivers/hv/mshv_irq.c
> @@ -0,0 +1,128 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2023, Microsoft Corporation.
> + *
> + * Authors:
> + *   Vineeth Remanan Pillai <viremana@linux.microsoft.com>
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <asm/mshyperv.h>
> +
> +#include "mshv_eventfd.h"
> +#include "mshv.h"
> +#include "mshv_root.h"
> +
> +MODULE_AUTHOR("Microsoft");
> +MODULE_LICENSE("GPL");
> +
> +/* called from the ioctl code, user wants to update the guest irq table =
*/
> +int mshv_update_routing_table(struct mshv_partition *partition,
> +			      const struct mshv_user_irq_entry *ue,
> +			      unsigned int numents)
> +{
> +	struct mshv_girq_routing_table *new =3D NULL, *old;
> +	u32 i, nr_rt_entries =3D 0;
> +	int r =3D 0;
> +
> +	if (numents =3D=3D 0)
> +		goto swap_routes;
> +
> +	for (i =3D 0; i < numents; i++) {
> +		if (ue[i].gsi >=3D MSHV_MAX_GUEST_IRQS)
> +			return -EINVAL;
> +
> +		if (ue[i].address_hi)
> +			return -EINVAL;
> +
> +		nr_rt_entries =3D max(nr_rt_entries, ue[i].gsi);
> +	}
> +	nr_rt_entries +=3D 1;
> +
> +	new =3D kzalloc(struct_size(new, mshv_girq_info_tbl, nr_rt_entries),
> +		      GFP_KERNEL_ACCOUNT);
> +	if (!new)
> +		return -ENOMEM;
> +
> +	new->num_rt_entries =3D nr_rt_entries;
> +	for (i =3D 0; i < numents; i++) {
> +		struct mshv_guest_irq_ent *girq;
> +
> +		girq =3D &new->mshv_girq_info_tbl[ue[i].gsi];
> +
> +		/*
> +		 * Allow only one to one mapping between GSI and MSI routing.
> +		 */
> +		if (girq->guest_irq_num !=3D 0) {
> +			r =3D -EINVAL;
> +			goto out;
> +		}
> +
> +		girq->guest_irq_num =3D ue[i].gsi;
> +		girq->girq_addr_lo =3D ue[i].address_lo;
> +		girq->girq_addr_hi =3D ue[i].address_hi;
> +		girq->girq_irq_data =3D ue[i].data;
> +		girq->girq_entry_valid =3D true;
> +	}
> +
> +swap_routes:
> +	mutex_lock(&partition->pt_irq_lock);
> +	old =3D rcu_dereference_protected(partition->pt_girq_tbl, 1);
> +	rcu_assign_pointer(partition->pt_girq_tbl, new);
> +	mshv_irqfd_routing_update(partition);
> +	mutex_unlock(&partition->pt_irq_lock);
> +
> +	synchronize_srcu_expedited(&partition->pt_irq_srcu);
> +	new =3D old;
> +
> +out:
> +	kfree(new);
> +
> +	return r;
> +}
> +
> +/* vm is going away, kfree the irq routing table */
> +void mshv_free_routing_table(struct mshv_partition *partition)
> +{
> +	struct mshv_girq_routing_table *rt =3D
> +				   rcu_access_pointer(partition->pt_girq_tbl);
> +
> +	kfree(rt);
> +}
> +
> +struct mshv_guest_irq_ent
> +mshv_ret_girq_entry(struct mshv_partition *partition, u32 irqnum)
> +{
> +	struct mshv_guest_irq_ent entry =3D { 0 };
> +	struct mshv_girq_routing_table *girq_tbl;
> +
> +	girq_tbl =3D srcu_dereference_check(partition->pt_girq_tbl,
> +					  &partition->pt_irq_srcu,
> +					  lockdep_is_held(&partition->pt_irq_lock));
> +	if (!girq_tbl || irqnum >=3D girq_tbl->num_rt_entries) {
> +		/*
> +		 * Premature register_irqfd, setting valid_entry =3D 0
> +		 * would ignore this entry anyway
> +		 */
> +		entry.guest_irq_num =3D irqnum;
> +		return entry;
> +	}
> +
> +	return girq_tbl->mshv_girq_info_tbl[irqnum];
> +}
> +
> +void mshv_copy_girq_info(struct mshv_guest_irq_ent *ent,
> +			 struct mshv_lapic_irq *lirq)
> +{
> +	memset(lirq, 0, sizeof(*lirq));
> +	if (!ent || !ent->girq_entry_valid)
> +		return;
> +
> +	lirq->lapic_vector =3D ent->girq_irq_data & 0xFF;
> +	lirq->lapic_apic_id =3D (ent->girq_addr_lo >> 12) & 0xFF;
> +	lirq->lapic_control.interrupt_type =3D (ent->girq_irq_data & 0x700) >> =
8;
> +	lirq->lapic_control.level_triggered =3D (ent->girq_irq_data >> 15) & 0x=
1;
> +	lirq->lapic_control.logical_dest_mode =3D (ent->girq_addr_lo >> 2) & 0x=
1;
> +}
> diff --git a/drivers/hv/mshv_portid_table.c b/drivers/hv/mshv_portid_tabl=
e.c
> new file mode 100644
> index 000000000000..a40abde6fd15
> --- /dev/null
> +++ b/drivers/hv/mshv_portid_table.c
> @@ -0,0 +1,84 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/types.h>
> +#include <linux/version.h>
> +#include <linux/mm.h>
> +#include <linux/slab.h>
> +#include <linux/idr.h>
> +#include <asm/mshyperv.h>
> +
> +#include "mshv.h"
> +#include "mshv_root.h"
> +
> +/*
> + * Ports and connections are hypervisor struct used for inter-partition
> + * communication. Port represents the source and connection represents
> + * the destination. Partitions are responsible for managing the port and
> + * connection ids.
> + *
> + */
> +
> +#define PORTID_MIN	1
> +#define PORTID_MAX	INT_MAX
> +
> +static DEFINE_IDR(port_table_idr);
> +
> +void
> +mshv_port_table_fini(void)
> +{
> +	struct port_table_info *port_info;
> +	unsigned long i, tmp;
> +
> +	idr_lock(&port_table_idr);
> +	if (!idr_is_empty(&port_table_idr)) {
> +		idr_for_each_entry_ul(&port_table_idr, port_info, tmp, i) {
> +			port_info =3D idr_remove(&port_table_idr, i);
> +			kfree_rcu(port_info, portbl_rcu);
> +		}
> +	}
> +	idr_unlock(&port_table_idr);
> +}
> +
> +int
> +mshv_portid_alloc(struct port_table_info *info)
> +{
> +	int ret =3D 0;
> +
> +	idr_lock(&port_table_idr);
> +	ret =3D idr_alloc(&port_table_idr, info, PORTID_MIN,
> +			PORTID_MAX, GFP_KERNEL);
> +	idr_unlock(&port_table_idr);
> +
> +	return ret;
> +}
> +
> +void
> +mshv_portid_free(int port_id)
> +{
> +	struct port_table_info *info;
> +
> +	idr_lock(&port_table_idr);
> +	info =3D idr_remove(&port_table_idr, port_id);
> +	WARN_ON(!info);
> +	idr_unlock(&port_table_idr);
> +
> +	synchronize_rcu();
> +	kfree(info);
> +}
> +
> +int
> +mshv_portid_lookup(int port_id, struct port_table_info *info)
> +{
> +	struct port_table_info *_info;
> +	int ret =3D -ENOENT;
> +
> +	rcu_read_lock();
> +	_info =3D idr_find(&port_table_idr, port_id);
> +	rcu_read_unlock();
> +
> +	if (_info) {
> +		*info =3D *_info;
> +		ret =3D 0;
> +	}
> +
> +	return ret;
> +}
> diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
> new file mode 100644
> index 000000000000..f8d85db14db1
> --- /dev/null
> +++ b/drivers/hv/mshv_root.h
> @@ -0,0 +1,321 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2023, Microsoft Corporation.
> + */
> +
> +#ifndef _MSHV_ROOT_H_
> +#define _MSHV_ROOT_H_
> +
> +#include <linux/spinlock.h>
> +#include <linux/mutex.h>
> +#include <linux/semaphore.h>
> +#include <linux/sched.h>
> +#include <linux/srcu.h>
> +#include <linux/wait.h>
> +#include <linux/hashtable.h>
> +#include <linux/dev_printk.h>
> +#include <uapi/linux/mshv.h>
> +
> +/*
> + * Hypervisor must be between these version numbers (inclusive)
> + * to guarantee compatibility
> + */
> +#define MSHV_HV_MIN_VERSION		(27744)
> +#define MSHV_HV_MAX_VERSION		(27751)
> +
> +#define MSHV_MAX_VPS			256
> +
> +#define MSHV_PARTITIONS_HASH_BITS	9
> +
> +#define MSHV_PIN_PAGES_BATCH_SIZE	(0x10000000ULL / HV_HYP_PAGE_SIZE)
> +
> +struct mshv_vp {
> +	u32 vp_index;
> +	struct mshv_partition *vp_partition;
> +	struct mutex vp_mutex;
> +	struct hv_vp_register_page *vp_register_page;
> +	struct hv_message *vp_intercept_msg_page;
> +	void *vp_ghcb_page;
> +	struct hv_stats_page *vp_stats_pages[2];
> +	struct {
> +		atomic64_t vp_signaled_count;
> +		struct {
> +			u64 intercept_suspend: 1;
> +			u64 root_sched_blocked: 1; /* root scheduler only */
> +			u64 root_sched_dispatched: 1; /* root scheduler only */
> +			u64 reserved: 62;

Hmmm.  This looks like 65 bits allocated in a u64.

> +		} flags;
> +		unsigned int kicked_by_hv;
> +		wait_queue_head_t vp_suspend_queue;
> +	} run;
> +};
> +
> +#define vp_fmt(fmt) "p%lluvp%u: " fmt
> +#define vp_dev(v) ((v)->vp_partition->pt_module_dev)
> +#define vp_emerg(v, fmt, ...) \
> +	dev_emerg(vp_dev(v), vp_fmt(fmt), (v)->vp_partition->pt_id, \
> +		  (v)->vp_index, ##__VA_ARGS__)
> +#define vp_crit(v, fmt, ...) \
> +	dev_crit(vp_dev(v), vp_fmt(fmt), (v)->vp_partition->pt_id, \
> +		 (v)->vp_index, ##__VA_ARGS__)
> +#define vp_alert(v, fmt, ...) \
> +	dev_alert(vp_dev(v), vp_fmt(fmt), (v)->vp_partition->pt_id, \
> +		  (v)->vp_index, ##__VA_ARGS__)
> +#define vp_err(v, fmt, ...) \
> +	dev_err(vp_dev(v), vp_fmt(fmt), (v)->vp_partition->pt_id, \
> +		(v)->vp_index, ##__VA_ARGS__)
> +#define vp_warn(v, fmt, ...) \
> +	dev_warn(vp_dev(v), vp_fmt(fmt), (v)->vp_partition->pt_id, \
> +		 (v)->vp_index, ##__VA_ARGS__)
> +#define vp_notice(v, fmt, ...) \
> +	dev_notice(vp_dev(v), vp_fmt(fmt), (v)->vp_partition->pt_id, \
> +		   (v)->vp_index, ##__VA_ARGS__)
> +#define vp_info(v, fmt, ...) \
> +	dev_info(vp_dev(v), vp_fmt(fmt), (v)->vp_partition->pt_id, \
> +		 (v)->vp_index, ##__VA_ARGS__)
> +#define vp_dbg(v, fmt, ...) \
> +	dev_dbg(vp_dev(v), vp_fmt(fmt), (v)->vp_partition->pt_id, \
> +		(v)->vp_index, ##__VA_ARGS__)
> +
> +struct mshv_mem_region {
> +	struct hlist_node hnode;
> +	u64 nr_pages;
> +	u64 start_gfn;
> +	u64 start_uaddr;
> +	u32 hv_map_flags;
> +	struct {
> +		u64 large_pages:  1; /* 2MiB */
> +		u64 range_pinned: 1;
> +		u64 reserved:	 62;
> +	} flags;
> +	struct mshv_partition *partition;
> +	struct page *pages[];
> +};
> +
> +struct mshv_irq_ack_notifier {
> +	struct hlist_node link;
> +	unsigned int irq_ack_gsi;
> +	void (*irq_acked)(struct mshv_irq_ack_notifier *mian);
> +};
> +
> +struct mshv_partition {
> +	struct device *pt_module_dev;
> +
> +	struct hlist_node pt_hnode;
> +	u64 pt_id;
> +	refcount_t pt_ref_count;
> +	struct mutex pt_mutex;
> +	struct hlist_head pt_mem_regions; // not ordered
> +
> +	u32 pt_vp_count;
> +	struct mshv_vp *pt_vp_array[MSHV_MAX_VPS];
> +
> +	struct mutex pt_irq_lock;
> +	struct srcu_struct pt_irq_srcu;
> +	struct hlist_head irq_ack_notifier_list;
> +
> +	struct hlist_head pt_devices;
> +
> +	/*
> +	 * Since MSHV does not support more than one async hypercall in flight

Wording is a bit messed up.  Drop the "Since"?

> +	 * for a single partition. Thus, it is okay to define per partition
> +	 * async hypercall status.
> +	 */
> +	struct completion async_hypercall;
> +	u64 async_hypercall_status;
> +
> +	spinlock_t	  pt_irqfds_lock;
> +	struct hlist_head pt_irqfds_list;
> +	struct mutex	  irqfds_resampler_lock;
> +	struct hlist_head irqfds_resampler_list;
> +
> +	struct hlist_head ioeventfds_list;
> +
> +	struct mshv_girq_routing_table __rcu *pt_girq_tbl;
> +	u64 isolation_type;
> +	bool import_completed;
> +	bool pt_initialized;
> +};
> +
> +#define pt_fmt(fmt) "p%llu: " fmt
> +#define pt_dev(p) ((p)->pt_module_dev)
> +#define pt_emerg(p, fmt, ...) \
> +	dev_emerg(pt_dev(p), pt_fmt(fmt), (p)->pt_id, ##__VA_ARGS__)
> +#define pt_crit(p, fmt, ...) \
> +	dev_crit(pt_dev(p), pt_fmt(fmt), (p)->pt_id, ##__VA_ARGS__)
> +#define pt_alert(p, fmt, ...) \
> +	dev_alert(pt_dev(p), pt_fmt(fmt), (p)->pt_id, ##__VA_ARGS__)
> +#define pt_err(p, fmt, ...) \
> +	dev_err(pt_dev(p), pt_fmt(fmt), (p)->pt_id, ##__VA_ARGS__)
> +#define pt_warn(p, fmt, ...) \
> +	dev_warn(pt_dev(p), pt_fmt(fmt), (p)->pt_id, ##__VA_ARGS__)
> +#define pt_notice(p, fmt, ...) \
> +	dev_notice(pt_dev(p), pt_fmt(fmt), (p)->pt_id, ##__VA_ARGS__)
> +#define pt_info(p, fmt, ...) \
> +	dev_info(pt_dev(p), pt_fmt(fmt), (p)->pt_id, ##__VA_ARGS__)
> +#define pt_dbg(p, fmt, ...) \
> +	dev_dbg(pt_dev(p), pt_fmt(fmt), (p)->pt_id, ##__VA_ARGS__)
> +
> +struct mshv_lapic_irq {
> +	u32 lapic_vector;
> +	u64 lapic_apic_id;
> +	union hv_interrupt_control lapic_control;
> +};
> +
> +#define MSHV_MAX_GUEST_IRQS		4096
> +
> +/* representation of one guest irq entry, either msi or legacy */
> +struct mshv_guest_irq_ent {
> +	u32 girq_entry_valid;	/* vfio looks at this */
> +	u32 guest_irq_num;	/* a unique number for each irq */
> +	u32 girq_addr_lo;	/* guest irq msi address info */
> +	u32 girq_addr_hi;
> +	u32 girq_irq_data;	/* idt vector in some cases */
> +};
> +
> +struct mshv_girq_routing_table {
> +	u32 num_rt_entries;
> +	struct mshv_guest_irq_ent mshv_girq_info_tbl[];
> +};
> +
> +struct hv_synic_pages {
> +	struct hv_message_page *synic_message_page;
> +	struct hv_synic_event_flags_page *synic_event_flags_page;
> +	struct hv_synic_event_ring_page *synic_event_ring_page;
> +};
> +
> +struct mshv_root {
> +	struct hv_synic_pages __percpu *synic_pages;
> +	spinlock_t pt_ht_lock;
> +	DECLARE_HASHTABLE(pt_htable, MSHV_PARTITIONS_HASH_BITS);
> +};
> +
> +/*
> + * Callback for doorbell events.
> + * NOTE: This is called in interrupt context. Callback
> + * should defer slow and sleeping logic to later.
> + */
> +typedef void (*doorbell_cb_t) (int doorbell_id, void *);
> +
> +/*
> + * port table information
> + */
> +struct port_table_info {
> +	struct rcu_head portbl_rcu;
> +	enum hv_port_type hv_port_type;
> +	union {
> +		struct {
> +			u64 reserved[2];
> +		} hv_port_message;
> +		struct {
> +			u64 reserved[2];
> +		} hv_port_event;
> +		struct {
> +			u64 reserved[2];
> +		} hv_port_monitor;
> +		struct {
> +			doorbell_cb_t doorbell_cb;
> +			void *data;
> +		} hv_port_doorbell;
> +	};
> +};
> +
> +int mshv_update_routing_table(struct mshv_partition *partition,
> +			      const struct mshv_user_irq_entry *entries,
> +			      unsigned int numents);
> +void mshv_free_routing_table(struct mshv_partition *partition);
> +
> +struct mshv_guest_irq_ent mshv_ret_girq_entry(struct mshv_partition *par=
tition,
> +					      u32 irq_num);
> +
> +void mshv_copy_girq_info(struct mshv_guest_irq_ent *src_irq,
> +			 struct mshv_lapic_irq *dest_irq);
> +
> +void mshv_irqfd_routing_update(struct mshv_partition *partition);
> +
> +void mshv_port_table_fini(void);
> +int mshv_portid_alloc(struct port_table_info *info);
> +int mshv_portid_lookup(int port_id, struct port_table_info *info);
> +void mshv_portid_free(int port_id);
> +
> +int mshv_register_doorbell(u64 partition_id, doorbell_cb_t doorbell_cb,
> +			   void *data, u64 gpa, u64 val, u64 flags);
> +void mshv_unregister_doorbell(u64 partition_id, int doorbell_portid);
> +
> +void mshv_isr(void);
> +int mshv_synic_init(unsigned int cpu);
> +int mshv_synic_cleanup(unsigned int cpu);
> +
> +static inline bool mshv_partition_encrypted(struct mshv_partition *parti=
tion)
> +{
> +	return partition->isolation_type =3D=3D HV_PARTITION_ISOLATION_TYPE_SNP=
;
> +}
> +
> +struct mshv_partition *mshv_partition_get(struct mshv_partition *partiti=
on);
> +void mshv_partition_put(struct mshv_partition *partition);
> +struct mshv_partition *mshv_partition_find(u64 partition_id) __must_hold=
(RCU);
> +
> +/* hypercalls */
> +
> +int hv_call_withdraw_memory(u64 count, int node, u64 partition_id);
> +int hv_call_create_partition(u64 flags,
> +			     struct hv_partition_creation_properties creation_properties,
> +			     union hv_partition_isolation_properties isolation_properties,
> +			     u64 *partition_id);
> +int hv_call_initialize_partition(u64 partition_id);
> +int hv_call_finalize_partition(u64 partition_id);
> +int hv_call_delete_partition(u64 partition_id);
> +int hv_call_map_mmio_pages(u64 partition_id, u64 gfn, u64 mmio_spa, u64 =
numpgs);
> +int hv_call_map_gpa_pages(u64 partition_id, u64 gpa_target, u64 page_cou=
nt,
> +			  u32 flags, struct page **pages);
> +int hv_call_unmap_gpa_pages(u64 partition_id, u64 gpa_target, u64 page_c=
ount,
> +			    u32 flags);
> +int hv_call_delete_vp(u64 partition_id, u32 vp_index);
> +int hv_call_assert_virtual_interrupt(u64 partition_id, u32 vector,
> +				     u64 dest_addr,
> +				     union hv_interrupt_control control);
> +int hv_call_clear_virtual_interrupt(u64 partition_id);
> +int hv_call_get_gpa_access_states(u64 partition_id, u32 count, u64 gpa_b=
ase_pfn,
> +				  union hv_gpa_page_access_state_flags state_flags,
> +				  int *written_total,
> +				  union hv_gpa_page_access_state *states);
> +int hv_call_get_vp_state(u32 vp_index, u64 partition_id,
> +			 struct hv_vp_state_data state_data,
> +			 /* Choose between pages and ret_output */
> +			 u64 page_count, struct page **pages,
> +			 union hv_output_get_vp_state *ret_output);
> +int hv_call_set_vp_state(u32 vp_index, u64 partition_id,
> +			 /* Choose between pages and bytes */
> +			 struct hv_vp_state_data state_data, u64 page_count,
> +			 struct page **pages, u32 num_bytes, u8 *bytes);
> +int hv_call_map_vp_state_page(u64 partition_id, u32 vp_index, u32 type,
> +			      union hv_input_vtl input_vtl,
> +			      struct page **state_page);
> +int hv_call_unmap_vp_state_page(u64 partition_id, u32 vp_index, u32 type=
,
> +				union hv_input_vtl input_vtl);
> +int hv_call_create_port(u64 port_partition_id, union hv_port_id port_id,
> +			u64 connection_partition_id, struct hv_port_info *port_info,
> +			u8 port_vtl, u8 min_connection_vtl, int node);
> +int hv_call_delete_port(u64 port_partition_id, union hv_port_id port_id)=
;
> +int hv_call_connect_port(u64 port_partition_id, union hv_port_id port_id=
,
> +			 u64 connection_partition_id,
> +			 union hv_connection_id connection_id,
> +			 struct hv_connection_info *connection_info,
> +			 u8 connection_vtl, int node);
> +int hv_call_disconnect_port(u64 connection_partition_id,
> +			    union hv_connection_id connection_id);
> +int hv_call_notify_port_ring_empty(u32 sint_index);
> +int hv_call_map_stat_page(enum hv_stats_object_type type,
> +			  const union hv_stats_object_identity *identity,
> +			  void **addr);
> +int hv_call_unmap_stat_page(enum hv_stats_object_type type,
> +			    const union hv_stats_object_identity *identity);
> +int hv_call_modify_spa_host_access(u64 partition_id, struct page **pages=
,
> +				   u64 page_struct_count, u32 host_access,
> +				   u32 flags, u8 acquire);
> +
> +extern struct mshv_root mshv_root;
> +extern enum hv_scheduler_type hv_scheduler_type;
> +extern u8 __percpu **hv_synic_eventring_tail;

Per comments on an earlier patch, the __percpu is in the wrong place.

> +
> +#endif /* _MSHV_ROOT_H_ */
> diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_cal=
l.c
> new file mode 100644
> index 000000000000..b3e5c652015d
> --- /dev/null
> +++ b/drivers/hv/mshv_root_hv_call.c
> @@ -0,0 +1,876 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2023, Microsoft Corporation.
> + *
> + * Hypercall helper functions used by the mshv_root module.
> + *
> + * Authors:
> + *   Nuno Das Neves <nunodasneves@linux.microsoft.com>
> + *   Wei Liu <wei.liu@kernel.org>
> + *   Jinank Jain <jinankjain@microsoft.com>
> + *   Vineeth Remanan Pillai <viremana@linux.microsoft.com>
> + *   Asher Kariv <askariv@microsoft.com>
> + *   Muminul Islam <Muminul.Islam@microsoft.com>
> + *   Anatol Belski <anbelski@linux.microsoft.com>
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/mm.h>
> +#include <asm/mshyperv.h>
> +
> +#include "mshv_root.h"
> +
> +/* Determined empirically */
> +#define HV_INIT_PARTITION_DEPOSIT_PAGES 208
> +#define HV_MAP_GPA_DEPOSIT_PAGES	256
> +
> +#define HV_PAGE_COUNT_2M_ALIGNED(pg_count) (!((pg_count) & (0x200 - 1)))
> +
> +#define HV_WITHDRAW_BATCH_SIZE	(HV_HYP_PAGE_SIZE / sizeof(u64))
> +#define HV_MAP_GPA_BATCH_SIZE	\
> +	((HV_HYP_PAGE_SIZE - sizeof(struct hv_input_map_gpa_pages)) \
> +		/ sizeof(u64))
> +#define HV_GET_VP_STATE_BATCH_SIZE	\
> +	((HV_HYP_PAGE_SIZE - sizeof(struct hv_input_get_vp_state)) \
> +		/ sizeof(u64))
> +#define HV_SET_VP_STATE_BATCH_SIZE	\
> +	((HV_HYP_PAGE_SIZE - sizeof(struct hv_input_set_vp_state)) \
> +		/ sizeof(u64))
> +#define HV_GET_GPA_ACCESS_STATES_BATCH_SIZE	\
> +	((HV_HYP_PAGE_SIZE - sizeof(union hv_gpa_page_access_state)) \
> +		/ sizeof(union hv_gpa_page_access_state))
> +#define HV_MODIFY_SPARSE_SPA_PAGE_HOST_ACCESS_MAX_PAGE_COUNT
> 	       \
> +	((HV_HYP_PAGE_SIZE -						       \
> +	  sizeof(struct hv_input_modify_sparse_spa_page_host_access)) /        =
\
> +	 sizeof(u64))
> +
> +int hv_call_withdraw_memory(u64 count, int node, u64 partition_id)
> +{
> +	struct hv_input_withdraw_memory *input_page;
> +	struct hv_output_withdraw_memory *output_page;
> +	struct page *page;
> +	u16 completed;
> +	unsigned long remaining =3D count;
> +	u64 status;
> +	int i;
> +	unsigned long flags;
> +
> +	page =3D alloc_page(GFP_KERNEL);
> +	if (!page)
> +		return -ENOMEM;
> +	output_page =3D page_address(page);
> +
> +	while (remaining) {
> +		local_irq_save(flags);
> +
> +		input_page =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> +
> +		memset(input_page, 0, sizeof(*input_page));
> +		input_page->partition_id =3D partition_id;
> +		status =3D hv_do_rep_hypercall(HVCALL_WITHDRAW_MEMORY,
> +					     min(remaining, HV_WITHDRAW_BATCH_SIZE),
> +					     0, input_page, output_page);
> +
> +		local_irq_restore(flags);
> +
> +		completed =3D hv_repcomp(status);
> +
> +		for (i =3D 0; i < completed; i++)
> +			__free_page(pfn_to_page(output_page->gpa_page_list[i]));
> +
> +		if (!hv_result_success(status)) {
> +			if (hv_result(status) =3D=3D HV_STATUS_NO_RESOURCES)
> +				status =3D HV_STATUS_SUCCESS;
> +			break;
> +		}
> +
> +		remaining -=3D completed;
> +	}
> +	free_page((unsigned long)output_page);
> +
> +	return hv_result_to_errno(status);
> +}
> +
> +int hv_call_create_partition(u64 flags,
> +			     struct hv_partition_creation_properties creation_properties,
> +			     union hv_partition_isolation_properties isolation_properties,
> +			     u64 *partition_id)
> +{
> +	struct hv_input_create_partition *input;
> +	struct hv_output_create_partition *output;
> +	u64 status;
> +	int ret;
> +	unsigned long irq_flags;
> +
> +	do {
> +		local_irq_save(irq_flags);
> +		input =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> +		output =3D *this_cpu_ptr(hyperv_pcpu_output_arg);
> +
> +		memset(input, 0, sizeof(*input));
> +		input->flags =3D flags;
> +		input->compatibility_version =3D HV_COMPATIBILITY_21_H2;
> +
> +		memcpy(&input->partition_creation_properties, &creation_properties,
> +		       sizeof(creation_properties));

This is an example of a generic question/concern that occurs in several pla=
ces. By
doing a memcpy into the hypercall input, the assumption is that the creatio=
n
properties supplied by the caller have zeros in all the reserved or unused =
fields.
Is that a valid assumption?

> +
> +		memcpy(&input->isolation_properties, &isolation_properties,
> +		       sizeof(isolation_properties));
> +
> +		status =3D hv_do_hypercall(HVCALL_CREATE_PARTITION,
> +					 input, output);
> +
> +		if (hv_result(status) !=3D HV_STATUS_INSUFFICIENT_MEMORY) {
> +			if (hv_result_success(status))
> +				*partition_id =3D output->partition_id;
> +			local_irq_restore(irq_flags);
> +			ret =3D hv_result_to_errno(status);
> +			break;
> +		}
> +		local_irq_restore(irq_flags);
> +		ret =3D hv_call_deposit_pages(NUMA_NO_NODE,
> +					    hv_current_partition_id, 1);
> +	} while (!ret);
> +
> +	return ret;
> +}
> +
> +int hv_call_initialize_partition(u64 partition_id)
> +{
> +	struct hv_input_initialize_partition input;
> +	u64 status;
> +	int ret;
> +
> +	input.partition_id =3D partition_id;
> +
> +	ret =3D hv_call_deposit_pages(NUMA_NO_NODE, partition_id,
> +				    HV_INIT_PARTITION_DEPOSIT_PAGES);
> +	if (ret)
> +		return ret;
> +
> +	do {
> +		status =3D hv_do_fast_hypercall8(HVCALL_INITIALIZE_PARTITION,
> +					       *(u64 *)&input);
> +
> +		if (hv_result(status) !=3D HV_STATUS_INSUFFICIENT_MEMORY) {
> +			ret =3D hv_result_to_errno(status);
> +			break;
> +		}
> +		ret =3D hv_call_deposit_pages(NUMA_NO_NODE, partition_id, 1);
> +	} while (!ret);
> +
> +	return ret;
> +}
> +
> +int hv_call_finalize_partition(u64 partition_id)
> +{
> +	struct hv_input_finalize_partition input;
> +	u64 status;
> +
> +	input.partition_id =3D partition_id;
> +	status =3D hv_do_fast_hypercall8(HVCALL_FINALIZE_PARTITION,
> +				       *(u64 *)&input);
> +
> +	return hv_result_to_errno(status);
> +}
> +
> +int hv_call_delete_partition(u64 partition_id)
> +{
> +	struct hv_input_delete_partition input;
> +	u64 status;
> +
> +	input.partition_id =3D partition_id;
> +	status =3D hv_do_fast_hypercall8(HVCALL_DELETE_PARTITION, *(u64 *)&inpu=
t);
> +
> +	return hv_result_to_errno(status);
> +}
> +
> +/* Ask the hypervisor to map guest ram pages or the guest mmio space */
> +static int hv_do_map_gpa_hcall(u64 partition_id, u64 gfn, u64 page_struc=
t_count,
> +			       u32 flags, struct page **pages, u64 mmio_spa)
> +{
> +	struct hv_input_map_gpa_pages *input_page;
> +	u64 status, *pfnlist;
> +	unsigned long irq_flags, large_shift =3D 0;
> +	int ret =3D 0, done =3D 0;
> +	u64 page_count =3D page_struct_count;
> +
> +	if (page_count =3D=3D 0 || (pages && mmio_spa))
> +		return -EINVAL;
> +
> +	if (flags & HV_MAP_GPA_LARGE_PAGE) {
> +		if (mmio_spa)
> +			return -EINVAL;
> +
> +		if (!HV_PAGE_COUNT_2M_ALIGNED(page_count))
> +			return -EINVAL;
> +
> +		large_shift =3D HV_HYP_LARGE_PAGE_SHIFT - HV_HYP_PAGE_SHIFT;
> +		page_count >>=3D large_shift;
> +	}
> +
> +	while (done < page_count) {
> +		ulong i, completed, remain =3D page_count - done;
> +		int rep_count =3D min(remain, HV_MAP_GPA_BATCH_SIZE);
> +
> +		local_irq_save(irq_flags);
> +		input_page =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> +
> +		input_page->target_partition_id =3D partition_id;
> +		input_page->target_gpa_base =3D gfn + (done << large_shift);
> +		input_page->map_flags =3D flags;
> +		pfnlist =3D input_page->source_gpa_page_list;
> +
> +		for (i =3D 0; i < rep_count; i++)
> +			if (flags & HV_MAP_GPA_NO_ACCESS) {
> +				pfnlist[i] =3D 0;
> +			} else if (pages) {
> +				u64 index =3D (done + i) << large_shift;
> +
> +				if (index >=3D page_struct_count) {

Can this test ever be true?  It looks like the pages array must
have space for each 4K page even if mapping in 2Meg granularity.
But only every 512th entry in the pages array is looked at
(which seems a little weird). But based on how rep_count is set up,
I don't see how the algorithm could go past the end of the pages
array.

> +					ret =3D -EINVAL;
> +					break;
> +				}
> +				pfnlist[i] =3D page_to_pfn(pages[index]);
> +			} else {
> +				pfnlist[i] =3D mmio_spa + done + i;
> +			}
> +		if (ret)
> +			break;

This test could also go away if the ret =3D -EINVAL error above can't
happen.

> +
> +		status =3D hv_do_rep_hypercall(HVCALL_MAP_GPA_PAGES, rep_count, 0,
> +					     input_page, NULL);
> +		local_irq_restore(irq_flags);
> +
> +		completed =3D hv_repcomp(status);
> +
> +		if (hv_result(status) =3D=3D HV_STATUS_INSUFFICIENT_MEMORY) {
> +			ret =3D hv_call_deposit_pages(NUMA_NO_NODE, partition_id,
> +						    HV_MAP_GPA_DEPOSIT_PAGES);
> +			if (ret)
> +				break;
> +
> +		} else if (!hv_result_success(status)) {
> +			ret =3D hv_result_to_errno(status);
> +			break;
> +		}
> +
> +		done +=3D completed;
> +	}
> +
> +	if (ret && done) {
> +		u32 unmap_flags =3D 0;
> +
> +		if (flags & HV_MAP_GPA_LARGE_PAGE)
> +			unmap_flags |=3D HV_UNMAP_GPA_LARGE_PAGE;
> +		hv_call_unmap_gpa_pages(partition_id, gfn, done, unmap_flags);
> +	}
> +
> +	return ret;
> +}
> +
> +/* Ask the hypervisor to map guest ram pages */
> +int hv_call_map_gpa_pages(u64 partition_id, u64 gpa_target, u64 page_cou=
nt,
> +			  u32 flags, struct page **pages)
> +{
> +	return hv_do_map_gpa_hcall(partition_id, gpa_target, page_count,
> +				   flags, pages, 0);
> +}
> +
> +/* Ask the hypervisor to map guest mmio space */
> +int hv_call_map_mmio_pages(u64 partition_id, u64 gfn, u64 mmio_spa, u64 =
numpgs)
> +{
> +	int i;
> +	u32 flags =3D HV_MAP_GPA_READABLE | HV_MAP_GPA_WRITABLE |
> +		    HV_MAP_GPA_NOT_CACHED;
> +
> +	for (i =3D 0; i < numpgs; i++)
> +		if (page_is_ram(mmio_spa + i))

FWIW, doing this check one-page-at-a-time is somewhat expensive if numpgs
is large.  The underlying data structures should support doing a single ran=
ge
check, but I haven't looked at whether functions exist to do such a range c=
heck.

> +			return -EINVAL;
> +
> +	return hv_do_map_gpa_hcall(partition_id, gfn, numpgs, flags, NULL,
> +				   mmio_spa);
> +}
> +
> +int hv_call_unmap_gpa_pages(u64 partition_id, u64 gfn, u64 page_count_4k=
,
> +			    u32 flags)
> +{
> +	struct hv_input_unmap_gpa_pages *input_page;
> +	u64 status, page_count =3D page_count_4k;
> +	unsigned long irq_flags, large_shift =3D 0;
> +	int ret =3D 0, done =3D 0;
> +
> +	if (page_count =3D=3D 0)
> +		return -EINVAL;
> +
> +	if (flags & HV_UNMAP_GPA_LARGE_PAGE) {
> +		if (!HV_PAGE_COUNT_2M_ALIGNED(page_count))
> +			return -EINVAL;
> +
> +		large_shift =3D HV_HYP_LARGE_PAGE_SHIFT - HV_HYP_PAGE_SHIFT;
> +		page_count >>=3D large_shift;
> +	}
> +
> +	while (done < page_count) {
> +		ulong completed, remain =3D page_count - done;
> +		int rep_count =3D min(remain, HV_MAP_GPA_BATCH_SIZE);

Using HV_MAP_GPA_BATCH_SIZE seems a little weird here since there's
no input array and hence no constraint based on keeping input args to
just one page. Is it being used as an arbitrary limit so the rep_count
passed to the hypercall isn't "too large" for some definition of "too large=
"?
If that's the case, perhaps a separate #define and a comment would
make sense. I kept trying to figure out how the batch size for unmap was
related to the map hypercall, and I don't think there is any relationship.

> +
> +		local_irq_save(irq_flags);
> +		input_page =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> +
> +		input_page->target_partition_id =3D partition_id;
> +		input_page->target_gpa_base =3D gfn + (done << large_shift);
> +		input_page->unmap_flags =3D flags;
> +		status =3D hv_do_rep_hypercall(HVCALL_UNMAP_GPA_PAGES, rep_count,
> +					     0, input_page, NULL);
> +		local_irq_restore(irq_flags);
> +
> +		completed =3D hv_repcomp(status);
> +		if (!hv_result_success(status)) {
> +			ret =3D hv_result_to_errno(status);
> +			break;
> +		}
> +
> +		done +=3D completed;
> +	}
> +
> +	return ret;
> +}
> +
> +int hv_call_get_gpa_access_states(u64 partition_id, u32 count, u64 gpa_b=
ase_pfn,
> +				  union hv_gpa_page_access_state_flags state_flags,
> +				  int *written_total,
> +				  union hv_gpa_page_access_state *states)
> +{
> +	struct hv_input_get_gpa_pages_access_state *input_page;
> +	union hv_gpa_page_access_state *output_page;
> +	int completed =3D 0;
> +	unsigned long remaining =3D count;
> +	int rep_count, i;
> +	u64 status;
> +	unsigned long flags;
> +
> +	*written_total =3D 0;
> +	while (remaining) {
> +		local_irq_save(flags);
> +		input_page =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> +		output_page =3D *this_cpu_ptr(hyperv_pcpu_output_arg);
> +
> +		input_page->partition_id =3D partition_id;
> +		input_page->hv_gpa_page_number =3D gpa_base_pfn + *written_total;
> +		input_page->flags =3D state_flags;
> +		rep_count =3D min(remaining, HV_GET_GPA_ACCESS_STATES_BATCH_SIZE);
> +
> +		status =3D hv_do_rep_hypercall(HVCALL_GET_GPA_PAGES_ACCESS_STATES, rep=
_count,
> +					     0, input_page, output_page);
> +		if (!hv_result_success(status)) {
> +			local_irq_restore(flags);
> +			break;
> +		}
> +		completed =3D hv_repcomp(status);
> +		for (i =3D 0; i < completed; ++i)
> +			states[i].as_uint8 =3D output_page[i].as_uint8;
> +
> +		states +=3D completed;
> +		*written_total +=3D completed;
> +		remaining -=3D completed;
> +		local_irq_restore(flags);

FWIW, this local_irq_restore() could move up three lines to before the prog=
ress
accounting is done.

> +	}
> +
> +	return hv_result_to_errno(status);
> +}
> +
> +int hv_call_assert_virtual_interrupt(u64 partition_id, u32 vector,
> +				     u64 dest_addr,
> +				     union hv_interrupt_control control)
> +{
> +	struct hv_input_assert_virtual_interrupt *input;
> +	unsigned long flags;
> +	u64 status;
> +
> +	local_irq_save(flags);
> +	input =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	memset(input, 0, sizeof(*input));
> +	input->partition_id =3D partition_id;
> +	input->vector =3D vector;
> +	input->dest_addr =3D dest_addr;
> +	input->control =3D control;
> +	status =3D hv_do_hypercall(HVCALL_ASSERT_VIRTUAL_INTERRUPT, input, NULL=
);
> +	local_irq_restore(flags);
> +
> +	return hv_result_to_errno(status);
> +}
> +
> +int hv_call_delete_vp(u64 partition_id, u32 vp_index)
> +{
> +	union hv_input_delete_vp input =3D {};
> +	u64 status;
> +
> +	input.partition_id =3D partition_id;
> +	input.vp_index =3D vp_index;
> +
> +	status =3D hv_do_fast_hypercall16(HVCALL_DELETE_VP,
> +					input.as_uint64[0], input.as_uint64[1]);
> +
> +	return hv_result_to_errno(status);
> +}
> +EXPORT_SYMBOL_GPL(hv_call_delete_vp);
> +
> +int hv_call_get_vp_state(u32 vp_index, u64 partition_id,
> +			 struct hv_vp_state_data state_data,
> +			 /* Choose between pages and ret_output */
> +			 u64 page_count, struct page **pages,
> +			 union hv_output_get_vp_state *ret_output)
> +{
> +	struct hv_input_get_vp_state *input;
> +	union hv_output_get_vp_state *output;
> +	u64 status;
> +	int i;
> +	u64 control;
> +	unsigned long flags;
> +	int ret =3D 0;
> +
> +	if (page_count > HV_GET_VP_STATE_BATCH_SIZE)
> +		return -EINVAL;
> +
> +	if (!page_count && !ret_output)
> +		return -EINVAL;
> +
> +	do {
> +		local_irq_save(flags);
> +		input =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> +		output =3D *this_cpu_ptr(hyperv_pcpu_output_arg);
> +		memset(input, 0, sizeof(*input));
> +		memset(output, 0, sizeof(*output));

Why is the output set to zero?  I would think Hyper-V is responsible for
ensuring that the output is properly populated, with unused fields/areas
set to zero.

> +
> +		input->partition_id =3D partition_id;
> +		input->vp_index =3D vp_index;
> +		input->state_data =3D state_data;
> +		for (i =3D 0; i < page_count; i++)
> +			input->output_data_pfns[i] =3D page_to_pfn(pages[i]);
> +
> +		control =3D (HVCALL_GET_VP_STATE) |
> +			  (page_count << HV_HYPERCALL_VARHEAD_OFFSET);
> +
> +		status =3D hv_do_hypercall(control, input, output);
> +
> +		if (hv_result(status) !=3D HV_STATUS_INSUFFICIENT_MEMORY) {
> +			if (hv_result_success(status) && ret_output)
> +				memcpy(ret_output, output, sizeof(*output));
> +
> +			local_irq_restore(flags);
> +			ret =3D hv_result_to_errno(status);
> +			break;
> +		}
> +		local_irq_restore(flags);
> +
> +		ret =3D hv_call_deposit_pages(NUMA_NO_NODE,
> +					    partition_id, 1);
> +	} while (!ret);
> +
> +	return ret;
> +}
> +
> +int hv_call_set_vp_state(u32 vp_index, u64 partition_id,
> +			 /* Choose between pages and bytes */
> +			 struct hv_vp_state_data state_data, u64 page_count,

The size of "struct hv_vp_state_data" looks to be 24 bytes (3 64-bit words)=
.
Is there a reason to pass this by value instead of as a pointer? I guess it=
 works
like this, but it seems atypical.

> +			 struct page **pages, u32 num_bytes, u8 *bytes)
> +{
> +	struct hv_input_set_vp_state *input;
> +	u64 status;
> +	int i;
> +	u64 control;
> +	unsigned long flags;
> +	int ret =3D 0;
> +	u16 varhead_sz;
> +
> +	if (page_count > HV_SET_VP_STATE_BATCH_SIZE)
> +		return -EINVAL;
> +	if (sizeof(*input) + num_bytes > HV_HYP_PAGE_SIZE)
> +		return -EINVAL;
> +
> +	if (num_bytes)
> +		/* round up to 8 and divide by 8 */
> +		varhead_sz =3D (num_bytes + 7) >> 3;
> +	else if (page_count)
> +		varhead_sz =3D page_count;
> +	else
> +		return -EINVAL;
> +
> +	do {
> +		local_irq_save(flags);
> +		input =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> +		memset(input, 0, sizeof(*input));
> +
> +		input->partition_id =3D partition_id;
> +		input->vp_index =3D vp_index;
> +		input->state_data =3D state_data;
> +		if (num_bytes) {
> +			memcpy((u8 *)input->data, bytes, num_bytes);
> +		} else {
> +			for (i =3D 0; i < page_count; i++)
> +				input->data[i].pfns =3D page_to_pfn(pages[i]);
> +		}
> +
> +		control =3D (HVCALL_SET_VP_STATE) |
> +			  (varhead_sz << HV_HYPERCALL_VARHEAD_OFFSET);
> +
> +		status =3D hv_do_hypercall(control, input, NULL);
> +
> +		if (hv_result(status) !=3D HV_STATUS_INSUFFICIENT_MEMORY) {
> +			local_irq_restore(flags);
> +			ret =3D hv_result_to_errno(status);
> +			break;
> +		}
> +		local_irq_restore(flags);
> +
> +		ret =3D hv_call_deposit_pages(NUMA_NO_NODE,
> +					    partition_id, 1);
> +	} while (!ret);
> +
> +	return ret;
> +}
> +
> +int hv_call_map_vp_state_page(u64 partition_id, u32 vp_index, u32 type,
> +			      union hv_input_vtl input_vtl,
> +			      struct page **state_page)
> +{
> +	struct hv_input_map_vp_state_page *input;
> +	struct hv_output_map_vp_state_page *output;
> +	u64 status;
> +	int ret;
> +	unsigned long flags;
> +
> +	do {
> +		local_irq_save(flags);
> +
> +		input =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> +		output =3D *this_cpu_ptr(hyperv_pcpu_output_arg);
> +
> +		input->partition_id =3D partition_id;
> +		input->vp_index =3D vp_index;
> +		input->type =3D type;
> +		input->input_vtl =3D input_vtl;
> +
> +		status =3D hv_do_hypercall(HVCALL_MAP_VP_STATE_PAGE, input, output);
> +
> +		if (hv_result(status) !=3D HV_STATUS_INSUFFICIENT_MEMORY) {
> +			if (hv_result_success(status))
> +				*state_page =3D pfn_to_page(output->map_location);
> +			local_irq_restore(flags);
> +			ret =3D hv_result_to_errno(status);
> +			break;
> +		}
> +
> +		local_irq_restore(flags);
> +
> +		ret =3D hv_call_deposit_pages(NUMA_NO_NODE, partition_id, 1);
> +	} while (!ret);
> +
> +	return ret;
> +}
> +
> +int hv_call_unmap_vp_state_page(u64 partition_id, u32 vp_index, u32 type=
,
> +				union hv_input_vtl input_vtl)
> +{
> +	unsigned long flags;
> +	u64 status;
> +	struct hv_input_unmap_vp_state_page *input;
> +
> +	local_irq_save(flags);
> +
> +	input =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> +
> +	memset(input, 0, sizeof(*input));
> +
> +	input->partition_id =3D partition_id;
> +	input->vp_index =3D vp_index;
> +	input->type =3D type;
> +	input->input_vtl =3D input_vtl;
> +
> +	status =3D hv_do_hypercall(HVCALL_UNMAP_VP_STATE_PAGE, input, NULL);
> +
> +	local_irq_restore(flags);
> +
> +	return hv_result_to_errno(status);
> +}
> +
> +int
> +hv_call_clear_virtual_interrupt(u64 partition_id)
> +{
> +	unsigned long flags;
> +	int status;
> +
> +	local_irq_save(flags);
> +	status =3D hv_do_fast_hypercall8(HVCALL_CLEAR_VIRTUAL_INTERRUPT,
> +				       partition_id) &
> +			HV_HYPERCALL_RESULT_MASK;

This "anding" with HV_HYPERCALL_RESULT_MASK should be removed.

> +	local_irq_restore(flags);

The irq save/restore isn't needed here since this is a fast hypercall and
per-cpu arg memory is not used.

> +
> +	return hv_result_to_errno(status);
> +}
> +
> +int
> +hv_call_create_port(u64 port_partition_id, union hv_port_id port_id,
> +		    u64 connection_partition_id,
> +		    struct hv_port_info *port_info,
> +		    u8 port_vtl, u8 min_connection_vtl, int node)
> +{
> +	struct hv_input_create_port *input;
> +	unsigned long flags;
> +	int ret =3D 0;
> +	int status;
> +
> +	do {
> +		local_irq_save(flags);
> +		input =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> +		memset(input, 0, sizeof(*input));
> +
> +		input->port_partition_id =3D port_partition_id;
> +		input->port_id =3D port_id;
> +		input->connection_partition_id =3D connection_partition_id;
> +		input->port_info =3D *port_info;
> +		input->port_vtl =3D port_vtl;
> +		input->min_connection_vtl =3D min_connection_vtl;
> +		input->proximity_domain_info =3D hv_numa_node_to_pxm_info(node);
> +		status =3D hv_do_hypercall(HVCALL_CREATE_PORT, input, NULL) &
> +			 HV_HYPERCALL_RESULT_MASK;

Use the hv_status checking macros instead of and'ing with
HV_HYPERCALL_RESULT_MASK.

> +		local_irq_restore(flags);
> +		if (status =3D=3D HV_STATUS_SUCCESS)
> +			break;
> +
> +		if (status !=3D HV_STATUS_INSUFFICIENT_MEMORY) {
> +			ret =3D hv_result_to_errno(status);
> +			break;
> +		}
> +		ret =3D hv_call_deposit_pages(NUMA_NO_NODE, port_partition_id, 1);
> +
> +	} while (!ret);
> +
> +	return ret;
> +}
> +
> +int
> +hv_call_delete_port(u64 port_partition_id, union hv_port_id port_id)
> +{
> +	union hv_input_delete_port input =3D { 0 };
> +	unsigned long flags;
> +	int status;
> +
> +	local_irq_save(flags);
> +	input.port_partition_id =3D port_partition_id;
> +	input.port_id =3D port_id;
> +	status =3D hv_do_fast_hypercall16(HVCALL_DELETE_PORT,
> +					input.as_uint64[0],
> +					input.as_uint64[1]) &
> +			HV_HYPERCALL_RESULT_MASK;
> +	local_irq_restore(flags);

Same a previous comment about and'ing.  And irq save/restore
isn't needed.

> +
> +	return hv_result_to_errno(status);
> +}
> +
> +int
> +hv_call_connect_port(u64 port_partition_id, union hv_port_id port_id,
> +		     u64 connection_partition_id,
> +		     union hv_connection_id connection_id,
> +		     struct hv_connection_info *connection_info,
> +		     u8 connection_vtl, int node)
> +{
> +	struct hv_input_connect_port *input;
> +	unsigned long flags;
> +	int ret =3D 0, status;
> +
> +	do {
> +		local_irq_save(flags);
> +		input =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> +		memset(input, 0, sizeof(*input));
> +		input->port_partition_id =3D port_partition_id;
> +		input->port_id =3D port_id;
> +		input->connection_partition_id =3D connection_partition_id;
> +		input->connection_id =3D connection_id;
> +		input->connection_info =3D *connection_info;
> +		input->connection_vtl =3D connection_vtl;
> +		input->proximity_domain_info =3D hv_numa_node_to_pxm_info(node);
> +		status =3D hv_do_hypercall(HVCALL_CONNECT_PORT, input, NULL) &
> +			 HV_HYPERCALL_RESULT_MASK;

Same here.  Use hv_* macros.

> +
> +		local_irq_restore(flags);
> +		if (status =3D=3D HV_STATUS_SUCCESS)
> +			break;
> +
> +		if (status !=3D HV_STATUS_INSUFFICIENT_MEMORY) {
> +			ret =3D hv_result_to_errno(status);
> +			break;
> +		}
> +		ret =3D hv_call_deposit_pages(NUMA_NO_NODE,
> +					    connection_partition_id, 1);
> +	} while (!ret);
> +
> +	return ret;
> +}
> +
> +int
> +hv_call_disconnect_port(u64 connection_partition_id,
> +			union hv_connection_id connection_id)
> +{
> +	union hv_input_disconnect_port input =3D { 0 };
> +	unsigned long flags;
> +	int status;
> +
> +	local_irq_save(flags);
> +	input.connection_partition_id =3D connection_partition_id;
> +	input.connection_id =3D connection_id;
> +	input.is_doorbell =3D 1;
> +	status =3D hv_do_fast_hypercall16(HVCALL_DISCONNECT_PORT,
> +					input.as_uint64[0],
> +					input.as_uint64[1]) &
> +			HV_HYPERCALL_RESULT_MASK;
> +	local_irq_restore(flags);

Same as above.

> +
> +	return hv_result_to_errno(status);
> +}
> +
> +int
> +hv_call_notify_port_ring_empty(u32 sint_index)
> +{
> +	union hv_input_notify_port_ring_empty input =3D { 0 };
> +	unsigned long flags;
> +	int status;
> +
> +	local_irq_save(flags);
> +	input.sint_index =3D sint_index;
> +	status =3D hv_do_fast_hypercall8(HVCALL_NOTIFY_PORT_RING_EMPTY,
> +				       input.as_uint64) &
> +		 HV_HYPERCALL_RESULT_MASK;
> +	local_irq_restore(flags);

Same as above.

> +
> +	return hv_result_to_errno(status);
> +}
> +
> +int hv_call_map_stat_page(enum hv_stats_object_type type,
> +			  const union hv_stats_object_identity *identity,
> +			  void **addr)
> +{
> +	unsigned long flags;
> +	struct hv_input_map_stats_page *input;
> +	struct hv_output_map_stats_page *output;
> +	u64 status, pfn;
> +	int ret;
> +
> +	do {
> +		local_irq_save(flags);
> +		input =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> +		output =3D *this_cpu_ptr(hyperv_pcpu_output_arg);
> +
> +		memset(input, 0, sizeof(*input));
> +		input->type =3D type;
> +		input->identity =3D *identity;
> +
> +		status =3D hv_do_hypercall(HVCALL_MAP_STATS_PAGE, input, output);
> +		pfn =3D output->map_location;
> +
> +		local_irq_restore(flags);
> +		if (hv_result(status) !=3D HV_STATUS_INSUFFICIENT_MEMORY) {
> +			if (hv_result_success(status))
> +				break;
> +			return hv_result_to_errno(status);
> +		}
> +
> +		ret =3D hv_call_deposit_pages(NUMA_NO_NODE,
> +					    hv_current_partition_id, 1);
> +		if (ret)
> +			return ret;
> +	} while (!ret);
> +
> +	*addr =3D page_address(pfn_to_page(pfn));
> +
> +	return ret;
> +}
> +
> +int hv_call_unmap_stat_page(enum hv_stats_object_type type,
> +			    const union hv_stats_object_identity *identity)
> +{
> +	unsigned long flags;
> +	struct hv_input_unmap_stats_page *input;
> +	u64 status;
> +
> +	local_irq_save(flags);
> +	input =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> +
> +	memset(input, 0, sizeof(*input));
> +	input->type =3D type;
> +	input->identity =3D *identity;
> +
> +	status =3D hv_do_hypercall(HVCALL_UNMAP_STATS_PAGE, input, NULL);
> +	local_irq_restore(flags);
> +
> +	return hv_result_to_errno(status);
> +}
> +
> +int hv_call_modify_spa_host_access(u64 partition_id, struct page **pages=
,
> +				   u64 page_struct_count, u32 host_access,
> +				   u32 flags, u8 acquire)
> +{
> +	struct hv_input_modify_sparse_spa_page_host_access *input_page;
> +	u64 status;
> +	int done =3D 0;
> +	unsigned long irq_flags, large_shift =3D 0;
> +	u64 page_count =3D page_struct_count;
> +	u16 code =3D acquire ? HVCALL_ACQUIRE_SPARSE_SPA_PAGE_HOST_ACCESS :
> +			     HVCALL_RELEASE_SPARSE_SPA_PAGE_HOST_ACCESS;
> +
> +	if (page_count =3D=3D 0)
> +		return -EINVAL;
> +
> +	if (flags & HV_MODIFY_SPA_PAGE_HOST_ACCESS_LARGE_PAGE) {
> +		if (!HV_PAGE_COUNT_2M_ALIGNED(page_count))
> +			return -EINVAL;
> +		large_shift =3D HV_HYP_LARGE_PAGE_SHIFT - HV_HYP_PAGE_SHIFT;
> +		page_count >>=3D large_shift;
> +	}
> +
> +	while (done < page_count) {
> +		ulong i, completed, remain =3D page_count - done;
> +		int rep_count =3D min(remain,
> +				HV_MODIFY_SPARSE_SPA_PAGE_HOST_ACCESS_MAX_PAGE_COUNT);
> +
> +		local_irq_save(irq_flags);
> +		input_page =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> +		/*
> +		 * This is required to make sure that reserved field is set to
> +		 * zero, because MSHV has a check to make sure reserved bits are
> +		 * set to zero.
> +		 */

Is this comment about checking reserved bits unique to this hypercall? If n=
ot, it
seems a little odd to see this comment here, but not other places where the=
 input
is zero'ed.

> +		memset(input_page, 0, sizeof(*input_page));
> +		/* Only set the partition id if you are making the pages
> +		 * exclusive
> +		 */
> +		if (flags & HV_MODIFY_SPA_PAGE_HOST_ACCESS_MAKE_EXCLUSIVE)
> +			input_page->partition_id =3D partition_id;
> +		input_page->flags =3D flags;
> +		input_page->host_access =3D host_access;
> +
> +		for (i =3D 0; i < rep_count; i++) {
> +			u64 index =3D (done + i) << large_shift;
> +
> +			if (index >=3D page_struct_count)
> +				return -EINVAL;

Can this test ever be true?

> +
> +			input_page->spa_page_list[i] =3D
> +						page_to_pfn(pages[index]);

When large_shift is non-zero, it seems weird to be skipping over most
of the entries in the "pages" array.  But maybe there's a reason for that.

> +		}
> +
> +		status =3D hv_do_rep_hypercall(code, rep_count, 0, input_page,
> +					     NULL);
> +		local_irq_restore(irq_flags);
> +
> +		completed =3D hv_repcomp(status);
> +
> +		if (!hv_result_success(status))
> +			return hv_result_to_errno(status);
> +
> +		done +=3D completed;
> +	}
> +
> +	return 0;
> +}

[snip the rest of the patch that I haven't reviewed yet]

Michael

