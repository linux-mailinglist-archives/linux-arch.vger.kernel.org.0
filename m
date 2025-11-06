Return-Path: <linux-arch+bounces-14554-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B4B6C3BFE2
	for <lists+linux-arch@lfdr.de>; Thu, 06 Nov 2025 16:19:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B4503AF424
	for <lists+linux-arch@lfdr.de>; Thu,  6 Nov 2025 15:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3824821C160;
	Thu,  6 Nov 2025 15:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PXkxbyWh"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF51C340A7A
	for <linux-arch@vger.kernel.org>; Thu,  6 Nov 2025 15:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762441917; cv=none; b=aylcL3qKhif3qx3pb4LlJ+Sqqm/Pghn2dUvV825IOB1CUEe4/K1KMPmsrFJdP40a83fc5Vraa2ZUov+XxKTSnu6lYU3dy21RjEFwe25v+5GFW9QKXRLtXOpKnICB1xjhlybxytsB9stZHeX2js16vtY9sBrOfAu0WXKTZqoAIX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762441917; c=relaxed/simple;
	bh=hAieD+WWGuTSffxpUcA1q/dR4SZs7rb61R1Dr5YIuDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=S/DR+TZ+4JSUbNra/Mt9+ISvbKixAjF2ziGdA0GI8U9ODhN1K8P8UdJtSqTm4Z5OKJ70EhNEXG1sDqi/knL8pXjeyxHH5J0eRXvq4aED5j/YUWsn8dselRwhdwsRIELNThII7rWnjKGh+XMkzeR9fftcnLC+sbkm1CHfucDdtm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PXkxbyWh; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-640bd9039fbso1832792a12.2
        for <linux-arch@vger.kernel.org>; Thu, 06 Nov 2025 07:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762441913; x=1763046713; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pr4I1+TpJGoh524IlcwOT6D1N8KANUmHgdXy9dFIgyI=;
        b=PXkxbyWheDzGXpFSxHx0NLUXMmrf6DnoSBG3msqPfLV0Y7dF1eIBp+j2Q26n/HMwJQ
         Uf0j1ykIZoWKj0D1UopoNF/K7E5SttimR3Tjo7yS9ktRQXf7WjZeN69QV4JGDIwAPNYV
         4Pv1a+1kB8UMzG0FdCaOixci51/DVW3dNFZEW4QZoExa1ZDrnSVUC88G08QqUfjvTOvp
         NvUC+CMf/2PY4gcYwr8Xesqk7d07ge3aSx6L6bL5wRvVsdKw13AwNSTJ0uT3pKmEl+A4
         vVUCJcyKidJeCpadMCwsRQO2As55hGmWh5CcG6XsplgBd+OrZVyCvkdJ9j2PjyhG+14n
         ehkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762441913; x=1763046713;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pr4I1+TpJGoh524IlcwOT6D1N8KANUmHgdXy9dFIgyI=;
        b=sjRg2EnAwHwhKCX2bHAHLz8JuK4grJ1BYxxnvGNjFiszCwUzTyg6prd/6tSwCV/lYA
         Y4WW3Xzi0+yPDhQImzBSi2o5MVuzNljkWGH6gReu19ZO8vX3Sm1NblAZCWjMFpVI3tvv
         IZbz0f6GmrP6YJoFZplSdjqpXkb0pq1z3ITDEshFCX9LJkW3hKui2LZguv8KQK8Nofjc
         SQz4mjBfUt8aqsgdfN10RSohLalynneLQDed4DZbZ/48pSJ+YnFr8ul7P8Ci1puSiYVH
         j/1mR7Y5jV5IV0hy8xBQlwJJWmeJQN9gPyDQ89y73uCncc++BPrpWUz9dg9dszYHn2GC
         KAfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwKNkP33+QVHlfB7ORvcRyHTfZvqLzDb7pWUHVdpUHt10cm2F+MpQdOMPLgf83ZqsLnkqG6FONCtg4@vger.kernel.org
X-Gm-Message-State: AOJu0YxybBhk7wD0rsiC8h7DWlx63E1M05v0elIVwswgzWhqAluJ/MWh
	7NwAh2CtFiJ7C++1wbJcDN69ID6bmQCSW/xZr4vCGtrefr3w2Yd5+S4TG00jU4fXcJE=
X-Gm-Gg: ASbGncv0BRABAoyVQNoXYgfXQYn0fykByF0tPlxguvPqLVybulMPP9VVDRGQWGdGw1b
	ycqCltb49VQzn85mFMmxqXRV++i+dDhUBJsfeUm/q4oXyjWTYKIy/uYmYNT704zIZddw4F4MqxF
	nY2kfmIy3yqTJwGlp+BZRevrIdi7CONj6oH7w6ky1WM9plmNYD6v7UHI3SKwiniYhfKP46xyAkS
	KMIgQjcob9Xnajs29LrGczWfLIdjDPoaCLnP7BtjbC4lAXQurUwH4NDfMeOe9cod4lt71YutojX
	trzLbviI9VuZlykDq6/NFGiXXOgByYpi5T1eDwRjkpnFgYWO/9SzyDYX0IX/h6cMM84H8DLiplE
	n7uL94Zl36yo00HE0xDgi7NgE60YXnC/pbn24PAsh5BI01OBbW0wFhveLL/KDIjbyIDQbZVmGZM
	eTuKAtwd7Mt5xr
