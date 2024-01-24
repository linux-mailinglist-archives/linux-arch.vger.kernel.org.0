Return-Path: <linux-arch+bounces-1513-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A562B83AA9D
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jan 2024 14:06:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55076291456
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jan 2024 13:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACDCA77652;
	Wed, 24 Jan 2024 13:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="C8A4JfHX"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAC477640;
	Wed, 24 Jan 2024 13:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706101604; cv=fail; b=Ba0Pac6rCSa99duOEFx8+VSGc3aNR8/svkl36Xso8QNs9RLePpokr1N0iTnGrUqoEMpGMPqshUxTU0VlDrjCe6cYYfEraVfDmztGN2F0YwKa28b1mXPFZN/KHhvh0r+jzw9Ef4l/+Nr5MF8EI/xUKNm2htkjoN9gAk9WRdBvgYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706101604; c=relaxed/simple;
	bh=sImGehbbnYVlky3oXITGF40qKaTrKWOq0ilDGlWqZNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TijtQM9jCXtr1pt45dAsiwyePkbPI4WTKdWDkWoXTKRh/ACEKhzomkEkGFdLXvT9oG6HDVstapXrBG/RrggmaoVMK5WMP9uKi7bCtZizyvFOzvbBq9ZGz2KM/ANL026Tn5ylj7uSfZggtgCTSpbSNclHM2fhGhwWGykHXVtCIn0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=C8A4JfHX; arc=fail smtp.client-ip=40.107.220.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TaAmKtQ48WjbICJ3JmMCOzg+Cn7Q84hdJfNn8UxJ1S9yiikompcgS+JUefJzYshiOFo3gEJM4J5yPzkxXbff/fSpU3jS4pQsr6kQqjNCkNWREVzMnRzCjtTCR73g811tRiFKT7EUhFUpx6UCMe/5W+sz5GKVaqqrM0VwrVz68Qv4s8gtFnjlu/sbin3TeRkTNHcE3WWKP176FjwQmMTIMvGirtv7RAzXATccVqn7KXCn3cbBPVd7Tfj5TXigj1DiTbtfgPFRtWyblRVjJyjT8cBPVy06Fis4uSp/+Q7Ge/nhOXH9wKc21vhYXLdw19X3zoGmn0DWsXJJDLJbbRlPbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jr2zl19Q7U4rayc0dxN5f+b6lVeBTqlyNkjxf8+SaGU=;
 b=CuKb3/t+9OxP0uFuaKZtTd3vb+8O07WqIVSYBE6g4Yu369SFx9i4FimzVvm0vU7LlAijqgyG8wfxsq8rDK/G4z7ugly3Cmjv1QqS8YsTmzhkx6gAKNpkOA52GY/jXU+evmKG7/EotrT+t54mTLf2G2R1uSh2R/SRSIDVu2daegzuFu4tRzmcWrik2rZb3RafB/X1uGzwML9O24ZEhStO7kPNy4a5fCMUQBoOOqnL+65SJ9F0vUHF5sPctu6coPhFois5ZL/8dwyG4xvJwzgk0/DDHggGkffq8+Xye+0pppeOXWS3zKKsLBvkhwtGeMn0vN3ki14wH4oxDC6dk1C9iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jr2zl19Q7U4rayc0dxN5f+b6lVeBTqlyNkjxf8+SaGU=;
 b=C8A4JfHXv9DXKEgbi5Q07F21fkILvLYH94dhToZEcAuKeYf57f9aCKnmzx9ifhPlvr9hHnlBIhNJkpmw5W9G2jOSgz3UptpQ3LQoYOf3ljH0wGNIlAkh8hDUTQluxoghSZeGo3f6YJq81QHH5hCjfaHCF7OI33CdjBoT1SLHDvbId5vHhF6X5yXNIs/Xp7nR991e9HTPkc9vQPsjf/7+s2+XIBsAdgFdcTmj3ZMPCNcDa97fFg5brdhN8VfIb+27otNJsbce5SKV/s667646z0A83Hc2sKdEa0mxQi4k+RZ5lfTdEWRJpH+afR1lzTAqLYSZxcONfpuCLeWk23eAHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN0PR12MB5978.namprd12.prod.outlook.com (2603:10b6:208:37d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.34; Wed, 24 Jan
 2024 13:06:40 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873%6]) with mapi id 15.20.7228.022; Wed, 24 Jan 2024
 13:06:40 +0000
Date: Wed, 24 Jan 2024 09:06:38 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Marc Zyngier <maz@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Leon Romanovsky <leon@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rdma@vger.kernel.org, llvm@lists.linux.dev,
	Michael Guralnik <michaelgur@mellanox.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH rdma-next 1/2] arm64/io: add memcpy_toio_64
