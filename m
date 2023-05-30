Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE5D471685C
	for <lists+linux-arch@lfdr.de>; Tue, 30 May 2023 17:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233113AbjE3P7f (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 30 May 2023 11:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233202AbjE3P7W (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 30 May 2023 11:59:22 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2079.outbound.protection.outlook.com [40.107.95.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C7CAE47;
        Tue, 30 May 2023 08:59:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fHVGriVbxb0bAE6o+Ui4npl3ORZHqM3505i9a7cBPEYxc/OJCbMGkiAauzb784BZvmeA8bPWCJDk+EZY2B3krOobgG1uQ6/pwryLGnx2/5Go6I1hpeD7I4pSGRFg7aMHuvogy8wJnjb/Az9adm0+dl5O2S9wdo1noOcrDacz3iWJwJohLxbUztYkqFyfUCasp8ksp/9FFVNawQKyeCikWRQoApfMxdYl63VX9iPbUFp1ZaZn0nobGQmpQRQAK/CtMuYE6DK6g0Qcu0aIziZpY+FosNpS2oC8IxU8Fh5LU4zigyUfJAnn5pRRXMIdr4OR00rngxK46keg25B67P2ElQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eUR1ty7awgip1X62R2Urz0yNWuPl5Q7d6HWJjqrWedA=;
 b=IMpmv3kE/OIiXKc3xXMNXGAz7cn4TfUqevdDHJ0Ik1Oz3UdMFKo7lHSNYk9zcR6lIQoirrRPB+2ONaebzKH/lPdfsaO6WoiX7JwfdUwBzjJzik+8YowYJD4F4j3CTq1WIiC543qVfbBbekv2SH1X/gQQKDdmI+ja990kMCWPMLSHOqKu6cTzbP3EOPsayFw+Z9orOoW9s8cV1LrWGxWru4/pZ0jZ2Lq3NU3lCo+OYk/IflxlbTVlLvimarvSgYdc/lNSLzS/agaqmUbq8B1OX3Jp7hr0D8JYYzzBjvduBF9vELjmBsxOV4E8OS0ahN0stUHcjFb930WuKSPMNEnfpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eUR1ty7awgip1X62R2Urz0yNWuPl5Q7d6HWJjqrWedA=;
 b=iQwe7srU2ScvVo3YveggXQ7NFFGF1bTDYCT65qPkgTw3iotFthPqjhZBy+pD5MLjfwbtUG5GeEFRt69gkLN7gOqSHbD02TM8+bJ0tKYZIfuUQnf5QHUra2BEt3dbSwCkvLR8PtwE6tPnxXQb3Fr+glXAD3Q6B7K85ncnUxCugZs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by SA3PR12MB9227.namprd12.prod.outlook.com (2603:10b6:806:398::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Tue, 30 May
 2023 15:59:06 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::61f6:a95e:c41e:bb25]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::61f6:a95e:c41e:bb25%3]) with mapi id 15.20.6455.020; Tue, 30 May 2023
 15:59:05 +0000
Message-ID: <0f0ab135-cdd0-0691-e0c1-42645671fe15@amd.com>
Date:   Tue, 30 May 2023 10:59:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC PATCH V6 01/14] x86/sev: Add a #HV exception handler
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        "Gupta, Pankaj" <pankaj.gupta@amd.com>
Cc:     Tianyu Lan <ltykernel@gmail.com>, luto@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        seanjc@google.com, pbonzini@redhat.com, jgross@suse.com,
        tiala@microsoft.com, kirill@shutemov.name,
        jiangshan.ljs@antgroup.com, ashish.kalra@amd.com,
        srutherford@google.com, akpm@linux-foundation.org,
        anshuman.khandual@arm.com, pawan.kumar.gupta@linux.intel.com,
        adrian.hunter@intel.com, daniel.sneddon@linux.intel.com,
        alexander.shishkin@linux.intel.com, sandipan.das@amd.com,
        ray.huang@amd.com, brijesh.singh@amd.com, michael.roth@amd.com,
        venu.busireddy@oracle.com, sterritt@google.com,
        tony.luck@intel.com, samitolvanen@google.com, fenghua.yu@intel.com,
        pangupta@amd.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-arch@vger.kernel.org
References: <20230515165917.1306922-1-ltykernel@gmail.com>
 <20230515165917.1306922-2-ltykernel@gmail.com>
 <20230516093010.GC2587705@hirez.programming.kicks-ass.net>
 <d43c14d9-a149-860c-71d6-e5c62b7c356f@amd.com>
 <20230530143504.GA200197@hirez.programming.kicks-ass.net>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20230530143504.GA200197@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0106.namprd04.prod.outlook.com
 (2603:10b6:806:122::21) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|SA3PR12MB9227:EE_
