Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED0AE5FAF7F
	for <lists+linux-arch@lfdr.de>; Tue, 11 Oct 2022 11:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbiJKJhh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 11 Oct 2022 05:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbiJKJhF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 11 Oct 2022 05:37:05 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE16A816B6;
        Tue, 11 Oct 2022 02:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665481024; x=1697017024;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nWubjhDs6KyFq9WHIsJpVZNfhlC96MmddFC4Vmw55G8=;
  b=Shx5E86FrFGsFnl1UJe//ffCkBydEcWmmLa5T5wxkT5noKKXdmQDv6rN
   isrrsgvrzg1Y+mkLu7ODUI/F4mpEBLrLRLseUiQcG1+2xnQ1B7evINebs
   xeC97H9Vxx6xxgOGwm7x9F5dUSBMW9VJ5OQtxg+RksOhz2RLvNem9Y6e5
   qxBHGhWq0N6Vprx5mDOw0ZY4cOuBnp0dgef/YXKqE6dC/5yskTjGy4u6S
   d2Wqo4fjBOHP6vEisX9jPhiZ7ewLH93ZbWsbe6lEMW0BJse8737SJtLfZ
   zgeCEIhhUw1fKeP6ZOgRodbXmr2FwnJAVJq1DSmKMaU3966kGDXeEMU8w
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="366450034"
X-IronPort-AV: E=Sophos;i="5.95,176,1661842800"; 
   d="scan'208";a="366450034"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2022 02:37:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="694992304"
