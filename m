Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 459E0209B45
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jun 2020 10:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390596AbgFYI1N (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 25 Jun 2020 04:27:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:41500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389747AbgFYI1M (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 25 Jun 2020 04:27:12 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC6FB207E8;
        Thu, 25 Jun 2020 08:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593073632;
        bh=GncOVRnsRbmrObVuGed/d33M2KDkzxTcEILATAJbLBA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KLWf/lD9VcylMACtq8p1wJiRL0bWr2kYSku0VKCkfSWkCAqHKhXHxHOSwvWTS7j3l
         w9u9NiMdpF5uccefpWlPwAM4Q9i0V+Qe7aZAsJdNvHebMPPRWYp9leOEenbVEgwE27
         4Y8WoUS9Iu/d8VHbgPuJp11WLopn88ZGoDVDvOts=
Date:   Thu, 25 Jun 2020 09:27:06 +0100
From:   Will Deacon <will@kernel.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH 00/22] add support for Clang LTO
Message-ID: <20200625082706.GA7584@willie-the-truck>
References: <20200624203200.78870-1-samitolvanen@google.com>
 <20200624211540.GS4817@hirez.programming.kicks-ass.net>
 <20200624213014.GB26253@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624213014.GB26253@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jun 24, 2020 at 02:30:14PM -0700, Sami Tolvanen wrote:
> On Wed, Jun 24, 2020 at 11:15:40PM +0200, Peter Zijlstra wrote:
> > On Wed, Jun 24, 2020 at 01:31:38PM -0700, Sami Tolvanen wrote:
> > > This patch series adds support for building x86_64 and arm64 kernels
> > > with Clang's Link Time Optimization (LTO).
> > > 
> > > In addition to performance, the primary motivation for LTO is to allow
> > > Clang's Control-Flow Integrity (CFI) to be used in the kernel. Google's
> > > Pixel devices have shipped with LTO+CFI kernels since 2018.
> > > 
> > > Most of the patches are build system changes for handling LLVM bitcode,
> > > which Clang produces with LTO instead of ELF object files, postponing
> > > ELF processing until a later stage, and ensuring initcall ordering.
> > > 
> > > Note that first objtool patch in the series is already in linux-next,
> > > but as it's needed with LTO, I'm including it also here to make testing
> > > easier.
> > 
> > I'm very sad that yet again, memory ordering isn't addressed. LTO vastly
> > increases the range of the optimizer to wreck things.
> 
> I believe Will has some thoughts about this, and patches, but I'll let
> him talk about it.

Thanks for reminding me! I will get patches out ASAP (I've been avoiding the
rebase from hell, but this is the motivation I need).

Will
