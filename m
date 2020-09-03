Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A46E625CD38
	for <lists+linux-arch@lfdr.de>; Fri,  4 Sep 2020 00:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728309AbgICWMA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Sep 2020 18:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728037AbgICWL5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Sep 2020 18:11:57 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D5BC061246
        for <linux-arch@vger.kernel.org>; Thu,  3 Sep 2020 15:11:56 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id z19so1279552pfn.8
        for <linux-arch@vger.kernel.org>; Thu, 03 Sep 2020 15:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5FkC7ZydcYZ7OvnDcVYU3cxvw/A+RLXuwzidT1u3ktE=;
        b=IGPy3Ev8EutCuQb4lwsTx1VAvqIeOIRFD7wLuyvXGTSAxwz8hL6v0K8f8IQ9Y+H11S
         fKbqKBL1KVGfL9CLfKWhp972pCQiDMPENIKcZYhRYuBh/NJ5d1xhg8qEzMWhJmjTO78y
         hpDI1nGkw9U2lPKfWpYJ5VKAyDFTBSuj0ip0o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5FkC7ZydcYZ7OvnDcVYU3cxvw/A+RLXuwzidT1u3ktE=;
        b=IY0Sb/1X8RDMsYmsn1TlE2Fpk3BBeqt08QKzjCK4s2GEc9skDIDB+frTzvzni5H4wh
         AxBAoJmF9BGyYd1LsgqceqmZiXPbo0jFEditVDaoIU455vzoTbn7qxrWuxn076F56YYL
         aZeTBwA+xsaPVCgB9KmhWzMtfwQXC9GZFbBLXmBXMnHMEYqjnyuIL6MR4nceghxGjaVe
         EJzolXeEprsrm21z2UOr9KxpeHrDQwe4EDmRt9KLOzLiaVrCgaF/Veh0bsTViI6Piq3A
         v6CQ5IJGiCRmKDOyBJOZU31iXtADABulJKroEmBS0BRSp6J16DCWQz+F5AaIom8SKY63
         YFoA==
X-Gm-Message-State: AOAM531d/SNBHSiPOJdjjHouZotKD1D3DXMMWZVBmLaDarTyrvPW8q5u
        01vhF7+kryMfv+a2KDMp5CJYgg==
X-Google-Smtp-Source: ABdhPJxNUt7QAkJJr6DVIatL2r/ZHjflOqWAAtFiZXIMzyxOBsAVSA+Y4d6vSRQM4txHS5CM9PwpZQ==
X-Received: by 2002:a17:902:d702:: with SMTP id w2mr6057532ply.53.1599171116270;
        Thu, 03 Sep 2020 15:11:56 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a6sm3721602pgt.70.2020.09.03.15.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 15:11:55 -0700 (PDT)
Date:   Thu, 3 Sep 2020 15:11:54 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH v2 10/28] kbuild: lto: fix module versioning
Message-ID: <202009031510.32523E45EC@keescook>
References: <20200624203200.78870-1-samitolvanen@google.com>
 <20200903203053.3411268-1-samitolvanen@google.com>
 <20200903203053.3411268-11-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903203053.3411268-11-samitolvanen@google.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 03, 2020 at 01:30:35PM -0700, Sami Tolvanen wrote:
> With CONFIG_MODVERSIONS, version information is linked into each
> compilation unit that exports symbols. With LTO, we cannot use this
> method as all C code is compiled into LLVM bitcode instead. This
> change collects symbol versions into .symversions files and merges
> them in link-vmlinux.sh where they are all linked into vmlinux.o at
> the same time.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

The only thought I have here is I wonder if this change could be made
universally instead of gating on LTO? (i.e. is it noticeably slower to
do it this way under non-LTO?)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
