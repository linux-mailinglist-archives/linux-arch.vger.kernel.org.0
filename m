Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B62FA6C70FD
	for <lists+linux-arch@lfdr.de>; Thu, 23 Mar 2023 20:21:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbjCWTVy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Mar 2023 15:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231504AbjCWTVp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Mar 2023 15:21:45 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B119D7EE2;
        Thu, 23 Mar 2023 12:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679599282; x=1711135282;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KGT3JSAKTA9TPA4CDSY4pFYa5k/9A9sHqosjNf7yt/o=;
  b=TzhFzvWg/QO+ofg7mF3sOixVgYaZcoVrEdiM/UV2EOar/ckKfdB9SPb/
   jPhPTT8QI2vAMu3otZakjHKximJl2CD92MP38QqcoWmodgX21UkYMOR3s
   WBMmZem50F3uWerFpXd3blKCxi1rQ46B2yVdV+D56xTESVsOx5Ay1j8ie
   nqGDommLg3r/SBwl1xA1inC2gr09CaymwbAetRCSMDy5w0nhs/HfAcsTH
   XpBHMgiUxDjlgZLtimYM1wKzysJb21t3/86ipWhvKOW4sa87KUSMD61LJ
   EH4dB3HhkEnBoUKKGPH83dUejvROnwt48y2O+/MKaHAbLEUYcXjqVtDc8
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="341980373"
X-IronPort-AV: E=Sophos;i="5.98,285,1673942400"; 
   d="scan'208";a="341980373"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2023 12:20:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="793139379"
X-IronPort-AV: E=Sophos;i="5.98,285,1673942400"; 
   d="scan'208";a="793139379"
Received: from jball6-mobl.amr.corp.intel.com (HELO [10.209.105.116]) ([10.209.105.116])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2023 12:20:23 -0700
Message-ID: <498938d3-60a4-6219-a02c-a03e490103c3@intel.com>
Date:   Thu, 23 Mar 2023 12:20:22 -0700
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
 <fe5d1e0e-0725-45eb-8b96-edcd12ae4a8b@intel.com>
 <87cz4zb8xu.fsf@meer.lwn.net>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <87cz4zb8xu.fsf@meer.lwn.net>
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

On 3/23/23 11:48, Jonathan Corbet wrote:
> I could do the "fix up and send at the end of the merge window" trick
> with it.

That would work for me.

>  Or perhaps some of this should go via tip?  Suggestions welcome.

Since we have so many branches, we'll still have to do the merges
between whatever branch carries the move and the actual doc-update branches.

The end-of-the-merge-window is nice for us maintainers because we can
ask the submitters to do any rebasing.
