Return-Path: <linux-arch+bounces-15716-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C114D0607A
	for <lists+linux-arch@lfdr.de>; Thu, 08 Jan 2026 21:22:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2967E301D312
	for <lists+linux-arch@lfdr.de>; Thu,  8 Jan 2026 20:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3300328614;
	Thu,  8 Jan 2026 20:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dE30YEXF"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CB81A23A0;
	Thu,  8 Jan 2026 20:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767903747; cv=none; b=lrizul+YAzEEBQp4jJZh4tH8HEK4IE6o5IbGJW/RS86iJgFJ+9HOZMzI90ARf6hqjhNrZudXmCVtiE4PMlaL5ILS41kd1OQi39CuLZmyEduK4sZwLT/xJaqD6nLsFDVKJn4/IENqvwIG9xLcyP7O5zeNhNH1X29U1NTn9vaaeg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767903747; c=relaxed/simple;
	bh=GdQrN+ZQRYM/rEQoK2EVWRblOIHzv0OWm75G2cMva8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y2CTnUDap8OQLdJGhg0c8XnmA2aaMXacvyGcLjXmRJMavN746olJrENe3wo6+npup+h6nmWVNS0lOc0GatbV/DC1BUvCxKdCk6u11C6LGrqtL+/6C7n5v8XUYjGvzw0JPfMpFqEXEh08WrR8nR63afs+gaCATIEYHrZqw2gHa8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dE30YEXF; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767903745; x=1799439745;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GdQrN+ZQRYM/rEQoK2EVWRblOIHzv0OWm75G2cMva8I=;
  b=dE30YEXFh3VEApy4TgVlRzkFD/nPBeEPmUVYU++6EcDdO/24Nze2pMTn
   g5546nm5IBWeeUNnlYRIwXcr5GCv6yYt1u9i0j9UT78f4tWE0gQXD2+d6
   dBy/fB22b0NJGhZo/EmU80m0KRM0jFxvLBMvzXwN1bqdYwqJ7heuZQ765
   8QaUsuHBlpQv+oHngD+QFdvK6oJ20uwVXgbcjUcwuIGiGqq1aqiuBPFkp
   R35IjPP8yrlPfv3G5TAAYxs7JQHElMkJiid5sL47Oz5fObJsAMJrz2fQ+
   aEciOsxP/4UP0Fq4sOJIL1qhK2KGO+c2g308PnCaY+YMHGIvCrHNohioX
   w==;
X-CSE-ConnectionGUID: XCzTnsmwRr+biRUy5KXhgA==
X-CSE-MsgGUID: 2iJ8O99CTOqdy7Z5RWYnVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11665"; a="86706514"
X-IronPort-AV: E=Sophos;i="6.21,211,1763452800"; 
   d="scan'208";a="86706514"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2026 12:22:24 -0800
X-CSE-ConnectionGUID: HKw0EADDT9S18G4SjpZ19Q==
X-CSE-MsgGUID: SCDiEARCQYSm/ua3y5cAtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,211,1763452800"; 
   d="scan'208";a="207775745"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 08 Jan 2026 12:22:18 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vdwWO-0000000058K-1XXv;
	Thu, 08 Jan 2026 20:22:16 +0000
Date: Fri, 9 Jan 2026 04:21:38 +0800
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
	Donald Hunter <donald.hunter@gmail.com>,
	Mina Almasry <almasrymina@google.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Stanislav Fomichev <sdf@fomichev.me>, asml.silence@gmail.com,
	matttbe@kernel.org, skhawaja@google.com,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v8 3/5] net: devmem: implement autorelease token
 management
Message-ID: <202601090411.LCEg5Rem-lkp@intel.com>
References: <20260107-scratch-bobbyeshleman-devmem-tcp-token-upstream-v8-3-92c968631496@meta.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260107-scratch-bobbyeshleman-devmem-tcp-token-upstream-v8-3-92c968631496@meta.com>

