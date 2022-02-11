Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24D024B1FDD
	for <lists+linux-arch@lfdr.de>; Fri, 11 Feb 2022 09:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347113AbiBKIFA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Feb 2022 03:05:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232830AbiBKIE7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 Feb 2022 03:04:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A269BD2;
        Fri, 11 Feb 2022 00:04:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0DE1BB82460;
        Fri, 11 Feb 2022 08:04:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C6E5C340E9;
        Fri, 11 Feb 2022 08:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644566696;
        bh=EvZx0hPGNr7WhzzF6zfcEjl+rm+0wcT7PDP5rXEhoT0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G668fAVy/mmFRiG3NNwK0RRvNbwbvLzzW7b3dKcOaYoiz/0vYGm+O0HkNI+Jfn1JK
         SsY7JNbENx3Gb28wL/1R64G64QUiIcDvwD067oZ2fnn7mupZkUtAqXCGyZrr5ccBXA
         1lbPqWQ//8wnRu+4qGJrQLrrU/OC8V8iJSpaWl/SZaYSuXsO4qEei8/dA40U5HjbAQ
         4bjyixShCHvpdkrBmCHaY6LLzSJpImJmi7ctymB8o7RRQfOjEpoLxZAzU4gChIVUs9
         jDpJQsmcMbLg7lkvciho7BRTMKyATFCroGVcdwXs3DXojexuijzFbcQ4K4WUqhIXV7
         dnTHFfZzfxUvQ==
Date:   Fri, 11 Feb 2022 10:04:38 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     "avagin@gmail.com" <avagin@gmail.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
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
Message-ID: <YgYYllWRJ6znI4AU@kernel.org>
References: <YgAWVSGQg8FPCeba@kernel.org>
 <YgDIIpCm3UITk896@lisas.de>
 <8f96c2a6-9c03-f97a-df52-73ffc1d87957@intel.com>
 <YgI1A0CtfmT7GMIp@kernel.org>
 <YgI37n+3JfLSNQCQ@grain>
 <357664de-b089-4617-99d1-de5098953c80@www.fastmail.com>
 <YgKiKEcsNt7mpMHN@grain>
 <8e36f20723ca175db49ed3cc73e42e8aa28d2615.camel@intel.com>
 <9d664c91-2116-42cc-ef8d-e6d236de43d0@kernel.org>
 <YgYTHLfnOvkK5FUu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgYTHLfnOvkK5FUu@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Feb 10, 2022 at 11:41:16PM -0800, avagin@gmail.com wrote:
> On Wed, Feb 09, 2022 at 06:37:53PM -0800, Andy Lutomirski wrote:
> >
> > An alternative would be to add a bona fide ptrace call-a-function mechanism.
> > I can think of two potentially usable variants:
> > 
> > 1. Straight call.  PTRACE_CALL_FUNCTION(addr) just emulates CALL addr,
> > shadow stack push and all.
> > 
> > 2. Signal-style.  PTRACE_CALL_FUNCTION_SIGFRAME injects an actual signal
> > frame just like a real signal is being delivered with the specified handler.
> > There could be a variant to opt-in to also using a specified altstack and
> > altshadowstack.
> 
> I think this would be ideal. In CRIU, the parasite code is executed in
> the "daemon" mode and returns back via sigreturn.  Right now, CRIU needs
> to generate a signal frame. If I understand your idea right, the signal
> frame will be generated by the kernel.
> 
> > 
> > 2 would be more expensive but would avoid the need for much in the way of
> > asm magic.  The injected code could be plain C (or Rust or Zig or whatever).
> > 
> > All of this only really handles save, not restore.  I don't understand
> > restore enough to fully understand the issue.
> 
> In a few words, it works like this: CRIU restores all required resources
> and prepares a signal frame with a target process state, then it
> switches to a small PIE blob, where it restores vma-s and calls
> rt_sigreturn.

I think it's also important to note that the stack is restored as a part of
the process memory, i.e. its contents is read from the images.
 
> > 
> > --Andy

-- 
Sincerely yours,
Mike.
