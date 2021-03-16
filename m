Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1533933E1D5
	for <lists+linux-arch@lfdr.de>; Wed, 17 Mar 2021 00:03:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbhCPXC7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 Mar 2021 19:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbhCPXC4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 Mar 2021 19:02:56 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 811ECC061765
        for <linux-arch@vger.kernel.org>; Tue, 16 Mar 2021 16:02:56 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id g4so23632232pgj.0
        for <linux-arch@vger.kernel.org>; Tue, 16 Mar 2021 16:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kXkZPUcTv+BH4LFKsPIbe+jirsdRWJGrIqCSnte4+pk=;
        b=n7z/7n8BAe+C7mTkXJHeaNKkrmAd3FDbaONpZvyNMxkhbVT0HhlGCasczqYzg9skM7
         qBBK04FrNjFr5vEVg8tejTGS6nhlakf8ACj8v81qEm6NbXbdnWSH6RNFIfGot//y7tiV
         m7X88W7uUbP5jCvFAuxcc3DEyOCGAo9oImDDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kXkZPUcTv+BH4LFKsPIbe+jirsdRWJGrIqCSnte4+pk=;
        b=Q5LGKmCvvsQRej9erqqNfFtykOmZA3hQlHgW5h7gEUR8R6D/+WTzZo6FE/yuu79sBM
         Ck9AQ577Z1umqyd+LNW5nkYLHDa7xE9SqynB/ds3I84IDnKkXTmEDtJtiNErKnwvQq4J
         ygrdzl1AhKKAawlbevuTKA4zzfiv4Aq9IrEljQUgpvQ4tGzHdn5CDqBdPmvCGBWA8DoT
         N4ml0GdASY1vqIPCk1KeJGVVRwQfs7JV0CnbPkRDR+hDlR05g0wm6rDCmsQnL7HfhBsg
         904mAgMaaC89rMdJmTegIZN0aUIgdml3U4tyWWLoogYeqcaihPWKL4jtG0MomQ8S2yFM
         UUgA==
X-Gm-Message-State: AOAM532GAnWhoT6qGk5vohllk1xBqBw2zy1TWfAk3tC2nqdCmfGqyWhN
        YA8PO723Zd+3gW/IIXk2WimEyQ==
X-Google-Smtp-Source: ABdhPJxUsDSC7HTflCNgrlhXH8m0bkwMud4JF2D4um9D+38w6bFYcJnCSdxm5YlWmyN87vHVWtDfEA==
X-Received: by 2002:a63:4652:: with SMTP id v18mr42886pgk.87.1615935775940;
        Tue, 16 Mar 2021 16:02:55 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id mp1sm372749pjb.48.2021.03.16.16.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 16:02:54 -0700 (PDT)
Date:   Tue, 16 Mar 2021 16:02:53 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        bpf@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 17/17] arm64: allow CONFIG_CFI_CLANG to be selected
Message-ID: <202103161602.6DB8AC31FA@keescook>
References: <20210312004919.669614-1-samitolvanen@google.com>
 <20210312004919.669614-18-samitolvanen@google.com>
 <202103111851.69AA6E59@keescook>
 <CABCJKucpFHC-9rvT7uNF+E-Jh20fz69zdO49_4p8G_Sb634qmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABCJKucpFHC-9rvT7uNF+E-Jh20fz69zdO49_4p8G_Sb634qmw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Mar 16, 2021 at 01:44:33PM -0700, Sami Tolvanen wrote:
> On Thu, Mar 11, 2021 at 6:51 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Thu, Mar 11, 2021 at 04:49:19PM -0800, Sami Tolvanen wrote:
> > > Select ARCH_SUPPORTS_CFI_CLANG to allow CFI to be enabled.
> > >
> > > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> >
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> >
> > Random thought: the vDSO doesn't need special handling because it
> > doesn't make any indirect calls, yes?
> 
> That might be true, but we also filter out CC_FLAGS_LTO for the vDSO,
> which disables CFI as well.

Oh right! That would do it. :)

-- 
Kees Cook
