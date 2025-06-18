Return-Path: <linux-arch+bounces-12380-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 400D4ADF272
	for <lists+linux-arch@lfdr.de>; Wed, 18 Jun 2025 18:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DEBA7A2515
	for <lists+linux-arch@lfdr.de>; Wed, 18 Jun 2025 16:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588952F2713;
	Wed, 18 Jun 2025 16:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="rcTkh2kU"
X-Original-To: linux-arch@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazolkn19012009.outbound.protection.outlook.com [52.103.14.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218212F0054;
	Wed, 18 Jun 2025 16:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.14.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750263585; cv=fail; b=K9EtuefleVNGN0QsQRoaB+Qf7Pcqta2HQLcUDamG8fVwQOaOOnl2qzG01kmnMBJlYMZR/+FqHtw0MVznjyN2lHbniLrrKCfAWfqOktqsKWQjmB1aXnHDEZmJFNNGJNCu/H/VBRAEvlt3le3UtEPFkWq8hU/R5DO+6qdXokFbFLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750263585; c=relaxed/simple;
	bh=F1Wmhjf4K7HBaiMyt391yq4krX9yjMpHy3OADXj/kJg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ef1Aa4yORYoJTno2w9CYoS+qVdWZbQTLQRNOoZ3FHZg7M5JQcWpE7UOMmO36UgrD7sKsiqBstcHnnAAFetuJrqbR4VfUZHMkdP0wG7Aov17DFzJnncu2sTDfsX0QMBAy84WadoIOO/f3gErrt/rGs47GeS2r/itk7GBvkNUdu64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=rcTkh2kU; arc=fail smtp.client-ip=52.103.14.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R4YW2zYsikQwggwAORmy2SlobW/50Mq5IL7ENsOcZqZjEagfJxiXphJHvYw20SlGkkcjF/rTNsa1HlHyE6Rl3K7v7wHNyiWj82jHxpEJp27HOqqapsJJZfndGdvurNuYuqJ/jSetTQJVQj0KUgDRnluKU50uTA+MaW5qjPg8bJwmacIxtJeoYkVgAF+84JaYRggA7IxY0lFd6e6jamUbtZgDgCF3ULEnLdsVnTijxk+58Mir5b6AeXqyvf6ly5ahSF+1lp6qyib0ZcAvQBMnctVwZG8U/ObzbJ0kGpyVLmHHtEdMCBmPazQuMWZBQNMMinK2gjqFO8dyhdKkMnQGeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5HO6EVCVMj+uHBuBl+0jX1KUmxucQZq3w0EismD4654=;
 b=WAHzXRpgdfZVTfV93bkUgT6Aqz+XAo8ejt0M6a9J9N1Au6/4u+IuePYQeltsJtj8HvXEZTnFg4C9WV6NCMjgs+fn5auazNSpj+o/L1vvH3XfLKXvMFKX2CMUSVjh6zyZgrLLct1I3YtBibMKJXNqkhGW8p1igEYjhWSxIHYZXNGxD5DMU51/X+e4H+NNv3krdGfX2qdKTj3/HcV82p36+FlbdSxlPQzpIbqGJAGqUzOSBYginZnd6rAZIc1jJJOOOY29/YW43et80eLndi9uZx8LxR8b3Zozd92E0hxWXKDmmIMcq1v/UJ3TBF5CJqcM+PyLhs97QroKqIMEBpGX5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5HO6EVCVMj+uHBuBl+0jX1KUmxucQZq3w0EismD4654=;
 b=rcTkh2kUr6fzp6dX+9ot4ENT0vb3TrVmKMHtE8c24qxWJGuLTDRlZTYwIW4nKF5TCbL8lHM3x2xtPUuXMnbQVWjO8+oN5w9JxtUfkhyFo8Un4jZaPPszOjyfklRYAdsmDu/HuyZqVuZ4KBruxReusw+eV4BBZHJHDM8hEeYx723hH5Vc7shkFoRCMFUlBUAs3q/jIzxGqNRatpsZYfN2Sppk6XdPfExdJdy8/ua820suDL5Z1uRBATK5udlBgro5dzfVw4teVZgkWwEXJx7AMpd9ne+JmRgc/4Ufb4bt2Nel5dvPudMhvwgk7QxFo7na6Y2c/g/lQqXCzGUiwsGK/Q==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SA6PR02MB10429.namprd02.prod.outlook.com (2603:10b6:806:405::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Wed, 18 Jun
 2025 16:19:39 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 16:19:39 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Roman Kisel <romank@linux.microsoft.com>, "alok.a.tiwari@oracle.com"
	<alok.a.tiwari@oracle.com>, "arnd@arndb.de" <arnd@arndb.de>, "bp@alien8.de"
	<bp@alien8.de>, "corbet@lwn.net" <corbet@lwn.net>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"decui@microsoft.com" <decui@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"kys@microsoft.com" <kys@microsoft.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>
CC: "apais@microsoft.com" <apais@microsoft.com>, "benhill@microsoft.com"
	<benhill@microsoft.com>, "bperkins@microsoft.com" <bperkins@microsoft.com>,
	"sunilmut@microsoft.com" <sunilmut@microsoft.com>
Subject: RE: [PATCH hyperv-next v3 14/15] Drivers: hv: Support establishing
 the confidential VMBus connection
Thread-Topic: [PATCH hyperv-next v3 14/15] Drivers: hv: Support establishing
 the confidential VMBus connection
Thread-Index: AQHb1Om9BhiLCGJpSUq3QReI4goGebQGzGnQ
Date: Wed, 18 Jun 2025 16:19:39 +0000
Message-ID:
 <SN6PR02MB415749A79FD265F2CF8F4D77D472A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250604004341.7194-1-romank@linux.microsoft.com>
 <20250604004341.7194-15-romank@linux.microsoft.com>
In-Reply-To: <20250604004341.7194-15-romank@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SA6PR02MB10429:EE_
x-ms-office365-filtering-correlation-id: 345d3e80-c6b6-4e78-9124-08ddae83eccc
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799006|41001999006|15080799009|8060799009|8062599006|461199028|440099028|3412199025|40105399003|12091999003|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?zst54JUCZJbwXw3BPV2UXwQL9Xwt6lMaCAFVWdj2LA7mch7FhSIyQOEy14Wy?=
 =?us-ascii?Q?vhSO+QsFU5DND7tf+gMCdnFTljaz3iAZd9pC7n7oJIvHuYdjK8V1uQsvBha9?=
 =?us-ascii?Q?ku6Dsd6PP87qFOxf6alO+lGKyXp4S7w83taPIMSaWzVMhtyk7Lr1sQ59duLI?=
 =?us-ascii?Q?BSC/anRvVR9XoTN9kaKfDy8jahnh8UFbaX88C7FgkGkf2Cn2jtzfs2feymZR?=
 =?us-ascii?Q?wiLw8TfmLivUO7QnoXQrH88A38zJmemwUsGj7Iwc+zBiSPLVq62ZcfcZiQTq?=
 =?us-ascii?Q?Tt6a8SCPWG3/5q912BvJO336WP4syM8GfJz/d3f79r9j2vy4mabuyDaTxn5g?=
 =?us-ascii?Q?1CFkl/JuO7YT3pUPSAYyTi8iroa4yIrTyn2+IHYFEbA7rH5qQb680XWYmNWu?=
 =?us-ascii?Q?HURx5lEtm/jX7tzxaIl5ZP+heXla/1HIuVWmy3HpksMLS8eSpPDtZQlbx3QO?=
 =?us-ascii?Q?/EQv+iS6kGeOoDadn349cteBodABQWIIqgyCaZxoBiPMt80HxAmA4ZOv+FCY?=
 =?us-ascii?Q?hBLnFJ0PfyN1fcjO4shTS6AT0znQNdlWCd2Fqk8sqzI8sd/JjDjJiKDlvEWU?=
 =?us-ascii?Q?5ecUx2c9t7wTJsuY5RtZyLWS8p1JZRF2QI4J3JTpJzq2bwLTztZ33kkEFeQi?=
 =?us-ascii?Q?lTzHfKGHJddFCckJtaPy76oUd9spqQaDNcIN5tOsIXABvSfA4twj0a4720e3?=
 =?us-ascii?Q?cbw3MNINeyEeunFHs5kpB4BqCBVvabtTMamiQ5OQN9bgpXQ7TOniYPniNuxM?=
 =?us-ascii?Q?AR4JvpTiiLd3dbWPvEs7ESJgmllNrvRBVFCxMJF6wB4N8GwZ+k7FZo31J35V?=
 =?us-ascii?Q?8Ts4KaSO+0Yv/EklYopbp+CeabAg5kNzbeCFqnD8qMilx9//WynPjpEKPGqq?=
 =?us-ascii?Q?5k4BfhV22ydsoG5k8rcqO3VPMCUtdxEaImiT4YleEHWumonLaLP2ksDGPisB?=
 =?us-ascii?Q?0dwbtNx2V+vzYcNV2c19bRnSeVdMZFuUByXFrHSu5NDSSPVJwxdZXMu/oWcC?=
 =?us-ascii?Q?slhFiDEzleAaC58iwqvDVhwQvX/So9N0J6zbklWavBFeamj40sflmhCZEND1?=
 =?us-ascii?Q?qc6PD6HrX+/B/ZXfEIc+vIxVx3prZW8TJbnY2QPlLMWyKEvMIEwArK66MnYZ?=
 =?us-ascii?Q?YDGZgZ6U9Mpu96F6wExrFHHQLAgn7mlIZmP+TWZkxK134XuYKZW0E+o=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?msB8qzockT16pbZFyIYPc6ebm77YNVkgyxE5s+S9T4Q4YHUw8RoLXoFpicNX?=
 =?us-ascii?Q?VwBGSSQc6wYaMecKmZAx7D66qJywnDVflgz2gl2x8cuphM8odOWiNbNBjWAN?=
 =?us-ascii?Q?kfqzqQ9HeWhx9Mq6fHRIVJR8h0illJ9xNUAW8bWSG+KTx9s2gYu+iSQucGHg?=
 =?us-ascii?Q?AuO/89fzPaSm5y4n8RcTfQaypYQG3GrCP1P6NN07TtMAYMpTzFHMO2ONwByR?=
 =?us-ascii?Q?YyOQ1rR9hcgWeOAakcnwiPADMUMEwkYoDUDG7LxXCdZsMpcbZUCUOb2HSrbL?=
 =?us-ascii?Q?skWX//1bWkVroiVcE17SN3UKGrxVGzw1AjEYHQpaVFNAF6fdmCSuOO73/miX?=
 =?us-ascii?Q?FiD0T5Q/2I6u3Cyndv1nP0Mm2oU4VhV0LUQTfSXgy9Woww45jOWjhyrsMlkw?=
 =?us-ascii?Q?0CN6a4iHEmFJjPAlDMIyTCj0YRk1o5HTMwMduMMfQbXPpmOFonus/iT0AB0Y?=
 =?us-ascii?Q?HeWaK/HgaH2Qu1tTLjWyeh3zCt3dC9BppVTLxsDlXj5S0O0Bza5olJ11SDgL?=
 =?us-ascii?Q?MUegXAYqfgOE3xdLohj9+3+U6JaXZM7MBxOP44NCMM9qWdb+RNC9kPACED/g?=
 =?us-ascii?Q?kLoSDS/rB4x5t9HZcCMr4p9DdpsjSmF6ZsaSFeuI3rPqz3bxclW7UWMvyqEj?=
 =?us-ascii?Q?TrN2L1bJ/e1c7gPzkFjoFFAhf2F4goVc5xnepvVeyjx7iB2XIZHozNiGyyJi?=
 =?us-ascii?Q?pbLa9n3YMyqa0iky93sEY6o2lWla5xjmLjH1U5wxHkA8n9sFGKffvyQ21bip?=
 =?us-ascii?Q?q4ykwmDEpcny2K4ptkITpGTF13aZW9MTh2hwtop072GNgNJ2dY2IOWZZC9/a?=
 =?us-ascii?Q?cbiZnf4noA3K5LxZJiD4b0yQK6ijmO2JNcRiogCMybNfWC/amaP5nfc0cHUW?=
 =?us-ascii?Q?GCBflFGRvP1n7xec7QhYJVBrzRIIyZLAwq/ojaWYT5EVNGkqt5dVa/6Lbd9T?=
 =?us-ascii?Q?YqxIKSnMcXEXe7hQZypw6eYVnkcikZnVJXg08HrDAtWSMdsaN5dt8ClmesVX?=
 =?us-ascii?Q?gLW2U4xtjzxslR8o2Z320895qFAE+U6ZWnIr3BlPcn0GkwfNx8TwxoZvgS5U?=
 =?us-ascii?Q?+s6LWvKnAhIJaZqzPHGqZJy8+PXH06wYQxk6g/nXvjiW83TzzqsEawW3nWXw?=
 =?us-ascii?Q?KY4u0bXVla1YwYAKhw8G5r4xZl0l6n1xpEeygvgdMfTyl0blHUzukpTTN+0J?=
 =?us-ascii?Q?ImHUdOR1p69FFDmW0omecO1o6lfMmIim2gSPBFTxRh/VG4t9h2/C7/K6H3c?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 345d3e80-c6b6-4e78-9124-08ddae83eccc
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2025 16:19:39.2688
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR02MB10429

From: Roman Kisel <romank@linux.microsoft.com> Sent: Tuesday, June 3, 2025 =
5:44 PM
>=20
> To establish the confidential VMBus connection the CoCo VM guest
> first attempts to connect to the VMBus server run by the paravisor.
> If that fails, the guest falls back to the non-confidential VMBus.
>=20
> Implement that in the VMBus driver initialization.
>=20
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> ---
>  drivers/hv/vmbus_drv.c | 169 +++++++++++++++++++++++++++--------------
>  1 file changed, 110 insertions(+), 59 deletions(-)
>=20
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index f7e82a4fe133..88701c3ad999 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -1057,12 +1057,9 @@ static void vmbus_onmessage_work(struct work_struc=
t *work)
>  	kfree(ctx);
>  }
>=20
> -void vmbus_on_msg_dpc(unsigned long data)
> +static void __vmbus_on_msg_dpc(void *message_page_addr)
>  {
> -	struct hv_per_cpu_context *hv_cpu =3D (void *)data;
> -	void *page_addr =3D hv_cpu->hyp_synic_message_page;
> -	struct hv_message msg_copy, *msg =3D (struct hv_message *)page_addr +
> -				  VMBUS_MESSAGE_SINT;
> +	struct hv_message msg_copy, *msg;
>  	struct vmbus_channel_message_header *hdr;
>  	enum vmbus_channel_message_type msgtype;
>  	const struct vmbus_channel_message_table_entry *entry;
> @@ -1070,6 +1067,10 @@ void vmbus_on_msg_dpc(unsigned long data)
>  	__u8 payload_size;
>  	u32 message_type;
>=20
> +	if (!message_page_addr)
> +		return;
> +	msg =3D (struct hv_message *)message_page_addr + VMBUS_MESSAGE_SINT;
> +
>  	/*
>  	 * 'enum vmbus_channel_message_type' is supposed to always be 'u32' as
>  	 * it is being used in 'struct vmbus_channel_message_header' definition
> @@ -1195,6 +1196,14 @@ void vmbus_on_msg_dpc(unsigned long data)
>  	vmbus_signal_eom(msg, message_type);
>  }
>=20
> +void vmbus_on_msg_dpc(unsigned long data)
> +{
> +	struct hv_per_cpu_context *hv_cpu =3D (void *)data;
> +
> +	__vmbus_on_msg_dpc(hv_cpu->hyp_synic_message_page);
> +	__vmbus_on_msg_dpc(hv_cpu->para_synic_message_page);
> +}
> +
>  #ifdef CONFIG_PM_SLEEP
>  /*
>   * Fake RESCIND_CHANNEL messages to clean up hv_sock channels by force f=
or
> @@ -1233,21 +1242,19 @@ static void vmbus_force_channel_rescinded(struct
> vmbus_channel *channel)
>  #endif /* CONFIG_PM_SLEEP */
>=20
>  /*
> - * Schedule all channels with events pending
> + * Schedule all channels with events pending.
> + * The event page can be directly checked to get the id of
> + * the channel that has the interrupt pending.
>   */
> -static void vmbus_chan_sched(struct hv_per_cpu_context *hv_cpu)
> +static void vmbus_chan_sched(struct hv_per_cpu_context *hv_cpu, void *ev=
ent_page_addr)

The hv_cpu parameter to this function isn't used.  Couldn't it be removed? =
Perhaps there's a
case for making the function API more parallel to vmbus_message_sched(), bu=
t in my judgment
that's not enough value to warrant passing an unneeded parameter.

>  {
>  	unsigned long *recv_int_page;
>  	u32 maxbits, relid;
> +	union hv_synic_event_flags *event;
>=20
> -	/*
> -	 * The event page can be directly checked to get the id of
> -	 * the channel that has the interrupt pending.
> -	 */
> -	void *page_addr =3D hv_cpu->hyp_synic_event_page;
> -	union hv_synic_event_flags *event
> -		=3D (union hv_synic_event_flags *)page_addr +
> -					 VMBUS_MESSAGE_SINT;
> +	if (!event_page_addr)
> +		return;
> +	event =3D (union hv_synic_event_flags *)event_page_addr + VMBUS_MESSAGE=
_SINT;
>=20
>  	maxbits =3D HV_EVENT_FLAGS_COUNT;
>  	recv_int_page =3D event->flags;
> @@ -1318,26 +1325,40 @@ static void vmbus_chan_sched(struct hv_per_cpu_co=
ntext *hv_cpu)
>  	}
>  }
>=20
> -static void vmbus_isr(void)
> +static void vmbus_message_sched(struct hv_per_cpu_context *hv_cpu, void =
*message_page_addr)
>  {
> -	struct hv_per_cpu_context *hv_cpu
> -		=3D this_cpu_ptr(hv_context.cpu_context);
> -	void *page_addr;
>  	struct hv_message *msg;
>=20
> -	vmbus_chan_sched(hv_cpu);
> -
> -	page_addr =3D hv_cpu->hyp_synic_message_page;
> -	msg =3D (struct hv_message *)page_addr + VMBUS_MESSAGE_SINT;
> +	if (!message_page_addr)
> +		return;
> +	msg =3D (struct hv_message *)message_page_addr + VMBUS_MESSAGE_SINT;
>=20
>  	/* Check if there are actual msgs to be processed */
>  	if (msg->header.message_type !=3D HVMSG_NONE) {
>  		if (msg->header.message_type =3D=3D HVMSG_TIMER_EXPIRED) {
>  			hv_stimer0_isr();
>  			vmbus_signal_eom(msg, HVMSG_TIMER_EXPIRED);
> -		} else
> +		} else {
>  			tasklet_schedule(&hv_cpu->msg_dpc);
> +		}
>  	}
> +}
> +
> +static void vmbus_isr(void)
> +{
> +	struct hv_per_cpu_context *hv_cpu
> +		=3D this_cpu_ptr(hv_context.cpu_context);
> +
> +	/*
> +	 * Suggested-by: Michael Kelley <mhklinux@outlook.com>
> +	 * One possible optimization would be to keep track of the largest relI=
D that's in use,
> +	 * and only scan up to that relID.
> +	 */

I'd put this comment in vmbus_chan_sched() just before the "for_each_set_bi=
t()"
loop. That's the loop that is doing the scanning.

> +	vmbus_chan_sched(hv_cpu, hv_cpu->hyp_synic_event_page);
> +	vmbus_chan_sched(hv_cpu, hv_cpu->para_synic_event_page);
> +
> +	vmbus_message_sched(hv_cpu, hv_cpu->hyp_synic_message_page);
> +	vmbus_message_sched(hv_cpu, hv_cpu->para_synic_message_page);
>=20
>  	add_interrupt_randomness(vmbus_interrupt);
>  }
> @@ -1355,6 +1376,60 @@ static void vmbus_percpu_work(struct work_struct *=
work)
>  	hv_synic_init(cpu);
>  }
>=20
> +static int vmbus_alloc_synic_and_connect(void)
> +{
> +	int ret, cpu;
> +	struct work_struct __percpu *works;
> +	int hyperv_cpuhp_online;
> +
> +	ret =3D hv_synic_alloc();
> +	if (ret < 0)
> +		goto err_alloc;
> +

Extra blank line here.

> +
> +	works =3D alloc_percpu(struct work_struct);
> +	if (!works) {
> +		ret =3D -ENOMEM;
> +		goto err_alloc;
> +	}
> +
> +	/*
> +	 * Initialize the per-cpu interrupt state and stimer state.
> +	 * Then connect to the host.
> +	 */
> +	cpus_read_lock();
> +	for_each_online_cpu(cpu) {
> +		struct work_struct *work =3D per_cpu_ptr(works, cpu);
> +
> +		INIT_WORK(work, vmbus_percpu_work);
> +		schedule_work_on(cpu, work);
> +	}
> +
> +	for_each_online_cpu(cpu)
> +		flush_work(per_cpu_ptr(works, cpu));
> +
> +	/* Register the callbacks for possible CPU online/offline'ing */
> +	ret =3D cpuhp_setup_state_nocalls_cpuslocked(CPUHP_AP_ONLINE_DYN, "hype=
rv/vmbus:online",
> +						   hv_synic_init, hv_synic_cleanup);
> +	cpus_read_unlock();

There's a subtle problem here. As soon as the lock is released, there could=
 be
vCPUs that start coming online (started by the udev daemon), and running
hv_synic_init(). My assumption is that hv_synic_init() might fail if this i=
nvocation
of vmbus_alloc_synic_and_connect() is trying to determine if Confidential V=
MBus
is supported. A failure will abort the new CPU coming online. That suggests=
 that
hv_synic_init() should not return an error in the case where initializing t=
he paravisor
SynIC doesn't work.

> +	free_percpu(works);
> +	if (ret < 0)
> +		goto err_alloc;
> +	hyperv_cpuhp_online =3D ret;
> +
> +	ret =3D vmbus_connect();

When doing vmbus_alloc_synic_and_connect() the first time with "is_confiden=
tial"
set to "true", where exactly does the failure occur if the paravisor doesn'=
t support
Confidential VMBus? Since your patches add machinery to detect MSR accesses
against the paravisor that fail, I'm presuming hv_synic_init() will fail fo=
r all vCPUs.
But the error return from hv_synic_init() isn't checked (except as I mentio=
ned above
for cpuhp_setup_state). So evidently the failure is detected in vmbus_conne=
ct() when
vmbus_negotiate_version() sends the INITIATE_CONTACT message. And presumabl=
y
sending the message fails because there's no way to wait for a failure resp=
onse since
the SynICs didn't initialized. So is it the HV_POST_MESSAGE hypercall that =
is the
exact point of failure, and if so, what error status is returned? It looks =
like
vmbus_post_msg() would output an error message. Or is there some other fail=
ure
point that I'm missing?