Hi Bobby,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Bobby-Eshleman/net-devmem-refactor-sock_devmem_dontneed-for-autorelease-split/20260108-095740
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260107-scratch-bobbyeshleman-devmem-tcp-token-upstream-v8-3-92c968631496%40meta.com
patch subject: [PATCH net-next v8 3/5] net: devmem: implement autorelease token management
config: sparc64-defconfig (https://download.01.org/0day-ci/archive/20260109/202601090411.LCEg5Rem-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260109/202601090411.LCEg5Rem-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601090411.LCEg5Rem-lkp@intel.com/

All errors (new ones prefixed by >>):

>> net/ipv4/tcp.c:2600:6: error: call to undeclared function 'net_devmem_dmabuf_binding_get'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    2600 |                                         net_devmem_dmabuf_binding_get(binding);
         |                                         ^
   net/ipv4/tcp.c:2600:6: note: did you mean 'net_devmem_dmabuf_binding_put'?
   net/ipv4/../core/devmem.h:163:1: note: 'net_devmem_dmabuf_binding_put' declared here
     163 | net_devmem_dmabuf_binding_put(struct net_devmem_dmabuf_binding *binding)
         | ^
   1 error generated.


vim +/net_devmem_dmabuf_binding_get +2600 net/ipv4/tcp.c

  2498	
  2499	/* On error, returns the -errno. On success, returns number of bytes sent to the
  2500	 * user. May not consume all of @remaining_len.
  2501	 */
  2502	static int tcp_recvmsg_dmabuf(struct sock *sk, const struct sk_buff *skb,
  2503				      unsigned int offset, struct msghdr *msg,
  2504				      int remaining_len)
  2505	{
  2506		struct dmabuf_cmsg dmabuf_cmsg = { 0 };
  2507		struct tcp_xa_pool tcp_xa_pool;
  2508		unsigned int start;
  2509		int i, copy, n;
  2510		int sent = 0;
  2511		int err = 0;
  2512	
  2513		tcp_xa_pool.max = 0;
  2514		tcp_xa_pool.idx = 0;
  2515		do {
  2516			start = skb_headlen(skb);
  2517	
  2518			if (skb_frags_readable(skb)) {
  2519				err = -ENODEV;
  2520				goto out;
  2521			}
  2522	
  2523			/* Copy header. */
  2524			copy = start - offset;
  2525			if (copy > 0) {
  2526				copy = min(copy, remaining_len);
  2527	
  2528				n = copy_to_iter(skb->data + offset, copy,
  2529						 &msg->msg_iter);
  2530				if (n != copy) {
  2531					err = -EFAULT;
  2532					goto out;
  2533				}
  2534	
  2535				offset += copy;
  2536				remaining_len -= copy;
  2537	
  2538				/* First a dmabuf_cmsg for # bytes copied to user
  2539				 * buffer.
  2540				 */
  2541				memset(&dmabuf_cmsg, 0, sizeof(dmabuf_cmsg));
  2542				dmabuf_cmsg.frag_size = copy;
  2543				err = put_cmsg_notrunc(msg, SOL_SOCKET,
  2544						       SO_DEVMEM_LINEAR,
  2545						       sizeof(dmabuf_cmsg),
  2546						       &dmabuf_cmsg);
  2547				if (err)
  2548					goto out;
  2549	
  2550				sent += copy;
  2551	
  2552				if (remaining_len == 0)
  2553					goto out;
  2554			}
  2555	
  2556			/* after that, send information of dmabuf pages through a
  2557			 * sequence of cmsg
  2558			 */
  2559			for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
  2560				struct net_devmem_dmabuf_binding *binding = NULL;
  2561				skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
  2562				struct net_iov *niov;
  2563				u64 frag_offset;
  2564				int end;
  2565	
  2566				/* !skb_frags_readable() should indicate that ALL the
  2567				 * frags in this skb are dmabuf net_iovs. We're checking
  2568				 * for that flag above, but also check individual frags
  2569				 * here. If the tcp stack is not setting
  2570				 * skb_frags_readable() correctly, we still don't want
  2571				 * to crash here.
  2572				 */
  2573				if (!skb_frag_net_iov(frag)) {
  2574					net_err_ratelimited("Found non-dmabuf skb with net_iov");
  2575					err = -ENODEV;
  2576					goto out;
  2577				}
  2578	
  2579				niov = skb_frag_net_iov(frag);
  2580				if (!net_is_devmem_iov(niov)) {
  2581					err = -ENODEV;
  2582					goto out;
  2583				}
  2584	
  2585				end = start + skb_frag_size(frag);
  2586				copy = end - offset;
  2587	
  2588				if (copy > 0) {
  2589					copy = min(copy, remaining_len);
  2590	
  2591					frag_offset = net_iov_virtual_addr(niov) +
  2592						      skb_frag_off(frag) + offset -
  2593						      start;
  2594					dmabuf_cmsg.frag_offset = frag_offset;
  2595					dmabuf_cmsg.frag_size = copy;
  2596	
  2597					binding = net_devmem_iov_binding(niov);
  2598	
  2599					if (!sk->sk_devmem_info.binding) {
> 2600						net_devmem_dmabuf_binding_get(binding);
  2601						sk->sk_devmem_info.binding = binding;
  2602					}
  2603	
  2604					if (sk->sk_devmem_info.binding != binding) {
  2605						err = -EFAULT;
  2606						goto out;
  2607					}
  2608	
  2609					if (static_branch_unlikely(&tcp_devmem_ar_key)) {
  2610						err = tcp_xa_pool_refill(sk,
  2611									 &tcp_xa_pool,
  2612									 skb_shinfo(skb)->nr_frags - i);
  2613						if (err)
  2614							goto out;
  2615	
  2616						dmabuf_cmsg.frag_token =
  2617							tcp_xa_pool.tokens[tcp_xa_pool.idx];
  2618					} else {
  2619						dmabuf_cmsg.frag_token =
  2620							net_iov_virtual_addr(niov) >> PAGE_SHIFT;
  2621					}
  2622	
  2623	
  2624					/* Will perform the exchange later */
  2625					dmabuf_cmsg.dmabuf_id = net_devmem_iov_binding_id(niov);
  2626	
  2627					offset += copy;
  2628					remaining_len -= copy;
  2629	
  2630					err = put_cmsg_notrunc(msg, SOL_SOCKET,
  2631							       SO_DEVMEM_DMABUF,
  2632							       sizeof(dmabuf_cmsg),
  2633							       &dmabuf_cmsg);
  2634					if (err)
  2635						goto out;
  2636	
  2637					tcp_xa_pool_inc_pp_ref_count(&tcp_xa_pool, frag);
  2638	
  2639					sent += copy;
  2640	
  2641					if (remaining_len == 0)
  2642						goto out;
  2643				}
  2644				start = end;
  2645			}
  2646	
  2647			tcp_xa_pool_commit(sk, &tcp_xa_pool);
  2648			if (!remaining_len)
  2649				goto out;
  2650	
  2651			/* if remaining_len is not satisfied yet, we need to go to the
  2652			 * next frag in the frag_list to satisfy remaining_len.
  2653			 */
  2654			skb = skb_shinfo(skb)->frag_list ?: skb->next;
  2655	
  2656			offset = offset - start;
  2657		} while (skb);
  2658	
  2659		if (remaining_len) {
  2660			err = -EFAULT;
  2661			goto out;
  2662		}
  2663	
  2664	out:
  2665		tcp_xa_pool_commit(sk, &tcp_xa_pool);
  2666		if (!sent)
  2667			sent = err;
  2668	
  2669		return sent;
  2670	}
  2671	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

