Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD9D124E1BD
	for <lists+linux-arch@lfdr.de>; Fri, 21 Aug 2020 22:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726737AbgHUUCD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Aug 2020 16:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbgHUUCD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Aug 2020 16:02:03 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C65C061573;
        Fri, 21 Aug 2020 13:02:03 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id d14so2429369qke.13;
        Fri, 21 Aug 2020 13:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TPOt76AEuXIQt1E+8hC9FNGB9En2HYeoQvtbHdl/m1g=;
        b=cFHRVbfk774qVr9x3mqS5vqcqh4uuZR3AktkRKIYSbrK/h6eTE8iTn3Eszc8EU5VU4
         H2gBX0hwAajvgJkpnxJzEPZCh94gbkzOVt+ZveLrWKElY7x28RT/g51x+SukMSCeeINg
         HZvWl4elaNCaYwDed/Z0Vi4QHqie2XI2XiXN35MWwFN1l394xqNEFKcchxE11pXAGn9m
         nJ6X4fA4xIO+NOhv34wJ10ixswyFiVLdeml9cwaPWhfYsQ4zWLHmdRMhrsC5B1zdAvSO
         vvdZ6jLj7HQCdxyGI4xYcdJwoIdN9f91NDDlkyL/QXjpshXpCtguxWzEgk1JvLMc5BiP
         NorA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=TPOt76AEuXIQt1E+8hC9FNGB9En2HYeoQvtbHdl/m1g=;
        b=By/lg7wN0OPsZXKYDQkjjrjmYT/iOeI9SGd1IRUCc/q8bLWoOnebWKVhwk1c0v37CW
         IQqOVVFfWKqIAHLR6e7Vmz0j/0YtNxhABERvj9wgGanjN9iY+3d+dD0K3o15+NNtGCGG
         dlNUXfBTNvywDdEEH9ixDCb5dsodGbJ9AwjFUX4r08DdxQ8ytjCp0QEF+1ZxipXP8nov
         ItAmriXlgyfTMIp7uIIX5wM4rVWzEEC1kB9rGgsMi5Vfx6KyaIhGlJxPdj1OIDKIU/RV
         JmlXWSULUl03o19ZD95UD3z+iG1efWZ5hcLmQfgHrvRTLPQLolAWxJDC0yaKpBBeGDeA
         w9aA==
X-Gm-Message-State: AOAM531xjAa6vgCassh5ItihqKL1Ss+1CPpz3k4pZ6p2+L40USghsSBP
        ONnCNlYpGRYYu2kWm1Pr8o0=
X-Google-Smtp-Source: ABdhPJzZMA2ESypf7UBk0PGzEz41wGwqm+M4H7u2kSTHaPem1ioXNXWIIvmjsMySROa1IgLhZylzMg==
X-Received: by 2002:a05:620a:201a:: with SMTP id c26mr4160170qka.155.1598040121471;
        Fri, 21 Aug 2020 13:02:01 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id c142sm2528839qkg.71.2020.08.21.13.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 13:02:01 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Fri, 21 Aug 2020 16:01:59 -0400
To:     Kees Cook <keescook@chromium.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
        Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
        clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 27/29] x86/boot/compressed: Remove, discard, or assert
 for unwanted sections
Message-ID: <20200821200159.GC1475504@rani.riverdale.lan>
References: <20200821194310.3089815-1-keescook@chromium.org>
 <20200821194310.3089815-28-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200821194310.3089815-28-keescook@chromium.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Aug 21, 2020 at 12:43:08PM -0700, Kees Cook wrote:
> In preparation for warning on orphan sections, stop the linker from
> generating the .eh_frame* sections, discard unwanted non-zero-sized
> generated sections, and enforce other expected-to-be-zero-sized sections
> (since discarding them might hide problems with them suddenly gaining
> unexpected entries).
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
>  	.rel.dyn : {
> -		*(.rel.*)
> +		*(.rel.*) *(.rel_*)
>  	}
>  	ASSERT(SIZEOF(.rel.dyn) == 0, "Unexpected run-time relocations (.rel) detected!")
>  
>  	.rela.dyn : {
> -		*(.rela.*)
> +		*(.rela.*) *(.rela_*)
>  	}
>  	ASSERT(SIZEOF(.rela.dyn) == 0, "Unexpected run-time relocations (.rela) detected!")
>  }
> -- 
> 2.25.1
> 

When do you get .rela_?
