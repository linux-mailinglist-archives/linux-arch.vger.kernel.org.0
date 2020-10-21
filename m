Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99AA5294C0F
	for <lists+linux-arch@lfdr.de>; Wed, 21 Oct 2020 13:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439776AbgJUL7m (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Oct 2020 07:59:42 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:39122 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439708AbgJUL7m (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 21 Oct 2020 07:59:42 -0400
Received: from HKMAIL104.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f9022ac0000>; Wed, 21 Oct 2020 19:59:40 +0800
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 21 Oct
 2020 11:59:37 +0000
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.105)
 by HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 21 Oct 2020 11:59:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CZESJMpycdnJIL6YqafdDVOygA0Ft/SbSDYTMZ5TSNOoHy+T34z9CFNZtP581x4ppBf2NbSxYgbkxjAsWICs3AfLXXjuLHK/thsVu53udmyvdpq80sucLN/1IYLLlw5E5rgyuV1af9Dbd2ubRMdTHSbghYjcH9aBPNjXpLMG9kNIzucZuTBmBGI8tb7xnlqhUbmRt407No3b0X5+msomptk80x4OGuW+0B+PMtbfL8MCBC3rl6/0UV3PCXESH8MUEXi5jutx9cQCRJM3YR4YQcx89fbu5iRyF3/9iNMRX1VAPyXnqdEolPmHNCydUSDvuctLB/oCqvmEB/SJH46K4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MSxuzY8mRCeGGk4B7dZgaFlLp9Sygp3sC0Z94j1H5hg=;
 b=QqRoY2rzWStrMR1Mgr5YaNaPJWDzVUiWh2PE/jR/5aqggMBx0YOMfxUzAkEtf+2G6lZvB99R8ItuCa7qsh8sVjagxOnO58S3K9j7rrkXenJ9jLfZa+DSHaWiD2ZABsdEV3EyDtZgFYeruUI1HRcawriSoCyc7CmacLTj6dsG/ked6t3gGQnWZktS19QFkQyYKyMpDWdNEZY2ZxW9+oqMAaLKXoNHE0egC5eTHVjmDP+1YovHIpK5nlXizWbYcFx/App0mjvHfQGmrO2M7aIlrEp/BC0OT4ib3ZnaGn9bvpZQ7T6q2lXfkBHgGF8zXav0i93X4yxXcI8yzXn2zjC6IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3306.namprd12.prod.outlook.com (2603:10b6:5:186::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.25; Wed, 21 Oct
 2020 11:59:34 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3477.028; Wed, 21 Oct 2020
 11:59:34 +0000
Date:   Wed, 21 Oct 2020 08:59:33 -0300
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
        Paolo Bonzini <pbonzini@redhat.com>,
        Alexander Potapenko <glider@google.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Rik van Riel" <riel@redhat.com>,
        Larry Woodman <lwoodman@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        Toshimitsu Kani <toshi.kani@hpe.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: Re: AMD SME encrpytion and PCI BAR pages to user space
Message-ID: <20201021115933.GS6219@nvidia.com>
References: <20201019152556.GA560082@nvidia.com>
 <4b9f13bf-3f82-1aed-c7be-0eaecebc5d82@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4b9f13bf-3f82-1aed-c7be-0eaecebc5d82@amd.com>
X-ClientProxiedBy: BL1PR13CA0258.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::23) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL1PR13CA0258.namprd13.prod.outlook.com (2603:10b6:208:2ba::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.11 via Frontend Transport; Wed, 21 Oct 2020 11:59:34 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kVCmD-003Szc-77; Wed, 21 Oct 2020 08:59:33 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1603281580; bh=MSxuzY8mRCeGGk4B7dZgaFlLp9Sygp3sC0Z94j1H5hg=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=IrA7CaLTHVGX0oWXirOHZZc3xlLWh6yRMqhBGqbVOxHxlgalGGuLBjNk2xRQGsi2H
         z8RNubckHE6YOATdhjHsHSV+AtJEB/+gQ1+EqEj84vw2uXojvl08UhqAtcLp4wkrTL
         UEJMPUnRnXOAx064aHiGUaqYlNYIM/254Jr7PQnPr/onSwHwr75hBAXppQ7sMc8/D9
         N2+HxcBWbZQ6IQmRWYY1cQdL1RNeoxvz/OmthOMKrdSHw2MNGYuMQCj4Ow6QsRF9B7
         kBaN3sVbmDSBCziZCKNA1DAIuiJfSGhUd9XIGPn62EjVUd9arhZvG/sR4EnEIcfyjy
         H6hHwnpXXsBxQ==
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Oct 19, 2020 at 11:36:16AM -0500, Tom Lendacky wrote:

> > io_remap_pfn_range()? Is there use cases where a caller actually wants
> > encrypted io memory?
> 
> As long as you never have physical memory / ram being mapped in this path,
> it seems that applying pgprot_decrypted() would be ok.

I made a patch along these lines:

https://github.com/jgunthorpe/linux/commits/amd_sme_fix

Just waiting for the 0-day bots to check it

I now have a report that SME works OK but when the same test is done
inside a VM with SEV it fails again - is there something else needed
for the SEV case?

This would be using VFIO with qemu and KVM to assign the PCI device to
the guest, it seems the guest kernel driver is able to use the device
but the guest userspace fails.

Regards,
Jason
