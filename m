Return-Path: <linux-arch+bounces-13737-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F9A2B97539
	for <lists+linux-arch@lfdr.de>; Tue, 23 Sep 2025 21:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D20824416C9
	for <lists+linux-arch@lfdr.de>; Tue, 23 Sep 2025 19:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBAC7303A08;
	Tue, 23 Sep 2025 19:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Olo+qSmX"
X-Original-To: linux-arch@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013046.outbound.protection.outlook.com [40.107.159.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D8124E4A1;
	Tue, 23 Sep 2025 19:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758655375; cv=fail; b=jFuO94n6884CginzeG1b51tnvKy9yWk8yQBvyrGGNAfvxFfqJrmitJFtA3quIQ/v02qxXHtTivfcorGwX220mq+ROREaIdZuZHfNIyY2x9i2Cjs6E+Y4l6zyt6X4uqFsarGknRgVUD4hnsBpEg7qHfs/HvUASmvKfYrdZVM4TU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758655375; c=relaxed/simple;
	bh=gf90nlYZXJWvV2ZxL+sT7+dCl6xEH+vnlupGLzW2lTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZNBiudouiZsZwtsQucME9nDS8L3qlVD3ppyGsFGvIZwhCyZIWKYamLkWxMTZeHSeHDEjPhgvdeq65lYDjhL0cPP31aK3Wuo25SBlBmVO5zSnWgXz5WgNGGWSdgp11CTvUUNcXQ8eZh3/wJkSoNyOtwbA/PpRXgaBAV3NExykQOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Olo+qSmX; arc=fail smtp.client-ip=40.107.159.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BkQm9R/sAScWJlSWVbp/CP/+uxiZ43kAWbWQzkh2hrPdDVHr2FANlcP+6/+3eA9VZbRYs8pTbnfVUTUyynqlDV54P/G8DsZAD+wHqMNC9lhzgtplkrlBDzY+iwgG3wEUnsQ/U9ykSvTZ2OwX/eUaIbUZIXTZYoNnW5kyvSbuPgiadJO2QDoQJW45OfBWK3faQu0p/6BWznWf+wWs7Ouf/MfzB2OJqD5PzgJD4w1FuV+PgLGSvsFJzqsvtVfcz2E+4FXERaA8klkOub2AYA4jJs8FHWEIuZ47Gfd/sZ9nt10zfxZaV0Vi0qPILW08yqc9CVoZL4SXHcSylyg9ORgdAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=woEgEtSUL6BMBgXy+ttXtvFm3pCETRY9RBigW9bKKS4=;
 b=piMenZiI8B8gror4vkX/IWtCXbvFS45inGIc26RxnHEZ6hKrEgFkPMrD70CbEtHSuIdMth5MGsXlwGKNq0zb6MutN283tRjTykDHOXIrgsT3S9zYpP1tYWG4hkigbSVFAiJLKVJkZBrp/XySW44jQcnEuM4k76CH61czmw+xZ8gQ76u+xxaHTs/oxpFVCILNSGM7+fNw6KTJgVQrh7ljS5cgTqP72GmuS7Ou6nrUZ5PAsspVZxOJzyB5K6dsiyMqrh7IMXqArd3vTMEdYIfXbE90Z1UIDRwLxDLYRTUIU/LCOm53pVwafehr+oC8eSF9IRC+5xkRgbQM8fewxbj1IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=woEgEtSUL6BMBgXy+ttXtvFm3pCETRY9RBigW9bKKS4=;
 b=Olo+qSmXWV74kM6xP4j5Ov4/xGekKB82//BfVD2PDdJ65iZm+l+q7mV+IqUZ4iIrIbfHzPyuYnM/qSFmcp8SsvWx66exUpr/Wi8SpHYkFe1AaSCkax7HCpClkeIAwiePeqlxSVuuxMpilknk9S3BLnM6dYPAGzqxYrzpytv6sXvWxnSKjX53+yEDrCDxceHaLKKe4DDXlJSKEpUbkn3tcu4E9QuTcpp557V6WTuQj1YvybGIBtpJ7m3elJ5+BYY/uN9cggUqhX/I6wavpgWjoX+R4Ke0cuD4Sq8PtsTfDq6UJqOgoCWvyPvY6t6c+q5WaAEqhwzCZZTkg3ECkO6Rww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com (2603:10a6:20b:4ff::22)
 by AS8PR04MB7765.eurprd04.prod.outlook.com (2603:10a6:20b:2ae::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Tue, 23 Sep
 2025 19:22:50 +0000
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e]) by AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e%4]) with mapi id 15.20.9160.008; Tue, 23 Sep 2025
 19:22:49 +0000
