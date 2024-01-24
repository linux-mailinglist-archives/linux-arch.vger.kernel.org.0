Return-Path: <linux-arch+bounces-1514-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6469F83AAE6
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jan 2024 14:27:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 203121C20326
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jan 2024 13:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1AFF77F04;
	Wed, 24 Jan 2024 13:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="H100TWoR"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0807D77622;
	Wed, 24 Jan 2024 13:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706102847; cv=fail; b=SxOnfmYnekgRYilGmpVgnxdW7URv7QZ9fP+64MoD8u6rqTkX7Awb8mueQQmLHMlSmemptoxaE0li6DsP/Ursbr6hsXT321zOA4CsP3qnq+RU12SP7faxVHlFo2sZzNkqruTnFTmSy35IIWd9KEUNbBp4gdVIiByeSIqIwoLTJ1k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706102847; c=relaxed/simple;
	bh=728E3lRPi4OJJLLbAMnOTsbeyn+HXhoycDlUm11CGvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=l1+0sYO2eq1LoZSPC6rooAa11+Is41YW1G2sjPI4drFI1v+7WC2AUQFk/kaDjsu98FqMqh9AaM7NgfIX9/5NwVPwtPyCFPLd+Klqhyp+/q79Fm87o3WLQwx4qyzjdaRgmGlmmIQFGvnZ2fIltLii1dPT/d0QYKn7kexJ8THLNl4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=H100TWoR; arc=fail smtp.client-ip=40.107.220.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fG3AE9JBb2qkrCTg35/UtVx6n3AhIKwuh3kzZEkNKT72BHAaw1y3RXQOF85TFoW2GLRKpTUcWrXwalNjUb15I3hX4P1XnV0/GvUff08vS0/dRKe2PPSIaIjqAbkD1IKKGYTbAw2sOWrwIWHOeucQrVisyaicmeCFq4ahHq5Oekkq1i7M2kfjIzp2I3zphQxjdZcm9aUBYmfLGEzoVsPRystakRYjadTIThUEL/Nhqk4YGhWOhPB6HBY37jXonD+iy8XSDFYV901fho0sgRvFSyeQywkKsQ6B/1MWGwWoTm4ZhC0JkGPFQKwOpxr9uvWucRoPPeu4WcvsnsqjyxjUhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FO1lJgJhT0SyFBNkCEyhSsAF6q9oQZm/ARC6i7kvNVY=;
 b=Xt/EKaSjDfPNn0tH1W5Jz6Ey9aKIFeQxo/wsiuW8d7TiZwWvflZuow8DHGPS8NU67sIcS3L4dV60VIi5KpRO4wSCcbvW2tbEDJlFI0oQN6zVPSBo+E6jl+KFJ1GsBXSpOt14BM6tXoSOY7eIyOUtJNKLwdQNQF+Ak5cYUrmQJ6Er4oOfVO19ScGIFtWZgh+rMAMgJfDkz/Rvh9lfN1hw2MkCm9p53/wfG4rlUjgffJubjN8pO5m2ZjlLVRr1Sq8g4CS7Z+iBr9AOhrQ13swaWBT3iFLjGOmbhAbGlnknPw3fRGUmv5Q1rKa8A/9RlLBoeP78unLV6ZgWgJZjnXNGUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FO1lJgJhT0SyFBNkCEyhSsAF6q9oQZm/ARC6i7kvNVY=;
 b=H100TWoRQFYmhvRQp+RcBB7Ifr4zWOLvHcMU3OzEQm5AkpbW3HcA4sc5BK93JLdAATQ3hWCDKuhJXwfJT39w9B4VEaueUwPf/3Wa4VxJpOxkkbR38TmPMtlRRQSoaucCJ14YjU5/YMGcv9FoxxDjRlyUvdx69CLCVKO1KZ6wjTToCNyskpnDCOzPXp7173p5/1Nu94QpDiuwhv8ZoSB2vsElKMiH+CAN7PIi0aBORGsAyoIP7hsKiPsK2+Z5GJmRpaKSUaWM85tzB15eZccuJK5aftSwZ2S61BVvOWObqbri3kpA4fnLWDGG80JY3e+ZseedEW/6OqTNJadMc0wtow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN6PR12MB8514.namprd12.prod.outlook.com (2603:10b6:208:474::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Wed, 24 Jan
 2024 13:27:21 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873%6]) with mapi id 15.20.7228.022; Wed, 24 Jan 2024
 13:27:20 +0000
