Return-Path: <linux-arch+bounces-12898-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD984B0E2F7
	for <lists+linux-arch@lfdr.de>; Tue, 22 Jul 2025 19:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08D673B3BE6
	for <lists+linux-arch@lfdr.de>; Tue, 22 Jul 2025 17:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E8C283683;
	Tue, 22 Jul 2025 17:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="EsujaN42"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2033.outbound.protection.outlook.com [40.92.40.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7C1191493;
	Tue, 22 Jul 2025 17:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.40.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753206329; cv=fail; b=WvH2j7Y/betSsAnQRFAZaWCgO395yMbk78jOHTm1ImqEVOrogTMXE7yMh782SnAZZuyawRpcbp8cxJYLF1/ZuHqW+v8qxdbo6a2kCDVUqU6FWYh3kEWwD2vvyid/z/bUKG2GoX2GVzjehiU3ejP3K6P6WnD49IN6OAikWGTTHb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753206329; c=relaxed/simple;
	bh=D0Uryf5xnZse6+fmoA9kkp0P89uhjhA9JaWK+fSiQ24=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jcFGKmVqKziT03mtDSc7fR09Fg9IJg1eKSIlrxt4iTt7CqkfG310oKSc7bYrkNZ6VsJIOFKNpzUPA+VPe1z/azFzFUJs7ACMtfYLa3LHjC5hY/SvjJ/2ocemVcI07fTTCtszLpGE7QFbwhfW0GLlGdNHia03J9JgyUhf5ZAtBY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=EsujaN42; arc=fail smtp.client-ip=40.92.40.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jlX9fdx963/MpNy5L9D9mWK+cfTw/6GvE/w6jOo9H0suGZu1YLpQmNMdju/V3OZx9/ZFdPPiSt5f9I3cZVBnnD03mVSjl5vFvvT9BrPz0h/GF997R/QmBoh+eamFpsjA20cZNQGVJ9nfA8pmrIR5n4nJm2Vhgndyxq/+g4kTfab8pjMVdAHcxmw6zzUIxuus6x+tQgFo19Pj3hbKIOx+F0y10dXBLvKECHNGvs451+WAa+nl7k+9qrR7D+CZn9p/aymOrJIpFvmADWSycXTJNRTtMvhK88URercE1IYLHxWk9Z2Qy4rDnGYinxm+tiZcFyHwLWqbXHWlh3jcfaIzKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cYSUoX2Y43OOeoDuKBMKxUgyF5D0W7Lz4jdwFUkTErE=;
 b=oCHRgBUX/i6uBR+s1va4C79j2UNxwIiDxZ/fUmg93lFd0zax2434yM1//EMeWnoN9uZPljd7Fxa1LbA6LGwuP+yRqAtPYBj+GDZEwjSYTjFsj1tXbTG8w3Xmh1D1ZJVwV7W7i2YteVQRiOSvepruCm82NCYNTTfR6Wf6O2GdO7t/1bwAwraziEMD0XVD26WhAm0kfIpG8Pbq4UrTp3zogsSQNF9RedUD8Mx856DJIaIta8h/KMN/Gr1KKe70wa6xn+eGTWODxPVmSvu9snUbVtDEJG1gjMdtbHlqcdTt2+ksQUqUsEDzI5BHzRCxMG2CbTaHZHYkwyg1lQskcKRK8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cYSUoX2Y43OOeoDuKBMKxUgyF5D0W7Lz4jdwFUkTErE=;
 b=EsujaN42OK2CTtIsTdOWiW38l5YJKo4+4x+hHJTuUgiO5xvCvXYVZmtvG/H5xWUgex23eLM0KER53FWFvFT3fKq4fvHTpef2QHxVDGInBp07LVQ931okSA/xOs1cWfVxz/elK59Lfyuq4UpMmsP6ix8nBMTvdYM9zVXRya/KqFiurqZaYgr9z28230q2A3PNCxi9DVL3TYjfqwLeNowgubK6gRHzNoVo9x6g0+pq72S5blz/JVqBNcjm/F92CuWDy0cL8eos1WWSyS3vkcpslEVqQFcGHaAwkcBYfubF2cj0Y0ik4/DILaOvdkwP54GbYznIs9c5OWfF8qf298UM8g==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CY8PR02MB9201.namprd02.prod.outlook.com (2603:10b6:930:9c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.28; Tue, 22 Jul
 2025 17:45:22 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 17:45:22 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Roman Kisel <romank@linux.microsoft.com>, "alok.a.tiwari@oracle.com"
	<alok.a.tiwari@oracle.com>, "arnd@arndb.de" <arnd@arndb.de>, "bp@alien8.de"
	<bp@alien8.de>, "corbet@lwn.net" <corbet@lwn.net>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"decui@microsoft.com" <decui@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"kys@microsoft.com" <kys@microsoft.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "rdunlap@infradead.org" <rdunlap@infradead.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "Tianyu.Lan@microsoft.com"
	<Tianyu.Lan@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>
CC: "apais@microsoft.com" <apais@microsoft.com>, "benhill@microsoft.com"
	<benhill@microsoft.com>, "bperkins@microsoft.com" <bperkins@microsoft.com>,
	"sunilmut@microsoft.com" <sunilmut@microsoft.com>
Subject: RE: [PATCH hyperv-next v4 15/16] Drivers: hv: Support establishing
 the confidential VMBus connection
Thread-Topic: [PATCH hyperv-next v4 15/16] Drivers: hv: Support establishing
 the confidential VMBus connection
Thread-Index: AQHb9QzdCSSjuBw3YkCOrMrpQQy8+bQ4xuXA
Date: Tue, 22 Jul 2025 17:45:22 +0000
Message-ID:
 <SN6PR02MB4157D6952FF8830EB97126B4D45CA@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250714221545.5615-1-romank@linux.microsoft.com>
 <20250714221545.5615-16-romank@linux.microsoft.com>
In-Reply-To: <20250714221545.5615-16-romank@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CY8PR02MB9201:EE_
x-ms-office365-filtering-correlation-id: 1abde113-4bde-4b56-7671-08ddc9478871
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799012|461199028|41001999006|40105399003|3412199025|440099028|12091999003|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?5IStYMsjYbVLVDaI5G1gpynXBbXraGKZ/XFxGY9SNPPcNXS/GDWl1vbkKgEB?=
 =?us-ascii?Q?IR3sPBbwSrjDRbMbdMN6iaF9gncH8saA+fbGCs3Q8LyYotdpLVu1UgKLf5pv?=
 =?us-ascii?Q?9W4oOIOoaWg09qWEIcIbq/flwLbGDwDnDOqoqBeEdzwBGLGW93IzE5Je9RAF?=
 =?us-ascii?Q?bbim5aunRspkJePMqBJbutan+K7U3NdFxAiIecQ9q64DKZrPCc1j9k6WKCR6?=
 =?us-ascii?Q?7nks476gpU7DCG/Y0+E/a/o5ticAr8HxTCvqTP2+hJHlrbiGW9UiZon3yP0Y?=
 =?us-ascii?Q?QMsGuPdt8leUh/ZZMvzehPaY6WXHr2QwtC03DHdrsgpQnp+3+tM0x1/B2dmn?=
 =?us-ascii?Q?q5Orc+Se+0ubSU3AoSQG3fe9hjY9U7CWAQq9WQkj/Sc3LdHuRc1rqtaSJnPL?=
 =?us-ascii?Q?b5u6hRGXNZM8GFy77Gj9pu7Ee713lzLX2G6Ssz+pfFQ6cYAg6pySNA+FRr2J?=
 =?us-ascii?Q?yj6EFPXE/9HWAMQNVvTupUIDjPd8P3vgrhjldMEB6d9xLgzSwQ1EnAWXinDA?=
 =?us-ascii?Q?p569Pz0l116itF1An5cwkbo0bHuh4WRAF1tsV9gxaTF8iyKBs/vC1o78xZ2X?=
 =?us-ascii?Q?IQbLhNQWPPC2tS5ua7O2cQtPMWZsb3LidBe5/cFftmSREhT/DipVVxdMezFd?=
 =?us-ascii?Q?xkUma9dWVr4hM6ymOl6Tzbk3v08T1BBvylZoF1kNi2z+9Kge3k0eFHW7CGzx?=
 =?us-ascii?Q?FN2hVk+FW8tQknWZYWwOYi7hQaPlzkYMmysxnqkQGZMgWP5r5XYnGtyv8P8R?=
 =?us-ascii?Q?2DJlQQvwVznYqQyNe6s16T04Dk85QQWBA9cqDM4KP3bVCEPDzf2jVmghWcgb?=
 =?us-ascii?Q?2dxxhZqmybbJLGVOLdC38V/jcD7aUsxX3KhL1sJOWyJV/M/6l71Zs3igWV1J?=
 =?us-ascii?Q?aLmXpNJJbQsyQNfzGsyE+PpB0wGOtH7032vYBtHVIurkbtTpyKngFytBfQ3V?=
 =?us-ascii?Q?U+1NENa1lsKArOCfIhS6PEz48U3o45JzO32AqXpT+oBKx6p0iCAj0pklmxpU?=
 =?us-ascii?Q?e6YdYdQT1urFThJmfcoDoZdy0ticI3C33SYaB6oo8kAJ2ZtA1Bi7RbVX1l+0?=
 =?us-ascii?Q?49vyACv1ALfexBhqELTso2UGfeWSIg=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?mBhLWjgY6H07QlOrU4NePl7QA7IN29ulxmbMHMVd98s4XdtxNeSXnGYtupY6?=
 =?us-ascii?Q?L0NOb22liOUc/7Mzhw7p4KIHeU8n/hOmxe5VPS7vfWcSk8MXM0OvfnPWULA/?=
 =?us-ascii?Q?XUz75unvZrkz6Q6z7M9ShcnzkM123Snkmfjt9fIFMuJ2Ofala6WxUiKEuUgg?=
 =?us-ascii?Q?K1GPeKS1aRH6Ma7zVSplrjTEX6g6miVeyGD9CifStXdbh/o1yl1D5JlXJQJt?=
 =?us-ascii?Q?LnCmMKKAAr57GHRXOm6jYnbihyAydh7+3LEwE6Okf1IJEAMQqHYhMMRmhyNe?=
 =?us-ascii?Q?Of2kwQlwxBrEHsFfjTvoy4GzqXbseT9se+ZNf1igiqyU52p/bRiT9sUyDaKF?=
 =?us-ascii?Q?zQ+ARtaaus73KogHlk60Hkd2QmU6yeJ84oZ/Gn3jlYtUgcH0WsaL/w0FBrpA?=
 =?us-ascii?Q?evuNeu66wKvGMl9Kxscfg3mAekisXvFWJsltXcFzGfAqRBp9kRNrhbfhCEz5?=
 =?us-ascii?Q?4npfbrATJ8NSNHeVbaAqBkf2FWpAEW+avOu5IKdxZy/SzHkJB9MDTTXwSlC8?=
 =?us-ascii?Q?xdDU2JtixzjxLz3WSqfHLczg7BNSdAED9cDYrR3EOpBmKUHx9TDJKmbgiod8?=
 =?us-ascii?Q?Wjip7YQ3Tu8AjPVa+j8Rwd0syZdQZzmIDIZ6OFpsLS4Naajv9jUcFlXu9eaY?=
 =?us-ascii?Q?xE1oPWHQ70CDuUyVT5Z3uWHU8IvWfjh8/RERBnJaO+nBI8Dmc80ulIe9vUX2?=
 =?us-ascii?Q?oxNIQLwuoeujjrMcyNY8JPLNZ0iPYmFSRNJEA0BnAJteRsI7FL8Hk+6yH9tj?=
 =?us-ascii?Q?wP/II5nkj4G3jrI1fWMLy83lQkwBumG7ReNFLF9QRsJTxvcjUclZmzQ+zbsG?=
 =?us-ascii?Q?prc091s/2h1JnQYslOOQJDoTPoari6i6HhdwjSBSHbXM/Sn4XVbBXmhjYPfm?=
 =?us-ascii?Q?0zhejJHGYnS1vyb3zlCD+MFtfPS+HpE77cbFmKSk6NCV3GYj8cmVYLjv64Ru?=
 =?us-ascii?Q?DUENLSm0Bosje1pehL9zz9g+BOG1D6VShzZZoqOGy7dd0Nn/XTm2OYbrijRL?=
 =?us-ascii?Q?wRzDCuOzXVEgygGRfyAE4o6XAfAaS8u89qFhNBE3G3R5tt3a+okguOMuPvSY?=
 =?us-ascii?Q?XHAycQVtXbxlyNecY7IMFxT7G1MTcMbfLhZwLlGfH73/y7WwI7OJE7FBRTNB?=
 =?us-ascii?Q?i2d74JuGCt8dBYBiZnKp3aTU+Nwysg+khTAvYDPfa/GyWNeGI7wyiV1M5GZx?=
 =?us-ascii?Q?2cMoTAXNspF6bu7w9HqfJgIOenma8W/l4J92kjkOh4t2xXzeb1n61wwUYV0?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1abde113-4bde-4b56-7671-08ddc9478871
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2025 17:45:22.5148
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR02MB9201

From: Roman Kisel <romank@linux.microsoft.com> Sent: Monday, July 14, 2025 =
3:16 PM
>=20
> To establish the confidential VMBus connection the CoCo VM guest
> first attempts to connect to the VMBus server run by the paravisor.
> If that fails, the guest falls back to the non-confidential VMBus.
>=20
> Implement that in the VMBus driver initialization.
>=20
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>

See some spelling/formatting nits below, plus a comment about
your 5 scenarios. Those notwithstanding,
Reviewed-by: Michael Kelley <mhklinux@outlook.com>

> ---
>  drivers/hv/vmbus_drv.c | 189 ++++++++++++++++++++++++++++-------------
>  1 file changed, 130 insertions(+), 59 deletions(-)
>=20
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 13aca5abc7d8..53be3157e22c 100644
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
> @@ -1233,21 +1242,19 @@ static void vmbus_force_channel_rescinded(struct =
vmbus_channel *channel)
>  #endif /* CONFIG_PM_SLEEP */
>=20
>  /*
> - * Schedule all channels with events pending
> + * Schedule all channels with events pending.
> + * The event page can be directly checked to get the id of
> + * the channel that has the interrupt pending.
>   */
> -static void vmbus_chan_sched(struct hv_per_cpu_context *hv_cpu)
> +static void vmbus_chan_sched(void *event_page_addr)
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
> @@ -1255,6 +1262,11 @@ static void vmbus_chan_sched(struct hv_per_cpu_con=
text *hv_cpu)
>  	if (unlikely(!recv_int_page))
>  		return;
>=20
> +	/*
> +	 * Suggested-by: Michael Kelley <mhklinux@outlook.com>
> +	 * One possible optimization would be to keep track of the largest relI=
D that's in use,
> +	 * and only scan up to that relID.
> +	 */
>  	for_each_set_bit(relid, recv_int_page, maxbits) {
>  		void (*callback_fn)(void *context);
>  		struct vmbus_channel *channel;
> @@ -1318,26 +1330,35 @@ static void vmbus_chan_sched(struct hv_per_cpu_co=
ntext *hv_cpu)
>  	}
>  }
>=20
> -static void vmbus_isr(void)
> +static void vmbus_message_sched(struct hv_per_cpu_context *hv_cpu, void
> *message_page_addr)
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
> +	vmbus_chan_sched(hv_cpu->hyp_synic_event_page);
> +	vmbus_chan_sched(hv_cpu->para_synic_event_page);
> +
> +	vmbus_message_sched(hv_cpu, hv_cpu->hyp_synic_message_page);
> +	vmbus_message_sched(hv_cpu, hv_cpu->para_synic_message_page);
>=20
>  	add_interrupt_randomness(vmbus_interrupt);
>  }
> @@ -1355,6 +1376,59 @@ static void vmbus_percpu_work(struct work_struct *=
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
> +	free_percpu(works);
> +	if (ret < 0)
> +		goto err_alloc;
> +	hyperv_cpuhp_online =3D ret;
> +
> +	ret =3D vmbus_connect();
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
> @@ -1365,8 +1439,7 @@ static void vmbus_percpu_work(struct work_struct *w=
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
> @@ -1401,41 +1474,42 @@ static int vmbus_bus_init(void)
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
> +	 *
> +	 * All scenarios here are:
> +	 *	1. No paravisor,

Inconsistent indentation.

Also, isn't there a "No paravisor, with hardware isolation" scenario? We've
called this "fully enlightened guest" in the past, and code has gone into t=
he
kernel to at least partially support this. The scenario is supported by the
hardware and by Linux guests on other hypervisors. But I'm unsure of the
status on Hyper-V.

> +	 *  2. Paravisor without VMBus relay, no hardware isolation,
> +	 *  3. Paravisor without VMBus relay, with hardware isolation,
> +	 *  4. Paravisor with VMBus relay, no hardware isolation,
> +	 *  5. Paravisor with VMBus relay, with hardware isolation.
> +	 *
> +	 * In the cloud, scenarios 1, 4, 5 are most common, and outside the clo=
ud,
> +	 * scenario 1 should be the most common at the moment. Detecting of the=
 Confidential
> +	 * VMBus support below takes that into account running `vmbus_alloc_syn=
ic_and_connect()`
> +	 * only once (barring any faults not related to VMBus) in these cases. =
That is true
> +	 * for the scenario 2, too, albeit it might be not as feature-rich as 1=
, 4, 5.
> +	 *
> +	 * However, the code will be doing much more work in scenario 3 where i=
t will have to
> +	 * first initialize lots of structures for every CPU only to likely tea=
r them down later
> +	 * and start again, now without attempting to use Confidential VMBus, t=
hus taking a
> +	 * performance hit. Such systems are rather uncomoon today, don't suppo=
rt more than

s/uncomoon/uncommon/

> +	 * ~300 CPUs, and are rarely used with many dozens of CPUs. As the time=
 goes on, that
> +	 * will be even less common. Hence, the preference is to not specialize=
 the code for
> +	 * that scenario.
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
> @@ -1451,9 +1525,6 @@ static int vmbus_bus_init(void)
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


