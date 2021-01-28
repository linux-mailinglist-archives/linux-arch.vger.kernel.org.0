Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E15A430709F
	for <lists+linux-arch@lfdr.de>; Thu, 28 Jan 2021 09:09:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbhA1ICh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 28 Jan 2021 03:02:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232194AbhA1IAI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 28 Jan 2021 03:00:08 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FDD3C061574;
        Wed, 27 Jan 2021 23:59:21 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id l12so5212385ljc.3;
        Wed, 27 Jan 2021 23:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZhLAAud3HvOatZc8bWa160+GGDrtwAXLfmrfPeaVYS8=;
        b=iipPbsfxZVCoeVKuars96HlwaPhNMoxff6kXibVhpITK1M6liR5Y9O7+S15Bs18l09
         qlUtM1wTfg9Ou6I6g23AZm7cVsi8afl9ywua8K9yMdO5bZr9nt5kjWGTXEGzGKuOa9/g
         1XUmU2pb08XIkn2+EUpygz+rpS2BWuStq+kp1Z0L+RWjtUcubBnlDUTz5WKp9v7710os
         SLNWgHiJ3JIV+8IAHjWh/nhAgSk/YRdA5r5xJzX10KabfIVPeT0lFPft9QR1HE2XX97r
         YL6s2qMMPrVFtgVS0PASinY6oq3v5br43OEKFxy7K4ebWVUxXV6rGDy0rY0fMsVaCwye
         p0Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ZhLAAud3HvOatZc8bWa160+GGDrtwAXLfmrfPeaVYS8=;
        b=pN7U5ayKK/5sWgKJajDwgbMe8oZmnkj5Fp3s/iZsY8CifS6Me08uX7SipdDw7CeoaR
         VNhn9E8cDytM0IiGEhtWtbZQ3AZHvUBjewbZI/W2/DiGl6yTN+tkIFu5DH3YyCu9+hh7
         gYwRud3ruesYNpda2PE4F5GUgYufPY36wAuJHucDDYEOj9iA9jf0gZwuvIdEh5lMRoFu
         XsyVOFe0TZfOgVYTZSeasCbEMasthSzVQKCYq67+0Zw622MibMPyXxLYsPF0lPSr8nny
         ACdv1rCn5x1fzDLWnCQq8SH8N71clIGzP2IsncPEASzOippulsQn2V6yADX/lq+HRxhJ
         4k1w==
X-Gm-Message-State: AOAM531I4BQCnba6xiWms7ArJFMKyRLi6vQyzQ6xe9GguVVj3rr1bglc
        SKZRRshpTzk13W+xiVHNGFXC9zXZSYhsgQ==
X-Google-Smtp-Source: ABdhPJyNhfosDqTVmWD8kXJOJ9HDxIw2bv3pFQwo469kI3mpp/ZSh90Ay+X1biZCj8UPTr2AxhJ8ug==
X-Received: by 2002:a2e:b6cc:: with SMTP id m12mr7769208ljo.401.1611820759903;
        Wed, 27 Jan 2021 23:59:19 -0800 (PST)
Received: from [192.168.1.100] ([178.176.79.159])
        by smtp.gmail.com with ESMTPSA id z23sm1635056ljj.25.2021.01.27.23.59.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jan 2021 23:59:19 -0800 (PST)
Subject: Re: [PATCH 02/27] x86/syscalls: fix -Wmissing-prototypes warnings
 from COND_SYSCALL()
To:     Masahiro Yamada <masahiroy@kernel.org>, linux-arch@vger.kernel.org,
        x86@kernel.org
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-um@lists.infradead.org,
        linux-xtensa@linux-xtensa.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org
References: <20210128005110.2613902-1-masahiroy@kernel.org>
 <20210128005110.2613902-3-masahiroy@kernel.org>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Organization: Brain-dead Software
Message-ID: <dd37a7f2-55e1-2e96-0c93-4a40980b8ef2@gmail.com>
Date:   Thu, 28 Jan 2021 10:59:07 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210128005110.2613902-3-masahiroy@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hello!

On 28.01.2021 3:50, Masahiro Yamada wrote:

> Building kernel/sys_ni.c with W=1 omits tons of -Wmissing-prototypes

    Emits?

> warnings.
> 
> $ make W=1 kernel/sys_ni.o
>    [ snip ]
>    CC      kernel/sys_ni.o
> In file included from kernel/sys_ni.c:10:
> ./arch/x86/include/asm/syscall_wrapper.h:83:14: warning: no previous prototype for '__x64_sys_io_setup' [-Wmissing-prototypes]
>     83 |  __weak long __##abi##_##name(const struct pt_regs *__unused) \
>        |              ^~
> ./arch/x86/include/asm/syscall_wrapper.h:100:2: note: in expansion of macro '__COND_SYSCALL'
>    100 |  __COND_SYSCALL(x64, sys_##name)
>        |  ^~~~~~~~~~~~~~
> ./arch/x86/include/asm/syscall_wrapper.h:256:2: note: in expansion of macro '__X64_COND_SYSCALL'
>    256 |  __X64_COND_SYSCALL(name)     \
>        |  ^~~~~~~~~~~~~~~~~~
> kernel/sys_ni.c:39:1: note: in expansion of macro 'COND_SYSCALL'
>     39 | COND_SYSCALL(io_setup);
>        | ^~~~~~~~~~~~
> ./arch/x86/include/asm/syscall_wrapper.h:83:14: warning: no previous prototype for '__ia32_sys_io_setup' [-Wmissing-prototypes]
>     83 |  __weak long __##abi##_##name(const struct pt_regs *__unused) \
>        |              ^~
> ./arch/x86/include/asm/syscall_wrapper.h:120:2: note: in expansion of macro '__COND_SYSCALL'
>    120 |  __COND_SYSCALL(ia32, sys_##name)
>        |  ^~~~~~~~~~~~~~
> ./arch/x86/include/asm/syscall_wrapper.h:257:2: note: in expansion of macro '__IA32_COND_SYSCALL'
>    257 |  __IA32_COND_SYSCALL(name)
>        |  ^~~~~~~~~~~~~~~~~~~
> kernel/sys_ni.c:39:1: note: in expansion of macro 'COND_SYSCALL'
>     39 | COND_SYSCALL(io_setup);
>        | ^~~~~~~~~~~~
>    ...
> 
> __SYS_STUB0() and __SYS_STUBx() defined a few lines above have forward
> declarations. Let's do likewise for __COND_SYSCALL() to fix the
> warnings.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>   arch/x86/include/asm/syscall_wrapper.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/include/asm/syscall_wrapper.h b/arch/x86/include/asm/syscall_wrapper.h
> index a84333adeef2..80c08c7d5e72 100644
> --- a/arch/x86/include/asm/syscall_wrapper.h
> +++ b/arch/x86/include/asm/syscall_wrapper.h
> @@ -80,6 +80,7 @@ extern long __ia32_sys_ni_syscall(const struct pt_regs *regs);
>   	}
>   
>   #define __COND_SYSCALL(abi, name)					\
> +	__weak long __##abi##_##name(const struct pt_regs *__unused);	\
>   	__weak long __##abi##_##name(const struct pt_regs *__unused)	\

    Aren't these two lines identical?

[...]

MBR, Sergei
