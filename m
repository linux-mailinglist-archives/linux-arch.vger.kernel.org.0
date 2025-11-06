Return-Path: <linux-arch+bounces-14555-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF64C3C01C
	for <lists+linux-arch@lfdr.de>; Thu, 06 Nov 2025 16:21:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E67E3A6454
	for <lists+linux-arch@lfdr.de>; Thu,  6 Nov 2025 15:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9BAD346FA6;
	Thu,  6 Nov 2025 15:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NGcOGbCW"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE29346E40
	for <linux-arch@vger.kernel.org>; Thu,  6 Nov 2025 15:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762442056; cv=none; b=oh8tGP5S3m1ikoPKm/OLbzJGPpcCIu/ukFeI2mhqaiyXaICBHDiV1JA1+ZaArswkr90Ec0bmN7jvD5BPTzIFo6I5T9SS322fs9Qhx5A6MpPQtLvhu/KNF8Cdb4o5fG4eVhPRhIfdisG91B7mNYhD70csnExZ0HJhBdiyqCTMLLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762442056; c=relaxed/simple;
	bh=o/UkQ5u97qWom/i/3OHl5FeeE6MKR73YOXiRcmWk9Qs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=HM1h/+IfJHw3LCVE24Rpj9mn+LWNAVBaClcuLqd7OOE5WoKGprrb51Nl215yjFItwptmCt/cvGVLaNsYEDgeYvCbYigHnT5HszMuKGl7aPkj2Mr0eWFmgFpXTHwQGzoGnefmNSMABm/K826rk8JkbPSeuVZKlpDv5Em6VG/GsgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NGcOGbCW; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-afcb7ae6ed0so181496466b.3
        for <linux-arch@vger.kernel.org>; Thu, 06 Nov 2025 07:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762442049; x=1763046849; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HagtsVyWDiv+KcI6/p888WZFkgTtFN1dnDWNBUt/rhk=;
        b=NGcOGbCWAq4Ba2UiaThxpaNzT080TN3ddisyR5LITdBLrXD9XiMY43AZNSfWzxrelT
         c7xbUFzdhM33RA/LeoR/HUCZf70DgxSInUi/aJFYjPZI2LLX52iHNFhXtuWOwA3xssrh
         BfMlaR9MPcecmPalE/bnF9Lcnx4vK1Z0kY5knc7eiiG9LbkPoWTtLNSyc5s3BS0HJdFP
         iFxTV21nLF/2NJCskOeOyAAknYFWWMgkGTY90HYh+eTQ1zyo5H3NH8FjjF65Bk/4cFNQ
         /NzRtSSnBTrZo/sA67oODxvuInrqNHzp5jOwiVCxXlyplfAeYNgl2Dw3T6nRzoze/4i0
         WJOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762442049; x=1763046849;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HagtsVyWDiv+KcI6/p888WZFkgTtFN1dnDWNBUt/rhk=;
        b=o11/pMoSlje15BPZqUQycovk0ZU9072U39k4wXVS5Rcl64J1IkKtU43ugTDWYzdOTp
         Y/R2/Wd0OLQAgA44mk4SEejyb27tpcdTpZjcAa19ajJt9gJxsfvnTjQvNUqeBiLMtdnB
         RNI8Z4+DsF+oiZavR3ekcTgpC5j7C1BJ0eXNewJdChBNEdF9ETapTAhSdT6wuOojyPPG
         y1S0yMnS3Z0SPPsVCMYoDJw5hZsc1EPTXlBFSZj8rUmS03+NmuzraKGZIjAvNMUdGMH0
         ES+RyeS6474zXPa52Ar9v1FUb6cE5B90kTDH48b9TcVGAxnaFaDHv1J7RA0xxhZxJBzC
         fTEw==
X-Forwarded-Encrypted: i=1; AJvYcCUroBZGkexI7IYNvHGRl9KLluIZqqyiuF2xx6juY1o5D4VzYfjc5wE6vKMwR2NkjpRWHeVOKKOQSMNp@vger.kernel.org
X-Gm-Message-State: AOJu0YxWS0fnmjGjc3uNl7a2hR1SRX2egKe9PlV9JCVjUiY+Ts3Z+JjE
	XM/3Qo0kjFfE6OM1qndUV1DXEyZ8LqAwpATa8z6Lqp79An0VooqSt/budPo2gGA8ins=
