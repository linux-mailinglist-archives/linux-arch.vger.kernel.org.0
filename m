Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9045B1B39E5
	for <lists+linux-arch@lfdr.de>; Wed, 22 Apr 2020 10:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbgDVISp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Apr 2020 04:18:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:41774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725811AbgDVISp (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 22 Apr 2020 04:18:45 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6FF6520663;
        Wed, 22 Apr 2020 08:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587543524;
        bh=qKTrX6IeQOH1sN4dcsG+sIFtqX60IcAtKde3714EdwE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SaFBd0qQpVm6Jz+PKjXp3tXRmYe3vNQMbpxXwl94dli2KhSzDDIWFkb2yiwF+Pcif
         gXDFjAp5nat471/4iBV5/Ji5nHJOabF8YlLAEgeMzkkdf5mLTFf5mWiwWLwAWGou3o
         VM0U3QCNmoHn9DZ3+DLlysj7QbFJf/Tdy9vW2Pg0=
Date:   Wed, 22 Apr 2020 09:18:39 +0100
From:   Will Deacon <will@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v4 00/11] Rework READ_ONCE() to improve codegen
Message-ID: <20200422081838.GA29541@willie-the-truck>
References: <20200421151537.19241-1-will@kernel.org>
 <CAHk-=wjjz927czq5zKkV1TUvajbWZGsPeFBSgnQftLNWmCcoSg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjjz927czq5zKkV1TUvajbWZGsPeFBSgnQftLNWmCcoSg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Apr 21, 2020 at 11:42:56AM -0700, Linus Torvalds wrote:
> On Tue, Apr 21, 2020 at 8:15 AM Will Deacon <will@kernel.org> wrote:
> >
> > It's me again. This is version four of the READ_ONCE() codegen improvement
> > patches [...]
> 
> Let's just plan on biting the bullet and do this for 5.8. I'm assuming
> that I'll juet get a pull request from you?

Sure thing, thanks. I'll get it into -next along with the arm64 bits for
5.8, but I'll send it as a separate pull when the time comes. I'll also
include the sparc32 changes because otherwise the build falls apart and
we'll get an army of angry robots yelling at us (they seem to form the
majority of the active sparc32 user base afaict).

> > (I'm interpreting the silence as monumental joy)
> 
> By now I think we can take that for granted.
> 
> Because "monumental joy" is certainly exactly what I felt re-reading
> that "unqualified scalar type" macro.
> 
> Or maybe it was just my breakfast trying to say "Hi!".

Haha! It's definitely best viewed on an empty stomach, but the comment
does give you ample warning.

Will
