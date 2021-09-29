Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2845741BF89
	for <lists+linux-arch@lfdr.de>; Wed, 29 Sep 2021 09:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244497AbhI2HGi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 29 Sep 2021 03:06:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:54844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244488AbhI2HGh (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 29 Sep 2021 03:06:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8E66F60F6E;
        Wed, 29 Sep 2021 07:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1632899097;
        bh=g6BUe7enuFI4kxDLyFSJFYsLRLSx3gM/vt9+PUIBkDo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FL95RGHa44BF5B5Lw0VjAdsdqvfpo2q0UvdkB+Vinf8wyAX9PChuuIEVvwkwDn+jv
         cHAPhXvSG3PCDo3LllmIRJ4uDW//iCy0QwgbT2R8ZoD95K893CqSr/m+h03pGjNlCX
         whBEcMccL8T1rkHyyqSkCJuZ2+CP5GrdBQhuRgls=
Date:   Wed, 29 Sep 2021 09:04:54 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sohil Mehta <sohil.mehta@intel.com>
Cc:     x86@kernel.org, Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
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
Subject: Re: [RFC PATCH 10/13] x86/uintr: Introduce user IPI sender syscalls
Message-ID: <YVQQFs4HC3tn2GiG@kroah.com>
References: <20210913200132.3396598-1-sohil.mehta@intel.com>
 <20210913200132.3396598-11-sohil.mehta@intel.com>
 <YUxy6XqMB1+DYJtP@kroah.com>
 <4704e81d-a3d2-aedf-1c79-e45cc86826a5@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4704e81d-a3d2-aedf-1c79-e45cc86826a5@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Sep 28, 2021 at 11:01:54AM -0700, Sohil Mehta wrote:
> On 9/23/2021 5:28 AM, Greg KH wrote:
> > On Mon, Sep 13, 2021 at 01:01:29PM -0700, Sohil Mehta wrote:
> > > +/* User Interrupt Target Table Entry (UITTE) */
> > > +struct uintr_uitt_entry {
> > > +	u8	valid;			/* bit 0: valid, bit 1-7: reserved */
> > Do you check that the other bits are set to 0?
> 
> I don't have a check but kzalloc() in alloc_uitt() should set it to 0.
> 
> > > +	u8	user_vec;
> > > +	u8	reserved[6];
> > What is this reserved for?
> 
> This is hardware defined structure as well. I should probably mention this
> it in the comment above.
> 
> > > +	u64	target_upid_addr;
> > If this is a pointer, why not say it is a pointer?
> 
> I used a u64 to get the size and alignment of this structure as required by
> the hardware. I wasn't sure if using a struct upid * would complicate that.
> 
> Also this field is never used as a pointer by the kernel. It is only used to
> program an entry that is read by the hardware.
> 
> Is this reasonable or would you still prefer a pointer?

Ok, just document it really well that this is NOT a real address used by
the kernel.  As it is, that's not obvious at all.

And if this crosses the user/kernel boundry, it needs to be __u64 right?

thanks,

greg k-h
