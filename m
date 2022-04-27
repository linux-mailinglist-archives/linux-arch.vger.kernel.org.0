Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE02511ACA
	for <lists+linux-arch@lfdr.de>; Wed, 27 Apr 2022 16:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237305AbiD0ONQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 27 Apr 2022 10:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237259AbiD0ONO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 27 Apr 2022 10:13:14 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam08on2071.outbound.protection.outlook.com [40.107.102.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A64444F9DE;
        Wed, 27 Apr 2022 07:10:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kGq4qouSjKepHTDgmrScIM8Y2w3aipkAzgEhWtZboeAC/qvuNF73gb2uUuIi8QmtB5Q6RNpDsiJdImHmv/fj/RhahI/nC3p37JIFob31QDkVboho9TsXUmXBj3bVWFl93jBVUt+UEG4wFN+6V1W/6s0MWpxpFFpCVONRpc71150Z24dbfMti5DhiNoFFew4ims3vFtd9qnp7kCZD8t6yhdSo47AUdcx8AR4o4eO3E2AkY+w+VUZLXRBHw7U/oUnp6IQXh8167DNRoJ+tlh7Ha/u+lRi8APyaUWJeyGLSM4BErcIqQa14TtYMB80G5EZQOVOi1k/jVliasQOwC8T2sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iiQKMgHKfWwR2IuJOkUtq3i/GbNxbvccwSVvcoxnB90=;
 b=hD5gH+8wpxbeJ7fAvvHDpnuOZKa5tYrILwPGppSlz8ZEXI6ud54UuyCOIq84ScFp0PZ5Cz74ldl7aOlKTdacrRxUmYat8/2KdHajhgbQ1YiiVnWVkOld6e+ZbL+Bz63yw/XGNM2JE2g4UaSVgEYV2XpsBgxsFBLhhSgtfynP98CQbwVCaQSE9ovSOlnxrAh1I32KrD49y9oLyYVIFKP9/0j7ebL1MJcx8ziC8T4GLaKEkBOKt0E1/4BEwkPlLdznDwf0mXJMOavGgoACy5QT+B4hrnjEGPfOymA+Mp/qtwBRM0ju8vV3J/jbkzLJ3sJ3SbGSQXQVNtN3EO1WWE8xBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iiQKMgHKfWwR2IuJOkUtq3i/GbNxbvccwSVvcoxnB90=;
 b=dJJEZH0bdurHGLM7Byk0bLVo3NJe0lI3c6BxiRox9fKEeqQCpTxMXqFHq6Xp0WeWeEnEHt1HzRg/c5tB9Ht1pZz0c5sG4f1T0GRy2Bh3k2SWFZtyf75/VrNvtwV3jUVlFyay2JlRB7LEi5nHEwcz99kskLbwx1n/vdQM5ogluho=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by MN2PR12MB3118.namprd12.prod.outlook.com (2603:10b6:208:c6::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Wed, 27 Apr
 2022 14:09:58 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::781d:15d6:8f63:a4e7]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::781d:15d6:8f63:a4e7%7]) with mapi id 15.20.5186.021; Wed, 27 Apr 2022
 14:09:58 +0000
Message-ID: <c959d3ea-1187-3e88-287b-27e75f0225e8@amd.com>
Date:   Wed, 27 Apr 2022 09:09:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 2/2] virtio: replace
 arch_has_restricted_virtio_memory_access()
Content-Language: en-US
To:     Juergen Gross <jgross@suse.com>, Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-hyperv@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Arnd Bergmann <arnd@arndb.de>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Oleksandr Tyshchenko <olekstysh@gmail.com>
References: <20220426134021.11210-1-jgross@suse.com>
 <20220426134021.11210-3-jgross@suse.com> <Ymgtb2dSNYz7DBqx@zn.tnic>
 <1c1a4a7d-a273-c3b0-3683-195f6e09a027@suse.com> <Ymk2/N/DdAyxQnV0@zn.tnic>
 <2a340424-29e6-8ad8-0181-f70450eecb80@suse.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <2a340424-29e6-8ad8-0181-f70450eecb80@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR10CA0015.namprd10.prod.outlook.com
 (2603:10b6:208:120::28) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 76156ede-2110-476c-088f-08da28579cd2
