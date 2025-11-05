Return-Path: <linux-arch+bounces-14543-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 96BF6C37CCF
	for <lists+linux-arch@lfdr.de>; Wed, 05 Nov 2025 21:57:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7F33A4E43C7
	for <lists+linux-arch@lfdr.de>; Wed,  5 Nov 2025 20:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB62346FCB;
	Wed,  5 Nov 2025 20:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iDrI6EBZ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B639F30EF7A;
	Wed,  5 Nov 2025 20:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762376215; cv=none; b=SvyxoRt1dzM90eVf+7BLVWrbItPqdDQJTa05+YcZe0Wawmj5vaqlbAFBg854ZTiI1+89h8ehkzCup+lid/1xHCGKIqzpxUmUacCk5OPFMtEc+B8072e8uICnvrWPog5hDYQp2CBLUH6TP/FGxLqx+9j/dBekpCIZ1/M6vcge7ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762376215; c=relaxed/simple;
	bh=fC9X5qQj+U0WNsqsc7Qvk95wkvv4i6g0VGE+cP4MB1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t3m5pkRzozRZ2XAb0cEUycNq/BsqPr9VfKbHGoQ4TkfUOUlfrmAcTpJF7rffN9QqrgU42BUb4HeE88BjSZnExnetLhHGSy9MPy6mFPRO/CT4UqBQje1PWZ5mwOfA07t3EnDtznBuGrfR659SFSDCqwGZv7ERZx4IjrGYsDECsJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iDrI6EBZ; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762376213; x=1793912213;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fC9X5qQj+U0WNsqsc7Qvk95wkvv4i6g0VGE+cP4MB1g=;
  b=iDrI6EBZ0pWtm5nfv4Lhmq3YD9VmB7PVC/aJZHx/f+Z7oIdKsiOTCiBO
   U5s83ziGDDs+4YzmjvHBQX8FTpeFSdXXMY7vYxpssdHqryitMjI3i1xuj
   4v2CasrDZEFeg7yxATEvngSufhO+vT6Q05IwJl6ecHp1k09jRfwnaCHep
   K6I3+ne/a1kA7BWtL8hLXtG7yPJbyaugbp+UIMp2HArkq5mfH4hM/c/R9
   carFsrwUTFjo7hL0u7HvVYLpcdGGAZvsd/azKAZ/sBpk46c1uxYazJ8Is
   Sa1UgVc62FXFAjV6pnlxNXUDjuy/CVQlCJbuR30ubpn6DAs89Pn1Dk2Fg
   A==;
X-CSE-ConnectionGUID: WTOw55ZhS/msdhXRrV9FrA==
X-CSE-MsgGUID: FzHckbY+TUq+CEmvAEPPtg==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="75618434"
X-IronPort-AV: E=Sophos;i="6.19,282,1754982000"; 
   d="scan'208";a="75618434"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 12:56:53 -0800
X-CSE-ConnectionGUID: AeMS6Am/TCalEZpqKR8AjA==
X-CSE-MsgGUID: 3GJ74quFQrKrVc0jEipUHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,282,1754982000"; 
   d="scan'208";a="187401197"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 05 Nov 2025 12:56:48 -0800
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vGkYd-000T7m-1A;
	Wed, 05 Nov 2025 20:56:46 +0000
Date: Thu, 6 Nov 2025 04:55:32 +0800
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
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Stanislav Fomichev <sdf@fomichev.me>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v6 3/6] net: devmem: prepare for autorelease rx
 token management
