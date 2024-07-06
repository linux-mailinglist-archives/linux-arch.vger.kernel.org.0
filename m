Return-Path: <linux-arch+bounces-5289-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 649E89292B9
	for <lists+linux-arch@lfdr.de>; Sat,  6 Jul 2024 13:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0C46B21B5C
	for <lists+linux-arch@lfdr.de>; Sat,  6 Jul 2024 11:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6184B73509;
	Sat,  6 Jul 2024 11:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CwJo5WNx"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1980454907;
	Sat,  6 Jul 2024 11:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720264429; cv=none; b=r2Ka65TENhXaATDYMUSLaB8qIiVQa6jPBWcebLn5U+ANzBdThbfKmEWPO4lIK5gBd14+o9B0uPwB9W4arEV8TP9+4S2x7Ds2Zwc4LMcYSDMZvOmYZrR/xmX9kpP+Cy55WtDa7yZy8u3FnCkSXwYMS6F27lCuOBW1NdGTDOSfbpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720264429; c=relaxed/simple;
	bh=gTn1gxChF+AnLmVYi9zYChJ2t7bCR+Q5zs+W+Sfp71Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=heJOnXHlJ/KqUR93sBfkRf5pHz54Ij98qu8YQKxkVS5G50pZZLBSiN87a7aOHyMf5OX0iGMdPThivzO6qH5dk0u5Z9lqFUaqlTv/Um67i57xuYfZKXjAIcypJWOEjuTIKcllMsYvH5GSLf9Hl6M+Tobg/onFBhBNYNs+mMM/xjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CwJo5WNx; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720264428; x=1751800428;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gTn1gxChF+AnLmVYi9zYChJ2t7bCR+Q5zs+W+Sfp71Y=;
  b=CwJo5WNxtzwlELuptrgCDCH4GRn7t4mbimlTulXbvoskChwbK0fobWw5
   9nTJoYmR+z/dxaNY7DZSvyiMQz1JSGJZ20nAhhuTf5qxf15sXkFk7+9ci
   anHH5D8ZfgnTp3g5C5VWlaL9YwYg8vNLhrLELbj+Xw5zBOFKmFMgNVS+3
   l6gynt7noMIEekv4DvdX0jTP+XnUuyQDsV/LjA2HBjCCaP8hm+8O0OkAO
   TCWipibnQ+sveCz5sTWEYtdsV1Z2o+Ip3qC0zQ3gAQRubdZrsKO2taZhU
   hNF2RUOnJYVQ1LYKBEz7fwWGsKfZxkiK7RW71zPCJVrczoa9Z5CPSFprB
   A==;
X-CSE-ConnectionGUID: gZYW64yERVyNqojL0fgnaQ==
X-CSE-MsgGUID: f/TaXTUtTPmSSF5f1foBwg==
X-IronPort-AV: E=McAfee;i="6700,10204,11123"; a="17348120"
X-IronPort-AV: E=Sophos;i="6.09,187,1716274800"; 
   d="scan'208";a="17348120"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2024 04:13:47 -0700
X-CSE-ConnectionGUID: ncFW8IFhRb2LNx+hL5z19Q==
X-CSE-MsgGUID: Rl78OCbuQf+8QE+nwI3lSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,187,1716274800"; 
   d="scan'208";a="47028304"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 06 Jul 2024 04:13:44 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sQ3ML-000Thg-2k;
	Sat, 06 Jul 2024 11:13:41 +0000
Date: Sat, 6 Jul 2024 19:13:41 +0800
From: kernel test robot <lkp@intel.com>
To: Nicolas Pitre <nico@fluxnic.net>, Arnd Bergmann <arnd@arndb.de>,
	Russell King <linux@armlinux.org.uk>
Cc: oe-kbuild-all@lists.linux.dev, Nicolas Pitre <npitre@baylibre.com>,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] asm-generic/div64: reimplement __arch_xprod64()
Message-ID: <202407061823.qXqNlq8o-lkp@intel.com>
References: <20240705022334.1378363-3-nico@fluxnic.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240705022334.1378363-3-nico@fluxnic.net>

Hi Nicolas,

kernel test robot noticed the following build warnings:

