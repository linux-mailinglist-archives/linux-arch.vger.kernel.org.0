Return-Path: <linux-arch+bounces-13778-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F2DBA0B29
	for <lists+linux-arch@lfdr.de>; Thu, 25 Sep 2025 18:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77E857A3BE2
	for <lists+linux-arch@lfdr.de>; Thu, 25 Sep 2025 16:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C532DEA9E;
	Thu, 25 Sep 2025 16:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iI6r3MiN"
X-Original-To: linux-arch@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010034.outbound.protection.outlook.com [52.101.84.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D66D2C032C;
	Thu, 25 Sep 2025 16:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758819051; cv=fail; b=AmWbT4sVRHfh/qZYGTFQOyldMAhXnbTp+rzj/cyB+J5msFPcXA7oyhQC7ut8sOl9I2LPXUkjKTOZfnfSChaR0SqJgyZB+wX8QBh4737yRebdFd72j9EZjzjPboRqkKHV/qUWxqDM51bOY2Bi9GA217Zn566Qs+itrNp8o35u+aU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758819051; c=relaxed/simple;
	bh=vvdbDceSNY8IeTMWnknCFiyEugrTqyuvbICgkeI6cc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jxlJGHGCU0s6Sk+ulXSs5+ceyq3509OC/sV7pSSRL5mQlaNr97CBs5hgsGEEEDQ0USqo/DhN38qbuKQLtMQE6ztH0pQ+nSSAOpKx3vKt5d33Sjg++OV+iEXmoCB7vlShDTMMQ8dMLSKaKtRnKVdSRWMatbS/Vkeab9RpIlZkXuU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iI6r3MiN; arc=fail smtp.client-ip=52.101.84.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vnr0LRfeWm3pgUuxCFqbRIoXcd2dvWvtwhaf5ZeC2xjP+XeKs6Nvx3QuK7n3tp2CE0kKcHWrzrXqARVkY+bnqR+J4Q+sI6dWVRRbSOP3FpWfcO5cvnl7PdxmJQKv5SV3K35R0WO6FJeOax5M16ke2If3ir0wKy31ZZk1MLDO7yDWBCvxl0WDxF/I88Ajp7BJJAchhAytpQLif0qRNDmsEQf1TE/LKduH1uFtPIWq33lWqfl3vTVYe45h2cwvTCYFyKtjm/c2qLu7YcQnQ+5gf/MQX7/P+EFJtRsGeijmAjeJ4mlKNNaOY/zNdB1GuHDMGIuW/Fvx0DdmPNVwYvu7DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M2IR9h+SkvS8TFYiCxCdIObSFXD7fvR9YDYLiiw+430=;
 b=S11j6vGtDKoZNAG3fCVJgLt81CpVQFYB/KZxdpjGpVtEgy4ZQPY2NijB1neC6N2BM0TgnfPH8PrcvwLllj79W9/InMf02/eA7cqaj1Z6H1xJ4vRDVyWt1L9YRjKVav+J+nYQEDPd2UwgPGYdFtCBVqAjFnPwmvUdBrn+PJ+Gd5oDG4a1QlkTzhalg2pn0biWj2amaFgJjoOg58KC9l88LPKdUAJaE6lLJ53zGxblOxzsz5dFBew4GZV0f2baF4Cb5UFcQw4u3SI+++aQu2TvXJXHJlihadRyxfaqOwiBZumY/DvjiPm4aWl7BVgpT3bcM10AG0WKdyKHGF6854uMhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M2IR9h+SkvS8TFYiCxCdIObSFXD7fvR9YDYLiiw+430=;
 b=iI6r3MiNIlkE+rJZ9cBfjFzZtXx+820pzQELbnWyiGbnAIkZuB6LcxaeMXeYa2G1R2FjhchCN4ehIZyq8LQEBL5LQwpg3bDKrqH6A4oOTNi0S6WIuJytbGBWLEmX22bVDrqDFSnvEZFa9LcgEA+swNHEfocoT6m0l0S6BZHV2RWvajsaHO0jpqwj/gluejUWZcZf+UG+Zf92Zy/dY1B4gH9kB64cD/7Q1q58VckljZ1GJQ6vGvy8AeYxOlUKQR03rIYBu1OUNwwn2TJ2+B/PWlc9VLZ1onIG447IKY0IiikBGL9piQhA2qJ7Ym6d8Awf0Kv/4jqf1uZDve48ayRlsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by DU4PR04MB10364.eurprd04.prod.outlook.com (2603:10a6:10:560::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Thu, 25 Sep
 2025 16:50:46 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 16:50:46 +0000
Date: Thu, 25 Sep 2025 12:50:35 -0400
From: Frank Li <Frank.li@nxp.com>
To: "Guntupalli, Manikanta" <manikanta.guntupalli@amd.com>
Cc: Arnd Bergmann <arnd@arndb.de>, "git (AMD-Xilinx)" <git@amd.com>,
	"Simek, Michal" <michal.simek@amd.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Rob Herring <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?utf-8?Q?Przemys=C5=82aw?= Gaj <pgaj@cadence.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	"tommaso.merciai.xr@bp.renesas.com" <tommaso.merciai.xr@bp.renesas.com>,
	"quic_msavaliy@quicinc.com" <quic_msavaliy@quicinc.com>,
	"S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	"'billy_tsai@aspeedtech.com'" <billy_tsai@aspeedtech.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Jarkko Nikula <jarkko.nikula@linux.intel.com>,
	Jorge Marques <jorge.marques@analog.com>,
	"linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Linux-Arch <linux-arch@vger.kernel.org>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
	"Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>,
	"Goud, Srinivas" <srinivas.goud@amd.com>,
	"Datta, Shubhrajyoti" <shubhrajyoti.datta@amd.com>,
	"manion05gk@gmail.com" <manion05gk@gmail.com>
Subject: Re: [PATCH V7 3/4] i3c: master: Add endianness support for
 i3c_readl_fifo() and i3c_writel_fifo()
Message-ID: <aNVy22ayfAsw+Zgj@lizhi-Precision-Tower-5810>
References: <13bbd85e-48d2-4163-b9f1-2a2a870d4322@app.fastmail.com>
 <DM4PR12MB61098EA538FCB7CED2E5C47B8C1CA@DM4PR12MB6109.namprd12.prod.outlook.com>
 <4199b1ca-c1c7-41ef-b053-415f0cd80468@app.fastmail.com>
 <DM4PR12MB6109E009DAC953525093FE808C1CA@DM4PR12MB6109.namprd12.prod.outlook.com>
 <134c3a96-4023-47ab-8aa9-fd6ab75e5654@app.fastmail.com>
 <DM4PR12MB610989A03A7560F2A03792838C1CA@DM4PR12MB6109.namprd12.prod.outlook.com>
 <295ee05e-3366-4846-9c8b-85ac09d79d48@app.fastmail.com>
 <DM4PR12MB61090F307DBA2B99AFC93B168C1FA@DM4PR12MB6109.namprd12.prod.outlook.com>
 <b2ce3e0b-a639-4e70-a5e7-ffbdc855153e@app.fastmail.com>
 <DM4PR12MB610946C438F742BA743A0BDA8C1FA@DM4PR12MB6109.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DM4PR12MB610946C438F742BA743A0BDA8C1FA@DM4PR12MB6109.namprd12.prod.outlook.com>
X-ClientProxiedBy: BYAPR05CA0085.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::26) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|DU4PR04MB10364:EE_
X-MS-Office365-Filtering-Correlation-Id: 078a664c-3faf-4a93-7236-08ddfc53ac2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|52116014|7416014|376014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M1d4dFdiYWt6M3Y3Uk5lNy9kenNLV0lEQ2h5WXBXVkdNYVdaVXFpRi9xd2Fr?=
 =?utf-8?B?VXFZNmVqL1pmRWhtMzFnc0RSVnVpSkpOSGtWdXlxZzdiV1gxVmVZMUpHQUpj?=
 =?utf-8?B?blJlbGF0RVBJdDNiNlpzVEYyWWMvTlpxNUNhN1FEZENJdUsvV1AyUFI1bmlO?=
 =?utf-8?B?NVZXd1JKUnRwY3pGbDhxVHBPSFhJTWJYUDZkZVAxeFdFVFFQWktKN0dIWW8z?=
 =?utf-8?B?dVFMUGJ4T2Rjei9xaytaSWJSZDJYa0Q4clcrSlM1dlFhVFhybWZQaDZ3V20v?=
 =?utf-8?B?M3N1bHl1NVU1OFlOSlRsZWpNUStYeVhaaUdxT3lDM2I2K213azlya2Z6dE5V?=
 =?utf-8?B?N013TFh3enNmWHZXY3dRNUZlNlovdWRQdkxxTDI0cjJoZWFaTGdxTngxRnVI?=
 =?utf-8?B?SmFiUnZtVXY4WGtSd0JXOU11UEFaWW42NVlSOHJRVVE3TTQreUFqUHR1TmNR?=
 =?utf-8?B?WHQ3TXRHZ3pGWVdZNkpVKzVUc0FqSWF3WVpZdTVDUGJ2dzBJUFRvbE5DbGVL?=
 =?utf-8?B?cUU5TEg2SFBJYUN0WHdkUHgxTHBKS0xvUG5xeXRBVFV6MVNBMmFob0Z3QlhJ?=
 =?utf-8?B?NVlSamRxcUE1WVI3Nm5xUnVwQXhUV1o1RE8rNXZudldZMlAyKzFFYkZuOGZW?=
 =?utf-8?B?L2FicE03Y1MrOXJ5YWswRWVBNjV6d3M4NkJRbmh2eFZJYk9MV2JEVzlyZzA4?=
 =?utf-8?B?M2phMlRmRzIzMFVaZ3ViOGw5SStvUEFnK2l2T3krQWNpQTd0OVBrMm9Xaktm?=
 =?utf-8?B?YVN5RjFhZEZ2OW5BY3hUdzRvQzhGT0FYTktxL1BlMXd5Qmhwekw3bVg0M0FZ?=
 =?utf-8?B?eDl6SENIVUVEamxQVTdmSmlGTXBUOUdhNnR2Szk3RWNEcjFpcStVenVYZ1pr?=
 =?utf-8?B?dE1hSEFNM1YxSFUvQkd6dkM1TnhPT0hWaHJsek5IekVNcldnY0J4Z2E2UEtJ?=
 =?utf-8?B?bWhoYTFsNGw2NXZodzVHQlhXdkNXT2hWNmlWdHBHNURaWnV5YldtcFZhbE05?=
 =?utf-8?B?RWhOS3RScFk3NjdqMTRXRmlmcXFXNkxNSFF4QU53NWtVMS9HVlo2b2NUQzFy?=
 =?utf-8?B?M1pwVkZBNlk5ajI1K3psWHFoakhDSllxc3lFQ3ZTaXZXMmRVY21mdzFxRWZC?=
 =?utf-8?B?UVZrSjZYZUJYMzFSSWxBTXY2R0d4MHBsS1hUWnh6QWwyR1pEeXpic3RvZVV0?=
 =?utf-8?B?UlBsZEdQYlVWQ2Q4MFRmNXFpZHE5czVCRFNVUXVTNkppamJYWlhMcVViUHp4?=
 =?utf-8?B?eXJSeDNpMzJ3QkpMV0t5eitjZTdKYk1KMy92ZDIvR1FJd2ZVdVJsbVhyZDFy?=
 =?utf-8?B?ZHZCT1JYMGxxc2NiR2g2aEllZ3dud1ByWWJxSEh6ZUk3M2xOVlZFQlhQM0NP?=
 =?utf-8?B?UFZabXA1Zm5XWS9ocjdRZ0xlVW54Tm5XalA3bjRoL0poTWZoSitOU3NDaXN6?=
 =?utf-8?B?bDVqS0tmcWZWRUpYcVNFcDI2bTVpV0xUMVJnSC9ERHpVU3NIY0pWeC93RHhP?=
 =?utf-8?B?dmFCSEVUcUVBM1FvVUthNm16TloxNjRxQXBCdUpSd2JDQnFxRWpOYnhTRUdX?=
 =?utf-8?B?ckNhVjhuVHFVQUtZVEJnUXpoOGVDang2QUhJQitIRWcrSEU3RFY2SmovdWlm?=
 =?utf-8?B?enZqRlUyS2dqWkcxQkFET1YwcjhvTmhuVUNaM0c4cU1FTlNUaTFQU1BHbE5C?=
 =?utf-8?B?TnoxZFhwZk5WWEQvQmp0NzZQT1FpNGlCZi9IZkpKV0s4a2lWTFRFWG03ZVdU?=
 =?utf-8?B?dVNDeWZ1cVRZdGFHWGxLbVNjM0M1cEg1dWc1K2VPYVVsYTVFYU1NNUY2cTdr?=
 =?utf-8?B?M1NINzVqMUJkY3E0V2RMWFdlcXBrb0o3TVR6ZDhUUlAxNVNSWndBZWEzQktn?=
 =?utf-8?B?NFVGU2xsY0Q5ZTFkUnJ5ZmZrT09TT0l1U1VlWDVSWDVpNzhML1lTZ2ZNeEtx?=
 =?utf-8?B?U2xjUlpQM1ZYaG5oVnJidlFTVTdvSjQ2NWhKbTVuTkVTaVFtN215Nk53TFBZ?=
 =?utf-8?B?bHpJeG93UlZRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(52116014)(7416014)(376014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RXdzUnFVdy9XZlBMN201ZzFyQ2s4Y3FhV2Fxc2hvd1hLWDBXSWVWSDFNUjEx?=
 =?utf-8?B?cHJGa3g0M25QTE11dmFBWkJxY05oVzVLcHlhL1JqVUVRUzhRMWowRGJqbnFy?=
 =?utf-8?B?WCs5ZE54b2JYWGYvRjE4bHIwb0t5TFQwL2NzUGt0cFJTT0MvejZ3WU8vbjNV?=
 =?utf-8?B?Z2tqNG5LWGZ4cEk1d1JIY3VtZTczVjdYRi9SRXk2czhkUGxtQ1Vkd1RBMVpx?=
 =?utf-8?B?a1l3NGVKR1NmTmhNTWtpU1g0cC8rbVhOTDQ1Z05PZW9KS01qWGhxUDlOY1Zq?=
 =?utf-8?B?aTdjOHh4R3JDNWd0SElEUG9heStkZ01Fald2R1FjQm9zTjRGallCTUMzOGh0?=
 =?utf-8?B?S3AwdWdmUTBUdGtqaU1BZUovOFhiRDlpRUxGNlJ4WDcwSzFSMUk5TGs2ckZy?=
 =?utf-8?B?ZHpaQzhGQnJkTG9hUTZQTndaTFlmQW8yeXVWVndMcWVVc2dBMnhOVFJMZG9M?=
 =?utf-8?B?WU92am5UUVQwM1JJR2pVT1IwM05WRWFYZ0JuRjFtaGRjSGUxTmw2a25yN1du?=
 =?utf-8?B?OXV4Y3BVRTJQRXZRVkU0M0VFUldSN05sbGdPeXNQVFNzbktXVDBzNHRXWTFW?=
 =?utf-8?B?a0MwN0lEd0cxZlR1RHR3eUx6d0VJdHhkdUNjMnY0WGRPTG5LTm85YzRwc3Ba?=
 =?utf-8?B?ci9OZVNWanNQZkJ4MlVaSGJzdmhnZTZ0a0NPM3hsMFIvenZSVnBvOUlkd3N4?=
 =?utf-8?B?RXk3ZmZxMlZDNjVvVHRlblRmUDBQZzgxY0lBemVpT1F4c0dMWGtKQkxnblhs?=
 =?utf-8?B?YVdOYkkrK0Q3aWdZbTlqREhENjRETm9GZkJLeDZIVzJMZUtvZmVjVi9OcEpy?=
 =?utf-8?B?dFVMeFQ3d2hUWUF4d3dyVWpqV3RROWdwY3dBMlJ3MWFQVVBCc2ppWUtEbGV0?=
 =?utf-8?B?OSt1RVRXQlVGQ2RrT0FLVUpLRnBNa2pVWFBqb3pGNmhySjNBc3NqSmF6Q3pJ?=
 =?utf-8?B?c0kwdjNyTTh2N2JZZHh3bTI2ZWd1TTY4T0toYS9FQkg5WWlzWVRrTStwSEMw?=
 =?utf-8?B?em9UQ0pxMW5YVGxtdnN6K3dJRjF5cUxTeWJ5VGlqVXJBUnJGK3JQRUJWd1d5?=
 =?utf-8?B?T3RJeW5GMXcvZDhxWEM1cVc1akxPU21UdUpvWko1cURKMjF0RHExczQ4c2cy?=
 =?utf-8?B?blBNWEozaHFDcm9xL2RFTEdRTExrS01SY2J1SXRpU2I0K21wU3R1YW5xdzdj?=
 =?utf-8?B?b2RjSlJKQVBZNlhtL0NROFN2ZGc2b1RFKzRkQ1NDYVpyN1pWNFZGbEVVbmti?=
 =?utf-8?B?WnJ6ZEFRdlo2c2FkUXlQSzF5aFNpUmlXTWpIUjkzaUk4YzN3dURoWjVUMk9j?=
 =?utf-8?B?T1A1eW9WNmdqZmJhZVJGWTcrWmpaVVJ3S2pEMkJ5R3F1Q0J3cC84Y2tKRGM4?=
 =?utf-8?B?am9LT29LYTA2aW0rN2JpdW4reERJSlNtVFVHamxDaGNVM2tFS2RqSWlrRlRw?=
 =?utf-8?B?YUwrekl4dUJqWU1oc1hWK21uWVhhV0d0MXFMdmRjR3JTTldJeERpSGlUc3Jn?=
 =?utf-8?B?d25rcmNhVHhleWt2RmJ4M0VvNXp4OU5oNVVuUWZKVEQ5ZUd6TmowdnFIazlr?=
 =?utf-8?B?REMreGhoZW9aRDZYdkUva0I1TWJ3Z0NUeHYrQSthRnZIdkJnQ3pPUENJWmI1?=
 =?utf-8?B?Z2wzRWtOQ2dvZ2tHRHFIeFQ2ZE52SS9pcCtjOEFCKzU2ZllNTTdMYmdkR2JO?=
 =?utf-8?B?R2hUKzkwUCtTczBBUEFNSE9MeHlidGRpdUlCMVJ6NDczUVJLR2NxMUN3M2M2?=
 =?utf-8?B?ZG1VRVlHdjNER0NiS1d0aHBSQVc5WTV4TW1BWlNadmxLdEZuY04rS3FWL0I0?=
 =?utf-8?B?eXRaYUVNQkhwdjNhazJSS1BjMzJzdzN3VzlJRGNHQ1VpZCtpR2tWQkNPQnJJ?=
 =?utf-8?B?VE9wazhOK3VJaEppRmFETGtsZDM3aHIzODRpOUhIU2NGL1JJcjRTWWY3N2Na?=
 =?utf-8?B?SEliWDZZc1ZxN21BU3E1bGNobGxNRWZKQUxpdTBZczJCVzBjMWg5UEdTZHhK?=
 =?utf-8?B?VXBxbW1IUUloaG9MYlY3YzVxTVhob2Uxd3VvbTByaUUxUllUaWF3K2pvNURx?=
 =?utf-8?B?cmszWUpoeklYUTQ5TXI5Z1E1SFZ2a3Z3WHluVzhQUU5uMlYvL05QOS90WjBN?=
 =?utf-8?Q?DyboanIHpUT6hDDyLLZTxN9mM?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 078a664c-3faf-4a93-7236-08ddfc53ac2b
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 16:50:46.0849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ckFCBlAgMyKEVUVMSOh+RCbDMdjYJf9duage5tZyuD0Afy/nS90b+YkI4d3TNwFkKe1qt+0L+LsC0DbqfzwERA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10364

On Thu, Sep 25, 2025 at 04:37:54PM +0000, Guntupalli, Manikanta wrote:
> [Public]
>
> Hi,
>
> > -----Original Message-----
> > From: Arnd Bergmann <arnd@arndb.de>
> > Sent: Thursday, September 25, 2025 5:45 PM
> > To: Guntupalli, Manikanta <manikanta.guntupalli@amd.com>; git (AMD-Xilinx)
> > <git@amd.com>; Simek, Michal <michal.simek@amd.com>; Alexandre Belloni
> > <alexandre.belloni@bootlin.com>; Frank Li <Frank.Li@nxp.com>; Rob Herring
> > <robh@kernel.org>; krzk+dt@kernel.org; Conor Dooley <conor+dt@kernel.org>;
> > Przemysław Gaj <pgaj@cadence.com>; Wolfram Sang <wsa+renesas@sang-
> > engineering.com>; tommaso.merciai.xr@bp.renesas.com;
> > quic_msavaliy@quicinc.com; S-k, Shyam-sundar <Shyam-sundar.S-k@amd.com>;
> > Sakari Ailus <sakari.ailus@linux.intel.com>; 'billy_tsai@aspeedtech.com'
> > <billy_tsai@aspeedtech.com>; Kees Cook <kees@kernel.org>; Gustavo A. R. Silva
> > <gustavoars@kernel.org>; Jarkko Nikula <jarkko.nikula@linux.intel.com>; Jorge
> > Marques <jorge.marques@analog.com>; linux-i3c@lists.infradead.org;
> > devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; Linux-Arch <linux-
> > arch@vger.kernel.org>; linux-hardening@vger.kernel.org
> > Cc: Pandey, Radhey Shyam <radhey.shyam.pandey@amd.com>; Goud, Srinivas
> > <srinivas.goud@amd.com>; Datta, Shubhrajyoti <shubhrajyoti.datta@amd.com>;
> > manion05gk@gmail.com
> > Subject: Re: [PATCH V7 3/4] i3c: master: Add endianness support for i3c_readl_fifo()
> > and i3c_writel_fifo()
> >
> > On Thu, Sep 25, 2025, at 11:26, Guntupalli, Manikanta wrote:
> >
> > >> Can you explain how that works? What I see is that your
> > >> readsl_be()/writesl_be() functions do a byteswap on every four bytes,
> > >> so the bytestream that gets copied to/from the FIFO gets garbled, in
> > >> particular the final
> > >> (unaligned) bytes of the kernel buffer end up in the higher bytes of
> > >> the FIFO register rather than the first bytes as they do on a big-endian kernel.
> > >>
> > >> Are both the big-endian and little-endian kernels in your tests on
> > >> microblaze, using the upstream version of asm/io.h? Is there a
> > >> hardware byteswap between the CPU local bus and the i3c controller?
> > >> If there is one, is it set the same way for both kernels?
> > >>
> > > To clarify, my testing was performed on the latest upstream kernel on
> > > a
> > > ZCU102 (Zynq UltraScale+ MPSoC, Cortex-A53, little-endian) with
> > > big-endian FIFOs and no bus-level byteswap. For more details, please
> > > refer to my reply in Re: [PATCH] [v2] i3c: fix big-endian FIFO
> > > transfers.
> >
> > Ok, thanks fro the clarification. I got confused by your description mentioning big-
> > endian in [PATCH V7 3/4] and assumed this would be on a big-endian microblaze
> > CPU, after I saw that the original i3c_readl_fifo() had a bug in that configuration that
> > your patch addressed and this being a driver for a xilinx design. That fix just turned
> > out unrelated to what you were actually trying to do ;-)
> >
> > > Please don't take this as negative or aggressive-my intention is
> > > purely to learn and ensure it works correctly in all cases.
> >
> > No worries, I should not have jumped to conclusions myself based on what I saw in
> > your implementation and assumed that fixing the one bug would address your
> > problem as well.
> >
> > I do understand that your driver clearly needs a special case, we just need to come
> > to a conclusion what exactly the hardware does and how to best deal with it. This is
> > partly about whether you may be able to use an external DMA engine such as
> > xlnx,zynqmp-dma-1.0 or xlnx,zynqmp-dpdma, and whether that would need the
> > same byteswap.
> >
> > If you already plan to add that support, you likely need to allocate a bounce buffer
> > and byteswap the data in place to have it copied in and out of the FIFO, and when
> > you have that, you can use the regular i3c_readl_fifo() unchanged.
> > If you are sure that the i3c controller is not going to be used with DMA, or if the FIFO
> > register as seen by the DMA master does not require a byteswap, having a local
> > helper for the transfer is likely easier.
> >
> Thanks for understanding.
>
> The I3C controller is not going to be used with DMA in our case.
>
> We had initially implemented local helpers, but based on Frank Li's suggestion, we added the support in i3c_readl_fifo() and i3c_writel_fifo() to make it more generic and beneficial for others as well. That's why we included it here.

Yes, 32 bit FIFO generally two orders

BIT 31..24, 23..16, 15..8, 7..0
    B3      B2      B1     B0
    A0      A1      A2     A3

Need write/read to memory as

0x00     B0       A0
0x01     B1       A1
0x02     B2       A2
0x03     B3       A3

We don't expect every driver need duplicate to handle these two kind order
and trail data. Just need clear API defination to avoid confusiton at
difference cpu endian system.

Frank

>
> Thanks,
> Manikanta.

