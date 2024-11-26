Return-Path: <linux-arch+bounces-9164-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E9B9D919B
	for <lists+linux-arch@lfdr.de>; Tue, 26 Nov 2024 07:00:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0529A28AE7E
	for <lists+linux-arch@lfdr.de>; Tue, 26 Nov 2024 06:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF01156F5D;
	Tue, 26 Nov 2024 06:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="UUT+0VGQ"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11olkn2073.outbound.protection.outlook.com [40.92.18.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA262539A;
	Tue, 26 Nov 2024 05:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.18.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732600800; cv=fail; b=WVSEOF3IXXwqnZ3STa67sw/1N5wyp5vHkDtXrOMb2t8dUZDEwU8OILcdiPS5O/cQ4xLxo6sDpP9mrlO1jDLPDFgN637M3Z/ojZaukdQlzPFK5ONCPMeAatWC1cZsllvMtHHo8yYdoI94jzoDAcIDC9+h0gaHrwLwGm72O18XQcs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732600800; c=relaxed/simple;
	bh=qxQv7Z3S7NTKriAkM5GokfYtZJ1VUWQnAwA/oY8ubHU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GAgsx6BonHdAKiQj6F2kKr8XAV0LG31HqZw5y5zueu36MYTA4qCha9tKoaaEe8M7aRvX1HLxseqQvfB95oFMzjZo4VFGjmz5KW1P+woLhpuRmyHNztB1fu8wk4eMfpW5DFZRTsBdKt5d3jJwUXtdWTAwkQDUVHSqSl0wI+g8J/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=UUT+0VGQ; arc=fail smtp.client-ip=40.92.18.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FKtm5RSAyc8nio12ufFYfIWoT18s+ZxUIbfA0p8F+xYgJ7+jjz6GJi8bY1fBgpAGv1NABIhw2yI/ajB5aSk3O/E5TGM+ahfr92t++uQ6xtGXVL0GkUpblIQf1mb4PO6iJk3oc/HDBz0B5aFxCgaoKX6JrYdIjsVTzCi71PRyGob+xXWWbmbEZdmhpunYqJwh9fWri6CtU40wLBqHCzRaZ7wOYe7hD97bq5QFNiIq+bNklMRSud2YePLcyerFOR5zNBNPnghsytEyaVslV2MhesDgazR/TBo4sdHNGnmZz0ul3ZsK7p6A7btq3S/9MuC6UKDG+gn7bipiW/uVf3aKOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qxQv7Z3S7NTKriAkM5GokfYtZJ1VUWQnAwA/oY8ubHU=;
 b=hIo++iy51+Bb9DDVYvz8i8cymcFCFJsBOKi8RW2/yLuEL28q/Fl68kP9vV5Pfzkej/iZyCU4R76mZfzaqd1d1e2gcYiruFri3Rv2+q/+XeJiUCZh/iI2LXdUmtPLIarcYNPMxmUr3czxuOfhVOrtXQ8bVJpbSvd1/qYw5eWXBY7ySb6ZI39iP2u0GejTTQAlEOXjF/d+0jVlcb6gDH/vMnz83ZjgimlbRfQj5tW9w0SCXS/MVZ7qLTeuSol+cQ/KInV3tJ+2MybQ3ec+tG3YtEiEPPCq9MD/0r0YdZ7xKN+WTO9MrCXfN0wi3xhH112VEhLGCVD8CF21o77aw8gI1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qxQv7Z3S7NTKriAkM5GokfYtZJ1VUWQnAwA/oY8ubHU=;
 b=UUT+0VGQTnxycDrk1Q+ZTkpKwgrki2Kln3uQF599PuyckNhJ7sot3M5I5reuoA7ImULWsVYwKMx88yNrY/5dUxNyxsHoBTyfrZjvOTC2K0qPp27yP7ULR7tdxjFwJtKE0i/AYFhbdljGeDWAeI8LLoYB2zzJSxu4m0WKaoT6GglpALe58/CTaXbcPg7M/h3R5imqmBNOaIrJ1jS0IKQTQSGnAvWySZN7PqkAqlaPE/l/KArz9ODOa7so5aWJA0mAgSxX4uVYn+Y8DCoS4b21lnLp3hTbdJ3u4T5KScJqsgRH/tUDIUtnAU3Wi73DhzaQ2msIIgc5z2Wk/mNxNqps0A==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by PH7PR02MB10038.namprd02.prod.outlook.com (2603:10b6:510:2ec::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.21; Tue, 26 Nov
 2024 05:59:54 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%7]) with mapi id 15.20.8182.018; Tue, 26 Nov 2024
 05:59:54 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>