I ask because there's a lot of work done before the failure is detected. Ea=
ch
vCPU must try to initialize their paravisor SynIC and fail. Then each CPU d=
oes
hv_synic_cleanup() as part of cpuhp_remove_state(). Workqueues are created
in vmbus_connect(), and memory is allocated, all of which must be cleaned
up. Then everything is retried with "is_confidential" set to "false". Do yo=
u have
any sense of how much elapsed time it takes to get the initial failure and =
then
cleanup? Consider the case with a large number of vCPUs, all of which must
run hv_synic_init() and then hv_synic_cleanup(). See commit 87c9741a38c4
where this elapsed time was a concern in large VMs.

Can the failure be detected earlier by doing a simple MSR read against
the paravisor for an MSR that's only available if Confidential VMBus is
implemented? Then "is _confidential" could be set correctly before
all the work is done, and the work would only be done once even
if Confidential VMBus isn't supported.

> +	if (ret)
> +		goto err_connect;
> +	return 0;
> +
> +err_connect:
> +	cpuhp_remove_state(hyperv_cpuhp_online);
> +	return -ENODEV;
> +err_alloc:
> +	hv_synic_free();
> +	return -ENOMEM;
> +}
> +
>  /*
>   * vmbus_bus_init -Main vmbus driver initialization routine.
>   *
> @@ -1365,8 +1440,7 @@ static void vmbus_percpu_work(struct work_struct *w=
ork)
>   */
>  static int vmbus_bus_init(void)
>  {
> -	int ret, cpu;
> -	struct work_struct __percpu *works;
> +	int ret;
>=20
>  	ret =3D hv_init();
>  	if (ret !=3D 0) {
> @@ -1401,41 +1475,21 @@ static int vmbus_bus_init(void)
>  		}
>  	}
>=20
> -	ret =3D hv_synic_alloc();
> -	if (ret)
> -		goto err_alloc;
> -
> -	works =3D alloc_percpu(struct work_struct);
> -	if (!works) {
> -		ret =3D -ENOMEM;
> -		goto err_alloc;
> -	}
> -
>  	/*
> -	 * Initialize the per-cpu interrupt state and stimer state.
> -	 * Then connect to the host.
> +	 * Attempt to establish the confidential VMBus connection first if this=
 VM is
> +	 * a hardware confidential VM, and the paravisor is present.
>  	 */
> -	cpus_read_lock();
> -	for_each_online_cpu(cpu) {
> -		struct work_struct *work =3D per_cpu_ptr(works, cpu);
> +	ret =3D -ENODEV;
> +	if (ms_hyperv.paravisor_present && (hv_isolation_type_tdx() || hv_isola=
tion_type_snp())) {
> +		is_confidential =3D true;
> +		ret =3D vmbus_alloc_synic_and_connect();
> +		is_confidential =3D !ret;
>=20
> -		INIT_WORK(work, vmbus_percpu_work);
> -		schedule_work_on(cpu, work);
> +		pr_info("VMBus is confidential: %d\n", is_confidential);
>  	}
>=20
> -	for_each_online_cpu(cpu)
> -		flush_work(per_cpu_ptr(works, cpu));
> -
> -	/* Register the callbacks for possible CPU online/offline'ing */
> -	ret =3D cpuhp_setup_state_nocalls_cpuslocked(CPUHP_AP_ONLINE_DYN, "hype=
rv/vmbus:online",
> -						   hv_synic_init, hv_synic_cleanup);
> -	cpus_read_unlock();
> -	free_percpu(works);
> -	if (ret < 0)
> -		goto err_alloc;
> -	hyperv_cpuhp_online =3D ret;
> -
> -	ret =3D vmbus_connect();
> +	if (!is_confidential)
> +		ret =3D vmbus_alloc_synic_and_connect();
>  	if (ret)
>  		goto err_connect;
>=20
> @@ -1451,9 +1505,6 @@ static int vmbus_bus_init(void)
>  	return 0;
>=20
>  err_connect:
> -	cpuhp_remove_state(hyperv_cpuhp_online);
> -err_alloc:
> -	hv_synic_free();
>  	if (vmbus_irq =3D=3D -1) {
>  		hv_remove_vmbus_handler();
>  	} else {
> --
> 2.43.0


