Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9706292C5F
	for <lists+linux-arch@lfdr.de>; Mon, 19 Oct 2020 19:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730336AbgJSRLp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 19 Oct 2020 13:11:45 -0400
Received: from mail-co1nam11on2060.outbound.protection.outlook.com ([40.107.220.60]:52960
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730186AbgJSRLo (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 19 Oct 2020 13:11:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=duNTZFEBjVppEE08A+3JcGVL5u/bXBestDVf+obkRTtC/tJNJ5D74GgQ3rD0CknQZacRQa+DctT0EZ7KUdm7xcfpqUuK/EJj56N+CpMOuC0FeKivFcr6LyzOy5FHK2e1WyUrGjw8rqN64qJWPaDGSPvfyFw3qlzNXAsKoHThYjVZOy3XLRi8/2nUg/kUdEvWsiWUkxNV4CW6qGXQ6PVGMzEZeTjz8KnClvXfapxOCA0Ao1P0oSpGZwSkVdH82ultk4lzZMO4mHklXH61drrcSQ3BCCrRpajjfgzhqwbPH8CeOwhWVqUwg/dP2rsIEt+o1OypT6VD8VDiOogXwUAv3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qq8euBMDQqGWidJipXSz6c5Ve5AvJpNiZkT3wHG+HL0=;
 b=cUoo8VKf8HLgd5kWUdc7c3ISGs4vFh1kGxorOxtkAJT5o7WyI2PQG9s1LsQHhY8+yp5ePkuQzSnKogRF6ufn55AXRP3IWCXge7RsZHVuN9D61AtW8swX0nXfk+aWOpJOAmfFwk/2ARTPZmXNfvW4NJ7QjUjVCaib5DmEcqpBGeY8fCdDcq9NdiBJqxrk7nM5SHoqW+mg91pDBzg8GfTSEWniMnopsdkxHlmamZqwhL162jzyIrNMDzq9hI5MOYPMU+Am0qAFBmnQYYsrra7uXuHkLeGtWkoDrYF74ErNJPJZtROx/c8Y0oNALe+DFc9Nw/XEXUYRrqQXJGBj8cP5IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qq8euBMDQqGWidJipXSz6c5Ve5AvJpNiZkT3wHG+HL0=;
 b=Tkcm2l5UsWRMOnLNB/boUUewjzTk69BaVEcXVlEXJ7C0Ia5exfuNawdPTV3mka7K/x0If9p8tdJB+MU2aoIwJsRZdSBqrHGQev7VwtZk2rjjDRmoItDFTDfhfv++ar+5Z+9eB3cdgV4H0t2GPSsyhzI1nNRvxeguxBilcJdGFfQ=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) by
 DM5PR12MB1836.namprd12.prod.outlook.com (2603:10b6:3:114::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.22; Mon, 19 Oct 2020 17:11:39 +0000
Received: from DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::e442:c052:8a2c:5fba]) by DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::e442:c052:8a2c:5fba%6]) with mapi id 15.20.3477.028; Mon, 19 Oct 2020
 17:11:39 +0000
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
 <20201019170029.GU6219@nvidia.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <d0e18bf8-b591-6af8-198d-82f629cda695@amd.com>