X-MS-Office365-Filtering-Correlation-Id: 8daa34e6-04e8-475b-f946-08db6126cb9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8h+owdRYxOykLSb1VB28E4H3NJI7W9NbRO2zLxJVhdfXET+rpm1tcRmYY0XMFsZciyEpRX+e0Qcxzwj9WKiIu3sV5Yaw4+jz/Tavv7EYC4oNFIM+1QOLKtWxf9abS3Jgwl/Lnn8AXUMwr48UNSlDek7hBGe0M+bfAu3JURbHPXVE7CBtrHfir9GmCGKI9j9sKI8WLJyjw7GxVa/5CAYibTa6MlFbNNnqZ7i7CO2MUZk8dGlEmOG/axdD3ooaPDq1XV43W/qks/3vTix881l9gJjATVBGbRVBD4G9jE8ekBMPCPTw7gceiZcrUTqiskhvBcSZRlAQHklv7k34kgf1kef3/sYKomO9RwlAeVE64xciBHF2Y3d7h/QqvRiV9oxpOh4iyhst3a4vQn2S/gjO72fJWqn8pWRJMcZM8+08Pw2CCKeX4yAzsT9gVdLKppgokDrgtFpVN0Yxca9e0R0f9oo0VES2emDKFWRZh52LkZr4gCqxZ1Zh9T0WsbfB+G3I9mPOB/zb0FUdAEzjhfDZrE2DW8wquNnno3KDXJsDGHR2nwEFpktTGtNSI9JVcDxzpQlrWrDVJovfM1rKM4BIE9Tn9yhpJYzc2S0LFTizyj0bfrYRVoqUj58VMy5zfH6SatYQOXfa2/T0nIJho4DHoA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(136003)(366004)(39860400002)(451199021)(2906002)(4744005)(31686004)(8936002)(7416002)(7406005)(26005)(6506007)(6512007)(53546011)(5660300002)(6486002)(110136005)(41300700001)(83380400001)(478600001)(86362001)(8676002)(6666004)(38100700002)(186003)(31696002)(2616005)(66556008)(66946007)(4326008)(6636002)(66476007)(316002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QjZJRXdHdlU2a3RLRHNLeVlFc3lTSGRyWjlaRVlBNmlmMGdtTFA4a0U3TnJF?=
 =?utf-8?B?TExLRmVkU3dZaHRNUGFxNE9BbEdLeGdSRzZMdUkyYzcyUXd5aWVZallNUnhX?=
 =?utf-8?B?YldWSUorb3lsKzVIaVE4UkJnRXlxWGZvVXRkeHNvVWF5UTNMckRsZlVpeVgx?=
 =?utf-8?B?ZGxwYUdTa1ZpdTY5MWlxZnhUWjVydGRQMm9LYUFLZVJtNHRHbU02QU4wNFZE?=
 =?utf-8?B?dkViWG9Wa2daQTJOa2NjWUJibmxSYVhlQTJvOTBYT3R3ZFd0WjAwVjdZVE5k?=
 =?utf-8?B?czk4VjFyVXQzUnplMGl0Rno4eWJQcGo5RytHaEp0OFZEWE9seHBTRHRrY3hX?=
 =?utf-8?B?cTNsVjZMQ3liemVRMUtjdmwvYm4wcnFiQlM1dU9abWcvTU9TeUplcW9zQ0dX?=
 =?utf-8?B?eDVMZS9MWGEvUVBlUHRaNGQ1QlVYR0ppRXF2WG9maHpPL1J0WkQxVzJ1aU11?=
 =?utf-8?B?bDdCc2RCZk1ITExGMTlMWG5xM3Y0ZG5YY05tQW1OMlNmUTJ0NC9KWUJQSk80?=
 =?utf-8?B?bjBFdE51bU1XakZBL0hWMVBwM2NsZDRhVnhxSW56R2dRa2tsZUtmY0xZTm92?=
 =?utf-8?B?RUhyQVlOekV4UjMzM0JMMDB0Ujg3NHU3b0FDV0dKM29PLzdTb0NxdkVzS2k2?=
 =?utf-8?B?RHpieTQzSmwzWUF1NnZRdjVoTzFVZGNTRXMwcXVhTmhEOFlEcy9QYWU0MEVp?=
 =?utf-8?B?OVJadVFuam9OTGtLVHNpWTFIS0Raa3V1MUFLbFV2NUI3SzIrdGRwYWd3bnhZ?=
 =?utf-8?B?Y3pqSlhydDhvWjJ1V1UrMlIzdDBhRlpEMHMyV3dVMS91L05ud1VIbnpDRWZV?=
 =?utf-8?B?WjZZMTduMXNCMHIvcWEyY2hjTGhvRkRNa29WZjg5aUJUTGtUaVVLakpCM09P?=
 =?utf-8?B?WVJ0MUV1U2ZPTWJoaXE1WkI3UzZjV1FUNlJXdkIvVDdSamV5VVNkRHRhVCtw?=
 =?utf-8?B?K3M4M2k1THM5OWcxbWlpUmx6S2o1V3kxWjJVYVdDc1J2L1MreVA5QW1GbTBM?=
 =?utf-8?B?QXBTRkoyaEI3TW1DdHlDNlRkWFY0SkJmVDlrb2xMZldyNmlpZ0E2OUZpdlRP?=
 =?utf-8?B?Rk0rbE45VUxxRWNFY2plcHVTKzJnQnhOS2NBUnJEUHhrc0xidXJPeS9aeGMy?=
 =?utf-8?B?Y3ZUeVRCdkRFV3d1cmlPWmFvdm9zZm44SkpVWk50ZWRUUzFCVFNDL21lZmFT?=
 =?utf-8?B?VkpoWGhWYTZYMDRpVUJHU2czZndIK2hrR2dtUXEyaDhLWWdDd0FNNzRkRGxG?=
 =?utf-8?B?K3hDZ1pWczlmVVY3L0lreUVsMGNUeTF4TnhKeGh2c1BhU0sxbzUrV2lWMDlT?=
 =?utf-8?B?MzNKOEVQejU1K2N0NUVta0xnU1VzQ3hnMGtkemxXbXlnYWFMMTlLVnZodXJP?=
 =?utf-8?B?Y1d0TG9NQVVFUExXa1hHMWI5RWJKbkUxRWEzYktNTkMvOUR0blphTURteFRU?=
 =?utf-8?B?eC9YWTVmeXhHV2VRUHdEbzdYZ0J5dWsvdVZ5TkRZS2VYdWRpS0ZTM2s5Z0RB?=
 =?utf-8?B?aXVFR29PV3Zhc0VGUmtMancxcG5LWVlZVEtwTGI1RXJOOWN4OTg5bTZxY2lJ?=
 =?utf-8?B?YU1LdzNYU3F3WjVoSkd1NmFhY3pvK0o5eVFLYy9keUpxTVRZejQ5NkhtalpS?=
 =?utf-8?B?T3pVSjUwMnJXQm5OMmxJYUU1bExlNXBnOG1JTFQzQW1ncGUwWW1DbE5PSFhp?=
 =?utf-8?B?V2Z6S2w2ZGROeDNISFJYT3hYYXg4VnNzdGMvcFRLaGgvZ2M5RG82MENROFFW?=
 =?utf-8?B?RVNicmJ3c0dvZ3Y4dElHSTlXS0VETkFSYUN2ck9CdXdZZDd4U0M1TFZoMEd1?=
 =?utf-8?B?NkpRNFVsYXZqZkJ0SkJMMVRvc2JHeGVQTCtaeVVqTFRDZnhFNUhneHMyV1R3?=
 =?utf-8?B?Z3pxY0I1QWpIMHBhWkRVRjhQOTZpa3Q0cW0wbWlXdDdVS2s0VHE3SHVCSm8v?=
 =?utf-8?B?NWt6aW5rT2VwOElUemRXdlZzSi9uZEhVSlVEZ3lCYlRkUjl0Tkx0VUR0akJi?=
 =?utf-8?B?d21USkd1aVg3bHg0MWlNWUloRmpyMTZuRjFORFdZaHp3d044VHYvSW9oYlJz?=
 =?utf-8?B?WkFYdDA5eFhiZHJQZFlyWXlXM0dWOHlMdSthdTJyaVY5K1VZR1dQWWVqY1Uz?=
 =?utf-8?Q?nPQ/hX11xin3/3t8DDYA94MKd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8daa34e6-04e8-475b-f946-08db6126cb9d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 15:59:05.7777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wkD/omVYbZUAmLIXE8LvsjWQaLMAY4uGlX0xqhTIjgEkdVbxUa6KMwB0zJYptrqwTPY0L4nEMQnNkdWmrTQgqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9227
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

On 5/30/23 09:35, Peter Zijlstra wrote:
> On Tue, May 30, 2023 at 02:16:55PM +0200, Gupta, Pankaj wrote:
>>
>>>> Add a #HV exception handler that uses IST stack.
>>>>
>>>
>>> Urgh.. that is entirely insufficient. Like it doesn't even begin to
>>> start to cover things.
>>>
>>> The whole existing VC IST stack abuse is already a nightmare and you're
>>> duplicating that.. without any explanation for why this would be needed
>>> and how it is correct.
>>>
>>> Please try again.
>>
>> #HV handler handles both #NMI & #MCE in the guest and nested #HV is never
>> raised by the hypervisor.
> 
> I thought all this confidental computing nonsense was about not trusting
> the hypervisor, so how come we're now relying on the hypervisor being
> sane?

That should really say that a nested #HV should never be raised by the 
hypervisor, but if it is, then the guest should detect that and 
self-terminate knowing that the hypervisor is possibly being malicious.

Thanks,
Tom
