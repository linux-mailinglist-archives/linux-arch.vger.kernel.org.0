Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 625177B4229
	for <lists+linux-arch@lfdr.de>; Sat, 30 Sep 2023 18:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234526AbjI3Qdx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 30 Sep 2023 12:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232221AbjI3Qdw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 30 Sep 2023 12:33:52 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C057DA;
        Sat, 30 Sep 2023 09:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696091628; x=1727627628;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wivL2FNMHrv0kFxgem2g4Ng1yRrT2EUjB8vIvh8nWZg=;
  b=JAOV3r//8b22z/IhPe17qXBC6cZEJpEr4RNz7wieo7xFOrKnjl2241Sy
   Z2VhAIAjRDSbY+rDm/crJvMhCAUiLcGFfAvoP2ohiwUjIRI7BHeGlFeZ7
   ryauSkVT8cRCUUqgMzg291WdwacJXDkURi6ZDHL74lYvbW3Cn7Vw9Szsw
   fLJtlKi7sjPgr5zdqMrPSIfeyS9MKJp5BEzk/LSxgim9D1Ov/3TEn/4RE
   oyT5fN+4ooE5Q8XfinENgbxXaIAzT/Sg7lfw/X6XTZSGKnQukZ5rFpXXw
   7W+45/S6A1PazLmFxHtaOx52nQ7ee6Ik/ah+tAMnCoglDyozURZEKbhYt
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10849"; a="446615903"
X-IronPort-AV: E=Sophos;i="6.03,190,1694761200"; 
   d="scan'208";a="446615903"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2023 09:33:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10849"; a="699932078"
X-IronPort-AV: E=Sophos;i="6.03,190,1694761200"; 
   d="scan'208";a="699932078"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 30 Sep 2023 09:33:40 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qmcuQ-0004IN-29;
        Sat, 30 Sep 2023 16:33:38 +0000
Date:   Sun, 1 Oct 2023 00:33:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, patches@lists.linux.dev,
        mikelley@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
        gregkh@linuxfoundation.org, haiyangz@microsoft.com,
        decui@microsoft.com, apais@linux.microsoft.com,
        Tianyu.Lan@microsoft.com, ssengar@linux.microsoft.com,
        mukeshrathor@microsoft.com, stanislav.kinsburskiy@gmail.com,
        jinankjain@linux.microsoft.com, vkuznets@redhat.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, will@kernel.org,
        catalin.marinas@arm.com
Subject: Re: [PATCH v4 13/15] uapi: hyperv: Add mshv driver headers defining
 hypervisor ABIs
Message-ID: <202310010025.o6cTttg5-lkp@intel.com>
References: <1696010501-24584-14-git-send-email-nunodasneves@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1696010501-24584-14-git-send-email-nunodasneves@linux.microsoft.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Nuno,

kernel test robot noticed the following build errors:

