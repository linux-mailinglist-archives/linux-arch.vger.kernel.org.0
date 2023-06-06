Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B0B723710
	for <lists+linux-arch@lfdr.de>; Tue,  6 Jun 2023 08:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbjFFGA4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Jun 2023 02:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjFFGA4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Jun 2023 02:00:56 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7BC811B;
        Mon,  5 Jun 2023 23:00:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N6S+AAhkP4AFOfQrWm72UHGt/ZbrKVtXR/2Z8ZspencfJKMK6a+V1CHAW++dFnoasQm1H833qO1uKLFQcJH364TtAZCwPF+7ewwZnghOnYWU19HGyJHP+LlErd7HKwSEG+3R456fp37bEd2vPWuyjX2m++lLJ7B+JVGH70iT7IiFBy6HNDAq7beN76A1EA+T6dSPFKBHseV25ZaV2h0km9MRH7kf3Sdaove90wVyCfe80wpr26hzpCHufNZbxxg7qx3sAAk+CSuijpkMlGSIsaX0EzdDby6FW3vefDMfApRyJzaaoaYzrD0WkEG0ASPw/XFNMedx9kZLny8Ir63S4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eaQIe6F6uD7CL4fyYjzh+i3viPVKI/oRSGoWzMHr/Vs=;
 b=lBSMC7TY6RiL85WwTxRs0Xh+hLM0G+hJ5+gxxf11ZpelGPHwGGwkUjCSauByPDxHnHBTB27N6kI4d54Aw+DB1HTa3saPhxA1MQf5EwCl+ZRkm8/C+uX48XO7id6ccimdgx+Aoyg/zxkuV2s+uS/VFZgh2MMM03ooD8HGgNVR0O+a36+ui2GhQbTKR4R7osOu91KCjhqkHE/hjwyZRvLhVwlj2iIMDnFFpPJ9j7kR0qhpsrD1yFPYI/PT1lZw2zjZpN6TcBWgX3V1fw32P2GQIlD5HuX5W4nJUBnmoW/4uxezN2FF06+DjFtHymw7PQ4bOw6/D1ZEmZp3Sfb4R4k83g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eaQIe6F6uD7CL4fyYjzh+i3viPVKI/oRSGoWzMHr/Vs=;
 b=VRyIPeaeypZ7hFYo5J/qwYbFQjUNUN8+jH40jghT8f3bXsmfP4vYOXis5Z3PG5db/uZKPCC8d/FatE0tPPNywm4xVjoxaTYh+hP/jmhE24XG0SuRGqt7O4jai1nCJErt3hKopRDXKj5AFIsYTNqYLl122eDY3lr3rLDprYJYbsA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2810.namprd12.prod.outlook.com (2603:10b6:5:41::21) by
 SA1PR12MB6970.namprd12.prod.outlook.com (2603:10b6:806:24d::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.32; Tue, 6 Jun 2023 06:00:51 +0000
Received: from DM6PR12MB2810.namprd12.prod.outlook.com
 ([fe80::2a9c:fc67:a9fd:bea5]) by DM6PR12MB2810.namprd12.prod.outlook.com
 ([fe80::2a9c:fc67:a9fd:bea5%6]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 06:00:51 +0000
Message-ID: <54fa0a4f-9b3e-50d7-57cb-e0d2d39b7761@amd.com>
Date:   Tue, 6 Jun 2023 08:00:32 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
From:   "Gupta, Pankaj" <pankaj.gupta@amd.com>
Subject: Re: [RFC PATCH V6 01/14] x86/sev: Add a #HV exception handler
To:     Peter Zijlstra <peterz@infradead.org>,
        Tom Lendacky <thomas.lendacky@amd.com>
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
 <0f0ab135-cdd0-0691-e0c1-42645671fe15@amd.com>
 <20230530185232.GA211927@hirez.programming.kicks-ass.net>
Content-Language: en-US
In-Reply-To: <20230530185232.GA211927@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0147.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::12) To DM6PR12MB2810.namprd12.prod.outlook.com
 (2603:10b6:5:41::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2810:EE_|SA1PR12MB6970:EE_
X-MS-Office365-Filtering-Correlation-Id: 07e64908-2c13-4cdd-2955-08db66536194
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b/O/9ULZuEB+3/s4KKiRU0fEbEuC/hqjWusGuS9MK8aq4F4OnzQ3m21+H03m4qazPD70SVNkdStHilaufCxvA8AMw6x6CV9DREp4Iyxa35XeQZWknK+K0SF/i2EBIxP6qDOIKkDT5ip1tra3pUEU1zK+hdozGz8BR3yva3Nrb3t2aQY6JMkgBqXc1LHS3cVliucaV6YeOoD5DzmBQ9AazR6gDPP50Dx2U+uyLjMYRLU9h/zXKC4jgA0JBNi6/8544TjFlrUpbPSXHOk2RS/BKUd92hzUuD8FZ5T7Mz9UP5l7mPTpyB/knF6Q19O+z7YuKklF0PhDRXXkeAJ1fCcu4xdPVrWdM6uLQ1SZFsEFMhQLjydohaZg3cjD64v8VO8i3iRq7pdNk/0cwQsddCPnIyxYd2UNr3+J5lAHQxgJMZnxIeskmlEbqsCkxz1t8iftgp1OLQglx3qAPMaaHUYOzKfl+izRD4guCOfeDyw1ZCnlmCOor5Du54Thbp6vwXndz9uR7cmznH9PqB9+a13ovZNSMB15iMGmjq74bWMehC8cMKgvdJ8bOkkXUEN2GnTaBrT6JssOb5ONDNloER6PGJt1sm6eaSx1sbfjGbgzO+g3oJp1dJe6N1ZGdsjCD6xg3AfT7x7EBYhrH00ibttANw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2810.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(346002)(396003)(136003)(376002)(451199021)(478600001)(2906002)(6486002)(36756003)(6666004)(2616005)(83380400001)(6506007)(6512007)(86362001)(31696002)(38100700002)(26005)(186003)(5660300002)(316002)(31686004)(7416002)(7406005)(8676002)(8936002)(66946007)(4326008)(66556008)(6636002)(66476007)(110136005)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TzJvTHdMdjBBMytRUVBpSlBldHdSeWZBTVVJdzYwekw0Rnl4a0NObGlSZXdQ?=
 =?utf-8?B?a0U3YVROb245bU5hM3pDbHE4WGVBZ3JqYWd1YjRVQTR3Tjh6MFJDOGs2S0ZP?=
 =?utf-8?B?NmJCR1RYcmp4a1lWRzFKOFhLSWNJTGNTeW05YU5sMGljQXNWUnhFWE5RWUdJ?=
 =?utf-8?B?bEI3TWJrVjV2d3BGYzcxQ1hKaS92dzZHZ2RSd1g5aEIzMFVYb1BGc0ZWL0Nx?=
 =?utf-8?B?blFqVjFCWjdmZm1UQVhUSFhOWVZBNUphRTJmeDBvRXNhNDFheG9BUElkSGpq?=
 =?utf-8?B?QzlaQ044ZUoyekduLzVQSHZVS0k5YkEzSFdXZkVlTG1iVm12Uko0ZE5kTjRj?=
 =?utf-8?B?MHhZZkRLWG51WTY5TDlZdUpsdmtUayt0MXl0dUxLQi8xUzdzVUxvaGhtVE9O?=
 =?utf-8?B?WjNLVjF2MkVSaEh6Z3NIRThHdENsODNjbkJjczQ4NW13ZjZGTU9DclFUZEg1?=
 =?utf-8?B?VEVrcS8rU09EUy9UN3R3QUc1SnNiUGl0UTFkZDdOUy9mWnYwY3RIanVzaFc2?=
 =?utf-8?B?R3QvMkhMQmdxOEE2R2hkTGlsZGRJQzdLckljM3Naa2NmU21PNk5obm9KWDI2?=
 =?utf-8?B?dDdBM2JMZTh0bVR6WG1USjdNZktRY2lZckdIemdTVzhSU2M4U2tna0c5Mld2?=
 =?utf-8?B?VTBBOXZVVWg1Tk0xWGp2NHRUd2ZwSHNUZkt1T1pOZ0p0K1Z4RGpzbVlNc3Vi?=
 =?utf-8?B?a2hHSEJpQnNicEZHNGV4bDY4dzRKamdQRUpRVEpZMWxmcFpPYmcrVmJCT1Bn?=
 =?utf-8?B?NWlCSFFtR3VVU1V1cnZmTnRlUVdyemJoZXZDcitGb2ZtNnVENW5NU0k4OG53?=
 =?utf-8?B?MTZva1loUHM1aC9SQWdNc1dSeTFjMjVWY3diWUNhQUNseVQ1MC9JT0xveG52?=
 =?utf-8?B?cThmTll2YS85WEJJQkZpRldTSG90WGh5Z3VLWUZnYXhJenkrMldDalEralh2?=
 =?utf-8?B?UUlUNVNwUkZueWluVTBCblI4cUNvMkhjWENsOWlITU1KaFNkRk5YcXB0Tm1q?=
 =?utf-8?B?ZmFNR0pwUE1xcDBQTjY2VzNTM0h2RmdFNHh0WDBwdmFkNkUyVldCRUNibDMr?=
 =?utf-8?B?T0dHaTBla2Q5Z1dkMmVFRSs1OU9WaWdEa0dGYytIOUpXM3pVR1V1WjYyaG5Z?=
 =?utf-8?B?OVVndmdxUVRvYWVDMCsxdEwyUUpQeWF2S1NMUmNPZWhPcWlMMklSVjdDZmNx?=
 =?utf-8?B?TmY0cFcrUTlnWk9iNWpCWm1ITVMzUngrdXRjakN3d0xSZU5BVkUwdlFXbXBh?=
 =?utf-8?B?bEJyZHZ0TVhMMmdLcUtWV2tiZlg1Qjc0MjdGYTZ0aFNCSkUxSkxwa1VHeDNT?=
 =?utf-8?B?R0hmOHl0SzN6V1doOFJ6T3dSL25QRWNmYVpWZ2FTN0dMNTh1MWE5dFZUcUZn?=
 =?utf-8?B?NlpMMDJ6MFIyQ1J6VnlZanFiY2VVampCWVUyTVE4dm5KN1lOZldqZ2ErSUx2?=
 =?utf-8?B?L055aG5sT1cyRkZwMmllRm5DRWJ5VlVMVEtOZmJjUE1YVTh6eTlKcTFHNXZ6?=
 =?utf-8?B?WHFBNDZKUEdkeGMrdTdlbDdmekxMUWFvb2Qrdk56eWw3cmJCeUh3L2s3ZmQ5?=
 =?utf-8?B?cGNTdXY5NWxoL2p6dGlMUUVWUU9xYTJGS0JSQndSQWxPUnlvSmFzOFRBK01n?=
 =?utf-8?B?eXM5V1dISmMvaVRHa0V4OFh3SFNRSklzcFRUdlByblVqTURJSzR6SzJETEhm?=
 =?utf-8?B?SnJ4QjN1bjV5Rzg1NEl6bll6R1MwbWcvazJPVlhtcC8wUFNMeVZVRFBpd2Ex?=
 =?utf-8?B?d0RuU09meGVRZzV3T1BXME9zYlN2cGtmb3daNWVmWUFsSnhPYUlVcVF4UGd2?=
 =?utf-8?B?Kyt5OGVuQUtRSWhlYVdocU8xNkFWazVhL1RhN3F2azZSaXdML01EUnFEY2FJ?=
 =?utf-8?B?QUkyOXJ5VUVaYXB5UWpVL1pWMVZGWEFySDBFRmo2VFRPMFpQeDdtcFZIVVNt?=
 =?utf-8?B?NEYwNkZGdlFRTXF0a2xkY1IyNHdwSVh0cEUzeWV3cGU4VWtCSUhvNUhLNWtl?=
 =?utf-8?B?cUp5OTA3bG1EdGN5QXdOK0RMaWc5cm5xbFJCQkNHNWJyei8wQjNCSW13NFNM?=
 =?utf-8?B?R01KaXpiRGkvU3VRZVQ4cGpsRUg5ejBuY29tMlRiZFdFRkJqdlF1V25RckpD?=
 =?utf-8?Q?82HzRgbAibPsOAMsIwwPEE1Mj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07e64908-2c13-4cdd-2955-08db66536194
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2810.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 06:00:51.0983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0LAgusRfzToqpamc/H1DSZYae6jjyjpzmHzw+vaXZ2C0/4DGe/w2nMk+Jwm/rnilMOwjG/R0ayLUtNIHal9JFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6970
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


>> That should really say that a nested #HV should never be raised by the
>> hypervisor, but if it is, then the guest should detect that and
>> self-terminate knowing that the hypervisor is possibly being malicious.
> 
> I've yet to see code that can do that reliably.

- Currently, we are detecting the direct nested #HV with below check and
   guest self terminate.

   <snip>
	if (get_stack_info_noinstr(stack, current, &info) &&
	    (info.type == (STACK_TYPE_EXCEPTION + ESTACK_HV) ||
	     info.type == (STACK_TYPE_EXCEPTION + ESTACK_HV2)))
		panic("Nested #HV exception, HV IST corrupted, stack
                 type = %d\n", info.type);
   </snip>

- Thinking about below solution to detect the nested
   #HV reliably:

   -- Make reliable IST stack switching for #VC -> #HV -> #VC case
      (similar to done in __sev_es_ist_enter/__sev_es_ist_exit for NMI
      IST stack).

   -- In addition to this, we can make nested #HV detection (with another
      exception type) more reliable with refcounting (percpu?).

Need your inputs before I implement this solution. Or any other idea in 
software you have in mind?

Thanks,
Pankaj

