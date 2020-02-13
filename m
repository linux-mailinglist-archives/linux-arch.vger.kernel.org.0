Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91C0B15CA9F
	for <lists+linux-arch@lfdr.de>; Thu, 13 Feb 2020 19:45:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727761AbgBMSo7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 13 Feb 2020 13:44:59 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:39409 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgBMSo6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 13 Feb 2020 13:44:58 -0500
Received: by mail-oi1-f193.google.com with SMTP id z2so6828929oih.6;
        Thu, 13 Feb 2020 10:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VMfn8PswbJmJdlO37QEJbyEduZmdzRHRACLwl4PEk8k=;
        b=rXsK2+iVg+xAfKgvi8EJ+xRiZDZt0bawe08UY4AzUK/QxcpXAUmYzPuw5Qe7XCMnPS
         tZmzuVkVUVXxEupPwU/YXXodbsdKtthv4T+BBBq8URGrUJ1o7hAfIh0Sd9dohGvv5EIQ
         f53iQUD4rXqVzeH6ddG3CL1x4L51BMbJzNbBLADFJYxR4/0bW/ybjDX/REtyW/700YaR
         5oseD972Bfj3ZCtTInx+MQVCKJbE8Hka8ka9o7uuUqI5tAlVmhZ/zt5x5KcBppLqgUBF
         U6UrSKM3wIKl8sXU0LUGs+T/ABgd9EWNoteBxkwYi/Wo3FlcS8spkr8gU1uTDGoDHDgc
         O3jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VMfn8PswbJmJdlO37QEJbyEduZmdzRHRACLwl4PEk8k=;
        b=qUumq25N5+qeblBsL+BZkYd+56+/WLJDa1vrHR4ZzTz8ihhD2iQIeB6sJgVWuj8JGH
         hjswJHeCBU5egAiyZhfcsQi8tC7i+t6Pl0vWldvbvCiEUlc/yIN6qbb4dlLJCs/7uuvS
         l+63VmGmxX678/+6F+DIyIX0LZYb9uZACodEN0i1Zfjwegj8qhd+/gv4RMM48f98tMTQ
         8VixzxEUrRr1DapnfW7kmSI4qIrNVHgNzCKXXUozn1dCBaNTrtJnTz3paa9n+DsGjoLC
         4e8Ybn/HdEmKMWqkkE3FU/cO5X3ba2uCyB6s2MSRNUwLVgGH9QHPASf7xurbkafIs2VO
         5u0A==
X-Gm-Message-State: APjAAAXUN6fOtbn3+jghYF8eUo+vA+yk4CDTLuIhf3b11ZnhcKiIZLr5
        7t/W3pb5o12M9eRxUvasglc=
X-Google-Smtp-Source: APXvYqynTIfheT81Tmv6YGZbDN/SxN5IZ1aShJnYqGSRbGS5am4J0OAyqhZh6lHjOP9ROpiUTekYoA==
X-Received: by 2002:a05:6808:218:: with SMTP id l24mr3689993oie.108.1581619496475;
        Thu, 13 Feb 2020 10:44:56 -0800 (PST)
Received: from ubuntu-m2-xlarge-x86 ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id q5sm951383oia.21.2020.02.13.10.44.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Feb 2020 10:44:56 -0800 (PST)
Date:   Thu, 13 Feb 2020 11:44:54 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        clang-built-linux@googlegroups.com, x86@kernel.org,
        catalin.marinas@arm.com, will.deacon@arm.com, arnd@arndb.de,
        linux@armlinux.org.uk, paul.burton@mips.com, tglx@linutronix.de,
        luto@kernel.org, mingo@redhat.com, bp@alien8.de, sboyd@kernel.org,
        salyzyn@android.com, pcc@google.com, 0x7f454c46@gmail.com,
        ndesaulniers@google.com, avagin@openvz.org
Subject: Re: [PATCH 19/19] arm64: vdso32: Enable Clang Compilation
Message-ID: <20200213184454.GA4663@ubuntu-m2-xlarge-x86>
References: <20200213161614.23246-1-vincenzo.frascino@arm.com>
 <20200213161614.23246-20-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213161614.23246-20-vincenzo.frascino@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Feb 13, 2020 at 04:16:14PM +0000, Vincenzo Frascino wrote:
> Enable Clang Compilation for the vdso32 library.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
>  arch/arm64/kernel/vdso32/Makefile | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/vdso32/Makefile b/arch/arm64/kernel/vdso32/Makefile
> index 04df57b43cb1..209639101044 100644
> --- a/arch/arm64/kernel/vdso32/Makefile
> +++ b/arch/arm64/kernel/vdso32/Makefile
> @@ -11,8 +11,10 @@ include $(srctree)/lib/vdso/Makefile
>  # Same as cc-*option, but using CC_COMPAT instead of CC
>  ifeq ($(CONFIG_CC_IS_CLANG), y)
>  CC_COMPAT ?= $(CC)
> +LD_COMPAT ?= $(CROSS_COMPILE_COMPAT)gcc

Well this is unfortunate :/

It looks like adding the --target flag to VDSO_LDFLAGS allows
clang to link the vDSO just fine although it does warn that -nostdinc
is unused:

clang-11: warning: argument unused during compilation: '-nostdinc'
[-Wunused-command-line-argument]

It would be nice if the logic of commit fe00e50b2db8 ("ARM: 8858/1:
vdso: use $(LD) instead of $(CC) to link VDSO") could be adopted here
but I get that this Makefile is its own beast :) at the very least, I
think that the --target flag should be added to VDSO_LDFLAGS so that gcc
is not a requirement for this but I am curious if you tried that already
and noticed any issues with it.

Cheers,
Nathan

>  else
>  CC_COMPAT ?= $(CROSS_COMPILE_COMPAT)gcc
> +LD_COMPAT ?= $(CC_COMPAT)
>  endif
>  
>  cc32-option = $(call try-run,\
> @@ -171,7 +173,7 @@ quiet_cmd_vdsold_and_vdso_check = LD32    $@
>        cmd_vdsold_and_vdso_check = $(cmd_vdsold); $(cmd_vdso_check)
>  
>  quiet_cmd_vdsold = LD32    $@
> -      cmd_vdsold = $(CC_COMPAT) -Wp,-MD,$(depfile) $(VDSO_LDFLAGS) \
> +      cmd_vdsold = $(LD_COMPAT) -Wp,-MD,$(depfile) $(VDSO_LDFLAGS) \
>                     -Wl,-T $(filter %.lds,$^) $(filter %.o,$^) -o $@
>  quiet_cmd_vdsocc = CC32    $@
>        cmd_vdsocc = $(CC_COMPAT) -Wp,-MD,$(depfile) $(VDSO_CFLAGS) -c -o $@ $<
> -- 
> 2.25.0
> 
