Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0627128EB08
	for <lists+linux-arch@lfdr.de>; Thu, 15 Oct 2020 04:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbgJOCTh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 14 Oct 2020 22:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbgJOCTh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 14 Oct 2020 22:19:37 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E0BC05BD22
        for <linux-arch@vger.kernel.org>; Wed, 14 Oct 2020 15:43:25 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id a200so694824pfa.10
        for <linux-arch@vger.kernel.org>; Wed, 14 Oct 2020 15:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HXE7zd358OihnnXdqbHtVXM+0rFJH6HtXX7mG7HS7rs=;
        b=P+m7XeYyZ2d5m2JBT4Wg90TEWdILqbaLccqKq7i1SamEiRkb82fahXnlpg2f1W1wbg
         hYpm7jOYPcOHuFgqqHnuX4V3PF9C/c9wSPHpPybZudVDCal6bW+V4V423MNW5wH9Pi3v
         EAtrVXrDgHaNrDFivAYIB/ro+72Y46zcpNM1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HXE7zd358OihnnXdqbHtVXM+0rFJH6HtXX7mG7HS7rs=;
        b=FHPTtmlHJx3rq42nqHn1ytCPDYL8LkUVboVEDxdYe3ORO7xsiteBu3DlzacymWFYoT
         ziWL8omTar3wL704WOZO/h2EWBwSh9CPbytFjTOGuAq5yDL1b1XMabobFY0/YWQxLdku
         fOLemOiQPfjf3ScS2fm5gI+2IOmpH+wOy7Hpm1YsclDfeqD/D/RiI4h7A52rGnRi4wCO
         PSIaJK02t81bMtfdu4zR4XLOl+AvUdg9Smhnc8Oo2Egy3SvWrjsCv/XMRcoFUPyo1prk
         UDAx4TUWra2dGrDIVzO1GmUikn56lb2uCpX9fE/fnXTVjsyFY0jiU1+ILX331AR95YhW
         dj+Q==
X-Gm-Message-State: AOAM532Tfpxo3B7HGiniFb7nzwHEwKq0j4lDyGzA3b4nDnBmrhx94C9q
        G1apMZYSO8ytayA+/QOao7LkEw==
X-Google-Smtp-Source: ABdhPJwfaPNC+AVzyD2mbtxihYKliPRj3PBojQshk4IbHIXu4wlCtL4Vs5DVZZ2Xhz60ywvob16sAw==
X-Received: by 2002:a63:77c4:: with SMTP id s187mr881793pgc.303.1602715405507;
        Wed, 14 Oct 2020 15:43:25 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l14sm630167pfc.170.2020.10.14.15.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2020 15:43:24 -0700 (PDT)
Date:   Wed, 14 Oct 2020 15:43:23 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH v6 07/25] treewide: remove DISABLE_LTO
Message-ID: <202010141541.E689442E@keescook>
References: <20201013003203.4168817-1-samitolvanen@google.com>
 <20201013003203.4168817-8-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201013003203.4168817-8-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Oct 12, 2020 at 05:31:45PM -0700, Sami Tolvanen wrote:
> This change removes all instances of DISABLE_LTO from
> Makefiles, as they are currently unused, and the preferred
> method of disabling LTO is to filter out the flags instead.
> 
> Suggested-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>

Hi Masahiro,

Since this is independent of anything else and could be seen as a
general cleanup, can this patch be taken into your tree, just to
separate it from the list of dependencies for this series?

-Kees

-- 
Kees Cook