Date: Tue, 23 Sep 2025 15:22:38 -0400
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
Subject: Re: [PATCH V7 4/4] i3c: master: Add AMD I3C bus controller driver
Message-ID: <aNLzfnN0QGF0qT7e@lizhi-Precision-Tower-5810>
References: <20250923154551.2112388-1-manikanta.guntupalli@amd.com>
 <20250923154551.2112388-5-manikanta.guntupalli@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923154551.2112388-5-manikanta.guntupalli@amd.com>
X-ClientProxiedBy: BY5PR17CA0010.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::23) To AS4PR04MB9621.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ff::22)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9621:EE_|AS8PR04MB7765:EE_
X-MS-Office365-Filtering-Correlation-Id: ebc627a0-906e-4228-6ef5-08ddfad6958d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|52116014|7416014|376014|366016|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?130LrlMI5wlR/u7wh/Rc2rqHyW0QEtLij0oiNpxBzwptM4CXbzGN4Je/LqG/?=
 =?us-ascii?Q?HjTiH2L66irkgv8Lb5q1C4/1ENpAXVvlNeJZfp9ECWAYDVFXfQ08uxHjpEj7?=
 =?us-ascii?Q?QG6r4BIY3U46Nh3C7pADcARgs99G9sbaM0WTuO460tlGspVs8ZLYZdZy6KLg?=
 =?us-ascii?Q?yYwlk6XJxVOUfRuKNwXlMln05/Rkc8AQL9C5HSnkQLanhXYJ5AQsUGAKzjUe?=
 =?us-ascii?Q?Y2NzDDiFTpTQaGBJxJ9O+RjOGH9cXBDk0mFNxVtbyNAYg8Mxd0GmLIu/Ut7N?=
 =?us-ascii?Q?SpzdRKxue1F9G1WbVy4f+clUS/s0M3999/WUkil+DLFuUyzc+vW0HKodHnUm?=
 =?us-ascii?Q?10LP6mM4ee2gu10MN6C+R1fALCKjJ3wHWbukZIyDU+1SU7pmThGYga3bLGqM?=
 =?us-ascii?Q?ZXQFV+IJP7VyrsmpQy49500m2pJlilFtD1RxAytKH6oLU6HOCYOCLG1pADhV?=
 =?us-ascii?Q?RlnIaNcgnA2vr8TQYJye2jssH3/rZtiOWysuU/j8jAdgoMl0iv2n5yoA+gor?=
 =?us-ascii?Q?XZ7N1lApkzPbTXI8Fw87QWCBG+vnLagekTBlDOT8Tgn7W2BYW1QIn4dOr5PP?=
 =?us-ascii?Q?n+z4TGcQ4WfDjJcaT56mgDh3wkUqvFaBhMAbD2AQPXHhEj697ujTkVMEBmYF?=
 =?us-ascii?Q?DV4DvK3C5v7GvldVMgxcpDyGTy0+t7u+ID3CiOyFWhIqTw6nQR6QS+ZV9Qg8?=
 =?us-ascii?Q?246oaSM6XO3EISb0pWyaMlsijCaoDRthxI4u9bZ7IjXa4Mb9tvPvZR1z42Nn?=
 =?us-ascii?Q?r/4Kp7yRHu1/CP90uw2UqLcjaHpOl8CczZMFH8WQtX0dOr6+x1j9fW20lbOW?=
 =?us-ascii?Q?69nsQgq1Cpqxcw5NTPB2ZPJHP/cZQktovtmSgIV3dyeSdtRhxtcf/4TgR+u1?=
 =?us-ascii?Q?Y3E8nNaAqFXt8uWvwUNijKV9ADo0XxS0des7Rnz+SxqICVhOT76sRmbAbdBV?=
 =?us-ascii?Q?UZ6U0SAa+47SmMzQpLf9ZZ33KU5a5+gdaftxgKx6Hrsui5e/z7T5Fjzf94pF?=
 =?us-ascii?Q?yTUtMPvAxuKgky6jf3+HPvuMv2pB8sWys8klRLEh9vyC6EuLaicsyfgdsglf?=
 =?us-ascii?Q?XrEpIoLOlJ0UKQmb/kFs7tmIVEIhTkgdtF+sMadexPlMNC6qk8hJmBuQMkNC?=
 =?us-ascii?Q?m4lX8+S5HHWgqoTeFWFFtZfWv++iQCr4mKNuKrGhjYMdR/6Icog4IjS0b/om?=
 =?us-ascii?Q?UQrPGan2nBi62yHOe2SQxjOJRGREkYMrnn0vdHV+nxaCzQsXDXDDbxzwBbF8?=
 =?us-ascii?Q?6LyhLUekSvipCwwfczyFM+OFwYU1/Zic51K5BCGBYWQzgCWQih5KnLu2YWIw?=
 =?us-ascii?Q?r40vBYjIObYh/BXd7bwLoLydELiwZYnP3Ptjo6e9xDFCCQI9xFH0/H8Ve+Ke?=
 =?us-ascii?Q?QVMEJGtcikwyhuMeP0oYqh4gBFAC+QX92ohSbfMDIoq2BW6Ks6MSGNW+iANm?=
 =?us-ascii?Q?usXGomOd//Zeg60hU6e/ooPUGhZUsLfEqFSQBKc8bgOgvfj2mQzkWA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9621.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(52116014)(7416014)(376014)(366016)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?r0Kcip4JS/z+Us/33gjODfjDrWtMgxaOn49B+5ZjrzwUtDkvgi1wGfd2G+Vg?=
 =?us-ascii?Q?MiGbc9/w0aaaT0jxn80sn7mGTQRt1cxg0cJJyZMRzzIumiV61UuOj5RHRDnm?=
 =?us-ascii?Q?2St/fAImNqd7geux2CZJIixBzzYJUftQrq5j98SjlaKyKB2U+6x0olvXxRIO?=
 =?us-ascii?Q?pcJnOz7yMcDJF0LCANFPRYf3IsIHRFCnp48vM3ELWBrUitx+fCOcvxJ4K/zo?=
 =?us-ascii?Q?kPB9w494lNXA+hHQ/8VgMuJ2oGZHrpeRMXTTBd7pJwIDfi0ZO45M1fjbeD9w?=
 =?us-ascii?Q?rohWEOlT0n5+NJPCvXpe0snoAMBL1mzR0P05kbyZdTc9gtSPGCT6q1Lj+R1k?=
 =?us-ascii?Q?1uMG92P1FWq5mTS0Xk4kFugIEDVbyIEqj2lqayPolYzERd+G2Y35As4pSJq3?=
 =?us-ascii?Q?OqHTWBL6oE4LyDlvO0lZ6P1++LIY5J3jAqFD+cBi6+ROe2QBjGmQFNvCWUm+?=
 =?us-ascii?Q?HB4HBKCJTOsFuLVmEb5oXttJqan62zDZHalRWNf/f17X1sNSy8aRgZCJjZts?=
 =?us-ascii?Q?V3WGyjQ3ef2b6RQ8u8S455Hp3edoY9usJKTrRjgfbGORXvWGgTVRwTuaGYx4?=
 =?us-ascii?Q?YUmwmZTGzO09kjtKJ2sUELlMxGx3ZhDbcLBP9XHx4FwrGOleM9/NohCUqqd6?=
 =?us-ascii?Q?uZIP4AgJnoJqmHp2503f+xAizpQrZMzfYY9nvVkmAQX+p1W58rPnoC/Od/ve?=
 =?us-ascii?Q?+J9Us45pn4trKwWvXfES3YWEyFLqqPfWwAqjA++xFixQh1qM6NepQiQHsG2T?=
 =?us-ascii?Q?XG4eK9XgQ65E0QikzI0gFFCBf4qhLbdWRhl+Eps1XOuX0zuYqFYPuuSllvMx?=
 =?us-ascii?Q?CpwlLWVdO0Q/SeCk8d5ciVTMNrdz9RyiSn/vTM5Yyg3AXtdfUrww3yX+wY1U?=
 =?us-ascii?Q?qQ48WijxdkxkuDF0YSmAhrUWTgVVXx5OY1QhGRtCz+XjPanuJHfkITaXsAwC?=
 =?us-ascii?Q?vTuc5ENL5gl+SnDT4LpvVFydJr6j+rcd8krtSRgoFdwQ/ZGl/Z3aU8RVDP1c?=
 =?us-ascii?Q?JupODOwz+LXoY449jAGVVg85BTvdBKlT8RJBF2KfOKQyBIKK+muT9EvwCA17?=
 =?us-ascii?Q?fCWkznsVpHn78bFzWmEghmGH7qaTM1wPYkNRGWZfxAz/llJheW9QjQ/1RQcI?=
 =?us-ascii?Q?57PNHfrpMD/Ra4GsgU64ebjhfxZGqLCq8lzJbOkwZQ/Ef6KtLLSFygdMMYKZ?=
 =?us-ascii?Q?ytXDNCRvTvrSuUAARL3fl+WioYrpdSkSftrbWJwbEr+g+gX5NQzC+fzVcHWk?=
 =?us-ascii?Q?T4nqYM4ycTyxDN1+gDPpxPLyLNi8z/6B8c9wOFgyxUg7if8ZwtNFL6kndpV1?=
 =?us-ascii?Q?TN8nASO5xkL24nb9ukEDGuvG8KAfdLMaSF7nQ3grQNmfeQ1sx4dqsp+iQZM7?=
 =?us-ascii?Q?5IzaJwqBdA2c8lIyxhtHcXhFxx3HZKsxueG55lPSuDVyt2oe1IRcQqRZbw7u?=
 =?us-ascii?Q?02FEKaUQaDnIupIlZs9MRA2kHC++jgRicb47co+aMiu7AZZgjh7FDrvjOZVD?=
 =?us-ascii?Q?YhOK2yUblGcXPDJyfaZpTZdT15oX4lCO6s0jRgksYu030FNYBorF81uwKXBl?=
 =?us-ascii?Q?kEjAmK1ju8gvHgiGJoq5LT3TUgXfQFRsPqygBUvb?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebc627a0-906e-4228-6ef5-08ddfad6958d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9621.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 19:22:49.8368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0/2sag+3jE43EIMbL9UU6MH/dKKygohv591U/inKzallhe6sHoFazaYb1vyS5tHB/iQM7TO1ZL/jD6R3nKVeaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7765

