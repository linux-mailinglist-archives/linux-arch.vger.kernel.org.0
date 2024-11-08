Return-Path: <linux-arch+bounces-8927-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7552D9C189A
	for <lists+linux-arch@lfdr.de>; Fri,  8 Nov 2024 09:59:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C986FB243E2
	for <lists+linux-arch@lfdr.de>; Fri,  8 Nov 2024 08:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3054F1E0092;
	Fri,  8 Nov 2024 08:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="PgOiS7vK";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="PgOiS7vK"
X-Original-To: linux-arch@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2060.outbound.protection.outlook.com [40.107.20.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C451E048A
	for <linux-arch@vger.kernel.org>; Fri,  8 Nov 2024 08:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.60
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731056381; cv=fail; b=jUAMsuWcb79v4cLDbjr84MDo5vpSxJtoe9mZ1OJhVyec1gepFx+L11HcqfKjFZeBpqEbk6v04n9GWCjR95mBPgzmRo1DR4CUP02WgarjTkjQ2N4Xgp5cha1TPbiW0dQKxYnB2KwA933NdsnOcNQ/yjqWRLUnm3ahaGCSF+cE2OM=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731056381; c=relaxed/simple;
	bh=Y9nnQ/I9bxExguN78WaBAJLUDWkXt7aYZKWz0ZbzC9E=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B/bNAQLKp0OHs0zqoiV6QNhRWDZlpbvHzte8KKo7rZ6hG2i82rTbhqkptYL9MOPTzFrkfmho5uGqoEGNALMZ5u37rsisMpo9WK8nQheUyTcGI7KJVJTh84fdUevCxYN1pz1sI7iSJ0xSBGj+DFtZ4m7IQs3gxWPR09DRpfYS+9g=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=PgOiS7vK; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=PgOiS7vK; arc=fail smtp.client-ip=40.107.20.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=IHvndwx/vbeIx6PtnvRu1cH7GAyxezQSHvWlC/fGPSwygU6NLes/Ycv7ybQkJkihS3JYFUKzGLpgeYlwbmouuzMTqqiNLdFVCsYkX63aMnJLNF+oJAaFEbnzxCWaezV4R0xh0DoD4b5MpEX68r4teX9pdDU2xUsKtroE+HHZWr5yu/UOz6urWSppMpTZJ9vnibQAW9dI5UCDoOn6z22Q/yt2/RxAs+6WjTBeImOQ/dbYGOOa3JKAoWwgaQ2QnXYh1Cyt1INY/U77wdxQTxuCYQIu5SJCyQ3z/slVCNWy94goM9okJNFb34YKhvX93H30kLnoKg1VFoND6cCQ8xHTFA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6hq7rVZO8bSx8LDmG9+MMJ1cDMrKHlYeH1u0x93MUPc=;
 b=jQ/m2U1IngtDVbuxerHKGmCcOGGc9s5IFSNcSOjb//dRUwbaH1czb9uHFYsObRz6Y1xfgq6skNZZZ7eyIevu2+lS/yvWDN47FhfnPiFxIZi3DpCGW/ykOq8loGjMM15b4Vo4zmIKeCCJ5kZFG3j1+7pQ2aiVpV66jC7TnLpsyNbJuxc15DUOzz7fbE1SyjUH+5z5NeynYfY+3C7mwlCmPjOV4u26Z1JUEt8GIE5WT8MdV3hz0CUsCGls/k0wP8PbWtrcNW/7+adCmUZXTVCH9N6fIK/JefUmi46KlKuUrXNrt5JOvwWKF0XjeKRKyajjJIBVKN2xsPDVOdDwqvBWZA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6hq7rVZO8bSx8LDmG9+MMJ1cDMrKHlYeH1u0x93MUPc=;
 b=PgOiS7vKDJj+ijCgWrWphzOvreypPKaiuDXev/P3ZC0ptQjYStvUsOKuCG63wacB2DbEWlFbNUTQhQ3wVo0aG7oEQvd29Q6lb5xo5N1Tcw4dNrPDWr2qI8JNvzqQ4maU+QXLqzX2u7MStqUAjHhWFpFy32mmQWpMJ6C6qseCvIY=
Received: from AM9P195CA0019.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:21f::24)
 by AM7PR08MB5317.eurprd08.prod.outlook.com (2603:10a6:20b:101::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Fri, 8 Nov
 2024 08:59:33 +0000
Received: from AMS0EPF000001B0.eurprd05.prod.outlook.com
 (2603:10a6:20b:21f:cafe::d9) by AM9P195CA0019.outlook.office365.com
 (2603:10a6:20b:21f::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20 via Frontend
 Transport; Fri, 8 Nov 2024 08:59:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AMS0EPF000001B0.mail.protection.outlook.com (10.167.16.164) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8137.17
 via Frontend Transport; Fri, 8 Nov 2024 08:59:33 +0000
Received: ("Tessian outbound c4cd8408e1a6:v490"); Fri, 08 Nov 2024 08:59:33 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 94ccb1e9a7f555e9
X-TessianGatewayMetadata: A6NFjioXAZq4Z27n2f10k6gmy3q90P7MM0LDl4veVCwdpdofjwXCkD0e0tQDLDrTI9zq7W1coVYJs7cnDk64CTskz+o+Wuw112mdTYMlM3SZ1f/Zvut4T78Ysyw4xY0ENdt7Zg8WcZclAykus7K6FQ==
X-CR-MTA-TID: 64aa7808
Received: from L0fd2f3d014cb.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 99F5888B-2A6F-4C47-AA64-222BCDB99259.1;
	Fri, 08 Nov 2024 08:59:26 +0000
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id L0fd2f3d014cb.1
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Fri, 08 Nov 2024 08:59:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u7w06qjB46SvmkZDAqzFopL9uYYd5yIUP0+LEuZygbEmo0iLoKLARh/eDHVz6RnUn/KmvWz9i2T0xNrZbag6CS2bTIfHo3XgDj/Lhu4efRknaX2JnH0zza0NOvz/unAMBEQrzGUb37SU6t1on27Gl/44tIJh9T9p8wp46KWJHk/HX3g7rZqPz5JZbQGvCkr5txDsNj9HrwGHbwujUzdog77nK8U/ybml4e4S4mOkR4WLyVCQZPwPlCHOwJls8JaDxi2IKJ/IBJrO1IJIPx/R2hD2nWk8Ia3YOZC+rtE9qjv8bhqoA+5S/41k+aHnjOfwxpcBOn+VIKS55i5T484rBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6hq7rVZO8bSx8LDmG9+MMJ1cDMrKHlYeH1u0x93MUPc=;
 b=NsfHbuWaA+tENbBdyo4OE2nVFljOo4GNyFtVYNCmAOy1sD88STGI9m8B6GZOj/8eMQjl/0y5TE5EZTMwZsl4TLzC8nFkrgXPmHurLHasKtZCHuNdDRsU72fDypxXObhGCYePdWfdKctR5g+qA9eO7NZfmC+iHNpB2zMrrv5Ol1QaEDzNWyWDm3id2AmrUofTDxZIIUcPIrseGGEsvrYr5l97TZQYXygc3sCM4CUUp+HeNAo8ksT5vGqXN2BYZI4eosfhZBtqNXDEybtDmEewXX01rZNBlbWIT0N6kQw1ZUmx7mkuKQNAkP8cQQiN/Q1PMA5D9uEqvpzcTj52UDrrZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 40.67.248.234) smtp.rcpttodomain=ellerman.id.au smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6hq7rVZO8bSx8LDmG9+MMJ1cDMrKHlYeH1u0x93MUPc=;
 b=PgOiS7vKDJj+ijCgWrWphzOvreypPKaiuDXev/P3ZC0ptQjYStvUsOKuCG63wacB2DbEWlFbNUTQhQ3wVo0aG7oEQvd29Q6lb5xo5N1Tcw4dNrPDWr2qI8JNvzqQ4maU+QXLqzX2u7MStqUAjHhWFpFy32mmQWpMJ6C6qseCvIY=
Received: from AS9PR05CA0111.eurprd05.prod.outlook.com (2603:10a6:20b:498::32)
 by PAXPR08MB6621.eurprd08.prod.outlook.com (2603:10a6:102:dc::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.21; Fri, 8 Nov
 2024 08:59:22 +0000
Received: from AMS1EPF00000041.eurprd04.prod.outlook.com
 (2603:10a6:20b:498:cafe::51) by AS9PR05CA0111.outlook.office365.com
 (2603:10a6:20b:498::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.21 via Frontend
 Transport; Fri, 8 Nov 2024 08:59:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.67.248.234)
 smtp.mailfrom=arm.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 40.67.248.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.67.248.234; helo=nebula.arm.com; pr=C
Received: from nebula.arm.com (40.67.248.234) by
 AMS1EPF00000041.mail.protection.outlook.com (10.167.16.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Fri, 8 Nov 2024 08:59:21 +0000
Received: from AZ-NEU-EXJ01.Arm.com (10.240.25.132) by AZ-NEU-EX03.Arm.com
 (10.251.24.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 8 Nov
 2024 08:59:20 +0000
Received: from AZ-NEU-EX03.Arm.com (10.251.24.31) by AZ-NEU-EXJ01.Arm.com
 (10.240.25.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 8 Nov
 2024 08:59:19 +0000
Received: from arm.com (10.57.26.225) by mail.arm.com (10.251.24.31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Fri, 8 Nov 2024 08:59:18 +0000
Date: Fri, 8 Nov 2024 08:59:17 +0000
From: Yury Khrustalev <yury.khrustalev@arm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
CC: <linux-arch@vger.kernel.org>, <acme@kernel.org>, Arnd Bergmann
	<arnd@arndb.de>, Kevin Brodsky <kevin.brodsky@arm.com>, Joey Gouly
	<joey.gouly@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>, Sandipan Das
	<sandipan@linux.ibm.com>, <linuxppc-dev@lists.ozlabs.org>, <nd@arm.com>
Subject: Re: [PATCH v3 1/3] mm/pkey: Add PKEY_UNRESTRICTED macro
Message-ID: <Zy3S5YhlgduqCMRD@arm.com>
References: <20241028090715.509527-1-yury.khrustalev@arm.com>
 <20241028090715.509527-2-yury.khrustalev@arm.com>
 <87ttcl89c5.fsf@mpe.ellerman.id.au>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87ttcl89c5.fsf@mpe.ellerman.id.au>
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic:
	AMS1EPF00000041:EE_|PAXPR08MB6621:EE_|AMS0EPF000001B0:EE_|AM7PR08MB5317:EE_
X-MS-Office365-Filtering-Correlation-Id: 49061289-cc99-48c4-adc7-08dcffd3aa05
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?JSb2SHQ4NAoCkNdg5nc4iT1xePZNn9csgr6q4/z0bjdZUeLnBzlwzizQbvS+?=
 =?us-ascii?Q?BaATd3XIzkuXa1zLOIZ/fTqubb/7Td0ZmOkh33316I9pkqg7mp/wHwEihwwY?=
 =?us-ascii?Q?5+MRbBu5xLPAuIBsF9uJ4J6vRODelRqpFtxdZ55GUBIqKmhcKRc5uWpo6ceX?=
 =?us-ascii?Q?jHH3sQkQkuJ252GErjZuJkJOuxK8jpomoOenGG7RuFkwQO0OndQO+iOSp5zl?=
 =?us-ascii?Q?PJJ/MvfRuss73q1dji9o7QjIiGy+VoiGi5wzu876eQYhozqeAt15mMZ1WUeW?=
 =?us-ascii?Q?DdAVqIUQZ71Fv0Odza9o5cEdFZxn3XQOyez8rQZpCS0wWAL7/JjNS0lipGs0?=
 =?us-ascii?Q?f9/JRUpi6MMmYmCCvrQyElkPygEGmBUGlGcfHMm0nTyE9pj7Qa53dqyC7rAy?=
 =?us-ascii?Q?PNGtanN/b38SpZMmZjlBUrpsvX3HKwFXacOCpJlq1TJl76nW/Zsmw9NJ8pGy?=
 =?us-ascii?Q?98S25g0TXLFFB5Z3hKkT53KXf/t9NxszJSBZst22clVHyyuNJ0+qNRG+E1Jc?=
 =?us-ascii?Q?zXYkMdpiTk+msnepg9AqFtjlViK5JFUWxsxEBJGeiXdyeNBEB1P3vWNJS88t?=
 =?us-ascii?Q?F6NjWnSPrWbtVUVEgvgxc52TqZp041EWV+GaswlQAr9W4D0YCMa+95bNDZcA?=
 =?us-ascii?Q?56aAWzKELtL0L65FcufizA2yP2qWseia8WoXnpDktQVnr81ri6Fpocx+Itd9?=
 =?us-ascii?Q?Y8x0NMs7jON4drAuM32zCC2YMw6Rdf4Ibn/8Ba8B5EDCzJi4X0XsfB2nPap9?=
 =?us-ascii?Q?l3Q2owzzwG/HNTGgqYnqXxqG+ys0srQR+KNMHqm8Nt6QNXCCr6fM+vNwTbZV?=
 =?us-ascii?Q?QCa3AAcet/B5adxMRGgJnnY5b8YExF8pxEXiQl8Brrah9tBy8U6jMhyV/cn5?=
 =?us-ascii?Q?3Ik4YwZvTDooA6MN6CORaNObfQGqboObQWPvajP5hyz2raIwrnbgngE/836N?=
 =?us-ascii?Q?f5Q+1uzRU3ywLZ124p2kuMGqyxthS4UvPJ6aIj/RUxY0EZ6dAQwqF1RJSAUR?=
 =?us-ascii?Q?MBjnxpzjfmzat/v8gl/C8lsV81WSr4Q3rV/atWShc7MSpJYfrImnUN3Eh1Xt?=
 =?us-ascii?Q?B4C0t+Zmsd6qgyXsDUaaRGBluvs3tLy2tZ/v8fBYpZJIUcnVYv5yK8PKP1M5?=
 =?us-ascii?Q?uI0CwCKiblNM1CfIdzayVO9Uxvc5q3a7zA1nG7syTyamlujBV7OULF3cAlWc?=
 =?us-ascii?Q?Ba94BJ1H55Bx6Fa0NsZaFNyQlcBVHaPITPi0NV1VOTGzDQMkldY31CSTG8GM?=
 =?us-ascii?Q?yX1w9baXaB2YoYSGS69jvPDLodv03ik6iM86cKHPrkstRpyHPLDowHPXaX2+?=
 =?us-ascii?Q?12r1qCvFlK7g5L3MArmnVWj2NAoFcc4KA58/YyKwXH82OEMgMxx4eJNTYEDN?=
 =?us-ascii?Q?psqUy4EhK62Daj21H1pTTq31ho8CI1efr13WVEC+bp89wDbA/oyISxCS6T4m?=
 =?us-ascii?Q?OJVL2xEiLJo=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:40.67.248.234;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:nebula.arm.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6621
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:20b:498::32];domain=AS9PR05CA0111.eurprd05.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001B0.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	d84be0eb-ef06-4387-c1ce-08dcffd3a2a0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|14060799003|35042699022|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DS7IdRaEc9EgQ98mUkQ+FDek0AOwdPT7656oNuaDAx5rN2/jRFCH90PQJHss?=
 =?us-ascii?Q?I9SwVLShyCjzPBT6TKqmtrB3qhFoOkH8Jzmau6hGztsexHosYezfqcv9jntm?=
 =?us-ascii?Q?25fqgeDwHodbYhJIzb7s8U1m+yJRgN80W54eKoyyCh8cXsXYTYd33rLe8CtJ?=
 =?us-ascii?Q?B34IPNOHVCtcEgBMkdo8ytc1x2/4/i+Dp/ZKeX5CB4R22duSu6d8n9aXX/pJ?=
 =?us-ascii?Q?xWwjjhzOoXym8BUU3rbNw16PpZM2Vi4bUQg2EVSOYaZMycOkNb4SFaWXFHIc?=
 =?us-ascii?Q?s0ELlQI8oXtarE2do8a1QkGSRATQgmcali0f0a/u8TjE9aOB9pV1cv4wvx41?=
 =?us-ascii?Q?p+Pth8kr7Z61UKzq2u3OLWmeUKS1FjTjVBZh7GoLUfPUOmeBhtrlObJEGCpj?=
 =?us-ascii?Q?bpqMCvWKSTkEE9nmpTNKwyaxbYk9UENdavftCnj+vdJ9K04utysB3YkgZQje?=
 =?us-ascii?Q?8GHac1W3tLjUubIourt1LB5X+LGRsnqQiVxDQM3ezvyVD0Mr1n2AT3vvECYu?=
 =?us-ascii?Q?NIBIurYCha6fnS26/Q8Q5N6p+BOhTG2XgVUC8XC9h1/AxVSUDBsRnP8kR+yx?=
 =?us-ascii?Q?6xP1MqTQg1VTsFQy8WbZ6iw/fT0dnvb6PDg4mvF8swcyn1zh5xBaxcKey97j?=
 =?us-ascii?Q?JWbORNKx/drseunECIVBKPCOYJFGdlndDT9tmkFg/6ohO2FhLThNRnS8aN9G?=
 =?us-ascii?Q?D5f+5j+GR0eUje9DrI2b2PtR6ZHPaCP/HJl6VRq15yBWtVd4LAIEtyEy+7eU?=
 =?us-ascii?Q?ZZjA4bzelC/eFsE3K5kItEQ3NYvU3Uh2LVVaxscHilsiVp1g1eocZs/bdqLe?=
 =?us-ascii?Q?cGNI5wQ4YIE+xPr3XLDvr0TmDhgXOcM17gImX9ZMefOYnByBBVEAHYSDnsVI?=
 =?us-ascii?Q?21Y2EXAWOolqKVMiH0M6yQ8rcNtdQqKAGZ0qhqienlDP2JwdMZO7Gd1pUmlM?=
 =?us-ascii?Q?zvyFZ+5fNF6lc6FX2PNWARGNjblOoJ7jD/vBeL7O61xp4X90kuKizI6lzAS+?=
 =?us-ascii?Q?AYZKHVtNGZG+KGqtfTrOUmXoG0c/DQrbW1A7QDkA5EcJk+z//6e9lUjVdEx8?=
 =?us-ascii?Q?vdimO3smUm45xRfneQ7x0IbS9RxkuHrtVDRDYW0LhegYgTklNQKMnGvjfNdO?=
 =?us-ascii?Q?yzytrZfEzimPkrPNiaVR8dG7+exUfMgAcEnBdbU8FgH0VtmuNJ1kgKlW/+z2?=
 =?us-ascii?Q?pZMfM+HElJRmoFM4/I9hhc28xEKzzWOOlYuoTPbFslsbnIN5/UXAO6U5f0CV?=
 =?us-ascii?Q?+FGZhdjJnDPHQfXvZGxu3rxD5vgR/YAb26p+xfCAv5lBRYKFptfLbyfyTJez?=
 =?us-ascii?Q?WCUugbjRLMqbOalejR8awD8mNy1BReaqu1aLcOytw88m4Aah7mRdP6xecfTc?=
 =?us-ascii?Q?N3iFg7ViYI2eEHzMg9R5Qja7xC51hrMO9IE4jim3ls6VUbmnOSvN2aPR6Tlv?=
 =?us-ascii?Q?iiKcD3lawd0=3D?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(14060799003)(35042699022)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 08:59:33.4980
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49061289-cc99-48c4-adc7-08dcffd3aa05
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001B0.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5317

Hi Michael,

On Wed, Nov 06, 2024 at 12:00:42PM +1100, Michael Ellerman wrote:
> Yury Khrustalev <yury.khrustalev@arm.com> writes:
> > Memory protection keys (pkeys) uapi has two macros for pkeys restrictions:
> >
> >  - PKEY_DISABLE_ACCESS 0x1
> >  - PKEY_DISABLE_WRITE  0x2
> >
> > ...
> >
> > This patch adds PKEY_UNRESTRICTED macro defined as 0x0.
> >
> > ...
>   
> Apparently you're not meant to modify the copy in tools/, there's a
> script that does that, which is run by acme, see:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/include/uapi/README
> 
> cheers

Thank you for clarification. I've fixed the patch in v4 [1]

[1] https://lore.kernel.org/all/20241108085358.777687-1-yury.khrustalev@arm.com/

Kind regards,
Yury