[auto build test ERROR on arnd-asm-generic/master]
[also build test ERROR on arm64/for-next/core linus/master v6.6-rc3 next-20230929]
[cannot apply to tip/x86/core]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Nuno-Das-Neves/hyperv-tlfs-Change-shared-HV_REGISTER_-defines-to-HV_MSR_/20230930-041305
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git master
patch link:    https://lore.kernel.org/r/1696010501-24584-14-git-send-email-nunodasneves%40linux.microsoft.com
patch subject: [PATCH v4 13/15] uapi: hyperv: Add mshv driver headers defining hypervisor ABIs
config: i386-randconfig-013-20230930 (https://download.01.org/0day-ci/archive/20231001/202310010025.o6cTttg5-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231001/202310010025.o6cTttg5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310010025.o6cTttg5-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from ./usr/include/hyperv/hvgdk.h:17,
                    from <command-line>:
>> ./usr/include/hyperv/hvgdk_mini.h:18:9: error: unknown type name '__u64'
      18 |         __u64 low_part;
         |         ^~~~~
   ./usr/include/hyperv/hvgdk_mini.h:19:9: error: unknown type name '__u64'
      19 |         __u64 high_part;
         |         ^~~~~
>> ./usr/include/hyperv/hvgdk_mini.h:170:17: error: unknown type name '__u32'
     170 |                 __u32 build_number;
         |                 ^~~~~
   ./usr/include/hyperv/hvgdk_mini.h:172:17: error: unknown type name '__u32'
     172 |                 __u32 minor_version : 16;
         |                 ^~~~~
   ./usr/include/hyperv/hvgdk_mini.h:173:17: error: unknown type name '__u32'
     173 |                 __u32 major_version : 16;
         |                 ^~~~~
   ./usr/include/hyperv/hvgdk_mini.h:175:17: error: unknown type name '__u32'
     175 |                 __u32 service_pack;
         |                 ^~~~~
   ./usr/include/hyperv/hvgdk_mini.h:177:17: error: unknown type name '__u32'
     177 |                 __u32 service_number : 24;
         |                 ^~~~~
   ./usr/include/hyperv/hvgdk_mini.h:178:17: error: unknown type name '__u32'
     178 |                 __u32 service_branch : 8;
         |                 ^~~~~
   ./usr/include/hyperv/hvgdk_mini.h:181:17: error: unknown type name '__u32'
     181 |                 __u32 eax;
         |                 ^~~~~
   ./usr/include/hyperv/hvgdk_mini.h:182:17: error: unknown type name '__u32'
     182 |                 __u32 ebx;
         |                 ^~~~~
   ./usr/include/hyperv/hvgdk_mini.h:183:17: error: unknown type name '__u32'
     183 |                 __u32 ecx;
         |                 ^~~~~
   ./usr/include/hyperv/hvgdk_mini.h:184:17: error: unknown type name '__u32'
     184 |                 __u32 edx;
         |                 ^~~~~
>> ./usr/include/hyperv/hvgdk_mini.h:266:9: error: unknown type name 'u64'
     266 |         u64 address_space;
         |         ^~~
   ./usr/include/hyperv/hvgdk_mini.h:268:17: error: unknown type name 'u64'
     268 |                 u64 additional_pages:11;
         |                 ^~~
   ./usr/include/hyperv/hvgdk_mini.h:269:17: error: unknown type name 'u64'
     269 |                 u64 largepage:1;
         |                 ^~~
   ./usr/include/hyperv/hvgdk_mini.h:270:17: error: unknown type name 'u64'
     270 |                 u64 basepfn:52;
         |                 ^~~
>> ./usr/include/hyperv/hvgdk_mini.h:270:21: error: width of 'basepfn' exceeds its type
     270 |                 u64 basepfn:52;
         |                     ^~~~~~~
   ./usr/include/hyperv/hvgdk_mini.h:273:17: error: unknown type name 'u64'
     273 |                 u64 reserved:12;
         |                 ^~~
   ./usr/include/hyperv/hvgdk_mini.h:274:17: error: unknown type name 'u64'
     274 |                 u64 page_size:1;
         |                 ^~~
   ./usr/include/hyperv/hvgdk_mini.h:275:17: error: unknown type name 'u64'
     275 |                 u64 reserved1:8;
         |                 ^~~
   ./usr/include/hyperv/hvgdk_mini.h:276:17: error: unknown type name 'u64'
     276 |                 u64 base_large_pfn:43;
         |                 ^~~
>> ./usr/include/hyperv/hvgdk_mini.h:276:21: error: width of 'base_large_pfn' exceeds its type
     276 |                 u64 base_large_pfn:43;
         |                     ^~~~~~~~~~~~~~
   ./usr/include/hyperv/hvgdk_mini.h:308:9: error: unknown type name '__u64'
     308 |         __u64 as_uint64;
         |         ^~~~~
   ./usr/include/hyperv/hvgdk_mini.h:310:17: error: unknown type name '__u64'
     310 |                 __u64 vector : 8;
         |                 ^~~~~
   ./usr/include/hyperv/hvgdk_mini.h:311:17: error: unknown type name '__u64'
     311 |                 __u64 reserved1 : 8;
         |                 ^~~~~
   ./usr/include/hyperv/hvgdk_mini.h:312:17: error: unknown type name '__u64'
     312 |                 __u64 masked : 1;
         |                 ^~~~~
   ./usr/include/hyperv/hvgdk_mini.h:313:17: error: unknown type name '__u64'
     313 |                 __u64 auto_eoi : 1;
         |                 ^~~~~
   ./usr/include/hyperv/hvgdk_mini.h:314:17: error: unknown type name '__u64'
     314 |                 __u64 polling : 1;
         |                 ^~~~~
   ./usr/include/hyperv/hvgdk_mini.h:315:17: error: unknown type name '__u64'
     315 |                 __u64 as_intercept : 1;
         |                 ^~~~~
   ./usr/include/hyperv/hvgdk_mini.h:316:17: error: unknown type name '__u64'
     316 |                 __u64 proxy : 1;
         |                 ^~~~~
   ./usr/include/hyperv/hvgdk_mini.h:317:17: error: unknown type name '__u64'
     317 |                 __u64 reserved2 : 43;
         |                 ^~~~~
>> ./usr/include/hyperv/hvgdk_mini.h:317:23: error: width of 'reserved2' exceeds its type
     317 |                 __u64 reserved2 : 43;
         |                       ^~~~~~~~~
   ./usr/include/hyperv/hvgdk_mini.h:322:9: error: unknown type name '__u64'
     322 |         __u64 as_uint64;
         |         ^~~~~
   ./usr/include/hyperv/hvgdk_mini.h:324:17: error: unknown type name '__u32'
     324 |                 __u32 low_uint32;
         |                 ^~~~~
   ./usr/include/hyperv/hvgdk_mini.h:325:17: error: unknown type name '__u32'
     325 |                 __u32 high_uint32;
         |                 ^~~~~
   ./usr/include/hyperv/hvgdk_mini.h:328:17: error: unknown type name '__u64'
     328 |                 __u64 legacy_x87 : 1;
         |                 ^~~~~
   ./usr/include/hyperv/hvgdk_mini.h:329:17: error: unknown type name '__u64'
     329 |                 __u64 legacy_sse : 1;
         |                 ^~~~~
   ./usr/include/hyperv/hvgdk_mini.h:330:17: error: unknown type name '__u64'
     330 |                 __u64 avx : 1;
         |                 ^~~~~
   ./usr/include/hyperv/hvgdk_mini.h:331:17: error: unknown type name '__u64'
     331 |                 __u64 mpx_bndreg : 1;
         |                 ^~~~~
   ./usr/include/hyperv/hvgdk_mini.h:332:17: error: unknown type name '__u64'
     332 |                 __u64 mpx_bndcsr : 1;
         |                 ^~~~~
   ./usr/include/hyperv/hvgdk_mini.h:333:17: error: unknown type name '__u64'
     333 |                 __u64 avx_512_op_mask : 1;
         |                 ^~~~~
   ./usr/include/hyperv/hvgdk_mini.h:334:17: error: unknown type name '__u64'
     334 |                 __u64 avx_512_zmmhi : 1;
         |                 ^~~~~
   ./usr/include/hyperv/hvgdk_mini.h:335:17: error: unknown type name '__u64'
     335 |                 __u64 avx_512_zmm16_31 : 1;
         |                 ^~~~~
   ./usr/include/hyperv/hvgdk_mini.h:336:17: error: unknown type name '__u64'
     336 |                 __u64 rsvd8_9 : 2;
         |                 ^~~~~
   ./usr/include/hyperv/hvgdk_mini.h:337:17: error: unknown type name '__u64'
     337 |                 __u64 pasid : 1;
         |                 ^~~~~
   ./usr/include/hyperv/hvgdk_mini.h:338:17: error: unknown type name '__u64'
     338 |                 __u64 cet_u : 1;
         |                 ^~~~~
   ./usr/include/hyperv/hvgdk_mini.h:339:17: error: unknown type name '__u64'
     339 |                 __u64 cet_s : 1;
         |                 ^~~~~
   ./usr/include/hyperv/hvgdk_mini.h:340:17: error: unknown type name '__u64'
     340 |                 __u64 rsvd13_16 : 4;
         |                 ^~~~~
   ./usr/include/hyperv/hvgdk_mini.h:341:17: error: unknown type name '__u64'
     341 |                 __u64 xtile_cfg : 1;
         |                 ^~~~~
   ./usr/include/hyperv/hvgdk_mini.h:342:17: error: unknown type name '__u64'
     342 |                 __u64 xtile_data : 1;
         |                 ^~~~~
   ./usr/include/hyperv/hvgdk_mini.h:343:17: error: unknown type name '__u64'
     343 |                 __u64 rsvd19_63 : 45;
         |                 ^~~~~
>> ./usr/include/hyperv/hvgdk_mini.h:343:23: error: width of 'rsvd19_63' exceeds its type
     343 |                 __u64 rsvd19_63 : 45;
         |                       ^~~~~~~~~
   ./usr/include/hyperv/hvgdk_mini.h:352:9: error: unknown type name '__u32'
     352 |         __u32 asu32;
         |         ^~~~~
   ./usr/include/hyperv/hvgdk_mini.h:354:17: error: unknown type name '__u32'
     354 |                 __u32 id : 24;
         |                 ^~~~~
   ./usr/include/hyperv/hvgdk_mini.h:355:17: error: unknown type name '__u32'
     355 |                 __u32 reserved : 8;
         |                 ^~~~~
>> ./usr/include/hyperv/hvgdk_mini.h:356:38: error: C++ style comments are not allowed in ISO C90
     356 |         } __attribute__((packed)) u; // TODO remove this u
         |                                      ^
   ./usr/include/hyperv/hvgdk_mini.h:356:38: note: (this will be reported only once per input file)
   ./usr/include/hyperv/hvgdk_mini.h:418:9: error: unknown type name '__u64'
     418 |         __u64 as_uint64;
         |         ^~~~~
   ./usr/include/hyperv/hvgdk_mini.h:420:17: error: unknown type name '__u64'
     420 |                 __u64 simp_enabled : 1;
         |                 ^~~~~
   ./usr/include/hyperv/hvgdk_mini.h:421:17: error: unknown type name '__u64'
     421 |                 __u64 preserved : 11;
         |                 ^~~~~
   ./usr/include/hyperv/hvgdk_mini.h:422:17: error: unknown type name '__u64'
     422 |                 __u64 base_simp_gpa : 52;
         |                 ^~~~~
