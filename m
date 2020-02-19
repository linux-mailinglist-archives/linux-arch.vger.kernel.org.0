Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1F04164E7E
	for <lists+linux-arch@lfdr.de>; Wed, 19 Feb 2020 20:09:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgBSTJb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Feb 2020 14:09:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:42530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726609AbgBSTJa (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 19 Feb 2020 14:09:30 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5692208C4;
        Wed, 19 Feb 2020 19:09:28 +0000 (UTC)
Date:   Wed, 19 Feb 2020 14:09:27 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH 3/6] tracing: Wrap section comparison in
 tracer_alloc_buffers with COMPARE_SECTIONS
Message-ID: <20200219140927.396ca577@gandalf.local.home>
In-Reply-To: <20200219181619.GV31668@ziepe.ca>
References: <20200219045423.54190-1-natechancellor@gmail.com>
        <20200219045423.54190-4-natechancellor@gmail.com>
        <20200219093445.386f1c09@gandalf.local.home>
        <CAKwvOdm-N1iX0SMxGDV5Vf=qS5uHPdH3S-TRs-065BuSOdKt1w@mail.gmail.com>
        <20200219181619.GV31668@ziepe.ca>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 19 Feb 2020 14:16:19 -0400
Jason Gunthorpe <jgg@ziepe.ca> wrote:

> > kernel/trace/trace.h
> > 1923:extern const char *__stop___trace_bprintk_fmt[];  
> 
> Godbolt says clang is happy if it is written as:
> 
>   if (&__stop___trace_bprintk_fmt[0] != &__start___trace_bprintk_fmt[0])
> 
> Which is probably the best compromise. The type here is const char
> *[], so it would be a shame to see it go.

If the above works, I'd be happy with that. As it is still readable.

-- Steve
