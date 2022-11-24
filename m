Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EEA8637302
	for <lists+linux-arch@lfdr.de>; Thu, 24 Nov 2022 08:46:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbiKXHqW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 24 Nov 2022 02:46:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiKXHqU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 24 Nov 2022 02:46:20 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E5513E14;
        Wed, 23 Nov 2022 23:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669275978; x=1700811978;
  h=message-id:date:from:subject:to:cc:
   content-transfer-encoding:mime-version;
  bh=k2sNqdPfnhUZ+u61Uj9iNjrpXnLh2Oy1RO7A90vTnAE=;
  b=TQTp0Fb+eFZKnwFUd5YIHBGwah2e16EPPOhyJC3lCIixx0s1ShT2Cwys
   ZvZ2KusvdpqVNyTSXDy7tW3vQhO0T1K4XDrziaqZxABWpYfzY0rDuhBIv
   5XKFhJJ5RxxWdejCEDNErpr1wZJS9vPJyxpME+nGUjN0AygoPxwN5WjuO
   UOVJ6Bpm6DngjVSv61Kn8fztpHD/fgB6Xc3FsDifVPIhN346EuIUP/1gO
   WqKTHiA/TFpbzT/ur5V6eIYGdZPVckNUWAxOvHSwLNfWpdyJ9Ay5IApoR
   ZKGUgj1ql2wrbrWn2DSuEWizq0r+mZr9urVfqAQGzoL4k4ALUSIBnAKVD
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="293943402"
X-IronPort-AV: E=Sophos;i="5.96,189,1665471600"; 
   d="scan'208";a="293943402"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2022 23:46:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="731046776"