>> ./usr/include/hyperv/hvgdk_mini.h:422:23: error: width of 'base_simp_gpa' exceeds its type
     422 |                 __u64 base_simp_gpa : 52;
         |                       ^~~~~~~~~~~~~
>> ./usr/include/hyperv/hvgdk_mini.h:427:9: error: unknown type name '__u8'
     427 |         __u8 asu8;
         |         ^~~~
   ./usr/include/hyperv/hvgdk_mini.h:429:17: error: unknown type name '__u8'
     429 |                 __u8 msg_pending : 1;
         |                 ^~~~
   ./usr/include/hyperv/hvgdk_mini.h:430:17: error: unknown type name '__u8'
     430 |                 __u8 reserved : 7;
         |                 ^~~~
   ./usr/include/hyperv/hvgdk_mini.h:435:9: error: unknown type name '__u32'
     435 |         __u32 message_type;
         |         ^~~~~
   ./usr/include/hyperv/hvgdk_mini.h:436:9: error: unknown type name '__u8'
     436 |         __u8 payload_size;
         |         ^~~~
   ./usr/include/hyperv/hvgdk_mini.h:438:9: error: unknown type name '__u8'
     438 |         __u8 reserved[2];
         |         ^~~~
   ./usr/include/hyperv/hvgdk_mini.h:440:17: error: unknown type name '__u64'
     440 |                 __u64 sender;
         |                 ^~~~~
   ./usr/include/hyperv/hvgdk_mini.h:450:9: error: unknown type name '__u32'
     450 |         __u32 sint_index;
         |         ^~~~~
   ./usr/include/hyperv/hvgdk_mini.h:456:17: error: unknown type name '__u64'
     456 |                 __u64 payload[HV_MESSAGE_PAYLOAD_QWORD_COUNT];
         |                 ^~~~~
   ./usr/include/hyperv/hvgdk_mini.h:466:9: error: unknown type name '__u64'
     466 |         __u64 base;
         |         ^~~~~
   ./usr/include/hyperv/hvgdk_mini.h:467:9: error: unknown type name '__u32'
     467 |         __u32 limit;
         |         ^~~~~
