Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFC9B43679B
	for <lists+linux-arch@lfdr.de>; Thu, 21 Oct 2021 18:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230441AbhJUQ0k (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 Oct 2021 12:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbhJUQ0k (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 21 Oct 2021 12:26:40 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9D4C061764
        for <linux-arch@vger.kernel.org>; Thu, 21 Oct 2021 09:24:24 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id w17so769578plg.9
        for <linux-arch@vger.kernel.org>; Thu, 21 Oct 2021 09:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sicbfSoVA09vC/F2ygsvFebcU9ao+N436bsOlAERsb0=;
        b=J7SHLOqBgGtyMBwfu6R2MQgPhsCmRrCwQurlKSFARfZtEcN03hk0m/I7C7yv7Rv5xO
         zwC6ZgAR7Acy0JFIo2P2acD2hZYpScYEd+ghKPkRlk/rnVUNiyhgXEIq1BSA5BtSPyZ6
         Cosuw68xSLwG89F8ygK32uEg4/ozQJvzzkLV0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sicbfSoVA09vC/F2ygsvFebcU9ao+N436bsOlAERsb0=;
        b=dkr89/xHOQAZyOVMWF644JzK+wSyt9a32mH3aEUJqF0gzVG4p9MLBBJa1QWyL3tgcr
         gpYlFOkyEzcijo7k05e5gSB3/VoB4nHYa7ZU3dNsAYrRNFoi466EQvEar2EtrgyFmpp5
         rWxsWxfapLsycn/lTvXkmcnZs6OOlLRIyKJpv/vmPc9NpnTkMBONvizF62dnegujtGZL
         n0HzFJZiieElMCJyVZfgPvK6riea8t5e61mvwipXwdOvo3Hl+M5cCa5Ugzh3QqGlDBNh
         FTD8v4LOWEqzgMxpLaiLP/nuz/K0+cRdEWEiFNCwejiR5lDHuaCrQsSKyDX441sIUUc9
         ByJA==
X-Gm-Message-State: AOAM533eBRyz2hwbq8i6RMoMFZevqpC3kxw/p37lWiWdF3Qgh0atV9At
        5bdvv19ddat4ZCOZpTgUJ7Sr7Q==
X-Google-Smtp-Source: ABdhPJx2qkrlbfcZEtyzZwLuRL4U2JW0J2alIIZO9Gd3zy4tWSCeZlXmXCDgeDR/qz7B9+GwugC2QA==
X-Received: by 2002:a17:902:c104:b0:13f:24db:8658 with SMTP id 4-20020a170902c10400b0013f24db8658mr6138071pli.7.1634833463732;
        Thu, 21 Oct 2021 09:24:23 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x1sm6800991pfp.190.2021.10.21.09.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 09:24:23 -0700 (PDT)
Date:   Thu, 21 Oct 2021 09:24:22 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 13/20] signal: Implement force_fatal_sig
Message-ID: <202110210923.F5BE43C@keescook>
References: <87y26nmwkb.fsf@disp2133>
 <20211020174406.17889-13-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211020174406.17889-13-ebiederm@xmission.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 20, 2021 at 12:43:59PM -0500, Eric W. Biederman wrote:
> Add a simple helper force_fatal_sig that causes a signal to be
> delivered to a process as if the signal handler was set to SIG_DFL.
> 
> Reimplement force_sigsegv based upon this new helper.  This fixes
> force_sigsegv so that when it forces the default signal handler
> to be used the code now forces the signal to be unblocked as well.
> 
> Reusing the tested logic in force_sig_info_to_task that was built for
> force_sig_seccomp this makes the implementation trivial.
> 
> This is interesting both because it makes force_sigsegv simpler and
> because there are a couple of buggy places in the kernel that call
> do_exit(SIGILL) or do_exit(SIGSYS) because there is no straight
> forward way today for those places to simply force the exit of a
> process with the chosen signal.  Creating force_fatal_sig allows
> those places to be implemented with normal signal exits.

I assume this is talking about seccomp()? :) Should a patch be included
in this series to change those?

> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
