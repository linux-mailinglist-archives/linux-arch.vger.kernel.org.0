Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7652628682B
	for <lists+linux-arch@lfdr.de>; Wed,  7 Oct 2020 21:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbgJGTUL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Oct 2020 15:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728034AbgJGTUK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 7 Oct 2020 15:20:10 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11BFC061755
        for <linux-arch@vger.kernel.org>; Wed,  7 Oct 2020 12:20:10 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kQEyn-001960-Tl; Wed, 07 Oct 2020 21:20:02 +0200
Message-ID: <52dec5e578550efa0b8abbbabcf45d7ef7845c52.camel@sipsolutions.net>
Subject: Re: [RFC v7 16/21] um: nommu: plug in the build system
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Hajime Tazaki <thehajime@gmail.com>, linux-um@lists.infradead.org,
        jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com
Cc:     tavi.purdila@gmail.com, linux-kernel-library@freelists.org,
        linux-arch@vger.kernel.org, retrage01@gmail.com
Date:   Wed, 07 Oct 2020 21:20:00 +0200
In-Reply-To: <714783a8d1d6aace7d0e315fc12ffc60b5867ada.1601960644.git.thehajime@gmail.com>
References: <cover.1601960644.git.thehajime@gmail.com>
         <714783a8d1d6aace7d0e315fc12ffc60b5867ada.1601960644.git.thehajime@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 2020-10-06 at 18:44 +0900, Hajime Tazaki wrote:
> Basic Makefiles for building library of nommu mode. Add a new architecture
> specific target for installing the resulting library files and headers.
> 
> To make nommu binaries build, UML introduced an additional option, UMMODE
> variable, to switch the output file of build: kernel (default), or
> library (nommu).  Those modes are not able to be ON at the same time.

Here you did that again :)

I think you should really be up-front about it and call it "kernel" and
"library" mode. Then do the ifdefs on library mode etc.

Sure, kernel mode will be CONFIG_MMU=y and library mode will be
!CONFIG_MMU instead, but it really makes more sense to call things
CONFIG_UMMODE_LIB in most cases, I think?

Yes, a lot of stuff *does* depend on CONFIG_MMU, and that still makes
sense. It just feels like a lot of stuff you made depend on CONFIG_MMU
here (or !CONFIG_MMU) really isn't related too much to that, rather than
being related to "library mode".

>   make defconfig ARCH=um UMMODE=library
>   make ARCH=um UMMODE=library

Why not make it a real Kconfig symbol? I find the ARCH=um tricky enough
to remember all the time, so much I usually write a "GNUmakefile" with

export ARCH=um
include Makefile

:-)

> +config UMMODE_LIB
> +	bool "UML mode: library mode"
> +	default y if "$(UMMODE)" = "library"

So wait, you _can_ switch that through Kconfig then, because you made it
a visible option (string after "bool"). But it won't work, because then
you later in the build system etc. still check UMMODE instead of
CONFIG_UMMODE_LIB. Seems like something that ought to be fixed one way
or the other - at the very least hide this symbol if setting it manually
is invalid.

> +	help
> +	 This mode switches a mode to build a library of UML (Linux
> +	 Kernel Library/LKL).  This switch is exclusive to "kernel mode"
> +	 of UML, which is traditional mode of UML.

Not sure if that historically made more sense, but you don't have any
UMMODE_KERNEL option or something like that, so the help text seems
confusing?


> +	 For more detail about LKL, see
> +	 <file:Documentation/virt/uml/lkl.txt>.
> +
>  config MMU
>  	bool
> -	default y
> +	default y if !UMMODE_LIB
>  
>  config NO_IOMEM
>  	def_bool y
> @@ -45,12 +56,12 @@ config LOCKDEP_SUPPORT
>  
>  config STACKTRACE_SUPPORT
>  	bool
> -	default y
> +	default y if MMU

Same as what I said above - there really shouldn't be any inherent
reason why STACKTRACE_SUPPORT depends on CONFIG_MMU, is there? Apart
from not having implemented it in UMMODE_LIB, that is, and then you
should make this if !UMMODE_LIB?

