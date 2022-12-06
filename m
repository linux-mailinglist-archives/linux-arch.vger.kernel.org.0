Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B554D643B24
	for <lists+linux-arch@lfdr.de>; Tue,  6 Dec 2022 03:03:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbiLFCDg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 5 Dec 2022 21:03:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbiLFCDf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 5 Dec 2022 21:03:35 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C709710FDD
        for <linux-arch@vger.kernel.org>; Mon,  5 Dec 2022 18:03:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670292214; x=1701828214;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version:content-transfer-encoding;
  bh=8c7UdCeE5P2gBTMsb1MwQl5B3qvTaC1WOOt1HdlBGyY=;
  b=D32ivsinvSGuTezrINsfk+hVMMfCGYtCIVUA3dRbXwoqxnesEh0P1k0/
   KRN0y04D5p9C8M7kwiBdVMMY/syw7rhwpkKE/5Qz5KE/TyBYkVTLbG2m7
   MlVLmyMsfvujlzaseb46eJ+2SxoHi7XIYFa2o39gfkevZdqnF7U0GTvr5
   gVopJ8NUQkwb5wUIGu3VvuHyiyC880enpEsu1ZmtuZgTssHuRpSwuwUyO
   B/BPXPc9+TwI1Iq1X+vprKdfUiBXxrVedIi1KyOhM1rQ8R6U6KrF5+S1/
   riE1qYQWck+TGIIdibODce8LyKYkaVYhc9xiDbXHd8lZ+ojyzpMiZk6Ql
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="299939463"
X-IronPort-AV: E=Sophos;i="5.96,220,1665471600"; 
   d="scan'208";a="299939463"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 18:03:34 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="709474338"
X-IronPort-AV: E=Sophos;i="5.96,220,1665471600"; 
   d="scan'208";a="709474338"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 18:03:31 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     kernel test robot <yujie.liu@intel.com>, oe-lkp@lists.linux.dev,
        lkp@intel.com, Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hugh Dickins <hughd@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-arch@vger.kernel.org, feng.tang@intel.com,
        zhengjun.xing@linux.intel.com, fengwei.yin@intel.com
Subject: Re: [linux-next:master] [mm] 5df397dec7:
 will-it-scale.per_thread_ops -53.3% regression
References: <202212051534.852804af-yujie.liu@intel.com>
        <CAHk-=wg330wAAxwSaJBPUtL5Rrn7PoQK3ksJw2OLvBxA0NGg+g@mail.gmail.com>
Date:   Tue, 06 Dec 2022 10:02:27 +0800
In-Reply-To: <CAHk-=wg330wAAxwSaJBPUtL5Rrn7PoQK3ksJw2OLvBxA0NGg+g@mail.gmail.com>
        (Linus Torvalds's message of "Mon, 5 Dec 2022 12:43:37 -0800")
Message-ID: <87ilipffws.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Mon, Dec 5, 2022 at 1:02 AM kernel test robot <yujie.liu@intel.com> wr=
ote:
>>
>> FYI, we noticed a -53.3% regression of will-it-scale.per_thread_ops due =
to commit:
>> 5df397dec7c4 ("mm: delay page_remove_rmap() until after the TLB has been=
 flushed")
>
> Sadly, I think this may be at least partially expected.
>
> The code fundamentally moves one "loop over pages" and splits it up
> (with the TLB flush in between).
>
> Which can't be great for locality, but it's kind of fundamental for
> the fix - but some of it might be due to the batch limit logic.
>
> I wouldn't have expected it to actually show up in any real loads, but:
>
>> in testcase: will-it-scale
>>         test: page_fault3
>
> I assume that this test is doing a lot of mmap/munmap on dirty shared
> memory regions (both because of the regression, and because of the
> name of that test ;)

I have checked the source code of will-it-scale/page_fault3.  Yes, it
exactly does that.

> So this is hopefully an extreme case.
>
> Now, it's likely that this particular case probably also triggers that
>
>         /* No more batching if we have delayed rmaps pending */
>
> which means that the loops in between the TLB flushes will be smaller,
> since we don't batch up as many pages as we used to before we force a
> TLB (and rmap) flush and free them.
>
> If it's due to that batching issue it may be fixable - I'll think
> about this some more, but
>
>> Details are as below:
>
> The bug it fixes ends up meaning that we run that rmap removal code
> _after_ the TLB flush, and it looks like this (probably combined with
> the batching limit) then causes some nasty iTLB load issues:
>
>>    2291312 =C4=85  2%   +1452.8%   35580378 =C4=85  4%  perf-stat.i.iTLB=
-loads
>
> although it also does look like it's at least partly due to some irq
> timing issue (and/or bad NUMA/CPU migration luck):
>
>>    388169          +267.4%    1426305 =C4=85  6%  vmstat.system.in
>>     161.37           +84.9%     298.43 =C4=85  6%  perf-stat.ps.cpu-migr=
ations
>>    172442 =C4=85  4%     +26.9%     218745 =C4=85  8%  perf-stat.ps.node=
-load-misses
>
> so it might be that some of the regression comes down to "bad luck" -
> it happened to run really nicely on that particular machine, and then
> the timing changes caused some random "phase change" to the load.
>
> The profile doesn't actually seem to show all that much more IPI
> overhead, so maybe these incidental issues are what then causes that
> big regression.

      0.00            +8.5        8.49   5%  perf-profile.calltrace.cycles-=
pp.flush_tlb_func.__flush_smp_call_function_queue.__sysvec_call_function.sy=
svec_call_function.asm_sysvec_call_function

From perf profiling, the cycles for TLB flushing increases much.  So I
guess it may be related?

> It would be lovely to hear if you see this on other machines and/or loads.

Will ask 0-Day guys to check this.

Best Regards,
Huang, Ying

> Because if it's a one-off, it's probably best ignored. If it shows up
> elsewhere, I think that batching logic might need looking at.
>
>                Linus
