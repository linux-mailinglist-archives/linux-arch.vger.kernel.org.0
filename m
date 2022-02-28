Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3B44C7A5B
	for <lists+linux-arch@lfdr.de>; Mon, 28 Feb 2022 21:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbiB1U2Q (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 28 Feb 2022 15:28:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiB1U2P (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 28 Feb 2022 15:28:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43DC647AE4;
        Mon, 28 Feb 2022 12:27:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D5D7960C24;
        Mon, 28 Feb 2022 20:27:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B278C340F2;
        Mon, 28 Feb 2022 20:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646080055;
        bh=Afapf1pYfGXISLziFelpEK++X0t+Auwfn5socGkEaSE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WaNbKRVb+8PyC2XBMMuGUDzadTZQU7i4YPRjxMq7iFSKes7Vv4DyIVaBobjJOeoL6
         oZt4Z44m7gTyg1BoNpW3KqQNTUkAjhFc5lq/9nDsrzoowLNwwYMZwXLWcCTYAyEPZ6
         FgRG1DnhR9He9KtCfA3xkUkfsj4noS1+aNDR7H18/oFJ53uCYVt06GHHWvlNDWy5b9
         jCLHRm1IW6RzLfF1lbcUVgAKGt6HNzjcfD4o4Uh92jK8FiWxDRV1NuYdYY0w1HgQHQ
         aE3OLyBUl05iyG/BGvpez2NppZwA0Yp+RXEqG49Dg0AL+dnXtsEA9xWNx+dEx8RCQN
         TZJGMvbUKSsaw==
Date:   Mon, 28 Feb 2022 22:27:12 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
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
Message-ID: <Yh0wIMjFdDl8vaNM@kernel.org>
References: <20220130211838.8382-1-rick.p.edgecombe@intel.com>
 <YgAWVSGQg8FPCeba@kernel.org>
 <YgDIIpCm3UITk896@lisas.de>
 <8f96c2a6-9c03-f97a-df52-73ffc1d87957@intel.com>
 <YgI1A0CtfmT7GMIp@kernel.org>
 <YgI37n+3JfLSNQCQ@grain>
 <357664de-b089-4617-99d1-de5098953c80@www.fastmail.com>
 <YgKiKEcsNt7mpMHN@grain>
 <8e36f20723ca175db49ed3cc73e42e8aa28d2615.camel@intel.com>
 <9d664c91-2116-42cc-ef8d-e6d236de43d0@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d664c91-2116-42cc-ef8d-e6d236de43d0@kernel.org>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 09, 2022 at 06:37:53PM -0800, Andy Lutomirski wrote:
> On 2/8/22 18:18, Edgecombe, Rick P wrote:
> > On Tue, 2022-02-08 at 20:02 +0300, Cyrill Gorcunov wrote:
> > 
> > Still wrapping my head around the CRIU save and restore steps, but
> > another general approach might be to give ptrace the ability to
> > temporarily pause/resume/set CET enablement and SSP for a stopped
> > thread. Then injected code doesn't need to jump through any hoops or
> > possibly run into road blocks. I'm not sure how much this opens things
> > up if the thread has to be stopped...
> 
> Hmm, that's maybe not insane.
> 
> An alternative would be to add a bona fide ptrace call-a-function mechanism.
> I can think of two potentially usable variants:
> 
> 1. Straight call.  PTRACE_CALL_FUNCTION(addr) just emulates CALL addr,
> shadow stack push and all.
> 
> 2. Signal-style.  PTRACE_CALL_FUNCTION_SIGFRAME injects an actual signal
> frame just like a real signal is being delivered with the specified handler.
> There could be a variant to opt-in to also using a specified altstack and
> altshadowstack.

Using ptrace() will not solve CRIU's issue with sigreturn because sigreturn
is called from the victim context rather than from the criu process that
controls the dump and uses ptrace().

Even with the current shadow stack interface Rick proposed, CRIU can restore
the victim using ptrace without any additional knobs, but we loose an
important ability to "self-cure" the victim from the parasite in case
anything goes wrong with criu control process.

Moreover, the issue with backward compatibility is not with ptrace but with
sigreturn and it seems that criu is not its only user.

So I think we need a way to allow direct calls to sigreturn that will
bypass check and restore of the shadow stack.

I only know that there are sigreturn users except criu that show up in
Debian codesearch, and I don't know how do they use it, but for full
backward compatibility we'd need to have no-CET sigreturn as default and
add a new, say UC_CHECK_SHSTK flag to rt_sigframe->uc.uc_flags or even a
new syscall for libc signal handling.
 
> 2 would be more expensive but would avoid the need for much in the way of
> asm magic.  The injected code could be plain C (or Rust or Zig or whatever).
> 
> All of this only really handles save, not restore.  I don't understand
> restore enough to fully understand the issue.

Restore is more complex, will get to it later.
 
> --Andy

-- 
Sincerely yours,
Mike.
