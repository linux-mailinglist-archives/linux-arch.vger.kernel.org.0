Return-Path: <linux-arch+bounces-7710-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B52CB99127F
	for <lists+linux-arch@lfdr.de>; Sat,  5 Oct 2024 00:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 719F3282877
	for <lists+linux-arch@lfdr.de>; Fri,  4 Oct 2024 22:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 575DC146A68;
	Fri,  4 Oct 2024 22:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Je1NUrFt"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6303B13A416;
	Fri,  4 Oct 2024 22:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728082069; cv=none; b=s8S/MQU1ocJ3MGa6GdgIepwtHrCzTDgI0icriqVXthhn0eMCrzg9Pdf8YoEmJKAF5rrslIzoENpY548ErKkOlfkyEuIgPh7daIdbGE+VDn0v0W3C7/W/BKSYJzQViT71LNgYhts+uecNPT84n2mmbd21WcU7v74wR3roE/4Jp04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728082069; c=relaxed/simple;
	bh=MlwMo+TC9a7kC97ziHy88u344ItEnCnkGeXeeaigOso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UBcbVfi0Qq8KcP3S6kwOULgMuPEbEYcQi4TWLxmc8EMrrBpQDQBJYQynwlkiq75fr9HQbMIhnWd3zFR6GyYQyDMnO/vyaL1StbVE/bROQ1FVW/6wOgQ9W/2IatjclFS4ibKqM+m5Kaa7OPg+0oXhfxluPhqFjtbML5qVz1vYf0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Je1NUrFt; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728082067; x=1759618067;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MlwMo+TC9a7kC97ziHy88u344ItEnCnkGeXeeaigOso=;
  b=Je1NUrFtgViKAzMkQTJTnyaSSiZUffbDX60ZVViPYeT0k4bToeG897H7
   7bDLuiGJGTBJyprd0jySCwh4KPIag4aBFSYAsPbfoJ2ShzciA40q14zvu
   4fLecE9b9lKdM6j9x03FWtCOHb4x9tfuX8uIQm0AJf/vmKLJqeKd85SGC
   23sQMqYJ/rNrd7JbezPDKRngIBS3V5a4+Iibi5MMm8Dr+rlXIEevHkvD0
   kgblDCDtSV7zh1StcK+/+29BD6ppPcWywZHDk5+dMSWSunbNTc/GGIqej
   SxPA0QBpaFpruOwXgJjyYK5SDOPiWeFDo1tAjg+NYZvXXduL0npU6qdzy
   g==;
X-CSE-ConnectionGUID: fxHKzeNXS+eMFTW/AjlJUA==
X-CSE-MsgGUID: PPDJ/GroT9SRbJIIxxDLaA==
X-IronPort-AV: E=McAfee;i="6700,10204,11215"; a="44783511"
X-IronPort-AV: E=Sophos;i="6.11,178,1725346800"; 
   d="scan'208";a="44783511"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 15:47:47 -0700
X-CSE-ConnectionGUID: ZspearNRT5GVhaqSRr6fqg==
X-CSE-MsgGUID: LTmPgDHVSqmvd2kYL3hyXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,178,1725346800"; 
   d="scan'208";a="75181515"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 04 Oct 2024 15:47:45 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1swr5K-0002J2-20;
	Fri, 04 Oct 2024 22:47:42 +0000
Date: Sat, 5 Oct 2024 06:47:17 +0800
From: kernel test robot <lkp@intel.com>
To: Nicolas Pitre <nico@fluxnic.net>, Arnd Bergmann <arnd@arndb.de>,
	Russell King <linux@armlinux.org.uk>
Cc: oe-kbuild-all@lists.linux.dev, Nicolas Pitre <npitre@baylibre.com>,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/4] asm-generic/div64: optimize/simplify
 __div64_const32()
Message-ID: <202410050606.G2mm4qbj-lkp@intel.com>
References: <20241003211829.2750436-3-nico@fluxnic.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003211829.2750436-3-nico@fluxnic.net>

Hi Nicolas,

kernel test robot noticed the following build warnings:

[auto build test WARNING on arnd-asm-generic/master]
[also build test WARNING on soc/for-next linus/master arm/for-next arm/fixes v6.12-rc1 next-20241004]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Nicolas-Pitre/lib-math-test_div64-add-some-edge-cases-relevant-to-__div64_const32/20241004-052015
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git master
patch link:    https://lore.kernel.org/r/20241003211829.2750436-3-nico%40fluxnic.net
patch subject: [PATCH v4 2/4] asm-generic/div64: optimize/simplify __div64_const32()
config: arm-u8500_defconfig (https://download.01.org/0day-ci/archive/20241005/202410050606.G2mm4qbj-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241005/202410050606.G2mm4qbj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410050606.G2mm4qbj-lkp@intel.com/

All warnings (new ones prefixed by >>):

   security/keys/proc.c: In function 'proc_keys_show':
   security/keys/proc.c:217:45: warning: 'sprintf' may write a terminating nul past the end of the destination [-Wformat-overflow=]
     217 |                         sprintf(xbuf, "%lluw", div_u64(timo, 60 * 60 * 24 * 7));
         |                                             ^
   security/keys/proc.c:217:25: note: 'sprintf' output between 3 and 17 bytes into a destination of size 16
     217 |                         sprintf(xbuf, "%lluw", div_u64(timo, 60 * 60 * 24 * 7));
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
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
>> security/keys/proc.c:211:40: warning: '%llu' directive writing between 1 and 18 bytes into a region of size 16 [-Wformat-overflow=]
     211 |                         sprintf(xbuf, "%llum", div_u64(timo, 60));
         |                                        ^~~~
   security/keys/proc.c:211:39: note: directive argument in the range [0, 576460752303423487]
     211 |                         sprintf(xbuf, "%llum", div_u64(timo, 60));
         |                                       ^~~~~~~
   security/keys/proc.c:211:25: note: 'sprintf' output between 3 and 20 bytes into a destination of size 16
     211 |                         sprintf(xbuf, "%llum", div_u64(timo, 60));
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +211 security/keys/proc.c

^1da177e4c3f41 Linus Torvalds 2005-04-16  152  
^1da177e4c3f41 Linus Torvalds 2005-04-16  153  static int proc_keys_show(struct seq_file *m, void *v)
^1da177e4c3f41 Linus Torvalds 2005-04-16  154  {
^1da177e4c3f41 Linus Torvalds 2005-04-16  155  	struct rb_node *_p = v;
^1da177e4c3f41 Linus Torvalds 2005-04-16  156  	struct key *key = rb_entry(_p, struct key, serial_node);
ab5c69f01313c8 Eric Biggers   2017-09-27  157  	unsigned long flags;
927942aabbbe50 David Howells  2010-06-11  158  	key_ref_t key_ref, skey_ref;
074d58989569b3 Baolin Wang    2017-11-15  159  	time64_t now, expiry;
03dab869b7b239 David Howells  2016-10-26  160  	char xbuf[16];
363b02dab09b32 David Howells  2017-10-04  161  	short state;
074d58989569b3 Baolin Wang    2017-11-15  162  	u64 timo;
06ec7be557a125 Michael LeMay  2006-06-26  163  	int rc;
06ec7be557a125 Michael LeMay  2006-06-26  164  
4bdf0bc3003141 David Howells  2013-09-24  165  	struct keyring_search_context ctx = {
ede0fa98a900e6 Eric Biggers   2019-02-22  166  		.index_key		= key->index_key,
4aa68e07d84556 Eric Biggers   2017-09-18  167  		.cred			= m->file->f_cred,
462919591a1791 David Howells  2014-09-16  168  		.match_data.cmp		= lookup_user_key_possessed,
462919591a1791 David Howells  2014-09-16  169  		.match_data.raw_data	= key,
462919591a1791 David Howells  2014-09-16  170  		.match_data.lookup_type	= KEYRING_SEARCH_LOOKUP_DIRECT,
dcf49dbc8077e2 David Howells  2019-06-26  171  		.flags			= (KEYRING_SEARCH_NO_STATE_CHECK |
dcf49dbc8077e2 David Howells  2019-06-26  172  					   KEYRING_SEARCH_RECURSE),
4bdf0bc3003141 David Howells  2013-09-24  173  	};
4bdf0bc3003141 David Howells  2013-09-24  174  
028db3e290f15a Linus Torvalds 2019-07-10  175  	key_ref = make_key_ref(key, 0);
927942aabbbe50 David Howells  2010-06-11  176  
927942aabbbe50 David Howells  2010-06-11  177  	/* determine if the key is possessed by this process (a test we can
927942aabbbe50 David Howells  2010-06-11  178  	 * skip if the key does not indicate the possessor can view it
927942aabbbe50 David Howells  2010-06-11  179  	 */
028db3e290f15a Linus Torvalds 2019-07-10  180  	if (key->perm & KEY_POS_VIEW) {
028db3e290f15a Linus Torvalds 2019-07-10  181  		rcu_read_lock();
e59428f721ee09 David Howells  2019-06-19  182  		skey_ref = search_cred_keyrings_rcu(&ctx);
028db3e290f15a Linus Torvalds 2019-07-10  183  		rcu_read_unlock();
927942aabbbe50 David Howells  2010-06-11  184  		if (!IS_ERR(skey_ref)) {
927942aabbbe50 David Howells  2010-06-11  185  			key_ref_put(skey_ref);
927942aabbbe50 David Howells  2010-06-11  186  			key_ref = make_key_ref(key, 1);
927942aabbbe50 David Howells  2010-06-11  187  		}
927942aabbbe50 David Howells  2010-06-11  188  	}
927942aabbbe50 David Howells  2010-06-11  189  
4aa68e07d84556 Eric Biggers   2017-09-18  190  	/* check whether the current task is allowed to view the key */
f5895943d91b41 David Howells  2014-03-14  191  	rc = key_task_permission(key_ref, ctx.cred, KEY_NEED_VIEW);
06ec7be557a125 Michael LeMay  2006-06-26  192  	if (rc < 0)
028db3e290f15a Linus Torvalds 2019-07-10  193  		return 0;
^1da177e4c3f41 Linus Torvalds 2005-04-16  194  
074d58989569b3 Baolin Wang    2017-11-15  195  	now = ktime_get_real_seconds();
^1da177e4c3f41 Linus Torvalds 2005-04-16  196  
028db3e290f15a Linus Torvalds 2019-07-10  197  	rcu_read_lock();
028db3e290f15a Linus Torvalds 2019-07-10  198  
^1da177e4c3f41 Linus Torvalds 2005-04-16  199  	/* come up with a suitable timeout value */
ab5c69f01313c8 Eric Biggers   2017-09-27  200  	expiry = READ_ONCE(key->expiry);
39299bdd254668 David Howells  2023-12-09  201  	if (expiry == TIME64_MAX) {
^1da177e4c3f41 Linus Torvalds 2005-04-16  202  		memcpy(xbuf, "perm", 5);
074d58989569b3 Baolin Wang    2017-11-15  203  	} else if (now >= expiry) {
^1da177e4c3f41 Linus Torvalds 2005-04-16  204  		memcpy(xbuf, "expd", 5);
7b1b9164598286 David Howells  2009-09-02  205  	} else {
074d58989569b3 Baolin Wang    2017-11-15  206  		timo = expiry - now;
^1da177e4c3f41 Linus Torvalds 2005-04-16  207  
^1da177e4c3f41 Linus Torvalds 2005-04-16  208  		if (timo < 60)
074d58989569b3 Baolin Wang    2017-11-15  209  			sprintf(xbuf, "%llus", timo);
^1da177e4c3f41 Linus Torvalds 2005-04-16  210  		else if (timo < 60*60)
074d58989569b3 Baolin Wang    2017-11-15 @211  			sprintf(xbuf, "%llum", div_u64(timo, 60));
^1da177e4c3f41 Linus Torvalds 2005-04-16  212  		else if (timo < 60*60*24)
074d58989569b3 Baolin Wang    2017-11-15  213  			sprintf(xbuf, "%lluh", div_u64(timo, 60 * 60));
^1da177e4c3f41 Linus Torvalds 2005-04-16  214  		else if (timo < 60*60*24*7)
074d58989569b3 Baolin Wang    2017-11-15 @215  			sprintf(xbuf, "%llud", div_u64(timo, 60 * 60 * 24));
^1da177e4c3f41 Linus Torvalds 2005-04-16  216  		else
074d58989569b3 Baolin Wang    2017-11-15  217  			sprintf(xbuf, "%lluw", div_u64(timo, 60 * 60 * 24 * 7));
^1da177e4c3f41 Linus Torvalds 2005-04-16  218  	}
^1da177e4c3f41 Linus Torvalds 2005-04-16  219  
363b02dab09b32 David Howells  2017-10-04  220  	state = key_read_state(key);
363b02dab09b32 David Howells  2017-10-04  221  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

