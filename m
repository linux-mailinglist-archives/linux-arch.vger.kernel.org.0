Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8C8526431F
	for <lists+linux-arch@lfdr.de>; Thu, 10 Sep 2020 12:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729781AbgIJKBF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Sep 2020 06:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730567AbgIJJzB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 10 Sep 2020 05:55:01 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04566C061799
        for <linux-arch@vger.kernel.org>; Thu, 10 Sep 2020 02:55:01 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id z9so5170221wmk.1
        for <linux-arch@vger.kernel.org>; Thu, 10 Sep 2020 02:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kBmlII5Vo//A9yPEJvnx3pKLF3xO4ua5qFTJHSq3g7w=;
        b=Mp48Y5o3UTjqc7GRbcTi2cjvv51nFGNvyAA5DE1UfeTL1TMGbjAHc4RUbolyjBcq78
         jLfYRxESN0S1R7j1vveSLWJeMYK+nJX28JhMyTmyicQtPHsq5swlYfpyW+55u5AoImfZ
         oBxeH5Lbwxs2v/dztAijetFrho1Wx6bVj+Oc/dkvUXrE5TyUZWh0epgiUpxiOto85MsG
         hTEOT+NcLacuqmR7JmXxY+IDVmr5voQ/ECTLxZvFSYbuWjRg4MsOVEUUgTnqbsR0HMQb
         V0et67mMhX/LXsQcKVGVYQwUkRusWYFa/RLbGrMSils0/fDIHW0nT7CA22W1u9F3htI4
         NkqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kBmlII5Vo//A9yPEJvnx3pKLF3xO4ua5qFTJHSq3g7w=;
        b=pcPk/Mzt4J5ZTurs46v6G5GfZ5OMzo8PnRkatOSwtmwm3qzMn+vA32vEmvKmXYyOoo
         sGzJkNH2+dYF+jc/EPXo2lLz7jD1RQncXVpIXjqsEyOv43mMQEJK2Qvzs/KpAeyOanGu
         PTS1uAy37iRTsC6EwCNVqjwstCT2Xr4tAIK4zjlo5bTBT4QjduV0fR1K+1kBK17zOjvk
         uwePTzXb2Rh1anOn/VL66obAmyNQYDcieNKGyw1kNjXJ2q2xh5vg9LyZIP/rz9CpORyX
         HnjWQMVf8JF4ZFLpyl0VakYHiy+bN9NI/FxszJZ3KtMQZf2hEMkkWDd0W12DT1O1T8pO
         1Jiw==
X-Gm-Message-State: AOAM531UKU3pt2WgCZgeufllClcB5GxzfL/rs5ypkO88Mq1h+pUZcFap
        qG9CXV9uHKY3kjSP3tYCKQIVQw==
X-Google-Smtp-Source: ABdhPJxw2J4g1tLxlXhkthydaDC7Hl8eCBStOVqNL7T4xvp4Dg/q8If7FlfLMGbTnCUpJcon0gm14g==
X-Received: by 2002:a7b:c14d:: with SMTP id z13mr7474778wmi.19.1599731699416;
        Thu, 10 Sep 2020 02:54:59 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:109:4a0f:cfff:fe4a:6363])
        by smtp.gmail.com with ESMTPSA id b76sm2975511wme.45.2020.09.10.02.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 02:54:58 -0700 (PDT)
Date:   Thu, 10 Sep 2020 10:54:54 +0100
From:   Andrew Scull <ascull@google.com>
To:     David Brazdil <dbrazdil@google.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Dennis Zhou <dennis@kernel.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Arnd Bergmann <arnd@arndb.de>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, linux-arch@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v2 02/10] kvm: arm64: Partially link nVHE hyp code,
 simplify HYPCOPY
Message-ID: <20200910095454.GB93664@google.com>
References: <20200903091712.46456-1-dbrazdil@google.com>
 <20200903091712.46456-3-dbrazdil@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903091712.46456-3-dbrazdil@google.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 03, 2020 at 11:17:04AM +0200, 'David Brazdil' via kernel-team wrote:
> Previous series introduced custom build rules for nVHE hyp code, using
> objcopy to prefix ELF section and symbol names to separate nVHE code
> into its own "namespace". This approach was limited by the expressiveness
> of objcopy's command line interface, eg. missing support for wildcards.
> 
> Improve the build rules by partially linking all '.hyp.o' files and
> prefixing their ELF section names using a linker script. Continue using
> objcopy for prefixing ELF symbol names.
> 
> One immediate advantage of this approach is that all subsections
> matching a pattern can be merged into a single prefixed section, eg.
> .text and .text.* can be linked into a single '.hyp.text'. This removes
> the need for -fno-reorder-functions on GCC and will be useful in the
> future too: LTO builds use .text subsections, compilers routinely
> generate .rodata subsections, etc.

This certaintly feels like a more robust and controlled approach to the
sections now that we have an explicit list of those that are allowed.

