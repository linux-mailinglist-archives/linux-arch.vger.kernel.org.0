Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 833674168AD
	for <lists+linux-arch@lfdr.de>; Fri, 24 Sep 2021 02:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236458AbhIXAHZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Sep 2021 20:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232143AbhIXAHZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Sep 2021 20:07:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43736C061574;
        Thu, 23 Sep 2021 17:05:53 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632441951;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oY8EuJiYEKvkUjpvE7Y5S4ag1Dg/um8EAc+9e8mXoRw=;
        b=xA8c8+gHSrJKHkvWZ2jPU2Ndt91Zzd/URXlXCRD1wTNrq15B+kSlp/1PY15x+diOt9PkKa
        8INdgMX1p0OPg9fU5X/uXNW/ymZfXrCkWJ1eqoWTfsJHn9Bt4/qUpBNCHSEPHEewfc1pkd
        w3OwUUH/TZHUz+JHeHqFVW5STwVDVNnYUSvFLC/TnYkwUa3skd0R4Bt/6NlFWfYoHN63h3
        oV0sNk9YJOTc1rSHhyQAq/oQJX7XjCpGd1Y/veBDuDI7TZvhZCW2/n6zF3HMeYUM+gcOkF
        s0eUtwJ2T/BeY2KtS7n2eEZXWW35leUit4hlpCK9w87Fw3DB80dUmX3LvtYHUw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632441951;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oY8EuJiYEKvkUjpvE7Y5S4ag1Dg/um8EAc+9e8mXoRw=;
        b=07PjkRSxh+DGScz1Vj7xjE/dEP53ru2E9F94RJcbaZBEI//uuNfyU2zFv+/LfcIOldKwZN
        vnMpzG8GyE8K2pAA==
To:     Greg KH <gregkh@linuxfoundation.org>,
        Sohil Mehta <sohil.mehta@intel.com>
Cc:     x86@kernel.org, Tony Luck <tony.luck@intel.com>,
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
Subject: Re: [RFC PATCH 06/13] x86/uintr: Introduce uintr receiver syscalls
In-Reply-To: <YUxyZuJoK87OeGlw@kroah.com>
References: <20210913200132.3396598-1-sohil.mehta@intel.com>
 <20210913200132.3396598-7-sohil.mehta@intel.com>
 <YUxyZuJoK87OeGlw@kroah.com>
Date:   Fri, 24 Sep 2021 02:05:51 +0200
Message-ID: <87a6k2g7mo.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 23 2021 at 14:26, Greg KH wrote:
> On Mon, Sep 13, 2021 at 01:01:25PM -0700, Sohil Mehta wrote:
>> +SYSCALL_DEFINE2(uintr_register_handler, u64 __user *, handler, unsigned int, flags)
>> +{
>> +	int ret;
>> +
>> +	if (!uintr_arch_enabled())
>> +		return -EOPNOTSUPP;
>> +
>> +	if (flags)
>> +		return -EINVAL;
>> +
>> +	/* TODO: Validate the handler address */
>> +	if (!handler)
>> +		return -EFAULT;
>
> Um, that's a pretty big "TODO" here.
>
> How are you going to define what is, and what is not, an allowed
> "handler"?

The requirement is obviously that this is a valid user space address,
but that's so hard to validate that it needs to be done later.

At least the documentation claims that a non user space address should
result in a #GP on delivery. Whether that holds in all corner cases (see
the spurious handling muck) is a different question and might come back
to us later through a channel which we hate with a passion :)

> I'm sure the security people would like to get involved here, as well as
> the auditing people.  Have you talked with them about their requirements
> for this type of stuff?

The handler is strictly a user space address and user space is generally
allowed to shoot itself into the foot. If the address is bogus then this
will resolve into inaccessible, not-mapped or not exectuable space and
the application can keep the pieces.

Whether the hardware handles the resulting exception correctly is a
different question, but that can't be prevented by any sanity check on
the address at registration time.

Thanks,

        tglx
