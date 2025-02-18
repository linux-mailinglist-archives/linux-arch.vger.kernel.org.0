Return-Path: <linux-arch+bounces-10166-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA27A39814
	for <lists+linux-arch@lfdr.de>; Tue, 18 Feb 2025 11:05:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 997F83B7F4A
	for <lists+linux-arch@lfdr.de>; Tue, 18 Feb 2025 09:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8521022D7B1;
	Tue, 18 Feb 2025 09:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="c/qx+bLN";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="c/qx+bLN"
X-Original-To: linux-arch@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013024.outbound.protection.outlook.com [40.107.162.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604C323024C;
	Tue, 18 Feb 2025 09:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.24
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739872637; cv=fail; b=CZV4Wekh/XZkCuDDWlMfnKKbXELwBJnw/mA9hg+ZGYof/k6V3b5A2c/ilQ76dNU2dWQvOcbnVT1IX8ZZFgCkWFkQ6Iashj1R5E6j4off/Ph86H/SX3jRq0CMVNTAcuPBbOnpums80V65MAeqlsNBYvMEMrfpenm+Uv6CgueF+K8=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739872637; c=relaxed/simple;
	bh=PjkWey1ZhR0VMU3qHn1mfPgu7CvtQmDlFzYxDr1Zmsg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i0+tEwy/dfOdYCgSOWnUnq6ikqd/D743WOVSfA58JB2EXadwm8ed64fi6ZfJA0d/FxWepXvVl4Qu7ZahMzq3pK+PzijfqEcoXmsDcvg0DdoxI5x1vc4So04HRWob3GcYuYPuVnMrX+0u2dXWo84iQEEZDdUmu3kQSEJQztZjr4c=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=c/qx+bLN; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=c/qx+bLN; arc=fail smtp.client-ip=40.107.162.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=WPXi5WOLI0rH/Ti7AMccqvP5HKwrOKNDvXDlws0K5LlRB+4/9dV9BCHm0Fbya7dlAj3xjof1VPeAJcLd+Lfzk1A6dNx596vLyuibfXaZ0mJzitc7G5xWeuAzRqt5lpQh1rleuXillVjYBy4TjYrvgENQBGfeHm9/q9Qc/Qd4gOXbc9Wwa9EQQAxzpZeb5HUWPssVlk0tI+onuDTCxGNA+k8ylT81Y6pGjxslxN/i3tn5WtkghczVjRUyBwSUpSZDPrXmbFb11hFHfcmMM/h3j9frYDUpsUfTeH9fduv8a8+UiEIyysNAm6hQ/H9mHqjFug/4o+5akOLSa556AMNS2w==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g66rGXUQGYyuS2Eo+qkj4zV3LVGZaz+edNogDzi9nzo=;
 b=GGTVyoSbqq0dicR0R97KIDw/2IlJnEgT+df9SMI3ecnpAC8SkPTsDLa/0leD0lFdHEKnI3Q63kiPXMc7oR0UIaUfQ9loU4dmLhjRqau0CzBKtde1SVYO2jZ2X81bTGrzlacOZyp4NNrQVwmn9js9fem8SBgKnvA5G4eWPDiHoLPcLXDpV99zkcqcx7lT9fmz9YNXGvWKZoUfzsYSHFuYaNnbbtReokNYGCMYJ7+1IqytEn/OdH167XUQ+7duuVWEBVqp35s5AgkI3dvm2n2ughWz8EL4Wx2QonDsQyU/MxbppKB906q0nHeny83B0Nbe25wDcL5Bh1sgYWMVVTYGYw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=0
 ltdi=1)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g66rGXUQGYyuS2Eo+qkj4zV3LVGZaz+edNogDzi9nzo=;
 b=c/qx+bLNr4jrVxLOMBnVPTpugQ4xn9bvJq/xwJf63SzEAlCj0AfbRqLA5xf8Emdo5+1SecA8MUkX8qcdnohbeIW4CVTPKLhq+m23M5B91pk5XHB/nYg+mw4/NPwb2iMXVmY9ZzYCNKiaI9MmGxIcouHRA5YsVcNQLPB29kMGnYo=
