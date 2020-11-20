Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA2062BA15E
	for <lists+linux-arch@lfdr.de>; Fri, 20 Nov 2020 05:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbgKTEEj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 19 Nov 2020 23:04:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35541 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726100AbgKTEEi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 19 Nov 2020 23:04:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605845077;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o2KUuc5wwsBwxaFKsqE+AT6g8ZgQDPHa1BC4D1RcHko=;
        b=QAJ7dC+jIYsdyzBghu3FHiqv+OL8V9WfweQXvabDm0BuyD2fUVodeXv9ZSzivR3XgbNV/9
        zHJUJxTdFwFOenytSIrWixG0LeCLX+vakVbyd9H9RKRHaz7jpzN0vIdQ84bnrJGoWlABzE
        7UQhpSn87Kq+F1ruZxfdoTXRYHzCfsc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-230-yDf3VGw1POqCQOhtPJpkwQ-1; Thu, 19 Nov 2020 23:04:33 -0500
X-MC-Unique: yDf3VGw1POqCQOhtPJpkwQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 126894236B;
        Fri, 20 Nov 2020 04:04:31 +0000 (UTC)
Received: from treble (ovpn-119-150.rdu2.redhat.com [10.10.119.150])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 90D3019C47;
        Fri, 20 Nov 2020 04:04:27 +0000 (UTC)
Date:   Thu, 19 Nov 2020 22:04:24 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
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
Message-ID: <20201120040424.a3wctajzft4ufoiw@treble>
References: <20201118220731.925424-1-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201118220731.925424-1-samitolvanen@google.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

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

Sami,

Here are some patches to fix the objtool issues (other than crypto which
I'll work on next).

  https://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git objtool-vmlinux

-- 
Josh