X-Google-Smtp-Source: AGHT+IHwC37XRyFfnN+/f5wSqrpQAP6dIioKEyvZ5pTh5YK+WFVy/VWvB0JDs0KxKTLiDxdgzCtNxQ==
X-Received: by 2002:a05:6402:1d50:b0:640:c807:6af8 with SMTP id 4fb4d7f45d1cf-64105a582f8mr7170150a12.30.1762441912914;
        Thu, 06 Nov 2025 07:11:52 -0800 (PST)
Received: from localhost ([87.213.113.147])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6411f8578ecsm2022840a12.19.2025.11.06.07.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 07:11:52 -0800 (PST)
Date: Thu, 6 Nov 2025 18:11:50 +0300
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
Message-ID: <95223e0d-e0a4-4bff-b3a8-babe7a8a093c@suswa.mountain>
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
config: openrisc-randconfig-r073-20251105 (https://download.01.org/0day-ci/archive/20251106/202511060119.MAzcsLoN-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 10.5.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202511060119.MAzcsLoN-lkp@intel.com/

New smatch warnings:
net/core/sock.c:1107 sock_devmem_dontneed_manual_release() error: uninitialized symbol 'ret'.

vim +/ret +1107 net/core/sock.c

45aa39492cf4dd Bobby Eshleman 2025-11-04  1086  static noinline_for_stack int
45aa39492cf4dd Bobby Eshleman 2025-11-04  1087  sock_devmem_dontneed_manual_release(struct sock *sk, struct dmabuf_token *tokens,
45aa39492cf4dd Bobby Eshleman 2025-11-04  1088  				    unsigned int num_tokens)
45aa39492cf4dd Bobby Eshleman 2025-11-04  1089  {
45aa39492cf4dd Bobby Eshleman 2025-11-04  1090  	struct net_iov *niov;
45aa39492cf4dd Bobby Eshleman 2025-11-04  1091  	unsigned int i, j;
45aa39492cf4dd Bobby Eshleman 2025-11-04  1092  	netmem_ref netmem;
45aa39492cf4dd Bobby Eshleman 2025-11-04  1093  	unsigned int token;
45aa39492cf4dd Bobby Eshleman 2025-11-04  1094  	int num_frags = 0;
45aa39492cf4dd Bobby Eshleman 2025-11-04  1095  	int ret;

ret needs to be = 0;

45aa39492cf4dd Bobby Eshleman 2025-11-04  1096  
45aa39492cf4dd Bobby Eshleman 2025-11-04  1097  	if (!sk->sk_devmem_info.binding)
45aa39492cf4dd Bobby Eshleman 2025-11-04  1098  		return -EINVAL;
45aa39492cf4dd Bobby Eshleman 2025-11-04  1099  
45aa39492cf4dd Bobby Eshleman 2025-11-04  1100  	for (i = 0; i < num_tokens; i++) {
45aa39492cf4dd Bobby Eshleman 2025-11-04  1101  		for (j = 0; j < tokens[i].token_count; j++) {
45aa39492cf4dd Bobby Eshleman 2025-11-04  1102  			token = tokens[i].token_start + j;
45aa39492cf4dd Bobby Eshleman 2025-11-04  1103  			if (token >= sk->sk_devmem_info.binding->dmabuf->size / PAGE_SIZE)
45aa39492cf4dd Bobby Eshleman 2025-11-04  1104  				break;
45aa39492cf4dd Bobby Eshleman 2025-11-04  1105  
45aa39492cf4dd Bobby Eshleman 2025-11-04  1106  			if (++num_frags > MAX_DONTNEED_FRAGS)
45aa39492cf4dd Bobby Eshleman 2025-11-04 @1107  				return ret;

Uninitialized.  It's always a good idea to test code with
CONFIG_INIT_STACK_ALL_PATTERN.

45aa39492cf4dd Bobby Eshleman 2025-11-04  1108  
45aa39492cf4dd Bobby Eshleman 2025-11-04  1109  			niov = sk->sk_devmem_info.binding->vec[token];
45aa39492cf4dd Bobby Eshleman 2025-11-04  1110  			if (atomic_dec_and_test(&niov->uref)) {
45aa39492cf4dd Bobby Eshleman 2025-11-04  1111  				netmem = net_iov_to_netmem(niov);
45aa39492cf4dd Bobby Eshleman 2025-11-04  1112  				WARN_ON_ONCE(!napi_pp_put_page(netmem));
45aa39492cf4dd Bobby Eshleman 2025-11-04  1113  			}
45aa39492cf4dd Bobby Eshleman 2025-11-04  1114  			ret++;

Uninitialized.

45aa39492cf4dd Bobby Eshleman 2025-11-04  1115  		}
45aa39492cf4dd Bobby Eshleman 2025-11-04  1116  	}
45aa39492cf4dd Bobby Eshleman 2025-11-04  1117  
45aa39492cf4dd Bobby Eshleman 2025-11-04  1118  	atomic_sub(ret, &sk->sk_devmem_info.outstanding_urefs);
45aa39492cf4dd Bobby Eshleman 2025-11-04  1119  
45aa39492cf4dd Bobby Eshleman 2025-11-04  1120  	return ret;
45aa39492cf4dd Bobby Eshleman 2025-11-04  1121  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