Message-ID: <20240124130638.GE1455070@nvidia.com>
References: <20231205195130.GM2692119@nvidia.com>
 <ZXBWXodu2rxQ7Szz@arm.com>
 <20231206125919.GP2692119@nvidia.com>
 <20240116185121.GB980613@nvidia.com>
 <ZafISDVeAA1swx2I@FVFF77S0Q05N.cambridge.arm.com>
 <20240117123618.GD734935@nvidia.com>
 <ZafWIsrjvk--JdDn@FVFF77S0Q05N.cambridge.arm.com>
 <ZbAj34vdVuMrmdFD@arm.com>
 <20240124012723.GD1455070@nvidia.com>
 <86ede787d7.wl-maz@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86ede787d7.wl-maz@kernel.org>
X-ClientProxiedBy: SN6PR2101CA0014.namprd21.prod.outlook.com
 (2603:10b6:805:106::24) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN0PR12MB5978:EE_
X-MS-Office365-Filtering-Correlation-Id: 20b79242-b52c-4525-b867-08dc1cdd4de5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2XjCLbqHm0mKyU/6s+nUMtBREYOh66LFwHvSghop84s7LPqUhO7csaMMnRqI853TkrVfciFpQZc5+zTayO26K1Dpl0yolY9xmlVc4wmdpqLhMICoU4kd+UuXn7DWbDVI4ARnzwuuy/LHpgKynhgOW6MGKVadiob3Xm2iwLU9+rTmZ65aI0jkiKQNprhFMUNEe4vmQwSdPk1ADKFdwM6UQYlxUZIwrfa//87cGgJA619/n7PyIgiTTXAYjgJ1OVinZVDOOh+11EjcvKKX3UAr6pZDCI76E41yPxTIfQofOjdTTSAFZG9nyAZeUV6f52NQKH0SPEfNUAMfwkyznw7wmFH0aQm88zaCoR5Nw5nctCKP9PRiEAUHDxCEFpQGeUO/HDVLKnBHknvcVBetLpBxDdOf7AvXzGmFj3mHQdcY12w4EDMMJP846/yLj+Tv5Psud6arzfTzlCdiarxlaXL7Ida8bxbQG4+6Z3ja2Tpv24l4+WJbcaPkGOMuQ21sI3kyzb8PnSIsQ54TGiv+pejZdi1SLTJj7ufD//54FH6ZFTBYhy/inmNq3+39RFtodyBk
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(39860400002)(376002)(346002)(396003)(84040400005)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(86362001)(6486002)(478600001)(33656002)(36756003)(2906002)(316002)(2616005)(1076003)(26005)(8936002)(6506007)(7416002)(66556008)(5660300002)(6512007)(4326008)(38100700002)(66476007)(8676002)(54906003)(66946007)(6916009)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dGccODiyz6HMmrk9YeCIOdN7O0kklbASboAp088QJH0rEyJjxQtt+xdCriLP?=
 =?us-ascii?Q?yu19LnMQK3FIVKPCG17K8UjIscqdY9+W6XyuEEiWODLZB2/layj5FQ94nfrd?=
 =?us-ascii?Q?/i+7h2+FZpwvBgWUJAhwAseUwhDEScn+jvbHeOK9KQukiNdaduN4k9xX4+ex?=
 =?us-ascii?Q?GvGvjFTJpfIYwaWOy5xawE7JpxPCE1FjFtkDGLSxRQPmnLzYQU+Uc8V0HIsI?=
 =?us-ascii?Q?cOxXvRnDlV06Zl426y7tYB8BWOIxzWz3wmjHPZatMF0HMR3imKUhgfEXOrcL?=
 =?us-ascii?Q?fKKzQ/yI5fYsqOvKmYt7LtC2sTuU8FvRyA8xs6bdCsql48as3Z5lIJjv/CIH?=
 =?us-ascii?Q?RVHqf3ndRIpbHMjFOKN/uPDQ064LeGqCoxNRPDVlJWm5ZehXD12TwNJ3OrCx?=
 =?us-ascii?Q?6ll2eNkerWCtCMl5WgLKAWLp1ifADh0/bRvyrQ7fD/BkUcNc7/0JTH41HXYS?=
 =?us-ascii?Q?t+KvKhgfvLlM2oXf46TQcFsC5yJ/aJNW2kbfbq7SU8qRgxxa9XI7CuswzCLg?=
 =?us-ascii?Q?7r/923xgwZxwPIVszYkInr4x6UH9Sr/7efuKwXWLVrRVkteB75S4Ma5xGtN+?=
 =?us-ascii?Q?t3zlbnAikVc1m14uGDVjPjBbJ/OMsfLRKAS4queLEP2c1Nxsq43lNm331ZGE?=
 =?us-ascii?Q?XF2s9Xzy2pAnmsKjPiXXHpulzg7etinonjlUSowlQ429c6cA2YIeuyj6/qWT?=
 =?us-ascii?Q?e3XdNd57s87yPStrQGeUIxzAoM8cW8KxZ2rDgiX0O2h0iMql7v17zJIt1ept?=
 =?us-ascii?Q?gvdIo3FEWoEWijnM0RJ09b5zk0b457EZIHVvP2HUn7KCefcyMV3K5ocFwIYD?=
 =?us-ascii?Q?nFaw48XF6ti1Kx7oMwX+kdi95s6PRPPZ/Y4w/cER8vhkD/LhzJxONGdONoTg?=
 =?us-ascii?Q?ObU+rF8Vu6P31aJax2EV7oFgo2HcMqdJQ+TDMy92u51nigAtax3kgZ56NcMf?=
 =?us-ascii?Q?kmGOtSfMx0zyeHJCJ3hUo9Z8gHIG/+I3mfPCN4UiW2q2WapVI/Ig7x1DZ0qA?=
 =?us-ascii?Q?rqfY/SigbePO7IxeeDwx0y+aPtET0G3nOcQWQvgXQ8B+os6W/n6T2ZzViBTp?=
 =?us-ascii?Q?95SG1xnygnViYm3nBV7JNSxF159pshQPMAmb8gOIWso5iR1CKfjJkfQJqdiX?=
 =?us-ascii?Q?tgIJrHUWEYnZVtdqKl+YfsvlyF+QGnL8U1eukerdI29oHFdDmkBiqGTM3uSR?=
 =?us-ascii?Q?rFiINUl2GuTMQprHFTGD2SF+5W4P9zl2KEl3xeqs+agLAXPSxLciSdmfTCJn?=
 =?us-ascii?Q?q1N/QsBbmsKV2PgUekxFI64EEiOqvPlFK3aJC3acO11f7DYu32I1nyjVSLrd?=
 =?us-ascii?Q?6hHUls1m4vAmpCIBKZuqDB7zWsX3n7REuPGdUqoNIS5LVpLJmKVQ+NKk4zkm?=
 =?us-ascii?Q?obmBd6noDA20RmXR733AYUYWg8zIWcgZwmBi85O8WF7nbO1Rw3VWKG1ciPJ6?=
 =?us-ascii?Q?FxtQqBNthUZAucbYr3zze9aEmvFxqSOfBcYguOILAM7pi1E6nU/DUB7pq+NM?=
 =?us-ascii?Q?WFHc6qTnPt2Fb0LNtF7JWvdQ3SThyKZiblgtB4BHxbWlXxuL1vOSVD6sqkOx?=
 =?us-ascii?Q?4Nd5v/TqTzwH9MzH8Go=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20b79242-b52c-4525-b867-08dc1cdd4de5
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 13:06:40.1367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UQB/YnbrH+N3Q5sgZQGIWBQIKC8prrurSHTk2S/UrcIIJcRpCV3U+rp/wQVBL78C
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5978

