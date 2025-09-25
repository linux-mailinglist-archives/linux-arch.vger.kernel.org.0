Return-Path: <linux-arch+bounces-13766-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D41B9E504
	for <lists+linux-arch@lfdr.de>; Thu, 25 Sep 2025 11:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63D87178F8C
	for <lists+linux-arch@lfdr.de>; Thu, 25 Sep 2025 09:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D490C2E8B71;
	Thu, 25 Sep 2025 09:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bJoduSRa"
X-Original-To: linux-arch@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010051.outbound.protection.outlook.com [52.101.46.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF3528031C;
	Thu, 25 Sep 2025 09:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758792401; cv=fail; b=eoyozwcb22B/k0EOG22WxLeUflT8jEG0O35pJ1dDHbAC0pU2zMyzC4+X0hMvwTyFw+ERe9wRbB8fY3iq/bqSV6iaMIJM9RIG/RMDAl0vHsFOS/nROHXeiPY14cWXE+AU9P1PH+M2lfirE3KUSxa9hJ1P0t8w/aWqXglv3lSZKAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758792401; c=relaxed/simple;
	bh=36KKQmgAjR1nKGI1kMx/mVBLHT9fX2tXB4DuQ/4oC1s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jEdaIVudlRhllA+cIt20oo6t/Esy/WHqHgVe+6j6uc5dkuiU3VGUujijLQPDyQHYYulxZl92A6A1YNtdrCb83b0u9meo9q3Zs7ZYW6TtB4oYiQA3XomRKuTU/+PtME+kKbNgF/1920WlPP9ibkXDNGM9x6DiWAGtOtyUNfn6tsw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bJoduSRa; arc=fail smtp.client-ip=52.101.46.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cV+G6QAnyo4Tlj5k8QUoACeTcy4O8ybyBRCkY7CfYJCusYQkEmlCdSgvg6O4mYSHF7O9A+60kdUvSi9RCfwSE+1C0zYCb8FXxKWGR8mqdglmrvuxEmSIeQbfASskz/RKeXtc9iZSPvAQxZIjoZAJ8+CBNic1GlLiSqt7lEUBHxuaxbxqeVKVo04FdUGsZ3FKpwPmsp/8TUf/V5y+vBOyenlXw1S19ttUMinjDZ3q2K+MdGSKvqxDGoWtcxUpOQiz827SkYu3yGWA9hJTxRpVEQEVfslU+N+0BW52BxKlHTgAtNtpXZM/C82p9oUCKCV2Ers050XBowj+poCsFi+ZPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=36KKQmgAjR1nKGI1kMx/mVBLHT9fX2tXB4DuQ/4oC1s=;
 b=jx0o/FaLrreQPBUAKJ7/QuqTz7YYuou0F/59yZZaajVc8HgtiC0rpGWGJFC4f5U9HyYYS41nHqVbRpqab6YQlEAdx+K+VBGO4Qi/G6HPj32V5ek8YrngxEZwH6fUbunf4YgqZMP3EbSZG7CHtlBPhDl6vlNdRvKiWIOJtwxmieZTJFDPXwi2OkNxFi1ewNRucUApPJcrReVzth3vjcpLw/318JDd1QEpHIM0BU2SRxrZ7hBHHVQlIGt4Aabf6nAhJEVVQ+wGmvhuNGeRGWCLEKoXJoraptDFzZP9u3de1kXoPOGW0J+363dywFE+G0rNBxzKy4lmvlcEbhaITJVD6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=36KKQmgAjR1nKGI1kMx/mVBLHT9fX2tXB4DuQ/4oC1s=;
 b=bJoduSRabc5wjS6d1HJvOF6a/ADw0XIjjACb4vNIn2gEb+29SswZuRuoeVxlcD6DOGaUA9/y8Wy9CtLCRrZI8USMFnE2w63NbS5DuvmoUy2Wg8fChfWHdBFoedyXba/WXRU/MBX8N1KgzPYbATZJD0MgXPCSG7/w44CulyflDtQ=
Received: from DM4PR12MB6109.namprd12.prod.outlook.com (2603:10b6:8:ae::11) by
 MN2PR12MB4224.namprd12.prod.outlook.com (2603:10b6:208:1dd::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.10; Thu, 25 Sep 2025 09:26:35 +0000
Received: from DM4PR12MB6109.namprd12.prod.outlook.com
 ([fe80::680c:3105:babe:b7e1]) by DM4PR12MB6109.namprd12.prod.outlook.com
 ([fe80::680c:3105:babe:b7e1%4]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 09:26:34 +0000
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
 AQHcLKFhrxQvMAo9OkSHor4BRo6l1bShHNCAgADPJECAAC7KAIAAJThQgAAfVACAABEjwIAACgMAgAEkxmA=
Date: Thu, 25 Sep 2025 09:26:34 +0000
Message-ID:
 <DM4PR12MB61090F307DBA2B99AFC93B168C1FA@DM4PR12MB6109.namprd12.prod.outlook.com>
References: <20250923154551.2112388-1-manikanta.guntupalli@amd.com>
 <20250923154551.2112388-4-manikanta.guntupalli@amd.com>
 <13bbd85e-48d2-4163-b9f1-2a2a870d4322@app.fastmail.com>
 <DM4PR12MB61098EA538FCB7CED2E5C47B8C1CA@DM4PR12MB6109.namprd12.prod.outlook.com>
 <4199b1ca-c1c7-41ef-b053-415f0cd80468@app.fastmail.com>
 <DM4PR12MB6109E009DAC953525093FE808C1CA@DM4PR12MB6109.namprd12.prod.outlook.com>
 <134c3a96-4023-47ab-8aa9-fd6ab75e5654@app.fastmail.com>
 <DM4PR12MB610989A03A7560F2A03792838C1CA@DM4PR12MB6109.namprd12.prod.outlook.com>
 <295ee05e-3366-4846-9c8b-85ac09d79d48@app.fastmail.com>
In-Reply-To: <295ee05e-3366-4846-9c8b-85ac09d79d48@app.fastmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-09-25T09:17:07.0000000Z;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6109:EE_|MN2PR12MB4224:EE_
x-ms-office365-filtering-correlation-id: c47491c2-d132-4224-50f8-08ddfc159ee6
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|7416014|38070700021|921020;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?sh4KDjTgYD05AH2uUlYog4PlescxtCVb7VNEMc5xw778qnHcFnY78ZqkWK?=
 =?iso-8859-2?Q?imHyo3lYkJFgRx3mkE0gfadSq4UHzpTnc4ODhT8kB9PHrYh/PABTK0l8EV?=
 =?iso-8859-2?Q?yztifdGerl1ehlgX3lhCLQCo0pW1+ccs2cZ8fF81zp7r+lPerK++Yqq2ce?=
 =?iso-8859-2?Q?fKew8A6xC+GzIHZvKWn4KZE7srrh2TTprz46xJvEfwxKUZkpKB0zqTboBC?=
 =?iso-8859-2?Q?E76IUdfuljxPHw99xdDOC22fL9ub6SmdGR2e0Fd5+xZSmhfVKpVu4bAPc0?=
 =?iso-8859-2?Q?XaG5G53MOcHVsCoAHasHSFdmnei206XLaBzUlXwA8EtgVN2guOb/0nuei/?=
 =?iso-8859-2?Q?7ShqL5V81kJXJrOxvkCe5ATlEbqvuwxe1VFpoNyJFoa/5O3vObX69Cd6qW?=
 =?iso-8859-2?Q?n2Ze+HE6OpT2WZEa5YYixbtX6uG0cPF6sd6KLqW1QpJxiNQrsYEqkAZTtE?=
 =?iso-8859-2?Q?UjbYQ23keS8kK8V2YSlj4xgcsbzqjauETc1NqnglQs8bHzg983JXV4sj83?=
 =?iso-8859-2?Q?4GqB98hx/jVxek5e5RyYaR7X709PhQ/r9msGJsFi/CR20U/Bflkw0Dzff/?=
 =?iso-8859-2?Q?4ELZml/VZi7VSNjo3nHrFVEuqwgPC4wflc89qEgOZEZnhXU4Os+8yUMavo?=
 =?iso-8859-2?Q?9myUQTH9WbPQ4CN2bjhiAsLzUp6mBHgqeHh26OM6ltAjszV8oAjfSSKki9?=
 =?iso-8859-2?Q?Ey+frUhTCZmyqQCgeZQ3VcJcEeexzolLKjHe0s3XDbXT+EXV9sbhFyaTix?=
 =?iso-8859-2?Q?jeVYOjkVp07ouOoWD1AJncXGPjvyziKNdMuOYea+QC//YQTLrXBhGlfYlG?=
 =?iso-8859-2?Q?D4md5MmzPWdbNSRDePFw1HDwmC9wSU+/ncAEtc2WQ3eHx4evDUwiwq5Czk?=
 =?iso-8859-2?Q?aJZ65R5o4z8+F6gwtLfAIiwAuCB76jw0ZLFQXdphZh6tVmJqhlvY4RY7bx?=
 =?iso-8859-2?Q?r8SxAtP0FQezq9ok763SIgZJBmU8U7xO8WuBFTxwiScsvTqOY63XV2Lp5p?=
 =?iso-8859-2?Q?8NBzloBdQJ3OPezx07eToB9cQ4NYMIApUnx3G/DgdcBNqfvWniD3oyMgDO?=
 =?iso-8859-2?Q?FzE3eikTMALnvJfkhmqiroPuGlq3l6mZkL4MrvNWRvZQHAoz4sQaRul5sa?=
 =?iso-8859-2?Q?08rmO+MVdq2zEnvldnKsyGs/dip+1IUGrPDPBZ0rvb+A1bffr2DQjcYkDK?=
 =?iso-8859-2?Q?/k56npMECHt8nZpJKvMWt3bXaJ6SnhujqJ7oroiMhgCDFQu607xwiaOB+I?=
 =?iso-8859-2?Q?+PN+EAx9boGYXjIg21rCP3rD+SSXP2fupd1vX1nGlM+CXF7KP4Rt+eiE9T?=
 =?iso-8859-2?Q?Hon86kzw2YRFFH5ec52ZnS0Ff3SGLsGHa9XxfGIcQPSskSEr6AMt5wsH4P?=
 =?iso-8859-2?Q?GuhWWuZ1e33gzufpdfiyqm+bAW/vbo43pLbX7gVsUhAbPnpnx1mofs0Alk?=
 =?iso-8859-2?Q?JII4UhkdXCfP20AD09+blBqkLjf6Wpu04Sr68stRMpF6jzAh0cZsTuFlNw?=
 =?iso-8859-2?Q?0wN+LHlS4YPT6zapJKZnb6LHDZ8/KotdxrflTLfK1EBTtbyqmNQwYiKPI0?=
 =?iso-8859-2?Q?dRgV7om3H194XVt6Nf58I8q6Y7Pv?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?uee+wDIvSHP4M/QMfMkKrDBDKaaODgH0CAm6faHp5qYfzAuQh+OtlBYe2/?=
 =?iso-8859-2?Q?zO6I1NDQQ+YED3opBWtE+yR9vI/qsqNXeFjBuhwOl8T2MgxczfZF6z6D8O?=
 =?iso-8859-2?Q?n77oCtXfbAAP9avBPSYMI1xTYqedJbCS893gVT52PPOP3I6LFAe4TBIjTm?=
 =?iso-8859-2?Q?zcH2XnULWBTaz1Y1oQEZqNrAFrBXyAYIV7pQk/M0BWTOcxuLRUoFtNNbKm?=
 =?iso-8859-2?Q?DONUJaB8uMEHD2rfLk7TCmpEncQ/pwG4lulVS7+lA1RDqbHyhqeIUrGGtL?=
 =?iso-8859-2?Q?Y1FNDypGFff0nMFOFPAAkGe6gwYEKDh/U5zP68Du5W5VgMlu37FLnY9odl?=
 =?iso-8859-2?Q?m24LhLLRdY/PUl0F8ZlpOZLejpOkj5MTkYUcS+4AQqE13aOYS2hTBW91eE?=
 =?iso-8859-2?Q?nuuz+jsTv097ZiiLNLFi9qvd6eSulDnJCfxCQUcj42oQ7/ENTj9z/voxsk?=
 =?iso-8859-2?Q?itsvX/z4vgbg0pRw+w4m9oHdd7BVDY40/IBWOgBu8pp5vIgQJ8aa3uMD8w?=
 =?iso-8859-2?Q?Bu9hFqjHIje+rJQHbDBzx98sGcwuvhCKsXnFLqqGVH9DKZHxV6sld+gIlS?=
 =?iso-8859-2?Q?K1hM06HGtqChJ/2kzAa9BoRJ4SCEVFMAZvT2vgIPbrPNGBDdIpNT+8PYRo?=
 =?iso-8859-2?Q?pRk/yhYzjS9Is6qkJl0sHjUBEnEQeLDFmdH8uag2wAyzboy2gHWo0/VCG1?=
 =?iso-8859-2?Q?6WIOHmOy6HXqllOE0NdeD/PBEtZBYgwKDXcltKI79CdYJz3a72vOgXXQZb?=
 =?iso-8859-2?Q?mlM3YqEPn8YsSq8y53UkaZLJE3rVjyLV7g0NtJoiSEWLknYxgbl+NtQJ1s?=
 =?iso-8859-2?Q?S2NpmUWXj2jiwoyPgkcWUtcov1U9hN7f4BkiJixUXYL01x8gUBBBWmmTt7?=
 =?iso-8859-2?Q?gMU6wjXJfbjCiY0ZJ7k5Ogr+yOhyyQ6HeJqAu9eTadQN69Mgj4I1fOVvLX?=
 =?iso-8859-2?Q?wvuM9+HO0GWyvf4XUqo3BHTBLsssHjE6IR+rGPulXCVjFCfnhxbU2eM3Hw?=
 =?iso-8859-2?Q?3B2wxNHf6HIgL7bkaNCpxpgPp+/jO7OtVS3r/UDu05ttiWVTbejuRLafgC?=
 =?iso-8859-2?Q?LyMoKVf/w/Qu7Rxn1aiYWAMfw6lMr73r9sRXqrACOpSoSPpSFmHO2OT8ON?=
 =?iso-8859-2?Q?NlRmCfmDKWOp1+H5mv+r8KntPXAH+ksFYTOXgVbhA5SVGh6acN8TrrhfBw?=
 =?iso-8859-2?Q?w1zlUbc6KRC57M7ExMAJN2xJZ4K3r+R1M7zq9srRUJLvFldM8LI1i/qy/Z?=
 =?iso-8859-2?Q?9/5Vz25ChRqJakA67jM23sPmDbZIvxYS1oJLGgqnXPzxjn67nYBonV+TJH?=
 =?iso-8859-2?Q?9INVGTTlHdhN+H8iAq2hCiVs0fB60ZYFREHhQ8M6cXxDmq631k1y7gb13r?=
 =?iso-8859-2?Q?sj51b6lv0UV1AqEgf04Y2meYXOd8MZJzOw2HgstMBW1KwLCcc3UXZoH0+/?=
 =?iso-8859-2?Q?yc1E/RwinqCi6tolGRfeYdComNVYGu1gnvj4K5JM9UH32zJ2Qk9ulmqaPQ?=
 =?iso-8859-2?Q?cFcEITUJ6elc8vhE5fcGLcB6+jROOKWUKL7roIP3C3yvoDBlnVwzIvWmZl?=
 =?iso-8859-2?Q?Q7RLLV9lKr3YuWHXDkuKYtjyjepOyYU0K2W8TR6BIvFCXdd+PQiqTrl8OY?=
 =?iso-8859-2?Q?mDDANEcD+5vQw=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c47491c2-d132-4224-50f8-08ddfc159ee6
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2025 09:26:34.6350
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2/ferPF+OMm1vxltkHLpzDjAGQbXZThXBXgLgvgQhbnX0bs+B176jgBA+DYvyT6cQpCVKBAnvXtyS73PCm+AGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4224

[Public]

Hi,

> -----Original Message-----
> From: Arnd Bergmann <arnd@arndb.de>
> Sent: Wednesday, September 24, 2025 9:13 PM
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
> On Wed, Sep 24, 2025, at 17:23, Guntupalli, Manikanta wrote:
> >> Subject: Re: [PATCH V7 3/4] i3c: master: Add endianness support for
> >> i3c_readl_fifo() and i3c_writel_fifo()
> >> > }
> >> >
> >> > With this approach, both little-endian and big-endian cases works as=
 expected.
> >>
> >> This version should fix the cases where you have a big-endian kernel
> >> with either I3C_FIFO_BIG_ENDIAN or I3C_FIFO_LITTLE_ENDIAN, as neither
> >> combination does any byte swaps.
> >>
> >> However I'm fairly sure it's still broken for little-endian kernels
> >> when a driver asks for a I3C_FIFO_BIG_ENDIAN conversion, same as v7.
> > We tested using the I3C_FIFO_BIG_ENDIAN flag from the driver on
> > little-endian kernels, and it works as expected.
>
> Can you explain how that works? What I see is that your
> readsl_be()/writesl_be() functions do a byteswap on every four bytes, so =
the
> bytestream that gets copied to/from the FIFO gets garbled, in particular =
the final
> (unaligned) bytes of the kernel buffer end up in the higher bytes of the =
FIFO register
> rather than the first bytes as they do on a big-endian kernel.
>
> Are both the big-endian and little-endian kernels in your tests on microb=
laze, using
> the upstream version of asm/io.h? Is there a hardware byteswap between th=
e CPU
> local bus and the i3c controller? If there is one, is it set the same way=
 for both
> kernels?
>
To clarify, my testing was performed on the latest upstream kernel on a ZCU=
102 (Zynq UltraScale+ MPSoC, Cortex-A53, little-endian) with big-endian FIF=
Os and no bus-level byteswap. For more details, please refer to my reply in=
 Re: [PATCH] [v2] i3c: fix big-endian FIFO transfers.

Please don't take this as negative or aggressive-my intention is purely to =
learn and ensure it works correctly in all cases.

Thanks,
Manikanta.

