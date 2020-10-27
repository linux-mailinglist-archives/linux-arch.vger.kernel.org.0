Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8055829AB4E
	for <lists+linux-arch@lfdr.de>; Tue, 27 Oct 2020 12:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750373AbgJ0L6T (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Oct 2020 07:58:19 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:6260 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750371AbgJ0L6T (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 27 Oct 2020 07:58:19 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f980b450001>; Tue, 27 Oct 2020 04:57:57 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 27 Oct
 2020 11:58:14 +0000
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.56) by
 HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 27 Oct 2020 11:58:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OpJwEAhW/1o7e3SryeXWsqfxPV9ry9R8Iu6j5got1koMLs3EWQz+SdSBuRtz3YC6MCZbL/9WyP/5f+ymZaA9tvqGraI4yjhhLYzRkttiAPnirLuLgelN913a+vWBfdDitbaLNZtHZCu9dIf+NF7I3YAMBvtF5n2A0KQCPqkMnQdr4m78b/B5ILgrxShdMIO1UFd3g+5x/VHwOaV52uy/BydgCIdSobOn1NQsXmjbJ4eYChI8uonUy8hHRdLnTg3KkzIg2jFY8d23mTA+hJL44/T9y89j9V0Eaew/6AC40NFbabLqz/UcQEay21k5j80Dd4VRVRYJUYZqgpQfF4pTIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=euyUCc7Fc3m9fZe0HlaXBdvVYHYAC98vLn14YMvbS+Q=;
 b=BfUaY4Da/TOLKZYTvOuBL7hhaolcLrILnlbcnBfgzbEoyj2QrTlDKDKTp64eX2A+tEkzIB4y3pEsYgsfjCZWVY2fsQmqroIVtj2u5eRQb50lICIU1PPG1TwSsZiI+9HqgmiGpagCwGyViKKW5LZEp6Xc8vZqTxgMGJm1/vAFw+9/gBCqN5JUoPozTFiGXS1Sib3GcY1WevMGNLX00/CgV9beYB80pm6Prfqm4oCyHIrCh2yc/sfFEIPDfuOHeSjl67NWJicepcl4GNRQ1fNB7alKWEzbMSFrOoseQZaSxyoM4N1ms69LxhY3cjbxwcbdwxDyPfdbVLyznpKoLQ3kow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR1201MB0201.namprd12.prod.outlook.com (2603:10b6:4:5b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Tue, 27 Oct
 2020 11:58:12 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3477.028; Tue, 27 Oct 2020
 11:58:12 +0000
Date:   Tue, 27 Oct 2020 08:58:10 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     Tom Lendacky <thomas.lendacky@amd.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-mm@kvack.org>, <kvm@vger.kernel.org>,
        Radim Kr??m???? <rkrcmar@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Alexander Potapenko" <glider@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Dmitry Vyukov" <dvyukov@google.com>,
        Rik van Riel <riel@redhat.com>,
        Larry Woodman <lwoodman@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        Toshimitsu Kani <toshi.kani@hpe.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: Re: AMD SME encrpytion and PCI BAR pages to user space
Message-ID: <20201027115810.GH1523783@nvidia.com>
References: <20201019152556.GA560082@nvidia.com>
 <4b9f13bf-3f82-1aed-c7be-0eaecebc5d82@amd.com>
 <20201021115933.GS6219@nvidia.com>
 <f9c50e3a-c5de-8c85-4d6c-0e8a90729420@amd.com>
 <20201021160322.GT6219@nvidia.com> <20201027084357.GA10053@infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201027084357.GA10053@infradead.org>
X-ClientProxiedBy: MN2PR01CA0053.prod.exchangelabs.com (2603:10b6:208:23f::22)
 To DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR01CA0053.prod.exchangelabs.com (2603:10b6:208:23f::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.22 via Frontend Transport; Tue, 27 Oct 2020 11:58:11 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kXNcA-009G0X-VP; Tue, 27 Oct 2020 08:58:10 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1603799877; bh=euyUCc7Fc3m9fZe0HlaXBdvVYHYAC98vLn14YMvbS+Q=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=BsYyMkxO11+8dWhoE/1vd3jsm0B6LncaeEWQKojoA35WglK4IsBwotwYx4xtqNKea
         uL8QNdyijE1QZJ9kJholMyuVB1Lte6sT0SQqajJyv9QRAZM9bBBeEa2qjJahuNWvLk
         QuqcuS0vCGDr5pdBJyrKYRp7oiBJcBY5gR005wAdfIIVOgv7IcQzuOD21nb+wjeU27
         6udevM5BbAL2qONyjEgKegW9fW7NDH88t0hVIpDJOBjhoY7CejmCsbC6S5eDMmDDNy
         6GJ7er886vRNiOU3NX0xiqogIEMjlKdXFlXFPhs8FGk1E1J8VKmgyBBxhr/ROs1y+C
         7VzehGWJ5W9Tg==
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Oct 27, 2020 at 08:43:57AM +0000, Christoph Hellwig wrote:
> On Wed, Oct 21, 2020 at 01:03:22PM -0300, Jason Gunthorpe wrote:
> > Oh, interesting.. Yes the issue is no userspace DMA stuff uses the DMA
> > API correctly (because it is in userspace)
> > 
> > So SWIOTLB tricks don't work, I wish the dma_map could fail for these
> > situations
> 
> Userspace DMA by definition also does not use dma_map..

? Sure it does, ib_dma_map_sg_attrs() is what RDMA uses

What all the userspace users skip is the dma_sync*() - that would
require a kernel call which defeats the point.

So, my desire is some flag to dma_map_sg() that says
  'user space mapping no dma_sync_*'

ie dma_sync_* is a NOP

Then things like SWIOTLB on the SEV system can fail with an error code
instead of malfunctioning

If FOLL_LONGERM is some estimate of this pattern then we have these users:
 - drivers/infiniband
 - v4l
 - vdpa
 - xdp
 - rds
 - habana labs

Jason
