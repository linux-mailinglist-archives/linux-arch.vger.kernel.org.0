Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6DA66DD97C
	for <lists+linux-arch@lfdr.de>; Tue, 11 Apr 2023 13:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbjDKLgA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 11 Apr 2023 07:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjDKLf7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 11 Apr 2023 07:35:59 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 887CDE60;
        Tue, 11 Apr 2023 04:35:58 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 96259D75;
        Tue, 11 Apr 2023 04:36:42 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.20.166])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4DAD93F6C4;
        Tue, 11 Apr 2023 04:35:53 -0700 (PDT)
Date:   Tue, 11 Apr 2023 12:35:50 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Dave Hansen <dave.hansen@intel.com>
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
Subject: Re: [PATCH v2 0/5] locking: Introduce local{,64}_try_cmpxchg
Message-ID: <ZDVGFhMwOtpxJtnQ@FVFF77S0Q05N>
References: <20230405141710.3551-1-ubizjak@gmail.com>
 <7360ffd2-a5aa-1373-8309-93e71ff36cbb@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7360ffd2-a5aa-1373-8309-93e71ff36cbb@intel.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Apr 05, 2023 at 09:37:04AM -0700, Dave Hansen wrote:
> On 4/5/23 07:17, Uros Bizjak wrote:
> > Add generic and target specific support for local{,64}_try_cmpxchg
> > and wire up support for all targets that use local_t infrastructure.
> 
> I feel like I'm missing some context.
> 
> What are the actual end user visible effects of this series?  Is there a
> measurable decrease in perf overhead?  Why go to all this trouble for
> perf?  Who else will use local_try_cmpxchg()?

Overall, the theory is that it can generate slightly better code (e.g. by
reusing the flags on x86). In practice, that might be in the noise, but as
demonstrated in prior postings the code generation is no worse than before.

From my perspective, the more important part is that this aligns local_t with
the other atomic*_t APIs, which all have ${atomictype}_try_cmpxchg(), and for
consistency/legibility/maintainability it's nice to be able to use the same
code patterns, e.g.

	${inttype} new, old = ${atomictype}_read(ptr);
	do {
		...
		new = do_something_with(old);
	} while (${atomictype}_try_cmpxvhg(ptr, &oldval, newval);

> I'm all for improving things, and perf is an important user.  But, if
> the goal here is improving performance, it would be nice to see at least
> a stab at quantifying the performance delta.

IIUC, Steve's original request for local_try_cmpxchg() was a combination of a
theoretical performance benefit and a more general preference to use
try_cmpxchg() for consistency / better structure of the source code:

  https://lore.kernel.org/lkml/20230301131831.6c8d4ff5@gandalf.local.home/

I agree it'd be nice to have performance figures, but I think those would only
need to demonstrate a lack of a regression rather than a performance
improvement, and I think it's fairly clear from eyeballing the generated
instructions that a regression isn't likely.

Thanks,
Mark.