On Tue, Sep 23, 2025 at 09:15:51PM +0530, Manikanta Guntupalli wrote:
> Add an I3C master driver and maintainers fragment for the AMD I3C bus
> controller.
>
> The driver currently supports the I3C bus operating in SDR i3c mode,
> with features including Dynamic Address Assignment, private data transfers,
> and CCC transfers in both broadcast and direct modes. It also supports
> operation in I2C mode.
>
> Signed-off-by: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
> ---
> Changes for V2:
> Updated commit description.
> Added mixed mode support with clock configuration.
> Converted smaller functions into inline functions.
> Used FIELD_GET() in xi3c_get_response().
> Updated xi3c_master_rd_from_rx_fifo() to use cmd->rx_buf.
> Used parity8() for address parity calculation.
> Added guards for locks.
> Dropped num_targets and updated xi3c_master_do_daa().
> Used __free(kfree) in xi3c_master_send_bdcast_ccc_cmd().
> Dropped PM runtime support.
> Updated xi3c_master_read() and xi3c_master_write() with
> xi3c_is_resp_available() check.
> Created separate functions: xi3c_master_init() and xi3c_master_reinit().
> Used xi3c_master_init() in bus initialization and xi3c_master_reinit()
> in error paths.
> Added DAA structure to xi3c_master structure.
>
> Changes for V3:
> Resolved merge conflicts.
>
> Changes for V4:
> Updated timeout macros.
> Removed type casting for xi3c_is_resp_available() macro.
> Used ioread32() and iowrite32() instead of readl() and writel()
> to keep consistency.
> Read XI3C_RESET_OFFSET reg before udelay().
> Removed xi3c_master_free_xfer() and directly used kfree().
> Skipped checking return value of i3c_master_add_i3c_dev_locked().
> Used devm_mutex_init() instead of mutex_init().
>
> Changes for V5:
> Used GENMASK_ULL for PID mask as it's 64bit mask.
>
> Changes for V6:
> Removed typecast for xi3c_getrevisionnumber(), xi3c_wrfifolevel(),
> and xi3c_rdfifolevel().
> Replaced dynamic allocation with a static variable for pid_bcr_dcr.
> Fixed sparse warning in do_daa by typecasting the address parity value
> to u8.
> Fixed sparse warning in xi3c_master_bus_init by typecasting the pid value
> to u64 in info.pid calculation.
>
> Changes for V7:
> Updated timeout macro name.
> Updated xi3c_master_wr_to_tx_fifo() and xi3c_master_rd_from_rx_fifo()
> to use i3c_writel_fifo() and i3c_readl_fifo().
> ---
>  MAINTAINERS                         |    7 +
>  drivers/i3c/master/Kconfig          |   16 +
>  drivers/i3c/master/Makefile         |    1 +
>  drivers/i3c/master/amd-i3c-master.c | 1012 +++++++++++++++++++++++++++
>  4 files changed, 1036 insertions(+)
>  create mode 100644 drivers/i3c/master/amd-i3c-master.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8886d66bd824..fe88efb41f5b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11782,6 +11782,13 @@ L:	linux-i2c@vger.kernel.org
>  S:	Maintained
>  F:	drivers/i2c/i2c-stub.c
>
> +I3C DRIVER FOR AMD AXI I3C MASTER
> +M:	Manikanta Guntupalli <manikanta.guntupalli@amd.com>
> +R:	Michal Simek <michal.simek@amd.com>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/i3c/xlnx,axi-i3c.yaml
> +F:	drivers/i3c/master/amd-i3c-master.c
> +
>  I3C DRIVER FOR ASPEED AST2600
>  M:	Jeremy Kerr <jk@codeconstruct.com.au>
>  S:	Maintained
> diff --git a/drivers/i3c/master/Kconfig b/drivers/i3c/master/Kconfig
> index 13df2944f2ec..4b884a678893 100644
> --- a/drivers/i3c/master/Kconfig
> +++ b/drivers/i3c/master/Kconfig
> @@ -1,4 +1,20 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> +
> +config AMD_I3C_MASTER
> +	tristate "AMD I3C Master driver"
> +	depends on I3C
> +	depends on HAS_IOMEM
> +	help
> +	  Support for AMD I3C Master Controller.
> +
> +	  This driver allows communication with I3C devices using the AMD
> +	  I3C master, currently supporting Standard Data Rate (SDR) mode.
> +	  Features include Dynamic Address Assignment, private transfers,
> +	  and CCC transfers in both broadcast and direct modes.
> +
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called amd-i3c-master.
> +
>  config CDNS_I3C_MASTER
>  	tristate "Cadence I3C master driver"
>  	depends on HAS_IOMEM
> diff --git a/drivers/i3c/master/Makefile b/drivers/i3c/master/Makefile
> index aac74f3e3851..109bd48cb159 100644
> --- a/drivers/i3c/master/Makefile
> +++ b/drivers/i3c/master/Makefile
> @@ -1,4 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> +obj-$(CONFIG_AMD_I3C_MASTER)		+= amd-i3c-master.o
>  obj-$(CONFIG_CDNS_I3C_MASTER)		+= i3c-master-cdns.o
>  obj-$(CONFIG_DW_I3C_MASTER)		+= dw-i3c-master.o
>  obj-$(CONFIG_AST2600_I3C_MASTER)	+= ast2600-i3c-master.o
> diff --git a/drivers/i3c/master/amd-i3c-master.c b/drivers/i3c/master/amd-i3c-master.c
> new file mode 100644
> index 000000000000..c89f7de85635
> --- /dev/null
> +++ b/drivers/i3c/master/amd-i3c-master.c
> @@ -0,0 +1,1012 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * I3C master driver for the AMD I3C controller.
> + *
> + * Copyright (C) 2025, Advanced Micro Devices, Inc.
> + */
> +

