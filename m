Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 419DB25CCE5
	for <lists+linux-arch@lfdr.de>; Thu,  3 Sep 2020 23:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729415AbgICV4N (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Sep 2020 17:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727804AbgICV4L (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Sep 2020 17:56:11 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54CCCC061244
        for <linux-arch@vger.kernel.org>; Thu,  3 Sep 2020 14:56:11 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id c142so3417407pfb.7
        for <linux-arch@vger.kernel.org>; Thu, 03 Sep 2020 14:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+qkcq0KaVk7HSQBAkByrnKJ1sZBfvqUX0j4GLf7P4Ho=;
        b=Seros2DTlS5cvJrc6eXGVeiAHZSqw0rR2qykzMdKQEtfa4XdwNdSID5ZkvediVM9AJ
         O7omW08AaLWNFuSJ2HD93Wkv2v202rCTP6thwQMutIbbVLf7kd+B9GMFYWvsh9yIgl4o
         wj2jIiZYQWQu0rnmAlwzd4ky0DUpgiwfDRBxE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+qkcq0KaVk7HSQBAkByrnKJ1sZBfvqUX0j4GLf7P4Ho=;
        b=UDNA+AN2rNeZ9N5WM66BVk+Ye2pEVXGObiYhn+emLJ613Y6dt5WiEzi0ONqeQc39cg
         wu3TGphyNNaPyC5kDu1Ys407rHno5D9LHNQq5WDh+IjAU3B5DybVBIRtwdBTTkn6nEJm
         xEvbv+MgfgteOuQTuFESRJsTholu2u2HNi42u7CsVXhbSO+0dSUQ9cuojf5RTS0aZ7dt
         AMF8aSsA08r0hs96RBW46yMdKpzLIZIldemWKVrxRvukExh9E6gn3BsymQIlLMAbZ4vo
         e5X0ruxD6a3vNX5YrMARXSPp3z+T59HCRsLD6RS64E+hGzmTv+l7Q1SnIDvoovShwqkK
         rL7w==
X-Gm-Message-State: AOAM530FD0bZT+w1gm5llL6ax27vGx2OVDfjycXcC/htQfBpUzMPtsIv
        5l7r7BNTpdPh83dRNqofFUlTkw==
X-Google-Smtp-Source: ABdhPJyOa4sKb29bYinReMEHv5PsZTZST1EHUNe/55RA0OQy4wRKFNRcU2420Azk0bfn+Y9cX+tWeg==
X-Received: by 2002:a62:fccf:: with SMTP id e198mr5659849pfh.183.1599170170933;
        Thu, 03 Sep 2020 14:56:10 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r3sm4349799pfh.88.2020.09.03.14.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 14:56:10 -0700 (PDT)
Date:   Thu, 3 Sep 2020 14:56:09 -0700
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
Subject: Re: [PATCH v2 07/28] kbuild: add support for objtool mcount
Message-ID: <202009031455.A305DD4F97@keescook>
References: <20200624203200.78870-1-samitolvanen@google.com>
 <20200903203053.3411268-1-samitolvanen@google.com>
 <20200903203053.3411268-8-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903203053.3411268-8-samitolvanen@google.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 03, 2020 at 01:30:32PM -0700, 'Sami Tolvanen' via Clang Built Linux wrote:
> This change adds build support for using objtool to generate
> __mcount_loc sections.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Looks right to me. (There is probably an argument to be made to do all
of the tooling detection in the Kconfig, but that's a larger issues and
orthogonal to this fix, IMO.)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
