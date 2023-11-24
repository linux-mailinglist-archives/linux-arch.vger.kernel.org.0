Return-Path: <linux-arch+bounces-441-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F31A77F763B
	for <lists+linux-arch@lfdr.de>; Fri, 24 Nov 2023 15:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67042B212B0
	for <lists+linux-arch@lfdr.de>; Fri, 24 Nov 2023 14:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D40D2D02F;
	Fri, 24 Nov 2023 14:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NY34R66O"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C732F130;
	Fri, 24 Nov 2023 06:20:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RzjFwFjbtdrMI2bjmQtwbii3vc8w+X1/x2+Q8o/718Sv1k1TuJ1vWpEXHdeXj8aDLivF/0scMfzVJfLLEYdBaBcxNhqcym3ucvaDS1onqE9ML05GzoIhPqI/gUo7QH8mP4D2ZB2PGCSmysGN7uB/ZQClrp6eE2a2d89r/W7q7PTP3yxsB4OVguzVBOyj5nUUdwuMHHjqR4oyhIDqh8WNeK+wpwSIqDumjnpbgpd8bSdEU66tT+N4loXEQHG5soWmIPpgTD3HmwpuAQ6hNHzDzb2MXjvQbt0AOsh51EvDOSkeVttGxmcFq1yYIyo23piQjD3zKmOU4Dwfioqjhxtdzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=htV2ZQdXGzZnztDxCHBzqJeJxqpQzwMQmLUMcmpmqYo=;
 b=AOKabLvmo7z0wr+JKrULGIAoEmMsYYxsA1ADQtqEPyeV4kD4gpxR5bUx4q5xWZQd7+57D+FcwDmN2IJZnGohEiLN+/41fS7YusgWmxs1DN3ykajdWcAwqyaKDculqJxRf2TMzwWabIv2eKdYC2OmSnzUg+KoHcJXqJwfhkzYCQ6wMrl0YaAxU6KmBnH9omxUlcM07eCgR3dOVMSw216erTyfVoEz+NrqrzLALu+3QOmCMfaKbCCULbdQY5vOuFDY/U26+sRvF4kzdSrt2WSJTq68vZ2k5dFTcgnzbUalnIxiDAo4z8Kprv+WfyYzNw3C5GG8e8g151Xua3Y1CKHLiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=htV2ZQdXGzZnztDxCHBzqJeJxqpQzwMQmLUMcmpmqYo=;
 b=NY34R66OnhZaxc+HBk55vfF3eUIEhVXqwfY+55YMTTUzIVGk1heMbReth3ZrwErvsNWTNHe11FC+hlphYfDo++g3BbvnyaOOtPfTGyVkI0B+VnVpUvYT/iW/D4wcWlUEOykMEFRHp1Zy4PUsaOLQpZWGLEg/NUKc14lU66uK4HrHo7AC2xm9r93oQQMM5YKCKAY8SPyHrZVxVpR2S8EC9i8lSz3D/c35IUlKMh/iU7dEdqmtm6T+hTh4zj4lLHxN29elD0fs3g5+oZCVLLhenpqQ6Y1vrZuO4IWjNdHD3wpyQJ1j9I8DLbqD3tBRlmhHN6+t1ccBYEXZx4fCn9jytw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MW6PR12MB8952.namprd12.prod.outlook.com (2603:10b6:303:246::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.20; Fri, 24 Nov
 2023 14:20:50 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7025.020; Fri, 24 Nov 2023
 14:20:50 +0000
Date: Fri, 24 Nov 2023 10:20:49 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Leon Romanovsky <leon@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rdma@vger.kernel.org, llvm@lists.linux.dev,
	Michael Guralnik <michaelgur@mellanox.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH rdma-next 1/2] arm64/io: add memcpy_toio_64
Message-ID: <20231124142049.GF436702@nvidia.com>
References: <cover.1700766072.git.leon@kernel.org>
 <c3ae87aea7660c3d266905c19d10d8de0f9fb779.1700766072.git.leon@kernel.org>
 <c102bdef10b280f47f5fe4538eb168ac730d7644.camel@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c102bdef10b280f47f5fe4538eb168ac730d7644.camel@linux.ibm.com>
