Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1228C6B4B7D
	for <lists+linux-arch@lfdr.de>; Fri, 10 Mar 2023 16:46:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232398AbjCJPq2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 10 Mar 2023 10:46:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232414AbjCJPqH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 10 Mar 2023 10:46:07 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2047.outbound.protection.outlook.com [40.107.100.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB0110FBAA;
        Fri, 10 Mar 2023 07:35:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LHvWLrhpLrjn5vabEvd7qd4MJg00s5gTXCtpjEfsEkdKVYHLS44zv1yGfHi9r4Z+oLYkyXZndl0pfVqiYabytUoeeVqUoqW1E21WjVNmc0YZ9lUuJ/yS9iSr17PnvPeqRoSmpMuVWRJtBHAoavFhiz31HCh0ruOfHuKE4Ak3MtvPQ88otgVwoacSuJtrIcFPC7j2b2cpIWbtox5WXwrWYrvimVEUiVEbDGjApDXmuPZbJagaa8do4lUKzOMuGtrPLmnbqXnMJ3xcdiFCXmiVcIZrfPDhuFVOpLHMnB7G6UIxF8g/Z4YDWm0nPFJNznFDNo8lyoXMcrPV3Vin5MnTAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ls0Upm8UY9iZYdkVMTe2ZbfgjcFeetYQuUpXa1VQkNA=;
 b=JS23DP8v95RSjx7qEh6lpd9Ko561eQrQFDt85gL7EYg5Hv/9muHCtnmx1TZl1NVLXM/37OmHhMF/Y6BQcZZ/dOF7blZpQdT2ixiQ1p8oeptHM71n3BCQAemuzLCIObbuBVFpN1KzrFPpuNFlpWlOYiqEaLrmw+CrdXOuDdwLAO3U6f/qDBbLEW/6cysDdLAL5KZ8Uf8P/6L32QZBHwS6NBw3W7Nq/X/5xmfTTGx07q3vqD9cCqFrJSAbLMsuYXebbdob2KdkWLMP/aYPdh15smCD0cDvcu7+dnxJvBV7GcDtu0fsOuv1y9U/4IIaA8nz55Uv4zyRJWZ+u7rnykFgqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ls0Upm8UY9iZYdkVMTe2ZbfgjcFeetYQuUpXa1VQkNA=;
 b=ivSl4OWMLSyqoBLYjtWDGYPV1tw6Eo4yqLPsMd/RWl42akolyZG1e4DoDkvTmRqlJAXs1dApdXNciUeMQM9cO9V8HUcuarFhpRtUefzq3PaF6z8N2uMk4wTuAwajGeH9t2ByBCfe/+cPgFGQbNWvISDFk8QXX0dZD+pKGh0cX0g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2810.namprd12.prod.outlook.com (2603:10b6:5:41::21) by
 DM4PR12MB5867.namprd12.prod.outlook.com (2603:10b6:8:66::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.20; Fri, 10 Mar 2023 15:35:50 +0000
Received: from DM6PR12MB2810.namprd12.prod.outlook.com
 ([fe80::bad5:8f56:fc07:15cf]) by DM6PR12MB2810.namprd12.prod.outlook.com
 ([fe80::bad5:8f56:fc07:15cf%3]) with mapi id 15.20.6178.019; Fri, 10 Mar 2023
 15:35:50 +0000
Message-ID: <0a968926-670a-c383-492d-52c45b09bb18@amd.com>
Date:   Fri, 10 Mar 2023 16:35:38 +0100
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
 <fe100597-26be-23e4-bfa9-f45aa27b7966@amd.com>
In-Reply-To: <fe100597-26be-23e4-bfa9-f45aa27b7966@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0127.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::8) To DM6PR12MB2810.namprd12.prod.outlook.com
 (2603:10b6:5:41::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2810:EE_|DM4PR12MB5867:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f777cf7-18ee-46e3-06d2-08db217d203d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VUYo4l1fYcrvcLUu0P2N3TMoaU4SepB6D/nFio4nIMj4KHKWYmrJoyPpPjayfZ5eAvlT7BA2y4Hav0H3D1PDNbu3NUrx1oJVQoWqmQGqykc2x5ajGttn7dZVVaurnczotx8py9Ya6M5tESf+SEwr4MYu5RnHXO2rfLIv2e+T/k2ikAjlph/K1BrQXka21St4MqnwpGo2RBR3yrJf0SK29m+w8Dm0sXy988HhqYh+pz51nwrzrMc0LPwEc9hb3i/+ak4LvW9M59KQEDS+X0q09CqoL7oLj7wTYyikaKMARhbU0PmPPwACJskT1Vmn/Z+LLelHY1DbkIz0oYbOOvk/zkg5IMKBSbFYI71RILYLcx2dOTsnoG/HbdaYBZTwss/M8IPtrrl0A4h/D0rEJYMtUX3R+rbwPrOZdFekHhdFHNKr+Oyy2lnqSVv6Ttu4BzYYEIjs5o2fiE/O7HLoIKd2veSM6deG048HojODSjobVzuezF/sl8x84P5KuiSB5h9TFskOHx3/rFmifusXAjpu+JbKXKAB7CWDXDqYZRbbJ0MouvChfbvstku75bIFgYOAuEW0XZIoohNdr/zhJK1/zqy5HydUo7Jg6lJ0XAsrKtFWr1TZryuszqAK3OLlOZyb6t/s0VRtuL5kI7jMZZOgQzk/n1zmDdprmSSbaiJDEB5SenEhOG/YtNh73LJxGIqSYmbIDjJSxS5JM+RODWHLU7BS+jTrFlLwcB1gulvP70s1Lq2EPTzQSgsJ5kFVYYNw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2810.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(346002)(39860400002)(366004)(396003)(451199018)(41300700001)(2906002)(31686004)(83380400001)(36756003)(5660300002)(7416002)(7406005)(66476007)(66556008)(8936002)(921005)(8676002)(4326008)(316002)(38100700002)(86362001)(31696002)(66946007)(478600001)(2616005)(186003)(6506007)(6512007)(6666004)(26005)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WmVmekMrV3VyVUJpQWdTZi9lUGxaTDcwVTZoT1VWN1lwSlNxdldlMDZubmhL?=
 =?utf-8?B?dFNIYWZQeUsvN3BtNFpoZUVnZGVOWDQ1TlJhOGdFRENhRXJ6RVVCc2R3YWVK?=
 =?utf-8?B?S0tIYnM2U2Q5Q1doVFhmRnExbTMvU0hVbEpacVA0azJiQUFGdFJkYzM0UW9I?=
 =?utf-8?B?MVlYM2N2YzM0aVhxUlNtUkJYQnhWNzBLb0NlVnFEQUQwSlRSWkhyYUJ5d0hJ?=
 =?utf-8?B?YTd0MlN4RWxKeVZJRGovSmVnT09vQmhoREc0ekI0ck41U3U0cm4wbzVmWU1T?=
 =?utf-8?B?azZEbjZMaXYzd2oxUzJQV05tOVJRbHJQaldwMUtBVEhxOUVNaUtNcVRIVE1K?=
 =?utf-8?B?YW1Sdy95SlBucFRHSXkveHEzN0twZDVZbzBRTVRzdHY2UkpvWnU4NXNiQ2hM?=
 =?utf-8?B?R1pDdHRBa2tWb0lON3VXQStyUy85MHY1dy9aN0p5a3FQTU51YUEzRVUrS2pB?=
 =?utf-8?B?TXRqYW4vc2UyZFJyUUpIRmZaSmEyVU9tcHdGellLNVZOK0hxMkU4NFhSM0Ni?=
 =?utf-8?B?S1NLSE13K3BTSHozYVdNVVRlRkkvR3ExSzZ4U1BnWXhkbHEyZTRvNFM5b0RQ?=
 =?utf-8?B?UzdjK2VOTE1yRWVRWWdVK0E4U3hnaXd6MGh6ck1Bbjh6UjBNa25DOTVhSVRP?=
 =?utf-8?B?c0FtNzZaNWhwamFHejNXb1R5QnNrNE9zc3NzMkY1SjFwOUVkdERxWHBKcHJa?=
 =?utf-8?B?OVhIa0Rld3o3Y2JVdXZDVVFLSmljbEIrSEhUUzhEQnFGOEduWnNXOVZqdE9E?=
 =?utf-8?B?aVBCZThhaysxeUlZMk1xWnUyczgxYTlveDQ4cW9mdzJMbjk4MWxtMlFHWXZz?=
 =?utf-8?B?YkJKUWwvUlVmY0I1ekZGMnpMVHNqV1VMb1dFRTBVY0ZWY0hLMm02TW9tQjBj?=
 =?utf-8?B?M3Q1b0xIZTlmdTUwd2lKSGZ1VW9zdzhYSmVLT2JlSkZRRktJQytEUm5ldnVU?=
 =?utf-8?B?ZDZwMW1ZcS9URFh3S2kza0lVNnExcTQ3aERkbEJldG1oNGdJQ3hOdkREQ3ZQ?=
 =?utf-8?B?WDU5NzhMNDhhOFZlOHNBT3RUYnFOWjhKSXptQWhmQnl3VW5VSXNmcnFZenRL?=
 =?utf-8?B?Ym1oR2p1Q2xReUlvOGFhVVhkYTRpUmRuUDIrYUQ3MVliTkFOamFIdVRiUDJH?=
 =?utf-8?B?bVMxbmZNd1M4STIvRkRjMkx6T1Rja2VOSEVNcEdMaEM5RHl1V0xpSnpsZ05x?=
 =?utf-8?B?MkRQUkZNTTZ6SkhCTmV2M1RQUmM5QzJsdFNLRTAvMjNpSlhsTHBSVHY4ak5r?=
 =?utf-8?B?VkM1VWJ3MDM0Y3dFOENHYmtucnNpc3hYb0N2L01iMmtGTGtXUTFKU3FQMi80?=
 =?utf-8?B?OCtYVUROTmwvVjNra05RQ1dTVWl1UDBNcHZrbmhlRFgzWnQwcWpNT01EcThI?=
 =?utf-8?B?L0ZVa3VicDY3RFRlQVBmbUVEeWtPQXpxR3gxS1Nyb3p3VHdiY1lSZ2V6ZnhH?=
 =?utf-8?B?VnQzZkJ0eFEwZ3V2V2NLeXNEWXNuMjJmOGRZL1JGWSttY3ZqQ2ZFeUt0N0M4?=
 =?utf-8?B?RGNxZ2txSmx5V25XMCs1Sko0N0NLaXUyRHRoTmNoem1Uc2J0d2ZmV1hldFU5?=
 =?utf-8?B?eXZ0NXlRdWQ5czMwRmdLQk1wZ3ZqNEc3c3VqYkF4RHo3Z2RDUHIzYTdNTStO?=
 =?utf-8?B?WUVuQUlyK1A3ek5pMEphQUh0TGg0cDd3SThCWEhUQXFIdDlJWUd5ZnNGOU04?=
 =?utf-8?B?YUdlZ0RoQndlMXowT2ZvSmRhT1l1UFZBTFVXQW5wekhtTGUvSG94cy9saC96?=
 =?utf-8?B?R0dMb04vN1ZLMDQwb09SZ09KSDEwK0ZaR1REQmlSbnc3czBXektlaG43Mk9Q?=
 =?utf-8?B?c2Q4Ym5MU2orN1VtUHpOS2xZUE5Vem80RUtYcC92TTA2Vi9Pd3l2RDJ0ZElY?=
 =?utf-8?B?NHRiUVFZZVkxWks5UGlFTHZwVys3NEZIVGxQdnhRZ0NwRnJJRG9jektTeUs3?=
 =?utf-8?B?RXNKSzVSK2tmYWdSVjYyVERHZFdodmdhQVlEMWJhV1VodVNrWkZLUEVpcEJU?=
 =?utf-8?B?M2pXcXBHem8zSHBWeE5xSUV6QThaTEkrL0VMWWpTNjl4RXVGRmpKeFlSK055?=
 =?utf-8?B?U0pzWlplWE03NlkwUnVrZlpmOG93MlJHdlQ3dklWVlpwMEJMKzk2UHN6VkxE?=
 =?utf-8?Q?K5LkSwBg87ZmYZzvDjmtFP1lk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f777cf7-18ee-46e3-06d2-08db217d203d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2810.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 15:35:50.1055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dolp/V6OhhHu1nXtySIFXauklTrRkAnJjCeOITE8FvNR3V0FBnxYIlS4EsQN3Wn5NzuGGvMlaAMxnuBM8+w2gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5867
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



Hi Tianyu,

While testing the guest patches on KVM host, My guest kernel is stuck
at early bootup. As it did not seem a hang but sort of loop where 
interrupts are getting processed from "pv_native_irq_enable" path 
repeatedly and prevent boot process to make progress IIUC. Did you face 
any such scenario in your testing?

It seems to me "native_irq_enable" enable interrupts and 
"check_hv_pending_irq_enable" starts handling the interrupts (after 
disabling irqs). But "check_hv_pending_irq_enable=>do_exc_hv" can again 
call "pv_native_irq_enable" in interrupt handling path and execute the 
same loop?

Also pasting below the stack dump [1].

Thanks,
Pankaj

[1]
[   20.530786] Call Trace:^M
[   20.531099]  <IRQ>^M
[   20.531360]  dump_stack_lvl+0x4d/0x67^M
[   20.531820]  dump_stack+0x14/0x1a^M
[   20.532235]  do_exc_hv.cold+0x11/0xec^M
[   20.532792]  check_hv_pending_irq_enable+0x64/0x80^M
[   20.533390]  pv_native_irq_enable+0xe/0x20^M   ====> here
[   20.533902]  __do_softirq+0x89/0x2f3^M
[   20.534352]  __irq_exit_rcu+0x9f/0x110^M
[   20.534825]  irq_exit_rcu+0x12/0x20^M
[   20.535267]  common_interrupt+0xca/0xf0^M
[   20.535745]  </IRQ>^M
[   20.536014]  <TASK>^M
[   20.536286]  do_exc_hv.cold+0xda/0xec^M
[   20.536826]  check_hv_pending_irq_enable+0x64/0x80^M
[   20.537429]  pv_native_irq_enable+0xe/0x20^M    ====> here
[   20.537942]  _raw_spin_unlock_irqrestore+0x21/0x50^M
[   20.538539]  __setup_irq+0x3be/0x740^M
[   20.538990]  request_threaded_irq+0x116/0x180^M
[   20.539533]  hpet_time_init+0x35/0x56^M
[   20.539994]  x86_late_time_init+0x1f/0x3d^M
[   20.540556]  start_kernel+0x8af/0x970^M
[   20.541033]  x86_64_start_reservations+0x28/0x2e^M
[   20.541607]  x86_64_start_kernel+0x96/0xa0^M
[   20.542126]  secondary_startup_64_no_verify+0xe5/0xeb^M
[   20.542757]  </TASK>^M
