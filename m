Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 816686C70D6
	for <lists+linux-arch@lfdr.de>; Thu, 23 Mar 2023 20:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjCWTPL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Mar 2023 15:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjCWTPK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Mar 2023 15:15:10 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1799749F7;
        Thu, 23 Mar 2023 12:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679598910; x=1711134910;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8v1MfgmasFE+BalMNtLnvgpx+sV9Z9LnMJ4Kr4Tdph8=;
  b=OWokWtXPHWiLMs2z/G/jViz9dGD2gg9FLdhAjSXgIvQmbP4z2Q6BuP3V
   6IEFtmlEL81aG2NxxE5FZyWkQ6QJE6RLJ5nd8deVuoqCAAo3zIRGSzNTc
   J18zONBVzI65/SaG7YMBkZ3XKSUWklUDTk0OfSw7kqU0X8lVKjDsw5v7+
   /S5bNg3vMWM7SsUyIsmyVecBUDmHtQ8LNuNsGuwFVUFuRebs+rVoXdJSC
   c+Oq4WC6kN4F4vkx4jukZfkppkFyMPy8cpwDl3pHluv8ff3MAPfN9QI45
   eftOupnwwb0jmK+znxaKywupMu9LDDlzNaDWxq/FdzrPO9IMrmQy2ycCR
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="425872202"
X-IronPort-AV: E=Sophos;i="5.98,285,1673942400"; 
   d="scan'208";a="425872202"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2023 12:15:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="751612054"
X-IronPort-AV: E=Sophos;i="5.98,285,1673942400"; 
   d="scan'208";a="751612054"
Received: from jball6-mobl.amr.corp.intel.com (HELO [10.209.105.116]) ([10.209.105.116])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2023 12:15:08 -0700
Message-ID: <5064fa75-20a8-7297-8c0d-18199d02e273@intel.com>
Date:   Thu, 23 Mar 2023 12:15:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 2/2] docs: move x86 documentation into Documentation/arch/
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>
References: <20230315211523.108836-1-corbet@lwn.net>
 <20230315211523.108836-3-corbet@lwn.net>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230315211523.108836-3-corbet@lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 3/15/23 14:15, Jonathan Corbet wrote:
> Move the x86 documentation under Documentation/arch/ as a way of cleaning
> up the top-level directory and making the structure of our docs more
> closely match the structure of the source directories it describes.
> 
> All in-kernel references to the old paths have been updated.
> 
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>

Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
