Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFC67289A03
	for <lists+linux-arch@lfdr.de>; Fri,  9 Oct 2020 22:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390940AbgJIUut (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 9 Oct 2020 16:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390883AbgJIUus (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 9 Oct 2020 16:50:48 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE8DC0613D2
        for <linux-arch@vger.kernel.org>; Fri,  9 Oct 2020 13:50:48 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id x13so5231431pfa.9
        for <linux-arch@vger.kernel.org>; Fri, 09 Oct 2020 13:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wTcVu4oETJELTBTO9Qx9E6QynJ2qRr0RMhI6Lss/kRo=;
        b=KqYQl09nzQc++fy4ixa3glsFIZci442nzrDG0fcwmUtpLC5GdJDecIntJaTr9BnU+k
         mHQV/FbLDSsp3LtFLsRl7T/zeVjv8Twr5lMP3mtNmGjMAycuhVQeNy6SxCfwNFW224a7
         0aTYXNZMa+jC7UhkQneYNe71rwlQlYDitPklTa97BhEb1m7+mN8rfc5c/j9aVJULK1tK
         kXqyUbQ8e7mPIF4Q1d2YHCkekuQkecmqoGoo0ONdt2lmrDHm6ydQldiw4prAm7vbUqOP
         n+GwBtayqaO7D2OKGp8MP+pmirMixqou37jYYe5EkC/YvLWRQkL0zC9bekBaZ8qVYuhi
         m9ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wTcVu4oETJELTBTO9Qx9E6QynJ2qRr0RMhI6Lss/kRo=;
        b=UNglNySyR/cTbNOrn54Fvb1wRw6ZMC2oCD8q07EgPTf3ZlhmylgKLRQMnOFnzAgt7D
         YpMGGGchGiLTPf0YMfArM5TGW47AGKYtGzpAnhLCWwZVH1kgbwcj14BA6PmX6lTs2S4S
         sAnUMGfVGfOJC5UzM2+/nXMzQ/51mZGHzxsFXxuQHh6b916s1nZZFMkWvha21D9Ws07U
         rQidcwL4ImyqdPlZ+S/htuLdZCZR/DIZYKPDGQkktiIjm1k3h+N9KO/cd03/YPwkkxWJ
         racRST3wJrQXAFT+2L5yG8zVIjsj7XEuu4Ttf9PovjPyGwkzrp37JSUug4d+NG8AYDX1
         fv6Q==
X-Gm-Message-State: AOAM530JGFilDQANaR4u3LsrmuBsCU50QOEghqbOuSMVbC/Hml0Al5gF
        UuQDcVFnXCMe2ITr+ilPnK7Sbw==
X-Google-Smtp-Source: ABdhPJxVwMwto7ILPuyT8ZZD/+7fv8lOOoXOE+RyXcVgFRqpvoLioQmgYU/5kPeWbujatJFVPXtviQ==
X-Received: by 2002:a17:90b:19c9:: with SMTP id nm9mr6551747pjb.6.1602276647984;
        Fri, 09 Oct 2020 13:50:47 -0700 (PDT)
Received: from google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
        by smtp.gmail.com with ESMTPSA id n4sm10981225pgv.89.2020.10.09.13.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 13:50:47 -0700 (PDT)
Date:   Fri, 9 Oct 2020 13:50:41 -0700
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH v5 00/29] Add support for Clang LTO
Message-ID: <20201009205041.GA1448445@google.com>
References: <20201009161338.657380-1-samitolvanen@google.com>
 <CA+icZUVWdRWfhPhPy79Hpjmqbfw+n8xsgMKv_RU+hoh1bphXdg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+icZUVWdRWfhPhPy79Hpjmqbfw+n8xsgMKv_RU+hoh1bphXdg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Oct 09, 2020 at 06:30:24PM +0200, Sedat Dilek wrote:
> Will clang-cfi be based on this, too?

At least until the prerequisite patches are merged into mainline. In the
meanwhile, I have a CFI tree based on this series here:

  https://github.com/samitolvanen/linux/tree/tip/clang-lto

Sami
