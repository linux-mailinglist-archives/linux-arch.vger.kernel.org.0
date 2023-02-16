Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD7C469964E
	for <lists+linux-arch@lfdr.de>; Thu, 16 Feb 2023 14:50:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbjBPNud (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 16 Feb 2023 08:50:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjBPNuc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 16 Feb 2023 08:50:32 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A56233A84D;
        Thu, 16 Feb 2023 05:50:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y1skmKWXVUwcwrsx66ZHcn7Br7aUacI3xafhIu9iSF+rYIpsVL5EXKjGCYPfsvOHxUSufsbMtn/aCoI8D7Vi8kD5Pw9yRKUKMAjgdoG1WYLRW2Si32Xx5jhWIzFaNazLsuKOA5JRbz5uTPxiFAGLJaMP3fcjj7UrsawzDV/vSIfZH4Sppr3ndhaf/OAg0RnGPD9Zt9bVBKd3/NA6e2zHzpug1wZPtobDm1Q/z0lr+FeDEcUw+pyFK1kjCF4f2q849N0s4uTNifUTH2IG8qnTvT3Wvy3WsIoc6+beY6WSlvZpr57jwbKxroKZFRN/GZKp5AKhcFpF3Mf995YgZuGvxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v4SI1SJCtnyt5WolZKSrskU7dtzI72Gmt40UcwVVn4U=;
 b=KTXURWT1aSIFeQo0qF+hCd1TXOlqBpoQdJ8bS4N1UQcmiuTu/NVHuWTBf7ZneHfBcC16IfmQw5WkTFxdqjIgtykJAIV3LDLCTmlVlPvlmxH+8sZNwM+qXAOWHtOdWmZ7KVUXqtkqEkRoYdToXU/BpPUXn/RzrbzSm8lc/tOpFwWZvFXTS8NRuatDgKyxmnO+fVlsdnkDTUIiaWP/qEV62ytWX+ovU1RDMbrlh/uWqMac5id5wEvsTquw8WKI1BVFB9cgOid6QoL6aBamysikXbDuWuCPSabqm52IyAmbptlQkns0df8BzVtE8A98BzI6Dyq2KyjMXPyZWNOyRLntdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v4SI1SJCtnyt5WolZKSrskU7dtzI72Gmt40UcwVVn4U=;
 b=vkEIxQMmMGH1Z4FdKLfsMpmMx7bQEqHDEznMGo9IZIlkZvoo7Y3S47EMe5v+6g5/4v8SVlwFBGaxwOYJPQbrRnppKjerIjsAq55HlX/OKDD051Yk0kdTqPk6QqhmjsZ9YV3wqNxk8wtO+VTm9HNY7jvx6B+1nuhKXAmswCUujEg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2810.namprd12.prod.outlook.com (2603:10b6:5:41::21) by
 CY8PR12MB8299.namprd12.prod.outlook.com (2603:10b6:930:6c::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.26; Thu, 16 Feb 2023 13:50:28 +0000
Received: from DM6PR12MB2810.namprd12.prod.outlook.com
 ([fe80::b84e:f638:fa40:27ef]) by DM6PR12MB2810.namprd12.prod.outlook.com
 ([fe80::b84e:f638:fa40:27ef%6]) with mapi id 15.20.6111.013; Thu, 16 Feb 2023
 13:50:27 +0000
Message-ID: <68b180fa-75ee-08b9-aa6b-2afeac860462@amd.com>
Date:   Thu, 16 Feb 2023 14:50:09 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [RFC PATCH V3 12/16] x86/sev: Add a #HV exception handler
Content-Language: en-US
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
 <20230122024607.788454-13-ltykernel@gmail.com>
 <0098b974-7ceb-664a-aa53-afac8cc26d47@amd.com>
 <7dbc845a-0ada-f97a-ba50-a6b2c31ee9c0@gmail.com>
From:   "Gupta, Pankaj" <pankaj.gupta@amd.com>
In-Reply-To: <7dbc845a-0ada-f97a-ba50-a6b2c31ee9c0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0112.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::15) To DM6PR12MB2810.namprd12.prod.outlook.com
 (2603:10b6:5:41::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2810:EE_|CY8PR12MB8299:EE_
X-MS-Office365-Filtering-Correlation-Id: 04595dbd-c509-46ac-d758-08db1024c29b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J+ALLHBTfNS3lQdPvw1TklHzXYtO8VjUcxxddHuDM4YPJDSaaFfiZNX4BQCMXnMd4k7cuZO0UqvwAZ1Capd1jlq7SClvNiOsyqArVbBgLpkxRLI+dvNi72tAJ7jqMf/UubTB2RSU4v5TnRcFoHXPmTK1KaoWmEDzYd9ajM8mH4JVepm7gp8cvLGKWEzf1r6sCln3SM0GWBp2DJofFkNBSMh8fybev/W4r9B68V/CRUdrm+qBdQg/msozJipTwO7bs6P6vh2LqjnQ45fkaRJ3NsYveq0Y8clA6TlWeee1+6lIWFC7r36LDXdo+7vb0upl0g0aVhCZ1EOyrxO+j4XwjIbpyp9f1bnhyLDXrKFEADuvA7ToZHooJySbM6kIRDvuvHAzSuUKCc7T5dAXRZFRta3xwNoQoLTf5C+kWcU8BgHk/oL23Dk3jXRLoy5kOeiF9ZF0lsgZ93baQS3QodKOX+p2JYyms4toRsHCDAsp+RtQEyJymBIBxiGF2cYZJjpnIRYZBPQYaeTNR70XX3Pk9s9k6TWmGM9D5nMwuJ9rnYlpT4SuijgFW7sGJ1yf3icRjwC+Wk/jIrtc32OT1ezWbXaRu+A1VewDCrBqHMRPPZpTJruHfw4XkgVmlDwP90pPjRI3MfOCfmfurIXVpdD11GKMh2qCfIv7RpSm5lzvbqKBZPY/n62Pp0R3d/uOdpAesYY/Q1xJBEe3wOyGvK5TXgteFzARQbnXjFuvPxeelmn0LmBPirywdBBiSxupcknc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2810.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(366004)(346002)(39860400002)(376002)(136003)(451199018)(31686004)(8936002)(36756003)(86362001)(41300700001)(31696002)(66476007)(66556008)(7406005)(66946007)(8676002)(5660300002)(7416002)(4326008)(2906002)(38100700002)(921005)(966005)(478600001)(6486002)(316002)(186003)(6506007)(2616005)(53546011)(6512007)(6666004)(26005)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mm4wQ1Yvdk5MODdSWUxEL3FlcmNSNzFjSXZaMWRUa0tIeHJVeTFVUFZQeFE4?=
 =?utf-8?B?cmwvaVRScWsrQWFBNGpibGRwVCtmM0xjZnhPR0NBWFBBVzdieEpxSnVFNU5V?=
 =?utf-8?B?SUtEZEdiUVhMd2h0aWc1QVo2bkRoWkZqaUNKVjNXcHlaQms3VkdXK1RBRHZB?=
 =?utf-8?B?SzhVVlRNSWl2VTk0amViSmJmZWh5ZTZhV3lYdGdLd2gxNU9ISTdWeUJTa0dQ?=
 =?utf-8?B?YVdBOHBjeG9OcXQrQTVxaHhIdlRWbDltanNYcmtGUE5jbk1ERnNWdHByaFoy?=
 =?utf-8?B?eGpwMGF5ZTIvZFRuUVpiMy82K3M0bjVtaEVuRkd0QWlvV1hhcWxyQS94Si81?=
 =?utf-8?B?enRQQURCd01hbWlBVkc1MytLRTU3WERKWFZDZGNLZDBackgreFVRcGpsMHc4?=
 =?utf-8?B?djVvL3hUL2Y2NEdlS1dveHZ3S2JlV1B5SWlsM1pMWm5rMm93dWVFbkRDakxn?=
 =?utf-8?B?UnViU0UwSDRCZ1pSR0FWdVRNKzQ4Ym5Xc1ZvT0MvTG5DS3FqZjBwZkFDOXY5?=
 =?utf-8?B?c1M1Rkc0WG1ocVVwdEk0N2cwWnVLRVc5REtGTEYrcEV0WDZNNnBTQVdvSlhR?=
 =?utf-8?B?Mjlhcm10NnUzbHh4S04yNFM2cktaVy9vd3pIeGxHVnF0MCtNYkk2cktFSnhK?=
 =?utf-8?B?NVhpSjhWMzN0cndhL3VDTk9aZEkxWlB3Y01sV2FKT2hLVDVzREZpZVRTV2hJ?=
 =?utf-8?B?S2lLTXhiZ3k1TkdIZS9RTTI4YjNvSEZzSDVhWndiOFRxWXR1RU5VZ3UzK2Zp?=
 =?utf-8?B?T3RVK0JDYjJoL3hDcHN0RVRCbHhMcGpFMHZvNDY0UEE0RjFhclpQVEFLTzZo?=
 =?utf-8?B?alk4aTRaK2s4M3BJNmRxMGh5VjlBTFRJWm00V3NyVEJienYyb3FhcGowTS92?=
 =?utf-8?B?ZEFrL3ArbEg1UlVlMldSYVpxclBWdTVKQjBjL3NLRHl0QVdKOEFHN2pYME1R?=
 =?utf-8?B?b3o3TFdVYUkyMW9obkZURko0ak9FdmE4Z1pHMzZVZ242Tjh6SFd6aE9NMmdW?=
 =?utf-8?B?ZTcwdnFCQk5uRzB2RHZEQ294Q0xGSFVDZ05FbHpKaXZhSCtsblovZjRRSmhz?=
 =?utf-8?B?dVdmYjZLM3ZWendNRzFVS2hFMG5jL0U1UGM4RTgxVGl6UTRwWWwzNjNjQy9n?=
 =?utf-8?B?RVF5VGFNZmgwdFdsdk0yNXNpbTlBSmZ4UEtFajcyTlY0L2lnUlEwc3BzOGti?=
 =?utf-8?B?QnVzMk5qSFovcHZNYUtRU1pEUzBObjdGMC9wZ1VkWEZuRERKSExya3dHeVRN?=
 =?utf-8?B?ZmtOZjA0RWlodmdTa3FkSmdxNjVEVjh6NTNBb3UzNHhKWVRSZUVzcmUydHMy?=
 =?utf-8?B?bmVxaDR4emJGbmJSTkh0UXZXMTJTdFh1b0tzeHpkSy92MGdPaldoNXBMWi9T?=
 =?utf-8?B?V3dnbXBPemVEQ0hQc3pOTVcwNWFuOWtyU2dKMzVOdFNqN1V3b2I1dGxncEpp?=
 =?utf-8?B?SjIxU3dDNWc3aTYvTFlpWXdJaVVQUEhoaVY5UkkwRmQvbUpOUEdTYTJuaUVF?=
 =?utf-8?B?TThsT0F6YTFPY04vTEJod1gxajk1T1RiMWREMlprZzB4b28rR091UlBCUWlh?=
 =?utf-8?B?VzVmU2JZS2NCQ0RFeFF6eGEzNHBJb051YVg1aTlGWHRnbHVSQzBUY1BURW51?=
 =?utf-8?B?c0kwU3lBSklYSnUxRmFNYklQRVhxVlVyZkJmQThxYTVaWDZJV205NUJWWEFW?=
 =?utf-8?B?WFFacGpjZHhsTWhEbGhrVjVIZ0x6cDlUZDJtN28vQ29NT0JLeEdORE1vRUpr?=
 =?utf-8?B?LzlrYk9hZVRSQVErWXZPNkp4UG42cW16VlNXM3FneHdaQW5TY2lsblAxTUxa?=
 =?utf-8?B?T29hQkpjdmtDK01pSktGQlN1OTB2a2NHNmQ5aUl3OVZ2cW4xZVBxNHd4WGFD?=
 =?utf-8?B?Zi92U1lBTTdSdi9XL29LazFSbzEvbUhYZTRNS2JZdXJlZkgyUk9yNHJsWFRr?=
 =?utf-8?B?V05JVk1SWDVGUHVVK09YOGNianZoNnVpZVg0Q3pieDU2S1lHYnhvb0J4Um50?=
 =?utf-8?B?RElnKzgrcWZUdTE5Q1U4eGViR055TW5uVTFIdHozVjlDYkttR0NJckhBaUMy?=
 =?utf-8?B?YVhhYnFGb2kvOFB2NktOazJER0FTdThjVjBTVzRqNFQrOTQ5b09zbGRPbUls?=
 =?utf-8?Q?51PAcgqE1DEKtJRWSjyHwb5Yo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04595dbd-c509-46ac-d758-08db1024c29b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2810.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2023 13:50:27.6198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MlM0IUJRUfU+j43OvxszZ/Gvh7z0Y5gN8+uJn+8wgTGfSKYMMDefYFiH/AVhOHwUOrRpY/H9PVq+4sH55Gb1tA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8299
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2/3/2023 8:27 AM, Tianyu Lan wrote:
> On 1/23/2023 3:33 PM, Gupta, Pankaj wrote:
>>
>>> + */
>>> +.macro idtentry_hv vector asmsym cfunc
>>> +SYM_CODE_START(\asmsym)
>>> +    UNWIND_HINT_IRET_REGS
>>> +    ASM_CLAC
>>
>> Did you get a chance to review the new instructions
>> added at the start similar to idtentry_vc and comments
>> added assuggested here?
>>
>> https://lore.kernel.org/lkml/16e50239-39b2-4fb4-5110-18f13ba197fe@amd.com/
> 
> Hi Pankaj:
>      Thanks for your reminder. Yes, CLD should be add after ASM_CLAC. 
> Will fix it.

Also it looks ENDBR also needs to be added before ASM_CLAC? as I also 
get this:

vmlinux.o: warning: objtool: asm_exc_hv_injection+0x0: 
UNWIND_HINT_IRET_REGS without ENDBR
vmlinux.o: warning: objtool: ibt_selftest+0x11: sibling call from 
callable instruction with modified stack frame
vmlinux.o: warning: objtool: ibt_selftest+0x1e: return with modified 
stack frame
vmlinux.o: warning: objtool: def_idts+0x1d8: data relocation to !ENDBR: 
asm_exc_hv_injection+0x0

Thanks,
Pankaj