CC: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>, "will@kernel.org" <will@kernel.org>,
	"luto@kernel.org" <luto@kernel.org>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de"
	<bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"seanjc@google.com" <seanjc@google.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "peterz@infradead.org" <peterz@infradead.org>,
	"daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "joro@8bytes.org"
	<joro@8bytes.org>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kw@linux.com" <kw@linux.com>, "robh@kernel.org"
	<robh@kernel.org>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"arnd@arndb.de" <arnd@arndb.de>, "sgarzare@redhat.com" <sgarzare@redhat.com>,
	"jinankjain@linux.microsoft.com" <jinankjain@linux.microsoft.com>,
	"muminulrussell@gmail.com" <muminulrussell@gmail.com>,
	"skinsburskii@linux.microsoft.com" <skinsburskii@linux.microsoft.com>,
	"mukeshrathor@microsoft.com" <mukeshrathor@microsoft.com>,
	"vkuznets@redhat.com" <vkuznets@redhat.com>, "ssengar@linux.microsoft.com"
	<ssengar@linux.microsoft.com>, "apais@linux.microsoft.com"
	<apais@linux.microsoft.com>, "eahariha@linux.microsoft.com"
	<eahariha@linux.microsoft.com>, "horms@kernel.org" <horms@kernel.org>
Subject: RE: [PATCH v3 5/5] hyperv: Remove the now unused hyperv-tlfs.h files
Thread-Topic: [PATCH v3 5/5] hyperv: Remove the now unused hyperv-tlfs.h files
Thread-Index: AQHbP5E7zVz9oL6wU0uTUJ+VMFMHp7LJEWeQ
Date: Tue, 26 Nov 2024 05:59:54 +0000
Message-ID:
 <SN6PR02MB41570E0108D4E3B45571EE9FD42F2@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <1732577084-2122-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1732577084-2122-6-git-send-email-nunodasneves@linux.microsoft.com>
In-Reply-To:
 <1732577084-2122-6-git-send-email-nunodasneves@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|PH7PR02MB10038:EE_
