Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3959D349AEF
	for <lists+linux-arch@lfdr.de>; Thu, 25 Mar 2021 21:21:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbhCYUUx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Thu, 25 Mar 2021 16:20:53 -0400
Received: from albireo.enyo.de ([37.24.231.21]:34966 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230347AbhCYUUm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 25 Mar 2021 16:20:42 -0400
X-Greylist: delayed 367 seconds by postgrey-1.27 at vger.kernel.org; Thu, 25 Mar 2021 16:20:42 EDT
Received: from [172.17.203.2] (port=38035 helo=deneb.enyo.de)
        by albireo.enyo.de ([172.17.140.2]) with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1lPWNA-0006VJ-Bh; Thu, 25 Mar 2021 20:14:28 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.92)
        (envelope-from <fw@deneb.enyo.de>)
        id 1lPWN9-00045D-5Z; Thu, 25 Mar 2021 21:14:27 +0100
From:   Florian Weimer <fw@deneb.enyo.de>
To:     "Bae\, Chang Seok via Libc-alpha" <libc-alpha@sourceware.org>
Cc:     Borislav Petkov <bp@suse.de>,
        "Bae\, Chang Seok" <chang.seok.bae@intel.com>,
        "linux-arch\@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "Brown\, Len" <len.brown@intel.com>,
        "Luck\, Tony" <tony.luck@intel.com>,
        "jannh\@google.com" <jannh@google.com>,
        "x86\@kernel.org" <x86@kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Dave.Martin\@arm.com" <Dave.Martin@arm.com>,
        "Hansen\, Dave" <dave.hansen@intel.com>,
        "luto\@kernel.org" <luto@kernel.org>,
        "linux-api\@vger.kernel.org" <linux-api@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "mingo\@kernel.org" <mingo@kernel.org>,
        "Shankar\, Ravi V" <ravi.v.shankar@intel.com>
Subject: Re: [PATCH v7 5/6] x86/signal: Detect and prevent an alternate signal stack overflow
References: <20210316065215.23768-1-chang.seok.bae@intel.com>
        <20210316065215.23768-6-chang.seok.bae@intel.com>
        <20210316115248.GB18822@zn.tnic>
        <16A53D65-2460-49B3-892B-81EF8D7B12B9@intel.com>
        <20210325162047.GA32296@zn.tnic>
        <06722BDE-738A-4513-886E-2C1442C97369@intel.com>
Date:   Thu, 25 Mar 2021 21:14:27 +0100
In-Reply-To: <06722BDE-738A-4513-886E-2C1442C97369@intel.com> (Chang Seok via
        Libc-alpha Bae's message of "Thu, 25 Mar 2021 17:21:04 +0000")
Message-ID: <87o8f7j8ik.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

* Chang Seok via Libc-alpha Bae:

> On Mar 25, 2021, at 09:20, Borislav Petkov <bp@suse.de> wrote:
>> 
>> $ gcc tst-minsigstksz-2.c -DMY_MINSIGSTKSZ=3453 -o tst-minsigstksz-2
>> $ ./tst-minsigstksz-2
>> tst-minsigstksz-2: changed byte 50 bytes below configured stack
>> 
>> Whoops.
>> 
>> And the debug print said:
>> 
>> [ 5395.252884] signal: get_sigframe: sp: 0x7f54ec39e7b8, sas_ss_sp: 0x7f54ec39e6ce, sas_ss_size 0xd7d
>> 
>> which tells me that, AFAICT, your check whether we have enough alt stack
>> doesn't seem to work in this case.
>
> Yes, in this case.
>
> tst-minsigstksz-2.c has this code:
>
> static void
> handler (int signo)
> {
>   /* Clear a bit of on-stack memory.  */
>   volatile char buffer[256];
>   for (size_t i = 0; i < sizeof (buffer); ++i)
>     buffer[i] = 0;
>   handler_run = 1;
> }
> …
>
>   if (handler_run != 1)
>     errx (1, "handler did not run");
>
>   for (void *p = stack_buffer; p < stack_bottom; ++p)
>     if (*(unsigned char *) p != 0xCC)
>       errx (1, "changed byte %zd bytes below configured stack\n",
>             stack_bottom - p);
> …
>
> I think the message comes from the handler’s overwriting, not from the kernel.
>
> The patch's check is to detect and prevent the kernel-induced overflow --
> whether alt stack enough for signal delivery itself.  The stack is possibly
> not enough for the signal handler's use as the kernel does not know for it.

Ahh, right.  When I wrote the test, I didn't know which turn the
kernel would eventually take, so the test is quite arbitrary.

The glibc dynamic loader uses XSAVE/XSAVEC as well, so you can
probably double the practical stack requirement if lazy binding is in
use and can be triggered from the signal handler.  Estimating stack
sizes is hard.
