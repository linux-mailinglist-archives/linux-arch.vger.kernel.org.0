Return-Path: <linux-arch+bounces-13787-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59CF1BA3695
	for <lists+linux-arch@lfdr.de>; Fri, 26 Sep 2025 12:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5ABB3BD33F
	for <lists+linux-arch@lfdr.de>; Fri, 26 Sep 2025 10:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5332F4A08;
	Fri, 26 Sep 2025 10:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="twSWmNHt"
X-Original-To: linux-arch@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012050.outbound.protection.outlook.com [40.107.209.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3722F49EC;
	Fri, 26 Sep 2025 10:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758884128; cv=fail; b=XAtrym/JZTJVKtjS3WPiyZhEpPRqhCtWcAYWGwh2EXxrG/J0bQ2myAIjU9+SFvUElGEG3r3yjri+sntKi6qZNJtjq58K7VTtxSkLU2pPkgaxjW8kCQfr8Ne1hA9ex5P5rH/sNCGpFsZZNccSeoW630TENfKqybvUttvZbdjr2lc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758884128; c=relaxed/simple;
	bh=GMDbUd3At1I/ik97cZY9Pl/OsbN5l3vTSz+22dWblyk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kaCh7ad/u90z7TjwkwjNI+BiUJNTYwl/Bv6DJTn0tUdHCaQWRZKNk8QLASpM9f0K54Thxl9+17QTPU4WR2G4gAFtcf02Cm7YxTQ/hNFCRhFnc1zY5Yz9mV0DAmNMjFDdCjToVIa4afltoBtqN9OeNxqae90XAOFWooH8PiMlBOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=twSWmNHt; arc=fail smtp.client-ip=40.107.209.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zTQQF1oUQv6ZXgs0CMRR2dNqKOz/ak6mR7L0gFAH1dZcHvVHBsJJgcQFNjBsOY4k2pLjUMhZaPfv/LpYtepE+abbokdLWF2G7cX6sI+QkggkbhyD0lu2dhCCzPSHUqndNR1o4kHNd58ie0W8Zrgw0QkmoAyMxNJvDoa2Laye5WdxEywZE0EVTktdjh4+Zn9RVw/pGze6ZK1WxbGTBBn77W++r+2BO8ck2BqKX+HNAadY97az4ukOy/wDCkVmxIGP/igCt/fESifMnxetrBI5LA6mFjXtFuRyjfj9bjCr1LYYIRy+eNzLfLkOOtMfDaoefQXbvWyBdYgySmwSweortA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zB/JLEY7FhV/HzUVezktFI5uFReN2t55b3G0YKOavaA=;
 b=Jl/65xQK8N3aa9G+3hoPbTihQFkWC87xL8v63tcTps+OZHoDCNTNe7TPAZSEW9/bcY0llElVk67C8kZ2uKY4i3fgIhfrEZTFD6KsoppcY3cArPBHqg9ASL7pjqPc4fx/zrYJfejZFcNafsjf3WeQSSqHRMNEAcEyk2gWe1JjYagoqEKaR3J2u9gZ/e6NXLAJmGvaeBBmxIJAUMGxH8AEDM5ZxdUeb8f7oTa6mmL68iJfK+252FvvT+/5pC3J1dWFrQ9C6Wb4To5HUJEgWMEaWmS8lyTIVitOVVAO5UTb9i3mEQK1bpzw8VmRgYTDfBZ9ch+fhGFt+qyTU72xl8bplg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zB/JLEY7FhV/HzUVezktFI5uFReN2t55b3G0YKOavaA=;
 b=twSWmNHtFIcWf5k9/9O1MXRXinHYDtujWRXYTKoViABcl5jJfnKZ1xIm1I9vrD68/h1x//eE3QiYdU+1jG6twKcqLfFmo9f7IsruskOHHfl3D8lznirDg3rgOnDXluLVamO58OCRagGJVInTVvWXLy/PP+t/IKoeGSf5EyYa1XM=
Received: from BLAPR03CA0005.namprd03.prod.outlook.com (2603:10b6:208:32b::10)
 by CYXPR12MB9442.namprd12.prod.outlook.com (2603:10b6:930:e3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Fri, 26 Sep
 2025 10:54:01 +0000
Received: from BL02EPF0002992C.namprd02.prod.outlook.com
 (2603:10b6:208:32b:cafe::4) by BLAPR03CA0005.outlook.office365.com
 (2603:10b6:208:32b::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.21 via Frontend Transport; Fri,
 26 Sep 2025 10:54:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL02EPF0002992C.mail.protection.outlook.com (10.167.249.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Fri, 26 Sep 2025 10:54:00 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 26 Sep
 2025 03:54:00 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 26 Sep
 2025 05:53:59 -0500
Received: from xhdradheys41.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 26 Sep 2025 03:53:52 -0700
From: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
To: <git@amd.com>, <michal.simek@amd.com>, <alexandre.belloni@bootlin.com>,
	<Frank.Li@nxp.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <pgaj@cadence.com>,
	<wsa+renesas@sang-engineering.com>, <tommaso.merciai.xr@bp.renesas.com>,
	<arnd@arndb.de>, <quic_msavaliy@quicinc.com>, <Shyam-sundar.S-k@amd.com>,
	<sakari.ailus@linux.intel.com>, <billy_tsai@aspeedtech.com>,
	<kees@kernel.org>, <gustavoars@kernel.org>, <jarkko.nikula@linux.intel.com>,
	<jorge.marques@analog.com>, <linux-i3c@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arch@vger.kernel.org>, <linux-hardening@vger.kernel.org>
CC: <radhey.shyam.pandey@amd.com>, <srinivas.goud@amd.com>,
	<shubhrajyoti.datta@amd.com>, <manion05gk@gmail.com>, Manikanta Guntupalli
	<manikanta.guntupalli@amd.com>
Subject: [PATCH V8 0/5] Add AMD I3C master controller driver and bindings
Date: Fri, 26 Sep 2025 16:23:44 +0530
Message-ID: <20250926105349.2932952-1-manikanta.guntupalli@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992C:EE_|CYXPR12MB9442:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e0fe7c8-f94f-4087-4ad5-08ddfceb0026
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LUUtWI1M+a3ASycHtIyDeEUaYn0mI09/1+8YEOymTMwTopi1cmaXByx8OXCH?=
 =?us-ascii?Q?mbb93CNDIUhpoZaJEHQOry05xC5ZZFM0QH25InVvPRn0+ypN4Y2ApJ/XQNk9?=
 =?us-ascii?Q?7jqQXbUkZXVJDK4j3172GyHgNOwXugstL3Mo7l7emiZ9zfPzOrsus2+BYTj0?=
 =?us-ascii?Q?/5cUsXJIqv5ZT4j7pXeDKqUK5hVbo+rfIIEgke+KzpLceCk7Nee8qUAxQe/P?=
 =?us-ascii?Q?ZemVTXBLXRKI5vyHYrfEix89JCrWgjHkwnp/5ABaPThfRHbdpIoN8xyQPWVe?=
 =?us-ascii?Q?xGUBdZO4zzkFBjgpcM68F7bYGa9uidQUGyZGYi1DVEXeP5nc7elhX7T56SF5?=
 =?us-ascii?Q?hFAxKmRFHzKNlKG6LJpGQL3/RAP0OqYVHT6QSVwsknGflOHmi7C2faTaGwP2?=
 =?us-ascii?Q?rR/2Bv9OMjL7iONgmKKxoFy4C9C++9EFQB8WbC6mNYiLo3RqXHL3A9vNOK6u?=
 =?us-ascii?Q?++7zbUJ/01LLq7qpMD4V7yUWTpbxYvQu6NmVqDFheqt+QlqTM9xtFBvJrgXY?=
 =?us-ascii?Q?zOy4IWT86GoNElgVB7skH4ZjD6VyTVKWrXBretEZteH1SiOYMNNpa6PnSLlC?=
 =?us-ascii?Q?4rKrzNsF4LoFj2abZ9qT1MtkQZxH5QyMkBA86OGTMtl6Bvd/SnKCtZVNQGc9?=
 =?us-ascii?Q?Y3WhpqEO/C/vkV9inHSLi22M3B/OjxTsTTgwLiCIzes/T/53cJFcPPyUrl75?=
 =?us-ascii?Q?3Ie0MIw3eCJEIRac8Zm3tL0GNSrGwSlh3zj03+Z7wMb+RGjU5ZujzNnT7IZ9?=
 =?us-ascii?Q?SUty1EA/WCQRxI7AeT5hXmODo9l9yFAZE1XJN+/mYAj/WSNSv5AeAgL8jQOC?=
 =?us-ascii?Q?5cGNKX6x/wAYTWeaigSVF3y8cwDV3h8t112T0A9rhyjsAiigjZlqgk/M9M7Z?=
 =?us-ascii?Q?ARpAsmNqg25xh70A/tuIYgZfpiGhLVrDicVhdX8c037jzUFMibgWhUMhXVos?=
 =?us-ascii?Q?nbqQ7iz/AN4kdASUY3YM9hOuycTSIWbgFnKmizPZl40GUqPcu4i7r32rpiX7?=
 =?us-ascii?Q?e8EXYDputAaDpLGS5yTVp1J7gfSNKLa3VjkifFJmRVNStxWDF/VwbxuIHicH?=
 =?us-ascii?Q?hpLFW/XfaiXP2lO5FYwz4FuwJwAfsIbCmgzz3GIrROB5VyGbrjJwWYvJEanF?=
 =?us-ascii?Q?bMlGTYkPJlFnzGZZ9dFhGI3+yJLoF5TL9HY2JRAVPZpxYboNPe5n9tNtZ+KS?=
 =?us-ascii?Q?7mqrJjy1+OPtTySnScFePfphUOwp1XpJfWz4kUANxEjPqPtIZIcXbGal4DZU?=
 =?us-ascii?Q?JiCPOZSUiedDC5iELmrLb5SaeHFC6QhkPI8MKugdeHg1/mX6LyuUwl5w5+2H?=
 =?us-ascii?Q?fHDycx0LJfv4Cc5aq4rqNRCjoA6tcdbezWrrs3oB4GsEy5cYHkeIWJZR89tw?=
 =?us-ascii?Q?WCkwHCr+hC64JON8op+uy53kikEFa/kpIPKL+ohmDM5hNaYV0pZKHwBj+Od/?=
 =?us-ascii?Q?vu0IYlKubgaeOA9cKItZ8Yvefz+GZwe8smdHXKcwUwEREn7YQRTNJfYnrBlD?=
 =?us-ascii?Q?T1/EhbGnQN6ZSD9wRYSb5Jhbmr/zGDDca712tH00/FCZW63W/8qitCLCinPN?=
 =?us-ascii?Q?mQBGsL4IjlHXMKPw2bblNasEuEwQyyiZwHti9lPJ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 10:54:00.6078
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e0fe7c8-f94f-4087-4ad5-08ddfceb0026
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9442

This patch series introduces support for the AMD I3C master controller,
including the device tree binding and driver implementation.

In addition, the series adds big-endian MMIO accessors and extends
i3c_readl_fifo() and i3c_writel_fifo() helpers with endianness support.
---
Changes for V2:
Updated commit subject and description.
Moved allOf to after required.
Removed xlnx,num-targets property.
Added mixed mode support with clock configuration.
Converted smaller functions into inline functions.
Used FIELD_GET() in xi3c_get_response().
Updated xi3c_master_rd_from_rx_fifo() to use cmd->rx_buf.
Used parity8() for address parity calculation.
Added guards for locks.
Dropped num_targets and updated xi3c_master_do_daa().
Used __free(kfree) in xi3c_master_send_bdcast_ccc_cmd().
Dropped PM runtime support.
Updated xi3c_master_read() and xi3c_master_write() with
xi3c_is_resp_available() check.
Created separate functions: xi3c_master_init() and xi3c_master_reinit().
Used xi3c_master_init() in bus initialization and xi3c_master_reinit()
in error paths.
Added DAA structure to xi3c_master structure.

Changes for V3:
Updated commit description.
Corrected the order of properties and removed resets property.
Added compatible to required list.
Added interrupts to example.
Resolved merge conflicts.

Changes for V4:
Added h/w documentation details.
Updated timeout macros.
Removed type casting for xi3c_is_resp_available() macro.
Used ioread32() and iowrite32() instead of readl() and writel()
to keep consistency.
Read XI3C_RESET_OFFSET reg before udelay().
Removed xi3c_master_free_xfer() and directly used kfree().
Skipped checking return value of i3c_master_add_i3c_dev_locked().
Used devm_mutex_init() instead of mutex_init().

Changes for V5:
Renamed the xlnx,axi-i3c.yaml file into xlnx,axi-i3c-1.0.yaml.
Used GENMASK_ULL for PID mask as it's 64bit mask.

Changes for V6:
Corrected the $id in the YAML file to match the filename and fix
the dtschema warning.
Removed typecast for xi3c_getrevisionnumber(), xi3c_wrfifolevel(),
and xi3c_rdfifolevel().
Replaced dynamic allocation with a static variable for pid_bcr_dcr.
Fixed sparse warning in do_daa by typecasting the address parity value
to u8.
Fixed sparse warning in xi3c_master_bus_init by typecasting the pid value
to u64 in info.pid calculation.

Changes for V7:
Added i3c controller version details to commit description.
Added Reviewed-by tag to binding patch [1/4].
Added big-endian MMIO accessors [2/4].
Added endianness support for i3c_readl_fifo() and i3c_writel_fifo() [3/4].
Updated timeout macro name.
Updated xi3c_master_wr_to_tx_fifo() and xi3c_master_rd_from_rx_fifo()
to use i3c_writel_fifo() and i3c_readl_fifo().

Changes for V8:
Included dependent patch "i3c: fix big-endian FIFO transfers"
to this series as [3/5].
Resolved conflicts with "i3c: fix big-endian FIFO transfers".
Updated description.
Used time_left instead of timeout.
Used __free(kfree) for xfer to simplify err path in multiple places.

Arnd Bergmann (1):
  i3c: fix big-endian FIFO transfers

Manikanta Guntupalli (4):
  dt-bindings: i3c: Add AMD I3C master controller support
  asm-generic/io.h: Add big-endian MMIO accessors
  i3c: master: Add endianness support for i3c_readl_fifo() and
    i3c_writel_fifo()
  i3c: master: Add AMD I3C bus controller driver

 .../bindings/i3c/xlnx,axi-i3c-1.0.yaml        |   55 +
 MAINTAINERS                                   |    7 +
 drivers/i3c/internals.h                       |   45 +-
 drivers/i3c/master/Kconfig                    |   16 +
 drivers/i3c/master/Makefile                   |    1 +
 drivers/i3c/master/amd-i3c-master.c           | 1002 +++++++++++++++++
 drivers/i3c/master/dw-i3c-master.c            |    9 +-
 drivers/i3c/master/i3c-master-cdns.c          |    9 +-
 drivers/i3c/master/renesas-i3c.c              |   12 +-
 include/asm-generic/io.h                      |  202 ++++
 10 files changed, 1342 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/i3c/xlnx,axi-i3c-1.0.yaml
 create mode 100644 drivers/i3c/master/amd-i3c-master.c

-- 
2.34.1


