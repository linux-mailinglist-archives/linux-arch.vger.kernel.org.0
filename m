Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE5356BBFB0
	for <lists+linux-arch@lfdr.de>; Wed, 15 Mar 2023 23:18:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbjCOWS6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Mar 2023 18:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbjCOWSy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Mar 2023 18:18:54 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D7E2BEC4;
        Wed, 15 Mar 2023 15:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678918713; x=1710454713;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fU4QSBmq06kLp0HuxVosNJEKUx3vKXjpqUJcfSNehIg=;
  b=R8eYLpwl6zOBXVjVGOh4kuc1mwc666w4yFo70wICN3yAsyT7Z8O3xNmp
   ek5Yv5NAtbSOyscaqkrIY4ntZWeH1TZJGhOJZZMs0YaCzope36rXVDeJu
   MOh1hznOPa5G7Ghm7wqP5UsoNhn9FKv1IRa9vWOQZEVx+1bpeyk+bilbQ
   +/Gx6653uQJLwIkBcHUQF78YTj9oDFjQQqTPPPjJaJ9QAQBuiFemlvqTm
   vgPQVCWgPC1YcdkIFkm9ld6z7Lv1H8FCp+fTc9XOPtExCFDnzgRIbm4Or
   j8rB0GJ6ZVOJtY0BmvtSiAWzwBojwTlt/oKnfddN+nJdYz3FWIYJc3wHj
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="318226006"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="318226006"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 15:18:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="709832226"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="709832226"
Received: from arnabch1-mobl.amr.corp.intel.com (HELO [10.209.44.101]) ([10.209.44.101])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 15:18:28 -0700
Message-ID: <fe5d1e0e-0725-45eb-8b96-edcd12ae4a8b@intel.com>
Date:   Wed, 15 Mar 2023 15:18:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH RFC 0/2] Begin reorganizing the arch documentation
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>
References: <20230315211523.108836-1-corbet@lwn.net>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230315211523.108836-1-corbet@lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 3/15/23 14:15, Jonathan Corbet wrote:
> On the other hand, it *is* a fair amount of churn.  If it's more than
> people can handle, I'll quietly back away and we'll muddle along as we have
> been; this isn't something I'm going to dig in my heels over.

I'm not fundamentally opposed to this.  It'll probably cost me a few
keystrokes in moments of confusion, but that's the price of progress. :)

Things in Documentation/ have also been mobile enough in recent years
that I tend to "find Documentation | grep something" rather than try to
remember the paths for things.  Adding an arch/ in there won't hurt
anything.

> Also, it is worth noting that, while the rendered HTML looks the same,
> links that went to Documentation/x86 (on https://kernel.org, say) will be
> broken by this change.  We have never considered whether we care about
> preserving external links to the rendered docs on kernel.org or not; I
> don't think we should break them without thinking about it.

I don't think this is a big deal.  Folks that are doing explicit versions:

	https://www.kernel.org/doc/html/v6.0/x86/

won't break and folks that are using "latest":

	https://www.kernel.org/doc/html/latest/x86/

are kinda already playing with fire.  I guess we could ask the
kernel.org admins to see how many 404's folks get after the docs get
moved.  They could _theoretically_ redirect users from the old to new URL:

	doc/html/latest/x86 => doc/html/latest/arch/x86

but I doubt it's worth it for this one little directory.
