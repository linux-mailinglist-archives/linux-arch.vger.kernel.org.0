Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 167226DDC74
	for <lists+linux-arch@lfdr.de>; Tue, 11 Apr 2023 15:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbjDKNnn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 11 Apr 2023 09:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbjDKNnm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 11 Apr 2023 09:43:42 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB2661707;
        Tue, 11 Apr 2023 06:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681220621; x=1712756621;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2GeQQq+KcbTCEU+rXh5JGw+yLkL8a8JmHupdRnaoc8M=;
  b=chh0jmd4I6VNBC14A5780CVuHTxHv34bO0UjY1fWhG0r+A/g9vuNnnrk
   E+fR5m5J7LjjjauKWjtM5cDvn/VshNJS7PkdCiRCVmTIhUshEwoVGEG8b
   wy1Pi7MzUi65BzAmzI0VR+9oQ7q8s3WT3M0V1L5tNCwwunJzcv97RHTzx
   8Qq1eRnZKzEXBwkocoGx0q2IWHtWIVYVgI46XPRMqoq1DfPfa0JUw94/i
   wfzMjpmAHVtA+0eunF8M3nQVkiQyBB+wHFH9lRuec31hAZeGU7Aky1Osl
   AO673s42/mPq2YqPWCRbRKBnog/LYpIYyM7jKV5gjF4yHdc6en+zZzG0n
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="429905385"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="429905385"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 06:43:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="812566489"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="812566489"
Received: from gtryonx-mobl.amr.corp.intel.com (HELO [10.209.72.81]) ([10.209.72.81])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 06:43:39 -0700
Message-ID: <1fee0372-3a3b-5e09-38c3-ffb3523fe195@intel.com>
Date:   Tue, 11 Apr 2023 06:43:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 0/5] locking: Introduce local{,64}_try_cmpxchg
Content-Language: en-US
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Uros Bizjak <ubizjak@gmail.com>, linux-alpha@vger.kernel.org,
        loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-arch@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Jun Yi <yijun@loongson.cn>
References: <20230405141710.3551-1-ubizjak@gmail.com>
 <7360ffd2-a5aa-1373-8309-93e71ff36cbb@intel.com>
 <ZDVGFhMwOtpxJtnQ@FVFF77S0Q05N>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <ZDVGFhMwOtpxJtnQ@FVFF77S0Q05N>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 4/11/23 04:35, Mark Rutland wrote:
> I agree it'd be nice to have performance figures, but I think those would only
> need to demonstrate a lack of a regression rather than a performance
> improvement, and I think it's fairly clear from eyeballing the generated
> instructions that a regression isn't likely.

Thanks for the additional context.

I totally agree that there's zero burden here to show a performance
increase.  If anyone can think of a quick way to do _some_ kind of
benchmark on the code being changed and just show that it's free of
brown paper bags, it would be appreciated.  Nothing crazy, just think of
one workload (synthetic or not) that will stress the paths being changed
and run it with and without these changes.  Make sure there are not
surprises.

I also agree that it's unlikely to be brown paper bag material.
