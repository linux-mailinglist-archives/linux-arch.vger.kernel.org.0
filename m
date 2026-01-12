Return-Path: <linux-arch+bounces-15755-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8BF5D1522E
	for <lists+linux-arch@lfdr.de>; Mon, 12 Jan 2026 20:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D78523015D2B
	for <lists+linux-arch@lfdr.de>; Mon, 12 Jan 2026 19:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E403254B0;
	Mon, 12 Jan 2026 19:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JfXGBlJr"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50633246F0
	for <linux-arch@vger.kernel.org>; Mon, 12 Jan 2026 19:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768247798; cv=none; b=YtfZm3NH9AZb+PUySlON6C/sRHUUhnqXnjX8RvhQLX4FoNKJ/ZO+1RqqlCMb2MKqzjW6s4YsqiEZiYCayjZIKVsmiwDIQxlBBzt3GF/g2eEhSv123w58arhbDy5cyT741vnZsWY8LBFBwnwPhK+RZX6O3waWw3uOP3ojA/l8uRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768247798; c=relaxed/simple;
	bh=M31+Y79zuoXr1vFVcVS4+r+feGloqOn2T9Swnz4nHtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J5w32gbM6XRp4zllgoj8STG+BJc2sSR1jTiFmjSvEF+3Xlj+z1p/5hUHQKFXovFMb62dOhryW6bw9gTFk1E6wa1kWjW8mLRQcoBJ46K508VbhnJJGkpZQLsusC9kZpupUfYvrf2RtZ/AWgoWHxNAAfMglqac9MVIToIsCX2lGqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JfXGBlJr; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7927416137dso21903137b3.0
        for <linux-arch@vger.kernel.org>; Mon, 12 Jan 2026 11:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768247796; x=1768852596; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KH869nzXNgoUvJaMyA9BtLsL3ZEwdxgmckhbEXHR+og=;
        b=JfXGBlJr2osxbGCfOatR5NPxF/H8VMPOSfZ9C13U+SqbZ8hRSf7IpFZ5vVZZZDvYy+
         2VSYW+xuO9Bi0KdQQnnXccSV51JR2vcgKPJFjSAlJ0mpQSEBEmC2x87Vomfoyg1OUrb0
         eUpgCWAHD10emPytH3FHapE0liSihz2Qj34/ht62jJUcnctbeBSiitrQwmQTvbhTXwr3
         uazflyT+HRwx5fjoj3Xrb+nPgejigD+oJwC8xPgaflNl5yKfA0QQD92+xlRKPuwcKfOD
         1Bvtzq6S9S2SfotgpV6P+ZOSzP61PwYVK8gkBBYcA6/AJSGj140dh34N/VQVWs7JOYyN
         uhIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768247796; x=1768852596;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KH869nzXNgoUvJaMyA9BtLsL3ZEwdxgmckhbEXHR+og=;
        b=MaEwo7tsei26fyyt1Lo2WjMIk3Oa/DpsGtlxQqT+zi8ouEnL65HG0VmJhrD86upGwN
         dxH7eCsQUbPxMcIr2Mvi7q/iz99hcZTXrUskFqXN9jzApOa1fBlE8RHOZm2N067Be3Yw
         CBSolvU+iUa5HbyRbfeUfBQ8rLKdkCuQ0nwrUwjpTAeqCLDBY1xjPr0Tfqw0KTQJ1lZj
         yR3JtWJj/aMUr9ia36fADFwBzHOPpqmjkEf2kh6OIv76/6sM5V02qm37JDSiMJToONRU
         ppeJYU7xZrZpb9br9zNdpL1wZeo5jsrNRbHblFVJBnIpgVE0JdrDu2XPWBZgJ3ef+F+k
         XkqQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2efroKHyeiizRijSUArZSY4I/q1CUMVPfNzf2KhCGD1NNhCRZFFK9v2/0mFW1IQ0tQrYRoU7xrTBh@vger.kernel.org
X-Gm-Message-State: AOJu0YzXIr0BY0KmjiRTSznZNS3Mepjc2qCN+vzuSLiDeEedYwZPMCQ1
	8DOGqNjD+R7zhzLNdVF6ISZ/JaO5WOGQo4EXxyenykZVTcV6ZsJS8svv
X-Gm-Gg: AY/fxX5HVMf0BM8YMMYASFyur4BdpHMJzZvQtl0p2ih3NjLXWXcFEX08pCjnwvkliAS
	eiZyfQ1SBVEaCnaB4dg9uj9336DKPddQCfjKJ8P2ZOe8SbQZTU08w23mFMC0qMHMVD0djCzM8bu
	S9lA/dV8vhPIekKwN7gG9bPWg1ZvoFYXr4uk5l9DsDGGYCi8ZfqFxA6YJK4cDUlxEIsFdQjKGcm
	oxJ1DU0Xwjajs4tS8B40oWVL33uaskwiTKZkL5xsb0d8yfi+7msXF9XWZW5mALAMsLswT3OXqPb
	ozaJPvhHmtEYiE1IpakBlGfKLlP1E/Md4qlxingHsYWUev5b8h2xXkNIAGyFlF9gTOhfb/lCkRv
	3j++Z5zGgFtaUHDblM8f3llwtOlCxaZ3UkfnFVWU0fRoz7z3jvj/Qe28m5bI/10BOfzBEYL9Gps
	kSr4f4lLKHP8IoEOl/I1F+CaLPCz4Yw+vDNvE=
