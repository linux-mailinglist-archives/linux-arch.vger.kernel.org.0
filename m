Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD258206B6F
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jun 2020 06:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388584AbgFXEwL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Jun 2020 00:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388401AbgFXEwL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 Jun 2020 00:52:11 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B537C061755
        for <linux-arch@vger.kernel.org>; Tue, 23 Jun 2020 21:52:11 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id z5so788008pgb.6
        for <linux-arch@vger.kernel.org>; Tue, 23 Jun 2020 21:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6f53wfu9QNcdQT3ZJDSOeI3w2U50C/xG0fFlCdqBwh8=;
        b=SOQtldw9KnegRbDuujQK6mSW72Ar+eCo9OL6sqQyLe4507FK6z15J0tVonL3ROJGKX
         jmUWzV1kGTM8ch5wLol9h8AUoGlp2vmbh9AfB5HB82Nf6nd9MDgTkfuVbQTqVcoi6m9O
         rflkv7LK/GEf+O4d4akCkHJ7Zge7ftnPwuhiE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6f53wfu9QNcdQT3ZJDSOeI3w2U50C/xG0fFlCdqBwh8=;
        b=jXxnA0KXITBrbr5uOWl+nkOtKQUCUR8+5MYFCzQrhE7/gUlukdlk2USFuVMkSyoLo8
         tJGASLwvflksJhDZywYker147YwITm/hYHcfQ6gzg/0nYEOHdBY6LiGtq517Ivd73jQv
         OraqLx3cHISAx8gTWi8YCiiUcNOxsGuyJXGUAKKW1xDgKo3nV5WqPTXeR1CfsA80iG7p
         B0E6Qk0ZZ9P+7766PqwfydI/MzgW0xMdK32Ox7kzAlmuEh1+XPOqtvT83Bw8QlqsapYs
         lx2zRf1Ee24kVddRnGHccnn060iGdOO8GytyeInS2KFyxfeeirNlyrq359kxRjhsh035
         uUww==
X-Gm-Message-State: AOAM530tvXRH9DZr8geV8bBejUtNL5ndjUIry/GDiIlUhjbF/FgCTZ3A
        QlIIV2dcXPmBv312gCvJwR9HDw==
X-Google-Smtp-Source: ABdhPJwX4es65nYyfcxHOhK/hXQNs9Mgx96rrroztpO1dJ1CT4SWu7NO7yDI/cU1cNN8RdLutBMqkA==
X-Received: by 2002:a65:6710:: with SMTP id u16mr14011070pgf.45.1592974330709;
        Tue, 23 Jun 2020 21:52:10 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q92sm3895838pjh.12.2020.06.23.21.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 21:52:09 -0700 (PDT)
Date:   Tue, 23 Jun 2020 21:52:08 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Kristen Carlson Accardi <kristen@linux.intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
        arjan@linux.intel.com, linux-kernel@vger.kernel.org,
        kernel-hardening@lists.openwall.com, rick.p.edgecombe@intel.com,
        Tony Luck <tony.luck@intel.com>, linux-arch@vger.kernel.org
Subject: Re: [PATCH v3 05/10] x86: Make sure _etext includes function sections
Message-ID: <202006232152.733212868D@keescook>
References: <20200623172327.5701-1-kristen@linux.intel.com>
 <20200623172327.5701-6-kristen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623172327.5701-6-kristen@linux.intel.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jun 23, 2020 at 10:23:22AM -0700, Kristen Carlson Accardi wrote:
> When using -ffunction-sections to place each function in
> it's own text section so it can be randomized at load time, the
> linker considers these .text.* sections "orphaned sections", and
> will place them after the first similar section (.text). In order
> to accurately represent the end of the text section and the
> orphaned sections, _etext must be moved so that it is after both
> .text and .text.* The text size must also be calculated to
> include .text AND .text.*
> 
> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
