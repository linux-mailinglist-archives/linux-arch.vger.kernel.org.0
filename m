Return-Path: <linux-arch+bounces-13734-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFBB2B973AB
	for <lists+linux-arch@lfdr.de>; Tue, 23 Sep 2025 20:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D206118A4D08
	for <lists+linux-arch@lfdr.de>; Tue, 23 Sep 2025 18:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B38426E706;
	Tue, 23 Sep 2025 18:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="AAOgpE+C"
X-Original-To: linux-arch@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013040.outbound.protection.outlook.com [52.101.72.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDB2A48;
	Tue, 23 Sep 2025 18:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758653137; cv=fail; b=KOe4O40dw8BtOEYMojPu6jJ5GnpSLVoUI9cgh2X/yT6hvgk6y8DL2hVlvnO2Ij6tXWJzBJtXOqUZDqdOXnDSTKWIVD4nFeW59Psy62VCQFEm/jOZMLBRiCvNceudug9PIoDmAjoYo+oSoloSmo1SQeHpp6eUU6UmEzEqjMyJXDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758653137; c=relaxed/simple;
	bh=VcAmDjXY9KSVEodvX3YTnqEyepfIipFGS09IS2k62Y8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=b0AzD7yi2gVxf2XaT/El8nB0muyldV93BckiGZ6nQqwpeS+k3aIyPy5DbfkoesDZDwnxk7g9BaqJ6I06KRxkZ4ZTPo+J3WxA+iWyqAQvffqUXXkiI0ZPx/5mLHSHABR9kgnQrbxMg4RhW4ih+c/KCJ/v2L6bsknwzrOi9+oXdFU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AAOgpE+C; arc=fail smtp.client-ip=52.101.72.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rWk0V9Z1lobUzmsoMqP1df1vEyKYbrfGy9YDLIjZA2QmNGPfdC8OcXHnznlog78C9RSETGGcnEr4qoF7uwLxndOeApHwENYHVt4sQkmqqW78cKOP5ARoud68edk0QwZOEW8+illICe+U8jAMlk66Ef2oJgWkN+1/k9C5rtDTP51GI/XDOVwqOQ7nU7zDL9rX3CqgFiANNrNw2Ch2xz9a6HFfJyskOyeftPm1sTCJxq4qLMopTTclWlFaGkOTrYsZ3DBROhzwGQ67npE76rVvPIZus689KpgAuYjQOfNmkfbOrgyIITnX4qhMsSZqgmHjn1lylJsl1CT/2C9rBgQYdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PqlHJ3v3Os2vyYC/PGpLXoER4boSJjiQN8+QEkGsIKY=;
 b=SCefBx/8tgpCrPbK59auJpcX0VXZocewYl6I54sKDN3bQvr8LdCBjx66UEBKZFzaJjgaskWrawo0AJhwRUwQaXvVLGgjR+rmdKScvDSEZoIN/QR+69cbB1Lq3e5rbFfbZMKQxkFJo6KNXEakr6dL7W7OJNaCAZ8vqa/KcTHXVx1FxvSvMfqdhjOAxFEuHk2rlXuzP9sXZ7PepPc6K8ESlcoaNDu6EU+tDzGu9HazpfoyxM0VQYEo52ay9u1jsv3BAad0z3oBamaF1yxByZv7u0lZIEj760IDckjzifhhr1FKG862fsCMNkfDCDalZfPYmJiTveFNGC0qBY60WPT6RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PqlHJ3v3Os2vyYC/PGpLXoER4boSJjiQN8+QEkGsIKY=;
 b=AAOgpE+CdTLUf86eBGhYUOnn7VOMaJOOJWUZjpMK9KPQ9nC3MFHSzzXtKQAqVF0f+ixU8JnHZAuTUuqivMhUylVPybX8OxGk0ut3PD3VyW1va3tT1wZjBXGD76hve79l8crOqWEfQMCqOWu6H7mdm8gUF7DYdCRbM9S19Dn6g/jYdSKi/LpUi1XbmVjey9+K/+tLCZSm58/w9252XLorUg+rKvOeozLOJY4hkrDfVJVxQJU9eQxutuWQm+n0wQB6HyHJhChCuM5Ul+nUpfWLC2aemASZIytxAdI/WsxVu89bg5TqD+I6RmpIz1eD69FTdUvvdOl+CrIyzuAlFXtpOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com (2603:10a6:20b:4ff::22)
 by PA1PR04MB10769.eurprd04.prod.outlook.com (2603:10a6:102:488::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Tue, 23 Sep
 2025 18:45:31 +0000
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e]) by AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e%4]) with mapi id 15.20.9160.008; Tue, 23 Sep 2025
 18:45:31 +0000
