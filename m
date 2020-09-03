Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF1525CD64
	for <lists+linux-arch@lfdr.de>; Fri,  4 Sep 2020 00:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728309AbgICWU3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Sep 2020 18:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728678AbgICWUT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Sep 2020 18:20:19 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B44C061246
        for <linux-arch@vger.kernel.org>; Thu,  3 Sep 2020 15:20:17 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id v15so3230267pgh.6
        for <linux-arch@vger.kernel.org>; Thu, 03 Sep 2020 15:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dmzINT6p66dX/e1LULkP+IK8q8rhLoHpFzoaZ62doLA=;
        b=R+gBqR6jMnk+6oKx2tqu8pEQMa6B4rvdU39xncVxP9cYGjTvu9Y7E6/eDwL4d91aZg
         2AWd6bD1I8hpzfCMHWXyOEAUYG/ByrfmTjLvqStAtIQAudEBj+5PL2eVmUhWK1C7kkkn
         PbOlpfhNaxLGq78/VBxGKRETiCVBKzIIjWBQY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dmzINT6p66dX/e1LULkP+IK8q8rhLoHpFzoaZ62doLA=;
        b=H42Q3jjz/2Z65Aw639rpHkYgg9tFiBxNneAXOG82LoyyBANiZG6C+Yl+h3VDXbfvUp
         tytY1+YubSsgZHhXyHztLfdNTK39rVJm+F268ZFtXpKBuP2+4tB9k7PFsU8IUt964jwy
         hIhW0eEN0+qnnpqJ27e5YrBs2t6DKvlOvPqVPZqZZ/HUaEKYSl62HjRfAlm+m5mhVqXx
         KyhnzWOAx4aAeT6P+R1jMKswBYlc/4a2FygmOfg9Ukml9kKclY3W5K+2e2rR82wGq+3+
         vtLP0lved4TF7aL+4QWCD7Hcq9sMKrlVBlQMnqwZHOa0ME3gkvpzgmGQSvAwJGJzhWXC
         0KOA==
X-Gm-Message-State: AOAM532v///iZbbYVjYLGuKntfalkPc0641Aj4SrYvCAo4voKplV8Sip
        HznFf8X+EqP/bW5Ft/OmLqTT+Q==
X-Google-Smtp-Source: ABdhPJzvTlWSfXCMJbRcWCpKisPl6QUA4PdiAul/EgxhmyHEf/e8MtwNFLvtPo2Deh4MEaqWvcd6DQ==
X-Received: by 2002:a17:902:aa91:: with SMTP id d17mr5955717plr.27.1599171616614;
        Thu, 03 Sep 2020 15:20:16 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o6sm3294870pju.25.2020.09.03.15.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 15:20:15 -0700 (PDT)
Date:   Thu, 3 Sep 2020 15:20:14 -0700
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
Subject: Re: [PATCH v2 12/28] kbuild: lto: limit inlining
Message-ID: <202009031520.DCF0B90B65@keescook>
References: <20200624203200.78870-1-samitolvanen@google.com>
 <20200903203053.3411268-1-samitolvanen@google.com>
 <20200903203053.3411268-13-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903203053.3411268-13-samitolvanen@google.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 03, 2020 at 01:30:37PM -0700, Sami Tolvanen wrote:
> This change limits function inlining across translation unit boundaries
> in order to reduce the binary size with LTO. The -import-instr-limit
> flag defines a size limit, as the number of LLVM IR instructions, for
> importing functions from other TUs, defaulting to 100.
> 
> Based on testing with arm64 defconfig, we found that a limit of 5 is a
> reasonable compromise between performance and binary size, reducing the
> size of a stripped vmlinux by 11%.
> 
> Suggested-by: George Burgess IV <gbiv@google.com>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