>> ./usr/include/hyperv/hvgdk_mini.h:468:9: error: unknown type name '__u16'
     468 |         __u16 selector;
         |         ^~~~~
   ./usr/include/hyperv/hvgdk_mini.h:471:25: error: unknown type name '__u16'
     471 |                         __u16 segment_type : 4;
         |                         ^~~~~
   ./usr/include/hyperv/hvgdk_mini.h:472:25: error: unknown type name '__u16'
     472 |                         __u16 non_system_segment : 1;
         |                         ^~~~~
   ./usr/include/hyperv/hvgdk_mini.h:473:25: error: unknown type name '__u16'
     473 |                         __u16 descriptor_privilege_level : 2;
         |                         ^~~~~
   ./usr/include/hyperv/hvgdk_mini.h:474:25: error: unknown type name '__u16'
     474 |                         __u16 present : 1;
         |                         ^~~~~
   ./usr/include/hyperv/hvgdk_mini.h:475:25: error: unknown type name '__u16'
     475 |                         __u16 reserved : 4;
         |                         ^~~~~
   ./usr/include/hyperv/hvgdk_mini.h:476:25: error: unknown type name '__u16'
     476 |                         __u16 available : 1;
         |                         ^~~~~
   ./usr/include/hyperv/hvgdk_mini.h:477:25: error: unknown type name '__u16'
     477 |                         __u16 _long : 1;
         |                         ^~~~~
   ./usr/include/hyperv/hvgdk_mini.h:478:25: error: unknown type name '__u16'
     478 |                         __u16 _default : 1;
         |                         ^~~~~
   ./usr/include/hyperv/hvgdk_mini.h:479:25: error: unknown type name '__u16'
     479 |                         __u16 granularity : 1;
         |                         ^~~~~
   ./usr/include/hyperv/hvgdk_mini.h:481:17: error: unknown type name '__u16'
     481 |                 __u16 attributes;
         |                 ^~~~~
   ./usr/include/hyperv/hvgdk_mini.h:486:9: error: unknown type name '__u16'
     486 |         __u16 pad[3];
         |         ^~~~~
   ./usr/include/hyperv/hvgdk_mini.h:487:9: error: unknown type name '__u16'
     487 |         __u16 limit;
         |         ^~~~~
   ./usr/include/hyperv/hvgdk_mini.h:488:9: error: unknown type name '__u64'
     488 |         __u64 base;
         |         ^~~~~
   ./usr/include/hyperv/hvgdk_mini.h:494:17: error: unknown type name '__u16'
     494 |                 __u16 fp_control;
         |                 ^~~~~
   ./usr/include/hyperv/hvgdk_mini.h:495:17: error: unknown type name '__u16'
     495 |                 __u16 fp_status;
         |                 ^~~~~
   ./usr/include/hyperv/hvgdk_mini.h:496:17: error: unknown type name '__u8'
     496 |                 __u8 fp_tag;
         |                 ^~~~
   ./usr/include/hyperv/hvgdk_mini.h:497:17: error: unknown type name '__u8'
     497 |                 __u8 reserved;
         |                 ^~~~
   ./usr/include/hyperv/hvgdk_mini.h:498:17: error: unknown type name '__u16'
     498 |                 __u16 last_fp_op;
         |                 ^~~~~
   ./usr/include/hyperv/hvgdk_mini.h:501:25: error: unknown type name '__u64'
     501 |                         __u64 last_fp_rip;
         |                         ^~~~~
   ./usr/include/hyperv/hvgdk_mini.h:504:33: error: unknown type name '__u32'
     504 |                                 __u32 last_fp_eip;
         |                                 ^~~~~
   ./usr/include/hyperv/hvgdk_mini.h:505:33: error: unknown type name '__u16'
     505 |                                 __u16 last_fp_cs;
         |                                 ^~~~~
   ./usr/include/hyperv/hvgdk_mini.h:506:33: error: unknown type name '__u16'
     506 |                                 __u16 padding;
         |                                 ^~~~~
   ./usr/include/hyperv/hvgdk_mini.h:517:25: error: unknown type name '__u64'
     517 |                         __u64 last_fp_rdp;
         |                         ^~~~~
   ./usr/include/hyperv/hvgdk_mini.h:520:33: error: unknown type name '__u32'
     520 |                                 __u32 last_fp_dp;
         |                                 ^~~~~
   ./usr/include/hyperv/hvgdk_mini.h:521:33: error: unknown type name '__u16'
     521 |                                 __u16 last_fp_ds;
         |                                 ^~~~~
   ./usr/include/hyperv/hvgdk_mini.h:522:33: error: unknown type name '__u16'
     522 |                                 __u16 padding;
         |                                 ^~~~~
   ./usr/include/hyperv/hvgdk_mini.h:525:17: error: unknown type name '__u32'
     525 |                 __u32 xmm_status_control;
         |                 ^~~~~
   ./usr/include/hyperv/hvgdk_mini.h:526:17: error: unknown type name '__u32'
     526 |                 __u32 xmm_status_control_mask;
         |                 ^~~~~
   ./usr/include/hyperv/hvgdk_mini.h:533:17: error: unknown type name '__u64'
     533 |                 __u64 mantissa;
         |                 ^~~~~
   ./usr/include/hyperv/hvgdk_mini.h:534:17: error: unknown type name '__u64'
     534 |                 __u64 biased_exponent : 15;
         |                 ^~~~~
   ./usr/include/hyperv/hvgdk_mini.h:535:17: error: unknown type name '__u64'
     535 |                 __u64 sign : 1;
         |                 ^~~~~
   ./usr/include/hyperv/hvgdk_mini.h:536:17: error: unknown type name '__u64'
     536 |                 __u64 reserved : 48;
         |                 ^~~~~