Date: Tue, 23 Sep 2025 14:45:19 -0400
From: Frank Li <Frank.li@nxp.com>
To: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
Cc: git@amd.com, michal.simek@amd.com, alexandre.belloni@bootlin.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	pgaj@cadence.com, wsa+renesas@sang-engineering.com,
	tommaso.merciai.xr@bp.renesas.com, arnd@arndb.de,
	quic_msavaliy@quicinc.com, Shyam-sundar.S-k@amd.com,
	sakari.ailus@linux.intel.com, billy_tsai@aspeedtech.com,
	kees@kernel.org, gustavoars@kernel.org,
	jarkko.nikula@linux.intel.com, jorge.marques@analog.com,
	linux-i3c@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-hardening@vger.kernel.org, radhey.shyam.pandey@amd.com,
	srinivas.goud@amd.com, shubhrajyoti.datta@amd.com,
	manion05gk@gmail.com
Subject: Re: [PATCH V7 3/4] i3c: master: Add endianness support for
 i3c_readl_fifo() and i3c_writel_fifo()
Message-ID: <aNLqv/yjhwu3/ai0@lizhi-Precision-Tower-5810>
References: <20250923154551.2112388-1-manikanta.guntupalli@amd.com>
 <20250923154551.2112388-4-manikanta.guntupalli@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923154551.2112388-4-manikanta.guntupalli@amd.com>
