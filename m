Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40DA125CCCE
	for <lists+linux-arch@lfdr.de>; Thu,  3 Sep 2020 23:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728826AbgICVwj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Sep 2020 17:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728134AbgICVwh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Sep 2020 17:52:37 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 525C2C061245
        for <linux-arch@vger.kernel.org>; Thu,  3 Sep 2020 14:52:37 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id n3so4273140pjq.1
        for <linux-arch@vger.kernel.org>; Thu, 03 Sep 2020 14:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=niBSeaSbgvRvlB35MBxx98Nw+20RftQpbuI5pjBM80I=;
        b=KicJSqu+xVTyfixy3duLdJz55bxWRU3qA5qutCjSiukroOXIqFG0/1lD3QJeDVIqMC
         hZ6NZa7w9Qs1p1rJ4Alr8OVZgM7Zw7wnpZVEMqp9fetWV7i08ZFQCV9dvLbQsymap8Sa
         WEtcBNRNrgLCnUJf91oNzu8Xfg8xBZ6/pJAwg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=niBSeaSbgvRvlB35MBxx98Nw+20RftQpbuI5pjBM80I=;
        b=Q228AFqhfvXvBWU2nUNOf7ccYO98FU5t05mm6NzQ5yXLbcA+6+vH9Sla9k8Iq7prfH
         /4nrJKzHTLXa0FM7ifBljkqK+eGpte38cImnOp3wAIOxbpS+Z3yHk0aIEQys8yMiTFfR
         Iz2srJXrPyZbBbqTiGde1iuf/nf1KJf0u+06XWhM2gF7s7BeOgB3hHTmVo3f9MzqvdOl
         wzGQzXceoIXuLzBwxr5nc9qG79KsBi2yHG/xrmONVjdrfGYiwsSuxWmmG+KnmVB+11OD
         heVNtKd+8XMFQO/IfcIL1TL6Q0yTb/Y43xA5sydug3dqIXYkCPeiXKrf4hdXkMlI/HMa
         rpbA==
X-Gm-Message-State: AOAM530MlDcSP3DN8KTrgWEAQb4T0GpgY2i69+hvvctwM5O6DKLKrXY+
        NTJnq6Z7y9SBljbq9t5smKw4hw==
X-Google-Smtp-Source: ABdhPJwa48YSM6ExHujIeVMJjTdMKXdlCG8evKNumN+cGLnV5tqHACBkFFTWQTDxLZ9gej+518XXtg==
X-Received: by 2002:a17:90a:f198:: with SMTP id bv24mr5394608pjb.117.1599169956918;
        Thu, 03 Sep 2020 14:52:36 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 31sm3746762pgo.17.2020.09.03.14.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 14:52:36 -0700 (PDT)
Date:   Thu, 3 Sep 2020 14:52:35 -0700
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
Subject: Re: [PATCH v2 06/28] objtool: Don't autodetect vmlinux.o
Message-ID: <202009031452.FD826A9748@keescook>
References: <20200624203200.78870-1-samitolvanen@google.com>
 <20200903203053.3411268-1-samitolvanen@google.com>
 <20200903203053.3411268-7-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903203053.3411268-7-samitolvanen@google.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 03, 2020 at 01:30:31PM -0700, Sami Tolvanen wrote:
> With LTO, we run objtool on vmlinux.o, but don't want noinstr
> validation. This change requires --vmlinux to be passed to objtool
> explicitly.
> 
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Looks right to me.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
