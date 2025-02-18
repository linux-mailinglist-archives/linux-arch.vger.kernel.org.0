Return-Path: <linux-arch+bounces-10174-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D0EA399F9
	for <lists+linux-arch@lfdr.de>; Tue, 18 Feb 2025 12:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2C7B1891383
	for <lists+linux-arch@lfdr.de>; Tue, 18 Feb 2025 11:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0593223BF91;
	Tue, 18 Feb 2025 11:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QTjAOU3l"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAB823AE96;
	Tue, 18 Feb 2025 11:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739877046; cv=fail; b=do9I9efk/D4R+hutlPbPCz/4l8s7BK10N3CbeOxogJe1+P/FVOKUICPDyT1qH/tI7WletcsirZLBeADFJ5a/WZjkWFIkJXxbNRIMKU0mQvWQMasd3eFWQLT6cnqWa8Gxv72w46mwyb2Ztphg9ppz38yhbNPQb7lGFEdseOm23AY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739877046; c=relaxed/simple;
	bh=3CIMMHlJgUgFrmEFyAJPzB5mfSGqdyzPfcpp2qLv3nE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rrDE072AxH1VOVXcbVbGivgKPQyAhO1otRx9nVsBCZzqfq6A4tgP5R46/dNuqq+R2ayVWaIWI+wBkh/jtDb5vYHK0FGbs4EXY3ia5zTuVOa07FbnlCOiWIRWkJTf9noRWoB5NSDHecKeKNMA5byF359/gC0XZNDek2ReLcWeTKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QTjAOU3l; arc=fail smtp.client-ip=40.107.94.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pQzy6P2TavPzZActWopZPPZ/FEnBwo3NEMnFx42/rxUPzC+JFz2hRkgkPV5kQxQ3VScrek5rgIePHe0NtEm7V0k3OCJx4bt9/2ru4ylomXa1IJ4pqLrutyVypikKAjXFeh2RsDmdpTdChj3SV5ffnnyszhOytoae+gABK62QaXfOn0AHMIduu7J8hkzfFRF9LQiYh5fAp7j/VI4TzvexSZy2mTvG2LqU4peGtwQl0SoIu2S64IAoXQJO7BrhJwjzMnXhtVZEUIO+ozULOpYHZPxZhkOPPGNFSLV60GQc536vWnTkYmF3bU+LGgWO+83F+V+ojiUeUkQ/0iWfnOMhMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4LjYr4evbsIWdByov3Icl/PWXdikuFGSHDHGhtjU6Ek=;
 b=tDb6Zk4plBHppUYi9sqUBEdlQfFKq/XeobleuKCwznuLz0ZI5+xJKcO3jfBqvpvP6tovtIwhXfi7fKWZTlPbyVaPlG4OWNgjGVTfvPHuggr3eM5d1tJWfFHGLeEDlIbv5fISBqov5ch2uSfkLqeLvkyEH7nkxBeAUwL29bFmls5ezJJOUNoF1UQA0Q2XT4ZU5PgUqqNSdFVVpKqtyrP94Kl0WF9Q3tYhqBGBkcGlIKqg48BWg4LO14YRlLOqkcb/f2A7FcZjGE0ZFAOFmtMcWZleCfD0KNMslht+3bygvuvje52gDTFLgesHVUQdOF8Z6Di/E12vKNagPaUfFbKsrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4LjYr4evbsIWdByov3Icl/PWXdikuFGSHDHGhtjU6Ek=;
 b=QTjAOU3lj5OhmyAYfud6SezF9EdkDLsdqk6jFXNBkikKkL2bVyEL+tajzKXN5cDcraOr8jvsPMNKpXJrSRnC9YB5mujAtLdMqKKH6ckcPwDw8GvV0i/s8et7BeRBwdk65ek0KYlLzccZy8FZn7cw4X4r33m0g4t7+PkKCa8yWYg=