X-ClientProxiedBy: SJ0PR13CA0113.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::28) To AS4PR04MB9621.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ff::22)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9621:EE_|PA1PR04MB10769:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fe6a1c7-2037-4201-cc6e-08ddfad15f50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|52116014|376014|1800799024|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bOyfRWpDCUmDjPdKVgJXniYFKeoS/WXE7cqvuR1WGT3/ZqKou8mJOn2AyPRe?=
 =?us-ascii?Q?4SllOr4OTC1AgihavTw6VXMu6zOp+MAgm+8vEWq3xtvg9v74Y8v+yanktJX/?=
 =?us-ascii?Q?VLGHLWSR0JD4cSgBhlmXcevVrUdvRfTGooJI23fOBLCYUNrw7iYYdOsYtrBH?=
 =?us-ascii?Q?y+9R3SDS1W2arwIzfHGtTqiKKwZ3R9JlMaBRXLqVMis4BhpW/7a411ii9Lj7?=
 =?us-ascii?Q?5yDyZyh5NSpwzKPXUMlqzEtktXwSNu9YGlaLGVSMyeDpuxUPXN9o2XI1VyrJ?=
 =?us-ascii?Q?E6PemOY4NJRnJISEwr9OFW6AkmEvlaVBr2iMI6Oa1Tp+vw2jA4WQoKkWBNkv?=
 =?us-ascii?Q?YMslvRqNrmDlfhW73bd8afAGiYDIhCYGAq85vDx3c3IGJwyuj95vIGILjzk6?=
 =?us-ascii?Q?MbUsGHii1wD7vCwJGGpcvIKvzXdOQHcxLiv2FyOBzMD/oRaQxBYHp2/QWKSB?=
 =?us-ascii?Q?1OrYwj178ssrFgo6GOaXmdJxVdaA8BPS2Br2sIbKq3cRnRvmOBsoVMdgjMv6?=
 =?us-ascii?Q?PkmRjEv0S+qIrAMRa1DzUGdRPrWeBjcd/fIJX4SYya/QKTMDWN0+xETpgFwn?=
 =?us-ascii?Q?n9lfW9FBt2T8I/YgRXRi3Tda8leuo5lQj/BNG4k/6npPf4tI+8rF4Edy12Rh?=
 =?us-ascii?Q?/jHV5VmXwwVEgpd3AXtCy3uJqoancCGlKu72LwsEsA4iSOgiW89cU/kp1aTw?=
 =?us-ascii?Q?5qQ6RAG1dXMjUJhMt9Bq1kG5xLjWUJaNyktVp3vBfUb2TdxECAhruVkJxMjI?=
 =?us-ascii?Q?/JX6ypvsyyfzrkDT++aSfaxoZzG+iKi87NcbNuMfXpQvIPLUYSGpuObVXNQS?=
 =?us-ascii?Q?g54K35JfYpdKF1Cw+SP8qH5PyTsHJZsO8tTnQvLCSdfrRVnEdm2Sig9SwYvD?=
 =?us-ascii?Q?U+w7DwV+7T+tZb3wiVDPU0aKvpdrDIDulPfSN4j6rktdaKrOxm4ZYV5d5RZU?=
 =?us-ascii?Q?IdZsCpK8KZwSi6LWXtXwtgzDaa8/M+GMr1zWCVETSrXVJAXojtZs5jQU0qfh?=
 =?us-ascii?Q?/8QDKTOEt7PxRD87HGLHWh8QfOFd4HMbLT9+bstU5Iyw9Z1yC5CSFKNdVn1N?=
 =?us-ascii?Q?VX+bDHb1IhcGrkhf+nnTM8MlYvNKthnX4Baj6i3jyyOGReZD4POi3CnKUD9n?=
 =?us-ascii?Q?i7Wa/TsjwE9dVfxIzA7lHsZR8VLgK1LevvlPv9ZJ1EzKXyfINtLzynE2xY4v?=
 =?us-ascii?Q?d/pT30YfCgtUVTLdyr7fMUAE4TJg09E8rJr0A6f1B9/M2u+Xy21zj3/p3Wqs?=
 =?us-ascii?Q?3nwg02jOhf0k9HsQrZCWygmTnDHpeLNUSndgeVctV0y1X0Wbo7wW04pR/qK3?=
 =?us-ascii?Q?D1JM5nkXJ5Ta1GgXYNpvuf2+Jgv1hzpcCgwocYukhWOMzWq3nWk2ztjSDfKx?=
 =?us-ascii?Q?eqs74W3ulvBm/Zov1lf82NC0N70dbKaeiydE8QihKTxaZUgCQyjXSzfSDis6?=
 =?us-ascii?Q?6ajhA+8WAfK8DdJUoLlsMLLABt+VKRrGY+WOrBHCYp/3oTEUq6PM5g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9621.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(52116014)(376014)(1800799024)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2xH85hSmUwmeBoptsoiAyOUmDCpL2kKUICKyi3vDqvAB1mh2PDnwLndJtT1Y?=
 =?us-ascii?Q?qDD33beFiYsO1o8PqZmvh0wxIUcOkDO9Kxi1QE6kL9vQLGhP9Z+e8L4J+nRx?=
 =?us-ascii?Q?PfgFV3Y82w1dwGSi/rjZ4eFQbEPbXtKFwCdY5blanOlp9C4AvuLioU7WYbYd?=
 =?us-ascii?Q?P4o5SxB0acFVYDzLSj5TVOiCwTxv6OETS4DnSvZfPl310xFCumCSDcdJlvMB?=
 =?us-ascii?Q?uva74shudCDUE5tbihLOo9NsKSCd0CudtwI72smqxP/mDNErVREkOIUCo00b?=
 =?us-ascii?Q?2lRYeOP6SCRYiFfG0IwHMUQnptOZVwW8FWChp/uBmsCdPXew85c8+s+0B01Q?=
 =?us-ascii?Q?mxWpOy46ETxBItICO61lYQ6NABKutGRlBQP3YbQdx6EVnBJddcSg+JJ6Aclo?=
 =?us-ascii?Q?7/q/T0P2zdDzCwXU3HYQVK++g/C0uhlczyQiXLi1hugmqQ5tqJUELUeRks4G?=
 =?us-ascii?Q?OXCCractJowwDndco7iUJCCsk+k3AFR0UPZaXukrqz1f49dBU+nDAY1cV5G5?=
 =?us-ascii?Q?jq9JCGvtxhwFx3b8127XNHt4VA6RnqK5cl/8Wl3DEnmeUbVcEdjDTLy0i/p7?=
 =?us-ascii?Q?ciLTTl7V+IlFASI2Jd9oN7orXfn6+Bnit+jMIkQSt0BVvbXVZuCZct+ZtxWl?=
 =?us-ascii?Q?2qPZtrnohpisqQJwMGJSqjE+Dv/QU5qauL7jSi9k84k38LWGqdHw16htnQxI?=
 =?us-ascii?Q?6wert2PQGJQn/ozgmt/KTZmI0OmCQZO/YCDykhrWVeEGzJhhL7jc1vYoteug?=
 =?us-ascii?Q?cn87rngEVAOUS86482LqVC7Z1sxDbIrcYIShbeh+Fhwgq6PR87SxKzw89UYA?=
 =?us-ascii?Q?S+iu39VwO+lpCcF7YXJgNJp6gJ0UhBfTue2Pd3r0z83EwJLEPDHYRQ7cxCRv?=
 =?us-ascii?Q?Sg/jdT2gyHqUHUw/FcZs1V0vA4lim+TxtTqrFw5cxR2Sbw90u77scau8FDNo?=
 =?us-ascii?Q?iZrmxB5lOtH/C2egltSrZZRGa+snPnqBixDwBShutbWNv80QREh9NnZqMeAG?=
 =?us-ascii?Q?U+/1zxBMNL7egF/bUCesxW+4mxXhlVcWHWCU8HWk3JuMLHQRViJKNwWQ9p4l?=
 =?us-ascii?Q?QJiix6AoB0AFaxketWwfN1UIVCe3OwWyQDJMI1Dc7l/1RSKBrWTKR0CMREDx?=
 =?us-ascii?Q?uPIXn1XBzOORaRRBr/5tm2rIOsJPjVPeiPkUKplpQV+/Qni+Hzlv3mehjgti?=
 =?us-ascii?Q?iVL9VMt+pwPICqhxAfYrj3hkOGl9b9sg16MxUpdnNDVEopfR87VoUqRikjmp?=
 =?us-ascii?Q?lsbBVBvj934TZSJ4FECcg7xi8/flffWw4+g2UqQezlkniIWoFGlt3UVR3dQJ?=
 =?us-ascii?Q?Ym7lW4+E3U1N0PuMLNX5I67i9LZe1ALs0kF6duqp4h1OecnKKP0aysCo8v3q?=
 =?us-ascii?Q?MynWNOBl8yummbENvjXQsl46wK3Ntg1Npu/PkwPOKjcYv+/i8cJNL5eWvH5W?=
 =?us-ascii?Q?gD1LxCG8XWbbfrfcEqYSV9/3zVE295GTm6Zbpjt5TGBax+/bbQIqgusIB7GI?=
 =?us-ascii?Q?LQ9wQRsOrMi/z2DEBTEdyizPCSxot8qtTH7Nf6nep1pDorN5wxmrGk5i1UOT?=
 =?us-ascii?Q?EA9vBJ7SZTJ4t1TotbnR14v8WCRilo8LZevDvbwP?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fe6a1c7-2037-4201-cc6e-08ddfad15f50
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9621.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 18:45:31.2878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Le98MGW3l9Pu6mjo/XSH9mPfDsG6VUJCEU7oh1aeSaUkDJgYm8yL/54sMsk2x+hf1lGp3fdSPpQDpWgxNMGe1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10769

