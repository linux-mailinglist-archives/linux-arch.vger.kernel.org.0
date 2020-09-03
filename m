Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1D9225CDC9
	for <lists+linux-arch@lfdr.de>; Fri,  4 Sep 2020 00:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbgICWl4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Sep 2020 18:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729323AbgICWlv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Sep 2020 18:41:51 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B0CC06124F
        for <linux-arch@vger.kernel.org>; Thu,  3 Sep 2020 15:41:50 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id b17so7160pji.1
        for <linux-arch@vger.kernel.org>; Thu, 03 Sep 2020 15:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=t/oG9SCdq1xWr+ov4DXCG17oZgdOZVwWJcpUXXDNoEo=;
        b=GWCaNT3nM4fn50pBeGH+priah+inHtz/+o/HSxcFKJ+9g6L+7lcpaLmH1aFDCEt3sN
         cLNnfv5X6AEYL9NeIlpm/9yK+/MRS6sR6/uRRoPYye7RqP7/TVrQSHnggMT3tq9sR9hF
         zOPK2FA4z7TKMCX63xaseRtM1umBgGDIijy9M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=t/oG9SCdq1xWr+ov4DXCG17oZgdOZVwWJcpUXXDNoEo=;
        b=khvli3c1y4xlGKpclVEbUnshL/hmwt+3NxLO02p6qqtnotgymrANX+uv93mXr7zUvm
         ddEoK2ZvQEwGRJBaAfZAnnB2Fu3PcywN5k9IYMQgO9SRoP1gCa+xWMaZVF/imkBrIYZg
         Nfdmg/05m+lEuvZZm0X6V4cdpHhHZ7RYjWF2DGXy0GDl++ToSEcP4lZwaumRS7r2KbF9
         PcfJ3laGIPYHIh+BwYTOrPt4uTXvd2fyfmBrLCVNXAiiSpdDzGKGpuG8GGehmyvw/lUA
         8SjrtOGODDOop8xkpd5/2qDnvDnIIInB0V/jjx9QQz2qXKmf7SIc2e7L43UtGzL/rp4a
         AcgQ==
X-Gm-Message-State: AOAM532hVA6wlH3cnz17QRvE/RbLn1o6Wj7r6IjY7Pkm1n06mxWwKJQ5
        rQA2tGTwA1RPMvKXCjehmLNeTQ==
X-Google-Smtp-Source: ABdhPJzys++XSMZHn3WsTh+Gbvu5ZeD0Z5uwNitWJ8c9N8vmC+r+J+StAFQG3dzO4Nx2TrB3bIJMrw==
X-Received: by 2002:a17:90a:f298:: with SMTP id fs24mr5478610pjb.4.1599172910026;
        Thu, 03 Sep 2020 15:41:50 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i24sm3641252pfq.38.2020.09.03.15.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 15:41:48 -0700 (PDT)
Date:   Thu, 3 Sep 2020 15:41:47 -0700
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
Subject: Re: [PATCH v2 16/28] init: lto: fix PREL32 relocations
Message-ID: <202009031541.40B54A2E51@keescook>
References: <20200624203200.78870-1-samitolvanen@google.com>
 <20200903203053.3411268-1-samitolvanen@google.com>
 <20200903203053.3411268-17-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903203053.3411268-17-samitolvanen@google.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 03, 2020 at 01:30:41PM -0700, 'Sami Tolvanen' via Clang Built Linux wrote:
> With LTO, the compiler can rename static functions to avoid global
> naming collisions. As initcall functions are typically static,
> renaming can break references to them in inline assembly. This
> change adds a global stub with a stable name for each initcall to
> fix the issue when PREL32 relocations are used.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

This was a Delight(tm) to get right. Thanks for finding the right magic
here. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
