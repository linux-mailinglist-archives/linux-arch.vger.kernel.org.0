Return-Path: <linux-arch+bounces-9238-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 766ED9E1100
	for <lists+linux-arch@lfdr.de>; Tue,  3 Dec 2024 03:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4106A282BBD
	for <lists+linux-arch@lfdr.de>; Tue,  3 Dec 2024 02:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9A24594C;
	Tue,  3 Dec 2024 02:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HxMTZ6GI"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFAF414A82;
	Tue,  3 Dec 2024 02:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733191230; cv=none; b=eAbUU5NttPoi2yXzW/Egr8QDH3Hme5n1IoQsQGys+3aGFdyhSnlErF1pG9IcnaScfIJ5E3eZQzxDMPKWWkcuXnkvnv6ob6G1pbCjYXh86WtPhm4cP7ePszVB0Sm6vEy8+LTcYpUqkbe/ppNicM5E1NeheKMsmMc/EWkTurBsKJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733191230; c=relaxed/simple;
	bh=EAkYqHxwoA0R0dcqG7W4lfpOriiOfn2sTkhuAvg1mYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UW4xV4EJckC4a2a/8wiWz6J/N9f7IlT1jFY2YdX849nFc2M51yz2Z8QDcfrWjSXD/Dc7uWG3rddzfHuC2J6CEoWUJQJXar0wQKW37IvpWvW2HsN+5KC+M1PvKq1cvsW98SjGkdaSHijenwEmhxwwYUyNVy7GQ7zIStyUOAYn/is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HxMTZ6GI; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2e56750bb0dso3605037a91.0;
        Mon, 02 Dec 2024 18:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733191228; x=1733796028; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ifhyXCPwj2ZS4FThasjY1J6PG/17ZdtDu1I6YUbkxr0=;
        b=HxMTZ6GImJQWlkN17o/Pknr2ONcCHIl13tPF+JErwWPinscJXZSiT4UE+1debDm0s3
         zMsgtLr89brCFfXtKs4ixCBO0yGynZZTnt6DsJ3rN0Ysi5AnDpCoo0qq06F26WciYMyF
         f3y/ZmM4yEEUYLhUTOBqPrSl57QUZOiN6tBwz1mSO2uoeQ8iy1zv/iLDpDEqqJzqcgXE
         WakD/XJlP+Dv/rkh2S8dF5dgLUu5vq4uQ8TPCKhEul09HZHcQRMbvxBmbSR+ik5F32n8
         eLFGiqf1D1Tg1OVjt1POeYPVmxotq4lTJOAB7dSBa1g6Dy5lFPCiL3GSqj4fNCqqzgwD
         dNsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733191228; x=1733796028;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ifhyXCPwj2ZS4FThasjY1J6PG/17ZdtDu1I6YUbkxr0=;
        b=Y0OOt3R81xQ/n/Op5oB/2KvI2ftW+8u6XG2j16UiLsf5vn/QdjoWykGohg5xTLqfbB
         0rv4AXZtOuRUlPIedl3IF1bNWZ55n3zmDzniPHuJRLB6HuMvdltAhijGateX/GquK/8m
         8Tpv50XPVnDW081k+owv8g0t+mvjbsvYs+vO/MFJ9fGCmzLQ8CF7ymR0P74vkuwlFLem
         wz1vC0fTTO/0ynqHVNPS4y3yz2MW0NsQtAqMzJh6zHtrRU1Pvomm191K+6XbG8AeKvR6
         r7RdS2iMKkvkREmkq5+k0MOPUoKQUOxHkwa/ioj7EbO+0T2zE1BW1DClmENlrkdA1pSV
         3CVw==
