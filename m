Return-Path: <linux-arch+bounces-3094-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8515E886156
	for <lists+linux-arch@lfdr.de>; Thu, 21 Mar 2024 20:54:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CD2A1F21A22
	for <lists+linux-arch@lfdr.de>; Thu, 21 Mar 2024 19:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C674C131742;
	Thu, 21 Mar 2024 19:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lYthmPnI"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCB358AC0;
	Thu, 21 Mar 2024 19:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711050883; cv=none; b=tcbYGovT8HKatAHBOf9SKu/0PMYm1tCU4sLknsONDhDWaQZ+UpUKKJVqRwmsYim25FTjC7+QAonarrvx8RQ9CMsGZUediTgkaV7ASWQx8TlKvNRCZoTV8ss22n0OR2Km95SP//yII3APQpyyY1xM/duA0aVrsVfjBV24wGQF3QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711050883; c=relaxed/simple;
	bh=OiYdnSL+AKG5nj3ekBU6CFDhM4MmswGCM84UgPCDb8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TPW1FBabJ4tZvD1DEr/v6EVXtXwILahXNyHiI9xQvBOXma8gj2aC8RzKmKn0F4yxBrkinEQZqX5+6ixn5za83jaEG5DYdx22bclOTNfgsrh4tmclvr5UGfcpT4/uSJ9zrdqH08KWjdHMTnWHfqxrWl7Gepe7EE56YuLb3uhRc/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lYthmPnI; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3416df43cabso749057f8f.3;
        Thu, 21 Mar 2024 12:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711050880; x=1711655680; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jDZlJEtHFIm6Gl+7kSgG5qWF5bEblRoSU2T4MYJXNV8=;
        b=lYthmPnIETj1G3Uw4oo14IE3LnJcUTgdxvxhQaQwHekUi7qW5DdOUJj8CflXQiqbRg
         DM8TyQYh1R8p1gsBSYclTcGz13q7QhClqC6AaqKVYIZETIIK4PfvEQ6k1RZmqYo60cwn
         p2ytlMXkS9uIYiuCU6qgcORBngQ6SsCnu0G/jDp6oKt5pzlyhXDvvMCiUTGI856qcppz
         xXvg96zmDYjAtUJw/npDUI+itjLTnKV0jhNFGHxZ4IoZvVjVTRZ8ZsqyIUi/kjvvYz80
         G7nKSvzxqlqtp/1W8SShJKE6sZYf4fdXDkyeD+murUcxJmaqDBUFs9AspWWRFrlYW9Sj
         TwIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711050880; x=1711655680;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jDZlJEtHFIm6Gl+7kSgG5qWF5bEblRoSU2T4MYJXNV8=;
        b=PnZ2+9wxotgPnENB7k7p8MPO4mdHyKX0+jB47yRsJ91Pp5ZTz6fibqm87z4bjZizV1
         QJUiOdiDyIXxngLFHq7npWFVjODuPFY+PBl8E2i0G6C3O4gHYh7i+3CrNpm/M1NK6WSd
         8AmKOYD4T0vDZe7UbORgKACzb90ZXC8nRQqUuXwPz5gwNwV6+Xsw0UMISzGDOuGoTl5f
         8dheTVhK3nziTYISrCOckKNfIYaCdFZCLA5I8fb9syYBBXwBv03FQP+bo5ap/JJz3Ev4
         vbL5ISByw8VP1wQt249vAw3iS64WdntII4SlUv8b8bE6BF77S1LJx9wGtnPIpPlw4vUR
         nPvg==
X-Forwarded-Encrypted: i=1; AJvYcCWz2YxioEEBgsGBwWeVqXKYhPTl6+yPSqpYxJT6S4S06YYEx7rJKfa+OhZ9MzqDb6Rle//4TY4hgkz6PZP8bZUYqdn9VUIEkPBLhA==
X-Gm-Message-State: AOJu0Yx2xlQAP5xwtxFTJNHJIgUFmy4gxtaz5DOmItjQjpYsWUQDoVAQ
	n/XNrP/XheFqrcTkmxX9p5aTCo1FiazZQOlRFUhtyNjjRrQG3f3k
X-Google-Smtp-Source: AGHT+IEOclJy/CKjgZg3kBSaqvyZWV4BNEYGoWmUbWBMk90pFzsmw4VkSdit7UdC6gAJ/ZWAiox1gg==
X-Received: by 2002:a05:6000:1843:b0:33d:c657:6ae3 with SMTP id c3-20020a056000184300b0033dc6576ae3mr125312wri.7.1711050879879;
        Thu, 21 Mar 2024 12:54:39 -0700 (PDT)
Received: from gmail.com (1F2EF04C.nat.pool.telekom.hu. [31.46.240.76])
        by smtp.gmail.com with ESMTPSA id r29-20020adfa15d000000b0033e79eca6dfsm355492wrr.50.2024.03.21.12.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 12:54:39 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Thu, 21 Mar 2024 20:54:37 +0100
From: Ingo Molnar <mingo@kernel.org>
To: "Xin Li (Intel)" <xin@zytor.com>
Cc: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
	linux-arch@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, jgross@suse.com, boris.ostrovsky@oracle.com,
	arnd@arndb.de, Brian Gerst <brgerst@gmail.com>
Subject: Re: [PATCH v2 1/1] x86: Rename __{start,end}_init_task to
 __{start,end}_init_stack
Message-ID: <ZfyQfQrluph6GxLS@gmail.com>
References: <20240318071429.910454-1-xin@zytor.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240318071429.910454-1-xin@zytor.com>


* Xin Li (Intel) <xin@zytor.com> wrote:

> The stack of a task has been separated from the memory of a task_struct
> struture for a long time on x86, as a result __{start,end}_init_task no
> longer mark the start and end of the init_task structure, but its stack
> only.
> 
> Rename __{start,end}_init_task to __{start,end}_init_stack.
> 
> Note other architectures are not affected because __{start,end}_init_task
> are used on x86 only.
> 
> Signed-off-by: Xin Li (Intel) <xin@zytor.com>
> ---
> 
> Change since v1:
> * Revert an accident insane change, init_task to init_stack (Jürgen Groß).
> ---
>  arch/x86/include/asm/processor.h  | 4 ++--
>  arch/x86/kernel/head_64.S         | 2 +-
>  arch/x86/xen/xen-head.S           | 2 +-
>  include/asm-generic/vmlinux.lds.h | 6 +++---
>  4 files changed, 7 insertions(+), 7 deletions(-)

Note that this is now in conflict with this cleanup by Brian Gerst:

   2cb16181a1d1 x86/boot: Simplify boot stack setup

... which removed __end_init_task[] entirely.

Thanks,

	Ingo

