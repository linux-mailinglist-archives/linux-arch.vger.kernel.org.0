Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0C0292B96
	for <lists+linux-arch@lfdr.de>; Mon, 19 Oct 2020 18:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730356AbgJSQgW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 19 Oct 2020 12:36:22 -0400
Received: from mail-eopbgr770043.outbound.protection.outlook.com ([40.107.77.43]:33695
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729879AbgJSQgW (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 19 Oct 2020 12:36:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JINyxoue7kN+VitGFISpoeh+4c9wmdRc7n/I90HLp7TyPtPiiPoqS6DdylI/WawGo/ToSWBo2LRZXjo7yxkZBdrEAih4ykHg8l5VorkZVvItpJoHqKWpZUN5liAU061d2aXPD+NX9VGVFlxOSHawaZRqvA2iYLjd3uiAnoJBBp9icwgUjoNw6D6tWACPIIhyEjGbNZmGB2UNAP9CXjokOgSnpt+mSmCwdh8yFCp6fIlZOcwKPvy/FA+Pp9EZrWIMB/UH1FYpdp/9azxeH0miB5LJ+5ldpFKRliD/618unTSjlcFug3xIlgVSw+Yk4+VZ0HmI7iqWyjuHYBCivN8ZxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bdWZgXa/bCqfF44bitM9tq8Otm21AF/jET38V7WgRYA=;
 b=Hu+CX38uOKOB6SwESgLdhF0iqgaT4Z0yzjo/fXo90JWhqqb9zUILxgKX175VRhtZa2Zdj8LMxRf2znBKj/lFh3D9GxsyAcO5ZSmk53KyaQHQgWnStxRAMDtrf3C8JIQytoaQHA7DSAltbXvAIJDgPOZq0hIh5xiBKSNpOXrdbU4GZtaEK4m4BSXOGj7ypM5xOLVRhlU9TpJ3ivrklTKrLEFgnD7BZBYYoJvTLJUHqnLQy/JpzDhbapAMqPykzaJ7Bo6Arb2OdjPV/gW7WplxxtfsAynuFSfw7PTqDRadIeRETZBXhwSkVm1BF+o9IToI+kz26ikzl8vGQUkhtNHgaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bdWZgXa/bCqfF44bitM9tq8Otm21AF/jET38V7WgRYA=;
 b=l0qttdoxdXk8atf1jbBjZ3Ayndvua/JVPe/i650PaZaSdkUrzqRoYU1THZOtcF7zrD5r3GSZIvbgyln8c/+utVAfrxEuBmH5NDUs7wjt7veeyPA6gJ9oUa2PbXa6Nn7bH31G+innfYvDtGp8yB1SYmvldB6TmwBiqAE0I550Gs0=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) by
 DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.24; Mon, 19 Oct 2020 16:36:18 +0000
Received: from DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::e442:c052:8a2c:5fba]) by DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::e442:c052:8a2c:5fba%6]) with mapi id 15.20.3477.028; Mon, 19 Oct 2020
 16:36:18 +0000
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
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <4b9f13bf-3f82-1aed-c7be-0eaecebc5d82@amd.com>
Date:   Mon, 19 Oct 2020 11:36:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20201019152556.GA560082@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: DM5PR12CA0051.namprd12.prod.outlook.com
 (2603:10b6:3:103::13) To DM5PR12MB1355.namprd12.prod.outlook.com
 (2603:10b6:3:6e::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.30.118] (165.204.77.1) by DM5PR12CA0051.namprd12.prod.outlook.com (2603:10b6:3:103::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21 via Frontend Transport; Mon, 19 Oct 2020 16:36:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0ecbf3bc-cc2e-42d5-b754-08d8744d1aaa
X-MS-TrafficTypeDiagnostic: DM5PR12MB2469:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB2469648FEC6DE08D53CB1507EC1E0@DM5PR12MB2469.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zla4dycUa97S/uzewvOttyHq6gZQnpF2nVfL1JxvvkWKV9WkuqjZ7y3jotVOa5dNPdT74OzO3hRxbUPS+vvcOe2oBYIyE7x1JYF7IWlPpC0SrkzFalrClMxqW9plQASurRmsCBJMp9XIkwJUTn0BvWI3TLdmSZesRkIy8IPDHjaXgBzowM+2FH5M7gkrrOV47pR1xPoH/LajzUWofsFyY8FbH191Q8NJV0NUNw3z1KPeloganX1fhQJ9D2eN87vaj6QI+flbprnqJeWKtJt0AobPc0AstxSvLdfgHicCvMiLbMCRHeIPCg9J0x2FnguGTCWaKlORzw00Z/jRL/Sf37yUgbnLemzLYLuU3gJTpb1qmcfn8Vu+wNDcSuAF8vAe
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1355.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(5660300002)(53546011)(31696002)(36756003)(4326008)(52116002)(2906002)(6916009)(8676002)(54906003)(16576012)(316002)(16526019)(31686004)(6486002)(83380400001)(7416002)(8936002)(66556008)(956004)(86362001)(2616005)(66476007)(478600001)(66946007)(186003)(26005)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 8CDt3gjiKmT0+IpS+FS1PjuByCUoTgdiXMMdvBgOW7hwE8Me9xcXwNpSIHCFqBfY2AoimHWE6rzM7+DLTxxWJRovJZwkKzyQI1k6zhU4GiBobyjUfWJVxPvarVVusCh6DoXA+0DPi8HmVrgTmIoawXgN9kTMI4eiRecrUnrme7QMHNiTo7vskWO7W2MIA7qSol/UU350Nx3s9Zkf55a0Vgq+bjapjHOb6bhrc3tXz9tKsBGPE16dDOFCNp9d/oJ3dUIgYOT3bB/E/2ojAPdi/fTe76JFQ+dd/k3Eez7RNeL9S5zFnGPVZ85ebDwztOKRqGfwfr2PkHmUgkiY/soJWAuidR+qkcu9dm2mqJVOAWa3d+wxfLefEkD9kZu1hIxCDwVIJiCwR0TiW5E1nZ4jrPDS+I/oLaj+wcMhECtlAGnMM8CUUNywRVPfNlQRbUuK8yMHUE++MBA8SIG2KVedjmIoYM4hfqvr0lDXZ9KQY04qei0eIVfG3A9ShY4F9yCHCdWar1b6BxOIpEEOfjP8tyHf+5LpvO17xjYEaGjwinzCj84FYxM19Kl/gFeg6Yehga1yD/Ao9njB0L9umbXrcgjMeuEAwLDrJtB9XrTXidaWWed+hRJeP/XLr6AbRX/H9pykYUgTNweHNPpTOzz2/w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ecbf3bc-cc2e-42d5-b754-08d8744d1aaa
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1355.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2020 16:36:18.6102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7bErGG25Xq85w8avw5K259pqJ9pe9IZwdNnE1lMb5xQFZmdrgrUBZbfsJSSCpQivcgo293alx8e7x4XC60DI+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2469
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 10/19/20 10:25 AM, Jason Gunthorpe wrote:
> Hi Tom,

Hi Jason,

> 
> We've found a bug where systems that have the AMD SME turned on are
> not able to run RDMA work loads. It seems the kernel is automatically
> encrypting VMA's pointing at PCI BAR memory created by
> io_remap_pfn_range() - adding a prot_decrypted() causes things to
> start working.
> 
> To me this is surprising, before I go adding random prot_decrypted()
> into the RDMA subsystem can you confirm this is actually how things
> are expected to work?

Yes, currently, the idea is that anything being done in user space is
mapped encrypted.

> 
> Is RDMA missing something? I don't see anything special in VFIO for
> instance and the two are very similar - does VFIO work with SME, eg
> DPDK or something unrelated to virtualization?

If user space is mapping un-encrypted memory, then, yes, it would seem
that there is a gap in the support where the pgprot_decrypted() would be
needed in order to override the protection map.

>      
> Is there a reason not to just add prot_decrypted() to
> io_remap_pfn_range()? Is there use cases where a caller actually wants
> encrypted io memory?

As long as you never have physical memory / ram being mapped in this path,
it seems that applying pgprot_decrypted() would be ok.

> 
> I saw your original patch series edited a few drivers this way, but
> not nearly enough. So I feel like I'm missing something.. Does vfio
> work with SME? I couldn't find any sign of it calling prot_decrypted()
> either?

I haven't tested SME with VFIO/DPDK.

> 
> (BTW, I don't have any AMD SME systems to test on here, I'm getting
>  this bug report from deployed system, running a distro kernel)

As a work around, if the system has support for TSME (transparent SME),
then that can be enabled (it is a BIOS option that the BIOS vendor would
have had to expose) to encrypt all of the system memory without requiring
SME support.

Thanks,
Tom

> 
> Thanks,
> Jason
> 