>  config GENERIC_CALIBRATE_DELAY
>  	bool
> -	default y
> +	default y if MMU

Same here. This one _surely_ has no relation to MMU.

> +ifeq ($(UMMODE),library)
> +  SUBARCH := um/nommu
> +endif

>  INSTALL_PATH=$(objtree)/tools/um
> +ifeq ($(UMMODE),library)

Here a few places using UMMODE which must come from the command line.

>  linux.o: vmlinux
>  	@echo '  LINK	$@'
> -	$(Q)$(OBJCOPY) -R .eh_frame $< $@
> +	$(Q)$(OBJCOPY) -R .eh_frame -L sem_init -L sem_post -L sem_wait -L sem_destroy $< $@

Care to explain?

>  	$(Q)mkdir -p $(objtree)/tools/um/lib
>  
>  define archhelp
> diff --git a/arch/um/kernel/Makefile b/arch/um/kernel/Makefile
> index 9b63831a69e1..01605ed439cb 100644
> --- a/arch/um/kernel/Makefile
> +++ b/arch/um/kernel/Makefile
> @@ -14,17 +14,21 @@ CPPFLAGS_vmlinux.lds := -DSTART=$(LDS_START)		\
>  			$(LDS_EXTRA)
>  extra-y := vmlinux.lds
>  
> -obj-y = config.o exec.o exitcode.o irq.o ksyms.o mem.o \
> -	physmem.o process.o ptrace.o reboot.o sigio.o \
> -	signal.o syscall.o sysrq.o time.o tlb.o trap.o \
> -	um_arch.o umid.o maccess.o kmsg_dump.o skas/
> +obj-y = config.o exitcode.o irq.o ksyms.o \
> +	process.o reboot.o sigio.o \
> +	signal.o syscall.o time.o \
> +	um_arch.o umid.o maccess.o kmsg_dump.o
> +
> +ifdef CONFIG_MMU
> +obj-y += exec.o mem.o physmem.o ptrace.o sysrq.o tlb.o trap.o skas/
> +endif
>  
>  obj-$(CONFIG_BLK_DEV_INITRD) += initrd.o
>  obj-$(CONFIG_GPROF)	+= gprof_syms.o
>  obj-$(CONFIG_GCOV)	+= gmon_syms.o
>  obj-$(CONFIG_EARLY_PRINTK) += early_printk.o
>  obj-$(CONFIG_STACKTRACE) += stacktrace.o
> -obj-y += user_syms.o
> +obj-$(CONFIG_MMU) += user_syms.o
>  
>  USER_OBJS := config.o
>  
> diff --git a/arch/um/nommu/um/Kconfig b/arch/um/nommu/um/Kconfig
> new file mode 100644
> index 000000000000..20b3eaccb6f0
> --- /dev/null
> +++ b/arch/um/nommu/um/Kconfig
> @@ -0,0 +1,37 @@
> +config UML_NOMMU
> +	def_bool y
> +	depends on !SMP && !MMU

again, using MMU to mean "LKL" (both UML_NOMMU and !MMU places)

> +	select UACCESS_MEMCPY
> +	select ARCH_THREAD_STACK_ALLOCATOR
> +	select ARCH_HAS_SYSCALL_WRAPPER

You never use this except for the selects, maybe can go elsewhere?

> +config 64BIT
> +	bool
> +	default y
> +
> +config GENERIC_CSUM
> +	def_bool y
> +
> +config GENERIC_ATOMIC64
> +	bool
> +	default y if !64BIT
> +
> +config SECCOMP
> +	bool
> +	default n
> +
> +config GENERIC_HWEIGHT
> +	def_bool y
> +
> +config GENERIC_CALIBRATE_DELAY
> +	bool
> +	default n
> +
> +config STACKTRACE_SUPPORT
> +	bool
> +	default n

You ... were just changing these elsewhere, so one of that isn't needed?

> +# XXX: need this to work well with tap13.py

What's tap13.py??

johannes