x-ms-office365-filtering-correlation-id: 81e8fe5d-0854-487c-4388-08dd0ddf8cc4
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599003|19110799003|8060799006|461199028|15080799006|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?WWwbdPZY5QS+WO590DxTUlcWx15jgnG3WFaQ/ikJ7OyXaeQeBgFazUQaRxpG?=
 =?us-ascii?Q?CLFfyEfdHUdsMQsGCHx8SpZVuNHhgjhAhg/w6ZzNNbvHFhg+x4pN/n26ttL3?=
 =?us-ascii?Q?c/s5kgb7xP0EDQm9CVQU0wuW7EtH3cCwW3Z4mSQQ7fHKSu49rWrZ0wXkqCnH?=
 =?us-ascii?Q?tErEh7TwQr2F7gm/eUWfDsWphzFl0ysEappf2GRPSTFsZuSBrzBY04Fp2SsV?=
 =?us-ascii?Q?JL0+KsWsuu8AdS4q+0MGUv+IVUSizjMER/ZNnJ4cZ5HwmjwSa6BcEu9z0kYU?=
 =?us-ascii?Q?CadTT55Z2h8iPT2mUez+VgkGWCUcygTeBRrCud/eiqTLRgCoYYuILJzzqvbl?=
 =?us-ascii?Q?xWXhUHNoKgP1zVsuw1gG2HRKTVu+cxSkU1Izg79R7kp7FrOig683PljOq79b?=
 =?us-ascii?Q?pjDDsWDUHpelXbpHlV1x4DuESBx01Glx/mEorZHU8t5OVF3Om6v3J9WvOx/y?=
 =?us-ascii?Q?aTQM4gPVbFDurwP75saiHnhRvtMSME68fIkczjZAyKiuoKyvzxiELlRUA6P4?=
 =?us-ascii?Q?TWtGUEAeSh3za0zUXabHFO3Ar9RCpEDXCERZF00+JhQjuDz0Dg7PRkgLKmcn?=
 =?us-ascii?Q?81UxDAizSjLwexoHKbEgKU1IfVkKresJX14a1HHMGYmCACZOlTfgjiGSuPyB?=
 =?us-ascii?Q?ceGavc0xmwO7eTmWiV8j2wjE0BNnLxjY5JOvP/eUhIkZCWm4Mu6361Tgyo/j?=
 =?us-ascii?Q?vIWZOdvdCVsa5G7qkOA31WtUTrQjI7wFL+rySBGr5jnSSpLiQvpBq5zVjQTU?=
 =?us-ascii?Q?X+K6xcrOQsIQvxlqnykeab6DLP0NMAH/JB2gyMdA84Rz0Nv0z/PbQCFEXqLr?=
 =?us-ascii?Q?1x7UbfiAFWtx/1PeR5Yb9gHt+E2tcm5jZpgL8fPEkTJZce9ilVJMyP+1rBHn?=
 =?us-ascii?Q?fJB4WnVSjSH80rnZUrlkEECyNf0oRjzEaxpuvbQdk3RvOJP3+d7exFmdNc0F?=
 =?us-ascii?Q?c9546IgHhyRoPEPLJQ6D40BQCmBrN/3Rbgvcma1X92wNRcT0g/KIgmJu0a20?=
 =?us-ascii?Q?vwEnThSKHFKr3mxmcq2ltu7pOA=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?WGdZhy5Y4upH0/EoZY0i20KCz1AgIqyBCDFnTY3xvjgbNETFYGu+jaMzw5te?=
 =?us-ascii?Q?SPjW3isJDvxTy16gsw6Lnd4ssrqnTj9bQhkVPN7yxMJeQxNynCVL5BWx/G21?=
 =?us-ascii?Q?U1+xAeNgeR7r9CBhJnSGKetiAfalB6qH+CmE1TmCpk9s4IKXIBq6Yltt1SYV?=
 =?us-ascii?Q?yU3JUv/jX9aOQuc0bJ9SQeGAMJjZDHHr1V4tXcyFYwgw231l8J/d08mrADPX?=
 =?us-ascii?Q?PczERWHZrlVb4ntK1Xhwc3jw0KTm/cb3y9PtX8elztd4hdw+EGLOv6CyrNCj?=
 =?us-ascii?Q?5rPlffEE9kS88zZ/l8AcCEfY1Rl2EWIcr90QX27N27YaJiHGXbH4YNxEDBx8?=
 =?us-ascii?Q?WfGlIJJjTn7bZjh/QtMMH2F+DDxNklsguhDG6j9CnrXA6hSf8jUMUK+JmcQM?=
 =?us-ascii?Q?cGIbpQvYQ2pyVrC/UiAAz5qbHQMjB3yHKJMc0FQd6osxekIgSI/L5F5BcSSd?=
 =?us-ascii?Q?6MidbWlbSeEW7n8vflGIRTwIG73ulNFXWG+0og3sf8ZVI4CvxAj+Pjxg70iV?=
 =?us-ascii?Q?C5uJAS0EIPunjld3qhza1AVS7Rp6KRUO7enOe4BGPh0MrWP+wr0Z4TItNnxq?=
 =?us-ascii?Q?xnIhXdDnlm+pIvYwHZOkxjH8Tof1SWoG0xxOXLwEyqBERJwHQIc4Xu9COd/M?=
 =?us-ascii?Q?emEY+aPOgiSUDb7Mvu9j0ijay2JEOBwkX4Z8c3Biml9bQNYJgDIybn6hnGds?=
 =?us-ascii?Q?JU1fPaEXg/VXzrLHoA/5mDvmxSvKl3lNcWm5MTDVJyYLfx8ilOkymu216GyR?=
 =?us-ascii?Q?zCT1w8oLbQch/bjH6R7/ZvwsTmcrCbEUV9BtG2Qy7t6dHAyxO1yElSo0ZbL1?=
 =?us-ascii?Q?2QY5wT65rj9WstTcTVq2muXO/xMJmtI7V8HRmiH8L3ufJmU+cSTQjid6CP/e?=
 =?us-ascii?Q?Pw3Ljyy8Gu7nNFdgSb3VSJDLUkkSY33j+0LkldC39JamHMBHmXHCWkCNqN8E?=
 =?us-ascii?Q?m9bQzFOq4Pb5TMR2rSBTmTm8mLIAbd0PSA0WZkF4uikCQF0FAuZ5ZaWwKVRZ?=
 =?us-ascii?Q?XkyTdOhTXAKzsYCDzMUrQi3RtJ8mVHkAYQowjcUyXqBH7g5XCSEcyRImlUn6?=
 =?us-ascii?Q?xGYLWhwqRVwLZn+R1wD5AEfgjub1oT4zf5XnbWNeiLjT3f0UyxZge9GXSuG6?=
 =?us-ascii?Q?cHHpqI7NjKLko+4TnLW7eRumFOAHxv2M3lAS4g4KbZcMc99SmJM+4qbQuyym?=
 =?us-ascii?Q?eL9e2q6wqK6gBmouCT1CRXJvBpdtFcPARnWsC/NU8M4Vx7009tyr1HCCF1s?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 81e8fe5d-0854-487c-4388-08dd0ddf8cc4
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2024 05:59:54.6865
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR02MB10038

From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Monday, Novem=
ber 25, 2024 3:25 PM
>=20
> Remove all hyperv-tlfs.h files. These are no longer included
> anywhere. hyperv/hvhdk.h serves the same role, but with an easier
> path for adding new definitions.
>=20
> Remove the relevant lines in MAINTAINERS.
>=20
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