X-IronPort-AV: E=Sophos;i="5.96,189,1665471600"; 
   d="scan'208";a="731046776"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP; 23 Nov 2022 23:46:16 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 23 Nov 2022 23:46:15 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 23 Nov 2022 23:46:15 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 23 Nov 2022 23:46:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O+zJh12zsHnhKfkwBT1fZZ+Mqe8TYbkCTVZowBuSqqRLCk2hV1DmkeJzwQAx6bpf9l7RmJvlbDHCJ1Sn3omUGSRsoIFNNdPGuI0pg4ulVVwdv+rigfV+RXE9txQMATGHYbxgNk8OiV59tYUR2LpRn7IvXif1raQwti8ddcz4pqq4nCB3CoZBeUTBuxfESqGO3jNN7vbRA/rMV+t4LATFHTcGCGowJFmubk+Iiz4N5GcqsBbPhw0oQKifaADmis7XhLYIaChFomAQPJJydJnVfCZicPVxJX3iJ2QZEtLsQqcg+S70yXnwSQhBs6Df82WzApdvWfxD1vHnS+DsnTA+bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XIol4svADON78tbu13wo0b7jPg9dkSvBSamM3K1/54g=;
 b=GhuA5pDm5Xiab77l/kAJUQ2o+aRa/WXrtpKMelrqF1IJQc/hVUGFxJEU3p+K0iifFUugytEraHrFGklbTm5LDUkostxkQQqF8aalGIB6Wao7BjPapJZ9Yr/Bw84yZK1ORXHq5g7DKDZRcGbnUKzZ/RxjTEomg9duMapv5UZxX46+WTn8m5dV9jKusfAGl50SzWyyYOsW7AML69clfDfuBmPCHOJQuQ8UE/0LLGO26zWrFMKVrNXzZkWVeXPUep8mXYHiNjV0qPD1wz1DWwl2HuJKknxoN28CCuM8MvciL/vYJkVfaQ5CT1sdP5Ofyo86eMbZRodzogcJxpSVhbRifw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB6397.namprd11.prod.outlook.com (2603:10b6:8:ca::12) by
 BN9PR11MB5548.namprd11.prod.outlook.com (2603:10b6:408:105::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Thu, 24 Nov
 2022 07:46:11 +0000
Received: from DS0PR11MB6397.namprd11.prod.outlook.com
 ([fe80::673a:7082:8d1c:4f11]) by DS0PR11MB6397.namprd11.prod.outlook.com
 ([fe80::673a:7082:8d1c:4f11%3]) with mapi id 15.20.5834.015; Thu, 24 Nov 2022
 07:46:11 +0000
Message-ID: <9eed8d82-8810-379c-6a78-cdb006f1d196@intel.com>
Date:   Thu, 24 Nov 2022 15:45:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.0
From:   kernel test robot <yujie.liu@intel.com>
Subject: Re: [linux-next:master] [asm] 5e5ff73c2e: Initramfs_unpacking_failed
To:     Sai Prakash Ranjan <quic_saipraka@quicinc.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Memory Management List <linux-mm@kvack.org>,
        <linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1P15301CA0032.APCP153.PROD.OUTLOOK.COM
 (2603:1096:820:6::20) To DS0PR11MB6397.namprd11.prod.outlook.com
 (2603:10b6:8:ca::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6397:EE_|BN9PR11MB5548:EE_
X-MS-Office365-Filtering-Correlation-Id: ae47b5fa-e9fa-4bf2-2166-08dacdeff4bf
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SCEYvU/tDRmjgFYFxuEZ3IGrPfq1BF35mgjgFMYw85sIJrIAqACJKjbKRVBM/Atqu1pXz+GxWDLjpquAUradGCnLcm2bn7cOqGQP0DSge6dtSZ1wMDZrzMTTkvI0Jx7reiG40T7Ypq4qaOb6IyJc7fGwemFUvwAvfsdTCCxlj9l67P1ba66el/Id1HsTbdHaWKUZ7ZszZQUSVq/44dpUbNuZx7zsb3ASU6FxP+rG95lbhgfPCLhCxYtqV7MNxVAP/MzUd2xBzQbRlM6fc4XayZ1wMB2ALrth0qgK9DYbHCC5UScO4l2gGjsk5wcQmHvFEWmwTshnKPKGADYF0hQyismggd5r+y7JRlChLTKK2cieKTaJsb3b+J2TBeL1dSqA9w8f9sVh+PbwzK9wIFNX7pWbSdYpXE0HZ45ilZFZrTFGOmehyuPHj0I0TqNdHbJxUU0HbhPQpgDR+siDNQRkt2r+QVpW4ycUAGEAYNeRlJkHlOgtaPDfix3u9X8W6ki7+2oH0iaVYFMvat4jOmCBSK+UU/hNV4AkHzG9xgQrZfHmG1lehhoYuV+6/uVCAF9jdyzMWPiSaQt2il/WHrA521TgOjGYXQP//fcNwfi2dQVOB7oJUCU+RAWfWvVTZE3phGyows+qW9NFQRNGS3BuoRPXXVB0rBsTjEWEVRyFpMJ8liNYLW1dDFE+F99pxtXqDcXVfhT9uCXnLWvt/8tsdhHpQ73D73PIoUOePCZFp4ltu3f5n6OpWZ/5bCqWiRrqiDLWsjxQrViyaoEf6tcL0OoFYsfiqkxTIoDVLJKEkjVdcKW8awQk1+rE2Ab54Wy5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6397.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(396003)(39860400002)(136003)(376002)(451199015)(31686004)(83380400001)(86362001)(31696002)(54906003)(6506007)(6916009)(966005)(6486002)(6666004)(36756003)(38100700002)(82960400001)(2616005)(186003)(5660300002)(26005)(53546011)(6512007)(478600001)(66556008)(66476007)(8676002)(66946007)(316002)(2906002)(4326008)(8936002)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2JTZHNTczczRVcyRU5KNEU0emkveWx1QlREZTlnaVVRSTlQRms1SVM1WjJs?=
 =?utf-8?B?NDhPM25UUndBN3RVc3lXYWlmY3RlL2prM3ZWR3pKaTNlbDRxL0k5ZFRrMFJm?=
 =?utf-8?B?a1JWNjVZSi85TllZL05oN0ZOalQzbzhsblJkMDBBb0x5MXY4VFlUMVFiRlIv?=
 =?utf-8?B?ZGZjWkFvUkZWUVhBVUtneWhxMEtSRTMweWVyL2h1YTY5MmQ4bWdteXJLR1ow?=
 =?utf-8?B?dG9FRVpoSTVhUjE5eEw4ZnpMR24xRXlBaTNkL1hybUlRQWRUTGtrNzhDMFp5?=
 =?utf-8?B?U25kcVIzYkltcDk0RFlvbkZmdlVsWXpvUmZ4bkRoTWQ5UEtwNGtIVXBxa3lM?=
 =?utf-8?B?MjNzZkMxeHBndm5Wam16YUxrVzYxbUMwNGJuTFdCaEx6Sk11RmV6cjBNeEhV?=
 =?utf-8?B?UzhQeHZpLytMZHFVWE1zVHFvY1gveTVsamMxZFVnZko0WkdRdUdEdUdSYTdp?=
 =?utf-8?B?SjA2cnc3cjJXNkFBbENNdXFNSE9ZREU0YXQ3NktSbG5lR1RobzRoTUtMZ1No?=
 =?utf-8?B?M1E5SXJRMjZLd3cxSG1sMGlZVFZRSEp0OHNQSElwRU5YTVZGK0NDUGlSYUh5?=
 =?utf-8?B?bHFqZWwwbE9MSW1vNXFGTW9NWWRlN1duNkJXZ2ZSV1BsaXZ3ZlZ6TExtMmVF?=
 =?utf-8?B?VjhWQVJWM1UycThFZ2ZQSm5xckVYU3JUVnFUVlZwZzYvU2VpRGFabGdqZTUx?=
 =?utf-8?B?eGVKL2hONjBXM0lseWhNcWYvWFJQdCszT0RvWHdWQ0FNYmIyUUdsMkJPYmRM?=
 =?utf-8?B?R3pWMEtTc1ZkMGJUbWxQR0lTemc2VlNpRnFLRDdMemVCQmluZ3d5d055RVk3?=
 =?utf-8?B?U1pLMm9DdHphUnl6S3Z6SHppWEs0c1d3ZlFjVUp6U2N3d3VhN200WTFIT1J6?=
 =?utf-8?B?TTJuVVBMR1MweTRWMGtaOGlSd1VhWllRSzVESU1OcElxMjM5RGYxcVB2NUdV?=
 =?utf-8?B?aWRXaFlpN2kzRWZmbTZ2Y2lZWTEweEdmZDVZcWtpWi93WUhiRHhrVUNOTS9u?=
 =?utf-8?B?TXBLbSsvWnFWZUlibElyTTEvVFgvWEd6S0VLVHBLa1lKTDZ3RFNkV0JvS0hG?=
 =?utf-8?B?VnA0dFNobkpwMWdWMENvTE5UUFAzWTcySEx3QUV3U0d4SmRZamNMODhHQTBs?=
 =?utf-8?B?QVUwK2VVWXVlaHN4VWU2TWsyVW5nWkdxRDc1aGIvR0lyRE43bVZDVUxpay8r?=
 =?utf-8?B?aG5yckNXNFcyS2VFYnNIVXlpRVRaTERqYlFIOGpLOEtoZmNvZ1E3MHhQSFVp?=
 =?utf-8?B?VUZ4UmNyYTZ4YnlOcVY4NkxING1panQ0RFNWb0l0S2JZZXFSSlAyMWdqdXFq?=
 =?utf-8?B?ZGRIRjlJbXo4QjhieFJtUEZFUzF6QWh4SzVkNUUxVlVwVDBQeHNMNzF0T2Fu?=
 =?utf-8?B?MXc1am9MT3RGa3l3QXhKN3lzcEU3M1E5cHNVemZvRVMwYzhJRVpKRmRXc2Nj?=
 =?utf-8?B?RVVVdE54ZHMxU3ZKYThhdEo2YkV1azEzN3BOOU5DdHZocHpXcUxLMUVsT3Bw?=
 =?utf-8?B?TmtHa0VXVmpCaWZEQm1BNW5LVlpuZWgzTmVhcTlRTkFLUFJjRFNVMlJXSXJh?=
 =?utf-8?B?OUY0QmVRTlB0ZHhFV0x4a1VpbDJzWXBVcGxEQkkrWFFOQWIySTVXMGpubnJD?=
 =?utf-8?B?cjRoaTQyVm5YMU1HZkFPT0JGaVovMkxOb3ZRcWYwd2gwZ2tLamZjdjZhdlZP?=
 =?utf-8?B?RTg5RFJLNWp1OXRYMUxhd3Rna3pIQTZqMEFYdVBzYWRYeWpZZTNoUzVoNC9l?=
 =?utf-8?B?d3FSbVlqbm1YTTQ1NU9sVUJNZ1QxRXJVVTFVckxGUHJWQXZuaG5PbVNsTVRP?=
 =?utf-8?B?VDEwUVgzQkc4Q1FhRnp4OW5nVERyN05QYTZLOUNPWUgvOFdoVlBQLzUreXRR?=
 =?utf-8?B?M2p6eXR2TjQwRlJzM3h6dXU0UVlaOXN3V1h3YVZaNHR2eHA2NXRBcFFmWFNs?=
 =?utf-8?B?QXRRU2hWalJTcGlDeENlK1Qzd3NkK1VGTmdYRFhrM25aZys1L1pyemo3dHJD?=
 =?utf-8?B?a0lTUDAyRFNRbmNubVdJbzJMdlZodXgyeDNBQksvMkdBMU1nYWxuMGUycVVu?=
 =?utf-8?B?dit2ZmxxbVRNczVPdkRYS1BQdExvMVMzR1JtUlc4ZmRkaGRrWUhJMHlMeTgx?=
 =?utf-8?B?eW82STZhVUJ4MDR5dnlVNmxSUExOaWVqeGpMNkIyN1JQOVBGOEgyK2FJdExk?=
 =?utf-8?B?Q0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ae47b5fa-e9fa-4bf2-2166-08dacdeff4bf
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6397.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2022 07:46:11.6984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S+/6rZpvobWMzlw8NH7Q8rY5Z8iIhXZA+vq3eCVzgfxqDbUnqoCbXoooRP7s37hPSdgVvF6QxpuON4S5SgtBnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5548
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Sorry for this false alarm. We found the root cause was due to a problem
in our testing environment, and it has been fixed now.

On 11/23/2022 17:25, kernel test robot wrote:
> Hi Sai,
> 
> We encountered an "Initramfs unpacking failed" issue when doing boot
> test on this patch. The patch is for printing accurate debug info under
> compiler optimization, looks totally unrelated with initramfs, but this
> issue is 100% reproducible in our tests. We confirmed that our rootfs
> image, kernel config and other environments were consistent during the
> testing. Could you please help check if this is a real problem or a
> false alarm? Thanks.
> 
> 
> Greeting,
> 
> FYI, we noticed Initramfs_unpacking_failed due to commit (built with gcc-11):
> 
> commit: 5e5ff73c2e5863f93fc5fd78d178cd8f2af12464 ("asm-generic/io: Add _RET_IP_ to MMIO trace for more accurate debug info")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> 
> in testcase: boot
> 
> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> [ 3.518862][ T1] initcall pci_apply_final_quirks+0x0/0x32c returned 0 after 10472 usecs
> [ 3.520299][ T1] calling acpi_reserve_resources+0x0/0x273 @ 1
> [ 3.521395][ T1] initcall acpi_reserve_resources+0x0/0x273 returned 0 after 61 usecs
> [ 3.522853][ T1] calling populate_rootfs+0x0/0x3c @ 1
> [    3.524393][   T25] Trying to unpack rootfs image as initramfs...
> [   30.185500][   T25] Initramfs unpacking failed: uncompression error   <--
> [   30.931793][   T25] Freeing initrd memory: 607016K
> [ 30.932869][ T1] initcall populate_rootfs+0x0/0x3c returned 0 after 27409026 usecs
> [ 30.934238][ T1] calling pci_iommu_init+0x0/0x55 @ 1
> [   30.935230][    T1] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
> [   30.936475][    T1] software IO TLB: mapped [mem 0x0000000096f16000-0x000000009af16000] (64MB)
> 
> 
> If you fix the issue, kindly add following tag
> | Reported-by: kernel test robot <yujie.liu@intel.com>
> | Link: https://lore.kernel.org/oe-lkp/202211231652.f67208c7-yujie.liu@intel.com
> 
> 
> To reproduce:
> 
>          # build kernel
> 	cd linux
> 	cp config-6.1.0-rc3-00002-g5e5ff73c2e58.old .config
> 	make HOSTCC=gcc-11 CC=gcc-11 ARCH=x86_64 olddefconfig prepare modules_prepare bzImage modules
> 	make HOSTCC=gcc-11 CC=gcc-11 ARCH=x86_64 INSTALL_MOD_PATH=<mod-install-dir> modules_install
> 	cd <mod-install-dir>
> 	find lib/ | cpio -o -H newc --quiet | gzip > modules.cgz
> 
> 
>          git clone https://github.com/intel/lkp-tests.git
>          cd lkp-tests
>          bin/lkp qemu -k <bzImage> -m modules.cgz job-script # job-script is attached in this email
> 
>          # if come across any failure that blocks the test,
>          # please remove ~/.lkp and /lkp dir to run from a clean state.
> 
> 
