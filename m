Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7CB5F4A7D
	for <lists+linux-arch@lfdr.de>; Tue,  4 Oct 2022 22:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbiJDUub (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Oct 2022 16:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiJDUua (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Oct 2022 16:50:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD08B5FAE4;
        Tue,  4 Oct 2022 13:50:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 795FA61522;
        Tue,  4 Oct 2022 20:50:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80DE0C433C1;
        Tue,  4 Oct 2022 20:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664916624;
        bh=lqWjHI9NBUUM724MhIy63OWllMBD4Wk6VPg2fo9VCpU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uvT1CHVfE78uNt8XRoidqxIxj7EJHwSZ/FyzzgppMdpmmpeoY/yFE2Q5BOR9kYfQy
         zSSwB3Ml+g4pC+XBDZ0I5oXbxq05jtp1tSfrNGdDAknXw9rFzeLuVX9X2Bc10GYHCL
         pb3bGSPVBP4PU1PDWcTpyX1DyKsgShNOd9elSF4cEKbTl0FPrDxHM+w2+6VfPGJDUS
         NIn+6XHteTgd/TYZJ1LADDst0PFIzcXWgoEy1UBQPkm5RJ91VXwPdbibjJKLIZE6XZ
         FCBFD9JqOkvvq9muRXwfg2+6/CH3AHdOSmesrc8500Xx9kPIX2wLUm/W/PXmEO1Y3f
         RNpHz00K6SZfQ==
Date:   Tue, 4 Oct 2022 13:50:20 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "keescook@chromium.org" <keescook@chromium.org>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "babu.moger@amd.com" <babu.moger@amd.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>, "pavel@ucw.cz" <pavel@ucw.cz>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "Moreira, Joao" <joao.moreira@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "gustavoars@kernel.org" <gustavoars@kernel.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Subject: Re: [PATCH v2 33/39] x86/cpufeatures: Limit shadow stack to Intel
 CPUs
Message-ID: <YzycjLUVh/WhPtKa@dev-arch.thelio-3990X>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <20220929222936.14584-34-rick.p.edgecombe@intel.com>
 <202210031656.23FAA3195@keescook>
 <559f937f-cab4-d408-6d95-fc85b4809aa9@intel.com>
 <202210032147.ED1310CEA8@keescook>
 <YzxViiyfMRKrmoMY@dev-arch.thelio-3990X>
 <ae5fea4b-8c33-c523-9d6d-3f27a9ae03d0@amd.com>
 <9e9396e207529af53b4755cce9d1744c0691e8b2.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e9396e207529af53b4755cce9d1744c0691e8b2.camel@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Oct 04, 2022 at 08:34:54PM +0000, Edgecombe, Rick P wrote:
> On Tue, 2022-10-04 at 14:43 -0500, John Allen wrote:
> > On 10/4/22 10:47 AM, Nathan Chancellor wrote:
> > > Hi Kees,
> > > 
> > > On Mon, Oct 03, 2022 at 09:54:26PM -0700, Kees Cook wrote:
> > > > On Mon, Oct 03, 2022 at 05:09:04PM -0700, Dave Hansen wrote:
> > > > > On 10/3/22 16:57, Kees Cook wrote:
> > > > > > On Thu, Sep 29, 2022 at 03:29:30PM -0700, Rick Edgecombe
> > > > > > wrote:
> > > > > > > Shadow stack is supported on newer AMD processors, but the
> > > > > > > kernel
> > > > > > > implementation has not been tested on them. Prevent basic
> > > > > > > issues from
> > > > > > > showing up for normal users by disabling shadow stack on
> > > > > > > all CPUs except
> > > > > > > Intel until it has been tested. At which point the
> > > > > > > limitation should be
> > > > > > > removed.
> > > > > > > 
> > > > > > > Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> > > > > > 
> > > > > > So running the selftests on an AMD system is sufficient to
> > > > > > drop this
> > > > > > patch?
> > > > > 
> > > > > Yes, that's enough.
> > > > > 
> > > > > I _thought_ the AMD folks provided some tested-by's at some
> > > > > point in the
> > > > > past.  But, maybe I'm confusing this for one of the other
> > > > > shared
> > > > > features.  Either way, I'm sure no tested-by's were dropped on
> > > > > purpose.
> > > > > 
> > > > > I'm sure Rick is eager to trim down his series and this would
> > > > > be a great
> > > > > patch to drop.  Does anyone want to make that easy for Rick?
> > > > > 
> > > > > <hint> <hint>
> > > > 
> > > > Hey Gustavo, Nathan, or Nick! I know y'all have some fancy AMD
> > > > testing
> > > > rigs. Got a moment to spin up this series and run the selftests?
> > > > :)
> > > 
> > > I do have access to a system with an EPYC 7513, which does have
> > > Shadow
> > > Stack support (I can see 'shstk' in the "Flags" section of lscpu
> > > with
> > > this series). As far as I understand it, AMD only added Shadow
> > > Stack
> > > with Zen 3; my regular AMD test system is Zen 2 (probably should
> > > look at
> > > procurring a Zen 3 or Zen 4 one at some point).
> > > 
> > > I applied this series on top of 6.0 and reverted this change then
> > > booted
> > > it on that system. After building the selftest (which did require
> > > 'make headers_install' and a small addition to make it build beyond
> > > that, see below), I ran it and this was the result. I am not sure
> > > if
> > > that is expected or not but the other results seem promising for
> > > dropping this patch.
> > > 
> > >    $ ./test_shadow_stack_64
> > >    [INFO]  new_ssp = 7f8a36c9fff8, *new_ssp = 7f8a36ca0001
> > >    [INFO]  changing ssp from 7f8a374a0ff0 to 7f8a36c9fff8
> > >    [INFO]  ssp is now 7f8a36ca0000
> > >    [OK]    Shadow stack pivot
> > >    [OK]    Shadow stack faults
> > >    [INFO]  Corrupting shadow stack
> > >    [INFO]  Generated shadow stack violation successfully
> > >    [OK]    Shadow stack violation test
> > >    [INFO]  Gup read -> shstk access success
> > >    [INFO]  Gup write -> shstk access success
> > >    [INFO]  Violation from normal write
> > >    [INFO]  Gup read -> write access success
> > >    [INFO]  Violation from normal write
> > >    [INFO]  Gup write -> write access success
> > >    [INFO]  Cow gup write -> write access success
> > >    [OK]    Shadow gup test
> > >    [INFO]  Violation from shstk access
> > >    [OK]    mprotect() test
> > >    [OK]    Userfaultfd test
> > >    [FAIL]  Alt shadow stack test
> > 
> > The selftest is looking OK on my system (Dell PowerEdge R6515 w/ EPYC
> > 7713). I also just pulled a fresh 6.0 kernel and applied the series
> > including the fix Nathan mentions below.
> > 
> > $ tools/testing/selftests/x86/test_shadow_stack_64
> > [INFO]  new_ssp = 7f30cccc5ff8, *new_ssp = 7f30cccc6001
> > [INFO]  changing ssp from 7f30cd4c6ff0 to 7f30cccc5ff8
> > [INFO]  ssp is now 7f30cccc6000
> > [OK]    Shadow stack pivot
> > [OK]    Shadow stack faults
> > [INFO]  Corrupting shadow stack
> > [INFO]  Generated shadow stack violation successfully
> > [OK]    Shadow stack violation test
> > [INFO]  Gup read -> shstk access success
> > [INFO]  Gup write -> shstk access success
> > [INFO]  Violation from normal write
> > [INFO]  Gup read -> write access success
> > [INFO]  Violation from normal write
> > [INFO]  Gup write -> write access success
> > [INFO]  Cow gup write -> write access success
> > [OK]    Shadow gup test
> > [INFO]  Violation from shstk access
> > [OK]    mprotect() test
> > [OK]    Userfaultfd test
> > [OK]    Alt shadow stack test.
> 
> Thanks for the testing. Based on the test, I wonder if this could be a
> SW bug. Nathan, could I send you a tweaked test with some more debug
> information?

Yes, more than happy to help you look into this further!

> John, are we sure AMD and Intel systems behave the same with respect to
> CPUs not creating Dirty=1,Write=0 PTEs in rare situations? Or any other
> CET related differences we should hash out? Otherwise I'll drop the
> patch for the next version. (and assuming the issue Nathan hit doesn't
> turn up anything HW related).