Date: Wed, 24 Jan 2024 09:27:19 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Leon Romanovsky <leon@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rdma@vger.kernel.org, llvm@lists.linux.dev,
	Michael Guralnik <michaelgur@mellanox.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH rdma-next 1/2] arm64/io: add memcpy_toio_64
Message-ID: <20240124132719.GF1455070@nvidia.com>
References: <20231205195130.GM2692119@nvidia.com>
 <ZXBWXodu2rxQ7Szz@arm.com>
 <20231206125919.GP2692119@nvidia.com>
 <20240116185121.GB980613@nvidia.com>
 <ZafISDVeAA1swx2I@FVFF77S0Q05N.cambridge.arm.com>
 <20240117123618.GD734935@nvidia.com>
 <ZafWIsrjvk--JdDn@FVFF77S0Q05N.cambridge.arm.com>
 <ZbAj34vdVuMrmdFD@arm.com>
 <ZbD2n-BKGbDgMfsB@FVFF77S0Q05N.cambridge.arm.com>
 <ZbEFPbT7vl6HN4lk@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbEFPbT7vl6HN4lk@arm.com>
X-ClientProxiedBy: SA1P222CA0050.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2d0::25) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN6PR12MB8514:EE_
X-MS-Office365-Filtering-Correlation-Id: 96b2e632-9d37-439f-d1fd-08dc1ce03156
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5NfOArrCbY2SbH5fphR0OevE0dKuUH270ruSd26QLJojQKH3VgSeNsZ4RD6nBXVNNIFEyRJ0PzSdB5Y3m4RFNLcJZlfC+Om4haGblvixBlH68bfRZuphyT1ZmCqrgZY+fLkwBtoccUcXQ2jSsympemb75vjkGsUl7dK8F1w5wi/4p2LMvr8DCYUVwj05mKfAOmQiopuze773+zkiwqhE3HowA+cR5GMuj2uxqKlXGG0ES+E+Ud6VrxLjOKGXPKiD0F3BAN+9I29yYEojq/ZPNKXifZJFu13nmahaXDTfOzfuj4+qkNZchy5vwTSp4ScEzmd31VVK2Nb9nPQyVdLzKWXalwT1ecpHuQPidoDXy3Qgm+MsUkSxah8/7/dk6JE35kWladV55NG+iJtbV8U9Do38wh7ejD6MwrTdnYks+NCfdOpz7o94cw37gxroBP6Um3PRXKLTQcYDHmLLq3ia26TQFE6FEbiFbL9ov7tTKPkWqMVqE0xF/3NrVK8kUs/RVBnUvlwsDGqb+anOK8sImJg1/J15lTja0oHmpaBO0jXnpJuJXIA20LRmnXK08aThT7qDYsUiw4b3m++g0LGPvBOQHHJzgdyX/EPc0LuEC/M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(39860400002)(136003)(366004)(376002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(8676002)(66946007)(6506007)(966005)(66556008)(26005)(6916009)(66476007)(2906002)(6486002)(8936002)(316002)(7416002)(4326008)(1076003)(5660300002)(54906003)(6512007)(2616005)(41300700001)(478600001)(83380400001)(38100700002)(36756003)(33656002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/4kZvkR4dXpu4OFl/HmhNKxr50z27mLhbr64IhuukHqerJ1G3AM1NBzGOQHq?=
 =?us-ascii?Q?APc/YnupWtCzZwNmTykF5gaSSBTCChu6ghaGM4Uz/sh0HEUEdybV3iLp2WUx?=
 =?us-ascii?Q?jnvvLyiYFDMc074Bb/M5n++bsbFeDmCQAqWz3CGNbDlt+td7KWUMGZ2ZfOSu?=
 =?us-ascii?Q?gfcsGyrRKdthtCxgAfXXO0y37RvwGbovplfhgB0MnJpJjMvMwR9vMmT5UELb?=
 =?us-ascii?Q?/CQmUeQrU1Mp/1ax9JUoupn5CCNjsJ+AWIykLMQo2wTaqMujkBxjpy7cJTcZ?=
 =?us-ascii?Q?BU1ymw51CD2Av/jrelbUPdiHNSwTOXmMbIQdFL79KWRABa8DLVL0zYzTar/7?=
 =?us-ascii?Q?4n9e9OIqs7TS4pPTGaL6jEQ+iz0TpGLRICK6jaTwHXuLC0cCQvsz6J/t5+lE?=
 =?us-ascii?Q?qnFqHG6UPdk4W1QinL1Tj+bOc4tbclX3u2f+T9i96nsdaXAgEY0tCIJhNVxW?=
 =?us-ascii?Q?MppPe1Ot1y8dzuG59cYxT/Nrr2YbjhjN9E5zyPM/+1CNqAJVG9+3Altu5BBA?=
 =?us-ascii?Q?uZdbxQHbDE8nQ17sQMgGB81PGAOxdgnQlp/wYCTWudiTUt+L0Ars1j8beaXx?=
 =?us-ascii?Q?XmZfisGDg05UsSuBqInYxYjmVthH4ofzT8/vs+QHWVLJG504J52Rl5dV7RF7?=
 =?us-ascii?Q?xKvuRkc3/Nyawz/CGGZqN8jldgQ5OIjR5krxHQuh6+UKc08xUtnCtKJZBLKz?=
 =?us-ascii?Q?+WcYGJzpZ3lTWaq4+fboEasPZq341flgaopH7QOrPcE3eID1Mo3ImXUjMZgG?=
 =?us-ascii?Q?+B8qDTZqeb9cLZwiTdrK+OTJ5quSya1W9GC+ENsNElLyqukaB4XtSSJvXrU9?=
 =?us-ascii?Q?onbhXFNNaEsMhtHnN/RYYSn7BU1CPvG1jemL+hpRr2I8qBf+ppE/p49371hc?=
 =?us-ascii?Q?K7PnDJ480C0p/uiuMkbVDkSzMC35KE/k8py802Txh2W85GQDEEq1LIK6l+Jx?=
 =?us-ascii?Q?b+kYAL3qjQXYE1k454nCNTQiphgnNZsILKP5or1MLiqMjSendLsLSeW3oUGZ?=
 =?us-ascii?Q?0fXSAGI9cUBYFwvJ3qI2IHQ+fsoL3CBLJtKoS1zyWNWyrO2QIyzV3bWQmU3V?=
 =?us-ascii?Q?O/kIA3DdCAKt+4VpHflBv2ltMHTf/B7ZeW5CPBTiDKg4ACSxDgUqlmVseQVP?=
 =?us-ascii?Q?R/SqNoMrq+X8IE6M85ASfRe5yml5ThEnvA3x0dt1j2Y4xbaImupuQyoMRc+e?=
 =?us-ascii?Q?bJQ7tW3uvcGz34FWTxf0G012dIw47dFH9HKRoIFWR0hcpCa7VjeowB6ccHFY?=
 =?us-ascii?Q?VoLmRyp9chmf1PKOoaFJTVoEAHQrKwKQP0gJ/kPYuOR5hoOCa+2NzpSquAEY?=
 =?us-ascii?Q?neZxIbJQ/ViS3F1ATE/9wJD9Mht7ewneyM3BUXgG0IBP0vdZ+LmAjJYPed8i?=
 =?us-ascii?Q?l7WkVnZ+DIo0wsxbjByYGddggPKv632DM97KdjKe3DvpEFDkRnJfQTwygc+N?=
 =?us-ascii?Q?c8vNX1ekNUL30meJGwVrc3QE5so8m8axUz2ObUURI9FeX0LI9mQg+g/DWYUw?=
 =?us-ascii?Q?lzU73BUGtMu2T+5Hst/xPKKod+iumOVFFHkRTnorEuflBcoWNeTLdTSBo6Gc?=
 =?us-ascii?Q?5iM5hgz6o/pdbDu4xESfwQfn/rNnd/0qmoqZ5USQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96b2e632-9d37-439f-d1fd-08dc1ce03156
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 13:27:20.7312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KYJJ/0dmeg11vW1T5D+qis3JV/a0uEnSMvN+j99pY+dBGuOf6B/pxBBE4SkzUvoW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8514

On Wed, Jan 24, 2024 at 12:40:29PM +0000, Catalin Marinas wrote:

> > Just to be clear, that means we should drop this patch ("arm64/io: add
> > memcpy_toio_64") for now, right?
> 
> In its current form yes, but that doesn't mean that memcpy_toio_64()
> cannot be reworked differently.

I gave up on touching memcpy_toio_64(), it doesn't work very well
because of the weak alignment

Instead I followed your suggestion to fix __iowrite64_copy()

There are only a couple of places that use this API:

drivers/infiniband/hw/bnxt_re/qplib_rcfw.c:     __iowrite32_copy(mbox->reg.bar_reg, &init, sizeof(init) / 4);
drivers/mtd/nand/raw/mxc_nand.c:        __iowrite32_copy(trg, src, size / 4);
drivers/net/ethernet/amazon/ena/ena_eth_com.c:  __iowrite64_copy(io_sq->desc_addr.pbuf_dev_addr + dst_offset,
drivers/net/ethernet/broadcom/bnxt/bnxt.c:                      __iowrite64_copy(db, tx_push_buf, 16);
drivers/net/ethernet/broadcom/bnxt/bnxt.c:                      __iowrite32_copy(db + 4, tx_push_buf + 1,
drivers/net/ethernet/broadcom/bnxt/bnxt.c:                      __iowrite64_copy(db, tx_push_buf, push_len);
drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.c: __iowrite32_copy(bp->bar0 + bar_offset, data, msg_len / 4);
drivers/net/ethernet/hisilicon/hns3/hns3_enet.c:        __iowrite64_copy(ring->tqp->mem_base, desc,
drivers/net/ethernet/hisilicon/hns3/hns3_enet.c:        __iowrite64_copy(ring->tqp->mem_base + HNS3_MEM_DOORBELL_OFFSET,
drivers/net/ethernet/mellanox/mlx4/en_tx.c:     __iowrite64_copy(dst, src, bytecnt / 8);
drivers/net/ethernet/myricom/myri10ge/myri10ge.c:#define myri10ge_pio_copy(to,from,size) __iowrite64_copy(to,from,size/8)
drivers/net/ethernet/sfc/tx.c:  __iowrite64_copy(*piobuf, data, block_len >> 3);
drivers/net/ethernet/sfc/tx.c:          __iowrite64_copy(*piobuf, copy_buf->buf,
drivers/net/ethernet/sfc/tx.c:          __iowrite64_copy(piobuf, copy_buf->buf,
drivers/net/ethernet/sfc/tx.c:          __iowrite64_copy(tx_queue->piobuf, skb->data,
drivers/net/wireless/mediatek/mt76/mmio.c:      __iowrite32_copy(dev->mmio.regs + offset, data, DIV_ROUND_UP(len, 4));
drivers/net/wireless/ralink/rt2x00/rt2x00mmio.h:        __iowrite32_copy(rt2x00dev->csr.base + offset, value, length >> 2);
drivers/remoteproc/mtk_scp_ipi.c:       __iowrite32_copy(dst + i, src + i, (len - i) / 4);
drivers/rpmsg/qcom_glink_rpm.c:         __iowrite32_copy(pipe->fifo + head, data,
drivers/rpmsg/qcom_glink_rpm.c:         __iowrite32_copy(pipe->fifo, data + len,
drivers/rpmsg/qcom_smd.c:               __iowrite32_copy(dst, src, count / sizeof(u32));
drivers/scsi/lpfc/lpfc_compat.h:        __iowrite32_copy(dest, src, bytes / sizeof(uint32_t));
drivers/slimbus/qcom-ctrl.c:    __iowrite32_copy(ctrl->base + tx_reg, buf, count);
drivers/soc/qcom/qcom_aoss.c:   __iowrite32_copy(qmp->msgram + qmp->offset + sizeof(u32),
drivers/soc/qcom/spm.c: __iowrite32_copy(addr, drv->reg_data->seq,
drivers/spi/spi-hisi-sfc-v3xx.c:                __iowrite32_copy(to, from, words);
sound/soc/intel/atom/sst/sst_loader.c:  __iowrite32_copy(dst, src, count / 4);
sound/soc/sof/iomem-utils.c:    __iowrite32_copy(dest, src, m);

At least the networking ones I recognize as performance paths, we
don't want to degrade them.

__iowrite64_copy() has a sufficient API that the compiler can inline
the STP block as this patch did.

I experimented with having memcpy_toio_64() invoke __iowrite64_copy(),
but it did not look very nice. Maybe there is a possible performance
win there, I don't know.

> > > If eight STRs without other operations interleaved give us the
> > > write-combining on most CPUs (with Normal NC), we should go with this
> > > instead of STP.
> > 
> > Agreed; I've sent out a patch to allow the offset addressing at:
> > 
> >   https://lore.kernel.org/linux-arm-kernel/20240124111259.874975-1-mark.rutland@arm.com/
> > 
> > ... and it should be possible to build atop that to use eight STRs.
> 
> That's great, thanks.

It is a nice patch but it does not really help this problem. The
compiler cannot be trusted to use the new writeq() properly, eg clang
doesn't optimize the new constraint at all.

Regardless this has to be a fixed inline assembly block of either STR
or STP.

Jason

