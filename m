Return-Path: <linux-arch+bounces-14520-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A878DC36CCB
	for <lists+linux-arch@lfdr.de>; Wed, 05 Nov 2025 17:51:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E9C6641CF1
	for <lists+linux-arch@lfdr.de>; Wed,  5 Nov 2025 16:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F29333755;
	Wed,  5 Nov 2025 16:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WWxLLBhl"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71305333745;
	Wed,  5 Nov 2025 16:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762358705; cv=none; b=iFdFlfEDF9UgJtoo5HwmIYEJl63+VRCDcPIUdtZj+r6QhgsIzrmWjWEQ9X8NslnQvtdS4WBOBFXyjH1+em4WEDp9Dqht//a4MY4n2vVYCNtsi0ZOFUuTP5X8ukjr0ig3ptAe6Ptg2Zej5OJlRnpRsALsD1b1Q2YwNGSX5fuFGkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762358705; c=relaxed/simple;
	bh=Vc8K3MrTyVwbjqp/DCwioUL/LWadEWrFyl8zAIAawBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SZjnpqfxb6jukRNbpicOg5pcCcfM0cC/zMR/vPHisCqezO4J+SOUHVfMPVKpZQx7joK6SrBKswVJtuTEDnrmIEMpuWYTRZq5MK08ZlfVscLzyU3t4kyG2In30X4s5YzhnAWpejyGtx98/6qFIBQ46hN3G4sp6cFZtFJD5ecF1O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WWxLLBhl; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762358704; x=1793894704;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Vc8K3MrTyVwbjqp/DCwioUL/LWadEWrFyl8zAIAawBA=;
  b=WWxLLBhl7yIK6JGmib04vE0mFhsfXn2YkEfHDIn3tYvE3K9Vb6Oll/Z0
   52aZM8r060HRaAgwsy0C293rkhEsYxTLAV9Et6yH4NoJMjkqELH8cUIuX
   AS3bCtrJA9vzvOD62VtMbkgxgsvKfOX0DP9pGp6IqVPdaty5Kq/jIqS8R
   UacmOIcLvF6LSK5gAj9mO9Ezw01YoPQbS+hG9D+dRqrk96LEEGQbXtAuU
   e0VgAVJD2RZ0wEkSfgRfJ4jXKO9JESZqV3TkdzmfdvoU/nkNW5sRgpZBO
   r6oscRlb3jhPYu/wJLvBmyov8F94I7fsSmT/Ug8FY9M4r7Wz00fZ8MTvm
   w==;
X-CSE-ConnectionGUID: LuP+QlqfRtKVDcQsAF6BJw==
X-CSE-MsgGUID: 4FKFNoJUQd+veTUGGHjH/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="75829680"
X-IronPort-AV: E=Sophos;i="6.19,282,1754982000"; 
   d="scan'208";a="75829680"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 08:04:45 -0800
X-CSE-ConnectionGUID: uKDzES6cQJ+/2F/g+UvqTw==
X-CSE-MsgGUID: reYSz8GhRLO04UAr3rNsZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,282,1754982000"; 
   d="scan'208";a="210969542"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 05 Nov 2025 08:04:40 -0800
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vGfzS-000SoS-0u;
	Wed, 05 Nov 2025 16:04:24 +0000
Date: Thu, 6 Nov 2025 00:02:07 +0800
From: kernel test robot <lkp@intel.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	David Ahern <dsahern@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Mina Almasry <almasrymina@google.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Stanislav Fomichev <sdf@fomichev.me>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v6 3/6] net: devmem: prepare for autorelease rx
 token management
Message-ID: <202511052307.doTV8fDn-lkp@intel.com>
References: <20251104-scratch-bobbyeshleman-devmem-tcp-token-upstream-v6-3-ea98cf4d40b3@meta.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104-scratch-bobbyeshleman-devmem-tcp-token-upstream-v6-3-ea98cf4d40b3@meta.com>

Hi Bobby,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 255d75ef029f33f75fcf5015052b7302486f7ad2]

url:    https://github.com/intel-lab-lkp/linux/commits/Bobby-Eshleman/net-devmem-rename-tx_vec-to-vec-in-dmabuf-binding/20251105-092703
base:   255d75ef029f33f75fcf5015052b7302486f7ad2
patch link:    https://lore.kernel.org/r/20251104-scratch-bobbyeshleman-devmem-tcp-token-upstream-v6-3-ea98cf4d40b3%40meta.com
patch subject: [PATCH net-next v6 3/6] net: devmem: prepare for autorelease rx token management
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20251105/202511052307.doTV8fDn-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251105/202511052307.doTV8fDn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511052307.doTV8fDn-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> net/core/sock.c:1107:12: warning: variable 'ret' is uninitialized when used here [-Wuninitialized]
    1107 |                                 return ret;
         |                                        ^~~
   net/core/sock.c:1095:9: note: initialize the variable 'ret' to silence this warning
    1095 |         int ret;
         |                ^
         |                 = 0
   1 warning generated.
--
>> net/ipv4/tcp.c:2626:6: warning: variable 'refs' is uninitialized when used here [-Wuninitialized]
    2626 |                                         refs++;
         |                                         ^~~~
   net/ipv4/tcp.c:2496:10: note: initialize the variable 'refs' to silence this warning
    2496 |         int refs;
         |                 ^
         |                  = 0
   1 warning generated.


vim +/ret +1107 net/core/sock.c

  1085	
  1086	static noinline_for_stack int
  1087	sock_devmem_dontneed_manual_release(struct sock *sk, struct dmabuf_token *tokens,
  1088					    unsigned int num_tokens)
  1089	{
  1090		struct net_iov *niov;
  1091		unsigned int i, j;
  1092		netmem_ref netmem;
  1093		unsigned int token;
  1094		int num_frags = 0;
  1095		int ret;
  1096	
  1097		if (!sk->sk_devmem_info.binding)
  1098			return -EINVAL;
  1099	
  1100		for (i = 0; i < num_tokens; i++) {
  1101			for (j = 0; j < tokens[i].token_count; j++) {
  1102				token = tokens[i].token_start + j;
  1103				if (token >= sk->sk_devmem_info.binding->dmabuf->size / PAGE_SIZE)
  1104					break;
  1105	
  1106				if (++num_frags > MAX_DONTNEED_FRAGS)
> 1107					return ret;
  1108	
  1109				niov = sk->sk_devmem_info.binding->vec[token];
  1110				if (atomic_dec_and_test(&niov->uref)) {
  1111					netmem = net_iov_to_netmem(niov);
  1112					WARN_ON_ONCE(!napi_pp_put_page(netmem));
  1113				}
  1114				ret++;
  1115			}
  1116		}
  1117	
  1118		atomic_sub(ret, &sk->sk_devmem_info.outstanding_urefs);
  1119	
  1120		return ret;
  1121	}
  1122	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