X-Forwarded-Encrypted: i=1; AJvYcCUGR2qqhs+Bte2DAyXw1Ak0JsF8wriwEC5Hj3vArL7w83YmMl+mm30Y+0bCxM0Y8A5jle2rjT/L@vger.kernel.org, AJvYcCV6KT9jPsd0kH5F4sqigXpGYmHtBOrtmKvBs7P6IMsOB/iiIIGF/k8Jg+uU2stEWZlsdkV3+PVGRp9WU7EB@vger.kernel.org, AJvYcCWIyaFM3SasmJrEIL4foueWymvsPFix1TR/PG4yPqgV8OBbpOMZ1yJYmlHSRt9/JFxVcC5yugjxFYQgZDyNCYA1@vger.kernel.org, AJvYcCXIvJuHiKyvc0XdGdkWiyKCA1rcoaKDEwYo39smPbDMfRX/d8cdQEaVx6ZU10Sa05ZiHQg0DbD5eS+Y@vger.kernel.org, AJvYcCXXWjvuGxKjrJv1N+02NUpGCOs1zl5LOEJgJHSQAiwRAl0wSzjxrWPk2vgHgL481tGkS/8P7zelWRo5yzwL4+Bl@vger.kernel.org
X-Gm-Message-State: AOJu0Yze7xsShEqvIxePgf+CKLn8VI68ZIHFZuE+LLKzXN/mnhE2O0mT
	aLHVeN+fQvDa/RqqPrBhSZ8tNN6IO2WEcMuSTcoO3+M+ncXu/CPV
X-Gm-Gg: ASbGncspduNW0rWQApz1evZZzs5JHq9OD/+CRShGWnn1gMbnMGc2QOFp29l6xGD0Q7i
	2+OwqHEZBsX8K+aTF+d+1dlz2eCfeS+I7m1RcxBFaMya9TInj4GBHOpeUxCpDW+n1cY/A/xie6E
	/snZvnl+T7e4gHxkO3Lk95GofIO2a2UEOr5PbIE8wgRF2kArbXLHCvnKMzyJSv++VgCHk8tIYwf
	ME/Pz4I+j2ZSXVBeo2zNNCSkxb6L7ty7gHr7Tt+q/EPfns4qtrJnzc=
X-Google-Smtp-Source: AGHT+IEe0uogUo+ebVsZ0JC4jhKeRE4kCvwTmE8uI2YOgw7JxmzvRPXAWvNj+Oa2WPogiVf++p7dKQ==
X-Received: by 2002:a17:90b:1b52:b0:2ee:7a4f:9265 with SMTP id 98e67ed59e1d1-2ef012019a9mr1313043a91.15.1733191228010;
        Mon, 02 Dec 2024 18:00:28 -0800 (PST)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2eee1591fbdsm1908976a91.35.2024.12.02.18.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 18:00:27 -0800 (PST)
Date: Tue, 3 Dec 2024 02:00:15 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Kenjiro Nakayama <nakayamakenjiro@gmail.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Andrea Parri <parri.andrea@gmail.com>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	David Howells <dhowells@redhat.com>,
	Jade Alglave <j.alglave@ucl.ac.uk>,
	Luc Maranget <luc.maranget@inria.fr>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Daniel Lustig <dlustig@nvidia.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Shuah Khan <shuah@kernel.org>, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-arch@vger.kernel.org,
	lkmm@lists.linux.dev, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests/net: call sendmmsg via udpgso_bench.sh
Message-ID: <Z05mL1WQHBLRkIw1@fedora>
References: <20241202232129.7139-1-nakayamakenjiro@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202232129.7139-1-nakayamakenjiro@gmail.com>

On Tue, Dec 03, 2024 at 08:21:29AM +0900, Kenjiro Nakayama wrote:
> Currently, sendmmsg is implemented in udpgso_bench_tx.c,
> but it is not called by any test script.
> 
> This patch adds a test for sendmmsg in udpgso_bench.sh.
> This allows for basic API testing and benchmarking
> comparisons with GSO.
> ---
>  tools/testing/selftests/net/udpgso_bench.sh | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/udpgso_bench.sh b/tools/testing/selftests/net/udpgso_bench.sh
> index 640bc43452fa..88fa1d53ba2b 100755
> --- a/tools/testing/selftests/net/udpgso_bench.sh
> +++ b/tools/testing/selftests/net/udpgso_bench.sh
> @@ -92,6 +92,9 @@ run_udp() {
>  	echo "udp"
>  	run_in_netns ${args}
>  
> +	echo "udp sendmmsg"
> +	run_in_netns ${args} -m
> +
>  	echo "udp gso"
>  	run_in_netns ${args} -S 0
>  
> -- 
> 2.39.3 (Apple Git-146)
> 

Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>

