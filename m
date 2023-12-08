Return-Path: <linux-arch+bounces-802-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF7280A7AA
	for <lists+linux-arch@lfdr.de>; Fri,  8 Dec 2023 16:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7DDD1F211F7
	for <lists+linux-arch@lfdr.de>; Fri,  8 Dec 2023 15:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64054328DF;
	Fri,  8 Dec 2023 15:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FTpP+iTP"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 206F01985;
	Fri,  8 Dec 2023 07:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702050065; x=1733586065;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PxrakpGuqUfUuHtiDzTjJnJ7tn9jbK7epdaQHMlqyWM=;
  b=FTpP+iTPVbcCtaelFrP3PUcLKWPnNfzzz2gllqKyvG/TkqAaMsXuVO/7
   9XIZrJHROU7NNxnfE4fseEDk4RuSy9Z5d5dVXDjSa1u7AGQJJrx1r20I1
   TvvufNedWO53iKL+iiU/MmLhfzihgYvWCi2+w5DhrUoHmJqGLayTN1MMG
   uo8JeBa7EoQHLOqLlMUpstjype2Bc3jgwNR6qekrkjvSKihsmS3H78qmU
   OVpw0iox70VcijSj34wB5lcrO9F0j8iWCcgF9S2oqCrEqhOK3FvBGHkBY
   BekJFCb5tadsMbKP7zQI1C29r4T/Lc+GHpZ7r71jJUqDgLdhpeVNkFT9y
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="397212535"
X-IronPort-AV: E=Sophos;i="6.04,261,1695711600"; 
   d="scan'208";a="397212535"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 07:41:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="842650843"
X-IronPort-AV: E=Sophos;i="6.04,261,1695711600"; 
   d="scan'208";a="842650843"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 08 Dec 2023 07:40:58 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rBcyF-000DuR-3A;
	Fri, 08 Dec 2023 15:40:55 +0000
Date: Fri, 8 Dec 2023 23:40:15 +0800
From: kernel test robot <lkp@intel.com>
To: Mina Almasry <almasrymina@google.com>,
	Shailend Chand <shailend@google.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
	bpf@vger.kernel.org, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Cc: oe-kbuild-all@lists.linux.dev, Mina Almasry <almasrymina@google.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kaiyuan Zhang <kaiyuanz@google.com>,
	Jeroen de Borst <jeroendb@google.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>,
	David Ahern <dsahern@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Yunsheng Lin <linyunsheng@huawei.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Eric Dumazet <edumazet@google.com>,
	Shakeel Butt <shakeelb@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Praveen Kaligineedi <pkaligineedi@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [net-next v1 13/16] tcp: RX path for devmem TCP
Message-ID: <202312082353.lFKTtexo-lkp@intel.com>
References: <20231208005250.2910004-14-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208005250.2910004-14-almasrymina@google.com>