X-MS-TrafficTypeDiagnostic: MN2PR12MB3118:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB31182DFD31BE471FDEC6F4C7ECFA9@MN2PR12MB3118.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 267Du0EWzGz4w1LzxZHJD7O4owB0RLnMBp0dx7a1P7/6gBFKQVAAusNK5fRTLNkpIGXy0h4Po70l26fcO+4UrBC6NrwklrVhWql3oFUwvL452w4Nk+oOJ2t3OWLmvUB2Y5ICzQuqd3/JJdu1SjdvFRb+OVe13e6cFn1zMcZFlAYFs3vqaMotfm9iPRU337iM2n00mw7/Cl/2BRj8Y9JShwUkQU6NGmDKVBCWZ0QGq5tV4u+ErDgC9oYPWJe7tyASf11GQTZUrjbclyI24D5Osb2iHNJkdvsw6oUvjn4/O3TMkPBOOrs1JYo61NpPEyzdSyu/1Nr2b0DC1epEUqVCzrDhZZdSfO7zDXAufRNMR1jJ0HB0Zo+9jDtaO5WoO/DfJJy9VpAc19eKCB/5PFIFAwz8fY/Tz1yE8h23Lk3VjtHdMJ7aOUglwo8ZHnJMHRRtI8VsACvyxsjtKI0lYNIt7fBuJhT7k253UeIQtXTXUrL7qAenMf/8SB323WBTvwlgA3m7zGL34tj63ddzGOqjyeYY+dPi6cD1z3dQC+GTBUe4/ibDIbGt1iDnLxXLhV11Ic4m+iArDNjNWlWzS3wAAjMF4ti7Kg/fq2VfduDmXWhWrUm76xG1q2N3iKnWf+B8fl+D5f/mWP/Pw4/dGPsJYxVnMWUV4h1cPTUrKynVkaxIwfcizJL70U/2V0AIDq6PfpVq+R0bIr2Rucj3xpZw4PKnSbjDH44zGtY+HIaH2Dn/3Jje1oAzNnNAMfPotFdQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(508600001)(186003)(8936002)(36756003)(6486002)(316002)(83380400001)(2616005)(66556008)(66476007)(31686004)(53546011)(6666004)(2906002)(38100700002)(54906003)(7416002)(31696002)(86362001)(26005)(110136005)(6506007)(8676002)(4326008)(6512007)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NldiV3E1QkdtdzcwNzdsT0ljekxkeE4wcTRyZEZFQURzL0xzbmkvSzE1ME8x?=
 =?utf-8?B?NmErR3dQblYrYWd4bThWeWlTRS8yZUlNd3RJNGRhZFhmVnVjYTh3SVpCVm5h?=
 =?utf-8?B?N0M1TkFhS3NFSUNzc1NOUjdYdmNMWFVhcmxBRDIrTHdDTVpaVytmYVpvQVhk?=
 =?utf-8?B?NVdRWTBqOTVwSmF2N2pBcm1PNHdJdHRna3p5NjBqVWZVYWxHa1VxOU51enkv?=
 =?utf-8?B?NmVjVzZabHVpUFMvQ3laRzg5WFpleDRCZjloaVBZS3RWZXVnVmZLTUN3bDJV?=
 =?utf-8?B?d1NNV1Fnd1VydFBGUStHQmE1UDF5aktRMGVuQWR1bmdxQ1pmOHRKcVgxYVoz?=
 =?utf-8?B?VWZSYVNwdGtpK2RhQXZjSHV0QThjMnhHcDN0eUk2RFRGeisyaG5lb3JZQldO?=
 =?utf-8?B?eVdKSkhWdFlZMU16TmM5Q3lqQmJ0SE8xbHVPazc1aWM2WWNhazRxNzNkY0V2?=
 =?utf-8?B?ejFlYm5SNE1uZTYrR2NvK1dERFB5a2hUZFZnTU56Ry93MUNBWnZ0bDczV2Yv?=
 =?utf-8?B?NHJDN2J1SXV4ZXJLT3lIdnhUZHYyV01jbzlaZXIrTUtFbStyWUZhYmYvWUsz?=
 =?utf-8?B?WHdjV093U2gzWVUwQm45VStrWHQ2SVltbnZDbGYyU0NjNVNxZEY0MmhrVXQy?=
 =?utf-8?B?bWViUVNyWDhzRU4yRTl6TXVEVXh5b3VabXB5cFcwSm5NRzY0aFZlWmczRVpn?=
 =?utf-8?B?elVRNWpnaGw2THBPSzZLWlFYUGZnS0hHTHFHWGYyYXlDQTU1cDFibW00aVJh?=
 =?utf-8?B?L1VBTkNWTUtPc1pqYnZJWGM2akV3c3hTRXNkVG84em1iVFIvTjFZMEdMdjB0?=
 =?utf-8?B?SlJBOTlwUzBIS3Y3a2YyNUZ0NWVhRWFSN1ZPY1BiVmpja1dnM0pTWXpNK3dC?=
 =?utf-8?B?dkErR1UwSGdwWG1lVVJIQmFGZHg2YUpsNFJpaGlBak80MEROVHZGTHJLWUxD?=
 =?utf-8?B?c3I2OWVwTVdkSXBoVFhJbHRNQWtUdTVubyt2Y2dkOUM5dGVMWFJXeTFtMkRY?=
 =?utf-8?B?RXpVVnN0OGNlSmJWSGNaYmlqNUpBaEgweG1mQVd0SkdjVE1udysvc3NUMk1E?=
 =?utf-8?B?czllVkJGblNDdnhsbmFsV2NDaytFS1NoZ0QzVHpucHd0YUV1Z3FtdTJxbnJv?=
 =?utf-8?B?MStBTEZndzJ5MWtDSFNQM1prdzZaeUx6SzRwZlRuQithOHVXNHlTUFFtSXFh?=
 =?utf-8?B?a3lwa2tQZGsycElQMGl5L25hOFQvRVBJOGR4ZS9MMzNuWS9xUEg2QWFuSkdW?=
 =?utf-8?B?cFdreHRZZStsZmk5cmxmalJaenhCK01tZFpETldWOXdYbThESXFEdWR0YVV5?=
 =?utf-8?B?Tm9Na3hXK1RwczRnYnhPdlJWQjNVTlhMdWlsaUlkS2xoVW53U3RMQTBIenhl?=
 =?utf-8?B?dS9UWTJidGkvYXVrdzI4WUF6b0FkaElyWG51Q2liMkI5aXJhMnNLblJPenVs?=
 =?utf-8?B?ZjdrajdKajB1aVpjc1ZtYmNmOTg4VGdUUUlFSS9LL0szN3VEUkVzTnB6MUZY?=
 =?utf-8?B?VGpDOWFQeWd1elBqMXMrTzQ1SFh0NnNvMDdJZnJTeHBNbVNMVEprQnRsMmxT?=
 =?utf-8?B?T2tiSVZrSmxWQkFncVBDR3dDTEsyUk1sdmhFQ2s3MWlRb2dBMlFsS2Z2MGN4?=
 =?utf-8?B?RFNubFpkVzJtMlZKaWtjRmF6bWdCbHQyMXJwVnRhQmxrR1lZN2FwR2xzeGR4?=
 =?utf-8?B?S1VxKzhaeE5OQ1VNZnZ3T04wbGVQcDZldU1wZWR0KzZ5dDdQTmNubnY2aEJX?=
 =?utf-8?B?RDY0TnVLTmIrVjdKTEdPRkVVc0FtSGVRc3Mvb1BUL1phUk5uYjRnTFM5NnMz?=
 =?utf-8?B?V0JwVWFpSjBOMVkxYitwSnFUeXJPaHN4cVBHUFJsZXQ1MGcyZHZYUU1CSFN0?=
 =?utf-8?B?VUFYdE1la295WUoxNE9TakhzNGdmYjFHMFpVMnRRTXJXUG8yN0ZwdlU4RTIy?=
 =?utf-8?B?ZUpHbk1KZWdHMjN5ekNOV3VzR3NCbmZiVElRTlg3NWFpZjJIbThLLzFwUkdl?=
 =?utf-8?B?QndUMWdkTFhNaTdZQUt2NzB3SnNLOEcwUGpCZmxma0NIM1ZPVnNhV052bStC?=
 =?utf-8?B?L05scnRmL3RQajFqUHo1OGdEN3BMSzRhbS9hL2d4bzA4TXpLdk0wankvaDFN?=
 =?utf-8?B?OHd2bFJGMFFweUsvNDJoZWYzZ2FMTzFQMWMraGgvWW8rRkJodlU4cWw2M2M0?=
 =?utf-8?B?UklYRm56Z2ovMW9FSi9qT0FSSndsdWNPSFcxVWlUZWNDdnkrdWhFUTI0akVn?=
 =?utf-8?B?dmpsUEVwbnI4MXd2WTVveHIyNVg0a1RGSzhtbVlqVitiVE5EckY1SDhlcUN1?=
 =?utf-8?B?bUwzNlU3NGR0WG0raDhFQ2JucHdDYUdaSE03bmwvYzBHWlQya3JsUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76156ede-2110-476c-088f-08da28579cd2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 14:09:58.6979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n1f2EgLdqJKQXQxH9kLGyqHC1IIoBdf7fcvVZRnIGHk3pYJ94mwD75Rx7z1yz8VsSgrDIJoRdtzmeWXbTcBV+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3118
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 4/27/22 07:37, Juergen Gross wrote:
> On 27.04.22 14:28, Borislav Petkov wrote:
>> On Wed, Apr 27, 2022 at 08:37:31AM +0200, Juergen Gross wrote:
>>> On 26.04.22 19:35, Borislav Petkov wrote:
>>>> On Tue, Apr 26, 2022 at 03:40:21PM +0200, Juergen Gross wrote:
>>>>>    /* protected virtualization */
>>>>>    static void pv_init(void)
>>>>>    {
>>>>>        if (!is_prot_virt_guest())
>>>>>            return;
>>>>> +    platform_set_feature(PLATFORM_VIRTIO_RESTRICTED_MEM_ACCESS);
>>>>
>>>> Kinda long-ish for my taste. I'll probably call it:
>>>>
>>>>     platform_set()
>>>>
>>>> as it is implicit that it sets a feature bit.
>>>
>>> Okay, fine with me.
>>>
>>>>
>>>>> diff --git a/arch/x86/mm/mem_encrypt_identity.c 
>>>>> b/arch/x86/mm/mem_encrypt_identity.c
>>>>> index b43bc24d2bb6..6043ba6cd17d 100644
>>>>> --- a/arch/x86/mm/mem_encrypt_identity.c
>>>>> +++ b/arch/x86/mm/mem_encrypt_identity.c
>>>>> @@ -40,6 +40,7 @@
>>>>>    #include <linux/mm.h>
>>>>>    #include <linux/mem_encrypt.h>
>>>>>    #include <linux/cc_platform.h>
>>>>> +#include <linux/platform-feature.h>
>>>>>    #include <asm/setup.h>
>>>>>    #include <asm/sections.h>
>>>>> @@ -566,6 +567,10 @@ void __init sme_enable(struct boot_params *bp)
>>>>>        } else {
>>>>>            /* SEV state cannot be controlled by a command line option */
>>>>>            sme_me_mask = me_mask;
>>>>> +
>>>>> +        /* Set restricted memory access for virtio. */
>>>>> +        platform_set_feature(PLATFORM_VIRTIO_RESTRICTED_MEM_ACCESS);

This is way early in the boot, but it appears that marking the platform 
feature bitmap as __read_mostly puts this in the .data section, so avoids 
the issue of bss being cleared.

TDX support also uses the arch_has_restricted_virtio_memory_access() 
function and will need to be updated.

Seems like a lot of changes, I just wonder if the the arch_has...() 
function couldn't be updated to also include a Xen check?

Thanks,
Tom

>>>>
>>>> Huh, what does that have to do with SME?
>>>
>>> I picked the function where sev_status is being set, as this seemed to be
>>> the correct place to set the feature bit.
>>
>> What I don't understand is what does restricted memory access have to do
>> with AMD SEV and how does play together with what you guys are trying to
>> do?
>>
>> The big picture pls.
> 
> Ah, okay.
> 
> For support of virtio with Xen we want to not only support the virtio
> devices like KVM, but use grants for letting the guest decide which
> pages are allowed to be mapped by the backend (dom0).
> 
> Instead of physical guest addresses the guest will use grant-ids (plus
> offset). In order to be able to handle this at the basic virtio level
> instead of the single virtio device drivers, we need to use dedicated
> dma-ops. And those will be used by virtio only, if the "restricted
> virtio memory request" flag is set, which is used by SEV, too. In order
> to let virtio set this flag, we need a way to communicate to virtio
> that the running system is either a SEV guest or a Xen guest.
> 
> HTH,
> 
> 
> Juergen
