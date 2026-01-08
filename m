Return-Path: <linux-arch+bounces-15715-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A19D6D05D5F
	for <lists+linux-arch@lfdr.de>; Thu, 08 Jan 2026 20:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0779E301064C
	for <lists+linux-arch@lfdr.de>; Thu,  8 Jan 2026 19:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D03313272;
	Thu,  8 Jan 2026 19:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O2mY2EJM"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DD416EB42;
	Thu,  8 Jan 2026 19:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767900019; cv=none; b=c1GzZQzxx0TKAw+8xUp2Lwwm9jn+R6f8qlWn7B5N+fO8FbLbhuxzpBmeRDBQMXnp4YfxqXhGB2m1qY6N1gdVDynDsmSe0fXWsmxxoAun+iFTnoHRIb6ZTpiJPtyKoJXBs3KrqeZYG4OwCCMr34QFrMINN+MDxAqli+rlFQjIpfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767900019; c=relaxed/simple;
	bh=FBaPQlSoTU5UHUYndbWv1nQt4mmWHgIdDAUljiKLbro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RUyVtqyEYTXxOb/zmEecsVAU1i27FTwbayUdK1eLHig/84+e01tYyAljJy5Wxjmndtr2m2L+lDL48qnQ68AgSlRLhRQe1GpShQ2Mi7+4SJWolDrea8cMF0pwfL3hkhfBo9X0HmNhcOhSHqPJFZKWnru9IUET381NetMDTf58dBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O2mY2EJM; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767900018; x=1799436018;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FBaPQlSoTU5UHUYndbWv1nQt4mmWHgIdDAUljiKLbro=;
  b=O2mY2EJM8BABzGWqpu/7Mx60a3H3X1UMcfjO2X2l6147HNJztNdibzQG
   i38wt+g8hFRlwP80XKDYwd3+CylS9GtGfHZApYwPInzd01iKUWPE7MRfP
   IhrdKktwcCdq2pgkzKdNZ4vYmKJdmQoXgRtNJdOY8/9ju1grkzRUTbCp/
   IXaCd1eHp+q/Fn8vcEweJaLRrDh9vNgHR3pBlIwhwUdnTelAX7YEhL2aE
   b91T0kCG+NkO1LXNbegstUYIFRe3AduYI7FNew93p1p0aNZ3KWXZydnDF
   8pwljU9LYL9obZGhnceOMpCTMj8QgHqNp23wQBwOj7BDeIdk5EViYW7Jx
   g==;
X-CSE-ConnectionGUID: lNCDdACnTT2K4Ylh86U1tQ==
X-CSE-MsgGUID: h+uJI4oBR4qM/MJgSaCuJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11665"; a="86702597"
X-IronPort-AV: E=Sophos;i="6.21,211,1763452800"; 
   d="scan'208";a="86702597"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2026 11:20:16 -0800
X-CSE-ConnectionGUID: JN1S6bCYR3WKLjz2HSm2wg==
X-CSE-MsgGUID: WywU1gmIRreo/ZIK9+auZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,211,1763452800"; 
   d="scan'208";a="203197976"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 08 Jan 2026 11:20:08 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vdvYC-00000000568-2Bfv;
	Thu, 08 Jan 2026 19:20:04 +0000
Date: Fri, 9 Jan 2026 03:19:52 +0800
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
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Stanislav Fomichev <sdf@fomichev.me>, asml.silence@gmail.com,
	matttbe@kernel.org, skhawaja@google.com,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v8 3/5] net: devmem: implement autorelease token
 management
Message-ID: <202601090223.Ygqrrc5p-lkp@intel.com>
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
config: openrisc-defconfig (https://download.01.org/0day-ci/archive/20260109/202601090223.Ygqrrc5p-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260109/202601090223.Ygqrrc5p-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601090223.Ygqrrc5p-lkp@intel.com/

All errors (new ones prefixed by >>):

   net/ipv4/tcp.c: In function 'tcp_recvmsg_dmabuf':
>> net/ipv4/tcp.c:2600:41: error: implicit declaration of function 'net_devmem_dmabuf_binding_get'; did you mean 'net_devmem_dmabuf_binding_put'? [-Wimplicit-function-declaration]
    2600 |                                         net_devmem_dmabuf_binding_get(binding);
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                         net_devmem_dmabuf_binding_put


vim +2600 net/ipv4/tcp.c

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

