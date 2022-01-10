Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D30E348A0FD
	for <lists+linux-arch@lfdr.de>; Mon, 10 Jan 2022 21:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240010AbiAJUhm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 Jan 2022 15:37:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239773AbiAJUhm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Jan 2022 15:37:42 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151C2C06173F;
        Mon, 10 Jan 2022 12:37:42 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n71Q8-0015hA-DI; Mon, 10 Jan 2022 20:37:36 +0000
Date:   Mon, 10 Jan 2022 20:37:36 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Linux API <linux-api@vger.kernel.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
Subject: Re: [PATCH 08/17] ptrace/m68k: Stop open coding ptrace_report_syscall
Message-ID: <YdyZEAWKVTVnq2ef@zeniv-ca.linux.org.uk>
References: <87r19opkx1.fsf_-_@email.froward.int.ebiederm.org>
 <20220103213312.9144-8-ebiederm@xmission.com>
 <CAMuHMdWsNBjOJh0QEx9sppA9x3WoL8H2icqukNqECFhOPremjw@mail.gmail.com>
 <YdxcszwEslyQJSuF@zeniv-ca.linux.org.uk>
 <CAMuHMdX9nhUQe_jeQCUtXeQgcQ5MBiHpPiRexh86EssoHNtJ3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdX9nhUQe_jeQCUtXeQgcQ5MBiHpPiRexh86EssoHNtJ3Q@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jan 10, 2022 at 06:54:57PM +0100, Geert Uytterhoeven wrote:

> In fact Michael did so in "[PATCH v7 1/2] m68k/kernel - wire up
> syscall_trace_enter/leave for m68k"[1], but that's still stuck...
> 
> [1] https://lore.kernel.org/r/1624924520-17567-2-git-send-email-schmitzmic@gmail.com/

Looks sane, but I'd split it in two - switch to calling syscall_trace_{enter,leave}
and then handling the return values...

The former would keep the current behaviour (modulo reporting enter vs. leave
via PTRACE_GETEVENTMSG), the latter would allow syscall number change by tracer
and/or handling of seccomp/audit/whatnot.

For exit+signal work the former would suffice, and IMO it would be a good idea
to put that one into a shared branch to be pulled both by seccomp and by signal
series.  Would reduce the conflicts...

Objections?
