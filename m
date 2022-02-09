Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2523D4AF03F
	for <lists+linux-arch@lfdr.de>; Wed,  9 Feb 2022 12:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbiBIL4O (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Feb 2022 06:56:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231597AbiBILz0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Feb 2022 06:55:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 887D9C0045A9;
        Wed,  9 Feb 2022 02:54:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1527B612E7;
        Wed,  9 Feb 2022 10:54:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F355C340EE;
        Wed,  9 Feb 2022 10:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644404049;
        bh=8nfXi2bAkBkxKe4ZmVJ1McrLUR/vS+aiNoKC3c4V54c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o8kvTb2TMbpq1whYqOyKIm1hlJzLi/Q/a7JoUpj/jGssXx7Qt2YZfBNYkEkw/hZXE
         oSInBQ5nuOk5Os7WPqk0FsmT5MYuYpJeH1AwVx9/sNxYghplvePkYAHWRcNnd3okRc
         M9krUM2hOFkqKwv1q7AvLokp6kWPbgxm4oByhL31KH+6gGAD8NURHSZGlgRPeJ34wR
         oKsYkioVYxJpiwc0Ji4Sp/jM+78yoZTEYYk3XHfiYOqzRm+ha7Fh2SpXMJsyh6VB8N
         ivZdoNTpo9Vm+5jKSaeoJXseiJK/X0ch6HI7SG9uzqs2raWQmeBW+yzpszfgW8m8ad
         YPv9Vixyl0Iow==
Date:   Wed, 9 Feb 2022 12:53:51 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "Lutomirski, Andy" <luto@kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "0x7f454c46@gmail.com" <0x7f454c46@gmail.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "adrian@lisas.de" <adrian@lisas.de>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "avagin@gmail.com" <avagin@gmail.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>, "bp@alien8.de" <bp@alien8.de>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "Moreira, Joao" <joao.moreira@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Dave.Martin@arm.com" <Dave.Martin@arm.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>
Subject: Re: [PATCH 00/35] Shadow stacks for userspace
Message-ID: <YgOdP7YFwbX13SlP@kernel.org>
References: <20220130211838.8382-1-rick.p.edgecombe@intel.com>
 <YgAWVSGQg8FPCeba@kernel.org>
 <YgDIIpCm3UITk896@lisas.de>
 <8f96c2a6-9c03-f97a-df52-73ffc1d87957@intel.com>
 <YgI1A0CtfmT7GMIp@kernel.org>
 <YgI37n+3JfLSNQCQ@grain>
 <357664de-b089-4617-99d1-de5098953c80@www.fastmail.com>
 <YgKiKEcsNt7mpMHN@grain>
 <8e36f20723ca175db49ed3cc73e42e8aa28d2615.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e36f20723ca175db49ed3cc73e42e8aa28d2615.camel@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Rick,

On Wed, Feb 09, 2022 at 02:18:42AM +0000, Edgecombe, Rick P wrote:
> On Tue, 2022-02-08 at 20:02 +0300, Cyrill Gorcunov wrote:
> > On Tue, Feb 08, 2022 at 08:21:20AM -0800, Andy Lutomirski wrote:
> > > > > But such a knob will immediately reduce the security value of
> > > > > the entire
> > > > > thing, and I don't have good ideas how to deal with it :(
> > > > 
> > > > Probably a kind of latch in the task_struct which would trigger
> > > > off once
> > > > returt to a different address happened, thus we would be able to
> > > > jump inside
> > > > paratite code. Of course such trigger should be available under
> > > > proper
> > > > capability only.
> > > 
> > > I'm not fully in touch with how parasite, etc works.  Are we
> > > talking about save or restore?
> > 
> > We use parasite code in question during checkpoint phase as far as I
> > remember.
> > push addr/lret trick is used to run "injected" code (code injection
> > itself is
> > done via ptrace) in compat mode at least. Dima, Andrei, I didn't look
> > into this code
> > for years already, do we still need to support compat mode at all?
> > 
> > > If it's restore, what exactly does CRIU need to do?  Is it just
> > > that CRIU needs to return
> > > out from its resume code into the to-be-resumed program without
> > > tripping CET?  Would it
> > > be acceptable for CRIU to require that at least one shstk slot be
> > > free at save time?
> > > Or do we need a mechanism to atomically switch to a completely full
> > > shadow stack at resume?
> > > 
> > > Off the top of my head, a sigreturn (or sigreturn-like mechanism)
> > > that is intended for
> > > use for altshadowstack could safely verify a token on the
> > > altshdowstack, possibly
> > > compare to something in ucontext (or not -- this isn't clearly
> > > necessary) and switch
> > > back to the previous stack.  CRIU could use that too.  Obviously
> > > CRIU will need a way
> > > to populate the relevant stacks, but WRUSS can be used for that,
> > > and I think this
> > > is a fundamental requirement for CRIU -- CRIU restore absolutely
> > > needs a way to write
> > > the saved shadow stack data into the shadow stack.
> 
> Still wrapping my head around the CRIU save and restore steps, but
> another general approach might be to give ptrace the ability to
> temporarily pause/resume/set CET enablement and SSP for a stopped
> thread. Then injected code doesn't need to jump through any hoops or
> possibly run into road blocks. I'm not sure how much this opens things
> up if the thread has to be stopped...
 
IIRC, criu dump does something like this:
* Stop the process being dumped (victim) with ptrace
* Inject parasite code and data into the victim, again with ptrace.
  Among other things the parasite data contains a sigreturn frame with
  saved victim state.
* Resume the victim process, which will run parasite code now.
* When parasite finishes it uses that frame to sigreturn to normal victim
  execution

So, my feeling is that for dump side WRUSS should be enough.

> Cyrill, could it fit into the CRIU pause and resume flow? What action
> causes the final resuming of execution of the restored process for
> checkpointing and for restore? Wondering if we could somehow make CET
> re-enable exactly then.
> 
> And I guess this also needs a way to create shadow stack allocations at
> a specific address to match where they were in the dumped process. That
> is missing in this series.

Yes, criu restore will need to recreate shadow stack mappings. Currently,
we recreate the restored process (target) address space based on
/proc/pid/maps and /proc/pid/smaps. CRIU preserves the virtual addresses
and VMA flags. The relevant steps of restore process can be summarised as:
* Clone() the target process tree
* Recreate VMAs with the needed size and flags, but not necessarily at the
  correct place yet
* Partially populate memory data from the saved images
* Move VMAs to their exact addresses
* Complete restoring the data
* Create a frame for sigreturn and jump to the target.

Here, the stack used after sigreturn contains the data that was captured
during dump and it entirely different from what shadow stack will contain.

There are several points when the target threads are stopped, so
pausing/resuming CET may help.
 
> > > So I think the only special capability that CRIU really needs is
> > > WRUSS, and
> > > we need to wire that up anyway.
> > 
> > Thanks for these notes, Andy! I can't provide any sane answer here
> > since didn't
> > read tech spec for this feature yet :-)
> 
> 
> 
> 

-- 
Sincerely yours,
Mike.
