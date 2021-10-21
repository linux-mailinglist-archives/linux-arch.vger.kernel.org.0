Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B981436740
	for <lists+linux-arch@lfdr.de>; Thu, 21 Oct 2021 18:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbhJUQJI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 Oct 2021 12:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbhJUQJI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 21 Oct 2021 12:09:08 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 064AAC061764
        for <linux-arch@vger.kernel.org>; Thu, 21 Oct 2021 09:06:52 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id u6-20020a17090a3fc600b001a00250584aso3487250pjm.4
        for <linux-arch@vger.kernel.org>; Thu, 21 Oct 2021 09:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=m3LNgj0O/EXMuPerErFfv8v3ZBKINoSF6egU7Q9+w6o=;
        b=VluUCZI5Zb5BTknGwQTyQF+4e1x/d0hzfTejBQzID7EOo2c7LL2H55BJCJyzDqz+TY
         eopKS0vvjh1ta40dEl/PecFKas4qyf0oFKD9A4UW7/OqH1mtSPUfkEMqv2oYbNmDH5et
         RgtwwZtcSQXUO/559PvY3hzysWPdXVTGUMTfk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=m3LNgj0O/EXMuPerErFfv8v3ZBKINoSF6egU7Q9+w6o=;
        b=BxdmWO4Z6JclFS/l10FsQol1obD9nReoNVSlkK0rYPk71MrAuzg7n+u6FRIXrNA4J9
         IEX8kjlthj7d5jdOVL/wq5i/zBs71xZ33kYipYB4oosvLxs7Zv9yxFDgwzsmjmkmIwGo
         JwrJC83/82b989y0bjMN4R/lDRDDUFgO20a9cYLpihL1L9rCDI4+tew5p00TxwB1MlQm
         sCFIRWDJw3n51TSgfKUpiqUtfOqhnBAefuUEPWhBCe1SmEEeCFfYezIFplG7UcAtJfEA
         akqxshdQahrHfVIR0A3EzNodddlXX8vKp5A40eRo0qmDKS3/nXZonAfnTxOOEOD3wFoE
         Paeg==
X-Gm-Message-State: AOAM5304bTVTbyB71PkEO/9Vjd/bXRAMEOXDn1r91AKqngHOfipjDbak
        hp8EmI/7XkFgKNc5pvVgLW31gA==
X-Google-Smtp-Source: ABdhPJxgGu/kN8JubYDrPPD2bRBuFYPLrSNply2C5Q8AmdkddFccWiBgO05LI4OoBiR/2Tp4xlB9MQ==
X-Received: by 2002:a17:902:c94e:b0:13f:1b02:e539 with SMTP id i14-20020a170902c94e00b0013f1b02e539mr5894109pla.72.1634832411588;
        Thu, 21 Oct 2021 09:06:51 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s2sm5721985pgd.13.2021.10.21.09.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 09:06:51 -0700 (PDT)
Date:   Thu, 21 Oct 2021 09:06:50 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Maciej Rozycki <macro@orcam.me.uk>, linux-mips@vger.kernel.org
Subject: Re: [PATCH 05/20] signal/mips: Update (_save|_restore)_fp_context to
 fail with -EFAULT
Message-ID: <202110210906.AA70D50BA@keescook>
References: <87y26nmwkb.fsf@disp2133>
 <20211020174406.17889-5-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211020174406.17889-5-ebiederm@xmission.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 20, 2021 at 12:43:51PM -0500, Eric W. Biederman wrote:
> When an instruction to save or restore a register from the stack fails
> in _save_fp_context or _restore_fp_context return with -EFAULT.  This
> change was made to r2300_fpu.S[1] but it looks like it got lost with
> the introduction of EX2[2].  This is also what the other implementation
> of _save_fp_context and _restore_fp_context in r4k_fpu.S does, and
> what is needed for the callers to be able to handle the error.
> 
> Furthermore calling do_exit(SIGSEGV) from bad_stack is wrong because
> it does not terminate the entire process it just terminates a single
> thread.
> 
> As the changed code was the only caller of arch/mips/kernel/syscall.c:bad_stack
> remove the problematic and now unused helper function.
> 
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Maciej Rozycki <macro@orcam.me.uk>
> Cc: linux-mips@vger.kernel.org
> [1] 35938a00ba86 ("MIPS: Fix ISA I FP sigcontext access violation handling")
> [2] f92722dc4545 ("MIPS: Correct MIPS I FP sigcontext layout")
> Fixes: f92722dc4545 ("MIPS: Correct MIPS I FP sigcontext layout")
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
