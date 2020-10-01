Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97DE527FFDB
	for <lists+linux-arch@lfdr.de>; Thu,  1 Oct 2020 15:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732139AbgJANRR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 1 Oct 2020 09:17:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:55250 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732018AbgJANRM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 1 Oct 2020 09:17:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0B2A4AF59;
        Thu,  1 Oct 2020 13:17:08 +0000 (UTC)
Date:   Thu, 1 Oct 2020 15:17:07 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Sami Tolvanen <samitolvanen@google.com>
cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org, jthierry@redhat.com, jpoimboe@redhat.com
Subject: Re: [PATCH v4 04/29] objtool: Add a pass for generating
 __mcount_loc
In-Reply-To: <20200929214631.3516445-5-samitolvanen@google.com>
Message-ID: <alpine.LSU.2.21.2010011504340.6689@pobox.suse.cz>
References: <20200929214631.3516445-1-samitolvanen@google.com> <20200929214631.3516445-5-samitolvanen@google.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Sami,

On Tue, 29 Sep 2020, Sami Tolvanen wrote:

> From: Peter Zijlstra <peterz@infradead.org>
> 
> Add the --mcount option for generating __mcount_loc sections
> needed for dynamic ftrace. Using this pass requires the kernel to
> be compiled with -mfentry and CC_USING_NOP_MCOUNT to be defined
> in Makefile.
> 
> Link: https://lore.kernel.org/lkml/20200625200235.GQ4781@hirez.programming.kicks-ass.net/
> Signed-off-by: Peter Zijlstra <peterz@infradead.org>
> [Sami: rebased to mainline, dropped config changes, fixed to actually use
>        --mcount, and wrote a commit message.]
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>

I am sorry to reply on v4. Should have been sooner.

Julien has been sending patches to make objtool's check functionality 
arch-agnostic as much as possible. So it seems to me that the patch should 
be based on the effort

I also wonder about making 'mcount' command separate from 'check'. Similar 
to what is 'orc' now. But that could be done later.

See tip-tree/objtool/core for both.

Thanks
Miroslav
