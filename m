Return-Path: <linux-arch+bounces-9244-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 644889E3C02
	for <lists+linux-arch@lfdr.de>; Wed,  4 Dec 2024 15:03:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2990D281549
	for <lists+linux-arch@lfdr.de>; Wed,  4 Dec 2024 14:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D8C41FA152;
	Wed,  4 Dec 2024 14:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Er7TdoqP"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9B61F943D;
	Wed,  4 Dec 2024 14:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733320993; cv=none; b=M7dwLceiCVcQ2gM6l2u5d95Lor+2X749+EePnVEG5KUytkbQMl6YMfuDcp7/YjX/htADf8cNDjrmWt/1WEZzuBP5anDCTkQOAWWMB7VJ8cgUwOBhBRTFsewVuCZxEW0CK6tJdloWD16z7ogimqzi4an8gzTAXdPssFozjVTD7MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733320993; c=relaxed/simple;
	bh=wiR5htVN+22hbXfWg7ML4jVM0P0Y7+RaaSQ2h6rUHR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fLYOWMWnEVpdXEjdDHf2xtaECjnK5JFRzjaR4NFG2r+H2F7rJcfry0YURHIbtAaWy3s/VVukhk5D/bA9AP+meTBtrEsn0srhWpBKP7kSTsrNvun51/n5dOBoc+FyJ+yjZgh5xzqQVUVvx+iIvhCEWimQ3capxfYi4hz7l/niYG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Er7TdoqP; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7252f48acf2so5007521b3a.2;
        Wed, 04 Dec 2024 06:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733320990; x=1733925790; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0SkLnU8JcXk82S6VfOwZc1CCUFMw4TrFjPFHV116tyI=;
        b=Er7TdoqP+PeyhGDdrO09WzCjhyJMA2N9eIGSzvTcgdNPToFGyCZhMt8dA16RyxrA2L
         QW+JmMrysUGUJAyA8+LP+U+RTF5xhpSXDqq49/pKlE0pHTuBPre5eNtBRfGmJYotOn0W
         z/34vh+yNMDm8DTGHcVKxDV96/nkINDNvpnpn98IfjtGYBJUagbngbg04V6ZiKU3ZERD
         nB5CV+pdWgzlyfY9Fr5MINiKc22vPtPvcJc+Kc7nksFgfBSqQOHliUsyxPPAexSVxRnS
         pavjQlLUmUg3ZDEMt8lxCsjS/BybXLZXInwzGAmuFbSTQ6Asr/C/IhDagPQ38TEhQIJU
         /iXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733320991; x=1733925791;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0SkLnU8JcXk82S6VfOwZc1CCUFMw4TrFjPFHV116tyI=;
        b=D77/jEnysl+lOkX3lvnPCTXp2NnqFijOrg0eqCFwIYxI++a+NwnXeX0oCvdANE4qQD
         UEdc6Tl5KxmmfiR13kLxQWTATg3VEoImLk1FXVpXvirkzSlG43BUECOa3HKwutGefYFQ
         bPo5tRibZIuJyfNpSrn7rPRtDqKoEUDpmUOw9/UQ0J821HXQosvjwou3ejnptILJxYsh
         4k6N7XowAN3Vw/C6QB3UYrkQlEyCl6qIFAeEOOy33FxkFHwiZjwmFZZIM3prUquVw1Bj
         EYWrN/tyRLg2Vk4hX6D2az+ep8jf5+ammIAV+IVHy+7Keipg+lUnsDqbK8aFZQttkfn1
         A4gg==
X-Forwarded-Encrypted: i=1; AJvYcCU8evdWcpme1BA7FCJSeEPjzxh85oLlgY9wm6OuVkG+NEhEImyTcgZ+BYxMrptkJzkUf5ByonikeEvvoOUoZjv/@vger.kernel.org, AJvYcCUZb8yHjQg/Ug1VxzLrBb+HoGPE9/mPJSOE7/0XO/2fotxqbXWfOiiW91rZaXttXn9DQ5xAvHpeBGeB4JFd@vger.kernel.org, AJvYcCV0Q94XUQlGQZuOlcD3P7TqF0Q+geVhXn0J9G4wDhemrlOdoVVYbw641Yb/9oX17k1qTfsug/eZn/rM@vger.kernel.org, AJvYcCW2d0Ap2YZZY3i6U9F/r1rm8g8p5rDl+iqyIe6lUrUmGkYTcsWqAUzYUfvoqjZESBxAGfOccY/yaxktSqe0YDwy@vger.kernel.org, AJvYcCWQgBITDpsyRmD2QiwKKlkJAAksc+vQVx1NDnVibdPpWBa1JuiZiVuSPEWMniog7IX6upmiL74R@vger.kernel.org
X-Gm-Message-State: AOJu0YwFMVowSzTlNueGjBS7Sr4Bg+GURMynFvIK9XDhTKta+ZkiUm/S
	YhiwxBJVlYV0GW0jxwa7LyBdM2C27DYtP+6EzyzIou33smfO2dwm
X-Gm-Gg: ASbGncu9srxqV8li3BvcrtTk4lSzCLE61b4u5ATI9OvT6jr+wuEg7qT9OBJJYVp2UwY
	pM+5aCx+7jy61Qze28HQb97BeJpi9woEE1e75IsTzDVg/IO8VYAFm7i9rNghruRArEfWeVCvybO
	clOIaaa3oIeZVkrFtr5Ydw9YIDY3Ayo3Ln7spF+QfxAcrFi/t29e0M6Y6w/qlavx3flWlJqS2f/
	F5cMupOcKp1DP3SllL3OO6CC5ubSEkILcX3Yj4Odt01sAREI25bPKY=
X-Google-Smtp-Source: AGHT+IEUKdzmeAo1eoMyTnSkc02brGe/K04CdFfkaSutlwK1ABZqZrvFGOq8UuSIGqZcRz48RNbWJg==
X-Received: by 2002:aa7:8888:0:b0:71e:41b3:a56b with SMTP id d2e1a72fcca58-72587f9083amr6136440b3a.24.1733320990387;
        Wed, 04 Dec 2024 06:03:10 -0800 (PST)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725417612b5sm12374317b3a.30.2024.12.04.06.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 06:03:09 -0800 (PST)
Date: Wed, 4 Dec 2024 14:02:57 +0000
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
Subject: Re: [PATCH net-next v2] selftests/net: call sendmmsg via
 udpgso_bench.sh
Message-ID: <Z1BhEQ5RsJqB2ugr@fedora>
References: <20241203222843.26983-1-nakayamakenjiro@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203222843.26983-1-nakayamakenjiro@gmail.com>

On Wed, Dec 04, 2024 at 07:28:44AM +0900, Kenjiro Nakayama wrote:
> Currently, sendmmsg is implemented in udpgso_bench_tx.c,
> but it is not called by any test script.
> 
> This patch adds a test for sendmmsg in udpgso_bench.sh.
> This allows for basic API testing and benchmarking
> comparisons with GSO.
> 
> Signed-off-by: Kenjiro Nakayama <nakayamakenjiro@gmail.com>
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

