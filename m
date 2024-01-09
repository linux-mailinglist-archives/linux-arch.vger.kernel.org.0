Return-Path: <linux-arch+bounces-1318-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B3DA6828B98
	for <lists+linux-arch@lfdr.de>; Tue,  9 Jan 2024 18:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BEB8B20E8D
	for <lists+linux-arch@lfdr.de>; Tue,  9 Jan 2024 17:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113F53B7A8;
	Tue,  9 Jan 2024 17:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pBXR0hDI"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBFD38DF8;
	Tue,  9 Jan 2024 17:58:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFD56C433F1;
	Tue,  9 Jan 2024 17:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704823097;
	bh=jPQukDAtVbClY9EBeS+NqfHyLacDsIvaawr24NohtKA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pBXR0hDIxuyEvjXNm0ZHkn82qvWJPxEeg8vRLhUWpcgwAjyw9QDysog3LK2PVQult
	 9Go+Fi125jYvZDB64hW3vCXxDEcn1/BK+pt5NqtqqQKLTdqo9bY948RcuvcxU2solW
	 4vKCSzlftGX3C8MVRS35uscVo5/xKVpYDqx9lrU9Apjy76V+ddXDE8gB+2mmN0AuZf
	 oPcWHesQh5ieuYvzxayCuvHpRXx3KbE78X0kmN1z43HIDK8fHuuSm5D93GP6NTB/A2
	 otf9gtIxEuJz5XBV4wxvbQ8xXHf1BOfBSoPrqMAdPLvPhwTHpw3vbnYVN41E5sHJLi
	 jqPfsfuLkmYcA==
Date: Tue, 9 Jan 2024 10:58:14 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, ardb@kernel.org,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	bhelgaas@google.com, arnd@arndb.de, zohar@linux.ibm.com,
	dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
	serge@hallyn.com, javierm@redhat.com, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev, linux-arch@vger.kernel.org,
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v4 2/4] arch/x86: Move internal setup_data structures
 into setup_data.h
Message-ID: <20240109175814.GA5981@dev-arch.thelio-3990X>
References: <20240108095903.8427-3-tzimmermann@suse.de>
 <202401090800.UOBEKB3W-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202401090800.UOBEKB3W-lkp@intel.com>

On Tue, Jan 09, 2024 at 08:28:59AM +0800, kernel test robot wrote:
> Hi Thomas,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on tip/x86/core]
> [also build test WARNING on efi/next tip/master tip/auto-latest linus/master v6.7 next-20240108]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Thomas-Zimmermann/arch-x86-Move-UAPI-setup-structures-into-setup_data-h/20240108-180158
> base:   tip/x86/core
> patch link:    https://lore.kernel.org/r/20240108095903.8427-3-tzimmermann%40suse.de
> patch subject: [PATCH v4 2/4] arch/x86: Move internal setup_data structures into setup_data.h
> config: x86_64-rhel-8.3-bpf (https://download.01.org/0day-ci/archive/20240109/202401090800.UOBEKB3W-lkp@intel.com/config)
> compiler: ClangBuiltLinux clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240109/202401090800.UOBEKB3W-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202401090800.UOBEKB3W-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>    In file included from arch/x86/realmode/rm/wakemain.c:3:
>    In file included from arch/x86/boot/boot.h:24:
>    In file included from arch/x86/include/asm/setup.h:10:
>    In file included from arch/x86/include/asm/page_types.h:7:
>    In file included from include/linux/mem_encrypt.h:17:
>    In file included from arch/x86/include/asm/mem_encrypt.h:18:
>    In file included from arch/x86/include/uapi/asm/bootparam.h:5:
> >> arch/x86/include/asm/setup_data.h:10:20: warning: field 'data' with variable sized type 'struct setup_data' not at the end of a struct or class is a GNU extension [-Wgnu-variable-sized-type-not-at-end]
>       10 |         struct setup_data data;
>          |                           ^
>    1 warning generated.

I think this warning is expected. This structure is now included in the
realmode part of arch/x86, which has its own set of build flags,
including -Wall, which includes -Wgnu on clang. The kernel obviously
uses GNU extensions and states this clearly with '-std=gnu11', so
-Wno-gnu is unconditionally added to KBUILD_CFLAGS for clang. It seems
that same treatment is needed for REALMODE_CFLAGS, which also matches
arch/x86/boot/compressed/Makefile, see commit 6c3b56b19730 ("x86/boot:
Disable Clang warnings about GNU extensions"):

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 1a068de12a56..24076db59783 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -53,6 +53,9 @@ REALMODE_CFLAGS += -fno-stack-protector
 REALMODE_CFLAGS += -Wno-address-of-packed-member
 REALMODE_CFLAGS += $(cc_stack_align4)
 REALMODE_CFLAGS += $(CLANG_FLAGS)
+ifdef CONFIG_CC_IS_CLANG
+REALMODE_CFLAGS += -Wno-gnu
+endif
 export REALMODE_CFLAGS
 
 # BITS is used as extension for files which are available in a 32 bit

