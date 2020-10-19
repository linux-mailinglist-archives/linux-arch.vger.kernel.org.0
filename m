Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A582292CB2
	for <lists+linux-arch@lfdr.de>; Mon, 19 Oct 2020 19:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731165AbgJSR0j (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 19 Oct 2020 13:26:39 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:54926 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730095AbgJSRZO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 19 Oct 2020 13:25:14 -0400
Received: from HKMAIL101.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f8dcbf70001>; Tue, 20 Oct 2020 01:25:11 +0800
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 19 Oct
 2020 17:25:10 +0000
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.107)
 by HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 19 Oct 2020 17:25:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QVIcJnbikLrwBj7xpDOjAf3ueq6t991lWTlZhTAfIeqJH4M9EFIz0Y+uML5c304yuWH75liz8qDIiVxx9COwJ25X1i2U1NVX5/XFxcl33hlEoMdNwzl8xYgFVrRZs/9qVcXk6TuLBopWW27UX1nhrTLEAsTB8RKYlddHxjQ0wz35+1rosoNUyNDbpg7TMH9TMpzYjMHHHIZwTDacb3+mVx7+cyYuuPY5npy/f6YfYECkvTb48/hUHsNO3IqXiraQFd4/diO7SYa9KorTQQlLYRoVKnfuBu7ohjrAd6ZaJu++KwaHcCO8FD6oghyQ1Xvn/cNsmpGLbcv6ZZ4c8pUssQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+RYXBXHcRflICjlHYqIevLJYA1M+Lqj3fKVCCM8NL18=;
 b=gHnhgPX8DuggNHk1A+oAinWsH0vNbS+7XpD0mr6COZQztZvXPZmQJW8hXaL6mmUMnHt3I3LfS2LwoUQt08v+n9vitsSz/0Q+ZyDZ53nfoSTe9mXqIMWjXp0k5IRM4QYMiXYNHpCPUL2tTB+ZiORKQwvND3R36B8qpbe5Kof7qiyQ7KPVcT6i3OPG2Yp+Ss3P43rKQ+CHyG/PVO1nCxTM8uAHeNFTl+CidcIQHfToKdOELChZgiRw9rk6vt0RgHEfPdH5hwVu3Fs35Lelh/VNcdzFVavaxaeTszwPi4UQbGpL9uEfcsHv+g7zvco/3e6U5G4G7OTjeYQBFV8kHAcl7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4619.namprd12.prod.outlook.com (2603:10b6:5:7c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.22; Mon, 19 Oct
 2020 17:25:07 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3477.028; Mon, 19 Oct 2020
 17:25:07 +0000
Date:   Mon, 19 Oct 2020 14:25:06 -0300
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
Message-ID: <20201019172506.GV6219@nvidia.com>
References: <20201019152556.GA560082@nvidia.com>
 <4b9f13bf-3f82-1aed-c7be-0eaecebc5d82@amd.com>
 <20201019170029.GU6219@nvidia.com>
 <d0e18bf8-b591-6af8-198d-82f629cda695@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d0e18bf8-b591-6af8-198d-82f629cda695@amd.com>
X-ClientProxiedBy: YTOPR0101CA0061.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::38) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YTOPR0101CA0061.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::38) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21 via Frontend Transport; Mon, 19 Oct 2020 17:25:07 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kUYuA-002PCS-4j; Mon, 19 Oct 2020 14:25:06 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1603128311; bh=+RYXBXHcRflICjlHYqIevLJYA1M+Lqj3fKVCCM8NL18=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=hflumUd4UYce+WaEmkheM/m4iewe/t0yUJdb0gAtIY/x7CMxQ4tuJA/u0k4xJFfAx
         y4+dwlQqZ8zwS5awXyQoiRycrldWmVK1m9MFAzH5iFa4z69Im2R1EaptdEAG8DN406
         5rb74a1Ik0zOoiGqc1kzgetn5q9sP7nsV5TShFdENtkzNXVN39C17OsIGdQ7nYVM8o
         9zudwozdnjQSWeRLVRR98YmQkCOD3CmapRPaG3KRNdikDlergnTh8GYSH1JgK0nLyX
         9geKjCNI8BoSIpmCRm+NfcXPCQkPvXFyJ5+t2c3DkvrFphy6Nmh9nuRmn4tg0jPKuF
         CffhOhVYw9s7w==
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Oct 19, 2020 at 12:11:36PM -0500, Tom Lendacky wrote:

> > Hum, I assume it is broken also. Actually quite a swath of drivers
> > and devices will be broken under this :\
> 
> Not sure what you mean by the last statement - in general or when running
> under VFIO/DPDK? In general, traditional in kernel drivers work just fine
> under SME without any changes.

Split user/kernel drivers are common enough. Looks like maybe ~50
drivers in the kernel potentially are mmaping IO memory so would be
broken here.

Looking for pgprot_noncached() or pgprot_writecombine() around VMA
mappings is a pretty good clue it is working on IO memory.

I checked through the infiniband ones and they seem to be using
io_remap vs remap properly, but other places may need fixing.

Jason
