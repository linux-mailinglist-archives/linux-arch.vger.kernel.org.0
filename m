Return-Path: <linux-arch+bounces-13728-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3864B96A41
	for <lists+linux-arch@lfdr.de>; Tue, 23 Sep 2025 17:47:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD0C42A6591
	for <lists+linux-arch@lfdr.de>; Tue, 23 Sep 2025 15:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5698264A92;
	Tue, 23 Sep 2025 15:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="E/NlfF08"
X-Original-To: linux-arch@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012049.outbound.protection.outlook.com [40.107.200.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8C074040;
	Tue, 23 Sep 2025 15:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758642406; cv=fail; b=L9dppjuaq6EAc5jrWB960TW2Ti9xEerWgGTfl/a7Z2JEr9Guv+RqBBuiOGUrcYFmNx/hS+3TnrF65Iyw9//NoF7QDTsyr3ALrryccjP5+3q7c2UeaRz4LLfcpHkxYSWZ+0J2wl/3xE7+0BPF4OU4NU4zDirdyeK1EgF3WYxloIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758642406; c=relaxed/simple;
	bh=M+Vdu5qRCNIfgxnCnt53qAW6/CgVYeZvAj7fsYN7UWM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kKBePyUJFI4m9xCrd0HtcznIdjKkPs6o33EoSVEbGhCln5I//UjUbMcVam53Xfg5qvL2MS14Y9N5AO5vnY9JEmAu2c9/7V0oRDf5RqRWQ6n2t3ZaKPDJOpelUNkPaCKO50fQdFv7hLhwXd8xFqCdT9BuD9L2TtSzvEUXMRFOehU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=E/NlfF08; arc=fail smtp.client-ip=40.107.200.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rmziKuwrT785pEUxgETWRyeUtCOmv3hRGQwm64PHy4W3p1ZxjKh7hFSPyB1ublkHDMDlp7UPaZFJvjw8C9mj8s4t2tOEURaYmyQj8XWuCacsnzELRtoqbYc1Zu2MH3s2vcaCUO6lAoJg4XNqhL+ezxoZR+Oqg8Ojm78odb6N8TaNJimR3J0lrJxxST1d2w4mwknqPfZti51G+u/u/QHuprKA/Gq9F1UMUksoFoW/8UBzUUYmE1GUu4sUANvErGp+rYGhH3fwHW+jy27/4C9x304wx8ZQ+m3nJLtGCSNvL1RKxkzI63Erzy8PZtfC5COgIjrnJw3tYzBjtfIxvtJ7zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+IYuFnucLeNyRenJlC/cdhZDUwDTBN+JrJJSqkK6xNA=;
 b=DB9hqRUxHOIEkAfOxoMiYpuRO7AlVniep2bGhX1z95jW3S5OHRV+L8Xcnc7acgoketVt7A0KEQvt1x7Bg3lK30+USO7+scSOC5sFe8uUYM7mOfl+R9I1vPcToe5glQWZ3pYgsXKksEDOv25hscz8aPQStM/uKDZHHdLdij5lXM4utjYGLHNxl0VmwE1PNMsJy9GlVfkYlLDb4QOSLZ94b0FuXwQs7bRQqxONrk6tJyb2pWNDirFfeyjlPFjZi6ucTog8GoI2reg1emTGWpFOrQ/aupL8ICRZVYPAt8wGgRBM0BI9RzxGPLzyphB9TXpQ//IbRtNSBUrY68GodzToww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+IYuFnucLeNyRenJlC/cdhZDUwDTBN+JrJJSqkK6xNA=;
 b=E/NlfF08RBFI+6qVVMaFEEjik7L2jpkYoUu2s5rWZvQvxjGwXqH+kXk085gWHyIHpr77+WDQdshNahPvGobmJHTCgoxhWZcSRjQxWB7pq9f7tXbRVhJFkAYVQe7c1jfZMtRUhbDv9uk/aZhSatvu5GjbxSuP7liEmZewxgcGgrM=
Received: from PH8P223CA0009.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:2db::6)
 by IA1PR12MB6577.namprd12.prod.outlook.com (2603:10b6:208:3a3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Tue, 23 Sep
 2025 15:46:38 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:510:2db:cafe::eb) by PH8P223CA0009.outlook.office365.com
 (2603:10b6:510:2db::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Tue,
 23 Sep 2025 15:46:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 23 Sep 2025 15:46:37 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 23 Sep
 2025 08:46:08 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 23 Sep
 2025 10:46:07 -0500
Received: from xhdradheys41.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 23 Sep 2025 08:46:00 -0700
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
Subject: [PATCH V7 0/4] Add AMD I3C master controller driver and bindings
Date: Tue, 23 Sep 2025 21:15:47 +0530
Message-ID: <20250923154551.2112388-1-manikanta.guntupalli@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: manikanta.guntupalli@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|IA1PR12MB6577:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ec3e2a9-70fa-4d44-f740-08ddfab861bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?v4HImPRff108U6JhZUajNBF3I06bGS75OwCWmMNRovFUclQ06CZrX1xy8qH0?=
 =?us-ascii?Q?075j3vCu8SaR3KwvBoZ48uKxN26vNUIxKNIPBmINra/7yJ/+ulPiWzvG/UED?=
 =?us-ascii?Q?TVyDaTQxrzUP6iXG1rgbCqxIqET7OV3kzR2dtE4Ln+dXwIpeXi74QWLtS1ZB?=
 =?us-ascii?Q?Usm+JpOUrmpQlUkKnETdKiDvngpMsNpeitdbgcYmo6jXwgBqBcCldwvY9oSE?=
 =?us-ascii?Q?h/oIvmoKDASeDFk+ArjejbD0odmutjxmoMzy+GnNvoVcOsxmtbYRiTtxNjjd?=
 =?us-ascii?Q?v9rf4Cgsi8SUpzVSjT/EyWuJAjVhQ2PpJDjsQsX4GpAd5Cd/7SXJe4CaZqZ1?=
 =?us-ascii?Q?YfPbGygKqn1tXhrnxKivWnF3d5J+EppJnoR0kc8/kgF9mTaPhRp7iSEkES+L?=
 =?us-ascii?Q?Y7lYxuwfcby9ruzYyXgdLyCAwZT5Ps2QkNZmtPdc9RBo128eOkfThPaEuzSN?=
 =?us-ascii?Q?2SktJIOaSyvgDCwZ2qA9JHVGFss5l9YWtbiXLkPAmtZ08cWo8AwjVdqSyoiF?=
 =?us-ascii?Q?w7N+Eg8Du2juJO6vmxky2VizcpDkXuf/eK5El3UgbMaammMa3FkvUkUaSYPN?=
 =?us-ascii?Q?elaopW+IXaM2t4MrqJeqjJiy+XS6AAzN6E5P5rioYa69NRLUDznGMoVE4aZ9?=
 =?us-ascii?Q?8qAOns/PRCraeuo8Bh9ULDmqPL/4mYfKxLYA1wgkLDCQrUZmJqwhC6ME4vob?=
 =?us-ascii?Q?FIymrgQQauIQKVNqE83I+0J534e2RXfb9waFjBjpmfBCVoDn3FQzQH8t4Alp?=
 =?us-ascii?Q?+q0H7Cj8aksDm4C0KCuQTdsVZsHXjk8voCC11QrqqxZXq8wxeCN96o734/uW?=
 =?us-ascii?Q?Ie3b52I9lpeVDufmxn1obG5Y6NhzVO+2CJCWuILJfUeO9ldDc+IMtXf0su3e?=
 =?us-ascii?Q?00rT5QpDeTSXi+QNnCt0Rhw9UvD1EUcBI7CY1w0irUtPqK2kW224zSOIcFRG?=
 =?us-ascii?Q?+xisclAh3tp14s4XbDc3i/I4FREHGltvtjApxCWlcxgKz91nyrk4tFiC5wqg?=
 =?us-ascii?Q?Qc6i7UZTLlgKm8tSLnElG2N6paHCrWqdcDhWH934pD/pxpoejHVSdaQtpxcZ?=
 =?us-ascii?Q?QLmNHc9gIB1AOB8CZh4aZGw8yMwHpAhpdQiZ9ODV7tbu9I9HJno+AgDSLwZw?=
 =?us-ascii?Q?qlwgK6szNDM8HX4014b9z8ek+tqlK8qFvDabu7NQqYTwXVvk3dSLSvsVNm1A?=
 =?us-ascii?Q?lSAGZz6mYmaARUHz9C2qbkamCFZXV8i058hvUpKlKOZwBtdhImzj/REMPVYN?=
 =?us-ascii?Q?Q8OJZof8VAaRoIHZ+4UMzPw/pEzvhNsOXW9iP3ICbZgqFH+i5G254eBbj+g0?=
 =?us-ascii?Q?bW75UAVF24FXz9D319V88nwdwT1qF1qg4Fxu1Q7E7ywnm+KTSTUEpuIQ6WiT?=
 =?us-ascii?Q?a/k4+4g4LRUFVTeXXWq3PFP0qQEjUxSIGhyKdHF3TSIUN1MXDyKRL5WEnh1A?=
 =?us-ascii?Q?WJ+Lp6eU+V0mQAZuffX1gTjCnM10HlCnPPYybZoeaaTSqA15/0TemzkShV+E?=
 =?us-ascii?Q?USyOOjG/o7M+uijUUsnRRrEoq+R6vl92HbJ3tPma4qy5A1ZghPGnvj4y9g?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 15:46:37.6381
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ec3e2a9-70fa-4d44-f740-08ddfab861bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6577

This patch series introduces support for the AMD I3C master controller,
including the device tree binding and driver implementation.

In addition, the series adds big-endian MMIO accessors and extends
i3c_readl_fifo() and i3c_writel_fifo() helpers with endianness support.

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

Manikanta Guntupalli (4):
  dt-bindings: i3c: Add AMD I3C master controller support
  asm-generic/io.h: Add big-endian MMIO accessors
  i3c: master: Add endianness support for i3c_readl_fifo() and
    i3c_writel_fifo()
  i3c: master: Add AMD I3C bus controller driver

 .../bindings/i3c/xlnx,axi-i3c-1.0.yaml        |   55 +
 MAINTAINERS                                   |    7 +
 drivers/i3c/internals.h                       |   35 +-
 drivers/i3c/master/Kconfig                    |   16 +
 drivers/i3c/master/Makefile                   |    1 +
 drivers/i3c/master/amd-i3c-master.c           | 1012 +++++++++++++++++
 drivers/i3c/master/dw-i3c-master.c            |    9 +-
 drivers/i3c/master/i3c-master-cdns.c          |    9 +-
 drivers/i3c/master/renesas-i3c.c              |   12 +-
 include/asm-generic/io.h                      |  202 ++++
 10 files changed, 1342 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/i3c/xlnx,axi-i3c-1.0.yaml
 create mode 100644 drivers/i3c/master/amd-i3c-master.c

-- 
2.34.1


