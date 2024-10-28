Return-Path: <linux-arch+bounces-8635-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD3D69B2A6D
	for <lists+linux-arch@lfdr.de>; Mon, 28 Oct 2024 09:33:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CF951C21878
	for <lists+linux-arch@lfdr.de>; Mon, 28 Oct 2024 08:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E62115EFA1;
	Mon, 28 Oct 2024 08:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="gXdT1QSA";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="gXdT1QSA"
X-Original-To: linux-arch@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2076.outbound.protection.outlook.com [40.107.247.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D076242A82
	for <linux-arch@vger.kernel.org>; Mon, 28 Oct 2024 08:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.76
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730104414; cv=fail; b=Z/iIHFmR0SaoEs7FAXp9ETYW7wJTz6ebSf8bSGyHNg5V+yO7fS7lmpawMb3DgLTS+E4WRyK82lXrGwp4IQpF5geJmVm7/rnNVqGezM4dcAYKQtJ9Wjup6/RYCVkvo6XaiNbfmPizRPebjCE1BDGZV7Sl+xQXM7H8ewTaV5qWNuc=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730104414; c=relaxed/simple;
	bh=ED0vsf6y7SVI9tAl+zsuTNv16YQQqcVX9eKLFQxnaVQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LWTBR9b1gACXI6Onj1FT2Mb36VpU5J5dZJJ1dyjjgrJjEtujsyNKcqSGiedxPuUN/W3DqSGG+yn0dzJEn6QeZVSKmcYf1Oc65hUirvTIWvX1U83brUCn1EGGZ2QMYUE2bIqtiQmyCS89GdgerQa04Q1Xzyuxu50t0bHYllyn6Yw=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=gXdT1QSA; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=gXdT1QSA; arc=fail smtp.client-ip=40.107.247.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=d+by7FU1YhKMuYGFBdiSS2wVNxxzWO8lUGUy20/J/RI/n7f5tdQUp1Io8XUt7sL0JVJ816a22a1dEHArdMzX2qJr28gyQbXmW1/va5J6LlaTWe6E5d8ND5/hTafHJfMsBPoTmf9SqAPDLfGuYalQQY+ELiXVNlXPT4QJuA+3q/q65DwSqMlcuAx2DBzmQbbkKujmt3gj50S/Zm35ydt2l6gRRwYxoqbOd+QEZ0TKMpsx8zXA/qM8Cw6TgzVPWr5aqXti+jeKRDERdmdde1/ylTxI/YD5jor4RNH/F+Lsm5BEUQvDr88mO4Jsf0boMEXYx7H4sja7KSd46xPJeycwYQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3qzycSOF2o00sdSBBay+nuTSGKvpZwQrX7CGMl5xMq8=;
 b=CH2+sONpnWBUoh1mr8LGlqWz1gNxeXVRG0SBrdLJfcVLRaVMxhwA8NpKPS3S6HcSfXhaImEJ4XoBt57+//YCE6rH7s4n+fQn/z7OcMHdMXu26rhHPPNHSI2gyjVaw6O6OpQNH/nXiwXwkpva2b9gysnStKI5OFh31jnZGZfynd3ffGWtgWC09h8EslSGvhYlu4f5+r6pzWeQ9hayG7bOrfd5pOsUDEVXWZ39qFdUcAdFhcvdhTsJ7f1xPl83FLQbvXudAuJTGXv03GAVUms7JqxZLemoR8V/WpLOWjLR6CRh49rroFabDBjumRffkMBEEFTTifEjgnuy1xUvg/ULEQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3qzycSOF2o00sdSBBay+nuTSGKvpZwQrX7CGMl5xMq8=;
 b=gXdT1QSAPBnN7EVaHuhlDl9Q4HWk52zzwHqB7Uz7wxh+y0SHIPfVQVpFPkKW8DTHTdCJLHiza5mEgUUloqk0cdxasajsVpXcok2agFHkS+5f76Nazw1caNPQoqNetmmy6O9fh/fRLAkKZPDtLJ/pRIUyiwhX/DhBpa+Y1q0WlJM=
Received: from AM6PR04CA0049.eurprd04.prod.outlook.com (2603:10a6:20b:f0::26)
 by DB9PR08MB9442.eurprd08.prod.outlook.com (2603:10a6:10:458::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Mon, 28 Oct
 2024 08:33:25 +0000
Received: from AMS0EPF000001A7.eurprd05.prod.outlook.com
 (2603:10a6:20b:f0:cafe::ff) by AM6PR04CA0049.outlook.office365.com
 (2603:10a6:20b:f0::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.26 via Frontend
 Transport; Mon, 28 Oct 2024 08:33:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AMS0EPF000001A7.mail.protection.outlook.com (10.167.16.234) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8114.16
 via Frontend Transport; Mon, 28 Oct 2024 08:33:24 +0000
Received: ("Tessian outbound 99870d44e01c:v490"); Mon, 28 Oct 2024 08:33:23 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 00c841322ad79783
X-TessianGatewayMetadata: gyd/G7WbuIOn3HS5K477DdaI3ElGvz4HhdnKmy3ToKhyHgQ31AjJ4/Ii9WVsJcpa7c8UzRjSCUbFfTPuPCtq1jvoFJt+7h4QCe0PpG8aHjt3qB7Wi3ZV88kzy0DA4JrEJDxQQ+gj9YwGxCcbtxc6/g==
X-CR-MTA-TID: 64aa7808
Received: from L48fd52f7e765.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 1CE1ADD6-E4D1-46BD-A883-F57C205CD8BA.1;
	Mon, 28 Oct 2024 08:33:17 +0000
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id L48fd52f7e765.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 28 Oct 2024 08:33:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZT5NSZv2Kt84LRsNt8gLABw02TGMOnimmUfcgI02kSnCGuQB6BQ+J9lUqMiEttk/0yjRsR3fg6Vjovl3vRnQPNnnkliwMdXIZRmJ1vm3io0ILy75lDagf4bicOPeYNpvxOH8gVYc54Q7qAfoOFRv3hknkXqAfkesRqQS0786QP5hrUquOXCZNksFdquOGlXyzLXs4L6msUhHpJH32Wp8Bwz8HflLZygR45bXBwHEGrLTscY/FO05pOLXq6gdGgMb2c5wiE7YmkYBJBugf2p7SZuManc6AOt5qH0u9cKR063QEI9g4vYqjF+/6uPSGLUm2KF5lMb13zjkSRB+NQHAXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3qzycSOF2o00sdSBBay+nuTSGKvpZwQrX7CGMl5xMq8=;
 b=OTn1ARjynfv12is4wbZDo46pRLnZaMSir6XP/sux1HVsWfqu7IcfqNRW5nq0SXuPy+MHO2Wlilw5DqunNiRfRE4rigNtLyI8W2/g0NTZuQpjTcDsUOiT7wPc9Q7gMtioHljZX3Z6VaAsFZ6Z6IASvDzsbX9NjrTDCmJJBgoRZ70qcNtBVtWrnpbSb6tLtrTHop1/Cd5E/zZlvs+t/L23Zn0PDkN9WdfO6CyJgxIh3h91pW1kDyVuUewzCxuH3M1RLm4UjtoeeDDj0ISQJpnKkj+9dXz2ACYqxeXXUU0PWwsUF2LzKxNcrVfYd5G3ORJgva4cfcGXlWlKAqOS3UJKrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 40.67.248.234) smtp.rcpttodomain=intel.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3qzycSOF2o00sdSBBay+nuTSGKvpZwQrX7CGMl5xMq8=;
 b=gXdT1QSAPBnN7EVaHuhlDl9Q4HWk52zzwHqB7Uz7wxh+y0SHIPfVQVpFPkKW8DTHTdCJLHiza5mEgUUloqk0cdxasajsVpXcok2agFHkS+5f76Nazw1caNPQoqNetmmy6O9fh/fRLAkKZPDtLJ/pRIUyiwhX/DhBpa+Y1q0WlJM=
Received: from AM0PR03CA0044.eurprd03.prod.outlook.com (2603:10a6:208::21) by
 DB9PR08MB8505.eurprd08.prod.outlook.com (2603:10a6:10:3d6::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.24; Mon, 28 Oct 2024 08:33:13 +0000
Received: from AM4PEPF00025F9C.EURPRD83.prod.outlook.com
 (2603:10a6:208:0:cafe::ca) by AM0PR03CA0044.outlook.office365.com
 (2603:10a6:208::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25 via Frontend
 Transport; Mon, 28 Oct 2024 08:33:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.67.248.234)
 smtp.mailfrom=arm.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 40.67.248.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.67.248.234; helo=nebula.arm.com; pr=C
Received: from nebula.arm.com (40.67.248.234) by
 AM4PEPF00025F9C.mail.protection.outlook.com (10.167.16.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.0 via Frontend Transport; Mon, 28 Oct 2024 08:33:13 +0000
Received: from AZ-NEU-EX03.Arm.com (10.251.24.31) by AZ-NEU-EX04.Arm.com
 (10.251.24.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Oct
 2024 08:33:12 +0000
Received: from arm.com (10.57.58.19) by mail.arm.com (10.251.24.31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Mon, 28 Oct 2024 08:33:12 +0000
Date: Mon, 28 Oct 2024 08:33:10 +0000
From: Yury Khrustalev <yury.khrustalev@arm.com>
To: Dave Hansen <dave.hansen@intel.com>
CC: Kevin Brodsky <kevin.brodsky@arm.com>, <linux-arch@vger.kernel.org>, "Arnd
 Bergmann" <arnd@arndb.de>, Joey Gouly <joey.gouly@arm.com>, Dave Hansen
	<dave.hansen@linux.intel.com>, <nd@arm.com>
Subject: Re: [PATCH] mm/pkey: Add PKEY_UNRESTRICTED macro
Message-ID: <Zx9MIsVTKoddY7I6@arm.com>
References: <20241022120128.359652-1-yury.khrustalev@arm.com>
 <d8c2ff4a-a7b3-409f-aa3c-5ee97ba4c540@intel.com>
 <04426b9c-2686-470b-977e-d6890312d49b@arm.com>
 <585b56ef-6e89-4d1e-be6f-715c0f38b56d@intel.com>
 <4da06814-1846-47f1-87f9-f8d38fe2ef33@arm.com>
 <dbe74360-dc58-4613-9b95-7a950f69bc9b@intel.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <dbe74360-dc58-4613-9b95-7a950f69bc9b@intel.com>
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic:
	AM4PEPF00025F9C:EE_|DB9PR08MB8505:EE_|AMS0EPF000001A7:EE_|DB9PR08MB9442:EE_
X-MS-Office365-Filtering-Correlation-Id: 57b4a5d5-bc58-47e9-2eaf-08dcf72b306c
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?wp2aNn+jSjj2LG0eyhNMIzC8O0GWGhJmq4OvBEKsKLx06D9K8IgcYTWdESN7?=
 =?us-ascii?Q?mNGKaz/0U3mxzcjFMNS/2N9p5Bxw7fahLVi7x5BI1YAfa1oGz2AAX053yX7C?=
 =?us-ascii?Q?UyPkq+pxf3UOGJFEjT1nbWH0UK0byqutANA9mMqy67LmB62JMW5V2KhUYTvR?=
 =?us-ascii?Q?bJAu7Grhn11W2DiWigP8gwdCkJ2lLkULOfbypt2NADYrNNXjEnPYN+GaBaYV?=
 =?us-ascii?Q?bMH66RKuCKKF8yizO2BSh3B0mETdMseQ2xUHkbSV/dlv5qTqzaxyGS/KeICh?=
 =?us-ascii?Q?WLg+mu1QSXxgzj0rWKiboph/63HzusEeJnP9eUNUdkF8CzNvI9VcUsaZ7Egu?=
 =?us-ascii?Q?+Uq8h2u3lZQqO+QcQx2aWYRlO8ieYImCHXOIMdNLHuAbMBSuYMaE6yHl3d+Q?=
 =?us-ascii?Q?8phBgPv29Epv5CpzdN+kSB1zqTCJNFNNGXLknXL1fozRcdrb2wG86iSLqcfa?=
 =?us-ascii?Q?KxzP9VD4Ir0uJQx5DnQwtoeeP6cFztUjgXTNO+xz2Qcg+Yp6Q4vLcwrw7p0S?=
 =?us-ascii?Q?zYKNAhuH/jJ93ItY2JSeFsHzdYX4vF54VFYA5mQj/fjfJzM8wBdYg5y4VBoj?=
 =?us-ascii?Q?ZqcpySQmCWUyeWNWJ7AyTxDhaxIGY1TLnV2ejEbEN5vZWKpH1DjDOZyX3KDh?=
 =?us-ascii?Q?yklNF5/yDeHMek6VQdXCZ6IHYXK+GFEUYlndLHg8PQ7M9aDFXT+qz20tiAF8?=
 =?us-ascii?Q?1JhRBoVbL7c460o2H/blmjDWYmXp0ytM4EsOPW9NLhGFjqJetMIR3hu05xaT?=
 =?us-ascii?Q?5s/Dn2HyUs1M970ljjmqSkd2+XjGrY2XvT9FQCXK0zHIB0TEwPHmRDNDFTl+?=
 =?us-ascii?Q?0hpRu6m0Txuao8G2Q4/VpOi3FpoJnnOLyW6c8atecpPLX5D7ajVLKTii9F6a?=
 =?us-ascii?Q?szMz3nQcqzzL74m1PlWK/C/IHvOujhcM5xfA6Ac9/JmyEUiYrhQo+J5hiLTF?=
 =?us-ascii?Q?M7H2V4Ofzf89vt+0vt89u9dJXarSDZX0fCfkj5G08sf6ZMT7VtRxTJYwIh3X?=
 =?us-ascii?Q?7bC+2P/gkxlNy4XfQNMF+frtrigreUPWupe573Mzb6UYAGcUJpP7WE+MHhOd?=
 =?us-ascii?Q?ujkMGqY1gjGNhqgA9qN2PailE6ZZt0eXEpS0z0fJCxh15PxZsTsCLLckkJGH?=
 =?us-ascii?Q?tcnSu0KT217yjxFFJd34uELDVhy8Td7LU8eiJneJjMvfoH8u+XwZgQDNIrF2?=
 =?us-ascii?Q?F8HI6+7t6cFyv2Wr9E9lwlqBY6pFziEqwe/ES2XKSeWbDrgN9Pwn1kNcIeck?=
 =?us-ascii?Q?cFyXNKA9uao6jThpIrPPhl+rZMgTAwx35AX+JB1IntUFdAQlb9ERS6WYeq85?=
 =?us-ascii?Q?1PNz4c3Y3do2lWCHOq9lOi4UZNGtv76rLQWRAdFVi7LFgf9t0uRvmEuCA8Id?=
 =?us-ascii?Q?1hyY2Il+OiCbSHM1ywjlLTJTR0mlpPDiGOQmnUn8moEWDQ/7ug=3D=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:40.67.248.234;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:nebula.arm.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB8505
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:208::21];domain=AM0PR03CA0044.eurprd03.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001A7.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	ee5c6d51-719c-4c68-d316-08dcf72b29e7
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|35042699022|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?J+G8ygQUkc8jw+H6QRYR4u6C/uEl7Uk0MlGtA9EDPDwqJFkYwTJJhqP7HXDE?=
 =?us-ascii?Q?WCgZomhjCdZad/LebTTcLpeB9u+WJxXu8DWWWMJEEZaZ2FZvDYkxNLT9UQdq?=
 =?us-ascii?Q?AkNLmiP4XE0SmpvW2nQC+gElFcZ1vI8WbY11v9c2IH9FF5Izck8fcjcdAHME?=
 =?us-ascii?Q?QNs7XczCK06QwQ7AVCNsOa7aXt64yB/iJauso0taLFewTzoTxIvVhwJVcVqt?=
 =?us-ascii?Q?hVwGYyqItNNYn2EcV9bcFyPt1Amr4bNs61ihhqMPlhDX3NbYft1Qrm6PjOyP?=
 =?us-ascii?Q?QB80utHAO34LlsTai7L3BDusc+UYkikCWzv+fPbDKO7EkeEeK3qPQZ1AYGQm?=
 =?us-ascii?Q?cANhtwFBpih+j+M+I5W/UcQr6cHbOOOFAPPS4mu2wYaoG6uVPI12kf5aTh5G?=
 =?us-ascii?Q?6IktnXmLVkDEnfhroD33RJY9lA22lxzL/rFAhEX3gjcTtzsq8ShqwysP/5f0?=
 =?us-ascii?Q?D3Q8Qh2t+8VYxXE6dMSrr/Dc5OdxXUMaQDoJT/nRx869shO31/X2KhOOPhvh?=
 =?us-ascii?Q?wdqqIbl4U8Sc0kn/J0K552rA8o0VpF/GYRVpUUo6KIy8g8NHj/5po0/XfX1V?=
 =?us-ascii?Q?0F8wGgOgnvmChpmmuLUSnCyvwN13dLxU+T3MZHWRAMuaHRWEBxEGnFvaUPic?=
 =?us-ascii?Q?+nbi5r715UPdrXyLtxvZ19iStJKrRdqUdPiB2tTMjmB3HgsZu41zwP9n7gAD?=
 =?us-ascii?Q?IyAar1MDpddgja3ncF+BI/+GFfhxN7piitSa/FEQS0EO9MUJHDV9qU54Q60G?=
 =?us-ascii?Q?w4XHj6aKraoE2V+89lje165XEEXq8fUkgpRPsTLtXOfNqEU3VU3kRR6SLzbc?=
 =?us-ascii?Q?YPMbZSFJ0GcjzJD4i3hRRHpM09W7oWwyw1csD3H/KwaA94+6cSfOKTMmrt1b?=
 =?us-ascii?Q?w+awW+Vsdti22wQXjl/jxfIJwuDM1drCPw+FVl8QbhwmkVTMgi4qGvi7mWZX?=
 =?us-ascii?Q?4dmFHj06XuwR6Q46Hq1K43RY4Pg1yAcq+g0iwYm3YW+9bzhaXcVjYjKDCRzb?=
 =?us-ascii?Q?Ze1vgiIx0R1dxvzh44L48UrxFXY2iJcB4hdziZsiYZpGF4Q1sCff3sPGGeQe?=
 =?us-ascii?Q?A2hqJX2jD9yBcrvBesmsxfE2IdS0T0MLvRwYse10hW63TjAzLE/xIO/4sk3b?=
 =?us-ascii?Q?ZF3soEOG9kaYQInZa9UQn0FX6Mc4wzUr+sPFqxl7mxAGvZHyfLA3I0XcscEQ?=
 =?us-ascii?Q?DN6xtFM31F1yxs+n+f9Metk3b9Y6r1rLgVNP5sBgi51W+P/Ww3+wzavGFBVx?=
 =?us-ascii?Q?QpQLLjn9vxXTMINjb/yeoB3sLCV9hKOP16TuwhKjtjdZs6jfpKmU8XCW4EWw?=
 =?us-ascii?Q?UBv3FeZ2m4pFE+lzzvRQLp30ZRsp3nut8mErZqvVyMdp4H8dVDqKY7ABWP9c?=
 =?us-ascii?Q?4gJKGdhynnYh9l4W+zAOv/w9TaqDybc/25dEe87CXKpUnIZxqQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(35042699022)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 08:33:24.7349
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57b4a5d5-bc58-47e9-2eaf-08dcf72b306c
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001A7.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB9442

Hi,

On Fri, Oct 25, 2024 at 07:48:01AM -0700, Dave Hansen wrote:
> On 10/25/24 01:26, Kevin Brodsky wrote:
> >> It would be much appreciated if someone could make a pass over kernel
> >> code and fix up the places where PKEY_UNRESTRICTED makes things more clear.
> > It doesn't look like kernel code would have a use for it at the moment,
> > but I have found a few places in kselftests (mm, ppc) where 0 could be
> > replaced with PKEY_UNRESTRICTED. I can send a follow-up series.
> 
> Just doing it in the selftests would be great.


Thank you for the feedback, I've sent v2 with updated tests [1].

[1] https://lore.kernel.org/linux-arch/20241027170006.464252-1-yury.khrustalev@arm.com/

Kind regards,
Yury