On Wed, Jan 24, 2024 at 08:26:28AM +0000, Marc Zyngier wrote:

> > Even if you refuse to take STP to mainline it *will* be running in VMs
> > under ARM hypervisors.
> 
> A hypervisor can't do anything with it. If you cared to read the
> architecture, you'd know by now. So your VM will be either dead, or
> dog slow, depending on your hypervisor. In any case, I'm sure it will
> reflect positively on your favourite software.

"Dog slow" is fine. Forcing IO emulation on paths that shouldn't have
it is a VMM problem. KVM & qemu have some issues where this can happen
infrequently for VFIO MMIO maps. It is just important that it be
functionally correct if you get unlucky. The performance path is to
not take a fault in the first place.

> > What exactly do you think should be done about that?
> 
> Well, you could use KVM_CAP_ARM_NISV_TO_USER in userspace and see
> everything slow down. Your call.

The issue Mark raised here was that things like STP/etc cannot work in
VMs, not that they are slow.

The places we are talking about using the STP pattern are all high
performance HW drivers, that do not have any existing SW emulation to
worry about. ie the VMM will be using VFIO to back the MMIO the
acessors target.

So, I'm fine if the answer is that VMM's using VFIO need to use
KVM_CAP_ARM_NISV_TO_USER and do instruction parsing for emulated IO in
userspace if they have a design where VFIO MMIO can infrequently
generate faults. That is all VMM design stuff and has nothing to do
with the kernel.

My objection is this notion we should degrade a performance hot path
in drivers to accomodate an ARM VMM issue that should be solved in the
VMM.

> Or you can stop whining and try to get better performance out of what
> we have today.

"better performance"!?!? You are telling me I have to destroy one of
our important fast paths for HPC workloads to accommodate some
theoretical ARM KVM problem?

Jason