On Tue, Sep 23, 2025 at 09:15:50PM +0530, Manikanta Guntupalli wrote:
> Add endianness handling to the FIFO access helpers i3c_readl_fifo() and
> i3c_writel_fifo(). This ensures correct data transfers on platforms where
> the FIFO registers are expected to be accessed in either big-endian or
> little-endian format.
>
> Update the Synopsys, Cadence, and Renesas I3C master controller drivers to
> pass the appropriate endianness argument to these helpers.
>
> Signed-off-by: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Changes since V7:
> This patch introduced in V7.
> ---
>  drivers/i3c/internals.h              | 35 +++++++++++++++++++++++-----
>  drivers/i3c/master/dw-i3c-master.c   |  9 ++++---
>  drivers/i3c/master/i3c-master-cdns.c |  9 ++++---
>  drivers/i3c/master/renesas-i3c.c     | 12 ++++++----
>  4 files changed, 49 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/i3c/internals.h b/drivers/i3c/internals.h
> index 0d857cc68cc5..399bbf006dcd 100644
> --- a/drivers/i3c/internals.h
> +++ b/drivers/i3c/internals.h
> @@ -24,21 +24,35 @@ int i3c_dev_request_ibi_locked(struct i3c_dev_desc *dev,
>  			       const struct i3c_ibi_setup *req);
>  void i3c_dev_free_ibi_locked(struct i3c_dev_desc *dev);
>
> +enum i3c_fifo_endian {
> +	I3C_FIFO_LITTLE_ENDIAN,
> +	I3C_FIFO_BIG_ENDIAN,
> +};
> +
>  /**
>   * i3c_writel_fifo - Write data buffer to 32bit FIFO
>   * @addr: FIFO Address to write to
>   * @buf: Pointer to the data bytes to write
>   * @nbytes: Number of bytes to write
> + * @endian: Endianness of FIFO write
>   */
>  static inline void i3c_writel_fifo(void __iomem *addr, const void *buf,
> -				   int nbytes)
> +				   int nbytes, enum i3c_fifo_endian endian)
>  {
> -	writesl(addr, buf, nbytes / 4);
> +	if (endian)
> +		writesl_be(addr, buf, nbytes / 4);
> +	else
> +		writesl(addr, buf, nbytes / 4);
> +
>  	if (nbytes & 3) {
>  		u32 tmp = 0;
>
>  		memcpy(&tmp, buf + (nbytes & ~3), nbytes & 3);
> -		writel(tmp, addr);
> +
> +		if (endian)
> +			writel_be(tmp, addr);
> +		else
> +			writel(tmp, addr);
>  	}
>  }
>
> @@ -47,15 +61,24 @@ static inline void i3c_writel_fifo(void __iomem *addr, const void *buf,
>   * @addr: FIFO Address to read from
>   * @buf: Pointer to the buffer to store read bytes
>   * @nbytes: Number of bytes to read
> + * @endian: Endianness of FIFO read
>   */
>  static inline void i3c_readl_fifo(const void __iomem *addr, void *buf,
> -				  int nbytes)
> +				  int nbytes, enum i3c_fifo_endian endian)
>  {
> -	readsl(addr, buf, nbytes / 4);
> +	if (endian)
> +		readsl_be(addr, buf, nbytes / 4);
> +	else
> +		readsl(addr, buf, nbytes / 4);
> +
>  	if (nbytes & 3) {
>  		u32 tmp;
>
> -		tmp = readl(addr);
> +		if (endian)
> +			tmp = readl_be(addr);
> +		else
> +			tmp = readl(addr);
> +
>  		memcpy(buf + (nbytes & ~3), &tmp, nbytes & 3);
>  	}
>  }
> diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
> index 974122b2d20e..5d723ac041c2 100644
> --- a/drivers/i3c/master/dw-i3c-master.c
> +++ b/drivers/i3c/master/dw-i3c-master.c
> @@ -337,19 +337,22 @@ static int dw_i3c_master_get_free_pos(struct dw_i3c_master *master)
>  static void dw_i3c_master_wr_tx_fifo(struct dw_i3c_master *master,
>  				     const u8 *bytes, int nbytes)
>  {
> -	i3c_writel_fifo(master->regs + RX_TX_DATA_PORT, bytes, nbytes);
> +	i3c_writel_fifo(master->regs + RX_TX_DATA_PORT, bytes, nbytes,
> +			I3C_FIFO_LITTLE_ENDIAN);
>  }
>
>  static void dw_i3c_master_read_rx_fifo(struct dw_i3c_master *master,
>  				       u8 *bytes, int nbytes)
>  {
> -	i3c_readl_fifo(master->regs + RX_TX_DATA_PORT, bytes, nbytes);
> +	i3c_readl_fifo(master->regs + RX_TX_DATA_PORT, bytes, nbytes,
> +		       I3C_FIFO_LITTLE_ENDIAN);
>  }
>
>  static void dw_i3c_master_read_ibi_fifo(struct dw_i3c_master *master,
>  					u8 *bytes, int nbytes)
>  {
> -	i3c_readl_fifo(master->regs + IBI_QUEUE_STATUS, bytes, nbytes);
> +	i3c_readl_fifo(master->regs + IBI_QUEUE_STATUS, bytes, nbytes,
> +		       I3C_FIFO_LITTLE_ENDIAN);
>  }
>
>  static struct dw_i3c_xfer *
> diff --git a/drivers/i3c/master/i3c-master-cdns.c b/drivers/i3c/master/i3c-master-cdns.c
> index 97b151564d3d..de3b5e894b4b 100644
> --- a/drivers/i3c/master/i3c-master-cdns.c
> +++ b/drivers/i3c/master/i3c-master-cdns.c
> @@ -428,13 +428,15 @@ to_cdns_i3c_master(struct i3c_master_controller *master)
>  static void cdns_i3c_master_wr_to_tx_fifo(struct cdns_i3c_master *master,
>  					  const u8 *bytes, int nbytes)
>  {
> -	i3c_writel_fifo(master->regs + TX_FIFO, bytes, nbytes);
> +	i3c_writel_fifo(master->regs + TX_FIFO, bytes, nbytes,
> +			I3C_FIFO_LITTLE_ENDIAN);
>  }
>
>  static void cdns_i3c_master_rd_from_rx_fifo(struct cdns_i3c_master *master,
>  					    u8 *bytes, int nbytes)
>  {
> -	i3c_readl_fifo(master->regs + RX_FIFO, bytes, nbytes);
> +	i3c_readl_fifo(master->regs + RX_FIFO, bytes, nbytes,
> +		       I3C_FIFO_LITTLE_ENDIAN);
>  }
>
>  static bool cdns_i3c_master_supports_ccc_cmd(struct i3c_master_controller *m,
> @@ -1319,7 +1321,8 @@ static void cdns_i3c_master_handle_ibi(struct cdns_i3c_master *master,
>  	buf = slot->data;
>
>  	nbytes = IBIR_XFER_BYTES(ibir);
> -	i3c_readl_fifo(master->regs + IBI_DATA_FIFO, buf, nbytes);
> +	i3c_readl_fifo(master->regs + IBI_DATA_FIFO, buf, nbytes,
> +		       I3C_FIFO_LITTLE_ENDIAN);
>
>  	slot->len = min_t(unsigned int, IBIR_XFER_BYTES(ibir),
>  			  dev->ibi->max_payload_len);
> diff --git a/drivers/i3c/master/renesas-i3c.c b/drivers/i3c/master/renesas-i3c.c
> index 174d3dc5d276..5610cf71740e 100644
> --- a/drivers/i3c/master/renesas-i3c.c
> +++ b/drivers/i3c/master/renesas-i3c.c
> @@ -835,7 +835,8 @@ static int renesas_i3c_priv_xfers(struct i3c_dev_desc *dev, struct i3c_priv_xfer
>  		}
>
>  		if (!i3c_xfers[i].rnw && i3c_xfers[i].len > 4) {
> -			i3c_writel_fifo(i3c->regs + NTDTBP0, cmd->tx_buf, cmd->len);
> +			i3c_writel_fifo(i3c->regs + NTDTBP0, cmd->tx_buf, cmd->len,
> +					I3C_FIFO_LITTLE_ENDIAN);
>  			if (cmd->len > NTDTBP0_DEPTH * sizeof(u32))
>  				renesas_set_bit(i3c->regs, NTIE, NTIE_TDBEIE0);
>  		}
> @@ -1021,7 +1022,8 @@ static irqreturn_t renesas_i3c_tx_isr(int irq, void *data)
>  			/* Clear the Transmit Buffer Empty status flag. */
>  			renesas_clear_bit(i3c->regs, NTST, NTST_TDBEF0);
>  		} else {
> -			i3c_writel_fifo(i3c->regs + NTDTBP0, cmd->tx_buf, cmd->len);
> +			i3c_writel_fifo(i3c->regs + NTDTBP0, cmd->tx_buf, cmd->len,
> +					I3C_FIFO_LITTLE_ENDIAN);
>  		}
>  	}
>
> @@ -1061,7 +1063,8 @@ static irqreturn_t renesas_i3c_resp_isr(int irq, void *data)
>  			if (NDBSTLV0_RDBLV(renesas_readl(i3c->regs, NDBSTLV0)) && !cmd->err)
>  				bytes_remaining = data_len - cmd->rx_count;
>
> -			i3c_readl_fifo(i3c->regs + NTDTBP0, cmd->rx_buf, bytes_remaining);
> +			i3c_readl_fifo(i3c->regs + NTDTBP0, cmd->rx_buf, bytes_remaining,
> +				       I3C_FIFO_LITTLE_ENDIAN);
>  			renesas_clear_bit(i3c->regs, NTIE, NTIE_RDBFIE0);
>  			break;
>  		default:
> @@ -1203,7 +1206,8 @@ static irqreturn_t renesas_i3c_rx_isr(int irq, void *data)
>  			cmd->i2c_bytes_left--;
>  		} else {
>  			read_bytes = NDBSTLV0_RDBLV(renesas_readl(i3c->regs, NDBSTLV0)) * sizeof(u32);
> -			i3c_readl_fifo(i3c->regs + NTDTBP0, cmd->rx_buf, read_bytes);
> +			i3c_readl_fifo(i3c->regs + NTDTBP0, cmd->rx_buf, read_bytes,
> +				       I3C_FIFO_LITTLE_ENDIAN);
>  			cmd->rx_count = read_bytes;
>  		}
>
> --
> 2.34.1
>