Received: from AM5PR04CA0016.eurprd04.prod.outlook.com (2603:10a6:206:1::29)
 by DU4PR08MB11150.eurprd08.prod.outlook.com (2603:10a6:10:577::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 09:57:08 +0000
Received: from AM4PEPF00027A6A.eurprd04.prod.outlook.com
 (2603:10a6:206:1:cafe::be) by AM5PR04CA0016.outlook.office365.com
 (2603:10a6:206:1::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.19 via Frontend Transport; Tue,
 18 Feb 2025 09:57:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM4PEPF00027A6A.mail.protection.outlook.com (10.167.16.88) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.11
 via Frontend Transport; Tue, 18 Feb 2025 09:57:06 +0000
Received: ("Tessian outbound 4fd325905615:v567"); Tue, 18 Feb 2025 09:57:06 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 7c466d3c344f8571
X-TessianGatewayMetadata: ZVu9O+5+SCETLaQVGQnm9J/e8lYP1K1MHeX18ZDZphmXlFU4/rC1A/hcGyDlEvaVW2z0fm26Kh4uerMtlPzm6j0pbcMiJ5cqtpe616vrhPEktC+X2uACQNCCSqxSm4U7LQGchsGvQAQXPdlns5p0DA==
X-CR-MTA-TID: 64aa7808
Received: from L783cfa010d18.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 0F570B93-EAF7-4E84-86BD-D35F3CFBCEC4.1;
	Tue, 18 Feb 2025 09:56:59 +0000
Received: from AS8PR03CU001.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id L783cfa010d18.1
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Tue, 18 Feb 2025 09:56:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=azfghCHKiirEDsUYuV1OD/xdaPIc4QUlYnWw/LYwvOjMKQc3mqqf5QiK594+P0DRIZESaLK4NN+Ee4sjbGogNT3yyz4GbH+KLLpxiJuSXsKZuOUCRi78jAAr1Hp6J27nt6z0XT+j0cA/+4j1rgEv+ZhqOXsQEtG7+EWXAm2JNAoPGoBGGxJVUScU5WpiLdyvEpxEHa/NeV+BXG2nTWa13vsS2y3vTYlBYkXfITi70YvLsDhiJufw+YRdYNGnGX1YTgjAhVYU0A2LJjwDeY9w2Tug9p8OqNAjrfYwZkMTRrhfURRkD/5OaTBXh9bB06ZM1P8lo0nn3hSgcmtnsy54lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g66rGXUQGYyuS2Eo+qkj4zV3LVGZaz+edNogDzi9nzo=;
 b=bWZXju5genozlyQo6ySmUpEsoid/rEMopSYJEb6QUssagzHZ+5qHa7rLQIsVaGlyHyi6OCS89iCoHIpvk5Qnqw/zG2TnmrFO6XDc6dxnA7MczHkIYYIzQk5Kvs+wd0RIq45qXwY8dx1cNcDhcoSLGGwMM8QZI2/XP4p2yLi+sMKLwvXQZM9+f+ELaEXfgLSEQE/r0yj+cL7xeAw8jOlGDgjLkDgiUKONVo9qoawOvI/Se6TOzHlmnqI5ZkyyDAnR9pSAe1HSVGcpPtoR1GnCFsjF4g3lhf3xOuBOuw4jple542UaIwheIhHXGxT+HSjTvQNoKM71+irsURpgZWGZgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 172.205.89.229) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g66rGXUQGYyuS2Eo+qkj4zV3LVGZaz+edNogDzi9nzo=;
 b=c/qx+bLNr4jrVxLOMBnVPTpugQ4xn9bvJq/xwJf63SzEAlCj0AfbRqLA5xf8Emdo5+1SecA8MUkX8qcdnohbeIW4CVTPKLhq+m23M5B91pk5XHB/nYg+mw4/NPwb2iMXVmY9ZzYCNKiaI9MmGxIcouHRA5YsVcNQLPB29kMGnYo=
Received: from PA7P264CA0362.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:37c::28)
 by DB9PR08MB7422.eurprd08.prod.outlook.com (2603:10a6:10:371::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 09:56:49 +0000
Received: from AMS1EPF0000004B.eurprd04.prod.outlook.com
 (2603:10a6:102:37c:cafe::1a) by PA7P264CA0362.outlook.office365.com
 (2603:10a6:102:37c::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.19 via Frontend Transport; Tue,
 18 Feb 2025 09:56:49 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 172.205.89.229)
 smtp.mailfrom=arm.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arm.com;
Received-SPF: Fail (protection.outlook.com: domain of arm.com does not
 designate 172.205.89.229 as permitted sender)
 receiver=protection.outlook.com; client-ip=172.205.89.229;
 helo=nebula.arm.com;
Received: from nebula.arm.com (172.205.89.229) by
 AMS1EPF0000004B.mail.protection.outlook.com (10.167.16.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Tue, 18 Feb 2025 09:56:48 +0000
Received: from AZ-NEU-EX03.Arm.com (10.251.24.31) by AZ-NEU-EX06.Arm.com
 (10.240.25.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 18 Feb
 2025 09:56:48 +0000
Received: from AZ-NEU-EX05.Arm.com (10.240.25.133) by AZ-NEU-EX03.Arm.com
 (10.251.24.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 18 Feb
 2025 09:56:47 +0000
Received: from arm.com (10.1.32.37) by mail.arm.com (10.240.25.133) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Tue, 18 Feb 2025 09:56:46 +0000
Date: Tue, 18 Feb 2025 09:56:45 +0000
From: Yury Khrustalev <yury.khrustalev@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>
CC: <linux-arch@vger.kernel.org>, Will Deacon <will@kernel.org>, Arnd Bergmann
	<arnd@arndb.de>, Kevin Brodsky <kevin.brodsky@arm.com>, Joey Gouly
	<joey.gouly@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>, Sandipan Das
	<sandipan@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-arm-kernel@lists.infradead.org>,
	<x86@kernel.org>, <linux-mm@kvack.org>, <linux-kselftest@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, <nd@arm.com>
Subject: Re: [RESEND v4 0/3] mm/pkey: Add PKEY_UNRESTRICTED macro
Message-ID: <Z7RZXef1LqE0_lMf@arm.com>
References: <20250113170619.484698-1-yury.khrustalev@arm.com>
 <173982794521.4020985.15838989967891150260.b4-ty@arm.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <173982794521.4020985.15838989967891150260.b4-ty@arm.com>
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic:
	AMS1EPF0000004B:EE_|DB9PR08MB7422:EE_|AM4PEPF00027A6A:EE_|DU4PR08MB11150:EE_
X-MS-Office365-Filtering-Correlation-Id: 5da4427a-9225-495c-f405-08dd50029aec
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|7416014|1800799024|376014|82310400026|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?AIlgGOO3RTw7jxHPhdW3RqRyZCNSlgMrzpBV7Hshcz6wpHqOvGtR927zJ9Sf?=
 =?us-ascii?Q?D52zi1U/B5aJdQpxLdty2XZ3kSaVDoXncqTd/nw3baxDwfxsnQfpt5pnBBOB?=
 =?us-ascii?Q?uGFo3QsYUwO2EvkJ9FQ7jT24YwvzjkHNX7DZXvNwCPE4mLEa68P5KSu9m06+?=
 =?us-ascii?Q?MMOOjgxT9AxhCGyavBWYr7Tpk9ay0YXIE4akSmy/5XPm2EjGdVIe7MukY+s5?=
 =?us-ascii?Q?CSpUvW8wnKbnV/+oRlDof0yaHu7ZhkYYcTLcYObeJXSo1pGULK2h2d9gtKwx?=
 =?us-ascii?Q?3DyPJku96R2ivQ5v+R1NAYNg+pCGbi9ktlRagsLvtxVsgxCwaa173WQ8Htam?=
 =?us-ascii?Q?PykaLHOjy3tZua1eI0HjtyBjrmJkYjkTE/f5Ehe60GcC77FhQQnYyStsjLEG?=
 =?us-ascii?Q?3oKSuBYByPGqKB4+3QLRvvs5Jqv3Gkqc9+lh3+PawWyJBoQuLJf4YoReG2mH?=
 =?us-ascii?Q?hr823vRy99rLFkcPQQScd1RgXiStBbtsKfVFF+CYXRXlxRnRseG7lZNPcAJe?=
 =?us-ascii?Q?MlWNqIUnbXJTL/20H4jcTHtouoaeOsH1qCUhdnHwd3Akrgz8yn+pL4nClwHe?=
 =?us-ascii?Q?DCOakFGEu2DD25cDclWTpxK2GzatWP7ltiPfcIV294f6MfoMI87l8Auw13g0?=
 =?us-ascii?Q?hchdqTyaT4K4xiviRdria4447DaEHvMqm/idnM+JI5N/hahpCxQB15Wp7rO3?=
 =?us-ascii?Q?/2v8F0pSEfUd7h/kvFtohivrpfvm15dlCzar9WIwqaUcOESl9emUN4jw3P9Y?=
 =?us-ascii?Q?4kBV5SeGVZQHJtMMhLSYsW+KkXwzh+nO39pAPls8oLw53dTkBNsALvJ3LZ1p?=
 =?us-ascii?Q?qTq1wPuJkd2ecc27cHkIjqDVoulzkcYOYXJZ7FhYhmaU7ja0o5avI0z1x+kG?=
 =?us-ascii?Q?LU/PAlNnQxuhbiEAbQjXO6P2Ur1mnKx+4DZtaY5WwuggrEMC24a0qRkDBZfl?=
 =?us-ascii?Q?fbWjNJxoqX4+0lBFNl9LB5NHRmU6Q6I/R6BGRJeOCdUygiAfGZD8zogyLnsZ?=
 =?us-ascii?Q?dv3fn+gdiB3vxEoKDBgFIDSbWqp5GwrxsyuzyndTv4N1oPsH4qxylztcOvTu?=
 =?us-ascii?Q?0diE1W1CN6mhkc14c8jugM5BVbBMSlLW7VUOdWIPVcRS+y4dSs9im5Mbp95l?=
 =?us-ascii?Q?I1rO0525HxrEaSLSdmeAQ+GyIwSnuVz4CpaLSUg/BogWlqxG+zclei9hZxUI?=
 =?us-ascii?Q?5VX5yPiGLVup24ouKahnH5jWy6Q+Ef2pp0AoWU5nV3wac6f+VkO/9yEnFKUw?=
 =?us-ascii?Q?BszRQBOhf+XKupUR5uEwxr/sXbKULzK3lr0L4YiK2qLFhDhWUieT2HfwBw7k?=
 =?us-ascii?Q?f91XX78A4E51A4oOkwNjQ+fZUf/gjBayBK5iNO8wygAPoRQQ/CqNqUbxfs9q?=
 =?us-ascii?Q?vw5SBT5IHlc+Y6BeXSsiXbt6cTVRradGNBkIDBtvdsYdcfNXrCJIWASrzMVx?=
 =?us-ascii?Q?paWzU+CWloelRS+WU4l5XffStoNQYbQt?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:172.205.89.229;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:nebula.arm.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(82310400026)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7422
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:102:37c::28];domain=PA7P264CA0362.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM4PEPF00027A6A.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	a0b6e54f-f525-48fd-e885-08dd50028fd2
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024|35042699022|14060799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Pxaw6kjvmfH/LTMy1qEJwsdpwetVznKAF5Dxd9vWjSH/IqkILSVcWe7Uf3wZ?=
 =?us-ascii?Q?tiKOrpjMNQMYTzitv7hS6adkcIGYICcOHlWqdlOPXykiugrznChJmEvFfo8I?=
 =?us-ascii?Q?CsGWe9ZpAGrL7tNmAR/gdKba1ZJzHWGSKmBKaH2yHe4pgvfJ+4+ym9D928cI?=
 =?us-ascii?Q?pY6ITG+FUDfhTnLkA59ZNxpF6C9mbamVjFkfb29yxmfRc0M/1w//3JQg1vVP?=
 =?us-ascii?Q?vThY/eY0EueA3FB2nPUeKPLVTqgNfOLmFi5RR2hTQWnzC9HpmJjkVHDFwEQd?=
 =?us-ascii?Q?k+RRI0Zn7LSf+Ew+pA4pa5GvBZPQDsxTv5JciCTSedQHQXsiYkylS69f4+Ma?=
 =?us-ascii?Q?3J5Kzt9d4h/OjpiXzW4Jj0hPAOfDXXkFR0fqRJ1KcNQ073esaTHFRbnasrkd?=
 =?us-ascii?Q?WfSqyqyVWuxOshLxrAS2pndswlsrvkmA7Ww2/NZGQZymCxX/Gf+fgnlWkAQO?=
 =?us-ascii?Q?lq9lPkh2Fjq7Y1xk2ZgMUqeKe2HvQmISFa0LPyXrILFZQ3QVjdFd28cFdRop?=
 =?us-ascii?Q?Xxru6+DS59+QGk08PwYSb6WGb+PB1XwVLYE3cTOZmOGc6Q4jYh7ar38ZwRLv?=
 =?us-ascii?Q?pcjkmVzhxP4mxiJcHW71lH1j041Nxcn1onY2FqevFPv5pdTVosp778SneJOc?=
 =?us-ascii?Q?IOQVS0PrzO4+0VvGv7cn4ye0S7hl+UcpA6sYFeKXP9wZGj0Mx+hNx6hmt0UA?=
 =?us-ascii?Q?DxIxvxrkjJEWRjOJ0+onglPnpdoDNj/1pog0O8Q2PytjGUvlIdbh0oEbcztN?=
 =?us-ascii?Q?FDcPQerSjEwDg0jEFaa8BMW0cuh7xHFyoB6v5a1y3sXBJw0mF72Dh62WuePk?=
 =?us-ascii?Q?t3fxu3KIrmzyh42NEEBJvMRNZ4hpGccTvTwWtzEn1PAaFLLWV4BbG/wXsTHn?=
 =?us-ascii?Q?IDPrkQeEGsQxZxUTtfXWkeu9hYXxhFfQ9UCcAuVQOvEWcansO6W3s/osT6hY?=
 =?us-ascii?Q?dNCLMxLb86pVDp0gqu7ElweU7AdbFidA2XR9Zmqt8fip13UGc2TV7xaXqo3G?=
 =?us-ascii?Q?+ieNWn34DCPzYS1uz9YHgzyGzOhngsCeLg3oAG/D47FKgwpZOQkRnjJQKQKu?=
 =?us-ascii?Q?/1GBkQebb+ont0CyqiE0Bcv6845fUNBQweX+LhGY3kU4tuKohAqsaHaFKh/m?=
 =?us-ascii?Q?JoPADCH+vXCZ+K5AmW3RfJdwZkSi4cqvOYRDDmP1BJsd76y9Y4Tkkte1eZew?=
 =?us-ascii?Q?jkWd0zusn+X8aRkN+u6NB5SzDnMjpsPW4vzK8b1b6Chfh5IwDlBByYMjJDHV?=
 =?us-ascii?Q?6yDK2ZVWDktB0WQwDYq/KLQnkUHPRn/3EWVuKnZl2crF4/7vr/PDe5AjBtbA?=
 =?us-ascii?Q?cdAS6nK2zkv+ZX5QUAuSj96zWALE+kjiIv7u/VxkgMBfM5alYIEj2v74lLW5?=
 =?us-ascii?Q?yXs+sbkaB014dT8CxoUo0ZpfwCiIBWNewnJUxEw9JngORyHy4JScYGVOVJcq?=
 =?us-ascii?Q?GT1ElsK+2Tj/k3YbZAOf9eFW0N7Ol0h0?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:64aa7808-outbound-1.mta.getcheckrecipient.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024)(35042699022)(14060799003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 09:57:06.9761
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5da4427a-9225-495c-f405-08dd50029aec
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A6A.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR08MB11150

On Mon, Feb 17, 2025 at 09:33:10PM +0000, Catalin Marinas wrote:
> On Mon, 13 Jan 2025 17:06:16 +0000, Yury Khrustalev wrote:
> > Add PKEY_UNRESTRICTED macro to mman.h and use it in selftests.
> > 
> > For context, this change will also allow for more consistent update of the
> > Glibc manual which in turn will help with introducing memory protection
> > keys on AArch64 targets.
> > 
> > Applies to 5bc55a333a2f (tag: v6.13-rc7).
> > 
> > [...]
> 
> Applied to arm64 (for-next/pkey_unrestricted), thanks!

Thank you!

Kind regards,
Yury

> 
> [1/3] mm/pkey: Add PKEY_UNRESTRICTED macro
>       https://git.kernel.org/arm64/c/6d61527d931b
> [2/3] selftests/mm: Use PKEY_UNRESTRICTED macro
>       https://git.kernel.org/arm64/c/3809cefe93f6
> [3/3] selftests/powerpc: Use PKEY_UNRESTRICTED macro
>       https://git.kernel.org/arm64/c/00894c3fc917
> 
> -- 
> Catalin
> 

