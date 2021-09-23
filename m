Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 698B24161BA
	for <lists+linux-arch@lfdr.de>; Thu, 23 Sep 2021 17:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241815AbhIWPJC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Sep 2021 11:09:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:57348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241838AbhIWPJA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 23 Sep 2021 11:09:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AC473610D1;
        Thu, 23 Sep 2021 15:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1632409649;
        bh=US8IJM1epMnlaRX8k7bmkMIXpNy7JU6hUxfHTCGrtsE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1viTjeFbDHNjqqb5AqC6js61riKitWdybX0g+NBdztf2PoRzMoYYLeJyzNSfYz8x/
         KT6g6sLG985JesBuK9ooyaLwz8bx0WSO3Erxz5oLG0dDt1RBBvnvLY8wIghUrZAq2s
         SJem+TVA1n/a8NgHtZA/W/AfcFefNcZDyYddxQo8=
Date:   Thu, 23 Sep 2021 17:07:27 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Mehta, Sohil" <sohil.mehta@intel.com>,
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
Message-ID: <YUyYL9HIfP+rLsLv@kroah.com>
References: <20210913200132.3396598-1-sohil.mehta@intel.com>
 <c08f38db-77da-c50e-23f7-b3a76688deeb@intel.com>
 <BYAPR11MB33203044CD5D7413846655F9E5DA9@BYAPR11MB3320.namprd11.prod.outlook.com>
 <YUxwuR4V+kwk1L34@kroah.com>
 <YUyKqmKR0pOcP/NA@kroah.com>
 <b335f28f-ecb6-525e-c56d-0d8f303ce081@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b335f28f-ecb6-525e-c56d-0d8f303ce081@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 23, 2021 at 07:46:43AM -0700, Dave Hansen wrote:
> I encourage everyone submitting new hardware features to include
> information about where their feature will show up to end users *and* to
> say how widely it will be available.  I'd actually prefer if maintainers
> rejected patches that didn't have this information.

Make sense.  So, what are the answers to these questions for this new
CPU feature?

thanks,

greg k-h