Hi Mina,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Mina-Almasry/net-page_pool-factor-out-releasing-DMA-from-releasing-the-page/20231208-085531
base:   net-next/main
patch link:    https://lore.kernel.org/r/20231208005250.2910004-14-almasrymina%40google.com
patch subject: [net-next v1 13/16] tcp: RX path for devmem TCP
config: alpha-defconfig (https://download.01.org/0day-ci/archive/20231208/202312082353.lFKTtexo-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231208/202312082353.lFKTtexo-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312082353.lFKTtexo-lkp@intel.com/

All errors (new ones prefixed by >>):

   net/ipv4/tcp.c: In function 'tcp_recvmsg_dmabuf':
>> net/ipv4/tcp.c:2348:57: error: 'SO_DEVMEM_LINEAR' undeclared (first use in this function)
    2348 |                         err = put_cmsg(msg, SOL_SOCKET, SO_DEVMEM_LINEAR,
         |                                                         ^~~~~~~~~~~~~~~~
   net/ipv4/tcp.c:2348:57: note: each undeclared identifier is reported only once for each function it appears in
>> net/ipv4/tcp.c:2411:48: error: 'SO_DEVMEM_DMABUF' undeclared (first use in this function)
    2411 |                                                SO_DEVMEM_DMABUF,
         |                                                ^~~~~~~~~~~~~~~~


vim +/SO_DEVMEM_LINEAR +2348 net/ipv4/tcp.c

  2306	
  2307	/* On error, returns the -errno. On success, returns number of bytes sent to the
  2308	 * user. May not consume all of @remaining_len.
  2309	 */
  2310	static int tcp_recvmsg_dmabuf(const struct sock *sk, const struct sk_buff *skb,
  2311				      unsigned int offset, struct msghdr *msg,
  2312				      int remaining_len)
  2313	{
  2314		struct dmabuf_cmsg dmabuf_cmsg = { 0 };
  2315		unsigned int start;
  2316		int i, copy, n;
  2317		int sent = 0;
  2318		int err = 0;
  2319	
  2320		do {
  2321			start = skb_headlen(skb);
  2322	
  2323			if (!skb->dmabuf) {
  2324				err = -ENODEV;
  2325				goto out;
  2326			}
  2327	
  2328			/* Copy header. */
  2329			copy = start - offset;
  2330			if (copy > 0) {
  2331				copy = min(copy, remaining_len);
  2332	
  2333				n = copy_to_iter(skb->data + offset, copy,
  2334						 &msg->msg_iter);
  2335				if (n != copy) {
  2336					err = -EFAULT;
  2337					goto out;
  2338				}
  2339	
  2340				offset += copy;
  2341				remaining_len -= copy;
  2342	
  2343				/* First a dmabuf_cmsg for # bytes copied to user
  2344				 * buffer.
  2345				 */
  2346				memset(&dmabuf_cmsg, 0, sizeof(dmabuf_cmsg));
  2347				dmabuf_cmsg.frag_size = copy;
> 2348				err = put_cmsg(msg, SOL_SOCKET, SO_DEVMEM_LINEAR,
  2349					       sizeof(dmabuf_cmsg), &dmabuf_cmsg);
  2350				if (err || msg->msg_flags & MSG_CTRUNC) {
  2351					msg->msg_flags &= ~MSG_CTRUNC;
  2352					if (!err)
  2353						err = -ETOOSMALL;
  2354					goto out;
  2355				}
  2356	
  2357				sent += copy;
  2358	
  2359				if (remaining_len == 0)
  2360					goto out;
  2361			}
  2362	
  2363			/* after that, send information of dmabuf pages through a
  2364			 * sequence of cmsg
  2365			 */
  2366			for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
  2367				skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
  2368				struct page_pool_iov *ppiov;
  2369				u64 frag_offset;
  2370				u32 user_token;
  2371				int end;
  2372	
  2373				/* skb->dmabuf should indicate that ALL the frags in
  2374				 * this skb are dmabuf page_pool_iovs. We're checking
  2375				 * for that flag above, but also check individual frags
  2376				 * here. If the tcp stack is not setting skb->dmabuf
  2377				 * correctly, we still don't want to crash here when
  2378				 * accessing pgmap or priv below.
  2379				 */
  2380				if (!skb_frag_page_pool_iov(frag)) {
  2381					net_err_ratelimited("Found non-dmabuf skb with page_pool_iov");
  2382					err = -ENODEV;
  2383					goto out;
  2384				}
  2385	
  2386				ppiov = skb_frag_page_pool_iov(frag);
  2387				end = start + skb_frag_size(frag);
  2388				copy = end - offset;
  2389	
  2390				if (copy > 0) {
  2391					copy = min(copy, remaining_len);
  2392	
  2393					frag_offset = page_pool_iov_virtual_addr(ppiov) +
  2394						      skb_frag_off(frag) + offset -
  2395						      start;
  2396					dmabuf_cmsg.frag_offset = frag_offset;
  2397					dmabuf_cmsg.frag_size = copy;
  2398					err = xa_alloc((struct xarray *)&sk->sk_user_pages,
  2399						       &user_token, frag->bv_page,
  2400						       xa_limit_31b, GFP_KERNEL);
  2401					if (err)
  2402						goto out;
  2403	
  2404					dmabuf_cmsg.frag_token = user_token;
  2405					dmabuf_cmsg.dmabuf_id = page_pool_iov_binding_id(ppiov);
  2406	
  2407					offset += copy;
  2408					remaining_len -= copy;
  2409	
  2410					err = put_cmsg(msg, SOL_SOCKET,
> 2411						       SO_DEVMEM_DMABUF,
  2412						       sizeof(dmabuf_cmsg),
  2413						       &dmabuf_cmsg);
  2414					if (err || msg->msg_flags & MSG_CTRUNC) {
  2415						msg->msg_flags &= ~MSG_CTRUNC;
  2416						xa_erase((struct xarray *)&sk->sk_user_pages,
  2417							 user_token);
  2418						if (!err)
  2419							err = -ETOOSMALL;
  2420						goto out;
  2421					}
  2422	
  2423					__skb_frag_ref(frag);
  2424	
  2425					sent += copy;
  2426	
  2427					if (remaining_len == 0)
  2428						goto out;
  2429				}
  2430				start = end;
  2431			}
  2432	
  2433			if (!remaining_len)
  2434				goto out;
  2435	
  2436			/* if remaining_len is not satisfied yet, we need to go to the
  2437			 * next frag in the frag_list to satisfy remaining_len.
  2438			 */
  2439			skb = skb_shinfo(skb)->frag_list ?: skb->next;
  2440	
  2441			offset = offset - start;
  2442		} while (skb);
  2443	
  2444		if (remaining_len) {
  2445			err = -EFAULT;
  2446			goto out;
  2447		}
  2448	
  2449	out:
  2450		if (!sent)
  2451			sent = err;
  2452	
  2453		return sent;
  2454	}
  2455	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