>> ./usr/include/hyperv/hvgdk_mini.h:536:23: error: width of 'reserved' exceeds its type
     536 |                 __u64 reserved : 48;
         |                       ^~~~~~~~
   ./usr/include/hyperv/hvgdk_mini.h:541:9: error: unknown type name '__u64'
     541 |         __u64 as_uint64;
         |         ^~~~~
   ./usr/include/hyperv/hvgdk_mini.h:547:17: error: unknown type name '__u64'
     547 |                 __u64 prevents_gdt : 1;
         |                 ^~~~~
   ./usr/include/hyperv/hvgdk_mini.h:548:17: error: unknown type name '__u64'
     548 |                 __u64 prevents_idt : 1;
         |                 ^~~~~
   ./usr/include/hyperv/hvgdk_mini.h:549:17: error: unknown type name '__u64'
     549 |                 __u64 prevents_ldt : 1;
         |                 ^~~~~
   ./usr/include/hyperv/hvgdk_mini.h:550:17: error: unknown type name '__u64'
     550 |                 __u64 prevents_tr : 1;
         |                 ^~~~~
   ./usr/include/hyperv/hvgdk_mini.h:553:17: error: unknown type name '__u64'
     553 |                 __u64 reserved : 60;
         |                 ^~~~~
   ./usr/include/hyperv/hvgdk_mini.h:553:23: error: width of 'reserved' exceeds its type
     553 |                 __u64 reserved : 60;
         |                       ^~~~~~~~
   ./usr/include/hyperv/hvgdk_mini.h:558:9: error: unknown type name '__u8'
     558 |         __u8 as_uint8;
         |         ^~~~
   ./usr/include/hyperv/hvgdk_mini.h:560:17: error: unknown type name '__u8'
     560 |                 __u8 target_vtl : 4;
         |                 ^~~~
   ./usr/include/hyperv/hvgdk_mini.h:561:17: error: unknown type name '__u8'
     561 |                 __u8 use_target_vtl : 1;
         |                 ^~~~
   ./usr/include/hyperv/hvgdk_mini.h:562:17: error: unknown type name '__u8'
     562 |                 __u8 reserved_z : 3;
         |                 ^~~~
   ./usr/include/hyperv/hvgdk_mini.h:570:9: error: unknown type name '__u64'
     570 |         __u64 as_u64;
         |         ^~~~~
   ./usr/include/hyperv/hvgdk_mini.h:572:17: error: unknown type name '__u64'
     572 |                 __u64 enable_vtl_protection : 1;
         |                 ^~~~~
   ./usr/include/hyperv/hvgdk_mini.h:573:17: error: unknown type name '__u64'
     573 |                 __u64 default_vtl_protection_mask : 4;
         |                 ^~~~~
   ./usr/include/hyperv/hvgdk_mini.h:574:17: error: unknown type name '__u64'
     574 |                 __u64 zero_memory_on_reset : 1;
         |                 ^~~~~
   ./usr/include/hyperv/hvgdk_mini.h:575:17: error: unknown type name '__u64'
     575 |                 __u64 deny_lower_vtl_startup : 1;
         |                 ^~~~~
   ./usr/include/hyperv/hvgdk_mini.h:576:17: error: unknown type name '__u64'
     576 |                 __u64 intercept_acceptance : 1;
         |                 ^~~~~
   ./usr/include/hyperv/hvgdk_mini.h:577:17: error: unknown type name '__u64'
     577 |                 __u64 intercept_enable_vtl_protection : 1;
         |                 ^~~~~
   ./usr/include/hyperv/hvgdk_mini.h:578:17: error: unknown type name '__u64'
     578 |                 __u64 intercept_vp_startup : 1;
         |                 ^~~~~
   ./usr/include/hyperv/hvgdk_mini.h:579:17: error: unknown type name '__u64'
     579 |                 __u64 intercept_cpuid_unimplemented : 1;
         |                 ^~~~~
   ./usr/include/hyperv/hvgdk_mini.h:580:17: error: unknown type name '__u64'
     580 |                 __u64 intercept_unrecoverable_exception : 1;
         |                 ^~~~~
   ./usr/include/hyperv/hvgdk_mini.h:581:17: error: unknown type name '__u64'
     581 |                 __u64 intercept_page : 1;
         |                 ^~~~~
   ./usr/include/hyperv/hvgdk_mini.h:582:17: error: unknown type name '__u64'
     582 |                 __u64 mbz : 51;
         |                 ^~~~~