...

> +
> +static inline int xi3c_master_common_xfer(struct xi3c_master *master,
> +					  struct xi3c_xfer *xfer)
> +{
> +	int ret, timeout;
> +
> +	guard(mutex)(&master->lock);
> +
> +	xi3c_master_enqueue_xfer(master, xfer);
> +	timeout = wait_for_completion_timeout(&xfer->comp,
> +					      XI3C_XFER_TIMEOUT_JIFFIES);

Recent patch use time_left instead of timeout.

> +	if (!timeout)
> +		ret = -ETIMEDOUT;
> +	else
> +		ret = xfer->ret;
> +
> +	if (ret)
> +		xi3c_master_dequeue_xfer(master, xfer);
> +
> +	return ret;
> +}
> +
> +static int xi3c_master_do_daa(struct i3c_master_controller *m)
> +{
> +	struct xi3c_master *master = to_xi3c_master(m);
> +	struct xi3c_cmd *daa_cmd;
> +	struct xi3c_xfer *xfer;

struct xi3c_xfer __free(kfree) *xfer;
will simple err path.

> +	u8 pid_bufs[XI3C_MAX_DEVS][8];
> +	u8 data, last_addr = 0;
> +	int addr, ret, i;
> +	u8 *pid_buf;

try keep reverise christmas tree order

> +
> +	xfer = xi3c_master_alloc_xfer(master, 1);

only 1 xfer, needn't alloc from heap. Just use stack varible should be
enough.

> +	if (!xfer) {
> +		ret = -ENOMEM;
> +		goto err_daa_mem;
> +	}
> +
> +	for (i = 0; i < XI3C_MAX_DEVS; i++) {
> +		addr = i3c_master_get_free_addr(m, last_addr + 1);
> +		if (addr < 0) {
> +			ret = -ENOSPC;
> +			goto err_daa;
> +		}
> +		master->daa.addrs[i] = (u8)addr;
> +		last_addr = (u8)addr;
> +	}
> +
> +	/* Fill ENTDAA CCC */
> +	data = I3C_CCC_ENTDAA;
> +	daa_cmd = &xfer->cmds[0];
> +	daa_cmd->addr = I3C_BROADCAST_ADDR;
> +	daa_cmd->rnw = 0;
> +	daa_cmd->tx_buf = &data;
> +	daa_cmd->tx_len = 1;
> +	daa_cmd->type = XI3C_SDR_MODE;
> +	daa_cmd->tid = XI3C_SDR_TID;
> +	daa_cmd->continued = true;
> +
> +	ret = xi3c_master_common_xfer(master, xfer);
> +	/* DAA always finishes with CE2_ERROR or NACK_RESP */
> +	if (ret && ret != I3C_ERROR_M2) {
> +		goto err_daa;
> +	} else {
> +		if (ret && ret == I3C_ERROR_M2) {
> +			ret = 0;
> +			goto err_daa;
> +		}
> +	}
> +
> +	master->daa.index = 0;
> +
> +	while (true) {
> +		struct xi3c_cmd *cmd = &xfer->cmds[0];
> +
> +		pid_buf = pid_bufs[master->daa.index];
> +		addr = (master->daa.addrs[master->daa.index] << 1) |
> +		       (u8)(!parity8(master->daa.addrs[master->daa.index]));
> +
> +		cmd->tx_buf = (u8 *)&addr;
> +		cmd->tx_len = 1;
> +		cmd->addr = I3C_BROADCAST_ADDR;
> +		cmd->rnw = 1;
> +		cmd->rx_buf = pid_buf;
> +		cmd->rx_len = XI3C_DAA_SLAVEINFO_READ_BYTECOUNT;
> +		cmd->is_daa = true;
> +		cmd->type = XI3C_SDR_MODE;
> +		cmd->tid = XI3C_SDR_TID;
> +		cmd->continued = true;
> +
> +		ret = xi3c_master_common_xfer(master, xfer);
> +
> +		/* DAA always finishes with CE2_ERROR or NACK_RESP */
> +		if (ret && ret != I3C_ERROR_M2) {
> +			goto err_daa;
> +		} else {
> +			if (ret && ret == I3C_ERROR_M2) {
> +				xi3c_master_resume(master);
> +				master->daa.index--;
> +				ret = 0;
> +				break;
> +			}
> +		}
> +	}
> +
> +	kfree(xfer);
> +
> +	for (i = 0; i < master->daa.index; i++) {
> +		i3c_master_add_i3c_dev_locked(m, master->daa.addrs[i]);
> +
> +		u64 data = FIELD_GET(XI3C_PID_MASK, get_unaligned_be64(pid_bufs[i]));
> +
> +		dev_info(master->dev, "Client %d: PID: 0x%llx\n", i, data);
> +	}
> +
> +	return 0;
> +
> +err_daa:
> +	kfree(xfer);
> +err_daa_mem:
> +	xi3c_master_reinit(master);
> +	return ret;
> +}
> +

