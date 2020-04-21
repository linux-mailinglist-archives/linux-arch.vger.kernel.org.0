Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FDC31B1D29
	for <lists+linux-arch@lfdr.de>; Tue, 21 Apr 2020 06:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726019AbgDUEDe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Apr 2020 00:03:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:49646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725283AbgDUEDe (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 21 Apr 2020 00:03:34 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 346EA206CD;
        Tue, 21 Apr 2020 04:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587441813;
        bh=RgxAeo6o21slOdeo/oi5CMpvkiC62LoMPO2UXH4ytCg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FGLJJlZ/+pwYtllfiyvbICis0kR+XtiFWxk8jd4DCCrB0AVKN6G0EEvo0s3IyG5hJ
         OoLitET1styvnih6JBJnLm+5ftxRowAsgfZvhK8SXw2ENrQaH21ENEYQD76wP6mpJ6
         QBWhmiL/3DUF0iZsaw1bADGS4Kt+owXLiEWtycFA=
Date:   Mon, 20 Apr 2020 21:03:32 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH 0/6] Silence some instances of -Wtautological-compare
 and enable globally
Message-Id: <20200420210332.7ff9652c8bdca7fb91ccfb0c@linux-foundation.org>
In-Reply-To: <20200219045423.54190-1-natechancellor@gmail.com>
References: <20200219045423.54190-1-natechancellor@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 18 Feb 2020 21:54:17 -0700 Nathan Chancellor <natechancellor@gmail.com> wrote:

> Hi everyone,
> 
> This patch series aims to silence some instances of clang's
> -Wtautological-compare that are not problematic and enable it globally
> for the kernel because it has a bunch of subwarnings that can find real
> bugs in the kernel such as
> https://lore.kernel.org/lkml/20200116222658.5285-1-natechancellor@gmail.com/
> and https://bugs.llvm.org/show_bug.cgi?id=42666, which was specifically
> requested by Dmitry.
> 
> The first patch adds a macro that casts the section variables to
> unsigned long (uintptr_t), which silences the warning and adds
> documentation.
> 
> Patches two through four silence the warning in the places I have
> noticed it across all of my builds with -Werror, including arm, arm64,
> and x86_64 defconfig/allmodconfig/allyesconfig. There might still be
> more lurking but those will have to be teased out over time.
> 
> Patch six finally enables the warning, while leaving one of the
> subwarnings disabled because it is rather noisy and somewhat pointless
> for the kernel, where core kernel code is expected to build and run with
> many different configurations where variable types can be different
> sizes.
> 

For some reason none of these patches apply.  Not sure why - prehaps
something in the diff headers.

Anyway, the kmemleak.c code has recently changed in ways which impact
these patches.  Please take a look at that, redo, retest and resend?


