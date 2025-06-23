Return-Path: <linux-arch+bounces-12431-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9FCDAE3F13
	for <lists+linux-arch@lfdr.de>; Mon, 23 Jun 2025 14:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E28C83B5A43
	for <lists+linux-arch@lfdr.de>; Mon, 23 Jun 2025 12:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93902571B0;
	Mon, 23 Jun 2025 12:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FQ0onncv"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D001255F39;
	Mon, 23 Jun 2025 12:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750680057; cv=none; b=gISxxIkWSQz/TZQUeYxrvjOy0xx8m0g4REl63pIaVX4Z5h1md/sbTIXf2dvNnTemUiissiClws68tXm2I5wGzd1wB5POAfLZ7b7G0jb+7H6/uPVZdSIqU/fFS+fiETOGFKKqJWSkuBSzlOQooatIt/9noBF0/Dehtzi46nAtg7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750680057; c=relaxed/simple;
	bh=S45BOtnpLY803LtSlt8cS8oUCjZlOAl7O/M8gBmSjZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bjNhai9p/dY7tOWMfdxeDXFHCKcz7/U+QaL0Topa3lAbmLa7R1cAqSjJLZ+gklM6u2JW3KBP4Eavnnw+JftyPR8ud3iurLQWSi3DFyCL4m4bPTm1D25iwQSHsRv/mDIRIEZp3eZEfkFEDSDtm5nSDHViV+vCqWihHczTsbx8w+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FQ0onncv; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750680053; x=1782216053;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=S45BOtnpLY803LtSlt8cS8oUCjZlOAl7O/M8gBmSjZo=;
  b=FQ0onncvokaVbfp2KxEZ2BzvduUfPnfIdy8L8D+Wv6zlXut6Hyh70KnM
   Mq9ybOWA+oQVEkxQDKN500eDUzQzSHxOstNAcTBR+bo7zpN0IxLrrKT/M
   XNhynDionERxMAc3Tb+xX2unYDjSBvzHgAYzcLHPhi6qUaTLwCzVvyDxI
   pkFgEE5U+VxMXzhiDN3juS7mGMTAjPKr5oob+iKZt1Ny+5PmKnLW70PZh
   3a10rpJEAF7SY/eQY1m7WTOxGJ/7FmX6Oe5rXczExGKHBl3qjIxcj9QOY
   VrQ8XzUPRHAi4f2Oru2S45+GpqNE4l0QnUSRQtvJd0RDTPl/dTOFfcIHQ
   Q==;
X-CSE-ConnectionGUID: Bv+33pXRQxSy87rK2cJwgg==
X-CSE-MsgGUID: cWZ3ZdUHRO6H2EQ7blW85A==
X-IronPort-AV: E=McAfee;i="6800,10657,11473"; a="52752404"
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; 
   d="scan'208";a="52752404"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 05:00:50 -0700
X-CSE-ConnectionGUID: ePnLZKKyST24ZYz8OIpbZw==
X-CSE-MsgGUID: jEmw7k6oSoywR5Gyh7kHWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; 
   d="scan'208";a="151761795"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 23 Jun 2025 05:00:47 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uTfqu-000O1q-0S;
	Mon, 23 Jun 2025 12:00:44 +0000
Date: Mon, 23 Jun 2025 19:59:52 +0800
From: kernel test robot <lkp@intel.com>
To: cp0613@linux.alibaba.com, yury.norov@gmail.com,
	linux@rasmusvillemoes.dk, arnd@arndb.de, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org, Chen Pei <cp0613@linux.alibaba.com>
