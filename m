Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A84C5146F5B
	for <lists+linux-arch@lfdr.de>; Thu, 23 Jan 2020 18:16:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729186AbgAWRQr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Jan 2020 12:16:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:37780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728731AbgAWRQr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 23 Jan 2020 12:16:47 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7DE120704;
        Thu, 23 Jan 2020 17:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579799807;
        bh=caBzUH87lp4Mnc407nS8xaDKbecRpmkU11Lh6D8ZhtQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zNRh2GsCZfIoZh4vccc1qvE+NoVJ8wQSpBQfnqOa4+8OlwkJZhKclmRqaog119FBv
         zLMeEWjpgKczZUNmIUDzTwfDe/ri/qOipH9vsM2UbV9eePmZWHfMv96M0DIWJUrJdZ
         eG9Bx4uNv7OmEajDz04SIDsYG/YS0LdLdevWoarI=
Date:   Thu, 23 Jan 2020 17:16:41 +0000
From:   Will Deacon <will@kernel.org>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kernel-team@android.com" <kernel-team@android.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v2 00/10] Rework READ_ONCE() to improve codegen
Message-ID: <20200123171641.GC20126@willie-the-truck>
References: <20200123153341.19947-1-will@kernel.org>
 <26ad7a8a975c4e06b44a3184d7c86e5f@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26ad7a8a975c4e06b44a3184d7c86e5f@AcuMS.aculab.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jan 23, 2020 at 05:07:40PM +0000, David Laight wrote:
> From: Will Deacon
> > Sent: 23 January 2020 15:34
> ...
> >   * Only warn once at build-time if GCC prior to 4.8 is detected...
> > 
> >   * ... and then raise the minimum GCC version to 4.8, with an error for
> >     older versions of the compiler
> 
> If the kernel compiled with gcc 4.7 is likely to be buggy, don't these
> need to be in the other order?
> 
> Otherwise you need to keep the old versions for use with the old
> compilers.

I think it depends how much we care about those older compilers. My series
first moves it to "Good luck mate, you're on your own" and then follows up
with a "Let me take that off you it's sharp".

Will
