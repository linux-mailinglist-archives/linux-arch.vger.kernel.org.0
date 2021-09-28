Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C92D341A6A8
	for <lists+linux-arch@lfdr.de>; Tue, 28 Sep 2021 06:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232261AbhI1ElN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Sep 2021 00:41:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:48108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229493AbhI1ElN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 28 Sep 2021 00:41:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4B7A260F70;
        Tue, 28 Sep 2021 04:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1632803974;
        bh=dUEgK5MxvbEsLFF7RzVlp2pNWgbt0LfYqH8ttdtiUxg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ur1kY/97GRyQHz3p0DTxncxGicx/Grmic1p2adGE83PK5TurDwXMgu/8j5byeep1N
         kwj1p6Lii62pfUNu5ySoXdlRrArGLTdbBUpKOkf7IAAj1WrFm5rgU1YUwQ/8ZLgm4N
         +Keu5Z0IFYpheq8rXJCn+T9I9361wpIoiBKS2Sng=
Date:   Tue, 28 Sep 2021 06:39:29 +0200
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
Subject: Re: [RFC PATCH 06/13] x86/uintr: Introduce uintr receiver syscalls
Message-ID: <YVKcgSx8wd2xiW1/@kroah.com>
References: <20210913200132.3396598-1-sohil.mehta@intel.com>
 <20210913200132.3396598-7-sohil.mehta@intel.com>
 <YUxyZuJoK87OeGlw@kroah.com>
 <d3cabce0-922d-b09c-13b6-cafa7023d93f@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3cabce0-922d-b09c-13b6-cafa7023d93f@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Sep 27, 2021 at 04:20:25PM -0700, Sohil Mehta wrote:
> On 9/23/2021 5:26 AM, Greg KH wrote:
> > On Mon, Sep 13, 2021 at 01:01:25PM -0700, Sohil Mehta wrote:
> > > +
> > > +/* User Posted Interrupt Descriptor (UPID) */
> > > +struct uintr_upid {
> > > +	struct {
> > > +		u8 status;	/* bit 0: ON, bit 1: SN, bit 2-7: reserved */
> > > +		u8 reserved1;	/* Reserved */
> > > +		u8 nv;		/* Notification vector */
> > > +		u8 reserved2;	/* Reserved */
> > What are these "reserved" for?
> 
> 
> The UPID is an architectural data structure defined by the hardware. The
> reserved fields are defined by the hardware (likely to keep the structure
> size as 16 bytes).

Then those values must be set to 0, right?  I think I missed the part of
the code that set them, hopefully it's somewhere...

thanks,

greg k-h
