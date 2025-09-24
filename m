Return-Path: <linux-arch+bounces-13747-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A984B99049
	for <lists+linux-arch@lfdr.de>; Wed, 24 Sep 2025 11:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AB567B1A78
	for <lists+linux-arch@lfdr.de>; Wed, 24 Sep 2025 08:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4D32D663D;
	Wed, 24 Sep 2025 09:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Y5MZqWdd"
X-Original-To: linux-arch@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011042.outbound.protection.outlook.com [52.101.52.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E082D6614;
	Wed, 24 Sep 2025 09:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758704465; cv=fail; b=XYtJkLuRRmEVHFqQ+aX+nmg5VAJpENzQmjydWBKsKqdK23/SJVgvy3ru9ia4OzZ23Qt3FJbQ8IwaZ8Er3mKooSzJXy9bEE6SCHec2sNdvDWfw31kvOYZn7aOftlfoo9rOCXqU/UaykPdRzYd2cS8zcqFj+xuiUCGkvKbCDcXwCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758704465; c=relaxed/simple;
	bh=rOyOtZ0A3CelgjnwvsjJ6fkMF1tBawLvtyheooEehR8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=M8g/IoUYGlQyesG0IasfWquShAfA/eh4FBwTqZ8lOIyzJxT6eUyDCqN7HKBenZnt0MzMdwCCyTZx4sfRz+g5OxjZq0+StDbNVnkpaqiRCSDrurdUzmK3vPT3G55sLqxP5PnBbLpBoyajMlUkH/U9hP1Zsf7x4yS14iJ5vIRtLx4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Y5MZqWdd; arc=fail smtp.client-ip=52.101.52.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H5ohLgUroBka19mG6HHtdGfmI+FOOfjYyEdcKll7Ncn/1F6LrN7VJ2fLVc1VN1DJdoZXjpRIeizt0SLJGY3jbUQYZf3mZyDK4SWMzAxNKc7BZWhe21fyeEd98lqEfbjcPqMEF3YTuC+4ECmOVtfH8R+TkQCc450wQ10eS0u9ueqaEmmCD55QpffjIt9iY52mZUJWy2JqMVPrLbu0CjnhtARBfLeA86adf7WCEbm5CaBQcDidcNOImN2DLNYY24Tb33tUuGKLWbLA4LyAfvAeJWl+zsxrYXkyURTfPlNE0EDxw4wzNcwxZqX27Dl6yl2VMo6/32RKK5tGLIqtqWhMnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EcTIbAOFkHdP69zTFb/acdaEg0h0F1YOe1iqbBfhMrM=;
 b=xTf9TNLGVUOipoB1DKa1kWqo5RlojIVRytkEOV4AJ1cgG+UBuXctGxQUs9/B8yIMNHQjqdBI4H9Eam/VInDQIAkVIwve+15ftZR9ZTQ0U11Bz4kmYmRL5ceRyIofxlY2spmeVMLwjEEI+pH4jxXL7P3QT0HO0j5LU+sa3f3WNWJpAi44z/n9HxRexw6Q6kdJc2WnRCruYx+5BLhdqS2zYvAqzBTIBtfRIUvblgC3tvB4lsiGROEuCKqlIRlw9MP8Xw6bROcTwhSKlQnu8QSWN6ZxwGO6km6ihwFQJFzD+Y/rJFSwE48IRY+VH3nGiGoSPO+SHGfVgUOldq5KI6g2aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EcTIbAOFkHdP69zTFb/acdaEg0h0F1YOe1iqbBfhMrM=;
 b=Y5MZqWddlVx8Tc8kLnen4TxeiBy0SWLgBUek1hNUs79qxkP0/Qc0ukRyP9rf3bx/Rn3GFSTzUfuFHaBpMyHG5UfyrcIU0buTFDn5B+LnJ4+2grebhyGFO5wxwXyKTsfJ7HbbgEpPm3L1xSWJ6KB5bkt40bgReOcfrqCOeOLNq20=
Received: from DM4PR12MB6109.namprd12.prod.outlook.com (2603:10b6:8:ae::11) by
 CH3PR12MB8332.namprd12.prod.outlook.com (2603:10b6:610:131::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 09:00:52 +0000
Received: from DM4PR12MB6109.namprd12.prod.outlook.com
 ([fe80::680c:3105:babe:b7e1]) by DM4PR12MB6109.namprd12.prod.outlook.com
 ([fe80::680c:3105:babe:b7e1%4]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 09:00:52 +0000
From: "Guntupalli, Manikanta" <manikanta.guntupalli@amd.com>
To: Arnd Bergmann <arnd@arndb.de>, "git (AMD-Xilinx)" <git@amd.com>, "Simek,
 Michal" <michal.simek@amd.com>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Frank Li <Frank.Li@nxp.com>, Rob Herring
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, =?iso-8859-2?Q?Przemys=B3aw_Gaj?= <pgaj@cadence.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	"tommaso.merciai.xr@bp.renesas.com" <tommaso.merciai.xr@bp.renesas.com>,
	"quic_msavaliy@quicinc.com" <quic_msavaliy@quicinc.com>, "S-k, Shyam-sundar"
	<Shyam-sundar.S-k@amd.com>, Sakari Ailus <sakari.ailus@linux.intel.com>,
	"'billy_tsai@aspeedtech.com'" <billy_tsai@aspeedtech.com>, Kees Cook
	<kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, Jarkko
 Nikula <jarkko.nikula@linux.intel.com>, Jorge Marques
	<jorge.marques@analog.com>, "linux-i3c@lists.infradead.org"
	<linux-i3c@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
CC: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>, "Goud, Srinivas"
	<srinivas.goud@amd.com>, "Datta, Shubhrajyoti" <shubhrajyoti.datta@amd.com>,
	"manion05gk@gmail.com" <manion05gk@gmail.com>
Subject: RE: [PATCH V7 3/4] i3c: master: Add endianness support for
 i3c_readl_fifo() and i3c_writel_fifo()
Thread-Topic: [PATCH V7 3/4] i3c: master: Add endianness support for
 i3c_readl_fifo() and i3c_writel_fifo()
Thread-Index: AQHcLKFhrxQvMAo9OkSHor4BRo6l1bShHNCAgADPJEA=
Date: Wed, 24 Sep 2025 09:00:52 +0000
Message-ID:
 <DM4PR12MB61098EA538FCB7CED2E5C47B8C1CA@DM4PR12MB6109.namprd12.prod.outlook.com>
References: <20250923154551.2112388-1-manikanta.guntupalli@amd.com>
 <20250923154551.2112388-4-manikanta.guntupalli@amd.com>
 <13bbd85e-48d2-4163-b9f1-2a2a870d4322@app.fastmail.com>
In-Reply-To: <13bbd85e-48d2-4163-b9f1-2a2a870d4322@app.fastmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-09-24T07:41:57.0000000Z;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6109:EE_|CH3PR12MB8332:EE_
x-ms-office365-filtering-correlation-id: 9e0dc764-8109-4a17-e2c0-08ddfb48dd1e
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?P6y+8Ia7a3FWT3kTeBoxI8SGZbZbyi4prrUva708wZWkxcUlC4qpPVHGLD?=
 =?iso-8859-2?Q?/nyZ8pxPX0dua+mYbU5T4OCA/vlX5aURpPuLnSf3AbiBjujsNsfyBUgk52?=
 =?iso-8859-2?Q?/HQ0rZYuqf9yD15QqXOAG1AgaE67s08XO+BwrtNNUbR1wioQR/aIWu/b7j?=
 =?iso-8859-2?Q?j6YvuJjAsWOP61N7uMZjeV27ikbYQ2dZX2UipnBBwGFY0xQ1DhzUm0Nmf8?=
 =?iso-8859-2?Q?7jSE412PDxLVIH4ojSaAg7y5UM+rVfrT/HBsd4/3lXb0dkVXYDntu+Ohpt?=
 =?iso-8859-2?Q?FnM3Ze1MrtTPSwsovCoET8x5eJkCL1Yh3TX7QdVXyDT9jt3HwARvpnnd1B?=
 =?iso-8859-2?Q?wRgIzf9iFoXKUQBdbD0BficKszFBeO4LREXuHNuKlHCNhwZjVcTiWZGl3k?=
 =?iso-8859-2?Q?icQArkcAMkek8UgOhhR4QoI8cEIsMepi/3dQeltsv0cwNHKWMl78nMLN7i?=
 =?iso-8859-2?Q?W0gFtVZf0SucwzrLhGhX74Iuqi9WthPozUgn3AR6FX/HRapdQSOkwn6Ckp?=
 =?iso-8859-2?Q?hDXrfySGpO2tueV4C1vTTur43OokNId05LL+t+vBNs79IKdXqAO95oUfSt?=
 =?iso-8859-2?Q?ideYSvGxc1+NNJZoPsqYZJG9QfrQyk4ORMD7KQZWRmUNhcGFrQaokdN6cK?=
 =?iso-8859-2?Q?1GRPBPa54DxY6cHS35DzF4hYxH31HGI/t+6LCYkAoz9+wafrE2cv+NaSQ7?=
 =?iso-8859-2?Q?T+3sSeiOcucnLWYhwP5z5k2RCtY/swuFtKneVK1UTbqJzc27JPkiLdfdoV?=
 =?iso-8859-2?Q?ffb2C8uNzqeTIvcP1tjmFABd7Yq6gG3aW7MDJSHNOk6mHOq+PjkPSsZGts?=
 =?iso-8859-2?Q?SPyrkc2M1IUUWpSWWZyRigjYHxHHXuki8iB3/s+hP+3VMvFcJnU2gew+v2?=
 =?iso-8859-2?Q?5WIpNASNEfLoamnjXslBG4AeiaiBKL2dcCWWCuDVYVKG0gu1hvGJWgqbB1?=
 =?iso-8859-2?Q?4AvfKaDrhuUVebeDRSndPx9wXoXnn2uDEts3xrxPmJrlhsm42D2HWxTa6q?=
 =?iso-8859-2?Q?aIXR7Kt8T/cVRADeZ7Qfs1K14GkLSOrVNzc/5Az6T2qR8y7B/kcBpbnw44?=
 =?iso-8859-2?Q?sl0bVjaPqmT5Obj/dN1wOsV0UxPVZ3+QwUZqIjSl+oNOjb2i3ihXdsjjzo?=
 =?iso-8859-2?Q?kQ1eYok4XrElz08yaE0WB/cvic6VKZpEYfoeReNOzVGrBbhto10Z1y0U6f?=
 =?iso-8859-2?Q?1Yf7SEs5/zUusdF6OEzfJ7nmFuWSfm7zM6LKeuBcOHKZ5PgBC75qiZmKHo?=
 =?iso-8859-2?Q?xu5I4x8M2YoQxEMf+fNmruWmv0YePPpHWfRlRedQZ4kYlHfz4oAS3xOvAl?=
 =?iso-8859-2?Q?iA2esHUYZzlZNi9xHwolVXGzoI/lKzjcxQBVbLQ3yHxuR6wgVwHiUTMtWD?=
 =?iso-8859-2?Q?lbkPrltpOHf+U19uge3TZomOu748ap9fa07yXphLozL0i9zY+P9UXJg4hs?=
 =?iso-8859-2?Q?Yhl3g1acqpkrYa45knUgL4hH90jmBSqLR3kLUhKRpU3vO9pdpqPJUKjGDC?=
 =?iso-8859-2?Q?8bXHAo8Ly0y/jiVr1QRM5IaBb5+0D5XdAyIzv7SEne/N7swJesXBdcJ8fx?=
 =?iso-8859-2?Q?M3tJCheGs6e6jJWdpSpqXMFSerna?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?bWCbSOcZvaKOFtunA310+pMh/9TBNWeda2+BLs9sTlx5lFWHovfG5xMVMG?=
 =?iso-8859-2?Q?i7jZBKuHCe2c9dObuIbmRHFdsPqguIGq8uVOXAwCu1OBfm6/v/ZYfdZP2N?=
 =?iso-8859-2?Q?hW0md3oWOy2pZVPMRzaTh6wJK05g5gNou9TYWMSH/lo5KYzIoEq160xWA5?=
 =?iso-8859-2?Q?sDzAXc8TeoQEV/+czVledq1/2RJVGXplDKIwOhoSqYhsN4pj3OBJ5I4TyO?=
 =?iso-8859-2?Q?NzHqvpAVcnJx15nL2UPXKoutrH47TdkiUH7WptuS7Fm36zyMxF4h2ODTB2?=
 =?iso-8859-2?Q?HCXSGVqrrLM2LvGIR+3YgpeXqE6bO19UduKdvmhe1cwINGFA+VlRxN5dvy?=
 =?iso-8859-2?Q?5IxSLK+WosnW/fyBCDGO6Ezr3QQ/T3egp0eZ6tun5LmIdWyO8NRsvAwmXu?=
 =?iso-8859-2?Q?iWOz1BaJxgIgdMyGzfn9SnOY926awEGeD/ZPC4wDJ2CGIQVml1fwvlYbY6?=
 =?iso-8859-2?Q?y5JhYSlD9a9QGgjoYqSFibnld0S/7ZcY+BuP0JYQlVGiY6Mdjk9uwu2RJU?=
 =?iso-8859-2?Q?Bb7VXGvhaNm20jpulqPXzkIfQa1ogKN0vjlNhqTftFZdI/AOykio2OAN4r?=
 =?iso-8859-2?Q?vLCkBrCLPkKsT5ap9O4rpusjCgngNoToBYUPMMs3eL+5PizOf680j/+K0s?=
 =?iso-8859-2?Q?8JpqYTcGQ4p1c5mTrWxYEctV+EcfZdKB9Lb8eCjRhEjFC6cGFoMUW8ZtnT?=
 =?iso-8859-2?Q?0nsP9NUg/08aJURLoUMN3mavqXy8TFIqD7UGL8a323G+eOMJZS9CDCoCwv?=
 =?iso-8859-2?Q?zZwR4Euwwiskbc2ynn1R+iEB62aMtu2/3pIf/mFaKsJ8+8AHYQUjYBoyBG?=
 =?iso-8859-2?Q?GVk6K9yjxMvqwHK2D4RWYmN/VdQ5fB+l4kMTvEt7f4Swab+8Zg7ieZCcbb?=
 =?iso-8859-2?Q?A8T19/SiFfQHP1biajDvf6OOGlEzoWv6q2Zi3pCPmw7nQNLtdClWL15EcU?=
 =?iso-8859-2?Q?Q8P4iucD91rwQbPDjSJg1SweX6bEQwFB+swxjS+B99gxL7rhyoNzh8oLCZ?=
 =?iso-8859-2?Q?iz6XTSH7oT7BuccIpZCbnbc+NAGPPxBAWqUzL63mFqd+43JFf+zQSb9Lfl?=
 =?iso-8859-2?Q?mmynqYVR48jr0YiYo+Y9nb0fOwQxpERsCAyrATrLb21zFeGo4o6oEz6Exr?=
 =?iso-8859-2?Q?Teo9xBrmPLZjYRnQA7173+4+uyXRfWLfTl4GI8LdAZh4xxASCxLtm1cerA?=
 =?iso-8859-2?Q?FnG34v7C57BEFcLDk2mzslRPHVxLwfWgtJiTDr6431lkHBgVg3bgrhg7dy?=
 =?iso-8859-2?Q?9nFlcVLWs3/rMztR2uogrlc4sPZBT12Rx/ujGNtvnsreJSHR4pWD0/UL8w?=
 =?iso-8859-2?Q?7Nzhiwx7714guVRnPaPj+wDAtDNW4bq2mGvVdhNyrJfm7nWa9Iz0D3OJDR?=
 =?iso-8859-2?Q?d/kLDcBkJHjOwjkO9xsrf4ncEQyj7WLoK513djwg+BvLwn7iu+WJ1xZ/lg?=
 =?iso-8859-2?Q?nPZjaTyRNHQt5wffOx3PZ3NnpNXuPs7DdXewUoB87geBHwi4oj7GG8j+GP?=
 =?iso-8859-2?Q?qSs9sI9CG86dhh9dG62P75Ox74wrUOqQYcSokEom6QjDGS4h/M01nyIvjn?=
 =?iso-8859-2?Q?c0I2Q0S5VDE4niezCVtN3bJS0fPjRl3EkvS7GrPLf567UHMlNrR4rtdd3/?=
 =?iso-8859-2?Q?Pvgf0m7k54Y5g=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e0dc764-8109-4a17-e2c0-08ddfb48dd1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2025 09:00:52.1976
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7YBL3CKj+QziRX2JOKZxyZjY7eGGkkaVQzQkqa6D33x+Oumo1zvTeImiHZHQURrDjumiqsN6+U4Sp9ZT7srsxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8332

[Public]

Hi,

> -----Original Message-----
> From: Arnd Bergmann <arnd@arndb.de>
> Sent: Wednesday, September 24, 2025 12:21 AM
> To: Guntupalli, Manikanta <manikanta.guntupalli@amd.com>; git (AMD-Xilinx=
)
> <git@amd.com>; Simek, Michal <michal.simek@amd.com>; Alexandre Belloni
> <alexandre.belloni@bootlin.com>; Frank Li <Frank.Li@nxp.com>; Rob Herring
> <robh@kernel.org>; krzk+dt@kernel.org; Conor Dooley <conor+dt@kernel.org>=
;
> Przemys=B3aw Gaj <pgaj@cadence.com>; Wolfram Sang <wsa+renesas@sang-
> engineering.com>; tommaso.merciai.xr@bp.renesas.com;
> quic_msavaliy@quicinc.com; S-k, Shyam-sundar <Shyam-sundar.S-k@amd.com>;
> Sakari Ailus <sakari.ailus@linux.intel.com>; 'billy_tsai@aspeedtech.com'
> <billy_tsai@aspeedtech.com>; Kees Cook <kees@kernel.org>; Gustavo A. R. S=
ilva
> <gustavoars@kernel.org>; Jarkko Nikula <jarkko.nikula@linux.intel.com>; J=
orge
> Marques <jorge.marques@analog.com>; linux-i3c@lists.infradead.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; Linux-Arch <lin=
ux-
> arch@vger.kernel.org>; linux-hardening@vger.kernel.org
> Cc: Pandey, Radhey Shyam <radhey.shyam.pandey@amd.com>; Goud, Srinivas
> <srinivas.goud@amd.com>; Datta, Shubhrajyoti <shubhrajyoti.datta@amd.com>=
;
> manion05gk@gmail.com
> Subject: Re: [PATCH V7 3/4] i3c: master: Add endianness support for i3c_r=
eadl_fifo()
> and i3c_writel_fifo()
>
> On Tue, Sep 23, 2025, at 17:45, Manikanta Guntupalli wrote:
> >  /**
> >   * i3c_writel_fifo - Write data buffer to 32bit FIFO
> >   * @addr: FIFO Address to write to
> >   * @buf: Pointer to the data bytes to write
> >   * @nbytes: Number of bytes to write
> > + * @endian: Endianness of FIFO write
> >   */
> >  static inline void i3c_writel_fifo(void __iomem *addr, const void *buf=
,
> > -                              int nbytes)
> > +                              int nbytes, enum i3c_fifo_endian endian)
> >  {
> > -   writesl(addr, buf, nbytes / 4);
> > +   if (endian)
> > +           writesl_be(addr, buf, nbytes / 4);
> > +   else
> > +           writesl(addr, buf, nbytes / 4);
> > +
>
> This seems counter-intuitive: a FIFO doesn't really have an endianness, i=
t is instead
> used to transfer a stream of bytes, so if the device has a fixed endianes=
s, the FIFO
> still needs to be read using a plain writesl().
>
> I see that your writesl_be() has an incorrect definition, which would lea=
d to the
> i3c_writel_fifo() function accidentally still working if both the device =
and CPU use
> big-endian registers:
>
> static inline void writesl_be(volatile void __iomem *addr,
>                             const void *buffer,
>                             unsigned int count)
> {
>       if (count) {
>               const u32 *buf =3D buffer;
>               do {
>                       __raw_writel((u32 __force)__cpu_to_be32(*buf), addr=
);
>                       buf++;
>               } while (--count);
>       }
> }
>
> The __cpu_to_be32() call that you add here means that the FIFO data is sw=
apped
> on little-endian CPUs but not swapped on big-endian ones. Compare this to=
 the
> normal writesl() function that never swaps because it writes a byte strea=
m.
The use of __cpu_to_be32() in writesl_be() is intentional. The goal here is=
 to ensure that the FIFO is always accessed in big-endian format, regardles=
s of whether the CPU is little-endian or big-endian. On little-endian CPUs,=
 this introduces the required byte swap before writing; on big-endian CPUs,=
 the data is already in big-endian order, so no additional swap occurs.
This guarantees that the FIFO sees consistent big-endian data, matching the=
 hardware's expectation.

>
> >     if (nbytes & 3) {
> >             u32 tmp =3D 0;
> >
> >             memcpy(&tmp, buf + (nbytes & ~3), nbytes & 3);
> > -           writel(tmp, addr);
> > +
> > +           if (endian)
> > +                   writel_be(tmp, addr);
> > +           else
> > +                   writel(tmp, addr);
>
> This bit however seems to fix a bug, but does so in a confusing way. The =
way the
> FIFO registers usually deal with excess bytes is to put them into the fir=
st bytes of the
> FIFO register, so this should just be a
>
>        writesl(addr, &tmp, 1);
>
> to write one set of four bytes into the FIFO without endian-swapping.
>
> Could it be that you are just trying to use a normal i3c adapter with lit=
tle-endian
> registers on a normal big-endian machine but ran into this bug?
The intention here is to enforce big-endian ordering for the trailing bytes=
 as well. By using __cpu_to_be32() for full words and writel_be() for the l=
eftover word, the FIFO is always accessed in big-endian format, regardless =
of the CPU's native endianness. This ensures consistent and correct data or=
dering from the device's perspective.

Thanks,
Manikanta.