> Partially linking all hyp code into a single object file also makes it
> easier to analyze.
> 
> Signed-off-by: David Brazdil <dbrazdil@google.com>
> ---
>  arch/arm64/kvm/hyp/nvhe/Makefile  | 56 ++++++++++++++++---------------
>  arch/arm64/kvm/hyp/nvhe/hyp.lds.S | 14 ++++++++
>  2 files changed, 43 insertions(+), 27 deletions(-)
>  create mode 100644 arch/arm64/kvm/hyp/nvhe/hyp.lds.S
> 
> diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
> index aef76487edc2..1b2fbb19f3e8 100644
> --- a/arch/arm64/kvm/hyp/nvhe/Makefile
> +++ b/arch/arm64/kvm/hyp/nvhe/Makefile
> @@ -10,40 +10,42 @@ obj-y := timer-sr.o sysreg-sr.o debug-sr.o switch.o tlb.o hyp-init.o
>  obj-y += ../vgic-v3-sr.o ../aarch32.o ../vgic-v2-cpuif-proxy.o ../entry.o \
>  	 ../fpsimd.o ../hyp-entry.o
>  
> -obj-y := $(patsubst %.o,%.hyp.o,$(obj-y))
> -extra-y := $(patsubst %.hyp.o,%.hyp.tmp.o,$(obj-y))
> +##
> +## Build rules for compiling nVHE hyp code
> +## Output of this folder is `hyp.o`, a partially linked object file containing
> +## all nVHE hyp code and data.
> +##
>  
> -$(obj)/%.hyp.tmp.o: $(src)/%.c FORCE
> +hyp-obj := $(patsubst %.o,%.hyp.o,$(obj-y))
> +obj-y := hyp.o
> +extra-y := $(hyp-obj) hyp.tmp.o hyp.lds
> +
> +# 1) Compile all source files to `.hyp.o` object files. The file extension
> +#    avoids file name clashes for files shared with VHE.

Very much a nit, but possibly .nvhe.o or .kvm_nvhe.o would make the
intended distinction more obvious and line up with the prefix being
applied to the symbols.

> +$(obj)/%.hyp.o: $(src)/%.c FORCE
>  	$(call if_changed_rule,cc_o_c)
> -$(obj)/%.hyp.tmp.o: $(src)/%.S FORCE
> +$(obj)/%.hyp.o: $(src)/%.S FORCE
>  	$(call if_changed_rule,as_o_S)
> -$(obj)/%.hyp.o: $(obj)/%.hyp.tmp.o FORCE
> -	$(call if_changed,hypcopy)
>  
> -# Disable reordering functions by GCC (enabled at -O2).
> -# This pass puts functions into '.text.*' sections to aid the linker
> -# in optimizing ELF layout. See HYPCOPY comment below for more info.
> -ccflags-y += $(call cc-option,-fno-reorder-functions)
> +# 2) Compile linker script.
> +$(obj)/hyp.lds: $(src)/hyp.lds.S FORCE
> +	$(call if_changed_dep,cpp_lds_S)
> +
> +# 3) Partially link all '.hyp.o' files and apply the linker script.
> +#    Prefixes names of ELF sections with '.hyp', eg. '.hyp.text'.
> +LDFLAGS_hyp.tmp.o := -r -T $(obj)/hyp.lds
> +$(obj)/hyp.tmp.o: $(addprefix $(obj)/,$(hyp-obj)) $(obj)/hyp.lds FORCE
> +	$(call if_changed,ld)
> +
> +# 4) Produce the final 'hyp.o', ready to be linked into 'vmlinux'.
> +#    Prefixes names of ELF symbols with '__kvm_nvhe_'.
> +$(obj)/hyp.o: $(obj)/hyp.tmp.o FORCE
> +	$(call if_changed,hypcopy)
>  
>  # The HYPCOPY command uses `objcopy` to prefix all ELF symbol names
> -# and relevant ELF section names to avoid clashes with VHE code/data.
> -#
> -# Hyp code is assumed to be in the '.text' section of the input object
> -# files (with the exception of specialized sections such as
> -# '.hyp.idmap.text'). This assumption may be broken by a compiler that
> -# divides code into sections like '.text.unlikely' so as to optimize
> -# ELF layout. HYPCOPY checks that no such sections exist in the input
> -# using `objdump`, otherwise they would be linked together with other
> -# kernel code and not memory-mapped correctly at runtime.
> +# to avoid clashes with VHE code/data.
>  quiet_cmd_hypcopy = HYPCOPY $@
> -      cmd_hypcopy =							\
> -	if $(OBJDUMP) -h $< | grep -F '.text.'; then			\
> -		echo "$@: function reordering not supported in nVHE hyp code" >&2; \
> -		/bin/false;						\
> -	fi;								\
> -	$(OBJCOPY) --prefix-symbols=__kvm_nvhe_				\
> -		   --rename-section=.text=.hyp.text			\
> -		   $< $@
> +      cmd_hypcopy = $(OBJCOPY) --prefix-symbols=__kvm_nvhe_ $< $@
>  
>  # Remove ftrace and Shadow Call Stack CFLAGS.
>  # This is equivalent to the 'notrace' and '__noscs' annotations.
> diff --git a/arch/arm64/kvm/hyp/nvhe/hyp.lds.S b/arch/arm64/kvm/hyp/nvhe/hyp.lds.S
> new file mode 100644
> index 000000000000..aaa0ce133a32
> --- /dev/null
> +++ b/arch/arm64/kvm/hyp/nvhe/hyp.lds.S
> @@ -0,0 +1,14 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Linker script used during partial linking of nVHE EL2 object files.
> + * Written by David Brazdil <dbrazdil@google.com>
> + */

Should this file have the standard copyright line?

> +
> +/*
> + * Defines an ELF hyp section from input section @NAME and its subsections.
> + */
> +#define HYP_SECTION(NAME) .hyp##NAME : { *(NAME NAME##.[0-9a-zA-Z_]*) }
> +
> +SECTIONS {
> +	HYP_SECTION(.text)
> +}
> -- 
> 2.28.0.402.g5ffc5be6b7-goog
> 
> -- 
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
> 
