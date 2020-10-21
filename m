Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2539295003
	for <lists+linux-arch@lfdr.de>; Wed, 21 Oct 2020 17:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502518AbgJUPaa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Oct 2020 11:30:30 -0400
Received: from mail-bn8nam08on2089.outbound.protection.outlook.com ([40.107.100.89]:14176
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2502459AbgJUPaa (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 21 Oct 2020 11:30:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ikUTUeysJPgjFz2f/sXQLUnFYC8ErMMZO9N3H8HBjzaAgnkYyU0w9Hhi5B8F5oan+oilO8dMtT/xJQ2oq614zemXBksjKXbRz3sLLTIPjwjW7+miGfX2w5IfNzR4yAu24Z/DHs5ZlTNnMNc3vUBUxWYWQDr+KQBLW0Wke/cxm6SBQX+qWSZZ2Y9RWB7lmRlHURt4FCS4xJzmSGEJuiy8RPol0e8YIcfkpEaaPayNcH6/m6H10Oha2HdrfKa+ZJTpzEb6nqYFYDR0jJ51vaJaB+dfgD0hTJqZOclc0kp5FXoCKLJegssg6PhgO9MCKvi1MAhR3UnvLV+sJAmrLrgDIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eKc87hqNdEvUkpin0YSTf+kTVsHqnN1ZjbLiX7YtPTM=;
 b=WI5IaobXwlX6hXdHn0qo6x65vVRDHz9UxDRNuYaIvxdG7o5w5WywlAxCEudB2L8uvsSNATz92FOchLh43rD+fXrJ7pkPbgP4WvQ/F7tAvZkeXLmlA4RKxWC804kv9CTCw0wNlygHbThqY0spTldljHZotiM5bB1mnjMhlfsHt4+ue3JHE9jvHNDIDFIfVOPiD9aFWkZaqTIgLjk4yploaYGXoX3bVgxtG8PG5AnPP3xyX5edDLf2l4l92KAhmY86hsQdkOSS7lWMCd1Czba72g26ckDgSg4FIQHmU6V6PjGPN/A9N1geZxMD7qUOmY3f0yS3zN0ei5SrPIMSPITcCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eKc87hqNdEvUkpin0YSTf+kTVsHqnN1ZjbLiX7YtPTM=;
 b=w0WLNk5TrscZR7zocfM6jwyOjUVI3K9h0BIo+MZVYNU2ovHd8f8yyJPMH2iXDR2/JWA9c0JuwxyhpOFx2Cpdc5lWgzQOj+P0PMR47lKfnS7Q6AZR3Khu5Tj+0ivPtNBQju718wfw6N0cjwFUtly8M8WwzHhatabYmbWKZ/oFd0o=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) by
 DM5PR12MB1706.namprd12.prod.outlook.com (2603:10b6:3:10f::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.24; Wed, 21 Oct 2020 15:30:26 +0000
Received: from DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::e442:c052:8a2c:5fba]) by DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::e442:c052:8a2c:5fba%6]) with mapi id 15.20.3499.018; Wed, 21 Oct 2020
 15:30:26 +0000
Subject: Re: AMD SME encrpytion and PCI BAR pages to user space
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        kvm@vger.kernel.org,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Alexander Potapenko <glider@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        Rik van Riel <riel@redhat.com>,
        Larry Woodman <lwoodman@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        Toshimitsu Kani <toshi.kani@hpe.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Brijesh Singh <brijesh.singh@amd.com>
References: <20201019152556.GA560082@nvidia.com>
 <4b9f13bf-3f82-1aed-c7be-0eaecebc5d82@amd.com>
 <20201021115933.GS6219@nvidia.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <f9c50e3a-c5de-8c85-4d6c-0e8a90729420@amd.com>