X-IronPort-AV: E=Sophos;i="5.95,176,1661842800"; 
   d="scan'208";a="694992304"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP; 11 Oct 2022 02:37:03 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 11 Oct 2022 02:37:02 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 11 Oct 2022 02:36:57 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 11 Oct 2022 02:36:57 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 11 Oct 2022 02:36:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HlA/lQ3RBPClNWVd5Y44suBA40B2pb+1GaHmzE4pxsPkP9KP7VUXJU8OcXbpcZc1149qOTKVDHGc40lUXEFgn+RuE/U5seYRA/oLODbWljZ929vBA2LiwB3q5PQDQqVvpT8DLeeJ5F859ID6uUsxcZMUuRF9XS5zfy0YdJEbhdO5+CsWhM7fFk/8hKTCjnQLfoGOHC59fxbL7ZSwsB9ZE4PXS4kI85jEb5o4BaWaGqHw8R7DU2jmfaD44HXHuC0T/vSjBv1ib99EJDhoZO8bvnhgoSeSiJEOdYJwHQX11snASfxeTZaX/qa3PgHteSfd909EwUPCFkE7qUErBJ818A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=euuwYbijzkOGwTNfca6bV+9g2S5aeow5fMBKOq+SFI4=;
 b=k+j6hJ1yPyxU8j6NvVuvujj4Xw6EQjpECc60QS+GndiZSOqldspWBqNuwQiQ/vx+nGEP4nsX8J2tNAm//Ly9FtNSWETlc7YlPxdq8Y70w0poSDfbxADwqrUGJFRKpxNO6d4Ey076dBj8y6hpx726O+9rW8b1Rdp5bcjSd25q8QtDHzxHdSqT5GYJ84L2azEAozxoNI5lgwDsJvUBa6/YqT0c4LyRQMhEEjkCPGksRoX5XpUODWi0Q9VNLJOsIoZ252c4FcQJi5kIXAHqy+Q4eZfi8ll8/6jBHG0pC8/57xwrWWp7EAi0A/tPsThFGLA0pQQsPVGMRghm+owz5PU4FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB6397.namprd11.prod.outlook.com (2603:10b6:8:ca::12) by
 SA2PR11MB5017.namprd11.prod.outlook.com (2603:10b6:806:11e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.21; Tue, 11 Oct
 2022 09:36:24 +0000
Received: from DS0PR11MB6397.namprd11.prod.outlook.com
 ([fe80::3a1b:7b6b:aded:fbfc]) by DS0PR11MB6397.namprd11.prod.outlook.com
 ([fe80::3a1b:7b6b:aded:fbfc%5]) with mapi id 15.20.5654.025; Tue, 11 Oct 2022
 09:36:24 +0000
Message-ID: <f09f2fb1-ae86-5419-4361-bdd8f8a22e11@intel.com>
Date:   Tue, 11 Oct 2022 17:36:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.3.2
Subject: Re: [kbuild] b3830bad81: System_halted
Content-Language: en-US
To:     Masahiro Yamada <masahiroy@kernel.org>
CC:     <lkp@lists.01.org>, <lkp@intel.com>,
        <linux-kbuild@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-ia64@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Ard Biesheuvel" <ardb@kernel.org>,
        Nicolas Pitre <npitre@baylibre.com>,
        "Michal Marek" <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
References: <20220928063947.299333-3-masahiroy@kernel.org>
 <202210090942.a159fe4-yujie.liu@intel.com>
 <CAK7LNASUhDMo72eNge_GvdfbmOkpBCJA88Xw=_V69jcf+_072Q@mail.gmail.com>
From:   Yujie Liu <yujie.liu@intel.com>
In-Reply-To: <CAK7LNASUhDMo72eNge_GvdfbmOkpBCJA88Xw=_V69jcf+_072Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0129.apcprd02.prod.outlook.com
 (2603:1096:4:188::19) To DS0PR11MB6397.namprd11.prod.outlook.com
 (2603:10b6:8:ca::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6397:EE_|SA2PR11MB5017:EE_
X-MS-Office365-Filtering-Correlation-Id: 68af87f9-1a85-4433-4d8d-08daab6c0feb
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eUqyEWb3A1ldp/oPcmXj7646jbx4QL36oBMY/od0y/6VQLOA2aXrMzEwDrtmDkPZbP/37LmYzwX9aF6qCAmHq025rP1LVPzZyoZwMZza2BQaXDhNkl7YKDNFnH47/jM2ZQdWFear+PAdS8RG4cf/A0rnh1+Xhp3aAsTsKTPCj9refI4Fi+Uy20OTztHMTrIO+CevIdJ7ewUwYOumkMUqQCgemHnXjMvfDw27qFVaRrBhyWgNOGinT3lVrBCP2SmpZy7f8m1fZjsbmEyTKAymOXCpt+ryFB4t7jpMAzi2wBj0b8+mo3K7+3Qw93cxMprUnUYee+tUnm7sZFmPlfQ52NPL36BOsAHPoLKu3zspIVjQeBQ0Ow68oX2gTwkk3rGxNZC3Zfwj8fNG18RE7OXfG1JaFtT95cbwlLa/ZXt4oDvRRYx1BfXr6yNTSUiV6bGAPbtNwFRgqgI6UeK+pX0V0XuO5vWB6s/TCU1K+YEdUsfQJNexLx4bvNACRkUVruHV90BrBFxbJAihk++yNEeirG44o4ifMzfUvDPr+U9J8/K45ZLyjcnQc0jmubxL8iwRABKndfD6m9hkTgMyGu1kvOtWcbsU6RM82xr5YjBFZtCKDUTKocqiviCST8DDqUbsHAgSsCEAKf9mmmpCaTe+kw1P47SEBD+yODBGavD9+12uyGuYOoEPaYmrbl9CECGOTCByxhneD8ZhN+9P9de3qVUKQa/cEIKUuKODV7d0xuuhagubwSrrv1TnNGBSxO0sLDy5fV7VJp3IstvUnMVkjyx3PunRUA7mBa89HugoF5bgDVrLXoBgvUOGaCUxdz4DIC537aL6T3ou1zPQa2PV0K7lE5rkV/RvchcGYTvR5HN2G2jDVz8AS4lXsamLgfVF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6397.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(396003)(366004)(376002)(346002)(451199015)(6512007)(26005)(7416002)(31686004)(6916009)(316002)(38100700002)(6486002)(8676002)(54906003)(82960400001)(36756003)(31696002)(86362001)(83380400001)(6506007)(2616005)(6666004)(53546011)(186003)(966005)(478600001)(5660300002)(44832011)(2906002)(8936002)(41300700001)(66946007)(4326008)(66476007)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmZFL0ZwUUxYQmM4WXd3eHJnTUhsU1d5Tm51eE9kNnVHVlpucEJOV2VUNDEv?=
 =?utf-8?B?Sjk3N0JqZlpPMnBkR0psR2VIY1AwTjRNTVJWMmJqRVVPQ1A3NU1ldDd1Wlhk?=
 =?utf-8?B?aTBjSTNZK2NKMkxSUWVmaVpoNzVtS1YvdXdIU2p2TGQ5K2xaTXV0U0xGdU9u?=
 =?utf-8?B?Q25HNE5ScFo5amttbjNjQjZLRzdKQjdQZUtkWWZXWUhEallIMFFxVVhJcFNW?=
 =?utf-8?B?UzRzUXpQM1JjUmQ4UFpEZUhRUldTdG8wN3hhN2RYcVNlWXMwdjgyd2xpaU5C?=
 =?utf-8?B?VXJMeDNjTEVTOStJcGoza1hnRkxXb3MxaHRMaTBkVGZ6V2RjZ0haNzlnL1R3?=
 =?utf-8?B?WW1Bcmx3cDBNNWZxTXlBVUgvNXA1VVhiN0JZRFdPcUtmUEd2eDkxaUlHVmZw?=
 =?utf-8?B?NVhzTzAyak5QejJrUytneFJGbERMbjhTWFNEM3VGUkpMUTJvWmowOG01dG9j?=
 =?utf-8?B?djdUekI1ZzkvZ1N1Qm8rZUx4VisvdFFnQmN4V09DaXZYYUZucVUxekl0c0JS?=
 =?utf-8?B?MHc4MWE4MFU2My9BN2lubS9mMUU4ak4xYzM1L1RTbjlySFBtKzNCV3ZvaE5v?=
 =?utf-8?B?K2xJQjdlNkpGQk5IZU9VVUhCVFB0Sm1jajk5MzVXcTAvQkdReEZXY2oxT1ZR?=
 =?utf-8?B?TUY1Zm4yUWNBd3gwdlJocHQra1lvWkc1OU9sNmZwM0NranZYWnVGeit5VWF2?=
 =?utf-8?B?REttQW96bmt0bDVpeUZsSTdFQzFQQnJocmJZelc2dWJRbDRKa2FaWDBWanRW?=
 =?utf-8?B?MXV4ajE2ZlBMdkdDcExmVXJ2cWF4WUd1NGNtSm9FanJqaHh6RWh2MkZEb0F2?=
 =?utf-8?B?RXZFQWphbXk0OVMzaS9teWVzKzh3QmJRK3Y0S01nZ2c3eEhLMGIybUJpMXNz?=
 =?utf-8?B?V3BEQVZHUVB6Vm5VWWFWcUU1RUxqc2pkZXJqdVlkMko4bXpENEE4Yk81WXNr?=
 =?utf-8?B?MXIveFRLVXN4RTZ0dTVXZ0FxK0xYbVdkdGU0M0E5WURoSHpjNzNtK01XbmN5?=
 =?utf-8?B?ckYwL2IreDY3T2tKUDQyd3lDS3lteGVuT0xQOVRNSWlqYW9IR01HaUZXZjdH?=
 =?utf-8?B?RU5sbXZBdmc4Vjk4NUhoT2psck00UHNYUFl1cHZWMXV0Sit6TnV6dzFYazVm?=
 =?utf-8?B?NGM5aWt5NU1KOUdOaWZhalZNSEFXbDQxWGVOUzRadE5CdWVoaWllbFEvVEth?=
 =?utf-8?B?VXNIK1NmQi84eHh2VWI3L2lnQzZxMWhjdmRXMVZueXJmQ05hOXVMcW00Uk9C?=
 =?utf-8?B?VlF1QnRMa3pXTHR0KzJPNmdVMVdSOU8wcFFVOWZZR0swV0hmam1QMENMK2pR?=
 =?utf-8?B?cFBGZzQrcm8yMEJTUVNtVEljUGRUdllOalVwTG9XSUtHclJ0ZDQ2M2RJNmRx?=
 =?utf-8?B?Tm5KQkJvcnc1RlRmNXhpY3gyNEtYU2pZZkF0OWNCZC9wMnRaRTI0WWxBSGlJ?=
 =?utf-8?B?Z3JKcXlEUmgyeS9Xb0dpcUk4TkcxUU9jSWRjUk00ZWRHYXFMb1pUU1UwQnNk?=
 =?utf-8?B?eTY5a0s4OEovSldGN3lzRmNxTXprcUhDUUhYdHc2cGMxY1dPaFNLSmpNUHR3?=
 =?utf-8?B?K1czVVZXblRvSGxpV0YzbzQyVWFxT1VUSG5jSy84bXNNUnl0b0M3SHhHU3Za?=
 =?utf-8?B?VEVJWnJ5LzBJeEJmaExtM3hYeUpKUmdmRHpoNVpvYnZ0R2NKMFF5NGxTZUo5?=
 =?utf-8?B?alZBZjFyR1RzWmd2bU56My9qQlNvUit5Zm9rMnBLWDgzUlpibXp3dDhvOUhr?=
 =?utf-8?B?a0FjMzdoWFBvR2RUQWxISlRzVmVpbVQ5RWVhUDJWL0lvVnZ5ckdGOC9XZ1dv?=
 =?utf-8?B?R1FicEE3YUJ1R3AyMzBacjdueUdqeWlKZm1JN1EremxwdEVzUnduOXczL3lw?=
 =?utf-8?B?czZFYUY1SGZxK1Qzd0UzSGxnVEV6UTVUTnhUeHh5dFV5RVpRR1RJdG02UE05?=
 =?utf-8?B?Z2ZvaFF5cys4Ymc2WHRzUzM1Ym02eVExRmdleERqaHVTNkhMbTRTQ0pUckI4?=
 =?utf-8?B?SlIyUGpBNjl3b2FETjc3c3lwUFFpQzBOdm9HN1FQc1hzajRwSXA5Um82Slkw?=
 =?utf-8?B?TGNwVlZQRXlJcitUT29kZVZITTNQNG53WE41ZTNONXYrNC8ySmV4UTQ2dVJN?=
 =?utf-8?Q?1Ki3JYU1R5J8/v88u9EVg7hWe?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 68af87f9-1a85-4433-4d8d-08daab6c0feb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6397.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2022 09:36:24.1055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lGdRSxoD8WW4W1bpkGZnNfeJKeYYovuWt4b4pm5yFAH/OczFEbMDQZt341ce6MqkGfIg0a3z3GW1WGFPM0MUSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5017
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 10/11/2022 03:29, Masahiro Yamada wrote:
> On Sun, Oct 9, 2022 at 10:21 AM kernel test robot <yujie.liu@intel.com> wrote:
>>
>> Greeting,
>>
>> FYI, we noticed the following commit (built with gcc-11):
>>
>> commit: b3830bad81e872632431363853c810c5f652a040 ("[PATCH v3 2/8] kbuild: rebuild .vmlinux.export.o when its prerequisite is updated")
>> url: https://github.com/intel-lab-lkp/linux/commits/Masahiro-Yamada/Unify-linux-export-h-and-asm-export-h-remove-EXPORT_DATA_SYMBOL-faster-TRIM_UNUSED_KSYMS/20220928-144539
>> base: https://git.kernel.org/cgit/linux/kernel/git/masahiroy/linux-kbuild.git for-next
>> patch link: https://lore.kernel.org/linux-kbuild/20220928063947.299333-3-masahiroy@kernel.org
>>
>> in testcase: boot
>>
>> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
>>
>> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> I think this is a false-positive alarm.
> 
> As I replied before [1], I know my patch set is broken.
> I think 0day bot is testing the patch set I had already retracted.
> 
> I only picked up low-hanging fruits with fixes to my tree,
> and did boot tests.
> 
> Please let me know if linux-next is broken.
> 
> 
> [1] : https://lore.kernel.org/linux-kbuild/CAK7LNATcD6k+R66YFVg_mhe7-FGNc0nYaTPuORCcd34Qw3ra2g@mail.gmail.com/T/#t
> 

Sorry for this false-positive report.

Thanks for the info, we noticed that this patch has been merged into
linux-next, so we tested below commits:

b9f85101cad33 (tag: next-20221011, linux-next/master) Add linux-next specific files for 20221011
5d4aeffbf7092 kbuild: rebuild .vmlinux.export.o when its prerequisite is updated

They all passed the boot tests.

--
Best Regards,
Yujie
