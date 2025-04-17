Return-Path: <linux-arch+bounces-11425-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C2AA92192
	for <lists+linux-arch@lfdr.de>; Thu, 17 Apr 2025 17:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F98D16CED4
	for <lists+linux-arch@lfdr.de>; Thu, 17 Apr 2025 15:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1132A25484D;
	Thu, 17 Apr 2025 15:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="RUoJF79Y"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2060.outbound.protection.outlook.com [40.92.41.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090DB253B5E;
	Thu, 17 Apr 2025 15:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.41.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744903716; cv=fail; b=otzsOlwmm4hwLhO7+78eCjIfk/s0yzDxCANdnLvQASDkQg0ySIO9YDJErVWAnkaGwBnx8hOCxY8eNYnFfdWseL4Zr0vbg9MdimjAeY6FGBWs7U6II3zBiOkbdB/O4PGG4EVnkMPlZ8B0lwd5vMgK4Ex8tgCkhiL/D2wppewWSl8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744903716; c=relaxed/simple;
	bh=0vOu99oCjE8cMKlbTdN93Pho0dSTo7SIi2Adnc1msT8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NHB6IWaWO39svIEgkzyBaMWKxwif2tYk9m41DN3GnvQvFHMRqcix3S1yCKwNmXrgIysiY3whUA4hhAQULa9xf9R3DrH34jTiBqyrJ8obf82wAVo7yvYjYngWnA4JDjCo/Wm67HhzyzDO1eL7+lcmP5/z6LDYd/nUdvNM/r5SeP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=RUoJF79Y; arc=fail smtp.client-ip=40.92.41.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P/l6oJuX2+wGWfR2/EpYPPna1NAlAVZ3jLEes/6ujZI/J69Pjy09FI/B363UR5Oc+9H3FUVX5B6Z9bwRlVs30jm0awEwrK1wmg96IeV3PcSRK+U33XSD3IZKUljusbQH216pF8z5LjX5locthvkrYvvZPMuO9D1ZKuFyNYegqEAiM9LqiDiob2Kfe4Op+QcJdTlLINc+453tA7RFz7r4MziQkgyc/LajYFo2C81DlONz55EU8buGQ8rK3O7j8/6PVbJh2jLMV6yQTyj9I/9XfZLUM/yCxOkwwppOHlh+kOr70hO+NHksKjJuwluKY767c25Skvwb4yjFOeLSU16tUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wWD8CzOOkRN1YR3YCwqTw4MXeo3qQg2kfqOaYvtikVQ=;
 b=iMddwjnR7211h2v9SDs3lFhBC4GF+0wnJg4bbGx0Z/q3DyBz4xWgQIXGZqgbPF9J+lUaIDZDm/jPbyFaI/a+rCMoobKPah+MrnGnaHnpRXq/Yj/v20G7nYNYt/8W1sA9UlQ1qFXdYJX0BKNDTT4lO7WTbg2cvWrJChrpLjYURx2sGztKGynzYxE4VR2+VtBiUkCj7FMxa36tXrt9ZpqYC9Sy/k2dEOJjz6X9Fw4t0lhLJ13mKAw6bbLj/1aI3ysB6q8SyFnyycwdq+0k9P7KnUErDiqI3K44zFR0iDvtbz1DLSxmxcUIulHTiabE9ZAER2SIytCB7PbwTB9nQJBHvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wWD8CzOOkRN1YR3YCwqTw4MXeo3qQg2kfqOaYvtikVQ=;
 b=RUoJF79YDIiB3xaP6Xe4aimzMcKpaepzt51gBf5b774L9iNcvE2u1lw2fAOBz32h6eFdfbja1BMjf2RsiLL/DPH5xfPFO/lPkLLj16B+8dMTjEu2rkNO/iJi4N+5VMca/Or4Xxt3j9QyGc1t7dFoXCQXnawND8E0+uMo597CIortq3vFH8ow7aV3FCIVgGZnIwsO9lU2pofU4Ypg7w36q8/RLng/MFdUMA8Hs8SmPozQJ0fC6K/aYazlWZNlJGqBljWHn4UuHLEap+AeUZqAuji4tAcgcXKGDr1dTHVVLQvMgm8fFBdk/1PS73URhcy6gN60d1PReRVtwQOT29V0xA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CH0PR02MB8209.namprd02.prod.outlook.com (2603:10b6:610:f1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Thu, 17 Apr
 2025 15:28:32 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%5]) with mapi id 15.20.8655.022; Thu, 17 Apr 2025
 15:28:32 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Roman Kisel <romank@linux.microsoft.com>, "arnd@arndb.de" <arnd@arndb.de>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "bp@alien8.de" <bp@alien8.de>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "dan.carpenter@linaro.org" <dan.carpenter@linaro.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"decui@microsoft.com" <decui@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"joey.gouly@arm.com" <joey.gouly@arm.com>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "kw@linux.com" <kw@linux.com>, "kys@microsoft.com"
	<kys@microsoft.com>, "lenb@kernel.org" <lenb@kernel.org>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>, "maz@kernel.org"
	<maz@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"oliver.upton@linux.dev" <oliver.upton@linux.dev>, "rafael@kernel.org"
	<rafael@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
	"ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
	"sudeep.holla@arm.com" <sudeep.holla@arm.com>, "suzuki.poulose@arm.com"
	<suzuki.poulose@arm.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "will@kernel.org"
	<will@kernel.org>, "yuzenghui@huawei.com" <yuzenghui@huawei.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>