>> ./usr/include/hyperv/hvgdk_mini.h:582:23: error: width of 'mbz' exceeds its type
     582 |                 __u64 mbz : 51;
         |                       ^~~
   ./usr/include/hyperv/hvgdk_mini.h:588:17: error: unknown type name '__u32'
     588 |                 __u32 directhypercall : 1;
         |                 ^~~~~
   ./usr/include/hyperv/hvgdk_mini.h:589:17: error: unknown type name '__u32'
     589 |                 __u32 reserved : 31;
         |                 ^~~~~
   ./usr/include/hyperv/hvgdk_mini.h:592:17: error: unknown type name '__u32'
     592 |                 __u32 inter_partition_comm : 1;
         |                 ^~~~~
   ./usr/include/hyperv/hvgdk_mini.h:593:17: error: unknown type name '__u32'
     593 |                 __u32 reserved : 31;
         |                 ^~~~~
   ./usr/include/hyperv/hvgdk_mini.h:599:9: error: unknown type name '__u32'
     599 |         __u32 apic_assist;
         |         ^~~~~
   ./usr/include/hyperv/hvgdk_mini.h:600:9: error: unknown type name '__u32'
     600 |         __u32 reserved1;
         |         ^~~~~
   ./usr/include/hyperv/hvgdk_mini.h:601:9: error: unknown type name '__u32'
     601 |         __u32 vtl_entry_reason;
         |         ^~~~~
   ./usr/include/hyperv/hvgdk_mini.h:602:9: error: unknown type name '__u32'
     602 |         __u32 vtl_reserved;
         |         ^~~~~
   ./usr/include/hyperv/hvgdk_mini.h:603:9: error: unknown type name '__u64'
     603 |         __u64 vtl_ret_x64rax;
         |         ^~~~~
   ./usr/include/hyperv/hvgdk_mini.h:604:9: error: unknown type name '__u64'
     604 |         __u64 vtl_ret_x64rcx;
         |         ^~~~~
   ./usr/include/hyperv/hvgdk_mini.h:606:9: error: unknown type name '__u8'
     606 |         __u8 enlighten_vmentry;
         |         ^~~~
   ./usr/include/hyperv/hvgdk_mini.h:607:9: error: unknown type name '__u8'
     607 |         __u8 reserved2[7];
         |         ^~~~
   ./usr/include/hyperv/hvgdk_mini.h:608:9: error: unknown type name '__u64'
     608 |         __u64 current_nested_vmcs;
         |         ^~~~~
   ./usr/include/hyperv/hvgdk_mini.h:609:9: error: unknown type name '__u8'
     609 |         __u8 synthetic_time_unhalted_timer_expired;
         |         ^~~~
   ./usr/include/hyperv/hvgdk_mini.h:610:9: error: unknown type name '__u8'
     610 |         __u8 reserved3[7];
         |         ^~~~
   ./usr/include/hyperv/hvgdk_mini.h:611:9: error: unknown type name '__u8'
     611 |         __u8 virtualization_fault_information[40];
         |         ^~~~
   ./usr/include/hyperv/hvgdk_mini.h:612:9: error: unknown type name '__u8'
     612 |         __u8 reserved4[8];
         |         ^~~~
   ./usr/include/hyperv/hvgdk_mini.h:613:9: error: unknown type name '__u8'
     613 |         __u8 intercept_message[256];
         |         ^~~~
   ./usr/include/hyperv/hvgdk_mini.h:614:9: error: unknown type name '__u8'
     614 |         __u8 vtl_ret_actions[256];
         |         ^~~~
   ./usr/include/hyperv/hvgdk_mini.h:847:9: error: unknown type name '__u64'
     847 |         __u64 as_uint64;
         |         ^~~~~
   ./usr/include/hyperv/hvgdk_mini.h:849:17: error: unknown type name '__u64'
     849 |                 __u64 suspended : 1;
         |                 ^~~~~
   ./usr/include/hyperv/hvgdk_mini.h:850:17: error: unknown type name '__u64'
     850 |                 __u64 reserved : 63;
         |                 ^~~~~
   ./usr/include/hyperv/hvgdk_mini.h:850:23: error: width of 'reserved' exceeds its type
     850 |                 __u64 reserved : 63;
         |                       ^~~~~~~~
   ./usr/include/hyperv/hvgdk_mini.h:855:9: error: unknown type name '__u64'
     855 |         __u64 as_uint64;
         |         ^~~~~
   ./usr/include/hyperv/hvgdk_mini.h:857:17: error: unknown type name '__u64'
     857 |                 __u64 suspended : 1;
         |                 ^~~~~
   ./usr/include/hyperv/hvgdk_mini.h:858:17: error: unknown type name '__u64'
     858 |                 __u64 reserved : 63;
         |                 ^~~~~
   ./usr/include/hyperv/hvgdk_mini.h:858:23: error: width of 'reserved' exceeds its type
     858 |                 __u64 reserved : 63;
         |                       ^~~~~~~~
   ./usr/include/hyperv/hvgdk_mini.h:863:9: error: unknown type name '__u64'
     863 |         __u64 as_uint64;
         |         ^~~~~
   ./usr/include/hyperv/hvgdk_mini.h:865:17: error: unknown type name '__u64'
     865 |                 __u64 suspended : 1;
         |                 ^~~~~
   ./usr/include/hyperv/hvgdk_mini.h:866:17: error: unknown type name '__u64'
     866 |                 __u64 reserved : 63;
         |                 ^~~~~
   ./usr/include/hyperv/hvgdk_mini.h:866:23: error: width of 'reserved' exceeds its type
     866 |                 __u64 reserved : 63;
         |                       ^~~~~~~~
   ./usr/include/hyperv/hvgdk_mini.h:871:9: error: unknown type name '__u64'
     871 |         __u64 as_uint64;
         |         ^~~~~
   ./usr/include/hyperv/hvgdk_mini.h:873:17: error: unknown type name '__u64'
     873 |                 __u64 interrupt_shadow : 1;
..

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
