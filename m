Return-Path: <linux-arch+bounces-13751-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7F6B99D10
	for <lists+linux-arch@lfdr.de>; Wed, 24 Sep 2025 14:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 181AA4A8420
	for <lists+linux-arch@lfdr.de>; Wed, 24 Sep 2025 12:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5269130276E;
	Wed, 24 Sep 2025 12:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XXzdwXMg"
X-Original-To: linux-arch@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011033.outbound.protection.outlook.com [40.93.194.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF272FF67C;
	Wed, 24 Sep 2025 12:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758716577; cv=fail; b=hxR3T8TdabGPbHXXZty+u7RPlWQCTAd73sWYTYjaZ1no/xAu0gilRoq/3g6uRIsA/QV72d8Zfrs6DC3zE+7UZW1zavlHIFCdBcC0nl2r+MRVaft9NSuDK2M9hoHSk21BdjaaiEJkzkLUKBHk7sufWkGW2jyKDs/kMOfhlwyQV24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758716577; c=relaxed/simple;
	bh=Onvxoe2YiAZeRcz1t4CjACMq4RGmZMBo2XZCxhiCmEE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=edgySGoMQO76BGLEMN6p3209N2hkLSr45t9gsFiskUm3XG+BBcZ1MpL1PC4dv2GW4rasBDTSRUgUaW8ugydNg5h3L5IoC+sXlpT6r+hkQ1xluvYSE8FVBKBDPeD8MX7WZg2PnQwbjDUIlOxlAkUgMebX6UjranCWQLlKifwmjeo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XXzdwXMg; arc=fail smtp.client-ip=40.93.194.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h4Gagoq8lyZkRj2cggZuYo52KnkAQSJLI4l62S5C6r+3Q2kwQbDybEYxvIf76/FgR3R78FpewCMQxyl8JAksRQi7wi0uSUnAnWErQajnZnbc6qgeVattuXPGXC9FRH6JD5Mr/u9UGjQFyuTxuQHxON7GTaTH4RmfOEqivhHn6jW6uanoNGDIC7aLTd0+bq1MmjYkr+fICoI24IUiA1nhYxF47dCpIRC7lwD23xAXQK4TnlvLKi0Vp0B4pGyGSeJL5iRF0VgEwcM+494PSmm0I2iOJ6TxwO6jBxnJWPQQTBXiVRBpjlmBWD+nJx9XOev4sfTcQZ47Erv0zhZLw+2hsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i/3uLF0bOuJgsN3iu+AcR6XbWM171NNSnz6JDfyyDjE=;
 b=dN6rtMkcceQy4w+chssHRmyrgW7vejDr9ZMQcxI45C1lx9tLooWSsmcJaKa02CYfRurODDkplW5f1spWElRIfhE0W0UyH+lEWd4zSPHqAhmOtKJ3SlXV/uLDEI4ripVuq9PelVx7LIKC+9LJwSurSD2KiHlVfdL8Zl5NWiU+XYnj54PezT6xNimAcEGrX0hNeQVrCsSTGhLsRFUf2i2TMpV3Cs6fy3pK3dcXihi4wejg2JREddkts1gb8Hs6ko3f9Q1/ZuteoN5aqOYoYFXens1EUwT3g8ceHqnh/wSvj+1ibGE9RccovqtEyLLgDK31nLGxMDP4RB7VtrqfGzT5wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i/3uLF0bOuJgsN3iu+AcR6XbWM171NNSnz6JDfyyDjE=;
 b=XXzdwXMgSsAYSUDoh0nj9oRIDa12DMV2qYC3vDTmdmZZw/QZl26pt6hXDX3zVusIfDlVBJxJ1MXm+SSv67CBfnhmBRhiNfkZJ02976LQsue5Bh+gPM9qds7C6If++htys/spJeKAg9+T90lGEizoLvLrvFfP8W5514yQntfuqq8=
Received: from DM4PR12MB6109.namprd12.prod.outlook.com (2603:10b6:8:ae::11) by
 SJ0PR12MB6927.namprd12.prod.outlook.com (2603:10b6:a03:483::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Wed, 24 Sep
 2025 12:22:48 +0000
Received: from DM4PR12MB6109.namprd12.prod.outlook.com
 ([fe80::680c:3105:babe:b7e1]) by DM4PR12MB6109.namprd12.prod.outlook.com
 ([fe80::680c:3105:babe:b7e1%4]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 12:22:48 +0000
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
Thread-Index: AQHcLKFhrxQvMAo9OkSHor4BRo6l1bShHNCAgADPJECAAC7KAIAAJThQ
Date: Wed, 24 Sep 2025 12:22:48 +0000
Message-ID:
 <DM4PR12MB6109E009DAC953525093FE808C1CA@DM4PR12MB6109.namprd12.prod.outlook.com>
References: <20250923154551.2112388-1-manikanta.guntupalli@amd.com>
 <20250923154551.2112388-4-manikanta.guntupalli@amd.com>
 <13bbd85e-48d2-4163-b9f1-2a2a870d4322@app.fastmail.com>
 <DM4PR12MB61098EA538FCB7CED2E5C47B8C1CA@DM4PR12MB6109.namprd12.prod.outlook.com>
 <4199b1ca-c1c7-41ef-b053-415f0cd80468@app.fastmail.com>
In-Reply-To: <4199b1ca-c1c7-41ef-b053-415f0cd80468@app.fastmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-09-24T12:13:26.0000000Z;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6109:EE_|SJ0PR12MB6927:EE_
x-ms-office365-filtering-correlation-id: d5c0633c-696b-465b-6938-08ddfb65130c
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700021|921020;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?BknK55GFmOgeiGDrk1YLPU268rQKHLJA12zfotOK8VtHpXhviXeOWTel1J?=
 =?iso-8859-2?Q?tv5sMtqD6+PK0I9JTPWx6uZxk8yVB8cF8OS4k5Tb9A3uN6/Ltt0FUZ/Wmm?=
 =?iso-8859-2?Q?thkPYXWQh8vkUSaCcE/tI1pFcQcjSphLUMeXRFLAOFFwPWt9+yZHxPDW0p?=
 =?iso-8859-2?Q?kGHKhfzxX48dZyeQtTfjXFdVdHMVbaVZloO13YFn6+EXz+jNb3iLk1PyeF?=
 =?iso-8859-2?Q?rBhS3RBF/AQC0H6RRu8SUws1jBKFvHzOnv/YVBAA6mUCVBXxrjbi5vuqb5?=
 =?iso-8859-2?Q?WCDeFqE1D1QRVcdbaKzhvVAgsVpZx9eQkCM1oWYSJJfX6E1EjE6s2rO4En?=
 =?iso-8859-2?Q?9sRvUm9vdEzaCA0LQ1uZuuO0noGuxnEjSyYIPw87+sDHc6mt3XP0wCh3Iy?=
 =?iso-8859-2?Q?cjG+nvVy416/1Xk0MKSa3kPZMzptsfUDRyPR8sV6++fqbKWQwR8tWneU1k?=
 =?iso-8859-2?Q?GoEKBWx935ZnjjRqC4sHzFAnNbAku7ONRDvnbT+CNhRz7o3Mr3Gwq76IlG?=
 =?iso-8859-2?Q?GuANXDB87/iBHiqXGS5tBJaZ/JxcZfhVwceFpLkr1U83rB59nvv4YCOjQ4?=
 =?iso-8859-2?Q?PC+wdv0I6QpBmd3D7LYVy3tmv0i0R/DhZoAwBPEl5QiDsjYWihBMG+CZEm?=
 =?iso-8859-2?Q?R1MlJ3dLMdiIxDzMtKPa6zozCreiP18NPWkpC2YleCUOvyLixxkGT6rFbJ?=
 =?iso-8859-2?Q?euwxerEasHMl2TfHtwogrzGb0koaa7969nZDBpTzung7QCBsuQGVP2v1SR?=
 =?iso-8859-2?Q?89eCOFyTVsKcFyOc+Y3SUsLFC39kYuicHleavkPQkK4yVv7jza8Ldo1AFe?=
 =?iso-8859-2?Q?axO3LCvShIxjHdIZIyZFz1zwQfacxyXz/Kbvyx00qCm2B0e2ER9QQ4ES3S?=
 =?iso-8859-2?Q?8BXfzvGFwMXyPaTczK/0xiHWP7Y9AHkoZXKAOLgsvaj7NyuZ9yzK6T3tCp?=
 =?iso-8859-2?Q?BqtGaVjc6kbYP/TJUXyNJlH0UG53j92/qJe4iFnBOqbWD2Ggcy4SUp5qFS?=
 =?iso-8859-2?Q?KHVxOeEPXrlPSkdHHG/Ol0fIQPBYIpL6kDUvaG2ZVfwsMwXXw4ev2ML1Ko?=
 =?iso-8859-2?Q?TFUfzoT9XyBI7EJUvyZiR8AiNbuqZ6AS/KdDluhBDmGUrm8JeNrMGcv1jt?=
 =?iso-8859-2?Q?zJkUMfREiRPG8/6WIBYraw2CFXn5X+c+Nl7WusFtw9fuYQdXjaCLV0HISf?=
 =?iso-8859-2?Q?ee+KTHQiLmJUQJQTsaoG2NJQlnPmKXXszhe/YzBoZCb+jup/s8SKFFP/KP?=
 =?iso-8859-2?Q?NhBdbhiW4t5YucpJd3iv5+eQfOg0gb5dqCNkNd7tokZD4ikXbH35cyEqwx?=
 =?iso-8859-2?Q?6XpiIrd1AS7aWny6rfMvTaiTuhxFXB95sGWTyYpa11aQVfnvg6T6SwX6Or?=
 =?iso-8859-2?Q?4zw7JDthAkDpBQ9UN2kqVDawtN5d8bkMmP2ojGdMjuV1/yVU7XxDNrAs/A?=
 =?iso-8859-2?Q?KRnHJKdCCZu5Q4vA6dqdysY+96cor5pcrO29Y3uYu8m3ek4fYyssWnwlFK?=
 =?iso-8859-2?Q?2VgAg68nMOrUD5icV0SafQrJS3k5Z5EN38TK7UNSVa5lTI1Ip6c/p5GGEV?=
 =?iso-8859-2?Q?tF428RpOpx7V4VcTKgoNpjj7MyCm?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?7eUtNApWPsQtXNyk+/4TRlM99vi8RZXtb1m475BFhblj9HQ/FLvWmD88RC?=
 =?iso-8859-2?Q?VJuamPnBVlHKbB2qCxbxSfeQ4vCIonDdDVi0va2IrLhClTSmwusw1xK/BJ?=
 =?iso-8859-2?Q?Zhe8IF+6+szK2s23hXDX7EYJHBq89tgXJFQFWf5LJsDXmVnLYj+eQEpj1w?=
 =?iso-8859-2?Q?Zz1KbjkojLuyouwh5gEdJ2jgtczQRvB5LbenQe1YO3+MO3pmWCHVk6XcM4?=
 =?iso-8859-2?Q?g/tQ7ZOstjlgYWeqSAnNhxZ3OpWLlo0ATeL/OJxTbilfaBhhllfIW5gM3u?=
 =?iso-8859-2?Q?xSNFxcGeVnhYHZOUOGBfBr0OsPAVZ8VYH/lcGQOLgVSbLmjOVK5JzM7Afy?=
 =?iso-8859-2?Q?PULq8igpU5p78QrQLFA7ijfVGCcSGn3Mm7+OiZOwd16e8GG2m57zJDoXGY?=
 =?iso-8859-2?Q?Rjy02Z6jQynJYV1iSi5eu5DhvTMZw/ARjPypzJ1i1RbQ72y8HMJKSX+Ksi?=
 =?iso-8859-2?Q?PrqN+Zh7zttwqLonO6ig/8YQsqW6W7eqFrMjYKusyjNwU4syI8YHLloSkU?=
 =?iso-8859-2?Q?wTYwpdQ+H6k2+xsL8oV5iJqgCVsfWcv/HNEgqp02ExzK7xbHvDFACrFYyj?=
 =?iso-8859-2?Q?ntBnxaIUqLrS9/UcmdF+H6veSwP/ILUnW3RECSu3LG7AGfVBJijBdFozBr?=
 =?iso-8859-2?Q?Z2gXWPrvBXqxBoQ/IMF+tzXcnYtUrdRFH7KrJ2pkcLgI+RJaUhcgNgdBvw?=
 =?iso-8859-2?Q?4SiEU8fi4tRWlOxCzT9xVzE1lwVVSwlXuYHWFeh1PimCr2OjNWdteSa9Xn?=
 =?iso-8859-2?Q?19xnJqWt6l1aed+o61Lc1NaVfwBnBze1UxXOF0+HOrOaMLkamcHPKHuXZt?=
 =?iso-8859-2?Q?9ltWgFc+lm1GMuyhNbotV+2r0pkxcR2ksWW37fHRZUBoqpI6llYOEygtgk?=
 =?iso-8859-2?Q?iQRivlq7hmSEciDEJHz4pq8cXcCrSNVseJ1bs0+RmeJzrjwbKxxAQxNWT/?=
 =?iso-8859-2?Q?0rVxRAbZ7SQYSFm5zRKAroT6fBgJYGwEnYRlsr99pX2FukXQy3lm3nhXBo?=
 =?iso-8859-2?Q?LXaNqvk/7hjqel9438Fg29NkCRDyPYRrMvN6nrZYJ4xnRO9WzyTWAwQF8I?=
 =?iso-8859-2?Q?qrw7UxDdZdFa7YpqrWqSelL5X2O/lV31kuw1FdeExpymDFXeqjERJGZKvC?=
 =?iso-8859-2?Q?jEFGPhenHGDZevcAo6jh6BKEUqrR/bkbgiPZf0bAEm9OT5dmQysovvZbl5?=
 =?iso-8859-2?Q?zMev2UYBUyLD6RSwtsDddMKVyeUvLr4x5ij+N79SR6xUIDPQjl2uOvhj5X?=
 =?iso-8859-2?Q?SIzMWkoOQEbuWs4Nd9F8JM8/bdT8dw5dKoQIPuIn/m3vVhWM/5M2wTUP0h?=
 =?iso-8859-2?Q?un/z0bOq/TpxRUSeiZd3o+aHKuvk0R40Aw1tq5kFNdfRYlmqX+1FuolLs4?=
 =?iso-8859-2?Q?YbvXoydHjeBxCcMIfYjrp9foPLF7/McV1rQZKiLN9cAqS82oMgTApOeq2s?=
 =?iso-8859-2?Q?vv5fXhg+mjCvvpvwKR/SZPpyuMT0uB5ocVb9IfNmDFg2XHcMpK/uXKI4e2?=
 =?iso-8859-2?Q?V+ecF2reu6ixjryYK0+cnagT/qXNHCErXCsx3NPF8GCFCQyFR+ZaBA2P6k?=
 =?iso-8859-2?Q?4SH0oHwy869MnCK8FctH9z1S58fLilfoBk+0cYC6OSIJ30SAxpNlRwDjSQ?=
 =?iso-8859-2?Q?FPrthKRsDazI4=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d5c0633c-696b-465b-6938-08ddfb65130c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2025 12:22:48.5754
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HT9AIts0dRJwTU+ik44I+tAVAqaOMBHuBl3cs9VxEo9+vq91RjtaMERpnvAK5w0AbXlJvb1B8PRcSjlYiSn/+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6927

[Public]

Hi,

> -----Original Message-----
> From: Arnd Bergmann <arnd@arndb.de>
> Sent: Wednesday, September 24, 2025 3:30 PM
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
> On Wed, Sep 24, 2025, at 11:00, Guntupalli, Manikanta wrote:
> >> >     if (nbytes & 3) {
> >> >             u32 tmp =3D 0;
> >> >
> >> >             memcpy(&tmp, buf + (nbytes & ~3), nbytes & 3);
> >> > -           writel(tmp, addr);
> >> > +
> >> > +           if (endian)
> >> > +                   writel_be(tmp, addr);
> >> > +           else
> >> > +                   writel(tmp, addr);
> >>
> >> This bit however seems to fix a bug, but does so in a confusing way.
> >> The way the FIFO registers usually deal with excess bytes is to put
> >> them into the first bytes of the FIFO register, so this should just
> >> be a
> >>
> >>        writesl(addr, &tmp, 1);
> >>
> >> to write one set of four bytes into the FIFO without endian-swapping.
> >>
> >> Could it be that you are just trying to use a normal i3c adapter with
> >> little-endian registers on a normal big-endian machine but ran into th=
is bug?
> > The intention here is to enforce big-endian ordering for the trailing
> > bytes as well. By using __cpu_to_be32() for full words and writel_be()
> > for the leftover word, the FIFO is always accessed in big-endian
> > format, regardless of the CPU's native endianness. This ensures
> > consistent and correct data ordering from the device's perspective.
>
> No, this makes no sense: The 'else' portion is incorrect in the function,=
 and prevents
> it from working on all big-endian CPUs because 'writel()' only works for =
little-endian
> 32-bit registers. If you just fix the bug as I described above, this will=
 work correctly on
> any driver calling the current function. At that point, your hack becomes=
 a nop for big-
> endian systems, while calling the function with 'endian =3D true' on litt=
le-endian kernels
> is still wrong.
>
> Please start by fixing the existing bug and test that again.
>
> I know that endianess with FIFO registers is hard to understand, and ever=
yone has
> to spend the time once to actually wrap their head around this. Even if y=
ou don't
> believe me, please try the bugfix below (without your added argument) and=
 think
> about how FIFO registers that transfer byte streams are different of fixe=
d-endian 32-
> bit registers. Note that your driver uses little-endian readl() for norma=
l registers, and
> this is portable to both LE and BE kernels.
>
> See also the explanation in 41739ee355ab ("asm-generic: io:
> don't perform swab during {in,out} string functions").
>
>      Arnd
>
> diff --git a/drivers/i3c/internals.h b/drivers/i3c/internals.h index
> 0d857cc68cc5..0f8a25cb71e7 100644
> --- a/drivers/i3c/internals.h
> +++ b/drivers/i3c/internals.h
> @@ -38,7 +38,7 @@ static inline void i3c_writel_fifo(void __iomem *addr, =
const
> void *buf,
>               u32 tmp =3D 0;
>
>               memcpy(&tmp, buf + (nbytes & ~3), nbytes & 3);
> -             writel(tmp, addr);
> +             writesl(addr, &buf, 1);
>       }
>  }
>
> @@ -55,7 +55,7 @@ static inline void i3c_readl_fifo(const void __iomem *a=
ddr, void
> *buf,
>       if (nbytes & 3) {
>               u32 tmp;
>
> -             tmp =3D readl(addr);
> +             readsl(addr, &tmp, 1);
>               memcpy(buf + (nbytes & ~3), &tmp, nbytes & 3);
>       }
>  }

We have not observed any issue on little-endian systems in our testing so f=
ar (as I mentioned earlier in asm-generic/io.h: Add big-endian MMIO accesso=
rs).

That said, I understand your point about FIFO semantics being different fro=
m fixed-endian registers. To cover both cases, we considered using writesl(=
) for little-endian and introducing a writesl_be() helper for big-endian, a=
s shown below:

static inline void i3c_writel_fifo(void __iomem *addr, const void *buf,
                                   int nbytes, enum i3c_fifo_endian endian)
{
        if (endian)
                writesl_be(addr, buf, nbytes / 4);
        else
                writesl(addr, buf, nbytes / 4);

        if (nbytes & 3) {
                u32 tmp =3D 0;

                memcpy(&tmp, buf + (nbytes & ~3), nbytes & 3);

                if (endian)
                        writesl_be(addr, &tmp, 1);
                else
                        writesl(addr, &tmp, 1);
        }
}

With this approach, both little-endian and big-endian cases works as expect=
ed.

Thanks,
Manikanta.

