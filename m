Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7F62F00DE
	for <lists+linux-arch@lfdr.de>; Sat,  9 Jan 2021 16:38:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbhAIPiY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 9 Jan 2021 10:38:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43079 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726059AbhAIPiX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 9 Jan 2021 10:38:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610206616;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a2MU/nqWLE/JGSkdP0kIS5IkD9QMgYVvccKJFswQ5ZI=;
        b=O3mKq/U3ja65onGl2qsSERaBL0sPq1Co7hkbiDLwJBRtqa6a+MhnuY5GqA0c2ZhSaUyCFB
        Q34hDgrsVr9RAAyAD+yI8lzEnsCp/L3wxzwpPWFw8JBVZv9mjjua09s9R7hm1QkQBXyXxX
        jmN6EdUpIRhbEaU7hD86qSR1D9XQkeg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-426-VeFGfpw6MSCN1ixeCjF0BQ-1; Sat, 09 Jan 2021 10:36:53 -0500
X-MC-Unique: VeFGfpw6MSCN1ixeCjF0BQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 771588015C3;
        Sat,  9 Jan 2021 15:36:50 +0000 (UTC)
Received: from treble (ovpn-120-156.rdu2.redhat.com [10.10.120.156])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 379F75D9C2;
        Sat,  9 Jan 2021 15:36:48 +0000 (UTC)
Date:   Sat, 9 Jan 2021 09:36:46 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v9 00/16] Add support for Clang LTO
Message-ID: <20210109153646.zrmglpvr27f5zd7m@treble>
References: <20201211184633.3213045-1-samitolvanen@google.com>
 <CA+icZUWYxO1hHW-_vrJid7EstqQRYQphjO3Xn6pj6qfEYEONbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+icZUWYxO1hHW-_vrJid7EstqQRYQphjO3Xn6pj6qfEYEONbA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Jan 09, 2021 at 03:54:20PM +0100, Sedat Dilek wrote:
> I am interested in having Clang LTO (Clang-CFI) for x86-64 working and
> help with testing.
> 
> I tried the Git tree mentioned in [3] <jpoimboe.git#objtool-vmlinux>
> (together with changes from <peterz.git#x86/urgent>).
> 
> I only see in my build-log...
> 
> drivers/gpu/drm/i915/gem/i915_gem_execbuffer.o: warning: objtool:
> eb_relocate_parse_slow()+0x3d0: stack state mismatch: cfa1=7+120
> cfa2=-1+0
> drivers/gpu/drm/i915/gem/i915_gem_execbuffer.o: warning: objtool:
> eb_copy_relocations()+0x229: stack state mismatch: cfa1=7+120
> cfa2=-1+0
> 
> ...which was reported and worked on in [1].
> 
> This is with Clang-IAS version 11.0.1.
> 
> Unfortunately, the recent changes in <samitolvanen.github#clang-cfi>
> do not cleanly apply with Josh stuff.
> My intention/wish was to report this combination of patchsets "heals"
> a lot of objtool-warnings for vmlinux.o I observed with Clang-CFI.
> 
> Is it possible to have a Git branch where Josh's objtool-vmlinux is
> working together with Clang-LTO?
> For testing purposes.

I updated my branch with my most recent work from before the holidays,
can you try it now?  It still doesn't fix any of the crypto warnings,
but I'll do that in a separate set after posting these next week.

-- 
Josh

