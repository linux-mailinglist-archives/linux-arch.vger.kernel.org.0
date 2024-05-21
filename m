Return-Path: <linux-arch+bounces-4476-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2EB8CA89D
	for <lists+linux-arch@lfdr.de>; Tue, 21 May 2024 09:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A2D01F22306
	for <lists+linux-arch@lfdr.de>; Tue, 21 May 2024 07:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F48A4B5CD;
	Tue, 21 May 2024 07:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UdfD5H+g"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE86050A63;
	Tue, 21 May 2024 07:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716275600; cv=none; b=kg+a7jrwpc0RsE8zciuefYqnJ0xFmT+tMSdc6p/nlV3NmEnh/AfEtwpC0GWMuqdCssLUW1GK5wp3jl1r84MNdPQqcW/jaahq0vwtGKX3wVD6sLH8w6jfm+XuGld7l6JdGrSShcOIS+B+8AsO28YPyIbelqE1Ic/2LbKi0C0HKfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716275600; c=relaxed/simple;
	bh=qvDP1jRufMd2iN8O0kotoJkFNUCBvX8IE1LAXNkhM1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=izLkAsWUUSCziqX7R4dtmeuJrOY/bnnmIn3//O8joaQqBD5+o3zKPb1P3EDddlhmRfz3pMmXmkxBTJxcQouglmouDNt12mjz/FS7wr9fuQzbKrB6Sja1lSvRHQxLiZ/WHX5n4jdEpA4kt+BEakHwbA+WPqe5X9u/Ihrm9ovmoG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UdfD5H+g; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716275598; x=1747811598;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qvDP1jRufMd2iN8O0kotoJkFNUCBvX8IE1LAXNkhM1g=;
  b=UdfD5H+gd1jRdL0zYqehBSb9rMNH9ooi+ylXSAVW2OAJUepLzi4iEvsO
   5e+OGQgHnUao74iVdqyg1Yb0JQYktKV1hN2JYF4zLicmmWsjcg0/S6ucL
   FQyDsWehbNkpAscdPsDwWc6pMnZX6rNjrDuSwa74pMjjM0Nxq9dd3aBYT
   cm8XK3Bo9VmyLG8J+JBzM7+5LGOefYwZL5uJ34cR8+ToGO6uyAhpLE4Xh
   ilC124x0BNGYY1rHoziR/YU9n3agd0c0L2bXspZjbTW8W+ffi44WbSXyz
   8w8F0j8I0/bo3Oyg/wtpqN3MD7xFOOpgwrfAy9FM261EtWELhlkZQGel2
   Q==;
X-CSE-ConnectionGUID: djKayKkGQei4osPDzYdgCw==
X-CSE-MsgGUID: ZViJSLMCQcass4npX+EZ4Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="16286092"
X-IronPort-AV: E=Sophos;i="6.08,177,1712646000"; 
   d="scan'208";a="16286092"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2024 00:13:17 -0700
X-CSE-ConnectionGUID: OAN1HqFMQvCBENBKOgy+NQ==
X-CSE-MsgGUID: 1Jnk6Zz3RkWsAysqIHuL5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,177,1712646000"; 
   d="scan'208";a="33416294"
Received: from unknown (HELO 108735ec233b) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 21 May 2024 00:13:14 -0700
Received: from kbuild by 108735ec233b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s9JgN-000636-1A;
	Tue, 21 May 2024 07:13:11 +0000
Date: Tue, 21 May 2024 15:12:32 +0800
From: kernel test robot <lkp@intel.com>
To: Masahiro Yamada <masahiroy@kernel.org>, linux-kbuild@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Ard Biesheuvel <ardb@kernel.org>,
	linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>, linux-arch@vger.kernel.org
Subject: Re: [PATCH 4/4] kbuild: remove PROVIDE() for kallsyms symbols
Message-ID: <202405211448.fglQOQ9W-lkp@intel.com>
References: <20240520124212.2351033-5-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240520124212.2351033-5-masahiroy@kernel.org>

Hi Masahiro,

kernel test robot noticed the following build errors:

