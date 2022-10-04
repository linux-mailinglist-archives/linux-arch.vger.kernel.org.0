Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 828625F46E8
	for <lists+linux-arch@lfdr.de>; Tue,  4 Oct 2022 17:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbiJDPra (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Oct 2022 11:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbiJDPr3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Oct 2022 11:47:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC5F5F7D3;
        Tue,  4 Oct 2022 08:47:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 05BD1614C2;
        Tue,  4 Oct 2022 15:47:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AB8AC433D6;
        Tue,  4 Oct 2022 15:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664898446;
        bh=CPcAiHKHpUkWh0PA+NRCcRCL9rFyUZMmHsEQuOiHE3o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ooJkMsJBnKsRzCfdUKKCH3gK1tBl1/nF7T2XOhJKnC4ezZGZmGoS3sTNk77qyCkzz
         k4JvcUGlBOJOc3X1dhRQI0C0KJuXvkYfllhSSfz3nrFmw3PchRM7W1H4hhhOFJce7I
         ymHHeI9A637+AhHolx5ULHoKid+MvM9mM2XqzO6yPXFRenTjOgd2yaIjV0fbqwDenY
         nBWshZEpTGixEcSd+kHKs/pKXyLi77MWBkd/vuGCU8BlEaI4OtYUtyjI7m7OGQZ2WH
         bjf14qcjOmH6Qa0oUnFOnwEuAnRQt0HM76OTwmO49kCtO3gyXLDbIQnnMS5jAoHC4d
         Y1mjvrr9mXNnA==
Date:   Tue, 4 Oct 2022 08:47:22 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        joao.moreira@intel.com, John Allen <john.allen@amd.com>,
        kcc@google.com, eranian@google.com, rppt@kernel.org,
        jamorris@linux.microsoft.com, dethoma@microsoft.com,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Moger, Babu" <babu.moger@amd.com>
Subject: Re: [PATCH v2 33/39] x86/cpufeatures: Limit shadow stack to Intel
 CPUs
Message-ID: <YzxViiyfMRKrmoMY@dev-arch.thelio-3990X>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <20220929222936.14584-34-rick.p.edgecombe@intel.com>
 <202210031656.23FAA3195@keescook>
 <559f937f-cab4-d408-6d95-fc85b4809aa9@intel.com>
 <202210032147.ED1310CEA8@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202210032147.ED1310CEA8@keescook>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Kees,

On Mon, Oct 03, 2022 at 09:54:26PM -0700, Kees Cook wrote:
> On Mon, Oct 03, 2022 at 05:09:04PM -0700, Dave Hansen wrote:
> > On 10/3/22 16:57, Kees Cook wrote:
> > > On Thu, Sep 29, 2022 at 03:29:30PM -0700, Rick Edgecombe wrote:
> > >> Shadow stack is supported on newer AMD processors, but the kernel
> > >> implementation has not been tested on them. Prevent basic issues from
> > >> showing up for normal users by disabling shadow stack on all CPUs except
> > >> Intel until it has been tested. At which point the limitation should be
> > >> removed.
> > >>
> > >> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> > > So running the selftests on an AMD system is sufficient to drop this
> > > patch?
> > 
> > Yes, that's enough.
> > 
> > I _thought_ the AMD folks provided some tested-by's at some point in the
> > past.  But, maybe I'm confusing this for one of the other shared
> > features.  Either way, I'm sure no tested-by's were dropped on purpose.
> > 
> > I'm sure Rick is eager to trim down his series and this would be a great
> > patch to drop.  Does anyone want to make that easy for Rick?
> > 
> > <hint> <hint>
> 
> Hey Gustavo, Nathan, or Nick! I know y'all have some fancy AMD testing
> rigs. Got a moment to spin up this series and run the selftests? :)

I do have access to a system with an EPYC 7513, which does have Shadow
Stack support (I can see 'shstk' in the "Flags" section of lscpu with
this series). As far as I understand it, AMD only added Shadow Stack
with Zen 3; my regular AMD test system is Zen 2 (probably should look at
procurring a Zen 3 or Zen 4 one at some point).

I applied this series on top of 6.0 and reverted this change then booted
it on that system. After building the selftest (which did require
'make headers_install' and a small addition to make it build beyond
that, see below), I ran it and this was the result. I am not sure if
that is expected or not but the other results seem promising for
dropping this patch.

  $ ./test_shadow_stack_64
  [INFO]  new_ssp = 7f8a36c9fff8, *new_ssp = 7f8a36ca0001
  [INFO]  changing ssp from 7f8a374a0ff0 to 7f8a36c9fff8
  [INFO]  ssp is now 7f8a36ca0000
  [OK]    Shadow stack pivot
  [OK]    Shadow stack faults
  [INFO]  Corrupting shadow stack
  [INFO]  Generated shadow stack violation successfully
  [OK]    Shadow stack violation test
  [INFO]  Gup read -> shstk access success
  [INFO]  Gup write -> shstk access success
  [INFO]  Violation from normal write
  [INFO]  Gup read -> write access success
  [INFO]  Violation from normal write
  [INFO]  Gup write -> write access success
  [INFO]  Cow gup write -> write access success
  [OK]    Shadow gup test
  [INFO]  Violation from shstk access
  [OK]    mprotect() test
  [OK]    Userfaultfd test
  [FAIL]  Alt shadow stack test

  $ echo $?
  1

I am happy to provide any information that would be useful for exploring
this failure and test further iterations of this series as necessary.

Cheers,
Nathan

test_shadow_stack.c: In function ‘create_shstk’:
test_shadow_stack.c:86:70: error: ‘SHADOW_STACK_SET_TOKEN’ undeclared (first use in this function)
   86 |         return (void *)syscall(__NR_map_shadow_stack, addr, SS_SIZE, SHADOW_STACK_SET_TOKEN);
      |                                                                      ^~~~~~~~~~~~~~~~~~~~~~
test_shadow_stack.c:86:70: note: each undeclared identifier is reported only once for each function it appears in
test_shadow_stack.c:87:1: warning: control reaches end of non-void function [-Wreturn-type]
   87 | }
      | ^

diff --git a/tools/testing/selftests/x86/test_shadow_stack.c b/tools/testing/selftests/x86/test_shadow_stack.c
index 22b856de5cdd..958dbb248518 100644
--- a/tools/testing/selftests/x86/test_shadow_stack.c
+++ b/tools/testing/selftests/x86/test_shadow_stack.c
@@ -11,6 +11,7 @@
 #define _GNU_SOURCE
 
 #include <sys/syscall.h>
+#include <asm/mman.h>
 #include <sys/mman.h>
 #include <sys/stat.h>
 #include <sys/wait.h>