X-ClientProxiedBy: SA9PR11CA0013.namprd11.prod.outlook.com
 (2603:10b6:806:6e::18) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MW6PR12MB8952:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cc6b50e-f847-4981-b6dc-08dbecf88f4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mbcVasuz/AC+ws7VeW5ytxzkbrofzqXF51MvfjRB7ilT+SH/yZdrCcJEQ6a3j7r/QXqHdbWoy+0pm1/l1Ls41GMcAqAEes63TYAjYqrNwqJAMGNsiD8oRaja+3PQY4NIunU3DX41QBpp8STyQkNr48CaM4Q6KhrJlJ7dwLRUPaM/gvE68WTaVHOUiyEYsp7zoE67QGRkQD1pMjZrgnqXPf9xYniIRGlkSddGu4Gza+rAILjWg/RSIuW8z0bCzGRWoD0g8nYmFDjH+rDc8fRqW9ZMVfOuXNk8Xh7nfprsiEknV4iASYhT5615VCqU3DBeW09axFIA8UQrrtRf417UiQUMMsOp8Z0o8iHeQfRUTgPh/au8h+mQNb5rwgnjwyYaxCm3E0NzLfaVOJit0qZv5lWOxBPcmbdQ9EG2zX2mBqX7rpQhvCmwhenB99EL+bymYJGFEI2aGBWsELoj644GFDKF9OhOiAPDK9TjSautZjbvsWX8HPaeZoUHUv9q/28mDgnEn3WYk/KrI4YSI4rGxhrQN/FukvZueJlagmYJxca9FV7FviI82Lg99dhNfWIR7B9iFIrIleqCtxXnT6kwaQ4HK3OIaWpIjF9rTBVT3Ps=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(346002)(366004)(39860400002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(2616005)(6512007)(1076003)(26005)(316002)(478600001)(6916009)(7416002)(6506007)(5660300002)(2906002)(4744005)(6486002)(66946007)(41300700001)(66556008)(66476007)(8936002)(4326008)(8676002)(54906003)(83380400001)(38100700002)(36756003)(33656002)(86362001)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CNd/nGMfIEGCROprDa4MZwawCTzu5p9S2NiomAm7vH+sEXiCM1FOGeaLXqsI?=
 =?us-ascii?Q?36yc65zPmGzdi5UvcNvE+3kpeBqCdqGzZunxH+1HKchGsPlikpzuX75jBujf?=
 =?us-ascii?Q?+o3aXUVrXC6CElKdpq+3DCa4opo4rEabUXlV1BhafNliENNP94GwSFR5FHgc?=
 =?us-ascii?Q?yv/M2Lsus+L0+usbwe6IlGMCb2FUp1V2uD1IhF/vW/nHsfmBPFbSQs7oQiJe?=
 =?us-ascii?Q?uN4umUVrgwa4LIimp9mtESnJhqoOtk0hwKFQnn7XRrKX+KPVaGGu2AXMI4xE?=
 =?us-ascii?Q?ac/bBXvBzHztsIZgC0vGnJTPr42FKQ5D1FlEDRqPQ/ahasDiImUyPPMZL0uk?=
 =?us-ascii?Q?X7lBgJrHxfemKAhs49/R/db3BBTmu9okrDT7mZ7cLsh7GvUfklEw+72HSeXb?=
 =?us-ascii?Q?MU5yo1SuYLl1CglZdcLhv9L8d+blG5M60mD7MkaDQISVqnZc4t/0GuWi//MX?=
 =?us-ascii?Q?mXbFGrVcEP4hu0NCGao57Qgd5r+F7nQHKMFexr3tk/F7kraA/1nCLKxulDlt?=
 =?us-ascii?Q?wdskAnVaPKc5ykWjgNV+m1L22OODjbIuKBE6fnj4YcAEwXWE/IwA5jQUCo4H?=
 =?us-ascii?Q?P/wEozqh64XaWPvqQbEMtSUPCMZdKvTJGmWJymCcw5Ig7ki/ig6hDesGwWra?=
 =?us-ascii?Q?W5QZMXfJjeHb/WLI4AJWaUYmXYv3AApjIMuQtY8YJYj+dBqw32roD9iaJzzM?=
 =?us-ascii?Q?y4n7mk/3DCVjxlc1OHs1qcgE/HA5+NwuuULtL+cguzjO8hToewmt9fMdrWaA?=
 =?us-ascii?Q?WvkW65hlmoko3fYEyxe8LwYs5OA/SM7MjUcz0f+W1FnqgNvAj9V5Rx4IiVmK?=
 =?us-ascii?Q?G3kA4aQ9vygYTT5We2MyymFU7GVrt39FDfz5u7xDzGV5iWPcsko0PKO2cmhO?=
 =?us-ascii?Q?aLFRP2gvwCwqd0xTiuqllal0VMuPnuFB9rtsz7OdyJsY4kC3S1g5bMbEklZ9?=
 =?us-ascii?Q?clIUVMcnmZIlKDY6uHOkrvf7YGHDtkcfkuKSzMVbS/wnJ82orOJAY6JnlOgL?=
 =?us-ascii?Q?wzkOq89fu5nYE/6l6BFDMUod+mNZtQE2e4ulgY/ZlXlDxZsEiOL4zb5fd6Ub?=
 =?us-ascii?Q?htIClpqz1WPdTaXgHx1GAO2I2ziQAicGt22p4s4DChCJ5XZSvWyhKRsi88fn?=
 =?us-ascii?Q?z9HW7rTMVy5EQYbCvBr2A0sp6taHtoyb0uPjDHr9VBrAUK1SSPJLTjWIZIKZ?=
 =?us-ascii?Q?zmnrhp4vP0FO+kaJ4G2xeD+yNg9lNX33pzeZmUKMiVnFdEzlHIeVG55HmTPH?=
 =?us-ascii?Q?zc4JGk4Cv+Wc+ljGx5eqqhqJ8tWdlEG6sIOxXkw5psnic5mQMguQZA7YTKRM?=
 =?us-ascii?Q?2tB/QXZqkNs+snNRTktxEAOAeGflyCzS8ZQeAXQ0IdYM3AIc7RsFjhGd/r4r?=
 =?us-ascii?Q?VaomY1ffDkM2CTw1ZfJSxTeojFiLjOmX5wkeUy9bP9dw+iQ++GoIOlnN5Uf7?=
 =?us-ascii?Q?zWqfMdFMA8FLR8xkwlkSSkNqljhHCTawDwFghhe5G8sy7HGucXE0NrM1iQSr?=
 =?us-ascii?Q?MU1mC/tLeOiFDlEqDHuBKExvLQB6ZUgcCKE2dZXqAI4v9nogDjE03e0wh1a1?=
 =?us-ascii?Q?B/rXR2HZ8rhZvjJvZ29UCK89rpFYzOxKWAXg/LF2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cc6b50e-f847-4981-b6dc-08dbecf88f4e
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2023 14:20:50.4596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LLJ2P9sle+jCUNnPLC5Wm+inAxkdMWLxDqELlbKvUtSW5YaRBgxycaEpcKYevusl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8952

On Fri, Nov 24, 2023 at 03:10:29PM +0100, Niklas Schnelle wrote:
 
> What's the reasoning behind not using the existing memcpy_toio()
> here?

Going forward CPUs are implementing an instruction to do a 64 byte
aligned store, this is a wrapper for exactly that operation.

memcpy_toio() is much more general, it allows unaligned buffers and
non-multiples of 64. Adapting the general version to generate the
optimized version in the cases it can is complex and has a codegen
penalty..

> For s390 the above generic variant would do 8 of our special PCI store
> instructions while memcpy_toio() is defined to zpci_memcpy_toio() which
> can do the same as a single PCI store block instruction. Now of course
> we could provide our own memcpy_toio_64() but that would end up the
> same as just doing memcpy_toio(addr, buffer, 64) here.

This is probably better?

Jason

