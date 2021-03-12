Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B88D3383C9
	for <lists+linux-arch@lfdr.de>; Fri, 12 Mar 2021 03:46:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbhCLCpe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 11 Mar 2021 21:45:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbhCLCpT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 11 Mar 2021 21:45:19 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A0E1C061574
        for <linux-arch@vger.kernel.org>; Thu, 11 Mar 2021 18:45:19 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id a188so874537pfb.4
        for <linux-arch@vger.kernel.org>; Thu, 11 Mar 2021 18:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AssdNLgVnE+ciH4+zO5lxL3YhHsnzigu9rKdFnlTKlk=;
        b=hIQlmeCWP7pIGfJ5QNK11xJD01Ah5yhUwvyA2ww7yhNm+fTC+X7nXsvxCf/cfPJkw8
         nkcI9fivFzWEt/maVUeYndiFDn25FO8B7W04AYR/UDOt3gRYjRZzQNUCnbTnncwE0cZP
         XqXc4TvxtdB2n7+7RQIxaEFd3VdXAy+vdwy6o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AssdNLgVnE+ciH4+zO5lxL3YhHsnzigu9rKdFnlTKlk=;
        b=JUVwRWLKHl9L0j0aPfCxhsnz1AbH6Zn/tyQfzE7953Ytzx62g5uo+U43MxINs0uWCY
         NZshKGW7Hke2YIOOlWxs10ZOxotfG+F1PDaB7Ic2XdZlSBY6BZjmg0ArZX9pjM3J+Fqr
         fZlBXOivbBwISW7WvjAFd4fTOmRBFlY67EUnsrRQrwCu+JZla9SKyrFs/VD/iie2+0ej
         lQuO3+ZTaXf9RRsStJI49r8qo42zsRP3xjovCAynX2xXUNWLYfJnZ81XMCTC1Ekl1ECT
         iGJgbkeBjG+Mi6RMZA2s7MWQg1+F3S0Ex1PT/CQp9k0D24coFJAxnfxX/06c0m5q/o01
         /hYw==
X-Gm-Message-State: AOAM5321kVwU944Uxy8l2k1oqBDJtgZCeHd40vIygvZDHpbor3Z4iods
        9xfphh/NOAhM2K2EYCJQMndyvQ==
X-Google-Smtp-Source: ABdhPJxI0qWCdvIWD0Iv1exumtIeT9fGoJnsI5bP8+qNI3aaTbYLPtnoi/Tg5jl4840YLUIassNTiw==
X-Received: by 2002:a63:1e0a:: with SMTP id e10mr9855197pge.3.1615517118872;
        Thu, 11 Mar 2021 18:45:18 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 14sm3673048pfo.141.2021.03.11.18.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 18:45:18 -0800 (PST)
Date:   Thu, 11 Mar 2021 18:45:17 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        bpf@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kbuild@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/17] bpf: disable CFI in dispatcher functions
Message-ID: <202103111845.3A6EEB3E43@keescook>
References: <20210312004919.669614-1-samitolvanen@google.com>
 <20210312004919.669614-9-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210312004919.669614-9-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Mar 11, 2021 at 04:49:10PM -0800, Sami Tolvanen wrote:
> BPF dispatcher functions are patched at runtime to perform direct
> instead of indirect calls. Disable CFI for the dispatcher functions to
> avoid conflicts.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
