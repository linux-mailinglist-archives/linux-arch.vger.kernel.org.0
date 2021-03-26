Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D233F34A096
	for <lists+linux-arch@lfdr.de>; Fri, 26 Mar 2021 05:35:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbhCZEfL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 26 Mar 2021 00:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbhCZEe4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 26 Mar 2021 00:34:56 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD6C9C0613DF
        for <linux-arch@vger.kernel.org>; Thu, 25 Mar 2021 21:34:55 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id v10so3753142pgs.12
        for <linux-arch@vger.kernel.org>; Thu, 25 Mar 2021 21:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZznyDRg62Aq1s1+p2944fwJCGEKWMFo0KzijBRVLdmY=;
        b=TIB4PsMHJfphVL92/msg3G5qMO4sc9Q0j+qrJPLXwTDkmFfcf0Ausc1NmOjXDUFjD1
         GDkWCYMA3bUeziVVqzGGizG/fAmUwj8oXAFn38jaiwedU+5KjkHu1IQGatlAG01m56gy
         zq5vsbOryhA4183WK8CwjCtKavIwW9tgiaU9w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZznyDRg62Aq1s1+p2944fwJCGEKWMFo0KzijBRVLdmY=;
        b=YJcOXbA+15Zju+HMAa1EZplACEjV+ziBwQ9dHpSC9z6t/UJJzWqPi3ocWmiqqAVipl
         DJ46FyBXbAJnaZrfk26Msiuql0VQLWCMe1ll30OeTK0KZ9W+70ktTe6oR9aG4sOKaUOp
         tlFS4uDUCjPKEUGlRs82+PpDXPDn1iOLUks5TsDxSg0Dr/0/jvd7OZSLhD1J4NJXdXwW
         ucy4CB8zwla9ZxQc6WWadLXi9c9GjLBdEQhj6M0g7kGAr4q2BUGvy2E0k8xp3t/bV5lj
         lVMoGbgGQnnRVUHXxyYH6oOTXT+MkjafUBEAfdUrYFCCWdLUco8RiUK4YvJj7TWlLrmJ
         QosA==
X-Gm-Message-State: AOAM530dpQKmsRVE5QoU4qRTLXznPdcW/EvLK5Rr7I9ViVGYbebPZQbG
        84DDRpN8RInEdBXOLpflzJjxDw==
X-Google-Smtp-Source: ABdhPJxBRCXJ1li4dH5xsPQG84q9505VJQO+4Hhbb6bLG6ZNByyMdRrV56Yf27GEeoRpH/Z6b/yttg==
X-Received: by 2002:aa7:8e8f:0:b029:1f1:5a1a:7f82 with SMTP id a15-20020aa78e8f0000b02901f15a1a7f82mr11057824pfr.52.1616733295456;
        Thu, 25 Mar 2021 21:34:55 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w191sm8543354pfd.25.2021.03.25.21.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 21:34:54 -0700 (PDT)
Date:   Thu, 25 Mar 2021 21:34:54 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>, bpf@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 05/17] workqueue: use WARN_ON_FUNCTION_MISMATCH
Message-ID: <202103252134.03274C44@keescook>
References: <20210323203946.2159693-1-samitolvanen@google.com>
 <20210323203946.2159693-6-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210323203946.2159693-6-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Mar 23, 2021 at 01:39:34PM -0700, Sami Tolvanen wrote:
> With CONFIG_CFI_CLANG, a callback function passed to
> __queue_delayed_work from a module points to a jump table entry
> defined in the module instead of the one used in the core kernel,
> which breaks function address equality in this check:
> 
>   WARN_ON_ONCE(timer->function != delayed_work_timer_fn);
> 
> Use WARN_ON_FUNCTION_MISMATCH() instead to disable the warning
> when CFI and modules are both enabled.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