[auto build test ERROR on masahiroy-kbuild/for-next]
[also build test ERROR on linus/master masahiroy-kbuild/fixes next-20240521]
[cannot apply to v6.9]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Masahiro-Yamada/kbuild-avoid-unneeded-kallsyms-step-3/20240520-204508
base:   https://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git for-next
patch link:    https://lore.kernel.org/r/20240520124212.2351033-5-masahiroy%40kernel.org
patch subject: [PATCH 4/4] kbuild: remove PROVIDE() for kallsyms symbols
config: x86_64-rhel-8.3-bpf (https://download.01.org/0day-ci/archive/20240521/202405211448.fglQOQ9W-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240521/202405211448.fglQOQ9W-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405211448.fglQOQ9W-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: vmlinux.o: in function `get_symbol_offset':
>> kernel/kallsyms.c:125:(.text+0x2111af): undefined reference to `kallsyms_markers'
>> ld: kernel/kallsyms.c:125:(.text+0x2111b5): undefined reference to `kallsyms_names'
   ld: kernel/kallsyms.c:146:(.text+0x2111eb): undefined reference to `kallsyms_names'
   ld: vmlinux.o: in function `get_symbol_pos':
>> kernel/kallsyms.c:330:(.text+0x211218): undefined reference to `kallsyms_relative_base'
>> ld: kernel/kallsyms.c:330:(.text+0x211226): undefined reference to `kallsyms_num_syms'
   ld: vmlinux.o: in function `kallsyms_sym_address':
>> kernel/kallsyms.c:159:(.text+0x211245): undefined reference to `kallsyms_offsets'
>> ld: kernel/kallsyms.c:159:(.text+0x211285): undefined reference to `kallsyms_offsets'
   ld: kernel/kallsyms.c:159:(.text+0x211296): undefined reference to `kallsyms_offsets'
   ld: kernel/kallsyms.c:159:(.text+0x2112b7): undefined reference to `kallsyms_offsets'
   ld: kernel/kallsyms.c:159:(.text+0x2112ec): undefined reference to `kallsyms_offsets'
   ld: vmlinux.o: in function `get_ksymbol_mod':
>> kernel/kallsyms.c:623:(.text+0x211434): undefined reference to `kallsyms_num_syms'
   ld: vmlinux.o: in function `kallsyms_expand_symbol':
>> kernel/kallsyms.c:50:(.text+0x21167d): undefined reference to `kallsyms_names'
   ld: kernel/kallsyms.c:51:(.text+0x211684): undefined reference to `kallsyms_names'
>> ld: kernel/kallsyms.c:73:(.text+0x2116b6): undefined reference to `kallsyms_token_index'
>> ld: kernel/kallsyms.c:73:(.text+0x2116bf): undefined reference to `kallsyms_token_table'
   ld: kernel/kallsyms.c:77:(.text+0x2116c6): undefined reference to `kallsyms_token_table'
   ld: vmlinux.o: in function `update_iter':
   kernel/kallsyms.c:740:(.text+0x211757): undefined reference to `kallsyms_num_syms'
   ld: vmlinux.o: in function `kallsyms_sym_address':
   kernel/kallsyms.c:159:(.text+0x211782): undefined reference to `kallsyms_offsets'
>> ld: kernel/kallsyms.c:163:(.text+0x211790): undefined reference to `kallsyms_relative_base'
   ld: vmlinux.o: in function `kallsyms_get_symbol_type':
   kernel/kallsyms.c:108:(.text+0x21179e): undefined reference to `kallsyms_names'
   ld: kernel/kallsyms.c:108:(.text+0x2117aa): undefined reference to `kallsyms_token_index'
   ld: vmlinux.o: in function `get_ksymbol_core':
>> kernel/kallsyms.c:693:(.text+0x2117b1): undefined reference to `kallsyms_token_table'
   ld: vmlinux.o: in function `kallsyms_lookup_names':
   kernel/kallsyms.c:218:(.text+0x211a48): undefined reference to `kallsyms_num_syms'
   ld: vmlinux.o: in function `get_symbol_seq':
>> kernel/kallsyms.c:203:(.text+0x211a83): undefined reference to `kallsyms_seqs_of_names'
>> ld: kernel/kallsyms.c:203:(.text+0x211a90): undefined reference to `kallsyms_seqs_of_names'
   ld: kernel/kallsyms.c:203:(.text+0x211a9c): undefined reference to `kallsyms_seqs_of_names'
   ld: kernel/kallsyms.c:203:(.text+0x211af2): undefined reference to `kallsyms_seqs_of_names'
   ld: kernel/kallsyms.c:203:(.text+0x211aff): undefined reference to `kallsyms_seqs_of_names'
   ld: vmlinux.o:kernel/kallsyms.c:203: more undefined references to `kallsyms_seqs_of_names' follow
   ld: vmlinux.o: in function `kallsyms_sym_address':
   kernel/kallsyms.c:159:(.text+0x211fb0): undefined reference to `kallsyms_offsets'
   ld: kernel/kallsyms.c:163:(.text+0x211fbe): undefined reference to `kallsyms_relative_base'
   ld: vmlinux.o: in function `get_symbol_seq':
   kernel/kallsyms.c:203:(.text+0x212049): undefined reference to `kallsyms_seqs_of_names'
   ld: kernel/kallsyms.c:203:(.text+0x212056): undefined reference to `kallsyms_seqs_of_names'
   ld: kernel/kallsyms.c:203:(.text+0x21205d): undefined reference to `kallsyms_seqs_of_names'
   ld: vmlinux.o: in function `kallsyms_sym_address':
   kernel/kallsyms.c:159:(.text+0x212071): undefined reference to `kallsyms_offsets'
   ld: kernel/kallsyms.c:163:(.text+0x21207f): undefined reference to `kallsyms_relative_base'
   ld: vmlinux.o: in function `kallsyms_on_each_symbol':
   kernel/kallsyms.c:293:(.text+0x2120e5): undefined reference to `kallsyms_num_syms'
   ld: vmlinux.o: in function `kallsyms_sym_address':
   kernel/kallsyms.c:159:(.text+0x21214b): undefined reference to `kallsyms_offsets'
   ld: kernel/kallsyms.c:163:(.text+0x212159): undefined reference to `kallsyms_relative_base'
   ld: kernel/kallsyms.c:163:(.text+0x212224): undefined reference to `kallsyms_relative_base'
   ld: vmlinux.o: in function `get_symbol_seq':
   kernel/kallsyms.c:203:(.text+0x212239): undefined reference to `kallsyms_seqs_of_names'
   ld: kernel/kallsyms.c:203:(.text+0x212240): undefined reference to `kallsyms_seqs_of_names'
   ld: kernel/kallsyms.c:203:(.text+0x212253): undefined reference to `kallsyms_seqs_of_names'
   ld: vmlinux.o: in function `kallsyms_sym_address':
   kernel/kallsyms.c:159:(.text+0x21225f): undefined reference to `kallsyms_offsets'
   ld: vmlinux.o: in function `crash_save_vmcoreinfo_init':
>> kernel/vmcore_info.c:214:(.init.text+0x429d6): undefined reference to `kallsyms_names'
>> ld: kernel/vmcore_info.c:215:(.init.text+0x429f0): undefined reference to `kallsyms_num_syms'
>> ld: kernel/vmcore_info.c:216:(.init.text+0x42a0a): undefined reference to `kallsyms_token_table'
>> ld: kernel/vmcore_info.c:217:(.init.text+0x42a24): undefined reference to `kallsyms_token_index'
>> ld: kernel/vmcore_info.c:219:(.init.text+0x42a3e): undefined reference to `kallsyms_offsets'
>> ld: kernel/vmcore_info.c:220:(.init.text+0x42a58): undefined reference to `kallsyms_relative_base'
   pahole: .tmp_vmlinux.btf: Invalid argument
   .btf.vmlinux.bin.o: file not recognized: file format not recognized


vim +125 kernel/kallsyms.c

^1da177e4c3f41 Linus Torvalds   2005-04-16   36  
ad6ccfad6f759a Manish Katiyar   2009-05-12   37  /*
ad6ccfad6f759a Manish Katiyar   2009-05-12   38   * Expand a compressed symbol data into the resulting uncompressed string,
e3f26752f0f8a6 Chen Gang        2013-04-15   39   * if uncompressed string is too long (>= maxlen), it will be truncated,
ad6ccfad6f759a Manish Katiyar   2009-05-12   40   * given the offset to where the symbol is in the compressed stream.
ad6ccfad6f759a Manish Katiyar   2009-05-12   41   */
e3f26752f0f8a6 Chen Gang        2013-04-15   42  static unsigned int kallsyms_expand_symbol(unsigned int off,
e3f26752f0f8a6 Chen Gang        2013-04-15   43  					   char *result, size_t maxlen)
^1da177e4c3f41 Linus Torvalds   2005-04-16   44  {
^1da177e4c3f41 Linus Torvalds   2005-04-16   45  	int len, skipped_first = 0;
cde26a6e17ec36 Masahiro Yamada  2020-02-02   46  	const char *tptr;
cde26a6e17ec36 Masahiro Yamada  2020-02-02   47  	const u8 *data;
^1da177e4c3f41 Linus Torvalds   2005-04-16   48  
ad6ccfad6f759a Manish Katiyar   2009-05-12   49  	/* Get the compressed symbol length from the first symbol byte. */
^1da177e4c3f41 Linus Torvalds   2005-04-16  @50  	data = &kallsyms_names[off];
^1da177e4c3f41 Linus Torvalds   2005-04-16   51  	len = *data;
^1da177e4c3f41 Linus Torvalds   2005-04-16   52  	data++;
73bbb94466fd3f Miguel Ojeda     2021-04-05   53  	off++;
73bbb94466fd3f Miguel Ojeda     2021-04-05   54  
73bbb94466fd3f Miguel Ojeda     2021-04-05   55  	/* If MSB is 1, it is a "big" symbol, so needs an additional byte. */
73bbb94466fd3f Miguel Ojeda     2021-04-05   56  	if ((len & 0x80) != 0) {
73bbb94466fd3f Miguel Ojeda     2021-04-05   57  		len = (len & 0x7F) | (*data << 7);
73bbb94466fd3f Miguel Ojeda     2021-04-05   58  		data++;
73bbb94466fd3f Miguel Ojeda     2021-04-05   59  		off++;
73bbb94466fd3f Miguel Ojeda     2021-04-05   60  	}
^1da177e4c3f41 Linus Torvalds   2005-04-16   61  
ad6ccfad6f759a Manish Katiyar   2009-05-12   62  	/*
ad6ccfad6f759a Manish Katiyar   2009-05-12   63  	 * Update the offset to return the offset for the next symbol on
ad6ccfad6f759a Manish Katiyar   2009-05-12   64  	 * the compressed stream.
ad6ccfad6f759a Manish Katiyar   2009-05-12   65  	 */
73bbb94466fd3f Miguel Ojeda     2021-04-05   66  	off += len;
^1da177e4c3f41 Linus Torvalds   2005-04-16   67  
ad6ccfad6f759a Manish Katiyar   2009-05-12   68  	/*
ad6ccfad6f759a Manish Katiyar   2009-05-12   69  	 * For every byte on the compressed symbol data, copy the table
ad6ccfad6f759a Manish Katiyar   2009-05-12   70  	 * entry for that byte.
ad6ccfad6f759a Manish Katiyar   2009-05-12   71  	 */
^1da177e4c3f41 Linus Torvalds   2005-04-16   72  	while (len) {
^1da177e4c3f41 Linus Torvalds   2005-04-16  @73  		tptr = &kallsyms_token_table[kallsyms_token_index[*data]];
^1da177e4c3f41 Linus Torvalds   2005-04-16   74  		data++;
^1da177e4c3f41 Linus Torvalds   2005-04-16   75  		len--;
^1da177e4c3f41 Linus Torvalds   2005-04-16   76  
^1da177e4c3f41 Linus Torvalds   2005-04-16   77  		while (*tptr) {
^1da177e4c3f41 Linus Torvalds   2005-04-16   78  			if (skipped_first) {
e3f26752f0f8a6 Chen Gang        2013-04-15   79  				if (maxlen <= 1)
e3f26752f0f8a6 Chen Gang        2013-04-15   80  					goto tail;
^1da177e4c3f41 Linus Torvalds   2005-04-16   81  				*result = *tptr;
^1da177e4c3f41 Linus Torvalds   2005-04-16   82  				result++;
e3f26752f0f8a6 Chen Gang        2013-04-15   83  				maxlen--;
^1da177e4c3f41 Linus Torvalds   2005-04-16   84  			} else
^1da177e4c3f41 Linus Torvalds   2005-04-16   85  				skipped_first = 1;
^1da177e4c3f41 Linus Torvalds   2005-04-16   86  			tptr++;
^1da177e4c3f41 Linus Torvalds   2005-04-16   87  		}
^1da177e4c3f41 Linus Torvalds   2005-04-16   88  	}
^1da177e4c3f41 Linus Torvalds   2005-04-16   89  
e3f26752f0f8a6 Chen Gang        2013-04-15   90  tail:
e3f26752f0f8a6 Chen Gang        2013-04-15   91  	if (maxlen)
^1da177e4c3f41 Linus Torvalds   2005-04-16   92  		*result = '\0';
^1da177e4c3f41 Linus Torvalds   2005-04-16   93  
ad6ccfad6f759a Manish Katiyar   2009-05-12   94  	/* Return to offset to the next symbol. */
^1da177e4c3f41 Linus Torvalds   2005-04-16   95  	return off;
^1da177e4c3f41 Linus Torvalds   2005-04-16   96  }
^1da177e4c3f41 Linus Torvalds   2005-04-16   97  
ad6ccfad6f759a Manish Katiyar   2009-05-12   98  /*
ad6ccfad6f759a Manish Katiyar   2009-05-12   99   * Get symbol type information. This is encoded as a single char at the
ad6ccfad6f759a Manish Katiyar   2009-05-12  100   * beginning of the symbol name.
ad6ccfad6f759a Manish Katiyar   2009-05-12  101   */
^1da177e4c3f41 Linus Torvalds   2005-04-16  102  static char kallsyms_get_symbol_type(unsigned int off)
^1da177e4c3f41 Linus Torvalds   2005-04-16  103  {
ad6ccfad6f759a Manish Katiyar   2009-05-12  104  	/*
ad6ccfad6f759a Manish Katiyar   2009-05-12  105  	 * Get just the first code, look it up in the token table,
ad6ccfad6f759a Manish Katiyar   2009-05-12  106  	 * and return the first char from this token.
ad6ccfad6f759a Manish Katiyar   2009-05-12  107  	 */
^1da177e4c3f41 Linus Torvalds   2005-04-16  108  	return kallsyms_token_table[kallsyms_token_index[kallsyms_names[off + 1]]];
^1da177e4c3f41 Linus Torvalds   2005-04-16  109  }
^1da177e4c3f41 Linus Torvalds   2005-04-16  110  
^1da177e4c3f41 Linus Torvalds   2005-04-16  111  
ad6ccfad6f759a Manish Katiyar   2009-05-12  112  /*
ad6ccfad6f759a Manish Katiyar   2009-05-12  113   * Find the offset on the compressed stream given and index in the
ad6ccfad6f759a Manish Katiyar   2009-05-12  114   * kallsyms array.
ad6ccfad6f759a Manish Katiyar   2009-05-12  115   */
^1da177e4c3f41 Linus Torvalds   2005-04-16  116  static unsigned int get_symbol_offset(unsigned long pos)
^1da177e4c3f41 Linus Torvalds   2005-04-16  117  {
aad094701c6355 Jan Beulich      2006-12-08  118  	const u8 *name;
73bbb94466fd3f Miguel Ojeda     2021-04-05  119  	int i, len;
^1da177e4c3f41 Linus Torvalds   2005-04-16  120  
ad6ccfad6f759a Manish Katiyar   2009-05-12  121  	/*
ad6ccfad6f759a Manish Katiyar   2009-05-12  122  	 * Use the closest marker we have. We have markers every 256 positions,
ad6ccfad6f759a Manish Katiyar   2009-05-12  123  	 * so that should be close enough.
ad6ccfad6f759a Manish Katiyar   2009-05-12  124  	 */
^1da177e4c3f41 Linus Torvalds   2005-04-16 @125  	name = &kallsyms_names[kallsyms_markers[pos >> 8]];
^1da177e4c3f41 Linus Torvalds   2005-04-16  126  
ad6ccfad6f759a Manish Katiyar   2009-05-12  127  	/*
ad6ccfad6f759a Manish Katiyar   2009-05-12  128  	 * Sequentially scan all the symbols up to the point we're searching
ad6ccfad6f759a Manish Katiyar   2009-05-12  129  	 * for. Every symbol is stored in a [<len>][<len> bytes of data] format,
ad6ccfad6f759a Manish Katiyar   2009-05-12  130  	 * so we just need to add the len to the current pointer for every
ad6ccfad6f759a Manish Katiyar   2009-05-12  131  	 * symbol we wish to skip.
ad6ccfad6f759a Manish Katiyar   2009-05-12  132  	 */
73bbb94466fd3f Miguel Ojeda     2021-04-05  133  	for (i = 0; i < (pos & 0xFF); i++) {
73bbb94466fd3f Miguel Ojeda     2021-04-05  134  		len = *name;
73bbb94466fd3f Miguel Ojeda     2021-04-05  135  
73bbb94466fd3f Miguel Ojeda     2021-04-05  136  		/*
73bbb94466fd3f Miguel Ojeda     2021-04-05  137  		 * If MSB is 1, it is a "big" symbol, so we need to look into
73bbb94466fd3f Miguel Ojeda     2021-04-05  138  		 * the next byte (and skip it, too).
73bbb94466fd3f Miguel Ojeda     2021-04-05  139  		 */
73bbb94466fd3f Miguel Ojeda     2021-04-05  140  		if ((len & 0x80) != 0)
73bbb94466fd3f Miguel Ojeda     2021-04-05  141  			len = ((len & 0x7F) | (name[1] << 7)) + 1;
73bbb94466fd3f Miguel Ojeda     2021-04-05  142  
73bbb94466fd3f Miguel Ojeda     2021-04-05  143  		name = name + len + 1;
73bbb94466fd3f Miguel Ojeda     2021-04-05  144  	}
^1da177e4c3f41 Linus Torvalds   2005-04-16  145  
^1da177e4c3f41 Linus Torvalds   2005-04-16  146  	return name - kallsyms_names;
^1da177e4c3f41 Linus Torvalds   2005-04-16  147  }
^1da177e4c3f41 Linus Torvalds   2005-04-16  148  
30f3bb09778de6 Zhen Lei         2022-11-15  149  unsigned long kallsyms_sym_address(int idx)
2213e9a66bb87d Ard Biesheuvel   2016-03-15  150  {
2213e9a66bb87d Ard Biesheuvel   2016-03-15  151  	if (!IS_ENABLED(CONFIG_KALLSYMS_BASE_RELATIVE))
2213e9a66bb87d Ard Biesheuvel   2016-03-15  152  		return kallsyms_addresses[idx];
2213e9a66bb87d Ard Biesheuvel   2016-03-15  153  
2213e9a66bb87d Ard Biesheuvel   2016-03-15  154  	/* values are unsigned offsets if --absolute-percpu is not in effect */
2213e9a66bb87d Ard Biesheuvel   2016-03-15  155  	if (!IS_ENABLED(CONFIG_KALLSYMS_ABSOLUTE_PERCPU))
2213e9a66bb87d Ard Biesheuvel   2016-03-15  156  		return kallsyms_relative_base + (u32)kallsyms_offsets[idx];
2213e9a66bb87d Ard Biesheuvel   2016-03-15  157  
2213e9a66bb87d Ard Biesheuvel   2016-03-15  158  	/* ...otherwise, positive offsets are absolute values */
2213e9a66bb87d Ard Biesheuvel   2016-03-15 @159  	if (kallsyms_offsets[idx] >= 0)
2213e9a66bb87d Ard Biesheuvel   2016-03-15  160  		return kallsyms_offsets[idx];
2213e9a66bb87d Ard Biesheuvel   2016-03-15  161  
2213e9a66bb87d Ard Biesheuvel   2016-03-15  162  	/* ...and negative offsets are relative to kallsyms_relative_base - 1 */
2213e9a66bb87d Ard Biesheuvel   2016-03-15 @163  	return kallsyms_relative_base - 1 - kallsyms_offsets[idx];
2213e9a66bb87d Ard Biesheuvel   2016-03-15  164  }
2213e9a66bb87d Ard Biesheuvel   2016-03-15  165  
76903a9648744c Yonghong Song    2023-08-25  166  static void cleanup_symbol_name(char *s)
8b8e6b5d3b013b Sami Tolvanen    2021-04-08  167  {
8b8e6b5d3b013b Sami Tolvanen    2021-04-08  168  	char *res;
8b8e6b5d3b013b Sami Tolvanen    2021-04-08  169  
6eb4bd92c1cedc Nick Desaulniers 2021-10-04  170  	if (!IS_ENABLED(CONFIG_LTO_CLANG))
76903a9648744c Yonghong Song    2023-08-25  171  		return;
6eb4bd92c1cedc Nick Desaulniers 2021-10-04  172  
6eb4bd92c1cedc Nick Desaulniers 2021-10-04  173  	/*
6eb4bd92c1cedc Nick Desaulniers 2021-10-04  174  	 * LLVM appends various suffixes for local functions and variables that
6eb4bd92c1cedc Nick Desaulniers 2021-10-04  175  	 * must be promoted to global scope as part of LTO.  This can break
6eb4bd92c1cedc Nick Desaulniers 2021-10-04  176  	 * hooking of static functions with kprobes. '.' is not a valid
8cc32a9bbf2934 Yonghong Song    2023-06-28  177  	 * character in an identifier in C. Suffixes only in LLVM LTO observed:
6eb4bd92c1cedc Nick Desaulniers 2021-10-04  178  	 * - foo.llvm.[0-9a-f]+
6eb4bd92c1cedc Nick Desaulniers 2021-10-04  179  	 */
8cc32a9bbf2934 Yonghong Song    2023-06-28  180  	res = strstr(s, ".llvm.");
76903a9648744c Yonghong Song    2023-08-25  181  	if (res)
6eb4bd92c1cedc Nick Desaulniers 2021-10-04  182  		*res = '\0';
6eb4bd92c1cedc Nick Desaulniers 2021-10-04  183  
76903a9648744c Yonghong Song    2023-08-25  184  	return;
8b8e6b5d3b013b Sami Tolvanen    2021-04-08  185  }
8b8e6b5d3b013b Sami Tolvanen    2021-04-08  186  
60443c88f3a89f Zhen Lei         2022-11-02  187  static int compare_symbol_name(const char *name, char *namebuf)
60443c88f3a89f Zhen Lei         2022-11-02  188  {
33f0467fe06934 Yonghong Song    2023-08-24  189  	/* The kallsyms_seqs_of_names is sorted based on names after
33f0467fe06934 Yonghong Song    2023-08-24  190  	 * cleanup_symbol_name() (see scripts/kallsyms.c) if clang lto is enabled.
33f0467fe06934 Yonghong Song    2023-08-24  191  	 * To ensure correct bisection in kallsyms_lookup_names(), do
33f0467fe06934 Yonghong Song    2023-08-24  192  	 * cleanup_symbol_name(namebuf) before comparing name and namebuf.
33f0467fe06934 Yonghong Song    2023-08-24  193  	 */
33f0467fe06934 Yonghong Song    2023-08-24  194  	cleanup_symbol_name(namebuf);
33f0467fe06934 Yonghong Song    2023-08-24  195  	return strcmp(name, namebuf);
60443c88f3a89f Zhen Lei         2022-11-02  196  }
60443c88f3a89f Zhen Lei         2022-11-02  197  
19bd8981dc2ee3 Zhen Lei         2022-11-02  198  static unsigned int get_symbol_seq(int index)
19bd8981dc2ee3 Zhen Lei         2022-11-02  199  {
19bd8981dc2ee3 Zhen Lei         2022-11-02  200  	unsigned int i, seq = 0;
19bd8981dc2ee3 Zhen Lei         2022-11-02  201  
19bd8981dc2ee3 Zhen Lei         2022-11-02  202  	for (i = 0; i < 3; i++)
19bd8981dc2ee3 Zhen Lei         2022-11-02 @203  		seq = (seq << 8) | kallsyms_seqs_of_names[3 * index + i];
19bd8981dc2ee3 Zhen Lei         2022-11-02  204  
19bd8981dc2ee3 Zhen Lei         2022-11-02  205  	return seq;
19bd8981dc2ee3 Zhen Lei         2022-11-02  206  }
19bd8981dc2ee3 Zhen Lei         2022-11-02  207  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

