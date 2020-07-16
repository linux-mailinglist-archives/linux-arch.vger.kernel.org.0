Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80EE9222D4B
	for <lists+linux-arch@lfdr.de>; Thu, 16 Jul 2020 22:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725959AbgGPU5B (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 16 Jul 2020 16:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbgGPU47 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 16 Jul 2020 16:56:59 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D27BFC061755
        for <linux-arch@vger.kernel.org>; Thu, 16 Jul 2020 13:56:59 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id m22so5441248pgv.9
        for <linux-arch@vger.kernel.org>; Thu, 16 Jul 2020 13:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VhwUXS7xQLeI5A8zuKFyZny7IQHvIE+zP5ObVJhuh7o=;
        b=juh+QMp9iXE9jqDtJtdsumhrFyyJ4wGE7w2uxHCiQ4hgadiBuZzPhFjfXzE/UUX3ry
         zXHjDUciBIv+1/76l2skFse0Ks6ANgnaIfesAnXonjXm9WpbaenWt+bOkTHX+wYi3EwR
         K8GNbPPPqJ5re+9LirXkpX5Rk+EUm1YIoyL6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VhwUXS7xQLeI5A8zuKFyZny7IQHvIE+zP5ObVJhuh7o=;
        b=SGJHeqBXWSraKLK0KUqbTnqDMCSEcih4j+k6KaTRBzCr79li+7yi4SI3fxtkWsq2/m
         86NqUzprO8cWfxH210stdsvJyjKp18c1YUIZqJtuqgzFC1M9IHAFNHXBE27gG+e84nj+
         8C5c+eWieBpDFc+grQ+sa9NQRPTWV8Oe82Woqrr3+730MVeKBHGLh5k9V1Uxed4vh3Tw
         cm+49dUeEs/5VcoNffUBJSXtgcDLLLQMMe6Q4NYNjzR9pPEjdYUWd7nDu1bD8nZwnBtP
         FC5p6Ou046npJkbHt/I9plj9xYBZOfs4Vzb6ywtiQN992bmlZQcItfZsdvGj4xcrRGm4
         bRTQ==
X-Gm-Message-State: AOAM531pigaCXNzu01UTsIjECn0T54yJOmmYa8VuNLxM4rLt16k5U7dJ
        mthy635Ifc7oarTMRFocZykkxw==
X-Google-Smtp-Source: ABdhPJwMV2s/kQB+MFw/wcpWH6J0wsZn4KhmDPbLhSzK2FEmEK7+il1ocsbY/TenztYWogQxFnw2Lg==
X-Received: by 2002:aa7:8648:: with SMTP id a8mr5179085pfo.222.1594933019474;
        Thu, 16 Jul 2020 13:56:59 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b18sm839769pju.10.2020.07.16.13.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 13:56:58 -0700 (PDT)
Date:   Thu, 16 Jul 2020 13:56:57 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Keno Fischer <keno@juliacomputing.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Subject: Re: [patch V3 05/13] x86/entry: Consolidate check_user_regs()
Message-ID: <202007161356.5CD3A6ACE@keescook>
References: <20200716182208.180916541@linutronix.de>
 <20200716185424.442693273@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716185424.442693273@linutronix.de>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jul 16, 2020 at 08:22:13PM +0200, Thomas Gleixner wrote:
> The user register sanity check is sprinkled all over the place. Move it
> into enter_from_user_mode().
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
