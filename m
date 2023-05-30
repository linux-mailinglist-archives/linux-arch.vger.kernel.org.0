Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A43C7715ECD
	for <lists+linux-arch@lfdr.de>; Tue, 30 May 2023 14:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbjE3MRR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 30 May 2023 08:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbjE3MRQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 30 May 2023 08:17:16 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240C4136;
        Tue, 30 May 2023 05:17:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j53rtlWihx5vVUV2YO2XLdmr3qkGTJXQqdgEp/AwPBPWMsOwaULLj7+ObXuJ4GVuYcSe7PKTL4mkMex4CmlNSqNgiGkLumwUKUzNopNMa9yid+32X/gEuMhbTtONVLSKq9FKi/Nzd8cdOXN3gCdDxObEXNr3vdohDr4FtN1Yz5I49KwZCM2rWgT7WOtpMhBUc44p/XOTXqRf5tHEtDKDnVPf9TSWHmwLvuym52QBEhYcMWfWYRsQ3P/S0Gupw0LpFZ/v1+e8HxM9ZVQ9+3hSb2MLxaP+Z4JDp2lrf5oNYoxupDSIjh9bWlrfWAucPwL8VwUNATPNNK+uRCxQezAN2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QNQVhgg44HLZp6CP352q6L7RMlhsZtae8G/mtt2Y4ZI=;
 b=EqMRYZXxxXBd4+hkYwbnv5t/0Sre3ua1s31nwZSJIG6pkF1lQrnMpI9aKHheBhFS39+wZwtks1dk8HSsgXVnk3X7NWLmYy+DVRfz+ETInk9SvDOxxsOxSZ9XbQyGANHTNhCyOC3BYsTlLxtYJDYnvPXSRPr3cgZMa6L1gKO/BvMse1ABv84HxQlLTeGF6w9HkvS1zGQth8ELHsvkxZtG8IGzrl1REy++jTf0tbcsp4Fr4ULOGsVGsNelkJYjN3SKwrc3WDbk2MO2g8hT99QVdNIIjnuD5LIjim6wb0+WkkxPjpbSzb8NINpwxblX2t0v1UEpkppxPM+fFInwCrJfQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QNQVhgg44HLZp6CP352q6L7RMlhsZtae8G/mtt2Y4ZI=;
 b=ri1ee7APkLMoRiQ8C2VjvQQCHsJyxQJeTH4/oKLGcPUgASbHD73Xu3TLRTk3oILkUjQ93PHuH9YMmS6dsGDo1jO76wvatf8WEvZX2e2I19W3IvGri7W5qIHk77w6dN2actFI6Vfp0Wx2jtrtxo8m81Kylj2JcUsUHQiH9qovDXM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2810.namprd12.prod.outlook.com (2603:10b6:5:41::21) by
 DM8PR12MB5493.namprd12.prod.outlook.com (2603:10b6:8:3d::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6433.23; Tue, 30 May 2023 12:17:06 +0000
Received: from DM6PR12MB2810.namprd12.prod.outlook.com
 ([fe80::6220:7985:a611:c053]) by DM6PR12MB2810.namprd12.prod.outlook.com
 ([fe80::6220:7985:a611:c053%4]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 12:17:05 +0000
Message-ID: <d43c14d9-a149-860c-71d6-e5c62b7c356f@amd.com>
Date:   Tue, 30 May 2023 14:16:55 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [RFC PATCH V6 01/14] x86/sev: Add a #HV exception handler
To:     Peter Zijlstra <peterz@infradead.org>,
        Tianyu Lan <ltykernel@gmail.com>
Cc:     luto@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, seanjc@google.com, pbonzini@redhat.com,
        jgross@suse.com, tiala@microsoft.com, kirill@shutemov.name,
        jiangshan.ljs@antgroup.com, ashish.kalra@amd.com,
        srutherford@google.com, akpm@linux-foundation.org,
        anshuman.khandual@arm.com, pawan.kumar.gupta@linux.intel.com,
        adrian.hunter@intel.com, daniel.sneddon@linux.intel.com,
        alexander.shishkin@linux.intel.com, sandipan.das@amd.com,
        ray.huang@amd.com, brijesh.singh@amd.com, michael.roth@amd.com,
        thomas.lendacky@amd.com, venu.busireddy@oracle.com,
        sterritt@google.com, tony.luck@intel.com, samitolvanen@google.com,
        fenghua.yu@intel.com, pangupta@amd.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-arch@vger.kernel.org
References: <20230515165917.1306922-1-ltykernel@gmail.com>
 <20230515165917.1306922-2-ltykernel@gmail.com>
 <20230516093010.GC2587705@hirez.programming.kicks-ass.net>
Content-Language: en-US
From:   "Gupta, Pankaj" <pankaj.gupta@amd.com>
In-Reply-To: <20230516093010.GC2587705@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0005.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01::13)
 To DM6PR12MB2810.namprd12.prod.outlook.com (2603:10b6:5:41::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2810:EE_|DM8PR12MB5493:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e67db6e-83f2-41aa-ddfa-08db6107c822
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +IaidBle5usX3k3lymGHVmqNf02YJtjr3ETThVJYg8Dkm3CrrSN3UejchDrfmZKE2Da7KZ8CuIjPiYjwTl3+vQLyD4+fFrjvps0y5o6yv5G+ioH8E2eVRFhoEguuaMRLRQdo9yW4xGofE+C9Oj2QngJph/N55l7ueKq7/PWmnHpDCnsWDBHy1iBOyyJx+40MqoOUpGmVAD2dya8rasXFlDhLjX41hgoxvJbVlo5KkhFZY4h51LsgPbzFyg2gf3eKm+bku7hygH8mUUYtKygdlL5McHShpqWDVMDaSDTSgufqNm4VqLPcefEUSooli4n2k0+01Z+L2X0kC1ucHH72W09b26gOAxxnkVe5SEW6Oad/b2TasLLhAnUAEgjEXKs+4+TlEtqUAiJbpSsfBkTfg6urSh8IdanZZ1b6hOurg/beyA7rPA6HMYEaCMYp+9dkVO9nmKkLMDs1JCBIMiCkn09Va1nclnsWuVGJcTQ+Brl1DhXmVcRPpgvDJ3aYAl7/5V8VmHhYZyV/p/OifQZTjx9L6B/jZ2YvGOPZnKhOsBbtbR7VO5Idfet6xMhjzWKKw8AUNbJ2lguII2zio6u9tx5lXCxXH3DBFp0D8TSyHz6B2If5dHhjSSItfteSBi+C+/ron3YIabyPk6HFE6e0rQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2810.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(346002)(366004)(136003)(451199021)(478600001)(110136005)(8676002)(5660300002)(7406005)(7416002)(8936002)(36756003)(2906002)(31696002)(86362001)(66476007)(66556008)(4326008)(66946007)(316002)(41300700001)(38100700002)(186003)(26005)(6512007)(6506007)(83380400001)(6486002)(6666004)(31686004)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a21HbFE0eXRGQWhZUXpBRHZUMVZYVWIzaGpQVmtwNTAwVkFtVTluK0JzMFh1?=
 =?utf-8?B?M0lMNVpRanFrU3RKOTlvanZKRStha2Jwb0xoY2Zpa0xpblFwMU1aL2gycTBy?=
 =?utf-8?B?V2tWdThyRTdlaGJzb2FUc2NhVVIzVkhuZ0JWbjJtQ3U3VUFFSDExVjFZQ1Jr?=
 =?utf-8?B?T3FnRklybnJHNklBMFl6Mm9MY3RxTEdlT1RyUUVPSWoyUHZyOWMvQllpZGky?=
 =?utf-8?B?Wk53QXdiZW9MdncySUxBbFE4YUZDMXRkUVA4ck9mK3pwdHRic0JWUEhMQmZu?=
 =?utf-8?B?MTA4eVpPRlVjOWN0VEF0ZFN5bDBvRnI5UkhOaUNMTFJYbDZiQkQyTWhCMy9j?=
 =?utf-8?B?R3RvaVNxNlFDTW1CVEUrSHliMk5Ia0VuUzdXNG81U3dYWGRGY01zbDNPeks0?=
 =?utf-8?B?TExRR0pGODZVSFVpSk44UEJyNCs2RStaalBleEtCdG1ITCtLU0ZmQy9qSy9i?=
 =?utf-8?B?b3NQSjBpMHVHblpJYVdXRTBwTUxkVW56OUIwLzFhcTlEWEtQWGRBZjBpTW5T?=
 =?utf-8?B?Sit5SWxIWktqVkZQUHpSNjFGeU8yRjFqamdBVGdoT2tvNzdvWElFVGhRVGhN?=
 =?utf-8?B?OUZlMVh2ZTJRN0NzK3VmRTBHRjVtZCtrMjdjVk90R3BMOTRtOERsNGpmNDd6?=
 =?utf-8?B?eDJyTEp3Snp0NjVHSUlmSGt3L3hINWxFV3lCRm9QdTk0U0w1eTJsVXd2VTU4?=
 =?utf-8?B?WkQ0VmxhMjRQeUM5VzZVdFpBRjQvSHJESWlSRGNxVTBqekVKNnM5dGZwVDV1?=
 =?utf-8?B?UTF5eHZNZDY0UGs0WEsrYUgvVExBTlEvSHMxcy9yaFp3bWhWYnh2SnViS2Yz?=
 =?utf-8?B?MUJVMVhiVk40QjZnL3dSZjA1dDliaTRldmU1Z3FBRmZua0JsQUVJdDZGUjkw?=
 =?utf-8?B?WHFFUE5xNGR0V2ZtSnRrejZ3L3pzQzlqU1BVMzZRWmU3aHpxbWxSdDAwWW5Z?=
 =?utf-8?B?dExva0ZBRWVKSXNOTVN5cEgxT01ORG9HZklOYnFCUGQ3U1VPSUhjN2xtU2hq?=
 =?utf-8?B?dkJlMk5ObHAzNnorcEtBV2g2MExwOVBPTGV5TnVjLytLUlhLa3h2bmcxends?=
 =?utf-8?B?TWVXYkF3RVRDUFV6Ujc4STlVY0VaY2IrYmtxRHREeldxZE9IRTR0dENMU0xo?=
 =?utf-8?B?aEp3bkYzTlNnUW1WUG9BZnUzYis1ZWl6NXJ5bXB3bWUwd0NIYVc0aUUvaENq?=
 =?utf-8?B?WXdDL0U1WlNNb2MxRDNTTERZanpHdTcrejArSWQ3R1VlRHRZeDFsR0FoOEx4?=
 =?utf-8?B?NEZzeDlsUkRVZ1RncU0raFJoYlpjc2FYZ3FTTHpTWFM5TDNhb243V0o5Zzlp?=
 =?utf-8?B?bjY4ak5xeTNrUHV3ZFhWaE02aENIOTNKeFdmNjFZWW4xM2VodkM5cFg2Q2hR?=
 =?utf-8?B?TnIvK0ViRUlTY0crZ0tRTXpiL3BreFRacnhiRGFXSHVubXY5Z1ZHWUJna0wy?=
 =?utf-8?B?V0tPQVhWZEhHZlBZNFpvM0NiVCtsTDJFU21kUld5d1lyYlRyYzZLQ0g2ajI1?=
 =?utf-8?B?SGx1d205QjJkZEl0MFVjblVVZEduZkpIUlJLMGJ3eGgxeWhtUkNtZjBZbTNM?=
 =?utf-8?B?cU5tY05VM0tmbjhRb0w2RHQ0SmN3Y01ZdWxjMFY2TU4vd2pWVU1IdUxYZEov?=
 =?utf-8?B?bTFJOGI2d052bkl0aWV6bXNEV0RnNXZYcTNMSmc3alR0ak1JekRiV3FVUTdl?=
 =?utf-8?B?U1Y4K3gwcS90NDlLMlVrMWh5dktMS1EzWjdpd1UrbXRtZDd0QVFFeE00czZQ?=
 =?utf-8?B?RStheCtidDM2RTZ5OCtvYTR1UEY3a044QVNUYXpaNm1HWVB6KzZnZHVKQ1kz?=
 =?utf-8?B?ZStJRFhQOWs1RGhtSEtVNlZ3b2ZUTjZJWHprQmR3UDBhd0ViUUpiSWdZRysr?=
 =?utf-8?B?ZThmWC9tZk42MHJTZ05va1A2UjZqdzk2dUpGQ1R6cjM1ZHQwMm00RUZLTmxL?=
 =?utf-8?B?TXhCdm9yQjA5WktRUW10RHlXWllHRmp2Y29EVU9ubmIxQkNyU09GLzQwY3Bv?=
 =?utf-8?B?d2twZjc4VllsTlpKa3NDOXFFejRtcXJ0Q0JNeUdaTkQwaUYzWVphc0J0UDRs?=
 =?utf-8?B?eFhUdFVXRVBtcDh3SmJkTVJLYTFPbjdkN1EwdnFZaWxnY2ZwVHZjR0tiTlBS?=
 =?utf-8?Q?/ReWz0cfZqNgqXJGmSr/1dQBo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e67db6e-83f2-41aa-ddfa-08db6107c822
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2810.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 12:17:05.6276
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2PRPKlCBtKM+O6naIUymFzhFM3kMO0FgiX6CdYrpr0c3LR3MtxVJyD9sTUAFPAmqtybfAGzJkyMSb+ycPZ2+7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5493
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


>> Add a #HV exception handler that uses IST stack.
>>
> 
> Urgh.. that is entirely insufficient. Like it doesn't even begin to
> start to cover things.
> 
> The whole existing VC IST stack abuse is already a nightmare and you're
> duplicating that.. without any explanation for why this would be needed
> and how it is correct.
> 
> Please try again.

#HV handler handles both #NMI & #MCE in the guest and nested #HV is 
never raised by the hypervisor. Next #HV exception is only raised by the 
hypervisor when Guest acknowledges the pending #HV exception by clearing 
"NoFurtherSignal” bit in the doorbell page.

There is still protection (please see hv_switch_off_ist()) to gracefully 
exit the guest if by any chance a malicious hypervisor sends nested #HV. 
This saves with most of the nested IST stack pitfalls with #NMI & #MCE, 
also #DB is handled in noinstr code 
block(exc_vmm_communication()->vc_is_db {...}) hence avoid any recursive 
#DBs.

Do you see anything else needs to be handled in #HV IST handling?

Thanks,
Pankaj