Subject: Re: [PATCH 1/2] bitops: generic rotate
Message-ID: <202506231924.kPX5UiaD-lkp@intel.com>
References: <20250620111610.52750-2-cp0613@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250620111610.52750-2-cp0613@linux.alibaba.com>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on arnd-asm-generic/master]
[also build test WARNING on linus/master v6.16-rc3 next-20250623]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/cp0613-linux-alibaba-com/bitops-generic-rotate/20250620-192016
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git master
patch link:    https://lore.kernel.org/r/20250620111610.52750-2-cp0613%40linux.alibaba.com
patch subject: [PATCH 1/2] bitops: generic rotate
config: powerpc-allyesconfig (https://download.01.org/0day-ci/archive/20250623/202506231924.kPX5UiaD-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project 875b36a8742437b95f623bab1e0332562c7b4b3f)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250623/202506231924.kPX5UiaD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506231924.kPX5UiaD-lkp@intel.com/

All warnings (new ones prefixed by >>):

         |         ^
   In file included from drivers/net/ethernet/pensando/ionic/ionic_txrx.c:5:
   In file included from include/linux/ipv6.h:102:
   In file included from include/linux/tcp.h:19:
   In file included from include/net/sock.h:46:
   In file included from include/linux/netdevice.h:44:
   In file included from include/uapi/linux/neighbour.h:6:
   In file included from include/linux/netlink.h:9:
   In file included from include/net/scm.h:13:
   In file included from include/net/compat.h:8:
   include/linux/compat.h:458:22: warning: array index 1 is past the end of the array (that has type 'const unsigned long[1]') [-Warray-bounds]
     458 |         case 2: v.sig[3] = (set->sig[1] >> 32); v.sig[2] = set->sig[1];
         |                             ^        ~
   arch/powerpc/include/uapi/asm/signal.h:18:2: note: array 'sig' declared here
      18 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from drivers/net/ethernet/pensando/ionic/ionic_txrx.c:5:
   In file included from include/linux/ipv6.h:102:
   In file included from include/linux/tcp.h:19:
   In file included from include/net/sock.h:46:
   In file included from include/linux/netdevice.h:44:
   In file included from include/uapi/linux/neighbour.h:6:
   In file included from include/linux/netlink.h:9:
   In file included from include/net/scm.h:13:
   In file included from include/net/compat.h:8:
   include/linux/compat.h:458:10: warning: array index 3 is past the end of the array (that has type 'compat_sigset_word[2]' (aka 'unsigned int[2]')) [-Warray-bounds]
     458 |         case 2: v.sig[3] = (set->sig[1] >> 32); v.sig[2] = set->sig[1];
         |                 ^     ~
   include/linux/compat.h:130:2: note: array 'sig' declared here
     130 |         compat_sigset_word      sig[_COMPAT_NSIG_WORDS];
         |         ^
   include/linux/compat.h:458:42: warning: array index 2 is past the end of the array (that has type 'compat_sigset_word[2]' (aka 'unsigned int[2]')) [-Warray-bounds]
     458 |         case 2: v.sig[3] = (set->sig[1] >> 32); v.sig[2] = set->sig[1];
         |                                                 ^     ~
   include/linux/compat.h:130:2: note: array 'sig' declared here
     130 |         compat_sigset_word      sig[_COMPAT_NSIG_WORDS];
         |         ^
   include/linux/compat.h:458:53: warning: array index 1 is past the end of the array (that has type 'const unsigned long[1]') [-Warray-bounds]
     458 |         case 2: v.sig[3] = (set->sig[1] >> 32); v.sig[2] = set->sig[1];
         |                                                            ^        ~
   arch/powerpc/include/uapi/asm/signal.h:18:2: note: array 'sig' declared here
      18 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from drivers/net/ethernet/pensando/ionic/ionic_txrx.c:5:
   In file included from include/linux/ipv6.h:102:
   In file included from include/linux/tcp.h:20:
   In file included from include/net/inet_connection_sock.h:21:
   In file included from include/net/inet_sock.h:18:
   include/linux/jhash.h:83:3: error: call to undeclared function 'rol32'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      83 |                 __jhash_mix(a, b, c);
         |                 ^
   include/linux/jhash.h:37:16: note: expanded from macro '__jhash_mix'
      37 |         a -= c;  a ^= rol32(c, 4);  c += b;     \
         |                       ^
   include/linux/jhash.h:101:4: error: call to undeclared function 'rol32'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     101 |                  __jhash_final(a, b, c);
         |                  ^
   include/linux/jhash.h:48:15: note: expanded from macro '__jhash_final'
      48 |         c ^= b; c -= rol32(b, 14);              \
         |                      ^
   include/linux/jhash.h:129:3: error: call to undeclared function 'rol32'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     129 |                 __jhash_mix(a, b, c);
         |                 ^
   include/linux/jhash.h:37:16: note: expanded from macro '__jhash_mix'
      37 |         a -= c;  a ^= rol32(c, 4);  c += b;     \
         |                       ^
   include/linux/jhash.h:139:3: error: call to undeclared function 'rol32'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     139 |                 __jhash_final(a, b, c);
         |                 ^
   include/linux/jhash.h:48:15: note: expanded from macro '__jhash_final'
      48 |         c ^= b; c -= rol32(b, 14);              \
         |                      ^
   include/linux/jhash.h:156:2: error: call to undeclared function 'rol32'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     156 |         __jhash_final(a, b, c);
         |         ^
   include/linux/jhash.h:48:15: note: expanded from macro '__jhash_final'
      48 |         c ^= b; c -= rol32(b, 14);              \
         |                      ^
   In file included from drivers/net/ethernet/pensando/ionic/ionic_txrx.c:7:
   In file included from include/net/ip6_checksum.h:27:
   In file included from include/net/ip.h:30:
   In file included from include/net/route.h:24:
   In file included from include/net/inetpeer.h:16:
   include/net/ipv6.h:975:9: error: call to undeclared function 'rol32'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     975 |         hash = rol32(hash, 16);
         |                ^
   In file included from drivers/net/ethernet/pensando/ionic/ionic_txrx.c:7:
   In file included from include/net/ip6_checksum.h:27:
   include/net/ip.h:478:14: warning: default initialization of an object of type 'typeof (rt->dst.expires)' (aka 'const unsigned long') leaves the object uninitialized [-Wdefault-const-init-var-unsafe]
     478 |                 if (mtu && time_before(jiffies, rt->dst.expires))
         |                            ^
   include/linux/jiffies.h:138:26: note: expanded from macro 'time_before'
     138 | #define time_before(a,b)        time_after(b,a)
         |                                 ^
   include/linux/jiffies.h:128:3: note: expanded from macro 'time_after'
     128 |         (typecheck(unsigned long, a) && \
         |          ^
   include/linux/typecheck.h:11:12: note: expanded from macro 'typecheck'
      11 |         typeof(x) __dummy2; \
         |                   ^
>> drivers/net/ethernet/pensando/ionic/ionic_txrx.c:203:30: warning: implicit conversion from 'unsigned long' to 'u16' (aka 'unsigned short') changes value from 65536 to 0 [-Wconstant-conversion]
     203 |                 frag_len = min_t(u16, len, IONIC_PAGE_SIZE);
         |                            ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~
   drivers/net/ethernet/pensando/ionic/ionic_dev.h:184:32: note: expanded from macro 'IONIC_PAGE_SIZE'
     184 | #define IONIC_PAGE_SIZE                         MIN(PAGE_SIZE, IONIC_MAX_BUF_LEN)
         |                                                     ^
   include/vdso/page.h:15:30: note: expanded from macro 'PAGE_SIZE'
      15 | #define PAGE_SIZE       (_AC(1,UL) << CONFIG_PAGE_SHIFT)
         |                                    ^
   include/linux/minmax.h:314:30: note: expanded from macro 'MIN'
     314 | #define MIN(a, b) __cmp(min, a, b)
         |                              ^
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/minmax.h:161:52: note: expanded from macro 'min_t'
     161 | #define min_t(type, x, y) __cmp_once(min, type, x, y)
         |                           ~~~~~~~~~~~~~~~~~~~~~~~~~^~
   include/linux/minmax.h:89:33: note: expanded from macro '__cmp_once'
      89 |         __cmp_once_unique(op, type, x, y, __UNIQUE_ID(x_), __UNIQUE_ID(y_))
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:86:31: note: expanded from macro '__cmp_once_unique'
      86 |         ({ type ux = (x); type uy = (y); __cmp(op, ux, uy); })
         |                                ~~    ^
   drivers/net/ethernet/pensando/ionic/ionic_txrx.c:803:36: warning: implicit conversion from 'unsigned long' to 'u16' (aka 'unsigned short') changes value from 65536 to 0 [-Wconstant-conversion]
     803 |                 first_frag_len = min_t(u16, len, IONIC_PAGE_SIZE);
         |                                  ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~
   drivers/net/ethernet/pensando/ionic/ionic_dev.h:184:32: note: expanded from macro 'IONIC_PAGE_SIZE'
     184 | #define IONIC_PAGE_SIZE                         MIN(PAGE_SIZE, IONIC_MAX_BUF_LEN)
         |                                                     ^
   include/vdso/page.h:15:30: note: expanded from macro 'PAGE_SIZE'
      15 | #define PAGE_SIZE       (_AC(1,UL) << CONFIG_PAGE_SHIFT)
         |                                    ^
   include/linux/minmax.h:314:30: note: expanded from macro 'MIN'
     314 | #define MIN(a, b) __cmp(min, a, b)
         |                              ^
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/minmax.h:161:52: note: expanded from macro 'min_t'
     161 | #define min_t(type, x, y) __cmp_once(min, type, x, y)
         |                           ~~~~~~~~~~~~~~~~~~~~~~~~~^~
   include/linux/minmax.h:89:33: note: expanded from macro '__cmp_once'
      89 |         __cmp_once_unique(op, type, x, y, __UNIQUE_ID(x_), __UNIQUE_ID(y_))
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:86:31: note: expanded from macro '__cmp_once_unique'
      86 |         ({ type ux = (x); type uy = (y); __cmp(op, ux, uy); })
         |                                ~~    ^
   drivers/net/ethernet/pensando/ionic/ionic_txrx.c:838:38: warning: implicit conversion from 'unsigned long' to 'u16' (aka 'unsigned short') changes value from 65536 to 0 [-Wconstant-conversion]
     838 |                         frag_len = min_t(u16, remain_len, IONIC_PAGE_SIZE);
         |                                    ~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~
   drivers/net/ethernet/pensando/ionic/ionic_dev.h:184:32: note: expanded from macro 'IONIC_PAGE_SIZE'
     184 | #define IONIC_PAGE_SIZE                         MIN(PAGE_SIZE, IONIC_MAX_BUF_LEN)
         |                                                     ^
   include/vdso/page.h:15:30: note: expanded from macro 'PAGE_SIZE'
      15 | #define PAGE_SIZE       (_AC(1,UL) << CONFIG_PAGE_SHIFT)
         |                                    ^
   include/linux/minmax.h:314:30: note: expanded from macro 'MIN'
     314 | #define MIN(a, b) __cmp(min, a, b)
         |                              ^
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/minmax.h:161:52: note: expanded from macro 'min_t'
     161 | #define min_t(type, x, y) __cmp_once(min, type, x, y)
         |                           ~~~~~~~~~~~~~~~~~~~~~~~~~^~
   include/linux/minmax.h:89:33: note: expanded from macro '__cmp_once'
      89 |         __cmp_once_unique(op, type, x, y, __UNIQUE_ID(x_), __UNIQUE_ID(y_))
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:86:31: note: expanded from macro '__cmp_once_unique'
      86 |         ({ type ux = (x); type uy = (y); __cmp(op, ux, uy); })
         |                                ~~    ^
   16 warnings and 9 errors generated.


vim +203 drivers/net/ethernet/pensando/ionic/ionic_txrx.c

36a47c906b23240 Shannon Nelson 2024-03-06  174  
36a47c906b23240 Shannon Nelson 2024-03-06  175  static struct sk_buff *ionic_rx_build_skb(struct ionic_queue *q,
4dcd4575bfb17d0 Shannon Nelson 2024-03-06  176  					  struct ionic_rx_desc_info *desc_info,
f81da39bf4c0a54 Shannon Nelson 2024-02-14  177  					  unsigned int headroom,
f81da39bf4c0a54 Shannon Nelson 2024-02-14  178  					  unsigned int len,
f81da39bf4c0a54 Shannon Nelson 2024-02-14  179  					  unsigned int num_sg_elems,
180e35cdf035d1c Shannon Nelson 2024-02-14  180  					  bool synced)
0f3154e6bcb3549 Shannon Nelson 2019-09-03  181  {
4b0a7539a3728f0 Shannon Nelson 2021-03-10  182  	struct ionic_buf_info *buf_info;
08f2e4b2b2008ce Shannon Nelson 2019-10-23  183  	struct sk_buff *skb;
08f2e4b2b2008ce Shannon Nelson 2019-10-23  184  	unsigned int i;
08f2e4b2b2008ce Shannon Nelson 2019-10-23  185  	u16 frag_len;
08f2e4b2b2008ce Shannon Nelson 2019-10-23  186  
4b0a7539a3728f0 Shannon Nelson 2021-03-10  187  	buf_info = &desc_info->bufs[0];
e75ccac1d0644c9 Shannon Nelson 2021-07-27  188  	prefetchw(buf_info->page);
08f2e4b2b2008ce Shannon Nelson 2019-10-23  189  
89e572e7369fd9a Shannon Nelson 2021-03-10  190  	skb = napi_get_frags(&q_to_qcq(q)->napi);
89e572e7369fd9a Shannon Nelson 2021-03-10  191  	if (unlikely(!skb)) {
89e572e7369fd9a Shannon Nelson 2021-03-10  192  		net_warn_ratelimited("%s: SKB alloc failed on %s!\n",
36a47c906b23240 Shannon Nelson 2024-03-06  193  				     dev_name(q->dev), q->name);
2854242d23a7b3a Shannon Nelson 2024-03-06  194  		q_to_rx_stats(q)->alloc_err++;
08f2e4b2b2008ce Shannon Nelson 2019-10-23  195  		return NULL;
89e572e7369fd9a Shannon Nelson 2021-03-10  196  	}
ac8813c0ab7d281 Shannon Nelson 2024-09-06  197  	skb_mark_for_recycle(skb);
08f2e4b2b2008ce Shannon Nelson 2019-10-23  198  
f81da39bf4c0a54 Shannon Nelson 2024-02-14  199  	if (headroom)
36a47c906b23240 Shannon Nelson 2024-03-06  200  		frag_len = min_t(u16, len,
36a47c906b23240 Shannon Nelson 2024-03-06  201  				 IONIC_XDP_MAX_LINEAR_MTU + VLAN_ETH_HLEN);
f81da39bf4c0a54 Shannon Nelson 2024-02-14  202  	else
ac8813c0ab7d281 Shannon Nelson 2024-09-06 @203  		frag_len = min_t(u16, len, IONIC_PAGE_SIZE);
f81da39bf4c0a54 Shannon Nelson 2024-02-14  204  
36a47c906b23240 Shannon Nelson 2024-03-06  205  	if (unlikely(!buf_info->page))
36a47c906b23240 Shannon Nelson 2024-03-06  206  		goto err_bad_buf_page;
36a47c906b23240 Shannon Nelson 2024-03-06  207  	ionic_rx_add_skb_frag(q, skb, buf_info, headroom, frag_len, synced);
36a47c906b23240 Shannon Nelson 2024-03-06  208  	len -= frag_len;
4b0a7539a3728f0 Shannon Nelson 2021-03-10  209  	buf_info++;
4b0a7539a3728f0 Shannon Nelson 2021-03-10  210  
36a47c906b23240 Shannon Nelson 2024-03-06  211  	for (i = 0; i < num_sg_elems; i++, buf_info++) {
36a47c906b23240 Shannon Nelson 2024-03-06  212  		if (unlikely(!buf_info->page))
36a47c906b23240 Shannon Nelson 2024-03-06  213  			goto err_bad_buf_page;
ac8813c0ab7d281 Shannon Nelson 2024-09-06  214  		frag_len = min_t(u16, len, buf_info->len);
36a47c906b23240 Shannon Nelson 2024-03-06  215  		ionic_rx_add_skb_frag(q, skb, buf_info, 0, frag_len, synced);
36a47c906b23240 Shannon Nelson 2024-03-06  216  		len -= frag_len;
36a47c906b23240 Shannon Nelson 2024-03-06  217  	}
08f2e4b2b2008ce Shannon Nelson 2019-10-23  218  
08f2e4b2b2008ce Shannon Nelson 2019-10-23  219  	return skb;
36a47c906b23240 Shannon Nelson 2024-03-06  220  
36a47c906b23240 Shannon Nelson 2024-03-06  221  err_bad_buf_page:
36a47c906b23240 Shannon Nelson 2024-03-06  222  	dev_kfree_skb(skb);
36a47c906b23240 Shannon Nelson 2024-03-06  223  	return NULL;
0f3154e6bcb3549 Shannon Nelson 2019-09-03  224  }
0f3154e6bcb3549 Shannon Nelson 2019-09-03  225  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