CC: "apais@microsoft.com" <apais@microsoft.com>, "benhill@microsoft.com"
	<benhill@microsoft.com>, "bperkins@microsoft.com" <bperkins@microsoft.com>,
	"sunilmut@microsoft.com" <sunilmut@microsoft.com>
Subject: RE: [PATCH hyperv-next v8 11/11] PCI: hv: Get vPCI MSI IRQ domain
 from DeviceTree
Thread-Topic: [PATCH hyperv-next v8 11/11] PCI: hv: Get vPCI MSI IRQ domain
 from DeviceTree
Thread-Index: AQHbrY/Fq7quJBKCyESy+GFzxkgZH7On+1ig
Date: Thu, 17 Apr 2025 15:28:32 +0000
Message-ID:
 <SN6PR02MB41572F24DCB9247E74876E41D4BC2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250414224713.1866095-1-romank@linux.microsoft.com>
 <20250414224713.1866095-12-romank@linux.microsoft.com>
In-Reply-To: <20250414224713.1866095-12-romank@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CH0PR02MB8209:EE_
x-ms-office365-filtering-correlation-id: f014ac62-f4c9-48f3-d692-08dd7dc4832f
x-ms-exchange-slblob-mailprops:
 ZILSnhm0P3lYr6gs3hDP08q5bX2zp/WUSVSMxsIGm5JXj367JCr8dgHH8En0R3socebTKTC+EZ3YUTzEYPXd0kaA33qwbhQb2MmjYkR3mvT8yeLO1FK0vcQWtCrQuaDkcqIp/6xy3qbd61v8fxCW+0IeZcgLnLpHHrv2xccGIyxAxIn/LifMvvK+7o9+BHberzoCWjVBxZl3rwOTU6ZMQGPBs9Khut/znvfF9DfqjlNhc8Gz5SHYF8gtr5qwTjX9I29vrK/EIU1dDtTPCrGP0YSjDNMWWKqZ0NMs/72FnRCWAg2+pZQXHvZyVzjsu220jEnJ+AXvI4BlAXB6pnUwAN9TW/GCNg3/YdgrwvOL6FBoDqCUPHgtI+xJsjBDUcZubGBlzYWsNfadbGBaJEmCtDkGVbIf/H6b3xPkCnTE0ntts+u8AvoGADEcO6IEjzIHWYcP0riSvIQ6FywWD/iq8ViNxdk8AE8jVlf+KSST+byeeNBwRQh2HzCXUmmP7ab5xvGP3nZjqRy4Mut8JaVfpmNs3ZYRwsLyTCTlLQjqF9HMDQG3m+Q7n0WFNjDrNvlim+EmkFaPBrH9pJJTlR+WubNV/mt6bgo2p0nHD//2UkDlV+oA27XwoSxx8xPxdF4yjUcumXySMibPUjj/wUE+It1fM9Q+nNFZcVBbu1+4MEtUDXA/pj07kdYOfC5xxcNLoql9S7CI0joIAKrbY6I0/xetB5rJbwS8XGkoi5pPrJ0dNpphVqfjdC1DL85VPOYfQl72gr2GRDf3di5XRD5nZbKyAhgAMEvi
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599003|461199028|8060799006|19110799003|15080799006|3412199025|440099028|12091999003|41001999003|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?QBwhA6Cfmn+qIGtKlkX8mnkAov1Z2juthzKyTU3uXAfI8Gld4icq70lDTx5g?=
 =?us-ascii?Q?n3wZ696mVJjzRLJXsFWOEOznMWCUS8ADZ12OuZqI63oxLSQmjCf33+YfWA+k?=
 =?us-ascii?Q?TMDPPsAOa6t9Xv3bp0jIh3AX5KFPCe5QkCs99EVKQPI+71lYgKBhNC+CAhG6?=
 =?us-ascii?Q?TD5M3VLYvR5snQSquzr3WhBqQLERApHCz1mr76IYkd9GO6qIf96p8ugDvYrR?=
 =?us-ascii?Q?uExIIicc8prJoP6Ooe8Tcl7d1orw/mUFy3oH1gDDxUR2Axs8fIZEJl70IDVM?=
 =?us-ascii?Q?/vDv2cTGEVAiCfBqAV84RCzEVobV9frDMKstHlsu6DnwqMFQjI21dkpH20Xo?=
 =?us-ascii?Q?ftOqKwS3BixCImgldnZ3EA2dzK0D2ds1ChvelGc3fan+6noib82N4qDt7DxX?=
 =?us-ascii?Q?p0xAccM2Gj33/qLu0ZDYttQxYAlVvhrqu5INv7TuOxM3FsrssCxE0Hin7Ryy?=
 =?us-ascii?Q?aO4ZAJo8ayKBagg9QDpYDD4mMaGr4sdp6kg025Dhi6s767XDqcw4kIsY53Hl?=
 =?us-ascii?Q?bCSiaFmoxyfg4O9Lk7hxqrUHo5CvyqWg9Mi1g3srEoHJXMLT0IW2+ZRgkNSu?=
 =?us-ascii?Q?jZ+GXgL39I0Veot87797cWk7SLSWr3weIb7vdkqN0NrEMpwDiNkqZlW2ne5g?=
 =?us-ascii?Q?9nOn/j6QJupbx3e6bFEft9tHTZJVTc55IBbh5o23dwGYQIQs0+3GpSDvHsPv?=
 =?us-ascii?Q?pm2bysBfgI8gOzf+3zk/7RFUx10DqJfP9E5lbp7bxJyfnBKuCxMYGSaRzevc?=
 =?us-ascii?Q?izkRxFMIAEahAqzruN/D/6Mr76xaBOmpxZ0eIvRgXIT5HuTcJkx5TJa5q4bt?=
 =?us-ascii?Q?Z2zlsoNMjpJnppYJmDF3RhW5c+dAsBVt0M+uX2jGfCAugLnjVEORj8Y7SBWT?=
 =?us-ascii?Q?SOCAKaNB/ZzmIg9PTIxTVyE7TDkp8NTV5R8fwI0QEwEpO2ax4Vc1kX63kEFQ?=
 =?us-ascii?Q?MBpPo2pJkfs5WLEE9QtFYgNdLe0FV9EopfvpqgFPogpS/GAhuCFKnvRRZo/q?=
 =?us-ascii?Q?9U4AB1IUOZddIIGvUW3OEh9F6ZVUshj/SVLEJBvibK2SnU4mWmADrQuZBwvQ?=
 =?us-ascii?Q?hyrVTn9KUsSKfZY8/7eltvg8K67NUMoEK3Wio3kw0ub21yp2HHMFFoG/sL4C?=
 =?us-ascii?Q?f9l9flF/Mm8XPyFhcqXkfLEbLlLdbcH1Bw=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?7U4+eoWa0pVEtq1zGVSbFKdTBAJ7weueTHzVSv3yWVuY/EFsqfdOE4147DKP?=
 =?us-ascii?Q?Ca7C6uZBW76I5vM3XkTl3eaW2JGgK+Vk/jCEcafDfE+HC666pgwKBwap/RCo?=
 =?us-ascii?Q?MAUbZ2f9IknIWv+fNCFxSYACzVfkmqnUodNCIaAbrsIu4NCguneJslc/QxAJ?=
 =?us-ascii?Q?5p9dR3FVmWKwxqNlGXZJXuYXF1BKQwJ0rSb0ZRtAJ29Sp2PDBGU5PD+5yaZj?=
 =?us-ascii?Q?xWnN8DWlWViOF20CI1LgU931A2+qsI5CthiVVWXwZGA7tvVLCmOzOuooH94l?=
 =?us-ascii?Q?s4m+oEsmeaxDVUI2wab4s78LvKaRhpnslsM7/bsx5QXVlptCtk/uJ2TEWuK2?=
 =?us-ascii?Q?jty40UGVBG8IRsGiLcN54IVcJ4f7pHaQzqZq3plIjzarYDL5TPQmDWFRYWiT?=
 =?us-ascii?Q?fEdM/k6gbibQUzSYmKL/dv4Op+CAa3wg3nCqSjIjOie/ExYi/nRWaJNj3eIE?=
 =?us-ascii?Q?GKQsCMgwa3/ksXfzxhN5DEYisGnBa1p7tjBVyuQZOzsZddpWPXe4JEA0B7EC?=
 =?us-ascii?Q?mTxz0sfCUmb1gWv2ShWQcyWsSAufNg2QfG6koPaR22yIBLFF0UuScYGMXf+l?=
 =?us-ascii?Q?m0x1Y5nN3zhIu3RXGzPtexh3N0Xc5R0htU9eSVKQeCKVTvmHneBuXKFW96ee?=
 =?us-ascii?Q?opegtoKJZxKKjjJVU4sPCY1KjedTGHe0YfGReOlR79pj/3MUqgJBawNgoh0B?=
 =?us-ascii?Q?wiiZ8eB/oDREJySAll0xWXf+DJ/7z2DTD20mRodPBgXZnTAuQU5xPqtyzgDv?=
 =?us-ascii?Q?uU/X2zS20QzY3DK8sRaQPBa7+GNYlcuSmd0NuHVnLQKJQbGccNN7S2GzouJq?=
 =?us-ascii?Q?glLeUCe/oNha0SKFOAcI2xXNkNRBWEAyrINTcs5OwdgeEyCKJUAGKDOCu3Cs?=
 =?us-ascii?Q?cTA3IONb8Y3sN4VrcyCu5hTCi3H6wLd9xd2uOLuEPHxGMlFlfIgIc5nYDsH9?=
 =?us-ascii?Q?0ffkjxl/tdWwPuvZvuVET/i/+r+Jg+r0YD47WhayquCYw5KKlkH87/fYp76P?=
 =?us-ascii?Q?ZO6hVhh2yX8QLOzo0Krk9nrCgggilfCJYLdjJ7LBEenYOKJD1t9IguwOgXCu?=
 =?us-ascii?Q?AjLOQfqkeSv0C/BkbuvpQRIUOdaxew3O7gKme3lE8/Aa+061JgHKCc9rJHId?=
 =?us-ascii?Q?Nwa6QxBLOgm3SYZL0OETDO69hfG40eS3C8e/bCafsYYYsqjVPb/b7PNdZAR2?=
 =?us-ascii?Q?Gj/1pI+UBtnRYNz7ho5o9kwRwB19+YSKFNkNXz+ztY8EYEtQCHpB5o7N8qE?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f014ac62-f4c9-48f3-d692-08dd7dc4832f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2025 15:28:32.3948
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR02MB8209