Date:   Wed, 21 Oct 2020 10:30:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20201021115933.GS6219@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SN4PR0401CA0016.namprd04.prod.outlook.com
 (2603:10b6:803:21::26) To DM5PR12MB1355.namprd12.prod.outlook.com
 (2603:10b6:3:6e::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.30.118] (165.204.77.1) by SN4PR0401CA0016.namprd04.prod.outlook.com (2603:10b6:803:21::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Wed, 21 Oct 2020 15:30:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b01c4189-3016-46e5-b937-08d875d63bce
X-MS-TrafficTypeDiagnostic: DM5PR12MB1706:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB170607C56093C721A6810511EC1C0@DM5PR12MB1706.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wR3dZOfM2JS1VT6ladHmTC4oOM2Tw0uXJJR9ANOE0MekTkxDcnUQh9S2PsqiBobc1ZZnM7ieSZfZlPcZDRyBgTldWaxoF5FvQpP2pivxYSIYZAoWtkR8HxnmRcYTsyq9pllTNjjrssmwEglFkZNHgMLi0lojr7K9IvD6SU1mqdLEvU9DSRbRIxrVFGrq7Vi2ieJTQcShDIA9gni3Ex1pB9EjfpZxgb52bqA1U0K0aArkVlsfJnTYRlY5Mkkck2SWTVLgd96fm0V0IrHsgo0DpAEphiz0HZeWHD6sZh4LtupjTMHvt2Kv98WDAYaNtoikbWtQtIybFGmdghIQYQGM2kL6+ruWG53YAeVaLiONMM7OCsGLH+wE4PUxO/x8v1w+o4GZaMhZb+iZ65ExYaaWRdyxeKBsrpVx2odoBUBFWTR1p66VEDyEvM1V8OwYUC3AoQQYSQkvqQGJ0fHeZZM2XQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1355.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(39860400002)(396003)(366004)(376002)(66946007)(66556008)(8936002)(66476007)(6486002)(4326008)(966005)(5660300002)(2616005)(31696002)(7416002)(186003)(52116002)(53546011)(31686004)(956004)(8676002)(16526019)(83380400001)(54906003)(6916009)(2906002)(316002)(86362001)(16576012)(478600001)(36756003)(26005)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: uPkOzzdAEu8su9RBElsmQuNSKpsTtkQbrJcMd20cCMivbNOZh7TkDkwUiR4Jx9hszTDaQQWmUa3NhS/fOlisGLsDwv+YNdReibh+TdrtSYDhoJDSBfgUL0IcOirqWsZn0xSoidy5kCYjLFT7Tf5X4lDI8EzNszkW6abqdwZYehzq1ed0A0xkEmrxzYi7YvM8VKYWf5Tb1yKQ1j0PWyoqa1595P5m6SmkHIeDo5lYp2Kq7TxKKzbn46d0X5QuTXOL8jU0ekLTzmXU5GvqZop1GUJ1Dn8hhCo+sK+ZNxcSl06JQOe5y5gxJaV0NJz0qpsU6a7n466CTcBSiKE1rU+JLHqA6nJ9CoDZCEqf07SDnJ//Iy+8M6spNGGPZDYcI1oQp/pGpc60xHsY9AjLg+qpD2fzrClm/AjG2mCggrlMgwagPTDnfZX3nxH2G8c3DFV4/HOWjLP64te00jchXcAoU+8w4c+xT11S03Uz0WhFDzGpGyykvBFJ8MFt6decgeSnsCHz2KN6hvoc7tn5sfApbdCTjLnzK60xfsyvrtON1oW6BW7ntwDDAUGZkNBA6Mmo8TAVhFO2x/Z9VA8gIbgl9/oqNSB5xzPmtAuKS4xHtrV0IFEcpne6g7GcN6qFxBnAL5LbxKOTM/fOSRULZidCiQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b01c4189-3016-46e5-b937-08d875d63bce
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1355.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2020 15:30:26.3448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ohcEC07fie4rhNUepycHQleQTP6reYDmvzxHLF+SnkL0kltis2FQAtQpZzViNvzDv1wsWm/MmJdTvNSc5c30IQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1706
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 10/21/20 6:59 AM, Jason Gunthorpe wrote:
> On Mon, Oct 19, 2020 at 11:36:16AM -0500, Tom Lendacky wrote:
> 
>>> io_remap_pfn_range()? Is there use cases where a caller actually wants
>>> encrypted io memory?
>>
>> As long as you never have physical memory / ram being mapped in this path,
>> it seems that applying pgprot_decrypted() would be ok.
> 
> I made a patch along these lines:
> 
> https://github.com/jgunthorpe/linux/commit/fc990842983f3530b72fcceafed84bd6075174a1
> 
> Just waiting for the 0-day bots to check it
> 
> I now have a report that SME works OK but when the same test is done
> inside a VM with SEV it fails again - is there something else needed
> for the SEV case?

Probably. I would assume that it is getting past the MMIO issue, since the
above patch should cover SEV, too. But, with SEV, all DMA to and from the
guest is unencrypted. I'm not familiar with how the DMA is setup and
performed in this situation, but if the DMA is occurring to userspace
buffers that are mapped as encrypted, then the resulting access will be
ciphertext (either reading unencrypted data from the device as encrypted
or writing encrypted data to the device that should be unencrypted). There
isn't currently an API to allow userspace to change its mapping from
encrypted to unencrypted.

> 
> This would be using VFIO with qemu and KVM to assign the PCI device to
> the guest, it seems the guest kernel driver is able to use the device
> but the guest userspace fails.

In the kernel, the SWIOTLB support is used to bounce the data from
encrypted to unencrypted and vice-versa.

Thanks,
Tom

> 
> Regards,
> Jason
> 
