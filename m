Return-Path: <linux-arch+bounces-7338-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA14097A729
	for <lists+linux-arch@lfdr.de>; Mon, 16 Sep 2024 20:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1F1B1C2345E
	for <lists+linux-arch@lfdr.de>; Mon, 16 Sep 2024 18:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533A115D5CF;
	Mon, 16 Sep 2024 18:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="SDHG7pqC"
X-Original-To: linux-arch@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazolkn19010008.outbound.protection.outlook.com [52.103.11.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8B715CD58;
	Mon, 16 Sep 2024 18:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.11.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726510514; cv=fail; b=VAO74z+5JM0JQ7cGXz/BIRrBXWbCzmf/lnEZNYhzGrmlZQ51xcH01qr4r+ZoKfhBIBDamoI6SrZZXJ82baM/tMEn47vVzGVnlIswZVqt9ONaAkrAtVPxq7kBXb7pCvUDQXtOgKAO1K4ufi5CTC6eSw2Pk1xPtYpTfC8+2Mqti2A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726510514; c=relaxed/simple;
	bh=IWHm6XGfqQoYV7LLkg2QKXHfmv7BIAyEZdNHxJLbprs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=H9XRoDQ+NaxaWZPWvjHsF2mEJMP/y/7T6PDkDSgXhnjGdNIwZ5LIZfBkn4ERTKny1UF4dnD2txg9PRhk0Z9P4Q4yrO9ux9GyeGHydKlSEva5sGw7wRWdTCThniu1pJAfRj4bNVcHSNtZO+7jQNsLPFxLhLbzTiSCH5gjOxV8shw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=SDHG7pqC; arc=fail smtp.client-ip=52.103.11.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TmcQTt3/9scigSXoiffYxTixYt8LskGDyKJ22F95ZqDgVav+OaAhZe7KJYQ6Iy2uaPFj2s4QJePuqjnKwGvj8F2KNivivE70GKk11tL1asp5S0JaiX9EUAnpeuiK++0oXTwOFbt5RP1cMJurZMadmWNRBYbr+ohLujQMYuaZnbZeAPlD1F2IjeyDK4DC69TwFFSwFfU524WD5TbUDxc8TkSHop6m6be4OMzW3K1+6AIjJQ1teU/A2BRC7LZNZbx8dxnL+GBoIB7+S0cbYfXmNL0tyId98qEaC+Xc1hegHjpeBwV3JYnMeG83D4EpNkMRVoJU5ozbRBYlTzN+sAM68g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w80hOrjOSHnvDzUmGg4avaGlDIV2stvDov/1qwlEwVw=;
 b=FT8XjeDPgqqjs6LkrgrddKkAWDpL87HhOYiRP0auDR91cRrt1r5AojKGPRjCXQ5GXzjtJ5NZkWViyx654OUaVjDWHt8W+62/4/8Gr5npAwc68DyWOmtHhO3fd96m4cP87envt2QlqX0e5YjP/VYNquCCk62+ZWBQeOoMsrlUulOs0jYpw+KVKmdY6KskfJegVfsChXpXdHYJ3KD1HkRCaZR/FwuafZw18ClZtJFWhFhEjRV7LDfwFA01O+wj1jPCt2xJkLyoj6vEz6OyF3jS0446+HcjVWgnik4Y9UUgsx/l3JqkfWAxc5Wci1dmXYnrgeDgpxNCOTnTw6vHKYf92A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w80hOrjOSHnvDzUmGg4avaGlDIV2stvDov/1qwlEwVw=;
 b=SDHG7pqC00gcbeJbCzbI735JkHptMKpq7BXfDag502xly+vi5x3lxAvlKRlCDv+xfuex5sZEtVkaSDJpIsq477plwZ/xF3X37+2mKVjpOlRIcmT75IWMQajmjWfbtvtinOfrCC9S6FlHU7gpQxkYQtaLeflmd+LkAdhB44jxk+cg0ASsu3wYLr4T+CJE7oTwvhfbQUdXuyCtZ+fpgv8EScEyS2iQf9uJPk6WSX0Mve0ISQwu84z6PRQxo0M7rM3wQ74NuDvSlsJRKm3z85XvTWxSIcW/nZM9uleZKL34oy3yugz/opKnSSMr8bLYf+nf7cV4TXShJPvvWZdGOig4GA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by PH0PR02MB7128.namprd02.prod.outlook.com (2603:10b6:510:17::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Mon, 16 Sep
 2024 18:15:05 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.7939.022; Mon, 16 Sep 2024
 18:15:04 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Michael Kelley <mhklinux@outlook.com>, "kys@microsoft.com"
	<kys@microsoft.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "decui@microsoft.com"
	<decui@microsoft.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kw@linux.com" <kw@linux.com>, "robh@kernel.org"
	<robh@kernel.org>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"James.Bottomley@HansenPartnership.com"
	<James.Bottomley@HansenPartnership.com>, "martin.petersen@oracle.com"
	<martin.petersen@oracle.com>, "arnd@arndb.de" <arnd@arndb.de>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
CC: "maz@kernel.org" <maz@kernel.org>, "den@valinux.co.jp"
	<den@valinux.co.jp>, "jgowans@amazon.com" <jgowans@amazon.com>,
	"dawei.li@shingroup.cn" <dawei.li@shingroup.cn>
Subject: RE: [RFC 00/12] Hyper-V guests use Linux IRQs for channel interrupts
Thread-Topic: [RFC 00/12] Hyper-V guests use Linux IRQs for channel interrupts
Thread-Index: AQHatj2nF9qzOISBtEauAe73nof0crJbWNxQ
Date: Mon, 16 Sep 2024 18:15:04 +0000
Message-ID:
 <SN6PR02MB4157F39049BEFD43AE7C3731D4602@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240604050940.859909-1-mhklinux@outlook.com>
In-Reply-To: <20240604050940.859909-1-mhklinux@outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [jTMGQ6tQD3e0NL7/yiTOhnocKUjl6dAp]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|PH0PR02MB7128:EE_
x-ms-office365-filtering-correlation-id: dcbdb0f5-ef3d-408b-f6d1-08dcd67b7d01
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799006|461199028|19110799003|8060799006|56899033|102099032|440099028|3412199025|1710799026;
x-microsoft-antispam-message-info:
 Y/LQWWDChAgs1OHQ3u8/VjecoqDcJEckNYVQcvqWr/AbVKcxz10ZeJgqGols73Y0N/bUb1pBd7E+WMwRsfKT/5aA8FEYsKEl6J0MqsvE9b+EKlng45X2r+MdUF8534j3sow0tF/lX8m8lyRkhJmEWuptk0X1s6XWmp8gW0xp2IYqL4sMZqf5Cwu+bAYnS0MaaLEsJSZCJYxREdRXtR1usPIHDnBFi6FrH9Mi75IHlovBBGdlPyIAHnfQxIZhE66iXjBRO6MmSR48IDXNH7Ibghz4gGW/mqxITARKnWlq5c2w8l2diKIdAJc1mywLCUJv0bsQ1ienycpgK+ozGQQ9hJHL0hGM+JUVnxTT3nRnx9AwfHvYEnmKjdgE9cdk49czM8sRUPJJpVCY065jwug6blH7jnFqig0OK2jBttSNatatKOGSTaF1vzn+bCJUTvRoPphLlv8iwJy9ARfdAGOF/uxRrBXuy9UwWLZqvB8yXRFUWwBjriuq4/hsrjJw4ZbNmpWer1ebJKnOJNI9GV2fu3Ikt3/3euUxFRBqxqzRJZPHUKU6Y19rin1tBAMkY3tN17uUHq9CHHtaOEAXIAK84m1EKd6D+B6qfW9bepgAf+UySYLdS0LZoVZ8ShX6XhBd9Sv3Mk7qzkdm9LqjJXuWO1OPZ2lLNaF0ClqSp+B+IY2cVhhS5GbrUumFMVI3ae8B9oiNNJp3cUYw2G1gfb/uRw==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?c50FfhhtLMCTcyccujKLtbYIioDAFDgLpk9lQwpDbyH+YTJdEvPqrGsB9hnQ?=
 =?us-ascii?Q?daOpwqmXpb8YnyivSLC0ALIpdNmdLzQS7B2ZGfebfOmA1IZU0Am/aKZ0ZynW?=
 =?us-ascii?Q?Ef1Uri1LJop20uB1ZphVWbqJPP/iJtqBrqNRWtpCoMQAMM9mNTvl/IY+OE2b?=
 =?us-ascii?Q?1AN9x34pw6hkA53v/gmJfx12xRMt1KQ3/emMoTtHdZaNWCQWcIu+zvpogCIF?=
 =?us-ascii?Q?0Y/pc1VXtWEl3kNLO5Nh5yMFfLoTAWeU3iYyErvOCv72HZ8g9Pc1Wa7ldEcr?=
 =?us-ascii?Q?LkN5X6JSjrww28uFpGi2NHstIrtWi0JxRP6UShzrzzvnmNXzmOr/aw0nj1KJ?=
 =?us-ascii?Q?u07b41mcQegMctLwcF4oNZN847S6FU4gBLqDBGDBQOT4bOWFZNj4OMWFJM2n?=
 =?us-ascii?Q?vRQuhef3Pb9jkcL8yr0dJeP9guoUhKvo0kxou+Q9Ce2dayT2EXsCSmZLbcVX?=
 =?us-ascii?Q?zgd/sOc8Mc6eifBvdHu/squF5/g7i0CY7RLsn/3unRa86GdFPbg0R7XOvn1E?=
 =?us-ascii?Q?xzfA6HkA+ASCJqandqKVGFKetG6GaNO34k341tCnHnJzGvZwd8gBhkwOP/VU?=
 =?us-ascii?Q?1N3xfqMJODHaW7D3wJWkGSxgDyXqK/mEZ9ntbin3IfNSrMbhKcTTWB41Dw8x?=
 =?us-ascii?Q?VOWAvF70I4tDWjucPjS+hpmWQDuiTuhQylsOFbkrvSPczj3QhC1YQ4dmK+sp?=
 =?us-ascii?Q?dx8gHT/R0PgKUAuLlPjybVuXDVj38LJAwVvzwGo+HwkAg1t53hybZdn2vtcy?=
 =?us-ascii?Q?+qXjRIhzQZb1fxbnUWDZa3zJ9EHaqRZ0xIEtL7y6tgGpSUj33O54lbacRCdL?=
 =?us-ascii?Q?sQA6rr8AX3Box1dQjft6lHsLQjYSS2fgw3cuIHIz6G0iQ0AhLrmec45HGSdy?=
 =?us-ascii?Q?OppWN5rsWHwW2E6rpCkywlQOxCPeJn7N8K3LHgbaVEEoATHg2cJP3G3peFnE?=
 =?us-ascii?Q?H947jOXOt5nuSdUepRmQqK1XkUdNaX0MSxtrYFbuGxOv1K3llIRK+NTHgJDB?=
 =?us-ascii?Q?PtAAXlB4ncBtwY7lfN72lwvJRsR+RquTvItvEcGtyV7KU56cmIcQM53CgVom?=
 =?us-ascii?Q?QfJDGLFYQU4x5k8KT6A1n/AFVurGhEQzM//vAS1mJcNX2qW1NfNeUssLxXVD?=
 =?us-ascii?Q?16RaYk/bXfFWNBKDZCFCJF1bb5oEf3vVc1cvvJDc4SNUjr4NrVtPkqeqsH+C?=
 =?us-ascii?Q?24U3YbGU4TnpPtvizEfqPil491GL7SaSrpXOnv4ssXLUOEtkjjoXlVb5Usg?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: dcbdb0f5-ef3d-408b-f6d1-08dcd67b7d01
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2024 18:15:04.5801
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7128

From: mhkelley58@gmail.com <mhkelley58@gmail.com> Sent: Monday, June 3, 202=
4 10:09 PM
>=20
> This patch set makes significant changes in how Linux guests running on H=
yper-V
> handle interrupts from VMBus devices. It's "RFC" because of the level of =
change,
> and because I'm interested in macro-level feedback on the whole idea. The=
 usual
> detailed-level code review feedback is also welcome.

I want to get back to this RFC patch set and incorporate the changes
suggested by Thomas Gleixner. But before I do that, is there any high-level
feedback on whether the whole idea should be pursued at all? I think there'=
s
value in having the VMBus devices appear in a standard way in /proc/irq, so
that we can eventually get away from the custom stuff in /sys/bus/vmbus.
It also makes VMBus devices show up in a way similar to virtio devices. But
on the flip side, it's churn to code that's already working well. And havin=
g
VMBus devices appear in /proc/irq means they are visible to user space util=
ities
like irqbalance, giving them the ability to affect performance (particularl=
y for
networking). As such, this patch set has implications beyond just the Linux
kernel, and probably means disabling irqbalance by default in Azure cloud
images.

I'm especially interested in input from Microsoft folks, since the changes
are specific to Hyper-V, with implications for the Azure cloud.

Michael

>=20
> Background
> ----------
> Linux guests running on Hyper-V are presented with a range of synthetic
> devices, including storage, networking, mouse, keyboard, etc. Guests are =
also
> presented with management-related pseudo-devices, including time
> synchronization, heartbeat, and host-initiated shutdown. These devices us=
e the
> VMBus connection between the host and the guest, and each device has one =
or
> more VMBus channels for passing messages between the host and guest.
> Separately, a control path exists for creating and tearing down VMBus cha=
nnels
> when needed. Hyper-V VMBus and its synthetic devices play a role similar =
to
> virtio and virtio devices.
>=20
> The host interrupts the guest when it sends a new message to the guest in=
 an
> otherwise empty channel, and when it sends a new control message to the g=
uest.
> All interrupts are multiplexed onto a single per-CPU architectural interr=
upt as
> defined by the processor architecture. On arm64, this architectural inter=
rupt
> is a PPI, and is represented in Linux as a Linux per-CPU IRQ. The x86/x64
> architecture does not provide per-CPU interrupts, so Linux reserves a fix=
ed x86
> interrupt vector (HYPERVISOR_CALLBACK_VECTOR) on all CPUs, with a hard-co=
ded
> interrupt handler. No Linux IRQ is assigned on x86/x64.
>=20
> The interrupt handler for the architectural interrupt is the VMBus interr=
upt
> handler, and it runs whenever the host generates an interrupt for a chann=
el or
> a control message. The VMBus interrupt handler consults data structures
> provided by the per-CPU Hyper-V synthetic interrupt controller (synic) to
> determine which channel or channels have a pending interrupt, or if there=
 is a
> pending control message. When doing this demultiplexing, the VMBus interr=
upt
> handler directly invokes the per-device handlers, and processes any contr=
ol
> messages.
>=20
> In this scheme, the individual VMBus devices and their channels are not
> modelled as Linux IRQs. /proc/interrupts shows counts for the top-level
> architectural interrupt, but not for the individual VMBus devices. The VM=
Bus
> driver has implemented separate reporting of per-device data under /sys.
> Similarly, /proc/irq/<nn> does not show affinity information for individu=
al
> VMBus devices, and the affinity cannot be changed via /proc/irq. Again, a
> separate interface under /sys is provided for changing the vCPU that a VM=
Bus
> channel should interrupt.
>=20
> What's New
> ----------
> Linux kernel community members have commented that it would be better for=
 the
> Hyper-V synic and the handling of VMBus channel interrupts to be modelled=
 as
> Linux IRQs. Then they would participate in existing IRQ handling mechanis=
ms,
> and not need something separate under /sys. This patch set provides such =
an
> implementation.
>=20
> With this patch set, the output of /proc/interrupts looks like this in a =
Linux
> guest on a Hyper-V x86/x64 Generation 2 VM with 8 vCPUs (the columns for
> CPUs 2 thru 5 are omitted due to text width considerations):
>=20
>            CPU0       CPU1        CPU6       CPU7
>   8:          0          0           0          0   IO-APIC   8-edge     =
 rtc0
>   9:          2          0           0          0   IO-APIC   9-fasteoi  =
 acpi
>  24:      16841          0           0          0     VMBus   7  heartbea=
t
>  25:          1          0           0          0     VMBus   9  shutdown
>  26:       6752          0           0          0     VMBus  10  timesync
>  27:          1          0           0          0     VMBus  11  vss
>  28:      22095          0           0          0     VMBus  14  pri@stor=
vsc1
>  29:          0         85           0          0     VMBus  15  pri@stor=
vsc0
>  30:          3          0           0          0     VMBus   1  balloon
>  31:        106          0           0          0     VMBus   3  mouse
>  32:         73          0           0          0     VMBus   4  keyboard
>  33:          6          0           0          0     VMBus   5  framebuf=
fer
>  34:          0          0           0          0     VMBus  13  netvsc
>  35:          1          0           0          0     VMBus   8  kvp
>  36:          0          0           0          0     VMBus  16  netvsc
>  37:          0          0           0          0     VMBus  17  netvsc
>  38:          0          0           0          0     VMBus  18  netvsc
>  39:          0          0        2375          0     VMBus  19  netvsc
>  40:          0          0           0       1178     VMBus  20  netvsc
>  41:       1003          0           0          0     VMBus  21  netvsc
>  42:          0       4337           0          0     VMBus  22  netvsc
>  43:          0          0           0          0     VMBus  23  sub@stor=
vsc1
>  44:          0          0           0          0     VMBus  24  sub@stor=
vsc0
> NMI:          0          0           0          0   Non-maskable interrup=
ts
> LOC:          0          0           0          0   Local timer interrupt=
s
> SPU:          0          0           0          0   Spurious interrupts
> PMI:          0          0           0          0   Performance monitorin=
g interrupts
> IWI:          1          0           0          2   IRQ work interrupts
> RTR:          0          0           0          0   APIC ICR read retries
> RES:        411        233         349        318   Rescheduling interrup=
ts
> CAL:     135236      29211       99526      36424   Function call interru=
pts
> TLB:          0          0           0          0   TLB shootdowns
> TRM:          0          0           0          0   Thermal event interru=
pts
> THR:          0          0           0          0   Threshold APIC interr=
upts
> DFR:          0          0           0          0   Deferred Error APIC i=
nterrupts
> MCE:          0          0           0          0   Machine check excepti=
ons
> MCP:        109        109         109        109   Machine check polls
> HYP:         71          0           0          0   Hypervisor callback i=
nterrupts
> HRE:          0          0           0          0   Hyper-V reenlightenme=
nt interrupts
> HVS:     183391     109695      181539     339239   Hyper-V stimer0 inter=
rupts
> ERR:          0
> MIS:          0
> PIN:          0          0           0          0   Posted-interrupt noti=
fication event
> NPI:          0          0           0          0   Nested posted-interru=
pt event
> PIW:          0          0           0          0   Posted-interrupt wake=
up event
>=20
> IRQs 24 thru 44 are the VMBus channel IRQs that didn't previously exist. =
Some
> devices, such as storvsc and netvsc, have multiple channels, each of whic=
h has
> a separate IRQ. The HYP line now shows counts only for control messages i=
nstead
> of for all VMBus interrupts. The HVS line continues to show Hyper-V synth=
etic
> timer (stimer0) interrupts. (In older versions of Hyper-V where stimer0
> interrupts are delivered as control messages, those interrupts are accoun=
ted
> for on the HYP line. Since this is legacy behavior, it seemed unnecessary=
 to
> create a separate Linux IRQ to model these messages.)
>=20
> The basic approach is to update the VMBus channel create/open/close/delet=
e
> infrastructure, and the VMBus interrupt handler, to create and process th=
e
> additional IRQs. The goal is that individual VMBus drivers require no cod=
e
> changes to work with the new IRQs. However, a driver may optionally annot=
ate
> the IRQ using knowledge that only the driver has. For example, in the abo=
ve
> /proc/interrupts output, the storvsc driver for synthetic disks has been
> updated to distinguish the primary channel from the subchannels, and to
> distinguish controller 0 from controller 1. Since storvsc models a SCSI
> controller, the numeric designations are set to match the "host0" and "ho=
st1"
> SCSI controllers that could be seen with "lsscsi -H -v". Similarly annota=
ting
> the "netvsc" entries is a "to do" item.
>=20
> In furtherance of the "no changes to existing VMBus drivers" goal, all VM=
Bus
> IRQs use the same interrupt handler. Each channel has a callback function
> associated with it, and the interrupt handler invokes this callback in th=
e same
> way as before VMBus IRQs were introduced.
>=20
> VMBus code creates a standalone linear IRQ domain for the VMBus IRQs. The=
 hwirq
> #'s are the VMBus channel relid's, which are integers in the range 1 to 2=
047.
> Each relid uniquely identifies a VMBus channel, and a channel interrupt f=
rom
> the host provides the relid. A mapping from IRQ to hwirq (relid) is creat=
ed
> when a new channel is created, and the mapping is deleted when the channe=
l is
> deleted, so adding and removing VMBus devices in a running VM is fully
> functional.
>=20
> Getting the IRQ counting correct requires a new IRQ flow handler in
> /kernel/irq/chip.c. See Patch 6. The existing flow handlers don't handle =
this
> case, and creating a custom flow handler outside of chip.c isn't feasible
> because the needed components aren't available to code outside of /kernel=
/irq.
>=20
> When a guest CPU is taken offline, Linux automatically changes the affini=
ty of
> IRQs assigned to that CPU so that the IRQ is handled on another CPU that =
is
> still online. Unfortunately, VMBus channel IRQs are not able to take adva=
ntage
> of that mechanism. At the point the mechanism runs, it isn't possible to =
know
> when Hyper-V started interrupting the new CPU; hence pending interrupts m=
ay be
> stranded on the old offline CPU. Existing VMBus code in Linux prevents a =
CPU
> from going offline when a VMBus channel interrupt is affined to it, and t=
hat
> code must be retained. Of course, VMBus channel IRQs can manually be affi=
ned to
> a different CPU, which could then allow a CPU to be taken offline. I have=
 an
> idea for a somewhat convoluted way to allow the automatic Linux mechanism=
 to
> work, but that will be another patch set.
>=20
> Having VMBus channel interrupts appear in /proc/irq means that user-space
> irqbalance can change the affinity of the interrupts, where previously it=
 could
> not. For example, this gives irqbalance the ability to change (and perhap=
s
> degrade) the default affinity configuration that was designed to maximize
> network throughput. This is yet another reason to disable irqbalance in V=
M
> images.
>=20
> The custom VMBus entries under /sys are retained for backwards compatibil=
ity,
> but they are integrated. For example, changing the affinity via /proc/irq=
 is
> reflected in /sys/bus/vmbus/devices/<guid>/channels/<nn>/cpu, and vice ve=
rsa.
>=20
> Patches
> -------
> The patches have been tested on x86/x64 Generation 1 and Generation 2 VMs=
, and
> on arm64 VMs.
>=20
> * Patches 1 and 2 fixes some error handling that is needed by subsequent
> patches. They could be applied independent of this patch set.
>=20
> * Patches 3,4, and 5 add support for IRQ names, and add annotations in th=
e
> storvsc and the Hyper-V vPCI driver so that descriptions in /proc/interru=
pts
> convey useful information.
>=20
> * Patch 6 adds a new IRQ flow handler needed to properly account for IRQs=
 as
> VMBus IRQs or as the top-level architectural interrupt.
>=20
> * Patch 7 creates the new IRQ domain for VMBus channel IRQs.
>=20
> * Patch 8 allocates the VMBus channel IRQs, and creates the mapping betwe=
en
> VMBus relid (used as the hwirq) and the Linux IRQ number. That mapping is=
 then
> used for lookups.
>=20
> * Patch 9 does request_irq() for the new VMBus channel IRQs, and converts=
 the
> top-level VMBus architectural interrupt handler to use the new VMBus chan=
nel
> IRQs for handling channel interrupts. With this patch, /proc/interrupts s=
hows
> counts for the VMBus channel IRQs.
>=20
> * Patch 10 implements the irq_set_affinity() function for VMBus channel I=
RQs,
> and integrates it with the existing Hyper-V-specific sysfs mechanism for
> changing the CPU that a VMBus channel will interrupt.
>=20
> * Patch 11 updates hv_synic_cleanup() during CPU offlining to handle the =
lack
> of waiting for the MODIFYCHANNEL message in vmbus_irq_set_affinity() in P=
atch
> 10.
>=20
> * Patch 12 fixes a race in VMBus channel interrupt assignments that exist=
ed
> prior to this patch set when taking a CPU offline.
>=20
> Open Topics
> -----------
> * The performance impact of the additional IRQ processing in the interrup=
t path
> appears to be minimal, based on looking at the code. Measurements are sti=
ll to
> be taken to confirm this.
>=20
> * Does the netvsc driver have sufficient information to annotate what app=
ears
> in /proc/interrupts, particularly when multiple synthetic NICs are presen=
t? At
> first glance, it appears that the identifying info isn't generated until =
after
> vmbus_open() is called, and by then it's too late to do the IRQ annotatio=
n.
> Need some input from a netvsc expert.
>=20
> * The VMBus irq domain and irq chip data structures are placed in the
> vmbus_connection structure. Starting with VMBus protocol version 5.0, the=
 VMBus
> host side supports multiple connections from a single guest instance (see
> commit ae20b254306a6). While there's no upstream kernel code that creates
> multiple VMBus connections, it's unclear whether the IRQ domain should be
> global across all VMBus connection, or per connection. Are relid's global=
 (to
> the VM) or per connection?
>=20
> * I have not tried or tested any hv_sock channels. Is there a handy test
> program that would be convenient for opening multiple hv_sock connections=
 to
> the guest, have them persist long enough to see what /proc/interrupts sho=
ws,
> and try changing the IRQ affinity?
>=20
> * I have not tried or tested Linux guest hibernation paths.
>=20
> The patches build and run against 6.10-rc2 and next-20240603.
>=20
> Michael Kelley (12):
>   Drivers: hv: vmbus: Drop unsupported VMBus devices earlier
>   Drivers: hv: vmbus: Fix error path that deletes non-existent sysfs
>     group
>   Drivers: hv: vmbus: Add an IRQ name to VMBus channels
>   PCI: hv: Annotate the VMBus channel IRQ name
>   scsi: storvsc: Annotate the VMBus channel IRQ name
>   genirq: Add per-cpu flow handler with conditional IRQ stats
>   Drivers: hv: vmbus: Set up irqdomain and irqchip for the VMBus
>     connection
>   Drivers: hv: vmbus: Allocate an IRQ per channel and use for relid
>     mapping
>   Drivers: hv: vmbus: Use Linux IRQs to handle VMBus channel interrupts
>   Drivers: hv: vmbus: Implement vmbus_irq_set_affinity
>   Drivers: hv: vmbus: Wait for MODIFYCHANNEL to finish when offlining
>     CPUs
>   Drivers: hv: vmbus: Ensure IRQ affinity isn't set to a CPU going
>     offline
>=20
>  arch/x86/kernel/cpu/mshyperv.c      |   9 +-
>  drivers/hv/channel.c                | 125 ++++------
>  drivers/hv/channel_mgmt.c           | 139 ++++++++----
>  drivers/hv/connection.c             |  48 ++--
>  drivers/hv/hv.c                     |  90 +++++++-
>  drivers/hv/hv_common.c              |   2 +-
>  drivers/hv/hyperv_vmbus.h           |  22 +-
>  drivers/hv/vmbus_drv.c              | 338 +++++++++++++++++++---------
>  drivers/pci/controller/pci-hyperv.c |   5 +
>  drivers/scsi/storvsc_drv.c          |   9 +
>  include/asm-generic/mshyperv.h      |   9 +-
>  include/linux/hyperv.h              |   9 +
>  include/linux/irq.h                 |   1 +
>  kernel/irq/chip.c                   |  29 +++
>  14 files changed, 567 insertions(+), 268 deletions(-)
>=20
> --
> 2.25.1
>=20


