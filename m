Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93BC528309B
	for <lists+linux-arch@lfdr.de>; Mon,  5 Oct 2020 09:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725880AbgJEHKK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 5 Oct 2020 03:10:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:48016 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725870AbgJEHKJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 5 Oct 2020 03:10:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 600D5AA55;
        Mon,  5 Oct 2020 07:10:08 +0000 (UTC)
Date:   Mon, 5 Oct 2020 09:10:07 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
cc:     Peter Zijlstra <peterz@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org, jthierry@redhat.com
Subject: Re: [PATCH v4 04/29] objtool: Add a pass for generating
 __mcount_loc
In-Reply-To: <20201002141303.hyl72to37wudoi66@treble>
Message-ID: <alpine.LSU.2.21.2010050909510.12678@pobox.suse.cz>
References: <20200929214631.3516445-1-samitolvanen@google.com> <20200929214631.3516445-5-samitolvanen@google.com> <alpine.LSU.2.21.2010011504340.6689@pobox.suse.cz> <20201001133612.GQ2628@hirez.programming.kicks-ass.net>
 <20201002141303.hyl72to37wudoi66@treble>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 2 Oct 2020, Josh Poimboeuf wrote:

> On Thu, Oct 01, 2020 at 03:36:12PM +0200, Peter Zijlstra wrote:
> > On Thu, Oct 01, 2020 at 03:17:07PM +0200, Miroslav Benes wrote:
> > 
> > > I also wonder about making 'mcount' command separate from 'check'. Similar 
> > > to what is 'orc' now. But that could be done later.
> > 
> > I'm not convinced more commands make sense. That only begets us the
> > problem of having to run multiple commands.
> 
> Agreed, it gets hairy when we need to combine things.  I think "orc" as
> a separate subcommand was a mistake.
> 
> We should change to something like
> 
>   objtool run [--check] [--orc] [--mcount]
>   objtool dump [--orc] [--mcount]

Yes, that makes sense.

Miroslav
