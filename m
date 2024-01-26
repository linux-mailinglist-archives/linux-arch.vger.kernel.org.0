Return-Path: <linux-arch+bounces-1725-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B4B83DF7F
	for <lists+linux-arch@lfdr.de>; Fri, 26 Jan 2024 18:10:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55C511C215A5
	for <lists+linux-arch@lfdr.de>; Fri, 26 Jan 2024 17:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FDD11EA7C;
	Fri, 26 Jan 2024 17:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YZUgsIQj"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C87C1E87E;
	Fri, 26 Jan 2024 17:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706289003; cv=fail; b=MdCp57MfClDnLT2HBLuC50hAbI1buIOr1B/kqPFthylw8e590lsAmNjWVBU0VgTFf6WAeRAaoBDeA/dVWAuOzhkF/8VwbqfpQmct4CnPuWb3VPsVuWYcmSMoP9HuskpOLDT0rd7nxft//dDQkSzajkuY8oejM/z7A9ke9bZKqCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706289003; c=relaxed/simple;
	bh=akzzGuyJ2ambuPdIF461qRLgzBIefK6K1klbxI4gCLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=O+FbqF32UtqmTSiXQ0JaJ/Vu1Ws/tGyArWyL0hPzstbp07YhkwT8sdso8DI9Tdv1mIUW3YkCj8swPoRuGz8TibvziAHbFtAIkDhlZxzivS0NwAlP+GUtqVDdfDhe8P5KdmTFcM40J3VN5++rW7u47XQj5DzwLBcjlqD+gakNLeA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YZUgsIQj; arc=fail smtp.client-ip=40.107.244.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nk+khtqUzE7vMKUZCfWQrRCwM6ia8q4DdW2EiB18aw0zc14SBNGPcbS9TWaAJnCB+HEu7wDgnAe/lppvGTWwR43XlTBO42crWB6DQMn6YVuypV7FYCDrn/55OkwXG5ZF8lvVG1SAZJPjLJItktGy6tlUEeYDORX6p8Rkc+oUPh2ucmqjIfV57Lyf2oV/UGqzhZAcoVZc4mdrdBE+2hat0HUpnFiCmFU2CEo9fzONTfL7iBNXXM9s9eYCEQFXC6YMKhwnh5RlfFms9wgbf8SWlr5rDGdWE6FbvpAEzdPDSBdBx5FSuEOUEluR/1Av0qXCIGrXQyla4FEggezK4NNbmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B4TQuGh8mAUa4VzaUM0TVZf5bmjFQqFYYTpbN6KiQwg=;
 b=GeeTW9r5NljfaM3p9ElWh/5oCEAJ8xb4WlXIhmExMMHCCI3PFY4N4rQ17QImYEDNUQo9IdKJ8ERy5tLCuD/HtxNCjy9fb2Vaka8lpXK0QLcQ5JWNshJg25j/UHfc5JeReXy6bxQvz8FH1L6sWfmAsEEjBkBLkkhP47BakgZ9wMWA+jy0A6GjFsLyy392bt9eWyrXHOmb2Ww1HRuG0R/e5JnHud2xI1f50nK9aC2qzhDkEA4HsIQdHQjlSAA+7JDDq/FbZJKqkyFfokjuUsVi8PC/vEOTtHc2dMx+YWItsw/AIWYtmZ+APpuDzXL2TsBxckHb6kXxOqCGyqdDmz/QJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B4TQuGh8mAUa4VzaUM0TVZf5bmjFQqFYYTpbN6KiQwg=;
 b=YZUgsIQjUj72MDnsjjOYpqA8yVS9uuigH/UeIBlUc+KrRXLa8mLwDW+pAI7Cai1OzpmK8HQTHCbiP7pi2oF0/Zk9GBBlBnc7S+LmvGRJYdC8o2X/69aYIrU4P54eEN6NHIziN/aLYlvw4HI+P/k4Ddg/cocL+rqxpKB8IzNt5ag+uvUP/cQGEcJx6aXtxDst/dRPKxVg26i53K2AX3BRdFzVG/o9coNgmDGZZPbpcbiUQYbtGRle3zEU82qzopfduQcKYgrRIRw6nAu7sniFPNT3Ke82y73YDmssEN6Cah8cvWEGrZKYMlU1bb3Q+DrWHixQeA0tNeQttyjC5vQewg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ2PR12MB7991.namprd12.prod.outlook.com (2603:10b6:a03:4d1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.24; Fri, 26 Jan
 2024 17:09:58 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873%6]) with mapi id 15.20.7228.022; Fri, 26 Jan 2024
 17:09:57 +0000
Date: Fri, 26 Jan 2024 13:09:56 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Leon Romanovsky <leon@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rdma@vger.kernel.org, llvm@lists.linux.dev,
	Michael Guralnik <michaelgur@mellanox.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH rdma-next 1/2] arm64/io: add memcpy_toio_64