X-Gm-Gg: ASbGnctAGf5Dk5F2buIWgbqDCV7q4rWKeLDObIt4cbJo+Q0iHXWoez3HziEh1Bol34d
	44Xr/iv0D5XMlKNAKIYuQkhYJGZzqane/1rHm2JswLS20J6KfYB0x8nR7O91KjR1+ZUnPFlOCVO
	BqNxX1EhngOhJk6KvElVKLpSpwTai3sHClNnKqHChMcC24xx70pu8rB4MncOKIJadmfEi5lzG1z
	AvgA2FdIL+pRMOOMIaB8Py3g9idMQIKSXPMXYxn2mJCHmzXFhMUZBrcGUinKkt+KT1hBAKuUvEM
	vC9I19PXxsuteBdT018E+qVNY1vUOldjpAHuuj2nH7KnT/9wiwbk+DZkaRgDxvuMe3WKluHAe1g
	Y2PREfSCXSC40ygdNZG1Z20HIiv0/OWJ4DxxxOIuEnME2cQg69N8vHXt3ghTZ/Y+CxVD1i/zHCS
	x+4mUUyy+Ax2FD
X-Google-Smtp-Source: AGHT+IEsuIUvNLnPlwFN3+VmgnXrhObFfu4Be6ixdY6AL/4JqrPb9LdcBRAwep5DRtttB+5TfdujaQ==
X-Received: by 2002:a17:907:3fa6:b0:b04:67f3:890f with SMTP id a640c23a62f3a-b72654d3d36mr658748866b.33.1762442049245;
        Thu, 06 Nov 2025 07:14:09 -0800 (PST)
Received: from localhost ([87.213.113.147])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b728937fb6bsm243589266b.23.2025.11.06.07.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 07:14:08 -0800 (PST)
Date: Thu, 6 Nov 2025 18:14:07 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Bobby Eshleman <bobbyeshleman@gmail.com>,
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
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Stanislav Fomichev <sdf@fomichev.me>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v6 3/6] net: devmem: prepare for autorelease rx
 token management
Message-ID: <4aa34dd6-f5ea-40cf-8004-bbde053dc143@suswa.mountain>
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

