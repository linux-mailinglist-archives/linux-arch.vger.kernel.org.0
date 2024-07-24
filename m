Return-Path: <linux-arch+bounces-5599-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 859EB93AB00
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jul 2024 04:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04B25B22FAF
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jul 2024 02:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78CE614006;
	Wed, 24 Jul 2024 02:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="h0HlnRfz"
X-Original-To: linux-arch@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683AD17547
	for <linux-arch@vger.kernel.org>; Wed, 24 Jul 2024 02:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721787313; cv=none; b=MRWzquJMQuDE2vs6mKcYD7EWb1BOaoXYJNfvgBtyg7pqcCtOARiiSLx8MZAy9rAhBeoRZITK7IBfxl6g8vlOU/sGmrbEmcE1IWKt8vq/KBebc7pTWo0/ujiKcRChVwd5cwv2rW/hlQ0EKPklALL2ACBqApdNKjMNTRoSE8lF6as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721787313; c=relaxed/simple;
	bh=O96nVOKIorM7OixK34nGovVkLbLQd2lGu7pSs49Y5Xw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fFnY2NSr7BCCPvyE3rFgm89hHKAetyYDdyNlhGu5SLdG6q6RPyXgdlehS0zMyWKruR+n1d+lyVyRREU/3oYqbOx1FNUeR5MCrTgmnEUlzC/Rgkx1OpgKuC1LT89SVTUqVgJ4VcuviHW19KxuftpFejU1VdOvveQdcWX7tWKjkmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=h0HlnRfz; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4b932baf-9b43-42cd-9d9b-8048009d6d42@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721787309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MLUfk9gi7OCPJH9Y7tsnfPUpLHamp4aWw3nheTJInOk=;
	b=h0HlnRfzLN2pF/0Djo3ulN2R/8hakmdUblUS8AMiDZvzdfcac3jnIdfoJnkofQkSy/5Kv4
	ruGT11NG/QXJU/JV90HgCY8W5hKXZ0PjyFwlGHLGr9cVWDehFUhwydQ4hZWs/TacOJtqIQ
	s6MbaR10dt+l4Zl2DHJZxMX7IgFCLUc=
Date: Wed, 24 Jul 2024 10:14:58 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 4/4] f2fs: Use module_{subinit, subeixt} helper macros
To: kernel test robot <lkp@intel.com>, Arnd Bergmann <arnd@arndb.de>,
 Luis Chamberlain <mcgrof@kernel.org>, Chris Mason
 <chris.mason@fusionio.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>, tytso@mit.edu,
 Andreas Dilger <adilger.kernel@dilger.ca>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <yuchao0@huawei.com>, Chao Yu <chao@kernel.org>,
 Christoph Hellwig <hch@infradead.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-modules@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 Youling Tang <tangyouling@kylinos.cn>
References: <20240723083239.41533-5-youling.tang@linux.dev>
 <202407240204.KcPiCniO-lkp@intel.com>
Content-Language: en-US, en-AU
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Youling Tang <youling.tang@linux.dev>
In-Reply-To: <202407240204.KcPiCniO-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 24/07/2024 02:51, kernel test robot wrote:
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
> patch link:    https://lore.kernel.org/r/20240723083239.41533-5-youling.tang%40linux.dev
> patch subject: [PATCH 4/4] f2fs: Use module_{subinit, subeixt} helper macros
> config: i386-buildonly-randconfig-004-20240724 (https://download.01.org/0day-ci/archive/20240724/202407240204.KcPiCniO-lkp@intel.com/config)
> compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240724/202407240204.KcPiCniO-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202407240204.KcPiCniO-lkp@intel.com/
>
> All warnings (new ones prefixed by >>):
>
>     In file included from fs/f2fs/node.c:16:
>>> fs/f2fs/f2fs.h:4131:57: warning: non-void function does not return a value [-Wreturn-type]
>      4131 | static inline int __init f2fs_create_root_stats(void) { }

I'll fix it later.
static inline int __init f2fs_create_root_stats(void) { return 0; }
>           |                                                         ^
>     1 warning generated.
> --
>     In file included from fs/f2fs/data.c:25:
>>> fs/f2fs/f2fs.h:4131:57: warning: non-void function does not return a value [-Wreturn-type]
>      4131 | static inline int __init f2fs_create_root_stats(void) { }
>           |                                                         ^
>     fs/f2fs/data.c:2373:10: warning: variable 'index' set but not used [-Wunused-but-set-variable]
>      2373 |         pgoff_t index;
>           |                 ^
>     2 warnings generated.
index = folio_index(folio);
This statement should be moved to CONFIG_F2FS_FS_COMPRESSION.

I'll send a separate patch to fix it if it needs to be modified.

