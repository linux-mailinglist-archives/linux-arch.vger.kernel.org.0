Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1F457E194F
	for <lists+linux-arch@lfdr.de>; Mon,  6 Nov 2023 05:04:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbjKFEEL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 5 Nov 2023 23:04:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbjKFEEL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 5 Nov 2023 23:04:11 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB80D6;
        Sun,  5 Nov 2023 20:04:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699243446; x=1730779446;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=36G3s3mjGbJFq5j/NhFGstt1RlPdX0X1ykdfnGuTgYY=;
  b=KC6dhKP7Cpe0oDxvaoZ/uw6UwmEuIV3NQxAQlnVMz8ugQUP8O6zM4+rI
   mN9NkihSa/kI0iVy1T5rP69TDVUzXEGp31XoscpfY2lyYcLGzQ1mOQfB3
   cVd/OtDv4YfCyul+B92xFSL8SaQQjwZqR7KtKwTvKAS0/PkokQZucjJFv
   poyaz0HHoeWrId0z0flmilhRlzN6poMzTkjyxcgDQT9SuK07KkCENbUKm
   S8nE1tj85i2Epm93/JiqlI/ZGpwv6VrANRG1KJdR43Zpy0hzL3Utnb1Z/
   Emv7Yt8ClXITcsAVRi+qccpYss5jy5YSDcWa+nOSQRTj+SOufB0S5VpzZ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="420319132"
X-IronPort-AV: E=Sophos;i="6.03,280,1694761200"; 
   d="scan'208";a="420319132"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2023 20:04:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="828081680"
X-IronPort-AV: E=Sophos;i="6.03,280,1694761200"; 
   d="scan'208";a="828081680"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 05 Nov 2023 20:03:59 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qzqqC-000656-2R;
        Mon, 06 Nov 2023 04:03:56 +0000
Date:   Mon, 6 Nov 2023 12:03:31 +0800
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
Subject: Re: [PATCH v4 15/15] Drivers: hv: Add modules to expose /dev/mshv to
 VMMs running on Hyper-V
Message-ID: <202311061139.Zrlkam3w-lkp@intel.com>
References: <1696010501-24584-16-git-send-email-nunodasneves@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1696010501-24584-16-git-send-email-nunodasneves@linux.microsoft.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Nuno,

kernel test robot noticed the following build warnings:

[auto build test WARNING on arnd-asm-generic/master]
[also build test WARNING on tip/x86/core arm64/for-next/core linus/master v6.6 next-20231103]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Nuno-Das-Neves/hyperv-tlfs-Change-shared-HV_REGISTER_-defines-to-HV_MSR_/20230930-041305
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git master
patch link:    https://lore.kernel.org/r/1696010501-24584-16-git-send-email-nunodasneves%40linux.microsoft.com
patch subject: [PATCH v4 15/15] Drivers: hv: Add modules to expose /dev/mshv to VMMs running on Hyper-V
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20231106/202311061139.Zrlkam3w-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231106/202311061139.Zrlkam3w-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311061139.Zrlkam3w-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/hv/hv_call.c:21:5: warning: no previous prototype for 'hv_call_get_vp_registers' [-Wmissing-prototypes]
      21 | int hv_call_get_vp_registers(u32 vp_index, u64 partition_id, u16 count,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/hv/hv_call.c:65:5: warning: no previous prototype for 'hv_call_set_vp_registers' [-Wmissing-prototypes]
      65 | int hv_call_set_vp_registers(u32 vp_index, u64 partition_id, u16 count,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~
--
>> drivers/hv/mshv_root_main.c:1816:12: warning: no previous prototype for 'mshv_root_init' [-Wmissing-prototypes]
    1816 | int __init mshv_root_init(void)
         |            ^~~~~~~~~~~~~~
>> drivers/hv/mshv_root_main.c:1896:13: warning: no previous prototype for 'mshv_root_exit' [-Wmissing-prototypes]
    1896 | void __exit mshv_root_exit(void)
         |             ^~~~~~~~~~~~~~
--
>> drivers/hv/mshv_synic.c:27:1: warning: no previous prototype for 'synic_event_ring_get_queued_port' [-Wmissing-prototypes]
      27 | synic_event_ring_get_queued_port(u32 sint_index)
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
>> drivers/hv/mshv_root_hv_call.c:46:5: warning: no previous prototype for 'hv_call_withdraw_memory' [-Wmissing-prototypes]
      46 | int hv_call_withdraw_memory(u64 count, int node, u64 partition_id)
         |     ^~~~~~~~~~~~~~~~~~~~~~~
>> drivers/hv/mshv_root_hv_call.c:94:5: warning: no previous prototype for 'hv_call_create_partition' [-Wmissing-prototypes]
      94 | int hv_call_create_partition(u64 flags,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/hv/mshv_root_hv_call.c:139:5: warning: no previous prototype for 'hv_call_initialize_partition' [-Wmissing-prototypes]
     139 | int hv_call_initialize_partition(u64 partition_id)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/hv/mshv_root_hv_call.c:166:5: warning: no previous prototype for 'hv_call_finalize_partition' [-Wmissing-prototypes]
     166 | int hv_call_finalize_partition(u64 partition_id)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/hv/mshv_root_hv_call.c:177:5: warning: no previous prototype for 'hv_call_delete_partition' [-Wmissing-prototypes]
     177 | int hv_call_delete_partition(u64 partition_id)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/hv/mshv_root_hv_call.c:188:5: warning: no previous prototype for 'hv_call_map_gpa_pages' [-Wmissing-prototypes]
     188 | int hv_call_map_gpa_pages(u64 partition_id, u64 gpa_target, u64 page_count,
         |     ^~~~~~~~~~~~~~~~~~~~~
>> drivers/hv/mshv_root_hv_call.c:241:5: warning: no previous prototype for 'hv_call_unmap_gpa_pages' [-Wmissing-prototypes]
     241 | int hv_call_unmap_gpa_pages(u64 partition_id, u64 gpa_target, u64 page_count,
         |     ^~~~~~~~~~~~~~~~~~~~~~~
>> drivers/hv/mshv_root_hv_call.c:277:5: warning: no previous prototype for 'hv_call_get_gpa_access_states' [-Wmissing-prototypes]
     277 | int hv_call_get_gpa_access_states(u64 partition_id, u32 count,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/hv/mshv_root_hv_call.c:320:5: warning: no previous prototype for 'hv_call_install_intercept' [-Wmissing-prototypes]
     320 | int hv_call_install_intercept(u64 partition_id, u32 access_type,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/hv/mshv_root_hv_call.c:350:5: warning: no previous prototype for 'hv_call_assert_virtual_interrupt' [-Wmissing-prototypes]
     350 | int hv_call_assert_virtual_interrupt(u64 partition_id, u32 vector, u64 dest_addr,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/hv/mshv_root_hv_call.c:372:5: warning: no previous prototype for 'hv_call_get_vp_state' [-Wmissing-prototypes]
     372 | int hv_call_get_vp_state(u32 vp_index, u64 partition_id,
         |     ^~~~~~~~~~~~~~~~~~~~
>> drivers/hv/mshv_root_hv_call.c:429:5: warning: no previous prototype for 'hv_call_set_vp_state' [-Wmissing-prototypes]
     429 | int hv_call_set_vp_state(u32 vp_index, u64 partition_id,
         |     ^~~~~~~~~~~~~~~~~~~~
>> drivers/hv/mshv_root_hv_call.c:494:5: warning: no previous prototype for 'hv_call_map_vp_state_page' [-Wmissing-prototypes]
     494 | int hv_call_map_vp_state_page(u64 partition_id, u32 vp_index, u32 type,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/hv/mshv_root_hv_call.c:531:5: warning: no previous prototype for 'hv_call_unmap_vp_state_page' [-Wmissing-prototypes]
     531 | int hv_call_unmap_vp_state_page(u64 partition_id, u32 vp_index, u32 type)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/hv/mshv_root_hv_call.c:554:5: warning: no previous prototype for 'hv_call_get_partition_property' [-Wmissing-prototypes]
     554 | int hv_call_get_partition_property(u64 partition_id, u64 property_code,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/hv/mshv_root_hv_call.c:581:5: warning: no previous prototype for 'hv_call_set_partition_property' [-Wmissing-prototypes]
     581 | int hv_call_set_partition_property(u64 partition_id, u64 property_code,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/hv/mshv_root_hv_call.c:609:5: warning: no previous prototype for 'hv_call_translate_virtual_address' [-Wmissing-prototypes]
     609 | int hv_call_translate_virtual_address(u32 vp_index, u64 partition_id, u64 flags,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/hv/mshv_root_hv_call.c:648:1: warning: no previous prototype for 'hv_call_clear_virtual_interrupt' [-Wmissing-prototypes]
     648 | hv_call_clear_virtual_interrupt(u64 partition_id)
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/hv/mshv_root_hv_call.c:662:1: warning: no previous prototype for 'hv_call_create_port' [-Wmissing-prototypes]
     662 | hv_call_create_port(u64 port_partition_id, union hv_port_id port_id,
         | ^~~~~~~~~~~~~~~~~~~
>> drivers/hv/mshv_root_hv_call.c:703:1: warning: no previous prototype for 'hv_call_delete_port' [-Wmissing-prototypes]
     703 | hv_call_delete_port(u64 port_partition_id, union hv_port_id port_id)
         | ^~~~~~~~~~~~~~~~~~~
   drivers/hv/mshv_root_hv_call.c:721:1: warning: no previous prototype for 'hv_call_connect_port' [-Wmissing-prototypes]
     721 | hv_call_connect_port(u64 port_partition_id, union hv_port_id port_id,
         | ^~~~~~~~~~~~~~~~~~~~
   drivers/hv/mshv_root_hv_call.c:761:1: warning: no previous prototype for 'hv_call_disconnect_port' [-Wmissing-prototypes]
     761 | hv_call_disconnect_port(u64 connection_partition_id,
         | ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/hv/mshv_root_hv_call.c:781:1: warning: no previous prototype for 'hv_call_notify_port_ring_empty' [-Wmissing-prototypes]
     781 | hv_call_notify_port_ring_empty(u32 sint_index)
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/hv/mshv_root_hv_call.c:798:5: warning: no previous prototype for 'hv_call_register_intercept_result' [-Wmissing-prototypes]
     798 | int hv_call_register_intercept_result(u32 vp_index, u64 partition_id,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/hv/mshv_root_hv_call.c:834:5: warning: no previous prototype for 'hv_call_signal_event_direct' [-Wmissing-prototypes]
     834 | int hv_call_signal_event_direct(u32 vp_index, u64 partition_id, u8 vtl,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/hv/mshv_root_hv_call.c:861:5: warning: no previous prototype for 'hv_call_post_message_direct' [-Wmissing-prototypes]
     861 | int hv_call_post_message_direct(u32 vp_index, u64 partition_id, u8 vtl,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/hv/mshv_root_hv_call.c:883:5: warning: no previous prototype for 'hv_call_get_vp_cpuid_values' [-Wmissing-prototypes]
     883 | int hv_call_get_vp_cpuid_values(u32 vp_index, u64 partition_id,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~
--
>> drivers/hv/xfer_to_guest.c:15:5: warning: no previous prototype for 'mshv_xfer_to_guest_mode_handle_work' [-Wmissing-prototypes]
      15 | int mshv_xfer_to_guest_mode_handle_work(unsigned long ti_work)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/hv_call_get_vp_registers +21 drivers/hv/hv_call.c

    14	
    15	#define HV_GET_REGISTER_BATCH_SIZE	\
    16		(HV_HYP_PAGE_SIZE / sizeof(union hv_register_value))
    17	#define HV_SET_REGISTER_BATCH_SIZE	\
    18		((HV_HYP_PAGE_SIZE - sizeof(struct hv_input_set_vp_registers)) \
    19			/ sizeof(struct hv_register_assoc))
    20	
  > 21	int hv_call_get_vp_registers(u32 vp_index, u64 partition_id, u16 count,
    22				     union hv_input_vtl input_vtl,
    23				     struct hv_register_assoc *registers)
    24	{
    25		struct hv_input_get_vp_registers *input_page;
    26		union hv_register_value *output_page;
    27		u16 completed = 0;
    28		unsigned long remaining = count;
    29		int rep_count, i;
    30		u64 status = HV_STATUS_SUCCESS;
    31		unsigned long flags;
    32	
    33		local_irq_save(flags);
    34	
    35		input_page = *this_cpu_ptr(hyperv_pcpu_input_arg);
    36		output_page = *this_cpu_ptr(hyperv_pcpu_output_arg);
    37	
    38		input_page->partition_id = partition_id;
    39		input_page->vp_index = vp_index;
    40		input_page->input_vtl.as_uint8 = input_vtl.as_uint8;
    41		input_page->rsvd_z8 = 0;
    42		input_page->rsvd_z16 = 0;
    43	
    44		while (remaining) {
    45			rep_count = min(remaining, HV_GET_REGISTER_BATCH_SIZE);
    46			for (i = 0; i < rep_count; ++i)
    47				input_page->names[i] = registers[i].name;
    48	
    49			status = hv_do_rep_hypercall(HVCALL_GET_VP_REGISTERS, rep_count,
    50						     0, input_page, output_page);
    51			if (!hv_result_success(status))
    52				break;
    53			completed = hv_repcomp(status);
    54			for (i = 0; i < completed; ++i)
    55				registers[i].value = output_page[i];
    56	
    57			registers += completed;
    58			remaining -= completed;
    59		}
    60		local_irq_restore(flags);
    61	
    62		return hv_status_to_errno(status);
    63	}
    64	
  > 65	int hv_call_set_vp_registers(u32 vp_index, u64 partition_id, u16 count,
    66				     union hv_input_vtl input_vtl,
    67				     struct hv_register_assoc *registers)
    68	{
    69		struct hv_input_set_vp_registers *input_page;
    70		u16 completed = 0;
    71		unsigned long remaining = count;
    72		int rep_count;
    73		u64 status = HV_STATUS_SUCCESS;
    74		unsigned long flags;
    75	
    76		local_irq_save(flags);
    77		input_page = *this_cpu_ptr(hyperv_pcpu_input_arg);
    78	
    79		input_page->partition_id = partition_id;
    80		input_page->vp_index = vp_index;
    81		input_page->input_vtl.as_uint8 = input_vtl.as_uint8;
    82		input_page->rsvd_z8 = 0;
    83		input_page->rsvd_z16 = 0;
    84	
    85		while (remaining) {
    86			rep_count = min(remaining, HV_SET_REGISTER_BATCH_SIZE);
    87			memcpy(input_page->elements, registers,
    88			       sizeof(struct hv_register_assoc) * rep_count);
    89	
    90			status = hv_do_rep_hypercall(HVCALL_SET_VP_REGISTERS, rep_count,
    91						     0, input_page, NULL);
    92			if (!hv_result_success(status))
    93				break;
    94			completed = hv_repcomp(status);
    95			registers += completed;
    96			remaining -= completed;
    97		}
    98	
    99		local_irq_restore(flags);
   100	
   101		return hv_status_to_errno(status);
   102	}
   103	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