Message-ID: <20240126170956.GW1455070@nvidia.com>
References: <ZafWIsrjvk--JdDn@FVFF77S0Q05N.cambridge.arm.com>
 <ZbAj34vdVuMrmdFD@arm.com>
 <20240124012723.GD1455070@nvidia.com>
 <86ede787d7.wl-maz@kernel.org>
 <20240124130638.GE1455070@nvidia.com>
 <86bk9a97rt.wl-maz@kernel.org>
 <20240124155225.GG1455070@nvidia.com>
 <ZbFO6ZXq99AWerlQ@arm.com>
 <20240125012924.GL1455070@nvidia.com>
 <ZbPalOaGu4XjMb0R@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbPalOaGu4XjMb0R@arm.com>
X-ClientProxiedBy: SN6PR01CA0002.prod.exchangelabs.com (2603:10b6:805:b6::15)
 To LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ2PR12MB7991:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f2e6b8c-fc5e-41b6-734c-08dc1e919f9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SrnNBRaMehhqnVu7zo2y+fXEImYtnRKaFyvnpKcoUFKmkbSB+PD+cfsXOjWUUEfABxITFZEt3zyevbXOXGLvQk9/rX6lQvPtvlolGOBDkDm5JWn2YL5wI7GqO1EMr3TFfall0eS3RpdyGkj7w2wEPs1XY6DvlCaoq3H1u55umgXRk/3mqU+e2j+gYkkUJ5szCKLFSyl/SDauociItJZ7/48nfbKgQfgxs8+AJ59cdLRzV0zOYwhdZoyLWvij6hrB8ZLGqeKf+ah7ajWiWFjcac/SNcLbLDPeh445tRolEVec94y2yywA03zEZbRDa64fq7oVR7kerGmjGiNo7d/Bfjc/VoZ8AFkQugNYN08/H2ayNdD4du9F7JcISvPWnO0zl1dl+HBzSLqN2c+ntnl5moMIpu2pvdBylOgb9WzUwT6q9NfRDq79RcQ4M6gl/Mbj0WF0uCIcMc1ZWwXXzdePYMkVwSUCGsum5pHWzZ18+CnosMiuEhfyxddkpPU3P6rTQFpnLXDIuX0fCgT8cOZNVP4spHBvd89soFuIXCdzQH+SCXvLESo8MIDSWaaCUhsh
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(346002)(396003)(376002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(54906003)(7416002)(5660300002)(6916009)(66476007)(33656002)(36756003)(8936002)(2906002)(66946007)(316002)(4326008)(8676002)(66556008)(86362001)(41300700001)(478600001)(6486002)(1076003)(83380400001)(6512007)(38100700002)(2616005)(6506007)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?I9dLNIlFSz3nslOq8mr2wEHQy4mZoXcPEk3dRVv5FcysUt5eCl+VzBLNlrq+?=
 =?us-ascii?Q?dbU/OdKse2jHX8Ue4uev0eaDGAA5n1FRI9rCjoJNFT0LxDaEYKIHHQjAnYCp?=
 =?us-ascii?Q?hxlrHdVlCM80RoNHpVnKpvFgs735E+AQQ6YzoZigWGTkdLqWmhwQR99YOk3z?=
 =?us-ascii?Q?9b3LH8PKfXAj4R8S2Y6zTxQtn/YBf4Ml8CnUv8XBaseMFr0N3v7iklBF0oZ6?=
 =?us-ascii?Q?AGvSpUq7fGuS24aXGbPStAk55b8Kqo2jOzpQUnpFdfxUia2CLZXQjfMcH/RZ?=
 =?us-ascii?Q?kzMKkiaOpD820+rBm3LqB4R21EcBu+fVcPo4bfCZsi/pxd6a5+S8YO4PTPmE?=
 =?us-ascii?Q?GepW4vYyRS6mSQKhvY0Sob8Am2afB+ci2ePusxxiIdlVmgFsb8g91aVRjops?=
 =?us-ascii?Q?noi5NRCAg9bz8ABCoinYnharYLIV7iWd1zb0go6Te6RJiJ9EsUFq5cmJxdlb?=
 =?us-ascii?Q?gIfUCklsD+WFTEOycm8zoirLPx6kDuvCG0uKt4Z0iiUbOnSK0YGvhxM6h52T?=
 =?us-ascii?Q?sAdVTtVfVi/K4fsKD9Abp9w2C6s8nKMzoeaKSVbBEgCVZ5EXQgFgIWe3xJbd?=
 =?us-ascii?Q?uzgksCn7hgT7HBJLhiK8139EDwwg4yhxdMjJSAMn936RtowWEAVjjkHuU1g5?=
 =?us-ascii?Q?qgyJSDQfpputTQ9ZjKRCBsV/PVUBJnaq4BHn5zT3TcXIh1N6vtYJ7yqP6E8L?=
 =?us-ascii?Q?axnn0bL09i47eQS3Tnj5wtZ4DpDdlmvwrw2xiFlfAeEsDdvVMBUT+xW92mTY?=
 =?us-ascii?Q?ElznDoGqOZFQT0nzNZRuXHq94acMRd0ZtPNom8KExh1yTZNzLYTmP9QEVaas?=
 =?us-ascii?Q?jSYnmddpiR1e/kkSbDOFd5PKnwLXJMBeusRUZP0xX1Ug5ScMGPsen4ui/DR7?=
 =?us-ascii?Q?357IC1OE54jv178x9ZaFDNZKL+EqQ/KeJIAdCPo4Se4bsnk3Oybs+PATezsr?=
 =?us-ascii?Q?A3RlyhDwqFCXw1/hyPGsuyDU/5ZdIiKZq4pDoHVurFsf9g4T5+UqNL9g5Ws3?=
 =?us-ascii?Q?piW5X3v4QwNDTYudzxSa13JnVID2X23cHZ5SFzBHG9Ssc0N3FAMPN7fQP3LQ?=
 =?us-ascii?Q?vFViVaMoTYWhzCvmrBK1cpQWAqlEhSzHBQkgu/v+YocpMukKEPYd6bbDWztl?=
 =?us-ascii?Q?D+C/xvpL9Lze2B0F64I87FVkTfjDXne0byWYfL3ny/S70cJ004uyPd1jJXz9?=
 =?us-ascii?Q?1lFED04q/TXqi3zNgcCRBy7ueEIp9FnJJev0JxvuNNfKPk/vDbBxcL2aHQww?=
 =?us-ascii?Q?uyMX9RJUqs7f5hzaSgeCiMQoK5kvcmMCslS3cnxaelmnxeJnXRv6mPg7p708?=
 =?us-ascii?Q?AP9M2cl3/KLlPvLoDe2r8dO3Me0EmyC0zQaCd+nSeYo9JW39Ao0F4HorWUHw?=
 =?us-ascii?Q?L4/0MeJlAegIUWBq+l9shzoopMGTqpI7VEleJ11zkwpFCFEMjPHC7wvAZh0r?=
 =?us-ascii?Q?VfnUdZpuLZ1clnporxsJQVcxM5x/qqymH0Mnea5Pm3kyWhn1lZ1riMKkQmB3?=
 =?us-ascii?Q?BKj+EUSznldhsKQ3P5dmjsHVJvuf75C/dAh6+aPCw1gcCirc9E6bqZNfGeBH?=
 =?us-ascii?Q?1VIjC2SlB7PmOxqvlBpfY36dvIclZgD9sFsaYVCJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f2e6b8c-fc5e-41b6-734c-08dc1e919f9f
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 17:09:57.8480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jwP8OqMq51fZdV8g7qfcDBwrPO8ZoaOvsXtYO4jGEIM9iZRE4dnJEksxOH5GKP95
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7991

On Fri, Jan 26, 2024 at 04:15:16PM +0000, Catalin Marinas wrote:
> > It looks to me like qemu turns on the KVM_CAP_ARM_NISV_TO_USER and
> > then when it gets a NISV it always converts it to a data abort to the
> > guest. See kvm_arm_handle_dabt_nisv() in qemu. So it is just a
> > correctness issue, not a 'VM userspace can crash the VMM' security
> > problem.
> 
> The VMM wasn't my concern but rather a guest getting killed or not
> functioning correctly (user app killed).

Right, hopefully it is the latter.

> > Thus, IMHO, doing IO emulation for VFIO that doesn't support all the
> > instructions actual existing SW uses to do IO is hard to justify. We
> > are already on a slow path that only exists for technical correctness,
> > it should be perfect. It is perfect on x86 because x86 KVM does SW
> > instruction decode and emulation. ARM could too, but doesn't.
> 
> It could fall back to instruction decode, either in KVM or the VMM
> (strong preference for the latter), but I'd only do this if it's
> justified.

From a performance perspective, if the VMM is doing pure emulation and
wants to memcpy lots of data to emulated vMMIO I'd look at it like this:

  1xST4 transfers 512 bits and requires one vmexit and one
  instruction parse.

  4xSTP is four instruction parses and four vmexits

  8xSTR is no instruction parses and eight vmexits

The instruction parse is not pure overhead, it saves on vmexit's which
are expensive things (at least on x86). I don't have a sense how this
stacks up on arm, but I wouldn't jump to it being horribly
non-performing.

> I don't think the issue here is VFIO, I doubt we'd ever see emulation
> for hardware like mlx5.

Sadly no :(

It can happen in non-production corner cases due to the VFIO MSI emulation.

There is a qemu bug prior to 8.something that causes it to happen at
random, with VFIO, rarely.

There is a non-prodcution debug mode in qemu where all VFIO MMIO is
trapped. The qemu expectation is that this is functionally identical
to non-trapping. (The E in qemu is emulation after all, kind of a core
reason it exists)

Finally, we do actually have an internal simulation tool that does
software emulate mlx5 HW without VFIO.

> But we are changing generic kernel functions
> like memcpy_toio/__iowrite64_copy() that end up being used in other
> drivers (e.g. USB, UART) for emulated devices. 

I didn't touch memcpy_toio, I think given this problem we shouldn't
touch it. I only touched __iowriteXX_copy() which did not look like it
is being used in any drivers with emulation.

Even if I got this wrong we can revert any impacted drivers to use
memcpy_toio() instead.

Jason

