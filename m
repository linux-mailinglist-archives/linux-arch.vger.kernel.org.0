Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0D74160C3
	for <lists+linux-arch@lfdr.de>; Thu, 23 Sep 2021 16:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241463AbhIWOLV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Sep 2021 10:11:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:35764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241603AbhIWOLU (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 23 Sep 2021 10:11:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 22F9360F44;
        Thu, 23 Sep 2021 14:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1632406188;
        bh=ZTXZf30T3ZUc5R8VZRJeJBfdae5TPW0th0RClDFdmdM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RxK7Top7vHYOES/amPXJnFenVjo0z1GxYXGT3k/Pyxf3hwK+9RBPl2JQBMvA3rhgj
         ztdDDfIrLIkkNbZ4oLXX2AhB/qQ8rB/TQz4SMfzg5+od+heVr1b1aInMgefEGzDDjv
         xjSTc4pdVdE2p+fxWCl5UKcuHhuGEoZ0fIk4RucM=
Date:   Thu, 23 Sep 2021 16:09:46 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Mehta, Sohil" <sohil.mehta@intel.com>
Cc:     "Hansen, Dave" <dave.hansen@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Luck, Tony" <tony.luck@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Lutomirski, Andy" <luto@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christian Brauner <christian@brauner.io>,
        Peter Zijlstra <peterz@infradead.org>,
        Shuah Khan <shuah@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        "Kammela, Gayatri" <gayatri.kammela@intel.com>,
        "Zeng, Guang" <guang.zeng@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Witt, Randy E" <randy.e.witt@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "Thomas, Ramesh" <ramesh.thomas@intel.com>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: Re: [RFC PATCH 00/13] x86 User Interrupts support
Message-ID: <YUyKqmKR0pOcP/NA@kroah.com>
References: <20210913200132.3396598-1-sohil.mehta@intel.com>
 <c08f38db-77da-c50e-23f7-b3a76688deeb@intel.com>
 <BYAPR11MB33203044CD5D7413846655F9E5DA9@BYAPR11MB3320.namprd11.prod.outlook.com>
 <YUxwuR4V+kwk1L34@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUxwuR4V+kwk1L34@kroah.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 23, 2021 at 02:19:05PM +0200, Greg KH wrote:
> On Tue, Sep 14, 2021 at 07:03:36PM +0000, Mehta, Sohil wrote:
> > Resending.. There were some email delivery issues.
> > 
> > On 9/13/2021 1:27 PM, Dave Hansen wrote:
> > >	User Interrupts directly deliver events to user space and are
> > >	10x faster than the closest alternative.
> > 
> > Thanks Dave. This is definitely more attention-grabbing than the
> > previous intro. I'll include this next time.
> > 
> > One thing to note, the 10x gain is only applicable for User IPIs.
> > For other source of User Interrupts (like kernel-to-user
> > notifications and other external sources), we don't have the data
> > yet.
> > 
> > I realized the User IPI data in the cover also needs some
> > clarification. The 10x gain is only seen when the receiver is
> > spinning in User space - waiting for interrupts.
> > 
> > If the receiver were to block (wait) in the kernel, the performance
> > would drop as expected. However, User IPI (blocked) would still be
> > 10% faster than Eventfd and 40% faster than signals.
> > 
> > Here is the updated table:
> > +---------------------+-------------------------+
> > | IPC type            |   Relative Latency      |
> > |                     |(normalized to User IPI) |
> > +---------------------+-------------------------+
> > | User IPI            |                     1.0 |
> > | User IPI (blocked)  |                     8.9 |
> > | Signal              |                    14.8 |
> > | Eventfd             |                     9.7 |
> > | Pipe                |                    16.3 |
> > | Domain              |                    17.3 |
> > +---------------------+-------------------------+
> 
> Relative is just that, "relative".  If the real values are extremely
> tiny, then relative is just "this goes a tiny tiny bit faster than what
> you have today in eventfd", right?
> 
> So how about "absolute"?  What are we talking here?
> 
> And this is really only for the "one userspace task waking up another
> userspace task" policies.  What real workload can actually use this?

Also, you forgot to list Binder in the above IPC type.

And you forgot to mention that this is tied to one specific CPU type
only.  Are syscalls allowed to be created that would only work on
obscure cpus like this one?

thanks,

greg k-h
