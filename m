Return-Path: <linux-arch+bounces-10225-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9150AA3C90A
	for <lists+linux-arch@lfdr.de>; Wed, 19 Feb 2025 20:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6208A17831A
	for <lists+linux-arch@lfdr.de>; Wed, 19 Feb 2025 19:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF8F22CBF3;
	Wed, 19 Feb 2025 19:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="L+HaMM2j"
X-Original-To: linux-arch@vger.kernel.org
Received: from CY4PR05CU001.outbound.protection.outlook.com (mail-westcentralusazolkn19010000.outbound.protection.outlook.com [52.103.7.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655711FDE24;
	Wed, 19 Feb 2025 19:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.7.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739994404; cv=fail; b=Ee2zZkV4xMVVrpFG0FaU2BLaFOC3hgKse4C87oIXzvffitxn5yJoLO35PJXFTxhBwJLQnpAi0XMInm6NvU9rewSZv5DQZwrlQqbhL/aiqhaZMJomIdXmlzE9GSsZi7Jk+pgVPLfod9kusdtF0vljQN5bOAIjfh5pIFy2NOQ4Wvw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739994404; c=relaxed/simple;
	bh=Io5FKrLfEgTX+10N+Mag5kB0Dy1BrymQ54iY/8H2iYE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BY9TSNQSl89fpGwe9dxA+A5FvXaf4lsAY8z613SfsIPtowXPeFEy6BUG0+QELKtnQrQ4YgK3jMXaKNQmLhiOT5QJCZXuUQVksNrUW28ljrhrMDp5uhz+AUDZNdl5gebdYeQpcH4dmsHGCZEC4cFL54gx9lt5IJFfespBzo5uegE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=L+HaMM2j; arc=fail smtp.client-ip=52.103.7.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y+zpLFVDi45DTqR2egiIRyilf1MptfvxpOjlUlV4c8fuV7X4FT0SXA3odYW1kA6RzUlrXfUwhvBdz5xn2VfdMahjBlhzFUir/DBXfCMK8f6VqtX72dfKyVQZBVrZ+DOmaRVRzFZSuWiC68gxl3McBo6Lo9EnDUjV23NWeydlAfXoxEuZ5FNWEl/wRK2Qa6Ob5bahcJGitFu+E7pa2CwhklHTKUW3Kl1T4FvorSkWMfRynZzBNxL4AbyBTGCf/WA2GbAGKuop9AWUyhWlUGjNj8G5Me+rcaBApzc+ICr1e8B6uOJUVgMEd982DK1ayop8OHx4pc81V4XBTJRxMGhBqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cACUQwrDkVPNuNUofqvo/WhkP5A0QAF3IsPR+9uRq9M=;
 b=tTo4hXSPYEJs2y9auV7ckTOmA3E5/Qk1tKGLDmFywf1Wpb0gEW2tth/wSMM5iz6gHnBAMbQ5cFnng1orh7JBGzb6hB8JY/rrhz8FMnJr8atOVvcbrBayryXaSa6549/ZtgTNNdgNQNECXPntTxvX4Z+Pdukvl1E7PuWKWqzmR8J8GZVRtHrYTuwwVsSPCJnBRH6h7lox8zvMeoSgCWkDYSdA/UlavrqK5HdOvlIk4suERewPbXv3HftKzJHNKwuDO64H6xzFkPrA9T5vm4Qt0hLuZFbWcPyx9abwfUCzHNmFpKcszhXbHNXxQtQ3BkEQmmoi0E9hCzHO9ytt5t0GLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cACUQwrDkVPNuNUofqvo/WhkP5A0QAF3IsPR+9uRq9M=;
 b=L+HaMM2jNNdirp26jchx8Og4lPMZI4ehRzDl5wNC1LVaZVdeyDlM3DsNmXPyXf1/x4AWeGfbdUFSB/uhHicZASIseTaEu7tqdsHdFMjNvB1PfXLTjScY81VD+0aoHSmVtXOMTvHMzsGzY1XxjU+tUvsmzxFDg2O3Y2sMrL+TZqTszp8n0r3B1DXG8NxWiwNsgmNsEfL7Iq+nbGrwEsVkGpun4vqsIkvqHJ2MebUKTMTDSqIdJKlSwO3I1ETsz2JZyRXK0yiF8k9JmZGTCWQoiyQysHyg6DwhW0kh/7v1VHD1sWZe05D68ceWKZnt1pzTCdeK2824YZGVLTmYw6gz8Q==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by MW6PR02MB9693.namprd02.prod.outlook.com (2603:10b6:303:23f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Wed, 19 Feb
 2025 19:46:32 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8466.013; Wed, 19 Feb 2025
 19:46:32 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>
CC: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>, "will@kernel.org" <will@kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "joro@8bytes.org"
	<joro@8bytes.org>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
	"arnd@arndb.de" <arnd@arndb.de>, "jinankjain@linux.microsoft.com"
	<jinankjain@linux.microsoft.com>, "muminulrussell@gmail.com"
	<muminulrussell@gmail.com>, "skinsburskii@linux.microsoft.com"
	<skinsburskii@linux.microsoft.com>, "mukeshrathor@microsoft.com"
	<mukeshrathor@microsoft.com>
Subject: RE: [PATCH] hyperv: Add CONFIG_MSHV_ROOT to gate hv_root_partition
 checks
Thread-Topic: [PATCH] hyperv: Add CONFIG_MSHV_ROOT to gate hv_root_partition
 checks
Thread-Index: AQHbfNN0LPMRAYePyESDh5/Fg8MXNbNO4d+Q
Date: Wed, 19 Feb 2025 19:46:32 +0000
Message-ID:
 <SN6PR02MB4157F396B9FECAD555520DDED4C52@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <1739312515-18848-1-git-send-email-nunodasneves@linux.microsoft.com>
In-Reply-To:
 <1739312515-18848-1-git-send-email-nunodasneves@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|MW6PR02MB9693:EE_
x-ms-office365-filtering-correlation-id: f79aed05-7153-49ef-3a35-08dd511e1c3f
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799006|15080799006|8062599003|12121999004|19110799003|461199028|3412199025|4302099013|440099028|10035399004|12091999003|41001999003|102099032|1602099012;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?rybBjhnJdZjfp3MBsNZySQUeUc0MHOkfk/jdudGaYkQYx48An0tlbupVtruZ?=
 =?us-ascii?Q?T6fI4g5vaMEdvPThLeKN+hBEft1pTvwKVR4O40gbg9sFYEpac1XhD9fPY4of?=
 =?us-ascii?Q?cd6vy1Wrmfk9cUeVKpBzOP96AaQpSU/8tctXw4Ouo4VK7K/u+b6/zC2c5lT3?=
 =?us-ascii?Q?H0tb+9zO35yzjHFyungG1JyBo1Vc9+q4oqRjw0VXVmdyM9XEJbMCqngZDzBX?=
 =?us-ascii?Q?DEZm06KgUlMwadBa5Y4hEbQYpnm2K6iH/HJgemAUPrr6yVOKev1ZS98e7156?=
 =?us-ascii?Q?Jr+g0LkZoxptApVaHw3QFR6Vpq+FMmjNYa6nXvndLe4W6T+oZ0KAU/zbpK8q?=
 =?us-ascii?Q?lGVRkoZ0nOB41D+PqFtBJlKqiKebX0sMVbzngEqUDZX+bal/MV7r04987Yum?=
 =?us-ascii?Q?Bn5NZ3uejx6ikoFR0xu44Y2UBebVh1aM4B6JY0jn9Hd5243mJYSxKO1cIG7H?=
 =?us-ascii?Q?j3YQjBK679JPD+JXh4qw6JLZmvroPrZdu91rwPyhiB40OG7DaNQw5wqMF8HA?=
 =?us-ascii?Q?ERnkBIxTGBsLuu935xmAyw9lcUz0chuu75c15qz1hQrhB+6OL/zYD9falxaI?=
 =?us-ascii?Q?8inOuLljC5KPktCvgCzPoMpSL5Wqcc4toHm7v9wE9zkoHP5lENfmmeDTQP+h?=
 =?us-ascii?Q?BC0deRqq095w+H85UBKPvBPTItW8l5pzThi8XGjSXwdI/b2ivoMmjNWNbiki?=
 =?us-ascii?Q?9T/CNQFVlKhNMb/81LFMlALwQm5+uUdWbD7WQSUpV47iOf8u+Wz7PQxNE9YO?=
 =?us-ascii?Q?6NfAbPz16bl+ej28ThQLAscvwl8DgNYFLR+11x02GmsrhJfWwArZYy8/NGOy?=
 =?us-ascii?Q?usQBcjyv3M9h92FeCkPnfAS581YWGzKCZRUAlgnk4cr67g51u6Lmht2vplsB?=
 =?us-ascii?Q?jOAWjEv1IshCYBSTqqQGSdIMPzHiT+OUXEdJ/jIOJKYjmoH8NFHp4i5XAMNA?=
 =?us-ascii?Q?8Q7JaBWQZITWm+PnH4nR3TQ3B5VfQXnJ4/1Q/hChRfLRvkIvwHr84zIImd2k?=
 =?us-ascii?Q?FxR2OdQQdDLq/uIDPYSweZggTmLnLTw1d0O8HJvFVnkmoTqZ+FJjdRiVRWQs?=
 =?us-ascii?Q?fwljbezO6LuE6eSYmQACi6fP8+2YYwOpqXOYE4ycg8AxR8WdAVOvcsQjdXbS?=
 =?us-ascii?Q?1veNkKk8id1AP4Q7LZLkEeUB/LTTovhKtTGJcJVrip89oTMiU4rll9ztDbGF?=
 =?us-ascii?Q?TR6UEzvYbhxzzVkXs7uF+nCi/LbDmWmJPx1S1O4NF5fxs1MRMxYTAKxKeWMv?=
 =?us-ascii?Q?eXB6P80X71UqiFqfAIMWkp9FSi4tFfVL5MxxtosVtX88Ipa0e52bcYmEjy2u?=
 =?us-ascii?Q?ww/X8bMbXzriAynjyeBmQfPr?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?1bjTeYv9XxPyCh2/4+Kzhlpl4yC1S/StnlDv5Bk8U8XYHfBHi3CKvQWDTGZj?=
 =?us-ascii?Q?VKjifEOLYeB3SQoJt4S0RMNGA2XFm5gAycXT5roTnJVioD02Jta7zn5Ije/5?=
 =?us-ascii?Q?I35jAqHZSKbLVsDqc19jqwz8jFcFKhu+BIUN+6EhWc2pIHx/wVh8jWRWBbh0?=
 =?us-ascii?Q?WqQuSOgULlzpVTvl68gFV8jqnwrd32LvmyCpPZKkRQDjXlGh1hqEQHoVnQHc?=
 =?us-ascii?Q?MSsX26zFfIhoL1tWISdw98aLLL6y6pYH4b3GtxbQzBB2jefyGYOHvkKM9mfx?=
 =?us-ascii?Q?R+Yi/AmBqjohAkZEyAfFUN+0doRJeje0MjTQT7EYDYwvFKGURhcd5fflbUlh?=
 =?us-ascii?Q?RABOPP02+1BYON7rMXBGxsmhIbCXtaAf58yNCUspky3vOKtsOEOTQl5f6Kjh?=
 =?us-ascii?Q?msFrckcLKEd+rc4JkXo9uCr0TrWIVy4YzLM5UKclh8FEtwOH9n84IXO7QF6i?=
 =?us-ascii?Q?tPoNoJYQYXq+41CYrgmWvMlpitq4qmrPqHNbY93DxyRtQBhF89SmaIYQUz5O?=
 =?us-ascii?Q?DlbsBtKIlCB2lgo6XV2/wL5CfCXkrVTr+f9LpHCnkyouMh0b+w6Cc0h5PW+g?=
 =?us-ascii?Q?2KogmXY/jMKgYoT4BZWz4ny/dOAMDaHk4voCnbA7blmbd0YufrGjNfk3gyyF?=
 =?us-ascii?Q?iBe6sjlAieKDbpf+CP6obfCtqIIJaiCsvSr6XAjiq6yldMbi7NalWj7hpNx+?=
 =?us-ascii?Q?keEk1JeHYCTK8HYErT9l7Galx79cPzN3blB9x91t7sxWuFqn2Z1bHsxtKb8B?=
 =?us-ascii?Q?LNBPLriXq9mC3nCqVrtFe2v2qdzp9fvKOIrnKX7bab8O13SEQyeWwifhlXsE?=
 =?us-ascii?Q?dbhyGHY87pSFGNMrcUaRGDkZMG0mMXK8hTiKUEfWcsI463E09KHwLyW6LGcj?=
 =?us-ascii?Q?zOAZEP8EfkmHF90ErXrXEG51xpOPfxxYZHTQSDlUgc7L6FGbJgP5qLOJrCTO?=
 =?us-ascii?Q?CfZdWBPP6x6RORbIbapEep75Bcyc7ni2A/dszZWmn3XLsB9yD3Jbx4QDtID8?=
 =?us-ascii?Q?3i3h4eKwHmuvA6ARCmXKJj/KWQamgR3+73lY7ZTzv9zIjnpYw9HhE2i2suFO?=
 =?us-ascii?Q?SF6EDJSxWOL9AYWkWGUxnUkKuDIeoam9H0WPxFMg29ttkHNn6xM3QK4YI/Bj?=
 =?us-ascii?Q?oncJGgh86koPmpYcy3Ne9DDxS7d/Sepe7jToVrzovLWMNEn1HlLHEUEmyVKE?=
 =?us-ascii?Q?ZCNEWX3HKbtp/oCQNafDuCJk7lQ3Q0FQ9qlLg90MXnngUygNZ7gEaWlhCFw?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f79aed05-7153-49ef-3a35-08dd511e1c3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2025 19:46:32.0859
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR02MB9693

From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Tuesday, Febr=
uary 11, 2025 2:22 PM
>=20
> Introduce CONFIG_MSHV_ROOT as a tristate to enable root partition
> booting and future mshv driver functionality.

This statement could use a bit more explanation as to "why".  Something
like:

Running in the root partition is a unique and specialized case that require=
s
additional code. The config option allows kernels built to run as a normal
Hyper-V guest to exclude this code, which is important since significant
additional code specific to the root partition is expected to be added over
time.

Related, what's the thinking behind making CONFIG_MSHV_ROOT be
tri-state? Obviously, it would allow most of the root partition code
to be loaded as a module instead of built-in to the kernel image, but is th=
at
a useful scenario given the unique nature of running in the root partition?
Since the root partition environment is very specific and constrained,
perhaps just always building the root partition code into the kernel
makes sense. I'm asking purely as a question because I'm not familiar with
the details of how a root partition kernel is likely to be setup & run. If
possible, give a short explanation for the "why tri-state" question.
Remember, that's what commit message are for -- to answer the "why"
question as much as to summarize the "what" question.

>=20
> Change hv_root_partition into a function which always returns false
> if CONFIG_MSHV_ROOT=3Dn.

Again, help answer the "why" question. I think the goal is related to
the above by allowing the compiler to optimize away any "if (root partition=
)"
code when building for a normal Hyper-V guest.

>=20
> Introduce hv_current_partition_type to store the type of partition
> (guest, root, or other kinds in future), and hv_identify_partition_type()
> to it up early in Hyper-V initialization.
>=20
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> ---
> Depends on
> https://lore.kernel.org/linux-hyperv/1738955002-20821-3-git-send-email-nu=
nodasneves@linux.microsoft.com/
>=20
>  arch/arm64/hyperv/mshyperv.c       |  2 ++
>  arch/x86/hyperv/hv_init.c          | 10 ++++----
>  arch/x86/kernel/cpu/mshyperv.c     | 24 ++----------------
>  drivers/clocksource/hyperv_timer.c |  4 +--
>  drivers/hv/Kconfig                 | 12 +++++++++
>  drivers/hv/Makefile                |  3 ++-
>  drivers/hv/hv.c                    | 10 ++++----
>  drivers/hv/hv_common.c             | 32 +++++++++++++++++++-----
>  drivers/hv/vmbus_drv.c             |  2 +-
>  drivers/iommu/hyperv-iommu.c       |  4 +--
>  include/asm-generic/mshyperv.h     | 39 +++++++++++++++++++++++++-----
>  11 files changed, 92 insertions(+), 50 deletions(-)
>=20
> diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
> index 29fcfd595f48..2265ea5ce5ad 100644
> --- a/arch/arm64/hyperv/mshyperv.c
> +++ b/arch/arm64/hyperv/mshyperv.c
> @@ -61,6 +61,8 @@ static int __init hyperv_init(void)
>  		ms_hyperv.features, ms_hyperv.priv_high, ms_hyperv.hints,
>  		ms_hyperv.misc_features);
>=20
> +	hv_identify_partition_type();
> +
>  	ret =3D hv_common_init();
>  	if (ret)
>  		return ret;
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 9be1446f5bd3..ddeb40930bc8 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -90,7 +90,7 @@ static int hv_cpu_init(unsigned int cpu)
>  		return 0;
>=20
>  	hvp =3D &hv_vp_assist_page[cpu];
> -	if (hv_root_partition) {
> +	if (hv_root_partition()) {
>  		/*
>  		 * For root partition we get the hypervisor provided VP assist
>  		 * page, instead of allocating a new page.
> @@ -242,7 +242,7 @@ static int hv_cpu_die(unsigned int cpu)
>=20
>  	if (hv_vp_assist_page && hv_vp_assist_page[cpu]) {
>  		union hv_vp_assist_msr_contents msr =3D { 0 };
> -		if (hv_root_partition) {
> +		if (hv_root_partition()) {
>  			/*
>  			 * For root partition the VP assist page is mapped to
>  			 * hypervisor provided page, and thus we unmap the
> @@ -317,7 +317,7 @@ static int hv_suspend(void)
>  	union hv_x64_msr_hypercall_contents hypercall_msr;
>  	int ret;
>=20
> -	if (hv_root_partition)
> +	if (hv_root_partition())
>  		return -EPERM;
>=20
>  	/*
> @@ -518,7 +518,7 @@ void __init hyperv_init(void)
>  	rdmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
>  	hypercall_msr.enable =3D 1;
>=20
> -	if (hv_root_partition) {
> +	if (hv_root_partition()) {
>  		struct page *pg;
>  		void *src;
>=20
> @@ -592,7 +592,7 @@ void __init hyperv_init(void)
>  	 * If we're running as root, we want to create our own PCI MSI domain.
>  	 * We can't set this in hv_pci_init because that would be too late.
>  	 */
> -	if (hv_root_partition)
> +	if (hv_root_partition())
>  		x86_init.irqs.create_pci_msi_domain =3D hv_create_pci_msi_domain;
>  #endif
>=20
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyper=
v.c
> index f285757618fc..4f01f424ea5b 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -33,8 +33,6 @@
>  #include <asm/numa.h>
>  #include <asm/svm.h>
>=20
> -/* Is Linux running as the root partition? */
> -bool hv_root_partition;
>  /* Is Linux running on nested Microsoft Hypervisor */
>  bool hv_nested;
>  struct ms_hyperv_info ms_hyperv;
> @@ -451,25 +449,7 @@ static void __init ms_hyperv_init_platform(void)
>  	pr_debug("Hyper-V: max %u virtual processors, %u logical processors\n",
>  		 ms_hyperv.max_vp_index, ms_hyperv.max_lp_index);
>=20
> -	/*
> -	 * Check CPU management privilege.
> -	 *
> -	 * To mirror what Windows does we should extract CPU management
> -	 * features and use the ReservedIdentityBit to detect if Linux is the
> -	 * root partition. But that requires negotiating CPU management
> -	 * interface (a process to be finalized). For now, use the privilege
> -	 * flag as the indicator for running as root.
> -	 *
> -	 * Hyper-V should never specify running as root and as a Confidential
> -	 * VM. But to protect against a compromised/malicious Hyper-V trying
> -	 * to exploit root behavior to expose Confidential VM memory, ignore
> -	 * the root partition setting if also a Confidential VM.
> -	 */
> -	if ((ms_hyperv.priv_high & HV_CPU_MANAGEMENT) &&
> -	    !(ms_hyperv.priv_high & HV_ISOLATION)) {
> -		hv_root_partition =3D true;
> -		pr_info("Hyper-V: running as root partition\n");
> -	}
> +	hv_identify_partition_type();
>=20
>  	if (ms_hyperv.hints & HV_X64_HYPERV_NESTED) {
>  		hv_nested =3D true;
> @@ -618,7 +598,7 @@ static void __init ms_hyperv_init_platform(void)
>=20
>  # ifdef CONFIG_SMP
>  	smp_ops.smp_prepare_boot_cpu =3D hv_smp_prepare_boot_cpu;
> -	if (hv_root_partition ||
> +	if (hv_root_partition() ||
>  	    (!ms_hyperv.paravisor_present && hv_isolation_type_snp()))
>  		smp_ops.smp_prepare_cpus =3D hv_smp_prepare_cpus;
>  # endif
> diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyp=
erv_timer.c
> index f00019b078a7..09549451dd51 100644
> --- a/drivers/clocksource/hyperv_timer.c
> +++ b/drivers/clocksource/hyperv_timer.c
> @@ -582,7 +582,7 @@ static void __init hv_init_tsc_clocksource(void)
>  	 * mapped.
>  	 */
>  	tsc_msr.as_uint64 =3D hv_get_msr(HV_MSR_REFERENCE_TSC);
> -	if (hv_root_partition)
> +	if (hv_root_partition())
>  		tsc_pfn =3D tsc_msr.pfn;
>  	else
>  		tsc_pfn =3D HVPFN_DOWN(virt_to_phys(tsc_page));
> @@ -627,7 +627,7 @@ void __init hv_remap_tsc_clocksource(void)
>  	if (!(ms_hyperv.features & HV_MSR_REFERENCE_TSC_AVAILABLE))
>  		return;
>=20
> -	if (!hv_root_partition) {
> +	if (!hv_root_partition()) {
>  		WARN(1, "%s: attempt to remap TSC page in guest partition\n",
>  		     __func__);
>  		return;
> diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
> index 862c47b191af..aac172942f6c 100644
> --- a/drivers/hv/Kconfig
> +++ b/drivers/hv/Kconfig
> @@ -55,4 +55,16 @@ config HYPERV_BALLOON
>  	help
>  	  Select this option to enable Hyper-V Balloon driver.
>=20
> +config MSHV_ROOT
> +	tristate "Microsoft Hyper-V root partition support"
> +	depends on HYPERV
> +	depends on !HYPERV_VTL_MODE
> +	depends on PAGE_SIZE_4KB

Add a comment about why PAGE_SIZE_4KB is a requirement, even on
arm64 systems that can support guests with larger page sizes. We
discussed why in an earlier email thread, but somebody looking at
this in the future might wonder.

> +	default n
> +	help
> +	  Select this option to enable support for booting and running as root
> +	  partition on Microsoft Hyper-V.
> +
> +	  If unsure, say N.
> +

One thing to keep in mind:  Sometimes people build kernels with all
config options set to "Y".  We want to make sure that if someone does
that, the kernel will still run in a non-Hyper-V environment.  We had this
problem with CONFIG_HYPERV_VTL_MODE=3Dy, where a kernel built with
that wouldn't run elsewhere, and that had to be fixed.  I don't think the
changes in this patch cause a problem in that regard, but it is something
to keep in mind for the future.

As I see it, setting CONFIG_MSHV_ROOT=3Dy (or =3Dm) just adds code to
the kernel image or modules list, and enables runtime detection of
whether the kernel is actually in the root partition. If not actually in th=
e
root partition, the behavior is normal guest behavior. I think that is all =
good.

>  endmenu
> diff --git a/drivers/hv/Makefile b/drivers/hv/Makefile
> index 9afcabb3fbd2..2b8dc954b350 100644
> --- a/drivers/hv/Makefile
> +++ b/drivers/hv/Makefile
> @@ -13,4 +13,5 @@ hv_vmbus-$(CONFIG_HYPERV_TESTING)	+=3D hv_debugfs.o
>  hv_utils-y :=3D hv_util.o hv_kvp.o hv_snapshot.o hv_utils_transport.o
>=20
>  # Code that must be built-in
> -obj-$(subst m,y,$(CONFIG_HYPERV)) +=3D hv_common.o hv_proc.o
> +obj-$(subst m,y,$(CONFIG_HYPERV)) +=3D hv_common.o
> +obj-$(subst m,y,$(CONFIG_MSHV_ROOT)) +=3D hv_proc.o

OK, so hv_proc.o is always built-in, regardless of whether
CONFIG_MSHV_ROOT=3Dy or =3Dm. I think that makes sense. The functions in
hv_proc.c are called somewhere in the middle of the kernel boot process,
and I'm unsure if the module loading mechanism is fully set up at the point
the functions are needed. This approach avoids any risk of not being able
to load the module. Presumably still-to-be-added code for the root partitio=
n
could be built as a module (though see my comment in the commit message).

> diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
> index 36d9ba097ff5..93d82382351c 100644
> --- a/drivers/hv/hv.c
> +++ b/drivers/hv/hv.c
> @@ -144,7 +144,7 @@ int hv_synic_alloc(void)
>  		 * Synic message and event pages are allocated by paravisor.
>  		 * Skip these pages allocation here.
>  		 */
> -		if (!ms_hyperv.paravisor_present && !hv_root_partition) {
> +		if (!ms_hyperv.paravisor_present && !hv_root_partition()) {
>  			hv_cpu->synic_message_page =3D
>  				(void *)get_zeroed_page(GFP_ATOMIC);
>  			if (!hv_cpu->synic_message_page) {
> @@ -272,7 +272,7 @@ void hv_synic_enable_regs(unsigned int cpu)
>  	simp.as_uint64 =3D hv_get_msr(HV_MSR_SIMP);
>  	simp.simp_enabled =3D 1;
>=20
> -	if (ms_hyperv.paravisor_present || hv_root_partition) {
> +	if (ms_hyperv.paravisor_present || hv_root_partition()) {
>  		/* Mask out vTOM bit. ioremap_cache() maps decrypted */
>  		u64 base =3D (simp.base_simp_gpa << HV_HYP_PAGE_SHIFT) &
>  				~ms_hyperv.shared_gpa_boundary;
> @@ -291,7 +291,7 @@ void hv_synic_enable_regs(unsigned int cpu)
>  	siefp.as_uint64 =3D hv_get_msr(HV_MSR_SIEFP);
>  	siefp.siefp_enabled =3D 1;
>=20
> -	if (ms_hyperv.paravisor_present || hv_root_partition) {
> +	if (ms_hyperv.paravisor_present || hv_root_partition()) {
>  		/* Mask out vTOM bit. ioremap_cache() maps decrypted */
>  		u64 base =3D (siefp.base_siefp_gpa << HV_HYP_PAGE_SHIFT) &
>  				~ms_hyperv.shared_gpa_boundary;
> @@ -367,7 +367,7 @@ void hv_synic_disable_regs(unsigned int cpu)
>  	 * addresses.
>  	 */
>  	simp.simp_enabled =3D 0;
> -	if (ms_hyperv.paravisor_present || hv_root_partition) {
> +	if (ms_hyperv.paravisor_present || hv_root_partition()) {
>  		iounmap(hv_cpu->synic_message_page);
>  		hv_cpu->synic_message_page =3D NULL;
>  	} else {
> @@ -379,7 +379,7 @@ void hv_synic_disable_regs(unsigned int cpu)
>  	siefp.as_uint64 =3D hv_get_msr(HV_MSR_SIEFP);
>  	siefp.siefp_enabled =3D 0;
>=20
> -	if (ms_hyperv.paravisor_present || hv_root_partition) {
> +	if (ms_hyperv.paravisor_present || hv_root_partition()) {
>  		iounmap(hv_cpu->synic_event_page);
>  		hv_cpu->synic_event_page =3D NULL;
>  	} else {
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index cb3ea49020ef..d1227e85c5b7 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -34,8 +34,11 @@
>  u64 hv_current_partition_id =3D HV_PARTITION_ID_SELF;
>  EXPORT_SYMBOL_GPL(hv_current_partition_id);
>=20
> +enum hv_partition_type hv_current_partition_type;
> +EXPORT_SYMBOL_GPL(hv_current_partition_type);
> +
>  /*
> - * hv_root_partition, ms_hyperv and hv_nested are defined here with othe=
r
> + * ms_hyperv and hv_nested are defined here with other
>   * Hyper-V specific globals so they are shared across all architectures =
and are
>   * built only when CONFIG_HYPERV is defined.  But on x86,
>   * ms_hyperv_init_platform() is built even when CONFIG_HYPERV is not
> @@ -43,9 +46,6 @@ EXPORT_SYMBOL_GPL(hv_current_partition_id);
>   * here, allowing for an overriding definition in the module containing
>   * ms_hyperv_init_platform().
>   */
> -bool __weak hv_root_partition;
> -EXPORT_SYMBOL_GPL(hv_root_partition);
> -
>  bool __weak hv_nested;
>  EXPORT_SYMBOL_GPL(hv_nested);
>=20
> @@ -283,7 +283,7 @@ static void hv_kmsg_dump_register(void)
>=20
>  static inline bool hv_output_page_exists(void)
>  {
> -	return hv_root_partition || IS_ENABLED(CONFIG_HYPERV_VTL_MODE);
> +	return hv_root_partition() || IS_ENABLED(CONFIG_HYPERV_VTL_MODE);
>  }
>=20
>  void __init hv_get_partition_id(void)
> @@ -594,7 +594,7 @@ EXPORT_SYMBOL_GPL(hv_setup_dma_ops);
>=20
>  bool hv_is_hibernation_supported(void)
>  {
> -	return !hv_root_partition && acpi_sleep_state_supported(ACPI_STATE_S4);
> +	return !hv_root_partition() && acpi_sleep_state_supported(ACPI_STATE_S4=
);
>  }
>  EXPORT_SYMBOL_GPL(hv_is_hibernation_supported);
>=20
> @@ -683,3 +683,23 @@ u64 __weak hv_tdx_hypercall(u64 control, u64 param1,=
 u64 param2)
>  	return HV_STATUS_INVALID_PARAMETER;
>  }
>  EXPORT_SYMBOL_GPL(hv_tdx_hypercall);
> +
> +void hv_identify_partition_type(void)
> +{
> +	/*
> +	 * Check partition creation and cpu management privileges
> +	 *
> +	 * Hyper-V should never specify running as root and as a Confidential
> +	 * VM. But to protect against a compromised/malicious Hyper-V trying
> +	 * to exploit root behavior to expose Confidential VM memory, ignore
> +	 * the root partition setting if also a Confidential VM.
> +	 */
> +	if ((ms_hyperv.priv_high & HV_CREATE_PARTITIONS) &&
> +	    (ms_hyperv.priv_high & HV_CPU_MANAGEMENT) &&
> +	    !(ms_hyperv.priv_high & HV_ISOLATION)) {
> +		hv_current_partition_type =3D HV_PARTITION_TYPE_ROOT;
> +		pr_info("Hyper-V: running as root partition\n");
> +	} else {
> +		hv_current_partition_type =3D HV_PARTITION_TYPE_GUEST;
> +	}

If the flags indicate running in the root partition, but CONFIG_MSHV_ROOT=
=3Dn,
perhaps that should probably be flagged with an error message. I haven't th=
ought
through what to do then: Panic, keep running as a normal guest, or somethin=
g else?

> +}
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 0f6cd44fff29..844eba0429fa 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -2646,7 +2646,7 @@ static int __init hv_acpi_init(void)
>  	if (!hv_is_hyperv_initialized())
>  		return -ENODEV;
>=20
> -	if (hv_root_partition && !hv_nested)
> +	if (hv_root_partition() && !hv_nested)
>  		return 0;
>=20
>  	/*
> diff --git a/drivers/iommu/hyperv-iommu.c b/drivers/iommu/hyperv-iommu.c
> index 2a86aa5d54c6..53e4b37716af 100644
> --- a/drivers/iommu/hyperv-iommu.c
> +++ b/drivers/iommu/hyperv-iommu.c
> @@ -130,7 +130,7 @@ static int __init hyperv_prepare_irq_remapping(void)
>  	    x86_init.hyper.msi_ext_dest_id())
>  		return -ENODEV;
>=20
> -	if (hv_root_partition) {
> +	if (hv_root_partition()) {
>  		name =3D "HYPERV-ROOT-IR";
>  		ops =3D &hyperv_root_ir_domain_ops;
>  	} else {
> @@ -151,7 +151,7 @@ static int __init hyperv_prepare_irq_remapping(void)
>  		return -ENOMEM;
>  	}
>=20
> -	if (hv_root_partition)
> +	if (hv_root_partition())
>  		return 0; /* The rest is only relevant to guests */
>=20
>  	/*
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyper=
v.h
> index 7adc10a4fa3e..6f898792fb51 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -28,6 +28,11 @@
>=20
>  #define VTPM_BASE_ADDRESS 0xfed40000
>=20
> +enum hv_partition_type {
> +	HV_PARTITION_TYPE_GUEST,
> +	HV_PARTITION_TYPE_ROOT,
> +};
> +
>  struct ms_hyperv_info {
>  	u32 features;
>  	u32 priv_high;
> @@ -59,6 +64,7 @@ struct ms_hyperv_info {
>  extern struct ms_hyperv_info ms_hyperv;
>  extern bool hv_nested;
>  extern u64 hv_current_partition_id;
> +extern enum hv_partition_type hv_current_partition_type;
>=20
>  extern void * __percpu *hyperv_pcpu_input_arg;
>  extern void * __percpu *hyperv_pcpu_output_arg;
> @@ -190,8 +196,6 @@ void hv_remove_crash_handler(void);
>  extern int vmbus_interrupt;
>  extern int vmbus_irq;
>=20
> -extern bool hv_root_partition;
> -
>  #if IS_ENABLED(CONFIG_HYPERV)
>  /*
>   * Hypervisor's notion of virtual processor ID is different from
> @@ -213,15 +217,12 @@ void __init hv_common_free(void);
>  void __init ms_hyperv_late_init(void);
>  int hv_common_cpu_init(unsigned int cpu);
>  int hv_common_cpu_die(unsigned int cpu);
> +void hv_identify_partition_type(void);
>=20
>  void *hv_alloc_hyperv_page(void);
>  void *hv_alloc_hyperv_zeroed_page(void);
>  void hv_free_hyperv_page(void *addr);
>=20
> -int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages);
> -int hv_call_add_logical_proc(int node, u32 lp_index, u32 acpi_id);
> -int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flag=
s);
> -
>  /**
>   * hv_cpu_number_to_vp_number() - Map CPU to VP.
>   * @cpu_number: CPU number in Linux terms
> @@ -309,6 +310,7 @@ void hyperv_cleanup(void);
>  bool hv_query_ext_cap(u64 cap_query);
>  void hv_setup_dma_ops(struct device *dev, bool coherent);
>  #else /* CONFIG_HYPERV */
> +static inline void hv_identify_partition_type(void) {}
>  static inline bool hv_is_hyperv_initialized(void) { return false; }
>  static inline bool hv_is_hibernation_supported(void) { return false; }
>  static inline void hyperv_cleanup(void) {}
> @@ -320,4 +322,29 @@ static inline enum hv_isolation_type hv_get_isolatio=
n_type(void)
>  }
>  #endif /* CONFIG_HYPERV */
>=20
> +#if IS_ENABLED(CONFIG_MSHV_ROOT)
> +static inline bool hv_root_partition(void)
> +{
> +	return	hv_current_partition_type =3D=3D HV_PARTITION_TYPE_ROOT;

Nit: There's an extra space character after "return".

> +}
> +int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages);
> +int hv_call_add_logical_proc(int node, u32 lp_index, u32 acpi_id);
> +int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flag=
s);
> +
> +#else /* CONFIG_MSHV_ROOT */
> +static inline bool hv_root_partition(void) { return false; }
> +static inline int hv_call_deposit_pages(int node, u64 partition_id, u32 =
num_pages)
> +{
> +	return hv_result(U64_MAX);
> +}
> +static inline int hv_call_add_logical_proc(int node, u32 lp_index, u32 a=
cpi_id)
> +{
> +	return hv_result(U64_MAX);
> +}
> +static inline int hv_call_create_vp(int node, u64 partition_id, u32 vp_i=
ndex, u32 flags)
> +{
> +	return hv_result(U64_MAX);
> +}
> +#endif /* CONFIG_MSHV_ROOT */
> +
>  #endif
> --
> 2.34.1


