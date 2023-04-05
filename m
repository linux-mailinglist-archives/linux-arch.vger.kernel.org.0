Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9D56D83D0
	for <lists+linux-arch@lfdr.de>; Wed,  5 Apr 2023 18:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232690AbjDEQhZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Apr 2023 12:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232558AbjDEQhX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Apr 2023 12:37:23 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8CCC4C1F;
        Wed,  5 Apr 2023 09:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680712643; x=1712248643;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0xErBa/ZTd4QuIygEuCmz4Ddp7YfQ0AoZ3dVIG2ez3Y=;
  b=dqLPk3bQ9PiFQn0zDY+AcZjtRALJZLymqJ4MJ4H9QMKAMOhpd8WOcXId
   k8Hf8+rgp+Z9K7SytT0q1mK5gw1d8TiO59HJfrKBwaf3Ffu/xBXejZc5M
   1CMxxfS8HdphHR60dFj3ZWKdWUEOaBFZ8wF/LRaiaTsD5QU7PzZzVwNxv
   ZqCUYGItOeP3xk/3Ed6MvLguxuRN9XP+gDmYljboI1X1P5bjtsN5QuS9g
   mz1Vde2rXtnqNox+BC5E/d4/hW4YoMlhq311JQWEDB6ZvqP3Cb+hd0T2x
   xI4aUSmEvHngGnTNoQVFY+0+jF/VkgQCEE4xCX3DM1kEDdkimHQX98SoS
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="339995929"
X-IronPort-AV: E=Sophos;i="5.98,321,1673942400"; 
   d="scan'208";a="339995929"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2023 09:37:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="932891908"
X-IronPort-AV: E=Sophos;i="5.98,321,1673942400"; 
   d="scan'208";a="932891908"
Received: from kyunghyu-mobl2.amr.corp.intel.com (HELO [10.209.6.69]) ([10.209.6.69])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2023 09:37:05 -0700
Message-ID: <7360ffd2-a5aa-1373-8309-93e71ff36cbb@intel.com>
Date:   Wed, 5 Apr 2023 09:37:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 0/5] locking: Introduce local{,64}_try_cmpxchg
Content-Language: en-US
To:     Uros Bizjak <ubizjak@gmail.com>, linux-alpha@vger.kernel.org,
        loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-arch@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Richard Henderson <richard.henderson@linaro.org>,
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
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Jun Yi <yijun@loongson.cn>
References: <20230405141710.3551-1-ubizjak@gmail.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230405141710.3551-1-ubizjak@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 4/5/23 07:17, Uros Bizjak wrote:
> Add generic and target specific support for local{,64}_try_cmpxchg
> and wire up support for all targets that use local_t infrastructure.

I feel like I'm missing some context.

What are the actual end user visible effects of this series?  Is there a
measurable decrease in perf overhead?  Why go to all this trouble for
perf?  Who else will use local_try_cmpxchg()?

I'm all for improving things, and perf is an important user.  But, if
the goal here is improving performance, it would be nice to see at least
a stab at quantifying the performance delta.
