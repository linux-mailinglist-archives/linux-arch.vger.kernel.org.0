Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCCEB27F37C
	for <lists+linux-arch@lfdr.de>; Wed, 30 Sep 2020 22:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730281AbgI3UpH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 30 Sep 2020 16:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728793AbgI3UpG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 30 Sep 2020 16:45:06 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B8DC061755
        for <linux-arch@vger.kernel.org>; Wed, 30 Sep 2020 13:45:06 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id m34so1857475pgl.9
        for <linux-arch@vger.kernel.org>; Wed, 30 Sep 2020 13:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JgQmmymEepmTyKfdtmZJjASTO5kyTURiWqToh5meDKE=;
        b=N1JSnjgIbsN1xv7O/7f3T3QNscpYc+Oc8Onavg+xJhKmu87Vl5txC0mRnj581yP+T5
         vji39GuQ54k3KnvTyItbHHJyjV7n/9yiIdpidKzXo0JDXhzi+h96aiFk9fi64j8d2bCt
         gMDMVPAGpbUo9icFxVDwyRsfPfCjPc7VT3l7U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JgQmmymEepmTyKfdtmZJjASTO5kyTURiWqToh5meDKE=;
        b=bb66ASFhyFNmF6UN5bt3fy+rc0uOWvyVde1Hs2nIlWJhScldZPPB48jN7INasOWpoU
         4yw9d83Fw3+OsaN2jeqHA5a9pdsgrRNfTxaJ5hgR+KMCysPTVtBN9Qv9Nj2EWCHZr6MD
         DowzCUXWtZPW9pHh7T0CNUploUV07fy89yWggcSUah/lGjLRxtVGSSOwO2KXOW+EDrsV
         TdzkaERTVXyIdPiYWpJFb2esOolM6lieV2tPr6yyZY7nQLvP2buDfrQKQVvSBKMWn/Ru
         8UKY4XZpZBz/UpiOiICTn3DbYU5Iw03q4qSZ1/TP+jaWSw3C4rKrXlK+fyt0t9kQtXMX
         jfHg==
X-Gm-Message-State: AOAM533d3kDai7DXD4tbH4+oUy80oc7L+F1idDm+fGA1M537pNzEHBya
        3TNUN9AQB5GKfza3H5nWGWw6Lw==
X-Google-Smtp-Source: ABdhPJwj25UpjOCh8s4y4qnI0EKHGhfilZz0SCC4DlHMi6btWQ6hwRXxTigXsih3jOgTEpH2lz1kwQ==
X-Received: by 2002:a63:4d4a:: with SMTP id n10mr3430255pgl.96.1601498706030;
        Wed, 30 Sep 2020 13:45:06 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g24sm3730158pfk.65.2020.09.30.13.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 13:45:05 -0700 (PDT)
Date:   Wed, 30 Sep 2020 13:45:04 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH v4 10/29] treewide: remove DISABLE_LTO
Message-ID: <202009301344.3949D2FA8@keescook>
References: <20200929214631.3516445-1-samitolvanen@google.com>
 <20200929214631.3516445-11-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929214631.3516445-11-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Sep 29, 2020 at 02:46:12PM -0700, Sami Tolvanen wrote:
> This change removes all instances of DISABLE_LTO from
> Makefiles, as they are currently unused, and the preferred
> method of disabling LTO is to filter out the flags instead.
> 
> Suggested-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Thanks! I think this makes things cleaner in the later patches. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
