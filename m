Return-Path: <linux-arch+bounces-15711-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C3ED05A3D
	for <lists+linux-arch@lfdr.de>; Thu, 08 Jan 2026 19:46:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5F6A0303818D
	for <lists+linux-arch@lfdr.de>; Thu,  8 Jan 2026 18:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C4E2DA765;
	Thu,  8 Jan 2026 18:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="c5VWm6pa"
X-Original-To: linux-arch@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azolkn19012049.outbound.protection.outlook.com [52.103.10.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9009325719;
	Thu,  8 Jan 2026 18:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.10.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767898001; cv=fail; b=F4nm7iZxKaE9GhGpsLfHAo7YQkRdcBhyIbEBFmE6gRQ01wnttqbRLXcdBCGioNCUPYWRRqapkCb2iW/THjfbPTWLFeKlX2VGgPZO42mcVbQ0GayelbTTk7ZtOV29GLouStUIPwkzWztRweBl3wBn8BWDd0CiJHnQfi+0uh1FbS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767898001; c=relaxed/simple;
	bh=olVzP4OQDge0SaJi9VRkHj/YFS+grUCWc7mxDYDQ6vo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RCo7zE/OvT3oRuiMCCW2gLiT/zUzg5yTm3r3nLKWElq2ErvSnSkt1CKQfswh6HbEu9bJMJsowu9fmmD1EBwf2Hrl4lzWPUeApbWQWBJwxslRdRQeJrMcY5ubGtHMi2fJUxDOENlv+PWFzVHyFJKPPorWgvYYvkRwgnsc2dR6Pr4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=c5VWm6pa; arc=fail smtp.client-ip=52.103.10.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kox1i/VD8iuzDcrtyx0YfW84lbKr9C45vAQkqdbxY4lXtyoksu6oAZ2Y+4McNbJmXcT8bqluVyU8zBeB839Fzn7ic6RJrqKqrGUpXyL70CpVS2Fx3AKGpsKAbHNfadAn7WbMAKUuQdh6omZgI+YtXvNKgWxA9pjVrsiURweh8l2sASjz6M3h9P/19ubcXFMtNHX/RSx4NtwGelvaJrODlACLN4JPWJtmoTtAfg2uG5FAn3YAHFsXOj3TEgRi63Dm/dVcSxuc1HK8uMkkxT0xEX3PoXRvFXAvM+TWShkReRjMTZblB3G9NfcG8YKIz0+lH2L1qTfCDlYrVXBXMWoqiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Agw6WWFSKAvVmBkEIb5Rk0JPzq7jXq9V9jV7Mbw21w4=;
 b=yGmbZqXzfIlBLLCBwYe5YBZnBATCwAQ1m9KToLqZbtw6gNuLNf5djUN9r1PmUBkiAsEAY5+jNMrh9icnWXts0s49hyPOgmzjVnSJygqtuKduOuWn9+n854Tx5pfZ8HJbmsPcg6cl0uoul1FscF2JXnC1XYBmnwWxntjF/2F/rqGjIFgsmR20JZCzBum7mR/kAoGDXGJAZY8wSXgB5hIzsAZXjYbgdHnceOyqdr27/mm2BW60NcfatJ+xqI/jjUpgcXqtFWqERxlEHXll15TZWUDEwdtpTGuyo/LRn7OMuObBNoPbyELPllUc7M+nfZBE50NuCZCcB0gaDcU3oJSdmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Agw6WWFSKAvVmBkEIb5Rk0JPzq7jXq9V9jV7Mbw21w4=;
 b=c5VWm6pa/h2Gqsevw+N15lm3sUjSI1HFMpW7LMe3TFf1CpQq4NK4LbpC1Jj9ZB/rclSBnBTy1p1C8ciCP6L+yrJ1vLn21LypBUHcBUNlDRzYyo6sKQRersqwrYJgUE5r9k2BSaxoO6X0GkWNnXfmzk9ZhVLiej0J1koAqxoWCa5E2NrUGvGjhbRY58+Xx1P/lvgFEj30QsTWrE8ZcxsylSSeNc2H4sa7An1vTCM6AZkxv20xiPY3nxtEXf7VSYMIbifpAxUTlocJBP7GRViwxSM0zwXbaaceKpX6OeEHJls/iUqWQ2yL0b0OHe/d3Qr4/T3iMDyjHA7kofJ0kwhhIQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by PH0PR02MB7542.namprd02.prod.outlook.com (2603:10b6:510:51::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 18:46:29 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9499.002; Thu, 8 Jan 2026
 18:46:29 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Yu Zhang <zhangyu1@linux.microsoft.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>
CC: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
	"mani@kernel.org" <mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "arnd@arndb.de" <arnd@arndb.de>,
	"joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"easwar.hariharan@linux.microsoft.com"
	<easwar.hariharan@linux.microsoft.com>, "jacob.pan@linux.microsoft.com"
	<jacob.pan@linux.microsoft.com>, "nunodasneves@linux.microsoft.com"
	<nunodasneves@linux.microsoft.com>, "mrathor@linux.microsoft.com"
	<mrathor@linux.microsoft.com>, "peterz@infradead.org" <peterz@infradead.org>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: RE: [RFC v1 1/5] PCI: hv: Create and export hv_build_logical_dev_id()
Thread-Topic: [RFC v1 1/5] PCI: hv: Create and export
 hv_build_logical_dev_id()
Thread-Index: AQHcaMpPt/satBkNIUW6NoagzPaHTbVImcPw
Date: Thu, 8 Jan 2026 18:46:29 +0000
Message-ID:
 <SN6PR02MB41570FC0D7EA1364FB48CD1ED485A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20251209051128.76913-1-zhangyu1@linux.microsoft.com>
 <20251209051128.76913-2-zhangyu1@linux.microsoft.com>
In-Reply-To: <20251209051128.76913-2-zhangyu1@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|PH0PR02MB7542:EE_
x-ms-office365-filtering-correlation-id: a499ebb0-9f64-4efb-1b5a-08de4ee63c1c
x-ms-exchange-slblob-mailprops:
 znQPCv1HvwXZ5XHxNrJCjRnjimRBgM6SxtsUecfjAS4V7zhGO4A5zHiw/W5XjaclJ7QOk6ftsM2hAIgIAkjN1GkGiKzfdp8NNGRnq6vnZysLIzeOzuxAolzCTA006fLPm9yCUtj4w3ZoTXEbwSj02u7tKwM4iBGT/0oRvtUErQjnujoYwMyxvJcJMk9XY0xnkLKDZPs+cOnipCavBOfvi7XVso4RsTOyOVSS6Otb8d0J9QKNRsPOSyPpO13V33C8HWHWcDWN1cWbJSrDJXNLbnhfFemIs1+bilmcM0EaAt7xLogNarmuT3PqW7esGgjuO4gPMRAqV5Vgy6rQrh8SeAKFCS74/M8lmioRId50ZTDOfqRBcHKFlz2PulH9hkMslGtHs5YESj4702JLdb4Mof8cEgzgyxZHmy9nZTW2qCh6LOgfETeWOxRdmUhOVphJazwdR6hZeL7/8EpAs9wpJe0LtK6ztVbGR0jhNEas5gP/pQ9OanFN22kvcK9Adj395MhSgPoLspOrHmYq+Y4x+6ZfOK48twkKZeb9sejiHSWgOcAVxasrxtRHTR88GOCEyDb68HD2qdc7A3sE8KMhC9EMdrswfQWHfxM8CNpGboFJ1Kt6/i5MRzWlPBaYLrolQz8/UbB7GgmUoAAQhoikJe2qbsftO2yQlh2gV38DXZd0iKG3jrTd3/Voc9sbqMoKy6GKyrE/2oE9p5/38H7kPT6dDxUos3GU6zM0zJL+OXr/YPbmnj7raun1tjvMH8GTNX8+G4r7QAY=
x-microsoft-antispam:
 BCL:0;ARA:14566002|13091999003|19110799012|8060799015|8062599012|461199028|41001999006|51005399006|15080799012|31061999003|56899033|3412199025|440099028|40105399003|102099032|12091999003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?EoUWganr0nIfexTPBrg8JmlAepL8PPBnk/30B7ZRDlyn1jll/OKih91Rq0r4?=
 =?us-ascii?Q?fLSUkWXKup23414l5cGA0YhjYOwfCeQSCkDWOUq7X1VbuC3hWsnWO0PZt+XP?=
 =?us-ascii?Q?PutQcHYfOP011q6RgSiWcqDHCP1Eyl+i+pTvZWrw79TJIinati5rp5R2MDUS?=
 =?us-ascii?Q?FeJc/rCyJ7Jd+0BM6dB4rNirBXow31o2shyyPCNcuGdMk4ephzEvL38YH3TF?=
 =?us-ascii?Q?Hkr/wcrMzAOIeoQspuTqONK6Q5ZmlW2fkS9fGeNwU53T6xk258lVq3i82ipv?=
 =?us-ascii?Q?8KCRwl6Fos6kGHsHB5HKAgAX14G6Bln2/w8CJwP8P5yMIVNKZR12tbCaZcKK?=
 =?us-ascii?Q?dQ2jLRkoisxEXVpY+5OonV1MMsbmNZISqw3LUq5uiKdoF3wFXHKPq/Rc/zDY?=
 =?us-ascii?Q?hx5HYI8FG2EF3V1+L/42vz+amMrswF+hQm56IFe8xoWeGLWKXhZ2cBn75+AG?=
 =?us-ascii?Q?twUGJot/aY534hGLSKqScxvUQkaaYRcFl+vsb0tp/9hG8N6F0MS5hSUz3Gs5?=
 =?us-ascii?Q?z4Rx6vDWCNeYn2ewUc1Ck/yF8N3rq85HAVfTZqCozCGDgul3dJGd0MklR5Zk?=
 =?us-ascii?Q?LcEUO/Q9eZsg0qkvlWRsWahmkD3SN2GATb7svnPP6peZF8oFR6LIQTIbFJm4?=
 =?us-ascii?Q?S0N5BHnVRWQXgGKjDnXIJF5zJeFHaf02wkoBIwJYWqGcbar/yXa0E3fFkmwl?=
 =?us-ascii?Q?aJFUZe0W5PeP/Jrh4AdlXd9zHjnbNHUo1d04Tk29Jn+CFdO7S9adOK2WrYst?=
 =?us-ascii?Q?+61rxjP+L383CUyLoPKJvA47byq1ivkmWlBF+4nI+QX7idaraCAYgpN+uash?=
 =?us-ascii?Q?b45kCyT1e4PD5sFmQ4euAZOoEgPpkHONAYkNaEGDlw6YziDtCrJqgOXJ9iu4?=
 =?us-ascii?Q?b6tKOC38+mFh8AtmWA4wJbMq1jW7xxWJLnvMrcwwejwOlA5ykhX7Oyl5Ntbj?=
 =?us-ascii?Q?NWBSR/PbYRsegvKr7zcXF/sZMvjMsNiQhORxIdIbk6DxJ5qxPkAxdagaOUjJ?=
 =?us-ascii?Q?FrHf9wViqoZ9oAU2QY6HJpFJMr6TsUoOuGYAUWh0UvieyIoDmC62jHTEcfDr?=
 =?us-ascii?Q?8eKZvcdlkxkcRJK+sQ6eE7ohJyY7o++LDZ/ihFpwHzpZ1UGzxKIJr424eTOX?=
 =?us-ascii?Q?5qdqdGQinUF8h+fQhpqfQ0ZXz1m2xCSbmfiAEOdDYcdkUdd9ERqkUY91vNsq?=
 =?us-ascii?Q?yX+ngcGMuDL94aIojU7yhUFLfIF6NpA5OEgzOtAbXWRXV/wjpx75PDfEB0C0?=
 =?us-ascii?Q?ieHTCwVMvDLEEeUYJab5eTfhv6wDZ783cyriOcCljQ=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?uqhTw70r4XnoRFvy3IzjHKxUJfDRTbrDGbMYDL/W8BS026VAjzsH5d9bro0A?=
 =?us-ascii?Q?9daW+f/58bH5JgYddftzREUaZDNOZavLFhkpgB64DFm0ZLYEQy1CQWJKGz/4?=
 =?us-ascii?Q?0OPW8r5uZNu9mMyTERi0YmrsKKDCTqrWygX/dDauXQeA43j6MAU4SSO6TSCJ?=
 =?us-ascii?Q?VDEi/P/nzCLXGOmogrK8MGTMYqn+PzDmO1eD3HdvbHGiElnHcz0fWUdkmimX?=
 =?us-ascii?Q?zhBv/9gzmKnMH9KQgJGLG51Pf7qaQz88+6Mh55Hjc9NAd3iKxQL5mvRfsfpn?=
 =?us-ascii?Q?sMU281V2IhKqmo9UZ8EazWhtNCBfrH85FfvMbrBW7KeaKXLU1o9Kuv8p+7J7?=
 =?us-ascii?Q?8dSscxpNFiih663iarH618GDhrldbFl/lrTtMxOdDjGw1S98lDFOlOh/sqbO?=
 =?us-ascii?Q?cz5mD6DcxhgtHq1Czgt576WIdc8GXxt2/rpwiE8hkKKngtCqcS4wE3199D3N?=
 =?us-ascii?Q?rx/QiWJ+zBKLNQyrV8yBODOuoiqS+T+I87VDJBLSK25GNnTcn7EHl598WY6D?=
 =?us-ascii?Q?eN4O+iioOANLDilqycTU9s4JWUe4C9o02u9vpMhs2VwIWQxHIhBGrZyW4omX?=
 =?us-ascii?Q?AxF3usl0lFGeoUfcf1FBtXWlBGMBrfnKhLBCaoqBrDRrKz1Q3ELAxSpqHbsq?=
 =?us-ascii?Q?19jOlpSHeEsSJ13EyFMSDtfCz/Vc5ux3puvqf3CqOfP0iiPEgsElczJoMvm7?=
 =?us-ascii?Q?H9Qih7M2voWUZThtbtbaxmsaOa6t/ZOzyyMXHjK9/SFKgUCpYRRdrxgjOjVB?=
 =?us-ascii?Q?s6Rlbv24zX0kP7aPVyPk5DgmKxwPc7RmrFtTmu26nkiCjSBznlWuEsMw3J5R?=
 =?us-ascii?Q?+8ZIhn1i3eVwnt0ck+KVmBqiZNb0Rext9E1/Zyd9btPdvI9ZSPIIM6Q3KwEc?=
 =?us-ascii?Q?74vsl23izYIdnlxMDwvFFVkZlLHCc2t7tUHiqvtzWrP+whGLvcRQ2osKG2aO?=
 =?us-ascii?Q?M3nxhLYKFDPTodJA59daeYW43+Cm3RWJu04AK4Zm4CJOFKctGaRyWww4iLTS?=
 =?us-ascii?Q?OjJkQd8SoBQF/9zAafJRAA3/Ogx3aeWbnn6MnemlPqp0whAiyLDf70QH37K1?=
 =?us-ascii?Q?iKHC9L6Bgc1+gF/sDQy3VbysVXFiFNAX/mji6lmsQE0kdKa1TiopBckJnuNf?=
 =?us-ascii?Q?5Hu9upfllcmEUSZJCXlYNKSS+agXf9OuXx4t+6h3Pvilb4kYnT4nJQh5ekrF?=
 =?us-ascii?Q?msD6uWrAHhZhihz+HxYkQjZvQxI/W2YufIxrVeRCxRXouJsqbr9blUkuO/YS?=
 =?us-ascii?Q?eulCCuOnzTXyRqGzQy57+DmIKJTQwjXBXFbJX6PC6xHeC6NFtEJ3hV3k3z4O?=
 =?us-ascii?Q?bZ1BdGFwxijYwu0bv1pUQijrKiM+8KI38kPFxbbIidiR4aS7P46xeHsCRAFP?=
 =?us-ascii?Q?u1k9prU=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a499ebb0-9f64-4efb-1b5a-08de4ee63c1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2026 18:46:29.0470
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7542

From: Yu Zhang <zhangyu1@linux.microsoft.com> Sent: Monday, December 8, 202=
5 9:11 PM
>=20
> From: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
>=20
> Hyper-V uses a logical device ID to identify a PCI endpoint device for
> child partitions. This ID will also be required for future hypercalls
> used by the Hyper-V IOMMU driver.
>=20
> Refactor the logic for building this logical device ID into a standalone
> helper function and export the interface for wider use.
>=20
> Signed-off-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
> Signed-off-by: Yu Zhang <zhangyu1@linux.microsoft.com>
> ---
>  drivers/pci/controller/pci-hyperv.c | 28 ++++++++++++++++++++--------
>  include/asm-generic/mshyperv.h      |  2 ++
>  2 files changed, 22 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller=
/pci-hyperv.c
> index 146b43981b27..4b82e06b5d93 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -598,15 +598,31 @@ static unsigned int hv_msi_get_int_vector(struct ir=
q_data *data)
>=20
>  #define hv_msi_prepare		pci_msi_prepare
>=20
> +/**
> + * Build a "Device Logical ID" out of this PCI bus's instance GUID and t=
he
> + * function number of the device.
> + */
> +u64 hv_build_logical_dev_id(struct pci_dev *pdev)
> +{
> +	struct pci_bus *pbus =3D pdev->bus;
> +	struct hv_pcibus_device *hbus =3D container_of(pbus->sysdata,
> +						struct hv_pcibus_device, sysdata);
> +
> +	return (u64)((hbus->hdev->dev_instance.b[5] << 24) |
> +		     (hbus->hdev->dev_instance.b[4] << 16) |
> +		     (hbus->hdev->dev_instance.b[7] << 8)  |
> +		     (hbus->hdev->dev_instance.b[6] & 0xf8) |
> +		     PCI_FUNC(pdev->devfn));
> +}
> +EXPORT_SYMBOL_GPL(hv_build_logical_dev_id);

This change is fine for hv_irq_retarget_interrupt(), it doesn't help for th=
e
new IOMMU driver because pci-hyperv.c can (and often is) built as a module.
The new Hyper-V IOMMU driver in this patch series is built-in, and so it ca=
n't
use this symbol in that case -- you'll get a link error on vmlinux when bui=
lding
the kernel. Requiring pci-hyperv.c to *not* be built as a module would also
require that the VMBus driver not be built as a module, so I don't think th=
at's
the right solution.

This is a messy problem. The new IOMMU driver needs to start with a generic
"struct device" for the PCI device, and somehow find the corresponding VMBu=
s
PCI pass-thru device from which it can get the VMBus instance ID. I'm think=
ing
about ways to do this that don't depend on code and data structures that ar=
e
private to the pci-hyperv.c driver, and will follow-up if I have a good sug=
gestion.

I was wondering if this "logical device id" is actually parsed by the hyper=
visor,
or whether it is just a unique ID that is opaque to the hypervisor. From th=
e
usage in the hypercalls in pci-hyperv.c and this new IOMMU driver, it appea=
rs
to be the former. Evidently the hypervisor is taking this logical device ID=
 and
and matching against bytes 4 thru 7 of the instance GUIDs of PCI pass-thru
devices offered to the guest, so as to identify a particular PCI pass-thru =
device.
If that's the case, then Linux doesn't have the option of choosing some oth=
er
unique ID that is easier to generate and access.

There's a uniqueness issue with this kind of logical device ID that has bee=
n
around for years, but I had never thought about before. In hv_pci_probe()
instance GUID bytes 4 and 5 are used to generate the PCI domain number for
the "fake" PCI bus that the PCI pass-thru device resides on. The issue is t=
he
lack of guaranteed uniqueness of bytes 4 and 5, so there's code to deal wit=
h
a collision. (The full GUID is unique, but not necessarily some subset of t=
he
GUID.) It seems like the same kind of uniqueness issue could occur here. Do=
es
the Hyper-V host provide any guarantees about the uniqueness of bytes 4 thr=
u
7 as a unit, and if not, what happens if there is a collision? Again, this
uniqueness issue has existed for years, so it's not new to this patch set, =
but
with new uses of the logical device ID, it seems relevant to consider.

Michael

> +
>  /**
>   * hv_irq_retarget_interrupt() - "Unmask" the IRQ by setting its current
>   * affinity.
>   * @data:	Describes the IRQ
>   *
>   * Build new a destination for the MSI and make a hypercall to
> - * update the Interrupt Redirection Table. "Device Logical ID"
> - * is built out of this PCI bus's instance GUID and the function
> - * number of the device.
> + * update the Interrupt Redirection Table.
>   */
>  static void hv_irq_retarget_interrupt(struct irq_data *data)
>  {
> @@ -642,11 +658,7 @@ static void hv_irq_retarget_interrupt(struct irq_dat=
a *data)
>  	params->int_entry.source =3D HV_INTERRUPT_SOURCE_MSI;
>  	params->int_entry.msi_entry.address.as_uint32 =3D int_desc->address & 0=
xffffffff;
>  	params->int_entry.msi_entry.data.as_uint32 =3D int_desc->data;
> -	params->device_id =3D (hbus->hdev->dev_instance.b[5] << 24) |
> -			   (hbus->hdev->dev_instance.b[4] << 16) |
> -			   (hbus->hdev->dev_instance.b[7] << 8) |
> -			   (hbus->hdev->dev_instance.b[6] & 0xf8) |
> -			   PCI_FUNC(pdev->devfn);
> +	params->device_id =3D hv_build_logical_dev_id(pdev);
>  	params->int_target.vector =3D hv_msi_get_int_vector(data);
>=20
>  	if (hbus->protocol_version >=3D PCI_PROTOCOL_VERSION_1_2) {
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyper=
v.h
> index 64ba6bc807d9..1a205ed69435 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -71,6 +71,8 @@ extern enum hv_partition_type hv_curr_partition_type;
>  extern void * __percpu *hyperv_pcpu_input_arg;
>  extern void * __percpu *hyperv_pcpu_output_arg;
>=20
> +extern u64 hv_build_logical_dev_id(struct pci_dev *pdev);
> +
>  u64 hv_do_hypercall(u64 control, void *inputaddr, void *outputaddr);
>  u64 hv_do_fast_hypercall8(u16 control, u64 input8);
>  u64 hv_do_fast_hypercall16(u16 control, u64 input1, u64 input2);
> --
> 2.49.0