[auto build test WARNING on arnd-asm-generic/master]
[also build test WARNING on arm/for-next arm/fixes soc/for-next linus/master v6.10-rc6 next-20240703]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Nicolas-Pitre/ARM-div64-remove-custom-__arch_xprod_64/20240705-195905
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git master
patch link:    https://lore.kernel.org/r/20240705022334.1378363-3-nico%40fluxnic.net
patch subject: [PATCH 2/2] asm-generic/div64: reimplement __arch_xprod64()
config: parisc-defconfig (https://download.01.org/0day-ci/archive/20240706/202407061823.qXqNlq8o-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240706/202407061823.qXqNlq8o-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407061823.qXqNlq8o-lkp@intel.com/

All warnings (new ones prefixed by >>):

   security/keys/proc.c: In function 'proc_keys_show':
   security/keys/proc.c:215:45: warning: 'sprintf' may write a terminating nul past the end of the destination [-Wformat-overflow=]
     215 |                         sprintf(xbuf, "%llud", div_u64(timo, 60 * 60 * 24));
         |                                             ^
   security/keys/proc.c:215:25: note: 'sprintf' output between 3 and 17 bytes into a destination of size 16
     215 |                         sprintf(xbuf, "%llud", div_u64(timo, 60 * 60 * 24));
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   security/keys/proc.c:213:44: warning: 'h' directive writing 1 byte into a region of size between 0 and 15 [-Wformat-overflow=]
     213 |                         sprintf(xbuf, "%lluh", div_u64(timo, 60 * 60));
         |                                            ^
   security/keys/proc.c:213:25: note: 'sprintf' output between 3 and 18 bytes into a destination of size 16
     213 |                         sprintf(xbuf, "%lluh", div_u64(timo, 60 * 60));
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> security/keys/proc.c:211:40: warning: '%llu' directive writing between 1 and 19 bytes into a region of size 16 [-Wformat-overflow=]
     211 |                         sprintf(xbuf, "%llum", div_u64(timo, 60));
         |                                        ^~~~
   security/keys/proc.c:211:39: note: directive argument in the range [0, 1229782946264575725]
     211 |                         sprintf(xbuf, "%llum", div_u64(timo, 60));
         |                                       ^~~~~~~
   security/keys/proc.c:211:25: note: 'sprintf' output between 3 and 21 bytes into a destination of size 16
     211 |                         sprintf(xbuf, "%llum", div_u64(timo, 60));
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +211 security/keys/proc.c

^1da177e4c3f415 Linus Torvalds 2005-04-16  152  
^1da177e4c3f415 Linus Torvalds 2005-04-16  153  static int proc_keys_show(struct seq_file *m, void *v)
^1da177e4c3f415 Linus Torvalds 2005-04-16  154  {
^1da177e4c3f415 Linus Torvalds 2005-04-16  155  	struct rb_node *_p = v;
^1da177e4c3f415 Linus Torvalds 2005-04-16  156  	struct key *key = rb_entry(_p, struct key, serial_node);
ab5c69f01313c80 Eric Biggers   2017-09-27  157  	unsigned long flags;
927942aabbbe506 David Howells  2010-06-11  158  	key_ref_t key_ref, skey_ref;
074d58989569b39 Baolin Wang    2017-11-15  159  	time64_t now, expiry;
03dab869b7b239c David Howells  2016-10-26  160  	char xbuf[16];
363b02dab09b322 David Howells  2017-10-04  161  	short state;
074d58989569b39 Baolin Wang    2017-11-15  162  	u64 timo;
06ec7be557a1259 Michael LeMay  2006-06-26  163  	int rc;
06ec7be557a1259 Michael LeMay  2006-06-26  164  
4bdf0bc30031414 David Howells  2013-09-24  165  	struct keyring_search_context ctx = {
ede0fa98a900e65 Eric Biggers   2019-02-22  166  		.index_key		= key->index_key,
4aa68e07d845562 Eric Biggers   2017-09-18  167  		.cred			= m->file->f_cred,
462919591a1791e David Howells  2014-09-16  168  		.match_data.cmp		= lookup_user_key_possessed,
462919591a1791e David Howells  2014-09-16  169  		.match_data.raw_data	= key,
462919591a1791e David Howells  2014-09-16  170  		.match_data.lookup_type	= KEYRING_SEARCH_LOOKUP_DIRECT,
dcf49dbc8077e27 David Howells  2019-06-26  171  		.flags			= (KEYRING_SEARCH_NO_STATE_CHECK |
dcf49dbc8077e27 David Howells  2019-06-26  172  					   KEYRING_SEARCH_RECURSE),
4bdf0bc30031414 David Howells  2013-09-24  173  	};
4bdf0bc30031414 David Howells  2013-09-24  174  
028db3e290f15ac Linus Torvalds 2019-07-10  175  	key_ref = make_key_ref(key, 0);
927942aabbbe506 David Howells  2010-06-11  176  
927942aabbbe506 David Howells  2010-06-11  177  	/* determine if the key is possessed by this process (a test we can
927942aabbbe506 David Howells  2010-06-11  178  	 * skip if the key does not indicate the possessor can view it
927942aabbbe506 David Howells  2010-06-11  179  	 */
028db3e290f15ac Linus Torvalds 2019-07-10  180  	if (key->perm & KEY_POS_VIEW) {
028db3e290f15ac Linus Torvalds 2019-07-10  181  		rcu_read_lock();
e59428f721ee096 David Howells  2019-06-19  182  		skey_ref = search_cred_keyrings_rcu(&ctx);
028db3e290f15ac Linus Torvalds 2019-07-10  183  		rcu_read_unlock();
927942aabbbe506 David Howells  2010-06-11  184  		if (!IS_ERR(skey_ref)) {
927942aabbbe506 David Howells  2010-06-11  185  			key_ref_put(skey_ref);
927942aabbbe506 David Howells  2010-06-11  186  			key_ref = make_key_ref(key, 1);
927942aabbbe506 David Howells  2010-06-11  187  		}
927942aabbbe506 David Howells  2010-06-11  188  	}
927942aabbbe506 David Howells  2010-06-11  189  
4aa68e07d845562 Eric Biggers   2017-09-18  190  	/* check whether the current task is allowed to view the key */
f5895943d91b41b David Howells  2014-03-14  191  	rc = key_task_permission(key_ref, ctx.cred, KEY_NEED_VIEW);
06ec7be557a1259 Michael LeMay  2006-06-26  192  	if (rc < 0)
028db3e290f15ac Linus Torvalds 2019-07-10  193  		return 0;
^1da177e4c3f415 Linus Torvalds 2005-04-16  194  
074d58989569b39 Baolin Wang    2017-11-15  195  	now = ktime_get_real_seconds();
^1da177e4c3f415 Linus Torvalds 2005-04-16  196  
028db3e290f15ac Linus Torvalds 2019-07-10  197  	rcu_read_lock();
028db3e290f15ac Linus Torvalds 2019-07-10  198  
^1da177e4c3f415 Linus Torvalds 2005-04-16  199  	/* come up with a suitable timeout value */
ab5c69f01313c80 Eric Biggers   2017-09-27  200  	expiry = READ_ONCE(key->expiry);
39299bdd2546688 David Howells  2023-12-09  201  	if (expiry == TIME64_MAX) {
^1da177e4c3f415 Linus Torvalds 2005-04-16  202  		memcpy(xbuf, "perm", 5);
074d58989569b39 Baolin Wang    2017-11-15  203  	} else if (now >= expiry) {
^1da177e4c3f415 Linus Torvalds 2005-04-16  204  		memcpy(xbuf, "expd", 5);
7b1b9164598286f David Howells  2009-09-02  205  	} else {
074d58989569b39 Baolin Wang    2017-11-15  206  		timo = expiry - now;
^1da177e4c3f415 Linus Torvalds 2005-04-16  207  
^1da177e4c3f415 Linus Torvalds 2005-04-16  208  		if (timo < 60)
074d58989569b39 Baolin Wang    2017-11-15  209  			sprintf(xbuf, "%llus", timo);
^1da177e4c3f415 Linus Torvalds 2005-04-16  210  		else if (timo < 60*60)
074d58989569b39 Baolin Wang    2017-11-15 @211  			sprintf(xbuf, "%llum", div_u64(timo, 60));
^1da177e4c3f415 Linus Torvalds 2005-04-16  212  		else if (timo < 60*60*24)
074d58989569b39 Baolin Wang    2017-11-15  213  			sprintf(xbuf, "%lluh", div_u64(timo, 60 * 60));
^1da177e4c3f415 Linus Torvalds 2005-04-16  214  		else if (timo < 60*60*24*7)
074d58989569b39 Baolin Wang    2017-11-15 @215  			sprintf(xbuf, "%llud", div_u64(timo, 60 * 60 * 24));
^1da177e4c3f415 Linus Torvalds 2005-04-16  216  		else
074d58989569b39 Baolin Wang    2017-11-15  217  			sprintf(xbuf, "%lluw", div_u64(timo, 60 * 60 * 24 * 7));
^1da177e4c3f415 Linus Torvalds 2005-04-16  218  	}
^1da177e4c3f415 Linus Torvalds 2005-04-16  219  
363b02dab09b322 David Howells  2017-10-04  220  	state = key_read_state(key);
363b02dab09b322 David Howells  2017-10-04  221  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

