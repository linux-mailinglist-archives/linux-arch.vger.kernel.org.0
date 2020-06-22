Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 017F620440B
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jun 2020 00:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731171AbgFVWtg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 Jun 2020 18:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730943AbgFVWtg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 Jun 2020 18:49:36 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2888BC061573
        for <linux-arch@vger.kernel.org>; Mon, 22 Jun 2020 15:49:32 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id y18so8234516plr.4
        for <linux-arch@vger.kernel.org>; Mon, 22 Jun 2020 15:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SP3dyPHUmHcuUaUcIWcrCUYi0/7CkhHaUVAQAIGPRiw=;
        b=rqyfynf7UAFDwDSb/T55QtDTBnFfCHVZCses4sSuiYO2dgUm7t8zd3wVI44JPOhk/S
         msAc41Xsv0jlK17XIEwc4UIIukR6wMdrfDGWYMITucg8XL9elbqousD6Y5vQn4ZQdYbP
         x+rAgSVOwRngX0FpZ9a1EZp0U2D65wKG/ilw7iY9UHEp/x5B1kDOIdC3c1R4W9X9APVt
         H1ybAP4FBK7ngwH7RpHzxzxQEj7UMXtaSqKgY+yMYpdcvdNixWsChNFKjCtXQiJHpWgX
         T39C419wCjJcWLVWFr7VKvD3YZsYCR06gGDDAsl64X3N5rC8FlTET8lbIbBRDstc+gi8
         42aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SP3dyPHUmHcuUaUcIWcrCUYi0/7CkhHaUVAQAIGPRiw=;
        b=mkcnIG7TTY0lTBLXw+pjssiRx9sbhBGDSzOJQw5LmGslJZsr2WEh8Uoszl0jNobQZ5
         zAk8C/Cs+QmAioK0MWrGeqwH7eAJOooDOJB+c8UOcRoy2Ssi+7PMyFtEkPTyE2jpdzTe
         kAG0ZYIDbv1+4zzY8PUoS7R1U+OCqFtdKGeCQLPjiPGsRIQhRxFKFfkacElkeRGdIhR/
         Vy2Stts4PcMC3K2eIJM7/2JPdx/dAWHtaww43CSoCCpp7WaqESgyc8HBxnvU3ITk4AZN
         7ag9jj4tqsU6c95PBHHVkMr3QsP88oufi50yIKKDfLAb/K8ubTIS9FAWww+ptNPyz0Bn
         OkRQ==
X-Gm-Message-State: AOAM53398/WQ8lI4iZNxAmEHeB3HJyUa8iWrWjZjjVHmk6BRNR7QxxSG
        nDctOfDw869N5298gdoD/bG4Dg==
X-Google-Smtp-Source: ABdhPJwQ2Ixe/aYho5JT0ddHM/v5RvncJ3WmbpOAhsM4vvBeH77HFDofl5WlPL5D4DTiBlLrPGJvRA==
X-Received: by 2002:a17:902:46b:: with SMTP id 98mr22227335ple.259.1592866171384;
        Mon, 22 Jun 2020 15:49:31 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:9efe:9f1:9267:2b27])
        by smtp.gmail.com with ESMTPSA id a5sm14858353pfi.41.2020.06.22.15.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 15:49:30 -0700 (PDT)
Date:   Mon, 22 Jun 2020 15:49:28 -0700
From:   Fangrui Song <maskray@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Borislav Petkov <bp@suse.de>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] x86/boot: Warn on orphan section placement
Message-ID: <20200622224928.o2a7jkq33guxfci4@google.com>
References: <20200622205341.2987797-1-keescook@chromium.org>
 <20200622205341.2987797-4-keescook@chromium.org>
 <20200622220628.t5fklwmbtqoird5f@google.com>
 <202006221543.EA2FCFA2FF@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <202006221543.EA2FCFA2FF@keescook>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2020-06-22, Kees Cook wrote:
>On Mon, Jun 22, 2020 at 03:06:28PM -0700, Fangrui Song wrote:
>> LLD may report warnings for 3 synthetic sections if they are orphans:
>>
>> ld.lld: warning: <internal>:(.symtab) is being placed in '.symtab'
>> ld.lld: warning: <internal>:(.shstrtab) is being placed in '.shstrtab'
>> ld.lld: warning: <internal>:(.strtab) is being placed in '.strtab'
>>
>> Are they described?
>
>Perhaps:
>
>diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
>index db600ef218d7..57e9c142e401 100644
>--- a/include/asm-generic/vmlinux.lds.h
>+++ b/include/asm-generic/vmlinux.lds.h
>@@ -792,6 +792,9 @@
> 		.stab.exclstr 0 : { *(.stab.exclstr) }			\
> 		.stab.index 0 : { *(.stab.index) }			\
> 		.stab.indexstr 0 : { *(.stab.indexstr) }		\
>+		.symtab 0 : { *(.symtab) }				\
>+		.strtab 0 : { *(.strtab) }				\
>+		.shstrtab 0 : { *(.shstrtab) }				\
> 		.comment 0 : { *(.comment) }
>
> #ifdef CONFIG_GENERIC_BUG

This LGTM. Nit: .comment before .symtab is a more common order.

Reviewed-by: Fangrui Song <maskray@google.com>
