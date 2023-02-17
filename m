Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C988369ABD6
	for <lists+linux-arch@lfdr.de>; Fri, 17 Feb 2023 13:48:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbjBQMsK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 17 Feb 2023 07:48:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbjBQMsI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 17 Feb 2023 07:48:08 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9547125972;
        Fri, 17 Feb 2023 04:48:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BY26KxokUyAyVFbK3P0ph/1aKfn/YlN5/Yc7SHdhyvoV+LrEwvLdTkROzQCixzVMaq/3bbyzjFfvH7eFlLBuFAh287ur3ANyKbCe/Hz6prS4/WijpKluM7qPgKU1DOpkOjlE4SXE1HwLY3TYrbkOBQ8h07qiEZVbufs9hxoN0EXmwcibNpNSg7khYW/ZV6IrhkQgdRInhWBX+VuA7QAJ/wtGtt5uU1yw7325+zOhGDidp0nCvbqyvtjuEJf6eRITBT7krByzwcSCEBSyPanSkYon6AIVPpS9uYQMVbThHklEGMnm0si6X0eT22/01Yk2d22g+OjdmUhbT8aSLeFi9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kjxQNO9z6Oa8HUpBf3sLfiY8x2NUNNz4aCo8SZMXPPk=;
 b=Xcjqh4t2iJnoTmUm2JmuNNE+fyxbK8fKPV1ttVw4QPCY5aiZKLlzO//1bXAWCgklUxicXJEfkZ4wEDTb8Sp37gMEz7u1wLnazBqj3HyF2P2RZIu+bHe7qP97Gl/jEpaI9WTK3Jk9RP7rWwx8WwGd9V+csxuI8VVcRWpbaaZvXMJ/mR6HhqH9fOCsj8Ob3pKrPFqsmtHCh5bPlP1MKEnkv2rS+bgt4vZ+BX0trBhtybH8FJMi2GuTK7quq97VAAPY0A0OQO6hZREybUdPJ1t3Uq0dfK4vBIEeLj43KWpEWaHksiSuqeNMKJ5kkLqusIluYQVDYbGvH36GvoobRmZGIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kjxQNO9z6Oa8HUpBf3sLfiY8x2NUNNz4aCo8SZMXPPk=;
 b=p4Lv01VFEVFWwVmmAhHroc9USaU0sQDFgj+dUstqL6hRuWzGYHOwCDxLj2thp9fVYiTqpPFTybCVCuQ60PO3hhp8bjpr6ysdHnkz4ZLeslV/2H8MD8WgcOPJ93Y22rNsbQV0eRpqZ85CutMi9aODDxyjtGbiU1ailXG/ja4cW+8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2810.namprd12.prod.outlook.com (2603:10b6:5:41::21) by
 SN7PR12MB6929.namprd12.prod.outlook.com (2603:10b6:806:263::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Fri, 17 Feb
 2023 12:48:05 +0000
Received: from DM6PR12MB2810.namprd12.prod.outlook.com
 ([fe80::b84e:f638:fa40:27ef]) by DM6PR12MB2810.namprd12.prod.outlook.com
 ([fe80::b84e:f638:fa40:27ef%6]) with mapi id 15.20.6111.013; Fri, 17 Feb 2023
 12:48:05 +0000
Message-ID: <fe100597-26be-23e4-bfa9-f45aa27b7966@amd.com>
Date:   Fri, 17 Feb 2023 13:47:55 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [RFC PATCH V3 00/16] x86/hyperv/sev: Add AMD sev-snp enlightened
 guest support on hyperv
Content-Language: en-US
From:   "Gupta, Pankaj" <pankaj.gupta@amd.com>
To:     Tianyu Lan <ltykernel@gmail.com>, luto@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        seanjc@google.com, pbonzini@redhat.com, jgross@suse.com,
        tiala@microsoft.com, kirill@shutemov.name,
        jiangshan.ljs@antgroup.com, peterz@infradead.org,
        ashish.kalra@amd.com, srutherford@google.com,
        akpm@linux-foundation.org, anshuman.khandual@arm.com,
        pawan.kumar.gupta@linux.intel.com, adrian.hunter@intel.com,
        daniel.sneddon@linux.intel.com, alexander.shishkin@linux.intel.com,
        sandipan.das@amd.com, ray.huang@amd.com, brijesh.singh@amd.com,
        michael.roth@amd.com, thomas.lendacky@amd.com,
        venu.busireddy@oracle.com, sterritt@google.com,
        tony.luck@intel.com, samitolvanen@google.com, fenghua.yu@intel.com
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-arch@vger.kernel.org
References: <20230122024607.788454-1-ltykernel@gmail.com>
 <fac62414-06f9-0454-8393-f039aa30571a@amd.com>
In-Reply-To: <fac62414-06f9-0454-8393-f039aa30571a@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0061.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::18) To DM6PR12MB2810.namprd12.prod.outlook.com
 (2603:10b6:5:41::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2810:EE_|SN7PR12MB6929:EE_
X-MS-Office365-Filtering-Correlation-Id: 55e86118-d418-4208-8cd2-08db10e53690
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: chPRdne3POwVDczwtQ97K7WXc9rihAJbmZ/Qvm/p4GcnQ/ePapMj1F1wWel4hfmOV6K00fZuIo/VGnx15Kav4eGcG9Mz777Yk6bjP3X2Defx3ZlPeI/a/urcweqnGG3v888EOIkzS0QcR25Bj3ppUE1423ACyh6o1wYoPzZZkqaTIf6bWm4960u4XTgmmf7rOaHK18nQ/x5ZTMxD7+ivODC4Q85Gm1VNTH/9z5Kg8ynLiEx5c/06A4d3AdSY3mCRMaSNPQ/HWMjjN2vD5FZl7v11P788ik0V3p1dvuLCT38/zyIT+kgbSSLzt+OubtkuzYn/xWQNLxho97nl0KUnqw0wsYT49IeFsVUxfyDen4PpOd910t99F9zhrcSXCCwgiOUi70rRuPmIHNY9FwFr168tiCuB/W/r0UyPnevw8XvC/60w7EUQY4Cd13jFoMVmBrMLYqKLGKX+Sgc8sZxoOjsZU8nLlpDRm5Da36zZRZsQ2xdamIEdDq+9XSbrzQNF4lLy74xis4jzXiOcXci6gCBI6IC9cKgrobDZ4Pc/oIT74sFIOjFx53U4/VcnUSoLrKHtlXyZeA2Kvde+vHJZZN4uvZmPr4GOmhq3CMs9kKzh0HAylMhzfSPEulUhIQPeTohB6RB0lY89lL90Dh/tekcHNfK9MgZvhauwGE3UGpgfQ0ygHSc69GUOvv/njufNJBZz+1fA5TzQ1oE34iD6Uo8zIeZ8KB3z02NWX6/i0JiRIJ4uEh8yoHpuzGgM5Pxd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2810.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(366004)(376002)(39860400002)(396003)(451199018)(8936002)(316002)(921005)(38100700002)(7406005)(7416002)(66476007)(4326008)(8676002)(66946007)(5660300002)(6666004)(41300700001)(2906002)(6486002)(66556008)(2616005)(478600001)(6512007)(186003)(6506007)(83380400001)(36756003)(86362001)(31696002)(31686004)(53546011)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WmlScmxlQm1hdFlrQmhLSnpLR3FXTkk5VGVxd2tkbitHTndhY0I5ZTZXYWpn?=
 =?utf-8?B?ZmJ5b2dOVk5UTERrRm81N3MzaDJzemxjd210c2FPNTduQ1NSekw2VU8vSWpD?=
 =?utf-8?B?bkNzTDVWWEhJV1FLZno4MTZpMXNiZTlqT2NwZGsxTlBYWE9RUThLUlR1T2NR?=
 =?utf-8?B?NmczdGlJWGNRTmMxWXVIakJIRllqVEFBU0xNUUxUV2NNbXJxNnQ3aGowTzJa?=
 =?utf-8?B?LzJnZjZKSytFT2ZDM2NkRC8vbjFKOENsUE9Ea1FTaFpNUGl2OWRTRnlXREtH?=
 =?utf-8?B?a3BOdnZjcnlteGJVYk52QW5BYjVnai9xN0IrelJjRDJ3ZTZnRloxeGEzbHlX?=
 =?utf-8?B?QVZsQmNoRFFVMmlYZXJXMVZqSDNVQ0N4ZmhBTmpnZnNackw5RGJwR3Zib0Mr?=
 =?utf-8?B?d0YvVWNnRXlhYzcxTlhERitUYWZFTVlxLzdaUldnZjJnNXJpTnJKUWs3OFRB?=
 =?utf-8?B?Um9HRnN0dkd3VWJOb0xBcEwybXh4WlplWi9kZ3FFUVo4MWNaR3JuR3NqN0RJ?=
 =?utf-8?B?czU4T0RKTkZYUTlUaDFaTW1tMDNOZnFWTUlUbDFKQ25mNm83cktTa1I4QmRJ?=
 =?utf-8?B?cldvMFVBbElCcEVQRXBHNTJFaGZpUHRLOWcwZFVBNFN5ZjNzYjhvQnNIY28r?=
 =?utf-8?B?eWZobWlpc2kwb0hnWTlIeUFaVi9CcXFuODllZnU2TitxM082Y09qSnZ0NVls?=
 =?utf-8?B?QXJGc3BzU2lyRWkvWW1nWmRBb3R2cjM1blJQV0JWMUxqSXVFQkswN2xKTms1?=
 =?utf-8?B?Q3MrMEdpSEh5d0ltWDE4a3JFakNDenJHVHdFdWxWcU1VZjQ2N0NYRUp6ZTJW?=
 =?utf-8?B?SWx5UlY3d3dZckMzR2paT1loT1pRRWlFcnNETDUzUVE0dXc3MEplYU5QcjJo?=
 =?utf-8?B?bmFTNXZ2WTNJRFEvOUdVbE9TaG1teTc1RTRLYndOSGN4L2tpbEJ1eUt5WWRY?=
 =?utf-8?B?R3kveGo5eEZnZ25wcWZqRG9wVmk2dTM3UldaVXBwMllyN1pxb0NER2Vwa1BU?=
 =?utf-8?B?M0VHeWVZQVQ0d045Wis5bVMxd0VORlpubUtFQXEvZy9EZzZpaVpwNERLMFRZ?=
 =?utf-8?B?NjFwbFkrcVM1ZEVFS2VkU3RKYWZLK0tPMmdJN3k5Z2xncXMrY1ZyaktjdXBi?=
 =?utf-8?B?WHIvQmxRbUFJcVo3UlFsN29oQkFUQUJHY3pFeXNJU0VDc0I4MnlySG5MMW90?=
 =?utf-8?B?TmxxeWFWQ3BpUVplWmNGVnFzL2k0ZUhDd3FIVHhyQUxWamhUek9GQXJNd3E3?=
 =?utf-8?B?MFJMZi82MW5uZkhqYTUyUnl5RmpJQS9MSmczWXh3eTJQWGZKVldQeUUzamQx?=
 =?utf-8?B?eDAxQ01CSURjbmRrZmNlNm52MkFtcVI0Z0RMa2c2RktxOE9ucjNpV25hVkt5?=
 =?utf-8?B?bWxJKzNzZ0gxVHdZdDN5MXBSbXdsM2NGSlN5c3JENXJhRitLdHdJTmNuNVJW?=
 =?utf-8?B?VENPU2lWNVkzYVNkZHY2dFdpYTJHWmI2VDBmMmlCTDh2VXArU3VmcEpkcFpQ?=
 =?utf-8?B?aHFiOTY4ZVExS2lUM3VXOXZFTXFRdHhWRzQ5TlFXeUhGS1RpNDBvTXBsVncx?=
 =?utf-8?B?d3BMREJaWURhd2FJVHRway9BS0F4VE1UaXE3bU8zYUZqWXRBckoyNE1pVmha?=
 =?utf-8?B?YzNtQkNoMUtUK1IvQzUyUWtYWlNoUTB2S2hJaVRPZktmVko2K0x3S2VST2J6?=
 =?utf-8?B?RExCWjV4ZFV1S29FaVI3NWtXYmxLb0NiVzAycXZ3Qkh3aC9yakJxRXBLUlZN?=
 =?utf-8?B?bHJqTFJUQzhVZ1EwTXk2M3BLZGM0ekowMkMrZ2JNclA3TUJ3Y01jRFFmQzly?=
 =?utf-8?B?MFhUWUs4WE1kTGtySlNxSEVrNDBQVEdaSHB3aktseXF4YjFzdVZqZTZiMXFl?=
 =?utf-8?B?b0JIYXJCMzl0K2NpZGh4M3R6aFBjeHZWazBuYXpHTWRnMkhSOHQzRGdudUJy?=
 =?utf-8?B?NHlHSVRXc2ZRdHQ5MzJwYmprU09PM1BnbXhRSGhNWG1NaGk0d3BiWTJwMjNE?=
 =?utf-8?B?d1NzVGgyME9YQjRVc0FKcjE1RlNpam1aWUoxTUl3SEkyWGxxY2pQT2Zyekhp?=
 =?utf-8?B?RllZUnprU1gzRVIwQlBSeTFIejdlQlFpUWRLQ0twSndJTkRuek5PRjVkK2k1?=
 =?utf-8?Q?vLn2qYtuiaeY1Xp/wf2wbu0n/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55e86118-d418-4208-8cd2-08db10e53690
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2810.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2023 12:48:05.5648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pxJqfb0S5MipARuelXSuEdWTCICAw6s34T8EAHuYpUMkNb0EAzoqW8mLG3DZYgIGa0M8AKir/Wb0nhFO/aTq3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6929
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2/9/2023 12:36 PM, Gupta, Pankaj wrote:
> Hi Tianyu,
> 
>> This patchset is to add AMD sev-snp enlightened guest
>> support on hyperv. Hyperv uses Linux direct boot mode
>> to boot up Linux kernel and so it needs to pvalidate
>> system memory by itself.
>>
>> In hyperv case, there is no boot loader and so cc blob
>> is prepared by hypervisor. In this series, hypervisor
>> set the cc blob address directly into boot parameter
>> of Linux kernel. If the magic number on cc blob address
>> is valid, kernel will read cc blob.
>>
>> Shared memory between guests and hypervisor should be
>> decrypted and zero memory after decrypt memory. The data
>> in the target address. It maybe smearedto avoid smearing
>> data.
>>
>> Introduce #HV exception support in AMD sev snp code and
>> #HV handler.
> 
> I am interested to test the Linux guest #HV exception handling (patches 
> 12-16 in this series) for the restricted interrupt injection with the 
> Linux/KVM host.
> 
> Do you have a git tree which or any base commit on which
> I can use to apply these patches?

Never mind. I could apply the patches 12-16 on master (except minor 
tweak in patch 14). Now, will try to test.

Thanks,
Pankaj

