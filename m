Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DFA836E5EC
	for <lists+linux-arch@lfdr.de>; Thu, 29 Apr 2021 09:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239563AbhD2H3C (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 29 Apr 2021 03:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239542AbhD2H25 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 29 Apr 2021 03:28:57 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E48C06138F;
        Thu, 29 Apr 2021 00:28:11 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id h36so49163112lfv.7;
        Thu, 29 Apr 2021 00:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jdGoIRWBioljnz1nn4BBzNDaqsoqN9PPsguAeYrjWLg=;
        b=HJX7+45yNzfNOqoK21ORJnfSS4SqA73WGkbuaPh5kcOvNYBW3pgUgci+P8nrnGhQNi
         QZWfIOMDuLxP7E+IQpYLX9lQKKuah9ZA8zd1fRzmg+us00a0DmfVFSJnoglvDlrR5JPu
         wZT0M0/aUfULpMBV9n6oztU1UyISEfYE99jx+Q8TP6g+4uRAG8uA8+yTJauJnN5AbBUY
         qNoqboxDl+xzzGI7bhFrM+aicJFNWgbT7KP6ymuX4ynpdc3n//T15fOaV6b78MEdGhpM
         FgBTL7grc3s+XEViMjWFpN6JTZThcff9VQa1IWXouixVnItPd6v/EBVeRr1oW/H3lGiu
         /UIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jdGoIRWBioljnz1nn4BBzNDaqsoqN9PPsguAeYrjWLg=;
        b=F7+IaO8wzRH5HaDZ7T77Gov35YfycrgsjdDmc/5Uz+pJbUnQSZzrU5lrgE64EQhJSP
         32Lk8yfAiYARvKp8shBrftuGmLcoo0qws35hlHZkKmaMgohLu7GvpPRhbBsZ32ZOSgWi
         oMOroKpoqpAKsqedrDZsnY9U12THMT0UMEIFYriBshw4xmcaFWca8fXO4ITnqb9iX6RR
         osr1sxE1LfcqW6m17zK5polb/jxBA9GGCTBP2iXmptwNrb8WAfllNfT1ntJVIz1VIq40
         Oa5gI4UTsU6qavlS3g4NLC5zoJ4RO2GeoNH7aZjxwb7W3mPYw1VDTMLzT7qJ1JoL1Jt+
         jb9A==
X-Gm-Message-State: AOAM531FUzHww6X9No679KWry/KHEaRq6pENdedH23LqD53HVRitJCdj
        H0n7s7Bmx7zpKM0RozizhrY=
X-Google-Smtp-Source: ABdhPJwuzpu7JK/CSqJabsNtmy0swVR3AkMVRzJ7rqYa3XCC6KgbaqN5bCkxJUe0VVIgGQcVOJHNpg==
X-Received: by 2002:a05:6512:12d2:: with SMTP id p18mr4572032lfg.239.1619681289241;
        Thu, 29 Apr 2021 00:28:09 -0700 (PDT)
Received: from grain.localdomain ([5.18.199.94])
        by smtp.gmail.com with ESMTPSA id f17sm260073lfu.215.2021.04.29.00.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 00:28:08 -0700 (PDT)
Received: by grain.localdomain (Postfix, from userid 1000)
        id 72CF5560116; Thu, 29 Apr 2021 10:28:07 +0300 (MSK)
Date:   Thu, 29 Apr 2021 10:28:07 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>,
        linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Haitao Huang <haitao.huang@intel.com>
Subject: Re: extending ucontext (Re: [PATCH v26 25/30] x86/cet/shstk: Handle
 signals for shadow stack)
Message-ID: <YIpgB5HbnNPWX4FP@grain>
References: <20210427204315.24153-1-yu-cheng.yu@intel.com>
 <20210427204315.24153-26-yu-cheng.yu@intel.com>
 <CALCETrVTeYfzO-XWh+VwTuKCyPyp-oOMGH=QR_msG9tPQ4xPmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrVTeYfzO-XWh+VwTuKCyPyp-oOMGH=QR_msG9tPQ4xPmA@mail.gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Apr 28, 2021 at 04:03:55PM -0700, Andy Lutomirski wrote:
> On Tue, Apr 27, 2021 at 1:44 PM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
> >
> > When shadow stack is enabled, a task's shadow stack states must be saved
> > along with the signal context and later restored in sigreturn.  However,
> > currently there is no systematic facility for extending a signal context.
> > There is some space left in the ucontext, but changing ucontext is likely
> > to create compatibility issues and there is not enough space for further
> > extensions.
> >
> > Introduce a signal context extension struct 'sc_ext', which is used to save
> > shadow stack restore token address.  The extension is located above the fpu
> > states, plus alignment.  The struct can be extended (such as the ibt's
> > wait_endbr status to be introduced later), and sc_ext.total_size field
> > keeps track of total size.
> 
> I still don't like this.
> 
> Here's how the signal layout works, for better or for worse:
> 
> The kernel has:
> 
> struct rt_sigframe {
>     char __user *pretcode;
>     struct ucontext uc;
>     struct siginfo info;
>     /* fp state follows here */
> };
> 
> This is roughly the actual signal frame.  But userspace does not have
> this struct declared, and user code does not know the sizes of the
> fields.  So it's accessed in a nonsensical way.  The signal handler

Well, not really. While indeed this is not declared as a part of API
the structure is widely used for rt_sigreturn syscall (and we're using
it inside criu thus any change here will simply break the restore
procedure). Sorry out of time right now, I'll read your mail more
carefully once time permit.
