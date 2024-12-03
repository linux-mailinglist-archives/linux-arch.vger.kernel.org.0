Return-Path: <linux-arch+bounces-9241-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C479E29D4
	for <lists+linux-arch@lfdr.de>; Tue,  3 Dec 2024 18:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E05F9BA5A85
	for <lists+linux-arch@lfdr.de>; Tue,  3 Dec 2024 15:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B271F757E;
	Tue,  3 Dec 2024 15:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l041LLGt"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C083D1EF0AE;
	Tue,  3 Dec 2024 15:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733239283; cv=none; b=gjl9YOos7gQQ0ULCgjDXPr7gRJUN9nbLMjCJTndQNGq41x+Ess0tUj5ZLQ6fkNmjQ/6X6rrmdCFCd1G5117QnqevJmLpOV3EVMApnEhN3NNFNrPMyH1voMgHvQchGaT7xFa0CVfebB5KlbiuhBH1r5Qhxdk3wnUNXcm8OyDkc7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733239283; c=relaxed/simple;
	bh=t8yscXsYjfpe/1tcoMvCTfOcyi3GhvMr0P2NT0AZHzk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=NDOTvpYXolAMvRnkODBz9ftwwnokmEUXpBuxvbS6IPchbs0U0sR4z9KRDZh/rmdwxf/ZXpmwy8Y8dJmgBcQh6PItk6N1sWvXmKL05ECSuivB7CmsRwJsKfORn82a+b655/pAmfOrRttyoy0MOtUPi0bQ6xNSa5vpkxJjDaG56TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l041LLGt; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-466966d8dbaso45712501cf.3;
        Tue, 03 Dec 2024 07:21:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733239280; x=1733844080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VqsVHmCOaWiBo6waU1R1vraLU/LK0vRFjavrsVUjZLY=;
        b=l041LLGtQ09D5k9YVBUQuBVvQ8Q6hMoDvDvrGkEdSwkOK8gnKxMD+RTAhmJ8ioGzNS
         5Iyt9SRcV/JXbqOP96OJGr/UmP5yyTMfsTcJ4Y2xhovpEDW0UErs1gfmgOJC8iUQulan
         46EP+dxFoM6ZxrL4s5ILxNK/q4tkEUMXTwI7a3K8qhPo6Tzwbmyy8vaKHgPRwI/P3yT/
         wJXLQulArcn+0E7DskiJCzgdBidYcFVBlA4Py9q2t9ecekhde5Tmy2GVu5wjJ024984M
         aExkXDxAYhlVvLN06Mzn4H6Jx6YXZHh2I4H0ORIOrkq3IqW3xOgb8BcSjQhD5Qspx4ww
         ZWOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733239280; x=1733844080;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VqsVHmCOaWiBo6waU1R1vraLU/LK0vRFjavrsVUjZLY=;
        b=Mexig+DofDUwVTNGN5G8TKshCoajvQvlzcTIFdpDoEbN33+Wpg18Vo4EjbuGXBgIPT
         3vjRi5E+nnChK9BxdD/WPn6Vlhi/l+YS/cysywCoOF7B3eewDxrcZ4AFhOYaqYXsDgmn
         aDnIJC7DVrjca0+ooIBQBHLcQr3+maPSI6mPsz1QKeDM/A0YrHAGF3Shps5x7kTOhyUS
         PFEzmLCLYTURr1lWz7Mr9ZBs47aJjJS/zLdU2NFI+MuUYpFnwJ888vseEkUXy2qO/qeT
         6oh1ulpQBG84l1gtynB1YVpgigHv/vJCS+1ahx6JI3uZeSt1MseiOy885khYFjYoInLU
         E83A==