From: Roman Kisel <romank@linux.microsoft.com> Sent: Monday, April 14, 2025=
 3:47 PM
>=20
> The hyperv-pci driver uses ACPI for MSI IRQ domain configuration on
> arm64. It won't be able to do that in the VTL mode where only DeviceTree
> can be used.
>=20
> Update the hyperv-pci driver to get vPCI MSI IRQ domain in the DeviceTree
> case, too.
>=20
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/controller/pci-hyperv.c | 72 ++++++++++++++++++++++++++---
>  1 file changed, 66 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller=
/pci-hyperv.c
> index 6084b38bdda1..2d7de07bbf38 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -50,6 +50,7 @@
>  #include <linux/irqdomain.h>
>  #include <linux/acpi.h>
>  #include <linux/sizes.h>
> +#include <linux/of_irq.h>
>  #include <asm/mshyperv.h>
>=20
>  /*
> @@ -817,9 +818,17 @@ static int hv_pci_vec_irq_gic_domain_alloc(struct ir=
q_domain *domain,
>  	int ret;
>=20
>  	fwspec.fwnode =3D domain->parent->fwnode;
> -	fwspec.param_count =3D 2;
> -	fwspec.param[0] =3D hwirq;
> -	fwspec.param[1] =3D IRQ_TYPE_EDGE_RISING;
> +	if (is_of_node(fwspec.fwnode)) {
> +		/* SPI lines for OF translations start at offset 32 */
> +		fwspec.param_count =3D 3;
> +		fwspec.param[0] =3D 0;
> +		fwspec.param[1] =3D hwirq - 32;
> +		fwspec.param[2] =3D IRQ_TYPE_EDGE_RISING;
> +	} else {
> +		fwspec.param_count =3D 2;
> +		fwspec.param[0] =3D hwirq;
> +		fwspec.param[1] =3D IRQ_TYPE_EDGE_RISING;
> +	}
>=20
>  	ret =3D irq_domain_alloc_irqs_parent(domain, virq, 1, &fwspec);
>  	if (ret)
> @@ -887,10 +896,46 @@ static const struct irq_domain_ops hv_pci_domain_op=
s =3D {
>  	.activate =3D hv_pci_vec_irq_domain_activate,
>  };
>=20
> +#ifdef CONFIG_OF
> +
> +static struct irq_domain *hv_pci_of_irq_domain_parent(void)
> +{
> +	struct device_node *parent;
> +	struct irq_domain *domain;
> +
> +	parent =3D of_irq_find_parent(hv_get_vmbus_root_device()->of_node);
> +	if (!parent)
> +		return NULL;
> +	domain =3D irq_find_host(parent);
> +	of_node_put(parent);
> +
> +	return domain;
> +}
> +
> +#endif
> +
> +#ifdef CONFIG_ACPI
> +
> +static struct irq_domain *hv_pci_acpi_irq_domain_parent(void)
> +{
> +	acpi_gsi_domain_disp_fn gsi_domain_disp_fn;
> +
> +	if (acpi_irq_model !=3D ACPI_IRQ_MODEL_GIC)
> +		return NULL;

This causes a build error on arm64 if pci-hyperv.c is built as a
module because acpi_irq_model is not exported.

Michael

> +	gsi_domain_disp_fn =3D acpi_get_gsi_dispatcher();
> +	if (!gsi_domain_disp_fn)
> +		return NULL;
> +	return irq_find_matching_fwnode(gsi_domain_disp_fn(0),
> +				     DOMAIN_BUS_ANY);
> +}
> +
> +#endif
> +
>  static int hv_pci_irqchip_init(void)
>  {
>  	static struct hv_pci_chip_data *chip_data;
>  	struct fwnode_handle *fn =3D NULL;
> +	struct irq_domain *irq_domain_parent =3D NULL;
>  	int ret =3D -ENOMEM;
>=20
>  	chip_data =3D kzalloc(sizeof(*chip_data), GFP_KERNEL);
> @@ -907,9 +952,24 @@ static int hv_pci_irqchip_init(void)
>  	 * way to ensure that all the corresponding devices are also gone and
>  	 * no interrupts will be generated.
>  	 */
> -	hv_msi_gic_irq_domain =3D acpi_irq_create_hierarchy(0, HV_PCI_MSI_SPI_N=
R,
> -							  fn, &hv_pci_domain_ops,
> -							  chip_data);
> +#ifdef CONFIG_ACPI
> +	if (!acpi_disabled)
> +		irq_domain_parent =3D hv_pci_acpi_irq_domain_parent();
> +#endif
> +#ifdef CONFIG_OF
> +	if (!irq_domain_parent)
> +		irq_domain_parent =3D hv_pci_of_irq_domain_parent();
> +#endif
> +	if (!irq_domain_parent) {
> +		WARN_ONCE(1, "Invalid firmware configuration for VMBus interrupts\n");
> +		ret =3D -EINVAL;
> +		goto free_chip;
> +	}
> +
> +	hv_msi_gic_irq_domain =3D irq_domain_create_hierarchy(irq_domain_parent=
, 0,
> +		HV_PCI_MSI_SPI_NR,
> +		fn, &hv_pci_domain_ops,
> +		chip_data);
>=20
>  	if (!hv_msi_gic_irq_domain) {
>  		pr_err("Failed to create Hyper-V arm64 vPCI MSI IRQ domain\n");
> --
> 2.43.0
>=20


