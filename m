Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A761E228BA0
	for <lists+linux-arch@lfdr.de>; Tue, 21 Jul 2020 23:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728203AbgGUVr7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Jul 2020 17:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727971AbgGUVr6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jul 2020 17:47:58 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B86CC0619DC
        for <linux-arch@vger.kernel.org>; Tue, 21 Jul 2020 14:47:58 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id f16so84757pjt.0
        for <linux-arch@vger.kernel.org>; Tue, 21 Jul 2020 14:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Uq0Aq+GcsmVy3ZiohS7NTEe6z0eXz9cxjaRfYjEwnno=;
        b=PMP0ufkBBI/0n1brlASes3pVQK2FeofXL5D2cNR4NNDrIKCeTAfTtEi6hR8sHKIW9x
         KvymZb8ra4HK/OeQDQ6IE9M0E3cVlC6btD441Fnq9Pe0vg0f9hDcEKJ4n/Bq5uQW9GlV
         gclJFMiOJUpa41KhoSbJ4I7Etd4Zhs6cMaZ9s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Uq0Aq+GcsmVy3ZiohS7NTEe6z0eXz9cxjaRfYjEwnno=;
        b=RNBUE1d2s9eNjhGLAOkfFUuOoBWnAsTbHaKypqu3MlxMSqlWBppSVvZ+M+zOoB+A/0
         W5/xlN+9hp/iVJ+cwWW+3Rof0HhxISrSiRWoNlFW2A3E/dXNhY9+TyuAY/tUiTFT+Sba
         mXvzvi9NMbUA6ufICNWk6LlHs5Id+shSFhkjnx40fYWTWTAlPtBc7KjDZvxDaKJMBtIz
         lm1xh8LGW570wOtFVSPJMuL2EsP6gZekeozfBCKA98kOxu8fLHW91LzeW973MsPgyNFZ
         ljfqGSvdpW/wlMkOVGTH5212VzGwb/eVYX8qM69PBaHtltY7ZuZuCOLqSEoYlPi+Yx1j
         Jnzw==
X-Gm-Message-State: AOAM530EY7hkcQ4B5AJRKyDwafKJRv6pLseYmN1aMaw/UpoSI9F9iU5z
        rU24fa4IOJw2MFaxsLQRu6bqbQ==
X-Google-Smtp-Source: ABdhPJzIWR86OgW1YkqQCpbKimd/BCL0yL44kI4I/YgjKuNClofZhDSTwBuM2DWxXlJ0krV0jYl8iw==
X-Received: by 2002:a17:90a:987:: with SMTP id 7mr6334935pjo.186.1595368078049;
        Tue, 21 Jul 2020 14:47:58 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w1sm21824179pfq.53.2020.07.21.14.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 14:47:57 -0700 (PDT)
Date:   Tue, 21 Jul 2020 14:47:56 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Keno Fischer <keno@juliacomputing.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: Re: [patch V4 11/15] x86/entry: Use generic syscall exit
 functionality
Message-ID: <202007211447.8F89234@keescook>
References: <20200721105706.030914876@linutronix.de>
 <20200721110809.432210708@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721110809.432210708@linutronix.de>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 21, 2020 at 12:57:17PM +0200, Thomas Gleixner wrote:
> Replace the x86 variant with the generic version. Provide the relevant
> architecture specific helper functions and defines.
> 
> Use a temporary define for idtentry_exit_user which will be cleaned up
> seperately.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
