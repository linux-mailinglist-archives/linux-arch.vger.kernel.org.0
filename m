Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70BE1209733
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jun 2020 01:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388094AbgFXXhc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Jun 2020 19:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387981AbgFXXhb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 Jun 2020 19:37:31 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8313CC061796
        for <linux-arch@vger.kernel.org>; Wed, 24 Jun 2020 16:37:31 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id y18so1860844plr.4
        for <linux-arch@vger.kernel.org>; Wed, 24 Jun 2020 16:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mo7Dwe07kJhP63QLmOzciNFvW218NBaVIlEPp4HbWlg=;
        b=ghe0LNHZStIXrutzWngNn1w8HnVKxzkKAANg+f3UNbpWa1VXDLTQLRRUxQiw0ETxf1
         8IwO0ripMH+IKCR86WNY+ysG11jZ8MVO51xum9mEa475UtB+fdRpajYIKrof1LeRnhfw
         q/KZy9ALnBT7rcr/zSWyqYTnZ3OeY5pBxENZEDhKneGeIxS3jxNDb3T6z60V1Qc+Vdy6
         OTaykXWX6WKsBL92+Zu8AYSrqkunkoROSncALDdIHd5jRSMEYzkTx2v4nRNz4Z77j4S9
         tRCzT7qVWnXl4XZ9bSsfQVqiYUdUQyfJWFL+rlMfK7ACBBFVz6umkgQZxUMxIfkAgDuf
         rFfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mo7Dwe07kJhP63QLmOzciNFvW218NBaVIlEPp4HbWlg=;
        b=HGQ8na6mlXidsMuUtcDeBJwM9giZJrROXxoYjRdVgYs1u0AjNPnSwsIBEkVKj4HGOy
         CYIbYJoHSY5OySh6hDvtc0uYDc298qHtQ0F2IHdxawKuQ9B9mnJlKg83OvaPreTi9F3c
         2tmDhPXdNlhGdh9xNXWmE0WG1XtE/YjcVH+jmMEGQmn4UAygQxG6sEt/LcDXn6wV23Vf
         yoPilAC3ggIKsg5xgLdt9fuuS+Qu2K1RJKbnVckzmoRtqvpCJsPNA/R3kjSnh07xENRg
         G5CSMTP1R8ZDhoAHOifxTG66ePF+9VtJt+aIlUQOHUVduCWJONCMYZCfI3XorLzPma/i
         oVaw==
X-Gm-Message-State: AOAM5332icdp8CML1yJ3v/kyZCSTRdW8wLX2Ft9+Pb7DBTZT25FUQuri
        XAtdd85Vd3AI0cwvrIGMEVdq1w==
X-Google-Smtp-Source: ABdhPJzbL+A8YRu6cQqMhEnH4JVMHPuZevDUkJdMyUg1rfNtOurVArWJG2BoYxI9g7/QXZLvtzZHnQ==
X-Received: by 2002:a17:90a:9d8b:: with SMTP id k11mr267919pjp.10.1593041850610;
        Wed, 24 Jun 2020 16:37:30 -0700 (PDT)
Received: from google.com ([2620:15c:201:2:ce90:ab18:83b0:619])
        by smtp.gmail.com with ESMTPSA id c9sm21338811pfr.72.2020.06.24.16.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 16:37:29 -0700 (PDT)
Date:   Wed, 24 Jun 2020 16:37:24 -0700
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org, George Burgess IV <gbiv@google.com>
Subject: Re: [PATCH 06/22] kbuild: lto: limit inlining
Message-ID: <20200624233724.GA94769@google.com>
References: <20200624203200.78870-1-samitolvanen@google.com>
 <20200624203200.78870-7-samitolvanen@google.com>
 <20200624212055.GU4817@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624212055.GU4817@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jun 24, 2020 at 11:20:55PM +0200, Peter Zijlstra wrote:
> On Wed, Jun 24, 2020 at 01:31:44PM -0700, Sami Tolvanen wrote:
> > This change limits function inlining across translation unit
> > boundaries in order to reduce the binary size with LTO.
> > 
> > The -import-instr-limit flag defines a size limit, as the number
> > of LLVM IR instructions, for importing functions from other TUs.
> > The default value is 100, and decreasing it to 5 reduces the size
> > of a stripped arm64 defconfig vmlinux by 11%.
> 
> Is that also the right number for x86? What about the effect on
> performance? What did 6 do? or 4?

This is the size limit we decided on for Android after testing on
arm64, but the number is obviously a compromise between code size
and performance. I'd be happy to benchmark this further once other
concerns have been resolved.

Sami
