Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08562418251
	for <lists+linux-arch@lfdr.de>; Sat, 25 Sep 2021 15:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245582AbhIYNca (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 25 Sep 2021 09:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245082AbhIYNc3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 25 Sep 2021 09:32:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 526DFC061570;
        Sat, 25 Sep 2021 06:30:55 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632576652;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hcK440/A2t29+9f6o8g/qxJ5FA5DoAQ9IVDgmyj6BZ0=;
        b=zBt4lL7w0QoxRlFafp5xqcbaerU8EfhjSVUVexryfeIDcjvBZVariaTz94zXNMySEvdOEH
        Qig4F7ofz6uBrsquUQrNjaNCiXKBkARSXkBVdN1L0CorVFiTD7jkWpVqQi/DdC6SL5R4Hq
        k71IpDGIHXdcJAAaWDUvxpZUtoeCg2PhULYERxSHFeM3MWBORxz6AxQC8DHYiREwR3S/Zt
        wgitbVfV0yeWIvQt10IPl3VHO9q2dRxT9tv0FbtD0bAYKhmO9M6XznWyTnMxDiR7Q3VCAz
        D45ShYq1/0LbLxHrKcwBicomCR7CTyTj9UQ4snBUQp/6OnCmCZSZBoB25ah8Rg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632576652;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hcK440/A2t29+9f6o8g/qxJ5FA5DoAQ9IVDgmyj6BZ0=;
        b=2OOV6i0kLQWP28ioPuSUEXkWCesxyw7FyOiyJFUOWrG4vE5zTrLUAbhUGBaMY4KnFMrYrP
        6Wd2SIz/ETv8N9BA==
To:     Sohil Mehta <sohil.mehta@intel.com>, x86@kernel.org
Cc:     Sohil Mehta <sohil.mehta@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Christian Brauner <christian@brauner.io>,
        Peter Zijlstra <peterz@infradead.org>,
        Shuah Khan <shuah@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Ashok Raj <ashok.raj@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Zeng Guang <guang.zeng@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Randy E Witt <randy.e.witt@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Ramesh Thomas <ramesh.thomas@intel.com>,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH 05/13] x86/irq: Reserve a user IPI notification vector
In-Reply-To: <87fstugabg.ffs@tglx>
References: <20210913200132.3396598-1-sohil.mehta@intel.com>
 <20210913200132.3396598-6-sohil.mehta@intel.com> <87fstugabg.ffs@tglx>
Date:   Sat, 25 Sep 2021 15:30:52 +0200
Message-ID: <878rzkeq9f.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Sep 24 2021 at 01:07, Thomas Gleixner wrote:
> On Mon, Sep 13 2021 at 13:01, Sohil Mehta wrote:
>> The kernel doesn't need to do anything in this case other than receiving
>> the interrupt and clearing the local APIC. The user interrupt is always
>> stored in the receiver's UPID before the IPI is generated. When the
>> receiver gets scheduled back the interrupt would be delivered based on
>> its UPID.
>
> So why on earth is that vector reaching the CPU at all?

Let's see how this works:

  task starts using UINTR.
    set UINTR_NOTIFACTION_VECTOR in MSR_IA32_UINTR_MISC
    
So from that point on the User-Interrupt Notification Identification
mechanism swallows the vector.

Where this stops working is not limited to context switch. The wreckage
comes from XSAVES:

 "After saving the user-interrupt state component, XSAVES clears
  UINV. (UINV is IA32_UINTR_MISC[39:32]; XSAVES does not modify the
  remainder of that MSR.)"

So the problem is _not_ context switch. The problem is XSAVES and that
can be issued even without a context switch.

The obvious question is: What is the value of clearing UINV?

Absolutely none. That notification vector cannot be used for anything
else, so why would the OS be interested to see it ever? This is about
user space interupts, right?

UINV should be set _ONCE_ when CR4.UINTR is enabled and not be touched
by XSAVES/XRSTORS at all. Any delivery of this vector to the OS should
be considered a hardware bug.

Thanks,

         tglx
