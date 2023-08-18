Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 380F57802B9
	for <lists+linux-arch@lfdr.de>; Fri, 18 Aug 2023 02:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352399AbjHRA04 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Aug 2023 20:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356429AbjHRA0l (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Aug 2023 20:26:41 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0365FE;
        Thu, 17 Aug 2023 17:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692318400; x=1723854400;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ctCzlIT+5k3T1YALRzvioprufv0wKEBR63rBIHtioCM=;
  b=BeI8am6kq9Og1ZQMQciAFJTcAp6s++mqERlWUFnmvYdhx8QwZpzJHpsu
   lHjHFqOkt9KmyJ3zYEivnESymc3qSd4kqwEAPa0f2aTdtA1e5KLzII1lb
   0WhTVcxBNmSl/Zr3XfbU2JhPP0eCj5BWmjzx7b/yJVQjWDieQ4IShBI5p
   7UflkcR+b5vdwZdxWx7GXNsFxLxJL1trCNs0gq2pVntaaw0ldWpQrDXus
   NSzb5flOqCiEvcyVOWBhCLnMJCe0l+ml2NlkEvI5RGmoMBZ4K9H3B4MVn
   L6f4koflsVPBEFrM4EhEiWhjd9Gwi8N8YGkczTuAWJsalaukit/nX9flh
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="403951555"
X-IronPort-AV: E=Sophos;i="6.01,181,1684825200"; 
   d="scan'208";a="403951555"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 17:26:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="1065518469"
X-IronPort-AV: E=Sophos;i="6.01,181,1684825200"; 
   d="scan'208";a="1065518469"
Received: from lacoffin-mobl.amr.corp.intel.com (HELO [10.212.196.192]) ([10.212.196.192])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 17:26:20 -0700
Message-ID: <51095880-da66-5041-e47c-6572f199f6db@intel.com>
Date:   Thu, 17 Aug 2023 17:26:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 03/15] mshyperv: Introduce
 numa_node_to_proximity_domain_info
Content-Language: en-US
To:     Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org
Cc:     patches@lists.linux.dev, mikelley@microsoft.com, kys@microsoft.com,
        wei.liu@kernel.org, haiyangz@microsoft.com, decui@microsoft.com,
        apais@linux.microsoft.com, Tianyu.Lan@microsoft.com,
        ssengar@linux.microsoft.com, mukeshrathor@microsoft.com,
        stanislav.kinsburskiy@gmail.com, jinankjain@linux.microsoft.com,
        vkuznets@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        will@kernel.org, catalin.marinas@arm.com
References: <1692309711-5573-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1692309711-5573-4-git-send-email-nunodasneves@linux.microsoft.com>
 <3b1ca61c-fa3f-a802-6705-a8c1f37ad58f@intel.com>
 <8161aa90-5535-4ef9-ad30-1655746a1053@linux.microsoft.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <8161aa90-5535-4ef9-ad30-1655746a1053@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 8/17/23 17:17, Nuno Das Neves wrote:
>>> +	if (node != NUMA_NO_NODE) {
>>> +		proximity_domain_info.domain_id = node_to_pxm(node);
>>> +		proximity_domain_info.flags.reserved = 0;
>>> +		proximity_domain_info.flags.proximity_info_valid = 1;
>>> +		proximity_domain_info.flags.proximity_preferred = 1;
>>> +	} else {
>>> +		proximity_domain_info.as_uint64 = 0;
>>> +	}
>>> +
>>> +	return proximity_domain_info;
>>> +}
>> Pop quiz: What are the rules for the 30 bits of uninitialized data of
>> proximity_domain_info.flags in the (node != NUMA_NO_NODE) case?
>>
>> I actually don't know off the top of my head.  I generally avoid
>> bitfields, but if they were normal stack-allocated variable space,
>> they'd be garbage.
> I'm not sure what you are getting at here - all the fields are
> initialized.

Whoops, I somehow missed the reserved field initialization.  But, yeah,
a struct would be nice instead of the union here.