X-Google-Smtp-Source: AGHT+IHgu2lOJznxq2Oiaq3vnKy3dA5EnBV3x7HgHsvKXwndIU+C6LqpkznWacQVy1guDmkfDk9/Ng==
X-Received: by 2002:a05:690e:1348:b0:63f:baef:c4f with SMTP id 956f58d0204a3-64716c5a848mr15226065d50.63.1768247795824;
        Mon, 12 Jan 2026 11:56:35 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:4d::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6470d7f76desm8366862d50.3.2026.01.12.11.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 11:56:35 -0800 (PST)
Date: Mon, 12 Jan 2026 11:56:33 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	David Ahern <dsahern@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	asml.silence@gmail.com, matttbe@kernel.org, skhawaja@google.com,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v9 5/5] selftests: drv-net: devmem: add
 autorelease test
Message-ID: <aWVR8U54fLB+mA/4@devvm11784.nha0.facebook.com>
References: <20260109-scratch-bobbyeshleman-devmem-tcp-token-upstream-v9-0-8042930d00d7@meta.com>
 <20260109-scratch-bobbyeshleman-devmem-tcp-token-upstream-v9-5-8042930d00d7@meta.com>
 <CAHS8izMy_CPHRhzwGMV57hgNnp70Niwvru2WMENPmEJaRfRq5Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izMy_CPHRhzwGMV57hgNnp70Niwvru2WMENPmEJaRfRq5Q@mail.gmail.com>

On Sun, Jan 11, 2026 at 11:16:37AM -0800, Mina Almasry wrote:
> On Fri, Jan 9, 2026 at 6:19 PM Bobby Eshleman <bobbyeshleman@gmail.com> wrote:
> >
> > From: Bobby Eshleman <bobbyeshleman@meta.com>
> >
> > Add test case for autorelease.
> >
> > The test case is the same as the RX test, but enables autorelease.  The
> > original RX test is changed to use the -a 0 flag to disable autorelease.
> >
> > TAP version 13
> > 1..4
> > ok 1 devmem.check_rx
> > ok 2 devmem.check_rx_autorelease
> > ok 3 devmem.check_tx
> > ok 4 devmem.check_tx_chunks
> >
> > Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> 
> Can you add a test for the problematic/weird scenario I comment on patch 3?
> 
> 1. User does bind (autorelease on or off)
> 2. Data is received.
> 3. User does unbind.
> 4. User calls recevmsg()
> 5. User calls dontneed on the frags obtained in 4.
> 
> This should work with autorelease=on or off, or at least emit a clean
> error message (kernel must not splat).

IIUC, this looks something like (psuedo-code):

ncdevmem.c:

do_server(...) {

	client_fd = accept(...);

	if (check_premature_unbind) {
		/* wait for data but don't recvmsg yet */
		epoll(client_fd, ...);

		/* unbind */
		ynl_sock_destroy(ys);
		
		while (1) {
			ret = recvmsg(client_fd, &msg, MSG_SOCK_DEVMEM);
			/* check ret */

			ret = setsockopt(client_fd, SOL_SOCKET, SO_DEVMEM_DONTNEED, ...)
			/* check ret */
		}
	} else { ... }
}

... then devmem.py checks dmesg?

> 
> I realize a made a suggestion in patch 3 that may make this hard to
> test (i.e. put the kernel in autorelease on/off mode for the boot
> session on the first unbind). If we can add a test while making that
> simplification great, if not, lets not make the simplification I
> guess.

I think we can do both the simplification and this test, but in general
we would have to skip any test when rx bind fails due to the test's new
mode not matching. Not sure if that is desired.

I tend to like the simplification because I really dislike having to
track the RX binding count, but I'm not sure if there is a good way to
do that with making our tests locked into a single mode.

Maybe a debugfs reset option that rejects when rx_bindings_count is
non-zero? That way we can remove all the program logic around
rx_bindings_count and make it's inc/dec wrapper functions no-ops in
production (CONFIG_DEBUG_NET_DEVMEM=n), but still test both modes?


The handler would look something like (approx.):

#ifdef CONFIG_DEBUG_NET_DEVMEM
static ssize_t devmem_reset_write(struct file *file, const char __user *buf,
				  size_t count, loff_t *ppos)
{
	int ret = count;

	mutex_lock(&devmem_ar_lock);

	if (net_devmem_rx_bindings_count_read() != 0) {
		ret = -EBUSY;
		goto unlock;
	}

	/* enable setting the key again via bind_rx) */
	tcp_devmem_ar_locked = false;

	static_branch_disable(&tcp_devmem_ar_key);

unlock:
	mutex_unlock(&devmem_ar_lock);
	return ret;
}
[...]
#endif


... but I couldn't find a good precedent for this in the current
selftests. 

Best,
Bobby