Date:   Mon, 19 Oct 2020 12:11:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20201019170029.GU6219@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SA9PR10CA0018.namprd10.prod.outlook.com
 (2603:10b6:806:a7::23) To DM5PR12MB1355.namprd12.prod.outlook.com
 (2603:10b6:3:6e::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.30.118] (165.204.77.1) by SA9PR10CA0018.namprd10.prod.outlook.com (2603:10b6:806:a7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21 via Frontend Transport; Mon, 19 Oct 2020 17:11:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bbc001ad-1e08-4874-7040-08d874520af4
X-MS-TrafficTypeDiagnostic: DM5PR12MB1836:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1836BA0D98269B58ADC8B041EC1E0@DM5PR12MB1836.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QsU8LbbCRygctQ+zzgg1N5OAi7fOh7/L440T1wTlQBliDVQuFiyVn/MP8Z8vBtAj78URyNhJNSMicmoyTOszuxhX3dGRNrz1xBw0JfNcjKnIwVwSJi6MwEzw1JdpdrvSB053zdSBw9C65tQaRRI+JYdjNidoKZsN468GESvtpQgmDnIZ465UthZKlMANY235Eh464wKqGxYvUgKd9EjK718MyYn7k6Sddq1xxPIE2u0Axxl8TxsWgoJG53GdxazlfolwyGF4AOYftPyvyFiGyVcvTXdlopBawkMw8CLj5EsRqbO1AI+10BarNKaEkcOB3cJM3hl3gjxB9hdsidDO7uf/LBudJfM48Wlrt/PMEt+qq2u0ypnvgdT0rgyz4p9Y
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1355.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(366004)(346002)(376002)(396003)(36756003)(8676002)(66556008)(66476007)(53546011)(31696002)(7416002)(66946007)(6916009)(16576012)(956004)(316002)(186003)(16526019)(26005)(2616005)(8936002)(52116002)(6486002)(2906002)(31686004)(83380400001)(478600001)(54906003)(86362001)(4326008)(5660300002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: E2dmv38yDCygXBVOlD9LtxMTXgv7JoY43ff3+p2x68p4ddmRExlFDZaSyoIPTD6y7IzTGnc8TYxvGSqQQpzxMywNrEvyyLeZFRUKkcD5HC688iJ6fP+I4nze8x91xX7hQfGt9r0winEDr/aipkUmFtVV02qHdCpBf/FFbQ4ZDalt7KG0FfRhlHcbAWQN+l/2kXCcIvj3n3gkJoPtU3cdw5JHJJqLNCjSOCjc6aIiTSCyLW85a1Ss6g9uh0VcPkjuYR8MbdUYB5iEEcR2JL7/mjfhjA/OKoyuT7illJ0ubaEJA0bbnU9KZoURFUau6bDrMmcmqZVri+iebRp3t7bWOiqb0mZauw09vY9cnO13fE7cY56VGPo/AdDwybeEVWBdrAFmjDEl4RxJ6MbY0r0tAy1Fzpjl0Nq5U48Zmevl0eRiG1J/d6qQG0Cv+PpBSYXdiNXFaO8IRgZEMWiZ81GnSczjg89daWmd/7/+vUfczcdK3pIlksIg2ND1FRvIdiYwjBrk0ZMkHqiQv0HsojA2eX5OFtAB1Ij/SijU1dozqGvNqTbj6uC66/gRdYo/mIhjGqGp7l6kZHFSj0pqC/FfkyOQHBAdmXf3FwXa76LD0dtPDeyRqPDWP6/b2v0ybEGUhkjZcNu6FhKsEbV4e4zgSg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbc001ad-1e08-4874-7040-08d874520af4
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1355.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2020 17:11:39.6025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CoWU2lJhGZ/7w3qku+SI15zQawhfDOkKulw8IQ451agVNli1wyCGd/rxrX7nC/Rg+pIvNTrAFXRnmq472pcwLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1836
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 10/19/20 12:00 PM, Jason Gunthorpe wrote:
> On Mon, Oct 19, 2020 at 11:36:16AM -0500, Tom Lendacky wrote:
> 
>>> Is RDMA missing something? I don't see anything special in VFIO for
>>> instance and the two are very similar - does VFIO work with SME, eg
>>> DPDK or something unrelated to virtualization?
>>
>> If user space is mapping un-encrypted memory, then, yes, it would seem
>> that there is a gap in the support where the pgprot_decrypted() would be
>> needed in order to override the protection map.
> 
> It isn't "memory" it is PCI BAR pages, eg memory mapped IO

Right, I understand that.

> 
>>> Is there a reason not to just add prot_decrypted() to
>>> io_remap_pfn_range()? Is there use cases where a caller actually wants
>>> encrypted io memory?
>>
>> As long as you never have physical memory / ram being mapped in this path,
>> it seems that applying pgprot_decrypted() would be ok.
> 
> I think the word 'io' implies this is the case..

Heh, you would think so, but I found quite a few things that used ioremap
instead of memremap when developing this.

> 
> Let me make a patch for this avenue then, I think it is not OK to add
> pgprot_decrypted to every driver.. We already have the special
> distinction with io and non-io remap, that seems better.

Yup, seems reasonable.

> 
>>> I saw your original patch series edited a few drivers this way, but
>>> not nearly enough. So I feel like I'm missing something.. Does vfio
>>> work with SME? I couldn't find any sign of it calling prot_decrypted()
>>> either?
>>
>> I haven't tested SME with VFIO/DPDK.
> 
> Hum, I assume it is broken also. Actually quite a swath of drivers
> and devices will be broken under this :\

Not sure what you mean by the last statement - in general or when running
under VFIO/DPDK? In general, traditional in kernel drivers work just fine
under SME without any changes.

Thanks,
Tom

> 
> Jason
> 
