Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4445D2C83B4
	for <lists+linux-arch@lfdr.de>; Mon, 30 Nov 2020 13:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728538AbgK3MCS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 30 Nov 2020 07:02:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:35772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727656AbgK3MCS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 30 Nov 2020 07:02:18 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89B91206CB;
        Mon, 30 Nov 2020 12:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606737697;
        bh=A/tQpaRCdVBxIrK5CVrihAXJGL1D0YMcA4iympcoTzk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EwVQLNwsXH/bdnWP/eU1At5WBpjCSdAR6JTRNITU+0kyAYmyC7vfvCGB5aglCFG6x
         MgF+azWjp5V9E9RCzfCIxmq6AyuSMIhVSOBmKKJ8jGetiIbmZ9+phj0IYAntF8L2n+
         Jz+cOfBAzUsJpOu6/EZ4Jj48GG8LJpvvDpy7mI9s=
Date:   Mon, 30 Nov 2020 12:01:31 +0000
From:   Will Deacon <will@kernel.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v7 00/17] Add support for Clang LTO
Message-ID: <20201130120130.GF24563@willie-the-truck>
References: <20201118220731.925424-1-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201118220731.925424-1-samitolvanen@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Sami,

On Wed, Nov 18, 2020 at 02:07:14PM -0800, Sami Tolvanen wrote:
> This patch series adds support for building the kernel with Clang's
> Link Time Optimization (LTO). In addition to performance, the primary
> motivation for LTO is to allow Clang's Control-Flow Integrity (CFI) to
> be used in the kernel. Google has shipped millions of Pixel devices
> running three major kernel versions with LTO+CFI since 2018.
> 
> Most of the patches are build system changes for handling LLVM bitcode,
> which Clang produces with LTO instead of ELF object files, postponing
> ELF processing until a later stage, and ensuring initcall ordering.
> 
> Note that v7 brings back arm64 support as Will has now staged the
> prerequisite memory ordering patches [1], and drops x86_64 while we work
> on fixing the remaining objtool warnings [2].

Sounds like you're going to post a v8, but that's the plan for merging
that? The arm64 parts look pretty good to me now.

Will
