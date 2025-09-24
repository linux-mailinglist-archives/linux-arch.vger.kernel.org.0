Return-Path: <linux-arch+bounces-13755-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD581B9AA16
	for <lists+linux-arch@lfdr.de>; Wed, 24 Sep 2025 17:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3FC8166AC2
	for <lists+linux-arch@lfdr.de>; Wed, 24 Sep 2025 15:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1453E30FC29;
	Wed, 24 Sep 2025 15:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="u4K+WgtM"
X-Original-To: linux-arch@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011019.outbound.protection.outlook.com [52.101.57.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F062530F95E;
	Wed, 24 Sep 2025 15:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758727410; cv=fail; b=OnRXCKgIUeGJ3/a0I0Bf5VxoxyFDUfVo3omS9Gy4adnBrmv9fHr9wMXajXk+l5KFsHagatInWpDyVEz4J5U0F//Q2WHJ6/EJFLtLdca87gZdqbxhGBZ1nl+ZTPyUKOz36ezAuaZyCmnuetK0TPGDrr4cv5oWDQzwS3an6sEGJzk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758727410; c=relaxed/simple;
	bh=i8UlOOSB+uNEd12G0MoCdbPFaTiX2zg9C0BIFkE+XIA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uxLpDyj9LzaJB8tfat8nCFPGjNsnKU8bpFxMvCg/Uybrw90Z1NWUGTzGD9rudMLLzYYsQChHsQQF7QpzuW/2gnWv8s6JTa5BvX+EkDDeafqX5By1gGbqkKgu9uFG9Uft6ZZ/NdpdLdi41DWtOJd/ZMOjYDvOfAmg12R0fUt2YmE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=u4K+WgtM; arc=fail smtp.client-ip=52.101.57.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CC5831PMz7bks8L6h2hXJwa9r/ANaoTVceNtUnooXGSbOVv0r7DKf5oNlqGMLmMiC6gmiF7y892ITvmiKbGwyiUFo24m7HYrF+9stWeyd39XoZxSLDEC+cvcI3gHExPWgd1kNtf8pTgSTXOxRmrXZdkqPvBMZMsy+wiMArASoio7NAwii0qglbvemAbZmj0tczYvjJRYvOoJ4nW1iFxosrKDyw3vpYlaVAiAIpni8DJtsJGInRxtETFZjYJYBrUq/kcJ7ARp1DIlC3698yL+Z6HkNS5bgt0tdg7KsAsBocP0nxKYdp0mlOb8nVwh3xZI09II+eJciczOMTDgA0MgwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1nhljVTsBRNnKrKTPy3amfCmFGYNjpuqte/gM5vhNTk=;
 b=dNNJj6E1jcGVur4sJ6aQPhGhHxYFYtEET0GXWWWIl0mhBYkwWcw42m/K/yl0dwpIb/SVn9HEClwz+2QGW8+9b2z9pAzezYCBTbXeOigi6BPrxtFD+s68D8W9Fpcd0czVINPTdVVm2kajL6mloMvbo88mU2DRDMxJu6NcSH/Rmc7+ZrzI5JqBkJiSNYpPvGa1yzNrVtamWmKvMlLrG+tIKKfOVkE4bn+xg5v23f2reQZgOqhXJo3rhcdXb4tMtvG5S2T4Rs9VOILK686zfAYIjDkJtoKzG8V06eBTbr6/966zBvL24JGAOjb7GXsmOBr5gz3TeD1wTFsW7xY9Ul1xZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1nhljVTsBRNnKrKTPy3amfCmFGYNjpuqte/gM5vhNTk=;
 b=u4K+WgtMKHb102ixKlZjgJOP4ZoTtPlZ0q/PCY4SctdapywBL7qXJWzj6sGFZj4Jx6Sra1j1puysqU59pCVjfo6aJkf4LfL1Gwjzwwy755zfoqH2pclg+UgYw0g7jgazzeJJV1PJ6MXuIILR1otVKqq0jSCegA7tD5y+5NX6yCw=
Received: from DM4PR12MB6109.namprd12.prod.outlook.com (2603:10b6:8:ae::11) by
 BL3PR12MB9051.namprd12.prod.outlook.com (2603:10b6:208:3ba::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.19; Wed, 24 Sep 2025 15:23:21 +0000
Received: from DM4PR12MB6109.namprd12.prod.outlook.com
 ([fe80::680c:3105:babe:b7e1]) by DM4PR12MB6109.namprd12.prod.outlook.com
 ([fe80::680c:3105:babe:b7e1%4]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 15:23:21 +0000
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
Thread-Index:
 AQHcLKFhrxQvMAo9OkSHor4BRo6l1bShHNCAgADPJECAAC7KAIAAJThQgAAfVACAABEjwA==
Date: Wed, 24 Sep 2025 15:23:20 +0000
Message-ID:
 <DM4PR12MB610989A03A7560F2A03792838C1CA@DM4PR12MB6109.namprd12.prod.outlook.com>
References: <20250923154551.2112388-1-manikanta.guntupalli@amd.com>
 <20250923154551.2112388-4-manikanta.guntupalli@amd.com>
 <13bbd85e-48d2-4163-b9f1-2a2a870d4322@app.fastmail.com>
 <DM4PR12MB61098EA538FCB7CED2E5C47B8C1CA@DM4PR12MB6109.namprd12.prod.outlook.com>
 <4199b1ca-c1c7-41ef-b053-415f0cd80468@app.fastmail.com>
 <DM4PR12MB6109E009DAC953525093FE808C1CA@DM4PR12MB6109.namprd12.prod.outlook.com>
 <134c3a96-4023-47ab-8aa9-fd6ab75e5654@app.fastmail.com>
In-Reply-To: <134c3a96-4023-47ab-8aa9-fd6ab75e5654@app.fastmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-09-24T15:12:43.0000000Z;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6109:EE_|BL3PR12MB9051:EE_
x-ms-office365-filtering-correlation-id: 6f0c10da-1a9c-4b21-18e7-08ddfb7e4ba1
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700021|921020;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?uBn/c34mYg1d8TFLTya2ExAauJT7BRL7QpVNahvKAFs+nCq6UQQNyd1dwQ?=
 =?iso-8859-2?Q?Bri3k7Eifyd0YfHSUSQwcdD0VEO5byDQyPXruBBkHB7TR5KFtP2AHzhuQF?=
 =?iso-8859-2?Q?W1mF6K6gSinKNeXiwKN7kFZYOcHCNWzWtPA+pWxo0oUWpTZtkBeB8w1DoC?=
 =?iso-8859-2?Q?AOtjtDb44hbcsXRhemHrOtRBVq9XcKWBoofvP7IeZPiGSrzlt/W0J/8hMe?=
 =?iso-8859-2?Q?6+hAR/x5Hlap/GP9ox70JtU5NIy1yovLviLQ0DlqihDmiuZ44H52xAll/i?=
 =?iso-8859-2?Q?jlm7jCI62X3lV/8SX6Lq5f+vF/jbLVrLloxCEBiOeZuTvsj+wY7iwyTl6z?=
 =?iso-8859-2?Q?f09kRzR5+y1yYMwy73TWiuzt6RWq5bDNGiG+nphk0Z7JB9daWHtPFdQ5hj?=
 =?iso-8859-2?Q?RcgJ7ugB+baogHlrLvoeE1W2DQAb4hOF6bjrWlHNTqUb3lVLMyp6FI8oMW?=
 =?iso-8859-2?Q?NnPLd0t4M2Jcv6ofHjSsiagRKUbtsWj94ypWDL+b+vidGOuTtpqmimQ0jl?=
 =?iso-8859-2?Q?9ZmLGVPJUa88rfw0uVAR2MlPkl91ZLFDaPYOIGwQJ/BuIQZf209FX41BcJ?=
 =?iso-8859-2?Q?c4PemOAxJYq3eucj4111VeReIZZyzImwwIFlYMdeNBK/Cop+y+z1rFs115?=
 =?iso-8859-2?Q?p74kGKIU5utdoEuBy9Q8du4bB2lniiAiWQlobZG/FqqwXKfCk4+fifLvbk?=
 =?iso-8859-2?Q?3TN0RRZOfeOBjZpJsvAA44wn5vpfo5Eg6mb0ZJY++s4yxetFB+yv0zb5Wo?=
 =?iso-8859-2?Q?1dxmFm3EEeijoYk+ZTTPL9ymBIrG68PinYh4SG4d81nRdd4MRha20vLLTa?=
 =?iso-8859-2?Q?21ng+d8gQw9HMxAaesNQ4a+3rp4Vm9+N/fJ8/kEiaCBFxOEK/wstvvdZFI?=
 =?iso-8859-2?Q?W0YwryQskswPIpweUykx3fpf+F4nUrcMK5M+NgCpOEB1odVgHEcl5Qz6uD?=
 =?iso-8859-2?Q?e8lseEulCWoqIZz3Vul56ACriPrEftInSQEDWUxOwED5v8I2gO3zAkL3kK?=
 =?iso-8859-2?Q?UM2Ao/8XTW+T0c1/tomoIiAykggFGleoS204cyxaMxUSNvHdgLXbCqYvNL?=
 =?iso-8859-2?Q?B0ceEkK9LSpMhQBWUf/zHC9btYxPEXPQqD44uDL9BKM6AVkrvS5HCoS8OI?=
 =?iso-8859-2?Q?KmuQlgPiDz8+/lqGz6cNN/T8SWikw30OuxAzw9NYUgz1LM+aqHDlg9Oe5E?=
 =?iso-8859-2?Q?RpIAwJVeeiZCKD/6kiLRTktSOgp5KdNy3HP0AZHR5deZgAmRQ6WQbTrYf7?=
 =?iso-8859-2?Q?nD0r2EEBi2/bMnd7cLmnlhx0KI1Huz80H6+rMuy8IqBjceCimGHUyy273e?=
 =?iso-8859-2?Q?bB5M8u0EPCq2TgqVmw43hGfA9S8BFMGsEyy1unLdVmEeUfe0M5DT7u/QFL?=
 =?iso-8859-2?Q?9zsW6VQ6OCe9tCHyes6u9kePE2odB9GAhus5qLjV+L99psYys6nwdIOm44?=
 =?iso-8859-2?Q?9n/eabGw4pCwsjq68cjLtsuejd4s++JcJ0VNlRo6lVzZi6F2YL/I95p0v/?=
 =?iso-8859-2?Q?9ZZIQj/8fXpRl4Cg9OgXPxoq6+esTLuLnUnLDknMRcfZ+xECmjHhqr9xgG?=
 =?iso-8859-2?Q?PDcwq2Q2BIPYrC05cvQXN2j2YFGb?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?fcZaYhGbg1pYZ4J12ovWKaBMnDPf6COW9URhCKBZbwBEC6JZk5XY8xiJAY?=
 =?iso-8859-2?Q?GFU33nVttw7zNCEL5A2W35PExbHQUlrgXCU0V6FsXuyo6HPZAmdgWRfqx4?=
 =?iso-8859-2?Q?mqBGGn7KtxUxELxCeljVY1NIKP+Ih1dTWudxf11kzmxcLIgVzKM2nz/pWJ?=
 =?iso-8859-2?Q?HQ1LPs10igw/WihM/RKK1adIzIfBTmXCUfq550dNk23RtaP4onkRWkpYRS?=
 =?iso-8859-2?Q?vBTLdWDlozebb/msB61FFPuHxd68Ph0fK/x69Sk5qaDslCD9eY3jkwsgTf?=
 =?iso-8859-2?Q?WGtKhR52obZ/09kMPpTBiDzPlorGVlkGrH9pHpnx2DBXqKZ0C2216WMXpV?=
 =?iso-8859-2?Q?cjwte+30wNpUbqq/2NDRUek49MaLPnXUkBZq9d0juGW+dkQEH8RKI8kR0q?=
 =?iso-8859-2?Q?jlc8WFMtdXCWWJA4uwJfVkN5p7BYuuGWoqC6audo8zNTtKe0bBhiThLXLo?=
 =?iso-8859-2?Q?gIxe6BrtK7uqPeQ5jhSqHM3zPkoPSdM2pmXGupEkHJqk8dhqH3A6PdOHjp?=
 =?iso-8859-2?Q?JwQNr4Btng9WDCtvSpmPPDZmDQFvffjOgu3Mk/RdXwA2wwETGAOnR9oV/c?=
 =?iso-8859-2?Q?UMEMhodvyX9J5Qw2NzQt9N4HRd2iF5oQFpPf5Oq8CUYM/5L2RDDgm+2Ky9?=
 =?iso-8859-2?Q?vCHPBixc81XlKJQIccBOgnCOEpLXi7lbEHAp5mVOINgndh7X4GE9wsJnIA?=
 =?iso-8859-2?Q?lvurNqPTwbUySq1uBR4/7pUS/VfiX8KVtLWQr0vOWeZl1geCc/t6ZAY5Ki?=
 =?iso-8859-2?Q?jgqltTPQoN9VBtmBqoPzF/4aIciUeFBgSK2lvUKDlOyiF+WAewVtsucgla?=
 =?iso-8859-2?Q?KzKneLPDGknXdSh7aPAOdeUq++3l+bvfbqpcTsXjNRprWqfA0Nwxh1oIhs?=
 =?iso-8859-2?Q?lJnIIQDVGF5bis4VhDQpZnXyak2+F3w7ib47linuzRDwoOJpJbOoMde5jh?=
 =?iso-8859-2?Q?L9URnjsVawN0ECZBaYuXYdHBYwpGBUtw3xk/PyXbPWRgFBJUMg18P7mN8N?=
 =?iso-8859-2?Q?zsbJitEy4KmEgwr9WwoWo70CsuRYD4xV4ebCZxOGUTitSCyE/0KW7CWb55?=
 =?iso-8859-2?Q?8A8qnQx+ZyFJ7XMDUha9AaosRedcN2CQK8QYpB89U6/K0khAiJ2nf4W4gc?=
 =?iso-8859-2?Q?1RsslqXloI+DGPRDnFM04fBYRE/m+OcP7Y7TBg45xkkFycpkH476b4GT6j?=
 =?iso-8859-2?Q?j5rUvxwblI5MwUWHASkRNvb+3QmZExf8PkypP9A3rI40b5NmTLu5b6SJ3P?=
 =?iso-8859-2?Q?QYFCRL8dRn8Hy62s0UOubORr8idfETRqFWOkhwHKcTLIkwZL3nZVh0F7nb?=
 =?iso-8859-2?Q?oPjTylTeuKBwXUATUp9EBhT1OUg/NYzjFiI3gOHx7VXRe8fLelVzgYYHO0?=
 =?iso-8859-2?Q?nBiEd1dN5vi1Cpo+mSfFEgMn+ckIIegZYI+C2EhskxHzpFwekSJreeC4Wk?=
 =?iso-8859-2?Q?nJivDEFWzkhYa/f3wNNaN4wIcIxoEfYQX1790tkx1AvOhc+OyxUaR5TlZK?=
 =?iso-8859-2?Q?Kyvdxmg5nkfKEN1b0eFp8B3K+EVPvlptMplOPAbDAMU0b9LFpyXNujSSxu?=
 =?iso-8859-2?Q?79aTjLb9BvpiKTW/v1LWFf+BP/ytsNgPoyGwIB4xyrM3Z1E0rExhw9G0/R?=
 =?iso-8859-2?Q?jhNpkpW1kBYv8=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f0c10da-1a9c-4b21-18e7-08ddfb7e4ba1
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2025 15:23:20.9407
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DNYSzBgylRnEFIik7d5fGJP1tUWAvqvLSekVixMz1cNsVksnwY1BAWxYaBTQspiytJ+chITqrD2HDiompwqxfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB9051

[Public]

Hi,

> -----Original Message-----
> From: Arnd Bergmann <arnd@arndb.de>
> Sent: Wednesday, September 24, 2025 7:35 PM
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
> On Wed, Sep 24, 2025, at 14:22, Guntupalli, Manikanta wrote:
>
> >> @@ -55,7 +55,7 @@ static inline void i3c_readl_fifo(const void
> >> __iomem *addr, void *buf,
> >>       if (nbytes & 3) {
> >>               u32 tmp;
> >>
> >> -             tmp =3D readl(addr);
> >> +             readsl(addr, &tmp, 1);
> >>               memcpy(buf + (nbytes & ~3), &tmp, nbytes & 3);
> >>       }
> >>  }
> >
> > We have not observed any issue on little-endian systems in our testing
> > so far (as I mentioned earlier in asm-generic/io.h: Add big-endian
> > MMIO accessors).
>
> Did you test the little-endian system with the 'endian' flag set to
> I3C_FIFO_BIG_ENDIAN though?
Yes.

Your v7 code will still work on little-endian kernels
> if that flag is set to I3C_FIFO_LITTLE_ENDIAN, and it will also work on b=
ig-endian
> kernels if the flag is set to I3C_FIFO_BIG_ENDIAN. But is broken for the =
other two:
>
> - on little-endian kernels with I3C_FIFO_BIG_ENDIAN, the entire
>   data buffer is byteswapped in 32-bit chunks
>
> - on big-endian kernels with I3C_FIFO_LITTLE_ENDIAN, you run into
>   the existing bug of the swapped tail word.
>
> > That said, I understand your point about FIFO semantics being
> > different from fixed-endian registers. To cover both cases, we
> > considered using
> > writesl() for little-endian and introducing a writesl_be() helper for
> > big-endian, as shown below:
> >
> > static inline void i3c_writel_fifo(void __iomem *addr, const void *buf,
> >                                    int nbytes, enum i3c_fifo_endian
> > endian) {
> >         if (endian)
> >                 writesl_be(addr, buf, nbytes / 4);
> >         else
> >                 writesl(addr, buf, nbytes / 4);
> >
> >         if (nbytes & 3) {
> >                 u32 tmp =3D 0;
> >
> >                 memcpy(&tmp, buf + (nbytes & ~3), nbytes & 3);
> >
> >                 if (endian)
> >                         writesl_be(addr, &tmp, 1);
> >                 else
> >                         writesl(addr, &tmp, 1);
> >         }
> > }
> >
> > With this approach, both little-endian and big-endian cases works as ex=
pected.
>
> This version should fix the cases where you have a big-endian kernel with=
 either
> I3C_FIFO_BIG_ENDIAN or I3C_FIFO_LITTLE_ENDIAN, as neither combination
> does any byte swaps.
>
> However I'm fairly sure it's still broken for little-endian kernels when =
a driver asks for
> a I3C_FIFO_BIG_ENDIAN conversion, same as v7.
We tested using the I3C_FIFO_BIG_ENDIAN flag from the driver on little-endi=
an kernels, and it works as expected.

Thanks,
Manikanta.

