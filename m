Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFE8F489D77
	for <lists+linux-arch@lfdr.de>; Mon, 10 Jan 2022 17:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237341AbiAJQZX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 Jan 2022 11:25:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237337AbiAJQZW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Jan 2022 11:25:22 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 425CCC06173F;
        Mon, 10 Jan 2022 08:25:22 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n6xTx-0013P7-TU; Mon, 10 Jan 2022 16:25:17 +0000
Date:   Mon, 10 Jan 2022 16:25:17 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH 08/17] ptrace/m68k: Stop open coding ptrace_report_syscall
Message-ID: <Ydxd7b37r6Mmce5l@zeniv-ca.linux.org.uk>
References: <87r19opkx1.fsf_-_@email.froward.int.ebiederm.org>
 <20220103213312.9144-8-ebiederm@xmission.com>
 <CAMuHMdWsNBjOJh0QEx9sppA9x3WoL8H2icqukNqECFhOPremjw@mail.gmail.com>
 <YdxcszwEslyQJSuF@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdxcszwEslyQJSuF@zeniv-ca.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jan 10, 2022 at 04:20:03PM +0000, Al Viro wrote:

> Geert, do you see any problems with that?  The only difference is that
> current->ptrace_message would be set to 1 for ptrace stop on entry and
> 2 - on leave.  Currently m68k just has it 0 all along.
> 
> It is user-visible (the whole point is to let the tracer see which
> stop it is - entry or exit one), so somebody using PTRACE_GETEVENTMSG
> on syscall stops would start seeing 1 or 2 instead of "0 all along".
> That's how it works on all other architectures (including m68k-nommu),
> and I doubt that anything in userland will get broken.
> 
> Behaviour of PTRACE_GETEVENTMSG for other stops (fork, etc.) remains
> as-is, of course.

Actually, the current behaviour is "report what the last PTRACE_GETEVENTMSG
has reported, whatever kind of stop that used to be for".  So I very much
doubt that anything could break there.