Message-ID: <202511060345.AQs0FTNg-lkp@intel.com>
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
config: arc-nsimosci_hs_defconfig (https://download.01.org/0day-ci/archive/20251106/202511060345.AQs0FTNg-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251106/202511060345.AQs0FTNg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511060345.AQs0FTNg-lkp@intel.com/

All warnings (new ones prefixed by >>):

   net/ipv4/tcp.c: In function 'tcp_recvmsg_dmabuf':
>> net/ipv4/tcp.c:2661:12: warning: 'refs' is used uninitialized [-Wuninitialized]
    2661 |         if (refs > 0)
         |            ^
   net/ipv4/tcp.c:2496:13: note: 'refs' was declared here
    2496 |         int refs;
         |             ^~~~


vim +/refs +2661 net/ipv4/tcp.c

  2481	
  2482	/* On error, returns the -errno. On success, returns number of bytes sent to the
  2483	 * user. May not consume all of @remaining_len.
  2484	 */
  2485	static int tcp_recvmsg_dmabuf(struct sock *sk, const struct sk_buff *skb,
  2486				      unsigned int offset, struct msghdr *msg,
  2487				      int remaining_len)
  2488	{
  2489		struct net_devmem_dmabuf_binding *binding = NULL;
  2490		struct dmabuf_cmsg dmabuf_cmsg = { 0 };
  2491		struct tcp_xa_pool tcp_xa_pool;
  2492		unsigned int start;
  2493		int i, copy, n;
  2494		int sent = 0;
  2495		int err = 0;
  2496		int refs;
  2497	
  2498		tcp_xa_pool.max = 0;
  2499		tcp_xa_pool.idx = 0;
  2500		do {
  2501			start = skb_headlen(skb);
  2502	
  2503			if (skb_frags_readable(skb)) {
  2504				err = -ENODEV;
  2505				goto out;
  2506			}
  2507	
  2508			/* Copy header. */
  2509			copy = start - offset;
  2510			if (copy > 0) {
  2511				copy = min(copy, remaining_len);
  2512	
  2513				n = copy_to_iter(skb->data + offset, copy,
  2514						 &msg->msg_iter);
  2515				if (n != copy) {
  2516					err = -EFAULT;
  2517					goto out;
  2518				}
  2519	
  2520				offset += copy;
  2521				remaining_len -= copy;
  2522	
  2523				/* First a dmabuf_cmsg for # bytes copied to user
  2524				 * buffer.
  2525				 */
  2526				memset(&dmabuf_cmsg, 0, sizeof(dmabuf_cmsg));
  2527				dmabuf_cmsg.frag_size = copy;
  2528				err = put_cmsg_notrunc(msg, SOL_SOCKET,
  2529						       SO_DEVMEM_LINEAR,
  2530						       sizeof(dmabuf_cmsg),
  2531						       &dmabuf_cmsg);
  2532				if (err)
  2533					goto out;
  2534	
  2535				sent += copy;
  2536	
  2537				if (remaining_len == 0)
  2538					goto out;
  2539			}
  2540	
  2541			/* after that, send information of dmabuf pages through a
  2542			 * sequence of cmsg
  2543			 */
  2544			for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
  2545				skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
  2546				struct net_iov *niov;
  2547				u64 frag_offset;
  2548				u32 token;
  2549				int end;
  2550	
  2551				/* !skb_frags_readable() should indicate that ALL the
  2552				 * frags in this skb are dmabuf net_iovs. We're checking
  2553				 * for that flag above, but also check individual frags
  2554				 * here. If the tcp stack is not setting
  2555				 * skb_frags_readable() correctly, we still don't want
  2556				 * to crash here.
  2557				 */
  2558				if (!skb_frag_net_iov(frag)) {
  2559					net_err_ratelimited("Found non-dmabuf skb with net_iov");
  2560					err = -ENODEV;
  2561					goto out;
  2562				}
  2563	
  2564				niov = skb_frag_net_iov(frag);
  2565				if (!net_is_devmem_iov(niov)) {
  2566					err = -ENODEV;
  2567					goto out;
  2568				}
  2569	
  2570				end = start + skb_frag_size(frag);
  2571				copy = end - offset;
  2572	
  2573				if (copy > 0) {
  2574					copy = min(copy, remaining_len);
  2575	
  2576					frag_offset = net_iov_virtual_addr(niov) +
  2577						      skb_frag_off(frag) + offset -
  2578						      start;
  2579					dmabuf_cmsg.frag_offset = frag_offset;
  2580					dmabuf_cmsg.frag_size = copy;
  2581	
  2582					binding = net_devmem_iov_binding(niov);
  2583	
  2584					if (!sk->sk_devmem_info.binding)
  2585						sk->sk_devmem_info.binding = binding;
  2586	
  2587					if (sk->sk_devmem_info.binding != binding) {
  2588						err = -EFAULT;
  2589						goto out;
  2590					}
  2591	
  2592					if (sk->sk_devmem_info.autorelease) {
  2593						err = tcp_xa_pool_refill(sk, &tcp_xa_pool,
  2594									 skb_shinfo(skb)->nr_frags - i);
  2595						if (err)
  2596							goto out;
  2597	
  2598						dmabuf_cmsg.frag_token =
  2599							tcp_xa_pool.tokens[tcp_xa_pool.idx];
  2600					} else {
  2601						token = net_iov_virtual_addr(niov) >> PAGE_SHIFT;
  2602						dmabuf_cmsg.frag_token = token;
  2603					}
  2604	
  2605	
  2606					/* Will perform the exchange later */
  2607					dmabuf_cmsg.dmabuf_id = net_devmem_iov_binding_id(niov);
  2608	
  2609					offset += copy;
  2610					remaining_len -= copy;
  2611	
  2612					err = put_cmsg_notrunc(msg, SOL_SOCKET,
  2613							       SO_DEVMEM_DMABUF,
  2614							       sizeof(dmabuf_cmsg),
  2615							       &dmabuf_cmsg);
  2616					if (err)
  2617						goto out;
  2618	
  2619					if (sk->sk_devmem_info.autorelease) {
  2620						atomic_long_inc(&niov->pp_ref_count);
  2621						tcp_xa_pool.netmems[tcp_xa_pool.idx++] =
  2622							skb_frag_netmem(frag);
  2623					} else {
  2624						if (atomic_inc_return(&niov->uref) == 1)
  2625							atomic_long_inc(&niov->pp_ref_count);
  2626						refs++;
  2627					}
  2628	
  2629					sent += copy;
  2630	
  2631					if (remaining_len == 0)
  2632						goto out;
  2633				}
  2634				start = end;
  2635			}
  2636	
  2637			tcp_xa_pool_commit(sk, &tcp_xa_pool);
  2638	
  2639			if (!remaining_len)
  2640				goto out;
  2641	
  2642			/* if remaining_len is not satisfied yet, we need to go to the
  2643			 * next frag in the frag_list to satisfy remaining_len.
  2644			 */
  2645			skb = skb_shinfo(skb)->frag_list ?: skb->next;
  2646	
  2647			offset = offset - start;
  2648		} while (skb);
  2649	
  2650		if (remaining_len) {
  2651			err = -EFAULT;
  2652			goto out;
  2653		}
  2654	
  2655	out:
  2656		tcp_xa_pool_commit(sk, &tcp_xa_pool);
  2657	
  2658		if (!sent)
  2659			sent = err;
  2660	
> 2661		if (refs > 0)
  2662			atomic_add(refs, &sk->sk_devmem_info.outstanding_urefs);
  2663	
  2664		return sent;
  2665	}
  2666	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

