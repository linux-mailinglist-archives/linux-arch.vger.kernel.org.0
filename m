Return-Path: <linux-arch+bounces-9246-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D10569E4473
	for <lists+linux-arch@lfdr.de>; Wed,  4 Dec 2024 20:19:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6B26166026
	for <lists+linux-arch@lfdr.de>; Wed,  4 Dec 2024 19:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1541F5408;
	Wed,  4 Dec 2024 19:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GfI8Hpr/"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6CF1C3C0A;
	Wed,  4 Dec 2024 19:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733339779; cv=none; b=Fn8cKJm5q5pzknAe37EXD3QviZ+uJH3CwrNPd9D+mI73qIJpKUoFqEtQ9/xTgXXhdwl5RuFpq1UGv2WJ7WPlXjxNyWY/PR51idqUmRMggPYJ26nvwmvm4Eul6A2Fx/mCVIdhCVrwTtuV2OT/acAvlX69hGUfM5SW8osZ1fz9Jnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733339779; c=relaxed/simple;
	bh=riFR1uFph0+nEzIzgS8wLwTUnFjsEBS3WhqWQhLswo0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=YoXXRsG079rb/MvLDGxTfOC42BBE9JaR/lakBaq9lfszxkFJudXYez4mOggrgXDLqn/kuxUieEMIQ745zfrg8LgT4Q9Uexha20y6O/PBGLjrhv2rUfmESFHctpE13pnxBWhGfIjDxN7D/iVLD5+12qsOUg7ZgCl4pbzzoknTn40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GfI8Hpr/; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4668978858aso655971cf.0;
        Wed, 04 Dec 2024 11:16:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733339775; x=1733944575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pr0hdtkXWBz6Deg8rD9qqpfL9wDCS2J4zLJaloBbbT4=;
        b=GfI8Hpr/yGxYX0eVAHWIZr+I3iFzk9APoRut2TBqVBMcJIxjoNq6H2DOfVWST3E6Zu
         7yCAHaSwqOfOKml2TCcbkfPrpedgTP5rJE+1EG50eXOmBGQFhuFK2NGNOWHaFiyTJNRo
         +fzPHYjOvC04+iA/PShiwNatJ0uSKb5UXhBRvs6Qaow9HracJ6dPyuoIuccrU8+Q6h0N
         IZQXGLeQlB8/agMJOitkZw2jSqbhwEv5sOU/3CDFTQMyWqQfItXDCMGjAHHGOQ1kGauC
         em61nQb4fSZN3b6/7/uasiaoAL8is3KyL1fSCYNfS87Ho+RdtXIdC/fIP5wlJQwKbl9r
         TwtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733339775; x=1733944575;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Pr0hdtkXWBz6Deg8rD9qqpfL9wDCS2J4zLJaloBbbT4=;
        b=dfFEW2RrENhXPs8Gg4f3+tCc3FwhFM62crD+SSVFmb3aCSTI0gJwBNpdFzn9oZXDcI
         MkgXvoLgbkfGsTvWQ2KdZ9Fb3WHXStcQRhPz67loO6D9TaVPYoPu5pvDW67Bb5ZhFi+A
         H0biswxQa+sG6/JRA8D6lFIiuCWkp+x+EsrbD+X4azZXbY8xA4p7S3gB5r06Imw75RFz
         76xyYQJsIQVUJ73v9rsyZb16ygXVN473G/AOHevGM8eHdvxsQSIAKpLE1qTb+sQ/jsKX
         i3jEGkTEirxhLjdyaOMofwtS2Ex0gkqyR6fl2HvBR31AFISUh1VOMtD+VzIguVRtJEhx
         EoSg==
X-Forwarded-Encrypted: i=1; AJvYcCU3w109YPfqsIrK5/MDShMYrR78LdmYjlKeMmoK7jJxqOyDKJJ3Jmnj6IHrbyYjITDgSENte9Nwa0SWJHLd3X8O@vger.kernel.org, AJvYcCVSYUFLOIWZV2/Iwjl+S6avHQ1QO4ijjOJ5HaGmgan81JuMe7AFKd62IWenS6GJ+Lg071ccZSao@vger.kernel.org, AJvYcCVTyn9ABjI8ySLrsyU80DH3lzW15QkErT6bPhlAnkNpZV/KMHUpyJim0Q4ErqRW9xx9N9zM4niaHIfUG6UJ@vger.kernel.org, AJvYcCXfK+7ZYsHVX9RtMFdHuBfONCYFgIsweVZ9/w9DsM/XGQkG5Iq6O2GpbD2G5zW1R+eFzuKZAO0X2TBT@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl3XaI3tjnF9HqcEVM/7obrH90CnJXnRWSekpoC3DFgP9oGmMv
	RAbIjgdumpTWId8GXhl4k3FSeecqFf2AanlyDDpj/JDjx+bVER7b
X-Gm-Gg: ASbGncsWAVsGmtYg+X27/f+XJ5388Wqh+og+yV+YAFOzy3buNRKuX8pZ6FXe2Dq+yJs
	JjRpfaiN/p1XoslF71GSQna4MfbR9RPbVMgYcEROfWVCsuYeBBb9vW/FCDjD80qo4QUD7Sjj2tF
	9dgHTWPVlXZuRufvqMkiiFtkBOmZP2v/QEBHPTEvwuq5m1RLhW0DTNzdcOqNtu7I9OjD4c1Je7d
	kaEIeczh6K9eZaEK9tZ4BIV8sGVWA5PRvijSf093+09pG+x558TswYYD3TuF9NQq2775o8i0Wf7
	6ZjQbpGkMcmcIWJb4V9ffw==
X-Google-Smtp-Source: AGHT+IGvHGN7TJ0teVYRi09OToFGV/F78Y/ZVg2hNhJyImOWe5fuNzGtXanUUzFhOp4XNh/yEmEP6g==
X-Received: by 2002:a05:622a:50:b0:466:9938:91f6 with SMTP id d75a77b69052e-4670c6c5422mr109547961cf.51.1733339774925;
        Wed, 04 Dec 2024 11:16:14 -0800 (PST)
Received: from localhost (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-466c3fa58fesm77103941cf.0.2024.12.04.11.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 11:16:14 -0800 (PST)
Date: Wed, 04 Dec 2024 14:16:13 -0500
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
Message-ID: <6750aa7dc6dfd_b1fe52945f@willemb.c.googlers.com.notmuch>
In-Reply-To: <20241203222843.26983-1-nakayamakenjiro@gmail.com>
References: <20241203222843.26983-1-nakayamakenjiro@gmail.com>
Subject: Re: [PATCH net-next v2] selftests/net: call sendmmsg via
 udpgso_bench.sh
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
> 
> Signed-off-by: Kenjiro Nakayama <nakayamakenjiro@gmail.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

