Return-Path: <linux-arch+bounces-5601-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AED5293ACA5
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jul 2024 08:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 665AC2838EA
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jul 2024 06:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D606C50A63;
	Wed, 24 Jul 2024 06:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="R24iF1lU"
X-Original-To: linux-arch@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735B94F615
	for <linux-arch@vger.kernel.org>; Wed, 24 Jul 2024 06:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721802601; cv=none; b=RKpk/ps+C7XvssMQJcby7zUE78qSWNr5dybX7M6nTzZgIuEeCKEgnN8+RzwVyJ0WEwKKlzUhH3/2zVqUrpmTw8fS2g1B98pKEf0MYg0kzWMNdNeZKcRpUzgm7jvgd5q45ZwdzS2K54ti8X4w3YA6vKWI8sxgUzICyk87NcH6kWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721802601; c=relaxed/simple;
	bh=L0mtDx1VUFwswhffo7XukUhtd3po+LW3dvP30M8KV6M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CITtq1OvGKOJJ9PDHkXKqB/EWvadofxrg2/b/FwjcIkRhkXJ6KMxAMgV7mvNFgUtksMg4KjgD6oorMWJSSzNy3Mv/RDW1GgmJB1B3TeIfW16VsVgKVDw8Gxf3cURUsaFsMtMIT23cLOArlFgYMyfB0QgVqYYVcsuHe963O1vUvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=R24iF1lU; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <79e896cc-4078-403d-b4c2-9d52e65e9e9a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721802597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fRL2yX4yUx6QZo1sb8qR2HPQF6k8pn9QttXtjz27+Nw=;
	b=R24iF1lUL1O6KI/u3ZLfaalGecBVtgIXPA+B29ebMHD27KFdjGCqrCJtlPD8+DozCEYU4N
	/FVsguCioroc3l78fZx53X4uwl1ucUV/LNLDxt8j8bNLka3/3f225foy9imc4qeZ+S+pht
	fQHzipVfjEbw/COiOq9Hnd9CkwEjSIY=
Date: Wed, 24 Jul 2024 14:29:44 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 2/4] btrfs: Use module_subinit{_noexit} and module_subeixt
 helper macros
To: kernel test robot <lkp@intel.com>, Arnd Bergmann <arnd@arndb.de>,
 Luis Chamberlain <mcgrof@kernel.org>, Chris Mason
 <chris.mason@fusionio.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>, tytso@mit.edu,
 Andreas Dilger <adilger.kernel@dilger.ca>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <yuchao0@huawei.com>, Chao Yu <chao@kernel.org>,
 Christoph Hellwig <hch@infradead.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, Youling Tang <tangyouling@kylinos.cn>
References: <20240723083239.41533-3-youling.tang@linux.dev>
 <202407240648.afyUbKEP-lkp@intel.com>
