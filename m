Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE739295057
	for <lists+linux-arch@lfdr.de>; Wed, 21 Oct 2020 18:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2444367AbgJUQDb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Oct 2020 12:03:31 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:7436 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436706AbgJUQDa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 21 Oct 2020 12:03:30 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f905b740000>; Wed, 21 Oct 2020 09:01:56 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 21 Oct
 2020 16:03:25 +0000
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 21 Oct 2020 16:03:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mRhEbENkDKrVqgzlqmLXhohO/aGLrxYrJNS2WNHOxtW85yCK7KIF6i+/O1o41st3P12dl5GW9kaYJTMz8UiyPogwjjeAmGiD9KO2ChKtejSJvR9F0jXKZzYe+CbIyj8FJcWsEa/xLcGCoOL1dw4Hl6tYhQuGe08MC4978fk6MmmppgJ49Vqha+KcDXiqMoIC1+OH67P1iu+lpYeWSoh8sAMUnK2pc06masgL52C8IlLRfUwmPH4mMZJ4KIwYJHfbsWTk/jzzejJ3iCL2DIG0Jxbt8b1aMasxAxA4gCk3RTcRhm7B8Patmd4WSRnn7Nj2wVA1nL5RItetNCN9MDP9Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XB+FhDduwMEIWosA5Idr15DXqqve7Url6j+ZRFuWW8A=;
 b=lBqpC5MficjtfiuKjn6INCPppnd0qjTX4aezMImYlsvArLSL07zCMB9Nol+6oJ+RPOrqZkzfWPjCbR3YDsi/jqdv/WNkk9un0ob29y4TAtZnQDUQiIEPbEob4qAPoLMF0rnZurlWyEegn33XiLnnniNT+b0Xx/EYiMzpEyObxWPlVRqD0hsS0nD/7tPOn6xD8guR4/ahA5rGWtsFx0w95ni403JAakhAhJSe9ncw3RjxS51cVq/os4axaW/8h7cLbsNcpnJparM336UkWvs2u2McPbHAUmJLIfSsdwF3vqaqbR3X3IA00FUaGDpSPhX/XZlRGP9TkjDa9lznJR2k2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1660.namprd12.prod.outlook.com (2603:10b6:4:9::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.22; Wed, 21 Oct 2020 16:03:23 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3477.028; Wed, 21 Oct 2020
 16:03:23 +0000
Date:   Wed, 21 Oct 2020 13:03:22 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>
CC:     <x86@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arch@vger.kernel.org>, <linux-mm@kvack.org>,
        <kvm@vger.kernel.org>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        "Konrad Rzeszutek Wilk" <konrad.wilk@oracle.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "Andy Lutomirski" <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Paolo Bonzini" <pbonzini@redhat.com>,
        Alexander Potapenko <glider@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        Rik van Riel <riel@redhat.com>,
        Larry Woodman <lwoodman@redhat.com>,
        "Dave Young" <dyoung@redhat.com>,
        Toshimitsu Kani <toshi.kani@hpe.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: Re: AMD SME encrpytion and PCI BAR pages to user space
Message-ID: <20201021160322.GT6219@nvidia.com>
References: <20201019152556.GA560082@nvidia.com>
 <4b9f13bf-3f82-1aed-c7be-0eaecebc5d82@amd.com>
 <20201021115933.GS6219@nvidia.com>
 <f9c50e3a-c5de-8c85-4d6c-0e8a90729420@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f9c50e3a-c5de-8c85-4d6c-0e8a90729420@amd.com>
X-ClientProxiedBy: MN2PR15CA0027.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::40) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR15CA0027.namprd15.prod.outlook.com (2603:10b6:208:1b4::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21 via Frontend Transport; Wed, 21 Oct 2020 16:03:23 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kVGaA-003Y9G-2N; Wed, 21 Oct 2020 13:03:22 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1603296117; bh=XB+FhDduwMEIWosA5Idr15DXqqve7Url6j+ZRFuWW8A=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=DB3y2aMU6rw1i0Di5GZIuaYzLe7oy7tgdx5loh7hJEAkD+ryJoS8b0oMJg/psZL9v
         snLb7eENEIr55aKVpYz1HfUiWd2ESng1Ng0Oun20p2LqRel1b1uvg0qs3jFPzww8Hr
         nLlPbZwU8mlKpcnA6g9clthHAsOOEbyPY5yfJw0dZgwsVFuxux6yJYlNapcivjgQ/6
         S3bvcDMJxkgEvXovPOIXWYZSlYSJ10OiosrxkBOBC+HOwd33DAZMkXsN9gatDG9fTi
         uRPoxFpHE1zrCGyif6+SEnvMtPDOG6t/Jj/epk3JiLzVrUqXqQYsg7mF+xF+5szcXB
         CVm8gGAefav6g==
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 21, 2020 at 10:30:23AM -0500, Tom Lendacky wrote:
> On 10/21/20 6:59 AM, Jason Gunthorpe wrote:
> > On Mon, Oct 19, 2020 at 11:36:16AM -0500, Tom Lendacky wrote:
> > 
> >>> io_remap_pfn_range()? Is there use cases where a caller actually wants
> >>> encrypted io memory?
> >>
> >> As long as you never have physical memory / ram being mapped in this path,
> >> it seems that applying pgprot_decrypted() would be ok.
> > 
> > I made a patch along these lines:
> > 
> > https://github.com/jgunthorpe/linux/commit/fc990842983f3530b72fcceafed84bd6075174a1
> > 
> > Just waiting for the 0-day bots to check it
> > 
> > I now have a report that SME works OK but when the same test is done
> > inside a VM with SEV it fails again - is there something else needed
> > for the SEV case?
> 
> Probably. I would assume that it is getting past the MMIO issue, since the
> above patch should cover SEV, too. But, with SEV, all DMA to and from the
> guest is unencrypted. I'm not familiar with how the DMA is setup and
> performed in this situation, but if the DMA is occurring to userspace
> buffers that are mapped as encrypted, then the resulting access will be
> ciphertext (either reading unencrypted data from the device as encrypted
> or writing encrypted data to the device that should be unencrypted). There
> isn't currently an API to allow userspace to change its mapping from
> encrypted to unencrypted.

Oh, interesting.. Yes the issue is no userspace DMA stuff uses the DMA
API correctly (because it is in userspace)

So SWIOTLB tricks don't work, I wish the dma_map could fail for these
situations

I would have guessed it used some vIOMMU and setup decrpytion just
like the host does..

Thanks,
Jason
