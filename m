Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11D0028EEDA
	for <lists+linux-arch@lfdr.de>; Thu, 15 Oct 2020 10:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388358AbgJOI6G (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 15 Oct 2020 04:58:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:35902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388315AbgJOI6G (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 15 Oct 2020 04:58:06 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 544BC20BED;
        Thu, 15 Oct 2020 08:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602752285;
        bh=r1iinCCdcy2yWWZxUcnTvEcHKoN+v6ic5MXXjcnieUI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yF5dndaxHAxJiVqKekVPJj4nnIzubOXjnKN1J7dLGJ/SHgxS5fppzyIHrctB6tJO8
         3eDXomZzXHnEFCBNc7Xv+rS3jMLbzAfRaH4uN6GNCCiXpdmHaDDsOHLi/OI9J86aQk
         bth54DNQBV4aWrhKOvPyncP7sV4C7+i4N0c3e91A=
Date:   Thu, 15 Oct 2020 09:57:59 +0100
From:   Will Deacon <will@kernel.org>
To:     Peter Collingbourne <pcc@google.com>
Cc:     Dave Martin <Dave.Martin@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arch@vger.kernel.org, libc-alpha@sourceware.org,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v9 29/29] arm64: mte: Add Memory Tagging Extension
 documentation
Message-ID: <20201015085759.GA4790@willie-the-truck>
References: <20200904103029.32083-1-catalin.marinas@arm.com>
 <20200904103029.32083-30-catalin.marinas@arm.com>
 <20200917081107.GA29031@willie-the-truck>
 <20200917090229.GA10662@gaia>
 <20200917161550.GA6642@arm.com>
 <20200918083046.GA30709@willie-the-truck>
 <CAMn1gO76z7eLcuYg_PuWPCq7_N5p29518EGy-FdY9AvyY0fDgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMn1gO76z7eLcuYg_PuWPCq7_N5p29518EGy-FdY9AvyY0fDgw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 14, 2020 at 04:43:23PM -0700, Peter Collingbourne wrote:
> On Fri, Sep 18, 2020 at 1:30 AM Will Deacon <will@kernel.org> wrote:
> > I think so, yes. I'm hoping to queue it for 5.10, once I have an Ack from
> > the Android tools side on the per-thread ABI.
> 
> Our main requirement on the Android side is to provide an API for
> changing the tag checking mode in all threads in a process while
> multiple threads are running. I think we've been able to accomplish
> this [1] by using a libc private real-time signal which is sent to all
> threads. The implementation has been tested on FVP via the included
> unit tests. The code has also been tested on real hardware in a
> multi-threaded app process (of course we don't have MTE-enabled
> hardware, so the implementation was tested on hardware by hacking it
> to disable the tagged address ABI instead of changing the tag checking
> mode, and then verifying via ptrace(PTRACE_GETREGSET) that the tagged
> address ABI was disabled in all threads).
> 
> That being said, as with any code at the nexus of concurrency and
> POSIX signals, the implementation is quite tricky so I would say it
> falls more into the category of "no obvious problems" than "obviously
> no problems". It also relies on changes to the implementations of
> pthread APIs so it wouldn't catch threads created directly via clone()
> rather than via pthread_create(). I think we would be able to ignore
> such threads on Android without causing compatibility issues because
> we can require the process to not create threads via clone() before
> calling the function. I imagine this may not necessarily work for
> other libcs like glibc, though, but as I understand it glibc has no
> plan to offer such an API.
> 
> I feel confident enough in the kernel API though that I think that
> it's reasonable as a starting point at least, and that if a problem
> with the API is discovered I would expect it to be fixable by adding
> new APIs, so:
> 
> Acked-by: Peter Collingbourne <pcc@google.com>

Thanks, Peter. This series has already landed upstream, so I'm unable to
add your Ack now, but the text above is very helpful.

Cheers,

Will

> [1] https://android-review.googlesource.com/c/platform/bionic/+/1427377