Received: from PH7P220CA0085.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32c::26)
 by IA1PR12MB6116.namprd12.prod.outlook.com (2603:10b6:208:3e8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Tue, 18 Feb
 2025 11:10:38 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:510:32c:cafe::8a) by PH7P220CA0085.outlook.office365.com
 (2603:10b6:510:32c::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.14 via Frontend Transport; Tue,
 18 Feb 2025 11:10:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Tue, 18 Feb 2025 11:10:37 +0000
Received: from aiemdee.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 18 Feb
 2025 05:10:29 -0600
From: Alexey Kardashevskiy <aik@amd.com>
To: <x86@kernel.org>
CC: <kvm@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-arch@vger.kernel.org>, "Sean
 Christopherson" <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>,
	"Tom Lendacky" <thomas.lendacky@amd.com>, Ashish Kalra
	<ashish.kalra@amd.com>, Joerg Roedel <joro@8bytes.org>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, Bjorn Helgaas
	<bhelgaas@google.com>, Dan Williams <dan.j.williams@intel.com>, "Christoph
 Hellwig" <hch@lst.de>, Nikunj A Dadhania <nikunj@amd.com>, Michael Roth
	<michael.roth@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, Joao Martins
	<joao.m.martins@oracle.com>, Nicolin Chen <nicolinc@nvidia.com>, Lu Baolu
	<baolu.lu@linux.intel.com>, Steve Sistare <steven.sistare@oracle.com>, "Lukas
 Wunner" <lukas@wunner.de>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>, Dionna Glaze
	<dionnaglaze@google.com>, Yi Liu <yi.l.liu@intel.com>,
	<iommu@lists.linux.dev>, <linux-coco@lists.linux.dev>, Zhi Wang
	<zhiw@nvidia.com>, AXu Yilun <yilun.xu@linux.intel.com>, "Aneesh Kumar K . V"
	<aneesh.kumar@kernel.org>, Alexey Kardashevskiy <aik@amd.com>
Subject: [RFC PATCH v2 00/22] TSM: Secure VFIO, TDISP, SEV TIO
Date: Tue, 18 Feb 2025 22:09:47 +1100
Message-ID: <20250218111017.491719-1-aik@amd.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|IA1PR12MB6116:EE_
X-MS-Office365-Filtering-Correlation-Id: ec7af72f-8c2f-4855-4031-08dd500cdfc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ay7HhRuVZawlIjIhODDBtXdACYwZkP0hHqC8DCwDHz2eBMHY2NQ2Wk/yVi6J?=
 =?us-ascii?Q?Csb0PnPSVUCe08keB52k3P4T6DHOEnZb8PvsLfaurcMp8WvB2Xe+rmOkRXXm?=
 =?us-ascii?Q?B1zlM5emiS1B1uG5rgxvVP/hB2raH4n0xfc9HFCWdeqKXknNGRWqpLgcv1Bf?=
 =?us-ascii?Q?2bxyP67WsdvPNw3ScKHxJvd2ZQS1UFuJ8oxjnWwgJkhbqANXxJsUk/J7muZH?=
 =?us-ascii?Q?MbP7Lv3d28l2XTa5A0yydNxE39LIH6hxqohmMrm0kKSoBBQK2/Y1/8uPBGpA?=
 =?us-ascii?Q?/ISizYFuPm90beDanht8kBV9t9KN2TG75pxquBCEVPL0Mmmukay0Uc8M4MBh?=
 =?us-ascii?Q?JNkVCCG2Nw5oBMxS69/Z1+5OGhWP+GGIW/QYfHBoX+g2n5EXC56mLyaz8IfG?=
 =?us-ascii?Q?+ThbBiddV62KZXEp63jApcvKE2+EEKDT5GW3E31347ZyEJJGGMIHgsPfPiEK?=
 =?us-ascii?Q?9WuPD+Ntn6jBtXEgVn0J4/pEy5LGhz3vql7SPbjx1eN6lxTvgdO0sjTq4i3d?=
 =?us-ascii?Q?MLk49lb//R4NDGPtWsIq6oXGNDzZsxjf7mSdHjYe7Ll2R98cBOsg3zKccp45?=
 =?us-ascii?Q?QU+NSHvGXuNBoXdkuvOP1B1s+rQ0iUw1Nl5mht89SN1GalVsWZofELHV0gxW?=
 =?us-ascii?Q?yj91RbXRk3x1Q/xs0tJ5DMbZz/NrxLuk74PK9Y6o6/ITzbqcK4S6LMcW0JnP?=
 =?us-ascii?Q?t0mZFt84X3VcdSwC7h9NUEqoOeg2uEnVrzIM/Jj46rez9eh34+rVul90JKUv?=
 =?us-ascii?Q?LtQy6EjZRfZ7+Bor/a0gMBumYUwuLSOyrQujYETDSWn/FN9U2qfe3hN+Z8Or?=
 =?us-ascii?Q?ND/JthbF6n4AZADLmahqSQ+3UNSIoT3akmiSR0i09OnKmTMAcMyYLw53/bLl?=
 =?us-ascii?Q?ofcy/trgPNvsEYQUIkAgvr22u9RY5q/f8FEtvsYxoIoxlgyGw2kMZChrhJIo?=
 =?us-ascii?Q?UY5h1mB3oNeH6O+IJ+zaZDIoHPMLMz6tzKzRJqDcyFiu65wH7QKaN9Kk68EJ?=
 =?us-ascii?Q?HTGJ9FCdEs9jHQTe5/f+/MFypQOJkgvO9G0voA61LPKH0CRw0ii6mc1vdkaO?=
 =?us-ascii?Q?oQYNNAPUJNVSRV8uxT8mXUJ5rlc46TWgyvchTU6IlpyY+ktVajSnhlBbU9d/?=
 =?us-ascii?Q?ZdWFP7Uf6BX/3FyXY8MlFI5874VmQAIPThFSfDC/RU9KaxB8gbt4FodQPMFh?=
 =?us-ascii?Q?wCozhwgA9wmi2tRT1lxRlxqEXy8x8vwRkmYDqbFxD3c1aScJaoSHZTJczn4J?=
 =?us-ascii?Q?XMExbeAc6zn97QTTwNTEnaVFYuusb3Vp97TbmUu7xxinLEmLFOpKFl4U1YDR?=
 =?us-ascii?Q?ZE6QPsItl6w6RD8wDASvBs/vyOj3RRChd4ArFHFbs3QzSRc4dk8sTG2fAvf/?=
 =?us-ascii?Q?eF4yDuWMG6+qcVABqUNb0tAKfgzyIhrzpKKOytrzVLjUSdqEVG373cWw1cm7?=
 =?us-ascii?Q?6PSTI9M5BNfoFNhoo7hD5cA+ObLZxT+9?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 11:10:37.8769
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec7af72f-8c2f-4855-4031-08dd500cdfc4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6116

Here are some patches to enable SEV-TIO on AMD Turin. It's been a while
and got quiet and I kept fixing my tree and wondering if I am going in
the right direction.

SEV-TIO allow a guest to establish trust in a device that supports TEE
Device Interface Security Protocol (TDISP, defined in PCIe r6.0+) and
then interact with the device via private memory.

These include both guest and host support. QEMU also requires changes.
This is more to show what it takes on AMD EPYC to pass through TDISP
devices, hence "RFC".

Components affected:
KVM
IOMMUFD
CCP (AMD)
SEV-GUEST (AMD)

New components:
PCI IDE
PCI TSM
VIRT CoCo TSM
VIRT CoCo TSM-HOST
VIRT CoCo TSM-GUEST


This is based on a merge of Lukas'es CMA and 1 week old upstream + some of Dan's patches:

https://github.com/aik/linux/tree/tsm
https://github.com/aik/qemu/tree/tsm

Not using "[PATCH 03/11] coco/tsm: Introduce a class device for TEE Security Managers"
yet as may be (may be) my approach makes sense too. Tried to stick to the terminology.
I have done some changes on top of that, these are on github, not posting here as
I expect those to be addressed in that thread:
https://lore.kernel.org/linux-coco/173343739517.1074769.13134786548545925484.stgit@dwillia2-xfh.jf.intel.com/T/


SEV TIO spec:
https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/specifications/58271_0_70.pdf
Whitepaper:
https://www.amd.com/content/dam/amd/en/documents/epyc-business-docs/white-papers/sev-tio-whitepaper.pdf


Acronyms:

TEE - Trusted Execution Environments, a concept of managing trust between the host
	and devices
TSM - TEE Security Manager (TSM), an entity which ensures security on the host
PSP - AMD platform secure processor (also "ASP", "AMD-SP"), acts as TSM on AMD.
SEV TIO - the TIO protocol implemented by the PSP and used by the host
GHCB - guest/host communication block - a protocol for guest-to-host communication
	via a shared page
TDISP - TEE Device Interface Security Protocol (PCIe).


Flow:

- Boot host OS, load CCP and PCI TSM (they will load TSM-HOST too)
- PCI TSM creates sysfs nodes in "coco/tsm: Add tsm and tsm-host modules" for all TDISP-capable devices
- Enable IDE via "echo 0 > /sys/bus/pci/devices/0000:e1:00.0/tsm-dev/tdev:0000:e1:00.0/tsm_dev_connect"
- Examine certificates/measurements/status via sysfs

- run an SNP VM _without_ VFIO PCI device, wait till it is booted
- hotplug a TDISP-capable PCI function, IOMMUFD must be used (not a VFIO container)
- QEMU pins all guest memory via IOMMUFD map-from-fd ioctl()
- the VM detects a TDISP-capable device, creates sysfs nodes in "coco/tsm: Add tsm-guest module"
- the VM loads the device driver which goes as usual till enabling bus master (for convinience)
- TSM-GUEST modules listens for bus master event (hacked in "pci: Add BUS_NOTIFY_PCI_BUS_MASTER event")
- TSM-GUEST requests TDI ("trusted PCI VF") info, traps into QEMU
- QEMU binds the VF to the Coco VM in the secure fw (AMD PSP) via IOMMUFD ioctl
- QEMU reads certificates/measurements/interface report from the hosts sysfs and writes to the guest memory
- the guest receives all the data, examines it (not in this series though)
- the guest enables secure DMA and MMIO by calling GHCB which traps into QEMU
- QEMU calls IOMMUFD ioctl to enable secure DMA and MMIO
- the guest can now stop sharing memory for DMA (and expect DMA to encrypted memory to work) and
start accessing validated MMIO with Cbit set.



Assumptions

This requires hotpligging into the VM vs passing the device via the command line as
VFIO maps all guest memory as the device init step which is too soon as
SNP LAUNCH UPDATE happens later and will fail if VFIO maps private memory before that.

This requires the BME hack as MMIO and BusMaster enable bits cannot be 0 after MMIO
validation is done and there are moments in the guest OS booting process when this
appens.

SVSM could help addressing these (not implemented).

QEMU advertises TEE-IO capability to the VM. An additional x-tio flag is added to
vfio-pci.

Trying to avoid the device driver modification as much as possible at
the moment as my test devices already exist in non-TDISP form and need to work without
modification. Arguably this may not be always the case.


TODOs

Deal with PCI reset. Hot unplug+plug? Power states too.
Actually collaborate with CMA.
Other tons of things.


The previous conversation is here:
https://lore.kernel.org/r/20240823132137.336874-1-aik@amd.com


Changes:
v2:
* redid the whole thing pretty much
* RMPUPDATE API for QEMU
* switched to IOMMUFD
* mapping guest memory via IOMMUFD map-from-fd
* marking resouces as validated
* more modules
* moved tons to the userspace (QEMU), such as TDI bind and GHCB guest requests


Sean, get_maintainer.pl produced more than 100 emails for the entire
patchset, should I have posted them all anyway?

Please comment. Thanks.



Alexey Kardashevskiy (22):
  pci/doe: Define protocol types and make those public
  PCI/IDE: Fixes to make it work on AMD SNP-SEV
  PCI/IDE: Init IDs on all IDE streams beforehand
  iommu/amd: Report SEV-TIO support
  crypto: ccp: Enable SEV-TIO feature in the PSP when supported
  KVM: X86: Define tsm_get_vmid
  coco/tsm: Add tsm and tsm-host modules
  pci/tsm: Add PCI driver for TSM
  crypto/ccp: Implement SEV TIO firmware interface
  KVM: SVM: Add uAPI to change RMP for MMIO
  KVM: SEV: Add TIO VMGEXIT
  iommufd: Allow mapping from guest_memfd
  iommufd: amd-iommu: Add vdevice support
  iommufd: Add TIO calls
  KVM: X86: Handle private MMIO as shared
  coco/tsm: Add tsm-guest module
  resource: Mark encrypted MMIO resource on validation
  coco/sev-guest: Implement the guest support for SEV TIO
  RFC: pci: Add BUS_NOTIFY_PCI_BUS_MASTER event
  sev-guest: Stop changing encrypted page state for TDISP devices
  pci: Allow encrypted MMIO mapping via sysfs
  pci: Define pci_iomap_range_encrypted

 drivers/crypto/ccp/Makefile                 |   13 +
 drivers/pci/Makefile                        |    3 +
 drivers/virt/coco/Makefile                  |    2 +
 drivers/virt/coco/guest/Makefile            |    3 +
 drivers/virt/coco/host/Makefile             |    6 +
 drivers/virt/coco/sev-guest/Makefile        |    2 +-
 arch/x86/include/asm/kvm-x86-ops.h          |    1 +
 arch/x86/include/asm/kvm_host.h             |    2 +
 arch/x86/include/asm/sev.h                  |   31 +
 arch/x86/include/uapi/asm/kvm.h             |   11 +
 arch/x86/include/uapi/asm/svm.h             |    2 +
 drivers/crypto/ccp/sev-dev-tio.h            |  111 ++
 drivers/crypto/ccp/sev-dev.h                |   19 +
 drivers/iommu/amd/amd_iommu_types.h         |    3 +
 drivers/iommu/iommufd/iommufd_private.h     |    3 +
 include/asm-generic/pci_iomap.h             |    4 +
 include/linux/amd-iommu.h                   |    2 +
 include/linux/device.h                      |    4 +
 include/linux/device/bus.h                  |    3 +
 include/linux/dma-direct.h                  |    8 +
 include/linux/ioport.h                      |    2 +
 include/linux/kvm_host.h                    |    2 +
 include/linux/pci-doe.h                     |    4 +
 include/linux/pci-ide.h                     |   19 +-
 include/linux/pci.h                         |    2 +-
 include/linux/psp-sev.h                     |   61 +-
 include/linux/swiotlb.h                     |    8 +
 include/linux/tsm.h                         |  315 ++++
 include/uapi/linux/iommufd.h                |   26 +
 include/uapi/linux/kvm.h                    |   24 +
 include/uapi/linux/pci_regs.h               |    5 +-
 include/uapi/linux/psp-sev.h                |    6 +-
 include/uapi/linux/sev-guest.h              |   39 +
 arch/x86/coco/sev/core.c                    |   19 +-
 arch/x86/kvm/mmu/mmu.c                      |    6 +-
 arch/x86/kvm/svm/sev.c                      |  205 +++
 arch/x86/kvm/svm/svm.c                      |   12 +
 arch/x86/mm/ioremap.c                       |    2 +
 arch/x86/mm/mem_encrypt.c                   |    6 +
 arch/x86/virt/svm/sev.c                     |   34 +-
 drivers/crypto/ccp/sev-dev-tio.c            | 1664 ++++++++++++++++++++
 drivers/crypto/ccp/sev-dev-tsm.c            |  709 +++++++++
 drivers/crypto/ccp/sev-dev.c                |   94 +-
 drivers/iommu/amd/init.c                    |    9 +
 drivers/iommu/amd/iommu.c                   |   60 +-
 drivers/iommu/iommufd/main.c                |    6 +
 drivers/iommu/iommufd/pages.c               |   88 +-
 drivers/iommu/iommufd/viommu.c              |  112 ++
 drivers/pci/doe.c                           |    2 -
 drivers/pci/ide.c                           |  103 +-
 drivers/pci/iomap.c                         |   24 +
 drivers/pci/mmap.c                          |   11 +-
 drivers/pci/pci-sysfs.c                     |   27 +-
 drivers/pci/pci.c                           |    3 +
 drivers/pci/proc.c                          |    2 +-
 drivers/pci/tsm.c                           |  233 +++
 drivers/virt/coco/guest/tsm-guest.c         |  326 ++++
 drivers/virt/coco/host/tsm-host.c           |  551 +++++++
 drivers/virt/coco/sev-guest/sev_guest.c     |   10 +
 drivers/virt/coco/sev-guest/sev_guest_tio.c |  738 +++++++++
 drivers/virt/coco/tsm.c                     |  638 ++++++++
 kernel/resource.c                           |   48 +
 virt/kvm/kvm_main.c                         |    6 +
 Documentation/virt/coco/tsm.rst             |  132 ++
 drivers/crypto/ccp/Kconfig                  |    2 +
 drivers/pci/Kconfig                         |   15 +
 drivers/virt/coco/Kconfig                   |   14 +
 drivers/virt/coco/guest/Kconfig             |    3 +
 drivers/virt/coco/host/Kconfig              |    6 +
 drivers/virt/coco/sev-guest/Kconfig         |    1 +
 70 files changed, 6614 insertions(+), 53 deletions(-)
 create mode 100644 drivers/virt/coco/host/Makefile
 create mode 100644 drivers/crypto/ccp/sev-dev-tio.h
 create mode 100644 drivers/crypto/ccp/sev-dev-tio.c
 create mode 100644 drivers/crypto/ccp/sev-dev-tsm.c
 create mode 100644 drivers/pci/tsm.c
 create mode 100644 drivers/virt/coco/guest/tsm-guest.c
 create mode 100644 drivers/virt/coco/host/tsm-host.c
 create mode 100644 drivers/virt/coco/sev-guest/sev_guest_tio.c
 create mode 100644 drivers/virt/coco/tsm.c
 create mode 100644 Documentation/virt/coco/tsm.rst
 create mode 100644 drivers/virt/coco/host/Kconfig

-- 
2.47.1


