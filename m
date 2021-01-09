Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 786CD2F020B
	for <lists+linux-arch@lfdr.de>; Sat,  9 Jan 2021 18:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbhAIRHf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 9 Jan 2021 12:07:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28840 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726090AbhAIRHe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 9 Jan 2021 12:07:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610211968;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=joUlfz99h/FvbQhyQ1sXKa4tTuoivxwQKiFtAkkLoGE=;
        b=S4/Yeg+xUxWPxccd5/Zr1OD0OeoJeEml8KhPTKNp5Gh059lluMNWm3fe/B3MT9XqIHoh4G
        QBOpX5mMFJtKAR1DV1/uoxXbn/71iqjzUSV5EDKMBLb16QKHlH33ebDudLROqAJI0qtIm/
        xd3YbCyDVfRdGhg1gCvlefWyW+8xxRY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-254-s4qYlsTrNKOXjyTgnesYQQ-1; Sat, 09 Jan 2021 12:06:04 -0500
X-MC-Unique: s4qYlsTrNKOXjyTgnesYQQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 56322180A093;
        Sat,  9 Jan 2021 17:06:02 +0000 (UTC)
Received: from treble (ovpn-120-156.rdu2.redhat.com [10.10.120.156])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 96EEA19C45;
        Sat,  9 Jan 2021 17:06:00 +0000 (UTC)
Date:   Sat, 9 Jan 2021 11:05:58 -0600
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
Message-ID: <20210109170558.meufvgwrjtqo5v3i@treble>
References: <20201211184633.3213045-1-samitolvanen@google.com>
 <CA+icZUWYxO1hHW-_vrJid7EstqQRYQphjO3Xn6pj6qfEYEONbA@mail.gmail.com>
 <20210109153646.zrmglpvr27f5zd7m@treble>
 <CA+icZUUiucbsQZtJKYdD7Y7Cq8hJZdBwsF0U0BFbaBtnLY3Nsw@mail.gmail.com>
 <20210109160709.kqqpf64klflajarl@treble>
 <CA+icZUU=sS2xfzo9qTUTPQ0prbbQcj29tpDt1qK5cYZxarXuxg@mail.gmail.com>
 <20210109163256.3sv3wbgrshbj72ik@treble>
 <CA+icZUUszOHkJ8Acx2mDowg3StZw9EureDQ7YYkJkcAnpLBA+g@mail.gmail.com>
 <20210109170353.litivfvc4zotnimv@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210109170353.litivfvc4zotnimv@treble>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Jan 09, 2021 at 11:03:57AM -0600, Josh Poimboeuf wrote:
> On Sat, Jan 09, 2021 at 05:45:47PM +0100, Sedat Dilek wrote:
> > I tried merging with clang-cfi Git which is based on Linux v5.11-rc2+
> > with a lot of merge conflicts.
> > 
> > Did you try on top of cfi-10 Git tag which is based on Linux v5.10?
> > 
> > Whatever you successfully did... Can you give me a step-by-step instruction?
> 
> Oops, my bad.  My last three commits (which I just added) do conflict.
> Sorry for the confusion.
> 
> Just drop my last three commits:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git objtool-vmlinux
> git checkout -B tmp FETCH_HEAD
> git reset --hard HEAD~~~
> git fetch https://github.com/samitolvanen/linux clang-lto
> git rebase --onto FETCH_HEAD 79881bfc57be

Last one should be:

git rebase --onto FETCH_HEAD 2c85ebc57b3e

-- 
Josh