Content-Language: en-US, en-AU
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Youling Tang <youling.tang@linux.dev>
In-Reply-To: <202407240648.afyUbKEP-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 24/07/2024 06:24, kernel test robot wrote:
> Hi Youling,
>
> kernel test robot noticed the following build warnings:
>
> [auto build test WARNING on kdave/for-next]
> [also build test WARNING on linus/master next-20240723]
> [cannot apply to jaegeuk-f2fs/dev-test jaegeuk-f2fs/dev soc/for-next v6.10]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Youling-Tang/module-Add-module_subinit-_noexit-and-module_subeixt-helper-macros/20240723-164434
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
> patch link:    https://lore.kernel.org/r/20240723083239.41533-3-youling.tang%40linux.dev
> patch subject: [PATCH 2/4] btrfs: Use module_subinit{_noexit} and module_subeixt helper macros
> config: arm64-randconfig-004-20240724 (https://download.01.org/0day-ci/archive/20240724/202407240648.afyUbKEP-lkp@intel.com/config)
> compiler: aarch64-linux-gcc (GCC) 14.1.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240724/202407240648.afyUbKEP-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202407240648.afyUbKEP-lkp@intel.com/
>
> All warnings (new ones prefixed by >>):
>
>>> aarch64-linux-ld: warning: orphan section `.subexitcall.exit' from `fs/btrfs/super.o' being placed in section `.subexitcall.exit'
>>> aarch64-linux-ld: warning: orphan section `.subinitcall.init' from `fs/btrfs/super.o' being placed in section `.subinitcall.init'
>>> aarch64-linux-ld: warning: orphan section `.subexitcall.exit' from `fs/btrfs/super.o' being placed in section `.subexitcall.exit'
>>> aarch64-linux-ld: warning: orphan section `.subinitcall.init' from `fs/btrfs/super.o' being placed in section `.subinitcall.init'
>>> aarch64-linux-ld: warning: orphan section `.subexitcall.exit' from `fs/btrfs/super.o' being placed in section `.subexitcall.exit'
>>> aarch64-linux-ld: warning: orphan section `.subinitcall.init' from `fs/btrfs/super.o' being placed in section `.subinitcall.init'
The warning above is because arm64 does not use INIT_DATA_SECTION in link
scripts (some other architectures have similar problems), and it will be 
fixed
with the following changes:

```
diff --git a/arch/arc/kernel/vmlinux.lds.S b/arch/arc/kernel/vmlinux.lds.S
index 61a1b2b96e1d..2e3ce4c98550 100644
--- a/arch/arc/kernel/vmlinux.lds.S
+++ b/arch/arc/kernel/vmlinux.lds.S
@@ -66,6 +66,7 @@ SECTIONS
                 INIT_DATA
                 INIT_SETUP(L1_CACHE_BYTES)
                 INIT_CALLS
+               SUBINIT_CALL
                 CON_INITCALL
         }

diff --git a/arch/arm/kernel/vmlinux-xip.lds.S 
b/arch/arm/kernel/vmlinux-xip.lds.S
index c16d196b5aad..c9c2880db953 100644
--- a/arch/arm/kernel/vmlinux-xip.lds.S
+++ b/arch/arm/kernel/vmlinux-xip.lds.S
@@ -94,6 +94,7 @@ SECTIONS
         .init.rodata : {
                 INIT_SETUP(16)
                 INIT_CALLS
+               SUBINIT_CALL
                 CON_INITCALL
                 INIT_RAM_FS
         }
diff --git a/arch/arm64/kernel/vmlinux.lds.S 
b/arch/arm64/kernel/vmlinux.lds.S
index 55a8e310ea12..35549fb50cd2 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -256,6 +256,7 @@ SECTIONS
                 INIT_DATA
                 INIT_SETUP(16)
                 INIT_CALLS
+               SUBINIT_CALL
                 CON_INITCALL
                 INIT_RAM_FS
                 *(.init.altinstructions .init.bss)      /* from the EFI 
stub */
diff --git a/arch/microblaze/kernel/vmlinux.lds.S 
b/arch/microblaze/kernel/vmlinux.lds.S
index ae50d3d04a7d..113bbe4fe0fd 100644
--- a/arch/microblaze/kernel/vmlinux.lds.S
+++ b/arch/microblaze/kernel/vmlinux.lds.S
@@ -115,6 +115,10 @@ SECTIONS {
                 INIT_CALLS
         }

+       .subinitcall.init : AT(ADDR(.subinitcall.init) - LOAD_OFFSET ) {
+               SUBINIT_CALL
+       }
+
         .con_initcall.init : AT(ADDR(.con_initcall.init) - LOAD_OFFSET) {
                 CON_INITCALL
         }
diff --git a/arch/riscv/kernel/vmlinux-xip.lds.S 
b/arch/riscv/kernel/vmlinux-xip.lds.S
index 8c3daa1b0531..cfb108fe9d5c 100644
--- a/arch/riscv/kernel/vmlinux-xip.lds.S
+++ b/arch/riscv/kernel/vmlinux-xip.lds.S
@@ -55,6 +55,7 @@ SECTIONS
         .init.rodata : {
                 INIT_SETUP(16)
                 INIT_CALLS
+               SUBINIT_CALL
                 CON_INITCALL
                 INIT_RAM_FS
         }
diff --git a/arch/um/include/asm/common.lds.S 
b/arch/um/include/asm/common.lds.S
index fd481ac371de..59286d987936 100644
--- a/arch/um/include/asm/common.lds.S
+++ b/arch/um/include/asm/common.lds.S
@@ -48,6 +48,10 @@
         INIT_CALLS
    }

+  .subinitcall.init : {
+       SUBINIT_CALL
+  }
+
    .con_initcall.init : {
         CON_INITCALL
    }
diff --git a/arch/xtensa/kernel/vmlinux.lds.S 
b/arch/xtensa/kernel/vmlinux.lds.S
index f47e9bbbd291..1f4f921d9068 100644
--- a/arch/xtensa/kernel/vmlinux.lds.S
+++ b/arch/xtensa/kernel/vmlinux.lds.S
@@ -219,6 +219,7 @@ SECTIONS

      INIT_SETUP(XCHAL_ICACHE_LINESIZE)
      INIT_CALLS
+    SUBINIT_CALL
      CON_INITCALL
      INIT_RAM_FS
    }
```