X-Forwarded-Encrypted: i=1; AJvYcCU5/P+d2WqQgIndwYFoJ8P7ueJ3gqAsO4EYkOgUZIiBgGkAz3rIoipftKar3dD6vhir9iWKTA89@vger.kernel.org, AJvYcCU80hH145bh54fJjVz7ibwQjl/A3ljRFZUdpc5Um6lKDU6LmKFhHmgNGaU5PJSvy2QtfBZtEXAPvAHR5C0O@vger.kernel.org, AJvYcCUKttrQNS2eaPFdJms1IDmY383EE8A1oYSfiAYiiBPTo2mk/LUlfNK3I3/4WRQI9kelh0lM6bs1AUPU@vger.kernel.org, AJvYcCXVNEr2WK+l//1EZ3cnMT2kdAOyvXOClKQwSqHr1HVU3xrwI5Tri7yuYU7vmdpDiBav72p3B0pp7It5+W8m2PIo@vger.kernel.org
X-Gm-Message-State: AOJu0YxJXIx7Lac+uUo0BHx1Y7QYQU+cyKJqzhpLoFTtuRJEHGDia/HD
	7grfsPBoHcpBQKHvoxL5aZu0f/tzA9KcxeVHA8H+tofJm/8mylx0
X-Gm-Gg: ASbGnctU6OSh2uWgz/+vqPFd/lfrqgFGKwu1qQCcyQBAt/qwSUS1rY1T38X/WL55aAj
	NTxAV4AkeHFbwxuf4KQFdNbldy4lUcIFd0MUHHRqpXoUCtm0IDiLqvsg+ImbOHB1EnO0LAkQfs2
	D4Bf1p66L5BKUn2gf2wMuYtcc7XPFj6Zc61wRLs4iIP3zYHzccBIAci5QPvuSQVzGFdHavXQ9Px
	7iyMuNjSta+9Xdoru903ZmR8lL6saX76ZI89RD9MYRx9JenK3jjOtkuNTUUiwKgYLhrQRF+u1Y7
	tGFft1DxPj6jQkfvJOGf1w==
X-Google-Smtp-Source: AGHT+IGPHit5+V6UhQpAx4/BlJFXSsgH9I6LPVgBePoc1CSG05dOym+Yqu7WxRzxJcebBY0CylhigA==
X-Received: by 2002:ad4:5b8f:0:b0:6d8:99cf:d2e3 with SMTP id 6a1803df08f44-6d8b737d8d2mr41162076d6.22.1733239280369;
        Tue, 03 Dec 2024 07:21:20 -0800 (PST)
Received: from localhost (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d875195da6sm61747786d6.57.2024.12.03.07.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 07:21:19 -0800 (PST)
Date: Tue, 03 Dec 2024 10:21:19 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Kenjiro Nakayama <nakayamakenjiro@gmail.com>, 
 Pablo Neira Ayuso <pablo@netfilter.org>, 
 Jozsef Kadlecsik <kadlec@netfilter.org>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
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
 Shuah Khan <shuah@kernel.org>
Cc: netfilter-devel@vger.kernel.org, 
 coreteam@netfilter.org, 
 linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, 
 linux-arch@vger.kernel.org, 
 lkmm@lists.linux.dev, 
 linux-kselftest@vger.kernel.org, 
 Kenjiro Nakayama <nakayamakenjiro@gmail.com>
Message-ID: <674f21ef3048c_19a62294c6@willemb.c.googlers.com.notmuch>
In-Reply-To: <20241202232129.7139-1-nakayamakenjiro@gmail.com>
References: <20241202232129.7139-1-nakayamakenjiro@gmail.com>
Subject: Re: [PATCH] selftests/net: call sendmmsg via udpgso_bench.sh
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Kenjiro Nakayama wrote:
> Currently, sendmmsg is implemented in udpgso_bench_tx.c,
> but it is not called by any test script.
> 
> This patch adds a test for sendmmsg in udpgso_bench.sh.
> This allows for basic API testing and benchmarking
> comparisons with GSO.

The change looks fine to me, but the commit is missing your
Signed-off-by.

Also, if resubmitting, please mark [PATCH net-next v2].

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



