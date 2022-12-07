Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29860645380
	for <lists+linux-arch@lfdr.de>; Wed,  7 Dec 2022 06:41:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbiLGFk6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Dec 2022 00:40:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiLGFk4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 7 Dec 2022 00:40:56 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7BD758020
        for <linux-arch@vger.kernel.org>; Tue,  6 Dec 2022 21:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670391655; x=1701927655;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=nuvP5ru5qaNNoGwijTA2xk12sPYZDzHB4wO5RLsEeKw=;
  b=DU566Cvjr3uazO2W1not2q7Am296WXXKqwgGFoKj/pSD/HOu/STkausI
   2AEaJTsemUw4vtRcNdDKSMsYNVhJ6dlezMqKoN3l2GAvfBbVsVyvuHqn0
   z7vO0WVYzPOd+dfIPZi9QkrsuxINOjKaw4PQdwIjLeQUK0qjbjuObqx0t
   gAtt/fjZl3snxBALeY2weeQg2qit5DrH08kFuXDSs03alcBe36x6Dq48m
   kytAuvilWUAgHzrjWTZF5/NNxi662aoclunOl5fLGnaX4+twnPpBM1Jit
   2QDzWu56h1fmQaX2GvjT2yznwJiFu7kqPI4j8CyhR02xideyuQqIrM6OX
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="297161645"
X-IronPort-AV: E=Sophos;i="5.96,223,1665471600"; 
   d="scan'208";a="297161645"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2022 21:40:55 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="677241005"
X-IronPort-AV: E=Sophos;i="5.96,223,1665471600"; 
   d="scan'208";a="677241005"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2022 21:40:51 -0800
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
In-Reply-To: <CAHk-=whjis-wTZKH20xoBW3=1qyygYoxJORxXx8ZpJbc6KtROw@mail.gmail.com>
        (Linus Torvalds's message of "Tue, 6 Dec 2022 11:15:09 -0800")
References: <202212051534.852804af-yujie.liu@intel.com>
        <CAHk-=wg330wAAxwSaJBPUtL5Rrn7PoQK3ksJw2OLvBxA0NGg+g@mail.gmail.com>
        <87ilipffws.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <CAHk-=wjDzVL+r6NmnU--tyEfDYhUB-5m=PQBZTQ2Es8bx7Mz+w@mail.gmail.com>
        <CAHk-=whjis-wTZKH20xoBW3=1qyygYoxJORxXx8ZpJbc6KtROw@mail.gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Date:   Wed, 07 Dec 2022 13:39:48 +0800
Message-ID: <878rjj22mz.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Tue, Dec 6, 2022 at 10:41 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> Let me think about this a while, but I think I'll have a patch for you
>> to test once I've dealt with a couple more pull requests.
>
> So here's a trial balloon for you to try if you can see if this mostly
> fixes the regression..
>
> It still limits batching (because unlike the full "gather pages until
> you have to flush", this is all batched under the page table lock. But
> it limits it a bit less, in that it will use a second active batch if
> it only used the initial on-stack one (which is called "local", which
> is not a great name in this context, but whatever).
>
> This _should_ mean that that benchmark will now batch ~512 pages
> instead of just 8.
>
> Which should be pretty much what it effectively used to do before too,
> because the dirty shared page case has always caused that
> "force_flush" thing, so it will have always stopped to flush every
> page directory.
>
> (But we still have that extra rmap flushing limit because there could
> have been _previous_ buffered page pointers that weren't dirty shared
> pages, and we don't want to have to deal with that pain, and might
> have to exit early in order to avoid it)
>
> I can imagine cleaner ways to do this, but they would involve having
> to remember which batch we started having dirty pages in, which is
> more bookkeeping pain than I really think it's worth.
>
> Does this fix the regression?

I have tested the patch, it does fix the regression, the test result is
as follows,

5df397dec7c4c08c 7cc8f9c7146a5c2dad6e71653c4 7763ba2bb16804313aa52bc78ae=20
---------------- --------------------------- ---------------------------=20
         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \=20=20
   2256919 =C2=B1  5%    +114.2%    4833919 =C2=B1  2%    +116.6%    488919=
9        will-it-scale.16.threads
      8.17 =C2=B1  6%      -8.2        0.00            -8.2        0.00    =
    perf-profile.calltrace.cycles-pp.native_flush_tlb_one_user.flush_tlb_fu=
nc.__flush_smp_call_function_queue.__sysvec_call_function.sysvec_call_funct=
ion

Where 5df397dec7c4c08c is first bad commit, 7cc8f9c7146a5c2dad6e71653c4
is its parent commit, and 7763ba2bb16804313aa52bc78ae is the fix
commit.  The benchmark score recovered and CPU cycles for tlb flushing
recovered too.

Best Regards,
Huang, Ying