> +static int xi3c_master_send_bdcast_ccc_cmd(struct xi3c_master *master,
> +					   struct i3c_ccc_cmd *ccc)
> +{
> +	u16 xfer_len = ccc->dests[0].payload.len + 1;
> +	struct xi3c_xfer *xfer;
> +	struct xi3c_cmd *cmd;
> +	int ret;
> +
> +	xfer = xi3c_master_alloc_xfer(master, 1);
> +	if (!xfer)
> +		return -ENOMEM;

the same here. use struct xi3c_xfer xfer should be more simple.

Frank
> +
> +	u8 *buf __free(kfree) = kmalloc(xfer_len, GFP_KERNEL);
> +	if (!buf) {
> +		kfree(xfer);
> +		return -ENOMEM;
> +	}
> +
> +	buf[0] = ccc->id;
> +	memcpy(&buf[1], ccc->dests[0].payload.data, ccc->dests[0].payload.len);
> +
> +	cmd = &xfer->cmds[0];
> +	cmd->addr = ccc->dests[0].addr;
> +	cmd->rnw = ccc->rnw;
> +	cmd->tx_buf = buf;
> +	cmd->tx_len = xfer_len;
> +	cmd->type = XI3C_SDR_MODE;
> +	cmd->tid = XI3C_SDR_TID;
> +	cmd->continued = false;
> +
> +	ret = xi3c_master_common_xfer(master, xfer);
> +	kfree(xfer);
> +
> +	return ret;
> +}
> +
...
> +static struct platform_driver xi3c_master_driver = {
> +	.probe = xi3c_master_probe,
> +	.remove = xi3c_master_remove,
> +	.driver = {
> +		.name = "axi-i3c-master",
> +		.of_match_table = xi3c_master_of_ids,
> +	},
> +};
> +module_platform_driver(xi3c_master_driver);
> +
> +MODULE_AUTHOR("Manikanta Guntupalli <manikanta.guntupalli@amd.com>");
> +MODULE_DESCRIPTION("AXI I3C master driver");
> +MODULE_LICENSE("GPL");
> --
> 2.34.1
>