url:    https://github.com/intel-lab-lkp/linux/commits/Bobby-Eshleman/net-devmem-rename-tx_vec-to-vec-in-dmabuf-binding/20251105-092703
base:   255d75ef029f33f75fcf5015052b7302486f7ad2
patch link:    https://lore.kernel.org/r/20251104-scratch-bobbyeshleman-devmem-tcp-token-upstream-v6-3-ea98cf4d40b3%40meta.com
patch subject: [PATCH net-next v6 3/6] net: devmem: prepare for autorelease rx token management
config: nios2-randconfig-r071-20251105 (https://download.01.org/0day-ci/archive/20251106/202511060352.2kPPX3xE-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 8.5.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202511060352.2kPPX3xE-lkp@intel.com/

New smatch warnings:
net/ipv4/tcp.c:2626 tcp_recvmsg_dmabuf() error: uninitialized symbol 'refs'.

vim +/refs +2626 net/ipv4/tcp.c

8f0b3cc9a4c102 Mina Almasry       2024-09-10  2485  static int tcp_recvmsg_dmabuf(struct sock *sk, const struct sk_buff *skb,
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2486  			      unsigned int offset, struct msghdr *msg,
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2487  			      int remaining_len)
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2488  {
45aa39492cf4dd Bobby Eshleman     2025-11-04  2489  	struct net_devmem_dmabuf_binding *binding = NULL;
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2490  	struct dmabuf_cmsg dmabuf_cmsg = { 0 };
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2491  	struct tcp_xa_pool tcp_xa_pool;
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2492  	unsigned int start;
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2493  	int i, copy, n;
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2494  	int sent = 0;
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2495  	int err = 0;
45aa39492cf4dd Bobby Eshleman     2025-11-04  2496  	int refs;

refs needs to be initialized to zero.  Best practice is to use
CONFIG_INIT_STACK_ALL_PATTERN for testing.

8f0b3cc9a4c102 Mina Almasry       2024-09-10  2497  
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2498  	tcp_xa_pool.max = 0;
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2499  	tcp_xa_pool.idx = 0;
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2500  	do {
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2501  		start = skb_headlen(skb);
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2502  
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2503  		if (skb_frags_readable(skb)) {
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2504  			err = -ENODEV;
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2505  			goto out;
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2506  		}
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2507  
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2508  		/* Copy header. */
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2509  		copy = start - offset;
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2510  		if (copy > 0) {
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2511  			copy = min(copy, remaining_len);
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2512  
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2513  			n = copy_to_iter(skb->data + offset, copy,
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2514  					 &msg->msg_iter);
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2515  			if (n != copy) {
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2516  				err = -EFAULT;
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2517  				goto out;
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2518  			}
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2519  
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2520  			offset += copy;
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2521  			remaining_len -= copy;
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2522  
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2523  			/* First a dmabuf_cmsg for # bytes copied to user
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2524  			 * buffer.
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2525  			 */
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2526  			memset(&dmabuf_cmsg, 0, sizeof(dmabuf_cmsg));
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2527  			dmabuf_cmsg.frag_size = copy;
18912c520674ec Stanislav Fomichev 2025-02-24  2528  			err = put_cmsg_notrunc(msg, SOL_SOCKET,
18912c520674ec Stanislav Fomichev 2025-02-24  2529  					       SO_DEVMEM_LINEAR,
18912c520674ec Stanislav Fomichev 2025-02-24  2530  					       sizeof(dmabuf_cmsg),
18912c520674ec Stanislav Fomichev 2025-02-24  2531  					       &dmabuf_cmsg);
18912c520674ec Stanislav Fomichev 2025-02-24  2532  			if (err)
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2533  				goto out;
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2534  
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2535  			sent += copy;
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2536  
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2537  			if (remaining_len == 0)
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2538  				goto out;
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2539  		}
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2540  
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2541  		/* after that, send information of dmabuf pages through a
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2542  		 * sequence of cmsg
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2543  		 */
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2544  		for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2545  			skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2546  			struct net_iov *niov;
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2547  			u64 frag_offset;
45aa39492cf4dd Bobby Eshleman     2025-11-04  2548  			u32 token;
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2549  			int end;
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2550  
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2551  			/* !skb_frags_readable() should indicate that ALL the
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2552  			 * frags in this skb are dmabuf net_iovs. We're checking
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2553  			 * for that flag above, but also check individual frags
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2554  			 * here. If the tcp stack is not setting
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2555  			 * skb_frags_readable() correctly, we still don't want
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2556  			 * to crash here.
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2557  			 */
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2558  			if (!skb_frag_net_iov(frag)) {
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2559  				net_err_ratelimited("Found non-dmabuf skb with net_iov");
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2560  				err = -ENODEV;
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2561  				goto out;
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2562  			}
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2563  
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2564  			niov = skb_frag_net_iov(frag);
69e39537b66232 Pavel Begunkov     2025-02-04  2565  			if (!net_is_devmem_iov(niov)) {
69e39537b66232 Pavel Begunkov     2025-02-04  2566  				err = -ENODEV;
69e39537b66232 Pavel Begunkov     2025-02-04  2567  				goto out;
69e39537b66232 Pavel Begunkov     2025-02-04  2568  			}
69e39537b66232 Pavel Begunkov     2025-02-04  2569  
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2570  			end = start + skb_frag_size(frag);
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2571  			copy = end - offset;
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2572  
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2573  			if (copy > 0) {
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2574  				copy = min(copy, remaining_len);
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2575  
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2576  				frag_offset = net_iov_virtual_addr(niov) +
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2577  					      skb_frag_off(frag) + offset -
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2578  					      start;
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2579  				dmabuf_cmsg.frag_offset = frag_offset;
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2580  				dmabuf_cmsg.frag_size = copy;
45aa39492cf4dd Bobby Eshleman     2025-11-04  2581  
45aa39492cf4dd Bobby Eshleman     2025-11-04  2582  				binding = net_devmem_iov_binding(niov);
45aa39492cf4dd Bobby Eshleman     2025-11-04  2583  
45aa39492cf4dd Bobby Eshleman     2025-11-04  2584  				if (!sk->sk_devmem_info.binding)
45aa39492cf4dd Bobby Eshleman     2025-11-04  2585  					sk->sk_devmem_info.binding = binding;
45aa39492cf4dd Bobby Eshleman     2025-11-04  2586  
45aa39492cf4dd Bobby Eshleman     2025-11-04  2587  				if (sk->sk_devmem_info.binding != binding) {
45aa39492cf4dd Bobby Eshleman     2025-11-04  2588  					err = -EFAULT;
45aa39492cf4dd Bobby Eshleman     2025-11-04  2589  					goto out;
45aa39492cf4dd Bobby Eshleman     2025-11-04  2590  				}
45aa39492cf4dd Bobby Eshleman     2025-11-04  2591  
45aa39492cf4dd Bobby Eshleman     2025-11-04  2592  				if (sk->sk_devmem_info.autorelease) {
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2593  					err = tcp_xa_pool_refill(sk, &tcp_xa_pool,
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2594  								 skb_shinfo(skb)->nr_frags - i);
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2595  					if (err)
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2596  						goto out;
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2597  
45aa39492cf4dd Bobby Eshleman     2025-11-04  2598  					dmabuf_cmsg.frag_token =
45aa39492cf4dd Bobby Eshleman     2025-11-04  2599  						tcp_xa_pool.tokens[tcp_xa_pool.idx];
45aa39492cf4dd Bobby Eshleman     2025-11-04  2600  				} else {
45aa39492cf4dd Bobby Eshleman     2025-11-04  2601  					token = net_iov_virtual_addr(niov) >> PAGE_SHIFT;
45aa39492cf4dd Bobby Eshleman     2025-11-04  2602  					dmabuf_cmsg.frag_token = token;
45aa39492cf4dd Bobby Eshleman     2025-11-04  2603  				}
45aa39492cf4dd Bobby Eshleman     2025-11-04  2604  
45aa39492cf4dd Bobby Eshleman     2025-11-04  2605  
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2606  				/* Will perform the exchange later */
297d389e9e5bd4 Pavel Begunkov     2025-02-04  2607  				dmabuf_cmsg.dmabuf_id = net_devmem_iov_binding_id(niov);
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2608  
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2609  				offset += copy;
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2610  				remaining_len -= copy;
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2611  
18912c520674ec Stanislav Fomichev 2025-02-24  2612  				err = put_cmsg_notrunc(msg, SOL_SOCKET,
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2613  						       SO_DEVMEM_DMABUF,
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2614  						       sizeof(dmabuf_cmsg),
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2615  						       &dmabuf_cmsg);
18912c520674ec Stanislav Fomichev 2025-02-24  2616  				if (err)
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2617  					goto out;
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2618  
45aa39492cf4dd Bobby Eshleman     2025-11-04  2619  				if (sk->sk_devmem_info.autorelease) {
45aa39492cf4dd Bobby Eshleman     2025-11-04  2620  					atomic_long_inc(&niov->pp_ref_count);
45aa39492cf4dd Bobby Eshleman     2025-11-04  2621  					tcp_xa_pool.netmems[tcp_xa_pool.idx++] =
45aa39492cf4dd Bobby Eshleman     2025-11-04  2622  						skb_frag_netmem(frag);
45aa39492cf4dd Bobby Eshleman     2025-11-04  2623  				} else {
45aa39492cf4dd Bobby Eshleman     2025-11-04  2624  					if (atomic_inc_return(&niov->uref) == 1)
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2625  						atomic_long_inc(&niov->pp_ref_count);
45aa39492cf4dd Bobby Eshleman     2025-11-04 @2626  					refs++;
                                                                                        ^^^^^^

45aa39492cf4dd Bobby Eshleman     2025-11-04  2627  				}
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2628  
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2629  				sent += copy;
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2630  
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2631  				if (remaining_len == 0)
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2632  					goto out;
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2633  			}
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2634  			start = end;
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2635  		}
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2636  
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2637  		tcp_xa_pool_commit(sk, &tcp_xa_pool);
45aa39492cf4dd Bobby Eshleman     2025-11-04  2638  
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2639  		if (!remaining_len)
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2640  			goto out;
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2641  
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2642  		/* if remaining_len is not satisfied yet, we need to go to the
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2643  		 * next frag in the frag_list to satisfy remaining_len.
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2644  		 */
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2645  		skb = skb_shinfo(skb)->frag_list ?: skb->next;
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2646  
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2647  		offset = offset - start;
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2648  	} while (skb);
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2649  
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2650  	if (remaining_len) {
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2651  		err = -EFAULT;
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2652  		goto out;
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2653  	}
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2654  
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2655  out:
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2656  	tcp_xa_pool_commit(sk, &tcp_xa_pool);
45aa39492cf4dd Bobby Eshleman     2025-11-04  2657  
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2658  	if (!sent)
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2659  		sent = err;
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2660  
45aa39492cf4dd Bobby Eshleman     2025-11-04  2661  	if (refs > 0)
45aa39492cf4dd Bobby Eshleman     2025-11-04  2662  		atomic_add(refs, &sk->sk_devmem_info.outstanding_urefs);
45aa39492cf4dd Bobby Eshleman     2025-11-04  2663  
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2664  	return sent;
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2665  }
8f0b3cc9a4c102 Mina Almasry       2024-09-10  2666  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


