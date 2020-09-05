Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF05A25EB8E
	for <lists+linux-arch@lfdr.de>; Sun,  6 Sep 2020 00:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728505AbgIEWso (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 5 Sep 2020 18:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728103AbgIEWsn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 5 Sep 2020 18:48:43 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47227C061244;
        Sat,  5 Sep 2020 15:48:42 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id n10so7512097qtv.3;
        Sat, 05 Sep 2020 15:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dYL37oonxahMiERY6M7bI0fQzZLAfl7INM1zulnY34U=;
        b=i2sjWJ41j0LCW9MSNR1r+BVTos+aNU/sQNRWMGLG3Xma5GsC0JJOMnRi2RFJtAuqeZ
         0lHzhBvxAsBMOF3NMXNMwQD+MuIZx5VzzycZN/qia173TCug2EPrmCp/1flJHsFHFloR
         3VwMI8lSCupizstJ9n/tk5eH9GL5wojfKV9z2jtfNZI2gEbcRbZlgndrrSdimkuu3NM1
         I50PNYQ9ZRV5w6K1nEe5yUUyjb+54T0D1PA3Cyds+//mrHOpI0X1ugO2t6yIT4THAprZ
         PEySoMqWEQwDcQTH3SGaEir1HOXMu+jm+kXFGkB+kxz9Qk3oB/KbAa6ykOY2+TF9iqFW
         JmZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=dYL37oonxahMiERY6M7bI0fQzZLAfl7INM1zulnY34U=;
        b=QnwAFk0CzywhDdZCTVa/+JbDIw6qTFDrx0zcZcfuG9PNe0v1prSs+zDHlGTS8ib/Cy
         unyfaUHpi8TNoPR6v/cPBCSNPEK75aocpHFgmRO8KW8r6bojukmH9A9LLkjFyN23LVzj
         es/Er+Slgg+N6uNkkVCALL/b9N2ivYbgvFdb0/TPtVojNkiqMO2qMCJLRKMCf6XJaDSJ
         LV9GtzXUNFfenGChalHT+uh12c5eCQrXHi+nsDr6vYkDWricqcU8yqteU+rR9mk1WkB/
         g9CMROa6Tdg68FJKyruB+fl6OOLdta4fy6AWph+wHbNH5NvxJvVPnPgakcWL5OGcpXq8
         xhHA==
X-Gm-Message-State: AOAM533oSOXN+wjvzlBVtvuWgoQCsu1rtCD4Z0AyIEJxE5pT9SSYTJqx
        xs382JY9+oe9u4m8hWqdyHo=
X-Google-Smtp-Source: ABdhPJzozlDPhyXr6JOZFagjTaiEP3QCjS39SNNHLMhx0wYBQR2VlcAzn6ysX8qJ/+qxrT46u/KrJA==
X-Received: by 2002:ac8:fbb:: with SMTP id b56mr14999497qtk.307.1599346118622;
        Sat, 05 Sep 2020 15:48:38 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id d16sm8184604qte.19.2020.09.05.15.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2020 15:48:38 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Sat, 5 Sep 2020 18:48:35 -0400
To:     Kees Cook <keescook@chromium.org>
Cc:     Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
        clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 4/5] x86/build: Warn on orphan section placement
Message-ID: <20200905224835.GA1500331@rani.riverdale.lan>
References: <20200902025347.2504702-1-keescook@chromium.org>
 <20200902025347.2504702-5-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200902025347.2504702-5-keescook@chromium.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Sep 01, 2020 at 07:53:46PM -0700, Kees Cook wrote:
> We don't want to depend on the linker's orphan section placement
> heuristics as these can vary between linkers, and may change between
> versions. All sections need to be explicitly handled in the linker script.
> 
> Now that all sections are explicitly handled, enable orphan section
> warnings.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  arch/x86/Makefile | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/x86/Makefile b/arch/x86/Makefile
> index 4346ffb2e39f..154259f18b8b 100644
> --- a/arch/x86/Makefile
> +++ b/arch/x86/Makefile
> @@ -209,6 +209,10 @@ ifdef CONFIG_X86_64
>  LDFLAGS_vmlinux += -z max-page-size=0x200000
>  endif
>  
> +# We never want expected sections to be placed heuristically by the
> +# linker. All sections should be explicitly named in the linker script.
> +LDFLAGS_vmlinux += $(call ld-option, --orphan-handling=warn)
> +
>  archscripts: scripts_basic
>  	$(Q)$(MAKE) $(build)=arch/x86/tools relocs
>  
> -- 
> 2.25.1
> 

With LLVM=1 and GCOV_KERNEL/GCOV_PROFILE_ALL enabled, there are
.eh_frame sections created. I see that KASAN and KCSAN currently discard
them. Does GCOV actually need them or should it also discard?

Thanks.
